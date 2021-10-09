Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A2BA4278B4
	for <lists+linux-tip-commits@lfdr.de>; Sat,  9 Oct 2021 12:07:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244568AbhJIKJI (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Sat, 9 Oct 2021 06:09:08 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:49360 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244485AbhJIKJE (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Sat, 9 Oct 2021 06:09:04 -0400
Date:   Sat, 09 Oct 2021 10:07:06 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1633774027;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zuK+Zoot9RvCOh6Krj7IRU3mNWtC9uG/CPHtsFk4AdI=;
        b=psbSwQRbk8BpHmg1G3Oxph7a76k8H0yKLT9WQfa0nOssJ15aDJGM8Fu+ikAqQt3IG4Ztm5
        GNaqPY+OpsAg8Z9GbqYfnclpxUej9fjFPBV/58uuNYv8J/R2+EkDhLL+aMEEJTSoWm4NhZ
        dPQHfL0T9/8IUkrucCJqORBmChbmgYsA8R6tOQPTa5WPRtLjboSCiRhepJYXxwEoIiYXj8
        vY0Zjc2ZrWxnpEnDr5UPeoYBsOzPDPJbhOtjPwkI+4vwZ8i/91dAc0UgzjPN0cXdIVl6VE
        cI1q0c+3iJ4CTYy+BSil/LRo+/8OaNc5oOCnxCcXEG2can+uauwb9PEznyR2OA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1633774027;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zuK+Zoot9RvCOh6Krj7IRU3mNWtC9uG/CPHtsFk4AdI=;
        b=lSbd/94PA/1PWYPvsu9fnT2yt86pT5iuy58AND47sclo88mE0J3j+adCyvlFjgsQvhAj0H
        ck6tGIr1Z3rw2uDw==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] futex: Split out wait/wake
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        andrealmeid@collabora.com, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210923171111.300673-15-andrealmeid@collabora.com>
References: <20210923171111.300673-15-andrealmeid@collabora.com>
MIME-Version: 1.0
Message-ID: <163377402646.25758.14437149990208998723.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     a046f1a0d3e320cfee6bdac336416a537f49e7c6
Gitweb:        https://git.kernel.org/tip/a046f1a0d3e320cfee6bdac336416a537f4=
9e7c6
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Thu, 23 Sep 2021 14:11:03 -03:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Thu, 07 Oct 2021 13:51:11 +02:00

futex: Split out wait/wake

Move the wait/wake bits into their own file.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Andr=C3=A9 Almeida <andrealmeid@collabora.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Andr=C3=A9 Almeida <andrealmeid@collabora.com>
Link: https://lore.kernel.org/r/20210923171111.300673-15-andrealmeid@collabor=
a.com
---
 kernel/futex/Makefile   |   2 +-
 kernel/futex/core.c     | 536 +---------------------------------------
 kernel/futex/futex.h    |  34 ++-
 kernel/futex/waitwake.c | 507 +++++++++++++++++++++++++++++++++++++-
 4 files changed, 543 insertions(+), 536 deletions(-)
 create mode 100644 kernel/futex/waitwake.c

diff --git a/kernel/futex/Makefile b/kernel/futex/Makefile
index c040941..b77188d 100644
--- a/kernel/futex/Makefile
+++ b/kernel/futex/Makefile
@@ -1,3 +1,3 @@
 # SPDX-License-Identifier: GPL-2.0
=20
-obj-y +=3D core.o syscalls.o pi.o requeue.o
+obj-y +=3D core.o syscalls.o pi.o requeue.o waitwake.o
diff --git a/kernel/futex/core.c b/kernel/futex/core.c
index 42f2735..25d8a88 100644
--- a/kernel/futex/core.c
+++ b/kernel/futex/core.c
@@ -34,7 +34,6 @@
 #include <linux/compat.h>
 #include <linux/jhash.h>
 #include <linux/pagemap.h>
-#include <linux/freezer.h>
 #include <linux/memblock.h>
 #include <linux/fault-inject.h>
 #include <linux/slab.h>
@@ -42,106 +41,6 @@
 #include "futex.h"
 #include "../locking/rtmutex_common.h"
=20
-/*
- * READ this before attempting to hack on futexes!
- *
- * Basic futex operation and ordering guarantees
- * =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
- *
- * The waiter reads the futex value in user space and calls
- * futex_wait(). This function computes the hash bucket and acquires
- * the hash bucket lock. After that it reads the futex user space value
- * again and verifies that the data has not changed. If it has not changed
- * it enqueues itself into the hash bucket, releases the hash bucket lock
- * and schedules.
- *
- * The waker side modifies the user space value of the futex and calls
- * futex_wake(). This function computes the hash bucket and acquires the
- * hash bucket lock. Then it looks for waiters on that futex in the hash
- * bucket and wakes them.
- *
- * In futex wake up scenarios where no tasks are blocked on a futex, taking
- * the hb spinlock can be avoided and simply return. In order for this
- * optimization to work, ordering guarantees must exist so that the waiter
- * being added to the list is acknowledged when the list is concurrently bei=
ng
- * checked by the waker, avoiding scenarios like the following:
- *
- * CPU 0                               CPU 1
- * val =3D *futex;
- * sys_futex(WAIT, futex, val);
- *   futex_wait(futex, val);
- *   uval =3D *futex;
- *                                     *futex =3D newval;
- *                                     sys_futex(WAKE, futex);
- *                                       futex_wake(futex);
- *                                       if (queue_empty())
- *                                         return;
- *   if (uval =3D=3D val)
- *      lock(hash_bucket(futex));
- *      queue();
- *     unlock(hash_bucket(futex));
- *     schedule();
- *
- * This would cause the waiter on CPU 0 to wait forever because it
- * missed the transition of the user space value from val to newval
- * and the waker did not find the waiter in the hash bucket queue.
- *
- * The correct serialization ensures that a waiter either observes
- * the changed user space value before blocking or is woken by a
- * concurrent waker:
- *
- * CPU 0                                 CPU 1
- * val =3D *futex;
- * sys_futex(WAIT, futex, val);
- *   futex_wait(futex, val);
- *
- *   waiters++; (a)
- *   smp_mb(); (A) <-- paired with -.
- *                                  |
- *   lock(hash_bucket(futex));      |
- *                                  |
- *   uval =3D *futex;                 |
- *                                  |        *futex =3D newval;
- *                                  |        sys_futex(WAKE, futex);
- *                                  |          futex_wake(futex);
- *                                  |
- *                                  `--------> smp_mb(); (B)
- *   if (uval =3D=3D val)
- *     queue();
- *     unlock(hash_bucket(futex));
- *     schedule();                         if (waiters)
- *                                           lock(hash_bucket(futex));
- *   else                                    wake_waiters(futex);
- *     waiters--; (b)                        unlock(hash_bucket(futex));
- *
- * Where (A) orders the waiters increment and the futex value read through
- * atomic operations (see futex_hb_waiters_inc) and where (B) orders the wri=
te
- * to futex and the waiters read (see futex_hb_waiters_pending()).
- *
- * This yields the following case (where X:=3Dwaiters, Y:=3Dfutex):
- *
- *	X =3D Y =3D 0
- *
- *	w[X]=3D1		w[Y]=3D1
- *	MB		MB
- *	r[Y]=3Dy		r[X]=3Dx
- *
- * Which guarantees that x=3D=3D0 && y=3D=3D0 is impossible; which translate=
s back into
- * the guarantee that we cannot both miss the futex variable change and the
- * enqueue.
- *
- * Note that a new waiter is accounted for in (a) even when it is possible t=
hat
- * the wait call can return error, in which case we backtrack from it in (b).
- * Refer to the comment in futex_q_lock().
- *
- * Similarly, in order to account for waiters being requeued on another
- * address we always increment the waiters for the destination bucket before
- * acquiring the lock. It then decrements them again  after releasing it -
- * the code that actually moves the futex(es) between hash buckets (requeue_=
futex)
- * will do the additional required waiter count housekeeping. This is done f=
or
- * double_lock_hb() and double_unlock_hb(), respectively.
- */
-
 #ifndef CONFIG_HAVE_FUTEX_CMPXCHG
 int  __read_mostly futex_cmpxchg_enabled;
 #endif
@@ -211,19 +110,6 @@ late_initcall(fail_futex_debugfs);
=20
 #endif /* CONFIG_FAIL_FUTEX */
=20
-static inline int futex_hb_waiters_pending(struct futex_hash_bucket *hb)
-{
-#ifdef CONFIG_SMP
-	/*
-	 * Full barrier (B), see the ordering comment above.
-	 */
-	smp_mb();
-	return atomic_read(&hb->waiters);
-#else
-	return 1;
-#endif
-}
-
 /**
  * futex_hash - Return the hash bucket in the global hash
  * @key:	Pointer to the futex key for which the hash is calculated
@@ -628,217 +514,6 @@ void __futex_unqueue(struct futex_q *q)
 	futex_hb_waiters_dec(hb);
 }
=20
-/*
- * The hash bucket lock must be held when this is called.
- * Afterwards, the futex_q must not be accessed. Callers
- * must ensure to later call wake_up_q() for the actual
- * wakeups to occur.
- */
-void futex_wake_mark(struct wake_q_head *wake_q, struct futex_q *q)
-{
-	struct task_struct *p =3D q->task;
-
-	if (WARN(q->pi_state || q->rt_waiter, "refusing to wake PI futex\n"))
-		return;
-
-	get_task_struct(p);
-	__futex_unqueue(q);
-	/*
-	 * The waiting task can free the futex_q as soon as q->lock_ptr =3D NULL
-	 * is written, without taking any locks. This is possible in the event
-	 * of a spurious wakeup, for example. A memory barrier is required here
-	 * to prevent the following store to lock_ptr from getting ahead of the
-	 * plist_del in __futex_unqueue().
-	 */
-	smp_store_release(&q->lock_ptr, NULL);
-
-	/*
-	 * Queue the task for later wakeup for after we've released
-	 * the hb->lock.
-	 */
-	wake_q_add_safe(wake_q, p);
-}
-
-/*
- * Wake up waiters matching bitset queued on this futex (uaddr).
- */
-int futex_wake(u32 __user *uaddr, unsigned int flags, int nr_wake, u32 bitse=
t)
-{
-	struct futex_hash_bucket *hb;
-	struct futex_q *this, *next;
-	union futex_key key =3D FUTEX_KEY_INIT;
-	int ret;
-	DEFINE_WAKE_Q(wake_q);
-
-	if (!bitset)
-		return -EINVAL;
-
-	ret =3D get_futex_key(uaddr, flags & FLAGS_SHARED, &key, FUTEX_READ);
-	if (unlikely(ret !=3D 0))
-		return ret;
-
-	hb =3D futex_hash(&key);
-
-	/* Make sure we really have tasks to wakeup */
-	if (!futex_hb_waiters_pending(hb))
-		return ret;
-
-	spin_lock(&hb->lock);
-
-	plist_for_each_entry_safe(this, next, &hb->chain, list) {
-		if (futex_match (&this->key, &key)) {
-			if (this->pi_state || this->rt_waiter) {
-				ret =3D -EINVAL;
-				break;
-			}
-
-			/* Check if one of the bits is set in both bitsets */
-			if (!(this->bitset & bitset))
-				continue;
-
-			futex_wake_mark(&wake_q, this);
-			if (++ret >=3D nr_wake)
-				break;
-		}
-	}
-
-	spin_unlock(&hb->lock);
-	wake_up_q(&wake_q);
-	return ret;
-}
-
-static int futex_atomic_op_inuser(unsigned int encoded_op, u32 __user *uaddr)
-{
-	unsigned int op =3D	  (encoded_op & 0x70000000) >> 28;
-	unsigned int cmp =3D	  (encoded_op & 0x0f000000) >> 24;
-	int oparg =3D sign_extend32((encoded_op & 0x00fff000) >> 12, 11);
-	int cmparg =3D sign_extend32(encoded_op & 0x00000fff, 11);
-	int oldval, ret;
-
-	if (encoded_op & (FUTEX_OP_OPARG_SHIFT << 28)) {
-		if (oparg < 0 || oparg > 31) {
-			char comm[sizeof(current->comm)];
-			/*
-			 * kill this print and return -EINVAL when userspace
-			 * is sane again
-			 */
-			pr_info_ratelimited("futex_wake_op: %s tries to shift op by %d; fix this =
program\n",
-					get_task_comm(comm, current), oparg);
-			oparg &=3D 31;
-		}
-		oparg =3D 1 << oparg;
-	}
-
-	pagefault_disable();
-	ret =3D arch_futex_atomic_op_inuser(op, oparg, &oldval, uaddr);
-	pagefault_enable();
-	if (ret)
-		return ret;
-
-	switch (cmp) {
-	case FUTEX_OP_CMP_EQ:
-		return oldval =3D=3D cmparg;
-	case FUTEX_OP_CMP_NE:
-		return oldval !=3D cmparg;
-	case FUTEX_OP_CMP_LT:
-		return oldval < cmparg;
-	case FUTEX_OP_CMP_GE:
-		return oldval >=3D cmparg;
-	case FUTEX_OP_CMP_LE:
-		return oldval <=3D cmparg;
-	case FUTEX_OP_CMP_GT:
-		return oldval > cmparg;
-	default:
-		return -ENOSYS;
-	}
-}
-
-/*
- * Wake up all waiters hashed on the physical page that is mapped
- * to this virtual address:
- */
-int futex_wake_op(u32 __user *uaddr1, unsigned int flags, u32 __user *uaddr2,
-		  int nr_wake, int nr_wake2, int op)
-{
-	union futex_key key1 =3D FUTEX_KEY_INIT, key2 =3D FUTEX_KEY_INIT;
-	struct futex_hash_bucket *hb1, *hb2;
-	struct futex_q *this, *next;
-	int ret, op_ret;
-	DEFINE_WAKE_Q(wake_q);
-
-retry:
-	ret =3D get_futex_key(uaddr1, flags & FLAGS_SHARED, &key1, FUTEX_READ);
-	if (unlikely(ret !=3D 0))
-		return ret;
-	ret =3D get_futex_key(uaddr2, flags & FLAGS_SHARED, &key2, FUTEX_WRITE);
-	if (unlikely(ret !=3D 0))
-		return ret;
-
-	hb1 =3D futex_hash(&key1);
-	hb2 =3D futex_hash(&key2);
-
-retry_private:
-	double_lock_hb(hb1, hb2);
-	op_ret =3D futex_atomic_op_inuser(op, uaddr2);
-	if (unlikely(op_ret < 0)) {
-		double_unlock_hb(hb1, hb2);
-
-		if (!IS_ENABLED(CONFIG_MMU) ||
-		    unlikely(op_ret !=3D -EFAULT && op_ret !=3D -EAGAIN)) {
-			/*
-			 * we don't get EFAULT from MMU faults if we don't have
-			 * an MMU, but we might get them from range checking
-			 */
-			ret =3D op_ret;
-			return ret;
-		}
-
-		if (op_ret =3D=3D -EFAULT) {
-			ret =3D fault_in_user_writeable(uaddr2);
-			if (ret)
-				return ret;
-		}
-
-		cond_resched();
-		if (!(flags & FLAGS_SHARED))
-			goto retry_private;
-		goto retry;
-	}
-
-	plist_for_each_entry_safe(this, next, &hb1->chain, list) {
-		if (futex_match (&this->key, &key1)) {
-			if (this->pi_state || this->rt_waiter) {
-				ret =3D -EINVAL;
-				goto out_unlock;
-			}
-			futex_wake_mark(&wake_q, this);
-			if (++ret >=3D nr_wake)
-				break;
-		}
-	}
-
-	if (op_ret > 0) {
-		op_ret =3D 0;
-		plist_for_each_entry_safe(this, next, &hb2->chain, list) {
-			if (futex_match (&this->key, &key2)) {
-				if (this->pi_state || this->rt_waiter) {
-					ret =3D -EINVAL;
-					goto out_unlock;
-				}
-				futex_wake_mark(&wake_q, this);
-				if (++op_ret >=3D nr_wake2)
-					break;
-			}
-		}
-		ret +=3D op_ret;
-	}
-
-out_unlock:
-	double_unlock_hb(hb1, hb2);
-	wake_up_q(&wake_q);
-	return ret;
-}
-
 /* The key must be already stored in q->key. */
 struct futex_hash_bucket *futex_q_lock(struct futex_q *q)
 	__acquires(&hb->lock)
@@ -890,25 +565,6 @@ void __futex_queue(struct futex_q *q, struct futex_hash_=
bucket *hb)
 }
