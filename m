Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 932F82CD27E
	for <lists+linux-tip-commits@lfdr.de>; Thu,  3 Dec 2020 10:26:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388514AbgLCJZY (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Thu, 3 Dec 2020 04:25:24 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:39622 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728664AbgLCJZQ (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Thu, 3 Dec 2020 04:25:16 -0500
Date:   Thu, 03 Dec 2020 09:24:33 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1606987473;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ANAiS3fo5jRwE3AvMDaoQ7GuKHyVvs6l1W/mEyjYtSI=;
        b=AWVJD5NowqfcNHT5GPqmxU3GW5/39IvGx7Gz/x6wpqgDfi9vFqd7gCvmSt31XmvM0wjVpN
        57AJcIRpMHUhP2ZbtQsUQQl5+FUr1xPCaS7061V+MUjxOh84wMY3drv78Raa6/m/ZrPrf+
        MDggFmlBFk8Dg/P8HIRRqnnwuoPWHd/wEMeBroElihOXpxcKB6lSGG4UVUpJQHAn153hDi
        HRJWVYGAcLGN71ee9q9E/mNv2B6/pIG8FKnOQ2UF9X2zoWc+rOCInL80VVMIcuLaAgP+Me
        PDtywoYZiRfIqOYrVQ/8hR7cqDlCUcX3ImvP2htn5NsvHFBRy7JKKnZfE41CBQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1606987473;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ANAiS3fo5jRwE3AvMDaoQ7GuKHyVvs6l1W/mEyjYtSI=;
        b=ekx8HvUQczpQ6H3NQevWRbslLF4vFIfXKRStYpxXAGNSbDAUn5JtIEfDG2UcYVtAop5VgJ
        E5LsnNCrjvNowOAg==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] mm/gup: Provide gup_get_pte() more generic
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20201126121121.036370527@infradead.org>
References: <20201126121121.036370527@infradead.org>
MIME-Version: 1.0
Message-ID: <160698747311.3364.2439398871681898668.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     2a4a06da8a4b93dd189171eed7a99fffd38f42f3
Gitweb:        https://git.kernel.org/tip/2a4a06da8a4b93dd189171eed7a99fffd38f42f3
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Fri, 13 Nov 2020 11:41:40 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Thu, 03 Dec 2020 10:14:50 +01:00

mm/gup: Provide gup_get_pte() more generic

In order to write another lockless page-table walker, we need
gup_get_pte() exposed. While doing that, rename it to
ptep_get_lockless() to match the existing ptep_get() naming.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20201126121121.036370527@infradead.org
---
 include/linux/pgtable.h | 55 ++++++++++++++++++++++++++++++++++++++-
 mm/gup.c                | 58 +----------------------------------------
 2 files changed, 56 insertions(+), 57 deletions(-)

diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
index 71125a4..ed9266c 100644
--- a/include/linux/pgtable.h
+++ b/include/linux/pgtable.h
@@ -258,6 +258,61 @@ static inline pte_t ptep_get(pte_t *ptep)
 }
 #endif
 
