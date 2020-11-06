Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ACEA62AA126
	for <lists+linux-tip-commits@lfdr.de>; Sat,  7 Nov 2020 00:28:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729100AbgKFX1z (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 6 Nov 2020 18:27:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728988AbgKFX11 (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 6 Nov 2020 18:27:27 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3334C0613CF;
        Fri,  6 Nov 2020 15:27:26 -0800 (PST)
Date:   Fri, 06 Nov 2020 23:27:23 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1604705244;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6488FqrBwoXekAF6Opc6Ikkh72SjhaWYDBKzH4KPuxQ=;
        b=qocGegMRpIgqby0phErq8Wy4gaGLJsZ1I+WTngnORJaue4la8kUExVasnZi4J0g2XFePtr
        XnXvcdsQud9z+C/e++r2R9rudfMq5i0pjmPLAq+8QSxytHMBlpwKr9Yauh8HykPG/NuBEO
        yJ/Dji/t355OfbXOno9+glHcF6+4giYQTs1AQckBq2ABYA3VH6l8esCCxGO5ByNobhvBd6
        DVz9/QZpZRqAqn/qKAjZ3GyNdFzb4OKfX+uN5YP7UesH0qT/rrqzK/0j/7Jf8JBEU1fde8
        oRt+iFVfzMeT1z9w+gxSpyU9/Eqb5++fkMnde080IjsVRh9dssKTQxazv5kA9w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1604705244;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6488FqrBwoXekAF6Opc6Ikkh72SjhaWYDBKzH4KPuxQ=;
        b=YX09fQ9Jm60O7b7gOD1o9Mw/gKmEBKsaiq+IS0KFpjlybHlHLggs4A83DWjSx+3IbM54gy
        vhihhw1MF/Gy//CA==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/mm] x86/mm/highmem: Use generic kmap atomic implementation
Cc:     Thomas Gleixner <tglx@linutronix.de>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20201103095857.375127260@linutronix.de>
References: <20201103095857.375127260@linutronix.de>
MIME-Version: 1.0
Message-ID: <160470524327.397.10859954425941165692.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the core/mm branch of tip:

Commit-ID:     157e118b55113d1e6c7f8ddfcec0a1dbf3a69511
Gitweb:        https://git.kernel.org/tip/157e118b55113d1e6c7f8ddfcec0a1dbf3a69511
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Tue, 03 Nov 2020 10:27:20 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Fri, 06 Nov 2020 23:14:55 +01:00

x86/mm/highmem: Use generic kmap atomic implementation

Convert X86 to the generic kmap atomic implementation and make the
iomap_atomic() naming convention consistent while at it.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/20201103095857.375127260@linutronix.de

---
 arch/x86/Kconfig                      |  3 +-
 arch/x86/include/asm/fixmap.h         |  5 +--
 arch/x86/include/asm/highmem.h        | 13 ++++--
 arch/x86/include/asm/iomap.h          | 18 ++++----
 arch/x86/include/asm/kmap_types.h     | 13 +------
 arch/x86/include/asm/paravirt_types.h |  1 +-
 arch/x86/mm/highmem_32.c              | 59 +--------------------------
 arch/x86/mm/init_32.c                 | 15 +-------
 arch/x86/mm/iomap_32.c                | 59 ++------------------------
 include/linux/highmem.h               |  2 +-
 include/linux/io-mapping.h            |  2 +-
 mm/highmem.c                          |  2 +-
 12 files changed, 31 insertions(+), 161 deletions(-)
 delete mode 100644 arch/x86/include/asm/kmap_types.h

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index f6946b8..33c273c 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -14,10 +14,11 @@ config X86_32
 	select ARCH_WANT_IPC_PARSE_VERSION
 	select CLKSRC_I8253
 	select CLONE_BACKWARDS
+	select GENERIC_VDSO_32
 	select HAVE_DEBUG_STACKOVERFLOW
+	select KMAP_LOCAL
 	select MODULES_USE_ELF_REL
 	select OLD_SIGACTION
-	select GENERIC_VDSO_32
 
 config X86_64
 	def_bool y
diff --git a/arch/x86/include/asm/fixmap.h b/arch/x86/include/asm/fixmap.h
index 77217bd..8eba66a 100644
--- a/arch/x86/include/asm/fixmap.h
+++ b/arch/x86/include/asm/fixmap.h
@@ -31,7 +31,7 @@
 #include <asm/pgtable_types.h>
 #ifdef CONFIG_X86_32
 #include <linux/threads.h>
-#include <asm/kmap_types.h>
+#include <asm/kmap_size.h>
 #else
 #include <uapi/asm/vsyscall.h>
 #endif
@@ -94,7 +94,7 @@ enum fixed_addresses {
 #endif
 #ifdef CONFIG_X86_32
 	FIX_KMAP_BEGIN,	/* reserved pte's for temporary kernel mappings */
-	FIX_KMAP_END = FIX_KMAP_BEGIN+(KM_TYPE_NR*NR_CPUS)-1,
+	FIX_KMAP_END = FIX_KMAP_BEGIN + (KM_MAX_IDX * NR_CPUS) - 1,
 #ifdef CONFIG_PCI_MMCONFIG
 	FIX_PCIE_MCFG,
 #endif
@@ -151,7 +151,6 @@ extern void reserve_top_address(unsigned long reserve);
 
 extern int fixmaps_set;
 
-extern pte_t *kmap_pte;
 extern pte_t *pkmap_page_table;
 
 void __native_set_fixmap(enum fixed_addresses idx, pte_t pte);
diff --git a/arch/x86/include/asm/highmem.h b/arch/x86/include/asm/highmem.h
index 0f420b2..032e020 100644
--- a/arch/x86/include/asm/highmem.h
+++ b/arch/x86/include/asm/highmem.h
@@ -23,7 +23,6 @@
 
 #include <linux/interrupt.h>
 #include <linux/threads.h>
-#include <asm/kmap_types.h>
 #include <asm/tlbflush.h>
 #include <asm/paravirt.h>
 #include <asm/fixmap.h>
@@ -58,11 +57,17 @@ extern unsigned long highstart_pfn, highend_pfn;
 #define PKMAP_NR(virt)  ((virt-PKMAP_BASE) >> PAGE_SHIFT)
 #define PKMAP_ADDR(nr)  (PKMAP_BASE + ((nr) << PAGE_SHIFT))
 
-void *kmap_atomic_pfn(unsigned long pfn);
-void *kmap_atomic_prot_pfn(unsigned long pfn, pgprot_t prot);
-
 #define flush_cache_kmaps()	do { } while (0)
 
+#define	arch_kmap_local_post_map(vaddr, pteval)		\
+	arch_flush_lazy_mmu_mode()
+
+#define	arch_kmap_local_post_unmap(vaddr)		\
+	do {						\
+		flush_tlb_one_kernel((vaddr));		\
+		arch_flush_lazy_mmu_mode();		\
+	} while (0)
+
 extern void add_highpages_with_active_regions(int nid, unsigned long start_pfn,
 					unsigned long end_pfn);
 
diff --git a/arch/x86/include/asm/iomap.h b/arch/x86/include/asm/iomap.h
index bacf68c..0be7a30 100644
--- a/arch/x86/include/asm/iomap.h
+++ b/arch/x86/include/asm/iomap.h
@@ -9,19 +9,21 @@
 #include <linux/fs.h>
 #include <linux/mm.h>
 #include <linux/uaccess.h>
+#include <linux/highmem.h>
 #include <asm/cacheflush.h>
 #include <asm/tlbflush.h>
 
-void __iomem *
-iomap_atomic_prot_pfn(unsigned long pfn, pgprot_t prot);
+void __iomem *iomap_atomic_pfn_prot(unsigned long pfn, pgprot_t prot);
 
-void
-iounmap_atomic(void __iomem *kvaddr);
+static inline void iounmap_atomic(void __iomem *vaddr)
+{
+	kunmap_local_indexed((void __force *)vaddr);
+	pagefault_enable();
+	preempt_enable();
+}
 
-int
-iomap_create_wc(resource_size_t base, unsigned long size, pgprot_t *prot);
+int iomap_create_wc(resource_size_t base, unsigned long size, pgprot_t *prot);
 
-void
-iomap_free(resource_size_t base, unsigned long size);
+void iomap_free(resource_size_t base, unsigned long size);
 
 #endif /* _ASM_X86_IOMAP_H */
diff --git a/arch/x86/include/asm/kmap_types.h b/arch/x86/include/asm/kmap_types.h
deleted file mode 100644
index 04ab826..0000000
--- a/arch/x86/include/asm/kmap_types.h
+++ /dev/null
@@ -1,13 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-#ifndef _ASM_X86_KMAP_TYPES_H
-#define _ASM_X86_KMAP_TYPES_H
-
-#if defined(CONFIG_X86_32) && defined(CONFIG_DEBUG_HIGHMEM)
-#define  __WITH_KM_FENCE
-#endif
-
-#include <asm-generic/kmap_types.h>
-
-#undef __WITH_KM_FENCE
-
-#endif /* _ASM_X86_KMAP_TYPES_H */
diff --git a/arch/x86/include/asm/paravirt_types.h b/arch/x86/include/asm/paravirt_types.h
index 0fad9f6..b6b02b7 100644
--- a/arch/x86/include/asm/paravirt_types.h
+++ b/arch/x86/include/asm/paravirt_types.h
@@ -41,7 +41,6 @@
 #ifndef __ASSEMBLY__
 
 #include <asm/desc_defs.h>
-#include <asm/kmap_types.h>
 #include <asm/pgtable_types.h>
 #include <asm/nospec-branch.h>
 
diff --git a/arch/x86/mm/highmem_32.c b/arch/x86/mm/highmem_32.c
index 075fe51..2c54b76 100644
--- a/arch/x86/mm/highmem_32.c
+++ b/arch/x86/mm/highmem_32.c
@@ -4,65 +4,6 @@
 #include <linux/swap.h> /* for totalram_pages */
 #include <linux/memblock.h>
 
-void *kmap_atomic_high_prot(struct page *page, pgprot_t prot)
-{
-	unsigned long vaddr;
-	int idx, type;
-
-	type = kmap_atomic_idx_push();
-	idx = type + KM_TYPE_NR*smp_processor_id();
-	vaddr = __fix_to_virt(FIX_KMAP_BEGIN + idx);
-	BUG_ON(!pte_none(*(kmap_pte-idx)));
-	set_pte(kmap_pte-idx, mk_pte(page, prot));
-	arch_flush_lazy_mmu_mode();
-
-	return (void *)vaddr;
-}
-EXPORT_SYMBOL(kmap_atomic_high_prot);
-
-/*
- * This is the same as kmap_atomic() but can map memory that doesn't
- * have a struct page associated with it.
- */
-void *kmap_atomic_pfn(unsigned long pfn)
-{
-	return kmap_atomic_prot_pfn(pfn, kmap_prot);
-}
-EXPORT_SYMBOL_GPL(kmap_atomic_pfn);
-
-void kunmap_atomic_high(void *kvaddr)
-{
-	unsigned long vaddr = (unsigned long) kvaddr & PAGE_MASK;
-
-	if (vaddr >= __fix_to_virt(FIX_KMAP_END) &&
-	    vaddr <= __fix_to_virt(FIX_KMAP_BEGIN)) {
-		int idx, type;
-
-		type = kmap_atomic_idx();
-		idx = type + KM_TYPE_NR * smp_processor_id();
-
-#ifdef CONFIG_DEBUG_HIGHMEM
-		WARN_ON_ONCE(vaddr != __fix_to_virt(FIX_KMAP_BEGIN + idx));
-#endif
-		/*
-		 * Force other mappings to Oops if they'll try to access this
-		 * pte without first remap it.  Keeping stale mappings around
-		 * is a bad idea also, in case the page changes cacheability
-		 * attributes or becomes a protected page in a hypervisor.
-		 */
-		kpte_clear_flush(kmap_pte-idx, vaddr);
-		kmap_atomic_idx_pop();
-		arch_flush_lazy_mmu_mode();
-	}
-#ifdef CONFIG_DEBUG_HIGHMEM
-	else {
-		BUG_ON(vaddr < PAGE_OFFSET);
-		BUG_ON(vaddr >= (unsigned long)high_memory);
-	}
-#endif
-}
-EXPORT_SYMBOL(kunmap_atomic_high);
-
 void __init set_highmem_pages_init(void)
 {
 	struct zone *zone;
diff --git a/arch/x86/mm/init_32.c b/arch/x86/mm/init_32.c
index 7c05525..da31c26 100644
--- a/arch/x86/mm/init_32.c
+++ b/arch/x86/mm/init_32.c
@@ -394,19 +394,6 @@ repeat:
 	return last_map_addr;
 }
 
-pte_t *kmap_pte;
-
-static void __init kmap_init(void)
-{
-	unsigned long kmap_vstart;
-
-	/*
-	 * Cache the first kmap pte:
-	 */
-	kmap_vstart = __fix_to_virt(FIX_KMAP_BEGIN);
-	kmap_pte = virt_to_kpte(kmap_vstart);
-}
-
 #ifdef CONFIG_HIGHMEM
 static void __init permanent_kmaps_init(pgd_t *pgd_base)
 {
@@ -712,8 +699,6 @@ void __init paging_init(void)
 
 	__flush_tlb_all();
 
-	kmap_init();
-
 	/*
 	 * NOTE: at this point the bootmem allocator is fully available.
 	 */
diff --git a/arch/x86/mm/iomap_32.c b/arch/x86/mm/iomap_32.c
index f60398a..e0a40d7 100644
--- a/arch/x86/mm/iomap_32.c
+++ b/arch/x86/mm/iomap_32.c
@@ -44,28 +44,7 @@ void iomap_free(resource_size_t base, unsigned long size)
 }
 EXPORT_SYMBOL_GPL(iomap_free);
 
-void *kmap_atomic_prot_pfn(unsigned long pfn, pgprot_t prot)
-{
-	unsigned long vaddr;
-	int idx, type;
-
-	preempt_disable();
-	pagefault_disable();
-
-	type = kmap_atomic_idx_push();
-	idx = type + KM_TYPE_NR * smp_processor_id();
-	vaddr = __fix_to_virt(FIX_KMAP_BEGIN + idx);
-	set_pte(kmap_pte - idx, pfn_pte(pfn, prot));
-	arch_flush_lazy_mmu_mode();
-
-	return (void *)vaddr;
-}
-
-/*
- * Map 'pfn' using protections 'prot'
- */
-void __iomem *
-iomap_atomic_prot_pfn(unsigned long pfn, pgprot_t prot)
+void __iomem *iomap_atomic_pfn_prot(unsigned long pfn, pgprot_t prot)
 {
 	/*
 	 * For non-PAT systems, translate non-WB request to UC- just in
@@ -81,36 +60,8 @@ iomap_atomic_prot_pfn(unsigned long pfn, pgprot_t prot)
 	/* Filter out unsupported __PAGE_KERNEL* bits: */
 	pgprot_val(prot) &= __default_kernel_pte_mask;
 
-	return (void __force __iomem *) kmap_atomic_prot_pfn(pfn, prot);
-}
-EXPORT_SYMBOL_GPL(iomap_atomic_prot_pfn);
-
-void
-iounmap_atomic(void __iomem *kvaddr)
-{
-	unsigned long vaddr = (unsigned long) kvaddr & PAGE_MASK;
-
-	if (vaddr >= __fix_to_virt(FIX_KMAP_END) &&
-	    vaddr <= __fix_to_virt(FIX_KMAP_BEGIN)) {
-		int idx, type;
-
-		type = kmap_atomic_idx();
-		idx = type + KM_TYPE_NR * smp_processor_id();
-
-#ifdef CONFIG_DEBUG_HIGHMEM
-		WARN_ON_ONCE(vaddr != __fix_to_virt(FIX_KMAP_BEGIN + idx));
-#endif
-		/*
-		 * Force other mappings to Oops if they'll try to access this
-		 * pte without first remap it.  Keeping stale mappings around
-		 * is a bad idea also, in case the page changes cacheability
-		 * attributes or becomes a protected page in a hypervisor.
-		 */
-		kpte_clear_flush(kmap_pte-idx, vaddr);
-		kmap_atomic_idx_pop();
-	}
-
-	pagefault_enable();
-	preempt_enable();
+	preempt_disable();
+	pagefault_disable();
+	return (void __force __iomem *)__kmap_local_pfn_prot(pfn, prot);
 }
-EXPORT_SYMBOL_GPL(iounmap_atomic);
+EXPORT_SYMBOL_GPL(iomap_atomic_pfn_prot);
diff --git a/include/linux/highmem.h b/include/linux/highmem.h
index f5ecee9..1222a31 100644
--- a/include/linux/highmem.h
+++ b/include/linux/highmem.h
@@ -217,7 +217,7 @@ static inline void __kunmap_atomic(void *addr)
 #endif /* CONFIG_HIGHMEM */
 
 #if !defined(CONFIG_KMAP_LOCAL)
-#if defined(CONFIG_HIGHMEM) || defined(CONFIG_X86_32)
+#if defined(CONFIG_HIGHMEM)
 
 DECLARE_PER_CPU(int, __kmap_atomic_idx);
 
diff --git a/include/linux/io-mapping.h b/include/linux/io-mapping.h
index c75e4d3..3b0940b 100644
--- a/include/linux/io-mapping.h
+++ b/include/linux/io-mapping.h
@@ -69,7 +69,7 @@ io_mapping_map_atomic_wc(struct io_mapping *mapping,
 
 	BUG_ON(offset >= mapping->size);
 	phys_addr = mapping->base + offset;
-	return iomap_atomic_prot_pfn(PHYS_PFN(phys_addr), mapping->prot);
+	return iomap_atomic_pfn_prot(PHYS_PFN(phys_addr), mapping->prot);
 }
 
 static inline void
diff --git a/mm/highmem.c b/mm/highmem.c
index 67d2d59..77677c6 100644
--- a/mm/highmem.c
+++ b/mm/highmem.c
@@ -32,7 +32,7 @@
 #include <linux/vmalloc.h>
 
 #ifndef CONFIG_KMAP_LOCAL
-#if defined(CONFIG_HIGHMEM) || defined(CONFIG_X86_32)
+#ifdef CONFIG_HIGHMEM
 DEFINE_PER_CPU(int, __kmap_atomic_idx);
 #endif
 #endif
