Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2523C29E9B4
	for <lists+linux-tip-commits@lfdr.de>; Thu, 29 Oct 2020 11:53:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726954AbgJ2KxC (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Thu, 29 Oct 2020 06:53:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726863AbgJ2Kvo (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Thu, 29 Oct 2020 06:51:44 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48D3FC0613D2;
        Thu, 29 Oct 2020 03:51:43 -0700 (PDT)
Date:   Thu, 29 Oct 2020 10:51:40 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1603968701;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=ylnhJqI8Sk4Di3e9dNk2bF3N994C2NiHX9hDlrepkqE=;
        b=QqWuKTry8rc31+eKEBfrFobRC4VBhRraAnT6lT/gJ7lwbNxVKMgdXbcOEGpZnlpKx3fgFM
        m2UuZIQDdqEDbSE9SkGWJ2UOhruplKsEjhDUuFx/lMnyMErQcOEbnCpT43vrFBM0em7vaU
        pbDYdk/v06vJCswO3HyURPnzVn6ixDT6vfDaPtMz52UFTolHs+y/Kx2Mc8truqfrQXY4yh
        5dJcFATynw5Sx5/m4dmz+moBIBNlTThRMnzEt24sS4oiwynXbntsSmzBZoO9E4TwVuTQX/
        2wPv5fU6pNDcTbrykvqlFOuUiowZk0WdXkPCkkjKeznmYgUnjAZ6fkfA9758RA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1603968701;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=ylnhJqI8Sk4Di3e9dNk2bF3N994C2NiHX9hDlrepkqE=;
        b=F/LTzUVDnuO8+UDiIFRHNz+2WrKdWrJ9Br0ehEvogsVu9lkRB8D8vZT1VEaflVBehD0ZbQ
        wwtcfLy95Hvw/6AQ==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf,mm: Handle non-page-table-aligned hugetlbfs
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <160396870073.397.5253000962129174657.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     51b646b2d9f84d6ff6300e3c1d09f2be4329a424
Gitweb:        https://git.kernel.org/tip/51b646b2d9f84d6ff6300e3c1d09f2be4329a424
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Fri, 09 Oct 2020 11:09:27 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Thu, 29 Oct 2020 11:00:39 +01:00

perf,mm: Handle non-page-table-aligned hugetlbfs

A limited nunmber of architectures support hugetlbfs sizes that do not
align with the page-tables (ARM64, Power, Sparc64). Add support for
this to the generic perf_get_page_size() implementation, and also
allow an architecture to override this implementation.

This latter is only needed when it uses non-page-table aligned huge
pages in its kernel map.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 include/linux/perf_event.h |  4 ++++-
 kernel/events/core.c       | 39 +++++++++++++++++++++++++++++++------
 2 files changed, 37 insertions(+), 6 deletions(-)

diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index e533b03..0defb52 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -1590,4 +1590,8 @@ extern void __weak arch_perf_update_userpage(struct perf_event *event,
 					     struct perf_event_mmap_page *userpg,
 					     u64 now);
 
+#ifdef CONFIG_MMU
+extern __weak u64 arch_perf_get_page_size(struct mm_struct *mm, unsigned long addr);
+#endif
+
 #endif /* _LINUX_PERF_EVENT_H */
diff --git a/kernel/events/core.c b/kernel/events/core.c
index 7f655d1..b458ed3 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -7011,10 +7011,18 @@ static u64 perf_virt_to_phys(u64 virt)
 #ifdef CONFIG_MMU
 
 /*
- * Return the MMU page size of a given virtual address
+ * Return the MMU page size of a given virtual address.
+ *
+ * This generic implementation handles page-table aligned huge pages, as well
+ * as non-page-table aligned hugetlbfs compound pages.
+ *
+ * If an architecture supports and uses non-page-table aligned pages in their
+ * kernel mapping it will need to provide it's own implementation of this
+ * function.
  */
-static u64 __perf_get_page_size(struct mm_struct *mm, unsigned long addr)
+__weak u64 arch_perf_get_page_size(struct mm_struct *mm, unsigned long addr)
 {
+	struct page *page;
 	pgd_t *pgd;
 	p4d_t *p4d;
 	pud_t *pud;
@@ -7036,15 +7044,27 @@ static u64 __perf_get_page_size(struct mm_struct *mm, unsigned long addr)
 	if (!pud_present(*pud))
 		return 0;
 
-	if (pud_leaf(*pud))
+	if (pud_leaf(*pud)) {
+#ifdef pud_page
+		page = pud_page(*pud);
+		if (PageHuge(page))
+			return page_size(compound_head(page));
+#endif
 		return 1ULL << PUD_SHIFT;
+	}
 
 	pmd = pmd_offset(pud, addr);
 	if (!pmd_present(*pmd))
 		return 0;
 
-	if (pmd_leaf(*pmd))
+	if (pmd_leaf(*pmd)) {
+#ifdef pmd_page
+		page = pmd_page(*pmd);
+		if (PageHuge(page))
+			return page_size(compound_head(page));
+#endif
 		return 1ULL << PMD_SHIFT;
+	}
 
 	pte = pte_offset_map(pmd, addr);
 	if (!pte_present(*pte)) {
@@ -7052,13 +7072,20 @@ static u64 __perf_get_page_size(struct mm_struct *mm, unsigned long addr)
 		return 0;
 	}
 
+	page = pte_page(*pte);
+	if (PageHuge(page)) {
+		u64 size = page_size(compound_head(page));
+		pte_unmap(pte);
+		return size;
+	}
+
 	pte_unmap(pte);
 	return PAGE_SIZE;
 }
 
 #else
 
-static u64 __perf_get_page_size(struct mm_struct *mm, unsigned long addr)
+static u64 arch_perf_get_page_size(struct mm_struct *mm, unsigned long addr)
 {
 	return 0;
 }
@@ -7089,7 +7116,7 @@ static u64 perf_get_page_size(unsigned long addr)
 		mm = &init_mm;
 	}
 
-	size = __perf_get_page_size(mm, addr);
+	size = arch_perf_get_page_size(mm, addr);
 
 	local_irq_restore(flags);
 
