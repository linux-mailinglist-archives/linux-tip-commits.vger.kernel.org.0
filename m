Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2CC2822948D
	for <lists+linux-tip-commits@lfdr.de>; Wed, 22 Jul 2020 11:12:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731208AbgGVJMc (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 22 Jul 2020 05:12:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728911AbgGVJMb (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 22 Jul 2020 05:12:31 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECEA1C0619DC;
        Wed, 22 Jul 2020 02:12:30 -0700 (PDT)
Date:   Wed, 22 Jul 2020 09:12:28 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1595409149;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+DJ+I4aS/gkX6Q8ZZ3+h7UQGFFh2i+GvC9LXYxbNNhs=;
        b=OKIw5v91yOyT6JIk65HGV6NhF5yiPaffuOXTlH9L93XHxQlqMcydMsQ5BNJKVw9RyL7/lP
        ok/K/0afqdBJnq7D2WKQH9cPkj1iq4/S6Cbd6mUnR2vvoxT+PKo/bUiX3VtoXCwdretfl6
        mH86/9wH6YSShQYdnaHQ3SBHib2/ogw+a9myjgN7SKlPac4amA74NO96uj5W5HlSVKQUby
        MzGge5Si86fW/baFrBpHXLQhw26InXtPObBfqXkauG+kJJ6T/ucpn8bQSSe0fk8VF9JHtP
        BZdbHzwvUuYO+gZzl3X7AebLvLXWZc3ZJKVySDMsuXNtyVnJj1l5vNXvuXZ9zw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1595409149;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+DJ+I4aS/gkX6Q8ZZ3+h7UQGFFh2i+GvC9LXYxbNNhs=;
        b=nA7zX8gQL6T9jZ7gWjhVz5blDZ7e4EUiOwvoA0RlY+/W0q5dE/wMCRG3SIP0IRWkPXBQAm
        KHBinWa0NI6NpJDg==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched: Better document ttwu()
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200702125211.GQ4800@hirez.programming.kicks-ass.net>
References: <20200702125211.GQ4800@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Message-ID: <159540914842.4006.14987114768301139831.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-tip-commits-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     58877d347b58c9e971112df5eb311c13bb0acb28
Gitweb:        https://git.kernel.org/tip/58877d347b58c9e971112df5eb311c13bb0acb28
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Thu, 02 Jul 2020 14:52:11 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 22 Jul 2020 10:22:03 +02:00

sched: Better document ttwu()

Dave hit the problem fixed by commit:

  b6e13e85829f ("sched/core: Fix ttwu() race")

and failed to understand much of the code involved. Per his request a
few comments to (hopefully) clarify things.

Requested-by: Dave Chinner <david@fromorbit.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20200702125211.GQ4800@hirez.programming.kicks-ass.net
---
 include/linux/sched.h |  12 +--
 kernel/sched/core.c   | 188 +++++++++++++++++++++++++++++++++++------
 kernel/sched/sched.h  |  10 ++-
 3 files changed, 179 insertions(+), 31 deletions(-)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index 12b10ce..5033813 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -154,24 +154,24 @@ struct task_group;
  *
  *   for (;;) {
  *	set_current_state(TASK_UNINTERRUPTIBLE);
- *	if (!need_sleep)
- *		break;
+ *	if (CONDITION)
+ *	   break;
  *
  *	schedule();
  *   }
  *   __set_current_state(TASK_RUNNING);
  *
  * If the caller does not need such serialisation (because, for instance, the
- * condition test and condition change and wakeup are under the same lock) then
+ * CONDITION test and condition change and wakeup are under the same lock) then
  * use __set_current_state().
  *
  * The above is typically ordered against the wakeup, which does:
  *
- *   need_sleep = false;
+ *   CONDITION = 1;
  *   wake_up_state(p, TASK_UNINTERRUPTIBLE);
  *
- * where wake_up_state() executes a full memory barrier before accessing the
- * task state.
+ * where wake_up_state()/try_to_wake_up() executes a full memory barrier before
+ * accessing p->state.
  *
  * Wakeup will do: if (@state & p->state) p->state = TASK_RUNNING, that is,
  * once it observes the TASK_UNINTERRUPTIBLE store the waking CPU can issue a
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 08d02ce..12db8fb 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -79,6 +79,100 @@ __read_mostly int scheduler_running;
  */
 int sysctl_sched_rt_runtime = 950000;
 
+
+/*
+ * Serialization rules:
+ *
+ * Lock order:
+ *
+ *   p->pi_lock
+ *     rq->lock
+ *       hrtimer_cpu_base->lock (hrtimer_start() for bandwidth controls)
+ *
+ *  rq1->lock
+ *    rq2->lock  where: rq1 < rq2
+ *
+ * Regular state:
+ *
+ * Normal scheduling state is serialized by rq->lock. __schedule() takes the
+ * local CPU's rq->lock, it optionally removes the task from the runqueue and
+ * always looks at the local rq data structures to find the most elegible task
+ * to run next.
+ *
+ * Task enqueue is also under rq->lock, possibly taken from another CPU.
+ * Wakeups from another LLC domain might use an IPI to transfer the enqueue to
+ * the local CPU to avoid bouncing the runqueue state around [ see
+ * ttwu_queue_wakelist() ]
+ *
+ * Task wakeup, specifically wakeups that involve migration, are horribly
+ * complicated to avoid having to take two rq->locks.
+ *
+ * Special state:
+ *
+ * System-calls and anything external will use task_rq_lock() which acquires
+ * both p->pi_lock and rq->lock. As a consequence the state they change is
+ * stable while holding either lock:
+ *
+ *  - sched_setaffinity()/
+ *    set_cpus_allowed_ptr():	p->cpus_ptr, p->nr_cpus_allowed
+ *  - set_user_nice():		p->se.load, p->*prio
+ *  - __sched_setscheduler():	p->sched_class, p->policy, p->*prio,
+ *				p->se.load, p->rt_priority,
+ *				p->dl.dl_{runtime, deadline, period, flags, bw, density}
+ *  - sched_setnuma():		p->numa_preferred_nid
+ *  - sched_move_task()/
+ *    cpu_cgroup_fork():	p->sched_task_group
+ *  - uclamp_update_active()	p->uclamp*
+ *
+ * p->state <- TASK_*:
+ *
+ *   is changed locklessly using set_current_state(), __set_current_state() or
+ *   set_special_state(), see their respective comments, or by
+ *   try_to_wake_up(). This latter uses p->pi_lock to serialize against
+ *   concurrent self.
+ *
+ * p->on_rq <- { 0, 1 = TASK_ON_RQ_QUEUED, 2 = TASK_ON_RQ_MIGRATING }:
+ *
+ *   is set by activate_task() and cleared by deactivate_task(), under
+ *   rq->lock. Non-zero indicates the task is runnable, the special
+ *   ON_RQ_MIGRATING state is used for migration without holding both
+ *   rq->locks. It indicates task_cpu() is not stable, see task_rq_lock().
+ *
+ * p->on_cpu <- { 0, 1 }:
+ *
+ *   is set by prepare_task() and cleared by finish_task() such that it will be
+ *   set before p is scheduled-in and cleared after p is scheduled-out, both
+ *   under rq->lock. Non-zero indicates the task is running on its CPU.
+ *
+ *   [ The astute reader will observe that it is possible for two tasks on one
+ *     CPU to have ->on_cpu = 1 at the same time. ]
+ *
+ * task_cpu(p): is changed by set_task_cpu(), the rules are:
+ *
+ *  - Don't call set_task_cpu() on a blocked task:
+ *
+ *    We don't care what CPU we're not running on, this simplifies hotplug,
+ *    the CPU assignment of blocked tasks isn't required to be valid.
+ *
+ *  - for try_to_wake_up(), called under p->pi_lock:
+ *
+ *    This allows try_to_wake_up() to only take one rq->lock, see its comment.
+ *
+ *  - for migration called under rq->lock:
+ *    [ see task_on_rq_migrating() in task_rq_lock() ]
+ *
+ *    o move_queued_task()
+ *    o detach_task()
+ *
+ *  - for migration called under double_rq_lock():
+ *
+ *    o __migrate_swap_task()
+ *    o push_rt_task() / pull_rt_task()
+ *    o push_dl_task() / pull_dl_task()
+ *    o dl_task_offline_migration()
+ *
+ */
+
 /*
  * __task_rq_lock - lock the rq @p resides on.
  */
@@ -1543,8 +1637,7 @@ static struct rq *move_queued_task(struct rq *rq, struct rq_flags *rf,
 {
 	lockdep_assert_held(&rq->lock);
 
-	WRITE_ONCE(p->on_rq, TASK_ON_RQ_MIGRATING);
-	dequeue_task(rq, p, DEQUEUE_NOCLOCK);
+	deactivate_task(rq, p, DEQUEUE_NOCLOCK);
 	set_task_cpu(p, new_cpu);
 	rq_unlock(rq, rf);
 
@@ -1552,8 +1645,7 @@ static struct rq *move_queued_task(struct rq *rq, struct rq_flags *rf,
 
 	rq_lock(rq, rf);
 	BUG_ON(task_cpu(p) != new_cpu);
-	enqueue_task(rq, p, 0);
-	p->on_rq = TASK_ON_RQ_QUEUED;
+	activate_task(rq, p, 0);
 	check_preempt_curr(rq, p, 0);
 
 	return rq;
@@ -2318,12 +2410,31 @@ ttwu_do_activate(struct rq *rq, struct task_struct *p, int wake_flags,
 }
 
 /*
- * Called in case the task @p isn't fully descheduled from its runqueue,
- * in this case we must do a remote wakeup. Its a 'light' wakeup though,
- * since all we need to do is flip p->state to TASK_RUNNING, since
- * the task is still ->on_rq.
+ * Consider @p being inside a wait loop:
+ *
+ *   for (;;) {
+ *      set_current_state(TASK_UNINTERRUPTIBLE);
+ *
+ *      if (CONDITION)
+ *         break;
+ *
+ *      schedule();
+ *   }
+ *   __set_current_state(TASK_RUNNING);
+ *
+ * between set_current_state() and schedule(). In this case @p is still
+ * runnable, so all that needs doing is change p->state back to TASK_RUNNING in
+ * an atomic manner.
+ *
+ * By taking task_rq(p)->lock we serialize against schedule(), if @p->on_rq
+ * then schedule() must still happen and p->state can be changed to
+ * TASK_RUNNING. Otherwise we lost the race, schedule() has happened, and we
+ * need to do a full wakeup with enqueue.
+ *
+ * Returns: %true when the wakeup is done,
+ *          %false otherwise.
  */
-static int ttwu_remote(struct task_struct *p, int wake_flags)
+static int ttwu_runnable(struct task_struct *p, int wake_flags)
 {
 	struct rq_flags rf;
 	struct rq *rq;
@@ -2464,6 +2575,14 @@ static bool ttwu_queue_wakelist(struct task_struct *p, int cpu, int wake_flags)
 
 	return false;
 }
+
+#else /* !CONFIG_SMP */
+
+static inline bool ttwu_queue_wakelist(struct task_struct *p, int cpu, int wake_flags)
+{
+	return false;
+}
+
 #endif /* CONFIG_SMP */
 
 static void ttwu_queue(struct task_struct *p, int cpu, int wake_flags)
@@ -2471,10 +2590,8 @@ static void ttwu_queue(struct task_struct *p, int cpu, int wake_flags)
 	struct rq *rq = cpu_rq(cpu);
 	struct rq_flags rf;
 
-#if defined(CONFIG_SMP)
 	if (ttwu_queue_wakelist(p, cpu, wake_flags))
 		return;
-#endif
 
 	rq_lock(rq, &rf);
 	update_rq_clock(rq);
@@ -2530,8 +2647,8 @@ static void ttwu_queue(struct task_struct *p, int cpu, int wake_flags)
  * migration. However the means are completely different as there is no lock
  * chain to provide order. Instead we do:
  *
- *   1) smp_store_release(X->on_cpu, 0)
- *   2) smp_cond_load_acquire(!X->on_cpu)
+ *   1) smp_store_release(X->on_cpu, 0)   -- finish_task()
+ *   2) smp_cond_load_acquire(!X->on_cpu) -- try_to_wake_up()
  *
  * Example:
  *
