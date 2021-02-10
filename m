Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 439D831668F
	for <lists+linux-tip-commits@lfdr.de>; Wed, 10 Feb 2021 13:25:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230384AbhBJMZf (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 10 Feb 2021 07:25:35 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:59358 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231822AbhBJMXs (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 10 Feb 2021 07:23:48 -0500
Date:   Wed, 10 Feb 2021 12:23:01 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1612959782;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=OQ33l5MwJjRmA99SQkfTfmSO/j16t30ANLED648Vu3Q=;
        b=13DCAXRqLBTaCELRdcsYvtV5xxYRU2Usmuxld2F7ROTRsyoctJ9f7FdSUYUYzKnMYZLUOL
        Squ24fiUaHsxApgkaGMBdbeJ7dUCzZur5ueILC4n+yXiKXhC61grJimmBWSZYF3Go221zK
        9++pdPHdn7Kmi0v+9QoIRmVHmxzYY3DmC/q4FQcfXK/8E9d39Xgz6mr2tyroJpMeDJqcKx
        MfBKJ1jgtOUep9ebJjCY5McP/OKFxEwkHmR1qyktFi+9LcXwVHbMB/5x3KuZ1gZIRcXpX1
        blBZuY9iZ7M4dd3mRSMXNZwdix8LCJqMjK1xZpVmA4vYzaaU0N8uyhPUfGtvcw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1612959782;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=OQ33l5MwJjRmA99SQkfTfmSO/j16t30ANLED648Vu3Q=;
        b=00V6rLz/eBZt/N6BDqYtMr6PiIY03OeqVAmkGEUrXPsxN8yLLZ8f+ogTJJdPbe7icb/o3r
        L1XouUOH6gexQbDw==
From:   "tip-bot2 for Juergen Gross" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/paravirt] x86/pv: Switch SWAPGS to ALTERNATIVE
Cc:     Juergen Gross <jgross@suse.com>, Borislav Petkov <bp@suse.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andy Lutomirski <luto@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210120135555.32594-5-jgross@suse.com>
References: <20210120135555.32594-5-jgross@suse.com>
MIME-Version: 1.0
Message-ID: <161295978140.23325.1897971952756502585.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/paravirt branch of tip:

Commit-ID:     53c9d9240944088274aadbbbafc6138ca462db4f
Gitweb:        https://git.kernel.org/tip/53c9d9240944088274aadbbbafc6138ca462db4f
Author:        Juergen Gross <jgross@suse.com>
AuthorDate:    Wed, 20 Jan 2021 14:55:44 +01:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Wed, 10 Feb 2021 12:25:49 +01:00

x86/pv: Switch SWAPGS to ALTERNATIVE

SWAPGS is used only for interrupts coming from user mode or for
returning to user mode. So there is no reason to use the PARAVIRT
framework, as it can easily be replaced by an ALTERNATIVE depending
on X86_FEATURE_XENPV.

There are several instances using the PV-aware SWAPGS macro in paths
which are never executed in a Xen PV guest. Replace those with the
plain swapgs instruction. For SWAPGS_UNSAFE_STACK the same applies.

Signed-off-by: Juergen Gross <jgross@suse.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Reviewed-by: Borislav Petkov <bp@suse.de>
Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Andy Lutomirski <luto@kernel.org>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20210120135555.32594-5-jgross@suse.com
---
 arch/x86/entry/entry_64.S             | 10 +++++-----
 arch/x86/include/asm/irqflags.h       | 20 ++++++++------------
 arch/x86/include/asm/paravirt.h       | 20 --------------------
 arch/x86/include/asm/paravirt_types.h |  2 --
 arch/x86/kernel/asm-offsets_64.c      |  1 -
 arch/x86/kernel/paravirt.c            |  1 -
 arch/x86/kernel/paravirt_patch.c      |  3 ---
 arch/x86/xen/enlighten_pv.c           |  3 ---
 8 files changed, 13 insertions(+), 47 deletions(-)

diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
index cad0870..a876204 100644
--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -669,7 +669,7 @@ native_irq_return_ldt:
 	 */
 
 	pushq	%rdi				/* Stash user RDI */
-	SWAPGS					/* to kernel GS */
+	swapgs					/* to kernel GS */
 	SWITCH_TO_KERNEL_CR3 scratch_reg=%rdi	/* to kernel CR3 */
 
 	movq	PER_CPU_VAR(espfix_waddr), %rdi
@@ -699,7 +699,7 @@ native_irq_return_ldt:
 	orq	PER_CPU_VAR(espfix_stack), %rax
 
 	SWITCH_TO_USER_CR3_STACK scratch_reg=%rdi
-	SWAPGS					/* to user GS */
+	swapgs					/* to user GS */
 	popq	%rdi				/* Restore user RDI */
 
 	movq	%rax, %rsp
@@ -943,7 +943,7 @@ SYM_CODE_START_LOCAL(paranoid_entry)
 	ret
 
 .Lparanoid_entry_swapgs:
-	SWAPGS
+	swapgs
 
 	/*
 	 * The above SAVE_AND_SWITCH_TO_KERNEL_CR3 macro doesn't do an
@@ -1001,7 +1001,7 @@ SYM_CODE_START_LOCAL(paranoid_exit)
 	jnz		restore_regs_and_return_to_kernel
 
 	/* We are returning to a context with user GSBASE */
-	SWAPGS_UNSAFE_STACK
+	swapgs
 	jmp		restore_regs_and_return_to_kernel
 SYM_CODE_END(paranoid_exit)
 
@@ -1426,7 +1426,7 @@ nmi_no_fsgsbase:
 	jnz	nmi_restore
 
 nmi_swapgs:
-	SWAPGS_UNSAFE_STACK
+	swapgs
 
 nmi_restore:
 	POP_REGS
diff --git a/arch/x86/include/asm/irqflags.h b/arch/x86/include/asm/irqflags.h
index 2dfc8d3..8c86ede 100644
--- a/arch/x86/include/asm/irqflags.h
+++ b/arch/x86/include/asm/irqflags.h
@@ -131,18 +131,6 @@ static __always_inline unsigned long arch_local_irq_save(void)
 #define SAVE_FLAGS(x)		pushfq; popq %rax
 #endif
 
-#define SWAPGS	swapgs
-/*
- * Currently paravirt can't handle swapgs nicely when we
- * don't have a stack we can rely on (such as a user space
- * stack).  So we either find a way around these or just fault
- * and emulate if a guest tries to call swapgs directly.
- *
- * Either way, this is a good way to document that we don't
- * have a reliable stack. x86_64 only.
- */
-#define SWAPGS_UNSAFE_STACK	swapgs
-
 #define INTERRUPT_RETURN	jmp native_iret
 #define USERGS_SYSRET64				\
 	swapgs;					\
@@ -170,6 +158,14 @@ static __always_inline int arch_irqs_disabled(void)
 
 	return arch_irqs_disabled_flags(flags);
 }
