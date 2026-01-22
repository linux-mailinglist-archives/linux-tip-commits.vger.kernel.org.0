Return-Path: <linux-tip-commits+bounces-8104-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wBb2FBb7cWmvZwAAu9opvQ
	(envelope-from <linux-tip-commits+bounces-8104-lists+linux-tip-commits=lfdr.de@vger.kernel.org>)
	for <lists+linux-tip-commits@lfdr.de>; Thu, 22 Jan 2026 11:25:26 +0100
X-Original-To: lists+linux-tip-commits@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id EEFB76536E
	for <lists+linux-tip-commits@lfdr.de>; Thu, 22 Jan 2026 11:25:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id AE05C8428FB
	for <lists+linux-tip-commits@lfdr.de>; Thu, 22 Jan 2026 10:19:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63CB83EFD1F;
	Thu, 22 Jan 2026 10:16:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="E99zJmZR";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="oU6PITRN"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B25D3EDACF;
	Thu, 22 Jan 2026 10:16:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769076970; cv=none; b=A1IQRhDBIMvHCdPl+Cirb6a4BtljUiwwLutIJ1x8xq10Q2h1qo0juf+3G5lZ4qIu94MPj7h7I1lG5S9rO597mZD+N+5PAwubdabmnYLDYsm06XmKp3M8TQnnNRDXDZ4rFHp5VQehkH1P0EAdeG5vea6/SGZSFWi98F9hseYI0A0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769076970; c=relaxed/simple;
	bh=5EqtzoEObu7IylAKo5oc2a7jgVdwqdWl5P5BQzE5u1I=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=uXiUUKgbsfhHaxhIQnasT1a6tqbPSZJwdcMnC9lxUAp4pcEjobk4fW3R4Nn7P5B25M/e9ViovavZsoAfLM2UejZ78vOzpDBV+44y54XZa+sheEYXSbkb2zX6MiFzyIxgtLag3WFO1mwKIxBOTqWTOoRWtBNKfok/2YkK4LMHaJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=E99zJmZR; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=oU6PITRN; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 22 Jan 2026 10:16:03 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1769076964;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ln63kRvMR5AZLCUKHy3U/oVD5SP3ZJ7iI2YqzlpcEnM=;
	b=E99zJmZR2oPdzOVg+nidklxtPYpux9CqAMPKJMiuIn5Z3CPMF1blDZjSHOaBQs5p6ASUUV
	R/rIFUfdK/Qt0+xar8TzRD1hVs1hLRjy8Xyx6U6zdCIBRMUGWinYA6mB+2HF7Q2U87qyDY
	xjHjCeU4L2TBdpHT+J8hEKsh9EmPej70kITyoOC2+tGd+YzVOjHgG5DMz+qJOeFldPYHXQ
	3WVjI2ASKkwYQ/D1SphZ7ypfv6fSQuGLU1ff6pVIpwlNKuTMDCbeVVfxjkjDji8x7shemW
	jfXDTy59gqa7IqjosFne6jyZpJfQiHuhCNrF9EP0k3vW9zLE9PAx+eZ4PJVxrQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1769076964;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ln63kRvMR5AZLCUKHy3U/oVD5SP3ZJ7iI2YqzlpcEnM=;
	b=oU6PITRN/t+uRtLmYfz4TxRX0oTAm0TYi/X5UGpZhLE5P74lrvufr0hAVBFsMy9WSp4her
	tzvGRowbXxeWcUDQ==
From: "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] rseq: Implement syscall entry work for time slice
 extensions
Cc: Thomas Gleixner <tglx@linutronix.de>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20251215155709.005777059@linutronix.de>
References: <20251215155709.005777059@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176907696316.510.5351094031049665279.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[linutronix.de:s=2020,linutronix.de:s=2020e];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	REPLYTO_DOM_EQ_TO_DOM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linutronix.de:email,linutronix.de:dkim,vger.kernel.org:replyto,dfw.mirrors.kernel.org:helo,dfw.mirrors.kernel.org:rdns,infradead.org:email,msgid.link:url];
	RCVD_COUNT_THREE(0.00)[3];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-8104-lists,linux-tip-commits=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linutronix.de:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tip-bot2@linutronix.de,linux-tip-commits@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DMARC_POLICY_ALLOW(0.00)[linutronix.de,none];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	ASN(0.00)[asn:7979, ipnet:142.0.200.0/24, country:US];
	TAGGED_RCPT(0.00)[linux-tip-commits];
	RCPT_COUNT_FIVE(0.00)[5];
	MISSING_XM_UA(0.00)[];
	HAS_REPLYTO(0.00)[linux-kernel@vger.kernel.org]
