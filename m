Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 98F1B3B83BD
	for <lists+linux-tip-commits@lfdr.de>; Wed, 30 Jun 2021 15:48:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235919AbhF3Nuq (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 30 Jun 2021 09:50:46 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:33060 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235684AbhF3NuO (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 30 Jun 2021 09:50:14 -0400
Date:   Wed, 30 Jun 2021 13:47:44 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1625060864;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=cSLS9f8U+C68DyG1aadaYNXYRm1dv6QsAbf1SZz0wb8=;
        b=z38xA1XywFVuvGFVz4OP3JBqDm4HpPRfXLsrzIEG5Q80s3PJGN4RXSkQLtnfDXQZVJGSg+
        i60PV2r/2riZgJwt3s7UaRQsHDEUFcadsytUtX31toOMgMD2DvwnZ8QTQkLJvz+e/bewbx
        P9GY+NIyaswCAQAy/506MucovvGSp2u74TEMjKgwFT9fNeZhDs4B9V67eBzhObNFc7lTqU
        lvF6j4voIgLe82hPRsP6I7OCDD6YxIDIsPNziegKIBsHRrsWiodtAm6H6MKddlRctZqzk2
        /EGNTfjguf+rYM4HOVnaVuIEjNe+ZgAGHY7h0NFrECn8uuzzspUs2q8QJ68Vbw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1625060864;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=cSLS9f8U+C68DyG1aadaYNXYRm1dv6QsAbf1SZz0wb8=;
        b=lhUJH6DLMkIFql8Skwgh6BSCIk2xPbeIz8/ouTG/yno38oGS0YPOto/0nO8SDKLo6k3iny
        DAiZTBqWnGLmuFBA==
From:   "tip-bot2 for Paul E. McKenney" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] rcutorture: Judge RCU priority boosting on grace
 periods, not callbacks
Cc:     "Paul E. McKenney" <paulmck@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <162506086408.395.963173561919812795.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the core/rcu branch of tip:

Commit-ID:     ea6d962e80b61996aeacb443661cc3adcb605315
Gitweb:        https://git.kernel.org/tip/ea6d962e80b61996aeacb443661cc3adcb605315
Author:        Paul E. McKenney <paulmck@kernel.org>
AuthorDate:    Tue, 30 Mar 2021 16:30:32 -07:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Mon, 10 May 2021 16:05:06 -07:00

rcutorture: Judge RCU priority boosting on grace periods, not callbacks

Currently, rcutorture's testing of RCU priority boosting insists not
only that grace periods complete, but also that callbacks be invoked.
Although this is in fact what the user would want, ensuring that there
is sufficient CPU bandwidth devoted to callback execution is in fact
the user's responsibility.  One could argue that rcutorture can take on
that responsibility, which is true in theory.  But in practice, ensuring
sufficient CPU bandwidth to ksoftirqd, any rcuc kthreads, and any rcuo
kthreads is not particularly consistent with rcutorture's main job,
that of stress-testing RCU.  In addition, if the system administrator
(say) makes very poor choices when pinning rcuo kthreads and then runs
rcutorture, there really isn't much rcutorture can do.

Besides, RCU priority boosting only boosts lagging readers, not all the
machinery required to invoke callbacks in a timely fashion.

This commit therefore switches rcutorture's evaluation of RCU priority
boosting from callback execution to grace-period completion by using
the new start_poll_synchronize_rcu() and poll_state_synchronize_rcu()
functions.  When rcutorture is built in (as in when there is no innocent
workload to inconvenience), the ksoftirqd ktheads are boosted to real-time
priority 2 in order to allow timeouts to work properly in the face of
rcutorture's testing of RCU priority boosting.

Indeed, it is not as easy as it looks to create a reliable test of RCU
priority boosting without destroying the rest of the kernel!

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/rcutorture.c | 111 +++++++++++++++++----------------------
 1 file changed, 51 insertions(+), 60 deletions(-)

diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
index bf488f9..06d08f4 100644
--- a/kernel/rcu/rcutorture.c
+++ b/kernel/rcu/rcutorture.c
@@ -245,12 +245,6 @@ static const char *rcu_torture_writer_state_getname(void)
 	return rcu_torture_writer_state_names[i];
 }
 
