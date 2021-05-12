Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E55FC37BA66
	for <lists+linux-tip-commits@lfdr.de>; Wed, 12 May 2021 12:28:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230379AbhELK3k (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 12 May 2021 06:29:40 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:50400 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230370AbhELK3f (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 12 May 2021 06:29:35 -0400
Date:   Wed, 12 May 2021 10:28:26 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1620815307;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zaLQFGoBLR+f9fxjgVrbgslGly5IPRQ5uCOOldB2Ho8=;
        b=aKNpHJFAIok0/TNZ+xaC4US9OQFob+9IODO/QxHSI4/BodMCuafvPiDEfhgKABHgj8v7Mp
        3Y0/7lX/8I5kW9Caai5N+2MbkoW6+uNJ2xVWlHe8Ssb4Ha97wR4up4avPOFzJHEOeeNXQG
        Vq2J8jr5wK2IaSJ6CUEWGHN0NheZPIlNHp56iJ8iyYrgaMCH/pYXvj3AzM5PYXMj0ZeKDF
        fu5+hhxJa9sz5Tcu2TS8XHTsOfhcwNvLmOxA1tPw165JLGwyW21kf5ExFpsi+CMrQyPYQh
        L+ZOELtcoMEYuDVrVvcI+k9iUs9rcIzKpkWv1lbR80N4lXLjSYUTtISlkf4row==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1620815307;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zaLQFGoBLR+f9fxjgVrbgslGly5IPRQ5uCOOldB2Ho8=;
        b=Lbfnx3dZWG/vnAUn3/Iuvi73gskGvyYoo+XVcoMKioJKePG6aP288iueWa/qCyXme7MoVS
        HLqfw7YOLiaWUzBQ==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched: Core-wide rq->lock
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Don Hiatt <dhiatt@digitalocean.com>,
        Hongyu Ning <hongyu.ning@linux.intel.com>,
        Vincent Guittot <vincent.guittot@linaro.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <YJUNfzSgptjX7tG6@hirez.programming.kicks-ass.net>
References: <YJUNfzSgptjX7tG6@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Message-ID: <162081530662.29796.18273095135192979351.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     9edeaea1bc452372718837ed2ba775811baf1ba1
Gitweb:        https://git.kernel.org/tip/9edeaea1bc452372718837ed2ba775811baf1ba1
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Tue, 17 Nov 2020 18:19:34 -05:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 12 May 2021 11:43:27 +02:00

sched: Core-wide rq->lock

Introduce the basic infrastructure to have a core wide rq->lock.

This relies on the rq->__lock order being in increasing CPU number
(inside a core). It is also constrained to SMT8 per lockdep (and
SMT256 per preempt_count).

Luckily SMT8 is the max supported SMT count for Linux (Mips, Sparc and
Power are known to have this).

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Tested-by: Don Hiatt <dhiatt@digitalocean.com>
Tested-by: Hongyu Ning <hongyu.ning@linux.intel.com>
Tested-by: Vincent Guittot <vincent.guittot@linaro.org>
Link: https://lkml.kernel.org/r/YJUNfzSgptjX7tG6@hirez.programming.kicks-ass.net
---
 kernel/Kconfig.preempt |   6 +-
 kernel/sched/core.c    | 164 +++++++++++++++++++++++++++++++++++++++-
 kernel/sched/sched.h   |  58 ++++++++++++++-
 3 files changed, 224 insertions(+), 4 deletions(-)

diff --git a/kernel/Kconfig.preempt b/kernel/Kconfig.preempt
index 4160173..ea1e333 100644
--- a/kernel/Kconfig.preempt
+++ b/kernel/Kconfig.preempt
@@ -99,3 +99,9 @@ config PREEMPT_DYNAMIC
 
 	  Interesting if you want the same pre-built kernel should be used for
 	  both Server and Desktop workloads.
+
+config SCHED_CORE
+	bool "Core Scheduling for SMT"
+	default y
+	depends on SCHED_SMT
+
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 8bd2f12..384b793 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -84,6 +84,108 @@ unsigned int sysctl_sched_rt_period = 1000000;
 
 __read_mostly int scheduler_running;
 
+#ifdef CONFIG_SCHED_CORE
+
+DEFINE_STATIC_KEY_FALSE(__sched_core_enabled);
+
+/*
+ * Magic required such that:
+ *
+ *	raw_spin_rq_lock(rq);
+ *	...
+ *	raw_spin_rq_unlock(rq);
+ *
+ * ends up locking and unlocking the _same_ lock, and all CPUs
+ * always agree on what rq has what lock.
+ *
+ * XXX entirely possible to selectively enable cores, don't bother for now.
+ */
+
+static DEFINE_MUTEX(sched_core_mutex);
+static int sched_core_count;
+static struct cpumask sched_core_mask;
+
+static void __sched_core_flip(bool enabled)
+{
+	int cpu, t, i;
+
+	cpus_read_lock();
+
+	/*
+	 * Toggle the online cores, one by one.
+	 */
+	cpumask_copy(&sched_core_mask, cpu_online_mask);
+	for_each_cpu(cpu, &sched_core_mask) {
+		const struct cpumask *smt_mask = cpu_smt_mask(cpu);
+
+		i = 0;
+		local_irq_disable();
+		for_each_cpu(t, smt_mask) {
+			/* supports up to SMT8 */
+			raw_spin_lock_nested(&cpu_rq(t)->__lock, i++);
+		}
+
+		for_each_cpu(t, smt_mask)
+			cpu_rq(t)->core_enabled = enabled;
+
+		for_each_cpu(t, smt_mask)
+			raw_spin_unlock(&cpu_rq(t)->__lock);
+		local_irq_enable();
+
+		cpumask_andnot(&sched_core_mask, &sched_core_mask, smt_mask);
+	}
+
+	/*
+	 * Toggle the offline CPUs.
+	 */
+	cpumask_copy(&sched_core_mask, cpu_possible_mask);
+	cpumask_andnot(&sched_core_mask, &sched_core_mask, cpu_online_mask);
+
+	for_each_cpu(cpu, &sched_core_mask)
+		cpu_rq(cpu)->core_enabled = enabled;
+
+	cpus_read_unlock();
+}
+
+static void __sched_core_enable(void)
+{
+	// XXX verify there are no cookie tasks (yet)
+
+	static_branch_enable(&__sched_core_enabled);
+	/*
+	 * Ensure all previous instances of raw_spin_rq_*lock() have finished
+	 * and future ones will observe !sched_core_disabled().
+	 */
+	synchronize_rcu();
+	__sched_core_flip(true);
+}
+
+static void __sched_core_disable(void)
+{
+	// XXX verify there are no cookie tasks (left)
+
+	__sched_core_flip(false);
+	static_branch_disable(&__sched_core_enabled);
+}
+
+void sched_core_get(void)
+{
+	mutex_lock(&sched_core_mutex);
+	if (!sched_core_count++)
+		__sched_core_enable();
+	mutex_unlock(&sched_core_mutex);
+}
+
+void sched_core_put(void)
+{
+	mutex_lock(&sched_core_mutex);
+	if (!--sched_core_count)
+		__sched_core_disable();
+	mutex_unlock(&sched_core_mutex);
+}
+
+#endif /* CONFIG_SCHED_CORE */
+
 /*
  * part of the period that we allow rt tasks to run in us.
  * default: 0.95s
@@ -188,16 +290,23 @@ void raw_spin_rq_lock_nested(struct rq *rq, int subclass)
 {
 	raw_spinlock_t *lock;
 
+	/* Matches synchronize_rcu() in __sched_core_enable() */
+	preempt_disable();
 	if (sched_core_disabled()) {
 		raw_spin_lock_nested(&rq->__lock, subclass);
+		/* preempt_count *MUST* be > 1 */
+		preempt_enable_no_resched();
 		return;
 	}
 
 	for (;;) {
 		lock = rq_lockp(rq);
 		raw_spin_lock_nested(lock, subclass);
-		if (likely(lock == rq_lockp(rq)))
+		if (likely(lock == rq_lockp(rq))) {
+			/* preempt_count *MUST* be > 1 */
+			preempt_enable_no_resched();
 			return;
+		}
 		raw_spin_unlock(lock);
 	}
 }
@@ -207,14 +316,21 @@ bool raw_spin_rq_trylock(struct rq *rq)
 	raw_spinlock_t *lock;
 	bool ret;
 
-	if (sched_core_disabled())
-		return raw_spin_trylock(&rq->__lock);
+	/* Matches synchronize_rcu() in __sched_core_enable() */
+	preempt_disable();
+	if (sched_core_disabled()) {
+		ret = raw_spin_trylock(&rq->__lock);
+		preempt_enable();
+		return ret;
+	}
 
 	for (;;) {
 		lock = rq_lockp(rq);
 		ret = raw_spin_trylock(lock);
-		if (!ret || (likely(lock == rq_lockp(rq))))
+		if (!ret || (likely(lock == rq_lockp(rq)))) {
+			preempt_enable();
 			return ret;
+		}
 		raw_spin_unlock(lock);
 	}
 }
