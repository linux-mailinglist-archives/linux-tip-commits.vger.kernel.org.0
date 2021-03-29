Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F33434D2B4
	for <lists+linux-tip-commits@lfdr.de>; Mon, 29 Mar 2021 16:48:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230503AbhC2OsO (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Mon, 29 Mar 2021 10:48:14 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:36982 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230458AbhC2Orw (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Mon, 29 Mar 2021 10:47:52 -0400
Date:   Mon, 29 Mar 2021 14:47:50 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1617029271;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wa+sRZ4sGSeVGsYB7uNtnMZEQ+fIBNm2H04krQ3CBeQ=;
        b=bG2U4Z29/bwQUtb2KstFTXZEbm6MQFQHao/jVkT4tNw0dZmEuTCuzqxA18ApQnEkftnM9f
        gtC+ArbfO+7BQ4gYPHrJzUC5eqrc9Gw1f/UnicfP6zJjY02BcbB94jmTgNeQ2F1pv7F9HQ
        8eBbIgSlDVpS0m1hKBv92f8DJ/PHMVzWbHTt/aUTzIqyr1l76GPZNTnHFev/acsHshzmMh
        ItHGYsCBvjY7N/81YUI1tZVxUiXTjZs5aQB4uI2LZvBaJx2zaw8NtZW7RvQck8nxOdaYbl
        vQL7lHEmZjvvo8+Wd4OnL5JVqRQ/eTaf8OWwJ7iXsG4y3nJW0wCArjEHA5p9FA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1617029271;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wa+sRZ4sGSeVGsYB7uNtnMZEQ+fIBNm2H04krQ3CBeQ=;
        b=DgAxOTlUuJBGC71OzuM26fnSCiAMQTp83OIrOZvsIwhRQXwNpT71VoyWKRaPdh58f+JH85
        o/ovApGj7N0QA5Bg==
From:   tip-bot2 for Niklas =?utf-8?q?S=C3=B6derlund?= 
        <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] timekeeping: Allow runtime PM from change_clocksource()
Cc:     niklas.soderlund+renesas@ragnatech.se,
        Thomas Gleixner <tglx@linutronix.de>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20210211134318.323910-1-niklas.soderlund+renesas@ragnatech.se>
References: <20210211134318.323910-1-niklas.soderlund+renesas@ragnatech.se>
MIME-Version: 1.0
Message-ID: <161702927044.29796.127875993811870866.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     d4c7c28806616809e3baa0b7cd8c665516b2726d
Gitweb:        https://git.kernel.org/tip/d4c7c28806616809e3baa0b7cd8c665516b=
2726d
Author:        Niklas S=C3=B6derlund <niklas.soderlund+renesas@ragnatech.se>
AuthorDate:    Thu, 11 Feb 2021 14:43:18 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Mon, 29 Mar 2021 16:41:59 +02:00

timekeeping: Allow runtime PM from change_clocksource()

The struct clocksource callbacks enable() and disable() are described as a
way to allow clock sources to enter a power save mode. See commit
4614e6adafa2 ("clocksource: add enable() and disable() callbacks")

But using runtime PM from these callbacks triggers a cyclic lockdep warning w=
hen
switching clock source using change_clocksource().

  # echo e60f0000.timer > /sys/devices/system/clocksource/clocksource0/curren=
t_clocksource
   =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D
   WARNING: possible circular locking dependency detected
   ------------------------------------------------------
   migration/0/11 is trying to acquire lock:
   ffff0000403ed220 (&dev->power.lock){-...}-{2:2}, at: __pm_runtime_resume+0=
x40/0x74

   but task is already holding lock:
   ffff8000113c8f88 (tk_core.seq.seqcount){----}-{0:0}, at: multi_cpu_stop+0x=
a4/0x190

   which lock already depends on the new lock.

   the existing dependency chain (in reverse order) is:

   -> #2 (tk_core.seq.seqcount){----}-{0:0}:
          ktime_get+0x28/0xa0
          hrtimer_start_range_ns+0x210/0x2dc
          generic_sched_clock_init+0x70/0x88
          sched_clock_init+0x40/0x64
          start_kernel+0x494/0x524

   -> #1 (hrtimer_bases.lock){-.-.}-{2:2}:
          hrtimer_start_range_ns+0x68/0x2dc
          rpm_suspend+0x308/0x5dc
          rpm_idle+0xc4/0x2a4
          pm_runtime_work+0x98/0xc0
          process_one_work+0x294/0x6f0
          worker_thread+0x70/0x45c
          kthread+0x154/0x160
          ret_from_fork+0x10/0x20

   -> #0 (&dev->power.lock){-...}-{2:2}:
          _raw_spin_lock_irqsave+0x7c/0xc4
          __pm_runtime_resume+0x40/0x74
          sh_cmt_start+0x1c4/0x260
          sh_cmt_clocksource_enable+0x28/0x50
          change_clocksource+0x9c/0x160
          multi_cpu_stop+0xa4/0x190
          cpu_stopper_thread+0x90/0x154
          smpboot_thread_fn+0x244/0x270
          kthread+0x154/0x160
          ret_from_fork+0x10/0x20

   other info that might help us debug this:

   Chain exists of:
     &dev->power.lock --> hrtimer_bases.lock --> tk_core.seq.seqcount

    Possible unsafe locking scenario:

          CPU0                    CPU1
          ----                    ----
     lock(tk_core.seq.seqcount);
                                  lock(hrtimer_bases.lock);
                                  lock(tk_core.seq.seqcount);
     lock(&dev->power.lock);

    *** DEADLOCK ***

   2 locks held by migration/0/11:
    #0: ffff8000113c9278 (timekeeper_lock){-.-.}-{2:2}, at: change_clocksourc=
e+0x2c/0x160
    #1: ffff8000113c8f88 (tk_core.seq.seqcount){----}-{0:0}, at: multi_cpu_st=
op+0xa4/0x190

Rework change_clocksource() so it enables the new clocksource and disables
the old clocksource outside of the timekeeper_lock and seqcount write held
region. There is no requirement that these callbacks are invoked from the
lock held region.

Signed-off-by: Niklas S=C3=B6derlund <niklas.soderlund+renesas@ragnatech.se>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Link: https://lore.kernel.org/r/20210211134318.323910-1-niklas.soderlund+rene=
sas@ragnatech.se
---
 kernel/time/timekeeping.c | 36 +++++++++++++++++++++++-------------
 1 file changed, 23 insertions(+), 13 deletions(-)

diff --git a/kernel/time/timekeeping.c b/kernel/time/timekeeping.c
index 77bafd8..81fe2a3 100644
--- a/kernel/time/timekeeping.c
+++ b/kernel/time/timekeeping.c
@@ -1427,35 +1427,45 @@ static void __timekeeping_set_tai_offset(struct timek=
eeper *tk, s32 tai_offset)
 static int change_clocksource(void *data)
 {
 	struct timekeeper *tk =3D &tk_core.timekeeper;
-	struct clocksource *new, *old;
+	struct clocksource *new, *old =3D NULL;
 	unsigned long flags;
+	bool change =3D false;
=20
 	new =3D (struct clocksource *) data;
=20
-	raw_spin_lock_irqsave(&timekeeper_lock, flags);
-	write_seqcount_begin(&tk_core.seq);
-
-	timekeeping_forward_now(tk);
 	/*
 	 * If the cs is in module, get a module reference. Succeeds
 	 * for built-in code (owner =3D=3D NULL) as well.
 	 */
 	if (try_module_get(new->owner)) {
-		if (!new->enable || new->enable(new) =3D=3D 0) {
-			old =3D tk->tkr_mono.clock;
-			tk_setup_internals(tk, new);
-			if (old->disable)
-				old->disable(old);
-			module_put(old->owner);
-		} else {
+		if (!new->enable || new->enable(new) =3D=3D 0)
+			change =3D true;
+		else
 			module_put(new->owner);
-		}
 	}
+
+	raw_spin_lock_irqsave(&timekeeper_lock, flags);
+	write_seqcount_begin(&tk_core.seq);
+
+	timekeeping_forward_now(tk);
+
+	if (change) {
+		old =3D tk->tkr_mono.clock;
+		tk_setup_internals(tk, new);
+	}
+
 	timekeeping_update(tk, TK_CLEAR_NTP | TK_MIRROR | TK_CLOCK_WAS_SET);
=20
 	write_seqcount_end(&tk_core.seq);
 	raw_spin_unlock_irqrestore(&timekeeper_lock, flags);
=20
+	if (old) {
+		if (old->disable)
+			old->disable(old);
+
+		module_put(old->owner);
+	}
+
 	return 0;
 }
=20
