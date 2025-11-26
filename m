Return-Path: <linux-tip-commits+bounces-7535-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 64129C88120
	for <lists+linux-tip-commits@lfdr.de>; Wed, 26 Nov 2025 05:37:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 56F8B3555A6
	for <lists+linux-tip-commits@lfdr.de>; Wed, 26 Nov 2025 04:37:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D62EB3126C5;
	Wed, 26 Nov 2025 04:36:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="KiQiYqUR";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="WSmTrMAy"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B41EE311966;
	Wed, 26 Nov 2025 04:36:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764131777; cv=none; b=VBZ7J96t98Rpr40F1UNN8jp53DDfKrhdLz6ZbqnSF4Y7TkCCYBUbjdJ11QdBgjMj8e7+t/YNzHpUr2oR8bPEEwygcvIGyca/idgaNDSIrUghw0gBjV7Gxd+XEVh2K90xfwQjai+I1wYTItFZpklUGvLsSlW8zuXptScA+bdzJyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764131777; c=relaxed/simple;
	bh=JhprJwZUl6CPBWTjVknODqLWxn7IzU87m9DUML77umA=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=VUWjDCekiexItEftIZvbvDHpdZBEoX0WWW+wKkHpAFlfejhlk+EdK7Ofin1zE9T4pblOWrqCiDUgCszDUIJX6a2wcRGEE82ffY0JJc5MC4K6GYzlqJnP4TPeXAkGtoErgYZ9lqGO6ZxrvjkObl8mOmlarw9Vq8fHEX28ZWZPsvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=KiQiYqUR; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=WSmTrMAy; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 26 Nov 2025 04:36:12 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1764131773;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sV7wtY1mwIq6P4ucQQhbOQRd5Pep5nJb8osXAh4cUBs=;
	b=KiQiYqURx1//3SZtAl4pkrG74XF6yYDnoRn52RX1a8UN+P6v5o7cvUvCzi1PLEeuSv17fO
	UpidjjofWDGb8p2RHbWGlDkfsjxEGPrf8DCKpPiWeMq5mRURA12hmJGalj//7rPxXEwFIr
	+Y36G8ZqwgzaQjLc7iGBYzsF5LtjtLqY2Tnmrc67Ee2dcofg9T4yRI+RpxujZZXywoBcBQ
	Nbfz8YpkCFugpAk3Tc8KGYCbAOsbJNBLIDZEM4cdF9bK6h3SZ+clqD0pl3MkHCcP7tZ+w1
	mOZcTWlrreQqp5jxpdzfC0sEDwNGGhWKr9SDdPIQtrTn7Wagr1F2zZjtxyB2Hw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1764131773;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sV7wtY1mwIq6P4ucQQhbOQRd5Pep5nJb8osXAh4cUBs=;
	b=WSmTrMAyC/WiS6drvQWSGasldjqI8aU92zOzLitzAaGpA4cQ9z8opsag4BOI8BeXsRpuug
	bEAOHRuRIndjIjDw==
From: "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: core/rseq] sched/mmcid: Provide precomputed maximal value
Cc: Thomas Gleixner <tglx@linutronix.de>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20251119172549.832764634@linutronix.de>
References: <20251119172549.832764634@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176413177225.498.11284771236455981276.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the core/rseq branch of tip:

Commit-ID:     b0c3d51b54f8a4f4c809432d210c0c983d5cd97e
Gitweb:        https://git.kernel.org/tip/b0c3d51b54f8a4f4c809432d210c0c983d5=
cd97e
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Wed, 19 Nov 2025 18:27:09 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 25 Nov 2025 19:45:40 +01:00

sched/mmcid: Provide precomputed maximal value

Reading mm::mm_users and mm:::mm_cid::nr_cpus_allowed every time to compute
the maximal CID value is just wasteful as that value is only changing on
fork(), exit() and eventually when the affinity changes.

So it can be easily precomputed at those points and provided in mm::mm_cid
for consumption in the hot path.

But there is an issue with using mm::mm_users for accounting because that
does not necessarily reflect the number of user space tasks as other kernel
code can take temporary references on the MM which skew the picture.

