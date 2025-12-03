Return-Path: <linux-tip-commits+bounces-7605-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D7F2ACA1254
	for <lists+linux-tip-commits@lfdr.de>; Wed, 03 Dec 2025 19:48:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 1BC5F3002E8A
	for <lists+linux-tip-commits@lfdr.de>; Wed,  3 Dec 2025 18:48:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DC2A3254B1;
	Wed,  3 Dec 2025 18:48:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="E6WYpNDw";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="wgNpjSGY"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14DB0314B8A;
	Wed,  3 Dec 2025 18:48:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764787733; cv=none; b=IzdGNK4rTAahTt6jAQiRfqhDuG0SWEP6NKtWhrgYSjL9EshaW6tN6E2+vo93DzcAQfJ5+Seid46IjmemCBe6qlCWLYNEE7TodjTkh/rtQu+2OIvrSFwAvnHga/zp9BmxZTWY7FLPWJ79UPJFun8j3lQ13Xe3xq0s7+RLxvST1wY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764787733; c=relaxed/simple;
	bh=Cyl1p+jNzGKXkQkTrG3VERBPsjRVYii06M4e9ZkRbTA=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=fEEADvnims2wigWor4CqX3Pcuf8pPTzQa9+KGOP+kr/3mDRReSoauZ3uwjp49KCeXU3+a/jnC1zzBJ87pD8Ar4RQNK9SeQvrB6ZWUpnIe32rGbT7JA9YNsft5VcfSqn8Pgm9vy6MZ1uiWkBeu0iy/3NGz0YswRkmx6zY9+NtGKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=E6WYpNDw; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=wgNpjSGY; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 03 Dec 2025 18:48:48 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1764787729;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=D2c28wOqJzVE9YOsRfS8C2Ifjr96S6S/FZ5QEHjiDcU=;
	b=E6WYpNDwlTTu4lAGPmGlqt2BxcpvtJdvcWLXba3ACI3RxmniK39d254+T1qUBr0xfWcV67
	FnRMvA8dz5GiSk+scGia4MCAGWlj0juo+sIvbebKov88a829PspWdSMLuzL1dzQL4TaiZg
	nqa6Uk4Yle4EDLTEoLp1X3jLwncXwa+MquPq1176ScLawoAc5qkXcDgqXo8p4QR9BA+VBz
	pl34+70Xw52cwGARtf9fPbvghidb2eE5ubuhcKou0MItDhdnsElPCYxcpfM2BOUiOmLrmL
	6uyrUZX8Q1V3a6rPA7Akscc5ATI6zecOUzQlvoB7EdVNGjBZHDg3j17gauKf4g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1764787729;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=D2c28wOqJzVE9YOsRfS8C2Ifjr96S6S/FZ5QEHjiDcU=;
	b=wgNpjSGYDRsS1iGLq+FNf2vVEpI3ZkVku9PC8yNBV1jMRpq20qPkPLM58cjY0rtIlM0Vmf
	OVQ/XWg1qFUkJtCw==
From: "tip-bot2 for Josh Poimboeuf" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: objtool/urgent] objtool: Remove newlines and tabs from
 annotation macros
Cc: Josh Poimboeuf <jpoimboe@kernel.org>, Ingo Molnar <mingo@kernel.org>,
 Linus Torvalds <torvalds@linux-foundation.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To:
 <66305834c2eb78f082217611b756231ae9c0b555.1764694625.git.jpoimboe@kernel.org>
References:
 <66305834c2eb78f082217611b756231ae9c0b555.1764694625.git.jpoimboe@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176478772801.498.3556240303690170673.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the objtool/urgent branch of tip:

Commit-ID:     ed3bf863dc9150b56233b01ec073cbbd1fc9c6a3
Gitweb:        https://git.kernel.org/tip/ed3bf863dc9150b56233b01ec073cbbd1fc=
9c6a3
Author:        Josh Poimboeuf <jpoimboe@kernel.org>
AuthorDate:    Tue, 02 Dec 2025 09:59:39 -08:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Wed, 03 Dec 2025 19:42:37 +01:00

