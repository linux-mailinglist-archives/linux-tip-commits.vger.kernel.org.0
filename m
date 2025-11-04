Return-Path: <linux-tip-commits+bounces-7242-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DE0B3C2FD31
	for <lists+linux-tip-commits@lfdr.de>; Tue, 04 Nov 2025 09:21:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F2EBF189E661
	for <lists+linux-tip-commits@lfdr.de>; Tue,  4 Nov 2025 08:21:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0D9531BCAA;
	Tue,  4 Nov 2025 08:17:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="icyQVMgS";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="wyj1pchF"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 834E531A57E;
	Tue,  4 Nov 2025 08:17:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762244254; cv=none; b=WwTfX/QZ2kH+cf55NFdkKWlu0d5ekPinPvNoJGCAmydpGZdzVP6jV97UuUblbaUraM/IL4tjQ4c8gBZtGjjtwO5U748+yqsmAZD1DEeTPDnTZym3WMwxIkdKxsIXXpksDfbFX4XW75Xzaho8ZKLfqPliVkZCpLwOa2YHA/vv2qE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762244254; c=relaxed/simple;
	bh=au8lBYzVTidUTg8SQIGpmiboy8V3e3pAf1gyjzgKUUY=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=NEWj/XPI5dOl9Mo2BrRtIKoV7wlUyQRLwI7TZNjnO+mQ5R9HOm6umI7K4LvY8grnGMXNAlE0JVZNqylN9F+HbKcmQTrWGfd51KXQxJhOHL0FThq5ACxH0wpffdeJ2heIct9bgSl1xnAhEx+C355M0px+ZTenZSefGHwJkFy/D8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=icyQVMgS; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=wyj1pchF; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 04 Nov 2025 08:17:29 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1762244250;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+a7KdGYbCbm6/MWmcHDRd6V+WNEeMZjshzFhnWW8524=;
	b=icyQVMgSqBMe0+eA4atJiEt5JALeLR8uCN7x1TWXMBnaG7cT8jF+Oj57TM0b1mOLpDgc2I
	sqCmUvXqC99m9R+dS5FydbMtC3rXkTIs7XAvtIAI4ZOBZEReVvCzsD/14568trIFyVP0Pv
	aMJzMYvSLEq02hylMKFYkTMT1Oy9DLnY4rFJfVn5fvRkXBSNjyEZRhME0yG+yyM5oaeNQW
	MrXQUFb6b7Knha5rKyglwm8A18JOUEhYhFiSQjlgrUOETSfGMHKW78BOdnIEvRqarWHX5l
	zQcdnbi9KrhdiiL65pYczwrzALtc8gp8riGyJ0J9P32QYJj47yVhYL5X/Osx3g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1762244250;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+a7KdGYbCbm6/MWmcHDRd6V+WNEeMZjshzFhnWW8524=;
	b=wyj1pchFSY7e5f0aQdiInj0lLVRwduMffQM186BX6ndNfrWLRSZJvbZhzBxEfeSESELH2x
	03Gav/zcIpydAHDA==
From: "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: core/rseq] entry: Remove syscall_enter_from_user_mode_prepare()
Cc: Thomas Gleixner <tglx@linutronix.de>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Ingo Molnar <mingo@kernel.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20251027084306.652839989@linutronix.de>
References: <20251027084306.652839989@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176224424930.2601451.4022403110713858266.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the core/rseq branch of tip:

Commit-ID:     54a5ab56242f96555999aaa41228f77b4a76e386
Gitweb:        https://git.kernel.org/tip/54a5ab56242f96555999aaa41228f77b4a7=
6e386
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Mon, 27 Oct 2025 09:44:38 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 04 Nov 2025 08:31:37 +01:00

entry: Remove syscall_enter_from_user_mode_prepare()

Open code the only user in the x86 syscall code and reduce the zoo of
functions.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Reviewed-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Link: https://patch.msgid.link/20251027084306.652839989@linutronix.de
---
 arch/x86/entry/syscall_32.c   |  3 ++-
 include/linux/entry-common.h  | 26 +++++---------------------
 kernel/entry/syscall-common.c |  8 --------
 3 files changed, 7 insertions(+), 30 deletions(-)

