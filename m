Return-Path: <linux-tip-commits+bounces-3510-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C5AFA39BD4
	for <lists+linux-tip-commits@lfdr.de>; Tue, 18 Feb 2025 13:12:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3B1B6188D2D4
	for <lists+linux-tip-commits@lfdr.de>; Tue, 18 Feb 2025 12:13:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D1B0244EB5;
	Tue, 18 Feb 2025 12:11:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="z4BgmYRE";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="GWL9c5nt"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0720243397;
	Tue, 18 Feb 2025 12:11:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739880711; cv=none; b=N2rVj0W0wkheNObC4KOj5D+O/cTESb2KHVGz08p1bS9XqQkfwF1j2CVGz0LdAwxQ6zWseq7sE8o97JmY0xXnxQeAop72pZ6BuKkHcIi8Lx4KHHhszgiKfoP4R3sc7JO1pmDrwGwRCfO1BmDhFqFmCT+pBEfaviEfLCVlZLz8pJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739880711; c=relaxed/simple;
	bh=FL3Eox7dMXzRtGoROUUaAR+NorH3idmYSwAc9WDCbNI=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=WSFMTpD/CyJ7eObfOJpgbWlFWCZXbhx7RHHXVQNKoXmZ58mZiHdRG5v525uiARKnLFVq+zwMl0reVcATdNLgq0GhK32ooz9xXvmJtql+8OEivOVXcR0UTGMG7Zgb60oX0ZQSQLJUNYSK89lxdHsphI0+vcW2OHGwpxk+FcxVetM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=z4BgmYRE; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=GWL9c5nt; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 18 Feb 2025 12:11:46 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1739880707;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Tf4+Hi7TwiQAO3oDTkNww0wgfsZgqzOwKeMk5hVMRWk=;
	b=z4BgmYREw2mWyW82OKOCvGSGQUlmVfGqQVDYLbekwLu3Gg2Wv29B3Ui7U6osts/Mxkh1O2
	WJFPYZuVdKBEaQlCIpdRBe9pl9PbrYAXbWhD1qdjbCg3wutA7NRXmwds65BiQoijCpVjGD
	K239ihJ0ivJtgpBLLB5zo+kjkVxT2Sj5zml+G3veYDvpVlX0aKYXBBltg92isdC3nXvHPj
	x8AM7tVhcIKBIvgMDFM6P/usfqKQqHHVA2VWMjr3Rct1bhuCifm5JwM/ujZ/h1AoRD+eok
	qxDUgzR03K1uO0j1dcpk7m3JGY1rJwmbif7Ic7dXer5epULndYUXr1c3HPVw7A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1739880707;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Tf4+Hi7TwiQAO3oDTkNww0wgfsZgqzOwKeMk5hVMRWk=;
	b=GWL9c5nt+tU1TzkO2o7/s+6A4nDeKCBrtUHdhuS5OXtwkHTE4EVLR118Io/E9uXIhkaNP4
	ry2ozFVFJu3GcTBQ==
From: "tip-bot2 for Brian Gerst" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: x86/asm] x86/stackprotector/64: Convert to normal per-CPU variable
Cc: Brian Gerst <brgerst@gmail.com>, Ingo Molnar <mingo@kernel.org>,
 Ard Biesheuvel <ardb@kernel.org>, Uros Bizjak <ubizjak@gmail.com>,
 Linus Torvalds <torvalds@linux-foundation.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250123190747.745588-8-brgerst@gmail.com>
References: <20250123190747.745588-8-brgerst@gmail.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173988070654.10177.13573775149814419276.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/asm branch of tip:

Commit-ID:     80d47defddc000271502057ebd7efa4fd6481542
Gitweb:        https://git.kernel.org/tip/80d47defddc000271502057ebd7efa4fd6481542
Author:        Brian Gerst <brgerst@gmail.com>
AuthorDate:    Thu, 23 Jan 2025 14:07:39 -05:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 18 Feb 2025 10:15:09 +01:00

