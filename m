Return-Path: <linux-tip-commits+bounces-3509-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A961A39BD1
	for <lists+linux-tip-commits@lfdr.de>; Tue, 18 Feb 2025 13:12:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F1B5D188D1E9
	for <lists+linux-tip-commits@lfdr.de>; Tue, 18 Feb 2025 12:12:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF3FF243973;
	Tue, 18 Feb 2025 12:11:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="BWbr26Oj";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="dN3Uxqvb"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2B3124336A;
	Tue, 18 Feb 2025 12:11:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739880709; cv=none; b=iCRKGLqd186dczOPY1KEg5qsIvYod/e7pZQlPYwIW/VtasMfiV3mLhvCBChi8xINB0relFzrVLxAby0xTv42R0duKyp+lAiqfBRLbPt9sFDfVWKn2HQADVnZ19925SCYE5VtIqoZDIfiE8gasFpdb5EFShJLoAj48YlvHckgoHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739880709; c=relaxed/simple;
	bh=d3Ym4/+9wTeEqc1ndUeNsxZTy7nsDvv/rwLr2Qd+G2w=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=dH2oRwXJ5ZqobiuEvmug7brIZwhO7ShCkpdPuVLDfuuNOGbSg6gDFXydPGc4WaSVutKxPC6DiiNp6vMRDCy0+GZ7+plyia/heyqr1FKKJzBHiW147T4b2ymFyHtGds3YzvRZC1lD34Hwp2JYuPiebcFWOMp9sFZOYGVGfu+wd74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=BWbr26Oj; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=dN3Uxqvb; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 18 Feb 2025 12:11:45 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1739880706;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8XR7WA+O2TicyKASwviZ4t0ckLM0QQxIcwx0i/YAylQ=;
	b=BWbr26OjVFJ73e6lUUurym8YJPGFE9N5GvXPuPkitrCYZA5DKb9iYVVR5bPS5l0lZ69ifV
	0odkFiPL3JeYnswA3UjCd2SHRTTSiN48Suva8RBIbbaipRe+6ywongZYTA+p4bDVCtJOOJ
	ps9t5RdIDJM3luh7s36DCKwDt9chuDTUNO7NLjMgv6Kn7xZJnVEOOU9wIV81ayRBycS17V
	phHgfZUTgG+pAvvujuxaoIDF75UnTwVnG9H501xN9kEHaQk2WCiyGmfZNF8Rkj0E9zQrcy
	sKmTTYYWs5+jKcyoAvUizDwYjnLRzBY1aTsuCeQ10EIlD5OjUb3NfOiWfWDvdg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1739880706;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8XR7WA+O2TicyKASwviZ4t0ckLM0QQxIcwx0i/YAylQ=;
	b=dN3UxqvbAsTV4D1v1PoQXJC1yh2Miik1Vjkx1ML3Yjh/JFn+SvOgl8vMrg/mrNggchFpsP
	DvPNYYK1L35VG3Dw==
From: "tip-bot2 for Brian Gerst" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/asm] x86/percpu/64: Use relative percpu offsets
Cc: Brian Gerst <brgerst@gmail.com>, Ingo Molnar <mingo@kernel.org>,
 Ard Biesheuvel <ardb@kernel.org>, Uros Bizjak <ubizjak@gmail.com>,
 Linus Torvalds <torvalds@linux-foundation.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250123190747.745588-9-brgerst@gmail.com>
References: <20250123190747.745588-9-brgerst@gmail.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173988070584.10177.17602396029504536526.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/asm branch of tip:

Commit-ID:     9d7de2aa8b41407bc96d89a80dc1fd637d389d42
Gitweb:        https://git.kernel.org/tip/9d7de2aa8b41407bc96d89a80dc1fd637d389d42
Author:        Brian Gerst <brgerst@gmail.com>
AuthorDate:    Thu, 23 Jan 2025 14:07:40 -05:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 18 Feb 2025 10:15:27 +01:00

