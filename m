Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C2522C2949
	for <lists+linux-tip-commits@lfdr.de>; Tue, 24 Nov 2020 15:21:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388792AbgKXOU4 (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Tue, 24 Nov 2020 09:20:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726868AbgKXOUz (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Tue, 24 Nov 2020 09:20:55 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A176FC0613D6;
        Tue, 24 Nov 2020 06:20:55 -0800 (PST)
Date:   Tue, 24 Nov 2020 14:20:53 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1606227654;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HPOn8ALsdeIeXJzfymbOh0oRfuVAcxQ6TpCoIBD7YMg=;
        b=vXiNS0AtUwRfRmMM/KsRdJRGEsHUgriMqJ1F4LlcWLY2hl9CeARQIIucXBPf1JuqCBs/O1
        3pXzzToLBMoHdXXKuYWxXhvy7XVNGW8KtpAUInrLkccxOech8hZdZ20sHtL7BpH2hmHx3M
        GRei/N0L+xJ+tqt1CHlFmKvQfS9mbEDU0ZwQPEOt5MLki778MCmxwp2ZoN1PefwP0ZIW9K
        vS/PBFqvOsrdSLjLmw7Mbbr1LXZkfkUnhad3ExcJKBwtq1wGGc3TCnNIZ4kRcBisIfpEZN
        qVPmNkuLA1bJnFtVC256ngeDw/lwfSpVqXI3zooDBCEkZLJHOJXo8qR9SqRH1g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1606227654;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HPOn8ALsdeIeXJzfymbOh0oRfuVAcxQ6TpCoIBD7YMg=;
        b=wV/+HfhAXedfDQcMuQLpMCy3upagR5Zt3aPqA0QDBJAysOiot9V23fIz8O1y7iXyVpX7w4
        IicdWB+imsFjkfDw==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/mm] mm/highmem: Provide kmap_local*
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20201118204007.468533059@linutronix.de>
References: <20201118204007.468533059@linutronix.de>
MIME-Version: 1.0
Message-ID: <160622765305.11115.11767201930174930313.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the core/mm branch of tip:

Commit-ID:     f3ba3c710ac5a30cd058615a9eb62d2ad95bb782
Gitweb:        https://git.kernel.org/tip/f3ba3c710ac5a30cd058615a9eb62d2ad95bb782
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Wed, 18 Nov 2020 20:48:44 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 24 Nov 2020 14:42:09 +01:00

mm/highmem: Provide kmap_local*

Now that the kmap atomic index is stored in task struct provide a
preemptible variant. On context switch the maps of an outgoing task are
removed and the map of the incoming task are restored. That's obviously
slow, but highmem is slow anyway.

The kmap_local.*() functions can be invoked from both preemptible and
atomic context. kmap local sections disable migration to keep the resulting
virtual mapping address correct, but disable neither pagefaults nor
preemption.

A wholesale conversion of kmap_atomic to be fully preemptible is not
possible because some of the usage sites might rely on the preemption
disable for serialization or on the implicit pagefault disable. Needs to be
done on a case by case basis.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/r/20201118204007.468533059@linutronix.de

---
 include/linux/highmem-internal.h | 48 +++++++++++++++++++++++++++++++-
 include/linux/highmem.h          | 43 +++++++++++++++++-----------
 mm/highmem.c                     |  6 ++++-
 3 files changed, 81 insertions(+), 16 deletions(-)

diff --git a/include/linux/highmem-internal.h b/include/linux/highmem-internal.h
index c5a2217..1bbe96d 100644
--- a/include/linux/highmem-internal.h
+++ b/include/linux/highmem-internal.h
@@ -68,6 +68,26 @@ static inline void kmap_flush_unused(void)
 	__kmap_flush_unused();
 }
 
+static inline void *kmap_local_page(struct page *page)
+{
+	return __kmap_local_page_prot(page, kmap_prot);
+}
+
+static inline void *kmap_local_page_prot(struct page *page, pgprot_t prot)
+{
+	return __kmap_local_page_prot(page, prot);
+}
+
+static inline void *kmap_local_pfn(unsigned long pfn)
+{
+	return __kmap_local_pfn_prot(pfn, kmap_prot);
+}
+
+static inline void __kunmap_local(void *vaddr)
+{
+	kunmap_local_indexed(vaddr);
+}
+
 static inline void *kmap_atomic_prot(struct page *page, pgprot_t prot)
 {
 	preempt_disable();
@@ -140,6 +160,28 @@ static inline void kunmap(struct page *page)
 #endif
 }
 
