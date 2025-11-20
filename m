Return-Path: <linux-tip-commits+bounces-7410-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id E8932C73AD9
	for <lists+linux-tip-commits@lfdr.de>; Thu, 20 Nov 2025 12:21:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E9BD34E9233
	for <lists+linux-tip-commits@lfdr.de>; Thu, 20 Nov 2025 11:20:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27C78330B03;
	Thu, 20 Nov 2025 11:19:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="WkWrwyCU";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ejb607rP"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D319D322A24;
	Thu, 20 Nov 2025 11:19:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763637597; cv=none; b=A48vqJyXoY1EfcgzdorVZeBd9igTD3ME8Ps7MhNh4pu9yEPonU0kVHQQcjZ2rqMoeijFOuuWc1dGtwEntw1LCutLGQBnYrn+WwSHd0n6l4eNJkBihieTECXBe5Emnfo9jcUCjJsYXqjbMeubbaDs8qkrUXuJLdrqE/pMVaZWe4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763637597; c=relaxed/simple;
	bh=lQmvMGktJ7U5X0Sl+vA/jxaMmPHcXXEHO0dN/07Ed0U=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=d/ixrTqHTPO1W263SGS3k83Tzf/NCZbgdm5XHffiWhGed4NnbOPu9WmRU9PyE6YbKaDO3v5lP0OKlqrkr1i0LOQ1lEzl8khFJwH6d8uMp/4Ry/02dxa5kjzr7PnJzJl/w+4Y9FSyRYRcxSfeKkbvXcxlTj9BJAqEMm77SLT3oco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=WkWrwyCU; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ejb607rP; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 20 Nov 2025 11:19:51 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1763637593;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zqgMycWwxVTmMwKW1a/Amz7gJN0uywfYYy7cyaBanYg=;
	b=WkWrwyCUyAVTzZjs9yJ/U+IZPLWoVAVXhs//Ba1gXaHmVbXHNf+aHFaBIo7HjY3QTScM4z
	wfHxRBiU9NGm0isRVu394mBebc03M1/Y+H3xp+YhQBYQ9qac/KoxM5bOkGS3GDfjmme6Oq
	pXxNJ8aYBAbOmqNfxMFNl3MhGN9ao9G1d8hLe3qXnEFX/RvlA8suXkFjizAJYDvTlp42M2
	/da9eZJTJ81YNjE5r25N0n8MsGfuCRRmEqatFCX0kSBeevz5bdwoxj7bOSHbswH4ZbNW00
	MELM1P9813sNlHSCsUV4xwyYCS9mCFFY3gYuupNKoFo0/VP2yj1zIWHIkcSijA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1763637593;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zqgMycWwxVTmMwKW1a/Amz7gJN0uywfYYy7cyaBanYg=;
	b=ejb607rPvHGrSF+FSfU6F0mVpZCn/+e64TtDh+2mGabtBSRgIItNlGDeS0dNA2WZIlhvYb
	gnU/apgMzUJorsDQ==
From: "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: core/rseq] sched/mmcid: Provide CID ownership mode fixup functions
Cc: Thomas Gleixner <tglx@linutronix.de>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20251119172550.088189028@linutronix.de>
References: <20251119172550.088189028@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176363759199.498.9683193779802169872.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the core/rseq branch of tip:

Commit-ID:     340af997d25dab0f05c4de8399d656b112592a93
Gitweb:        https://git.kernel.org/tip/340af997d25dab0f05c4de8399d656b1125=
92a93
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Wed, 19 Nov 2025 18:27:16 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Thu, 20 Nov 2025 12:14:57 +01:00

sched/mmcid: Provide CID ownership mode fixup functions

CIDs are either owned by tasks or by CPUs. The ownership mode depends on
the number of tasks related to a MM and the number of CPUs on which these
tasks are theoretically allowed to run on. Theoretically because that
number is the superset of CPU affinities of all tasks which only grows and
never shrinks.