x86/stackprotector/64: Convert to normal per-CPU variable

Older versions of GCC fixed the location of the stack protector canary
at %gs:40.  This constraint forced the percpu section to be linked at
absolute address 0 so that the canary could be the first data object in
the percpu section.  Supporting the zero-based percpu section requires
additional code to handle relocations for RIP-relative references to
percpu data, extra complexity to kallsyms, and workarounds for linker
bugs due to the use of absolute symbols.

GCC 8.1 supports redefining where the canary is located, allowing it to
become a normal percpu variable instead of at a fixed location.  This
removes the constraint that the percpu section must be zero-based.

Signed-off-by: Brian Gerst <brgerst@gmail.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Reviewed-by: Ard Biesheuvel <ardb@kernel.org>
Reviewed-by: Uros Bizjak <ubizjak@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Link: https://lore.kernel.org/r/20250123190747.745588-8-brgerst@gmail.com
---
 arch/x86/Makefile                     | 20 ++++++++------
 arch/x86/entry/entry.S                |  2 +-
 arch/x86/entry/entry_64.S             |  2 +-
 arch/x86/include/asm/processor.h      | 16 +-----------
 arch/x86/include/asm/stackprotector.h | 36 +++-----------------------
 arch/x86/kernel/asm-offsets_64.c      |  6 +----
 arch/x86/kernel/cpu/common.c          |  5 +----
 arch/x86/kernel/head_64.S             |  3 +--
 arch/x86/xen/xen-head.S               |  3 +--
 9 files changed, 23 insertions(+), 70 deletions(-)

diff --git a/arch/x86/Makefile b/arch/x86/Makefile
index 5b773b3..88a1705 100644
--- a/arch/x86/Makefile
+++ b/arch/x86/Makefile
@@ -140,14 +140,7 @@ ifeq ($(CONFIG_X86_32),y)
         # temporary until string.h is fixed
         KBUILD_CFLAGS += -ffreestanding
 
-    ifeq ($(CONFIG_STACKPROTECTOR),y)
-        ifeq ($(CONFIG_SMP),y)
-            KBUILD_CFLAGS += -mstack-protector-guard-reg=fs \
-                             -mstack-protector-guard-symbol=__ref_stack_chk_guard
-        else
-            KBUILD_CFLAGS += -mstack-protector-guard=global
-        endif
-    endif
+        percpu_seg := fs
 else
         BITS := 64
         UTS_MACHINE := x86_64
@@ -197,6 +190,17 @@ else
         KBUILD_CFLAGS += -mcmodel=kernel
         KBUILD_RUSTFLAGS += -Cno-redzone=y
         KBUILD_RUSTFLAGS += -Ccode-model=kernel
+
+        percpu_seg := gs
+endif
+
+ifeq ($(CONFIG_STACKPROTECTOR),y)
+    ifeq ($(CONFIG_SMP),y)
+	KBUILD_CFLAGS += -mstack-protector-guard-reg=$(percpu_seg)
+	KBUILD_CFLAGS += -mstack-protector-guard-symbol=__ref_stack_chk_guard
+    else
+	KBUILD_CFLAGS += -mstack-protector-guard=global
+    endif
 endif
 
 #
diff --git a/arch/x86/entry/entry.S b/arch/x86/entry/entry.S
index b7ea3e8..fe5344a 100644
--- a/arch/x86/entry/entry.S
+++ b/arch/x86/entry/entry.S
@@ -52,7 +52,6 @@ EXPORT_SYMBOL_GPL(mds_verw_sel);
 
 THUNK warn_thunk_thunk, __warn_thunk
 
