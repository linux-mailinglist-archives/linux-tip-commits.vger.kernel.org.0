Return-Path: <linux-tip-commits+bounces-6779-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 39B95BC80FD
	for <lists+linux-tip-commits@lfdr.de>; Thu, 09 Oct 2025 10:35:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C98D53BB5A3
	for <lists+linux-tip-commits@lfdr.de>; Thu,  9 Oct 2025 08:35:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8485F285052;
	Thu,  9 Oct 2025 08:35:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XK3IL3G2"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 569944A01;
	Thu,  9 Oct 2025 08:35:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759998934; cv=none; b=V550O8PKzlyUdm3ev1dyBDCO9Ab0VVI/tnx72gIzEsmkqCmbveZN9TtMi8l/RZCrLw5nQJ5Nlj3zxJBmtwUrpI1YUzzkU25IT80rUxyvvQQiIpWWkd+Rr6LSKV1saDroPLtNUt9w6ymVTCXjb6+6PeeWx+IQpa/jCmVWfqJsAUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759998934; c=relaxed/simple;
	bh=iJ2gAtfZfSkAmmta5myZcy2q+0UiwW4oR9qXus1t1Qo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=K1kdL5D6ZHr4wnZ0w6c/kcJJiQLMFRWTgSPTsyyVmWRa9xhXaF3+vqo2026Zt7rAbWHR4HFZy9c2hmn124fDR5GBGMDsPkN40asJNnH7UP15ioS3YmvXSF2RM4iA/ccmVE71HxjenV0fPWpLcyqJl+nHKnpXB9/qOVoRLhFQl5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XK3IL3G2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5825C4CEE7;
	Thu,  9 Oct 2025 08:35:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759998933;
	bh=iJ2gAtfZfSkAmmta5myZcy2q+0UiwW4oR9qXus1t1Qo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=XK3IL3G2i/C5MvcOk/aViHDqOWlGhoELkqpohpehP7KriLonf025Kj9t0cCD4uFLp
	 sU+F8tGqejn/0au5vEihmh/BPHCH3h/Ej0RPLTeW7vPFkbOPKANTczGtwLBCy5vTap
	 fHlN82F5MEpgoQ40l+kSuSuRpKOQOMVO15HKHFlarv4tJRPROIFNoNILNaQt0D9xf0
	 8VjCydbivuUjZlrfFacJ/CP6bo4PDichsELzZhKomRqwHpK9tfSMp0cgkzx9/swV4B
	 7jx/Tqy1OhEuZjWLctvTqOXX7+trBRWyGJp1MYhLvwCyvWKAeKGxt5B9qKBbfrhwfa
	 MXj4WOc5+2tOg==
Message-ID: <66b75fc5-1d3c-4d43-b1c7-9be689e131e6@kernel.org>
Date: Thu, 9 Oct 2025 17:35:28 +0900
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [tip: sched/urgent] sched/deadline: Fix dl_server getting stuck
To: Marek Szyprowski <m.szyprowski@samsung.com>,
 Peter Zijlstra <peterz@infradead.org>
Cc: linux-kernel@vger.kernel.org, linux-tip-commits@vger.kernel.org,
 John Stultz <jstultz@google.com>, x86@kernel.org,
 'Linux Samsung SOC' <linux-samsung-soc@vger.kernel.org>,
 Mark Rutland <mark.rutland@arm.com>
References: <20250916110155.GH3245006@noisy.programming.kicks-ass.net>
 <175817861820.709179.10538516755307778527.tip-bot2@tip-bot2>
 <CGME20250922215704eucas1p1f53a65a5cd1eafd3e0db006653231efd@eucas1p1.samsung.com>
 <e56310b5-f7a9-4fad-b79a-dcbcdd3d3883@samsung.com>
 <20250923220215.GH3419281@noisy.programming.kicks-ass.net>
 <eae77bd0-d874-4ddf-88d7-c1ab75358f91@samsung.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 a/A=
