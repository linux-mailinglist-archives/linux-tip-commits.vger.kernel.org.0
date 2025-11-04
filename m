Return-Path: <linux-tip-commits+bounces-7247-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 31299C2FD5E
	for <lists+linux-tip-commits@lfdr.de>; Tue, 04 Nov 2025 09:23:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E13101887E2A
	for <lists+linux-tip-commits@lfdr.de>; Tue,  4 Nov 2025 08:22:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3919D320A08;
	Tue,  4 Nov 2025 08:17:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="bqGSAnLz";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="FQtkTQY5"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 230E2320A0B;
	Tue,  4 Nov 2025 08:17:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762244263; cv=none; b=fcdvVLPjg10YbwBYS0a3+UTenpE0cAvuHmUSf/WvIO7dkXL2lZwQWleS3gfnAhhwOROIw4JcvcuabpWN7QGvmXfvBBzzN2J7yPzqADq4vphPahMf6RsEpb0oGHpk5aFBdmt1+Hgi9VUju3T+6xpVkiK6lezz+VQMLQ3L9JUJzfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762244263; c=relaxed/simple;
	bh=nJTWeufI4aRxftVBuFoHUq5n0GC1DF7neqNqlR7tTFc=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=KQa6drWLQrj360+6s1PRMU3sn38feNHezapXfka+64cJxEfolKWlFxQGH08ShVc0sjp3ARlgLTHHM/X84YXjLX3J4KSHMcYZWDjjJ1xi8oMm9ieLjh4v9HBI3yjogbp0fya0KRFezbS/I+IgU8KeNMmTQsTUKeLtlnwhhwSCCms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=bqGSAnLz; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=FQtkTQY5; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 04 Nov 2025 08:17:36 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1762244258;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3lPsIMttJFXAcvBol3nLNexrZqsDq15nssUsFkmCjqc=;
	b=bqGSAnLzbX4DoDgkCaEgBIM6E86ExmTD5Grm61YCUk3TznDs0rkPHGM2i4ip+KAm5yz0a/
	7Cq9BCtwOTuTJ3GXQ2Qb6IsKbgjbgS3tS5RuRxlHPE/kA3YBpLZQa2pZ3ObA2g5YF9IAUn
	EYemTrA6wel64EFUA+CI3ehnRPdyxj4aaWv2ah+AvivkY+3VLjigjWqc88MPChjSl0CO89
	tSQj486f98OfYCSMygCg6QSccPy2f20zubEHChAxg3eiOQDD/Yvy3GOpFWVkNvu+SXRzQk
	4v/ZAnsgq5+g9Vwqr6DK3bXIJSl5BjpO8uOt8/N2FTAwInM+eiNwBngXTY1M7Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1762244258;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3lPsIMttJFXAcvBol3nLNexrZqsDq15nssUsFkmCjqc=;
	b=FQtkTQY5KMPxKWwMBb+0WLFFp4QrVikqLcOaiawQ6gFisFYTAxflRkCtyLGpIfYn50unBa
	ik0tN12KrMYYq5Ag==
From: "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: core/rseq] rseq: Simplify the event notification
Cc: Thomas Gleixner <tglx@linutronix.de>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Ingo Molnar <mingo@kernel.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20251027084306.336978188@linutronix.de>
References: <20251027084306.336978188@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176224425687.2601451.15901512223352702586.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the core/rseq branch of tip:

Commit-ID:     d923739e2e356424cc566143a3323c62cd6ed067
Gitweb:        https://git.kernel.org/tip/d923739e2e356424cc566143a3323c62cd6=
ed067
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Mon, 27 Oct 2025 09:44:26 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 04 Nov 2025 08:30:09 +01:00

rseq: Simplify the event notification

