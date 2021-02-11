Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7CA7A3182C0
	for <lists+linux-tip-commits@lfdr.de>; Thu, 11 Feb 2021 01:54:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230335AbhBKAvX (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 10 Feb 2021 19:51:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230093AbhBKAvO (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 10 Feb 2021 19:51:14 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7F5DC061788;
        Wed, 10 Feb 2021 16:50:26 -0800 (PST)
Date:   Thu, 11 Feb 2021 00:50:24 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1613004625;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Yv4t5YixocZ8rJ7dt6A7fuu8UoDHZB/9DK5wiysk4U8=;
        b=UAh/AIYjytT6yzzLP7g6+9wx+aaQ4rK2dA8lJGOG2VuJNjAvRqranu5tX9H/RNu1ibqzDk
        lGnpjHd+/TAAMog+kpl3qdX2U3PljmKJSFzYdpgH3a9MMwBH4kywf1otvWYPx3JDJY/Cxv
        eaQAeIKGR3bSEQ7uHlRPEgV0T9ftWmZ9yE6o0mxynL8160WD3fbxPU5fffb71qdBiCFcgo
        bgQwDQsmxvmwIWip3XpneK3lA32HCIUHYqlPeA4uL2BoKvdqNSv9T5h8EEosYkThg4a6U5
        9Nao0xHEWm3jhBprgfU8a25HfEFZiE69S8s4M1LLqJOEZkTwoUYA1g69SP7xnw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1613004625;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Yv4t5YixocZ8rJ7dt6A7fuu8UoDHZB/9DK5wiysk4U8=;
        b=kpZ09jQeaWHg+e1Fs0xFjV9H31zOG6uwbC4DLflm4mo/u2IQC63XOFa1V+l8hKcUazTi9/
        cl52RsiCslRWVOAA==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/entry] x86/softirq: Remove indirection in do_softirq_own_stack()
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Kees Cook <keescook@chromium.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210210002512.972714001@linutronix.de>
References: <20210210002512.972714001@linutronix.de>
MIME-Version: 1.0
Message-ID: <161300462488.23325.3422829173467212769.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/entry branch of tip:

Commit-ID:     52d743f3b71265e14560a38f4c835d07b9c6fc4c
Gitweb:        https://git.kernel.org/tip/52d743f3b71265e14560a38f4c835d07b9c6fc4c
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Wed, 10 Feb 2021 00:40:50 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 10 Feb 2021 23:34:15 +01:00

x86/softirq: Remove indirection in do_softirq_own_stack()

Use the new inline stack switching and remove the old ASM indirect call
implementation.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Kees Cook <keescook@chromium.org>
Link: https://lore.kernel.org/r/20210210002512.972714001@linutronix.de


---
 arch/x86/entry/entry_64.S        | 39 +-----------------------
 arch/x86/include/asm/irq_stack.h | 52 +++++++++----------------------
 arch/x86/kernel/irq_64.c         |  2 +-
 3 files changed, 17 insertions(+), 76 deletions(-)

diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
index f446e90..bd52f67 100644
--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -756,45 +756,6 @@ SYM_CODE_START_LOCAL_NOALIGN(.Lbad_gs)
 SYM_CODE_END(.Lbad_gs)
 	.previous
 
-/*
- * rdi: New stack pointer points to the top word of the stack
- * rsi: Function pointer
- * rdx: Function argument (can be NULL if none)
- */
-SYM_FUNC_START(asm_call_on_stack)
-	/*
-	 * Save the frame pointer unconditionally. This allows the ORC
-	 * unwinder to handle the stack switch.
-	 */
-	pushq		%rbp
-	mov		%rsp, %rbp
-
-	/*
-	 * The unwinder relies on the word at the top of the new stack
-	 * page linking back to the previous RSP.
-	 */
-	mov		%rsp, (%rdi)
-	mov		%rdi, %rsp
-	/* Move the argument to the right place */
-	mov		%rdx, %rdi
-
-1:
-	.pushsection .discard.instr_begin
-	.long 1b - .
-	.popsection
-
-	CALL_NOSPEC	rsi
-
-2:
-	.pushsection .discard.instr_end
-	.long 2b - .
-	.popsection
-
-	/* Restore the previous stack pointer from RBP. */
-	leaveq
-	ret
-SYM_FUNC_END(asm_call_on_stack)
-
 #ifdef CONFIG_XEN_PV
 /*
  * A note on the "critical region" in our callback handler.
diff --git a/arch/x86/include/asm/irq_stack.h b/arch/x86/include/asm/irq_stack.h
index dabc0cf..fa444c2 100644
--- a/arch/x86/include/asm/irq_stack.h
+++ b/arch/x86/include/asm/irq_stack.h
@@ -185,20 +185,23 @@
 			      IRQ_CONSTRAINTS, regs, vector);		\
 }
 
-static __always_inline bool irqstack_active(void)
-{
-	return __this_cpu_read(hardirq_stack_inuse);
-}
-
-void asm_call_on_stack(void *sp, void (*func)(void), void *arg);
+#define ASM_CALL_SOFTIRQ						\
+	"call %P[__func]				\n"
 
-static __always_inline void __run_on_irqstack(void (*func)(void))
-{
-	void *tos = __this_cpu_read(hardirq_stack_ptr);
-
-	__this_cpu_write(hardirq_stack_inuse, true);
-	asm_call_on_stack(tos, func, NULL);
-	__this_cpu_write(hardirq_stack_inuse, false);
+/*
+ * Macro to invoke __do_softirq on the irq stack. Contrary to the above
+ * the only check which is necessary is whether the interrupt stack is
+ * in use already.
+ */
+#define run_softirq_on_irqstack_cond()					\
+{									\
+	if (__this_cpu_read(hardirq_stack_inuse)) {			\
+		__do_softirq();						\
+	} else {							\
+		__this_cpu_write(hardirq_stack_inuse, true);		\
+		call_on_irqstack(__do_softirq, ASM_CALL_SOFTIRQ);	\
+		__this_cpu_write(hardirq_stack_inuse, false);		\
+	}								\
 }
 
 #else /* CONFIG_X86_64 */
@@ -219,29 +222,6 @@ static __always_inline void __run_on_irqstack(void (*func)(void))
 	irq_exit_rcu();							\
 }
 
-static inline bool irqstack_active(void) { return false; }
-static inline void __run_on_irqstack(void (*func)(void)) { }
 #endif /* !CONFIG_X86_64 */
 
-static __always_inline bool irq_needs_irq_stack(struct pt_regs *regs)
-{
-	if (IS_ENABLED(CONFIG_X86_32))
-		return false;
-	if (!regs)
-		return !irqstack_active();
-	return !user_mode(regs) && !irqstack_active();
-}
-
-
-static __always_inline void run_on_irqstack_cond(void (*func)(void),
-						 struct pt_regs *regs)
-{
-	lockdep_assert_irqs_disabled();
-
-	if (irq_needs_irq_stack(regs))
-		__run_on_irqstack(func);
-	else
-		func();
-}
-
 #endif
diff --git a/arch/x86/kernel/irq_64.c b/arch/x86/kernel/irq_64.c
index 7103f98..8d9f9a1 100644
--- a/arch/x86/kernel/irq_64.c
+++ b/arch/x86/kernel/irq_64.c
@@ -76,5 +76,5 @@ int irq_init_percpu_irqstack(unsigned int cpu)
 
 void do_softirq_own_stack(void)
 {
-	run_on_irqstack_cond(__do_softirq, NULL);
+	run_softirq_on_irqstack_cond();
 }
