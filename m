Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 833022E9D07
	for <lists+linux-tip-commits@lfdr.de>; Mon,  4 Jan 2021 19:30:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726497AbhADSaF (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Mon, 4 Jan 2021 13:30:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726396AbhADSaE (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Mon, 4 Jan 2021 13:30:04 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 435E9C061794;
        Mon,  4 Jan 2021 10:29:24 -0800 (PST)
Date:   Mon, 04 Jan 2021 18:29:19 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1609784959;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kM7c+t6EDNGt6sqKxFbnnws/zaHoluaYzE3C9iUtwbc=;
        b=H3884R/mTQXg0CE5ihc1Nslsl/1aWF0dyhNxlNFnuZp5htxTUsXqlBH5BFDajz9720FjFa
        QgZ/1aI5AGffq+GXs8Zb/MwSyqmdmCW+Z32lCyuzASdX2sDCHrSqU2zFYltKHDVoG1sU6K
        SeB7rRSS6m34H2d74WaSpvsQHKs8MSGIftg53zPErlzAPgZErgskR05GHZYc95WZBsaWTP
        mxNqr/BNdF+n7BxERBOsaFMytcVlLyrCVSTE8WmeRstK2BvF0dO1ObVp0ZVEssMeOM5gov
        tBFteYLEeFviEj95VPJtrixaTkABgsBwuxg+zxSOeFtNy4+4hyrkRhgne1ZCUA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1609784959;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kM7c+t6EDNGt6sqKxFbnnws/zaHoluaYzE3C9iUtwbc=;
        b=I3jXBXv9bvZ7S8PuWfwRFPMhRV7sjc3DHhs4QUML4n3H7pNe9r6JqkZj9qB9Z5XZLQumb2
        E3vkzW3I8XLcFZDA==
From:   "tip-bot2 for Lorenzo Stoakes" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/mm] x86/mm: Increase pgt_buf size for 5-level page tables
Cc:     Lorenzo Stoakes <lstoakes@gmail.com>, Borislav Petkov <bp@suse.de>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Dave Hansen <dave.hansen@intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20201215205641.34096-1-lstoakes@gmail.com>
References: <20201215205641.34096-1-lstoakes@gmail.com>
MIME-Version: 1.0
Message-ID: <160978495908.414.11743150085990569826.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/mm branch of tip:

Commit-ID:     167dcfc08b0b1f964ea95d410aa496fd78adf475
Gitweb:        https://git.kernel.org/tip/167dcfc08b0b1f964ea95d410aa496fd78adf475
Author:        Lorenzo Stoakes <lstoakes@gmail.com>
AuthorDate:    Tue, 15 Dec 2020 20:56:41 
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Mon, 04 Jan 2021 18:07:50 +01:00

x86/mm: Increase pgt_buf size for 5-level page tables

pgt_buf is used to allocate page tables on initial direct page mapping
which bootstraps the kernel into being able to allocate these before the
direct mapping makes further pages available.

INIT_PGD_PAGE_COUNT is set to 6 pages (doubled for KASLR) - 3 (PUD, PMD,
PTE) for the 1 MiB ISA mapping and 3 more for the first direct mapping
assignment in each case providing 2 MiB of address space.

This has not been updated for 5-level page tables which has an
additional P4D page table level above PUD.

In most instances, this will not have a material impact as the first
4 page levels allocated for the ISA mapping will provide sufficient
address space to encompass all further address mappings.

If the first direct mapping is within 512 GiB of the ISA mapping, only
a PMD and PTE needs to be added in the instance the kernel is using 4
KiB page tables (e.g. CONFIG_DEBUG_PAGEALLOC is enabled) and only a PMD
if the kernel can use 2 MiB pages (the first allocation is limited to
PMD_SIZE so a GiB page cannot be used there).

However, if the machine has more than 512 GiB of RAM and the kernel is
allocating 4 KiB page size, 3 further page tables are required.

If the machine has more than 256 TiB of RAM at 4 KiB or 2 MiB page size,
further 3 or 4 page tables are required respectively.

Update INIT_PGD_PAGE_COUNT to reflect this.

 [ bp: Sanitize text into passive voice without ambiguous personal pronouns. ]

Signed-off-by: Lorenzo Stoakes <lstoakes@gmail.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Acked-by: Dave Hansen <dave.hansen@intel.com>
Link: https://lkml.kernel.org/r/20201215205641.34096-1-lstoakes@gmail.com
---
 arch/x86/mm/init.c | 19 ++++++++++++++-----
 1 file changed, 14 insertions(+), 5 deletions(-)

diff --git a/arch/x86/mm/init.c b/arch/x86/mm/init.c
index e26f5c5..dd694fb 100644
--- a/arch/x86/mm/init.c
+++ b/arch/x86/mm/init.c
@@ -157,16 +157,25 @@ __ref void *alloc_low_pages(unsigned int num)
 }
 
 /*
- * By default need 3 4k for initial PMD_SIZE,  3 4k for 0-ISA_END_ADDRESS.
- * With KASLR memory randomization, depending on the machine e820 memory
- * and the PUD alignment. We may need twice more pages when KASLR memory
+ * By default need to be able to allocate page tables below PGD firstly for
+ * the 0-ISA_END_ADDRESS range and secondly for the initial PMD_SIZE mapping.
+ * With KASLR memory randomization, depending on the machine e820 memory and the
+ * PUD alignment, twice that many pages may be needed when KASLR memory
  * randomization is enabled.
  */
+
+#ifndef CONFIG_X86_5LEVEL
+#define INIT_PGD_PAGE_TABLES    3
+#else
+#define INIT_PGD_PAGE_TABLES    4
+#endif
+
 #ifndef CONFIG_RANDOMIZE_MEMORY
-#define INIT_PGD_PAGE_COUNT      6
+#define INIT_PGD_PAGE_COUNT      (2 * INIT_PGD_PAGE_TABLES)
 #else
-#define INIT_PGD_PAGE_COUNT      12
+#define INIT_PGD_PAGE_COUNT      (4 * INIT_PGD_PAGE_TABLES)
 #endif
+
 #define INIT_PGT_BUF_SIZE	(INIT_PGD_PAGE_COUNT * PAGE_SIZE)
 RESERVE_BRK(early_pgt_alloc, INIT_PGT_BUF_SIZE);
 void  __init early_alloc_pgt_buf(void)
