Return-Path: <linux-tip-commits+bounces-7426-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B315C73B27
	for <lists+linux-tip-commits@lfdr.de>; Thu, 20 Nov 2025 12:24:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9F4E44EA705
	for <lists+linux-tip-commits@lfdr.de>; Thu, 20 Nov 2025 11:23:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54E373358DE;
	Thu, 20 Nov 2025 11:20:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="U4RUTeqE";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="/Fcod1CR"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92D68335099;
	Thu, 20 Nov 2025 11:20:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763637619; cv=none; b=cuf2iy5KVb414bE1j/WE8Wqwy8frmNXN1sJoEyfh9Y+eGE+9G2zW/8kzWAq3A7h7EQ7Ib9Usk/oJPEjfoeaxXAd7Ee11WhlcsyPw2BuQCboP4oaj2PPbyJiBtRkONzIPUQL8apQJOMwG5IWzJa5UGeEEVrM/B/KeifJvGsPYcL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763637619; c=relaxed/simple;
	bh=XRxgSKmV5UevAHchzlRd2jGfakTNUWt9EhBTJKRwaYA=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=Wp24GnngOUmrPlTaTch3zXobZaG9eg+Ya4Ch7zteb65Vhbuknn52USd0xsb87D0pSkETY8PK3HZXPsCVOq8i7ahCLsOU23Y5k272E9sQkop4kRCXPLZikSx5E9hWlYswQGQesWlCE5wg27ylg8bPr/FWic5I/kNBlQ94YSIi3Nc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=U4RUTeqE; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=/Fcod1CR; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 20 Nov 2025 11:20:10 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1763637611;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5Vjp1eRx026faF9ZCjXfplXkiG1HT/kLujSNtoIMunw=;
	b=U4RUTeqE+WLRN+jLr0Fx/o0Rtn1goryVxrUAsWp6fq6dLlaJQYIBwBho7PPfvIWT9zmj8j
	Y2Voz0Qr2UVEzzLQoE/IjaK9YtC5N/W+QKUWCi6xLQXV2vJ9EVTxQCzlGdpsZE1iVN5kau
	WeAZ/kZ1biC34yUHJis3oRG2ZU0afU3nXe5zMumuL34Iata5ckqLSCNJ9zNGfNpaqOxa2N
	aEnPxZr6ygIsRglJHIKY6n9PdOmtbjfZJOIwehTkVzh540+aS/NttvRf5Vm8n2+zSiQKHk
	0ChQPZFY9XN3vgCGWStDGCQlG07Sj5q0ZGHItrAxAcw8DBa3aKT19Ad4mJO5tA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1763637611;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5Vjp1eRx026faF9ZCjXfplXkiG1HT/kLujSNtoIMunw=;
	b=/Fcod1CRBLbk2BplnxNZMRrJ7VX+rYwxZydyXAcMzLBpACW2STRIwbSJrfqvW0vgdHHVwd
	M/oxy5FnjMHXQHBw==
From: "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: core/rseq] sched/mmcid: Revert the complex CID management
Cc: Thomas Gleixner <tglx@linutronix.de>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20251119172549.068197830@linutronix.de>
References: <20251119172549.068197830@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176363761025.498.1247184506721481641.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the core/rseq branch of tip:

Commit-ID:     77d7dc8bef482e987036bc204136bbda552d95cd
Gitweb:        https://git.kernel.org/tip/77d7dc8bef482e987036bc204136bbda552=
d95cd
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Wed, 19 Nov 2025 18:26:45 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Thu, 20 Nov 2025 12:14:52 +01:00

sched/mmcid: Revert the complex CID management

The CID management is a complex beast, which affects both scheduling and
task migration. The compaction mechanism forces random tasks of a process
into task work on exit to user space causing latency spikes.

Revert back to the initial simple bitmap allocating mechanics, which are
known to have scalability issues as that allows to gradually build up a
replacement functionality in a reviewable way.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Link: https://patch.msgid.link/20251119172549.068197830@linutronix.de
---
 include/linux/mm_types.h |  53 +----
 kernel/fork.c            |   5 +-
 kernel/sched/core.c      | 517 +-------------------------------------
 kernel/sched/sched.h     | 289 +++------------------
 4 files changed, 64 insertions(+), 800 deletions(-)

diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index 90e5790..63b8c12 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -922,13 +922,9 @@ struct vm_area_struct {
 #define vma_policy(vma) NULL
 #endif
=20
-#ifdef CONFIG_SCHED_MM_CID
 struct mm_cid {
-	u64 time;
-	int cid;
-	int recent_cid;
+	unsigned int cid;
 };
-#endif
=20
 /*
  * Opaque type representing current mm_struct flag state. Must be accessed v=
ia
@@ -1000,12 +996,6 @@ struct mm_struct {
 		 * runqueue locks.
 		 */
 		struct mm_cid __percpu *pcpu_cid;
-		/*
-		 * @mm_cid_next_scan: Next mm_cid scan (in jiffies).
-		 *
-		 * When the next mm_cid scan is due (in jiffies).
-		 */
-		unsigned long mm_cid_next_scan;
 		/**
 		 * @nr_cpus_allowed: Number of CPUs allowed for mm.
 		 *
@@ -1014,14 +1004,6 @@ struct mm_struct {
 		 */
 		unsigned int nr_cpus_allowed;
 		/**
-		 * @max_nr_cid: Maximum number of allowed concurrency
-		 *              IDs allocated.
-		 *
-		 * Track the highest number of allowed concurrency IDs
-		 * allocated for the mm.
-		 */
-		atomic_t max_nr_cid;
-		/**
 		 * @cpus_allowed_lock: Lock protecting mm cpus_allowed.
 		 *
 		 * Provide mutual exclusion for mm cpus_allowed and
@@ -1371,35 +1353,7 @@ static inline void vma_iter_init(struct vma_iterator *=
vmi,
=20
 #ifdef CONFIG_SCHED_MM_CID
=20
-enum mm_cid_state {
-	MM_CID_UNSET =3D -1U,		/* Unset state has lazy_put flag set. */
-	MM_CID_LAZY_PUT =3D (1U << 31),
-};
-
-static inline bool mm_cid_is_unset(int cid)
-{
-	return cid =3D=3D MM_CID_UNSET;
-}
-
-static inline bool mm_cid_is_lazy_put(int cid)
-{
-	return !mm_cid_is_unset(cid) && (cid & MM_CID_LAZY_PUT);
-}
-
-static inline bool mm_cid_is_valid(int cid)
-{
-	return !(cid & MM_CID_LAZY_PUT);
-}
-
-static inline int mm_cid_set_lazy_put(int cid)
-{
-	return cid | MM_CID_LAZY_PUT;
-}
-
-static inline int mm_cid_clear_lazy_put(int cid)
-{
-	return cid & ~MM_CID_LAZY_PUT;
-}
+#define	MM_CID_UNSET	(~0U)
=20
 /*
  * mm_cpus_allowed: Union of all mm's threads allowed CPUs.
@@ -1432,11 +1386,8 @@ static inline void mm_init_cid(struct mm_struct *mm, s=
truct task_struct *p)
 		struct mm_cid *pcpu_cid =3D per_cpu_ptr(mm->pcpu_cid, i);
=20
 		pcpu_cid->cid =3D MM_CID_UNSET;
-		pcpu_cid->recent_cid =3D MM_CID_UNSET;
-		pcpu_cid->time =3D 0;
 	}
 	mm->nr_cpus_allowed =3D p->nr_cpus_allowed;
-	atomic_set(&mm->max_nr_cid, 0);
 	raw_spin_lock_init(&mm->cpus_allowed_lock);
 	cpumask_copy(mm_cpus_allowed(mm), &p->cpus_mask);
 	cpumask_clear(mm_cidmask(mm));
diff --git a/kernel/fork.c b/kernel/fork.c
index 3da0f08..9d9afe4 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -955,10 +955,9 @@ static struct task_struct *dup_task_struct(struct task_s=
truct *orig, int node)
 #endif
=20
 #ifdef CONFIG_SCHED_MM_CID
-	tsk->mm_cid =3D -1;
-	tsk->last_mm_cid =3D -1;
+	tsk->mm_cid =3D MM_CID_UNSET;
+	tsk->last_mm_cid =3D MM_CID_UNSET;
 	tsk->mm_cid_active =3D 0;
-	tsk->migrate_from_cpu =3D -1;
 #endif
 	return tsk;
=20
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 579a8e9..11a1735 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -2128,8 +2128,6 @@ void activate_task(struct rq *rq, struct task_struct *p=
, int flags)
 {
 	if (task_on_rq_migrating(p))
 		flags |=3D ENQUEUE_MIGRATED;
-	if (flags & ENQUEUE_MIGRATED)
-		sched_mm_cid_migrate_to(rq, p);
=20
 	enqueue_task(rq, p, flags);
=20
@@ -3329,7 +3327,6 @@ void set_task_cpu(struct task_struct *p, unsigned int n=
ew_cpu)
 		if (p->sched_class->migrate_task_rq)
 			p->sched_class->migrate_task_rq(p, new_cpu);
 		p->se.nr_migrations++;
-		sched_mm_cid_migrate_from(p);
 		perf_event_task_migrate(p);
 	}
=20
@@ -5280,9 +5277,6 @@ context_switch(struct rq *rq, struct task_struct *prev,
 	 *
 	 * kernel ->   user   switch + mmdrop_lazy_tlb() active
 	 *   user ->   user   switch
-	 *
-	 * switch_mm_cid() needs to be updated if the barriers provided
-	 * by context_switch() are modified.
 	 */
 	if (!next->mm) {                                // to kernel
 		enter_lazy_tlb(prev->active_mm, next);
@@ -5312,8 +5306,7 @@ context_switch(struct rq *rq, struct task_struct *prev,
 		}
 	}