-#ifndef CONFIG_X86_64
 /*
  * Clang's implementation of TLS stack cookies requires the variable in
  * question to be a TLS variable. If the variable happens to be defined as an
@@ -66,4 +65,3 @@ THUNK warn_thunk_thunk, __warn_thunk
 #ifdef CONFIG_STACKPROTECTOR
 EXPORT_SYMBOL(__ref_stack_chk_guard);
 #endif
-#endif
diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
index f52dbe0..33a955a 100644
--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -192,7 +192,7 @@ SYM_FUNC_START(__switch_to_asm)
 
 #ifdef CONFIG_STACKPROTECTOR
 	movq	TASK_stack_canary(%rsi), %rbx
-	movq	%rbx, PER_CPU_VAR(fixed_percpu_data + FIXED_stack_canary)
+	movq	%rbx, PER_CPU_VAR(__stack_chk_guard)
 #endif
 
 	/*
diff --git a/arch/x86/include/asm/processor.h b/arch/x86/include/asm/processor.h
index c0cd101..a468712 100644
--- a/arch/x86/include/asm/processor.h
+++ b/arch/x86/include/asm/processor.h
@@ -422,16 +422,8 @@ struct irq_stack {
 
 #ifdef CONFIG_X86_64
 struct fixed_percpu_data {
-	/*
-	 * GCC hardcodes the stack canary as %gs:40.  Since the
-	 * irq_stack is the object at %gs:0, we reserve the bottom
-	 * 48 bytes of the irq stack for the canary.
-	 *
-	 * Once we are willing to require -mstack-protector-guard-symbol=
-	 * support for x86_64 stackprotector, we can get rid of this.
-	 */
 	char		gs_base[40];
-	unsigned long	stack_canary;
+	unsigned long	reserved;
 };
 
 DECLARE_PER_CPU_FIRST(struct fixed_percpu_data, fixed_percpu_data) __visible;
@@ -446,11 +438,7 @@ extern asmlinkage void entry_SYSCALL32_ignore(void);
 
 /* Save actual FS/GS selectors and bases to current->thread */
 void current_save_fsgs(void);
-#else	/* X86_64 */
-#ifdef CONFIG_STACKPROTECTOR
-DECLARE_PER_CPU(unsigned long, __stack_chk_guard);
-#endif
-#endif	/* !X86_64 */
+#endif	/* X86_64 */
 
 struct perf_event;
 
diff --git a/arch/x86/include/asm/stackprotector.h b/arch/x86/include/asm/stackprotector.h
index 00473a6..d43fb58 100644
--- a/arch/x86/include/asm/stackprotector.h
+++ b/arch/x86/include/asm/stackprotector.h
@@ -2,26 +2,10 @@
 /*
  * GCC stack protector support.
  *
- * Stack protector works by putting predefined pattern at the start of
+ * Stack protector works by putting a predefined pattern at the start of
  * the stack frame and verifying that it hasn't been overwritten when
- * returning from the function.  The pattern is called stack canary
- * and unfortunately gcc historically required it to be at a fixed offset
- * from the percpu segment base.  On x86_64, the offset is 40 bytes.
- *
- * The same segment is shared by percpu area and stack canary.  On
- * x86_64, percpu symbols are zero based and %gs (64-bit) points to the
- * base of percpu area.  The first occupant of the percpu area is always
- * fixed_percpu_data which contains stack_canary at the appropriate
- * offset.  On x86_32, the stack canary is just a regular percpu
- * variable.
- *
- * Putting percpu data in %fs on 32-bit is a minor optimization compared to
- * using %gs.  Since 32-bit userspace normally has %fs == 0, we are likely
- * to load 0 into %fs on exit to usermode, whereas with percpu data in
- * %gs, we are likely to load a non-null %gs on return to user mode.
- *
- * Once we are willing to require GCC 8.1 or better for 64-bit stackprotector
- * support, we can remove some of this complexity.
+ * returning from the function.  The pattern is called the stack canary
+ * and is a unique value for each task.
  */
 
 #ifndef _ASM_STACKPROTECTOR_H
@@ -36,6 +20,8 @@
 
 #include <linux/sched.h>
 
