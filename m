Return-Path: <linux-tip-commits+bounces-7246-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 67CDEC2FD59
	for <lists+linux-tip-commits@lfdr.de>; Tue, 04 Nov 2025 09:23:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CFF1B1885FCC
	for <lists+linux-tip-commits@lfdr.de>; Tue,  4 Nov 2025 08:22:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF0E6320CA2;
	Tue,  4 Nov 2025 08:17:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="czVvl0rS";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="C5dCYHrB"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF29331E115;
	Tue,  4 Nov 2025 08:17:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762244261; cv=none; b=NmT0rYQBwVWtLLwhdCZi0NuhltSXj6YM9qsZDIJp6zJUbFGI05Iv1/Qav3uRITm6Y0ChTDISfN+h3YE63Bq3ndXc7SivyvQuPNyURPNR30bAfY27tD4S2PwnckQFl49ohVY2fIlwneZtNnBT45cjntMjazID6wkEn8xFEgUQGM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762244261; c=relaxed/simple;
	bh=CdazgqFLWcTbHaTcvr1aKLOT8/+aeGWXWtSGTA1eiJo=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=O/S/L+dYTunZ5AT6S3po9OMHg3cOFS+gdBdyBfS100tHT1kFTqRq7hwxqDhS7rZwAVPg71atqwBCIuQ0MXegywUZ8BtFPTksVnINDPcJrEPA/llniwR+QDQ8EWUT2R1ucJf3HkG6f7+5jfFagtjWtCSFnSqVqqY37YF7PO2kTQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=czVvl0rS; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=C5dCYHrB; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 04 Nov 2025 08:17:35 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1762244256;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=y/gYITaA6aKfTEyhLCzI4+9lo5LJgElYLqXai7xK0AA=;
	b=czVvl0rS2yrfaQsjG41CC4REfZ6c9pP81Z64zYFQ0tAbq7+M5HCvO9XBB05Z0UETzZS8cE
	mE5lhCZ0HWTyJuWnm7om3Aighx8QJVR2ULWZ3MoESO1suyZxmPcW/wLWCkBuXwqtQV7LsB
	5CkMP6z54ajFK4G3QLeYdUDWQIyOV3bi8q2Mee+jAhyA3WRc01AuWAoCm63rBCCmJv1MgQ
	IOAqucMu0sFbSoxOfmP1B8/sqeyDpVTURcfjYxcLN/zfR1fzEMBichL8bHmUoxIjUiGIXJ
	AMiDoVSAfLLhaBgyXDlaOKtJNxXCRMkkHvRu0PDVuDvaOX49FZWK2ucqZarJyA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1762244256;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=y/gYITaA6aKfTEyhLCzI4+9lo5LJgElYLqXai7xK0AA=;
	b=C5dCYHrBT2aJA+hqjyCYe2kQTYj4zttvbjTik58yL2nARsKv3hJMUcX3eS2h5GeaFZdSU/
	y7y2HUCqg9V2L3BQ==
From: "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: core/rseq] rseq, virt: Retrigger RSEQ after vcpu_run()
Cc: Thomas Gleixner <tglx@linutronix.de>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Ingo Molnar <mingo@kernel.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Sean Christopherson <seanjc@google.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20251027084306.399495855@linutronix.de>
References: <20251027084306.399495855@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176224425536.2601451.10216007065962562418.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the core/rseq branch of tip:

Commit-ID:     83409986f49f17b14a675f9c598ad50d4c60191b
Gitweb:        https://git.kernel.org/tip/83409986f49f17b14a675f9c598ad50d4c6=
0191b
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Mon, 27 Oct 2025 09:44:28 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 04 Nov 2025 08:30:23 +01:00

rseq, virt: Retrigger RSEQ after vcpu_run()

Hypervisors invoke resume_user_mode_work() before entering the guest, which
clears TIF_NOTIFY_RESUME. The @regs argument is NULL as there is no user
space context available to them, so the rseq notify handler skips
inspecting the critical section, but updates the CPU/MM CID values
unconditionally so that the eventual pending rseq event is not lost on the
way to user space.

