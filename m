Return-Path: <linux-tip-commits+bounces-2517-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5211B9A36A8
	for <lists+linux-tip-commits@lfdr.de>; Fri, 18 Oct 2024 09:10:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 736A01C2336B
	for <lists+linux-tip-commits@lfdr.de>; Fri, 18 Oct 2024 07:10:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FD6F18E35B;
	Fri, 18 Oct 2024 07:08:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="RFrZcdVe";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="jOMwUGW6"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05A6718CC1E;
	Fri, 18 Oct 2024 07:07:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729235280; cv=none; b=FPk3FxjH2J4HxVyp9pVQ2YnRW29PVajgoSqyuBkbU5hWiPBI57nwrQcwKCF5tRcKh3M4bgjG3x229b9iA45WcRl1c2sLjOik9PRTSGoz9Jo0ujHXOtic209KOWNzBPp6YMRBl0rXYjX6izZNOQjCXbd9yUYm+O7qt+8gbppMJPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729235280; c=relaxed/simple;
	bh=mr5/9/18uLl111agpAm1YRYi6V15bADlZpFC5E4Juuc=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=urq4dnku7Bia+jNG/+2B5px+D0lSZtDFvTd2E6KnMv37l8EsGi9/6UY9TJ+kf1/zA/WHBQXyGO2KtXtzapJFDrYmbzy/TDB9e2gT42rXMiIeW9Hrc0MFxvtc/lr0xtwx7cO0jIYex8WBslQsW2xH4unElwKDqYgp1g494DvnWug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=RFrZcdVe; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=jOMwUGW6; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 18 Oct 2024 07:07:44 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1729235265;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=FkjCMloicva7rG2YlSWnfOeVFAXh5ujjvrvd+p6sUbM=;
	b=RFrZcdVenCYKVc+08bk9qBIs6KNvQP29CsjWuQb4KtbQRKF4s2PEwyP246jLFcczweblmQ
	UQfLrQHSXnx0OfOBdj5yzW9kEjiGWPaKvMFzaWEEMqrkrmMFzviaDmaZWe8ZqFU2L5iBSP
	b1Wozh+3SWjQM9Po9nIlHm6Q9y8Lb8uu5O2QAywlLMXO6eqtOYnV+UHCfUAJSNDDJFWlyU
	rwwa/MzM3i0pUpgULNLjRQ7jqtnWGuhfV/shoPGv87zdKFJkTHwssB0tv2nnGTZ9RPclb7
	+xZcV7masNUIk/ceaVw1m1YQtW8Z1+xtkvupa9a58IOurw+Ly0PS4++F+/pbBA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1729235265;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=FkjCMloicva7rG2YlSWnfOeVFAXh5ujjvrvd+p6sUbM=;
	b=jOMwUGW6u+w9tCffbmEoaPpkhxrC2sbZBfi4xN7aPFTUlRrnIqSF9P7ZnhnGQghm/B88G/
	pEEh/bvx0y3CT1Ag==
From: "tip-bot2 for Mathieu Desnoyers" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched: Improve cache locality of RSEQ concurrency
 IDs for intermittent workloads
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Marco Elver <elver@google.com>, x86@kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172923526494.1442.1373531333956730313.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     7e019dcc470f27066c98697e43d930df8d54bd9c
Gitweb:        https://git.kernel.org/tip/7e019dcc470f27066c98697e43d930df8d54bd9c
Author:        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
AuthorDate:    Wed, 09 Oct 2024 09:50:07 -04:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 14 Oct 2024 12:52:40 +02:00

sched: Improve cache locality of RSEQ concurrency IDs for intermittent workloads

commit 223baf9d17f25 ("sched: Fix performance regression introduced by mm_cid")
introduced a per-mm/cpu current concurrency id (mm_cid), which keeps
a reference to the concurrency id allocated for each CPU. This reference
expires shortly after a 100ms delay.

These per-CPU references keep the per-mm-cid data cache-local in
situations where threads are running at least once on each CPU within
each 100ms window, thus keeping the per-cpu reference alive.

However, intermittent workloads behaving in bursts spaced by more than
100ms on each CPU exhibit bad cache locality and degraded performance
compared to purely per-cpu data indexing, because concurrency IDs are
allocated over various CPUs and cores, therefore losing cache locality
of the associated data.

Introduce the following changes to improve per-mm-cid cache locality:

