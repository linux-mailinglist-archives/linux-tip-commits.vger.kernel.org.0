Return-Path: <linux-tip-commits+bounces-3324-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 548FDA25A28
	for <lists+linux-tip-commits@lfdr.de>; Mon,  3 Feb 2025 13:56:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E11063A37A4
	for <lists+linux-tip-commits@lfdr.de>; Mon,  3 Feb 2025 12:54:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDDDB209F4C;
	Mon,  3 Feb 2025 12:50:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="rLYPiuZJ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="bAuVjcQY"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1787C205ADF;
	Mon,  3 Feb 2025 12:50:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738587010; cv=none; b=aYQcOpWfK42qoUu8K49WMhJHW7jbfhC/Li86T71F38ndq03zpbMyNbuEjrwK5Cb0A3OjHhUXaPLbxdtVzze4w6GOqiYhYw46x1331ChoHnqkDdiW6tIXmBuC2n9Uaq/qCFw3XSpO9CS5FlMUfzss6+pQU5gFEBfURfSNwp+NK7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738587010; c=relaxed/simple;
	bh=0wlWSGXp3EsXQt6DvjOX2nlhXfymZczwTMdNzEC8O3c=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=kHgABfn1ztU1jpreB46z4aatTWuL7aUJbx9TfdRjenfmtlDTOwqjY5FEBMZAfS434kCg9RJbwKLDjb1JicmofNZpqdwi/zViaP3sqn8XacZvj3kz6J1KT9frmIgEZOXXhUvcJeqv5zWXOGv2uxpxZ7hxTJCvqmUdtdr/jGRmxAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=rLYPiuZJ; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=bAuVjcQY; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 03 Feb 2025 12:50:05 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1738587006;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1YfvnWynVny2zGPimDcPbM38Pl0TbmR6MGazWvZ+Q7k=;
	b=rLYPiuZJ3zldvNEu9PsgvMG/Izptm4hEpWP+OpMYryhqk+ny+PF9ZHV3yf9vajv9kCL5nL
	/hndYh2VbwdAMrT7eraPfjsXuVDKtQGCJeovIP0jeX9tQZDEuK2/lMt53lnh14Vz1FUeoW
	5G71OeT/e98qYo275qiDDgtT6ll9jcmUO4FEnjvLCIDeJzPmv1keCHajXPykKLyHzIoMpv
	35jw/Id5lu4hcFDRQ/33CPIg6i7nu5dAjwHYgYaBjKlaZeVU/vMvgyI/84zPjGbp9xyEo3
	lfH+t4etz+lfu1dntsK1nQ5ixpFtb5RE9ZIxflCAGdxOgF3onmui3+OC+hVKlQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1738587006;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1YfvnWynVny2zGPimDcPbM38Pl0TbmR6MGazWvZ+Q7k=;
	b=bAuVjcQYWImw6UM2XgIL6zHVOnFFTElnzE+nkgy40GXFNywB6MUhZ5Y5MVAVuQvUWTmhkM
	zxdkc8p1PQULQ6Dw==
From: "tip-bot2 for Kirill A. Shutemov" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/mm] x86/mm/pat: restore large ROX pages after fragmentation
Cc: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
 "Mike Rapoport (Microsoft)" <rppt@kernel.org>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250126074733.1384926-4-rppt@kernel.org>
References: <20250126074733.1384926-4-rppt@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173858700582.10177.6102486074190652268.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/mm branch of tip:

Commit-ID:     41d88484c71cd4f659348da41b7b5b3dbd3be1f6
Gitweb:        https://git.kernel.org/tip/41d88484c71cd4f659348da41b7b5b3dbd3be1f6
Author:        Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
AuthorDate:    Sun, 26 Jan 2025 09:47:27 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 03 Feb 2025 11:46:01 +01:00

x86/mm/pat: restore large ROX pages after fragmentation

Change of attributes of the pages may lead to fragmentation of direct
mapping over time and performance degradation when these pages contain
executable code.

With current code it's one way road: kernel tries to avoid splitting
large pages, but it doesn't restore them back even if page attributes
got compatible again.

Any change to the mapping may potentially allow to restore large page.

