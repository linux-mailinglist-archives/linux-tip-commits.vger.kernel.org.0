Return-Path: <linux-tip-commits+bounces-3376-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3142DA36D7B
	for <lists+linux-tip-commits@lfdr.de>; Sat, 15 Feb 2025 11:57:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9492A189518B
	for <lists+linux-tip-commits@lfdr.de>; Sat, 15 Feb 2025 10:58:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4666F1D6DDA;
	Sat, 15 Feb 2025 10:56:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="WwyMZDYf";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="xI0nNa1+"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9DF21AAA0D;
	Sat, 15 Feb 2025 10:56:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739617005; cv=none; b=iB726zD1OrffkXSSsufE2pipQ0zrq5xhg7u+Odu46QTc3UbybY2r+7kH3XEw8j52Fj/i+kVUdsaRP6B1ZASlVyhocpIb7/3yfVnW0ef/b6q99B3eu5mf469ERFknu10PbrvyXr7crR7mUCQdcPxe7w/NG5ZKIFt5ahIzmltiVJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739617005; c=relaxed/simple;
	bh=APPguLajb04Ur1C59VVCLr7M/M97iwD6vU9mWw8KjCk=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=KdHFVryQNVhIWJkDjqGviX+5Hr2Xdn5316JiPEmfVUKV62FDK4S5WKb8prLj6z6+AHPwGLdwi/LxyKD3e2A1itSWuHL7MOA+JEZj10gEmnhru3D7VieYVu9LFtKjIF04s+8rkNofdpYiDaPmjLLllwwxHOcaDYTGVTMTRFNp++Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=WwyMZDYf; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=xI0nNa1+; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sat, 15 Feb 2025 10:56:39 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1739616999;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AzwMsrOWMQmVnhoElsoYlV4bKeYd6WCInGem8MJx9cE=;
	b=WwyMZDYfbjXkp8azuwZRA46uPsPmTawdgBincSr+sldAwuD9o10zEUmNbQLi61dilhUz3f
	Lqu6gHPfJ1dowITYS5DSHTdK2iwiCFqsG8vIDTh6yWnY2cfqnFPI/UFRX4BjRMGBbr4/tl
	Kw3jn2mbi+XpBFePxoSLI7jp/anxyq8NE0evLLEFrKXCv0J4/vvj7B8cyU6Ta82sc0pcN+
	yO+ccvGuFopM3TfMArYvzSJNhFVyVJSmdjlIEf9ZKtBT3Hy0W+kLUsfWaGIu6TXsPQZXvU
	360IsF0RMNw2dPttbnr2h2m+QTKUKEq/7hKuiB/0g7uo2GdEIJcE1+4f5hUa/g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1739616999;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AzwMsrOWMQmVnhoElsoYlV4bKeYd6WCInGem8MJx9cE=;
	b=xI0nNa1+oOg5mBsKe/s2YLJKa5xQ6Xl2TmDHsjmitfDyJGoszpwIz1IOOED7biUdQSHW7h
	PvE+8fQyaxQj8CDw==
From: "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/core] x86/cfi: Clean up linkage
Cc: "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Sami Tolvanen <samitolvanen@google.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250207122546.409116003@infradead.org>
References: <20250207122546.409116003@infradead.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173961699922.10177.9876137098323396131.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/core branch of tip:

Commit-ID:     582077c94052bd69a544b3f9d7619c9c6a67c34b
Gitweb:        https://git.kernel.org/tip/582077c94052bd69a544b3f9d7619c9c6a67c34b
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Fri, 07 Feb 2025 13:15:33 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 14 Feb 2025 10:32:05 +01:00

x86/cfi: Clean up linkage

With the introduction of kCFI the addition of ENDBR to
SYM_FUNC_START* no longer suffices to make the function indirectly
callable. This now requires the use of SYM_TYPED_FUNC_START.

As such, remove the implicit ENDBR from SYM_FUNC_START* and add some
explicit annotations to fix things up again.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Sami Tolvanen <samitolvanen@google.com>
Link: https://lore.kernel.org/r/20250207122546.409116003@infradead.org
---
 arch/x86/crypto/aesni-intel_asm.S     |  2 ++
 arch/x86/entry/calling.h              |  1 +
 arch/x86/entry/entry.S                |  2 ++
 arch/x86/entry/entry_64.S             |  3 +++
 arch/x86/entry/entry_64_fred.S        |  1 +
 arch/x86/entry/vdso/Makefile          |  1 +
 arch/x86/include/asm/linkage.h        | 18 ++++++------------
 arch/x86/include/asm/page_64.h        |  1 +
 arch/x86/include/asm/paravirt_types.h | 12 +++++++++++-
 arch/x86/include/asm/special_insns.h  |  4 ++--
 arch/x86/include/asm/string_64.h      |  2 ++
 arch/x86/kernel/acpi/madt_playdead.S  |  1 +
 arch/x86/kernel/acpi/wakeup_64.S      |  1 +
 arch/x86/kernel/alternative.c         |  8 ++------
 arch/x86/kernel/ftrace_64.S           |  5 +++++
 arch/x86/kernel/irqflags.S            |  1 +
 arch/x86/kernel/paravirt.c            | 14 ++++++++++++--
 arch/x86/lib/clear_page_64.S          |  2 ++
 arch/x86/lib/copy_user_64.S           |  3 +++
 arch/x86/lib/copy_user_uncached_64.S  |  2 ++
 arch/x86/lib/getuser.S                |  9 +++++++++
 arch/x86/lib/hweight.S                |  3 +++
 arch/x86/lib/putuser.S                |  9 +++++++++
 arch/x86/lib/retpoline.S              |  1 +
 arch/x86/mm/mem_encrypt_boot.S        |  1 +
 arch/x86/power/hibernate_asm_64.S     |  2 ++
 arch/x86/xen/xen-asm.S                |  5 +++++
 arch/x86/xen/xen-head.S               |  2 ++
 include/linux/compiler.h              | 10 ++++++++++
 29 files changed, 103 insertions(+), 23 deletions(-)

