Return-Path: <linux-tip-commits+bounces-7224-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E0D42C2FCB3
	for <lists+linux-tip-commits@lfdr.de>; Tue, 04 Nov 2025 09:17:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 375D41897CC6
	for <lists+linux-tip-commits@lfdr.de>; Tue,  4 Nov 2025 08:17:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EE7D312803;
	Tue,  4 Nov 2025 08:16:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="huuD9BNF";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="+4oCW9MJ"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7512E311C2A;
	Tue,  4 Nov 2025 08:16:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762244211; cv=none; b=O4rAeUVyZoanjRWsG8Lgu0C/Zeg+pqRJuVKkzJ050OOf+5ow3xEViZxfgOillNaVXHyKI5nk/aCfTPRhUlyyEDp/trQUcNp5k53agUkKypwSaMOWKvv/Dw7AaXIRmla0HNURkqUpEplfx+Vy9BFhFX18GvHysgwcOn7MX9NmzIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762244211; c=relaxed/simple;
	bh=8iFyg8/ecMGwT+5p542+YEaH4hE2YJqhpXFD9bmiw2s=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=YQtVA01cjBa3B++gNSUNnYYUfZrT+T+v9FAvaYEHWiD36lrJUI8ucQTxiD5K+ddnYl7zZWDfPsjxvf6suTEKZvX2fRA93A+/PMPV36QalTNilVTA5hI+lQUawU4CvXV+BlsWRo432zWhJRHnUDigefOegTwFULLYfSFLVkm+rP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=huuD9BNF; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=+4oCW9MJ; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 04 Nov 2025 08:16:46 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1762244207;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CnrCeoyCH1xjQ+zG7zIVB+uw97wgcEHb/+4hC2tYh/s=;
	b=huuD9BNFQvGwBTBKiVfZCOHOfLtMWSxZOWxlZ/HId4p3AM8aKfDXdjZrHZL7XJMVNQU7Dh
	8jXhdNc2Udhn6KawKCC+YtpQ9BFCbJbUpqM2SRF3JlO0NJ0k9sHd73GXEVzwr8jG8ULP3G
	9tMjfJgDvLh0pxaT4NIe18q9kSQfS/E/w+HFgwyM7C/lSNxLqHZzryeUPTa+96uvouMpKt
	J5nKLTOPLBzl9Ddbuv3XXu0NlL1sYJX7nTWvSt/s/9RyXKNyhtFuvzD8xIxPhOX2zqSiit
	ZBDU2KmaGeCT8lr0uUFEaxgw8gH8xoYcVCSMwgy2C9cYpcNGb+pR5tmI8XRLqw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1762244207;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CnrCeoyCH1xjQ+zG7zIVB+uw97wgcEHb/+4hC2tYh/s=;
	b=+4oCW9MJ0hTYBPQKjAei7OS9xPI6L55qzMMTj46CtmleThX1uF5EARhBN1iNj4ari07Qgu
	DV1ovWprjv/JqmDg==
From: "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: core/rseq] entry: Split up exit_to_user_mode_prepare()
Cc: Thomas Gleixner <tglx@linutronix.de>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Ingo Molnar <mingo@kernel.org>,
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
Message-ID: <176224420620.2601451.5996280552610464309.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the core/rseq branch of tip:

Commit-ID:     70fe25a3bc53a891f0e6184c12bd55cc524cb13b
Gitweb:        https://git.kernel.org/tip/70fe25a3bc53a891f0e6184c12bd55cc524=
cb13b
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Mon, 27 Oct 2025 09:45:21 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 04 Nov 2025 08:35:17 +01:00

entry: Split up exit_to_user_mode_prepare()

exit_to_user_mode_prepare() is used for both interrupts and syscalls, but
there is extra rseq work, which is only required for in the interrupt exit
case.

Split up the function and provide wrappers for syscalls and interrupts,
which allows to separate the rseq exit work in the next step.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
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

