Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C7C43EF342
	for <lists+linux-tip-commits@lfdr.de>; Tue, 17 Aug 2021 22:15:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234219AbhHQUOs (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Tue, 17 Aug 2021 16:14:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234570AbhHQUOn (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Tue, 17 Aug 2021 16:14:43 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85D39C06179A;
        Tue, 17 Aug 2021 13:14:09 -0700 (PDT)
Date:   Tue, 17 Aug 2021 20:14:07 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1629231248;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=O6F9R1K3OZQATw+wdi+9So3atGE8ILpQj7SvieDKsIQ=;
        b=BjwAB3KY/tBTaDzKifiyliM+XTrrnkliOXD8khfWLmIp+4aQ2zczrHS2NBr4bG8uL0eE/M
        e83J4iNiRSBbvKXh9IkRK58j9USpS3beb0yQtJlWFUqiFWLPvZQky0aTAyKyCZ1zR/bwKZ
        B65Yj+Kzas9ggpYBnaTcPOqlOgVwlfHPaUmKU9UUEEpON/Jh2b8Pq/Xc6nf/PGeR4G01HS
        h+c1FrI8zoDO20x87CAACd37n6HibggrB/ZYXdHx/Lpu6T5dcWdibbqfgDl2yDXQ0L64Pe
        ZglsRHCvkDa8ZLDZR7XK7AfyO88L4c+qyRcyQ0Ako9dTrX0bX8kQBbT4WGPtyg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1629231248;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=O6F9R1K3OZQATw+wdi+9So3atGE8ILpQj7SvieDKsIQ=;
        b=sAu9T9UryruCL2gCB5feUlTJ3lE+JYxb0mdpDf3oP8CzHkARfVlMl5CgBkoFlNPJ2YwGvg
        4cK3zePiO0wpcqDQ==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] locking/rtmutex: Extend the rtmutex core to
 support ww_mutex
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210815211304.966139174@linutronix.de>
References: <20210815211304.966139174@linutronix.de>
MIME-Version: 1.0
Message-ID: <162923124737.25758.12123045724192063646.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     add461325ec5bc39aa619a1bfcde7245e5f31ac7
Gitweb:        https://git.kernel.org/tip/add461325ec5bc39aa619a1bfcde7245e5f31ac7
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Sun, 15 Aug 2021 23:28:58 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 17 Aug 2021 19:05:23 +02:00

locking/rtmutex: Extend the rtmutex core to support ww_mutex

Add a ww acquire context pointer to the waiter and various functions and
add the ww_mutex related invocations to the proper spots in the locking
code, similar to the mutex based variant.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/20210815211304.966139174@linutronix.de
---
 kernel/locking/rtmutex.c        | 121 ++++++++++++++++++++++++++++---
 kernel/locking/rtmutex_api.c    |   4 +-
 kernel/locking/rtmutex_common.h |   2 +-
 kernel/locking/rwsem.c          |   2 +-
 4 files changed, 115 insertions(+), 14 deletions(-)

diff --git a/kernel/locking/rtmutex.c b/kernel/locking/rtmutex.c
index ac8fb2f..af7e3af 100644
--- a/kernel/locking/rtmutex.c
+++ b/kernel/locking/rtmutex.c
@@ -17,9 +17,44 @@
 #include <linux/sched/signal.h>
 #include <linux/sched/rt.h>
 #include <linux/sched/wake_q.h>
+#include <linux/ww_mutex.h>
 
 #include "rtmutex_common.h"
 
+#ifndef WW_RT
+# define build_ww_mutex()	(false)
+# define ww_container_of(rtm)	NULL
+
+static inline int __ww_mutex_add_waiter(struct rt_mutex_waiter *waiter,
+					struct rt_mutex *lock,
+					struct ww_acquire_ctx *ww_ctx)
+{
+	return 0;
+}
+
+static inline void __ww_mutex_check_waiters(struct rt_mutex *lock,
+					    struct ww_acquire_ctx *ww_ctx)
+{
+}
+
+static inline void ww_mutex_lock_acquired(struct ww_mutex *lock,
+					  struct ww_acquire_ctx *ww_ctx)
+{
+}
+
+static inline int __ww_mutex_check_kill(struct rt_mutex *lock,
+					struct rt_mutex_waiter *waiter,
+					struct ww_acquire_ctx *ww_ctx)
+{
+	return 0;
+}
+
+#else
+# define build_ww_mutex()	(true)
+# define ww_container_of(rtm)	container_of(rtm, struct ww_mutex, base)
+# include "ww_mutex.h"
+#endif
+
 /*
  * lock->owner state tracking:
  *
@@ -308,7 +343,28 @@ static __always_inline int rt_mutex_waiter_equal(struct rt_mutex_waiter *left,
 
 static __always_inline bool __waiter_less(struct rb_node *a, const struct rb_node *b)
 {
-	return rt_mutex_waiter_less(__node_2_waiter(a), __node_2_waiter(b));
+	struct rt_mutex_waiter *aw = __node_2_waiter(a);
+	struct rt_mutex_waiter *bw = __node_2_waiter(b);
+
+	if (rt_mutex_waiter_less(aw, bw))
+		return 1;
+
+	if (!build_ww_mutex())
+		return 0;
+
+	if (rt_mutex_waiter_less(bw, aw))
+		return 0;
+
+	/* NOTE: relies on waiter->ww_ctx being set before insertion */
+	if (aw->ww_ctx) {
+		if (!bw->ww_ctx)
+			return 1;
+
+		return (signed long)(aw->ww_ctx->stamp -
+				     bw->ww_ctx->stamp) < 0;
+	}
+
+	return 0;
 }
 
 static __always_inline void