Switching to per CPU mode happens when the user count becomes greater than
the maximum number of CIDs, which is calculated by:

	opt_cids =3D min(mm_cid::nr_cpus_allowed, mm_cid::users);
	max_cids =3D min(1.25 * opt_cids, nr_cpu_ids);

The +25% allowance is useful for tight CPU masks in scenarios where only a
few threads are created and destroyed to avoid frequent mode
switches. Though this allowance shrinks, the closer opt_cids becomes to
nr_cpu_ids, which is the (unfortunate) hard ABI limit.

At the point of switching to per CPU mode the new user is not yet visible
in the system, so the task which initiated the fork() runs the fixup
function: mm_cid_fixup_tasks_to_cpu() walks the thread list and either
transfers each tasks owned CID to the CPU the task runs on or drops it into
the CID pool if a task is not on a CPU at that point in time. Tasks which
schedule in before the task walk reaches them do the handover in
mm_cid_schedin(). When mm_cid_fixup_tasks_to_cpus() completes it's
guaranteed that no task related to that MM owns a CID anymore.

Switching back to task mode happens when the user count goes below the
threshold which was recorded on the per CPU mode switch:

	pcpu_thrs =3D min(opt_cids - (opt_cids / 4), nr_cpu_ids / 2);

This threshold is updated when a affinity change increases the number of
allowed CPUs for the MM, which might cause a switch back to per task mode.

If the switch back was initiated by a exiting task, then that task runs the
fixup function. If it was initiated by a affinity change, then it's run
either in the deferred update function in context of a workqueue or by a
task which forks a new one or by a task which exits. Whatever happens
first. mm_cid_fixup_cpus_to_task() walks through the possible CPUs and
either transfers the CPU owned CIDs to a related task which runs on the CPU
or drops it into the pool. Tasks which schedule in on a CPU which the walk
did not cover yet do the handover themselves.

This transition from CPU to per task ownership happens in two phases:

 1) mm:mm_cid.transit contains MM_CID_TRANSIT. This is OR'ed on the task
    CID and denotes that the CID is only temporarily owned by the
    task. When it schedules out the task drops the CID back into the
    pool if this bit is set.

 2) The initiating context walks the per CPU space and after completion
    clears mm:mm_cid.transit. After that point the CIDs are strictly
    task owned again.

This two phase transition is required to prevent CID space exhaustion
during the transition as a direct transfer of ownership would fail if
two tasks are scheduled in on the same CPU before the fixup freed per
CPU CIDs.

When mm_cid_fixup_cpus_to_tasks() completes it's guaranteed that no CID
related to that MM is owned by a CPU anymore.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Link: https://patch.msgid.link/20251119172550.088189028@linutronix.de
---
 include/linux/rseq_types.h |   7 +-
 kernel/sched/core.c        | 277 ++++++++++++++++++++++++++++++++----
 2 files changed, 258 insertions(+), 26 deletions(-)

