Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B6BE3B83B5
	for <lists+linux-tip-commits@lfdr.de>; Wed, 30 Jun 2021 15:48:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235219AbhF3Nuk (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 30 Jun 2021 09:50:40 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:32892 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235626AbhF3NuK (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 30 Jun 2021 09:50:10 -0400
Date:   Wed, 30 Jun 2021 13:47:40 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1625060860;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=EtJO2JvnFWEeEnk8MjgElbz9UBB89rjpHTdLcKKIxl4=;
        b=p1lSP/ySFrlgyx6SWqCeTz46HPaIr4TU7PmaQtL4H0BCmeP1sHEc4S5DL6LDRiMwKsbZOe
        PfzO67H44wY/qKIi2LPoaEc3Clb8+qb+F9dgorLIro6/bIzuAej9kVDHP9QAK5gaaBXk2h
        m4V9x5CZKTDmCRcPEVq1XcbBGIRC+CgdIvz44+gKNbXXEm0j+WDqcvZ9i3qV4cz+BdAd6g
        vYvjoBgAlCS/sokMHI7/38cRRjxb7P4+4ojDr0HATgbKPAQV5+PX3wzlZU5WEOya1fxdcx
        Z7P8A008JvwK16/L6SIF1YdKIbp0uruC25r7fvhNnCDBXsOhPSaq6uYseF9MJQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1625060860;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=EtJO2JvnFWEeEnk8MjgElbz9UBB89rjpHTdLcKKIxl4=;
        b=BfFabmsqy3q7AY/6oYn2eMboCqDo591EaZ+2+kVNfZa/Jfy7zz8k12jywE58GnlbnLzcCr
        9x7mTnp1Q+BcYmBA==
From:   "tip-bot2 for Paul E. McKenney" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] rcutorture: Don't count CPU-stalled time against
 priority boosting
Cc:     "Paul E. McKenney" <paulmck@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <162506086003.395.8551339587665909409.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the core/rcu branch of tip:

Commit-ID:     063f5a4df99145ba0a5d4879d171a8175235f37b
Gitweb:        https://git.kernel.org/tip/063f5a4df99145ba0a5d4879d171a8175235f37b
Author:        Paul E. McKenney <paulmck@kernel.org>
AuthorDate:    Wed, 14 Apr 2021 13:00:10 -07:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Mon, 10 May 2021 16:05:07 -07:00

rcutorture: Don't count CPU-stalled time against priority boosting

It will frequently be the case that rcu_torture_boost() will get a
->start_gp_poll() cookie that needs almost all of the current grace period
plus an additional grace period to elapse before ->poll_gp_state() will
return true.  It is quite possible that the current grace period will have
(say) two seconds of stall by a CPU failing to pass through a quiescent
state, followed by 300 milliseconds of delay due to a preempted reader.
The next grace period might suffer only one second of stall by a CPU,
followed by another 300 milliseconds of delay due to a preempted reader.
This is an example of RCU priority boosting doing its job, but the full
elapsed time of 3.6 seconds exceeds the 3.5-second limit.  In addition,
there is no CPU stall in force at the 3.5-second mark, so this would
nevertheless currently be counted as an RCU priority boosting failure.

This commit therefore avoids this sort of false positive by resetting
the gp_state_time timestamp any time that the current grace period is
being blocked by a CPU.  This results in extremely frequent calls to
the ->check_boost_failed() function, so this commit provides a lockless
fastpath that is selected by supplying a NULL CPU-number pointer.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/rcutorture.c | 13 ++++++++-----
 kernel/rcu/tree_stall.h | 10 ++++++++++
 2 files changed, 18 insertions(+), 5 deletions(-)

diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
index 5ae4dcc..8b347b9 100644
--- a/kernel/rcu/rcutorture.c
+++ b/kernel/rcu/rcutorture.c
@@ -918,17 +918,18 @@ static void rcu_torture_enable_rt_throttle(void)
 	old_rt_runtime = -1;
 }
 
