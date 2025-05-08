Return-Path: <linux-tip-commits+bounces-5472-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 36894AAF7F8
	for <lists+linux-tip-commits@lfdr.de>; Thu,  8 May 2025 12:36:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B2DD04E33A2
	for <lists+linux-tip-commits@lfdr.de>; Thu,  8 May 2025 10:35:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E141B22541C;
	Thu,  8 May 2025 10:33:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="pecKZB3p";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="aCoD7raK"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4046F21ABA8;
	Thu,  8 May 2025 10:33:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746700435; cv=none; b=KET30nqz8Ro0oWtAwNWeIlWsWj84nrTzEFIEPInVqUzjImUnyKRiSZj8QyATkOMDOLqVDWqL+R5AkL3jASlJhbnliDaOjBpCQAzOf0u05S0kqvSdP7UdkoJ50jGLpXC1vBW913SyMQO7sQ6Vskimid9H1fqfO4PvAKNYIlL++ic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746700435; c=relaxed/simple;
	bh=zpSbfrZF3AJ7rpd9/eec1jWO/j1ADDtr2+kMo/g61iQ=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=M0OruxTdeYvQsQ0F9vFdP0+j45kgYoeEZMqaYf/ZmbkXOyfKrGoPo6fJs6vaL1KVGBMrBhDoTLNzbglMG88lAVhtVvML6txrJRsx5vv7EgunaztSNgE2Ax8nsCSmWbaHJAvq7eDjvV0pBD8lj+kyyk9crHkmkrnFOSyFdpIjecE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=pecKZB3p; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=aCoD7raK; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 08 May 2025 10:33:50 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1746700431;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lJXvNCJAyYuawXUWVP5BfFNLWPZ/cC6cuD0bsAGJxLg=;
	b=pecKZB3plsaHiQhZ7f4Fg/9wVg6dl0UJnlYwZJtQv8fXb0Ec9GbQF+5Wp1DB63jNwF7pq7
	hQDUwwwFyTyBCgluKOutjvK9UGyaREFaVjs9quNyLt/dawnJ0sINVLaeP8+uPoKLGkku+r
	UiLFV1Ql51IEUcc74o04JzQaM1zeAL/TWlmPiIrOAPW/lnuAJ1VTpB1nSGhLYxuFQ3DgtX
	oYXbnh2uN7o4OG3R/bF87CS4K8GdRffnNcYedZMEbXkZGrvugHtS/0hFeTQ1kYHnXhb3Bz
	q1eRTfetCf7fYDbVsRsiCdLfsyYM4zHazISB/l33nL1s8+cPnW5ED0uCvLD9dg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1746700431;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lJXvNCJAyYuawXUWVP5BfFNLWPZ/cC6cuD0bsAGJxLg=;
	b=aCoD7raKovDMGKSbKiU6T2stGqXJ2Jclg7+L3Y43Qh44yCz/qIqflD1EPFBwoVt5+Lx+fs
	ZE5D7A+V80UjLJAA==
From: "tip-bot2 for Sebastian Andrzej Siewior" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: locking/futex] futex: Allow to resize the private local hash
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250416162921.513656-15-bigeasy@linutronix.de>
References: <20250416162921.513656-15-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174670043099.406.5815393087017558806.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the locking/futex branch of tip:

Commit-ID:     bd54df5ea7cadac520e346d5f0fe5d58e635b6ba
Gitweb:        https://git.kernel.org/tip/bd54df5ea7cadac520e346d5f0fe5d58e635b6ba
Author:        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
AuthorDate:    Wed, 16 Apr 2025 18:29:14 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Sat, 03 May 2025 12:02:08 +02:00

futex: Allow to resize the private local hash

The mm_struct::futex_hash_lock guards the futex_hash_bucket assignment/
replacement. The futex_hash_allocate()/ PR_FUTEX_HASH_SET_SLOTS
operation can now be invoked at runtime and resize an already existing
internal private futex_hash_bucket to another size.

