Return-Path: <linux-tip-commits+bounces-7195-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id A2250C2C979
	for <lists+linux-tip-commits@lfdr.de>; Mon, 03 Nov 2025 16:11:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2DF0F4F2AA8
	for <lists+linux-tip-commits@lfdr.de>; Mon,  3 Nov 2025 15:03:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DDA031A7F0;
	Mon,  3 Nov 2025 14:47:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="zPf5StGn";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="fuzlxxW1"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBCE331A058;
	Mon,  3 Nov 2025 14:47:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762181269; cv=none; b=BqxQDvE4bdonouXUF//4P6XKG1tkvXd9Hl/+lMkl8G94h3oUxWYAXqiDhO6AGN3qgjSFDUUon/sfnArz7mI7UJLWkArQRBmdHVpE2RnVPHwVP43SnRjrqNMBIvu/zqQOEMUwJsUxjoQL23S2h/dBGmJQj4pQlekA8zyRGG6z5X0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762181269; c=relaxed/simple;
	bh=l19ULmEcKH+MukSfCPlZJ+2DoccNh0tt7uTpc3qNnLU=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=cl0ipsgQ6XlyEPmLsekc9B2gsgo5NBqEaCCRgVzZQZ/lxYKaW1karVePNlFnUS1GS62Xcl2LitgMCmd/3s0cVICVCFsS7m5xYBOBao3BGB2rhhCUqWNNnF4GI6YxkHo8dgVGWqf41rb+2pLj40yRocz1XZiC4UF3YBKyoEDwQWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=zPf5StGn; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=fuzlxxW1; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 03 Nov 2025 14:47:45 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1762181266;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/JAxrdBB/3A6+WIWAsQaVXkwO4L6SxI69DRSHit9908=;
	b=zPf5StGnX2iBofSk8Ni6GDAF+PQKSivgBYpxrh+ROnK7zjTf7b2gfXp5UONnvkA4WSbp/o
	+qnPqQylQbLXQh1TiHY9JDwtRWnpOYPIEaGmz7W8zC5BcFckjeSOIR6CYOFEW42iqyLsLX
	jhSO9kc7y2+oosUIsTzUV00uWm8icOZ3LEu5CkCzERlERsTNU/g11EqlkhDRgPJPeigEpn
	phQ6G4zMPZEkpe5ysIg3r1aYfXe3U7tyZH7tjoIKxe/Ci/UqCRAd4YbDQ0bwWjuNx/2jRO
	wc4IjLqCuT7dvvyL/ReCrh/CCjMF5iWX4wYggTs8QaNxye6cEINzxN/iVbMoyw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1762181266;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/JAxrdBB/3A6+WIWAsQaVXkwO4L6SxI69DRSHit9908=;
	b=fuzlxxW10C41p8SdmPP10DcGLmZzosq3KeqCzd1hQ0LJbA24LUzM34LdEcohdjyN66izVu
	TiEHieIse45pM2AQ==
From: "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: core/rseq] entry: Remove syscall_enter_from_user_mode_prepare()
Cc: Thomas Gleixner <tglx@linutronix.de>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
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
Message-ID: <176218126510.2601451.16654029709242286665.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the core/rseq branch of tip:

Commit-ID:     5e7be1e23bd119d8403cbe3110cfe2ce40306ffe
Gitweb:        https://git.kernel.org/tip/5e7be1e23bd119d8403cbe3110cfe2ce403=
06ffe
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Mon, 27 Oct 2025 09:44:38 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 03 Nov 2025 15:26:16 +01:00

entry: Remove syscall_enter_from_user_mode_prepare()

Open code the only user in the x86 syscall code and reduce the zoo of
functions.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
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

