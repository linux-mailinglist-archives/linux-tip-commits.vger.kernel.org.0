Return-Path: <linux-tip-commits+bounces-7053-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 69F9BC19AE8
	for <lists+linux-tip-commits@lfdr.de>; Wed, 29 Oct 2025 11:24:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id E42133507BC
	for <lists+linux-tip-commits@lfdr.de>; Wed, 29 Oct 2025 10:24:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B07ED3126DB;
	Wed, 29 Oct 2025 10:23:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="YaQ3NHHt";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="57ztk8oO"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10AD93074B4;
	Wed, 29 Oct 2025 10:23:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761733412; cv=none; b=D9lLZpPcJ8BIL+QARCoxQVI8dEYnHQe6JgJifTKL49hTdizwUnztRXRk1yMMmB/3471UfB6hWVeL16pI/CPbXaAgBFuNTFQsn/DVhqxtUk4T8c/sSv6STURXkTKbyOArx3SFvlGSohxcOvcIFaEymu0Z9TtCO16n5hlHW3vOBIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761733412; c=relaxed/simple;
	bh=pK/YYuwVw0dNMGDL/4xiOBeTZmWnv16C/Y9ZBRz/zjU=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=snl8OmU2W1wGu9D04l4QJyLPNrFqa/acrIj5zDrDW68OrUpp1EBIEVhtkDSHXsSEuhuuJKxn6plRFdNl7k63BhIHtVHLzM1/xcGd+PVUfL5e7IZsdkOGgVOolhjOSJDuWboEWA9qWN//C5oOVXYLf2ejM3N0K0OooAFjQwZMWPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=YaQ3NHHt; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=57ztk8oO; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 29 Oct 2025 10:23:25 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1761733407;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RiNjME06pBslSDUZ8GBMvErZDQeYLiu5OEX+k65dpBk=;
	b=YaQ3NHHtQKj9u0q1dcJfVbfjhOXy6N3WNIwksehazqL1FhywjjE5GKn5lzZb8zXyNyZBsq
	/H3WzvkPLjrLUVX6zeZba27oBfMHSO3S9/MmxkY1TeaBZVgG9Bj0Z8K5Niaf6bzNp1Z25e
	G83Xa5xWMY36jDPPLutBS4rM3V4BYwdy75bU2wjsxlLN68wXimwQ13fC6zO2Xg9LwXsGGo
	DN/vtd/c93nZ/InBXqM0V9luOG/VL49VrEAS5heBpMHkL6nX1t+pX49hCOkZGnrO0VTu3F
	WJEuKd7JpWYYPMS6yLKT58H9wtdEAiWseNcMs7DGh0aSNbrOVY9UoKM/rvGjqg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1761733407;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RiNjME06pBslSDUZ8GBMvErZDQeYLiu5OEX+k65dpBk=;
	b=57ztk8oOHrsHqx5AqSRAH+fx5z/PsDQ4c2/1jhyZNvqR4sNOxuHfrGOShoQGrRwpliWwUs
	ACYm0QEv/pmS4oAA==
From: "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: core/rseq] rseq: Switch to TIF_RSEQ if supported
Cc: Thomas Gleixner <tglx@linutronix.de>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20251027084307.903622031@linutronix.de>
References: <20251027084307.903622031@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176173340598.2601451.1818282942506757405.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the core/rseq branch of tip:

Commit-ID:     69c8e3d1610588d677faaa6035e1bd5de9431d6e
Gitweb:        https://git.kernel.org/tip/69c8e3d1610588d677faaa6035e1bd5de94=
31d6e
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Mon, 27 Oct 2025 09:45:26 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 29 Oct 2025 11:07:20 +01:00

rseq: Switch to TIF_RSEQ if supported

TIF_NOTIFY_RESUME is a multiplexing TIF bit, which is suboptimal especially
with the RSEQ fast path depending on it, but not really handling it.

Define a seperate TIF_RSEQ in the generic TIF space and enable the full
seperation of fast and slow path for architectures which utilize that.

That avoids the hassle with invocations of resume_user_mode_work() from
hypervisors, which clear TIF_NOTIFY_RESUME. It makes the therefore required
re-evaluation at the end of vcpu_run() a NOOP on architectures which
utilize the generic TIF space and have a seperate TIF_RSEQ.

The hypervisor TIF handling does not include the seperate TIF_RSEQ as there
is no point in doing so. The guest does neither know nor care about the VMM
host applications RSEQ state. That state is only relevant when the ioctl()
returns to user space.

