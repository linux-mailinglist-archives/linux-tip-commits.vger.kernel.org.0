Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33D8A40B7D9
	for <lists+linux-tip-commits@lfdr.de>; Tue, 14 Sep 2021 21:20:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233321AbhINTU6 (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Tue, 14 Sep 2021 15:20:58 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:35404 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232667AbhINTUy (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Tue, 14 Sep 2021 15:20:54 -0400
Date:   Tue, 14 Sep 2021 19:19:34 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1631647175;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RpB70TsVSYfh+pFE6DcRyIhBhbZx38j7i8Eu/cVM0T8=;
        b=dz3j4BSYBfAD8Hib6lqtbiPa5ZkkQ6hoQILqnoo1f5m16a1mLJlOl4TNcbZn3MlSNho1zR
        bPlwdv3788THY4NWKoesM36CF+yO+pFagvfVhcbIbucvunjMWZ3Xc4C1pRyUZwPSe6Qxr9
        Sv/SfzZ7FxcW2gAkcjlyKYT6RBKWYVq/6bLWduUSBo1qflIs4FToSJwjYlBdTBHgaEESAt
        HUmZ9yXDqrc/8gbfOxzyJ7HG2RQVSkmTKxu80B0ShIPD1dQjZvQ7+TH04nI9e9AtOsrRqS
        /4cErz5xaAJo4KayEgSVCnPoEafui4sLvCbld1Nqwe2JDVvxG8tXDsxsVhTERg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1631647175;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RpB70TsVSYfh+pFE6DcRyIhBhbZx38j7i8Eu/cVM0T8=;
        b=LwjTZXnib35HRm3SLXqfpO3fVO1Bo67UxiKiuMzbFv4Fm/60fP+8smX+WEEo1fnVSfonF/
        Qqg3fV9AjJjYNEAg==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/fpu] x86/extable: Rework the exception table mechanics
Cc:     Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@suse.de>,
        Alexei Starovoitov <ast@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210908132525.211958725@linutronix.de>
References: <20210908132525.211958725@linutronix.de>
MIME-Version: 1.0
Message-ID: <163164717479.25758.9861739530282563188.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/fpu branch of tip:

Commit-ID:     46d28947d9876fc0f8f93d3c69813ef6e9852595
Gitweb:        https://git.kernel.org/tip/46d28947d9876fc0f8f93d3c69813ef6e9852595
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Wed, 08 Sep 2021 15:29:18 +02:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Mon, 13 Sep 2021 17:51:47 +02:00

x86/extable: Rework the exception table mechanics

The exception table entries contain the instruction address, the fixup
address and the handler address. All addresses are relative. Storing the
handler address has a few downsides:

 1) Most handlers need to be exported

 2) Handlers can be defined everywhere and there is no overview about the
    handler types

 3) MCE needs to check the handler type to decide whether an in kernel #MC
    can be recovered. The functionality of the handler itself is not in any
    way special, but for these checks there need to be separate functions
    which in the worst case have to be exported.

    Some of these 'recoverable' exception fixups are pretty obscure and
    just reuse some other handler to spare code. That obfuscates e.g. the
    #MC safe copy functions. Cleaning that up would require more handlers
    and exports

Rework the exception fixup mechanics by storing a fixup type number instead
of the handler address and invoke the proper handler for each fixup
type. Also teach the extable sort to leave the type field alone.

This makes most handlers static except for special cases like the MCE
MSR fixup and the BPF fixup. This allows to add more types for cleaning up
the obscure places without adding more handler code and exports.

