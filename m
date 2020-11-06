Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A1152AA132
	for <lists+linux-tip-commits@lfdr.de>; Sat,  7 Nov 2020 00:29:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728846AbgKFX20 (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 6 Nov 2020 18:28:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728097AbgKFX1T (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 6 Nov 2020 18:27:19 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3A69C0613CF;
        Fri,  6 Nov 2020 15:27:18 -0800 (PST)
Date:   Fri, 06 Nov 2020 23:27:16 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1604705237;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hb+RjdpN7eG5B1lnoMK4WDG9PxEiFfaAV0ar+OaJBDs=;
        b=sBjioe5wZ9AnAw4EIRbvQQQANtnSiR67hz3V3vhcKs1oIB8PVYH1wtvb0/+ZFbjW+DxiAE
        6QoiEbmUCAJhzZCjwRN4a1+rw2JWKQWK3Hrw8Wtkummn4tmG/AFP5xk7MxIdg5EzIVaK34
        wnWuL6MkNgLTJZZekHyIwRc87SyAdoXDzBXHA3rRuZrNjx27Ay04jUK3R8coNVRIH+krTC
        nAE9YNCGTDfs2c2f3Jf8rK/HWiYYHSsRchAtn7p5hNn3WEDR3cokrHdZNIHyGo3Zgj46/P
        wDgR8ZK+rQNsM89C6+Mvf1Lg2CoPuBDpo+e4DHLiuhkiBozTrniHUNaaqqJ1rA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1604705237;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hb+RjdpN7eG5B1lnoMK4WDG9PxEiFfaAV0ar+OaJBDs=;
        b=yQNTFKa1xYsUYDVzK212N7NupmwaCdTEtIIw5T9gDAcfKUyhoMoeQ7vg9Kz9nI2E9o/n+D
        87cXB0BQCZsitIBA==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/mm] sparc/mm/highmem: Switch to generic kmap atomic
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        "David S. Miller" <davem@davemloft.net>,
        Arnd Bergmann <arnd@arndb.de>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20201103095858.197568209@linutronix.de>
References: <20201103095858.197568209@linutronix.de>
MIME-Version: 1.0
Message-ID: <160470523629.397.2932631897329151113.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the core/mm branch of tip:

Commit-ID:     3293efa9780712ad8504689e0c296d2bd33827d5
Gitweb:        https://git.kernel.org/tip/3293efa9780712ad8504689e0c296d2bd33827d5
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Tue, 03 Nov 2020 10:27:28 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Fri, 06 Nov 2020 23:14:57 +01:00

sparc/mm/highmem: Switch to generic kmap atomic

No reason having the same code in every architecture

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Arnd Bergmann <arnd@arndb.de>
Link: https://lore.kernel.org/r/20201103095858.197568209@linutronix.de

---
 arch/sparc/Kconfig                  |   1 +-
 arch/sparc/include/asm/highmem.h    |   8 +-
 arch/sparc/include/asm/kmap_types.h |  11 +---
 arch/sparc/include/asm/vaddrs.h     |   4 +-
 arch/sparc/mm/Makefile              |   3 +-
 arch/sparc/mm/highmem.c             | 115 +---------------------------
 arch/sparc/mm/srmmu.c               |   2 +-
 7 files changed, 8 insertions(+), 136 deletions(-)
 delete mode 100644 arch/sparc/include/asm/kmap_types.h
 delete mode 100644 arch/sparc/mm/highmem.c

diff --git a/arch/sparc/Kconfig b/arch/sparc/Kconfig
index a6ca135..e841708 100644
--- a/arch/sparc/Kconfig
+++ b/arch/sparc/Kconfig
@@ -139,6 +139,7 @@ config MMU
 config HIGHMEM
 	bool
 	default y if SPARC32
+	select KMAP_LOCAL
 
 config ZONE_DMA
 	bool
diff --git a/arch/sparc/include/asm/highmem.h b/arch/sparc/include/asm/highmem.h
index 6c35f0d..8751162 100644
--- a/arch/sparc/include/asm/highmem.h
+++ b/arch/sparc/include/asm/highmem.h
@@ -24,7 +24,6 @@
 #include <linux/interrupt.h>
 #include <linux/pgtable.h>
 #include <asm/vaddrs.h>
-#include <asm/kmap_types.h>
 #include <asm/pgtsrmmu.h>
 
 /* declarations for highmem.c */
@@ -33,8 +32,6 @@ extern unsigned long highstart_pfn, highend_pfn;
 #define kmap_prot __pgprot(SRMMU_ET_PTE | SRMMU_PRIV | SRMMU_CACHE)
 extern pte_t *pkmap_page_table;
 
-void kmap_init(void) __init;
-
 /*
  * Right now we initialize only a single pte table. It can be extended
  * easily, subsequent pte tables have to be allocated in one physical
@@ -53,6 +50,11 @@ void kmap_init(void) __init;
 
 #define flush_cache_kmaps()	flush_cache_all()
 
+/* FIXME: Use __flush_tlb_one(vaddr) instead of flush_cache_all() -- Anton */
+#define arch_kmap_local_post_map(vaddr, pteval)	flush_cache_all()
+#define arch_kmap_local_post_unmap(vaddr)	flush_cache_all()
+
+
 #endif /* __KERNEL__ */
 
 #endif /* _ASM_HIGHMEM_H */
diff --git a/arch/sparc/include/asm/kmap_types.h b/arch/sparc/include/asm/kmap_types.h
deleted file mode 100644
index 55a99b6..0000000
--- a/arch/sparc/include/asm/kmap_types.h
+++ /dev/null
@@ -1,11 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-#ifndef _ASM_KMAP_TYPES_H
-#define _ASM_KMAP_TYPES_H
-
-/* Dummy header just to define km_type.  None of this
- * is actually used on sparc.  -DaveM
- */
-
-#include <asm-generic/kmap_types.h>
-
-#endif
diff --git a/arch/sparc/include/asm/vaddrs.h b/arch/sparc/include/asm/vaddrs.h
index 84d054b..4fec034 100644
--- a/arch/sparc/include/asm/vaddrs.h
+++ b/arch/sparc/include/asm/vaddrs.h
@@ -32,13 +32,13 @@
 #define SRMMU_NOCACHE_ALCRATIO	64	/* 256 pages per 64MB of system RAM */
 
 #ifndef __ASSEMBLY__
-#include <asm/kmap_types.h>
+#include <asm/kmap_size.h>
 
 enum fixed_addresses {
 	FIX_HOLE,
 #ifdef CONFIG_HIGHMEM
 	FIX_KMAP_BEGIN,
-	FIX_KMAP_END = (KM_TYPE_NR * NR_CPUS),
+	FIX_KMAP_END = (KM_MAX_IDX * NR_CPUS),
 #endif
 	__end_of_fixed_addresses
 };
diff --git a/arch/sparc/mm/Makefile b/arch/sparc/mm/Makefile
index b078205..68db1f8 100644
--- a/arch/sparc/mm/Makefile
+++ b/arch/sparc/mm/Makefile
@@ -15,6 +15,3 @@ obj-$(CONFIG_SPARC32)   += leon_mm.o
 
 # Only used by sparc64
 obj-$(CONFIG_HUGETLB_PAGE) += hugetlbpage.o
-
-# Only used by sparc32
-obj-$(CONFIG_HIGHMEM)   += highmem.o
diff --git a/arch/sparc/mm/highmem.c b/arch/sparc/mm/highmem.c
deleted file mode 100644
index 8f2a2af..0000000
--- a/arch/sparc/mm/highmem.c
+++ /dev/null
@@ -1,115 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-/*
- *  highmem.c: virtual kernel memory mappings for high memory
- *
- *  Provides kernel-static versions of atomic kmap functions originally
- *  found as inlines in include/asm-sparc/highmem.h.  These became
- *  needed as kmap_atomic() and kunmap_atomic() started getting
- *  called from within modules.
- *  -- Tomas Szepe <szepe@pinerecords.com>, September 2002
- *
- *  But kmap_atomic() and kunmap_atomic() cannot be inlined in
- *  modules because they are loaded with btfixup-ped functions.
- */
-
-/*
- * The use of kmap_atomic/kunmap_atomic is discouraged - kmap/kunmap
- * gives a more generic (and caching) interface. But kmap_atomic can
- * be used in IRQ contexts, so in some (very limited) cases we need it.
- *
- * XXX This is an old text. Actually, it's good to use atomic kmaps,
- * provided you remember that they are atomic and not try to sleep
- * with a kmap taken, much like a spinlock. Non-atomic kmaps are
- * shared by CPUs, and so precious, and establishing them requires IPI.
- * Atomic kmaps are lightweight and we may have NCPUS more of them.
- */
-#include <linux/highmem.h>
-#include <linux/export.h>
-#include <linux/mm.h>
-
-#include <asm/cacheflush.h>
-#include <asm/tlbflush.h>
-#include <asm/vaddrs.h>
-
-static pte_t *kmap_pte;
-
-void __init kmap_init(void)
-{
-	unsigned long address = __fix_to_virt(FIX_KMAP_BEGIN);
-
-        /* cache the first kmap pte */
-        kmap_pte = virt_to_kpte(address);
-}
-
-void *kmap_atomic_high_prot(struct page *page, pgprot_t prot)
-{
-	unsigned long vaddr;
-	long idx, type;
-
-	type = kmap_atomic_idx_push();
-	idx = type + KM_TYPE_NR*smp_processor_id();
-	vaddr = __fix_to_virt(FIX_KMAP_BEGIN + idx);
-
-/* XXX Fix - Anton */
-#if 0
-	__flush_cache_one(vaddr);
-#else
-	flush_cache_all();
-#endif
-
-#ifdef CONFIG_DEBUG_HIGHMEM
-	BUG_ON(!pte_none(*(kmap_pte-idx)));
-#endif
-	set_pte(kmap_pte-idx, mk_pte(page, prot));
-/* XXX Fix - Anton */
-#if 0
-	__flush_tlb_one(vaddr);
-#else
-	flush_tlb_all();
-#endif
-
-	return (void*) vaddr;
-}
-EXPORT_SYMBOL(kmap_atomic_high_prot);
-
-void kunmap_atomic_high(void *kvaddr)
-{
-	unsigned long vaddr = (unsigned long) kvaddr & PAGE_MASK;
-	int type;
-
-	if (vaddr < FIXADDR_START)
-		return;
-
-	type = kmap_atomic_idx();
-
-#ifdef CONFIG_DEBUG_HIGHMEM
-	{
-		unsigned long idx;
-
-		idx = type + KM_TYPE_NR * smp_processor_id();
-		BUG_ON(vaddr != __fix_to_virt(FIX_KMAP_BEGIN+idx));
-
-		/* XXX Fix - Anton */
-#if 0
-		__flush_cache_one(vaddr);
-#else
-		flush_cache_all();
-#endif
-
-		/*
-		 * force other mappings to Oops if they'll try to access
-		 * this pte without first remap it
-		 */
-		pte_clear(&init_mm, vaddr, kmap_pte-idx);
-		/* XXX Fix - Anton */
-#if 0
-		__flush_tlb_one(vaddr);
-#else
-		flush_tlb_all();
-#endif
-	}
-#endif
-
-	kmap_atomic_idx_pop();
-}
-EXPORT_SYMBOL(kunmap_atomic_high);
diff --git a/arch/sparc/mm/srmmu.c b/arch/sparc/mm/srmmu.c
index 0070f8b..a03caa5 100644
--- a/arch/sparc/mm/srmmu.c
+++ b/arch/sparc/mm/srmmu.c
@@ -971,8 +971,6 @@ void __init srmmu_paging_init(void)
 
 	sparc_context_init(num_contexts);
 
-	kmap_init();
-
 	{
 		unsigned long max_zone_pfn[MAX_NR_ZONES] = { 0 };
 
