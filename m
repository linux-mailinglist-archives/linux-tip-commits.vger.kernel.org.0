Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 867723E9F5D
	for <lists+linux-tip-commits@lfdr.de>; Thu, 12 Aug 2021 09:20:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234686AbhHLHUk (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Thu, 12 Aug 2021 03:20:40 -0400
Received: from mout.gmx.net ([212.227.15.19]:47049 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234586AbhHLHUk (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Thu, 12 Aug 2021 03:20:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1628752788;
        bh=IJXp/tmjDEmO3jMT9VvG9Mo15moxI5P1Ym8vOeAajWc=;
        h=X-UI-Sender-Class:Subject:From:To:Cc:Date:In-Reply-To:References;
        b=CoS6Tm6PUAKop+86C8e7Y6bxMlLky3xfm1uFmiK3SR1fq3H4NmON50ERtEfNH95fs
         +gf5b22v+4U+JJYKWp5W42/V4S5VZin65kW4zgrOvxS7nCAHpJHu5LXOnZ/T2WYfTY
         QYc6p+kNyHT05yWVswCSxGoE34GTKi4SWqlRHw/U=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from homer.fritz.box ([185.191.219.67]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1ML9uK-1mW9qr3ZNy-00IGfc; Thu, 12
 Aug 2021 09:19:47 +0200
Message-ID: <7dfb3b15af67400227e7fa9e1916c8add0374ba9.camel@gmx.de>
Subject: Re: [tip: timers/core] hrtimer: Consolidate reprogramming code
From:   Mike Galbraith <efault@gmx.de>
To:     linux-kernel@vger.kernel.org, linux-tip-commits@vger.kernel.org
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org
Date:   Thu, 12 Aug 2021 09:19:31 +0200
In-Reply-To: <162861133759.395.7795246170325882103.tip-bot2@tip-bot2>
References: <20210713135158.054424875@linutronix.de>
         <162861133759.395.7795246170325882103.tip-bot2@tip-bot2>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.40.3 
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:dU9ZBKlzvGCACFXdfFQSjtm4TGMUO/sR0VDD3jc48WpJnZ9U/uk
 waJtZpDxXpRFVV8XtSwVnLZzF+gcF9ModNHvVudzEKeATc4jNGvQTLfQWNS0bNk5kH+sEfY
 lA+lSrXArQPRdcbxUNZFga4vv9O5sb0CXXi9TOEcDDa6AmAIkfv2ASKXrahQmGbtPd6tBj4
 oGw9m9uUiSaXUTtImvbEg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:oS2RMxMxUGc=:Z2xmg6FGdnb74n6c17Vbm5
 CrOv3Gvnq+/YknsEkqPhvTDAe6u78YAZFCnxxDCpmxCYCFbvFrIf2NABCmBxoIzVPc5/gjPQM
 Jl12U1b/xPZQX6pLJXgBQjd7aYUs5vZ39pACWH22fJDPDdv2wJZw+ql9UP0qbii5QhxgKEbbf
 ZJYcA7+eYn5k02D/uaCDtvYGTcAmACsIPKrePEFcVCBF6NUVQhERRoGIGmNNI0c01p2Ig+2w3
 4hSQ4eOrXL+RsbaPfoRTohzd3GGOpP7B1VoiN3P02IMLi64EHwFoe0sHc7caezVsanZiOcw+3
 UYiTSGOhWzDEZfD1bMD+gjaqO0ok2oRCZUO+5iADhk5O1cuabCZPGeLGMkc0fa5inQ3fxXCnd
 trFQdtQQaqRIimtKnkvLmqw9N/UtEn8OCH6TAAE25v/mMEsle0edYVPqT0d6P6NcPCIP9/x6W
 FkuPKQAC896hxeVJ9iF03m36TFwve2qmah5I3s9TZhebIWkm5HLpyGteFnlJe/qSho08JUvfT
 QKCv24r4Nd3WEpSti9Tg7PAx1qulazJp4ehB5R1Jx3Umvnj39uMt2B4FZq+Ud3vdWajVFNTXB
 mp8t0AYMhWYY+EXxD58czgHDmbR1ll4o0mBGExR1I75pxq0szy27/g1YKJAkOAS/NxJyWjkDo
 F4FvEXy9YehQpLaomn+Hv4Dvz+TJimuTdu2rztXbHqBQ9sa0m51X8WuOe4WzWsWpwn0iUss/n
 Z1fi1f3OeLz9lgLgUTBaE6Iv3V5F8ZINSnjjL+KqhjGsQR0f291qfi14bvh6sVJZIz552JEz1
 frGF/i2vGQts3R2na3i+U4Nt2HIdBwWBiHt8y3WbUD072wE2fHVTjX8acSQUmSth/0L+Um1oV
 9xps1fsXtcibE0e0tScRTxPhfHaICZ+TPhkhrZ2mC7XkN1NTdg4V+3foD5+3DReNqdJVaQOZ0
 5El1JYGAgJXg+d3XBpcdrWe6Ss9MjWRYPxmw98ZNGCbPo0h8/R9OPlV204tzDLJJcoswce0ez
 h6mzclG7mvLnzuyKkzW+Cn1vNiXtnPdcYpTnW+5tJG4BaTC5mL+fmX+YGKFXBwihvlTanJ46r
 3kWRDtjCmmh8P964XhEYG+1qdaBP86Vf0Ec
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

Greetings Peter, may your day get off to a better start than my box's
did :)

On Tue, 2021-08-10 at 16:02 +0000, tip-bot2 for Peter Zijlstra wrote:
> The following commit has been merged into the timers/core branch of tip:
>
> Commit-ID:=C2=A0=C2=A0=C2=A0=C2=A0 b14bca97c9f5c3e3f133445b01c723e95490d=
843
> Gitweb:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 https://git.kernel.org=
/tip/b14bca97c9f5c3e3f133445b01c723e95490d843
> Author:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Peter Zijlstra <peterz=
@infradead.org>
> AuthorDate:=C2=A0=C2=A0=C2=A0 Tue, 13 Jul 2021 15:39:47 +02:00
> Committer:=C2=A0=C2=A0=C2=A0=C2=A0 Thomas Gleixner <tglx@linutronix.de>
> CommitterDate: Tue, 10 Aug 2021 17:57:22 +02:00
>
> hrtimer: Consolidate reprogramming code

Per git-bisect, this is the tip.today commit that's bricking my box
early in boot.  Another inspires the moan below, courtesy of VM, which
unlike desktop box does not brick immediately thereafter.

[    0.556416] rtc_cmos 00:04: RTC can wake from S4
[    0.557184] rtc_cmos 00:04: registered as rtc0
[    0.557636] BUG: using smp_processor_id() in preemptible [00000000] cod=
e: swapper/0/1
[    0.558169] caller is debug_smp_processor_id+0x13/0x20
[    0.558511] CPU: 3 PID: 1 Comm: swapper/0 Not tainted 5.14.0.g1fd628c-t=
ip #15
[    0.558946] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS=
 rel-1.14.0-0-g155821a-rebuilt.opensuse.org 04/01/2014
[    0.559623] Call Trace:
[    0.559796]  dump_stack_lvl+0x62/0x78
[    0.560041]  dump_stack+0xc/0xd
[    0.560263]  check_preemption_disabled+0xd3/0xe0
[    0.560576]  debug_smp_processor_id+0x13/0x20
[    0.560954]  clock_was_set+0x1c/0x310
[    0.561118]  ? timekeeping_update+0x298/0x2b0
[    0.561118]  do_settimeofday64+0x31e/0x340
[    0.561118]  __devm_rtc_register_device+0x371/0x450
[    0.561118]  cmos_do_probe+0x4a2/0x6e0
[    0.561118]  ? cmos_interrupt+0x120/0x120
[    0.561118]  ? cmos_nvram_read+0x90/0x90
[    0.561118]  cmos_pnp_probe+0x91/0xe0
[    0.561118]  pnp_device_probe+0x15e/0x1d0
[    0.561118]  ? cmos_irq_enable+0x150/0x150
[    0.561118]  call_driver_probe+0x4a/0x130
[    0.561118]  really_probe+0x150/0x540
[    0.561118]  __driver_probe_device+0x160/0x200
[    0.561118]  driver_probe_device+0x3a/0x2b0
[    0.561118]  __driver_attach+0xb4/0x370
[    0.561118]  ? driver_attach+0x30/0x30
[    0.561118]  bus_for_each_dev+0xb0/0xe0
[    0.561118]  driver_attach+0x27/0x30
[    0.561118]  bus_add_driver+0x1ba/0x310
[    0.561118]  driver_register+0x104/0x200
[    0.561118]  pnp_register_driver+0x3e/0x50
[    0.561118]  ? rtc_dev_init+0x33/0x33
[    0.561118]  cmos_init+0x14/0xbc
[    0.561118]  ? rtc_dev_init+0x33/0x33
[    0.561118]  do_one_initcall+0xcf/0x2c0
[    0.561118]  ? strlen+0x18/0x30
[    0.561118]  ? parse_one+0x2b9/0x350
[    0.561118]  ? do_initcall_level+0x106/0x106
[    0.561118]  ? parse_args+0x133/0x280
[    0.561118]  ? parse_args+0x94/0x280
[    0.561118]  do_initcall_level+0x95/0x106
[    0.561118]  do_initcalls+0x61/0x8b
[    0.561118]  do_basic_setup+0x20/0x21
[    0.561118]  kernel_init_freeable+0x171/0x1de
[    0.561118]  ? rest_init+0xf0/0xf0
[    0.561118]  kernel_init+0x17/0x1e0
[    0.561118]  ? rest_init+0xf0/0xf0
[    0.561118]  ret_from_fork+0x1f/0x30