diff --git a/include/linux/rseq_types.h b/include/linux/rseq_types.h
index 66b1482..a3a4f3f 100644
--- a/include/linux/rseq_types.h
+++ b/include/linux/rseq_types.h
@@ -122,14 +122,15 @@ struct mm_cid_pcpu {
  * @percpu:		Set, when CIDs are in per CPU mode
  * @transit:		Set to MM_CID_TRANSIT during a mode change transition phase
  * @max_cids:		The exclusive maximum CID value for allocation and convergence
- * @lock:		Spinlock to protect all fields except @pcpu. It also protects
- *			the MM cid cpumask and the MM cidmask bitmap.
+ * @lock:		Spinlock to protect against affinity setting which can't take @mu=
tex
  * @mutex:		Mutex to serialize forks and exits related to this mm
  * @nr_cpus_allowed:	The number of CPUs in the per MM allowed CPUs map. The =
map
  *			is growth only.
  * @users:		The number of tasks sharing this MM. Separate from mm::mm_users
  *			as that is modified by mmget()/mm_put() by other entities which
  *			do not actually share the MM.
+ * @pcpu_thrs:		Threshold for switching back from per CPU mode
+ * @update_deferred:	A deferred switch back to per task mode is pending.
  */
 struct mm_mm_cid {
 	/* Hotpath read mostly members */
@@ -144,6 +145,8 @@ struct mm_mm_cid {
 	/* Low frequency modified */
 	unsigned int		nr_cpus_allowed;
 	unsigned int		users;
+	unsigned int		pcpu_thrs;
+	unsigned int		update_deferred;
 }____cacheline_aligned_in_smp;
 #else /* CONFIG_SCHED_MM_CID */
 struct mm_mm_cid { };
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 659ae56..f781d59 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -10396,43 +10396,269 @@ void call_trace_sched_update_nr_running(struct rq =
*rq, int count)
  * task needs to drop the CID into the pool when scheduling out.  Both bits
  * (ONCPU and TRANSIT) are filtered out by task_cid() when the CID is
  * actually handed over to user space in the RSEQ memory.
+ *
+ * Mode switching:
+ *
+ * Switching to per CPU mode happens when the user count becomes greater
+ * than the maximum number of CIDs, which is calculated by:
+ *
+ *	opt_cids =3D min(mm_cid::nr_cpus_allowed, mm_cid::users);
+ *	max_cids =3D min(1.25 * opt_cids, num_possible_cpus());
+ *
+ * The +25% allowance is useful for tight CPU masks in scenarios where only
+ * a few threads are created and destroyed to avoid frequent mode
+ * switches. Though this allowance shrinks, the closer opt_cids becomes to
+ * num_possible_cpus(), which is the (unfortunate) hard ABI limit.
+ *
+ * At the point of switching to per CPU mode the new user is not yet
+ * visible in the system, so the task which initiated the fork() runs the
+ * fixup function: mm_cid_fixup_tasks_to_cpu() walks the thread list and
+ * either transfers each tasks owned CID to the CPU the task runs on or
+ * drops it into the CID pool if a task is not on a CPU at that point in
+ * time. Tasks which schedule in before the task walk reaches them do the
+ * handover in mm_cid_schedin(). When mm_cid_fixup_tasks_to_cpus() completes
+ * it's guaranteed that no task related to that MM owns a CID anymore.
+ *
+ * Switching back to task mode happens when the user count goes below the
+ * threshold which was recorded on the per CPU mode switch:
+ *
+ *	pcpu_thrs =3D min(opt_cids - (opt_cids / 4), num_possible_cpus() / 2);
+ *
+ * This threshold is updated when a affinity change increases the number of
+ * allowed CPUs for the MM, which might cause a switch back to per task
+ * mode.
+ *
+ * If the switch back was initiated by a exiting task, then that task runs
+ * the fixup function. If it was initiated by a affinity change, then it's
+ * run either in the deferred update function in context of a workqueue or
+ * by a task which forks a new one or by a task which exits. Whatever
+ * happens first. mm_cid_fixup_cpus_to_task() walks through the possible
+ * CPUs and either transfers the CPU owned CIDs to a related task which
+ * runs on the CPU or drops it into the pool. Tasks which schedule in on a
+ * CPU which the walk did not cover yet do the handover themself.
+ *
+ * This transition from CPU to per task ownership happens in two phases:
+ *
+ *  1) mm:mm_cid.transit contains MM_CID_TRANSIT This is OR'ed on the task
+ *     CID and denotes that the CID is only temporarily owned by the
+ *     task. When it schedules out the task drops the CID back into the
+ *     pool if this bit is set.
+ *
+ *  2) The initiating context walks the per CPU space and after completion
+ *     clears mm:mm_cid.transit. So after that point the CIDs are strictly
+ *     task owned again.
+ *
+ * This two phase transition is required to prevent CID space exhaustion
+ * during the transition as a direct transfer of ownership would fail if
+ * two tasks are scheduled in on the same CPU before the fixup freed per
+ * CPU CIDs.
+ *
+ * When mm_cid_fixup_cpus_to_tasks() completes it's guaranteed that no CID
+ * related to that MM is owned by a CPU anymore.
  */
