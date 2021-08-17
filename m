Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F0C83EF32F
	for <lists+linux-tip-commits@lfdr.de>; Tue, 17 Aug 2021 22:15:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234298AbhHQUOg (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Tue, 17 Aug 2021 16:14:36 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:34586 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234196AbhHQUOf (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Tue, 17 Aug 2021 16:14:35 -0400
Date:   Tue, 17 Aug 2021 20:13:59 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1629231240;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=70BxkgUukaGtX9gY/v0nH9FTZSEiP3eTJMrtEoHRf9A=;
        b=1g6JkMSecPbA15EmFkw5mLtViMw978/dT/ZdOIpcEoskxdeHHi4tMQpuOy+94SHbY7Dyp5
        +T+QeRJgcujoXwaLu3P9aYQEt8SWRYwR7OzrU8S5Y3KBjHbSCaL/p1qdVtoWkF5muav2+i
        AFwipQpBuuHv+XfO3vZCl0JebDI9BcbapuaCXfKReTPFh7Vh/EP8CACn3clSN+9fxK/KZl
        Z2D563lfQ7fbpG5SanAmTvXuS5NypsrFmSoBPf4Zs0JX6iHnynmqIDsojfJdguQa4JIJ7+
        c86ZjWaljg2c7UM8ttxF02yj0KhqGvnyKxxD/I1qFf7Vr0eKgQN40ueSygmv8Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1629231240;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=70BxkgUukaGtX9gY/v0nH9FTZSEiP3eTJMrtEoHRf9A=;
        b=2F2sJ9nb1pskHIUI9fBbsdPg6XCfWWr70qMQYVqK7NHb1OjX2ArY9KGsQ/+jak2L7Xh1Jw
        DauGocZjBQBWMzAQ==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] futex: Prevent requeue_pi() lock nesting issue on RT
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210815211305.693317658@linutronix.de>
References: <20210815211305.693317658@linutronix.de>
MIME-Version: 1.0
Message-ID: <162923123997.25758.3255311088577992683.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     07d91ef510fb16a2e0ca7453222105835b7ba3b8
Gitweb:        https://git.kernel.org/tip/07d91ef510fb16a2e0ca7453222105835b7ba3b8
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Sun, 15 Aug 2021 23:29:18 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 17 Aug 2021 19:05:59 +02:00

futex: Prevent requeue_pi() lock nesting issue on RT

The requeue_pi() operation on RT kernels creates a problem versus the
task::pi_blocked_on state when a waiter is woken early (signal, timeout)
and that early wake up interleaves with the requeue_pi() operation.

When the requeue manages to block the waiter on the rtmutex which is
associated to the second futex, then a concurrent early wakeup of that
waiter faces the problem that it has to acquire the hash bucket spinlock,
which is not an issue on non-RT kernels, but on RT kernels spinlocks are
substituted by 'sleeping' spinlocks based on rtmutex. If the hash bucket
lock is contended then blocking on that spinlock would result in a
impossible situation: blocking on two locks at the same time (the hash
bucket lock and the rtmutex representing the PI futex).

It was considered to make the hash bucket locks raw_spinlocks, but
especially requeue operations with a large amount of waiters can introduce
significant latencies, so that's not an option for RT.

The RT tree carried a solution which (ab)used task::pi_blocked_on to store
the information about an ongoing requeue and an early wakeup which worked,
but required to add checks for these special states all over the place.

The distangling of an early wakeup of a waiter for a requeue_pi() operation
is already looking at quite some different states and the task::pi_blocked_on
magic just expanded that to a hard to understand 'state machine'.

This can be avoided by keeping track of the waiter/requeue state in the
futex_q object itself.

Add a requeue_state field to struct futex_q with the following possible
states:

	Q_REQUEUE_PI_NONE
	Q_REQUEUE_PI_IGNORE
	Q_REQUEUE_PI_IN_PROGRESS
	Q_REQUEUE_PI_WAIT
	Q_REQUEUE_PI_DONE
	Q_REQUEUE_PI_LOCKED

The waiter starts with state = NONE and the following state transitions are
valid:

On the waiter side:
  Q_REQUEUE_PI_NONE		-> Q_REQUEUE_PI_IGNORE
  Q_REQUEUE_PI_IN_PROGRESS	-> Q_REQUEUE_PI_WAIT

On the requeue side:
  Q_REQUEUE_PI_NONE		-> Q_REQUEUE_PI_INPROGRESS
  Q_REQUEUE_PI_IN_PROGRESS	-> Q_REQUEUE_PI_DONE/LOCKED
  Q_REQUEUE_PI_IN_PROGRESS	-> Q_REQUEUE_PI_NONE (requeue failed)
  Q_REQUEUE_PI_WAIT		-> Q_REQUEUE_PI_DONE/LOCKED
  Q_REQUEUE_PI_WAIT		-> Q_REQUEUE_PI_IGNORE (requeue failed)

The requeue side ignores a waiter with state Q_REQUEUE_PI_IGNORE as this
signals that the waiter is already on the way out. It also means that
the waiter is still on the 'wait' futex, i.e. uaddr1.

The waiter side signals early wakeup to the requeue side either through
setting state to Q_REQUEUE_PI_IGNORE or to Q_REQUEUE_PI_WAIT depending
on the current state. In case of Q_REQUEUE_PI_IGNORE it can immediately
proceed to take the hash bucket lock of uaddr1. If it set state to WAIT,
which means the wakeup is interleaving with a requeue in progress it has
to wait for the requeue side to change the state. Either to DONE/LOCKED
or to IGNORE. DONE/LOCKED means the waiter q is now on the uaddr2 futex
and either blocked (DONE) or has acquired it (LOCKED). IGNORE is set by
the requeue side when the requeue attempt failed via deadlock detection
and therefore the waiter's futex_q is still on the uaddr1 futex.

While this is not strictly required on !RT making this unconditional has
the benefit of common code and it also allows the waiter to avoid taking
the hash bucket lock on the way out in certain cases, which reduces
contention.

Add the required helpers required for the state transitions, invoke them at
the right places and restructure the futex_wait_requeue_pi() code to handle
the return from wait (early or not) based on the state machine values.

On !RT enabled kernels the waiter spin waits for the state going from
Q_REQUEUE_PI_WAIT to some other state, on RT enabled kernels this is
handled by rcuwait_wait_event() and the corresponding wake up on the
requeue side.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/20210815211305.693317658@linutronix.de
---
 kernel/futex.c | 308 ++++++++++++++++++++++++++++++++++++++++--------
 1 file changed, 259 insertions(+), 49 deletions(-)

diff --git a/kernel/futex.c b/kernel/futex.c
index 82660b9..e7b4c61 100644
--- a/kernel/futex.c
+++ b/kernel/futex.c
@@ -197,6 +197,8 @@ struct futex_pi_state {
  * @rt_waiter:		rt_waiter storage for use with requeue_pi
  * @requeue_pi_key:	the requeue_pi target futex key
  * @bitset:		bitset for the optional bitmasked wakeup
+ * @requeue_state:	State field for futex_requeue_pi()
+ * @requeue_wait:	RCU wait for futex_requeue_pi() (RT only)
  *
  * We use this hashed waitqueue, instead of a normal wait_queue_entry_t, so
  * we can wake only the relevant ones (hashed queues may be shared).
@@ -219,12 +221,68 @@ struct futex_q {
 	struct rt_mutex_waiter *rt_waiter;
 	union futex_key *requeue_pi_key;
 	u32 bitset;
+	atomic_t requeue_state;
+#ifdef CONFIG_PREEMPT_RT
+	struct rcuwait requeue_wait;
+#endif
 } __randomize_layout;
 
+/*
+ * On PREEMPT_RT, the hash bucket lock is a 'sleeping' spinlock with an
+ * underlying rtmutex. The task which is about to be requeued could have
+ * just woken up (timeout, signal). After the wake up the task has to
+ * acquire hash bucket lock, which is held by the requeue code.  As a task
+ * can only be blocked on _ONE_ rtmutex at a time, the proxy lock blocking
+ * and the hash bucket lock blocking would collide and corrupt state.
+ *
+ * On !PREEMPT_RT this is not a problem and everything could be serialized
+ * on hash bucket lock, but aside of having the benefit of common code,
+ * this allows to avoid doing the requeue when the task is already on the
+ * way out and taking the hash bucket lock of the original uaddr1 when the
+ * requeue has been completed.
+ *
+ * The following state transitions are valid:
+ *
+ * On the waiter side:
+ *   Q_REQUEUE_PI_NONE		-> Q_REQUEUE_PI_IGNORE
+ *   Q_REQUEUE_PI_IN_PROGRESS	-> Q_REQUEUE_PI_WAIT
+ *
+ * On the requeue side:
+ *   Q_REQUEUE_PI_NONE		-> Q_REQUEUE_PI_INPROGRESS
+ *   Q_REQUEUE_PI_IN_PROGRESS	-> Q_REQUEUE_PI_DONE/LOCKED
+ *   Q_REQUEUE_PI_IN_PROGRESS	-> Q_REQUEUE_PI_NONE (requeue failed)
+ *   Q_REQUEUE_PI_WAIT		-> Q_REQUEUE_PI_DONE/LOCKED
+ *   Q_REQUEUE_PI_WAIT		-> Q_REQUEUE_PI_IGNORE (requeue failed)
+ *
+ * The requeue side ignores a waiter with state Q_REQUEUE_PI_IGNORE as this
+ * signals that the waiter is already on the way out. It also means that
+ * the waiter is still on the 'wait' futex, i.e. uaddr1.
+ *
+ * The waiter side signals early wakeup to the requeue side either through
+ * setting state to Q_REQUEUE_PI_IGNORE or to Q_REQUEUE_PI_WAIT depending
+ * on the current state. In case of Q_REQUEUE_PI_IGNORE it can immediately
+ * proceed to take the hash bucket lock of uaddr1. If it set state to WAIT,
+ * which means the wakeup is interleaving with a requeue in progress it has
+ * to wait for the requeue side to change the state. Either to DONE/LOCKED
+ * or to IGNORE. DONE/LOCKED means the waiter q is now on the uaddr2 futex
+ * and either blocked (DONE) or has acquired it (LOCKED). IGNORE is set by
+ * the requeue side when the requeue attempt failed via deadlock detection
+ * and therefore the waiter q is still on the uaddr1 futex.
+ */
+enum {
+	Q_REQUEUE_PI_NONE		=  0,
+	Q_REQUEUE_PI_IGNORE,
+	Q_REQUEUE_PI_IN_PROGRESS,
+	Q_REQUEUE_PI_WAIT,
+	Q_REQUEUE_PI_DONE,
+	Q_REQUEUE_PI_LOCKED,
+};
+
 static const struct futex_q futex_q_init = {
 	/* list gets initialized in queue_me()*/
-	.key = FUTEX_KEY_INIT,
-	.bitset = FUTEX_BITSET_MATCH_ANY
+	.key		= FUTEX_KEY_INIT,
+	.bitset		= FUTEX_BITSET_MATCH_ANY,
+	.requeue_state	= ATOMIC_INIT(Q_REQUEUE_PI_NONE),
 };
 
 /*
@@ -1772,6 +1830,108 @@ void requeue_futex(struct futex_q *q, struct futex_hash_bucket *hb1,
 	q->key = *key2;
 }
 
+static inline bool futex_requeue_pi_prepare(struct futex_q *q,
+					    struct futex_pi_state *pi_state)
+{
+	int old, new;
+
+	/*
+	 * Set state to Q_REQUEUE_PI_IN_PROGRESS unless an early wakeup has
+	 * already set Q_REQUEUE_PI_IGNORE to signal that requeue should
+	 * ignore the waiter.
+	 */
+	old = atomic_read_acquire(&q->requeue_state);
+	do {
+		if (old == Q_REQUEUE_PI_IGNORE)
+			return false;
+
+		/*
+		 * futex_proxy_trylock_atomic() might have set it to
+		 * IN_PROGRESS and a interleaved early wake to WAIT.
+		 *
+		 * It was considered to have an extra state for that
+		 * trylock, but that would just add more conditionals
+		 * all over the place for a dubious value.
+		 */
+		if (old != Q_REQUEUE_PI_NONE)
+			break;
+
+		new = Q_REQUEUE_PI_IN_PROGRESS;
+	} while (!atomic_try_cmpxchg(&q->requeue_state, &old, new));
+
+	q->pi_state = pi_state;
+	return true;
+}
+
+static inline void futex_requeue_pi_complete(struct futex_q *q, int locked)
+{
+	int old, new;
+
+	old = atomic_read_acquire(&q->requeue_state);
+	do {
+		if (old == Q_REQUEUE_PI_IGNORE)
+			return;
+
+		if (locked >= 0) {
+			/* Requeue succeeded. Set DONE or LOCKED */
+			WARN_ON_ONCE(old != Q_REQUEUE_PI_IN_PROGRESS &&
+				     old != Q_REQUEUE_PI_WAIT);
+			new = Q_REQUEUE_PI_DONE + locked;
+		} else if (old == Q_REQUEUE_PI_IN_PROGRESS) {
+			/* Deadlock, no early wakeup interleave */
+			new = Q_REQUEUE_PI_NONE;
+		} else {
+			/* Deadlock, early wakeup interleave. */
+			WARN_ON_ONCE(old != Q_REQUEUE_PI_WAIT);
+			new = Q_REQUEUE_PI_IGNORE;
+		}
+	} while (!atomic_try_cmpxchg(&q->requeue_state, &old, new));
+
+#ifdef CONFIG_PREEMPT_RT
+	/* If the waiter interleaved with the requeue let it know */
+	if (unlikely(old == Q_REQUEUE_PI_WAIT))
+		rcuwait_wake_up(&q->requeue_wait);
+#endif
+}
+
+static inline int futex_requeue_pi_wakeup_sync(struct futex_q *q)
+{
+	int old, new;
+
+	old = atomic_read_acquire(&q->requeue_state);
+	do {
+		/* Is requeue done already? */
+		if (old >= Q_REQUEUE_PI_DONE)
+			return old;
+
+		/*
+		 * If not done, then tell the requeue code to either ignore
+		 * the waiter or to wake it up once the requeue is done.
+		 */
+		new = Q_REQUEUE_PI_WAIT;
+		if (old == Q_REQUEUE_PI_NONE)
+			new = Q_REQUEUE_PI_IGNORE;
+	} while (!atomic_try_cmpxchg(&q->requeue_state, &old, new));
+
+	/* If the requeue was in progress, wait for it to complete */
+	if (old == Q_REQUEUE_PI_IN_PROGRESS) {
+#ifdef CONFIG_PREEMPT_RT
+		rcuwait_wait_event(&q->requeue_wait,
+				   atomic_read(&q->requeue_state) != Q_REQUEUE_PI_WAIT,
+				   TASK_UNINTERRUPTIBLE);
+#else
+		(void)atomic_cond_read_relaxed(&q->requeue_state, VAL != Q_REQUEUE_PI_WAIT);
+#endif
+	}
+
+	/*
+	 * Requeue is now either prohibited or complete. Reread state
+	 * because during the wait above it might have changed. Nothing
+	 * will modify q->requeue_state after this point.
+	 */
+	return atomic_read(&q->requeue_state);
+}
+
 /**
  * requeue_pi_wake_futex() - Wake a task that acquired the lock during requeue
  * @q:		the futex_q
@@ -1799,6 +1959,8 @@ void requeue_pi_wake_futex(struct futex_q *q, union futex_key *key,
 
 	q->lock_ptr = &hb->lock;
 
+	/* Signal locked state to the waiter */
+	futex_requeue_pi_complete(q, 1);
 	wake_up_state(q->task, TASK_NORMAL);
 }
 