diff --git a/arch/x86/crypto/aesni-intel_asm.S b/arch/x86/crypto/aesni-intel_asm.S
index eb153ef..b37881b 100644
--- a/arch/x86/crypto/aesni-intel_asm.S
+++ b/arch/x86/crypto/aesni-intel_asm.S
@@ -17,6 +17,7 @@
  */
 
 #include <linux/linkage.h>
+#include <linux/objtool.h>
 #include <asm/frame.h>
 
 #define STATE1	%xmm0
@@ -1071,6 +1072,7 @@ SYM_FUNC_END(_aesni_inc)
  *		      size_t len, u8 *iv)
  */
 SYM_FUNC_START(aesni_ctr_enc)
+	ANNOTATE_NOENDBR
 	FRAME_BEGIN
 	cmp $16, LEN
 	jb .Lctr_enc_just_ret
diff --git a/arch/x86/entry/calling.h b/arch/x86/entry/calling.h
index ea81770..cb0911c 100644
--- a/arch/x86/entry/calling.h
+++ b/arch/x86/entry/calling.h
@@ -431,6 +431,7 @@ For 32-bit we have the following conventions - kernel is built with
 /* rdi:	arg1 ... normal C conventions. rax is saved/restored. */
 .macro THUNK name, func
 SYM_FUNC_START(\name)
+	ANNOTATE_NOENDBR
 	pushq %rbp
 	movq %rsp, %rbp
 
diff --git a/arch/x86/entry/entry.S b/arch/x86/entry/entry.S
index b7ea3e8..e6d52c2 100644
--- a/arch/x86/entry/entry.S
+++ b/arch/x86/entry/entry.S
@@ -5,6 +5,7 @@
 
 #include <linux/export.h>
 #include <linux/linkage.h>
+#include <linux/objtool.h>
 #include <asm/msr-index.h>
 #include <asm/unwind_hints.h>
 #include <asm/segment.h>
@@ -17,6 +18,7 @@
 .pushsection .noinstr.text, "ax"
 
 SYM_FUNC_START(entry_ibpb)
+	ANNOTATE_NOENDBR
 	movl	$MSR_IA32_PRED_CMD, %ecx
 	movl	$PRED_CMD_IBPB, %eax
 	xorl	%edx, %edx
diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
index f52dbe0..4e5260c 100644
--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -175,6 +175,7 @@ SYM_CODE_END(entry_SYSCALL_64)
  */
 .pushsection .text, "ax"
 SYM_FUNC_START(__switch_to_asm)
+	ANNOTATE_NOENDBR
 	/*
 	 * Save callee-saved registers
 	 * This must match the order in inactive_task_frame
@@ -742,6 +743,7 @@ _ASM_NOKPROBE(common_interrupt_return)
  * Is in entry.text as it shouldn't be instrumented.
  */
 SYM_FUNC_START(asm_load_gs_index)
+	ANNOTATE_NOENDBR
 	FRAME_BEGIN
 	swapgs
 .Lgs_change:
@@ -1526,6 +1528,7 @@ SYM_CODE_END(rewind_stack_and_make_dead)
  * refactored in the future if needed.
  */
 SYM_FUNC_START(clear_bhb_loop)
+	ANNOTATE_NOENDBR
 	push	%rbp
 	mov	%rsp, %rbp
 	movl	$5, %ecx
diff --git a/arch/x86/entry/entry_64_fred.S b/arch/x86/entry/entry_64_fred.S
index a02bc6f..29c5c32 100644
--- a/arch/x86/entry/entry_64_fred.S
+++ b/arch/x86/entry/entry_64_fred.S
@@ -58,6 +58,7 @@ SYM_CODE_END(asm_fred_entrypoint_kernel)
 
 #if IS_ENABLED(CONFIG_KVM_INTEL)
 SYM_FUNC_START(asm_fred_entry_from_kvm)
+	ANNOTATE_NOENDBR
 	push %rbp
 	mov %rsp, %rbp
 
