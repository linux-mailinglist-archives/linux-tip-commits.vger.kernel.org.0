Return-Path: <linux-tip-commits+bounces-4706-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F0AFCA7CF9A
	for <lists+linux-tip-commits@lfdr.de>; Sun,  6 Apr 2025 20:33:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7D130188D76D
	for <lists+linux-tip-commits@lfdr.de>; Sun,  6 Apr 2025 18:33:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D93EB154423;
	Sun,  6 Apr 2025 18:33:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="0Qvi2EgC";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="s+95Lu+J"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B63642AA5;
	Sun,  6 Apr 2025 18:33:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743964383; cv=none; b=sPm1BvkDXyOekPXQfJ7+SHV3xbgqATooQo76UOuu7V0XkCAn4teqJ+qyDk+MupqvqbTo1SNXb0QNTiFDkkLuSoAPCe3NqOK9npwQTGr05u8Oi9GVG4TnJdK8H2sY1jAumHgzqQYYuDFMa2XA59PthvPLQ8TQFyeTaZ+zdwtM4UQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743964383; c=relaxed/simple;
	bh=OfSH4FxnB/ZF80PgTthrUKPbgfJkKBhDrIvTP1GnLYA=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=TEMDxxIjIFV+PQDnj5MiKxwTetQgmJh/JtOHi1l8DVRwsVvNhffcKfQi3RmFC9QbCGITeUXMi/xuM2WWhM3D8ogfSEKuQKR8dhEdStG6z5DTJ650huR+YWwl6GKfTO1S+TeGVQQhG0GcpBquNCwaoUTMmhmwNMA5a2j/y2KIUEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=0Qvi2EgC; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=s+95Lu+J; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sun, 06 Apr 2025 18:32:59 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1743964379;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=92IlUscCN7p9N1agEf0jenO8KPe7XF7lQgAeQbHGGog=;
	b=0Qvi2EgChmp0QUd/CSFqb6T5Zj7fgv6eIxdDwRNfyyM533HhpGFtlz5ZoLWlmyikbciVGB
	93JSAqKknsqHMbB1LlFXy59m+dFBYQpSbFFrOi6sS3ZVIpyTfstJFuHJ6JaofhbCGdt3+0
	LEzzUzOXeWSZ99zbTbEssA7JgJIhK8f3RaViklo/lnsHTZrCKGg1hILk0K7T/XP6P30Uiq
	9q6v092r35HJU0T3rw9n1ic/foYN6AhD7BJXfj1n/hDPHRka+/3Q0bZplloRMf5dMVSx53
	4Qld9QobRZNu7uDcddeJleqhJ0UjDA1Ht3I3bksHn88uiCm0/IVvVm0ubdf7vw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1743964379;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=92IlUscCN7p9N1agEf0jenO8KPe7XF7lQgAeQbHGGog=;
	b=s+95Lu+JfustJakjWPDBwAz06NzkgVHyzOtzabTUlItXMYTYY4Xm0whXaUDEF+OasZX5PL
	GXAiq0IPcd3GB3DA==
From: "tip-bot2 for Ard Biesheuvel" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: x86/boot] x86/boot: Move the early kernel mapping code into startup/
Cc: Ard Biesheuvel <ardb@kernel.org>, Ingo Molnar <mingo@kernel.org>,
 David Woodhouse <dwmw@amazon.co.uk>, "H. Peter Anvin" <hpa@zytor.com>,
 Kees Cook <keescook@chromium.org>,
 Linus Torvalds <torvalds@linux-foundation.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250401133416.1436741-13-ardb+git@google.com>
References: <20250401133416.1436741-13-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174396437915.31282.2236991262430723770.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/boot branch of tip:

Commit-ID:     1c1f4adbb07ee6ead77050a0322fedfd19bc2861
Gitweb:        https://git.kernel.org/tip/1c1f4adbb07ee6ead77050a0322fedfd19bc2861
Author:        Ard Biesheuvel <ardb@kernel.org>
AuthorDate:    Tue, 01 Apr 2025 15:34:22 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Sun, 06 Apr 2025 20:15:15 +02:00