In-Reply-To: <eae77bd0-d874-4ddf-88d7-c1ab75358f91@samsung.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 30/09/2025 00:19, Marek Szyprowski wrote:
> On 24.09.2025 00:02, Peter Zijlstra wrote:
>> On Mon, Sep 22, 2025 at 11:57:02PM +0200, Marek Szyprowski wrote:
>>> On 18.09.2025 08:56, tip-bot2 for Peter Zijlstra wrote:
>>>> The following commit has been merged into the sched/urgent branch of tip:
>>>>
>>>> Commit-ID:     077e1e2e0015e5ba6538d1c5299fb299a3a92d60
>>>> Gitweb:https://git.kernel.org/tip/077e1e2e0015e5ba6538d1c5299fb299a3a92d60
>>>> Author:        Peter Zijlstra<peterz@infradead.org>
>>>> AuthorDate:    Tue, 16 Sep 2025 23:02:41 +02:00
>>>> Committer:     Peter Zijlstra<peterz@infradead.org>
>>>> CommitterDate: Thu, 18 Sep 2025 08:50:05 +02:00
>>>>
>>>> sched/deadline: Fix dl_server getting stuck
>>>>
>>>> John found it was easy to hit lockup warnings when running locktorture
>>>> on a 2 CPU VM, which he bisected down to: commit cccb45d7c429
>>>> ("sched/deadline: Less agressive dl_server handling").
>>>>
>>>> While debugging it seems there is a chance where we end up with the
>>>> dl_server dequeued, with dl_se->dl_server_active. This causes
>>>> dl_server_start() to return without enqueueing the dl_server, thus it
>>>> fails to run when RT tasks starve the cpu.
>>>>
>>>> When this happens, dl_server_timer() catches the
>>>> '!dl_se->server_has_tasks(dl_se)' case, which then calls
>>>> replenish_dl_entity() and dl_server_stopped() and finally return
>>>> HRTIMER_NO_RESTART.
>>>>
>>>> This ends in no new timer and also no enqueue, leaving the dl_server
>>>> 'dead', allowing starvation.
>>>>
>>>> What should have happened is for the bandwidth timer to start the
>>>> zero-laxity timer, which in turn would enqueue the dl_server and cause
>>>> dl_se->server_pick_task() to be called -- which will stop the
>>>> dl_server if no fair tasks are observed for a whole period.
>>>>
>>>> IOW, it is totally irrelevant if there are fair tasks at the moment of
>>>> bandwidth refresh.
>>>>
>>>> This removes all dl_se->server_has_tasks() users, so remove the whole
>>>> thing.
>>>>
>>>> Fixes: cccb45d7c4295 ("sched/deadline: Less agressive dl_server handling")
>>>> Reported-by: John Stultz<jstultz@google.com>
>>>> Signed-off-by: Peter Zijlstra (Intel)<peterz@infradead.org>
>>>> Tested-by: John Stultz<jstultz@google.com>
>>>> ---
>>> This patch landed in today's linux-next as commit 077e1e2e0015
>>> ("sched/deadline: Fix dl_server getting stuck"). In my tests I found
>>> that it breaks CPU hotplug on some of my systems. On 64bit
>>> Exynos5433-based TM2e board I've captured the following lock dep warning
>>> (which unfortunately doesn't look like really related to CPU hotplug):
>> Right -- I've looked at this patch a few times over the day, and the
>> only thing I can think of is that we keep the dl_server timer running.
>> But I already gave you a patch that *should've* stopped it.
>>
>> There were a few issues with it -- notably if you've booted with
>> something like isolcpus / nohz_full it might not have worked because the
>> site I put the dl_server_stop() would only get ran if there was a root
>> domain attached to the CPU.
>>
>> Put it in a different spot, just to make sure.
>>
>> There is also the fact that dl_server_stop() uses
>> hrtimer_try_to_cancel(), which can 'fail' when the timer is actively
>> running. But if that is the case, it must be spin-waiting on rq->lock
>> -- since the caller of dl_server_stop() will be holding that. Once
>> dl_server_stop() completes and the rq->lock is released, the timer will
>> see !dl_se->dl_throttled and immediately stop without restarting.
>>
>> So that *should* not be a problem.
>>
>> Anyway, clutching at staws here etc.
>>
>>> # for i in /sys/devices/system/cpu/cpu[1-9]; do echo 0 >$i/online; done
>>> Detected VIPT I-cache on CPU7
>>> CPU7: Booted secondary processor 0x0000000101 [0x410fd031]
>>> ------------[ cut here ]------------
>>> WARNING: CPU: 7 PID: 0 at kernel/rcu/tree.c:4329
>>> rcutree_report_cpu_starting+0x1e8/0x348
>> This is really weird; this does indeed look like CPU7 decides to boot
>> again. AFAICT it is not hotplug failing and bringing the CPU back again,
>> but it is really starting again.
>>
>> I'm not well versed enough in ARM64 foo to know what would cause a CPU
>> to boot -- but on x86_64 this isn't something that would easily happen
>> by accident.
>>
>> Not stopping a timer would certainly not be sufficient -- notably
>> hrtimers_cpu_dying() would have migrated the thing.
>>
>>> (system is frozen at this point).
>> The whole lockdep and freezing thing is typically printk choking on
>> itself.
>>
>> My personal way around this are these here patches:
>>
>>    git://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git debug/experimental
>>
>> They don't apply cleanly anymore, but the conflict isn't hard, so I've
>> not taken the bother to rebase them yet. It relies on the platform
>> having earlyprintk configured, then add force_early_printk to your
>> kernel cmdline to have earlyprintk completely take over.
>>
>> Typical early serial drivers are lock-free and don't suffer from
>> lockups.
>>
>> If you get it to work, you might get more data out of it.
> 
> Thanks for some hints, but unfortunately ARM64 doesn't support 
> earlyprintk, so I was not able to use this method.
> 
> However I've played a bit with this code and found that this strange 
> wake-up of the CPU7 seems to be caused by the timer. If I restore
> 
>    if (!dl_se->server_has_tasks(dl_se))
>            return HRTIMER_NORESTART;
> 
> part in the dl_server_timer, the everything works again as before this 
> patch.
> 
> This issue is however not Exynos5433 ARM 64bit specific. Similar lockup 
> happens on Exynos5422 ARM 32bit boards, although there is no message in 
> that case. Does it mean that handling of the hrtimers on Exynos boards 
> is a bit broken in the context of CPU hotplug? I've never analyzed that 
> part of Exynos SoC support. Krzysztof, any chance You remember how it works?


I don't recall anything around this, but I also don't remember that much
of details anymore.

I believe long time ago - around 2014-2015 - were testing Exynos MCT
against hotplug as well, so I think it was working. Many things could
happen in between...

Best regards,
Krzysztof