The reallocation is based on an idea by Thomas Gleixner: The initial
allocation of struct futex_private_hash sets the reference count
to one. Every user acquires a reference on the local hash before using
it and drops it after it enqueued itself on the hash bucket. There is no
reference held while the task is scheduled out while waiting for the
wake up.
The resize process allocates a new struct futex_private_hash and drops
the initial reference. Synchronized with mm_struct::futex_hash_lock it
is checked if the reference counter for the currently used
mm_struct::futex_phash is marked as DEAD. If so, then all users enqueued
on the current private hash are requeued on the new private hash and the
new private hash is set to mm_struct::futex_phash. Otherwise the newly
allocated private hash is saved as mm_struct::futex_phash_new and the
rehashing and reassigning is delayed to the futex_hash() caller once the
reference counter is marked DEAD.
The replacement is not performed at rcuref_put() time because certain
callers, such as futex_wait_queue(), drop their reference after changing
the task state. This change will be destroyed once the futex_hash_lock
is acquired.

The user can change the number slots with PR_FUTEX_HASH_SET_SLOTS
multiple times. An increase and decrease is allowed and request blocks
until the assignment is done.

The private hash allocated at thread creation is changed from 16 to
  16 <= 4 * number_of_threads <= global_hash_size
where number_of_threads can not exceed the number of online CPUs. Should
the user PR_FUTEX_HASH_SET_SLOTS then the auto scaling is disabled.

[peterz: reorganize the code to avoid state tracking and simplify new
object handling, block the user until changes are in effect, allow
increase and decrease of the hash].

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/r/20250416162921.513656-15-bigeasy@linutronix.de
---
 include/linux/futex.h    |   3 +-
 include/linux/mm_types.h |   4 +-
 kernel/futex/core.c      | 290 +++++++++++++++++++++++++++++++++++---
 kernel/futex/requeue.c   |   5 +-
 4 files changed, 281 insertions(+), 21 deletions(-)

diff --git a/include/linux/futex.h b/include/linux/futex.h
index 1d3f755..40bc778 100644
--- a/include/linux/futex.h
+++ b/include/linux/futex.h
@@ -85,7 +85,8 @@ void futex_hash_free(struct mm_struct *mm);
 
 static inline void futex_mm_init(struct mm_struct *mm)
 {
-	mm->futex_phash =  NULL;
+	rcu_assign_pointer(mm->futex_phash, NULL);
+	mutex_init(&mm->futex_hash_lock);
 }
 
 #else /* !CONFIG_FUTEX_PRIVATE_HASH */
diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index a4b5661..32ba512 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -1033,7 +1033,9 @@ struct mm_struct {
 		seqcount_t mm_lock_seq;
 #endif
 #ifdef CONFIG_FUTEX_PRIVATE_HASH
-		struct futex_private_hash	*futex_phash;
+		struct mutex			futex_hash_lock;
+		struct futex_private_hash	__rcu *futex_phash;
+		struct futex_private_hash	*futex_phash_new;
 #endif
 
 		unsigned long hiwater_rss; /* High-watermark of RSS usage */
diff --git a/kernel/futex/core.c b/kernel/futex/core.c
index 53b3a00..9e7dad5 100644
--- a/kernel/futex/core.c
+++ b/kernel/futex/core.c
@@ -40,6 +40,7 @@
 #include <linux/fault-inject.h>
 #include <linux/slab.h>
 #include <linux/prctl.h>
+#include <linux/rcuref.h>
 
 #include "futex.h"
 #include "../locking/rtmutex_common.h"
@@ -57,7 +58,9 @@ static struct {
 #define futex_hashmask (__futex_data.hashmask)
 
 struct futex_private_hash {
+	rcuref_t	users;
 	unsigned int	hash_mask;
+	struct rcu_head	rcu;
 	void		*mm;
 	bool		custom;
 	struct futex_hash_bucket queues[];
@@ -129,11 +132,14 @@ static inline bool futex_key_is_private(union futex_key *key)
 
 bool futex_private_hash_get(struct futex_private_hash *fph)
 {
-	return false;
+	return rcuref_get(&fph->users);
 }
 
 void futex_private_hash_put(struct futex_private_hash *fph)
 {
+	/* Ignore return value, last put is verified via rcuref_is_dead() */
+	if (rcuref_put(&fph->users))
+		wake_up_var(fph->mm);
 }
 
 /**
@@ -143,8 +149,23 @@ void futex_private_hash_put(struct futex_private_hash *fph)
  * Obtain an additional reference for the already obtained hash bucket. The
  * caller must already own an reference.
  */
-void futex_hash_get(struct futex_hash_bucket *hb) { }
-void futex_hash_put(struct futex_hash_bucket *hb) { }
+void futex_hash_get(struct futex_hash_bucket *hb)
+{
+	struct futex_private_hash *fph = hb->priv;
+
+	if (!fph)
+		return;
+	WARN_ON_ONCE(!futex_private_hash_get(fph));
+}
+
+void futex_hash_put(struct futex_hash_bucket *hb)
+{
+	struct futex_private_hash *fph = hb->priv;
+
+	if (!fph)
+		return;
+	futex_private_hash_put(fph);
+}
 
 static struct futex_hash_bucket *
 __futex_hash_private(union futex_key *key, struct futex_private_hash *fph)
@@ -155,7 +176,7 @@ __futex_hash_private(union futex_key *key, struct futex_private_hash *fph)
 		return NULL;
 
 	if (!fph)
-		fph = key->private.mm->futex_phash;
+		fph = rcu_dereference(key->private.mm->futex_phash);
 	if (!fph || !fph->hash_mask)
 		return NULL;
 
@@ -165,21 +186,119 @@ __futex_hash_private(union futex_key *key, struct futex_private_hash *fph)
 	return &fph->queues[hash & fph->hash_mask];
 }
 
+static void futex_rehash_private(struct futex_private_hash *old,
+				 struct futex_private_hash *new)
+{
+	struct futex_hash_bucket *hb_old, *hb_new;
+	unsigned int slots = old->hash_mask + 1;
+	unsigned int i;
+
+	for (i = 0; i < slots; i++) {
+		struct futex_q *this, *tmp;
+
+		hb_old = &old->queues[i];
+
+		spin_lock(&hb_old->lock);
+		plist_for_each_entry_safe(this, tmp, &hb_old->chain, list) {
+
+			plist_del(&this->list, &hb_old->chain);
+			futex_hb_waiters_dec(hb_old);
+
+			WARN_ON_ONCE(this->lock_ptr != &hb_old->lock);
+
+			hb_new = __futex_hash(&this->key, new);
+			futex_hb_waiters_inc(hb_new);
+			/*
+			 * The new pointer isn't published yet but an already
+			 * moved user can be unqueued due to timeout or signal.
+			 */
+			spin_lock_nested(&hb_new->lock, SINGLE_DEPTH_NESTING);
+			plist_add(&this->list, &hb_new->chain);
+			this->lock_ptr = &hb_new->lock;
+			spin_unlock(&hb_new->lock);
+		}
+		spin_unlock(&hb_old->lock);
+	}
+}
+
+static bool __futex_pivot_hash(struct mm_struct *mm,
+			       struct futex_private_hash *new)
+{
+	struct futex_private_hash *fph;
+
+	WARN_ON_ONCE(mm->futex_phash_new);
+
+	fph = rcu_dereference_protected(mm->futex_phash,
+					lockdep_is_held(&mm->futex_hash_lock));
+	if (fph) {
+		if (!rcuref_is_dead(&fph->users)) {
+			mm->futex_phash_new = new;
+			return false;
+		}
+
+		futex_rehash_private(fph, new);
+	}
+	rcu_assign_pointer(mm->futex_phash, new);
+	kvfree_rcu(fph, rcu);
+	return true;
+}
+
+static void futex_pivot_hash(struct mm_struct *mm)
+{
+	scoped_guard(mutex, &mm->futex_hash_lock) {
+		struct futex_private_hash *fph;
+
+		fph = mm->futex_phash_new;
+		if (fph) {
+			mm->futex_phash_new = NULL;
+			__futex_pivot_hash(mm, fph);
+		}
+	}
+}
+
 struct futex_private_hash *futex_private_hash(void)
 {
 	struct mm_struct *mm = current->mm;
-	struct futex_private_hash *fph;
+	/*
+	 * Ideally we don't loop. If there is a replacement in progress
+	 * then a new private hash is already prepared and a reference can't be
+	 * obtained once the last user dropped it's.
+	 * In that case we block on mm_struct::futex_hash_lock and either have
+	 * to perform the replacement or wait while someone else is doing the
+	 * job. Eitherway, on the second iteration we acquire a reference on the
+	 * new private hash or loop again because a new replacement has been
+	 * requested.
+	 */
+again:
+	scoped_guard(rcu) {
+		struct futex_private_hash *fph;
 
-	fph = mm->futex_phash;
-	return fph;
+		fph = rcu_dereference(mm->futex_phash);
+		if (!fph)
+			return NULL;
+
+		if (rcuref_get(&fph->users))
+			return fph;
+	}
+	futex_pivot_hash(mm);
+	goto again;
 }
 
 struct futex_hash_bucket *futex_hash(union futex_key *key)
 {
+	struct futex_private_hash *fph;
 	struct futex_hash_bucket *hb;
 
-	hb = __futex_hash(key, NULL);
-	return hb;
+again:
+	scoped_guard(rcu) {
+		hb = __futex_hash(key, NULL);
+		fph = hb->priv;
+
+		if (!fph || futex_private_hash_get(fph))
+			return hb;
+	}
+	futex_pivot_hash(key->private.mm);
+	goto again;
 }
 
 #else /* !CONFIG_FUTEX_PRIVATE_HASH */
@@ -664,6 +783,8 @@ int futex_unqueue(struct futex_q *q)
 	spinlock_t *lock_ptr;
 	int ret = 0;
 
+	/* RCU so lock_ptr is not going away during locking. */
+	guard(rcu)();
 	/* In the common case we don't take the spinlock, which is nice. */
 retry:
 	/*
@@ -1066,6 +1187,10 @@ static void exit_pi_state_list(struct task_struct *curr)
 	union futex_key key = FUTEX_KEY_INIT;
 
 	/*
+	 * The mutex mm_struct::futex_hash_lock might be acquired.
+	 */
+	might_sleep();
+	/*
 	 * Ensure the hash remains stable (no resize) during the while loop
 	 * below. The hb pointer is acquired under the pi_lock so we can't block
 	 * on the mutex.
@@ -1261,7 +1386,51 @@ static void futex_hash_bucket_init(struct futex_hash_bucket *fhb,
 #ifdef CONFIG_FUTEX_PRIVATE_HASH
 void futex_hash_free(struct mm_struct *mm)
 {
-	kvfree(mm->futex_phash);
+	struct futex_private_hash *fph;
+
+	kvfree(mm->futex_phash_new);
+	fph = rcu_dereference_raw(mm->futex_phash);
+	if (fph) {
+		WARN_ON_ONCE(rcuref_read(&fph->users) > 1);
+		kvfree(fph);
+	}
+}
+
+static bool futex_pivot_pending(struct mm_struct *mm)
+{
+	struct futex_private_hash *fph;
+
+	guard(rcu)();
+
+	if (!mm->futex_phash_new)
+		return true;
+
+	fph = rcu_dereference(mm->futex_phash);
+	return rcuref_is_dead(&fph->users);
+}
+
+static bool futex_hash_less(struct futex_private_hash *a,
+			    struct futex_private_hash *b)
+{
+	/* user provided always wins */
+	if (!a->custom && b->custom)
+		return true;
+	if (a->custom && !b->custom)
+		return false;
+
+	/* zero-sized hash wins */
+	if (!b->hash_mask)
+		return true;
+	if (!a->hash_mask)
+		return false;
+
+	/* keep the biggest */
+	if (a->hash_mask < b->hash_mask)
+		return true;
+	if (a->hash_mask > b->hash_mask)
+		return false;
+
+	return false; /* equal */
 }
 
 static int futex_hash_allocate(unsigned int hash_slots, bool custom)
@@ -1273,16 +1442,23 @@ static int futex_hash_allocate(unsigned int hash_slots, bool custom)
 	if (hash_slots && (hash_slots == 1 || !is_power_of_2(hash_slots)))
 		return -EINVAL;
 
-	if (mm->futex_phash)
-		return -EALREADY;
-
-	if (!thread_group_empty(current))
-		return -EINVAL;
+	/*
+	 * Once we've disabled the global hash there is no way back.
+	 */
+	scoped_guard(rcu) {
+		fph = rcu_dereference(mm->futex_phash);
+		if (fph && !fph->hash_mask) {
+			if (custom)
+				return -EBUSY;
+			return 0;
+		}
+	}
 
 	fph = kvzalloc(struct_size(fph, queues, hash_slots), GFP_KERNEL_ACCOUNT | __GFP_NOWARN);
 	if (!fph)
 		return -ENOMEM;
 
+	rcuref_init(&fph->users, 1);
 	fph->hash_mask = hash_slots ? hash_slots - 1 : 0;
 	fph->custom = custom;
 	fph->mm = mm;
@@ -1290,26 +1466,102 @@ static int futex_hash_allocate(unsigned int hash_slots, bool custom)
 	for (i = 0; i < hash_slots; i++)
 		futex_hash_bucket_init(&fph->queues[i], fph);
 
-	mm->futex_phash = fph;
+	if (custom) {
+		/*
+		 * Only let prctl() wait / retry; don't unduly delay clone().
+		 */
+again:
+		wait_var_event(mm, futex_pivot_pending(mm));
+	}
+
+	scoped_guard(mutex, &mm->futex_hash_lock) {
+		struct futex_private_hash *free __free(kvfree) = NULL;
+		struct futex_private_hash *cur, *new;
+
+		cur = rcu_dereference_protected(mm->futex_phash,
+						lockdep_is_held(&mm->futex_hash_lock));
+		new = mm->futex_phash_new;
+		mm->futex_phash_new = NULL;
+
+		if (fph) {
+			if (cur && !new) {
+				/*
+				 * If we have an existing hash, but do not yet have
+				 * allocated a replacement hash, drop the initial
+				 * reference on the existing hash.
+				 */
+				futex_private_hash_put(cur);
+			}
+
+			if (new) {
+				/*
+				 * Two updates raced; throw out the lesser one.
+				 */
+				if (futex_hash_less(new, fph)) {
+					free = new;
+					new = fph;
+				} else {
+					free = fph;
+				}
+			} else {
+				new = fph;
+			}
+			fph = NULL;
+		}
+
+		if (new) {
+			/*
+			 * Will set mm->futex_phash_new on failure;
+			 * futex_private_hash_get() will try again.
+			 */
+			if (!__futex_pivot_hash(mm, new) && custom)
+				goto again;
+		}
+	}
 	return 0;
 }
 
 int futex_hash_allocate_default(void)
 {
+	unsigned int threads, buckets, current_buckets = 0;
+	struct futex_private_hash *fph;
+
 	if (!current->mm)
 		return 0;
 
-	if (current->mm->futex_phash)
+	scoped_guard(rcu) {
+		threads = min_t(unsigned int,
+				get_nr_threads(current),
+				num_online_cpus());
+
+		fph = rcu_dereference(current->mm->futex_phash);
+		if (fph) {
+			if (fph->custom)
+				return 0;
+
+			current_buckets = fph->hash_mask + 1;
+		}
+	}
+
+	/*
+	 * The default allocation will remain within
+	 *   16 <= threads * 4 <= global hash size
+	 */
+	buckets = roundup_pow_of_two(4 * threads);
+	buckets = clamp(buckets, 16, futex_hashmask + 1);
+
+	if (current_buckets >= buckets)
 		return 0;
 
-	return futex_hash_allocate(16, false);
+	return futex_hash_allocate(buckets, false);
 }
 
 static int futex_hash_get_slots(void)
 {
 	struct futex_private_hash *fph;
 
-	fph = current->mm->futex_phash;
+	guard(rcu)();
+	fph = rcu_dereference(current->mm->futex_phash);
 	if (fph && fph->hash_mask)
 		return fph->hash_mask + 1;
 	return 0;
diff --git a/kernel/futex/requeue.c b/kernel/futex/requeue.c
index b0e64fd..c716a66 100644
--- a/kernel/futex/requeue.c
+++ b/kernel/futex/requeue.c
@@ -87,6 +87,11 @@ void requeue_futex(struct futex_q *q, struct futex_hash_bucket *hb1,
 		futex_hb_waiters_inc(hb2);
 		plist_add(&q->list, &hb2->chain);
 		q->lock_ptr = &hb2->lock;
+		/*
+		 * hb1 and hb2 belong to the same futex_hash_bucket_private
+		 * because if we managed get a reference on hb1 then it can't be
+		 * replaced. Therefore we avoid put(hb1)+get(hb2) here.
+		 */
 	}
 	q->key = *key2;
 }