The fastpath implementation still utilizes TIF_NOTIFY_RESUME for failure
handling, but this only happens within exit_to_user_mode_loop(), so
arguably the hypervisor ioctl() code is long done when this happens.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Link: https://patch.msgid.link/20251027084307.903622031@linutronix.de
---
 include/asm-generic/thread_info_tif.h |  3 +++-
 include/linux/irq-entry-common.h      |  2 +-
 include/linux/rseq.h                  | 22 ++++++++++++++-------
 include/linux/rseq_entry.h            | 27 ++++++++++++++++++++++++--
 include/linux/thread_info.h           |  5 +++++-
 kernel/entry/common.c                 | 10 ++++++++--
 6 files changed, 57 insertions(+), 12 deletions(-)

diff --git a/include/asm-generic/thread_info_tif.h b/include/asm-generic/thre=
ad_info_tif.h
index ee3793e..da1610a 100644
--- a/include/asm-generic/thread_info_tif.h
+++ b/include/asm-generic/thread_info_tif.h
@@ -45,4 +45,7 @@
 # define _TIF_RESTORE_SIGMASK	BIT(TIF_RESTORE_SIGMASK)
 #endif
=20
+#define TIF_RSEQ		11	// Run RSEQ fast path
+#define _TIF_RSEQ		BIT(TIF_RSEQ)
+
 #endif /* _ASM_GENERIC_THREAD_INFO_TIF_H_ */
diff --git a/include/linux/irq-entry-common.h b/include/linux/irq-entry-commo=
n.h
index 3ee0f16..b5baf22 100644
--- a/include/linux/irq-entry-common.h
+++ b/include/linux/irq-entry-common.h
@@ -30,7 +30,7 @@
 #define EXIT_TO_USER_MODE_WORK						\
 	(_TIF_SIGPENDING | _TIF_NOTIFY_RESUME | _TIF_UPROBE |		\
 	 _TIF_NEED_RESCHED | _TIF_NEED_RESCHED_LAZY |			\
-	 _TIF_PATCH_PENDING | _TIF_NOTIFY_SIGNAL |			\
+	 _TIF_PATCH_PENDING | _TIF_NOTIFY_SIGNAL | _TIF_RSEQ |		\
 	 ARCH_EXIT_TO_USER_MODE_WORK)
=20
 /**
diff --git a/include/linux/rseq.h b/include/linux/rseq.h
index ded4baa..b5e4803 100644
--- a/include/linux/rseq.h
+++ b/include/linux/rseq.h
@@ -42,7 +42,7 @@ static inline void rseq_signal_deliver(struct ksignal *ksig=
, struct pt_regs *reg
=20
 static inline void rseq_raise_notify_resume(struct task_struct *t)
 {
-	set_tsk_thread_flag(t, TIF_NOTIFY_RESUME);
+	set_tsk_thread_flag(t, TIF_RSEQ);
 }
=20
 /* Invoked from context switch to force evaluation on exit to user */
@@ -114,17 +114,25 @@ static inline void rseq_force_update(void)
=20
 /*
  * KVM/HYPERV invoke resume_user_mode_work() before entering guest mode,
- * which clears TIF_NOTIFY_RESUME. To avoid updating user space RSEQ in
- * that case just to do it eventually again before returning to user space,
- * the entry resume_user_mode_work() invocation is ignored as the register
- * argument is NULL.
+ * which clears TIF_NOTIFY_RESUME on architectures that don't use the
+ * generic TIF bits and therefore can't provide a separate TIF_RSEQ flag.
  *
- * After returning from guest mode, they have to invoke this function to
- * re-raise TIF_NOTIFY_RESUME if necessary.
+ * To avoid updating user space RSEQ in that case just to do it eventually
+ * again before returning to user space, because __rseq_handle_slowpath()
+ * does nothing when invoked with NULL register state.
+ *
+ * After returning from guest mode, before exiting to userspace, hypervisors
+ * must invoke this function to re-raise TIF_NOTIFY_RESUME if necessary.
  */
 static inline void rseq_virt_userspace_exit(void)
 {
 	if (current->rseq.event.sched_switch)
+	/*
+	 * The generic optimization for deferring RSEQ updates until the next
+	 * exit relies on having a dedicated TIF_RSEQ.
+	 */
+	if (!IS_ENABLED(CONFIG_HAVE_GENERIC_TIF_BITS) &&
+	    current->rseq.event.sched_switch)
 		rseq_raise_notify_resume(current);
 }
