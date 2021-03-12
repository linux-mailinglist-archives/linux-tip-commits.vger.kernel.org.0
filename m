Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57875338C00
	for <lists+linux-tip-commits@lfdr.de>; Fri, 12 Mar 2021 12:55:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231202AbhCLLyt (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 12 Mar 2021 06:54:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231409AbhCLLyl (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 12 Mar 2021 06:54:41 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F35CEC061574;
        Fri, 12 Mar 2021 03:54:40 -0800 (PST)
Date:   Fri, 12 Mar 2021 11:54:38 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1615550079;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BTFWjpIN546L+RKN9QuH5Ysqlp2LzO9e4Mhx8KhcpfU=;
        b=TEfvX1A+FPe+3LuKNhbFNb4mWlrDD8lqXI0k6PpPnELzGnucnFOPYITjEd21isxuG9Nw03
        k9DGQaJtHNlL8mJjUMUHK/RMTGlqDBkUNhZpeqwcxBlb0viOatIOieZI9PSgnbHDDPZCtR
        wn3xAfMxwBLjrRNq2XViv4niqKW+bWGZlqVsv1Jvo0fvJwxLXjRjMPJdLfUsm/uD7qQVaA
        BeRyuexgyYG9jWxK8T14Xm/cAXQILSUs6p6iJvD419egB9sioTcrBUHHgze3uQZN9ibaxy
        rHM2wUT1CV/aunSNiF6nxkLzydWFvGzQVCv2ErCnByGzkSRJcO/Xun1EAGPt2g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1615550079;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BTFWjpIN546L+RKN9QuH5Ysqlp2LzO9e4Mhx8KhcpfU=;
        b=ZsEmy2gNOu424F4HlbjRjaR0mw30+q5dbdL4EYHH7ubKKSc67RTTPhC/oKrwZiQz3FfSkc
        iIdUIfpj+JinP9Bw==
From:   "tip-bot2 for Juergen Gross" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/alternatives] x86/paravirt: Remove no longer needed 32-bit
 pvops cruft
Cc:     Juergen Gross <jgross@suse.com>, Borislav Petkov <bp@suse.de>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210311142319.4723-10-jgross@suse.com>
References: <20210311142319.4723-10-jgross@suse.com>
MIME-Version: 1.0
Message-ID: <161555007867.398.11779208844209565747.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/alternatives branch of tip:

Commit-ID:     33634e42e38be61f320183dfc264b9caba292d4e
Gitweb:        https://git.kernel.org/tip/33634e42e38be61f320183dfc264b9caba292d4e
Author:        Juergen Gross <jgross@suse.com>
AuthorDate:    Thu, 11 Mar 2021 15:23:14 +01:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Thu, 11 Mar 2021 19:51:55 +01:00

x86/paravirt: Remove no longer needed 32-bit pvops cruft

PVOP_VCALL4() is only used for Xen PV, while PVOP_CALL4() isn't used
at all. Keep PVOP_CALL4() for 64 bits due to symmetry reasons.

This allows to remove the 32-bit definitions of those macros leading
to a substantial simplification of the paravirt macros, as those were
the only ones needing non-empty "pre" and "post" parameters.

PVOP_CALLEE2() and PVOP_VCALLEE2() are used nowhere, so remove them.

Another no longer needed case is special handling of return types
larger than unsigned long. Replace that with a BUILD_BUG_ON().

DISABLE_INTERRUPTS() is used in 32-bit code only, so it can just be
replaced by cli.

INTERRUPT_RETURN in 32-bit code can be replaced by iret.

ENABLE_INTERRUPTS is used nowhere, so it can be removed.

Signed-off-by: Juergen Gross <jgross@suse.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20210311142319.4723-10-jgross@suse.com
---
 arch/x86/entry/entry_32.S             |   4 +-
 arch/x86/include/asm/irqflags.h       |   5 +-
 arch/x86/include/asm/paravirt.h       |  35 +--------
 arch/x86/include/asm/paravirt_types.h | 112 +++++++------------------
 arch/x86/kernel/asm-offsets.c         |   2 +-
 5 files changed, 35 insertions(+), 123 deletions(-)

diff --git a/arch/x86/entry/entry_32.S b/arch/x86/entry/entry_32.S
index 4e079f2..96f0848 100644
--- a/arch/x86/entry/entry_32.S
+++ b/arch/x86/entry/entry_32.S
@@ -430,7 +430,7 @@
 	 * will soon execute iret and the tracer was already set to
 	 * the irqstate after the IRET:
 	 */
-	DISABLE_INTERRUPTS(CLBR_ANY)
+	cli
 	lss	(%esp), %esp			/* switch to espfix segment */
 .Lend_\@:
 #endif /* CONFIG_X86_ESPFIX32 */
@@ -1077,7 +1077,7 @@ restore_all_switch_stack:
 	 * when returning from IPI handler and when returning from
 	 * scheduler to user-space.
 	 */
-	INTERRUPT_RETURN
+	iret
 
 .section .fixup, "ax"
 SYM_CODE_START(asm_iret_error)
diff --git a/arch/x86/include/asm/irqflags.h b/arch/x86/include/asm/irqflags.h
index 144d70e..a0efbcd 100644
--- a/arch/x86/include/asm/irqflags.h
+++ b/arch/x86/include/asm/irqflags.h
@@ -109,9 +109,6 @@ static __always_inline unsigned long arch_local_irq_save(void)
 }
 #else
 
