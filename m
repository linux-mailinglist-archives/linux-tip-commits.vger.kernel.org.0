Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B9EB3182BF
	for <lists+linux-tip-commits@lfdr.de>; Thu, 11 Feb 2021 01:54:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230333AbhBKAvX (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 10 Feb 2021 19:51:23 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:35534 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230059AbhBKAvJ (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 10 Feb 2021 19:51:09 -0500
Date:   Thu, 11 Feb 2021 00:50:26 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1613004626;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ekGaO8yzrbcjGv5e3X/YOOgr9mUzt/CyqelhfnncumQ=;
        b=Mod2fJwLumzFQEN/bhZH/oUbN01pK/CS6/cCNQ2RExd3BIe+KTArpg9C7d1nxrqxHQ0hqp
        8pEtjXD+/XEHOszjEUIQkVcMO/UHYP37M6xbXF17+kX4pANZynXoLhJLxH8xeYl7b/OMN4
        HlNK+faIMIxdKaInHn1emRxV6sNGAXayhjY2nHAGjpB3GN/mIqLlS55Npv2nFcDjXfepUJ
        QRXktorUsEK712f9TbsatVSdECKyV3BsSzCYopCLxNSWHQvmfzOPEiB5aqvvz1p0y7NLWM
        dgAz/6r6iugoJTFetrzsLcztUuKpyDYkwq7t/k8xeeO1KLzEkHamSzpZsanUHA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1613004626;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ekGaO8yzrbcjGv5e3X/YOOgr9mUzt/CyqelhfnncumQ=;
        b=iVdsQjTw4GhztveBmKIKZG2rm+rtxZ0gBaZwmhE4dGgNKwQT9LVzdw2GZAZf5pYXEr4WJi
        BwGz5fiV3o+NyCBg==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/entry] x86/irq/64: Adjust the per CPU irq stack pointer by 8
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Kees Cook <keescook@chromium.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210210002512.354260928@linutronix.de>
References: <20210210002512.354260928@linutronix.de>
MIME-Version: 1.0
Message-ID: <161300462633.23325.3267212299771627736.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/entry branch of tip:

Commit-ID:     951c2a51ae75382d519839e2308394ad43ce4b40
Gitweb:        https://git.kernel.org/tip/951c2a51ae75382d519839e2308394ad43ce4b40
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Wed, 10 Feb 2021 00:40:44 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 10 Feb 2021 23:34:14 +01:00

x86/irq/64: Adjust the per CPU irq stack pointer by 8

The per CPU hardirq_stack_ptr contains the pointer to the irq stack in the
form that it is ready to be assigned to [ER]SP so that the first push ends
up on the top entry of the stack.

But the stack switching on 64 bit has the following rules:

    1) Store the current stack pointer (RSP) in the top most stack entry
       to allow the unwinder to link back to the previous stack

    2) Set RSP to the top most stack entry

    3) Invoke functions on the irq stack

    4) Pop RSP from the top most stack entry (stored in #1) so it's back
       to the original stack.

That requires all stack switching code to decrement the stored pointer by 8
in order to be able to store the current RSP and then set RSP to that
location. That's a pointless exercise.

Do the -8 adjustment right when storing the pointer and make the data type
a void pointer to avoid confusion vs. the struct irq_stack data type which
is on 64bit only used to declare the backing store. Move the definition
next to the inuse flag so they likely end up in the same cache
line. Sticking them into a struct to enforce it is a seperate change.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Kees Cook <keescook@chromium.org>
Link: https://lore.kernel.org/r/20210210002512.354260928@linutronix.de

---
 arch/x86/include/asm/irq_stack.h |  6 +++---
 arch/x86/include/asm/processor.h |  7 +++----
 arch/x86/kernel/cpu/common.c     |  2 +-
 arch/x86/kernel/dumpstack_64.c   | 22 ++++++++++++++++------
 arch/x86/kernel/irq_64.c         |  6 ++++--
 5 files changed, 27 insertions(+), 16 deletions(-)

diff --git a/arch/x86/include/asm/irq_stack.h b/arch/x86/include/asm/irq_stack.h
index 4487bb9..554f84b 100644
--- a/arch/x86/include/asm/irq_stack.h
+++ b/arch/x86/include/asm/irq_stack.h
@@ -23,7 +23,7 @@ static __always_inline void __run_on_irqstack(void (*func)(void))
 	void *tos = __this_cpu_read(hardirq_stack_ptr);
 
 	__this_cpu_write(hardirq_stack_inuse, true);
-	asm_call_on_stack(tos - 8, func, NULL);
+	asm_call_on_stack(tos, func, NULL);
 	__this_cpu_write(hardirq_stack_inuse, false);
 }
 
@@ -34,7 +34,7 @@ __run_sysvec_on_irqstack(void (*func)(struct pt_regs *regs),
 	void *tos = __this_cpu_read(hardirq_stack_ptr);
 
 	__this_cpu_write(hardirq_stack_inuse, true);
-	asm_call_sysvec_on_stack(tos - 8, func, regs);
+	asm_call_sysvec_on_stack(tos, func, regs);
 	__this_cpu_write(hardirq_stack_inuse, false);
 }
 
@@ -45,7 +45,7 @@ __run_irq_on_irqstack(void (*func)(struct irq_desc *desc),
 	void *tos = __this_cpu_read(hardirq_stack_ptr);
 
 	__this_cpu_write(hardirq_stack_inuse, true);
-	asm_call_irq_on_stack(tos - 8, func, desc);
+	asm_call_irq_on_stack(tos, func, desc);
 	__this_cpu_write(hardirq_stack_inuse, false);
 }
 
diff --git a/arch/x86/include/asm/processor.h b/arch/x86/include/asm/processor.h
index 11d10f4..dc6d149 100644
--- a/arch/x86/include/asm/processor.h
+++ b/arch/x86/include/asm/processor.h
@@ -426,8 +426,6 @@ struct irq_stack {
 	char		stack[IRQ_STACK_SIZE];
 } __aligned(IRQ_STACK_SIZE);
 
-DECLARE_PER_CPU(struct irq_stack *, hardirq_stack_ptr);
-
 #ifdef CONFIG_X86_32
 DECLARE_PER_CPU(unsigned long, cpu_current_top_of_stack);
 #else
@@ -454,6 +452,7 @@ static inline unsigned long cpu_kernelmode_gs_base(int cpu)
 	return (unsigned long)per_cpu(fixed_percpu_data.gs_base, cpu);
 }
 
+DECLARE_PER_CPU(void *, hardirq_stack_ptr);
 DECLARE_PER_CPU(bool, hardirq_stack_inuse);
 extern asmlinkage void ignore_sysret(void);
 
@@ -473,9 +472,9 @@ struct stack_canary {
 };
 DECLARE_PER_CPU_ALIGNED(struct stack_canary, stack_canary);
 #endif
-/* Per CPU softirq stack pointer */
+DECLARE_PER_CPU(struct irq_stack *, hardirq_stack_ptr);
 DECLARE_PER_CPU(struct irq_stack *, softirq_stack_ptr);
-#endif	/* X86_64 */
+#endif	/* !X86_64 */
 
 extern unsigned int fpu_kernel_xstate_size;
 extern unsigned int fpu_user_xstate_size;
diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index 845c8a4..c5e23f3 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -1739,7 +1739,7 @@ DEFINE_PER_CPU(struct task_struct *, current_task) ____cacheline_aligned =
 	&init_task;
 EXPORT_PER_CPU_SYMBOL(current_task);
 
-DEFINE_PER_CPU(struct irq_stack *, hardirq_stack_ptr);
+DEFINE_PER_CPU(void *, hardirq_stack_ptr);
 DEFINE_PER_CPU(bool, hardirq_stack_inuse);
 
 DEFINE_PER_CPU(int, __preempt_count) = INIT_PREEMPT_COUNT;
diff --git a/arch/x86/kernel/dumpstack_64.c b/arch/x86/kernel/dumpstack_64.c
index 1dd8513..5601b95 100644
--- a/arch/x86/kernel/dumpstack_64.c
+++ b/arch/x86/kernel/dumpstack_64.c
@@ -128,12 +128,21 @@ static __always_inline bool in_exception_stack(unsigned long *stack, struct stac
 
 static __always_inline bool in_irq_stack(unsigned long *stack, struct stack_info *info)
 {
-	unsigned long *end   = (unsigned long *)this_cpu_read(hardirq_stack_ptr);
-	unsigned long *begin = end - (IRQ_STACK_SIZE / sizeof(long));
+	unsigned long *end = (unsigned long *)this_cpu_read(hardirq_stack_ptr);
+	unsigned long *begin;
 
 	/*
-	 * This is a software stack, so 'end' can be a valid stack pointer.
-	 * It just means the stack is empty.
+	 * @end points directly to the top most stack entry to avoid a -8
+	 * adjustment in the stack switch hotpath. Adjust it back before
+	 * calculating @begin.
+	 */
+	end++;
+	begin = end - (IRQ_STACK_SIZE / sizeof(long));
+
+	/*
+	 * Due to the switching logic RSP can never be == @end because the
+	 * final operation is 'popq %rsp' which means after that RSP points
+	 * to the original stack and not to @end.
 	 */
 	if (stack < begin || stack >= end)
 		return false;
@@ -143,8 +152,9 @@ static __always_inline bool in_irq_stack(unsigned long *stack, struct stack_info
 	info->end	= end;
 
 	/*
-	 * The next stack pointer is the first thing pushed by the entry code
-	 * after switching to the irq stack.
+	 * The next stack pointer is stored at the top of the irq stack
+	 * before switching to the irq stack. Actual stack entries are all
+	 * below that.
 	 */
 	info->next_sp = (unsigned long *)*(end - 1);
 
diff --git a/arch/x86/kernel/irq_64.c b/arch/x86/kernel/irq_64.c
index 440eed5..7103f98 100644
--- a/arch/x86/kernel/irq_64.c
+++ b/arch/x86/kernel/irq_64.c
@@ -48,7 +48,8 @@ static int map_irq_stack(unsigned int cpu)
 	if (!va)
 		return -ENOMEM;
 
-	per_cpu(hardirq_stack_ptr, cpu) = va + IRQ_STACK_SIZE;
+	/* Store actual TOS to avoid adjustment in the hotpath */
+	per_cpu(hardirq_stack_ptr, cpu) = va + IRQ_STACK_SIZE - 8;
 	return 0;
 }
 #else
@@ -60,7 +61,8 @@ static int map_irq_stack(unsigned int cpu)
 {
 	void *va = per_cpu_ptr(&irq_stack_backing_store, cpu);
 
-	per_cpu(hardirq_stack_ptr, cpu) = va + IRQ_STACK_SIZE;
+	/* Store actual TOS to avoid adjustment in the hotpath */
+	per_cpu(hardirq_stack_ptr, cpu) = va + IRQ_STACK_SIZE - 8;
 	return 0;
 }
 #endif