diff --git a/arch/x86/entry/syscall_32.c b/arch/x86/entry/syscall_32.c
index 2b15ea1..a67a644 100644
--- a/arch/x86/entry/syscall_32.c
+++ b/arch/x86/entry/syscall_32.c
@@ -274,9 +274,10 @@ static noinstr bool __do_fast_syscall_32(struct pt_regs =
*regs)
 	 * fetch EBP before invoking any of the syscall entry work
 	 * functions.
 	 */
-	syscall_enter_from_user_mode_prepare(regs);
+	enter_from_user_mode(regs);
=20
 	instrumentation_begin();
+	local_irq_enable();
 	/* Fetch EBP from where the vDSO stashed it. */
 	if (IS_ENABLED(CONFIG_X86_64)) {
 		/*
diff --git a/include/linux/entry-common.h b/include/linux/entry-common.h
index c585221..75b194c 100644
--- a/include/linux/entry-common.h
+++ b/include/linux/entry-common.h
@@ -45,23 +45,6 @@
 				 SYSCALL_WORK_SYSCALL_EXIT_TRAP	|	\
 				 ARCH_SYSCALL_WORK_EXIT)
=20
-/**
- * syscall_enter_from_user_mode_prepare - Establish state and enable interru=
pts
- * @regs:	Pointer to currents pt_regs
- *
- * Invoked from architecture specific syscall entry code with interrupts
- * disabled. The calling code has to be non-instrumentable. When the
- * function returns all state is correct, interrupts are enabled and the
- * subsequent functions can be instrumented.
- *
- * This handles lockdep, RCU (context tracking) and tracing state, i.e.
- * the functionality provided by enter_from_user_mode().
- *
- * This is invoked when there is extra architecture specific functionality
- * to be done between establishing state and handling user mode entry work.
- */
-void syscall_enter_from_user_mode_prepare(struct pt_regs *regs);
-
 long syscall_trace_enter(struct pt_regs *regs, long syscall, unsigned long w=
ork);
=20
 /**
@@ -71,8 +54,8 @@ long syscall_trace_enter(struct pt_regs *regs, long syscall=
, unsigned long work)
  * @syscall:	The syscall number
  *
  * Invoked from architecture specific syscall entry code with interrupts
- * enabled after invoking syscall_enter_from_user_mode_prepare() and extra
- * architecture specific work.
+ * enabled after invoking enter_from_user_mode(), enabling interrupts and
+ * extra architecture specific work.
  *
  * Returns: The original or a modified syscall number
  *
@@ -108,8 +91,9 @@ static __always_inline long syscall_enter_from_user_mode_w=
ork(struct pt_regs *re
  * function returns all state is correct, interrupts are enabled and the
  * subsequent functions can be instrumented.
  *
- * This is combination of syscall_enter_from_user_mode_prepare() and
- * syscall_enter_from_user_mode_work().
+ * This is the combination of enter_from_user_mode() and
+ * syscall_enter_from_user_mode_work() to be used when there is no
+ * architecture specific work to be done between the two.
  *
  * Returns: The original or a modified syscall number. See
  * syscall_enter_from_user_mode_work() for further explanation.
diff --git a/kernel/entry/syscall-common.c b/kernel/entry/syscall-common.c
index 66e6ba7..940a597 100644
--- a/kernel/entry/syscall-common.c
+++ b/kernel/entry/syscall-common.c
@@ -63,14 +63,6 @@ long syscall_trace_enter(struct pt_regs *regs, long syscal=
l,
 	return ret ? : syscall;
 }
=20
-noinstr void syscall_enter_from_user_mode_prepare(struct pt_regs *regs)
-{
-	enter_from_user_mode(regs);
-	instrumentation_begin();
-	local_irq_enable();
-	instrumentation_end();
-}
-
 /*
  * If SYSCALL_EMU is set, then the only reason to report is when
  * SINGLESTEP is set (i.e. PTRACE_SYSEMU_SINGLESTEP).  This syscall

