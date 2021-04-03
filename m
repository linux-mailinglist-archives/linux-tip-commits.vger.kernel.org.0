Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B83235339D
	for <lists+linux-tip-commits@lfdr.de>; Sat,  3 Apr 2021 13:12:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236727AbhDCLLJ (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Sat, 3 Apr 2021 07:11:09 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:42366 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236660AbhDCLLD (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Sat, 3 Apr 2021 07:11:03 -0400
Date:   Sat, 03 Apr 2021 11:10:59 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1617448260;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=McbOLVRV1xUmkdfnxYzhe7yBe9YxX5se2PkduhwWvgs=;
        b=etQeK30W4ZltKicEehpsvs8NQ6Ayq74Pk6EZCHRW4A6R5/kZzkpVMPJ8qHN1AtzayXN5C2
        qLJViCJVVaSGhNnYdhzFysN7MYaDgcE0+Tz7Ro8R4drigPhzCZOZHp5i+bsGuz6u3zZJgB
        zC15Mk3fYeBn8L31Z84eQL7QRuNYowas5FlisCwiQGq3O0ukSNBucdyuLkY+slBtiR9dnt
        tT3rKU30OZjkjtUL2xPIdFllx+NxqNiZPzKlPsSpoGC+bDrZBMLUxJ8RijR5MfQ6GV8SXa
        LNwdXYILT1fBrM70LaRFegqj4b8j82pbSG83JvJjis5xG0lPXkI+jKUXx69B2g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1617448260;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=McbOLVRV1xUmkdfnxYzhe7yBe9YxX5se2PkduhwWvgs=;
        b=SShTc2e4udjSALj/ZnU650bapG5UjWg9ITWkXO2eBFZvkTsFoGGzynlhLy/uIJxdlA42hI
        ibF58VhPqHYkvnDA==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/core] x86/retpoline: Simplify retpolines
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Borislav Petkov <bp@suse.de>, Ingo Molnar <mingo@kernel.org>,
        x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20210326151259.506071949@infradead.org>
References: <20210326151259.506071949@infradead.org>
MIME-Version: 1.0
Message-ID: <161744825969.29796.5634030362499829701.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/core branch of tip:

Commit-ID:     119251855f9adf9421cb5eb409933092141ab2c7
Gitweb:        https://git.kernel.org/tip/119251855f9adf9421cb5eb409933092141ab2c7
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Fri, 26 Mar 2021 16:12:02 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Fri, 02 Apr 2021 12:42:04 +02:00

x86/retpoline: Simplify retpolines

Due to:

  c9c324dc22aa ("objtool: Support stack layout changes in alternatives")

it is now possible to simplify the retpolines.

Currently our retpolines consist of 2 symbols:

 - __x86_indirect_thunk_\reg: the compiler target
 - __x86_retpoline_\reg:  the actual retpoline.

Both are consecutive in code and aligned such that for any one register
they both live in the same cacheline:

  0000000000000000 <__x86_indirect_thunk_rax>:
   0:   ff e0                   jmpq   *%rax
   2:   90                      nop
   3:   90                      nop
   4:   90                      nop

  0000000000000005 <__x86_retpoline_rax>:
   5:   e8 07 00 00 00          callq  11 <__x86_retpoline_rax+0xc>
   a:   f3 90                   pause
   c:   0f ae e8                lfence
   f:   eb f9                   jmp    a <__x86_retpoline_rax+0x5>
  11:   48 89 04 24             mov    %rax,(%rsp)
  15:   c3                      retq
  16:   66 2e 0f 1f 84 00 00 00 00 00   nopw   %cs:0x0(%rax,%rax,1)

The thunk is an alternative_2, where one option is a JMP to the
retpoline. This was done so that objtool didn't need to deal with
alternatives with stack ops. But that problem has been solved, so now
it is possible to fold the entire retpoline into the alternative to
simplify and consolidate unused bytes:

  0000000000000000 <__x86_indirect_thunk_rax>:
   0:   ff e0                   jmpq   *%rax
   2:   90                      nop
   3:   90                      nop
   4:   90                      nop
   5:   90                      nop
   6:   90                      nop
   7:   90                      nop
   8:   90                      nop
   9:   90                      nop
   a:   90                      nop
   b:   90                      nop
   c:   90                      nop
   d:   90                      nop
   e:   90                      nop
   f:   90                      nop
  10:   90                      nop
  11:   66 66 2e 0f 1f 84 00 00 00 00 00        data16 nopw %cs:0x0(%rax,%rax,1)
  1c:   0f 1f 40 00             nopl   0x0(%rax)

Notice that since the longest alternative sequence is now:

   0:   e8 07 00 00 00          callq  c <.altinstr_replacement+0xc>
   5:   f3 90                   pause
   7:   0f ae e8                lfence
   a:   eb f9                   jmp    5 <.altinstr_replacement+0x5>
   c:   48 89 04 24             mov    %rax,(%rsp)
  10:   c3                      retq

17 bytes, we have 15 bytes NOP at the end of our 32 byte slot. (IOW, if
we can shrink the retpoline by 1 byte we can pack it more densely).

 [ bp: Massage commit message. ]

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Borislav Petkov <bp@suse.de>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lkml.kernel.org/r/20210326151259.506071949@infradead.org
---
 arch/x86/include/asm/asm-prototypes.h |  7 +-----
 arch/x86/include/asm/nospec-branch.h  |  6 ++---
 arch/x86/lib/retpoline.S              | 34 +++++++++++++-------------
 tools/objtool/check.c                 |  3 +--
 4 files changed, 21 insertions(+), 29 deletions(-)

diff --git a/arch/x86/include/asm/asm-prototypes.h b/arch/x86/include/asm/asm-prototypes.h
index 51e2bf2..0545b07 100644
--- a/arch/x86/include/asm/asm-prototypes.h
+++ b/arch/x86/include/asm/asm-prototypes.h
@@ -22,15 +22,8 @@ extern void cmpxchg8b_emu(void);
 #define DECL_INDIRECT_THUNK(reg) \
 	extern asmlinkage void __x86_indirect_thunk_ ## reg (void);
 
-#define DECL_RETPOLINE(reg) \
-	extern asmlinkage void __x86_retpoline_ ## reg (void);
-
 #undef GEN
 #define GEN(reg) DECL_INDIRECT_THUNK(reg)
 #include <asm/GEN-for-each-reg.h>
 
-#undef GEN
-#define GEN(reg) DECL_RETPOLINE(reg)
-#include <asm/GEN-for-each-reg.h>
-
 #endif /* CONFIG_RETPOLINE */
diff --git a/arch/x86/include/asm/nospec-branch.h b/arch/x86/include/asm/nospec-branch.h
index 529f8e9..664be73 100644
--- a/arch/x86/include/asm/nospec-branch.h
+++ b/arch/x86/include/asm/nospec-branch.h
@@ -80,7 +80,7 @@
 .macro JMP_NOSPEC reg:req
 #ifdef CONFIG_RETPOLINE
 	ALTERNATIVE_2 __stringify(ANNOTATE_RETPOLINE_SAFE; jmp *%\reg), \
-		      __stringify(jmp __x86_retpoline_\reg), X86_FEATURE_RETPOLINE, \
+		      __stringify(jmp __x86_indirect_thunk_\reg), X86_FEATURE_RETPOLINE, \
 		      __stringify(lfence; ANNOTATE_RETPOLINE_SAFE; jmp *%\reg), X86_FEATURE_RETPOLINE_AMD
 #else
 	jmp	*%\reg
@@ -90,7 +90,7 @@
 .macro CALL_NOSPEC reg:req
 #ifdef CONFIG_RETPOLINE
 	ALTERNATIVE_2 __stringify(ANNOTATE_RETPOLINE_SAFE; call *%\reg), \
-		      __stringify(call __x86_retpoline_\reg), X86_FEATURE_RETPOLINE, \
+		      __stringify(call __x86_indirect_thunk_\reg), X86_FEATURE_RETPOLINE, \
 		      __stringify(lfence; ANNOTATE_RETPOLINE_SAFE; call *%\reg), X86_FEATURE_RETPOLINE_AMD
 #else
 	call	*%\reg
@@ -128,7 +128,7 @@
 	ALTERNATIVE_2(						\
 	ANNOTATE_RETPOLINE_SAFE					\
 	"call *%[thunk_target]\n",				\
-	"call __x86_retpoline_%V[thunk_target]\n",		\
+	"call __x86_indirect_thunk_%V[thunk_target]\n",		\
 	X86_FEATURE_RETPOLINE,					\
 	"lfence;\n"						\
 	ANNOTATE_RETPOLINE_SAFE					\
diff --git a/arch/x86/lib/retpoline.S b/arch/x86/lib/retpoline.S
index 6bb74b5..d2c0d14 100644
--- a/arch/x86/lib/retpoline.S
+++ b/arch/x86/lib/retpoline.S
@@ -10,27 +10,31 @@
 #include <asm/unwind_hints.h>
 #include <asm/frame.h>
 
-.macro THUNK reg
-	.section .text.__x86.indirect_thunk
-
-	.align 32
-SYM_FUNC_START(__x86_indirect_thunk_\reg)
-	JMP_NOSPEC \reg
-SYM_FUNC_END(__x86_indirect_thunk_\reg)
-
-SYM_FUNC_START_NOALIGN(__x86_retpoline_\reg)
+.macro RETPOLINE reg
 	ANNOTATE_INTRA_FUNCTION_CALL
-	call	.Ldo_rop_\@
+	call    .Ldo_rop_\@
 .Lspec_trap_\@:
 	UNWIND_HINT_EMPTY
 	pause
 	lfence
-	jmp	.Lspec_trap_\@
+	jmp .Lspec_trap_\@
 .Ldo_rop_\@:
-	mov	%\reg, (%_ASM_SP)
+	mov     %\reg, (%_ASM_SP)
 	UNWIND_HINT_FUNC
 	ret
-SYM_FUNC_END(__x86_retpoline_\reg)
+.endm
+
+.macro THUNK reg
+	.section .text.__x86.indirect_thunk
+
+	.align 32
+SYM_FUNC_START(__x86_indirect_thunk_\reg)
+
+	ALTERNATIVE_2 __stringify(ANNOTATE_RETPOLINE_SAFE; jmp *%\reg), \
+		      __stringify(RETPOLINE \reg), X86_FEATURE_RETPOLINE, \
+		      __stringify(lfence; ANNOTATE_RETPOLINE_SAFE; jmp *%\reg), X86_FEATURE_RETPOLINE_AMD
+
+SYM_FUNC_END(__x86_indirect_thunk_\reg)
 
 .endm
 
@@ -48,7 +52,6 @@ SYM_FUNC_END(__x86_retpoline_\reg)
 
 #define __EXPORT_THUNK(sym)	_ASM_NOKPROBE(sym); EXPORT_SYMBOL(sym)
 #define EXPORT_THUNK(reg)	__EXPORT_THUNK(__x86_indirect_thunk_ ## reg)
-#define EXPORT_RETPOLINE(reg)  __EXPORT_THUNK(__x86_retpoline_ ## reg)
 
 #undef GEN
 #define GEN(reg) THUNK reg
@@ -58,6 +61,3 @@ SYM_FUNC_END(__x86_retpoline_\reg)
 #define GEN(reg) EXPORT_THUNK(reg)
 #include <asm/GEN-for-each-reg.h>
 
-#undef GEN
-#define GEN(reg) EXPORT_RETPOLINE(reg)
-#include <asm/GEN-for-each-reg.h>
diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index 5e5388a..d45f018 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -872,8 +872,7 @@ static int add_jump_destinations(struct objtool_file *file)
 		} else if (reloc->sym->type == STT_SECTION) {
 			dest_sec = reloc->sym->sec;
 			dest_off = arch_dest_reloc_offset(reloc->addend);
-		} else if (!strncmp(reloc->sym->name, "__x86_indirect_thunk_", 21) ||
-			   !strncmp(reloc->sym->name, "__x86_retpoline_", 16)) {
+		} else if (!strncmp(reloc->sym->name, "__x86_indirect_thunk_", 21)) {
 			/*
 			 * Retpoline jumps are really dynamic jumps in
 			 * disguise, so convert them accordingly.
