Return-Path: <linux-tip-commits+bounces-5475-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C5D21AAF7FE
	for <lists+linux-tip-commits@lfdr.de>; Thu,  8 May 2025 12:36:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0B60C16F23A
	for <lists+linux-tip-commits@lfdr.de>; Thu,  8 May 2025 10:36:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4D97229B16;
	Thu,  8 May 2025 10:33:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="XQNVRSoP";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="bTGQdtH6"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2349222425B;
	Thu,  8 May 2025 10:33:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746700437; cv=none; b=WcRvk9MwdXlmWBVGK1uaxVPR9rjChejNpLSLHZk4y8k7Qmyocqloksjlv1coJT9U8gSa628Xk75U35Er+1aCBrUGz/cjQRvE06KXoAp3LbsuIMgm26P6lByd/7Tvm8HWT5M2Q31OPxBrC5z+8Z/fad1o+sfDnq6zUu3fGXH4ito=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746700437; c=relaxed/simple;
	bh=H1zMkNsUY+YlV7bTy7bpAVmjuG9/gfCds3CXGtX2jIo=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=UeQFySVJZYr5GCGdQNnKqp+hMxx6N9l6VDpO+TRPJnwMHO8wRAMODm+WDycQkQE1YtKRVGhHWHtXef60NygrzydPV3ePKfsGw9ezXGHm2Mf1ICB/oPr+CHC6UR7nixOuAT+TptE6TMc7NrsIPJF6jlRumtvC4ydAwSCy4SaqvuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=XQNVRSoP; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=bTGQdtH6; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 08 May 2025 10:33:52 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1746700433;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hleLRliYb8O4HSrCpWe4IuccsqHPje/mtHOWfuV2Ias=;
	b=XQNVRSoPp3/hrcTxwUzRqWc2RRvn0+eV4g5F09dJYlVh/lGi7DwaM02keqyrhD8WbUBCgL
	hEs/naYBnkUrI0/IcOcN/+Lmym7Y9ARJmrxnYKFGnqYdC3FUvV12kvCF8J9zOu/bvuQqr/
	NvdQWWUfDtYIHEY8fSlfnqOrJkCr7LxGz8QBka7HU2Eh/yz7w8CJmDOIauJzsxEHMv+AOE
	EHrKHjLJJWrWFRd2f8ZHqFmlwGL6gYl0Rf3IBETf76H+2Rg6KCf2dwXA3IKXoAcbDmFpBx
	2AS2RZLPSxgBT6U11a/Y6qbD1Ari0bavoQMG02m5IXtnc1DJjHp2i8KI/OIbKw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1746700433;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hleLRliYb8O4HSrCpWe4IuccsqHPje/mtHOWfuV2Ias=;
	b=bTGQdtH6CYtpkW2mX2SErN5oSDSF2UnZGt5RMqclJhCKuXG+Iyxs9PXCwv/I1q2YQnhOXC
	/7VQ/7UZdk6G98BA==
From: "tip-bot2 for Sebastian Andrzej Siewior" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: locking/futex] futex: Add basic infrastructure for local task
 local hash
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250416162921.513656-13-bigeasy@linutronix.de>
References: <20250416162921.513656-13-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174670043246.406.3639325236322831990.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the locking/futex branch of tip:

Commit-ID:     80367ad01d93ac781b0e1df246edaf006928002f
Gitweb:        https://git.kernel.org/tip/80367ad01d93ac781b0e1df246edaf006928002f
Author:        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
AuthorDate:    Wed, 16 Apr 2025 18:29:12 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Sat, 03 May 2025 12:02:07 +02:00

futex: Add basic infrastructure for local task local hash

The futex hash is system wide and shared by all tasks. Each slot
is hashed based on futex address and the VMA of the thread. Due to
randomized VMAs (and memory allocations) the same logical lock (pointer)
can end up in a different hash bucket on each invocation of the
application. This in turn means that different applications may share a
hash bucket on the first invocation but not on the second and it is not
always clear which applications will be involved. This can result in
high latency's to acquire the futex_hash_bucket::lock especially if the
lock owner is limited to a CPU and can not be effectively PI boosted.

Introduce basic infrastructure for process local hash which is shared by
all threads of process. This hash will only be used for a
PROCESS_PRIVATE FUTEX operation.

The hashmap can be allocated via:

        prctl(PR_FUTEX_HASH, PR_FUTEX_HASH_SET_SLOTS, num);

