Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B433C3EB088
	for <lists+linux-tip-commits@lfdr.de>; Fri, 13 Aug 2021 08:42:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238879AbhHMGnG (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 13 Aug 2021 02:43:06 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:21110 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238622AbhHMGnF (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 13 Aug 2021 02:43:05 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20210813064237euoutp016bc732efdc8f2a7ae1061de2c70c5fb6~aypU4Zbfs2294022940euoutp01L
        for <linux-tip-commits@vger.kernel.org>; Fri, 13 Aug 2021 06:42:37 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20210813064237euoutp016bc732efdc8f2a7ae1061de2c70c5fb6~aypU4Zbfs2294022940euoutp01L
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1628836957;
        bh=UH2P/XCNLvIFpcwBYuXJGbKjcIHHwJwGWtnaWNnyMhY=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=ma70eirc6n6Pg28YBi/KngfJmoJbPv8/5R2e9+6iOXqYeSvihxPYQQMGiXOsT6IQY
         D8ApwTtCXQHXjXLNCd1EJagatxP49yww1iCeAL/0iRLvLsZsCrtb+U8O9pUcZ1v7Wb
         zAj/hwtCwnj2kLZOW2Y6KdtGTAkyaAnL+KNHRV60=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20210813064236eucas1p2d09ff806303d3d32a44e10fc0a25bcc6~aypUae6z_2906929069eucas1p2M;
        Fri, 13 Aug 2021 06:42:36 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id B9.93.42068.C5416116; Fri, 13
        Aug 2021 07:42:36 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20210813064236eucas1p12488eb5bcdda32a1a0a8c80991eb1bcb~aypT_27OU2274522745eucas1p1I;
        Fri, 13 Aug 2021 06:42:36 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20210813064236eusmtrp10ee9278b2e611e5a41af7cda82aa4fd9~aypT_HlD62606326063eusmtrp1t;
        Fri, 13 Aug 2021 06:42:36 +0000 (GMT)
X-AuditID: cbfec7f4-c71ff7000002a454-b4-6116145c0f13
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 79.30.20981.C5416116; Fri, 13
        Aug 2021 07:42:36 +0100 (BST)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20210813064236eusmtip14cb8184043c39ca2dab9f8074a5004b5~aypTga14O0173101731eusmtip1G;
        Fri, 13 Aug 2021 06:42:35 +0000 (GMT)
Subject: Re: [PATCH] hrtimer: Use raw_cpu_ptr() in clock_was_set()
To:     Thomas Gleixner <tglx@linutronix.de>,
        Mike Galbraith <efault@gmx.de>, linux-kernel@vger.kernel.org,
        linux-tip-commits@vger.kernel.org
Cc:     Peter Zijlstra <peterz@infradead.org>, x86@kernel.org
From:   Marek Szyprowski <m.szyprowski@samsung.com>
Message-ID: <72282431-2d9e-048c-62c5-1fb62ebd8f5d@samsung.com>
Date:   Fri, 13 Aug 2021 08:42:35 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0)
        Gecko/20100101 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <875ywacsmb.ffs@tglx>
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprBKsWRmVeSWpSXmKPExsWy7djPc7oxImKJBk8um1iseXOLxeLyrjls
        FufPrGK3ON57gMli86apzBY/NjxmdWDz+PAxzmPzCi2PTas62TzenTvH7vF5k1wAaxSXTUpq
        TmZZapG+XQJXxt+N+5kKLvFWTNz8iq2BsYW7i5GTQ0LARGLH5rssXYxcHEICKxgl/uydygjh
        fGGUOLb1LROE85lRYuq0HmaYlpVn7kIlljNKdD+5zwzhfGSU2HXuPCtIlbCAk8Tn9f/ZQRIi
        At2MEqs6N7CBJJgFLCX6lmxjAbHZBAwlut52gcV5BewkZjZsAmrm4GARUJU4/cgOJCwqkCwx
        8ckkVogSQYmTM5+AtXIKKEn8fdnJAjFSXmL72znMELa4xK0n88GukxC4wiFx+8RrdoizXSTW
        brrHAmELS7w6vgUqLiNxenIPC0RDM6PEw3Nr2SGcHkaJy00zGCGqrCXunPvFBnIds4CmxPpd
        +hBhR4klpx4xg4QlBPgkbrwVhDiCT2LStulQYV6JjjYhiGo1iVnH18GtPXjhEvMERqVZSF6b
        heSdWUjemYWwdwEjyypG8dTS4tz01GKjvNRyveLE3OLSvHS95PzcTYzAxHP63/EvOxiXv/qo
        d4iRiYPxEKMEB7OSCG+xsFiiEG9KYmVValF+fFFpTmrxIUZpDhYlcd6kLWvihQTSE0tSs1NT
        C1KLYLJMHJxSDUwWiQXNS1/cYjGMCLtd9OS7j8uKjyfizvzVD93SoWvJcfN4v3feHCY26fWX
        A5UqrjkI794v1ScU8y2SbfmB9i9G821aHK09y37sZTo/PZyxc+GdzuefXXf7ZM8VlmkKPrz+
        R7+Re0HTO765uWKbHiyx4j+admDC1wO6lpJ176ZPTLjb18I4SVxSNcXG0k/BbE9fuXW0ovsi
        qa0sRz9NfjMj0DUoIKV03+vkE/du+7hrX5uSEX2w86Hime6f/yoTlU/Wy2Rkz1kud2hKkXc0
        x0ZfTff9+aaNHmoxrp/Wvd548I5DuHLoAZa7HyT7J8mb3whZkOU3dY3x950TnJ0XmP+ukt58
        pSHp/G3H8OMNK5RYijMSDbWYi4oTAWXlp+GrAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrFIsWRmVeSWpSXmKPExsVy+t/xu7oxImKJBu0XJS3WvLnFYnF51xw2
        i/NnVrFbHO89wGSxedNUZosfGx6zOrB5fPgY57F5hZbHplWdbB7vzp1j9/i8SS6ANUrPpii/
        tCRVISO/uMRWKdrQwkjP0NJCz8jEUs/Q2DzWyshUSd/OJiU1J7MstUjfLkEv4+/G/UwFl3gr
        Jm5+xdbA2MLdxcjJISFgIrHyzF2mLkYuDiGBpYwSM/7vZoVIyEicnNYAZQtL/LnWxQZR9J5R
        YuXJi8wgCWEBJ4nP6/+zgyREBLoZJc48ncYCkmAWsJToW7KNBaJjNZPE54df2EASbAKGEl1v
        u8BsXgE7iZkNm4BWcHCwCKhKnH5kBxIWFUiW+HB6KStEiaDEyZlPwGZyCihJ/H3ZCTXfTGLe
        5ofMELa8xPa3c6BscYlbT+YzTWAUmoWkfRaSlllIWmYhaVnAyLKKUSS1tDg3PbfYSK84Mbe4
        NC9dLzk/dxMjMNK2Hfu5ZQfjylcf9Q4xMnEwHmKU4GBWEuEtFhZLFOJNSaysSi3Kjy8qzUkt
        PsRoCvTORGYp0eR8YKznlcQbmhmYGpqYWRqYWpoZK4nzmhxZEy8kkJ5YkpqdmlqQWgTTx8TB
        KdXAxG603vKJ4/OPitLX1baszPjmFnc5zOVYvvsJsQV6uclhb4xnVqz8Z9Ltc/S2jJiMwiOT
        FWZX9Pf+TMxf/uhiQ/kdqyLBQu7nO/ewGdVufLJn/3G/x8HV2vvendv98My7tNypvalnrJ68
        mHigcsX7oukGjf+qpkzl3vH0pvCHqXeSfbs+nJ2s5/3chZ99qnLJ7uuqmmwXn1nvnX2iXe7g
        TwsHh7lP953ZKdjD905sqUaSY8Jb1mn3G/ZtDZK0WP1AzYTn4odDwuIumXsX/xf+q2bUq/J5
        V3EF+6Nsq7S8d9Kvtr/h/aW8pnHJxjQ3T6Yp3k/Xz9t8avemgx55pws6jWevLE49c7Ho56/f
        /qUFn5OUWIozEg21mIuKEwEGa8g+PQMAAA==
X-CMS-MailID: 20210813064236eucas1p12488eb5bcdda32a1a0a8c80991eb1bcb
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20210812203131eucas1p22c7a4049c7f78825e80d1624dbd78805
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20210812203131eucas1p22c7a4049c7f78825e80d1624dbd78805
References: <20210713135158.054424875@linutronix.de>
        <162861133759.395.7795246170325882103.tip-bot2@tip-bot2>
        <7dfb3b15af67400227e7fa9e1916c8add0374ba9.camel@gmx.de>
        <87a6lmiwi0.ffs@tglx>
        <CGME20210812203131eucas1p22c7a4049c7f78825e80d1624dbd78805@eucas1p2.samsung.com>
        <875ywacsmb.ffs@tglx>
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

On 12.08.2021 22:31, Thomas Gleixner wrote:
> clock_was_set() can be invoked from preemptible context. Use raw_cpu_ptr()
> to check whether high resolution mode is active or not. It does not matter
> whether the task migrates after acquiring the pointer.
>
> Fixes: e71a4153b7c2 ("hrtimer: Force clock_was_set() handling for the HIGHRES=n, NOHZ=y case")
> Reported-by: Mike Galbraith <efault@gmx.de>
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>

This fixes the following issue:

BUG: using smp_processor_id() in preemptible [00000000] code: hwclock/227

> ---
>   kernel/time/hrtimer.c |    5 +++--
>   1 file changed, 3 insertions(+), 2 deletions(-)
>
> --- a/kernel/time/hrtimer.c
> +++ b/kernel/time/hrtimer.c
> @@ -944,10 +944,11 @@ static bool update_needs_ipi(struct hrti
>    */
>   void clock_was_set(unsigned int bases)
>   {
> +	struct hrtimer_cpu_base *cpu_base = raw_cpu_ptr(&hrtimer_bases);
>   	cpumask_var_t mask;
>   	int cpu;
>   
> -	if (!hrtimer_hres_active() && !tick_nohz_active)
> +	if (!__hrtimer_hres_active(cpu_base) && !tick_nohz_active)
>   		goto out_timerfd;
>   
>   	if (!zalloc_cpumask_var(&mask, GFP_KERNEL)) {
> @@ -958,9 +959,9 @@ void clock_was_set(unsigned int bases)
>   	/* Avoid interrupting CPUs if possible */
>   	cpus_read_lock();
>   	for_each_online_cpu(cpu) {
> -		struct hrtimer_cpu_base *cpu_base = &per_cpu(hrtimer_bases, cpu);
>   		unsigned long flags;
>   
> +		cpu_base = &per_cpu(hrtimer_bases, cpu);
>   		raw_spin_lock_irqsave(&cpu_base->lock, flags);
>   
>   		if (update_needs_ipi(cpu_base, bases))
>
Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

