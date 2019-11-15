Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B4E47FE6E8
	for <lists+linux-tip-commits@lfdr.de>; Fri, 15 Nov 2019 22:12:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727135AbfKOVMu (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 15 Nov 2019 16:12:50 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:44648 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727196AbfKOVMt (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 15 Nov 2019 16:12:49 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1iVitT-0007T3-Mc; Fri, 15 Nov 2019 22:12:39 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id AC0D21C18D7;
        Fri, 15 Nov 2019 22:12:30 +0100 (CET)
Date:   Fri, 15 Nov 2019 21:12:30 -0000
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/iopl] x86/process: Unify copy_thread_tls()
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Andy Lutomirski <luto@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        linux-kernel@vger.kernel.org
In-Reply-To: <20191113210103.911310593@linutronix.de>
References: <20191113210103.911310593@linutronix.de>
MIME-Version: 1.0
Message-ID: <157385235063.12247.13335840019032998507.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-tip-commits-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/iopl branch of tip:

Commit-ID:     320044006807464e3e80c11b3afbc08a57767f29
Gitweb:        https://git.kernel.org/tip/320044006807464e3e80c11b3afbc08a57767f29
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Wed, 13 Nov 2019 21:42:42 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 14 Nov 2019 20:14:59 +01:00

x86/process: Unify copy_thread_tls()

While looking at the TSS io bitmap it turned out that any change in that
area would require identical changes to copy_thread_tls(). The 32 and 64
bit variants share sufficient code to consolidate them into a common
function to avoid duplication of upcoming modifications.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Andy Lutomirski <luto@kernel.org>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20191113210103.911310593@linutronix.de


---
 arch/x86/include/asm/ptrace.h    |  6 ++-
 arch/x86/include/asm/switch_to.h | 10 +++-
 arch/x86/kernel/process.c        | 94 +++++++++++++++++++++++++++++++-
 arch/x86/kernel/process_32.c     | 68 +----------------------
 arch/x86/kernel/process_64.c     | 75 +-------------------------
 5 files changed, 110 insertions(+), 143 deletions(-)

diff --git a/arch/x86/include/asm/ptrace.h b/arch/x86/include/asm/ptrace.h
index 332eb35..5057a8e 100644
--- a/arch/x86/include/asm/ptrace.h
+++ b/arch/x86/include/asm/ptrace.h
@@ -361,5 +361,11 @@ extern int do_get_thread_area(struct task_struct *p, int idx,
 extern int do_set_thread_area(struct task_struct *p, int idx,
 			      struct user_desc __user *info, int can_allocate);
 
+#ifdef CONFIG_X86_64
+# define do_set_thread_area_64(p, s, t)	do_arch_prctl_64(p, s, t)
+#else
+# define do_set_thread_area_64(p, s, t)	(0)
+#endif
+
 #endif /* !__ASSEMBLY__ */
 #endif /* _ASM_X86_PTRACE_H */
diff --git a/arch/x86/include/asm/switch_to.h b/arch/x86/include/asm/switch_to.h
index 18a4b68..0e059b7 100644
--- a/arch/x86/include/asm/switch_to.h
+++ b/arch/x86/include/asm/switch_to.h
@@ -103,7 +103,17 @@ static inline void update_task_stack(struct task_struct *task)
 	if (static_cpu_has(X86_FEATURE_XENPV))
 		load_sp0(task_top_of_stack(task));
 #endif
+}
 
+static inline void kthread_frame_init(struct inactive_task_frame *frame,
+				      unsigned long fun, unsigned long arg)
+{
+	frame->bx = fun;
+#ifdef CONFIG_X86_32
+	frame->di = arg;
+#else
+	frame->r12 = arg;
+#endif
 }
 
 #endif /* _ASM_X86_SWITCH_TO_H */
diff --git a/arch/x86/kernel/process.c b/arch/x86/kernel/process.c
index 5e94c43..c09130a 100644
--- a/arch/x86/kernel/process.c
+++ b/arch/x86/kernel/process.c
@@ -132,6 +132,100 @@ void exit_thread(struct task_struct *tsk)
 	fpu__drop(fpu);
 }
 