@@ -961,6 +1017,7 @@ takeit:
 static int __sched task_blocks_on_rt_mutex(struct rt_mutex_base *lock,
 					   struct rt_mutex_waiter *waiter,
 					   struct task_struct *task,
+					   struct ww_acquire_ctx *ww_ctx,
 					   enum rtmutex_chainwalk chwalk)
 {
 	struct task_struct *owner = rt_mutex_owner(lock);
@@ -996,6 +1053,16 @@ static int __sched task_blocks_on_rt_mutex(struct rt_mutex_base *lock,
 
 	raw_spin_unlock(&task->pi_lock);
 
+	if (build_ww_mutex() && ww_ctx) {
+		struct rt_mutex *rtm;
+
+		/* Check whether the waiter should back out immediately */
+		rtm = container_of(lock, struct rt_mutex, rtmutex);
+		res = __ww_mutex_add_waiter(waiter, rtm, ww_ctx);
+		if (res)
+			return res;
+	}
+
 	if (!owner)
 		return 0;
 
@@ -1281,6 +1348,7 @@ static void __sched remove_waiter(struct rt_mutex_base *lock,
 /**
  * rt_mutex_slowlock_block() - Perform the wait-wake-try-to-take loop
  * @lock:		 the rt_mutex to take
+ * @ww_ctx:		 WW mutex context pointer
  * @state:		 the state the task should block in (TASK_INTERRUPTIBLE
  *			 or TASK_UNINTERRUPTIBLE)
  * @timeout:		 the pre-initialized and started timer, or NULL for none
@@ -1289,10 +1357,12 @@ static void __sched remove_waiter(struct rt_mutex_base *lock,
  * Must be called with lock->wait_lock held and interrupts disabled
  */
 static int __sched rt_mutex_slowlock_block(struct rt_mutex_base *lock,
+					   struct ww_acquire_ctx *ww_ctx,
 					   unsigned int state,
 					   struct hrtimer_sleeper *timeout,
 					   struct rt_mutex_waiter *waiter)
 {
+	struct rt_mutex *rtm = container_of(lock, struct rt_mutex, rtmutex);
 	int ret = 0;
 
 	for (;;) {
@@ -1309,6 +1379,12 @@ static int __sched rt_mutex_slowlock_block(struct rt_mutex_base *lock,
 			break;
 		}
 
+		if (build_ww_mutex() && ww_ctx) {
+			ret = __ww_mutex_check_kill(rtm, waiter, ww_ctx);
+			if (ret)
+				break;
+		}
+
 		raw_spin_unlock_irq(&lock->wait_lock);
 
 		schedule();
@@ -1331,6 +1407,9 @@ static void __sched rt_mutex_handle_deadlock(int res, int detect_deadlock,
 	if (res != -EDEADLOCK || detect_deadlock)
 		return;
 
+	if (build_ww_mutex() && w->ww_ctx)
+		return;
+
 	/*
 	 * Yell loudly and stop the task right here.
 	 */
@@ -1344,31 +1423,46 @@ static void __sched rt_mutex_handle_deadlock(int res, int detect_deadlock,
 /**
  * __rt_mutex_slowlock - Locking slowpath invoked with lock::wait_lock held
  * @lock:	The rtmutex to block lock
+ * @ww_ctx:	WW mutex context pointer
  * @state:	The task state for sleeping
  * @chwalk:	Indicator whether full or partial chainwalk is requested
  * @waiter:	Initializer waiter for blocking
  */
 static int __sched __rt_mutex_slowlock(struct rt_mutex_base *lock,
+				       struct ww_acquire_ctx *ww_ctx,
 				       unsigned int state,
 				       enum rtmutex_chainwalk chwalk,
 				       struct rt_mutex_waiter *waiter)
 {
+	struct rt_mutex *rtm = container_of(lock, struct rt_mutex, rtmutex);
+	struct ww_mutex *ww = ww_container_of(rtm);
 	int ret;
 
 	lockdep_assert_held(&lock->wait_lock);
 
 	/* Try to acquire the lock again: */
-	if (try_to_take_rt_mutex(lock, current, NULL))
+	if (try_to_take_rt_mutex(lock, current, NULL)) {
+		if (build_ww_mutex() && ww_ctx) {
+			__ww_mutex_check_waiters(rtm, ww_ctx);
+			ww_mutex_lock_acquired(ww, ww_ctx);
+		}
 		return 0;
+	}
 
 	set_current_state(state);
 
-	ret = task_blocks_on_rt_mutex(lock, waiter, current, chwalk);
-
+	ret = task_blocks_on_rt_mutex(lock, waiter, current, ww_ctx, chwalk);
 	if (likely(!ret))
-		ret = rt_mutex_slowlock_block(lock, state, NULL, waiter);
-
-	if (unlikely(ret)) {
+		ret = rt_mutex_slowlock_block(lock, ww_ctx, state, NULL, waiter);
+
+	if (likely(!ret)) {
+		/* acquired the lock */
+		if (build_ww_mutex() && ww_ctx) {
+			if (!ww_ctx->is_wait_die)
+				__ww_mutex_check_waiters(rtm, ww_ctx);
+			ww_mutex_lock_acquired(ww, ww_ctx);
+		}
+	} else {
 		__set_current_state(TASK_RUNNING);
 		remove_waiter(lock, waiter);
 		rt_mutex_handle_deadlock(ret, chwalk, waiter);
@@ -1383,14 +1477,17 @@ static int __sched __rt_mutex_slowlock(struct rt_mutex_base *lock,
 }
 
 static inline int __rt_mutex_slowlock_locked(struct rt_mutex_base *lock,
+					     struct ww_acquire_ctx *ww_ctx,
 					     unsigned int state)
 {
 	struct rt_mutex_waiter waiter;
 	int ret;
 
 	rt_mutex_init_waiter(&waiter);
+	waiter.ww_ctx = ww_ctx;
 
-	ret = __rt_mutex_slowlock(lock, state, RT_MUTEX_MIN_CHAINWALK, &waiter);
+	ret = __rt_mutex_slowlock(lock, ww_ctx, state, RT_MUTEX_MIN_CHAINWALK,
+				  &waiter);
 
 	debug_rt_mutex_free_waiter(&waiter);
 	return ret;
@@ -1399,9 +1496,11 @@ static inline int __rt_mutex_slowlock_locked(struct rt_mutex_base *lock,
 /*
  * rt_mutex_slowlock - Locking slowpath invoked when fast path fails
  * @lock:	The rtmutex to block lock
+ * @ww_ctx:	WW mutex context pointer
  * @state:	The task state for sleeping
  */
 static int __sched rt_mutex_slowlock(struct rt_mutex_base *lock,
+				     struct ww_acquire_ctx *ww_ctx,
 				     unsigned int state)
 {
 	unsigned long flags;
@@ -1416,7 +1515,7 @@ static int __sched rt_mutex_slowlock(struct rt_mutex_base *lock,
 	 * irqsave/restore variants.
 	 */
 	raw_spin_lock_irqsave(&lock->wait_lock, flags);
-	ret = __rt_mutex_slowlock_locked(lock, state);
+	ret = __rt_mutex_slowlock_locked(lock, ww_ctx, state);
 	raw_spin_unlock_irqrestore(&lock->wait_lock, flags);
 
 	return ret;
@@ -1428,7 +1527,7 @@ static __always_inline int __rt_mutex_lock(struct rt_mutex_base *lock,
 	if (likely(rt_mutex_cmpxchg_acquire(lock, NULL, current)))
 		return 0;
 
-	return rt_mutex_slowlock(lock, state);
+	return rt_mutex_slowlock(lock, NULL, state);
 }
 #endif /* RT_MUTEX_BUILD_MUTEX */
 
@@ -1455,7 +1554,7 @@ static void __sched rtlock_slowlock_locked(struct rt_mutex_base *lock)
 	/* Save current state and set state to TASK_RTLOCK_WAIT */
 	current_save_and_set_rtlock_wait_state();
 
-	task_blocks_on_rt_mutex(lock, &waiter, current, RT_MUTEX_MIN_CHAINWALK);
+	task_blocks_on_rt_mutex(lock, &waiter, current, NULL, RT_MUTEX_MIN_CHAINWALK);
 
 	for (;;) {
 		/* Try to acquire the lock again */
diff --git a/kernel/locking/rtmutex_api.c b/kernel/locking/rtmutex_api.c
index 7f3ac09..16126fc 100644
--- a/kernel/locking/rtmutex_api.c
+++ b/kernel/locking/rtmutex_api.c
@@ -267,7 +267,7 @@ int __sched __rt_mutex_start_proxy_lock(struct rt_mutex_base *lock,
 		return 1;
 
 	/* We enforce deadlock detection for futexes */
-	ret = task_blocks_on_rt_mutex(lock, waiter, task,
+	ret = task_blocks_on_rt_mutex(lock, waiter, task, NULL,
 				      RT_MUTEX_FULL_CHAINWALK);
 
 	if (ret && !rt_mutex_owner(lock)) {
@@ -343,7 +343,7 @@ int __sched rt_mutex_wait_proxy_lock(struct rt_mutex_base *lock,
 	raw_spin_lock_irq(&lock->wait_lock);
 	/* sleep on the mutex */
 	set_current_state(TASK_INTERRUPTIBLE);
-	ret = rt_mutex_slowlock_block(lock, TASK_INTERRUPTIBLE, to, waiter);
+	ret = rt_mutex_slowlock_block(lock, NULL, TASK_INTERRUPTIBLE, to, waiter);
 	/*
 	 * try_to_take_rt_mutex() sets the waiter bit unconditionally. We might
 	 * have to fix that up.
diff --git a/kernel/locking/rtmutex_common.h b/kernel/locking/rtmutex_common.h
index ccf0e36..61256de 100644
--- a/kernel/locking/rtmutex_common.h
+++ b/kernel/locking/rtmutex_common.h
@@ -28,6 +28,7 @@
  * @wake_state:		Wakeup state to use (TASK_NORMAL or TASK_RTLOCK_WAIT)
  * @prio:		Priority of the waiter
  * @deadline:		Deadline of the waiter if applicable
+ * @ww_ctx:		WW context pointer
  */
 struct rt_mutex_waiter {
 	struct rb_node		tree_entry;
@@ -37,6 +38,7 @@ struct rt_mutex_waiter {
 	unsigned int		wake_state;
 	int			prio;
 	u64			deadline;
+	struct ww_acquire_ctx	*ww_ctx;
 };
 
 /**
diff --git a/kernel/locking/rwsem.c b/kernel/locking/rwsem.c
index 2847833..9215b4d 100644
--- a/kernel/locking/rwsem.c
+++ b/kernel/locking/rwsem.c
@@ -1360,7 +1360,7 @@ static inline void __downgrade_write(struct rw_semaphore *sem)
 	__rt_mutex_lock(rtm, state)
 
 #define rwbase_rtmutex_slowlock_locked(rtm, state)	\
-	__rt_mutex_slowlock_locked(rtm, state)
+	__rt_mutex_slowlock_locked(rtm, NULL, state)
 
 #define rwbase_rtmutex_unlock(rtm)			\
 	__rt_mutex_unlock(rtm)