@@ -2571,15 +2688,33 @@ static void ttwu_queue(struct task_struct *p, int cpu, int wake_flags)
  * @state: the mask of task states that can be woken
  * @wake_flags: wake modifier flags (WF_*)
  *
- * If (@state & @p->state) @p->state = TASK_RUNNING.
+ * Conceptually does:
+ *
+ *   If (@state & @p->state) @p->state = TASK_RUNNING.
  *
  * If the task was not queued/runnable, also place it back on a runqueue.
  *
- * Atomic against schedule() which would dequeue a task, also see
- * set_current_state().
+ * This function is atomic against schedule() which would dequeue the task.
+ *
+ * It issues a full memory barrier before accessing @p->state, see the comment
+ * with set_current_state().
+ *
+ * Uses p->pi_lock to serialize against concurrent wake-ups.
  *
- * This function executes a full memory barrier before accessing the task
- * state; see set_current_state().
+ * Relies on p->pi_lock stabilizing:
+ *  - p->sched_class
+ *  - p->cpus_ptr
+ *  - p->sched_task_group
+ * in order to do migration, see its use of select_task_rq()/set_task_cpu().
+ *
+ * Tries really hard to only take one task_rq(p)->lock for performance.
+ * Takes rq->lock in:
+ *  - ttwu_runnable()    -- old rq, unavoidable, see comment there;
+ *  - ttwu_queue()       -- new rq, for enqueue of the task;
+ *  - psi_ttwu_dequeue() -- much sadness :-( accounting will kill us.
+ *
+ * As a consequence we race really badly with just about everything. See the
+ * many memory barriers and their comments for details.
  *
  * Return: %true if @p->state changes (an actual wakeup was done),
  *	   %false otherwise.
@@ -2595,7 +2730,7 @@ try_to_wake_up(struct task_struct *p, unsigned int state, int wake_flags)
 		/*
 		 * We're waking current, this means 'p->on_rq' and 'task_cpu(p)
 		 * == smp_processor_id()'. Together this means we can special
-		 * case the whole 'p->on_rq && ttwu_remote()' case below
+		 * case the whole 'p->on_rq && ttwu_runnable()' case below
 		 * without taking any locks.
 		 *
 		 * In particular:
@@ -2616,8 +2751,8 @@ try_to_wake_up(struct task_struct *p, unsigned int state, int wake_flags)
 	/*
 	 * If we are going to wake up a thread waiting for CONDITION we
 	 * need to ensure that CONDITION=1 done by the caller can not be
-	 * reordered with p->state check below. This pairs with mb() in
-	 * set_current_state() the waiting thread does.
+	 * reordered with p->state check below. This pairs with smp_store_mb()
+	 * in set_current_state() that the waiting thread does.
 	 */
 	raw_spin_lock_irqsave(&p->pi_lock, flags);
 	smp_mb__after_spinlock();
@@ -2652,7 +2787,7 @@ try_to_wake_up(struct task_struct *p, unsigned int state, int wake_flags)
 	 * A similar smb_rmb() lives in try_invoke_on_locked_down_task().
 	 */
 	smp_rmb();
-	if (READ_ONCE(p->on_rq) && ttwu_remote(p, wake_flags))
+	if (READ_ONCE(p->on_rq) && ttwu_runnable(p, wake_flags))
 		goto unlock;
 
 	if (p->in_iowait) {
@@ -3222,8 +3357,10 @@ static inline void prepare_task(struct task_struct *next)
 	/*
 	 * Claim the task as running, we do this before switching to it
 	 * such that any running task will have this set.
+	 *
+	 * See the ttwu() WF_ON_CPU case and its ordering comment.
 	 */
-	next->on_cpu = 1;
+	WRITE_ONCE(next->on_cpu, 1);
 #endif
 }
 
@@ -3231,8 +3368,9 @@ static inline void finish_task(struct task_struct *prev)
 {
 #ifdef CONFIG_SMP
 	/*
-	 * After ->on_cpu is cleared, the task can be moved to a different CPU.
-	 * We must ensure this doesn't happen until the switch is completely
+	 * This must be the very last reference to @prev from this CPU. After
+	 * p->on_cpu is cleared, the task can be moved to a different CPU. We
+	 * must ensure this doesn't happen until the switch is completely
 	 * finished.
 	 *
 	 * In particular, the load of prev->state in finish_task_switch() must
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 65b72e0..9f33c77 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -1203,6 +1203,16 @@ struct rq_flags {
 #endif
 };
 
+/*
+ * Lockdep annotation that avoids accidental unlocks; it's like a
+ * sticky/continuous lockdep_assert_held().
+ *
+ * This avoids code that has access to 'struct rq *rq' (basically everything in
+ * the scheduler) from accidentally unlocking the rq if they do not also have a
+ * copy of the (on-stack) 'struct rq_flags rf'.
+ *
+ * Also see Documentation/locking/lockdep-design.rst.
+ */
 static inline void rq_pin_lock(struct rq *rq, struct rq_flags *rf)
 {
 	rf->cookie = lockdep_pin_lock(&rq->lock);
