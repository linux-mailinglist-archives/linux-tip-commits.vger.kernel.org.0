Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B5286316690
	for <lists+linux-tip-commits@lfdr.de>; Wed, 10 Feb 2021 13:25:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230243AbhBJMZh (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 10 Feb 2021 07:25:37 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:59350 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231617AbhBJMXt (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 10 Feb 2021 07:23:49 -0500
Date:   Wed, 10 Feb 2021 12:23:01 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1612959781;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Lta0Yc5nODjHnrsFaY12CMPrwlhv7eBXAxzkAvCk7Ao=;
        b=V4iywZwGpJf0VMv8fyqpR81m3WvfI0E4W3iZy6DU3LPgyOMhsS/fayTdO9gqFGdQ7tTBM2
        cyV2PXh/g83bVXvIwJjIbiW1UJbJaj+2Q4HvwFYn7wozVR6BGnQnjbvQe1kZyU40wJNM1k
        RG2C9yvsl1Im2i1oSw+Hjwy4z8VN7DUG0k2kOmDaKvL1FW+MHQ6N3qt+MIKptlZe9AItNA
        bxXNDwbzG76zwJHho57HhRX5KzhuMnOlAoJRXbT8RQXVm3cFZaocfoKULQTxM0zRa+/k/q
        dNzX1Fy/kIDtXo3obPQ0OF8K9uYXrLdsXNsz4vjeiejGc5sGdmw4IFn8WVfXoQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1612959781;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Lta0Yc5nODjHnrsFaY12CMPrwlhv7eBXAxzkAvCk7Ao=;
        b=EbFYAP2480YvGpZYb0/0V07Dpo63SyEP6JU6Yl+UToF0w5yesRO4CY0nLzehdLMiiLvmH8
        3VzA7d69wnSzDhCA==
From:   "tip-bot2 for Juergen Gross" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/paravirt] x86/xen: Drop USERGS_SYSRET64 paravirt call
Cc:     Juergen Gross <jgross@suse.com>, Borislav Petkov <bp@suse.de>,
        x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20210120135555.32594-6-jgross@suse.com>
References: <20210120135555.32594-6-jgross@suse.com>
MIME-Version: 1.0
Message-ID: <161295978107.23325.5529858866676284932.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/paravirt branch of tip:

Commit-ID:     afd30525a659ac0ae0904f0cb4a2ca75522c3123
Gitweb:        https://git.kernel.org/tip/afd30525a659ac0ae0904f0cb4a2ca75522c3123
Author:        Juergen Gross <jgross@suse.com>
AuthorDate:    Wed, 20 Jan 2021 14:55:45 +01:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Wed, 10 Feb 2021 12:32:07 +01:00

x86/xen: Drop USERGS_SYSRET64 paravirt call

USERGS_SYSRET64 is used to return from a syscall via SYSRET, but
a Xen PV guest will nevertheless use the IRET hypercall, as there
is no sysret PV hypercall defined.

So instead of testing all the prerequisites for doing a sysret and
then mangling the stack for Xen PV again for doing an iret just use
the iret exit from the beginning.

This can easily be done via an ALTERNATIVE like it is done for the
sysenter compat case already.

It should be noted that this drops the optimization in Xen for not
restoring a few registers when returning to user mode, but it seems
as if the saved instructions in the kernel more than compensate for
this drop (a kernel build in a Xen PV guest was slightly faster with
this patch applied).

While at it remove the stale sysret32 remnants.

Signed-off-by: Juergen Gross <jgross@suse.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lkml.kernel.org/r/20210120135555.32594-6-jgross@suse.com
---
 arch/x86/entry/entry_64.S             | 16 +++++++---------
 arch/x86/include/asm/irqflags.h       |  6 ------
 arch/x86/include/asm/paravirt.h       |  5 -----
 arch/x86/include/asm/paravirt_types.h |  8 --------
 arch/x86/kernel/asm-offsets_64.c      |  2 --
 arch/x86/kernel/paravirt.c            |  5 +----
 arch/x86/kernel/paravirt_patch.c      |  4 ----
 arch/x86/xen/enlighten_pv.c           |  1 -
 arch/x86/xen/xen-asm.S                | 20 --------------------
 arch/x86/xen/xen-ops.h                |  2 --
 10 files changed, 8 insertions(+), 61 deletions(-)

diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
index a876204..ce0464d 100644
--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -46,14 +46,6 @@
 .code64
 .section .entry.text, "ax"
 
-#ifdef CONFIG_PARAVIRT_XXL
-SYM_CODE_START(native_usergs_sysret64)
-	UNWIND_HINT_EMPTY
-	swapgs
-	sysretq
-SYM_CODE_END(native_usergs_sysret64)
-#endif /* CONFIG_PARAVIRT_XXL */
-
 /*
  * 64-bit SYSCALL instruction entry. Up to 6 arguments in registers.
  *
@@ -123,7 +115,12 @@ SYM_INNER_LABEL(entry_SYSCALL_64_after_hwframe, SYM_L_GLOBAL)
 	 * Try to use SYSRET instead of IRET if we're returning to
 	 * a completely clean 64-bit userspace context.  If we're not,
 	 * go to the slow exit path.
+	 * In the Xen PV case we must use iret anyway.
 	 */
+
+	ALTERNATIVE "", "jmp	swapgs_restore_regs_and_return_to_usermode", \
+		X86_FEATURE_XENPV
+
 	movq	RCX(%rsp), %rcx
 	movq	RIP(%rsp), %r11
 
@@ -215,7 +212,8 @@ syscall_return_via_sysret:
 
 	popq	%rdi
 	popq	%rsp
-	USERGS_SYSRET64
+	swapgs
+	sysretq
 SYM_CODE_END(entry_SYSCALL_64)
 
 /*
diff --git a/arch/x86/include/asm/irqflags.h b/arch/x86/include/asm/irqflags.h
index 8c86ede..e585a47 100644
--- a/arch/x86/include/asm/irqflags.h
+++ b/arch/x86/include/asm/irqflags.h
@@ -132,12 +132,6 @@ static __always_inline unsigned long arch_local_irq_save(void)
 #endif
 
 #define INTERRUPT_RETURN	jmp native_iret
-#define USERGS_SYSRET64				\
-	swapgs;					\
-	sysretq;
-#define USERGS_SYSRET32				\
-	swapgs;					\
-	sysretl
 
 #else
 #define INTERRUPT_RETURN		iret
diff --git a/arch/x86/include/asm/paravirt.h b/arch/x86/include/asm/paravirt.h
index f2ebe10..dd43b11 100644
--- a/arch/x86/include/asm/paravirt.h
+++ b/arch/x86/include/asm/paravirt.h
@@ -776,11 +776,6 @@ extern void default_banner(void);
 
 #ifdef CONFIG_X86_64
 #ifdef CONFIG_PARAVIRT_XXL
-#define USERGS_SYSRET64							\
-	PARA_SITE(PARA_PATCH(PV_CPU_usergs_sysret64),			\
-		  ANNOTATE_RETPOLINE_SAFE;				\
-		  jmp PARA_INDIRECT(pv_ops+PV_CPU_usergs_sysret64);)
-
 #ifdef CONFIG_DEBUG_ENTRY
 #define SAVE_FLAGS(clobbers)                                        \
 	PARA_SITE(PARA_PATCH(PV_IRQ_save_fl),			    \
diff --git a/arch/x86/include/asm/paravirt_types.h b/arch/x86/include/asm/paravirt_types.h
index 130f428..0169365 100644
--- a/arch/x86/include/asm/paravirt_types.h
+++ b/arch/x86/include/asm/paravirt_types.h
@@ -156,14 +156,6 @@ struct pv_cpu_ops {
 
 	u64 (*read_pmc)(int counter);
 
-	/*
-	 * Switch to usermode gs and return to 64-bit usermode using
-	 * sysret.  Only used in 64-bit kernels to return to 64-bit
-	 * processes.  Usermode register state, including %rsp, must
-	 * already be restored.
-	 */
-	void (*usergs_sysret64)(void);
-
 	/* Normal iret.  Jump to this with the standard iret stack
 	   frame set up. */
 	void (*iret)(void);
diff --git a/arch/x86/kernel/asm-offsets_64.c b/arch/x86/kernel/asm-offsets_64.c
index 1354bc3..b14533a 100644
--- a/arch/x86/kernel/asm-offsets_64.c
+++ b/arch/x86/kernel/asm-offsets_64.c
@@ -13,8 +13,6 @@ int main(void)
 {
 #ifdef CONFIG_PARAVIRT
 #ifdef CONFIG_PARAVIRT_XXL
-	OFFSET(PV_CPU_usergs_sysret64, paravirt_patch_template,
-	       cpu.usergs_sysret64);
 #ifdef CONFIG_DEBUG_ENTRY
 	OFFSET(PV_IRQ_save_fl, paravirt_patch_template, irq.save_fl);
 #endif
diff --git a/arch/x86/kernel/paravirt.c b/arch/x86/kernel/paravirt.c
index 5e5fcf5..18560b7 100644
--- a/arch/x86/kernel/paravirt.c
+++ b/arch/x86/kernel/paravirt.c
@@ -135,8 +135,7 @@ unsigned paravirt_patch_default(u8 type, void *insn_buff,
 	else if (opfunc == _paravirt_ident_64)
 		ret = paravirt_patch_ident_64(insn_buff, len);
 
-	else if (type == PARAVIRT_PATCH(cpu.iret) ||
-		 type == PARAVIRT_PATCH(cpu.usergs_sysret64))
+	else if (type == PARAVIRT_PATCH(cpu.iret))
 		/* If operation requires a jmp, then jmp */
 		ret = paravirt_patch_jmp(insn_buff, opfunc, addr, len);
 #endif
@@ -170,7 +169,6 @@ static u64 native_steal_clock(int cpu)
 
 /* These are in entry.S */
 extern void native_iret(void);
-extern void native_usergs_sysret64(void);
 
 static struct resource reserve_ioports = {
 	.start = 0,
@@ -310,7 +308,6 @@ struct paravirt_patch_template pv_ops = {
 
 	.cpu.load_sp0		= native_load_sp0,
 
-	.cpu.usergs_sysret64	= native_usergs_sysret64,
 	.cpu.iret		= native_iret,
 
 #ifdef CONFIG_X86_IOPL_IOPERM
diff --git a/arch/x86/kernel/paravirt_patch.c b/arch/x86/kernel/paravirt_patch.c
index 7c518b0..2fada2c 100644
--- a/arch/x86/kernel/paravirt_patch.c
+++ b/arch/x86/kernel/paravirt_patch.c
@@ -27,7 +27,6 @@ struct patch_xxl {
 	const unsigned char	mmu_write_cr3[3];
 	const unsigned char	irq_restore_fl[2];
 	const unsigned char	cpu_wbinvd[2];
-	const unsigned char	cpu_usergs_sysret64[6];
 	const unsigned char	mov64[3];
 };
 
@@ -40,8 +39,6 @@ static const struct patch_xxl patch_data_xxl = {
 	.mmu_write_cr3		= { 0x0f, 0x22, 0xdf },	// mov %rdi, %cr3
 	.irq_restore_fl		= { 0x57, 0x9d },	// push %rdi; popfq
 	.cpu_wbinvd		= { 0x0f, 0x09 },	// wbinvd
-	.cpu_usergs_sysret64	= { 0x0f, 0x01, 0xf8,
-				    0x48, 0x0f, 0x07 },	// swapgs; sysretq
 	.mov64			= { 0x48, 0x89, 0xf8 },	// mov %rdi, %rax
 };
 
@@ -83,7 +80,6 @@ unsigned int native_patch(u8 type, void *insn_buff, unsigned long addr,
 	PATCH_CASE(mmu, read_cr3, xxl, insn_buff, len);
 	PATCH_CASE(mmu, write_cr3, xxl, insn_buff, len);
 
-	PATCH_CASE(cpu, usergs_sysret64, xxl, insn_buff, len);
 	PATCH_CASE(cpu, wbinvd, xxl, insn_buff, len);
 #endif
 
diff --git a/arch/x86/xen/enlighten_pv.c b/arch/x86/xen/enlighten_pv.c
index 95f3799..6abf3f2 100644
--- a/arch/x86/xen/enlighten_pv.c
+++ b/arch/x86/xen/enlighten_pv.c
@@ -1073,7 +1073,6 @@ static const struct pv_cpu_ops xen_cpu_ops __initconst = {
 	.read_pmc = xen_read_pmc,
 
 	.iret = xen_iret,
-	.usergs_sysret64 = xen_sysret64,
 
 	.load_tr_desc = paravirt_nop,
 	.set_ldt = xen_set_ldt,
diff --git a/arch/x86/xen/xen-asm.S b/arch/x86/xen/xen-asm.S
index eac9dac..1d738c5 100644
--- a/arch/x86/xen/xen-asm.S
+++ b/arch/x86/xen/xen-asm.S
@@ -215,26 +215,6 @@ SYM_CODE_START(xen_iret)
 	jmp hypercall_iret
 SYM_CODE_END(xen_iret)
 
-SYM_CODE_START(xen_sysret64)
-	/*
-	 * We're already on the usermode stack at this point, but
-	 * still with the kernel gs, so we can easily switch back.
-	 *
-	 * tss.sp2 is scratch space.
-	 */
-	movq %rsp, PER_CPU_VAR(cpu_tss_rw + TSS_sp2)
-	movq PER_CPU_VAR(cpu_current_top_of_stack), %rsp
-
-	pushq $__USER_DS
-	pushq PER_CPU_VAR(cpu_tss_rw + TSS_sp2)
-	pushq %r11
-	pushq $__USER_CS
-	pushq %rcx
-
-	pushq $VGCF_in_syscall
-	jmp hypercall_iret
-SYM_CODE_END(xen_sysret64)
-
 /*
  * Xen handles syscall callbacks much like ordinary exceptions, which
  * means we have:
diff --git a/arch/x86/xen/xen-ops.h b/arch/x86/xen/xen-ops.h
index 9546c33..b2fd80a 100644
--- a/arch/x86/xen/xen-ops.h
+++ b/arch/x86/xen/xen-ops.h
@@ -138,8 +138,6 @@ __visible unsigned long xen_read_cr2_direct(void);
 
 /* These are not functions, and cannot be called normally */
 __visible void xen_iret(void);
-__visible void xen_sysret32(void);
-__visible void xen_sysret64(void);
 
 extern int xen_panic_handler_init(void);
 
