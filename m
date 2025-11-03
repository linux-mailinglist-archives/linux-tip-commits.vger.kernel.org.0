Return-Path: <linux-tip-commits+bounces-7199-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id DE489C2C8D1
	for <lists+linux-tip-commits@lfdr.de>; Mon, 03 Nov 2025 16:04:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 62DD734AA12
	for <lists+linux-tip-commits@lfdr.de>; Mon,  3 Nov 2025 15:04:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1ACF31BCB8;
	Mon,  3 Nov 2025 14:47:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="4hb7W3Mf";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="blnznVWc"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6CA631B133;
	Mon,  3 Nov 2025 14:47:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762181274; cv=none; b=PPVxFaf6N00f8SJq69WXgUXtrbKXlLfHr2gF2MpxNM7T731KEK8SjGVBXbzvoRWydLnwSLpgE09ApxwQF1K6qe3oIzwTPCxUmPxEtMq/Nr1AEAKofg1GKu3xuLU8NXG/HhEz2f/u6gjDfgJkWmVydv+3DiWvMFi0Kw8zl4+RyEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762181274; c=relaxed/simple;
	bh=OuTPjXIrebP//ucRli3/O3lyWZKWoB3OMkslS27ECJ4=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=RMrvHTtg79hsIV8OrV4y5OfQqi/7p9dNwcpcgUJdHkR17w4LVjqQZwS95eIipEZu0FqgM1qjTW/DXLoGLFIhermVZ84jhzAVMcCtxlUavzgsMcP4TEBqq4Vt7iuYE9mB7SnpFjJJRyNf3LBWJ1Q93EZ5BDK24GWNuXWFXZ7EMxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=4hb7W3Mf; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=blnznVWc; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 03 Nov 2025 14:47:50 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1762181271;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ED515RHB2yMxeErrdfUQGO12BgGNl2Iuf9p78GdrQDE=;
	b=4hb7W3MfCfzKdNxJnWz6y5G73PFN7mZNkFJfq35HOEbWV4sql7zPqFs9hFmvOjJveeEOvs
	LWoa/DknDImRlJJSdMtz8ii/oTO1JNvrboYpE5x/z4vcZ/jixe11n3eVGurj1hz6W+caMk
	rli7jUsXcqzLo4ZYY7rRn5N1OAjGnMdjbW+38k3bn2R3/DKpujofNYimX7pWlWBANtroQj
	0ZqA9TM/3esYHdJQARtW4jOyWu9e+awuGTbzNrFG7BTxdKZYSfQT1rBMrJZnlqAyydZ6pf
	88+KSiaOkKbCgTnCtH+/OZd00KV4xACcoLjpAASjftlQStG1K1/iOSFQ5OvJCA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1762181271;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ED515RHB2yMxeErrdfUQGO12BgGNl2Iuf9p78GdrQDE=;
	b=blnznVWcGSUPwT8QiYGTBAuc3hztmuRmUhWO709Ua+/Z2Gotow5tvpVifWVnXZSj+4kGea
	x1sWqpngFPAPByAQ==
From: "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: core/rseq] rseq, virt: Retrigger RSEQ after vcpu_run()
Cc: Thomas Gleixner <tglx@linutronix.de>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
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
Message-ID: <176218127004.2601451.3890468720454441658.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the core/rseq branch of tip:

Commit-ID:     2016e8735ac1c36ac7c1afbfe0645d723f147644
Gitweb:        https://git.kernel.org/tip/2016e8735ac1c36ac7c1afbfe0645d723f1=
47644
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Mon, 27 Oct 2025 09:44:28 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 03 Nov 2025 15:26:14 +01:00

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

