Return-Path: <linux-tip-commits+bounces-6100-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 073ACB023C4
	for <lists+linux-tip-commits@lfdr.de>; Fri, 11 Jul 2025 20:35:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B7C5A5C56EC
	for <lists+linux-tip-commits@lfdr.de>; Fri, 11 Jul 2025 18:34:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B5382F4A04;
	Fri, 11 Jul 2025 18:33:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="s/IYUgoj";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="SmTYA/fn"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B7B72F4324;
	Fri, 11 Jul 2025 18:33:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752258821; cv=none; b=EsgqZE4CobWjdad3PaFbAmEhwUJrrVm5srNP+l87Lke472WlgS2dgXxKh9MpG9ljsF+8E5Di5SWunXdncu+q9b1zC7t5uO+kj3PC4mpiUbjCieFob7jjgcjofZfCtcqAdIEeVaED1LJld/hFy60S0YwZCBFF2mPtsTycS7pbZ4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752258821; c=relaxed/simple;
	bh=Cu2I33Mx5hF51n+LznL4Tqi7itI4GCZNv1Uy4ZRVhRc=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=r1vYAYj51dJZISMTgMJt7Cpc03mezkxkibFsISs0iIjePx9/B8jPfW5RB/67rubDY+DXJAfKZE6/OAkHDD5fDJsdvL6xhj5u+IpQAeGKUfVSxLQ1HTSNrxEaK48xMnfJBbUt99EOVqae7Dw8zkdta1KpP7bvFyDdNFZgBO00usE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=s/IYUgoj; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=SmTYA/fn; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 11 Jul 2025 18:33:36 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1752258817;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iYIaL/MlSN/qAPfsshCtI7erDtrDtsREDs7BoT67mGE=;
	b=s/IYUgojOaXLePVLJg9abDyqUxsSuMwISIf8TFdg7MKX2xVe4DI1xNStGZ9NEHV2qFl2V0
	VqTT3LnK+GJO/2jxCAI1yRqiSceYfJ1pdauWId+d9uyLwvjmzYlgLjTraJwucypBqh+knX
	K9dSPMZ4Pbx3lXVo9VxMFl0P/bKtJvAbV2GDtxHPtyFb16K+ZhV4vbiJImxC1iT6fcjXOo
	W/RSUcHueXt/24mJciOBMg7FFR71kdBwNLJmaQJYXIyW17i5ofZDXD/yru6lHz+8ekJmOB
	/vqFC0GAi6H7ABJ/7yKdIbeORFgpQvgq8iCMUUPFDepTBlYfJiGZ3ZxdkWEIWw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1752258817;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iYIaL/MlSN/qAPfsshCtI7erDtrDtsREDs7BoT67mGE=;
	b=SmTYA/fn4SPCJ655yeOopQ2Ijly7kIko+yZuW8FT/C8TFoUiNyNZPU9YZjMkzDW+rUR4uG
	m/vl1iP496DGgBCA==
From: "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: locking/futex] futex: Use RCU-based per-CPU reference counting
 instead of rcuref_t
Cc: "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250710110011.384614-3-bigeasy@linutronix.de>
References: <20250710110011.384614-3-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175225881640.406.2875698205071601878.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the locking/futex branch of tip:

Commit-ID:     56180dd20c19e5b0fa34822997a9ac66b517e7b3
Gitweb:        https://git.kernel.org/tip/56180dd20c19e5b0fa34822997a9ac66b517e7b3
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Thu, 10 Jul 2025 13:00:07 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 11 Jul 2025 16:02:00 +02:00

futex: Use RCU-based per-CPU reference counting instead of rcuref_t

The use of rcuref_t for reference counting introduces a performance bottleneck
when accessed concurrently by multiple threads during futex operations.

Replace rcuref_t with special crafted per-CPU reference counters. The
lifetime logic remains the same.

The newly allocate private hash starts in FR_PERCPU state. In this state, each
futex operation that requires the private hash uses a per-CPU counter (an
unsigned int) for incrementing or decrementing the reference count.

When the private hash is about to be replaced, the per-CPU counters are
migrated to a atomic_t counter mm_struct::futex_atomic.
The migration process:
- Waiting for one RCU grace period to ensure all users observe the
  current private hash. This can be skipped if a grace period elapsed
  since the private hash was assigned.

- futex_private_hash::state is set to FR_ATOMIC, forcing all users to
  use mm_struct::futex_atomic for reference counting.

- After a RCU grace period, all users are guaranteed to be using the
  atomic counter. The per-CPU counters can now be summed up and added to
  the atomic_t counter. If the resulting count is zero, the hash can be
  safely replaced. Otherwise, active users still hold a valid reference.

