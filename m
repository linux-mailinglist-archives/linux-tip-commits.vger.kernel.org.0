Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0418035B4F4
	for <lists+linux-tip-commits@lfdr.de>; Sun, 11 Apr 2021 15:48:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235943AbhDKNo2 (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Sun, 11 Apr 2021 09:44:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235786AbhDKNoH (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Sun, 11 Apr 2021 09:44:07 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39A19C06138D;
        Sun, 11 Apr 2021 06:43:51 -0700 (PDT)
Date:   Sun, 11 Apr 2021 13:43:35 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1618148615;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=hZmB+BlO56zOiz2rqkvc1g3YMe2ak8QxLKFIrUA3kMg=;
        b=Cj2OPOWU/wVRQEqOp/kjhipTIy/XAEb+xfPjJK2brYrnwN0W84m509/PMhupoTh9yDIk6u
        O186XDGedhgEMPCzb8gT+HHbJKUfCx+pdluklkiwl2P++NimaiuC9VRXsv1Ho2DgRIKM1f
        ZNUJrnmwSDf4ZqlGyOUcHJBcXGYcV1XMv6iBvcUG819o9moo2/CJenzC3QdfIYGulSCZy5
        maKa5ORMPttk4y7OihltO6GW1x1+xplUhMvEanuyTzi+1ca34Gq3Nv8VQ80FhwN1bAIyiV
        wdB5xQ6doj5dEBSCr669Yw5nuUIHbHVSuv+hiGfmjK+R3ZpgqOdwxuUl0RTQgQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1618148615;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=hZmB+BlO56zOiz2rqkvc1g3YMe2ak8QxLKFIrUA3kMg=;
        b=XZXzLHOzxxtHYCZwXH6iMVtq0OmKwOGNtnV/sdbrhthtVsYEdsd4GZ4nplCyJjt9dJtQTJ
        pBGjYied9RmEy5CQ==
From:   "tip-bot2 for Paul E. McKenney" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] rcutorture: Fix testing of RCU priority boosting
Cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Scott Wood <swood@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Paul E. McKenney" <paulmck@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <161814861521.29796.11487622403532211048.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the core/rcu branch of tip:

Commit-ID:     5e59fba573e64cffc3a7a3113fff2336d652f45a
Gitweb:        https://git.kernel.org/tip/5e59fba573e64cffc3a7a3113fff2336d652f45a
Author:        Paul E. McKenney <paulmck@kernel.org>
AuthorDate:    Fri, 15 Jan 2021 13:30:38 -08:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Mon, 08 Mar 2021 14:21:41 -08:00

rcutorture: Fix testing of RCU priority boosting

Currently, rcutorture refuses to test RCU priority boosting in
CONFIG_HOTPLUG_CPU=y kernels, which are the only kind normally built on
x86 these days.  This commit therefore updates rcutorture's tests of RCU
priority boosting to make them safe for CPU hotplug.  However, these tests
will fail unless TIMER_SOFTIRQ runs at realtime priority, which does not
happen in current mainline.  This commit therefore also refuses to test
RCU priority boosting except in kernels built with CONFIG_PREEMPT_RT=y.

While in the area, this commt adds some debug output at boost-fail time
that helps diagnose the cause of the failure, for example, failing to
run TIMER_SOFTIRQ at realtime priority.

Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Scott Wood <swood@redhat.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/rcutorture.c | 36 ++++++++++++++++++++++--------------
 1 file changed, 22 insertions(+), 14 deletions(-)

diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
index 99657ff..af64bd8 100644
--- a/kernel/rcu/rcutorture.c
+++ b/kernel/rcu/rcutorture.c
@@ -245,11 +245,11 @@ static const char *rcu_torture_writer_state_getname(void)
 	return rcu_torture_writer_state_names[i];
 }
 
-#if defined(CONFIG_RCU_BOOST) && !defined(CONFIG_HOTPLUG_CPU)
-#define rcu_can_boost() 1
-#else /* #if defined(CONFIG_RCU_BOOST) && !defined(CONFIG_HOTPLUG_CPU) */
-#define rcu_can_boost() 0
-#endif /* #else #if defined(CONFIG_RCU_BOOST) && !defined(CONFIG_HOTPLUG_CPU) */
+#if defined(CONFIG_RCU_BOOST) && defined(CONFIG_PREEMPT_RT)
+# define rcu_can_boost() 1
+#else
+# define rcu_can_boost() 0
+#endif
 
 #ifdef CONFIG_RCU_TRACE
 static u64 notrace rcu_trace_clock_local(void)