Solve that by adding a users counter to struct mm_mm_cid, which is modified
by fork() and exit() and used for precomputing under mm_mm_cid::lock.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Link: https://patch.msgid.link/20251119172549.832764634@linutronix.de
---
 include/linux/rseq_types.h |  6 ++++-
 kernel/fork.c              |  1 +-
 kernel/sched/core.c        | 59 ++++++++++++++++++++++++++-----------
 kernel/sched/sched.h       |  3 +--
 4 files changed, 50 insertions(+), 19 deletions(-)

diff --git a/include/linux/rseq_types.h b/include/linux/rseq_types.h
index d7e8071..0fab369 100644
--- a/include/linux/rseq_types.h
+++ b/include/linux/rseq_types.h
@@ -117,14 +117,20 @@ struct mm_cid_pcpu {
 /**
  * struct mm_mm_cid - Storage for per MM CID data
  * @pcpu:		Per CPU storage for CIDs associated to a CPU
+ * @max_cids:		The exclusive maximum CID value for allocation and convergence
  * @nr_cpus_allowed:	The number of CPUs in the per MM allowed CPUs map. The =
map
  *			is growth only.
+ * @users:		The number of tasks sharing this MM. Separate from mm::mm_users
+ *			as that is modified by mmget()/mm_put() by other entities which
+ *			do not actually share the MM.
  * @lock:		Spinlock to protect all fields except @pcpu. It also protects
  *			the MM cid cpumask and the MM cidmask bitmap.
  */
 struct mm_mm_cid {
 	struct mm_cid_pcpu	__percpu *pcpu;
+	unsigned int		max_cids;
 	unsigned int		nr_cpus_allowed;
+	unsigned int		users;
 	raw_spinlock_t		lock;
 }____cacheline_aligned_in_smp;
 #else /* CONFIG_SCHED_MM_CID */
diff --git a/kernel/fork.c b/kernel/fork.c
index 74bc7c9..6c23219 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -2455,6 +2455,7 @@ bad_fork_cleanup_namespaces:
 	exit_task_namespaces(p);
 bad_fork_cleanup_mm:
 	if (p->mm) {
+		sched_mm_cid_exit(p);
 		mm_clear_owner(p->mm, p);
 		mmput(p->mm);
 	}
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 34b6c31..f9295c4 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -4485,7 +4485,6 @@ static void __sched_fork(u64 clone_flags, struct task_s=
truct *p)
 	init_numa_balancing(clone_flags, p);
 	p->wake_entry.u_flags =3D CSD_TYPE_TTWU;
 	p->migration_pending =3D NULL;
-	init_sched_mm_cid(p);
 }
=20
 DEFINE_STATIC_KEY_FALSE(sched_numa_balancing);
@@ -10371,15 +10370,27 @@ void call_trace_sched_update_nr_running(struct rq *=
rq, int count)
=20
 #ifdef CONFIG_SCHED_MM_CID
 /*
- * When a task exits, the MM CID held by the task is not longer required as
- * the task cannot return to user space.
+ * Update the CID range properties when the constraints change. Invoked via
+ * fork(), exit() and affinity changes
  */
+static void mm_update_max_cids(struct mm_struct *mm)
+{
+	struct mm_mm_cid *mc =3D &mm->mm_cid;
+	unsigned int max_cids;
+
+	lockdep_assert_held(&mm->mm_cid.lock);
+
+	/* Calculate the new maximum constraint */
+	max_cids =3D min(mc->nr_cpus_allowed, mc->users);
+	WRITE_ONCE(mc->max_cids, max_cids);
+}
+
 static inline void mm_update_cpus_allowed(struct mm_struct *mm, const struct=
 cpumask *affmsk)
 {
 	struct cpumask *mm_allowed;
 	unsigned int weight;
=20
-	if (!mm)
+	if (!mm || !READ_ONCE(mm->mm_cid.users))
 		return;
=20
 	/*
@@ -10389,9 +10400,30 @@ static inline void mm_update_cpus_allowed(struct mm_=
struct *mm, const struct cpu
 	guard(raw_spinlock)(&mm->mm_cid.lock);
 	mm_allowed =3D mm_cpus_allowed(mm);
 	weight =3D cpumask_weighted_or(mm_allowed, mm_allowed, affmsk);
+	if (weight =3D=3D mm->mm_cid.nr_cpus_allowed)
+		return;
 	WRITE_ONCE(mm->mm_cid.nr_cpus_allowed, weight);
+	mm_update_max_cids(mm);
+}
+
+void sched_mm_cid_fork(struct task_struct *t)
+{
+	struct mm_struct *mm =3D t->mm;
+
+	WARN_ON_ONCE(!mm || t->mm_cid.cid !=3D MM_CID_UNSET);
+
+	guard(raw_spinlock)(&mm->mm_cid.lock);
+	t->mm_cid.active =3D 1;
+	mm->mm_cid.users++;
+	/* Preset last_cid for mm_cid_select() */
+	t->mm_cid.last_cid =3D READ_ONCE(mm->mm_cid.max_cids) - 1;
+	mm_update_max_cids(mm);
 }
