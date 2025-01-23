Return-Path: <linux-tip-commits+bounces-3281-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 78F4BA1A244
	for <lists+linux-tip-commits@lfdr.de>; Thu, 23 Jan 2025 11:57:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 187EB3AD5DD
	for <lists+linux-tip-commits@lfdr.de>; Thu, 23 Jan 2025 10:57:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22B2B20DD7F;
	Thu, 23 Jan 2025 10:57:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="LTjJG8no";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="6vm4zG+Y"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 199911C5F14;
	Thu, 23 Jan 2025 10:57:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737629858; cv=none; b=KtulJInBDfqNa5Ofbz6zweZFM2YV4WYNMcSo4cYFY+b7LXzZgfeAk8NMWLNLQlYzAJqfIjeJWgWvJagLPcWO2AFDI981fuAhqcnnwjgTbQSOHcL2GiNUnq2w3yAfx/ReDrbT3EMkzzps/f3VuMHfvKT8PfGCEs1r0pjtD7WCdWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737629858; c=relaxed/simple;
	bh=bqSMNDAk1Rf3g0yCOuIadUrT1NZ8KVcL8+UMpCWSCyY=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=Wduer6VuTKsPqo6KlgWsP5StR9w846wqntyfR1SepRwW6yfUjMAzJ4Oh/oOhTCW3wd8K3kh/NRgth5Bln+EtV2jvQ4WfzcwqRfLZUyQq45tihPJetdyusMyKeCo7tzavDGf9mk60717Pe8SYn2g4I5NP4L22rc0XOH+KIGHqcUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=LTjJG8no; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=6vm4zG+Y; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 23 Jan 2025 10:57:28 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1737629853;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9d/C8IAtcK9gMwIavaj1Vdnu4lOmeIWDjl3J9zsp9Xw=;
	b=LTjJG8noQCx5rf9mJAWQxIG7zt8RH9YZlpbOxNyhKDTP9zwT8A0DPWZRCqfyyiHpxmRruw
	drJcEFc5KSZgvtUh2wy5eajAt5UJsh6yYf1JeChElHnR0tIlae6msuprua7xCPJ/DskcRb
	JurFzBFmEYkMxX7nL7ct9zCDQFOoW5aGtTdyA3RQu3HLiyaHzpmVbLlRydl5LI313nLQk7
	DHyIejX95KfZXUnz0DE9He3IUrvAmz/brWnpZvWU/kEG0nwO7n3vf5JWN1Qmywcx2OQFxg
	yueIAYme84u86wQZq/Lv16MMW+7ujWn8vH/CASM7hGklDpmG4MonQdL2btC3jg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1737629853;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9d/C8IAtcK9gMwIavaj1Vdnu4lOmeIWDjl3J9zsp9Xw=;
	b=6vm4zG+YJuBwkbx3rhzIE7IlNtm22E7EACMXnCUQcvuQVugJS4u2xHeNTSnHEGhZ5vZpXt
	oJ3+50EiIiw7/LBw==
From: "tip-bot2 for Frederic Weisbecker" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/urgent] hrtimers: Force migrate away hrtimers queued
 after CPUHP_AP_HRTIMERS_DYING
Cc: Vlad Poenaru <vlad.wing@gmail.com>, Usama Arif <usamaarif642@gmail.com>,
 Frederic Weisbecker <frederic@kernel.org>,
 "Paul E. McKenney" <paulmck@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
 stable@vger.kernel.org, x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250117232433.24027-1-frederic@kernel.org>
References: <20250117232433.24027-1-frederic@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173762984876.31546.16541159825307345411.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/urgent branch of tip:

Commit-ID:     b7a110336261147ccb373f4100cc88271c54bd91
Gitweb:        https://git.kernel.org/tip/b7a110336261147ccb373f4100cc88271c54bd91
Author:        Frederic Weisbecker <frederic@kernel.org>
AuthorDate:    Sat, 18 Jan 2025 00:24:33 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 23 Jan 2025 11:47:23 +01:00