x86/boot: Move the early kernel mapping code into startup/

The startup code that constructs the kernel virtual mapping runs from
the 1:1 mapping of memory itself, and therefore, cannot use absolute
symbol references. Move this code into a separate source file under
arch/x86/boot/startup/ where all such code will be kept from now on.

Since all code here is constructed in a manner that ensures that it
tolerates running from the 1:1 mapping of memory, any uses of the
RIP_REL_REF() macro can be dropped, along with __head annotations for
placing this code in a dedicated startup section.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: David Woodhouse <dwmw@amazon.co.uk>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Kees Cook <keescook@chromium.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Link: https://lore.kernel.org/r/20250401133416.1436741-13-ardb+git@google.com
---
 arch/x86/boot/startup/Makefile     |   2 +-
 arch/x86/boot/startup/map_kernel.c | 232 ++++++++++++++++++++++++++++-
 arch/x86/kernel/head64.c           | 228 +----------------------------
 3 files changed, 234 insertions(+), 228 deletions(-)
 create mode 100644 arch/x86/boot/startup/map_kernel.c

diff --git a/arch/x86/boot/startup/Makefile b/arch/x86/boot/startup/Makefile
index 34b324c..0142306 100644
--- a/arch/x86/boot/startup/Makefile
+++ b/arch/x86/boot/startup/Makefile
@@ -15,7 +15,7 @@ KMSAN_SANITIZE	:= n
 UBSAN_SANITIZE	:= n
 KCOV_INSTRUMENT	:= n
 
-obj-$(CONFIG_X86_64)		+= gdt_idt.o
+obj-$(CONFIG_X86_64)		+= gdt_idt.o map_kernel.o
 
 lib-$(CONFIG_X86_64)		+= la57toggle.o
 lib-$(CONFIG_EFI_MIXED)		+= efi-mixed.o
