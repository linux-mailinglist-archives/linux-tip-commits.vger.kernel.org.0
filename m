Return-Path: <linux-tip-commits+bounces-6707-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 30412B93688
	for <lists+linux-tip-commits@lfdr.de>; Mon, 22 Sep 2025 23:57:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D8FE12A3D59
	for <lists+linux-tip-commits@lfdr.de>; Mon, 22 Sep 2025 21:57:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE6202F28E0;
	Mon, 22 Sep 2025 21:57:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="bNR38Xj/"
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5698726A0BD
	for <linux-tip-commits@vger.kernel.org>; Mon, 22 Sep 2025 21:57:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758578229; cv=none; b=tAzmhU9h/W8guvH8fpo244/Zbt9g4cYRP5yVN56/bMRD4j85bSwoP/H+aolFZTWAFvzkMv1XP5Z6OfIZgCIOWdD1SetbeR3I0qVJG/oh9XKFBowcJHItyTkJxE/wRhWanzbuEGiBcnrLikDvz2ZTsyUICHOxCocxCNaPVXnMk+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758578229; c=relaxed/simple;
	bh=an5C3yhgDnC3YbPVyttBZAYLTNiJkifS8ZDBVEPe83o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:In-Reply-To:
	 Content-Type:References; b=E1O8TOSqza+d3tqjM7XqPx1z1dF2rD63D0zJEp06iCGnk2WPps0tDnhb/rhNhkDEcmExG6V4mDa/nd9fEeaZscNfEnKkzJYGjY94r+qrPaWDftfg1IQa8cNH2P0l1FW5nGFKgIdHTji4g786jUL1L5Hyfa4FoBBFn7yvYNsLdxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=bNR38Xj/; arc=none smtp.client-ip=210.118.77.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20250922215704euoutp01a56d5bd03d6a96dc11813c2d11d2d352~nuZP1nfuR2192721927euoutp010
	for <linux-tip-commits@vger.kernel.org>; Mon, 22 Sep 2025 21:57:04 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20250922215704euoutp01a56d5bd03d6a96dc11813c2d11d2d352~nuZP1nfuR2192721927euoutp010
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1758578224;
	bh=v73x/OsFJ0zfBygdSvvdcy3bRhRwipCxqQjqDSEa2N0=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=bNR38Xj/RUcMSxkop6ZPI8q0NhFrqPiPF1SMNBYbrHxQK1c9qhyi4+ThnssNX7D/h
	 rOParvWOfE+jvtifWCAJJtTf6DYf8Lnx2HC3IHvBOBCVWT6tiRl8tr7KUeYmwTk0Pi
	 Lqaw267F4vkVdYZklElH1E57l8nCskRUjB8kHq6I=
