Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 69DCB3182C2
	for <lists+linux-tip-commits@lfdr.de>; Thu, 11 Feb 2021 01:54:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230378AbhBKAvZ (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 10 Feb 2021 19:51:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230098AbhBKAvO (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 10 Feb 2021 19:51:14 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 055BEC06178B;
        Wed, 10 Feb 2021 16:50:28 -0800 (PST)
Date:   Thu, 11 Feb 2021 00:50:25 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1613004625;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=E3i7tbebgJngKf7QWRUirzeOxUKrC9Y+2YoG2fZDlQg=;
        b=m3RwfX2PtPKqmS/8SvsuTU9ALSZmgG1Xb8coklEn9zJUwaKnP7bR9VPx4aRZmJ+hjlKfSO
        wOTEQFUIc03zSPgrBlBkeZ7j3PmjAuVaWS1GDsvFF40flGo+pSJkTkhjkHZXG/+aqkpUTV
        O6wpCx1nVDULZz3Tk6XobOrGb64OLPNydGOCZCJH6q+k7/6c1S4ReX28oBfOvivEgmGLW6
        luJTwrjTB5ZCo1PzOwJMcFjzmD7NDTH9hDZoI/GWDsxVsMUU19RMWaGxgBuiYNmDlMqZmN
        teyrseq0k2eLUerFk1yus6XiOR18psCRTy45iXqtvuOk3Zxx3ANyJsJqzGorIA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1613004625;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=E3i7tbebgJngKf7QWRUirzeOxUKrC9Y+2YoG2fZDlQg=;
        b=+mJXJjAtoNbkyLCs2zNqc359SaeiHsNj9G/ATCas5CBBNuO9ZW+ulW8S0A9XmZ3l1jMp3x
        eV/dMRiRFy/hw/BQ==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/entry] x86/entry: Convert device interrupts to inline stack
 switching
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Kees Cook <keescook@chromium.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210210002512.769728139@linutronix.de>
References: <20210210002512.769728139@linutronix.de>
MIME-Version: 1.0
Message-ID: <161300462535.23325.2974259500618571388.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/entry branch of tip:

Commit-ID:     5b51e1db9bdc312d53087a0c97d54ea150111c0d
Gitweb:        https://git.kernel.org/tip/5b51e1db9bdc312d53087a0c97d54ea150111c0d
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Wed, 10 Feb 2021 00:40:48 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 10 Feb 2021 23:34:15 +01:00

x86/entry: Convert device interrupts to inline stack switching

Convert device interrupts to inline stack switching by replacing the
existing macro implementation with the new inline version. Tweak the
function signature of the actual handler function to have the vector
argument as u32. That allows the inline macro to avoid extra intermediates
and lets the compiler be smarter about the whole thing.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Kees Cook <keescook@chromium.org>
Link: https://lore.kernel.org/r/20210210002512.769728139@linutronix.de


---
 arch/x86/entry/entry_64.S        |  1 +-
 arch/x86/include/asm/idtentry.h  |  9 ++---
 arch/x86/include/asm/irq_stack.h | 58 ++++++++++++++++---------------
 arch/x86/kernel/irq.c            |  2 +-
 4 files changed, 36 insertions(+), 34 deletions(-)

diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
index 68643d3..f446e90 100644
--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -762,7 +762,6 @@ SYM_CODE_END(.Lbad_gs)
  * rdx: Function argument (can be NULL if none)
  */
 SYM_FUNC_START(asm_call_on_stack)
-SYM_INNER_LABEL(asm_call_irq_on_stack, SYM_L_GLOBAL)
 	/*
 	 * Save the frame pointer unconditionally. This allows the ORC
 	 * unwinder to handle the stack switch.
diff --git a/arch/x86/include/asm/idtentry.h b/arch/x86/include/asm/idtentry.h
index 712b3c8..f294637 100644
--- a/arch/x86/include/asm/idtentry.h
+++ b/arch/x86/include/asm/idtentry.h
@@ -187,23 +187,22 @@ __visible noinstr void func(struct pt_regs *regs, unsigned long error_code)
  * has to be done in the function body if necessary.
  */
 #define DEFINE_IDTENTRY_IRQ(func)					\
-static __always_inline void __##func(struct pt_regs *regs, u8 vector);	\
+static void __##func(struct pt_regs *regs, u32 vector);			\
 									\
 __visible noinstr void func(struct pt_regs *regs,			\
 			    unsigned long error_code)			\
 {									\
 	irqentry_state_t state = irqentry_enter(regs);			\
+	u32 vector = (u32)(u8)error_code;				\
 									\
 	instrumentation_begin();					\
-	irq_enter_rcu();						\
 	kvm_set_cpu_l1tf_flush_l1d();					\
-	__##func (regs, (u8)error_code);				\
-	irq_exit_rcu();							\
+	run_irq_on_irqstack_cond(__##func, regs, vector);		\
 	instrumentation_end();						\
 	irqentry_exit(regs, state);					\
 }									\
 									\
-static __always_inline void __##func(struct pt_regs *regs, u8 vector)
+static noinline void __##func(struct pt_regs *regs, u32 vector)
 
 /**
  * DECLARE_IDTENTRY_SYSVEC - Declare functions for system vector entry points
diff --git a/arch/x86/include/asm/irq_stack.h b/arch/x86/include/asm/irq_stack.h
index 05c37e7..dabc0cf 100644
--- a/arch/x86/include/asm/irq_stack.h
+++ b/arch/x86/include/asm/irq_stack.h
@@ -162,14 +162,35 @@
 			      SYSVEC_CONSTRAINTS, regs);		\
 }
 
+/*
+ * As in ASM_CALL_SYSVEC above the clobbers force the compiler to store
+ * @regs and @vector in callee saved registers.
+ */
+#define ASM_CALL_IRQ							\
+	"call irq_enter_rcu				\n"		\
+	"movq	%[arg1], %%rdi				\n"		\
+	"movl	%[arg2], %%esi				\n"		\
+	"call %P[__func]				\n"		\
+	"call irq_exit_rcu				\n"
+
+#define IRQ_CONSTRAINTS	, [arg1] "r" (regs), [arg2] "r" (vector)
+
+#define run_irq_on_irqstack_cond(func, regs, vector)			\
+{									\
+	assert_function_type(func, void (*)(struct pt_regs *, u32));	\
+	assert_arg_type(regs, struct pt_regs *);			\
+	assert_arg_type(vector, u32);					\
+									\
+	call_on_irqstack_cond(func, regs, ASM_CALL_IRQ,			\
+			      IRQ_CONSTRAINTS, regs, vector);		\
+}
+
 static __always_inline bool irqstack_active(void)
 {
 	return __this_cpu_read(hardirq_stack_inuse);
 }
 
 void asm_call_on_stack(void *sp, void (*func)(void), void *arg);
-void asm_call_irq_on_stack(void *sp, void (*func)(struct irq_desc *desc),
-			   struct irq_desc *desc);
 
 static __always_inline void __run_on_irqstack(void (*func)(void))
 {
@@ -180,17 +201,6 @@ static __always_inline void __run_on_irqstack(void (*func)(void))
 	__this_cpu_write(hardirq_stack_inuse, false);
 }
 
-static __always_inline void
-__run_irq_on_irqstack(void (*func)(struct irq_desc *desc),
-		      struct irq_desc *desc)
-{
-	void *tos = __this_cpu_read(hardirq_stack_ptr);
-
-	__this_cpu_write(hardirq_stack_inuse, true);
-	asm_call_irq_on_stack(tos, func, desc);
-	__this_cpu_write(hardirq_stack_inuse, false);
-}
-
 #else /* CONFIG_X86_64 */
 
 /* System vector handlers always run on the stack they interrupted. */
@@ -201,10 +211,16 @@ __run_irq_on_irqstack(void (*func)(struct irq_desc *desc),
 	irq_exit_rcu();							\
 }
 
+/* Switches to the irq stack within func() */
+#define run_irq_on_irqstack_cond(func, regs, vector)			\
+{									\
+	irq_enter_rcu();						\
+	func(regs, vector);						\
+	irq_exit_rcu();							\
+}
+
 static inline bool irqstack_active(void) { return false; }
 static inline void __run_on_irqstack(void (*func)(void)) { }
-static inline void __run_irq_on_irqstack(void (*func)(struct irq_desc *desc),
-					 struct irq_desc *desc) { }
 #endif /* !CONFIG_X86_64 */
 
 static __always_inline bool irq_needs_irq_stack(struct pt_regs *regs)
@@ -228,16 +244,4 @@ static __always_inline void run_on_irqstack_cond(void (*func)(void),
 		func();
 }
 
-static __always_inline void
-run_irq_on_irqstack_cond(void (*func)(struct irq_desc *desc), struct irq_desc *desc,
-			 struct pt_regs *regs)
-{
-	lockdep_assert_irqs_disabled();
-
-	if (irq_needs_irq_stack(regs))
-		__run_irq_on_irqstack(func, desc);
-	else
-		func(desc);
-}
-
 #endif
diff --git a/arch/x86/kernel/irq.c b/arch/x86/kernel/irq.c
index c5dd503..1507b98 100644
--- a/arch/x86/kernel/irq.c
+++ b/arch/x86/kernel/irq.c
@@ -227,7 +227,7 @@ static __always_inline void handle_irq(struct irq_desc *desc,
 				       struct pt_regs *regs)
 {
 	if (IS_ENABLED(CONFIG_X86_64))
-		run_irq_on_irqstack_cond(desc->handle_irq, desc, regs);
+		generic_handle_irq_desc(desc);
 	else
 		__handle_irq(desc, regs);
 }