diff --git a/arch/x86/boot/startup/map_kernel.c b/arch/x86/boot/startup/map_kernel.c
new file mode 100644
index 0000000..ba856be
--- /dev/null
+++ b/arch/x86/boot/startup/map_kernel.c
@@ -0,0 +1,232 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <linux/init.h>
+#include <linux/linkage.h>
+#include <linux/types.h>
+#include <linux/kernel.h>
+#include <linux/pgtable.h>
+
+#include <asm/sections.h>
+#include <asm/setup.h>
+#include <asm/sev.h>
+
+extern pmd_t early_dynamic_pgts[EARLY_DYNAMIC_PAGE_TABLES][PTRS_PER_PMD];
+extern unsigned int next_early_pgt;
+
+#ifdef CONFIG_X86_5LEVEL
+unsigned int __pgtable_l5_enabled __ro_after_init;
+unsigned int pgdir_shift __ro_after_init = 39;
+EXPORT_SYMBOL(pgdir_shift);
+unsigned int ptrs_per_p4d __ro_after_init = 1;
+EXPORT_SYMBOL(ptrs_per_p4d);
+#endif
+
+#ifdef CONFIG_DYNAMIC_MEMORY_LAYOUT
+unsigned long page_offset_base __ro_after_init = __PAGE_OFFSET_BASE_L4;
+EXPORT_SYMBOL(page_offset_base);
+unsigned long vmalloc_base __ro_after_init = __VMALLOC_BASE_L4;
+EXPORT_SYMBOL(vmalloc_base);
+unsigned long vmemmap_base __ro_after_init = __VMEMMAP_BASE_L4;
+EXPORT_SYMBOL(vmemmap_base);
+#endif
+
+static inline bool check_la57_support(void)
+{
+	if (!IS_ENABLED(CONFIG_X86_5LEVEL))
+		return false;
+
+	/*
+	 * 5-level paging is detected and enabled at kernel decompression
+	 * stage. Only check if it has been enabled there.
+	 */
+	if (!(native_read_cr4() & X86_CR4_LA57))
+		return false;
+
+	__pgtable_l5_enabled	= 1;
+	pgdir_shift		= 48;
+	ptrs_per_p4d		= 512;
+	page_offset_base	= __PAGE_OFFSET_BASE_L5;
+	vmalloc_base		= __VMALLOC_BASE_L5;
+	vmemmap_base		= __VMEMMAP_BASE_L5;
+
+	return true;
+}
+
+static unsigned long sme_postprocess_startup(struct boot_params *bp,
+					     pmdval_t *pmd,
+					     unsigned long p2v_offset)
+{
+	unsigned long paddr, paddr_end;
+	int i;
+
+	/* Encrypt the kernel and related (if SME is active) */
+	sme_encrypt_kernel(bp);
+
+	/*
+	 * Clear the memory encryption mask from the .bss..decrypted section.
+	 * The bss section will be memset to zero later in the initialization so
+	 * there is no need to zero it after changing the memory encryption
+	 * attribute.
+	 */
+	if (sme_get_me_mask()) {
+		paddr = (unsigned long)__start_bss_decrypted;
+		paddr_end = (unsigned long)__end_bss_decrypted;
+
+		for (; paddr < paddr_end; paddr += PMD_SIZE) {
+			/*
+			 * On SNP, transition the page to shared in the RMP table so that
+			 * it is consistent with the page table attribute change.
+			 *
+			 * __start_bss_decrypted has a virtual address in the high range
+			 * mapping (kernel .text). PVALIDATE, by way of
+			 * early_snp_set_memory_shared(), requires a valid virtual
+			 * address but the kernel is currently running off of the identity
+			 * mapping so use the PA to get a *currently* valid virtual address.
+			 */
+			early_snp_set_memory_shared(paddr, paddr, PTRS_PER_PMD);
+
+			i = pmd_index(paddr - p2v_offset);
+			pmd[i] -= sme_get_me_mask();
+		}
+	}
+
+	/*
+	 * Return the SME encryption mask (if SME is active) to be used as a
+	 * modifier for the initial pgdir entry programmed into CR3.
+	 */
+	return sme_get_me_mask();
+}
+
+unsigned long __init __startup_64(unsigned long p2v_offset,
+				  struct boot_params *bp)
+{
+	pmd_t (*early_pgts)[PTRS_PER_PMD] = early_dynamic_pgts;
+	unsigned long physaddr = (unsigned long)_text;
+	unsigned long va_text, va_end;
+	unsigned long pgtable_flags;
+	unsigned long load_delta;
+	pgdval_t *pgd;
+	p4dval_t *p4d;
+	pudval_t *pud;
+	pmdval_t *pmd, pmd_entry;
+	bool la57;
+	int i;
+
+	la57 = check_la57_support();
+
+	/* Is the address too large? */
+	if (physaddr >> MAX_PHYSMEM_BITS)
+		for (;;);
+
+	/*
+	 * Compute the delta between the address I am compiled to run at
+	 * and the address I am actually running at.
+	 */
+	phys_base = load_delta = __START_KERNEL_map + p2v_offset;
+
+	/* Is the address not 2M aligned? */
+	if (load_delta & ~PMD_MASK)
+		for (;;);
+
+	va_text = physaddr - p2v_offset;
+	va_end  = (unsigned long)_end - p2v_offset;
+
+	/* Include the SME encryption mask in the fixup value */
+	load_delta += sme_get_me_mask();
+
+	/* Fixup the physical addresses in the page table */
+
+	pgd = &early_top_pgt[0].pgd;
+	pgd[pgd_index(__START_KERNEL_map)] += load_delta;
+
+	if (IS_ENABLED(CONFIG_X86_5LEVEL) && la57) {
+		p4d = (p4dval_t *)level4_kernel_pgt;
+		p4d[MAX_PTRS_PER_P4D - 1] += load_delta;
+
+		pgd[pgd_index(__START_KERNEL_map)] = (pgdval_t)p4d | _PAGE_TABLE;
+	}
+
+	level3_kernel_pgt[PTRS_PER_PUD - 2].pud += load_delta;
+	level3_kernel_pgt[PTRS_PER_PUD - 1].pud += load_delta;
+
+	for (i = FIXMAP_PMD_TOP; i > FIXMAP_PMD_TOP - FIXMAP_PMD_NUM; i--)
+		level2_fixmap_pgt[i].pmd += load_delta;
+
+	/*
+	 * Set up the identity mapping for the switchover.  These
+	 * entries should *NOT* have the global bit set!  This also
+	 * creates a bunch of nonsense entries but that is fine --
+	 * it avoids problems around wraparound.
+	 */
+
+	pud = &early_pgts[0]->pmd;
+	pmd = &early_pgts[1]->pmd;
+	next_early_pgt = 2;
+
+	pgtable_flags = _KERNPG_TABLE_NOENC + sme_get_me_mask();
+
+	if (la57) {
+		p4d = &early_pgts[next_early_pgt++]->pmd;
+
+		i = (physaddr >> PGDIR_SHIFT) % PTRS_PER_PGD;
+		pgd[i + 0] = (pgdval_t)p4d + pgtable_flags;
+		pgd[i + 1] = (pgdval_t)p4d + pgtable_flags;
+
+		i = physaddr >> P4D_SHIFT;
+		p4d[(i + 0) % PTRS_PER_P4D] = (pgdval_t)pud + pgtable_flags;
+		p4d[(i + 1) % PTRS_PER_P4D] = (pgdval_t)pud + pgtable_flags;
+	} else {
+		i = (physaddr >> PGDIR_SHIFT) % PTRS_PER_PGD;
+		pgd[i + 0] = (pgdval_t)pud + pgtable_flags;
+		pgd[i + 1] = (pgdval_t)pud + pgtable_flags;
+	}
+
+	i = physaddr >> PUD_SHIFT;
+	pud[(i + 0) % PTRS_PER_PUD] = (pudval_t)pmd + pgtable_flags;
+	pud[(i + 1) % PTRS_PER_PUD] = (pudval_t)pmd + pgtable_flags;
+
+	pmd_entry = __PAGE_KERNEL_LARGE_EXEC & ~_PAGE_GLOBAL;
+	/* Filter out unsupported __PAGE_KERNEL_* bits: */
+	pmd_entry &= __supported_pte_mask;
+	pmd_entry += sme_get_me_mask();
+	pmd_entry +=  physaddr;
+
+	for (i = 0; i < DIV_ROUND_UP(va_end - va_text, PMD_SIZE); i++) {
+		int idx = i + (physaddr >> PMD_SHIFT);
+
+		pmd[idx % PTRS_PER_PMD] = pmd_entry + i * PMD_SIZE;
+	}
+
+	/*
+	 * Fixup the kernel text+data virtual addresses. Note that
+	 * we might write invalid pmds, when the kernel is relocated
+	 * cleanup_highmap() fixes this up along with the mappings
+	 * beyond _end.
+	 *
+	 * Only the region occupied by the kernel image has so far
+	 * been checked against the table of usable memory regions
+	 * provided by the firmware, so invalidate pages outside that
+	 * region. A page table entry that maps to a reserved area of
+	 * memory would allow processor speculation into that area,
+	 * and on some hardware (particularly the UV platform) even
+	 * speculative access to some reserved areas is caught as an
+	 * error, causing the BIOS to halt the system.
+	 */
+
+	pmd = &level2_kernel_pgt[0].pmd;
+
+	/* invalidate pages before the kernel image */
+	for (i = 0; i < pmd_index(va_text); i++)
+		pmd[i] &= ~_PAGE_PRESENT;
+
+	/* fixup pages that are part of the kernel image */
+	for (; i <= pmd_index(va_end); i++)
+		if (pmd[i] & _PAGE_PRESENT)
+			pmd[i] += load_delta;
+
+	/* invalidate pages after the kernel image */
+	for (; i < PTRS_PER_PMD; i++)
+		pmd[i] &= ~_PAGE_PRESENT;
+
+	return sme_postprocess_startup(bp, pmd, p2v_offset);
+}
diff --git a/arch/x86/kernel/head64.c b/arch/x86/kernel/head64.c
index 5b993b5..9afb123 100644
--- a/arch/x86/kernel/head64.c
+++ b/arch/x86/kernel/head64.c
@@ -47,235 +47,9 @@
  * Manage page tables very early on.
  */
 extern pmd_t early_dynamic_pgts[EARLY_DYNAMIC_PAGE_TABLES][PTRS_PER_PMD];