hrtimers: Force migrate away hrtimers queued after CPUHP_AP_HRTIMERS_DYING

hrtimers are migrated away from the dying CPU to any online target at
the CPUHP_AP_HRTIMERS_DYING stage in order not to delay bandwidth timers
handling tasks involved in the CPU hotplug forward progress.

However wakeups can still be performed by the outgoing CPU after
CPUHP_AP_HRTIMERS_DYING. Those can result again in bandwidth timers being
armed. Depending on several considerations (crystal ball power management
based election, earliest timer already enqueued, timer migration enabled or
not), the target may eventually be the current CPU even if offline. If that
happens, the timer is eventually ignored.

The most notable example is RCU which had to deal with each and every of
those wake-ups by deferring them to an online CPU, along with related
workarounds:

_ e787644caf76 (rcu: Defer RCU kthreads wakeup when CPU is dying)
_ 9139f93209d1 (rcu/nocb: Fix RT throttling hrtimer armed from offline CPU)
_ f7345ccc62a4 (rcu/nocb: Fix rcuog wake-up from offline softirq)

The problem isn't confined to RCU though as the stop machine kthread
(which runs CPUHP_AP_HRTIMERS_DYING) reports its completion at the end
of its work through cpu_stop_signal_done() and performs a wake up that
eventually arms the deadline server timer:

   WARNING: CPU: 94 PID: 588 at kernel/time/hrtimer.c:1086 hrtimer_start_range_ns+0x289/0x2d0
   CPU: 94 UID: 0 PID: 588 Comm: migration/94 Not tainted
   Stopper: multi_cpu_stop+0x0/0x120 <- stop_machine_cpuslocked+0x66/0xc0
   RIP: 0010:hrtimer_start_range_ns+0x289/0x2d0
   Call Trace:
   <TASK>
     start_dl_timer
     enqueue_dl_entity
     dl_server_start
     enqueue_task_fair
     enqueue_task
     ttwu_do_activate
     try_to_wake_up
     complete
     cpu_stopper_thread

Instead of providing yet another bandaid to work around the situation, fix
it in the hrtimers infrastructure instead: always migrate away a timer to
an online target whenever it is enqueued from an offline CPU.

This will also allow to revert all the above RCU disgraceful hacks.

Fixes: 5c0930ccaad5 ("hrtimers: Push pending hrtimers away from outgoing CPU earlier")
Reported-by: Vlad Poenaru <vlad.wing@gmail.com>
Reported-by: Usama Arif <usamaarif642@gmail.com>
Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: stable@vger.kernel.org
Tested-by: Paul E. McKenney <paulmck@kernel.org>
Link: https://lore.kernel.org/all/20250117232433.24027-1-frederic@kernel.org
Closes: 20241213203739.1519801-1-usamaarif642@gmail.com
---
 include/linux/hrtimer_defs.h |   1 +-
 kernel/time/hrtimer.c        | 103 +++++++++++++++++++++++++++-------
 2 files changed, 83 insertions(+), 21 deletions(-)

diff --git a/include/linux/hrtimer_defs.h b/include/linux/hrtimer_defs.h
index c3b4b7e..84a5045 100644
--- a/include/linux/hrtimer_defs.h
+++ b/include/linux/hrtimer_defs.h
@@ -125,6 +125,7 @@ struct hrtimer_cpu_base {
 	ktime_t				softirq_expires_next;
 	struct hrtimer			*softirq_next_timer;
 	struct hrtimer_clock_base	clock_base[HRTIMER_MAX_CLOCK_BASES];
+	call_single_data_t		csd;
 } ____cacheline_aligned;
 
 