Add a hook to cpa_flush() path that will check if the pages in the range
that were just touched can be mapped at PMD level. If the collapse at the
PMD level succeeded, also attempt to collapse PUD level.

The collapse logic runs only when a set_memory_ method explicitly sets
CPA_COLLAPSE flag, for now this is only enabled in set_memory_rox().

CPUs don't like[1] to have to have TLB entries of different size for the
same memory, but looks like it's okay as long as these entries have
matching attributes[2]. Therefore it's critical to flush TLB before any
following changes to the mapping.

Note that we already allow for multiple TLB entries of different sizes
for the same memory now in split_large_page() path. It's not a new
situation.

set_memory_4k() provides a way to use 4k pages on purpose. Kernel must
not remap such pages as large. Re-use one of software PTE bits to
indicate such pages.

[1] See Erratum 383 of AMD Family 10h Processors
[2] https://lore.kernel.org/linux-mm/1da1b025-cabc-6f04-bde5-e50830d1ecf0@amd.com/

[rppt@kernel.org:
 * s/restore/collapse/
 * update formatting per peterz
 * use 'struct ptdesc' instead of 'struct page' for list of page tables to
   be freed
 * try to collapse PMD first and if it succeeds move on to PUD as peterz
   suggested
 * flush TLB twice: for changes done in the original CPA call and after
   collapsing of large pages
 * update commit message
]

Signed-off-by: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Co-developed-by: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
Signed-off-by: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/r/20250126074733.1384926-4-rppt@kernel.org
---
 arch/x86/include/asm/pgtable_types.h |   2 +-
 arch/x86/mm/pat/set_memory.c         | 217 +++++++++++++++++++++++++-
 include/linux/vm_event_item.h        |   2 +-
 mm/vmstat.c                          |   2 +-
 4 files changed, 219 insertions(+), 4 deletions(-)

diff --git a/arch/x86/include/asm/pgtable_types.h b/arch/x86/include/asm/pgtable_types.h
index 4b80453..c90e9c5 100644
--- a/arch/x86/include/asm/pgtable_types.h
+++ b/arch/x86/include/asm/pgtable_types.h
@@ -33,6 +33,7 @@
 #define _PAGE_BIT_CPA_TEST	_PAGE_BIT_SOFTW1
 #define _PAGE_BIT_UFFD_WP	_PAGE_BIT_SOFTW2 /* userfaultfd wrprotected */
 #define _PAGE_BIT_SOFT_DIRTY	_PAGE_BIT_SOFTW3 /* software dirty tracking */
+#define _PAGE_BIT_KERNEL_4K	_PAGE_BIT_SOFTW3 /* page must not be converted to large */
 #define _PAGE_BIT_DEVMAP	_PAGE_BIT_SOFTW4
 
 #ifdef CONFIG_X86_64
@@ -64,6 +65,7 @@
 #define _PAGE_PAT_LARGE (_AT(pteval_t, 1) << _PAGE_BIT_PAT_LARGE)
 #define _PAGE_SPECIAL	(_AT(pteval_t, 1) << _PAGE_BIT_SPECIAL)
 #define _PAGE_CPA_TEST	(_AT(pteval_t, 1) << _PAGE_BIT_CPA_TEST)
+#define _PAGE_KERNEL_4K	(_AT(pteval_t, 1) << _PAGE_BIT_KERNEL_4K)
 #ifdef CONFIG_X86_INTEL_MEMORY_PROTECTION_KEYS
 #define _PAGE_PKEY_BIT0	(_AT(pteval_t, 1) << _PAGE_BIT_PKEY_BIT0)
 #define _PAGE_PKEY_BIT1	(_AT(pteval_t, 1) << _PAGE_BIT_PKEY_BIT1)
diff --git a/arch/x86/mm/pat/set_memory.c b/arch/x86/mm/pat/set_memory.c
index 1f7698c..7bd0f62 100644
--- a/arch/x86/mm/pat/set_memory.c
+++ b/arch/x86/mm/pat/set_memory.c
@@ -73,6 +73,7 @@ static DEFINE_SPINLOCK(cpa_lock);
 #define CPA_ARRAY 2
 #define CPA_PAGES_ARRAY 4
 #define CPA_NO_CHECK_ALIAS 8 /* Do not search for aliases */