-static bool rcu_torture_boost_failed(unsigned long gp_state, unsigned long start, unsigned long end)
+static bool rcu_torture_boost_failed(unsigned long gp_state, unsigned long *start)
 {
 	int cpu;
 	static int dbg_done;
+	unsigned long end = jiffies;
 	bool gp_done;
 	unsigned long j;
 	static unsigned long last_persist;
 	unsigned long lp;
 	unsigned long mininterval = test_boost_duration * HZ - HZ / 2;
 
-	if (end - start > mininterval) {
+	if (end - *start > mininterval) {
 		// Recheck after checking time to avoid false positives.
 		smp_mb(); // Time check before grace-period check.
 		if (cur_ops->poll_gp_state(gp_state))
@@ -945,7 +946,7 @@ static bool rcu_torture_boost_failed(unsigned long gp_state, unsigned long start
 		n_rcu_torture_boost_failure++;
 		if (!xchg(&dbg_done, 1) && cur_ops->gp_kthread_dbg) {
 			pr_info("Boost inversion thread ->rt_priority %u gp_state %lu jiffies %lu\n",
-				current->rt_priority, gp_state, end - start);
+				current->rt_priority, gp_state, end - *start);
 			cur_ops->gp_kthread_dbg();
 			// Recheck after print to flag grace period ending during splat.
 			gp_done = cur_ops->poll_gp_state(gp_state);
@@ -955,6 +956,8 @@ static bool rcu_torture_boost_failed(unsigned long gp_state, unsigned long start
 		}
 
 		return true; // failed
+	} else if (cur_ops->check_boost_failed && !cur_ops->check_boost_failed(gp_state, NULL)) {
+		*start = jiffies;
 	}
 
 	return false; // passed
@@ -995,7 +998,7 @@ static int rcu_torture_boost(void *arg)
 		while (time_before(jiffies, endtime)) {
 			// Has current GP gone too long?
 			if (gp_initiated && !failed && !cur_ops->poll_gp_state(gp_state))
-				failed = rcu_torture_boost_failed(gp_state, gp_state_time, jiffies);
+				failed = rcu_torture_boost_failed(gp_state, &gp_state_time);
 			// If we don't have a grace period in flight, start one.
 			if (!gp_initiated || cur_ops->poll_gp_state(gp_state)) {
 				gp_state = cur_ops->start_gp_poll();
@@ -1016,7 +1019,7 @@ static int rcu_torture_boost(void *arg)
 
 		// In case the grace period extended beyond the end of the loop.
 		if (gp_initiated && !failed && !cur_ops->poll_gp_state(gp_state))
-			rcu_torture_boost_failed(gp_state, gp_state_time, jiffies);
+			rcu_torture_boost_failed(gp_state, &gp_state_time);
 
 		/*
 		 * Set the start time of the next test interval.
diff --git a/kernel/rcu/tree_stall.h b/kernel/rcu/tree_stall.h
index af92d9f..8bde1b5 100644
--- a/kernel/rcu/tree_stall.h
+++ b/kernel/rcu/tree_stall.h
@@ -723,6 +723,10 @@ static void check_cpu_stall(struct rcu_data *rdp)
  * count this as an RCU priority boosting failure.  A return of true says
  * RCU priority boosting is to blame, and false says otherwise.  If false
  * is returned, the first of the CPUs to blame is stored through cpup.
+ *
+ * If cpup is NULL, then a lockless quick check is carried out, suitable
+ * for high-rate usage.  On the other hand, if cpup is non-NULL, each
+ * rcu_node structure's ->lock is acquired, ruling out high-rate usage.
  */
 bool rcu_check_boost_fail(unsigned long gp_state, int *cpup)
 {
@@ -731,6 +735,12 @@ bool rcu_check_boost_fail(unsigned long gp_state, int *cpup)
 	struct rcu_node *rnp;
 
 	rcu_for_each_leaf_node(rnp) {
+		if (!cpup) {
+			if (READ_ONCE(rnp->qsmask))
+				return false;
+			else
+				continue;
+		}
 		raw_spin_lock_irqsave_rcu_node(rnp, flags);
 		if (!rnp->qsmask) {
 			// No CPUs without quiescent states for this rnp.
