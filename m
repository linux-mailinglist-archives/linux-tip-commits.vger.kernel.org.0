Return-Path: <linux-tip-commits+bounces-5663-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E432ABAA1E
	for <lists+linux-tip-commits@lfdr.de>; Sat, 17 May 2025 15:00:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C70939E1A24
	for <lists+linux-tip-commits@lfdr.de>; Sat, 17 May 2025 13:00:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FA981FFC7B;
	Sat, 17 May 2025 13:00:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="1Jd6qE3p";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="vgftY8pM"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7B65219EB;
	Sat, 17 May 2025 13:00:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747486842; cv=none; b=MBONrUov7RbYFfXfVVCEApzAyFuNpJaHfFW5WAyomRPtTSgaESWdbgqpjw3tyCKnQcD3rWZOw1jtZ6GPCiCnpnBVI8ZxVjjDPjxYsz+u6x7gFnzCeRDe6Y6paxhyzGqTza9xslEXlr+rkSmFBRgR5Ab/jar/L8sEZnl2+CIWEiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747486842; c=relaxed/simple;
	bh=0Bm7b+xq7jtjSd3VKGKX7fKpe83PAbzkgeBDeLM1vA4=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=scnZ8mu1PI2LBdxlLden6ig8a+oRmTTOP0EFuSeLiweRx4l9795whnJ79EuOrySR0QIEPlVhhTSsKe55xJp8nj3WVu5OmyUA6qBsxeJPOJfymW1ycZ2IjxQIfpugE1Xwh1HMi2/sEiEU1jx+Ftg4NwHSboHCr+TMIgLtkDGeiZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=1Jd6qE3p; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=vgftY8pM; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sat, 17 May 2025 13:00:37 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1747486838;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mBoCqq0hErqbc0zuC8ia51gIstpDoEYohgWezy60ZGs=;
	b=1Jd6qE3pifatFeyh3vtxZ5MS/VlIUTQL1loUEmfXKag39VRZrfWIWWZs/h47sy/ozgroWs
	juoM6NOr/AnLe4p/jM+7Lt2LJ/cChvmH9c5LRTTD+xy6FwsIQpLLAi4GmLtDfiQye+VHvl
	XhXJmcfksS7aLkNmNd7NsT1rMV2v4FWXSwKqF+ogWZnDdPfWAQCOMk+uva7o+2lUqX72xp
	6BLRStkiF7db6Pzrv5AaDCyztaN6aKjlj+YqxYGXbqfmybPBKzovx/K5octy1E05CcmdAC
	N3mya5+ZW5FGymMBDolFmYjn7ureSOHFsFe1HQmvAXYE/3U8VKPxjop1deWceQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1747486838;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mBoCqq0hErqbc0zuC8ia51gIstpDoEYohgWezy60ZGs=;
	b=vgftY8pMptT9vxS0BL7/xd1SRxTT3qybBXXlf4uvcZ36YBathyRwenmc8pYK4bk0VenO7Q
	LSazgLD4umTE2iAg==
From: "tip-bot2 for Kirill A. Shutemov" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/merge] x86/mm/64: Make 5-level paging support unconditional
Cc: Borislav Petkov <bp@alien8.de>,
 "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
 Ingo Molnar <mingo@kernel.org>, Ard Biesheuvel <ardb@kernel.org>,
 Dave Hansen <dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>,
 Linus Torvalds <torvalds@linux-foundation.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250516123306.3812286-4-kirill.shutemov@linux.intel.com>
References: <20250516123306.3812286-4-kirill.shutemov@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174748683715.406.15050802302830067437.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/merge branch of tip:

Commit-ID:     7212b58d6d7133e4cd3c2295e1fb54febe284156
Gitweb:        https://git.kernel.org/tip/7212b58d6d7133e4cd3c2295e1fb54febe284156
Author:        Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
AuthorDate:    Fri, 16 May 2025 15:33:05 +03:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Sat, 17 May 2025 10:38:16 +02:00

x86/mm/64: Make 5-level paging support unconditional

Both Intel and AMD CPUs support 5-level paging, which is expected to
become more widely adopted in the future. All major x86 Linux
distributions have the feature enabled.

Remove CONFIG_X86_5LEVEL and related #ifdeffery for it to make it more readable.