objtool: Remove newlines and tabs from annotation macros

Remove newlines and tabs from the annotation macros so the invoking code
can insert them as needed to match the style of the surrounding code.

Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Link: https://patch.msgid.link/66305834c2eb78f082217611b756231ae9c0b555.17646=
94625.git.jpoimboe@kernel.org
---
 arch/x86/include/asm/alternative.h    | 2 +-
 arch/x86/include/asm/bug.h            | 2 +-
 arch/x86/include/asm/cpufeature.h     | 2 +-
 arch/x86/include/asm/irq_stack.h      | 2 +-
 arch/x86/include/asm/jump_label.h     | 2 +-
 arch/x86/include/asm/nospec-branch.h  | 4 ++--
 arch/x86/include/asm/paravirt_types.h | 2 +-
 arch/x86/include/asm/smap.h           | 8 ++++----
 arch/x86/include/asm/static_call.h    | 2 +-
 arch/x86/kernel/alternative.c         | 4 ++--
 arch/x86/kernel/rethook.c             | 2 +-
 arch/x86/kernel/static_call.c         | 4 ++--
 arch/x86/lib/error-inject.c           | 2 +-
 include/linux/annotate.h              | 6 +++---
 include/linux/objtool.h               | 2 +-
 15 files changed, 23 insertions(+), 23 deletions(-)

diff --git a/arch/x86/include/asm/alternative.h b/arch/x86/include/asm/altern=
ative.h
index df2c870..0336451 100644
--- a/arch/x86/include/asm/alternative.h
+++ b/arch/x86/include/asm/alternative.h
@@ -208,7 +208,7 @@ static inline int alternatives_text_reserved(void *start,=
 void *end)
=20
 #define ALTINSTR_REPLACEMENT(newinstr)		/* replacement */	\
 	".pushsection .altinstr_replacement, \"ax\"\n"			\
-	ANNOTATE_DATA_SPECIAL						\
+	ANNOTATE_DATA_SPECIAL "\n"					\
 	"# ALT: replacement\n"						\
 	"774:\n\t" newinstr "\n775:\n"					\
 	".popsection\n"
diff --git a/arch/x86/include/asm/bug.h b/arch/x86/include/asm/bug.h
index ab5bba6..ee23b98 100644
--- a/arch/x86/include/asm/bug.h
+++ b/arch/x86/include/asm/bug.h
@@ -70,7 +70,7 @@ extern void __WARN_trap(struct bug_entry *bug, ...);
=20
 #define _BUG_FLAGS_ASM(format, file, line, flags, size, extra)		\
 	".pushsection __bug_table,\"aw\"\n\t"				\
-	ANNOTATE_DATA_SPECIAL						\
+	ANNOTATE_DATA_SPECIAL "\n\t"					\
 	"2:\n\t"							\
 	__BUG_ENTRY(format, file, line, flags)				\
 	"\t.org 2b + " size "\n"					\
