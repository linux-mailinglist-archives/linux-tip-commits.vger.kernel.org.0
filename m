Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 863672AA12A
	for <lists+linux-tip-commits@lfdr.de>; Sat,  7 Nov 2020 00:28:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728912AbgKFX14 (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 6 Nov 2020 18:27:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728953AbgKFX1X (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 6 Nov 2020 18:27:23 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43CA5C0613D2;
        Fri,  6 Nov 2020 15:27:23 -0800 (PST)
Date:   Fri, 06 Nov 2020 23:27:20 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1604705241;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xiQx7Na3q8MnUN+7b6Zqmv1wy2/qRRd6m3AZxXBTWgg=;
        b=iSwK6ylJht+6g3X7F2Exoq/WN62oTFbz4CrSOE+oFy/n02sRrEm+F3nMmNn5b1Xif2zlWl
        V395YJOIv6EZf7xO9E0M7icYdfR1mAc4b2WaXWSbl+paxH4BeXbkXkBp5JcfNBOK4chn5s
        LRZq/WgnMUVNn4i+OmGI9FGNf7H2MQvdgMuVlDZptGIxhsbM2hG+yPjMB2qkpdi0KsmuNP
        /5YETeLJnZuYwAfcZnFq1jdJuH023qCsHJD+iiTnMf6AbNXR3LA+2XG9QhLNenNnhnmM+8
        RHD/INnezHvty/YEWk7ZcbOHnttB6AxStPvkRLvuB1aDXyKv/7rWjePKKLPD6w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1604705241;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xiQx7Na3q8MnUN+7b6Zqmv1wy2/qRRd6m3AZxXBTWgg=;
        b=tbcbzT/98TLSALi70Gav9emZS01uf7hayjXlb3ruhHjSyy1mCUzhiQIf4fFP16Vo60eHbQ
        yNKrIybfaJIVl8CQ==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/mm] csky/mm/highmem: Switch to generic kmap atomic
Cc:     Thomas Gleixner <tglx@linutronix.de>, Guo Ren <guoren@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20201103095857.681196473@linutronix.de>
References: <20201103095857.681196473@linutronix.de>
MIME-Version: 1.0
Message-ID: <160470524084.397.14899251852515667278.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the core/mm branch of tip:

Commit-ID:     5af627a043e39d3226eecd75753dcd2c920c16ec
Gitweb:        https://git.kernel.org/tip/5af627a043e39d3226eecd75753dcd2c920c16ec
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Tue, 03 Nov 2020 10:27:23 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Fri, 06 Nov 2020 23:14:56 +01:00

csky/mm/highmem: Switch to generic kmap atomic

No reason having the same code in every architecture.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Guo Ren <guoren@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>
Link: https://lore.kernel.org/r/20201103095857.681196473@linutronix.de

---
 arch/csky/Kconfig               |  1 +-
 arch/csky/include/asm/fixmap.h  |  4 +-
 arch/csky/include/asm/highmem.h |  6 ++-
 arch/csky/mm/highmem.c          | 75 +--------------------------------
 4 files changed, 8 insertions(+), 78 deletions(-)

diff --git a/arch/csky/Kconfig b/arch/csky/Kconfig
index 268fad5..7a86481 100644
--- a/arch/csky/Kconfig
+++ b/arch/csky/Kconfig
@@ -286,6 +286,7 @@ config NR_CPUS
 config HIGHMEM
 	bool "High Memory Support"
 	depends on !CPU_CK610
+	select KMAP_LOCAL
 	default y
 
 config FORCE_MAX_ZONEORDER
diff --git a/arch/csky/include/asm/fixmap.h b/arch/csky/include/asm/fixmap.h
index 81f9477..4b589cc 100644
--- a/arch/csky/include/asm/fixmap.h
+++ b/arch/csky/include/asm/fixmap.h
@@ -8,7 +8,7 @@
 #include <asm/memory.h>
 #ifdef CONFIG_HIGHMEM
 #include <linux/threads.h>
-#include <asm/kmap_types.h>
+#include <asm/kmap_size.h>
 #endif
 
 enum fixed_addresses {
@@ -17,7 +17,7 @@ enum fixed_addresses {
 #endif
 #ifdef CONFIG_HIGHMEM
 	FIX_KMAP_BEGIN,
-	FIX_KMAP_END = FIX_KMAP_BEGIN + (KM_TYPE_NR * NR_CPUS) - 1,
+	FIX_KMAP_END = FIX_KMAP_BEGIN + (KM_MAX_IDX * NR_CPUS) - 1,
 #endif
 	__end_of_fixed_addresses
 };
diff --git a/arch/csky/include/asm/highmem.h b/arch/csky/include/asm/highmem.h
index 14645e3..1f4ed3f 100644
--- a/arch/csky/include/asm/highmem.h
+++ b/arch/csky/include/asm/highmem.h
@@ -9,7 +9,7 @@
 #include <linux/init.h>
 #include <linux/interrupt.h>
 #include <linux/uaccess.h>
-#include <asm/kmap_types.h>
+#include <asm/kmap_size.h>
 #include <asm/cache.h>
 
 /* undef for production */
@@ -32,10 +32,12 @@ extern pte_t *pkmap_page_table;
 
 #define ARCH_HAS_KMAP_FLUSH_TLB
 extern void kmap_flush_tlb(unsigned long addr);
-extern void *kmap_atomic_pfn(unsigned long pfn);
 
 #define flush_cache_kmaps() do {} while (0)
 
+#define arch_kmap_local_post_map(vaddr, pteval)	kmap_flush_tlb(vaddr)
+#define arch_kmap_local_post_unmap(vaddr)	kmap_flush_tlb(vaddr)
+
 extern void kmap_init(void);
 
 #endif /* __KERNEL__ */
diff --git a/arch/csky/mm/highmem.c b/arch/csky/mm/highmem.c
index 89c1080..4161df3 100644
--- a/arch/csky/mm/highmem.c
+++ b/arch/csky/mm/highmem.c
@@ -9,8 +9,6 @@
 #include <asm/tlbflush.h>
 #include <asm/cacheflush.h>
 
-static pte_t *kmap_pte;
-
 unsigned long highstart_pfn, highend_pfn;
 
 void kmap_flush_tlb(unsigned long addr)
@@ -19,67 +17,7 @@ void kmap_flush_tlb(unsigned long addr)
 }
 EXPORT_SYMBOL(kmap_flush_tlb);
 
-void *kmap_atomic_high_prot(struct page *page, pgprot_t prot)
-{
-	unsigned long vaddr;
-	int idx, type;
-
-	type = kmap_atomic_idx_push();
-	idx = type + KM_TYPE_NR*smp_processor_id();
-	vaddr = __fix_to_virt(FIX_KMAP_BEGIN + idx);
-#ifdef CONFIG_DEBUG_HIGHMEM
-	BUG_ON(!pte_none(*(kmap_pte - idx)));
-#endif
-	set_pte(kmap_pte-idx, mk_pte(page, prot));
-	flush_tlb_one((unsigned long)vaddr);
-
-	return (void *)vaddr;
-}
-EXPORT_SYMBOL(kmap_atomic_high_prot);
-
-void kunmap_atomic_high(void *kvaddr)
-{
-	unsigned long vaddr = (unsigned long) kvaddr & PAGE_MASK;
-	int idx;
-
-	if (vaddr < FIXADDR_START)
-		return;
-
-#ifdef CONFIG_DEBUG_HIGHMEM
-	idx = KM_TYPE_NR*smp_processor_id() + kmap_atomic_idx();
-
-	BUG_ON(vaddr != __fix_to_virt(FIX_KMAP_BEGIN + idx));
-
-	pte_clear(&init_mm, vaddr, kmap_pte - idx);
-	flush_tlb_one(vaddr);
-#else
-	(void) idx; /* to kill a warning */
-#endif
-	kmap_atomic_idx_pop();
-}
-EXPORT_SYMBOL(kunmap_atomic_high);
-
-/*
- * This is the same as kmap_atomic() but can map memory that doesn't
- * have a struct page associated with it.
- */
-void *kmap_atomic_pfn(unsigned long pfn)
-{
-	unsigned long vaddr;
-	int idx, type;
-
-	pagefault_disable();
-
-	type = kmap_atomic_idx_push();
-	idx = type + KM_TYPE_NR*smp_processor_id();
-	vaddr = __fix_to_virt(FIX_KMAP_BEGIN + idx);
-	set_pte(kmap_pte-idx, pfn_pte(pfn, PAGE_KERNEL));
-	flush_tlb_one(vaddr);
-
-	return (void *) vaddr;
-}
-
-static void __init kmap_pages_init(void)
+void __init kmap_init(void)
 {
 	unsigned long vaddr;
 	pgd_t *pgd;
@@ -96,14 +34,3 @@ static void __init kmap_pages_init(void)
 	pte = pte_offset_kernel(pmd, vaddr);
 	pkmap_page_table = pte;
 }
-
-void __init kmap_init(void)
-{
-	unsigned long vaddr;
-
-	kmap_pages_init();
-
-	vaddr = __fix_to_virt(FIX_KMAP_BEGIN);
-
-	kmap_pte = pte_offset_kernel((pmd_t *)pgd_offset_k(vaddr), vaddr);
-}
