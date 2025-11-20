Return-Path: <linux-tip-commits+bounces-7425-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BA0FC73B2A
	for <lists+linux-tip-commits@lfdr.de>; Thu, 20 Nov 2025 12:24:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 543FE35BBB0
	for <lists+linux-tip-commits@lfdr.de>; Thu, 20 Nov 2025 11:23:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8886D32FA3A;
	Thu, 20 Nov 2025 11:20:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ORrrpV28";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Rn/R3RaT"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECF1832F76C;
	Thu, 20 Nov 2025 11:20:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763637617; cv=none; b=KW3WXxovamVsG1Y1UA4b3/7jEJ7oMmquTz3OjaWA1DDKDnzo9uUOhHZccy2q4WbW39ZWKdt1QUCpZGZdEujP3MQ9bUp1G9RNCfNxJlzXw8331EO+Sx1r66t3G6u/glPr6oCs4bUg2sYpY84cC/z0GbU1pDTez4pjOOaMIw8aznI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763637617; c=relaxed/simple;
	bh=+bDKFN9+xvJKg4uQehKlzBHlekWY5lIZBOBEjxoDs/A=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=c0F2TVEND/MeLikl/kvcOFxcpuVGu0JmdxDBxlAixA6MvUuMzJdd00mkgeU9oO+G+RInuQd2NsXse41la2UKTB/HVmfI44xcMXMROYqvgQlj2hg11c1E3286dWtdmq2FMv6wrA/nzcYBEzLekmh7JiYUJhDzO3fJ3tiTn3iQ9fs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ORrrpV28; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Rn/R3RaT; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 20 Nov 2025 11:20:09 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1763637610;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1kQr+RvZAuliDk5T/6c5VdNAwSv/IF/49RPaivgVj+4=;
	b=ORrrpV28Yt6tz4plp4o2r6jiQgZQjJe6nnLc74gv0YsYTZLrWt5xgMAWtA2a/Yi3g0GK4v
	BzPGNMg6zHtsWY/TtOzF2rkgyco1Wn896MSjWqDoWaZFJcCf9o4IHGBjEAI39fb7/632nK
	FyR0v/9D8w3Q2m94Rj/Dkr9w4oD9Ha0pU4q/Dunao0CnuFS+nLmfN2gGhpivBo7MLJMV5a
	O3b+S8s0pnQTxvMo+Es7GYsHKAo3wmtxj3/QS4v5pAD46S7rabUckgal2dUw7K4N1Q2QS4
	8WABFhhANl1RM7GamKN3517rAt+QLZp9IxWu11DZNkDPRN3DXlzvA2Ng5LLueQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1763637610;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1kQr+RvZAuliDk5T/6c5VdNAwSv/IF/49RPaivgVj+4=;
	b=Rn/R3RaTdVLYfaFbC6cXVbLl7cENqNM3NSUsfbVaUqMJzf0CLmMmO/rJ1E9EpVQe1ryKeL
	CGhwPv4DzMmOwBBQ==
From: "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: core/rseq] sched/mmcid: Use proper data structures
Cc: Thomas Gleixner <tglx@linutronix.de>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20251119172549.131573768@linutronix.de>
References: <20251119172549.131573768@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176363760921.498.277462510608484526.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the core/rseq branch of tip:

Commit-ID:     8cea569ca785060b8c5cc7800713ddc3b1548a94
Gitweb:        https://git.kernel.org/tip/8cea569ca785060b8c5cc7800713ddc3b15=
48a94
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Wed, 19 Nov 2025 18:26:47 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Thu, 20 Nov 2025 12:14:52 +01:00

sched/mmcid: Use proper data structures

Having a lot of CID functionality specific members in struct task_struct
and struct mm_struct is not really making the code easier to read.

Encapsulate the CID specific parts in data structures and keep them
separate from the stuff they are embedded in.

No functional change.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Link: https://patch.msgid.link/20251119172549.131573768@linutronix.de
---
 include/linux/mm_types.h   | 56 +++++++++----------------------------
 include/linux/rseq_types.h | 42 ++++++++++++++++++++++++++++-
 include/linux/sched.h      | 11 +------
 init/init_task.c           |  3 ++-
 kernel/fork.c              |  6 ++--
 kernel/sched/core.c        | 16 +++++------
 kernel/sched/sched.h       | 26 ++++++++---------
 7 files changed, 85 insertions(+), 75 deletions(-)

diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index 63b8c12..e4818e9 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -20,6 +20,7 @@
 #include <linux/seqlock.h>
 #include <linux/percpu_counter.h>
 #include <linux/types.h>
+#include <linux/rseq_types.h>
 #include <linux/bitmap.h>
=20
 #include <asm/mmu.h>
