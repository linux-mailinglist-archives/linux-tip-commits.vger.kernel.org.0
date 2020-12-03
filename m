Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5EE0E2CD282
	for <lists+linux-tip-commits@lfdr.de>; Thu,  3 Dec 2020 10:27:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388576AbgLCJZc (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Thu, 3 Dec 2020 04:25:32 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:39602 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729074AbgLCJZP (ORCPT
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
        bh=m5lCiy8nyJU9j8amdDoA7l2sVibPokZVpo+HAwvRG5g=;
        b=TC1rgDSZaQjgTepkFPr5plmvpCDqTiAcIni6UcVaBZC6vokffmtUHmE01I2ZfZogUPBVQE
        5KGYBaz1hZkUGkkm/3i8wwi7VDYE0D7RX0QGwYOieOxzoxrf6tqh9pPsL59PxKpLP/75tM
        PVfvQEXLwT20I6cXSXKy+8v3U+Z+tia2XbyXnyZPQ7qVsh2NANtQfqsef24fjOH04UQoPj
        2mobmqN7WCwui0lO/wGFbFy4BwJU77/1ZnaRh2YE2+1wKlotfgJq+7PmCZZtJhRYyFoBnX
        OXLsTs4Plq9D4afKc7zlqoViYpXfrsJQ1Z3xv4dTrE36U3eOdbRFbi0Hp6oeHQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1606987473;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=m5lCiy8nyJU9j8amdDoA7l2sVibPokZVpo+HAwvRG5g=;
        b=qescARt7/p6OuWp+SzjNq3MO8+xJq7KlP1ZcMzAScw6SkOt4Tm4/lL56PH7Seb0kI4GKFF
        svuhHuhBs0t/mgAA==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] arm64/mm: Implement pXX_leaf_size() support
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Will Deacon <will@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20201126125747.GG2414@hirez.programming.kicks-ass.net>
References: <20201126125747.GG2414@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Message-ID: <160698747268.3364.5296668255616343302.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     d55863db1dfec8845067f5625f1b0ab18c8948be
Gitweb:        https://git.kernel.org/tip/d55863db1dfec8845067f5625f1b0ab18c8948be
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Fri, 13 Nov 2020 11:46:06 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Thu, 03 Dec 2020 10:14:51 +01:00

arm64/mm: Implement pXX_leaf_size() support

ARM64 has non-pagetable aligned large page support with PTE_CONT, when
this bit is set the page is part of a super-page. Match the hugetlb
code and support these super pages for PTE and PMD levels.

This enables PERF_SAMPLE_{DATA,CODE}_PAGE_SIZE to report accurate
pagetable leaf sizes.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Will Deacon <will@kernel.org>
Link: https://lkml.kernel.org/r/20201126125747.GG2414@hirez.programming.kicks-ass.net
---
 arch/arm64/include/asm/pgtable.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
index 4ff12a7..c3b92a4 100644
--- a/arch/arm64/include/asm/pgtable.h
+++ b/arch/arm64/include/asm/pgtable.h
@@ -407,6 +407,7 @@ static inline int pmd_trans_huge(pmd_t pmd)
 #define pmd_dirty(pmd)		pte_dirty(pmd_pte(pmd))
 #define pmd_young(pmd)		pte_young(pmd_pte(pmd))
 #define pmd_valid(pmd)		pte_valid(pmd_pte(pmd))
+#define pmd_cont(pmd)		pte_cont(pmd_pte(pmd))
 #define pmd_wrprotect(pmd)	pte_pmd(pte_wrprotect(pmd_pte(pmd)))
 #define pmd_mkold(pmd)		pte_pmd(pte_mkold(pmd_pte(pmd)))
 #define pmd_mkwrite(pmd)	pte_pmd(pte_mkwrite(pmd_pte(pmd)))
@@ -503,6 +504,9 @@ extern pgprot_t phys_mem_access_prot(struct file *file, unsigned long pfn,
 				 PMD_TYPE_SECT)
 #define pmd_leaf(pmd)		pmd_sect(pmd)
 
+#define pmd_leaf_size(pmd)	(pmd_cont(pmd) ? CONT_PMD_SIZE : PMD_SIZE)
+#define pte_leaf_size(pte)	(pte_cont(pte) ? CONT_PTE_SIZE : PAGE_SIZE)
+
 #if defined(CONFIG_ARM64_64K_PAGES) || CONFIG_PGTABLE_LEVELS < 3
 static inline bool pud_sect(pud_t pud) { return false; }
 static inline bool pud_table(pud_t pud) { return true; }
