Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 84D4F3B83B8
	for <lists+linux-tip-commits@lfdr.de>; Wed, 30 Jun 2021 15:48:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235886AbhF3Nul (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 30 Jun 2021 09:50:41 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:32888 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235321AbhF3NuK (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 30 Jun 2021 09:50:10 -0400
Date:   Wed, 30 Jun 2021 13:47:40 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1625060861;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=htt0sBHDrMYqrJFggIY7PwdcVE1pYUd9hKxAb5vrTW0=;
        b=OoJYQJtXVtUlG9mve4CcWcHEje/PqlFyWIgurSKfgUrr55b/cAj0d7thnGJEuTfIp+AF7A
        0c1B3d/IJ7pJMg1IuAp76bhJNn8/FOS1cK/GdcBjXIZznlzLKHMpl8UFhd4An6GcLbwD7n
        7oQTDYMVdp7r2qX927O3WuQDoSVMcmSf4VoN3k6T5ium72KRT0BA253956MOVM4690AitD
        t1b2YezsStz3PPpT+RDtBpUUrgSyEn1q+16h9+y+JzTU86Q4LGy7PLeMDG1YeAje2XgM34
        dRv1DfhfPOEqJDRXcVs4EJJIPb/acjcZdypfec+izYIC7/w0xTb/AYxXe+5iIw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1625060861;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=htt0sBHDrMYqrJFggIY7PwdcVE1pYUd9hKxAb5vrTW0=;
        b=YFr9WId3s8cVAHzOqDzDDFdGBf8flqemMts/nIv0Nz+Z55frZ3DKIPdI8GYetPc+T+AXii
        a6swi5FuJqQMWuAA==
From:   "tip-bot2 for Paul E. McKenney" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] rcutorture: Forgive RCU boost failures when CPUs
 don't pass through QS
Cc:     "Paul E. McKenney" <paulmck@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <162506086050.395.13117528211802125041.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the core/rcu branch of tip:

Commit-ID:     0260b92e1c39412b1e345e202355c43169c16274
Gitweb:        https://git.kernel.org/tip/0260b92e1c39412b1e345e202355c43169c16274
Author:        Paul E. McKenney <paulmck@kernel.org>
AuthorDate:    Thu, 08 Apr 2021 13:01:14 -07:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Mon, 10 May 2021 16:05:07 -07:00

rcutorture: Forgive RCU boost failures when CPUs don't pass through QS

Currently, rcu_torture_boost() runs CPU-bound at real-time priority
to force RCU priority inversions.  It then checks that grace periods
progress during this CPU-bound time.  If grace periods fail to progress,
it reports and RCU priority boosting failure.

However, it is possible (and sometimes does happen) that the grace period
fails to progress due to a CPU failing to pass through a quiescent state
for an extended time period (3.5 seconds by default).  This can happen
due to vCPU preemption, long-running interrupts, and much else besides.
There is nothing that RCU priority boosting can do about these situations,
and so they should not be counted as RCU priority boosting failures.

This commit therefore checks for CPUs (as opposed to preempted tasks)
holding up a grace period, and flags the resulting RCU priority boosting
failures, but does not splat nor count them as errors.  It does rate-limit
them to avoid flooding the console log.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/rcu.h        |  2 +-
 kernel/rcu/rcutorture.c | 67 ++++++++++++++++++++++++----------------
 kernel/rcu/tree_stall.h | 36 +++++++++++++++++++++-
 3 files changed, 79 insertions(+), 26 deletions(-)

diff --git a/kernel/rcu/rcu.h b/kernel/rcu/rcu.h
index bf0827d..daf0cd3 100644
--- a/kernel/rcu/rcu.h
+++ b/kernel/rcu/rcu.h
@@ -519,6 +519,7 @@ static inline unsigned long rcu_exp_batches_completed(void) { return 0; }
 static inline unsigned long
 srcu_batches_completed(struct srcu_struct *sp) { return 0; }
 static inline void rcu_force_quiescent_state(void) { }
+static inline bool rcu_check_boost_fail(unsigned long gp_state, int *cpup) { return true; }
 static inline void show_rcu_gp_kthreads(void) { }
 static inline int rcu_get_gp_kthreads_prio(void) { return 0; }
 static inline void rcu_fwd_progress_check(unsigned long j) { }
@@ -527,6 +528,7 @@ bool rcu_dynticks_zero_in_eqs(int cpu, int *vp);
 unsigned long rcu_get_gp_seq(void);
 unsigned long rcu_exp_batches_completed(void);
 unsigned long srcu_batches_completed(struct srcu_struct *sp);
+bool rcu_check_boost_fail(unsigned long gp_state, int *cpup);
 void show_rcu_gp_kthreads(void);
 int rcu_get_gp_kthreads_prio(void);
 void rcu_fwd_progress_check(unsigned long j);
diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
index 02a14df..5ae4dcc 100644
--- a/kernel/rcu/rcutorture.c
+++ b/kernel/rcu/rcutorture.c
@@ -340,6 +340,7 @@ struct rcu_torture_ops {
 	void (*fqs)(void);
 	void (*stats)(void);
 	void (*gp_kthread_dbg)(void);
+	bool (*check_boost_failed)(unsigned long gp_state, int *cpup);
 	int (*stall_dur)(void);
 	int irq_capable;
 	int can_boost;
@@ -483,31 +484,32 @@ static void rcu_sync_torture_init(void)
 }
 
 static struct rcu_torture_ops rcu_ops = {
-	.ttype		= RCU_FLAVOR,
-	.init		= rcu_sync_torture_init,
-	.readlock	= rcu_torture_read_lock,
-	.read_delay	= rcu_read_delay,
-	.readunlock	= rcu_torture_read_unlock,
-	.readlock_held	= torture_readlock_not_held,
-	.get_gp_seq	= rcu_get_gp_seq,
-	.gp_diff	= rcu_seq_diff,
-	.deferred_free	= rcu_torture_deferred_free,
-	.sync		= synchronize_rcu,
-	.exp_sync	= synchronize_rcu_expedited,
-	.get_gp_state	= get_state_synchronize_rcu,
-	.start_gp_poll	= start_poll_synchronize_rcu,
-	.poll_gp_state	= poll_state_synchronize_rcu,
-	.cond_sync	= cond_synchronize_rcu,
-	.call		= call_rcu,
-	.cb_barrier	= rcu_barrier,
-	.fqs		= rcu_force_quiescent_state,
-	.stats		= NULL,
-	.gp_kthread_dbg	= show_rcu_gp_kthreads,
-	.stall_dur	= rcu_jiffies_till_stall_check,
-	.irq_capable	= 1,
-	.can_boost	= IS_ENABLED(CONFIG_RCU_BOOST),
-	.extendables	= RCUTORTURE_MAX_EXTEND,
-	.name		= "rcu"
+	.ttype			= RCU_FLAVOR,
+	.init			= rcu_sync_torture_init,
+	.readlock		= rcu_torture_read_lock,
+	.read_delay		= rcu_read_delay,
+	.readunlock		= rcu_torture_read_unlock,
+	.readlock_held		= torture_readlock_not_held,
+	.get_gp_seq		= rcu_get_gp_seq,
+	.gp_diff		= rcu_seq_diff,
+	.deferred_free		= rcu_torture_deferred_free,
+	.sync			= synchronize_rcu,
+	.exp_sync		= synchronize_rcu_expedited,
+	.get_gp_state		= get_state_synchronize_rcu,
+	.start_gp_poll		= start_poll_synchronize_rcu,
+	.poll_gp_state		= poll_state_synchronize_rcu,
+	.cond_sync		= cond_synchronize_rcu,
+	.call			= call_rcu,
+	.cb_barrier		= rcu_barrier,
+	.fqs			= rcu_force_quiescent_state,
+	.stats			= NULL,
+	.gp_kthread_dbg		= show_rcu_gp_kthreads,
+	.check_boost_failed	= rcu_check_boost_fail,
+	.stall_dur		= rcu_jiffies_till_stall_check,
+	.irq_capable		= 1,
+	.can_boost		= IS_ENABLED(CONFIG_RCU_BOOST),
+	.extendables		= RCUTORTURE_MAX_EXTEND,
+	.name			= "rcu"
 };
 
 /*
@@ -918,14 +920,27 @@ static void rcu_torture_enable_rt_throttle(void)
 
 static bool rcu_torture_boost_failed(unsigned long gp_state, unsigned long start, unsigned long end)
 {
+	int cpu;
 	static int dbg_done;
 	bool gp_done;
+	unsigned long j;
+	static unsigned long last_persist;
+	unsigned long lp;
+	unsigned long mininterval = test_boost_duration * HZ - HZ / 2;
 
-	if (end - start > test_boost_duration * HZ - HZ / 2) {
+	if (end - start > mininterval) {
 		// Recheck after checking time to avoid false positives.
 		smp_mb(); // Time check before grace-period check.
 		if (cur_ops->poll_gp_state(gp_state))
 			return false; // passed, though perhaps just barely
+		if (cur_ops->check_boost_failed && !cur_ops->check_boost_failed(gp_state, &cpu)) {
+			// At most one persisted message per boost test.
+			j = jiffies;
+			lp = READ_ONCE(last_persist);
+			if (time_after(j, lp + mininterval) && cmpxchg(&last_persist, lp, j) == lp)
+				pr_info("Boost inversion persisted: No QS from CPU %d\n", cpu);
+			return false; // passed on a technicality
+		}
 		VERBOSE_TOROUT_STRING("rcu_torture_boost boosting failed");
 		n_rcu_torture_boost_failure++;
 		if (!xchg(&dbg_done, 1) && cur_ops->gp_kthread_dbg) {
diff --git a/kernel/rcu/tree_stall.h b/kernel/rcu/tree_stall.h
index 59b95cc..af92d9f 100644
--- a/kernel/rcu/tree_stall.h
+++ b/kernel/rcu/tree_stall.h
@@ -717,6 +717,42 @@ static void check_cpu_stall(struct rcu_data *rdp)
 
 
 /*
+ * Check to see if a failure to end RCU priority inversion was due to
+ * a CPU not passing through a quiescent state.  When this happens, there
+ * is nothing that RCU priority boosting can do to help, so we shouldn't
+ * count this as an RCU priority boosting failure.  A return of true says
+ * RCU priority boosting is to blame, and false says otherwise.  If false
+ * is returned, the first of the CPUs to blame is stored through cpup.
+ */
+bool rcu_check_boost_fail(unsigned long gp_state, int *cpup)
+{
+	int cpu;
+	unsigned long flags;
+	struct rcu_node *rnp;
+
+	rcu_for_each_leaf_node(rnp) {
+		raw_spin_lock_irqsave_rcu_node(rnp, flags);
+		if (!rnp->qsmask) {
+			// No CPUs without quiescent states for this rnp.
+			raw_spin_unlock_irqrestore_rcu_node(rnp, flags);
+			continue;
+		}
+		// Find the first holdout CPU.
+		for_each_leaf_node_possible_cpu(rnp, cpu) {
+			if (rnp->qsmask & (1UL << (cpu - rnp->grplo))) {
+				raw_spin_unlock_irqrestore_rcu_node(rnp, flags);
+				*cpup = cpu;
+				return false;
+			}
+		}
+		raw_spin_unlock_irqrestore_rcu_node(rnp, flags);
+	}
+	// Can't blame CPUs, so must blame RCU priority boosting.
+	return true;
+}
+EXPORT_SYMBOL_GPL(rcu_check_boost_fail);
+
+/*
  * Show the state of the grace-period kthreads.
  */
 void show_rcu_gp_kthreads(void)