diff --git a/arch/x86/entry/vdso/Makefile b/arch/x86/entry/vdso/Makefile
index c9216ac..bf9f4f6 100644
--- a/arch/x86/entry/vdso/Makefile
+++ b/arch/x86/entry/vdso/Makefile
@@ -133,6 +133,7 @@ KBUILD_CFLAGS_32 += -fno-stack-protector
 KBUILD_CFLAGS_32 += $(call cc-option, -foptimize-sibling-calls)
 KBUILD_CFLAGS_32 += -fno-omit-frame-pointer
 KBUILD_CFLAGS_32 += -DDISABLE_BRANCH_PROFILING
+KBUILD_CFLAGS_32 += -DBUILD_VDSO
 
 ifdef CONFIG_MITIGATION_RETPOLINE
 ifneq ($(RETPOLINE_VDSO_CFLAGS),)
diff --git a/arch/x86/include/asm/linkage.h b/arch/x86/include/asm/linkage.h
index dc31b13..4835c67 100644
--- a/arch/x86/include/asm/linkage.h
+++ b/arch/x86/include/asm/linkage.h
@@ -119,33 +119,27 @@
 
 /* SYM_FUNC_START -- use for global functions */
 #define SYM_FUNC_START(name)				\
-	SYM_START(name, SYM_L_GLOBAL, SYM_F_ALIGN)	\
-	ENDBR
+	SYM_START(name, SYM_L_GLOBAL, SYM_F_ALIGN)
 
 /* SYM_FUNC_START_NOALIGN -- use for global functions, w/o alignment */
 #define SYM_FUNC_START_NOALIGN(name)			\
-	SYM_START(name, SYM_L_GLOBAL, SYM_A_NONE)	\
-	ENDBR
+	SYM_START(name, SYM_L_GLOBAL, SYM_A_NONE)
 
 /* SYM_FUNC_START_LOCAL -- use for local functions */
 #define SYM_FUNC_START_LOCAL(name)			\
-	SYM_START(name, SYM_L_LOCAL, SYM_F_ALIGN)	\
-	ENDBR
+	SYM_START(name, SYM_L_LOCAL, SYM_F_ALIGN)
 
 /* SYM_FUNC_START_LOCAL_NOALIGN -- use for local functions, w/o alignment */
 #define SYM_FUNC_START_LOCAL_NOALIGN(name)		\
-	SYM_START(name, SYM_L_LOCAL, SYM_A_NONE)	\
-	ENDBR
+	SYM_START(name, SYM_L_LOCAL, SYM_A_NONE)
 
 /* SYM_FUNC_START_WEAK -- use for weak functions */
 #define SYM_FUNC_START_WEAK(name)			\
-	SYM_START(name, SYM_L_WEAK, SYM_F_ALIGN)	\
-	ENDBR
+	SYM_START(name, SYM_L_WEAK, SYM_F_ALIGN)
 
 /* SYM_FUNC_START_WEAK_NOALIGN -- use for weak functions, w/o alignment */
 #define SYM_FUNC_START_WEAK_NOALIGN(name)		\
-	SYM_START(name, SYM_L_WEAK, SYM_A_NONE)		\
-	ENDBR
+	SYM_START(name, SYM_L_WEAK, SYM_A_NONE)
 
 #endif /* _ASM_X86_LINKAGE_H */
 
diff --git a/arch/x86/include/asm/page_64.h b/arch/x86/include/asm/page_64.h
index d635766..5c5cfa0 100644
--- a/arch/x86/include/asm/page_64.h
+++ b/arch/x86/include/asm/page_64.h
@@ -60,6 +60,7 @@ static inline void clear_page(void *page)
 }
 
 void copy_page(void *to, void *from);
+KCFI_REFERENCE(copy_page);
 
 #ifdef CONFIG_X86_5LEVEL
 /*
diff --git a/arch/x86/include/asm/paravirt_types.h b/arch/x86/include/asm/paravirt_types.h
index fea56b0..8b36a95 100644
--- a/arch/x86/include/asm/paravirt_types.h
+++ b/arch/x86/include/asm/paravirt_types.h
@@ -244,7 +244,17 @@ extern struct paravirt_patch_template pv_ops;
 
 int paravirt_disable_iospace(void);
 
-/* This generates an indirect call based on the operation type number. */
+/*
+ * This generates an indirect call based on the operation type number.
+ *
+ * Since alternatives run after enabling CET/IBT -- the latter setting/clearing
+ * capabilities and the former requiring all capabilities being finalized --
+ * these indirect calls are subject to IBT and the paravirt stubs should have
+ * ENDBR on.
+ *
+ * OTOH since this is effectively a __nocfi indirect call, the paravirt stubs
+ * don't need to bother with CFI prefixes.
+ */
 #define PARAVIRT_CALL					\
 	ANNOTATE_RETPOLINE_SAFE				\
 	"call *%[paravirt_opptr];"
