Return-Path: <linux-tip-commits+bounces-6709-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DD0CB948F6
	for <lists+linux-tip-commits@lfdr.de>; Tue, 23 Sep 2025 08:31:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6E6EB19008F3
	for <lists+linux-tip-commits@lfdr.de>; Tue, 23 Sep 2025 06:31:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF19522DA08;
	Tue, 23 Sep 2025 06:31:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="MbPEdgtj"
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82A8335959
	for <linux-tip-commits@vger.kernel.org>; Tue, 23 Sep 2025 06:31:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758609091; cv=none; b=uJYGgA2AtJ8i57/C14lRN2j6UzTE6hlFwnq2vmH7LSPYD5HR56BMBrfEWV32GV0HOQhxprkRfe4lF6B9BKHatv+O8secG+hk0oofo/NFu2wTdsqozjr2XvVwlPVn5BNRulHi+UADql6D8YkFV9PSYI1eP8po7AJCT75Wscn0MIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758609091; c=relaxed/simple;
	bh=7mFxlUoz+jCcP6rKZXNDXJ/o/NmYUhVbI84WFhXpjMY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:In-Reply-To:
	 Content-Type:References; b=Y7QcZKsumFcnFQMUiOr6qHSlLR2L78vex3MtAoESwKYcPq8r7ErCwSUkRqzqLlqBxXvp3rgNT3+CmAoGBkg44Ybbwv2Ahhq/9t1JA3rB4frilBk2hJ5RvgMCZJ0w+xXTkiNq74NQiMAtHFD6J3PW6NVtjj98+7E485JSsa+h9DM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=MbPEdgtj; arc=none smtp.client-ip=210.118.77.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20250923063127euoutp01830487948b447ea833747e17619a2a7f~n1aXXCDNO0888408884euoutp01D
	for <linux-tip-commits@vger.kernel.org>; Tue, 23 Sep 2025 06:31:27 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20250923063127euoutp01830487948b447ea833747e17619a2a7f~n1aXXCDNO0888408884euoutp01D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1758609087;
	bh=mey1jZcwAuCJC/IYycDLY8VErgZy5U0IXTS1bXXLblw=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=MbPEdgtjXVLIEwdRWKdaDdNA3gb4tVra5KMqtwozdNr4k4rkVnoobm8z9SdYRZGVI
	 pOEFXT1aBxI/X9l9IoM30NWKR+vBi5NNFHlkP9xoteaBmEZVk14s3+mgnsbQlYcqcc
	 CZYbj4R1KGumbmEqMd1N5B496fHtYpuWoqHrvVNE=