=20
-	/* switch_mm_cid() requires the memory barriers above. */
-	switch_mm_cid(rq, prev, next);
+	switch_mm_cid(prev, next);
=20
 	/*
 	 * Tell rseq that the task was scheduled in. Must be after
@@ -5604,7 +5597,6 @@ void sched_tick(void)
 		resched_latency =3D cpu_resched_latency(rq);
 	calc_global_load_tick(rq);
 	sched_core_tick(rq);
-	task_tick_mm_cid(rq, donor);
 	scx_tick(rq);
=20
 	rq_unlock(rq, &rf);
@@ -10376,522 +10368,47 @@ void call_trace_sched_update_nr_running(struct rq =
*rq, int count)
 }
=20
 #ifdef CONFIG_SCHED_MM_CID
-
 /*
- * @cid_lock: Guarantee forward-progress of cid allocation.
- *
- * Concurrency ID allocation within a bitmap is mostly lock-free. The cid_lo=
ck
- * is only used when contention is detected by the lock-free allocation so
- * forward progress can be guaranteed.
- */
-DEFINE_RAW_SPINLOCK(cid_lock);
-
-/*
- * @use_cid_lock: Select cid allocation behavior: lock-free vs spinlock.
- *
- * When @use_cid_lock is 0, the cid allocation is lock-free. When contention=
 is
- * detected, it is set to 1 to ensure that all newly coming allocations are
- * serialized by @cid_lock until the allocation which detected contention
- * completes and sets @use_cid_lock back to 0. This guarantees forward progr=
ess
- * of a cid allocation.
- */
-int use_cid_lock;
-
-/*
- * mm_cid remote-clear implements a lock-free algorithm to clear per-mm/cpu =
cid
- * concurrently with respect to the execution of the source runqueue context
- * switch.
- *
- * There is one basic properties we want to guarantee here:
- *
- * (1) Remote-clear should _never_ mark a per-cpu cid UNSET when it is activ=
ely
- * used by a task. That would lead to concurrent allocation of the cid and
- * userspace corruption.
- *
- * Provide this guarantee by introducing a Dekker memory ordering to guarant=
ee
- * that a pair of loads observe at least one of a pair of stores, which can =
be
- * shown as:
- *
- *      X =3D Y =3D 0
- *
- *      w[X]=3D1          w[Y]=3D1
- *      MB              MB
- *      r[Y]=3Dy          r[X]=3Dx
- *
- * Which guarantees that x=3D=3D0 && y=3D=3D0 is impossible. But rather than=
 using
- * values 0 and 1, this algorithm cares about specific state transitions of =
the
- * runqueue current task (as updated by the scheduler context switch), and t=
he
- * per-mm/cpu cid value.
- *
- * Let's introduce task (Y) which has task->mm =3D=3D mm and task (N) which =
has
- * task->mm !=3D mm for the rest of the discussion. There are two scheduler =
state
- * transitions on context switch we care about:
- *
- * (TSA) Store to rq->curr with transition from (N) to (Y)
- *
- * (TSB) Store to rq->curr with transition from (Y) to (N)
- *
- * On the remote-clear side, there is one transition we care about:
- *
- * (TMA) cmpxchg to *pcpu_cid to set the LAZY flag
- *
- * There is also a transition to UNSET state which can be performed from all
- * sides (scheduler, remote-clear). It is always performed with a cmpxchg wh=
ich
- * guarantees that only a single thread will succeed:
- *
- * (TMB) cmpxchg to *pcpu_cid to mark UNSET
- *
- * Just to be clear, what we do _not_ want to happen is a transition to UNSET
- * when a thread is actively using the cid (property (1)).
- *
- * Let's looks at the relevant combinations of TSA/TSB, and TMA transitions.
- *
- * Scenario A) (TSA)+(TMA) (from next task perspective)
- *
- * CPU0                                      CPU1
- *
- * Context switch CS-1                       Remote-clear
- *   - store to rq->curr: (N)->(Y) (TSA)     - cmpxchg to *pcpu_id to LAZY (=
TMA)
- *                                             (implied barrier after cmpxch=
g)
- *   - switch_mm_cid()
- *     - memory barrier (see switch_mm_cid()
- *       comment explaining how this barrier
- *       is combined with other scheduler
- *       barriers)
- *     - mm_cid_get (next)
- *       - READ_ONCE(*pcpu_cid)              - rcu_dereference(src_rq->curr)
- *
- * This Dekker ensures that either task (Y) is observed by the
- * rcu_dereference() or the LAZY flag is observed by READ_ONCE(), or both are
- * observed.
- *
- * If task (Y) store is observed by rcu_dereference(), it means that there is
- * still an active task on the cpu. Remote-clear will therefore not transiti=
on
- * to UNSET, which fulfills property (1).
- *
- * If task (Y) is not observed, but the lazy flag is observed by READ_ONCE(),
- * it will move its state to UNSET, which clears the percpu cid perhaps
- * uselessly (which is not an issue for correctness). Because task (Y) is not
- * observed, CPU1 can move ahead to set the state to UNSET. Because moving
- * state to UNSET is done with a cmpxchg expecting that the old state has the
- * LAZY flag set, only one thread will successfully UNSET.
- *
- * If both states (LAZY flag and task (Y)) are observed, the thread on CPU0
- * will observe the LAZY flag and transition to UNSET (perhaps uselessly), a=
nd
- * CPU1 will observe task (Y) and do nothing more, which is fine.
- *
- * What we are effectively preventing with this Dekker is a scenario where
- * neither LAZY flag nor store (Y) are observed, which would fail property (=
1)
- * because this would UNSET a cid which is actively used.
+ * When a task exits, the MM CID held by the task is not longer required as
+ * the task cannot return to user space.
  */