This is a pointless exercise as the task might be rescheduled before
actually returning to user space and it creates unnecessary work in the
vcpu_run() loops.

It's way more efficient to ignore that invocation based on @regs =3D=3D NULL
and let the hypervisors re-raise TIF_NOTIFY_RESUME after returning from the
vcpu_run() loop before returning from the ioctl().

This ensures that a pending RSEQ update is not lost and the IDs are updated
before returning to user space.

Once the RSEQ handling is decoupled from TIF_NOTIFY_RESUME, this turns into
a NOOP.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Reviewed-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Acked-by: Sean Christopherson <seanjc@google.com>
Link: https://patch.msgid.link/20251027084306.399495855@linutronix.de
---
 drivers/hv/mshv_root_main.c |  3 +-
 include/linux/rseq.h        | 17 ++++++++-
 kernel/rseq.c               | 78 ++++++++++++++++++------------------
 virt/kvm/kvm_main.c         |  7 +++-
 4 files changed, 68 insertions(+), 37 deletions(-)

diff --git a/drivers/hv/mshv_root_main.c b/drivers/hv/mshv_root_main.c
index e3b2bd4..a21a0eb 100644
--- a/drivers/hv/mshv_root_main.c
+++ b/drivers/hv/mshv_root_main.c
@@ -29,6 +29,7 @@
 #include <linux/crash_dump.h>
 #include <linux/panic_notifier.h>
 #include <linux/vmalloc.h>
+#include <linux/rseq.h>
=20
 #include "mshv_eventfd.h"
 #include "mshv.h"
@@ -560,6 +561,8 @@ static long mshv_run_vp_with_root_scheduler(struct mshv_v=
p *vp)
 		}
 	} while (!vp->run.flags.intercept_suspend);
=20
+	rseq_virt_userspace_exit();
+
 	return ret;
 }
=20
diff --git a/include/linux/rseq.h b/include/linux/rseq.h
index 241067b..c6267f7 100644
--- a/include/linux/rseq.h
+++ b/include/linux/rseq.h
@@ -38,6 +38,22 @@ static __always_inline void rseq_exit_to_user_mode(void)
 }
=20
 /*
+ * KVM/HYPERV invoke resume_user_mode_work() before entering guest mode,
+ * which clears TIF_NOTIFY_RESUME. To avoid updating user space RSEQ in
+ * that case just to do it eventually again before returning to user space,
+ * the entry resume_user_mode_work() invocation is ignored as the register
+ * argument is NULL.
+ *
+ * After returning from guest mode, they have to invoke this function to
+ * re-raise TIF_NOTIFY_RESUME if necessary.
+ */
+static inline void rseq_virt_userspace_exit(void)
+{
+	if (current->rseq_event_pending)
+		set_tsk_thread_flag(current, TIF_NOTIFY_RESUME);
+}
+
+/*
  * If parent process has a registered restartable sequences area, the
  * child inherits. Unregister rseq for a clone with CLONE_VM set.
  */
@@ -68,6 +84,7 @@ static inline void rseq_execve(struct task_struct *t)
 static inline void rseq_handle_notify_resume(struct pt_regs *regs) { }
 static inline void rseq_signal_deliver(struct ksignal *ksig, struct pt_regs =
*regs) { }
 static inline void rseq_sched_switch_event(struct task_struct *t) { }
+static inline void rseq_virt_userspace_exit(void) { }
 static inline void rseq_fork(struct task_struct *t, u64 clone_flags) { }
 static inline void rseq_execve(struct task_struct *t) { }
 static inline void rseq_exit_to_user_mode(void) { }