=20
diff --git a/include/linux/rseq_entry.h b/include/linux/rseq_entry.h
index 98d70a8..d14719d 100644
--- a/include/linux/rseq_entry.h
+++ b/include/linux/rseq_entry.h
@@ -507,13 +507,36 @@ static __always_inline bool __rseq_exit_to_user_mode_re=
start(struct pt_regs *reg
 	return false;
 }
=20
-static __always_inline bool rseq_exit_to_user_mode_restart(struct pt_regs *r=
egs)
+/* Required to allow conversion to GENERIC_ENTRY w/o GENERIC_TIF_BITS */
+#ifdef CONFIG_HAVE_GENERIC_TIF_BITS
+static __always_inline bool test_tif_rseq(unsigned long ti_work)
 {
+	return ti_work & _TIF_RSEQ;
+}
+
+static __always_inline void clear_tif_rseq(void)
+{
+	static_assert(TIF_RSEQ !=3D TIF_NOTIFY_RESUME);
+	clear_thread_flag(TIF_RSEQ);
+}
+#else
+static __always_inline bool test_tif_rseq(unsigned long ti_work) { return tr=
ue; }
+static __always_inline void clear_tif_rseq(void) { }
+#endif
+
+static __always_inline bool
+rseq_exit_to_user_mode_restart(struct pt_regs *regs, unsigned long ti_work)
+{
+	if (likely(!test_tif_rseq(ti_work)))
+		return false;
+
 	if (unlikely(__rseq_exit_to_user_mode_restart(regs))) {
 		current->rseq.event.slowpath =3D true;
 		set_tsk_thread_flag(current, TIF_NOTIFY_RESUME);
 		return true;
 	}
+
+	clear_tif_rseq();
 	return false;
 }
=20
@@ -557,7 +580,7 @@ static inline void rseq_debug_syscall_return(struct pt_re=
gs *regs)
 }
 #else /* CONFIG_RSEQ */
 static inline void rseq_note_user_irq_entry(void) { }
-static inline bool rseq_exit_to_user_mode_restart(struct pt_regs *regs)
+static inline bool rseq_exit_to_user_mode_restart(struct pt_regs *regs, unsi=
gned long ti_work)
 {
 	return false;
 }
diff --git a/include/linux/thread_info.h b/include/linux/thread_info.h
index dd925d8..b40de9b 100644
--- a/include/linux/thread_info.h
+++ b/include/linux/thread_info.h
@@ -67,6 +67,11 @@ enum syscall_work_bit {
 #define _TIF_NEED_RESCHED_LAZY _TIF_NEED_RESCHED
 #endif
=20
+#ifndef TIF_RSEQ
+# define TIF_RSEQ	TIF_NOTIFY_RESUME
+# define _TIF_RSEQ	_TIF_NOTIFY_RESUME
+#endif
+
 #ifdef __KERNEL__
=20
 #ifndef arch_set_restart_data
diff --git a/kernel/entry/common.c b/kernel/entry/common.c
index 523a3e7..5c792b3 100644
--- a/kernel/entry/common.c
+++ b/kernel/entry/common.c
@@ -11,6 +11,12 @@
 /* Workaround to allow gradual conversion of architecture code */
 void __weak arch_do_signal_or_restart(struct pt_regs *regs) { }
=20
+#ifdef CONFIG_HAVE_GENERIC_TIF_BITS
+#define EXIT_TO_USER_MODE_WORK_LOOP	(EXIT_TO_USER_MODE_WORK & ~_TIF_RSEQ)
+#else
+#define EXIT_TO_USER_MODE_WORK_LOOP	(EXIT_TO_USER_MODE_WORK)
+#endif
+
 static __always_inline unsigned long __exit_to_user_mode_loop(struct pt_regs=
 *regs,
 							      unsigned long ti_work)
 {
@@ -18,7 +24,7 @@ static __always_inline unsigned long __exit_to_user_mode_lo=
op(struct pt_regs *re
 	 * Before returning to user space ensure that all pending work
 	 * items have been completed.
 	 */
-	while (ti_work & EXIT_TO_USER_MODE_WORK) {
+	while (ti_work & EXIT_TO_USER_MODE_WORK_LOOP) {
=20
 		local_irq_enable_exit_to_user(ti_work);
=20
@@ -68,7 +74,7 @@ __always_inline unsigned long exit_to_user_mode_loop(struct=
 pt_regs *regs,
 	for (;;) {
 		ti_work =3D __exit_to_user_mode_loop(regs, ti_work);
=20
-		if (likely(!rseq_exit_to_user_mode_restart(regs)))
+		if (likely(!rseq_exit_to_user_mode_restart(regs, ti_work)))
 			return ti_work;
 		ti_work =3D read_thread_flags();
 	}

