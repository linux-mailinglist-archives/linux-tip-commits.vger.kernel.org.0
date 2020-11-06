Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 275FD2AA127
	for <lists+linux-tip-commits@lfdr.de>; Sat,  7 Nov 2020 00:28:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729124AbgKFX1z (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 6 Nov 2020 18:27:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728957AbgKFX1X (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 6 Nov 2020 18:27:23 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4684FC0613D3;
        Fri,  6 Nov 2020 15:27:23 -0800 (PST)
Date:   Fri, 06 Nov 2020 23:27:19 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1604705241;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+UQDYwuW4u7TCuA7jHycfr1zv/C8czt1YehBkj9BQjc=;
        b=XayQRhhD8L4NIIgOSXOdhl+arIvn75+hNR64hBcp1odDsPqnfuGpEJXTOiG8X2Uw5C3Sn6
        0vSqysMiiv835Cg5ur5EaMDefaLSODh2efu/vuhcGl8bVp9FWX14e3YD8tcHOacD1mjXZr
        jiC1qSu6ybR3qmWIeQfobhUXgaX2P17clIp1JslAiPp5YqraToSqrLiAlzNAY90aDnJXLZ
        3y3tNw5z3z86AKWsZTo/wHT7SPGgCBTcmg586dzbCSSi4OrD4MKzWHr3bisZOENPJ8UHB1
        ik2QRY+xwYvpwc/IS7cFtXD6igZwpGfajAI+ulR8d4XcNf1feB96okJWGDIJjw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1604705241;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+UQDYwuW4u7TCuA7jHycfr1zv/C8czt1YehBkj9BQjc=;
        b=0kRdU8fyp1azxUHVIoKqv9m9HcpqZCxkr0dYDeptwNZ9xMT173U1ebfejPwgPA7YUJU2DO
        lniPDgLSuQj6zMBQ==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/mm] microblaze/mm/highmem: Switch to generic kmap atomic
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Michal Simek <monstr@monstr.eu>, Arnd Bergmann <arnd@arndb.de>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20201103095857.777445435@linutronix.de>
References: <20201103095857.777445435@linutronix.de>
MIME-Version: 1.0
Message-ID: <160470523993.397.8433521554678433169.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the core/mm branch of tip:

Commit-ID:     7ac1b26b0a7288fc8f87aa8978891375f23740b2
Gitweb:        https://git.kernel.org/tip/7ac1b26b0a7288fc8f87aa8978891375f23740b2
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Tue, 03 Nov 2020 10:27:24 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Fri, 06 Nov 2020 23:14:56 +01:00

microblaze/mm/highmem: Switch to generic kmap atomic

No reason having the same code in every architecture.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Michal Simek <monstr@monstr.eu>
Cc: Arnd Bergmann <arnd@arndb.de>
Link: https://lore.kernel.org/r/20201103095857.777445435@linutronix.de

---
 arch/microblaze/Kconfig               |  1 +-
 arch/microblaze/include/asm/fixmap.h  |  4 +-
 arch/microblaze/include/asm/highmem.h |  6 +-
 arch/microblaze/mm/Makefile           |  1 +-
 arch/microblaze/mm/highmem.c          | 78 +--------------------------
 arch/microblaze/mm/init.c             |  6 +--
 6 files changed, 8 insertions(+), 88 deletions(-)
 delete mode 100644 arch/microblaze/mm/highmem.c

diff --git a/arch/microblaze/Kconfig b/arch/microblaze/Kconfig
index 33925ff..7f6ca0a 100644
--- a/arch/microblaze/Kconfig
+++ b/arch/microblaze/Kconfig
@@ -155,6 +155,7 @@ config XILINX_UNCACHED_SHADOW
 config HIGHMEM
 	bool "High memory support"
 	depends on MMU
+	select KMAP_LOCAL
 	help
 	  The address space of Microblaze processors is only 4 Gigabytes large
 	  and it has to accommodate user address space, kernel address
diff --git a/arch/microblaze/include/asm/fixmap.h b/arch/microblaze/include/asm/fixmap.h
index 0379ce5..e6e9288 100644
--- a/arch/microblaze/include/asm/fixmap.h
+++ b/arch/microblaze/include/asm/fixmap.h
@@ -20,7 +20,7 @@
 #include <asm/page.h>
 #ifdef CONFIG_HIGHMEM
 #include <linux/threads.h>
-#include <asm/kmap_types.h>
+#include <asm/kmap_size.h>
 #endif
 
 #define FIXADDR_TOP	((unsigned long)(-PAGE_SIZE))
@@ -47,7 +47,7 @@ enum fixed_addresses {
 	FIX_HOLE,
 #ifdef CONFIG_HIGHMEM
 	FIX_KMAP_BEGIN,	/* reserved pte's for temporary kernel mappings */
-	FIX_KMAP_END = FIX_KMAP_BEGIN + (KM_TYPE_NR * num_possible_cpus()) - 1,
+	FIX_KMAP_END = FIX_KMAP_BEGIN + (KM_MAX_IDX * num_possible_cpus()) - 1,
 #endif
 	__end_of_fixed_addresses
 };
diff --git a/arch/microblaze/include/asm/highmem.h b/arch/microblaze/include/asm/highmem.h
index 284ca8f..4418633 100644
--- a/arch/microblaze/include/asm/highmem.h
+++ b/arch/microblaze/include/asm/highmem.h
@@ -25,7 +25,6 @@
 #include <linux/uaccess.h>
 #include <asm/fixmap.h>
 
-extern pte_t *kmap_pte;
 extern pte_t *pkmap_page_table;
 
 /*
@@ -52,6 +51,11 @@ extern pte_t *pkmap_page_table;
 
 #define flush_cache_kmaps()	{ flush_icache(); flush_dcache(); }
 
+#define arch_kmap_local_post_map(vaddr, pteval)	\
+	local_flush_tlb_page(NULL, vaddr);
+#define arch_kmap_local_post_unmap(vaddr)	\
+	local_flush_tlb_page(NULL, vaddr);
+
 #endif /* __KERNEL__ */
 
 #endif /* _ASM_HIGHMEM_H */
diff --git a/arch/microblaze/mm/Makefile b/arch/microblaze/mm/Makefile
index 1b16875..8ced711 100644
--- a/arch/microblaze/mm/Makefile
+++ b/arch/microblaze/mm/Makefile
@@ -6,4 +6,3 @@
 obj-y := consistent.o init.o
 
 obj-$(CONFIG_MMU) += pgtable.o mmu_context.o fault.o
-obj-$(CONFIG_HIGHMEM) += highmem.o
diff --git a/arch/microblaze/mm/highmem.c b/arch/microblaze/mm/highmem.c
deleted file mode 100644
index 92e0890..0000000
--- a/arch/microblaze/mm/highmem.c
+++ /dev/null
@@ -1,78 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-/*
- * highmem.c: virtual kernel memory mappings for high memory
- *
- * PowerPC version, stolen from the i386 version.
- *
- * Used in CONFIG_HIGHMEM systems for memory pages which
- * are not addressable by direct kernel virtual addresses.
- *
- * Copyright (C) 1999 Gerhard Wichert, Siemens AG
- *		      Gerhard.Wichert@pdb.siemens.de
- *
- *
- * Redesigned the x86 32-bit VM architecture to deal with
- * up to 16 Terrabyte physical memory. With current x86 CPUs
- * we now support up to 64 Gigabytes physical RAM.
- *
- * Copyright (C) 1999 Ingo Molnar <mingo@redhat.com>
- *
- * Reworked for PowerPC by various contributors. Moved from
- * highmem.h by Benjamin Herrenschmidt (c) 2009 IBM Corp.
- */
-
-#include <linux/export.h>
-#include <linux/highmem.h>
-
-/*
- * The use of kmap_atomic/kunmap_atomic is discouraged - kmap/kunmap
- * gives a more generic (and caching) interface. But kmap_atomic can
- * be used in IRQ contexts, so in some (very limited) cases we need
- * it.
- */
-#include <asm/tlbflush.h>
-
-void *kmap_atomic_high_prot(struct page *page, pgprot_t prot)
-{
-
-	unsigned long vaddr;
-	int idx, type;
-
-	type = kmap_atomic_idx_push();
-	idx = type + KM_TYPE_NR*smp_processor_id();
-	vaddr = __fix_to_virt(FIX_KMAP_BEGIN + idx);
-#ifdef CONFIG_DEBUG_HIGHMEM
-	BUG_ON(!pte_none(*(kmap_pte-idx)));
-#endif
-	set_pte_at(&init_mm, vaddr, kmap_pte-idx, mk_pte(page, prot));
-	local_flush_tlb_page(NULL, vaddr);
-
-	return (void *) vaddr;
-}
-EXPORT_SYMBOL(kmap_atomic_high_prot);
-
-void kunmap_atomic_high(void *kvaddr)
-{
-	unsigned long vaddr = (unsigned long) kvaddr & PAGE_MASK;
-	int type;
-	unsigned int idx;
-
-	if (vaddr < __fix_to_virt(FIX_KMAP_END))
-		return;
-
-	type = kmap_atomic_idx();
-
-	idx = type + KM_TYPE_NR * smp_processor_id();
-#ifdef CONFIG_DEBUG_HIGHMEM
-	BUG_ON(vaddr != __fix_to_virt(FIX_KMAP_BEGIN + idx));
-#endif
-	/*
-	 * force other mappings to Oops if they'll try to access
-	 * this pte without first remap it
-	 */
-	pte_clear(&init_mm, vaddr, kmap_pte-idx);
-	local_flush_tlb_page(NULL, vaddr);
-
-	kmap_atomic_idx_pop();
-}
-EXPORT_SYMBOL(kunmap_atomic_high);
diff --git a/arch/microblaze/mm/init.c b/arch/microblaze/mm/init.c
index 45da639..1f4b5b3 100644
--- a/arch/microblaze/mm/init.c
+++ b/arch/microblaze/mm/init.c
@@ -49,17 +49,11 @@ unsigned long lowmem_size;
 EXPORT_SYMBOL(min_low_pfn);
 EXPORT_SYMBOL(max_low_pfn);
 
-#ifdef CONFIG_HIGHMEM
-pte_t *kmap_pte;
-EXPORT_SYMBOL(kmap_pte);
-
 static void __init highmem_init(void)
 {
 	pr_debug("%x\n", (u32)PKMAP_BASE);
 	map_page(PKMAP_BASE, 0, 0);	/* XXX gross */
 	pkmap_page_table = virt_to_kpte(PKMAP_BASE);
-
-	kmap_pte = virt_to_kpte(__fix_to_virt(FIX_KMAP_BEGIN));
 }
 
 static void highmem_setup(void)
