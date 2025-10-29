Return-Path: <linux-tip-commits+bounces-7083-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F1452C19C3B
	for <lists+linux-tip-commits@lfdr.de>; Wed, 29 Oct 2025 11:36:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CC8A61C84E71
	for <lists+linux-tip-commits@lfdr.de>; Wed, 29 Oct 2025 10:31:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81BB134AB16;
	Wed, 29 Oct 2025 10:24:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="lB6AxppV";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="VubVfBTJ"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BE1134A3B5;
	Wed, 29 Oct 2025 10:24:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761733448; cv=none; b=JQzOAqZWbSo0MdqIP6zJW6hzQHMUyG+0ow3dIw0lRa893To46Fkhp0Ut3tuMoyC6pH9V78efS8AUtTYEm/7oxaZ6EtSzB+7Il8XspOtM93nVhgFc2XBD9gmelj7A7wL7o3tCQS0XQ8ueUfzCaep31AJ+vaxAwgTogt87S8NyCGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761733448; c=relaxed/simple;
	bh=FFGaELJ+bnqXat33eheQVZ4iZCrrPsvkr5Tah49tszk=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=UJEjaVB9RvWw4Y4VTMGRftR0HTUkX2ZChEANFcK8rHDGcFONs53wh1kZAqKcDqv7l4NhbQ7+uno8LINNtSm0ZJ2lSQP4hepVmEJt6Mp7tcraUfjHYRURJWI05udXuwZmEsf/2PHVUXHOCAVHiLC9hnoSGpVakdlZDHvmkjY9oas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=lB6AxppV; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=VubVfBTJ; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 29 Oct 2025 10:24:03 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1761733444;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nWi2ukRmOcoqV/s+qY6KRI6PA67lj03W03JtYwRAMkk=;
	b=lB6AxppVCtguxb/UdMxzpxAcngIBeCS73xH8UjDmhawd0s3V55O1XNexsPIBhQG9qQ9bzW
	S7acOtQDQqAzI4wu3fuo1Aaug9OnxSXbBp08ZOPT/mgnGLNdh92lR656im8SVTQX7+JA0Q
	JnPOlbDOGtCy2dpdSCgB3Rqo1lwOrhoPieD4KmlKEXM47hzLKzbQvQHVVlicbnnmFfHIxN
	BfCc7Cic/IFM2mqfX4Sum0qlFSsJTrbcEV9NiQ1CfObRq83CzBd4OihMI0uOH6qSw7LvpT
	Ht8YFctSEmO3oxuC1n+YxY5A5qZESoLejp99/52REKGKZbBeEqNsKIU4Urk6Zw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1761733444;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nWi2ukRmOcoqV/s+qY6KRI6PA67lj03W03JtYwRAMkk=;
	b=VubVfBTJezjms/VAQcK/8P251K2gPFd519yMVv2oBLJXPy089Rz43/ZK3oqSmun56o1De4
	P25f2h0Kev8vUSCg==
From: "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: core/rseq] rseq: Avoid pointless evaluation in __rseq_notify_resume()
Cc: Thomas Gleixner <tglx@linutronix.de>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20251027084306.022571576@linutronix.de>
References: <20251027084306.022571576@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176173344304.2601451.2505095204398663143.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the core/rseq branch of tip:

Commit-ID:     fe9d47cb92603914b184b394a80f37e28274eacb
Gitweb:        https://git.kernel.org/tip/fe9d47cb92603914b184b394a80f37e2827=
4eacb
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Mon, 27 Oct 2025 09:44:16 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 29 Oct 2025 11:07:11 +01:00

rseq: Avoid pointless evaluation in __rseq_notify_resume()

The RSEQ critical section mechanism only clears the event mask when a
critical section is registered, otherwise it is stale and collects
bits.

That means once a critical section is installed the first invocation of
that code when TIF_NOTIFY_RESUME is set will abort the critical section,
even when the TIF bit was not raised by the rseq preempt/migrate/signal
helpers.

This also has a performance implication because TIF_NOTIFY_RESUME is a
multiplexing TIF bit, which is utilized by quite some infrastructure. That
means every invocation of __rseq_notify_resume() goes unconditionally
through the heavy lifting of user space access and consistency checks even
if there is no reason to do so.