+static int set_new_tls(struct task_struct *p, unsigned long tls)
+{
+	struct user_desc __user *utls = (struct user_desc __user *)tls;
+
+	if (in_ia32_syscall())
+		return do_set_thread_area(p, -1, utls, 0);
+	else
+		return do_set_thread_area_64(p, ARCH_SET_FS, tls);
+}
+
+static inline int copy_io_bitmap(struct task_struct *tsk)
+{
+	if (likely(!test_tsk_thread_flag(current, TIF_IO_BITMAP)))
+		return 0;
+
+	tsk->thread.io_bitmap_ptr = kmemdup(current->thread.io_bitmap_ptr,
+					    IO_BITMAP_BYTES, GFP_KERNEL);
+	if (!tsk->thread.io_bitmap_ptr) {
+		tsk->thread.io_bitmap_max = 0;
+		return -ENOMEM;
+	}
+	set_tsk_thread_flag(tsk, TIF_IO_BITMAP);
+	return 0;
+}
+
+static inline void free_io_bitmap(struct task_struct *tsk)
+{
+	if (tsk->thread.io_bitmap_ptr) {
+		kfree(tsk->thread.io_bitmap_ptr);
+		tsk->thread.io_bitmap_ptr = NULL;
+		tsk->thread.io_bitmap_max = 0;
+	}
+}
+
+int copy_thread_tls(unsigned long clone_flags, unsigned long sp,
+		    unsigned long arg, struct task_struct *p, unsigned long tls)
+{
+	struct inactive_task_frame *frame;
+	struct fork_frame *fork_frame;
+	struct pt_regs *childregs;
+	int ret;
+
+	childregs = task_pt_regs(p);
+	fork_frame = container_of(childregs, struct fork_frame, regs);
+	frame = &fork_frame->frame;
+
+	frame->bp = 0;
+	frame->ret_addr = (unsigned long) ret_from_fork;
+	p->thread.sp = (unsigned long) fork_frame;
+	p->thread.io_bitmap_ptr = NULL;
+	memset(p->thread.ptrace_bps, 0, sizeof(p->thread.ptrace_bps));
+
+#ifdef CONFIG_X86_64
+	savesegment(gs, p->thread.gsindex);
+	p->thread.gsbase = p->thread.gsindex ? 0 : current->thread.gsbase;
+	savesegment(fs, p->thread.fsindex);
+	p->thread.fsbase = p->thread.fsindex ? 0 : current->thread.fsbase;
+	savesegment(es, p->thread.es);
+	savesegment(ds, p->thread.ds);
+#else
+	/* Clear all status flags including IF and set fixed bit. */
+	frame->flags = X86_EFLAGS_FIXED;
+#endif
+
+	/* Kernel thread ? */
+	if (unlikely(p->flags & PF_KTHREAD)) {
+		memset(childregs, 0, sizeof(struct pt_regs));
+		kthread_frame_init(frame, sp, arg);
+		return 0;
+	}
+
+	frame->bx = 0;
+	*childregs = *current_pt_regs();
+	childregs->ax = 0;
+	if (sp)
+		childregs->sp = sp;
+
+#ifdef CONFIG_X86_32
+	task_user_gs(p) = get_user_gs(current_pt_regs());
+#endif
+
+	ret = copy_io_bitmap(p);
+	if (ret)
+		return ret;
+
+	/* Set a new TLS for the child thread? */
+	if (clone_flags & CLONE_SETTLS) {
+		ret = set_new_tls(p, tls);
+		if (ret)
+			free_io_bitmap(p);
+	}
+	return ret;
+}
+
 void flush_thread(void)
 {
 	struct task_struct *tsk = current;
diff --git a/arch/x86/kernel/process_32.c b/arch/x86/kernel/process_32.c
index b8ceec4..6c7d905 100644
--- a/arch/x86/kernel/process_32.c
+++ b/arch/x86/kernel/process_32.c
@@ -112,74 +112,6 @@ void release_thread(struct task_struct *dead_task)
 	release_vm86_irqs(dead_task);
 }
 
