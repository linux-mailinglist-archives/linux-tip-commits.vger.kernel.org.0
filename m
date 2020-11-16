Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 41C0C2B5270
	for <lists+linux-tip-commits@lfdr.de>; Mon, 16 Nov 2020 21:24:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732371AbgKPUYX (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Mon, 16 Nov 2020 15:24:23 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:43464 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726657AbgKPUYW (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Mon, 16 Nov 2020 15:24:22 -0500
Date:   Mon, 16 Nov 2020 20:24:18 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1605558259;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=26EBQuDLqRfJIob62SZ1w327byH5+z8iA8+RsCArhFc=;
        b=quK/hU5EWlIbLZzck0ReJs47B52II3g4eMXncbaKCqH106rDTe5CcU4XHJwb4BdnvqJm37
        VsVr0EWOb00RXHEf8zFvTLooNi0ojgNkhzZbIQ7bbCQQLFqc1c7ZP/a36BGxQZUG1+noJR
        5u2bKlTFha+ASy8Ahsox4V8vchvaj9LLBtXL9kFj5ZeOWBOQt93qxrfdZaZX7fbXQy4oq5
        5VCRf2t8LA7et/Bl+4HXX24zf+A5K6vDbhGbGdA7ABcBv3DnFmwTS7zg9YTfarftoqek95
        mxUKbg66JP5ukm8w3KxCR+RQPLUVsK5pAJGlgBWeU1UqNOJud/5/EPZf35Bd0w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1605558259;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=26EBQuDLqRfJIob62SZ1w327byH5+z8iA8+RsCArhFc=;
        b=PAmYrdu8IJT4WCBYuAKTVHo8B8VF4Zo40Bi12m4Xd4Cennumn/oaRovR2z/2LLpvy8h7Qa
        QM0QvAdrSWbu3WBQ==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/mm] xtensa/mm/highmem: Make generic kmap_atomic() work correctly
Cc:     Max Filippov <jcmvbkbc@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20201116193253.23875-1-jcmvbkbc@gmail.com>
References: <20201116193253.23875-1-jcmvbkbc@gmail.com>
MIME-Version: 1.0
Message-ID: <160555825838.11244.4652932210210243090.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the core/mm branch of tip:

Commit-ID:     1eb0616c2df5b78c301eaa7bd2ee859f43915001
Gitweb:        https://git.kernel.org/tip/1eb0616c2df5b78c301eaa7bd2ee859f43915001
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Mon, 16 Nov 2020 11:32:53 -08:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Mon, 16 Nov 2020 21:19:24 +01:00

xtensa/mm/highmem: Make generic kmap_atomic() work correctly

The conversion to the generic kmap_atomic() implementation missed the fact
that xtensa's fixmap works bottom up while all other implementations work
top down. There is no real reason why xtensa needs to work that way.

Cure it by:

  - Using the generic fix_to_virt()/virt_to_fix() functions which work top
    down
  - Adjusting the mapping defines
  - Using the generic index calculation for the non cache aliasing case
  - Making the cache colour offset reverse so the effective index is correct

While at it, remove the outdated and misleading comment above the fixmap
enum which originates from the initial copy&pasta of this code from i386.

[ Max: Fixed the off by one in the index calculation ]

Fixes: 629ed3f7dad2 ("xtensa/mm/highmem: Switch to generic kmap atomic")
Reported-by: Max Filippov <jcmvbkbc@gmail.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Max Filippov <jcmvbkbc@gmail.com>
Link: https://lore.kernel.org/r/20201116193253.23875-1-jcmvbkbc@gmail.com

---
 arch/xtensa/include/asm/fixmap.h  | 55 +++---------------------------
 arch/xtensa/include/asm/highmem.h | 15 ++++----
 arch/xtensa/mm/highmem.c          | 18 ++++++----
 arch/xtensa/mm/init.c             |  4 +-
 arch/xtensa/mm/mmu.c              |  3 +-
 5 files changed, 31 insertions(+), 64 deletions(-)

diff --git a/arch/xtensa/include/asm/fixmap.h b/arch/xtensa/include/asm/fixmap.h
index 92049b6..1c65dc1 100644
--- a/arch/xtensa/include/asm/fixmap.h
+++ b/arch/xtensa/include/asm/fixmap.h
@@ -17,63 +17,22 @@
 #include <linux/threads.h>
 #include <linux/pgtable.h>
 #include <asm/kmap_size.h>
-#endif
 
-/*
- * Here we define all the compile-time 'special' virtual
- * addresses. The point is to have a constant address at
- * compile time, but to set the physical address only
- * in the boot process. We allocate these special addresses
- * from the start of the consistent memory region upwards.
- * Also this lets us do fail-safe vmalloc(), we
- * can guarantee that these special addresses and
- * vmalloc()-ed addresses never overlap.
- *
- * these 'compile-time allocated' memory buffers are
- * fixed-size 4k pages. (or larger if used with an increment
- * higher than 1) use fixmap_set(idx,phys) to associate
- * physical memory with fixmap indices.
- */
+/* The map slots for temporary mappings via kmap_atomic/local(). */
 enum fixed_addresses {
-#ifdef CONFIG_HIGHMEM
-	/* reserved pte's for temporary kernel mappings */
 	FIX_KMAP_BEGIN,
 	FIX_KMAP_END = FIX_KMAP_BEGIN +
 		(KM_MAX_IDX * NR_CPUS * DCACHE_N_COLORS) - 1,
-#endif
 	__end_of_fixed_addresses
 };
 
-#define FIXADDR_TOP     (XCHAL_KSEG_CACHED_VADDR - PAGE_SIZE)
+#define FIXADDR_END     (XCHAL_KSEG_CACHED_VADDR - PAGE_SIZE)
 #define FIXADDR_SIZE	(__end_of_fixed_addresses << PAGE_SHIFT)
-#define FIXADDR_START	((FIXADDR_TOP - FIXADDR_SIZE) & PMD_MASK)
+/* Enforce that FIXADDR_START is PMD aligned to handle cache aliasing */
+#define FIXADDR_START	((FIXADDR_END - FIXADDR_SIZE) & PMD_MASK)
+#define FIXADDR_TOP	(FIXADDR_START + FIXADDR_SIZE - PAGE_SIZE)
 
-#define __fix_to_virt(x)	(FIXADDR_START + ((x) << PAGE_SHIFT))
-#define __virt_to_fix(x)	(((x) - FIXADDR_START) >> PAGE_SHIFT)
-
-#ifndef __ASSEMBLY__
-/*
- * 'index to address' translation. If anyone tries to use the idx
- * directly without translation, we catch the bug with a NULL-deference
- * kernel oops. Illegal ranges of incoming indices are caught too.
- */
-static __always_inline unsigned long fix_to_virt(const unsigned int idx)
-{
-	/* Check if this memory layout is broken because fixmap overlaps page
-	 * table.
-	 */
-	BUILD_BUG_ON(FIXADDR_START <
-		     TLBTEMP_BASE_1 + TLBTEMP_SIZE);
-	BUILD_BUG_ON(idx >= __end_of_fixed_addresses);
-	return __fix_to_virt(idx);
-}
-
-static inline unsigned long virt_to_fix(const unsigned long vaddr)
-{
-	BUG_ON(vaddr >= FIXADDR_TOP || vaddr < FIXADDR_START);
-	return __virt_to_fix(vaddr);
-}
-
-#endif
+#include <asm-generic/fixmap.h>
 
+#endif /* CONFIG_HIGHMEM */
 #endif
diff --git a/arch/xtensa/include/asm/highmem.h b/arch/xtensa/include/asm/highmem.h
index 0fc3b1c..34b8b62 100644
--- a/arch/xtensa/include/asm/highmem.h
+++ b/arch/xtensa/include/asm/highmem.h
@@ -12,6 +12,7 @@
 #ifndef _XTENSA_HIGHMEM_H
 #define _XTENSA_HIGHMEM_H
 
+#ifdef CONFIG_HIGHMEM
 #include <linux/wait.h>
 #include <linux/pgtable.h>
 #include <asm/cacheflush.h>
@@ -58,6 +59,13 @@ static inline wait_queue_head_t *get_pkmap_wait_queue_head(unsigned int color)
 {
 	return pkmap_map_wait_arr + color;
 }
+
+enum fixed_addresses kmap_local_map_idx(int type, unsigned long pfn);
+#define arch_kmap_local_map_idx		kmap_local_map_idx
+
+enum fixed_addresses kmap_local_unmap_idx(int type, unsigned long addr);
+#define arch_kmap_local_unmap_idx	kmap_local_unmap_idx
+
 #endif
 
 extern pte_t *pkmap_page_table;
@@ -67,15 +75,10 @@ static inline void flush_cache_kmaps(void)
 	flush_cache_all();
 }
 
-enum fixed_addresses kmap_local_map_idx(int type, unsigned long pfn);
-#define arch_kmap_local_map_idx		kmap_local_map_idx
-
-enum fixed_addresses kmap_local_unmap_idx(int type, unsigned long addr);
-#define arch_kmap_local_unmap_idx	kmap_local_unmap_idx
-
 #define arch_kmap_local_post_unmap(vaddr)	\
 	local_flush_tlb_kernel_range(vaddr, vaddr + PAGE_SIZE)
 
 void kmap_init(void);
 
+#endif /* CONFIG_HIGHMEM */
 #endif
diff --git a/arch/xtensa/mm/highmem.c b/arch/xtensa/mm/highmem.c
index 0735ca5..35c4f7d 100644
--- a/arch/xtensa/mm/highmem.c
+++ b/arch/xtensa/mm/highmem.c
@@ -23,16 +23,16 @@ static void __init kmap_waitqueues_init(void)
 	for (i = 0; i < ARRAY_SIZE(pkmap_map_wait_arr); ++i)
 		init_waitqueue_head(pkmap_map_wait_arr + i);
 }
-#else
-static inline void kmap_waitqueues_init(void)
-{
-}
-#endif
 
 static inline enum fixed_addresses kmap_idx(int type, unsigned long color)
 {
-	return (type + KM_MAX_IDX * smp_processor_id()) * DCACHE_N_COLORS +
-		color;
+	int idx = (type + KM_MAX_IDX * smp_processor_id()) * DCACHE_N_COLORS;
+
+	/*
+	 * The fixmap operates top down, so the color offset needs to be
+	 * reverse as well.
+	 */
+	return idx + DCACHE_N_COLORS - 1 - color;
 }
 
 enum fixed_addresses kmap_local_map_idx(int type, unsigned long pfn)