+#ifdef CONFIG_GUP_GET_PTE_LOW_HIGH
+/*
+ * WARNING: only to be used in the get_user_pages_fast() implementation.
+ *
+ * With get_user_pages_fast(), we walk down the pagetables without taking any
+ * locks.  For this we would like to load the pointers atomically, but sometimes
+ * that is not possible (e.g. without expensive cmpxchg8b on x86_32 PAE).  What
+ * we do have is the guarantee that a PTE will only either go from not present
+ * to present, or present to not present or both -- it will not switch to a
+ * completely different present page without a TLB flush in between; something
+ * that we are blocking by holding interrupts off.
+ *
+ * Setting ptes from not present to present goes:
+ *
+ *   ptep->pte_high = h;
+ *   smp_wmb();
+ *   ptep->pte_low = l;
+ *
+ * And present to not present goes:
+ *
+ *   ptep->pte_low = 0;
+ *   smp_wmb();
+ *   ptep->pte_high = 0;
+ *
+ * We must ensure here that the load of pte_low sees 'l' IFF pte_high sees 'h'.
+ * We load pte_high *after* loading pte_low, which ensures we don't see an older
+ * value of pte_high.  *Then* we recheck pte_low, which ensures that we haven't
+ * picked up a changed pte high. We might have gotten rubbish values from
+ * pte_low and pte_high, but we are guaranteed that pte_low will not have the
+ * present bit set *unless* it is 'l'. Because get_user_pages_fast() only
+ * operates on present ptes we're safe.
+ */
+static inline pte_t ptep_get_lockless(pte_t *ptep)
+{
+	pte_t pte;
+
+	do {
+		pte.pte_low = ptep->pte_low;
+		smp_rmb();
+		pte.pte_high = ptep->pte_high;
+		smp_rmb();
+	} while (unlikely(pte.pte_low != ptep->pte_low));
+
+	return pte;
+}
+#else /* CONFIG_GUP_GET_PTE_LOW_HIGH */
+/*
+ * We require that the PTE can be read atomically.
+ */
+static inline pte_t ptep_get_lockless(pte_t *ptep)
+{
+	return ptep_get(ptep);
+}
+#endif /* CONFIG_GUP_GET_PTE_LOW_HIGH */
+
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
 #ifndef __HAVE_ARCH_PMDP_HUGE_GET_AND_CLEAR
 static inline pmd_t pmdp_huge_get_and_clear(struct mm_struct *mm,
diff --git a/mm/gup.c b/mm/gup.c
index 98eb8e6..44b0c6b 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -2085,62 +2085,6 @@ static void put_compound_head(struct page *page, int refs, unsigned int flags)
 	put_page(page);
 }
 
-#ifdef CONFIG_GUP_GET_PTE_LOW_HIGH
-
-/*
- * WARNING: only to be used in the get_user_pages_fast() implementation.
- *
- * With get_user_pages_fast(), we walk down the pagetables without taking any
- * locks.  For this we would like to load the pointers atomically, but sometimes
- * that is not possible (e.g. without expensive cmpxchg8b on x86_32 PAE).  What
- * we do have is the guarantee that a PTE will only either go from not present
- * to present, or present to not present or both -- it will not switch to a
- * completely different present page without a TLB flush in between; something
- * that we are blocking by holding interrupts off.
- *
- * Setting ptes from not present to present goes:
- *
- *   ptep->pte_high = h;
- *   smp_wmb();
- *   ptep->pte_low = l;
- *
- * And present to not present goes:
- *
- *   ptep->pte_low = 0;
- *   smp_wmb();
- *   ptep->pte_high = 0;
- *
- * We must ensure here that the load of pte_low sees 'l' IFF pte_high sees 'h'.
- * We load pte_high *after* loading pte_low, which ensures we don't see an older
- * value of pte_high.  *Then* we recheck pte_low, which ensures that we haven't
- * picked up a changed pte high. We might have gotten rubbish values from
- * pte_low and pte_high, but we are guaranteed that pte_low will not have the
- * present bit set *unless* it is 'l'. Because get_user_pages_fast() only
- * operates on present ptes we're safe.
- */
-static inline pte_t gup_get_pte(pte_t *ptep)
-{
-	pte_t pte;
-
-	do {
-		pte.pte_low = ptep->pte_low;
-		smp_rmb();
-		pte.pte_high = ptep->pte_high;
-		smp_rmb();
-	} while (unlikely(pte.pte_low != ptep->pte_low));
-
-	return pte;
-}
-#else /* CONFIG_GUP_GET_PTE_LOW_HIGH */
-/*
- * We require that the PTE can be read atomically.
- */
-static inline pte_t gup_get_pte(pte_t *ptep)
-{
-	return ptep_get(ptep);
-}
-#endif /* CONFIG_GUP_GET_PTE_LOW_HIGH */
-
 static void __maybe_unused undo_dev_pagemap(int *nr, int nr_start,
 					    unsigned int flags,
 					    struct page **pages)
@@ -2166,7 +2110,7 @@ static int gup_pte_range(pmd_t pmd, unsigned long addr, unsigned long end,
 
 	ptem = ptep = pte_offset_map(&pmd, addr);
 	do {
-		pte_t pte = gup_get_pte(ptep);
+		pte_t pte = ptep_get_lockless(ptep);
 		struct page *head, *page;
 
 		/*
