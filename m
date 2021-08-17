Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7603B3EF37F
	for <lists+linux-tip-commits@lfdr.de>; Tue, 17 Aug 2021 22:15:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235380AbhHQUPz (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Tue, 17 Aug 2021 16:15:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235391AbhHQUPX (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Tue, 17 Aug 2021 16:15:23 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAC9DC0611C1;
        Tue, 17 Aug 2021 13:14:26 -0700 (PDT)
Date:   Tue, 17 Aug 2021 20:14:24 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1629231265;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=sMY+BmAkSJBa0uJSE+OzHEmrnjmzhlXnDIglilgLm7U=;
        b=n+wY5NfbXmr/PtxWCYYO8vlwSExXof2yzM7nq2GE8tO44Q05zUyUkP+4maSoBwoib2MExE
        XJmYHdyIKXWhzkwsSHd/tu1l1ilm25Tcl/SzJyIIhyVfBH542iaS+URhs9Gy/E+h5JvQZI
        Bu5WUbQGYbreWaQUuanNyGN07lGukb3tbwWNGB70c8kE6Ky4pFcs3wbfG6Z5d2bhUXYIQY
        LV5kUo0JCd5MKPXeSlllBvUHF9LaPtzyltwpQAx6GAMSr52bjj7eOmQOfhtAs8uJECBr/r
        DNnTXnsN7uiF7w9anuHG2zlprLg+4H2wzsdY4vbLl6dI7vn2/w3CVXRIsuxlRw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1629231265;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=sMY+BmAkSJBa0uJSE+OzHEmrnjmzhlXnDIglilgLm7U=;
        b=xU8CTNlpBmIeYpX6uuxc+D8y1pJ1EvwrEw0osyrBbPRkP3QIKlXdir+o6+KpkUkmpA3jAY
        E5u8yUTMGKUQm4Dg==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] locking/rtmutex: Guard regular sleeping locks
 specific functions
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210815211303.311535693@linutronix.de>
References: <20210815211303.311535693@linutronix.de>
MIME-Version: 1.0
Message-ID: <162923126469.25758.12209712450147338862.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     e17ba59b7e8e1f67e36d8fcc46daa13370efcf11
Gitweb:        https://git.kernel.org/tip/e17ba59b7e8e1f67e36d8fcc46daa13370efcf11
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Sun, 15 Aug 2021 23:28:12 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 17 Aug 2021 17:23:27 +02:00

locking/rtmutex: Guard regular sleeping locks specific functions

Guard the regular sleeping lock specific functionality, which is used for
rtmutex on non-RT enabled kernels and for mutex, rtmutex and semaphores on
RT enabled kernels so the code can be reused for the RT specific
implementation of spinlocks and rwlocks in a different compilation unit.

No functional change.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/20210815211303.311535693@linutronix.de
---
 kernel/locking/rtmutex.c     | 254 +++++++++++++++++-----------------
 kernel/locking/rtmutex_api.c |   1 +-
 kernel/locking/rwsem.c       |   1 +-
 3 files changed, 133 insertions(+), 123 deletions(-)

diff --git a/kernel/locking/rtmutex.c b/kernel/locking/rtmutex.c
index 8b0d38d..949781a 100644
--- a/kernel/locking/rtmutex.c
+++ b/kernel/locking/rtmutex.c
@@ -1075,10 +1075,139 @@ static void __sched mark_wakeup_next_waiter(struct rt_wake_q_head *wqh,
 	raw_spin_unlock(&current->pi_lock);
 }
 
+static int __sched __rt_mutex_slowtrylock(struct rt_mutex_base *lock)
+{
+	int ret = try_to_take_rt_mutex(lock, current, NULL);
+
+	/*
+	 * try_to_take_rt_mutex() sets the lock waiters bit
+	 * unconditionally. Clean this up.
+	 */
+	fixup_rt_mutex_waiters(lock);
+
+	return ret;
+}
+
+/*
+ * Slow path try-lock function:
+ */
+static int __sched rt_mutex_slowtrylock(struct rt_mutex_base *lock)
+{
+	unsigned long flags;
+	int ret;
+
+	/*
+	 * If the lock already has an owner we fail to get the lock.
+	 * This can be done without taking the @lock->wait_lock as
+	 * it is only being read, and this is a trylock anyway.
+	 */
+	if (rt_mutex_owner(lock))
+		return 0;
+
+	/*
+	 * The mutex has currently no owner. Lock the wait lock and try to
+	 * acquire the lock. We use irqsave here to support early boot calls.
+	 */
+	raw_spin_lock_irqsave(&lock->wait_lock, flags);
+
+	ret = __rt_mutex_slowtrylock(lock);
+
+	raw_spin_unlock_irqrestore(&lock->wait_lock, flags);
+
+	return ret;
+}
+
+static __always_inline int __rt_mutex_trylock(struct rt_mutex_base *lock)
+{
+	if (likely(rt_mutex_cmpxchg_acquire(lock, NULL, current)))
+		return 1;
+
+	return rt_mutex_slowtrylock(lock);
+}
+
+/*
+ * Slow path to release a rt-mutex.
+ */
+static void __sched rt_mutex_slowunlock(struct rt_mutex_base *lock)
+{
+	DEFINE_RT_WAKE_Q(wqh);
+	unsigned long flags;
+
+	/* irqsave required to support early boot calls */
+	raw_spin_lock_irqsave(&lock->wait_lock, flags);
+
+	debug_rt_mutex_unlock(lock);
+
+	/*
+	 * We must be careful here if the fast path is enabled. If we
+	 * have no waiters queued we cannot set owner to NULL here
+	 * because of:
+	 *
+	 * foo->lock->owner = NULL;
+	 *			rtmutex_lock(foo->lock);   <- fast path
+	 *			free = atomic_dec_and_test(foo->refcnt);
+	 *			rtmutex_unlock(foo->lock); <- fast path
+	 *			if (free)
+	 *				kfree(foo);
+	 * raw_spin_unlock(foo->lock->wait_lock);
+	 *
+	 * So for the fastpath enabled kernel:
+	 *
+	 * Nothing can set the waiters bit as long as we hold
+	 * lock->wait_lock. So we do the following sequence:
+	 *
+	 *	owner = rt_mutex_owner(lock);
+	 *	clear_rt_mutex_waiters(lock);
+	 *	raw_spin_unlock(&lock->wait_lock);
+	 *	if (cmpxchg(&lock->owner, owner, 0) == owner)
+	 *		return;
+	 *	goto retry;
+	 *
+	 * The fastpath disabled variant is simple as all access to
+	 * lock->owner is serialized by lock->wait_lock:
+	 *
+	 *	lock->owner = NULL;
+	 *	raw_spin_unlock(&lock->wait_lock);
+	 */
+	while (!rt_mutex_has_waiters(lock)) {
+		/* Drops lock->wait_lock ! */
+		if (unlock_rt_mutex_safe(lock, flags) == true)
+			return;
+		/* Relock the rtmutex and try again */
+		raw_spin_lock_irqsave(&lock->wait_lock, flags);
+	}
+
+	/*
+	 * The wakeup next waiter path does not suffer from the above
+	 * race. See the comments there.
+	 *
+	 * Queue the next waiter for wakeup once we release the wait_lock.
+	 */
+	mark_wakeup_next_waiter(&wqh, lock);
+	raw_spin_unlock_irqrestore(&lock->wait_lock, flags);
+
+	rt_mutex_wake_up_q(&wqh);
+}
+
+static __always_inline void __rt_mutex_unlock(struct rt_mutex_base *lock)
+{
+	if (likely(rt_mutex_cmpxchg_release(lock, current, NULL)))
+		return;
+
+	rt_mutex_slowunlock(lock);
+}
+
+#ifdef RT_MUTEX_BUILD_MUTEX
+/*
+ * Functions required for:
+ *	- rtmutex, futex on all kernels
+ *	- mutex and rwsem substitutions on RT kernels
+ */
+
 /*
  * Remove a waiter from a lock and give up
  *
- * Must be called with lock->wait_lock held and interrupts disabled. I must
+ * Must be called with lock->wait_lock held and interrupts disabled. It must
  * have just failed to try_to_take_rt_mutex().
  */
 static void __sched remove_waiter(struct rt_mutex_base *lock,
@@ -1286,125 +1415,4 @@ static __always_inline int __rt_mutex_lock(struct rt_mutex_base *lock,
 
 	return rt_mutex_slowlock(lock, state);
 }
-
-static int __sched __rt_mutex_slowtrylock(struct rt_mutex_base *lock)
-{
-	int ret = try_to_take_rt_mutex(lock, current, NULL);
-
-	/*
-	 * try_to_take_rt_mutex() sets the lock waiters bit
-	 * unconditionally. Clean this up.
-	 */
-	fixup_rt_mutex_waiters(lock);
-
-	return ret;
-}
-
-/*
- * Slow path try-lock function:
- */
-static int __sched rt_mutex_slowtrylock(struct rt_mutex_base *lock)
-{
-	unsigned long flags;
-	int ret;
-
-	/*
-	 * If the lock already has an owner we fail to get the lock.
-	 * This can be done without taking the @lock->wait_lock as
-	 * it is only being read, and this is a trylock anyway.
-	 */
-	if (rt_mutex_owner(lock))
-		return 0;
-
-	/*
-	 * The mutex has currently no owner. Lock the wait lock and try to
-	 * acquire the lock. We use irqsave here to support early boot calls.
-	 */
-	raw_spin_lock_irqsave(&lock->wait_lock, flags);
-
-	ret = __rt_mutex_slowtrylock(lock);
-
-	raw_spin_unlock_irqrestore(&lock->wait_lock, flags);
-
-	return ret;
-}
-
-static __always_inline int __rt_mutex_trylock(struct rt_mutex_base *lock)
-{
-	if (likely(rt_mutex_cmpxchg_acquire(lock, NULL, current)))
-		return 1;
-
-	return rt_mutex_slowtrylock(lock);
-}
-
-/*
- * Slow path to release a rt-mutex.
- */
-static void __sched rt_mutex_slowunlock(struct rt_mutex_base *lock)
-{
-	DEFINE_RT_WAKE_Q(wqh);
-	unsigned long flags;
-
-	/* irqsave required to support early boot calls */
-	raw_spin_lock_irqsave(&lock->wait_lock, flags);
-
-	debug_rt_mutex_unlock(lock);
-
-	/*
-	 * We must be careful here if the fast path is enabled. If we
-	 * have no waiters queued we cannot set owner to NULL here
-	 * because of:
-	 *
-	 * foo->lock->owner = NULL;
-	 *			rtmutex_lock(foo->lock);   <- fast path
-	 *			free = atomic_dec_and_test(foo->refcnt);
-	 *			rtmutex_unlock(foo->lock); <- fast path
-	 *			if (free)
-	 *				kfree(foo);
-	 * raw_spin_unlock(foo->lock->wait_lock);
-	 *
-	 * So for the fastpath enabled kernel:
-	 *
-	 * Nothing can set the waiters bit as long as we hold
-	 * lock->wait_lock. So we do the following sequence:
-	 *
-	 *	owner = rt_mutex_owner(lock);
-	 *	clear_rt_mutex_waiters(lock);
-	 *	raw_spin_unlock(&lock->wait_lock);
-	 *	if (cmpxchg(&lock->owner, owner, 0) == owner)
-	 *		return;
-	 *	goto retry;
-	 *
-	 * The fastpath disabled variant is simple as all access to
-	 * lock->owner is serialized by lock->wait_lock:
-	 *
-	 *	lock->owner = NULL;
-	 *	raw_spin_unlock(&lock->wait_lock);
-	 */
-	while (!rt_mutex_has_waiters(lock)) {
-		/* Drops lock->wait_lock ! */
-		if (unlock_rt_mutex_safe(lock, flags) == true)
-			return;
-		/* Relock the rtmutex and try again */
-		raw_spin_lock_irqsave(&lock->wait_lock, flags);
-	}
-
-	/*
-	 * The wakeup next waiter path does not suffer from the above
-	 * race. See the comments there.
-	 *
-	 * Queue the next waiter for wakeup once we release the wait_lock.
-	 */
-	mark_wakeup_next_waiter(&wqh, lock);
-	raw_spin_unlock_irqrestore(&lock->wait_lock, flags);
-
-	rt_mutex_wake_up_q(&wqh);
-}
-
-static __always_inline void __rt_mutex_unlock(struct rt_mutex_base *lock)
-{
-	if (likely(rt_mutex_cmpxchg_release(lock, current, NULL)))
-		return;
-
-	rt_mutex_slowunlock(lock);
-}
+#endif /* RT_MUTEX_BUILD_MUTEX */
diff --git a/kernel/locking/rtmutex_api.c b/kernel/locking/rtmutex_api.c
index 56403dc..7f3ac09 100644
--- a/kernel/locking/rtmutex_api.c
+++ b/kernel/locking/rtmutex_api.c
@@ -5,6 +5,7 @@
 #include <linux/spinlock.h>
 #include <linux/export.h>
 
+#define RT_MUTEX_BUILD_MUTEX
 #include "rtmutex.c"
 
 /*
diff --git a/kernel/locking/rwsem.c b/kernel/locking/rwsem.c
index c017f9f..2847833 100644
--- a/kernel/locking/rwsem.c
+++ b/kernel/locking/rwsem.c
@@ -1347,6 +1347,7 @@ static inline void __downgrade_write(struct rw_semaphore *sem)
 
 #else /* !CONFIG_PREEMPT_RT */
 
+#define RT_MUTEX_BUILD_MUTEX
 #include "rtmutex.c"
 
 #define rwbase_set_and_save_current_state(state)	\
