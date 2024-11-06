Return-Path: <linux-tip-commits+bounces-2771-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 46BFC9BE4C7
	for <lists+linux-tip-commits@lfdr.de>; Wed,  6 Nov 2024 11:51:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 06D73281D2C
	for <lists+linux-tip-commits@lfdr.de>; Wed,  6 Nov 2024 10:51:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA6EC1E04B2;
	Wed,  6 Nov 2024 10:48:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="XNwNLlxF";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="9WK8bCQf"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B70A01DFDB1;
	Wed,  6 Nov 2024 10:48:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730890132; cv=none; b=noiYpGnt+dRM2fNUhc3WDJP0a7BAKRRTFdQ5fB5lU1UosF0fdiHrGkfEXRNB90eZOZn1jSWS3tyLMYv2Kz0sPZDLJvXl7X3iU2ZkPEkcSK3UsjtP/LO5yrSVJXIHFLVFdEODUAfpWxkfcItS9Y+Kb/9b3+fP4ix3raw3Ysp8beg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730890132; c=relaxed/simple;
	bh=oU5oke8gChdyWtq7zfSOHTsx2XlrBqy3JDQj8h8gRio=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=bAxwEqHHPVcyglkBgihLLOqP//XiCUxH0r38Nd5/ia/GxCE7p1MFdMCr/UlEcy4eNwLypYIlbrn0bYmubrAf8l4jmOGHqoOepQ+NIzv9IgbneyPIsXRxfSJk1IXbMqcjC9OxYw+Asb5KbroCx0RzYmb2zoJTs972UehChpAaCis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=XNwNLlxF; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=9WK8bCQf; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 06 Nov 2024 10:48:47 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1730890129;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LASTauJ60ErsJnQ5D+esLatpNpaz62RavH+/XLG2DCg=;
	b=XNwNLlxFnqQfEfV+ZWAu1Ofd1xT7R+A24xhh93tY+t4+FPl0QUZF3/HwKXGstZDFHfxY4b
	jrA2yOn+XDcfRkxyWcLU1qvcB+MS59L6a1EIHz8UkPNCCuN5WYu9n3rRq1tXpXIjVNrWoI
	ahgyUdLMT/BO+8h1SFsdrDfKHI1SY7oixtjJiPt2YmZF2BIHz3oWZ9aXwAZRfc+kCBZSZR
	vcMgg6jmEi2JSm0sW0i2JUYtrcjGCxx1iQ0w9VxcUQwYZ1HCnCunOuJ7/FuN2/cyPFdEfR
	+eapZy8nGt8qg+QjuAkO7G5k5OzskAZPU0+rzaoVNLMCwzWR6RYMdUhsAAom6g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1730890129;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LASTauJ60ErsJnQ5D+esLatpNpaz62RavH+/XLG2DCg=;
	b=9WK8bCQfKuJWP3ZCBmU4DJ42/CPlsvsSmCn76z9dtOLZr9zUfoEmcyfAAgs729Hp0pKn9G
	8W0aE3wsYH6EdlCA==
From: "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched: Add TIF_NEED_RESCHED_LAZY infrastructure
Cc: Thomas Gleixner <tglx@linutronix.de>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20241007075055.219540785@infradead.org>
References: <20241007075055.219540785@infradead.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173089012783.32228.17611031098154263925.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     26baa1f1c4bdc34b8d698c1900b407d863ad0e69
Gitweb:        https://git.kernel.org/tip/26baa1f1c4bdc34b8d698c1900b407d863ad0e69
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Fri, 04 Oct 2024 14:47:02 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 05 Nov 2024 12:55:37 +01:00

sched: Add TIF_NEED_RESCHED_LAZY infrastructure

Add the basic infrastructure to split the TIF_NEED_RESCHED bit in two.
Either bit will cause a resched on return-to-user, but only
TIF_NEED_RESCHED will drive IRQ preemption.

No behavioural change intended.

Suggested-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Link: https://lkml.kernel.org/r/20241007075055.219540785@infradead.org
---
 include/linux/entry-common.h |  3 ++-
 include/linux/entry-kvm.h    |  5 +++--
 include/linux/sched.h        |  3 ++-
 include/linux/thread_info.h  | 21 +++++++++++++++++----
 kernel/entry/common.c        |  2 +-
 kernel/entry/kvm.c           |  4 ++--
 kernel/sched/core.c          | 34 +++++++++++++++++++++-------------
 7 files changed, 48 insertions(+), 24 deletions(-)

