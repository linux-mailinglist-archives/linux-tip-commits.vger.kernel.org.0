Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC17D2AEB2E
	for <lists+linux-tip-commits@lfdr.de>; Wed, 11 Nov 2020 09:25:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726627AbgKKIYo (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 11 Nov 2020 03:24:44 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:36274 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726226AbgKKIXU (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 11 Nov 2020 03:23:20 -0500
Date:   Wed, 11 Nov 2020 08:23:16 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1605082997;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bJE0WE5FMjdXOG/cLh6d4h849elgs7THlBmV4I7e/vI=;
        b=YI4Xu5gAiLyayXbwSuVqb7d7qFl48uctdIg6cg6NEURuKJTGgXvc9gR0d8IGPlTuY6SlOy
        P/jPGqXd3t+ov/zs3Cx6G9WikK6aro87ntA/vDVZMJR3ExrMuXjNVBpQlIQr3hO0kLCCSH
        F+KmMQLmZ2lB9K7Ge3yXL9DVXiZrJLwFwdXSbY9Vq33/HbNzzk1x0JXKYTPs76Auauutt9
        GZX8w7mojX8xrUGqv4mdjtv9y4fsv1eLXiY2E0uNRJmhpZaH+fS4RgwLGDMkCXI6cR7ymf
        eqwqzi66PbqBOFLSLyaakm3hqCWzOl6fXtCbNt5PPe0Oy3XHDyFLNhH9RwfufQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1605082997;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bJE0WE5FMjdXOG/cLh6d4h849elgs7THlBmV4I7e/vI=;
        b=RLeLV8D4b4Pvf5T8bGjWkMdSaLNlyfIKG0Ntm6tQBT1/TuKFqhANxrQIhShmbmE946dRsm
        g2C4zUhAh4EubsAA==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched: Fix migrate_disable() vs rt/dl balancing
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20201023102347.499155098@infradead.org>
References: <20201023102347.499155098@infradead.org>
MIME-Version: 1.0
Message-ID: <160508299645.11244.15504072651953867631.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     a7c81556ec4d341dfdbf2cc478ead89d73e474a7
Gitweb:        https://git.kernel.org/tip/a7c81556ec4d341dfdbf2cc478ead89d73e474a7
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Mon, 28 Sep 2020 17:06:07 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 10 Nov 2020 18:39:01 +01:00

sched: Fix migrate_disable() vs rt/dl balancing

In order to minimize the interference of migrate_disable() on lower
priority tasks, which can be deprived of runtime due to being stuck
below a higher priority task. Teach the RT/DL balancers to push away
these higher priority tasks when a lower priority task gets selected
to run on a freshly demoted CPU (pull).

This adds migration interference to the higher priority task, but
restores bandwidth to system that would otherwise be irrevocably lost.
Without this it would be possible to have all tasks on the system
stuck on a single CPU, each task preempted in a migrate_disable()
section with a single high priority task running.

This way we can still approximate running the M highest priority tasks
on the system.

Migrating the top task away is (ofcourse) still subject to
migrate_disable() too, which means the lower task is subject to an
interference equivalent to the worst case migrate_disable() section.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Daniel Bristot de Oliveira <bristot@redhat.com>
Link: https://lkml.kernel.org/r/20201023102347.499155098@infradead.org
---
 include/linux/preempt.h | 40 +++++++++++++-----------
 include/linux/sched.h   |  3 +-
 kernel/sched/core.c     | 67 ++++++++++++++++++++++++++++++++++------
 kernel/sched/deadline.c | 29 ++++++++++++-----
 kernel/sched/rt.c       | 63 ++++++++++++++++++++++++++++++--------
 kernel/sched/sched.h    | 32 +++++++++++++++++++-
 6 files changed, 186 insertions(+), 48 deletions(-)

diff --git a/include/linux/preempt.h b/include/linux/preempt.h
index 97ba7c9..8b43922 100644
--- a/include/linux/preempt.h
+++ b/include/linux/preempt.h
@@ -325,24 +325,28 @@ static inline void preempt_notifier_init(struct preempt_notifier *notifier,
 #if defined(CONFIG_SMP) && defined(CONFIG_PREEMPT_RT)
 
 /*
- * Migrate-Disable and why it is (strongly) undesired.
- *
- * The premise of the Real-Time schedulers we have on Linux
- * (SCHED_FIFO/SCHED_DEADLINE) is that M CPUs can/will run M tasks
- * concurrently, provided there are sufficient runnable tasks, also known as
- * work-conserving. For instance SCHED_DEADLINE tries to schedule the M
- * earliest deadline threads, and SCHED_FIFO the M highest priority threads.
- *
- * The correctness of various scheduling models depends on this, but is it
- * broken by migrate_disable() that doesn't imply preempt_disable(). Where
- * preempt_disable() implies an immediate priority ceiling, preemptible
- * migrate_disable() allows nesting.
- *
- * The worst case is that all tasks preempt one another in a migrate_disable()
- * region and stack on a single CPU. This then reduces the available bandwidth
- * to a single CPU. And since Real-Time schedulability theory considers the
- * Worst-Case only, all Real-Time analysis shall revert to single-CPU
- * (instantly solving the SMP analysis problem).
+ * Migrate-Disable and why it is undesired.
+ *
+ * When a preempted task becomes elegible to run under the ideal model (IOW it
+ * becomes one of the M highest priority tasks), it might still have to wait
+ * for the preemptee's migrate_disable() section to complete. Thereby suffering
+ * a reduction in bandwidth in the exact duration of the migrate_disable()
+ * section.
+ *
+ * Per this argument, the change from preempt_disable() to migrate_disable()
+ * gets us:
+ *
+ * - a higher priority tasks gains reduced wake-up latency; with preempt_disable()
+ *   it would have had to wait for the lower priority task.
+ *
+ * - a lower priority tasks; which under preempt_disable() could've instantly
+ *   migrated away when another CPU becomes available, is now constrained
+ *   by the ability to push the higher priority task away, which might itself be
+ *   in a migrate_disable() section, reducing it's available bandwidth.
+ *
+ * IOW it trades latency / moves the interference term, but it stays in the
+ * system, and as long as it remains unbounded, the system is not fully
+ * deterministic.
  *
  *
  * The reason we have it anyway.
diff --git a/include/linux/sched.h b/include/linux/sched.h
index 90a0c92..3af9d52 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -716,8 +716,9 @@ struct task_struct {
 	cpumask_t			cpus_mask;
 	void				*migration_pending;
 #if defined(CONFIG_SMP) && defined(CONFIG_PREEMPT_RT)
-	int				migration_disabled;
+	unsigned short			migration_disabled;
 #endif
+	unsigned short			migration_flags;
 
 #ifdef CONFIG_PREEMPT_RCU
 	int				rcu_read_lock_nesting;
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 9ce2fc7..e92d785 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -1763,11 +1763,6 @@ void migrate_enable(void)
 }
 EXPORT_SYMBOL_GPL(migrate_enable);
 
-static inline bool is_migration_disabled(struct task_struct *p)
-{
-	return p->migration_disabled;
-}
-
 static inline bool rq_has_pinned_tasks(struct rq *rq)
 {
 	return rq->nr_pinned;
@@ -1972,6 +1967,49 @@ out:
 	return 0;
 }
 
+int push_cpu_stop(void *arg)
+{
+	struct rq *lowest_rq = NULL, *rq = this_rq();
+	struct task_struct *p = arg;
+
+	raw_spin_lock_irq(&p->pi_lock);
+	raw_spin_lock(&rq->lock);
+
+	if (task_rq(p) != rq)
+		goto out_unlock;
+
+	if (is_migration_disabled(p)) {
+		p->migration_flags |= MDF_PUSH;
+		goto out_unlock;
+	}
+
+	p->migration_flags &= ~MDF_PUSH;
+
+	if (p->sched_class->find_lock_rq)
+		lowest_rq = p->sched_class->find_lock_rq(p, rq);
+
+	if (!lowest_rq)
+		goto out_unlock;
+
+	// XXX validate p is still the highest prio task
+	if (task_rq(p) == rq) {
+		deactivate_task(rq, p, 0);
+		set_task_cpu(p, lowest_rq->cpu);
+		activate_task(lowest_rq, p, 0);
+		resched_curr(lowest_rq);
+	}
+
+	double_unlock_balance(rq, lowest_rq);
+
+out_unlock:
+	rq->push_busy = false;
+	raw_spin_unlock(&rq->lock);
+	raw_spin_unlock_irq(&p->pi_lock);
+
+	put_task_struct(p);
+	return 0;
+}
+
 /*
  * sched_class::set_cpus_allowed must do the below, but is not required to
  * actually call this function.
@@ -2052,6 +2090,14 @@ static int affine_move_task(struct rq *rq, struct task_struct *p, struct rq_flag
 
 	/* Can the task run on the task's current CPU? If so, we're done */
 	if (cpumask_test_cpu(task_cpu(p), &p->cpus_mask)) {
+		struct task_struct *push_task = NULL;
+
+		if ((flags & SCA_MIGRATE_ENABLE) &&
+		    (p->migration_flags & MDF_PUSH) && !rq->push_busy) {
+			rq->push_busy = true;
+			push_task = get_task_struct(p);
+		}
+
 		pending = p->migration_pending;
 		if (pending) {
 			refcount_inc(&pending->refs);
@@ -2060,6 +2106,11 @@ static int affine_move_task(struct rq *rq, struct task_struct *p, struct rq_flag
 		}
 		task_rq_unlock(rq, p, rf);
 
+		if (push_task) {
+			stop_one_cpu_nowait(rq->cpu, push_cpu_stop,
+					    p, &rq->push_work);
+		}
+
 		if (complete)
 			goto do_complete;
 
@@ -2098,6 +2149,7 @@ static int affine_move_task(struct rq *rq, struct task_struct *p, struct rq_flag
 	if (flags & SCA_MIGRATE_ENABLE) {
 
 		refcount_inc(&pending->refs); /* pending->{arg,stop_work} */
+		p->migration_flags &= ~MDF_PUSH;
 		task_rq_unlock(rq, p, rf);
 
 		pending->arg = (struct migration_arg) {
@@ -2716,11 +2768,6 @@ static inline int __set_cpus_allowed_ptr(struct task_struct *p,
 
 static inline void migrate_disable_switch(struct rq *rq, struct task_struct *p) { }
 
-static inline bool is_migration_disabled(struct task_struct *p)
-{
-	return false;
-}
-
 static inline bool rq_has_pinned_tasks(struct rq *rq)
 {
 	return false;
diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index 3d3fd83..eed2e44 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -2129,6 +2129,9 @@ static int push_dl_task(struct rq *rq)
 		return 0;
 
 retry:
+	if (is_migration_disabled(next_task))
+		return 0;
+
 	if (WARN_ON(next_task == rq->curr))
 		return 0;
 
@@ -2206,7 +2209,7 @@ static void push_dl_tasks(struct rq *rq)
 static void pull_dl_task(struct rq *this_rq)
 {
 	int this_cpu = this_rq->cpu, cpu;
-	struct task_struct *p;
+	struct task_struct *p, *push_task;
 	bool resched = false;
 	struct rq *src_rq;
 	u64 dmin = LONG_MAX;
@@ -2236,6 +2239,7 @@ static void pull_dl_task(struct rq *this_rq)
 			continue;
 
 		/* Might drop this_rq->lock */
+		push_task = NULL;
 		double_lock_balance(this_rq, src_rq);
 
 		/*
@@ -2267,17 +2271,27 @@ static void pull_dl_task(struct rq *this_rq)
 					   src_rq->curr->dl.deadline))
 				goto skip;
 
-			resched = true;
-
-			deactivate_task(src_rq, p, 0);
-			set_task_cpu(p, this_cpu);
-			activate_task(this_rq, p, 0);
-			dmin = p->dl.deadline;
+			if (is_migration_disabled(p)) {
+				push_task = get_push_task(src_rq);
+			} else {
+				deactivate_task(src_rq, p, 0);
+				set_task_cpu(p, this_cpu);
+				activate_task(this_rq, p, 0);
+				dmin = p->dl.deadline;
+				resched = true;
+			}
 
 			/* Is there any other task even earlier? */
 		}
 skip:
 		double_unlock_balance(this_rq, src_rq);
+
+		if (push_task) {
+			raw_spin_unlock(&this_rq->lock);
+			stop_one_cpu_nowait(src_rq->cpu, push_cpu_stop,
+					    push_task, &src_rq->push_work);
+			raw_spin_lock(&this_rq->lock);
+		}
 	}
 
 	if (resched)
@@ -2524,6 +2538,7 @@ const struct sched_class dl_sched_class
 	.rq_online              = rq_online_dl,
 	.rq_offline             = rq_offline_dl,
 	.task_woken		= task_woken_dl,
+	.find_lock_rq		= find_lock_later_rq,
 #endif
 
 	.task_tick		= task_tick_dl,
diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
index cf63346..c592e47 100644
--- a/kernel/sched/rt.c
+++ b/kernel/sched/rt.c
@@ -1859,7 +1859,7 @@ static struct task_struct *pick_next_pushable_task(struct rq *rq)
  * running task can migrate over to a CPU that is running a task
  * of lesser priority.
  */
-static int push_rt_task(struct rq *rq)
+static int push_rt_task(struct rq *rq, bool pull)
 {
 	struct task_struct *next_task;
 	struct rq *lowest_rq;
@@ -1873,6 +1873,34 @@ static int push_rt_task(struct rq *rq)
 		return 0;
 
 retry:
+	if (is_migration_disabled(next_task)) {
+		struct task_struct *push_task = NULL;
+		int cpu;
+
+		if (!pull || rq->push_busy)
+			return 0;
+
+		cpu = find_lowest_rq(rq->curr);
+		if (cpu == -1 || cpu == rq->cpu)
+			return 0;
+
+		/*
+		 * Given we found a CPU with lower priority than @next_task,
+		 * therefore it should be running. However we cannot migrate it
+		 * to this other CPU, instead attempt to push the current
+		 * running task on this CPU away.
+		 */
+		push_task = get_push_task(rq);
+		if (push_task) {
+			raw_spin_unlock(&rq->lock);
+			stop_one_cpu_nowait(rq->cpu, push_cpu_stop,
+					    push_task, &rq->push_work);
+			raw_spin_lock(&rq->lock);
+		}
+
+		return 0;
+	}
+
 	if (WARN_ON(next_task == rq->curr))
 		return 0;
 
@@ -1927,12 +1955,10 @@ retry:
 	deactivate_task(rq, next_task, 0);
 	set_task_cpu(next_task, lowest_rq->cpu);
 	activate_task(lowest_rq, next_task, 0);
-	ret = 1;
-
 	resched_curr(lowest_rq);
+	ret = 1;
 
 	double_unlock_balance(rq, lowest_rq);
-
 out:
 	put_task_struct(next_task);
 
@@ -1942,7 +1968,7 @@ out:
 static void push_rt_tasks(struct rq *rq)
 {
 	/* push_rt_task will return true if it moved an RT */
-	while (push_rt_task(rq))
+	while (push_rt_task(rq, false))
 		;
 }
 
@@ -2095,7 +2121,8 @@ void rto_push_irq_work_func(struct irq_work *work)
 	 */
 	if (has_pushable_tasks(rq)) {
 		raw_spin_lock(&rq->lock);
-		push_rt_tasks(rq);
+		while (push_rt_task(rq, true))
+			;
 		raw_spin_unlock(&rq->lock);
 	}
 
@@ -2120,7 +2147,7 @@ static void pull_rt_task(struct rq *this_rq)
 {
 	int this_cpu = this_rq->cpu, cpu;
 	bool resched = false;
-	struct task_struct *p;
+	struct task_struct *p, *push_task;
 	struct rq *src_rq;
 	int rt_overload_count = rt_overloaded(this_rq);
 
@@ -2167,6 +2194,7 @@ static void pull_rt_task(struct rq *this_rq)
 		 * double_lock_balance, and another CPU could
 		 * alter this_rq
 		 */
+		push_task = NULL;
 		double_lock_balance(this_rq, src_rq);
 
 		/*
@@ -2194,11 +2222,14 @@ static void pull_rt_task(struct rq *this_rq)
 			if (p->prio < src_rq->curr->prio)
 				goto skip;
 
-			resched = true;
-
-			deactivate_task(src_rq, p, 0);
-			set_task_cpu(p, this_cpu);
-			activate_task(this_rq, p, 0);
+			if (is_migration_disabled(p)) {
+				push_task = get_push_task(src_rq);
+			} else {
+				deactivate_task(src_rq, p, 0);
+				set_task_cpu(p, this_cpu);
+				activate_task(this_rq, p, 0);
+				resched = true;
+			}
 			/*
 			 * We continue with the search, just in
 			 * case there's an even higher prio task
@@ -2208,6 +2239,13 @@ static void pull_rt_task(struct rq *this_rq)
 		}
 skip:
 		double_unlock_balance(this_rq, src_rq);
+
+		if (push_task) {
+			raw_spin_unlock(&this_rq->lock);
+			stop_one_cpu_nowait(src_rq->cpu, push_cpu_stop,
+					    push_task, &src_rq->push_work);
+			raw_spin_lock(&this_rq->lock);
+		}
 	}
 
 	if (resched)
@@ -2449,6 +2487,7 @@ const struct sched_class rt_sched_class
 	.rq_offline             = rq_offline_rt,
 	.task_woken		= task_woken_rt,
 	.switched_from		= switched_from_rt,
+	.find_lock_rq		= find_lock_lowest_rq,
 #endif
 
 	.task_tick		= task_tick_rt,
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 42de140..56992aa 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -1057,6 +1057,8 @@ struct rq {
 #if defined(CONFIG_PREEMPT_RT) && defined(CONFIG_SMP)
 	unsigned int		nr_pinned;
 #endif
+	unsigned int		push_busy;
+	struct cpu_stop_work	push_work;
 };
 
 #ifdef CONFIG_FAIR_GROUP_SCHED
@@ -1084,6 +1086,16 @@ static inline int cpu_of(struct rq *rq)
 #endif
 }
 
+#define MDF_PUSH	0x01
+
+static inline bool is_migration_disabled(struct task_struct *p)
+{
+#if defined(CONFIG_SMP) && defined(CONFIG_PREEMPT_RT)
+	return p->migration_disabled;
+#else
+	return false;
+#endif
+}
 
 #ifdef CONFIG_SCHED_SMT
 extern void __update_idle_core(struct rq *rq);
@@ -1823,6 +1835,8 @@ struct sched_class {
 
 	void (*rq_online)(struct rq *rq);
 	void (*rq_offline)(struct rq *rq);
+
+	struct rq *(*find_lock_rq)(struct task_struct *p, struct rq *rq);
 #endif
 
 	void (*task_tick)(struct rq *rq, struct task_struct *p, int queued);
@@ -1918,6 +1932,24 @@ extern void trigger_load_balance(struct rq *rq);
 
 extern void set_cpus_allowed_common(struct task_struct *p, const struct cpumask *new_mask, u32 flags);
 
+static inline struct task_struct *get_push_task(struct rq *rq)
+{
+	struct task_struct *p = rq->curr;
+
+	lockdep_assert_held(&rq->lock);
+
+	if (rq->push_busy)
+		return NULL;
+
+	if (p->nr_cpus_allowed == 1)
+		return NULL;
+
+	rq->push_busy = true;
+	return get_task_struct(p);
+}
+
+extern int push_cpu_stop(void *arg);
+
 #endif
 
 #ifdef CONFIG_CPU_IDLE