-
-void sched_mm_cid_migrate_from(struct task_struct *t)
-{
-	t->migrate_from_cpu =3D task_cpu(t);
-}
-
-static
-int __sched_mm_cid_migrate_from_fetch_cid(struct rq *src_rq,
-					  struct task_struct *t,
-					  struct mm_cid *src_pcpu_cid)
-{
-	struct mm_struct *mm =3D t->mm;
-	struct task_struct *src_task;
-	int src_cid, last_mm_cid;
-
-	if (!mm)
-		return -1;
-
-	last_mm_cid =3D t->last_mm_cid;
-	/*
-	 * If the migrated task has no last cid, or if the current
-	 * task on src rq uses the cid, it means the source cid does not need
-	 * to be moved to the destination cpu.
-	 */
-	if (last_mm_cid =3D=3D -1)
-		return -1;
-	src_cid =3D READ_ONCE(src_pcpu_cid->cid);
-	if (!mm_cid_is_valid(src_cid) || last_mm_cid !=3D src_cid)
-		return -1;
-
-	/*
-	 * If we observe an active task using the mm on this rq, it means we
-	 * are not the last task to be migrated from this cpu for this mm, so
-	 * there is no need to move src_cid to the destination cpu.
-	 */
-	guard(rcu)();
-	src_task =3D rcu_dereference(src_rq->curr);
-	if (READ_ONCE(src_task->mm_cid_active) && src_task->mm =3D=3D mm) {
-		t->last_mm_cid =3D -1;
-		return -1;
-	}
-
-	return src_cid;
-}
-
-static
-int __sched_mm_cid_migrate_from_try_steal_cid(struct rq *src_rq,
-					      struct task_struct *t,
-					      struct mm_cid *src_pcpu_cid,
-					      int src_cid)
-{
-	struct task_struct *src_task;
-	struct mm_struct *mm =3D t->mm;
-	int lazy_cid;
-
-	if (src_cid =3D=3D -1)
-		return -1;
-
-	/*
-	 * Attempt to clear the source cpu cid to move it to the destination
-	 * cpu.
-	 */
-	lazy_cid =3D mm_cid_set_lazy_put(src_cid);
-	if (!try_cmpxchg(&src_pcpu_cid->cid, &src_cid, lazy_cid))
-		return -1;
-
-	/*
-	 * The implicit barrier after cmpxchg per-mm/cpu cid before loading
-	 * rq->curr->mm matches the scheduler barrier in context_switch()
-	 * between store to rq->curr and load of prev and next task's
-	 * per-mm/cpu cid.
-	 *
-	 * The implicit barrier after cmpxchg per-mm/cpu cid before loading
-	 * rq->curr->mm_cid_active matches the barrier in
-	 * sched_mm_cid_exit_signals(), sched_mm_cid_before_execve(), and
-	 * sched_mm_cid_after_execve() between store to t->mm_cid_active and
-	 * load of per-mm/cpu cid.
-	 */
-
-	/*
-	 * If we observe an active task using the mm on this rq after setting
-	 * the lazy-put flag, this task will be responsible for transitioning
-	 * from lazy-put flag set to MM_CID_UNSET.
-	 */
-	scoped_guard (rcu) {
-		src_task =3D rcu_dereference(src_rq->curr);
-		if (READ_ONCE(src_task->mm_cid_active) && src_task->mm =3D=3D mm) {
-			/*
-			 * We observed an active task for this mm, there is therefore
-			 * no point in moving this cid to the destination cpu.
-			 */
-			t->last_mm_cid =3D -1;
-			return -1;
-		}
-	}
-
-	/*
-	 * The src_cid is unused, so it can be unset.
-	 */
-	if (!try_cmpxchg(&src_pcpu_cid->cid, &lazy_cid, MM_CID_UNSET))
-		return -1;
-	WRITE_ONCE(src_pcpu_cid->recent_cid, MM_CID_UNSET);
-	return src_cid;
-}
-
-/*
- * Migration to dst cpu. Called with dst_rq lock held.
- * Interrupts are disabled, which keeps the window of cid ownership without =
the
- * source rq lock held small.
- */
-void sched_mm_cid_migrate_to(struct rq *dst_rq, struct task_struct *t)
-{
-	struct mm_cid *src_pcpu_cid, *dst_pcpu_cid;
-	struct mm_struct *mm =3D t->mm;
-	int src_cid, src_cpu;
-	bool dst_cid_is_set;
-	struct rq *src_rq;
-
-	lockdep_assert_rq_held(dst_rq);
-
-	if (!mm)
-		return;
-	src_cpu =3D t->migrate_from_cpu;
-	if (src_cpu =3D=3D -1) {
-		t->last_mm_cid =3D -1;
-		return;
-	}
-	/*
-	 * Move the src cid if the dst cid is unset. This keeps id
-	 * allocation closest to 0 in cases where few threads migrate around
-	 * many CPUs.
-	 *
-	 * If destination cid or recent cid is already set, we may have
-	 * to just clear the src cid to ensure compactness in frequent
-	 * migrations scenarios.
-	 *
-	 * It is not useful to clear the src cid when the number of threads is
-	 * greater or equal to the number of allowed CPUs, because user-space
-	 * can expect that the number of allowed cids can reach the number of
-	 * allowed CPUs.
-	 */
-	dst_pcpu_cid =3D per_cpu_ptr(mm->pcpu_cid, cpu_of(dst_rq));
-	dst_cid_is_set =3D !mm_cid_is_unset(READ_ONCE(dst_pcpu_cid->cid)) ||
-			 !mm_cid_is_unset(READ_ONCE(dst_pcpu_cid->recent_cid));
-	if (dst_cid_is_set && atomic_read(&mm->mm_users) >=3D READ_ONCE(mm->nr_cpus=
_allowed))
-		return;
-	src_pcpu_cid =3D per_cpu_ptr(mm->pcpu_cid, src_cpu);
-	src_rq =3D cpu_rq(src_cpu);
-	src_cid =3D __sched_mm_cid_migrate_from_fetch_cid(src_rq, t, src_pcpu_cid);
-	if (src_cid =3D=3D -1)
-		return;
-	src_cid =3D __sched_mm_cid_migrate_from_try_steal_cid(src_rq, t, src_pcpu_c=
id,
-							    src_cid);
-	if (src_cid =3D=3D -1)
-		return;
-	if (dst_cid_is_set) {
-		__mm_cid_put(mm, src_cid);
-		return;
-	}
-	/* Move src_cid to dst cpu. */
-	mm_cid_snapshot_time(dst_rq, mm);
-	WRITE_ONCE(dst_pcpu_cid->cid, src_cid);
-	WRITE_ONCE(dst_pcpu_cid->recent_cid, src_cid);
-}
-
-static void sched_mm_cid_remote_clear(struct mm_struct *mm, struct mm_cid *p=
cpu_cid,
-				      int cpu)
-{
-	struct rq *rq =3D cpu_rq(cpu);
-	struct task_struct *t;
-	int cid, lazy_cid;
-
-	cid =3D READ_ONCE(pcpu_cid->cid);
-	if (!mm_cid_is_valid(cid))
-		return;
-
-	/*
-	 * Clear the cpu cid if it is set to keep cid allocation compact.  If
-	 * there happens to be other tasks left on the source cpu using this
-	 * mm, the next task using this mm will reallocate its cid on context
-	 * switch.
-	 */
-	lazy_cid =3D mm_cid_set_lazy_put(cid);
-	if (!try_cmpxchg(&pcpu_cid->cid, &cid, lazy_cid))
-		return;
-
-	/*
-	 * The implicit barrier after cmpxchg per-mm/cpu cid before loading
-	 * rq->curr->mm matches the scheduler barrier in context_switch()
-	 * between store to rq->curr and load of prev and next task's
-	 * per-mm/cpu cid.
-	 *
-	 * The implicit barrier after cmpxchg per-mm/cpu cid before loading
-	 * rq->curr->mm_cid_active matches the barrier in
-	 * sched_mm_cid_exit_signals(), sched_mm_cid_before_execve(), and
-	 * sched_mm_cid_after_execve() between store to t->mm_cid_active and
-	 * load of per-mm/cpu cid.
-	 */
-
-	/*
-	 * If we observe an active task using the mm on this rq after setting
-	 * the lazy-put flag, that task will be responsible for transitioning
-	 * from lazy-put flag set to MM_CID_UNSET.
-	 */
-	scoped_guard (rcu) {
-		t =3D rcu_dereference(rq->curr);
-		if (READ_ONCE(t->mm_cid_active) && t->mm =3D=3D mm)
-			return;
-	}
-
-	/*
-	 * The cid is unused, so it can be unset.
-	 * Disable interrupts to keep the window of cid ownership without rq
-	 * lock small.
-	 */
-	scoped_guard (irqsave) {
-		if (try_cmpxchg(&pcpu_cid->cid, &lazy_cid, MM_CID_UNSET))
-			__mm_cid_put(mm, cid);
-	}
-}
-
-static void sched_mm_cid_remote_clear_old(struct mm_struct *mm, int cpu)
-{
-	struct rq *rq =3D cpu_rq(cpu);
-	struct mm_cid *pcpu_cid;
-	struct task_struct *curr;
-	u64 rq_clock;
-
-	/*
-	 * rq->clock load is racy on 32-bit but one spurious clear once in a
-	 * while is irrelevant.
-	 */
-	rq_clock =3D READ_ONCE(rq->clock);
-	pcpu_cid =3D per_cpu_ptr(mm->pcpu_cid, cpu);
-
-	/*
-	 * In order to take care of infrequently scheduled tasks, bump the time
-	 * snapshot associated with this cid if an active task using the mm is
-	 * observed on this rq.
-	 */
-	scoped_guard (rcu) {
-		curr =3D rcu_dereference(rq->curr);
-		if (READ_ONCE(curr->mm_cid_active) && curr->mm =3D=3D mm) {
-			WRITE_ONCE(pcpu_cid->time, rq_clock);
-			return;
-		}
-	}
-
-	if (rq_clock < pcpu_cid->time + SCHED_MM_CID_PERIOD_NS)
-		return;
-	sched_mm_cid_remote_clear(mm, pcpu_cid, cpu);
-}
-
-static void sched_mm_cid_remote_clear_weight(struct mm_struct *mm, int cpu,
-					     int weight)
-{
-	struct mm_cid *pcpu_cid;
-	int cid;
-
-	pcpu_cid =3D per_cpu_ptr(mm->pcpu_cid, cpu);
-	cid =3D READ_ONCE(pcpu_cid->cid);
-	if (!mm_cid_is_valid(cid) || cid < weight)
-		return;
-	sched_mm_cid_remote_clear(mm, pcpu_cid, cpu);
-}
-
-static void task_mm_cid_work(struct callback_head *work)
-{
-	unsigned long now =3D jiffies, old_scan, next_scan;
-	struct task_struct *t =3D current;
-	struct cpumask *cidmask;
-	struct mm_struct *mm;
-	int weight, cpu;
-
-	WARN_ON_ONCE(t !=3D container_of(work, struct task_struct, cid_work));
-
-	work->next =3D work;	/* Prevent double-add */
-	if (t->flags & PF_EXITING)
-		return;
-	mm =3D t->mm;
-	if (!mm)
-		return;
-	old_scan =3D READ_ONCE(mm->mm_cid_next_scan);
-	next_scan =3D now + msecs_to_jiffies(MM_CID_SCAN_DELAY);
-	if (!old_scan) {
-		unsigned long res;
-
-		res =3D cmpxchg(&mm->mm_cid_next_scan, old_scan, next_scan);
-		if (res !=3D old_scan)
-			old_scan =3D res;
-		else
-			old_scan =3D next_scan;
-	}
-	if (time_before(now, old_scan))
-		return;
-	if (!try_cmpxchg(&mm->mm_cid_next_scan, &old_scan, next_scan))
-		return;
-	cidmask =3D mm_cidmask(mm);
-	/* Clear cids that were not recently used. */
-	for_each_possible_cpu(cpu)
-		sched_mm_cid_remote_clear_old(mm, cpu);
-	weight =3D cpumask_weight(cidmask);
-	/*
-	 * Clear cids that are greater or equal to the cidmask weight to
-	 * recompact it.
-	 */
-	for_each_possible_cpu(cpu)
-		sched_mm_cid_remote_clear_weight(mm, cpu, weight);
-}
-
-void init_sched_mm_cid(struct task_struct *t)
-{
-	struct mm_struct *mm =3D t->mm;
-	int mm_users =3D 0;
-
-	if (mm) {
-		mm_users =3D atomic_read(&mm->mm_users);
-		if (mm_users =3D=3D 1)
-			mm->mm_cid_next_scan =3D jiffies + msecs_to_jiffies(MM_CID_SCAN_DELAY);
-	}
-	t->cid_work.next =3D &t->cid_work;	/* Protect against double add */
-	init_task_work(&t->cid_work, task_mm_cid_work);
-}
-
-void task_tick_mm_cid(struct rq *rq, struct task_struct *curr)
-{
-	struct callback_head *work =3D &curr->cid_work;
-	unsigned long now =3D jiffies;
-
-	if (!curr->mm || (curr->flags & (PF_EXITING | PF_KTHREAD)) ||
-	    work->next !=3D work)
-		return;
-	if (time_before(now, READ_ONCE(curr->mm->mm_cid_next_scan)))
-		return;
-
-	/* No page allocation under rq lock */
-	task_work_add(curr, work, TWA_RESUME);
-}
-
 void sched_mm_cid_exit_signals(struct task_struct *t)
 {
 	struct mm_struct *mm =3D t->mm;
-	struct rq *rq;
=20
-	if (!mm)
+	if (!mm || !t->mm_cid_active)
 		return;
=20
-	preempt_disable();
-	rq =3D this_rq();
-	guard(rq_lock_irqsave)(rq);
-	preempt_enable_no_resched();	/* holding spinlock */
-	WRITE_ONCE(t->mm_cid_active, 0);
-	/*
-	 * Store t->mm_cid_active before loading per-mm/cpu cid.
-	 * Matches barrier in sched_mm_cid_remote_clear_old().
-	 */
-	smp_mb();
-	mm_cid_put(mm);
-	t->last_mm_cid =3D t->mm_cid =3D -1;
+	guard(preempt)();
+	t->mm_cid_active =3D 0;
+	if (t->mm_cid !=3D MM_CID_UNSET) {
+		cpumask_clear_cpu(t->mm_cid, mm_cidmask(mm));
+		t->mm_cid =3D MM_CID_UNSET;
+	}
 }
