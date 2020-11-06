Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F37CB2AA12B
	for <lists+linux-tip-commits@lfdr.de>; Sat,  7 Nov 2020 00:28:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729130AbgKFX14 (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 6 Nov 2020 18:27:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728931AbgKFX1W (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 6 Nov 2020 18:27:22 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F0A8C0613CF;
        Fri,  6 Nov 2020 15:27:22 -0800 (PST)
Date:   Fri, 06 Nov 2020 23:27:19 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1604705240;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yDy0wzJK3bFvSvXl6PlM57XrIP+eM95n0JTIsG0gbbY=;
        b=LwTvj9T7Jr/8naIudOkdAo14FBDX4H6kAuRHCRJ4eJZ0PUTWL069ZFe3LZujK/k/qzUci5
        mInAvU8ylhPD/jJ0oFg7mP5/GDMxfWktqUJhh2KSEMhQw6YCrb6sehNWe5dzrAl1ud4bio
        ZfVCAME4l+hRuyak52mMN3OWax67rxZhLpFM8pZ5y/rh8B3b6UE6JnyX+vP9W8DwhlLzVa
        kSRt6S3HWygwzj6v2uNgpUFGlW1pB3WufG+3gL11wyi8q9iqGvAWaKWUQsPbKlqJ/E0mlM
        Mojhu6BTGa23+6J9P89LbiuZzWm5xnqt6uPaWUMT18K5zqsiI5EJDQO4lzvWbQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1604705240;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yDy0wzJK3bFvSvXl6PlM57XrIP+eM95n0JTIsG0gbbY=;
        b=VWDZ/D8YpwyNkcqX9nDWtKO267g7Vd1jFQb2ntkCQcXk9Nef0smSuwhLCZBHqBL269EOlV
        RbfxA5m1vnNBUPBA==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/mm] mips/mm/highmem: Switch to generic kmap atomic
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Arnd Bergmann <arnd@arndb.de>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20201103095857.885321106@linutronix.de>
References: <20201103095857.885321106@linutronix.de>
MIME-Version: 1.0
Message-ID: <160470523906.397.15684090348252899282.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the core/mm branch of tip:

Commit-ID:     a4c33e83bca133ff979e13c784c7605e1ac143df
Gitweb:        https://git.kernel.org/tip/a4c33e83bca133ff979e13c784c7605e1ac143df
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Tue, 03 Nov 2020 10:27:25 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Fri, 06 Nov 2020 23:14:56 +01:00

mips/mm/highmem: Switch to generic kmap atomic

No reason having the same code in every architecture

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc: Arnd Bergmann <arnd@arndb.de>
Link: https://lore.kernel.org/r/20201103095857.885321106@linutronix.de

---
 arch/mips/Kconfig                  |  1 +-
 arch/mips/include/asm/fixmap.h     |  4 +-
 arch/mips/include/asm/highmem.h    |  6 +-
 arch/mips/include/asm/kmap_types.h | 13 +-----
 arch/mips/mm/highmem.c             | 77 +-----------------------------
 arch/mips/mm/init.c                |  4 +--
 6 files changed, 6 insertions(+), 99 deletions(-)
 delete mode 100644 arch/mips/include/asm/kmap_types.h

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index 2000bb2..6b762be 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -2719,6 +2719,7 @@ config WAR_MIPS34K_MISSED_ITLB
 config HIGHMEM
 	bool "High Memory Support"
 	depends on 32BIT && CPU_SUPPORTS_HIGHMEM && SYS_SUPPORTS_HIGHMEM && !CPU_MIPS32_3_5_EVA
+	select KMAP_LOCAL
 
 config CPU_SUPPORTS_HIGHMEM
 	bool
diff --git a/arch/mips/include/asm/fixmap.h b/arch/mips/include/asm/fixmap.h
index 743535b..beea147 100644
--- a/arch/mips/include/asm/fixmap.h
+++ b/arch/mips/include/asm/fixmap.h
@@ -17,7 +17,7 @@
 #include <spaces.h>
 #ifdef CONFIG_HIGHMEM
 #include <linux/threads.h>
-#include <asm/kmap_types.h>
+#include <asm/kmap_size.h>
 #endif
 
 /*
@@ -52,7 +52,7 @@ enum fixed_addresses {
 #ifdef CONFIG_HIGHMEM
 	/* reserved pte's for temporary kernel mappings */
 	FIX_KMAP_BEGIN = FIX_CMAP_END + 1,
-	FIX_KMAP_END = FIX_KMAP_BEGIN+(KM_TYPE_NR*NR_CPUS)-1,
+	FIX_KMAP_END = FIX_KMAP_BEGIN + (KM_MAX_IDX * NR_CPUS) - 1,
 #endif
 	__end_of_fixed_addresses
 };
diff --git a/arch/mips/include/asm/highmem.h b/arch/mips/include/asm/highmem.h
index f1f788b..19edf8e 100644
--- a/arch/mips/include/asm/highmem.h
+++ b/arch/mips/include/asm/highmem.h
@@ -24,7 +24,7 @@
 #include <linux/interrupt.h>
 #include <linux/uaccess.h>
 #include <asm/cpu-features.h>
