Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 47D82319EB8
	for <lists+linux-tip-commits@lfdr.de>; Fri, 12 Feb 2021 13:42:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231597AbhBLMkY (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 12 Feb 2021 07:40:24 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:45340 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231574AbhBLMi5 (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 12 Feb 2021 07:38:57 -0500
Date:   Fri, 12 Feb 2021 12:37:15 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1613133436;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=Vb9iNr0SC40epejTrnUwKmyPO9lYK4j13mzf8/evIwk=;
        b=lZurd3vaPGzi0i9sHzI5m6gp+kX/9P5NcHpr5A2F0ZGG/2KEQ2DLAhYTvVQBCzv97FRZMS
        kKrLyrwbJvQtKLf3RGQ2Rb+7AsaQXNANDkHs7mH/ThddZoiZ/WDIfs1/qAP85QR0jtl6f4
        sF2kuBjZ8+cuGqKTMb2yhpZs95Mf3P1ehMb8lVOEViSkxeT9RAC29uZhTi8hB3KKY161VB
        JtocNSMK16OJ0pnKz7olViXH6kQhCTiP96gtDe8vvXxKhnd0QLUqGS5CYCTW+WNL8wbnmB
        gqV/XutGVcsqYFcY/M1d1EfFH1ER/CZm1sH8u8iYImgwzMU9zytTrxO7yevEEQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1613133436;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=Vb9iNr0SC40epejTrnUwKmyPO9lYK4j13mzf8/evIwk=;
        b=OkfsvAPN7xJE8mrshyuF0ve09z9ijESmI4iWo1IaEGinlbGbIPq4rwEEfejkQgV7JsQaMU
        nWVO35uWocCge7Dw==
From:   "tip-bot2 for Paul E. McKenney" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] rcu/nocb: Code-style nits in callback-offloading toggling
Cc:     Frederic Weisbecker <frederic@kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <161313343587.23325.14285926102025412924.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the core/rcu branch of tip:

Commit-ID:     f759081e8f5ac640df1c7125540759bbcb4eb0e2
Gitweb:        https://git.kernel.org/tip/f759081e8f5ac640df1c7125540759bbcb4eb0e2
Author:        Paul E. McKenney <paulmck@kernel.org>
AuthorDate:    Mon, 21 Dec 2020 11:17:16 -08:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Wed, 06 Jan 2021 16:47:55 -08:00

rcu/nocb: Code-style nits in callback-offloading toggling

This commit addresses a few code-style nits in callback-offloading
toggling, including one that predates this toggling.

Cc: Frederic Weisbecker <frederic@kernel.org>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/rcu_segcblist.h | 19 +++++-----------
 kernel/rcu/rcutorture.c    |  2 +-
 kernel/rcu/tree_plugin.h   | 45 ++++++++++++++++++-------------------
 kernel/time/timer.c        |  1 +-
 4 files changed, 30 insertions(+), 37 deletions(-)

diff --git a/kernel/rcu/rcu_segcblist.h b/kernel/rcu/rcu_segcblist.h
index 3110602..9a19328 100644
--- a/kernel/rcu/rcu_segcblist.h
+++ b/kernel/rcu/rcu_segcblist.h
@@ -80,17 +80,12 @@ static inline bool rcu_segcblist_is_enabled(struct rcu_segcblist *rsclp)
 	return rcu_segcblist_test_flags(rsclp, SEGCBLIST_ENABLED);
 }
 
-/* Is the specified rcu_segcblist offloaded?  */
+/* Is the specified rcu_segcblist offloaded, or is SEGCBLIST_SOFTIRQ_ONLY set? */
 static inline bool rcu_segcblist_is_offloaded(struct rcu_segcblist *rsclp)
 {
-	if (IS_ENABLED(CONFIG_RCU_NOCB_CPU)) {
-		/*
-		 * Complete de-offloading happens only when SEGCBLIST_SOFTIRQ_ONLY
-		 * is set.
-		 */
-		if (!rcu_segcblist_test_flags(rsclp, SEGCBLIST_SOFTIRQ_ONLY))
-			return true;
-	}
+	if (IS_ENABLED(CONFIG_RCU_NOCB_CPU) &&
+	    !rcu_segcblist_test_flags(rsclp, SEGCBLIST_SOFTIRQ_ONLY))
+		return true;
 
 	return false;
 }