=20
+/* Deactivate MM CID allocation across execve() */
 void sched_mm_cid_before_execve(struct task_struct *t)
 {
-	struct mm_struct *mm =3D t->mm;
-	struct rq *rq;
-
-	if (!mm)
-		return;
-
-	preempt_disable();
-	rq =3D this_rq();
-	guard(rq_lock_irqsave)(rq);
-	preempt_enable_no_resched();	/* holding spinlock */
-	WRITE_ONCE(t->mm_cid_active, 0);
-	/*
-	 * Store t->mm_cid_active before loading per-mm/cpu cid.
-	 * Matches barrier in sched_mm_cid_remote_clear_old().
-	 */
-	smp_mb();
-	mm_cid_put(mm);
-	t->last_mm_cid =3D t->mm_cid =3D -1;
+	sched_mm_cid_exit_signals(t);
 }
=20
+/* Reactivate MM CID after successful execve() */
 void sched_mm_cid_after_execve(struct task_struct *t)
 {
 	struct mm_struct *mm =3D t->mm;
-	struct rq *rq;
=20
 	if (!mm)
 		return;
=20
-	preempt_disable();
-	rq =3D this_rq();
-	scoped_guard (rq_lock_irqsave, rq) {
-		preempt_enable_no_resched();	/* holding spinlock */
-		WRITE_ONCE(t->mm_cid_active, 1);
-		/*
-		 * Store t->mm_cid_active before loading per-mm/cpu cid.
-		 * Matches barrier in sched_mm_cid_remote_clear_old().
-		 */
-		smp_mb();
-		t->last_mm_cid =3D t->mm_cid =3D mm_cid_get(rq, t, mm);
-	}
+	guard(preempt)();
+	t->mm_cid_active =3D 1;
+	mm_cid_select(t);
 }
