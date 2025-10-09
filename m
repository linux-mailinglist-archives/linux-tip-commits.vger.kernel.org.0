Return-Path: <linux-tip-commits+bounces-6780-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 2261EBC84B0
	for <lists+linux-tip-commits@lfdr.de>; Thu, 09 Oct 2025 11:27:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C46254E44E3
	for <lists+linux-tip-commits@lfdr.de>; Thu,  9 Oct 2025 09:27:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C9232D3728;
	Thu,  9 Oct 2025 09:26:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ow6/USIH"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D08D1241CB7;
	Thu,  9 Oct 2025 09:26:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760002016; cv=none; b=dmuNRRIDs66CqRldvulcaGS9csSDScUCpET6lgqK8As65IHwoGH2JNYYsrslqpt2e6rV3x//zojLBUqNhOd2mXhT+2KuqapsSmpJp+sOQiU25ldDSDC7Ae2gDHUt9SiMaPf8HtzPeWxFYncM/uAA7sBjrNnQTzWtL6Clz4lMX0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760002016; c=relaxed/simple;
	bh=8WTQLafKA8kssI32iNLHS5hMP/bxEATA5wXnGRhRfS4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Pg5E0hKASas6ii6whHTP/h4O5HK/U2ECMVPHrlWIOcmrapUTF0u453aclZ9IOcuCAyeGsGYf0iJdtocyxW07h5+s8I0tn5F0nkNPN6JQZCaU/4veOr4CbM20VXsMhOWwLIvcLqhuwqZpprV+MFIa39x7/NpccerhR+JT50Z6CTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=ow6/USIH; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=V60S/pormhoYRYxsu+Egzzzz8CK1VuNM11O4msG+Yr8=; b=ow6/USIHg4VDT4eTYw7fb5iEmJ
	Ij+M3/EWF4tXFqlINgajlm1bN/m0IHjoNdAoTrmnfaoj7EdFWampbLbYHGl1PAGh1m8OtwUDIPSam
	ZSgeL185eDu+E0npTPFLBHnvVBr1uVdz5jkHd4/VQNaU0+UQo7zJbOobneVWnBvechbGXR4D8qJmB
	mz3NTm8SlX6MztJIgJRaI8gjaJBE0KzZeDEQZUjQZl18mwpS+LDJR92cc3k6P1ZcRpX8yVI8+jSdY
	8+Kphlym7jq3Y2aixJ3xb/I2YIYHIaj5NEOFVADIQ6ZyRoXiIkGFmOrEV2amxG94kxz2RA7Kh8mIg
	M8fYriwQ==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v6mvA-00000004lLM-1Yeo;
	Thu, 09 Oct 2025 09:26:49 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 11BDC300399; Thu, 09 Oct 2025 11:26:48 +0200 (CEST)
Date: Thu, 9 Oct 2025 11:26:48 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, linux-kernel@vger.kernel.org,
	linux-tip-commits@vger.kernel.org, John Stultz <jstultz@google.com>,
	x86@kernel.org,
	'Linux Samsung SOC' <linux-samsung-soc@vger.kernel.org>,
	Mark Rutland <mark.rutland@arm.com>
Subject: Re: [tip: sched/urgent] sched/deadline: Fix dl_server getting stuck
Message-ID: <20251009092648.GW3419281@noisy.programming.kicks-ass.net>
References: <20250916110155.GH3245006@noisy.programming.kicks-ass.net>
 <175817861820.709179.10538516755307778527.tip-bot2@tip-bot2>
 <CGME20250922215704eucas1p1f53a65a5cd1eafd3e0db006653231efd@eucas1p1.samsung.com>
 <e56310b5-f7a9-4fad-b79a-dcbcdd3d3883@samsung.com>
 <20250923220215.GH3419281@noisy.programming.kicks-ass.net>
 <eae77bd0-d874-4ddf-88d7-c1ab75358f91@samsung.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <eae77bd0-d874-4ddf-88d7-c1ab75358f91@samsung.com>

On Mon, Sep 29, 2025 at 05:19:27PM +0200, Marek Szyprowski wrote:

> Thanks for some hints, but unfortunately ARM64 doesn't support 
> earlyprintk, so I was not able to use this method.

I've been told it is called earlycon= on arm; still sets up
early_console and make early_printk() work.

My patches just re-route everything printk() into early_printk().

> However I've played a bit with this code and found that this strange 
> wake-up of the CPU7 seems to be caused by the timer. If I restore
> 
>    if (!dl_se->server_has_tasks(dl_se))
>            return HRTIMER_NORESTART;
> 
> part in the dl_server_timer, the everything works again as before this 
> patch.

Right, so something on your platform is not working right. Stray timers
should not wake up CPUs.

> This issue is however not Exynos5433 ARM 64bit specific. Similar lockup 
> happens on Exynos5422 ARM 32bit boards, although there is no message in 
> that case. Does it mean that handling of the hrtimers on Exynos boards 
> is a bit broken in the context of CPU hotplug? 

There is this thread:

  https://lkml.kernel.org/r/20251009080007.GH3245006@noisy.programming.kicks-ass.net

I suspect this might be the same issue and we've made a little progress
there.