-#include <asm/kmap_types.h>
+#include <asm/kmap_size.h>
 
 /* declarations for highmem.c */
 extern unsigned long highstart_pfn, highend_pfn;
@@ -48,11 +48,11 @@ extern pte_t *pkmap_page_table;
 
 #define ARCH_HAS_KMAP_FLUSH_TLB
 extern void kmap_flush_tlb(unsigned long addr);
-extern void *kmap_atomic_pfn(unsigned long pfn);
 
 #define flush_cache_kmaps()	BUG_ON(cpu_has_dc_aliases)
 
-extern void kmap_init(void);
+#define arch_kmap_local_post_map(vaddr, pteval)	local_flush_tlb_one(vaddr)
+#define arch_kmap_local_post_unmap(vaddr)	local_flush_tlb_one(vaddr)
 
 #endif /* __KERNEL__ */
 
diff --git a/arch/mips/include/asm/kmap_types.h b/arch/mips/include/asm/kmap_types.h
deleted file mode 100644
index 16665dc..0000000
--- a/arch/mips/include/asm/kmap_types.h
+++ /dev/null
@@ -1,13 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-#ifndef _ASM_KMAP_TYPES_H
-#define _ASM_KMAP_TYPES_H
-
-#ifdef CONFIG_DEBUG_HIGHMEM
-#define	 __WITH_KM_FENCE
-#endif
-
-#include <asm-generic/kmap_types.h>
-
-#undef __WITH_KM_FENCE
-
-#endif
diff --git a/arch/mips/mm/highmem.c b/arch/mips/mm/highmem.c
index 5fec7f4..57e2f08 100644
--- a/arch/mips/mm/highmem.c
+++ b/arch/mips/mm/highmem.c
@@ -8,8 +8,6 @@
 #include <asm/fixmap.h>
 #include <asm/tlbflush.h>
 
-static pte_t *kmap_pte;
-
 unsigned long highstart_pfn, highend_pfn;
 
 void kmap_flush_tlb(unsigned long addr)
@@ -17,78 +15,3 @@ void kmap_flush_tlb(unsigned long addr)
 	flush_tlb_one(addr);
 }
 EXPORT_SYMBOL(kmap_flush_tlb);
-
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
-	local_flush_tlb_one((unsigned long)vaddr);
-
-	return (void*) vaddr;
-}
-EXPORT_SYMBOL(kmap_atomic_high_prot);
-
-void kunmap_atomic_high(void *kvaddr)
-{
-	unsigned long vaddr = (unsigned long) kvaddr & PAGE_MASK;
-	int type __maybe_unused;
-
-	if (vaddr < FIXADDR_START)
-		return;
-
-	type = kmap_atomic_idx();
-#ifdef CONFIG_DEBUG_HIGHMEM
-	{
-		int idx = type + KM_TYPE_NR * smp_processor_id();
-
-		BUG_ON(vaddr != __fix_to_virt(FIX_KMAP_BEGIN + idx));
-
-		/*
-		 * force other mappings to Oops if they'll try to access
-		 * this pte without first remap it
-		 */
-		pte_clear(&init_mm, vaddr, kmap_pte-idx);
-		local_flush_tlb_one(vaddr);
-	}
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
-	preempt_disable();
-	pagefault_disable();
-
-	type = kmap_atomic_idx_push();
-	idx = type + KM_TYPE_NR*smp_processor_id();
-	vaddr = __fix_to_virt(FIX_KMAP_BEGIN + idx);
-	set_pte(kmap_pte-idx, pfn_pte(pfn, PAGE_KERNEL));
-	flush_tlb_one(vaddr);
-
-	return (void*) vaddr;
-}
-
-void __init kmap_init(void)
-{
-	unsigned long kmap_vstart;
-
-	/* cache the first kmap pte */
-	kmap_vstart = __fix_to_virt(FIX_KMAP_BEGIN);
-	kmap_pte = virt_to_kpte(kmap_vstart);
-}
diff --git a/arch/mips/mm/init.c b/arch/mips/mm/init.c
index 07e84a7..bc80893 100644
--- a/arch/mips/mm/init.c
+++ b/arch/mips/mm/init.c
@@ -36,7 +36,6 @@
 #include <asm/cachectl.h>
 #include <asm/cpu.h>
 #include <asm/dma.h>
-#include <asm/kmap_types.h>
 #include <asm/maar.h>
 #include <asm/mmu_context.h>
 #include <asm/sections.h>
@@ -402,9 +401,6 @@ void __init paging_init(void)
 
 	pagetable_init();
 
-#ifdef CONFIG_HIGHMEM
-	kmap_init();
-#endif
 #ifdef CONFIG_ZONE_DMA
 	max_zone_pfns[ZONE_DMA] = MAX_DMA_PFN;
 #endif
