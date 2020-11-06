Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9313B2AA114
	for <lists+linux-tip-commits@lfdr.de>; Sat,  7 Nov 2020 00:28:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728543AbgKFX1R (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 6 Nov 2020 18:27:17 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:38412 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727264AbgKFX1P (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 6 Nov 2020 18:27:15 -0500
Date:   Fri, 06 Nov 2020 23:27:12 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1604705233;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DurPxM/TiHII1+4yN5BElY2xOnZQNkwsnqcCT1FdALc=;
        b=aWEPNNqih3HwKiBUN33lsCRJPwHDxykA5NmsrlfefdrwVNX2Ts1ZzJPq9ZyWZAugSEV4YO
        tlg+zNdVvmSCrVS2Fk+Fkv8RH8cvRBrnRWzUx4PN/Ll6E+6NAseQ5H4FYDOWGQ2+8lML6+
        1Lpg+Uiwcmme7WVojxzptcWXvBsB7R1Qlxms47pYg3jAIV3dAVFEV+OKOuTzTjKxTACYDg
        b2bKhTNf/gdiDlm8QlLvZK3TpARPDwgSyYPU4/gtbfQFkO+5uRVvjHyR0xeFcyolWSQ7nT
        Kst5LzHZJ5FO0hnpT48/NSAIQ/bEUUwsugwbU4FB/fzVTRZ9Us4FCXQ72NXbFQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1604705233;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DurPxM/TiHII1+4yN5BElY2xOnZQNkwsnqcCT1FdALc=;
        b=1QTS5gpNMnkPJiDxe+9Dm2PIPdPBQKaUaNEech/9B+D/dPdtcv+hb8TXmV2HnUJ8jaTE9t
        pSPfe8atfvuzJ9Cw==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/mm] io-mapping: Cleanup atomic iomap
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Linus Torvalds <torvalds@linuxfoundation.org>,
        Christoph Hellwig <hch@lst.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20201103095858.625310005@linutronix.de>
References: <20201103095858.625310005@linutronix.de>
MIME-Version: 1.0
Message-ID: <160470523252.397.4778590462909013884.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the core/mm branch of tip:

Commit-ID:     351191ad55c8a1eccaf23e4187c62056229c0779
Gitweb:        https://git.kernel.org/tip/351191ad55c8a1eccaf23e4187c62056229c0779
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Tue, 03 Nov 2020 10:27:32 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Fri, 06 Nov 2020 23:14:58 +01:00

io-mapping: Cleanup atomic iomap

Switch the atomic iomap implementation over to kmap_local and stick the
preempt/pagefault mechanics into the generic code similar to the
kmap_atomic variants.

Rename the x86 map function in preparation for a non-atomic variant.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Linus Torvalds <torvalds@linuxfoundation.org>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Andrew Morton <akpm@linux-foundation.org>
Link: https://lore.kernel.org/r/20201103095858.625310005@linutronix.de

---
 arch/x86/include/asm/iomap.h |  9 +--------
 arch/x86/mm/iomap_32.c       |  6 ++----
 include/linux/io-mapping.h   |  8 ++++++--
 3 files changed, 9 insertions(+), 14 deletions(-)

diff --git a/arch/x86/include/asm/iomap.h b/arch/x86/include/asm/iomap.h
index 0be7a30..e2de092 100644
--- a/arch/x86/include/asm/iomap.h
+++ b/arch/x86/include/asm/iomap.h
@@ -13,14 +13,7 @@
 #include <asm/cacheflush.h>
 #include <asm/tlbflush.h>
 
-void __iomem *iomap_atomic_pfn_prot(unsigned long pfn, pgprot_t prot);
-
-static inline void iounmap_atomic(void __iomem *vaddr)
-{
-	kunmap_local_indexed((void __force *)vaddr);
-	pagefault_enable();
-	preempt_enable();
-}
+void __iomem *__iomap_local_pfn_prot(unsigned long pfn, pgprot_t prot);
 
 int iomap_create_wc(resource_size_t base, unsigned long size, pgprot_t *prot);
 
diff --git a/arch/x86/mm/iomap_32.c b/arch/x86/mm/iomap_32.c
index e0a40d7..9aaa756 100644
--- a/arch/x86/mm/iomap_32.c
+++ b/arch/x86/mm/iomap_32.c
@@ -44,7 +44,7 @@ void iomap_free(resource_size_t base, unsigned long size)
 }
 EXPORT_SYMBOL_GPL(iomap_free);
 
-void __iomem *iomap_atomic_pfn_prot(unsigned long pfn, pgprot_t prot)
+void __iomem *__iomap_local_pfn_prot(unsigned long pfn, pgprot_t prot)
 {
 	/*
 	 * For non-PAT systems, translate non-WB request to UC- just in
@@ -60,8 +60,6 @@ void __iomem *iomap_atomic_pfn_prot(unsigned long pfn, pgprot_t prot)
 	/* Filter out unsupported __PAGE_KERNEL* bits: */
 	pgprot_val(prot) &= __default_kernel_pte_mask;
 
-	preempt_disable();
-	pagefault_disable();
 	return (void __force __iomem *)__kmap_local_pfn_prot(pfn, prot);
 }
-EXPORT_SYMBOL_GPL(iomap_atomic_pfn_prot);
+EXPORT_SYMBOL_GPL(__iomap_local_pfn_prot);
diff --git a/include/linux/io-mapping.h b/include/linux/io-mapping.h
index 3b0940b..60e7c83 100644
--- a/include/linux/io-mapping.h
+++ b/include/linux/io-mapping.h
@@ -69,13 +69,17 @@ io_mapping_map_atomic_wc(struct io_mapping *mapping,
 
 	BUG_ON(offset >= mapping->size);
 	phys_addr = mapping->base + offset;
-	return iomap_atomic_pfn_prot(PHYS_PFN(phys_addr), mapping->prot);
+	preempt_disable();
+	pagefault_disable();
+	return __iomap_local_pfn_prot(PHYS_PFN(phys_addr), mapping->prot);
 }
 
 static inline void
 io_mapping_unmap_atomic(void __iomem *vaddr)
 {
-	iounmap_atomic(vaddr);
+	kunmap_local_indexed((void __force *)vaddr);
+	pagefault_enable();
+	preempt_enable();
 }
 
 static inline void __iomem *