- Once the atomic reference count drops to zero, the next futex
  operation will switch to the new private hash.

call_rcu_hurry() is used to speed up transition which otherwise might be
delay with RCU_LAZY. There is nothing wrong with using call_rcu(). The
side effects would be that on auto scaling the new hash is used later
and the SET_SLOTS prctl() will block longer.

[bigeasy: commit description + mm get/ put_async]

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/r/20250710110011.384614-3-bigeasy@linutronix.de
---
 include/linux/futex.h    |  16 +---
 include/linux/mm_types.h |   5 +-
 include/linux/sched/mm.h |   2 +-
 init/Kconfig             |   4 +-
 kernel/fork.c            |   8 +-
 kernel/futex/core.c      | 243 +++++++++++++++++++++++++++++++++++---
 6 files changed, 243 insertions(+), 35 deletions(-)

diff --git a/include/linux/futex.h b/include/linux/futex.h
index b371936..9e9750f 100644
--- a/include/linux/futex.h
+++ b/include/linux/futex.h
@@ -85,18 +85,12 @@ int futex_hash_prctl(unsigned long arg2, unsigned long arg3, unsigned long arg4)
 #ifdef CONFIG_FUTEX_PRIVATE_HASH
 int futex_hash_allocate_default(void);
 void futex_hash_free(struct mm_struct *mm);
-
-static inline void futex_mm_init(struct mm_struct *mm)
-{
-	RCU_INIT_POINTER(mm->futex_phash, NULL);
-	mm->futex_phash_new = NULL;
-	mutex_init(&mm->futex_hash_lock);
-}
+int futex_mm_init(struct mm_struct *mm);
 
 #else /* !CONFIG_FUTEX_PRIVATE_HASH */
 static inline int futex_hash_allocate_default(void) { return 0; }
-static inline void futex_hash_free(struct mm_struct *mm) { }
-static inline void futex_mm_init(struct mm_struct *mm) { }
+static inline int futex_hash_free(struct mm_struct *mm) { return 0; }
+static inline int futex_mm_init(struct mm_struct *mm) { return 0; }
 #endif /* CONFIG_FUTEX_PRIVATE_HASH */
 
 #else /* !CONFIG_FUTEX */
@@ -118,8 +112,8 @@ static inline int futex_hash_allocate_default(void)
 {
 	return 0;
 }
-static inline void futex_hash_free(struct mm_struct *mm) { }
-static inline void futex_mm_init(struct mm_struct *mm) { }
+static inline int futex_hash_free(struct mm_struct *mm) { return 0; }
+static inline int futex_mm_init(struct mm_struct *mm) { return 0; }
 
 #endif
 
diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index d6b91e8..0f06621 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -1070,6 +1070,11 @@ struct mm_struct {
 		struct mutex			futex_hash_lock;
 		struct futex_private_hash	__rcu *futex_phash;
 		struct futex_private_hash	*futex_phash_new;
+		/* futex-ref */
+		unsigned long			futex_batches;
+		struct rcu_head			futex_rcu;
+		atomic_long_t			futex_atomic;
+		unsigned int			__percpu *futex_ref;
 #endif
 
 		unsigned long hiwater_rss; /* High-watermark of RSS usage */
diff --git a/include/linux/sched/mm.h b/include/linux/sched/mm.h
index b134748..2201da0 100644
--- a/include/linux/sched/mm.h
+++ b/include/linux/sched/mm.h
@@ -140,7 +140,7 @@ static inline bool mmget_not_zero(struct mm_struct *mm)
 
 /* mmput gets rid of the mappings and all user-space */
 extern void mmput(struct mm_struct *);
-#ifdef CONFIG_MMU
+#if defined(CONFIG_MMU) || defined(CONFIG_FUTEX_PRIVATE_HASH)
 /* same as above but performs the slow path from the async context. Can
  * be called from the atomic context as well
  */
diff --git a/init/Kconfig b/init/Kconfig
index 666783e..af4c2f0 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -1716,13 +1716,9 @@ config FUTEX_PI
 	depends on FUTEX && RT_MUTEXES
 	default y
 
-#
-# marked broken for performance reasons; gives us one more cycle to sort things out.
-#
 config FUTEX_PRIVATE_HASH
 	bool
 	depends on FUTEX && !BASE_SMALL && MMU
-	depends on BROKEN
 	default y
 
 config FUTEX_MPOL
diff --git a/kernel/fork.c b/kernel/fork.c
index 1ee8eb1..0b885dc 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -1046,7 +1046,6 @@ static struct mm_struct *mm_init(struct mm_struct *mm, struct task_struct *p,
 	RCU_INIT_POINTER(mm->exe_file, NULL);
 	mmu_notifier_subscriptions_init(mm);
 	init_tlb_flush_pending(mm);
-	futex_mm_init(mm);
 #if defined(CONFIG_TRANSPARENT_HUGEPAGE) && !defined(CONFIG_SPLIT_PMD_PTLOCKS)
 	mm->pmd_huge_pte = NULL;
 #endif
@@ -1061,6 +1060,9 @@ static struct mm_struct *mm_init(struct mm_struct *mm, struct task_struct *p,
 		mm->def_flags = 0;
 	}
 
+	if (futex_mm_init(mm))
+		goto fail_mm_init;
+
 	if (mm_alloc_pgd(mm))
 		goto fail_nopgd;
 
@@ -1090,6 +1092,8 @@ fail_nocontext:
 fail_noid:
 	mm_free_pgd(mm);
 fail_nopgd:
+	futex_hash_free(mm);
+fail_mm_init:
 	free_mm(mm);
 	return NULL;
 }
@@ -1145,7 +1149,7 @@ void mmput(struct mm_struct *mm)
 }
 EXPORT_SYMBOL_GPL(mmput);
 