=20
 /*
  * Update the CID range properties when the constraints change. Invoked via
  * fork(), exit() and affinity changes
  */
-static void mm_update_max_cids(struct mm_struct *mm)
+static void __mm_update_max_cids(struct mm_mm_cid *mc)
+{
+	unsigned int opt_cids, max_cids;
+
+	/* Calculate the new optimal constraint */
+	opt_cids =3D min(mc->nr_cpus_allowed, mc->users);
+
+	/* Adjust the maximum CIDs to +25% limited by the number of possible CPUs */
+	max_cids =3D min(opt_cids + (opt_cids / 4), num_possible_cpus());
+	WRITE_ONCE(mc->max_cids, max_cids);
+}
+
+static inline unsigned int mm_cid_calc_pcpu_thrs(struct mm_mm_cid *mc)
+{
+	unsigned int opt_cids;
+
+	opt_cids =3D min(mc->nr_cpus_allowed, mc->users);
+	return min(opt_cids - opt_cids / 4, num_possible_cpus() / 2);
+}
+
+static bool mm_update_max_cids(struct mm_struct *mm)
 {
 	struct mm_mm_cid *mc =3D &mm->mm_cid;
-	unsigned int max_cids;
=20
 	lockdep_assert_held(&mm->mm_cid.lock);
=20
-	/* Calculate the new maximum constraint */
-	max_cids =3D min(mc->nr_cpus_allowed, mc->users);
-	WRITE_ONCE(mc->max_cids, max_cids);
+	/* Clear deferred mode switch flag. A change is handled by the caller */
+	mc->update_deferred =3D false;
+	__mm_update_max_cids(mc);
+
+	/* Check whether owner mode must be changed */
+	if (!mc->percpu) {
+		/* Enable per CPU mode when the number of users is above max_cids */
+		if (mc->users > mc->max_cids)
+			mc->pcpu_thrs =3D mm_cid_calc_pcpu_thrs(mc);
+	} else {
+		/* Switch back to per task if user count under threshold */
+		if (mc->users < mc->pcpu_thrs)
+			mc->pcpu_thrs =3D 0;
+	}
+
+	/* Mode change required? */
+	if (!!mc->percpu =3D=3D !!mc->pcpu_thrs)
+		return false;
+	/* When switching back to per TASK mode, set the transition flag */
+	if (!mc->pcpu_thrs)
+		WRITE_ONCE(mc->transit, MM_CID_TRANSIT);
+	WRITE_ONCE(mc->percpu, !!mc->pcpu_thrs);
+	return true;
 }
