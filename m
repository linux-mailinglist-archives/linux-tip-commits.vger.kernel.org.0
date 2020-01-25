Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A5B781494C4
	for <lists+linux-tip-commits@lfdr.de>; Sat, 25 Jan 2020 11:48:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729345AbgAYKpF (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Sat, 25 Jan 2020 05:45:05 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:44332 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729760AbgAYKnS (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Sat, 25 Jan 2020 05:43:18 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1ivIuK-0000Em-1f; Sat, 25 Jan 2020 11:43:16 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id CEB691C1A90;
        Sat, 25 Jan 2020 11:42:56 +0100 (CET)
Date:   Sat, 25 Jan 2020 10:42:56 -0000
From:   "tip-bot2 for Paul E. McKenney" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] rcu: Enable tick for nohz_full CPUs slow to provide
 expedited QS
Cc:     "Paul E. McKenney" <paulmck@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <157994897654.396.5667707782512768142.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-tip-commits-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the core/rcu branch of tip:

Commit-ID:     df1e849ae4559544ff00ff5052eefe2479750539
Gitweb:        https://git.kernel.org/tip/df1e849ae4559544ff00ff5052eefe2479750539
Author:        Paul E. McKenney <paulmck@kernel.org>
AuthorDate:    Wed, 27 Nov 2019 16:36:45 -08:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Mon, 09 Dec 2019 12:32:59 -08:00

rcu: Enable tick for nohz_full CPUs slow to provide expedited QS

An expedited grace period can be stalled by a nohz_full CPU looping
in kernel context.  This possibility is currently handled by some
carefully crafted checks in rcu_read_unlock_special() that enlist help
from ksoftirqd when permitted by the scheduler.  However, it is exactly
these checks that require the scheduler avoid holding any of its rq or
pi locks across rcu_read_unlock() without also having held them across
the entire RCU read-side critical section.

It would therefore be very nice if expedited grace periods could
handle nohz_full CPUs looping in kernel context without such checks.
This commit therefore adds code to the expedited grace period's wait
and cleanup code that forces the scheduler-clock interrupt on for CPUs
that fail to quickly supply a quiescent state.  "Quickly" is currently
a hard-coded single-jiffy delay.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 include/linux/tick.h  |  5 +++-
 kernel/rcu/tree.h     |  1 +-
 kernel/rcu/tree_exp.h | 52 ++++++++++++++++++++++++++++++++++++------
 3 files changed, 50 insertions(+), 8 deletions(-)

diff --git a/include/linux/tick.h b/include/linux/tick.h
index 7896f79..7340613 100644
--- a/include/linux/tick.h
+++ b/include/linux/tick.h
@@ -109,8 +109,10 @@ enum tick_dep_bits {
 	TICK_DEP_BIT_PERF_EVENTS	= 1,
 	TICK_DEP_BIT_SCHED		= 2,
 	TICK_DEP_BIT_CLOCK_UNSTABLE	= 3,
-	TICK_DEP_BIT_RCU		= 4
+	TICK_DEP_BIT_RCU		= 4,
+	TICK_DEP_BIT_RCU_EXP		= 5
 };
+#define TICK_DEP_BIT_MAX TICK_DEP_BIT_RCU_EXP
 
 #define TICK_DEP_MASK_NONE		0
 #define TICK_DEP_MASK_POSIX_TIMER	(1 << TICK_DEP_BIT_POSIX_TIMER)
@@ -118,6 +120,7 @@ enum tick_dep_bits {
 #define TICK_DEP_MASK_SCHED		(1 << TICK_DEP_BIT_SCHED)
 #define TICK_DEP_MASK_CLOCK_UNSTABLE	(1 << TICK_DEP_BIT_CLOCK_UNSTABLE)
 #define TICK_DEP_MASK_RCU		(1 << TICK_DEP_BIT_RCU)
+#define TICK_DEP_MASK_RCU_EXP		(1 << TICK_DEP_BIT_RCU_EXP)
 
 #ifdef CONFIG_NO_HZ_COMMON
 extern bool tick_nohz_enabled;
diff --git a/kernel/rcu/tree.h b/kernel/rcu/tree.h
index 055c317..f9253ed 100644
--- a/kernel/rcu/tree.h
+++ b/kernel/rcu/tree.h
@@ -182,6 +182,7 @@ struct rcu_data {
 	bool rcu_need_heavy_qs;		/* GP old, so heavy quiescent state! */
 	bool rcu_urgent_qs;		/* GP old need light quiescent state. */
 	bool rcu_forced_tick;		/* Forced tick to provide QS. */
+	bool rcu_forced_tick_exp;	/*   ... provide QS to expedited GP. */
 #ifdef CONFIG_RCU_FAST_NO_HZ
 	bool all_lazy;			/* All CPU's CBs lazy at idle start? */
 	unsigned long last_accelerate;	/* Last jiffy CBs were accelerated. */
diff --git a/kernel/rcu/tree_exp.h b/kernel/rcu/tree_exp.h
index 081a179..30b2a02 100644
--- a/kernel/rcu/tree_exp.h
+++ b/kernel/rcu/tree_exp.h
@@ -230,7 +230,9 @@ static void __maybe_unused rcu_report_exp_rnp(struct rcu_node *rnp, bool wake)
 static void rcu_report_exp_cpu_mult(struct rcu_node *rnp,
 				    unsigned long mask, bool wake)
 {
+	int cpu;
 	unsigned long flags;
+	struct rcu_data *rdp;
 
 	raw_spin_lock_irqsave_rcu_node(rnp, flags);
 	if (!(rnp->expmask & mask)) {
@@ -238,6 +240,13 @@ static void rcu_report_exp_cpu_mult(struct rcu_node *rnp,
 		return;
 	}
 	WRITE_ONCE(rnp->expmask, rnp->expmask & ~mask);
+	for_each_leaf_node_cpu_mask(rnp, cpu, mask) {
+		rdp = per_cpu_ptr(&rcu_data, cpu);
+		if (!IS_ENABLED(CONFIG_NO_HZ_FULL) || !rdp->rcu_forced_tick_exp)
+			continue;
+		rdp->rcu_forced_tick_exp = false;
+		tick_dep_clear_cpu(cpu, TICK_DEP_BIT_RCU_EXP);
+	}
 	__rcu_report_exp_rnp(rnp, wake, flags); /* Releases rnp->lock. */
 }
 
@@ -450,6 +459,26 @@ static void sync_rcu_exp_select_cpus(void)
 }
 
 /*
+ * Wait for the expedited grace period to elapse, within time limit.
+ * If the time limit is exceeded without the grace period elapsing,
+ * return false, otherwise return true.
+ */
+static bool synchronize_rcu_expedited_wait_once(long tlimit)
+{
+	int t;
+	struct rcu_node *rnp_root = rcu_get_root();
+
+	t = swait_event_timeout_exclusive(rcu_state.expedited_wq,
+					  sync_rcu_exp_done_unlocked(rnp_root),
+					  tlimit);
+	// Workqueues should not be signaled.
+	if (t > 0 || sync_rcu_exp_done_unlocked(rnp_root))
+		return true;
+	WARN_ON(t < 0);  /* workqueues should not be signaled. */
+	return false;
+}
+
+/*
  * Wait for the expedited grace period to elapse, issuing any needed
  * RCU CPU stall warnings along the way.
  */
@@ -460,22 +489,31 @@ static void synchronize_rcu_expedited_wait(void)
 	unsigned long jiffies_start;
 	unsigned long mask;
 	int ndetected;
+	struct rcu_data *rdp;
 	struct rcu_node *rnp;
 	struct rcu_node *rnp_root = rcu_get_root();
-	int ret;
 
 	trace_rcu_exp_grace_period(rcu_state.name, rcu_exp_gp_seq_endval(), TPS("startwait"));
 	jiffies_stall = rcu_jiffies_till_stall_check();
 	jiffies_start = jiffies;
+	if (IS_ENABLED(CONFIG_NO_HZ_FULL)) {
+		if (synchronize_rcu_expedited_wait_once(1))
+			return;
+		rcu_for_each_leaf_node(rnp) {
+			for_each_leaf_node_cpu_mask(rnp, cpu, rnp->expmask) {
+				rdp = per_cpu_ptr(&rcu_data, cpu);
+				if (rdp->rcu_forced_tick_exp)
+					continue;
+				rdp->rcu_forced_tick_exp = true;
+				tick_dep_set_cpu(cpu, TICK_DEP_BIT_RCU_EXP);
+			}
+		}
+		WARN_ON_ONCE(1);
+	}
 
 	for (;;) {
-		ret = swait_event_timeout_exclusive(
-				rcu_state.expedited_wq,
-				sync_rcu_exp_done_unlocked(rnp_root),
-				jiffies_stall);
-		if (ret > 0 || sync_rcu_exp_done_unlocked(rnp_root))
+		if (synchronize_rcu_expedited_wait_once(jiffies_stall))
 			return;
-		WARN_ON(ret < 0);  /* workqueues should not be signaled. */
 		if (rcu_cpu_stall_suppress)
 			continue;
 		panic_on_rcu_stall();