-#if defined(CONFIG_RCU_BOOST) && defined(CONFIG_PREEMPT_RT)
-# define rcu_can_boost() 1
-#else
-# define rcu_can_boost() 0
-#endif
-
 #ifdef CONFIG_RCU_TRACE
 static u64 notrace rcu_trace_clock_local(void)
 {
@@ -511,7 +505,7 @@ static struct rcu_torture_ops rcu_ops = {
 	.gp_kthread_dbg	= show_rcu_gp_kthreads,
 	.stall_dur	= rcu_jiffies_till_stall_check,
 	.irq_capable	= 1,
-	.can_boost	= rcu_can_boost(),
+	.can_boost	= IS_ENABLED(CONFIG_RCU_BOOST),
 	.extendables	= RCUTORTURE_MAX_EXTEND,
 	.name		= "rcu"
 };
@@ -891,25 +885,11 @@ static unsigned long rcutorture_seq_diff(unsigned long new, unsigned long old)
 
 /*
  * RCU torture priority-boost testing.  Runs one real-time thread per
- * CPU for moderate bursts, repeatedly registering RCU callbacks and
- * spinning waiting for them to be invoked.  If a given callback takes
- * too long to be invoked, we assume that priority inversion has occurred.
+ * CPU for moderate bursts, repeatedly starting grace periods and waiting
+ * for them to complete.  If a given grace period takes too long, we assume
+ * that priority inversion has occurred.
  */
 
-struct rcu_boost_inflight {
-	struct rcu_head rcu;
-	int inflight;
-};
-
-static void rcu_torture_boost_cb(struct rcu_head *head)
-{
-	struct rcu_boost_inflight *rbip =
-		container_of(head, struct rcu_boost_inflight, rcu);
-
-	/* Ensure RCU-core accesses precede clearing ->inflight */
-	smp_store_release(&rbip->inflight, 0);
-}
-
 static int old_rt_runtime = -1;
 
 static void rcu_torture_disable_rt_throttle(void)
@@ -936,15 +916,18 @@ static void rcu_torture_enable_rt_throttle(void)
 	old_rt_runtime = -1;
 }
 
