Return-Path: <linux-tip-commits+bounces-6708-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BDF95B93A19
	for <lists+linux-tip-commits@lfdr.de>; Tue, 23 Sep 2025 01:47:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 669652E0498
	for <lists+linux-tip-commits@lfdr.de>; Mon, 22 Sep 2025 23:47:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 938CF284898;
	Mon, 22 Sep 2025 23:47:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YCf/vfVt"
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4E5E275AF0
	for <linux-tip-commits@vger.kernel.org>; Mon, 22 Sep 2025 23:47:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758584828; cv=none; b=BSeRHahMGISdDgnt1RD4NZuwtbcdh50+6hEBAzHPw9641MunhLu8sPdBc83IwAp9oPnF/RFbbAD8xl/1jFV8WQqS72VtnK8MQTiLTFlINkoIxfar5UkcR5Ljy2qikTlsDzCR2npS0dhc2duooSkzIODnn2Q8OKjQfw2YGI7zchc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758584828; c=relaxed/simple;
	bh=vsvV9sYNxEd02bmok0zF1waXQhU8SOkKencLbjUyUb4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=F0vhqy3f1qAn1nTE+I8LclN5hflMFNDmVaq3PWNfE/BrjQ34TR61knDQstgT0w+c6rSDFjqrPL+5G2MzMB8FB2q8TxRXiBoTo8Czgb+PVk+dT2Rb7Z8TBp4ZLQ8ABlb6UNIiEVYAgvJoIi8dRS4OxlM7se2V1sJzxYGl+Fp1+0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YCf/vfVt; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-57d5ccd73dfso1815290e87.0
        for <linux-tip-commits@vger.kernel.org>; Mon, 22 Sep 2025 16:47:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758584825; x=1759189625; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UkYh1XrLqqJbB+K/z5F50jXY00Z8o2PU/kbVGNOHYjQ=;
        b=YCf/vfVtpUS70I5Ged9UvIJpaKPLH/pstkil5WENVgcHxcZ1o0a+Xro7gPl/ErlYwt
         GT5xi8ARFGJTEoAqK7z4XhfrUxmgaAardSnQ41wFoAc42phg3WU/CZTXNCFCozEAtgeC
         A6XoqMGTJSW4tCF2ll3B1X1GSOyeiNTY2YO/OHDuGJ6VQZXfQXE3SQg4CAy4C7NpIPFx
         9nR0idJvLe6nMLA2muEo/9knVIkrtgq8Uniutq8/iHou3VUl8Dvefi89Og6BRWENVGSy
         0XmnRZURnUFzqhjPgazaBSpSFem+drJJaTCtKhEDhBSBNiWdqe9jL0REtdCIyfSejWsj
         Zryw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758584825; x=1759189625;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UkYh1XrLqqJbB+K/z5F50jXY00Z8o2PU/kbVGNOHYjQ=;
        b=BDGGWC3KokKrJnKBaxTPi2ce3L0K/K5ZKaSXH85Hn7c2tOHLSbzH8gkNZkLogjdLXf
         rEmLavjXZNVeEIoGfona0eaCupxYctcLLh9H5EATHKXg7PZKm1U36XbKD60NCpGFhqCQ
         zgpCTvE2z6SoWHXx4nCj1dyGovaWu6f59YSd6/S1fMqCq0/AFHzUbL2oPaGr6AM3GZBR
         rFHn9xDYB4CyQLW7S+YKQ2KT8jy43EKsgQZh8cpMjmx152BGiDehc4arNY8l2k+qJIvk
         mXFPyIpHu30hAAxg/f6VA/31KjhX/SpRIyjvWLpWn9IEBImCIQ/0DICW+FUjJDYd5gxb
         uPRQ==
X-Forwarded-Encrypted: i=1; AJvYcCXHg8BYYOnu3nL/rvcPRJHbmRZw0rw+fi45rDhQ5Jkk6qdJmFuhflUOYYbMTju67A16zrSI5zP1yftnhn4YGTztWw==@vger.kernel.org
X-Gm-Message-State: AOJu0YyevhgzGylWgIhKmPZ/xWJM4Bq13LE1ir9xg9wi6sTCs2QMPR9M
	ireSOTwJa8k3t7ZMOb2PzrbQBRdcwpbvAkzjJoX2OSOc6S1qjeWhcM8AstzlKllivgmcyf7INt2
	p8BpsovV3bOWsi2RluAenBb35mI84opwJuUOo7YE=
