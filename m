Return-Path: <linux-tip-commits+bounces-7407-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 66377C73AB2
	for <lists+linux-tip-commits@lfdr.de>; Thu, 20 Nov 2025 12:19:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id DE776354A32
	for <lists+linux-tip-commits@lfdr.de>; Thu, 20 Nov 2025 11:19:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C388B30215D;
	Thu, 20 Nov 2025 11:19:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="BqysWaR1";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="WBz7Jeql"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACE9E2868B2;
	Thu, 20 Nov 2025 11:19:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763637593; cv=none; b=E3bAkhRHiz7eD6xZOV4k1Sn3PoyI+n4pcS8thA6I3r0gmtpzpuk1RWAxuCDknrCC0ZSzQBHx6ryoqYLHM1WJBu/CYE+dH8xCA+XznVDSu1bevijmquoIQvnK+mxzu4wLS+QgMpyArQhUEdLcSfSkSrsvqGP0GdJaWIX1m5Db3bc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763637593; c=relaxed/simple;
	bh=PouCTN2LvAptkJ7YPfP705hWAOs/pVH3sQA242sw2As=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=q5Tsq8kIUzZXBOIi+UiiceYT4dAUjhMDwKWl5Jc7Ac89oOpjZBwvNDzU+B8N0nCI3f+T4WkiWDnJ+DWVOidb8Cz/+l/jB3loPgsMwZZxAgr0n1EI49USVVYu+9uJvwtmJyLa3Wz5JuSMyEkd8HokjrBy4GdqreTsoqhGryuB+GE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=BqysWaR1; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=WBz7Jeql; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 20 Nov 2025 11:19:48 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1763637589;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=05TsNoVgS1sjQE975NV0BwAO+m3eWHRobS3Jb4GI3EM=;
	b=BqysWaR1+I6utB+Wdzq5UfKPvOwQ32wUD/z37LM/+8kxR5CbVV34nMx3Rmayy6Y/tv0YcT
	adhAaenM2V8Cn0esHisQ1nDgpZz79N7DFfDV6DSVlgEJZiUINiS+Hd9cmWh1Mx5NouTrxj
	jKcF9Re1RDzKPoy25y8b8If7sOPMPa7S1mmTmT5zXnp5HKQd3jNuEgRqEpPaX0yz+5VIJE
	g3x0xPHfeILHpw7ukr8dPifGX1V5aQdK2X//Mo1V6TzAEm7WqXyEB9MqLnTlmFn6dTtGTS
	6h+iy3CqJ60xLQNE/tDzkACuAhIXKFWai8P2Qbs6j5ck5cjHxqvWrwChbHA61w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1763637589;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=05TsNoVgS1sjQE975NV0BwAO+m3eWHRobS3Jb4GI3EM=;
	b=WBz7Jeql14JbFHtcv7E/msqOn5jaXnxVTCO5pBpX9iCDHN1cHyVHStD7XofZzmkEljPCfj
	pfJhF9vrrdALm0DA==
From: "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: core/rseq] sched/mmcid: Switch over to the new mechanism
Cc: Thomas Gleixner <tglx@linutronix.de>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20251119172550.280380631@linutronix.de>
References: <20251119172550.280380631@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176363758801.498.6854903357245846077.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the core/rseq branch of tip:

Commit-ID:     2635fb0f0973c57c45f03708d52e827ec99ac78e
Gitweb:        https://git.kernel.org/tip/2635fb0f0973c57c45f03708d52e827ec99=
ac78e
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Wed, 19 Nov 2025 18:27:22 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Thu, 20 Nov 2025 12:14:58 +01:00

sched/mmcid: Switch over to the new mechanism

Now that all pieces are in place, change the implementations of
sched_mm_cid_fork() and sched_mm_cid_exit() to adhere to the new strict
ownership scheme and switch context_switch() over to use the new
mm_cid_schedin() functionality.

The common case is that there is no mode change required, which makes
fork() and exit() just update the user count and the constraints.

In case that a new user would exceed the CID space limit the fork() context
handles the transition to per CPU mode with mm::mm_cid::mutex held. exit()
handles the transition back to per task mode when the user count drops
below the switch back threshold. fork() might also be forced to handle a
deferred switch back to per task mode, when a affinity change increased the
number of allowed CPUs enough.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Link: https://patch.msgid.link/20251119172550.280380631@linutronix.de
---
 include/linux/rseq.h       |  19 +------
 include/linux/rseq_types.h |   8 +--
 kernel/fork.c              |   1 +-
 kernel/sched/core.c        | 115 ++++++++++++++++++++++++++++++------
 kernel/sched/sched.h       |  76 +------------------------
 5 files changed, 103 insertions(+), 116 deletions(-)