@@ -922,10 +923,6 @@ struct vm_area_struct {
 #define vma_policy(vma) NULL
 #endif
=20
-struct mm_cid {
-	unsigned int cid;
-};
-
 /*
  * Opaque type representing current mm_struct flag state. Must be accessed v=
ia
  * mm_flags_xxx() helper functions.
@@ -987,30 +984,9 @@ struct mm_struct {
 		 */
 		atomic_t mm_users;
=20
-#ifdef CONFIG_SCHED_MM_CID
-		/**
-		 * @pcpu_cid: Per-cpu current cid.
-		 *
-		 * Keep track of the currently allocated mm_cid for each cpu.
-		 * The per-cpu mm_cid values are serialized by their respective
-		 * runqueue locks.
-		 */
-		struct mm_cid __percpu *pcpu_cid;
-		/**
-		 * @nr_cpus_allowed: Number of CPUs allowed for mm.
-		 *
-		 * Number of CPUs allowed in the union of all mm's
-		 * threads allowed CPUs.
-		 */
-		unsigned int nr_cpus_allowed;
-		/**
-		 * @cpus_allowed_lock: Lock protecting mm cpus_allowed.
-		 *
-		 * Provide mutual exclusion for mm cpus_allowed and
-		 * mm nr_cpus_allowed updates.
-		 */
-		raw_spinlock_t cpus_allowed_lock;
-#endif
+		/* MM CID related storage */
+		struct mm_mm_cid mm_cid;
+
 #ifdef CONFIG_MMU
 		atomic_long_t pgtables_bytes;	/* size of all page tables */
 #endif
@@ -1352,9 +1328,6 @@ static inline void vma_iter_init(struct vma_iterator *v=
mi,
 }
=20
 #ifdef CONFIG_SCHED_MM_CID
-
-#define	MM_CID_UNSET	(~0U)
-
 /*
  * mm_cpus_allowed: Union of all mm's threads allowed CPUs.
  */
@@ -1383,20 +1356,20 @@ static inline void mm_init_cid(struct mm_struct *mm, =
struct task_struct *p)
 	int i;
=20
 	for_each_possible_cpu(i) {
-		struct mm_cid *pcpu_cid =3D per_cpu_ptr(mm->pcpu_cid, i);
+		struct mm_cid_pcpu *pcpu =3D per_cpu_ptr(mm->mm_cid.pcpu, i);
=20
-		pcpu_cid->cid =3D MM_CID_UNSET;
+		pcpu->cid =3D MM_CID_UNSET;
 	}
-	mm->nr_cpus_allowed =3D p->nr_cpus_allowed;
-	raw_spin_lock_init(&mm->cpus_allowed_lock);
+	mm->mm_cid.nr_cpus_allowed =3D p->nr_cpus_allowed;
+	raw_spin_lock_init(&mm->mm_cid.lock);
 	cpumask_copy(mm_cpus_allowed(mm), &p->cpus_mask);
 	cpumask_clear(mm_cidmask(mm));
 }