=20
 static inline void mm_update_cpus_allowed(struct mm_struct *mm, const struct=
 cpumask *affmsk)
 {
 	struct cpumask *mm_allowed;
+	struct mm_mm_cid *mc;
 	unsigned int weight;
=20
 	if (!mm || !READ_ONCE(mm->mm_cid.users))
 		return;
-
 	/*
 	 * mm::mm_cid::mm_cpus_allowed is the superset of each threads
 	 * allowed CPUs mask which means it can only grow.
 	 */
-	guard(raw_spinlock)(&mm->mm_cid.lock);
+	mc =3D &mm->mm_cid;
+	guard(raw_spinlock)(&mc->lock);
 	mm_allowed =3D mm_cpus_allowed(mm);
 	weight =3D cpumask_weighted_or(mm_allowed, mm_allowed, affmsk);
-	if (weight =3D=3D mm->mm_cid.nr_cpus_allowed)
+	if (weight =3D=3D mc->nr_cpus_allowed)
+		return;
+
+	WRITE_ONCE(mc->nr_cpus_allowed, weight);
+	__mm_update_max_cids(mc);
+	if (!mc->percpu)
 		return;
-	WRITE_ONCE(mm->mm_cid.nr_cpus_allowed, weight);
-	mm_update_max_cids(mm);
+
+	/* Adjust the threshold to the wider set */
+	mc->pcpu_thrs =3D mm_cid_calc_pcpu_thrs(mc);
+
+	/* Scheduling of deferred mode switch goes here */
+}
+
+static inline void mm_cid_transit_to_task(struct task_struct *t, struct mm_c=
id_pcpu *pcp)
+{
+	if (cid_on_cpu(t->mm_cid.cid)) {
+		unsigned int cid =3D cpu_cid_to_cid(t->mm_cid.cid);
+
+		t->mm_cid.cid =3D cid_to_transit_cid(cid);
+		pcp->cid =3D t->mm_cid.cid;
+	}
+}
+
+static void __maybe_unused mm_cid_fixup_cpus_to_tasks(struct mm_struct *mm)
+{
+	unsigned int cpu;
+
+	/* Walk the CPUs and fixup all stale CIDs */
+	for_each_possible_cpu(cpu) {
+		struct mm_cid_pcpu *pcp =3D per_cpu_ptr(mm->mm_cid.pcpu, cpu);
+		struct rq *rq =3D cpu_rq(cpu);
+
+		/* Remote access to mm::mm_cid::pcpu requires rq_lock */
+		guard(rq_lock_irq)(rq);
+		/* Is the CID still owned by the CPU? */
+		if (cid_on_cpu(pcp->cid)) {
+			/*
+			 * If rq->curr has @mm, transfer it with the
+			 * transition bit set. Otherwise drop it.
+			 */
+			if (rq->curr->mm =3D=3D mm && rq->curr->mm_cid.active)
+				mm_cid_transit_to_task(rq->curr, pcp);
+			else
+				mm_drop_cid_on_cpu(mm, pcp);
+
+		} else if (rq->curr->mm =3D=3D mm && rq->curr->mm_cid.active) {
+			unsigned int cid =3D rq->curr->mm_cid.cid;
+
+			/* Ensure it has the transition bit set */
+			if (!cid_in_transit(cid)) {
+				cid =3D cid_to_transit_cid(cid);
+				rq->curr->mm_cid.cid =3D cid;
+				pcp->cid =3D cid;
+			}
+		}
+	}
+	/* Clear the transition bit */
+	WRITE_ONCE(mm->mm_cid.transit, 0);
+}
+
+static inline void mm_cid_transfer_to_cpu(struct task_struct *t, struct mm_c=
id_pcpu *pcp)
+{
+	if (cid_on_task(t->mm_cid.cid)) {
+		t->mm_cid.cid =3D cid_to_cpu_cid(t->mm_cid.cid);
+		pcp->cid =3D t->mm_cid.cid;
+	}
+}
+
+static bool mm_cid_fixup_task_to_cpu(struct task_struct *t, struct mm_struct=
 *mm)
