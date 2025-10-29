Return-Path: <linux-tip-commits+bounces-7058-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AE60C19B57
	for <lists+linux-tip-commits@lfdr.de>; Wed, 29 Oct 2025 11:26:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B841A5055DE
	for <lists+linux-tip-commits@lfdr.de>; Wed, 29 Oct 2025 10:25:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FE0E33030E;
	Wed, 29 Oct 2025 10:23:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="GbQ3RNt/";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="4seewnRX"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A93C931A810;
	Wed, 29 Oct 2025 10:23:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761733418; cv=none; b=Xsd206CtKn2U+/BvptU5T58DEtPaBp+jZmzCmZ3nD9NKFtq/dMV43A3IKuSye4iKqEJ3xURdlVgq+msZMlpmUBfBcequ7Ym7Jv7gz0LbgpI9oyGTRdMELyO4nVL5tUyeGOdDhp5/Rs7OHaz66l5HDiMW2m80KWfQOTElP1SV/T4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761733418; c=relaxed/simple;
	bh=JYmmoT49PsC3HlAO6mSivimIgLUr4XlsgREma6581DA=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=rSkGDGbSIkfCeeO/HRj7rPAc5TDnWW27vFYTetPJ69MZOHHmuYdZM3kOe46iaguYpXBcXScmhigKEnF4NauqFzrCNJBspGAdXiDZtfx9JT+ybtuCrBrFYHig7TjGmtV95q4jyeU/Aie9ivWD/jURlWooaIxwvIPlGE8FjFKp4/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=GbQ3RNt/; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=4seewnRX; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 29 Oct 2025 10:23:32 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1761733413;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=H3oYCFrE+PDOeXc+kZSwwqF/C1UsiWFBAuDJce6yjFY=;
	b=GbQ3RNt/LXjm3CyzyZo3oK30NImbcA+SBDS4n362RuywKCTKpyQHLITvxefE170WGN/5sF
	G4yhD/271qssD45v6HtrLCkwQ4a1WIdkCZTZFwZssjlTWAzJUoXNECMvmGqEqFcg+Y42b2
	Z70FM6w6zB4Y5F56B6dE/So9mKRqHFV41ZCAXmxl/iIfZ7XGB9ve1FueOwWd+uc2y4fhhs
	+d2Ku4jlxDBj8ojRMitqjzJdy995vNRY75Wr9sfw6YdBBoOBwJXXiEgpUM/b8ozXBfe5VM
	jC3PHTiFqEPNMHRfkDUnB09fy/8Q+alvGOktGzQBDB+1qkt0qrUQzcAccgiI8Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1761733413;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=H3oYCFrE+PDOeXc+kZSwwqF/C1UsiWFBAuDJce6yjFY=;
	b=4seewnRXUkoYAqP+B1BMXNEIFU/e2JzDueUP1GQ+OoBpKwkxbz3YLqOl6gyifan6ojUt26
	PkfZVwiUbuM0E5Cg==
From: "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: core/rseq] rseq: Optimize event setting
Cc: Thomas Gleixner <tglx@linutronix.de>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20251027084307.578058898@linutronix.de>
References: <20251027084307.578058898@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176173341249.2601451.8235169454616762014.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the core/rseq branch of tip:

Commit-ID:     ea7a1cb200defdbbdf1ae99405f0eaefe433eb2d
Gitweb:        https://git.kernel.org/tip/ea7a1cb200defdbbdf1ae99405f0eaefe43=
3eb2d
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Mon, 27 Oct 2025 09:45:14 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 29 Oct 2025 11:07:19 +01:00

rseq: Optimize event setting

After removing the various condition bits earlier it turns out that one
extra information is needed to avoid setting event::sched_switch and
TIF_NOTIFY_RESUME unconditionally on every context switch.

The update of the RSEQ user space memory is only required, when either

  the task was interrupted in user space and schedules

or

  the CPU or MM CID changes in schedule() independent of the entry mode

Right now only the interrupt from user information is available.

Add an event flag, which is set when the CPU or MM CID or both change.

Evaluate this event in the scheduler to decide whether the sched_switch
event and the TIF bit need to be set.

It's an extra conditional in context_switch(), but the downside of
unconditionally handling RSEQ after a context switch to user is way more
significant. The utilized boolean logic minimizes this to a single
conditional branch.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Link: https://patch.msgid.link/20251027084307.578058898@linutronix.de
---
 fs/exec.c                  |  2 +-
 include/linux/rseq.h       | 81 +++++++++++++++++++++++++++++++++----
 include/linux/rseq_types.h | 11 ++++-
 kernel/rseq.c              |  2 +-
 kernel/sched/core.c        |  7 ++-
 kernel/sched/sched.h       |  5 +-
 6 files changed, 95 insertions(+), 13 deletions(-)