Since commit 0190e4198e47 ("rseq: Deprecate RSEQ_CS_FLAG_NO_RESTART_ON_*
flags") the bits in task::rseq_event_mask are meaningless and just extra
work in terms of setting them individually.

Aside of that the only relevant point where an event has to be raised is
context switch. Neither the CPU nor MM CID can change without going through
a context switch.

Collapse them all into a single boolean which simplifies the code a lot and
remove the pointless invocations which have been sprinkled all over the
place for no value.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Reviewed-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Link: https://patch.msgid.link/20251027084306.336978188@linutronix.de
---
 fs/exec.c                 |  2 +-
 include/linux/rseq.h      | 66 +++++++-------------------------------
 include/linux/sched.h     | 10 +++---
 include/uapi/linux/rseq.h | 21 ++++--------
 kernel/rseq.c             | 28 +++++++++-------
 kernel/sched/core.c       |  5 +---
 kernel/sched/membarrier.c |  8 ++---
 7 files changed, 48 insertions(+), 92 deletions(-)

diff --git a/fs/exec.c b/fs/exec.c
index 4298e7e..e45b298 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -1775,7 +1775,7 @@ out:
 		force_fatal_sig(SIGSEGV);
=20
 	sched_mm_cid_after_execve(current);
-	rseq_set_notify_resume(current);
+	rseq_sched_switch_event(current);
 	current->in_execve =3D 0;
=20
 	return retval;
diff --git a/include/linux/rseq.h b/include/linux/rseq.h
index d72ddf7..241067b 100644
--- a/include/linux/rseq.h
+++ b/include/linux/rseq.h
@@ -3,38 +3,8 @@
 #define _LINUX_RSEQ_H
=20
 #ifdef CONFIG_RSEQ
-
-#include <linux/preempt.h>
 #include <linux/sched.h>
=20
-#ifdef CONFIG_MEMBARRIER
-# define RSEQ_EVENT_GUARD	irq
-#else
-# define RSEQ_EVENT_GUARD	preempt
-#endif
-
-/*
- * Map the event mask on the user-space ABI enum rseq_cs_flags
- * for direct mask checks.
- */
-enum rseq_event_mask_bits {
-	RSEQ_EVENT_PREEMPT_BIT	=3D RSEQ_CS_FLAG_NO_RESTART_ON_PREEMPT_BIT,
-	RSEQ_EVENT_SIGNAL_BIT	=3D RSEQ_CS_FLAG_NO_RESTART_ON_SIGNAL_BIT,
-	RSEQ_EVENT_MIGRATE_BIT	=3D RSEQ_CS_FLAG_NO_RESTART_ON_MIGRATE_BIT,
-};
-
-enum rseq_event_mask {
-	RSEQ_EVENT_PREEMPT	=3D (1U << RSEQ_EVENT_PREEMPT_BIT),
-	RSEQ_EVENT_SIGNAL	=3D (1U << RSEQ_EVENT_SIGNAL_BIT),
-	RSEQ_EVENT_MIGRATE	=3D (1U << RSEQ_EVENT_MIGRATE_BIT),
-};
-
-static inline void rseq_set_notify_resume(struct task_struct *t)
-{
-	if (t->rseq)
-		set_tsk_thread_flag(t, TIF_NOTIFY_RESUME);
-}
-
 void __rseq_handle_notify_resume(struct ksignal *sig, struct pt_regs *regs);
=20
 static inline void rseq_handle_notify_resume(struct pt_regs *regs)
@@ -43,35 +13,27 @@ static inline void rseq_handle_notify_resume(struct pt_re=
gs *regs)
 		__rseq_handle_notify_resume(NULL, regs);
 }
=20
-static inline void rseq_signal_deliver(struct ksignal *ksig,
-				       struct pt_regs *regs)
+static inline void rseq_signal_deliver(struct ksignal *ksig, struct pt_regs =
*regs)
 {
 	if (current->rseq) {
-		scoped_guard(RSEQ_EVENT_GUARD)
-			__set_bit(RSEQ_EVENT_SIGNAL_BIT, &current->rseq_event_mask);
+		current->rseq_event_pending =3D true;
 		__rseq_handle_notify_resume(ksig, regs);
 	}
 }
=20
-/* rseq_preempt() requires preemption to be disabled. */
-static inline void rseq_preempt(struct task_struct *t)
+static inline void rseq_sched_switch_event(struct task_struct *t)
 {
-	__set_bit(RSEQ_EVENT_PREEMPT_BIT, &t->rseq_event_mask);
-	rseq_set_notify_resume(t);
-}
-
-/* rseq_migrate() requires preemption to be disabled. */
-static inline void rseq_migrate(struct task_struct *t)
-{
-	__set_bit(RSEQ_EVENT_MIGRATE_BIT, &t->rseq_event_mask);
-	rseq_set_notify_resume(t);
+	if (t->rseq) {
+		t->rseq_event_pending =3D true;
+		set_tsk_thread_flag(t, TIF_NOTIFY_RESUME);
+	}
 }
=20
 static __always_inline void rseq_exit_to_user_mode(void)
 {
 	if (IS_ENABLED(CONFIG_DEBUG_RSEQ)) {
-		if (WARN_ON_ONCE(current->rseq && current->rseq_event_mask))
-			current->rseq_event_mask =3D 0;
+		if (WARN_ON_ONCE(current->rseq && current->rseq_event_pending))
+			current->rseq_event_pending =3D false;
 	}
 }
=20
@@ -85,12 +47,12 @@ static inline void rseq_fork(struct task_struct *t, u64 c=
lone_flags)
 		t->rseq =3D NULL;
 		t->rseq_len =3D 0;
 		t->rseq_sig =3D 0;