-#define ENABLE_INTERRUPTS(x)	sti
-#define DISABLE_INTERRUPTS(x)	cli
-
 #ifdef CONFIG_X86_64
 #ifdef CONFIG_DEBUG_ENTRY
 #define SAVE_FLAGS(x)		pushfq; popq %rax
@@ -119,8 +116,6 @@ static __always_inline unsigned long arch_local_irq_save(void)
 
 #define INTERRUPT_RETURN	jmp native_iret
 
-#else
-#define INTERRUPT_RETURN		iret
 #endif
 
 #endif /* __ASSEMBLY__ */
diff --git a/arch/x86/include/asm/paravirt.h b/arch/x86/include/asm/paravirt.h
index def450f..a780509 100644
--- a/arch/x86/include/asm/paravirt.h
+++ b/arch/x86/include/asm/paravirt.h
@@ -719,6 +719,7 @@ extern void default_banner(void);
 	.if ((~(set)) & mask); pop %reg; .endif
 
 #ifdef CONFIG_X86_64
+#ifdef CONFIG_PARAVIRT_XXL
 
 #define PV_SAVE_REGS(set)			\
 	COND_PUSH(set, CLBR_RAX, rax);		\
@@ -744,46 +745,12 @@ extern void default_banner(void);
 #define PARA_PATCH(off)		((off) / 8)
 #define PARA_SITE(ptype, ops)	_PVSITE(ptype, ops, .quad, 8)
 #define PARA_INDIRECT(addr)	*addr(%rip)
-#else
-#define PV_SAVE_REGS(set)			\
-	COND_PUSH(set, CLBR_EAX, eax);		\
-	COND_PUSH(set, CLBR_EDI, edi);		\
-	COND_PUSH(set, CLBR_ECX, ecx);		\
-	COND_PUSH(set, CLBR_EDX, edx)
-#define PV_RESTORE_REGS(set)			\
-	COND_POP(set, CLBR_EDX, edx);		\
-	COND_POP(set, CLBR_ECX, ecx);		\
-	COND_POP(set, CLBR_EDI, edi);		\
-	COND_POP(set, CLBR_EAX, eax)
-
-#define PARA_PATCH(off)		((off) / 4)
-#define PARA_SITE(ptype, ops)	_PVSITE(ptype, ops, .long, 4)
-#define PARA_INDIRECT(addr)	*%cs:addr
-#endif
 
-#ifdef CONFIG_PARAVIRT_XXL
 #define INTERRUPT_RETURN						\
 	PARA_SITE(PARA_PATCH(PV_CPU_iret),				\
 		  ANNOTATE_RETPOLINE_SAFE;				\
 		  jmp PARA_INDIRECT(pv_ops+PV_CPU_iret);)
 
