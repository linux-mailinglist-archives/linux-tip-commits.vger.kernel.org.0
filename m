Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE00A34D4F5
	for <lists+linux-tip-commits@lfdr.de>; Mon, 29 Mar 2021 18:25:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231469AbhC2QYi (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Mon, 29 Mar 2021 12:24:38 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:37656 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231342AbhC2QYN (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Mon, 29 Mar 2021 12:24:13 -0400
Date:   Mon, 29 Mar 2021 16:24:11 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1617035052;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NNS1ir0S8eYkFLYuDsLRrSLNKWAPafjq57N2I5xRAMM=;
        b=ddTx+Mgb1OR3PgeSg+CaxMdS5KamCXOeEvfmAhYT0OLWOkMctH+l7IdeThFIpZQKZ79Oxz
        Tv+V7RON526B7TNyJSzTVjQkczoUNZ4PmjH0nmNLg0i7ttHgF/Rk2I+rdybNhOxQjn7nvY
        +Hdo4lUKptDdeHo+j18y8wio8JkzVNUNzUNhaA6mV/Sfqxt7T5rWKRSaMSdYxNkc0vpRj/
        HLc8Lh8HjUd294woT4BMcMOgZgHVH6uRi4pX+s8TCONa83LMBdsETTIWlO0o6Qs5HDQGe/
        cwRcknRwiXjnRXDzAb5NXTPbipGutFdjUWk5zGKwPBvQqtfUQ8p3wtENDAI7pg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1617035052;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NNS1ir0S8eYkFLYuDsLRrSLNKWAPafjq57N2I5xRAMM=;
        b=/6t2hl0vzgZEA3lgnpDJN5/DI8TPD0pbw1vjXrV+h3bG8p/QboWDlFmXqzwbPbKK5mexmv
        lXp8FYoPhk8n/WDQ==
From:   "tip-bot2 for Sebastian Andrzej Siewior" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] locking/rtmutex: Remove output from deadlock detector
Cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210326153943.320398604@linutronix.de>
References: <20210326153943.320398604@linutronix.de>
MIME-Version: 1.0
Message-ID: <161703505164.29796.7533102196081587077.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     6d41c675a5394057f6fb1dc97cc0a0e360f2c2f8
Gitweb:        https://git.kernel.org/tip/6d41c675a5394057f6fb1dc97cc0a0e360f2c2f8
Author:        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
AuthorDate:    Fri, 26 Mar 2021 16:29:32 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Mon, 29 Mar 2021 15:57:02 +02:00

locking/rtmutex: Remove output from deadlock detector

The rtmutex specific deadlock detector predates lockdep coverage of rtmutex
and since commit f5694788ad8da ("rt_mutex: Add lockdep annotations") it
contains a lot of redundant functionality:

 - lockdep will detect an potential deadlock before rtmutex-debug
   has a chance to do so

 - the deadlock debugging is restricted to rtmutexes which are not
   associated to futexes and have an active waiter, which is covered by
   lockdep already

Remove the redundant functionality and move actual deadlock WARN() into the
deadlock code path. The latter needs a seperate cleanup.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/r/20210326153943.320398604@linutronix.de
---
 include/linux/rtmutex.h         |  7 +--
 kernel/locking/rtmutex-debug.c  | 97 +--------------------------------
 kernel/locking/rtmutex-debug.h  |  9 +---
 kernel/locking/rtmutex.c        |  7 +--
 kernel/locking/rtmutex.h        |  7 +--
 kernel/locking/rtmutex_common.h |  4 +-
 6 files changed, 1 insertion(+), 130 deletions(-)

diff --git a/include/linux/rtmutex.h b/include/linux/rtmutex.h
index 48b334b..0725c4b 100644
--- a/include/linux/rtmutex.h
+++ b/include/linux/rtmutex.h
@@ -31,9 +31,6 @@ struct rt_mutex {
 	raw_spinlock_t		wait_lock;
 	struct rb_root_cached   waiters;
 	struct task_struct	*owner;
-#ifdef CONFIG_DEBUG_RT_MUTEXES
-	const char		*name;
-#endif
 #ifdef CONFIG_DEBUG_LOCK_ALLOC
 	struct lockdep_map	dep_map;
 #endif
@@ -56,8 +53,6 @@ struct hrtimer_sleeper;
 #endif
 
 #ifdef CONFIG_DEBUG_RT_MUTEXES
-# define __DEBUG_RT_MUTEX_INITIALIZER(mutexname) \
-	, .name = #mutexname
 
 # define rt_mutex_init(mutex) \
 do { \
@@ -67,7 +62,6 @@ do { \
 
  extern void rt_mutex_debug_task_free(struct task_struct *tsk);
 #else
-# define __DEBUG_RT_MUTEX_INITIALIZER(mutexname)
 # define rt_mutex_init(mutex)			__rt_mutex_init(mutex, NULL, NULL)
 # define rt_mutex_debug_task_free(t)			do { } while (0)
 #endif
@@ -83,7 +77,6 @@ do { \
 	{ .wait_lock = __RAW_SPIN_LOCK_UNLOCKED(mutexname.wait_lock) \
 	, .waiters = RB_ROOT_CACHED \
 	, .owner = NULL \
-	__DEBUG_RT_MUTEX_INITIALIZER(mutexname) \
 	__DEP_MAP_RT_MUTEX_INITIALIZER(mutexname)}
 
 #define DEFINE_RT_MUTEX(mutexname) \
diff --git a/kernel/locking/rtmutex-debug.c b/kernel/locking/rtmutex-debug.c
index 7e411b9..fb15010 100644
--- a/kernel/locking/rtmutex-debug.c
+++ b/kernel/locking/rtmutex-debug.c
@@ -32,105 +32,12 @@
 
 #include "rtmutex_common.h"
 
-static void printk_task(struct task_struct *p)
-{
-	if (p)
-		printk("%16s:%5d [%p, %3d]", p->comm, task_pid_nr(p), p, p->prio);
-	else
-		printk("<none>");
-}
-
-static void printk_lock(struct rt_mutex *lock, int print_owner)
-{
-	printk(" [%p] {%s}\n", lock, lock->name);
-
-	if (print_owner && rt_mutex_owner(lock)) {
-		printk(".. ->owner: %p\n", lock->owner);
-		printk(".. held by:  ");
-		printk_task(rt_mutex_owner(lock));
-		printk("\n");
-	}
-}
-
 void rt_mutex_debug_task_free(struct task_struct *task)
 {
 	DEBUG_LOCKS_WARN_ON(!RB_EMPTY_ROOT(&task->pi_waiters.rb_root));
 	DEBUG_LOCKS_WARN_ON(task->pi_blocked_on);
 }
 
-/*
- * We fill out the fields in the waiter to store the information about
- * the deadlock. We print when we return. act_waiter can be NULL in
- * case of a remove waiter operation.
- */
-void debug_rt_mutex_deadlock(enum rtmutex_chainwalk chwalk,
-			     struct rt_mutex_waiter *act_waiter,
-			     struct rt_mutex *lock)
-{
-	struct task_struct *task;
-
-	if (!debug_locks || chwalk == RT_MUTEX_FULL_CHAINWALK || !act_waiter)
-		return;
-
-	task = rt_mutex_owner(act_waiter->lock);
-	if (task && task != current) {
-		act_waiter->deadlock_task_pid = get_pid(task_pid(task));
-		act_waiter->deadlock_lock = lock;
-	}
-}
-
-void debug_rt_mutex_print_deadlock(struct rt_mutex_waiter *waiter)
-{
-	struct task_struct *task;
-
-	if (!waiter->deadlock_lock || !debug_locks)
-		return;
-
-	rcu_read_lock();
-	task = pid_task(waiter->deadlock_task_pid, PIDTYPE_PID);
-	if (!task) {
-		rcu_read_unlock();
-		return;
-	}
-
-	if (!debug_locks_off()) {
-		rcu_read_unlock();
-		return;
-	}
-
-	pr_warn("\n");
-	pr_warn("============================================\n");
-	pr_warn("WARNING: circular locking deadlock detected!\n");
-	pr_warn("%s\n", print_tainted());
-	pr_warn("--------------------------------------------\n");
-	printk("%s/%d is deadlocking current task %s/%d\n\n",
-	       task->comm, task_pid_nr(task),
-	       current->comm, task_pid_nr(current));
-
-	printk("\n1) %s/%d is trying to acquire this lock:\n",
-	       current->comm, task_pid_nr(current));
-	printk_lock(waiter->lock, 1);
-
-	printk("\n2) %s/%d is blocked on this lock:\n",
-		task->comm, task_pid_nr(task));
-	printk_lock(waiter->deadlock_lock, 1);
-
-	debug_show_held_locks(current);
-	debug_show_held_locks(task);
-
-	printk("\n%s/%d's [blocked] stackdump:\n\n",
-		task->comm, task_pid_nr(task));
-	show_stack(task, NULL, KERN_DEFAULT);
-	printk("\n%s/%d's [current] stackdump:\n\n",
-		current->comm, task_pid_nr(current));
-	dump_stack();
-	debug_show_all_locks();
-	rcu_read_unlock();
-
-	printk("[ turning off deadlock detection."
-	       "Please report this trace. ]\n\n");
-}
-
 void debug_rt_mutex_lock(struct rt_mutex *lock)
 {
 }
@@ -153,12 +60,10 @@ void debug_rt_mutex_proxy_unlock(struct rt_mutex *lock)
 void debug_rt_mutex_init_waiter(struct rt_mutex_waiter *waiter)
 {
 	memset(waiter, 0x11, sizeof(*waiter));
-	waiter->deadlock_task_pid = NULL;
 }
 
 void debug_rt_mutex_free_waiter(struct rt_mutex_waiter *waiter)
 {
-	put_pid(waiter->deadlock_task_pid);
 	memset(waiter, 0x22, sizeof(*waiter));
 }
 
@@ -168,10 +73,8 @@ void debug_rt_mutex_init(struct rt_mutex *lock, const char *name, struct lock_cl
 	 * Make sure we are not reinitializing a held lock:
 	 */
 	debug_check_no_locks_freed((void *)lock, sizeof(*lock));
-	lock->name = name;
 
 #ifdef CONFIG_DEBUG_LOCK_ALLOC
 	lockdep_init_map(&lock->dep_map, name, key, 0);
 #endif
 }
-
diff --git a/kernel/locking/rtmutex-debug.h b/kernel/locking/rtmutex-debug.h
index 772c9b0..659e93e 100644
--- a/kernel/locking/rtmutex-debug.h
+++ b/kernel/locking/rtmutex-debug.h
@@ -18,18 +18,9 @@ extern void debug_rt_mutex_unlock(struct rt_mutex *lock);
 extern void debug_rt_mutex_proxy_lock(struct rt_mutex *lock,
 				      struct task_struct *powner);
 extern void debug_rt_mutex_proxy_unlock(struct rt_mutex *lock);
-extern void debug_rt_mutex_deadlock(enum rtmutex_chainwalk chwalk,
-				    struct rt_mutex_waiter *waiter,
-				    struct rt_mutex *lock);
-extern void debug_rt_mutex_print_deadlock(struct rt_mutex_waiter *waiter);
 
 static inline bool debug_rt_mutex_detect_deadlock(struct rt_mutex_waiter *waiter,
 						  enum rtmutex_chainwalk walk)
 {
 	return (waiter != NULL);
 }
-
-static inline void rt_mutex_print_deadlock(struct rt_mutex_waiter *w)
-{
-	debug_rt_mutex_print_deadlock(w);
-}
diff --git a/kernel/locking/rtmutex.c b/kernel/locking/rtmutex.c
index 11abc60..4beca54 100644
--- a/kernel/locking/rtmutex.c
+++ b/kernel/locking/rtmutex.c
@@ -579,7 +579,6 @@ static int rt_mutex_adjust_prio_chain(struct task_struct *task,
 	 * walk, we detected a deadlock.
 	 */
 	if (lock == orig_lock || rt_mutex_owner(lock) == top_task) {
-		debug_rt_mutex_deadlock(chwalk, orig_waiter, lock);
 		raw_spin_unlock(&lock->wait_lock);
 		ret = -EDEADLK;
 		goto out_unlock_pi;
@@ -1171,8 +1170,6 @@ __rt_mutex_slowlock(struct rt_mutex *lock, int state,
 
 		raw_spin_unlock_irq(&lock->wait_lock);
 
-		debug_rt_mutex_print_deadlock(waiter);
-
 		schedule();
 
 		raw_spin_lock_irq(&lock->wait_lock);
@@ -1196,7 +1193,7 @@ static void rt_mutex_handle_deadlock(int res, int detect_deadlock,
 	/*
 	 * Yell loudly and stop the task right here.
 	 */
-	rt_mutex_print_deadlock(w);
+	WARN(1, "rtmutex deadlock detected\n");
 	while (1) {
 		set_current_state(TASK_INTERRUPTIBLE);
 		schedule();
@@ -1704,8 +1701,6 @@ int __rt_mutex_start_proxy_lock(struct rt_mutex *lock,
 		ret = 0;
 	}
 
-	debug_rt_mutex_print_deadlock(waiter);
-
 	return ret;
 }
 
diff --git a/kernel/locking/rtmutex.h b/kernel/locking/rtmutex.h
index 4dbdec1..d77cb82 100644
--- a/kernel/locking/rtmutex.h
+++ b/kernel/locking/rtmutex.h
@@ -18,13 +18,6 @@
 #define debug_rt_mutex_proxy_unlock(l)			do { } while (0)
 #define debug_rt_mutex_unlock(l)			do { } while (0)
 #define debug_rt_mutex_init(m, n, k)			do { } while (0)
-#define debug_rt_mutex_deadlock(d, a ,l)		do { } while (0)
-#define debug_rt_mutex_print_deadlock(w)		do { } while (0)
-
-static inline void rt_mutex_print_deadlock(struct rt_mutex_waiter *w)
-{
-	WARN(1, "rtmutex deadlock detected\n");
-}
 
 static inline bool debug_rt_mutex_detect_deadlock(struct rt_mutex_waiter *w,
 						  enum rtmutex_chainwalk walk)
diff --git a/kernel/locking/rtmutex_common.h b/kernel/locking/rtmutex_common.h
index aa04743..badb2a2 100644
--- a/kernel/locking/rtmutex_common.h
+++ b/kernel/locking/rtmutex_common.h
@@ -29,10 +29,6 @@ struct rt_mutex_waiter {
 	struct rb_node          pi_tree_entry;
 	struct task_struct	*task;
 	struct rt_mutex		*lock;
-#ifdef CONFIG_DEBUG_RT_MUTEXES
-	struct pid		*deadlock_task_pid;
-	struct rt_mutex		*deadlock_lock;
-#endif
 	int prio;
 	u64 deadline;
 };
