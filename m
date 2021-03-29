Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A447134D4E4
	for <lists+linux-tip-commits@lfdr.de>; Mon, 29 Mar 2021 18:25:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230495AbhC2QYc (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Mon, 29 Mar 2021 12:24:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231327AbhC2QYL (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Mon, 29 Mar 2021 12:24:11 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2282C061574;
        Mon, 29 Mar 2021 09:24:10 -0700 (PDT)
Date:   Mon, 29 Mar 2021 16:24:08 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1617035049;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=F9v9E5wk5iTJYm0cbQ/dgLqga4NMtrqBQA5ZhrwL64g=;
        b=kQ6YkPkMSXx93QoQqQgVr7BUzGjsWWA3vx4E1Dwryv8+u185kAMy/R1/BQl5ho6tczxjdc
        CoNro4+46a9/1S69IsEdUacmDhtEOWsJuGf5vIRqvPKi8/zFwtT2pQz4y2Fj8zFpPCM4/x
        JLWFQ1RQKJxfWRP5EkP0LEUP7R0ToPcJPQZCTgu/LHfmLLHgs4O8fXRgIWLRmRxPyhwgCR
        gRrgwMKws9VAcwKN3j4/OURal8q50JMrqmZ3wXmYGse2H39Yj5tbhMA1YDv8lv9ejh7De+
        1FLKaaCpYpuz4j2T3G4IZ0mx89uP1sK1k2hgmXxxCA+2G8BI6LWj9FHYYVhguQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1617035049;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=F9v9E5wk5iTJYm0cbQ/dgLqga4NMtrqBQA5ZhrwL64g=;
        b=m8dSXAt5jDzCL6e6cVP6uVX6c2F0DMOolX495V2tB0CU/Ah56grnjRU3HnAh4xCSgwp9vY
        nBLkT4HPr4YiIsBw==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] locking/rtmutex: Consolidate the fast/slowpath invocation
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210326153944.247927548@linutronix.de>
References: <20210326153944.247927548@linutronix.de>
MIME-Version: 1.0
Message-ID: <161703504866.29796.13777373754764746233.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     70c80103aafdeae99126694bc1cd54de016bc258
Gitweb:        https://git.kernel.org/tip/70c80103aafdeae99126694bc1cd54de016bc258
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Fri, 26 Mar 2021 16:29:41 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Mon, 29 Mar 2021 15:57:04 +02:00

locking/rtmutex: Consolidate the fast/slowpath invocation

The indirection via a function pointer (which is at least optimized into a
tail call by the compiler) is making the code hard to read.

Clean it up and move the futex related trylock functions down to the futex
section.

Move the wake_q wakeup into rt_mutex_slowunlock(). No point in handing it
to the caller. The futex code uses a different function.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/r/20210326153944.247927548@linutronix.de
---
 kernel/locking/rtmutex.c | 144 +++++++++++++++-----------------------
 1 file changed, 59 insertions(+), 85 deletions(-)

diff --git a/kernel/locking/rtmutex.c b/kernel/locking/rtmutex.c
index 3612821..7d0c168 100644
--- a/kernel/locking/rtmutex.c
+++ b/kernel/locking/rtmutex.c
@@ -1299,13 +1299,24 @@ static int __sched rt_mutex_slowtrylock(struct rt_mutex *lock)
 }
 
 /*
+ * Performs the wakeup of the top-waiter and re-enables preemption.
+ */
+void __sched rt_mutex_postunlock(struct wake_q_head *wake_q)
+{
+	wake_up_q(wake_q);
+
+	/* Pairs with preempt_disable() in rt_mutex_slowunlock() */
+	preempt_enable();
+}
+
+/*
  * Slow path to release a rt-mutex.
  *
  * Return whether the current task needs to call rt_mutex_postunlock().
  */
