Return-Path: <linux-tip-commits+bounces-7647-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B0BE4CBA8A8
	for <lists+linux-tip-commits@lfdr.de>; Sat, 13 Dec 2025 13:06:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 64A01301B5A1
	for <lists+linux-tip-commits@lfdr.de>; Sat, 13 Dec 2025 12:06:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E552229B1F;
	Sat, 13 Dec 2025 12:06:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="GITbV6o0"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FFCE13D891;
	Sat, 13 Dec 2025 12:06:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765627574; cv=none; b=eZZrlKkwRFUsNiekWORFMUwNmKD6PxIIYXVR+llN3AkRlYYqtkJB+haqoi0BgBIJY9JhyiUvA1a8rO4tQgDi5vfh8yumzWtl4QIzdz0gKuJojGl3HFuwjlIZQclPqg2NlOluRRQz2x/XfVzMGjdQh2fRG//n3d0N1aBgM2vK8ow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765627574; c=relaxed/simple;
	bh=kgC9Gon+0HMfmNfkT00nqucRnjo3uwJUsAhPK5wSSwA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IaUPmuKPNfYGzusKg4eEaczphkgOZr+5Wu/qZyK/kPJvAo47PJQVeKlCVnfVNMdP4MhPjLdKvaYpQM4NFJ7PnaEW3UPDoGR/v8aT0GouYWdmLbLx54EBgaTKCt9rngwPhRMkO6oLgc3sR8+DOS0HRUgH/uq9yBBezPtvU5QHBYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=GITbV6o0; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=ZRY4UyVu9ilRpqIu913UiP3g8mDdcYAFAIpE1IGwGy4=; b=GITbV6o08mjtpka6Vc+rf1f9gf
	XuNDG/W5jsABJrtUm37CN6CF5rZebaIfhIlT+KneZHHdN7NMLOHrdF9JUlwHZl7NRplYigj1sLEYn
	U6XMZ8yfD2E4q76IF+rusO+RW6DVN/kMZMfj05N1j6OCQUSJ7/tGcwkvhG3P79leZvbe09fWEDAzx
	4ioWgNQK1hj/8k0S5Tkxz2/U3VoO+APLMaafJbvLzE3dQALWHVpzAW6LzFjKLZjrpdJiwEKewfiUc
	m4UEJv8WSPST2trJnC/gXbP9qMzPjbQ8Mh0AYztcZdHPEB5mchZ/q4E1EhQFSPmQZLr2Y7c8te760
	IVzsCXGw==;
Received: from 2001-1c00-8d85-5700-266e-96ff-fe07-7dcc.cable.dynamic.v6.ziggo.nl ([2001:1c00:8d85:5700:266e:96ff:fe07:7dcc] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vUNWR-00000000Gbx-0YJo;
	Sat, 13 Dec 2025 11:10:47 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id AD21630057E; Sat, 13 Dec 2025 13:06:01 +0100 (CET)
Date: Sat, 13 Dec 2025 13:06:01 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: linux-kernel@vger.kernel.org
Cc: linux-tip-commits@vger.kernel.org, kitta <kitta@linux.alibaba.com>,
	Evan Li <evan.li@linux.alibaba.com>, Ingo Molnar <mingo@kernel.org>,
	x86@kernel.org
Subject: Re: [tip: perf/urgent] perf/x86/intel: Fix NULL event dereference
 crash in handle_pmi_common()
Message-ID: <20251213120601.GQ3911114@noisy.programming.kicks-ass.net>
References: <20251212084943.2124787-1-evan.li@linux.alibaba.com>
 <176553028144.498.11236460229358296060.tip-bot2@tip-bot2>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <176553028144.498.11236460229358296060.tip-bot2@tip-bot2>

On Fri, Dec 12, 2025 at 09:04:41AM -0000, tip-bot2 for Evan Li wrote:
> The following commit has been merged into the perf/urgent branch of tip:
> 
> Commit-ID:     9415f749d34b926b9e4853da1462f4d941f89a0d
> Gitweb:        https://git.kernel.org/tip/9415f749d34b926b9e4853da1462f4d941f89a0d
> Author:        Evan Li <evan.li@linux.alibaba.com>
> AuthorDate:    Fri, 12 Dec 2025 16:49:43 +08:00
> Committer:     Ingo Molnar <mingo@kernel.org>
> CommitterDate: Fri, 12 Dec 2025 09:57:39 +01:00
> 
> perf/x86/intel: Fix NULL event dereference crash in handle_pmi_common()
> 
> handle_pmi_common() may observe an active bit set in cpuc->active_mask
> while the corresponding cpuc->events[] entry has already been cleared,
> which leads to a NULL pointer dereference.
> 
> This can happen when interrupt throttling stops all events in a group
> while PEBS processing is still in progress. perf_event_overflow() can
> trigger perf_event_throttle_group(), which stops the group and clears
> the cpuc->events[] entry, but the active bit may still be set when
> handle_pmi_common() iterates over the events.
> 
> The following recent fix:
> 
>   7e772a93eb61 ("perf/x86: Fix NULL event access and potential PEBS record loss")
> 
> moved the cpuc->events[] clearing from x86_pmu_stop() to x86_pmu_del() and
> relied on cpuc->active_mask/pebs_enabled checks. However,
> handle_pmi_common() can still encounter a NULL cpuc->events[] entry
> despite the active bit being set.
> 
> Add an explicit NULL check on the event pointer before using it,
> to cover this legitimate scenario and avoid the NULL dereference crash.
> 
> Fixes: 7e772a93eb61 ("perf/x86: Fix NULL event access and potential PEBS record loss")
> Reported-by: kitta <kitta@linux.alibaba.com>
> Co-developed-by: kitta <kitta@linux.alibaba.com>
> Signed-off-by: Evan Li <evan.li@linux.alibaba.com>
> Signed-off-by: Ingo Molnar <mingo@kernel.org>
> Link: https://patch.msgid.link/20251212084943.2124787-1-evan.li@linux.alibaba.com
> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=220855
> ---
>  arch/x86/events/intel/core.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
> index 853fe07..bdf3f0d 100644
> --- a/arch/x86/events/intel/core.c
> +++ b/arch/x86/events/intel/core.c
> @@ -3378,6 +3378,9 @@ static int handle_pmi_common(struct pt_regs *regs, u64 status)
>  
>  		if (!test_bit(bit, cpuc->active_mask))
>  			continue;
> +		/* Event may have already been cleared: */
> +		if (!event)
> +			continue;

I still hate this commit -- it doesn't actually explain anything, at
best it papers over an issue elsewhere :-(