@@ -1869,6 +2031,10 @@ futex_proxy_trylock_atomic(u32 __user *pifutex, struct futex_hash_bucket *hb1,
 	if (!match_futex(top_waiter->requeue_pi_key, key2))
 		return -EINVAL;
 
+	/* Ensure that this does not race against an early wakeup */
+	if (!futex_requeue_pi_prepare(top_waiter, NULL))
+		return -EAGAIN;
+
 	/*
 	 * Try to take the lock for top_waiter.  Set the FUTEX_WAITERS bit in
 	 * the contended case or if set_waiters is 1.  The pi_state is returned
@@ -1878,8 +2044,22 @@ futex_proxy_trylock_atomic(u32 __user *pifutex, struct futex_hash_bucket *hb1,
 	ret = futex_lock_pi_atomic(pifutex, hb2, key2, ps, top_waiter->task,
 				   exiting, set_waiters);
 	if (ret == 1) {
+		/* Dequeue, wake up and update top_waiter::requeue_state */
 		requeue_pi_wake_futex(top_waiter, key2, hb2);
 		return vpid;
+	} else if (ret < 0) {
+		/* Rewind top_waiter::requeue_state */
+		futex_requeue_pi_complete(top_waiter, ret);
+	} else {
+		/*
+		 * futex_lock_pi_atomic() did not acquire the user space
+		 * futex, but managed to establish the proxy lock and pi
+		 * state. top_waiter::requeue_state cannot be fixed up here
+		 * because the waiter is not enqueued on the rtmutex
+		 * yet. This is handled at the callsite depending on the
+		 * result of rt_mutex_start_proxy_lock() which is
+		 * guaranteed to be reached with this function returning 0.
+		 */
 	}
 	return ret;
 }
