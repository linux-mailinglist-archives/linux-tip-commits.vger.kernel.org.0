Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 806B11CE6CC
	for <lists+linux-tip-commits@lfdr.de>; Mon, 11 May 2020 23:05:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732482AbgEKVDw (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Mon, 11 May 2020 17:03:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1731976AbgEKU7p (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Mon, 11 May 2020 16:59:45 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41A51C061A0C;
        Mon, 11 May 2020 13:59:45 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jYFWZ-0005sH-Mp; Mon, 11 May 2020 22:59:43 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 2D5D21C0845;
        Mon, 11 May 2020 22:59:33 +0200 (CEST)
Date:   Mon, 11 May 2020 20:59:33 -0000
From:   "tip-bot2 for Paul E. McKenney" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] rcu-tasks: Refactor RCU-tasks to allow variants to be added
Cc:     "Paul E. McKenney" <paulmck@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <158923077309.390.16213054772697278113.tip-bot2@tip-bot2>
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

Commit-ID:     5873b8a94e5dae04b8e11fc798df512614e6d1e7
Gitweb:        https://git.kernel.org/tip/5873b8a94e5dae04b8e11fc798df512614e6d1e7
Author:        Paul E. McKenney <paulmck@kernel.org>
AuthorDate:    Tue, 03 Mar 2020 11:49:21 -08:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Mon, 27 Apr 2020 11:03:51 -07:00

rcu-tasks: Refactor RCU-tasks to allow variants to be added

This commit splits out generic processing from RCU-tasks-specific
processing in order to allow additional flavors to be added.  It also
adds a def_bool TASKS_RCU_GENERIC to enable the common RCU-tasks
infrastructure code.

This is primarily, but not entirely, a code-movement commit.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 include/linux/rcupdate.h |   6 +-
 kernel/rcu/Kconfig       |  10 +-
 kernel/rcu/tasks.h       | 491 +++++++++++++++++++-------------------
 kernel/rcu/update.c      |   4 +-
 4 files changed, 272 insertions(+), 239 deletions(-)

diff --git a/include/linux/rcupdate.h b/include/linux/rcupdate.h
index 2678a37..5523145 100644
--- a/include/linux/rcupdate.h
+++ b/include/linux/rcupdate.h
@@ -129,7 +129,7 @@ static inline void rcu_init_nohz(void) { }
  * Note a quasi-voluntary context switch for RCU-tasks's benefit.
  * This is a macro rather than an inline function to avoid #include hell.
  */
-#ifdef CONFIG_TASKS_RCU
+#ifdef CONFIG_TASKS_RCU_GENERIC
 #define rcu_tasks_qs(t) \
 	do { \
 		if (READ_ONCE((t)->rcu_tasks_holdout)) \
@@ -140,14 +140,14 @@ void call_rcu_tasks(struct rcu_head *head, rcu_callback_t func);
 void synchronize_rcu_tasks(void);
 void exit_tasks_rcu_start(void);
 void exit_tasks_rcu_finish(void);
-#else /* #ifdef CONFIG_TASKS_RCU */
+#else /* #ifdef CONFIG_TASKS_RCU_GENERIC */
 #define rcu_tasks_qs(t)	do { } while (0)
 #define rcu_note_voluntary_context_switch(t) do { } while (0)
 #define call_rcu_tasks call_rcu
 #define synchronize_rcu_tasks synchronize_rcu
 static inline void exit_tasks_rcu_start(void) { }
 static inline void exit_tasks_rcu_finish(void) { }
-#endif /* #else #ifdef CONFIG_TASKS_RCU */
+#endif /* #else #ifdef CONFIG_TASKS_RCU_GENERIC */
 
 /**
  * cond_resched_tasks_rcu_qs - Report potential quiescent states to RCU
diff --git a/kernel/rcu/Kconfig b/kernel/rcu/Kconfig
index 1cc940f..38475d0 100644
--- a/kernel/rcu/Kconfig
+++ b/kernel/rcu/Kconfig
@@ -70,13 +70,19 @@ config TREE_SRCU
 	help
 	  This option selects the full-fledged version of SRCU.
 
+config TASKS_RCU_GENERIC
+	def_bool TASKS_RCU
+	select SRCU
+	help
+	  This option enables generic infrastructure code supporting
+	  task-based RCU implementations.  Not for manual selection.
+
 config TASKS_RCU
 	def_bool PREEMPTION
-	select SRCU
 	help
 	  This option enables a task-based RCU implementation that uses
 	  only voluntary context switch (not preemption!), idle, and
-	  user-mode execution as quiescent states.
+	  user-mode execution as quiescent states.  Not for manual selection.
 
 config RCU_STALL_COMMON
 	def_bool TREE_RCU
diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
index 5ccfe0d..d77921e 100644
--- a/kernel/rcu/tasks.h
+++ b/kernel/rcu/tasks.h
@@ -5,7 +5,13 @@
  * Copyright (C) 2020 Paul E. McKenney
  */
 
-#ifdef CONFIG_TASKS_RCU
+
+////////////////////////////////////////////////////////////////////////
+//
+// Generic data structures.
+
+struct rcu_tasks;
+typedef void (*rcu_tasks_gp_func_t)(struct rcu_tasks *rtp);
 
 /**
  * Definition for a Tasks-RCU-like mechanism.
@@ -14,6 +20,8 @@
  * @cbs_wq: Wait queue allowning new callback to get kthread's attention.
  * @cbs_lock: Lock protecting callback list.
  * @kthread_ptr: This flavor's grace-period/callback-invocation kthread.
+ * @gp_func: This flavor's grace-period-wait function.
+ * @call_func: This flavor's call_rcu()-equivalent function.
  */
 struct rcu_tasks {
 	struct rcu_head *cbs_head;
@@ -21,29 +29,20 @@ struct rcu_tasks {
 	struct wait_queue_head cbs_wq;
 	raw_spinlock_t cbs_lock;
 	struct task_struct *kthread_ptr;
+	rcu_tasks_gp_func_t gp_func;
+	call_rcu_func_t call_func;
 };
 
-#define DEFINE_RCU_TASKS(name)						\
+#define DEFINE_RCU_TASKS(name, gp, call)				\
 static struct rcu_tasks name =						\
 {									\
 	.cbs_tail = &name.cbs_head,					\
 	.cbs_wq = __WAIT_QUEUE_HEAD_INITIALIZER(name.cbs_wq),		\
 	.cbs_lock = __RAW_SPIN_LOCK_UNLOCKED(name.cbs_lock),		\
+	.gp_func = gp,							\
+	.call_func = call,						\
 }
 
-/*
- * Simple variant of RCU whose quiescent states are voluntary context
- * switch, cond_resched_rcu_qs(), user-space execution, and idle.
- * As such, grace periods can take one good long time.  There are no
- * read-side primitives similar to rcu_read_lock() and rcu_read_unlock()
- * because this implementation is intended to get the system into a safe
- * state for some of the manipulations involved in tracing and the like.
- * Finally, this implementation does not support high call_rcu_tasks()
- * rates from multiple CPUs.  If this is required, per-CPU callback lists
- * will be needed.
- */
-DEFINE_RCU_TASKS(rcu_tasks);
-
 /* Track exiting tasks in order to allow them to be waited for. */
 DEFINE_STATIC_SRCU(tasks_rcu_exit_srcu);
 
@@ -52,29 +51,16 @@ DEFINE_STATIC_SRCU(tasks_rcu_exit_srcu);
 static int rcu_task_stall_timeout __read_mostly = RCU_TASK_STALL_TIMEOUT;
 module_param(rcu_task_stall_timeout, int, 0644);
 
-/**
- * call_rcu_tasks() - Queue an RCU for invocation task-based grace period
- * @rhp: structure to be used for queueing the RCU updates.
- * @func: actual callback function to be invoked after the grace period
- *
- * The callback function will be invoked some time after a full grace
- * period elapses, in other words after all currently executing RCU
- * read-side critical sections have completed. call_rcu_tasks() assumes
- * that the read-side critical sections end at a voluntary context
- * switch (not a preemption!), cond_resched_rcu_qs(), entry into idle,
- * or transition to usermode execution.  As such, there are no read-side
- * primitives analogous to rcu_read_lock() and rcu_read_unlock() because
- * this primitive is intended to determine that all tasks have passed
- * through a safe state, not so much for data-strcuture synchronization.
- *
- * See the description of call_rcu() for more detailed information on
- * memory ordering guarantees.
- */
-void call_rcu_tasks(struct rcu_head *rhp, rcu_callback_t func)
+////////////////////////////////////////////////////////////////////////
+//
+// Generic code.
+
+// Enqueue a callback for the specified flavor of Tasks RCU.
+static void call_rcu_tasks_generic(struct rcu_head *rhp, rcu_callback_t func,
+				   struct rcu_tasks *rtp)
 {
 	unsigned long flags;
 	bool needwake;
-	struct rcu_tasks *rtp = &rcu_tasks;
 
 	rhp->next = NULL;
 	rhp->func = func;
@@ -87,108 +73,25 @@ void call_rcu_tasks(struct rcu_head *rhp, rcu_callback_t func)
 	if (needwake && READ_ONCE(rtp->kthread_ptr))
 		wake_up(&rtp->cbs_wq);
 }
-EXPORT_SYMBOL_GPL(call_rcu_tasks);
 
-/**
- * synchronize_rcu_tasks - wait until an rcu-tasks grace period has elapsed.
- *
- * Control will return to the caller some time after a full rcu-tasks
- * grace period has elapsed, in other words after all currently
- * executing rcu-tasks read-side critical sections have elapsed.  These
- * read-side critical sections are delimited by calls to schedule(),
- * cond_resched_tasks_rcu_qs(), idle execution, userspace execution, calls
- * to synchronize_rcu_tasks(), and (in theory, anyway) cond_resched().
- *
- * This is a very specialized primitive, intended only for a few uses in
- * tracing and other situations requiring manipulation of function
- * preambles and profiling hooks.  The synchronize_rcu_tasks() function
- * is not (yet) intended for heavy use from multiple CPUs.
- *
- * Note that this guarantee implies further memory-ordering guarantees.
- * On systems with more than one CPU, when synchronize_rcu_tasks() returns,
- * each CPU is guaranteed to have executed a full memory barrier since the
- * end of its last RCU-tasks read-side critical section whose beginning
- * preceded the call to synchronize_rcu_tasks().  In addition, each CPU
- * having an RCU-tasks read-side critical section that extends beyond
- * the return from synchronize_rcu_tasks() is guaranteed to have executed
- * a full memory barrier after the beginning of synchronize_rcu_tasks()
- * and before the beginning of that RCU-tasks read-side critical section.
- * Note that these guarantees include CPUs that are offline, idle, or
- * executing in user mode, as well as CPUs that are executing in the kernel.
- *
- * Furthermore, if CPU A invoked synchronize_rcu_tasks(), which returned
- * to its caller on CPU B, then both CPU A and CPU B are guaranteed
- * to have executed a full memory barrier during the execution of
- * synchronize_rcu_tasks() -- even if CPU A and CPU B are the same CPU
- * (but again only if the system has more than one CPU).
- */
-void synchronize_rcu_tasks(void)
+// Wait for a grace period for the specified flavor of Tasks RCU.
+static void synchronize_rcu_tasks_generic(struct rcu_tasks *rtp)
 {
 	/* Complain if the scheduler has not started.  */
 	RCU_LOCKDEP_WARN(rcu_scheduler_active == RCU_SCHEDULER_INACTIVE,
 			 "synchronize_rcu_tasks called too soon");
 
 	/* Wait for the grace period. */
-	wait_rcu_gp(call_rcu_tasks);
-}
-EXPORT_SYMBOL_GPL(synchronize_rcu_tasks);
-
-/**
- * rcu_barrier_tasks - Wait for in-flight call_rcu_tasks() callbacks.
- *
- * Although the current implementation is guaranteed to wait, it is not
- * obligated to, for example, if there are no pending callbacks.
- */
-void rcu_barrier_tasks(void)
-{
-	/* There is only one callback queue, so this is easy.  ;-) */
-	synchronize_rcu_tasks();
-}
-EXPORT_SYMBOL_GPL(rcu_barrier_tasks);
-
-/* See if tasks are still holding out, complain if so. */
-static void check_holdout_task(struct task_struct *t,
-			       bool needreport, bool *firstreport)
-{
-	int cpu;
-
-	if (!READ_ONCE(t->rcu_tasks_holdout) ||
-	    t->rcu_tasks_nvcsw != READ_ONCE(t->nvcsw) ||
-	    !READ_ONCE(t->on_rq) ||
-	    (IS_ENABLED(CONFIG_NO_HZ_FULL) &&
-	     !is_idle_task(t) && t->rcu_tasks_idle_cpu >= 0)) {
-		WRITE_ONCE(t->rcu_tasks_holdout, false);
-		list_del_init(&t->rcu_tasks_holdout_list);
-		put_task_struct(t);
-		return;
-	}
-	rcu_request_urgent_qs_task(t);
-	if (!needreport)
-		return;
-	if (*firstreport) {
-		pr_err("INFO: rcu_tasks detected stalls on tasks:\n");
-		*firstreport = false;
-	}
-	cpu = task_cpu(t);
-	pr_alert("%p: %c%c nvcsw: %lu/%lu holdout: %d idle_cpu: %d/%d\n",
-		 t, ".I"[is_idle_task(t)],
-		 "N."[cpu < 0 || !tick_nohz_full_cpu(cpu)],
-		 t->rcu_tasks_nvcsw, t->nvcsw, t->rcu_tasks_holdout,
-		 t->rcu_tasks_idle_cpu, cpu);
-	sched_show_task(t);
+	wait_rcu_gp(rtp->call_func);
 }
 
 /* RCU-tasks kthread that detects grace periods and invokes callbacks. */
 static int __noreturn rcu_tasks_kthread(void *arg)
 {
 	unsigned long flags;
-	struct task_struct *g, *t;
-	unsigned long lastreport;
 	struct rcu_head *list;
 	struct rcu_head *next;
-	LIST_HEAD(rcu_tasks_holdouts);
 	struct rcu_tasks *rtp = arg;
-	int fract;
 
 	/* Run on housekeeping CPUs by default.  Sysadm can move if desired. */
 	housekeeping_affine(current, HK_FLAG_RCU);
@@ -220,111 +123,8 @@ static int __noreturn rcu_tasks_kthread(void *arg)
 			continue;
 		}
 
-		/*
-		 * Wait for all pre-existing t->on_rq and t->nvcsw
-		 * transitions to complete.  Invoking synchronize_rcu()
-		 * suffices because all these transitions occur with
-		 * interrupts disabled.  Without this synchronize_rcu(),
-		 * a read-side critical section that started before the
-		 * grace period might be incorrectly seen as having started
-		 * after the grace period.
-		 *
-		 * This synchronize_rcu() also dispenses with the
-		 * need for a memory barrier on the first store to
-		 * t->rcu_tasks_holdout, as it forces the store to happen
-		 * after the beginning of the grace period.
-		 */
-		synchronize_rcu();
-
-		/*
-		 * There were callbacks, so we need to wait for an
-		 * RCU-tasks grace period.  Start off by scanning
-		 * the task list for tasks that are not already
-		 * voluntarily blocked.  Mark these tasks and make
-		 * a list of them in rcu_tasks_holdouts.
-		 */
-		rcu_read_lock();
-		for_each_process_thread(g, t) {
-			if (t != current && READ_ONCE(t->on_rq) &&
-			    !is_idle_task(t)) {
-				get_task_struct(t);
-				t->rcu_tasks_nvcsw = READ_ONCE(t->nvcsw);
-				WRITE_ONCE(t->rcu_tasks_holdout, true);
-				list_add(&t->rcu_tasks_holdout_list,
-					 &rcu_tasks_holdouts);
-			}
-		}
-		rcu_read_unlock();
-
-		/*
-		 * Wait for tasks that are in the process of exiting.
-		 * This does only part of the job, ensuring that all
-		 * tasks that were previously exiting reach the point
-		 * where they have disabled preemption, allowing the
-		 * later synchronize_rcu() to finish the job.
-		 */
-		synchronize_srcu(&tasks_rcu_exit_srcu);
-
-		/*
-		 * Each pass through the following loop scans the list
-		 * of holdout tasks, removing any that are no longer
-		 * holdouts.  When the list is empty, we are done.
-		 */
-		lastreport = jiffies;
-
-		/* Start off with HZ/10 wait and slowly back off to 1 HZ wait*/
-		fract = 10;
-
-		for (;;) {
-			bool firstreport;
-			bool needreport;
-			int rtst;
-			struct task_struct *t1;
-
-			if (list_empty(&rcu_tasks_holdouts))
-				break;
-
-			/* Slowly back off waiting for holdouts */
-			schedule_timeout_interruptible(HZ/fract);
-
-			if (fract > 1)
-				fract--;
-
-			rtst = READ_ONCE(rcu_task_stall_timeout);
-			needreport = rtst > 0 &&
-				     time_after(jiffies, lastreport + rtst);
-			if (needreport)
-				lastreport = jiffies;
-			firstreport = true;
-			WARN_ON(signal_pending(current));
-			list_for_each_entry_safe(t, t1, &rcu_tasks_holdouts,
-						 rcu_tasks_holdout_list) {
-				check_holdout_task(t, needreport, &firstreport);
-				cond_resched();
-			}
-		}
-
-		/*
-		 * Because ->on_rq and ->nvcsw are not guaranteed
-		 * to have a full memory barriers prior to them in the
-		 * schedule() path, memory reordering on other CPUs could
-		 * cause their RCU-tasks read-side critical sections to
-		 * extend past the end of the grace period.  However,
-		 * because these ->nvcsw updates are carried out with
-		 * interrupts disabled, we can use synchronize_rcu()
-		 * to force the needed ordering on all such CPUs.
-		 *
-		 * This synchronize_rcu() also confines all
-		 * ->rcu_tasks_holdout accesses to be within the grace
-		 * period, avoiding the need for memory barriers for
-		 * ->rcu_tasks_holdout accesses.
-		 *
-		 * In addition, this synchronize_rcu() waits for exiting
-		 * tasks to complete their final preempt_disable() region
-		 * of execution, cleaning up after the synchronize_srcu()
-		 * above.
-		 */
-		synchronize_rcu();
+		// Wait for one grace period.
+		rtp->gp_func(rtp);
 
 		/* Invoke the callbacks. */
 		while (list) {
@@ -340,18 +140,16 @@ static int __noreturn rcu_tasks_kthread(void *arg)
 	}
 }
 
-/* Spawn rcu_tasks_kthread() at core_initcall() time. */
-static int __init rcu_spawn_tasks_kthread(void)
+/* Spawn RCU-tasks grace-period kthread, e.g., at core_initcall() time. */
+static void __init rcu_spawn_tasks_kthread_generic(struct rcu_tasks *rtp)
 {
 	struct task_struct *t;
 
-	t = kthread_run(rcu_tasks_kthread, &rcu_tasks, "rcu_tasks_kthread");
+	t = kthread_run(rcu_tasks_kthread, rtp, "rcu_tasks_kthread");
 	if (WARN_ONCE(IS_ERR(t), "%s: Could not start Tasks-RCU grace-period kthread, OOM is now expected behavior\n", __func__))
-		return 0;
+		return;
 	smp_mb(); /* Ensure others see full kthread. */
-	return 0;
 }
-core_initcall(rcu_spawn_tasks_kthread);
 
 /* Do the srcu_read_lock() for the above synchronize_srcu().  */
 void exit_tasks_rcu_start(void) __acquires(&tasks_rcu_exit_srcu)
@@ -369,8 +167,6 @@ void exit_tasks_rcu_finish(void) __releases(&tasks_rcu_exit_srcu)
 	preempt_enable();
 }
 
-#endif /* #ifdef CONFIG_TASKS_RCU */
-
 #ifndef CONFIG_TINY_RCU
 
 /*
@@ -387,3 +183,230 @@ static void __init rcu_tasks_bootup_oddness(void)
 }
 
 #endif /* #ifndef CONFIG_TINY_RCU */
+
+#ifdef CONFIG_TASKS_RCU
+
+////////////////////////////////////////////////////////////////////////
+//
+// Simple variant of RCU whose quiescent states are voluntary context
+// switch, cond_resched_rcu_qs(), user-space execution, and idle.
+// As such, grace periods can take one good long time.  There are no
+// read-side primitives similar to rcu_read_lock() and rcu_read_unlock()
+// because this implementation is intended to get the system into a safe
+// state for some of the manipulations involved in tracing and the like.
+// Finally, this implementation does not support high call_rcu_tasks()
+// rates from multiple CPUs.  If this is required, per-CPU callback lists
+// will be needed.
+
+/* See if tasks are still holding out, complain if so. */
+static void check_holdout_task(struct task_struct *t,
+			       bool needreport, bool *firstreport)
+{
+	int cpu;
+
+	if (!READ_ONCE(t->rcu_tasks_holdout) ||
+	    t->rcu_tasks_nvcsw != READ_ONCE(t->nvcsw) ||
+	    !READ_ONCE(t->on_rq) ||
+	    (IS_ENABLED(CONFIG_NO_HZ_FULL) &&
+	     !is_idle_task(t) && t->rcu_tasks_idle_cpu >= 0)) {
+		WRITE_ONCE(t->rcu_tasks_holdout, false);
+		list_del_init(&t->rcu_tasks_holdout_list);
+		put_task_struct(t);
+		return;
+	}
+	rcu_request_urgent_qs_task(t);
+	if (!needreport)
+		return;
+	if (*firstreport) {
+		pr_err("INFO: rcu_tasks detected stalls on tasks:\n");
+		*firstreport = false;
+	}
+	cpu = task_cpu(t);
+	pr_alert("%p: %c%c nvcsw: %lu/%lu holdout: %d idle_cpu: %d/%d\n",
+		 t, ".I"[is_idle_task(t)],
+		 "N."[cpu < 0 || !tick_nohz_full_cpu(cpu)],
+		 t->rcu_tasks_nvcsw, t->nvcsw, t->rcu_tasks_holdout,
+		 t->rcu_tasks_idle_cpu, cpu);
+	sched_show_task(t);
+}
+
+/* Wait for one RCU-tasks grace period. */
+static void rcu_tasks_wait_gp(struct rcu_tasks *rtp)
+{
+	struct task_struct *g, *t;
+	unsigned long lastreport;
+	LIST_HEAD(rcu_tasks_holdouts);
+	int fract;
+
+	/*
+	 * Wait for all pre-existing t->on_rq and t->nvcsw transitions
+	 * to complete.  Invoking synchronize_rcu() suffices because all
+	 * these transitions occur with interrupts disabled.  Without this
+	 * synchronize_rcu(), a read-side critical section that started
+	 * before the grace period might be incorrectly seen as having
+	 * started after the grace period.
+	 *
+	 * This synchronize_rcu() also dispenses with the need for a
+	 * memory barrier on the first store to t->rcu_tasks_holdout,
+	 * as it forces the store to happen after the beginning of the
+	 * grace period.
+	 */
+	synchronize_rcu();
+
+	/*
+	 * There were callbacks, so we need to wait for an RCU-tasks
+	 * grace period.  Start off by scanning the task list for tasks
+	 * that are not already voluntarily blocked.  Mark these tasks
+	 * and make a list of them in rcu_tasks_holdouts.
+	 */
+	rcu_read_lock();
+	for_each_process_thread(g, t) {
+		if (t != current && READ_ONCE(t->on_rq) && !is_idle_task(t)) {
+			get_task_struct(t);
+			t->rcu_tasks_nvcsw = READ_ONCE(t->nvcsw);
+			WRITE_ONCE(t->rcu_tasks_holdout, true);
+			list_add(&t->rcu_tasks_holdout_list,
+				 &rcu_tasks_holdouts);
+		}
+	}
+	rcu_read_unlock();
+
+	/*
+	 * Wait for tasks that are in the process of exiting.  This
+	 * does only part of the job, ensuring that all tasks that were
+	 * previously exiting reach the point where they have disabled
+	 * preemption, allowing the later synchronize_rcu() to finish
+	 * the job.
+	 */
+	synchronize_srcu(&tasks_rcu_exit_srcu);
+
+	/*
+	 * Each pass through the following loop scans the list of holdout
+	 * tasks, removing any that are no longer holdouts.  When the list
+	 * is empty, we are done.
+	 */
+	lastreport = jiffies;
+
+	/* Start off with HZ/10 wait and slowly back off to 1 HZ wait. */
+	fract = 10;
+
+	for (;;) {
+		bool firstreport;
+		bool needreport;
+		int rtst;
+		struct task_struct *t1;
+
+		if (list_empty(&rcu_tasks_holdouts))
+			break;
+
+		/* Slowly back off waiting for holdouts */
+		schedule_timeout_interruptible(HZ/fract);
+
+		if (fract > 1)
+			fract--;
+
+		rtst = READ_ONCE(rcu_task_stall_timeout);
+		needreport = rtst > 0 && time_after(jiffies, lastreport + rtst);
+		if (needreport)
+			lastreport = jiffies;
+		firstreport = true;
+		WARN_ON(signal_pending(current));
+		list_for_each_entry_safe(t, t1, &rcu_tasks_holdouts,
+					 rcu_tasks_holdout_list) {
+			check_holdout_task(t, needreport, &firstreport);
+			cond_resched();
+		}
+	}
+
+	/*
+	 * Because ->on_rq and ->nvcsw are not guaranteed to have a full
+	 * memory barriers prior to them in the schedule() path, memory
+	 * reordering on other CPUs could cause their RCU-tasks read-side
+	 * critical sections to extend past the end of the grace period.
+	 * However, because these ->nvcsw updates are carried out with
+	 * interrupts disabled, we can use synchronize_rcu() to force the
+	 * needed ordering on all such CPUs.
+	 *
+	 * This synchronize_rcu() also confines all ->rcu_tasks_holdout
+	 * accesses to be within the grace period, avoiding the need for
+	 * memory barriers for ->rcu_tasks_holdout accesses.
+	 *
+	 * In addition, this synchronize_rcu() waits for exiting tasks
+	 * to complete their final preempt_disable() region of execution,
+	 * cleaning up after the synchronize_srcu() above.
+	 */
+	synchronize_rcu();
+}
+
+void call_rcu_tasks(struct rcu_head *rhp, rcu_callback_t func);
+DEFINE_RCU_TASKS(rcu_tasks, rcu_tasks_wait_gp, call_rcu_tasks);
+
+/**
+ * call_rcu_tasks() - Queue an RCU for invocation task-based grace period
+ * @rhp: structure to be used for queueing the RCU updates.
+ * @func: actual callback function to be invoked after the grace period
+ *
+ * The callback function will be invoked some time after a full grace
+ * period elapses, in other words after all currently executing RCU
+ * read-side critical sections have completed. call_rcu_tasks() assumes
+ * that the read-side critical sections end at a voluntary context
+ * switch (not a preemption!), cond_resched_rcu_qs(), entry into idle,
+ * or transition to usermode execution.  As such, there are no read-side
+ * primitives analogous to rcu_read_lock() and rcu_read_unlock() because
+ * this primitive is intended to determine that all tasks have passed
+ * through a safe state, not so much for data-strcuture synchronization.
+ *
+ * See the description of call_rcu() for more detailed information on
+ * memory ordering guarantees.
+ */
+void call_rcu_tasks(struct rcu_head *rhp, rcu_callback_t func)
+{
+	call_rcu_tasks_generic(rhp, func, &rcu_tasks);
+}
+EXPORT_SYMBOL_GPL(call_rcu_tasks);
+
+/**
+ * synchronize_rcu_tasks - wait until an rcu-tasks grace period has elapsed.
+ *
+ * Control will return to the caller some time after a full rcu-tasks
+ * grace period has elapsed, in other words after all currently
+ * executing rcu-tasks read-side critical sections have elapsed.  These
+ * read-side critical sections are delimited by calls to schedule(),
+ * cond_resched_tasks_rcu_qs(), idle execution, userspace execution, calls
+ * to synchronize_rcu_tasks(), and (in theory, anyway) cond_resched().
+ *
+ * This is a very specialized primitive, intended only for a few uses in
+ * tracing and other situations requiring manipulation of function
+ * preambles and profiling hooks.  The synchronize_rcu_tasks() function
+ * is not (yet) intended for heavy use from multiple CPUs.
+ *
+ * See the description of synchronize_rcu() for more detailed information
+ * on memory ordering guarantees.
+ */
+void synchronize_rcu_tasks(void)
+{
+	synchronize_rcu_tasks_generic(&rcu_tasks);
+}
+EXPORT_SYMBOL_GPL(synchronize_rcu_tasks);
+
+/**
+ * rcu_barrier_tasks - Wait for in-flight call_rcu_tasks() callbacks.
+ *
+ * Although the current implementation is guaranteed to wait, it is not
+ * obligated to, for example, if there are no pending callbacks.
+ */
+void rcu_barrier_tasks(void)
+{
+	/* There is only one callback queue, so this is easy.  ;-) */
+	synchronize_rcu_tasks();
+}
+EXPORT_SYMBOL_GPL(rcu_barrier_tasks);
+
+static int __init rcu_spawn_tasks_kthread(void)
+{
+	rcu_spawn_tasks_kthread_generic(&rcu_tasks);
+	return 0;
+}
+core_initcall(rcu_spawn_tasks_kthread);
+
+#endif /* #ifdef CONFIG_TASKS_RCU */
diff --git a/kernel/rcu/update.c b/kernel/rcu/update.c
index c579934..30dce20 100644
--- a/kernel/rcu/update.c
+++ b/kernel/rcu/update.c
@@ -584,7 +584,11 @@ late_initcall(rcu_verify_early_boot_tests);
 void rcu_early_boot_tests(void) {}
 #endif /* CONFIG_PROVE_RCU */
 
+#ifdef CONFIG_TASKS_RCU_GENERIC
 #include "tasks.h"
+#else /* #ifdef CONFIG_TASKS_RCU_GENERIC */
+static inline void rcu_tasks_bootup_oddness(void) {}
+#endif /* #else #ifdef CONFIG_TASKS_RCU_GENERIC */
 
 #ifndef CONFIG_TINY_RCU
 