-static unsigned int __initdata next_early_pgt;
+unsigned int __initdata next_early_pgt;
 pmdval_t early_pmd_flags = __PAGE_KERNEL_LARGE & ~(_PAGE_GLOBAL | _PAGE_NX);
 
-#ifdef CONFIG_X86_5LEVEL
-unsigned int __pgtable_l5_enabled __ro_after_init;
-unsigned int pgdir_shift __ro_after_init = 39;
-EXPORT_SYMBOL(pgdir_shift);
-unsigned int ptrs_per_p4d __ro_after_init = 1;
-EXPORT_SYMBOL(ptrs_per_p4d);
-#endif
-
-#ifdef CONFIG_DYNAMIC_MEMORY_LAYOUT
-unsigned long page_offset_base __ro_after_init = __PAGE_OFFSET_BASE_L4;
-EXPORT_SYMBOL(page_offset_base);
-unsigned long vmalloc_base __ro_after_init = __VMALLOC_BASE_L4;
-EXPORT_SYMBOL(vmalloc_base);
-unsigned long vmemmap_base __ro_after_init = __VMEMMAP_BASE_L4;
-EXPORT_SYMBOL(vmemmap_base);
-#endif
-
-static inline bool check_la57_support(void)
-{
-	if (!IS_ENABLED(CONFIG_X86_5LEVEL))
-		return false;
-
-	/*
-	 * 5-level paging is detected and enabled at kernel decompression
-	 * stage. Only check if it has been enabled there.
-	 */
-	if (!(native_read_cr4() & X86_CR4_LA57))
-		return false;
-
-	RIP_REL_REF(__pgtable_l5_enabled)	= 1;
-	RIP_REL_REF(pgdir_shift)		= 48;
-	RIP_REL_REF(ptrs_per_p4d)		= 512;
-	RIP_REL_REF(page_offset_base)		= __PAGE_OFFSET_BASE_L5;
-	RIP_REL_REF(vmalloc_base)		= __VMALLOC_BASE_L5;
-	RIP_REL_REF(vmemmap_base)		= __VMEMMAP_BASE_L5;
-
-	return true;
-}
-
-static unsigned long __head sme_postprocess_startup(struct boot_params *bp,
-						    pmdval_t *pmd,
-						    unsigned long p2v_offset)
-{
-	unsigned long paddr, paddr_end;
-	int i;
-
-	/* Encrypt the kernel and related (if SME is active) */
-	sme_encrypt_kernel(bp);
-
-	/*
-	 * Clear the memory encryption mask from the .bss..decrypted section.
-	 * The bss section will be memset to zero later in the initialization so
-	 * there is no need to zero it after changing the memory encryption
-	 * attribute.
-	 */
-	if (sme_get_me_mask()) {
-		paddr = (unsigned long)&RIP_REL_REF(__start_bss_decrypted);
-		paddr_end = (unsigned long)&RIP_REL_REF(__end_bss_decrypted);
-
-		for (; paddr < paddr_end; paddr += PMD_SIZE) {
-			/*
-			 * On SNP, transition the page to shared in the RMP table so that
-			 * it is consistent with the page table attribute change.
-			 *
-			 * __start_bss_decrypted has a virtual address in the high range
-			 * mapping (kernel .text). PVALIDATE, by way of
-			 * early_snp_set_memory_shared(), requires a valid virtual
-			 * address but the kernel is currently running off of the identity
-			 * mapping so use the PA to get a *currently* valid virtual address.
-			 */
-			early_snp_set_memory_shared(paddr, paddr, PTRS_PER_PMD);
-
-			i = pmd_index(paddr - p2v_offset);
-			pmd[i] -= sme_get_me_mask();
-		}
-	}
-
-	/*
-	 * Return the SME encryption mask (if SME is active) to be used as a
-	 * modifier for the initial pgdir entry programmed into CR3.
-	 */
-	return sme_get_me_mask();
-}
-
-/* Code in __startup_64() can be relocated during execution, but the compiler
- * doesn't have to generate PC-relative relocations when accessing globals from
- * that function. Clang actually does not generate them, which leads to
- * boot-time crashes. To work around this problem, every global pointer must
- * be accessed using RIP_REL_REF(). Kernel virtual addresses can be determined
- * by subtracting p2v_offset from the RIP-relative address.
- */
-unsigned long __head __startup_64(unsigned long p2v_offset,
-				  struct boot_params *bp)
-{
-	pmd_t (*early_pgts)[PTRS_PER_PMD] = RIP_REL_REF(early_dynamic_pgts);
-	unsigned long physaddr = (unsigned long)&RIP_REL_REF(_text);
-	unsigned long va_text, va_end;
-	unsigned long pgtable_flags;
-	unsigned long load_delta;
-	pgdval_t *pgd;
-	p4dval_t *p4d;
-	pudval_t *pud;
-	pmdval_t *pmd, pmd_entry;
-	bool la57;
-	int i;
-
-	la57 = check_la57_support();
-
-	/* Is the address too large? */
-	if (physaddr >> MAX_PHYSMEM_BITS)
-		for (;;);
-
-	/*
-	 * Compute the delta between the address I am compiled to run at
-	 * and the address I am actually running at.
-	 */
-	load_delta = __START_KERNEL_map + p2v_offset;
-	RIP_REL_REF(phys_base) = load_delta;
-
-	/* Is the address not 2M aligned? */
-	if (load_delta & ~PMD_MASK)
-		for (;;);
-
-	va_text = physaddr - p2v_offset;
-	va_end  = (unsigned long)&RIP_REL_REF(_end) - p2v_offset;
-
-	/* Include the SME encryption mask in the fixup value */
-	load_delta += sme_get_me_mask();
-
-	/* Fixup the physical addresses in the page table */
-
-	pgd = &RIP_REL_REF(early_top_pgt)->pgd;
-	pgd[pgd_index(__START_KERNEL_map)] += load_delta;
-
-	if (IS_ENABLED(CONFIG_X86_5LEVEL) && la57) {
-		p4d = (p4dval_t *)&RIP_REL_REF(level4_kernel_pgt);
-		p4d[MAX_PTRS_PER_P4D - 1] += load_delta;
-
-		pgd[pgd_index(__START_KERNEL_map)] = (pgdval_t)p4d | _PAGE_TABLE;
-	}
-
-	RIP_REL_REF(level3_kernel_pgt)[PTRS_PER_PUD - 2].pud += load_delta;
-	RIP_REL_REF(level3_kernel_pgt)[PTRS_PER_PUD - 1].pud += load_delta;
-
-	for (i = FIXMAP_PMD_TOP; i > FIXMAP_PMD_TOP - FIXMAP_PMD_NUM; i--)
-		RIP_REL_REF(level2_fixmap_pgt)[i].pmd += load_delta;
-
-	/*
-	 * Set up the identity mapping for the switchover.  These
-	 * entries should *NOT* have the global bit set!  This also
-	 * creates a bunch of nonsense entries but that is fine --
-	 * it avoids problems around wraparound.
-	 */
-
-	pud = &early_pgts[0]->pmd;
-	pmd = &early_pgts[1]->pmd;
-	RIP_REL_REF(next_early_pgt) = 2;
-
-	pgtable_flags = _KERNPG_TABLE_NOENC + sme_get_me_mask();
-
-	if (la57) {
-		p4d = &early_pgts[RIP_REL_REF(next_early_pgt)++]->pmd;
-
-		i = (physaddr >> PGDIR_SHIFT) % PTRS_PER_PGD;
-		pgd[i + 0] = (pgdval_t)p4d + pgtable_flags;
-		pgd[i + 1] = (pgdval_t)p4d + pgtable_flags;
-
-		i = physaddr >> P4D_SHIFT;
-		p4d[(i + 0) % PTRS_PER_P4D] = (pgdval_t)pud + pgtable_flags;
-		p4d[(i + 1) % PTRS_PER_P4D] = (pgdval_t)pud + pgtable_flags;
-	} else {
-		i = (physaddr >> PGDIR_SHIFT) % PTRS_PER_PGD;
-		pgd[i + 0] = (pgdval_t)pud + pgtable_flags;
-		pgd[i + 1] = (pgdval_t)pud + pgtable_flags;
-	}
-
-	i = physaddr >> PUD_SHIFT;
-	pud[(i + 0) % PTRS_PER_PUD] = (pudval_t)pmd + pgtable_flags;
-	pud[(i + 1) % PTRS_PER_PUD] = (pudval_t)pmd + pgtable_flags;
-
-	pmd_entry = __PAGE_KERNEL_LARGE_EXEC & ~_PAGE_GLOBAL;
-	/* Filter out unsupported __PAGE_KERNEL_* bits: */
-	pmd_entry &= RIP_REL_REF(__supported_pte_mask);
-	pmd_entry += sme_get_me_mask();
-	pmd_entry +=  physaddr;
-
-	for (i = 0; i < DIV_ROUND_UP(va_end - va_text, PMD_SIZE); i++) {
-		int idx = i + (physaddr >> PMD_SHIFT);
-
-		pmd[idx % PTRS_PER_PMD] = pmd_entry + i * PMD_SIZE;
-	}
-
-	/*
-	 * Fixup the kernel text+data virtual addresses. Note that
-	 * we might write invalid pmds, when the kernel is relocated
-	 * cleanup_highmap() fixes this up along with the mappings
-	 * beyond _end.
-	 *
-	 * Only the region occupied by the kernel image has so far
-	 * been checked against the table of usable memory regions
-	 * provided by the firmware, so invalidate pages outside that
-	 * region. A page table entry that maps to a reserved area of
-	 * memory would allow processor speculation into that area,
-	 * and on some hardware (particularly the UV platform) even
-	 * speculative access to some reserved areas is caught as an
-	 * error, causing the BIOS to halt the system.
-	 */
-
-	pmd = &RIP_REL_REF(level2_kernel_pgt)->pmd;
-
-	/* invalidate pages before the kernel image */
-	for (i = 0; i < pmd_index(va_text); i++)
-		pmd[i] &= ~_PAGE_PRESENT;
-
-	/* fixup pages that are part of the kernel image */
-	for (; i <= pmd_index(va_end); i++)
-		if (pmd[i] & _PAGE_PRESENT)
-			pmd[i] += load_delta;
-
-	/* invalidate pages after the kernel image */
-	for (; i < PTRS_PER_PMD; i++)
-		pmd[i] &= ~_PAGE_PRESENT;
-
-	return sme_postprocess_startup(bp, pmd, p2v_offset);
-}
-
 /* Wipe all early page tables except for the kernel symbol map */
 static void __init reset_early_page_tables(void)
 {

