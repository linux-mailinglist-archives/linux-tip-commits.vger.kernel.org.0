Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A05129E8FB
	for <lists+linux-tip-commits@lfdr.de>; Thu, 29 Oct 2020 11:30:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726518AbgJ2KaN (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Thu, 29 Oct 2020 06:30:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726485AbgJ2KaM (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Thu, 29 Oct 2020 06:30:12 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7921AC0613CF;
        Thu, 29 Oct 2020 03:30:12 -0700 (PDT)
Date:   Thu, 29 Oct 2020 10:30:10 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1603967410;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1O0umD0r6nHz1iyg5AHaryvP23rrG6lBCmhhB5HaLzs=;
        b=OIhEOqhzWl+u+iRnhMWBTNFEa5af2fXdhsmxW3/SKQb4Rma5iT7yHkZvJlktiiwnlrppuU
        z1e3+gqbhKmZFwxFBm734MxJ9tZxcK+hS/jVyfZT0E+8yEkS990ryXCEhh55Dpnk3NlhkU
        LvkHifQRW90EnamR4pOVBwSpkSOEvU90hFAHUMdmByjahrHMC6VBBu0gMngpn5wyN31VHp
        0Mg+ZXOYmLNGWNMad3QlJfQWPWFoKVMzl4c9vIlUoVnv25n6D+1FB7iF68+GhFCb81WU/j
        3+4Ru/QknoRgJWVQK00Ueg5gys6FkqW+nm6pGvzPYMUhUHI6KkuFPcDM9UxD4g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1603967410;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1O0umD0r6nHz1iyg5AHaryvP23rrG6lBCmhhB5HaLzs=;
        b=WpLShZPmxpGEDf+fGPA2k8i3aj1aatxxLafA38itlopnT5FzqR/Kkr5hylvwcwuC1oizaF
        qTi//PiZQTZNowBA==
From:   "tip-bot2 for Jens Axboe" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/entry] entry: Add support for TIF_NOTIFY_SIGNAL
Cc:     Jens Axboe <axboe@kernel.dk>, Thomas Gleixner <tglx@linutronix.de>,
        Oleg Nesterov <oleg@redhat.com>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20201026203230.386348-3-axboe@kernel.dk>
References: <20201026203230.386348-3-axboe@kernel.dk>
MIME-Version: 1.0
Message-ID: <160396741001.397.4239619005773354881.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the core/entry branch of tip:

Commit-ID:     12db8b690010ccfadf9d0b49a1e1798e47dbbe1a
Gitweb:        https://git.kernel.org/tip/12db8b690010ccfadf9d0b49a1e1798e47dbbe1a
Author:        Jens Axboe <axboe@kernel.dk>
AuthorDate:    Mon, 26 Oct 2020 14:32:28 -06:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 29 Oct 2020 09:37:36 +01:00

entry: Add support for TIF_NOTIFY_SIGNAL

Add TIF_NOTIFY_SIGNAL handling in the generic entry code, which if set,
will return true if signal_pending() is used in a wait loop. That causes an
exit of the loop so that notify_signal tracehooks can be run. If the wait
loop is currently inside a system call, the system call is restarted once
task_work has been processed.

In preparation for only having arch_do_signal() handle syscall restarts if
_TIF_SIGPENDING isn't set, rename it to arch_do_signal_or_restart().  Pass
in a boolean that tells the architecture specific signal handler if it
should attempt to get a signal, or just process a potential syscall
restart.

For !CONFIG_GENERIC_ENTRY archs, add the TIF_NOTIFY_SIGNAL handling to
get_signal(). This is done to minimize the needed architecture changes to
support this feature.

Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Oleg Nesterov <oleg@redhat.com>
Link: https://lore.kernel.org/r/20201026203230.386348-3-axboe@kernel.dk

---
 arch/x86/kernel/signal.c     |  4 ++--
 include/linux/entry-common.h | 11 ++++++++---
 include/linux/entry-kvm.h    |  4 ++--
 include/linux/sched/signal.h | 11 ++++++++++-
 include/linux/tracehook.h    | 27 +++++++++++++++++++++++++++
 kernel/entry/common.c        | 14 +++++++++++---
 kernel/entry/kvm.c           |  3 +++
 kernel/signal.c              | 14 ++++++++++++++
 8 files changed, 77 insertions(+), 11 deletions(-)

diff --git a/arch/x86/kernel/signal.c b/arch/x86/kernel/signal.c
index d5fa494..ec3b9c6 100644
--- a/arch/x86/kernel/signal.c
+++ b/arch/x86/kernel/signal.c
@@ -804,11 +804,11 @@ static inline unsigned long get_nr_restart_syscall(const struct pt_regs *regs)
  * want to handle. Thus you cannot kill init even with a SIGKILL even by
  * mistake.
  */
-void arch_do_signal(struct pt_regs *regs)
+void arch_do_signal_or_restart(struct pt_regs *regs, bool has_signal)
 {
 	struct ksignal ksig;
 
-	if (get_signal(&ksig)) {
+	if (has_signal && get_signal(&ksig)) {
 		/* Whee! Actually deliver the signal.  */
 		handle_signal(&ksig, regs);
 		return;
diff --git a/include/linux/entry-common.h b/include/linux/entry-common.h
index efebbff..c7bfac4 100644
--- a/include/linux/entry-common.h
+++ b/include/linux/entry-common.h
@@ -37,6 +37,10 @@
 # define _TIF_UPROBE			(0)
 #endif
 
+#ifndef _TIF_NOTIFY_SIGNAL
+# define _TIF_NOTIFY_SIGNAL		(0)
+#endif
+
 /*
  * TIF flags handled in syscall_enter_from_usermode()
  */
@@ -69,7 +73,7 @@
 
 #define EXIT_TO_USER_MODE_WORK						\
 	(_TIF_SIGPENDING | _TIF_NOTIFY_RESUME | _TIF_UPROBE |		\
-	 _TIF_NEED_RESCHED | _TIF_PATCH_PENDING |			\
+	 _TIF_NEED_RESCHED | _TIF_PATCH_PENDING | _TIF_NOTIFY_SIGNAL |	\
 	 ARCH_EXIT_TO_USER_MODE_WORK)
 
 /**
@@ -226,12 +230,13 @@ static __always_inline void arch_exit_to_user_mode(void) { }
 #endif
 
 /**
- * arch_do_signal -  Architecture specific signal delivery function
+ * arch_do_signal_or_restart -  Architecture specific signal delivery function
  * @regs:	Pointer to currents pt_regs
+ * @has_signal:	actual signal to handle
  *
  * Invoked from exit_to_user_mode_loop().
  */
-void arch_do_signal(struct pt_regs *regs);
+void arch_do_signal_or_restart(struct pt_regs *regs, bool has_signal);
 
 /**
  * arch_syscall_exit_tracehook - Wrapper around tracehook_report_syscall_exit()
diff --git a/include/linux/entry-kvm.h b/include/linux/entry-kvm.h
index 0cef17a..9b93f85 100644
--- a/include/linux/entry-kvm.h
+++ b/include/linux/entry-kvm.h
@@ -11,8 +11,8 @@
 # define ARCH_XFER_TO_GUEST_MODE_WORK	(0)
 #endif
 
-#define XFER_TO_GUEST_MODE_WORK					\
-	(_TIF_NEED_RESCHED | _TIF_SIGPENDING |			\
+#define XFER_TO_GUEST_MODE_WORK						\
+	(_TIF_NEED_RESCHED | _TIF_SIGPENDING | _TIF_NOTIFY_SIGNAL |	\
 	 _TIF_NOTIFY_RESUME | ARCH_XFER_TO_GUEST_MODE_WORK)
 
 struct kvm_vcpu;
diff --git a/include/linux/sched/signal.h b/include/linux/sched/signal.h
index 404145d..bd5afa0 100644
--- a/include/linux/sched/signal.h
+++ b/include/linux/sched/signal.h
@@ -360,6 +360,15 @@ static inline int task_sigpending(struct task_struct *p)
 
 static inline int signal_pending(struct task_struct *p)
 {
+#if defined(TIF_NOTIFY_SIGNAL)
+	/*
+	 * TIF_NOTIFY_SIGNAL isn't really a signal, but it requires the same
+	 * behavior in terms of ensuring that we break out of wait loops
+	 * so that notify signal callbacks can be processed.
+	 */
+	if (unlikely(test_tsk_thread_flag(p, TIF_NOTIFY_SIGNAL)))
+		return 1;
+#endif
 	return task_sigpending(p);
 }
 
@@ -507,7 +516,7 @@ extern int set_user_sigmask(const sigset_t __user *umask, size_t sigsetsize);
 static inline void restore_saved_sigmask_unless(bool interrupted)
 {
 	if (interrupted)
-		WARN_ON(!test_thread_flag(TIF_SIGPENDING));
+		WARN_ON(!signal_pending(current));
 	else
 		restore_saved_sigmask();
 }
diff --git a/include/linux/tracehook.h b/include/linux/tracehook.h
index 36fb3bb..1e8caca 100644
--- a/include/linux/tracehook.h
+++ b/include/linux/tracehook.h
@@ -198,4 +198,31 @@ static inline void tracehook_notify_resume(struct pt_regs *regs)
 	blkcg_maybe_throttle_current();
 }
 
+/*
+ * called by exit_to_user_mode_loop() if ti_work & _TIF_NOTIFY_SIGNAL. This
+ * is currently used by TWA_SIGNAL based task_work, which requires breaking
+ * wait loops to ensure that task_work is noticed and run.
+ */
+static inline void tracehook_notify_signal(void)
+{
+#if defined(TIF_NOTIFY_SIGNAL)
+	clear_thread_flag(TIF_NOTIFY_SIGNAL);
+	smp_mb__after_atomic();
+	if (current->task_works)
+		task_work_run();
+#endif
+}
+
+/*
+ * Called when we have work to process from exit_to_user_mode_loop()
+ */
+static inline void set_notify_signal(struct task_struct *task)
+{
+#if defined(TIF_NOTIFY_SIGNAL)
+	if (!test_and_set_tsk_thread_flag(task, TIF_NOTIFY_SIGNAL) &&
+	    !wake_up_state(task, TASK_INTERRUPTIBLE))
+		kick_process(task);
+#endif
+}
+
 #endif	/* <linux/tracehook.h> */
diff --git a/kernel/entry/common.c b/kernel/entry/common.c
index 9852e0d..42eff11 100644
--- a/kernel/entry/common.c
+++ b/kernel/entry/common.c
@@ -109,7 +109,15 @@ static __always_inline void exit_to_user_mode(void)
 }
 
 /* Workaround to allow gradual conversion of architecture code */
-void __weak arch_do_signal(struct pt_regs *regs) { }
+void __weak arch_do_signal_or_restart(struct pt_regs *regs, bool has_signal) { }
+
+static void handle_signal_work(struct pt_regs *regs, unsigned long ti_work)
+{
+	if (ti_work & _TIF_NOTIFY_SIGNAL)
+		tracehook_notify_signal();
+
+	arch_do_signal_or_restart(regs, ti_work & _TIF_SIGPENDING);
+}
 
 static unsigned long exit_to_user_mode_loop(struct pt_regs *regs,
 					    unsigned long ti_work)
@@ -131,8 +139,8 @@ static unsigned long exit_to_user_mode_loop(struct pt_regs *regs,
 		if (ti_work & _TIF_PATCH_PENDING)
 			klp_update_patch_state(current);
 
-		if (ti_work & _TIF_SIGPENDING)
-			arch_do_signal(regs);
+		if (ti_work & (_TIF_SIGPENDING | _TIF_NOTIFY_SIGNAL))
+			handle_signal_work(regs, ti_work);
 
 		if (ti_work & _TIF_NOTIFY_RESUME) {
 			clear_thread_flag(TIF_NOTIFY_RESUME);
diff --git a/kernel/entry/kvm.c b/kernel/entry/kvm.c
index eb1a8a4..b828a3d 100644
--- a/kernel/entry/kvm.c
+++ b/kernel/entry/kvm.c
@@ -8,6 +8,9 @@ static int xfer_to_guest_mode_work(struct kvm_vcpu *vcpu, unsigned long ti_work)
 	do {
 		int ret;
 
+		if (ti_work & _TIF_NOTIFY_SIGNAL)
+			tracehook_notify_signal();
+
 		if (ti_work & _TIF_SIGPENDING) {
 			kvm_handle_signal_exit(vcpu);
 			return -EINTR;
diff --git a/kernel/signal.c b/kernel/signal.c
index b179ecc..61b377e 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -2529,6 +2529,20 @@ bool get_signal(struct ksignal *ksig)
 	struct signal_struct *signal = current->signal;
 	int signr;
 
+	/*
+	 * For non-generic architectures, check for TIF_NOTIFY_SIGNAL so
+	 * that the arch handlers don't all have to do it. If we get here
+	 * without TIF_SIGPENDING, just exit after running signal work.
+	 */
+#ifdef TIF_NOTIFY_SIGNAL
+	if (!IS_ENABLED(CONFIG_GENERIC_ENTRY)) {
+		if (test_thread_flag(TIF_NOTIFY_SIGNAL))
+			tracehook_notify_signal();
+		if (!task_sigpending(current))
+			return false;
+	}
+#endif
+
 	if (unlikely(uprobe_deny_signal()))
 		return false;
 