=20
 /**
- * futex_queue() - Enqueue the futex_q on the futex_hash_bucket
- * @q:	The futex_q to enqueue
- * @hb:	The destination hash bucket
- *
- * The hb->lock must be held by the caller, and is released here. A call to
- * futex_queue() is typically paired with exactly one call to futex_unqueue(=
).  The
- * exceptions involve the PI related operations, which may use futex_unqueue=
_pi()
- * or nothing if the unqueue is done as part of the wake process and the unq=
ueue
- * state is implicit in the state of woken task (see futex_wait_requeue_pi()=
 for
- * an example).
- */
-static inline void futex_queue(struct futex_q *q, struct futex_hash_bucket *=
hb)
-	__releases(&hb->lock)
-{
-	__futex_queue(q, hb);
-	spin_unlock(&hb->lock);
-}
-
-/**
  * futex_unqueue() - Remove the futex_q from its futex_hash_bucket
  * @q:	The futex_q to unqueue
  *
@@ -919,7 +575,7 @@ static inline void futex_queue(struct futex_q *q, struct =
futex_hash_bucket *hb)
  *  - 1 - if the futex_q was still queued (and we removed unqueued it);
  *  - 0 - if the futex_q was already removed by the waking thread
  */
-static int futex_unqueue(struct futex_q *q)
+int futex_unqueue(struct futex_q *q)
 {
 	spinlock_t *lock_ptr;
 	int ret =3D 0;
@@ -975,196 +631,6 @@ void futex_unqueue_pi(struct futex_q *q)
 	q->pi_state =3D NULL;
 }