+DECLARE_PER_CPU(unsigned long, __stack_chk_guard);
+
 /*
  * Initialize the stackprotector canary value.
  *
@@ -51,25 +37,13 @@ static __always_inline void boot_init_stack_canary(void)
 {
 	unsigned long canary = get_random_canary();
 
-#ifdef CONFIG_X86_64
-	BUILD_BUG_ON(offsetof(struct fixed_percpu_data, stack_canary) != 40);
-#endif
-
 	current->stack_canary = canary;
-#ifdef CONFIG_X86_64
-	this_cpu_write(fixed_percpu_data.stack_canary, canary);
-#else
 	this_cpu_write(__stack_chk_guard, canary);
-#endif
 }
 
 static inline void cpu_init_stack_canary(int cpu, struct task_struct *idle)
 {
-#ifdef CONFIG_X86_64
-	per_cpu(fixed_percpu_data.stack_canary, cpu) = idle->stack_canary;
-#else
 	per_cpu(__stack_chk_guard, cpu) = idle->stack_canary;
-#endif
 }
 
 #else	/* STACKPROTECTOR */
diff --git a/arch/x86/kernel/asm-offsets_64.c b/arch/x86/kernel/asm-offsets_64.c
index bb65371..590b6cd 100644
--- a/arch/x86/kernel/asm-offsets_64.c
+++ b/arch/x86/kernel/asm-offsets_64.c
@@ -54,11 +54,5 @@ int main(void)
 	BLANK();
 #undef ENTRY
 
-	BLANK();
-
-#ifdef CONFIG_STACKPROTECTOR
-	OFFSET(FIXED_stack_canary, fixed_percpu_data, stack_canary);
-	BLANK();
-#endif
 	return 0;
 }
diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index 7cce91b..b71178f 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -2089,8 +2089,7 @@ void syscall_init(void)
 	if (!cpu_feature_enabled(X86_FEATURE_FRED))
 		idt_syscall_init();
 }
-
-#else	/* CONFIG_X86_64 */
+#endif /* CONFIG_X86_64 */
 
 #ifdef CONFIG_STACKPROTECTOR
 DEFINE_PER_CPU(unsigned long, __stack_chk_guard);
@@ -2099,8 +2098,6 @@ EXPORT_PER_CPU_SYMBOL(__stack_chk_guard);
 #endif
 #endif
 
-#endif	/* CONFIG_X86_64 */
-
 /*
  * Clear all 6 debug registers:
  */
diff --git a/arch/x86/kernel/head_64.S b/arch/x86/kernel/head_64.S
index 31345e0..c3d73c0 100644
--- a/arch/x86/kernel/head_64.S
+++ b/arch/x86/kernel/head_64.S
@@ -361,8 +361,7 @@ SYM_INNER_LABEL(common_startup_64, SYM_L_LOCAL)
 
 	/* Set up %gs.
 	 *
-	 * The base of %gs always points to fixed_percpu_data. If the
-	 * stack protector canary is enabled, it is located at %gs:40.
+	 * The base of %gs always points to fixed_percpu_data.
 	 * Note that, on SMP, the boot cpu uses init data section until
 	 * the per cpu areas are set up.
 	 */
diff --git a/arch/x86/xen/xen-head.S b/arch/x86/xen/xen-head.S
index 894edf8..a31b057 100644
--- a/arch/x86/xen/xen-head.S
+++ b/arch/x86/xen/xen-head.S
@@ -33,8 +33,7 @@ SYM_CODE_START(startup_xen)
 
 	/* Set up %gs.
 	 *
-	 * The base of %gs always points to fixed_percpu_data.  If the
-	 * stack protector canary is enabled, it is located at %gs:40.
+	 * The base of %gs always points to fixed_percpu_data.
 	 * Note that, on SMP, the boot cpu uses init data section until
 	 * the per cpu areas are set up.
 	 */

