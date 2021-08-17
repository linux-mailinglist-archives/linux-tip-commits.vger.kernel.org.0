Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4158D3EF3AA
	for <lists+linux-tip-commits@lfdr.de>; Tue, 17 Aug 2021 22:48:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236002AbhHQURO (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Tue, 17 Aug 2021 16:17:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236027AbhHQUPs (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Tue, 17 Aug 2021 16:15:48 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22E3EC0611BD;
        Tue, 17 Aug 2021 13:14:32 -0700 (PDT)
Date:   Tue, 17 Aug 2021 20:14:29 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1629231270;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Dixu9XDKY9TemzKJcJEvY1/Sd4CGSJGsSaI3vfYMMuI=;
        b=l75jwQehMOtqaGP39DYqkWC5QG31TYvheEXhk79HmQvERxIbCP2aTZDrnKTIBOz/DoWUZf
        ztMsOedvr8MfQM4MujKk6UVY0cMFiJ2kDmgYtKXkbi2Qlf4q9UkjimzHly4XULOduHlHcM
        0sPP3pr958AL6aaGO99V6vk6oEKU5srHTuQ2HmAng2KRhrRJdctGf1H2z426qhKM+Qs4au
        iji3CKTC55blKaN8fAkWURK/JVNzNvr4+woK80t1mvNg8CvEjSiuJ3SHNu8JLnIU661kMj
        pK0x0aFgoF1VqgQhY/C1ebtfC8eV6NpAVKsF3eVmzsR34VoRmMLRDxjVbG9l/g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1629231270;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Dixu9XDKY9TemzKJcJEvY1/Sd4CGSJGsSaI3vfYMMuI=;
        b=OLGFgEokd6fyowsjRCBl4/5eETN5FaDXBufruH6Ci9XwVlZTQxFZwQgC9czU+9yxiMLxAX
        Cq43ehctFyvUoiDQ==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] locking/rtmutex: Split out the inner parts of
 'struct rtmutex'
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210815211302.784739994@linutronix.de>
References: <20210815211302.784739994@linutronix.de>
MIME-Version: 1.0
Message-ID: <162923127000.25758.6448180918578129037.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     830e6acc8a1cafe153a0d88f9b2455965b396131
Gitweb:        https://git.kernel.org/tip/830e6acc8a1cafe153a0d88f9b2455965b396131
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Sun, 15 Aug 2021 23:27:58 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 17 Aug 2021 17:04:01 +02:00

locking/rtmutex: Split out the inner parts of 'struct rtmutex'

RT builds substitutions for rwsem, mutex, spinlock and rwlock around
rtmutexes. Split the inner working out so each lock substitution can use
them with the appropriate lockdep annotations. This avoids having an extra
unused lockdep map in the wrapped rtmutex.

No functional change.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/20210815211302.784739994@linutronix.de
---
 include/linux/rtmutex.h         | 23 ++++++++----
 kernel/futex.c                  |  4 +-
 kernel/locking/rtmutex.c        | 64 ++++++++++++++++----------------
 kernel/locking/rtmutex_api.c    | 41 +++++++++++----------
 kernel/locking/rtmutex_common.h | 38 +++++++++----------
 kernel/rcu/tree_plugin.h        |  6 +--
 6 files changed, 97 insertions(+), 79 deletions(-)

diff --git a/include/linux/rtmutex.h b/include/linux/rtmutex.h
index cb0f441..8527402 100644
--- a/include/linux/rtmutex.h
+++ b/include/linux/rtmutex.h
@@ -19,6 +19,21 @@
 
 extern int max_lock_depth; /* for sysctl */
 
+struct rt_mutex_base {
+	raw_spinlock_t		wait_lock;
+	struct rb_root_cached   waiters;
+	struct task_struct	*owner;
+};
+
+#define __RT_MUTEX_BASE_INITIALIZER(rtbasename)				\
+{									\
+	.wait_lock = __RAW_SPIN_LOCK_UNLOCKED(rtbasename.wait_lock),	\
+	.waiters = RB_ROOT_CACHED,					\
+	.owner = NULL							\
+}
+
+extern void rt_mutex_base_init(struct rt_mutex_base *rtb);
+
 /**
  * The rt_mutex structure
  *
@@ -28,9 +43,7 @@ extern int max_lock_depth; /* for sysctl */
  * @owner:	the mutex owner
  */
 struct rt_mutex {
-	raw_spinlock_t		wait_lock;
-	struct rb_root_cached   waiters;
-	struct task_struct	*owner;
+	struct rt_mutex_base	rtmutex;
 #ifdef CONFIG_DEBUG_LOCK_ALLOC
 	struct lockdep_map	dep_map;
 #endif
@@ -63,9 +76,7 @@ do { \
 
 #define __RT_MUTEX_INITIALIZER(mutexname)				\
 {									\
-	.wait_lock = __RAW_SPIN_LOCK_UNLOCKED(mutexname.wait_lock),	\
-	.waiters = RB_ROOT_CACHED,					\
-	.owner = NULL,							\
+	.rtmutex = __RT_MUTEX_BASE_INITIALIZER(mutexname.rtmutex),	\
 	__DEP_MAP_RT_MUTEX_INITIALIZER(mutexname)			\
 }
 
diff --git a/kernel/futex.c b/kernel/futex.c
index 2ecb075..6eab247 100644
--- a/kernel/futex.c
+++ b/kernel/futex.c
@@ -179,7 +179,7 @@ struct futex_pi_state {
 	/*
 	 * The PI object:
 	 */
-	struct rt_mutex pi_mutex;
+	struct rt_mutex_base pi_mutex;
 
 	struct task_struct *owner;
 	refcount_t refcount;
@@ -3254,7 +3254,7 @@ static int futex_wait_requeue_pi(u32 __user *uaddr, unsigned int flags,
 			ret = ret < 0 ? ret : 0;
 		}
 	} else {
-		struct rt_mutex *pi_mutex;
+		struct rt_mutex_base *pi_mutex;
 
 		/*
 		 * We have been woken up by futex_unlock_pi(), a timeout, or a
diff --git a/kernel/locking/rtmutex.c b/kernel/locking/rtmutex.c
index cd0e1a4..b31f6cb 100644
--- a/kernel/locking/rtmutex.c
+++ b/kernel/locking/rtmutex.c
@@ -48,7 +48,7 @@
  */
 
 static __always_inline void
-rt_mutex_set_owner(struct rt_mutex *lock, struct task_struct *owner)
+rt_mutex_set_owner(struct rt_mutex_base *lock, struct task_struct *owner)
 {
 	unsigned long val = (unsigned long)owner;
 
@@ -58,13 +58,13 @@ rt_mutex_set_owner(struct rt_mutex *lock, struct task_struct *owner)
 	WRITE_ONCE(lock->owner, (struct task_struct *)val);
 }
 
-static __always_inline void clear_rt_mutex_waiters(struct rt_mutex *lock)
+static __always_inline void clear_rt_mutex_waiters(struct rt_mutex_base *lock)
 {
 	lock->owner = (struct task_struct *)
 			((unsigned long)lock->owner & ~RT_MUTEX_HAS_WAITERS);
 }
 
-static __always_inline void fixup_rt_mutex_waiters(struct rt_mutex *lock)
+static __always_inline void fixup_rt_mutex_waiters(struct rt_mutex_base *lock)
 {
 	unsigned long owner, *p = (unsigned long *) &lock->owner;
 
@@ -139,14 +139,14 @@ static __always_inline void fixup_rt_mutex_waiters(struct rt_mutex *lock)
  * set up.
  */
 #ifndef CONFIG_DEBUG_RT_MUTEXES
-static __always_inline bool rt_mutex_cmpxchg_acquire(struct rt_mutex *lock,
+static __always_inline bool rt_mutex_cmpxchg_acquire(struct rt_mutex_base *lock,
 						     struct task_struct *old,
 						     struct task_struct *new)
 {
 	return try_cmpxchg_acquire(&lock->owner, &old, new);
 }
 
-static __always_inline bool rt_mutex_cmpxchg_release(struct rt_mutex *lock,
+static __always_inline bool rt_mutex_cmpxchg_release(struct rt_mutex_base *lock,
 						     struct task_struct *old,
 						     struct task_struct *new)
 {
@@ -158,7 +158,7 @@ static __always_inline bool rt_mutex_cmpxchg_release(struct rt_mutex *lock,
  * all future threads that attempt to [Rmw] the lock to the slowpath. As such
  * relaxed semantics suffice.
  */
-static __always_inline void mark_rt_mutex_waiters(struct rt_mutex *lock)
+static __always_inline void mark_rt_mutex_waiters(struct rt_mutex_base *lock)
 {
 	unsigned long owner, *p = (unsigned long *) &lock->owner;
 
@@ -174,7 +174,7 @@ static __always_inline void mark_rt_mutex_waiters(struct rt_mutex *lock)
  * 2) Drop lock->wait_lock
  * 3) Try to unlock the lock with cmpxchg
  */
-static __always_inline bool unlock_rt_mutex_safe(struct rt_mutex *lock,
+static __always_inline bool unlock_rt_mutex_safe(struct rt_mutex_base *lock,
 						 unsigned long flags)
 	__releases(lock->wait_lock)
 {
@@ -210,7 +210,7 @@ static __always_inline bool unlock_rt_mutex_safe(struct rt_mutex *lock,
 }
 
 #else
-static __always_inline bool rt_mutex_cmpxchg_acquire(struct rt_mutex *lock,
+static __always_inline bool rt_mutex_cmpxchg_acquire(struct rt_mutex_base *lock,
 						     struct task_struct *old,
 						     struct task_struct *new)
 {
@@ -218,14 +218,14 @@ static __always_inline bool rt_mutex_cmpxchg_acquire(struct rt_mutex *lock,
 
 }
 
-static __always_inline bool rt_mutex_cmpxchg_release(struct rt_mutex *lock,
+static __always_inline bool rt_mutex_cmpxchg_release(struct rt_mutex_base *lock,
 						     struct task_struct *old,
 						     struct task_struct *new)
 {
 	return false;
 }
 
-static __always_inline void mark_rt_mutex_waiters(struct rt_mutex *lock)
+static __always_inline void mark_rt_mutex_waiters(struct rt_mutex_base *lock)
 {
 	lock->owner = (struct task_struct *)
 			((unsigned long)lock->owner | RT_MUTEX_HAS_WAITERS);
@@ -234,7 +234,7 @@ static __always_inline void mark_rt_mutex_waiters(struct rt_mutex *lock)
 /*
  * Simple slow path only version: lock->owner is protected by lock->wait_lock.
  */
-static __always_inline bool unlock_rt_mutex_safe(struct rt_mutex *lock,
+static __always_inline bool unlock_rt_mutex_safe(struct rt_mutex_base *lock,
 						 unsigned long flags)
 	__releases(lock->wait_lock)
 {
@@ -295,13 +295,13 @@ static __always_inline bool __waiter_less(struct rb_node *a, const struct rb_nod
 }
 
 static __always_inline void
-rt_mutex_enqueue(struct rt_mutex *lock, struct rt_mutex_waiter *waiter)
+rt_mutex_enqueue(struct rt_mutex_base *lock, struct rt_mutex_waiter *waiter)
 {
 	rb_add_cached(&waiter->tree_entry, &lock->waiters, __waiter_less);
 }
 
 static __always_inline void
-rt_mutex_dequeue(struct rt_mutex *lock, struct rt_mutex_waiter *waiter)
+rt_mutex_dequeue(struct rt_mutex_base *lock, struct rt_mutex_waiter *waiter)
 {
 	if (RB_EMPTY_NODE(&waiter->tree_entry))
 		return;
@@ -369,7 +369,7 @@ rt_mutex_cond_detect_deadlock(struct rt_mutex_waiter *waiter,
 	return chwalk == RT_MUTEX_FULL_CHAINWALK;
 }
 
-static __always_inline struct rt_mutex *task_blocked_on_lock(struct task_struct *p)
+static __always_inline struct rt_mutex_base *task_blocked_on_lock(struct task_struct *p)
 {
 	return p->pi_blocked_on ? p->pi_blocked_on->lock : NULL;
 }
@@ -439,15 +439,15 @@ static __always_inline struct rt_mutex *task_blocked_on_lock(struct task_struct 
  */
 static int __sched rt_mutex_adjust_prio_chain(struct task_struct *task,
 					      enum rtmutex_chainwalk chwalk,
-					      struct rt_mutex *orig_lock,
-					      struct rt_mutex *next_lock,
+					      struct rt_mutex_base *orig_lock,
+					      struct rt_mutex_base *next_lock,
 					      struct rt_mutex_waiter *orig_waiter,
 					      struct task_struct *top_task)
 {
 	struct rt_mutex_waiter *waiter, *top_waiter = orig_waiter;
 	struct rt_mutex_waiter *prerequeue_top_waiter;
 	int ret = 0, depth = 0;
-	struct rt_mutex *lock;
+	struct rt_mutex_base *lock;
 	bool detect_deadlock;
 	bool requeue = true;
 
@@ -795,7 +795,7 @@ static int __sched rt_mutex_adjust_prio_chain(struct task_struct *task,
  *	    callsite called task_blocked_on_lock(), otherwise NULL
  */
 static int __sched
-try_to_take_rt_mutex(struct rt_mutex *lock, struct task_struct *task,
+try_to_take_rt_mutex(struct rt_mutex_base *lock, struct task_struct *task,
 		     struct rt_mutex_waiter *waiter)
 {
 	lockdep_assert_held(&lock->wait_lock);
@@ -913,14 +913,14 @@ takeit:
  *
  * This must be called with lock->wait_lock held and interrupts disabled
  */
-static int __sched task_blocks_on_rt_mutex(struct rt_mutex *lock,
+static int __sched task_blocks_on_rt_mutex(struct rt_mutex_base *lock,
 					   struct rt_mutex_waiter *waiter,
 					   struct task_struct *task,
 					   enum rtmutex_chainwalk chwalk)
 {
 	struct task_struct *owner = rt_mutex_owner(lock);
 	struct rt_mutex_waiter *top_waiter = waiter;
-	struct rt_mutex *next_lock;
+	struct rt_mutex_base *next_lock;
 	int chain_walk = 0, res;
 
 	lockdep_assert_held(&lock->wait_lock);
@@ -1003,7 +1003,7 @@ static int __sched task_blocks_on_rt_mutex(struct rt_mutex *lock,
  * Called with lock->wait_lock held and interrupts disabled.
  */
 static void __sched mark_wakeup_next_waiter(struct wake_q_head *wake_q,
-					    struct rt_mutex *lock)
+					    struct rt_mutex_base *lock)
 {
 	struct rt_mutex_waiter *waiter;
 
@@ -1052,12 +1052,12 @@ static void __sched mark_wakeup_next_waiter(struct wake_q_head *wake_q,
  * Must be called with lock->wait_lock held and interrupts disabled. I must
  * have just failed to try_to_take_rt_mutex().
  */
-static void __sched remove_waiter(struct rt_mutex *lock,
+static void __sched remove_waiter(struct rt_mutex_base *lock,
 				  struct rt_mutex_waiter *waiter)
 {
 	bool is_top_waiter = (waiter == rt_mutex_top_waiter(lock));
 	struct task_struct *owner = rt_mutex_owner(lock);
-	struct rt_mutex *next_lock;
+	struct rt_mutex_base *next_lock;
 
 	lockdep_assert_held(&lock->wait_lock);
 
@@ -1115,7 +1115,8 @@ static void __sched remove_waiter(struct rt_mutex *lock,
  *
  * Must be called with lock->wait_lock held and interrupts disabled
  */
-static int __sched __rt_mutex_slowlock(struct rt_mutex *lock, unsigned int state,
+static int __sched __rt_mutex_slowlock(struct rt_mutex_base *lock,
+				       unsigned int state,
 				       struct hrtimer_sleeper *timeout,
 				       struct rt_mutex_waiter *waiter)
 {
@@ -1170,7 +1171,8 @@ static void __sched rt_mutex_handle_deadlock(int res, int detect_deadlock,
 /*
  * Slow path lock function:
  */
-static int __sched rt_mutex_slowlock(struct rt_mutex *lock, unsigned int state,
+static int __sched rt_mutex_slowlock(struct rt_mutex_base *lock,
+				     unsigned int state,
 				     struct hrtimer_sleeper *timeout,
 				     enum rtmutex_chainwalk chwalk)
 {
@@ -1231,7 +1233,7 @@ static int __sched rt_mutex_slowlock(struct rt_mutex *lock, unsigned int state,
 	return ret;
 }
 
-static __always_inline int __rt_mutex_lock(struct rt_mutex *lock,
+static __always_inline int __rt_mutex_lock(struct rt_mutex_base *lock,
 					   unsigned int state)
 {
 	if (likely(rt_mutex_cmpxchg_acquire(lock, NULL, current)))
@@ -1240,7 +1242,7 @@ static __always_inline int __rt_mutex_lock(struct rt_mutex *lock,
 	return rt_mutex_slowlock(lock, state, NULL, RT_MUTEX_MIN_CHAINWALK);
 }
 
-static int __sched __rt_mutex_slowtrylock(struct rt_mutex *lock)
+static int __sched __rt_mutex_slowtrylock(struct rt_mutex_base *lock)
 {
 	int ret = try_to_take_rt_mutex(lock, current, NULL);
 
@@ -1256,7 +1258,7 @@ static int __sched __rt_mutex_slowtrylock(struct rt_mutex *lock)
 /*
  * Slow path try-lock function:
  */
-static int __sched rt_mutex_slowtrylock(struct rt_mutex *lock)
+static int __sched rt_mutex_slowtrylock(struct rt_mutex_base *lock)
 {
 	unsigned long flags;
 	int ret;
@@ -1282,7 +1284,7 @@ static int __sched rt_mutex_slowtrylock(struct rt_mutex *lock)
 	return ret;
 }
 
-static __always_inline int __rt_mutex_trylock(struct rt_mutex *lock)
+static __always_inline int __rt_mutex_trylock(struct rt_mutex_base *lock)
 {
 	if (likely(rt_mutex_cmpxchg_acquire(lock, NULL, current)))
 		return 1;
@@ -1293,7 +1295,7 @@ static __always_inline int __rt_mutex_trylock(struct rt_mutex *lock)
 /*
  * Slow path to release a rt-mutex.
  */
-static void __sched rt_mutex_slowunlock(struct rt_mutex *lock)
+static void __sched rt_mutex_slowunlock(struct rt_mutex_base *lock)
 {
 	DEFINE_WAKE_Q(wake_q);
 	unsigned long flags;
@@ -1354,7 +1356,7 @@ static void __sched rt_mutex_slowunlock(struct rt_mutex *lock)
 	rt_mutex_postunlock(&wake_q);
 }
 
-static __always_inline void __rt_mutex_unlock(struct rt_mutex *lock)
+static __always_inline void __rt_mutex_unlock(struct rt_mutex_base *lock)
 {
 	if (likely(rt_mutex_cmpxchg_release(lock, current, NULL)))
 		return;
diff --git a/kernel/locking/rtmutex_api.c b/kernel/locking/rtmutex_api.c
index fc1322f..38de4b1 100644
--- a/kernel/locking/rtmutex_api.c
+++ b/kernel/locking/rtmutex_api.c
@@ -26,12 +26,18 @@ static __always_inline int __rt_mutex_lock_common(struct rt_mutex *lock,
 
 	might_sleep();
 	mutex_acquire(&lock->dep_map, subclass, 0, _RET_IP_);
-	ret = __rt_mutex_lock(lock, state);
+	ret = __rt_mutex_lock(&lock->rtmutex, state);
 	if (ret)
 		mutex_release(&lock->dep_map, _RET_IP_);
 	return ret;
 }
 
+void rt_mutex_base_init(struct rt_mutex_base *rtb)
+{
+	__rt_mutex_base_init(rtb);
+}
+EXPORT_SYMBOL(rt_mutex_base_init);
+
 #ifdef CONFIG_DEBUG_LOCK_ALLOC
 /**
  * rt_mutex_lock_nested - lock a rt_mutex
@@ -93,7 +99,7 @@ int __sched rt_mutex_trylock(struct rt_mutex *lock)
 	if (IS_ENABLED(CONFIG_DEBUG_RT_MUTEXES) && WARN_ON_ONCE(!in_task()))
 		return 0;
 
-	ret = __rt_mutex_trylock(lock);
+	ret = __rt_mutex_trylock(&lock->rtmutex);
 	if (ret)
 		mutex_acquire(&lock->dep_map, 0, 1, _RET_IP_);
 
@@ -109,19 +115,19 @@ EXPORT_SYMBOL_GPL(rt_mutex_trylock);
 void __sched rt_mutex_unlock(struct rt_mutex *lock)
 {
 	mutex_release(&lock->dep_map, _RET_IP_);
-	__rt_mutex_unlock(lock);
+	__rt_mutex_unlock(&lock->rtmutex);
 }
 EXPORT_SYMBOL_GPL(rt_mutex_unlock);
 
 /*
  * Futex variants, must not use fastpath.
  */
-int __sched rt_mutex_futex_trylock(struct rt_mutex *lock)
+int __sched rt_mutex_futex_trylock(struct rt_mutex_base *lock)
 {
 	return rt_mutex_slowtrylock(lock);
 }
 
-int __sched __rt_mutex_futex_trylock(struct rt_mutex *lock)
+int __sched __rt_mutex_futex_trylock(struct rt_mutex_base *lock)
 {
 	return __rt_mutex_slowtrylock(lock);
 }
@@ -133,7 +139,7 @@ int __sched __rt_mutex_futex_trylock(struct rt_mutex *lock)
  * @lock:	The rt_mutex to be unlocked
  * @wake_q:	The wake queue head from which to get the next lock waiter
  */
-bool __sched __rt_mutex_futex_unlock(struct rt_mutex *lock,
+bool __sched __rt_mutex_futex_unlock(struct rt_mutex_base *lock,
 				     struct wake_q_head *wake_q)
 {
 	lockdep_assert_held(&lock->wait_lock);
@@ -156,7 +162,7 @@ bool __sched __rt_mutex_futex_unlock(struct rt_mutex *lock,
 	return true; /* call postunlock() */
 }
 
-void __sched rt_mutex_futex_unlock(struct rt_mutex *lock)
+void __sched rt_mutex_futex_unlock(struct rt_mutex_base *lock)
 {
 	DEFINE_WAKE_Q(wake_q);
 	unsigned long flags;
@@ -182,12 +188,11 @@ void __sched rt_mutex_futex_unlock(struct rt_mutex *lock)
  * Initializing of a locked rt_mutex is not allowed
  */
 void __sched __rt_mutex_init(struct rt_mutex *lock, const char *name,
-		     struct lock_class_key *key)
+			     struct lock_class_key *key)
 {
 	debug_check_no_locks_freed((void *)lock, sizeof(*lock));
+	__rt_mutex_base_init(&lock->rtmutex);
 	lockdep_init_map_wait(&lock->dep_map, name, key, 0, LD_WAIT_SLEEP);
-
-	__rt_mutex_basic_init(lock);
 }
 EXPORT_SYMBOL_GPL(__rt_mutex_init);
 
@@ -205,10 +210,10 @@ EXPORT_SYMBOL_GPL(__rt_mutex_init);
  * possible at this point because the pi_state which contains the rtmutex
  * is not yet visible to other tasks.
  */
-void __sched rt_mutex_init_proxy_locked(struct rt_mutex *lock,
+void __sched rt_mutex_init_proxy_locked(struct rt_mutex_base *lock,
 					struct task_struct *proxy_owner)
 {
-	__rt_mutex_basic_init(lock);
+	__rt_mutex_base_init(lock);
 	rt_mutex_set_owner(lock, proxy_owner);
 }
 
@@ -224,7 +229,7 @@ void __sched rt_mutex_init_proxy_locked(struct rt_mutex *lock,
  * possible because it belongs to the pi_state which is about to be freed
  * and it is not longer visible to other tasks.
  */
-void __sched rt_mutex_proxy_unlock(struct rt_mutex *lock)
+void __sched rt_mutex_proxy_unlock(struct rt_mutex_base *lock)
 {
 	debug_rt_mutex_proxy_unlock(lock);
 	rt_mutex_set_owner(lock, NULL);
@@ -249,7 +254,7 @@ void __sched rt_mutex_proxy_unlock(struct rt_mutex *lock)
  *
  * Special API call for PI-futex support.
  */
-int __sched __rt_mutex_start_proxy_lock(struct rt_mutex *lock,
+int __sched __rt_mutex_start_proxy_lock(struct rt_mutex_base *lock,
 					struct rt_mutex_waiter *waiter,
 					struct task_struct *task)
 {
@@ -296,7 +301,7 @@ int __sched __rt_mutex_start_proxy_lock(struct rt_mutex *lock,
  *
  * Special API call for PI-futex support.
  */
-int __sched rt_mutex_start_proxy_lock(struct rt_mutex *lock,
+int __sched rt_mutex_start_proxy_lock(struct rt_mutex_base *lock,
 				      struct rt_mutex_waiter *waiter,
 				      struct task_struct *task)
 {
@@ -328,7 +333,7 @@ int __sched rt_mutex_start_proxy_lock(struct rt_mutex *lock,
  *
  * Special API call for PI-futex support
  */
-int __sched rt_mutex_wait_proxy_lock(struct rt_mutex *lock,
+int __sched rt_mutex_wait_proxy_lock(struct rt_mutex_base *lock,
 				     struct hrtimer_sleeper *to,
 				     struct rt_mutex_waiter *waiter)
 {
@@ -368,7 +373,7 @@ int __sched rt_mutex_wait_proxy_lock(struct rt_mutex *lock,
  *
  * Special API call for PI-futex support
  */
-bool __sched rt_mutex_cleanup_proxy_lock(struct rt_mutex *lock,
+bool __sched rt_mutex_cleanup_proxy_lock(struct rt_mutex_base *lock,
 					 struct rt_mutex_waiter *waiter)
 {
 	bool cleanup = false;
@@ -413,7 +418,7 @@ bool __sched rt_mutex_cleanup_proxy_lock(struct rt_mutex *lock,
 void __sched rt_mutex_adjust_pi(struct task_struct *task)
 {
 	struct rt_mutex_waiter *waiter;
-	struct rt_mutex *next_lock;
+	struct rt_mutex_base *next_lock;
 	unsigned long flags;
 
 	raw_spin_lock_irqsave(&task->pi_lock, flags);
diff --git a/kernel/locking/rtmutex_common.h b/kernel/locking/rtmutex_common.h
index 0f314a2..548285a 100644
--- a/kernel/locking/rtmutex_common.h
+++ b/kernel/locking/rtmutex_common.h
@@ -32,7 +32,7 @@ struct rt_mutex_waiter {
 	struct rb_node		tree_entry;
 	struct rb_node		pi_tree_entry;
 	struct task_struct	*task;
-	struct rt_mutex		*lock;
+	struct rt_mutex_base	*lock;
 	int			prio;
 	u64			deadline;
 };
@@ -40,26 +40,26 @@ struct rt_mutex_waiter {
 /*
  * PI-futex support (proxy locking functions, etc.):
  */
-extern void rt_mutex_init_proxy_locked(struct rt_mutex *lock,
+extern void rt_mutex_init_proxy_locked(struct rt_mutex_base *lock,
 				       struct task_struct *proxy_owner);
-extern void rt_mutex_proxy_unlock(struct rt_mutex *lock);
-extern int __rt_mutex_start_proxy_lock(struct rt_mutex *lock,
+extern void rt_mutex_proxy_unlock(struct rt_mutex_base *lock);
+extern int __rt_mutex_start_proxy_lock(struct rt_mutex_base *lock,
 				     struct rt_mutex_waiter *waiter,
 				     struct task_struct *task);
-extern int rt_mutex_start_proxy_lock(struct rt_mutex *lock,
+extern int rt_mutex_start_proxy_lock(struct rt_mutex_base *lock,
 				     struct rt_mutex_waiter *waiter,
 				     struct task_struct *task);
-extern int rt_mutex_wait_proxy_lock(struct rt_mutex *lock,
+extern int rt_mutex_wait_proxy_lock(struct rt_mutex_base *lock,
 			       struct hrtimer_sleeper *to,
 			       struct rt_mutex_waiter *waiter);
-extern bool rt_mutex_cleanup_proxy_lock(struct rt_mutex *lock,
+extern bool rt_mutex_cleanup_proxy_lock(struct rt_mutex_base *lock,
 				 struct rt_mutex_waiter *waiter);
 
-extern int rt_mutex_futex_trylock(struct rt_mutex *l);
-extern int __rt_mutex_futex_trylock(struct rt_mutex *l);
+extern int rt_mutex_futex_trylock(struct rt_mutex_base *l);
+extern int __rt_mutex_futex_trylock(struct rt_mutex_base *l);
 
-extern void rt_mutex_futex_unlock(struct rt_mutex *lock);
-extern bool __rt_mutex_futex_unlock(struct rt_mutex *lock,
+extern void rt_mutex_futex_unlock(struct rt_mutex_base *lock);
+extern bool __rt_mutex_futex_unlock(struct rt_mutex_base *lock,
 				struct wake_q_head *wake_q);
 
 extern void rt_mutex_postunlock(struct wake_q_head *wake_q);
@@ -69,12 +69,12 @@ extern void rt_mutex_postunlock(struct wake_q_head *wake_q);
  * unconditionally.
  */
 #ifdef CONFIG_RT_MUTEXES
-static inline int rt_mutex_has_waiters(struct rt_mutex *lock)
+static inline int rt_mutex_has_waiters(struct rt_mutex_base *lock)
 {
 	return !RB_EMPTY_ROOT(&lock->waiters.rb_root);
 }
 
-static inline struct rt_mutex_waiter *rt_mutex_top_waiter(struct rt_mutex *lock)
+static inline struct rt_mutex_waiter *rt_mutex_top_waiter(struct rt_mutex_base *lock)
 {
 	struct rb_node *leftmost = rb_first_cached(&lock->waiters);
 	struct rt_mutex_waiter *w = NULL;
@@ -99,7 +99,7 @@ static inline struct rt_mutex_waiter *task_top_pi_waiter(struct task_struct *p)
 
 #define RT_MUTEX_HAS_WAITERS	1UL
 
-static inline struct task_struct *rt_mutex_owner(struct rt_mutex *lock)
+static inline struct task_struct *rt_mutex_owner(struct rt_mutex_base *lock)
 {
 	unsigned long owner = (unsigned long) READ_ONCE(lock->owner);
 
@@ -121,21 +121,21 @@ enum rtmutex_chainwalk {
 	RT_MUTEX_FULL_CHAINWALK,
 };
 
-static inline void __rt_mutex_basic_init(struct rt_mutex *lock)
+static inline void __rt_mutex_base_init(struct rt_mutex_base *lock)
 {
-	lock->owner = NULL;
 	raw_spin_lock_init(&lock->wait_lock);
 	lock->waiters = RB_ROOT_CACHED;
+	lock->owner = NULL;
 }
 
 /* Debug functions */
-static inline void debug_rt_mutex_unlock(struct rt_mutex *lock)
+static inline void debug_rt_mutex_unlock(struct rt_mutex_base *lock)
 {
 	if (IS_ENABLED(CONFIG_DEBUG_RT_MUTEXES))
 		DEBUG_LOCKS_WARN_ON(rt_mutex_owner(lock) != current);
 }
 
-static inline void debug_rt_mutex_proxy_unlock(struct rt_mutex *lock)
+static inline void debug_rt_mutex_proxy_unlock(struct rt_mutex_base *lock)
 {
 	if (IS_ENABLED(CONFIG_DEBUG_RT_MUTEXES))
 		DEBUG_LOCKS_WARN_ON(!rt_mutex_owner(lock));
@@ -163,7 +163,7 @@ static inline void rt_mutex_init_waiter(struct rt_mutex_waiter *waiter)
 
 #else /* CONFIG_RT_MUTEXES */
 /* Used in rcu/tree_plugin.h */
-static inline struct task_struct *rt_mutex_owner(struct rt_mutex *lock)
+static inline struct task_struct *rt_mutex_owner(struct rt_mutex_base *lock)
 {
 	return NULL;
 }
diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
index de1dc3b..0ff5e4f 100644
--- a/kernel/rcu/tree_plugin.h
+++ b/kernel/rcu/tree_plugin.h
@@ -559,7 +559,7 @@ rcu_preempt_deferred_qs_irqrestore(struct task_struct *t, unsigned long flags)
 			WRITE_ONCE(rnp->exp_tasks, np);
 		if (IS_ENABLED(CONFIG_RCU_BOOST)) {
 			/* Snapshot ->boost_mtx ownership w/rnp->lock held. */
-			drop_boost_mutex = rt_mutex_owner(&rnp->boost_mtx) == t;
+			drop_boost_mutex = rt_mutex_owner(&rnp->boost_mtx.rtmutex) == t;
 			if (&t->rcu_node_entry == rnp->boost_tasks)
 				WRITE_ONCE(rnp->boost_tasks, np);
 		}
@@ -586,7 +586,7 @@ rcu_preempt_deferred_qs_irqrestore(struct task_struct *t, unsigned long flags)
 
 		/* Unboost if we were boosted. */
 		if (IS_ENABLED(CONFIG_RCU_BOOST) && drop_boost_mutex)
-			rt_mutex_futex_unlock(&rnp->boost_mtx);
+			rt_mutex_futex_unlock(&rnp->boost_mtx.rtmutex);
 
 		/*
 		 * If this was the last task on the expedited lists,
@@ -1083,7 +1083,7 @@ static int rcu_boost(struct rcu_node *rnp)
 	 * section.
 	 */
 	t = container_of(tb, struct task_struct, rcu_node_entry);
-	rt_mutex_init_proxy_locked(&rnp->boost_mtx, t);
+	rt_mutex_init_proxy_locked(&rnp->boost_mtx.rtmutex, t);
 	raw_spin_unlock_irqrestore_rcu_node(rnp, flags);
 	/* Lock only for side effect: boosts task t's priority. */
 	rt_mutex_lock(&rnp->boost_mtx);
