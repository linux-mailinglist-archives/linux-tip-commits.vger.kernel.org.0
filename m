Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA521319ED2
	for <lists+linux-tip-commits@lfdr.de>; Fri, 12 Feb 2021 13:43:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231567AbhBLMlx (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 12 Feb 2021 07:41:53 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:45320 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231669AbhBLMkV (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 12 Feb 2021 07:40:21 -0500
Date:   Fri, 12 Feb 2021 12:37:20 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1613133440;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=j+zzL0QWNimXqlspTi1Jyc2G/G5T8qxy5dSz1HE7CPk=;
        b=uqoX0DTD7ZvjMLBGji6I+4uqNBbwL5W2sByICjANw+UNM2T5tu+1P4Ra35CPhjjbYtwZkP
        svQbwVx9X5IGkn0CwCmoCDKUMG6BRWrNDTs3SuGr0MAB+srQgTsMaM+oK7zOJ5hWWFLZnm
        sUgl7BAnKemY70JljPo2NtsxrHJcDf/3FBkmZd7lTd5Z6YjXy3wT/b9fBITX27rMTi2Zfq
        MfaRDYyHG0shPQKNf8Km4JLB08RFgRCN+dEj68bA7YI3DDXNXVfjZD+EsP+e1ipXN0qq5U
        EQEi84UwswnCFXBEZG+MmxfYSFyUuCnrWjsONCpd7x4vEccX8vl3/m5HqbVt9g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1613133440;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=j+zzL0QWNimXqlspTi1Jyc2G/G5T8qxy5dSz1HE7CPk=;
        b=2LQa9PLYMhpltALhFRsk+BkAH28uF8jQ8x6iUwG7zPVQ/sPPMaFaabNmskW5WAi9C90Lc4
        BwKs78+U+YXYlEBA==
From:   "tip-bot2 for Frederic Weisbecker" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] rcu/nocb: De-offloading CB kthread
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
Message-ID: <161313344005.23325.16278588068525227270.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the core/rcu branch of tip:

Commit-ID:     d97b078182406c0bd0aacd36fc0a693e118e608f
Gitweb:        https://git.kernel.org/tip/d97b078182406c0bd0aacd36fc0a693e118e608f
Author:        Frederic Weisbecker <frederic@kernel.org>
AuthorDate:    Fri, 13 Nov 2020 13:13:19 +01:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Wed, 06 Jan 2021 16:24:19 -08:00

rcu/nocb: De-offloading CB kthread

To de-offload callback processing back onto a CPU, it is necessary to
clear SEGCBLIST_OFFLOAD and notify the nocb CB kthread, which will then
clear its own bit flag and go to sleep to stop handling callbacks.  This
commit makes that change.  It will also be necessary to notify the nocb
GP kthread in this same way, which is the subject of a follow-on commit.

Cc: Josh Triplett <josh@joshtriplett.org>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Lai Jiangshan <jiangshanlai@gmail.com>
Cc: Joel Fernandes <joel@joelfernandes.org>
Cc: Neeraj Upadhyay <neeraju@codeaurora.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Inspired-by: Paul E. McKenney <paulmck@kernel.org>
Tested-by: Boqun Feng <boqun.feng@gmail.com>
Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
[ paulmck: Add export per kernel test robot feedback. ]
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 include/linux/rcupdate.h   |   2 +-
 kernel/rcu/rcu_segcblist.c |  10 ++-
 kernel/rcu/rcu_segcblist.h |   2 +-
 kernel/rcu/tree.h          |   1 +-
 kernel/rcu/tree_plugin.h   | 130 +++++++++++++++++++++++++++++++-----
 5 files changed, 123 insertions(+), 22 deletions(-)

diff --git a/include/linux/rcupdate.h b/include/linux/rcupdate.h
index de08264..40266eb 100644
--- a/include/linux/rcupdate.h
+++ b/include/linux/rcupdate.h
@@ -104,8 +104,10 @@ static inline void rcu_user_exit(void) { }
 
 #ifdef CONFIG_RCU_NOCB_CPU
 void rcu_init_nohz(void);
+int rcu_nocb_cpu_deoffload(int cpu);
 #else /* #ifdef CONFIG_RCU_NOCB_CPU */
 static inline void rcu_init_nohz(void) { }
+static inline int rcu_nocb_cpu_deoffload(int cpu) { return 0; }
 #endif /* #else #ifdef CONFIG_RCU_NOCB_CPU */
 
 /**
diff --git a/kernel/rcu/rcu_segcblist.c b/kernel/rcu/rcu_segcblist.c
index 7fc6362..7f181c9 100644
--- a/kernel/rcu/rcu_segcblist.c
+++ b/kernel/rcu/rcu_segcblist.c
@@ -264,10 +264,14 @@ void rcu_segcblist_disable(struct rcu_segcblist *rsclp)
  * Mark the specified rcu_segcblist structure as offloaded.  This
  * structure must be empty.
  */
-void rcu_segcblist_offload(struct rcu_segcblist *rsclp)
+void rcu_segcblist_offload(struct rcu_segcblist *rsclp, bool offload)
 {
-	rcu_segcblist_clear_flags(rsclp, SEGCBLIST_SOFTIRQ_ONLY);
-	rcu_segcblist_set_flags(rsclp, SEGCBLIST_OFFLOADED);
+	if (offload) {
+		rcu_segcblist_clear_flags(rsclp, SEGCBLIST_SOFTIRQ_ONLY);
+		rcu_segcblist_set_flags(rsclp, SEGCBLIST_OFFLOADED);
+	} else {
+		rcu_segcblist_clear_flags(rsclp, SEGCBLIST_OFFLOADED);
+	}
 }
 
 /*
diff --git a/kernel/rcu/rcu_segcblist.h b/kernel/rcu/rcu_segcblist.h
index e05952a..28c9a52 100644
--- a/kernel/rcu/rcu_segcblist.h
+++ b/kernel/rcu/rcu_segcblist.h
@@ -109,7 +109,7 @@ void rcu_segcblist_inc_len(struct rcu_segcblist *rsclp);
 void rcu_segcblist_add_len(struct rcu_segcblist *rsclp, long v);
 void rcu_segcblist_init(struct rcu_segcblist *rsclp);
 void rcu_segcblist_disable(struct rcu_segcblist *rsclp);
-void rcu_segcblist_offload(struct rcu_segcblist *rsclp);
+void rcu_segcblist_offload(struct rcu_segcblist *rsclp, bool offload);
 bool rcu_segcblist_ready_cbs(struct rcu_segcblist *rsclp);
 bool rcu_segcblist_pend_cbs(struct rcu_segcblist *rsclp);
 struct rcu_head *rcu_segcblist_first_cb(struct rcu_segcblist *rsclp);
diff --git a/kernel/rcu/tree.h b/kernel/rcu/tree.h
index 7708ed1..e0deb48 100644
--- a/kernel/rcu/tree.h
+++ b/kernel/rcu/tree.h
@@ -201,6 +201,7 @@ struct rcu_data {
 	/* 5) Callback offloading. */
 #ifdef CONFIG_RCU_NOCB_CPU
 	struct swait_queue_head nocb_cb_wq; /* For nocb kthreads to sleep on. */
+	struct swait_queue_head nocb_state_wq; /* For offloading state changes */
 	struct task_struct *nocb_gp_kthread;
 	raw_spinlock_t nocb_lock;	/* Guard following pair of fields. */
 	atomic_t nocb_lock_contended;	/* Contention experienced. */
diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
index 7e291ce..1b870d0 100644
--- a/kernel/rcu/tree_plugin.h
+++ b/kernel/rcu/tree_plugin.h
@@ -2081,16 +2081,29 @@ static int rcu_nocb_gp_kthread(void *arg)
 	return 0;
 }
 