@@ -5041,6 +5157,40 @@ restart:
 	BUG();
 }
 
+#ifdef CONFIG_SCHED_CORE
+
+static inline void sched_core_cpu_starting(unsigned int cpu)
+{
+	const struct cpumask *smt_mask = cpu_smt_mask(cpu);
+	struct rq *rq, *core_rq = NULL;
+	int i;
+
+	core_rq = cpu_rq(cpu)->core;
+
+	if (!core_rq) {
+		for_each_cpu(i, smt_mask) {
+			rq = cpu_rq(i);
+			if (rq->core && rq->core == rq)
+				core_rq = rq;
+		}
+
+		if (!core_rq)
+			core_rq = cpu_rq(cpu);
+
+		for_each_cpu(i, smt_mask) {
+			rq = cpu_rq(i);
+
+			WARN_ON_ONCE(rq->core && rq->core != core_rq);
+			rq->core = core_rq;
+		}
+	}
+}
+#else /* !CONFIG_SCHED_CORE */
+
+static inline void sched_core_cpu_starting(unsigned int cpu) {}
+
+#endif /* CONFIG_SCHED_CORE */
+
 /*
  * __schedule() is the main scheduler function.
  *
@@ -8006,6 +8156,7 @@ static void sched_rq_cpu_starting(unsigned int cpu)
 
 int sched_cpu_starting(unsigned int cpu)
 {
+	sched_core_cpu_starting(cpu);
 	sched_rq_cpu_starting(cpu);
 	sched_tick_start(cpu);
 	return 0;
@@ -8290,6 +8441,11 @@ void __init sched_init(void)
 #endif /* CONFIG_SMP */
 		hrtick_rq_init(rq);
 		atomic_set(&rq->nr_iowait, 0);
