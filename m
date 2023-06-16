Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E51373399F
	for <lists+linux-tip-commits@lfdr.de>; Fri, 16 Jun 2023 21:19:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346155AbjFPTTD (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 16 Jun 2023 15:19:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346050AbjFPTRV (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 16 Jun 2023 15:17:21 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F21343C17;
        Fri, 16 Jun 2023 12:17:08 -0700 (PDT)
Date:   Fri, 16 Jun 2023 19:17:06 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1686943027;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=SdR4H/gh2Z8YGdMdJUpDZWJqKocZweul9AiASdgwo4o=;
        b=BxvswxBNc9iUq/7neP+mCWZqivTqeJlqj5OmkczlRIerVW427kpachXD3WmFGR6oPt4geQ
        zXtXULyKNFxbhc1PCd8HtzM2XVARLnWGFvji9Z1vrwtiT2u6R8e/RvWHitlg5e9TE7Mg8C
        tszuO3b9k+EsaFu8fROqe47I4I1hUvgmzZqEsUZ46mmIc3nyArlP+OOiNhge9/QFn6DlR9
        4zMvrh2vY+LJ9+VhSZ0aILpZUsMEXRWESYbRrj5RRFeZmFrvw6jgX+5RyeiqH/yzcaySZX
        ltmgTNLZiPj1sYKEHnbG0X53PeGQKuLbzPzLwBVyxOjHDbth6V2KPd7aPLysFw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1686943027;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=SdR4H/gh2Z8YGdMdJUpDZWJqKocZweul9AiASdgwo4o=;
        b=259iZAkf437TvlEpZoIbVebrpG8fhAwoY/7CNirF3HhlVhdWPPbt5bBtDN+Moa9+Iepliw
        f7P92NlZxO7ZjtDQ==
From:   "tip-bot2 for Rick Edgecombe" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/shstk] mm: Make pte_mkwrite() take a VMA
Cc:     David Hildenbrand <david@redhat.com>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "Mike Rapoport (IBM)" <rppt@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <168694302667.404.10503811297837635007.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/shstk branch of tip:

Commit-ID:     23a219c1860bc961491ad11e52dada82b021275b
Gitweb:        https://git.kernel.org/tip/23a219c1860bc961491ad11e52dada82b021275b
Author:        Rick Edgecombe <rick.p.edgecombe@intel.com>
AuthorDate:    Mon, 12 Jun 2023 17:10:29 -07:00
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Thu, 15 Jun 2023 16:30:56 -07:00

mm: Make pte_mkwrite() take a VMA

The x86 Shadow stack feature includes a new type of memory called shadow
stack. This shadow stack memory has some unusual properties, which requires
some core mm changes to function properly.

One of these unusual properties is that shadow stack memory is writable,
but only in limited ways. These limits are applied via a specific PTE
bit combination. Nevertheless, the memory is writable, and core mm code
will need to apply the writable permissions in the typical paths that
call pte_mkwrite(). Future patches will make pte_mkwrite() take a VMA, so
that the x86 implementation of it can know whether to create regular
writable or shadow stack mappings.

But there are a couple of challenges to this. Modifying the signatures of
each arch pte_mkwrite() implementation would be error prone because some
are generated with macros and would need to be re-implemented. Also, some
pte_mkwrite() callers operate on kernel memory without a VMA.

So this can be done in a three step process. First pte_mkwrite() can be
renamed to pte_mkwrite_novma() in each arch, with a generic pte_mkwrite()
added that just calls pte_mkwrite_novma(). Next callers without a VMA can
be moved to pte_mkwrite_novma(). And lastly, pte_mkwrite() and all callers
can be changed to take/pass a VMA.

Previous work pte_mkwrite() renamed pte_mkwrite_novma() and converted
callers that don't have a VMA were to use pte_mkwrite_novma(). So now
change pte_mkwrite() to take a VMA and change the remaining callers to
pass a VMA. Apply the same changes for pmd_mkwrite().

No functional change.

Suggested-by: David Hildenbrand <david@redhat.com>
Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Reviewed-by: Mike Rapoport (IBM) <rppt@kernel.org>
Acked-by: David Hildenbrand <david@redhat.com>
Link: https://lore.kernel.org/all/20230613001108.3040476-4-rick.p.edgecombe%40intel.com
---
 Documentation/mm/arch_pgtable_helpers.rst |  6 ++++--
 include/linux/mm.h                        |  2 +-
 include/linux/pgtable.h                   |  4 ++--
 mm/debug_vm_pgtable.c                     | 12 ++++++------
 mm/huge_memory.c                          | 10 +++++-----
 mm/memory.c                               |  4 ++--
 mm/migrate.c                              |  2 +-
 mm/migrate_device.c                       |  2 +-
 mm/mprotect.c                             |  2 +-
 mm/userfaultfd.c                          |  2 +-
 10 files changed, 24 insertions(+), 22 deletions(-)

diff --git a/Documentation/mm/arch_pgtable_helpers.rst b/Documentation/mm/arch_pgtable_helpers.rst
index 69ce1f2..c82e3ee 100644
--- a/Documentation/mm/arch_pgtable_helpers.rst
+++ b/Documentation/mm/arch_pgtable_helpers.rst
@@ -46,7 +46,8 @@ PTE Page Table Helpers
 +---------------------------+--------------------------------------------------+
 | pte_mkclean               | Creates a clean PTE                              |
 +---------------------------+--------------------------------------------------+
-| pte_mkwrite               | Creates a writable PTE                           |
+| pte_mkwrite               | Creates a writable PTE of the type specified by  |
+|                           | the VMA.                                         |
 +---------------------------+--------------------------------------------------+
 | pte_mkwrite_novma         | Creates a writable PTE, of the conventional type |
 |                           | of writable.                                     |
@@ -121,7 +122,8 @@ PMD Page Table Helpers
 +---------------------------+--------------------------------------------------+
 | pmd_mkclean               | Creates a clean PMD                              |
 +---------------------------+--------------------------------------------------+
-| pmd_mkwrite               | Creates a writable PMD                           |
+| pmd_mkwrite               | Creates a writable PMD of the type specified by  |
+|                           | the VMA.                                         |
 +---------------------------+--------------------------------------------------+
 | pmd_mkwrite_novma         | Creates a writable PMD, of the conventional type |
 |                           | of writable.                                     |
diff --git a/include/linux/mm.h b/include/linux/mm.h
index 27ce770..43701bf 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -1284,7 +1284,7 @@ void free_compound_page(struct page *page);
 static inline pte_t maybe_mkwrite(pte_t pte, struct vm_area_struct *vma)
 {
 	if (likely(vma->vm_flags & VM_WRITE))
-		pte = pte_mkwrite(pte);
+		pte = pte_mkwrite(pte, vma);
 	return pte;
 }
 
diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
index 15f0329..f5077a0 100644
--- a/include/linux/pgtable.h
+++ b/include/linux/pgtable.h
@@ -508,14 +508,14 @@ extern pud_t pudp_huge_clear_flush(struct vm_area_struct *vma,
 #endif
 
 #ifndef pte_mkwrite
-static inline pte_t pte_mkwrite(pte_t pte)
+static inline pte_t pte_mkwrite(pte_t pte, struct vm_area_struct *vma)
 {
 	return pte_mkwrite_novma(pte);
 }
 #endif
 
 #if defined(CONFIG_ARCH_WANT_PMD_MKWRITE) && !defined(pmd_mkwrite)
-static inline pmd_t pmd_mkwrite(pmd_t pmd)
+static inline pmd_t pmd_mkwrite(pmd_t pmd, struct vm_area_struct *vma)
 {
 	return pmd_mkwrite_novma(pmd);
 }
diff --git a/mm/debug_vm_pgtable.c b/mm/debug_vm_pgtable.c
index c54177a..107e293 100644
--- a/mm/debug_vm_pgtable.c
+++ b/mm/debug_vm_pgtable.c
@@ -109,10 +109,10 @@ static void __init pte_basic_tests(struct pgtable_debug_args *args, int idx)
 	WARN_ON(!pte_same(pte, pte));
 	WARN_ON(!pte_young(pte_mkyoung(pte_mkold(pte))));
 	WARN_ON(!pte_dirty(pte_mkdirty(pte_mkclean(pte))));
-	WARN_ON(!pte_write(pte_mkwrite(pte_wrprotect(pte))));
+	WARN_ON(!pte_write(pte_mkwrite(pte_wrprotect(pte), args->vma)));
 	WARN_ON(pte_young(pte_mkold(pte_mkyoung(pte))));
 	WARN_ON(pte_dirty(pte_mkclean(pte_mkdirty(pte))));
-	WARN_ON(pte_write(pte_wrprotect(pte_mkwrite(pte))));
+	WARN_ON(pte_write(pte_wrprotect(pte_mkwrite(pte, args->vma))));
 	WARN_ON(pte_dirty(pte_wrprotect(pte_mkclean(pte))));
 	WARN_ON(!pte_dirty(pte_wrprotect(pte_mkdirty(pte))));
 }
@@ -153,7 +153,7 @@ static void __init pte_advanced_tests(struct pgtable_debug_args *args)
 	pte = pte_mkclean(pte);
 	set_pte_at(args->mm, args->vaddr, args->ptep, pte);
 	flush_dcache_page(page);
-	pte = pte_mkwrite(pte);
+	pte = pte_mkwrite(pte, args->vma);
 	pte = pte_mkdirty(pte);
 	ptep_set_access_flags(args->vma, args->vaddr, args->ptep, pte, 1);
 	pte = ptep_get(args->ptep);
@@ -199,10 +199,10 @@ static void __init pmd_basic_tests(struct pgtable_debug_args *args, int idx)
 	WARN_ON(!pmd_same(pmd, pmd));
 	WARN_ON(!pmd_young(pmd_mkyoung(pmd_mkold(pmd))));
 	WARN_ON(!pmd_dirty(pmd_mkdirty(pmd_mkclean(pmd))));
-	WARN_ON(!pmd_write(pmd_mkwrite(pmd_wrprotect(pmd))));
+	WARN_ON(!pmd_write(pmd_mkwrite(pmd_wrprotect(pmd), args->vma)));
 	WARN_ON(pmd_young(pmd_mkold(pmd_mkyoung(pmd))));
 	WARN_ON(pmd_dirty(pmd_mkclean(pmd_mkdirty(pmd))));
-	WARN_ON(pmd_write(pmd_wrprotect(pmd_mkwrite(pmd))));
+	WARN_ON(pmd_write(pmd_wrprotect(pmd_mkwrite(pmd, args->vma))));
 	WARN_ON(pmd_dirty(pmd_wrprotect(pmd_mkclean(pmd))));
 	WARN_ON(!pmd_dirty(pmd_wrprotect(pmd_mkdirty(pmd))));
 	/*
@@ -253,7 +253,7 @@ static void __init pmd_advanced_tests(struct pgtable_debug_args *args)
 	pmd = pmd_mkclean(pmd);
 	set_pmd_at(args->mm, vaddr, args->pmdp, pmd);
 	flush_dcache_page(page);
-	pmd = pmd_mkwrite(pmd);
+	pmd = pmd_mkwrite(pmd, args->vma);
 	pmd = pmd_mkdirty(pmd);
 	pmdp_set_access_flags(args->vma, vaddr, args->pmdp, pmd, 1);
 	pmd = READ_ONCE(*args->pmdp);
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 624671a..37dd56b 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -551,7 +551,7 @@ __setup("transparent_hugepage=", setup_transparent_hugepage);
 pmd_t maybe_pmd_mkwrite(pmd_t pmd, struct vm_area_struct *vma)
 {
 	if (likely(vma->vm_flags & VM_WRITE))
-		pmd = pmd_mkwrite(pmd);
+		pmd = pmd_mkwrite(pmd, vma);
 	return pmd;
 }
 
@@ -1572,7 +1572,7 @@ out_map:
 	pmd = pmd_modify(oldpmd, vma->vm_page_prot);
 	pmd = pmd_mkyoung(pmd);
 	if (writable)
-		pmd = pmd_mkwrite(pmd);
+		pmd = pmd_mkwrite(pmd, vma);
 	set_pmd_at(vma->vm_mm, haddr, vmf->pmd, pmd);
 	update_mmu_cache_pmd(vma, vmf->address, vmf->pmd);
 	spin_unlock(vmf->ptl);
@@ -1924,7 +1924,7 @@ int change_huge_pmd(struct mmu_gather *tlb, struct vm_area_struct *vma,
 	/* See change_pte_range(). */
 	if ((cp_flags & MM_CP_TRY_CHANGE_WRITABLE) && !pmd_write(entry) &&
 	    can_change_pmd_writable(vma, addr, entry))
-		entry = pmd_mkwrite(entry);
+		entry = pmd_mkwrite(entry, vma);
 
 	ret = HPAGE_PMD_NR;
 	set_pmd_at(mm, addr, pmd, entry);
@@ -2234,7 +2234,7 @@ static void __split_huge_pmd_locked(struct vm_area_struct *vma, pmd_t *pmd,
 		} else {
 			entry = mk_pte(page + i, READ_ONCE(vma->vm_page_prot));
 			if (write)
-				entry = pte_mkwrite(entry);
+				entry = pte_mkwrite(entry, vma);
 			if (anon_exclusive)
 				SetPageAnonExclusive(page + i);
 			if (!young)
@@ -3271,7 +3271,7 @@ void remove_migration_pmd(struct page_vma_mapped_walk *pvmw, struct page *new)
 	if (pmd_swp_soft_dirty(*pvmw->pmd))
 		pmde = pmd_mksoft_dirty(pmde);
 	if (is_writable_migration_entry(entry))
-		pmde = pmd_mkwrite(pmde);
+		pmde = pmd_mkwrite(pmde, vma);
 	if (pmd_swp_uffd_wp(*pvmw->pmd))
 		pmde = pmd_mkuffd_wp(pmde);
 	if (!is_migration_entry_young(entry))
diff --git a/mm/memory.c b/mm/memory.c
index f69fbc2..c1b6fe9 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -4100,7 +4100,7 @@ static vm_fault_t do_anonymous_page(struct vm_fault *vmf)
 	entry = mk_pte(&folio->page, vma->vm_page_prot);
 	entry = pte_sw_mkyoung(entry);
 	if (vma->vm_flags & VM_WRITE)
-		entry = pte_mkwrite(pte_mkdirty(entry));
+		entry = pte_mkwrite(pte_mkdirty(entry), vma);
 
 	vmf->pte = pte_offset_map_lock(vma->vm_mm, vmf->pmd, vmf->address,
 			&vmf->ptl);
@@ -4796,7 +4796,7 @@ out_map:
 	pte = pte_modify(old_pte, vma->vm_page_prot);
 	pte = pte_mkyoung(pte);
 	if (writable)
-		pte = pte_mkwrite(pte);
+		pte = pte_mkwrite(pte, vma);
 	ptep_modify_prot_commit(vma, vmf->address, vmf->pte, old_pte, pte);
 	update_mmu_cache(vma, vmf->address, vmf->pte);
 	pte_unmap_unlock(vmf->pte, vmf->ptl);
diff --git a/mm/migrate.c b/mm/migrate.c
index 01cac26..8b46b72 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -219,7 +219,7 @@ static bool remove_migration_pte(struct folio *folio,
 		if (folio_test_dirty(folio) && is_migration_entry_dirty(entry))
 			pte = pte_mkdirty(pte);
 		if (is_writable_migration_entry(entry))
-			pte = pte_mkwrite(pte);
+			pte = pte_mkwrite(pte, vma);
 		else if (pte_swp_uffd_wp(*pvmw.pte))
 			pte = pte_mkuffd_wp(pte);
 
diff --git a/mm/migrate_device.c b/mm/migrate_device.c
index d30c9de..df3f5e9 100644
--- a/mm/migrate_device.c
+++ b/mm/migrate_device.c
@@ -646,7 +646,7 @@ static void migrate_vma_insert_page(struct migrate_vma *migrate,
 		}
 		entry = mk_pte(page, vma->vm_page_prot);
 		if (vma->vm_flags & VM_WRITE)
-			entry = pte_mkwrite(pte_mkdirty(entry));
+			entry = pte_mkwrite(pte_mkdirty(entry), vma);
 	}
 
 	ptep = pte_offset_map_lock(mm, pmdp, addr, &ptl);
diff --git a/mm/mprotect.c b/mm/mprotect.c
index 92d3d3c..afdb672 100644
--- a/mm/mprotect.c
+++ b/mm/mprotect.c
@@ -198,7 +198,7 @@ static long change_pte_range(struct mmu_gather *tlb,
 			if ((cp_flags & MM_CP_TRY_CHANGE_WRITABLE) &&
 			    !pte_write(ptent) &&
 			    can_change_pte_writable(vma, addr, ptent))
-				ptent = pte_mkwrite(ptent);
+				ptent = pte_mkwrite(ptent, vma);
 
 			ptep_modify_prot_commit(vma, addr, pte, oldpte, ptent);
 			if (pte_needs_flush(oldpte, ptent))
diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
index e97a0b4..6dea7f5 100644
--- a/mm/userfaultfd.c
+++ b/mm/userfaultfd.c
@@ -72,7 +72,7 @@ int mfill_atomic_install_pte(pmd_t *dst_pmd,
 	if (page_in_cache && !vm_shared)
 		writable = false;
 	if (writable)
-		_dst_pte = pte_mkwrite(_dst_pte);
+		_dst_pte = pte_mkwrite(_dst_pte, dst_vma);
 	if (flags & MFILL_ATOMIC_WP)
 		_dst_pte = pte_mkuffd_wp(_dst_pte);
 
