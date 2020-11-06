Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B0DFE2AA131
	for <lists+linux-tip-commits@lfdr.de>; Sat,  7 Nov 2020 00:29:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728467AbgKFX2Z (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 6 Nov 2020 18:28:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728766AbgKFX1T (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 6 Nov 2020 18:27:19 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7E5DC0613D2;
        Fri,  6 Nov 2020 15:27:18 -0800 (PST)
Date:   Fri, 06 Nov 2020 23:27:15 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1604705236;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=A3c7xZYKcDBBuEYCbcy/I8EkeAqDDDJ4YqMNPrPa2Pc=;
        b=uFMo5g0VKXUDHerdjUSaBy8z30kF0jttUm1V7G/MgE6a5z+/9GOusnsHe2YYx4J6LerCY1
        r4xFsDEKJQQbxWSboPYMN9e6yhNSXmT/FnnQwbZQ+bvzPZHdoib5KZHEenosH+LeQrEjZN
        B3MKyda+YM+19jdY08j+Xmg+Pq+rxb3aLIRnfc1DFVQ23Rq2qVlNT00gORvQijXqeUEt4U
        KcZydht9O2pEVWYXi60MFsQEBnlXj95n2YaYXaO5Ud7cbjsxyOT2pe3QutNvoe/eKE08wk
        RVvc3fTlINaQcQZGLMPBJzrowF+IjoMd67EYtVwrT6fJvq8MwnSk/elYbNtXig==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1604705236;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=A3c7xZYKcDBBuEYCbcy/I8EkeAqDDDJ4YqMNPrPa2Pc=;
        b=UOvcS0Tn1dqvKjGElidY6leU1dnWDNtK/0zhMVOJPbkqd3aXsgC/6hinM8rYyY3zsIbXyu
        ayQaGkXkPXviMhDw==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/mm] xtensa/mm/highmem: Switch to generic kmap atomic
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Chris Zankel <chris@zankel.net>,
        Max Filippov <jcmvbkbc@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20201103095858.311016780@linutronix.de>
References: <20201103095858.311016780@linutronix.de>
MIME-Version: 1.0
Message-ID: <160470523536.397.1851057157130212276.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the core/mm branch of tip:

Commit-ID:     629ed3f7dad2a914b3a89fad49b358e363e3e6d1
Gitweb:        https://git.kernel.org/tip/629ed3f7dad2a914b3a89fad49b358e363e3e6d1
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Tue, 03 Nov 2020 10:27:29 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Fri, 06 Nov 2020 23:14:57 +01:00

xtensa/mm/highmem: Switch to generic kmap atomic

No reason having the same code in every architecture

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Chris Zankel <chris@zankel.net>
Cc: Max Filippov <jcmvbkbc@gmail.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Link: https://lore.kernel.org/r/20201103095858.311016780@linutronix.de

---
 arch/xtensa/Kconfig               |  1 +-
 arch/xtensa/include/asm/fixmap.h  |  4 +--
 arch/xtensa/include/asm/highmem.h | 12 ++++++--
 arch/xtensa/mm/highmem.c          | 46 +++---------------------------
 4 files changed, 18 insertions(+), 45 deletions(-)

diff --git a/arch/xtensa/Kconfig b/arch/xtensa/Kconfig
index d0dfa50..dc22ef3 100644
--- a/arch/xtensa/Kconfig
+++ b/arch/xtensa/Kconfig
@@ -666,6 +666,7 @@ endchoice
 config HIGHMEM
 	bool "High Memory Support"
 	depends on MMU
+	select KMAP_LOCAL
 	help
 	  Linux can use the full amount of RAM in the system by
 	  default. However, the default MMUv2 setup only maps the
diff --git a/arch/xtensa/include/asm/fixmap.h b/arch/xtensa/include/asm/fixmap.h
index a06ffb0..92049b6 100644
--- a/arch/xtensa/include/asm/fixmap.h
+++ b/arch/xtensa/include/asm/fixmap.h
@@ -16,7 +16,7 @@
 #ifdef CONFIG_HIGHMEM
 #include <linux/threads.h>
 #include <linux/pgtable.h>
-#include <asm/kmap_types.h>
+#include <asm/kmap_size.h>
 #endif
 
 /*
@@ -39,7 +39,7 @@ enum fixed_addresses {
 	/* reserved pte's for temporary kernel mappings */
 	FIX_KMAP_BEGIN,
 	FIX_KMAP_END = FIX_KMAP_BEGIN +
-		(KM_TYPE_NR * NR_CPUS * DCACHE_N_COLORS) - 1,
+		(KM_MAX_IDX * NR_CPUS * DCACHE_N_COLORS) - 1,
 #endif
 	__end_of_fixed_addresses
 };
diff --git a/arch/xtensa/include/asm/highmem.h b/arch/xtensa/include/asm/highmem.h
index eac5032..0fc3b1c 100644
--- a/arch/xtensa/include/asm/highmem.h
+++ b/arch/xtensa/include/asm/highmem.h
@@ -16,9 +16,8 @@
 #include <linux/pgtable.h>
 #include <asm/cacheflush.h>
 #include <asm/fixmap.h>