=20
-static long futex_wait_restart(struct restart_block *restart);
-
-/**
- * futex_wait_queue() - futex_queue() and wait for wakeup, timeout, or signal
- * @hb:		the futex hash bucket, must be locked by the caller
- * @q:		the futex_q to queue up on
- * @timeout:	the prepared hrtimer_sleeper, or null for no timeout
- */
-void futex_wait_queue(struct futex_hash_bucket *hb, struct futex_q *q,
-			    struct hrtimer_sleeper *timeout)
-{
-	/*
-	 * The task state is guaranteed to be set before another task can
-	 * wake it. set_current_state() is implemented using smp_store_mb() and
-	 * futex_queue() calls spin_unlock() upon completion, both serializing
-	 * access to the hash list and forcing another memory barrier.
-	 */
-	set_current_state(TASK_INTERRUPTIBLE);
-	futex_queue(q, hb);
-
-	/* Arm the timer */
-	if (timeout)
-		hrtimer_sleeper_start_expires(timeout, HRTIMER_MODE_ABS);
-
-	/*
-	 * If we have been removed from the hash list, then another task
-	 * has tried to wake us, and we can skip the call to schedule().
-	 */
-	if (likely(!plist_node_empty(&q->list))) {
-		/*
-		 * If the timer has already expired, current will already be
-		 * flagged for rescheduling. Only call schedule if there
-		 * is no timeout, or if it has yet to expire.
-		 */
-		if (!timeout || timeout->task)
-			freezable_schedule();
-	}
-	__set_current_state(TASK_RUNNING);
-}
-
-/**
- * futex_wait_setup() - Prepare to wait on a futex
- * @uaddr:	the futex userspace address
- * @val:	the expected value
- * @flags:	futex flags (FLAGS_SHARED, etc.)
- * @q:		the associated futex_q
- * @hb:		storage for hash_bucket pointer to be returned to caller
- *
- * Setup the futex_q and locate the hash_bucket.  Get the futex value and
- * compare it with the expected value.  Handle atomic faults internally.
- * Return with the hb lock held on success, and unlocked on failure.
- *
- * Return:
- *  -  0 - uaddr contains val and hb has been locked;
- *  - <1 - -EFAULT or -EWOULDBLOCK (uaddr does not contain val) and hb is un=
locked
- */
-int futex_wait_setup(u32 __user *uaddr, u32 val, unsigned int flags,
-		     struct futex_q *q, struct futex_hash_bucket **hb)
-{
-	u32 uval;
-	int ret;
-
-	/*
-	 * Access the page AFTER the hash-bucket is locked.
-	 * Order is important:
-	 *
-	 *   Userspace waiter: val =3D var; if (cond(val)) futex_wait(&var, val);
-	 *   Userspace waker:  if (cond(var)) { var =3D new; futex_wake(&var); }
-	 *
-	 * The basic logical guarantee of a futex is that it blocks ONLY
-	 * if cond(var) is known to be true at the time of blocking, for
-	 * any cond.  If we locked the hash-bucket after testing *uaddr, that
-	 * would open a race condition where we could block indefinitely with
-	 * cond(var) false, which would violate the guarantee.
-	 *
-	 * On the other hand, we insert q and release the hash-bucket only
-	 * after testing *uaddr.  This guarantees that futex_wait() will NOT
-	 * absorb a wakeup if *uaddr does not match the desired values
-	 * while the syscall executes.
-	 */
-retry:
-	ret =3D get_futex_key(uaddr, flags & FLAGS_SHARED, &q->key, FUTEX_READ);
-	if (unlikely(ret !=3D 0))
-		return ret;
-
-retry_private:
-	*hb =3D futex_q_lock(q);
-
-	ret =3D futex_get_value_locked(&uval, uaddr);
-
-	if (ret) {
-		futex_q_unlock(*hb);
-
-		ret =3D get_user(uval, uaddr);
-		if (ret)
-			return ret;
-
-		if (!(flags & FLAGS_SHARED))
-			goto retry_private;
-
-		goto retry;
-	}
-
-	if (uval !=3D val) {
-		futex_q_unlock(*hb);
-		ret =3D -EWOULDBLOCK;
-	}
-
-	return ret;
-}
-
-int futex_wait(u32 __user *uaddr, unsigned int flags, u32 val, ktime_t *abs_=
time, u32 bitset)
-{
-	struct hrtimer_sleeper timeout, *to;
-	struct restart_block *restart;
-	struct futex_hash_bucket *hb;
-	struct futex_q q =3D futex_q_init;
-	int ret;
-
-	if (!bitset)
-		return -EINVAL;
-	q.bitset =3D bitset;
-
-	to =3D futex_setup_timer(abs_time, &timeout, flags,
-			       current->timer_slack_ns);
-retry:
-	/*
-	 * Prepare to wait on uaddr. On success, it holds hb->lock and q
-	 * is initialized.
-	 */
-	ret =3D futex_wait_setup(uaddr, val, flags, &q, &hb);
-	if (ret)
-		goto out;
-
-	/* futex_queue and wait for wakeup, timeout, or a signal. */
-	futex_wait_queue(hb, &q, to);
-
-	/* If we were woken (and unqueued), we succeeded, whatever. */
-	ret =3D 0;
-	if (!futex_unqueue(&q))
-		goto out;
-	ret =3D -ETIMEDOUT;
-	if (to && !to->task)
-		goto out;
-
-	/*
-	 * We expect signal_pending(current), but we might be the
-	 * victim of a spurious wakeup as well.
-	 */
-	if (!signal_pending(current))
-		goto retry;
-
-	ret =3D -ERESTARTSYS;
-	if (!abs_time)
-		goto out;
-
-	restart =3D &current->restart_block;
-	restart->futex.uaddr =3D uaddr;
-	restart->futex.val =3D val;
-	restart->futex.time =3D *abs_time;
-	restart->futex.bitset =3D bitset;
-	restart->futex.flags =3D flags | FLAGS_HAS_TIMEOUT;
-
-	ret =3D set_restart_fn(restart, futex_wait_restart);
-
-out:
-	if (to) {
-		hrtimer_cancel(&to->timer);
-		destroy_hrtimer_on_stack(&to->timer);
-	}
-	return ret;
-}
-
-
-static long futex_wait_restart(struct restart_block *restart)
-{
-	u32 __user *uaddr =3D restart->futex.uaddr;
-	ktime_t t, *tp =3D NULL;
-
-	if (restart->futex.flags & FLAGS_HAS_TIMEOUT) {
-		t =3D restart->futex.time;
-		tp =3D &t;
-	}
-	restart->fn =3D do_no_restart_syscall;
-
-	return (long)futex_wait(uaddr, restart->futex.flags,
-				restart->futex.val, tp, restart->futex.bitset);
-}
-
-
 /* Constants for the pending_op argument of handle_futex_death */
 #define HANDLE_DEATH_PENDING	true
 #define HANDLE_DEATH_LIST	false