diff --git a/arch/x86/include/asm/special_insns.h b/arch/x86/include/asm/special_insns.h
index 03e7c2d..21ce480 100644
--- a/arch/x86/include/asm/special_insns.h
+++ b/arch/x86/include/asm/special_insns.h
@@ -42,14 +42,14 @@ static __always_inline void native_write_cr2(unsigned long val)
 	asm volatile("mov %0,%%cr2": : "r" (val) : "memory");
 }
 
-static inline unsigned long __native_read_cr3(void)
+static __always_inline unsigned long __native_read_cr3(void)
 {
 	unsigned long val;
 	asm volatile("mov %%cr3,%0\n\t" : "=r" (val) : __FORCE_ORDER);
 	return val;
 }
 
-static inline void native_write_cr3(unsigned long val)
+static __always_inline void native_write_cr3(unsigned long val)
 {
 	asm volatile("mov %0,%%cr3": : "r" (val) : "memory");
 }
diff --git a/arch/x86/include/asm/string_64.h b/arch/x86/include/asm/string_64.h
index 9d0b324..79e9695 100644
--- a/arch/x86/include/asm/string_64.h
+++ b/arch/x86/include/asm/string_64.h
@@ -21,6 +21,7 @@ extern void *__memcpy(void *to, const void *from, size_t len);
 #define __HAVE_ARCH_MEMSET
 void *memset(void *s, int c, size_t n);
 void *__memset(void *s, int c, size_t n);
+KCFI_REFERENCE(__memset);
 
 /*
  * KMSAN needs to instrument as much code as possible. Use C versions of
@@ -70,6 +71,7 @@ static inline void *memset64(uint64_t *s, uint64_t v, size_t n)
 #define __HAVE_ARCH_MEMMOVE
 void *memmove(void *dest, const void *src, size_t count);
 void *__memmove(void *dest, const void *src, size_t count);
+KCFI_REFERENCE(__memmove);
 
 int memcmp(const void *cs, const void *ct, size_t count);
 size_t strlen(const char *s);
diff --git a/arch/x86/kernel/acpi/madt_playdead.S b/arch/x86/kernel/acpi/madt_playdead.S
index 4e498d2..aefb9cb 100644
--- a/arch/x86/kernel/acpi/madt_playdead.S
+++ b/arch/x86/kernel/acpi/madt_playdead.S
@@ -14,6 +14,7 @@
  * rsi: PGD of the identity mapping
  */
 SYM_FUNC_START(asm_acpi_mp_play_dead)
+	ANNOTATE_NOENDBR
 	/* Turn off global entries. Following CR3 write will flush them. */
 	movq	%cr4, %rdx
 	andq	$~(X86_CR4_PGE), %rdx
diff --git a/arch/x86/kernel/acpi/wakeup_64.S b/arch/x86/kernel/acpi/wakeup_64.S
index b200a19..04f561f 100644
--- a/arch/x86/kernel/acpi/wakeup_64.S
+++ b/arch/x86/kernel/acpi/wakeup_64.S
@@ -17,6 +17,7 @@
 	 * Hooray, we are in Long 64-bit mode (but still running in low memory)
 	 */
 SYM_FUNC_START(wakeup_long64)
+	ANNOTATE_NOENDBR
 	movq	saved_magic(%rip), %rax
 	movq	$0x123456789abcdef0, %rdx
 	cmpq	%rdx, %rax
diff --git a/arch/x86/kernel/alternative.c b/arch/x86/kernel/alternative.c
index 9a252bb..e914a65 100644
--- a/arch/x86/kernel/alternative.c
+++ b/arch/x86/kernel/alternative.c
@@ -926,11 +926,7 @@ struct bpf_insn;
 extern unsigned int __bpf_prog_runX(const void *ctx,
 				    const struct bpf_insn *insn);
 
