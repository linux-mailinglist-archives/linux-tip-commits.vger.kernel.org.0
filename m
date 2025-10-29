Return-Path: <linux-tip-commits+bounces-7055-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 56DF9C19AFA
	for <lists+linux-tip-commits@lfdr.de>; Wed, 29 Oct 2025 11:24:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 18B58189361E
	for <lists+linux-tip-commits@lfdr.de>; Wed, 29 Oct 2025 10:25:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B2583128CD;
	Wed, 29 Oct 2025 10:23:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="APDcJ+dO";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="1KKk+fOX"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02F8A2FDC56;
	Wed, 29 Oct 2025 10:23:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761733415; cv=none; b=T7E4HEdDJhFXfnDCIFB/L0OhFf54BcFy1LUWr639g69NFONi4Xrw7PPh/hRun5U/4DiQSLtyDvM6seU78RiNIbTcgPnvudsFVIRYJBC3flGjVrMC9Fzsk1XlTnSiftflAH69d121pUJs14DdQRwAQZMCuV5xnzAZ6pX9Uaje96E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761733415; c=relaxed/simple;
	bh=31YuB3CUKi78u4oxNs+Sz/PvIFE0R6BA9X3nFAQoISg=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=n3nIJHuK2a+qWdvpSlYHGeUxXAY+9uNAyMWuMU34d9cXp9lTI2IJ4jV8zLurFtYz/3nqR7xpMf1t5MBu7VwnDdm9zjO+EbsjzNfDtA16n8T0e01StD3mKmWZLCQwZNBiS0TFeZ2Yq2lQ4r5p9XhYsPC/smetsJHfOvlx3OK4TXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=APDcJ+dO; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=1KKk+fOX; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 29 Oct 2025 10:23:28 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1761733410;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oHLMD9eAqcOmJ79+i+f3IGz+6KVooJS4jaG9Rw3nv0U=;
	b=APDcJ+dO/8G6C4cRdDOkCfvaTZjR5bDmCBXaX10WFy+tI7v9bMkoei3VeniH1vWNmzYzwx
	H/Fq8RhqoQOi5XEWsDXj3Eu1bnu3gL5Zg/KmCOOWGSbFD54pYKVJnbFz1YrZCPHFcavtA1
	TsPajRvpqv6W4HGgaHwGJ8ib1s+hlshS979E3bXUkMUsSfCo+tmHWJwcsIqKW/pt0u2z9Z
	GIPpxiXL1ss4M/U+hHbGZudDxx8118aISZWp+3dAK7OH3XJqEI2r+qo1l2qqen+tsrVug3
	h7jvRFubpfi+f5VZB9ckjqJa4LG3LXyOphU+WOAp9vXAoU8ShSK1QULUexkcmA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1761733410;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oHLMD9eAqcOmJ79+i+f3IGz+6KVooJS4jaG9Rw3nv0U=;
	b=1KKk+fOX9Y6tAA1iiwIyiY5geLUY5wrIibZAMSUm0HpXrW79ShYzmt6I4/+inQmJmVHtKt
	mSPMLJhdJITqwKCw==
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
Message-ID: <176173340862.2601451.3505827684429498934.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the core/rseq branch of tip:

Commit-ID:     d589306403107aa3ba5f014cb7d17b3d5db3cf94
Gitweb:        https://git.kernel.org/tip/d589306403107aa3ba5f014cb7d17b3d5db=
3cf94
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Mon, 27 Oct 2025 09:45:21 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 29 Oct 2025 11:07:19 +01:00

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
 include/linux/entry-common.h     |  2 +-
 include/linux/irq-entry-common.h | 42 +++++++++++++++++++++++++++----
 2 files changed, 38 insertions(+), 6 deletions(-)

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
index 8f5ceea..9621d40 100644
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
@@ -224,15 +226,45 @@ static __always_inline void exit_to_user_mode_prepare(s=
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
@@ -297,7 +329,7 @@ static __always_inline void irqentry_enter_from_user_mode=
(struct pt_regs *regs)
 static __always_inline void irqentry_exit_to_user_mode(struct pt_regs *regs)
 {
 	instrumentation_begin();
-	exit_to_user_mode_prepare(regs);
+	irqentry_exit_to_user_mode_prepare(regs);
 	instrumentation_end();
 	exit_to_user_mode();
 }