diff --git a/fs/exec.c b/fs/exec.c
index e45b298..90e47eb 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -1775,7 +1775,7 @@ out:
 		force_fatal_sig(SIGSEGV);
=20
 	sched_mm_cid_after_execve(current);
-	rseq_sched_switch_event(current);
+	rseq_force_update();
 	current->in_execve =3D 0;
=20
 	return retval;
diff --git a/include/linux/rseq.h b/include/linux/rseq.h
index 06c21f6..684b5bd 100644
--- a/include/linux/rseq.h
+++ b/include/linux/rseq.h
@@ -11,7 +11,8 @@ void __rseq_handle_notify_resume(struct pt_regs *regs);
=20
 static inline void rseq_handle_notify_resume(struct pt_regs *regs)
 {
-	if (current->rseq.event.has_rseq)
+	/* '&' is intentional to spare one conditional branch */
+	if (current->rseq.event.sched_switch & current->rseq.event.has_rseq)
 		__rseq_handle_notify_resume(regs);
 }
=20
@@ -33,12 +34,75 @@ static inline void rseq_signal_deliver(struct ksignal *ks=
ig, struct pt_regs *reg
 	}
 }
=20
-/* Raised from context switch and exevce to force evaluation on exit to user=
 */
-static inline void rseq_sched_switch_event(struct task_struct *t)
+static inline void rseq_raise_notify_resume(struct task_struct *t)
 {
-	if (t->rseq.event.has_rseq) {
-		t->rseq.event.sched_switch =3D true;
-		set_tsk_thread_flag(t, TIF_NOTIFY_RESUME);
+	set_tsk_thread_flag(t, TIF_NOTIFY_RESUME);
+}
+
+/* Invoked from context switch to force evaluation on exit to user */
+static __always_inline void rseq_sched_switch_event(struct task_struct *t)
+{
+	struct rseq_event *ev =3D &t->rseq.event;
+
+	if (IS_ENABLED(CONFIG_GENERIC_IRQ_ENTRY)) {
+		/*
+		 * Avoid a boat load of conditionals by using simple logic
+		 * to determine whether NOTIFY_RESUME needs to be raised.
+		 *
+		 * It's required when the CPU or MM CID has changed or
+		 * the entry was from user space.
+		 */
+		bool raise =3D (ev->user_irq | ev->ids_changed) & ev->has_rseq;
+
+		if (raise) {
+			ev->sched_switch =3D true;
+			rseq_raise_notify_resume(t);
+		}
+	} else {
+		if (ev->has_rseq) {
+			t->rseq.event.sched_switch =3D true;
+			rseq_raise_notify_resume(t);
+		}
+	}
+}
+
+/*
+ * Invoked from __set_task_cpu() when a task migrates to enforce an IDs
+ * update.
+ *
+ * This does not raise TIF_NOTIFY_RESUME as that happens in
+ * rseq_sched_switch_event().
+ */
+static __always_inline void rseq_sched_set_task_cpu(struct task_struct *t, u=
nsigned int cpu)
+{
+	t->rseq.event.ids_changed =3D true;
+}
+
+/*
+ * Invoked from switch_mm_cid() in context switch when the task gets a MM
+ * CID assigned.
+ *
+ * This does not raise TIF_NOTIFY_RESUME as that happens in
+ * rseq_sched_switch_event().
+ */
+static __always_inline void rseq_sched_set_task_mm_cid(struct task_struct *t=
, unsigned int cid)
+{
+	/*
+	 * Requires a comparison as the switch_mm_cid() code does not
+	 * provide a conditional for it readily. So avoid excessive updates
+	 * when nothing changes.
+	 */
+	if (t->rseq.ids.mm_cid !=3D cid)
+		t->rseq.event.ids_changed =3D true;
+}
+
+/* Enforce a full update after RSEQ registration and when execve() failed */
+static inline void rseq_force_update(void)
+{
+	if (current->rseq.event.has_rseq) {
+		current->rseq.event.ids_changed =3D true;
+		current->rseq.event.sched_switch =3D true;
+		rseq_raise_notify_resume(current);
 	}
 }
=20
@@ -55,7 +119,7 @@ static inline void rseq_sched_switch_event(struct task_str=
uct *t)
 static inline void rseq_virt_userspace_exit(void)
 {
 	if (current->rseq.event.sched_switch)
-		set_tsk_thread_flag(current, TIF_NOTIFY_RESUME);
+		rseq_raise_notify_resume(current);
 }
=20
 static inline void rseq_reset(struct task_struct *t)
@@ -91,6 +155,9 @@ static inline void rseq_fork(struct task_struct *t, u64 cl=
one_flags)
 static inline void rseq_handle_notify_resume(struct ksignal *ksig, struct pt=
_regs *regs) { }
 static inline void rseq_signal_deliver(struct ksignal *ksig, struct pt_regs =
*regs) { }
 static inline void rseq_sched_switch_event(struct task_struct *t) { }
+static inline void rseq_sched_set_task_cpu(struct task_struct *t, unsigned i=
nt cpu) { }
+static inline void rseq_sched_set_task_mm_cid(struct task_struct *t, unsigne=
d int cid) { }
+static inline void rseq_force_update(void) { }
 static inline void rseq_virt_userspace_exit(void) { }
 static inline void rseq_fork(struct task_struct *t, u64 clone_flags) { }
 static inline void rseq_execve(struct task_struct *t) { }
diff --git a/include/linux/rseq_types.h b/include/linux/rseq_types.h
index 7c12394..a1389ff 100644
--- a/include/linux/rseq_types.h
+++ b/include/linux/rseq_types.h
@@ -11,20 +11,27 @@ struct rseq;
  * struct rseq_event - Storage for rseq related event management
  * @all:		Compound to initialize and clear the data efficiently
  * @events:		Compound to access events with a single load/store
- * @sched_switch:	True if the task was scheduled out
+ * @sched_switch:	True if the task was scheduled and needs update on
+ *			exit to user
+ * @ids_changed:	Indicator that IDs need to be updated
  * @user_irq:		True on interrupt entry from user mode
  * @has_rseq:		True if the task has a rseq pointer installed
  * @error:		Compound error code for the slow path to analyze
  * @fatal:		User space data corrupted or invalid
+ *
+ * @sched_switch and @ids_changed must be adjacent and the combo must be
+ * 16bit aligned to allow a single store, when both are set at the same
+ * time in the scheduler.
  */
 struct rseq_event {
 	union {
 		u64				all;
 		struct {
 			union {
-				u16		events;
+				u32		events;
 				struct {
 					u8	sched_switch;
+					u8	ids_changed;
 					u8	user_irq;
 				};
 			};
diff --git a/kernel/rseq.c b/kernel/rseq.c
index cbb1ab4..857fe61 100644
--- a/kernel/rseq.c
+++ b/kernel/rseq.c
@@ -464,7 +464,7 @@ SYSCALL_DEFINE4(rseq, struct rseq __user *, rseq, u32, rs=
eq_len, int, flags, u32
 	 * are updated before returning to user-space.
 	 */
 	current->rseq.event.has_rseq =3D true;
-	rseq_sched_switch_event(current);
+	rseq_force_update();
 	return 0;
=20
 efault:
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index b75e8e1..579a8e9 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -5118,7 +5118,6 @@ prepare_task_switch(struct rq *rq, struct task_struct *=
prev,
 	kcov_prepare_switch(prev);
 	sched_info_switch(rq, prev, next);
 	perf_event_task_sched_out(prev, next);
-	rseq_sched_switch_event(prev);
 	fire_sched_out_preempt_notifiers(prev, next);
 	kmap_local_sched_out();
 	prepare_task(next);
@@ -5316,6 +5315,12 @@ context_switch(struct rq *rq, struct task_struct *prev,
 	/* switch_mm_cid() requires the memory barriers above. */
 	switch_mm_cid(rq, prev, next);
=20
+	/*
+	 * Tell rseq that the task was scheduled in. Must be after
+	 * switch_mm_cid() to get the TIF flag set.
+	 */
+	rseq_sched_switch_event(next);
+
 	prepare_lock_switch(rq, next, rf);
=20
 	/* Here we just switch the register state and the stack. */
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 361f910..7fe961d 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -2208,6 +2208,7 @@ static inline void __set_task_cpu(struct task_struct *p=
, unsigned int cpu)
 	smp_wmb();
 	WRITE_ONCE(task_thread_info(p)->cpu, cpu);
 	p->wake_cpu =3D cpu;
+	rseq_sched_set_task_cpu(p, cpu);
 #endif /* CONFIG_SMP */
 }
=20
@@ -3806,8 +3807,10 @@ static inline void switch_mm_cid(struct rq *rq,
 		mm_cid_put_lazy(prev);
 		prev->mm_cid =3D -1;
 	}
-	if (next->mm_cid_active)
+	if (next->mm_cid_active) {
 		next->last_mm_cid =3D next->mm_cid =3D mm_cid_get(rq, next, next->mm);
+		rseq_sched_set_task_mm_cid(next, next->mm_cid);
+	}
 }
=20
 #else /* !CONFIG_SCHED_MM_CID: */

