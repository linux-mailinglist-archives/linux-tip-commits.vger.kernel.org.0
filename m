Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5773D2AA111
	for <lists+linux-tip-commits@lfdr.de>; Sat,  7 Nov 2020 00:27:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728998AbgKFX12 (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 6 Nov 2020 18:27:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728979AbgKFX1Z (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 6 Nov 2020 18:27:25 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57104C0613D4;
        Fri,  6 Nov 2020 15:27:25 -0800 (PST)
Date:   Fri, 06 Nov 2020 23:27:22 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1604705243;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RAdRc7byIJTRsG+HQPs+UrFY88ddRM51WOl0zg01gPI=;
        b=Vgy4TVfQZEWyriyGdkTF3m3TezrVPBO9Q91C27N3rTDrwTbjiXMXtmjvSFJp1WE07wsoPk
        iuorKHzaUrqkgpBuoAm1s2YutUoTrydD06BNE18n6zs630bOLO00NAgVgd/BZGik16oWh1
        bzkdYZ0KGx1KdMY3ckmmhENvVLygL3AhO2ITfLfbQs1EsONFkl/XZpT6wi+32Fub4eBlBT
        8h7QrjOc7oR8nK8+Zw9tmSixlQza36g0sZrqfwIgNrFfapOclCRZALcJpF9wCNbMV/VxQp
        dqF82fQr3OG9UVvELlsIH9RUGoyPNjlShQOq26JeVBZBEZG+qqjG09Be6/t3dQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1604705243;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RAdRc7byIJTRsG+HQPs+UrFY88ddRM51WOl0zg01gPI=;
        b=z4szlnYqKUjldY5ZwW1w/rGV+TSIJJ30vn73BxrHzbeeo8zjcx/69OdgiFKeLU6W5rrRCE
        9TjK5NMu7dCB2RAg==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/mm] arc/mm/highmem: Use generic kmap atomic implementation
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Vineet Gupta <vgupta@synopsys.com>,
        Arnd Bergmann <arnd@arndb.de>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20201103095857.472289952@linutronix.de>
References: <20201103095857.472289952@linutronix.de>
MIME-Version: 1.0
Message-ID: <160470524237.397.3894020872111517553.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the core/mm branch of tip:

Commit-ID:     39cac191ff37939544af80d5d2af6b870fd94c9b
Gitweb:        https://git.kernel.org/tip/39cac191ff37939544af80d5d2af6b870fd94c9b
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Tue, 03 Nov 2020 10:27:21 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Fri, 06 Nov 2020 23:14:55 +01:00

arc/mm/highmem: Use generic kmap atomic implementation

Adopt the map ordering to match the other architectures and the generic
code. Also make the maximum entries limited and not dependend on the number
of CPUs. With the original implementation did the following calculation:

   nr_slots = mapsize >> PAGE_SHIFT;

The results in either 512 or 1024 total slots depending on
configuration. The total slots have to be divided by the number of CPUs to
get the number of slots per CPU (former KM_TYPE_NR). ARC supports up to 4k
CPUs, so this just falls apart in random ways depending on the number of
CPUs and the actual kmap (atomic) nesting. The comment in highmem.c:

 * - fixmap anyhow needs a limited number of mappings. So 2M kvaddr == 256 PTE
 *   slots across NR_CPUS would be more than sufficient (generic code defines
 *   KM_TYPE_NR as 20).

is just wrong. KM_TYPE_NR (now KM_MAX_IDX) is the number of slots per CPU
because kmap_local/atomic() needs to support nested mappings (thread,
softirq, interrupt). While KM_MAX_IDX might be overestimated, the above
reasoning is just wrong and clearly the highmem code was never tested with
any system with more than a few CPUs.

Use the default number of slots and fail the build when it does not
fit. Randomly failing at runtime is not a really good option.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Vineet Gupta <vgupta@synopsys.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Link: https://lore.kernel.org/r/20201103095857.472289952@linutronix.de

---
 arch/arc/Kconfig                  |  1 +-
 arch/arc/include/asm/highmem.h    | 26 ++++++++++----
 arch/arc/include/asm/kmap_types.h | 14 +--------
 arch/arc/mm/highmem.c             | 54 ++----------------------------
 4 files changed, 26 insertions(+), 69 deletions(-)
 delete mode 100644 arch/arc/include/asm/kmap_types.h

diff --git a/arch/arc/Kconfig b/arch/arc/Kconfig
index 0a89cc9..d880400 100644
--- a/arch/arc/Kconfig
+++ b/arch/arc/Kconfig
@@ -507,6 +507,7 @@ config LINUX_RAM_BASE
 config HIGHMEM
 	bool "High Memory Support"
 	select ARCH_DISCONTIGMEM_ENABLE
+	select KMAP_LOCAL
 	help
 	  With ARC 2G:2G address split, only upper 2G is directly addressable by
 	  kernel. Enable this to potentially allow access to rest of 2G and PAE
diff --git a/arch/arc/include/asm/highmem.h b/arch/arc/include/asm/highmem.h
index 6e5eafb..a6b8e2c 100644
--- a/arch/arc/include/asm/highmem.h
+++ b/arch/arc/include/asm/highmem.h
@@ -9,17 +9,29 @@
 #ifdef CONFIG_HIGHMEM
 
 #include <uapi/asm/page.h>
-#include <asm/kmap_types.h>
+#include <asm/kmap_size.h>
+
+#define FIXMAP_SIZE		PGDIR_SIZE
+#define PKMAP_SIZE		PGDIR_SIZE
 
 /* start after vmalloc area */
 #define FIXMAP_BASE		(PAGE_OFFSET - FIXMAP_SIZE - PKMAP_SIZE)
-#define FIXMAP_SIZE		PGDIR_SIZE	/* only 1 PGD worth */
-#define KM_TYPE_NR		((FIXMAP_SIZE >> PAGE_SHIFT)/NR_CPUS)
-#define FIXMAP_ADDR(nr)		(FIXMAP_BASE + ((nr) << PAGE_SHIFT))
+
+#define FIX_KMAP_SLOTS		(KM_MAX_IDX * NR_CPUS)
+#define FIX_KMAP_BEGIN		(0UL)
+#define FIX_KMAP_END		((FIX_KMAP_BEGIN + FIX_KMAP_SLOTS) - 1)
+
+#define FIXADDR_TOP		(FIXMAP_BASE + (FIX_KMAP_END << PAGE_SHIFT))
+
+/*
+ * This should be converted to the asm-generic version, but of course this
+ * is needlessly different from all other architectures. Sigh - tglx
+ */
+#define __fix_to_virt(x)	(FIXADDR_TOP - ((x) << PAGE_SHIFT))
+#define __virt_to_fix(x)	(((FIXADDR_TOP - ((x) & PAGE_MASK))) >> PAGE_SHIFT)
 
 /* start after fixmap area */
 #define PKMAP_BASE		(FIXMAP_BASE + FIXMAP_SIZE)
-#define PKMAP_SIZE		PGDIR_SIZE
 #define LAST_PKMAP		(PKMAP_SIZE >> PAGE_SHIFT)
 #define LAST_PKMAP_MASK		(LAST_PKMAP - 1)
 #define PKMAP_ADDR(nr)		(PKMAP_BASE + ((nr) << PAGE_SHIFT))
@@ -29,11 +41,13 @@
 
 extern void kmap_init(void);
 
+#define arch_kmap_local_post_unmap(vaddr)			\
+	local_flush_tlb_kernel_range(vaddr, vaddr + PAGE_SIZE)
+
 static inline void flush_cache_kmaps(void)
 {
 	flush_cache_all();
 }
-
 #endif
 
 #endif
diff --git a/arch/arc/include/asm/kmap_types.h b/arch/arc/include/asm/kmap_types.h
deleted file mode 100644
index fecf785..0000000
--- a/arch/arc/include/asm/kmap_types.h
+++ /dev/null
@@ -1,14 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0-only */
-/*
- * Copyright (C) 2015 Synopsys, Inc. (www.synopsys.com)
- */
-
-#ifndef _ASM_KMAP_TYPES_H
-#define _ASM_KMAP_TYPES_H
-
-/*
- * We primarily need to define KM_TYPE_NR here but that in turn
- * is a function of PGDIR_SIZE etc.
- * To avoid circular deps issue, put everything in asm/highmem.h
- */
-#endif
diff --git a/arch/arc/mm/highmem.c b/arch/arc/mm/highmem.c
index 1b9f473..c79912a 100644
--- a/arch/arc/mm/highmem.c
+++ b/arch/arc/mm/highmem.c
@@ -36,9 +36,8 @@
  *   This means each only has 1 PGDIR_SIZE worth of kvaddr mappings, which means
  *   2M of kvaddr space for typical config (8K page and 11:8:13 traversal split)
  *
- * - fixmap anyhow needs a limited number of mappings. So 2M kvaddr == 256 PTE
- *   slots across NR_CPUS would be more than sufficient (generic code defines
- *   KM_TYPE_NR as 20).
+ * - The fixed KMAP slots for kmap_local/atomic() require KM_MAX_IDX slots per
+ *   CPU. So the number of CPUs sharing a single PTE page is limited.
  *
  * - pkmap being preemptible, in theory could do with more than 256 concurrent
  *   mappings. However, generic pkmap code: map_new_virtual(), doesn't traverse
@@ -47,48 +46,6 @@
  */
 
 extern pte_t * pkmap_page_table;
-static pte_t * fixmap_page_table;
-
-void *kmap_atomic_high_prot(struct page *page, pgprot_t prot)
-{
-	int idx, cpu_idx;
-	unsigned long vaddr;
-
-	cpu_idx = kmap_atomic_idx_push();
-	idx = cpu_idx + KM_TYPE_NR * smp_processor_id();
-	vaddr = FIXMAP_ADDR(idx);
-
-	set_pte_at(&init_mm, vaddr, fixmap_page_table + idx,
-		   mk_pte(page, prot));
-
-	return (void *)vaddr;
-}
-EXPORT_SYMBOL(kmap_atomic_high_prot);
-
-void kunmap_atomic_high(void *kv)
-{
-	unsigned long kvaddr = (unsigned long)kv;
-
-	if (kvaddr >= FIXMAP_BASE && kvaddr < (FIXMAP_BASE + FIXMAP_SIZE)) {
-
-		/*
-		 * Because preemption is disabled, this vaddr can be associated
-		 * with the current allocated index.
-		 * But in case of multiple live kmap_atomic(), it still relies on
-		 * callers to unmap in right order.
-		 */
-		int cpu_idx = kmap_atomic_idx();
-		int idx = cpu_idx + KM_TYPE_NR * smp_processor_id();
-
-		WARN_ON(kvaddr != FIXMAP_ADDR(idx));
-
-		pte_clear(&init_mm, kvaddr, fixmap_page_table + idx);
-		local_flush_tlb_kernel_range(kvaddr, kvaddr + PAGE_SIZE);
-
-		kmap_atomic_idx_pop();
-	}
-}
-EXPORT_SYMBOL(kunmap_atomic_high);
 
 static noinline pte_t * __init alloc_kmap_pgtable(unsigned long kvaddr)
 {
@@ -108,10 +65,9 @@ void __init kmap_init(void)
 {
 	/* Due to recursive include hell, we can't do this in processor.h */
 	BUILD_BUG_ON(PAGE_OFFSET < (VMALLOC_END + FIXMAP_SIZE + PKMAP_SIZE));
+	BUILD_BUG_ON(LAST_PKMAP > PTRS_PER_PTE);
+	BUILD_BUG_ON(FIX_KMAP_SLOTS > PTRS_PER_PTE);
 
-	BUILD_BUG_ON(KM_TYPE_NR > PTRS_PER_PTE);
 	pkmap_page_table = alloc_kmap_pgtable(PKMAP_BASE);
-
-	BUILD_BUG_ON(LAST_PKMAP > PTRS_PER_PTE);
-	fixmap_page_table = alloc_kmap_pgtable(FIXMAP_BASE);
+	alloc_kmap_pgtable(FIXMAP_BASE);
 }
