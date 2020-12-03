Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E65812CD281
	for <lists+linux-tip-commits@lfdr.de>; Thu,  3 Dec 2020 10:27:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388547AbgLCJZ3 (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Thu, 3 Dec 2020 04:25:29 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:39618 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729896AbgLCJZP (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Thu, 3 Dec 2020 04:25:15 -0500
Date:   Thu, 03 Dec 2020 09:24:32 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1606987473;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BunbLC1Liqo6sRJISr5gqlNiGqFxOhmHh5P0DgkIvt0=;
        b=rjZkeMl3sFBdA+rUnyZWQcJc2Ke9npBxjUTAg4ZrWN5NssLcCm+jfY0mxG2inQQzzKey/h
        akbLZFFRJ0jvATWd4QR0Rnf5Cphhc95oUFunXUWBm5JGN7RVjQBJHU4fLkKzeS14cbKSz8
        6caJVBg0zq0xFGkXneJlHQJIw60zOSScSzWE70ovPg5VM9T/5wFfPwGNUco1IZ2PQRJMuB
        CRAT70pjPbMss8Xa1ztxVXCEHjViiSRKEwjT+cIt7tlfdNmqv07YQu6WbBcT7TBcfJ6HmZ
        fXxXv3rirXu1OWo6fwZiLEVavy271DpiCBCUZQTV3PUntvywBEJtrkCfbwcqAg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1606987473;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BunbLC1Liqo6sRJISr5gqlNiGqFxOhmHh5P0DgkIvt0=;
        b=va3P7QFGJtZiM1eXPnIeF/VHScI8BWCzoGZ+ILA5V22X1nx8BeDqBGaj+5lrEATO7m1pql
        w9brkVMwpS3QlvCQ==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf/core: Fix arch_perf_get_page_size()
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Kan Liang <kan.liang@linux.intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20201126124207.GM3040@hirez.programming.kicks-ass.net>
References: <20201126124207.GM3040@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Message-ID: <160698747281.3364.15359072552006612329.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     8af26be062721e52eba1550caf50b712f774c5fd
Gitweb:        https://git.kernel.org/tip/8af26be062721e52eba1550caf50b712f774c5fd
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Wed, 11 Nov 2020 13:43:57 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Thu, 03 Dec 2020 10:14:51 +01:00

perf/core: Fix arch_perf_get_page_size()

The (new) page-table walker in arch_perf_get_page_size() is broken in
various ways. Specifically while it is used in a lockless manner, it
doesn't depend on CONFIG_HAVE_FAST_GUP nor uses the proper _lockless
offset methods, nor is careful to only read each entry only once.

Also the hugetlb support is broken due to calling pte_page() without
first checking pte_special().

Rewrite the whole thing to be a proper lockless page-table walker and
employ the new pXX_leaf_size() pgtable functions to determine the
pagetable size without looking at the page-frames.

Fixes: 51b646b2d9f8 ("perf,mm: Handle non-page-table-aligned hugetlbfs")
Fixes: 8d97e71811aa ("perf/core: Add PERF_SAMPLE_DATA_PAGE_SIZE")
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Tested-by: Kan Liang <kan.liang@linux.intel.com>
Link: https://lkml.kernel.org/r/20201126124207.GM3040@hirez.programming.kicks-ass.net
---
 kernel/events/core.c | 103 +++++++++++++++---------------------------
 1 file changed, 38 insertions(+), 65 deletions(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index d2f3ca7..a21b0be 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -52,6 +52,7 @@
 #include <linux/mount.h>
 #include <linux/min_heap.h>
 #include <linux/highmem.h>
+#include <linux/pgtable.h>
 
 #include "internal.h"
 
@@ -7001,90 +7002,62 @@ static u64 perf_virt_to_phys(u64 virt)
 	return phys_addr;
 }
 
-#ifdef CONFIG_MMU
-
 /*
- * Return the MMU page size of a given virtual address.
- *
- * This generic implementation handles page-table aligned huge pages, as well
- * as non-page-table aligned hugetlbfs compound pages.
- *
- * If an architecture supports and uses non-page-table aligned pages in their
- * kernel mapping it will need to provide it's own implementation of this
- * function.
+ * Return the pagetable size of a given virtual address.
  */
-__weak u64 arch_perf_get_page_size(struct mm_struct *mm, unsigned long addr)
+static u64 perf_get_pgtable_size(struct mm_struct *mm, unsigned long addr)
 {
-	struct page *page;
-	pgd_t *pgd;
-	p4d_t *p4d;
-	pud_t *pud;
-	pmd_t *pmd;
-	pte_t *pte;
+	u64 size = 0;
 
-	pgd = pgd_offset(mm, addr);
-	if (pgd_none(*pgd))
-		return 0;
+#ifdef CONFIG_HAVE_FAST_GUP
+	pgd_t *pgdp, pgd;
+	p4d_t *p4dp, p4d;
+	pud_t *pudp, pud;
+	pmd_t *pmdp, pmd;
+	pte_t *ptep, pte;
 
-	p4d = p4d_offset(pgd, addr);
-	if (!p4d_present(*p4d))
+	pgdp = pgd_offset(mm, addr);
+	pgd = READ_ONCE(*pgdp);
+	if (pgd_none(pgd))
 		return 0;
 
-	if (p4d_leaf(*p4d))
-		return 1ULL << P4D_SHIFT;
+	if (pgd_leaf(pgd))
+		return pgd_leaf_size(pgd);
 
-	pud = pud_offset(p4d, addr);
-	if (!pud_present(*pud))
+	p4dp = p4d_offset_lockless(pgdp, pgd, addr);
+	p4d = READ_ONCE(*p4dp);
+	if (!p4d_present(p4d))
 		return 0;
 
-	if (pud_leaf(*pud)) {
-#ifdef pud_page
-		page = pud_page(*pud);
-		if (PageHuge(page))
-			return page_size(compound_head(page));
-#endif
-		return 1ULL << PUD_SHIFT;
-	}
+	if (p4d_leaf(p4d))
+		return p4d_leaf_size(p4d);
 
-	pmd = pmd_offset(pud, addr);
-	if (!pmd_present(*pmd))
+	pudp = pud_offset_lockless(p4dp, p4d, addr);
+	pud = READ_ONCE(*pudp);
+	if (!pud_present(pud))
 		return 0;
 
-	if (pmd_leaf(*pmd)) {
-#ifdef pmd_page
-		page = pmd_page(*pmd);
-		if (PageHuge(page))
-			return page_size(compound_head(page));
-#endif
-		return 1ULL << PMD_SHIFT;
-	}
+	if (pud_leaf(pud))
+		return pud_leaf_size(pud);
 
-	pte = pte_offset_map(pmd, addr);
-	if (!pte_present(*pte)) {
-		pte_unmap(pte);
+	pmdp = pmd_offset_lockless(pudp, pud, addr);
+	pmd = READ_ONCE(*pmdp);
+	if (!pmd_present(pmd))
 		return 0;
-	}
 
-	page = pte_page(*pte);
-	if (PageHuge(page)) {
-		u64 size = page_size(compound_head(page));
-		pte_unmap(pte);
-		return size;
-	}
+	if (pmd_leaf(pmd))
+		return pmd_leaf_size(pmd);
 
-	pte_unmap(pte);
-	return PAGE_SIZE;
-}
+	ptep = pte_offset_map(&pmd, addr);
+	pte = ptep_get_lockless(ptep);
+	if (pte_present(pte))
+		size = pte_leaf_size(pte);
+	pte_unmap(ptep);
+#endif /* CONFIG_HAVE_FAST_GUP */
 
-#else
-
-static u64 arch_perf_get_page_size(struct mm_struct *mm, unsigned long addr)
-{
-	return 0;
+	return size;
 }
 
-#endif
-
 static u64 perf_get_page_size(unsigned long addr)
 {
 	struct mm_struct *mm;
@@ -7109,7 +7082,7 @@ static u64 perf_get_page_size(unsigned long addr)
 		mm = &init_mm;
 	}
 
-	size = arch_perf_get_page_size(mm, addr);
+	size = perf_get_pgtable_size(mm, addr);
 
 	local_irq_restore(flags);
 