diff --git a/kernel/time/hrtimer.c b/kernel/time/hrtimer.c
index 14bd09c..0feb38b 100644
--- a/kernel/time/hrtimer.c
+++ b/kernel/time/hrtimer.c
@@ -58,6 +58,8 @@
 #define HRTIMER_ACTIVE_SOFT	(HRTIMER_ACTIVE_HARD << MASK_SHIFT)
 #define HRTIMER_ACTIVE_ALL	(HRTIMER_ACTIVE_SOFT | HRTIMER_ACTIVE_HARD)
 
+static void retrigger_next_event(void *arg);
+
 /*
  * The timer bases:
  *
@@ -111,7 +113,8 @@ DEFINE_PER_CPU(struct hrtimer_cpu_base, hrtimer_bases) =
 			.clockid = CLOCK_TAI,
 			.get_time = &ktime_get_clocktai,
 		},
-	}
+	},
+	.csd = CSD_INIT(retrigger_next_event, NULL)
 };
 
 static const int hrtimer_clock_to_base_table[MAX_CLOCKS] = {
@@ -124,6 +127,14 @@ static const int hrtimer_clock_to_base_table[MAX_CLOCKS] = {
 	[CLOCK_TAI]		= HRTIMER_BASE_TAI,
 };
 
+static inline bool hrtimer_base_is_online(struct hrtimer_cpu_base *base)
+{
+	if (!IS_ENABLED(CONFIG_HOTPLUG_CPU))
+		return true;
+	else
+		return likely(base->online);
+}
+
 /*
  * Functions and macros which are different for UP/SMP systems are kept in a
  * single place
@@ -183,27 +194,54 @@ struct hrtimer_clock_base *lock_hrtimer_base(const struct hrtimer *timer,
 }
 
 /*
- * We do not migrate the timer when it is expiring before the next
- * event on the target cpu. When high resolution is enabled, we cannot
- * reprogram the target cpu hardware and we would cause it to fire
- * late. To keep it simple, we handle the high resolution enabled and
- * disabled case similar.
+ * Check if the elected target is suitable considering its next
+ * event and the hotplug state of the current CPU.
+ *
+ * If the elected target is remote and its next event is after the timer
+ * to queue, then a remote reprogram is necessary. However there is no
+ * guarantee the IPI handling the operation would arrive in time to meet
+ * the high resolution deadline. In this case the local CPU becomes a
+ * preferred target, unless it is offline.
+ *
+ * High and low resolution modes are handled the same way for simplicity.
  *
  * Called with cpu_base->lock of target cpu held.
  */
-static int
-hrtimer_check_target(struct hrtimer *timer, struct hrtimer_clock_base *new_base)
+static bool hrtimer_suitable_target(struct hrtimer *timer, struct hrtimer_clock_base *new_base,
+				    struct hrtimer_cpu_base *new_cpu_base,
+				    struct hrtimer_cpu_base *this_cpu_base)
 {
 	ktime_t expires;
 
+	/*
+	 * The local CPU clockevent can be reprogrammed. Also get_target_base()
+	 * guarantees it is online.
+	 */
+	if (new_cpu_base == this_cpu_base)
+		return true;
+
+	/*
+	 * The offline local CPU can't be the default target if the
+	 * next remote target event is after this timer. Keep the
+	 * elected new base. An IPI will we issued to reprogram
+	 * it as a last resort.
+	 */
+	if (!hrtimer_base_is_online(this_cpu_base))
+		return true;
+
 	expires = ktime_sub(hrtimer_get_expires(timer), new_base->offset);
-	return expires < new_base->cpu_base->expires_next;
+
+	return expires >= new_base->cpu_base->expires_next;
 }
 
