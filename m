Return-Path: <linux-tip-commits+bounces-7177-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B356C2C763
	for <lists+linux-tip-commits@lfdr.de>; Mon, 03 Nov 2025 15:47:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 88CC91896E93
	for <lists+linux-tip-commits@lfdr.de>; Mon,  3 Nov 2025 14:47:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 339B53148B7;
	Mon,  3 Nov 2025 14:47:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="rSymizn/";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="sALkKgbR"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43F5F313E1E;
	Mon,  3 Nov 2025 14:47:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762181234; cv=none; b=L8bN5rqRPxGRUaSifITTEqiEOtHUT/Uuh85brWVYxPe3dSHQ89sAf4KrqB8lArM50WqmzOaNFZM8z2VzM1GFO0YqUk3faPc3aLdpfk2jVLfYhqM5MWWDQ1ovqxVlKopnZmcBC6Ux8j3mZEf5EruxqxCtZLxRXShjv4wqcGR0AZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762181234; c=relaxed/simple;
	bh=JjYZ4VaO3Dg63LEjHY5Cl6hAC5vLAx/3pObl5KWJ+pI=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=YhyuWbmA5+/A0VACUTB5S/VvFmvtQMEOyQFvWNon6ImaHmhKGnEGLX5gJCCjavb1jCeUgLAP5qphC9oEmXyFELbrLgxs9uc1NDmP68VsmfUMC8hySii23fsh9WeBYbnnfqnKdMyCyg3Gg8LmtFRNBQcN26jg9v1s6ATgZLSsN2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=rSymizn/; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=sALkKgbR; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 03 Nov 2025 14:47:08 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1762181230;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vbRpGh/WyQdOW9uddas6QOHUJgOS726DvGPeeEju2v4=;
	b=rSymizn/wN3x3QEDhZxIMyblrV+gn07U6nWfJJ5xvCrdktUYldjcTW2SkHgRFumw656DMu
	ixGce/31jJL+Hq6FwYbycU9+3G8KOxYsPvgXZkAM4JVHlfpWqfOiSsOqXNmYOmIjgtHIeh
	Y1uPX+SiNXNKt08v4/7evq/4tTkRKmNvKRaPp+rD+vQNy2FMZrcEb/FdSmymuIYmXknksM
	Yxxy8k3b1FS/nXUoqUCnDGc1UlAFLdIa3U8JxxRo5B3I8dj6+XHjNfGTzMRLNnDwcYzuZf
	dINrr0hTcw9zLi8MtkRnKclqLPLCiw5py7T0swc1k+AmJtNEr7i6iq/4/cte+Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1762181230;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vbRpGh/WyQdOW9uddas6QOHUJgOS726DvGPeeEju2v4=;
	b=sALkKgbRQA/f6pruAoKAPa4nLGlNfdSzBQJ0yJUPTTe++2wopVmaaTO8z/Q3SRNy1JRzvg
	hxRWC9UWNGWU7XBQ==
From: "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: core/rseq] entry: Split up exit_to_user_mode_prepare()
Cc: Thomas Gleixner <tglx@linutronix.de>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20251027084307.782234789@linutronix.de>
References: <20251027084307.782234789@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176218122894.2601451.1844010748205743496.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the core/rseq branch of tip:

Commit-ID:     835baf7a6a1cf1ca8ade0dc22599e44beb764846
Gitweb:        https://git.kernel.org/tip/835baf7a6a1cf1ca8ade0dc22599e44beb7=
64846
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Mon, 27 Oct 2025 09:45:21 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 03 Nov 2025 15:26:22 +01:00

entry: Split up exit_to_user_mode_prepare()

exit_to_user_mode_prepare() is used for both interrupts and syscalls, but
there is extra rseq work, which is only required for in the interrupt exit
case.

Split up the function and provide wrappers for syscalls and interrupts,
which allows to separate the rseq exit work in the next step.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Link: https://patch.msgid.link/20251027084307.782234789@linutronix.de
---
 arch/arm64/kernel/entry-common.c |  2 +-
 include/linux/entry-common.h     |  2 +-
 include/linux/irq-entry-common.h | 49 +++++++++++++++++++++++++++----
 3 files changed, 46 insertions(+), 7 deletions(-)