x86/percpu/64: Use relative percpu offsets

The percpu section is currently linked at absolute address 0, because
older compilers hard-coded the stack protector canary value at a fixed
offset from the start of the GS segment.  Now that the canary is a
normal percpu variable, the percpu section does not need to be linked
at a specific address.

x86-64 will now calculate the percpu offsets as the delta between the
initial percpu address and the dynamically allocated memory, like other
architectures.  Note that GSBASE is limited to the canonical address
width (48 or 57 bits, sign-extended).  As long as the kernel text,
modules, and the dynamically allocated percpu memory are all in the
negative address space, the delta will not overflow this limit.

Signed-off-by: Brian Gerst <brgerst@gmail.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Reviewed-by: Ard Biesheuvel <ardb@kernel.org>
Reviewed-by: Uros Bizjak <ubizjak@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Link: https://lore.kernel.org/r/20250123190747.745588-9-brgerst@gmail.com
---
 arch/x86/include/asm/processor.h |  6 +++++-
 arch/x86/kernel/head_64.S        | 19 +++++++++----------
 arch/x86/kernel/setup_percpu.c   | 12 ++----------
 arch/x86/kernel/vmlinux.lds.S    | 29 +----------------------------
 arch/x86/platform/pvh/head.S     |  5 ++---
 arch/x86/tools/relocs.c          | 10 +++-------
 arch/x86/xen/xen-head.S          |  9 ++++-----
 init/Kconfig                     |  2 +-
 8 files changed, 27 insertions(+), 65 deletions(-)

diff --git a/arch/x86/include/asm/processor.h b/arch/x86/include/asm/processor.h
index a468712..b8fee88 100644
--- a/arch/x86/include/asm/processor.h
+++ b/arch/x86/include/asm/processor.h
@@ -431,7 +431,11 @@ DECLARE_INIT_PER_CPU(fixed_percpu_data);
 
 static inline unsigned long cpu_kernelmode_gs_base(int cpu)
 {
-	return (unsigned long)per_cpu(fixed_percpu_data.gs_base, cpu);
+#ifdef CONFIG_SMP
+	return per_cpu_offset(cpu);
+#else
+	return 0;
+#endif
 }
 
 extern asmlinkage void entry_SYSCALL32_ignore(void);
diff --git a/arch/x86/kernel/head_64.S b/arch/x86/kernel/head_64.S
index c3d73c0..2843b0a 100644
--- a/arch/x86/kernel/head_64.S
+++ b/arch/x86/kernel/head_64.S
@@ -61,11 +61,14 @@ SYM_CODE_START_NOALIGN(startup_64)
 	/* Set up the stack for verify_cpu() */
 	leaq	__top_init_kernel_stack(%rip), %rsp
 
-	/* Setup GSBASE to allow stack canary access for C code */
+	/*
+	 * Set up GSBASE.
+	 * Note that on SMP the boot CPU uses the init data section until
+	 * the per-CPU areas are set up.
+	 */
 	movl	$MSR_GS_BASE, %ecx
-	leaq	INIT_PER_CPU_VAR(fixed_percpu_data)(%rip), %rdx
-	movl	%edx, %eax
-	shrq	$32,  %rdx
+	xorl	%eax, %eax
+	xorl	%edx, %edx
 	wrmsr
 
 	call	startup_64_setup_gdt_idt
@@ -359,16 +362,12 @@ SYM_INNER_LABEL(common_startup_64, SYM_L_LOCAL)
 	movl %eax,%fs
 	movl %eax,%gs
 
-	/* Set up %gs.
-	 *
-	 * The base of %gs always points to fixed_percpu_data.
+	/*
+	 * Set up GSBASE.
 	 * Note that, on SMP, the boot cpu uses init data section until
 	 * the per cpu areas are set up.
 	 */
 	movl	$MSR_GS_BASE,%ecx
-#ifndef CONFIG_SMP
-	leaq	INIT_PER_CPU_VAR(fixed_percpu_data)(%rip), %rdx
-#endif
 	movl	%edx, %eax
 	shrq	$32, %rdx
 	wrmsr
