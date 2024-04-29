Return-Path: <linux-tip-commits+bounces-1208-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 48E7B8B5722
	for <lists+linux-tip-commits@lfdr.de>; Mon, 29 Apr 2024 13:51:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DA92A1F20F91
	for <lists+linux-tip-commits@lfdr.de>; Mon, 29 Apr 2024 11:51:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 181204E1BA;
	Mon, 29 Apr 2024 11:50:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Q1P9x5d9"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6925C4D9E6
	for <linux-tip-commits@vger.kernel.org>; Mon, 29 Apr 2024 11:50:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714391455; cv=none; b=c2b27HLqpF6OIuw6BywdyXn+6rzkfhngQmNG6ROkHqvo/gHffp0IX1/K5GqNM3XPKeL+MNstdHVzh9c195K3tMOSATs6CLx2yR3nxiKK7DuZ2KhzRgHu1SwDEvty12iVTH6gn0oXhiOSNB2kIiGBt2d5CXB8ji0O/fN3zT5o4jk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714391455; c=relaxed/simple;
	bh=OJnDAjggab+UfqW4LaR48h6HmXCWEzcPHrtXrz34eeQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l1rKBA9ICyh4ClEPyNBebLFdkbkTkEB0/LvefZYu5ac6hJJjFhNGAmzFLV/VEJp3/LBi4mhqV5v/Re/Qe2CP/NnmmmXoabW5xiaFKNcAfELIr1Sy0VO+N42eXJb6hGNJ0aOSRmpNVqUkLq8IbBZcrgM8U5Q19NpelkMqN36w42M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Q1P9x5d9; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1714391451;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=blrQloFPEgbcGmnp+2LvnLzjitNphgbk5Vm79qxPmyo=;
	b=Q1P9x5d9xkUh6owvYqtx8Lx1wMp+O3Lbg3hPltP3yvtX4dH9c3KqUuIO0gMciKs+8DafiD
	nskmt+i6mLBCRmc9QIqwV/L9YhfQxtNBb1sDBVVaT9Z20S4h2By3wgM5oRz5736mkmGnCi
	UyqVGd/0waWaoFP0JGY1piTW37fFacs=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-70-pELHOKnIOLaYqJ6MiNwEyw-1; Mon,
 29 Apr 2024 07:50:48 -0400
X-MC-Unique: pELHOKnIOLaYqJ6MiNwEyw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 7C1B61C03340;
	Mon, 29 Apr 2024 11:50:47 +0000 (UTC)
Received: from lorien.usersys.redhat.com (unknown [10.22.16.191])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id EEA8E1121306;
	Mon, 29 Apr 2024 11:50:46 +0000 (UTC)
Date: Mon, 29 Apr 2024 07:50:45 -0400
From: Phil Auld <pauld@redhat.com>
To: Ingo Molnar <mingo@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, linux-tip-commits@vger.kernel.org,
	Chris von Recklinghausen <crecklin@redhat.com>,
	Oleg Nesterov <oleg@redhat.com>, linux-kernel@vger.kernel.org,
	Frederic Weisbecker <frederic@kernel.org>, x86@kernel.org
Subject: Re: [tip: sched/urgent] sched/isolation: {revent boot crash when the
 boot CPU is nohz_full
Message-ID: <20240429115045.GA188749@lorien.usersys.redhat.com>
References: <20240411143905.GA19288@redhat.com>
 <171398910227.10875.3649946025664504959.tip-bot2@tip-bot2>
 <20240424204124.GA36310@lorien.usersys.redhat.com>
 <Zi4FZsjmq7FxaoSe@gmail.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zi4FZsjmq7FxaoSe@gmail.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3

On Sun, Apr 28, 2024 at 10:14:30AM +0200 Ingo Molnar wrote:
> 
> * Phil Auld <pauld@redhat.com> wrote:
> 
> > On Wed, Apr 24, 2024 at 08:05:02PM -0000 tip-bot2 for Oleg Nesterov wrote:
> > > The following commit has been merged into the sched/urgent branch of tip:
> > > 
> > > Commit-ID:     8e3101b38dfc20848a23525b1e6e80bd1641d44c
> > > Gitweb:        https://git.kernel.org/tip/8e3101b38dfc20848a23525b1e6e80bd1641d44c
> > > Author:        Oleg Nesterov <oleg@redhat.com>
> > > AuthorDate:    Thu, 11 Apr 2024 16:39:05 +02:00
> > > Committer:     Thomas Gleixner <tglx@linutronix.de>
> > > CommitterDate: Wed, 24 Apr 2024 21:53:34 +02:00
> > > 
> > > sched/isolation: {revent boot crash when the boot CPU is nohz_full
> > >
> > 
> > Thanks Thomas, Typo in the reworded description :)
> 
> Ok, so normally we wouldn't rebase just for a typo in a changelog, but 
> that's an annoying typo that will show up in shortlogs - so I fixed it all 
> up in tip:sched/urgent.
>

Yeah, I kept seeing "revert"...

Thanks,
Phil

> Thanks,
> 
> 	Ingo
> 

-- 