diff --git a/arch/x86/include/asm/cpufeature.h b/arch/x86/include/asm/cpufeat=
ure.h
index fc5f32d..d8bc614 100644
--- a/arch/x86/include/asm/cpufeature.h
+++ b/arch/x86/include/asm/cpufeature.h
@@ -101,7 +101,7 @@ static __always_inline bool _static_cpu_has(u16 bit)
 	asm goto(ALTERNATIVE_TERNARY("jmp 6f", %c[feature], "", "jmp %l[t_no]")
 		".pushsection .altinstr_aux,\"ax\"\n"
 		"6:\n"
-		ANNOTATE_DATA_SPECIAL
+		ANNOTATE_DATA_SPECIAL "\n"
 		" testb %[bitnum], %a[cap_byte]\n"
 		" jnz %l[t_yes]\n"
 		" jmp %l[t_no]\n"
diff --git a/arch/x86/include/asm/irq_stack.h b/arch/x86/include/asm/irq_stac=
k.h
index 735c3a4..8325b79 100644
--- a/arch/x86/include/asm/irq_stack.h
+++ b/arch/x86/include/asm/irq_stack.h
@@ -101,7 +101,7 @@
=20
 #define ASM_CALL_ARG0							\
 	"1: call %c[__func]				\n"		\
-	ANNOTATE_REACHABLE(1b)
+	ANNOTATE_REACHABLE(1b) "			\n"
=20
 #define ASM_CALL_ARG1							\
 	"movq	%[arg1], %%rdi				\n"		\
diff --git a/arch/x86/include/asm/jump_label.h b/arch/x86/include/asm/jump_la=
bel.h
index e0a6930..05b1629 100644
--- a/arch/x86/include/asm/jump_label.h
+++ b/arch/x86/include/asm/jump_label.h
@@ -15,7 +15,7 @@
 #define JUMP_TABLE_ENTRY(key, label)			\
 	".pushsection __jump_table,  \"aw\" \n\t"	\
 	_ASM_ALIGN "\n\t"				\
-	ANNOTATE_DATA_SPECIAL				\
+	ANNOTATE_DATA_SPECIAL "\n"			\
 	".long 1b - . \n\t"				\
 	".long " label " - . \n\t"			\
 	_ASM_PTR " " key " - . \n\t"			\
diff --git a/arch/x86/include/asm/nospec-branch.h b/arch/x86/include/asm/nosp=
ec-branch.h
index 08ed5a2..a5d41d8 100644
--- a/arch/x86/include/asm/nospec-branch.h
+++ b/arch/x86/include/asm/nospec-branch.h
@@ -464,7 +464,7 @@ static inline void call_depth_return_thunk(void) {}
  */
 # define CALL_NOSPEC						\
 	ALTERNATIVE_2(						\
-	ANNOTATE_RETPOLINE_SAFE					\
+	ANNOTATE_RETPOLINE_SAFE "\n"				\
 	"call *%[thunk_target]\n",				\
 	"       jmp    904f;\n"					\
 	"       .align 16\n"					\
@@ -480,7 +480,7 @@ static inline void call_depth_return_thunk(void) {}
 	"904:	call   901b;\n",				\
 	X86_FEATURE_RETPOLINE,					\
 	"lfence;\n"						\
-	ANNOTATE_RETPOLINE_SAFE					\
+	ANNOTATE_RETPOLINE_SAFE "\n"				\
 	"call *%[thunk_target]\n",				\
 	X86_FEATURE_RETPOLINE_LFENCE)
=20
diff --git a/arch/x86/include/asm/paravirt_types.h b/arch/x86/include/asm/par=
avirt_types.h
index 37a8627..3502939 100644
--- a/arch/x86/include/asm/paravirt_types.h
+++ b/arch/x86/include/asm/paravirt_types.h
@@ -249,7 +249,7 @@ extern struct paravirt_patch_template pv_ops;
  * don't need to bother with CFI prefixes.
  */
 #define PARAVIRT_CALL					\
-	ANNOTATE_RETPOLINE_SAFE				\
+	ANNOTATE_RETPOLINE_SAFE "\n\t"			\
 	"call *%[paravirt_opptr];"
=20
 /*
diff --git a/arch/x86/include/asm/smap.h b/arch/x86/include/asm/smap.h
index 4f84d42..cd173fa 100644
--- a/arch/x86/include/asm/smap.h
+++ b/arch/x86/include/asm/smap.h
@@ -40,7 +40,7 @@ static __always_inline unsigned long smap_save(void)
 	unsigned long flags;
=20
 	asm volatile ("# smap_save\n\t"
-		      ALTERNATIVE(ANNOTATE_IGNORE_ALTERNATIVE
+		      ALTERNATIVE(ANNOTATE_IGNORE_ALTERNATIVE "\n\t"
 				  "", "pushf; pop %0; clac",
 				  X86_FEATURE_SMAP)
 		      : "=3Drm" (flags) : : "memory", "cc");
@@ -51,7 +51,7 @@ static __always_inline unsigned long smap_save(void)
 static __always_inline void smap_restore(unsigned long flags)
 {
 	asm volatile ("# smap_restore\n\t"
-		      ALTERNATIVE(ANNOTATE_IGNORE_ALTERNATIVE
+		      ALTERNATIVE(ANNOTATE_IGNORE_ALTERNATIVE "\n\t"
 				  "", "push %0; popf",
 				  X86_FEATURE_SMAP)
 		      : : "g" (flags) : "memory", "cc");
@@ -64,9 +64,9 @@ static __always_inline void smap_restore(unsigned long flag=
s)
 	ALTERNATIVE("", "stac", X86_FEATURE_SMAP)
=20
 #define ASM_CLAC_UNSAFE \
-	ALTERNATIVE("", ANNOTATE_IGNORE_ALTERNATIVE "clac", X86_FEATURE_SMAP)
+	ALTERNATIVE("", ANNOTATE_IGNORE_ALTERNATIVE "\n\t" "clac", X86_FEATURE_SMAP)
 #define ASM_STAC_UNSAFE \
-	ALTERNATIVE("", ANNOTATE_IGNORE_ALTERNATIVE "stac", X86_FEATURE_SMAP)
+	ALTERNATIVE("", ANNOTATE_IGNORE_ALTERNATIVE "\n\t" "stac", X86_FEATURE_SMAP)
=20
 #endif /* __ASSEMBLER__ */
=20
diff --git a/arch/x86/include/asm/static_call.h b/arch/x86/include/asm/static=
_call.h
index 41502bd..4cd725a 100644
--- a/arch/x86/include/asm/static_call.h
+++ b/arch/x86/include/asm/static_call.h
@@ -36,7 +36,7 @@
 	    ".align 4						\n"	\
 	    ".globl " STATIC_CALL_TRAMP_STR(name) "		\n"	\
 	    STATIC_CALL_TRAMP_STR(name) ":			\n"	\
-	    ANNOTATE_NOENDBR						\
+	    ANNOTATE_NOENDBR "					\n"	\
 	    insns "						\n"	\
 	    ".byte 0x0f, 0xb9, 0xcc				\n"	\
 	    ".type " STATIC_CALL_TRAMP_STR(name) ", @function	\n"	\
diff --git a/arch/x86/kernel/alternative.c b/arch/x86/kernel/alternative.c
index e377b06..3bda511 100644
--- a/arch/x86/kernel/alternative.c
+++ b/arch/x86/kernel/alternative.c
@@ -2229,7 +2229,7 @@ asm (
 "	.pushsection	.init.text, \"ax\", @progbits\n"
 "	.type		int3_selftest_asm, @function\n"
 "int3_selftest_asm:\n"
-	ANNOTATE_NOENDBR
+	ANNOTATE_NOENDBR "\n"
 	/*
 	 * INT3 padded with NOP to CALL_INSN_SIZE. The INT3 triggers an
 	 * exception, then the int3_exception_nb notifier emulates a call to
@@ -2247,7 +2247,7 @@ asm (
 "	.pushsection	.init.text, \"ax\", @progbits\n"
 "	.type		int3_selftest_callee, @function\n"
 "int3_selftest_callee:\n"
-	ANNOTATE_NOENDBR
+	ANNOTATE_NOENDBR "\n"
 "	movl	$0x1234, (%" _ASM_ARG1 ")\n"
 	ASM_RET
 "	.size		int3_selftest_callee, . - int3_selftest_callee\n"
diff --git a/arch/x86/kernel/rethook.c b/arch/x86/kernel/rethook.c
index 8a1c011..85e2f2d 100644
--- a/arch/x86/kernel/rethook.c
+++ b/arch/x86/kernel/rethook.c
@@ -25,7 +25,7 @@ asm(
 	".type arch_rethook_trampoline, @function\n"
 	"arch_rethook_trampoline:\n"
 #ifdef CONFIG_X86_64
-	ANNOTATE_NOENDBR	/* This is only jumped from ret instruction */
+	ANNOTATE_NOENDBR "\n"	/* This is only jumped from ret instruction */
 	/* Push a fake return address to tell the unwinder it's a rethook. */
 	"	pushq $arch_rethook_trampoline\n"
 	UNWIND_HINT_FUNC
diff --git a/arch/x86/kernel/static_call.c b/arch/x86/kernel/static_call.c
index 2892cdb..61592e4 100644
--- a/arch/x86/kernel/static_call.c
+++ b/arch/x86/kernel/static_call.c
@@ -50,8 +50,8 @@ asm (".global __static_call_return\n\t"
      ".type __static_call_return, @function\n\t"
      ASM_FUNC_ALIGN "\n\t"
      "__static_call_return:\n\t"
-     ANNOTATE_NOENDBR
-     ANNOTATE_RETPOLINE_SAFE
+     ANNOTATE_NOENDBR "\n\t"
+     ANNOTATE_RETPOLINE_SAFE "\n\t"
      "ret; int3\n\t"
      ".size __static_call_return, . - __static_call_return \n\t");
=20
diff --git a/arch/x86/lib/error-inject.c b/arch/x86/lib/error-inject.c
index b5a6d83..512a253 100644
--- a/arch/x86/lib/error-inject.c
+++ b/arch/x86/lib/error-inject.c
@@ -13,7 +13,7 @@ asm(
 	".globl just_return_func\n"
 	ASM_FUNC_ALIGN
 	"just_return_func:\n"
-		ANNOTATE_NOENDBR
+		ANNOTATE_NOENDBR "\n"
 		ASM_RET
 	".size just_return_func, .-just_return_func\n"
 );
diff --git a/include/linux/annotate.h b/include/linux/annotate.h
index 996126f..5efac5d 100644
--- a/include/linux/annotate.h
+++ b/include/linux/annotate.h
@@ -15,15 +15,15 @@
 #ifndef __ASSEMBLY__
=20
 #define ASM_ANNOTATE_LABEL(label, type)					\
-	__stringify(__ASM_ANNOTATE(".discard.annotate_insn", label, type)) "\n\t"
+	__stringify(__ASM_ANNOTATE(".discard.annotate_insn", label, type))
=20
 #define ASM_ANNOTATE(type)						\
 	"911: "								\
-	__stringify(__ASM_ANNOTATE(".discard.annotate_insn", 911b, type)) "\n\t"
+	__stringify(__ASM_ANNOTATE(".discard.annotate_insn", 911b, type))
=20
 #define ASM_ANNOTATE_DATA(type)						\
 	"912: "								\
-	__stringify(__ASM_ANNOTATE(".discard.annotate_data", 912b, type)) "\n\t"
+	__stringify(__ASM_ANNOTATE(".discard.annotate_data", 912b, type))
=20
 #else /* __ASSEMBLY__ */
=20
diff --git a/include/linux/objtool.h b/include/linux/objtool.h
index b18ab53..9a00e70 100644
--- a/include/linux/objtool.h
+++ b/include/linux/objtool.h
@@ -12,7 +12,7 @@
 #define UNWIND_HINT(type, sp_reg, sp_offset, signal)		\
 	"987: \n\t"						\
 	".pushsection .discard.unwind_hints\n\t"		\
-	ANNOTATE_DATA_SPECIAL					\
+	ANNOTATE_DATA_SPECIAL "\n\t"				\
 	/* struct unwind_hint */				\
 	".long 987b - .\n\t"					\
 	".short " __stringify(sp_offset) "\n\t"			\

