Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DEA882FBDEC
	for <lists+linux-tip-commits@lfdr.de>; Tue, 19 Jan 2021 18:44:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387681AbhASOsC (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Tue, 19 Jan 2021 09:48:02 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:33728 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389676AbhASKOe (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Tue, 19 Jan 2021 05:14:34 -0500
Date:   Tue, 19 Jan 2021 10:12:43 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1611051164;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=39MTs0/AkU91NCzyrxDCYO5z9+AjlVQGidsTvcEiDHM=;
        b=xfEtEAnFyy+vg8kCU0kw4nvrZuxeGzc26mO1ZJU2bs9voiQtNx8R5Yb5zhbeZbnPSF5f/y
        Ijxe5egyTR9fPhqosjsV7pPOv+6ZttYIEDJVHk9DQtlXfM74As3Za8I32WXfOthpnofZM4
        ChUW8iBVs5I74Xx2qLqhE4rsy4+L+GsGlAMhfn1rBJRFaAgVZU6u6MRM4sIFNqvPgvhDIt
        lj2/6QcQyw1ggOLOCn0s2o/FcgzPh74zJKZzic1TdZ3WRUXEa34p4AYZTdRxG2En7n1oH8
        NoMjA8rep72Qn6jPSLvQxyzYDCeqLq1KeVBNPyi9Rd6h7oh8Yp84arkrixv0Fg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1611051164;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=39MTs0/AkU91NCzyrxDCYO5z9+AjlVQGidsTvcEiDHM=;
        b=CwQ2Ow6NhFnWP7KNxxt1jA5m3PFzVnqdgJ5x2DZ+RR7E0VGOieYKmD7By9oYd/umsg6wIZ
        3BsgmOuw5t5iIMBA==
From:   "tip-bot2 for Nick Desaulniers" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/entry] x86/entry: Emit a symbol for register restoring thunk
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        Mark Brown <broonie@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Borislav Petkov <bp@suse.de>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210112194625.4181814-1-ndesaulniers@google.com>
References: <20210112194625.4181814-1-ndesaulniers@google.com>
MIME-Version: 1.0
Message-ID: <161105116375.414.15930533850412363220.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/entry branch of tip:

Commit-ID:     5e6dca82bcaa49348f9e5fcb48df4881f6d6c4ae
Gitweb:        https://git.kernel.org/tip/5e6dca82bcaa49348f9e5fcb48df4881f6d6c4ae
Author:        Nick Desaulniers <ndesaulniers@google.com>
AuthorDate:    Tue, 12 Jan 2021 11:46:24 -08:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Thu, 14 Jan 2021 17:18:25 +01:00

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
Suggested-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Josh Poimboeuf <jpoimboe@redhat.com>
Link: https://lkml.kernel.org/r/20210112194625.4181814-1-ndesaulniers@google.com
Link: https://github.com/ClangBuiltLinux/linux/issues/1209
Link: https://reviews.llvm.org/D93783
Link: https://sourceware.org/binutils/docs/as/Symbol-Names.html
Link: https://sourceware.org/git/?p=binutils-gdb.git;a=commit;h=d1bcae833b32f1408485ce69f844dcd7ded093a8 [1]
---
 Documentation/asm-annotations.rst | 5 +++++
 arch/x86/entry/thunk_64.S         | 8 ++++----
 include/linux/linkage.h           | 5 +++++
 3 files changed, 14 insertions(+), 4 deletions(-)

diff --git a/Documentation/asm-annotations.rst b/Documentation/asm-annotations.rst
index 32ea574..76424e0 100644
--- a/Documentation/asm-annotations.rst
+++ b/Documentation/asm-annotations.rst
@@ -100,6 +100,11 @@ Instruction Macros
 ~~~~~~~~~~~~~~~~~~
 This section covers ``SYM_FUNC_*`` and ``SYM_CODE_*`` enumerated above.
 
+``objtool`` requires that all code must be contained in an ELF symbol. Symbol
+names that have a ``.L`` prefix do not emit symbol table entries. ``.L``
+prefixed symbols can be used within a code region, but should be avoided for
+denoting a range of code via ``SYM_*_START/END`` annotations.
+
 * ``SYM_FUNC_START`` and ``SYM_FUNC_START_LOCAL`` are supposed to be **the
   most frequent markings**. They are used for functions with standard calling
   conventions -- global and local. Like in C, they both align the functions to
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
index 5bcfbd9..dbf8506 100644
--- a/include/linux/linkage.h
+++ b/include/linux/linkage.h
@@ -178,6 +178,11 @@
  * Objtool generates debug info for both FUNC & CODE, but needs special
  * annotations for each CODE's start (to describe the actual stack frame).
  *
+ * Objtool requires that all code must be contained in an ELF symbol. Symbol
+ * names that have a  .L prefix do not emit symbol table entries. .L
+ * prefixed symbols can be used within a code region, but should be avoided for
+ * denoting a range of code via ``SYM_*_START/END`` annotations.
+ *
  * ALIAS -- does not generate debug info -- the aliased function will
  */
 