Received: from eusmtip1.samsung.com (unknown [203.254.199.221]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20250922215704eucas1p1f53a65a5cd1eafd3e0db006653231efd~nuZPWrQfr0395703957eucas1p1q;
	Mon, 22 Sep 2025 21:57:04 +0000 (GMT)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
	eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20250922215703eusmtip1c6250de2f49dcaf751973e086f104fcb~nuZOv61zZ2100721007eusmtip1j;
	Mon, 22 Sep 2025 21:57:03 +0000 (GMT)
Message-ID: <e56310b5-f7a9-4fad-b79a-dcbcdd3d3883@samsung.com>
Date: Mon, 22 Sep 2025 23:57:02 +0200
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [tip: sched/urgent] sched/deadline: Fix dl_server getting stuck
To: linux-kernel@vger.kernel.org, linux-tip-commits@vger.kernel.org
Cc: John Stultz <jstultz@google.com>, "Peter Zijlstra (Intel)"
	<peterz@infradead.org>, x86@kernel.org, 'Linux Samsung SOC'
	<linux-samsung-soc@vger.kernel.org>
Content-Language: en-US
From: Marek Szyprowski <m.szyprowski@samsung.com>
In-Reply-To: <175817861820.709179.10538516755307778527.tip-bot2@tip-bot2>
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20250922215704eucas1p1f53a65a5cd1eafd3e0db006653231efd
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20250922215704eucas1p1f53a65a5cd1eafd3e0db006653231efd
X-EPHeader: CA
X-CMS-RootMailID: 20250922215704eucas1p1f53a65a5cd1eafd3e0db006653231efd
References: <20250916110155.GH3245006@noisy.programming.kicks-ass.net>
	<175817861820.709179.10538516755307778527.tip-bot2@tip-bot2>
	<CGME20250922215704eucas1p1f53a65a5cd1eafd3e0db006653231efd@eucas1p1.samsung.com>

On 18.09.2025 08:56, tip-bot2 for Peter Zijlstra wrote:
> The following commit has been merged into the sched/urgent branch of tip:
>
> Commit-ID:     077e1e2e0015e5ba6538d1c5299fb299a3a92d60
> Gitweb:        https://git.kernel.org/tip/077e1e2e0015e5ba6538d1c5299fb299a3a92d60
> Author:        Peter Zijlstra <peterz@infradead.org>
> AuthorDate:    Tue, 16 Sep 2025 23:02:41 +02:00
> Committer:     Peter Zijlstra <peterz@infradead.org>
> CommitterDate: Thu, 18 Sep 2025 08:50:05 +02:00
>
> sched/deadline: Fix dl_server getting stuck
>
> John found it was easy to hit lockup warnings when running locktorture
> on a 2 CPU VM, which he bisected down to: commit cccb45d7c429
> ("sched/deadline: Less agressive dl_server handling").
>
> While debugging it seems there is a chance where we end up with the
> dl_server dequeued, with dl_se->dl_server_active. This causes
> dl_server_start() to return without enqueueing the dl_server, thus it
> fails to run when RT tasks starve the cpu.
>
> When this happens, dl_server_timer() catches the
> '!dl_se->server_has_tasks(dl_se)' case, which then calls
> replenish_dl_entity() and dl_server_stopped() and finally return
> HRTIMER_NO_RESTART.
>
> This ends in no new timer and also no enqueue, leaving the dl_server
> 'dead', allowing starvation.
>
> What should have happened is for the bandwidth timer to start the
> zero-laxity timer, which in turn would enqueue the dl_server and cause
> dl_se->server_pick_task() to be called -- which will stop the
> dl_server if no fair tasks are observed for a whole period.
>
> IOW, it is totally irrelevant if there are fair tasks at the moment of
> bandwidth refresh.
>
> This removes all dl_se->server_has_tasks() users, so remove the whole
> thing.
>
> Fixes: cccb45d7c4295 ("sched/deadline: Less agressive dl_server handling")
> Reported-by: John Stultz <jstultz@google.com>
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> Tested-by: John Stultz <jstultz@google.com>
> ---

This patch landed in today's linux-next as commit 077e1e2e0015 
("sched/deadline: Fix dl_server getting stuck"). In my tests I found 
that it breaks CPU hotplug on some of my systems. On 64bit 
Exynos5433-based TM2e board I've captured the following lock dep warning 
(which unfortunately doesn't look like really related to CPU hotplug):

# for i in /sys/devices/system/cpu/cpu[1-9]; do echo 0 >$i/online; done
Detected VIPT I-cache on CPU7
CPU7: Booted secondary processor 0x0000000101 [0x410fd031]
------------[ cut here ]------------
WARNING: CPU: 7 PID: 0 at kernel/rcu/tree.c:4329 
rcutree_report_cpu_starting+0x1e8/0x348
Modules linked in: brcmfmac_wcc cpufreq_powersave cpufreq_conservative 
brcmfmac brcmutil sha256 snd_soc_wm5110 cfg80211 snd_soc_wm_adsp cs_dsp 
snd_soc_tm2_wm5110 snd_soc_arizona arizona_micsupp phy_exynos5_usbdrd 
s5p_mfc typec arizona_ldo1 hci_uart btqca s5p_jpeg max77693_haptic btbcm 
s3fwrn5_i2c exynos_gsc bluetooth s3fwrn5 nci v4l2_mem2mem nfc 
snd_soc_i2s snd_soc_idma snd_soc_hdmi_codec snd_soc_max98504 
snd_soc_s3c_dma videobuf2_dma_contig videobuf2_memops ecdh_generic 
snd_soc_core ir_spi videobuf2_v4l2 ecc snd_compress ntc_thermistor 
panfrost videodev snd_pcm_dmaengine snd_pcm rfkill drm_shmem_helper 
panel_samsung_s6e3ha2 videobuf2_common backlight pwrseq_core gpu_sched 
mc snd_timer snd soundcore ipv6
CPU: 7 UID: 0 PID: 0 Comm: swapper/7 Not tainted 6.17.0-rc6+ #16012 PREEMPT
Hardware name: Samsung TM2E board (DT)
Hardware name: Samsung TM2E board (DT)
Detected VIPT I-cache on CPU7

======================================================
WARNING: possible circular locking dependency detected
6.17.0-rc6+ #16012 Not tainted
------------------------------------------------------
swapper/7/0 is trying to acquire lock:
ffff000024021cc8 (&irq_desc_lock_class){-.-.}-{2:2}, at: 
__irq_get_desc_lock+0x5c/0x9c

but task is already holding lock:
ffff800083e479c0 (&port_lock_key){-.-.}-{3:3}, at: 
s3c24xx_serial_console_write+0x80/0x268

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #2 (&port_lock_key){-.-.}-{3:3}:
        _raw_spin_lock_irqsave+0x60/0x88
        s3c24xx_serial_console_write+0x80/0x268
        console_flush_all+0x304/0x49c
        console_unlock+0x70/0x110
        vprintk_emit+0x254/0x39c
        vprintk_default+0x38/0x44
        vprintk+0x28/0x34
        _printk+0x5c/0x84
        register_console+0x3ac/0x4f8
        serial_core_register_port+0x6c4/0x7a4
        serial_ctrl_register_port+0x10/0x1c
        uart_add_one_port+0x10/0x1c
        s3c24xx_serial_probe+0x34c/0x6d8
        platform_probe+0x5c/0xac
        really_probe+0xbc/0x298
        __driver_probe_device+0x78/0x12c
        driver_probe_device+0xdc/0x164
        __device_attach_driver+0xb8/0x138
        bus_for_each_drv+0x80/0xdc
        __device_attach+0xa8/0x1b0
        device_initial_probe+0x14/0x20
        bus_probe_device+0xb0/0xb4
        deferred_probe_work_func+0x8c/0xc8
        process_one_work+0x208/0x60c
        worker_thread+0x244/0x388
        kthread+0x150/0x228
        ret_from_fork+0x10/0x20

-> #1 (console_owner){..-.}-{0:0}:
        console_lock_spinning_enable+0x6c/0x7c
        console_flush_all+0x2c8/0x49c
        console_unlock+0x70/0x110
        vprintk_emit+0x254/0x39c
        vprintk_default+0x38/0x44
        vprintk+0x28/0x34
        _printk+0x5c/0x84
        exynos_wkup_irq_set_wake+0x80/0xa4
        irq_set_irq_wake+0x164/0x1e0
        arizona_irq_set_wake+0x18/0x24
        irq_set_irq_wake+0x164/0x1e0
        regmap_irq_sync_unlock+0x328/0x530
        __irq_put_desc_unlock+0x48/0x4c
        irq_set_irq_wake+0x84/0x1e0
        arizona_set_irq_wake+0x5c/0x70
        wm5110_probe+0x220/0x354 [snd_soc_wm5110]
        platform_probe+0x5c/0xac
        really_probe+0xbc/0x298
        __driver_probe_device+0x78/0x12c
        driver_probe_device+0xdc/0x164
        __driver_attach+0x9c/0x1ac
        bus_for_each_dev+0x74/0xd0
        driver_attach+0x24/0x30
        bus_add_driver+0xe4/0x208
        driver_register+0x60/0x128
        __platform_driver_register+0x24/0x30
        cs_exit+0xc/0x20 [cpufreq_conservative]
        do_one_initcall+0x64/0x308
        do_init_module+0x58/0x23c
        load_module+0x1b48/0x1dc4
        init_module_from_file+0x84/0xc4
        idempotent_init_module+0x188/0x280
        __arm64_sys_finit_module+0x68/0xac
        invoke_syscall+0x48/0x110
        el0_svc_.common.c

(system is frozen at this point).

Let me know if I can help somehow debugging this issue. Reverting 
$subject on top of linux-next fixes this issue.


>   include/linux/sched.h   |  1 -
>   kernel/sched/deadline.c | 12 +-----------
>   kernel/sched/fair.c     |  7 +------
>   kernel/sched/sched.h    |  4 ----
>   4 files changed, 2 insertions(+), 22 deletions(-)
>
> diff --git a/include/linux/sched.h b/include/linux/sched.h
> index f8188b8..f89313b 100644
> --- a/include/linux/sched.h
> +++ b/include/linux/sched.h
> @@ -733,7 +733,6 @@ struct sched_dl_entity {
>   	 * runnable task.
>   	 */
>   	struct rq			*rq;
> -	dl_server_has_tasks_f		server_has_tasks;
>   	dl_server_pick_f		server_pick_task;
>   
>   #ifdef CONFIG_RT_MUTEXES
> diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
> index f253012..5a5080b 100644
> --- a/kernel/sched/deadline.c
> +++ b/kernel/sched/deadline.c
> @@ -875,7 +875,7 @@ static void replenish_dl_entity(struct sched_dl_entity *dl_se)
>   	 */
>   	if (dl_se->dl_defer && !dl_se->dl_defer_running &&
>   	    dl_time_before(rq_clock(dl_se->rq), dl_se->deadline - dl_se->runtime)) {
> -		if (!is_dl_boosted(dl_se) && dl_se->server_has_tasks(dl_se)) {
> +		if (!is_dl_boosted(dl_se)) {
>   
>   			/*
>   			 * Set dl_se->dl_defer_armed and dl_throttled variables to
> @@ -1152,8 +1152,6 @@ static void __push_dl_task(struct rq *rq, struct rq_flags *rf)
>   /* a defer timer will not be reset if the runtime consumed was < dl_server_min_res */
>   static const u64 dl_server_min_res = 1 * NSEC_PER_MSEC;
>   
> -static bool dl_server_stopped(struct sched_dl_entity *dl_se);
> -
>   static enum hrtimer_restart dl_server_timer(struct hrtimer *timer, struct sched_dl_entity *dl_se)
>   {
>   	struct rq *rq = rq_of_dl_se(dl_se);
> @@ -1171,12 +1169,6 @@ static enum hrtimer_restart dl_server_timer(struct hrtimer *timer, struct sched_
>   		if (!dl_se->dl_runtime)
>   			return HRTIMER_NORESTART;
>   
> -		if (!dl_se->server_has_tasks(dl_se)) {
> -			replenish_dl_entity(dl_se);
> -			dl_server_stopped(dl_se);
> -			return HRTIMER_NORESTART;
> -		}
> -
>   		if (dl_se->dl_defer_armed) {
>   			/*
>   			 * First check if the server could consume runtime in background.
> @@ -1625,11 +1617,9 @@ static bool dl_server_stopped(struct sched_dl_entity *dl_se)
>   }
>   
>   void dl_server_init(struct sched_dl_entity *dl_se, struct rq *rq,
> -		    dl_server_has_tasks_f has_tasks,
>   		    dl_server_pick_f pick_task)
>   {
>   	dl_se->rq = rq;
> -	dl_se->server_has_tasks = has_tasks;
>   	dl_se->server_pick_task = pick_task;
>   }
>   
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index c4d91e8..59d7dc9 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -8859,11 +8859,6 @@ static struct task_struct *__pick_next_task_fair(struct rq *rq, struct task_stru
>   	return pick_next_task_fair(rq, prev, NULL);
>   }
>   
> -static bool fair_server_has_tasks(struct sched_dl_entity *dl_se)
> -{
> -	return !!dl_se->rq->cfs.nr_queued;
> -}
> -
>   static struct task_struct *fair_server_pick_task(struct sched_dl_entity *dl_se)
>   {
>   	return pick_task_fair(dl_se->rq);
> @@ -8875,7 +8870,7 @@ void fair_server_init(struct rq *rq)
>   
>   	init_dl_entity(dl_se);
>   
> -	dl_server_init(dl_se, rq, fair_server_has_tasks, fair_server_pick_task);
> +	dl_server_init(dl_se, rq, fair_server_pick_task);
>   }
>   
>   /*
> diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
> index be9745d..f10d627 100644
> --- a/kernel/sched/sched.h
> +++ b/kernel/sched/sched.h
> @@ -365,9 +365,6 @@ extern s64 dl_scaled_delta_exec(struct rq *rq, struct sched_dl_entity *dl_se, s6
>    *
>    *   dl_se::rq -- runqueue we belong to.
>    *
> - *   dl_se::server_has_tasks() -- used on bandwidth enforcement; we 'stop' the
> - *                                server when it runs out of tasks to run.
> - *
>    *   dl_se::server_pick() -- nested pick_next_task(); we yield the period if this
>    *                           returns NULL.
>    *
> @@ -383,7 +380,6 @@ extern void dl_server_update(struct sched_dl_entity *dl_se, s64 delta_exec);
>   extern void dl_server_start(struct sched_dl_entity *dl_se);
>   extern void dl_server_stop(struct sched_dl_entity *dl_se);
>   extern void dl_server_init(struct sched_dl_entity *dl_se, struct rq *rq,
> -		    dl_server_has_tasks_f has_tasks,
>   		    dl_server_pick_f pick_task);
>   extern void sched_init_dl_servers(void);
>   
>
Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland


