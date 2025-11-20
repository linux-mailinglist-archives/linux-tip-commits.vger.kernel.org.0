Return-Path: <linux-tip-commits+bounces-7411-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 581FAC73AC1
	for <lists+linux-tip-commits@lfdr.de>; Thu, 20 Nov 2025 12:20:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by tor.lore.kernel.org (Postfix) with ESMTPS id 63FFC2A8BE
	for <lists+linux-tip-commits@lfdr.de>; Thu, 20 Nov 2025 11:20:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BD4F331200;
	Thu, 20 Nov 2025 11:19:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="rTJHPERx";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="c+duwTHE"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D340A32F75C;
	Thu, 20 Nov 2025 11:19:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763637598; cv=none; b=ML8bXmUV11nZViuEt2jvPdpodykCdOm/dkaqbzAxJeA6R4hgqv87HhnEBHhB3n2CRe6UrBPk/6r+rhv5+8tQvZvHNJb71ZLofJsRGo0jycYECKi7xg4DW7DEIV90KSavT+GMNAKNTqipSg2oboiIk6Yn2bYhPjgJkZ2SLdUtoWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763637598; c=relaxed/simple;
	bh=umYtQ5q/84TaXof8C4cYfinDVJ/MZfOkBIoLBig1hms=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=Lo1U9yrR7heZusl/h4s6FBO/ekZfAhj6hqlGcSl7ESLxLuoNdMBMrC6atsr6gimMak3aru+EAwp0NUuqJWY5I0oyaJZ49rHKJlHGi0QjpqKgyfSYt3+705W9gxmB1NCQb+9AN7I8fwbFf1LrczAKaRPghYCMBKoRvybubOVNX/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=rTJHPERx; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=c+duwTHE; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 20 Nov 2025 11:19:53 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1763637594;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zQs3SBtt/E+MIv2qyUL53wwT7GVcP1MoaZMYntb/NnA=;
	b=rTJHPERxMZTO6Dgd4qbAnH51I/fvt8Vw1aSoeq2Reoi3hlVpWnxQp9pCLOvkIJQK0H+jdC
	nhLjy7xd3hE7tM+eVEkF4CARjWCAUgZetLhrCh79fOScIy302wv32hZbNjq7Wn0F+8Q208
	hurXLaDspGPDEI4dL/XeBdG7w3DFUBCLJfoAzk5xVi3V59m12Q2VwKPR2oOuJuXU19i9LK
	V/lbO4hVgBY6PQx1l224FTSYPGaqwcT6+LZOkWF8mE9FBajbf/r2Lw7nWWAl3kJj3UZN9A
	OiHRT9SjsnF58slmn9yxmk0GrQFLjzH8KBUbrSdUEfgOciZupz1REOoVEaB3SQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1763637594;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zQs3SBtt/E+MIv2qyUL53wwT7GVcP1MoaZMYntb/NnA=;
	b=c+duwTHEp+ZcxOQ3Bjr1yl6f5VtcPG8+pLZPhtqrIM7aykn5Cv3Z0tRXr7PMpb9KI6CbiW
	+bORAUVndfU09cCg==
From: "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: core/rseq] sched/mmcid: Provide new scheduler CID mechanism
Cc: Thomas Gleixner <tglx@linutronix.de>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20251119172550.023984859@linutronix.de>
References: <20251119172550.023984859@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176363759306.498.4323551720231478768.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the core/rseq branch of tip:

Commit-ID:     6fa1e9565d81095ac1c085601a4af8b18a04db1d
Gitweb:        https://git.kernel.org/tip/6fa1e9565d81095ac1c085601a4af8b18a0=
4db1d
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Wed, 19 Nov 2025 18:27:14 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Thu, 20 Nov 2025 12:14:57 +01:00

sched/mmcid: Provide new scheduler CID mechanism

The MM CID management has two fundamental requirements:

  1) It has to guarantee that at no given point in time the same CID is
     used by concurrent tasks in userspace.

  2) The CID space must not exceed the number of possible CPUs in a
     system. While most allocators (glibc, tcmalloc, jemalloc) do not
     care about that, there seems to be at least some LTTng library
     depending on it.

The CID space compaction itself is not a functional correctness
requirement, it is only a useful optimization mechanism to reduce the
memory foot print in unused user space pools.

The optimal CID space is:

    min(nr_tasks, nr_cpus_allowed);

Where @nr_tasks is the number of actual user space threads associated to
the mm and @nr_cpus_allowed is the superset of all task affinities. It is
growth only as it would be insane to take a racy snapshot of all task
affinities when the affinity of one task changes just do redo it 2
milliseconds later when the next task changes it's affinity.

That means that as long as the number of tasks is lower or equal than the
number of CPUs allowed, each task owns a CID. If the number of tasks
exceeds the number of CPUs allowed it switches to per CPU mode, where the
CPUs own the CIDs and the tasks borrow them as long as they are scheduled
in.

For transition periods CIDs can go beyond the optimal space as long as they
don't go beyond the number of possible CPUs.

The current upstream implementation adds overhead into task migration to
keep the CID with the task. It also has to do the CID space consolidation
work from a task work in the exit to user space path. As that work is
assigned to a random task related to a MM this can inflict unwanted exit
latencies.

Implement the context switch parts of a strict ownership mechanism to
address this.

This removes most of the work from the task which schedules out. Only
during transitioning from per CPU to per task ownership it is required to
drop the CID when leaving the CPU to prevent CID space exhaustion. Other
than that scheduling out is just a single check and branch.

The task which schedules in has to check whether:

    1) The ownership mode changed
    2) The CID is within the optimal CID space

In stable situations this results in zero work. The only short disruption
is when ownership mode changes or when the associated CID is not in the
optimal CID space. The latter only happens when tasks exit and therefore
the optimal CID space shrinks.

That mechanism is strictly optimized for the common case where no change
happens. The only case where it actually causes a temporary one time spike
is on mode changes when and only when a lot of tasks related to a MM
schedule exactly at the same time and have eventually to compete on
allocating a CID from the bitmap.

In the sysbench test case which triggered the spinlock contention in the
initial CID code, __schedule() drops significantly in perf top on a 128
Core (256 threads) machine when running sysbench with 255 threads, which
fits into the task mode limit of 256 together with the parent thread:

  Upstream  rseq/perf branch  +CID rework
  0.42%     0.37%             0.32%          [k] __schedule

Increasing the number of threads to 256, which puts the test process into
per CPU mode looks about the same.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Link: https://patch.msgid.link/20251119172550.023984859@linutronix.de
---
 include/linux/rseq.h       |   8 +-
 include/linux/rseq_types.h |  18 ++--
 kernel/sched/core.c        |   2 +-
 kernel/sched/sched.h       | 150 +++++++++++++++++++++++++++++++++++-
 4 files changed, 168 insertions(+), 10 deletions(-)

diff --git a/include/linux/rseq.h b/include/linux/rseq.h
index bf8a6bf..4c0e8bd 100644
--- a/include/linux/rseq.h
+++ b/include/linux/rseq.h
@@ -73,13 +73,13 @@ static __always_inline void rseq_sched_switch_event(struc=
t task_struct *t)
 }
=20
 /*
- * Invoked from __set_task_cpu() when a task migrates to enforce an IDs
- * update.
+ * Invoked from __set_task_cpu() when a task migrates or from
+ * mm_cid_schedin() when the CID changes to enforce an IDs update.
  *
  * This does not raise TIF_NOTIFY_RESUME as that happens in
  * rseq_sched_switch_event().
  */
-static __always_inline void rseq_sched_set_task_cpu(struct task_struct *t, u=
nsigned int cpu)
+static __always_inline void rseq_sched_set_ids_changed(struct task_struct *t)
 {
 	t->rseq.event.ids_changed =3D true;
 }
@@ -168,7 +168,7 @@ static inline void rseq_fork(struct task_struct *t, u64 c=
lone_flags)
 static inline void rseq_handle_slowpath(struct pt_regs *regs) { }
 static inline void rseq_signal_deliver(struct ksignal *ksig, struct pt_regs =
*regs) { }
 static inline void rseq_sched_switch_event(struct task_struct *t) { }
-static inline void rseq_sched_set_task_cpu(struct task_struct *t, unsigned i=
nt cpu) { }
+static inline void rseq_sched_set_ids_changed(struct task_struct *t) { }
 static inline void rseq_sched_set_task_mm_cid(struct task_struct *t, unsigne=
d int cid) { }
 static inline void rseq_force_update(void) { }
 static inline void rseq_virt_userspace_exit(void) { }
diff --git a/include/linux/rseq_types.h b/include/linux/rseq_types.h
index 87854ef..66b1482 100644
--- a/include/linux/rseq_types.h
+++ b/include/linux/rseq_types.h
@@ -119,23 +119,31 @@ struct mm_cid_pcpu {
 /**
  * struct mm_mm_cid - Storage for per MM CID data
  * @pcpu:		Per CPU storage for CIDs associated to a CPU
+ * @percpu:		Set, when CIDs are in per CPU mode
+ * @transit:		Set to MM_CID_TRANSIT during a mode change transition phase
  * @max_cids:		The exclusive maximum CID value for allocation and convergence
+ * @lock:		Spinlock to protect all fields except @pcpu. It also protects
+ *			the MM cid cpumask and the MM cidmask bitmap.
+ * @mutex:		Mutex to serialize forks and exits related to this mm
  * @nr_cpus_allowed:	The number of CPUs in the per MM allowed CPUs map. The =
map
  *			is growth only.
  * @users:		The number of tasks sharing this MM. Separate from mm::mm_users
  *			as that is modified by mmget()/mm_put() by other entities which
  *			do not actually share the MM.
- * @lock:		Spinlock to protect all fields except @pcpu. It also protects
- *			the MM cid cpumask and the MM cidmask bitmap.
- * @mutex:		Mutex to serialize forks and exits related to this mm
  */
 struct mm_mm_cid {
+	/* Hotpath read mostly members */
 	struct mm_cid_pcpu	__percpu *pcpu;
+	unsigned int		percpu;
+	unsigned int		transit;
 	unsigned int		max_cids;
-	unsigned int		nr_cpus_allowed;
-	unsigned int		users;
+
 	raw_spinlock_t		lock;
 	struct mutex		mutex;
+
+	/* Low frequency modified */
+	unsigned int		nr_cpus_allowed;
+	unsigned int		users;
 }____cacheline_aligned_in_smp;
 #else /* CONFIG_SCHED_MM_CID */
 struct mm_mm_cid { };
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 55bb9c9..659ae56 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -10495,6 +10495,8 @@ void mm_init_cid(struct mm_struct *mm, struct task_st=
ruct *p)
 		per_cpu_ptr(pcpu, cpu)->cid =3D MM_CID_UNSET;
=20
 	mm->mm_cid.max_cids =3D 0;
+	mm->mm_cid.percpu =3D 0;
+	mm->mm_cid.transit =3D 0;
 	mm->mm_cid.nr_cpus_allowed =3D p->nr_cpus_allowed;
 	mm->mm_cid.users =3D 0;
 	raw_spin_lock_init(&mm->mm_cid.lock);
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 4b49284..82c7978 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -2209,7 +2209,7 @@ static inline void __set_task_cpu(struct task_struct *p=
, unsigned int cpu)
 	smp_wmb();
 	WRITE_ONCE(task_thread_info(p)->cpu, cpu);
 	p->wake_cpu =3D cpu;
-	rseq_sched_set_task_cpu(p, cpu);
+	rseq_sched_set_ids_changed(p);
 #endif /* CONFIG_SMP */
 }
=20
@@ -3598,6 +3598,153 @@ static __always_inline void mm_drop_cid_on_cpu(struct=
 mm_struct *mm, struct mm_c
 	mm_drop_cid(mm, pcp->cid);
 }
=20
+static inline unsigned int __mm_get_cid(struct mm_struct *mm, unsigned int m=
ax_cids)
+{
+	unsigned int cid =3D find_first_zero_bit(mm_cidmask(mm), max_cids);
+
+	if (cid >=3D max_cids)
+		return MM_CID_UNSET;
+	if (test_and_set_bit(cid, mm_cidmask(mm)))
+		return MM_CID_UNSET;
+	return cid;
+}
+
+static inline unsigned int mm_get_cid(struct mm_struct *mm)
+{
+	unsigned int cid =3D __mm_get_cid(mm, READ_ONCE(mm->mm_cid.max_cids));
+
+	while (cid =3D=3D MM_CID_UNSET) {
+		cpu_relax();
+		cid =3D __mm_get_cid(mm, num_possible_cpus());
+	}
+	return cid;
+}
+
+static inline unsigned int mm_cid_converge(struct mm_struct *mm, unsigned in=
t orig_cid,
+					   unsigned int max_cids)
+{
+	unsigned int new_cid, cid =3D cpu_cid_to_cid(orig_cid);
+
+	/* Is it in the optimal CID space? */
+	if (likely(cid < max_cids))
+		return orig_cid;
+
+	/* Try to find one in the optimal space. Otherwise keep the provided. */
+	new_cid =3D __mm_get_cid(mm, max_cids);
+	if (new_cid !=3D MM_CID_UNSET) {
+		mm_drop_cid(mm, cid);
+		/* Preserve the ONCPU mode of the original CID */
+		return new_cid | (orig_cid & MM_CID_ONCPU);
+	}
+	return orig_cid;
+}
+
+static __always_inline void mm_cid_update_task_cid(struct task_struct *t, un=
signed int cid)
+{
+	if (t->mm_cid.cid !=3D cid) {
+		t->mm_cid.cid =3D cid;
+		rseq_sched_set_ids_changed(t);
+	}
+}
+
+static __always_inline void mm_cid_update_pcpu_cid(struct mm_struct *mm, uns=
igned int cid)
+{
+	__this_cpu_write(mm->mm_cid.pcpu->cid, cid);
+}
+
+static __always_inline void mm_cid_from_cpu(struct task_struct *t, unsigned =
int cpu_cid)
+{
+	unsigned int max_cids, tcid =3D t->mm_cid.cid;
+	struct mm_struct *mm =3D t->mm;
+
+	max_cids =3D READ_ONCE(mm->mm_cid.max_cids);
+	/* Optimize for the common case where both have the ONCPU bit set */
+	if (likely(cid_on_cpu(cpu_cid & tcid))) {
+		if (likely(cpu_cid_to_cid(cpu_cid) < max_cids)) {
+			mm_cid_update_task_cid(t, cpu_cid);
+			return;
+		}
+		/* Try to converge into the optimal CID space */
+		cpu_cid =3D mm_cid_converge(mm, cpu_cid, max_cids);
+	} else {
+		/* Hand over or drop the task owned CID */
+		if (cid_on_task(tcid)) {
+			if (cid_on_cpu(cpu_cid))
+				mm_unset_cid_on_task(t);
+			else
+				cpu_cid =3D cid_to_cpu_cid(tcid);
+		}
+		/* Still nothing, allocate a new one */
+		if (!cid_on_cpu(cpu_cid))
+			cpu_cid =3D cid_to_cpu_cid(mm_get_cid(mm));
+	}
+	mm_cid_update_pcpu_cid(mm, cpu_cid);
+	mm_cid_update_task_cid(t, cpu_cid);
+}
+
+static __always_inline void mm_cid_from_task(struct task_struct *t, unsigned=
 int cpu_cid)