There is a marginal code size reduction for a production config and it
removes _eight_ exported symbols.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Borislav Petkov <bp@suse.de>
Acked-by: Alexei Starovoitov <ast@kernel.org>
Link: https://lkml.kernel.org/r/20210908132525.211958725@linutronix.de
---
 arch/x86/include/asm/asm.h                 |  22 ++--
 arch/x86/include/asm/extable.h             |  44 ++++---
 arch/x86/include/asm/extable_fixup_types.h |  19 +++-
 arch/x86/include/asm/fpu/internal.h        |   4 +-
 arch/x86/include/asm/msr.h                 |   4 +-
 arch/x86/include/asm/segment.h             |   2 +-
 arch/x86/kernel/cpu/mce/core.c             |  24 +----
 arch/x86/kernel/cpu/mce/internal.h         |  10 +--
 arch/x86/kernel/cpu/mce/severity.c         |  21 +--
 arch/x86/mm/extable.c                      | 123 ++++++++------------
 arch/x86/net/bpf_jit_comp.c                |  11 +--
 scripts/sorttable.c                        |   4 +-
 12 files changed, 133 insertions(+), 155 deletions(-)
 create mode 100644 arch/x86/include/asm/extable_fixup_types.h

diff --git a/arch/x86/include/asm/asm.h b/arch/x86/include/asm/asm.h
index 719955e..6aadb9a 100644
--- a/arch/x86/include/asm/asm.h
+++ b/arch/x86/include/asm/asm.h
@@ -122,14 +122,17 @@
 
 #ifdef __KERNEL__
 
+# include <asm/extable_fixup_types.h>
+
 /* Exception table entry */
 #ifdef __ASSEMBLY__
-# define _ASM_EXTABLE_HANDLE(from, to, handler)			\
+
+# define _ASM_EXTABLE_TYPE(from, to, type)			\
 	.pushsection "__ex_table","a" ;				\
 	.balign 4 ;						\
 	.long (from) - . ;					\
 	.long (to) - . ;					\
-	.long (handler) - . ;					\
+	.long type ;						\
 	.popsection
 
 # ifdef CONFIG_KPROBES
@@ -143,13 +146,13 @@
 # endif
 
 #else /* ! __ASSEMBLY__ */
-# define _EXPAND_EXTABLE_HANDLE(x) #x
-# define _ASM_EXTABLE_HANDLE(from, to, handler)			\
+
+# define _ASM_EXTABLE_TYPE(from, to, type)			\
 	" .pushsection \"__ex_table\",\"a\"\n"			\
 	" .balign 4\n"						\
 	" .long (" #from ") - .\n"				\
 	" .long (" #to ") - .\n"				\
-	" .long (" _EXPAND_EXTABLE_HANDLE(handler) ") - .\n"	\
+	" .long " __stringify(type) " \n"			\
 	" .popsection\n"
 
 /* For C file, we already have NOKPROBE_SYMBOL macro */
@@ -165,17 +168,16 @@ register unsigned long current_stack_pointer asm(_ASM_SP);
 #endif /* __ASSEMBLY__ */
 
 #define _ASM_EXTABLE(from, to)					\
-	_ASM_EXTABLE_HANDLE(from, to, ex_handler_default)
+	_ASM_EXTABLE_TYPE(from, to, EX_TYPE_DEFAULT)
 
 #define _ASM_EXTABLE_UA(from, to)				\
-	_ASM_EXTABLE_HANDLE(from, to, ex_handler_uaccess)
+	_ASM_EXTABLE_TYPE(from, to, EX_TYPE_UACCESS)
 
 #define _ASM_EXTABLE_CPY(from, to)				\
-	_ASM_EXTABLE_HANDLE(from, to, ex_handler_copy)
+	_ASM_EXTABLE_TYPE(from, to, EX_TYPE_COPY)
 
 #define _ASM_EXTABLE_FAULT(from, to)				\
-	_ASM_EXTABLE_HANDLE(from, to, ex_handler_fault)
+	_ASM_EXTABLE_TYPE(from, to, EX_TYPE_FAULT)
 
 #endif /* __KERNEL__ */
-
 #endif /* _ASM_X86_ASM_H */
diff --git a/arch/x86/include/asm/extable.h b/arch/x86/include/asm/extable.h
index 1f0cbc5..93f400e 100644
--- a/arch/x86/include/asm/extable.h
+++ b/arch/x86/include/asm/extable.h
@@ -1,12 +1,18 @@
 /* SPDX-License-Identifier: GPL-2.0 */
 #ifndef _ASM_X86_EXTABLE_H
 #define _ASM_X86_EXTABLE_H
+
+#include <asm/extable_fixup_types.h>
+
 /*
- * The exception table consists of triples of addresses relative to the
- * exception table entry itself. The first address is of an instruction
- * that is allowed to fault, the second is the target at which the program
- * should continue. The third is a handler function to deal with the fault
- * caused by the instruction in the first field.
+ * The exception table consists of two addresses relative to the
+ * exception table entry itself and a type selector field.
+ *
+ * The first address is of an instruction that is allowed to fault, the
+ * second is the target at which the program should continue.
+ *
+ * The type entry is used by fixup_exception() to select the handler to
+ * deal with the fault caused by the instruction in the first field.
  *
  * All the routines below use bits of fixup code that are out of line
  * with the main instruction path.  This means when everything is well,
@@ -15,7 +21,7 @@
  */
 
 struct exception_table_entry {
-	int insn, fixup, handler;
+	int insn, fixup, type;
 };
 struct pt_regs;
 
@@ -25,21 +31,27 @@ struct pt_regs;
 	do {							\
 		(a)->fixup = (b)->fixup + (delta);		\
 		(b)->fixup = (tmp).fixup - (delta);		\
-		(a)->handler = (b)->handler + (delta);		\
-		(b)->handler = (tmp).handler - (delta);		\
+		(a)->type = (b)->type;				\
+		(b)->type = (tmp).type;				\
 	} while (0)
 
-enum handler_type {
-	EX_HANDLER_NONE,
-	EX_HANDLER_FAULT,
-	EX_HANDLER_UACCESS,
-	EX_HANDLER_OTHER
-};
-
 extern int fixup_exception(struct pt_regs *regs, int trapnr,
 			   unsigned long error_code, unsigned long fault_addr);
 extern int fixup_bug(struct pt_regs *regs, int trapnr);
-extern enum handler_type ex_get_fault_handler_type(unsigned long ip);
+extern int ex_get_fixup_type(unsigned long ip);
 extern void early_fixup_exception(struct pt_regs *regs, int trapnr);
 
+#ifdef CONFIG_X86_MCE
+extern void ex_handler_msr_mce(struct pt_regs *regs, bool wrmsr);
+#else
+static inline void ex_handler_msr_mce(struct pt_regs *regs, bool wrmsr) { }
+#endif
+
+#if defined(CONFIG_BPF_JIT) && defined(CONFIG_X86_64)
+bool ex_handler_bpf(const struct exception_table_entry *x, struct pt_regs *regs);
+#else
+static inline bool ex_handler_bpf(const struct exception_table_entry *x,
+				  struct pt_regs *regs) { return false; }
+#endif
+
 #endif
diff --git a/arch/x86/include/asm/extable_fixup_types.h b/arch/x86/include/asm/extable_fixup_types.h
new file mode 100644
index 0000000..0adc117
--- /dev/null
+++ b/arch/x86/include/asm/extable_fixup_types.h
@@ -0,0 +1,19 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _ASM_X86_EXTABLE_FIXUP_TYPES_H
+#define _ASM_X86_EXTABLE_FIXUP_TYPES_H
+
+#define	EX_TYPE_NONE			 0
+#define	EX_TYPE_DEFAULT			 1
+#define	EX_TYPE_FAULT			 2
+#define	EX_TYPE_UACCESS			 3
+#define	EX_TYPE_COPY			 4
+#define	EX_TYPE_CLEAR_FS		 5
+#define	EX_TYPE_FPU_RESTORE		 6
+#define	EX_TYPE_WRMSR			 7
+#define	EX_TYPE_RDMSR			 8
+#define	EX_TYPE_BPF			 9
+
+#define	EX_TYPE_WRMSR_IN_MCE		10
+#define	EX_TYPE_RDMSR_IN_MCE		11
+
+#endif
diff --git a/arch/x86/include/asm/fpu/internal.h b/arch/x86/include/asm/fpu/internal.h
index 5a18694..ce6fc4f 100644
--- a/arch/x86/include/asm/fpu/internal.h
+++ b/arch/x86/include/asm/fpu/internal.h
@@ -126,7 +126,7 @@ extern void save_fpregs_to_fpstate(struct fpu *fpu);
 #define kernel_insn(insn, output, input...)				\
 	asm volatile("1:" #insn "\n\t"					\
 		     "2:\n"						\
-		     _ASM_EXTABLE_HANDLE(1b, 2b, ex_handler_fprestore)	\
+		     _ASM_EXTABLE_TYPE(1b, 2b, EX_TYPE_FPU_RESTORE)	\
 		     : output : input)
 
 static inline int fnsave_to_user_sigframe(struct fregs_state __user *fx)
