Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2DCBF30A697
	for <lists+linux-tip-commits@lfdr.de>; Mon,  1 Feb 2021 12:33:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230035AbhBALdS (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Mon, 1 Feb 2021 06:33:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229959AbhBALdL (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Mon, 1 Feb 2021 06:33:11 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95677C061574;
        Mon,  1 Feb 2021 03:32:30 -0800 (PST)
Date:   Mon, 01 Feb 2021 11:32:25 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1612179147;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uKpkVtmm8lPPbjqZ1SbBRwbcB59/2B7jLgycncob//I=;
        b=ouxM2QlL8oczylNnlTxuzEoGW+4gCokwGm39CO99EtW4TG+Uy2usM2Nxk7TPzMa9Fu4qBV
        fUohTsZjww8PCMco0Gxqfiq1DD5beCx321E+ThjHdnsRzensEgpTnw0k6lHUb5AyNk5GR8
        vv565CqKiIqp8BY8umgpKsQdiq1+XsAJ/iOWyCrwlkBSLcG48eKO4/P/z2EX2h8EkA+vTU
        6jV74FdnbMAQ5nZ9IFSPtGzVAWwYJGrJM9bKHGUz8EPUt6ahTpy0OD4g8cKWEnw4Euqbay
        Q32WGgIu/083KtMtIpc/LUVykwH5Rc30WP0bL3DCMutpGhBwqOvyIE81ZOIRIw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1612179147;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uKpkVtmm8lPPbjqZ1SbBRwbcB59/2B7jLgycncob//I=;
        b=l5/QSNLcAX8SmhFS8YPr6Og2Jj2mefGMyWV6riCJprK9pRd0CEvr1baXlcX4FcCfw6IIWf
        mjrehHhqN4sFa7AA==
From:   "tip-bot2 for Will Deacon" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/mm] tlb: mmu_gather: Introduce tlb_gather_mmu_fullmm()
Cc:     Will Deacon <will@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Yu Zhao <yuzhao@google.com>,
        Linus Torvalds <torvalds@linux-foundation.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210127235347.1402-4-will@kernel.org>
References: <20210127235347.1402-4-will@kernel.org>
MIME-Version: 1.0
Message-ID: <161217914590.23325.16504124484061163825.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the core/mm branch of tip:

Commit-ID:     d8b450530b90f8845ab962af18b8a10ed77fc889
Gitweb:        https://git.kernel.org/tip/d8b450530b90f8845ab962af18b8a10ed77fc889
Author:        Will Deacon <will@kernel.org>
AuthorDate:    Wed, 27 Jan 2021 23:53:44 
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 29 Jan 2021 20:02:29 +01:00

tlb: mmu_gather: Introduce tlb_gather_mmu_fullmm()

Passing the range '0, -1' to tlb_gather_mmu() sets the 'fullmm' flag,
which indicates that the mm_struct being operated on is going away. In
this case, some architectures (such as arm64) can elide TLB invalidation
by ensuring that the TLB tag (ASID) associated with this mm is not
immediately reclaimed. Although this behaviour is documented in
asm-generic/tlb.h, it's subtle and easily missed.

Introduce tlb_gather_mmu_fullmm() to make it clearer that this is for the
entire mm and WARN() if tlb_gather_mmu() is called with the 'fullmm'
address range.

Signed-off-by: Will Deacon <will@kernel.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Yu Zhao <yuzhao@google.com>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Linus Torvalds <torvalds@linux-foundation.org>
Link: https://lkml.kernel.org/r/20210127235347.1402-4-will@kernel.org
---
 include/asm-generic/tlb.h |  6 ++++--
 include/linux/mm_types.h  |  1 +
 mm/mmap.c                 |  2 +-
 mm/mmu_gather.c           | 16 ++++++++++++++--
 4 files changed, 20 insertions(+), 5 deletions(-)

diff --git a/include/asm-generic/tlb.h b/include/asm-generic/tlb.h
index 6661ee1..2c68a54 100644
--- a/include/asm-generic/tlb.h
+++ b/include/asm-generic/tlb.h
@@ -46,7 +46,9 @@
  *
  * The mmu_gather API consists of:
  *
- *  - tlb_gather_mmu() / tlb_finish_mmu(); start and finish a mmu_gather
+ *  - tlb_gather_mmu() / tlb_gather_mmu_fullmm() / tlb_finish_mmu()
+ *
+ *    start and finish a mmu_gather
  *
  *    Finish in particular will issue a (final) TLB invalidate and free
  *    all (remaining) queued pages.
@@ -91,7 +93,7 @@
  *
  *  - mmu_gather::fullmm
  *
- *    A flag set by tlb_gather_mmu() to indicate we're going to free
+ *    A flag set by tlb_gather_mmu_fullmm() to indicate we're going to free
  *    the entire mm; this allows a number of optimizations.
  *
  *    - We can ignore tlb_{start,end}_vma(); because we don't
diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index 1fe6a51..e49868b 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -590,6 +590,7 @@ static inline cpumask_t *mm_cpumask(struct mm_struct *mm)
 struct mmu_gather;
 extern void tlb_gather_mmu(struct mmu_gather *tlb, struct mm_struct *mm,
 				unsigned long start, unsigned long end);
+extern void tlb_gather_mmu_fullmm(struct mmu_gather *tlb, struct mm_struct *mm);
 extern void tlb_finish_mmu(struct mmu_gather *tlb);
 
 static inline void init_tlb_flush_pending(struct mm_struct *mm)
diff --git a/mm/mmap.c b/mm/mmap.c
index 7a9f493..4eac7c6 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -3214,7 +3214,7 @@ void exit_mmap(struct mm_struct *mm)
 
 	lru_add_drain();
 	flush_cache_mm(mm);
-	tlb_gather_mmu(&tlb, mm, 0, -1);
+	tlb_gather_mmu_fullmm(&tlb, mm);
 	/* update_hiwater_rss(mm) here? but nobody should be looking */
 	/* Use -1 here to ensure all VMAs in the mm are unmapped */
 	unmap_vmas(&tlb, vma, 0, -1);
diff --git a/mm/mmu_gather.c b/mm/mmu_gather.c
index b0be5a7..5f5e45d 100644
--- a/mm/mmu_gather.c
+++ b/mm/mmu_gather.c
@@ -261,8 +261,8 @@ void tlb_flush_mmu(struct mmu_gather *tlb)
  * respectively when @mm is without users and we're going to destroy
  * the full address space (exit/execve).
  */
-void tlb_gather_mmu(struct mmu_gather *tlb, struct mm_struct *mm,
-			unsigned long start, unsigned long end)
+static void __tlb_gather_mmu(struct mmu_gather *tlb, struct mm_struct *mm,
+			     unsigned long start, unsigned long end)
 {
 	tlb->mm = mm;
 
@@ -287,6 +287,18 @@ void tlb_gather_mmu(struct mmu_gather *tlb, struct mm_struct *mm,
 	inc_tlb_flush_pending(tlb->mm);
 }
 
+void tlb_gather_mmu(struct mmu_gather *tlb, struct mm_struct *mm,
+		    unsigned long start, unsigned long end)
+{
+	WARN_ON(!(start | (end + 1))); /* Use _fullmm() instead */
+	__tlb_gather_mmu(tlb, mm, start, end);
+}
+
+void tlb_gather_mmu_fullmm(struct mmu_gather *tlb, struct mm_struct *mm)
+{
+	__tlb_gather_mmu(tlb, mm, 0, -1);
+}
+
 /**
  * tlb_finish_mmu - finish an mmu_gather structure
  * @tlb: the mmu_gather structure to finish