=20
 static inline int mm_alloc_cid_noprof(struct mm_struct *mm, struct task_stru=
ct *p)
 {
-	mm->pcpu_cid =3D alloc_percpu_noprof(struct mm_cid);
-	if (!mm->pcpu_cid)
+	mm->mm_cid.pcpu =3D alloc_percpu_noprof(struct mm_cid_pcpu);
+	if (!mm->mm_cid.pcpu)
 		return -ENOMEM;
 	mm_init_cid(mm, p);
 	return 0;
@@ -1405,8 +1378,8 @@ static inline int mm_alloc_cid_noprof(struct mm_struct =
*mm, struct task_struct *
=20
 static inline void mm_destroy_cid(struct mm_struct *mm)
 {
-	free_percpu(mm->pcpu_cid);
-	mm->pcpu_cid =3D NULL;
+	free_percpu(mm->mm_cid.pcpu);
+	mm->mm_cid.pcpu =3D NULL;
 }
=20
 static inline unsigned int mm_cid_size(void)
@@ -1421,10 +1394,9 @@ static inline void mm_set_cpus_allowed(struct mm_struc=
t *mm, const struct cpumas
 	if (!mm)
 		return;
 	/* The mm_cpus_allowed is the union of each thread allowed CPUs masks. */
-	raw_spin_lock(&mm->cpus_allowed_lock);
+	guard(raw_spinlock)(&mm->mm_cid.lock);
 	cpumask_or(mm_allowed, mm_allowed, cpumask);
-	WRITE_ONCE(mm->nr_cpus_allowed, cpumask_weight(mm_allowed));
-	raw_spin_unlock(&mm->cpus_allowed_lock);
+	WRITE_ONCE(mm->mm_cid.nr_cpus_allowed, cpumask_weight(mm_allowed));
 }
 #else /* CONFIG_SCHED_MM_CID */
 static inline void mm_init_cid(struct mm_struct *mm, struct task_struct *p) =
{ }
diff --git a/include/linux/rseq_types.h b/include/linux/rseq_types.h
index 9c7a341..e444dd2 100644
--- a/include/linux/rseq_types.h
+++ b/include/linux/rseq_types.h
@@ -90,4 +90,46 @@ struct rseq_data {
 struct rseq_data { };
 #endif /* !CONFIG_RSEQ */
=20
+#ifdef CONFIG_SCHED_MM_CID
+
+#define MM_CID_UNSET	(~0U)
+
+/**
+ * struct sched_mm_cid - Storage for per task MM CID data
+ * @active:	MM CID is active for the task
+ * @cid:	The CID associated to the task
+ * @last_cid:	The last CID associated to the task
+ */
+struct sched_mm_cid {
+	unsigned int		active;
+	unsigned int		cid;
+	unsigned int		last_cid;
+};
+
+/**
+ * struct mm_cid_pcpu - Storage for per CPU MM_CID data
+ * @cid:	The CID associated to the CPU
+ */
+struct mm_cid_pcpu {
+	unsigned int	cid;
+};
+
+/**
+ * struct mm_mm_cid - Storage for per MM CID data
+ * @pcpu:		Per CPU storage for CIDs associated to a CPU
+ * @nr_cpus_allowed:	The number of CPUs in the per MM allowed CPUs map. The =
map
+ *			is growth only.
+ * @lock:		Spinlock to protect all fields except @pcpu. It also protects
+ *			the MM cid cpumask and the MM cidmask bitmap.
+ */
+struct mm_mm_cid {
+	struct mm_cid_pcpu	__percpu *pcpu;
+	unsigned int		nr_cpus_allowed;
+	raw_spinlock_t		lock;
+};
+#else /* CONFIG_SCHED_MM_CID */
+struct mm_mm_cid { };
+struct sched_mm_cid { };
+#endif /* !CONFIG_SCHED_MM_CID */
+
 #endif
diff --git a/include/linux/sched.h b/include/linux/sched.h
index e47abc8..64f080d 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1407,14 +1407,7 @@ struct task_struct {
 #endif /* CONFIG_NUMA_BALANCING */
=20
 	struct rseq_data		rseq;
-
-#ifdef CONFIG_SCHED_MM_CID
-	int				mm_cid;		/* Current cid in mm */
-	int				last_mm_cid;	/* Most recent cid in mm */
-	int				migrate_from_cpu;
-	int				mm_cid_active;	/* Whether cid bitmap is active */
-	struct callback_head		cid_work;
-#endif
+	struct sched_mm_cid		mm_cid;
=20
 	struct tlbflush_unmap_batch	tlb_ubc;
=20
@@ -2308,7 +2301,7 @@ void sched_mm_cid_fork(struct task_struct *t);
 void sched_mm_cid_exit_signals(struct task_struct *t);
 static inline int task_mm_cid(struct task_struct *t)
 {
-	return t->mm_cid;
+	return t->mm_cid.cid;
 }
 #else
 static inline void sched_mm_cid_before_execve(struct task_struct *t) { }
diff --git a/init/init_task.c b/init/init_task.c
index a55e218..5d12269 100644
--- a/init/init_task.c
+++ b/init/init_task.c
@@ -223,6 +223,9 @@ struct task_struct init_task __aligned(L1_CACHE_BYTES) =
=3D {
 #ifdef CONFIG_SECCOMP_FILTER
 	.seccomp	=3D { .filter_count =3D ATOMIC_INIT(0) },
 #endif
+#ifdef CONFIG_SCHED_MM_CID
+	.mm_cid		=3D { .cid =3D MM_CID_UNSET, },
+#endif
 };
 EXPORT_SYMBOL(init_task);
=20
diff --git a/kernel/fork.c b/kernel/fork.c
index 9d9afe4..74bc7c9 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -955,9 +955,9 @@ static struct task_struct *dup_task_struct(struct task_st=
ruct *orig, int node)
 #endif
=20
 #ifdef CONFIG_SCHED_MM_CID
-	tsk->mm_cid =3D MM_CID_UNSET;
-	tsk->last_mm_cid =3D MM_CID_UNSET;
-	tsk->mm_cid_active =3D 0;
+	tsk->mm_cid.cid =3D MM_CID_UNSET;
+	tsk->mm_cid.last_cid =3D MM_CID_UNSET;
+	tsk->mm_cid.active =3D 0;
 #endif
 	return tsk;
=20
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 11a1735..b1aa7d1 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -10376,14 +10376,14 @@ void sched_mm_cid_exit_signals(struct task_struct *=
t)
 {
 	struct mm_struct *mm =3D t->mm;
=20
-	if (!mm || !t->mm_cid_active)
+	if (!mm || !t->mm_cid.active)
 		return;
=20
 	guard(preempt)();
-	t->mm_cid_active =3D 0;
-	if (t->mm_cid !=3D MM_CID_UNSET) {
-		cpumask_clear_cpu(t->mm_cid, mm_cidmask(mm));
-		t->mm_cid =3D MM_CID_UNSET;
+	t->mm_cid.active =3D 0;
+	if (t->mm_cid.cid !=3D MM_CID_UNSET) {
+		cpumask_clear_cpu(t->mm_cid.cid, mm_cidmask(mm));
+		t->mm_cid.cid =3D MM_CID_UNSET;
 	}
 }
=20
@@ -10402,14 +10402,14 @@ void sched_mm_cid_after_execve(struct task_struct *=
t)
 		return;
=20
 	guard(preempt)();
-	t->mm_cid_active =3D 1;
+	t->mm_cid.active =3D 1;
 	mm_cid_select(t);
 }
=20
 void sched_mm_cid_fork(struct task_struct *t)
 {
-	WARN_ON_ONCE(!t->mm || t->mm_cid !=3D MM_CID_UNSET);
-	t->mm_cid_active =3D 1;
+	WARN_ON_ONCE(!t->mm || t->mm_cid.cid !=3D MM_CID_UNSET);
+	t->mm_cid.active =3D 1;
 }
 #endif /* CONFIG_SCHED_MM_CID */
=20
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index bf227c2..a17f04f 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -3549,8 +3549,8 @@ static inline void init_sched_mm_cid(struct task_struct=
 *t)
 		return;
=20
 	/* Preset last_mm_cid */
-	max_cid =3D min_t(int, READ_ONCE(mm->nr_cpus_allowed), atomic_read(&mm->mm_=
users));
-	t->last_mm_cid =3D max_cid - 1;
+	max_cid =3D min_t(int, READ_ONCE(mm->mm_cid.nr_cpus_allowed), atomic_read(&=
mm->mm_users));
+	t->mm_cid.last_cid =3D max_cid - 1;
 }
=20
 static inline bool __mm_cid_get(struct task_struct *t, unsigned int cid, uns=
igned int max_cids)
@@ -3561,8 +3561,8 @@ static inline bool __mm_cid_get(struct task_struct *t, =
unsigned int cid, unsigne
 		return false;
 	if (cpumask_test_and_set_cpu(cid, mm_cidmask(mm)))
 		return false;
-	t->mm_cid =3D t->last_mm_cid =3D cid;
-	__this_cpu_write(mm->pcpu_cid->cid, cid);
+	t->mm_cid.cid =3D t->mm_cid.last_cid =3D cid;
+	__this_cpu_write(mm->mm_cid.pcpu->cid, cid);
 	return true;
 }
=20
@@ -3571,14 +3571,14 @@ static inline bool mm_cid_get(struct task_struct *t)
 	struct mm_struct *mm =3D t->mm;
 	unsigned int max_cids;
=20
-	max_cids =3D min_t(int, READ_ONCE(mm->nr_cpus_allowed), atomic_read(&mm->mm=
_users));
+	max_cids =3D min_t(int, READ_ONCE(mm->mm_cid.nr_cpus_allowed), atomic_read(=
&mm->mm_users));
=20
 	/* Try to reuse the last CID of this task */
-	if (__mm_cid_get(t, t->last_mm_cid, max_cids))
+	if (__mm_cid_get(t, t->mm_cid.last_cid, max_cids))
 		return true;
=20
 	/* Try to reuse the last CID of this mm on this CPU */
-	if (__mm_cid_get(t, __this_cpu_read(mm->pcpu_cid->cid), max_cids))
+	if (__mm_cid_get(t, __this_cpu_read(mm->mm_cid.pcpu->cid), max_cids))
 		return true;
=20
 	/* Try the first zero bit in the cidmask. */
@@ -3601,15 +3601,15 @@ static inline void mm_cid_select(struct task_struct *=
t)
=20
 static inline void switch_mm_cid(struct task_struct *prev, struct task_struc=
t *next)
 {
-	if (prev->mm_cid_active) {
-		if (prev->mm_cid !=3D MM_CID_UNSET)
-			cpumask_clear_cpu(prev->mm_cid, mm_cidmask(prev->mm));
-		prev->mm_cid =3D MM_CID_UNSET;
+	if (prev->mm_cid.active) {
+		if (prev->mm_cid.cid !=3D MM_CID_UNSET)
+			cpumask_clear_cpu(prev->mm_cid.cid, mm_cidmask(prev->mm));
+		prev->mm_cid.cid =3D MM_CID_UNSET;
 	}
=20
-	if (next->mm_cid_active) {
+	if (next->mm_cid.active) {
 		mm_cid_select(next);
-		rseq_sched_set_task_mm_cid(next, next->mm_cid);
+		rseq_sched_set_task_mm_cid(next, next->mm_cid.cid);
 	}
 }
=20