diff --git a/include/linux/rseq.h b/include/linux/rseq.h
index 4c0e8bd..2266f4d 100644
--- a/include/linux/rseq.h
+++ b/include/linux/rseq.h
@@ -84,24 +84,6 @@ static __always_inline void rseq_sched_set_ids_changed(str=
uct task_struct *t)
 	t->rseq.event.ids_changed =3D true;
 }
=20
-/*
- * Invoked from switch_mm_cid() in context switch when the task gets a MM
- * CID assigned.
- *
- * This does not raise TIF_NOTIFY_RESUME as that happens in
- * rseq_sched_switch_event().
- */
-static __always_inline void rseq_sched_set_task_mm_cid(struct task_struct *t=
, unsigned int cid)
-{
-	/*
-	 * Requires a comparison as the switch_mm_cid() code does not
-	 * provide a conditional for it readily. So avoid excessive updates
-	 * when nothing changes.
-	 */
-	if (t->rseq.ids.mm_cid !=3D cid)
-		t->rseq.event.ids_changed =3D true;
-}
-
 /* Enforce a full update after RSEQ registration and when execve() failed */
 static inline void rseq_force_update(void)
 {
@@ -169,7 +151,6 @@ static inline void rseq_handle_slowpath(struct pt_regs *r=
egs) { }
 static inline void rseq_signal_deliver(struct ksignal *ksig, struct pt_regs =
*regs) { }
 static inline void rseq_sched_switch_event(struct task_struct *t) { }
 static inline void rseq_sched_set_ids_changed(struct task_struct *t) { }
-static inline void rseq_sched_set_task_mm_cid(struct task_struct *t, unsigne=
d int cid) { }
 static inline void rseq_force_update(void) { }
 static inline void rseq_virt_userspace_exit(void) { }
 static inline void rseq_fork(struct task_struct *t, u64 clone_flags) { }
diff --git a/include/linux/rseq_types.h b/include/linux/rseq_types.h
index 81fbb88..332dc14 100644
--- a/include/linux/rseq_types.h
+++ b/include/linux/rseq_types.h
@@ -101,18 +101,18 @@ struct rseq_data { };
 /**
  * struct sched_mm_cid - Storage for per task MM CID data
  * @active:	MM CID is active for the task
- * @cid:	The CID associated to the task
- * @last_cid:	The last CID associated to the task
+ * @cid:	The CID associated to the task either permanently or
+ *		borrowed from the CPU
  */
 struct sched_mm_cid {
 	unsigned int		active;
 	unsigned int		cid;
-	unsigned int		last_cid;
 };
=20
 /**
  * struct mm_cid_pcpu - Storage for per CPU MM_CID data
- * @cid:	The CID associated to the CPU
+ * @cid:	The CID associated to the CPU either permanently or
+ *		while a task with a CID is running
  */
 struct mm_cid_pcpu {
 	unsigned int	cid;
diff --git a/kernel/fork.c b/kernel/fork.c
index 6c23219..8475958 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -956,7 +956,6 @@ static struct task_struct *dup_task_struct(struct task_st=
ruct *orig, int node)
=20
 #ifdef CONFIG_SCHED_MM_CID
 	tsk->mm_cid.cid =3D MM_CID_UNSET;
-	tsk->mm_cid.last_cid =3D MM_CID_UNSET;
 	tsk->mm_cid.active =3D 0;
 #endif
 	return tsk;
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 938757e..72f368f 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -5307,7 +5307,7 @@ context_switch(struct rq *rq, struct task_struct *prev,
 		}
 	}
=20
-	switch_mm_cid(prev, next);
+	mm_cid_switch_to(prev, next);
=20
 	/*
 	 * Tell rseq that the task was scheduled in. Must be after
@@ -10623,7 +10623,7 @@ static bool mm_cid_fixup_task_to_cpu(struct task_stru=
ct *t, struct mm_struct *mm
 	return true;
 }
=20
-static void __maybe_unused mm_cid_fixup_tasks_to_cpus(void)
+static void mm_cid_fixup_tasks_to_cpus(void)
 {
 	struct mm_struct *mm =3D current->mm;
 	struct task_struct *p, *t;
@@ -10673,25 +10673,81 @@ static bool sched_mm_cid_add_user(struct task_struc=
t *t, struct mm_struct *mm)
 void sched_mm_cid_fork(struct task_struct *t)
 {
 	struct mm_struct *mm =3D t->mm;
+	bool percpu;
=20
 	WARN_ON_ONCE(!mm || t->mm_cid.cid !=3D MM_CID_UNSET);
=20
 	guard(mutex)(&mm->mm_cid.mutex);
-	scoped_guard(raw_spinlock, &mm->mm_cid.lock) {
-		sched_mm_cid_add_user(t, mm);
-		/* Preset last_cid for mm_cid_select() */
-		t->mm_cid.last_cid =3D mm->mm_cid.max_cids - 1;
+	scoped_guard(raw_spinlock_irq, &mm->mm_cid.lock) {
+		struct mm_cid_pcpu *pcp =3D this_cpu_ptr(mm->mm_cid.pcpu);
+
+		/* First user ? */
+		if (!mm->mm_cid.users) {
+			sched_mm_cid_add_user(t, mm);
+			t->mm_cid.cid =3D mm_get_cid(mm);
+			/* Required for execve() */
+			pcp->cid =3D t->mm_cid.cid;
+			return;
+		}
+
+		if (!sched_mm_cid_add_user(t, mm)) {
+			if (!mm->mm_cid.percpu)
+				t->mm_cid.cid =3D mm_get_cid(mm);
+			return;
+		}
+
+		/* Handle the mode change and transfer current's CID */
+		percpu =3D !!mm->mm_cid.percpu;
+		if (!percpu)
+			mm_cid_transit_to_task(current, pcp);
+		else
+			mm_cid_transfer_to_cpu(current, pcp);
+	}
+
+	if (percpu) {
+		mm_cid_fixup_tasks_to_cpus();
+	} else {
+		mm_cid_fixup_cpus_to_tasks(mm);
+		t->mm_cid.cid =3D mm_get_cid(mm);
 	}
 }