-static bool rcu_torture_boost_failed(unsigned long start, unsigned long end)
+static bool rcu_torture_boost_failed(unsigned long gp_state, unsigned long start, unsigned long end)
 {
 	static int dbg_done;
 
 	if (end - start > test_boost_duration * HZ - HZ / 2) {
 		VERBOSE_TOROUT_STRING("rcu_torture_boost boosting failed");
 		n_rcu_torture_boost_failure++;
-		if (!xchg(&dbg_done, 1) && cur_ops->gp_kthread_dbg)
+		if (!xchg(&dbg_done, 1) && cur_ops->gp_kthread_dbg) {
+			pr_info("Boost inversion thread ->rt_priority %u gp_state %lu jiffies %lu\n",
+				current->rt_priority, gp_state, end - start);
 			cur_ops->gp_kthread_dbg();
+		}
 
 		return true; /* failed */
 	}
@@ -954,21 +937,20 @@ static bool rcu_torture_boost_failed(unsigned long start, unsigned long end)
 
 static int rcu_torture_boost(void *arg)
 {
-	unsigned long call_rcu_time;
 	unsigned long endtime;
+	unsigned long gp_state;
+	unsigned long gp_state_time;
 	unsigned long oldstarttime;
-	struct rcu_boost_inflight rbi = { .inflight = 0 };
 
 	VERBOSE_TOROUT_STRING("rcu_torture_boost started");
 
 	/* Set real-time priority. */
 	sched_set_fifo_low(current);
 
-	init_rcu_head_on_stack(&rbi.rcu);
 	/* Each pass through the following loop does one boost-test cycle. */
 	do {
 		bool failed = false; // Test failed already in this test interval
-		bool firsttime = true;
+		bool gp_initiated = false;
 
 		/* Increment n_rcu_torture_boosts once per boost-test */
 		while (!kthread_should_stop()) {
@@ -992,33 +974,33 @@ static int rcu_torture_boost(void *arg)
 				goto checkwait;
 		}
 
-		/* Do one boost-test interval. */
+		// Do one boost-test interval.
 		endtime = oldstarttime + test_boost_duration * HZ;
 		while (time_before(jiffies, endtime)) {
-			/* If we don't have a callback in flight, post one. */
-			if (!smp_load_acquire(&rbi.inflight)) {
-				/* RCU core before ->inflight = 1. */
-				smp_store_release(&rbi.inflight, 1);
-				cur_ops->call(&rbi.rcu, rcu_torture_boost_cb);
-				/* Check if the boost test failed */
-				if (!firsttime && !failed)
-					failed = rcu_torture_boost_failed(call_rcu_time, jiffies);
-				call_rcu_time = jiffies;
-				firsttime = false;
+			// Has current GP gone too long?
+			if (gp_initiated && !failed && !cur_ops->poll_gp_state(gp_state))
+				failed = rcu_torture_boost_failed(gp_state, gp_state_time, jiffies);
+			// If we don't have a grace period in flight, start one.
+			if (!gp_initiated || cur_ops->poll_gp_state(gp_state)) {
+				gp_state = cur_ops->start_gp_poll();
+				gp_initiated = true;
+				gp_state_time = jiffies;
 			}
-			if (stutter_wait("rcu_torture_boost"))
+			if (stutter_wait("rcu_torture_boost")) {
 				sched_set_fifo_low(current);
+				// If the grace period already ended,
+				// we don't know when that happened, so
+				// start over.
+				if (cur_ops->poll_gp_state(gp_state))
+					gp_initiated = false;
+			}
 			if (torture_must_stop())
 				goto checkwait;
 		}
 
-		/*
-		 * If boost never happened, then inflight will always be 1, in
-		 * this case the boost check would never happen in the above
-		 * loop so do another one here.
-		 */
-		if (!firsttime && !failed && smp_load_acquire(&rbi.inflight))
-			rcu_torture_boost_failed(call_rcu_time, jiffies);
+		// In case the grace period extended beyond the end of the loop.
+		if (gp_initiated && !failed && !cur_ops->poll_gp_state(gp_state))
+			rcu_torture_boost_failed(gp_state, gp_state_time, jiffies);
 
 		/*
 		 * Set the start time of the next test interval.
@@ -1027,11 +1009,9 @@ static int rcu_torture_boost(void *arg)
 		 * interval.  Besides, we are running at RT priority,
 		 * so delays should be relatively rare.
 		 */
-		while (oldstarttime == boost_starttime &&
-		       !kthread_should_stop()) {
+		while (oldstarttime == boost_starttime && !kthread_should_stop()) {
 			if (mutex_trylock(&boost_mutex)) {
-				boost_starttime = jiffies +
-						  test_boost_interval * HZ;
+				boost_starttime = jiffies + test_boost_interval * HZ;
 				mutex_unlock(&boost_mutex);
 				break;
 			}
@@ -1043,15 +1023,11 @@ checkwait:	if (stutter_wait("rcu_torture_boost"))
 			sched_set_fifo_low(current);
 	} while (!torture_must_stop());
 
-	while (smp_load_acquire(&rbi.inflight))
-		schedule_timeout_uninterruptible(1); // rcu_barrier() deadlocks.
-
 	/* Clean up and exit. */
-	while (!kthread_should_stop() || smp_load_acquire(&rbi.inflight)) {
+	while (!kthread_should_stop()) {
 		torture_shutdown_absorb("rcu_torture_boost");
 		schedule_timeout_uninterruptible(1);
 	}
-	destroy_rcu_head_on_stack(&rbi.rcu);
 	torture_kthread_stopping("rcu_torture_boost");
 	return 0;
 }
@@ -2643,7 +2619,7 @@ static bool rcu_torture_can_boost(void)
 
 	if (!(test_boost == 1 && cur_ops->can_boost) && test_boost != 2)
 		return false;
-	if (!cur_ops->call)
+	if (!cur_ops->start_gp_poll || !cur_ops->poll_gp_state)
 		return false;
 
 	prio = rcu_get_gp_kthreads_prio();
@@ -2651,7 +2627,7 @@ static bool rcu_torture_can_boost(void)
 		return false;
 
 	if (prio < 2) {
-		if (boost_warn_once  == 1)
+		if (boost_warn_once == 1)
 			return false;
 
 		pr_alert("%s: WARN: RCU kthread priority too low to test boosting.  Skipping RCU boost test. Try passing rcutree.kthread_prio > 1 on the kernel command line.\n", KBUILD_MODNAME);
@@ -3129,6 +3105,21 @@ rcu_torture_init(void)
 		if (firsterr < 0)
 			goto unwind;
 		rcutor_hp = firsterr;
+
+		// Testing RCU priority boosting requires rcutorture do
+		// some serious abuse.  Counter this by running ksoftirqd
+		// at higher priority.
+		if (IS_BUILTIN(CONFIG_RCU_TORTURE_TEST)) {
+			for_each_online_cpu(cpu) {
+				struct sched_param sp;
+				struct task_struct *t;
+
+				t = per_cpu(ksoftirqd, cpu);
+				WARN_ON_ONCE(!t);
+				sp.sched_priority = 2;
+				sched_setscheduler_nocheck(t, SCHED_FIFO, &sp);
+			}
+		}
 	}
 	shutdown_jiffies = jiffies + shutdown_secs * HZ;
 	firsterr = torture_shutdown_init(shutdown_secs, rcu_torture_cleanup);