diff --git a/kernel/rseq.c b/kernel/rseq.c
index 59adc1a..01e7113 100644
--- a/kernel/rseq.c
+++ b/kernel/rseq.c
@@ -422,50 +422,54 @@ void __rseq_handle_notify_resume(struct ksignal *ksig, =
struct pt_regs *regs)
 {
 	struct task_struct *t =3D current;
 	int ret, sig;
+	bool event;
+
+	/*
+	 * If invoked from hypervisors before entering the guest via
+	 * resume_user_mode_work(), then @regs is a NULL pointer.
+	 *
+	 * resume_user_mode_work() clears TIF_NOTIFY_RESUME and re-raises
+	 * it before returning from the ioctl() to user space when
+	 * rseq_event.sched_switch is set.
+	 *
+	 * So it's safe to ignore here instead of pointlessly updating it
+	 * in the vcpu_run() loop.
+	 */
+	if (!regs)
+		return;
=20
 	if (unlikely(t->flags & PF_EXITING))
 		return;
=20
 	/*
-	 * If invoked from hypervisors or IO-URING, then @regs is a NULL
-	 * pointer, so fixup cannot be done. If the syscall which led to
-	 * this invocation was invoked inside a critical section, then it
-	 * will either end up in this code again or a possible violation of
-	 * a syscall inside a critical region can only be detected by the
-	 * debug code in rseq_syscall() in a debug enabled kernel.
+	 * Read and clear the event pending bit first. If the task
+	 * was not preempted or migrated or a signal is on the way,
+	 * there is no point in doing any of the heavy lifting here
+	 * on production kernels. In that case TIF_NOTIFY_RESUME
+	 * was raised by some other functionality.
+	 *
+	 * This is correct because the read/clear operation is
+	 * guarded against scheduler preemption, which makes it CPU
+	 * local atomic. If the task is preempted right after
+	 * re-enabling preemption then TIF_NOTIFY_RESUME is set
+	 * again and this function is invoked another time _before_
+	 * the task is able to return to user mode.
+	 *
+	 * On a debug kernel, invoke the fixup code unconditionally
+	 * with the result handed in to allow the detection of
+	 * inconsistencies.
 	 */
-	if (regs) {
-		/*
-		 * Read and clear the event pending bit first. If the task
-		 * was not preempted or migrated or a signal is on the way,
-		 * there is no point in doing any of the heavy lifting here
-		 * on production kernels. In that case TIF_NOTIFY_RESUME
-		 * was raised by some other functionality.
-		 *
-		 * This is correct because the read/clear operation is
-		 * guarded against scheduler preemption, which makes it CPU
-		 * local atomic. If the task is preempted right after
-		 * re-enabling preemption then TIF_NOTIFY_RESUME is set
-		 * again and this function is invoked another time _before_
-		 * the task is able to return to user mode.
-		 *
-		 * On a debug kernel, invoke the fixup code unconditionally
-		 * with the result handed in to allow the detection of
-		 * inconsistencies.
-		 */
-		bool event;
-
-		scoped_guard(RSEQ_EVENT_GUARD) {
-			event =3D t->rseq_event_pending;
-			t->rseq_event_pending =3D false;
-		}
-
-		if (IS_ENABLED(CONFIG_DEBUG_RSEQ) || event) {
-			ret =3D rseq_ip_fixup(regs, event);
-			if (unlikely(ret < 0))
-				goto error;
-		}
+	scoped_guard(RSEQ_EVENT_GUARD) {
+		event =3D t->rseq_event_pending;
+		t->rseq_event_pending =3D false;
 	}
+
+	if (IS_ENABLED(CONFIG_DEBUG_RSEQ) || event) {
+		ret =3D rseq_ip_fixup(regs, event);
+		if (unlikely(ret < 0))
+			goto error;
+	}
+
 	if (unlikely(rseq_update_cpu_node_id(t)))
 		goto error;
 	return;
diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index b7a0ae2..4255fcf 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -49,6 +49,7 @@
 #include <linux/lockdep.h>
 #include <linux/kthread.h>
 #include <linux/suspend.h>
+#include <linux/rseq.h>
=20
 #include <asm/processor.h>
 #include <asm/ioctl.h>
@@ -4476,6 +4477,12 @@ static long kvm_vcpu_ioctl(struct file *filp,
 		r =3D kvm_arch_vcpu_ioctl_run(vcpu);
 		vcpu->wants_to_run =3D false;
=20
+		/*
+		 * FIXME: Remove this hack once all KVM architectures
+		 * support the generic TIF bits, i.e. a dedicated TIF_RSEQ.
+		 */
+		rseq_virt_userspace_exit();
+
 		trace_kvm_userspace_exit(vcpu->run->exit_reason, r);
 		break;
 	}