=20
 void sched_mm_cid_fork(struct task_struct *t)
 {
-	WARN_ON_ONCE(!t->mm || t->mm_cid !=3D -1);
+	WARN_ON_ONCE(!t->mm || t->mm_cid !=3D MM_CID_UNSET);
 	t->mm_cid_active =3D 1;
 }
 #endif /* CONFIG_SCHED_MM_CID */
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 4838dda..bf227c2 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -3540,286 +3540,83 @@ extern void sched_dynamic_update(int mode);
 extern const char *preempt_modes[];
=20
 #ifdef CONFIG_SCHED_MM_CID
-
-#define SCHED_MM_CID_PERIOD_NS	(100ULL * 1000000)	/* 100ms */
-#define MM_CID_SCAN_DELAY	100			/* 100ms */
-
-extern raw_spinlock_t cid_lock;
-extern int use_cid_lock;
-
-extern void sched_mm_cid_migrate_from(struct task_struct *t);
-extern void sched_mm_cid_migrate_to(struct rq *dst_rq, struct task_struct *t=
);
-extern void task_tick_mm_cid(struct rq *rq, struct task_struct *curr);
-extern void init_sched_mm_cid(struct task_struct *t);
-
-static inline void __mm_cid_put(struct mm_struct *mm, int cid)
-{
-	if (cid < 0)
-		return;
-	cpumask_clear_cpu(cid, mm_cidmask(mm));
-}
-
-/*
- * The per-mm/cpu cid can have the MM_CID_LAZY_PUT flag set or transition to
- * the MM_CID_UNSET state without holding the rq lock, but the rq lock needs=
 to
- * be held to transition to other states.
- *
- * State transitions synchronized with cmpxchg or try_cmpxchg need to be
- * consistent across CPUs, which prevents use of this_cpu_cmpxchg.
- */
-static inline void mm_cid_put_lazy(struct task_struct *t)
+static inline void init_sched_mm_cid(struct task_struct *t)
 {
 	struct mm_struct *mm =3D t->mm;
-	struct mm_cid __percpu *pcpu_cid =3D mm->pcpu_cid;
-	int cid;
+	unsigned int max_cid;
=20
-	lockdep_assert_irqs_disabled();
-	cid =3D __this_cpu_read(pcpu_cid->cid);
-	if (!mm_cid_is_lazy_put(cid) ||
-	    !try_cmpxchg(&this_cpu_ptr(pcpu_cid)->cid, &cid, MM_CID_UNSET))
+	if (!mm)
 		return;
-	__mm_cid_put(mm, mm_cid_clear_lazy_put(cid));
-}
=20
-static inline int mm_cid_pcpu_unset(struct mm_struct *mm)
-{
-	struct mm_cid __percpu *pcpu_cid =3D mm->pcpu_cid;
-	int cid, res;
-
-	lockdep_assert_irqs_disabled();
-	cid =3D __this_cpu_read(pcpu_cid->cid);
-	for (;;) {
-		if (mm_cid_is_unset(cid))
-			return MM_CID_UNSET;
-		/*
-		 * Attempt transition from valid or lazy-put to unset.
-		 */
-		res =3D cmpxchg(&this_cpu_ptr(pcpu_cid)->cid, cid, MM_CID_UNSET);
-		if (res =3D=3D cid)
-			break;
-		cid =3D res;
-	}
-	return cid;
+	/* Preset last_mm_cid */
+	max_cid =3D min_t(int, READ_ONCE(mm->nr_cpus_allowed), atomic_read(&mm->mm_=
users));
+	t->last_mm_cid =3D max_cid - 1;
 }