-static inline
-struct hrtimer_cpu_base *get_target_base(struct hrtimer_cpu_base *base,
-					 int pinned)
+static inline struct hrtimer_cpu_base *get_target_base(struct hrtimer_cpu_base *base, int pinned)
 {
+	if (!hrtimer_base_is_online(base)) {
+		int cpu = cpumask_any_and(cpu_online_mask, housekeeping_cpumask(HK_TYPE_TIMER));
+
+		return &per_cpu(hrtimer_bases, cpu);
+	}
+
 #if defined(CONFIG_SMP) && defined(CONFIG_NO_HZ_COMMON)
 	if (static_branch_likely(&timers_migration_enabled) && !pinned)
 		return &per_cpu(hrtimer_bases, get_nohz_timer_target());
@@ -254,8 +292,8 @@ again:
 		raw_spin_unlock(&base->cpu_base->lock);
 		raw_spin_lock(&new_base->cpu_base->lock);
 
-		if (new_cpu_base != this_cpu_base &&
-		    hrtimer_check_target(timer, new_base)) {
+		if (!hrtimer_suitable_target(timer, new_base, new_cpu_base,
+					     this_cpu_base)) {
 			raw_spin_unlock(&new_base->cpu_base->lock);
 			raw_spin_lock(&base->cpu_base->lock);
 			new_cpu_base = this_cpu_base;
@@ -264,8 +302,7 @@ again:
 		}
 		WRITE_ONCE(timer->base, new_base);
 	} else {
-		if (new_cpu_base != this_cpu_base &&
-		    hrtimer_check_target(timer, new_base)) {
+		if (!hrtimer_suitable_target(timer, new_base,  new_cpu_base, this_cpu_base)) {
 			new_cpu_base = this_cpu_base;
 			goto again;
 		}
@@ -716,8 +753,6 @@ static inline int hrtimer_is_hres_enabled(void)
 	return hrtimer_hres_enabled;
 }
 
-static void retrigger_next_event(void *arg);
-
 /*
  * Switch to high resolution mode
  */
@@ -1205,6 +1240,7 @@ static int __hrtimer_start_range_ns(struct hrtimer *timer, ktime_t tim,
 				    u64 delta_ns, const enum hrtimer_mode mode,
 				    struct hrtimer_clock_base *base)
 {
+	struct hrtimer_cpu_base *this_cpu_base = this_cpu_ptr(&hrtimer_bases);
 	struct hrtimer_clock_base *new_base;
 	bool force_local, first;
 
@@ -1216,10 +1252,16 @@ static int __hrtimer_start_range_ns(struct hrtimer *timer, ktime_t tim,
 	 * and enforce reprogramming after it is queued no matter whether
 	 * it is the new first expiring timer again or not.
 	 */
-	force_local = base->cpu_base == this_cpu_ptr(&hrtimer_bases);
+	force_local = base->cpu_base == this_cpu_base;
 	force_local &= base->cpu_base->next_timer == timer;
 
 	/*
+	 * Don't force local queuing if this enqueue happens on a unplugged
+	 * CPU after hrtimer_cpu_dying() has been invoked.
+	 */
+	force_local &= this_cpu_base->online;
+
+	/*
 	 * Remove an active timer from the queue. In case it is not queued
 	 * on the current CPU, make sure that remove_hrtimer() updates the
 	 * remote data correctly.
@@ -1248,8 +1290,27 @@ static int __hrtimer_start_range_ns(struct hrtimer *timer, ktime_t tim,
 	}
 
 	first = enqueue_hrtimer(timer, new_base, mode);
-	if (!force_local)
-		return first;
+	if (!force_local) {
+		/*
+		 * If the current CPU base is online, then the timer is
+		 * never queued on a remote CPU if it would be the first
+		 * expiring timer there.
+		 */
+		if (hrtimer_base_is_online(this_cpu_base))
+			return first;
+
+		/*
+		 * Timer was enqueued remote because the current base is
+		 * already offline. If the timer is the first to expire,
+		 * kick the remote CPU to reprogram the clock event.
+		 */
+		if (first) {
+			struct hrtimer_cpu_base *new_cpu_base = new_base->cpu_base;
+
+			smp_call_function_single_async(new_cpu_base->cpu, &new_cpu_base->csd);
+		}
+		return 0;
+	}
 
 	/*
 	 * Timer was forced to stay on the current CPU to avoid