@@ -253,7 +253,7 @@ static inline void fxsave(struct fxregs_state *fx)
 				 XRSTORS, X86_FEATURE_XSAVES)		\
 		     "\n"						\
 		     "3:\n"						\
-		     _ASM_EXTABLE_HANDLE(661b, 3b, ex_handler_fprestore)\
+		     _ASM_EXTABLE_TYPE(661b, 3b, EX_TYPE_FPU_RESTORE)	\
 		     :							\
 		     : "D" (st), "m" (*st), "a" (lmask), "d" (hmask)	\
 		     : "memory")
diff --git a/arch/x86/include/asm/msr.h b/arch/x86/include/asm/msr.h
index a3f87f1..6b52182 100644
--- a/arch/x86/include/asm/msr.h
+++ b/arch/x86/include/asm/msr.h
@@ -92,7 +92,7 @@ static __always_inline unsigned long long __rdmsr(unsigned int msr)
 
 	asm volatile("1: rdmsr\n"
 		     "2:\n"
-		     _ASM_EXTABLE_HANDLE(1b, 2b, ex_handler_rdmsr_unsafe)
+		     _ASM_EXTABLE_TYPE(1b, 2b, EX_TYPE_RDMSR)
 		     : EAX_EDX_RET(val, low, high) : "c" (msr));
 
 	return EAX_EDX_VAL(val, low, high);
@@ -102,7 +102,7 @@ static __always_inline void __wrmsr(unsigned int msr, u32 low, u32 high)
 {
 	asm volatile("1: wrmsr\n"
 		     "2:\n"
-		     _ASM_EXTABLE_HANDLE(1b, 2b, ex_handler_wrmsr_unsafe)
+		     _ASM_EXTABLE_TYPE(1b, 2b, EX_TYPE_WRMSR)
 		     : : "c" (msr), "a"(low), "d" (high) : "memory");
 }
 
diff --git a/arch/x86/include/asm/segment.h b/arch/x86/include/asm/segment.h
index 7204402..8dd8e8e 100644
--- a/arch/x86/include/asm/segment.h
+++ b/arch/x86/include/asm/segment.h
@@ -339,7 +339,7 @@ static inline void __loadsegment_fs(unsigned short value)
 		     "1:	movw %0, %%fs			\n"
 		     "2:					\n"
 
-		     _ASM_EXTABLE_HANDLE(1b, 2b, ex_handler_clear_fs)
+		     _ASM_EXTABLE_TYPE(1b, 2b, EX_TYPE_CLEAR_FS)
 
 		     : : "rm" (value) : "memory");
 }
diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
index 428eed9..cd919fc 100644
--- a/arch/x86/kernel/cpu/mce/core.c
+++ b/arch/x86/kernel/cpu/mce/core.c
@@ -373,7 +373,7 @@ static int msr_to_offset(u32 msr)
 	return -1;
 }
 
