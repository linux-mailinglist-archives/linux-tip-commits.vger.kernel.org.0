Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9000338C01
	for <lists+linux-tip-commits@lfdr.de>; Fri, 12 Mar 2021 12:55:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231538AbhCLLyv (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 12 Mar 2021 06:54:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231474AbhCLLyn (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 12 Mar 2021 06:54:43 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34791C061574;
        Fri, 12 Mar 2021 03:54:43 -0800 (PST)
Date:   Fri, 12 Mar 2021 11:54:41 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1615550081;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Oz11jeGM/8r173rKrtiqAPEG+Y8KKDi/QWwn2FnlA4A=;
        b=oDpt2G3GY7rFtMrX3EXwJIDCvm+rtnIqxYlPsyh/OSzHDGYsKSP9Wd+wZzejfS1nYUWS+d
        6h0jsc33i9sb5Dz5j78cF5ybCfWhMM44ZdXK2Go/b765aRY5iTsMDCmSmWh/ls0x3kJhlm
        QZGK4+DtS8H9mo7VPU9BIs4smYdYOgDUglDYJes6cV6uKB9B4fFNSpgDEqhQ2AJ2M0Kecx
        NDpSqrvn1ZLcq0ELo6McUIB5lne/Id1qkzD0ml4ehkINmRP2mcploxMKu8r23prqnUe+X2
        P1mLS9casVnODuMEfUaO7q6y4Y/Ap7wrcGWgbEvzezVval7XXYeEHmyyY5yaNQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1615550081;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Oz11jeGM/8r173rKrtiqAPEG+Y8KKDi/QWwn2FnlA4A=;
        b=n0VKIc8pGHhBSk3c3+iHcolXUduLMAD6uGTXnz9zW7ZSYuzf4cH88chmg0pcLJm/CB8pKV
        AdakhvHk/LvPQ8Bg==
From:   "tip-bot2 for Juergen Gross" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/alternatives] x86/alternative: Merge include files
Cc:     Juergen Gross <jgross@suse.com>, Borislav Petkov <bp@suse.de>,
        x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20210311142319.4723-2-jgross@suse.com>
References: <20210311142319.4723-2-jgross@suse.com>
MIME-Version: 1.0
Message-ID: <161555008113.398.7221616698306911231.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/alternatives branch of tip:

Commit-ID:     5e21a3ecad1500e35b46701e7f3f232e15d78e69
Gitweb:        https://git.kernel.org/tip/5e21a3ecad1500e35b46701e7f3f232e15d78e69
Author:        Juergen Gross <jgross@suse.com>
AuthorDate:    Thu, 11 Mar 2021 15:23:06 +01:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Thu, 11 Mar 2021 15:58:02 +01:00

x86/alternative: Merge include files

Merge arch/x86/include/asm/alternative-asm.h into
arch/x86/include/asm/alternative.h in order to make it easier to use
common definitions later.

Signed-off-by: Juergen Gross <jgross@suse.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lkml.kernel.org/r/20210311142319.4723-2-jgross@suse.com
---
 arch/x86/entry/entry_32.S                |   2 +-
 arch/x86/entry/vdso/vdso32/system_call.S |   2 +-
 arch/x86/include/asm/alternative-asm.h   | 114 +----------------------
 arch/x86/include/asm/alternative.h       | 112 +++++++++++++++++++++-
 arch/x86/include/asm/nospec-branch.h     |   1 +-
 arch/x86/include/asm/smap.h              |   5 +-
 arch/x86/lib/atomic64_386_32.S           |   2 +-
 arch/x86/lib/atomic64_cx8_32.S           |   2 +-
 arch/x86/lib/copy_page_64.S              |   2 +-
 arch/x86/lib/copy_user_64.S              |   2 +-
 arch/x86/lib/memcpy_64.S                 |   2 +-
 arch/x86/lib/memmove_64.S                |   2 +-
 arch/x86/lib/memset_64.S                 |   2 +-
 arch/x86/lib/retpoline.S                 |   2 +-
 14 files changed, 120 insertions(+), 132 deletions(-)
 delete mode 100644 arch/x86/include/asm/alternative-asm.h

diff --git a/arch/x86/entry/entry_32.S b/arch/x86/entry/entry_32.S
index df8c017..4e079f2 100644
--- a/arch/x86/entry/entry_32.S
+++ b/arch/x86/entry/entry_32.S
@@ -40,7 +40,7 @@
 #include <asm/processor-flags.h>
 #include <asm/irq_vectors.h>
 #include <asm/cpufeatures.h>
-#include <asm/alternative-asm.h>
+#include <asm/alternative.h>
 #include <asm/asm.h>
 #include <asm/smap.h>
 #include <asm/frame.h>
diff --git a/arch/x86/entry/vdso/vdso32/system_call.S b/arch/x86/entry/vdso/vdso32/system_call.S
index de1fff7..d6a6080 100644
--- a/arch/x86/entry/vdso/vdso32/system_call.S
+++ b/arch/x86/entry/vdso/vdso32/system_call.S
@@ -6,7 +6,7 @@
 #include <linux/linkage.h>
 #include <asm/dwarf2.h>
 #include <asm/cpufeatures.h>
-#include <asm/alternative-asm.h>
+#include <asm/alternative.h>
 
 	.text
 	.globl __kernel_vsyscall
diff --git a/arch/x86/include/asm/alternative-asm.h b/arch/x86/include/asm/alternative-asm.h
deleted file mode 100644
index 464034d..0000000
--- a/arch/x86/include/asm/alternative-asm.h
+++ /dev/null
@@ -1,114 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-#ifndef _ASM_X86_ALTERNATIVE_ASM_H
-#define _ASM_X86_ALTERNATIVE_ASM_H
-
-#ifdef __ASSEMBLY__
-
-#include <asm/asm.h>
-
-#ifdef CONFIG_SMP
-	.macro LOCK_PREFIX
-672:	lock
-	.pushsection .smp_locks,"a"
-	.balign 4
-	.long 672b - .
-	.popsection
-	.endm
-#else
-	.macro LOCK_PREFIX
-	.endm
-#endif
-
-/*
- * objtool annotation to ignore the alternatives and only consider the original
- * instruction(s).
- */
-.macro ANNOTATE_IGNORE_ALTERNATIVE
-	.Lannotate_\@:
-	.pushsection .discard.ignore_alts
-	.long .Lannotate_\@ - .
-	.popsection
-.endm
-
-/*
- * Issue one struct alt_instr descriptor entry (need to put it into
- * the section .altinstructions, see below). This entry contains
- * enough information for the alternatives patching code to patch an
- * instruction. See apply_alternatives().
- */
-.macro altinstruction_entry orig alt feature orig_len alt_len pad_len
-	.long \orig - .
-	.long \alt - .
-	.word \feature
-	.byte \orig_len
-	.byte \alt_len
-	.byte \pad_len
-.endm
-
-/*
- * Define an alternative between two instructions. If @feature is
- * present, early code in apply_alternatives() replaces @oldinstr with
- * @newinstr. ".skip" directive takes care of proper instruction padding
- * in case @newinstr is longer than @oldinstr.
- */
-.macro ALTERNATIVE oldinstr, newinstr, feature
-140:
-	\oldinstr
-141:
-	.skip -(((144f-143f)-(141b-140b)) > 0) * ((144f-143f)-(141b-140b)),0x90
-142:
-
-	.pushsection .altinstructions,"a"
-	altinstruction_entry 140b,143f,\feature,142b-140b,144f-143f,142b-141b
-	.popsection
-
-	.pushsection .altinstr_replacement,"ax"
-143:
-	\newinstr
-144:
-	.popsection
-.endm
-
-#define old_len			141b-140b
-#define new_len1		144f-143f
-#define new_len2		145f-144f
-
-/*
- * gas compatible max based on the idea from:
- * http://graphics.stanford.edu/~seander/bithacks.html#IntegerMinOrMax
- *
- * The additional "-" is needed because gas uses a "true" value of -1.
- */
-#define alt_max_short(a, b)	((a) ^ (((a) ^ (b)) & -(-((a) < (b)))))
-
-
-/*
- * Same as ALTERNATIVE macro above but for two alternatives. If CPU
- * has @feature1, it replaces @oldinstr with @newinstr1. If CPU has
- * @feature2, it replaces @oldinstr with @feature2.
- */
-.macro ALTERNATIVE_2 oldinstr, newinstr1, feature1, newinstr2, feature2
-140:
-	\oldinstr
-141:
-	.skip -((alt_max_short(new_len1, new_len2) - (old_len)) > 0) * \
-		(alt_max_short(new_len1, new_len2) - (old_len)),0x90
-142:
-
-	.pushsection .altinstructions,"a"
-	altinstruction_entry 140b,143f,\feature1,142b-140b,144f-143f,142b-141b
-	altinstruction_entry 140b,144f,\feature2,142b-140b,145f-144f,142b-141b
-	.popsection
-
-	.pushsection .altinstr_replacement,"ax"
-143:
-	\newinstr1
-144:
-	\newinstr2
-145:
-	.popsection
-.endm
-
-#endif  /*  __ASSEMBLY__  */
-
-#endif /* _ASM_X86_ALTERNATIVE_ASM_H */
diff --git a/arch/x86/include/asm/alternative.h b/arch/x86/include/asm/alternative.h
index 5753fb2..53f295f 100644
--- a/arch/x86/include/asm/alternative.h
+++ b/arch/x86/include/asm/alternative.h
@@ -2,13 +2,14 @@
 #ifndef _ASM_X86_ALTERNATIVE_H
 #define _ASM_X86_ALTERNATIVE_H
 
-#ifndef __ASSEMBLY__
-
 #include <linux/types.h>
-#include <linux/stddef.h>
 #include <linux/stringify.h>
 #include <asm/asm.h>
 
+#ifndef __ASSEMBLY__
+
+#include <linux/stddef.h>
+
 /*
  * Alternative inline assembly for SMP.
  *
@@ -271,6 +272,111 @@ static inline int alternatives_text_reserved(void *start, void *end)
  */
 #define ASM_NO_INPUT_CLOBBER(clbr...) "i" (0) : clbr
 
+#else /* __ASSEMBLY__ */
+
+#ifdef CONFIG_SMP
+	.macro LOCK_PREFIX
+672:	lock
+	.pushsection .smp_locks,"a"
+	.balign 4
+	.long 672b - .
+	.popsection
+	.endm
+#else
+	.macro LOCK_PREFIX
+	.endm
+#endif
+
+/*
+ * objtool annotation to ignore the alternatives and only consider the original
+ * instruction(s).
+ */
+.macro ANNOTATE_IGNORE_ALTERNATIVE
+	.Lannotate_\@:
+	.pushsection .discard.ignore_alts
+	.long .Lannotate_\@ - .
+	.popsection
+.endm
+
+/*
+ * Issue one struct alt_instr descriptor entry (need to put it into
+ * the section .altinstructions, see below). This entry contains
+ * enough information for the alternatives patching code to patch an
+ * instruction. See apply_alternatives().
+ */
+.macro altinstruction_entry orig alt feature orig_len alt_len pad_len
+	.long \orig - .
+	.long \alt - .
+	.word \feature
+	.byte \orig_len
+	.byte \alt_len
+	.byte \pad_len
+.endm
+
+/*
+ * Define an alternative between two instructions. If @feature is
+ * present, early code in apply_alternatives() replaces @oldinstr with
+ * @newinstr. ".skip" directive takes care of proper instruction padding
+ * in case @newinstr is longer than @oldinstr.
+ */
+.macro ALTERNATIVE oldinstr, newinstr, feature
+140:
+	\oldinstr
+141:
+	.skip -(((144f-143f)-(141b-140b)) > 0) * ((144f-143f)-(141b-140b)),0x90
+142:
+
+	.pushsection .altinstructions,"a"
+	altinstruction_entry 140b,143f,\feature,142b-140b,144f-143f,142b-141b
+	.popsection
+
+	.pushsection .altinstr_replacement,"ax"
+143:
+	\newinstr
+144:
+	.popsection
+.endm
+
+#define old_len			141b-140b
+#define new_len1		144f-143f
+#define new_len2		145f-144f
+
+/*
+ * gas compatible max based on the idea from:
+ * http://graphics.stanford.edu/~seander/bithacks.html#IntegerMinOrMax
+ *
+ * The additional "-" is needed because gas uses a "true" value of -1.
+ */
+#define alt_max_short(a, b)	((a) ^ (((a) ^ (b)) & -(-((a) < (b)))))
+
+
+/*
+ * Same as ALTERNATIVE macro above but for two alternatives. If CPU
+ * has @feature1, it replaces @oldinstr with @newinstr1. If CPU has
+ * @feature2, it replaces @oldinstr with @feature2.
+ */
+.macro ALTERNATIVE_2 oldinstr, newinstr1, feature1, newinstr2, feature2
+140:
+	\oldinstr
+141:
+	.skip -((alt_max_short(new_len1, new_len2) - (old_len)) > 0) * \
+		(alt_max_short(new_len1, new_len2) - (old_len)),0x90
+142:
+
+	.pushsection .altinstructions,"a"
+	altinstruction_entry 140b,143f,\feature1,142b-140b,144f-143f,142b-141b
+	altinstruction_entry 140b,144f,\feature2,142b-140b,145f-144f,142b-141b
+	.popsection
+
+	.pushsection .altinstr_replacement,"ax"
+143:
+	\newinstr1
+144:
+	\newinstr2
+145:
+	.popsection
+.endm
+
 #endif /* __ASSEMBLY__ */
 
 #endif /* _ASM_X86_ALTERNATIVE_H */
diff --git a/arch/x86/include/asm/nospec-branch.h b/arch/x86/include/asm/nospec-branch.h
index cb9ad6b..529f8e9 100644
--- a/arch/x86/include/asm/nospec-branch.h
+++ b/arch/x86/include/asm/nospec-branch.h
@@ -7,7 +7,6 @@
 #include <linux/objtool.h>
 
 #include <asm/alternative.h>
-#include <asm/alternative-asm.h>
 #include <asm/cpufeatures.h>
 #include <asm/msr-index.h>
 #include <asm/unwind_hints.h>
diff --git a/arch/x86/include/asm/smap.h b/arch/x86/include/asm/smap.h
index 8b58d69..ea1d8eb 100644
--- a/arch/x86/include/asm/smap.h
+++ b/arch/x86/include/asm/smap.h
@@ -11,6 +11,7 @@
 
 #include <asm/nops.h>
 #include <asm/cpufeatures.h>
+#include <asm/alternative.h>
 
 /* "Raw" instruction opcodes */
 #define __ASM_CLAC	".byte 0x0f,0x01,0xca"
@@ -18,8 +19,6 @@
 
 #ifdef __ASSEMBLY__
 
-#include <asm/alternative-asm.h>
-
 #ifdef CONFIG_X86_SMAP
 
 #define ASM_CLAC \
@@ -37,8 +36,6 @@
 
 #else /* __ASSEMBLY__ */
 
-#include <asm/alternative.h>
-
 #ifdef CONFIG_X86_SMAP
 
 static __always_inline void clac(void)
diff --git a/arch/x86/lib/atomic64_386_32.S b/arch/x86/lib/atomic64_386_32.S
index 3b65441..16bc913 100644
--- a/arch/x86/lib/atomic64_386_32.S
+++ b/arch/x86/lib/atomic64_386_32.S
@@ -6,7 +6,7 @@
  */
 
 #include <linux/linkage.h>
-#include <asm/alternative-asm.h>
+#include <asm/alternative.h>
 
 /* if you want SMP support, implement these with real spinlocks */
 .macro LOCK reg
diff --git a/arch/x86/lib/atomic64_cx8_32.S b/arch/x86/lib/atomic64_cx8_32.S
index 1c5c81c..ce69356 100644
--- a/arch/x86/lib/atomic64_cx8_32.S
+++ b/arch/x86/lib/atomic64_cx8_32.S
@@ -6,7 +6,7 @@
  */
 
 #include <linux/linkage.h>
-#include <asm/alternative-asm.h>
+#include <asm/alternative.h>
 
 .macro read64 reg
 	movl %ebx, %eax
diff --git a/arch/x86/lib/copy_page_64.S b/arch/x86/lib/copy_page_64.S
index 2402d4c..db4b4f9 100644
--- a/arch/x86/lib/copy_page_64.S
+++ b/arch/x86/lib/copy_page_64.S
@@ -3,7 +3,7 @@
 
 #include <linux/linkage.h>
 #include <asm/cpufeatures.h>
-#include <asm/alternative-asm.h>
+#include <asm/alternative.h>
 #include <asm/export.h>
 
 /*
diff --git a/arch/x86/lib/copy_user_64.S b/arch/x86/lib/copy_user_64.S
index 77b9b2a..57b79c5 100644
--- a/arch/x86/lib/copy_user_64.S
+++ b/arch/x86/lib/copy_user_64.S
@@ -11,7 +11,7 @@
 #include <asm/asm-offsets.h>
 #include <asm/thread_info.h>
 #include <asm/cpufeatures.h>
-#include <asm/alternative-asm.h>
+#include <asm/alternative.h>
 #include <asm/asm.h>
 #include <asm/smap.h>
 #include <asm/export.h>
diff --git a/arch/x86/lib/memcpy_64.S b/arch/x86/lib/memcpy_64.S
index 1e299ac..1cc9da6 100644
--- a/arch/x86/lib/memcpy_64.S
+++ b/arch/x86/lib/memcpy_64.S
@@ -4,7 +4,7 @@
 #include <linux/linkage.h>
 #include <asm/errno.h>
 #include <asm/cpufeatures.h>
-#include <asm/alternative-asm.h>
+#include <asm/alternative.h>
 #include <asm/export.h>
 
 .pushsection .noinstr.text, "ax"
diff --git a/arch/x86/lib/memmove_64.S b/arch/x86/lib/memmove_64.S
index 41902fe..6480101 100644
--- a/arch/x86/lib/memmove_64.S
+++ b/arch/x86/lib/memmove_64.S
@@ -8,7 +8,7 @@
  */
 #include <linux/linkage.h>
 #include <asm/cpufeatures.h>
-#include <asm/alternative-asm.h>
+#include <asm/alternative.h>
 #include <asm/export.h>
 
 #undef memmove
diff --git a/arch/x86/lib/memset_64.S b/arch/x86/lib/memset_64.S
index 0bfd26e..9827ae2 100644
--- a/arch/x86/lib/memset_64.S
+++ b/arch/x86/lib/memset_64.S
@@ -3,7 +3,7 @@
 
 #include <linux/linkage.h>
 #include <asm/cpufeatures.h>
-#include <asm/alternative-asm.h>
+#include <asm/alternative.h>
 #include <asm/export.h>
 
 /*
diff --git a/arch/x86/lib/retpoline.S b/arch/x86/lib/retpoline.S
index f6fb1d2..6bb74b5 100644
--- a/arch/x86/lib/retpoline.S
+++ b/arch/x86/lib/retpoline.S
@@ -4,7 +4,7 @@
 #include <linux/linkage.h>
 #include <asm/dwarf2.h>
 #include <asm/cpufeatures.h>
-#include <asm/alternative-asm.h>
+#include <asm/alternative.h>
 #include <asm/export.h>
 #include <asm/nospec-branch.h>
 #include <asm/unwind_hints.h>
