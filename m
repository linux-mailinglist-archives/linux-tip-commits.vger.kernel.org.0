Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA52D4278B3
	for <lists+linux-tip-commits@lfdr.de>; Sat,  9 Oct 2021 12:07:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244554AbhJIKJI (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Sat, 9 Oct 2021 06:09:08 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:49368 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244511AbhJIKJG (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Sat, 9 Oct 2021 06:09:06 -0400
Date:   Sat, 09 Oct 2021 10:07:07 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1633774028;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=P4n52o+YH24uu8pPGhNP6+QFsnQEL4yr/Cc6q0TmhWA=;
        b=AV41ALUkQUzjuax2385pXVxmk8DS+4QdFvUKV0M8134sXm/4TSOd7rCdLoTFX/JhTn43Gg
        u301RhkabwJNUzWk2eqqWNbhogcU9yBmSwIDH4m7rQLGZ6Gc0MEA8u+uQNWJqiRvT+Uq60
        QpX6Hq+Zj2qJ7mJMieSirfn3k6SlCm6D7DRl9NhIli29yDoDp0GAQCHMvs8bOGszLIHrV6
        enGWTV3sFblJr4MHVApcaWS1A78urg3OlqvxvOHl99nPO3eSpH5Kgaj+K1nC70t/e5d+kp
        dN5+OwzFhIr8behBQJA/MhIm4sZqI7978uumqGFf+8CvQwwHqd4UZgeRJphFjQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1633774028;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=P4n52o+YH24uu8pPGhNP6+QFsnQEL4yr/Cc6q0TmhWA=;
        b=/drykrtwohuTlBpRnlUqS1w/Kjf+O316aG7T4kgzW2Jk9EaGJUE377cEjTm0hdZiTCLSqH
        /kHwVdz5tuqq8gCg==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] futex: Split out requeue
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        andrealmeid@collabora.com, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210923171111.300673-14-andrealmeid@collabora.com>
References: <20210923171111.300673-14-andrealmeid@collabora.com>
MIME-Version: 1.0
Message-ID: <163377402732.25758.10591795748827044017.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     e5c6828493b5fa6a3c4606b43e80ab6c5ec1111f
Gitweb:        https://git.kernel.org/tip/e5c6828493b5fa6a3c4606b43e80ab6c5ec=
1111f
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Thu, 23 Sep 2021 14:11:02 -03:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Thu, 07 Oct 2021 13:51:10 +02:00

futex: Split out requeue

Move all the requeue bits into their own file.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Andr=C3=A9 Almeida <andrealmeid@collabora.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Andr=C3=A9 Almeida <andrealmeid@collabora.com>
Link: https://lore.kernel.org/r/20210923171111.300673-14-andrealmeid@collabor=
a.com
---
 kernel/futex/Makefile  |   2 +-
 kernel/futex/core.c    | 966 +----------------------------------------
 kernel/futex/futex.h   |  77 ++-
 kernel/futex/requeue.c | 897 +++++++++++++++++++++++++++++++++++++-
 4 files changed, 979 insertions(+), 963 deletions(-)
 create mode 100644 kernel/futex/requeue.c

diff --git a/kernel/futex/Makefile b/kernel/futex/Makefile
index 27b71c2..c040941 100644
--- a/kernel/futex/Makefile
+++ b/kernel/futex/Makefile
@@ -1,3 +1,3 @@
 # SPDX-License-Identifier: GPL-2.0
=20
-obj-y +=3D core.o syscalls.o pi.o
+obj-y +=3D core.o syscalls.o pi.o requeue.o
diff --git a/kernel/futex/core.c b/kernel/futex/core.c
index bcc4aa0..42f2735 100644
--- a/kernel/futex/core.c
+++ b/kernel/futex/core.c
@@ -148,64 +148,6 @@ int  __read_mostly futex_cmpxchg_enabled;
=20
=20
 /*
- * On PREEMPT_RT, the hash bucket lock is a 'sleeping' spinlock with an
- * underlying rtmutex. The task which is about to be requeued could have
- * just woken up (timeout, signal). After the wake up the task has to
- * acquire hash bucket lock, which is held by the requeue code.  As a task
- * can only be blocked on _ONE_ rtmutex at a time, the proxy lock blocking
- * and the hash bucket lock blocking would collide and corrupt state.
- *
- * On !PREEMPT_RT this is not a problem and everything could be serialized
- * on hash bucket lock, but aside of having the benefit of common code,
- * this allows to avoid doing the requeue when the task is already on the
- * way out and taking the hash bucket lock of the original uaddr1 when the
- * requeue has been completed.
- *
- * The following state transitions are valid:
- *
- * On the waiter side:
- *   Q_REQUEUE_PI_NONE		-> Q_REQUEUE_PI_IGNORE
- *   Q_REQUEUE_PI_IN_PROGRESS	-> Q_REQUEUE_PI_WAIT
- *
- * On the requeue side:
- *   Q_REQUEUE_PI_NONE		-> Q_REQUEUE_PI_INPROGRESS
- *   Q_REQUEUE_PI_IN_PROGRESS	-> Q_REQUEUE_PI_DONE/LOCKED
- *   Q_REQUEUE_PI_IN_PROGRESS	-> Q_REQUEUE_PI_NONE (requeue failed)
- *   Q_REQUEUE_PI_WAIT		-> Q_REQUEUE_PI_DONE/LOCKED
- *   Q_REQUEUE_PI_WAIT		-> Q_REQUEUE_PI_IGNORE (requeue failed)
- *
- * The requeue side ignores a waiter with state Q_REQUEUE_PI_IGNORE as this
- * signals that the waiter is already on the way out. It also means that
- * the waiter is still on the 'wait' futex, i.e. uaddr1.
- *
- * The waiter side signals early wakeup to the requeue side either through
- * setting state to Q_REQUEUE_PI_IGNORE or to Q_REQUEUE_PI_WAIT depending
- * on the current state. In case of Q_REQUEUE_PI_IGNORE it can immediately
- * proceed to take the hash bucket lock of uaddr1. If it set state to WAIT,
- * which means the wakeup is interleaving with a requeue in progress it has
- * to wait for the requeue side to change the state. Either to DONE/LOCKED
- * or to IGNORE. DONE/LOCKED means the waiter q is now on the uaddr2 futex
- * and either blocked (DONE) or has acquired it (LOCKED). IGNORE is set by
- * the requeue side when the requeue attempt failed via deadlock detection
- * and therefore the waiter q is still on the uaddr1 futex.
- */
-enum {
-	Q_REQUEUE_PI_NONE		=3D  0,
-	Q_REQUEUE_PI_IGNORE,
-	Q_REQUEUE_PI_IN_PROGRESS,
-	Q_REQUEUE_PI_WAIT,
-	Q_REQUEUE_PI_DONE,
-	Q_REQUEUE_PI_LOCKED,
-};
-
-const struct futex_q futex_q_init =3D {
-	/* list gets initialized in futex_queue()*/
-	.key		=3D FUTEX_KEY_INIT,
-	.bitset		=3D FUTEX_BITSET_MATCH_ANY,
-	.requeue_state	=3D ATOMIC_INIT(Q_REQUEUE_PI_NONE),
-};
-
-/*
  * The base of the bucket array and its size are always used together
  * (after initialization only in futex_hash()), so ensure that they
  * reside in the same cacheline.
@@ -269,31 +211,6 @@ late_initcall(fail_futex_debugfs);
=20
 #endif /* CONFIG_FAIL_FUTEX */
=20
-/*
- * Reflects a new waiter being added to the waitqueue.
- */
-static inline void futex_hb_waiters_inc(struct futex_hash_bucket *hb)
-{
-#ifdef CONFIG_SMP
-	atomic_inc(&hb->waiters);
-	/*
-	 * Full barrier (A), see the ordering comment above.
-	 */
-	smp_mb__after_atomic();
-#endif
-}
-
-/*
- * Reflects a waiter being removed from the waitqueue by wakeup
- * paths.
- */
-static inline void futex_hb_waiters_dec(struct futex_hash_bucket *hb)
-{
-#ifdef CONFIG_SMP
-	atomic_dec(&hb->waiters);
-#endif
-}
-
 static inline int futex_hb_waiters_pending(struct futex_hash_bucket *hb)
 {
 #ifdef CONFIG_SMP
@@ -324,21 +241,6 @@ struct futex_hash_bucket *futex_hash(union futex_key *ke=
y)
=20
=20
 /**
- * futex_match - Check whether two futex keys are equal
- * @key1:	Pointer to key1
- * @key2:	Pointer to key2
- *
- * Return 1 if two futex_keys are equal, 0 otherwise.
- */
-static inline int futex_match(union futex_key *key1, union futex_key *key2)
-{
-	return (key1 && key2
-		&& key1->both.word =3D=3D key2->both.word
-		&& key1->both.ptr =3D=3D key2->both.ptr
-		&& key1->both.offset =3D=3D key2->both.offset);
-}
-
-/**
  * futex_setup_timer - set up the sleeping hrtimer.
  * @time:	ptr to the given timeout value
  * @timeout:	the hrtimer_sleeper structure to be set up
@@ -713,7 +615,7 @@ void wait_for_owner_exiting(int ret, struct task_struct *=
exiting)
  *
  * The q->lock_ptr must not be NULL and must be held by the caller.
  */
-static void __futex_unqueue(struct futex_q *q)
+void __futex_unqueue(struct futex_q *q)
 {
 	struct futex_hash_bucket *hb;
=20
@@ -732,7 +634,7 @@ static void __futex_unqueue(struct futex_q *q)
  * must ensure to later call wake_up_q() for the actual
  * wakeups to occur.
  */
-static void futex_wake_mark(struct wake_q_head *wake_q, struct futex_q *q)
+void futex_wake_mark(struct wake_q_head *wake_q, struct futex_q *q)
 {
 	struct task_struct *p =3D q->task;
=20
@@ -758,30 +660,6 @@ static void futex_wake_mark(struct wake_q_head *wake_q, =
struct futex_q *q)
 }
=20
 /*
- * Express the locking dependencies for lockdep:
- */
-static inline void
-double_lock_hb(struct futex_hash_bucket *hb1, struct futex_hash_bucket *hb2)
-{
-	if (hb1 <=3D hb2) {
-		spin_lock(&hb1->lock);
-		if (hb1 < hb2)
-			spin_lock_nested(&hb2->lock, SINGLE_DEPTH_NESTING);
-	} else { /* hb1 > hb2 */
-		spin_lock(&hb2->lock);
-		spin_lock_nested(&hb1->lock, SINGLE_DEPTH_NESTING);
-	}
-}
-
-static inline void
-double_unlock_hb(struct futex_hash_bucket *hb1, struct futex_hash_bucket *hb=
2)
-{
-	spin_unlock(&hb1->lock);
-	if (hb1 !=3D hb2)
-		spin_unlock(&hb2->lock);
-}
-
-/*
  * Wake up waiters matching bitset queued on this futex (uaddr).
  */
 int futex_wake(u32 __user *uaddr, unsigned int flags, int nr_wake, u32 bitse=
t)
@@ -961,619 +839,6 @@ out_unlock:
 	return ret;
 }
=20
-/**
- * requeue_futex() - Requeue a futex_q from one hb to another
- * @q:		the futex_q to requeue
- * @hb1:	the source hash_bucket
- * @hb2:	the target hash_bucket
- * @key2:	the new key for the requeued futex_q
- */
-static inline
-void requeue_futex(struct futex_q *q, struct futex_hash_bucket *hb1,
-		   struct futex_hash_bucket *hb2, union futex_key *key2)
-{
-
-	/*
-	 * If key1 and key2 hash to the same bucket, no need to
-	 * requeue.
-	 */
-	if (likely(&hb1->chain !=3D &hb2->chain)) {
-		plist_del(&q->list, &hb1->chain);
-		futex_hb_waiters_dec(hb1);
-		futex_hb_waiters_inc(hb2);
-		plist_add(&q->list, &hb2->chain);
-		q->lock_ptr =3D &hb2->lock;
-	}
-	q->key =3D *key2;
-}
-
-static inline bool futex_requeue_pi_prepare(struct futex_q *q,
-					    struct futex_pi_state *pi_state)
-{
-	int old, new;
-
-	/*
-	 * Set state to Q_REQUEUE_PI_IN_PROGRESS unless an early wakeup has
-	 * already set Q_REQUEUE_PI_IGNORE to signal that requeue should
-	 * ignore the waiter.
-	 */
-	old =3D atomic_read_acquire(&q->requeue_state);
-	do {
-		if (old =3D=3D Q_REQUEUE_PI_IGNORE)
-			return false;
-
-		/*
-		 * futex_proxy_trylock_atomic() might have set it to
-		 * IN_PROGRESS and a interleaved early wake to WAIT.
-		 *
-		 * It was considered to have an extra state for that
-		 * trylock, but that would just add more conditionals
-		 * all over the place for a dubious value.
-		 */
-		if (old !=3D Q_REQUEUE_PI_NONE)
-			break;
-
-		new =3D Q_REQUEUE_PI_IN_PROGRESS;
-	} while (!atomic_try_cmpxchg(&q->requeue_state, &old, new));
-
-	q->pi_state =3D pi_state;
-	return true;
-}
-
-static inline void futex_requeue_pi_complete(struct futex_q *q, int locked)
-{
-	int old, new;
-
-	old =3D atomic_read_acquire(&q->requeue_state);
-	do {
-		if (old =3D=3D Q_REQUEUE_PI_IGNORE)
-			return;
-
-		if (locked >=3D 0) {
-			/* Requeue succeeded. Set DONE or LOCKED */
-			WARN_ON_ONCE(old !=3D Q_REQUEUE_PI_IN_PROGRESS &&
-				     old !=3D Q_REQUEUE_PI_WAIT);
-			new =3D Q_REQUEUE_PI_DONE + locked;
-		} else if (old =3D=3D Q_REQUEUE_PI_IN_PROGRESS) {
-			/* Deadlock, no early wakeup interleave */
-			new =3D Q_REQUEUE_PI_NONE;
-		} else {
-			/* Deadlock, early wakeup interleave. */
-			WARN_ON_ONCE(old !=3D Q_REQUEUE_PI_WAIT);
-			new =3D Q_REQUEUE_PI_IGNORE;
-		}
-	} while (!atomic_try_cmpxchg(&q->requeue_state, &old, new));
-
-#ifdef CONFIG_PREEMPT_RT
-	/* If the waiter interleaved with the requeue let it know */
-	if (unlikely(old =3D=3D Q_REQUEUE_PI_WAIT))
-		rcuwait_wake_up(&q->requeue_wait);
-#endif
-}
-
-static inline int futex_requeue_pi_wakeup_sync(struct futex_q *q)
-{
-	int old, new;
-
-	old =3D atomic_read_acquire(&q->requeue_state);
-	do {
-		/* Is requeue done already? */
-		if (old >=3D Q_REQUEUE_PI_DONE)
-			return old;
-
-		/*
-		 * If not done, then tell the requeue code to either ignore
-		 * the waiter or to wake it up once the requeue is done.
-		 */
-		new =3D Q_REQUEUE_PI_WAIT;
-		if (old =3D=3D Q_REQUEUE_PI_NONE)
-			new =3D Q_REQUEUE_PI_IGNORE;
-	} while (!atomic_try_cmpxchg(&q->requeue_state, &old, new));
-
-	/* If the requeue was in progress, wait for it to complete */
-	if (old =3D=3D Q_REQUEUE_PI_IN_PROGRESS) {
-#ifdef CONFIG_PREEMPT_RT
-		rcuwait_wait_event(&q->requeue_wait,
-				   atomic_read(&q->requeue_state) !=3D Q_REQUEUE_PI_WAIT,
-				   TASK_UNINTERRUPTIBLE);
-#else
-		(void)atomic_cond_read_relaxed(&q->requeue_state, VAL !=3D Q_REQUEUE_PI_WA=
IT);
-#endif
-	}
-
-	/*
-	 * Requeue is now either prohibited or complete. Reread state
-	 * because during the wait above it might have changed. Nothing
-	 * will modify q->requeue_state after this point.
-	 */
-	return atomic_read(&q->requeue_state);
-}
-
-/**
- * requeue_pi_wake_futex() - Wake a task that acquired the lock during reque=
ue
- * @q:		the futex_q
- * @key:	the key of the requeue target futex
- * @hb:		the hash_bucket of the requeue target futex
- *
- * During futex_requeue, with requeue_pi=3D1, it is possible to acquire the
- * target futex if it is uncontended or via a lock steal.
- *
- * 1) Set @q::key to the requeue target futex key so the waiter can detect
- *    the wakeup on the right futex.
- *
- * 2) Dequeue @q from the hash bucket.
- *
- * 3) Set @q::rt_waiter to NULL so the woken up task can detect atomic lock
- *    acquisition.
- *
- * 4) Set the q->lock_ptr to the requeue target hb->lock for the case that
- *    the waiter has to fixup the pi state.
- *
- * 5) Complete the requeue state so the waiter can make progress. After
- *    this point the waiter task can return from the syscall immediately in
- *    case that the pi state does not have to be fixed up.
- *
- * 6) Wake the waiter task.
- *
- * Must be called with both q->lock_ptr and hb->lock held.
- */
-static inline
-void requeue_pi_wake_futex(struct futex_q *q, union futex_key *key,
-			   struct futex_hash_bucket *hb)
-{
-	q->key =3D *key;
-
-	__futex_unqueue(q);
-
-	WARN_ON(!q->rt_waiter);
-	q->rt_waiter =3D NULL;
-
-	q->lock_ptr =3D &hb->lock;
-
-	/* Signal locked state to the waiter */
-	futex_requeue_pi_complete(q, 1);
-	wake_up_state(q->task, TASK_NORMAL);
-}
-
-/**
- * futex_proxy_trylock_atomic() - Attempt an atomic lock for the top waiter
- * @pifutex:		the user address of the to futex
- * @hb1:		the from futex hash bucket, must be locked by the caller
- * @hb2:		the to futex hash bucket, must be locked by the caller
- * @key1:		the from futex key
- * @key2:		the to futex key
- * @ps:			address to store the pi_state pointer
- * @exiting:		Pointer to store the task pointer of the owner task
- *			which is in the middle of exiting
- * @set_waiters:	force setting the FUTEX_WAITERS bit (1) or not (0)
- *
- * Try and get the lock on behalf of the top waiter if we can do it atomical=
ly.
- * Wake the top waiter if we succeed.  If the caller specified set_waiters,
- * then direct futex_lock_pi_atomic() to force setting the FUTEX_WAITERS bit.
- * hb1 and hb2 must be held by the caller.
- *
- * @exiting is only set when the return value is -EBUSY. If so, this holds
- * a refcount on the exiting task on return and the caller needs to drop it
- * after waiting for the exit to complete.
- *
- * Return:
- *  -  0 - failed to acquire the lock atomically;
- *  - >0 - acquired the lock, return value is vpid of the top_waiter
- *  - <0 - error
- */
-static int
-futex_proxy_trylock_atomic(u32 __user *pifutex, struct futex_hash_bucket *hb=
1,
-			   struct futex_hash_bucket *hb2, union futex_key *key1,
-			   union futex_key *key2, struct futex_pi_state **ps,
-			   struct task_struct **exiting, int set_waiters)
-{
-	struct futex_q *top_waiter =3D NULL;
-	u32 curval;
-	int ret;
-
-	if (futex_get_value_locked(&curval, pifutex))
-		return -EFAULT;
-
-	if (unlikely(should_fail_futex(true)))
-		return -EFAULT;
-
-	/*
-	 * Find the top_waiter and determine if there are additional waiters.
-	 * If the caller intends to requeue more than 1 waiter to pifutex,
-	 * force futex_lock_pi_atomic() to set the FUTEX_WAITERS bit now,
-	 * as we have means to handle the possible fault.  If not, don't set
-	 * the bit unnecessarily as it will force the subsequent unlock to enter
-	 * the kernel.
-	 */
-	top_waiter =3D futex_top_waiter(hb1, key1);
-
-	/* There are no waiters, nothing for us to do. */
-	if (!top_waiter)
-		return 0;
-
-	/*
-	 * Ensure that this is a waiter sitting in futex_wait_requeue_pi()
-	 * and waiting on the 'waitqueue' futex which is always !PI.
-	 */
-	if (!top_waiter->rt_waiter || top_waiter->pi_state)
-		return -EINVAL;
-
-	/* Ensure we requeue to the expected futex. */
-	if (!futex_match(top_waiter->requeue_pi_key, key2))
-		return -EINVAL;
-
-	/* Ensure that this does not race against an early wakeup */
-	if (!futex_requeue_pi_prepare(top_waiter, NULL))
-		return -EAGAIN;
-
-	/*
-	 * Try to take the lock for top_waiter and set the FUTEX_WAITERS bit
-	 * in the contended case or if @set_waiters is true.
-	 *
-	 * In the contended case PI state is attached to the lock owner. If
-	 * the user space lock can be acquired then PI state is attached to
-	 * the new owner (@top_waiter->task) when @set_waiters is true.
-	 */
-	ret =3D futex_lock_pi_atomic(pifutex, hb2, key2, ps, top_waiter->task,
-				   exiting, set_waiters);
-	if (ret =3D=3D 1) {
-		/*
-		 * Lock was acquired in user space and PI state was
-		 * attached to @top_waiter->task. That means state is fully
-		 * consistent and the waiter can return to user space
-		 * immediately after the wakeup.
-		 */
-		requeue_pi_wake_futex(top_waiter, key2, hb2);
-	} else if (ret < 0) {
-		/* Rewind top_waiter::requeue_state */
-		futex_requeue_pi_complete(top_waiter, ret);
-	} else {
-		/*
-		 * futex_lock_pi_atomic() did not acquire the user space
-		 * futex, but managed to establish the proxy lock and pi
-		 * state. top_waiter::requeue_state cannot be fixed up here
-		 * because the waiter is not enqueued on the rtmutex
-		 * yet. This is handled at the callsite depending on the
-		 * result of rt_mutex_start_proxy_lock() which is
-		 * guaranteed to be reached with this function returning 0.
-		 */
-	}
-	return ret;
-}
-
-/**
- * futex_requeue() - Requeue waiters from uaddr1 to uaddr2
- * @uaddr1:	source futex user address
- * @flags:	futex flags (FLAGS_SHARED, etc.)
- * @uaddr2:	target futex user address
- * @nr_wake:	number of waiters to wake (must be 1 for requeue_pi)
- * @nr_requeue:	number of waiters to requeue (0-INT_MAX)
- * @cmpval:	@uaddr1 expected value (or %NULL)
- * @requeue_pi:	if we are attempting to requeue from a non-pi futex to a
- *		pi futex (pi to pi requeue is not supported)
- *
- * Requeue waiters on uaddr1 to uaddr2. In the requeue_pi case, try to acqui=
re
- * uaddr2 atomically on behalf of the top waiter.
- *
- * Return:
- *  - >=3D0 - on success, the number of tasks requeued or woken;
- *  -  <0 - on error
- */
-int futex_requeue(u32 __user *uaddr1, unsigned int flags, u32 __user *uaddr2,
-		  int nr_wake, int nr_requeue, u32 *cmpval, int requeue_pi)
-{
-	union futex_key key1 =3D FUTEX_KEY_INIT, key2 =3D FUTEX_KEY_INIT;
-	int task_count =3D 0, ret;
-	struct futex_pi_state *pi_state =3D NULL;
-	struct futex_hash_bucket *hb1, *hb2;
-	struct futex_q *this, *next;
-	DEFINE_WAKE_Q(wake_q);
-
-	if (nr_wake < 0 || nr_requeue < 0)
-		return -EINVAL;
-
-	/*
-	 * When PI not supported: return -ENOSYS if requeue_pi is true,
-	 * consequently the compiler knows requeue_pi is always false past
-	 * this point which will optimize away all the conditional code
-	 * further down.
-	 */
-	if (!IS_ENABLED(CONFIG_FUTEX_PI) && requeue_pi)
-		return -ENOSYS;
-
-	if (requeue_pi) {
-		/*
-		 * Requeue PI only works on two distinct uaddrs. This
-		 * check is only valid for private futexes. See below.
-		 */
-		if (uaddr1 =3D=3D uaddr2)
-			return -EINVAL;
-
-		/*
-		 * futex_requeue() allows the caller to define the number
-		 * of waiters to wake up via the @nr_wake argument. With
-		 * REQUEUE_PI, waking up more than one waiter is creating
-		 * more problems than it solves. Waking up a waiter makes
-		 * only sense if the PI futex @uaddr2 is uncontended as
-		 * this allows the requeue code to acquire the futex
-		 * @uaddr2 before waking the waiter. The waiter can then
-		 * return to user space without further action. A secondary
-		 * wakeup would just make the futex_wait_requeue_pi()
-		 * handling more complex, because that code would have to
-		 * look up pi_state and do more or less all the handling
-		 * which the requeue code has to do for the to be requeued
-		 * waiters. So restrict the number of waiters to wake to
-		 * one, and only wake it up when the PI futex is
-		 * uncontended. Otherwise requeue it and let the unlock of
-		 * the PI futex handle the wakeup.
-		 *
-		 * All REQUEUE_PI users, e.g. pthread_cond_signal() and
-		 * pthread_cond_broadcast() must use nr_wake=3D1.
-		 */
-		if (nr_wake !=3D 1)
-			return -EINVAL;
-
-		/*
-		 * requeue_pi requires a pi_state, try to allocate it now
-		 * without any locks in case it fails.
-		 */
-		if (refill_pi_state_cache())
-			return -ENOMEM;
-	}
-
-retry:
-	ret =3D get_futex_key(uaddr1, flags & FLAGS_SHARED, &key1, FUTEX_READ);
-	if (unlikely(ret !=3D 0))
-		return ret;
-	ret =3D get_futex_key(uaddr2, flags & FLAGS_SHARED, &key2,
-			    requeue_pi ? FUTEX_WRITE : FUTEX_READ);
-	if (unlikely(ret !=3D 0))
-		return ret;
-
-	/*
-	 * The check above which compares uaddrs is not sufficient for
-	 * shared futexes. We need to compare the keys:
-	 */
-	if (requeue_pi && futex_match(&key1, &key2))
-		return -EINVAL;
-
-	hb1 =3D futex_hash(&key1);
-	hb2 =3D futex_hash(&key2);
-
-retry_private:
-	futex_hb_waiters_inc(hb2);
-	double_lock_hb(hb1, hb2);
-
-	if (likely(cmpval !=3D NULL)) {
-		u32 curval;
-
-		ret =3D futex_get_value_locked(&curval, uaddr1);
-
-		if (unlikely(ret)) {
-			double_unlock_hb(hb1, hb2);
-			futex_hb_waiters_dec(hb2);
-
-			ret =3D get_user(curval, uaddr1);
-			if (ret)
-				return ret;
-
-			if (!(flags & FLAGS_SHARED))
-				goto retry_private;
-
-			goto retry;
-		}
-		if (curval !=3D *cmpval) {
-			ret =3D -EAGAIN;
-			goto out_unlock;
-		}
-	}
-
-	if (requeue_pi) {
-		struct task_struct *exiting =3D NULL;
-
-		/*
-		 * Attempt to acquire uaddr2 and wake the top waiter. If we
-		 * intend to requeue waiters, force setting the FUTEX_WAITERS
-		 * bit.  We force this here where we are able to easily handle
-		 * faults rather in the requeue loop below.
-		 *
-		 * Updates topwaiter::requeue_state if a top waiter exists.
-		 */
-		ret =3D futex_proxy_trylock_atomic(uaddr2, hb1, hb2, &key1,
-						 &key2, &pi_state,
-						 &exiting, nr_requeue);
-
-		/*
-		 * At this point the top_waiter has either taken uaddr2 or
-		 * is waiting on it. In both cases pi_state has been
-		 * established and an initial refcount on it. In case of an
-		 * error there's nothing.
-		 *
-		 * The top waiter's requeue_state is up to date:
-		 *
-		 *  - If the lock was acquired atomically (ret =3D=3D 1), then
-		 *    the state is Q_REQUEUE_PI_LOCKED.
-		 *
-		 *    The top waiter has been dequeued and woken up and can
-		 *    return to user space immediately. The kernel/user
-		 *    space state is consistent. In case that there must be
-		 *    more waiters requeued the WAITERS bit in the user
-		 *    space futex is set so the top waiter task has to go
-		 *    into the syscall slowpath to unlock the futex. This
-		 *    will block until this requeue operation has been
-		 *    completed and the hash bucket locks have been
-		 *    dropped.
-		 *
-		 *  - If the trylock failed with an error (ret < 0) then
-		 *    the state is either Q_REQUEUE_PI_NONE, i.e. "nothing
-		 *    happened", or Q_REQUEUE_PI_IGNORE when there was an
-		 *    interleaved early wakeup.
-		 *
-		 *  - If the trylock did not succeed (ret =3D=3D 0) then the
-		 *    state is either Q_REQUEUE_PI_IN_PROGRESS or
-		 *    Q_REQUEUE_PI_WAIT if an early wakeup interleaved.
-		 *    This will be cleaned up in the loop below, which
-		 *    cannot fail because futex_proxy_trylock_atomic() did
-		 *    the same sanity checks for requeue_pi as the loop
-		 *    below does.
-		 */
-		switch (ret) {
-		case 0:
-			/* We hold a reference on the pi state. */
-			break;
-
-		case 1:
-			/*
-			 * futex_proxy_trylock_atomic() acquired the user space
-			 * futex. Adjust task_count.
-			 */
-			task_count++;
-			ret =3D 0;
-			break;
-
-		/*
-		 * If the above failed, then pi_state is NULL and
-		 * waiter::requeue_state is correct.
-		 */
-		case -EFAULT:
-			double_unlock_hb(hb1, hb2);
-			futex_hb_waiters_dec(hb2);
-			ret =3D fault_in_user_writeable(uaddr2);
-			if (!ret)
-				goto retry;
-			return ret;
-		case -EBUSY:
-		case -EAGAIN:
-			/*
-			 * Two reasons for this:
-			 * - EBUSY: Owner is exiting and we just wait for the
-			 *   exit to complete.
-			 * - EAGAIN: The user space value changed.
-			 */
-			double_unlock_hb(hb1, hb2);
-			futex_hb_waiters_dec(hb2);
-			/*
-			 * Handle the case where the owner is in the middle of
-			 * exiting. Wait for the exit to complete otherwise
-			 * this task might loop forever, aka. live lock.
-			 */
-			wait_for_owner_exiting(ret, exiting);
-			cond_resched();
-			goto retry;
-		default:
-			goto out_unlock;
-		}
-	}
-
-	plist_for_each_entry_safe(this, next, &hb1->chain, list) {
-		if (task_count - nr_wake >=3D nr_requeue)
-			break;
-
-		if (!futex_match(&this->key, &key1))
-			continue;
-
-		/*
-		 * FUTEX_WAIT_REQUEUE_PI and FUTEX_CMP_REQUEUE_PI should always
-		 * be paired with each other and no other futex ops.
-		 *
-		 * We should never be requeueing a futex_q with a pi_state,
-		 * which is awaiting a futex_unlock_pi().
-		 */
-		if ((requeue_pi && !this->rt_waiter) ||
-		    (!requeue_pi && this->rt_waiter) ||
-		    this->pi_state) {
-			ret =3D -EINVAL;
-			break;
-		}
-
-		/* Plain futexes just wake or requeue and are done */
-		if (!requeue_pi) {
-			if (++task_count <=3D nr_wake)
-				futex_wake_mark(&wake_q, this);
-			else
-				requeue_futex(this, hb1, hb2, &key2);
-			continue;
-		}
-
-		/* Ensure we requeue to the expected futex for requeue_pi. */
-		if (!futex_match(this->requeue_pi_key, &key2)) {
-			ret =3D -EINVAL;
-			break;
-		}
-
-		/*
-		 * Requeue nr_requeue waiters and possibly one more in the case
-		 * of requeue_pi if we couldn't acquire the lock atomically.
-		 *
-		 * Prepare the waiter to take the rt_mutex. Take a refcount
-		 * on the pi_state and store the pointer in the futex_q
-		 * object of the waiter.
-		 */
-		get_pi_state(pi_state);
-
-		/* Don't requeue when the waiter is already on the way out. */
-		if (!futex_requeue_pi_prepare(this, pi_state)) {
-			/*
-			 * Early woken waiter signaled that it is on the
-			 * way out. Drop the pi_state reference and try the
-			 * next waiter. @this->pi_state is still NULL.
-			 */
-			put_pi_state(pi_state);
-			continue;
-		}
-
-		ret =3D rt_mutex_start_proxy_lock(&pi_state->pi_mutex,
-						this->rt_waiter,
-						this->task);
-
-		if (ret =3D=3D 1) {
-			/*
-			 * We got the lock. We do neither drop the refcount
-			 * on pi_state nor clear this->pi_state because the
-			 * waiter needs the pi_state for cleaning up the
-			 * user space value. It will drop the refcount
-			 * after doing so. this::requeue_state is updated
-			 * in the wakeup as well.
-			 */
-			requeue_pi_wake_futex(this, &key2, hb2);
-			task_count++;
-		} else if (!ret) {
-			/* Waiter is queued, move it to hb2 */
-			requeue_futex(this, hb1, hb2, &key2);
-			futex_requeue_pi_complete(this, 0);
-			task_count++;
-		} else {
-			/*
-			 * rt_mutex_start_proxy_lock() detected a potential
-			 * deadlock when we tried to queue that waiter.
-			 * Drop the pi_state reference which we took above
-			 * and remove the pointer to the state from the
-			 * waiters futex_q object.
-			 */
-			this->pi_state =3D NULL;
-			put_pi_state(pi_state);
-			futex_requeue_pi_complete(this, ret);
-			/*
-			 * We stop queueing more waiters and let user space
-			 * deal with the mess.
-			 */
-			break;
-		}
-	}
-
-	/*
-	 * We took an extra initial reference to the pi_state in
-	 * futex_proxy_trylock_atomic(). We need to drop it here again.
-	 */
-	put_pi_state(pi_state);
-
-out_unlock:
-	double_unlock_hb(hb1, hb2);
-	wake_up_q(&wake_q);
-	futex_hb_waiters_dec(hb2);
-	return ret ? ret : task_count;
-}
-
 /* The key must be already stored in q->key. */
 struct futex_hash_bucket *futex_q_lock(struct futex_q *q)
 	__acquires(&hb->lock)
@@ -1718,8 +983,8 @@ static long futex_wait_restart(struct restart_block *res=
tart);
  * @q:		the futex_q to queue up on
  * @timeout:	the prepared hrtimer_sleeper, or null for no timeout
  */
-static void futex_wait_queue(struct futex_hash_bucket *hb, struct futex_q *q,
-				struct hrtimer_sleeper *timeout)
+void futex_wait_queue(struct futex_hash_bucket *hb, struct futex_q *q,
+			    struct hrtimer_sleeper *timeout)
 {
 	/*
 	 * The task state is guaranteed to be set before another task can
@@ -1766,8 +1031,8 @@ static void futex_wait_queue(struct futex_hash_bucket *=
hb, struct futex_q *q,
  *  -  0 - uaddr contains val and hb has been locked;
  *  - <1 - -EFAULT or -EWOULDBLOCK (uaddr does not contain val) and hb is un=
locked
  */
-static int futex_wait_setup(u32 __user *uaddr, u32 val, unsigned int flags,
-			   struct futex_q *q, struct futex_hash_bucket **hb)
+int futex_wait_setup(u32 __user *uaddr, u32 val, unsigned int flags,
+		     struct futex_q *q, struct futex_hash_bucket **hb)
 {
 	u32 uval;
 	int ret;
@@ -1900,225 +1165,6 @@ static long futex_wait_restart(struct restart_block *=
restart)
 }
=20
=20
-/**
- * handle_early_requeue_pi_wakeup() - Handle early wakeup on the initial fut=
ex
- * @hb:		the hash_bucket futex_q was original enqueued on
- * @q:		the futex_q woken while waiting to be requeued
- * @timeout:	the timeout associated with the wait (NULL if none)
- *
- * Determine the cause for the early wakeup.
- *
- * Return:
- *  -EWOULDBLOCK or -ETIMEDOUT or -ERESTARTNOINTR
- */
-static inline
-int handle_early_requeue_pi_wakeup(struct futex_hash_bucket *hb,
-				   struct futex_q *q,
-				   struct hrtimer_sleeper *timeout)
-{
-	int ret;
-
-	/*
-	 * With the hb lock held, we avoid races while we process the wakeup.
-	 * We only need to hold hb (and not hb2) to ensure atomicity as the
-	 * wakeup code can't change q.key from uaddr to uaddr2 if we hold hb.
-	 * It can't be requeued from uaddr2 to something else since we don't
-	 * support a PI aware source futex for requeue.
-	 */
-	WARN_ON_ONCE(&hb->lock !=3D q->lock_ptr);
-
-	/*
-	 * We were woken prior to requeue by a timeout or a signal.
-	 * Unqueue the futex_q and determine which it was.
-	 */
-	plist_del(&q->list, &hb->chain);
-	futex_hb_waiters_dec(hb);
-
-	/* Handle spurious wakeups gracefully */
-	ret =3D -EWOULDBLOCK;
-	if (timeout && !timeout->task)
-		ret =3D -ETIMEDOUT;
-	else if (signal_pending(current))
-		ret =3D -ERESTARTNOINTR;
-	return ret;
-}
-
-/**
- * futex_wait_requeue_pi() - Wait on uaddr and take uaddr2
- * @uaddr:	the futex we initially wait on (non-pi)
- * @flags:	futex flags (FLAGS_SHARED, FLAGS_CLOCKRT, etc.), they must be
- *		the same type, no requeueing from private to shared, etc.
- * @val:	the expected value of uaddr
- * @abs_time:	absolute timeout
- * @bitset:	32 bit wakeup bitset set by userspace, defaults to all
- * @uaddr2:	the pi futex we will take prior to returning to user-space
- *
- * The caller will wait on uaddr and will be requeued by futex_requeue() to
- * uaddr2 which must be PI aware and unique from uaddr.  Normal wakeup will =
wake
- * on uaddr2 and complete the acquisition of the rt_mutex prior to returning=
 to
- * userspace.  This ensures the rt_mutex maintains an owner when it has wait=
ers;
- * without one, the pi logic would not know which task to boost/deboost, if
- * there was a need to.
- *
- * We call schedule in futex_wait_queue() when we enqueue and return there
- * via the following--
- * 1) wakeup on uaddr2 after an atomic lock acquisition by futex_requeue()
- * 2) wakeup on uaddr2 after a requeue
- * 3) signal
- * 4) timeout
- *
- * If 3, cleanup and return -ERESTARTNOINTR.
- *
- * If 2, we may then block on trying to take the rt_mutex and return via:
- * 5) successful lock
- * 6) signal
- * 7) timeout
- * 8) other lock acquisition failure
- *
- * If 6, return -EWOULDBLOCK (restarting the syscall would do the same).
- *
- * If 4 or 7, we cleanup and return with -ETIMEDOUT.
- *
- * Return:
- *  -  0 - On success;
- *  - <0 - On error
- */
-int futex_wait_requeue_pi(u32 __user *uaddr, unsigned int flags,
-			  u32 val, ktime_t *abs_time, u32 bitset,
-			  u32 __user *uaddr2)
-{
-	struct hrtimer_sleeper timeout, *to;
-	struct rt_mutex_waiter rt_waiter;
-	struct futex_hash_bucket *hb;
-	union futex_key key2 =3D FUTEX_KEY_INIT;
-	struct futex_q q =3D futex_q_init;
-	struct rt_mutex_base *pi_mutex;
-	int res, ret;
-
-	if (!IS_ENABLED(CONFIG_FUTEX_PI))
-		return -ENOSYS;
-
-	if (uaddr =3D=3D uaddr2)
-		return -EINVAL;
-
-	if (!bitset)
-		return -EINVAL;
-
-	to =3D futex_setup_timer(abs_time, &timeout, flags,
-			       current->timer_slack_ns);
-
-	/*
-	 * The waiter is allocated on our stack, manipulated by the requeue
-	 * code while we sleep on uaddr.
-	 */
-	rt_mutex_init_waiter(&rt_waiter);
-
-	ret =3D get_futex_key(uaddr2, flags & FLAGS_SHARED, &key2, FUTEX_WRITE);
-	if (unlikely(ret !=3D 0))
-		goto out;
-
-	q.bitset =3D bitset;
-	q.rt_waiter =3D &rt_waiter;
-	q.requeue_pi_key =3D &key2;
-
-	/*
-	 * Prepare to wait on uaddr. On success, it holds hb->lock and q
-	 * is initialized.
-	 */
-	ret =3D futex_wait_setup(uaddr, val, flags, &q, &hb);
-	if (ret)
-		goto out;
-
-	/*
-	 * The check above which compares uaddrs is not sufficient for
-	 * shared futexes. We need to compare the keys:
-	 */
-	if (futex_match(&q.key, &key2)) {
-		futex_q_unlock(hb);
-		ret =3D -EINVAL;
-		goto out;
-	}
-
-	/* Queue the futex_q, drop the hb lock, wait for wakeup. */
-	futex_wait_queue(hb, &q, to);
-
-	switch (futex_requeue_pi_wakeup_sync(&q)) {
-	case Q_REQUEUE_PI_IGNORE:
-		/* The waiter is still on uaddr1 */
-		spin_lock(&hb->lock);
-		ret =3D handle_early_requeue_pi_wakeup(hb, &q, to);
-		spin_unlock(&hb->lock);
-		break;
-
-	case Q_REQUEUE_PI_LOCKED:
-		/* The requeue acquired the lock */
-		if (q.pi_state && (q.pi_state->owner !=3D current)) {
-			spin_lock(q.lock_ptr);
-			ret =3D fixup_pi_owner(uaddr2, &q, true);
-			/*
-			 * Drop the reference to the pi state which the
-			 * requeue_pi() code acquired for us.
-			 */
-			put_pi_state(q.pi_state);
-			spin_unlock(q.lock_ptr);
-			/*
-			 * Adjust the return value. It's either -EFAULT or
-			 * success (1) but the caller expects 0 for success.
-			 */
-			ret =3D ret < 0 ? ret : 0;
-		}
-		break;
-
-	case Q_REQUEUE_PI_DONE:
-		/* Requeue completed. Current is 'pi_blocked_on' the rtmutex */
-		pi_mutex =3D &q.pi_state->pi_mutex;
-		ret =3D rt_mutex_wait_proxy_lock(pi_mutex, to, &rt_waiter);
-
-		/* Current is not longer pi_blocked_on */
-		spin_lock(q.lock_ptr);
-		if (ret && !rt_mutex_cleanup_proxy_lock(pi_mutex, &rt_waiter))
-			ret =3D 0;
-
-		debug_rt_mutex_free_waiter(&rt_waiter);
-		/*
-		 * Fixup the pi_state owner and possibly acquire the lock if we
-		 * haven't already.
-		 */
-		res =3D fixup_pi_owner(uaddr2, &q, !ret);
-		/*
-		 * If fixup_pi_owner() returned an error, propagate that.  If it
-		 * acquired the lock, clear -ETIMEDOUT or -EINTR.
-		 */
-		if (res)
-			ret =3D (res < 0) ? res : 0;
-
-		futex_unqueue_pi(&q);
-		spin_unlock(q.lock_ptr);
-
-		if (ret =3D=3D -EINTR) {
-			/*
-			 * We've already been requeued, but cannot restart
-			 * by calling futex_lock_pi() directly. We could
-			 * restart this syscall, but it would detect that
-			 * the user space "val" changed and return
-			 * -EWOULDBLOCK.  Save the overhead of the restart
-			 * and return -EWOULDBLOCK directly.
-			 */
-			ret =3D -EWOULDBLOCK;
-		}
-		break;
-	default:
-		BUG();
-	}
-
-out:
-	if (to) {
-		hrtimer_cancel(&to->timer);
-		destroy_hrtimer_on_stack(&to->timer);
-	}
-	return ret;
-}
-
 /* Constants for the pending_op argument of handle_futex_death */
 #define HANDLE_DEATH_PENDING	true
 #define HANDLE_DEATH_LIST	false
diff --git a/kernel/futex/futex.h b/kernel/futex/futex.h
index 4969e96..840302a 100644
--- a/kernel/futex/futex.h
+++ b/kernel/futex/futex.h
@@ -3,6 +3,8 @@
 #define _FUTEX_H
=20
 #include <linux/futex.h>
+#include <linux/sched/wake_q.h>
+
 #include <asm/futex.h>
=20
 /*
@@ -118,22 +120,69 @@ enum futex_access {
 extern int get_futex_key(u32 __user *uaddr, bool fshared, union futex_key *k=
ey,
 			 enum futex_access rw);
=20
-extern struct futex_hash_bucket *futex_hash(union futex_key *key);
-
 extern struct hrtimer_sleeper *
 futex_setup_timer(ktime_t *time, struct hrtimer_sleeper *timeout,
 		  int flags, u64 range_ns);
=20
+extern struct futex_hash_bucket *futex_hash(union futex_key *key);
+
+/**
+ * futex_match - Check whether two futex keys are equal
+ * @key1:	Pointer to key1
+ * @key2:	Pointer to key2
+ *
+ * Return 1 if two futex_keys are equal, 0 otherwise.
+ */
+static inline int futex_match(union futex_key *key1, union futex_key *key2)
+{
+	return (key1 && key2
+		&& key1->both.word =3D=3D key2->both.word
+		&& key1->both.ptr =3D=3D key2->both.ptr
+		&& key1->both.offset =3D=3D key2->both.offset);
+}
+
+extern int futex_wait_setup(u32 __user *uaddr, u32 val, unsigned int flags,
+			    struct futex_q *q, struct futex_hash_bucket **hb);
+extern void futex_wait_queue(struct futex_hash_bucket *hb, struct futex_q *q,
+				   struct hrtimer_sleeper *timeout);
+extern void futex_wake_mark(struct wake_q_head *wake_q, struct futex_q *q);
+
 extern int fault_in_user_writeable(u32 __user *uaddr);
 extern int futex_cmpxchg_value_locked(u32 *curval, u32 __user *uaddr, u32 uv=
al, u32 newval);
 extern int futex_get_value_locked(u32 *dest, u32 __user *from);
 extern struct futex_q *futex_top_waiter(struct futex_hash_bucket *hb, union =
futex_key *key);
=20
+extern void __futex_unqueue(struct futex_q *q);
 extern void __futex_queue(struct futex_q *q, struct futex_hash_bucket *hb);
 extern void futex_unqueue_pi(struct futex_q *q);
=20
 extern void wait_for_owner_exiting(int ret, struct task_struct *exiting);
=20
+/*
+ * Reflects a new waiter being added to the waitqueue.
+ */
+static inline void futex_hb_waiters_inc(struct futex_hash_bucket *hb)
+{
+#ifdef CONFIG_SMP
+	atomic_inc(&hb->waiters);
+	/*
+	 * Full barrier (A), see the ordering comment above.
+	 */
+	smp_mb__after_atomic();
+#endif
+}
+
+/*
+ * Reflects a waiter being removed from the waitqueue by wakeup
+ * paths.
+ */
+static inline void futex_hb_waiters_dec(struct futex_hash_bucket *hb)
+{
+#ifdef CONFIG_SMP
+	atomic_dec(&hb->waiters);
+#endif
+}
+
 extern struct futex_hash_bucket *futex_q_lock(struct futex_q *q);
 extern void futex_q_unlock(struct futex_hash_bucket *hb);
=20
@@ -150,6 +199,30 @@ extern void get_pi_state(struct futex_pi_state *pi_state=
);
 extern void put_pi_state(struct futex_pi_state *pi_state);
 extern int fixup_pi_owner(u32 __user *uaddr, struct futex_q *q, int locked);
=20
+/*
+ * Express the locking dependencies for lockdep:
+ */
+static inline void
+double_lock_hb(struct futex_hash_bucket *hb1, struct futex_hash_bucket *hb2)
+{
+	if (hb1 <=3D hb2) {
+		spin_lock(&hb1->lock);
+		if (hb1 < hb2)
+			spin_lock_nested(&hb2->lock, SINGLE_DEPTH_NESTING);
+	} else { /* hb1 > hb2 */
+		spin_lock(&hb2->lock);
+		spin_lock_nested(&hb1->lock, SINGLE_DEPTH_NESTING);
+	}
+}
+
+static inline void
+double_unlock_hb(struct futex_hash_bucket *hb1, struct futex_hash_bucket *hb=
2)
+{
+	spin_unlock(&hb1->lock);
+	if (hb1 !=3D hb2)
+		spin_unlock(&hb2->lock);
+}
+
 /* syscalls */
=20
 extern int futex_wait_requeue_pi(u32 __user *uaddr, unsigned int flags, u32
diff --git a/kernel/futex/requeue.c b/kernel/futex/requeue.c
new file mode 100644
index 0000000..cba8b1a
--- /dev/null
+++ b/kernel/futex/requeue.c
@@ -0,0 +1,897 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+
+#include <linux/sched/signal.h>
+
+#include "futex.h"
+#include "../locking/rtmutex_common.h"
+
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
+	Q_REQUEUE_PI_NONE		=3D  0,
+	Q_REQUEUE_PI_IGNORE,
+	Q_REQUEUE_PI_IN_PROGRESS,
+	Q_REQUEUE_PI_WAIT,
+	Q_REQUEUE_PI_DONE,
+	Q_REQUEUE_PI_LOCKED,
+};
+
+const struct futex_q futex_q_init =3D {
+	/* list gets initialized in futex_queue()*/
+	.key		=3D FUTEX_KEY_INIT,
+	.bitset		=3D FUTEX_BITSET_MATCH_ANY,
+	.requeue_state	=3D ATOMIC_INIT(Q_REQUEUE_PI_NONE),
+};
+
+/**
+ * requeue_futex() - Requeue a futex_q from one hb to another
+ * @q:		the futex_q to requeue
+ * @hb1:	the source hash_bucket
+ * @hb2:	the target hash_bucket
+ * @key2:	the new key for the requeued futex_q
+ */
+static inline
+void requeue_futex(struct futex_q *q, struct futex_hash_bucket *hb1,
+		   struct futex_hash_bucket *hb2, union futex_key *key2)
+{
+
+	/*
+	 * If key1 and key2 hash to the same bucket, no need to
+	 * requeue.
+	 */
+	if (likely(&hb1->chain !=3D &hb2->chain)) {
+		plist_del(&q->list, &hb1->chain);
+		futex_hb_waiters_dec(hb1);
+		futex_hb_waiters_inc(hb2);
+		plist_add(&q->list, &hb2->chain);
+		q->lock_ptr =3D &hb2->lock;
+	}
+	q->key =3D *key2;
+}
+
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
+	old =3D atomic_read_acquire(&q->requeue_state);
+	do {
+		if (old =3D=3D Q_REQUEUE_PI_IGNORE)
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
+		if (old !=3D Q_REQUEUE_PI_NONE)
+			break;
+
+		new =3D Q_REQUEUE_PI_IN_PROGRESS;
+	} while (!atomic_try_cmpxchg(&q->requeue_state, &old, new));
+
+	q->pi_state =3D pi_state;
+	return true;
+}
+
+static inline void futex_requeue_pi_complete(struct futex_q *q, int locked)
+{
+	int old, new;
+
+	old =3D atomic_read_acquire(&q->requeue_state);
+	do {
+		if (old =3D=3D Q_REQUEUE_PI_IGNORE)
+			return;
+
+		if (locked >=3D 0) {
+			/* Requeue succeeded. Set DONE or LOCKED */
+			WARN_ON_ONCE(old !=3D Q_REQUEUE_PI_IN_PROGRESS &&
+				     old !=3D Q_REQUEUE_PI_WAIT);
+			new =3D Q_REQUEUE_PI_DONE + locked;
+		} else if (old =3D=3D Q_REQUEUE_PI_IN_PROGRESS) {
+			/* Deadlock, no early wakeup interleave */
+			new =3D Q_REQUEUE_PI_NONE;
+		} else {
+			/* Deadlock, early wakeup interleave. */
+			WARN_ON_ONCE(old !=3D Q_REQUEUE_PI_WAIT);
+			new =3D Q_REQUEUE_PI_IGNORE;
+		}
+	} while (!atomic_try_cmpxchg(&q->requeue_state, &old, new));
+
+#ifdef CONFIG_PREEMPT_RT
+	/* If the waiter interleaved with the requeue let it know */
+	if (unlikely(old =3D=3D Q_REQUEUE_PI_WAIT))
+		rcuwait_wake_up(&q->requeue_wait);
+#endif
+}
+
+static inline int futex_requeue_pi_wakeup_sync(struct futex_q *q)
+{
+	int old, new;
+
+	old =3D atomic_read_acquire(&q->requeue_state);
+	do {
+		/* Is requeue done already? */
+		if (old >=3D Q_REQUEUE_PI_DONE)
+			return old;
+
+		/*
+		 * If not done, then tell the requeue code to either ignore
+		 * the waiter or to wake it up once the requeue is done.
+		 */
+		new =3D Q_REQUEUE_PI_WAIT;
+		if (old =3D=3D Q_REQUEUE_PI_NONE)
+			new =3D Q_REQUEUE_PI_IGNORE;
+	} while (!atomic_try_cmpxchg(&q->requeue_state, &old, new));
+
+	/* If the requeue was in progress, wait for it to complete */
+	if (old =3D=3D Q_REQUEUE_PI_IN_PROGRESS) {
+#ifdef CONFIG_PREEMPT_RT
+		rcuwait_wait_event(&q->requeue_wait,
+				   atomic_read(&q->requeue_state) !=3D Q_REQUEUE_PI_WAIT,
+				   TASK_UNINTERRUPTIBLE);
+#else
+		(void)atomic_cond_read_relaxed(&q->requeue_state, VAL !=3D Q_REQUEUE_PI_WA=
IT);
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
+/**
+ * requeue_pi_wake_futex() - Wake a task that acquired the lock during reque=
ue
+ * @q:		the futex_q
+ * @key:	the key of the requeue target futex
+ * @hb:		the hash_bucket of the requeue target futex
+ *
+ * During futex_requeue, with requeue_pi=3D1, it is possible to acquire the
+ * target futex if it is uncontended or via a lock steal.
+ *
+ * 1) Set @q::key to the requeue target futex key so the waiter can detect
+ *    the wakeup on the right futex.
+ *
+ * 2) Dequeue @q from the hash bucket.
+ *
+ * 3) Set @q::rt_waiter to NULL so the woken up task can detect atomic lock
+ *    acquisition.
+ *
+ * 4) Set the q->lock_ptr to the requeue target hb->lock for the case that
+ *    the waiter has to fixup the pi state.
+ *
+ * 5) Complete the requeue state so the waiter can make progress. After
+ *    this point the waiter task can return from the syscall immediately in
+ *    case that the pi state does not have to be fixed up.
+ *
+ * 6) Wake the waiter task.
+ *
+ * Must be called with both q->lock_ptr and hb->lock held.
+ */
+static inline
+void requeue_pi_wake_futex(struct futex_q *q, union futex_key *key,
+			   struct futex_hash_bucket *hb)
+{
+	q->key =3D *key;
+
+	__futex_unqueue(q);
+
+	WARN_ON(!q->rt_waiter);
+	q->rt_waiter =3D NULL;
+
+	q->lock_ptr =3D &hb->lock;
+
+	/* Signal locked state to the waiter */
+	futex_requeue_pi_complete(q, 1);
+	wake_up_state(q->task, TASK_NORMAL);
+}
+
+/**
+ * futex_proxy_trylock_atomic() - Attempt an atomic lock for the top waiter
+ * @pifutex:		the user address of the to futex
+ * @hb1:		the from futex hash bucket, must be locked by the caller
+ * @hb2:		the to futex hash bucket, must be locked by the caller
+ * @key1:		the from futex key
+ * @key2:		the to futex key
+ * @ps:			address to store the pi_state pointer
+ * @exiting:		Pointer to store the task pointer of the owner task
+ *			which is in the middle of exiting
+ * @set_waiters:	force setting the FUTEX_WAITERS bit (1) or not (0)
+ *
+ * Try and get the lock on behalf of the top waiter if we can do it atomical=
ly.
+ * Wake the top waiter if we succeed.  If the caller specified set_waiters,
+ * then direct futex_lock_pi_atomic() to force setting the FUTEX_WAITERS bit.
+ * hb1 and hb2 must be held by the caller.
+ *
+ * @exiting is only set when the return value is -EBUSY. If so, this holds
+ * a refcount on the exiting task on return and the caller needs to drop it
+ * after waiting for the exit to complete.
+ *
+ * Return:
+ *  -  0 - failed to acquire the lock atomically;
+ *  - >0 - acquired the lock, return value is vpid of the top_waiter
+ *  - <0 - error
+ */
+static int
+futex_proxy_trylock_atomic(u32 __user *pifutex, struct futex_hash_bucket *hb=
1,
+			   struct futex_hash_bucket *hb2, union futex_key *key1,
+			   union futex_key *key2, struct futex_pi_state **ps,
+			   struct task_struct **exiting, int set_waiters)
+{
+	struct futex_q *top_waiter =3D NULL;
+	u32 curval;
+	int ret;
+
+	if (futex_get_value_locked(&curval, pifutex))
+		return -EFAULT;
+
+	if (unlikely(should_fail_futex(true)))
+		return -EFAULT;
+
+	/*
+	 * Find the top_waiter and determine if there are additional waiters.
+	 * If the caller intends to requeue more than 1 waiter to pifutex,
+	 * force futex_lock_pi_atomic() to set the FUTEX_WAITERS bit now,
+	 * as we have means to handle the possible fault.  If not, don't set
+	 * the bit unnecessarily as it will force the subsequent unlock to enter
+	 * the kernel.
+	 */
+	top_waiter =3D futex_top_waiter(hb1, key1);
+
+	/* There are no waiters, nothing for us to do. */
+	if (!top_waiter)
+		return 0;
+
+	/*
+	 * Ensure that this is a waiter sitting in futex_wait_requeue_pi()
+	 * and waiting on the 'waitqueue' futex which is always !PI.
+	 */
+	if (!top_waiter->rt_waiter || top_waiter->pi_state)
+		return -EINVAL;
+
+	/* Ensure we requeue to the expected futex. */
+	if (!futex_match(top_waiter->requeue_pi_key, key2))
+		return -EINVAL;
+
+	/* Ensure that this does not race against an early wakeup */
+	if (!futex_requeue_pi_prepare(top_waiter, NULL))
+		return -EAGAIN;
+
+	/*
+	 * Try to take the lock for top_waiter and set the FUTEX_WAITERS bit
+	 * in the contended case or if @set_waiters is true.
+	 *
+	 * In the contended case PI state is attached to the lock owner. If
+	 * the user space lock can be acquired then PI state is attached to
+	 * the new owner (@top_waiter->task) when @set_waiters is true.
+	 */
+	ret =3D futex_lock_pi_atomic(pifutex, hb2, key2, ps, top_waiter->task,
+				   exiting, set_waiters);
+	if (ret =3D=3D 1) {
+		/*
+		 * Lock was acquired in user space and PI state was
+		 * attached to @top_waiter->task. That means state is fully
+		 * consistent and the waiter can return to user space
+		 * immediately after the wakeup.
+		 */
+		requeue_pi_wake_futex(top_waiter, key2, hb2);
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
+	}
+	return ret;
+}
+
+/**
+ * futex_requeue() - Requeue waiters from uaddr1 to uaddr2
+ * @uaddr1:	source futex user address
+ * @flags:	futex flags (FLAGS_SHARED, etc.)
+ * @uaddr2:	target futex user address
+ * @nr_wake:	number of waiters to wake (must be 1 for requeue_pi)
+ * @nr_requeue:	number of waiters to requeue (0-INT_MAX)
+ * @cmpval:	@uaddr1 expected value (or %NULL)
+ * @requeue_pi:	if we are attempting to requeue from a non-pi futex to a
+ *		pi futex (pi to pi requeue is not supported)
+ *
+ * Requeue waiters on uaddr1 to uaddr2. In the requeue_pi case, try to acqui=
re
+ * uaddr2 atomically on behalf of the top waiter.
+ *
+ * Return:
+ *  - >=3D0 - on success, the number of tasks requeued or woken;
+ *  -  <0 - on error
+ */
+int futex_requeue(u32 __user *uaddr1, unsigned int flags, u32 __user *uaddr2,
+		  int nr_wake, int nr_requeue, u32 *cmpval, int requeue_pi)
+{
+	union futex_key key1 =3D FUTEX_KEY_INIT, key2 =3D FUTEX_KEY_INIT;
+	int task_count =3D 0, ret;
+	struct futex_pi_state *pi_state =3D NULL;
+	struct futex_hash_bucket *hb1, *hb2;
+	struct futex_q *this, *next;
+	DEFINE_WAKE_Q(wake_q);
+
+	if (nr_wake < 0 || nr_requeue < 0)
+		return -EINVAL;
+
+	/*
+	 * When PI not supported: return -ENOSYS if requeue_pi is true,
+	 * consequently the compiler knows requeue_pi is always false past
+	 * this point which will optimize away all the conditional code
+	 * further down.
+	 */
+	if (!IS_ENABLED(CONFIG_FUTEX_PI) && requeue_pi)
+		return -ENOSYS;
+
+	if (requeue_pi) {
+		/*
+		 * Requeue PI only works on two distinct uaddrs. This
+		 * check is only valid for private futexes. See below.
+		 */
+		if (uaddr1 =3D=3D uaddr2)
+			return -EINVAL;
+
+		/*
+		 * futex_requeue() allows the caller to define the number
+		 * of waiters to wake up via the @nr_wake argument. With
+		 * REQUEUE_PI, waking up more than one waiter is creating
+		 * more problems than it solves. Waking up a waiter makes
+		 * only sense if the PI futex @uaddr2 is uncontended as
+		 * this allows the requeue code to acquire the futex
+		 * @uaddr2 before waking the waiter. The waiter can then
+		 * return to user space without further action. A secondary
+		 * wakeup would just make the futex_wait_requeue_pi()
+		 * handling more complex, because that code would have to
+		 * look up pi_state and do more or less all the handling
+		 * which the requeue code has to do for the to be requeued
+		 * waiters. So restrict the number of waiters to wake to
+		 * one, and only wake it up when the PI futex is
+		 * uncontended. Otherwise requeue it and let the unlock of
+		 * the PI futex handle the wakeup.
+		 *
+		 * All REQUEUE_PI users, e.g. pthread_cond_signal() and
+		 * pthread_cond_broadcast() must use nr_wake=3D1.
+		 */
+		if (nr_wake !=3D 1)
+			return -EINVAL;
+
+		/*
+		 * requeue_pi requires a pi_state, try to allocate it now
+		 * without any locks in case it fails.
+		 */
+		if (refill_pi_state_cache())
+			return -ENOMEM;
+	}
+
+retry:
+	ret =3D get_futex_key(uaddr1, flags & FLAGS_SHARED, &key1, FUTEX_READ);
+	if (unlikely(ret !=3D 0))
+		return ret;
+	ret =3D get_futex_key(uaddr2, flags & FLAGS_SHARED, &key2,
+			    requeue_pi ? FUTEX_WRITE : FUTEX_READ);
+	if (unlikely(ret !=3D 0))
+		return ret;
+
+	/*
+	 * The check above which compares uaddrs is not sufficient for
+	 * shared futexes. We need to compare the keys:
+	 */
+	if (requeue_pi && futex_match(&key1, &key2))
+		return -EINVAL;
+
+	hb1 =3D futex_hash(&key1);
+	hb2 =3D futex_hash(&key2);
+
+retry_private:
+	futex_hb_waiters_inc(hb2);
+	double_lock_hb(hb1, hb2);
+
+	if (likely(cmpval !=3D NULL)) {
+		u32 curval;
+
+		ret =3D futex_get_value_locked(&curval, uaddr1);
+
+		if (unlikely(ret)) {
+			double_unlock_hb(hb1, hb2);
+			futex_hb_waiters_dec(hb2);
+
+			ret =3D get_user(curval, uaddr1);
+			if (ret)
+				return ret;
+
+			if (!(flags & FLAGS_SHARED))
+				goto retry_private;
+
+			goto retry;
+		}
+		if (curval !=3D *cmpval) {
+			ret =3D -EAGAIN;
+			goto out_unlock;
+		}
+	}
+
+	if (requeue_pi) {
+		struct task_struct *exiting =3D NULL;
+
+		/*
+		 * Attempt to acquire uaddr2 and wake the top waiter. If we
+		 * intend to requeue waiters, force setting the FUTEX_WAITERS
+		 * bit.  We force this here where we are able to easily handle
+		 * faults rather in the requeue loop below.
+		 *
+		 * Updates topwaiter::requeue_state if a top waiter exists.
+		 */
+		ret =3D futex_proxy_trylock_atomic(uaddr2, hb1, hb2, &key1,
+						 &key2, &pi_state,
+						 &exiting, nr_requeue);
+
+		/*
+		 * At this point the top_waiter has either taken uaddr2 or
+		 * is waiting on it. In both cases pi_state has been
+		 * established and an initial refcount on it. In case of an
+		 * error there's nothing.
+		 *
+		 * The top waiter's requeue_state is up to date:
+		 *
+		 *  - If the lock was acquired atomically (ret =3D=3D 1), then
+		 *    the state is Q_REQUEUE_PI_LOCKED.
+		 *
+		 *    The top waiter has been dequeued and woken up and can
+		 *    return to user space immediately. The kernel/user
+		 *    space state is consistent. In case that there must be
+		 *    more waiters requeued the WAITERS bit in the user
+		 *    space futex is set so the top waiter task has to go
+		 *    into the syscall slowpath to unlock the futex. This
+		 *    will block until this requeue operation has been
+		 *    completed and the hash bucket locks have been
+		 *    dropped.
+		 *
+		 *  - If the trylock failed with an error (ret < 0) then
+		 *    the state is either Q_REQUEUE_PI_NONE, i.e. "nothing
+		 *    happened", or Q_REQUEUE_PI_IGNORE when there was an
+		 *    interleaved early wakeup.
+		 *
+		 *  - If the trylock did not succeed (ret =3D=3D 0) then the
+		 *    state is either Q_REQUEUE_PI_IN_PROGRESS or
+		 *    Q_REQUEUE_PI_WAIT if an early wakeup interleaved.
+		 *    This will be cleaned up in the loop below, which
+		 *    cannot fail because futex_proxy_trylock_atomic() did
+		 *    the same sanity checks for requeue_pi as the loop
+		 *    below does.
+		 */
+		switch (ret) {
+		case 0:
+			/* We hold a reference on the pi state. */
+			break;
+
+		case 1:
+			/*
+			 * futex_proxy_trylock_atomic() acquired the user space
+			 * futex. Adjust task_count.
+			 */
+			task_count++;
+			ret =3D 0;
+			break;
+
+		/*
+		 * If the above failed, then pi_state is NULL and
+		 * waiter::requeue_state is correct.
+		 */
+		case -EFAULT:
+			double_unlock_hb(hb1, hb2);
+			futex_hb_waiters_dec(hb2);
+			ret =3D fault_in_user_writeable(uaddr2);
+			if (!ret)
+				goto retry;
+			return ret;
+		case -EBUSY:
+		case -EAGAIN:
+			/*
+			 * Two reasons for this:
+			 * - EBUSY: Owner is exiting and we just wait for the
+			 *   exit to complete.
+			 * - EAGAIN: The user space value changed.
+			 */
+			double_unlock_hb(hb1, hb2);
+			futex_hb_waiters_dec(hb2);
+			/*
+			 * Handle the case where the owner is in the middle of
+			 * exiting. Wait for the exit to complete otherwise
+			 * this task might loop forever, aka. live lock.
+			 */
+			wait_for_owner_exiting(ret, exiting);
+			cond_resched();
+			goto retry;
+		default:
+			goto out_unlock;
+		}
+	}
+
+	plist_for_each_entry_safe(this, next, &hb1->chain, list) {
+		if (task_count - nr_wake >=3D nr_requeue)
+			break;
+
+		if (!futex_match(&this->key, &key1))
+			continue;
+
+		/*
+		 * FUTEX_WAIT_REQUEUE_PI and FUTEX_CMP_REQUEUE_PI should always
+		 * be paired with each other and no other futex ops.
+		 *
+		 * We should never be requeueing a futex_q with a pi_state,
+		 * which is awaiting a futex_unlock_pi().
+		 */
+		if ((requeue_pi && !this->rt_waiter) ||
+		    (!requeue_pi && this->rt_waiter) ||
+		    this->pi_state) {
+			ret =3D -EINVAL;
+			break;
+		}
+
+		/* Plain futexes just wake or requeue and are done */
+		if (!requeue_pi) {
+			if (++task_count <=3D nr_wake)
+				futex_wake_mark(&wake_q, this);
+			else
+				requeue_futex(this, hb1, hb2, &key2);
+			continue;
+		}
+
+		/* Ensure we requeue to the expected futex for requeue_pi. */
+		if (!futex_match(this->requeue_pi_key, &key2)) {
+			ret =3D -EINVAL;
+			break;
+		}
+
+		/*
+		 * Requeue nr_requeue waiters and possibly one more in the case
+		 * of requeue_pi if we couldn't acquire the lock atomically.
+		 *
+		 * Prepare the waiter to take the rt_mutex. Take a refcount
+		 * on the pi_state and store the pointer in the futex_q
+		 * object of the waiter.
+		 */
+		get_pi_state(pi_state);
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
+		ret =3D rt_mutex_start_proxy_lock(&pi_state->pi_mutex,
+						this->rt_waiter,
+						this->task);
+
+		if (ret =3D=3D 1) {
+			/*
+			 * We got the lock. We do neither drop the refcount
+			 * on pi_state nor clear this->pi_state because the
+			 * waiter needs the pi_state for cleaning up the
+			 * user space value. It will drop the refcount
+			 * after doing so. this::requeue_state is updated
+			 * in the wakeup as well.
+			 */
+			requeue_pi_wake_futex(this, &key2, hb2);
+			task_count++;
+		} else if (!ret) {
+			/* Waiter is queued, move it to hb2 */
+			requeue_futex(this, hb1, hb2, &key2);
+			futex_requeue_pi_complete(this, 0);
+			task_count++;
+		} else {
+			/*
+			 * rt_mutex_start_proxy_lock() detected a potential
+			 * deadlock when we tried to queue that waiter.
+			 * Drop the pi_state reference which we took above
+			 * and remove the pointer to the state from the
+			 * waiters futex_q object.
+			 */
+			this->pi_state =3D NULL;
+			put_pi_state(pi_state);
+			futex_requeue_pi_complete(this, ret);
+			/*
+			 * We stop queueing more waiters and let user space
+			 * deal with the mess.
+			 */
+			break;
+		}
+	}
+
+	/*
+	 * We took an extra initial reference to the pi_state in
+	 * futex_proxy_trylock_atomic(). We need to drop it here again.
+	 */
+	put_pi_state(pi_state);
+
+out_unlock:
+	double_unlock_hb(hb1, hb2);
+	wake_up_q(&wake_q);
+	futex_hb_waiters_dec(hb2);
+	return ret ? ret : task_count;
+}
+
+/**
+ * handle_early_requeue_pi_wakeup() - Handle early wakeup on the initial fut=
ex
+ * @hb:		the hash_bucket futex_q was original enqueued on
+ * @q:		the futex_q woken while waiting to be requeued
+ * @timeout:	the timeout associated with the wait (NULL if none)
+ *
+ * Determine the cause for the early wakeup.
+ *
+ * Return:
+ *  -EWOULDBLOCK or -ETIMEDOUT or -ERESTARTNOINTR
+ */
+static inline
+int handle_early_requeue_pi_wakeup(struct futex_hash_bucket *hb,
+				   struct futex_q *q,
+				   struct hrtimer_sleeper *timeout)
+{
+	int ret;
+
+	/*
+	 * With the hb lock held, we avoid races while we process the wakeup.
+	 * We only need to hold hb (and not hb2) to ensure atomicity as the
+	 * wakeup code can't change q.key from uaddr to uaddr2 if we hold hb.
+	 * It can't be requeued from uaddr2 to something else since we don't
+	 * support a PI aware source futex for requeue.
+	 */
+	WARN_ON_ONCE(&hb->lock !=3D q->lock_ptr);
+
+	/*
+	 * We were woken prior to requeue by a timeout or a signal.
+	 * Unqueue the futex_q and determine which it was.
+	 */
+	plist_del(&q->list, &hb->chain);
+	futex_hb_waiters_dec(hb);
+
+	/* Handle spurious wakeups gracefully */
+	ret =3D -EWOULDBLOCK;
+	if (timeout && !timeout->task)
+		ret =3D -ETIMEDOUT;
+	else if (signal_pending(current))
+		ret =3D -ERESTARTNOINTR;
+	return ret;
+}
+
+/**
+ * futex_wait_requeue_pi() - Wait on uaddr and take uaddr2
+ * @uaddr:	the futex we initially wait on (non-pi)
+ * @flags:	futex flags (FLAGS_SHARED, FLAGS_CLOCKRT, etc.), they must be
+ *		the same type, no requeueing from private to shared, etc.
+ * @val:	the expected value of uaddr
+ * @abs_time:	absolute timeout
+ * @bitset:	32 bit wakeup bitset set by userspace, defaults to all
+ * @uaddr2:	the pi futex we will take prior to returning to user-space
+ *
+ * The caller will wait on uaddr and will be requeued by futex_requeue() to
+ * uaddr2 which must be PI aware and unique from uaddr.  Normal wakeup will =
wake
+ * on uaddr2 and complete the acquisition of the rt_mutex prior to returning=
 to
+ * userspace.  This ensures the rt_mutex maintains an owner when it has wait=
ers;
+ * without one, the pi logic would not know which task to boost/deboost, if
+ * there was a need to.
+ *
+ * We call schedule in futex_wait_queue() when we enqueue and return there
+ * via the following--
+ * 1) wakeup on uaddr2 after an atomic lock acquisition by futex_requeue()
+ * 2) wakeup on uaddr2 after a requeue
+ * 3) signal
+ * 4) timeout
+ *
+ * If 3, cleanup and return -ERESTARTNOINTR.
+ *
+ * If 2, we may then block on trying to take the rt_mutex and return via:
+ * 5) successful lock
+ * 6) signal
+ * 7) timeout
+ * 8) other lock acquisition failure
+ *
+ * If 6, return -EWOULDBLOCK (restarting the syscall would do the same).
+ *
+ * If 4 or 7, we cleanup and return with -ETIMEDOUT.
+ *
+ * Return:
+ *  -  0 - On success;
+ *  - <0 - On error
+ */
+int futex_wait_requeue_pi(u32 __user *uaddr, unsigned int flags,
+			  u32 val, ktime_t *abs_time, u32 bitset,
+			  u32 __user *uaddr2)
+{
+	struct hrtimer_sleeper timeout, *to;
+	struct rt_mutex_waiter rt_waiter;
+	struct futex_hash_bucket *hb;
+	union futex_key key2 =3D FUTEX_KEY_INIT;
+	struct futex_q q =3D futex_q_init;
+	struct rt_mutex_base *pi_mutex;
+	int res, ret;
+
+	if (!IS_ENABLED(CONFIG_FUTEX_PI))
+		return -ENOSYS;
+
+	if (uaddr =3D=3D uaddr2)
+		return -EINVAL;
+
+	if (!bitset)
+		return -EINVAL;
+
+	to =3D futex_setup_timer(abs_time, &timeout, flags,
+			       current->timer_slack_ns);
+
+	/*
+	 * The waiter is allocated on our stack, manipulated by the requeue
+	 * code while we sleep on uaddr.
+	 */
+	rt_mutex_init_waiter(&rt_waiter);
+
+	ret =3D get_futex_key(uaddr2, flags & FLAGS_SHARED, &key2, FUTEX_WRITE);
+	if (unlikely(ret !=3D 0))
+		goto out;
+
+	q.bitset =3D bitset;
+	q.rt_waiter =3D &rt_waiter;
+	q.requeue_pi_key =3D &key2;
+
+	/*
+	 * Prepare to wait on uaddr. On success, it holds hb->lock and q
+	 * is initialized.
+	 */
+	ret =3D futex_wait_setup(uaddr, val, flags, &q, &hb);
+	if (ret)
+		goto out;
+
+	/*
+	 * The check above which compares uaddrs is not sufficient for
+	 * shared futexes. We need to compare the keys:
+	 */
+	if (futex_match(&q.key, &key2)) {
+		futex_q_unlock(hb);
+		ret =3D -EINVAL;
+		goto out;
+	}
+
+	/* Queue the futex_q, drop the hb lock, wait for wakeup. */
+	futex_wait_queue(hb, &q, to);
+
+	switch (futex_requeue_pi_wakeup_sync(&q)) {
+	case Q_REQUEUE_PI_IGNORE:
+		/* The waiter is still on uaddr1 */
+		spin_lock(&hb->lock);
+		ret =3D handle_early_requeue_pi_wakeup(hb, &q, to);
+		spin_unlock(&hb->lock);
+		break;
+
+	case Q_REQUEUE_PI_LOCKED:
+		/* The requeue acquired the lock */
+		if (q.pi_state && (q.pi_state->owner !=3D current)) {
+			spin_lock(q.lock_ptr);
+			ret =3D fixup_pi_owner(uaddr2, &q, true);
+			/*
+			 * Drop the reference to the pi state which the
+			 * requeue_pi() code acquired for us.
+			 */
+			put_pi_state(q.pi_state);
+			spin_unlock(q.lock_ptr);
+			/*
+			 * Adjust the return value. It's either -EFAULT or
+			 * success (1) but the caller expects 0 for success.
+			 */
+			ret =3D ret < 0 ? ret : 0;
+		}
+		break;
+
+	case Q_REQUEUE_PI_DONE:
+		/* Requeue completed. Current is 'pi_blocked_on' the rtmutex */
+		pi_mutex =3D &q.pi_state->pi_mutex;
+		ret =3D rt_mutex_wait_proxy_lock(pi_mutex, to, &rt_waiter);
+
+		/* Current is not longer pi_blocked_on */
+		spin_lock(q.lock_ptr);
+		if (ret && !rt_mutex_cleanup_proxy_lock(pi_mutex, &rt_waiter))
+			ret =3D 0;
+
+		debug_rt_mutex_free_waiter(&rt_waiter);
+		/*
+		 * Fixup the pi_state owner and possibly acquire the lock if we
+		 * haven't already.
+		 */
+		res =3D fixup_pi_owner(uaddr2, &q, !ret);
+		/*
+		 * If fixup_pi_owner() returned an error, propagate that.  If it
+		 * acquired the lock, clear -ETIMEDOUT or -EINTR.
+		 */
+		if (res)
+			ret =3D (res < 0) ? res : 0;
+
+		futex_unqueue_pi(&q);
+		spin_unlock(q.lock_ptr);
+
+		if (ret =3D=3D -EINTR) {
+			/*
+			 * We've already been requeued, but cannot restart
+			 * by calling futex_lock_pi() directly. We could
+			 * restart this syscall, but it would detect that
+			 * the user space "val" changed and return
+			 * -EWOULDBLOCK.  Save the overhead of the restart
+			 * and return -EWOULDBLOCK directly.
+			 */
+			ret =3D -EWOULDBLOCK;
+		}
+		break;
+	default:
+		BUG();
+	}
+
+out:
+	if (to) {
+		hrtimer_cancel(&to->timer);
+		destroy_hrtimer_on_stack(&to->timer);
+	}
+	return ret;
+}
+
