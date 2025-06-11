Return-Path: <linux-tip-commits+bounces-5772-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EBEADAD59E6
	for <lists+linux-tip-commits@lfdr.de>; Wed, 11 Jun 2025 17:12:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A3F6A7AD1F7
	for <lists+linux-tip-commits@lfdr.de>; Wed, 11 Jun 2025 15:10:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 708711CBEAA;
	Wed, 11 Jun 2025 15:11:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="M/0Jqpgq"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF5F91DC1AB;
	Wed, 11 Jun 2025 15:11:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749654679; cv=none; b=Svd++R+LDGDloIyOCxDdCaAlXkUGhNr1SRuV6zruGxWB8FfMLVCLfLeVrcRIEMvus2QN7gkIKE6hpKSUpwEwxawDpEzXqy9Xiol/z6w/F9JhYMsFbKT5EKOVcwY1Ftzhwu10m7hdIiQIG/efiH2LJv4RF1+Yun34MrhtGwPpZrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749654679; c=relaxed/simple;
	bh=Tz6HIGNxRaZNdDY+aXV8gtj9xCm9Ihk2l5HtGeFEbDs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oX0JHQGti6Ev9tsTxgizRgswz3Ielu1Kyn1LvVIyTQUtYD1dJGX+0CC3WtcB5CL9v3M2qr/etSMkKGhVH4kD71uyOrxsfq0BZulhjxZGA9xdn3AbbEBCOXdjN40Nbl4evlIig+w31GvcegkfiuDvdaQ/oNO/9SEOAFjsDPyXXLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=M/0Jqpgq; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=xogBe9OOJunfPNDVrb0ne+5gqa6BZn20KN9zD4DQ7I8=; b=M/0JqpgqvBWk16ejMCAOT1WWYP
	Qrh39r/RdEvnP+1guKsTIZwqfkesyBOXj5UR3H6NhnA8uRQNSAkOXhV+m/+BooDRnhFywTFwAWdTD
	/Yut76KwlAYbGBkdC5IcwNJmuRl7KavJm0jZWsOW8tLl2FHKwCaOT7CKaXeOxlcpUZ4aZ8gRSajpD
	xprNUatfxeqp2VjP5GOtanqiKZmQZ0m4eyWsYGU5DCCY1dAKOMKF4EkEdg4LfoLd0wVczr09M4oa7
	Yr4/4PLd5ZG7EVX2AU3w8ByLrg6ock2EZ1+qLMgWQqzXcz30rz1wnP68Sh9KQed1tRiFZtFXDFK6W
	9MWPZ6rw==;
Received: from 2001-1c00-8d82-d000-266e-96ff-fe07-7dcc.cable.dynamic.v6.ziggo.nl ([2001:1c00:8d82:d000:266e:96ff:fe07:7dcc] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uPN6h-00000002Pxh-23mh;
	Wed, 11 Jun 2025 15:11:15 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 6ABA53061CA; Wed, 11 Jun 2025 17:11:13 +0200 (CEST)
Date: Wed, 11 Jun 2025 17:11:13 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: linux-kernel@vger.kernel.org, linux-tip-commits@vger.kernel.org,
	"Lai, Yi" <yi1.lai@linux.intel.com>, x86@kernel.org
Subject: Re: [tip: locking/urgent] futex: Allow to resize the private local
 hash
Message-ID: <20250611151113.GE2273038@noisy.programming.kicks-ass.net>
References: <20250602110027.wfqbHgzb@linutronix.de>
 <174965275618.406.11364856155202390038.tip-bot2@tip-bot2>
 <20250611144302.1MtYItK6@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250611144302.1MtYItK6@linutronix.de>

On Wed, Jun 11, 2025 at 04:43:02PM +0200, Sebastian Andrzej Siewior wrote:
> On 2025-06-11 14:39:16 [-0000], tip-bot2 for Sebastian Andrzej Siewior wrote:
> > The following commit has been merged into the locking/urgent branch of tip:
> > 
> > Commit-ID:     703b5f31aee5bda47868c09a3522a78823c1bb77
> > Gitweb:        https://git.kernel.org/tip/703b5f31aee5bda47868c09a3522a78823c1bb77
> > Author:        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> > AuthorDate:    Mon, 02 Jun 2025 13:00:27 +02:00
> > Committer:     Peter Zijlstra <peterz@infradead.org>
> > CommitterDate: Wed, 11 Jun 2025 16:26:44 +02:00
> > 
> > futex: Allow to resize the private local hash
> > 
> > Once the global hash is requested there is no way back to switch back to
> > the per-task private hash. This is checked at the begin of the function.
> > 
> > It is possible that two threads simultaneously request the global hash
> > and both pass the initial check and block later on the
> > mm::futex_hash_lock. In this case the first thread performs the switch
> > to the global hash. The second thread will also attempt to switch to the
> > global hash and while doing so, accessing the nonexisting slot 1 of the
> > struct futex_private_hash.
> > This has been reported by Yi Lai.
> > 
> > Verify under mm_struct::futex_phash that the global hash is not in use.
> 
> Could you please replace it with
> 	https://lore.kernel.org/all/20250610104400.1077266-5-bigeasy@linutronix.de/
> 
> It also looks like the subject from commit bd54df5ea7cad ("futex: Allow
> to resize the private local hash")

Now done so, unless I messed up again :/

