Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 65F6A3182BA
	for <lists+linux-tip-commits@lfdr.de>; Thu, 11 Feb 2021 01:54:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230255AbhBKAvU (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 10 Feb 2021 19:51:20 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:35524 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230046AbhBKAvI (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 10 Feb 2021 19:51:08 -0500
Date:   Thu, 11 Feb 2021 00:50:25 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1613004626;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LGB36NVlg3TIUm/oIuGWRzP19cDTbj35h5sih9Kq0+s=;
        b=zQZpz9ft1gQa04DDwq9Rdrbgq+XBrIRBzRDl7MynX9//n488A+ziyPBo5nGqa8ReaD2nY3
        q1JzyrIDO73Qol7eHHz9lwFqEvQfiRiaascit4/TZmPKCOpApy1+ciMOHhYh7lYkMM0pzC
        PSSIdyVOTTT9KyoZDUoPfzAhzPdoOeB02wzzibLqz5/apYtNLhFw9mf7EFsz9TAyptoBpn
        UaKFmQY73eEAlpXwnPSZ0UI+ag0vLHzJnRn2XGdPpFyBCTM0izVmJsVTgvIQ+gyNQ2mxf1
        CyBL1AIyiFb0xA8ryAY2V+4hJh9K1HnRfaG3Sbl7dHI+DkQl3zE4Ghn1qG0fXQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1613004626;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LGB36NVlg3TIUm/oIuGWRzP19cDTbj35h5sih9Kq0+s=;
        b=14iDVBfU6fgMOcaVqTnydNCQ8RJRXZVzmWis3Jhn5o8QXUruQsXfgjPLp+uAoQiHXQnKDm
        PYt+u3EgyeRrMTDw==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/entry] x86/entry: Convert system vectors to irq stack macro
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Kees Cook <keescook@chromium.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210210002512.676197354@linutronix.de>
References: <20210210002512.676197354@linutronix.de>
MIME-Version: 1.0
Message-ID: <161300462559.23325.15667527831927013522.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/entry branch of tip:

Commit-ID:     569dd8b4eb7ef666b467c41b8e8e4f2820d07f67
Gitweb:        https://git.kernel.org/tip/569dd8b4eb7ef666b467c41b8e8e4f2820d07f67
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Wed, 10 Feb 2021 00:40:47 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 10 Feb 2021 23:34:15 +01:00

x86/entry: Convert system vectors to irq stack macro

To inline the stack switching and to prepare for enabling
CONFIG_HAVE_IRQ_EXIT_ON_IRQ_STACK provide a macro template for system
vectors and device interrupts and convert the system vectors over to it.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Kees Cook <keescook@chromium.org>
Link: https://lore.kernel.org/r/20210210002512.676197354@linutronix.de

---
 arch/x86/entry/entry_64.S        |  1 +-
 arch/x86/include/asm/idtentry.h  |  2 +-
 arch/x86/include/asm/irq_stack.h | 93 ++++++++++++++++++++++---------
 3 files changed, 66 insertions(+), 30 deletions(-)

diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
index cad0870..68643d3 100644
--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -762,7 +762,6 @@ SYM_CODE_END(.Lbad_gs)
  * rdx: Function argument (can be NULL if none)
  */
 SYM_FUNC_START(asm_call_on_stack)
-SYM_INNER_LABEL(asm_call_sysvec_on_stack, SYM_L_GLOBAL)
 SYM_INNER_LABEL(asm_call_irq_on_stack, SYM_L_GLOBAL)
 	/*
 	 * Save the frame pointer unconditionally. This allows the ORC
diff --git a/arch/x86/include/asm/idtentry.h b/arch/x86/include/asm/idtentry.h
index 247a60a..712b3c8 100644
--- a/arch/x86/include/asm/idtentry.h
+++ b/arch/x86/include/asm/idtentry.h
@@ -237,10 +237,8 @@ __visible noinstr void func(struct pt_regs *regs)			\
 	irqentry_state_t state = irqentry_enter(regs);			\
 									\
 	instrumentation_begin();					\
-	irq_enter_rcu();						\
 	kvm_set_cpu_l1tf_flush_l1d();					\
 	run_sysvec_on_irqstack_cond(__##func, regs);			\
-	irq_exit_rcu();							\
 	instrumentation_end();						\
 	irqentry_exit(regs, state);					\
 }									\
diff --git a/arch/x86/include/asm/irq_stack.h b/arch/x86/include/asm/irq_stack.h
index d5b7bc6..05c37e7 100644
--- a/arch/x86/include/asm/irq_stack.h
+++ b/arch/x86/include/asm/irq_stack.h
@@ -105,14 +105,69 @@
 #define assert_arg_type(arg, proto)					\
 	static_assert(__builtin_types_compatible_p(typeof(arg), proto))
 
+/*
+ * Macro to invoke system vector and device interrupt C handlers.
+ */
+#define call_on_irqstack_cond(func, regs, asm_call, constr, c_args...)	\
+{									\
+	/*								\
+	 * User mode entry and interrupt on the irq stack do not	\
+	 * switch stacks. If from user mode the task stack is empty.	\
+	 */								\
+	if (user_mode(regs) || __this_cpu_read(hardirq_stack_inuse)) {	\
+		irq_enter_rcu();					\
+		func(c_args);						\
+		irq_exit_rcu();						\
+	} else {							\
+		/*							\
+		 * Mark the irq stack inuse _before_ and unmark _after_	\
+		 * switching stacks. Interrupts are disabled in both	\
+		 * places. Invoke the stack switch macro with the call	\
+		 * sequence which matches the above direct invocation.	\
+		 */							\
+		__this_cpu_write(hardirq_stack_inuse, true);		\
+		call_on_irqstack(func, asm_call, constr);		\
+		__this_cpu_write(hardirq_stack_inuse, false);		\
+	}								\
+}
+
+/*
+ * Function call sequence for __call_on_irqstack() for system vectors.
+ *
+ * Note that irq_enter_rcu() and irq_exit_rcu() do not use the input
+ * mechanism because these functions are global and cannot be optimized out
+ * when compiling a particular source file which uses one of these macros.
+ *
+ * The argument (regs) does not need to be pushed or stashed in a callee
+ * saved register to be safe vs. the irq_enter_rcu() call because the
+ * clobbers already prevent the compiler from storing it in a callee
+ * clobbered register. As the compiler has to preserve @regs for the final
+ * call to idtentry_exit() anyway, it's likely that it does not cause extra
+ * effort for this asm magic.
+ */
+#define ASM_CALL_SYSVEC							\
+	"call irq_enter_rcu				\n"		\
+	"movq	%[arg1], %%rdi				\n"		\
+	"call %P[__func]				\n"		\
+	"call irq_exit_rcu				\n"
+
+#define SYSVEC_CONSTRAINTS	, [arg1] "r" (regs)
+
+#define run_sysvec_on_irqstack_cond(func, regs)				\
+{									\
+	assert_function_type(func, void (*)(struct pt_regs *));		\
+	assert_arg_type(regs, struct pt_regs *);			\
+									\
+	call_on_irqstack_cond(func, regs, ASM_CALL_SYSVEC,		\
+			      SYSVEC_CONSTRAINTS, regs);		\
+}
+
 static __always_inline bool irqstack_active(void)
 {
 	return __this_cpu_read(hardirq_stack_inuse);
 }
 
 void asm_call_on_stack(void *sp, void (*func)(void), void *arg);
-void asm_call_sysvec_on_stack(void *sp, void (*func)(struct pt_regs *regs),
-			      struct pt_regs *regs);
 void asm_call_irq_on_stack(void *sp, void (*func)(struct irq_desc *desc),
 			   struct irq_desc *desc);
 
@@ -126,17 +181,6 @@ static __always_inline void __run_on_irqstack(void (*func)(void))
 }
 
 static __always_inline void