-		t->rseq_event_mask =3D 0;
+		t->rseq_event_pending =3D false;
 	} else {
 		t->rseq =3D current->rseq;
 		t->rseq_len =3D current->rseq_len;
 		t->rseq_sig =3D current->rseq_sig;
-		t->rseq_event_mask =3D current->rseq_event_mask;
+		t->rseq_event_pending =3D current->rseq_event_pending;
 	}
 }
=20
@@ -99,15 +61,13 @@ static inline void rseq_execve(struct task_struct *t)
 	t->rseq =3D NULL;
 	t->rseq_len =3D 0;
 	t->rseq_sig =3D 0;
-	t->rseq_event_mask =3D 0;
+	t->rseq_event_pending =3D false;
 }
=20
 #else /* CONFIG_RSEQ */
-static inline void rseq_set_notify_resume(struct task_struct *t) { }
 static inline void rseq_handle_notify_resume(struct pt_regs *regs) { }
 static inline void rseq_signal_deliver(struct ksignal *ksig, struct pt_regs =
*regs) { }
-static inline void rseq_preempt(struct task_struct *t) { }
-static inline void rseq_migrate(struct task_struct *t) { }
+static inline void rseq_sched_switch_event(struct task_struct *t) { }
 static inline void rseq_fork(struct task_struct *t, u64 clone_flags) { }
 static inline void rseq_execve(struct task_struct *t) { }
 static inline void rseq_exit_to_user_mode(void) { }
