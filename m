Return-Path: <linux-tip-commits+bounces-6776-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CB25BA9C6D
	for <lists+linux-tip-commits@lfdr.de>; Mon, 29 Sep 2025 17:19:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 124CB171603
	for <lists+linux-tip-commits@lfdr.de>; Mon, 29 Sep 2025 15:19:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9C5530BB98;
	Mon, 29 Sep 2025 15:19:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="inCJw68P"
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B31C30B508
	for <linux-tip-commits@vger.kernel.org>; Mon, 29 Sep 2025 15:19:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759159183; cv=none; b=pfVnhr75FFCReL3NvQTSwntRvkkv7vDGiGRd80gxipZp9icTbMwp4W/m0lRvpUjW2DM7g75vqG+JK9g8rbjiAuBI0LTJDNlh5Sf7wli7MyHloOJp7gchXmwxtNZpsoce0EWirbXBERDHrUXvhWXYkDF3oUbpUM/i1XWYGetqYPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759159183; c=relaxed/simple;
	bh=NmngDIsVaG9FNz2pX1bIPHioJi65rfgJ6cXVNG1msos=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:In-Reply-To:
	 Content-Type:References; b=fdlNR55Nr6LBYdGpXs2ASvoAU0Pe+3lT08lJaL0Ta0gjGMPUp/ggnU2q7kBg0oBr/eM1BREQI6gNYQBQEeEDugTdkfCRZNk71kNxAUMxlEoMI+Eaof5yezr2WGJmzQ1K6v2TbMX0ZvXfZSU9BPyqfaEK47PopfTpbPZVygosQcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=inCJw68P; arc=none smtp.client-ip=210.118.77.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20250929151940euoutp02e7cb2935eadb1806a4c44d86f25d5949~pyfQ1U-XH2468424684euoutp020
	for <linux-tip-commits@vger.kernel.org>; Mon, 29 Sep 2025 15:19:40 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20250929151940euoutp02e7cb2935eadb1806a4c44d86f25d5949~pyfQ1U-XH2468424684euoutp020
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1759159180;
	bh=lQvatkdTJWv/O9iQgch5k0dtR3gAJUxhwmswZ23oNjo=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=inCJw68P7JFVfihpdlBFuJPKhwv0JgsfX6RbXcXdewDDT/fAGxLpN+rotyyIpDFB9
	 e1BnO03Q4gr/4aCuwT7Gt8wl17QY9DWytHGDzmRVNxPdwDkKJVb/4UMjnOl2Dr2mT1
	 IUEmPNcfcVKSyItIG/nalxBOpv/e/NNRhxIpn0DM=
