Return-Path: <linux-tip-commits+bounces-7073-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D0B1C19BC3
	for <lists+linux-tip-commits@lfdr.de>; Wed, 29 Oct 2025 11:30:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0B8C91C23075
	for <lists+linux-tip-commits@lfdr.de>; Wed, 29 Oct 2025 10:28:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDCC8337BAA;
	Wed, 29 Oct 2025 10:23:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="mAz6hO98";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="CcCAkv9q"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16CDC307ACB;
	Wed, 29 Oct 2025 10:23:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761733437; cv=none; b=GXafEY/87l1KuE0ibceAVe0xLYwGNk5KYu8hgpxAvGSs0nUVeyqA6zAuWeBFbJ4beTHnyzY7m5pEUz61DOMM9yMpgywaemALP/l4RDOxCn6EivxhOOQVBPN7c9QL1HuDJrws8bC7KS/g0fIrsoO/38HO/AVu1VEJE3hDIxWg3Hk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761733437; c=relaxed/simple;
	bh=nTcrFCksT/a8pDGEsWe2h0Nbs5ctzz7fArvCuEBIDsE=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=QNHDu+wE6aX1xYDf89ct0YCreOhiMuOW9p6jFmHOlz4lDg165/+MH/QhEPQAYVwdgKKBvGhMT+YAju/4deyCR9oXDuVGP98NHvHOu+kd8C8FDtaMEKC5CJFyCcy4Mb90zHUxk4HIm8a2tLW2DZa/eHJ0d+hh8uNpspuTs/AWWEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=mAz6hO98; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=CcCAkv9q; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 29 Oct 2025 10:23:51 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1761733432;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eg9YycoOPuCG5EKxQ/FWmAcNd2tu2LwK25kccMomtZc=;
	b=mAz6hO98rZDH93DRNdsMmF/mTqpZMFkrDHbyR0EJkJ3+IsD1CkBna/2dSsh+BwWQAQzgi0
	Mmru/QvC98gAXgjdq9ULWiFhO/AuPzZydq56YDlGxGTdQ6i/cx6aktQvOvfbvhhf6WMHmH
	mO8ZXOETRm2XS21s0TFNx7skeicXpiEmhDZD+STjqm+rzOrHaz3edt03fRZpWqBtMBmwiF
	95yOw1hM9HIxFwCzYETHmt6+2MyMX8kcwdAOlCcUOv4CgmT+Wi4xJtyUu6VDDl4A0Utl2P
	mpnyVj4560KrC6dTOT4pChZjlt53XBR7p70fpO2+QGmMl3t8FYOuW2Qyt77WmQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1761733432;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eg9YycoOPuCG5EKxQ/FWmAcNd2tu2LwK25kccMomtZc=;
	b=CcCAkv9q+tDe6dnmh4aaLCdy0JOcf9wqFLeEA45VZSCzg8YEECOXVEK3aB26pF7mMg44DZ
	vknvvOS7tIQPs+AQ==
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
Message-ID: <176173343121.2601451.10707534583219676221.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the core/rseq branch of tip:

Commit-ID:     8a10c38923ff6cc15c9debb806305cbccca3806b
Gitweb:        https://git.kernel.org/tip/8a10c38923ff6cc15c9debb806305cbccca=
3806b
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Mon, 27 Oct 2025 09:44:38 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 29 Oct 2025 11:07:14 +01:00

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

