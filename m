Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 39223412F6C
	for <lists+linux-tip-commits@lfdr.de>; Tue, 21 Sep 2021 09:28:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230264AbhIUH3k (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Tue, 21 Sep 2021 03:29:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230208AbhIUH3f (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Tue, 21 Sep 2021 03:29:35 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 781BDC061760;
        Tue, 21 Sep 2021 00:28:07 -0700 (PDT)
Date:   Tue, 21 Sep 2021 07:28:05 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1632209286;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=seYp2JFJW3PnhRbeMVnSXiJny58uYLLAWgIxOfgjfXU=;
        b=s+q/HQDjjUhLQyGMVxqREF1mPCep1AmvCU3o9CfFH8vYlIw1zeyMwx3+HkFGwnY9Lbedds
        senohJU7YmRNEbD8VyyORL9q9X3HEeIVnOIjdBNglAgUoOrOoBmKG54W7J4l/tVwX3v5M5
        I9k2s9acovUK96+kg+74cad9yaXpu64iTL4BPZIQl/SYHFlkAh82kaz6FV6v4I/zhk9/ZN
        +XsKvlhE23yqkO3lAO7EXTWq3XTPRfu1lhsRvifg3ppA7C0BV35WcKEQPNTOI04TRhIsZ0
        bPpTVkSVrg59Lui8blp12R5iQs/iCqIeKATCbXU7C9wXQQPUB7wgc/SRou3vNg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1632209286;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=seYp2JFJW3PnhRbeMVnSXiJny58uYLLAWgIxOfgjfXU=;
        b=0QzpGwVtri1WpvGBXwBEqIB7nNTMefsy1hKxQGdN5MOuxpfRiAi6PtRF716ndP6AVR0kK4
        W/C5BncUmgZv5qCA==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/core] x86/mm/64: Improve stack overflow warnings
Cc:     Michael Wang <yun.wang@linux.alibaba.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <NuqnaWbST8n@hirez.programming.kicks-ass.net>
References: <NuqnaWbST8n@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Message-ID: <163220928531.25758.4034642514868275308.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/core branch of tip:

Commit-ID:     074caf5fcf936a44359adcbc4d7792a29f6f129f
Gitweb:        https://git.kernel.org/tip/074caf5fcf936a44359adcbc4d7792a29f6f129f
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Wed, 15 Sep 2021 17:12:59 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Sat, 18 Sep 2021 12:18:33 +02:00

x86/mm/64: Improve stack overflow warnings

Current code has an explicit check for hitting the task stack guard;
but overflowing any of the other stacks will get you a non-descript
general #DF warning.

Improve matters by using get_stack_info_noinstr() to detetrmine if and
which stack guard page got hit, enabling a better stack warning.

In specific, Michael Wang reported what turned out to be an NMI
exception stack overflow, which is now clearly reported as such:

  [] BUG: NMI stack guard page was hit at 0000000085fd977b (stack is 000000003a55b09e..00000000d8cce1a5)

Reported-by: Michael Wang <yun.wang@linux.alibaba.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Tested-by: Michael Wang <yun.wang@linux.alibaba.com>
Link: https://lkml.kernel.org/r/YUTE/NuqnaWbST8n@hirez.programming.kicks-ass.net
---
 arch/x86/include/asm/irq_stack.h  | 37 ++++++++++++++++++++----------
 arch/x86/include/asm/stacktrace.h | 10 ++++++++-
 arch/x86/include/asm/traps.h      |  6 ++---
 arch/x86/kernel/dumpstack_64.c    |  6 +++++-
 arch/x86/kernel/traps.c           | 25 ++++++++++----------
 arch/x86/mm/fault.c               | 20 ++++++++--------
 6 files changed, 67 insertions(+), 37 deletions(-)

diff --git a/arch/x86/include/asm/irq_stack.h b/arch/x86/include/asm/irq_stack.h
index 562854c..8d55bd1 100644
--- a/arch/x86/include/asm/irq_stack.h
+++ b/arch/x86/include/asm/irq_stack.h
@@ -77,11 +77,11 @@
  *     Function calls can clobber anything except the callee-saved
  *     registers. Tell the compiler.
  */
-#define call_on_irqstack(func, asm_call, argconstr...)			\
+#define call_on_stack(stack, func, asm_call, argconstr...)		\
 {									\
 	register void *tos asm("r11");					\
 									\
-	tos = ((void *)__this_cpu_read(hardirq_stack_ptr));		\
+	tos = ((void *)(stack));					\
 									\
 	asm_inline volatile(						\
 	"movq	%%rsp, (%[tos])				\n"		\
@@ -98,6 +98,25 @@
 	);								\
 }
 
+#define ASM_CALL_ARG0							\
+	"call %P[__func]				\n"
+
+#define ASM_CALL_ARG1							\
+	"movq	%[arg1], %%rdi				\n"		\
+	ASM_CALL_ARG0
+
+#define ASM_CALL_ARG2							\
+	"movq	%[arg2], %%rsi				\n"		\
+	ASM_CALL_ARG1
+
+#define ASM_CALL_ARG3							\
+	"movq	%[arg3], %%rdx				\n"		\
+	ASM_CALL_ARG2
+
+#define call_on_irqstack(func, asm_call, argconstr...)			\
+	call_on_stack(__this_cpu_read(hardirq_stack_ptr),		\
+		      func, asm_call, argconstr)
+
 /* Macros to assert type correctness for run_*_on_irqstack macros */
 #define assert_function_type(func, proto)				\
 	static_assert(__builtin_types_compatible_p(typeof(&func), proto))
@@ -147,8 +166,7 @@
  */
 #define ASM_CALL_SYSVEC							\
 	"call irq_enter_rcu				\n"		\
-	"movq	%[arg1], %%rdi				\n"		\
-	"call %P[__func]				\n"		\
+	ASM_CALL_ARG1							\
 	"call irq_exit_rcu				\n"
 
 #define SYSVEC_CONSTRAINTS	, [arg1] "r" (regs)
@@ -168,12 +186,10 @@
  */
 #define ASM_CALL_IRQ							\
 	"call irq_enter_rcu				\n"		\
-	"movq	%[arg1], %%rdi				\n"		\
-	"movl	%[arg2], %%esi				\n"		\
-	"call %P[__func]				\n"		\
+	ASM_CALL_ARG2							\
 	"call irq_exit_rcu				\n"
 
-#define IRQ_CONSTRAINTS	, [arg1] "r" (regs), [arg2] "r" (vector)
+#define IRQ_CONSTRAINTS	, [arg1] "r" (regs), [arg2] "r" ((unsigned long)vector)
 
 #define run_irq_on_irqstack_cond(func, regs, vector)			\
 {									\
@@ -185,9 +201,6 @@
 			      IRQ_CONSTRAINTS, regs, vector);		\
 }
 
