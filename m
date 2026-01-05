Return-Path: <linux-tip-commits+bounces-7786-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 56705CF488D
	for <lists+linux-tip-commits@lfdr.de>; Mon, 05 Jan 2026 16:56:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5110A304E5DE
	for <lists+linux-tip-commits@lfdr.de>; Mon,  5 Jan 2026 15:54:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD78533A9F1;
	Mon,  5 Jan 2026 15:54:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="zmV/IbkF";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="We2HX5G1"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCC21334C09;
	Mon,  5 Jan 2026 15:54:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767628456; cv=none; b=Zv7RuQqx2lio+WserdUTHEqJLIkNuYFdf86QBAzTOPRuqwrNwW/nvRJmM6GR/my4qP5Ei1h23ny8+5LwaZxzeWQcud97IMlCMvq2e1LaX65Q+A9+C5XvkAk/sniHYiNgLn/xCFY8drN4pmCDMJCUlQTLspqMjaI6N7jKvnkDMks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767628456; c=relaxed/simple;
	bh=63Q9bi3jXR4qr5EIy9adDy6XCuZrEuBNIOzWA+Peqls=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=jG47uMDlEFxjni6egbkmTKNFNcoNO9eL73cQxcVv2ny+vtyZiSTZtbMPCmrmW8Tqtaa46FAljjWddH7TCDxUWjSWGNzkZWzG+XZZBhLPNinwdXIlcqBADqVTE57H5mS2c3aeBHx8IPsh+KUPdpI5OIwr07HpebG/HCPy+MEES/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=zmV/IbkF; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=We2HX5G1; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 05 Jan 2026 15:53:52 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1767628451;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EvoGw1Gc9AfhkMAqr2sQFMiTjT9/baKuXrJtQC5hOlo=;
	b=zmV/IbkFN7mnNK0q6tsASs7XaGyFSNPJigdOllHgyKuSBoglNOQLvH5toYGiNHYsuoC2Bo
	dP82s/bRNFY/NeWJXUlu+wR1l+riOaY7FRkdEYpwPsk3mOs1tMqRVUpDOR2qbGYgk5eotJ
	+ne9T779EJqPz6mofpDlTj0jqReqNbp628C7VxZ4OgP2i4s9Y9pCe9y7P8mAKga15mk//u
	/YNLXAJ8Uo7FiOC682Q+tbSxPT/igDKphKzkcsvOhe1CGwJ6lQOeL4rZwOZR+lAfkPFMQY
	DUK4XPlFF+a7oD9lCrWqbhbukZ2sxArGCVyp8NtkRHFj2mWf+kxdGniyv9bd5A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1767628451;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EvoGw1Gc9AfhkMAqr2sQFMiTjT9/baKuXrJtQC5hOlo=;
	b=We2HX5G1UnkC+OvKdEh1Q0IOWCvvWfplokUFFUG/10z1Tk4S1oDoPXm6IlE9eRHibOBzjs
	E5WR2sdetpylv2AQ==
From: "tip-bot2 for Marco Elver" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: locking/core] sched: Enable context analysis for core.c and fair.c
Cc: Marco Elver <elver@google.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20251219154418.3592607-37-elver@google.com>
References: <20251219154418.3592607-37-elver@google.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176762843252.510.7832235244239147164.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     04e49d926f438134b6453505aa206e70f8cf4cb1
Gitweb:        https://git.kernel.org/tip/04e49d926f438134b6453505aa206e70f8c=
f4cb1
Author:        Marco Elver <elver@google.com>
AuthorDate:    Fri, 19 Dec 2025 16:40:25 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 05 Jan 2026 16:43:36 +01:00

sched: Enable context analysis for core.c and fair.c

This demonstrates a larger conversion to use Clang's context
analysis. The benefit is additional static checking of locking rules,
along with better documentation.

Notably, kernel/sched contains sufficiently complex synchronization
patterns, and application to core.c & fair.c demonstrates that the
latest Clang version has become powerful enough to start applying this
to more complex subsystems (with some modest annotations and changes).

Signed-off-by: Marco Elver <elver@google.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://patch.msgid.link/20251219154418.3592607-37-elver@google.com
---
 include/linux/sched.h                    |   6 +-
 include/linux/sched/signal.h             |   4 +-
 include/linux/sched/task.h               |   6 +-
 include/linux/sched/wake_q.h             |   3 +-
 kernel/sched/Makefile                    |   3 +-
 kernel/sched/core.c                      |  89 +++++++++++-----
 kernel/sched/fair.c                      |   7 +-
 kernel/sched/sched.h                     | 126 +++++++++++++++-------
 scripts/context-analysis-suppression.txt |   1 +-
 9 files changed, 177 insertions(+), 68 deletions(-)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index d395f28..c402264 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -2094,9 +2094,9 @@ static inline int _cond_resched(void)
 	_cond_resched();			\
 })
=20
-extern int __cond_resched_lock(spinlock_t *lock);
-extern int __cond_resched_rwlock_read(rwlock_t *lock);
-extern int __cond_resched_rwlock_write(rwlock_t *lock);
+extern int __cond_resched_lock(spinlock_t *lock) __must_hold(lock);
+extern int __cond_resched_rwlock_read(rwlock_t *lock) __must_hold_shared(loc=
k);
+extern int __cond_resched_rwlock_write(rwlock_t *lock) __must_hold(lock);
=20
 #define MIGHT_RESCHED_RCU_SHIFT		8
 #define MIGHT_RESCHED_PREEMPT_MASK	((1U << MIGHT_RESCHED_RCU_SHIFT) - 1)
diff --git a/include/linux/sched/signal.h b/include/linux/sched/signal.h
index a63f65a..a22248a 100644
--- a/include/linux/sched/signal.h
+++ b/include/linux/sched/signal.h
@@ -738,10 +738,12 @@ static inline int thread_group_empty(struct task_struct=
 *p)
 		(thread_group_leader(p) && !thread_group_empty(p))
=20
 extern struct sighand_struct *lock_task_sighand(struct task_struct *task,
-						unsigned long *flags);
+						unsigned long *flags)
+	__acquires(&task->sighand->siglock);
=20
 static inline void unlock_task_sighand(struct task_struct *task,
 						unsigned long *flags)
+	__releases(&task->sighand->siglock)
 {
 	spin_unlock_irqrestore(&task->sighand->siglock, *flags);
 }
diff --git a/include/linux/sched/task.h b/include/linux/sched/task.h
index 525aa2a..41ed884 100644
--- a/include/linux/sched/task.h
+++ b/include/linux/sched/task.h
@@ -214,15 +214,19 @@ static inline struct vm_struct *task_stack_vm_area(cons=
t struct task_struct *t)
  * write_lock_irq(&tasklist_lock), neither inside nor outside.
  */
 static inline void task_lock(struct task_struct *p)
+	__acquires(&p->alloc_lock)
 {
 	spin_lock(&p->alloc_lock);
 }
=20
 static inline void task_unlock(struct task_struct *p)
+	__releases(&p->alloc_lock)
 {
 	spin_unlock(&p->alloc_lock);
 }
=20
-DEFINE_GUARD(task_lock, struct task_struct *, task_lock(_T), task_unlock(_T))
+DEFINE_LOCK_GUARD_1(task_lock, struct task_struct, task_lock(_T->lock), task=
_unlock(_T->lock))
+DECLARE_LOCK_GUARD_1_ATTRS(task_lock, __acquires(&_T->alloc_lock), __release=
s(&(*(struct task_struct **)_T)->alloc_lock))
+#define class_task_lock_constructor(_T) WITH_LOCK_GUARD_1_ATTRS(task_lock, _=
T)
=20
 #endif /* _LINUX_SCHED_TASK_H */
diff --git a/include/linux/sched/wake_q.h b/include/linux/sched/wake_q.h
index 0f28b46..765bbc3 100644
--- a/include/linux/sched/wake_q.h
+++ b/include/linux/sched/wake_q.h
@@ -66,6 +66,7 @@ extern void wake_up_q(struct wake_q_head *head);
 /* Spin unlock helpers to unlock and call wake_up_q with preempt disabled */
 static inline
 void raw_spin_unlock_wake(raw_spinlock_t *lock, struct wake_q_head *wake_q)
