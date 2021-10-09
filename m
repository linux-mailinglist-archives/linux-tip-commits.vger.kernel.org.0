Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 93F044278B8
	for <lists+linux-tip-commits@lfdr.de>; Sat,  9 Oct 2021 12:07:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244608AbhJIKJK (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Sat, 9 Oct 2021 06:09:10 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:49360 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244562AbhJIKJJ (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Sat, 9 Oct 2021 06:09:09 -0400
Date:   Sat, 09 Oct 2021 10:07:11 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1633774032;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Yh6IZjXqlWvcpA8nU/rXsPANrkuJwbNKkSaCJq9OFP4=;
        b=zI1q1Xha2k3WpaYWzDdm8ou3DHy6mlXQLM/vHBhbY2wWij6eYCDvlvO9vFzXjaxkBvsz+R
        mIOCnv9RTjTR602i+W795STDUZRp2n03LJ2OTR2jX+C/dvKqPzFGg0Gee2mSJnqtpPE9FD
        eWOpXM9nCbEzeOFfBwvn1nT/BcoE3pTgTB+r/YYPiD6doT58rMxXrx9gcnNfKrtvf5lGxh
        OYMxy+ihzVV61Enu+1FtpHx8MjT2Bd4g9TIQ3veUtgh1YNXJBm7w+S4qOWmlrn6JmhO2Tv
        Lvl0UrwZRuu8yN0QIDvQbCV6qedE1mIMRWHTDH3DUr5f5n3DHd+SMDxKZCHlqw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1633774032;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Yh6IZjXqlWvcpA8nU/rXsPANrkuJwbNKkSaCJq9OFP4=;
        b=y97GlDwCSsGnP/Enp88x8MC8+Qqw3r1Qfb7v03DUmAOwAbso3Wz11TOb3PKLlx5SymVWWG
        zuY3QI+jTd2NExDw==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] futex: Split out PI futex
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        andrealmeid@collabora.com, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210923171111.300673-10-andrealmeid@collabora.com>
References: <20210923171111.300673-10-andrealmeid@collabora.com>
MIME-Version: 1.0
Message-ID: <163377403113.25758.12252491465057263494.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     85dc28fa4ec058645c29bda952d901b29dfaa0b0
Gitweb:        https://git.kernel.org/tip/85dc28fa4ec058645c29bda952d901b29df=
aa0b0
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Thu, 23 Sep 2021 14:10:58 -03:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Thu, 07 Oct 2021 13:51:09 +02:00

futex: Split out PI futex

Move the PI futex implementation into it's own file.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Andr=C3=A9 Almeida <andrealmeid@collabora.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Andr=C3=A9 Almeida <andrealmeid@collabora.com>
Link: https://lore.kernel.org/r/20210923171111.300673-10-andrealmeid@collabor=
a.com
---
 kernel/futex/Makefile |    2 +-
 kernel/futex/core.c   | 1508 ++--------------------------------------
 kernel/futex/futex.h  |  117 +++-
 kernel/futex/pi.c     | 1233 +++++++++++++++++++++++++++++++++-
 4 files changed, 1452 insertions(+), 1408 deletions(-)
 create mode 100644 kernel/futex/pi.c

diff --git a/kernel/futex/Makefile b/kernel/futex/Makefile
index ff9a960..27b71c2 100644
--- a/kernel/futex/Makefile
+++ b/kernel/futex/Makefile
@@ -1,3 +1,3 @@
 # SPDX-License-Identifier: GPL-2.0
=20
-obj-y +=3D core.o syscalls.o
+obj-y +=3D core.o syscalls.o pi.o
diff --git a/kernel/futex/core.c b/kernel/futex/core.c
index 0e10aee..a8ca5b5 100644
--- a/kernel/futex/core.c
+++ b/kernel/futex/core.c
@@ -148,67 +148,6 @@ int  __read_mostly futex_cmpxchg_enabled;
=20
=20
 /*
- * Priority Inheritance state:
- */
-struct futex_pi_state {
-	/*
-	 * list of 'owned' pi_state instances - these have to be
-	 * cleaned up in do_exit() if the task exits prematurely:
-	 */
-	struct list_head list;
-
-	/*
-	 * The PI object:
-	 */
-	struct rt_mutex_base pi_mutex;
-
-	struct task_struct *owner;
-	refcount_t refcount;
-
-	union futex_key key;
-} __randomize_layout;
-
-/**
- * struct futex_q - The hashed futex queue entry, one per waiting task
- * @list:		priority-sorted list of tasks waiting on this futex
- * @task:		the task waiting on the futex
- * @lock_ptr:		the hash bucket lock
- * @key:		the key the futex is hashed on
- * @pi_state:		optional priority inheritance state
- * @rt_waiter:		rt_waiter storage for use with requeue_pi
- * @requeue_pi_key:	the requeue_pi target futex key
- * @bitset:		bitset for the optional bitmasked wakeup
- * @requeue_state:	State field for futex_requeue_pi()
- * @requeue_wait:	RCU wait for futex_requeue_pi() (RT only)
- *
- * We use this hashed waitqueue, instead of a normal wait_queue_entry_t, so
- * we can wake only the relevant ones (hashed queues may be shared).
- *
- * A futex_q has a woken state, just like tasks have TASK_RUNNING.
- * It is considered woken when plist_node_empty(&q->list) || q->lock_ptr =3D=
=3D 0.
- * The order of wakeup is always to make the first condition true, then
- * the second.
- *
- * PI futexes are typically woken before they are removed from the hash list=
 via
- * the rt_mutex code. See futex_unqueue_pi().
- */
-struct futex_q {
-	struct plist_node list;
-
-	struct task_struct *task;
-	spinlock_t *lock_ptr;
-	union futex_key key;
-	struct futex_pi_state *pi_state;
-	struct rt_mutex_waiter *rt_waiter;
-	union futex_key *requeue_pi_key;
-	u32 bitset;
-	atomic_t requeue_state;
-#ifdef CONFIG_PREEMPT_RT
-	struct rcuwait requeue_wait;
-#endif
-} __randomize_layout;
-
-/*
  * On PREEMPT_RT, the hash bucket lock is a 'sleeping' spinlock with an
  * underlying rtmutex. The task which is about to be requeued could have
  * just woken up (timeout, signal). After the wake up the task has to
@@ -259,7 +198,7 @@ enum {
 	Q_REQUEUE_PI_LOCKED,
 };
=20
-static const struct futex_q futex_q_init =3D {
+const struct futex_q futex_q_init =3D {
 	/* list gets initialized in futex_queue()*/
 	.key		=3D FUTEX_KEY_INIT,
 	.bitset		=3D FUTEX_BITSET_MATCH_ANY,
@@ -267,17 +206,6 @@ static const struct futex_q futex_q_init =3D {
 };
=20
 /*
- * Hash buckets are shared by all the futex_keys that hash to the same
- * location.  Each key may have multiple futex_q structures, one for each ta=
sk
- * waiting on a futex.
- */
-struct futex_hash_bucket {
-	atomic_t waiters;
-	spinlock_t lock;
-	struct plist_head chain;
-} ____cacheline_aligned_in_smp;
-
-/*
  * The base of the bucket array and its size are always used together
  * (after initialization only in futex_hash()), so ensure that they
  * reside in the same cacheline.
@@ -386,7 +314,7 @@ static inline int hb_waiters_pending(struct futex_hash_bu=
cket *hb)
  * We hash on the keys returned from get_futex_key (see below) and return the
  * corresponding hash bucket in the global hash.
  */
-static struct futex_hash_bucket *futex_hash(union futex_key *key)
+struct futex_hash_bucket *futex_hash(union futex_key *key)
 {
 	u32 hash =3D jhash2((u32 *)key, offsetof(typeof(*key), both.offset) / 4,
 			  key->both.offset);
@@ -410,11 +338,6 @@ static inline int match_futex(union futex_key *key1, uni=
on futex_key *key2)
 		&& key1->both.offset =3D=3D key2->both.offset);
 }
=20
-enum futex_access {
-	FUTEX_READ,
-	FUTEX_WRITE
-};
-
 /**
  * futex_setup_timer - set up the sleeping hrtimer.
  * @time:	ptr to the given timeout value
@@ -425,7 +348,7 @@ enum futex_access {
  * Return: Initialized hrtimer_sleeper structure or NULL if no timeout
  *	   value given
  */
