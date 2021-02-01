Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C90930A696
	for <lists+linux-tip-commits@lfdr.de>; Mon,  1 Feb 2021 12:33:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230009AbhBALdP (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Mon, 1 Feb 2021 06:33:15 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:56926 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229570AbhBALdK (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Mon, 1 Feb 2021 06:33:10 -0500
Date:   Mon, 01 Feb 2021 11:32:25 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1612179147;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LDQ/TXY7ggLB/kky2ERZC0LtBrm8BfvVqJaqiSLmzgg=;
        b=CL4GnYgfD0hpnnsC6QJqHoJvGjM0g1C7S3mNBPBkFH915E9qdZxqIZ+bbCmTZg4+dFQx7J
        nM7dLNBK1r1GSIRrOP2o+bz5hgWG91T0smiMSr5wX1dfcyGUjUh4KKdVA793y6N3eY76qC
        oIOJSuEW4XvBma1bhbEA8K1fyzX0PuefN1dPku3WM5xTWkIc2JUZ98TFcxS7WzqBoMmieL
        hmqGi9hp3dgczFoB6Lca9ulELgD6Y01NzCyItD/LO2rINLvtGsjvsBdgKAAKzdjgnPseIj
        V9WzFKBwIARe6taexBQfC/9cL4qW6LBiUxef0lGbGJzRFcd8R5BB1EAWGzJyTw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1612179147;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LDQ/TXY7ggLB/kky2ERZC0LtBrm8BfvVqJaqiSLmzgg=;
        b=LOfMt1v2GqZihanM65+LS4vMZsIChe2xPZxoeoSgkCUWx6XEnzgLTMFISHXxjcyBCjUMSe
        J59AT8n1cggkJ9Bw==
From:   "tip-bot2 for Will Deacon" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/mm] tlb: mmu_gather: Remove start/end arguments from
 tlb_gather_mmu()
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Will Deacon <will@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Yu Zhao <yuzhao@google.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <CAHk-=wjQWa14_4UpfDf=fiineNP+RH74kZeDMo_f1D35xNzq9w@mail.gmail.com>
References: <CAHk-=wjQWa14_4UpfDf=fiineNP+RH74kZeDMo_f1D35xNzq9w@mail.gmail.com>
MIME-Version: 1.0
Message-ID: <161217914566.23325.13021666121882104598.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the core/mm branch of tip:

Commit-ID:     a72afd873089c697053e9daa85ff343b3140d2e7
Gitweb:        https://git.kernel.org/tip/a72afd873089c697053e9daa85ff343b3140d2e7
Author:        Will Deacon <will@kernel.org>
AuthorDate:    Wed, 27 Jan 2021 23:53:45 
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 29 Jan 2021 20:02:29 +01:00

tlb: mmu_gather: Remove start/end arguments from tlb_gather_mmu()

The 'start' and 'end' arguments to tlb_gather_mmu() are no longer
needed now that there is a separate function for 'fullmm' flushing.

Remove the unused arguments and update all callers.

Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Will Deacon <will@kernel.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Yu Zhao <yuzhao@google.com>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Linus Torvalds <torvalds@linux-foundation.org>
Link: https://lore.kernel.org/r/CAHk-=wjQWa14_4UpfDf=fiineNP+RH74kZeDMo_f1D35xNzq9w@mail.gmail.com
---
 arch/ia64/include/asm/tlb.h |  2 +-
 arch/x86/kernel/ldt.c       |  2 +-
 fs/exec.c                   |  2 +-
 include/linux/mm_types.h    |  3 +--
 mm/hugetlb.c                | 16 +---------------
 mm/madvise.c                |  6 +++---
 mm/memory.c                 |  4 ++--
 mm/mmap.c                   |  2 +-
 mm/mmu_gather.c             | 22 ++++++++--------------
 mm/oom_kill.c               |  2 +-
 10 files changed, 20 insertions(+), 41 deletions(-)

diff --git a/arch/ia64/include/asm/tlb.h b/arch/ia64/include/asm/tlb.h
index 7059eb2..a15fe08 100644
--- a/arch/ia64/include/asm/tlb.h
+++ b/arch/ia64/include/asm/tlb.h
@@ -23,7 +23,7 @@
  * unmapping a portion of the virtual address space, these hooks are called according to
  * the following template:
  *
- *	tlb <- tlb_gather_mmu(mm, start, end);		// start unmap for address space MM
+ *	tlb <- tlb_gather_mmu(mm);			// start unmap for address space MM
  *	{
  *	  for each vma that needs a shootdown do {
  *	    tlb_start_vma(tlb, vma);
diff --git a/arch/x86/kernel/ldt.c b/arch/x86/kernel/ldt.c
index 0d4e125..7ad9834 100644
--- a/arch/x86/kernel/ldt.c
+++ b/arch/x86/kernel/ldt.c
@@ -398,7 +398,7 @@ static void free_ldt_pgtables(struct mm_struct *mm)
 	if (!boot_cpu_has(X86_FEATURE_PTI))
 		return;
 
-	tlb_gather_mmu(&tlb, mm, start, end);
+	tlb_gather_mmu(&tlb, mm);
 	free_pgd_range(&tlb, start, end, start, end);
 	tlb_finish_mmu(&tlb);
 #endif
diff --git a/fs/exec.c b/fs/exec.c
index 69d89a0..5a853f0 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -708,7 +708,7 @@ static int shift_arg_pages(struct vm_area_struct *vma, unsigned long shift)
 		return -ENOMEM;
 
 	lru_add_drain();
-	tlb_gather_mmu(&tlb, mm, old_start, old_end);
+	tlb_gather_mmu(&tlb, mm);
 	if (new_end > old_start) {
 		/*
 		 * when the old and new regions overlap clear from new_end.
diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index e49868b..0974ad5 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -588,8 +588,7 @@ static inline cpumask_t *mm_cpumask(struct mm_struct *mm)
 }
 
 struct mmu_gather;
-extern void tlb_gather_mmu(struct mmu_gather *tlb, struct mm_struct *mm,
-				unsigned long start, unsigned long end);
+extern void tlb_gather_mmu(struct mmu_gather *tlb, struct mm_struct *mm);
 extern void tlb_gather_mmu_fullmm(struct mmu_gather *tlb, struct mm_struct *mm);
 extern void tlb_finish_mmu(struct mmu_gather *tlb);
 
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 33db4fa..89635f4 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -3967,23 +3967,9 @@ void __unmap_hugepage_range_final(struct mmu_gather *tlb,
 void unmap_hugepage_range(struct vm_area_struct *vma, unsigned long start,
 			  unsigned long end, struct page *ref_page)
 {
-	struct mm_struct *mm;
 	struct mmu_gather tlb;
-	unsigned long tlb_start = start;
-	unsigned long tlb_end = end;
 
-	/*
-	 * If shared PMDs were possibly used within this vma range, adjust
-	 * start/end for worst case tlb flushing.
-	 * Note that we can not be sure if PMDs are shared until we try to
-	 * unmap pages.  However, we want to make sure TLB flushing covers
-	 * the largest possible range.
-	 */
-	adjust_range_if_pmd_sharing_possible(vma, &tlb_start, &tlb_end);
-
-	mm = vma->vm_mm;
-
-	tlb_gather_mmu(&tlb, mm, tlb_start, tlb_end);
+	tlb_gather_mmu(&tlb, vma->vm_mm);
 	__unmap_hugepage_range(&tlb, vma, start, end, ref_page);
 	tlb_finish_mmu(&tlb);
 }
diff --git a/mm/madvise.c b/mm/madvise.c
index 1b68520..0938fd3 100644
--- a/mm/madvise.c
+++ b/mm/madvise.c
@@ -506,7 +506,7 @@ static long madvise_cold(struct vm_area_struct *vma,
 		return -EINVAL;
 
 	lru_add_drain();
-	tlb_gather_mmu(&tlb, mm, start_addr, end_addr);
+	tlb_gather_mmu(&tlb, mm);
 	madvise_cold_page_range(&tlb, vma, start_addr, end_addr);
 	tlb_finish_mmu(&tlb);
 
@@ -558,7 +558,7 @@ static long madvise_pageout(struct vm_area_struct *vma,
 		return 0;
 
 	lru_add_drain();
-	tlb_gather_mmu(&tlb, mm, start_addr, end_addr);
+	tlb_gather_mmu(&tlb, mm);
 	madvise_pageout_page_range(&tlb, vma, start_addr, end_addr);
 	tlb_finish_mmu(&tlb);
 
@@ -723,7 +723,7 @@ static int madvise_free_single_vma(struct vm_area_struct *vma,
 				range.start, range.end);
 
 	lru_add_drain();
-	tlb_gather_mmu(&tlb, mm, range.start, range.end);
+	tlb_gather_mmu(&tlb, mm);
 	update_hiwater_rss(mm);
 
 	mmu_notifier_invalidate_range_start(&range);
diff --git a/mm/memory.c b/mm/memory.c
index 7bd3f12..9e8576a 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -1534,7 +1534,7 @@ void zap_page_range(struct vm_area_struct *vma, unsigned long start,
 	lru_add_drain();
 	mmu_notifier_range_init(&range, MMU_NOTIFY_CLEAR, 0, vma, vma->vm_mm,
 				start, start + size);
-	tlb_gather_mmu(&tlb, vma->vm_mm, start, range.end);
+	tlb_gather_mmu(&tlb, vma->vm_mm);
 	update_hiwater_rss(vma->vm_mm);
 	mmu_notifier_invalidate_range_start(&range);
 	for ( ; vma && vma->vm_start < range.end; vma = vma->vm_next)
@@ -1561,7 +1561,7 @@ static void zap_page_range_single(struct vm_area_struct *vma, unsigned long addr
 	lru_add_drain();
 	mmu_notifier_range_init(&range, MMU_NOTIFY_CLEAR, 0, vma, vma->vm_mm,
 				address, address + size);
-	tlb_gather_mmu(&tlb, vma->vm_mm, address, range.end);
+	tlb_gather_mmu(&tlb, vma->vm_mm);
 	update_hiwater_rss(vma->vm_mm);
 	mmu_notifier_invalidate_range_start(&range);
 	unmap_single_vma(&tlb, vma, address, range.end, details);
diff --git a/mm/mmap.c b/mm/mmap.c
index 4eac7c6..90673fe 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -2671,7 +2671,7 @@ static void unmap_region(struct mm_struct *mm,
 	struct mmu_gather tlb;
 
 	lru_add_drain();
-	tlb_gather_mmu(&tlb, mm, start, end);
+	tlb_gather_mmu(&tlb, mm);
 	update_hiwater_rss(mm);
 	unmap_vmas(&tlb, vma, start, end);
 	free_pgtables(&tlb, vma, prev ? prev->vm_end : FIRST_USER_ADDRESS,
diff --git a/mm/mmu_gather.c b/mm/mmu_gather.c
index 5f5e45d..0dc7149 100644
--- a/mm/mmu_gather.c
+++ b/mm/mmu_gather.c
@@ -253,21 +253,17 @@ void tlb_flush_mmu(struct mmu_gather *tlb)
  * tlb_gather_mmu - initialize an mmu_gather structure for page-table tear-down
  * @tlb: the mmu_gather structure to initialize
  * @mm: the mm_struct of the target address space
- * @start: start of the region that will be removed from the page-table
- * @end: end of the region that will be removed from the page-table
+ * @fullmm: @mm is without users and we're going to destroy the full address
+ *	    space (exit/execve)
  *
  * Called to initialize an (on-stack) mmu_gather structure for page-table
- * tear-down from @mm. The @start and @end are set to 0 and -1
- * respectively when @mm is without users and we're going to destroy
- * the full address space (exit/execve).
+ * tear-down from @mm.
  */
 static void __tlb_gather_mmu(struct mmu_gather *tlb, struct mm_struct *mm,
-			     unsigned long start, unsigned long end)
+			     bool fullmm)
 {
 	tlb->mm = mm;
-
-	/* Is it from 0 to ~0? */
-	tlb->fullmm     = !(start | (end+1));
+	tlb->fullmm = fullmm;
 
 #ifndef CONFIG_MMU_GATHER_NO_GATHER
 	tlb->need_flush_all = 0;
@@ -287,16 +283,14 @@ static void __tlb_gather_mmu(struct mmu_gather *tlb, struct mm_struct *mm,
 	inc_tlb_flush_pending(tlb->mm);
 }
 
-void tlb_gather_mmu(struct mmu_gather *tlb, struct mm_struct *mm,
-		    unsigned long start, unsigned long end)
+void tlb_gather_mmu(struct mmu_gather *tlb, struct mm_struct *mm)
 {
-	WARN_ON(!(start | (end + 1))); /* Use _fullmm() instead */
-	__tlb_gather_mmu(tlb, mm, start, end);
+	__tlb_gather_mmu(tlb, mm, false);
 }
 
 void tlb_gather_mmu_fullmm(struct mmu_gather *tlb, struct mm_struct *mm)
 {
-	__tlb_gather_mmu(tlb, mm, 0, -1);
+	__tlb_gather_mmu(tlb, mm, true);
 }
 
 /**
diff --git a/mm/oom_kill.c b/mm/oom_kill.c
index 757e557..c9a33ff 100644
--- a/mm/oom_kill.c
+++ b/mm/oom_kill.c
@@ -546,7 +546,7 @@ bool __oom_reap_task_mm(struct mm_struct *mm)
 			mmu_notifier_range_init(&range, MMU_NOTIFY_UNMAP, 0,
 						vma, mm, vma->vm_start,
 						vma->vm_end);
-			tlb_gather_mmu(&tlb, mm, range.start, range.end);
+			tlb_gather_mmu(&tlb, mm);
 			if (mmu_notifier_invalidate_range_start_nonblock(&range)) {
 				tlb_finish_mmu(&tlb);
 				ret = false;