-#define DISABLE_INTERRUPTS(clobbers)					\
-	PARA_SITE(PARA_PATCH(PV_IRQ_irq_disable),			\
-		  PV_SAVE_REGS(clobbers | CLBR_CALLEE_SAVE);		\
-		  ANNOTATE_RETPOLINE_SAFE;				\
-		  call PARA_INDIRECT(pv_ops+PV_IRQ_irq_disable);	\
-		  PV_RESTORE_REGS(clobbers | CLBR_CALLEE_SAVE);)
-
-#define ENABLE_INTERRUPTS(clobbers)					\
-	PARA_SITE(PARA_PATCH(PV_IRQ_irq_enable),			\
-		  PV_SAVE_REGS(clobbers | CLBR_CALLEE_SAVE);		\
-		  ANNOTATE_RETPOLINE_SAFE;				\
-		  call PARA_INDIRECT(pv_ops+PV_IRQ_irq_enable);		\
-		  PV_RESTORE_REGS(clobbers | CLBR_CALLEE_SAVE);)
-#endif
-
-#ifdef CONFIG_X86_64
-#ifdef CONFIG_PARAVIRT_XXL
 #ifdef CONFIG_DEBUG_ENTRY
 #define SAVE_FLAGS(clobbers)                                        \
 	PARA_SITE(PARA_PATCH(PV_IRQ_save_fl),			    \
diff --git a/arch/x86/include/asm/paravirt_types.h b/arch/x86/include/asm/paravirt_types.h
index 1fff349..42f9eef 100644
--- a/arch/x86/include/asm/paravirt_types.h
+++ b/arch/x86/include/asm/paravirt_types.h
@@ -470,55 +470,34 @@ int paravirt_disable_iospace(void);
 	})
 
 
-#define ____PVOP_CALL(rettype, op, clbr, call_clbr, extra_clbr,		\
-		      pre, post, ...)					\
+#define ____PVOP_CALL(rettype, op, clbr, call_clbr, extra_clbr, ...)	\
 	({								\
-		rettype __ret;						\
 		PVOP_CALL_ARGS;						\
 		PVOP_TEST_NULL(op);					\
-		/* This is 32-bit specific, but is okay in 64-bit */	\
-		/* since this condition will never hold */		\
-		if (sizeof(rettype) > sizeof(unsigned long)) {		\
-			asm volatile(pre				\
-				     paravirt_alt(PARAVIRT_CALL)	\
-				     post				\
-				     : call_clbr, ASM_CALL_CONSTRAINT	\
-				     : paravirt_type(op),		\
-				       paravirt_clobber(clbr),		\
-				       ##__VA_ARGS__			\
-				     : "memory", "cc" extra_clbr);	\
-			__ret = (rettype)((((u64)__edx) << 32) | __eax); \
-		} else {						\
-			asm volatile(pre				\
-				     paravirt_alt(PARAVIRT_CALL)	\
-				     post				\
-				     : call_clbr, ASM_CALL_CONSTRAINT	\
-				     : paravirt_type(op),		\
-				       paravirt_clobber(clbr),		\
-				       ##__VA_ARGS__			\
-				     : "memory", "cc" extra_clbr);	\
-			__ret = (rettype)(__eax & PVOP_RETMASK(rettype));	\
-		}							\
-		__ret;							\
+		BUILD_BUG_ON(sizeof(rettype) > sizeof(unsigned long));	\
+		asm volatile(paravirt_alt(PARAVIRT_CALL)		\
+			     : call_clbr, ASM_CALL_CONSTRAINT		\
+			     : paravirt_type(op),			\
+			       paravirt_clobber(clbr),			\
+			       ##__VA_ARGS__				\
+			     : "memory", "cc" extra_clbr);		\
+		(rettype)(__eax & PVOP_RETMASK(rettype));		\
 	})
 
