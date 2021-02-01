Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D14630A69A
	for <lists+linux-tip-commits@lfdr.de>; Mon,  1 Feb 2021 12:33:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229981AbhBALdP (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Mon, 1 Feb 2021 06:33:15 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:56950 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229624AbhBALdK (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Mon, 1 Feb 2021 06:33:10 -0500
Date:   Mon, 01 Feb 2021 11:32:26 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1612179147;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=p6TW9DkgdY/e/rZ8Ekswu9AmMTNICKinyHpOb+dmaYI=;
        b=3JWauimsY7gAwU8d058ks7ahQyWgxeAIHOlyTx03GRgSMgU3Quphx6C0iRWbTxt++k1wgZ
        Oe12oj14rC7+rTi5MTPSjqkc0CWU3SntqJFM+WM+AxKacJLwLmHAmfF+Js+3LfLUSU9X1e
        ZLE9QXKsjcL7HSjWrTnNI1wwLTJ24T2FG7cZPZG4hRU1IUeq61grUqOmD0s4/tJ7f3DwPQ
        YvBfJoZjvo33ZVs8NzRuCrIwZ3c1Dnpvs3LG6nRT/I+PPzdlp5FoR/6M7Kpow22Se+m2Y/
        Mhwc1mjO9DwWLSHpK73ClnBCgvovKZKKw+pAUFfIJapNECJxdVpb8p+x5JTRQw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1612179147;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=p6TW9DkgdY/e/rZ8Ekswu9AmMTNICKinyHpOb+dmaYI=;
        b=oMkWzHQHGUPFl86RtKDw6cNTKk4Cqti279eeiov1C5fIyvNKm6xYiKI5HRaxjQ+6ioe48r
        mgO08zr/k5HOIxCQ==
From:   "tip-bot2 for Will Deacon" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/mm] tlb: mmu_gather: Remove unused start/end arguments
 from tlb_finish_mmu()
Cc:     Will Deacon <will@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Yu Zhao <yuzhao@google.com>,
        Linus Torvalds <torvalds@linux-foundation.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210127235347.1402-3-will@kernel.org>
References: <20210127235347.1402-3-will@kernel.org>
MIME-Version: 1.0
Message-ID: <161217914611.23325.11763031441733134584.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the core/mm branch of tip:

Commit-ID:     ae8eba8b5d723a4ca543024b6e51f4d0f4fb6b6b
Gitweb:        https://git.kernel.org/tip/ae8eba8b5d723a4ca543024b6e51f4d0f4fb6b6b
Author:        Will Deacon <will@kernel.org>
AuthorDate:    Wed, 27 Jan 2021 23:53:43 
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 29 Jan 2021 20:02:28 +01:00

tlb: mmu_gather: Remove unused start/end arguments from tlb_finish_mmu()

Since commit 7a30df49f63a ("mm: mmu_gather: remove __tlb_reset_range()
for force flush"), the 'start' and 'end' arguments to tlb_finish_mmu()
are no longer used, since we flush the whole mm in case of a nested
invalidation.

Remove the unused arguments and update all callers.

Signed-off-by: Will Deacon <will@kernel.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Yu Zhao <yuzhao@google.com>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Linus Torvalds <torvalds@linux-foundation.org>
Link: https://lkml.kernel.org/r/20210127235347.1402-3-will@kernel.org
---
 arch/ia64/include/asm/tlb.h | 2 +-
 arch/x86/kernel/ldt.c       | 2 +-
 fs/exec.c                   | 2 +-
 include/linux/mm_types.h    | 3 +--
 mm/hugetlb.c                | 2 +-
 mm/madvise.c                | 6 +++---
 mm/memory.c                 | 4 ++--
 mm/mmap.c                   | 4 ++--
 mm/mmu_gather.c             | 5 +----
 mm/oom_kill.c               | 4 ++--
 10 files changed, 15 insertions(+), 19 deletions(-)

diff --git a/arch/ia64/include/asm/tlb.h b/arch/ia64/include/asm/tlb.h
index 8d9da6f..7059eb2 100644
--- a/arch/ia64/include/asm/tlb.h
+++ b/arch/ia64/include/asm/tlb.h
@@ -36,7 +36,7 @@
  *	    tlb_end_vma(tlb, vma);
  *	  }
  *	}
