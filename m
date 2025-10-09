Return-Path: <linux-tip-commits+bounces-6781-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 122EEBC8DE9
	for <lists+linux-tip-commits@lfdr.de>; Thu, 09 Oct 2025 13:43:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id CEB464F3167
	for <lists+linux-tip-commits@lfdr.de>; Thu,  9 Oct 2025 11:43:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F4102DCBE3;
	Thu,  9 Oct 2025 11:43:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="HRpXbQf+"
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE29D246BA8
	for <linux-tip-commits@vger.kernel.org>; Thu,  9 Oct 2025 11:43:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760010191; cv=none; b=WFcT/Xdr0Z1PTKI3F9cFp0Eks+mXYC8nudzM5sOqEP6TKH4U+9TvzltYsNS990gsa5R2LtoV0eA36JWpHGAxcZYQuQZzfcx08mlNUo8eF+w/cHHu7dMGnLMtImDcDmrIeo0ApJVB4+v7M3AQb3Or1RN1332HmXyFU18aS8G4xxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760010191; c=relaxed/simple;
	bh=o4ZC23bqkCzZRdyrb2q27Ia8Nl5pmYCkRwvOS6X6Po4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:In-Reply-To:
	 Content-Type:References; b=oG63HzH0VuUik5PTUtfPr9/j30rvCvAe6dbdHnInOUjKeOg1kFhw3W5Tkvwb49n89rteVKIeORWimagau7a64NzbjdpxuR7xdJS5HNPQ5wl3LBNdoLJGkRaA6WcpwD81wuQOaQp2iiVO6kWjJ/ZVIXv2+IqJMDChNCT1HAlwx9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=HRpXbQf+; arc=none smtp.client-ip=210.118.77.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20251009114300euoutp0246dc705d500338f95c6d1953a41c2347~sz_9DfymJ0699506995euoutp02a
	for <linux-tip-commits@vger.kernel.org>; Thu,  9 Oct 2025 11:43:00 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20251009114300euoutp0246dc705d500338f95c6d1953a41c2347~sz_9DfymJ0699506995euoutp02a
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1760010180;
	bh=RlesILzdKyeLs7LcSyCstuiyY+nX+baBO2Ld+IQgDBU=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=HRpXbQf+tpEz/XtDm0oqmXMR9YPCzRNdc/DanyHcAVQsCmabiTkx5sHmt6GUOua8K
	 jn6u9W7ZJEdimwmB2pXXkjUbluaMfQnAyhNSflU1dFL9Gs4eh+cjXik9dmWdZWYevf
	 ayNWy57XGqHFMagvb8UWh4pfdCFACYto36diP1bM=
Received: from eusmtip2.samsung.com (unknown [203.254.199.222]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20251009114300eucas1p1f43957675255cd9687831cff3f177299~sz_80yY0V0410304103eucas1p1Y;
	Thu,  9 Oct 2025 11:43:00 +0000 (GMT)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
	eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20251009114259eusmtip2099e83047b751e3eca3b23cab4329aff~sz_7xbw511293112931eusmtip2n;
	Thu,  9 Oct 2025 11:42:59 +0000 (GMT)
Message-ID: <0e1e61f6-6561-412b-9d45-1a000b3adc21@samsung.com>
Date: Thu, 9 Oct 2025 13:42:58 +0200
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [tip: sched/urgent] sched/deadline: Fix dl_server getting stuck
To: Peter Zijlstra <peterz@infradead.org>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, linux-kernel@vger.kernel.org,
	linux-tip-commits@vger.kernel.org, John Stultz <jstultz@google.com>,
	x86@kernel.org, 'Linux Samsung SOC' <linux-samsung-soc@vger.kernel.org>,
	Mark Rutland <mark.rutland@arm.com>, Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
From: Marek Szyprowski <m.szyprowski@samsung.com>
In-Reply-To: <20251009092648.GW3419281@noisy.programming.kicks-ass.net>
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20251009114300eucas1p1f43957675255cd9687831cff3f177299
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20250922215704eucas1p1f53a65a5cd1eafd3e0db006653231efd
X-EPHeader: CA
X-CMS-RootMailID: 20250922215704eucas1p1f53a65a5cd1eafd3e0db006653231efd
References: <20250916110155.GH3245006@noisy.programming.kicks-ass.net>
	<175817861820.709179.10538516755307778527.tip-bot2@tip-bot2>
	<CGME20250922215704eucas1p1f53a65a5cd1eafd3e0db006653231efd@eucas1p1.samsung.com>
	<e56310b5-f7a9-4fad-b79a-dcbcdd3d3883@samsung.com>
	<20250923220215.GH3419281@noisy.programming.kicks-ass.net>
	<eae77bd0-d874-4ddf-88d7-c1ab75358f91@samsung.com>
	<20251009092648.GW3419281@noisy.programming.kicks-ass.net>

On 09.10.2025 11:26, Peter Zijlstra wrote:
> On Mon, Sep 29, 2025 at 05:19:27PM +0200, Marek Szyprowski wrote:
>
>> Thanks for some hints, but unfortunately ARM64 doesn't support
>> earlyprintk, so I was not able to use this method.
> I've been told it is called earlycon= on arm; still sets up
> early_console and make early_printk() work.

ARM and ARM64 are almost completely separate architectures. 
CONFIG_EARLY_PRINTK is not available on ARM64.


> My patches just re-route everything printk() into early_printk().

>> However I've played a bit with this code and found that this strange
>> wake-up of the CPU7 seems to be caused by the timer. If I restore
>>
>>     if (!dl_se->server_has_tasks(dl_se))
>>             return HRTIMER_NORESTART;
>>
>> part in the dl_server_timer, the everything works again as before this
>> patch.
> Right, so something on your platform is not working right. Stray timers
> should not wake up CPUs.
>
>> This issue is however not Exynos5433 ARM 64bit specific. Similar lockup
>> happens on Exynos5422 ARM 32bit boards, although there is no message in
>> that case. Does it mean that handling of the hrtimers on Exynos boards
>> is a bit broken in the context of CPU hotplug?
> There is this thread:
>
>    https://lkml.kernel.org/r/20251009080007.GH3245006@noisy.programming.kicks-ass.net
>
> I suspect this might be the same issue and we've made a little progress
> there.

Indeed it looks like a similar issue and the proposed patch fixes the 
problem on my Exynos based boards! Thanks! I will post my comment and 
Tested-by tag there.

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland


