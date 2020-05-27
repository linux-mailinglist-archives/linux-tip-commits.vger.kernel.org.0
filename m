Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29E2B1E3B9A
	for <lists+linux-tip-commits@lfdr.de>; Wed, 27 May 2020 10:14:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729428AbgE0ILt (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 27 May 2020 04:11:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729424AbgE0ILs (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 27 May 2020 04:11:48 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A56C9C061A0F;
        Wed, 27 May 2020 01:11:48 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jdrAB-0002Ud-3W; Wed, 27 May 2020 10:11:47 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id A27E01C00ED;
        Wed, 27 May 2020 10:11:46 +0200 (CEST)
Date:   Wed, 27 May 2020 08:11:46 -0000
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/entry] x86/entry: Remove the apic/BUILD interrupt leftovers
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        Andy Lutomirski <luto@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200521202119.927433002@linutronix.de>
References: <20200521202119.927433002@linutronix.de>
MIME-Version: 1.0
Message-ID: <159056710651.17951.10117822810854579691.tip-bot2@tip-bot2>
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

The following commit has been merged into the x86/entry branch of tip:

Commit-ID:     cdafb7e8e71cf6567ff26e42c4c9d8b88374a1cb
Gitweb:        https://git.kernel.org/tip/cdafb7e8e71cf6567ff26e42c4c9d8b88374a1cb
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Thu, 21 May 2020 22:05:46 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 26 May 2020 19:06:29 +02:00

x86/entry: Remove the apic/BUILD interrupt leftovers

Remove all the code which was there to emit the system vector stubs. All
users are gone.

Move the now unused GET_CR2_INTO macro muck to head_64.S where the last
user is. Fixup the eye hurting comment there while at it.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Acked-by: Andy Lutomirski <luto@kernel.org>
Link: https://lore.kernel.org/r/20200521202119.927433002@linutronix.de
---
 arch/x86/entry/calling.h          |  20 +----
 arch/x86/entry/entry_32.S         |  18 +----
 arch/x86/entry/entry_64.S         | 143 +-----------------------------
 arch/x86/include/asm/entry_arch.h |  12 +--
 arch/x86/kernel/head_64.S         |   7 +-
 5 files changed, 4 insertions(+), 196 deletions(-)
 delete mode 100644 arch/x86/include/asm/entry_arch.h

diff --git a/arch/x86/entry/calling.h b/arch/x86/entry/calling.h
index 98da0d3..4208c1e 100644
--- a/arch/x86/entry/calling.h
+++ b/arch/x86/entry/calling.h
@@ -351,23 +351,3 @@ For 32-bit we have the following conventions - kernel is built with
 	call stackleak_erase
 #endif
 .endm
-
-/*
- * This does 'call enter_from_user_mode' unless we can avoid it based on
- * kernel config or using the static jump infrastructure.
- */
-.macro CALL_enter_from_user_mode
-#ifdef CONFIG_CONTEXT_TRACKING
-#ifdef CONFIG_JUMP_LABEL
-	STATIC_JUMP_IF_FALSE .Lafter_call_\@, context_tracking_key, def=0
-#endif
-	call enter_from_user_mode
-.Lafter_call_\@:
-#endif
-.endm
-
-#ifdef CONFIG_PARAVIRT_XXL
-#define GET_CR2_INTO(reg) GET_CR2_INTO_AX ; _ASM_MOV %_ASM_AX, reg
-#else
-#define GET_CR2_INTO(reg) _ASM_MOV %cr2, reg
-#endif
diff --git a/arch/x86/entry/entry_32.S b/arch/x86/entry/entry_32.S
index e034b56..4a4f34b 100644
--- a/arch/x86/entry/entry_32.S
+++ b/arch/x86/entry/entry_32.S
@@ -1233,24 +1233,6 @@ SYM_FUNC_END(entry_INT80_32)
 #endif
 .endm
 
-#define BUILD_INTERRUPT3(name, nr, fn)			\
-SYM_FUNC_START(name)					\
-	ASM_CLAC;					\
-	pushl	$~(nr);					\
-	SAVE_ALL switch_stacks=1;			\
-	ENCODE_FRAME_POINTER;				\
-	TRACE_IRQS_OFF					\
-	movl	%esp, %eax;				\
-	call	fn;					\
-	jmp	ret_from_intr;				\
-SYM_FUNC_END(name)
-
-#define BUILD_INTERRUPT(name, nr)		\
-	BUILD_INTERRUPT3(name, nr, smp_##name);	\
-
-/* The include is where all of the SMP etc. interrupts come from */
-#include <asm/entry_arch.h>
-
 #ifdef CONFIG_PARAVIRT
 SYM_CODE_START(native_iret)
 	iret
diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
index 9c0722e..389f97f 100644
--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -658,108 +658,7 @@ SYM_CODE_END(\asmsym)
  */
 #include <asm/idtentry.h>
 
-/*
- * Interrupt entry helper function.
- *
- * Entry runs with interrupts off. Stack layout at entry:
- * +----------------------------------------------------+
- * | regs->ss						|
- * | regs->rsp						|
- * | regs->eflags					|
- * | regs->cs						|
- * | regs->ip						|
- * +----------------------------------------------------+
- * | regs->orig_ax = ~(interrupt number)		|
- * +----------------------------------------------------+
- * | return address					|
- * +----------------------------------------------------+
- */
-SYM_CODE_START(interrupt_entry)
-	UNWIND_HINT_IRET_REGS offset=16
-	ASM_CLAC
-	cld
-
-	testb	$3, CS-ORIG_RAX+8(%rsp)
-	jz	1f
-	SWAPGS
-	FENCE_SWAPGS_USER_ENTRY
-	/*
-	 * Switch to the thread stack. The IRET frame and orig_ax are
-	 * on the stack, as well as the return address. RDI..R12 are
-	 * not (yet) on the stack and space has not (yet) been
-	 * allocated for them.
-	 */
-	pushq	%rdi
-
-	/* Need to switch before accessing the thread stack. */
-	SWITCH_TO_KERNEL_CR3 scratch_reg=%rdi
-	movq	%rsp, %rdi
-	movq	PER_CPU_VAR(cpu_current_top_of_stack), %rsp
-
-	 /*
-	  * We have RDI, return address, and orig_ax on the stack on
-	  * top of the IRET frame. That means offset=24
-	  */
-	UNWIND_HINT_IRET_REGS base=%rdi offset=24
-
-	pushq	7*8(%rdi)		/* regs->ss */
-	pushq	6*8(%rdi)		/* regs->rsp */
-	pushq	5*8(%rdi)		/* regs->eflags */
-	pushq	4*8(%rdi)		/* regs->cs */
-	pushq	3*8(%rdi)		/* regs->ip */
-	UNWIND_HINT_IRET_REGS
-	pushq	2*8(%rdi)		/* regs->orig_ax */
-	pushq	8(%rdi)			/* return address */
-
-	movq	(%rdi), %rdi
-	jmp	2f
-1:
-	FENCE_SWAPGS_KERNEL_ENTRY
-2:
-	PUSH_AND_CLEAR_REGS save_ret=1
-	ENCODE_FRAME_POINTER 8
-
-	testb	$3, CS+8(%rsp)
-	jz	1f
-
-	/*
-	 * IRQ from user mode.
-	 *
-	 * We need to tell lockdep that IRQs are off.  We can't do this until
-	 * we fix gsbase, and we should do it before enter_from_user_mode
-	 * (which can take locks).  Since TRACE_IRQS_OFF is idempotent,
-	 * the simplest way to handle it is to just call it twice if
-	 * we enter from user mode.  There's no reason to optimize this since
-	 * TRACE_IRQS_OFF is a no-op if lockdep is off.
-	 */
-	TRACE_IRQS_OFF
-
-	CALL_enter_from_user_mode
-
-1:
-	ENTER_IRQ_STACK old_rsp=%rdi save_ret=1
-	/* We entered an interrupt context - irqs are off: */
-	TRACE_IRQS_OFF
-
-	ret
-SYM_CODE_END(interrupt_entry)
-_ASM_NOKPROBE(interrupt_entry)
-
 SYM_CODE_START_LOCAL(common_interrupt_return)
-ret_from_intr:
-	DISABLE_INTERRUPTS(CLBR_ANY)
-	TRACE_IRQS_OFF
-
-	LEAVE_IRQ_STACK
-
-	testb	$3, CS(%rsp)
-	jz	retint_kernel
-
-	/* Interrupt came from user space */
-.Lretint_user:
-	mov	%rsp,%rdi
-	call	prepare_exit_to_usermode
-
 SYM_INNER_LABEL(swapgs_restore_regs_and_return_to_usermode, SYM_L_GLOBAL)
 #ifdef CONFIG_DEBUG_ENTRY
 	/* Assert that pt_regs indicates user mode. */
@@ -802,23 +701,6 @@ SYM_INNER_LABEL(swapgs_restore_regs_and_return_to_usermode, SYM_L_GLOBAL)
 	INTERRUPT_RETURN
 
 
-/* Returning to kernel space */
-retint_kernel:
-#ifdef CONFIG_PREEMPTION
-	/* Interrupts are off */
-	/* Check if we need preemption */
-	btl	$9, EFLAGS(%rsp)		/* were interrupts off? */
-	jnc	1f
-	cmpl	$0, PER_CPU_VAR(__preempt_count)
-	jnz	1f
-	call	preempt_schedule_irq
-1:
-#endif
-	/*
-	 * The iretq could re-enable interrupts:
-	 */
-	TRACE_IRQS_IRETQ
-
 SYM_INNER_LABEL(restore_regs_and_return_to_kernel, SYM_L_GLOBAL)
 #ifdef CONFIG_DEBUG_ENTRY
 	/* Assert that pt_regs indicates kernel mode. */
@@ -932,31 +814,6 @@ SYM_CODE_END(common_interrupt_return)
 _ASM_NOKPROBE(common_interrupt_return)
 
 /*
- * APIC interrupts.
- */
-.macro apicinterrupt3 num sym do_sym
-SYM_CODE_START(\sym)
-	UNWIND_HINT_IRET_REGS
-	pushq	$~(\num)
-	call	interrupt_entry
-	UNWIND_HINT_REGS indirect=1
-	call	\do_sym	/* rdi points to pt_regs */
-	jmp	ret_from_intr
-SYM_CODE_END(\sym)
-_ASM_NOKPROBE(\sym)
-.endm
-
-/* Make sure APIC interrupt handlers end up in the irqentry section: */
-#define PUSH_SECTION_IRQENTRY	.pushsection .irqentry.text, "ax"
-#define POP_SECTION_IRQENTRY	.popsection
-
-.macro apicinterrupt num sym do_sym
-PUSH_SECTION_IRQENTRY
-apicinterrupt3 \num \sym \do_sym
-POP_SECTION_IRQENTRY
-.endm
-
-/*
  * Reload gs selector with exception handling
  * edi:  new selector
  *
diff --git a/arch/x86/include/asm/entry_arch.h b/arch/x86/include/asm/entry_arch.h
deleted file mode 100644
index 3e841ed..0000000
--- a/arch/x86/include/asm/entry_arch.h
+++ /dev/null
@@ -1,12 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-/*
- * This file is designed to contain the BUILD_INTERRUPT specifications for
- * all of the extra named interrupt vectors used by the architecture.
- * Usually this is the Inter Process Interrupts (IPIs)
- */
-
-/*
- * The following vectors are part of the Linux architecture, there
- * is no hardware IRQ pin equivalent for them, they are triggered
- * through the ICC by us (IPIs)
- */
diff --git a/arch/x86/kernel/head_64.S b/arch/x86/kernel/head_64.S
index 4bbc770..5ad0217 100644
--- a/arch/x86/kernel/head_64.S
+++ b/arch/x86/kernel/head_64.S
@@ -29,15 +29,16 @@
 #ifdef CONFIG_PARAVIRT_XXL
 #include <asm/asm-offsets.h>
 #include <asm/paravirt.h>
+#define GET_CR2_INTO(reg) GET_CR2_INTO_AX ; _ASM_MOV %_ASM_AX, reg
 #else
 #define INTERRUPT_RETURN iretq
+#define GET_CR2_INTO(reg) _ASM_MOV %cr2, reg
 #endif
 
-/* we are not able to switch in one step to the final KERNEL ADDRESS SPACE
+/*
+ * We are not able to switch in one step to the final KERNEL ADDRESS SPACE
  * because we need identity-mapped pages.
- *
  */
-
 #define l4_index(x)	(((x) >> 39) & 511)
 #define pud_index(x)	(((x) >> PUD_SHIFT) & (PTRS_PER_PUD-1))
 