=20
 static bool sched_mm_cid_remove_user(struct task_struct *t)
 {
 	t->mm_cid.active =3D 0;
-	mm_unset_cid_on_task(t);
+	scoped_guard(preempt) {
+		/* Clear the transition bit */
+		t->mm_cid.cid =3D cid_from_transit_cid(t->mm_cid.cid);
+		mm_unset_cid_on_task(t);
+	}
 	t->mm->mm_cid.users--;
 	return mm_update_max_cids(t->mm);
 }
=20
+static bool __sched_mm_cid_exit(struct task_struct *t)
+{
+	struct mm_struct *mm =3D t->mm;
+
+	if (!sched_mm_cid_remove_user(t))
+		return false;
+	/*
+	 * Contrary to fork() this only deals with a switch back to per
+	 * task mode either because the above decreased users or an
+	 * affinity change increased the number of allowed CPUs and the
+	 * deferred fixup did not run yet.
+	 */
+	if (WARN_ON_ONCE(mm->mm_cid.percpu))
+		return false;
+	/*
+	 * A failed fork(2) cleanup never gets here, so @current must have
+	 * the same MM as @t. That's true for exit() and the failed
+	 * pthread_create() cleanup case.
+	 */
+	if (WARN_ON_ONCE(current->mm !=3D mm))
+		return false;
+	return true;
+}
+
 /*
  * When a task exits, the MM CID held by the task is not longer required as
  * the task cannot return to user space.
@@ -10702,10 +10758,43 @@ void sched_mm_cid_exit(struct task_struct *t)
=20
 	if (!mm || !t->mm_cid.active)
 		return;
+	/*
+	 * Ensure that only one instance is doing MM CID operations within
+	 * a MM. The common case is uncontended. The rare fixup case adds
+	 * some overhead.
+	 */
+	scoped_guard(mutex, &mm->mm_cid.mutex) {
+		/* mm_cid::mutex is sufficient to protect mm_cid::users */
+		if (likely(mm->mm_cid.users > 1)) {
+			scoped_guard(raw_spinlock_irq, &mm->mm_cid.lock) {
+				if (!__sched_mm_cid_exit(t))
+					return;
+				/* Mode change required. Transfer currents CID */
+				mm_cid_transit_to_task(current, this_cpu_ptr(mm->mm_cid.pcpu));
+			}
+			mm_cid_fixup_cpus_to_tasks(mm);
+			return;
+		}
+		/* Last user */
+		scoped_guard(raw_spinlock_irq, &mm->mm_cid.lock) {
+			/* Required across execve() */
+			if (t =3D=3D current)
+				mm_cid_transit_to_task(t, this_cpu_ptr(mm->mm_cid.pcpu));
+			/* Ignore mode change. There is nothing to do. */
+			sched_mm_cid_remove_user(t);
+		}
+	}
=20
-	guard(mutex)(&mm->mm_cid.mutex);
-	scoped_guard(raw_spinlock, &mm->mm_cid.lock)
-		sched_mm_cid_remove_user(t);
+	/*
+	 * As this is the last user (execve(), process exit or failed
+	 * fork(2)) there is no concurrency anymore.
+	 *
+	 * Synchronize eventually pending work to ensure that there are no
+	 * dangling references left. @t->mm_cid.users is zero so nothing
+	 * can queue this work anymore.
+	 */
+	irq_work_sync(&mm->mm_cid.irq_work);
+	cancel_work_sync(&mm->mm_cid.work);
 }
