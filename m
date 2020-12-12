Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BDBB82D8682
	for <lists+linux-tip-commits@lfdr.de>; Sat, 12 Dec 2020 14:00:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438915AbgLLM7v (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Sat, 12 Dec 2020 07:59:51 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:41358 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2438900AbgLLM7e (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Sat, 12 Dec 2020 07:59:34 -0500
Date:   Sat, 12 Dec 2020 12:58:49 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1607777930;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xb50bC384Gh0N1YAdlCc/SC04i30JCuqOF7GLdQ2jzk=;
        b=eYETH4KB9exwv0I8O7LGSSivZpUp6xtW9ztRKmIgH25pZ15S+UM0zQpc/HiQa4Eo4l6PrP
        MLnywf7WRFhejJzmQZZW2GY1TYzmZkghi++bzDjmwkleVwLmibxy3LkES3/eNL76VBnqlE
        rlS8wQpq01c5QUZ+Rx5Ym3W9o+C0j5VXCSTzLGzgv0U9PG9FBzzI0beO7hV78sua2YHX5E
        cCb7rTU0VMfSkCeBD1YxX7HNnMr58/AmRaATRfM8m0YH1W6MGg377zXQjQ45ro16sabrIs
        7sY/hgU6e+OEic6iDDVTFFUgdAjzMqHHjPTV9NOXXl88n2kgCTxMVKBVuFZpbA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1607777930;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xb50bC384Gh0N1YAdlCc/SC04i30JCuqOF7GLdQ2jzk=;
        b=HKPTi/P4JGlvutqw6g+T2cf0YsfZ5Frqon3Lict0a7EI9JQAidTQDlqjtuSXk1N/uzjm1F
        tDXtKR9NumCC6PDQ==
From:   tip-bot2 for Niklas =?utf-8?q?S=C3=B6derlund?= 
        <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] clocksource/drivers/sh_cmt: Fix potential deadlock
 when calling runtime PM
Cc:     niklas.soderlund+renesas@ragnatech.se,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Daniel Lezcano <daniel.lezcano@linaro.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20201205021921.1456190-2-niklas.soderlund+renesas@ragnatech.se>
References: <20201205021921.1456190-2-niklas.soderlund+renesas@ragnatech.se>
MIME-Version: 1.0
Message-ID: <160777792991.3364.17102704237776774767.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     8ae954caf49ac403c177d117fb8e05cbc866aa3c
Gitweb:        https://git.kernel.org/tip/8ae954caf49ac403c177d117fb8e05cbc86=
6aa3c
Author:        Niklas S=C3=B6derlund <niklas.soderlund+renesas@ragnatech.se>
AuthorDate:    Sat, 05 Dec 2020 03:19:20 +01:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Mon, 07 Dec 2020 20:10:05 +01:00

clocksource/drivers/sh_cmt: Fix potential deadlock when calling runtime PM

The ch->lock is used to protect the whole enable() and read() of
sh_cmt's implementation of struct clocksource. The enable()
implementation calls pm_runtime_get_sync() which may result in the clock
source to be read() triggering a cyclic lockdep warning for the
ch->lock.

The sh_cmt driver implement its own balancing of calls to
sh_cmt_{enable,disable}() with flags in sh_cmt_{start,stop}(). It does
this to deal with that start and stop are shared between the clock
source and clock event providers. While this could be improved on
verifying corner cases based on any substantial rework on all devices
this driver supports might prove hard.

As a first step separate the PM handling for clock event and clock
source. Always put/get the device when enabling/disabling the clock
source but keep the clock event logic unchanged. This allows the sh_cmt
implementation of struct clocksource to call PM without holding the
ch->lock and avoiding the deadlock.

Triggering and log of the deadlock warning,

  # echo e60f0000.timer > /sys/devices/system/clocksource/clocksource0/curren=
t_clocksource
  [   46.948370] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D
  [   46.954730] WARNING: possible circular locking dependency detected
  [   46.961094] 5.10.0-rc6-arm64-renesas-00001-g0e5fd7414e8b #36 Not tainted
  [   46.967985] ------------------------------------------------------
  [   46.974342] migration/0/11 is trying to acquire lock:
  [   46.979543] ffff0000403ed220 (&dev->power.lock){-...}-{2:2}, at: __pm_ru=
ntime_resume+0x40/0x74
  [   46.988445]
  [   46.988445] but task is already holding lock:
  [   46.994441] ffff000040ad0298 (&ch->lock){....}-{2:2}, at: sh_cmt_start+0=
x28/0x210
  [   47.002173]
  [   47.002173] which lock already depends on the new lock.
  [   47.002173]
  [   47.010573]
  [   47.010573] the existing dependency chain (in reverse order) is:
  [   47.018262]
  [   47.018262] -> #3 (&ch->lock){....}-{2:2}:
  [   47.024033]        lock_acquire.part.0+0x120/0x330
  [   47.028970]        lock_acquire+0x64/0x80
  [   47.033105]        _raw_spin_lock_irqsave+0x7c/0xc4
  [   47.038130]        sh_cmt_start+0x28/0x210
  [   47.042352]        sh_cmt_clocksource_enable+0x28/0x50
  [   47.047644]        change_clocksource+0x9c/0x160
  [   47.052402]        multi_cpu_stop+0xa4/0x190
  [   47.056799]        cpu_stopper_thread+0x90/0x154
  [   47.061557]        smpboot_thread_fn+0x244/0x270
  [   47.066310]        kthread+0x154/0x160
  [   47.070175]        ret_from_fork+0x10/0x20
  [   47.074390]
  [   47.074390] -> #2 (tk_core.seq.seqcount){----}-{0:0}:
  [   47.081136]        lock_acquire.part.0+0x120/0x330
  [   47.086070]        lock_acquire+0x64/0x80
  [   47.090203]        seqcount_lockdep_reader_access.constprop.0+0x74/0x100
  [   47.097096]        ktime_get+0x28/0xa0
  [   47.100960]        hrtimer_start_range_ns+0x210/0x2dc
  [   47.106164]        generic_sched_clock_init+0x70/0x88
  [   47.111364]        sched_clock_init+0x40/0x64
  [   47.115853]        start_kernel+0x494/0x524
  [   47.120156]
  [   47.120156] -> #1 (hrtimer_bases.lock){-.-.}-{2:2}:
  [   47.126721]        lock_acquire.part.0+0x120/0x330
  [   47.136042]        lock_acquire+0x64/0x80
  [   47.144461]        _raw_spin_lock_irqsave+0x7c/0xc4
  [   47.153721]        hrtimer_start_range_ns+0x68/0x2dc
  [   47.163054]        rpm_suspend+0x308/0x5dc
  [   47.171473]        rpm_idle+0xc4/0x2a4
  [   47.179550]        pm_runtime_work+0x98/0xc0
  [   47.188209]        process_one_work+0x294/0x6f0
  [   47.197142]        worker_thread+0x70/0x45c
  [   47.205661]        kthread+0x154/0x160
  [   47.213673]        ret_from_fork+0x10/0x20
  [   47.221957]
  [   47.221957] -> #0 (&dev->power.lock){-...}-{2:2}:
  [   47.236292]        check_noncircular+0x128/0x140
  [   47.244907]        __lock_acquire+0x13b0/0x204c
  [   47.253332]        lock_acquire.part.0+0x120/0x330
  [   47.262033]        lock_acquire+0x64/0x80
  [   47.269826]        _raw_spin_lock_irqsave+0x7c/0xc4
  [   47.278430]        __pm_runtime_resume+0x40/0x74
  [   47.286758]        sh_cmt_start+0x84/0x210
  [   47.294537]        sh_cmt_clocksource_enable+0x28/0x50
  [   47.303449]        change_clocksource+0x9c/0x160
  [   47.311783]        multi_cpu_stop+0xa4/0x190
  [   47.319720]        cpu_stopper_thread+0x90/0x154
  [   47.328022]        smpboot_thread_fn+0x244/0x270
  [   47.336298]        kthread+0x154/0x160
  [   47.343708]        ret_from_fork+0x10/0x20
  [   47.351445]
  [   47.351445] other info that might help us debug this:
  [   47.351445]
  [   47.370225] Chain exists of:
  [   47.370225]   &dev->power.lock --> tk_core.seq.seqcount --> &ch->lock
  [   47.370225]
  [   47.392003]  Possible unsafe locking scenario:
  [   47.392003]
  [   47.405314]        CPU0                    CPU1
  [   47.413569]        ----                    ----
  [   47.421768]   lock(&ch->lock);
  [   47.428425]                                lock(tk_core.seq.seqcount);
  [   47.438701]                                lock(&ch->lock);
  [   47.447930]   lock(&dev->power.lock);
  [   47.455172]
  [   47.455172]  *** DEADLOCK ***
  [   47.455172]
  [   47.471433] 3 locks held by migration/0/11:
  [   47.479099]  #0: ffff8000113c9278 (timekeeper_lock){-.-.}-{2:2}, at: cha=
nge_clocksource+0x2c/0x160
  [   47.491834]  #1: ffff8000113c8f88 (tk_core.seq.seqcount){----}-{0:0}, at=
: multi_cpu_stop+0xa4/0x190
  [   47.504727]  #2: ffff000040ad0298 (&ch->lock){....}-{2:2}, at: sh_cmt_st=
art+0x28/0x210
  [   47.516541]
  [   47.516541] stack backtrace:
  [   47.528480] CPU: 0 PID: 11 Comm: migration/0 Not tainted 5.10.0-rc6-arm6=
4-renesas-00001-g0e5fd7414e8b #36
  [   47.542147] Hardware name: Renesas Salvator-X 2nd version board based on=
 r8a77965 (DT)
  [   47.554241] Call trace:
  [   47.560832]  dump_backtrace+0x0/0x190
  [   47.568670]  show_stack+0x14/0x30
  [   47.576144]  dump_stack+0xe8/0x130
  [   47.583670]  print_circular_bug+0x1f0/0x200
  [   47.592015]  check_noncircular+0x128/0x140
  [   47.600289]  __lock_acquire+0x13b0/0x204c
  [   47.608486]  lock_acquire.part.0+0x120/0x330
  [   47.616953]  lock_acquire+0x64/0x80
  [   47.624582]  _raw_spin_lock_irqsave+0x7c/0xc4
  [   47.633114]  __pm_runtime_resume+0x40/0x74
  [   47.641371]  sh_cmt_start+0x84/0x210
  [   47.649115]  sh_cmt_clocksource_enable+0x28/0x50
  [   47.657916]  change_clocksource+0x9c/0x160
  [   47.666165]  multi_cpu_stop+0xa4/0x190
  [   47.674056]  cpu_stopper_thread+0x90/0x154
  [   47.682308]  smpboot_thread_fn+0x244/0x270
  [   47.690560]  kthread+0x154/0x160
  [   47.697927]  ret_from_fork+0x10/0x20
  [   47.708447] clocksource: Switched to clocksource e60f0000.timer

Signed-off-by: Niklas S=C3=B6derlund <niklas.soderlund+renesas@ragnatech.se>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Link: https://lore.kernel.org/r/20201205021921.1456190-2-niklas.soderlund+ren=
esas@ragnatech.se
---
 drivers/clocksource/sh_cmt.c | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/drivers/clocksource/sh_cmt.c b/drivers/clocksource/sh_cmt.c
index 7607774..19fa3ef 100644
--- a/drivers/clocksource/sh_cmt.c
+++ b/drivers/clocksource/sh_cmt.c
@@ -319,7 +319,6 @@ static int sh_cmt_enable(struct sh_cmt_channel *ch)
 {
 	int k, ret;
=20
-	pm_runtime_get_sync(&ch->cmt->pdev->dev);
 	dev_pm_syscore_device(&ch->cmt->pdev->dev, true);
=20
 	/* enable clock */
@@ -394,7 +393,6 @@ static void sh_cmt_disable(struct sh_cmt_channel *ch)
 	clk_disable(ch->cmt->clk);
=20
 	dev_pm_syscore_device(&ch->cmt->pdev->dev, false);
-	pm_runtime_put(&ch->cmt->pdev->dev);
 }
=20
 /* private flags */
@@ -562,10 +560,16 @@ static int sh_cmt_start(struct sh_cmt_channel *ch, unsi=
gned long flag)
 	int ret =3D 0;
 	unsigned long flags;
=20
+	if (flag & FLAG_CLOCKSOURCE)
+		pm_runtime_get_sync(&ch->cmt->pdev->dev);
+
 	raw_spin_lock_irqsave(&ch->lock, flags);
=20
-	if (!(ch->flags & (FLAG_CLOCKEVENT | FLAG_CLOCKSOURCE)))
+	if (!(ch->flags & (FLAG_CLOCKEVENT | FLAG_CLOCKSOURCE))) {
+		if (flag & FLAG_CLOCKEVENT)
+			pm_runtime_get_sync(&ch->cmt->pdev->dev);
 		ret =3D sh_cmt_enable(ch);
+	}
=20
 	if (ret)
 		goto out;
@@ -590,14 +594,20 @@ static void sh_cmt_stop(struct sh_cmt_channel *ch, unsi=
gned long flag)
 	f =3D ch->flags & (FLAG_CLOCKEVENT | FLAG_CLOCKSOURCE);
 	ch->flags &=3D ~flag;
=20
-	if (f && !(ch->flags & (FLAG_CLOCKEVENT | FLAG_CLOCKSOURCE)))
+	if (f && !(ch->flags & (FLAG_CLOCKEVENT | FLAG_CLOCKSOURCE))) {
 		sh_cmt_disable(ch);
+		if (flag & FLAG_CLOCKEVENT)
+			pm_runtime_put(&ch->cmt->pdev->dev);
+	}
=20
 	/* adjust the timeout to maximum if only clocksource left */
 	if ((flag =3D=3D FLAG_CLOCKEVENT) && (ch->flags & FLAG_CLOCKSOURCE))
 		__sh_cmt_set_next(ch, ch->max_match_value);
=20
 	raw_spin_unlock_irqrestore(&ch->lock, flags);
+
+	if (flag & FLAG_CLOCKSOURCE)
+		pm_runtime_put(&ch->cmt->pdev->dev);
 }
=20
 static struct sh_cmt_channel *cs_to_sh_cmt(struct clocksource *cs)