- Add a "recent_cid" field to the per-mm/cpu mm_cid structure to keep
  track of which mm_cid value was last used, and use it as a hint to
  attempt re-allocating the same concurrency ID the next time this
  mm/cpu needs to allocate a concurrency ID,

- Add a per-mm CPUs allowed mask, which keeps track of the union of
  CPUs allowed for all threads belonging to this mm. This cpumask is
  only set during the lifetime of the mm, never cleared, so it
  represents the union of all the CPUs allowed since the beginning of
  the mm lifetime (note that the mm_cpumask() is really arch-specific
  and tailored to the TLB flush needs, and is thus _not_ a viable
  approach for this),

- Add a per-mm nr_cpus_allowed to keep track of the weight of the
  per-mm CPUs allowed mask (for fast access),

- Add a per-mm max_nr_cid to keep track of the highest number of
  concurrency IDs allocated for the mm. This is used for expanding the
  concurrency ID allocation within the upper bound defined by:

    min(mm->nr_cpus_allowed, mm->mm_users)

  When the next unused CID value reaches this threshold, stop trying
  to expand the cid allocation and use the first available cid value
  instead.

  Spreading allocation to use all the cid values within the range

    [ 0, min(mm->nr_cpus_allowed, mm->mm_users) - 1 ]

  improves cache locality while preserving mm_cid compactness within the
  expected user limits,

- In __mm_cid_try_get, only return cid values within the range
  [ 0, mm->nr_cpus_allowed ] rather than [ 0, nr_cpu_ids ]. This
  prevents allocating cids above the number of allowed cpus in
  rare scenarios where cid allocation races with a concurrent
  remote-clear of the per-mm/cpu cid. This improvement is made
  possible by the addition of the per-mm CPUs allowed mask,

- In sched_mm_cid_migrate_to, use mm->nr_cpus_allowed rather than
  t->nr_cpus_allowed. This criterion was really meant to compare
  the number of mm->mm_users to the number of CPUs allowed for the
  entire mm. Therefore, the prior comparison worked fine when all
  threads shared the same CPUs allowed mask, but not so much in
  scenarios where those threads have different masks (e.g. each
  thread pinned to a single CPU). This improvement is made
  possible by the addition of the per-mm CPUs allowed mask.

* Benchmarks

Each thread increments 16kB worth of 8-bit integers in bursts, with
a configurable delay between each thread's execution. Each thread run
one after the other (no threads run concurrently). The order of
thread execution in the sequence is random. The thread execution
sequence begins again after all threads have executed. The 16kB areas
are allocated with rseq_mempool and indexed by either cpu_id, mm_cid
(not cache-local), or cache-local mm_cid. Each thread is pinned to its
own core.

Testing configurations:

8-core/1-L3:        Use 8 cores within a single L3
24-core/24-L3:      Use 24 cores, 1 core per L3
192-core/24-L3:     Use 192 cores (all cores in the system)
384-thread/24-L3:   Use 384 HW threads (all HW threads in the system)

Intermittent workload delays between threads: 200ms, 10ms.

Hardware:

CPU(s):                   384
  On-line CPU(s) list:    0-383
Vendor ID:                AuthenticAMD
  Model name:             AMD EPYC 9654 96-Core Processor
    Thread(s) per core:   2
    Core(s) per socket:   96
    Socket(s):            2
Caches (sum of all):
  L1d:                    6 MiB (192 instances)
  L1i:                    6 MiB (192 instances)
  L2:                     192 MiB (192 instances)
  L3:                     768 MiB (24 instances)

Each result is an average of 5 test runs. The cache-local speedup
is calculated as: (cache-local mm_cid) / (mm_cid).

Intermittent workload delay: 200ms

                     per-cpu     mm_cid    cache-local mm_cid    cache-local speedup
                         (ns)      (ns)                  (ns)
8-core/1-L3             1374      19289                  1336            14.4x
24-core/24-L3           2423      26721                  1594            16.7x
192-core/24-L3          2291      15826                  2153             7.3x
384-thread/24-L3        1874      13234                  1907             6.9x

Intermittent workload delay: 10ms

                     per-cpu     mm_cid    cache-local mm_cid    cache-local speedup
                         (ns)      (ns)                  (ns)
