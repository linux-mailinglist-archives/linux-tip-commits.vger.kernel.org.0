Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 976741CF754
	for <lists+linux-tip-commits@lfdr.de>; Tue, 12 May 2020 16:37:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730482AbgELOhg (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Tue, 12 May 2020 10:37:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730399AbgELOhM (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Tue, 12 May 2020 10:37:12 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A609EC061A0C;
        Tue, 12 May 2020 07:37:11 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jYW1n-0005ro-0K; Tue, 12 May 2020 16:37:03 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 7AA8B1C04E3;
        Tue, 12 May 2020 16:37:00 +0200 (CEST)
Date:   Tue, 12 May 2020 14:37:00 -0000
From:   "tip-bot2 for Will Deacon" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/kcsan] sparc32: mm: Restructure sparc32 MMU page-table layout
Cc:     Will Deacon <will@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        "David S. Miller" <davem@davemloft.net>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200511204150.27858-3-will@kernel.org>
References: <20200511204150.27858-3-will@kernel.org>
MIME-Version: 1.0
Message-ID: <158929422036.390.11858005370420637887.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-tip-commits-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the locking/kcsan branch of tip:

Commit-ID:     3408974d0533e1e9bd6345610b335c7c52195a49
Gitweb:        https://git.kernel.org/tip/3408974d0533e1e9bd6345610b335c7c52195a49
Author:        Will Deacon <will@kernel.org>
AuthorDate:    Mon, 11 May 2020 21:41:34 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 12 May 2020 11:04:09 +02:00

sparc32: mm: Restructure sparc32 MMU page-table layout

The "SRMMU" supports 4k pages using a fixed three-level walk with a
256-entry PGD and 64-entry PMD/PTE levels. In order to fill a page
with a 'pgtable_t', the SRMMU code allocates four native PTE tables
into a single PTE allocation and similarly for the PMD level, leading
to an array of 16 physical pointers in a 'pmd_t'

This breaks the generic code which assumes READ_ONCE(*pmd) will be
word sized.

In a manner similar to ef22d8abd876 ("m68k: mm: Restructure Motorola MMU
page-table layout"), implement the native page-table setup directly. This
significantly increases the page-table memory overhead, but will be
addressed in a subsequent patch.

Signed-off-by: Will Deacon <will@kernel.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: "David S. Miller" <davem@davemloft.net>
Link: https://lkml.kernel.org/r/20200511204150.27858-3-will@kernel.org

---
 arch/sparc/include/asm/page_32.h    | 10 ++---
 arch/sparc/include/asm/pgalloc_32.h |  5 +-
 arch/sparc/include/asm/pgtable_32.h | 29 +++++++-------
 arch/sparc/include/asm/pgtsrmmu.h   | 36 +----------------
 arch/sparc/include/asm/viking.h     |  5 +-
 arch/sparc/kernel/head_32.S         |  8 ++--
 arch/sparc/mm/hypersparc.S          |  3 +-
 arch/sparc/mm/srmmu.c               | 60 +++++++++-------------------
 arch/sparc/mm/viking.S              |  5 +-
 9 files changed, 58 insertions(+), 103 deletions(-)

diff --git a/arch/sparc/include/asm/page_32.h b/arch/sparc/include/asm/page_32.h
index 4782600..da01c8c 100644
--- a/arch/sparc/include/asm/page_32.h
+++ b/arch/sparc/include/asm/page_32.h
@@ -54,7 +54,7 @@ extern struct sparc_phys_banks sp_banks[SPARC_PHYS_BANKS+1];
  */
 typedef struct { unsigned long pte; } pte_t;
 typedef struct { unsigned long iopte; } iopte_t;
-typedef struct { unsigned long pmdv[16]; } pmd_t;
+typedef struct { unsigned long pmd; } pmd_t;
 typedef struct { unsigned long pgd; } pgd_t;
 typedef struct { unsigned long ctxd; } ctxd_t;
 typedef struct { unsigned long pgprot; } pgprot_t;
@@ -62,7 +62,7 @@ typedef struct { unsigned long iopgprot; } iopgprot_t;
 
 #define pte_val(x)	((x).pte)
 #define iopte_val(x)	((x).iopte)
-#define pmd_val(x)      ((x).pmdv[0])
+#define pmd_val(x)      ((x).pmd)
 #define pgd_val(x)	((x).pgd)
 #define ctxd_val(x)	((x).ctxd)
 #define pgprot_val(x)	((x).pgprot)
@@ -82,7 +82,7 @@ typedef struct { unsigned long iopgprot; } iopgprot_t;
  */
 typedef unsigned long pte_t;
 typedef unsigned long iopte_t;
-typedef struct { unsigned long pmdv[16]; } pmd_t;
+typedef unsigned long pmd_t;
 typedef unsigned long pgd_t;
 typedef unsigned long ctxd_t;
 typedef unsigned long pgprot_t;
@@ -90,14 +90,14 @@ typedef unsigned long iopgprot_t;
 
 #define pte_val(x)	(x)
 #define iopte_val(x)	(x)
-#define pmd_val(x)      ((x).pmdv[0])
+#define pmd_val(x)      (x)
 #define pgd_val(x)	(x)
 #define ctxd_val(x)	(x)
 #define pgprot_val(x)	(x)
 #define iopgprot_val(x)	(x)
 
 #define __pte(x)	(x)
-#define __pmd(x)	((pmd_t) { { (x) }, })
+#define __pmd(x)	(x)
 #define __iopte(x)	(x)
 #define __pgd(x)	(x)
 #define __ctxd(x)	(x)
diff --git a/arch/sparc/include/asm/pgalloc_32.h b/arch/sparc/include/asm/pgalloc_32.h
index eae0c92..99c0324 100644
--- a/arch/sparc/include/asm/pgalloc_32.h
+++ b/arch/sparc/include/asm/pgalloc_32.h
@@ -60,13 +60,14 @@ pgtable_t pte_alloc_one(struct mm_struct *mm);
 
 static inline pte_t *pte_alloc_one_kernel(struct mm_struct *mm)
 {
-	return srmmu_get_nocache(PTE_SIZE, PTE_SIZE);
+	return srmmu_get_nocache(SRMMU_PTE_TABLE_SIZE,
+				 SRMMU_PTE_TABLE_SIZE);
 }
 
 
 static inline void free_pte_fast(pte_t *pte)
 {
-	srmmu_free_nocache(pte, PTE_SIZE);
+	srmmu_free_nocache(pte, SRMMU_PTE_TABLE_SIZE);
 }
 
 #define pte_free_kernel(mm, pte)	free_pte_fast(pte)
diff --git a/arch/sparc/include/asm/pgtable_32.h b/arch/sparc/include/asm/pgtable_32.h
index 0de659a..3367e2b 100644
--- a/arch/sparc/include/asm/pgtable_32.h
+++ b/arch/sparc/include/asm/pgtable_32.h
@@ -11,6 +11,16 @@
 
 #include <linux/const.h>
 
+#define PMD_SHIFT		18
+#define PMD_SIZE        	(1UL << PMD_SHIFT)
+#define PMD_MASK        	(~(PMD_SIZE-1))
+#define PMD_ALIGN(__addr) 	(((__addr) + ~PMD_MASK) & PMD_MASK)
+
+#define PGDIR_SHIFT     	24
+#define PGDIR_SIZE      	(1UL << PGDIR_SHIFT)
+#define PGDIR_MASK      	(~(PGDIR_SIZE-1))
+#define PGDIR_ALIGN(__addr) 	(((__addr) + ~PGDIR_MASK) & PGDIR_MASK)
+
 #ifndef __ASSEMBLY__
 #include <asm-generic/pgtable-nopud.h>
 
@@ -34,17 +44,10 @@ unsigned long __init bootmem_init(unsigned long *pages_avail);
 #define pmd_ERROR(e)   __builtin_trap()
 #define pgd_ERROR(e)   __builtin_trap()
 
-#define PMD_SHIFT		22
-#define PMD_SIZE        	(1UL << PMD_SHIFT)
-#define PMD_MASK        	(~(PMD_SIZE-1))
-#define PMD_ALIGN(__addr) 	(((__addr) + ~PMD_MASK) & PMD_MASK)
-#define PGDIR_SHIFT     	SRMMU_PGDIR_SHIFT
-#define PGDIR_SIZE      	SRMMU_PGDIR_SIZE
-#define PGDIR_MASK      	SRMMU_PGDIR_MASK
-#define PTRS_PER_PTE    	1024
-#define PTRS_PER_PMD    	SRMMU_PTRS_PER_PMD
-#define PTRS_PER_PGD    	SRMMU_PTRS_PER_PGD
-#define USER_PTRS_PER_PGD	PAGE_OFFSET / SRMMU_PGDIR_SIZE
+#define PTRS_PER_PTE    	64
+#define PTRS_PER_PMD    	64
+#define PTRS_PER_PGD    	256
+#define USER_PTRS_PER_PGD	PAGE_OFFSET / PGDIR_SIZE
 #define FIRST_USER_ADDRESS	0UL
 #define PTE_SIZE		(PTRS_PER_PTE*4)
 
@@ -179,9 +182,7 @@ static inline int pmd_none(pmd_t pmd)
 
 static inline void pmd_clear(pmd_t *pmdp)
 {
-	int i;
-	for (i = 0; i < PTRS_PER_PTE/SRMMU_REAL_PTRS_PER_PTE; i++)
-		set_pte((pte_t *)&pmdp->pmdv[i], __pte(0));
+	set_pte((pte_t *)&pmd_val(*pmdp), __pte(0));
 }
 
 static inline int pud_none(pud_t pud)
diff --git a/arch/sparc/include/asm/pgtsrmmu.h b/arch/sparc/include/asm/pgtsrmmu.h
index 32a5088..58ea8e8 100644
--- a/arch/sparc/include/asm/pgtsrmmu.h
+++ b/arch/sparc/include/asm/pgtsrmmu.h
@@ -17,39 +17,9 @@
 /* Number of contexts is implementation-dependent; 64k is the most we support */
 #define SRMMU_MAX_CONTEXTS	65536
 
-/* PMD_SHIFT determines the size of the area a second-level page table entry can map */
-#define SRMMU_REAL_PMD_SHIFT		18
-#define SRMMU_REAL_PMD_SIZE		(1UL << SRMMU_REAL_PMD_SHIFT)
-#define SRMMU_REAL_PMD_MASK		(~(SRMMU_REAL_PMD_SIZE-1))
-#define SRMMU_REAL_PMD_ALIGN(__addr)	(((__addr)+SRMMU_REAL_PMD_SIZE-1)&SRMMU_REAL_PMD_MASK)
-
-/* PGDIR_SHIFT determines what a third-level page table entry can map */
-#define SRMMU_PGDIR_SHIFT       24
-#define SRMMU_PGDIR_SIZE        (1UL << SRMMU_PGDIR_SHIFT)
-#define SRMMU_PGDIR_MASK        (~(SRMMU_PGDIR_SIZE-1))
-#define SRMMU_PGDIR_ALIGN(addr) (((addr)+SRMMU_PGDIR_SIZE-1)&SRMMU_PGDIR_MASK)
-
-#define SRMMU_REAL_PTRS_PER_PTE	64
-#define SRMMU_REAL_PTRS_PER_PMD	64
-#define SRMMU_PTRS_PER_PGD	256
-
-#define SRMMU_REAL_PTE_TABLE_SIZE	(SRMMU_REAL_PTRS_PER_PTE*4)
-#define SRMMU_PMD_TABLE_SIZE		(SRMMU_REAL_PTRS_PER_PMD*4)
-#define SRMMU_PGD_TABLE_SIZE		(SRMMU_PTRS_PER_PGD*4)
-
-/*
- * To support pagetables in highmem, Linux introduces APIs which
- * return struct page* and generally manipulate page tables when
- * they are not mapped into kernel space. Our hardware page tables
- * are smaller than pages. We lump hardware tabes into big, page sized
- * software tables.
- *
- * PMD_SHIFT determines the size of the area a second-level page table entry
- * can map, and our pmd_t is 16 times larger than normal.  The values which
- * were once defined here are now generic for 4c and srmmu, so they're
- * found in pgtable.h.
- */
-#define SRMMU_PTRS_PER_PMD	4
+#define SRMMU_PTE_TABLE_SIZE		(PAGE_SIZE)
+#define SRMMU_PMD_TABLE_SIZE		(PAGE_SIZE)
+#define SRMMU_PGD_TABLE_SIZE		(PTRS_PER_PGD*4)
 
 /* Definition of the values in the ET field of PTD's and PTE's */
 #define SRMMU_ET_MASK         0x3
diff --git a/arch/sparc/include/asm/viking.h b/arch/sparc/include/asm/viking.h
index 0bbefd1..08ffc60 100644
--- a/arch/sparc/include/asm/viking.h
+++ b/arch/sparc/include/asm/viking.h
@@ -10,6 +10,7 @@
 
 #include <asm/asi.h>
 #include <asm/mxcc.h>
+#include <asm/pgtable.h>
 #include <asm/pgtsrmmu.h>
 
 /* Bits in the SRMMU control register for GNU/Viking modules.
@@ -227,7 +228,7 @@ static inline unsigned long viking_hwprobe(unsigned long vaddr)
 			     : "=r" (val)
 			     : "r" (vaddr | 0x200), "i" (ASI_M_FLUSH_PROBE));
 	if ((val & SRMMU_ET_MASK) == SRMMU_ET_PTE) {
-		vaddr &= ~SRMMU_PGDIR_MASK;
+		vaddr &= ~PGDIR_MASK;
 		vaddr >>= PAGE_SHIFT;
 		return val | (vaddr << 8);
 	}
@@ -237,7 +238,7 @@ static inline unsigned long viking_hwprobe(unsigned long vaddr)
 			     : "=r" (val)
 			     : "r" (vaddr | 0x100), "i" (ASI_M_FLUSH_PROBE));
 	if ((val & SRMMU_ET_MASK) == SRMMU_ET_PTE) {
-		vaddr &= ~SRMMU_REAL_PMD_MASK;
+		vaddr &= ~PMD_MASK;
 		vaddr >>= PAGE_SHIFT;
 		return val | (vaddr << 8);
 	}
diff --git a/arch/sparc/kernel/head_32.S b/arch/sparc/kernel/head_32.S
index e55f2c0..be30c8d 100644
--- a/arch/sparc/kernel/head_32.S
+++ b/arch/sparc/kernel/head_32.S
@@ -24,7 +24,7 @@
 #include <asm/winmacro.h>
 #include <asm/thread_info.h>	/* TI_UWINMASK */
 #include <asm/errno.h>
-#include <asm/pgtsrmmu.h>	/* SRMMU_PGDIR_SHIFT */
+#include <asm/pgtable.h>	/* PGDIR_SHIFT */
 #include <asm/export.h>
 
 	.data
@@ -273,7 +273,7 @@ not_a_sun4:
 		lda	[%o1] ASI_M_BYPASS, %o2		! This is the 0x0 16MB pgd
 
 		/* Calculate to KERNBASE entry. */
-		add	%o1, KERNBASE >> (SRMMU_PGDIR_SHIFT - 2), %o3
+		add	%o1, KERNBASE >> (PGDIR_SHIFT - 2), %o3
 
 		/* Poke the entry into the calculated address. */
 		sta	%o2, [%o3] ASI_M_BYPASS
@@ -317,7 +317,7 @@ srmmu_not_viking:
 		sll	%g1, 0x8, %g1			! make phys addr for l1 tbl
 
 		lda	[%g1] ASI_M_BYPASS, %g2		! get level1 entry for 0x0
-		add	%g1, KERNBASE >> (SRMMU_PGDIR_SHIFT - 2), %g3
+		add	%g1, KERNBASE >> (PGDIR_SHIFT - 2), %g3
 		sta	%g2, [%g3] ASI_M_BYPASS		! place at KERNBASE entry
 		b	go_to_highmem
 		 nop					! wheee....
@@ -341,7 +341,7 @@ leon_remap:
 		sll	%g1, 0x8, %g1			! make phys addr for l1 tbl
 
 		lda	[%g1] ASI_M_BYPASS, %g2		! get level1 entry for 0x0
-		add	%g1, KERNBASE >> (SRMMU_PGDIR_SHIFT - 2), %g3
+		add	%g1, KERNBASE >> (PGDIR_SHIFT - 2), %g3
 		sta	%g2, [%g3] ASI_M_BYPASS		! place at KERNBASE entry
 		b	go_to_highmem
 		 nop					! wheee....
diff --git a/arch/sparc/mm/hypersparc.S b/arch/sparc/mm/hypersparc.S
index 66885a8..6c2521e 100644
--- a/arch/sparc/mm/hypersparc.S
+++ b/arch/sparc/mm/hypersparc.S
@@ -10,6 +10,7 @@
 #include <asm/asm-offsets.h>
 #include <asm/asi.h>
 #include <asm/page.h>
+#include <asm/pgtable.h>
 #include <asm/pgtsrmmu.h>
 #include <linux/init.h>
 
@@ -293,7 +294,7 @@ hypersparc_flush_tlb_range:
 	cmp	%o3, -1
 	be	hypersparc_flush_tlb_range_out
 #endif
-	 sethi	%hi(~((1 << SRMMU_PGDIR_SHIFT) - 1)), %o4
+	 sethi	%hi(~((1 << PGDIR_SHIFT) - 1)), %o4
 	sta	%o3, [%g1] ASI_M_MMUREGS
 	and	%o1, %o4, %o1
 	add	%o1, 0x200, %o1
diff --git a/arch/sparc/mm/srmmu.c b/arch/sparc/mm/srmmu.c
index cb9ded8..50da4bc 100644
--- a/arch/sparc/mm/srmmu.c
+++ b/arch/sparc/mm/srmmu.c
@@ -136,26 +136,14 @@ static void msi_set_sync(void)
 
 void pmd_set(pmd_t *pmdp, pte_t *ptep)
 {
-	unsigned long ptp;	/* Physical address, shifted right by 4 */
-	int i;
-
-	ptp = __nocache_pa(ptep) >> 4;
-	for (i = 0; i < PTRS_PER_PTE/SRMMU_REAL_PTRS_PER_PTE; i++) {
-		set_pte((pte_t *)&pmdp->pmdv[i], __pte(SRMMU_ET_PTD | ptp));
-		ptp += (SRMMU_REAL_PTRS_PER_PTE * sizeof(pte_t) >> 4);
-	}
+	unsigned long ptp = __nocache_pa(ptep) >> 4;
+	set_pte((pte_t *)&pmd_val(*pmdp), __pte(SRMMU_ET_PTD | ptp));
 }
 
 void pmd_populate(struct mm_struct *mm, pmd_t *pmdp, struct page *ptep)
 {
-	unsigned long ptp;	/* Physical address, shifted right by 4 */
-	int i;
-
-	ptp = page_to_pfn(ptep) << (PAGE_SHIFT-4);	/* watch for overflow */
-	for (i = 0; i < PTRS_PER_PTE/SRMMU_REAL_PTRS_PER_PTE; i++) {
-		set_pte((pte_t *)&pmdp->pmdv[i], __pte(SRMMU_ET_PTD | ptp));
-		ptp += (SRMMU_REAL_PTRS_PER_PTE * sizeof(pte_t) >> 4);
-	}
+	unsigned long ptp = page_to_pfn(ptep) << (PAGE_SHIFT-4); /* watch for overflow */
+	set_pte((pte_t *)&pmd_val(*pmdp), __pte(SRMMU_ET_PTD | ptp));
 }
 
 /* Find an entry in the third-level page table.. */
@@ -163,7 +151,7 @@ pte_t *pte_offset_kernel(pmd_t *dir, unsigned long address)
 {
 	void *pte;
 
-	pte = __nocache_va((dir->pmdv[0] & SRMMU_PTD_PMASK) << 4);
+	pte = __nocache_va((pmd_val(*dir) & SRMMU_PTD_PMASK) << 4);
 	return (pte_t *) pte +
 	    ((address >> PAGE_SHIFT) & (PTRS_PER_PTE - 1));
 }
@@ -400,7 +388,7 @@ void pte_free(struct mm_struct *mm, pgtable_t pte)
 	p = page_to_pfn(pte) << PAGE_SHIFT;	/* Physical address */
 
 	/* free non cached virtual address*/
-	srmmu_free_nocache(__nocache_va(p), PTE_SIZE);
+	srmmu_free_nocache(__nocache_va(p), SRMMU_PTE_TABLE_SIZE);
 }
 
 /* context handling - a dynamically sized pool is used */
@@ -822,13 +810,13 @@ static void __init srmmu_inherit_prom_mappings(unsigned long start,
 		what = 0;
 		addr = start - PAGE_SIZE;
 
-		if (!(start & ~(SRMMU_REAL_PMD_MASK))) {
-			if (srmmu_probe(addr + SRMMU_REAL_PMD_SIZE) == probed)
+		if (!(start & ~(PMD_MASK))) {
+			if (srmmu_probe(addr + PMD_SIZE) == probed)
 				what = 1;
 		}
 
-		if (!(start & ~(SRMMU_PGDIR_MASK))) {
-			if (srmmu_probe(addr + SRMMU_PGDIR_SIZE) == probed)
+		if (!(start & ~(PGDIR_MASK))) {
+			if (srmmu_probe(addr + PGDIR_SIZE) == probed)
 				what = 2;
 		}
 
@@ -837,7 +825,7 @@ static void __init srmmu_inherit_prom_mappings(unsigned long start,
 		pudp = pud_offset(p4dp, start);
 		if (what == 2) {
 			*(pgd_t *)__nocache_fix(pgdp) = __pgd(probed);
-			start += SRMMU_PGDIR_SIZE;
+			start += PGDIR_SIZE;
 			continue;
 		}
 		if (pud_none(*(pud_t *)__nocache_fix(pudp))) {
@@ -849,6 +837,11 @@ static void __init srmmu_inherit_prom_mappings(unsigned long start,
 			pud_set(__nocache_fix(pudp), pmdp);
 		}
 		pmdp = pmd_offset(__nocache_fix(pgdp), start);
+		if (what == 1) {
+			*(pmd_t *)__nocache_fix(pmdp) = __pmd(probed);
+			start += PMD_SIZE;
+			continue;
+		}
 		if (srmmu_pmd_none(*(pmd_t *)__nocache_fix(pmdp))) {
 			ptep = __srmmu_get_nocache(PTE_SIZE, PTE_SIZE);
 			if (ptep == NULL)
@@ -856,19 +849,6 @@ static void __init srmmu_inherit_prom_mappings(unsigned long start,
 			memset(__nocache_fix(ptep), 0, PTE_SIZE);
 			pmd_set(__nocache_fix(pmdp), ptep);
 		}
-		if (what == 1) {
-			/* We bend the rule where all 16 PTPs in a pmd_t point
-			 * inside the same PTE page, and we leak a perfectly
-			 * good hardware PTE piece. Alternatives seem worse.
-			 */
-			unsigned int x;	/* Index of HW PMD in soft cluster */
-			unsigned long *val;
-			x = (start >> PMD_SHIFT) & 15;
-			val = &pmdp->pmdv[x];
-			*(unsigned long *)__nocache_fix(val) = probed;
-			start += SRMMU_REAL_PMD_SIZE;
-			continue;
-		}
 		ptep = pte_offset_kernel(__nocache_fix(pmdp), start);
 		*(pte_t *)__nocache_fix(ptep) = __pte(probed);
 		start += PAGE_SIZE;
@@ -890,9 +870,9 @@ static void __init do_large_mapping(unsigned long vaddr, unsigned long phys_base
 /* Map sp_bank entry SP_ENTRY, starting at virtual address VBASE. */
 static unsigned long __init map_spbank(unsigned long vbase, int sp_entry)
 {
-	unsigned long pstart = (sp_banks[sp_entry].base_addr & SRMMU_PGDIR_MASK);
-	unsigned long vstart = (vbase & SRMMU_PGDIR_MASK);
-	unsigned long vend = SRMMU_PGDIR_ALIGN(vbase + sp_banks[sp_entry].num_bytes);
+	unsigned long pstart = (sp_banks[sp_entry].base_addr & PGDIR_MASK);
+	unsigned long vstart = (vbase & PGDIR_MASK);
+	unsigned long vend = PGDIR_ALIGN(vbase + sp_banks[sp_entry].num_bytes);
 	/* Map "low" memory only */
 	const unsigned long min_vaddr = PAGE_OFFSET;
 	const unsigned long max_vaddr = PAGE_OFFSET + SRMMU_MAXMEM;
@@ -905,7 +885,7 @@ static unsigned long __init map_spbank(unsigned long vbase, int sp_entry)
 
 	while (vstart < vend) {
 		do_large_mapping(vstart, pstart);
-		vstart += SRMMU_PGDIR_SIZE; pstart += SRMMU_PGDIR_SIZE;
+		vstart += PGDIR_SIZE; pstart += PGDIR_SIZE;
 	}
 	return vstart;
 }
diff --git a/arch/sparc/mm/viking.S b/arch/sparc/mm/viking.S
index adaef6e..48f062d 100644
--- a/arch/sparc/mm/viking.S
+++ b/arch/sparc/mm/viking.S
@@ -13,6 +13,7 @@
 #include <asm/asi.h>
 #include <asm/mxcc.h>
 #include <asm/page.h>
+#include <asm/pgtable.h>
 #include <asm/pgtsrmmu.h>
 #include <asm/viking.h>
 
@@ -157,7 +158,7 @@ viking_flush_tlb_range:
 	cmp	%o3, -1
 	be	2f
 #endif
-	sethi	%hi(~((1 << SRMMU_PGDIR_SHIFT) - 1)), %o4
+	sethi	%hi(~((1 << PGDIR_SHIFT) - 1)), %o4
 	sta	%o3, [%g1] ASI_M_MMUREGS
 	and	%o1, %o4, %o1
 	add	%o1, 0x200, %o1
@@ -243,7 +244,7 @@ sun4dsmp_flush_tlb_range:
 	ld	[%o0 + VMA_VM_MM], %o0
 	ld	[%o0 + AOFF_mm_context], %o3
 	lda	[%g1] ASI_M_MMUREGS, %g5
-	sethi	%hi(~((1 << SRMMU_PGDIR_SHIFT) - 1)), %o4
+	sethi	%hi(~((1 << PGDIR_SHIFT) - 1)), %o4
 	sta	%o3, [%g1] ASI_M_MMUREGS
 	and	%o1, %o4, %o1
 	add	%o1, 0x200, %o1
