Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32FC42B8F8D
	for <lists+linux-tip-commits@lfdr.de>; Thu, 19 Nov 2020 11:00:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726973AbgKSJzK (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Thu, 19 Nov 2020 04:55:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727014AbgKSJzJ (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Thu, 19 Nov 2020 04:55:09 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65043C0613CF;
        Thu, 19 Nov 2020 01:55:09 -0800 (PST)
Date:   Thu, 19 Nov 2020 09:55:07 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1605779708;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=L4bM8t9gqDftLDFBIXZZGod971ceGNwraKxuAO90pgw=;
        b=xTAiAnzX95wM28NvjUWTZOSatQslr5W5k0aSZrnPidC7slFn6v4qFTmY2I6tewbjWYbXJw
        dfeDk9y5uShJVhFDwoanEutz20W5QvOoHXgL8nyGglZU5VQ+K23qATpEn0AA/XISuamxwv
        TPHt5M+LpTh+rJexeUPOQgdCuvuPWP2xL5pYfm456cqxYXr1S7ukD4CfIcz2pd5tXbbtPq
        s1aH+fr8yfp2+CAzX3WRQW2SolmpBpys9AVe1Kf20A/B7omrcuCkCmmjya1xL66jfSJiy7
        FRLb+cl6GvtVJeYF5dzNPMlKaZOelBU5hj4OqHT5ZPjw+nUhFpZrDHn8/ZFXkw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1605779708;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=L4bM8t9gqDftLDFBIXZZGod971ceGNwraKxuAO90pgw=;
        b=wDfo0dJrSvOLhDqJ/3vJH/R06nA1VPP+FAkeCOMrur/3H/c2jtNpuWE5jhkS0SdFNDVNs3
        UKwbhtXxXUR0wACw==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] tick: Get rid of tick_period
Cc:     Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20201117132006.766643526@linutronix.de>
References: <20201117132006.766643526@linutronix.de>
MIME-Version: 1.0
Message-ID: <160577970711.11244.1754640800834328157.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     b996544916429946bf4934c1c01a306d1690972c
Gitweb:        https://git.kernel.org/tip/b996544916429946bf4934c1c01a306d1690972c
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Tue, 17 Nov 2020 14:19:49 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 19 Nov 2020 10:48:29 +01:00

tick: Get rid of tick_period

The variable tick_period is initialized to NSEC_PER_TICK / HZ during boot
and never updated again.

If NSEC_PER_TICK is not an integer multiple of HZ this computation is less
accurate than TICK_NSEC which has proper rounding in place.

Aside of the inaccuracy there is no reason for having this variable at
all. It's just a pointless indirection and all usage sites can just use the
TICK_NSEC constant.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/20201117132006.766643526@linutronix.de

---
 kernel/time/tick-broadcast.c |  2 +-
 kernel/time/tick-common.c    |  8 +++-----
 kernel/time/tick-internal.h  |  1 -
 kernel/time/tick-sched.c     | 22 +++++++++++-----------
 4 files changed, 15 insertions(+), 18 deletions(-)

diff --git a/kernel/time/tick-broadcast.c b/kernel/time/tick-broadcast.c
index 2a47c8f..5a23829 100644
--- a/kernel/time/tick-broadcast.c
+++ b/kernel/time/tick-broadcast.c
@@ -331,7 +331,7 @@ static void tick_handle_periodic_broadcast(struct clock_event_device *dev)
 	bc_local = tick_do_periodic_broadcast();
 
 	if (clockevent_state_oneshot(dev)) {
-		ktime_t next = ktime_add(dev->next_event, tick_period);
+		ktime_t next = ktime_add_ns(dev->next_event, TICK_NSEC);
 
 		clockevents_program_event(dev, next, true);
 	}
diff --git a/kernel/time/tick-common.c b/kernel/time/tick-common.c
index 68504eb..a03764d 100644
--- a/kernel/time/tick-common.c
+++ b/kernel/time/tick-common.c
@@ -32,7 +32,6 @@ DEFINE_PER_CPU(struct tick_device, tick_cpu_device);
  * no requirement to write hold the jiffies seqcount for it.
  */
 ktime_t tick_next_period;
-ktime_t tick_period;
 
 /*
  * tick_do_timer_cpu is a timer core internal variable which holds the CPU NR
@@ -90,7 +89,7 @@ static void tick_periodic(int cpu)
 		write_seqcount_begin(&jiffies_seq);
 
 		/* Keep track of the next tick event */
-		tick_next_period = ktime_add(tick_next_period, tick_period);
+		tick_next_period = ktime_add_ns(tick_next_period, TICK_NSEC);
 
 		do_timer(1);
 		write_seqcount_end(&jiffies_seq);
@@ -129,7 +128,7 @@ void tick_handle_periodic(struct clock_event_device *dev)
 		 * Setup the next period for devices, which do not have
 		 * periodic mode:
 		 */
-		next = ktime_add(next, tick_period);
+		next = ktime_add_ns(next, TICK_NSEC);
 
 		if (!clockevents_program_event(dev, next, false))
 			return;
@@ -175,7 +174,7 @@ void tick_setup_periodic(struct clock_event_device *dev, int broadcast)
 		for (;;) {
 			if (!clockevents_program_event(dev, next, false))
 				return;
-			next = ktime_add(next, tick_period);
+			next = ktime_add_ns(next, TICK_NSEC);
 		}
 	}
 }
