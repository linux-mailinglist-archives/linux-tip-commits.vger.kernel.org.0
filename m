Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A42AB3EF3A8
	for <lists+linux-tip-commits@lfdr.de>; Tue, 17 Aug 2021 22:48:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236658AbhHQUQo (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Tue, 17 Aug 2021 16:16:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235983AbhHQUPq (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Tue, 17 Aug 2021 16:15:46 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F856C0611BC;
        Tue, 17 Aug 2021 13:14:31 -0700 (PDT)
Date:   Tue, 17 Aug 2021 20:14:29 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1629231270;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yxnE3jGPbmnkOiWC+uIcHgAm7OrLB/rfn8EM3KmigEk=;
        b=GHS8LIubGDz/jYw9cfUUfPiCvDpgzVCZynS6D7ZzJPn03Tl+Jvk0oYw9Ide96a33f2fHes
        JgNkXnbklReDLsmKewCgEB9anp2ts/Umxi4e1qgFo4gkKe1ph4eXf7OLmdsmgM5ANOxAq5
        cJ49qOB3JpGHBpgRjTt1PAabOfpP9uRowkl2T95TfQbGPe/cQWwU745fLmWeYVR0Wljnld
        49Mbi119bAwqaACIYQSRAxoX2et7o69hPd+QRo0upK2yeNRx7iYtrTwmTvjkYe178LhrJN
        YBBRLpc4vUFZQtg/EeLNurZjFaOVS+bQHTke4xUWII/sgClY8/tMG5iCeEV4Vw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1629231270;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yxnE3jGPbmnkOiWC+uIcHgAm7OrLB/rfn8EM3KmigEk=;
        b=qbBRCMLIiL+udsy/E4R5TUd3GWpY9d6lzz9CS95kSrbQslLiVJNTqNO2PbY/YN4FVDBPr0
        WRY2dAm51tjdY1Aw==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] locking/rtmutex: Provide rt_mutex_slowlock_locked()
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210815211302.841971086@linutronix.de>
References: <20210815211302.841971086@linutronix.de>
MIME-Version: 1.0
Message-ID: <162923126936.25758.45999842194126220.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     ebbdc41e90ffce8b6bb3cbba1801ede2dd07a89b
Gitweb:        https://git.kernel.org/tip/ebbdc41e90ffce8b6bb3cbba1801ede2dd07a89b
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Sun, 15 Aug 2021 23:28:00 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 17 Aug 2021 17:04:09 +02:00

locking/rtmutex: Provide rt_mutex_slowlock_locked()

Split the inner workings of rt_mutex_slowlock() out into a separate
function, which can be reused by the upcoming RT lock substitutions,
e.g. for rw_semaphores.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/20210815211302.841971086@linutronix.de
---
 kernel/locking/rtmutex.c     | 100 +++++++++++++++++++---------------
 kernel/locking/rtmutex_api.c |   2 +-
 2 files changed, 59 insertions(+), 43 deletions(-)

diff --git a/kernel/locking/rtmutex.c b/kernel/locking/rtmutex.c
index b31f6cb..3d0b29c 100644
--- a/kernel/locking/rtmutex.c
+++ b/kernel/locking/rtmutex.c
@@ -1106,7 +1106,7 @@ static void __sched remove_waiter(struct rt_mutex_base *lock,
 }
 
 /**
- * __rt_mutex_slowlock() - Perform the wait-wake-try-to-take loop
+ * rt_mutex_slowlock_block() - Perform the wait-wake-try-to-take loop
  * @lock:		 the rt_mutex to take
  * @state:		 the state the task should block in (TASK_INTERRUPTIBLE
  *			 or TASK_UNINTERRUPTIBLE)
@@ -1115,10 +1115,10 @@ static void __sched remove_waiter(struct rt_mutex_base *lock,
  *
  * Must be called with lock->wait_lock held and interrupts disabled
  */
-static int __sched __rt_mutex_slowlock(struct rt_mutex_base *lock,
-				       unsigned int state,
-				       struct hrtimer_sleeper *timeout,
-				       struct rt_mutex_waiter *waiter)
+static int __sched rt_mutex_slowlock_block(struct rt_mutex_base *lock,
+					   unsigned int state,
+					   struct hrtimer_sleeper *timeout,
+					   struct rt_mutex_waiter *waiter)
 {
 	int ret = 0;
 
@@ -1168,52 +1168,37 @@ static void __sched rt_mutex_handle_deadlock(int res, int detect_deadlock,
 	}
 }
 
-/*
- * Slow path lock function:
+/**
+ * __rt_mutex_slowlock - Locking slowpath invoked with lock::wait_lock held
+ * @lock:	The rtmutex to block lock
+ * @state:	The task state for sleeping
+ * @chwalk:	Indicator whether full or partial chainwalk is requested
+ * @waiter:	Initializer waiter for blocking
  */
-static int __sched rt_mutex_slowlock(struct rt_mutex_base *lock,
-				     unsigned int state,
-				     struct hrtimer_sleeper *timeout,
-				     enum rtmutex_chainwalk chwalk)
+static int __sched __rt_mutex_slowlock(struct rt_mutex_base *lock,
+				       unsigned int state,
+				       enum rtmutex_chainwalk chwalk,
+				       struct rt_mutex_waiter *waiter)
 {
-	struct rt_mutex_waiter waiter;
-	unsigned long flags;
-	int ret = 0;
-
-	rt_mutex_init_waiter(&waiter);
+	int ret;
 
-	/*
-	 * Technically we could use raw_spin_[un]lock_irq() here, but this can
-	 * be called in early boot if the cmpxchg() fast path is disabled
-	 * (debug, no architecture support). In this case we will acquire the
-	 * rtmutex with lock->wait_lock held. But we cannot unconditionally
-	 * enable interrupts in that early boot case. So we need to use the
-	 * irqsave/restore variants.
-	 */
-	raw_spin_lock_irqsave(&lock->wait_lock, flags);
+	lockdep_assert_held(&lock->wait_lock);
 
 	/* Try to acquire the lock again: */
-	if (try_to_take_rt_mutex(lock, current, NULL)) {
-		raw_spin_unlock_irqrestore(&lock->wait_lock, flags);
+	if (try_to_take_rt_mutex(lock, current, NULL))
 		return 0;
-	}
 
 	set_current_state(state);
 
-	/* Setup the timer, when timeout != NULL */
-	if (unlikely(timeout))
-		hrtimer_start_expires(&timeout->timer, HRTIMER_MODE_ABS);
-
-	ret = task_blocks_on_rt_mutex(lock, &waiter, current, chwalk);
+	ret = task_blocks_on_rt_mutex(lock, waiter, current, chwalk);
 
 	if (likely(!ret))
-		/* sleep on the mutex */
-		ret = __rt_mutex_slowlock(lock, state, timeout, &waiter);
+		ret = rt_mutex_slowlock_block(lock, state, NULL, waiter);
 
 	if (unlikely(ret)) {
 		__set_current_state(TASK_RUNNING);
-		remove_waiter(lock, &waiter);
-		rt_mutex_handle_deadlock(ret, chwalk, &waiter);
+		remove_waiter(lock, waiter);
+		rt_mutex_handle_deadlock(ret, chwalk, waiter);
 	}
 
 	/*
@@ -1221,14 +1206,45 @@ static int __sched rt_mutex_slowlock(struct rt_mutex_base *lock,
 	 * unconditionally. We might have to fix that up.
 	 */
 	fixup_rt_mutex_waiters(lock);
+	return ret;
+}
 
-	raw_spin_unlock_irqrestore(&lock->wait_lock, flags);
+static inline int __rt_mutex_slowlock_locked(struct rt_mutex_base *lock,
+					     unsigned int state)
+{
+	struct rt_mutex_waiter waiter;
+	int ret;
+
+	rt_mutex_init_waiter(&waiter);
 
-	/* Remove pending timer: */
-	if (unlikely(timeout))
-		hrtimer_cancel(&timeout->timer);
+	ret = __rt_mutex_slowlock(lock, state, RT_MUTEX_MIN_CHAINWALK, &waiter);
 
 	debug_rt_mutex_free_waiter(&waiter);
+	return ret;
+}
+
+/*
+ * rt_mutex_slowlock - Locking slowpath invoked when fast path fails
+ * @lock:	The rtmutex to block lock
+ * @state:	The task state for sleeping
+ */
+static int __sched rt_mutex_slowlock(struct rt_mutex_base *lock,
+				     unsigned int state)
+{
+	unsigned long flags;
+	int ret;
+
+	/*
+	 * Technically we could use raw_spin_[un]lock_irq() here, but this can
+	 * be called in early boot if the cmpxchg() fast path is disabled
+	 * (debug, no architecture support). In this case we will acquire the
+	 * rtmutex with lock->wait_lock held. But we cannot unconditionally
+	 * enable interrupts in that early boot case. So we need to use the
+	 * irqsave/restore variants.
+	 */
+	raw_spin_lock_irqsave(&lock->wait_lock, flags);
+	ret = __rt_mutex_slowlock_locked(lock, state);
+	raw_spin_unlock_irqrestore(&lock->wait_lock, flags);
 
 	return ret;
 }
@@ -1239,7 +1255,7 @@ static __always_inline int __rt_mutex_lock(struct rt_mutex_base *lock,
 	if (likely(rt_mutex_cmpxchg_acquire(lock, NULL, current)))
 		return 0;
 
-	return rt_mutex_slowlock(lock, state, NULL, RT_MUTEX_MIN_CHAINWALK);
+	return rt_mutex_slowlock(lock, state);
 }
 
 static int __sched __rt_mutex_slowtrylock(struct rt_mutex_base *lock)
diff --git a/kernel/locking/rtmutex_api.c b/kernel/locking/rtmutex_api.c
index 38de4b1..c5136f4 100644
--- a/kernel/locking/rtmutex_api.c
+++ b/kernel/locking/rtmutex_api.c
@@ -342,7 +342,7 @@ int __sched rt_mutex_wait_proxy_lock(struct rt_mutex_base *lock,
 	raw_spin_lock_irq(&lock->wait_lock);
 	/* sleep on the mutex */
 	set_current_state(TASK_INTERRUPTIBLE);
-	ret = __rt_mutex_slowlock(lock, TASK_INTERRUPTIBLE, to, waiter);
+	ret = rt_mutex_slowlock_block(lock, TASK_INTERRUPTIBLE, to, waiter);
 	/*
 	 * try_to_take_rt_mutex() sets the waiter bit unconditionally. We might
 	 * have to fix that up.