+static inline void *kmap_local_page(struct page *page)
+{
+	return page_address(page);
+}
+
+static inline void *kmap_local_page_prot(struct page *page, pgprot_t prot)
+{
+	return kmap_local_page(page);
+}
+
+static inline void *kmap_local_pfn(unsigned long pfn)
+{
+	return kmap_local_page(pfn_to_page(pfn));
+}
+
+static inline void __kunmap_local(void *addr)
+{
+#ifdef ARCH_HAS_FLUSH_ON_KUNMAP
+	kunmap_flush_on_unmap(addr);
+#endif
+}
+
 static inline void *kmap_atomic(struct page *page)
 {
 	preempt_disable();
@@ -181,4 +223,10 @@ do {								\
 	__kunmap_atomic(__addr);				\
 } while (0)
 
+#define kunmap_local(__addr)					\
+do {								\
+	BUILD_BUG_ON(__same_type((__addr), struct page *));	\
+	__kunmap_local(__addr);					\
+} while (0)
+
 #endif
diff --git a/include/linux/highmem.h b/include/linux/highmem.h
index 7d098bd..f597830 100644
--- a/include/linux/highmem.h
+++ b/include/linux/highmem.h
@@ -60,24 +60,22 @@ static inline struct page *kmap_to_page(void *addr);
 static inline void kmap_flush_unused(void);
 
 /**
- * kmap_atomic - Atomically map a page for temporary usage
+ * kmap_local_page - Map a page for temporary usage
  * @page:	Pointer to the page to be mapped
  *
  * Returns: The virtual address of the mapping
  *
- * Side effect: On return pagefaults and preemption are disabled.
- *
  * Can be invoked from any context.
  *
  * Requires careful handling when nesting multiple mappings because the map
  * management is stack based. The unmap has to be in the reverse order of
  * the map operation:
  *
- * addr1 = kmap_atomic(page1);
- * addr2 = kmap_atomic(page2);
+ * addr1 = kmap_local_page(page1);
+ * addr2 = kmap_local_page(page2);
  * ...
- * kunmap_atomic(addr2);
- * kunmap_atomic(addr1);
+ * kunmap_local(addr2);
+ * kunmap_local(addr1);
  *
  * Unmapping addr1 before addr2 is invalid and causes malfunction.
  *
@@ -88,10 +86,26 @@ static inline void kmap_flush_unused(void);
  * virtual address of the direct mapping. Only real highmem pages are
  * temporarily mapped.
  *
- * While it is significantly faster than kmap() it comes with restrictions
- * about the pointer validity and the side effects of disabling page faults
- * and preemption. Use it only when absolutely necessary, e.g. from non
- * preemptible contexts.
+ * While it is significantly faster than kmap() for the higmem case it
+ * comes with restrictions about the pointer validity. Only use when really
+ * necessary.
+ *
+ * On HIGHMEM enabled systems mapping a highmem page has the side effect of
+ * disabling migration in order to keep the virtual address stable across
+ * preemption. No caller of kmap_local_page() can rely on this side effect.
+ */
+static inline void *kmap_local_page(struct page *page);
+
+/**
+ * kmap_atomic - Atomically map a page for temporary usage - Deprecated!
+ * @page:	Pointer to the page to be mapped
+ *
+ * Returns: The virtual address of the mapping
+ *
+ * Effectively a wrapper around kmap_local_page() which disables pagefaults
+ * and preemption.
+ *
+ * Do not use in new code. Use kmap_local_page() instead.
  */
 static inline void *kmap_atomic(struct page *page);
 
@@ -101,12 +115,9 @@ static inline void *kmap_atomic(struct page *page);
  *
  * Counterpart to kmap_atomic().
  *
- * Undoes the side effects of kmap_atomic(), i.e. reenabling pagefaults and
+ * Effectively a wrapper around kunmap_local() which additionally undoes
+ * the side effects of kmap_atomic(), i.e. reenabling pagefaults and
  * preemption.
- *
- * Other than that a NOOP for CONFIG_HIGHMEM=n and for mappings of pages
- * in the low memory area. For real highmen pages the mapping which was
- * established with kmap_atomic() is destroyed.
  */
 
 /* Highmem related interfaces for management code */
diff --git a/mm/highmem.c b/mm/highmem.c
index d1ef06a..83f9660 100644
--- a/mm/highmem.c
+++ b/mm/highmem.c
@@ -453,6 +453,11 @@ void *__kmap_local_pfn_prot(unsigned long pfn, pgprot_t prot)
 	unsigned long vaddr;
 	int idx;
 
+	/*
+	 * Disable migration so resulting virtual address is stable
+	 * accross preemption.
+	 */
+	migrate_disable();
 	preempt_disable();
 	idx = arch_kmap_local_map_idx(kmap_local_idx_push(), pfn);
 	vaddr = __fix_to_virt(FIX_KMAP_BEGIN + idx);
@@ -522,6 +527,7 @@ void kunmap_local_indexed(void *vaddr)
 	current->kmap_ctrl.pteval[kmap_local_idx()] = __pte(0);
 	kmap_local_idx_pop();
 	preempt_enable();
+	migrate_enable();
 }
 EXPORT_SYMBOL(kunmap_local_indexed);
 