diff --git a/arch/x86/kernel/setup_percpu.c b/arch/x86/kernel/setup_percpu.c
index b30d6e1..1e7be94 100644
--- a/arch/x86/kernel/setup_percpu.c
+++ b/arch/x86/kernel/setup_percpu.c
@@ -23,18 +23,10 @@
 #include <asm/cpumask.h>
 #include <asm/cpu.h>
 
-#ifdef CONFIG_X86_64
-#define BOOT_PERCPU_OFFSET ((unsigned long)__per_cpu_load)
-#else
-#define BOOT_PERCPU_OFFSET 0
-#endif
-
-DEFINE_PER_CPU_READ_MOSTLY(unsigned long, this_cpu_off) = BOOT_PERCPU_OFFSET;
+DEFINE_PER_CPU_READ_MOSTLY(unsigned long, this_cpu_off);
 EXPORT_PER_CPU_SYMBOL(this_cpu_off);
 
-unsigned long __per_cpu_offset[NR_CPUS] __ro_after_init = {
-	[0 ... NR_CPUS-1] = BOOT_PERCPU_OFFSET,
-};
+unsigned long __per_cpu_offset[NR_CPUS] __ro_after_init;
 EXPORT_SYMBOL(__per_cpu_offset);
 
 /*
diff --git a/arch/x86/kernel/vmlinux.lds.S b/arch/x86/kernel/vmlinux.lds.S
index 0deb488..8a59851 100644
--- a/arch/x86/kernel/vmlinux.lds.S
+++ b/arch/x86/kernel/vmlinux.lds.S
@@ -112,12 +112,6 @@ ASSERT(__relocate_kernel_end - __relocate_kernel_start <= KEXEC_CONTROL_CODE_MAX
 PHDRS {
 	text PT_LOAD FLAGS(5);          /* R_E */
 	data PT_LOAD FLAGS(6);          /* RW_ */
-#ifdef CONFIG_X86_64
-#ifdef CONFIG_SMP
-	percpu PT_LOAD FLAGS(6);        /* RW_ */
-#endif
-	init PT_LOAD FLAGS(7);          /* RWE */
-#endif
 	note PT_NOTE FLAGS(0);          /* ___ */
 }
 
@@ -216,21 +210,7 @@ SECTIONS
 		__init_begin = .; /* paired with __init_end */
 	}
 
-#if defined(CONFIG_X86_64) && defined(CONFIG_SMP)
-	/*
-	 * percpu offsets are zero-based on SMP.  PERCPU_VADDR() changes the
-	 * output PHDR, so the next output section - .init.text - should
-	 * start another segment - init.
-	 */
-	PERCPU_VADDR(INTERNODE_CACHE_BYTES, 0, :percpu)
-	ASSERT(SIZEOF(.data..percpu) < CONFIG_PHYSICAL_START,
-	       "per-CPU data too large - increase CONFIG_PHYSICAL_START")
-#endif
-
 	INIT_TEXT_SECTION(PAGE_SIZE)
-#ifdef CONFIG_X86_64
-	:init
-#endif
 
 	/*
 	 * Section for code used exclusively before alternatives are run. All
@@ -347,9 +327,7 @@ SECTIONS
 		EXIT_DATA
 	}
 
-#if !defined(CONFIG_X86_64) || !defined(CONFIG_SMP)
 	PERCPU_SECTION(INTERNODE_CACHE_BYTES)
-#endif
 
 	RUNTIME_CONST_VARIABLES
 	RUNTIME_CONST(ptr, USER_PTR_MAX)
@@ -497,16 +475,11 @@ PROVIDE(__ref_stack_chk_guard = __stack_chk_guard);
  * Per-cpu symbols which need to be offset from __per_cpu_load
  * for the boot processor.
  */
-#define INIT_PER_CPU(x) init_per_cpu__##x = ABSOLUTE(x) + __per_cpu_load
+#define INIT_PER_CPU(x) init_per_cpu__##x = ABSOLUTE(x)
 INIT_PER_CPU(gdt_page);
 INIT_PER_CPU(fixed_percpu_data);
 INIT_PER_CPU(irq_stack_backing_store);
 
-#ifdef CONFIG_SMP
-. = ASSERT((fixed_percpu_data == 0),
-           "fixed_percpu_data is not at start of per-cpu area");
-#endif
-
 #ifdef CONFIG_MITIGATION_UNRET_ENTRY
 . = ASSERT((retbleed_return_thunk & 0x3f) == 0, "retbleed_return_thunk not cacheline-aligned");
 #endif
diff --git a/arch/x86/platform/pvh/head.S b/arch/x86/platform/pvh/head.S
index 723f181..cfa18ec 100644
--- a/arch/x86/platform/pvh/head.S
+++ b/arch/x86/platform/pvh/head.S
@@ -179,9 +179,8 @@ SYM_CODE_START(pvh_start_xen)
 	 * the per-CPU areas are set up.
 	 */
 	movl $MSR_GS_BASE,%ecx
-	leaq INIT_PER_CPU_VAR(fixed_percpu_data)(%rip), %rdx
-	movq %edx, %eax
-	shrq $32, %rdx
+	xorl %eax, %eax
+	xorl %edx, %edx
 	wrmsr
 
 	/* Call xen_prepare_pvh() via the kernel virtual mapping */
diff --git a/arch/x86/tools/relocs.c b/arch/x86/tools/relocs.c
index 92a1e50..3cb3b30 100644
--- a/arch/x86/tools/relocs.c
+++ b/arch/x86/tools/relocs.c
@@ -835,12 +835,7 @@ static void percpu_init(void)
  */
 static int is_percpu_sym(ElfW(Sym) *sym, const char *symname)
 {
-	int shndx = sym_index(sym);
-
-	return (shndx == per_cpu_shndx) &&
-		strcmp(symname, "__init_begin") &&
-		strcmp(symname, "__per_cpu_load") &&
-		strncmp(symname, "init_per_cpu_", 13);
+	return 0;
 }
 
 
@@ -1062,7 +1057,8 @@ static int cmp_relocs(const void *va, const void *vb)
 
 static void sort_relocs(struct relocs *r)
 {
-	qsort(r->offset, r->count, sizeof(r->offset[0]), cmp_relocs);
+	if (r->count)
+		qsort(r->offset, r->count, sizeof(r->offset[0]), cmp_relocs);
 }
 
 static int write32(uint32_t v, FILE *f)
diff --git a/arch/x86/xen/xen-head.S b/arch/x86/xen/xen-head.S
index a31b057..5ccb4c5 100644
--- a/arch/x86/xen/xen-head.S
+++ b/arch/x86/xen/xen-head.S
@@ -31,15 +31,14 @@ SYM_CODE_START(startup_xen)
 
 	leaq	__top_init_kernel_stack(%rip), %rsp
 
-	/* Set up %gs.
-	 *
-	 * The base of %gs always points to fixed_percpu_data.
+	/*
+	 * Set up GSBASE.
 	 * Note that, on SMP, the boot cpu uses init data section until
 	 * the per cpu areas are set up.
 	 */
 	movl	$MSR_GS_BASE,%ecx
-	movq	$INIT_PER_CPU_VAR(fixed_percpu_data),%rax
-	cdq
+	xorl	%eax, %eax
+	xorl	%edx, %edx
 	wrmsr
 
 	mov	%rsi, %rdi
diff --git a/init/Kconfig b/init/Kconfig
index d0d021b..b5d9c0f 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -1872,7 +1872,7 @@ config KALLSYMS_ALL
 config KALLSYMS_ABSOLUTE_PERCPU
 	bool
 	depends on KALLSYMS
-	default X86_64 && SMP
+	default n
 
 # end of the "standard kernel features (expert users)" menu
 

