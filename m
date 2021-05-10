Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B65A237887C
	for <lists+linux-tip-commits@lfdr.de>; Mon, 10 May 2021 13:47:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234208AbhEJLVj (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Mon, 10 May 2021 07:21:39 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:36314 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235346AbhEJLAp (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Mon, 10 May 2021 07:00:45 -0400
Date:   Mon, 10 May 2021 10:59:38 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1620644379;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9Q7UncAInzB0q75/FFVyaLc1oYz6kVZ3N+wuxDPiZGQ=;
        b=m+Ob8OF1/rNKkcc4o+KaQvuc+pffc5x6COivv5+tMowZ6oOQn54JCYKmsv/YkgvVRRjckA
        gjxOriiFJ195FXJwzmNOvto7mz5nlQXpTA+zEC9W0wn+CqTYAxW4UWDtuUZuSedANRRvtM
        YouCqLZzK3eVKwDTRCr+3bXiRnculQ22/i1a7qfYrqt1v1nVCt4CQiIceB+9Rjuba3hklx
        nozI29RIc9DzUxlhF3CnkP411RKeKsWXRF11FKtawrTHdj9wjegaZbJyPdLYiivSiuPbF5
        MM7ayFaTWdXeH3Q7/XIzQbHUoey8f+Md6ZQPraj/qx4Iqxd8FdT4ofuMD0mgxQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1620644379;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9Q7UncAInzB0q75/FFVyaLc1oYz6kVZ3N+wuxDPiZGQ=;
        b=1Qb81SzULLd7/MmcY0AvkX0mQ6Kr2gMSWiVj0fYu0/C69wy45wkQZRwkHF0K9ZrFSfKd3h
        ahkOF82bxY4uNPBA==
From:   "tip-bot2 for H. Peter Anvin (Intel)" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/asm] x86/asm: Use _ASM_BYTES() in <asm/nops.h>
Cc:     "H. Peter Anvin (Intel)" <hpa@zytor.com>,
        Ingo Molnar <mingo@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210510090940.924953-4-hpa@zytor.com>
References: <20210510090940.924953-4-hpa@zytor.com>
MIME-Version: 1.0
Message-ID: <162064437887.29796.16144339179320522548.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/asm branch of tip:

Commit-ID:     eef23e72b78b36924aea8be5ec7c54e628c442ef
Gitweb:        https://git.kernel.org/tip/eef23e72b78b36924aea8be5ec7c54e628c442ef
Author:        H. Peter Anvin (Intel) <hpa@zytor.com>
AuthorDate:    Mon, 10 May 2021 02:09:40 -07:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Mon, 10 May 2021 12:33:28 +02:00

x86/asm: Use _ASM_BYTES() in <asm/nops.h>

Use the new generalized _ASM_BYTES() macro from <asm/asm.h> instead of
the "home grown" _ASM_MK_NOP() in <asm/nops.h>.

Add <asm/asm.h> and update <asm/nops.h> in the tools directory...

Signed-off-by: H. Peter Anvin (Intel) <hpa@zytor.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/20210510090940.924953-4-hpa@zytor.com
---
 arch/x86/include/asm/nops.h       |  24 +---
 tools/arch/x86/include/asm/asm.h  | 189 +++++++++++++++++++++++++++++-
 tools/arch/x86/include/asm/nops.h |  24 +---
 3 files changed, 209 insertions(+), 28 deletions(-)
 create mode 100644 tools/arch/x86/include/asm/asm.h

diff --git a/arch/x86/include/asm/nops.h b/arch/x86/include/asm/nops.h
index c1e5e81..c5573ea 100644
--- a/arch/x86/include/asm/nops.h
+++ b/arch/x86/include/asm/nops.h
@@ -2,6 +2,8 @@
 #ifndef _ASM_X86_NOPS_H
 #define _ASM_X86_NOPS_H
 
+#include <asm/asm.h>
+
 /*
  * Define nops for use with alternative() and for tracing.
  */
@@ -57,20 +59,14 @@
 
 #endif /* CONFIG_64BIT */
 
-#ifdef __ASSEMBLY__
-#define _ASM_MK_NOP(x) .byte x
-#else
-#define _ASM_MK_NOP(x) ".byte " __stringify(x) "\n"
-#endif
-
-#define ASM_NOP1 _ASM_MK_NOP(BYTES_NOP1)
-#define ASM_NOP2 _ASM_MK_NOP(BYTES_NOP2)
-#define ASM_NOP3 _ASM_MK_NOP(BYTES_NOP3)
-#define ASM_NOP4 _ASM_MK_NOP(BYTES_NOP4)
-#define ASM_NOP5 _ASM_MK_NOP(BYTES_NOP5)
-#define ASM_NOP6 _ASM_MK_NOP(BYTES_NOP6)
-#define ASM_NOP7 _ASM_MK_NOP(BYTES_NOP7)
-#define ASM_NOP8 _ASM_MK_NOP(BYTES_NOP8)
+#define ASM_NOP1 _ASM_BYTES(BYTES_NOP1)
+#define ASM_NOP2 _ASM_BYTES(BYTES_NOP2)
+#define ASM_NOP3 _ASM_BYTES(BYTES_NOP3)
+#define ASM_NOP4 _ASM_BYTES(BYTES_NOP4)
+#define ASM_NOP5 _ASM_BYTES(BYTES_NOP5)
+#define ASM_NOP6 _ASM_BYTES(BYTES_NOP6)
+#define ASM_NOP7 _ASM_BYTES(BYTES_NOP7)
+#define ASM_NOP8 _ASM_BYTES(BYTES_NOP8)
 
 #define ASM_NOP_MAX 8
 
diff --git a/tools/arch/x86/include/asm/asm.h b/tools/arch/x86/include/asm/asm.h
new file mode 100644
index 0000000..507a37a
--- /dev/null
+++ b/tools/arch/x86/include/asm/asm.h
@@ -0,0 +1,189 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _ASM_X86_ASM_H
+#define _ASM_X86_ASM_H
+
+#ifdef __ASSEMBLY__
+# define __ASM_FORM(x, ...)		x,## __VA_ARGS__
+# define __ASM_FORM_RAW(x, ...)		x,## __VA_ARGS__
+# define __ASM_FORM_COMMA(x, ...)	x,## __VA_ARGS__,
+#else
+#include <linux/stringify.h>
+# define __ASM_FORM(x, ...)		" " __stringify(x,##__VA_ARGS__) " "
+# define __ASM_FORM_RAW(x, ...)		    __stringify(x,##__VA_ARGS__)
+# define __ASM_FORM_COMMA(x, ...)	" " __stringify(x,##__VA_ARGS__) ","
+#endif
+
+#define _ASM_BYTES(x, ...)	__ASM_FORM(.byte x,##__VA_ARGS__ ;)
+
+#ifndef __x86_64__
+/* 32 bit */
+# define __ASM_SEL(a,b)		__ASM_FORM(a)
+# define __ASM_SEL_RAW(a,b)	__ASM_FORM_RAW(a)
+#else
+/* 64 bit */
+# define __ASM_SEL(a,b)		__ASM_FORM(b)
+# define __ASM_SEL_RAW(a,b)	__ASM_FORM_RAW(b)
+#endif
+
+#define __ASM_SIZE(inst, ...)	__ASM_SEL(inst##l##__VA_ARGS__, \
+					  inst##q##__VA_ARGS__)
+#define __ASM_REG(reg)         __ASM_SEL_RAW(e##reg, r##reg)
+
+#define _ASM_PTR	__ASM_SEL(.long, .quad)
+#define _ASM_ALIGN	__ASM_SEL(.balign 4, .balign 8)
+
+#define _ASM_MOV	__ASM_SIZE(mov)
+#define _ASM_INC	__ASM_SIZE(inc)
+#define _ASM_DEC	__ASM_SIZE(dec)
+#define _ASM_ADD	__ASM_SIZE(add)
+#define _ASM_SUB	__ASM_SIZE(sub)
+#define _ASM_XADD	__ASM_SIZE(xadd)
+#define _ASM_MUL	__ASM_SIZE(mul)
+
+#define _ASM_AX		__ASM_REG(ax)
+#define _ASM_BX		__ASM_REG(bx)
+#define _ASM_CX		__ASM_REG(cx)
+#define _ASM_DX		__ASM_REG(dx)
+#define _ASM_SP		__ASM_REG(sp)
+#define _ASM_BP		__ASM_REG(bp)
+#define _ASM_SI		__ASM_REG(si)
+#define _ASM_DI		__ASM_REG(di)
+
+#ifndef __x86_64__
+/* 32 bit */
+
+#define _ASM_ARG1	_ASM_AX
+#define _ASM_ARG2	_ASM_DX
+#define _ASM_ARG3	_ASM_CX
+
+#define _ASM_ARG1L	eax
+#define _ASM_ARG2L	edx
+#define _ASM_ARG3L	ecx
+
+#define _ASM_ARG1W	ax
+#define _ASM_ARG2W	dx
+#define _ASM_ARG3W	cx
+
+#define _ASM_ARG1B	al
+#define _ASM_ARG2B	dl
+#define _ASM_ARG3B	cl
+
+#else
+/* 64 bit */
+
+#define _ASM_ARG1	_ASM_DI
+#define _ASM_ARG2	_ASM_SI
+#define _ASM_ARG3	_ASM_DX
+#define _ASM_ARG4	_ASM_CX
+#define _ASM_ARG5	r8
+#define _ASM_ARG6	r9
+
+#define _ASM_ARG1Q	rdi
+#define _ASM_ARG2Q	rsi
+#define _ASM_ARG3Q	rdx
+#define _ASM_ARG4Q	rcx
+#define _ASM_ARG5Q	r8
+#define _ASM_ARG6Q	r9
+
+#define _ASM_ARG1L	edi
+#define _ASM_ARG2L	esi
+#define _ASM_ARG3L	edx
+#define _ASM_ARG4L	ecx
+#define _ASM_ARG5L	r8d
+#define _ASM_ARG6L	r9d
+
+#define _ASM_ARG1W	di
+#define _ASM_ARG2W	si
+#define _ASM_ARG3W	dx
+#define _ASM_ARG4W	cx
+#define _ASM_ARG5W	r8w
+#define _ASM_ARG6W	r9w
+
+#define _ASM_ARG1B	dil
+#define _ASM_ARG2B	sil
+#define _ASM_ARG3B	dl
+#define _ASM_ARG4B	cl
+#define _ASM_ARG5B	r8b
+#define _ASM_ARG6B	r9b
+
+#endif
+
+/*
+ * Macros to generate condition code outputs from inline assembly,
+ * The output operand must be type "bool".
+ */
+#ifdef __GCC_ASM_FLAG_OUTPUTS__
+# define CC_SET(c) "\n\t/* output condition code " #c "*/\n"
+# define CC_OUT(c) "=@cc" #c
+#else
+# define CC_SET(c) "\n\tset" #c " %[_cc_" #c "]\n"
+# define CC_OUT(c) [_cc_ ## c] "=qm"
+#endif
+
+/* Exception table entry */
+#ifdef __ASSEMBLY__
+# define _ASM_EXTABLE_HANDLE(from, to, handler)			\
+	.pushsection "__ex_table","a" ;				\
+	.balign 4 ;						\
+	.long (from) - . ;					\
+	.long (to) - . ;					\
+	.long (handler) - . ;					\
+	.popsection
+
+# define _ASM_EXTABLE(from, to)					\
+	_ASM_EXTABLE_HANDLE(from, to, ex_handler_default)
+
+# define _ASM_EXTABLE_UA(from, to)				\
+	_ASM_EXTABLE_HANDLE(from, to, ex_handler_uaccess)
+
+# define _ASM_EXTABLE_CPY(from, to)				\
+	_ASM_EXTABLE_HANDLE(from, to, ex_handler_copy)
+
+# define _ASM_EXTABLE_FAULT(from, to)				\
+	_ASM_EXTABLE_HANDLE(from, to, ex_handler_fault)
+
+# ifdef CONFIG_KPROBES
+#  define _ASM_NOKPROBE(entry)					\
+	.pushsection "_kprobe_blacklist","aw" ;			\
+	_ASM_ALIGN ;						\
+	_ASM_PTR (entry);					\
+	.popsection
+# else
+#  define _ASM_NOKPROBE(entry)
+# endif
+
+#else /* ! __ASSEMBLY__ */
+# define _EXPAND_EXTABLE_HANDLE(x) #x
+# define _ASM_EXTABLE_HANDLE(from, to, handler)			\
+	" .pushsection \"__ex_table\",\"a\"\n"			\
+	" .balign 4\n"						\
+	" .long (" #from ") - .\n"				\
+	" .long (" #to ") - .\n"				\
+	" .long (" _EXPAND_EXTABLE_HANDLE(handler) ") - .\n"	\
+	" .popsection\n"
+
+# define _ASM_EXTABLE(from, to)					\
+	_ASM_EXTABLE_HANDLE(from, to, ex_handler_default)
+
+# define _ASM_EXTABLE_UA(from, to)				\
+	_ASM_EXTABLE_HANDLE(from, to, ex_handler_uaccess)
+
+# define _ASM_EXTABLE_CPY(from, to)				\
+	_ASM_EXTABLE_HANDLE(from, to, ex_handler_copy)
+
+# define _ASM_EXTABLE_FAULT(from, to)				\
+	_ASM_EXTABLE_HANDLE(from, to, ex_handler_fault)
+
+/* For C file, we already have NOKPROBE_SYMBOL macro */
+
+/*
+ * This output constraint should be used for any inline asm which has a "call"
+ * instruction.  Otherwise the asm may be inserted before the frame pointer
+ * gets set up by the containing function.  If you forget to do this, objtool
+ * may print a "call without frame pointer save/setup" warning.
+ */
+register unsigned long current_stack_pointer asm(_ASM_SP);
+#define ASM_CALL_CONSTRAINT "+r" (current_stack_pointer)
+#endif /* __ASSEMBLY__ */
+
+#endif /* _ASM_X86_ASM_H */
diff --git a/tools/arch/x86/include/asm/nops.h b/tools/arch/x86/include/asm/nops.h
index c1e5e81..c5573ea 100644
--- a/tools/arch/x86/include/asm/nops.h
+++ b/tools/arch/x86/include/asm/nops.h
@@ -2,6 +2,8 @@
 #ifndef _ASM_X86_NOPS_H
 #define _ASM_X86_NOPS_H
 
+#include <asm/asm.h>
+
 /*
  * Define nops for use with alternative() and for tracing.
  */
@@ -57,20 +59,14 @@
 
 #endif /* CONFIG_64BIT */
 
-#ifdef __ASSEMBLY__
-#define _ASM_MK_NOP(x) .byte x
-#else
-#define _ASM_MK_NOP(x) ".byte " __stringify(x) "\n"
-#endif
-
-#define ASM_NOP1 _ASM_MK_NOP(BYTES_NOP1)
-#define ASM_NOP2 _ASM_MK_NOP(BYTES_NOP2)
-#define ASM_NOP3 _ASM_MK_NOP(BYTES_NOP3)
-#define ASM_NOP4 _ASM_MK_NOP(BYTES_NOP4)
-#define ASM_NOP5 _ASM_MK_NOP(BYTES_NOP5)
-#define ASM_NOP6 _ASM_MK_NOP(BYTES_NOP6)
-#define ASM_NOP7 _ASM_MK_NOP(BYTES_NOP7)
-#define ASM_NOP8 _ASM_MK_NOP(BYTES_NOP8)
+#define ASM_NOP1 _ASM_BYTES(BYTES_NOP1)
+#define ASM_NOP2 _ASM_BYTES(BYTES_NOP2)
+#define ASM_NOP3 _ASM_BYTES(BYTES_NOP3)
+#define ASM_NOP4 _ASM_BYTES(BYTES_NOP4)
+#define ASM_NOP5 _ASM_BYTES(BYTES_NOP5)
+#define ASM_NOP6 _ASM_BYTES(BYTES_NOP6)
+#define ASM_NOP7 _ASM_BYTES(BYTES_NOP7)
+#define ASM_NOP8 _ASM_BYTES(BYTES_NOP8)
 
 #define ASM_NOP_MAX 8
 