@@ -45,6 +45,10 @@ enum fixed_addresses kmap_local_unmap_idx(int type, unsigned long addr)
 	return kmap_idx(type, DCACHE_ALIAS(addr));
 }
 
+#else
+static inline void kmap_waitqueues_init(void) { }
+#endif
+
 void __init kmap_init(void)
 {
 	/* Check if this memory layout is broken because PKMAP overlaps
diff --git a/arch/xtensa/mm/init.c b/arch/xtensa/mm/init.c
index c6fc83e..0f85666 100644
--- a/arch/xtensa/mm/init.c
+++ b/arch/xtensa/mm/init.c
@@ -147,8 +147,8 @@ void __init mem_init(void)
 #ifdef CONFIG_HIGHMEM
 		PKMAP_BASE, PKMAP_BASE + LAST_PKMAP * PAGE_SIZE,
 		(LAST_PKMAP*PAGE_SIZE) >> 10,
-		FIXADDR_START, FIXADDR_TOP,
-		(FIXADDR_TOP - FIXADDR_START) >> 10,
+		FIXADDR_START, FIXADDR_END,
+		(FIXADDR_END - FIXADDR_START) >> 10,
 #endif
 		PAGE_OFFSET, PAGE_OFFSET +
 		(max_low_pfn - min_low_pfn) * PAGE_SIZE,
diff --git a/arch/xtensa/mm/mmu.c b/arch/xtensa/mm/mmu.c
index fd2193d..7e4d97d 100644
--- a/arch/xtensa/mm/mmu.c
+++ b/arch/xtensa/mm/mmu.c
@@ -52,7 +52,8 @@ static void * __init init_pmd(unsigned long vaddr, unsigned long n_pages)
 
 static void __init fixedrange_init(void)
 {
-	init_pmd(__fix_to_virt(0), __end_of_fixed_addresses);
+	BUILD_BUG_ON(FIXADDR_START < TLBTEMP_BASE_1 + TLBTEMP_SIZE);
+	init_pmd(FIXADDR_START, __end_of_fixed_addresses);
 }
 #endif
 
