Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 06F5C338BF4
	for <lists+linux-tip-commits@lfdr.de>; Fri, 12 Mar 2021 12:55:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229530AbhCLLyr (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 12 Mar 2021 06:54:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231229AbhCLLyj (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 12 Mar 2021 06:54:39 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67D13C061761;
        Fri, 12 Mar 2021 03:54:39 -0800 (PST)
Date:   Fri, 12 Mar 2021 11:54:37 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1615550078;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8M20V248mrLzr/mrsIISQXGJgZ+NxREfUrZEsU+yS+A=;
        b=0uZgPJc2Lg1z6ssUvkHGj0LeaVSX1FxMgnEDM1CjfNfqxgXcgf8T+WQ80hP7PUEbf5drlb
        Rof0WOZzZSExgkG+z71u4YRSJOH8p0X0YPDwi8zN6amDeyNiHU5fptI8vbFEW0hmuUnQTO
        0LOmH8oYgfMJ7OyhkNpmsUCn+2N3IyzllDGcGQo4USDfM8/yNInP4oyn4ti4dKq38wm/sK
        E1Z118FousXgitPRjONxy97vsda6kniWayPwXR7bfbv8YL2tnYtJuTgMeEwnCjIHUbys85
        +J32mCPWSSbEG4Pg7QtFctN3IoOfEGu1LoWJ1c0wzhFaD8+bBRzlkaTNnNMp9g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1615550078;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8M20V248mrLzr/mrsIISQXGJgZ+NxREfUrZEsU+yS+A=;
        b=SQaRCzjjzAyKqJ8vAPEHgDYa6/RkKvsGuM7fTP1kSHZnwjj2CSZmfVpM6fmLP7YRe/yAgo
        JcsbgRFfIIh3CNAw==
From:   "tip-bot2 for Juergen Gross" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/alternatives] x86/paravirt: Switch functions with custom
 code to ALTERNATIVE
Cc:     Juergen Gross <jgross@suse.com>, Borislav Petkov <bp@suse.de>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210311142319.4723-14-jgross@suse.com>
References: <20210311142319.4723-14-jgross@suse.com>
MIME-Version: 1.0
Message-ID: <161555007733.398.3247780140188617697.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/alternatives branch of tip:

Commit-ID:     fafe5e74229fd3f425e3cbfc68b90e615aa6d62f
Gitweb:        https://git.kernel.org/tip/fafe5e74229fd3f425e3cbfc68b90e615aa6d62f
Author:        Juergen Gross <jgross@suse.com>
AuthorDate:    Thu, 11 Mar 2021 15:23:18 +01:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Thu, 11 Mar 2021 20:07:01 +01:00

x86/paravirt: Switch functions with custom code to ALTERNATIVE

Instead of using paravirt patching for custom code sequences use
ALTERNATIVE for the functions with custom code replacements.

Instead of patching an ud2 instruction for unpopulated vector entries
into the caller site, use a simple function just calling BUG() as a
replacement.

Simplify the register defines for assembler paravirt calling, as there
isn't much usage left.

Signed-off-by: Juergen Gross <jgross@suse.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20210311142319.4723-14-jgross@suse.com
---
 arch/x86/entry/entry_64.S             |   2 +-
 arch/x86/include/asm/irqflags.h       |   2 +-
 arch/x86/include/asm/paravirt.h       | 101 ++++++++++++-------------
 arch/x86/include/asm/paravirt_types.h |   6 +-
 arch/x86/kernel/paravirt.c            |  16 +---
 arch/x86/kernel/paravirt_patch.c      |  88 +----------------------
 6 files changed, 58 insertions(+), 157 deletions(-)

diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
index 400908d..12e2e3c 100644
--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -305,7 +305,7 @@ SYM_CODE_END(ret_from_fork)
 .macro DEBUG_ENTRY_ASSERT_IRQS_OFF
 #ifdef CONFIG_DEBUG_ENTRY
 	pushq %rax
-	SAVE_FLAGS(CLBR_RAX)
+	SAVE_FLAGS
 	testl $X86_EFLAGS_IF, %eax
 	jz .Lokay_\@
 	ud2
diff --git a/arch/x86/include/asm/irqflags.h b/arch/x86/include/asm/irqflags.h
index a0efbcd..c5ce984 100644
--- a/arch/x86/include/asm/irqflags.h
+++ b/arch/x86/include/asm/irqflags.h
@@ -111,7 +111,7 @@ static __always_inline unsigned long arch_local_irq_save(void)
 
 #ifdef CONFIG_X86_64
 #ifdef CONFIG_DEBUG_ENTRY
-#define SAVE_FLAGS(x)		pushfq; popq %rax
+#define SAVE_FLAGS		pushfq; popq %rax
 #endif
 
 #define INTERRUPT_RETURN	jmp native_iret
diff --git a/arch/x86/include/asm/paravirt.h b/arch/x86/include/asm/paravirt.h
index 913acf7..43992e5 100644
--- a/arch/x86/include/asm/paravirt.h
+++ b/arch/x86/include/asm/paravirt.h
@@ -135,7 +135,9 @@ static inline void write_cr0(unsigned long x)
 
 static inline unsigned long read_cr2(void)
 {
-	return PVOP_CALLEE0(unsigned long, mmu.read_cr2);
+	return PVOP_ALT_CALLEE0(unsigned long, mmu.read_cr2,
+				"mov %%cr2, %%rax;",
+				ALT_NOT(X86_FEATURE_XENPV));
 }
 
 static inline void write_cr2(unsigned long x)
@@ -145,12 +147,14 @@ static inline void write_cr2(unsigned long x)
 
 static inline unsigned long __read_cr3(void)
 {
-	return PVOP_CALL0(unsigned long, mmu.read_cr3);
+	return PVOP_ALT_CALL0(unsigned long, mmu.read_cr3,
+			      "mov %%cr3, %%rax;", ALT_NOT(X86_FEATURE_XENPV));
 }
 
 static inline void write_cr3(unsigned long x)
 {
-	PVOP_VCALL1(mmu.write_cr3, x);
+	PVOP_ALT_VCALL1(mmu.write_cr3, x,
+			"mov %%rdi, %%cr3", ALT_NOT(X86_FEATURE_XENPV));
 }
 
 static inline void __write_cr4(unsigned long x)
@@ -170,7 +174,7 @@ static inline void halt(void)
 
 static inline void wbinvd(void)
 {
-	PVOP_VCALL0(cpu.wbinvd);
+	PVOP_ALT_VCALL0(cpu.wbinvd, "wbinvd", ALT_NOT(X86_FEATURE_XENPV));
 }
 
 static inline u64 paravirt_read_msr(unsigned msr)
@@ -384,22 +388,28 @@ static inline void paravirt_release_p4d(unsigned long pfn)
 
 static inline pte_t __pte(pteval_t val)
 {
-	return (pte_t) { PVOP_CALLEE1(pteval_t, mmu.make_pte, val) };
+	return (pte_t) { PVOP_ALT_CALLEE1(pteval_t, mmu.make_pte, val,
+					  "mov %%rdi, %%rax",
+					  ALT_NOT(X86_FEATURE_XENPV)) };
 }
 
 static inline pteval_t pte_val(pte_t pte)
 {
-	return PVOP_CALLEE1(pteval_t, mmu.pte_val, pte.pte);
+	return PVOP_ALT_CALLEE1(pteval_t, mmu.pte_val, pte.pte,
+				"mov %%rdi, %%rax", ALT_NOT(X86_FEATURE_XENPV));
 }
 
 static inline pgd_t __pgd(pgdval_t val)
 {
-	return (pgd_t) { PVOP_CALLEE1(pgdval_t, mmu.make_pgd, val) };
+	return (pgd_t) { PVOP_ALT_CALLEE1(pgdval_t, mmu.make_pgd, val,
+					  "mov %%rdi, %%rax",
+					  ALT_NOT(X86_FEATURE_XENPV)) };
 }
 
 static inline pgdval_t pgd_val(pgd_t pgd)
 {
-	return PVOP_CALLEE1(pgdval_t, mmu.pgd_val, pgd.pgd);
+	return PVOP_ALT_CALLEE1(pgdval_t, mmu.pgd_val, pgd.pgd,
+				"mov %%rdi, %%rax", ALT_NOT(X86_FEATURE_XENPV));
 }
 
 #define  __HAVE_ARCH_PTEP_MODIFY_PROT_TRANSACTION
@@ -432,12 +442,15 @@ static inline void set_pmd(pmd_t *pmdp, pmd_t pmd)
 
 static inline pmd_t __pmd(pmdval_t val)
 {
-	return (pmd_t) { PVOP_CALLEE1(pmdval_t, mmu.make_pmd, val) };
+	return (pmd_t) { PVOP_ALT_CALLEE1(pmdval_t, mmu.make_pmd, val,
+					  "mov %%rdi, %%rax",
+					  ALT_NOT(X86_FEATURE_XENPV)) };
 }
 
 static inline pmdval_t pmd_val(pmd_t pmd)
 {
-	return PVOP_CALLEE1(pmdval_t, mmu.pmd_val, pmd.pmd);
+	return PVOP_ALT_CALLEE1(pmdval_t, mmu.pmd_val, pmd.pmd,
+				"mov %%rdi, %%rax", ALT_NOT(X86_FEATURE_XENPV));
 }
 
 static inline void set_pud(pud_t *pudp, pud_t pud)
@@ -449,14 +462,16 @@ static inline pud_t __pud(pudval_t val)
 {
 	pudval_t ret;
 
-	ret = PVOP_CALLEE1(pudval_t, mmu.make_pud, val);
+	ret = PVOP_ALT_CALLEE1(pudval_t, mmu.make_pud, val,
+			       "mov %%rdi, %%rax", ALT_NOT(X86_FEATURE_XENPV));
 
 	return (pud_t) { ret };
 }
 
 static inline pudval_t pud_val(pud_t pud)
 {
-	return PVOP_CALLEE1(pudval_t, mmu.pud_val, pud.pud);
+	return PVOP_ALT_CALLEE1(pudval_t, mmu.pud_val, pud.pud,
+				"mov %%rdi, %%rax", ALT_NOT(X86_FEATURE_XENPV));
 }
 
 static inline void pud_clear(pud_t *pudp)
@@ -475,14 +490,17 @@ static inline void set_p4d(p4d_t *p4dp, p4d_t p4d)
 
 static inline p4d_t __p4d(p4dval_t val)
 {
-	p4dval_t ret = PVOP_CALLEE1(p4dval_t, mmu.make_p4d, val);
+	p4dval_t ret = PVOP_ALT_CALLEE1(p4dval_t, mmu.make_p4d, val,
+					"mov %%rdi, %%rax",
+					ALT_NOT(X86_FEATURE_XENPV));
 
 	return (p4d_t) { ret };
 }
 
 static inline p4dval_t p4d_val(p4d_t p4d)
 {
-	return PVOP_CALLEE1(p4dval_t, mmu.p4d_val, p4d.p4d);
+	return PVOP_ALT_CALLEE1(p4dval_t, mmu.p4d_val, p4d.p4d,
+				"mov %%rdi, %%rax", ALT_NOT(X86_FEATURE_XENPV));
 }
 
 static inline void __set_pgd(pgd_t *pgdp, pgd_t pgd)
@@ -569,7 +587,9 @@ static __always_inline void pv_queued_spin_lock_slowpath(struct qspinlock *lock,
 
 static __always_inline void pv_queued_spin_unlock(struct qspinlock *lock)
 {
-	PVOP_VCALLEE1(lock.queued_spin_unlock, lock);
+	PVOP_ALT_VCALLEE1(lock.queued_spin_unlock, lock,
+			  "movb $0, (%%" _ASM_ARG1 ");",
+			  ALT_NOT(X86_FEATURE_PVUNLOCK));
 }
 
 static __always_inline void pv_wait(u8 *ptr, u8 val)
@@ -584,7 +604,9 @@ static __always_inline void pv_kick(int cpu)
 
 static __always_inline bool pv_vcpu_is_preempted(long cpu)
 {
-	return PVOP_CALLEE1(bool, lock.vcpu_is_preempted, cpu);
+	return PVOP_ALT_CALLEE1(bool, lock.vcpu_is_preempted, cpu,
+				"xor %%" _ASM_AX ", %%" _ASM_AX ";",
+				ALT_NOT(X86_FEATURE_VCPUPREEMPT));
 }
 
 void __raw_callee_save___native_queued_spin_unlock(struct qspinlock *lock);
@@ -658,17 +680,18 @@ bool __raw_callee_save___native_vcpu_is_preempted(long cpu);
 #ifdef CONFIG_PARAVIRT_XXL
 static inline notrace unsigned long arch_local_save_flags(void)
 {
-	return PVOP_CALLEE0(unsigned long, irq.save_fl);
+	return PVOP_ALT_CALLEE0(unsigned long, irq.save_fl, "pushf; pop %%rax;",
+				ALT_NOT(X86_FEATURE_XENPV));
 }
 
 static inline notrace void arch_local_irq_disable(void)
 {
-	PVOP_VCALLEE0(irq.irq_disable);
+	PVOP_ALT_VCALLEE0(irq.irq_disable, "cli;", ALT_NOT(X86_FEATURE_XENPV));
 }
 
 static inline notrace void arch_local_irq_enable(void)
 {
-	PVOP_VCALLEE0(irq.irq_enable);
+	PVOP_ALT_VCALLEE0(irq.irq_enable, "sti;", ALT_NOT(X86_FEATURE_XENPV));
 }
 
 static inline notrace unsigned long arch_local_irq_save(void)
@@ -713,35 +736,9 @@ extern void default_banner(void);
 	.popsection
 
 
-#define COND_PUSH(set, mask, reg)			\
-	.if ((~(set)) & mask); push %reg; .endif
-#define COND_POP(set, mask, reg)			\
-	.if ((~(set)) & mask); pop %reg; .endif
-
 #ifdef CONFIG_X86_64
 #ifdef CONFIG_PARAVIRT_XXL
 
-#define PV_SAVE_REGS(set)			\
-	COND_PUSH(set, CLBR_RAX, rax);		\
-	COND_PUSH(set, CLBR_RCX, rcx);		\
-	COND_PUSH(set, CLBR_RDX, rdx);		\
-	COND_PUSH(set, CLBR_RSI, rsi);		\
-	COND_PUSH(set, CLBR_RDI, rdi);		\
-	COND_PUSH(set, CLBR_R8, r8);		\
-	COND_PUSH(set, CLBR_R9, r9);		\
-	COND_PUSH(set, CLBR_R10, r10);		\
-	COND_PUSH(set, CLBR_R11, r11)
-#define PV_RESTORE_REGS(set)			\
-	COND_POP(set, CLBR_R11, r11);		\
-	COND_POP(set, CLBR_R10, r10);		\
-	COND_POP(set, CLBR_R9, r9);		\
-	COND_POP(set, CLBR_R8, r8);		\
-	COND_POP(set, CLBR_RDI, rdi);		\
-	COND_POP(set, CLBR_RSI, rsi);		\
-	COND_POP(set, CLBR_RDX, rdx);		\
-	COND_POP(set, CLBR_RCX, rcx);		\
-	COND_POP(set, CLBR_RAX, rax)
-
 #define PARA_PATCH(off)		((off) / 8)
 #define PARA_SITE(ptype, ops)	_PVSITE(ptype, ops, .quad, 8)
 #define PARA_INDIRECT(addr)	*addr(%rip)
@@ -752,12 +749,14 @@ extern void default_banner(void);
 		X86_FEATURE_XENPV, "jmp xen_iret;", "jmp native_iret;")
 
 #ifdef CONFIG_DEBUG_ENTRY
-#define SAVE_FLAGS(clobbers)                                        \
-	PARA_SITE(PARA_PATCH(PV_IRQ_save_fl),			    \
-		  PV_SAVE_REGS(clobbers | CLBR_CALLEE_SAVE);        \
-		  ANNOTATE_RETPOLINE_SAFE;			    \
-		  call PARA_INDIRECT(pv_ops+PV_IRQ_save_fl);	    \
-		  PV_RESTORE_REGS(clobbers | CLBR_CALLEE_SAVE);)
+.macro PARA_IRQ_save_fl
+	PARA_SITE(PARA_PATCH(PV_IRQ_save_fl),
+		  ANNOTATE_RETPOLINE_SAFE;
+		  call PARA_INDIRECT(pv_ops+PV_IRQ_save_fl);)
+.endm
+
+#define SAVE_FLAGS	ALTERNATIVE "PARA_IRQ_save_fl;", "pushf; pop %rax;", \
+				    ALT_NOT(X86_FEATURE_XENPV)
 #endif
 #endif /* CONFIG_PARAVIRT_XXL */
 #endif	/* CONFIG_X86_64 */
diff --git a/arch/x86/include/asm/paravirt_types.h b/arch/x86/include/asm/paravirt_types.h
index 0ed9762..588ff14 100644
--- a/arch/x86/include/asm/paravirt_types.h
+++ b/arch/x86/include/asm/paravirt_types.h
@@ -3,7 +3,6 @@
 #define _ASM_X86_PARAVIRT_TYPES_H
 
 /* Bitmask of what can be clobbered: usually at least eax. */
-#define CLBR_NONE 0
 #define CLBR_EAX  (1 << 0)
 #define CLBR_ECX  (1 << 1)
 #define CLBR_EDX  (1 << 2)
@@ -15,7 +14,6 @@
 
 #define CLBR_ARG_REGS	(CLBR_EAX | CLBR_EDX | CLBR_ECX)
 #define CLBR_RET_REG	(CLBR_EAX | CLBR_EDX)
-#define CLBR_SCRATCH	(0)
 #else
 #define CLBR_RAX  CLBR_EAX
 #define CLBR_RCX  CLBR_ECX
@@ -32,12 +30,9 @@
 #define CLBR_ARG_REGS	(CLBR_RDI | CLBR_RSI | CLBR_RDX | \
 			 CLBR_RCX | CLBR_R8 | CLBR_R9)
 #define CLBR_RET_REG	(CLBR_RAX)
-#define CLBR_SCRATCH	(CLBR_R10 | CLBR_R11)
 
 #endif /* X86_64 */
 
-#define CLBR_CALLEE_SAVE ((CLBR_ARG_REGS | CLBR_SCRATCH) & ~CLBR_RET_REG)
-
 #ifndef __ASSEMBLY__
 
 #include <asm/desc_defs.h>
@@ -322,7 +317,6 @@ extern void (*paravirt_iret)(void);
 /* Simple instruction patching code. */
 #define NATIVE_LABEL(a,x,b) "\n\t.globl " a #x "_" #b "\n" a #x "_" #b ":\n\t"
 
-unsigned paravirt_patch_ident_64(void *insn_buff, unsigned len);
 unsigned paravirt_patch_default(u8 type, void *insn_buff, unsigned long addr, unsigned len);
 unsigned paravirt_patch_insns(void *insn_buff, unsigned len, const char *start, const char *end);
 
diff --git a/arch/x86/kernel/paravirt.c b/arch/x86/kernel/paravirt.c
index 9b0f568..855ae08 100644
--- a/arch/x86/kernel/paravirt.c
+++ b/arch/x86/kernel/paravirt.c
@@ -53,7 +53,10 @@ void __init default_banner(void)
 }
 
 /* Undefined instruction for dealing with missing ops pointers. */
