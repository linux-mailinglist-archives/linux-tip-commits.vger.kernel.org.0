Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D740C2AA119
	for <lists+linux-tip-commits@lfdr.de>; Sat,  7 Nov 2020 00:28:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728927AbgKFX1W (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 6 Nov 2020 18:27:22 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:38434 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728835AbgKFX1V (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 6 Nov 2020 18:27:21 -0500
Date:   Fri, 06 Nov 2020 23:27:17 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1604705239;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fJF/ePB5oQU5dKSCaB2wayxejAKct+VxE3YxaTCIyPE=;
        b=EbvUpflgdmaasknD6ayjDN2LEz8eejE724yCZiK1aGiyr9SoWQwb2p8TrxeDZ7rWxUjXRf
        hyJyslaeF9mU0p2wpVjC9+4v+nV4mghVkzqz8qr1jIcrh0K2zd03xmyMRcb+oXkotFYf8e
        /8hr3afO+fjtDLwuP4teEfveKhs75fHqNso6U5KTUjuptHLITJuog5IILbcND2TnkeBIEB
        1t3IvKWAZx4UkE8y45r9XMJ5tHFQ5q3wiRFPVVpOqEm1oFVOjY5AYPOr3O53yYTE6AyKNq
        UQiqnTqxXHbZhWR+3x+KZd+bTwi1jtGFUMp2ZmJ3ffw07aHVYw/95LCsjpquxQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1604705239;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fJF/ePB5oQU5dKSCaB2wayxejAKct+VxE3YxaTCIyPE=;
        b=DPIXC8jCWGJyBCZXI6prHyO0GIQPcRMBAtr6gEdc2Z1VAVv6zMKLAoMJF9S1b6cmTB9mZw
        IkRx97S7PCw4PBDg==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/mm] nds32/mm/highmem: Switch to generic kmap atomic
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Nick Hu <nickhu@andestech.com>,
        Greentime Hu <green.hu@gmail.com>,
        Vincent Chen <deanbo422@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20201103095857.980576055@linutronix.de>
References: <20201103095857.980576055@linutronix.de>
MIME-Version: 1.0
Message-ID: <160470523798.397.4838599908825371603.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the core/mm branch of tip:

Commit-ID:     5f037ea3b26767e0b1bdc522948321b282268b49
Gitweb:        https://git.kernel.org/tip/5f037ea3b26767e0b1bdc522948321b282268b49
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Tue, 03 Nov 2020 10:27:26 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Fri, 06 Nov 2020 23:14:57 +01:00

nds32/mm/highmem: Switch to generic kmap atomic

The mapping code is odd and looks broken. See FIXME in the comment.

Also fix the harmless off by one in the FIX_KMAP_END define.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Nick Hu <nickhu@andestech.com>
Cc: Greentime Hu <green.hu@gmail.com>
Cc: Vincent Chen <deanbo422@gmail.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Link: https://lore.kernel.org/r/20201103095857.980576055@linutronix.de

---
 arch/nds32/Kconfig.cpu           |  1 +-
 arch/nds32/include/asm/fixmap.h  |  4 +--
 arch/nds32/include/asm/highmem.h | 22 ++++++++++----
 arch/nds32/mm/Makefile           |  1 +-
 arch/nds32/mm/highmem.c          | 48 +-------------------------------
 5 files changed, 19 insertions(+), 57 deletions(-)
 delete mode 100644 arch/nds32/mm/highmem.c

diff --git a/arch/nds32/Kconfig.cpu b/arch/nds32/Kconfig.cpu
index f88a12f..c107599 100644
--- a/arch/nds32/Kconfig.cpu
+++ b/arch/nds32/Kconfig.cpu
@@ -157,6 +157,7 @@ config HW_SUPPORT_UNALIGNMENT_ACCESS
 config HIGHMEM
 	bool "High Memory Support"
 	depends on MMU && !CPU_CACHE_ALIASING
+	select KMAP_LOCAL
 	help
 	  The address space of Andes processors is only 4 Gigabytes large
 	  and it has to accommodate user address space, kernel address
diff --git a/arch/nds32/include/asm/fixmap.h b/arch/nds32/include/asm/fixmap.h
index 5a4bf11..2fa09a2 100644
--- a/arch/nds32/include/asm/fixmap.h
+++ b/arch/nds32/include/asm/fixmap.h
@@ -6,7 +6,7 @@
 
 #ifdef CONFIG_HIGHMEM
 #include <linux/threads.h>
-#include <asm/kmap_types.h>
+#include <asm/kmap_size.h>
 #endif
 
 enum fixed_addresses {
@@ -14,7 +14,7 @@ enum fixed_addresses {
 	FIX_KMAP_RESERVED,
 	FIX_KMAP_BEGIN,
 #ifdef CONFIG_HIGHMEM
-	FIX_KMAP_END = FIX_KMAP_BEGIN + (KM_TYPE_NR * NR_CPUS),
+	FIX_KMAP_END = FIX_KMAP_BEGIN + (KM_MAX_IDX * NR_CPUS) - 1,
 #endif
 	FIX_EARLYCON_MEM_BASE,
 	__end_of_fixed_addresses
diff --git a/arch/nds32/include/asm/highmem.h b/arch/nds32/include/asm/highmem.h
index fe986d0..16159a8 100644
--- a/arch/nds32/include/asm/highmem.h
+++ b/arch/nds32/include/asm/highmem.h
@@ -5,7 +5,6 @@
 #define _ASM_HIGHMEM_H
 
 #include <asm/proc-fns.h>
-#include <asm/kmap_types.h>
 #include <asm/fixmap.h>
 
 /*
@@ -45,11 +44,22 @@ extern pte_t *pkmap_page_table;
 extern void kmap_init(void);
 
 /*
- * The following functions are already defined by <linux/highmem.h>
- * when CONFIG_HIGHMEM is not set.
+ * FIXME: The below looks broken vs. a kmap_atomic() in task context which
+ * is interupted and another kmap_atomic() happens in interrupt context.
+ * But what do I know about nds32. -- tglx
  */
-#ifdef CONFIG_HIGHMEM
-extern void *kmap_atomic_pfn(unsigned long pfn);
-#endif
+#define arch_kmap_local_post_map(vaddr, pteval)			\
+	do {							\
+		__nds32__tlbop_inv(vaddr);			\
+		__nds32__mtsr_dsb(vaddr, NDS32_SR_TLB_VPN);	\
+		__nds32__tlbop_rwr(pteval);			\
+		__nds32__isb();					\
+	} while (0)
+
+#define arch_kmap_local_pre_unmap(vaddr)			\
+	do {							\
+		__nds32__tlbop_inv(vaddr);			\
+		__nds32__isb();					\
+	} while (0)
 
 #endif
diff --git a/arch/nds32/mm/Makefile b/arch/nds32/mm/Makefile
index 897ecaf..14fb2e8 100644
--- a/arch/nds32/mm/Makefile
+++ b/arch/nds32/mm/Makefile
@@ -3,7 +3,6 @@ obj-y				:= extable.o tlb.o fault.o init.o mmap.o \
                                    mm-nds32.o cacheflush.o proc.o
 
 obj-$(CONFIG_ALIGNMENT_TRAP)	+= alignment.o
-obj-$(CONFIG_HIGHMEM)           += highmem.o
 
 ifdef CONFIG_FUNCTION_TRACER
 CFLAGS_REMOVE_proc.o     = $(CC_FLAGS_FTRACE)
diff --git a/arch/nds32/mm/highmem.c b/arch/nds32/mm/highmem.c
deleted file mode 100644
index 4284cd5..0000000
--- a/arch/nds32/mm/highmem.c
+++ /dev/null
@@ -1,48 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-// Copyright (C) 2005-2017 Andes Technology Corporation
-
-#include <linux/export.h>
-#include <linux/highmem.h>
-#include <linux/sched.h>
-#include <linux/smp.h>
-#include <linux/interrupt.h>
-#include <linux/memblock.h>
-#include <asm/fixmap.h>
-#include <asm/tlbflush.h>
-
-void *kmap_atomic_high_prot(struct page *page, pgprot_t prot)
-{
-	unsigned int idx;
-	unsigned long vaddr, pte;
-	int type;
-	pte_t *ptep;
-
-	type = kmap_atomic_idx_push();
-
-	idx = type + KM_TYPE_NR * smp_processor_id();
-	vaddr = __fix_to_virt(FIX_KMAP_BEGIN + idx);
-	pte = (page_to_pfn(page) << PAGE_SHIFT) | prot;
-	ptep = pte_offset_kernel(pmd_off_k(vaddr), vaddr);
-	set_pte(ptep, pte);
-
-	__nds32__tlbop_inv(vaddr);
-	__nds32__mtsr_dsb(vaddr, NDS32_SR_TLB_VPN);
-	__nds32__tlbop_rwr(pte);
-	__nds32__isb();
-	return (void *)vaddr;
-}
-EXPORT_SYMBOL(kmap_atomic_high_prot);
-
-void kunmap_atomic_high(void *kvaddr)
-{
-	if (kvaddr >= (void *)FIXADDR_START) {
-		unsigned long vaddr = (unsigned long)kvaddr;
-		pte_t *ptep;
-		kmap_atomic_idx_pop();
-		__nds32__tlbop_inv(vaddr);
-		__nds32__isb();
-		ptep = pte_offset_kernel(pmd_off_k(vaddr), vaddr);
-		set_pte(ptep, 0);
-	}
-}
-EXPORT_SYMBOL(kunmap_atomic_high);