-static bool __sched rt_mutex_slowunlock(struct rt_mutex *lock,
-					struct wake_q_head *wake_q)
+static void __sched rt_mutex_slowunlock(struct rt_mutex *lock)
 {
+	DEFINE_WAKE_Q(wake_q);
 	unsigned long flags;
 
 	/* irqsave required to support early boot calls */
@@ -1347,7 +1358,7 @@ static bool __sched rt_mutex_slowunlock(struct rt_mutex *lock,
 	while (!rt_mutex_has_waiters(lock)) {
 		/* Drops lock->wait_lock ! */
 		if (unlock_rt_mutex_safe(lock, flags) == true)
-			return false;
+			return;
 		/* Relock the rtmutex and try again */
 		raw_spin_lock_irqsave(&lock->wait_lock, flags);
 	}
@@ -1358,10 +1369,10 @@ static bool __sched rt_mutex_slowunlock(struct rt_mutex *lock,
 	 *
 	 * Queue the next waiter for wakeup once we release the wait_lock.
 	 */
-	mark_wakeup_next_waiter(wake_q, lock);
+	mark_wakeup_next_waiter(&wake_q, lock);
 	raw_spin_unlock_irqrestore(&lock->wait_lock, flags);
 
-	return true; /* call rt_mutex_postunlock() */
+	rt_mutex_postunlock(&wake_q);
 }
 
 /*
@@ -1370,60 +1381,21 @@ static bool __sched rt_mutex_slowunlock(struct rt_mutex *lock,
  * The atomic acquire/release ops are compiled away, when either the
  * architecture does not support cmpxchg or when debugging is enabled.
  */
-static __always_inline int
-rt_mutex_fastlock(struct rt_mutex *lock, int state,
-		  int (*slowfn)(struct rt_mutex *lock, int state,
-				struct hrtimer_sleeper *timeout,
-				enum rtmutex_chainwalk chwalk))
+static __always_inline int __rt_mutex_lock(struct rt_mutex *lock, long state,
+					   unsigned int subclass)
 {
-	if (likely(rt_mutex_cmpxchg_acquire(lock, NULL, current)))
-		return 0;
+	int ret;
 
-	return slowfn(lock, state, NULL, RT_MUTEX_MIN_CHAINWALK);
-}
+	might_sleep();
+	mutex_acquire(&lock->dep_map, subclass, 0, _RET_IP_);
 
-static __always_inline int
-rt_mutex_fasttrylock(struct rt_mutex *lock,
-		     int (*slowfn)(struct rt_mutex *lock))
-{
 	if (likely(rt_mutex_cmpxchg_acquire(lock, NULL, current)))
-		return 1;
-
-	return slowfn(lock);
-}
-
-/*
- * Performs the wakeup of the top-waiter and re-enables preemption.
- */
-void __sched rt_mutex_postunlock(struct wake_q_head *wake_q)
-{
-	wake_up_q(wake_q);
-
-	/* Pairs with preempt_disable() in rt_mutex_slowunlock() */
-	preempt_enable();
-}
-
-static __always_inline void
-rt_mutex_fastunlock(struct rt_mutex *lock,
-		    bool (*slowfn)(struct rt_mutex *lock,
-				   struct wake_q_head *wqh))
-{
-	DEFINE_WAKE_Q(wake_q);
-
-	if (likely(rt_mutex_cmpxchg_release(lock, current, NULL)))
-		return;
-
-	if (slowfn(lock, &wake_q))
-		rt_mutex_postunlock(&wake_q);
-}
-
-static __always_inline void __rt_mutex_lock(struct rt_mutex *lock,
-					    unsigned int subclass)
-{
-	might_sleep();
+		return 0;
 
-	mutex_acquire(&lock->dep_map, subclass, 0, _RET_IP_);
-	rt_mutex_fastlock(lock, TASK_UNINTERRUPTIBLE, rt_mutex_slowlock);
+	ret = rt_mutex_slowlock(lock, state, NULL, RT_MUTEX_MIN_CHAINWALK);
+	if (ret)
+		mutex_release(&lock->dep_map, _RET_IP_);
+	return ret;
 }
 
 #ifdef CONFIG_DEBUG_LOCK_ALLOC
@@ -1435,7 +1407,7 @@ static __always_inline void __rt_mutex_lock(struct rt_mutex *lock,
  */
 void __sched rt_mutex_lock_nested(struct rt_mutex *lock, unsigned int subclass)
 {
-	__rt_mutex_lock(lock, subclass);
+	__rt_mutex_lock(lock, TASK_UNINTERRUPTIBLE, subclass);
 }
 EXPORT_SYMBOL_GPL(rt_mutex_lock_nested);
 
@@ -1448,7 +1420,7 @@ EXPORT_SYMBOL_GPL(rt_mutex_lock_nested);
  */
 void __sched rt_mutex_lock(struct rt_mutex *lock)
 {
-	__rt_mutex_lock(lock, 0);
+	__rt_mutex_lock(lock, TASK_UNINTERRUPTIBLE, 0);
 }
 EXPORT_SYMBOL_GPL(rt_mutex_lock);
 #endif
@@ -1464,42 +1436,21 @@ EXPORT_SYMBOL_GPL(rt_mutex_lock);
  */
 int __sched rt_mutex_lock_interruptible(struct rt_mutex *lock)
 {
-	int ret;
-
-	might_sleep();
-
-	mutex_acquire(&lock->dep_map, 0, 0, _RET_IP_);
-	ret = rt_mutex_fastlock(lock, TASK_INTERRUPTIBLE, rt_mutex_slowlock);
-	if (ret)
-		mutex_release(&lock->dep_map, _RET_IP_);
-
-	return ret;
+	return __rt_mutex_lock(lock, TASK_INTERRUPTIBLE, 0);
 }
 EXPORT_SYMBOL_GPL(rt_mutex_lock_interruptible);
 
-/*
- * Futex variant, must not use fastpath.
- */
-int __sched rt_mutex_futex_trylock(struct rt_mutex *lock)
-{
-	return rt_mutex_slowtrylock(lock);
-}
-
-int __sched __rt_mutex_futex_trylock(struct rt_mutex *lock)
-{
-	return __rt_mutex_slowtrylock(lock);
-}
-
 /**
  * rt_mutex_trylock - try to lock a rt_mutex
  *
  * @lock:	the rt_mutex to be locked
  *
- * This function can only be called in thread context. It's safe to
- * call it from atomic regions, but not from hard interrupt or soft
- * interrupt context.
+ * This function can only be called in thread context. It's safe to call it
+ * from atomic regions, but not from hard or soft interrupt context.
  *
- * Returns 1 on success and 0 on contention
+ * Returns:
+ *  1 on success
+ *  0 on contention
  */
 int __sched rt_mutex_trylock(struct rt_mutex *lock)
 {
@@ -1508,7 +1459,14 @@ int __sched rt_mutex_trylock(struct rt_mutex *lock)
 	if (WARN_ON_ONCE(in_irq() || in_nmi() || in_serving_softirq()))
 		return 0;
 
-	ret = rt_mutex_fasttrylock(lock, rt_mutex_slowtrylock);
+	/*
+	 * No lockdep annotation required because lockdep disables the fast
+	 * path.
+	 */
+	if (likely(rt_mutex_cmpxchg_acquire(lock, NULL, current)))
+		return 1;
+
+	ret = rt_mutex_slowtrylock(lock);
 	if (ret)
 		mutex_acquire(&lock->dep_map, 0, 1, _RET_IP_);
 
@@ -1524,10 +1482,26 @@ EXPORT_SYMBOL_GPL(rt_mutex_trylock);
 void __sched rt_mutex_unlock(struct rt_mutex *lock)
 {
 	mutex_release(&lock->dep_map, _RET_IP_);
-	rt_mutex_fastunlock(lock, rt_mutex_slowunlock);
+	if (likely(rt_mutex_cmpxchg_release(lock, current, NULL)))
+		return;
+
+	rt_mutex_slowunlock(lock);
 }
 EXPORT_SYMBOL_GPL(rt_mutex_unlock);
 
+/*
+ * Futex variants, must not use fastpath.
+ */
+int __sched rt_mutex_futex_trylock(struct rt_mutex *lock)
+{
+	return rt_mutex_slowtrylock(lock);
+}
+
+int __sched __rt_mutex_futex_trylock(struct rt_mutex *lock)
+{
+	return __rt_mutex_slowtrylock(lock);
+}
+
 /**
  * __rt_mutex_futex_unlock - Futex variant, that since futex variants
  * do not use the fast-path, can be simple and will not need to retry.