-#define ASM_CALL_SOFTIRQ						\
-	"call %P[__func]				\n"
-
 /*
  * Macro to invoke __do_softirq on the irq stack. This is only called from
  * task context when bottom halves are about to be reenabled and soft
@@ -197,7 +210,7 @@
 #define do_softirq_own_stack()						\
 {									\
 	__this_cpu_write(hardirq_stack_inuse, true);			\
-	call_on_irqstack(__do_softirq, ASM_CALL_SOFTIRQ);		\
+	call_on_irqstack(__do_softirq, ASM_CALL_ARG0);			\
 	__this_cpu_write(hardirq_stack_inuse, false);			\
 }
 
diff --git a/arch/x86/include/asm/stacktrace.h b/arch/x86/include/asm/stacktrace.h
index f248eb2..3881b53 100644
--- a/arch/x86/include/asm/stacktrace.h
+++ b/arch/x86/include/asm/stacktrace.h
@@ -38,6 +38,16 @@ int get_stack_info(unsigned long *stack, struct task_struct *task,
 bool get_stack_info_noinstr(unsigned long *stack, struct task_struct *task,
 			    struct stack_info *info);
 
+static __always_inline
+bool get_stack_guard_info(unsigned long *stack, struct stack_info *info)
+{
+	/* make sure it's not in the stack proper */
+	if (get_stack_info_noinstr(stack, current, info))
+		return false;
+	/* but if it is in the page below it, we hit a guard */
+	return get_stack_info_noinstr((void *)stack + PAGE_SIZE, current, info);
+}
+
 const char *stack_type_name(enum stack_type type);
 
 static inline bool on_stack(struct stack_info *info, void *addr, size_t len)
diff --git a/arch/x86/include/asm/traps.h b/arch/x86/include/asm/traps.h
index 7f72000..6221be7 100644
--- a/arch/x86/include/asm/traps.h
+++ b/arch/x86/include/asm/traps.h
@@ -40,9 +40,9 @@ void math_emulate(struct math_emu_info *);
 bool fault_in_kernel_space(unsigned long address);
 
 #ifdef CONFIG_VMAP_STACK
-void __noreturn handle_stack_overflow(const char *message,
-				      struct pt_regs *regs,
-				      unsigned long fault_address);
+void __noreturn handle_stack_overflow(struct pt_regs *regs,
+				      unsigned long fault_address,
+				      struct stack_info *info);
 #endif
 
 #endif /* _ASM_X86_TRAPS_H */