+
+#ifdef CONFIG_SCHED_CORE
+		rq->core = NULL;
+		rq->core_enabled = 0;
+#endif
 	}
 
 	set_load_weight(&init_task, false);
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index f8bd5c8..29418b8 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -1075,6 +1075,12 @@ struct rq {
 #endif
 	unsigned int		push_busy;
 	struct cpu_stop_work	push_work;
+
+#ifdef CONFIG_SCHED_CORE
+	/* per rq */
+	struct rq		*core;
+	unsigned int		core_enabled;
+#endif
 };
 
 #ifdef CONFIG_FAIR_GROUP_SCHED
@@ -1113,6 +1119,35 @@ static inline bool is_migration_disabled(struct task_struct *p)
 #endif
 }
 
+#ifdef CONFIG_SCHED_CORE
+
+DECLARE_STATIC_KEY_FALSE(__sched_core_enabled);
+
+static inline bool sched_core_enabled(struct rq *rq)
+{
+	return static_branch_unlikely(&__sched_core_enabled) && rq->core_enabled;
+}
+
+static inline bool sched_core_disabled(void)
+{
+	return !static_branch_unlikely(&__sched_core_enabled);
+}
+
+static inline raw_spinlock_t *rq_lockp(struct rq *rq)
+{
+	if (sched_core_enabled(rq))
+		return &rq->core->__lock;
+
+	return &rq->__lock;
+}
+
+#else /* !CONFIG_SCHED_CORE */
+
+static inline bool sched_core_enabled(struct rq *rq)
+{
+	return false;
+}
+
 static inline bool sched_core_disabled(void)
 {
 	return true;
@@ -1123,6 +1158,8 @@ static inline raw_spinlock_t *rq_lockp(struct rq *rq)
 	return &rq->__lock;
 }
 
+#endif /* CONFIG_SCHED_CORE */
+
 static inline void lockdep_assert_rq_held(struct rq *rq)
 {
 	lockdep_assert_held(rq_lockp(rq));
@@ -2241,6 +2278,27 @@ unsigned long arch_scale_freq_capacity(int cpu)
 
 static inline bool rq_order_less(struct rq *rq1, struct rq *rq2)
 {
+#ifdef CONFIG_SCHED_CORE
+	/*
+	 * In order to not have {0,2},{1,3} turn into into an AB-BA,
+	 * order by core-id first and cpu-id second.
+	 *
+	 * Notably:
+	 *
+	 *	double_rq_lock(0,3); will take core-0, core-1 lock
+	 *	double_rq_lock(1,2); will take core-1, core-0 lock
+	 *
+	 * when only cpu-id is considered.
+	 */
+	if (rq1->core->cpu < rq2->core->cpu)
+		return true;
+	if (rq1->core->cpu > rq2->core->cpu)
+		return false;
+
+	/*
+	 * __sched_core_flip() relies on SMT having cpu-id lock order.
+	 */
+#endif
 	return rq1->cpu < rq2->cpu;
 }
 