diff --git a/arch/arm64/kernel/entry-common.c b/arch/arm64/kernel/entry-commo=
n.c
index a9c8171..0a97e26 100644
--- a/arch/arm64/kernel/entry-common.c
+++ b/arch/arm64/kernel/entry-common.c
@@ -100,7 +100,7 @@ static __always_inline void arm64_enter_from_user_mode(st=
ruct pt_regs *regs)
 static __always_inline void arm64_exit_to_user_mode(struct pt_regs *regs)
 {
 	local_irq_disable();
-	exit_to_user_mode_prepare(regs);
+	exit_to_user_mode_prepare_legacy(regs);
 	local_daif_mask();
 	mte_check_tfsr_exit();
 	exit_to_user_mode();
diff --git a/include/linux/entry-common.h b/include/linux/entry-common.h
index d967184..87efb38 100644
--- a/include/linux/entry-common.h
+++ b/include/linux/entry-common.h
@@ -156,7 +156,7 @@ static __always_inline void syscall_exit_to_user_mode_wor=
k(struct pt_regs *regs)
 	if (unlikely(work & SYSCALL_WORK_EXIT))
 		syscall_exit_work(regs, work);
 	local_irq_disable_exit_to_user();
-	exit_to_user_mode_prepare(regs);
+	syscall_exit_to_user_mode_prepare(regs);
 }
=20
 /**
diff --git a/include/linux/irq-entry-common.h b/include/linux/irq-entry-commo=
n.h
index 8f5ceea..5ea6172 100644
--- a/include/linux/irq-entry-common.h
+++ b/include/linux/irq-entry-common.h
@@ -201,7 +201,7 @@ void arch_do_signal_or_restart(struct pt_regs *regs);
 unsigned long exit_to_user_mode_loop(struct pt_regs *regs, unsigned long ti_=
work);
=20
 /**
- * exit_to_user_mode_prepare - call exit_to_user_mode_loop() if required
+ * __exit_to_user_mode_prepare - call exit_to_user_mode_loop() if required
  * @regs:	Pointer to pt_regs on entry stack
  *
  * 1) check that interrupts are disabled
@@ -209,8 +209,10 @@ unsigned long exit_to_user_mode_loop(struct pt_regs *reg=
s, unsigned long ti_work
  * 3) call exit_to_user_mode_loop() if any flags from
  *    EXIT_TO_USER_MODE_WORK are set
  * 4) check that interrupts are still disabled
+ *
+ * Don't invoke directly, use the syscall/irqentry_ prefixed variants below
  */
-static __always_inline void exit_to_user_mode_prepare(struct pt_regs *regs)
+static __always_inline void __exit_to_user_mode_prepare(struct pt_regs *regs)
 {
 	unsigned long ti_work;
=20
@@ -224,15 +226,52 @@ static __always_inline void exit_to_user_mode_prepare(s=
truct pt_regs *regs)
 		ti_work =3D exit_to_user_mode_loop(regs, ti_work);
=20
 	arch_exit_to_user_mode_prepare(regs, ti_work);
+}
=20
-	rseq_exit_to_user_mode();
-
+static __always_inline void __exit_to_user_mode_validate(void)
+{
 	/* Ensure that kernel state is sane for a return to userspace */
 	kmap_assert_nomap();
 	lockdep_assert_irqs_disabled();
 	lockdep_sys_exit();
 }
=20
+/* Temporary workaround to keep ARM64 alive */
+static __always_inline void exit_to_user_mode_prepare_legacy(struct pt_regs =
*regs)
+{
+	__exit_to_user_mode_prepare(regs);
+	rseq_exit_to_user_mode();
+	__exit_to_user_mode_validate();
+}
+
+/**
+ * syscall_exit_to_user_mode_prepare - call exit_to_user_mode_loop() if requ=
ired
+ * @regs:	Pointer to pt_regs on entry stack
+ *
+ * Wrapper around __exit_to_user_mode_prepare() to separate the exit work for
+ * syscalls and interrupts.
+ */
+static __always_inline void syscall_exit_to_user_mode_prepare(struct pt_regs=
 *regs)
+{
+	__exit_to_user_mode_prepare(regs);
+	rseq_exit_to_user_mode();
+	__exit_to_user_mode_validate();
+}
+
+/**
+ * irqentry_exit_to_user_mode_prepare - call exit_to_user_mode_loop() if req=
uired
+ * @regs:	Pointer to pt_regs on entry stack
+ *
+ * Wrapper around __exit_to_user_mode_prepare() to separate the exit work for
+ * syscalls and interrupts.
+ */
+static __always_inline void irqentry_exit_to_user_mode_prepare(struct pt_reg=
s *regs)
+{
+	__exit_to_user_mode_prepare(regs);
+	rseq_exit_to_user_mode();
+	__exit_to_user_mode_validate();
+}
+
 /**
  * exit_to_user_mode - Fixup state when exiting to user mode
  *
@@ -297,7 +336,7 @@ static __always_inline void irqentry_enter_from_user_mode=
(struct pt_regs *regs)
 static __always_inline void irqentry_exit_to_user_mode(struct pt_regs *regs)
 {
 	instrumentation_begin();
-	exit_to_user_mode_prepare(regs);
+	irqentry_exit_to_user_mode_prepare(regs);
 	instrumentation_end();
 	exit_to_user_mode();
 }

