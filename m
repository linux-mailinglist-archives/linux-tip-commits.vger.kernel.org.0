Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8EF1F3182BE
	for <lists+linux-tip-commits@lfdr.de>; Thu, 11 Feb 2021 01:54:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230318AbhBKAvW (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 10 Feb 2021 19:51:22 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:35528 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230042AbhBKAvJ (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 10 Feb 2021 19:51:09 -0500
Date:   Thu, 11 Feb 2021 00:50:25 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1613004626;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=st2B6QHmfN4ujmFzOt+8ewxD4I/fz4PVhv+5IGFugps=;
        b=si+aY4jb2SvHYGNE7N0IG/uVMYqCz0vbFZ4SZWvAeumm7wsa8eFOrnbopSx3JSQ2f4Oqwq
        XpuL8GmtNVETTx37wKe5qErqD6qZLA613L9Gy2+o1yDQXS/0gCuaRuX4JMvGY6yw07/f7z
        HCcRYGTvxQydAbL1E59IggxuwL+O6DTTY3CLBzlG5yycoiLWvhKzFb/+D6+Dq2a10lb3Gy
        SDEXCN+fFKn9jui+29unySO4hV5p6j4bGOjhzf+USoVl6APwPpvkPyTMSNhvavYNgTsFXJ
        PO1eZwArsYNsIYCsXUjq3DAEHl7ZrruZ+sfCtqr1D/INXa5iLyg9/CDr04EviQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1613004626;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=st2B6QHmfN4ujmFzOt+8ewxD4I/fz4PVhv+5IGFugps=;
        b=+SkjRCpLrOU/Y7W6/h1V9Asf245Hy78pRvcSAARjuTx1KJJKokVv9H/fA1nnDk/t1mRlCM
        jWX3cK19BsSJV5BA==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/entry] x86/irq: Provide macro for inlining irq stack switching
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Kees Cook <keescook@chromium.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210210002512.578371068@linutronix.de>
References: <20210210002512.578371068@linutronix.de>
MIME-Version: 1.0
Message-ID: <161300462586.23325.12238443401872704705.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/entry branch of tip:

Commit-ID:     a0cfc74d0b00c5201e1c09e28b2dc01c8088f809
Gitweb:        https://git.kernel.org/tip/a0cfc74d0b00c5201e1c09e28b2dc01c8088f809
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Wed, 10 Feb 2021 00:40:46 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 10 Feb 2021 23:34:14 +01:00

x86/irq: Provide macro for inlining irq stack switching

The effort to make the ASM entry code slim and unified moved the irq stack
switching out of the low level ASM code so that the whole return from
interrupt work and state handling can be done in C and the ASM code just
handles the low level details of entry and exit.

This ended up being a suboptimal implementation for various reasons
(including tooling). The main pain points are:

 - The indirect call which is expensive thanks to retpoline

 - The inability to stay on the irq stack for softirq processing on return
   from interrupt

 - The fact that the stack switching code ends up being an easy to target
   exploit gadget.

Prepare for inlining the stack switching logic into the C entry points by
providing a ASM macro which contains the guts of the switching mechanism:

  1) Store RSP at the top of the irq stack
  2) Switch RSP to the irq stack
  3) Invoke code
  4) Pop the original RSP back

Document the unholy asm() logic while at it to reduce the amount of head
scratching required a half year from now.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Kees Cook <keescook@chromium.org>
Link: https://lore.kernel.org/r/20210210002512.578371068@linutronix.de

---
 arch/x86/include/asm/irq_stack.h | 98 +++++++++++++++++++++++++++++++-
 1 file changed, 98 insertions(+)

diff --git a/arch/x86/include/asm/irq_stack.h b/arch/x86/include/asm/irq_stack.h
index 554f84b..d5b7bc6 100644
--- a/arch/x86/include/asm/irq_stack.h
+++ b/arch/x86/include/asm/irq_stack.h
@@ -7,6 +7,104 @@
 #include <asm/processor.h>
 
 #ifdef CONFIG_X86_64