-#ifdef CONFIG_MMU
+#if defined(CONFIG_MMU) || defined(CONFIG_FUTEX_PRIVATE_HASH)
 static void mmput_async_fn(struct work_struct *work)
 {
 	struct mm_struct *mm = container_of(work, struct mm_struct,
diff --git a/kernel/futex/core.c b/kernel/futex/core.c
index 90d53fb..1dcb4c8 100644
--- a/kernel/futex/core.c
+++ b/kernel/futex/core.c
@@ -42,7 +42,6 @@
 #include <linux/fault-inject.h>
 #include <linux/slab.h>
 #include <linux/prctl.h>
-#include <linux/rcuref.h>
 #include <linux/mempolicy.h>
 #include <linux/mmap_lock.h>
 
@@ -65,7 +64,7 @@ static struct {
 #define futex_queues	(__futex_data.queues)
 
 struct futex_private_hash {
-	rcuref_t	users;
+	int		state;
 	unsigned int	hash_mask;
 	struct rcu_head	rcu;
 	void		*mm;
@@ -129,6 +128,12 @@ static struct futex_hash_bucket *
 __futex_hash(union futex_key *key, struct futex_private_hash *fph);
 
 #ifdef CONFIG_FUTEX_PRIVATE_HASH
+static bool futex_ref_get(struct futex_private_hash *fph);
+static bool futex_ref_put(struct futex_private_hash *fph);
+static bool futex_ref_is_dead(struct futex_private_hash *fph);
+
+enum { FR_PERCPU = 0, FR_ATOMIC };
+
 static inline bool futex_key_is_private(union futex_key *key)
 {
 	/*
@@ -142,15 +147,14 @@ bool futex_private_hash_get(struct futex_private_hash *fph)
 {
 	if (fph->immutable)
 		return true;
-	return rcuref_get(&fph->users);
+	return futex_ref_get(fph);
 }
 
 void futex_private_hash_put(struct futex_private_hash *fph)
 {
-	/* Ignore return value, last put is verified via rcuref_is_dead() */
 	if (fph->immutable)
 		return;
-	if (rcuref_put(&fph->users))
+	if (futex_ref_put(fph))
 		wake_up_var(fph->mm);
 }
 
@@ -243,14 +247,18 @@ static bool __futex_pivot_hash(struct mm_struct *mm,
 	fph = rcu_dereference_protected(mm->futex_phash,
 					lockdep_is_held(&mm->futex_hash_lock));
 	if (fph) {
-		if (!rcuref_is_dead(&fph->users)) {
+		if (!futex_ref_is_dead(fph)) {
 			mm->futex_phash_new = new;
 			return false;
 		}
 
 		futex_rehash_private(fph, new);
 	}
-	rcu_assign_pointer(mm->futex_phash, new);
+	new->state = FR_PERCPU;
+	scoped_guard(rcu) {
+		mm->futex_batches = get_state_synchronize_rcu();
+		rcu_assign_pointer(mm->futex_phash, new);
+	}
 	kvfree_rcu(fph, rcu);
 	return true;
 }
@@ -289,9 +297,7 @@ again:
 		if (!fph)
 			return NULL;
 
-		if (fph->immutable)
-			return fph;
-		if (rcuref_get(&fph->users))
+		if (futex_private_hash_get(fph))
 			return fph;
 	}
 	futex_pivot_hash(mm);
@@ -1527,16 +1533,219 @@ static void futex_hash_bucket_init(struct futex_hash_bucket *fhb,
 #define FH_IMMUTABLE	0x02
 
 #ifdef CONFIG_FUTEX_PRIVATE_HASH
+
+/*
+ * futex-ref
+ *
+ * Heavily inspired by percpu-rwsem/percpu-refcount; not reusing any of that
+ * code because it just doesn't fit right.
+ *
+ * Dual counter, per-cpu / atomic approach like percpu-refcount, except it
+ * re-initializes the state automatically, such that the fph swizzle is also a
+ * transition back to per-cpu.
+ */
+
+static void futex_ref_rcu(struct rcu_head *head);
+
+static void __futex_ref_atomic_begin(struct futex_private_hash *fph)
+{
+	struct mm_struct *mm = fph->mm;
+
+	/*
+	 * The counter we're about to switch to must have fully switched;
+	 * otherwise it would be impossible for it to have reported success
+	 * from futex_ref_is_dead().
+	 */
+	WARN_ON_ONCE(atomic_long_read(&mm->futex_atomic) != 0);
+
+	/*
+	 * Set the atomic to the bias value such that futex_ref_{get,put}()
+	 * will never observe 0. Will be fixed up in __futex_ref_atomic_end()
+	 * when folding in the percpu count.
+	 */
+	atomic_long_set(&mm->futex_atomic, LONG_MAX);
+	smp_store_release(&fph->state, FR_ATOMIC);
+
+	call_rcu_hurry(&mm->futex_rcu, futex_ref_rcu);
+}
+
+static void __futex_ref_atomic_end(struct futex_private_hash *fph)
+{
+	struct mm_struct *mm = fph->mm;
+	unsigned int count = 0;
+	long ret;
+	int cpu;
+
+	/*
+	 * Per __futex_ref_atomic_begin() the state of the fph must be ATOMIC
+	 * and per this RCU callback, everybody must now observe this state and
+	 * use the atomic variable.
+	 */
+	WARN_ON_ONCE(fph->state != FR_ATOMIC);
+
+	/*
+	 * Therefore the per-cpu counter is now stable, sum and reset.
+	 */
+	for_each_possible_cpu(cpu) {
+		unsigned int *ptr = per_cpu_ptr(mm->futex_ref, cpu);
+		count += *ptr;
+		*ptr = 0;
+	}
+
+	/*
+	 * Re-init for the next cycle.
+	 */
+	this_cpu_inc(*mm->futex_ref); /* 0 -> 1 */
+
+	/*
+	 * Add actual count, subtract bias and initial refcount.
+	 *
+	 * The moment this atomic operation happens, futex_ref_is_dead() can
+	 * become true.
+	 */
+	ret = atomic_long_add_return(count - LONG_MAX - 1, &mm->futex_atomic);
+	if (!ret)
+		wake_up_var(mm);
+
+	WARN_ON_ONCE(ret < 0);
+	mmput_async(mm);
+}
+
+static void futex_ref_rcu(struct rcu_head *head)
+{
+	struct mm_struct *mm = container_of(head, struct mm_struct, futex_rcu);
+	struct futex_private_hash *fph = rcu_dereference_raw(mm->futex_phash);
+
+	if (fph->state == FR_PERCPU) {
+		/*
+		 * Per this extra grace-period, everybody must now observe
+		 * fph as the current fph and no previously observed fph's
+		 * are in-flight.
+		 *
+		 * Notably, nobody will now rely on the atomic
+		 * futex_ref_is_dead() state anymore so we can begin the
+		 * migration of the per-cpu counter into the atomic.
+		 */
+		__futex_ref_atomic_begin(fph);
+		return;
+	}
+
+	__futex_ref_atomic_end(fph);
+}
+
+/*
+ * Drop the initial refcount and transition to atomics.
+ */
+static void futex_ref_drop(struct futex_private_hash *fph)
+{
+	struct mm_struct *mm = fph->mm;
+
+	/*
+	 * Can only transition the current fph;
+	 */
+	WARN_ON_ONCE(rcu_dereference_raw(mm->futex_phash) != fph);
+	/*
+	 * We enqueue at least one RCU callback. Ensure mm stays if the task
+	 * exits before the transition is completed.
+	 */
+	mmget(mm);
+
+	/*
+	 * In order to avoid the following scenario:
+	 *
+	 * futex_hash()			__futex_pivot_hash()
+	 *   guard(rcu);		  guard(mm->futex_hash_lock);
+	 *   fph = mm->futex_phash;
+	 *				  rcu_assign_pointer(&mm->futex_phash, new);
+	 *				futex_hash_allocate()
+	 *				  futex_ref_drop()
+	 *				    fph->state = FR_ATOMIC;
+	 *				    atomic_set(, BIAS);
+	 *
+	 *   futex_private_hash_get(fph); // OOPS
+	 *
+	 * Where an old fph (which is FR_ATOMIC) and should fail on
+	 * inc_not_zero, will succeed because a new transition is started and
+	 * the atomic is bias'ed away from 0.
+	 *
+	 * There must be at least one full grace-period between publishing a
+	 * new fph and trying to replace it.
+	 */
+	if (poll_state_synchronize_rcu(mm->futex_batches)) {
+		/*
+		 * There was a grace-period, we can begin now.
+		 */
+		__futex_ref_atomic_begin(fph);
+		return;
+	}
+
+	call_rcu_hurry(&mm->futex_rcu, futex_ref_rcu);
+}
+
+static bool futex_ref_get(struct futex_private_hash *fph)
+{
+	struct mm_struct *mm = fph->mm;
+
+	guard(rcu)();
+
+	if (smp_load_acquire(&fph->state) == FR_PERCPU) {
+		this_cpu_inc(*mm->futex_ref);
+		return true;
+	}
+
+	return atomic_long_inc_not_zero(&mm->futex_atomic);
+}
+
+static bool futex_ref_put(struct futex_private_hash *fph)
+{
+	struct mm_struct *mm = fph->mm;
+
+	guard(rcu)();
+
+	if (smp_load_acquire(&fph->state) == FR_PERCPU) {
+		this_cpu_dec(*mm->futex_ref);
+		return false;
+	}
+
+	return atomic_long_dec_and_test(&mm->futex_atomic);
+}
+
+static bool futex_ref_is_dead(struct futex_private_hash *fph)
+{
+	struct mm_struct *mm = fph->mm;
+
+	guard(rcu)();
+
+	if (smp_load_acquire(&fph->state) == FR_PERCPU)
+		return false;
+
+	return atomic_long_read(&mm->futex_atomic) == 0;
+}
+
+int futex_mm_init(struct mm_struct *mm)
+{
+	mutex_init(&mm->futex_hash_lock);
+	RCU_INIT_POINTER(mm->futex_phash, NULL);
+	mm->futex_phash_new = NULL;
+	/* futex-ref */
+	atomic_long_set(&mm->futex_atomic, 0);
+	mm->futex_batches = get_state_synchronize_rcu();
+	mm->futex_ref = alloc_percpu(unsigned int);
+	if (!mm->futex_ref)
+		return -ENOMEM;
+	this_cpu_inc(*mm->futex_ref); /* 0 -> 1 */
+	return 0;
+}
+
 void futex_hash_free(struct mm_struct *mm)
 {
 	struct futex_private_hash *fph;
 
+	free_percpu(mm->futex_ref);
 	kvfree(mm->futex_phash_new);
 	fph = rcu_dereference_raw(mm->futex_phash);
-	if (fph) {
-		WARN_ON_ONCE(rcuref_read(&fph->users) > 1);
+	if (fph)
 		kvfree(fph);
-	}
 }
 
 static bool futex_pivot_pending(struct mm_struct *mm)
@@ -1549,7 +1758,7 @@ static bool futex_pivot_pending(struct mm_struct *mm)
 		return true;
 
 	fph = rcu_dereference(mm->futex_phash);
-	return rcuref_is_dead(&fph->users);
+	return futex_ref_is_dead(fph);
 }
 
 static bool futex_hash_less(struct futex_private_hash *a,
@@ -1598,11 +1807,11 @@ static int futex_hash_allocate(unsigned int hash_slots, unsigned int flags)
 		}
 	}
 
-	fph = kvzalloc(struct_size(fph, queues, hash_slots), GFP_KERNEL_ACCOUNT | __GFP_NOWARN);
+	fph = kvzalloc(struct_size(fph, queues, hash_slots),
+		       GFP_KERNEL_ACCOUNT | __GFP_NOWARN);
 	if (!fph)
 		return -ENOMEM;
 
-	rcuref_init(&fph->users, 1);
 	fph->hash_mask = hash_slots ? hash_slots - 1 : 0;
 	fph->custom = custom;
 	fph->immutable = !!(flags & FH_IMMUTABLE);
@@ -1645,7 +1854,7 @@ again:
 				 * allocated a replacement hash, drop the initial
 				 * reference on the existing hash.
 				 */
-				futex_private_hash_put(cur);
+				futex_ref_drop(cur);
 			}
 
 			if (new) {