+static inline bool nocb_cb_can_run(struct rcu_data *rdp)
+{
+	u8 flags = SEGCBLIST_OFFLOADED | SEGCBLIST_KTHREAD_CB;
+	return rcu_segcblist_test_flags(&rdp->cblist, flags);
+}
+
+static inline bool nocb_cb_wait_cond(struct rcu_data *rdp)
+{
+	return nocb_cb_can_run(rdp) && !READ_ONCE(rdp->nocb_cb_sleep);
+}
+
 /*
  * Invoke any ready callbacks from the corresponding no-CBs CPU,
  * then, if there are no more, wait for more to appear.
  */
 static void nocb_cb_wait(struct rcu_data *rdp)
 {
+	struct rcu_segcblist *cblist = &rdp->cblist;
+	struct rcu_node *rnp = rdp->mynode;
+	bool needwake_state = false;
+	bool needwake_gp = false;
 	unsigned long cur_gp_seq;
 	unsigned long flags;
-	bool needwake_gp = false;
-	struct rcu_node *rnp = rdp->mynode;
 
 	local_irq_save(flags);
 	rcu_momentary_dyntick_idle();
@@ -2100,32 +2113,50 @@ static void nocb_cb_wait(struct rcu_data *rdp)
 	local_bh_enable();
 	lockdep_assert_irqs_enabled();
 	rcu_nocb_lock_irqsave(rdp, flags);
-	if (rcu_segcblist_nextgp(&rdp->cblist, &cur_gp_seq) &&
+	if (rcu_segcblist_nextgp(cblist, &cur_gp_seq) &&
 	    rcu_seq_done(&rnp->gp_seq, cur_gp_seq) &&
 	    raw_spin_trylock_rcu_node(rnp)) { /* irqs already disabled. */
 		needwake_gp = rcu_advance_cbs(rdp->mynode, rdp);
 		raw_spin_unlock_rcu_node(rnp); /* irqs remain disabled. */
 	}
-	if (rcu_segcblist_ready_cbs(&rdp->cblist)) {
-		rcu_nocb_unlock_irqrestore(rdp, flags);
-		if (needwake_gp)
-			rcu_gp_kthread_wake();
-		return;
-	}
 
-	trace_rcu_nocb_wake(rcu_state.name, rdp->cpu, TPS("CBSleep"));
 	WRITE_ONCE(rdp->nocb_cb_sleep, true);
+
+	if (rcu_segcblist_test_flags(cblist, SEGCBLIST_OFFLOADED)) {
+		if (rcu_segcblist_ready_cbs(cblist))
+			WRITE_ONCE(rdp->nocb_cb_sleep, false);
+	} else {
+		/*
+		 * De-offloading. Clear our flag and notify the de-offload worker.
+		 * We won't touch the callbacks and keep sleeping until we ever
+		 * get re-offloaded.
+		 */
+		WARN_ON_ONCE(!rcu_segcblist_test_flags(cblist, SEGCBLIST_KTHREAD_CB));
+		rcu_segcblist_clear_flags(cblist, SEGCBLIST_KTHREAD_CB);
+		if (!rcu_segcblist_test_flags(cblist, SEGCBLIST_KTHREAD_GP))
+			needwake_state = true;
+	}
+
+	if (rdp->nocb_cb_sleep)
+		trace_rcu_nocb_wake(rcu_state.name, rdp->cpu, TPS("CBSleep"));
+
 	rcu_nocb_unlock_irqrestore(rdp, flags);
 	if (needwake_gp)
 		rcu_gp_kthread_wake();
-	swait_event_interruptible_exclusive(rdp->nocb_cb_wq,
-				 !READ_ONCE(rdp->nocb_cb_sleep));
-	if (!smp_load_acquire(&rdp->nocb_cb_sleep)) { /* VVV */
+
+	if (needwake_state)
+		swake_up_one(&rdp->nocb_state_wq);
+
+	do {
+		swait_event_interruptible_exclusive(rdp->nocb_cb_wq,
+						    nocb_cb_wait_cond(rdp));
+
 		/* ^^^ Ensure CB invocation follows _sleep test. */
-		return;
-	}
-	WARN_ON(signal_pending(current));
-	trace_rcu_nocb_wake(rcu_state.name, rdp->cpu, TPS("WokeEmpty"));
+		if (smp_load_acquire(&rdp->nocb_cb_sleep)) {
+			WARN_ON(signal_pending(current));
+			trace_rcu_nocb_wake(rcu_state.name, rdp->cpu, TPS("WokeEmpty"));
+		}
+	} while (!nocb_cb_can_run(rdp));
 }
 
 /*
@@ -2187,6 +2218,67 @@ static void do_nocb_deferred_wakeup(struct rcu_data *rdp)
 		do_nocb_deferred_wakeup_common(rdp);
 }
 
+static int __rcu_nocb_rdp_deoffload(struct rcu_data *rdp)
+{
+	struct rcu_segcblist *cblist = &rdp->cblist;
+	bool wake_cb = false;
+	unsigned long flags;
+
+	printk("De-offloading %d\n", rdp->cpu);
+
+	rcu_nocb_lock_irqsave(rdp, flags);
+	rcu_segcblist_offload(cblist, false);
+
+	if (rdp->nocb_cb_sleep) {
+		rdp->nocb_cb_sleep = false;
+		wake_cb = true;
+	}
+	rcu_nocb_unlock_irqrestore(rdp, flags);
+
+	if (wake_cb)
+		swake_up_one(&rdp->nocb_cb_wq);
+
+	swait_event_exclusive(rdp->nocb_state_wq,
+			      !rcu_segcblist_test_flags(cblist, SEGCBLIST_KTHREAD_CB));
+
+	return 0;
+}
+
+static long rcu_nocb_rdp_deoffload(void *arg)
+{
+	struct rcu_data *rdp = arg;
+
+	WARN_ON_ONCE(rdp->cpu != raw_smp_processor_id());
+	return __rcu_nocb_rdp_deoffload(rdp);
+}
+
+int rcu_nocb_cpu_deoffload(int cpu)
+{
+	struct rcu_data *rdp = per_cpu_ptr(&rcu_data, cpu);
+	int ret = 0;
+
+	if (rdp == rdp->nocb_gp_rdp) {
+		pr_info("Can't deoffload an rdp GP leader (yet)\n");
+		return -EINVAL;
+	}
+	mutex_lock(&rcu_state.barrier_mutex);
+	cpus_read_lock();
+	if (rcu_segcblist_is_offloaded(&rdp->cblist)) {
+		if (cpu_online(cpu)) {
+			ret = work_on_cpu(cpu, rcu_nocb_rdp_deoffload, rdp);
+		} else {
+			ret = __rcu_nocb_rdp_deoffload(rdp);
+		}
+		if (!ret)
+			cpumask_clear_cpu(cpu, rcu_nocb_mask);
+	}
+	cpus_read_unlock();
+	mutex_unlock(&rcu_state.barrier_mutex);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(rcu_nocb_cpu_deoffload);
+
 void __init rcu_init_nohz(void)
 {
 	int cpu;
@@ -2229,7 +2321,8 @@ void __init rcu_init_nohz(void)
 		rdp = per_cpu_ptr(&rcu_data, cpu);
 		if (rcu_segcblist_empty(&rdp->cblist))
 			rcu_segcblist_init(&rdp->cblist);
-		rcu_segcblist_offload(&rdp->cblist);
+		rcu_segcblist_offload(&rdp->cblist, true);
+		rcu_segcblist_set_flags(&rdp->cblist, SEGCBLIST_KTHREAD_CB);
 	}
 	rcu_organize_nocb_kthreads();
 }
@@ -2239,6 +2332,7 @@ static void __init rcu_boot_init_nocb_percpu_data(struct rcu_data *rdp)
 {
 	init_swait_queue_head(&rdp->nocb_cb_wq);
 	init_swait_queue_head(&rdp->nocb_gp_wq);
+	init_swait_queue_head(&rdp->nocb_state_wq);
 	raw_spin_lock_init(&rdp->nocb_lock);
 	raw_spin_lock_init(&rdp->nocb_bypass_lock);
 	raw_spin_lock_init(&rdp->nocb_gp_lock);
