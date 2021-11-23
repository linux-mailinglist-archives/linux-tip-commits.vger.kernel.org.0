Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D909459EA5
	for <lists+linux-tip-commits@lfdr.de>; Tue, 23 Nov 2021 09:53:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235085AbhKWI4x (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Tue, 23 Nov 2021 03:56:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233970AbhKWI4v (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Tue, 23 Nov 2021 03:56:51 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91113C061746;
        Tue, 23 Nov 2021 00:53:43 -0800 (PST)
Date:   Tue, 23 Nov 2021 08:53:39 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1637657620;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2q9lxKYdYqkhBA6erZfRDBHmDp7Nh1WVxtHcJfMg2o0=;
        b=oDmDDBl64yFFHABDwEITd0N1F09T7dBHQ1rdKbczms8p5A245pV6iQWXiqmiLsGKtF9nrU
        VlrWIXxPL2d7k97lnmN0guCICTBkt8ywa6s195xXzetvBrDIkXvb3Nny8VIzs6qIrUCOJj
        d+cYbfaETnY+UraY44DkV+5l34qU6pbgx2g6zMcQmsdFARpDohLqkjF2OdgLjTVyMSGNEv
        vkN9nEsseTvjtidJNS3NExsk1xN/pK51RCZgQaahPuoxGVpB4bf4hXraUoDveDJ+E2Gz7x
        rxl/fY9TanBhtENCdi2cFdxdCPO/PQ4cNgoKa9CNerTgDqAbGBQ8c75XHaik5g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1637657620;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2q9lxKYdYqkhBA6erZfRDBHmDp7Nh1WVxtHcJfMg2o0=;
        b=hFPbY9ia3h4c0Jnm9KW9G3IqKaQf5HXQ9F7tMxGB1Qt2Tt3d6dfTG/NNaF1/lZBABhHl4z
        O9TPk7M3t9EmXxDQ==
From:   "tip-bot2 for Waiman Long" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/urgent] locking/rwsem: Make handoff bit handling more
 consistent
Cc:     Zhenhua Ma <mazhenhua@xiaomi.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Waiman Long <longman@redhat.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20211116012912.723980-1-longman@redhat.com>
References: <20211116012912.723980-1-longman@redhat.com>
MIME-Version: 1.0
Message-ID: <163765761984.11128.3614911867026534584.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the locking/urgent branch of tip:

Commit-ID:     d257cc8cb8d5355ffc43a96bab94db7b5a324803
Gitweb:        https://git.kernel.org/tip/d257cc8cb8d5355ffc43a96bab94db7b5a324803
Author:        Waiman Long <longman@redhat.com>
AuthorDate:    Mon, 15 Nov 2021 20:29:12 -05:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 23 Nov 2021 09:45:35 +01:00

locking/rwsem: Make handoff bit handling more consistent

There are some inconsistency in the way that the handoff bit is being
handled in readers and writers that lead to a race condition.

Firstly, when a queue head writer set the handoff bit, it will clear
it when the writer is being killed or interrupted on its way out
without acquiring the lock. That is not the case for a queue head
reader. The handoff bit will simply be inherited by the next waiter.

Secondly, in the out_nolock path of rwsem_down_read_slowpath(), both
the waiter and handoff bits are cleared if the wait queue becomes
empty.  For rwsem_down_write_slowpath(), however, the handoff bit is
not checked and cleared if the wait queue is empty. This can
potentially make the handoff bit set with empty wait queue.

Worse, the situation in rwsem_down_write_slowpath() relies on wstate,
a variable set outside of the critical section containing the ->count
manipulation, this leads to race condition where RWSEM_FLAG_HANDOFF
can be double subtracted, corrupting ->count.

To make the handoff bit handling more consistent and robust, extract
out handoff bit clearing code into the new rwsem_del_waiter() helper
function. Also, completely eradicate wstate; always evaluate
everything inside the same critical section.

The common function will only use atomic_long_andnot() to clear bits
when the wait queue is empty to avoid possible race condition.  If the
first waiter with handoff bit set is killed or interrupted to exit the
slowpath without acquiring the lock, the next waiter will inherit the
handoff bit.

While at it, simplify the trylock for loop in
rwsem_down_write_slowpath() to make it easier to read.

Fixes: 4f23dbc1e657 ("locking/rwsem: Implement lock handoff to prevent lock starvation")
Reported-by: Zhenhua Ma <mazhenhua@xiaomi.com>
Suggested-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Waiman Long <longman@redhat.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20211116012912.723980-1-longman@redhat.com
---
 kernel/locking/rwsem.c | 171 +++++++++++++++++++---------------------
 1 file changed, 85 insertions(+), 86 deletions(-)

diff --git a/kernel/locking/rwsem.c b/kernel/locking/rwsem.c
index c51387a..e039cf1 100644
--- a/kernel/locking/rwsem.c
+++ b/kernel/locking/rwsem.c
@@ -105,9 +105,9 @@
  * atomic_long_cmpxchg() will be used to obtain writer lock.
  *
  * There are three places where the lock handoff bit may be set or cleared.
- * 1) rwsem_mark_wake() for readers.
- * 2) rwsem_try_write_lock() for writers.
- * 3) Error path of rwsem_down_write_slowpath().
+ * 1) rwsem_mark_wake() for readers		-- set, clear
+ * 2) rwsem_try_write_lock() for writers	-- set, clear
+ * 3) rwsem_del_waiter()			-- clear
  *
  * For all the above cases, wait_lock will be held. A writer must also
  * be the first one in the wait_list to be eligible for setting the handoff
