Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A727C6FB99B
	for <lists+linux-tip-commits@lfdr.de>; Mon,  8 May 2023 23:27:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233752AbjEHV1m (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Mon, 8 May 2023 17:27:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233808AbjEHV1k (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Mon, 8 May 2023 17:27:40 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA2FFF3;
        Mon,  8 May 2023 14:27:25 -0700 (PDT)
Date:   Mon, 08 May 2023 21:27:23 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1683581244;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=s7kRYJ2sTswKFD58XBJXwq5aIG7wh5l9VISQ2RiK5QA=;
        b=1u+vFkosP1AsA/sIBmgH4gJtPjPS8AJ0S+yVjIZMQdTQuSBCtUu7E9oTzoUk/o+ytxTz9c
        9J8GCdhPGnAOx2o+OGDcHTNxwau4BiYBkBtk9X3lZ3nMYuYNdj0/hZhDjQOGF7+qLLcTMt
        WB1D8K7t6l2APX1IBQ82gDGxubYQ3oT9DBPqgdakmT6oP5+Zz3HmqqW/PMaUx9VowHD0sN
        tCjBOzua6mIUrAyPKrvrVzBvsFscoT1nVypAX1N+77SecCM1VyfwDtRB9hvqsgtbV2sorE
        aEqphPrmLQB8VxqkoRDn4tHyE0CQrNiKi6sB2gXpNte3X184VLzVAwN/ZBkszQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1683581244;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=s7kRYJ2sTswKFD58XBJXwq5aIG7wh5l9VISQ2RiK5QA=;
        b=9IeKUKAFh9KuNznLgSyq9vEOCF2eYhRgvCm60Ah/CxG26d6C1aEB8lJAeikIy4tsOw8oyk
        HasALIB5cgGxbdCw==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/urgent] tick/broadcast: Make broadcast device
 replacement work correctly
Cc:     Victor Hassan <victor@allwinnertech.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Frederic Weisbecker <frederic@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <87pm7d2z1i.ffs@tglx>
References: <87pm7d2z1i.ffs@tglx>
MIME-Version: 1.0
Message-ID: <168358124386.404.12087069170395150328.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the timers/urgent branch of tip:

Commit-ID:     f9d36cf445ffff0b913ba187a3eff78028f9b1fb
Gitweb:        https://git.kernel.org/tip/f9d36cf445ffff0b913ba187a3eff78028f9b1fb
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Sat, 06 May 2023 18:40:57 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Mon, 08 May 2023 23:18:16 +02:00

tick/broadcast: Make broadcast device replacement work correctly

When a tick broadcast clockevent device is initialized for one shot mode
then tick_broadcast_setup_oneshot() OR's the periodic broadcast mode
cpumask into the oneshot broadcast cpumask.

This is required when switching from periodic broadcast mode to oneshot
broadcast mode to ensure that CPUs which are waiting for periodic
broadcast are woken up on the next tick.

But it is subtly broken, when an active broadcast device is replaced and
the system is already in oneshot (NOHZ/HIGHRES) mode. Victor observed
this and debugged the issue.

Then the OR of the periodic broadcast CPU mask is wrong as the periodic
cpumask bits are sticky after tick_broadcast_enable() set it for a CPU
unless explicitly cleared via tick_broadcast_disable().

That means that this sets all other CPUs which have tick broadcasting
enabled at that point unconditionally in the oneshot broadcast mask.

If the affected CPUs were already idle and had their bits set in the
oneshot broadcast mask then this does no harm. But for non idle CPUs
which were not set this corrupts their state.

On their next invocation of tick_broadcast_enable() they observe the bit
set, which indicates that the broadcast for the CPU is already set up.
As a consequence they fail to update the broadcast event even if their
earliest expiring timer is before the actually programmed broadcast
event.

If the programmed broadcast event is far in the future, then this can
cause stalls or trigger the hung task detector.

Avoid this by telling tick_broadcast_setup_oneshot() explicitly whether
this is the initial switch over from periodic to oneshot broadcast which
must take the periodic broadcast mask into account. In the case of
initialization of a replacement device this prevents that the broadcast
oneshot mask is modified.

There is a second problem with broadcast device replacement in this
function. The broadcast device is only armed when the previous state of
the device was periodic.

That is correct for the switch from periodic broadcast mode to oneshot
broadcast mode as the underlying broadcast device could operate in
oneshot state already due to lack of periodic state in hardware. In that
case it is already armed to expire at the next tick.

For the replacement case this is wrong as the device is in shutdown
state. That means that any already pending broadcast event will not be
armed.

This went unnoticed because any CPU which goes idle will observe that
the broadcast device has an expiry time of KTIME_MAX and therefore any
CPUs next timer event will be earlier and cause a reprogramming of the
broadcast device. But that does not guarantee that the events of the
CPUs which were already in idle are delivered on time.

Fix this by arming the newly installed device for an immediate event
which will reevaluate the per CPU expiry times and reprogram the
broadcast device accordingly. This is simpler than caching the last
expiry time in yet another place or saving it before the device exchange
and handing it down to the setup function. Replacement of broadcast
devices is not a frequent operation and usually happens once somewhere
late in the boot process.

Fixes: 9c336c9935cf ("tick/broadcast: Allow late registered device to enter oneshot mode")
Reported-by: Victor Hassan <victor@allwinnertech.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
Link: https://lore.kernel.org/r/87pm7d2z1i.ffs@tglx

---
 kernel/time/tick-broadcast.c | 120 ++++++++++++++++++++++++----------
 1 file changed, 88 insertions(+), 32 deletions(-)

diff --git a/kernel/time/tick-broadcast.c b/kernel/time/tick-broadcast.c
index 93bf2b4..771d1e0 100644
--- a/kernel/time/tick-broadcast.c
+++ b/kernel/time/tick-broadcast.c
@@ -35,14 +35,15 @@ static __cacheline_aligned_in_smp DEFINE_RAW_SPINLOCK(tick_broadcast_lock);
 #ifdef CONFIG_TICK_ONESHOT
 static DEFINE_PER_CPU(struct clock_event_device *, tick_oneshot_wakeup_device);
 
-static void tick_broadcast_setup_oneshot(struct clock_event_device *bc);
+static void tick_broadcast_setup_oneshot(struct clock_event_device *bc, bool from_periodic);
 static void tick_broadcast_clear_oneshot(int cpu);
 static void tick_resume_broadcast_oneshot(struct clock_event_device *bc);
 # ifdef CONFIG_HOTPLUG_CPU
 static void tick_broadcast_oneshot_offline(unsigned int cpu);
 # endif
 #else
-static inline void tick_broadcast_setup_oneshot(struct clock_event_device *bc) { BUG(); }
+static inline void
+tick_broadcast_setup_oneshot(struct clock_event_device *bc, bool from_periodic) { BUG(); }
 static inline void tick_broadcast_clear_oneshot(int cpu) { }
 static inline void tick_resume_broadcast_oneshot(struct clock_event_device *bc) { }
 # ifdef CONFIG_HOTPLUG_CPU
@@ -264,7 +265,7 @@ int tick_device_uses_broadcast(struct clock_event_device *dev, int cpu)
 		if (tick_broadcast_device.mode == TICKDEV_MODE_PERIODIC)
 			tick_broadcast_start_periodic(bc);
 		else
-			tick_broadcast_setup_oneshot(bc);
+			tick_broadcast_setup_oneshot(bc, false);
 		ret = 1;
 	} else {
 		/*
@@ -500,7 +501,7 @@ void tick_broadcast_control(enum tick_broadcast_mode mode)
 			if (tick_broadcast_device.mode == TICKDEV_MODE_PERIODIC)
 				tick_broadcast_start_periodic(bc);
 			else
-				tick_broadcast_setup_oneshot(bc);
+				tick_broadcast_setup_oneshot(bc, false);
 		}
 	}
 out:
@@ -1020,48 +1021,101 @@ static inline ktime_t tick_get_next_period(void)
 /**
  * tick_broadcast_setup_oneshot - setup the broadcast device
  */
-static void tick_broadcast_setup_oneshot(struct clock_event_device *bc)
+static void tick_broadcast_setup_oneshot(struct clock_event_device *bc,
+					 bool from_periodic)
 {
 	int cpu = smp_processor_id();
+	ktime_t nexttick = 0;
 
 	if (!bc)
 		return;
 
-	/* Set it up only once ! */
-	if (bc->event_handler != tick_handle_oneshot_broadcast) {
-		int was_periodic = clockevent_state_periodic(bc);
-
-		bc->event_handler = tick_handle_oneshot_broadcast;
-
+	/*
+	 * When the broadcast device was switched to oneshot by the first
+	 * CPU handling the NOHZ change, the other CPUs will reach this
+	 * code via hrtimer_run_queues() -> tick_check_oneshot_change()
+	 * too. Set up the broadcast device only once!
+	 */
+	if (bc->event_handler == tick_handle_oneshot_broadcast) {
 		/*
-		 * We must be careful here. There might be other CPUs
-		 * waiting for periodic broadcast. We need to set the
-		 * oneshot_mask bits for those and program the
-		 * broadcast device to fire.
+		 * The CPU which switched from periodic to oneshot mode
+		 * set the broadcast oneshot bit for all other CPUs which
+		 * are in the general (periodic) broadcast mask to ensure
+		 * that CPUs which wait for the periodic broadcast are
+		 * woken up.
+		 *
+		 * Clear the bit for the local CPU as the set bit would
+		 * prevent the first tick_broadcast_enter() after this CPU
+		 * switched to oneshot state to program the broadcast
+		 * device.
+		 *
+		 * This code can also be reached via tick_broadcast_control(),
+		 * but this cannot avoid the tick_broadcast_clear_oneshot()
+		 * as that would break the periodic to oneshot transition of
+		 * secondary CPUs. But that's harmless as the below only
+		 * clears already cleared bits.
 		 */
+		tick_broadcast_clear_oneshot(cpu);
+		return;
+	}
+
+
+	bc->event_handler = tick_handle_oneshot_broadcast;
+	bc->next_event = KTIME_MAX;
+
+	/*
+	 * When the tick mode is switched from periodic to oneshot it must
+	 * be ensured that CPUs which are waiting for periodic broadcast
+	 * get their wake-up at the next tick.  This is achieved by ORing
+	 * tick_broadcast_mask into tick_broadcast_oneshot_mask.
+	 *
+	 * For other callers, e.g. broadcast device replacement,
+	 * tick_broadcast_oneshot_mask must not be touched as this would
+	 * set bits for CPUs which are already NOHZ, but not idle. Their
+	 * next tick_broadcast_enter() would observe the bit set and fail
+	 * to update the expiry time and the broadcast event device.
+	 */
+	if (from_periodic) {
 		cpumask_copy(tmpmask, tick_broadcast_mask);
+		/* Remove the local CPU as it is obviously not idle */
 		cpumask_clear_cpu(cpu, tmpmask);
-		cpumask_or(tick_broadcast_oneshot_mask,
-			   tick_broadcast_oneshot_mask, tmpmask);
+		cpumask_or(tick_broadcast_oneshot_mask, tick_broadcast_oneshot_mask, tmpmask);
 
-		if (was_periodic && !cpumask_empty(tmpmask)) {
-			ktime_t nextevt = tick_get_next_period();
+		/*
+		 * Ensure that the oneshot broadcast handler will wake the
+		 * CPUs which are still waiting for periodic broadcast.
+		 */
+		nexttick = tick_get_next_period();
+		tick_broadcast_init_next_event(tmpmask, nexttick);
 
-			clockevents_switch_state(bc, CLOCK_EVT_STATE_ONESHOT);
-			tick_broadcast_init_next_event(tmpmask, nextevt);
-			tick_broadcast_set_event(bc, cpu, nextevt);
-		} else
-			bc->next_event = KTIME_MAX;
-	} else {
 		/*
-		 * The first cpu which switches to oneshot mode sets
-		 * the bit for all other cpus which are in the general
-		 * (periodic) broadcast mask. So the bit is set and
-		 * would prevent the first broadcast enter after this
-		 * to program the bc device.
+		 * If the underlying broadcast clock event device is
+		 * already in oneshot state, then there is nothing to do.
+		 * The device was already armed for the next tick
+		 * in tick_handle_broadcast_periodic()
 		 */
-		tick_broadcast_clear_oneshot(cpu);
+		if (clockevent_state_oneshot(bc))
+			return;
 	}
+
+	/*
+	 * When switching from periodic to oneshot mode arm the broadcast
+	 * device for the next tick.
+	 *
+	 * If the broadcast device has been replaced in oneshot mode and
+	 * the oneshot broadcast mask is not empty, then arm it to expire
+	 * immediately in order to reevaluate the next expiring timer.
+	 * @nexttick is 0 and therefore in the past which will cause the
+	 * clockevent code to force an event.
+	 *
+	 * For both cases the programming can be avoided when the oneshot
+	 * broadcast mask is empty.
+	 *
+	 * tick_broadcast_set_event() implicitly switches the broadcast
+	 * device to oneshot state.
+	 */
+	if (!cpumask_empty(tick_broadcast_oneshot_mask))
+		tick_broadcast_set_event(bc, cpu, nexttick);
 }
 
 /*
@@ -1070,14 +1124,16 @@ static void tick_broadcast_setup_oneshot(struct clock_event_device *bc)
 void tick_broadcast_switch_to_oneshot(void)
 {
 	struct clock_event_device *bc;
+	enum tick_device_mode oldmode;
 	unsigned long flags;
 
 	raw_spin_lock_irqsave(&tick_broadcast_lock, flags);
 
+	oldmode = tick_broadcast_device.mode;
 	tick_broadcast_device.mode = TICKDEV_MODE_ONESHOT;
 	bc = tick_broadcast_device.evtdev;
 	if (bc)
-		tick_broadcast_setup_oneshot(bc);
+		tick_broadcast_setup_oneshot(bc, oldmode == TICKDEV_MODE_PERIODIC);
 
 	raw_spin_unlock_irqrestore(&tick_broadcast_lock, flags);
 }