Suggested-by: Borislav Petkov <bp@alien8.de>
Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Reviewed-by: Ard Biesheuvel <ardb@kernel.org>
Reviewed-by: Borislav Petkov (AMD) <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Link: https://lore.kernel.org/r/20250516123306.3812286-4-kirill.shutemov@linux.intel.com
---
 Documentation/arch/x86/cpuinfo.rst              |  8 ++----
 Documentation/arch/x86/x86_64/5level-paging.rst |  9 +-------
 arch/x86/Kconfig                                | 22 +----------------
 arch/x86/Kconfig.cpufeatures                    |  4 +---
 arch/x86/boot/compressed/pgtable_64.c           | 11 +-------
 arch/x86/boot/header.S                          |  4 +---
 arch/x86/boot/startup/map_kernel.c              |  5 +----
 arch/x86/entry/vsyscall/vsyscall_64.c           |  2 +-
 arch/x86/include/asm/page_64.h                  |  2 +-
 arch/x86/include/asm/page_64_types.h            |  7 +-----
 arch/x86/include/asm/pgtable_64.h               |  2 +-
 arch/x86/include/asm/pgtable_64_types.h         | 18 +-------------
 arch/x86/kernel/alternative.c                   |  2 +-
 arch/x86/kernel/head64.c                        |  2 +-
 arch/x86/kernel/head_64.S                       |  2 +-
 arch/x86/mm/init.c                              |  4 +---
 arch/x86/mm/pgtable.c                           |  2 +-
 arch/x86/xen/mmu_pv.c                           |  4 +---
 drivers/firmware/efi/libstub/x86-5lvl.c         |  2 +-
 19 files changed, 10 insertions(+), 102 deletions(-)

diff --git a/Documentation/arch/x86/cpuinfo.rst b/Documentation/arch/x86/cpuinfo.rst
index f80e2a5..dd8b780 100644
--- a/Documentation/arch/x86/cpuinfo.rst
+++ b/Documentation/arch/x86/cpuinfo.rst
@@ -173,10 +173,10 @@ For example, when an old kernel is running on new hardware.
 The kernel disabled support for it at compile-time
 --------------------------------------------------
 