X-Rspamd-Queue-Id: EEFB76536E
X-Rspamd-Action: no action

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     dd0a04606937af5810e9117d343ee3792635bd3d
Gitweb:        https://git.kernel.org/tip/dd0a04606937af5810e9117d343ee379263=
5bd3d
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Mon, 15 Dec 2025 17:52:19 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Thu, 22 Jan 2026 11:11:18 +01:00

rseq: Implement syscall entry work for time slice extensions

The kernel sets SYSCALL_WORK_RSEQ_SLICE when it grants a time slice
extension. This allows to handle the rseq_slice_yield() syscall, which is
used by user space to relinquish the CPU after finishing the critical
section for which it requested an extension.

In case the kernel state is still GRANTED, the kernel resets both kernel
and user space state with a set of sanity checks. If the kernel state is
already cleared, then this raced against the timer or some other interrupt
and just clears the work bit.

Doing it in syscall entry work allows to catch misbehaving user space,
which issues an arbitrary syscall, i.e. not rseq_slice_yield(), from the
critical section. Contrary to the initial strict requirement to use
rseq_slice_yield() arbitrary syscalls are not considered a violation of the
ABI contract anymore to allow onion architecture applications, which cannot
control the code inside a critical section, to utilize this as well.

If the code detects inconsistent user space that result in a SIGSEGV for
the application.

If the grant was still active and the task was not preempted yet, the work
code reschedules immediately before continuing through the syscall.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://patch.msgid.link/20251215155709.005777059@linutronix.de
---
 include/linux/entry-common.h  |  2 +-
 include/linux/rseq.h          |  2 +-
 include/linux/thread_info.h   | 16 +++---
 kernel/entry/syscall-common.c | 11 +++-
 kernel/rseq.c                 | 91 ++++++++++++++++++++++++++++++++++-
 5 files changed, 112 insertions(+), 10 deletions(-)

diff --git a/include/linux/entry-common.h b/include/linux/entry-common.h
index 87efb38..026201a 100644
--- a/include/linux/entry-common.h
+++ b/include/linux/entry-common.h
@@ -36,8 +36,8 @@
 				 SYSCALL_WORK_SYSCALL_EMU |		\
 				 SYSCALL_WORK_SYSCALL_AUDIT |		\
 				 SYSCALL_WORK_SYSCALL_USER_DISPATCH |	\
+				 SYSCALL_WORK_SYSCALL_RSEQ_SLICE |	\
 				 ARCH_SYSCALL_WORK_ENTER)
-
 #define SYSCALL_WORK_EXIT	(SYSCALL_WORK_SYSCALL_TRACEPOINT |	\
 				 SYSCALL_WORK_SYSCALL_TRACE |		\
 				 SYSCALL_WORK_SYSCALL_AUDIT |		\
diff --git a/include/linux/rseq.h b/include/linux/rseq.h
index 3c194a0..7a01a07 100644
--- a/include/linux/rseq.h
+++ b/include/linux/rseq.h
@@ -164,8 +164,10 @@ static inline void rseq_syscall(struct pt_regs *regs) { }
 #endif /* !CONFIG_DEBUG_RSEQ */
=20
 #ifdef CONFIG_RSEQ_SLICE_EXTENSION
+void rseq_syscall_enter_work(long syscall);
 int rseq_slice_extension_prctl(unsigned long arg2, unsigned long arg3);
 #else /* CONFIG_RSEQ_SLICE_EXTENSION */
+static inline void rseq_syscall_enter_work(long syscall) { }
 static inline int rseq_slice_extension_prctl(unsigned long arg2, unsigned lo=
ng arg3)
 {
 	return -ENOTSUPP;
diff --git a/include/linux/thread_info.h b/include/linux/thread_info.h
index b40de9b..051e429 100644
--- a/include/linux/thread_info.h
+++ b/include/linux/thread_info.h
@@ -46,15 +46,17 @@ enum syscall_work_bit {
 	SYSCALL_WORK_BIT_SYSCALL_AUDIT,
 	SYSCALL_WORK_BIT_SYSCALL_USER_DISPATCH,
 	SYSCALL_WORK_BIT_SYSCALL_EXIT_TRAP,
+	SYSCALL_WORK_BIT_SYSCALL_RSEQ_SLICE,
 };
=20
-#define SYSCALL_WORK_SECCOMP		BIT(SYSCALL_WORK_BIT_SECCOMP)
-#define SYSCALL_WORK_SYSCALL_TRACEPOINT	BIT(SYSCALL_WORK_BIT_SYSCALL_TRACEPO=
INT)
-#define SYSCALL_WORK_SYSCALL_TRACE	BIT(SYSCALL_WORK_BIT_SYSCALL_TRACE)
-#define SYSCALL_WORK_SYSCALL_EMU	BIT(SYSCALL_WORK_BIT_SYSCALL_EMU)
-#define SYSCALL_WORK_SYSCALL_AUDIT	BIT(SYSCALL_WORK_BIT_SYSCALL_AUDIT)
-#define SYSCALL_WORK_SYSCALL_USER_DISPATCH BIT(SYSCALL_WORK_BIT_SYSCALL_USER=
_DISPATCH)
-#define SYSCALL_WORK_SYSCALL_EXIT_TRAP	BIT(SYSCALL_WORK_BIT_SYSCALL_EXIT_TRA=
P)
+#define SYSCALL_WORK_SECCOMP			BIT(SYSCALL_WORK_BIT_SECCOMP)
+#define SYSCALL_WORK_SYSCALL_TRACEPOINT		BIT(SYSCALL_WORK_BIT_SYSCALL_TRACEP=
OINT)
+#define SYSCALL_WORK_SYSCALL_TRACE		BIT(SYSCALL_WORK_BIT_SYSCALL_TRACE)
+#define SYSCALL_WORK_SYSCALL_EMU		BIT(SYSCALL_WORK_BIT_SYSCALL_EMU)
+#define SYSCALL_WORK_SYSCALL_AUDIT		BIT(SYSCALL_WORK_BIT_SYSCALL_AUDIT)
+#define SYSCALL_WORK_SYSCALL_USER_DISPATCH	BIT(SYSCALL_WORK_BIT_SYSCALL_USER=
_DISPATCH)
+#define SYSCALL_WORK_SYSCALL_EXIT_TRAP		BIT(SYSCALL_WORK_BIT_SYSCALL_EXIT_TR=
AP)
+#define SYSCALL_WORK_SYSCALL_RSEQ_SLICE		BIT(SYSCALL_WORK_BIT_SYSCALL_RSEQ_S=
LICE)
 #endif
=20
 #include <asm/thread_info.h>
diff --git a/kernel/entry/syscall-common.c b/kernel/entry/syscall-common.c
index 940a597..f7ee25b 100644
--- a/kernel/entry/syscall-common.c
+++ b/kernel/entry/syscall-common.c
@@ -17,8 +17,7 @@ static inline void syscall_enter_audit(struct pt_regs *regs=
, long syscall)
 	}
 }
=20
-long syscall_trace_enter(struct pt_regs *regs, long syscall,
-				unsigned long work)
+long syscall_trace_enter(struct pt_regs *regs, long syscall, unsigned long w=
ork)
 {
 	long ret =3D 0;
=20
@@ -32,6 +31,14 @@ long syscall_trace_enter(struct pt_regs *regs, long syscal=
l,
 			return -1L;
 	}
=20
+	/*
+	 * User space got a time slice extension granted and relinquishes
+	 * the CPU. The work stops the slice timer to avoid an extra round
+	 * through hrtimer_interrupt().
+	 */
+	if (work & SYSCALL_WORK_SYSCALL_RSEQ_SLICE)
+		rseq_syscall_enter_work(syscall);
+
 	/* Handle ptrace */
 	if (work & (SYSCALL_WORK_SYSCALL_TRACE | SYSCALL_WORK_SYSCALL_EMU)) {
 		ret =3D ptrace_report_syscall_entry(regs);
diff --git a/kernel/rseq.c b/kernel/rseq.c
index d8e1992..8aa4821 100644
--- a/kernel/rseq.c
+++ b/kernel/rseq.c
@@ -502,6 +502,97 @@ efault:
 #ifdef CONFIG_RSEQ_SLICE_EXTENSION
 DEFINE_STATIC_KEY_TRUE(rseq_slice_extension_key);
=20
+static inline void rseq_slice_set_need_resched(struct task_struct *curr)
+{
+	/*
+	 * The interrupt guard is required to prevent inconsistent state in
+	 * this case:
+	 *
+	 * set_tsk_need_resched()
+	 * --> Interrupt
+	 *       wakeup()
+	 *        set_tsk_need_resched()
+	 *	  set_preempt_need_resched()
+	 *     schedule_on_return()
+	 *        clear_tsk_need_resched()
+	 *	  clear_preempt_need_resched()
+	 * set_preempt_need_resched()		<- Inconsistent state
+	 *
+	 * This is safe vs. a remote set of TIF_NEED_RESCHED because that
+	 * only sets the already set bit and does not create inconsistent
+	 * state.
+	 */
+	scoped_guard(irq)
+		set_need_resched_current();
+}
+
+static void rseq_slice_validate_ctrl(u32 expected)
+{
+	u32 __user *sctrl =3D &current->rseq.usrptr->slice_ctrl.all;
+	u32 uval;
+
+	if (get_user(uval, sctrl) || uval !=3D expected)
+		force_sig(SIGSEGV);
+}
+
+/*
+ * Invoked from syscall entry if a time slice extension was granted and the
+ * kernel did not clear it before user space left the critical section.
+ *
+ * While the recommended way to relinquish the CPU side effect free is
+ * rseq_slice_yield(2), any syscall within a granted slice terminates the
+ * grant and immediately reschedules if required. This supports onion layer
+ * applications, where the code requesting the grant cannot control the
+ * code within the critical section.
+ */
+void rseq_syscall_enter_work(long syscall)
+{
+	struct task_struct *curr =3D current;
+	struct rseq_slice_ctrl ctrl =3D { .granted =3D curr->rseq.slice.state.grant=
ed };
+
+	clear_task_syscall_work(curr, SYSCALL_RSEQ_SLICE);
+
+	if (static_branch_unlikely(&rseq_debug_enabled))
+		rseq_slice_validate_ctrl(ctrl.all);
+
+	/*
+	 * The kernel might have raced, revoked the grant and updated
+	 * userspace, but kept the SLICE work set.
+	 */
+	if (!ctrl.granted)
+		return;
+
+	/*
+	 * Required to make set_tsk_need_resched() correct on PREEMPT[RT]
+	 * kernels. Leaving the scope will reschedule on preemption models
+	 * FULL, LAZY and RT if necessary.
+	 */
+	scoped_guard(preempt) {
+		/*
+		 * Now that preemption is disabled, quickly check whether
+		 * the task was already rescheduled before arriving here.
+		 */
+		if (!curr->rseq.event.sched_switch) {
+			rseq_slice_set_need_resched(curr);
+
+			if (syscall =3D=3D __NR_rseq_slice_yield) {
+				rseq_stat_inc(rseq_stats.s_yielded);
+				/* Update the yielded state for syscall return */
+				curr->rseq.slice.yielded =3D 1;
+			} else {
+				rseq_stat_inc(rseq_stats.s_aborted);
+			}
+		}
+	}
+	/* Reschedule on NONE/VOLUNTARY preemption models */
+	cond_resched();
+
+	/* Clear the grant in kernel state and user space */
+	curr->rseq.slice.state.granted =3D false;
+	if (put_user(0U, &curr->rseq.usrptr->slice_ctrl.all))
+		force_sig(SIGSEGV);
+}
+
 int rseq_slice_extension_prctl(unsigned long arg2, unsigned long arg3)
 {
 	switch (arg2) {