-static void ex_handler_msr_mce(struct pt_regs *regs, bool wrmsr)
+void ex_handler_msr_mce(struct pt_regs *regs, bool wrmsr)
 {
 	if (wrmsr) {
 		pr_emerg("MSR access error: WRMSR to 0x%x (tried to write 0x%08x%08x) at rIP: 0x%lx (%pS)\n",
@@ -392,15 +392,6 @@ static void ex_handler_msr_mce(struct pt_regs *regs, bool wrmsr)
 		cpu_relax();
 }
 
-__visible bool ex_handler_rdmsr_fault(const struct exception_table_entry *fixup,
-				      struct pt_regs *regs, int trapnr,
-				      unsigned long error_code,
-				      unsigned long fault_addr)
-{
-	ex_handler_msr_mce(regs, false);
-	return true;
-}
-
 /* MSR access wrappers used for error injection */
 static noinstr u64 mce_rdmsrl(u32 msr)
 {
@@ -430,22 +421,13 @@ static noinstr u64 mce_rdmsrl(u32 msr)
 	 */
 	asm volatile("1: rdmsr\n"
 		     "2:\n"
-		     _ASM_EXTABLE_HANDLE(1b, 2b, ex_handler_rdmsr_fault)
+		     _ASM_EXTABLE_TYPE(1b, 2b, EX_TYPE_RDMSR_IN_MCE)
 		     : EAX_EDX_RET(val, low, high) : "c" (msr));
 
 
 	return EAX_EDX_VAL(val, low, high);
 }
 
-__visible bool ex_handler_wrmsr_fault(const struct exception_table_entry *fixup,
-				      struct pt_regs *regs, int trapnr,
-				      unsigned long error_code,
-				      unsigned long fault_addr)
-{
-	ex_handler_msr_mce(regs, true);
-	return true;
-}
-
 static noinstr void mce_wrmsrl(u32 msr, u64 v)
 {
 	u32 low, high;
@@ -470,7 +452,7 @@ static noinstr void mce_wrmsrl(u32 msr, u64 v)
 	/* See comment in mce_rdmsrl() */
 	asm volatile("1: wrmsr\n"
 		     "2:\n"
-		     _ASM_EXTABLE_HANDLE(1b, 2b, ex_handler_wrmsr_fault)
+		     _ASM_EXTABLE_TYPE(1b, 2b, EX_TYPE_WRMSR_IN_MCE)
 		     : : "c" (msr), "a"(low), "d" (high) : "memory");
 }
 
diff --git a/arch/x86/kernel/cpu/mce/internal.h b/arch/x86/kernel/cpu/mce/internal.h
index 9509922..3463f8c 100644
--- a/arch/x86/kernel/cpu/mce/internal.h
+++ b/arch/x86/kernel/cpu/mce/internal.h
@@ -186,14 +186,4 @@ extern bool amd_filter_mce(struct mce *m);
 static inline bool amd_filter_mce(struct mce *m) { return false; }
 #endif
 
-__visible bool ex_handler_rdmsr_fault(const struct exception_table_entry *fixup,
-				      struct pt_regs *regs, int trapnr,
-				      unsigned long error_code,
-				      unsigned long fault_addr);
-
-__visible bool ex_handler_wrmsr_fault(const struct exception_table_entry *fixup,
-				      struct pt_regs *regs, int trapnr,
-				      unsigned long error_code,
-				      unsigned long fault_addr);
-
 #endif /* __X86_MCE_INTERNAL_H__ */
diff --git a/arch/x86/kernel/cpu/mce/severity.c b/arch/x86/kernel/cpu/mce/severity.c
index 17e6314..74fe763 100644
--- a/arch/x86/kernel/cpu/mce/severity.c
+++ b/arch/x86/kernel/cpu/mce/severity.c
@@ -265,25 +265,24 @@ static bool is_copy_from_user(struct pt_regs *regs)
  */
 static int error_context(struct mce *m, struct pt_regs *regs)
 {
-	enum handler_type t;
-
 	if ((m->cs & 3) == 3)
 		return IN_USER;
 	if (!mc_recoverable(m->mcgstatus))
 		return IN_KERNEL;
 
-	t = ex_get_fault_handler_type(m->ip);
-	if (t == EX_HANDLER_FAULT) {
-		m->kflags |= MCE_IN_KERNEL_RECOV;
-		return IN_KERNEL_RECOV;
-	}
-	if (t == EX_HANDLER_UACCESS && regs && is_copy_from_user(regs)) {
-		m->kflags |= MCE_IN_KERNEL_RECOV;
+	switch (ex_get_fixup_type(m->ip)) {
+	case EX_TYPE_UACCESS:
+	case EX_TYPE_COPY:
+		if (!regs || !is_copy_from_user(regs))
+			return IN_KERNEL;
 		m->kflags |= MCE_IN_KERNEL_COPYIN;
+		fallthrough;
+	case EX_TYPE_FAULT:
+		m->kflags |= MCE_IN_KERNEL_RECOV;
 		return IN_KERNEL_RECOV;
+	default:
+		return IN_KERNEL;
 	}
-
-	return IN_KERNEL;
 }
 
 static int mce_severity_amd_smca(struct mce *m, enum context err_ctx)
diff --git a/arch/x86/mm/extable.c b/arch/x86/mm/extable.c
index d9a1046..5db46df 100644
--- a/arch/x86/mm/extable.c
+++ b/arch/x86/mm/extable.c
@@ -9,40 +9,25 @@
 #include <asm/traps.h>
 #include <asm/kdebug.h>
 
-typedef bool (*ex_handler_t)(const struct exception_table_entry *,
-			    struct pt_regs *, int, unsigned long,
-			    unsigned long);
-
 static inline unsigned long
 ex_fixup_addr(const struct exception_table_entry *x)
 {
 	return (unsigned long)&x->fixup + x->fixup;
 }
-static inline ex_handler_t
-ex_fixup_handler(const struct exception_table_entry *x)
-{
-	return (ex_handler_t)((unsigned long)&x->handler + x->handler);
-}
 
-__visible bool ex_handler_default(const struct exception_table_entry *fixup,
-				  struct pt_regs *regs, int trapnr,
-				  unsigned long error_code,
-				  unsigned long fault_addr)
+static bool ex_handler_default(const struct exception_table_entry *fixup,
+			       struct pt_regs *regs)
 {
 	regs->ip = ex_fixup_addr(fixup);
 	return true;
 }
-EXPORT_SYMBOL(ex_handler_default);
 
-__visible bool ex_handler_fault(const struct exception_table_entry *fixup,
-				struct pt_regs *regs, int trapnr,
-				unsigned long error_code,
-				unsigned long fault_addr)
+static bool ex_handler_fault(const struct exception_table_entry *fixup,
+			     struct pt_regs *regs, int trapnr)
 {
 	regs->ax = trapnr;
-	return ex_handler_default(fixup, regs, trapnr, error_code, fault_addr);
+	return ex_handler_default(fixup, regs);
 }
-EXPORT_SYMBOL_GPL(ex_handler_fault);
 
 /*
  * Handler for when we fail to restore a task's FPU state.  We should never get
@@ -54,10 +39,8 @@ EXPORT_SYMBOL_GPL(ex_handler_fault);
  * of vulnerability by restoring from the initial state (essentially, zeroing
  * out all the FPU registers) if we can't restore from the task's FPU state.
  */
-__visible bool ex_handler_fprestore(const struct exception_table_entry *fixup,
-				    struct pt_regs *regs, int trapnr,
-				    unsigned long error_code,
-				    unsigned long fault_addr)
+static bool ex_handler_fprestore(const struct exception_table_entry *fixup,
+				 struct pt_regs *regs)
 {
 	regs->ip = ex_fixup_addr(fixup);
 
@@ -67,32 +50,23 @@ __visible bool ex_handler_fprestore(const struct exception_table_entry *fixup,
 	__restore_fpregs_from_fpstate(&init_fpstate, xfeatures_mask_fpstate());
 	return true;
 }
-EXPORT_SYMBOL_GPL(ex_handler_fprestore);
 
-__visible bool ex_handler_uaccess(const struct exception_table_entry *fixup,
-				  struct pt_regs *regs, int trapnr,
-				  unsigned long error_code,
-				  unsigned long fault_addr)
+static bool ex_handler_uaccess(const struct exception_table_entry *fixup,
+			       struct pt_regs *regs, int trapnr)
 {
 	WARN_ONCE(trapnr == X86_TRAP_GP, "General protection fault in user access. Non-canonical address?");
-	return ex_handler_default(fixup, regs, trapnr, error_code, fault_addr);
+	return ex_handler_default(fixup, regs);
 }
-EXPORT_SYMBOL(ex_handler_uaccess);
 
-__visible bool ex_handler_copy(const struct exception_table_entry *fixup,
-			       struct pt_regs *regs, int trapnr,
-			       unsigned long error_code,
-			       unsigned long fault_addr)
+static bool ex_handler_copy(const struct exception_table_entry *fixup,
+			    struct pt_regs *regs, int trapnr)
 {
 	WARN_ONCE(trapnr == X86_TRAP_GP, "General protection fault in user access. Non-canonical address?");
-	return ex_handler_fault(fixup, regs, trapnr, error_code, fault_addr);
+	return ex_handler_fault(fixup, regs, trapnr);
 }
-EXPORT_SYMBOL(ex_handler_copy);
 
-__visible bool ex_handler_rdmsr_unsafe(const struct exception_table_entry *fixup,
-				       struct pt_regs *regs, int trapnr,
-				       unsigned long error_code,
-				       unsigned long fault_addr)
+static bool ex_handler_rdmsr_unsafe(const struct exception_table_entry *fixup,
+				    struct pt_regs *regs)
 {
 	if (pr_warn_once("unchecked MSR access error: RDMSR from 0x%x at rIP: 0x%lx (%pS)\n",
 			 (unsigned int)regs->cx, regs->ip, (void *)regs->ip))
@@ -101,14 +75,11 @@ __visible bool ex_handler_rdmsr_unsafe(const struct exception_table_entry *fixup
 	/* Pretend that the read succeeded and returned 0. */
 	regs->ax = 0;
 	regs->dx = 0;
-	return ex_handler_default(fixup, regs, trapnr, error_code, fault_addr);
+	return ex_handler_default(fixup, regs);
 }
-EXPORT_SYMBOL(ex_handler_rdmsr_unsafe);
 
-__visible bool ex_handler_wrmsr_unsafe(const struct exception_table_entry *fixup,
-				       struct pt_regs *regs, int trapnr,
-				       unsigned long error_code,
-				       unsigned long fault_addr)
+static bool ex_handler_wrmsr_unsafe(const struct exception_table_entry *fixup,
+				    struct pt_regs *regs)
 {
 	if (pr_warn_once("unchecked MSR access error: WRMSR to 0x%x (tried to write 0x%08x%08x) at rIP: 0x%lx (%pS)\n",
 			 (unsigned int)regs->cx, (unsigned int)regs->dx,
@@ -116,44 +87,29 @@ __visible bool ex_handler_wrmsr_unsafe(const struct exception_table_entry *fixup
 		show_stack_regs(regs);
 
 	/* Pretend that the write succeeded. */
-	return ex_handler_default(fixup, regs, trapnr, error_code, fault_addr);
+	return ex_handler_default(fixup, regs);
 }
-EXPORT_SYMBOL(ex_handler_wrmsr_unsafe);
 
-__visible bool ex_handler_clear_fs(const struct exception_table_entry *fixup,
-				   struct pt_regs *regs, int trapnr,
-				   unsigned long error_code,
-				   unsigned long fault_addr)
+static bool ex_handler_clear_fs(const struct exception_table_entry *fixup,
+				struct pt_regs *regs)
 {
 	if (static_cpu_has(X86_BUG_NULL_SEG))
 		asm volatile ("mov %0, %%fs" : : "rm" (__USER_DS));
 	asm volatile ("mov %0, %%fs" : : "rm" (0));
-	return ex_handler_default(fixup, regs, trapnr, error_code, fault_addr);
+	return ex_handler_default(fixup, regs);
 }
-EXPORT_SYMBOL(ex_handler_clear_fs);
 
-enum handler_type ex_get_fault_handler_type(unsigned long ip)
+int ex_get_fixup_type(unsigned long ip)
 {
-	const struct exception_table_entry *e;
-	ex_handler_t handler;
+	const struct exception_table_entry *e = search_exception_tables(ip);
 
-	e = search_exception_tables(ip);
-	if (!e)
-		return EX_HANDLER_NONE;
-	handler = ex_fixup_handler(e);
-	if (handler == ex_handler_fault)
-		return EX_HANDLER_FAULT;
-	else if (handler == ex_handler_uaccess || handler == ex_handler_copy)
-		return EX_HANDLER_UACCESS;
-	else
-		return EX_HANDLER_OTHER;
+	return e ? e->type : EX_TYPE_NONE;
 }
 
 int fixup_exception(struct pt_regs *regs, int trapnr, unsigned long error_code,
 		    unsigned long fault_addr)
 {
 	const struct exception_table_entry *e;
-	ex_handler_t handler;
 
 #ifdef CONFIG_PNPBIOS
 	if (unlikely(SEGMENT_IS_PNP_CODE(regs->cs))) {
@@ -173,8 +129,33 @@ int fixup_exception(struct pt_regs *regs, int trapnr, unsigned long error_code,
 	if (!e)
 		return 0;
 
-	handler = ex_fixup_handler(e);
-	return handler(e, regs, trapnr, error_code, fault_addr);
+	switch (e->type) {
+	case EX_TYPE_DEFAULT:
+		return ex_handler_default(e, regs);
+	case EX_TYPE_FAULT:
+		return ex_handler_fault(e, regs, trapnr);
+	case EX_TYPE_UACCESS:
+		return ex_handler_uaccess(e, regs, trapnr);
+	case EX_TYPE_COPY:
+		return ex_handler_copy(e, regs, trapnr);
+	case EX_TYPE_CLEAR_FS:
+		return ex_handler_clear_fs(e, regs);
+	case EX_TYPE_FPU_RESTORE:
+		return ex_handler_fprestore(e, regs);
+	case EX_TYPE_RDMSR:
+		return ex_handler_rdmsr_unsafe(e, regs);
+	case EX_TYPE_WRMSR:
+		return ex_handler_wrmsr_unsafe(e, regs);
+	case EX_TYPE_BPF:
+		return ex_handler_bpf(e, regs);
+	case EX_TYPE_RDMSR_IN_MCE:
+		ex_handler_msr_mce(regs, false);
+		break;
+	case EX_TYPE_WRMSR_IN_MCE:
+		ex_handler_msr_mce(regs, true);
+		break;
+	}
+	BUG();
 }
 
 extern unsigned int early_recursion_flag;
diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
index 0fe6aac..703dc6e 100644
--- a/arch/x86/net/bpf_jit_comp.c
+++ b/arch/x86/net/bpf_jit_comp.c
@@ -827,9 +827,7 @@ static int emit_atomic(u8 **pprog, u8 atomic_op,
 	return 0;
 }
 
-static bool ex_handler_bpf(const struct exception_table_entry *x,
-			   struct pt_regs *regs, int trapnr,
-			   unsigned long error_code, unsigned long fault_addr)
+bool ex_handler_bpf(const struct exception_table_entry *x, struct pt_regs *regs)
 {
 	u32 reg = x->fixup >> 8;
 
@@ -1313,12 +1311,7 @@ st:			if (is_imm8(insn->off))
 				}
 				ex->insn = delta;
 
-				delta = (u8 *)ex_handler_bpf - (u8 *)&ex->handler;
-				if (!is_simm32(delta)) {
-					pr_err("extable->handler doesn't fit into 32-bit\n");
-					return -EFAULT;
-				}
-				ex->handler = delta;
+				ex->type = EX_TYPE_BPF;
 
 				if (dst_reg > BPF_REG_9) {
 					pr_err("verifier error\n");
diff --git a/scripts/sorttable.c b/scripts/sorttable.c
index f355869..a9b3324 100644
--- a/scripts/sorttable.c
+++ b/scripts/sorttable.c
@@ -236,7 +236,7 @@ static void x86_sort_relative_table(char *extab_image, int image_size)
 
 		w(r(loc) + i, loc);
 		w(r(loc + 1) + i + 4, loc + 1);
-		w(r(loc + 2) + i + 8, loc + 2);
+		/* Don't touch the fixup type */
 
 		i += sizeof(uint32_t) * 3;
 	}
@@ -249,7 +249,7 @@ static void x86_sort_relative_table(char *extab_image, int image_size)
 
 		w(r(loc) - i, loc);
 		w(r(loc + 1) - (i + 4), loc + 1);
-		w(r(loc + 2) - (i + 8), loc + 2);
+		/* Don't touch the fixup type */
 
 		i += sizeof(uint32_t) * 3;
 	}