-static const unsigned char ud2a[] = { 0x0f, 0x0b };
+static void paravirt_BUG(void)
+{
+	BUG();
+}
 
 struct branch {
 	unsigned char opcode;
@@ -107,17 +110,10 @@ unsigned paravirt_patch_default(u8 type, void *insn_buff,
 	unsigned ret;
 
 	if (opfunc == NULL)
-		/* If there's no function, patch it with a ud2a (BUG) */
-		ret = paravirt_patch_insns(insn_buff, len, ud2a, ud2a+sizeof(ud2a));
+		/* If there's no function, patch it with paravirt_BUG() */
+		ret = paravirt_patch_call(insn_buff, paravirt_BUG, addr, len);
 	else if (opfunc == _paravirt_nop)
 		ret = 0;
-
-#ifdef CONFIG_PARAVIRT_XXL
-	/* identity functions just return their single argument */
-	else if (opfunc == _paravirt_ident_64)
-		ret = paravirt_patch_ident_64(insn_buff, len);
-
-#endif
 	else
 		/* Otherwise call the function. */
 		ret = paravirt_patch_call(insn_buff, opfunc, addr, len);
diff --git a/arch/x86/kernel/paravirt_patch.c b/arch/x86/kernel/paravirt_patch.c
index abd27ec..10543dc 100644
--- a/arch/x86/kernel/paravirt_patch.c
+++ b/arch/x86/kernel/paravirt_patch.c
@@ -4,96 +4,8 @@
 #include <asm/paravirt.h>
 #include <asm/asm-offsets.h>
 
-#define PSTART(d, m)							\
-	patch_data_##d.m
-
-#define PEND(d, m)							\
-	(PSTART(d, m) + sizeof(patch_data_##d.m))
-
-#define PATCH(d, m, insn_buff, len)						\
-	paravirt_patch_insns(insn_buff, len, PSTART(d, m), PEND(d, m))
-
-#define PATCH_CASE(ops, m, data, insn_buff, len)				\
-	case PARAVIRT_PATCH(ops.m):					\
-		return PATCH(data, ops##_##m, insn_buff, len)
-
-#ifdef CONFIG_PARAVIRT_XXL
-struct patch_xxl {
-	const unsigned char	irq_irq_disable[1];
-	const unsigned char	irq_irq_enable[1];
-	const unsigned char	irq_save_fl[2];
-	const unsigned char	mmu_read_cr2[3];
-	const unsigned char	mmu_read_cr3[3];
-	const unsigned char	mmu_write_cr3[3];
-	const unsigned char	cpu_wbinvd[2];
-	const unsigned char	mov64[3];
-};
-
-static const struct patch_xxl patch_data_xxl = {
-	.irq_irq_disable	= { 0xfa },		// cli
-	.irq_irq_enable		= { 0xfb },		// sti
-	.irq_save_fl		= { 0x9c, 0x58 },	// pushf; pop %[re]ax
-	.mmu_read_cr2		= { 0x0f, 0x20, 0xd0 },	// mov %cr2, %[re]ax
-	.mmu_read_cr3		= { 0x0f, 0x20, 0xd8 },	// mov %cr3, %[re]ax
-	.mmu_write_cr3		= { 0x0f, 0x22, 0xdf },	// mov %rdi, %cr3
-	.cpu_wbinvd		= { 0x0f, 0x09 },	// wbinvd
-	.mov64			= { 0x48, 0x89, 0xf8 },	// mov %rdi, %rax
-};
-
-unsigned int paravirt_patch_ident_64(void *insn_buff, unsigned int len)
-{
-	return PATCH(xxl, mov64, insn_buff, len);
-}
-# endif /* CONFIG_PARAVIRT_XXL */
-
-#ifdef CONFIG_PARAVIRT_SPINLOCKS
-struct patch_lock {
-	unsigned char queued_spin_unlock[3];
-	unsigned char vcpu_is_preempted[2];
-};
-
-static const struct patch_lock patch_data_lock = {
-	.vcpu_is_preempted	= { 0x31, 0xc0 },	// xor %eax, %eax
-
-# ifdef CONFIG_X86_64
-	.queued_spin_unlock	= { 0xc6, 0x07, 0x00 },	// movb $0, (%rdi)
-# else
-	.queued_spin_unlock	= { 0xc6, 0x00, 0x00 },	// movb $0, (%eax)
-# endif
-};
-#endif /* CONFIG_PARAVIRT_SPINLOCKS */
-
 unsigned int native_patch(u8 type, void *insn_buff, unsigned long addr,
 			  unsigned int len)
 {
-	switch (type) {
-
-#ifdef CONFIG_PARAVIRT_XXL
-	PATCH_CASE(irq, save_fl, xxl, insn_buff, len);
-	PATCH_CASE(irq, irq_enable, xxl, insn_buff, len);
-	PATCH_CASE(irq, irq_disable, xxl, insn_buff, len);
-
-	PATCH_CASE(mmu, read_cr2, xxl, insn_buff, len);
-	PATCH_CASE(mmu, read_cr3, xxl, insn_buff, len);
-	PATCH_CASE(mmu, write_cr3, xxl, insn_buff, len);
-
-	PATCH_CASE(cpu, wbinvd, xxl, insn_buff, len);
-#endif
-
-#ifdef CONFIG_PARAVIRT_SPINLOCKS
-	case PARAVIRT_PATCH(lock.queued_spin_unlock):
-		if (pv_is_native_spin_unlock())
-			return PATCH(lock, queued_spin_unlock, insn_buff, len);
-		break;
-
-	case PARAVIRT_PATCH(lock.vcpu_is_preempted):
-		if (pv_is_native_vcpu_is_preempted())
-			return PATCH(lock, vcpu_is_preempted, insn_buff, len);
-		break;
-#endif
-	default:
-		break;
-	}
-
 	return paravirt_patch_default(type, insn_buff, addr, len);
 }