8-core/1-L3               662       756                   686             1.1x
24-core/24-L3            1378      3648                  1035             3.5x
192-core/24-L3           1439     10833                  1482             7.3x
384-thread/24-L3         1503     10570                  1556             6.8x

[ This deprecates the prior "sched: NUMA-aware per-memory-map concurrency IDs"
  patch series with a simpler and more general approach. ]

[ This patch applies on top of v6.12-rc1. ]

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Marco Elver <elver@google.com>
Link: https://lore.kernel.org/lkml/20240823185946.418340-1-mathieu.desnoyers@efficios.com/
---
 fs/exec.c                |  2 +-
 include/linux/mm_types.h | 72 ++++++++++++++++++++++++++++++++++-----
 kernel/fork.c            |  2 +-
 kernel/sched/core.c      | 22 +++++++-----
 kernel/sched/sched.h     | 48 ++++++++++++++++++--------
 5 files changed, 112 insertions(+), 34 deletions(-)

diff --git a/fs/exec.c b/fs/exec.c
index 6c53920..aaa6055 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -990,7 +990,7 @@ static int exec_mmap(struct mm_struct *mm)
 	active_mm = tsk->active_mm;
 	tsk->active_mm = mm;
 	tsk->mm = mm;
-	mm_init_cid(mm);
+	mm_init_cid(mm, tsk);
 	/*
 	 * This prevents preemption while active_mm is being loaded and
 	 * it and mm are being updated, which could cause problems for
diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index 6e3bdf8..381d22e 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -782,6 +782,7 @@ struct vm_area_struct {
 struct mm_cid {
 	u64 time;
 	int cid;
+	int recent_cid;
 };
 #endif
 
@@ -852,6 +853,27 @@ struct mm_struct {
 		 * When the next mm_cid scan is due (in jiffies).
 		 */
 		unsigned long mm_cid_next_scan;
+		/**
+		 * @nr_cpus_allowed: Number of CPUs allowed for mm.
+		 *
+		 * Number of CPUs allowed in the union of all mm's
+		 * threads allowed CPUs.
+		 */
+		unsigned int nr_cpus_allowed;
+		/**
+		 * @max_nr_cid: Maximum number of concurrency IDs allocated.
+		 *
+		 * Track the highest number of concurrency IDs allocated for the
+		 * mm.
+		 */
+		atomic_t max_nr_cid;
+		/**
+		 * @cpus_allowed_lock: Lock protecting mm cpus_allowed.
+		 *
+		 * Provide mutual exclusion for mm cpus_allowed and
+		 * mm nr_cpus_allowed updates.
+		 */
+		raw_spinlock_t cpus_allowed_lock;
 #endif
 #ifdef CONFIG_MMU
 		atomic_long_t pgtables_bytes;	/* size of all page tables */
@@ -1170,18 +1192,30 @@ static inline int mm_cid_clear_lazy_put(int cid)
 	return cid & ~MM_CID_LAZY_PUT;
 }
 
+/*
+ * mm_cpus_allowed: Union of all mm's threads allowed CPUs.
+ */
+static inline cpumask_t *mm_cpus_allowed(struct mm_struct *mm)
+{
+	unsigned long bitmap = (unsigned long)mm;
+
+	bitmap += offsetof(struct mm_struct, cpu_bitmap);
+	/* Skip cpu_bitmap */
+	bitmap += cpumask_size();
+	return (struct cpumask *)bitmap;
+}
+
 /* Accessor for struct mm_struct's cidmask. */
 static inline cpumask_t *mm_cidmask(struct mm_struct *mm)
 {
-	unsigned long cid_bitmap = (unsigned long)mm;
+	unsigned long cid_bitmap = (unsigned long)mm_cpus_allowed(mm);
 
-	cid_bitmap += offsetof(struct mm_struct, cpu_bitmap);
-	/* Skip cpu_bitmap */
+	/* Skip mm_cpus_allowed */
 	cid_bitmap += cpumask_size();
 	return (struct cpumask *)cid_bitmap;
 }
 
-static inline void mm_init_cid(struct mm_struct *mm)
+static inline void mm_init_cid(struct mm_struct *mm, struct task_struct *p)
 {
 	int i;
 
@@ -1189,17 +1223,22 @@ static inline void mm_init_cid(struct mm_struct *mm)
 		struct mm_cid *pcpu_cid = per_cpu_ptr(mm->pcpu_cid, i);
 
 		pcpu_cid->cid = MM_CID_UNSET;
+		pcpu_cid->recent_cid = MM_CID_UNSET;
 		pcpu_cid->time = 0;
 	}