diff --git a/include/linux/sched.h b/include/linux/sched.h
index b469878..6627c52 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1407,14 +1407,14 @@ struct task_struct {
 #endif /* CONFIG_NUMA_BALANCING */
=20
 #ifdef CONFIG_RSEQ
-	struct rseq __user *rseq;
-	u32 rseq_len;
-	u32 rseq_sig;
+	struct rseq __user		*rseq;
+	u32				rseq_len;
+	u32				rseq_sig;
 	/*
-	 * RmW on rseq_event_mask must be performed atomically
+	 * RmW on rseq_event_pending must be performed atomically
 	 * with respect to preemption.
 	 */
-	unsigned long rseq_event_mask;
+	bool				rseq_event_pending;
 # ifdef CONFIG_DEBUG_RSEQ
 	/*
 	 * This is a place holder to save a copy of the rseq fields for
diff --git a/include/uapi/linux/rseq.h b/include/uapi/linux/rseq.h
index c233aae..1b76d50 100644
--- a/include/uapi/linux/rseq.h
+++ b/include/uapi/linux/rseq.h
@@ -114,20 +114,13 @@ struct rseq {
 	/*
 	 * Restartable sequences flags field.
 	 *
-	 * This field should only be updated by the thread which
-	 * registered this data structure. Read by the kernel.
-	 * Mainly used for single-stepping through rseq critical sections
-	 * with debuggers.
-	 *
-	 * - RSEQ_CS_FLAG_NO_RESTART_ON_PREEMPT
-	 *     Inhibit instruction sequence block restart on preemption
-	 *     for this thread.
-	 * - RSEQ_CS_FLAG_NO_RESTART_ON_SIGNAL
-	 *     Inhibit instruction sequence block restart on signal
-	 *     delivery for this thread.
-	 * - RSEQ_CS_FLAG_NO_RESTART_ON_MIGRATE
-	 *     Inhibit instruction sequence block restart on migration for
-	 *     this thread.
+	 * This field was initially intended to allow event masking for
+	 * single-stepping through rseq critical sections with debuggers.
+	 * The kernel does not support this anymore and the relevant bits
+	 * are checked for being always false:
+	 *	- RSEQ_CS_FLAG_NO_RESTART_ON_PREEMPT
+	 *	- RSEQ_CS_FLAG_NO_RESTART_ON_SIGNAL
+	 *	- RSEQ_CS_FLAG_NO_RESTART_ON_MIGRATE
 	 */
 	__u32 flags;
=20
diff --git a/kernel/rseq.c b/kernel/rseq.c
index 80af48a..59adc1a 100644
--- a/kernel/rseq.c
+++ b/kernel/rseq.c
@@ -78,6 +78,12 @@
 #define CREATE_TRACE_POINTS
 #include <trace/events/rseq.h>
=20
+#ifdef CONFIG_MEMBARRIER
+# define RSEQ_EVENT_GUARD	irq
+#else
+# define RSEQ_EVENT_GUARD	preempt
+#endif
+
 /* The original rseq structure size (including padding) is 32 bytes. */
 #define ORIG_RSEQ_SIZE		32
=20
@@ -430,11 +436,11 @@ void __rseq_handle_notify_resume(struct ksignal *ksig, =
struct pt_regs *regs)
 	 */
 	if (regs) {
 		/*
-		 * Read and clear the event mask first. If the task was not
-		 * preempted or migrated or a signal is on the way, there
-		 * is no point in doing any of the heavy lifting here on
-		 * production kernels. In that case TIF_NOTIFY_RESUME was
-		 * raised by some other functionality.
+		 * Read and clear the event pending bit first. If the task
+		 * was not preempted or migrated or a signal is on the way,
+		 * there is no point in doing any of the heavy lifting here
+		 * on production kernels. In that case TIF_NOTIFY_RESUME
+		 * was raised by some other functionality.
 		 *
 		 * This is correct because the read/clear operation is
 		 * guarded against scheduler preemption, which makes it CPU
@@ -447,15 +453,15 @@ void __rseq_handle_notify_resume(struct ksignal *ksig, =
struct pt_regs *regs)
 		 * with the result handed in to allow the detection of
 		 * inconsistencies.
 		 */
-		u32 event_mask;
+		bool event;
=20
 		scoped_guard(RSEQ_EVENT_GUARD) {
-			event_mask =3D t->rseq_event_mask;
-			t->rseq_event_mask =3D 0;
+			event =3D t->rseq_event_pending;
+			t->rseq_event_pending =3D false;
 		}
=20
-		if (IS_ENABLED(CONFIG_DEBUG_RSEQ) || event_mask) {
-			ret =3D rseq_ip_fixup(regs, !!event_mask);
+		if (IS_ENABLED(CONFIG_DEBUG_RSEQ) || event) {
+			ret =3D rseq_ip_fixup(regs, event);
 			if (unlikely(ret < 0))
 				goto error;
 		}
@@ -584,7 +590,7 @@ SYSCALL_DEFINE4(rseq, struct rseq __user *, rseq, u32, rs=
eq_len, int, flags, u32
 	 * registered, ensure the cpu_id_start and cpu_id fields
 	 * are updated before returning to user-space.
 	 */
-	rseq_set_notify_resume(current);
+	rseq_sched_switch_event(current);
=20
 	return 0;
 }
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index f1ebf67..b75e8e1 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -3329,7 +3329,6 @@ void set_task_cpu(struct task_struct *p, unsigned int n=
ew_cpu)
 		if (p->sched_class->migrate_task_rq)
 			p->sched_class->migrate_task_rq(p, new_cpu);
 		p->se.nr_migrations++;
-		rseq_migrate(p);
 		sched_mm_cid_migrate_from(p);
 		perf_event_task_migrate(p);
 	}
@@ -4763,7 +4762,6 @@ int sched_cgroup_fork(struct task_struct *p, struct ker=
nel_clone_args *kargs)
 		p->sched_task_group =3D tg;
 	}
 #endif
-	rseq_migrate(p);
 	/*
 	 * We're setting the CPU for the first time, we don't migrate,
 	 * so use __set_task_cpu().
@@ -4827,7 +4825,6 @@ void wake_up_new_task(struct task_struct *p)
 	 * as we're not fully set-up yet.
 	 */
 	p->recent_used_cpu =3D task_cpu(p);
-	rseq_migrate(p);
 	__set_task_cpu(p, select_task_rq(p, task_cpu(p), &wake_flags));
 	rq =3D __task_rq_lock(p, &rf);
 	update_rq_clock(rq);
@@ -5121,7 +5118,7 @@ prepare_task_switch(struct rq *rq, struct task_struct *=
prev,
 	kcov_prepare_switch(prev);
 	sched_info_switch(rq, prev, next);
 	perf_event_task_sched_out(prev, next);
-	rseq_preempt(prev);
+	rseq_sched_switch_event(prev);
 	fire_sched_out_preempt_notifiers(prev, next);
 	kmap_local_sched_out();
 	prepare_task(next);
diff --git a/kernel/sched/membarrier.c b/kernel/sched/membarrier.c
index 62fba83..6234456 100644
--- a/kernel/sched/membarrier.c
+++ b/kernel/sched/membarrier.c
@@ -199,7 +199,7 @@ static void ipi_rseq(void *info)
 	 * is negligible.
 	 */
 	smp_mb();
-	rseq_preempt(current);
+	rseq_sched_switch_event(current);
 }
=20
 static void ipi_sync_rq_state(void *info)
@@ -407,9 +407,9 @@ static int membarrier_private_expedited(int flags, int cp=
u_id)
 		 * membarrier, we will end up with some thread in the mm
 		 * running without a core sync.
 		 *
-		 * For RSEQ, don't rseq_preempt() the caller.  User code
-		 * is not supposed to issue syscalls at all from inside an
-		 * rseq critical section.
+		 * For RSEQ, don't invoke rseq_sched_switch_event() on the
+		 * caller.  User code is not supposed to issue syscalls at
+		 * all from inside an rseq critical section.
 		 */
 		if (flags !=3D MEMBARRIER_FLAG_SYNC_CORE) {
 			preempt_disable();