@@ -222,7 +221,6 @@ static void tick_setup_device(struct tick_device *td,
 			tick_do_timer_cpu = cpu;
 
 			tick_next_period = ktime_get();
-			tick_period = NSEC_PER_SEC / HZ;
 #ifdef CONFIG_NO_HZ_FULL
 			/*
 			 * The boot CPU may be nohz_full, in which case set
diff --git a/kernel/time/tick-internal.h b/kernel/time/tick-internal.h
index 7b24961..7a981c9 100644
--- a/kernel/time/tick-internal.h
+++ b/kernel/time/tick-internal.h
@@ -15,7 +15,6 @@
 
 DECLARE_PER_CPU(struct tick_device, tick_cpu_device);
 extern ktime_t tick_next_period;
-extern ktime_t tick_period;
 extern int tick_do_timer_cpu __read_mostly;
 
 extern void tick_setup_periodic(struct clock_event_device *dev, int broadcast);
diff --git a/kernel/time/tick-sched.c b/kernel/time/tick-sched.c
index 33c897b..cc7cba2 100644
--- a/kernel/time/tick-sched.c
+++ b/kernel/time/tick-sched.c
@@ -95,17 +95,17 @@ static void tick_do_update_jiffies64(ktime_t now)
 	write_seqcount_begin(&jiffies_seq);
 
 	delta = ktime_sub(now, tick_next_period);
-	if (unlikely(delta >= tick_period)) {
+	if (unlikely(delta >= TICK_NSEC)) {
 		/* Slow path for long idle sleep times */
-		s64 incr = ktime_to_ns(tick_period);
+		s64 incr = TICK_NSEC;
 
 		ticks += ktime_divns(delta, incr);
 
 		last_jiffies_update = ktime_add_ns(last_jiffies_update,
 						   incr * ticks);
 	} else {
-		last_jiffies_update = ktime_add(last_jiffies_update,
-						tick_period);
+		last_jiffies_update = ktime_add_ns(last_jiffies_update,
+						   TICK_NSEC);
 	}
 
 	/* Advance jiffies to complete the jiffies_seq protected job */
@@ -116,7 +116,7 @@ static void tick_do_update_jiffies64(ktime_t now)
 	 * pairs with the READ_ONCE() in the lockless quick check above.
 	 */
 	WRITE_ONCE(tick_next_period,
-		   ktime_add(last_jiffies_update, tick_period));
+		   ktime_add_ns(last_jiffies_update, TICK_NSEC));
 
 	/*
 	 * Release the sequence count. calc_global_load() below is not
@@ -691,7 +691,7 @@ static void tick_nohz_restart(struct tick_sched *ts, ktime_t now)
 	hrtimer_set_expires(&ts->sched_timer, ts->last_tick);
 
 	/* Forward the time to expire in the future */
-	hrtimer_forward(&ts->sched_timer, now, tick_period);
+	hrtimer_forward(&ts->sched_timer, now, TICK_NSEC);
 
 	if (ts->nohz_mode == NOHZ_MODE_HIGHRES) {
 		hrtimer_start_expires(&ts->sched_timer,
@@ -1260,7 +1260,7 @@ static void tick_nohz_handler(struct clock_event_device *dev)
 	if (unlikely(ts->tick_stopped))
 		return;
 
-	hrtimer_forward(&ts->sched_timer, now, tick_period);
+	hrtimer_forward(&ts->sched_timer, now, TICK_NSEC);
 	tick_program_event(hrtimer_get_expires(&ts->sched_timer), 1);
 }
 
@@ -1297,7 +1297,7 @@ static void tick_nohz_switch_to_nohz(void)
 	next = tick_init_jiffy_update();
 
 	hrtimer_set_expires(&ts->sched_timer, next);
-	hrtimer_forward_now(&ts->sched_timer, tick_period);
+	hrtimer_forward_now(&ts->sched_timer, TICK_NSEC);
 	tick_program_event(hrtimer_get_expires(&ts->sched_timer), 1);
 	tick_nohz_activate(ts, NOHZ_MODE_LOWRES);
 }
@@ -1363,7 +1363,7 @@ static enum hrtimer_restart tick_sched_timer(struct hrtimer *timer)
 	if (unlikely(ts->tick_stopped))
 		return HRTIMER_NORESTART;
 
-	hrtimer_forward(timer, now, tick_period);
+	hrtimer_forward(timer, now, TICK_NSEC);
 
 	return HRTIMER_RESTART;
 }
@@ -1397,13 +1397,13 @@ void tick_setup_sched_timer(void)
 
 	/* Offset the tick to avert jiffies_lock contention. */
 	if (sched_skew_tick) {
-		u64 offset = ktime_to_ns(tick_period) >> 1;
+		u64 offset = TICK_NSEC >> 1;
 		do_div(offset, num_possible_cpus());
 		offset *= smp_processor_id();
 		hrtimer_add_expires_ns(&ts->sched_timer, offset);
 	}
 
-	hrtimer_forward(&ts->sched_timer, now, tick_period);
+	hrtimer_forward(&ts->sched_timer, now, TICK_NSEC);
 	hrtimer_start_expires(&ts->sched_timer, HRTIMER_MODE_ABS_PINNED_HARD);
 	tick_nohz_activate(ts, NOHZ_MODE_HIGHRES);
 }
