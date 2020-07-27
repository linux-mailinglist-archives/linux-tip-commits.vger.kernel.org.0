Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2204022EC7D
	for <lists+linux-tip-commits@lfdr.de>; Mon, 27 Jul 2020 14:46:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728387AbgG0Mqk (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Mon, 27 Jul 2020 08:46:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728495AbgG0MqX (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Mon, 27 Jul 2020 08:46:23 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 931B2C061794;
        Mon, 27 Jul 2020 05:46:22 -0700 (PDT)
Date:   Mon, 27 Jul 2020 12:46:20 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1595853980;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zaloEFRTqoTP58E0zEf74QFtQaCoWtp3TL9B5Itjv9U=;
        b=vUnyyTQRM8mcfmW1fqsro1OjmXz4vT5EvBs0ppcNdOYvJDoSBtbdcyN5IAfG7bxoJPxqh1
        S3KLddU4m2OP38D8GiZ69BNJOETMPgytjCHjJQ7aiPiWsIBZ7krqVrMdDPd7CcQn+iL2al
        2iuxkUGcgCuKrqdFnWcfUL45lAvd4mniVHpyx5lmBZcy9o3AwNqC9BVWoAZfCTvgE4IizS
        gxmpj9Ew7GgVxEyz8rxL9+6BXse9mBiN6ISJayh0aOIAMSGtGt2WI2JXgAjJNKuQlltu0z
        cmwgpZJLbwnw5fUBcrpxbbKCUcnOdf8LoQU3xBR+IVMds5s8L1S0L3C7uXzyeg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1595853980;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zaloEFRTqoTP58E0zEf74QFtQaCoWtp3TL9B5Itjv9U=;
        b=5Vlu6OlzWRusdYSFX7h07Y10owcO8UdyBwUmxXq9Px6ljvz8K/XICgNFWOt0OhY6DLVlU8
        HlCYNPCf4R6wWnCw==
From:   "tip-bot2 for Joerg Roedel" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/mm] x86/mm/64: Do not sync vmalloc/ioremap mappings
Cc:     Joerg Roedel <jroedel@suse.de>, Ingo Molnar <mingo@kernel.org>,
        Mike Rapoport <rppt@linux.ibm.com>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200721095953.6218-3-joro@8bytes.org>
References: <20200721095953.6218-3-joro@8bytes.org>
MIME-Version: 1.0
Message-ID: <159585398003.4006.15699987838110302486.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-tip-commits-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/mm branch of tip:

Commit-ID:     8bb9bf242d1fee925636353807c511d54fde8986
Gitweb:        https://git.kernel.org/tip/8bb9bf242d1fee925636353807c511d54fde8986
Author:        Joerg Roedel <jroedel@suse.de>
AuthorDate:    Tue, 21 Jul 2020 11:59:52 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Mon, 27 Jul 2020 12:32:29 +02:00

x86/mm/64: Do not sync vmalloc/ioremap mappings

Remove the code to sync the vmalloc and ioremap ranges for x86-64. The
page-table pages are all pre-allocated now so that synchronization is
no longer necessary.

Signed-off-by: Joerg Roedel <jroedel@suse.de>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Reviewed-by: Mike Rapoport <rppt@linux.ibm.com>
Link: https://lore.kernel.org/r/20200721095953.6218-3-joro@8bytes.org
---
 arch/x86/include/asm/pgtable_64_types.h | 2 --
 arch/x86/mm/init_64.c                   | 5 -----
 2 files changed, 7 deletions(-)

diff --git a/arch/x86/include/asm/pgtable_64_types.h b/arch/x86/include/asm/pgtable_64_types.h
index 8f63efb..52e5f5f 100644
--- a/arch/x86/include/asm/pgtable_64_types.h
+++ b/arch/x86/include/asm/pgtable_64_types.h
@@ -159,6 +159,4 @@ extern unsigned int ptrs_per_p4d;
 
 #define PGD_KERNEL_START	((PAGE_SIZE / 2) / sizeof(pgd_t))
 
-#define ARCH_PAGE_TABLE_SYNC_MASK	(pgtable_l5_enabled() ?	PGTBL_PGD_MODIFIED : PGTBL_P4D_MODIFIED)
-
 #endif /* _ASM_X86_PGTABLE_64_DEFS_H */
diff --git a/arch/x86/mm/init_64.c b/arch/x86/mm/init_64.c
index e76bdb0..e0cd2df 100644
--- a/arch/x86/mm/init_64.c
+++ b/arch/x86/mm/init_64.c
@@ -217,11 +217,6 @@ void sync_global_pgds(unsigned long start, unsigned long end)
 		sync_global_pgds_l4(start, end);
 }
 
-void arch_sync_kernel_mappings(unsigned long start, unsigned long end)
-{
-	sync_global_pgds(start, end);
-}
-
 /*
  * NOTE: This function is marked __ref because it calls __init function
  * (alloc_bootmem_pages). It's safe to do it ONLY when after_bootmem == 0.