-#define __PVOP_CALL(rettype, op, pre, post, ...)			\
+#define __PVOP_CALL(rettype, op, ...)					\
 	____PVOP_CALL(rettype, op, CLBR_ANY, PVOP_CALL_CLOBBERS,	\
-		      EXTRA_CLOBBERS, pre, post, ##__VA_ARGS__)
+		      EXTRA_CLOBBERS, ##__VA_ARGS__)
 
-#define __PVOP_CALLEESAVE(rettype, op, pre, post, ...)			\
+#define __PVOP_CALLEESAVE(rettype, op, ...)				\
 	____PVOP_CALL(rettype, op.func, CLBR_RET_REG,			\
-		      PVOP_CALLEE_CLOBBERS, ,				\
-		      pre, post, ##__VA_ARGS__)
+		      PVOP_CALLEE_CLOBBERS, , ##__VA_ARGS__)
 
 
-#define ____PVOP_VCALL(op, clbr, call_clbr, extra_clbr, pre, post, ...)	\
+#define ____PVOP_VCALL(op, clbr, call_clbr, extra_clbr, ...)		\
 	({								\
 		PVOP_VCALL_ARGS;					\
 		PVOP_TEST_NULL(op);					\
-		asm volatile(pre					\
-			     paravirt_alt(PARAVIRT_CALL)		\
-			     post					\
+		asm volatile(paravirt_alt(PARAVIRT_CALL)		\
 			     : call_clbr, ASM_CALL_CONSTRAINT		\
 			     : paravirt_type(op),			\
 			       paravirt_clobber(clbr),			\
@@ -526,84 +505,57 @@ int paravirt_disable_iospace(void);
 			     : "memory", "cc" extra_clbr);		\
 	})
 
-#define __PVOP_VCALL(op, pre, post, ...)				\
+#define __PVOP_VCALL(op, ...)						\
 	____PVOP_VCALL(op, CLBR_ANY, PVOP_VCALL_CLOBBERS,		\
-		       VEXTRA_CLOBBERS,					\
-		       pre, post, ##__VA_ARGS__)
+		       VEXTRA_CLOBBERS, ##__VA_ARGS__)
 
-#define __PVOP_VCALLEESAVE(op, pre, post, ...)				\
+#define __PVOP_VCALLEESAVE(op, ...)					\
 	____PVOP_VCALL(op.func, CLBR_RET_REG,				\
-		      PVOP_VCALLEE_CLOBBERS, ,				\
-		      pre, post, ##__VA_ARGS__)
+		      PVOP_VCALLEE_CLOBBERS, , ##__VA_ARGS__)
 
 
 
 #define PVOP_CALL0(rettype, op)						\
-	__PVOP_CALL(rettype, op, "", "")
+	__PVOP_CALL(rettype, op)
 #define PVOP_VCALL0(op)							\
-	__PVOP_VCALL(op, "", "")
+	__PVOP_VCALL(op)
 
 #define PVOP_CALLEE0(rettype, op)					\
-	__PVOP_CALLEESAVE(rettype, op, "", "")
+	__PVOP_CALLEESAVE(rettype, op)
 #define PVOP_VCALLEE0(op)						\
-	__PVOP_VCALLEESAVE(op, "", "")
+	__PVOP_VCALLEESAVE(op)
 
 
 #define PVOP_CALL1(rettype, op, arg1)					\
-	__PVOP_CALL(rettype, op, "", "", PVOP_CALL_ARG1(arg1))
+	__PVOP_CALL(rettype, op, PVOP_CALL_ARG1(arg1))
 #define PVOP_VCALL1(op, arg1)						\
-	__PVOP_VCALL(op, "", "", PVOP_CALL_ARG1(arg1))
+	__PVOP_VCALL(op, PVOP_CALL_ARG1(arg1))
 
 #define PVOP_CALLEE1(rettype, op, arg1)					\
-	__PVOP_CALLEESAVE(rettype, op, "", "", PVOP_CALL_ARG1(arg1))
+	__PVOP_CALLEESAVE(rettype, op, PVOP_CALL_ARG1(arg1))
 #define PVOP_VCALLEE1(op, arg1)						\
-	__PVOP_VCALLEESAVE(op, "", "", PVOP_CALL_ARG1(arg1))
+	__PVOP_VCALLEESAVE(op, PVOP_CALL_ARG1(arg1))
 
 
 #define PVOP_CALL2(rettype, op, arg1, arg2)				\
-	__PVOP_CALL(rettype, op, "", "", PVOP_CALL_ARG1(arg1),		\
-		    PVOP_CALL_ARG2(arg2))
+	__PVOP_CALL(rettype, op, PVOP_CALL_ARG1(arg1), PVOP_CALL_ARG2(arg2))
 #define PVOP_VCALL2(op, arg1, arg2)					\
-	__PVOP_VCALL(op, "", "", PVOP_CALL_ARG1(arg1),			\
-		     PVOP_CALL_ARG2(arg2))
-
-#define PVOP_CALLEE2(rettype, op, arg1, arg2)				\
-	__PVOP_CALLEESAVE(rettype, op, "", "", PVOP_CALL_ARG1(arg1),	\
-			  PVOP_CALL_ARG2(arg2))
-#define PVOP_VCALLEE2(op, arg1, arg2)					\
-	__PVOP_VCALLEESAVE(op, "", "", PVOP_CALL_ARG1(arg1),		\
-			   PVOP_CALL_ARG2(arg2))
-
+	__PVOP_VCALL(op, PVOP_CALL_ARG1(arg1), PVOP_CALL_ARG2(arg2))
 
 #define PVOP_CALL3(rettype, op, arg1, arg2, arg3)			\
-	__PVOP_CALL(rettype, op, "", "", PVOP_CALL_ARG1(arg1),		\
+	__PVOP_CALL(rettype, op, PVOP_CALL_ARG1(arg1),			\
 		    PVOP_CALL_ARG2(arg2), PVOP_CALL_ARG3(arg3))
 #define PVOP_VCALL3(op, arg1, arg2, arg3)				\
-	__PVOP_VCALL(op, "", "", PVOP_CALL_ARG1(arg1),			\
+	__PVOP_VCALL(op, PVOP_CALL_ARG1(arg1),				\
 		     PVOP_CALL_ARG2(arg2), PVOP_CALL_ARG3(arg3))
 
-/* This is the only difference in x86_64. We can make it much simpler */
-#ifdef CONFIG_X86_32
 #define PVOP_CALL4(rettype, op, arg1, arg2, arg3, arg4)			\
 	__PVOP_CALL(rettype, op,					\
-		    "push %[_arg4];", "lea 4(%%esp),%%esp;",		\
-		    PVOP_CALL_ARG1(arg1), PVOP_CALL_ARG2(arg2),		\
-		    PVOP_CALL_ARG3(arg3), [_arg4] "mr" ((u32)(arg4)))
-#define PVOP_VCALL4(op, arg1, arg2, arg3, arg4)				\
-	__PVOP_VCALL(op,						\
-		    "push %[_arg4];", "lea 4(%%esp),%%esp;",		\
-		    "0" ((u32)(arg1)), "1" ((u32)(arg2)),		\
-		    "2" ((u32)(arg3)), [_arg4] "mr" ((u32)(arg4)))
-#else
-#define PVOP_CALL4(rettype, op, arg1, arg2, arg3, arg4)			\
-	__PVOP_CALL(rettype, op, "", "",				\
 		    PVOP_CALL_ARG1(arg1), PVOP_CALL_ARG2(arg2),		\
 		    PVOP_CALL_ARG3(arg3), PVOP_CALL_ARG4(arg4))
 #define PVOP_VCALL4(op, arg1, arg2, arg3, arg4)				\
-	__PVOP_VCALL(op, "", "",					\
-		     PVOP_CALL_ARG1(arg1), PVOP_CALL_ARG2(arg2),	\
+	__PVOP_VCALL(op, PVOP_CALL_ARG1(arg1), PVOP_CALL_ARG2(arg2),	\
 		     PVOP_CALL_ARG3(arg3), PVOP_CALL_ARG4(arg4))
-#endif
 
 /* Lazy mode for batching updates / context switch */
 enum paravirt_lazy_mode {
diff --git a/arch/x86/kernel/asm-offsets.c b/arch/x86/kernel/asm-offsets.c
index 60b9f42..7365080 100644
--- a/arch/x86/kernel/asm-offsets.c
+++ b/arch/x86/kernel/asm-offsets.c
@@ -63,8 +63,6 @@ static void __used common(void)
 
 #ifdef CONFIG_PARAVIRT_XXL
 	BLANK();
-	OFFSET(PV_IRQ_irq_disable, paravirt_patch_template, irq.irq_disable);
-	OFFSET(PV_IRQ_irq_enable, paravirt_patch_template, irq.irq_enable);
 	OFFSET(PV_CPU_iret, paravirt_patch_template, cpu.iret);
 #endif
 