Received: from eusmtip2.samsung.com (unknown [203.254.199.222]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20250923063127eucas1p26e39a1ed018e382f880e2e120c6555e4~n1aXPN0n-1731817318eucas1p2Q;
	Tue, 23 Sep 2025 06:31:27 +0000 (GMT)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
	eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20250923063126eusmtip2a8efab38a6568b81a516261f0a4fe4b3~n1aWgkdVQ0941709417eusmtip2T;
	Tue, 23 Sep 2025 06:31:26 +0000 (GMT)
Message-ID: <47563570-7339-43da-af15-4acf7b93075c@samsung.com>
Date: Tue, 23 Sep 2025 08:31:26 +0200
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [tip: sched/urgent] sched/deadline: Fix dl_server getting stuck
To: John Stultz <jstultz@google.com>
Cc: linux-kernel@vger.kernel.org, linux-tip-commits@vger.kernel.org, "Peter
 Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org, Linux Samsung SOC
	<linux-samsung-soc@vger.kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
From: Marek Szyprowski <m.szyprowski@samsung.com>
In-Reply-To: <CANDhNCrztM1eK-6dab_-4hnX4miJH_pe49r=GVVqtD+Z235kgw@mail.gmail.com>
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20250923063127eucas1p26e39a1ed018e382f880e2e120c6555e4
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20250922215704eucas1p1f53a65a5cd1eafd3e0db006653231efd
X-EPHeader: CA
X-CMS-RootMailID: 20250922215704eucas1p1f53a65a5cd1eafd3e0db006653231efd
References: <20250916110155.GH3245006@noisy.programming.kicks-ass.net>
	<CGME20250922215704eucas1p1f53a65a5cd1eafd3e0db006653231efd@eucas1p1.samsung.com>
	<175817861820.709179.10538516755307778527.tip-bot2@tip-bot2>
	<e56310b5-f7a9-4fad-b79a-dcbcdd3d3883@samsung.com>
	<CANDhNCrztM1eK-6dab_-4hnX4miJH_pe49r=GVVqtD+Z235kgw@mail.gmail.com>

On 23.09.2025 01:46, John Stultz wrote:
> On Mon, Sep 22, 2025 at 2:57 PM Marek Szyprowski
> <m.szyprowski@samsung.com> wrote:
>> This patch landed in today's linux-next as commit 077e1e2e0015
>> ("sched/deadline: Fix dl_server getting stuck"). In my tests I found
>> that it breaks CPU hotplug on some of my systems. On 64bit
>> Exynos5433-based TM2e board I've captured the following lock dep warning
>> (which unfortunately doesn't look like really related to CPU hotplug):
>>
> Huh. Nor does it really look related to the dl_server change. Interesting...
>
>
>> # for i in /sys/devices/system/cpu/cpu[1-9]; do echo 0 >$i/online; done
>> Detected VIPT I-cache on CPU7
>> CPU7: Booted secondary processor 0x0000000101 [0x410fd031]
>> ------------[ cut here ]------------
>> WARNING: CPU: 7 PID: 0 at kernel/rcu/tree.c:4329
>> rcutree_report_cpu_starting+0x1e8/0x348
>> Modules linked in: brcmfmac_wcc cpufreq_powersave cpufreq_conservative
>> brcmfmac brcmutil sha256 snd_soc_wm5110 cfg80211 snd_soc_wm_adsp cs_dsp
>> snd_soc_tm2_wm5110 snd_soc_arizona arizona_micsupp phy_exynos5_usbdrd
>> s5p_mfc typec arizona_ldo1 hci_uart btqca s5p_jpeg max77693_haptic btbcm
>> s3fwrn5_i2c exynos_gsc bluetooth s3fwrn5 nci v4l2_mem2mem nfc
>> snd_soc_i2s snd_soc_idma snd_soc_hdmi_codec snd_soc_max98504
>> snd_soc_s3c_dma videobuf2_dma_contig videobuf2_memops ecdh_generic
>> snd_soc_core ir_spi videobuf2_v4l2 ecc snd_compress ntc_thermistor
>> panfrost videodev snd_pcm_dmaengine snd_pcm rfkill drm_shmem_helper
>> panel_samsung_s6e3ha2 videobuf2_common backlight pwrseq_core gpu_sched
>> mc snd_timer snd soundcore ipv6
>> CPU: 7 UID: 0 PID: 0 Comm: swapper/7 Not tainted 6.17.0-rc6+ #16012 PREEMPT
>> Hardware name: Samsung TM2E board (DT)
>> Hardware name: Samsung TM2E board (DT)
>> Detected VIPT I-cache on CPU7
>>
>> ======================================================
>> WARNING: possible circular locking dependency detected
>> 6.17.0-rc6+ #16012 Not tainted
>> ------------------------------------------------------
>> swapper/7/0 is trying to acquire lock:
>> ffff000024021cc8 (&irq_desc_lock_class){-.-.}-{2:2}, at:
>> __irq_get_desc_lock+0x5c/0x9c
>>
>> but task is already holding lock:
>> ffff800083e479c0 (&port_lock_key){-.-.}-{3:3}, at:
>> s3c24xx_serial_console_write+0x80/0x268
>>
>> which lock already depends on the new lock.
>>
>>
>> the existing dependency chain (in reverse order) is:
>>
>> -> #2 (&port_lock_key){-.-.}-{3:3}:
>>          _raw_spin_lock_irqsave+0x60/0x88
>>          s3c24xx_serial_console_write+0x80/0x268
>>          console_flush_all+0x304/0x49c
>>          console_unlock+0x70/0x110
>>          vprintk_emit+0x254/0x39c
>>          vprintk_default+0x38/0x44
>>          vprintk+0x28/0x34
>>          _printk+0x5c/0x84
>>          register_console+0x3ac/0x4f8
>>          serial_core_register_port+0x6c4/0x7a4
>>          serial_ctrl_register_port+0x10/0x1c
>>          uart_add_one_port+0x10/0x1c
>>          s3c24xx_serial_probe+0x34c/0x6d8
>>          platform_probe+0x5c/0xac
>>          really_probe+0xbc/0x298
>>          __driver_probe_device+0x78/0x12c
>>          driver_probe_device+0xdc/0x164
>>          __device_attach_driver+0xb8/0x138
>>          bus_for_each_drv+0x80/0xdc
>>          __device_attach+0xa8/0x1b0
>>          device_initial_probe+0x14/0x20
>>          bus_probe_device+0xb0/0xb4
>>          deferred_probe_work_func+0x8c/0xc8
>>          process_one_work+0x208/0x60c
>>          worker_thread+0x244/0x388
>>          kthread+0x150/0x228
>>          ret_from_fork+0x10/0x20
>>
>> -> #1 (console_owner){..-.}-{0:0}:
>>          console_lock_spinning_enable+0x6c/0x7c
>>          console_flush_all+0x2c8/0x49c
>>          console_unlock+0x70/0x110
>>          vprintk_emit+0x254/0x39c
>>          vprintk_default+0x38/0x44
>>          vprintk+0x28/0x34
>>          _printk+0x5c/0x84
>>          exynos_wkup_irq_set_wake+0x80/0xa4
>>          irq_set_irq_wake+0x164/0x1e0
>>          arizona_irq_set_wake+0x18/0x24
>>          irq_set_irq_wake+0x164/0x1e0
>>          regmap_irq_sync_unlock+0x328/0x530
>>          __irq_put_desc_unlock+0x48/0x4c
>>          irq_set_irq_wake+0x84/0x1e0
>>          arizona_set_irq_wake+0x5c/0x70
>>          wm5110_probe+0x220/0x354 [snd_soc_wm5110]
>>          platform_probe+0x5c/0xac
>>          really_probe+0xbc/0x298
>>          __driver_probe_device+0x78/0x12c
>>          driver_probe_device+0xdc/0x164
>>          __driver_attach+0x9c/0x1ac
>>          bus_for_each_dev+0x74/0xd0
>>          driver_attach+0x24/0x30
>>          bus_add_driver+0xe4/0x208
>>          driver_register+0x60/0x128
>>          __platform_driver_register+0x24/0x30
>>          cs_exit+0xc/0x20 [cpufreq_conservative]
>>          do_one_initcall+0x64/0x308
>>          do_init_module+0x58/0x23c
>>          load_module+0x1b48/0x1dc4
>>          init_module_from_file+0x84/0xc4
>>          idempotent_init_module+0x188/0x280
>>          __arm64_sys_finit_module+0x68/0xac
>>          invoke_syscall+0x48/0x110
>>          el0_svc_.common.c
>>
>> (system is frozen at this point).
> So I've seen issues like this when testing scheduler changes,
> particularly when I've added debug printks or WARN_ONs that trip while
> we're deep in the scheduler core and hold various locks. I reported
> something similar here:
> https://lore.kernel.org/lkml/CANDhNCo8NRm4meR7vHqvP8vVZ-_GXVPuUKSO1wUQkKdfjvy20w@mail.gmail.com/
>
> Now, usually I'll see the lockdep warning, and the hang is much more rare.
>
> But I don't see right off how the dl_server change would affect this,
> other than just changing the timing of execution such that you manage
> to trip over the existing issue.
>
> So far I don't see anything similar testing hotplug on x86 qemu.  Do
> you get any other console messages or warnings prior?

Nope. But the most suspicious message that is there is the 'CPU7: Booted 
secondary processor 0x0000000101' line, which I got while off-lining all 
non-zero CPUs.


> Looking at the backtrace, I wonder if changing the pr_info() in
> exynos_wkup_irq_set_wake() to printk_deferred() might avoid this?


I've removed that pr_info() from exynos_wkup_irq_set_wake() completely 
and now I get the following warning:

# for i in /sys/devices/system/cpu/cpu[1-9]; do echo 0 >$i/online; done
# Detected VIPT I-cache on CPU7
  CPU7: Booted secondary processor 0x0000000101 [0x410fd031]
  ------------[ cut here ]------------
  WARNING: CPU: 7 PID: 0 at kernel/rcu/tree.c:4329 
rcutree_report_cpu_starting+0x1e8/0x348
  Modules linked in: brcmfmac_wcc brcmfmac brcmutil sha256 
cpufreq_powersave cpufreq_conservative cfg80211 snd_soc_tm2_wm5110 
hci_uart btqca btbcm s3fwrn5_i2c snd_soc_wm5110 bluetooth 
arizona_micsupp phy_exynos5_usbdrd s3fwrn5 s5p_mfc nci typec 
snd_soc_wm_adsp s5p_jpeg cs_dsp nfc ecdh_generic max77693_haptic 
snd_soc_arizona arizona_ldo1 ecc rfkill snd_soc_i2s snd_soc_idma 
snd_soc_max98504 snd_soc_hdmi_codec snd_soc_s3c_dma pwrseq_core 
snd_soc_core exynos_gsc ir_spi v4l2_mem2mem videobuf2_dma_contig 
videobuf2_memops snd_compress snd_pcm_dmaengine videobuf2_v4l2 videodev 
ntc_thermistor snd_pcm panfrost videobuf2_common drm_shmem_helper 
gpu_sched snd_timer mc panel_samsung_s6e3ha2 backlight snd soundcore ipv6
  CPU: 7 UID: 0 PID: 0 Comm: swapper/7 Not tainted 6.17.0-rc6+ #16014 
PREEMPT
  Hardware name: Samsung TM2E board (DT)
  Hardware name: Samsung TM2E board (DT)
  Detected VIPT I-cache on CPU7
  CPU7: Booted secondary processor 0x0000000103 [0x410fd031]

  ================================
  WARNING: inconsistent lock state
  6.17.0-rc6+ #16014 Not tainted
  --------------------------------
  inconsistent {IN-HARDIRQ-W} -> {HARDIRQ-ON-W} usage.
  swapper/7/0 [HC0[0]:SC0[0]:HE0:SE1] takes:
  ffff800083e479c0 (&port_lock_key){?.-.}-{3:3}, at: 
s3c24xx_serial_console_write+0x80/0x268
  {IN-HARDIRQ-W} state was registered at:
    lock_acquire+0x1c8/0x354
    _raw_spin_lock+0x48/0x60
    s3c64xx_serial_handle_irq+0x6c/0x164
    __handle_irq_event_percpu+0x9c/0x2d8
    handle_irq_event+0x4c/0xac
    handle_fasteoi_irq+0x108/0x198
    handle_irq_desc+0x40/0x58
    generic_handle_domain_irq+0x1c/0x28
    gic_handle_irq+0x40/0xc8
    call_on_irq_stack+0x30/0x48
    do_interrupt_handler+0x80/0x84
    el1_interrupt+0x34/0x64
    el1h_64_irq_handler+0x18/0x24
    el1h_64_irq+0x6c/0x70
    default_idle_call+0xac/0x26c
    do_idle+0x220/0x284
    cpu_startup_entry+0x38/0x3c
    rest_init+0xf4/0x184
    start_kernel+0x70c/0x7d4
    __primary_switched+0x88/0x90
  irq event stamp: 63878
  hardirqs last  enabled at (63877): [<ffff800080121d2c>] 
do_idle+0x220/0x284
  hardirqs last disabled at (63878): [<ffff80008132f3a4>] 
el1_brk64+0x1c/0x54
  softirqs last  enabled at (63812): [<ffff8000800c1164>] 
handle_softirqs+0x4c4/0x4dc
  softirqs last disabled at (63807): [<ffff800080010690>] 
__do_softirq+0x14/0x20

  other info that might help us debug this:
   Possible unsafe locking scenario:

         CPU0
         ----
    lock(&port_lock_key);
    <Interrupt>
      lock(&port_lock_key);

   *** DEADLOCK ***

  5 locks held by swapper/7/0:
   #0: ffff800082d0aa98 (console_lock){+.+.}-{0:0}, at: 
vprintk_emit+0x150/0x39c
   #1: ffff800082d0aaf0 (console_srcu){....}-{0:0}, at: 
console_flush_all+0x78/0x49c
   #2: ffff800082d0acb0 (console_owner){+.-.}-{0:0}, at: 
console_lock_spinning_enable+0x48/0x7c
   #3: ffff800082d0acd8 
(printk_legacy_map-wait-type-override){+...}-{4:4}, at: 
console_flush_all+0x2b0/0x49c
   #4: ffff800083e479c0 (&port_lock_key){?.-.}-{3:3}, at: 
s3c24xx_serial_console_write+0x80/0x268

  stack backtrace:
  CPU: 7 UID: 0 PID: 0 Comm: swapper/7 Not tainted 6.17.0-rc6+ #16014 
PREEMPT
  Hardware name: Samsung TM2E board (DT)
  Call trace:
   show_stack+0x18/0x24 (C)
   dump_stack_lvl+0x90/0xd0
   dump_stack+0x18/0x24
   print_usage_bug.part.0+0x29c/0x358
   mark_lock+0x7bc/0x960
   mark_held_locks+0x58/0x90
   lockdep_hardirqs_on_prepare+0x104/0x214
   trace_hardirqs_on+0x58/0x1d8
   secondary_start_kernel+0x134/0x160
   __secondary_switched+0xc0/0xc4
  ------------[ cut here ]------------
  WARNING: CPU: 7 PID: 0 at kernel/context_tracking.c:127 
ct_kernel_exit.constprop.0+0x120/0x184
  Modules linked in: brcmfmac_wcc brcmfmac brcmutil sha256 
cpufreq_powersave cpufreq_conservative cfg80211 snd_soc_tm2_wm5110 
hci_uart btqca btbcm s3fwrn5_i2c snd_soc_wm5110 bluetooth 
arizona_micsupp phy_exynos5_usbdrd s3fwrn5 s5p_mfc nci typec 
snd_soc_wm_adsp s5p_jpeg cs_dsp nfc ecdh_generic max77693_haptic 
snd_soc_arizona arizona_ldo1 ecc rfkill snd_soc_i2s snd_soc_idma 
snd_soc_max98504 snd_soc_hdmi_c

(no more messages, system frozen)

It looks that offlining CPUs 1-7 was successful (there is a prompt char 
in the second line), but then CPU7 got somehow onlined again, what 
causes this freeze.

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland


