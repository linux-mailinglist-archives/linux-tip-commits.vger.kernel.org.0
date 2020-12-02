Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 418B52CB92A
	for <lists+linux-tip-commits@lfdr.de>; Wed,  2 Dec 2020 10:41:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728490AbgLBJjv (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 2 Dec 2020 04:39:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388307AbgLBJjc (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 2 Dec 2020 04:39:32 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E52CBC061A47;
        Wed,  2 Dec 2020 01:38:30 -0800 (PST)
Date:   Wed, 02 Dec 2020 09:38:27 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1606901908;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SDUeAngXNOwf9/sLJqUfNg0HN1clz5Ofr3sPI0C/aQ8=;
        b=Zx77TA/zZ/EZPT5K2oYQZh9N63B8orqumSXi7+JB4DtK8tLr06Mry3MQZPdaUVWesCAhUc
        RGwWk31uwpDmewgg4Epu9cc94Ha92lZqI6zUAUq6BBFxs6uut4EM4ele6taymITJfPhaRj
        yHSEB8UNonlBs2QtFu7s/nfrbkmDk1pfi2QQfnNor20q9aTCIinoECUJ4uYFzptljZErkM
        cmtfU8O5W4FpldhvU7gci9dfJucMVV9+KAN+B25Kxp9A7dPiipBXmSB1MSSIJwGjRQVlVe
        cSvIEIzs/pMINDGooFBGYRFjGp2DfO8cqk5h85Bp9HpCHbBYNcynuWDpvb7jBg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1606901908;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SDUeAngXNOwf9/sLJqUfNg0HN1clz5Ofr3sPI0C/aQ8=;
        b=v5PqOgmMTQr+30bUdGDIzo8H+TYcFoULoHnknY4ZU2gJjNZIlDVKIN0S87Z3SB0IxloNyM
        jd60+Z2T8lhTngAw==
From:   "tip-bot2 for Gabriel Krisman Bertazi" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/entry] kernel: Implement selective syscall userspace redirection
Cc:     Gabriel Krisman Bertazi <krisman@collabora.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andy Lutomirski <luto@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Kees Cook <keescook@chromium.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20201127193238.821364-4-krisman@collabora.com>
References: <20201127193238.821364-4-krisman@collabora.com>
MIME-Version: 1.0
Message-ID: <160690190770.3364.5119373826178425644.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the core/entry branch of tip:

Commit-ID:     7a2cc679e8bb5bfdeef28ec80dc3c34edbc099fd
Gitweb:        https://git.kernel.org/tip/7a2cc679e8bb5bfdeef28ec80dc3c34edbc099fd
Author:        Gabriel Krisman Bertazi <krisman@collabora.com>
AuthorDate:    Fri, 27 Nov 2020 14:32:34 -05:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 02 Dec 2020 10:32:17 +01:00

kernel: Implement selective syscall userspace redirection

Introduce a mechanism to quickly disable/enable syscall handling for a
specific process and redirect to userspace via SIGSYS.  This is useful
for processes with parts that require syscall redirection and parts that
don't, but who need to perform this boundary crossing really fast,
without paying the cost of a system call to reconfigure syscall handling
on each boundary transition.  This is particularly important for Windows
games running over Wine.

The proposed interface looks like this:

  prctl(PR_SET_SYSCALL_USER_DISPATCH, <op>, <off>, <length>, [selector])

The range [<offset>,<offset>+<length>) is a part of the process memory
map that is allowed to by-pass the redirection code and dispatch
syscalls directly, such that in fast paths a process doesn't need to
disable the trap nor the kernel has to check the selector.  This is
essential to return from SIGSYS to a blocked area without triggering
another SIGSYS from rt_sigreturn.

selector is an optional pointer to a char-sized userspace memory region
that has a key switch for the mechanism. This key switch is set to
either PR_SYS_DISPATCH_ON, PR_SYS_DISPATCH_OFF to enable and disable the
redirection without calling the kernel.

The feature is meant to be set per-thread and it is disabled on
fork/clone/execv.

Internally, this doesn't add overhead to the syscall hot path, and it
requires very little per-architecture support.  I avoided using seccomp,
even though it duplicates some functionality, due to previous feedback
that maybe it shouldn't mix with seccomp since it is not a security
mechanism.  And obviously, this should never be considered a security
mechanism, since any part of the program can by-pass it by using the
syscall dispatcher.

For the sysinfo benchmark, which measures the overhead added to
executing a native syscall that doesn't require interception, the
overhead using only the direct dispatcher region to issue syscalls is
pretty much irrelevant.  The overhead of using the selector goes around
40ns for a native (unredirected) syscall in my system, and it is (as
expected) dominated by the supervisor-mode user-address access.  In
fact, with SMAP off, the overhead is consistently less than 5ns on my
test box.

Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Andy Lutomirski <luto@kernel.org>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Kees Cook <keescook@chromium.org>
Link: https://lore.kernel.org/r/20201127193238.821364-4-krisman@collabora.com

---
 fs/exec.c                             |   3 +-
 include/linux/sched.h                 |   2 +-
 include/linux/syscall_user_dispatch.h |  40 ++++++++++-
 include/linux/thread_info.h           |   2 +-
 include/uapi/linux/prctl.h            |   5 +-
 kernel/entry/Makefile                 |   2 +-
 kernel/entry/common.h                 |   7 ++-
 kernel/entry/syscall_user_dispatch.c  | 102 +++++++++++++++++++++++++-
 kernel/fork.c                         |   1 +-
 kernel/sys.c                          |   5 +-
 10 files changed, 168 insertions(+), 1 deletion(-)
 create mode 100644 include/linux/syscall_user_dispatch.h
 create mode 100644 kernel/entry/common.h
 create mode 100644 kernel/entry/syscall_user_dispatch.c

diff --git a/fs/exec.c b/fs/exec.c
index 547a239..aee36e5 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -64,6 +64,7 @@
 #include <linux/compat.h>
 #include <linux/vmalloc.h>
 #include <linux/io_uring.h>
+#include <linux/syscall_user_dispatch.h>
 
 #include <linux/uaccess.h>
 #include <asm/mmu_context.h>
@@ -1302,6 +1303,8 @@ int begin_new_exec(struct linux_binprm * bprm)
 	flush_thread();
 	me->personality &= ~bprm->per_clear;
 
+	clear_syscall_work_syscall_user_dispatch(me);
+
 	/*
 	 * We have to apply CLOEXEC before we change whether the process is
 	 * dumpable (in setup_new_exec) to avoid a race with a process in userspace
diff --git a/include/linux/sched.h b/include/linux/sched.h
index 063cd12..5a24a03 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -28,6 +28,7 @@
 #include <linux/sched/prio.h>
 #include <linux/sched/types.h>
 #include <linux/signal_types.h>
+#include <linux/syscall_user_dispatch.h>
 #include <linux/mm_types_task.h>
 #include <linux/task_io_accounting.h>
 #include <linux/posix-timers.h>
@@ -965,6 +966,7 @@ struct task_struct {
 	unsigned int			sessionid;
 #endif
 	struct seccomp			seccomp;
+	struct syscall_user_dispatch	syscall_dispatch;
 
 	/* Thread group tracking: */
 	u64				parent_exec_id;
diff --git a/include/linux/syscall_user_dispatch.h b/include/linux/syscall_user_dispatch.h
new file mode 100644
index 0000000..a0ae443
--- /dev/null
+++ b/include/linux/syscall_user_dispatch.h
@@ -0,0 +1,40 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) 2020 Collabora Ltd.
+ */
+#ifndef _SYSCALL_USER_DISPATCH_H
+#define _SYSCALL_USER_DISPATCH_H
+
+#include <linux/thread_info.h>
+
+#ifdef CONFIG_GENERIC_ENTRY
+
+struct syscall_user_dispatch {
+	char __user	*selector;
+	unsigned long	offset;
+	unsigned long	len;
+	bool		on_dispatch;
+};
+
+int set_syscall_user_dispatch(unsigned long mode, unsigned long offset,
+			      unsigned long len, char __user *selector);
+
+#define clear_syscall_work_syscall_user_dispatch(tsk) \
+	clear_task_syscall_work(tsk, SYSCALL_USER_DISPATCH)
+
+#else
+struct syscall_user_dispatch {};
+
+static inline int set_syscall_user_dispatch(unsigned long mode, unsigned long offset,
+					    unsigned long len, char __user *selector)
+{
+	return -EINVAL;
+}
+
+static inline void clear_syscall_work_syscall_user_dispatch(struct task_struct *tsk)
+{
+}
+
+#endif /* CONFIG_GENERIC_ENTRY */
+
+#endif /* _SYSCALL_USER_DISPATCH_H */
diff --git a/include/linux/thread_info.h b/include/linux/thread_info.h
index ca80a21..c8a974c 100644
--- a/include/linux/thread_info.h
+++ b/include/linux/thread_info.h
@@ -42,6 +42,7 @@ enum syscall_work_bit {
 	SYSCALL_WORK_BIT_SYSCALL_TRACE,
 	SYSCALL_WORK_BIT_SYSCALL_EMU,
 	SYSCALL_WORK_BIT_SYSCALL_AUDIT,
+	SYSCALL_WORK_BIT_SYSCALL_USER_DISPATCH,
 };
 
 #define SYSCALL_WORK_SECCOMP		BIT(SYSCALL_WORK_BIT_SECCOMP)
@@ -49,6 +50,7 @@ enum syscall_work_bit {
 #define SYSCALL_WORK_SYSCALL_TRACE	BIT(SYSCALL_WORK_BIT_SYSCALL_TRACE)
 #define SYSCALL_WORK_SYSCALL_EMU	BIT(SYSCALL_WORK_BIT_SYSCALL_EMU)
 #define SYSCALL_WORK_SYSCALL_AUDIT	BIT(SYSCALL_WORK_BIT_SYSCALL_AUDIT)
+#define SYSCALL_WORK_SYSCALL_USER_DISPATCH BIT(SYSCALL_WORK_BIT_SYSCALL_USER_DISPATCH)
 #endif
 
 #include <asm/thread_info.h>
diff --git a/include/uapi/linux/prctl.h b/include/uapi/linux/prctl.h
index 7f08277..90deb41 100644
--- a/include/uapi/linux/prctl.h
+++ b/include/uapi/linux/prctl.h
@@ -247,4 +247,9 @@ struct prctl_mm_map {
 #define PR_SET_IO_FLUSHER		57
 #define PR_GET_IO_FLUSHER		58
 
+/* Dispatch syscalls to a userspace handler */
+#define PR_SET_SYSCALL_USER_DISPATCH	59
+# define PR_SYS_DISPATCH_OFF		0
+# define PR_SYS_DISPATCH_ON		1
+
 #endif /* _LINUX_PRCTL_H */
diff --git a/kernel/entry/Makefile b/kernel/entry/Makefile
index 34c8a3f..095c775 100644
--- a/kernel/entry/Makefile
+++ b/kernel/entry/Makefile
@@ -9,5 +9,5 @@ KCOV_INSTRUMENT := n
 CFLAGS_REMOVE_common.o	 = -fstack-protector -fstack-protector-strong
 CFLAGS_common.o		+= -fno-stack-protector
 
-obj-$(CONFIG_GENERIC_ENTRY) 		+= common.o
+obj-$(CONFIG_GENERIC_ENTRY) 		+= common.o syscall_user_dispatch.o
 obj-$(CONFIG_KVM_XFER_TO_GUEST_WORK)	+= kvm.o
diff --git a/kernel/entry/common.h b/kernel/entry/common.h
new file mode 100644
index 0000000..f6e6d02
--- /dev/null
+++ b/kernel/entry/common.h
@@ -0,0 +1,7 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _COMMON_H
+#define _COMMON_H
+
+bool syscall_user_dispatch(struct pt_regs *regs);
+
+#endif
diff --git a/kernel/entry/syscall_user_dispatch.c b/kernel/entry/syscall_user_dispatch.c
new file mode 100644
index 0000000..8e9199b
--- /dev/null
+++ b/kernel/entry/syscall_user_dispatch.c
@@ -0,0 +1,102 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2020 Collabora Ltd.
+ */
+#include <linux/sched.h>
+#include <linux/prctl.h>
+#include <linux/syscall_user_dispatch.h>
+#include <linux/uaccess.h>
+#include <linux/signal.h>
+#include <linux/elf.h>
+
+#include <linux/sched/signal.h>
+#include <linux/sched/task_stack.h>
+
+#include <asm/syscall.h>
+
+static void trigger_sigsys(struct pt_regs *regs)
+{
+	struct kernel_siginfo info;
+
+	clear_siginfo(&info);
+	info.si_signo = SIGSYS;
+	info.si_code = SYS_USER_DISPATCH;
+	info.si_call_addr = (void __user *)KSTK_EIP(current);
+	info.si_errno = 0;
+	info.si_arch = syscall_get_arch(current);
+	info.si_syscall = syscall_get_nr(current, regs);
+
+	force_sig_info(&info);
+}
+
+bool syscall_user_dispatch(struct pt_regs *regs)
+{
+	struct syscall_user_dispatch *sd = &current->syscall_dispatch;
+	char state;
+
+	if (likely(instruction_pointer(regs) - sd->offset < sd->len))
+		return false;
+
+	if (unlikely(arch_syscall_is_vdso_sigreturn(regs)))
+		return false;
+
+	if (likely(sd->selector)) {
+		/*
+		 * access_ok() is performed once, at prctl time, when
+		 * the selector is loaded by userspace.
+		 */
+		if (unlikely(__get_user(state, sd->selector)))
+			do_exit(SIGSEGV);
+
+		if (likely(state == PR_SYS_DISPATCH_OFF))
+			return false;
+
+		if (state != PR_SYS_DISPATCH_ON)
+			do_exit(SIGSYS);
+	}
+
+	sd->on_dispatch = true;
+	syscall_rollback(current, regs);
+	trigger_sigsys(regs);
+
+	return true;
+}
+
+int set_syscall_user_dispatch(unsigned long mode, unsigned long offset,
+			      unsigned long len, char __user *selector)
+{
+	switch (mode) {
+	case PR_SYS_DISPATCH_OFF:
+		if (offset || len || selector)
+			return -EINVAL;
+		break;
+	case PR_SYS_DISPATCH_ON:
+		/*
+		 * Validate the direct dispatcher region just for basic
+		 * sanity against overflow and a 0-sized dispatcher
+		 * region.  If the user is able to submit a syscall from
+		 * an address, that address is obviously valid.
+		 */
+		if (offset && offset + len <= offset)
+			return -EINVAL;
+
+		if (selector && !access_ok(selector, sizeof(*selector)))
+			return -EFAULT;
+
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	current->syscall_dispatch.selector = selector;
+	current->syscall_dispatch.offset = offset;
+	current->syscall_dispatch.len = len;
+	current->syscall_dispatch.on_dispatch = false;
+
+	if (mode == PR_SYS_DISPATCH_ON)
+		set_syscall_work(SYSCALL_USER_DISPATCH);
+	else
+		clear_syscall_work(SYSCALL_USER_DISPATCH);
+
+	return 0;
+}
diff --git a/kernel/fork.c b/kernel/fork.c
index 02b689a..4a5ecb4 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -906,6 +906,7 @@ static struct task_struct *dup_task_struct(struct task_struct *orig, int node)
 	clear_user_return_notifier(tsk);
 	clear_tsk_need_resched(tsk);
 	set_task_stack_end_magic(tsk);
+	clear_syscall_work_syscall_user_dispatch(tsk);
 
 #ifdef CONFIG_STACKPROTECTOR
 	tsk->stack_canary = get_random_canary();
diff --git a/kernel/sys.c b/kernel/sys.c
index a730c03..51f00fe 100644
--- a/kernel/sys.c
+++ b/kernel/sys.c
@@ -42,6 +42,7 @@
 #include <linux/syscore_ops.h>
 #include <linux/version.h>
 #include <linux/ctype.h>
+#include <linux/syscall_user_dispatch.h>
 
 #include <linux/compat.h>
 #include <linux/syscalls.h>
@@ -2530,6 +2531,10 @@ SYSCALL_DEFINE5(prctl, int, option, unsigned long, arg2, unsigned long, arg3,
 
 		error = (current->flags & PR_IO_FLUSHER) == PR_IO_FLUSHER;
 		break;
+	case PR_SET_SYSCALL_USER_DISPATCH:
+		error = set_syscall_user_dispatch(arg2, arg3, arg4,
+						  (char __user *) arg5);
+		break;
 	default:
 		error = -EINVAL;
 		break;