diff --git a/kernel/futex/futex.h b/kernel/futex/futex.h
index 840302a..fe847f5 100644
--- a/kernel/futex/futex.h
+++ b/kernel/futex/futex.h
@@ -154,6 +154,27 @@ extern struct futex_q *futex_top_waiter(struct futex_has=
h_bucket *hb, union fute
=20
 extern void __futex_unqueue(struct futex_q *q);
 extern void __futex_queue(struct futex_q *q, struct futex_hash_bucket *hb);
+extern int futex_unqueue(struct futex_q *q);
+
+/**
+ * futex_queue() - Enqueue the futex_q on the futex_hash_bucket
+ * @q:	The futex_q to enqueue
+ * @hb:	The destination hash bucket
+ *
+ * The hb->lock must be held by the caller, and is released here. A call to
+ * futex_queue() is typically paired with exactly one call to futex_unqueue(=
).  The
+ * exceptions involve the PI related operations, which may use futex_unqueue=
_pi()
+ * or nothing if the unqueue is done as part of the wake process and the unq=
ueue
+ * state is implicit in the state of woken task (see futex_wait_requeue_pi()=
 for
+ * an example).
+ */
+static inline void futex_queue(struct futex_q *q, struct futex_hash_bucket *=
hb)
+	__releases(&hb->lock)
+{
+	__futex_queue(q, hb);
+	spin_unlock(&hb->lock);
+}
+
 extern void futex_unqueue_pi(struct futex_q *q);
=20
 extern void wait_for_owner_exiting(int ret, struct task_struct *exiting);
@@ -183,6 +204,19 @@ static inline void futex_hb_waiters_dec(struct futex_has=
h_bucket *hb)
 #endif
 }
