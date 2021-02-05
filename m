Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A41953118C0
	for <lists+linux-tip-commits@lfdr.de>; Sat,  6 Feb 2021 03:49:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230292AbhBFCpN (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 5 Feb 2021 21:45:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231475AbhBFCkR (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 5 Feb 2021 21:40:17 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46B93C08ED88;
        Fri,  5 Feb 2021 15:25:31 -0800 (PST)
Date:   Fri, 05 Feb 2021 23:24:43 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1612567484;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BTXyt8OX82yB04ratLPQ6e/d85XDm/1dsBa9Nm4cATY=;
        b=AHoEkYNmtGpKmT0//Bi4Ga8NCN7enEco3YJxgLV2xsxlJidYCcOG+AM1u9AmcJ9jW/fdpP
        ze6V23zNRmjeYyRgZJiVW9XwtAu3zaFvkgbGNFA7O8vFRnqayemxivLsGNQICwT6BUb6Cv
        XOQQy0skruYJhKipD67mGFs8Za3ArD0HGjrp9LquWq/w5w52+t8alYQeYEpV2goyUA65XS
        EhHu6AMoDKOdQO7hgUN3itqCcRYzGdBxmNaD5L0hCxH7asg1K197N6ZGkiKV7rn6dV0JId
        u5geLtBHko/yfRpU0FfBErQDEMHJzDnruEtEjwGUdtppGFVOOyQwtVvT6kNrkg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1612567484;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BTXyt8OX82yB04ratLPQ6e/d85XDm/1dsBa9Nm4cATY=;
        b=GkUoXv9EC5lMbXTwJvBfXdJYHX4RVn4I7aJX0L3pplmJc/rWoDoxDtdVdMPxjRmPgeUmoH
        u3+GhHOa25UJfYAw==
From:   "tip-bot2 for Gabriel Krisman Bertazi" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/urgent] entry: Ensure trap after single-step on system call return
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Kyle Huey <me@kylehuey.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <87h7mtc9pr.fsf_-_@collabora.com>
References: <87h7mtc9pr.fsf_-_@collabora.com>
MIME-Version: 1.0
Message-ID: <161256748344.23325.10918166447470880122.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the core/urgent branch of tip:

Commit-ID:     6342adcaa683c2b705c24ed201dc11b35854c88d
Gitweb:        https://git.kernel.org/tip/6342adcaa683c2b705c24ed201dc11b35854c88d
Author:        Gabriel Krisman Bertazi <krisman@collabora.com>
AuthorDate:    Wed, 03 Feb 2021 13:00:48 -05:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Sat, 06 Feb 2021 00:21:42 +01:00

entry: Ensure trap after single-step on system call return

Commit 299155244770 ("entry: Drop usage of TIF flags in the generic syscall
code") introduced a bug on architectures using the generic syscall entry
code, in which processes stopped by PTRACE_SYSCALL do not trap on syscall
return after receiving a TIF_SINGLESTEP.

The reason is that the meaning of TIF_SINGLESTEP flag is overloaded to
cause the trap after a system call is executed, but since the above commit,
the syscall call handler only checks for the SYSCALL_WORK flags on the exit
work.

Split the meaning of TIF_SINGLESTEP such that it only means single-step
mode, and create a new type of SYSCALL_WORK to request a trap immediately
after a syscall in single-step mode.  In the current implementation, the
SYSCALL_WORK flag shadows the TIF_SINGLESTEP flag for simplicity.

Update x86 to flip this bit when a tracer enables single stepping.

Fixes: 299155244770 ("entry: Drop usage of TIF flags in the generic syscall code")
Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Kyle Huey <me@kylehuey.com>
Link: https://lore.kernel.org/r/87h7mtc9pr.fsf_-_@collabora.com

---
 arch/x86/include/asm/entry-common.h |  2 --
 arch/x86/kernel/step.c              | 10 ++++++++--
 include/linux/entry-common.h        |  1 +
 include/linux/thread_info.h         |  2 ++
 kernel/entry/common.c               | 12 ++----------
 5 files changed, 13 insertions(+), 14 deletions(-)

diff --git a/arch/x86/include/asm/entry-common.h b/arch/x86/include/asm/entry-common.h
index 6fe54b2..2b87b19 100644
--- a/arch/x86/include/asm/entry-common.h
+++ b/arch/x86/include/asm/entry-common.h
@@ -43,8 +43,6 @@ static __always_inline void arch_check_user_regs(struct pt_regs *regs)
 }
 #define arch_check_user_regs arch_check_user_regs
 
-#define ARCH_SYSCALL_EXIT_WORK		(_TIF_SINGLESTEP)
-
 static inline void arch_exit_to_user_mode_prepare(struct pt_regs *regs,
 						  unsigned long ti_work)
 {
diff --git a/arch/x86/kernel/step.c b/arch/x86/kernel/step.c
index 60d2c37..0f3c307 100644
--- a/arch/x86/kernel/step.c
+++ b/arch/x86/kernel/step.c
@@ -127,12 +127,17 @@ static int enable_single_step(struct task_struct *child)
 		regs->flags |= X86_EFLAGS_TF;
 
 	/*
-	 * Always set TIF_SINGLESTEP - this guarantees that
-	 * we single-step system calls etc..  This will also
+	 * Always set TIF_SINGLESTEP.  This will also
 	 * cause us to set TF when returning to user mode.
 	 */
 	set_tsk_thread_flag(child, TIF_SINGLESTEP);
 
+	/*
+	 * Ensure that a trap is triggered once stepping out of a system
+	 * call prior to executing any user instruction.
+	 */
+	set_task_syscall_work(child, SYSCALL_EXIT_TRAP);
+
 	oflags = regs->flags;
 
 	/* Set TF on the kernel stack.. */
@@ -230,6 +235,7 @@ void user_disable_single_step(struct task_struct *child)
 
 	/* Always clear TIF_SINGLESTEP... */
 	clear_tsk_thread_flag(child, TIF_SINGLESTEP);
+	clear_task_syscall_work(child, SYSCALL_EXIT_TRAP);
 
 	/* But touch TF only if it was set by us.. */
 	if (test_and_clear_tsk_thread_flag(child, TIF_FORCED_TF))
diff --git a/include/linux/entry-common.h b/include/linux/entry-common.h
index ca86a00..a104b29 100644
--- a/include/linux/entry-common.h
+++ b/include/linux/entry-common.h
@@ -46,6 +46,7 @@
 				 SYSCALL_WORK_SYSCALL_TRACE |		\
 				 SYSCALL_WORK_SYSCALL_AUDIT |		\
 				 SYSCALL_WORK_SYSCALL_USER_DISPATCH |	\
+				 SYSCALL_WORK_SYSCALL_EXIT_TRAP	|	\
 				 ARCH_SYSCALL_WORK_EXIT)
 
 /*
diff --git a/include/linux/thread_info.h b/include/linux/thread_info.h
index c8a974c..9b2158c 100644
--- a/include/linux/thread_info.h
+++ b/include/linux/thread_info.h
@@ -43,6 +43,7 @@ enum syscall_work_bit {
 	SYSCALL_WORK_BIT_SYSCALL_EMU,
 	SYSCALL_WORK_BIT_SYSCALL_AUDIT,
 	SYSCALL_WORK_BIT_SYSCALL_USER_DISPATCH,
+	SYSCALL_WORK_BIT_SYSCALL_EXIT_TRAP,
 };
 
 #define SYSCALL_WORK_SECCOMP		BIT(SYSCALL_WORK_BIT_SECCOMP)
@@ -51,6 +52,7 @@ enum syscall_work_bit {
 #define SYSCALL_WORK_SYSCALL_EMU	BIT(SYSCALL_WORK_BIT_SYSCALL_EMU)
 #define SYSCALL_WORK_SYSCALL_AUDIT	BIT(SYSCALL_WORK_BIT_SYSCALL_AUDIT)
 #define SYSCALL_WORK_SYSCALL_USER_DISPATCH BIT(SYSCALL_WORK_BIT_SYSCALL_USER_DISPATCH)
+#define SYSCALL_WORK_SYSCALL_EXIT_TRAP	BIT(SYSCALL_WORK_BIT_SYSCALL_EXIT_TRAP)
 #endif
 
 #include <asm/thread_info.h>
diff --git a/kernel/entry/common.c b/kernel/entry/common.c
index 6dd82be..f9d491b 100644
--- a/kernel/entry/common.c
+++ b/kernel/entry/common.c
@@ -209,15 +209,9 @@ static void exit_to_user_mode_prepare(struct pt_regs *regs)
 	lockdep_sys_exit();
 }
 
-#ifndef _TIF_SINGLESTEP
-static inline bool report_single_step(unsigned long work)
-{
-	return false;
-}
-#else
 /*
  * If SYSCALL_EMU is set, then the only reason to report is when
- * TIF_SINGLESTEP is set (i.e. PTRACE_SYSEMU_SINGLESTEP).  This syscall
+ * SINGLESTEP is set (i.e. PTRACE_SYSEMU_SINGLESTEP).  This syscall
  * instruction has been already reported in syscall_enter_from_user_mode().
  */
 static inline bool report_single_step(unsigned long work)
@@ -225,10 +219,8 @@ static inline bool report_single_step(unsigned long work)
 	if (work & SYSCALL_WORK_SYSCALL_EMU)
 		return false;
 
-	return !!(current_thread_info()->flags & _TIF_SINGLESTEP);
+	return work & SYSCALL_WORK_SYSCALL_EXIT_TRAP;
 }
-#endif
-
 
 static void syscall_exit_work(struct pt_regs *regs, unsigned long work)
 {