Received: from eusmtip2.samsung.com (unknown [203.254.199.222]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20250929151939eucas1p1daf505d038fd8f999100284e894faf90~pyfQU0uuS1280512805eucas1p1L;
	Mon, 29 Sep 2025 15:19:39 +0000 (GMT)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
	eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20250929151938eusmtip28c497a2e4ed21f13040dd7f07cb23456~pyfPlNMDE2517525175eusmtip2X;
	Mon, 29 Sep 2025 15:19:38 +0000 (GMT)
Message-ID: <306c576d-9840-4604-88de-7d1623eabfba@samsung.com>
Date: Mon, 29 Sep 2025 17:19:37 +0200
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [tip: sched/urgent] sched/deadline: Fix dl_server getting stuck
To: Peter Zijlstra <peterz@infradead.org>, Krzysztof Kozlowski
	<krzk@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-tip-commits@vger.kernel.org, John
	Stultz <jstultz@google.com>, x86@kernel.org, 'Linux Samsung SOC'
	<linux-samsung-soc@vger.kernel.org>, Mark Rutland <mark.rutland@arm.com>
Content-Language: en-US
From: Marek Szyprowski <m.szyprowski@samsung.com>
In-Reply-To: <20250923220215.GH3419281@noisy.programming.kicks-ass.net>
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20250929151939eucas1p1daf505d038fd8f999100284e894faf90
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

On 24.09.2025 00:02, Peter Zijlstra wrote:
> On Mon, Sep 22, 2025 at 11:57:02PM +0200, Marek Szyprowski wrote:
>> On 18.09.2025 08:56, tip-bot2 for Peter Zijlstra wrote:
>>> The following commit has been merged into the sched/urgent branch of tip:
>>>
>>> Commit-ID:     077e1e2e0015e5ba6538d1c5299fb299a3a92d60
>>> Gitweb:        https://git.kernel.org/tip/077e1e2e0015e5ba6538d1c5299fb299a3a92d60
>>> Author:        Peter Zijlstra <peterz@infradead.org>
>>> AuthorDate:    Tue, 16 Sep 2025 23:02:41 +02:00
>>> Committer:     Peter Zijlstra <peterz@infradead.org>
>>> CommitterDate: Thu, 18 Sep 2025 08:50:05 +02:00
>>>
>>> sched/deadline: Fix dl_server getting stuck
>>>
>>> John found it was easy to hit lockup warnings when running locktorture
>>> on a 2 CPU VM, which he bisected down to: commit cccb45d7c429
>>> ("sched/deadline: Less agressive dl_server handling").
>>>
>>> While debugging it seems there is a chance where we end up with the
>>> dl_server dequeued, with dl_se->dl_server_active. This causes
>>> dl_server_start() to return without enqueueing the dl_server, thus it
>>> fails to run when RT tasks starve the cpu.
>>>
>>> When this happens, dl_server_timer() catches the
>>> '!dl_se->server_has_tasks(dl_se)' case, which then calls
>>> replenish_dl_entity() and dl_server_stopped() and finally return
>>> HRTIMER_NO_RESTART.
>>>
>>> This ends in no new timer and also no enqueue, leaving the dl_server
>>> 'dead', allowing starvation.
>>>
>>> What should have happened is for the bandwidth timer to start the
>>> zero-laxity timer, which in turn would enqueue the dl_server and cause
>>> dl_se->server_pick_task() to be called -- which will stop the
>>> dl_server if no fair tasks are observed for a whole period.
>>>
>>> IOW, it is totally irrelevant if there are fair tasks at the moment of
>>> bandwidth refresh.
>>>
>>> This removes all dl_se->server_has_tasks() users, so remove the whole
>>> thing.
>>>
>>> Fixes: cccb45d7c4295 ("sched/deadline: Less agressive dl_server handling")
>>> Reported-by: John Stultz <jstultz@google.com>
>>> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
>>> Tested-by: John Stultz <jstultz@google.com>
>>> ---
>> This patch landed in today's linux-next as commit 077e1e2e0015
>> ("sched/deadline: Fix dl_server getting stuck"). In my tests I found
>> that it breaks CPU hotplug on some of my systems. On 64bit
>> Exynos5433-based TM2e board I've captured the following lock dep warning
>> (which unfortunately doesn't look like really related to CPU hotplug):
> Right -- I've looked at this patch a few times over the day, and the
> only thing I can think of is that we keep the dl_server timer running.
> But I already gave you a patch that *should've* stopped it.
>
> There were a few issues with it -- notably if you've booted with
> something like isolcpus / nohz_full it might not have worked because the
> site I put the dl_server_stop() would only get ran if there was a root
> domain attached to the CPU.
>
> Put it in a different spot, just to make sure.
>
> There is also the fact that dl_server_stop() uses
> hrtimer_try_to_cancel(), which can 'fail' when the timer is actively
> running. But if that is the case, it must be spin-waiting on rq->lock
> -- since the caller of dl_server_stop() will be holding that. Once
> dl_server_stop() completes and the rq->lock is released, the timer will
> see !dl_se->dl_throttled and immediately stop without restarting.
>
> So that *should* not be a problem.
>
> Anyway, clutching at staws here etc.
>
>> # for i in /sys/devices/system/cpu/cpu[1-9]; do echo 0 >$i/online; done
>> Detected VIPT I-cache on CPU7
>> CPU7: Booted secondary processor 0x0000000101 [0x410fd031]
>> ------------[ cut here ]------------
>> WARNING: CPU: 7 PID: 0 at kernel/rcu/tree.c:4329
>> rcutree_report_cpu_starting+0x1e8/0x348
> This is really weird; this does indeed look like CPU7 decides to boot
> again. AFAICT it is not hotplug failing and bringing the CPU back again,
> but it is really starting again.
>
> I'm not well versed enough in ARM64 foo to know what would cause a CPU
> to boot -- but on x86_64 this isn't something that would easily happen
> by accident.
>
> Not stopping a timer would certainly not be sufficient -- notably
> hrtimers_cpu_dying() would have migrated the thing.
>
>> (system is frozen at this point).
> The whole lockdep and freezing thing is typically printk choking on
> itself.
>
> My personal way around this are these here patches:
>
>    git://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git debug/experimental
>
> They don't apply cleanly anymore, but the conflict isn't hard, so I've
> not taken the bother to rebase them yet. It relies on the platform
> having earlyprintk configured, then add force_early_printk to your
> kernel cmdline to have earlyprintk completely take over.
>
> Typical early serial drivers are lock-free and don't suffer from
> lockups.
>
> If you get it to work, you might get more data out of it.

Thanks for some hints, but unfortunately ARM64 doesn't support 
earlyprintk, so I was not able to use this method.

However I've played a bit with this code and found that this strange 
wake-up of the CPU7 seems to be caused by the timer. If I restore

   if (!dl_se->server_has_tasks(dl_se))
           return HRTIMER_NORESTART;

part in the dl_server_timer, the everything works again as before this 
patch.

This issue is however not Exynos5433 ARM 64bit specific. Similar lockup 
happens on Exynos5422 ARM 32bit boards, although there is no message in 
that case. Does it mean that handling of the hrtimers on Exynos boards 
is a bit broken in the context of CPU hotplug? I've never analyzed that 
part of Exynos SoC support. Krzysztof, any chance You remember how it works?

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland


