Return-Path: <linux-tip-commits+bounces-8149-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AC5vCF4ofWk0QgIAu9opvQ
	(envelope-from <linux-tip-commits+bounces-8149-lists+linux-tip-commits=lfdr.de@vger.kernel.org>)
	for <lists+linux-tip-commits@lfdr.de>; Fri, 30 Jan 2026 22:53:34 +0100
X-Original-To: lists+linux-tip-commits@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7159DBEE58
	for <lists+linux-tip-commits@lfdr.de>; Fri, 30 Jan 2026 22:53:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 75EB33009164
	for <lists+linux-tip-commits@lfdr.de>; Fri, 30 Jan 2026 21:53:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 216A23451C6;
	Fri, 30 Jan 2026 21:53:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="yubS4ewB";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="QFUsxiY/"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B055274FEB;
	Fri, 30 Jan 2026 21:53:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769810011; cv=none; b=GRvcc1IsKu2YC+twRYxe5rs9xLGKWiqcYDkt1DkNXXKjSw9GfUL4sehF1rWdqyTjdtNlpwsVF6epq+O5rkYsEFzsv5YWt84ysWHN6iZbTXYxRZyHOCz8HHd4nWxiBUQdHp/uiUvNgvmo2VJqcFR413gKMNgXSnhLaqDlfwXkB00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769810011; c=relaxed/simple;
	bh=DgtBkJvWdS2R1QzGjSGfY5N8YIDHww92BF9wfIsATOM=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=j1d+kp+dmUTfNdjGpBTIjZuq7qwnplaSuE66at09hVLILttTLbjgrWS/tTryaTnU3EWK/Ndx0ZT558C4BlIa0pvhkuZR6a1pPqCwFkzcdHTiKHZo/+1N83hAES0ILgOl/gGIFB50J+md/huObNB3FzkHgwUBiAmdyzpp5LzyA8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=yubS4ewB; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=QFUsxiY/; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 30 Jan 2026 21:53:26 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1769810007;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eIYGMig4mUHal3qiVOr/S2aZX3u+H6rG65msEFXHV5Q=;
	b=yubS4ewBTLOgT0GDR6jEzsl3+Fmg+8jb5tAHuhHNB8Y5Py3zcMb64wwthIDmgXisQvsGFe
	5ryIlVQPe0Vs8CXvXuVuLzjnVMJrE98IUvFq9pCgYQM8ietkKcGGYJixS3XWMNBiZyNEQX
	Wo1HvA5Wm4gz+adCJLybqcaXNQfVH1gDF3d0b/kyq3NVHxireXFdwfvEyCDwTRbZz+JmP3
	z/2NMJmyaNJ6xjkjeWDf8aEPdZn+yEjG2p8TxsyoVQCtE1W5EYQ8hu9OL/ZReV6ZXMvVeP
	N6R3YlGuIziXNert3uooTbvY5bsmbKUduRNFxto4HrAjMCRtdvlentKEGXcSAA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1769810007;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eIYGMig4mUHal3qiVOr/S2aZX3u+H6rG65msEFXHV5Q=;
	b=QFUsxiY/BdeF79Zv1RWzL3/t5y+tEqLwpBXuB0bqiCWl8KezDS/tNE4skcmB8LxfSu9nIl
	7AXt5WzLMZOThFAw==
From: "tip-bot2 for Jinjie Ruan" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: core/entry] entry: Inline syscall_exit_work() and syscall_trace_enter()
Cc: Jinjie Ruan <ruanjinjie@huawei.com>, Thomas Gleixner <tglx@kernel.org>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20260128031934.3906955-14-ruanjinjie@huawei.com>
References: <20260128031934.3906955-14-ruanjinjie@huawei.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176981000629.2495410.7047759143853625711.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linutronix.de,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[linutronix.de:s=2020,linutronix.de:s=2020e];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8149-lists,linux-tip-commits=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:replyto,huawei.com:email];
	REPLYTO_DOM_EQ_TO_DOM(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tip-bot2@linutronix.de,linux-tip-commits@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linutronix.de:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-tip-commits];
	MISSING_XM_UA(0.00)[];
	HAS_REPLYTO(0.00)[linux-kernel@vger.kernel.org]
X-Rspamd-Queue-Id: 7159DBEE58
X-Rspamd-Action: no action

The following commit has been merged into the core/entry branch of tip:

Commit-ID:     31c9387d0d84bc1d643a0c30155b6d92d05c92fc
Gitweb:        https://git.kernel.org/tip/31c9387d0d84bc1d643a0c30155b6d92d05=
c92fc
Author:        Jinjie Ruan <ruanjinjie@huawei.com>
AuthorDate:    Wed, 28 Jan 2026 11:19:33 +08:00
Committer:     Thomas Gleixner <tglx@kernel.org>
CommitterDate: Fri, 30 Jan 2026 15:38:10 +01:00

entry: Inline syscall_exit_work() and syscall_trace_enter()

After switching ARM64 to the generic entry code, a syscall_exit_work()
appeared as a profiling hotspot because it is not inlined.

Inlining both syscall_trace_enter() and syscall_exit_work() provides a
performance gain when any of the work items is enabled. With audit enabled
this results in a ~4% performance gain for perf bench basic syscall on
a kunpeng920 system:

    | Metric     | Baseline    | Inlined     | Change  |
    | ---------- | ----------- | ----------- | ------  |
    | Total time | 2.353 [sec] | 2.264 [sec] |  =E2=86=933.8%  |
    | usecs/op   | 0.235374    | 0.226472    |  =E2=86=933.8%  |
    | ops/sec    | 4,248,588   | 4,415,554   |  =E2=86=913.9%  |

Small gains can be observed on x86 as well, though the generated code
optimizes for the work case, which is counterproductive for high
performance scenarios where such entry/exit work is usually avoided.

Avoid this by marking the work check in syscall_enter_from_user_mode_work()
unlikely, which is what the corresponding check in the exit path does
already.

[ tglx: Massage changelog and add the unlikely() ]

Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
Signed-off-by: Thomas Gleixner <tglx@kernel.org>
Link: https://patch.msgid.link/20260128031934.3906955-14-ruanjinjie@huawei.com
---
 include/linux/entry-common.h         | 94 +++++++++++++++++++++++++-
 kernel/entry/common.h                |  7 +--
 kernel/entry/syscall-common.c        | 96 ++-------------------------
 kernel/entry/syscall_user_dispatch.c |  4 +-
 4 files changed, 102 insertions(+), 99 deletions(-)
 delete mode 100644 kernel/entry/common.h

diff --git a/include/linux/entry-common.h b/include/linux/entry-common.h
index bea207e..e67e3af 100644
--- a/include/linux/entry-common.h
+++ b/include/linux/entry-common.h
@@ -2,6 +2,7 @@
 #ifndef __LINUX_ENTRYCOMMON_H
 #define __LINUX_ENTRYCOMMON_H
=20
+#include <linux/audit.h>
 #include <linux/irq-entry-common.h>
 #include <linux/livepatch.h>
 #include <linux/ptrace.h>
@@ -63,7 +64,58 @@ static __always_inline int arch_ptrace_report_syscall_entr=
y(struct pt_regs *regs
 }
 #endif
=20
-long syscall_trace_enter(struct pt_regs *regs, unsigned long work);
+bool syscall_user_dispatch(struct pt_regs *regs);
+long trace_syscall_enter(struct pt_regs *regs, long syscall);
+void trace_syscall_exit(struct pt_regs *regs, long ret);
+
+static inline void syscall_enter_audit(struct pt_regs *regs, long syscall)
+{
+	if (unlikely(audit_context())) {
+		unsigned long args[6];
+
+		syscall_get_arguments(current, regs, args);
+		audit_syscall_entry(syscall, args[0], args[1], args[2], args[3]);
+	}
+}
+
+static __always_inline long syscall_trace_enter(struct pt_regs *regs, unsign=
ed long work)
+{
+	long syscall, ret =3D 0;
+
+	/*
+	 * Handle Syscall User Dispatch.  This must comes first, since
+	 * the ABI here can be something that doesn't make sense for
+	 * other syscall_work features.
+	 */
+	if (work & SYSCALL_WORK_SYSCALL_USER_DISPATCH) {
+		if (syscall_user_dispatch(regs))
+			return -1L;
+	}
+
+	/* Handle ptrace */
+	if (work & (SYSCALL_WORK_SYSCALL_TRACE | SYSCALL_WORK_SYSCALL_EMU)) {
+		ret =3D arch_ptrace_report_syscall_entry(regs);
+		if (ret || (work & SYSCALL_WORK_SYSCALL_EMU))
+			return -1L;
+	}
+
+	/* Do seccomp after ptrace, to catch any tracer changes. */
+	if (work & SYSCALL_WORK_SECCOMP) {
+		ret =3D __secure_computing();
+		if (ret =3D=3D -1L)
+			return ret;
+	}
+
+	/* Either of the above might have changed the syscall number */
+	syscall =3D syscall_get_nr(current, regs);
+
+	if (unlikely(work & SYSCALL_WORK_SYSCALL_TRACEPOINT))
+		syscall =3D trace_syscall_enter(regs, syscall);
+
+	syscall_enter_audit(regs, syscall);
+
+	return ret ? : syscall;
+}
=20
 /**
  * syscall_enter_from_user_mode_work - Check and handle work before invoking
@@ -130,6 +182,19 @@ static __always_inline long syscall_enter_from_user_mode=
(struct pt_regs *regs, l
 	return ret;
 }
=20
+/*
+ * If SYSCALL_EMU is set, then the only reason to report is when
+ * SINGLESTEP is set (i.e. PTRACE_SYSEMU_SINGLESTEP).  This syscall
+ * instruction has been already reported in syscall_enter_from_user_mode().
+ */
+static __always_inline bool report_single_step(unsigned long work)
+{
+	if (work & SYSCALL_WORK_SYSCALL_EMU)
+		return false;
+
+	return work & SYSCALL_WORK_SYSCALL_EXIT_TRAP;
+}
+
 /**
  * arch_ptrace_report_syscall_exit - Architecture specific ptrace_report_sys=
call_exit()
  *
@@ -155,7 +220,32 @@ static __always_inline void arch_ptrace_report_syscall_e=
xit(struct pt_regs *regs
  *
  * Do one-time syscall specific work.
  */
-void syscall_exit_work(struct pt_regs *regs, unsigned long work);
+static __always_inline void syscall_exit_work(struct pt_regs *regs, unsigned=
 long work)
+{
+	bool step;
+
+	/*
+	 * If the syscall was rolled back due to syscall user dispatching,
+	 * then the tracers below are not invoked for the same reason as
+	 * the entry side was not invoked in syscall_trace_enter(): The ABI
+	 * of these syscalls is unknown.
+	 */
+	if (work & SYSCALL_WORK_SYSCALL_USER_DISPATCH) {
+		if (unlikely(current->syscall_dispatch.on_dispatch)) {
+			current->syscall_dispatch.on_dispatch =3D false;
+			return;
+		}
+	}
+
+	audit_syscall_exit(regs);
+
+	if (work & SYSCALL_WORK_SYSCALL_TRACEPOINT)
+		trace_syscall_exit(regs, syscall_get_return_value(current, regs));
+
+	step =3D report_single_step(work);
+	if (step || work & SYSCALL_WORK_SYSCALL_TRACE)
+		arch_ptrace_report_syscall_exit(regs, step);
+}
=20
 /**
  * syscall_exit_to_user_mode_work - Handle one time work before returning to=
 user mode
diff --git a/kernel/entry/common.h b/kernel/entry/common.h
deleted file mode 100644
index f6e6d02..0000000
--- a/kernel/entry/common.h
+++ /dev/null
@@ -1,7 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-#ifndef _COMMON_H
-#define _COMMON_H
-
-bool syscall_user_dispatch(struct pt_regs *regs);
-
-#endif
diff --git a/kernel/entry/syscall-common.c b/kernel/entry/syscall-common.c
index bb5f61f..cd4967a 100644
--- a/kernel/entry/syscall-common.c
+++ b/kernel/entry/syscall-common.c
@@ -1,103 +1,23 @@
 // SPDX-License-Identifier: GPL-2.0
=20
-#include <linux/audit.h>
 #include <linux/entry-common.h>
-#include "common.h"
=20
 #define CREATE_TRACE_POINTS
 #include <trace/events/syscalls.h>
=20
-static inline void syscall_enter_audit(struct pt_regs *regs, long syscall)
-{
-	if (unlikely(audit_context())) {
-		unsigned long args[6];
-
-		syscall_get_arguments(current, regs, args);
-		audit_syscall_entry(syscall, args[0], args[1], args[2], args[3]);
-	}
-}
+/* Out of line to prevent tracepoint code duplication */
=20
-long syscall_trace_enter(struct pt_regs *regs, unsigned long work)
+long trace_syscall_enter(struct pt_regs *regs, long syscall)
 {
-	long syscall, ret =3D 0;
-
+	trace_sys_enter(regs, syscall);
 	/*
-	 * Handle Syscall User Dispatch.  This must comes first, since
-	 * the ABI here can be something that doesn't make sense for
-	 * other syscall_work features.
+	 * Probes or BPF hooks in the tracepoint may have changed the
+	 * system call number. Reread it.
 	 */
-	if (work & SYSCALL_WORK_SYSCALL_USER_DISPATCH) {
-		if (syscall_user_dispatch(regs))
-			return -1L;
-	}
-
-	/* Handle ptrace */
-	if (work & (SYSCALL_WORK_SYSCALL_TRACE | SYSCALL_WORK_SYSCALL_EMU)) {
-		ret =3D arch_ptrace_report_syscall_entry(regs);
-		if (ret || (work & SYSCALL_WORK_SYSCALL_EMU))
-			return -1L;
-	}
-
-	/* Do seccomp after ptrace, to catch any tracer changes. */
-	if (work & SYSCALL_WORK_SECCOMP) {
-		ret =3D __secure_computing();
-		if (ret =3D=3D -1L)
-			return ret;
-	}
-
-	/* Either of the above might have changed the syscall number */
-	syscall =3D syscall_get_nr(current, regs);
-
-	if (unlikely(work & SYSCALL_WORK_SYSCALL_TRACEPOINT)) {
-		trace_sys_enter(regs, syscall);
-		/*
-		 * Probes or BPF hooks in the tracepoint may have changed the
-		 * system call number as well.
-		 */
-		syscall =3D syscall_get_nr(current, regs);
-	}
-
-	syscall_enter_audit(regs, syscall);
-
-	return ret ? : syscall;
+	return syscall_get_nr(current, regs);
 }
=20
-/*
- * If SYSCALL_EMU is set, then the only reason to report is when
- * SINGLESTEP is set (i.e. PTRACE_SYSEMU_SINGLESTEP).  This syscall
- * instruction has been already reported in syscall_enter_from_user_mode().
- */
-static inline bool report_single_step(unsigned long work)
+void trace_syscall_exit(struct pt_regs *regs, long ret)
 {
-	if (work & SYSCALL_WORK_SYSCALL_EMU)
-		return false;
-
-	return work & SYSCALL_WORK_SYSCALL_EXIT_TRAP;
-}
-
-void syscall_exit_work(struct pt_regs *regs, unsigned long work)
-{
-	bool step;
-
-	/*
-	 * If the syscall was rolled back due to syscall user dispatching,
-	 * then the tracers below are not invoked for the same reason as
-	 * the entry side was not invoked in syscall_trace_enter(): The ABI
-	 * of these syscalls is unknown.
-	 */
-	if (work & SYSCALL_WORK_SYSCALL_USER_DISPATCH) {
-		if (unlikely(current->syscall_dispatch.on_dispatch)) {
-			current->syscall_dispatch.on_dispatch =3D false;
-			return;
-		}
-	}
-
-	audit_syscall_exit(regs);
-
-	if (work & SYSCALL_WORK_SYSCALL_TRACEPOINT)
-		trace_sys_exit(regs, syscall_get_return_value(current, regs));
-
-	step =3D report_single_step(work);
-	if (step || work & SYSCALL_WORK_SYSCALL_TRACE)
-		arch_ptrace_report_syscall_exit(regs, step);
+	trace_sys_exit(regs, ret);
 }
diff --git a/kernel/entry/syscall_user_dispatch.c b/kernel/entry/syscall_user=
_dispatch.c
index a9055ec..d89dffc 100644
--- a/kernel/entry/syscall_user_dispatch.c
+++ b/kernel/entry/syscall_user_dispatch.c
@@ -2,6 +2,8 @@
 /*
  * Copyright (C) 2020 Collabora Ltd.
  */
+
+#include <linux/entry-common.h>
 #include <linux/sched.h>
 #include <linux/prctl.h>
 #include <linux/ptrace.h>
@@ -15,8 +17,6 @@
=20
 #include <asm/syscall.h>
=20
-#include "common.h"
-
 static void trigger_sigsys(struct pt_regs *regs)
 {
 	struct kernel_siginfo info;

