Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ACB1635B500
	for <lists+linux-tip-commits@lfdr.de>; Sun, 11 Apr 2021 15:49:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235992AbhDKNoj (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Sun, 11 Apr 2021 09:44:39 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:33296 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235627AbhDKNoN (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Sun, 11 Apr 2021 09:44:13 -0400
Date:   Sun, 11 Apr 2021 13:43:38 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1618148618;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=6R1aNChp3v64YU0arxt7Y0pQmcqBbrXdg4XPaZLIcmM=;
        b=seWxMuvX309Iq+dxD9Ow+uxJglwqPf/ahH1xW/SZl/THGPTmXwiZNAeMNeXufWgSgrglXZ
        lQZBx3dH3LZJyMlW+Wt2BZjMpWkl+YVmSk6fVJ5GLLphr3odMYLLv6iaEwQPe+BGNf1SSS
        oX2Nu9WJa/t0MLXQWEXE4DPPIUa7iS8vWsLKvXsbsqteaMiyiXN0SHF9P8gIgfAXdm8HBx
        zn3CBkHlITiC8y1Et0mScCfYIYt+WQMqK05UcLVSRadkNCgZU8iq+sPgVPCg6s5zo+QgJl
        rBomtwVXIIkeNN5deXP+yP0avhi7Qr8rZPG5MvjPj2kP0GotNxJqL1X5DmyHiA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1618148618;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=6R1aNChp3v64YU0arxt7Y0pQmcqBbrXdg4XPaZLIcmM=;
        b=pFkyfHhj1hBkKmgqnvHx8Lb9QdBJ8lTFqU7cAv8gyOw0kBMYNj3Wbl9F9sab7yoIXc2vy6
        GJRdlw8y7k6/ANAA==
From:   "tip-bot2 for Frederic Weisbecker" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] rcu/nocb: Detect unsafe checks for offloaded rdp
Cc:     Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Neeraj Upadhyay <neeraju@codeaurora.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Boqun Feng <boqun.feng@gmail.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <161814861809.29796.14540281963859173487.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the core/rcu branch of tip:

Commit-ID:     3820b513a2e33d6dee1caa3b4815f92079cb9890
Gitweb:        https://git.kernel.org/tip/3820b513a2e33d6dee1caa3b4815f92079cb9890
Author:        Frederic Weisbecker <frederic@kernel.org>
AuthorDate:    Thu, 12 Nov 2020 01:51:21 +01:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Mon, 08 Mar 2021 14:20:20 -08:00

rcu/nocb: Detect unsafe checks for offloaded rdp

Provide CONFIG_PROVE_RCU sanity checks to ensure we are always reading
the offloaded state of an rdp in a safe and stable way and prevent from
its value to be changed under us. We must either hold the barrier mutex,
the cpu-hotplug lock (read or write) or the nocb lock.
Local non-preemptible reads are also safe. NOCB kthreads and timers have
their own means of synchronization against the offloaded state updaters.

Cc: Josh Triplett <josh@joshtriplett.org>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Lai Jiangshan <jiangshanlai@gmail.com>
Cc: Joel Fernandes <joel@joelfernandes.org>
Cc: Neeraj Upadhyay <neeraju@codeaurora.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Boqun Feng <boqun.feng@gmail.com>
Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tree.c        | 21 ++++-----
 kernel/rcu/tree_plugin.h | 90 ++++++++++++++++++++++++++++++++-------
 2 files changed, 87 insertions(+), 24 deletions(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index da6f521..03503e2 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -156,6 +156,7 @@ static void invoke_rcu_core(void);
 static void rcu_report_exp_rdp(struct rcu_data *rdp);
 static void sync_sched_exp_online_cleanup(int cpu);
 static void check_cb_ovld_locked(struct rcu_data *rdp, struct rcu_node *rnp);
+static bool rcu_rdp_is_offloaded(struct rcu_data *rdp);
 
 /* rcuc/rcub kthread realtime priority */
 static int kthread_prio = IS_ENABLED(CONFIG_RCU_BOOST) ? 1 : 0;
@@ -1672,7 +1673,7 @@ static bool __note_gp_changes(struct rcu_node *rnp, struct rcu_data *rdp)
 {
 	bool ret = false;
 	bool need_qs;
-	const bool offloaded = rcu_segcblist_is_offloaded(&rdp->cblist);
+	const bool offloaded = rcu_rdp_is_offloaded(rdp);
 
 	raw_lockdep_assert_held_rcu_node(rnp);
 
@@ -2128,7 +2129,7 @@ static void rcu_gp_cleanup(void)
 		needgp = true;
 	}
 	/* Advance CBs to reduce false positives below. */
-	offloaded = rcu_segcblist_is_offloaded(&rdp->cblist);
+	offloaded = rcu_rdp_is_offloaded(rdp);
 	if ((offloaded || !rcu_accelerate_cbs(rnp, rdp)) && needgp) {
 		WRITE_ONCE(rcu_state.gp_flags, RCU_GP_FLAG_INIT);
 		WRITE_ONCE(rcu_state.gp_req_activity, jiffies);
@@ -2327,7 +2328,7 @@ rcu_report_qs_rdp(struct rcu_data *rdp)
 	unsigned long flags;
 	unsigned long mask;
 	bool needwake = false;
-	const bool offloaded = rcu_segcblist_is_offloaded(&rdp->cblist);
+	const bool offloaded = rcu_rdp_is_offloaded(rdp);
 	struct rcu_node *rnp;
 
 	WARN_ON_ONCE(rdp->cpu != smp_processor_id());
@@ -2497,7 +2498,7 @@ static void rcu_do_batch(struct rcu_data *rdp)
 	int div;
 	bool __maybe_unused empty;
 	unsigned long flags;
-	const bool offloaded = rcu_segcblist_is_offloaded(&rdp->cblist);
+	const bool offloaded = rcu_rdp_is_offloaded(rdp);
 	struct rcu_head *rhp;
 	struct rcu_cblist rcl = RCU_CBLIST_INITIALIZER(rcl);
 	long bl, count = 0;
@@ -3066,7 +3067,7 @@ __call_rcu(struct rcu_head *head, rcu_callback_t func)
 	trace_rcu_segcb_stats(&rdp->cblist, TPS("SegCBQueued"));
 
 	/* Go handle any RCU core processing required. */
-	if (unlikely(rcu_segcblist_is_offloaded(&rdp->cblist))) {
+	if (unlikely(rcu_rdp_is_offloaded(rdp))) {
 		__call_rcu_nocb_wake(rdp, was_alldone, flags); /* unlocks */
 	} else {
 		__call_rcu_core(rdp, head, flags);
@@ -3843,13 +3844,13 @@ static int rcu_pending(int user)
 		return 1;
 
 	/* Does this CPU have callbacks ready to invoke? */
-	if (!rcu_segcblist_is_offloaded(&rdp->cblist) &&
+	if (!rcu_rdp_is_offloaded(rdp) &&
 	    rcu_segcblist_ready_cbs(&rdp->cblist))
 		return 1;
 
 	/* Has RCU gone idle with this CPU needing another grace period? */
 	if (!gp_in_progress && rcu_segcblist_is_enabled(&rdp->cblist) &&
-	    !rcu_segcblist_is_offloaded(&rdp->cblist) &&
+	    !rcu_rdp_is_offloaded(rdp) &&
 	    !rcu_segcblist_restempty(&rdp->cblist, RCU_NEXT_READY_TAIL))
 		return 1;
 
@@ -3968,7 +3969,7 @@ void rcu_barrier(void)
 	for_each_possible_cpu(cpu) {
 		rdp = per_cpu_ptr(&rcu_data, cpu);
 		if (cpu_is_offline(cpu) &&
-		    !rcu_segcblist_is_offloaded(&rdp->cblist))
+		    !rcu_rdp_is_offloaded(rdp))
 			continue;
 		if (rcu_segcblist_n_cbs(&rdp->cblist) && cpu_online(cpu)) {
 			rcu_barrier_trace(TPS("OnlineQ"), cpu,
@@ -4291,7 +4292,7 @@ void rcutree_migrate_callbacks(int cpu)
 	struct rcu_data *rdp = per_cpu_ptr(&rcu_data, cpu);
 	bool needwake;
 
-	if (rcu_segcblist_is_offloaded(&rdp->cblist) ||
+	if (rcu_rdp_is_offloaded(rdp) ||
 	    rcu_segcblist_empty(&rdp->cblist))
 		return;  /* No callbacks to migrate. */
 
@@ -4309,7 +4310,7 @@ void rcutree_migrate_callbacks(int cpu)
 	rcu_segcblist_disable(&rdp->cblist);
 	WARN_ON_ONCE(rcu_segcblist_empty(&my_rdp->cblist) !=
 		     !rcu_segcblist_n_cbs(&my_rdp->cblist));
-	if (rcu_segcblist_is_offloaded(&my_rdp->cblist)) {
+	if (rcu_rdp_is_offloaded(my_rdp)) {
 		raw_spin_unlock_rcu_node(my_rnp); /* irqs remain disabled. */
 		__call_rcu_nocb_wake(my_rdp, true, flags);
 	} else {
diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
index 2d60377..cd513ea 100644
--- a/kernel/rcu/tree_plugin.h
+++ b/kernel/rcu/tree_plugin.h
@@ -16,8 +16,70 @@
 #ifdef CONFIG_RCU_NOCB_CPU
 static cpumask_var_t rcu_nocb_mask; /* CPUs to have callbacks offloaded. */
 static bool __read_mostly rcu_nocb_poll;    /* Offload kthread are to poll. */
+static inline int rcu_lockdep_is_held_nocb(struct rcu_data *rdp)
+{
+	return lockdep_is_held(&rdp->nocb_lock);
+}
+
+static inline bool rcu_current_is_nocb_kthread(struct rcu_data *rdp)
+{
+	/* Race on early boot between thread creation and assignment */
+	if (!rdp->nocb_cb_kthread || !rdp->nocb_gp_kthread)
+		return true;
+
+	if (current == rdp->nocb_cb_kthread || current == rdp->nocb_gp_kthread)
+		if (in_task())
+			return true;
+	return false;
+}
+
+static inline bool rcu_running_nocb_timer(struct rcu_data *rdp)
+{
+	return (timer_curr_running(&rdp->nocb_timer) && !in_irq());
+}
+#else
+static inline int rcu_lockdep_is_held_nocb(struct rcu_data *rdp)
+{
+	return 0;
+}
+
+static inline bool rcu_current_is_nocb_kthread(struct rcu_data *rdp)
+{
+	return false;
+}
+
+static inline bool rcu_running_nocb_timer(struct rcu_data *rdp)
+{
+	return false;
+}
+
 #endif /* #ifdef CONFIG_RCU_NOCB_CPU */
 
+static bool rcu_rdp_is_offloaded(struct rcu_data *rdp)
+{
+	/*
+	 * In order to read the offloaded state of an rdp is a safe
+	 * and stable way and prevent from its value to be changed
+	 * under us, we must either hold the barrier mutex, the cpu
+	 * hotplug lock (read or write) or the nocb lock. Local
+	 * non-preemptible reads are also safe. NOCB kthreads and
+	 * timers have their own means of synchronization against the
+	 * offloaded state updaters.
+	 */
+	RCU_LOCKDEP_WARN(
+		!(lockdep_is_held(&rcu_state.barrier_mutex) ||
+		  (IS_ENABLED(CONFIG_HOTPLUG_CPU) && lockdep_is_cpus_held()) ||
+		  rcu_lockdep_is_held_nocb(rdp) ||
+		  (rdp == this_cpu_ptr(&rcu_data) &&
+		   !(IS_ENABLED(CONFIG_PREEMPT_COUNT) && preemptible())) ||
+		  rcu_current_is_nocb_kthread(rdp) ||
+		  rcu_running_nocb_timer(rdp)),
+		"Unsafe read of RCU_NOCB offloaded state"
+	);
+
+	return rcu_segcblist_is_offloaded(&rdp->cblist);
+}
+
 /*
  * Check the RCU kernel configuration parameters and print informative
  * messages about anything out of the ordinary.
@@ -1257,7 +1319,7 @@ int rcu_needs_cpu(u64 basemono, u64 *nextevt)
 {
 	*nextevt = KTIME_MAX;
 	return !rcu_segcblist_empty(&this_cpu_ptr(&rcu_data)->cblist) &&
-	       !rcu_segcblist_is_offloaded(&this_cpu_ptr(&rcu_data)->cblist);
+		!rcu_rdp_is_offloaded(this_cpu_ptr(&rcu_data));
 }
 
 /*
@@ -1352,7 +1414,7 @@ int rcu_needs_cpu(u64 basemono, u64 *nextevt)
 
 	/* If no non-offloaded callbacks, RCU doesn't need the CPU. */
 	if (rcu_segcblist_empty(&rdp->cblist) ||
-	    rcu_segcblist_is_offloaded(&this_cpu_ptr(&rcu_data)->cblist)) {
+	    rcu_rdp_is_offloaded(rdp)) {
 		*nextevt = KTIME_MAX;
 		return 0;
 	}
@@ -1388,7 +1450,7 @@ static void rcu_prepare_for_idle(void)
 	int tne;
 
 	lockdep_assert_irqs_disabled();
-	if (rcu_segcblist_is_offloaded(&rdp->cblist))
+	if (rcu_rdp_is_offloaded(rdp))
 		return;
 
 	/* Handle nohz enablement switches conservatively. */
@@ -1429,7 +1491,7 @@ static void rcu_cleanup_after_idle(void)
 	struct rcu_data *rdp = this_cpu_ptr(&rcu_data);
 
 	lockdep_assert_irqs_disabled();
-	if (rcu_segcblist_is_offloaded(&rdp->cblist))
+	if (rcu_rdp_is_offloaded(rdp))
 		return;
 	if (rcu_try_advance_all_cbs())
 		invoke_rcu_core();
@@ -1560,7 +1622,7 @@ static void rcu_nocb_bypass_unlock(struct rcu_data *rdp)
 static void rcu_nocb_lock(struct rcu_data *rdp)
 {
 	lockdep_assert_irqs_disabled();
-	if (!rcu_segcblist_is_offloaded(&rdp->cblist))
+	if (!rcu_rdp_is_offloaded(rdp))
 		return;
 	raw_spin_lock(&rdp->nocb_lock);
 }
@@ -1571,7 +1633,7 @@ static void rcu_nocb_lock(struct rcu_data *rdp)
  */
 static void rcu_nocb_unlock(struct rcu_data *rdp)
 {
-	if (rcu_segcblist_is_offloaded(&rdp->cblist)) {
+	if (rcu_rdp_is_offloaded(rdp)) {
 		lockdep_assert_irqs_disabled();
 		raw_spin_unlock(&rdp->nocb_lock);
 	}
@@ -1584,7 +1646,7 @@ static void rcu_nocb_unlock(struct rcu_data *rdp)
 static void rcu_nocb_unlock_irqrestore(struct rcu_data *rdp,
 				       unsigned long flags)
 {
-	if (rcu_segcblist_is_offloaded(&rdp->cblist)) {
+	if (rcu_rdp_is_offloaded(rdp)) {
 		lockdep_assert_irqs_disabled();
 		raw_spin_unlock_irqrestore(&rdp->nocb_lock, flags);
 	} else {
@@ -1596,7 +1658,7 @@ static void rcu_nocb_unlock_irqrestore(struct rcu_data *rdp,
 static void rcu_lockdep_assert_cblist_protected(struct rcu_data *rdp)
 {
 	lockdep_assert_irqs_disabled();
-	if (rcu_segcblist_is_offloaded(&rdp->cblist))
+	if (rcu_rdp_is_offloaded(rdp))
 		lockdep_assert_held(&rdp->nocb_lock);
 }
 
@@ -1690,7 +1752,7 @@ static bool rcu_nocb_do_flush_bypass(struct rcu_data *rdp, struct rcu_head *rhp,
 {
 	struct rcu_cblist rcl;
 
-	WARN_ON_ONCE(!rcu_segcblist_is_offloaded(&rdp->cblist));
+	WARN_ON_ONCE(!rcu_rdp_is_offloaded(rdp));
 	rcu_lockdep_assert_cblist_protected(rdp);
 	lockdep_assert_held(&rdp->nocb_bypass_lock);
 	if (rhp && !rcu_cblist_n_cbs(&rdp->nocb_bypass)) {
@@ -1718,7 +1780,7 @@ static bool rcu_nocb_do_flush_bypass(struct rcu_data *rdp, struct rcu_head *rhp,
 static bool rcu_nocb_flush_bypass(struct rcu_data *rdp, struct rcu_head *rhp,
 				  unsigned long j)
 {
-	if (!rcu_segcblist_is_offloaded(&rdp->cblist))
+	if (!rcu_rdp_is_offloaded(rdp))
 		return true;
 	rcu_lockdep_assert_cblist_protected(rdp);
 	rcu_nocb_bypass_lock(rdp);
@@ -1732,7 +1794,7 @@ static bool rcu_nocb_flush_bypass(struct rcu_data *rdp, struct rcu_head *rhp,
 static void rcu_nocb_try_flush_bypass(struct rcu_data *rdp, unsigned long j)
 {
 	rcu_lockdep_assert_cblist_protected(rdp);
-	if (!rcu_segcblist_is_offloaded(&rdp->cblist) ||
+	if (!rcu_rdp_is_offloaded(rdp) ||
 	    !rcu_nocb_bypass_trylock(rdp))
 		return;
 	WARN_ON_ONCE(!rcu_nocb_do_flush_bypass(rdp, NULL, j));
@@ -1764,7 +1826,7 @@ static bool rcu_nocb_try_bypass(struct rcu_data *rdp, struct rcu_head *rhp,
 	unsigned long j = jiffies;
 	long ncbs = rcu_cblist_n_cbs(&rdp->nocb_bypass);
 
-	if (!rcu_segcblist_is_offloaded(&rdp->cblist)) {
+	if (!rcu_rdp_is_offloaded(rdp)) {
 		*was_alldone = !rcu_segcblist_pend_cbs(&rdp->cblist);
 		return false; /* Not offloaded, no bypassing. */
 	}
@@ -2397,7 +2459,7 @@ int rcu_nocb_cpu_deoffload(int cpu)
 	}
 	mutex_lock(&rcu_state.barrier_mutex);
 	cpus_read_lock();
-	if (rcu_segcblist_is_offloaded(&rdp->cblist)) {
+	if (rcu_rdp_is_offloaded(rdp)) {
 		if (cpu_online(cpu))
 			ret = work_on_cpu(cpu, rcu_nocb_rdp_deoffload, rdp);
 		else
@@ -2472,7 +2534,7 @@ int rcu_nocb_cpu_offload(int cpu)
 
 	mutex_lock(&rcu_state.barrier_mutex);
 	cpus_read_lock();
-	if (!rcu_segcblist_is_offloaded(&rdp->cblist)) {
+	if (!rcu_rdp_is_offloaded(rdp)) {
 		if (cpu_online(cpu))
 			ret = work_on_cpu(cpu, rcu_nocb_rdp_offload, rdp);
 		else