@@ -2020,6 +2200,8 @@ retry_private:
 		 * intend to requeue waiters, force setting the FUTEX_WAITERS
 		 * bit.  We force this here where we are able to easily handle
 		 * faults rather in the requeue loop below.
+		 *
+		 * Updates topwaiter::requeue_state if a top waiter exists.
 		 */
 		ret = futex_proxy_trylock_atomic(uaddr2, hb1, hb2, &key1,
 						 &key2, &pi_state,
@@ -2033,6 +2215,24 @@ retry_private:
 		 * VPID of the top waiter task.
 		 * If the lock was not taken, we have pi_state and an initial
 		 * refcount on it. In case of an error we have nothing.
+		 *
+		 * The top waiter's requeue_state is up to date:
+		 *
+		 *  - If the lock was acquired atomically (ret > 0), then
+		 *    the state is Q_REQUEUE_PI_LOCKED.
+		 *
+		 *  - If the trylock failed with an error (ret < 0) then
+		 *    the state is either Q_REQUEUE_PI_NONE, i.e. "nothing
+		 *    happened", or Q_REQUEUE_PI_IGNORE when there was an
+		 *    interleaved early wakeup.
+		 *
+		 *  - If the trylock did not succeed (ret == 0) then the
+		 *    state is either Q_REQUEUE_PI_IN_PROGRESS or
+		 *    Q_REQUEUE_PI_WAIT if an early wakeup interleaved.
+		 *    This will be cleaned up in the loop below, which
+		 *    cannot fail because futex_proxy_trylock_atomic() did
+		 *    the same sanity checks for requeue_pi as the loop
+		 *    below does.
 		 */
 		if (ret > 0) {
 			WARN_ON(pi_state);
@@ -2064,7 +2264,10 @@ retry_private:
 			/* We hold a reference on the pi state. */
 			break;
 
-			/* If the above failed, then pi_state is NULL */
+		/*
+		 * If the above failed, then pi_state is NULL and
+		 * waiter::requeue_state is correct.
+		 */
 		case -EFAULT:
 			double_unlock_hb(hb1, hb2);
 			hb_waiters_dec(hb2);
@@ -2140,21 +2343,39 @@ retry_private:
 		 * object of the waiter.
 		 */
 		get_pi_state(pi_state);
-		this->pi_state = pi_state;
+
+		/* Don't requeue when the waiter is already on the way out. */
+		if (!futex_requeue_pi_prepare(this, pi_state)) {
+			/*
+			 * Early woken waiter signaled that it is on the
+			 * way out. Drop the pi_state reference and try the
+			 * next waiter. @this->pi_state is still NULL.
+			 */
+			put_pi_state(pi_state);
+			continue;
+		}
+
 		ret = rt_mutex_start_proxy_lock(&pi_state->pi_mutex,
-						this->rt_waiter, this->task);
+						this->rt_waiter,
+						this->task);
+
 		if (ret == 1) {
 			/*
 			 * We got the lock. We do neither drop the refcount
 			 * on pi_state nor clear this->pi_state because the
 			 * waiter needs the pi_state for cleaning up the
 			 * user space value. It will drop the refcount
-			 * after doing so.
+			 * after doing so. this::requeue_state is updated
+			 * in the wakeup as well.
 			 */
 			requeue_pi_wake_futex(this, &key2, hb2);
 			task_count++;
-			continue;
-		} else if (ret) {
+		} else if (!ret) {
+			/* Waiter is queued, move it to hb2 */
+			requeue_futex(this, hb1, hb2, &key2);
+			futex_requeue_pi_complete(this, 0);
+			task_count++;
+		} else {
 			/*
 			 * rt_mutex_start_proxy_lock() detected a potential
 			 * deadlock when we tried to queue that waiter.
@@ -2164,15 +2385,13 @@ retry_private:
 			 */
 			this->pi_state = NULL;
 			put_pi_state(pi_state);
+			futex_requeue_pi_complete(this, ret);
 			/*
 			 * We stop queueing more waiters and let user space
 			 * deal with the mess.
 			 */
 			break;
 		}
-		/* Waiter is queued, move it to hb2 */
-		requeue_futex(this, hb1, hb2, &key2);
-		task_count++;
 	}
 
 	/*
@@ -3161,6 +3380,7 @@ static int futex_wait_requeue_pi(u32 __user *uaddr, unsigned int flags,
 	struct futex_hash_bucket *hb;
 	union futex_key key2 = FUTEX_KEY_INIT;
 	struct futex_q q = futex_q_init;
+	struct rt_mutex_base *pi_mutex;
 	int res, ret;
 
 	if (!IS_ENABLED(CONFIG_FUTEX_PI))
@@ -3210,32 +3430,22 @@ static int futex_wait_requeue_pi(u32 __user *uaddr, unsigned int flags,
 	/* Queue the futex_q, drop the hb lock, wait for wakeup. */
 	futex_wait_queue_me(hb, &q, to);
 