+{
+	/* Remote access to mm::mm_cid::pcpu requires rq_lock */
+	guard(task_rq_lock)(t);
+	/* If the task is not active it is not in the users count */
+	if (!t->mm_cid.active)
+		return false;
+	if (cid_on_task(t->mm_cid.cid)) {
+		/* If running on the CPU, transfer the CID, otherwise drop it */
+		if (task_rq(t)->curr =3D=3D t)
+			mm_cid_transfer_to_cpu(t, per_cpu_ptr(mm->mm_cid.pcpu, task_cpu(t)));
+		else
+			mm_unset_cid_on_task(t);
+	}
+	return true;
+}
+
+static void __maybe_unused mm_cid_fixup_tasks_to_cpus(void)
+{
+	struct mm_struct *mm =3D current->mm;
+	struct task_struct *p, *t;
+	unsigned int users;
+
+	/*
+	 * This can obviously race with a concurrent affinity change, which
+	 * increases the number of allowed CPUs for this mm, but that does
+	 * not affect the mode and only changes the CID constraints. A
+	 * possible switch back to per task mode happens either in the
+	 * deferred handler function or in the next fork()/exit().
+	 *
+	 * The caller has already transferred. The newly incoming task is
+	 * already accounted for, but not yet visible.
+	 */
+	users =3D mm->mm_cid.users - 2;
+	if (!users)
+		return;
+
+	guard(rcu)();
+	for_other_threads(current, t) {
+		if (mm_cid_fixup_task_to_cpu(t, mm))
+			users--;
+	}
+
+	if (!users)
+		return;
+
+	/* Happens only for VM_CLONE processes. */
+	for_each_process_thread(p, t) {
+		if (t =3D=3D current || t->mm !=3D mm)
+			continue;
+		if (mm_cid_fixup_task_to_cpu(t, mm)) {
+			if (--users =3D=3D 0)
+				return;
+		}
+	}
+}
+
+static bool sched_mm_cid_add_user(struct task_struct *t, struct mm_struct *m=
m)
+{
+	t->mm_cid.active =3D 1;
+	mm->mm_cid.users++;
+	return mm_update_max_cids(mm);
 }
=20
 void sched_mm_cid_fork(struct task_struct *t)
@@ -10442,12 +10668,19 @@ void sched_mm_cid_fork(struct task_struct *t)
 	WARN_ON_ONCE(!mm || t->mm_cid.cid !=3D MM_CID_UNSET);
=20
 	guard(mutex)(&mm->mm_cid.mutex);
-	guard(raw_spinlock)(&mm->mm_cid.lock);
-	t->mm_cid.active =3D 1;
-	mm->mm_cid.users++;
-	/* Preset last_cid for mm_cid_select() */
-	t->mm_cid.last_cid =3D READ_ONCE(mm->mm_cid.max_cids) - 1;
-	mm_update_max_cids(mm);
+	scoped_guard(raw_spinlock, &mm->mm_cid.lock) {
+		sched_mm_cid_add_user(t, mm);
+		/* Preset last_cid for mm_cid_select() */
+		t->mm_cid.last_cid =3D mm->mm_cid.max_cids - 1;
+	}
+}
+
+static bool sched_mm_cid_remove_user(struct task_struct *t)
+{
+	t->mm_cid.active =3D 0;
+	mm_unset_cid_on_task(t);
+	t->mm->mm_cid.users--;
+	return mm_update_max_cids(t->mm);
 }
=20
 /*
@@ -10462,14 +10695,8 @@ void sched_mm_cid_exit(struct task_struct *t)
 		return;
=20
 	guard(mutex)(&mm->mm_cid.mutex);
-	guard(raw_spinlock)(&mm->mm_cid.lock);
-	t->mm_cid.active =3D 0;
-	mm->mm_cid.users--;
-	if (t->mm_cid.cid !=3D MM_CID_UNSET) {
-		clear_bit(t->mm_cid.cid, mm_cidmask(mm));
-		t->mm_cid.cid =3D MM_CID_UNSET;
-	}
-	mm_update_max_cids(mm);
+	scoped_guard(raw_spinlock, &mm->mm_cid.lock)
+		sched_mm_cid_remove_user(t);
 }
=20
 /* Deactivate MM CID allocation across execve() */
@@ -10499,6 +10726,8 @@ void mm_init_cid(struct mm_struct *mm, struct task_st=
ruct *p)
 	mm->mm_cid.transit =3D 0;
 	mm->mm_cid.nr_cpus_allowed =3D p->nr_cpus_allowed;
 	mm->mm_cid.users =3D 0;
+	mm->mm_cid.pcpu_thrs =3D 0;
+	mm->mm_cid.update_deferred =3D 0;
 	raw_spin_lock_init(&mm->mm_cid.lock);
 	mutex_init(&mm->mm_cid.mutex);
 	cpumask_copy(mm_cpus_allowed(mm), &p->cpus_mask);