-__run_sysvec_on_irqstack(void (*func)(struct pt_regs *regs),
-			 struct pt_regs *regs)
-{
-	void *tos = __this_cpu_read(hardirq_stack_ptr);
-
-	__this_cpu_write(hardirq_stack_inuse, true);
-	asm_call_sysvec_on_stack(tos, func, regs);
-	__this_cpu_write(hardirq_stack_inuse, false);
-}
-
-static __always_inline void
 __run_irq_on_irqstack(void (*func)(struct irq_desc *desc),
 		      struct irq_desc *desc)
 {
@@ -148,10 +192,17 @@ __run_irq_on_irqstack(void (*func)(struct irq_desc *desc),
 }
 
 #else /* CONFIG_X86_64 */
+
+/* System vector handlers always run on the stack they interrupted. */
+#define run_sysvec_on_irqstack_cond(func, regs)				\
+{									\
+	irq_enter_rcu();						\
+	func(regs);							\
+	irq_exit_rcu();							\
+}
+
 static inline bool irqstack_active(void) { return false; }
 static inline void __run_on_irqstack(void (*func)(void)) { }
-static inline void __run_sysvec_on_irqstack(void (*func)(struct pt_regs *regs),
-					    struct pt_regs *regs) { }
 static inline void __run_irq_on_irqstack(void (*func)(struct irq_desc *desc),
 					 struct irq_desc *desc) { }
 #endif /* !CONFIG_X86_64 */
@@ -178,18 +229,6 @@ static __always_inline void run_on_irqstack_cond(void (*func)(void),
 }
 
 static __always_inline void
-run_sysvec_on_irqstack_cond(void (*func)(struct pt_regs *regs),
-			    struct pt_regs *regs)
-{
-	lockdep_assert_irqs_disabled();
-
-	if (irq_needs_irq_stack(regs))
-		__run_sysvec_on_irqstack(func, regs);
-	else
-		func(regs);
-}
-
-static __always_inline void
 run_irq_on_irqstack_cond(void (*func)(struct irq_desc *desc), struct irq_desc *desc,
 			 struct pt_regs *regs)
 {
