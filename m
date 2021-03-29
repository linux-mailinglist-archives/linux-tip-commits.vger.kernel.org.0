Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DCF0D34D4E2
	for <lists+linux-tip-commits@lfdr.de>; Mon, 29 Mar 2021 18:25:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231259AbhC2QYd (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Mon, 29 Mar 2021 12:24:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231320AbhC2QYL (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Mon, 29 Mar 2021 12:24:11 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9809C061762;
        Mon, 29 Mar 2021 09:24:10 -0700 (PDT)
Date:   Mon, 29 Mar 2021 16:24:09 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1617035049;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=OQYumU0VcJVDP4mfQs+xlLJTg8h9d0k71/mvhsyyz54=;
        b=jOiJHLQ+XzI31OXdLzBH3qEoG5U8Ktg/ybb9eoavmQ4mfSVe9srfLuDBSiTAqh6Gkat65L
        6FXPFJuA4tlN1c4XymyWjuyVeS7gwTiA/aNbbf8HnmAZGnAP9rPle/Lr1boQ1rSxHfa3UC
        HXnvCduqeQzAarL82hGPdXGCGYvrVecxmArH1u3BG0GOCHJDxqBkGXnFSKq7YZKgLff1Tz
        /FBkB6yeMcwvkjWrDbXh9gG6z7ZHJBaqPWLpw+ziLf82ozjnfcayVPHzU1YPjUy4TA6pT4
        o5nPCzwxWK+jkWdCMMfEd++3gwfUaRgSnYR88DctTtieOEl8MQOeuu1xt4imaQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1617035049;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=OQYumU0VcJVDP4mfQs+xlLJTg8h9d0k71/mvhsyyz54=;
        b=WAW7NZrKIkWmBljh5FCdVnnoPllPq9Cx989X7hOKY8LBEP6z58WMAF3YVjfIKjzFHMtt/d
        9EVpvZTR7ljcaACg==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] locking/rtmutex: Make text section and inlining
 consistent
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210326153944.152977820@linutronix.de>
References: <20210326153944.152977820@linutronix.de>
MIME-Version: 1.0
Message-ID: <161703504901.29796.10973484060765767726.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     d7a2edb890c0bfe467140c0cd79fe7cf65249376
Gitweb:        https://git.kernel.org/tip/d7a2edb890c0bfe467140c0cd79fe7cf65249376
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Fri, 26 Mar 2021 16:29:40 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Mon, 29 Mar 2021 15:57:04 +02:00

locking/rtmutex: Make text section and inlining consistent

rtmutex is half __sched and the other half is not. If the compiler decides
to not inline larger static functions then part of the code ends up in the
regular text section.

There are also quite some performance related small helpers which are
either static or plain inline. Force inline those which make sense and mark
the rest __sched.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/r/20210326153944.152977820@linutronix.de
---
 kernel/locking/rtmutex.c | 152 +++++++++++++++++++-------------------
 1 file changed, 76 insertions(+), 76 deletions(-)

diff --git a/kernel/locking/rtmutex.c b/kernel/locking/rtmutex.c
index c9c2ab5..3612821 100644
--- a/kernel/locking/rtmutex.c
+++ b/kernel/locking/rtmutex.c
@@ -49,7 +49,7 @@
  * set this bit before looking at the lock.
  */
 
-static void
+static __always_inline void
 rt_mutex_set_owner(struct rt_mutex *lock, struct task_struct *owner)
 {
 	unsigned long val = (unsigned long)owner;
@@ -60,13 +60,13 @@ rt_mutex_set_owner(struct rt_mutex *lock, struct task_struct *owner)
 	WRITE_ONCE(lock->owner, (struct task_struct *)val);
 }
 
-static inline void clear_rt_mutex_waiters(struct rt_mutex *lock)
+static __always_inline void clear_rt_mutex_waiters(struct rt_mutex *lock)
 {
 	lock->owner = (struct task_struct *)
 			((unsigned long)lock->owner & ~RT_MUTEX_HAS_WAITERS);
 }
 
-static void fixup_rt_mutex_waiters(struct rt_mutex *lock)
+static __always_inline void fixup_rt_mutex_waiters(struct rt_mutex *lock)
 {
 	unsigned long owner, *p = (unsigned long *) &lock->owner;
 
@@ -149,7 +149,7 @@ static void fixup_rt_mutex_waiters(struct rt_mutex *lock)
  * all future threads that attempt to [Rmw] the lock to the slowpath. As such
  * relaxed semantics suffice.
  */
-static inline void mark_rt_mutex_waiters(struct rt_mutex *lock)
+static __always_inline void mark_rt_mutex_waiters(struct rt_mutex *lock)
 {
 	unsigned long owner, *p = (unsigned long *) &lock->owner;
 
@@ -165,8 +165,8 @@ static inline void mark_rt_mutex_waiters(struct rt_mutex *lock)
  * 2) Drop lock->wait_lock
  * 3) Try to unlock the lock with cmpxchg
  */
-static inline bool unlock_rt_mutex_safe(struct rt_mutex *lock,
-					unsigned long flags)
+static __always_inline bool unlock_rt_mutex_safe(struct rt_mutex *lock,
+						 unsigned long flags)
 	__releases(lock->wait_lock)
 {
 	struct task_struct *owner = rt_mutex_owner(lock);
@@ -204,7 +204,7 @@ static inline bool unlock_rt_mutex_safe(struct rt_mutex *lock,
 # define rt_mutex_cmpxchg_acquire(l,c,n)	(0)
 # define rt_mutex_cmpxchg_release(l,c,n)	(0)
 
-static inline void mark_rt_mutex_waiters(struct rt_mutex *lock)
+static __always_inline void mark_rt_mutex_waiters(struct rt_mutex *lock)
 {
 	lock->owner = (struct task_struct *)
 			((unsigned long)lock->owner | RT_MUTEX_HAS_WAITERS);
@@ -213,8 +213,8 @@ static inline void mark_rt_mutex_waiters(struct rt_mutex *lock)
 /*
  * Simple slow path only version: lock->owner is protected by lock->wait_lock.
  */
-static inline bool unlock_rt_mutex_safe(struct rt_mutex *lock,
-					unsigned long flags)
+static __always_inline bool unlock_rt_mutex_safe(struct rt_mutex *lock,
+						 unsigned long flags)
 	__releases(lock->wait_lock)
 {
 	lock->owner = NULL;
@@ -229,9 +229,8 @@ static inline bool unlock_rt_mutex_safe(struct rt_mutex *lock,
 #define task_to_waiter(p)	\
 	&(struct rt_mutex_waiter){ .prio = (p)->prio, .deadline = (p)->dl.deadline }
 
-static inline int
-rt_mutex_waiter_less(struct rt_mutex_waiter *left,
-		     struct rt_mutex_waiter *right)
+static __always_inline int rt_mutex_waiter_less(struct rt_mutex_waiter *left,
+						struct rt_mutex_waiter *right)
 {
 	if (left->prio < right->prio)
 		return 1;
@@ -248,9 +247,8 @@ rt_mutex_waiter_less(struct rt_mutex_waiter *left,
 	return 0;
 }
 
-static inline int
-rt_mutex_waiter_equal(struct rt_mutex_waiter *left,
-		      struct rt_mutex_waiter *right)
+static __always_inline int rt_mutex_waiter_equal(struct rt_mutex_waiter *left,
+						 struct rt_mutex_waiter *right)
 {
 	if (left->prio != right->prio)
 		return 0;
@@ -270,18 +268,18 @@ rt_mutex_waiter_equal(struct rt_mutex_waiter *left,
 #define __node_2_waiter(node) \
 	rb_entry((node), struct rt_mutex_waiter, tree_entry)
 
-static inline bool __waiter_less(struct rb_node *a, const struct rb_node *b)
+static __always_inline bool __waiter_less(struct rb_node *a, const struct rb_node *b)
 {
 	return rt_mutex_waiter_less(__node_2_waiter(a), __node_2_waiter(b));
 }
 
-static void
+static __always_inline void
 rt_mutex_enqueue(struct rt_mutex *lock, struct rt_mutex_waiter *waiter)
 {
 	rb_add_cached(&waiter->tree_entry, &lock->waiters, __waiter_less);
 }
 
-static void
+static __always_inline void
 rt_mutex_dequeue(struct rt_mutex *lock, struct rt_mutex_waiter *waiter)
 {
 	if (RB_EMPTY_NODE(&waiter->tree_entry))
@@ -294,18 +292,19 @@ rt_mutex_dequeue(struct rt_mutex *lock, struct rt_mutex_waiter *waiter)
 #define __node_2_pi_waiter(node) \
 	rb_entry((node), struct rt_mutex_waiter, pi_tree_entry)
 
-static inline bool __pi_waiter_less(struct rb_node *a, const struct rb_node *b)
+static __always_inline bool
+__pi_waiter_less(struct rb_node *a, const struct rb_node *b)
 {
 	return rt_mutex_waiter_less(__node_2_pi_waiter(a), __node_2_pi_waiter(b));
 }
 
-static void
+static __always_inline void
 rt_mutex_enqueue_pi(struct task_struct *task, struct rt_mutex_waiter *waiter)
 {
 	rb_add_cached(&waiter->pi_tree_entry, &task->pi_waiters, __pi_waiter_less);
 }
 
-static void
+static __always_inline void
 rt_mutex_dequeue_pi(struct task_struct *task, struct rt_mutex_waiter *waiter)
 {
 	if (RB_EMPTY_NODE(&waiter->pi_tree_entry))
@@ -315,7 +314,7 @@ rt_mutex_dequeue_pi(struct task_struct *task, struct rt_mutex_waiter *waiter)
 	RB_CLEAR_NODE(&waiter->pi_tree_entry);
 }
 
-static void rt_mutex_adjust_prio(struct task_struct *p)
+static __always_inline void rt_mutex_adjust_prio(struct task_struct *p)
 {
 	struct task_struct *pi_task = NULL;
 
@@ -340,8 +339,9 @@ static void rt_mutex_adjust_prio(struct task_struct *p)
  * deadlock detection is disabled independent of the detect argument
  * and the config settings.
  */
-static bool rt_mutex_cond_detect_deadlock(struct rt_mutex_waiter *waiter,
-					  enum rtmutex_chainwalk chwalk)
+static __always_inline bool
+rt_mutex_cond_detect_deadlock(struct rt_mutex_waiter *waiter,
+			      enum rtmutex_chainwalk chwalk)
 {
 	if (IS_ENABLED(CONFIG_DEBUG_RT_MUTEX))
 		return waiter != NULL;
@@ -353,7 +353,7 @@ static bool rt_mutex_cond_detect_deadlock(struct rt_mutex_waiter *waiter,
  */
 int max_lock_depth = 1024;
 
-static inline struct rt_mutex *task_blocked_on_lock(struct task_struct *p)
+static __always_inline struct rt_mutex *task_blocked_on_lock(struct task_struct *p)
 {
 	return p->pi_blocked_on ? p->pi_blocked_on->lock : NULL;
 }
@@ -421,12 +421,12 @@ static inline struct rt_mutex *task_blocked_on_lock(struct task_struct *p)
  *	  unlock(lock->wait_lock);		release [L]
  *	  goto again;
  */
-static int rt_mutex_adjust_prio_chain(struct task_struct *task,
-				      enum rtmutex_chainwalk chwalk,
-				      struct rt_mutex *orig_lock,
-				      struct rt_mutex *next_lock,
-				      struct rt_mutex_waiter *orig_waiter,
-				      struct task_struct *top_task)
+static int __sched rt_mutex_adjust_prio_chain(struct task_struct *task,
+					      enum rtmutex_chainwalk chwalk,
+					      struct rt_mutex *orig_lock,
+					      struct rt_mutex *next_lock,
+					      struct rt_mutex_waiter *orig_waiter,
+					      struct task_struct *top_task)
 {
 	struct rt_mutex_waiter *waiter, *top_waiter = orig_waiter;
 	struct rt_mutex_waiter *prerequeue_top_waiter;
@@ -778,8 +778,9 @@ static int rt_mutex_adjust_prio_chain(struct task_struct *task,
  * @waiter: The waiter that is queued to the lock's wait tree if the
  *	    callsite called task_blocked_on_lock(), otherwise NULL
  */
-static int try_to_take_rt_mutex(struct rt_mutex *lock, struct task_struct *task,
-				struct rt_mutex_waiter *waiter)
+static int __sched
+try_to_take_rt_mutex(struct rt_mutex *lock, struct task_struct *task,
+		     struct rt_mutex_waiter *waiter)
 {
 	lockdep_assert_held(&lock->wait_lock);
 
@@ -896,10 +897,10 @@ takeit:
  *
  * This must be called with lock->wait_lock held and interrupts disabled
  */
-static int task_blocks_on_rt_mutex(struct rt_mutex *lock,
-				   struct rt_mutex_waiter *waiter,
-				   struct task_struct *task,
-				   enum rtmutex_chainwalk chwalk)
+static int __sched task_blocks_on_rt_mutex(struct rt_mutex *lock,
+					   struct rt_mutex_waiter *waiter,
+					   struct task_struct *task,
+					   enum rtmutex_chainwalk chwalk)
 {
 	struct task_struct *owner = rt_mutex_owner(lock);
 	struct rt_mutex_waiter *top_waiter = waiter;
@@ -985,8 +986,8 @@ static int task_blocks_on_rt_mutex(struct rt_mutex *lock,
  *
  * Called with lock->wait_lock held and interrupts disabled.
  */
-static void mark_wakeup_next_waiter(struct wake_q_head *wake_q,
-				    struct rt_mutex *lock)
+static void __sched mark_wakeup_next_waiter(struct wake_q_head *wake_q,
+					    struct rt_mutex *lock)
 {
 	struct rt_mutex_waiter *waiter;
 
@@ -1035,8 +1036,8 @@ static void mark_wakeup_next_waiter(struct wake_q_head *wake_q,
  * Must be called with lock->wait_lock held and interrupts disabled. I must
  * have just failed to try_to_take_rt_mutex().
  */
-static void remove_waiter(struct rt_mutex *lock,
-			  struct rt_mutex_waiter *waiter)
+static void __sched remove_waiter(struct rt_mutex *lock,
+				  struct rt_mutex_waiter *waiter)
 {
 	bool is_top_waiter = (waiter == rt_mutex_top_waiter(lock));
 	struct task_struct *owner = rt_mutex_owner(lock);
@@ -1093,7 +1094,7 @@ static void remove_waiter(struct rt_mutex *lock,
  *
  * Called from sched_setscheduler
  */
-void rt_mutex_adjust_pi(struct task_struct *task)
+void __sched rt_mutex_adjust_pi(struct task_struct *task)
 {
 	struct rt_mutex_waiter *waiter;
 	struct rt_mutex *next_lock;
@@ -1116,7 +1117,7 @@ void rt_mutex_adjust_pi(struct task_struct *task)
 				   next_lock, NULL, task);
 }
 
-void rt_mutex_init_waiter(struct rt_mutex_waiter *waiter)
+void __sched rt_mutex_init_waiter(struct rt_mutex_waiter *waiter)
 {
 	debug_rt_mutex_init_waiter(waiter);
 	RB_CLEAR_NODE(&waiter->pi_tree_entry);
@@ -1134,10 +1135,9 @@ void rt_mutex_init_waiter(struct rt_mutex_waiter *waiter)
  *
  * Must be called with lock->wait_lock held and interrupts disabled
  */
-static int __sched
-__rt_mutex_slowlock(struct rt_mutex *lock, int state,
-		    struct hrtimer_sleeper *timeout,
-		    struct rt_mutex_waiter *waiter)
+static int __sched __rt_mutex_slowlock(struct rt_mutex *lock, int state,
+				       struct hrtimer_sleeper *timeout,
+				       struct rt_mutex_waiter *waiter)
 {
 	int ret = 0;
 
@@ -1172,8 +1172,8 @@ __rt_mutex_slowlock(struct rt_mutex *lock, int state,
 	return ret;
 }
 
-static void rt_mutex_handle_deadlock(int res, int detect_deadlock,
-				     struct rt_mutex_waiter *w)
+static void __sched rt_mutex_handle_deadlock(int res, int detect_deadlock,
+					     struct rt_mutex_waiter *w)
 {
 	/*
 	 * If the result is not -EDEADLOCK or the caller requested
@@ -1195,10 +1195,9 @@ static void rt_mutex_handle_deadlock(int res, int detect_deadlock,
 /*
  * Slow path lock function:
  */
-static int __sched
-rt_mutex_slowlock(struct rt_mutex *lock, int state,
-		  struct hrtimer_sleeper *timeout,
-		  enum rtmutex_chainwalk chwalk)
+static int __sched rt_mutex_slowlock(struct rt_mutex *lock, int state,
+				     struct hrtimer_sleeper *timeout,
+				     enum rtmutex_chainwalk chwalk)
 {
 	struct rt_mutex_waiter waiter;
 	unsigned long flags;
@@ -1257,7 +1256,7 @@ rt_mutex_slowlock(struct rt_mutex *lock, int state,
 	return ret;
 }
 
-static inline int __rt_mutex_slowtrylock(struct rt_mutex *lock)
+static int __sched __rt_mutex_slowtrylock(struct rt_mutex *lock)
 {
 	int ret = try_to_take_rt_mutex(lock, current, NULL);
 
@@ -1273,7 +1272,7 @@ static inline int __rt_mutex_slowtrylock(struct rt_mutex *lock)
 /*
  * Slow path try-lock function:
  */
-static inline int rt_mutex_slowtrylock(struct rt_mutex *lock)
+static int __sched rt_mutex_slowtrylock(struct rt_mutex *lock)
 {
 	unsigned long flags;
 	int ret;
@@ -1371,7 +1370,7 @@ static bool __sched rt_mutex_slowunlock(struct rt_mutex *lock,
  * The atomic acquire/release ops are compiled away, when either the
  * architecture does not support cmpxchg or when debugging is enabled.
  */
-static inline int
+static __always_inline int
 rt_mutex_fastlock(struct rt_mutex *lock, int state,
 		  int (*slowfn)(struct rt_mutex *lock, int state,
 				struct hrtimer_sleeper *timeout,
@@ -1383,7 +1382,7 @@ rt_mutex_fastlock(struct rt_mutex *lock, int state,
 	return slowfn(lock, state, NULL, RT_MUTEX_MIN_CHAINWALK);
 }
 
-static inline int
+static __always_inline int
 rt_mutex_fasttrylock(struct rt_mutex *lock,
 		     int (*slowfn)(struct rt_mutex *lock))
 {
@@ -1396,7 +1395,7 @@ rt_mutex_fasttrylock(struct rt_mutex *lock,
 /*
  * Performs the wakeup of the top-waiter and re-enables preemption.
  */
-void rt_mutex_postunlock(struct wake_q_head *wake_q)
+void __sched rt_mutex_postunlock(struct wake_q_head *wake_q)
 {
 	wake_up_q(wake_q);
 
@@ -1404,7 +1403,7 @@ void rt_mutex_postunlock(struct wake_q_head *wake_q)
 	preempt_enable();
 }
 
-static inline void
+static __always_inline void
 rt_mutex_fastunlock(struct rt_mutex *lock,
 		    bool (*slowfn)(struct rt_mutex *lock,
 				   struct wake_q_head *wqh))
@@ -1418,7 +1417,8 @@ rt_mutex_fastunlock(struct rt_mutex *lock,
 		rt_mutex_postunlock(&wake_q);
 }
 
-static inline void __rt_mutex_lock(struct rt_mutex *lock, unsigned int subclass)
+static __always_inline void __rt_mutex_lock(struct rt_mutex *lock,
+					    unsigned int subclass)
 {
 	might_sleep();
 
@@ -1536,7 +1536,7 @@ EXPORT_SYMBOL_GPL(rt_mutex_unlock);
  * @wake_q:	The wake queue head from which to get the next lock waiter
  */
 bool __sched __rt_mutex_futex_unlock(struct rt_mutex *lock,
-				    struct wake_q_head *wake_q)
+				     struct wake_q_head *wake_q)
 {
 	lockdep_assert_held(&lock->wait_lock);
 
@@ -1583,7 +1583,7 @@ void __sched rt_mutex_futex_unlock(struct rt_mutex *lock)
  *
  * Initializing of a locked rt_mutex is not allowed
  */
-void __rt_mutex_init(struct rt_mutex *lock, const char *name,
+void __sched __rt_mutex_init(struct rt_mutex *lock, const char *name,
 		     struct lock_class_key *key)
 {
 	debug_check_no_locks_freed((void *)lock, sizeof(*lock));
@@ -1607,8 +1607,8 @@ EXPORT_SYMBOL_GPL(__rt_mutex_init);
  * possible at this point because the pi_state which contains the rtmutex
  * is not yet visible to other tasks.
  */
-void rt_mutex_init_proxy_locked(struct rt_mutex *lock,
-				struct task_struct *proxy_owner)
+void __sched rt_mutex_init_proxy_locked(struct rt_mutex *lock,
+					struct task_struct *proxy_owner)
 {
 	__rt_mutex_basic_init(lock);
 	rt_mutex_set_owner(lock, proxy_owner);
@@ -1626,7 +1626,7 @@ void rt_mutex_init_proxy_locked(struct rt_mutex *lock,
  * possible because it belongs to the pi_state which is about to be freed
  * and it is not longer visible to other tasks.
  */
-void rt_mutex_proxy_unlock(struct rt_mutex *lock)
+void __sched rt_mutex_proxy_unlock(struct rt_mutex *lock)
 {
 	debug_rt_mutex_proxy_unlock(lock);
 	rt_mutex_set_owner(lock, NULL);
@@ -1651,9 +1651,9 @@ void rt_mutex_proxy_unlock(struct rt_mutex *lock)
  *
  * Special API call for PI-futex support.
  */
-int __rt_mutex_start_proxy_lock(struct rt_mutex *lock,
-			      struct rt_mutex_waiter *waiter,
-			      struct task_struct *task)
+int __sched __rt_mutex_start_proxy_lock(struct rt_mutex *lock,
+					struct rt_mutex_waiter *waiter,
+					struct task_struct *task)
 {
 	int ret;
 
@@ -1698,9 +1698,9 @@ int __rt_mutex_start_proxy_lock(struct rt_mutex *lock,
  *
  * Special API call for PI-futex support.
  */
-int rt_mutex_start_proxy_lock(struct rt_mutex *lock,
-			      struct rt_mutex_waiter *waiter,
-			      struct task_struct *task)
+int __sched rt_mutex_start_proxy_lock(struct rt_mutex *lock,
+				      struct rt_mutex_waiter *waiter,
+				      struct task_struct *task)
 {
 	int ret;
 
@@ -1730,9 +1730,9 @@ int rt_mutex_start_proxy_lock(struct rt_mutex *lock,
  *
  * Special API call for PI-futex support
  */
-int rt_mutex_wait_proxy_lock(struct rt_mutex *lock,
-			       struct hrtimer_sleeper *to,
-			       struct rt_mutex_waiter *waiter)
+int __sched rt_mutex_wait_proxy_lock(struct rt_mutex *lock,
+				     struct hrtimer_sleeper *to,
+				     struct rt_mutex_waiter *waiter)
 {
 	int ret;
 
@@ -1770,8 +1770,8 @@ int rt_mutex_wait_proxy_lock(struct rt_mutex *lock,
  *
  * Special API call for PI-futex support
  */
-bool rt_mutex_cleanup_proxy_lock(struct rt_mutex *lock,
-				 struct rt_mutex_waiter *waiter)
+bool __sched rt_mutex_cleanup_proxy_lock(struct rt_mutex *lock,
+					 struct rt_mutex_waiter *waiter)
 {
 	bool cleanup = false;
 