+	__releases(lock)
 {
 	guard(preempt)();
 	raw_spin_unlock(lock);
@@ -77,6 +78,7 @@ void raw_spin_unlock_wake(raw_spinlock_t *lock, struct wake=
_q_head *wake_q)
=20
 static inline
 void raw_spin_unlock_irq_wake(raw_spinlock_t *lock, struct wake_q_head *wake=
_q)
+	__releases(lock)
 {
 	guard(preempt)();
 	raw_spin_unlock_irq(lock);
@@ -89,6 +91,7 @@ void raw_spin_unlock_irq_wake(raw_spinlock_t *lock, struct =
wake_q_head *wake_q)
 static inline
 void raw_spin_unlock_irqrestore_wake(raw_spinlock_t *lock, unsigned long fla=
gs,
 				     struct wake_q_head *wake_q)
+	__releases(lock)
 {
 	guard(preempt)();
 	raw_spin_unlock_irqrestore(lock, flags);
diff --git a/kernel/sched/Makefile b/kernel/sched/Makefile
index 8ae8637..b1f1a36 100644
--- a/kernel/sched/Makefile
+++ b/kernel/sched/Makefile
@@ -1,5 +1,8 @@
 # SPDX-License-Identifier: GPL-2.0
=20
+CONTEXT_ANALYSIS_core.o :=3D y
+CONTEXT_ANALYSIS_fair.o :=3D y
+
 # The compilers are complaining about unused variables inside an if(0) scope
 # block. This is daft, shut them up.
 ccflags-y +=3D $(call cc-disable-warning, unused-but-set-variable)
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 41ba0be..ae543ee 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -396,6 +396,8 @@ static atomic_t sched_core_count;
 static struct cpumask sched_core_mask;
=20
 static void sched_core_lock(int cpu, unsigned long *flags)
+	__context_unsafe(/* acquires multiple */)
+	__acquires(&runqueues.__lock) /* overapproximation */
 {
 	const struct cpumask *smt_mask =3D cpu_smt_mask(cpu);
 	int t, i =3D 0;
@@ -406,6 +408,8 @@ static void sched_core_lock(int cpu, unsigned long *flags)
 }
=20
 static void sched_core_unlock(int cpu, unsigned long *flags)
+	__context_unsafe(/* releases multiple */)
+	__releases(&runqueues.__lock) /* overapproximation */
 {
 	const struct cpumask *smt_mask =3D cpu_smt_mask(cpu);
 	int t;
@@ -630,6 +634,7 @@ EXPORT_SYMBOL(__trace_set_current_state);
  */
=20
 void raw_spin_rq_lock_nested(struct rq *rq, int subclass)
+	__context_unsafe()
 {
 	raw_spinlock_t *lock;
=20
@@ -655,6 +660,7 @@ void raw_spin_rq_lock_nested(struct rq *rq, int subclass)
 }
=20
 bool raw_spin_rq_trylock(struct rq *rq)
+	__context_unsafe()
 {
 	raw_spinlock_t *lock;
 	bool ret;
@@ -696,15 +702,16 @@ void double_rq_lock(struct rq *rq1, struct rq *rq2)
 	raw_spin_rq_lock(rq1);
 	if (__rq_lockp(rq1) !=3D __rq_lockp(rq2))
 		raw_spin_rq_lock_nested(rq2, SINGLE_DEPTH_NESTING);
+	else
+		__acquire_ctx_lock(__rq_lockp(rq2)); /* fake acquire */
=20
 	double_rq_clock_clear_update(rq1, rq2);
 }
=20
 /*
- * __task_rq_lock - lock the rq @p resides on.
+ * ___task_rq_lock - lock the rq @p resides on.
  */
-struct rq *__task_rq_lock(struct task_struct *p, struct rq_flags *rf)
-	__acquires(rq->lock)
+struct rq *___task_rq_lock(struct task_struct *p, struct rq_flags *rf)
 {
 	struct rq *rq;
=20
@@ -727,9 +734,7 @@ struct rq *__task_rq_lock(struct task_struct *p, struct r=
q_flags *rf)
 /*
  * task_rq_lock - lock p->pi_lock and lock the rq @p resides on.
  */
-struct rq *task_rq_lock(struct task_struct *p, struct rq_flags *rf)
-	__acquires(p->pi_lock)
-	__acquires(rq->lock)
+struct rq *_task_rq_lock(struct task_struct *p, struct rq_flags *rf)
 {
 	struct rq *rq;
=20
@@ -2431,6 +2436,7 @@ static inline bool is_cpu_allowed(struct task_struct *p=
, int cpu)
  */
 static struct rq *move_queued_task(struct rq *rq, struct rq_flags *rf,
 				   struct task_struct *p, int new_cpu)
+	__must_hold(__rq_lockp(rq))
 {
 	lockdep_assert_rq_held(rq);
=20
@@ -2477,6 +2483,7 @@ struct set_affinity_pending {
  */
 static struct rq *__migrate_task(struct rq *rq, struct rq_flags *rf,
 				 struct task_struct *p, int dest_cpu)
+	__must_hold(__rq_lockp(rq))
 {
 	/* Affinity changed (again). */
 	if (!is_cpu_allowed(p, dest_cpu))
@@ -2513,6 +2520,12 @@ static int migration_cpu_stop(void *data)
 	 */
 	flush_smp_call_function_queue();
=20
+	/*
+	 * We may change the underlying rq, but the locks held will
+	 * appropriately be "transferred" when switching.
+	 */
+	context_unsafe_alias(rq);
+
 	raw_spin_lock(&p->pi_lock);
 	rq_lock(rq, &rf);
=20
@@ -2624,6 +2637,8 @@ int push_cpu_stop(void *arg)
 	if (!lowest_rq)
 		goto out_unlock;
=20
+	lockdep_assert_rq_held(lowest_rq);
+
 	// XXX validate p is still the highest prio task
 	if (task_rq(p) =3D=3D rq) {
 		move_queued_task_locked(rq, lowest_rq, p);
@@ -2834,8 +2849,7 @@ void release_user_cpus_ptr(struct task_struct *p)
  */
 static int affine_move_task(struct rq *rq, struct task_struct *p, struct rq_=
flags *rf,
 			    int dest_cpu, unsigned int flags)
-	__releases(rq->lock)
-	__releases(p->pi_lock)
+	__releases(__rq_lockp(rq), &p->pi_lock)
 {
 	struct set_affinity_pending my_pending =3D { }, *pending =3D NULL;
 	bool stop_pending, complete =3D false;
@@ -2990,8 +3004,7 @@ static int __set_cpus_allowed_ptr_locked(struct task_st=
ruct *p,
 					 struct affinity_context *ctx,
 					 struct rq *rq,
 					 struct rq_flags *rf)
-	__releases(rq->lock)
-	__releases(p->pi_lock)
+	__releases(__rq_lockp(rq), &p->pi_lock)
 {
 	const struct cpumask *cpu_allowed_mask =3D task_cpu_possible_mask(p);
 	const struct cpumask *cpu_valid_mask =3D cpu_active_mask;
@@ -4273,29 +4286,30 @@ static bool __task_needs_rq_lock(struct task_struct *=
p)
  */
 int task_call_func(struct task_struct *p, task_call_f func, void *arg)
 {
-	struct rq *rq =3D NULL;
 	struct rq_flags rf;
 	int ret;
=20
 	raw_spin_lock_irqsave(&p->pi_lock, rf.flags);
=20
-	if (__task_needs_rq_lock(p))
-		rq =3D __task_rq_lock(p, &rf);
+	if (__task_needs_rq_lock(p)) {
+		struct rq *rq =3D __task_rq_lock(p, &rf);
=20
-	/*
-	 * At this point the task is pinned; either:
-	 *  - blocked and we're holding off wakeups	 (pi->lock)
-	 *  - woken, and we're holding off enqueue	 (rq->lock)
-	 *  - queued, and we're holding off schedule	 (rq->lock)
-	 *  - running, and we're holding off de-schedule (rq->lock)
-	 *
-	 * The called function (@func) can use: task_curr(), p->on_rq and
-	 * p->__state to differentiate between these states.
-	 */
-	ret =3D func(p, arg);
+		/*
+		 * At this point the task is pinned; either:
+		 *  - blocked and we're holding off wakeups	 (pi->lock)
+		 *  - woken, and we're holding off enqueue	 (rq->lock)
+		 *  - queued, and we're holding off schedule	 (rq->lock)
+		 *  - running, and we're holding off de-schedule (rq->lock)
+		 *
+		 * The called function (@func) can use: task_curr(), p->on_rq and
+		 * p->__state to differentiate between these states.
+		 */
+		ret =3D func(p, arg);
=20
-	if (rq)
 		__task_rq_unlock(rq, p, &rf);
+	} else {
+		ret =3D func(p, arg);
+	}
=20
 	raw_spin_unlock_irqrestore(&p->pi_lock, rf.flags);
 	return ret;
@@ -4968,6 +4982,8 @@ void balance_callbacks(struct rq *rq, struct balance_ca=
llback *head)
=20
 static inline void
 prepare_lock_switch(struct rq *rq, struct task_struct *next, struct rq_flags=
 *rf)
+	__releases(__rq_lockp(rq))
+	__acquires(__rq_lockp(this_rq()))
 {
 	/*
 	 * Since the runqueue lock will be released by the next
@@ -4981,9 +4997,15 @@ prepare_lock_switch(struct rq *rq, struct task_struct =
*next, struct rq_flags *rf
 	/* this is a valid case when another task releases the spinlock */
 	rq_lockp(rq)->owner =3D next;
 #endif
+	/*
+	 * Model the rq reference switcheroo.
+	 */
+	__release(__rq_lockp(rq));
+	__acquire(__rq_lockp(this_rq()));
 }
=20
 static inline void finish_lock_switch(struct rq *rq)
+	__releases(__rq_lockp(rq))
 {
 	/*
 	 * If we are tracking spinlock dependencies then we have to
@@ -5039,6 +5061,7 @@ static inline void kmap_local_sched_in(void)
 static inline void
 prepare_task_switch(struct rq *rq, struct task_struct *prev,
 		    struct task_struct *next)
+	__must_hold(__rq_lockp(rq))
 {
 	kcov_prepare_switch(prev);
 	sched_info_switch(rq, prev, next);
@@ -5069,7 +5092,7 @@ prepare_task_switch(struct rq *rq, struct task_struct *=
prev,
  * because prev may have moved to another CPU.
  */
 static struct rq *finish_task_switch(struct task_struct *prev)
-	__releases(rq->lock)
+	__releases(__rq_lockp(this_rq()))
 {
 	struct rq *rq =3D this_rq();
 	struct mm_struct *mm =3D rq->prev_mm;
@@ -5165,7 +5188,7 @@ static struct rq *finish_task_switch(struct task_struct=
 *prev)
  * @prev: the thread we just switched away from.
  */
 asmlinkage __visible void schedule_tail(struct task_struct *prev)
-	__releases(rq->lock)
+	__releases(__rq_lockp(this_rq()))
 {
 	/*
 	 * New tasks start with FORK_PREEMPT_COUNT, see there and
@@ -5197,6 +5220,7 @@ asmlinkage __visible void schedule_tail(struct task_str=
uct *prev)
 static __always_inline struct rq *
 context_switch(struct rq *rq, struct task_struct *prev,
 	       struct task_struct *next, struct rq_flags *rf)
+	__releases(__rq_lockp(rq))
 {
 	prepare_task_switch(rq, prev, next);
=20
@@ -5865,6 +5889,7 @@ static void prev_balance(struct rq *rq, struct task_str=
uct *prev,
  */
 static inline struct task_struct *
 __pick_next_task(struct rq *rq, struct task_struct *prev, struct rq_flags *r=
f)
+	__must_hold(__rq_lockp(rq))
 {
 	const struct sched_class *class;
 	struct task_struct *p;
@@ -5965,6 +5990,7 @@ static void queue_core_balance(struct rq *rq);
=20
 static struct task_struct *
 pick_next_task(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
+	__must_hold(__rq_lockp(rq))
 {
 	struct task_struct *next, *p, *max;
 	const struct cpumask *smt_mask;
@@ -6273,6 +6299,7 @@ static bool steal_cookie_task(int cpu, struct sched_dom=
ain *sd)
 }
=20
 static void sched_core_balance(struct rq *rq)
+	__must_hold(__rq_lockp(rq))
 {
 	struct sched_domain *sd;
 	int cpu =3D cpu_of(rq);
@@ -6418,6 +6445,7 @@ static inline void sched_core_cpu_dying(unsigned int cp=
u) {}
=20
 static struct task_struct *
 pick_next_task(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
+	__must_hold(__rq_lockp(rq))
 {
 	return __pick_next_task(rq, prev, rf);
 }
@@ -8043,6 +8071,12 @@ static int __balance_push_cpu_stop(void *arg)
 	int cpu;
=20
 	scoped_guard (raw_spinlock_irq, &p->pi_lock) {
+		/*
+		 * We may change the underlying rq, but the locks held will
+		 * appropriately be "transferred" when switching.
+		 */
+		context_unsafe_alias(rq);
+
 		cpu =3D select_fallback_rq(rq->cpu, p);
=20
 		rq_lock(rq, &rf);
@@ -8066,6 +8100,7 @@ static DEFINE_PER_CPU(struct cpu_stop_work, push_work);
  * effective when the hotplug motion is down.
  */
 static void balance_push(struct rq *rq)
+	__must_hold(__rq_lockp(rq))
 {
 	struct task_struct *push_task =3D rq->curr;
=20
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index da46c31..d0c929e 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -2860,6 +2860,7 @@ static int preferred_group_nid(struct task_struct *p, i=
nt nid)
 }
=20
 static void task_numa_placement(struct task_struct *p)
+	__context_unsafe(/* conditional locking */)
 {
 	int seq, nid, max_nid =3D NUMA_NO_NODE;
 	unsigned long max_faults =3D 0;
@@ -4781,7 +4782,8 @@ static inline unsigned long cfs_rq_load_avg(struct cfs_=
rq *cfs_rq)
 	return cfs_rq->avg.load_avg;
 }
=20
-static int sched_balance_newidle(struct rq *this_rq, struct rq_flags *rf);
+static int sched_balance_newidle(struct rq *this_rq, struct rq_flags *rf)
+	__must_hold(__rq_lockp(this_rq));
=20
 static inline unsigned long task_util(struct task_struct *p)
 {
@@ -6188,6 +6190,7 @@ next:
  * used to track this state.
  */
 static int do_sched_cfs_period_timer(struct cfs_bandwidth *cfs_b, int overru=
n, unsigned long flags)
+	__must_hold(&cfs_b->lock)
 {
 	int throttled;
=20
@@ -8919,6 +8922,7 @@ static void set_next_task_fair(struct rq *rq, struct ta=
sk_struct *p, bool first)
=20
 struct task_struct *
 pick_next_task_fair(struct rq *rq, struct task_struct *prev, struct rq_flags=
 *rf)
+	__must_hold(__rq_lockp(rq))
 {
 	struct sched_entity *se;
 	struct task_struct *p;
@@ -12858,6 +12862,7 @@ static inline void nohz_newidle_balance(struct rq *th=
is_rq) { }
  *   > 0 - success, new (fair) tasks present
  */
 static int sched_balance_newidle(struct rq *this_rq, struct rq_flags *rf)
+	__must_hold(__rq_lockp(this_rq))
 {
 	unsigned long next_balance =3D jiffies + HZ;
 	int this_cpu =3D this_rq->cpu;
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index d30cca6..25d2ff2 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -1358,8 +1358,13 @@ static inline u32 sched_rng(void)
 	return prandom_u32_state(this_cpu_ptr(&sched_rnd_state));
 }
=20
+static __always_inline struct rq *__this_rq(void)
+{
+	return this_cpu_ptr(&runqueues);
+}
+
 #define cpu_rq(cpu)		(&per_cpu(runqueues, (cpu)))
-#define this_rq()		this_cpu_ptr(&runqueues)
+#define this_rq()		__this_rq()
 #define task_rq(p)		cpu_rq(task_cpu(p))
 #define cpu_curr(cpu)		(cpu_rq(cpu)->curr)
 #define raw_rq()		raw_cpu_ptr(&runqueues)
@@ -1404,6 +1409,7 @@ static inline raw_spinlock_t *rq_lockp(struct rq *rq)
 }
=20
 static inline raw_spinlock_t *__rq_lockp(struct rq *rq)
+	__returns_ctx_lock(rq_lockp(rq)) /* alias them */
 {
 	if (rq->core_enabled)
 		return &rq->core->__lock;
@@ -1503,6 +1509,7 @@ static inline raw_spinlock_t *rq_lockp(struct rq *rq)
 }
=20
 static inline raw_spinlock_t *__rq_lockp(struct rq *rq)
+	__returns_ctx_lock(rq_lockp(rq)) /* alias them */
 {
 	return &rq->__lock;
 }
@@ -1545,32 +1552,42 @@ static inline bool rt_group_sched_enabled(void)
 #endif /* !CONFIG_RT_GROUP_SCHED */
=20
 static inline void lockdep_assert_rq_held(struct rq *rq)
+	__assumes_ctx_lock(__rq_lockp(rq))
 {
 	lockdep_assert_held(__rq_lockp(rq));
 }
=20
-extern void raw_spin_rq_lock_nested(struct rq *rq, int subclass);
-extern bool raw_spin_rq_trylock(struct rq *rq);
-extern void raw_spin_rq_unlock(struct rq *rq);
+extern void raw_spin_rq_lock_nested(struct rq *rq, int subclass)
+	__acquires(__rq_lockp(rq));
+
+extern bool raw_spin_rq_trylock(struct rq *rq)
+	__cond_acquires(true, __rq_lockp(rq));
+
+extern void raw_spin_rq_unlock(struct rq *rq)
+	__releases(__rq_lockp(rq));
=20
 static inline void raw_spin_rq_lock(struct rq *rq)
+	__acquires(__rq_lockp(rq))
 {
 	raw_spin_rq_lock_nested(rq, 0);
 }
=20
 static inline void raw_spin_rq_lock_irq(struct rq *rq)
+	__acquires(__rq_lockp(rq))
 {
 	local_irq_disable();
 	raw_spin_rq_lock(rq);
 }
=20
 static inline void raw_spin_rq_unlock_irq(struct rq *rq)
+	__releases(__rq_lockp(rq))
 {
 	raw_spin_rq_unlock(rq);
 	local_irq_enable();
 }
=20
 static inline unsigned long _raw_spin_rq_lock_irqsave(struct rq *rq)
+	__acquires(__rq_lockp(rq))
 {
 	unsigned long flags;
=20
@@ -1581,6 +1598,7 @@ static inline unsigned long _raw_spin_rq_lock_irqsave(s=
truct rq *rq)
 }
=20
 static inline void raw_spin_rq_unlock_irqrestore(struct rq *rq, unsigned lon=
g flags)
+	__releases(__rq_lockp(rq))
 {
 	raw_spin_rq_unlock(rq);
 	local_irq_restore(flags);
@@ -1829,18 +1847,16 @@ static inline void rq_repin_lock(struct rq *rq, struc=
t rq_flags *rf)
 	rq->clock_update_flags |=3D rf->clock_update_flags;
 }
=20
-extern
-struct rq *__task_rq_lock(struct task_struct *p, struct rq_flags *rf)
-	__acquires(rq->lock);
+#define __task_rq_lock(...) __acquire_ret(___task_rq_lock(__VA_ARGS__), __rq=
_lockp(__ret))
+extern struct rq *___task_rq_lock(struct task_struct *p, struct rq_flags *rf=
) __acquires_ret;
=20
-extern
-struct rq *task_rq_lock(struct task_struct *p, struct rq_flags *rf)
-	__acquires(p->pi_lock)
-	__acquires(rq->lock);
+#define task_rq_lock(...) __acquire_ret(_task_rq_lock(__VA_ARGS__), __rq_loc=
kp(__ret))
+extern struct rq *_task_rq_lock(struct task_struct *p, struct rq_flags *rf)
+	__acquires(&p->pi_lock) __acquires_ret;
=20
 static inline void
 __task_rq_unlock(struct rq *rq, struct task_struct *p, struct rq_flags *rf)
-	__releases(rq->lock)
+	__releases(__rq_lockp(rq))
 {
 	rq_unpin_lock(rq, rf);
 	raw_spin_rq_unlock(rq);
@@ -1848,8 +1864,7 @@ __task_rq_unlock(struct rq *rq, struct task_struct *p, =
struct rq_flags *rf)
=20
 static inline void
 task_rq_unlock(struct rq *rq, struct task_struct *p, struct rq_flags *rf)
-	__releases(rq->lock)
-	__releases(p->pi_lock)
+	__releases(__rq_lockp(rq), &p->pi_lock)
 {
 	__task_rq_unlock(rq, p, rf);
 	raw_spin_unlock_irqrestore(&p->pi_lock, rf->flags);
@@ -1859,6 +1874,8 @@ DEFINE_LOCK_GUARD_1(task_rq_lock, struct task_struct,
 		    _T->rq =3D task_rq_lock(_T->lock, &_T->rf),
 		    task_rq_unlock(_T->rq, _T->lock, &_T->rf),
 		    struct rq *rq; struct rq_flags rf)
+DECLARE_LOCK_GUARD_1_ATTRS(task_rq_lock, __acquires(_T->pi_lock), __releases=
((*(struct task_struct **)_T)->pi_lock))
+#define class_task_rq_lock_constructor(_T) WITH_LOCK_GUARD_1_ATTRS(task_rq_l=
ock, _T)
=20
 DEFINE_LOCK_GUARD_1(__task_rq_lock, struct task_struct,
 		    _T->rq =3D __task_rq_lock(_T->lock, &_T->rf),
@@ -1866,42 +1883,42 @@ DEFINE_LOCK_GUARD_1(__task_rq_lock, struct task_struc=
t,
 		    struct rq *rq; struct rq_flags rf)
=20
 static inline void rq_lock_irqsave(struct rq *rq, struct rq_flags *rf)
-	__acquires(rq->lock)
+	__acquires(__rq_lockp(rq))
 {
 	raw_spin_rq_lock_irqsave(rq, rf->flags);
 	rq_pin_lock(rq, rf);
 }
=20
 static inline void rq_lock_irq(struct rq *rq, struct rq_flags *rf)
-	__acquires(rq->lock)
+	__acquires(__rq_lockp(rq))
 {
 	raw_spin_rq_lock_irq(rq);
 	rq_pin_lock(rq, rf);
 }
=20
 static inline void rq_lock(struct rq *rq, struct rq_flags *rf)
-	__acquires(rq->lock)
+	__acquires(__rq_lockp(rq))
 {
 	raw_spin_rq_lock(rq);
 	rq_pin_lock(rq, rf);
 }
=20
 static inline void rq_unlock_irqrestore(struct rq *rq, struct rq_flags *rf)
-	__releases(rq->lock)
+	__releases(__rq_lockp(rq))
 {
 	rq_unpin_lock(rq, rf);
 	raw_spin_rq_unlock_irqrestore(rq, rf->flags);
 }
=20
 static inline void rq_unlock_irq(struct rq *rq, struct rq_flags *rf)
-	__releases(rq->lock)
+	__releases(__rq_lockp(rq))
 {
 	rq_unpin_lock(rq, rf);
 	raw_spin_rq_unlock_irq(rq);
 }
=20
 static inline void rq_unlock(struct rq *rq, struct rq_flags *rf)
-	__releases(rq->lock)
+	__releases(__rq_lockp(rq))
 {
 	rq_unpin_lock(rq, rf);
 	raw_spin_rq_unlock(rq);
@@ -1912,18 +1929,27 @@ DEFINE_LOCK_GUARD_1(rq_lock, struct rq,
 		    rq_unlock(_T->lock, &_T->rf),
 		    struct rq_flags rf)
=20
+DECLARE_LOCK_GUARD_1_ATTRS(rq_lock, __acquires(__rq_lockp(_T)), __releases(_=
_rq_lockp(*(struct rq **)_T)));
+#define class_rq_lock_constructor(_T) WITH_LOCK_GUARD_1_ATTRS(rq_lock, _T)
+
 DEFINE_LOCK_GUARD_1(rq_lock_irq, struct rq,
 		    rq_lock_irq(_T->lock, &_T->rf),
 		    rq_unlock_irq(_T->lock, &_T->rf),
 		    struct rq_flags rf)
=20
+DECLARE_LOCK_GUARD_1_ATTRS(rq_lock_irq, __acquires(__rq_lockp(_T)), __releas=
es(__rq_lockp(*(struct rq **)_T)));
+#define class_rq_lock_irq_constructor(_T) WITH_LOCK_GUARD_1_ATTRS(rq_lock_ir=
q, _T)
+
 DEFINE_LOCK_GUARD_1(rq_lock_irqsave, struct rq,
 		    rq_lock_irqsave(_T->lock, &_T->rf),
 		    rq_unlock_irqrestore(_T->lock, &_T->rf),
 		    struct rq_flags rf)
=20
-static inline struct rq *this_rq_lock_irq(struct rq_flags *rf)
-	__acquires(rq->lock)
+DECLARE_LOCK_GUARD_1_ATTRS(rq_lock_irqsave, __acquires(__rq_lockp(_T)), __re=
leases(__rq_lockp(*(struct rq **)_T)));
+#define class_rq_lock_irqsave_constructor(_T) WITH_LOCK_GUARD_1_ATTRS(rq_loc=
k_irqsave, _T)
+
+#define this_rq_lock_irq(...) __acquire_ret(_this_rq_lock_irq(__VA_ARGS__), =
__rq_lockp(__ret))
+static inline struct rq *_this_rq_lock_irq(struct rq_flags *rf) __acquires_r=
et
 {
 	struct rq *rq;
=20
@@ -3050,8 +3076,20 @@ static inline void double_rq_clock_clear_update(struct=
 rq *rq1, struct rq *rq2)
 #define DEFINE_LOCK_GUARD_2(name, type, _lock, _unlock, ...)				\
 __DEFINE_UNLOCK_GUARD(name, type, _unlock, type *lock2; __VA_ARGS__)			\
 static inline class_##name##_t class_##name##_constructor(type *lock, type *=
lock2)	\
+	__no_context_analysis								\
 { class_##name##_t _t =3D { .lock =3D lock, .lock2 =3D lock2 }, *_T =3D &_t;=
			\
   _lock; return _t; }
+#define DECLARE_LOCK_GUARD_2_ATTRS(_name, _lock, _unlock1, _unlock2)			\
+static inline class_##_name##_t class_##_name##_constructor(lock_##_name##_t=
 *_T1,	\
+							    lock_##_name##_t *_T2) _lock; \
+static __always_inline void __class_##_name##_cleanup_ctx1(class_##_name##_t=
 **_T1)	\
+	__no_context_analysis _unlock1 { }						\
+static __always_inline void __class_##_name##_cleanup_ctx2(class_##_name##_t=
 **_T2)	\
+	__no_context_analysis _unlock2 { }
+#define WITH_LOCK_GUARD_2_ATTRS(_name, _T1, _T2)					\
+	class_##_name##_constructor(_T1, _T2),						\
+	*__UNIQUE_ID(unlock1) __cleanup(__class_##_name##_cleanup_ctx1) =3D (void *=
)(_T1),\
+	*__UNIQUE_ID(unlock2) __cleanup(__class_##_name##_cleanup_ctx2) =3D (void *=
)(_T2)
=20
 static inline bool rq_order_less(struct rq *rq1, struct rq *rq2)
 {
@@ -3079,7 +3117,8 @@ static inline bool rq_order_less(struct rq *rq1, struct=
 rq *rq2)
 	return rq1->cpu < rq2->cpu;
 }
=20
-extern void double_rq_lock(struct rq *rq1, struct rq *rq2);
+extern void double_rq_lock(struct rq *rq1, struct rq *rq2)
+	__acquires(__rq_lockp(rq1), __rq_lockp(rq2));
=20
 #ifdef CONFIG_PREEMPTION
=20
@@ -3092,9 +3131,8 @@ extern void double_rq_lock(struct rq *rq1, struct rq *r=
q2);
  * also adds more overhead and therefore may reduce throughput.
  */
 static inline int _double_lock_balance(struct rq *this_rq, struct rq *busies=
t)
-	__releases(this_rq->lock)
-	__acquires(busiest->lock)
-	__acquires(this_rq->lock)
+	__must_hold(__rq_lockp(this_rq))
+	__acquires(__rq_lockp(busiest))
 {
 	raw_spin_rq_unlock(this_rq);
 	double_rq_lock(this_rq, busiest);
@@ -3111,12 +3149,16 @@ static inline int _double_lock_balance(struct rq *thi=
s_rq, struct rq *busiest)
  * regardless of entry order into the function.
  */
 static inline int _double_lock_balance(struct rq *this_rq, struct rq *busies=
t)
-	__releases(this_rq->lock)
-	__acquires(busiest->lock)
-	__acquires(this_rq->lock)
+	__must_hold(__rq_lockp(this_rq))
+	__acquires(__rq_lockp(busiest))
 {
-	if (__rq_lockp(this_rq) =3D=3D __rq_lockp(busiest) ||
-	    likely(raw_spin_rq_trylock(busiest))) {
+	if (__rq_lockp(this_rq) =3D=3D __rq_lockp(busiest)) {
+		__acquire(__rq_lockp(busiest)); /* already held */
+		double_rq_clock_clear_update(this_rq, busiest);
+		return 0;
+	}
+
+	if (likely(raw_spin_rq_trylock(busiest))) {
 		double_rq_clock_clear_update(this_rq, busiest);
 		return 0;
 	}
@@ -3139,6 +3181,8 @@ static inline int _double_lock_balance(struct rq *this_=
rq, struct rq *busiest)
  * double_lock_balance - lock the busiest runqueue, this_rq is locked alread=
y.
  */
 static inline int double_lock_balance(struct rq *this_rq, struct rq *busiest)
+	__must_hold(__rq_lockp(this_rq))
+	__acquires(__rq_lockp(busiest))
 {
 	lockdep_assert_irqs_disabled();
=20
@@ -3146,14 +3190,17 @@ static inline int double_lock_balance(struct rq *this=
_rq, struct rq *busiest)
 }
=20
 static inline void double_unlock_balance(struct rq *this_rq, struct rq *busi=
est)
-	__releases(busiest->lock)
+	__releases(__rq_lockp(busiest))
 {
 	if (__rq_lockp(this_rq) !=3D __rq_lockp(busiest))
 		raw_spin_rq_unlock(busiest);
+	else
+		__release(__rq_lockp(busiest)); /* fake release */
 	lock_set_subclass(&__rq_lockp(this_rq)->dep_map, 0, _RET_IP_);
 }
=20
 static inline void double_lock(spinlock_t *l1, spinlock_t *l2)
+	__acquires(l1, l2)
 {
 	if (l1 > l2)
 		swap(l1, l2);
@@ -3163,6 +3210,7 @@ static inline void double_lock(spinlock_t *l1, spinlock=
_t *l2)
 }
=20
 static inline void double_lock_irq(spinlock_t *l1, spinlock_t *l2)
+	__acquires(l1, l2)
 {
 	if (l1 > l2)
 		swap(l1, l2);
@@ -3172,6 +3220,7 @@ static inline void double_lock_irq(spinlock_t *l1, spin=
lock_t *l2)
 }
=20
 static inline void double_raw_lock(raw_spinlock_t *l1, raw_spinlock_t *l2)
+	__acquires(l1, l2)
 {
 	if (l1 > l2)
 		swap(l1, l2);
@@ -3181,6 +3230,7 @@ static inline void double_raw_lock(raw_spinlock_t *l1, =
raw_spinlock_t *l2)
 }
=20
 static inline void double_raw_unlock(raw_spinlock_t *l1, raw_spinlock_t *l2)
+	__releases(l1, l2)
 {
 	raw_spin_unlock(l1);
 	raw_spin_unlock(l2);
@@ -3190,6 +3240,13 @@ DEFINE_LOCK_GUARD_2(double_raw_spinlock, raw_spinlock_=
t,
 		    double_raw_lock(_T->lock, _T->lock2),
 		    double_raw_unlock(_T->lock, _T->lock2))
=20
+DECLARE_LOCK_GUARD_2_ATTRS(double_raw_spinlock,
+			   __acquires(_T1, _T2),
+			   __releases(*(raw_spinlock_t **)_T1),
+			   __releases(*(raw_spinlock_t **)_T2));
+#define class_double_raw_spinlock_constructor(_T1, _T2) \
+	WITH_LOCK_GUARD_2_ATTRS(double_raw_spinlock, _T1, _T2)
+
 /*
  * double_rq_unlock - safely unlock two runqueues
  *
@@ -3197,13 +3254,12 @@ DEFINE_LOCK_GUARD_2(double_raw_spinlock, raw_spinlock=
_t,
  * you need to do so manually after calling.
  */
 static inline void double_rq_unlock(struct rq *rq1, struct rq *rq2)
-	__releases(rq1->lock)
-	__releases(rq2->lock)
+	__releases(__rq_lockp(rq1), __rq_lockp(rq2))
 {
 	if (__rq_lockp(rq1) !=3D __rq_lockp(rq2))
 		raw_spin_rq_unlock(rq2);
 	else
-		__release(rq2->lock);
+		__release(__rq_lockp(rq2)); /* fake release */
 	raw_spin_rq_unlock(rq1);
 }
=20
diff --git a/scripts/context-analysis-suppression.txt b/scripts/context-analy=
sis-suppression.txt
index df25c3d..fd8951d 100644
--- a/scripts/context-analysis-suppression.txt
+++ b/scripts/context-analysis-suppression.txt
@@ -26,6 +26,7 @@ src:*include/linux/refcount.h=3Demit
 src:*include/linux/rhashtable.h=3Demit
 src:*include/linux/rwlock*.h=3Demit
 src:*include/linux/rwsem.h=3Demit
+src:*include/linux/sched*=3Demit
 src:*include/linux/seqlock*.h=3Demit
 src:*include/linux/spinlock*.h=3Demit
 src:*include/linux/srcu*.h=3Demit