+#else
+#ifdef CONFIG_X86_64
+#ifdef CONFIG_XEN_PV
+#define SWAPGS	ALTERNATIVE "swapgs", "", X86_FEATURE_XENPV
+#else
+#define SWAPGS	swapgs
+#endif
+#endif
 #endif /* !__ASSEMBLY__ */
 
 #endif
diff --git a/arch/x86/include/asm/paravirt.h b/arch/x86/include/asm/paravirt.h
index f8dce11..f2ebe10 100644
--- a/arch/x86/include/asm/paravirt.h
+++ b/arch/x86/include/asm/paravirt.h
@@ -776,26 +776,6 @@ extern void default_banner(void);
 
 #ifdef CONFIG_X86_64
 #ifdef CONFIG_PARAVIRT_XXL
-/*
- * If swapgs is used while the userspace stack is still current,
- * there's no way to call a pvop.  The PV replacement *must* be
- * inlined, or the swapgs instruction must be trapped and emulated.
- */
-#define SWAPGS_UNSAFE_STACK						\
-	PARA_SITE(PARA_PATCH(PV_CPU_swapgs), swapgs)
-
-/*
- * Note: swapgs is very special, and in practise is either going to be
- * implemented with a single "swapgs" instruction or something very
- * special.  Either way, we don't need to save any registers for
- * it.
- */
-#define SWAPGS								\
-	PARA_SITE(PARA_PATCH(PV_CPU_swapgs),				\
-		  ANNOTATE_RETPOLINE_SAFE;				\
-		  call PARA_INDIRECT(pv_ops+PV_CPU_swapgs);		\
-		 )
-
 #define USERGS_SYSRET64							\
 	PARA_SITE(PARA_PATCH(PV_CPU_usergs_sysret64),			\
 		  ANNOTATE_RETPOLINE_SAFE;				\
diff --git a/arch/x86/include/asm/paravirt_types.h b/arch/x86/include/asm/paravirt_types.h
index b6b02b7..130f428 100644
--- a/arch/x86/include/asm/paravirt_types.h
+++ b/arch/x86/include/asm/paravirt_types.h
@@ -168,8 +168,6 @@ struct pv_cpu_ops {
 	   frame set up. */
 	void (*iret)(void);
 
-	void (*swapgs)(void);
-
 	void (*start_context_switch)(struct task_struct *prev);
 	void (*end_context_switch)(struct task_struct *next);
 #endif
diff --git a/arch/x86/kernel/asm-offsets_64.c b/arch/x86/kernel/asm-offsets_64.c
index 828be79..1354bc3 100644
--- a/arch/x86/kernel/asm-offsets_64.c
+++ b/arch/x86/kernel/asm-offsets_64.c
@@ -15,7 +15,6 @@ int main(void)
 #ifdef CONFIG_PARAVIRT_XXL
 	OFFSET(PV_CPU_usergs_sysret64, paravirt_patch_template,
 	       cpu.usergs_sysret64);
-	OFFSET(PV_CPU_swapgs, paravirt_patch_template, cpu.swapgs);
 #ifdef CONFIG_DEBUG_ENTRY
 	OFFSET(PV_IRQ_save_fl, paravirt_patch_template, irq.save_fl);
 #endif
diff --git a/arch/x86/kernel/paravirt.c b/arch/x86/kernel/paravirt.c
index 6c3407b..5e5fcf5 100644
--- a/arch/x86/kernel/paravirt.c
+++ b/arch/x86/kernel/paravirt.c
@@ -312,7 +312,6 @@ struct paravirt_patch_template pv_ops = {
 
 	.cpu.usergs_sysret64	= native_usergs_sysret64,
 	.cpu.iret		= native_iret,
-	.cpu.swapgs		= native_swapgs,
 
 #ifdef CONFIG_X86_IOPL_IOPERM
 	.cpu.invalidate_io_bitmap	= native_tss_invalidate_io_bitmap,
diff --git a/arch/x86/kernel/paravirt_patch.c b/arch/x86/kernel/paravirt_patch.c
index ace6e33..7c518b0 100644
--- a/arch/x86/kernel/paravirt_patch.c
+++ b/arch/x86/kernel/paravirt_patch.c
@@ -28,7 +28,6 @@ struct patch_xxl {
 	const unsigned char	irq_restore_fl[2];
 	const unsigned char	cpu_wbinvd[2];
 	const unsigned char	cpu_usergs_sysret64[6];
-	const unsigned char	cpu_swapgs[3];
 	const unsigned char	mov64[3];
 };
 
@@ -43,7 +42,6 @@ static const struct patch_xxl patch_data_xxl = {
 	.cpu_wbinvd		= { 0x0f, 0x09 },	// wbinvd
 	.cpu_usergs_sysret64	= { 0x0f, 0x01, 0xf8,
 				    0x48, 0x0f, 0x07 },	// swapgs; sysretq
-	.cpu_swapgs		= { 0x0f, 0x01, 0xf8 },	// swapgs
 	.mov64			= { 0x48, 0x89, 0xf8 },	// mov %rdi, %rax
 };
 
@@ -86,7 +84,6 @@ unsigned int native_patch(u8 type, void *insn_buff, unsigned long addr,
 	PATCH_CASE(mmu, write_cr3, xxl, insn_buff, len);
 
 	PATCH_CASE(cpu, usergs_sysret64, xxl, insn_buff, len);
-	PATCH_CASE(cpu, swapgs, xxl, insn_buff, len);
 	PATCH_CASE(cpu, wbinvd, xxl, insn_buff, len);
 #endif
 
diff --git a/arch/x86/xen/enlighten_pv.c b/arch/x86/xen/enlighten_pv.c
index 1fec2ee..95f3799 100644
--- a/arch/x86/xen/enlighten_pv.c
+++ b/arch/x86/xen/enlighten_pv.c
@@ -1098,9 +1098,6 @@ static const struct pv_cpu_ops xen_cpu_ops __initconst = {
 #endif
 	.io_delay = xen_io_delay,
 
-	/* Xen takes care of %gs when switching to usermode for us */
-	.swapgs = paravirt_nop,
-
 	.start_context_switch = paravirt_start_context_switch,
 	.end_context_switch = xen_end_context_switch,
 };