-int copy_thread_tls(unsigned long clone_flags, unsigned long sp,
-	unsigned long arg, struct task_struct *p, unsigned long tls)
-{
-	struct pt_regs *childregs = task_pt_regs(p);
-	struct fork_frame *fork_frame = container_of(childregs, struct fork_frame, regs);
-	struct inactive_task_frame *frame = &fork_frame->frame;
-	struct task_struct *tsk;
-	int err;
-
-	/*
-	 * For a new task use the RESET flags value since there is no before.
-	 * All the status flags are zero; DF and all the system flags must also
-	 * be 0, specifically IF must be 0 because we context switch to the new
-	 * task with interrupts disabled.
-	 */
-	frame->flags = X86_EFLAGS_FIXED;
-	frame->bp = 0;
-	frame->ret_addr = (unsigned long) ret_from_fork;
-	p->thread.sp = (unsigned long) fork_frame;
-	p->thread.sp0 = (unsigned long) (childregs+1);
-	memset(p->thread.ptrace_bps, 0, sizeof(p->thread.ptrace_bps));
-
-	if (unlikely(p->flags & PF_KTHREAD)) {
-		/* kernel thread */
-		memset(childregs, 0, sizeof(struct pt_regs));
-		frame->bx = sp;		/* function */
-		frame->di = arg;
-		p->thread.io_bitmap_ptr = NULL;
-		return 0;
-	}
-	frame->bx = 0;
-	*childregs = *current_pt_regs();
-	childregs->ax = 0;
-	if (sp)
-		childregs->sp = sp;
-
-	task_user_gs(p) = get_user_gs(current_pt_regs());
-
-	p->thread.io_bitmap_ptr = NULL;
-	tsk = current;
-	err = -ENOMEM;
-
-	if (unlikely(test_tsk_thread_flag(tsk, TIF_IO_BITMAP))) {
-		p->thread.io_bitmap_ptr = kmemdup(tsk->thread.io_bitmap_ptr,
-						IO_BITMAP_BYTES, GFP_KERNEL);
-		if (!p->thread.io_bitmap_ptr) {
-			p->thread.io_bitmap_max = 0;
-			return -ENOMEM;
-		}
-		set_tsk_thread_flag(p, TIF_IO_BITMAP);
-	}
-
-	err = 0;
-
-	/*
-	 * Set a new TLS for the child thread?
-	 */
-	if (clone_flags & CLONE_SETTLS)
-		err = do_set_thread_area(p, -1,
-			(struct user_desc __user *)tls, 0);
-
-	if (err && p->thread.io_bitmap_ptr) {
-		kfree(p->thread.io_bitmap_ptr);
-		p->thread.io_bitmap_max = 0;
-	}
-	return err;
-}
-
 void
 start_thread(struct pt_regs *regs, unsigned long new_ip, unsigned long new_sp)
 {
diff --git a/arch/x86/kernel/process_64.c b/arch/x86/kernel/process_64.c
index af64519..e93a1b8 100644
--- a/arch/x86/kernel/process_64.c
+++ b/arch/x86/kernel/process_64.c
@@ -371,81 +371,6 @@ void x86_gsbase_write_task(struct task_struct *task, unsigned long gsbase)
 	task->thread.gsbase = gsbase;
 }
 
-int copy_thread_tls(unsigned long clone_flags, unsigned long sp,
-		unsigned long arg, struct task_struct *p, unsigned long tls)
-{
-	int err;
-	struct pt_regs *childregs;
-	struct fork_frame *fork_frame;
-	struct inactive_task_frame *frame;
-	struct task_struct *me = current;
-
-	childregs = task_pt_regs(p);
-	fork_frame = container_of(childregs, struct fork_frame, regs);
-	frame = &fork_frame->frame;
-
-	frame->bp = 0;
-	frame->ret_addr = (unsigned long) ret_from_fork;
-	p->thread.sp = (unsigned long) fork_frame;
-	p->thread.io_bitmap_ptr = NULL;
-
-	savesegment(gs, p->thread.gsindex);
-	p->thread.gsbase = p->thread.gsindex ? 0 : me->thread.gsbase;
-	savesegment(fs, p->thread.fsindex);
-	p->thread.fsbase = p->thread.fsindex ? 0 : me->thread.fsbase;
-	savesegment(es, p->thread.es);
-	savesegment(ds, p->thread.ds);
-	memset(p->thread.ptrace_bps, 0, sizeof(p->thread.ptrace_bps));
-
-	if (unlikely(p->flags & PF_KTHREAD)) {
-		/* kernel thread */
-		memset(childregs, 0, sizeof(struct pt_regs));
-		frame->bx = sp;		/* function */
-		frame->r12 = arg;
-		return 0;
-	}
-	frame->bx = 0;
-	*childregs = *current_pt_regs();
-
-	childregs->ax = 0;
-	if (sp)
-		childregs->sp = sp;
-
-	err = -ENOMEM;
-	if (unlikely(test_tsk_thread_flag(me, TIF_IO_BITMAP))) {
-		p->thread.io_bitmap_ptr = kmemdup(me->thread.io_bitmap_ptr,
-						  IO_BITMAP_BYTES, GFP_KERNEL);
-		if (!p->thread.io_bitmap_ptr) {
-			p->thread.io_bitmap_max = 0;
-			return -ENOMEM;
-		}
-		set_tsk_thread_flag(p, TIF_IO_BITMAP);
-	}
-
-	/*
-	 * Set a new TLS for the child thread?
-	 */
-	if (clone_flags & CLONE_SETTLS) {
-#ifdef CONFIG_IA32_EMULATION
-		if (in_ia32_syscall())
-			err = do_set_thread_area(p, -1,
-				(struct user_desc __user *)tls, 0);
-		else
-#endif
-			err = do_arch_prctl_64(p, ARCH_SET_FS, tls);
-		if (err)
-			goto out;
-	}
-	err = 0;
-out:
-	if (err && p->thread.io_bitmap_ptr) {
-		kfree(p->thread.io_bitmap_ptr);
-		p->thread.io_bitmap_max = 0;
-	}
-
-	return err;
-}
-
 static void
 start_thread_common(struct pt_regs *regs, unsigned long new_ip,
 		    unsigned long new_sp,