=20
-static inline void mm_cid_put(struct mm_struct *mm)
+static inline bool __mm_cid_get(struct task_struct *t, unsigned int cid, uns=
igned int max_cids)
 {
-	int cid;
+	struct mm_struct *mm =3D t->mm;
=20
-	lockdep_assert_irqs_disabled();
-	cid =3D mm_cid_pcpu_unset(mm);
-	if (cid =3D=3D MM_CID_UNSET)
-		return;
-	__mm_cid_put(mm, mm_cid_clear_lazy_put(cid));
+	if (cid >=3D max_cids)
+		return false;
+	if (cpumask_test_and_set_cpu(cid, mm_cidmask(mm)))
+		return false;
+	t->mm_cid =3D t->last_mm_cid =3D cid;
+	__this_cpu_write(mm->pcpu_cid->cid, cid);
+	return true;
 }
=20
-static inline int __mm_cid_try_get(struct task_struct *t, struct mm_struct *=
mm)
+static inline bool mm_cid_get(struct task_struct *t)
 {
-	struct cpumask *cidmask =3D mm_cidmask(mm);
-	struct mm_cid __percpu *pcpu_cid =3D mm->pcpu_cid;
-	int cid, max_nr_cid, allowed_max_nr_cid;
+	struct mm_struct *mm =3D t->mm;
+	unsigned int max_cids;
=20
-	/*
-	 * After shrinking the number of threads or reducing the number
-	 * of allowed cpus, reduce the value of max_nr_cid so expansion
-	 * of cid allocation will preserve cache locality if the number
-	 * of threads or allowed cpus increase again.
-	 */
-	max_nr_cid =3D atomic_read(&mm->max_nr_cid);
-	while ((allowed_max_nr_cid =3D min_t(int, READ_ONCE(mm->nr_cpus_allowed),
-					   atomic_read(&mm->mm_users))),
-	       max_nr_cid > allowed_max_nr_cid) {
-		/* atomic_try_cmpxchg loads previous mm->max_nr_cid into max_nr_cid. */
-		if (atomic_try_cmpxchg(&mm->max_nr_cid, &max_nr_cid, allowed_max_nr_cid)) {
-			max_nr_cid =3D allowed_max_nr_cid;
-			break;
-		}
-	}
-	/* Try to re-use recent cid. This improves cache locality. */
-	cid =3D __this_cpu_read(pcpu_cid->recent_cid);
-	if (!mm_cid_is_unset(cid) && cid < max_nr_cid &&
-	    !cpumask_test_and_set_cpu(cid, cidmask))
-		return cid;
-	/*
-	 * Expand cid allocation if the maximum number of concurrency
-	 * IDs allocated (max_nr_cid) is below the number cpus allowed
-	 * and number of threads. Expanding cid allocation as much as
-	 * possible improves cache locality.
-	 */
-	cid =3D max_nr_cid;
-	while (cid < READ_ONCE(mm->nr_cpus_allowed) && cid < atomic_read(&mm->mm_us=
ers)) {
-		/* atomic_try_cmpxchg loads previous mm->max_nr_cid into cid. */
-		if (!atomic_try_cmpxchg(&mm->max_nr_cid, &cid, cid + 1))
-			continue;
-		if (!cpumask_test_and_set_cpu(cid, cidmask))
-			return cid;
-	}
-	/*
-	 * Find the first available concurrency id.
-	 * Retry finding first zero bit if the mask is temporarily
-	 * filled. This only happens during concurrent remote-clear
-	 * which owns a cid without holding a rq lock.
-	 */
-	for (;;) {
-		cid =3D cpumask_first_zero(cidmask);
-		if (cid < READ_ONCE(mm->nr_cpus_allowed))
-			break;
-		cpu_relax();
-	}
-	if (cpumask_test_and_set_cpu(cid, cidmask))
-		return -1;
+	max_cids =3D min_t(int, READ_ONCE(mm->nr_cpus_allowed), atomic_read(&mm->mm=
_users));
=20
-	return cid;
-}
+	/* Try to reuse the last CID of this task */
+	if (__mm_cid_get(t, t->last_mm_cid, max_cids))
+		return true;
=20
-/*
- * Save a snapshot of the current runqueue time of this cpu
- * with the per-cpu cid value, allowing to estimate how recently it was used.
- */
-static inline void mm_cid_snapshot_time(struct rq *rq, struct mm_struct *mm)
-{
-	struct mm_cid *pcpu_cid =3D per_cpu_ptr(mm->pcpu_cid, cpu_of(rq));
+	/* Try to reuse the last CID of this mm on this CPU */
+	if (__mm_cid_get(t, __this_cpu_read(mm->pcpu_cid->cid), max_cids))
+		return true;
=20
-	lockdep_assert_rq_held(rq);
-	WRITE_ONCE(pcpu_cid->time, rq->clock);
+	/* Try the first zero bit in the cidmask. */
+	return __mm_cid_get(t, cpumask_first_zero(mm_cidmask(mm)), max_cids);
 }