diff --git a/include/linux/entry-common.h b/include/linux/entry-common.h
index 1e50cdb..fc61d02 100644
--- a/include/linux/entry-common.h
+++ b/include/linux/entry-common.h
@@ -64,7 +64,8 @@
 
 #define EXIT_TO_USER_MODE_WORK						\
 	(_TIF_SIGPENDING | _TIF_NOTIFY_RESUME | _TIF_UPROBE |		\
-	 _TIF_NEED_RESCHED | _TIF_PATCH_PENDING | _TIF_NOTIFY_SIGNAL |	\
+	 _TIF_NEED_RESCHED | _TIF_NEED_RESCHED_LAZY |			\
+	 _TIF_PATCH_PENDING | _TIF_NOTIFY_SIGNAL |			\
 	 ARCH_EXIT_TO_USER_MODE_WORK)
 
 /**
diff --git a/include/linux/entry-kvm.h b/include/linux/entry-kvm.h
index 6813171..16149f6 100644
--- a/include/linux/entry-kvm.h
+++ b/include/linux/entry-kvm.h
@@ -17,8 +17,9 @@
 #endif
 
 #define XFER_TO_GUEST_MODE_WORK						\
-	(_TIF_NEED_RESCHED | _TIF_SIGPENDING | _TIF_NOTIFY_SIGNAL |	\
-	 _TIF_NOTIFY_RESUME | ARCH_XFER_TO_GUEST_MODE_WORK)
+	(_TIF_NEED_RESCHED | _TIF_NEED_RESCHED_LAZY | _TIF_SIGPENDING | \
+	 _TIF_NOTIFY_SIGNAL | _TIF_NOTIFY_RESUME |			\
+	 ARCH_XFER_TO_GUEST_MODE_WORK)
 
 struct kvm_vcpu;
 
diff --git a/include/linux/sched.h b/include/linux/sched.h
index a76e3d0..1d5cc3e 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -2002,7 +2002,8 @@ static inline void set_tsk_need_resched(struct task_struct *tsk)
 
 static inline void clear_tsk_need_resched(struct task_struct *tsk)
 {
-	clear_tsk_thread_flag(tsk,TIF_NEED_RESCHED);
+	atomic_long_andnot(_TIF_NEED_RESCHED | _TIF_NEED_RESCHED_LAZY,
+			   (atomic_long_t *)&task_thread_info(tsk)->flags);
 }
 
 static inline int test_tsk_need_resched(struct task_struct *tsk)
diff --git a/include/linux/thread_info.h b/include/linux/thread_info.h
index 9ea0b28..cf2446c 100644
--- a/include/linux/thread_info.h
+++ b/include/linux/thread_info.h
@@ -59,6 +59,14 @@ enum syscall_work_bit {
 
 #include <asm/thread_info.h>
 
+#ifndef TIF_NEED_RESCHED_LAZY
+#ifdef CONFIG_ARCH_HAS_PREEMPT_LAZY
+#error Inconsistent PREEMPT_LAZY
+#endif
+#define TIF_NEED_RESCHED_LAZY TIF_NEED_RESCHED
+#define _TIF_NEED_RESCHED_LAZY _TIF_NEED_RESCHED
+#endif
+
 #ifdef __KERNEL__
 
 #ifndef arch_set_restart_data
@@ -179,22 +187,27 @@ static __always_inline unsigned long read_ti_thread_flags(struct thread_info *ti
 
 #ifdef _ASM_GENERIC_BITOPS_INSTRUMENTED_NON_ATOMIC_H
 
-static __always_inline bool tif_need_resched(void)
+static __always_inline bool tif_test_bit(int bit)
 {
-	return arch_test_bit(TIF_NEED_RESCHED,
+	return arch_test_bit(bit,
 			     (unsigned long *)(&current_thread_info()->flags));
 }
 
 #else
 
-static __always_inline bool tif_need_resched(void)
+static __always_inline bool tif_test_bit(int bit)
 {
-	return test_bit(TIF_NEED_RESCHED,
+	return test_bit(bit,
 			(unsigned long *)(&current_thread_info()->flags));
 }
 
 #endif /* _ASM_GENERIC_BITOPS_INSTRUMENTED_NON_ATOMIC_H */
 
+static __always_inline bool tif_need_resched(void)
+{
+	return tif_test_bit(TIF_NEED_RESCHED);
+}
+
 #ifndef CONFIG_HAVE_ARCH_WITHIN_STACK_FRAMES
 static inline int arch_within_stack_frames(const void * const stack,
 					   const void * const stackend,
diff --git a/kernel/entry/common.c b/kernel/entry/common.c
index 5b6934e..e33691d 100644
--- a/kernel/entry/common.c
+++ b/kernel/entry/common.c
@@ -98,7 +98,7 @@ __always_inline unsigned long exit_to_user_mode_loop(struct pt_regs *regs,
 
 		local_irq_enable_exit_to_user(ti_work);
 
-		if (ti_work & _TIF_NEED_RESCHED)
+		if (ti_work & (_TIF_NEED_RESCHED | _TIF_NEED_RESCHED_LAZY))
 			schedule();
 
 		if (ti_work & _TIF_UPROBE)
diff --git a/kernel/entry/kvm.c b/kernel/entry/kvm.c
index 2e0f75b..8485f63 100644
--- a/kernel/entry/kvm.c
+++ b/kernel/entry/kvm.c
@@ -13,7 +13,7 @@ static int xfer_to_guest_mode_work(struct kvm_vcpu *vcpu, unsigned long ti_work)
 			return -EINTR;
 		}
 
-		if (ti_work & _TIF_NEED_RESCHED)
+		if (ti_work & (_TIF_NEED_RESCHED | _TIF_NEED_RESCHED_LAZY))
 			schedule();
 
 		if (ti_work & _TIF_NOTIFY_RESUME)
@@ -24,7 +24,7 @@ static int xfer_to_guest_mode_work(struct kvm_vcpu *vcpu, unsigned long ti_work)
 			return ret;
 
 		ti_work = read_thread_flags();
-	} while (ti_work & XFER_TO_GUEST_MODE_WORK || need_resched());
+	} while (ti_work & XFER_TO_GUEST_MODE_WORK);
 	return 0;
 }
 
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index aad4885..0cd05e3 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -941,10 +941,9 @@ static inline void hrtick_rq_init(struct rq *rq)
  * this avoids any races wrt polling state changes and thereby avoids
  * spurious IPIs.
  */
-static inline bool set_nr_and_not_polling(struct task_struct *p)
+static inline bool set_nr_and_not_polling(struct thread_info *ti, int tif)
 {
-	struct thread_info *ti = task_thread_info(p);
-	return !(fetch_or(&ti->flags, _TIF_NEED_RESCHED) & _TIF_POLLING_NRFLAG);
+	return !(fetch_or(&ti->flags, 1 << tif) & _TIF_POLLING_NRFLAG);
 }
 
 /*
@@ -969,9 +968,9 @@ static bool set_nr_if_polling(struct task_struct *p)
 }
 
 #else
-static inline bool set_nr_and_not_polling(struct task_struct *p)
+static inline bool set_nr_and_not_polling(struct thread_info *ti, int tif)
 {
-	set_tsk_need_resched(p);
+	set_ti_thread_flag(ti, tif);
 	return true;
 }
 
@@ -1076,28 +1075,37 @@ void wake_up_q(struct wake_q_head *head)
  * might also involve a cross-CPU call to trigger the scheduler on
  * the target CPU.
  */
-void resched_curr(struct rq *rq)
+static void __resched_curr(struct rq *rq, int tif)
 {
 	struct task_struct *curr = rq->curr;
+	struct thread_info *cti = task_thread_info(curr);
 	int cpu;
 
 	lockdep_assert_rq_held(rq);
 
-	if (test_tsk_need_resched(curr))
+	if (cti->flags & ((1 << tif) | _TIF_NEED_RESCHED))
 		return;
 
 	cpu = cpu_of(rq);
 
 	if (cpu == smp_processor_id()) {
-		set_tsk_need_resched(curr);
-		set_preempt_need_resched();
+		set_ti_thread_flag(cti, tif);
+		if (tif == TIF_NEED_RESCHED)
+			set_preempt_need_resched();
 		return;
 	}
 
-	if (set_nr_and_not_polling(curr))
-		smp_send_reschedule(cpu);
-	else
+	if (set_nr_and_not_polling(cti, tif)) {
+		if (tif == TIF_NEED_RESCHED)
+			smp_send_reschedule(cpu);
+	} else {
 		trace_sched_wake_idle_without_ipi(cpu);
+	}
+}
+
+void resched_curr(struct rq *rq)
+{
+	__resched_curr(rq, TIF_NEED_RESCHED);
 }
 
 void resched_cpu(int cpu)
@@ -1192,7 +1200,7 @@ static void wake_up_idle_cpu(int cpu)
 	 * and testing of the above solutions didn't appear to report
 	 * much benefits.
 	 */
-	if (set_nr_and_not_polling(rq->idle))
+	if (set_nr_and_not_polling(task_thread_info(rq->idle), TIF_NEED_RESCHED))
 		smp_send_reschedule(cpu);
 	else
 		trace_sched_wake_idle_without_ipi(cpu);

