Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA4DE2D4950
	for <lists+linux-tip-commits@lfdr.de>; Wed,  9 Dec 2020 19:46:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733034AbgLISpb (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 9 Dec 2020 13:45:31 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:48550 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733276AbgLISpY (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 9 Dec 2020 13:45:24 -0500
Date:   Wed, 09 Dec 2020 18:44:41 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1607539481;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hFSrSCbfgqTV8Uq/be5lRFzQnIszjfWspKcqjSJrZvA=;
        b=0/BVTm4rYyv8rJXujzTsJGlDamNAsbEPd5154QsAYgTWOUE2+GjwEe2OOEoUCaws2HNN0A
        InNOYqKu6ncrGTutqUzrPUQb6G9+bV3paeIQnibx5fhQv0WWr3v2lo3r4/2S0lGN6DISs/
        8fysCgDqTjgk36TB3/bxC1+CsGkePlvU258GY6CvQsy8jxQ7T7ekQcDAcGzEAkxPT++g47
        TmEMjFmAgJmx2EGH6Qd+t3veT2RhJHyIc0NACb3q4el7OuWhbS6RS28835dPi7Qy4aodqe
        GLR+F234BARHtLj2+v94ueSibXhZhdT2VPGlz3a7hufmye6TyIgSS/tWDestxQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1607539481;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hFSrSCbfgqTV8Uq/be5lRFzQnIszjfWspKcqjSJrZvA=;
        b=zqtxy8eXfrzaQk6OTw9+9b9eaXmHwncdvxXTyw5o/Fxm6WekvOK6JqQ1oKHRnZbHOZHKCs
        atpcsHNGdrSInRAA==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] powerpc/8xx: Implement pXX_leaf_size() support
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20201126121121.364451610@infradead.org>
References: <20201126121121.364451610@infradead.org>
MIME-Version: 1.0
Message-ID: <160753948109.3364.11131685830660675965.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     c5eecbb58f65bf1c4effab9a7f283184b469768c
Gitweb:        https://git.kernel.org/tip/c5eecbb58f65bf1c4effab9a7f283184b469768c
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Thu, 26 Nov 2020 11:53:33 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 09 Dec 2020 17:08:56 +01:00

powerpc/8xx: Implement pXX_leaf_size() support

Christophe Leroy wrote:

> I can help with powerpc 8xx. It is a 32 bits powerpc. The PGD has 1024
> entries, that means each entry maps 4M.
>
> Page sizes are 4k, 16k, 512k and 8M.
>
> For the 8M pages we use hugepd with a single entry. The two related PGD
> entries point to the same hugepd.
>
> For the other sizes, they are in standard page tables. 16k pages appear
> 4 times in the page table. 512k entries appear 128 times in the page
> table.
>
> When the PGD entry has _PMD_PAGE_8M bits, the PMD entry points to a
> hugepd with holds the single 8M entry.
>
> In the PTE, we have two bits: _PAGE_SPS and _PAGE_HUGE
>
> _PAGE_HUGE means it is a 512k page
> _PAGE_SPS means it is not a 4k page
>
> The kernel can by build either with 4k pages as standard page size, or
> 16k pages. It doesn't change the page table layout though.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20201126121121.364451610@infradead.org
---
 arch/powerpc/include/asm/nohash/32/pte-8xx.h | 23 +++++++++++++++++++-
 1 file changed, 23 insertions(+)

diff --git a/arch/powerpc/include/asm/nohash/32/pte-8xx.h b/arch/powerpc/include/asm/nohash/32/pte-8xx.h
index 1581204..fcc48d5 100644
--- a/arch/powerpc/include/asm/nohash/32/pte-8xx.h
+++ b/arch/powerpc/include/asm/nohash/32/pte-8xx.h
@@ -135,6 +135,29 @@ static inline pte_t pte_mkhuge(pte_t pte)
 }
 
 #define pte_mkhuge pte_mkhuge
+
+static inline unsigned long pgd_leaf_size(pgd_t pgd)
+{
+	if (pgd_val(pgd) & _PMD_PAGE_8M)
+		return SZ_8M;
+	return SZ_4M;
+}
+
+#define pgd_leaf_size pgd_leaf_size
+
+static inline unsigned long pte_leaf_size(pte_t pte)
+{
+	pte_basic_t val = pte_val(pte);
+
+	if (val & _PAGE_HUGE)
+		return SZ_512K;
+	if (val & _PAGE_SPS)
+		return SZ_16K;
+	return SZ_4K;
+}
+
+#define pte_leaf_size pte_leaf_size
+
 #endif
 
 #endif /* __KERNEL__ */