-	spin_lock(&hb->lock);
-	/* Is @q still queued on uaddr1? */
-	if (!match_futex(&q->key, key2))
+	switch (futex_requeue_pi_wakeup_sync(&q)) {
+	case Q_REQUEUE_PI_IGNORE:
+		/* The waiter is still on uaddr1 */
+		spin_lock(&hb->lock);
 		ret = handle_early_requeue_pi_wakeup(hb, &q, to);
-	spin_unlock(&hb->lock);
-	if (ret)
-		goto out;
-
-	/*
-	 * In order for us to be here, we know our q.key == key2, and since
-	 * we took the hb->lock above, we also know that futex_requeue() has
-	 * completed and we no longer have to concern ourselves with a wakeup
-	 * race with the atomic proxy lock acquisition by the requeue code.
-	 */
+		spin_unlock(&hb->lock);
+		break;
 
-	/*
-	 * Check if the requeue code acquired the second futex for us and do
-	 * any pertinent fixup.
-	 */
-	if (!q.rt_waiter) {
+	case Q_REQUEUE_PI_LOCKED:
+		/* The requeue acquired the lock */
 		if (q.pi_state && (q.pi_state->owner != current)) {
 			spin_lock(q.lock_ptr);
 			ret = fixup_owner(uaddr2, &q, true);
 			/*
-			 * Drop the reference to the pi state which
-			 * the requeue_pi() code acquired for us.
+			 * Drop the reference to the pi state which the
+			 * requeue_pi() code acquired for us.
 			 */
 			put_pi_state(q.pi_state);
 			spin_unlock(q.lock_ptr);
@@ -3245,18 +3455,14 @@ static int futex_wait_requeue_pi(u32 __user *uaddr, unsigned int flags,
 			 */
 			ret = ret < 0 ? ret : 0;
 		}
-	} else {
-		struct rt_mutex_base *pi_mutex;
+		break;
 
-		/*
-		 * We have been woken up by futex_unlock_pi(), a timeout, or a
-		 * signal.  futex_unlock_pi() will not destroy the lock_ptr nor
-		 * the pi_state.
-		 */
-		WARN_ON(!q.pi_state);
+	case Q_REQUEUE_PI_DONE:
+		/* Requeue completed. Current is 'pi_blocked_on' the rtmutex */
 		pi_mutex = &q.pi_state->pi_mutex;
 		ret = rt_mutex_wait_proxy_lock(pi_mutex, to, &rt_waiter);
 
+		/* Current is not longer pi_blocked_on */
 		spin_lock(q.lock_ptr);
 		if (ret && !rt_mutex_cleanup_proxy_lock(pi_mutex, &rt_waiter))
 			ret = 0;
@@ -3276,17 +3482,21 @@ static int futex_wait_requeue_pi(u32 __user *uaddr, unsigned int flags,
 
 		unqueue_me_pi(&q);
 		spin_unlock(q.lock_ptr);
-	}
 
-	if (ret == -EINTR) {
-		/*
-		 * We've already been requeued, but cannot restart by calling
-		 * futex_lock_pi() directly. We could restart this syscall, but
-		 * it would detect that the user space "val" changed and return
-		 * -EWOULDBLOCK.  Save the overhead of the restart and return
-		 * -EWOULDBLOCK directly.
-		 */
-		ret = -EWOULDBLOCK;
+		if (ret == -EINTR) {
+			/*
+			 * We've already been requeued, but cannot restart
+			 * by calling futex_lock_pi() directly. We could
+			 * restart this syscall, but it would detect that
+			 * the user space "val" changed and return
+			 * -EWOULDBLOCK.  Save the overhead of the restart
+			 * and return -EWOULDBLOCK directly.
+			 */
+			ret = -EWOULDBLOCK;
+		}
+		break;
+	default:
+		BUG();
 	}
 
 out:
