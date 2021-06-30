Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A5F73B8392
	for <lists+linux-tip-commits@lfdr.de>; Wed, 30 Jun 2021 15:47:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235580AbhF3NuI (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 30 Jun 2021 09:50:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235300AbhF3Nt6 (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 30 Jun 2021 09:49:58 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CE4CC0613A4;
        Wed, 30 Jun 2021 06:47:29 -0700 (PDT)
Date:   Wed, 30 Jun 2021 13:47:27 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1625060848;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=IPf0mXFfGa+mATHbKciVcpdog+TQJEBlGZm60TL5d0c=;
        b=Fp0IMCMU06eabU3smQIFFQI3Lwd61OwIIIHg7ErSHtWx05VU9PtombqxqdkmsJ9XoJCQj/
        Efz0kXV4ER2j7FqpDGhLEdyoKZ2p0hE+thht1451CGRb5ED/6bw4ILEEgeYcBnWm5Aa2ny
        KtXvH7rVsWev1C16ZnNMMSO5cK2MYuqCczokKSv5A3rI3c6HY4q+YFGRDgfDBdI5NGhQ4G
        1iN2S24eXOmSObeZxlrB8kpdPSTz/w0X3i4WpfBct7u2U7AU6j7fO8gvmzTXjPxt+galqh
        uCzMGRVmzLQe8KxdoxG4ETMzr1rHsTJbDo33ijcWk6A1b7Ue3aH9OsuQCHnNrg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1625060848;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=IPf0mXFfGa+mATHbKciVcpdog+TQJEBlGZm60TL5d0c=;
        b=DHbgmzX03f0Yxdaj0ZJXfueBSAYZsOrjY2yAESKOWPqLsxf6bMGJpRtoFV02wDpMg2pJIO
        +fkWCYVZLPsr/yBQ==
From:   "tip-bot2 for Frederic Weisbecker" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] rcu/nocb: Unify timers
Cc:     Frederic Weisbecker <frederic@kernel.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Neeraj Upadhyay <neeraju@codeaurora.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        "Paul E. McKenney" <paulmck@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <162506084736.395.8239698719575204489.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the core/rcu branch of tip:

Commit-ID:     e75bcd48e2c4026b1f3feda916a2327b1744d664
Gitweb:        https://git.kernel.org/tip/e75bcd48e2c4026b1f3feda916a2327b1744d664
Author:        Frederic Weisbecker <frederic@kernel.org>
AuthorDate:    Tue, 23 Feb 2021 01:10:11 +01:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Wed, 12 May 2021 12:10:23 -07:00

rcu/nocb: Unify timers

Now that ->nocb_timer and ->nocb_bypass_timer have become quite similar,
this commit merges them together.  A new RCU_NOCB_WAKE_BYPASS wake level
is introduced.  As a result, timers perform all kinds of deferred wake
ups but other deferred wakeup callsites only handle non-bypass wakeups
in order not to wake up rcuo too early.

The timer also unconditionally executes a full barrier so as to order
timer_pending() and callback enqueue although the path performing
RCU_NOCB_WAKE_FORCE that makes use of it is debatable. It should also
test against the rdp leader instead of the current rdp.

This unconditional full barrier shouldn't bring visible overhead since
these timers almost never fire.

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Cc: Josh Triplett <josh@joshtriplett.org>
Cc: Lai Jiangshan <jiangshanlai@gmail.com>
Cc: Joel Fernandes <joel@joelfernandes.org>
Cc: Neeraj Upadhyay <neeraju@codeaurora.org>
Cc: Boqun Feng <boqun.feng@gmail.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 include/trace/events/rcu.h |  1 +-
 kernel/rcu/tree.h          |  6 +-
 kernel/rcu/tree_plugin.h   | 92 +++++++++++++++----------------------
 3 files changed, 43 insertions(+), 56 deletions(-)

diff --git a/include/trace/events/rcu.h b/include/trace/events/rcu.h
index 6768b64..670e417 100644
--- a/include/trace/events/rcu.h
+++ b/include/trace/events/rcu.h
@@ -278,6 +278,7 @@ TRACE_EVENT_RCU(rcu_exp_funnel_lock,
  * "WakeNot": Don't wake rcuo kthread.
  * "WakeNotPoll": Don't wake rcuo kthread because it is polling.
  * "WakeOvfIsDeferred": Wake rcuo kthread later, CB list is huge.
+ * "WakeBypassIsDeferred": Wake rcuo kthread later, bypass list is contended.
  * "WokeEmpty": rcuo CB kthread woke to find empty list.
  */
 TRACE_EVENT_RCU(rcu_nocb_wake,
diff --git a/kernel/rcu/tree.h b/kernel/rcu/tree.h
index 2510e86..9a16487 100644
--- a/kernel/rcu/tree.h
+++ b/kernel/rcu/tree.h
@@ -218,7 +218,6 @@ struct rcu_data {
 
 	/* The following fields are used by GP kthread, hence own cacheline. */
 	raw_spinlock_t nocb_gp_lock ____cacheline_internodealigned_in_smp;
-	struct timer_list nocb_bypass_timer; /* Force nocb_bypass flush. */
 	u8 nocb_gp_sleep;		/* Is the nocb GP thread asleep? */
 	u8 nocb_gp_bypass;		/* Found a bypass on last scan? */
 	u8 nocb_gp_gp;			/* GP to wait for on last scan? */
@@ -258,8 +257,9 @@ struct rcu_data {
 
 /* Values for nocb_defer_wakeup field in struct rcu_data. */
 #define RCU_NOCB_WAKE_NOT	0
-#define RCU_NOCB_WAKE		1
-#define RCU_NOCB_WAKE_FORCE	2
+#define RCU_NOCB_WAKE_BYPASS	1
+#define RCU_NOCB_WAKE		2
+#define RCU_NOCB_WAKE_FORCE	3
 
 #define RCU_JIFFIES_TILL_FORCE_QS (1 + (HZ > 250) + (HZ > 500))
 					/* For jiffies_till_first_fqs and */
diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
index e2e5e49..dfb048e 100644
--- a/kernel/rcu/tree_plugin.h
+++ b/kernel/rcu/tree_plugin.h
@@ -1701,8 +1701,6 @@ static bool __wake_nocb_gp(struct rcu_data *rdp_gp,
 		del_timer(&rdp_gp->nocb_timer);
 	}
 
-	del_timer(&rdp_gp->nocb_bypass_timer);
-
 	if (force || READ_ONCE(rdp_gp->nocb_gp_sleep)) {
 		WRITE_ONCE(rdp_gp->nocb_gp_sleep, false);
 		needwake = true;
@@ -1740,10 +1738,19 @@ static void wake_nocb_gp_defer(struct rcu_data *rdp, int waketype,
 
 	raw_spin_lock_irqsave(&rdp_gp->nocb_gp_lock, flags);
 
-	if (rdp_gp->nocb_defer_wakeup == RCU_NOCB_WAKE_NOT)
-		mod_timer(&rdp_gp->nocb_timer, jiffies + 1);
-	if (rdp_gp->nocb_defer_wakeup < waketype)
+	/*
+	 * Bypass wakeup overrides previous deferments. In case
+	 * of callback storm, no need to wake up too early.
+	 */
+	if (waketype == RCU_NOCB_WAKE_BYPASS) {
+		mod_timer(&rdp_gp->nocb_timer, jiffies + 2);
 		WRITE_ONCE(rdp_gp->nocb_defer_wakeup, waketype);
+	} else {
+		if (rdp_gp->nocb_defer_wakeup < RCU_NOCB_WAKE)
+			mod_timer(&rdp_gp->nocb_timer, jiffies + 1);
+		if (rdp_gp->nocb_defer_wakeup < waketype)
+			WRITE_ONCE(rdp_gp->nocb_defer_wakeup, waketype);
+	}
 
 	raw_spin_unlock_irqrestore(&rdp_gp->nocb_gp_lock, flags);
 
@@ -1995,7 +2002,7 @@ static void __call_rcu_nocb_wake(struct rcu_data *rdp, bool was_alldone,
 		smp_mb(); /* Enqueue before timer_pending(). */
 		if ((rdp->nocb_cb_sleep ||
 		     !rcu_segcblist_ready_cbs(&rdp->cblist)) &&
-		    !timer_pending(&rdp->nocb_bypass_timer)) {
+		    !timer_pending(&rdp->nocb_timer)) {
 			rcu_nocb_unlock_irqrestore(rdp, flags);
 			wake_nocb_gp_defer(rdp, RCU_NOCB_WAKE_FORCE,
 					   TPS("WakeOvfIsDeferred"));
@@ -2010,19 +2017,6 @@ static void __call_rcu_nocb_wake(struct rcu_data *rdp, bool was_alldone,
 	return;
 }
 
-/* Wake up the no-CBs GP kthread to flush ->nocb_bypass. */
-static void do_nocb_bypass_wakeup_timer(struct timer_list *t)
-{
-	unsigned long flags;
-	struct rcu_data *rdp = from_timer(rdp, t, nocb_bypass_timer);
-
-	trace_rcu_nocb_wake(rcu_state.name, rdp->cpu, TPS("Timer"));
-
-	raw_spin_lock_irqsave(&rdp->nocb_gp_lock, flags);
-	smp_mb__after_spinlock(); /* Timer expire before wakeup. */
-	__wake_nocb_gp(rdp, rdp, false, flags);
-}
-
 /*
  * Check if we ignore this rdp.
  *
@@ -2175,19 +2169,12 @@ static void nocb_gp_wait(struct rcu_data *my_rdp)
 	my_rdp->nocb_gp_bypass = bypass;
 	my_rdp->nocb_gp_gp = needwait_gp;
 	my_rdp->nocb_gp_seq = needwait_gp ? wait_gp_seq : 0;
-	if (bypass) {
-		if (!rcu_nocb_poll) {
-			raw_spin_lock_irqsave(&my_rdp->nocb_gp_lock, flags);
-			// Avoid race with first bypass CB.
-			if (my_rdp->nocb_defer_wakeup > RCU_NOCB_WAKE_NOT) {
-				WRITE_ONCE(my_rdp->nocb_defer_wakeup, RCU_NOCB_WAKE_NOT);
-				del_timer(&my_rdp->nocb_timer);
-			}
-			// At least one child with non-empty ->nocb_bypass, so set
-			// timer in order to avoid stranding its callbacks.
-			mod_timer(&my_rdp->nocb_bypass_timer, j + 2);
-			raw_spin_unlock_irqrestore(&my_rdp->nocb_gp_lock, flags);
-		}
+
+	if (bypass && !rcu_nocb_poll) {
+		// At least one child with non-empty ->nocb_bypass, so set
+		// timer in order to avoid stranding its callbacks.
+		wake_nocb_gp_defer(my_rdp, RCU_NOCB_WAKE_BYPASS,
+				   TPS("WakeBypassIsDeferred"));
 	}
 	if (rcu_nocb_poll) {
 		/* Polling, so trace if first poll in the series. */
@@ -2211,8 +2198,6 @@ static void nocb_gp_wait(struct rcu_data *my_rdp)
 	}
 	if (!rcu_nocb_poll) {
 		raw_spin_lock_irqsave(&my_rdp->nocb_gp_lock, flags);
-		if (bypass)
-			del_timer(&my_rdp->nocb_bypass_timer);
 		if (my_rdp->nocb_defer_wakeup > RCU_NOCB_WAKE_NOT) {
 			WRITE_ONCE(my_rdp->nocb_defer_wakeup, RCU_NOCB_WAKE_NOT);
 			del_timer(&my_rdp->nocb_timer);
@@ -2358,16 +2343,14 @@ static int rcu_nocb_need_deferred_wakeup(struct rcu_data *rdp, int level)
 }
 
 /* Do a deferred wakeup of rcu_nocb_kthread(). */
-static bool do_nocb_deferred_wakeup_common(struct rcu_data *rdp,
-					   int level)
+static bool do_nocb_deferred_wakeup_common(struct rcu_data *rdp_gp,
+					   struct rcu_data *rdp, int level,
+					   unsigned long flags)
+	__releases(rdp_gp->nocb_gp_lock)
 {
-	unsigned long flags;
 	int ndw;
-	struct rcu_data *rdp_gp = rdp->nocb_gp_rdp;
 	int ret;
 
-	raw_spin_lock_irqsave(&rdp_gp->nocb_gp_lock, flags);
-
 	if (!rcu_nocb_need_deferred_wakeup(rdp_gp, level)) {
 		raw_spin_unlock_irqrestore(&rdp_gp->nocb_gp_lock, flags);
 		return false;
@@ -2383,9 +2366,15 @@ static bool do_nocb_deferred_wakeup_common(struct rcu_data *rdp,
 /* Do a deferred wakeup of rcu_nocb_kthread() from a timer handler. */
 static void do_nocb_deferred_wakeup_timer(struct timer_list *t)
 {
+	unsigned long flags;
 	struct rcu_data *rdp = from_timer(rdp, t, nocb_timer);
 
-	do_nocb_deferred_wakeup_common(rdp, RCU_NOCB_WAKE);
+	WARN_ON_ONCE(rdp->nocb_gp_rdp != rdp);
+	trace_rcu_nocb_wake(rcu_state.name, rdp->cpu, TPS("Timer"));
+
+	raw_spin_lock_irqsave(&rdp->nocb_gp_lock, flags);
+	smp_mb__after_spinlock(); /* Timer expire before wakeup. */
+	do_nocb_deferred_wakeup_common(rdp, rdp, RCU_NOCB_WAKE_BYPASS, flags);
 }
 
 /*
@@ -2395,12 +2384,14 @@ static void do_nocb_deferred_wakeup_timer(struct timer_list *t)
  */
 static bool do_nocb_deferred_wakeup(struct rcu_data *rdp)
 {
-	if (!rdp->nocb_gp_rdp)
+	unsigned long flags;
+	struct rcu_data *rdp_gp = rdp->nocb_gp_rdp;
+
+	if (!rdp_gp || !rcu_nocb_need_deferred_wakeup(rdp_gp, RCU_NOCB_WAKE))
 		return false;
 
-	if (rcu_nocb_need_deferred_wakeup(rdp->nocb_gp_rdp, RCU_NOCB_WAKE))
-		return do_nocb_deferred_wakeup_common(rdp, RCU_NOCB_WAKE);
-	return false;
+	raw_spin_lock_irqsave(&rdp_gp->nocb_gp_lock, flags);
+	return do_nocb_deferred_wakeup_common(rdp_gp, rdp, RCU_NOCB_WAKE, flags);
 }
 
 void rcu_nocb_flush_deferred_wakeup(void)
@@ -2644,7 +2635,6 @@ static void __init rcu_boot_init_nocb_percpu_data(struct rcu_data *rdp)
 	raw_spin_lock_init(&rdp->nocb_bypass_lock);
 	raw_spin_lock_init(&rdp->nocb_gp_lock);
 	timer_setup(&rdp->nocb_timer, do_nocb_deferred_wakeup_timer, 0);
-	timer_setup(&rdp->nocb_bypass_timer, do_nocb_bypass_wakeup_timer, 0);
 	rcu_cblist_init(&rdp->nocb_bypass);
 }
 
@@ -2803,13 +2793,12 @@ static void show_rcu_nocb_gp_state(struct rcu_data *rdp)
 {
 	struct rcu_node *rnp = rdp->mynode;
 
-	pr_info("nocb GP %d %c%c%c%c%c%c %c[%c%c] %c%c:%ld rnp %d:%d %lu %c CPU %d%s\n",
+	pr_info("nocb GP %d %c%c%c%c%c %c[%c%c] %c%c:%ld rnp %d:%d %lu %c CPU %d%s\n",
 		rdp->cpu,
 		"kK"[!!rdp->nocb_gp_kthread],
 		"lL"[raw_spin_is_locked(&rdp->nocb_gp_lock)],
 		"dD"[!!rdp->nocb_defer_wakeup],
 		"tT"[timer_pending(&rdp->nocb_timer)],
-		"bB"[timer_pending(&rdp->nocb_bypass_timer)],
 		"sS"[!!rdp->nocb_gp_sleep],
 		".W"[swait_active(&rdp->nocb_gp_wq)],
 		".W"[swait_active(&rnp->nocb_gp_wq[0])],
@@ -2830,7 +2819,6 @@ static void show_rcu_nocb_state(struct rcu_data *rdp)
 	char bufr[20];
 	struct rcu_segcblist *rsclp = &rdp->cblist;
 	bool waslocked;
-	bool wastimer;
 	bool wassleep;
 
 	if (rdp->nocb_gp_rdp == rdp)
@@ -2867,15 +2855,13 @@ static void show_rcu_nocb_state(struct rcu_data *rdp)
 		return;
 
 	waslocked = raw_spin_is_locked(&rdp->nocb_gp_lock);
-	wastimer = timer_pending(&rdp->nocb_bypass_timer);
 	wassleep = swait_active(&rdp->nocb_gp_wq);
-	if (!rdp->nocb_gp_sleep && !waslocked && !wastimer && !wassleep)
+	if (!rdp->nocb_gp_sleep && !waslocked && !wassleep)
 		return;  /* Nothing untowards. */
 
-	pr_info("   nocb GP activity on CB-only CPU!!! %c%c%c%c %c\n",
+	pr_info("   nocb GP activity on CB-only CPU!!! %c%c%c %c\n",
 		"lL"[waslocked],
 		"dD"[!!rdp->nocb_defer_wakeup],
-		"tT"[wastimer],
 		"sS"[!!rdp->nocb_gp_sleep],
 		".W"[wassleep]);
 }