X-Gm-Gg: ASbGnctbfKZhh1+gH+pXm50u2KBZVPFvkaqnCmDnOuTpbkn353ovgGi2kkntSJd2mLs
	ZozhMIR1veE6WDflqSAmZ2nT6RzDtfSbRxWRJqdiM/7uVhlBhz4bgUxRQ8dsJNYgxE4x4441wZD
	z6HUS419Q6EyveFjXlbf1WcYe18EVoupEp9O6KEr2itwTBOXmpk7m+7/I3B+xj/X3pyncxaeFJU
	LOSBug6BiIjmb5g0fOztqwMnksUiWPbAgwh
X-Google-Smtp-Source: AGHT+IFpHPGrNQ+FpH6chnuwZ3/y3GcFnspmffPcZmo2uSG/gDUbbt23gHiiBBNGHkMBwUrBVenMMvXDvpvg59FMKEw=
X-Received: by 2002:a05:6512:4007:b0:55f:4f1f:93fa with SMTP id
 2adb3069b0e04-580735ff0c7mr110448e87.42.1758584824691; Mon, 22 Sep 2025
 16:47:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250916110155.GH3245006@noisy.programming.kicks-ass.net>
 <CGME20250922215704eucas1p1f53a65a5cd1eafd3e0db006653231efd@eucas1p1.samsung.com>
 <175817861820.709179.10538516755307778527.tip-bot2@tip-bot2> <e56310b5-f7a9-4fad-b79a-dcbcdd3d3883@samsung.com>
In-Reply-To: <e56310b5-f7a9-4fad-b79a-dcbcdd3d3883@samsung.com>
From: John Stultz <jstultz@google.com>
Date: Mon, 22 Sep 2025 16:46:52 -0700
X-Gm-Features: AS18NWAfDev1AP7TODzSXAmyJmYli1vtB_9VPgq30LevCm0dpHpVmjj9u4t-nL4
Message-ID: <CANDhNCrztM1eK-6dab_-4hnX4miJH_pe49r=GVVqtD+Z235kgw@mail.gmail.com>
Subject: Re: [tip: sched/urgent] sched/deadline: Fix dl_server getting stuck
To: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: linux-kernel@vger.kernel.org, linux-tip-commits@vger.kernel.org, 
	"Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org, 
	Linux Samsung SOC <linux-samsung-soc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 22, 2025 at 2:57=E2=80=AFPM Marek Szyprowski