=20
+/*
+ * When a task exits, the MM CID held by the task is not longer required as
+ * the task cannot return to user space.
+ */
 void sched_mm_cid_exit(struct task_struct *t)
 {
 	struct mm_struct *mm =3D t->mm;
@@ -10399,12 +10431,14 @@ void sched_mm_cid_exit(struct task_struct *t)
 	if (!mm || !t->mm_cid.active)
 		return;
=20
-	guard(preempt)();
+	guard(raw_spinlock)(&mm->mm_cid.lock);
 	t->mm_cid.active =3D 0;
+	mm->mm_cid.users--;
 	if (t->mm_cid.cid !=3D MM_CID_UNSET) {
 		clear_bit(t->mm_cid.cid, mm_cidmask(mm));
 		t->mm_cid.cid =3D MM_CID_UNSET;
 	}
+	mm_update_max_cids(mm);
 }
=20
 /* Deactivate MM CID allocation across execve() */
@@ -10416,22 +10450,11 @@ void sched_mm_cid_before_execve(struct task_struct =
*t)
 /* Reactivate MM CID after successful execve() */
 void sched_mm_cid_after_execve(struct task_struct *t)
 {
-	struct mm_struct *mm =3D t->mm;
-
-	if (!mm)
-		return;
-
+	sched_mm_cid_fork(t);
 	guard(preempt)();
-	t->mm_cid.active =3D 1;
 	mm_cid_select(t);
 }
=20
-void sched_mm_cid_fork(struct task_struct *t)
-{
-	WARN_ON_ONCE(!t->mm || t->mm_cid.cid !=3D MM_CID_UNSET);
-	t->mm_cid.active =3D 1;
-}
-
 void mm_init_cid(struct mm_struct *mm, struct task_struct *p)
 {
 	struct mm_cid_pcpu __percpu *pcpu =3D mm->mm_cid.pcpu;
@@ -10440,7 +10463,9 @@ void mm_init_cid(struct mm_struct *mm, struct task_st=
ruct *p)
 	for_each_possible_cpu(cpu)
 		per_cpu_ptr(pcpu, cpu)->cid =3D MM_CID_UNSET;
=20
+	mm->mm_cid.max_cids =3D 0;
 	mm->mm_cid.nr_cpus_allowed =3D p->nr_cpus_allowed;
+	mm->mm_cid.users =3D 0;
 	raw_spin_lock_init(&mm->mm_cid.lock);
 	cpumask_copy(mm_cpus_allowed(mm), &p->cpus_mask);
 	bitmap_zero(mm_cidmask(mm), num_possible_cpus());
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 31f2e43..d539fb2 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -3571,7 +3571,7 @@ static inline bool mm_cid_get(struct task_struct *t)
 	struct mm_struct *mm =3D t->mm;
 	unsigned int max_cids;
=20
-	max_cids =3D min_t(int, READ_ONCE(mm->mm_cid.nr_cpus_allowed), atomic_read(=
&mm->mm_users));
+	max_cids =3D READ_ONCE(mm->mm_cid.max_cids);
=20
 	/* Try to reuse the last CID of this task */
 	if (__mm_cid_get(t, t->mm_cid.last_cid, max_cids))
@@ -3614,7 +3614,6 @@ static inline void switch_mm_cid(struct task_struct *pr=
ev, struct task_struct *n
 }
=20
 #else /* !CONFIG_SCHED_MM_CID: */
-static inline void init_sched_mm_cid(struct task_struct *t) { }
 static inline void mm_cid_select(struct task_struct *t) { }
 static inline void switch_mm_cid(struct task_struct *prev, struct task_struc=
t *next) { }
 #endif /* !CONFIG_SCHED_MM_CID */