+	mm->nr_cpus_allowed = p->nr_cpus_allowed;
+	atomic_set(&mm->max_nr_cid, 0);
+	raw_spin_lock_init(&mm->cpus_allowed_lock);
+	cpumask_copy(mm_cpus_allowed(mm), &p->cpus_mask);
 	cpumask_clear(mm_cidmask(mm));
 }
 
-static inline int mm_alloc_cid_noprof(struct mm_struct *mm)
+static inline int mm_alloc_cid_noprof(struct mm_struct *mm, struct task_struct *p)
 {
 	mm->pcpu_cid = alloc_percpu_noprof(struct mm_cid);
 	if (!mm->pcpu_cid)
 		return -ENOMEM;
-	mm_init_cid(mm);
+	mm_init_cid(mm, p);
 	return 0;
 }
 #define mm_alloc_cid(...)	alloc_hooks(mm_alloc_cid_noprof(__VA_ARGS__))
@@ -1212,16 +1251,31 @@ static inline void mm_destroy_cid(struct mm_struct *mm)
 
 static inline unsigned int mm_cid_size(void)
 {
-	return cpumask_size();
+	return 2 * cpumask_size();	/* mm_cpus_allowed(), mm_cidmask(). */
+}
+
+static inline void mm_set_cpus_allowed(struct mm_struct *mm, const struct cpumask *cpumask)
+{
+	struct cpumask *mm_allowed = mm_cpus_allowed(mm);
+
+	if (!mm)
+		return;
+	/* The mm_cpus_allowed is the union of each thread allowed CPUs masks. */
+	raw_spin_lock(&mm->cpus_allowed_lock);
+	cpumask_or(mm_allowed, mm_allowed, cpumask);
+	WRITE_ONCE(mm->nr_cpus_allowed, cpumask_weight(mm_allowed));
+	raw_spin_unlock(&mm->cpus_allowed_lock);
 }
 #else /* CONFIG_SCHED_MM_CID */
-static inline void mm_init_cid(struct mm_struct *mm) { }
-static inline int mm_alloc_cid(struct mm_struct *mm) { return 0; }
+static inline void mm_init_cid(struct mm_struct *mm, struct task_struct *p) { }
+static inline int mm_alloc_cid(struct mm_struct *mm, struct task_struct *p) { return 0; }
 static inline void mm_destroy_cid(struct mm_struct *mm) { }
+
 static inline unsigned int mm_cid_size(void)
 {
 	return 0;
 }
+static inline void mm_set_cpus_allowed(struct mm_struct *mm, const struct cpumask *cpumask) { }
 #endif /* CONFIG_SCHED_MM_CID */
 
 struct mmu_gather;
