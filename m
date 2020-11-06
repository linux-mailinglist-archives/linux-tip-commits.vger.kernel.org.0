Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 94CB82AA128
	for <lists+linux-tip-commits@lfdr.de>; Sat,  7 Nov 2020 00:28:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729109AbgKFX1z (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 6 Nov 2020 18:27:55 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:38434 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728951AbgKFX10 (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 6 Nov 2020 18:27:26 -0500
Date:   Fri, 06 Nov 2020 23:27:21 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1604705242;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tqfYailm5pUmac9hsjq9IE3eD24iTDYLDOSZRwHF4A8=;
        b=LEJPs23Cd+utFm4S3CMPme/wdUpcgcaj/jhnoJpg1PuyYA+nzGVM+7NTkq5kZSNiaAo+uG
        5NMxIX3eiivhzg/IgDbN6NbocQrB2sFZkAT3n6vc+wJsc31Emp7QHB8XRYyX7NmznOefpD
        CSIP0FlKj1iVZcFtxTuGDvT1v+UahRW7K7HWCtffsvzufoq7c4/5L95mThF/LcrB1iM2kT
        E31X2YGs9VKifFHbfD4vTjf/1a/HOhc6TpcQzrMg+l8oqsoYkRbRhvc1ebJ8I88ITveM+2
        +5F/G2EYr5/E1rkHjyaJY4iEVjWJPxG5QzFNKXfYtZoI9UIHRPmkScLXdT6Lww==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1604705242;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tqfYailm5pUmac9hsjq9IE3eD24iTDYLDOSZRwHF4A8=;
        b=DATxQpLRXKex1ypl67Pua4FCQiBZImmsFdUbqVFZxC+5q0v4yWB415APhG+E0n77guEa7o
        1wU8d0AzrAuppRAA==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/mm] ARM: highmem: Switch to generic kmap atomic
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Russell King <linux@armlinux.org.uk>,
        Arnd Bergmann <arnd@arndb.de>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20201103095857.582196476@linutronix.de>
References: <20201103095857.582196476@linutronix.de>
MIME-Version: 1.0
Message-ID: <160470524157.397.1127537148470073372.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the core/mm branch of tip:

Commit-ID:     2a15ba82fa6ca3f35502b3060f22118a938d2889
Gitweb:        https://git.kernel.org/tip/2a15ba82fa6ca3f35502b3060f22118a938d2889
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Tue, 03 Nov 2020 10:27:22 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Fri, 06 Nov 2020 23:14:56 +01:00

ARM: highmem: Switch to generic kmap atomic

No reason having the same code in every architecture.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Russell King <linux@armlinux.org.uk>
Cc: Arnd Bergmann <arnd@arndb.de>
Link: https://lore.kernel.org/r/20201103095857.582196476@linutronix.de

---
 arch/arm/Kconfig                  |   1 +-
 arch/arm/include/asm/fixmap.h     |   4 +-
 arch/arm/include/asm/highmem.h    |  33 +++++---
 arch/arm/include/asm/kmap_types.h |  10 +--
 arch/arm/mm/Makefile              |   1 +-
 arch/arm/mm/highmem.c             | 121 +-----------------------------
 6 files changed, 26 insertions(+), 144 deletions(-)
 delete mode 100644 arch/arm/include/asm/kmap_types.h
 delete mode 100644 arch/arm/mm/highmem.c

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index fe2f17e..46f8900 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -1498,6 +1498,7 @@ config HAVE_ARCH_PFN_VALID
 config HIGHMEM
 	bool "High Memory Support"
 	depends on MMU
+	select KMAP_LOCAL
 	help
 	  The address space of ARM processors is only 4 Gigabytes large
 	  and it has to accommodate user address space, kernel address
diff --git a/arch/arm/include/asm/fixmap.h b/arch/arm/include/asm/fixmap.h
index fc56fc3..c279a8a 100644
--- a/arch/arm/include/asm/fixmap.h
+++ b/arch/arm/include/asm/fixmap.h
@@ -7,14 +7,14 @@
 #define FIXADDR_TOP		(FIXADDR_END - PAGE_SIZE)
 
 #include <linux/pgtable.h>
-#include <asm/kmap_types.h>
+#include <asm/kmap_size.h>
 
 enum fixed_addresses {
 	FIX_EARLYCON_MEM_BASE,
 	__end_of_permanent_fixed_addresses,
 
 	FIX_KMAP_BEGIN = __end_of_permanent_fixed_addresses,
-	FIX_KMAP_END = FIX_KMAP_BEGIN + (KM_TYPE_NR * NR_CPUS) - 1,
+	FIX_KMAP_END = FIX_KMAP_BEGIN + (KM_MAX_IDX * NR_CPUS) - 1,
 
 	/* Support writing RO kernel text via kprobes, jump labels, etc. */
 	FIX_TEXT_POKE0,
diff --git a/arch/arm/include/asm/highmem.h b/arch/arm/include/asm/highmem.h
index 31811be..a41de52 100644
--- a/arch/arm/include/asm/highmem.h
+++ b/arch/arm/include/asm/highmem.h
@@ -2,7 +2,7 @@
 #ifndef _ASM_HIGHMEM_H
 #define _ASM_HIGHMEM_H
 
-#include <asm/kmap_types.h>
+#include <asm/fixmap.h>
 
 #define PKMAP_BASE		(PAGE_OFFSET - PMD_SIZE)
 #define LAST_PKMAP		PTRS_PER_PTE
@@ -46,19 +46,32 @@ extern pte_t *pkmap_page_table;
 
 #ifdef ARCH_NEEDS_KMAP_HIGH_GET
 extern void *kmap_high_get(struct page *page);
-#else
+
+static inline void *arch_kmap_local_high_get(struct page *page)
+{
+	if (IS_ENABLED(CONFIG_DEBUG_HIGHMEM) && !cache_is_vivt())
+		return NULL;
+	return kmap_high_get(page);
+}
+#define arch_kmap_local_high_get arch_kmap_local_high_get
+
+#else /* ARCH_NEEDS_KMAP_HIGH_GET */
 static inline void *kmap_high_get(struct page *page)
 {
 	return NULL;
 }
-#endif
+#endif /* !ARCH_NEEDS_KMAP_HIGH_GET */
 
-/*
- * The following functions are already defined by <linux/highmem.h>
- * when CONFIG_HIGHMEM is not set.
- */
-#ifdef CONFIG_HIGHMEM
-extern void *kmap_atomic_pfn(unsigned long pfn);
-#endif
+#define arch_kmap_local_post_map(vaddr, pteval)				\
+	local_flush_tlb_kernel_page(vaddr)
+
+#define arch_kmap_local_pre_unmap(vaddr)				\
+do {									\
+	if (cache_is_vivt())						\
+		__cpuc_flush_dcache_area((void *)vaddr, PAGE_SIZE);	\
+} while (0)
+
+#define arch_kmap_local_post_unmap(vaddr)				\
+	local_flush_tlb_kernel_page(vaddr)
 
 #endif
diff --git a/arch/arm/include/asm/kmap_types.h b/arch/arm/include/asm/kmap_types.h
deleted file mode 100644
index 5590940..0000000
--- a/arch/arm/include/asm/kmap_types.h
+++ /dev/null
@@ -1,10 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-#ifndef __ARM_KMAP_TYPES_H
-#define __ARM_KMAP_TYPES_H
-
-/*
- * This is the "bare minimum".  AIO seems to require this.
- */
-#define KM_TYPE_NR 16
-
-#endif
diff --git a/arch/arm/mm/Makefile b/arch/arm/mm/Makefile
index 7cb1699..c4ce477 100644
--- a/arch/arm/mm/Makefile
+++ b/arch/arm/mm/Makefile
@@ -19,7 +19,6 @@ obj-$(CONFIG_MODULES)		+= proc-syms.o
 obj-$(CONFIG_DEBUG_VIRTUAL)	+= physaddr.o
 
 obj-$(CONFIG_ALIGNMENT_TRAP)	+= alignment.o
-obj-$(CONFIG_HIGHMEM)		+= highmem.o
 obj-$(CONFIG_HUGETLB_PAGE)	+= hugetlbpage.o
 obj-$(CONFIG_ARM_PV_FIXUP)	+= pv-fixup-asm.o
 
diff --git a/arch/arm/mm/highmem.c b/arch/arm/mm/highmem.c
deleted file mode 100644
index 187fab2..0000000
--- a/arch/arm/mm/highmem.c
+++ /dev/null
@@ -1,121 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-only
-/*
- * arch/arm/mm/highmem.c -- ARM highmem support
- *
- * Author:	Nicolas Pitre
- * Created:	september 8, 2008
- * Copyright:	Marvell Semiconductors Inc.
- */
-
-#include <linux/module.h>
-#include <linux/highmem.h>
-#include <linux/interrupt.h>
-#include <asm/fixmap.h>
-#include <asm/cacheflush.h>
-#include <asm/tlbflush.h>
-#include "mm.h"
-
-static inline void set_fixmap_pte(int idx, pte_t pte)
-{
-	unsigned long vaddr = __fix_to_virt(idx);
-	pte_t *ptep = virt_to_kpte(vaddr);
-
-	set_pte_ext(ptep, pte, 0);
-	local_flush_tlb_kernel_page(vaddr);
-}
-
-static inline pte_t get_fixmap_pte(unsigned long vaddr)
-{
-	pte_t *ptep = virt_to_kpte(vaddr);
-
-	return *ptep;
-}
-
-void *kmap_atomic_high_prot(struct page *page, pgprot_t prot)
-{
-	unsigned int idx;
-	unsigned long vaddr;
-	void *kmap;
-	int type;
-
-#ifdef CONFIG_DEBUG_HIGHMEM
-	/*
-	 * There is no cache coherency issue when non VIVT, so force the
-	 * dedicated kmap usage for better debugging purposes in that case.
-	 */
-	if (!cache_is_vivt())
-		kmap = NULL;
-	else
-#endif
-		kmap = kmap_high_get(page);
-	if (kmap)
-		return kmap;
-
-	type = kmap_atomic_idx_push();
-
-	idx = FIX_KMAP_BEGIN + type + KM_TYPE_NR * smp_processor_id();
-	vaddr = __fix_to_virt(idx);
-#ifdef CONFIG_DEBUG_HIGHMEM
-	/*
-	 * With debugging enabled, kunmap_atomic forces that entry to 0.
-	 * Make sure it was indeed properly unmapped.
-	 */
-	BUG_ON(!pte_none(get_fixmap_pte(vaddr)));
-#endif
-	/*
-	 * When debugging is off, kunmap_atomic leaves the previous mapping
-	 * in place, so the contained TLB flush ensures the TLB is updated
-	 * with the new mapping.
-	 */
-	set_fixmap_pte(idx, mk_pte(page, prot));
-
-	return (void *)vaddr;
-}
-EXPORT_SYMBOL(kmap_atomic_high_prot);
-
-void kunmap_atomic_high(void *kvaddr)
-{
-	unsigned long vaddr = (unsigned long) kvaddr & PAGE_MASK;
-	int idx, type;
-
-	if (kvaddr >= (void *)FIXADDR_START) {
-		type = kmap_atomic_idx();
-		idx = FIX_KMAP_BEGIN + type + KM_TYPE_NR * smp_processor_id();
-
-		if (cache_is_vivt())
-			__cpuc_flush_dcache_area((void *)vaddr, PAGE_SIZE);
-#ifdef CONFIG_DEBUG_HIGHMEM
-		BUG_ON(vaddr != __fix_to_virt(idx));
-		set_fixmap_pte(idx, __pte(0));
-#else
-		(void) idx;  /* to kill a warning */
-#endif
-		kmap_atomic_idx_pop();
-	} else if (vaddr >= PKMAP_ADDR(0) && vaddr < PKMAP_ADDR(LAST_PKMAP)) {
-		/* this address was obtained through kmap_high_get() */
-		kunmap_high(pte_page(pkmap_page_table[PKMAP_NR(vaddr)]));
-	}
-}
-EXPORT_SYMBOL(kunmap_atomic_high);
-
-void *kmap_atomic_pfn(unsigned long pfn)
-{
-	unsigned long vaddr;
-	int idx, type;
-	struct page *page = pfn_to_page(pfn);
-
-	preempt_disable();
-	pagefault_disable();
-	if (!PageHighMem(page))
-		return page_address(page);
-
-	type = kmap_atomic_idx_push();
-	idx = FIX_KMAP_BEGIN + type + KM_TYPE_NR * smp_processor_id();
-	vaddr = __fix_to_virt(idx);
-#ifdef CONFIG_DEBUG_HIGHMEM
-	BUG_ON(!pte_none(get_fixmap_pte(vaddr)));
-#endif
-	set_fixmap_pte(idx, pfn_pte(pfn, kmap_prot));
-
-	return (void *)vaddr;
-}
