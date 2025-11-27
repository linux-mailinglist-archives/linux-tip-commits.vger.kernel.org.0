Return-Path: <linux-tip-commits+bounces-7554-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BE41C8EB4E
	for <lists+linux-tip-commits@lfdr.de>; Thu, 27 Nov 2025 15:10:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id AD0B84E230F
	for <lists+linux-tip-commits@lfdr.de>; Thu, 27 Nov 2025 14:09:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EABBA33290A;
	Thu, 27 Nov 2025 14:09:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="CA35JTdU"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2976175A5;
	Thu, 27 Nov 2025 14:09:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764252593; cv=none; b=AHyyYWDuMsRpmyvaimMDGAe09nVOMWZMH9ZeWYLOF7XQ1bIf/lryuu5e8RDTNKOYd2VfW1wv24MqHO0WdRA0Qbo+ut6VG5l3lrTVm43Upc6bf23l1O8zaU6W7/UxZdhr4IG/3hyQZeildroZG1B1kIFq781cQAAhWdb3etnrzWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764252593; c=relaxed/simple;
	bh=spFiWCMcfw8g+JExYRUixp20wUu+rlNRKd+hlw47+r0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FmafDw5pRaMkR0Kj5XIdkKRn4TmgFRjvupr7qa1aiI6CL9bVFISyOM9D9t3OvIZYq0MMX/ly2I8mPMNKTs5Wik2G+Kq7mMJ1N1xHAVayuXDHiaD3Q4tkZo7GSyb/XkRSRFNieUYOjlfuwJLq3NVW0gcHm1KZa97yJuzEC9a/G2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=CA35JTdU; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=+l5YS/ZDWyQLkDp+VJkGaSKyZVCR9j6f+aLO/x/D5m4=; b=CA35JTdU1jNe2sLdFrN8Nm9Pxf
	3AcXrQZl1Pls1raXVTXPm2RMNCkJ7ZEIJlkJksGKwaMNNauYpWmaHydCKN+2mUqwvsCGyVej8omNq
	I8YfoREf5cmnVk9oAsBRe1cczU9pb3RvPV2kK5vBMFQUEZlfMy+Bf0Q6lzbYWmlWEPG9bumGqf7dP
	HsavdcYUJ5afdoZvKp4CvtiSIj76NZGaR3+Knj+e/y5Rtc5l9AS4il10MfZoQOSX+OaN3/T6dRJWf
	jbmQ/m7I4z1j0LDh2wgkDEVLFwTVi/GJN7SGcBZliMZu9rBz4O2hsIXt6Q55ztQmIUEMsYGwK1XzF
	8z8K8nHg==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vOcgp-0000000BpEg-14kW;
	Thu, 27 Nov 2025 14:09:43 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 296DF300342; Thu, 27 Nov 2025 15:09:42 +0100 (CET)
Date: Thu, 27 Nov 2025 15:09:42 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: K Prateek Nayak <kprateek.nayak@amd.com>
Cc: Tim Chen <tim.c.chen@linux.intel.com>,
	Shrikanth Hegde <sshegde@linux.ibm.com>,
	linux-kernel@vger.kernel.org, linux-tip-commits@vger.kernel.org,
	Chen Yu <yu.c.chen@intel.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Srikar Dronamraju <srikar@linux.ibm.com>,
	Mohini Narkhede <mohini.narkhede@intel.com>, x86@kernel.org
Subject: Re: [tip: sched/core] sched/fair: Skip sched_balance_running cmpxchg
 when balance is not due
Message-ID: <20251127140942.GW4067720@noisy.programming.kicks-ass.net>
References: <6fed119b723c71552943bfe5798c93851b30a361.1762800251.git.tim.c.chen@linux.intel.com>
 <176312274812.498.6548506845675120622.tip-bot2@tip-bot2>
 <dffe53a4-0ef2-4346-ad73-c4b71a734b3a@linux.ibm.com>
 <ceffc6f7870711d40f195191d298ca9bf1def022.camel@linux.intel.com>
 <7099a373-8d6c-4c67-806c-84b50315f160@amd.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7099a373-8d6c-4c67-806c-84b50315f160@amd.com>

On Tue, Nov 18, 2025 at 12:30:36AM +0530, K Prateek Nayak wrote:
> On 11/18/2025 12:25 AM, Tim Chen wrote:
> >> I wondered what is really different since the tim's v4 boots fine.
> >> There is try instead in the tip, i think that is messing it since likely
> >> we are dereferencing 0?
> >>
> >>
> >> With this diff it boots fine.
> >>
> >> ---
> >> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> >> index aaa47ece6a8e..01814b10b833 100644
> >> --- a/kernel/sched/fair.c
> >> +++ b/kernel/sched/fair.c
> >> @@ -11841,7 +11841,7 @@ static int sched_balance_rq(int this_cpu, struct rq *this_rq,
> >>          }
> >>   
> >>          if (!need_unlock && (sd->flags & SD_SERIALIZE)) {
> >> -               if (!atomic_try_cmpxchg_acquire(&sched_balance_running, 0, 1))
> > 
> > The second argument of atomic_try_cmpxchg_acquire is "int *old" while that of atomic_cmpxchg_acquire
> > is "int old". So the above check would result in NULL pointer access.  Probably have
> > to do something like the following to use atomic_try_cmpxchg_acquire()
> > 
> > 		int zero = 0;
> > 		if (!atomic_try_cmpxchg_acquire(&sched_balance_running, &zero, 1))
> 
> Peter seems to have refreshed tip:sched/core with above but is
> there any advantage of using atomic_try_cmpxchg_acquire() as
> opposed to plain old atomic_cmpxchg_acquire() and then checking
> the old value it returns?
> 
> That zero variable serves no other purpose and is a bit of an
> eyesore IMO.

Yeah, its not ideal. It should generate slightly saner code, since the
compiler can now use the condition codes set by cmpxchg instead of
having to do an extra compare.