diff --git a/arch/x86/kernel/dumpstack_64.c b/arch/x86/kernel/dumpstack_64.c
index 5601b95..6c5defd 100644
--- a/arch/x86/kernel/dumpstack_64.c
+++ b/arch/x86/kernel/dumpstack_64.c
@@ -32,9 +32,15 @@ const char *stack_type_name(enum stack_type type)
 {
 	BUILD_BUG_ON(N_EXCEPTION_STACKS != 6);
 
+	if (type == STACK_TYPE_TASK)
+		return "TASK";
+
 	if (type == STACK_TYPE_IRQ)
 		return "IRQ";
 
+	if (type == STACK_TYPE_SOFTIRQ)
+		return "SOFTIRQ";
+
 	if (type == STACK_TYPE_ENTRY) {
 		/*
 		 * On 64-bit, we have a generic entry stack that we
diff --git a/arch/x86/kernel/traps.c b/arch/x86/kernel/traps.c
index f3f3034..cc6de3a 100644
--- a/arch/x86/kernel/traps.c
+++ b/arch/x86/kernel/traps.c
@@ -313,17 +313,19 @@ out:
 }
 
 #ifdef CONFIG_VMAP_STACK
-__visible void __noreturn handle_stack_overflow(const char *message,
-						struct pt_regs *regs,
-						unsigned long fault_address)
+__visible void __noreturn handle_stack_overflow(struct pt_regs *regs,
+						unsigned long fault_address,
+						struct stack_info *info)
 {
-	printk(KERN_EMERG "BUG: stack guard page was hit at %p (stack is %p..%p)\n",
-		 (void *)fault_address, current->stack,
-		 (char *)current->stack + THREAD_SIZE - 1);
-	die(message, regs, 0);
+	const char *name = stack_type_name(info->type);
+
+	printk(KERN_EMERG "BUG: %s stack guard page was hit at %p (stack is %p..%p)\n",
+	       name, (void *)fault_address, info->begin, info->end);
+
+	die("stack guard page", regs, 0);
 
 	/* Be absolutely certain we don't return. */
-	panic("%s", message);
+	panic("%s stack guard hit", name);
 }
 #endif
 
@@ -353,6 +355,7 @@ DEFINE_IDTENTRY_DF(exc_double_fault)
 
 #ifdef CONFIG_VMAP_STACK
 	unsigned long address = read_cr2();
+	struct stack_info info;
 #endif
 
 #ifdef CONFIG_X86_ESPFIX64
@@ -455,10 +458,8 @@ DEFINE_IDTENTRY_DF(exc_double_fault)
 	 * stack even if the actual trigger for the double fault was
 	 * something else.
 	 */
-	if ((unsigned long)task_stack_page(tsk) - 1 - address < PAGE_SIZE) {
-		handle_stack_overflow("kernel stack overflow (double-fault)",
-				      regs, address);
-	}
+	if (get_stack_guard_info((void *)address, &info))
+		handle_stack_overflow(regs, address, &info);
 #endif
 
 	pr_emerg("PANIC: double fault, error_code: 0x%lx\n", error_code);
diff --git a/arch/x86/mm/fault.c b/arch/x86/mm/fault.c
index b2eefde..edb5152 100644
--- a/arch/x86/mm/fault.c
+++ b/arch/x86/mm/fault.c
@@ -32,6 +32,7 @@
 #include <asm/pgtable_areas.h>		/* VMALLOC_START, ...		*/
 #include <asm/kvm_para.h>		/* kvm_handle_async_pf		*/
 #include <asm/vdso.h>			/* fixup_vdso_exception()	*/
+#include <asm/irq_stack.h>
 
 #define CREATE_TRACE_POINTS
 #include <asm/trace/exceptions.h>
@@ -631,6 +632,9 @@ static noinline void
 page_fault_oops(struct pt_regs *regs, unsigned long error_code,
 		unsigned long address)
 {
+#ifdef CONFIG_VMAP_STACK
+	struct stack_info info;
+#endif
 	unsigned long flags;
 	int sig;
 
@@ -649,9 +653,7 @@ page_fault_oops(struct pt_regs *regs, unsigned long error_code,
 	 * that we're in vmalloc space to avoid this.
 	 */
 	if (is_vmalloc_addr((void *)address) &&
-	    (((unsigned long)current->stack - 1 - address < PAGE_SIZE) ||
-	     address - ((unsigned long)current->stack + THREAD_SIZE) < PAGE_SIZE)) {
-		unsigned long stack = __this_cpu_ist_top_va(DF) - sizeof(void *);
+	    get_stack_guard_info((void *)address, &info)) {
 		/*
 		 * We're likely to be running with very little stack space
 		 * left.  It's plausible that we'd hit this condition but
@@ -662,13 +664,11 @@ page_fault_oops(struct pt_regs *regs, unsigned long error_code,
 		 * and then double-fault, though, because we're likely to
 		 * break the console driver and lose most of the stack dump.
 		 */
-		asm volatile ("movq %[stack], %%rsp\n\t"
-			      "call handle_stack_overflow\n\t"
-			      "1: jmp 1b"
-			      : ASM_CALL_CONSTRAINT
-			      : "D" ("kernel stack overflow (page fault)"),
-				"S" (regs), "d" (address),
-				[stack] "rm" (stack));
+		call_on_stack(__this_cpu_ist_top_va(DF) - sizeof(void*),
+			      handle_stack_overflow,
+			      ASM_CALL_ARG3,
+			      , [arg1] "r" (regs), [arg2] "r" (address), [arg3] "r" (&info));
+
 		unreachable();
 	}
 #endif
