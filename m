Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4BCA92B5378
	for <lists+linux-tip-commits@lfdr.de>; Mon, 16 Nov 2020 22:13:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732592AbgKPVLf (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Mon, 16 Nov 2020 16:11:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732029AbgKPVLe (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Mon, 16 Nov 2020 16:11:34 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2FBCC0613CF;
        Mon, 16 Nov 2020 13:11:33 -0800 (PST)
Date:   Mon, 16 Nov 2020 21:11:31 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1605561092;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bKMVurXJYeWc7FV5f9w8J268d0m1ws1NERf2G9DLF+A=;
        b=TL1onblKfw7SxB2loItY8/dYio4quf022Opis8iRvx3/DYGGSnkYMu8Wmvkj5+xnK0AQaZ
        dcf3tkSqFb9XHJ9cY0/VFWvLfRwGJxLWEH5VcpCgVDBiMCq7gbazLDWXfmbb7SUNGq5lfB
        KCttBt/LxEBFvwQgR0DGTjeyxo5jeZEe0U0lXWZ19EHC5dpUL9NpH70KQaFHWOlN5cP5ND
        64DeGMN3Ztcg0LsJuRAPcHEzLma7EI5XfMlAaS38c3A4WFeLx+fID26aFNpQQaCZ/BIJtJ
        qcBjr86u/P0iLyQwM8qB78+onl8+rxSQ6dpTVG8SET7a6nx9eK0hBiUIHj7DIw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1605561092;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bKMVurXJYeWc7FV5f9w8J268d0m1ws1NERf2G9DLF+A=;
        b=iy8gIdGOtePClrJjyeGuAFidUg7pChgLMPKyIwg3ksmD6RMNRJvUK7TV8tlHCXeXF9npk6
        GxjV8z1Mr/rcBtAA==
From:   "tip-bot2 for Gabriel Krisman Bertazi" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/entry] ptrace: Migrate to use SYSCALL_TRACE flag
Cc:     Gabriel Krisman Bertazi <krisman@collabora.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andy Lutomirski <luto@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20201116174206.2639648-7-krisman@collabora.com>
References: <20201116174206.2639648-7-krisman@collabora.com>
MIME-Version: 1.0
Message-ID: <160556109138.11244.2912031193988655698.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the core/entry branch of tip:

Commit-ID:     64c19ba29b66e98af9306b4a7525fb22c895d252
Gitweb:        https://git.kernel.org/tip/64c19ba29b66e98af9306b4a7525fb22c895d252
Author:        Gabriel Krisman Bertazi <krisman@collabora.com>
AuthorDate:    Mon, 16 Nov 2020 12:42:02 -05:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Mon, 16 Nov 2020 21:53:16 +01:00

ptrace: Migrate to use SYSCALL_TRACE flag

On architectures using the generic syscall entry code the architecture
independent syscall work is moved to flags in thread_info::syscall_work.
This removes architecture dependencies and frees up TIF bits.

Define SYSCALL_WORK_SYSCALL_TRACE, use it in the generic entry code and
convert the code which uses the TIF specific helper functions to use the
new *_syscall_work() helpers which either resolve to the new mode for users
of the generic entry code or to the TIF based functions for the other
architectures.

Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Andy Lutomirski <luto@kernel.org>
Link: https://lore.kernel.org/r/20201116174206.2639648-7-krisman@collabora.com


---
 include/asm-generic/syscall.h | 15 ++++++++-------
 include/linux/entry-common.h  | 10 ++++++----
 include/linux/thread_info.h   |  2 ++
 include/linux/tracehook.h     | 17 +++++++++--------
 kernel/entry/common.c         |  4 ++--
 kernel/fork.c                 |  2 +-
 kernel/ptrace.c               |  6 +++---
 7 files changed, 31 insertions(+), 25 deletions(-)

diff --git a/include/asm-generic/syscall.h b/include/asm-generic/syscall.h
index 524d8e6..ed94e56 100644
--- a/include/asm-generic/syscall.h
+++ b/include/asm-generic/syscall.h
@@ -43,7 +43,7 @@ int syscall_get_nr(struct task_struct *task, struct pt_regs *regs);
  * @regs:	task_pt_regs() of @task
  *
  * It's only valid to call this when @task is stopped for system
- * call exit tracing (due to TIF_SYSCALL_TRACE or TIF_SYSCALL_AUDIT),
+ * call exit tracing (due to %SYSCALL_WORK_SYSCALL_TRACE or TIF_SYSCALL_AUDIT),
  * after tracehook_report_syscall_entry() returned nonzero to prevent
  * the system call from taking place.
  *
@@ -63,7 +63,7 @@ void syscall_rollback(struct task_struct *task, struct pt_regs *regs);
  * Returns 0 if the system call succeeded, or -ERRORCODE if it failed.
  *
  * It's only valid to call this when @task is stopped for tracing on exit
- * from a system call, due to %TIF_SYSCALL_TRACE or %TIF_SYSCALL_AUDIT.
+ * from a system call, due to %SYSCALL_WORK_SYSCALL_TRACE or %TIF_SYSCALL_AUDIT.
  */
 long syscall_get_error(struct task_struct *task, struct pt_regs *regs);
 
@@ -76,7 +76,7 @@ long syscall_get_error(struct task_struct *task, struct pt_regs *regs);
  * This value is meaningless if syscall_get_error() returned nonzero.
  *
  * It's only valid to call this when @task is stopped for tracing on exit
- * from a system call, due to %TIF_SYSCALL_TRACE or %TIF_SYSCALL_AUDIT.
+ * from a system call, due to %SYSCALL_WORK_SYSCALL_TRACE or %TIF_SYSCALL_AUDIT.
  */
 long syscall_get_return_value(struct task_struct *task, struct pt_regs *regs);
 
@@ -93,7 +93,7 @@ long syscall_get_return_value(struct task_struct *task, struct pt_regs *regs);
  * code; the user sees a failed system call with this errno code.
  *
  * It's only valid to call this when @task is stopped for tracing on exit
- * from a system call, due to %TIF_SYSCALL_TRACE or %TIF_SYSCALL_AUDIT.
+ * from a system call, due to %SYSCALL_WORK_SYSCALL_TRACE or %TIF_SYSCALL_AUDIT.
  */
 void syscall_set_return_value(struct task_struct *task, struct pt_regs *regs,
 			      int error, long val);
@@ -108,7 +108,7 @@ void syscall_set_return_value(struct task_struct *task, struct pt_regs *regs,
 *  @args[0], and so on.
  *
  * It's only valid to call this when @task is stopped for tracing on
- * entry to a system call, due to %TIF_SYSCALL_TRACE or %TIF_SYSCALL_AUDIT.
+ * entry to a system call, due to %SYSCALL_WORK_SYSCALL_TRACE or %TIF_SYSCALL_AUDIT.
  */
 void syscall_get_arguments(struct task_struct *task, struct pt_regs *regs,
 			   unsigned long *args);
@@ -123,7 +123,7 @@ void syscall_get_arguments(struct task_struct *task, struct pt_regs *regs,
  * The first argument gets value @args[0], and so on.
  *
  * It's only valid to call this when @task is stopped for tracing on
- * entry to a system call, due to %TIF_SYSCALL_TRACE or %TIF_SYSCALL_AUDIT.
+ * entry to a system call, due to %SYSCALL_WORK_SYSCALL_TRACE or %TIF_SYSCALL_AUDIT.
  */
 void syscall_set_arguments(struct task_struct *task, struct pt_regs *regs,
 			   const unsigned long *args);
@@ -135,7 +135,8 @@ void syscall_set_arguments(struct task_struct *task, struct pt_regs *regs,
  * Returns the AUDIT_ARCH_* based on the system call convention in use.
  *
  * It's only valid to call this when @task is stopped on entry to a system
- * call, due to %TIF_SYSCALL_TRACE, %TIF_SYSCALL_AUDIT, or %SYSCALL_WORK_SECCOMP.
+ * call, due to %SYSCALL_WORK_SYSCALL_TRACE, %TIF_SYSCALL_AUDIT, or
+ * %SYSCALL_WORK_SECCOMP.
  *
  * Architectures which permit CONFIG_HAVE_ARCH_SECCOMP_FILTER must
  * provide an implementation of this.
diff --git a/include/linux/entry-common.h b/include/linux/entry-common.h
index 2a01eee..ae426ab 100644
--- a/include/linux/entry-common.h
+++ b/include/linux/entry-common.h
@@ -41,7 +41,7 @@
 #endif
 
 #define SYSCALL_ENTER_WORK						\
-	(_TIF_SYSCALL_TRACE | _TIF_SYSCALL_AUDIT  |			\
+	(_TIF_SYSCALL_AUDIT  |						\
 	 _TIF_SYSCALL_EMU |						\
 	 ARCH_SYSCALL_ENTER_WORK)
 
@@ -53,12 +53,14 @@
 #endif
 
 #define SYSCALL_EXIT_WORK						\
-	(_TIF_SYSCALL_TRACE | _TIF_SYSCALL_AUDIT |			\
+	(_TIF_SYSCALL_AUDIT |						\
 	 ARCH_SYSCALL_EXIT_WORK)
 
 #define SYSCALL_WORK_ENTER	(SYSCALL_WORK_SECCOMP |			\
-				 SYSCALL_WORK_SYSCALL_TRACEPOINT)
-#define SYSCALL_WORK_EXIT	(SYSCALL_WORK_SYSCALL_TRACEPOINT)
+				 SYSCALL_WORK_SYSCALL_TRACEPOINT |	\
+				 SYSCALL_WORK_SYSCALL_TRACE)
+#define SYSCALL_WORK_EXIT	(SYSCALL_WORK_SYSCALL_TRACEPOINT |	\
+				 SYSCALL_WORK_SYSCALL_TRACE)
 
 /*
  * TIF flags handled in exit_to_user_mode_loop()
diff --git a/include/linux/thread_info.h b/include/linux/thread_info.h
index c232043..761a459 100644
--- a/include/linux/thread_info.h
+++ b/include/linux/thread_info.h
@@ -38,10 +38,12 @@ enum {
 enum syscall_work_bit {
 	SYSCALL_WORK_BIT_SECCOMP,
 	SYSCALL_WORK_BIT_SYSCALL_TRACEPOINT,
+	SYSCALL_WORK_BIT_SYSCALL_TRACE,
 };
 
 #define SYSCALL_WORK_SECCOMP		BIT(SYSCALL_WORK_BIT_SECCOMP)
 #define SYSCALL_WORK_SYSCALL_TRACEPOINT	BIT(SYSCALL_WORK_BIT_SYSCALL_TRACEPOINT)
+#define SYSCALL_WORK_SYSCALL_TRACE	BIT(SYSCALL_WORK_BIT_SYSCALL_TRACE)
 
 #include <asm/thread_info.h>
 
diff --git a/include/linux/tracehook.h b/include/linux/tracehook.h
index f7d82e4..3f20368 100644
--- a/include/linux/tracehook.h
+++ b/include/linux/tracehook.h
@@ -83,11 +83,12 @@ static inline int ptrace_report_syscall(struct pt_regs *regs,
  * tracehook_report_syscall_entry - task is about to attempt a system call
  * @regs:		user register state of current task
  *
- * This will be called if %TIF_SYSCALL_TRACE or %TIF_SYSCALL_EMU have been set,
- * when the current task has just entered the kernel for a system call.
- * Full user register state is available here.  Changing the values
- * in @regs can affect the system call number and arguments to be tried.
- * It is safe to block here, preventing the system call from beginning.
+ * This will be called if %SYSCALL_WORK_SYSCALL_TRACE or
+ * %TIF_SYSCALL_EMU have been set, when the current task has just
+ * entered the kernel for a system call.  Full user register state is
+ * available here.  Changing the values in @regs can affect the system
+ * call number and arguments to be tried.  It is safe to block here,
+ * preventing the system call from beginning.
  *
  * Returns zero normally, or nonzero if the calling arch code should abort
  * the system call.  That must prevent normal entry so no system call is
@@ -109,15 +110,15 @@ static inline __must_check int tracehook_report_syscall_entry(
  * @regs:		user register state of current task
  * @step:		nonzero if simulating single-step or block-step
  *
- * This will be called if %TIF_SYSCALL_TRACE has been set, when the
- * current task has just finished an attempted system call.  Full
+ * This will be called if %SYSCALL_WORK_SYSCALL_TRACE has been set, when
+ * the current task has just finished an attempted system call.  Full
  * user register state is available here.  It is safe to block here,
  * preventing signals from being processed.
  *
  * If @step is nonzero, this report is also in lieu of the normal
  * trap that would follow the system call instruction because
  * user_enable_block_step() or user_enable_single_step() was used.
- * In this case, %TIF_SYSCALL_TRACE might not be set.
+ * In this case, %SYSCALL_WORK_SYSCALL_TRACE might not be set.
  *
  * Called without locks, just before checking for pending signals.
  */
diff --git a/kernel/entry/common.c b/kernel/entry/common.c
index f651967..917328a 100644
--- a/kernel/entry/common.c
+++ b/kernel/entry/common.c
@@ -47,7 +47,7 @@ static long syscall_trace_enter(struct pt_regs *regs, long syscall,
 	long ret = 0;
 
 	/* Handle ptrace */
-	if (ti_work & (_TIF_SYSCALL_TRACE | _TIF_SYSCALL_EMU)) {
+	if (work & SYSCALL_WORK_SYSCALL_TRACE || ti_work & _TIF_SYSCALL_EMU) {
 		ret = arch_syscall_enter_tracehook(regs);
 		if (ret || (ti_work & _TIF_SYSCALL_EMU))
 			return -1L;
@@ -237,7 +237,7 @@ static void syscall_exit_work(struct pt_regs *regs, unsigned long ti_work,
 		trace_sys_exit(regs, syscall_get_return_value(current, regs));
 
 	step = report_single_step(ti_work);
-	if (step || ti_work & _TIF_SYSCALL_TRACE)
+	if (step || work & SYSCALL_WORK_SYSCALL_TRACE)
 		arch_syscall_exit_tracehook(regs, step);
 }
 
diff --git a/kernel/fork.c b/kernel/fork.c
index bc5b109..99f68c2 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -2158,7 +2158,7 @@ static __latent_entropy struct task_struct *copy_process(
 	 * child regardless of CLONE_PTRACE.
 	 */
 	user_disable_single_step(p);
-	clear_tsk_thread_flag(p, TIF_SYSCALL_TRACE);
+	clear_task_syscall_work(p, SYSCALL_TRACE);
 #ifdef TIF_SYSCALL_EMU
 	clear_tsk_thread_flag(p, TIF_SYSCALL_EMU);
 #endif
diff --git a/kernel/ptrace.c b/kernel/ptrace.c
index 43d6179..55a2bc3 100644
--- a/kernel/ptrace.c
+++ b/kernel/ptrace.c
@@ -117,7 +117,7 @@ void __ptrace_unlink(struct task_struct *child)
 	const struct cred *old_cred;
 	BUG_ON(!child->ptrace);
 
-	clear_tsk_thread_flag(child, TIF_SYSCALL_TRACE);
+	clear_task_syscall_work(child, SYSCALL_TRACE);
 #ifdef TIF_SYSCALL_EMU
 	clear_tsk_thread_flag(child, TIF_SYSCALL_EMU);
 #endif
@@ -812,9 +812,9 @@ static int ptrace_resume(struct task_struct *child, long request,
 		return -EIO;
 
 	if (request == PTRACE_SYSCALL)
-		set_tsk_thread_flag(child, TIF_SYSCALL_TRACE);
+		set_task_syscall_work(child, SYSCALL_TRACE);
 	else
-		clear_tsk_thread_flag(child, TIF_SYSCALL_TRACE);
+		clear_task_syscall_work(child, SYSCALL_TRACE);
 
 #ifdef TIF_SYSCALL_EMU
 	if (request == PTRACE_SYSEMU || request == PTRACE_SYSEMU_SINGLESTEP)
