Return-Path: <linux-tip-commits+bounces-1817-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 901FE940BB3
	for <lists+linux-tip-commits@lfdr.de>; Tue, 30 Jul 2024 10:34:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C0FC81C22D03
	for <lists+linux-tip-commits@lfdr.de>; Tue, 30 Jul 2024 08:34:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EDE3194A56;
	Tue, 30 Jul 2024 08:28:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="OiEQeyQh"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 285531922E9;
	Tue, 30 Jul 2024 08:28:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722328101; cv=none; b=ahkzhcThHCG8M2ISOndQjAo3N8i8ATxIdLr2bRoNQgAaou8wU5lfM9bijLoFmXaTdZO7ygdv7smAcVxAfJuz9TmlIWb+Yek7ieLxrwgE3nnu0vA2LXIDqxMzzl89/z/lmFy84+BAPxXhQ8mcbso6ls04BG/VL26rHjYwL8DCAac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722328101; c=relaxed/simple;
	bh=4HzJuTP5aFQF0KMhr5FjOiAIlUo60YDaBpLnZ2+8RqY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cAs0d5vfg2ZGifeWAuQATY4W6iQA4rdKUvKPmsXnUplY2r1Bq6jlNWqVBaZffwZkl1YxpPMQ2fZS4t4OIgUjQQcF0+sbmZvw1XoE0gIcGXXK2a739RXLdpkEP+kdB4qoA64u+9heGHdSrhKR0/81efgiSWHz4IF2xV154vux+OI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=OiEQeyQh; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=lbYXlDHdZgKuGNHD6Ao+K+LGPDxTFA26PTvGzDVHnLc=; b=OiEQeyQh5EITXuJN4Y1i/kwrOH
	WE86E4kN599FlPAZfhVE7Z8nVn2+cs/m70D9h9O4PgILXQr3DvdjsC9giI7bTiMGln4mMsIkh5uc7
	oq2yjwK+bdCj8Ju3o/MecfH16Mf8tcKyHlU/sFSqp5pG+N5H7xLY4yGGQFZUydGYo0zcr6BMPDC6q
	zhXSQevm7lf8DhJ0Bqm932K+DLcjRzPSuDB4OZ4v9kOWdHSn+H9sYAJch14NwatDDLao9oW8IpWpc
	eGntPIYku+561+dlejra6qSpUOacCAG9KlY9pMz+HlgPXMeWxy5EaTkYIJmeiPa+sSLm7LVNMsZKR
	Plv4puTQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sYiDP-00000004wjS-45PM;
	Tue, 30 Jul 2024 08:28:16 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 19B143003EA; Tue, 30 Jul 2024 10:28:15 +0200 (CEST)
Date: Tue, 30 Jul 2024 10:28:15 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Mukesh Kumar Chaurasiya <mchauras@linux.ibm.com>
Cc: linux-tip-commits@vger.kernel.org, Zhang Qiao <zhangqiao22@huawei.com>,
	x86@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [tip: sched/core] sched: Initialize the vruntime of a new task
 when it is first enqueued
Message-ID: <20240730082815.GG33588@noisy.programming.kicks-ass.net>
References: <20240627133359.1370598-1-zhangqiao22@huawei.com>
 <172224924797.2215.1886433124274814892.tip-bot2@tip-bot2>
 <srdvb6k4evy2dpczpzovbfb4afehbrmroutlsmids33r357azi@znkbcphlfuab>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <srdvb6k4evy2dpczpzovbfb4afehbrmroutlsmids33r357azi@znkbcphlfuab>

On Tue, Jul 30, 2024 at 01:45:41PM +0530, Mukesh Kumar Chaurasiya wrote:
> 
> On Mon, Jul 29, 2024 at 10:34:07AM GMT, tip-bot2 for Zhang Qiao wrote:
> > The following commit has been merged into the sched/core branch of tip:
> > 
> > Commit-ID:     c40dd90ac045fa1fdf6acc5bf9109a2315e6c92c
> > Gitweb:        https://git.kernel.org/tip/c40dd90ac045fa1fdf6acc5bf9109a2315e6c92c
> > Author:        Zhang Qiao <zhangqiao22@huawei.com>
> > AuthorDate:    Thu, 27 Jun 2024 21:33:59 +08:00
> > Committer:     Peter Zijlstra <peterz@infradead.org>
> > CommitterDate: Mon, 29 Jul 2024 12:22:34 +02:00
> > 
> > 
> > Signed-off-by: Zhang Qiao <zhangqiao22@huawei.com>
> > Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> > Link: https://lkml.kernel.org/r/20240627133359.1370598-1-zhangqiao22@huawei.com
> > ---
> Hi Peter,
> 
> I just noticed that my tags were not picked, just wanted to check if it's some
> config issue on my end or something on the tipbot side.

Could be I applied the patch before your email arrived. No harm
intended, and I do appreciate the review effort.