diff --git a/kernel/fork.c b/kernel/fork.c
index 89ceb4a..7d950e9 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -1298,7 +1298,7 @@ static struct mm_struct *mm_init(struct mm_struct *mm, struct task_struct *p,
 	if (init_new_context(p, mm))
 		goto fail_nocontext;
 
-	if (mm_alloc_cid(mm))
+	if (mm_alloc_cid(mm, p))
 		goto fail_cid;
 
 	if (percpu_counter_init_many(mm->rss_stat, 0, GFP_KERNEL_ACCOUNT,
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 7db711b..f5ec452 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -2696,6 +2696,7 @@ __do_set_cpus_allowed(struct task_struct *p, struct affinity_context *ctx)
 		put_prev_task(rq, p);
 
 	p->sched_class->set_cpus_allowed(p, ctx);
+	mm_set_cpus_allowed(p->mm, ctx->new_mask);
 
 	if (queued)
 		enqueue_task(rq, p, ENQUEUE_RESTORE | ENQUEUE_NOCLOCK);
@@ -10243,6 +10244,7 @@ int __sched_mm_cid_migrate_from_try_steal_cid(struct rq *src_rq,
 	 */
 	if (!try_cmpxchg(&src_pcpu_cid->cid, &lazy_cid, MM_CID_UNSET))
 		return -1;
+	WRITE_ONCE(src_pcpu_cid->recent_cid, MM_CID_UNSET);
 	return src_cid;
 }
 
@@ -10255,7 +10257,8 @@ void sched_mm_cid_migrate_to(struct rq *dst_rq, struct task_struct *t)
 {
 	struct mm_cid *src_pcpu_cid, *dst_pcpu_cid;
 	struct mm_struct *mm = t->mm;
-	int src_cid, dst_cid, src_cpu;
+	int src_cid, src_cpu;
+	bool dst_cid_is_set;
 	struct rq *src_rq;
 
 	lockdep_assert_rq_held(dst_rq);
@@ -10272,9 +10275,9 @@ void sched_mm_cid_migrate_to(struct rq *dst_rq, struct task_struct *t)
 	 * allocation closest to 0 in cases where few threads migrate around
 	 * many CPUs.
 	 *
-	 * If destination cid is already set, we may have to just clear
-	 * the src cid to ensure compactness in frequent migrations
-	 * scenarios.
+	 * If destination cid or recent cid is already set, we may have
+	 * to just clear the src cid to ensure compactness in frequent
+	 * migrations scenarios.
 	 *
 	 * It is not useful to clear the src cid when the number of threads is
 	 * greater or equal to the number of allowed CPUs, because user-space
@@ -10282,9 +10285,9 @@ void sched_mm_cid_migrate_to(struct rq *dst_rq, struct task_struct *t)
 	 * allowed CPUs.
 	 */
 	dst_pcpu_cid = per_cpu_ptr(mm->pcpu_cid, cpu_of(dst_rq));
-	dst_cid = READ_ONCE(dst_pcpu_cid->cid);
-	if (!mm_cid_is_unset(dst_cid) &&
-	    atomic_read(&mm->mm_users) >= t->nr_cpus_allowed)
+	dst_cid_is_set = !mm_cid_is_unset(READ_ONCE(dst_pcpu_cid->cid)) ||
+			 !mm_cid_is_unset(READ_ONCE(dst_pcpu_cid->recent_cid));
+	if (dst_cid_is_set && atomic_read(&mm->mm_users) >= READ_ONCE(mm->nr_cpus_allowed))
 		return;
 	src_pcpu_cid = per_cpu_ptr(mm->pcpu_cid, src_cpu);
 	src_rq = cpu_rq(src_cpu);
@@ -10295,13 +10298,14 @@ void sched_mm_cid_migrate_to(struct rq *dst_rq, struct task_struct *t)
 							    src_cid);
 	if (src_cid == -1)
 		return;
-	if (!mm_cid_is_unset(dst_cid)) {
+	if (dst_cid_is_set) {
 		__mm_cid_put(mm, src_cid);
 		return;
 	}
 	/* Move src_cid to dst cpu. */
 	mm_cid_snapshot_time(dst_rq, mm);
 	WRITE_ONCE(dst_pcpu_cid->cid, src_cid);
+	WRITE_ONCE(dst_pcpu_cid->recent_cid, src_cid);
 }
 
 static void sched_mm_cid_remote_clear(struct mm_struct *mm, struct mm_cid *pcpu_cid,
@@ -10540,7 +10544,7 @@ void sched_mm_cid_after_execve(struct task_struct *t)
 		 * Matches barrier in sched_mm_cid_remote_clear_old().
 		 */
 		smp_mb();
-		t->last_mm_cid = t->mm_cid = mm_cid_get(rq, mm);
+		t->last_mm_cid = t->mm_cid = mm_cid_get(rq, t, mm);
 	}
 	rseq_set_notify_resume(t);
 }
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index fba524c..20b6e75 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -3596,24 +3596,41 @@ static inline void mm_cid_put(struct mm_struct *mm)
 	__mm_cid_put(mm, mm_cid_clear_lazy_put(cid));
 }
 
-static inline int __mm_cid_try_get(struct mm_struct *mm)
+static inline int __mm_cid_try_get(struct task_struct *t, struct mm_struct *mm)
 {
-	struct cpumask *cpumask;
-	int cid;
+	struct cpumask *cidmask = mm_cidmask(mm);
+	struct mm_cid __percpu *pcpu_cid = mm->pcpu_cid;
+	int cid = __this_cpu_read(pcpu_cid->recent_cid);
 
-	cpumask = mm_cidmask(mm);
+	/* Try to re-use recent cid. This improves cache locality. */
+	if (!mm_cid_is_unset(cid) && !cpumask_test_and_set_cpu(cid, cidmask))
+		return cid;
+	/*
+	 * Expand cid allocation if the maximum number of concurrency
+	 * IDs allocated (max_nr_cid) is below the number cpus allowed
+	 * and number of threads. Expanding cid allocation as much as
+	 * possible improves cache locality.
+	 */
+	cid = atomic_read(&mm->max_nr_cid);
+	while (cid < READ_ONCE(mm->nr_cpus_allowed) && cid < atomic_read(&mm->mm_users)) {
+		if (!atomic_try_cmpxchg(&mm->max_nr_cid, &cid, cid + 1))
+			continue;
+		if (!cpumask_test_and_set_cpu(cid, cidmask))
+			return cid;
+	}
 	/*
+	 * Find the first available concurrency id.
 	 * Retry finding first zero bit if the mask is temporarily
 	 * filled. This only happens during concurrent remote-clear
 	 * which owns a cid without holding a rq lock.
 	 */
 	for (;;) {
-		cid = cpumask_first_zero(cpumask);
-		if (cid < nr_cpu_ids)
+		cid = cpumask_first_zero(cidmask);
+		if (cid < READ_ONCE(mm->nr_cpus_allowed))
 			break;
 		cpu_relax();
 	}
-	if (cpumask_test_and_set_cpu(cid, cpumask))
+	if (cpumask_test_and_set_cpu(cid, cidmask))
 		return -1;
 
 	return cid;
@@ -3631,7 +3648,8 @@ static inline void mm_cid_snapshot_time(struct rq *rq, struct mm_struct *mm)
 	WRITE_ONCE(pcpu_cid->time, rq->clock);
 }
 
-static inline int __mm_cid_get(struct rq *rq, struct mm_struct *mm)
+static inline int __mm_cid_get(struct rq *rq, struct task_struct *t,
+			       struct mm_struct *mm)
 {
 	int cid;
 
@@ -3641,13 +3659,13 @@ static inline int __mm_cid_get(struct rq *rq, struct mm_struct *mm)
 	 * guarantee forward progress.
 	 */
 	if (!READ_ONCE(use_cid_lock)) {
-		cid = __mm_cid_try_get(mm);
+		cid = __mm_cid_try_get(t, mm);
 		if (cid >= 0)
 			goto end;
 		raw_spin_lock(&cid_lock);
 	} else {
 		raw_spin_lock(&cid_lock);
-		cid = __mm_cid_try_get(mm);
+		cid = __mm_cid_try_get(t, mm);
 		if (cid >= 0)
 			goto unlock;
 	}
@@ -3667,7 +3685,7 @@ static inline int __mm_cid_get(struct rq *rq, struct mm_struct *mm)
 	 * all newcoming allocations observe the use_cid_lock flag set.
 	 */
 	do {
-		cid = __mm_cid_try_get(mm);
+		cid = __mm_cid_try_get(t, mm);
 		cpu_relax();
 	} while (cid < 0);
 	/*
@@ -3684,7 +3702,8 @@ end:
 	return cid;
 }
 
-static inline int mm_cid_get(struct rq *rq, struct mm_struct *mm)
+static inline int mm_cid_get(struct rq *rq, struct task_struct *t,
+			     struct mm_struct *mm)
 {
 	struct mm_cid __percpu *pcpu_cid = mm->pcpu_cid;
 	struct cpumask *cpumask;
@@ -3701,8 +3720,9 @@ static inline int mm_cid_get(struct rq *rq, struct mm_struct *mm)
 		if (try_cmpxchg(&this_cpu_ptr(pcpu_cid)->cid, &cid, MM_CID_UNSET))
 			__mm_cid_put(mm, mm_cid_clear_lazy_put(cid));
 	}
-	cid = __mm_cid_get(rq, mm);
+	cid = __mm_cid_get(rq, t, mm);
 	__this_cpu_write(pcpu_cid->cid, cid);
+	__this_cpu_write(pcpu_cid->recent_cid, cid);
 
 	return cid;
 }
@@ -3755,7 +3775,7 @@ static inline void switch_mm_cid(struct rq *rq,
 		prev->mm_cid = -1;
 	}
 	if (next->mm_cid_active)
-		next->last_mm_cid = next->mm_cid = mm_cid_get(rq, next->mm);
+		next->last_mm_cid = next->mm_cid = mm_cid_get(rq, next, next->mm);
 }
 
 #else /* !CONFIG_SCHED_MM_CID: */