+{
+	unsigned int max_cids, tcid =3D t->mm_cid.cid;
+	struct mm_struct *mm =3D t->mm;
+
+	max_cids =3D READ_ONCE(mm->mm_cid.max_cids);
+	/* Optimize for the common case, where both have the ONCPU bit clear */
+	if (likely(cid_on_task(tcid | cpu_cid))) {
+		if (likely(tcid < max_cids)) {
+			mm_cid_update_pcpu_cid(mm, tcid);
+			return;
+		}
+		/* Try to converge into the optimal CID space */
+		tcid =3D mm_cid_converge(mm, tcid, max_cids);
+	} else {
+		/* Hand over or drop the CPU owned CID */
+		if (cid_on_cpu(cpu_cid)) {
+			if (cid_on_task(tcid))
+				mm_drop_cid_on_cpu(mm, this_cpu_ptr(mm->mm_cid.pcpu));
+			else
+				tcid =3D cpu_cid_to_cid(cpu_cid);
+		}
+		/* Still nothing, allocate a new one */
+		if (!cid_on_task(tcid))
+			tcid =3D mm_get_cid(mm);
+		/* Set the transition mode flag if required */
+		tcid |=3D READ_ONCE(mm->mm_cid.transit);
+	}
+	mm_cid_update_pcpu_cid(mm, tcid);
+	mm_cid_update_task_cid(t, tcid);
+}
+
+static __always_inline void mm_cid_schedin(struct task_struct *next)
+{
+	struct mm_struct *mm =3D next->mm;
+	unsigned int cpu_cid;
+
+	if (!next->mm_cid.active)
+		return;
+
+	cpu_cid =3D __this_cpu_read(mm->mm_cid.pcpu->cid);
+	if (likely(!READ_ONCE(mm->mm_cid.percpu)))
+		mm_cid_from_task(next, cpu_cid);
+	else
+		mm_cid_from_cpu(next, cpu_cid);
+}
+
+static __always_inline void mm_cid_schedout(struct task_struct *prev)
+{
+	/* During mode transitions CIDs are temporary and need to be dropped */
+	if (likely(!cid_in_transit(prev->mm_cid.cid)))
+		return;
+
+	mm_drop_cid(prev->mm, cid_from_transit_cid(prev->mm_cid.cid));
+	prev->mm_cid.cid =3D MM_CID_UNSET;
+}
+
+static inline void mm_cid_switch_to(struct task_struct *prev, struct task_st=
ruct *next)
+{
+	mm_cid_schedout(prev);
+	mm_cid_schedin(next);
+}
+
 /* Active implementation */
 static inline void init_sched_mm_cid(struct task_struct *t)
 {
@@ -3675,6 +3822,7 @@ static inline void switch_mm_cid(struct task_struct *pr=
ev, struct task_struct *n
 #else /* !CONFIG_SCHED_MM_CID: */
 static inline void mm_cid_select(struct task_struct *t) { }
 static inline void switch_mm_cid(struct task_struct *prev, struct task_struc=
t *next) { }
+static inline void mm_cid_switch_to(struct task_struct *prev, struct task_st=
ruct *next) { }
 #endif /* !CONFIG_SCHED_MM_CID */
=20
 extern u64 avg_vruntime(struct cfs_rq *cfs_rq);