@@ -334,6 +334,9 @@ struct rwsem_waiter {
 	struct task_struct *task;
 	enum rwsem_waiter_type type;
 	unsigned long timeout;
+
+	/* Writer only, not initialized in reader */
+	bool handoff_set;
 };
 #define rwsem_first_waiter(sem) \
 	list_first_entry(&sem->wait_list, struct rwsem_waiter, list)
@@ -344,12 +347,6 @@ enum rwsem_wake_type {
 	RWSEM_WAKE_READ_OWNED	/* Waker thread holds the read lock */
 };
 
-enum writer_wait_state {
-	WRITER_NOT_FIRST,	/* Writer is not first in wait list */
-	WRITER_FIRST,		/* Writer is first in wait list     */
-	WRITER_HANDOFF		/* Writer is first & handoff needed */
-};
-
 /*
  * The typical HZ value is either 250 or 1000. So set the minimum waiting
  * time to at least 4ms or 1 jiffy (if it is higher than 4ms) in the wait
@@ -365,6 +362,31 @@ enum writer_wait_state {
  */
 #define MAX_READERS_WAKEUP	0x100
 
+static inline void
+rwsem_add_waiter(struct rw_semaphore *sem, struct rwsem_waiter *waiter)
+{
+	lockdep_assert_held(&sem->wait_lock);
+	list_add_tail(&waiter->list, &sem->wait_list);
+	/* caller will set RWSEM_FLAG_WAITERS */
+}
+
+/*
+ * Remove a waiter from the wait_list and clear flags.
+ *
+ * Both rwsem_mark_wake() and rwsem_try_write_lock() contain a full 'copy' of
+ * this function. Modify with care.
+ */
+static inline void
+rwsem_del_waiter(struct rw_semaphore *sem, struct rwsem_waiter *waiter)
+{
+	lockdep_assert_held(&sem->wait_lock);
+	list_del(&waiter->list);
+	if (likely(!list_empty(&sem->wait_list)))
+		return;
+
+	atomic_long_andnot(RWSEM_FLAG_HANDOFF | RWSEM_FLAG_WAITERS, &sem->count);
+}
+
 /*
  * handle the lock release when processes blocked on it that can now run
  * - if we come here from up_xxxx(), then the RWSEM_FLAG_WAITERS bit must
@@ -376,6 +398,8 @@ enum writer_wait_state {
  *   preferably when the wait_lock is released
  * - woken process blocks are discarded from the list after having task zeroed
  * - writers are only marked woken if downgrading is false
+ *
+ * Implies rwsem_del_waiter() for all woken readers.
  */
 static void rwsem_mark_wake(struct rw_semaphore *sem,
 			    enum rwsem_wake_type wake_type,
@@ -490,18 +514,25 @@ static void rwsem_mark_wake(struct rw_semaphore *sem,
 
 	adjustment = woken * RWSEM_READER_BIAS - adjustment;
 	lockevent_cond_inc(rwsem_wake_reader, woken);
+
+	oldcount = atomic_long_read(&sem->count);
 	if (list_empty(&sem->wait_list)) {
-		/* hit end of list above */
+		/*
+		 * Combined with list_move_tail() above, this implies
+		 * rwsem_del_waiter().
+		 */
 		adjustment -= RWSEM_FLAG_WAITERS;
+		if (oldcount & RWSEM_FLAG_HANDOFF)
+			adjustment -= RWSEM_FLAG_HANDOFF;
+	} else if (woken) {
+		/*
+		 * When we've woken a reader, we no longer need to force
+		 * writers to give up the lock and we can clear HANDOFF.
+		 */
+		if (oldcount & RWSEM_FLAG_HANDOFF)
+			adjustment -= RWSEM_FLAG_HANDOFF;
 	}
 
-	/*
-	 * When we've woken a reader, we no longer need to force writers
-	 * to give up the lock and we can clear HANDOFF.
-	 */
-	if (woken && (atomic_long_read(&sem->count) & RWSEM_FLAG_HANDOFF))
-		adjustment -= RWSEM_FLAG_HANDOFF;
-
 	if (adjustment)
 		atomic_long_add(adjustment, &sem->count);
 
@@ -532,12 +563,12 @@ static void rwsem_mark_wake(struct rw_semaphore *sem,
  * race conditions between checking the rwsem wait list and setting the
  * sem->count accordingly.
  *
- * If wstate is WRITER_HANDOFF, it will make sure that either the handoff
- * bit is set or the lock is acquired with handoff bit cleared.
+ * Implies rwsem_del_waiter() on success.
  */
 static inline bool rwsem_try_write_lock(struct rw_semaphore *sem,
-					enum writer_wait_state wstate)
+					struct rwsem_waiter *waiter)
 {
+	bool first = rwsem_first_waiter(sem) == waiter;
 	long count, new;
 
 	lockdep_assert_held(&sem->wait_lock);
@@ -546,13 +577,19 @@ static inline bool rwsem_try_write_lock(struct rw_semaphore *sem,
 	do {
 		bool has_handoff = !!(count & RWSEM_FLAG_HANDOFF);
 
-		if (has_handoff && wstate == WRITER_NOT_FIRST)
-			return false;
+		if (has_handoff) {
+			if (!first)
+				return false;
+
+			/* First waiter inherits a previously set handoff bit */
+			waiter->handoff_set = true;
+		}
 
 		new = count;
 
 		if (count & RWSEM_LOCK_MASK) {
-			if (has_handoff || (wstate != WRITER_HANDOFF))
+			if (has_handoff || (!rt_task(waiter->task) &&
+					    !time_after(jiffies, waiter->timeout)))
 				return false;
 
 			new |= RWSEM_FLAG_HANDOFF;
@@ -569,9 +606,17 @@ static inline bool rwsem_try_write_lock(struct rw_semaphore *sem,
 	 * We have either acquired the lock with handoff bit cleared or
 	 * set the handoff bit.
 	 */
-	if (new & RWSEM_FLAG_HANDOFF)
+	if (new & RWSEM_FLAG_HANDOFF) {
+		waiter->handoff_set = true;
+		lockevent_inc(rwsem_wlock_handoff);
 		return false;
+	}
 
+	/*
+	 * Have rwsem_try_write_lock() fully imply rwsem_del_waiter() on
+	 * success.
+	 */
+	list_del(&waiter->list);
 	rwsem_set_owner(sem);
 	return true;
 }
@@ -956,7 +1001,7 @@ queue:
 		}
 		adjustment += RWSEM_FLAG_WAITERS;
 	}
-	list_add_tail(&waiter.list, &sem->wait_list);
+	rwsem_add_waiter(sem, &waiter);
 
 	/* we're now waiting on the lock, but no longer actively locking */
 	count = atomic_long_add_return(adjustment, &sem->count);
@@ -1002,11 +1047,7 @@ queue:
 	return sem;
 
 out_nolock:
-	list_del(&waiter.list);
-	if (list_empty(&sem->wait_list)) {
-		atomic_long_andnot(RWSEM_FLAG_WAITERS|RWSEM_FLAG_HANDOFF,
-				   &sem->count);
-	}
+	rwsem_del_waiter(sem, &waiter);
 	raw_spin_unlock_irq(&sem->wait_lock);
 	__set_current_state(TASK_RUNNING);
 	lockevent_inc(rwsem_rlock_fail);
@@ -1020,9 +1061,7 @@ static struct rw_semaphore *
 rwsem_down_write_slowpath(struct rw_semaphore *sem, int state)
 {
 	long count;
-	enum writer_wait_state wstate;
 	struct rwsem_waiter waiter;
-	struct rw_semaphore *ret = sem;
 	DEFINE_WAKE_Q(wake_q);
 
 	/* do optimistic spinning and steal lock if possible */
@@ -1038,16 +1077,13 @@ rwsem_down_write_slowpath(struct rw_semaphore *sem, int state)
 	waiter.task = current;
 	waiter.type = RWSEM_WAITING_FOR_WRITE;
 	waiter.timeout = jiffies + RWSEM_WAIT_TIMEOUT;
+	waiter.handoff_set = false;
 
 	raw_spin_lock_irq(&sem->wait_lock);
-
-	/* account for this before adding a new element to the list */
-	wstate = list_empty(&sem->wait_list) ? WRITER_FIRST : WRITER_NOT_FIRST;
-
-	list_add_tail(&waiter.list, &sem->wait_list);
+	rwsem_add_waiter(sem, &waiter);
 
 	/* we're now waiting on the lock */
-	if (wstate == WRITER_NOT_FIRST) {
+	if (rwsem_first_waiter(sem) != &waiter) {
 		count = atomic_long_read(&sem->count);
 
 		/*
@@ -1083,13 +1119,16 @@ wait:
 	/* wait until we successfully acquire the lock */
 	set_current_state(state);
 	for (;;) {
-		if (rwsem_try_write_lock(sem, wstate)) {
+		if (rwsem_try_write_lock(sem, &waiter)) {
 			/* rwsem_try_write_lock() implies ACQUIRE on success */
 			break;
 		}
 
 		raw_spin_unlock_irq(&sem->wait_lock);
 
+		if (signal_pending_state(state, current))
+			goto out_nolock;
+
 		/*
 		 * After setting the handoff bit and failing to acquire
 		 * the lock, attempt to spin on owner to accelerate lock
@@ -1098,7 +1137,7 @@ wait:
 		 * In this case, we attempt to acquire the lock again
 		 * without sleeping.
 		 */
-		if (wstate == WRITER_HANDOFF) {
+		if (waiter.handoff_set) {
 			enum owner_state owner_state;
 
 			preempt_disable();
@@ -1109,66 +1148,26 @@ wait:
 				goto trylock_again;
 		}
 
-		/* Block until there are no active lockers. */
-		for (;;) {
-			if (signal_pending_state(state, current))
-				goto out_nolock;
-
-			schedule();
-			lockevent_inc(rwsem_sleep_writer);
-			set_current_state(state);
-			/*
-			 * If HANDOFF bit is set, unconditionally do
-			 * a trylock.
-			 */
-			if (wstate == WRITER_HANDOFF)
-				break;
-
-			if ((wstate == WRITER_NOT_FIRST) &&
-			    (rwsem_first_waiter(sem) == &waiter))
-				wstate = WRITER_FIRST;
-
-			count = atomic_long_read(&sem->count);
-			if (!(count & RWSEM_LOCK_MASK))
-				break;
-
-			/*
-			 * The setting of the handoff bit is deferred
-			 * until rwsem_try_write_lock() is called.
-			 */
-			if ((wstate == WRITER_FIRST) && (rt_task(current) ||
-			    time_after(jiffies, waiter.timeout))) {
-				wstate = WRITER_HANDOFF;
-				lockevent_inc(rwsem_wlock_handoff);
-				break;
-			}
-		}
+		schedule();
+		lockevent_inc(rwsem_sleep_writer);
+		set_current_state(state);
 trylock_again:
 		raw_spin_lock_irq(&sem->wait_lock);
 	}
 	__set_current_state(TASK_RUNNING);
-	list_del(&waiter.list);
 	raw_spin_unlock_irq(&sem->wait_lock);
 	lockevent_inc(rwsem_wlock);
-
-	return ret;
+	return sem;
 
 out_nolock:
 	__set_current_state(TASK_RUNNING);
 	raw_spin_lock_irq(&sem->wait_lock);
-	list_del(&waiter.list);
-
-	if (unlikely(wstate == WRITER_HANDOFF))
-		atomic_long_add(-RWSEM_FLAG_HANDOFF,  &sem->count);
-
-	if (list_empty(&sem->wait_list))
-		atomic_long_andnot(RWSEM_FLAG_WAITERS, &sem->count);
-	else
+	rwsem_del_waiter(sem, &waiter);
+	if (!list_empty(&sem->wait_list))
 		rwsem_mark_wake(sem, RWSEM_WAKE_ANY, &wake_q);
 	raw_spin_unlock_irq(&sem->wait_lock);
 	wake_up_q(&wake_q);
 	lockevent_inc(rwsem_wlock_fail);
-
 	return ERR_PTR(-EINTR);
 }
 
