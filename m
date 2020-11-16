Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 31DCD2B537E
	for <lists+linux-tip-commits@lfdr.de>; Mon, 16 Nov 2020 22:13:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732625AbgKPVLg (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Mon, 16 Nov 2020 16:11:36 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:43760 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731765AbgKPVLe (ORCPT
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
        bh=eVyKf1okBTcreoNpQz5wM1xAEpTQ89MgtQUwYQ4GK64=;
        b=ybuE6lgjOa+Z+tCNo3p2HMqu/rOMeaND7OGjSBzO3tnoNzBvOOWqEPx5CLNjvBUW5MU67Y
        wxb9m5Io0/diG8W6uCXTKFdQk3rBgLfCaZEGxDV4nXhkqKXR5oAj1CJYE2st0TjQnZNAxo
        DNQYqdMhmtYXg3NX7IGuiE5gGrGRPLNJhX6c3b1ToXJ50Pn9KSBJoAIOaDAACHtOkHXx+d
        866SIgb0KvpLVIXdVeLeLg0X7aUZ4IQBuGtMXK3bgjz1ycdeDyCgdMgvvtwhRlPY9TYcn3
        UHmrE7FWREohb/Pud+AsLc8+uycSDKqsy/vzXiNVIrO3zKXXRPHX5EafWAvWZw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1605561091;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=eVyKf1okBTcreoNpQz5wM1xAEpTQ89MgtQUwYQ4GK64=;
        b=OU9osWCFkERmjoGfyG7vcTsB22gM+NHdBZ04RAeQb3rrvZPVek2vW1K7FkDMTQgIOy8ac5
        z/2PCV8eeevs9FDA==
From:   "tip-bot2 for Gabriel Krisman Bertazi" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/entry] ptrace: Migrate TIF_SYSCALL_EMU to use SYSCALL_WORK flag
Cc:     Gabriel Krisman Bertazi <krisman@collabora.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andy Lutomirski <luto@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20201116174206.2639648-8-krisman@collabora.com>
References: <20201116174206.2639648-8-krisman@collabora.com>
MIME-Version: 1.0
Message-ID: <160556109081.11244.17452013208698495908.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the core/entry branch of tip:

Commit-ID:     64eb35f701f04b30706e21d1b02636b5d31a37d2
Gitweb:        https://git.kernel.org/tip/64eb35f701f04b30706e21d1b02636b5d31a37d2
Author:        Gabriel Krisman Bertazi <krisman@collabora.com>
AuthorDate:    Mon, 16 Nov 2020 12:42:03 -05:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Mon, 16 Nov 2020 21:53:16 +01:00

ptrace: Migrate TIF_SYSCALL_EMU to use SYSCALL_WORK flag

On architectures using the generic syscall entry code the architecture
independent syscall work is moved to flags in thread_info::syscall_work.
This removes architecture dependencies and frees up TIF bits.

Define SYSCALL_WORK_SYSCALL_EMU, use it in the generic entry code and
convert the code which uses the TIF specific helper functions to use the
new *_syscall_work() helpers which either resolve to the new mode for users
of the generic entry code or to the TIF based functions for the other
architectures.

Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Andy Lutomirski <luto@kernel.org>
Link: https://lore.kernel.org/r/20201116174206.2639648-8-krisman@collabora.com
---
 include/linux/entry-common.h |  8 ++------
 include/linux/thread_info.h  |  2 ++
 include/linux/tracehook.h    |  2 +-
 kernel/entry/common.c        | 19 ++++++++++---------
 kernel/fork.c                |  4 ++--
 kernel/ptrace.c              | 10 +++++-----
 6 files changed, 22 insertions(+), 23 deletions(-)

diff --git a/include/linux/entry-common.h b/include/linux/entry-common.h
index ae426ab..b30f82b 100644
--- a/include/linux/entry-common.h
+++ b/include/linux/entry-common.h
@@ -13,10 +13,6 @@
  * Define dummy _TIF work flags if not defined by the architecture or for
  * disabled functionality.
  */
-#ifndef _TIF_SYSCALL_EMU
-# define _TIF_SYSCALL_EMU		(0)
-#endif
-
 #ifndef _TIF_SYSCALL_AUDIT
 # define _TIF_SYSCALL_AUDIT		(0)
 #endif
@@ -42,7 +38,6 @@
 
 #define SYSCALL_ENTER_WORK						\
 	(_TIF_SYSCALL_AUDIT  |						\
-	 _TIF_SYSCALL_EMU |						\
 	 ARCH_SYSCALL_ENTER_WORK)
 
 /*
@@ -58,7 +53,8 @@
 
 #define SYSCALL_WORK_ENTER	(SYSCALL_WORK_SECCOMP |			\
 				 SYSCALL_WORK_SYSCALL_TRACEPOINT |	\
-				 SYSCALL_WORK_SYSCALL_TRACE)
+				 SYSCALL_WORK_SYSCALL_TRACE |		\
+				 SYSCALL_WORK_SYSCALL_EMU)
 #define SYSCALL_WORK_EXIT	(SYSCALL_WORK_SYSCALL_TRACEPOINT |	\
 				 SYSCALL_WORK_SYSCALL_TRACE)
 
diff --git a/include/linux/thread_info.h b/include/linux/thread_info.h
index 761a459..85b8a42 100644
--- a/include/linux/thread_info.h
+++ b/include/linux/thread_info.h
@@ -39,11 +39,13 @@ enum syscall_work_bit {
 	SYSCALL_WORK_BIT_SECCOMP,
 	SYSCALL_WORK_BIT_SYSCALL_TRACEPOINT,
 	SYSCALL_WORK_BIT_SYSCALL_TRACE,
+	SYSCALL_WORK_BIT_SYSCALL_EMU,
 };
 
 #define SYSCALL_WORK_SECCOMP		BIT(SYSCALL_WORK_BIT_SECCOMP)
 #define SYSCALL_WORK_SYSCALL_TRACEPOINT	BIT(SYSCALL_WORK_BIT_SYSCALL_TRACEPOINT)
 #define SYSCALL_WORK_SYSCALL_TRACE	BIT(SYSCALL_WORK_BIT_SYSCALL_TRACE)
+#define SYSCALL_WORK_SYSCALL_EMU	BIT(SYSCALL_WORK_BIT_SYSCALL_EMU)
 
 #include <asm/thread_info.h>
 
diff --git a/include/linux/tracehook.h b/include/linux/tracehook.h
index 3f20368..54b9252 100644
--- a/include/linux/tracehook.h
+++ b/include/linux/tracehook.h
@@ -84,7 +84,7 @@ static inline int ptrace_report_syscall(struct pt_regs *regs,
  * @regs:		user register state of current task
  *
  * This will be called if %SYSCALL_WORK_SYSCALL_TRACE or
- * %TIF_SYSCALL_EMU have been set, when the current task has just
+ * %SYSCALL_WORK_SYSCALL_EMU have been set, when the current task has just
  * entered the kernel for a system call.  Full user register state is
  * available here.  Changing the values in @regs can affect the system
  * call number and arguments to be tried.  It is safe to block here,
diff --git a/kernel/entry/common.c b/kernel/entry/common.c
index 917328a..90533f3 100644
--- a/kernel/entry/common.c
+++ b/kernel/entry/common.c
@@ -47,9 +47,9 @@ static long syscall_trace_enter(struct pt_regs *regs, long syscall,
 	long ret = 0;
 
 	/* Handle ptrace */
-	if (work & SYSCALL_WORK_SYSCALL_TRACE || ti_work & _TIF_SYSCALL_EMU) {
+	if (work & (SYSCALL_WORK_SYSCALL_TRACE | SYSCALL_WORK_SYSCALL_EMU)) {
 		ret = arch_syscall_enter_tracehook(regs);
-		if (ret || (ti_work & _TIF_SYSCALL_EMU))
+		if (ret || (work & SYSCALL_WORK_SYSCALL_EMU))
 			return -1L;
 	}
 
@@ -208,21 +208,22 @@ static void exit_to_user_mode_prepare(struct pt_regs *regs)
 }
 
 #ifndef _TIF_SINGLESTEP
-static inline bool report_single_step(unsigned long ti_work)
+static inline bool report_single_step(unsigned long work)
 {
 	return false;
 }
 #else
 /*
- * If TIF_SYSCALL_EMU is set, then the only reason to report is when
+ * If SYSCALL_EMU is set, then the only reason to report is when
  * TIF_SINGLESTEP is set (i.e. PTRACE_SYSEMU_SINGLESTEP).  This syscall
  * instruction has been already reported in syscall_enter_from_user_mode().
  */
-#define SYSEMU_STEP	(_TIF_SINGLESTEP | _TIF_SYSCALL_EMU)
-
-static inline bool report_single_step(unsigned long ti_work)
+static inline bool report_single_step(unsigned long work)
 {
-	return (ti_work & SYSEMU_STEP) == _TIF_SINGLESTEP;
+	if (!(work & SYSCALL_WORK_SYSCALL_EMU))
+		return false;
+
+	return !!(current_thread_info()->flags & _TIF_SINGLESTEP);
 }
 #endif
 
@@ -236,7 +237,7 @@ static void syscall_exit_work(struct pt_regs *regs, unsigned long ti_work,
 	if (work & SYSCALL_WORK_SYSCALL_TRACEPOINT)
 		trace_sys_exit(regs, syscall_get_return_value(current, regs));
 
-	step = report_single_step(ti_work);
+	step = report_single_step(work);
 	if (step || work & SYSCALL_WORK_SYSCALL_TRACE)
 		arch_syscall_exit_tracehook(regs, step);
 }
diff --git a/kernel/fork.c b/kernel/fork.c
index 99f68c2..02b689a 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -2159,8 +2159,8 @@ static __latent_entropy struct task_struct *copy_process(
 	 */
 	user_disable_single_step(p);
 	clear_task_syscall_work(p, SYSCALL_TRACE);
-#ifdef TIF_SYSCALL_EMU
-	clear_tsk_thread_flag(p, TIF_SYSCALL_EMU);
+#if defined(CONFIG_GENERIC_ENTRY) || defined(TIF_SYSCALL_EMU)
+	clear_task_syscall_work(p, SYSCALL_EMU);
 #endif
 	clear_tsk_latency_tracing(p);
 
diff --git a/kernel/ptrace.c b/kernel/ptrace.c
index 55a2bc3..237bcd6 100644
--- a/kernel/ptrace.c
+++ b/kernel/ptrace.c
@@ -118,8 +118,8 @@ void __ptrace_unlink(struct task_struct *child)
 	BUG_ON(!child->ptrace);
 
 	clear_task_syscall_work(child, SYSCALL_TRACE);
-#ifdef TIF_SYSCALL_EMU
-	clear_tsk_thread_flag(child, TIF_SYSCALL_EMU);
+#if defined(CONFIG_GENERIC_ENTRY) || defined(TIF_SYSCALL_EMU)
+	clear_task_syscall_work(child, SYSCALL_EMU);
 #endif
 
 	child->parent = child->real_parent;
@@ -816,11 +816,11 @@ static int ptrace_resume(struct task_struct *child, long request,
 	else
 		clear_task_syscall_work(child, SYSCALL_TRACE);
 
-#ifdef TIF_SYSCALL_EMU
+#if defined(CONFIG_GENERIC_ENTRY) || defined(TIF_SYSCALL_EMU)
 	if (request == PTRACE_SYSEMU || request == PTRACE_SYSEMU_SINGLESTEP)
-		set_tsk_thread_flag(child, TIF_SYSCALL_EMU);
+		set_task_syscall_work(child, SYSCALL_EMU);
 	else
-		clear_tsk_thread_flag(child, TIF_SYSCALL_EMU);
+		clear_task_syscall_work(child, SYSCALL_EMU);
 #endif
 
 	if (is_singleblock(request)) {