-static inline struct hrtimer_sleeper *
+struct hrtimer_sleeper *
 futex_setup_timer(ktime_t *time, struct hrtimer_sleeper *timeout,
 		  int flags, u64 range_ns)
 {
@@ -511,8 +434,8 @@ static u64 get_inode_sequence_number(struct inode *inode)
  *
  * lock_page() might sleep, the caller should not hold a spinlock.
  */
-static int get_futex_key(u32 __user *uaddr, bool fshared, union futex_key *k=
ey,
-			 enum futex_access rw)
+int get_futex_key(u32 __user *uaddr, bool fshared, union futex_key *key,
+		  enum futex_access rw)
 {
 	unsigned long address =3D (unsigned long)uaddr;
 	struct mm_struct *mm =3D current->mm;
@@ -700,7 +623,7 @@ out:
  * disabled section so we can as well avoid the #PF overhead by
  * calling get_user_pages() right away.
  */
-static int fault_in_user_writeable(u32 __user *uaddr)
+int fault_in_user_writeable(u32 __user *uaddr)
 {
 	struct mm_struct *mm =3D current->mm;
 	int ret;
@@ -720,8 +643,7 @@ static int fault_in_user_writeable(u32 __user *uaddr)
  *
  * Must be called with the hb lock held.
  */
-static struct futex_q *futex_top_waiter(struct futex_hash_bucket *hb,
-					union futex_key *key)
+struct futex_q *futex_top_waiter(struct futex_hash_bucket *hb, union futex_k=
ey *key)
 {
 	struct futex_q *this;
=20
@@ -732,8 +654,7 @@ static struct futex_q *futex_top_waiter(struct futex_hash=
_bucket *hb,
 	return NULL;
 }
=20
-static int futex_cmpxchg_value_locked(u32 *curval, u32 __user *uaddr,
-				      u32 uval, u32 newval)
+int futex_cmpxchg_value_locked(u32 *curval, u32 __user *uaddr, u32 uval, u32=
 newval)
 {
 	int ret;
=20
@@ -744,7 +665,7 @@ static int futex_cmpxchg_value_locked(u32 *curval, u32 __=
user *uaddr,
 	return ret;
 }
=20
-static int futex_get_value_locked(u32 *dest, u32 __user *from)
+int futex_get_value_locked(u32 *dest, u32 __user *from)
 {
 	int ret;
=20
@@ -755,399 +676,6 @@ static int futex_get_value_locked(u32 *dest, u32 __user=
 *from)
 	return ret ? -EFAULT : 0;
 }
=20
-
-/*
- * PI code:
- */
-static int refill_pi_state_cache(void)
-{
-	struct futex_pi_state *pi_state;
-
-	if (likely(current->pi_state_cache))
-		return 0;
-
-	pi_state =3D kzalloc(sizeof(*pi_state), GFP_KERNEL);
-
-	if (!pi_state)
-		return -ENOMEM;
-
-	INIT_LIST_HEAD(&pi_state->list);
-	/* pi_mutex gets initialized later */
-	pi_state->owner =3D NULL;
-	refcount_set(&pi_state->refcount, 1);
-	pi_state->key =3D FUTEX_KEY_INIT;
-
-	current->pi_state_cache =3D pi_state;
-
-	return 0;
-}
-
-static struct futex_pi_state *alloc_pi_state(void)
-{
-	struct futex_pi_state *pi_state =3D current->pi_state_cache;
-
-	WARN_ON(!pi_state);
-	current->pi_state_cache =3D NULL;
-
-	return pi_state;
-}
-
-static void pi_state_update_owner(struct futex_pi_state *pi_state,
-				  struct task_struct *new_owner)
-{
-	struct task_struct *old_owner =3D pi_state->owner;
-
-	lockdep_assert_held(&pi_state->pi_mutex.wait_lock);
-
-	if (old_owner) {
-		raw_spin_lock(&old_owner->pi_lock);
-		WARN_ON(list_empty(&pi_state->list));
-		list_del_init(&pi_state->list);
-		raw_spin_unlock(&old_owner->pi_lock);
-	}
-
-	if (new_owner) {
-		raw_spin_lock(&new_owner->pi_lock);
-		WARN_ON(!list_empty(&pi_state->list));
-		list_add(&pi_state->list, &new_owner->pi_state_list);
-		pi_state->owner =3D new_owner;
-		raw_spin_unlock(&new_owner->pi_lock);
-	}
-}
-
-static void get_pi_state(struct futex_pi_state *pi_state)
-{
-	WARN_ON_ONCE(!refcount_inc_not_zero(&pi_state->refcount));
-}
-
-/*
- * Drops a reference to the pi_state object and frees or caches it
- * when the last reference is gone.
- */
-static void put_pi_state(struct futex_pi_state *pi_state)
-{
-	if (!pi_state)
-		return;
-
-	if (!refcount_dec_and_test(&pi_state->refcount))
-		return;
-
-	/*
-	 * If pi_state->owner is NULL, the owner is most probably dying
-	 * and has cleaned up the pi_state already
-	 */
-	if (pi_state->owner) {
-		unsigned long flags;
-
-		raw_spin_lock_irqsave(&pi_state->pi_mutex.wait_lock, flags);
-		pi_state_update_owner(pi_state, NULL);
-		rt_mutex_proxy_unlock(&pi_state->pi_mutex);
-		raw_spin_unlock_irqrestore(&pi_state->pi_mutex.wait_lock, flags);
-	}
-
-	if (current->pi_state_cache) {
-		kfree(pi_state);
-	} else {
-		/*
-		 * pi_state->list is already empty.
-		 * clear pi_state->owner.
-		 * refcount is at 0 - put it back to 1.
-		 */
-		pi_state->owner =3D NULL;
-		refcount_set(&pi_state->refcount, 1);
-		current->pi_state_cache =3D pi_state;
-	}
-}
-
-#ifdef CONFIG_FUTEX_PI
-
-/*
- * This task is holding PI mutexes at exit time =3D> bad.
- * Kernel cleans up PI-state, but userspace is likely hosed.
- * (Robust-futex cleanup is separate and might save the day for userspace.)
- */
-static void exit_pi_state_list(struct task_struct *curr)
-{
-	struct list_head *next, *head =3D &curr->pi_state_list;
-	struct futex_pi_state *pi_state;
-	struct futex_hash_bucket *hb;
-	union futex_key key =3D FUTEX_KEY_INIT;
-
-	if (!futex_cmpxchg_enabled)
-		return;
-	/*
-	 * We are a ZOMBIE and nobody can enqueue itself on
-	 * pi_state_list anymore, but we have to be careful
-	 * versus waiters unqueueing themselves:
-	 */
-	raw_spin_lock_irq(&curr->pi_lock);
-	while (!list_empty(head)) {
-		next =3D head->next;
-		pi_state =3D list_entry(next, struct futex_pi_state, list);
-		key =3D pi_state->key;
-		hb =3D futex_hash(&key);
-
-		/*
-		 * We can race against put_pi_state() removing itself from the
-		 * list (a waiter going away). put_pi_state() will first
-		 * decrement the reference count and then modify the list, so
-		 * its possible to see the list entry but fail this reference
-		 * acquire.
-		 *
-		 * In that case; drop the locks to let put_pi_state() make
-		 * progress and retry the loop.
-		 */
-		if (!refcount_inc_not_zero(&pi_state->refcount)) {
-			raw_spin_unlock_irq(&curr->pi_lock);
-			cpu_relax();
-			raw_spin_lock_irq(&curr->pi_lock);
-			continue;
-		}
-		raw_spin_unlock_irq(&curr->pi_lock);
-
-		spin_lock(&hb->lock);
-		raw_spin_lock_irq(&pi_state->pi_mutex.wait_lock);
-		raw_spin_lock(&curr->pi_lock);
-		/*
-		 * We dropped the pi-lock, so re-check whether this
-		 * task still owns the PI-state:
-		 */
-		if (head->next !=3D next) {
-			/* retain curr->pi_lock for the loop invariant */
-			raw_spin_unlock(&pi_state->pi_mutex.wait_lock);
-			spin_unlock(&hb->lock);
-			put_pi_state(pi_state);
-			continue;
-		}
-
-		WARN_ON(pi_state->owner !=3D curr);
-		WARN_ON(list_empty(&pi_state->list));
-		list_del_init(&pi_state->list);
-		pi_state->owner =3D NULL;
-
-		raw_spin_unlock(&curr->pi_lock);
-		raw_spin_unlock_irq(&pi_state->pi_mutex.wait_lock);
-		spin_unlock(&hb->lock);
-
-		rt_mutex_futex_unlock(&pi_state->pi_mutex);
-		put_pi_state(pi_state);
-
-		raw_spin_lock_irq(&curr->pi_lock);
-	}
-	raw_spin_unlock_irq(&curr->pi_lock);
-}
-#else
-static inline void exit_pi_state_list(struct task_struct *curr) { }
-#endif
-
-/*
- * We need to check the following states:
- *
- *      Waiter | pi_state | pi->owner | uTID      | uODIED | ?
- *
- * [1]  NULL   | ---      | ---       | 0         | 0/1    | Valid
- * [2]  NULL   | ---      | ---       | >0        | 0/1    | Valid
- *
- * [3]  Found  | NULL     | --        | Any       | 0/1    | Invalid
- *
- * [4]  Found  | Found    | NULL      | 0         | 1      | Valid
- * [5]  Found  | Found    | NULL      | >0        | 1      | Invalid
- *
- * [6]  Found  | Found    | task      | 0         | 1      | Valid
- *
- * [7]  Found  | Found    | NULL      | Any       | 0      | Invalid
- *
- * [8]  Found  | Found    | task      | =3D=3DtaskTID | 0/1    | Valid
- * [9]  Found  | Found    | task      | 0         | 0      | Invalid
- * [10] Found  | Found    | task      | !=3DtaskTID | 0/1    | Invalid
- *
- * [1]	Indicates that the kernel can acquire the futex atomically. We
- *	came here due to a stale FUTEX_WAITERS/FUTEX_OWNER_DIED bit.
- *
- * [2]	Valid, if TID does not belong to a kernel thread. If no matching
- *      thread is found then it indicates that the owner TID has died.
- *
- * [3]	Invalid. The waiter is queued on a non PI futex
- *
- * [4]	Valid state after exit_robust_list(), which sets the user space
- *	value to FUTEX_WAITERS | FUTEX_OWNER_DIED.
- *
- * [5]	The user space value got manipulated between exit_robust_list()
- *	and exit_pi_state_list()
- *
- * [6]	Valid state after exit_pi_state_list() which sets the new owner in
- *	the pi_state but cannot access the user space value.
- *
- * [7]	pi_state->owner can only be NULL when the OWNER_DIED bit is set.
- *
- * [8]	Owner and user space value match
- *
- * [9]	There is no transient state which sets the user space TID to 0
- *	except exit_robust_list(), but this is indicated by the
- *	FUTEX_OWNER_DIED bit. See [4]
- *
- * [10] There is no transient state which leaves owner and user space
- *	TID out of sync. Except one error case where the kernel is denied
- *	write access to the user address, see fixup_pi_state_owner().
- *
- *
- * Serialization and lifetime rules:
- *
- * hb->lock:
- *
- *	hb -> futex_q, relation
- *	futex_q -> pi_state, relation
- *
- *	(cannot be raw because hb can contain arbitrary amount
- *	 of futex_q's)
- *
- * pi_mutex->wait_lock:
- *
- *	{uval, pi_state}
- *
- *	(and pi_mutex 'obviously')
- *
- * p->pi_lock:
- *
- *	p->pi_state_list -> pi_state->list, relation
- *	pi_mutex->owner -> pi_state->owner, relation
- *
- * pi_state->refcount:
- *
- *	pi_state lifetime
- *
- *
- * Lock order:
- *
- *   hb->lock
- *     pi_mutex->wait_lock
- *       p->pi_lock
- *
- */
-
-/*
- * Validate that the existing waiter has a pi_state and sanity check
- * the pi_state against the user space value. If correct, attach to
- * it.
- */
-static int attach_to_pi_state(u32 __user *uaddr, u32 uval,
-			      struct futex_pi_state *pi_state,
-			      struct futex_pi_state **ps)
-{
-	pid_t pid =3D uval & FUTEX_TID_MASK;
-	u32 uval2;
-	int ret;
-
-	/*
-	 * Userspace might have messed up non-PI and PI futexes [3]
-	 */
-	if (unlikely(!pi_state))
-		return -EINVAL;
-
-	/*
-	 * We get here with hb->lock held, and having found a
-	 * futex_top_waiter(). This means that futex_lock_pi() of said futex_q
-	 * has dropped the hb->lock in between futex_queue() and futex_unqueue_pi(),
-	 * which in turn means that futex_lock_pi() still has a reference on
-	 * our pi_state.
-	 *
-	 * The waiter holding a reference on @pi_state also protects against
-	 * the unlocked put_pi_state() in futex_unlock_pi(), futex_lock_pi()
-	 * and futex_wait_requeue_pi() as it cannot go to 0 and consequently
-	 * free pi_state before we can take a reference ourselves.
-	 */
-	WARN_ON(!refcount_read(&pi_state->refcount));
-
-	/*
-	 * Now that we have a pi_state, we can acquire wait_lock
-	 * and do the state validation.
-	 */
-	raw_spin_lock_irq(&pi_state->pi_mutex.wait_lock);
-
-	/*
-	 * Since {uval, pi_state} is serialized by wait_lock, and our current
-	 * uval was read without holding it, it can have changed. Verify it
-	 * still is what we expect it to be, otherwise retry the entire
-	 * operation.
-	 */
-	if (futex_get_value_locked(&uval2, uaddr))
-		goto out_efault;
-
-	if (uval !=3D uval2)
-		goto out_eagain;
-
-	/*
-	 * Handle the owner died case:
-	 */
-	if (uval & FUTEX_OWNER_DIED) {
-		/*
-		 * exit_pi_state_list sets owner to NULL and wakes the
-		 * topmost waiter. The task which acquires the
-		 * pi_state->rt_mutex will fixup owner.
-		 */
-		if (!pi_state->owner) {
-			/*
-			 * No pi state owner, but the user space TID
-			 * is not 0. Inconsistent state. [5]
-			 */
-			if (pid)
-				goto out_einval;
-			/*
-			 * Take a ref on the state and return success. [4]
-			 */
-			goto out_attach;
-		}
-
-		/*
-		 * If TID is 0, then either the dying owner has not
-		 * yet executed exit_pi_state_list() or some waiter
-		 * acquired the rtmutex in the pi state, but did not
-		 * yet fixup the TID in user space.
-		 *
-		 * Take a ref on the state and return success. [6]
-		 */
-		if (!pid)
-			goto out_attach;
-	} else {
-		/*
-		 * If the owner died bit is not set, then the pi_state
-		 * must have an owner. [7]
-		 */
-		if (!pi_state->owner)
-			goto out_einval;
-	}
-
-	/*
-	 * Bail out if user space manipulated the futex value. If pi
-	 * state exists then the owner TID must be the same as the
-	 * user space TID. [9/10]
-	 */
-	if (pid !=3D task_pid_vnr(pi_state->owner))
-		goto out_einval;
-
-out_attach:
-	get_pi_state(pi_state);
-	raw_spin_unlock_irq(&pi_state->pi_mutex.wait_lock);
-	*ps =3D pi_state;
-	return 0;
-
-out_einval:
-	ret =3D -EINVAL;
-	goto out_error;
-
-out_eagain:
-	ret =3D -EAGAIN;
-	goto out_error;
-
-out_efault:
-	ret =3D -EFAULT;
-	goto out_error;
-
-out_error:
-	raw_spin_unlock_irq(&pi_state->pi_mutex.wait_lock);
-	return ret;
-}
-
 /**
  * wait_for_owner_exiting - Block until the owner has exited
  * @ret: owner's current futex lock status
@@ -1155,7 +683,7 @@ out_error:
  *
  * Caller must hold a refcount on @exiting.
  */
-static void wait_for_owner_exiting(int ret, struct task_struct *exiting)
+void wait_for_owner_exiting(int ret, struct task_struct *exiting)
 {
 	if (ret !=3D -EBUSY) {
 		WARN_ON_ONCE(exiting);
@@ -1179,296 +707,6 @@ static void wait_for_owner_exiting(int ret, struct tas=
k_struct *exiting)
 	put_task_struct(exiting);
 }
=20
-static int handle_exit_race(u32 __user *uaddr, u32 uval,
-			    struct task_struct *tsk)
-{
-	u32 uval2;
-
-	/*
-	 * If the futex exit state is not yet FUTEX_STATE_DEAD, tell the
-	 * caller that the alleged owner is busy.
-	 */
-	if (tsk && tsk->futex_state !=3D FUTEX_STATE_DEAD)
-		return -EBUSY;
-
-	/*
-	 * Reread the user space value to handle the following situation:
-	 *
-	 * CPU0				CPU1
-	 *
-	 * sys_exit()			sys_futex()
-	 *  do_exit()			 futex_lock_pi()
-	 *                                futex_lock_pi_atomic()
-	 *   exit_signals(tsk)		    No waiters:
-	 *    tsk->flags |=3D PF_EXITING;	    *uaddr =3D=3D 0x00000PID
-	 *  mm_release(tsk)		    Set waiter bit
-	 *   exit_robust_list(tsk) {	    *uaddr =3D 0x80000PID;
-	 *      Set owner died		    attach_to_pi_owner() {
-	 *    *uaddr =3D 0xC0000000;	     tsk =3D get_task(PID);
-	 *   }				     if (!tsk->flags & PF_EXITING) {
-	 *  ...				       attach();
-	 *  tsk->futex_state =3D               } else {
-	 *	FUTEX_STATE_DEAD;              if (tsk->futex_state !=3D
-	 *					  FUTEX_STATE_DEAD)
-	 *				         return -EAGAIN;
-	 *				       return -ESRCH; <--- FAIL
-	 *				     }
-	 *
-	 * Returning ESRCH unconditionally is wrong here because the
-	 * user space value has been changed by the exiting task.
-	 *
-	 * The same logic applies to the case where the exiting task is
-	 * already gone.
-	 */
-	if (futex_get_value_locked(&uval2, uaddr))
-		return -EFAULT;
-
-	/* If the user space value has changed, try again. */
-	if (uval2 !=3D uval)
-		return -EAGAIN;
-
-	/*
-	 * The exiting task did not have a robust list, the robust list was
-	 * corrupted or the user space value in *uaddr is simply bogus.
-	 * Give up and tell user space.
-	 */
-	return -ESRCH;
-}
-
-static void __attach_to_pi_owner(struct task_struct *p, union futex_key *key,
-				 struct futex_pi_state **ps)
-{
-	/*
-	 * No existing pi state. First waiter. [2]
-	 *
-	 * This creates pi_state, we have hb->lock held, this means nothing can
-	 * observe this state, wait_lock is irrelevant.
-	 */
-	struct futex_pi_state *pi_state =3D alloc_pi_state();
-
-	/*
-	 * Initialize the pi_mutex in locked state and make @p
-	 * the owner of it:
-	 */
-	rt_mutex_init_proxy_locked(&pi_state->pi_mutex, p);
-
-	/* Store the key for possible exit cleanups: */
-	pi_state->key =3D *key;
-
-	WARN_ON(!list_empty(&pi_state->list));
-	list_add(&pi_state->list, &p->pi_state_list);
-	/*
-	 * Assignment without holding pi_state->pi_mutex.wait_lock is safe
-	 * because there is no concurrency as the object is not published yet.
-	 */
-	pi_state->owner =3D p;
-
-	*ps =3D pi_state;
-}
-/*
- * Lookup the task for the TID provided from user space and attach to
- * it after doing proper sanity checks.
- */
-static int attach_to_pi_owner(u32 __user *uaddr, u32 uval, union futex_key *=
key,
-			      struct futex_pi_state **ps,
-			      struct task_struct **exiting)
-{
-	pid_t pid =3D uval & FUTEX_TID_MASK;
-	struct task_struct *p;
-
-	/*
-	 * We are the first waiter - try to look up the real owner and attach
-	 * the new pi_state to it, but bail out when TID =3D 0 [1]
-	 *
-	 * The !pid check is paranoid. None of the call sites should end up
-	 * with pid =3D=3D 0, but better safe than sorry. Let the caller retry
-	 */
-	if (!pid)
-		return -EAGAIN;
-	p =3D find_get_task_by_vpid(pid);
-	if (!p)
-		return handle_exit_race(uaddr, uval, NULL);
-
-	if (unlikely(p->flags & PF_KTHREAD)) {
-		put_task_struct(p);
-		return -EPERM;
-	}
-
-	/*
-	 * We need to look at the task state to figure out, whether the
-	 * task is exiting. To protect against the change of the task state
-	 * in futex_exit_release(), we do this protected by p->pi_lock:
-	 */
-	raw_spin_lock_irq(&p->pi_lock);
-	if (unlikely(p->futex_state !=3D FUTEX_STATE_OK)) {
-		/*
-		 * The task is on the way out. When the futex state is
-		 * FUTEX_STATE_DEAD, we know that the task has finished
-		 * the cleanup:
-		 */
-		int ret =3D handle_exit_race(uaddr, uval, p);
-
-		raw_spin_unlock_irq(&p->pi_lock);
-		/*
-		 * If the owner task is between FUTEX_STATE_EXITING and
-		 * FUTEX_STATE_DEAD then store the task pointer and keep
-		 * the reference on the task struct. The calling code will
-		 * drop all locks, wait for the task to reach
-		 * FUTEX_STATE_DEAD and then drop the refcount. This is
-		 * required to prevent a live lock when the current task
-		 * preempted the exiting task between the two states.
-		 */
-		if (ret =3D=3D -EBUSY)
-			*exiting =3D p;
-		else
-			put_task_struct(p);
-		return ret;
-	}
-
-	__attach_to_pi_owner(p, key, ps);
-	raw_spin_unlock_irq(&p->pi_lock);
-
-	put_task_struct(p);
-
-	return 0;
-}
-
-static int lock_pi_update_atomic(u32 __user *uaddr, u32 uval, u32 newval)
-{
-	int err;
-	u32 curval;
-
-	if (unlikely(should_fail_futex(true)))
-		return -EFAULT;
-
-	err =3D futex_cmpxchg_value_locked(&curval, uaddr, uval, newval);
-	if (unlikely(err))
-		return err;
-
-	/* If user space value changed, let the caller retry */
-	return curval !=3D uval ? -EAGAIN : 0;
-}
-
-/**
- * futex_lock_pi_atomic() - Atomic work required to acquire a pi aware futex
- * @uaddr:		the pi futex user address
- * @hb:			the pi futex hash bucket
- * @key:		the futex key associated with uaddr and hb
- * @ps:			the pi_state pointer where we store the result of the
- *			lookup
- * @task:		the task to perform the atomic lock work for.  This will
- *			be "current" except in the case of requeue pi.
- * @exiting:		Pointer to store the task pointer of the owner task
- *			which is in the middle of exiting
- * @set_waiters:	force setting the FUTEX_WAITERS bit (1) or not (0)
- *
- * Return:
- *  -  0 - ready to wait;
- *  -  1 - acquired the lock;
- *  - <0 - error
- *
- * The hb->lock must be held by the caller.
- *
- * @exiting is only set when the return value is -EBUSY. If so, this holds
- * a refcount on the exiting task on return and the caller needs to drop it
- * after waiting for the exit to complete.
- */
-static int futex_lock_pi_atomic(u32 __user *uaddr, struct futex_hash_bucket =
*hb,
-				union futex_key *key,
-				struct futex_pi_state **ps,
-				struct task_struct *task,
-				struct task_struct **exiting,
-				int set_waiters)
-{
-	u32 uval, newval, vpid =3D task_pid_vnr(task);
-	struct futex_q *top_waiter;
-	int ret;
-
-	/*
-	 * Read the user space value first so we can validate a few
-	 * things before proceeding further.
-	 */
-	if (futex_get_value_locked(&uval, uaddr))
-		return -EFAULT;
-
-	if (unlikely(should_fail_futex(true)))
-		return -EFAULT;
-
-	/*
-	 * Detect deadlocks.
-	 */
-	if ((unlikely((uval & FUTEX_TID_MASK) =3D=3D vpid)))
-		return -EDEADLK;
-
-	if ((unlikely(should_fail_futex(true))))
-		return -EDEADLK;
-
-	/*
-	 * Lookup existing state first. If it exists, try to attach to
-	 * its pi_state.
-	 */
-	top_waiter =3D futex_top_waiter(hb, key);
-	if (top_waiter)
-		return attach_to_pi_state(uaddr, uval, top_waiter->pi_state, ps);
-
-	/*
-	 * No waiter and user TID is 0. We are here because the
-	 * waiters or the owner died bit is set or called from
-	 * requeue_cmp_pi or for whatever reason something took the
-	 * syscall.
-	 */
-	if (!(uval & FUTEX_TID_MASK)) {
-		/*
-		 * We take over the futex. No other waiters and the user space
-		 * TID is 0. We preserve the owner died bit.
-		 */
-		newval =3D uval & FUTEX_OWNER_DIED;
-		newval |=3D vpid;
-
-		/* The futex requeue_pi code can enforce the waiters bit */
-		if (set_waiters)
-			newval |=3D FUTEX_WAITERS;
-
-		ret =3D lock_pi_update_atomic(uaddr, uval, newval);
-		if (ret)
-			return ret;
-
-		/*
-		 * If the waiter bit was requested the caller also needs PI
-		 * state attached to the new owner of the user space futex.
-		 *
-		 * @task is guaranteed to be alive and it cannot be exiting
-		 * because it is either sleeping or waiting in
-		 * futex_requeue_pi_wakeup_sync().
-		 *
-		 * No need to do the full attach_to_pi_owner() exercise
-		 * because @task is known and valid.
-		 */
-		if (set_waiters) {
-			raw_spin_lock_irq(&task->pi_lock);
-			__attach_to_pi_owner(task, key, ps);
-			raw_spin_unlock_irq(&task->pi_lock);
-		}
-		return 1;
-	}
-
-	/*
-	 * First waiter. Set the waiters bit before attaching ourself to
-	 * the owner. If owner tries to unlock, it will be forced into
-	 * the kernel and blocked on hb->lock.
-	 */
-	newval =3D uval | FUTEX_WAITERS;
-	ret =3D lock_pi_update_atomic(uaddr, uval, newval);
-	if (ret)
-		return ret;
-	/*
-	 * If the update of the user space value succeeded, we try to
-	 * attach to the owner. If that fails, no harm done, we only
-	 * set the FUTEX_WAITERS bit in the user space variable.
-	 */
-	return attach_to_pi_owner(uaddr, newval, key, ps, exiting);
-}
-
 /**
  * __futex_unqueue() - Remove the futex_q from its futex_hash_bucket
  * @q:	The futex_q to unqueue
@@ -1520,79 +758,6 @@ static void mark_wake_futex(struct wake_q_head *wake_q,=
 struct futex_q *q)
 }
=20
 /*
- * Caller must hold a reference on @pi_state.
- */
-static int wake_futex_pi(u32 __user *uaddr, u32 uval, struct futex_pi_state =
*pi_state)
-{
-	struct rt_mutex_waiter *top_waiter;
-	struct task_struct *new_owner;
-	bool postunlock =3D false;
-	DEFINE_RT_WAKE_Q(wqh);
-	u32 curval, newval;
-	int ret =3D 0;
-
-	top_waiter =3D rt_mutex_top_waiter(&pi_state->pi_mutex);
-	if (WARN_ON_ONCE(!top_waiter)) {
-		/*
-		 * As per the comment in futex_unlock_pi() this should not happen.
-		 *
-		 * When this happens, give up our locks and try again, giving
-		 * the futex_lock_pi() instance time to complete, either by
-		 * waiting on the rtmutex or removing itself from the futex
-		 * queue.
-		 */
-		ret =3D -EAGAIN;
-		goto out_unlock;
-	}
-
-	new_owner =3D top_waiter->task;
-
-	/*
-	 * We pass it to the next owner. The WAITERS bit is always kept
-	 * enabled while there is PI state around. We cleanup the owner
-	 * died bit, because we are the owner.
-	 */
-	newval =3D FUTEX_WAITERS | task_pid_vnr(new_owner);
-
-	if (unlikely(should_fail_futex(true))) {
-		ret =3D -EFAULT;
-		goto out_unlock;
-	}
-
-	ret =3D futex_cmpxchg_value_locked(&curval, uaddr, uval, newval);
-	if (!ret && (curval !=3D uval)) {
-		/*
-		 * If a unconditional UNLOCK_PI operation (user space did not
-		 * try the TID->0 transition) raced with a waiter setting the
-		 * FUTEX_WAITERS flag between get_user() and locking the hash
-		 * bucket lock, retry the operation.
-		 */
-		if ((FUTEX_TID_MASK & curval) =3D=3D uval)
-			ret =3D -EAGAIN;
-		else
-			ret =3D -EINVAL;
-	}
-
-	if (!ret) {
-		/*
-		 * This is a point of no return; once we modified the uval
-		 * there is no going back and subsequent operations must
-		 * not fail.
-		 */
-		pi_state_update_owner(pi_state, new_owner);
-		postunlock =3D __rt_mutex_futex_unlock(&pi_state->pi_mutex, &wqh);
-	}
-
-out_unlock:
-	raw_spin_unlock_irq(&pi_state->pi_mutex.wait_lock);
-
-	if (postunlock)
-		rt_mutex_postunlock(&wqh);
-
-	return ret;
-}
-
-/*
  * Express the locking dependencies for lockdep:
  */
 static inline void
@@ -2410,7 +1575,7 @@ out_unlock:
 }
=20
 /* The key must be already stored in q->key. */
-static inline struct futex_hash_bucket *futex_q_lock(struct futex_q *q)
+struct futex_hash_bucket *futex_q_lock(struct futex_q *q)
 	__acquires(&hb->lock)
 {
 	struct futex_hash_bucket *hb;
@@ -2433,15 +1598,14 @@ static inline struct futex_hash_bucket *futex_q_lock(=
struct futex_q *q)
 	return hb;
 }
=20
-static inline void
-futex_q_unlock(struct futex_hash_bucket *hb)
+void futex_q_unlock(struct futex_hash_bucket *hb)
 	__releases(&hb->lock)
 {
 	spin_unlock(&hb->lock);
 	hb_waiters_dec(hb);
 }
=20
-static inline void __futex_queue(struct futex_q *q, struct futex_hash_bucket=
 *hb)
+void __futex_queue(struct futex_q *q, struct futex_hash_bucket *hb)
 {
 	int prio;
=20
@@ -2537,255 +1701,17 @@ retry:
  * PI futexes can not be requeued and must remove themselves from the
  * hash bucket. The hash bucket lock (i.e. lock_ptr) is held.
  */
-static void futex_unqueue_pi(struct futex_q *q)
+void futex_unqueue_pi(struct futex_q *q)
 {
 	__futex_unqueue(q);
=20
 	BUG_ON(!q->pi_state);
 	put_pi_state(q->pi_state);
-	q->pi_state =3D NULL;
-}
-
-static int __fixup_pi_state_owner(u32 __user *uaddr, struct futex_q *q,
-				  struct task_struct *argowner)
-{
-	struct futex_pi_state *pi_state =3D q->pi_state;
-	struct task_struct *oldowner, *newowner;
-	u32 uval, curval, newval, newtid;
-	int err =3D 0;
-
-	oldowner =3D pi_state->owner;
-
-	/*
-	 * We are here because either:
-	 *
-	 *  - we stole the lock and pi_state->owner needs updating to reflect
-	 *    that (@argowner =3D=3D current),
-	 *
-	 * or:
-	 *
-	 *  - someone stole our lock and we need to fix things to point to the
-	 *    new owner (@argowner =3D=3D NULL).
-	 *
-	 * Either way, we have to replace the TID in the user space variable.
-	 * This must be atomic as we have to preserve the owner died bit here.
-	 *
-	 * Note: We write the user space value _before_ changing the pi_state
-	 * because we can fault here. Imagine swapped out pages or a fork
-	 * that marked all the anonymous memory readonly for cow.
-	 *
-	 * Modifying pi_state _before_ the user space value would leave the
-	 * pi_state in an inconsistent state when we fault here, because we
-	 * need to drop the locks to handle the fault. This might be observed
-	 * in the PID checks when attaching to PI state .
-	 */
-retry:
-	if (!argowner) {
-		if (oldowner !=3D current) {
-			/*
-			 * We raced against a concurrent self; things are
-			 * already fixed up. Nothing to do.
-			 */
-			return 0;
-		}
-
-		if (__rt_mutex_futex_trylock(&pi_state->pi_mutex)) {
-			/* We got the lock. pi_state is correct. Tell caller. */
-			return 1;
-		}
-
-		/*
-		 * The trylock just failed, so either there is an owner or
-		 * there is a higher priority waiter than this one.
-		 */
-		newowner =3D rt_mutex_owner(&pi_state->pi_mutex);
-		/*
-		 * If the higher priority waiter has not yet taken over the
-		 * rtmutex then newowner is NULL. We can't return here with
-		 * that state because it's inconsistent vs. the user space
-		 * state. So drop the locks and try again. It's a valid
-		 * situation and not any different from the other retry
-		 * conditions.
-		 */
-		if (unlikely(!newowner)) {
-			err =3D -EAGAIN;
-			goto handle_err;
-		}
-	} else {
-		WARN_ON_ONCE(argowner !=3D current);
-		if (oldowner =3D=3D current) {
-			/*
-			 * We raced against a concurrent self; things are
-			 * already fixed up. Nothing to do.
-			 */
-			return 1;
-		}
-		newowner =3D argowner;
-	}
-
-	newtid =3D task_pid_vnr(newowner) | FUTEX_WAITERS;
-	/* Owner died? */
-	if (!pi_state->owner)
-		newtid |=3D FUTEX_OWNER_DIED;
-
-	err =3D futex_get_value_locked(&uval, uaddr);
-	if (err)
-		goto handle_err;
-
-	for (;;) {
-		newval =3D (uval & FUTEX_OWNER_DIED) | newtid;
-
-		err =3D futex_cmpxchg_value_locked(&curval, uaddr, uval, newval);
-		if (err)
-			goto handle_err;
-
-		if (curval =3D=3D uval)
-			break;
-		uval =3D curval;
-	}
-
-	/*
-	 * We fixed up user space. Now we need to fix the pi_state
-	 * itself.
-	 */
-	pi_state_update_owner(pi_state, newowner);
-
-	return argowner =3D=3D current;
-
-	/*
-	 * In order to reschedule or handle a page fault, we need to drop the
-	 * locks here. In the case of a fault, this gives the other task
-	 * (either the highest priority waiter itself or the task which stole
-	 * the rtmutex) the chance to try the fixup of the pi_state. So once we
-	 * are back from handling the fault we need to check the pi_state after
-	 * reacquiring the locks and before trying to do another fixup. When
-	 * the fixup has been done already we simply return.
-	 *
-	 * Note: we hold both hb->lock and pi_mutex->wait_lock. We can safely
-	 * drop hb->lock since the caller owns the hb -> futex_q relation.
-	 * Dropping the pi_mutex->wait_lock requires the state revalidate.
-	 */
-handle_err:
-	raw_spin_unlock_irq(&pi_state->pi_mutex.wait_lock);
-	spin_unlock(q->lock_ptr);
-
-	switch (err) {
-	case -EFAULT:
-		err =3D fault_in_user_writeable(uaddr);
-		break;
-
-	case -EAGAIN:
-		cond_resched();
-		err =3D 0;
-		break;
-
-	default:
-		WARN_ON_ONCE(1);
-		break;
-	}
-
-	spin_lock(q->lock_ptr);
-	raw_spin_lock_irq(&pi_state->pi_mutex.wait_lock);
-
-	/*
-	 * Check if someone else fixed it for us:
-	 */
-	if (pi_state->owner !=3D oldowner)
-		return argowner =3D=3D current;
-
-	/* Retry if err was -EAGAIN or the fault in succeeded */
-	if (!err)
-		goto retry;
-
-	/*
-	 * fault_in_user_writeable() failed so user state is immutable. At
-	 * best we can make the kernel state consistent but user state will
-	 * be most likely hosed and any subsequent unlock operation will be
-	 * rejected due to PI futex rule [10].
-	 *
-	 * Ensure that the rtmutex owner is also the pi_state owner despite
-	 * the user space value claiming something different. There is no
-	 * point in unlocking the rtmutex if current is the owner as it
-	 * would need to wait until the next waiter has taken the rtmutex
-	 * to guarantee consistent state. Keep it simple. Userspace asked
-	 * for this wreckaged state.
-	 *
-	 * The rtmutex has an owner - either current or some other
-	 * task. See the EAGAIN loop above.
-	 */
-	pi_state_update_owner(pi_state, rt_mutex_owner(&pi_state->pi_mutex));
-
-	return err;
-}
-
-static int fixup_pi_state_owner(u32 __user *uaddr, struct futex_q *q,
-				struct task_struct *argowner)
-{
-	struct futex_pi_state *pi_state =3D q->pi_state;
-	int ret;
-
-	lockdep_assert_held(q->lock_ptr);
-
-	raw_spin_lock_irq(&pi_state->pi_mutex.wait_lock);
-	ret =3D __fixup_pi_state_owner(uaddr, q, argowner);
-	raw_spin_unlock_irq(&pi_state->pi_mutex.wait_lock);
-	return ret;
-}
-
-static long futex_wait_restart(struct restart_block *restart);
-
-/**
- * fixup_owner() - Post lock pi_state and corner case management
- * @uaddr:	user address of the futex
- * @q:		futex_q (contains pi_state and access to the rt_mutex)
- * @locked:	if the attempt to take the rt_mutex succeeded (1) or not (0)
- *
- * After attempting to lock an rt_mutex, this function is called to cleanup
- * the pi_state owner as well as handle race conditions that may allow us to
- * acquire the lock. Must be called with the hb lock held.
- *
- * Return:
- *  -  1 - success, lock taken;
- *  -  0 - success, lock not taken;
- *  - <0 - on error (-EFAULT)
- */
-static int fixup_owner(u32 __user *uaddr, struct futex_q *q, int locked)
-{
-	if (locked) {
-		/*
-		 * Got the lock. We might not be the anticipated owner if we
-		 * did a lock-steal - fix up the PI-state in that case:
-		 *
-		 * Speculative pi_state->owner read (we don't hold wait_lock);
-		 * since we own the lock pi_state->owner =3D=3D current is the
-		 * stable state, anything else needs more attention.
-		 */
-		if (q->pi_state->owner !=3D current)
-			return fixup_pi_state_owner(uaddr, q, current);
-		return 1;
-	}
-
-	/*
-	 * If we didn't get the lock; check if anybody stole it from us. In
-	 * that case, we need to fix up the uval to point to them instead of
-	 * us, otherwise bad things happen. [10]
-	 *
-	 * Another speculative read; pi_state->owner =3D=3D current is unstable
-	 * but needs our attention.
-	 */
-	if (q->pi_state->owner =3D=3D current)
-		return fixup_pi_state_owner(uaddr, q, NULL);
-
-	/*
-	 * Paranoia check. If we did not take the lock, then we should not be
-	 * the owner of the rt_mutex. Warn and establish consistent state.
-	 */
-	if (WARN_ON_ONCE(rt_mutex_owner(&q->pi_state->pi_mutex) =3D=3D current))
-		return fixup_pi_state_owner(uaddr, q, current);
-
-	return 0;
+	q->pi_state =3D NULL;
 }
=20
+static long futex_wait_restart(struct restart_block *restart);
+
 /**
  * futex_wait_queue() - futex_queue() and wait for wakeup, timeout, or signal
  * @hb:		the futex hash bucket, must be locked by the caller
@@ -2974,319 +1900,6 @@ static long futex_wait_restart(struct restart_block *=
restart)
 }
=20
=20
-/*
- * Userspace tried a 0 -> TID atomic transition of the futex value
- * and failed. The kernel side here does the whole locking operation:
- * if there are waiters then it will block as a consequence of relying
- * on rt-mutexes, it does PI, etc. (Due to races the kernel might see
- * a 0 value of the futex too.).
- *
- * Also serves as futex trylock_pi()'ing, and due semantics.
- */
-int futex_lock_pi(u32 __user *uaddr, unsigned int flags, ktime_t *time, int =
trylock)
-{
-	struct hrtimer_sleeper timeout, *to;
-	struct task_struct *exiting =3D NULL;
-	struct rt_mutex_waiter rt_waiter;
-	struct futex_hash_bucket *hb;
-	struct futex_q q =3D futex_q_init;
-	int res, ret;
-
-	if (!IS_ENABLED(CONFIG_FUTEX_PI))
-		return -ENOSYS;
-
-	if (refill_pi_state_cache())
-		return -ENOMEM;
-
-	to =3D futex_setup_timer(time, &timeout, flags, 0);
-
-retry:
-	ret =3D get_futex_key(uaddr, flags & FLAGS_SHARED, &q.key, FUTEX_WRITE);
-	if (unlikely(ret !=3D 0))
-		goto out;
-
-retry_private:
-	hb =3D futex_q_lock(&q);
-
-	ret =3D futex_lock_pi_atomic(uaddr, hb, &q.key, &q.pi_state, current,
-				   &exiting, 0);
-	if (unlikely(ret)) {
-		/*
-		 * Atomic work succeeded and we got the lock,
-		 * or failed. Either way, we do _not_ block.
-		 */
-		switch (ret) {
-		case 1:
-			/* We got the lock. */
-			ret =3D 0;
-			goto out_unlock_put_key;
-		case -EFAULT:
-			goto uaddr_faulted;
-		case -EBUSY:
-		case -EAGAIN:
-			/*
-			 * Two reasons for this:
-			 * - EBUSY: Task is exiting and we just wait for the
-			 *   exit to complete.
-			 * - EAGAIN: The user space value changed.
-			 */
-			futex_q_unlock(hb);
-			/*
-			 * Handle the case where the owner is in the middle of
-			 * exiting. Wait for the exit to complete otherwise
-			 * this task might loop forever, aka. live lock.
-			 */
-			wait_for_owner_exiting(ret, exiting);
-			cond_resched();
-			goto retry;
-		default:
-			goto out_unlock_put_key;
-		}
-	}
-
-	WARN_ON(!q.pi_state);
-
-	/*
-	 * Only actually queue now that the atomic ops are done:
-	 */
-	__futex_queue(&q, hb);
-
-	if (trylock) {
-		ret =3D rt_mutex_futex_trylock(&q.pi_state->pi_mutex);
-		/* Fixup the trylock return value: */
-		ret =3D ret ? 0 : -EWOULDBLOCK;
-		goto no_block;
-	}
-
-	rt_mutex_init_waiter(&rt_waiter);
-
-	/*
-	 * On PREEMPT_RT_FULL, when hb->lock becomes an rt_mutex, we must not
-	 * hold it while doing rt_mutex_start_proxy(), because then it will
-	 * include hb->lock in the blocking chain, even through we'll not in
-	 * fact hold it while blocking. This will lead it to report -EDEADLK
-	 * and BUG when futex_unlock_pi() interleaves with this.
-	 *
-	 * Therefore acquire wait_lock while holding hb->lock, but drop the
-	 * latter before calling __rt_mutex_start_proxy_lock(). This
-	 * interleaves with futex_unlock_pi() -- which does a similar lock
-	 * handoff -- such that the latter can observe the futex_q::pi_state
-	 * before __rt_mutex_start_proxy_lock() is done.
-	 */
-	raw_spin_lock_irq(&q.pi_state->pi_mutex.wait_lock);
-	spin_unlock(q.lock_ptr);
-	/*
-	 * __rt_mutex_start_proxy_lock() unconditionally enqueues the @rt_waiter
-	 * such that futex_unlock_pi() is guaranteed to observe the waiter when
-	 * it sees the futex_q::pi_state.
-	 */
-	ret =3D __rt_mutex_start_proxy_lock(&q.pi_state->pi_mutex, &rt_waiter, curr=
ent);
-	raw_spin_unlock_irq(&q.pi_state->pi_mutex.wait_lock);
-
-	if (ret) {
-		if (ret =3D=3D 1)
-			ret =3D 0;
-		goto cleanup;
-	}
-
-	if (unlikely(to))
-		hrtimer_sleeper_start_expires(to, HRTIMER_MODE_ABS);
-
-	ret =3D rt_mutex_wait_proxy_lock(&q.pi_state->pi_mutex, to, &rt_waiter);
-
-cleanup:
-	spin_lock(q.lock_ptr);
-	/*
-	 * If we failed to acquire the lock (deadlock/signal/timeout), we must
-	 * first acquire the hb->lock before removing the lock from the
-	 * rt_mutex waitqueue, such that we can keep the hb and rt_mutex wait
-	 * lists consistent.
-	 *
-	 * In particular; it is important that futex_unlock_pi() can not
-	 * observe this inconsistency.
-	 */
-	if (ret && !rt_mutex_cleanup_proxy_lock(&q.pi_state->pi_mutex, &rt_waiter))
-		ret =3D 0;
-
-no_block:
-	/*
-	 * Fixup the pi_state owner and possibly acquire the lock if we
-	 * haven't already.
-	 */
-	res =3D fixup_owner(uaddr, &q, !ret);
-	/*
-	 * If fixup_owner() returned an error, propagate that.  If it acquired
-	 * the lock, clear our -ETIMEDOUT or -EINTR.
-	 */
-	if (res)
-		ret =3D (res < 0) ? res : 0;
-
-	futex_unqueue_pi(&q);
-	spin_unlock(q.lock_ptr);
-	goto out;
-
-out_unlock_put_key:
-	futex_q_unlock(hb);
-
-out:
-	if (to) {
-		hrtimer_cancel(&to->timer);
-		destroy_hrtimer_on_stack(&to->timer);
-	}
-	return ret !=3D -EINTR ? ret : -ERESTARTNOINTR;
-
-uaddr_faulted:
-	futex_q_unlock(hb);
-
-	ret =3D fault_in_user_writeable(uaddr);
-	if (ret)
-		goto out;
-
-	if (!(flags & FLAGS_SHARED))
-		goto retry_private;
-
-	goto retry;
-}
-
-/*
- * Userspace attempted a TID -> 0 atomic transition, and failed.
- * This is the in-kernel slowpath: we look up the PI state (if any),
- * and do the rt-mutex unlock.
- */
-int futex_unlock_pi(u32 __user *uaddr, unsigned int flags)
-{
-	u32 curval, uval, vpid =3D task_pid_vnr(current);
-	union futex_key key =3D FUTEX_KEY_INIT;
-	struct futex_hash_bucket *hb;
-	struct futex_q *top_waiter;
-	int ret;
-
-	if (!IS_ENABLED(CONFIG_FUTEX_PI))
-		return -ENOSYS;
-
-retry:
-	if (get_user(uval, uaddr))
-		return -EFAULT;
-	/*
-	 * We release only a lock we actually own:
-	 */
-	if ((uval & FUTEX_TID_MASK) !=3D vpid)
-		return -EPERM;
-
-	ret =3D get_futex_key(uaddr, flags & FLAGS_SHARED, &key, FUTEX_WRITE);
-	if (ret)
-		return ret;
-
-	hb =3D futex_hash(&key);
-	spin_lock(&hb->lock);
-
-	/*
-	 * Check waiters first. We do not trust user space values at
-	 * all and we at least want to know if user space fiddled
-	 * with the futex value instead of blindly unlocking.
-	 */
-	top_waiter =3D futex_top_waiter(hb, &key);
-	if (top_waiter) {
-		struct futex_pi_state *pi_state =3D top_waiter->pi_state;
-
-		ret =3D -EINVAL;
-		if (!pi_state)
-			goto out_unlock;
-
-		/*
-		 * If current does not own the pi_state then the futex is
-		 * inconsistent and user space fiddled with the futex value.
-		 */
-		if (pi_state->owner !=3D current)
-			goto out_unlock;
-
-		get_pi_state(pi_state);
-		/*
-		 * By taking wait_lock while still holding hb->lock, we ensure
-		 * there is no point where we hold neither; and therefore
-		 * wake_futex_pi() must observe a state consistent with what we
-		 * observed.
-		 *
-		 * In particular; this forces __rt_mutex_start_proxy() to
-		 * complete such that we're guaranteed to observe the
-		 * rt_waiter. Also see the WARN in wake_futex_pi().
-		 */
-		raw_spin_lock_irq(&pi_state->pi_mutex.wait_lock);
-		spin_unlock(&hb->lock);
-
-		/* drops pi_state->pi_mutex.wait_lock */
-		ret =3D wake_futex_pi(uaddr, uval, pi_state);
-
-		put_pi_state(pi_state);
-
-		/*
-		 * Success, we're done! No tricky corner cases.
-		 */
-		if (!ret)
-			return ret;
-		/*
-		 * The atomic access to the futex value generated a
-		 * pagefault, so retry the user-access and the wakeup:
-		 */
-		if (ret =3D=3D -EFAULT)
-			goto pi_faulted;
-		/*
-		 * A unconditional UNLOCK_PI op raced against a waiter
-		 * setting the FUTEX_WAITERS bit. Try again.
-		 */
-		if (ret =3D=3D -EAGAIN)
-			goto pi_retry;
-		/*
-		 * wake_futex_pi has detected invalid state. Tell user
-		 * space.
-		 */
-		return ret;
-	}
-
-	/*
-	 * We have no kernel internal state, i.e. no waiters in the
-	 * kernel. Waiters which are about to queue themselves are stuck
-	 * on hb->lock. So we can safely ignore them. We do neither
-	 * preserve the WAITERS bit not the OWNER_DIED one. We are the
-	 * owner.
-	 */
-	if ((ret =3D futex_cmpxchg_value_locked(&curval, uaddr, uval, 0))) {
-		spin_unlock(&hb->lock);
-		switch (ret) {
-		case -EFAULT:
-			goto pi_faulted;
-
-		case -EAGAIN:
-			goto pi_retry;
-
-		default:
-			WARN_ON_ONCE(1);
-			return ret;
-		}
-	}
-
-	/*
-	 * If uval has changed, let user space handle it.
-	 */
-	ret =3D (curval =3D=3D uval) ? 0 : -EAGAIN;
-
-out_unlock:
-	spin_unlock(&hb->lock);
-	return ret;
-
-pi_retry:
-	cond_resched();
-	goto retry;
-
-pi_faulted:
-
-	ret =3D fault_in_user_writeable(uaddr);
-	if (!ret)
-		goto retry;
-
-	return ret;
-}
-
 /**
  * handle_early_requeue_pi_wakeup() - Handle early wakeup on the initial fut=
ex
  * @hb:		the hash_bucket futex_q was original enqueued on
@@ -3441,7 +2054,7 @@ int futex_wait_requeue_pi(u32 __user *uaddr, unsigned i=
nt flags,
 		/* The requeue acquired the lock */
 		if (q.pi_state && (q.pi_state->owner !=3D current)) {
 			spin_lock(q.lock_ptr);
-			ret =3D fixup_owner(uaddr2, &q, true);
+			ret =3D fixup_pi_owner(uaddr2, &q, true);
 			/*
 			 * Drop the reference to the pi state which the
 			 * requeue_pi() code acquired for us.
@@ -3471,9 +2084,9 @@ int futex_wait_requeue_pi(u32 __user *uaddr, unsigned i=
nt flags,
 		 * Fixup the pi_state owner and possibly acquire the lock if we
 		 * haven't already.
 		 */
-		res =3D fixup_owner(uaddr2, &q, !ret);
+		res =3D fixup_pi_owner(uaddr2, &q, !ret);
 		/*
-		 * If fixup_owner() returned an error, propagate that.  If it
+		 * If fixup_pi_owner() returned an error, propagate that.  If it
 		 * acquired the lock, clear -ETIMEDOUT or -EINTR.
 		 */
 		if (res)
@@ -3811,6 +2424,87 @@ static void compat_exit_robust_list(struct task_struct=
 *curr)
 }
 #endif
=20
+#ifdef CONFIG_FUTEX_PI
+
+/*
+ * This task is holding PI mutexes at exit time =3D> bad.
+ * Kernel cleans up PI-state, but userspace is likely hosed.
+ * (Robust-futex cleanup is separate and might save the day for userspace.)
+ */
+static void exit_pi_state_list(struct task_struct *curr)
+{
+	struct list_head *next, *head =3D &curr->pi_state_list;
+	struct futex_pi_state *pi_state;
+	struct futex_hash_bucket *hb;
+	union futex_key key =3D FUTEX_KEY_INIT;
+
+	if (!futex_cmpxchg_enabled)
+		return;
+	/*
+	 * We are a ZOMBIE and nobody can enqueue itself on
+	 * pi_state_list anymore, but we have to be careful
+	 * versus waiters unqueueing themselves:
+	 */
+	raw_spin_lock_irq(&curr->pi_lock);
+	while (!list_empty(head)) {
+		next =3D head->next;
+		pi_state =3D list_entry(next, struct futex_pi_state, list);
+		key =3D pi_state->key;
+		hb =3D futex_hash(&key);
+
+		/*
+		 * We can race against put_pi_state() removing itself from the
+		 * list (a waiter going away). put_pi_state() will first
+		 * decrement the reference count and then modify the list, so
+		 * its possible to see the list entry but fail this reference
+		 * acquire.
+		 *
+		 * In that case; drop the locks to let put_pi_state() make
+		 * progress and retry the loop.
+		 */
+		if (!refcount_inc_not_zero(&pi_state->refcount)) {
+			raw_spin_unlock_irq(&curr->pi_lock);
+			cpu_relax();
+			raw_spin_lock_irq(&curr->pi_lock);
+			continue;
+		}
+		raw_spin_unlock_irq(&curr->pi_lock);
+
+		spin_lock(&hb->lock);
+		raw_spin_lock_irq(&pi_state->pi_mutex.wait_lock);
+		raw_spin_lock(&curr->pi_lock);
+		/*
+		 * We dropped the pi-lock, so re-check whether this
+		 * task still owns the PI-state:
+		 */
+		if (head->next !=3D next) {
+			/* retain curr->pi_lock for the loop invariant */
+			raw_spin_unlock(&pi_state->pi_mutex.wait_lock);
+			spin_unlock(&hb->lock);
+			put_pi_state(pi_state);
+			continue;
+		}
+
+		WARN_ON(pi_state->owner !=3D curr);
+		WARN_ON(list_empty(&pi_state->list));
+		list_del_init(&pi_state->list);
+		pi_state->owner =3D NULL;
+
+		raw_spin_unlock(&curr->pi_lock);
+		raw_spin_unlock_irq(&pi_state->pi_mutex.wait_lock);
+		spin_unlock(&hb->lock);
+
+		rt_mutex_futex_unlock(&pi_state->pi_mutex);
+		put_pi_state(pi_state);
+
+		raw_spin_lock_irq(&curr->pi_lock);
+	}
+	raw_spin_unlock_irq(&curr->pi_lock);
+}
+#else
+static inline void exit_pi_state_list(struct task_struct *curr) { }
+#endif
+
 static void futex_cleanup(struct task_struct *tsk)
 {
 	if (unlikely(tsk->robust_list)) {
diff --git a/kernel/futex/futex.h b/kernel/futex/futex.h
index 7bb4ca8..4969e96 100644
--- a/kernel/futex/futex.h
+++ b/kernel/futex/futex.h
@@ -2,6 +2,7 @@
 #ifndef _FUTEX_H
 #define _FUTEX_H
=20
+#include <linux/futex.h>
 #include <asm/futex.h>
=20
 /*
@@ -35,6 +36,122 @@ static inline bool should_fail_futex(bool fshared)
 }
 #endif
=20
+/*
+ * Hash buckets are shared by all the futex_keys that hash to the same
+ * location.  Each key may have multiple futex_q structures, one for each ta=
sk
+ * waiting on a futex.
+ */
+struct futex_hash_bucket {
+	atomic_t waiters;
+	spinlock_t lock;
+	struct plist_head chain;
+} ____cacheline_aligned_in_smp;
+
+/*
+ * Priority Inheritance state:
+ */
+struct futex_pi_state {
+	/*
+	 * list of 'owned' pi_state instances - these have to be
+	 * cleaned up in do_exit() if the task exits prematurely:
+	 */
+	struct list_head list;
+
+	/*
+	 * The PI object:
+	 */
+	struct rt_mutex_base pi_mutex;
+
+	struct task_struct *owner;
+	refcount_t refcount;
+
+	union futex_key key;
+} __randomize_layout;
+
+/**
+ * struct futex_q - The hashed futex queue entry, one per waiting task
+ * @list:		priority-sorted list of tasks waiting on this futex
+ * @task:		the task waiting on the futex
+ * @lock_ptr:		the hash bucket lock
+ * @key:		the key the futex is hashed on
+ * @pi_state:		optional priority inheritance state
+ * @rt_waiter:		rt_waiter storage for use with requeue_pi
+ * @requeue_pi_key:	the requeue_pi target futex key
+ * @bitset:		bitset for the optional bitmasked wakeup
+ * @requeue_state:	State field for futex_requeue_pi()
+ * @requeue_wait:	RCU wait for futex_requeue_pi() (RT only)
+ *
+ * We use this hashed waitqueue, instead of a normal wait_queue_entry_t, so
+ * we can wake only the relevant ones (hashed queues may be shared).
+ *
+ * A futex_q has a woken state, just like tasks have TASK_RUNNING.
+ * It is considered woken when plist_node_empty(&q->list) || q->lock_ptr =3D=
=3D 0.
+ * The order of wakeup is always to make the first condition true, then
+ * the second.
+ *
+ * PI futexes are typically woken before they are removed from the hash list=
 via
+ * the rt_mutex code. See futex_unqueue_pi().
+ */
+struct futex_q {
+	struct plist_node list;
+
+	struct task_struct *task;
+	spinlock_t *lock_ptr;
+	union futex_key key;
+	struct futex_pi_state *pi_state;
+	struct rt_mutex_waiter *rt_waiter;
+	union futex_key *requeue_pi_key;
+	u32 bitset;
+	atomic_t requeue_state;
+#ifdef CONFIG_PREEMPT_RT
+	struct rcuwait requeue_wait;
+#endif
+} __randomize_layout;
+
+extern const struct futex_q futex_q_init;
+
+enum futex_access {
+	FUTEX_READ,
+	FUTEX_WRITE
+};
+
+extern int get_futex_key(u32 __user *uaddr, bool fshared, union futex_key *k=
ey,
+			 enum futex_access rw);
+
+extern struct futex_hash_bucket *futex_hash(union futex_key *key);
+
+extern struct hrtimer_sleeper *
+futex_setup_timer(ktime_t *time, struct hrtimer_sleeper *timeout,
+		  int flags, u64 range_ns);
+
+extern int fault_in_user_writeable(u32 __user *uaddr);
+extern int futex_cmpxchg_value_locked(u32 *curval, u32 __user *uaddr, u32 uv=
al, u32 newval);
+extern int futex_get_value_locked(u32 *dest, u32 __user *from);
+extern struct futex_q *futex_top_waiter(struct futex_hash_bucket *hb, union =
futex_key *key);
+
+extern void __futex_queue(struct futex_q *q, struct futex_hash_bucket *hb);
+extern void futex_unqueue_pi(struct futex_q *q);
+
+extern void wait_for_owner_exiting(int ret, struct task_struct *exiting);
+
+extern struct futex_hash_bucket *futex_q_lock(struct futex_q *q);
+extern void futex_q_unlock(struct futex_hash_bucket *hb);
+
+
+extern int futex_lock_pi_atomic(u32 __user *uaddr, struct futex_hash_bucket =
*hb,
+				union futex_key *key,
+				struct futex_pi_state **ps,
+				struct task_struct *task,
+				struct task_struct **exiting,
+				int set_waiters);
+
+extern int refill_pi_state_cache(void);
+extern void get_pi_state(struct futex_pi_state *pi_state);
+extern void put_pi_state(struct futex_pi_state *pi_state);
+extern int fixup_pi_owner(u32 __user *uaddr, struct futex_q *q, int locked);
+
+/* syscalls */
+
 extern int futex_wait_requeue_pi(u32 __user *uaddr, unsigned int flags, u32
 				 val, ktime_t *abs_time, u32 bitset, u32 __user
 				 *uaddr2);
diff --git a/kernel/futex/pi.c b/kernel/futex/pi.c
new file mode 100644
index 0000000..183b28c
--- /dev/null
+++ b/kernel/futex/pi.c
@@ -0,0 +1,1233 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+
+#include <linux/slab.h>
+#include <linux/sched/task.h>
+
+#include "futex.h"
+#include "../locking/rtmutex_common.h"
+
+/*
+ * PI code:
+ */
+int refill_pi_state_cache(void)
+{
+	struct futex_pi_state *pi_state;
+
+	if (likely(current->pi_state_cache))
+		return 0;
+
+	pi_state =3D kzalloc(sizeof(*pi_state), GFP_KERNEL);
+
+	if (!pi_state)
+		return -ENOMEM;
+
+	INIT_LIST_HEAD(&pi_state->list);
+	/* pi_mutex gets initialized later */
+	pi_state->owner =3D NULL;
+	refcount_set(&pi_state->refcount, 1);
+	pi_state->key =3D FUTEX_KEY_INIT;
+
+	current->pi_state_cache =3D pi_state;
+
+	return 0;
+}
+
+static struct futex_pi_state *alloc_pi_state(void)
+{
+	struct futex_pi_state *pi_state =3D current->pi_state_cache;
+
+	WARN_ON(!pi_state);
+	current->pi_state_cache =3D NULL;
+
+	return pi_state;
+}
+
+static void pi_state_update_owner(struct futex_pi_state *pi_state,
+				  struct task_struct *new_owner)
+{
+	struct task_struct *old_owner =3D pi_state->owner;
+
+	lockdep_assert_held(&pi_state->pi_mutex.wait_lock);
+
+	if (old_owner) {
+		raw_spin_lock(&old_owner->pi_lock);
+		WARN_ON(list_empty(&pi_state->list));
+		list_del_init(&pi_state->list);
+		raw_spin_unlock(&old_owner->pi_lock);
+	}
+
+	if (new_owner) {
+		raw_spin_lock(&new_owner->pi_lock);
+		WARN_ON(!list_empty(&pi_state->list));
+		list_add(&pi_state->list, &new_owner->pi_state_list);
+		pi_state->owner =3D new_owner;
+		raw_spin_unlock(&new_owner->pi_lock);
+	}
+}
+
+void get_pi_state(struct futex_pi_state *pi_state)
+{
+	WARN_ON_ONCE(!refcount_inc_not_zero(&pi_state->refcount));
+}
+
+/*
+ * Drops a reference to the pi_state object and frees or caches it
+ * when the last reference is gone.
+ */
+void put_pi_state(struct futex_pi_state *pi_state)
+{
+	if (!pi_state)
+		return;
+
+	if (!refcount_dec_and_test(&pi_state->refcount))
+		return;
+
+	/*
+	 * If pi_state->owner is NULL, the owner is most probably dying
+	 * and has cleaned up the pi_state already
+	 */
+	if (pi_state->owner) {
+		unsigned long flags;
+
+		raw_spin_lock_irqsave(&pi_state->pi_mutex.wait_lock, flags);
+		pi_state_update_owner(pi_state, NULL);
+		rt_mutex_proxy_unlock(&pi_state->pi_mutex);
+		raw_spin_unlock_irqrestore(&pi_state->pi_mutex.wait_lock, flags);
+	}
+
+	if (current->pi_state_cache) {
+		kfree(pi_state);
+	} else {
+		/*
+		 * pi_state->list is already empty.
+		 * clear pi_state->owner.
+		 * refcount is at 0 - put it back to 1.
+		 */
+		pi_state->owner =3D NULL;
+		refcount_set(&pi_state->refcount, 1);
+		current->pi_state_cache =3D pi_state;
+	}
+}
+
+/*
+ * We need to check the following states:
+ *
+ *      Waiter | pi_state | pi->owner | uTID      | uODIED | ?
+ *
+ * [1]  NULL   | ---      | ---       | 0         | 0/1    | Valid
+ * [2]  NULL   | ---      | ---       | >0        | 0/1    | Valid
+ *
+ * [3]  Found  | NULL     | --        | Any       | 0/1    | Invalid
+ *
+ * [4]  Found  | Found    | NULL      | 0         | 1      | Valid
+ * [5]  Found  | Found    | NULL      | >0        | 1      | Invalid
+ *
+ * [6]  Found  | Found    | task      | 0         | 1      | Valid
+ *
+ * [7]  Found  | Found    | NULL      | Any       | 0      | Invalid
+ *
+ * [8]  Found  | Found    | task      | =3D=3DtaskTID | 0/1    | Valid
+ * [9]  Found  | Found    | task      | 0         | 0      | Invalid
+ * [10] Found  | Found    | task      | !=3DtaskTID | 0/1    | Invalid
+ *
+ * [1]	Indicates that the kernel can acquire the futex atomically. We
+ *	came here due to a stale FUTEX_WAITERS/FUTEX_OWNER_DIED bit.
+ *
+ * [2]	Valid, if TID does not belong to a kernel thread. If no matching
+ *      thread is found then it indicates that the owner TID has died.
+ *
+ * [3]	Invalid. The waiter is queued on a non PI futex
+ *
+ * [4]	Valid state after exit_robust_list(), which sets the user space
+ *	value to FUTEX_WAITERS | FUTEX_OWNER_DIED.
+ *
+ * [5]	The user space value got manipulated between exit_robust_list()
+ *	and exit_pi_state_list()
+ *
+ * [6]	Valid state after exit_pi_state_list() which sets the new owner in
+ *	the pi_state but cannot access the user space value.
+ *
+ * [7]	pi_state->owner can only be NULL when the OWNER_DIED bit is set.
+ *
+ * [8]	Owner and user space value match
+ *
+ * [9]	There is no transient state which sets the user space TID to 0
+ *	except exit_robust_list(), but this is indicated by the
+ *	FUTEX_OWNER_DIED bit. See [4]
+ *
+ * [10] There is no transient state which leaves owner and user space
+ *	TID out of sync. Except one error case where the kernel is denied
+ *	write access to the user address, see fixup_pi_state_owner().
+ *
+ *
+ * Serialization and lifetime rules:
+ *
+ * hb->lock:
+ *
+ *	hb -> futex_q, relation
+ *	futex_q -> pi_state, relation
+ *
+ *	(cannot be raw because hb can contain arbitrary amount
+ *	 of futex_q's)
+ *
+ * pi_mutex->wait_lock:
+ *
+ *	{uval, pi_state}
+ *
+ *	(and pi_mutex 'obviously')
+ *
+ * p->pi_lock:
+ *
+ *	p->pi_state_list -> pi_state->list, relation
+ *	pi_mutex->owner -> pi_state->owner, relation
+ *
+ * pi_state->refcount:
+ *
+ *	pi_state lifetime
+ *
+ *
+ * Lock order:
+ *
+ *   hb->lock
+ *     pi_mutex->wait_lock
+ *       p->pi_lock
+ *
+ */
+
+/*
+ * Validate that the existing waiter has a pi_state and sanity check
+ * the pi_state against the user space value. If correct, attach to
+ * it.
+ */
+static int attach_to_pi_state(u32 __user *uaddr, u32 uval,
+			      struct futex_pi_state *pi_state,
+			      struct futex_pi_state **ps)
+{
+	pid_t pid =3D uval & FUTEX_TID_MASK;
+	u32 uval2;
+	int ret;
+
+	/*
+	 * Userspace might have messed up non-PI and PI futexes [3]
+	 */
+	if (unlikely(!pi_state))
+		return -EINVAL;
+
+	/*
+	 * We get here with hb->lock held, and having found a
+	 * futex_top_waiter(). This means that futex_lock_pi() of said futex_q
+	 * has dropped the hb->lock in between futex_queue() and futex_unqueue_pi(),
+	 * which in turn means that futex_lock_pi() still has a reference on
+	 * our pi_state.
+	 *
+	 * The waiter holding a reference on @pi_state also protects against
+	 * the unlocked put_pi_state() in futex_unlock_pi(), futex_lock_pi()
+	 * and futex_wait_requeue_pi() as it cannot go to 0 and consequently
+	 * free pi_state before we can take a reference ourselves.
+	 */
+	WARN_ON(!refcount_read(&pi_state->refcount));
+
+	/*
+	 * Now that we have a pi_state, we can acquire wait_lock
+	 * and do the state validation.
+	 */
+	raw_spin_lock_irq(&pi_state->pi_mutex.wait_lock);
+
+	/*
+	 * Since {uval, pi_state} is serialized by wait_lock, and our current
+	 * uval was read without holding it, it can have changed. Verify it
+	 * still is what we expect it to be, otherwise retry the entire
+	 * operation.
+	 */
+	if (futex_get_value_locked(&uval2, uaddr))
+		goto out_efault;
+
+	if (uval !=3D uval2)
+		goto out_eagain;
+
+	/*
+	 * Handle the owner died case:
+	 */
+	if (uval & FUTEX_OWNER_DIED) {
+		/*
+		 * exit_pi_state_list sets owner to NULL and wakes the
+		 * topmost waiter. The task which acquires the
+		 * pi_state->rt_mutex will fixup owner.
+		 */
+		if (!pi_state->owner) {
+			/*
+			 * No pi state owner, but the user space TID
+			 * is not 0. Inconsistent state. [5]
+			 */
+			if (pid)
+				goto out_einval;
+			/*
+			 * Take a ref on the state and return success. [4]
+			 */
+			goto out_attach;
+		}
+
+		/*
+		 * If TID is 0, then either the dying owner has not
+		 * yet executed exit_pi_state_list() or some waiter
+		 * acquired the rtmutex in the pi state, but did not
+		 * yet fixup the TID in user space.
+		 *
+		 * Take a ref on the state and return success. [6]
+		 */
+		if (!pid)
+			goto out_attach;
+	} else {
+		/*
+		 * If the owner died bit is not set, then the pi_state
+		 * must have an owner. [7]
+		 */
+		if (!pi_state->owner)
+			goto out_einval;
+	}
+
+	/*
+	 * Bail out if user space manipulated the futex value. If pi
+	 * state exists then the owner TID must be the same as the
+	 * user space TID. [9/10]
+	 */
+	if (pid !=3D task_pid_vnr(pi_state->owner))
+		goto out_einval;
+
+out_attach:
+	get_pi_state(pi_state);
+	raw_spin_unlock_irq(&pi_state->pi_mutex.wait_lock);
+	*ps =3D pi_state;
+	return 0;
+
+out_einval:
+	ret =3D -EINVAL;
+	goto out_error;
+
+out_eagain:
+	ret =3D -EAGAIN;
+	goto out_error;
+
+out_efault:
+	ret =3D -EFAULT;
+	goto out_error;
+
+out_error:
+	raw_spin_unlock_irq(&pi_state->pi_mutex.wait_lock);
+	return ret;
+}
+
+static int handle_exit_race(u32 __user *uaddr, u32 uval,
+			    struct task_struct *tsk)
+{
+	u32 uval2;
+
+	/*
+	 * If the futex exit state is not yet FUTEX_STATE_DEAD, tell the
+	 * caller that the alleged owner is busy.
+	 */
+	if (tsk && tsk->futex_state !=3D FUTEX_STATE_DEAD)
+		return -EBUSY;
+
+	/*
+	 * Reread the user space value to handle the following situation:
+	 *
+	 * CPU0				CPU1
+	 *
+	 * sys_exit()			sys_futex()
+	 *  do_exit()			 futex_lock_pi()
+	 *                                futex_lock_pi_atomic()
+	 *   exit_signals(tsk)		    No waiters:
+	 *    tsk->flags |=3D PF_EXITING;	    *uaddr =3D=3D 0x00000PID
+	 *  mm_release(tsk)		    Set waiter bit
+	 *   exit_robust_list(tsk) {	    *uaddr =3D 0x80000PID;
+	 *      Set owner died		    attach_to_pi_owner() {
+	 *    *uaddr =3D 0xC0000000;	     tsk =3D get_task(PID);
+	 *   }				     if (!tsk->flags & PF_EXITING) {
+	 *  ...				       attach();
+	 *  tsk->futex_state =3D               } else {
+	 *	FUTEX_STATE_DEAD;              if (tsk->futex_state !=3D
+	 *					  FUTEX_STATE_DEAD)
+	 *				         return -EAGAIN;
+	 *				       return -ESRCH; <--- FAIL
+	 *				     }
+	 *
+	 * Returning ESRCH unconditionally is wrong here because the
+	 * user space value has been changed by the exiting task.
+	 *
+	 * The same logic applies to the case where the exiting task is
+	 * already gone.
+	 */
+	if (futex_get_value_locked(&uval2, uaddr))
+		return -EFAULT;
+
+	/* If the user space value has changed, try again. */
+	if (uval2 !=3D uval)
+		return -EAGAIN;
+
+	/*
+	 * The exiting task did not have a robust list, the robust list was
+	 * corrupted or the user space value in *uaddr is simply bogus.
+	 * Give up and tell user space.
+	 */
+	return -ESRCH;
+}
+
+static void __attach_to_pi_owner(struct task_struct *p, union futex_key *key,
+				 struct futex_pi_state **ps)
+{
+	/*
+	 * No existing pi state. First waiter. [2]
+	 *
+	 * This creates pi_state, we have hb->lock held, this means nothing can
+	 * observe this state, wait_lock is irrelevant.
+	 */
+	struct futex_pi_state *pi_state =3D alloc_pi_state();
+
+	/*
+	 * Initialize the pi_mutex in locked state and make @p
+	 * the owner of it:
+	 */
+	rt_mutex_init_proxy_locked(&pi_state->pi_mutex, p);
+
+	/* Store the key for possible exit cleanups: */
+	pi_state->key =3D *key;
+
+	WARN_ON(!list_empty(&pi_state->list));
+	list_add(&pi_state->list, &p->pi_state_list);
+	/*
+	 * Assignment without holding pi_state->pi_mutex.wait_lock is safe
+	 * because there is no concurrency as the object is not published yet.
+	 */
+	pi_state->owner =3D p;
+
+	*ps =3D pi_state;
+}
+/*
+ * Lookup the task for the TID provided from user space and attach to
+ * it after doing proper sanity checks.
+ */
+static int attach_to_pi_owner(u32 __user *uaddr, u32 uval, union futex_key *=
key,
+			      struct futex_pi_state **ps,
+			      struct task_struct **exiting)
+{
+	pid_t pid =3D uval & FUTEX_TID_MASK;
+	struct task_struct *p;
+
+	/*
+	 * We are the first waiter - try to look up the real owner and attach
+	 * the new pi_state to it, but bail out when TID =3D 0 [1]
+	 *
+	 * The !pid check is paranoid. None of the call sites should end up
+	 * with pid =3D=3D 0, but better safe than sorry. Let the caller retry
+	 */
+	if (!pid)
+		return -EAGAIN;
+	p =3D find_get_task_by_vpid(pid);
+	if (!p)
+		return handle_exit_race(uaddr, uval, NULL);
+
+	if (unlikely(p->flags & PF_KTHREAD)) {
+		put_task_struct(p);
+		return -EPERM;
+	}
+
+	/*
+	 * We need to look at the task state to figure out, whether the
+	 * task is exiting. To protect against the change of the task state
+	 * in futex_exit_release(), we do this protected by p->pi_lock:
+	 */
+	raw_spin_lock_irq(&p->pi_lock);
+	if (unlikely(p->futex_state !=3D FUTEX_STATE_OK)) {
+		/*
+		 * The task is on the way out. When the futex state is
+		 * FUTEX_STATE_DEAD, we know that the task has finished
+		 * the cleanup:
+		 */
+		int ret =3D handle_exit_race(uaddr, uval, p);
+
+		raw_spin_unlock_irq(&p->pi_lock);
+		/*
+		 * If the owner task is between FUTEX_STATE_EXITING and
+		 * FUTEX_STATE_DEAD then store the task pointer and keep
+		 * the reference on the task struct. The calling code will
+		 * drop all locks, wait for the task to reach
+		 * FUTEX_STATE_DEAD and then drop the refcount. This is
+		 * required to prevent a live lock when the current task
+		 * preempted the exiting task between the two states.
+		 */
+		if (ret =3D=3D -EBUSY)
+			*exiting =3D p;
+		else
+			put_task_struct(p);
+		return ret;
+	}
+
+	__attach_to_pi_owner(p, key, ps);
+	raw_spin_unlock_irq(&p->pi_lock);
+
+	put_task_struct(p);
+
+	return 0;
+}
+
+static int lock_pi_update_atomic(u32 __user *uaddr, u32 uval, u32 newval)
+{
+	int err;
+	u32 curval;
+
+	if (unlikely(should_fail_futex(true)))
+		return -EFAULT;
+
+	err =3D futex_cmpxchg_value_locked(&curval, uaddr, uval, newval);
+	if (unlikely(err))
+		return err;
+
+	/* If user space value changed, let the caller retry */
+	return curval !=3D uval ? -EAGAIN : 0;
+}
+
+/**
+ * futex_lock_pi_atomic() - Atomic work required to acquire a pi aware futex
+ * @uaddr:		the pi futex user address
+ * @hb:			the pi futex hash bucket
+ * @key:		the futex key associated with uaddr and hb
+ * @ps:			the pi_state pointer where we store the result of the
+ *			lookup
+ * @task:		the task to perform the atomic lock work for.  This will
+ *			be "current" except in the case of requeue pi.
+ * @exiting:		Pointer to store the task pointer of the owner task
+ *			which is in the middle of exiting
+ * @set_waiters:	force setting the FUTEX_WAITERS bit (1) or not (0)
+ *
+ * Return:
+ *  -  0 - ready to wait;
+ *  -  1 - acquired the lock;
+ *  - <0 - error
+ *
+ * The hb->lock must be held by the caller.
+ *
+ * @exiting is only set when the return value is -EBUSY. If so, this holds
+ * a refcount on the exiting task on return and the caller needs to drop it
+ * after waiting for the exit to complete.
+ */
+int futex_lock_pi_atomic(u32 __user *uaddr, struct futex_hash_bucket *hb,
+			 union futex_key *key,
+			 struct futex_pi_state **ps,
+			 struct task_struct *task,
+			 struct task_struct **exiting,
+			 int set_waiters)
+{
+	u32 uval, newval, vpid =3D task_pid_vnr(task);
+	struct futex_q *top_waiter;
+	int ret;
+
+	/*
+	 * Read the user space value first so we can validate a few
+	 * things before proceeding further.
+	 */
+	if (futex_get_value_locked(&uval, uaddr))
+		return -EFAULT;
+
+	if (unlikely(should_fail_futex(true)))
+		return -EFAULT;
+
+	/*
+	 * Detect deadlocks.
+	 */
+	if ((unlikely((uval & FUTEX_TID_MASK) =3D=3D vpid)))
+		return -EDEADLK;
+
+	if ((unlikely(should_fail_futex(true))))
+		return -EDEADLK;
+
+	/*
+	 * Lookup existing state first. If it exists, try to attach to
+	 * its pi_state.
+	 */
+	top_waiter =3D futex_top_waiter(hb, key);
+	if (top_waiter)
+		return attach_to_pi_state(uaddr, uval, top_waiter->pi_state, ps);
+
+	/*
+	 * No waiter and user TID is 0. We are here because the
+	 * waiters or the owner died bit is set or called from
+	 * requeue_cmp_pi or for whatever reason something took the
+	 * syscall.
+	 */
+	if (!(uval & FUTEX_TID_MASK)) {
+		/*
+		 * We take over the futex. No other waiters and the user space
+		 * TID is 0. We preserve the owner died bit.
+		 */
+		newval =3D uval & FUTEX_OWNER_DIED;
+		newval |=3D vpid;
+
+		/* The futex requeue_pi code can enforce the waiters bit */
+		if (set_waiters)
+			newval |=3D FUTEX_WAITERS;
+
+		ret =3D lock_pi_update_atomic(uaddr, uval, newval);
+		if (ret)
+			return ret;
+
+		/*
+		 * If the waiter bit was requested the caller also needs PI
+		 * state attached to the new owner of the user space futex.
+		 *
+		 * @task is guaranteed to be alive and it cannot be exiting
+		 * because it is either sleeping or waiting in
+		 * futex_requeue_pi_wakeup_sync().
+		 *
+		 * No need to do the full attach_to_pi_owner() exercise
+		 * because @task is known and valid.
+		 */
+		if (set_waiters) {
+			raw_spin_lock_irq(&task->pi_lock);
+			__attach_to_pi_owner(task, key, ps);
+			raw_spin_unlock_irq(&task->pi_lock);
+		}
+		return 1;
+	}
+
+	/*
+	 * First waiter. Set the waiters bit before attaching ourself to
+	 * the owner. If owner tries to unlock, it will be forced into
+	 * the kernel and blocked on hb->lock.
+	 */
+	newval =3D uval | FUTEX_WAITERS;
+	ret =3D lock_pi_update_atomic(uaddr, uval, newval);
+	if (ret)
+		return ret;
+	/*
+	 * If the update of the user space value succeeded, we try to
+	 * attach to the owner. If that fails, no harm done, we only
+	 * set the FUTEX_WAITERS bit in the user space variable.
+	 */
+	return attach_to_pi_owner(uaddr, newval, key, ps, exiting);
+}
+
+/*
+ * Caller must hold a reference on @pi_state.
+ */
+static int wake_futex_pi(u32 __user *uaddr, u32 uval, struct futex_pi_state =
*pi_state)
+{
+	struct rt_mutex_waiter *top_waiter;
+	struct task_struct *new_owner;
+	bool postunlock =3D false;
+	DEFINE_RT_WAKE_Q(wqh);
+	u32 curval, newval;
+	int ret =3D 0;
+
+	top_waiter =3D rt_mutex_top_waiter(&pi_state->pi_mutex);
+	if (WARN_ON_ONCE(!top_waiter)) {
+		/*
+		 * As per the comment in futex_unlock_pi() this should not happen.
+		 *
+		 * When this happens, give up our locks and try again, giving
+		 * the futex_lock_pi() instance time to complete, either by
+		 * waiting on the rtmutex or removing itself from the futex
+		 * queue.
+		 */
+		ret =3D -EAGAIN;
+		goto out_unlock;
+	}
+
+	new_owner =3D top_waiter->task;
+
+	/*
+	 * We pass it to the next owner. The WAITERS bit is always kept
+	 * enabled while there is PI state around. We cleanup the owner
+	 * died bit, because we are the owner.
+	 */
+	newval =3D FUTEX_WAITERS | task_pid_vnr(new_owner);
+
+	if (unlikely(should_fail_futex(true))) {
+		ret =3D -EFAULT;
+		goto out_unlock;
+	}
+
+	ret =3D futex_cmpxchg_value_locked(&curval, uaddr, uval, newval);
+	if (!ret && (curval !=3D uval)) {
+		/*
+		 * If a unconditional UNLOCK_PI operation (user space did not
+		 * try the TID->0 transition) raced with a waiter setting the
+		 * FUTEX_WAITERS flag between get_user() and locking the hash
+		 * bucket lock, retry the operation.
+		 */
+		if ((FUTEX_TID_MASK & curval) =3D=3D uval)
+			ret =3D -EAGAIN;
+		else
+			ret =3D -EINVAL;
+	}
+
+	if (!ret) {
+		/*
+		 * This is a point of no return; once we modified the uval
+		 * there is no going back and subsequent operations must
+		 * not fail.
+		 */
+		pi_state_update_owner(pi_state, new_owner);
+		postunlock =3D __rt_mutex_futex_unlock(&pi_state->pi_mutex, &wqh);
+	}
+
+out_unlock:
+	raw_spin_unlock_irq(&pi_state->pi_mutex.wait_lock);
+
+	if (postunlock)
+		rt_mutex_postunlock(&wqh);
+
+	return ret;
+}
+
+static int __fixup_pi_state_owner(u32 __user *uaddr, struct futex_q *q,
+				  struct task_struct *argowner)
+{
+	struct futex_pi_state *pi_state =3D q->pi_state;
+	struct task_struct *oldowner, *newowner;
+	u32 uval, curval, newval, newtid;
+	int err =3D 0;
+
+	oldowner =3D pi_state->owner;
+
+	/*
+	 * We are here because either:
+	 *
+	 *  - we stole the lock and pi_state->owner needs updating to reflect
+	 *    that (@argowner =3D=3D current),
+	 *
+	 * or:
+	 *
+	 *  - someone stole our lock and we need to fix things to point to the
+	 *    new owner (@argowner =3D=3D NULL).
+	 *
+	 * Either way, we have to replace the TID in the user space variable.
+	 * This must be atomic as we have to preserve the owner died bit here.
+	 *
+	 * Note: We write the user space value _before_ changing the pi_state
+	 * because we can fault here. Imagine swapped out pages or a fork
+	 * that marked all the anonymous memory readonly for cow.
+	 *
+	 * Modifying pi_state _before_ the user space value would leave the
+	 * pi_state in an inconsistent state when we fault here, because we
+	 * need to drop the locks to handle the fault. This might be observed
+	 * in the PID checks when attaching to PI state .
+	 */
+retry:
+	if (!argowner) {
+		if (oldowner !=3D current) {
+			/*
+			 * We raced against a concurrent self; things are
+			 * already fixed up. Nothing to do.
+			 */
+			return 0;
+		}
+
+		if (__rt_mutex_futex_trylock(&pi_state->pi_mutex)) {
+			/* We got the lock. pi_state is correct. Tell caller. */
+			return 1;
+		}
+
+		/*
+		 * The trylock just failed, so either there is an owner or
+		 * there is a higher priority waiter than this one.
+		 */
+		newowner =3D rt_mutex_owner(&pi_state->pi_mutex);
+		/*
+		 * If the higher priority waiter has not yet taken over the
+		 * rtmutex then newowner is NULL. We can't return here with
+		 * that state because it's inconsistent vs. the user space
+		 * state. So drop the locks and try again. It's a valid
+		 * situation and not any different from the other retry
+		 * conditions.
+		 */
+		if (unlikely(!newowner)) {
+			err =3D -EAGAIN;
+			goto handle_err;
+		}
+	} else {
+		WARN_ON_ONCE(argowner !=3D current);
+		if (oldowner =3D=3D current) {
+			/*
+			 * We raced against a concurrent self; things are
+			 * already fixed up. Nothing to do.
+			 */
+			return 1;
+		}
+		newowner =3D argowner;
+	}
+
+	newtid =3D task_pid_vnr(newowner) | FUTEX_WAITERS;
+	/* Owner died? */
+	if (!pi_state->owner)
+		newtid |=3D FUTEX_OWNER_DIED;
+
+	err =3D futex_get_value_locked(&uval, uaddr);
+	if (err)
+		goto handle_err;
+
+	for (;;) {
+		newval =3D (uval & FUTEX_OWNER_DIED) | newtid;
+
+		err =3D futex_cmpxchg_value_locked(&curval, uaddr, uval, newval);
+		if (err)
+			goto handle_err;
+
+		if (curval =3D=3D uval)
+			break;
+		uval =3D curval;
+	}
+
+	/*
+	 * We fixed up user space. Now we need to fix the pi_state
+	 * itself.
+	 */
+	pi_state_update_owner(pi_state, newowner);
+
+	return argowner =3D=3D current;
+
+	/*
+	 * In order to reschedule or handle a page fault, we need to drop the
+	 * locks here. In the case of a fault, this gives the other task
+	 * (either the highest priority waiter itself or the task which stole
+	 * the rtmutex) the chance to try the fixup of the pi_state. So once we
+	 * are back from handling the fault we need to check the pi_state after
+	 * reacquiring the locks and before trying to do another fixup. When
+	 * the fixup has been done already we simply return.
+	 *
+	 * Note: we hold both hb->lock and pi_mutex->wait_lock. We can safely
+	 * drop hb->lock since the caller owns the hb -> futex_q relation.
+	 * Dropping the pi_mutex->wait_lock requires the state revalidate.
+	 */
+handle_err:
+	raw_spin_unlock_irq(&pi_state->pi_mutex.wait_lock);
+	spin_unlock(q->lock_ptr);
+
+	switch (err) {
+	case -EFAULT:
+		err =3D fault_in_user_writeable(uaddr);
+		break;
+
+	case -EAGAIN:
+		cond_resched();
+		err =3D 0;
+		break;
+
+	default:
+		WARN_ON_ONCE(1);
+		break;
+	}
+
+	spin_lock(q->lock_ptr);
+	raw_spin_lock_irq(&pi_state->pi_mutex.wait_lock);
+
+	/*
+	 * Check if someone else fixed it for us:
+	 */
+	if (pi_state->owner !=3D oldowner)
+		return argowner =3D=3D current;
+
+	/* Retry if err was -EAGAIN or the fault in succeeded */
+	if (!err)
+		goto retry;
+
+	/*
+	 * fault_in_user_writeable() failed so user state is immutable. At
+	 * best we can make the kernel state consistent but user state will
+	 * be most likely hosed and any subsequent unlock operation will be
+	 * rejected due to PI futex rule [10].
+	 *
+	 * Ensure that the rtmutex owner is also the pi_state owner despite
+	 * the user space value claiming something different. There is no
+	 * point in unlocking the rtmutex if current is the owner as it
+	 * would need to wait until the next waiter has taken the rtmutex
+	 * to guarantee consistent state. Keep it simple. Userspace asked
+	 * for this wreckaged state.
+	 *
+	 * The rtmutex has an owner - either current or some other
+	 * task. See the EAGAIN loop above.
+	 */
+	pi_state_update_owner(pi_state, rt_mutex_owner(&pi_state->pi_mutex));
+
+	return err;
+}
+
+static int fixup_pi_state_owner(u32 __user *uaddr, struct futex_q *q,
+				struct task_struct *argowner)
+{
+	struct futex_pi_state *pi_state =3D q->pi_state;
+	int ret;
+
+	lockdep_assert_held(q->lock_ptr);
+
+	raw_spin_lock_irq(&pi_state->pi_mutex.wait_lock);
+	ret =3D __fixup_pi_state_owner(uaddr, q, argowner);
+	raw_spin_unlock_irq(&pi_state->pi_mutex.wait_lock);
+	return ret;
+}
+
+/**
+ * fixup_pi_owner() - Post lock pi_state and corner case management
+ * @uaddr:	user address of the futex
+ * @q:		futex_q (contains pi_state and access to the rt_mutex)
+ * @locked:	if the attempt to take the rt_mutex succeeded (1) or not (0)
+ *
+ * After attempting to lock an rt_mutex, this function is called to cleanup
+ * the pi_state owner as well as handle race conditions that may allow us to
+ * acquire the lock. Must be called with the hb lock held.
+ *
+ * Return:
+ *  -  1 - success, lock taken;
+ *  -  0 - success, lock not taken;
+ *  - <0 - on error (-EFAULT)
+ */
+int fixup_pi_owner(u32 __user *uaddr, struct futex_q *q, int locked)
+{
+	if (locked) {
+		/*
+		 * Got the lock. We might not be the anticipated owner if we
+		 * did a lock-steal - fix up the PI-state in that case:
+		 *
+		 * Speculative pi_state->owner read (we don't hold wait_lock);
+		 * since we own the lock pi_state->owner =3D=3D current is the
+		 * stable state, anything else needs more attention.
+		 */
+		if (q->pi_state->owner !=3D current)
+			return fixup_pi_state_owner(uaddr, q, current);
+		return 1;
+	}
+
+	/*
+	 * If we didn't get the lock; check if anybody stole it from us. In
+	 * that case, we need to fix up the uval to point to them instead of
+	 * us, otherwise bad things happen. [10]
+	 *
+	 * Another speculative read; pi_state->owner =3D=3D current is unstable
+	 * but needs our attention.
+	 */
+	if (q->pi_state->owner =3D=3D current)
+		return fixup_pi_state_owner(uaddr, q, NULL);
+
+	/*
+	 * Paranoia check. If we did not take the lock, then we should not be
+	 * the owner of the rt_mutex. Warn and establish consistent state.
+	 */
+	if (WARN_ON_ONCE(rt_mutex_owner(&q->pi_state->pi_mutex) =3D=3D current))
+		return fixup_pi_state_owner(uaddr, q, current);
+
+	return 0;
+}
+
+/*
+ * Userspace tried a 0 -> TID atomic transition of the futex value
+ * and failed. The kernel side here does the whole locking operation:
+ * if there are waiters then it will block as a consequence of relying
+ * on rt-mutexes, it does PI, etc. (Due to races the kernel might see
+ * a 0 value of the futex too.).
+ *
+ * Also serves as futex trylock_pi()'ing, and due semantics.
+ */
+int futex_lock_pi(u32 __user *uaddr, unsigned int flags, ktime_t *time, int =
trylock)
+{
+	struct hrtimer_sleeper timeout, *to;
+	struct task_struct *exiting =3D NULL;
+	struct rt_mutex_waiter rt_waiter;
+	struct futex_hash_bucket *hb;
+	struct futex_q q =3D futex_q_init;
+	int res, ret;
+
+	if (!IS_ENABLED(CONFIG_FUTEX_PI))
+		return -ENOSYS;
+
+	if (refill_pi_state_cache())
+		return -ENOMEM;
+
+	to =3D futex_setup_timer(time, &timeout, flags, 0);
+
+retry:
+	ret =3D get_futex_key(uaddr, flags & FLAGS_SHARED, &q.key, FUTEX_WRITE);
+	if (unlikely(ret !=3D 0))
+		goto out;
+
+retry_private:
+	hb =3D futex_q_lock(&q);
+
+	ret =3D futex_lock_pi_atomic(uaddr, hb, &q.key, &q.pi_state, current,
+				   &exiting, 0);
+	if (unlikely(ret)) {
+		/*
+		 * Atomic work succeeded and we got the lock,
+		 * or failed. Either way, we do _not_ block.
+		 */
+		switch (ret) {
+		case 1:
+			/* We got the lock. */
+			ret =3D 0;
+			goto out_unlock_put_key;
+		case -EFAULT:
+			goto uaddr_faulted;
+		case -EBUSY:
+		case -EAGAIN:
+			/*
+			 * Two reasons for this:
+			 * - EBUSY: Task is exiting and we just wait for the
+			 *   exit to complete.
+			 * - EAGAIN: The user space value changed.
+			 */
+			futex_q_unlock(hb);
+			/*
+			 * Handle the case where the owner is in the middle of
+			 * exiting. Wait for the exit to complete otherwise
+			 * this task might loop forever, aka. live lock.
+			 */
+			wait_for_owner_exiting(ret, exiting);
+			cond_resched();
+			goto retry;
+		default:
+			goto out_unlock_put_key;
+		}
+	}
+
+	WARN_ON(!q.pi_state);
+
+	/*
+	 * Only actually queue now that the atomic ops are done:
+	 */
+	__futex_queue(&q, hb);
+
+	if (trylock) {
+		ret =3D rt_mutex_futex_trylock(&q.pi_state->pi_mutex);
+		/* Fixup the trylock return value: */
+		ret =3D ret ? 0 : -EWOULDBLOCK;
+		goto no_block;
+	}
+
+	rt_mutex_init_waiter(&rt_waiter);
+
+	/*
+	 * On PREEMPT_RT_FULL, when hb->lock becomes an rt_mutex, we must not
+	 * hold it while doing rt_mutex_start_proxy(), because then it will
+	 * include hb->lock in the blocking chain, even through we'll not in
+	 * fact hold it while blocking. This will lead it to report -EDEADLK
+	 * and BUG when futex_unlock_pi() interleaves with this.
+	 *
+	 * Therefore acquire wait_lock while holding hb->lock, but drop the
+	 * latter before calling __rt_mutex_start_proxy_lock(). This
+	 * interleaves with futex_unlock_pi() -- which does a similar lock
+	 * handoff -- such that the latter can observe the futex_q::pi_state
+	 * before __rt_mutex_start_proxy_lock() is done.
+	 */
+	raw_spin_lock_irq(&q.pi_state->pi_mutex.wait_lock);
+	spin_unlock(q.lock_ptr);
+	/*
+	 * __rt_mutex_start_proxy_lock() unconditionally enqueues the @rt_waiter
+	 * such that futex_unlock_pi() is guaranteed to observe the waiter when
+	 * it sees the futex_q::pi_state.
+	 */
+	ret =3D __rt_mutex_start_proxy_lock(&q.pi_state->pi_mutex, &rt_waiter, curr=
ent);
+	raw_spin_unlock_irq(&q.pi_state->pi_mutex.wait_lock);
+
+	if (ret) {
+		if (ret =3D=3D 1)
+			ret =3D 0;
+		goto cleanup;
+	}
+
+	if (unlikely(to))
+		hrtimer_sleeper_start_expires(to, HRTIMER_MODE_ABS);
+
+	ret =3D rt_mutex_wait_proxy_lock(&q.pi_state->pi_mutex, to, &rt_waiter);
+
+cleanup:
+	spin_lock(q.lock_ptr);
+	/*
+	 * If we failed to acquire the lock (deadlock/signal/timeout), we must
+	 * first acquire the hb->lock before removing the lock from the
+	 * rt_mutex waitqueue, such that we can keep the hb and rt_mutex wait
+	 * lists consistent.
+	 *
+	 * In particular; it is important that futex_unlock_pi() can not
+	 * observe this inconsistency.
+	 */
+	if (ret && !rt_mutex_cleanup_proxy_lock(&q.pi_state->pi_mutex, &rt_waiter))
+		ret =3D 0;
+
+no_block:
+	/*
+	 * Fixup the pi_state owner and possibly acquire the lock if we
+	 * haven't already.
+	 */
+	res =3D fixup_pi_owner(uaddr, &q, !ret);
+	/*
+	 * If fixup_pi_owner() returned an error, propagate that.  If it acquired
+	 * the lock, clear our -ETIMEDOUT or -EINTR.
+	 */
+	if (res)
+		ret =3D (res < 0) ? res : 0;
+
+	futex_unqueue_pi(&q);
+	spin_unlock(q.lock_ptr);
+	goto out;
+
+out_unlock_put_key:
+	futex_q_unlock(hb);
+
+out:
+	if (to) {
+		hrtimer_cancel(&to->timer);
+		destroy_hrtimer_on_stack(&to->timer);
+	}
+	return ret !=3D -EINTR ? ret : -ERESTARTNOINTR;
+
+uaddr_faulted:
+	futex_q_unlock(hb);
+
+	ret =3D fault_in_user_writeable(uaddr);
+	if (ret)
+		goto out;
+
+	if (!(flags & FLAGS_SHARED))
+		goto retry_private;
+
+	goto retry;
+}
+
+/*
+ * Userspace attempted a TID -> 0 atomic transition, and failed.
+ * This is the in-kernel slowpath: we look up the PI state (if any),
+ * and do the rt-mutex unlock.
+ */
+int futex_unlock_pi(u32 __user *uaddr, unsigned int flags)
+{
+	u32 curval, uval, vpid =3D task_pid_vnr(current);
+	union futex_key key =3D FUTEX_KEY_INIT;
+	struct futex_hash_bucket *hb;
+	struct futex_q *top_waiter;
+	int ret;
+
+	if (!IS_ENABLED(CONFIG_FUTEX_PI))
+		return -ENOSYS;
+
+retry:
+	if (get_user(uval, uaddr))
+		return -EFAULT;
+	/*
+	 * We release only a lock we actually own:
+	 */
+	if ((uval & FUTEX_TID_MASK) !=3D vpid)
+		return -EPERM;
+
+	ret =3D get_futex_key(uaddr, flags & FLAGS_SHARED, &key, FUTEX_WRITE);
+	if (ret)
+		return ret;
+
+	hb =3D futex_hash(&key);
+	spin_lock(&hb->lock);
+
+	/*
+	 * Check waiters first. We do not trust user space values at
+	 * all and we at least want to know if user space fiddled
+	 * with the futex value instead of blindly unlocking.
+	 */
+	top_waiter =3D futex_top_waiter(hb, &key);
+	if (top_waiter) {
+		struct futex_pi_state *pi_state =3D top_waiter->pi_state;
+
+		ret =3D -EINVAL;
+		if (!pi_state)
+			goto out_unlock;
+
+		/*
+		 * If current does not own the pi_state then the futex is
+		 * inconsistent and user space fiddled with the futex value.
+		 */
+		if (pi_state->owner !=3D current)
+			goto out_unlock;
+
+		get_pi_state(pi_state);
+		/*
+		 * By taking wait_lock while still holding hb->lock, we ensure
+		 * there is no point where we hold neither; and therefore
+		 * wake_futex_p() must observe a state consistent with what we
+		 * observed.
+		 *
+		 * In particular; this forces __rt_mutex_start_proxy() to
+		 * complete such that we're guaranteed to observe the
+		 * rt_waiter. Also see the WARN in wake_futex_pi().
+		 */
+		raw_spin_lock_irq(&pi_state->pi_mutex.wait_lock);
+		spin_unlock(&hb->lock);
+
+		/* drops pi_state->pi_mutex.wait_lock */
+		ret =3D wake_futex_pi(uaddr, uval, pi_state);
+
+		put_pi_state(pi_state);
+
+		/*
+		 * Success, we're done! No tricky corner cases.
+		 */
+		if (!ret)
+			return ret;
+		/*
+		 * The atomic access to the futex value generated a
+		 * pagefault, so retry the user-access and the wakeup:
+		 */
+		if (ret =3D=3D -EFAULT)
+			goto pi_faulted;
+		/*
+		 * A unconditional UNLOCK_PI op raced against a waiter
+		 * setting the FUTEX_WAITERS bit. Try again.
+		 */
+		if (ret =3D=3D -EAGAIN)
+			goto pi_retry;
+		/*
+		 * wake_futex_pi has detected invalid state. Tell user
+		 * space.
+		 */
+		return ret;
+	}
+
+	/*
+	 * We have no kernel internal state, i.e. no waiters in the
+	 * kernel. Waiters which are about to queue themselves are stuck
+	 * on hb->lock. So we can safely ignore them. We do neither
+	 * preserve the WAITERS bit not the OWNER_DIED one. We are the
+	 * owner.
+	 */
+	if ((ret =3D futex_cmpxchg_value_locked(&curval, uaddr, uval, 0))) {
+		spin_unlock(&hb->lock);
+		switch (ret) {
+		case -EFAULT:
+			goto pi_faulted;
+
+		case -EAGAIN:
+			goto pi_retry;
+
+		default:
+			WARN_ON_ONCE(1);
+			return ret;
+		}
+	}
+
+	/*
+	 * If uval has changed, let user space handle it.
+	 */
+	ret =3D (curval =3D=3D uval) ? 0 : -EAGAIN;
+
+out_unlock:
+	spin_unlock(&hb->lock);
+	return ret;
+
+pi_retry:
+	cond_resched();
+	goto retry;
+
+pi_faulted:
+
+	ret =3D fault_in_user_writeable(uaddr);
+	if (!ret)
+		goto retry;
+
+	return ret;
+}
+
