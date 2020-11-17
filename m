Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 989822B6C1E
	for <lists+linux-tip-commits@lfdr.de>; Tue, 17 Nov 2020 18:47:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729990AbgKQRrO (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Tue, 17 Nov 2020 12:47:14 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:49682 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727838AbgKQRrO (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Tue, 17 Nov 2020 12:47:14 -0500
Date:   Tue, 17 Nov 2020 17:47:09 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1605635231;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=o4O87AnU5hneBS3mjSaT0iMcb9LaTdka39Ud6mJbR/o=;
        b=rfjVlpsMnAoUGTUTBPwvWD3eFgCfWFOdDSD/KkwATcwvaFgy3VexZMs/66QgfK9Weco94n
        sZ3NpA9JfYv52gU43WYW5L8A/sTMWoGsCa3Vf+2+3f3tnkgnaVa8EDsdOf1gcYJjDv7692
        +caS+K+JMQcuca9RHYcu3/XKgkfkhGSWvynW4SERkh2dSg5WziI9Kqb3RABUlztCmEe6VS
        TCsgCqxgEwbiFLmTqRVA4jWq/tpqSAZvpcDoEhcVVlYPTEjydLFSxX2fD2+E7ynF7qv9wp
        r4hecTg/91oqSIOC9OqPAt/9e+KzkZuzLJWspoqhE7gQioB0mRsHdFy4D/QBng==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1605635231;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=o4O87AnU5hneBS3mjSaT0iMcb9LaTdka39Ud6mJbR/o=;
        b=E1IQErOhjtB1UdbbcDxtdoIkjziPjfYFBvht1TmqCJnbgeVVebOR3wptSMQwc3+Zw1IqKH
        pnP6zxq8VJ3kYPAQ==
From:   "tip-bot2 for Arvind Sankar" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: efi/urgent] efi/x86: Free efi_pgd with free_pages()
Cc:     Arvind Sankar <nivedita@alum.mit.edu>,
        Ard Biesheuvel <ardb@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20201110163919.1134431-1-nivedita@alum.mit.edu>
References: <20201110163919.1134431-1-nivedita@alum.mit.edu>
MIME-Version: 1.0
Message-ID: <160563522966.11244.17449598594182315880.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the efi/urgent branch of tip:

Commit-ID:     c2fe61d8be491ff8188edaf22e838f819999146b
Gitweb:        https://git.kernel.org/tip/c2fe61d8be491ff8188edaf22e838f819999146b
Author:        Arvind Sankar <nivedita@alum.mit.edu>
AuthorDate:    Tue, 10 Nov 2020 11:39:19 -05:00
Committer:     Ard Biesheuvel <ardb@kernel.org>
CommitterDate: Tue, 10 Nov 2020 19:18:11 +01:00

efi/x86: Free efi_pgd with free_pages()

Commit

  d9e9a6418065 ("x86/mm/pti: Allocate a separate user PGD")

changed the PGD allocation to allocate PGD_ALLOCATION_ORDER pages, so in
the error path it should be freed using free_pages() rather than
free_page().

Commit

    06ace26f4e6f ("x86/efi: Free efi_pgd with free_pages()")

fixed one instance of this, but missed another.

Move the freeing out-of-line to avoid code duplication and fix this bug.

Fixes: d9e9a6418065 ("x86/mm/pti: Allocate a separate user PGD")
Link: https://lore.kernel.org/r/20201110163919.1134431-1-nivedita@alum.mit.edu
Signed-off-by: Arvind Sankar <nivedita@alum.mit.edu>
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/x86/platform/efi/efi_64.c | 24 +++++++++++++-----------
 1 file changed, 13 insertions(+), 11 deletions(-)

diff --git a/arch/x86/platform/efi/efi_64.c b/arch/x86/platform/efi/efi_64.c
index 8f5759d..e1e8d4e 100644
--- a/arch/x86/platform/efi/efi_64.c
+++ b/arch/x86/platform/efi/efi_64.c
@@ -78,28 +78,30 @@ int __init efi_alloc_page_tables(void)
 	gfp_mask = GFP_KERNEL | __GFP_ZERO;
 	efi_pgd = (pgd_t *)__get_free_pages(gfp_mask, PGD_ALLOCATION_ORDER);
 	if (!efi_pgd)
-		return -ENOMEM;
+		goto fail;
 
 	pgd = efi_pgd + pgd_index(EFI_VA_END);
 	p4d = p4d_alloc(&init_mm, pgd, EFI_VA_END);
-	if (!p4d) {
-		free_page((unsigned long)efi_pgd);
-		return -ENOMEM;
-	}
+	if (!p4d)
+		goto free_pgd;
 
 	pud = pud_alloc(&init_mm, p4d, EFI_VA_END);
-	if (!pud) {
-		if (pgtable_l5_enabled())
-			free_page((unsigned long) pgd_page_vaddr(*pgd));
-		free_pages((unsigned long)efi_pgd, PGD_ALLOCATION_ORDER);
-		return -ENOMEM;
-	}
+	if (!pud)
+		goto free_p4d;
 
 	efi_mm.pgd = efi_pgd;
 	mm_init_cpumask(&efi_mm);
 	init_new_context(NULL, &efi_mm);
 
 	return 0;
+
+free_p4d:
+	if (pgtable_l5_enabled())
+		free_page((unsigned long)pgd_page_vaddr(*pgd));
+free_pgd:
+	free_pages((unsigned long)efi_pgd, PGD_ALLOCATION_ORDER);
+fail:
+	return -ENOMEM;
 }
 
 /*