+#define CPA_COLLAPSE 16 /* try to collapse large pages */
 
 static inline pgprot_t cachemode2pgprot(enum page_cache_mode pcm)
 {
@@ -105,6 +106,18 @@ static void split_page_count(int level)
 	direct_pages_count[level - 1] += PTRS_PER_PTE;
 }
 
+static void collapse_page_count(int level)
+{
+	direct_pages_count[level]++;
+	if (system_state == SYSTEM_RUNNING) {
+		if (level == PG_LEVEL_2M)
+			count_vm_event(DIRECT_MAP_LEVEL2_COLLAPSE);
+		else if (level == PG_LEVEL_1G)
+			count_vm_event(DIRECT_MAP_LEVEL3_COLLAPSE);
+	}
+	direct_pages_count[level - 1] -= PTRS_PER_PTE;
+}
+
 void arch_report_meminfo(struct seq_file *m)
 {
 	seq_printf(m, "DirectMap4k:    %8lu kB\n",
@@ -122,6 +135,7 @@ void arch_report_meminfo(struct seq_file *m)
 }
 #else
 static inline void split_page_count(int level) { }
+static inline void collapse_page_count(int level) { }
 #endif
 
 #ifdef CONFIG_X86_CPA_STATISTICS
@@ -394,6 +408,40 @@ static void __cpa_flush_tlb(void *data)
 		flush_tlb_one_kernel(fix_addr(__cpa_addr(cpa, i)));
 }
 