+
+/*
+ * Macro to inline switching to an interrupt stack and invoking function
+ * calls from there. The following rules apply:
+ *
+ * - Ordering:
+ *
+ *   1. Write the stack pointer into the top most place of the irq
+ *	stack. This ensures that the various unwinders can link back to the
+ *	original stack.
+ *
+ *   2. Switch the stack pointer to the top of the irq stack.
+ *
+ *   3. Invoke whatever needs to be done (@asm_call argument)
+ *
+ *   4. Pop the original stack pointer from the top of the irq stack
+ *	which brings it back to the original stack where it left off.
+ *
+ * - Function invocation:
+ *
+ *   To allow flexible usage of the macro, the actual function code including
+ *   the store of the arguments in the call ABI registers is handed in via
+ *   the @asm_call argument.
+ *
+ * - Local variables:
+ *
+ *   @tos:
+ *	The @tos variable holds a pointer to the top of the irq stack and
+ *	_must_ be allocated in a non-callee saved register as this is a
+ *	restriction coming from objtool.
+ *
+ *	Note, that (tos) is both in input and output constraints to ensure
+ *	that the compiler does not assume that R11 is left untouched in
+ *	case this macro is used in some place where the per cpu interrupt
+ *	stack pointer is used again afterwards
+ *
+ * - Function arguments:
+ *	The function argument(s), if any, have to be defined in register
+ *	variables at the place where this is invoked. Storing the
+ *	argument(s) in the proper register(s) is part of the @asm_call
+ *
+ * - Constraints:
+ *
+ *   The constraints have to be done very carefully because the compiler
+ *   does not know about the assembly call.
+ *
+ *   output:
+ *     As documented already above the @tos variable is required to be in
+ *     the output constraints to make the compiler aware that R11 cannot be
+ *     reused after the asm() statement.
+ *
+ *     For builds with CONFIG_UNWIND_FRAME_POINTER ASM_CALL_CONSTRAINT is
+ *     required as well as this prevents certain creative GCC variants from
+ *     misplacing the ASM code.
+ *
+ *  input:
+ *    - func:
+ *	  Immediate, which tells the compiler that the function is referenced.
+ *
+ *    - tos:
+ *	  Register. The actual register is defined by the variable declaration.
+ *
+ *    - function arguments:
+ *	  The constraints are handed in via the 'argconstr' argument list. They
+ *	  describe the register arguments which are used in @asm_call.
+ *
+ *  clobbers:
+ *     Function calls can clobber anything except the callee-saved
+ *     registers. Tell the compiler.
+ */
+#define call_on_irqstack(func, asm_call, argconstr...)			\
+{									\
+	register void *tos asm("r11");					\
+									\
+	tos = ((void *)__this_cpu_read(hardirq_stack_ptr));		\
+									\
+	asm_inline volatile(						\
+	"movq	%%rsp, (%[tos])				\n"		\
+	"movq	%[tos], %%rsp				\n"		\
+									\
+	asm_call							\
+									\
+	"popq	%%rsp					\n"		\
+									\
+	: "+r" (tos), ASM_CALL_CONSTRAINT				\
+	: [__func] "i" (func), [tos] "r" (tos) argconstr		\
+	: "cc", "rax", "rcx", "rdx", "rsi", "rdi", "r8", "r9", "r10",	\
+	  "memory"							\
+	);								\
+}
+
+/* Macros to assert type correctness for run_*_on_irqstack macros */
+#define assert_function_type(func, proto)				\
+	static_assert(__builtin_types_compatible_p(typeof(&func), proto))
+
+#define assert_arg_type(arg, proto)					\
+	static_assert(__builtin_types_compatible_p(typeof(arg), proto))
+
 static __always_inline bool irqstack_active(void)
 {
 	return __this_cpu_read(hardirq_stack_inuse);