- *	tlb_finish_mmu(tlb, start, end);	// finish unmap for address space MM
+ *	tlb_finish_mmu(tlb);				// finish unmap for address space MM
  */
 #include <linux/mm.h>
 #include <linux/pagemap.h>
diff --git a/arch/x86/kernel/ldt.c b/arch/x86/kernel/ldt.c
index b8aee71..0d4e125 100644
--- a/arch/x86/kernel/ldt.c
+++ b/arch/x86/kernel/ldt.c
@@ -400,7 +400,7 @@ static void free_ldt_pgtables(struct mm_struct *mm)
 
 	tlb_gather_mmu(&tlb, mm, start, end);
 	free_pgd_range(&tlb, start, end, start, end);
-	tlb_finish_mmu(&tlb, start, end);
+	tlb_finish_mmu(&tlb);
 #endif
 }
 
diff --git a/fs/exec.c b/fs/exec.c
index 5d4d520..69d89a0 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -725,7 +725,7 @@ static int shift_arg_pages(struct vm_area_struct *vma, unsigned long shift)
 		free_pgd_range(&tlb, old_start, old_end, new_end,
 			vma->vm_next ? vma->vm_next->vm_start : USER_PGTABLES_CEILING);
 	}
-	tlb_finish_mmu(&tlb, old_start, old_end);
+	tlb_finish_mmu(&tlb);
 
 	/*
 	 * Shrink the vma to just the new range.  Always succeeds.
diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index 07d9acb..1fe6a51 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -590,8 +590,7 @@ static inline cpumask_t *mm_cpumask(struct mm_struct *mm)
 struct mmu_gather;
 extern void tlb_gather_mmu(struct mmu_gather *tlb, struct mm_struct *mm,
 				unsigned long start, unsigned long end);
-extern void tlb_finish_mmu(struct mmu_gather *tlb,
-				unsigned long start, unsigned long end);
+extern void tlb_finish_mmu(struct mmu_gather *tlb);
 
 static inline void init_tlb_flush_pending(struct mm_struct *mm)
 {
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 18f6ee3..33db4fa 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -3985,7 +3985,7 @@ void unmap_hugepage_range(struct vm_area_struct *vma, unsigned long start,
 
 	tlb_gather_mmu(&tlb, mm, tlb_start, tlb_end);
 	__unmap_hugepage_range(&tlb, vma, start, end, ref_page);
-	tlb_finish_mmu(&tlb, tlb_start, tlb_end);
+	tlb_finish_mmu(&tlb);
 }
 
 /*
diff --git a/mm/madvise.c b/mm/madvise.c
index 6a66085..1b68520 100644
--- a/mm/madvise.c
+++ b/mm/madvise.c
@@ -508,7 +508,7 @@ static long madvise_cold(struct vm_area_struct *vma,
 	lru_add_drain();
 	tlb_gather_mmu(&tlb, mm, start_addr, end_addr);
 	madvise_cold_page_range(&tlb, vma, start_addr, end_addr);
-	tlb_finish_mmu(&tlb, start_addr, end_addr);
+	tlb_finish_mmu(&tlb);
 
 	return 0;
 }
@@ -560,7 +560,7 @@ static long madvise_pageout(struct vm_area_struct *vma,
 	lru_add_drain();
 	tlb_gather_mmu(&tlb, mm, start_addr, end_addr);
 	madvise_pageout_page_range(&tlb, vma, start_addr, end_addr);
-	tlb_finish_mmu(&tlb, start_addr, end_addr);
+	tlb_finish_mmu(&tlb);
 
 	return 0;
 }
@@ -732,7 +732,7 @@ static int madvise_free_single_vma(struct vm_area_struct *vma,
 			&madvise_free_walk_ops, &tlb);
 	tlb_end_vma(&tlb, vma);
 	mmu_notifier_invalidate_range_end(&range);
-	tlb_finish_mmu(&tlb, range.start, range.end);
+	tlb_finish_mmu(&tlb);
 
 	return 0;
 }
diff --git a/mm/memory.c b/mm/memory.c
index feff48e..7bd3f12 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -1540,7 +1540,7 @@ void zap_page_range(struct vm_area_struct *vma, unsigned long start,
 	for ( ; vma && vma->vm_start < range.end; vma = vma->vm_next)
 		unmap_single_vma(&tlb, vma, start, range.end, NULL);
 	mmu_notifier_invalidate_range_end(&range);
-	tlb_finish_mmu(&tlb, start, range.end);
+	tlb_finish_mmu(&tlb);
 }
 
 /**
@@ -1566,7 +1566,7 @@ static void zap_page_range_single(struct vm_area_struct *vma, unsigned long addr
 	mmu_notifier_invalidate_range_start(&range);
 	unmap_single_vma(&tlb, vma, address, range.end, details);
 	mmu_notifier_invalidate_range_end(&range);
-	tlb_finish_mmu(&tlb, address, range.end);
+	tlb_finish_mmu(&tlb);
 }
 
 /**
diff --git a/mm/mmap.c b/mm/mmap.c
index dc72060..7a9f493 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -2676,7 +2676,7 @@ static void unmap_region(struct mm_struct *mm,
 	unmap_vmas(&tlb, vma, start, end);
 	free_pgtables(&tlb, vma, prev ? prev->vm_end : FIRST_USER_ADDRESS,
 				 next ? next->vm_start : USER_PGTABLES_CEILING);
-	tlb_finish_mmu(&tlb, start, end);
+	tlb_finish_mmu(&tlb);
 }
 
 /*
@@ -3219,7 +3219,7 @@ void exit_mmap(struct mm_struct *mm)
 	/* Use -1 here to ensure all VMAs in the mm are unmapped */
 	unmap_vmas(&tlb, vma, 0, -1);
 	free_pgtables(&tlb, vma, FIRST_USER_ADDRESS, USER_PGTABLES_CEILING);