@@ -99,10 +94,8 @@ static inline bool rcu_segcblist_completely_offloaded(struct rcu_segcblist *rscl
 {
 	int flags = SEGCBLIST_KTHREAD_CB | SEGCBLIST_KTHREAD_GP | SEGCBLIST_OFFLOADED;
 
-	if (IS_ENABLED(CONFIG_RCU_NOCB_CPU)) {
-		if ((rsclp->flags & flags) == flags)
-			return true;
-	}
+	if (IS_ENABLED(CONFIG_RCU_NOCB_CPU) && (rsclp->flags & flags) == flags)
+		return true;
 
 	return false;
 }
diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
index 22735bc..b9dd63c 100644
--- a/kernel/rcu/rcutorture.c
+++ b/kernel/rcu/rcutorture.c
@@ -1606,7 +1606,7 @@ rcu_torture_stats_print(void)
 		data_race(n_barrier_successes),
 		data_race(n_barrier_attempts),
 		data_race(n_rcu_torture_barrier_error));
-	pr_cont("read-exits: %ld ", data_race(n_read_exits));
+	pr_cont("read-exits: %ld ", data_race(n_read_exits)); // Statistic.
 	pr_cont("nocb-toggles: %ld:%ld\n",
 		atomic_long_read(&n_nocb_offload), atomic_long_read(&n_nocb_deoffload));
 
diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
index bc63a6b..6f56f9e 100644
--- a/kernel/rcu/tree_plugin.h
+++ b/kernel/rcu/tree_plugin.h
@@ -1962,17 +1962,17 @@ static inline bool nocb_gp_update_state(struct rcu_data *rdp, bool *needwake_sta
 				*needwake_state = true;
 		}
 		return true;
-	} else {
-		/*
-		 * De-offloading. Clear our flag and notify the de-offload worker.
-		 * We will ignore this rdp until it ever gets re-offloaded.
-		 */
-		WARN_ON_ONCE(!rcu_segcblist_test_flags(cblist, SEGCBLIST_KTHREAD_GP));
-		rcu_segcblist_clear_flags(cblist, SEGCBLIST_KTHREAD_GP);
-		if (!rcu_segcblist_test_flags(cblist, SEGCBLIST_KTHREAD_CB))
-			*needwake_state = true;
-		return false;
 	}
+
+	/*
+	 * De-offloading. Clear our flag and notify the de-offload worker.
+	 * We will ignore this rdp until it ever gets re-offloaded.
+	 */
+	WARN_ON_ONCE(!rcu_segcblist_test_flags(cblist, SEGCBLIST_KTHREAD_GP));
+	rcu_segcblist_clear_flags(cblist, SEGCBLIST_KTHREAD_GP);
+	if (!rcu_segcblist_test_flags(cblist, SEGCBLIST_KTHREAD_CB))
+		*needwake_state = true;
+	return false;
 }
 
 