Keeping the stale event mask around when exiting to user space also
prevents it from being utilized by the upcoming time slice extension
mechanism.

Avoid this by reading and clearing the event mask before doing the user
space critical section access with interrupts or preemption disabled, which
ensures that the read and clear operation is CPU local atomic versus
scheduling and the membarrier IPI.

This is correct as after re-enabling interrupts/preemption any relevant
event will set the bit again and raise TIF_NOTIFY_RESUME, which makes the
user space exit code take another round of TIF bit clearing.

If the event mask was non-zero, invoke the slow path. On debug kernels the
slow path is invoked unconditionally and the result of the event mask
evaluation is handed in.

Add a exit path check after the TIF bit loop, which validates on debug
kernels that the event mask is zero before exiting to user space.

While at it reword the convoluted comment why the pt_regs pointer can be
NULL under certain circumstances.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Link: https://patch.msgid.link/20251027084306.022571576@linutronix.de
---
 include/linux/irq-entry-common.h |  7 ++-
 include/linux/rseq.h             | 10 ++++-
 kernel/rseq.c                    | 66 ++++++++++++++++++++-----------
 3 files changed, 58 insertions(+), 25 deletions(-)

diff --git a/include/linux/irq-entry-common.h b/include/linux/irq-entry-commo=
n.h
index d643c7c..e5941df 100644
--- a/include/linux/irq-entry-common.h
+++ b/include/linux/irq-entry-common.h
@@ -2,11 +2,12 @@
 #ifndef __LINUX_IRQENTRYCOMMON_H
 #define __LINUX_IRQENTRYCOMMON_H
=20
+#include <linux/context_tracking.h>
+#include <linux/kmsan.h>
+#include <linux/rseq.h>
 #include <linux/static_call_types.h>
 #include <linux/syscalls.h>
-#include <linux/context_tracking.h>
 #include <linux/tick.h>
-#include <linux/kmsan.h>
 #include <linux/unwind_deferred.h>
=20
 #include <asm/entry-common.h>
@@ -226,6 +227,8 @@ static __always_inline void exit_to_user_mode_prepare(str=
uct pt_regs *regs)
=20
 	arch_exit_to_user_mode_prepare(regs, ti_work);
=20
+	rseq_exit_to_user_mode();
+
 	/* Ensure that kernel state is sane for a return to userspace */
 	kmap_assert_nomap();
 	lockdep_assert_irqs_disabled();
diff --git a/include/linux/rseq.h b/include/linux/rseq.h
index 69553e7..7622b73 100644
--- a/include/linux/rseq.h
+++ b/include/linux/rseq.h
@@ -66,6 +66,14 @@ static inline void rseq_migrate(struct task_struct *t)
 	rseq_set_notify_resume(t);
 }
=20
+static __always_inline void rseq_exit_to_user_mode(void)
+{
+	if (IS_ENABLED(CONFIG_DEBUG_RSEQ)) {
+		if (WARN_ON_ONCE(current->rseq && current->rseq_event_mask))
+			current->rseq_event_mask =3D 0;
+	}
+}
+
 /*
  * If parent process has a registered restartable sequences area, the
  * child inherits. Unregister rseq for a clone with CLONE_VM set.
@@ -118,7 +126,7 @@ static inline void rseq_fork(struct task_struct *t, u64 c=
lone_flags)
 static inline void rseq_execve(struct task_struct *t)
 {
 }
-
+static inline void rseq_exit_to_user_mode(void) { }
 #endif
=20
 #ifdef CONFIG_DEBUG_RSEQ
diff --git a/kernel/rseq.c b/kernel/rseq.c
index 2452b73..246319d 100644
--- a/kernel/rseq.c
+++ b/kernel/rseq.c
@@ -324,9 +324,9 @@ static bool rseq_warn_flags(const char *str, u32 flags)
 	return true;
 }
=20
-static int rseq_need_restart(struct task_struct *t, u32 cs_flags)
+static int rseq_check_flags(struct task_struct *t, u32 cs_flags)
 {
-	u32 flags, event_mask;
+	u32 flags;
 	int ret;
=20
 	if (rseq_warn_flags("rseq_cs", cs_flags))
@@ -339,17 +339,7 @@ static int rseq_need_restart(struct task_struct *t, u32 =
cs_flags)
=20
 	if (rseq_warn_flags("rseq", flags))
 		return -EINVAL;
-
-	/*
-	 * Load and clear event mask atomically with respect to
-	 * scheduler preemption and membarrier IPIs.
-	 */
-	scoped_guard(RSEQ_EVENT_GUARD) {
-		event_mask =3D t->rseq_event_mask;
-		t->rseq_event_mask =3D 0;
-	}
-
-	return !!event_mask;
+	return 0;
 }