=20
 /* Deactivate MM CID allocation across execve() */
@@ -10718,18 +10807,12 @@ void sched_mm_cid_before_execve(struct task_struct =
*t)
 void sched_mm_cid_after_execve(struct task_struct *t)
 {
 	sched_mm_cid_fork(t);
-	guard(preempt)();
-	mm_cid_select(t);
 }
=20
 static void mm_cid_work_fn(struct work_struct *work)
 {
 	struct mm_struct *mm =3D container_of(work, struct mm_struct, mm_cid.work);
=20
-	/* Make it compile, but not functional yet */
-	if (!IS_ENABLED(CONFIG_NEW_MM_CID))
-		return;
-
 	guard(mutex)(&mm->mm_cid.mutex);
 	/* Did the last user task exit already? */
 	if (!mm->mm_cid.users)
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 82c7978..f9d0515 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -3745,83 +3745,7 @@ static inline void mm_cid_switch_to(struct task_struct=
 *prev, struct task_struct
 	mm_cid_schedin(next);
 }
=20
-/* Active implementation */
-static inline void init_sched_mm_cid(struct task_struct *t)
-{
-	struct mm_struct *mm =3D t->mm;
-	unsigned int max_cid;
-
-	if (!mm)
-		return;
-
-	/* Preset last_mm_cid */
-	max_cid =3D min_t(int, READ_ONCE(mm->mm_cid.nr_cpus_allowed), atomic_read(&=
mm->mm_users));
-	t->mm_cid.last_cid =3D max_cid - 1;
-}
-
-static inline bool __mm_cid_get(struct task_struct *t, unsigned int cid, uns=
igned int max_cids)
-{
-	struct mm_struct *mm =3D t->mm;
-
-	if (cid >=3D max_cids)
-		return false;
-	if (test_and_set_bit(cid, mm_cidmask(mm)))
-		return false;
-	t->mm_cid.cid =3D t->mm_cid.last_cid =3D cid;
-	__this_cpu_write(mm->mm_cid.pcpu->cid, cid);
-	return true;
-}
-
-static inline bool mm_cid_get(struct task_struct *t)
-{
-	struct mm_struct *mm =3D t->mm;
-	unsigned int max_cids;
-
-	max_cids =3D READ_ONCE(mm->mm_cid.max_cids);
-
-	/* Try to reuse the last CID of this task */
-	if (__mm_cid_get(t, t->mm_cid.last_cid, max_cids))
-		return true;
-
-	/* Try to reuse the last CID of this mm on this CPU */
-	if (__mm_cid_get(t, __this_cpu_read(mm->mm_cid.pcpu->cid), max_cids))
-		return true;
-
-	/* Try the first zero bit in the cidmask. */
-	return __mm_cid_get(t, find_first_zero_bit(mm_cidmask(mm), num_possible_cpu=
s()), max_cids);
-}
-
-static inline void mm_cid_select(struct task_struct *t)
-{
-	/*
-	 * mm_cid_get() can fail when the maximum CID, which is determined
-	 * by min(mm->nr_cpus_allowed, mm->mm_users) changes concurrently.
-	 * That's a transient failure as there cannot be more tasks
-	 * concurrently on a CPU (or about to be scheduled in) than that.
-	 */
-	for (;;) {
-		if (mm_cid_get(t))
-			break;
-	}
-}
-
-static inline void switch_mm_cid(struct task_struct *prev, struct task_struc=
t *next)
-{
-	if (prev->mm_cid.active) {
-		if (prev->mm_cid.cid !=3D MM_CID_UNSET)
-			clear_bit(prev->mm_cid.cid, mm_cidmask(prev->mm));
-		prev->mm_cid.cid =3D MM_CID_UNSET;
-	}
-
-	if (next->mm_cid.active) {
-		mm_cid_select(next);
-		rseq_sched_set_task_mm_cid(next, next->mm_cid.cid);
-	}
-}
-
 #else /* !CONFIG_SCHED_MM_CID: */
-static inline void mm_cid_select(struct task_struct *t) { }
-static inline void switch_mm_cid(struct task_struct *prev, struct task_struc=
t *next) { }
 static inline void mm_cid_switch_to(struct task_struct *prev, struct task_st=
ruct *next) { }
 #endif /* !CONFIG_SCHED_MM_CID */
=20

