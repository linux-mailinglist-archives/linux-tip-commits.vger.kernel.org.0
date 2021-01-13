Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DAFB82F4ABC
	for <lists+linux-tip-commits@lfdr.de>; Wed, 13 Jan 2021 12:57:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726593AbhAMLxS (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 13 Jan 2021 06:53:18 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:52098 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727122AbhAMLxS (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 13 Jan 2021 06:53:18 -0500
Date:   Wed, 13 Jan 2021 11:52:34 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1610538755;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9SPAg+zkLT3zMZabm6nzRd0dPxO1o/euEhXbv7r6WE4=;
        b=pl1jeaM2jOF54eBDkte8hL/3VAiZC/PArsQGUiXopf6WDtCjQxByROlhlg5OFkafqKjxYM
        J8LsHx/aLMW7LqkZtUY3s1dDB8ptVKv5IK/re1Ko4hq/5JIn+9HIK53gK+zSp4ycHEPlEN
        bR2YSvhn1dVs7n6wz7Y+ish7L4H9pCPOF1DTqIbn2N5jgTFTsvcZD0SrrkVtr/VuEDwjTE
        lMbtbYgs7yUZtEA17i0p+8zcOrlqplis+5yiL8Vrl1a88/Yqi+Ui2eQ6iiXNHhJgMorqN+
        OzLBCj6TpLdb1CLm7PXYmtjqsN10ANPGiYkTZUbDVW3TQgvZzeEI8XnVkfrolw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1610538755;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9SPAg+zkLT3zMZabm6nzRd0dPxO1o/euEhXbv7r6WE4=;
        b=kcM4vA0wLC3C+BkIbbz0Wer6Gm5Bx+MjJ08Uae00cr0SNCuP9ED3uPIgYDDz99aWZKTXq4
        Xhsl86dTRUfMA6AA==
From:   "tip-bot2 for Nick Desaulniers" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/entry] x86/entry: Emit a symbol for register restoring thunk
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Borislav Petkov <bp@suse.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210112194625.4181814-1-ndesaulniers@google.com>
References: <20210112194625.4181814-1-ndesaulniers@google.com>
MIME-Version: 1.0
Message-ID: <161053875473.414.57133209689816752.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/entry branch of tip:

Commit-ID:     bde718b7e154afc99e1956b18a848401ce8e1f8e
Gitweb:        https://git.kernel.org/tip/bde718b7e154afc99e1956b18a848401ce8e1f8e
Author:        Nick Desaulniers <ndesaulniers@google.com>
AuthorDate:    Tue, 12 Jan 2021 11:46:24 -08:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Wed, 13 Jan 2021 12:23:57 +01:00

x86/entry: Emit a symbol for register restoring thunk

Arnd found a randconfig that produces the warning:

  arch/x86/entry/thunk_64.o: warning: objtool: missing symbol for insn at
  offset 0x3e

when building with LLVM_IAS=1 (Clang's integrated assembler). Josh
notes:

  With the LLVM assembler not generating section symbols, objtool has no
  way to reference this code when it generates ORC unwinder entries,
  because this code is outside of any ELF function.

  The limitation now being imposed by objtool is that all code must be
  contained in an ELF symbol.  And .L symbols don't create such symbols.

  So basically, you can use an .L symbol *inside* a function or a code
  segment, you just can't use the .L symbol to contain the code using a
  SYM_*_START/END annotation pair.

Fangrui notes that this optimization is helpful for reducing image size
when compiling with -ffunction-sections and -fdata-sections. I have
observed on the order of tens of thousands of symbols for the kernel
images built with those flags.

A patch has been authored against GNU binutils to match this behavior
of not generating unused section symbols ([1]), so this will
also become a problem for users of GNU binutils once they upgrade to 2.36.

Omit the .L prefix on a label so that the assembler will emit an entry
into the symbol table for the label, with STB_LOCAL binding. This
enables objtool to generate proper unwind info here with LLVM_IAS=1 or
GNU binutils 2.36+.

 [ bp: Massage commit message. ]

Reported-by: Arnd Bergmann <arnd@arndb.de>
Suggested-by: Josh Poimboeuf <jpoimboe@redhat.com>
Suggested-by: Borislav Petkov <bp@alien8.de>
Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lkml.kernel.org/r/20210112194625.4181814-1-ndesaulniers@google.com
Link: https://github.com/ClangBuiltLinux/linux/issues/1209
Link: https://reviews.llvm.org/D93783
Link: https://sourceware.org/binutils/docs/as/Symbol-Names.html
Link: https://sourceware.org/git/?p=binutils-gdb.git;a=commit;h=d1bcae833b32f1408485ce69f844dcd7ded093a8 [1]
---
 Documentation/asm-annotations.rst |  9 +++++++++
 arch/x86/entry/thunk_64.S         |  8 ++++----
 include/linux/linkage.h           |  5 ++++-
 3 files changed, 17 insertions(+), 5 deletions(-)

diff --git a/Documentation/asm-annotations.rst b/Documentation/asm-annotations.rst
index 32ea574..e711ff9 100644
--- a/Documentation/asm-annotations.rst
+++ b/Documentation/asm-annotations.rst
@@ -153,6 +153,15 @@ This section covers ``SYM_FUNC_*`` and ``SYM_CODE_*`` enumerated above.
   To some extent, this category corresponds to deprecated ``ENTRY`` and
   ``END``. Except ``END`` had several other meanings too.
 
+  Developers should avoid using local symbol names that are prefixed with
+  ``.L``, as this has special meaning for the assembler; a symbol entry will
+  not be emitted into the symbol table. This can prevent ``objtool`` from
+  generating correct unwind info. Symbols with STB_LOCAL binding may still be
+  used, and ``.L`` prefixed local symbol names are still generally useable
+  within a function, but ``.L`` prefixed local symbol names should not be used
+  to denote the beginning or end of code regions via
+  ``SYM_CODE_START_LOCAL``/``SYM_CODE_END``.
+
 * ``SYM_INNER_LABEL*`` is used to denote a label inside some
   ``SYM_{CODE,FUNC}_START`` and ``SYM_{CODE,FUNC}_END``.  They are very similar
   to C labels, except they can be made global. An example of use::
diff --git a/arch/x86/entry/thunk_64.S b/arch/x86/entry/thunk_64.S
index ccd3287..c9a9fbf 100644
--- a/arch/x86/entry/thunk_64.S
+++ b/arch/x86/entry/thunk_64.S
@@ -31,7 +31,7 @@ SYM_FUNC_START_NOALIGN(\name)
 	.endif
 
 	call \func
-	jmp  .L_restore
+	jmp  __thunk_restore
 SYM_FUNC_END(\name)
 	_ASM_NOKPROBE(\name)
 	.endm
@@ -44,7 +44,7 @@ SYM_FUNC_END(\name)
 #endif
 
 #ifdef CONFIG_PREEMPTION
-SYM_CODE_START_LOCAL_NOALIGN(.L_restore)
+SYM_CODE_START_LOCAL_NOALIGN(__thunk_restore)
 	popq %r11
 	popq %r10
 	popq %r9
@@ -56,6 +56,6 @@ SYM_CODE_START_LOCAL_NOALIGN(.L_restore)
 	popq %rdi
 	popq %rbp
 	ret
-	_ASM_NOKPROBE(.L_restore)
-SYM_CODE_END(.L_restore)
+	_ASM_NOKPROBE(__thunk_restore)
+SYM_CODE_END(__thunk_restore)
 #endif
diff --git a/include/linux/linkage.h b/include/linux/linkage.h
index 5bcfbd9..11537ba 100644
--- a/include/linux/linkage.h
+++ b/include/linux/linkage.h
@@ -270,7 +270,10 @@
 	SYM_END(name, SYM_T_FUNC)
 #endif
 
-/* SYM_CODE_START -- use for non-C (special) functions */
+/*
+ * SYM_CODE_START -- use for non-C (special) functions, avoid .L prefixed local
+ * symbol names which may not emit a symbol table entry.
+ */
 #ifndef SYM_CODE_START
 #define SYM_CODE_START(name)				\
 	SYM_START(name, SYM_L_GLOBAL, SYM_A_ALIGN)
