Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ADBC62CD27C
	for <lists+linux-tip-commits@lfdr.de>; Thu,  3 Dec 2020 10:26:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388458AbgLCJZQ (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Thu, 3 Dec 2020 04:25:16 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:39610 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729128AbgLCJZP (ORCPT
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
        bh=5rj0ICCexn5lymhSHOv8+TdXBMy37sde9ag8AwpvBek=;
        b=WlwaCCSvzoYzOw+iyo0RgjtTG+2fagsiswmSOq3SHxPg31pSetZdqu25MNzr2ZGUz/tfFv
        B2CfxK3x9XorAGBSRMkNhZMyT6Eydw9wpulkJbUYVCxCUUyygnD2P2tziSonb7gTO1ImR+
        KvGtxd547XoW/XMmQqyMVDbo5gC/M9FSwUv37eV2PP7xn5y7zsMH/Pzqchwewt+MPPzVma
        xFWZNKlitQojkUlAw/IrjRfM47J3I0wr+bC52JqTcz8sr32rC9UjvYIzIDg89hF0GMO/7S
        +kHVf+PQyGkv8f/nNYv9niRvym+nGu5qZKmUkO2r3LP8fTbgNiXILI8k330qZg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1606987473;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5rj0ICCexn5lymhSHOv8+TdXBMy37sde9ag8AwpvBek=;
        b=stB5rIMqaFm5DdZbzgBVWIfQwCX2v1LQ24h70MpRjvUflYl516GJ3HZCu/9qy3iBQr5zY5
        mkJgF696ud5NR7CA==
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
Message-ID: <160698747295.3364.6132255453696965707.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     560dabbdf68bb15f9e241af8f828b1c8c38d6c6f
Gitweb:        https://git.kernel.org/tip/560dabbdf68bb15f9e241af8f828b1c8c38d6c6f
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Fri, 13 Nov 2020 11:45:36 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Thu, 03 Dec 2020 10:14:50 +01:00

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
index ed9266c..fefbbdb 100644
--- a/include/linux/pgtable.h
+++ b/include/linux/pgtable.h
@@ -1536,4 +1536,20 @@ typedef unsigned int pgtbl_mod_mask;
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