A `num' of 0 means that the global hash is used instead of a private
hash.
Other values for `num' specify the number of slots for the hash and the
number must be power of two, starting with two.
The prctl() returns zero on success. This function can only be used
before a thread is created.

The current status for the private hash can be queried via:

        num = prctl(PR_FUTEX_HASH, PR_FUTEX_HASH_GET_SLOTS);

which return the current number of slots. The value 0 means that the
global hash is used. Values greater than 0 indicate the number of slots
that are used. A negative number indicates an error.

For optimisation, for the private hash jhash2() uses only two arguments
the address and the offset. This omits the VMA which is always the same.

[peterz: Use 0 for global hash. A bit shuffling and renaming. ]

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/r/20250416162921.513656-13-bigeasy@linutronix.de
---
 include/linux/futex.h      |  26 ++++-
 include/linux/mm_types.h   |   5 +-
 include/uapi/linux/prctl.h |   5 +-
 init/Kconfig               |   5 +-
 kernel/fork.c              |   2 +-
 kernel/futex/core.c        | 208 ++++++++++++++++++++++++++++++++----
 kernel/futex/futex.h       |  10 ++-
 kernel/sys.c               |   4 +-
 8 files changed, 244 insertions(+), 21 deletions(-)

diff --git a/include/linux/futex.h b/include/linux/futex.h
index b70df27..8f1be08 100644
--- a/include/linux/futex.h
+++ b/include/linux/futex.h
@@ -4,11 +4,11 @@
 
 #include <linux/sched.h>
 #include <linux/ktime.h>
+#include <linux/mm_types.h>
 
 #include <uapi/linux/futex.h>
 
 struct inode;
-struct mm_struct;
 struct task_struct;
 
 /*
@@ -77,7 +77,22 @@ void futex_exec_release(struct task_struct *tsk);
 
 long do_futex(u32 __user *uaddr, int op, u32 val, ktime_t *timeout,
 	      u32 __user *uaddr2, u32 val2, u32 val3);
-#else
+int futex_hash_prctl(unsigned long arg2, unsigned long arg3, unsigned long arg4);
+
+#ifdef CONFIG_FUTEX_PRIVATE_HASH
+void futex_hash_free(struct mm_struct *mm);
+
+static inline void futex_mm_init(struct mm_struct *mm)
+{
+	mm->futex_phash =  NULL;
+}
+
+#else /* !CONFIG_FUTEX_PRIVATE_HASH */
+static inline void futex_hash_free(struct mm_struct *mm) { }
+static inline void futex_mm_init(struct mm_struct *mm) { }
+#endif /* CONFIG_FUTEX_PRIVATE_HASH */
+
+#else /* !CONFIG_FUTEX */
 static inline void futex_init_task(struct task_struct *tsk) { }
 static inline void futex_exit_recursive(struct task_struct *tsk) { }
 static inline void futex_exit_release(struct task_struct *tsk) { }
