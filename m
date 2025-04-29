Return-Path: <linux-tip-commits+bounces-5131-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D6C25AA0366
	for <lists+linux-tip-commits@lfdr.de>; Tue, 29 Apr 2025 08:33:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1C5AB48015A
	for <lists+linux-tip-commits@lfdr.de>; Tue, 29 Apr 2025 06:33:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3DB2274671;
	Tue, 29 Apr 2025 06:33:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Ak16QQXs";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="XQ9BsK3D"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15E10433C4;
	Tue, 29 Apr 2025 06:33:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745908405; cv=none; b=APmrmbdfV13rSCakYNA1PrxzP9H0Le0X+4Y+OMBl9omrncp5jFp8y10hcaQn6qNq6scpg7LorcPRC7IKm4HoVuePywBcBTdAsj1lk4c8k/FXOwaopNKQiG7s5FRzosyDNr/y8Dcipu+2ePcsoPDUEVvOaydg12Sakg0ogRO8LO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745908405; c=relaxed/simple;
	bh=/jZ134Z6Jw1/+GGUNk+WvhsmhnpCfXlJjTZv4V+2qdw=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=HxcOb1pbzNw1k6C1AjYcPNexaxY8jqKbJMINEwhNLea14chsUnBNjcBPTdV+0QbalhcHYO98nNI41Njdtp7Yu6ezDvIBzmiNXNbfC7N9cd8EwxJiIH4YmqIjeniyB+Z68B6SXReDl/Onk9gyKmQ5L1o9NiJ9nXepAbEqj6PNWX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Ak16QQXs; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=XQ9BsK3D; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 29 Apr 2025 06:33:16 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1745908402;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rI0Ss9ZVUtgcZdXslOTMWEet55UCOXrBN0K/EpEwcIQ=;
	b=Ak16QQXs2Hzb7p2C43BEg3bJvMA375KwyifLLZL0W/d1SB4bQVINtfWO9JpxQ+fFEjMF5c
	5b6Cysj9dnkKU6YMAR8uEe3B3cHPBpyef41LcbgX7QTsB/Hvy15vw8RsKT9TCcqjPYMdy+
	JMHwETJqy9N5Vteq1yKxg+3v2cyleZAhTUzFMMyGvkXXfP483PlZ3QH9AZO2UAkNW4nyPE
	F6Z5wsb74tIX+lztqacxSd5n9Uvpbipv8zDUDA5OQ7RHQIShcwRTWzJQ3ui5oynVgdVEFQ
	9pB/0gawFeOyMeNr5m0Ioy2HmPkqsavvN3FzJAYDF3HAvBFEtPaA3YL/9wl17Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1745908402;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rI0Ss9ZVUtgcZdXslOTMWEet55UCOXrBN0K/EpEwcIQ=;
	b=XQ9BsK3D1l56inItM0ltPIJVrhJl/o5290q1xwKcZTjAdJrCBpi6sFJwouLGTw/5WiDrz0
	F7j7KRBGqdnzM+CQ==
From: "tip-bot2 for Charlie Jenkins" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: core/entry] entry: Inline syscall_exit_to_user_mode()
Cc: Charlie Jenkins <charlie@rivosinc.com>,
 Thomas Gleixner <tglx@linutronix.de>,
 Alexandre Ghiti <alexghiti@rivosinc.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250320-riscv_optimize_entry-v6-4-63e187e26041@rivosinc.com>
References: <20250320-riscv_optimize_entry-v6-4-63e187e26041@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174590839698.22196.13962819374780313523.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the core/entry branch of tip:

Commit-ID:     e43b8bb56e537bfc8d9076793091e7679020fc9c
Gitweb:        https://git.kernel.org/tip/e43b8bb56e537bfc8d9076793091e7679020fc9c
Author:        Charlie Jenkins <charlie@rivosinc.com>
AuthorDate:    Thu, 20 Mar 2025 10:29:24 -07:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 29 Apr 2025 08:27:10 +02:00

entry: Inline syscall_exit_to_user_mode()

Similar to commit 221a164035fd ("entry: Move syscall_enter_from_user_mode()
to header file"), move syscall_exit_to_user_mode() to the header file as
well.

Testing was done with the byte-unixbench syscall benchmark (which calls
getpid) and QEMU. On riscv I measured a 7.09246% improvement, on x86 a
2.98843% improvement, on loongarch a 6.07954% improvement, and on s390 a
11.1328% improvement.

The Intel bot also reported "kernel test robot noticed a 1.9% improvement
of stress-ng.seek.ops_per_sec".

Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Alexandre Ghiti <alexghiti@rivosinc.com>
Link: https://lore.kernel.org/all/20250320-riscv_optimize_entry-v6-4-63e187e26041@rivosinc.com
Link: https://lore.kernel.org/linux-riscv/202502051555.85ae6844-lkp@intel.com/
---
 include/linux/entry-common.h | 43 +++++++++++++++++++++++++++++--
 kernel/entry/common.c        | 49 +-----------------------------------
 2 files changed, 42 insertions(+), 50 deletions(-)

diff --git a/include/linux/entry-common.h b/include/linux/entry-common.h
index fc61d02..f94f3fd 100644
--- a/include/linux/entry-common.h
+++ b/include/linux/entry-common.h
@@ -14,6 +14,7 @@
 #include <linux/kmsan.h>
 
 #include <asm/entry-common.h>
+#include <asm/syscall.h>
 
 /*
  * Define dummy _TIF work flags if not defined by the architecture or for
@@ -367,6 +368,15 @@ static __always_inline void exit_to_user_mode(void)
 }
 
 /**
+ * syscall_exit_work - Handle work before returning to user mode
+ * @regs:	Pointer to current pt_regs
+ * @work:	Current thread syscall work
+ *
+ * Do one-time syscall specific work.
+ */
+void syscall_exit_work(struct pt_regs *regs, unsigned long work);
+
+/**
  * syscall_exit_to_user_mode_work - Handle work before returning to user mode
  * @regs:	Pointer to currents pt_regs
  *
@@ -379,7 +389,30 @@ static __always_inline void exit_to_user_mode(void)
  * make the final state transitions. Interrupts must stay disabled between
  * return from this function and the invocation of exit_to_user_mode().
  */
-void syscall_exit_to_user_mode_work(struct pt_regs *regs);
+static __always_inline void syscall_exit_to_user_mode_work(struct pt_regs *regs)
+{
+	unsigned long work = READ_ONCE(current_thread_info()->syscall_work);
+	unsigned long nr = syscall_get_nr(current, regs);
+
+	CT_WARN_ON(ct_state() != CT_STATE_KERNEL);
+
+	if (IS_ENABLED(CONFIG_PROVE_LOCKING)) {
+		if (WARN(irqs_disabled(), "syscall %lu left IRQs disabled", nr))
+			local_irq_enable();
+	}
+
+	rseq_syscall(regs);
+
+	/*
+	 * Do one-time syscall specific work. If these work items are
+	 * enabled, we want to run them exactly once per syscall exit with
+	 * interrupts enabled.
+	 */
+	if (unlikely(work & SYSCALL_WORK_EXIT))
+		syscall_exit_work(regs, work);
+	local_irq_disable_exit_to_user();
+	exit_to_user_mode_prepare(regs);
+}
 
 /**
  * syscall_exit_to_user_mode - Handle work before returning to user mode
@@ -410,7 +443,13 @@ void syscall_exit_to_user_mode_work(struct pt_regs *regs);
  * exit_to_user_mode(). This function is preferred unless there is a
  * compelling architectural reason to use the separate functions.
  */
-void syscall_exit_to_user_mode(struct pt_regs *regs);
+static __always_inline void syscall_exit_to_user_mode(struct pt_regs *regs)
+{
+	instrumentation_begin();
+	syscall_exit_to_user_mode_work(regs);
+	instrumentation_end();
+	exit_to_user_mode();
+}
 
 /**
  * irqentry_enter_from_user_mode - Establish state before invoking the irq handler
diff --git a/kernel/entry/common.c b/kernel/entry/common.c
index 2015457..a8dd1f2 100644
--- a/kernel/entry/common.c
+++ b/kernel/entry/common.c
@@ -146,7 +146,7 @@ static inline bool report_single_step(unsigned long work)
 	return work & SYSCALL_WORK_SYSCALL_EXIT_TRAP;
 }
 
-static void syscall_exit_work(struct pt_regs *regs, unsigned long work)
+void syscall_exit_work(struct pt_regs *regs, unsigned long work)
 {
 	bool step;
 
@@ -173,53 +173,6 @@ static void syscall_exit_work(struct pt_regs *regs, unsigned long work)
 		ptrace_report_syscall_exit(regs, step);
 }
 
-/*
- * Syscall specific exit to user mode preparation. Runs with interrupts
- * enabled.
- */
-static void syscall_exit_to_user_mode_prepare(struct pt_regs *regs)
-{
-	unsigned long work = READ_ONCE(current_thread_info()->syscall_work);
-	unsigned long nr = syscall_get_nr(current, regs);
-
-	CT_WARN_ON(ct_state() != CT_STATE_KERNEL);
-
-	if (IS_ENABLED(CONFIG_PROVE_LOCKING)) {
-		if (WARN(irqs_disabled(), "syscall %lu left IRQs disabled", nr))
-			local_irq_enable();
-	}
-
-	rseq_syscall(regs);
-
-	/*
-	 * Do one-time syscall specific work. If these work items are
-	 * enabled, we want to run them exactly once per syscall exit with
-	 * interrupts enabled.
-	 */
-	if (unlikely(work & SYSCALL_WORK_EXIT))
-		syscall_exit_work(regs, work);
-}
-
-static __always_inline void __syscall_exit_to_user_mode_work(struct pt_regs *regs)
-{
-	syscall_exit_to_user_mode_prepare(regs);
-	local_irq_disable_exit_to_user();
-	exit_to_user_mode_prepare(regs);
-}
-
-void syscall_exit_to_user_mode_work(struct pt_regs *regs)
-{
-	__syscall_exit_to_user_mode_work(regs);
-}
-
-__visible noinstr void syscall_exit_to_user_mode(struct pt_regs *regs)
-{
-	instrumentation_begin();
-	__syscall_exit_to_user_mode_work(regs);
-	instrumentation_end();
-	exit_to_user_mode();
-}
-
 noinstr void irqentry_enter_from_user_mode(struct pt_regs *regs)
 {
 	enter_from_user_mode(regs);