@@ -923,9 +923,13 @@ static void rcu_torture_enable_rt_throttle(void)
 
 static bool rcu_torture_boost_failed(unsigned long start, unsigned long end)
 {
+	static int dbg_done;
+
 	if (end - start > test_boost_duration * HZ - HZ / 2) {
 		VERBOSE_TOROUT_STRING("rcu_torture_boost boosting failed");
 		n_rcu_torture_boost_failure++;
+		if (!xchg(&dbg_done, 1) && cur_ops->gp_kthread_dbg)
+			cur_ops->gp_kthread_dbg();
 
 		return true; /* failed */
 	}
@@ -948,8 +952,8 @@ static int rcu_torture_boost(void *arg)
 	init_rcu_head_on_stack(&rbi.rcu);
 	/* Each pass through the following loop does one boost-test cycle. */
 	do {
-		/* Track if the test failed already in this test interval? */
-		bool failed = false;
+		bool failed = false; // Test failed already in this test interval
+		bool firsttime = true;
 
 		/* Increment n_rcu_torture_boosts once per boost-test */
 		while (!kthread_should_stop()) {
@@ -975,18 +979,17 @@ static int rcu_torture_boost(void *arg)
 
 		/* Do one boost-test interval. */
 		endtime = oldstarttime + test_boost_duration * HZ;
-		call_rcu_time = jiffies;
 		while (time_before(jiffies, endtime)) {
 			/* If we don't have a callback in flight, post one. */
 			if (!smp_load_acquire(&rbi.inflight)) {
 				/* RCU core before ->inflight = 1. */
 				smp_store_release(&rbi.inflight, 1);
-				call_rcu(&rbi.rcu, rcu_torture_boost_cb);
+				cur_ops->call(&rbi.rcu, rcu_torture_boost_cb);
 				/* Check if the boost test failed */
-				failed = failed ||
-					 rcu_torture_boost_failed(call_rcu_time,
-								 jiffies);
+				if (!firsttime && !failed)
+					failed = rcu_torture_boost_failed(call_rcu_time, jiffies);
 				call_rcu_time = jiffies;
+				firsttime = false;
 			}
 			if (stutter_wait("rcu_torture_boost"))
 				sched_set_fifo_low(current);
@@ -999,7 +1002,7 @@ static int rcu_torture_boost(void *arg)
 		 * this case the boost check would never happen in the above
 		 * loop so do another one here.
 		 */
-		if (!failed && smp_load_acquire(&rbi.inflight))
+		if (!firsttime && !failed && smp_load_acquire(&rbi.inflight))
 			rcu_torture_boost_failed(call_rcu_time, jiffies);
 
 		/*
@@ -1025,6 +1028,9 @@ checkwait:	if (stutter_wait("rcu_torture_boost"))
 			sched_set_fifo_low(current);
 	} while (!torture_must_stop());
 
+	while (smp_load_acquire(&rbi.inflight))
+		schedule_timeout_uninterruptible(1); // rcu_barrier() deadlocks.
+
 	/* Clean up and exit. */
 	while (!kthread_should_stop() || smp_load_acquire(&rbi.inflight)) {
 		torture_shutdown_absorb("rcu_torture_boost");
@@ -1797,7 +1803,7 @@ rcu_torture_stats_print(void)
 		WARN_ON_ONCE(n_rcu_torture_barrier_error);  // rcu_barrier()
 		WARN_ON_ONCE(n_rcu_torture_boost_ktrerror); // no boost kthread
 		WARN_ON_ONCE(n_rcu_torture_boost_rterror); // can't set RT prio
-		WARN_ON_ONCE(n_rcu_torture_boost_failure); // RCU boost failed
+		WARN_ON_ONCE(n_rcu_torture_boost_failure); // boost failed (TIMER_SOFTIRQ RT prio?)
 		WARN_ON_ONCE(i > 1); // Too-short grace period
 	}
 	pr_cont("Reader Pipe: ");
@@ -2595,6 +2601,8 @@ static bool rcu_torture_can_boost(void)
 
 	if (!(test_boost == 1 && cur_ops->can_boost) && test_boost != 2)
 		return false;
+	if (!cur_ops->call)
+		return false;
 
 	prio = rcu_get_gp_kthreads_prio();
 	if (!prio)