<m.szyprowski@samsung.com> wrote:
> This patch landed in today's linux-next as commit 077e1e2e0015
> ("sched/deadline: Fix dl_server getting stuck"). In my tests I found
> that it breaks CPU hotplug on some of my systems. On 64bit
> Exynos5433-based TM2e board I've captured the following lock dep warning
> (which unfortunately doesn't look like really related to CPU hotplug):
>

Huh. Nor does it really look related to the dl_server change. Interesting..=
.


> # for i in /sys/devices/system/cpu/cpu[1-9]; do echo 0 >$i/online; done
> Detected VIPT I-cache on CPU7
> CPU7: Booted secondary processor 0x0000000101 [0x410fd031]
> ------------[ cut here ]------------
> WARNING: CPU: 7 PID: 0 at kernel/rcu/tree.c:4329
> rcutree_report_cpu_starting+0x1e8/0x348
> Modules linked in: brcmfmac_wcc cpufreq_powersave cpufreq_conservative
> brcmfmac brcmutil sha256 snd_soc_wm5110 cfg80211 snd_soc_wm_adsp cs_dsp
> snd_soc_tm2_wm5110 snd_soc_arizona arizona_micsupp phy_exynos5_usbdrd
> s5p_mfc typec arizona_ldo1 hci_uart btqca s5p_jpeg max77693_haptic btbcm
> s3fwrn5_i2c exynos_gsc bluetooth s3fwrn5 nci v4l2_mem2mem nfc
> snd_soc_i2s snd_soc_idma snd_soc_hdmi_codec snd_soc_max98504
> snd_soc_s3c_dma videobuf2_dma_contig videobuf2_memops ecdh_generic
> snd_soc_core ir_spi videobuf2_v4l2 ecc snd_compress ntc_thermistor
> panfrost videodev snd_pcm_dmaengine snd_pcm rfkill drm_shmem_helper
> panel_samsung_s6e3ha2 videobuf2_common backlight pwrseq_core gpu_sched
> mc snd_timer snd soundcore ipv6
> CPU: 7 UID: 0 PID: 0 Comm: swapper/7 Not tainted 6.17.0-rc6+ #16012 PREEM=
PT
> Hardware name: Samsung TM2E board (DT)
> Hardware name: Samsung TM2E board (DT)
> Detected VIPT I-cache on CPU7
>
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D
> WARNING: possible circular locking dependency detected
> 6.17.0-rc6+ #16012 Not tainted
> ------------------------------------------------------
> swapper/7/0 is trying to acquire lock:
> ffff000024021cc8 (&irq_desc_lock_class){-.-.}-{2:2}, at:
> __irq_get_desc_lock+0x5c/0x9c
>
> but task is already holding lock:
> ffff800083e479c0 (&port_lock_key){-.-.}-{3:3}, at:
> s3c24xx_serial_console_write+0x80/0x268
>
> which lock already depends on the new lock.
>
>
> the existing dependency chain (in reverse order) is:
>
> -> #2 (&port_lock_key){-.-.}-{3:3}:
>         _raw_spin_lock_irqsave+0x60/0x88
>         s3c24xx_serial_console_write+0x80/0x268
>         console_flush_all+0x304/0x49c
>         console_unlock+0x70/0x110
>         vprintk_emit+0x254/0x39c
>         vprintk_default+0x38/0x44
>         vprintk+0x28/0x34
>         _printk+0x5c/0x84
>         register_console+0x3ac/0x4f8
>         serial_core_register_port+0x6c4/0x7a4
>         serial_ctrl_register_port+0x10/0x1c
>         uart_add_one_port+0x10/0x1c
>         s3c24xx_serial_probe+0x34c/0x6d8
>         platform_probe+0x5c/0xac
>         really_probe+0xbc/0x298
>         __driver_probe_device+0x78/0x12c
>         driver_probe_device+0xdc/0x164
>         __device_attach_driver+0xb8/0x138
>         bus_for_each_drv+0x80/0xdc
>         __device_attach+0xa8/0x1b0
>         device_initial_probe+0x14/0x20
>         bus_probe_device+0xb0/0xb4
>         deferred_probe_work_func+0x8c/0xc8
>         process_one_work+0x208/0x60c
>         worker_thread+0x244/0x388
>         kthread+0x150/0x228
>         ret_from_fork+0x10/0x20
>
> -> #1 (console_owner){..-.}-{0:0}:
>         console_lock_spinning_enable+0x6c/0x7c
>         console_flush_all+0x2c8/0x49c
>         console_unlock+0x70/0x110
>         vprintk_emit+0x254/0x39c
>         vprintk_default+0x38/0x44
>         vprintk+0x28/0x34
>         _printk+0x5c/0x84
>         exynos_wkup_irq_set_wake+0x80/0xa4
>         irq_set_irq_wake+0x164/0x1e0
>         arizona_irq_set_wake+0x18/0x24
>         irq_set_irq_wake+0x164/0x1e0
>         regmap_irq_sync_unlock+0x328/0x530
>         __irq_put_desc_unlock+0x48/0x4c
>         irq_set_irq_wake+0x84/0x1e0
>         arizona_set_irq_wake+0x5c/0x70
>         wm5110_probe+0x220/0x354 [snd_soc_wm5110]
>         platform_probe+0x5c/0xac
>         really_probe+0xbc/0x298
>         __driver_probe_device+0x78/0x12c
>         driver_probe_device+0xdc/0x164
>         __driver_attach+0x9c/0x1ac
>         bus_for_each_dev+0x74/0xd0
>         driver_attach+0x24/0x30
>         bus_add_driver+0xe4/0x208
>         driver_register+0x60/0x128
>         __platform_driver_register+0x24/0x30
>         cs_exit+0xc/0x20 [cpufreq_conservative]
>         do_one_initcall+0x64/0x308
>         do_init_module+0x58/0x23c
>         load_module+0x1b48/0x1dc4
>         init_module_from_file+0x84/0xc4
>         idempotent_init_module+0x188/0x280
>         __arm64_sys_finit_module+0x68/0xac
>         invoke_syscall+0x48/0x110
>         el0_svc_.common.c
>
> (system is frozen at this point).

So I've seen issues like this when testing scheduler changes,
particularly when I've added debug printks or WARN_ONs that trip while
we're deep in the scheduler core and hold various locks. I reported
something similar here:
https://lore.kernel.org/lkml/CANDhNCo8NRm4meR7vHqvP8vVZ-_GXVPuUKSO1wUQkKdfj=
vy20w@mail.gmail.com/

Now, usually I'll see the lockdep warning, and the hang is much more rare.

But I don't see right off how the dl_server change would affect this,
other than just changing the timing of execution such that you manage
to trip over the existing issue.

So far I don't see anything similar testing hotplug on x86 qemu.  Do
you get any other console messages or warnings prior?

Looking at the backtrace, I wonder if changing the pr_info() in
exynos_wkup_irq_set_wake() to printk_deferred() might avoid this?

thanks
-john