=20
+static inline int futex_hb_waiters_pending(struct futex_hash_bucket *hb)
+{
+#ifdef CONFIG_SMP
+	/*
+	 * Full barrier (B), see the ordering comment above.
+	 */
+	smp_mb();
+	return atomic_read(&hb->waiters);
+#else
+	return 1;
+#endif
+}
+
 extern struct futex_hash_bucket *futex_q_lock(struct futex_q *q);
 extern void futex_q_unlock(struct futex_hash_bucket *hb);
=20
diff --git a/kernel/futex/waitwake.c b/kernel/futex/waitwake.c
new file mode 100644
index 0000000..3688078
--- /dev/null
+++ b/kernel/futex/waitwake.c
@@ -0,0 +1,507 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+
+#include <linux/sched/task.h>
+#include <linux/sched/signal.h>
+#include <linux/freezer.h>
+
+#include "futex.h"
+
+/*
+ * READ this before attempting to hack on futexes!
+ *
+ * Basic futex operation and ordering guarantees
+ * =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+ *
+ * The waiter reads the futex value in user space and calls
+ * futex_wait(). This function computes the hash bucket and acquires
+ * the hash bucket lock. After that it reads the futex user space value
+ * again and verifies that the data has not changed. If it has not changed
+ * it enqueues itself into the hash bucket, releases the hash bucket lock
+ * and schedules.
+ *
+ * The waker side modifies the user space value of the futex and calls
+ * futex_wake(). This function computes the hash bucket and acquires the
+ * hash bucket lock. Then it looks for waiters on that futex in the hash
+ * bucket and wakes them.
+ *
+ * In futex wake up scenarios where no tasks are blocked on a futex, taking
+ * the hb spinlock can be avoided and simply return. In order for this
+ * optimization to work, ordering guarantees must exist so that the waiter
+ * being added to the list is acknowledged when the list is concurrently bei=
ng
+ * checked by the waker, avoiding scenarios like the following:
+ *
+ * CPU 0                               CPU 1
+ * val =3D *futex;
+ * sys_futex(WAIT, futex, val);
+ *   futex_wait(futex, val);
+ *   uval =3D *futex;
+ *                                     *futex =3D newval;
+ *                                     sys_futex(WAKE, futex);
+ *                                       futex_wake(futex);
+ *                                       if (queue_empty())
+ *                                         return;
+ *   if (uval =3D=3D val)
+ *      lock(hash_bucket(futex));
+ *      queue();
+ *     unlock(hash_bucket(futex));
+ *     schedule();
+ *
+ * This would cause the waiter on CPU 0 to wait forever because it
+ * missed the transition of the user space value from val to newval
+ * and the waker did not find the waiter in the hash bucket queue.
+ *
+ * The correct serialization ensures that a waiter either observes
+ * the changed user space value before blocking or is woken by a
+ * concurrent waker:
+ *
+ * CPU 0                                 CPU 1
+ * val =3D *futex;
+ * sys_futex(WAIT, futex, val);
+ *   futex_wait(futex, val);
+ *
+ *   waiters++; (a)
+ *   smp_mb(); (A) <-- paired with -.
+ *                                  |
+ *   lock(hash_bucket(futex));      |
+ *                                  |
+ *   uval =3D *futex;                 |
+ *                                  |        *futex =3D newval;
+ *                                  |        sys_futex(WAKE, futex);
+ *                                  |          futex_wake(futex);
+ *                                  |
+ *                                  `--------> smp_mb(); (B)
+ *   if (uval =3D=3D val)
+ *     queue();
+ *     unlock(hash_bucket(futex));
+ *     schedule();                         if (waiters)
+ *                                           lock(hash_bucket(futex));
+ *   else                                    wake_waiters(futex);
+ *     waiters--; (b)                        unlock(hash_bucket(futex));
+ *
+ * Where (A) orders the waiters increment and the futex value read through
+ * atomic operations (see futex_hb_waiters_inc) and where (B) orders the wri=
te
+ * to futex and the waiters read (see futex_hb_waiters_pending()).
+ *
+ * This yields the following case (where X:=3Dwaiters, Y:=3Dfutex):
+ *
+ *	X =3D Y =3D 0
+ *
+ *	w[X]=3D1		w[Y]=3D1
+ *	MB		MB
+ *	r[Y]=3Dy		r[X]=3Dx
+ *
+ * Which guarantees that x=3D=3D0 && y=3D=3D0 is impossible; which translate=
s back into
+ * the guarantee that we cannot both miss the futex variable change and the
+ * enqueue.
+ *
+ * Note that a new waiter is accounted for in (a) even when it is possible t=
hat
+ * the wait call can return error, in which case we backtrack from it in (b).
+ * Refer to the comment in futex_q_lock().
+ *
+ * Similarly, in order to account for waiters being requeued on another
+ * address we always increment the waiters for the destination bucket before
+ * acquiring the lock. It then decrements them again  after releasing it -
+ * the code that actually moves the futex(es) between hash buckets (requeue_=
futex)
+ * will do the additional required waiter count housekeeping. This is done f=
or
+ * double_lock_hb() and double_unlock_hb(), respectively.
+ */
+
+/*
+ * The hash bucket lock must be held when this is called.
+ * Afterwards, the futex_q must not be accessed. Callers
+ * must ensure to later call wake_up_q() for the actual
+ * wakeups to occur.
+ */
+void futex_wake_mark(struct wake_q_head *wake_q, struct futex_q *q)
+{
+	struct task_struct *p =3D q->task;
+
+	if (WARN(q->pi_state || q->rt_waiter, "refusing to wake PI futex\n"))
+		return;
+
+	get_task_struct(p);
+	__futex_unqueue(q);
+	/*
+	 * The waiting task can free the futex_q as soon as q->lock_ptr =3D NULL
+	 * is written, without taking any locks. This is possible in the event
+	 * of a spurious wakeup, for example. A memory barrier is required here
+	 * to prevent the following store to lock_ptr from getting ahead of the
+	 * plist_del in __futex_unqueue().
+	 */
+	smp_store_release(&q->lock_ptr, NULL);
+
+	/*
+	 * Queue the task for later wakeup for after we've released
+	 * the hb->lock.
+	 */
+	wake_q_add_safe(wake_q, p);
+}
+
+/*
+ * Wake up waiters matching bitset queued on this futex (uaddr).
+ */
+int futex_wake(u32 __user *uaddr, unsigned int flags, int nr_wake, u32 bitse=
t)
+{
+	struct futex_hash_bucket *hb;
+	struct futex_q *this, *next;
+	union futex_key key =3D FUTEX_KEY_INIT;
+	int ret;
+	DEFINE_WAKE_Q(wake_q);
+
+	if (!bitset)
+		return -EINVAL;
+
+	ret =3D get_futex_key(uaddr, flags & FLAGS_SHARED, &key, FUTEX_READ);
+	if (unlikely(ret !=3D 0))
+		return ret;
+
+	hb =3D futex_hash(&key);
+
+	/* Make sure we really have tasks to wakeup */
+	if (!futex_hb_waiters_pending(hb))
+		return ret;
+
+	spin_lock(&hb->lock);
+
+	plist_for_each_entry_safe(this, next, &hb->chain, list) {
+		if (futex_match (&this->key, &key)) {
+			if (this->pi_state || this->rt_waiter) {
+				ret =3D -EINVAL;
+				break;
+			}
+
+			/* Check if one of the bits is set in both bitsets */
+			if (!(this->bitset & bitset))
+				continue;
+
+			futex_wake_mark(&wake_q, this);
+			if (++ret >=3D nr_wake)
+				break;
+		}
+	}
+
+	spin_unlock(&hb->lock);
+	wake_up_q(&wake_q);
+	return ret;
+}
+
+static int futex_atomic_op_inuser(unsigned int encoded_op, u32 __user *uaddr)
+{
+	unsigned int op =3D	  (encoded_op & 0x70000000) >> 28;
+	unsigned int cmp =3D	  (encoded_op & 0x0f000000) >> 24;
+	int oparg =3D sign_extend32((encoded_op & 0x00fff000) >> 12, 11);
+	int cmparg =3D sign_extend32(encoded_op & 0x00000fff, 11);
+	int oldval, ret;
+
+	if (encoded_op & (FUTEX_OP_OPARG_SHIFT << 28)) {
+		if (oparg < 0 || oparg > 31) {
+			char comm[sizeof(current->comm)];
+			/*
+			 * kill this print and return -EINVAL when userspace
+			 * is sane again
+			 */
+			pr_info_ratelimited("futex_wake_op: %s tries to shift op by %d; fix this =
program\n",
+					get_task_comm(comm, current), oparg);
+			oparg &=3D 31;
+		}
+		oparg =3D 1 << oparg;
+	}
+
+	pagefault_disable();
+	ret =3D arch_futex_atomic_op_inuser(op, oparg, &oldval, uaddr);
+	pagefault_enable();
+	if (ret)
+		return ret;
+
+	switch (cmp) {
+	case FUTEX_OP_CMP_EQ:
+		return oldval =3D=3D cmparg;
+	case FUTEX_OP_CMP_NE:
+		return oldval !=3D cmparg;
+	case FUTEX_OP_CMP_LT:
+		return oldval < cmparg;
+	case FUTEX_OP_CMP_GE:
+		return oldval >=3D cmparg;
+	case FUTEX_OP_CMP_LE:
+		return oldval <=3D cmparg;
+	case FUTEX_OP_CMP_GT:
+		return oldval > cmparg;
+	default:
+		return -ENOSYS;
+	}
+}
+
+/*
+ * Wake up all waiters hashed on the physical page that is mapped
+ * to this virtual address:
+ */
+int futex_wake_op(u32 __user *uaddr1, unsigned int flags, u32 __user *uaddr2,
+		  int nr_wake, int nr_wake2, int op)
+{
+	union futex_key key1 =3D FUTEX_KEY_INIT, key2 =3D FUTEX_KEY_INIT;
+	struct futex_hash_bucket *hb1, *hb2;
+	struct futex_q *this, *next;
+	int ret, op_ret;
+	DEFINE_WAKE_Q(wake_q);
+
+retry:
+	ret =3D get_futex_key(uaddr1, flags & FLAGS_SHARED, &key1, FUTEX_READ);
+	if (unlikely(ret !=3D 0))
+		return ret;
+	ret =3D get_futex_key(uaddr2, flags & FLAGS_SHARED, &key2, FUTEX_WRITE);
+	if (unlikely(ret !=3D 0))
+		return ret;
+
+	hb1 =3D futex_hash(&key1);
+	hb2 =3D futex_hash(&key2);
+
+retry_private:
+	double_lock_hb(hb1, hb2);
+	op_ret =3D futex_atomic_op_inuser(op, uaddr2);
+	if (unlikely(op_ret < 0)) {
+		double_unlock_hb(hb1, hb2);
+
+		if (!IS_ENABLED(CONFIG_MMU) ||
+		    unlikely(op_ret !=3D -EFAULT && op_ret !=3D -EAGAIN)) {
+			/*
+			 * we don't get EFAULT from MMU faults if we don't have
+			 * an MMU, but we might get them from range checking
+			 */
+			ret =3D op_ret;
+			return ret;
+		}
+
+		if (op_ret =3D=3D -EFAULT) {
+			ret =3D fault_in_user_writeable(uaddr2);
+			if (ret)
+				return ret;
+		}
+
+		cond_resched();
+		if (!(flags & FLAGS_SHARED))
+			goto retry_private;
+		goto retry;
+	}
+
+	plist_for_each_entry_safe(this, next, &hb1->chain, list) {
+		if (futex_match (&this->key, &key1)) {
+			if (this->pi_state || this->rt_waiter) {
+				ret =3D -EINVAL;
+				goto out_unlock;
+			}
+			futex_wake_mark(&wake_q, this);
+			if (++ret >=3D nr_wake)
+				break;
+		}
+	}
+
+	if (op_ret > 0) {
+		op_ret =3D 0;
+		plist_for_each_entry_safe(this, next, &hb2->chain, list) {
+			if (futex_match (&this->key, &key2)) {
+				if (this->pi_state || this->rt_waiter) {
+					ret =3D -EINVAL;
+					goto out_unlock;
+				}
+				futex_wake_mark(&wake_q, this);
+				if (++op_ret >=3D nr_wake2)
+					break;
+			}
+		}
+		ret +=3D op_ret;
+	}
+
+out_unlock:
+	double_unlock_hb(hb1, hb2);
+	wake_up_q(&wake_q);
+	return ret;
+}
+
+static long futex_wait_restart(struct restart_block *restart);
+
+/**
+ * futex_wait_queue() - futex_queue() and wait for wakeup, timeout, or signal
+ * @hb:		the futex hash bucket, must be locked by the caller
+ * @q:		the futex_q to queue up on
+ * @timeout:	the prepared hrtimer_sleeper, or null for no timeout
+ */
+void futex_wait_queue(struct futex_hash_bucket *hb, struct futex_q *q,
+			    struct hrtimer_sleeper *timeout)
+{
+	/*
+	 * The task state is guaranteed to be set before another task can
+	 * wake it. set_current_state() is implemented using smp_store_mb() and
+	 * futex_queue() calls spin_unlock() upon completion, both serializing
+	 * access to the hash list and forcing another memory barrier.
+	 */
+	set_current_state(TASK_INTERRUPTIBLE);
+	futex_queue(q, hb);
+
+	/* Arm the timer */
+	if (timeout)
+		hrtimer_sleeper_start_expires(timeout, HRTIMER_MODE_ABS);
+
+	/*
+	 * If we have been removed from the hash list, then another task
+	 * has tried to wake us, and we can skip the call to schedule().
+	 */
+	if (likely(!plist_node_empty(&q->list))) {
+		/*
+		 * If the timer has already expired, current will already be
+		 * flagged for rescheduling. Only call schedule if there
+		 * is no timeout, or if it has yet to expire.
+		 */
+		if (!timeout || timeout->task)
+			freezable_schedule();
+	}
+	__set_current_state(TASK_RUNNING);
+}
+
+/**
+ * futex_wait_setup() - Prepare to wait on a futex
+ * @uaddr:	the futex userspace address
+ * @val:	the expected value
+ * @flags:	futex flags (FLAGS_SHARED, etc.)
+ * @q:		the associated futex_q
+ * @hb:		storage for hash_bucket pointer to be returned to caller
+ *
+ * Setup the futex_q and locate the hash_bucket.  Get the futex value and
+ * compare it with the expected value.  Handle atomic faults internally.
+ * Return with the hb lock held on success, and unlocked on failure.
+ *
+ * Return:
+ *  -  0 - uaddr contains val and hb has been locked;
+ *  - <1 - -EFAULT or -EWOULDBLOCK (uaddr does not contain val) and hb is un=
locked
+ */
+int futex_wait_setup(u32 __user *uaddr, u32 val, unsigned int flags,
+		     struct futex_q *q, struct futex_hash_bucket **hb)
+{
+	u32 uval;
+	int ret;
+
+	/*
+	 * Access the page AFTER the hash-bucket is locked.
+	 * Order is important:
+	 *
+	 *   Userspace waiter: val =3D var; if (cond(val)) futex_wait(&var, val);
+	 *   Userspace waker:  if (cond(var)) { var =3D new; futex_wake(&var); }
+	 *
+	 * The basic logical guarantee of a futex is that it blocks ONLY
+	 * if cond(var) is known to be true at the time of blocking, for
+	 * any cond.  If we locked the hash-bucket after testing *uaddr, that
+	 * would open a race condition where we could block indefinitely with
+	 * cond(var) false, which would violate the guarantee.
+	 *
+	 * On the other hand, we insert q and release the hash-bucket only
+	 * after testing *uaddr.  This guarantees that futex_wait() will NOT
+	 * absorb a wakeup if *uaddr does not match the desired values
+	 * while the syscall executes.
+	 */
+retry:
+	ret =3D get_futex_key(uaddr, flags & FLAGS_SHARED, &q->key, FUTEX_READ);
+	if (unlikely(ret !=3D 0))
+		return ret;
+
+retry_private:
+	*hb =3D futex_q_lock(q);
+
+	ret =3D futex_get_value_locked(&uval, uaddr);
+
+	if (ret) {
+		futex_q_unlock(*hb);
+
+		ret =3D get_user(uval, uaddr);
+		if (ret)
+			return ret;
+
+		if (!(flags & FLAGS_SHARED))
+			goto retry_private;
+
+		goto retry;
+	}
+
+	if (uval !=3D val) {
+		futex_q_unlock(*hb);
+		ret =3D -EWOULDBLOCK;
+	}
+
+	return ret;
+}
+
+int futex_wait(u32 __user *uaddr, unsigned int flags, u32 val, ktime_t *abs_=
time, u32 bitset)
+{
+	struct hrtimer_sleeper timeout, *to;
+	struct restart_block *restart;
+	struct futex_hash_bucket *hb;
+	struct futex_q q =3D futex_q_init;
+	int ret;
+
+	if (!bitset)
+		return -EINVAL;
+	q.bitset =3D bitset;
+
+	to =3D futex_setup_timer(abs_time, &timeout, flags,
+			       current->timer_slack_ns);
+retry:
+	/*
+	 * Prepare to wait on uaddr. On success, it holds hb->lock and q
+	 * is initialized.
+	 */
+	ret =3D futex_wait_setup(uaddr, val, flags, &q, &hb);
+	if (ret)
+		goto out;
+
+	/* futex_queue and wait for wakeup, timeout, or a signal. */
+	futex_wait_queue(hb, &q, to);
+
+	/* If we were woken (and unqueued), we succeeded, whatever. */
+	ret =3D 0;
+	if (!futex_unqueue(&q))
+		goto out;
+	ret =3D -ETIMEDOUT;
+	if (to && !to->task)
+		goto out;
+
+	/*
+	 * We expect signal_pending(current), but we might be the
+	 * victim of a spurious wakeup as well.
+	 */
+	if (!signal_pending(current))
+		goto retry;
+
+	ret =3D -ERESTARTSYS;
+	if (!abs_time)
+		goto out;
+
+	restart =3D &current->restart_block;
+	restart->futex.uaddr =3D uaddr;
+	restart->futex.val =3D val;
+	restart->futex.time =3D *abs_time;
+	restart->futex.bitset =3D bitset;
+	restart->futex.flags =3D flags | FLAGS_HAS_TIMEOUT;
+
+	ret =3D set_restart_fn(restart, futex_wait_restart);
+
+out:
+	if (to) {
+		hrtimer_cancel(&to->timer);
+		destroy_hrtimer_on_stack(&to->timer);
+	}
+	return ret;
+}
+
+static long futex_wait_restart(struct restart_block *restart)
+{
+	u32 __user *uaddr =3D restart->futex.uaddr;
+	ktime_t t, *tp =3D NULL;
+
+	if (restart->futex.flags & FLAGS_HAS_TIMEOUT) {
+		t =3D restart->futex.time;
+		tp =3D &t;
+	}
+	restart->fn =3D do_no_restart_syscall;
+
+	return (long)futex_wait(uaddr, restart->futex.flags,
+				restart->futex.val, tp, restart->futex.bitset);
+}
+