+static int collapse_large_pages(unsigned long addr, struct list_head *pgtables);
+
+static void cpa_collapse_large_pages(struct cpa_data *cpa)
+{
+	unsigned long start, addr, end;
+	struct ptdesc *ptdesc, *tmp;
+	LIST_HEAD(pgtables);
+	int collapsed = 0;
+	int i;
+
+	if (cpa->flags & (CPA_PAGES_ARRAY | CPA_ARRAY)) {
+		for (i = 0; i < cpa->numpages; i++)
+			collapsed += collapse_large_pages(__cpa_addr(cpa, i),
+							  &pgtables);
+	} else {
+		addr = __cpa_addr(cpa, 0);
+		start = addr & PMD_MASK;
+		end = addr + PAGE_SIZE * cpa->numpages;
+
+		for (addr = start; within(addr, start, end); addr += PMD_SIZE)
+			collapsed += collapse_large_pages(addr, &pgtables);
+	}
+
+	if (!collapsed)
+		return;
+
+	flush_tlb_all();
+
+	list_for_each_entry_safe(ptdesc, tmp, &pgtables, pt_list) {
+		list_del(&ptdesc->pt_list);
+		__free_page(ptdesc_page(ptdesc));
+	}
+}
+
 static void cpa_flush(struct cpa_data *cpa, int cache)
 {
 	unsigned int i;
@@ -402,7 +450,7 @@ static void cpa_flush(struct cpa_data *cpa, int cache)
 
 	if (cache && !static_cpu_has(X86_FEATURE_CLFLUSH)) {
 		cpa_flush_all(cache);
-		return;
+		goto collapse_large_pages;
 	}
 
 	if (cpa->force_flush_all || cpa->numpages > tlb_single_page_flush_ceiling)
@@ -411,7 +459,7 @@ static void cpa_flush(struct cpa_data *cpa, int cache)
 		on_each_cpu(__cpa_flush_tlb, cpa, 1);
 
 	if (!cache)
-		return;
+		goto collapse_large_pages;
 
 	mb();
 	for (i = 0; i < cpa->numpages; i++) {
@@ -427,6 +475,10 @@ static void cpa_flush(struct cpa_data *cpa, int cache)
 			clflush_cache_range_opt((void *)fix_addr(addr), PAGE_SIZE);
 	}
 	mb();
+
+collapse_large_pages:
+	if (cpa->flags & CPA_COLLAPSE)
+		cpa_collapse_large_pages(cpa);
 }
 
 static bool overlaps(unsigned long r1_start, unsigned long r1_end,
@@ -1196,6 +1248,161 @@ static int split_large_page(struct cpa_data *cpa, pte_t *kpte,
 	return 0;
 }
 
+static int collapse_pmd_page(pmd_t *pmd, unsigned long addr,
+			     struct list_head *pgtables)
+{
+	pmd_t _pmd, old_pmd;
+	pte_t *pte, first;
+	unsigned long pfn;
+	pgprot_t pgprot;
+	int i = 0;
+
+	addr &= PMD_MASK;
+	pte = pte_offset_kernel(pmd, addr);
+	first = *pte;
+	pfn = pte_pfn(first);
+
+	/* Make sure alignment is suitable */
+	if (PFN_PHYS(pfn) & ~PMD_MASK)
+		return 0;
+
+	/* The page is 4k intentionally */
+	if (pte_flags(first) & _PAGE_KERNEL_4K)
+		return 0;
+
+	/* Check that the rest of PTEs are compatible with the first one */
+	for (i = 1, pte++; i < PTRS_PER_PTE; i++, pte++) {
+		pte_t entry = *pte;
+
+		if (!pte_present(entry))
+			return 0;
+		if (pte_flags(entry) != pte_flags(first))
+			return 0;
+		if (pte_pfn(entry) != pte_pfn(first) + i)
+			return 0;
+	}
+
+	old_pmd = *pmd;
+
+	/* Success: set up a large page */
+	pgprot = pgprot_4k_2_large(pte_pgprot(first));
+	pgprot_val(pgprot) |= _PAGE_PSE;
+	_pmd = pfn_pmd(pfn, pgprot);
+	set_pmd(pmd, _pmd);
+
+	/* Queue the page table to be freed after TLB flush */
+	list_add(&page_ptdesc(pmd_page(old_pmd))->pt_list, pgtables);
+
+	if (IS_ENABLED(CONFIG_X86_32) && !SHARED_KERNEL_PMD) {
+		struct page *page;
+
+		/* Update all PGD tables to use the same large page */
+		list_for_each_entry(page, &pgd_list, lru) {
+			pgd_t *pgd = (pgd_t *)page_address(page) + pgd_index(addr);
+			p4d_t *p4d = p4d_offset(pgd, addr);
+			pud_t *pud = pud_offset(p4d, addr);
+			pmd_t *pmd = pmd_offset(pud, addr);
+			/* Something is wrong if entries doesn't match */
+			if (WARN_ON(pmd_val(old_pmd) != pmd_val(*pmd)))
+				continue;
+			set_pmd(pmd, _pmd);
+		}
+	}
+
+	if (virt_addr_valid(addr) && pfn_range_is_mapped(pfn, pfn + 1))
+		collapse_page_count(PG_LEVEL_2M);
+
+	return 1;
+}
+
+static int collapse_pud_page(pud_t *pud, unsigned long addr,
+			     struct list_head *pgtables)
+{
+	unsigned long pfn;
+	pmd_t *pmd, first;
+	int i;
+
+	if (!direct_gbpages)
+		return 0;
+
+	addr &= PUD_MASK;
+	pmd = pmd_offset(pud, addr);
+	first = *pmd;
+
+	/*
+	 * To restore PUD page all PMD entries must be large and
+	 * have suitable alignment
+	 */
+	pfn = pmd_pfn(first);
+	if (!pmd_leaf(first) || (PFN_PHYS(pfn) & ~PUD_MASK))
+		return 0;
+
+	/*
+	 * To restore PUD page, all following PMDs must be compatible with the
+	 * first one.
+	 */
+	for (i = 1, pmd++; i < PTRS_PER_PMD; i++, pmd++) {
+		pmd_t entry = *pmd;
+
+		if (!pmd_present(entry) || !pmd_leaf(entry))
+			return 0;
+		if (pmd_flags(entry) != pmd_flags(first))
+			return 0;
+		if (pmd_pfn(entry) != pmd_pfn(first) + i * PTRS_PER_PTE)
+			return 0;
+	}
+
+	/* Restore PUD page and queue page table to be freed after TLB flush */
+	list_add(&page_ptdesc(pud_page(*pud))->pt_list, pgtables);
+	set_pud(pud, pfn_pud(pfn, pmd_pgprot(first)));
+
+	if (virt_addr_valid(addr) && pfn_range_is_mapped(pfn, pfn + 1))
+		collapse_page_count(PG_LEVEL_1G);
+
+	return 1;
+}
+
+/*
+ * Collapse PMD and PUD pages in the kernel mapping around the address where
+ * possible.
+ *
+ * Caller must flush TLB and free page tables queued on the list before
+ * touching the new entries. CPU must not see TLB entries of different size
+ * with different attributes.
+ */
+static int collapse_large_pages(unsigned long addr, struct list_head *pgtables)
+{
+	int collapsed = 0;
+	pgd_t *pgd;
+	p4d_t *p4d;
+	pud_t *pud;
+	pmd_t *pmd;
+
+	addr &= PMD_MASK;
+
+	spin_lock(&pgd_lock);
+	pgd = pgd_offset_k(addr);
+	if (pgd_none(*pgd))
+		goto out;
+	p4d = p4d_offset(pgd, addr);
+	if (p4d_none(*p4d))
+		goto out;
+	pud = pud_offset(p4d, addr);
+	if (!pud_present(*pud) || pud_leaf(*pud))
+		goto out;
+	pmd = pmd_offset(pud, addr);
+	if (!pmd_present(*pmd) || pmd_leaf(*pmd))
+		goto out;
+
+	collapsed = collapse_pmd_page(pmd, addr, pgtables);
+	if (collapsed)
+		collapsed += collapse_pud_page(pud, addr, pgtables);
+
+out:
+	spin_unlock(&pgd_lock);
+	return collapsed;
+}
+
 static bool try_to_free_pte_page(pte_t *pte)
 {
 	int i;
@@ -2119,7 +2326,8 @@ int set_memory_rox(unsigned long addr, int numpages)
 	if (__supported_pte_mask & _PAGE_NX)
 		clr.pgprot |= _PAGE_NX;
 
-	return change_page_attr_clear(&addr, numpages, clr, 0);
+	return change_page_attr_set_clr(&addr, numpages, __pgprot(0), clr, 0,
+					CPA_COLLAPSE, NULL);
 }
 
 int set_memory_rw(unsigned long addr, int numpages)
@@ -2146,7 +2354,8 @@ int set_memory_p(unsigned long addr, int numpages)
 
 int set_memory_4k(unsigned long addr, int numpages)
 {
-	return change_page_attr_set_clr(&addr, numpages, __pgprot(0),
+	return change_page_attr_set_clr(&addr, numpages,
+					__pgprot(_PAGE_KERNEL_4K),
 					__pgprot(0), 1, 0, NULL);
 }
 
diff --git a/include/linux/vm_event_item.h b/include/linux/vm_event_item.h
index f70d095..5a37cb2 100644
--- a/include/linux/vm_event_item.h
+++ b/include/linux/vm_event_item.h
@@ -151,6 +151,8 @@ enum vm_event_item { PGPGIN, PGPGOUT, PSWPIN, PSWPOUT,
 #ifdef CONFIG_X86
 		DIRECT_MAP_LEVEL2_SPLIT,
 		DIRECT_MAP_LEVEL3_SPLIT,
+		DIRECT_MAP_LEVEL2_COLLAPSE,
+		DIRECT_MAP_LEVEL3_COLLAPSE,
 #endif
 #ifdef CONFIG_PER_VMA_LOCK_STATS
 		VMA_LOCK_SUCCESS,
diff --git a/mm/vmstat.c b/mm/vmstat.c
index 16bfe1c..8899872 100644
--- a/mm/vmstat.c
+++ b/mm/vmstat.c
@@ -1435,6 +1435,8 @@ const char * const vmstat_text[] = {
 #ifdef CONFIG_X86
 	"direct_map_level2_splits",
 	"direct_map_level3_splits",
+	"direct_map_level2_collapses",
+	"direct_map_level3_collapses",
 #endif
 #ifdef CONFIG_PER_VMA_LOCK_STATS
 	"vma_lock_success",