-For example, if 5-level-paging is not enabled when building (i.e.,
-CONFIG_X86_5LEVEL is not selected) the flag "la57" will not show up [#f1]_.
+For example, if Linear Address Masking (LAM) is not enabled when building (i.e.,
+CONFIG_ADDRESS_MASKING is not selected) the flag "lam" will not show up.
 Even though the feature will still be detected via CPUID, the kernel disables
-it by clearing via setup_clear_cpu_cap(X86_FEATURE_LA57).
+it by clearing via setup_clear_cpu_cap(X86_FEATURE_LAM).
 
 The feature is disabled at boot-time
 ------------------------------------
@@ -200,5 +200,3 @@ missing at runtime. For example, AVX flags will not show up if XSAVE feature
 is disabled since they depend on XSAVE feature. Another example would be broken
 CPUs and them missing microcode patches. Due to that, the kernel decides not to
 enable a feature.
-
-.. [#f1] 5-level paging uses linear address of 57 bits.
diff --git a/Documentation/arch/x86/x86_64/5level-paging.rst b/Documentation/arch/x86/x86_64/5level-paging.rst
index 71f882f..ad7ddc1 100644
--- a/Documentation/arch/x86/x86_64/5level-paging.rst
+++ b/Documentation/arch/x86/x86_64/5level-paging.rst
@@ -22,15 +22,6 @@ QEMU 2.9 and later support 5-level paging.
 Virtual memory layout for 5-level paging is described in
 Documentation/arch/x86/x86_64/mm.rst
 
-
-Enabling 5-level paging
-=======================
-CONFIG_X86_5LEVEL=y enables the feature.
-
-Kernel with CONFIG_X86_5LEVEL=y still able to boot on 4-level hardware.
-In this case additional page table level -- p4d -- will be folded at
-runtime.
-
 User-space and large virtual address space
 ==========================================
 On x86, 5-level paging enables 56-bit userspace virtual address space.
diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 27f5d87..bae3e97 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -427,8 +427,7 @@ config DYNAMIC_PHYSICAL_MASK
 
 config PGTABLE_LEVELS
 	int
-	default 5 if X86_5LEVEL
-	default 4 if X86_64
+	default 5 if X86_64
 	default 3 if X86_PAE
 	default 2
 
@@ -1464,25 +1463,6 @@ config X86_PAE
 	  has the cost of more pagetable lookup overhead, and also
 	  consumes more pagetable space per process.
 
-config X86_5LEVEL
-	bool "Enable 5-level page tables support"
-	default y
-	depends on X86_64
-	help
-	  5-level paging enables access to larger address space:
-	  up to 128 PiB of virtual address space and 4 PiB of
-	  physical address space.
-
-	  It will be supported by future Intel CPUs.
-
-	  A kernel with the option enabled can be booted on machines that
-	  support 4- or 5-level paging.
-
-	  See Documentation/arch/x86/x86_64/5level-paging.rst for more
-	  information.
-
-	  Say N if unsure.
-
 config X86_DIRECT_GBPAGES
 	def_bool y
 	depends on X86_64
diff --git a/arch/x86/Kconfig.cpufeatures b/arch/x86/Kconfig.cpufeatures
index e12d5b7..250c106 100644
--- a/arch/x86/Kconfig.cpufeatures
+++ b/arch/x86/Kconfig.cpufeatures
@@ -132,10 +132,6 @@ config X86_DISABLED_FEATURE_OSPKE
 	def_bool y
 	depends on !X86_INTEL_MEMORY_PROTECTION_KEYS
 
-config X86_DISABLED_FEATURE_LA57
-	def_bool y
-	depends on !X86_5LEVEL
-
 config X86_DISABLED_FEATURE_PTI
 	def_bool y
 	depends on !MITIGATION_PAGE_TABLE_ISOLATION
diff --git a/arch/x86/boot/compressed/pgtable_64.c b/arch/x86/boot/compressed/pgtable_64.c
index 5a6c7a1..bdd2605 100644
--- a/arch/x86/boot/compressed/pgtable_64.c
+++ b/arch/x86/boot/compressed/pgtable_64.c
@@ -10,12 +10,10 @@
 #define BIOS_START_MIN		0x20000U	/* 128K, less than this is insane */
 #define BIOS_START_MAX		0x9f000U	/* 640K, absolute maximum */
 
-#ifdef CONFIG_X86_5LEVEL
 /* __pgtable_l5_enabled needs to be in .data to avoid being cleared along with .bss */
 unsigned int __section(".data") __pgtable_l5_enabled;
 unsigned int __section(".data") pgdir_shift = 39;
 unsigned int __section(".data") ptrs_per_p4d = 1;
-#endif
 
 /* Buffer to preserve trampoline memory */
 static char trampoline_save[TRAMPOLINE_32BIT_SIZE];
@@ -114,18 +112,13 @@ asmlinkage void configure_5level_paging(struct boot_params *bp, void *pgtable)
 	 * Check if LA57 is desired and supported.
 	 *
 	 * There are several parts to the check:
-	 *   - if the kernel supports 5-level paging: CONFIG_X86_5LEVEL=y
 	 *   - if user asked to disable 5-level paging: no5lvl in cmdline
 	 *   - if the machine supports 5-level paging:
 	 *     + CPUID leaf 7 is supported
 	 *     + the leaf has the feature bit set
-	 *
-	 * That's substitute for boot_cpu_has() in early boot code.
 	 */
-	if (IS_ENABLED(CONFIG_X86_5LEVEL) &&
-			!cmdline_find_option_bool("no5lvl") &&
-			native_cpuid_eax(0) >= 7 &&
-			(native_cpuid_ecx(7) & (1 << (X86_FEATURE_LA57 & 31)))) {
+	if (!cmdline_find_option_bool("no5lvl") &&
+	    native_cpuid_eax(0) >= 7 && (native_cpuid_ecx(7) & BIT(16))) {
 		l5_required = true;
 
 		/* Initialize variables for 5-level paging */
diff --git a/arch/x86/boot/header.S b/arch/x86/boot/header.S
index 9cb9142..e30649e 100644
--- a/arch/x86/boot/header.S
+++ b/arch/x86/boot/header.S
@@ -361,12 +361,8 @@ xloadflags:
 #endif
 
 #ifdef CONFIG_X86_64
-#ifdef CONFIG_X86_5LEVEL
 #define XLF56 (XLF_5LEVEL|XLF_5LEVEL_ENABLED)
 #else
-#define XLF56 XLF_5LEVEL
-#endif
-#else
 #define XLF56 0
 #endif
 
diff --git a/arch/x86/boot/startup/map_kernel.c b/arch/x86/boot/startup/map_kernel.c
index 905e873..332dbe6 100644
--- a/arch/x86/boot/startup/map_kernel.c
+++ b/arch/x86/boot/startup/map_kernel.c
@@ -16,9 +16,6 @@ extern unsigned int next_early_pgt;
 
 static inline bool check_la57_support(void)
 {
-	if (!IS_ENABLED(CONFIG_X86_5LEVEL))
-		return false;
-
 	/*
 	 * 5-level paging is detected and enabled at kernel decompression
 	 * stage. Only check if it has been enabled there.
@@ -129,7 +126,7 @@ unsigned long __head __startup_64(unsigned long p2v_offset,
 	pgd = rip_rel_ptr(early_top_pgt);
 	pgd[pgd_index(__START_KERNEL_map)] += load_delta;
 
-	if (IS_ENABLED(CONFIG_X86_5LEVEL) && la57) {
+	if (la57) {
 		p4d = (p4dval_t *)rip_rel_ptr(level4_kernel_pgt);
 		p4d[MAX_PTRS_PER_P4D - 1] += load_delta;
 
diff --git a/arch/x86/entry/vsyscall/vsyscall_64.c b/arch/x86/entry/vsyscall/vsyscall_64.c
index 2fb7d53..c9103a6 100644
--- a/arch/x86/entry/vsyscall/vsyscall_64.c
+++ b/arch/x86/entry/vsyscall/vsyscall_64.c
@@ -341,9 +341,7 @@ void __init set_vsyscall_pgtable_user_bits(pgd_t *root)
 	pgd = pgd_offset_pgd(root, VSYSCALL_ADDR);
 	set_pgd(pgd, __pgd(pgd_val(*pgd) | _PAGE_USER));
 	p4d = p4d_offset(pgd, VSYSCALL_ADDR);
-#if CONFIG_PGTABLE_LEVELS >= 5
 	set_p4d(p4d, __p4d(p4d_val(*p4d) | _PAGE_USER));
-#endif
 	pud = pud_offset(p4d, VSYSCALL_ADDR);
 	set_pud(pud, __pud(pud_val(*pud) | _PAGE_USER));
 	pmd = pmd_offset(pud, VSYSCALL_ADDR);
diff --git a/arch/x86/include/asm/page_64.h b/arch/x86/include/asm/page_64.h
index d3aab6f..015d23f 100644
--- a/arch/x86/include/asm/page_64.h
+++ b/arch/x86/include/asm/page_64.h
@@ -62,7 +62,6 @@ static inline void clear_page(void *page)
 void copy_page(void *to, void *from);
 KCFI_REFERENCE(copy_page);
 
-#ifdef CONFIG_X86_5LEVEL
 /*
  * User space process size.  This is the first address outside the user range.
  * There are a few constraints that determine this:
@@ -93,7 +92,6 @@ static __always_inline unsigned long task_size_max(void)
 
 	return ret;
 }
-#endif	/* CONFIG_X86_5LEVEL */
 
 #endif	/* !__ASSEMBLER__ */
 
diff --git a/arch/x86/include/asm/page_64_types.h b/arch/x86/include/asm/page_64_types.h
index 6b8c816..7400dab 100644
--- a/arch/x86/include/asm/page_64_types.h
+++ b/arch/x86/include/asm/page_64_types.h
@@ -48,14 +48,7 @@
 /* See Documentation/arch/x86/x86_64/mm.rst for a description of the memory map. */
 
 #define __PHYSICAL_MASK_SHIFT	52
-
-#ifdef CONFIG_X86_5LEVEL
 #define __VIRTUAL_MASK_SHIFT	(pgtable_l5_enabled() ? 56 : 47)
-/* See task_size_max() in <asm/page_64.h> */
-#else
-#define __VIRTUAL_MASK_SHIFT	47
-#define task_size_max()		((_AC(1,UL) << __VIRTUAL_MASK_SHIFT) - PAGE_SIZE)
-#endif
 
 #define TASK_SIZE_MAX		task_size_max()
 #define DEFAULT_MAP_WINDOW	((1UL << 47) - PAGE_SIZE)
diff --git a/arch/x86/include/asm/pgtable_64.h b/arch/x86/include/asm/pgtable_64.h
index b89f8f1..f06e5d6 100644
--- a/arch/x86/include/asm/pgtable_64.h
+++ b/arch/x86/include/asm/pgtable_64.h
@@ -41,11 +41,9 @@ static inline void sync_initial_page_table(void) { }
 	pr_err("%s:%d: bad pud %p(%016lx)\n",		\
 	       __FILE__, __LINE__, &(e), pud_val(e))
 
-#if CONFIG_PGTABLE_LEVELS >= 5
 #define p4d_ERROR(e)					\
 	pr_err("%s:%d: bad p4d %p(%016lx)\n",		\
 	       __FILE__, __LINE__, &(e), p4d_val(e))
-#endif
 
 #define pgd_ERROR(e)					\
 	pr_err("%s:%d: bad pgd %p(%016lx)\n",		\
diff --git a/arch/x86/include/asm/pgtable_64_types.h b/arch/x86/include/asm/pgtable_64_types.h
index eee06f7..4604f92 100644
--- a/arch/x86/include/asm/pgtable_64_types.h
+++ b/arch/x86/include/asm/pgtable_64_types.h
@@ -23,7 +23,6 @@ typedef struct { pmdval_t pmd; } pmd_t;
 
 extern unsigned int __pgtable_l5_enabled;
 
-#ifdef CONFIG_X86_5LEVEL
 #ifdef USE_EARLY_PGTABLE_L5
 /*
  * cpu_feature_enabled() is not available in early boot code.
@@ -37,17 +36,11 @@ static inline bool pgtable_l5_enabled(void)
 #define pgtable_l5_enabled() cpu_feature_enabled(X86_FEATURE_LA57)
 #endif /* USE_EARLY_PGTABLE_L5 */
 
-#else
-#define pgtable_l5_enabled() 0
-#endif /* CONFIG_X86_5LEVEL */
-
 extern unsigned int pgdir_shift;
 extern unsigned int ptrs_per_p4d;
 
 #endif	/* !__ASSEMBLER__ */
 
-#ifdef CONFIG_X86_5LEVEL
-
 /*
  * PGDIR_SHIFT determines what a top-level page table entry can map
  */
@@ -65,17 +58,6 @@ extern unsigned int ptrs_per_p4d;
 
 #define MAX_POSSIBLE_PHYSMEM_BITS	52
 
-#else /* CONFIG_X86_5LEVEL */
-
-/*
- * PGDIR_SHIFT determines what a top-level page table entry can map
- */
-#define PGDIR_SHIFT		39
-#define PTRS_PER_PGD		512
-#define MAX_PTRS_PER_P4D	1
-
-#endif /* CONFIG_X86_5LEVEL */
-
 /*
  * 3rd level page
  */
diff --git a/arch/x86/kernel/alternative.c b/arch/x86/kernel/alternative.c
index 2385528..f3c68b5 100644
--- a/arch/x86/kernel/alternative.c
+++ b/arch/x86/kernel/alternative.c
@@ -590,7 +590,7 @@ void __init_or_module noinline apply_alternatives(struct alt_instr *start,
 	DPRINTK(ALT, "alt table %px, -> %px", start, end);
 
 	/*
-	 * In the case CONFIG_X86_5LEVEL=y, KASAN_SHADOW_START is defined using
+	 * KASAN_SHADOW_START is defined using
 	 * cpu_feature_enabled(X86_FEATURE_LA57) and is therefore patched here.
 	 * During the process, KASAN becomes confused seeing partial LA57
 	 * conversion and triggers a false-positive out-of-bound report.
diff --git a/arch/x86/kernel/head64.c b/arch/x86/kernel/head64.c
index 9f617be..533fcf5 100644
--- a/arch/x86/kernel/head64.c
+++ b/arch/x86/kernel/head64.c
@@ -51,13 +51,11 @@ unsigned int __initdata next_early_pgt;
 SYM_PIC_ALIAS(next_early_pgt);
 pmdval_t early_pmd_flags = __PAGE_KERNEL_LARGE & ~(_PAGE_GLOBAL | _PAGE_NX);
 
-#ifdef CONFIG_X86_5LEVEL
 unsigned int __pgtable_l5_enabled __ro_after_init;
 unsigned int pgdir_shift __ro_after_init = 39;
 EXPORT_SYMBOL(pgdir_shift);
 unsigned int ptrs_per_p4d __ro_after_init = 1;
 EXPORT_SYMBOL(ptrs_per_p4d);
-#endif
 
 unsigned long page_offset_base __ro_after_init = __PAGE_OFFSET_BASE_L4;
 EXPORT_SYMBOL(page_offset_base);
diff --git a/arch/x86/kernel/head_64.S b/arch/x86/kernel/head_64.S
index 0694208..3e9b3a3 100644
--- a/arch/x86/kernel/head_64.S
+++ b/arch/x86/kernel/head_64.S
@@ -649,13 +649,11 @@ SYM_DATA_START_PTI_ALIGNED(init_top_pgt)
 SYM_DATA_END(init_top_pgt)
 #endif
 
-#ifdef CONFIG_X86_5LEVEL
 SYM_DATA_START_PAGE_ALIGNED(level4_kernel_pgt)
 	.fill	511,8,0
 	.quad	level3_kernel_pgt - __START_KERNEL_map + _PAGE_TABLE_NOENC
 SYM_DATA_END(level4_kernel_pgt)
 SYM_PIC_ALIAS(level4_kernel_pgt)
-#endif
 
 SYM_DATA_START_PAGE_ALIGNED(level3_kernel_pgt)
 	.fill	L3_START_KERNEL,8,0
diff --git a/arch/x86/mm/init.c b/arch/x86/mm/init.c
index aa56d9a..7456df9 100644
--- a/arch/x86/mm/init.c
+++ b/arch/x86/mm/init.c
@@ -174,11 +174,7 @@ __ref void *alloc_low_pages(unsigned int num)
  * randomization is enabled.
  */
 
-#ifndef CONFIG_X86_5LEVEL
-#define INIT_PGD_PAGE_TABLES    3
-#else
 #define INIT_PGD_PAGE_TABLES    4
-#endif
 
 #ifndef CONFIG_RANDOMIZE_MEMORY
 #define INIT_PGD_PAGE_COUNT      (2 * INIT_PGD_PAGE_TABLES)
diff --git a/arch/x86/mm/pgtable.c b/arch/x86/mm/pgtable.c
index 59c42de..62777ba 100644
--- a/arch/x86/mm/pgtable.c
+++ b/arch/x86/mm/pgtable.c
@@ -592,7 +592,7 @@ void native_set_fixmap(unsigned /* enum fixed_addresses */ idx,
 }
 
 #ifdef CONFIG_HAVE_ARCH_HUGE_VMAP
-#ifdef CONFIG_X86_5LEVEL
+#if CONFIG_PGTABLE_LEVELS > 4
 /**
  * p4d_set_huge - Set up kernel P4D mapping
  * @p4d: Pointer to the P4D entry
diff --git a/arch/x86/xen/mmu_pv.c b/arch/x86/xen/mmu_pv.c
index 38971c6..2a4a8de 100644
--- a/arch/x86/xen/mmu_pv.c
+++ b/arch/x86/xen/mmu_pv.c
@@ -578,7 +578,6 @@ static void xen_set_p4d(p4d_t *ptr, p4d_t val)
 	xen_mc_issue(XEN_LAZY_MMU);
 }
 
-#if CONFIG_PGTABLE_LEVELS >= 5
 __visible p4dval_t xen_p4d_val(p4d_t p4d)
 {
 	return pte_mfn_to_pfn(p4d.p4d);
@@ -592,7 +591,6 @@ __visible p4d_t xen_make_p4d(p4dval_t p4d)
 	return native_make_p4d(p4d);
 }
 PV_CALLEE_SAVE_REGS_THUNK(xen_make_p4d);
-#endif  /* CONFIG_PGTABLE_LEVELS >= 5 */
 
 static void xen_pmd_walk(struct mm_struct *mm, pmd_t *pmd,
 			 void (*func)(struct mm_struct *mm, struct page *,
@@ -2222,10 +2220,8 @@ static const typeof(pv_ops) xen_mmu_ops __initconst = {
 		.alloc_pud = xen_alloc_pmd_init,
 		.release_pud = xen_release_pmd_init,
 
-#if CONFIG_PGTABLE_LEVELS >= 5
 		.p4d_val = PV_CALLEE_SAVE(xen_p4d_val),
 		.make_p4d = PV_CALLEE_SAVE(xen_make_p4d),
-#endif
 
 		.enter_mmap = xen_enter_mmap,
 		.exit_mmap = xen_exit_mmap,
diff --git a/drivers/firmware/efi/libstub/x86-5lvl.c b/drivers/firmware/efi/libstub/x86-5lvl.c
index 77359e8..f1c5fb4 100644
--- a/drivers/firmware/efi/libstub/x86-5lvl.c
+++ b/drivers/firmware/efi/libstub/x86-5lvl.c
@@ -62,7 +62,7 @@ efi_status_t efi_setup_5level_paging(void)
 
 void efi_5level_switch(void)
 {
-	bool want_la57 = IS_ENABLED(CONFIG_X86_5LEVEL) && !efi_no5lvl;
+	bool want_la57 = !efi_no5lvl;
 	bool have_la57 = native_read_cr4() & X86_CR4_LA57;
 	bool need_toggle = want_la57 ^ have_la57;
 	u64 *pgt = (void *)la57_toggle + PAGE_SIZE;