-#include <asm/kmap_types.h>
 
-#define PKMAP_BASE		((FIXADDR_START - \
+#define PKMAP_BASE		((FIXADDR_START -			\
 				  (LAST_PKMAP + 1) * PAGE_SIZE) & PMD_MASK)
 #define LAST_PKMAP		(PTRS_PER_PTE * DCACHE_N_COLORS)
 #define LAST_PKMAP_MASK		(LAST_PKMAP - 1)
@@ -68,6 +67,15 @@ static inline void flush_cache_kmaps(void)
 	flush_cache_all();
 }
 
+enum fixed_addresses kmap_local_map_idx(int type, unsigned long pfn);
+#define arch_kmap_local_map_idx		kmap_local_map_idx
+
+enum fixed_addresses kmap_local_unmap_idx(int type, unsigned long addr);
+#define arch_kmap_local_unmap_idx	kmap_local_unmap_idx
+
+#define arch_kmap_local_post_unmap(vaddr)	\
+	local_flush_tlb_kernel_range(vaddr, vaddr + PAGE_SIZE)
+
 void kmap_init(void);
 
 #endif
diff --git a/arch/xtensa/mm/highmem.c b/arch/xtensa/mm/highmem.c
index 673196f..0735ca5 100644
--- a/arch/xtensa/mm/highmem.c
+++ b/arch/xtensa/mm/highmem.c
@@ -12,8 +12,6 @@
 #include <linux/highmem.h>
 #include <asm/tlbflush.h>
 
-static pte_t *kmap_pte;
-
 #if DCACHE_WAY_SIZE > PAGE_SIZE
 unsigned int last_pkmap_nr_arr[DCACHE_N_COLORS];
 wait_queue_head_t pkmap_map_wait_arr[DCACHE_N_COLORS];
@@ -33,59 +31,25 @@ static inline void kmap_waitqueues_init(void)
 
 static inline enum fixed_addresses kmap_idx(int type, unsigned long color)
 {
-	return (type + KM_TYPE_NR * smp_processor_id()) * DCACHE_N_COLORS +
+	return (type + KM_MAX_IDX * smp_processor_id()) * DCACHE_N_COLORS +
 		color;
 }
 
-void *kmap_atomic_high_prot(struct page *page, pgprot_t prot)
+enum fixed_addresses kmap_local_map_idx(int type, unsigned long pfn)
 {
-	enum fixed_addresses idx;
-	unsigned long vaddr;
-
-	idx = kmap_idx(kmap_atomic_idx_push(),
-		       DCACHE_ALIAS(page_to_phys(page)));
-	vaddr = __fix_to_virt(FIX_KMAP_BEGIN + idx);
-#ifdef CONFIG_DEBUG_HIGHMEM
-	BUG_ON(!pte_none(*(kmap_pte + idx)));
-#endif
-	set_pte(kmap_pte + idx, mk_pte(page, prot));
-
-	return (void *)vaddr;
+	return kmap_idx(type, DCACHE_ALIAS(pfn << PAGE_SHIFT));
 }
-EXPORT_SYMBOL(kmap_atomic_high_prot);
 
-void kunmap_atomic_high(void *kvaddr)
+enum fixed_addresses kmap_local_unmap_idx(int type, unsigned long addr)
 {
-	if (kvaddr >= (void *)FIXADDR_START &&
-	    kvaddr < (void *)FIXADDR_TOP) {
-		int idx = kmap_idx(kmap_atomic_idx(),
-				   DCACHE_ALIAS((unsigned long)kvaddr));
-
-		/*
-		 * Force other mappings to Oops if they'll try to access this
-		 * pte without first remap it.  Keeping stale mappings around
-		 * is a bad idea also, in case the page changes cacheability
-		 * attributes or becomes a protected page in a hypervisor.
-		 */
-		pte_clear(&init_mm, kvaddr, kmap_pte + idx);
-		local_flush_tlb_kernel_range((unsigned long)kvaddr,
-					     (unsigned long)kvaddr + PAGE_SIZE);
-
-		kmap_atomic_idx_pop();
-	}
+	return kmap_idx(type, DCACHE_ALIAS(addr));
 }
-EXPORT_SYMBOL(kunmap_atomic_high);
 
 void __init kmap_init(void)
 {
-	unsigned long kmap_vstart;
-
 	/* Check if this memory layout is broken because PKMAP overlaps
 	 * page table.
 	 */
 	BUILD_BUG_ON(PKMAP_BASE < TLBTEMP_BASE_1 + TLBTEMP_SIZE);
-	/* cache the first kmap pte */
-	kmap_vstart = __fix_to_virt(FIX_KMAP_BEGIN);
-	kmap_pte = virt_to_kpte(kmap_vstart);
 	kmap_waitqueues_init();
 }
