Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8BA622CD21B
	for <lists+linux-tip-commits@lfdr.de>; Thu,  3 Dec 2020 10:09:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388488AbgLCJIN (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Thu, 3 Dec 2020 04:08:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388467AbgLCJIM (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Thu, 3 Dec 2020 04:08:12 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 041BAC061A4E;
        Thu,  3 Dec 2020 01:07:32 -0800 (PST)
Date:   Thu, 03 Dec 2020 09:07:30 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1606986450;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZESFwGZj+JubuhWQ8H9sKylF1e9+OfKyH5SzJyC65pg=;
        b=r1lRtSiLylaA2ufjVY5DpcGFJzt3rpMPuP7dVq4P8rZhuZMy0fEQRaAVwMGj5Wei5oPru7
        oXElVxKy7miWgxs4v5IjBr6BWBjjsxvcAn1X8z3EnZN5G5mXv84yCXi3seWyapg4Ljr5Ap
        NtmE3rudHyblRdVUqjU41JoaYb1J9LjS3NwZk4ngYbMq92tV25K5+pHaqqbAOizs5DE7cx
        6Vk+fmr1s+tRMJdXHMUPfFRtQfhYuJDHpcIO32n1PKvxmHY3bwzI8cTCJAfFcK4mYYKt90
        UnlnVWbYWNEct5nJCxy0Kxm6UgaYj8ZrWaH6ncpOrVtsxFGFPczGk/IMV6g3YA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1606986450;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZESFwGZj+JubuhWQ8H9sKylF1e9+OfKyH5SzJyC65pg=;
        b=H9UU+UiguIrrIFls4l7j1P7oj+0cd0yBlm4dZMPJjAI9QkV8Zi1ixFM4+IwwstMOOyjVyG
        X0kmmteGZpMTNTAA==
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
Message-ID: <160698645014.3364.16950403315152077351.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     9e7d61ae8acc62ef6dd5fc5f4033ed9420372599
Gitweb:        https://git.kernel.org/tip/9e7d61ae8acc62ef6dd5fc5f4033ed9420372599
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Thu, 26 Nov 2020 11:53:33 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Thu, 03 Dec 2020 10:00:32 +01:00

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
