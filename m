Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A63F2AA118
	for <lists+linux-tip-commits@lfdr.de>; Sat,  7 Nov 2020 00:28:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728935AbgKFX1W (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 6 Nov 2020 18:27:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728863AbgKFX1U (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 6 Nov 2020 18:27:20 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F04DC0613CF;
        Fri,  6 Nov 2020 15:27:20 -0800 (PST)
Date:   Fri, 06 Nov 2020 23:27:17 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1604705238;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rnxHn9e/HUpL1L0d077Cb+YuBcH/AUvSXrlDvZiBsv4=;
        b=qsKB8+56eaGgRCvuo5GQ9mZrPG0fI/5AemBJBe7DMnXaO71VvQx6eGwpi53lcDDT69jvhQ
        MFQgg2r+yzjtzALiDu5Rx2FvpHn+HLU0Sd+s5p1M2E2TUdvhB7D6kQzLAxG7gyoW+51Jbl
        A4g3+RX60BxkGtewnBAgUXoAUy78FiAnrCU5qJAqMD52EnaR7Ka0KFWFk9bnzDv0D+mlRG
        NnYul18SB39ByC8rSr9wFWWeMSKNIropeKOgv9iZimbV//tpCKtijPg10iFzEKvLd3Erw4
        f8HnkyB9SywfMmI0usuh0BIZK8NVb/InWBVDVCESlAVUxW3L02YuWYV4wPaMsg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1604705238;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rnxHn9e/HUpL1L0d077Cb+YuBcH/AUvSXrlDvZiBsv4=;
        b=9bB0iN9s9BnSzBYFrZHMHyLjU3xBZrOsEM+GQtvNQBuv7qVu/XsYgdXeQ8DKa0SvUoVBnZ
        qxZgJSh9KRhOoIAg==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/mm] powerpc/mm/highmem: Switch to generic kmap atomic
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Arnd Bergmann <arnd@arndb.de>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20201103095858.087635810@linutronix.de>
References: <20201103095858.087635810@linutronix.de>
MIME-Version: 1.0
Message-ID: <160470523719.397.13971786303774203554.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the core/mm branch of tip:

Commit-ID:     47da42b27a56f3ee5abace2858b69e277703f707
Gitweb:        https://git.kernel.org/tip/47da42b27a56f3ee5abace2858b69e277703f707
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Tue, 03 Nov 2020 10:27:27 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Fri, 06 Nov 2020 23:14:57 +01:00

powerpc/mm/highmem: Switch to generic kmap atomic

No reason having the same code in every architecture

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>
Cc: Arnd Bergmann <arnd@arndb.de>
Link: https://lore.kernel.org/r/20201103095858.087635810@linutronix.de

---
 arch/powerpc/Kconfig                  |  1 +-
 arch/powerpc/include/asm/fixmap.h     |  4 +-
 arch/powerpc/include/asm/highmem.h    |  7 ++-
 arch/powerpc/include/asm/kmap_types.h | 13 +-----
 arch/powerpc/mm/Makefile              |  1 +-
 arch/powerpc/mm/highmem.c             | 67 +--------------------------
 arch/powerpc/mm/mem.c                 |  7 +---
 7 files changed, 8 insertions(+), 92 deletions(-)
 delete mode 100644 arch/powerpc/include/asm/kmap_types.h
 delete mode 100644 arch/powerpc/mm/highmem.c

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index e9f13fe..d4cfddc 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -409,6 +409,7 @@ menu "Kernel options"
 config HIGHMEM
 	bool "High memory support"
 	depends on PPC32
+	select KMAP_LOCAL
 
 source "kernel/Kconfig.hz"
 
diff --git a/arch/powerpc/include/asm/fixmap.h b/arch/powerpc/include/asm/fixmap.h
index 6bfc879..8d03c16 100644
--- a/arch/powerpc/include/asm/fixmap.h
+++ b/arch/powerpc/include/asm/fixmap.h
@@ -20,7 +20,7 @@
 #include <asm/page.h>
 #ifdef CONFIG_HIGHMEM
 #include <linux/threads.h>
-#include <asm/kmap_types.h>
+#include <asm/kmap_size.h>
 #endif
 
 #ifdef CONFIG_KASAN
@@ -55,7 +55,7 @@ enum fixed_addresses {
 	FIX_EARLY_DEBUG_BASE = FIX_EARLY_DEBUG_TOP+(ALIGN(SZ_128K, PAGE_SIZE)/PAGE_SIZE)-1,
 #ifdef CONFIG_HIGHMEM
 	FIX_KMAP_BEGIN,	/* reserved pte's for temporary kernel mappings */
-	FIX_KMAP_END = FIX_KMAP_BEGIN+(KM_TYPE_NR*NR_CPUS)-1,
+	FIX_KMAP_END = FIX_KMAP_BEGIN + (KM_MAX_IDX * NR_CPUS) - 1,
 #endif
 #ifdef CONFIG_PPC_8xx
 	/* For IMMR we need an aligned 512K area */
diff --git a/arch/powerpc/include/asm/highmem.h b/arch/powerpc/include/asm/highmem.h
index 104026f..80a5ae7 100644
--- a/arch/powerpc/include/asm/highmem.h
+++ b/arch/powerpc/include/asm/highmem.h
@@ -24,12 +24,10 @@
 #ifdef __KERNEL__
 
 #include <linux/interrupt.h>
-#include <asm/kmap_types.h>
 #include <asm/cacheflush.h>
 #include <asm/page.h>
 #include <asm/fixmap.h>
 
-extern pte_t *kmap_pte;
 extern pte_t *pkmap_page_table;
 
 /*
@@ -60,6 +58,11 @@ extern pte_t *pkmap_page_table;
 
 #define flush_cache_kmaps()	flush_cache_all()
 
+#define arch_kmap_local_post_map(vaddr, pteval)	\
+	local_flush_tlb_page(NULL, vaddr)
+#define arch_kmap_local_post_unmap(vaddr)	\
+	local_flush_tlb_page(NULL, vaddr)
+
 #endif /* __KERNEL__ */
 
 #endif /* _ASM_HIGHMEM_H */
diff --git a/arch/powerpc/include/asm/kmap_types.h b/arch/powerpc/include/asm/kmap_types.h
deleted file mode 100644
index c8fa182..0000000
--- a/arch/powerpc/include/asm/kmap_types.h
+++ /dev/null
@@ -1,13 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0-or-later */
-#ifndef _ASM_POWERPC_KMAP_TYPES_H
-#define _ASM_POWERPC_KMAP_TYPES_H
-
-#ifdef __KERNEL__
-
-/*
- */
-
-#define KM_TYPE_NR 16
-
-#endif	/* __KERNEL__ */
-#endif	/* _ASM_POWERPC_KMAP_TYPES_H */
diff --git a/arch/powerpc/mm/Makefile b/arch/powerpc/mm/Makefile
index 5e14798..1c552b5 100644
--- a/arch/powerpc/mm/Makefile
+++ b/arch/powerpc/mm/Makefile
@@ -16,7 +16,6 @@ obj-$(CONFIG_NEED_MULTIPLE_NODES) += numa.o
 obj-$(CONFIG_PPC_MM_SLICES)	+= slice.o
 obj-$(CONFIG_HUGETLB_PAGE)	+= hugetlbpage.o
 obj-$(CONFIG_NOT_COHERENT_CACHE) += dma-noncoherent.o
-obj-$(CONFIG_HIGHMEM)		+= highmem.o
 obj-$(CONFIG_PPC_COPRO_BASE)	+= copro_fault.o
 obj-$(CONFIG_PPC_PTDUMP)	+= ptdump/
 obj-$(CONFIG_KASAN)		+= kasan/
diff --git a/arch/powerpc/mm/highmem.c b/arch/powerpc/mm/highmem.c
deleted file mode 100644
index 624b443..0000000
--- a/arch/powerpc/mm/highmem.c
+++ /dev/null
@@ -1,67 +0,0 @@
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
-#include <linux/highmem.h>
-#include <linux/module.h>
-
-void *kmap_atomic_high_prot(struct page *page, pgprot_t prot)
-{
-	unsigned long vaddr;
-	int idx, type;
-
-	type = kmap_atomic_idx_push();
-	idx = type + KM_TYPE_NR*smp_processor_id();
-	vaddr = __fix_to_virt(FIX_KMAP_BEGIN + idx);
-	WARN_ON(IS_ENABLED(CONFIG_DEBUG_HIGHMEM) && !pte_none(*(kmap_pte - idx)));
-	__set_pte_at(&init_mm, vaddr, kmap_pte-idx, mk_pte(page, prot), 1);
-	local_flush_tlb_page(NULL, vaddr);
-
-	return (void*) vaddr;
-}
-EXPORT_SYMBOL(kmap_atomic_high_prot);
-
-void kunmap_atomic_high(void *kvaddr)
-{
-	unsigned long vaddr = (unsigned long) kvaddr & PAGE_MASK;
-
-	if (vaddr < __fix_to_virt(FIX_KMAP_END))
-		return;
-
-	if (IS_ENABLED(CONFIG_DEBUG_HIGHMEM)) {
-		int type = kmap_atomic_idx();
-		unsigned int idx;
-
-		idx = type + KM_TYPE_NR * smp_processor_id();
-		WARN_ON(vaddr != __fix_to_virt(FIX_KMAP_BEGIN + idx));
-
-		/*
-		 * force other mappings to Oops if they'll try to access
-		 * this pte without first remap it
-		 */
-		pte_clear(&init_mm, vaddr, kmap_pte-idx);
-		local_flush_tlb_page(NULL, vaddr);
-	}
-
-	kmap_atomic_idx_pop();
-}
-EXPORT_SYMBOL(kunmap_atomic_high);
diff --git a/arch/powerpc/mm/mem.c b/arch/powerpc/mm/mem.c
index 01ec2a2..375a989 100644
--- a/arch/powerpc/mm/mem.c
+++ b/arch/powerpc/mm/mem.c
@@ -61,11 +61,6 @@
 unsigned long long memory_limit;
 bool init_mem_is_free;
 
-#ifdef CONFIG_HIGHMEM
-pte_t *kmap_pte;
-EXPORT_SYMBOL(kmap_pte);
-#endif
-
 pgprot_t phys_mem_access_prot(struct file *file, unsigned long pfn,
 			      unsigned long size, pgprot_t vma_prot)
 {
@@ -235,8 +230,6 @@ void __init paging_init(void)
 
 	map_kernel_page(PKMAP_BASE, 0, __pgprot(0));	/* XXX gross */
 	pkmap_page_table = virt_to_kpte(PKMAP_BASE);
-
-	kmap_pte = virt_to_kpte(__fix_to_virt(FIX_KMAP_BEGIN));
 #endif /* CONFIG_HIGHMEM */
 
 	printk(KERN_DEBUG "Top of RAM: 0x%llx, Total RAM: 0x%llx\n",
