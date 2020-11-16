Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D079E2B5377
	for <lists+linux-tip-commits@lfdr.de>; Mon, 16 Nov 2020 22:13:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732524AbgKPVLf (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Mon, 16 Nov 2020 16:11:35 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:43744 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728877AbgKPVLd (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Mon, 16 Nov 2020 16:11:33 -0500
Date:   Mon, 16 Nov 2020 21:11:29 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1605561090;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/IJkmjOb+Ort2DqlyBwVKVb8n3j/fB7rR5InM7yLooU=;
        b=gZ7Waexf6MICDEcKQFve/U3U2vAKB0TxP6qY1nezkk1IM9Uef//36l6YAxczy0Y3i+lQdp
        kiv+okh/AAjfZFRL+imPUSQDpENG/aFcf4OIa0JoD2lo5e4EJ0fQCeAMtQElpOILhPCDl/
        81dV0Tn/TPNHczG33Q8wQrE7NbTgbLhxbDK0cXzlUWbR6OwbyxPNdC/bmQRUdEvrxCrW7a
        6oBLGi97ZYD9J7P7NMDX4oDrDry85nxaKFOEE6+zPEp9QwvKXAhyq0Zwj6YjaN5Vz1R/yg
        61IqrKn0nnSZVR/rSTz+A0eCnqfNQwXEA3cUwNxuvE9KICA/FGfp5CpnETTOsA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1605561090;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/IJkmjOb+Ort2DqlyBwVKVb8n3j/fB7rR5InM7yLooU=;
        b=Hqbc69kCPLjRLgwi9ggcrb1zGffH++6+X7Tbau3YgMc9YLYrTmc6q8jU5ZJFNT+RZIq12p
        bzYB8927asrQn1Ag==
From:   "tip-bot2 for Gabriel Krisman Bertazi" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/entry] entry: Drop usage of TIF flags in the generic syscall code
Cc:     Gabriel Krisman Bertazi <krisman@collabora.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andy Lutomirski <luto@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20201116174206.2639648-10-krisman@collabora.com>
References: <20201116174206.2639648-10-krisman@collabora.com>
MIME-Version: 1.0
Message-ID: <160556108956.11244.6109673820343585025.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the core/entry branch of tip:

Commit-ID:     2991552447707d791d9d81a5dc161f9e9e90b163
Gitweb:        https://git.kernel.org/tip/2991552447707d791d9d81a5dc161f9e9e90b163
Author:        Gabriel Krisman Bertazi <krisman@collabora.com>
AuthorDate:    Mon, 16 Nov 2020 12:42:05 -05:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Mon, 16 Nov 2020 21:53:16 +01:00

entry: Drop usage of TIF flags in the generic syscall code

Now that the flags migration in the common syscall entry code is complete
and the code relies exclusively on thread_info::syscall_work, clean up the
accesses to TI flags in that path.

Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Andy Lutomirski <luto@kernel.org>
Link: https://lore.kernel.org/r/20201116174206.2639648-10-krisman@collabora.com
---
 include/linux/entry-common.h | 26 ++++++++++++--------------
 kernel/entry/common.c        | 17 +++++++----------
 2 files changed, 19 insertions(+), 24 deletions(-)

diff --git a/include/linux/entry-common.h b/include/linux/entry-common.h
index d7b96f4..49b26b2 100644
--- a/include/linux/entry-common.h
+++ b/include/linux/entry-common.h
@@ -26,31 +26,29 @@
 #endif
 
 /*
- * TIF flags handled in syscall_enter_from_user_mode()
+ * SYSCALL_WORK flags handled in syscall_enter_from_user_mode()
  */
-#ifndef ARCH_SYSCALL_ENTER_WORK
-# define ARCH_SYSCALL_ENTER_WORK	(0)
+#ifndef ARCH_SYSCALL_WORK_ENTER
+# define ARCH_SYSCALL_WORK_ENTER	(0)
 #endif
 
-#define SYSCALL_ENTER_WORK ARCH_SYSCALL_ENTER_WORK
-
 /*
- * TIF flags handled in syscall_exit_to_user_mode()
+ * SYSCALL_WORK flags handled in syscall_exit_to_user_mode()
  */
-#ifndef ARCH_SYSCALL_EXIT_WORK
-# define ARCH_SYSCALL_EXIT_WORK		(0)
+#ifndef ARCH_SYSCALL_WORK_EXIT
+# define ARCH_SYSCALL_WORK_EXIT		(0)
 #endif
 
-#define SYSCALL_EXIT_WORK ARCH_SYSCALL_EXIT_WORK
-
 #define SYSCALL_WORK_ENTER	(SYSCALL_WORK_SECCOMP |			\
 				 SYSCALL_WORK_SYSCALL_TRACEPOINT |	\
 				 SYSCALL_WORK_SYSCALL_TRACE |		\
 				 SYSCALL_WORK_SYSCALL_EMU |		\
-				 SYSCALL_WORK_SYSCALL_AUDIT)
+				 SYSCALL_WORK_SYSCALL_AUDIT |		\
+				 ARCH_SYSCALL_WORK_ENTER)
 #define SYSCALL_WORK_EXIT	(SYSCALL_WORK_SYSCALL_TRACEPOINT |	\
 				 SYSCALL_WORK_SYSCALL_TRACE |		\
-				 SYSCALL_WORK_SYSCALL_AUDIT)
+				 SYSCALL_WORK_SYSCALL_AUDIT |		\
+				 ARCH_SYSCALL_WORK_EXIT)
 
 /*
  * TIF flags handled in exit_to_user_mode_loop()
@@ -136,8 +134,8 @@ void syscall_enter_from_user_mode_prepare(struct pt_regs *regs);
  *
  * It handles the following work items:
  *
- *  1) TIF flag dependent invocations of arch_syscall_enter_tracehook(),
- *     __secure_computing(), trace_sys_enter()
+ *  1) syscall_work flag dependent invocations of
+ *     arch_syscall_enter_tracehook(), __secure_computing(), trace_sys_enter()
  *  2) Invocation of audit_syscall_entry()
  */
 long syscall_enter_from_user_mode_work(struct pt_regs *regs, long syscall);
diff --git a/kernel/entry/common.c b/kernel/entry/common.c
index 90533f3..91e8fd5 100644
--- a/kernel/entry/common.c
+++ b/kernel/entry/common.c
@@ -42,7 +42,7 @@ static inline void syscall_enter_audit(struct pt_regs *regs, long syscall)
 }
 
 static long syscall_trace_enter(struct pt_regs *regs, long syscall,
-				unsigned long ti_work, unsigned long work)
+				unsigned long work)
 {
 	long ret = 0;
 
@@ -75,11 +75,9 @@ static __always_inline long
 __syscall_enter_from_user_work(struct pt_regs *regs, long syscall)
 {
 	unsigned long work = READ_ONCE(current_thread_info()->syscall_work);
-	unsigned long ti_work;
 
-	ti_work = READ_ONCE(current_thread_info()->flags);
-	if (work & SYSCALL_WORK_ENTER || ti_work & SYSCALL_ENTER_WORK)
-		syscall = syscall_trace_enter(regs, syscall, ti_work, work);
+	if (work & SYSCALL_WORK_ENTER)
+		syscall = syscall_trace_enter(regs, syscall, work);
 
 	return syscall;
 }
@@ -227,8 +225,8 @@ static inline bool report_single_step(unsigned long work)
 }
 #endif
 
-static void syscall_exit_work(struct pt_regs *regs, unsigned long ti_work,
-			      unsigned long work)
+
+static void syscall_exit_work(struct pt_regs *regs, unsigned long work)
 {
 	bool step;
 
@@ -249,7 +247,6 @@ static void syscall_exit_work(struct pt_regs *regs, unsigned long ti_work,
 static void syscall_exit_to_user_mode_prepare(struct pt_regs *regs)
 {
 	unsigned long work = READ_ONCE(current_thread_info()->syscall_work);
-	u32 cached_flags = READ_ONCE(current_thread_info()->flags);
 	unsigned long nr = syscall_get_nr(current, regs);
 
 	CT_WARN_ON(ct_state() != CONTEXT_KERNEL);
@@ -266,8 +263,8 @@ static void syscall_exit_to_user_mode_prepare(struct pt_regs *regs)
 	 * enabled, we want to run them exactly once per syscall exit with
 	 * interrupts enabled.
 	 */
-	if (unlikely(work & SYSCALL_WORK_EXIT || cached_flags & SYSCALL_EXIT_WORK))
-		syscall_exit_work(regs, cached_flags, work);
+	if (unlikely(work & SYSCALL_WORK_EXIT))
+		syscall_exit_work(regs, work);
 }
 
 __visible noinstr void syscall_exit_to_user_mode(struct pt_regs *regs)