@@ -88,6 +103,13 @@ static inline long do_futex(u32 __user *uaddr, int op, u32 val,
 {
 	return -EINVAL;
 }
+static inline int futex_hash_prctl(unsigned long arg2, unsigned long arg3, unsigned long arg4)
+{
+	return -EINVAL;
+}
+static inline void futex_hash_free(struct mm_struct *mm) { }
+static inline void futex_mm_init(struct mm_struct *mm) { }
+
 #endif
 
 #endif
diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index 56d07ed..a4b5661 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -31,6 +31,7 @@
 #define INIT_PASID	0
 
 struct address_space;
+struct futex_private_hash;
 struct mem_cgroup;
 
 /*
@@ -1031,7 +1032,9 @@ struct mm_struct {
 		 */
 		seqcount_t mm_lock_seq;
 #endif
-
+#ifdef CONFIG_FUTEX_PRIVATE_HASH
+		struct futex_private_hash	*futex_phash;
+#endif
 
 		unsigned long hiwater_rss; /* High-watermark of RSS usage */
 		unsigned long hiwater_vm;  /* High-water virtual memory usage */
diff --git a/include/uapi/linux/prctl.h b/include/uapi/linux/prctl.h
index 15c18ef..3b93fb9 100644
--- a/include/uapi/linux/prctl.h
+++ b/include/uapi/linux/prctl.h
@@ -364,4 +364,9 @@ struct prctl_mm_map {
 # define PR_TIMER_CREATE_RESTORE_IDS_ON		1
 # define PR_TIMER_CREATE_RESTORE_IDS_GET	2
 
+/* FUTEX hash management */
+#define PR_FUTEX_HASH			78
+# define PR_FUTEX_HASH_SET_SLOTS	1
+# define PR_FUTEX_HASH_GET_SLOTS	2
+
 #endif /* _LINUX_PRCTL_H */
diff --git a/init/Kconfig b/init/Kconfig
index 63f5974..4b84da2 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -1699,6 +1699,11 @@ config FUTEX_PI
 	depends on FUTEX && RT_MUTEXES
 	default y
 
+config FUTEX_PRIVATE_HASH
+	bool
+	depends on FUTEX && !BASE_SMALL && MMU
+	default y
+
 config EPOLL
 	bool "Enable eventpoll support" if EXPERT
 	default y
diff --git a/kernel/fork.c b/kernel/fork.c
index c4b26cd..831dfec 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -1305,6 +1305,7 @@ static struct mm_struct *mm_init(struct mm_struct *mm, struct task_struct *p,
 	RCU_INIT_POINTER(mm->exe_file, NULL);
 	mmu_notifier_subscriptions_init(mm);
 	init_tlb_flush_pending(mm);
+	futex_mm_init(mm);
 #if defined(CONFIG_TRANSPARENT_HUGEPAGE) && !defined(CONFIG_SPLIT_PMD_PTLOCKS)
 	mm->pmd_huge_pte = NULL;
 #endif
@@ -1387,6 +1388,7 @@ static inline void __mmput(struct mm_struct *mm)
 	if (mm->binfmt)
 		module_put(mm->binfmt->module);
 	lru_gen_del_mm(mm);
+	futex_hash_free(mm);
 	mmdrop(mm);
 }
 
diff --git a/kernel/futex/core.c b/kernel/futex/core.c
index afc6678..818df74 100644
--- a/kernel/futex/core.c
+++ b/kernel/futex/core.c
@@ -39,6 +39,7 @@
 #include <linux/memblock.h>
 #include <linux/fault-inject.h>
 #include <linux/slab.h>
+#include <linux/prctl.h>
 
 #include "futex.h"
 #include "../locking/rtmutex_common.h"
@@ -55,6 +56,12 @@ static struct {
 #define futex_queues   (__futex_data.queues)
 #define futex_hashmask (__futex_data.hashmask)
 
+struct futex_private_hash {
+	unsigned int	hash_mask;
+	void		*mm;
+	bool		custom;
+	struct futex_hash_bucket queues[];
+};
 
 /*
  * Fault injections for futexes.
@@ -107,9 +114,17 @@ late_initcall(fail_futex_debugfs);
 
 #endif /* CONFIG_FAIL_FUTEX */
 
-struct futex_private_hash *futex_private_hash(void)
+static struct futex_hash_bucket *
+__futex_hash(union futex_key *key, struct futex_private_hash *fph);
+
+#ifdef CONFIG_FUTEX_PRIVATE_HASH
+static inline bool futex_key_is_private(union futex_key *key)
 {
-	return NULL;
+	/*
+	 * Relies on get_futex_key() to set either bit for shared
+	 * futexes -- see comment with union futex_key.
+	 */
+	return !(key->both.offset & (FUT_OFF_INODE | FUT_OFF_MMSHARED));
 }
 
 bool futex_private_hash_get(struct futex_private_hash *fph)
@@ -117,21 +132,8 @@ bool futex_private_hash_get(struct futex_private_hash *fph)
 	return false;
 }
 
-void futex_private_hash_put(struct futex_private_hash *fph) { }
-
-/**
- * futex_hash - Return the hash bucket in the global hash
- * @key:	Pointer to the futex key for which the hash is calculated
- *
- * We hash on the keys returned from get_futex_key (see below) and return the
- * corresponding hash bucket in the global hash.
- */
-struct futex_hash_bucket *futex_hash(union futex_key *key)
+void futex_private_hash_put(struct futex_private_hash *fph)
 {
-	u32 hash = jhash2((u32 *)key, offsetof(typeof(*key), both.offset) / 4,
-			  key->both.offset);
-
-	return &futex_queues[hash & futex_hashmask];
 }
 
 /**
@@ -144,6 +146,84 @@ struct futex_hash_bucket *futex_hash(union futex_key *key)
 void futex_hash_get(struct futex_hash_bucket *hb) { }
 void futex_hash_put(struct futex_hash_bucket *hb) { }
 
+static struct futex_hash_bucket *
+__futex_hash_private(union futex_key *key, struct futex_private_hash *fph)
+{
+	u32 hash;
+
+	if (!futex_key_is_private(key))
+		return NULL;
+
+	if (!fph)
+		fph = key->private.mm->futex_phash;
+	if (!fph || !fph->hash_mask)
+		return NULL;
+
+	hash = jhash2((void *)&key->private.address,
+		      sizeof(key->private.address) / 4,
+		      key->both.offset);
+	return &fph->queues[hash & fph->hash_mask];
+}
+
+struct futex_private_hash *futex_private_hash(void)
+{
+	struct mm_struct *mm = current->mm;
+	struct futex_private_hash *fph;
+
+	fph = mm->futex_phash;
+	return fph;
+}
+
+struct futex_hash_bucket *futex_hash(union futex_key *key)
+{
+	struct futex_hash_bucket *hb;
+
+	hb = __futex_hash(key, NULL);
+	return hb;
+}
+
+#else /* !CONFIG_FUTEX_PRIVATE_HASH */
+
+static struct futex_hash_bucket *
+__futex_hash_private(union futex_key *key, struct futex_private_hash *fph)
+{
+	return NULL;
+}
+
+struct futex_hash_bucket *futex_hash(union futex_key *key)
+{
+	return __futex_hash(key, NULL);
+}
+
+#endif /* CONFIG_FUTEX_PRIVATE_HASH */
+
+/**
+ * __futex_hash - Return the hash bucket
+ * @key:	Pointer to the futex key for which the hash is calculated
+ * @fph:	Pointer to private hash if known
+ *
+ * We hash on the keys returned from get_futex_key (see below) and return the
+ * corresponding hash bucket.
+ * If the FUTEX is PROCESS_PRIVATE then a per-process hash bucket (from the
+ * private hash) is returned if existing. Otherwise a hash bucket from the
+ * global hash is returned.
+ */
+static struct futex_hash_bucket *
+__futex_hash(union futex_key *key, struct futex_private_hash *fph)
+{
+	struct futex_hash_bucket *hb;
+	u32 hash;
+
+	hb = __futex_hash_private(key, fph);
+	if (hb)
+		return hb;
+
+	hash = jhash2((u32 *)key,
+		      offsetof(typeof(*key), both.offset) / 4,
+		      key->both.offset);
+	return &futex_queues[hash & futex_hashmask];
+}
+
 /**
  * futex_setup_timer - set up the sleeping hrtimer.
  * @time:	ptr to the given timeout value
@@ -986,6 +1066,13 @@ static void exit_pi_state_list(struct task_struct *curr)
 	union futex_key key = FUTEX_KEY_INIT;
 
 	/*
+	 * Ensure the hash remains stable (no resize) during the while loop
+	 * below. The hb pointer is acquired under the pi_lock so we can't block
+	 * on the mutex.
+	 */
+	WARN_ON(curr != current);
+	guard(private_hash)();
+	/*
 	 * We are a ZOMBIE and nobody can enqueue itself on
 	 * pi_state_list anymore, but we have to be careful
 	 * versus waiters unqueueing themselves:
@@ -1160,13 +1247,98 @@ void futex_exit_release(struct task_struct *tsk)
 	futex_cleanup_end(tsk, FUTEX_STATE_DEAD);
 }
 
-static void futex_hash_bucket_init(struct futex_hash_bucket *fhb)
+static void futex_hash_bucket_init(struct futex_hash_bucket *fhb,
+				   struct futex_private_hash *fph)
 {
+#ifdef CONFIG_FUTEX_PRIVATE_HASH
+	fhb->priv = fph;
+#endif
 	atomic_set(&fhb->waiters, 0);
 	plist_head_init(&fhb->chain);
 	spin_lock_init(&fhb->lock);
 }
 
+#ifdef CONFIG_FUTEX_PRIVATE_HASH
+void futex_hash_free(struct mm_struct *mm)
+{
+	kvfree(mm->futex_phash);
+}
+
+static int futex_hash_allocate(unsigned int hash_slots, bool custom)
+{
+	struct mm_struct *mm = current->mm;
+	struct futex_private_hash *fph;
+	int i;
+
+	if (hash_slots && (hash_slots == 1 || !is_power_of_2(hash_slots)))
+		return -EINVAL;
+
+	if (mm->futex_phash)
+		return -EALREADY;
+
+	if (!thread_group_empty(current))
+		return -EINVAL;
+
+	fph = kvzalloc(struct_size(fph, queues, hash_slots), GFP_KERNEL_ACCOUNT | __GFP_NOWARN);
+	if (!fph)
+		return -ENOMEM;
+
+	fph->hash_mask = hash_slots ? hash_slots - 1 : 0;
+	fph->custom = custom;
+	fph->mm = mm;
+
+	for (i = 0; i < hash_slots; i++)
+		futex_hash_bucket_init(&fph->queues[i], fph);
+
+	mm->futex_phash = fph;
+	return 0;
+}
+
+static int futex_hash_get_slots(void)
+{
+	struct futex_private_hash *fph;
+
+	fph = current->mm->futex_phash;
+	if (fph && fph->hash_mask)
+		return fph->hash_mask + 1;
+	return 0;
+}
+
+#else
+
+static int futex_hash_allocate(unsigned int hash_slots, bool custom)
+{
+	return -EINVAL;
+}
+
+static int futex_hash_get_slots(void)
+{
+	return 0;
+}
+#endif
+
+int futex_hash_prctl(unsigned long arg2, unsigned long arg3, unsigned long arg4)
+{
+	int ret;
+
+	switch (arg2) {
+	case PR_FUTEX_HASH_SET_SLOTS:
+		if (arg4 != 0)
+			return -EINVAL;
+		ret = futex_hash_allocate(arg3, true);
+		break;
+
+	case PR_FUTEX_HASH_GET_SLOTS:
+		ret = futex_hash_get_slots();
+		break;
+
+	default:
+		ret = -EINVAL;
+		break;
+	}
+	return ret;
+}
+
 static int __init futex_init(void)
 {
 	unsigned long hashsize, i;
@@ -1185,7 +1357,7 @@ static int __init futex_init(void)
 	hashsize = 1UL << futex_shift;
 
 	for (i = 0; i < hashsize; i++)
-		futex_hash_bucket_init(&futex_queues[i]);
+		futex_hash_bucket_init(&futex_queues[i], NULL);
 
 	futex_hashmask = hashsize - 1;
 	return 0;
diff --git a/kernel/futex/futex.h b/kernel/futex/futex.h
index 26e6933..899aed5 100644
--- a/kernel/futex/futex.h
+++ b/kernel/futex/futex.h
@@ -118,6 +118,7 @@ struct futex_hash_bucket {
 	atomic_t waiters;
 	spinlock_t lock;
 	struct plist_head chain;
+	struct futex_private_hash *priv;
 } ____cacheline_aligned_in_smp;
 
 /*
@@ -204,6 +205,7 @@ futex_setup_timer(ktime_t *time, struct hrtimer_sleeper *timeout,
 		  int flags, u64 range_ns);
 
 extern struct futex_hash_bucket *futex_hash(union futex_key *key);
+#ifdef CONFIG_FUTEX_PRIVATE_HASH
 extern void futex_hash_get(struct futex_hash_bucket *hb);
 extern void futex_hash_put(struct futex_hash_bucket *hb);
 
@@ -211,6 +213,14 @@ extern struct futex_private_hash *futex_private_hash(void);
 extern bool futex_private_hash_get(struct futex_private_hash *fph);
 extern void futex_private_hash_put(struct futex_private_hash *fph);
 
+#else /* !CONFIG_FUTEX_PRIVATE_HASH */
+static inline void futex_hash_get(struct futex_hash_bucket *hb) { }
+static inline void futex_hash_put(struct futex_hash_bucket *hb) { }
+static inline struct futex_private_hash *futex_private_hash(void) { return NULL; }
+static inline bool futex_private_hash_get(void) { return false; }
+static inline void futex_private_hash_put(struct futex_private_hash *fph) { }
+#endif
+
 DEFINE_CLASS(hb, struct futex_hash_bucket *,
 	     if (_T) futex_hash_put(_T),
 	     futex_hash(key), union futex_key *key);
diff --git a/kernel/sys.c b/kernel/sys.c
index c434968..adc0de0 100644
--- a/kernel/sys.c
+++ b/kernel/sys.c
@@ -52,6 +52,7 @@
 #include <linux/user_namespace.h>
 #include <linux/time_namespace.h>
 #include <linux/binfmts.h>
+#include <linux/futex.h>
 
 #include <linux/sched.h>
 #include <linux/sched/autogroup.h>
@@ -2820,6 +2821,9 @@ SYSCALL_DEFINE5(prctl, int, option, unsigned long, arg2, unsigned long, arg3,
 			return -EINVAL;
 		error = posixtimer_create_prctl(arg2);
 		break;
+	case PR_FUTEX_HASH:
+		error = futex_hash_prctl(arg2, arg3, arg4);
+		break;
 	default:
 		trace_task_prctl_unknown(option, arg2, arg3, arg4, arg5);
 		error = -EINVAL;