=20
-static inline int __mm_cid_get(struct rq *rq, struct task_struct *t,
-			       struct mm_struct *mm)
+static inline void mm_cid_select(struct task_struct *t)
 {
-	int cid;
-
 	/*
-	 * All allocations (even those using the cid_lock) are lock-free. If
-	 * use_cid_lock is set, hold the cid_lock to perform cid allocation to
-	 * guarantee forward progress.
+	 * mm_cid_get() can fail when the maximum CID, which is determined
+	 * by min(mm->nr_cpus_allowed, mm->mm_users) changes concurrently.
+	 * That's a transient failure as there cannot be more tasks
+	 * concurrently on a CPU (or about to be scheduled in) than that.
 	 */
-	if (!READ_ONCE(use_cid_lock)) {
-		cid =3D __mm_cid_try_get(t, mm);
-		if (cid >=3D 0)
-			goto end;
-		raw_spin_lock(&cid_lock);
-	} else {
-		raw_spin_lock(&cid_lock);
-		cid =3D __mm_cid_try_get(t, mm);
-		if (cid >=3D 0)
-			goto unlock;
-	}
-
-	/*
-	 * cid concurrently allocated. Retry while forcing following
-	 * allocations to use the cid_lock to ensure forward progress.
-	 */
-	WRITE_ONCE(use_cid_lock, 1);
-	/*
-	 * Set use_cid_lock before allocation. Only care about program order
-	 * because this is only required for forward progress.
-	 */
-	barrier();
-	/*
-	 * Retry until it succeeds. It is guaranteed to eventually succeed once
-	 * all newcoming allocations observe the use_cid_lock flag set.
-	 */
-	do {
-		cid =3D __mm_cid_try_get(t, mm);
-		cpu_relax();
-	} while (cid < 0);
-	/*
-	 * Allocate before clearing use_cid_lock. Only care about
-	 * program order because this is for forward progress.
-	 */
-	barrier();
-	WRITE_ONCE(use_cid_lock, 0);
-unlock:
-	raw_spin_unlock(&cid_lock);
-end:
-	mm_cid_snapshot_time(rq, mm);
-
-	return cid;
-}
-
-static inline int mm_cid_get(struct rq *rq, struct task_struct *t,
-			     struct mm_struct *mm)
-{
-	struct mm_cid __percpu *pcpu_cid =3D mm->pcpu_cid;
-	int cid;
-
-	lockdep_assert_rq_held(rq);
-	cid =3D __this_cpu_read(pcpu_cid->cid);
-	if (mm_cid_is_valid(cid)) {
-		mm_cid_snapshot_time(rq, mm);
-		return cid;
-	}
-	if (mm_cid_is_lazy_put(cid)) {
-		if (try_cmpxchg(&this_cpu_ptr(pcpu_cid)->cid, &cid, MM_CID_UNSET))
-			__mm_cid_put(mm, mm_cid_clear_lazy_put(cid));
+	for (;;) {
+		if (mm_cid_get(t))
+			break;
 	}
-	cid =3D __mm_cid_get(rq, t, mm);
-	__this_cpu_write(pcpu_cid->cid, cid);
-	__this_cpu_write(pcpu_cid->recent_cid, cid);
-
-	return cid;
 }
=20
-static inline void switch_mm_cid(struct rq *rq,
-				 struct task_struct *prev,
-				 struct task_struct *next)
+static inline void switch_mm_cid(struct task_struct *prev, struct task_struc=
t *next)
 {
-	/*
-	 * Provide a memory barrier between rq->curr store and load of
-	 * {prev,next}->mm->pcpu_cid[cpu] on rq->curr->mm transition.
-	 *
-	 * Should be adapted if context_switch() is modified.
-	 */
-	if (!next->mm) {                                // to kernel
-		/*
-		 * user -> kernel transition does not guarantee a barrier, but
-		 * we can use the fact that it performs an atomic operation in
-		 * mmgrab().
-		 */
-		if (prev->mm)                           // from user
-			smp_mb__after_mmgrab();
-		/*
-		 * kernel -> kernel transition does not change rq->curr->mm
-		 * state. It stays NULL.
-		 */
-	} else {                                        // to user
-		/*
-		 * kernel -> user transition does not provide a barrier
-		 * between rq->curr store and load of {prev,next}->mm->pcpu_cid[cpu].
-		 * Provide it here.
-		 */
-		if (!prev->mm) {                        // from kernel
-			smp_mb();
-		} else {				// from user
-			/*
-			 * user->user transition relies on an implicit
-			 * memory barrier in switch_mm() when
-			 * current->mm changes. If the architecture
-			 * switch_mm() does not have an implicit memory
-			 * barrier, it is emitted here.  If current->mm
-			 * is unchanged, no barrier is needed.
-			 */
-			smp_mb__after_switch_mm();
-		}
-	}
 	if (prev->mm_cid_active) {
-		mm_cid_snapshot_time(rq, prev->mm);
-		mm_cid_put_lazy(prev);
-		prev->mm_cid =3D -1;
+		if (prev->mm_cid !=3D MM_CID_UNSET)
+			cpumask_clear_cpu(prev->mm_cid, mm_cidmask(prev->mm));
+		prev->mm_cid =3D MM_CID_UNSET;
 	}
+
 	if (next->mm_cid_active) {
-		next->last_mm_cid =3D next->mm_cid =3D mm_cid_get(rq, next, next->mm);
+		mm_cid_select(next);
 		rseq_sched_set_task_mm_cid(next, next->mm_cid);
 	}
 }
=20
 #else /* !CONFIG_SCHED_MM_CID: */
-static inline void switch_mm_cid(struct rq *rq, struct task_struct *prev, st=
ruct task_struct *next) { }
-static inline void sched_mm_cid_migrate_from(struct task_struct *t) { }
-static inline void sched_mm_cid_migrate_to(struct rq *dst_rq, struct task_st=
ruct *t) { }
-static inline void task_tick_mm_cid(struct rq *rq, struct task_struct *curr)=
 { }
 static inline void init_sched_mm_cid(struct task_struct *t) { }
+static inline void mm_cid_select(struct task_struct *t) { }
+static inline void switch_mm_cid(struct task_struct *prev, struct task_struc=
t *next) { }
 #endif /* !CONFIG_SCHED_MM_CID */
=20
 extern u64 avg_vruntime(struct cfs_rq *cfs_rq);