-	tlb_finish_mmu(&tlb, 0, -1);
+	tlb_finish_mmu(&tlb);
 
 	/*
 	 * Walk the list again, actually closing and freeing it,
diff --git a/mm/mmu_gather.c b/mm/mmu_gather.c
index 03c33c9..b0be5a7 100644
--- a/mm/mmu_gather.c
+++ b/mm/mmu_gather.c
@@ -290,14 +290,11 @@ void tlb_gather_mmu(struct mmu_gather *tlb, struct mm_struct *mm,
 /**
  * tlb_finish_mmu - finish an mmu_gather structure
  * @tlb: the mmu_gather structure to finish
- * @start: start of the region that will be removed from the page-table
- * @end: end of the region that will be removed from the page-table
  *
  * Called at the end of the shootdown operation to free up any resources that
  * were required.
  */
-void tlb_finish_mmu(struct mmu_gather *tlb,
-		unsigned long start, unsigned long end)
+void tlb_finish_mmu(struct mmu_gather *tlb)
 {
 	/*
 	 * If there are parallel threads are doing PTE changes on same range
diff --git a/mm/oom_kill.c b/mm/oom_kill.c
index 04b19b7..757e557 100644
--- a/mm/oom_kill.c
+++ b/mm/oom_kill.c
@@ -548,13 +548,13 @@ bool __oom_reap_task_mm(struct mm_struct *mm)
 						vma->vm_end);
 			tlb_gather_mmu(&tlb, mm, range.start, range.end);
 			if (mmu_notifier_invalidate_range_start_nonblock(&range)) {
-				tlb_finish_mmu(&tlb, range.start, range.end);
+				tlb_finish_mmu(&tlb);
 				ret = false;
 				continue;
 			}
 			unmap_page_range(&tlb, vma, range.start, range.end, NULL);
 			mmu_notifier_invalidate_range_end(&range);
-			tlb_finish_mmu(&tlb, range.start, range.end);
+			tlb_finish_mmu(&tlb);
 		}
 	}
 