@@ -2005,6 +2005,7 @@ static void nocb_gp_wait(struct rcu_data *my_rdp)
 	WARN_ON_ONCE(my_rdp->nocb_gp_rdp != my_rdp);
 	for (rdp = my_rdp; rdp; rdp = rdp->nocb_next_cb_rdp) {
 		bool needwake_state = false;
+
 		if (!nocb_gp_enabled_cb(rdp))
 			continue;
 		trace_rcu_nocb_wake(rcu_state.name, rdp->cpu, TPS("Check"));
@@ -2160,11 +2161,11 @@ static inline bool nocb_cb_wait_cond(struct rcu_data *rdp)
 static void nocb_cb_wait(struct rcu_data *rdp)
 {
 	struct rcu_segcblist *cblist = &rdp->cblist;
-	struct rcu_node *rnp = rdp->mynode;
-	bool needwake_state = false;
-	bool needwake_gp = false;
 	unsigned long cur_gp_seq;
 	unsigned long flags;
+	bool needwake_state = false;
+	bool needwake_gp = false;
+	struct rcu_node *rnp = rdp->mynode;
 
 	local_irq_save(flags);
 	rcu_momentary_dyntick_idle();
@@ -2217,8 +2218,8 @@ static void nocb_cb_wait(struct rcu_data *rdp)
 		swait_event_interruptible_exclusive(rdp->nocb_cb_wq,
 						    nocb_cb_wait_cond(rdp));
 
-		/* ^^^ Ensure CB invocation follows _sleep test. */
-		if (smp_load_acquire(&rdp->nocb_cb_sleep)) {
+		// VVV Ensure CB invocation follows _sleep test.
+		if (smp_load_acquire(&rdp->nocb_cb_sleep)) { // ^^^
 			WARN_ON(signal_pending(current));
 			trace_rcu_nocb_wake(rcu_state.name, rdp->cpu, TPS("WokeEmpty"));
 		}
@@ -2323,7 +2324,7 @@ static int __rcu_nocb_rdp_deoffload(struct rcu_data *rdp)
 	unsigned long flags;
 	int ret;
 
-	printk("De-offloading %d\n", rdp->cpu);
+	pr_info("De-offloading %d\n", rdp->cpu);
 
 	rcu_nocb_lock_irqsave(rdp, flags);
 	/*
@@ -2384,11 +2385,10 @@ int rcu_nocb_cpu_deoffload(int cpu)
 	mutex_lock(&rcu_state.barrier_mutex);
 	cpus_read_lock();
 	if (rcu_segcblist_is_offloaded(&rdp->cblist)) {
-		if (cpu_online(cpu)) {
+		if (cpu_online(cpu))
 			ret = work_on_cpu(cpu, rcu_nocb_rdp_deoffload, rdp);
-		} else {
+		else
 			ret = __rcu_nocb_rdp_deoffload(rdp);
-		}
 		if (!ret)
 			cpumask_clear_cpu(cpu, rcu_nocb_mask);
 	}
@@ -2412,7 +2412,7 @@ static int __rcu_nocb_rdp_offload(struct rcu_data *rdp)
 	if (!rdp->nocb_gp_rdp)
 		return -EINVAL;
 
-	printk("Offloading %d\n", rdp->cpu);
+	pr_info("Offloading %d\n", rdp->cpu);
 	/*
 	 * Can't use rcu_nocb_lock_irqsave() while we are in
 	 * SEGCBLIST_SOFTIRQ_ONLY mode.
@@ -2460,11 +2460,10 @@ int rcu_nocb_cpu_offload(int cpu)
 	mutex_lock(&rcu_state.barrier_mutex);
 	cpus_read_lock();
 	if (!rcu_segcblist_is_offloaded(&rdp->cblist)) {
-		if (cpu_online(cpu)) {
+		if (cpu_online(cpu))
 			ret = work_on_cpu(cpu, rcu_nocb_rdp_offload, rdp);
-		} else {
+		else
 			ret = __rcu_nocb_rdp_offload(rdp);
-		}
 		if (!ret)
 			cpumask_set_cpu(cpu, rcu_nocb_mask);
 	}
diff --git a/kernel/time/timer.c b/kernel/time/timer.c
index f9b2096..f475f1a 100644
--- a/kernel/time/timer.c
+++ b/kernel/time/timer.c
@@ -1243,6 +1243,7 @@ bool timer_curr_running(struct timer_list *timer)
 
 	for (i = 0; i < NR_BASES; i++) {
 		struct timer_base *base = this_cpu_ptr(&timer_bases[i]);
+
 		if (base->running_timer == timer)
 			return true;
 	}
