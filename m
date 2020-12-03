Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 86E5E2CD228
	for <lists+linux-tip-commits@lfdr.de>; Thu,  3 Dec 2020 10:09:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388553AbgLCJId (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Thu, 3 Dec 2020 04:08:33 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:39396 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388469AbgLCJIN (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Thu, 3 Dec 2020 04:08:13 -0500
Date:   Thu, 03 Dec 2020 09:07:31 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1606986451;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/hX4EmIhgprps8EukAJmWTPZSixkL2WulEsR8JZY0Uc=;
        b=Yyf4CyPkIrJcSEpNHZpNd3qWZO78eEcwbuvPUZyLlssj8AoHI0giI76pI8OATZoIXE9Ydz
        +k91NJC3F3x57SBsdTtBtZw7kgHH0jCYnn35Fb1b4/ns+K0sqRWAh3kNJAeVRc+1HiWV66
        2ReBCbbZdtCdQXsFeiJ+naGwzj8qSQl41nk7CCdqSYCCAkZu0z8WO474xyVQ+URlySZGCh
        uszC/OOPDagwiToc8Z8Qi+fyQTVdqWzl7EukPP2QKmqEmReDDrlWiYZK/uesSs0dj7otIp
        9DsSKg2CHFsxZuV4zEzDe6PZvBoNV0EihWnQkHIcSP6SGsm2Dpk+rv4nkanHmQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1606986451;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/hX4EmIhgprps8EukAJmWTPZSixkL2WulEsR8JZY0Uc=;
        b=Dbeox7PIn13ZNLmna8B/SxoNbfbhgPfOsGqLt9anSt+2GICSW90k0G+Qpm/OLIZ/l0zSGQ
        UhN+yNjpq9EOJqDA==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] mm: Introduce pXX_leaf_size()
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20201126121121.102580109@infradead.org>
References: <20201126121121.102580109@infradead.org>
MIME-Version: 1.0
Message-ID: <160698645116.3364.7718413514903352862.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     93aec63b945579b679234ff5e5d7837baf2c7018
Gitweb:        https://git.kernel.org/tip/93aec63b945579b679234ff5e5d7837baf2c7018
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Fri, 13 Nov 2020 11:45:36 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Thu, 03 Dec 2020 10:00:30 +01:00

mm: Introduce pXX_leaf_size()

A number of architectures have non-pagetable aligned huge/large pages.
For such architectures a leaf can actually be part of a larger entry.

Provide generic helpers to determine the size of a page-table leaf.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Link: https://lkml.kernel.org/r/20201126121121.102580109@infradead.org
---
 include/linux/pgtable.h | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
index c8602af..8fcdfa5 100644
--- a/include/linux/pgtable.h
+++ b/include/linux/pgtable.h
@@ -1549,4 +1549,20 @@ typedef unsigned int pgtbl_mod_mask;
 #define pmd_leaf(x)	0
 #endif
 
+#ifndef pgd_leaf_size
+#define pgd_leaf_size(x) (1ULL << PGDIR_SHIFT)
+#endif
+#ifndef p4d_leaf_size
+#define p4d_leaf_size(x) P4D_SIZE
+#endif
+#ifndef pud_leaf_size
+#define pud_leaf_size(x) PUD_SIZE
+#endif
+#ifndef pmd_leaf_size
+#define pmd_leaf_size(x) PMD_SIZE
+#endif
+#ifndef pte_leaf_size
+#define pte_leaf_size(x) PAGE_SIZE
+#endif
+
 #endif /* _LINUX_PGTABLE_H */