=20
 static int clear_rseq_cs(struct rseq __user *rseq)
@@ -380,7 +370,7 @@ static bool in_rseq_cs(unsigned long ip, struct rseq_cs *=
rseq_cs)
 	return ip - rseq_cs->start_ip < rseq_cs->post_commit_offset;
 }
=20
-static int rseq_ip_fixup(struct pt_regs *regs)
+static int rseq_ip_fixup(struct pt_regs *regs, bool abort)
 {
 	unsigned long ip =3D instruction_pointer(regs);
 	struct task_struct *t =3D current;
@@ -398,9 +388,11 @@ static int rseq_ip_fixup(struct pt_regs *regs)
 	 */
 	if (!in_rseq_cs(ip, &rseq_cs))
 		return clear_rseq_cs(t->rseq);
-	ret =3D rseq_need_restart(t, rseq_cs.flags);
-	if (ret <=3D 0)
+	ret =3D rseq_check_flags(t, rseq_cs.flags);
+	if (ret < 0)
 		return ret;
+	if (!abort)
+		return 0;
 	ret =3D clear_rseq_cs(t->rseq);
 	if (ret)
 		return ret;
@@ -430,14 +422,44 @@ void __rseq_handle_notify_resume(struct ksignal *ksig, =
struct pt_regs *regs)
 		return;
=20
 	/*
-	 * regs is NULL if and only if the caller is in a syscall path.  Skip
-	 * fixup and leave rseq_cs as is so that rseq_sycall() will detect and
-	 * kill a misbehaving userspace on debug kernels.
+	 * If invoked from hypervisors or IO-URING, then @regs is a NULL
+	 * pointer, so fixup cannot be done. If the syscall which led to
+	 * this invocation was invoked inside a critical section, then it
+	 * will either end up in this code again or a possible violation of
+	 * a syscall inside a critical region can only be detected by the
+	 * debug code in rseq_syscall() in a debug enabled kernel.
 	 */
 	if (regs) {
-		ret =3D rseq_ip_fixup(regs);
-		if (unlikely(ret < 0))
-			goto error;
+		/*
+		 * Read and clear the event mask first. If the task was not
+		 * preempted or migrated or a signal is on the way, there
+		 * is no point in doing any of the heavy lifting here on
+		 * production kernels. In that case TIF_NOTIFY_RESUME was
+		 * raised by some other functionality.
+		 *
+		 * This is correct because the read/clear operation is
+		 * guarded against scheduler preemption, which makes it CPU
+		 * local atomic. If the task is preempted right after
+		 * re-enabling preemption then TIF_NOTIFY_RESUME is set
+		 * again and this function is invoked another time _before_
+		 * the task is able to return to user mode.
+		 *
+		 * On a debug kernel, invoke the fixup code unconditionally
+		 * with the result handed in to allow the detection of
+		 * inconsistencies.
+		 */
+		u32 event_mask;
+
+		scoped_guard(RSEQ_EVENT_GUARD) {
+			event_mask =3D t->rseq_event_mask;
+			t->rseq_event_mask =3D 0;
+		}
+
+		if (IS_ENABLED(CONFIG_DEBUG_RSEQ) || event_mask) {
+			ret =3D rseq_ip_fixup(regs, !!event_mask);
+			if (unlikely(ret < 0))
+				goto error;
+		}
 	}
 	if (unlikely(rseq_update_cpu_node_id(t)))
 		goto error;