-/*
- * Force a reference to the external symbol so the compiler generates
- * __kcfi_typid.
- */
-__ADDRESSABLE(__bpf_prog_runX);
+KCFI_REFERENCE(__bpf_prog_runX);
 
 /* u32 __ro_after_init cfi_bpf_hash = __kcfi_typeid___bpf_prog_runX; */
 asm (
@@ -947,7 +943,7 @@ asm (
 /* Must match bpf_callback_t */
 extern u64 __bpf_callback_fn(u64, u64, u64, u64, u64);
 
-__ADDRESSABLE(__bpf_callback_fn);
+KCFI_REFERENCE(__bpf_callback_fn);
 
 /* u32 __ro_after_init cfi_bpf_subprog_hash = __kcfi_typeid___bpf_callback_fn; */
 asm (
diff --git a/arch/x86/kernel/ftrace_64.S b/arch/x86/kernel/ftrace_64.S
index d516472..367da36 100644
--- a/arch/x86/kernel/ftrace_64.S
+++ b/arch/x86/kernel/ftrace_64.S
@@ -146,12 +146,14 @@ SYM_FUNC_END(ftrace_stub_graph)
 #ifdef CONFIG_DYNAMIC_FTRACE
 
 SYM_FUNC_START(__fentry__)
+	ANNOTATE_NOENDBR
 	CALL_DEPTH_ACCOUNT
 	RET
 SYM_FUNC_END(__fentry__)
 EXPORT_SYMBOL(__fentry__)
 
 SYM_FUNC_START(ftrace_caller)
+	ANNOTATE_NOENDBR
 	/* save_mcount_regs fills in first two parameters */
 	save_mcount_regs
 
@@ -197,6 +199,7 @@ SYM_FUNC_END(ftrace_caller);
 STACK_FRAME_NON_STANDARD_FP(ftrace_caller)
 
 SYM_FUNC_START(ftrace_regs_caller)
+	ANNOTATE_NOENDBR
 	/* Save the current flags before any operations that can change them */
 	pushfq
 
@@ -310,6 +313,7 @@ SYM_FUNC_END(ftrace_regs_caller)
 STACK_FRAME_NON_STANDARD_FP(ftrace_regs_caller)
 
 SYM_FUNC_START(ftrace_stub_direct_tramp)
+	ANNOTATE_NOENDBR
 	CALL_DEPTH_ACCOUNT
 	RET
 SYM_FUNC_END(ftrace_stub_direct_tramp)
@@ -317,6 +321,7 @@ SYM_FUNC_END(ftrace_stub_direct_tramp)
 #else /* ! CONFIG_DYNAMIC_FTRACE */
 
 SYM_FUNC_START(__fentry__)
+	ANNOTATE_NOENDBR
 	CALL_DEPTH_ACCOUNT
 
 	cmpq $ftrace_stub, ftrace_trace_function
diff --git a/arch/x86/kernel/irqflags.S b/arch/x86/kernel/irqflags.S
index 7f542a7..fdabd5d 100644
--- a/arch/x86/kernel/irqflags.S
+++ b/arch/x86/kernel/irqflags.S
@@ -9,6 +9,7 @@
  */
 .pushsection .noinstr.text, "ax"
 SYM_FUNC_START(native_save_fl)
+	ENDBR
 	pushf
 	pop %_ASM_AX
 	RET
diff --git a/arch/x86/kernel/paravirt.c b/arch/x86/kernel/paravirt.c
index 1ccaa33..1dc114c 100644
--- a/arch/x86/kernel/paravirt.c
+++ b/arch/x86/kernel/paravirt.c
@@ -116,6 +116,16 @@ static noinstr void pv_native_write_cr2(unsigned long val)
 	native_write_cr2(val);
 }
 
+static noinstr unsigned long pv_native_read_cr3(void)
+{
+	return __native_read_cr3();
+}
+
+static noinstr void pv_native_write_cr3(unsigned long cr3)
+{
+	native_write_cr3(cr3);
+}
+
 static noinstr unsigned long pv_native_get_debugreg(int regno)
 {
 	return native_get_debugreg(regno);
@@ -203,8 +213,8 @@ struct paravirt_patch_template pv_ops = {
 #ifdef CONFIG_PARAVIRT_XXL
 	.mmu.read_cr2		= __PV_IS_CALLEE_SAVE(pv_native_read_cr2),
 	.mmu.write_cr2		= pv_native_write_cr2,
-	.mmu.read_cr3		= __native_read_cr3,
-	.mmu.write_cr3		= native_write_cr3,
+	.mmu.read_cr3		= pv_native_read_cr3,
+	.mmu.write_cr3		= pv_native_write_cr3,
 
 	.mmu.pgd_alloc		= __paravirt_pgd_alloc,
 	.mmu.pgd_free		= paravirt_nop,
diff --git a/arch/x86/lib/clear_page_64.S b/arch/x86/lib/clear_page_64.S
index cc5077b..a508e4a 100644
--- a/arch/x86/lib/clear_page_64.S
+++ b/arch/x86/lib/clear_page_64.S
@@ -2,6 +2,7 @@
 #include <linux/export.h>
 #include <linux/linkage.h>
 #include <linux/cfi_types.h>
+#include <linux/objtool.h>
 #include <asm/asm.h>
 
 /*
@@ -64,6 +65,7 @@ EXPORT_SYMBOL_GPL(clear_page_erms)
  * rcx: uncleared bytes or 0 if successful.
  */
 SYM_FUNC_START(rep_stos_alternative)
+	ANNOTATE_NOENDBR
 	cmpq $64,%rcx
 	jae .Lunrolled
 
diff --git a/arch/x86/lib/copy_user_64.S b/arch/x86/lib/copy_user_64.S
index fc9fb5d..aa8c341 100644
--- a/arch/x86/lib/copy_user_64.S
+++ b/arch/x86/lib/copy_user_64.S
@@ -8,6 +8,8 @@
 
 #include <linux/export.h>
 #include <linux/linkage.h>
+#include <linux/cfi_types.h>
+#include <linux/objtool.h>
 #include <asm/cpufeatures.h>
 #include <asm/alternative.h>
 #include <asm/asm.h>
@@ -30,6 +32,7 @@
  * it simpler for us, we can clobber rsi/rdi and rax freely.
  */
 SYM_FUNC_START(rep_movs_alternative)
+	ANNOTATE_NOENDBR
 	cmpq $64,%rcx
 	jae .Llarge
 
diff --git a/arch/x86/lib/copy_user_uncached_64.S b/arch/x86/lib/copy_user_uncached_64.S
index 2918e36..18350b3 100644
--- a/arch/x86/lib/copy_user_uncached_64.S
+++ b/arch/x86/lib/copy_user_uncached_64.S
@@ -5,6 +5,7 @@
 
 #include <linux/export.h>
 #include <linux/linkage.h>
+#include <linux/objtool.h>
 #include <asm/asm.h>
 
 /*
@@ -27,6 +28,7 @@
  * rax uncopied bytes or 0 if successful.
  */
 SYM_FUNC_START(__copy_user_nocache)
+	ANNOTATE_NOENDBR
 	/* If destination is not 7-byte aligned, we'll have to align it */
 	testb $7,%dil
 	jne .Lalign
diff --git a/arch/x86/lib/getuser.S b/arch/x86/lib/getuser.S
index 89ecd57..71d8e7d 100644
--- a/arch/x86/lib/getuser.S
+++ b/arch/x86/lib/getuser.S
@@ -28,6 +28,7 @@
 
 #include <linux/export.h>
 #include <linux/linkage.h>
+#include <linux/objtool.h>
 #include <asm/page_types.h>
 #include <asm/errno.h>
 #include <asm/asm-offsets.h>
@@ -62,6 +63,7 @@
 
 	.text
 SYM_FUNC_START(__get_user_1)
+	ANNOTATE_NOENDBR
 	check_range size=1
 	ASM_STAC
 	UACCESS movzbl (%_ASM_AX),%edx
@@ -72,6 +74,7 @@ SYM_FUNC_END(__get_user_1)
 EXPORT_SYMBOL(__get_user_1)
 
 SYM_FUNC_START(__get_user_2)
+	ANNOTATE_NOENDBR
 	check_range size=2
 	ASM_STAC
 	UACCESS movzwl (%_ASM_AX),%edx
@@ -82,6 +85,7 @@ SYM_FUNC_END(__get_user_2)
 EXPORT_SYMBOL(__get_user_2)
 
 SYM_FUNC_START(__get_user_4)
+	ANNOTATE_NOENDBR
 	check_range size=4
 	ASM_STAC
 	UACCESS movl (%_ASM_AX),%edx
@@ -92,6 +96,7 @@ SYM_FUNC_END(__get_user_4)
 EXPORT_SYMBOL(__get_user_4)
 
 SYM_FUNC_START(__get_user_8)
+	ANNOTATE_NOENDBR
 #ifndef CONFIG_X86_64
 	xor %ecx,%ecx
 #endif
@@ -111,6 +116,7 @@ EXPORT_SYMBOL(__get_user_8)
 
 /* .. and the same for __get_user, just without the range checks */
 SYM_FUNC_START(__get_user_nocheck_1)
+	ANNOTATE_NOENDBR
 	ASM_STAC
 	ASM_BARRIER_NOSPEC
 	UACCESS movzbl (%_ASM_AX),%edx
@@ -121,6 +127,7 @@ SYM_FUNC_END(__get_user_nocheck_1)
 EXPORT_SYMBOL(__get_user_nocheck_1)
 
 SYM_FUNC_START(__get_user_nocheck_2)
+	ANNOTATE_NOENDBR
 	ASM_STAC
 	ASM_BARRIER_NOSPEC
 	UACCESS movzwl (%_ASM_AX),%edx
@@ -131,6 +138,7 @@ SYM_FUNC_END(__get_user_nocheck_2)
 EXPORT_SYMBOL(__get_user_nocheck_2)
 
 SYM_FUNC_START(__get_user_nocheck_4)
+	ANNOTATE_NOENDBR
 	ASM_STAC
 	ASM_BARRIER_NOSPEC
 	UACCESS movl (%_ASM_AX),%edx
@@ -141,6 +149,7 @@ SYM_FUNC_END(__get_user_nocheck_4)
 EXPORT_SYMBOL(__get_user_nocheck_4)
 
 SYM_FUNC_START(__get_user_nocheck_8)
+	ANNOTATE_NOENDBR
 	ASM_STAC
 	ASM_BARRIER_NOSPEC
 #ifdef CONFIG_X86_64
diff --git a/arch/x86/lib/hweight.S b/arch/x86/lib/hweight.S
index 774bdf3..edbeb3e 100644
--- a/arch/x86/lib/hweight.S
+++ b/arch/x86/lib/hweight.S
@@ -1,6 +1,7 @@
 /* SPDX-License-Identifier: GPL-2.0 */
 #include <linux/export.h>
 #include <linux/linkage.h>
+#include <linux/objtool.h>
 
 #include <asm/asm.h>
 
@@ -9,6 +10,7 @@
  * %rdi: w
  */
 SYM_FUNC_START(__sw_hweight32)
+	ANNOTATE_NOENDBR
 
 #ifdef CONFIG_X86_64
 	movl %edi, %eax				# w
@@ -42,6 +44,7 @@ EXPORT_SYMBOL(__sw_hweight32)
  */
 #ifdef CONFIG_X86_64
 SYM_FUNC_START(__sw_hweight64)
+	ANNOTATE_NOENDBR
 	pushq   %rdi
 	pushq   %rdx
 
diff --git a/arch/x86/lib/putuser.S b/arch/x86/lib/putuser.S
index 975c9c1..46d9e9b 100644
--- a/arch/x86/lib/putuser.S
+++ b/arch/x86/lib/putuser.S
@@ -13,6 +13,7 @@
  */
 #include <linux/export.h>
 #include <linux/linkage.h>
+#include <linux/objtool.h>
 #include <asm/thread_info.h>
 #include <asm/errno.h>
 #include <asm/asm.h>
@@ -45,6 +46,7 @@
 
 .text
 SYM_FUNC_START(__put_user_1)
+	ANNOTATE_NOENDBR
 	check_range size=1
 	ASM_STAC
 1:	movb %al,(%_ASM_CX)
@@ -55,6 +57,7 @@ SYM_FUNC_END(__put_user_1)
 EXPORT_SYMBOL(__put_user_1)
 
 SYM_FUNC_START(__put_user_nocheck_1)
+	ANNOTATE_NOENDBR
 	ASM_STAC
 2:	movb %al,(%_ASM_CX)
 	xor %ecx,%ecx
@@ -64,6 +67,7 @@ SYM_FUNC_END(__put_user_nocheck_1)
 EXPORT_SYMBOL(__put_user_nocheck_1)
 
 SYM_FUNC_START(__put_user_2)
+	ANNOTATE_NOENDBR
 	check_range size=2
 	ASM_STAC
 3:	movw %ax,(%_ASM_CX)
@@ -74,6 +78,7 @@ SYM_FUNC_END(__put_user_2)
 EXPORT_SYMBOL(__put_user_2)
 
 SYM_FUNC_START(__put_user_nocheck_2)
+	ANNOTATE_NOENDBR
 	ASM_STAC
 4:	movw %ax,(%_ASM_CX)
 	xor %ecx,%ecx
@@ -83,6 +88,7 @@ SYM_FUNC_END(__put_user_nocheck_2)
 EXPORT_SYMBOL(__put_user_nocheck_2)
 
 SYM_FUNC_START(__put_user_4)
+	ANNOTATE_NOENDBR
 	check_range size=4
 	ASM_STAC
 5:	movl %eax,(%_ASM_CX)
@@ -93,6 +99,7 @@ SYM_FUNC_END(__put_user_4)
 EXPORT_SYMBOL(__put_user_4)
 
 SYM_FUNC_START(__put_user_nocheck_4)
+	ANNOTATE_NOENDBR
 	ASM_STAC
 6:	movl %eax,(%_ASM_CX)
 	xor %ecx,%ecx
@@ -102,6 +109,7 @@ SYM_FUNC_END(__put_user_nocheck_4)
 EXPORT_SYMBOL(__put_user_nocheck_4)
 
 SYM_FUNC_START(__put_user_8)
+	ANNOTATE_NOENDBR
 	check_range size=8
 	ASM_STAC
 7:	mov %_ASM_AX,(%_ASM_CX)
@@ -115,6 +123,7 @@ SYM_FUNC_END(__put_user_8)
 EXPORT_SYMBOL(__put_user_8)
 
 SYM_FUNC_START(__put_user_nocheck_8)
+	ANNOTATE_NOENDBR
 	ASM_STAC
 9:	mov %_ASM_AX,(%_ASM_CX)
 #ifdef CONFIG_X86_32
diff --git a/arch/x86/lib/retpoline.S b/arch/x86/lib/retpoline.S
index 391059b..038f49a 100644
--- a/arch/x86/lib/retpoline.S
+++ b/arch/x86/lib/retpoline.S
@@ -326,6 +326,7 @@ SYM_FUNC_END(retbleed_untrain_ret)
 #if defined(CONFIG_MITIGATION_UNRET_ENTRY) || defined(CONFIG_MITIGATION_SRSO)
 
 SYM_FUNC_START(entry_untrain_ret)
+	ANNOTATE_NOENDBR
 	ALTERNATIVE JMP_RETBLEED_UNTRAIN_RET, JMP_SRSO_UNTRAIN_RET, X86_FEATURE_SRSO
 SYM_FUNC_END(entry_untrain_ret)
 __EXPORT_THUNK(entry_untrain_ret)
diff --git a/arch/x86/mm/mem_encrypt_boot.S b/arch/x86/mm/mem_encrypt_boot.S
index e25288e..f8a33b2 100644
--- a/arch/x86/mm/mem_encrypt_boot.S
+++ b/arch/x86/mm/mem_encrypt_boot.S
@@ -72,6 +72,7 @@ SYM_FUNC_START(sme_encrypt_execute)
 SYM_FUNC_END(sme_encrypt_execute)
 
 SYM_FUNC_START(__enc_copy)
+	ANNOTATE_NOENDBR
 /*
  * Routine used to encrypt memory in place.
  *   This routine must be run outside of the kernel proper since
diff --git a/arch/x86/power/hibernate_asm_64.S b/arch/x86/power/hibernate_asm_64.S
index 0a0539e..8c534c3 100644
--- a/arch/x86/power/hibernate_asm_64.S
+++ b/arch/x86/power/hibernate_asm_64.S
@@ -26,6 +26,7 @@
 	 /* code below belongs to the image kernel */
 	.align PAGE_SIZE
 SYM_FUNC_START(restore_registers)
+	ANNOTATE_NOENDBR
 	/* go back to the original page tables */
 	movq    %r9, %cr3
 
@@ -119,6 +120,7 @@ SYM_FUNC_END(restore_image)
 
 	/* code below has been relocated to a safe page */
 SYM_FUNC_START(core_restore_code)
+	ANNOTATE_NOENDBR
 	/* switch to temporary page tables */
 	movq	%rax, %cr3
 	/* flush TLB */
diff --git a/arch/x86/xen/xen-asm.S b/arch/x86/xen/xen-asm.S
index b518f36..109af12 100644
--- a/arch/x86/xen/xen-asm.S
+++ b/arch/x86/xen/xen-asm.S
@@ -51,6 +51,7 @@ SYM_FUNC_END(xen_hypercall_pv)
  * non-zero.
  */
 SYM_FUNC_START(xen_irq_disable_direct)
+	ENDBR
 	movb $1, PER_CPU_VAR(xen_vcpu_info + XEN_vcpu_info_mask)
 	RET
 SYM_FUNC_END(xen_irq_disable_direct)
@@ -90,6 +91,7 @@ SYM_FUNC_END(check_events)
  * then enter the hypervisor to get them handled.
  */
 SYM_FUNC_START(xen_irq_enable_direct)
+	ENDBR
 	FRAME_BEGIN
 	/* Unmask events */
 	movb $0, PER_CPU_VAR(xen_vcpu_info + XEN_vcpu_info_mask)
@@ -120,6 +122,7 @@ SYM_FUNC_END(xen_irq_enable_direct)
  * x86 use opposite senses (mask vs enable).
  */
 SYM_FUNC_START(xen_save_fl_direct)
+	ENDBR
 	testb $0xff, PER_CPU_VAR(xen_vcpu_info + XEN_vcpu_info_mask)
 	setz %ah
 	addb %ah, %ah
@@ -127,6 +130,7 @@ SYM_FUNC_START(xen_save_fl_direct)
 SYM_FUNC_END(xen_save_fl_direct)
 
 SYM_FUNC_START(xen_read_cr2)
+	ENDBR
 	FRAME_BEGIN
 	_ASM_MOV PER_CPU_VAR(xen_vcpu), %_ASM_AX
 	_ASM_MOV XEN_vcpu_info_arch_cr2(%_ASM_AX), %_ASM_AX
@@ -135,6 +139,7 @@ SYM_FUNC_START(xen_read_cr2)
 SYM_FUNC_END(xen_read_cr2);
 
 SYM_FUNC_START(xen_read_cr2_direct)
+	ENDBR
 	FRAME_BEGIN
 	_ASM_MOV PER_CPU_VAR(xen_vcpu_info + XEN_vcpu_info_arch_cr2), %_ASM_AX
 	FRAME_END
diff --git a/arch/x86/xen/xen-head.S b/arch/x86/xen/xen-head.S
index 894edf8..8d6873e 100644
--- a/arch/x86/xen/xen-head.S
+++ b/arch/x86/xen/xen-head.S
@@ -133,11 +133,13 @@ SYM_FUNC_START(xen_hypercall_hvm)
 SYM_FUNC_END(xen_hypercall_hvm)
 
 SYM_FUNC_START(xen_hypercall_amd)
+	ANNOTATE_NOENDBR
 	vmmcall
 	RET
 SYM_FUNC_END(xen_hypercall_amd)
 
 SYM_FUNC_START(xen_hypercall_intel)
+	ANNOTATE_NOENDBR
 	vmcall
 	RET
 SYM_FUNC_END(xen_hypercall_intel)
diff --git a/include/linux/compiler.h b/include/linux/compiler.h
index 200fd3c..aa7f0a9 100644
--- a/include/linux/compiler.h
+++ b/include/linux/compiler.h
@@ -212,6 +212,16 @@ void ftrace_likely_update(struct ftrace_likely_data *f, int val,
 
 #endif /* __KERNEL__ */
 
+#if defined(CONFIG_CFI_CLANG) && !defined(__DISABLE_EXPORTS) && !defined(BUILD_VDSO)
+/*
+ * Force a reference to the external symbol so the compiler generates
+ * __kcfi_typid.
+ */
+#define KCFI_REFERENCE(sym) __ADDRESSABLE(sym)
+#else
+#define KCFI_REFERENCE(sym)
+#endif
+
 /**
  * offset_to_ptr - convert a relative memory offset to an absolute pointer
  * @off:	the address of the 32-bit offset value

