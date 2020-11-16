Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DCADD2B5379
	for <lists+linux-tip-commits@lfdr.de>; Mon, 16 Nov 2020 22:13:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728877AbgKPVLf (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Mon, 16 Nov 2020 16:11:35 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:43754 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731756AbgKPVLe (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Mon, 16 Nov 2020 16:11:34 -0500
Date:   Mon, 16 Nov 2020 21:11:30 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1605561091;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ljUsIijDF1b9qNu7+vfC72Pvba0eTu579WtrVo8ILI0=;
        b=SN7QwMqeCY4rI8QyPVfsfUEuf3ElXurGxbl4W0rb+c/WU8BKF/Lh1v70sd6lfA6Blp9fiX
        9kdPKb20ZT85hTMRnWvhAkZFRI1lHJkKJTc8vpBSvAhcmxXEjEmURTpX05QtQOVU8hxh2q
        g3aGFhINquezKtKTg5KdkKQmVqiA6hFW8AxCr7HnyZHAprJhXMtwTJvGXqZHZnhiGxk/KF
        CntUo1k/Rqf8CvMSidyMTvRqptmXcw6KmIovt15CHMZ4ELtioZyDtItRwR8nGXgN7xS8IH
        hzZ05GJNRcEBv82h5lsdfAq+4ZoVF05AY+lCQcIFCRs/r+PH/DvThHajQaB3MQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1605561091;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ljUsIijDF1b9qNu7+vfC72Pvba0eTu579WtrVo8ILI0=;
        b=1R15jNUdyWorvwz8RjSTswQEY5qXDKtiysiPXl00lo08jEPRkcxFupxjpWdRjctLs9FZs7
        Oft7ablOd9NP4KCg==
From:   "tip-bot2 for Gabriel Krisman Bertazi" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/entry] audit: Migrate to use SYSCALL_WORK flag
Cc:     Gabriel Krisman Bertazi <krisman@collabora.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andy Lutomirski <luto@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20201116174206.2639648-9-krisman@collabora.com>
References: <20201116174206.2639648-9-krisman@collabora.com>
MIME-Version: 1.0
Message-ID: <160556109024.11244.10271549184704170445.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the core/entry branch of tip:

Commit-ID:     785dc4eb7fd74e3b7f4eac468457b633117e1aea
Gitweb:        https://git.kernel.org/tip/785dc4eb7fd74e3b7f4eac468457b633117e1aea
Author:        Gabriel Krisman Bertazi <krisman@collabora.com>
AuthorDate:    Mon, 16 Nov 2020 12:42:04 -05:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Mon, 16 Nov 2020 21:53:16 +01:00

audit: Migrate to use SYSCALL_WORK flag

On architectures using the generic syscall entry code the architecture
independent syscall work is moved to flags in thread_info::syscall_work.
This removes architecture dependencies and frees up TIF bits.

Define SYSCALL_WORK_SYSCALL_AUDIT, use it in the generic entry code and
convert the code which uses the TIF specific helper functions to use the
new *_syscall_work() helpers which either resolve to the new mode for users
of the generic entry code or to the TIF based functions for the other
architectures.

Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Andy Lutomirski <luto@kernel.org>
Link: https://lore.kernel.org/r/20201116174206.2639648-9-krisman@collabora.com
---
 include/asm-generic/syscall.h | 23 ++++++++++++++---------
 include/linux/entry-common.h  | 18 ++++++------------
 include/linux/thread_info.h   |  2 ++
 kernel/auditsc.c              |  4 ++--
 4 files changed, 24 insertions(+), 23 deletions(-)

diff --git a/include/asm-generic/syscall.h b/include/asm-generic/syscall.h
index ed94e56..524218a 100644
--- a/include/asm-generic/syscall.h
+++ b/include/asm-generic/syscall.h
@@ -43,9 +43,9 @@ int syscall_get_nr(struct task_struct *task, struct pt_regs *regs);
  * @regs:	task_pt_regs() of @task
  *
  * It's only valid to call this when @task is stopped for system
- * call exit tracing (due to %SYSCALL_WORK_SYSCALL_TRACE or TIF_SYSCALL_AUDIT),
- * after tracehook_report_syscall_entry() returned nonzero to prevent
- * the system call from taking place.
+ * call exit tracing (due to %SYSCALL_WORK_SYSCALL_TRACE or
+ * %SYSCALL_WORK_SYSCALL_AUDIT), after tracehook_report_syscall_entry()
+ * returned nonzero to prevent the system call from taking place.
  *
  * This rolls back the register state in @regs so it's as if the
  * system call instruction was a no-op.  The registers containing
@@ -63,7 +63,8 @@ void syscall_rollback(struct task_struct *task, struct pt_regs *regs);
  * Returns 0 if the system call succeeded, or -ERRORCODE if it failed.
  *
  * It's only valid to call this when @task is stopped for tracing on exit
- * from a system call, due to %SYSCALL_WORK_SYSCALL_TRACE or %TIF_SYSCALL_AUDIT.
+ * from a system call, due to %SYSCALL_WORK_SYSCALL_TRACE or
+ * %SYSCALL_WORK_SYSCALL_AUDIT.
  */
 long syscall_get_error(struct task_struct *task, struct pt_regs *regs);
 
@@ -76,7 +77,8 @@ long syscall_get_error(struct task_struct *task, struct pt_regs *regs);
  * This value is meaningless if syscall_get_error() returned nonzero.
  *
  * It's only valid to call this when @task is stopped for tracing on exit
- * from a system call, due to %SYSCALL_WORK_SYSCALL_TRACE or %TIF_SYSCALL_AUDIT.
+ * from a system call, due to %SYSCALL_WORK_SYSCALL_TRACE or
+ * %SYSCALL_WORK_SYSCALL_AUDIT.
  */
 long syscall_get_return_value(struct task_struct *task, struct pt_regs *regs);
 
@@ -93,7 +95,8 @@ long syscall_get_return_value(struct task_struct *task, struct pt_regs *regs);
  * code; the user sees a failed system call with this errno code.
  *
  * It's only valid to call this when @task is stopped for tracing on exit
- * from a system call, due to %SYSCALL_WORK_SYSCALL_TRACE or %TIF_SYSCALL_AUDIT.
+ * from a system call, due to %SYSCALL_WORK_SYSCALL_TRACE or
+ * %SYSCALL_WORK_SYSCALL_AUDIT.
  */
 void syscall_set_return_value(struct task_struct *task, struct pt_regs *regs,
 			      int error, long val);
@@ -108,7 +111,8 @@ void syscall_set_return_value(struct task_struct *task, struct pt_regs *regs,
 *  @args[0], and so on.
  *
  * It's only valid to call this when @task is stopped for tracing on
- * entry to a system call, due to %SYSCALL_WORK_SYSCALL_TRACE or %TIF_SYSCALL_AUDIT.
+ * entry to a system call, due to %SYSCALL_WORK_SYSCALL_TRACE or
+ * %SYSCALL_WORK_SYSCALL_AUDIT.
  */
 void syscall_get_arguments(struct task_struct *task, struct pt_regs *regs,
 			   unsigned long *args);
@@ -123,7 +127,8 @@ void syscall_get_arguments(struct task_struct *task, struct pt_regs *regs,
  * The first argument gets value @args[0], and so on.
  *
  * It's only valid to call this when @task is stopped for tracing on
- * entry to a system call, due to %SYSCALL_WORK_SYSCALL_TRACE or %TIF_SYSCALL_AUDIT.
+ * entry to a system call, due to %SYSCALL_WORK_SYSCALL_TRACE or
+ * %SYSCALL_WORK_SYSCALL_AUDIT.
  */
 void syscall_set_arguments(struct task_struct *task, struct pt_regs *regs,
 			   const unsigned long *args);
@@ -135,7 +140,7 @@ void syscall_set_arguments(struct task_struct *task, struct pt_regs *regs,
  * Returns the AUDIT_ARCH_* based on the system call convention in use.
  *
  * It's only valid to call this when @task is stopped on entry to a system
- * call, due to %SYSCALL_WORK_SYSCALL_TRACE, %TIF_SYSCALL_AUDIT, or
+ * call, due to %SYSCALL_WORK_SYSCALL_TRACE, %SYSCALL_WORK_SYSCALL_AUDIT, or
  * %SYSCALL_WORK_SECCOMP.
  *
  * Architectures which permit CONFIG_HAVE_ARCH_SECCOMP_FILTER must
diff --git a/include/linux/entry-common.h b/include/linux/entry-common.h
index b30f82b..d7b96f4 100644
--- a/include/linux/entry-common.h
+++ b/include/linux/entry-common.h
@@ -13,10 +13,6 @@
  * Define dummy _TIF work flags if not defined by the architecture or for
  * disabled functionality.
  */
-#ifndef _TIF_SYSCALL_AUDIT
-# define _TIF_SYSCALL_AUDIT		(0)
-#endif
-
 #ifndef _TIF_PATCH_PENDING
 # define _TIF_PATCH_PENDING		(0)
 #endif
@@ -36,9 +32,7 @@
 # define ARCH_SYSCALL_ENTER_WORK	(0)
 #endif
 
-#define SYSCALL_ENTER_WORK						\
-	(_TIF_SYSCALL_AUDIT  |						\
-	 ARCH_SYSCALL_ENTER_WORK)
+#define SYSCALL_ENTER_WORK ARCH_SYSCALL_ENTER_WORK
 
 /*
  * TIF flags handled in syscall_exit_to_user_mode()
@@ -47,16 +41,16 @@
 # define ARCH_SYSCALL_EXIT_WORK		(0)
 #endif
 
-#define SYSCALL_EXIT_WORK						\
-	(_TIF_SYSCALL_AUDIT |						\
-	 ARCH_SYSCALL_EXIT_WORK)
+#define SYSCALL_EXIT_WORK ARCH_SYSCALL_EXIT_WORK
 
 #define SYSCALL_WORK_ENTER	(SYSCALL_WORK_SECCOMP |			\
 				 SYSCALL_WORK_SYSCALL_TRACEPOINT |	\
 				 SYSCALL_WORK_SYSCALL_TRACE |		\
-				 SYSCALL_WORK_SYSCALL_EMU)
+				 SYSCALL_WORK_SYSCALL_EMU |		\
+				 SYSCALL_WORK_SYSCALL_AUDIT)
 #define SYSCALL_WORK_EXIT	(SYSCALL_WORK_SYSCALL_TRACEPOINT |	\
-				 SYSCALL_WORK_SYSCALL_TRACE)
+				 SYSCALL_WORK_SYSCALL_TRACE |		\
+				 SYSCALL_WORK_SYSCALL_AUDIT)
 
 /*
  * TIF flags handled in exit_to_user_mode_loop()
diff --git a/include/linux/thread_info.h b/include/linux/thread_info.h
index 85b8a42..3173632 100644
--- a/include/linux/thread_info.h
+++ b/include/linux/thread_info.h
@@ -40,12 +40,14 @@ enum syscall_work_bit {
 	SYSCALL_WORK_BIT_SYSCALL_TRACEPOINT,
 	SYSCALL_WORK_BIT_SYSCALL_TRACE,
 	SYSCALL_WORK_BIT_SYSCALL_EMU,
+	SYSCALL_WORK_BIT_SYSCALL_AUDIT,
 };
 
 #define SYSCALL_WORK_SECCOMP		BIT(SYSCALL_WORK_BIT_SECCOMP)
 #define SYSCALL_WORK_SYSCALL_TRACEPOINT	BIT(SYSCALL_WORK_BIT_SYSCALL_TRACEPOINT)
 #define SYSCALL_WORK_SYSCALL_TRACE	BIT(SYSCALL_WORK_BIT_SYSCALL_TRACE)
 #define SYSCALL_WORK_SYSCALL_EMU	BIT(SYSCALL_WORK_BIT_SYSCALL_EMU)
+#define SYSCALL_WORK_SYSCALL_AUDIT	BIT(SYSCALL_WORK_BIT_SYSCALL_AUDIT)
 
 #include <asm/thread_info.h>
 
diff --git a/kernel/auditsc.c b/kernel/auditsc.c
index 8dba8f0..c00aa58 100644
--- a/kernel/auditsc.c
+++ b/kernel/auditsc.c
@@ -952,7 +952,7 @@ int audit_alloc(struct task_struct *tsk)
 
 	state = audit_filter_task(tsk, &key);
 	if (state == AUDIT_DISABLED) {
-		clear_tsk_thread_flag(tsk, TIF_SYSCALL_AUDIT);
+		clear_task_syscall_work(tsk, SYSCALL_AUDIT);
 		return 0;
 	}
 
@@ -964,7 +964,7 @@ int audit_alloc(struct task_struct *tsk)
 	context->filterkey = key;
 
 	audit_set_context(tsk, context);
-	set_tsk_thread_flag(tsk, TIF_SYSCALL_AUDIT);
+	set_task_syscall_work(tsk, SYSCALL_AUDIT);
 	return 0;
 }
 
