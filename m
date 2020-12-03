Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 183F22CD227
	for <lists+linux-tip-commits@lfdr.de>; Thu,  3 Dec 2020 10:09:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388555AbgLCJId (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Thu, 3 Dec 2020 04:08:33 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:39380 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387417AbgLCJIN (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Thu, 3 Dec 2020 04:08:13 -0500
Date:   Thu, 03 Dec 2020 09:07:30 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1606986450;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VL7YbcuZGGKz6iZIS8ph5OXsKb/tBxYNcCrGK+Fgluk=;
        b=R3TXHjWwJOImO481tp/1ViFi37lU5+z/RYWIcDeEv1P7R0NKCboSoDsFnwL4d+3egNgo3i
        6hNkKSpki1MQe9q7qYhe6DGTuK6yzI3FfAVZ3Lj+/bP0jYJMiX1yU8wUtFa07B9H8mmWuZ
        RCbNyopU9oXGE0FlXUF8YdY2ftYLuHm3CrLgs6RdLx94X0z8e72usxWBHioBHgCseMuIzv
        jU+1/wXpl0KDfoQR5XqkOQJZlKf9Uj57Qhad0Mk3d2ceuQNvVjhZvm165WLvxLnJ25de+b
        vfTMpBLNot8/+oqPsr7BVdSdFwYBWad02uwgNv3kwRHhOoX2EeBuErsyp6nD8A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1606986450;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VL7YbcuZGGKz6iZIS8ph5OXsKb/tBxYNcCrGK+Fgluk=;
        b=AhCbXVAQ5gNy1uJMUw+tsZIO+fq9xiXoiUQEl+YILK+wyhoFqvd9hiRp42JxCWgwtYakjm
        Nt2n/TgaEBdXQkAg==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] sparc64/mm: Implement pXX_leaf_size() support
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20201126121121.301768209@infradead.org>
References: <20201126121121.301768209@infradead.org>
MIME-Version: 1.0
Message-ID: <160698645038.3364.1277626764730981396.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     58aeee3cecc5fd4922bbd21c294905267baf4edd
Gitweb:        https://git.kernel.org/tip/58aeee3cecc5fd4922bbd21c294905267baf4edd
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Fri, 13 Nov 2020 11:46:23 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Thu, 03 Dec 2020 10:00:31 +01:00

sparc64/mm: Implement pXX_leaf_size() support

Sparc64 has non-pagetable aligned large page support; wire up the
pXX_leaf_size() functions to report the correct pagetable page size.

This enables PERF_SAMPLE_{DATA,CODE}_PAGE_SIZE to report accurate
pagetable leaf sizes.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20201126121121.301768209@infradead.org
---
 arch/sparc/include/asm/pgtable_64.h | 13 +++++++++++++
 arch/sparc/mm/hugetlbpage.c         | 19 +++++++++++++------
 2 files changed, 26 insertions(+), 6 deletions(-)

diff --git a/arch/sparc/include/asm/pgtable_64.h b/arch/sparc/include/asm/pgtable_64.h
index 7ef6aff..550d390 100644
--- a/arch/sparc/include/asm/pgtable_64.h
+++ b/arch/sparc/include/asm/pgtable_64.h
@@ -1121,6 +1121,19 @@ extern unsigned long cmdline_memory_size;
 
 asmlinkage void do_sparc64_fault(struct pt_regs *regs);
 
+#ifdef CONFIG_HUGETLB_PAGE
+
+#define pud_leaf_size pud_leaf_size
+extern unsigned long pud_leaf_size(pud_t pud);
+
+#define pmd_leaf_size pmd_leaf_size
+extern unsigned long pmd_leaf_size(pmd_t pmd);
+
+#define pte_leaf_size pte_leaf_size
+extern unsigned long pte_leaf_size(pte_t pte);
+
+#endif /* CONFIG_HUGETLB_PAGE */
+
 #endif /* !(__ASSEMBLY__) */
 
 #endif /* !(_SPARC64_PGTABLE_H) */
diff --git a/arch/sparc/mm/hugetlbpage.c b/arch/sparc/mm/hugetlbpage.c
index ec423b5..bf865dc 100644
--- a/arch/sparc/mm/hugetlbpage.c
+++ b/arch/sparc/mm/hugetlbpage.c
@@ -247,14 +247,17 @@ static unsigned int sun4u_huge_tte_to_shift(pte_t entry)
 	return shift;
 }
 
-static unsigned int huge_tte_to_shift(pte_t entry)
+static unsigned long tte_to_shift(pte_t entry)
 {
-	unsigned long shift;
-
 	if (tlb_type == hypervisor)
-		shift = sun4v_huge_tte_to_shift(entry);
-	else
-		shift = sun4u_huge_tte_to_shift(entry);
+		return sun4v_huge_tte_to_shift(entry);
+
+	return sun4u_huge_tte_to_shift(entry);
+}
+
+static unsigned int huge_tte_to_shift(pte_t entry)
+{
+	unsigned long shift = tte_to_shift(entry);
 
 	if (shift == PAGE_SHIFT)
 		WARN_ONCE(1, "tto_to_shift: invalid hugepage tte=0x%lx\n",
@@ -272,6 +275,10 @@ static unsigned long huge_tte_to_size(pte_t pte)
 	return size;
 }
 
+unsigned long pud_leaf_size(pud_t pud) { return 1UL << tte_to_shift((pte_t)pud); }
+unsigned long pmd_leaf_size(pmd_t pmd) { return 1UL << tte_to_shift((pte_t)pmd); }
+unsigned long pte_leaf_size(pte_t pte) { return 1UL << tte_to_shift((pte_t)pte); }
+
 pte_t *huge_pte_alloc(struct mm_struct *mm,
 			unsigned long addr, unsigned long sz)
 {
