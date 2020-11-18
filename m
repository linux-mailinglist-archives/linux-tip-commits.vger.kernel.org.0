Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DDD3B2B82FE
	for <lists+linux-tip-commits@lfdr.de>; Wed, 18 Nov 2020 18:21:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728283AbgKRRTC (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 18 Nov 2020 12:19:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728144AbgKRRS1 (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 18 Nov 2020 12:18:27 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93943C0613D4;
        Wed, 18 Nov 2020 09:18:27 -0800 (PST)
Date:   Wed, 18 Nov 2020 17:18:25 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1605719906;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fpPZbt+b2KrElde1TvONusAOm5dwkze+rhasNAyZJU4=;
        b=Ajb3RTnqVHGZvX0KtVozMUXcVVRkxAk8bvgZ9OFEfZaQ1yRUfkjvX4+VUxdtDZwGt7LasL
        iQAjTh+d1/OXU2MP51gC3sT4/Av+5iQCSAwy6comaQdmtkXOgHZOE0CDHw/p2YutoKgvMI
        YKhTaxv0WLGWVWgkpSgflMpzGUHLXpxr3wtnB8mS8mUNVJUgR0fK9OSSVvmEUBvYvimNJo
        dLAL2o49n3xxe8avTU/IAqs9JA9viuVA+4Y+GRsg42MCaSnW85uBpkCwLtQ02Hmj5bKJri
        t2iL3eukKtZm7iYIEsNaK4nTXjL4tFhyqowqVlFAnJBVIZelXYHNRx6OxykcAw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1605719906;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fpPZbt+b2KrElde1TvONusAOm5dwkze+rhasNAyZJU4=;
        b=Ldx6gzh45ss5cfrX7UzTWmTzX5g7soBRV6VepZUbbV5ai08RXsLyKBCH7yI4vK08FULOEa
        AxOAJrFG9+Boa1Aw==
From:   "tip-bot2 for Jarkko Sakkinen" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/sgx] x86/sgx: Add SGX page allocator functions
Cc:     Sean Christopherson <sean.j.christopherson@intel.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Borislav Petkov <bp@suse.de>,
        Jethro Beekman <jethro@fortanix.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20201112220135.165028-10-jarkko@kernel.org>
References: <20201112220135.165028-10-jarkko@kernel.org>
MIME-Version: 1.0
Message-ID: <160571990531.11244.14914038894848073741.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/sgx branch of tip:

Commit-ID:     d2285493bef310b66b56dfe4eb75c1e2f431ea5c
Gitweb:        https://git.kernel.org/tip/d2285493bef310b66b56dfe4eb75c1e2f431ea5c
Author:        Jarkko Sakkinen <jarkko@kernel.org>
AuthorDate:    Fri, 13 Nov 2020 00:01:20 +02:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Tue, 17 Nov 2020 14:36:13 +01:00

x86/sgx: Add SGX page allocator functions

Add functions for runtime allocation and free.

This allocator and its algorithms are as simple as it gets.  They do a
linear search across all EPC sections and find the first free page.  They
are not NUMA-aware and only hand out individual pages.  The SGX hardware
does not support large pages, so something more complicated like a buddy
allocator is unwarranted.

The free function (sgx_free_epc_page()) implicitly calls ENCLS[EREMOVE],
which returns the page to the uninitialized state.  This ensures that the
page is ready for use at the next allocation.

Co-developed-by: Sean Christopherson <sean.j.christopherson@intel.com>
Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
Signed-off-by: Borislav Petkov <bp@suse.de>
Acked-by: Jethro Beekman <jethro@fortanix.com>
Link: https://lkml.kernel.org/r/20201112220135.165028-10-jarkko@kernel.org
---
 arch/x86/kernel/cpu/sgx/main.c | 65 +++++++++++++++++++++++++++++++++-
 arch/x86/kernel/cpu/sgx/sgx.h  |  3 ++-
 2 files changed, 68 insertions(+)

diff --git a/arch/x86/kernel/cpu/sgx/main.c b/arch/x86/kernel/cpu/sgx/main.c
index 187a237..2e53afc 100644
--- a/arch/x86/kernel/cpu/sgx/main.c
+++ b/arch/x86/kernel/cpu/sgx/main.c
@@ -85,6 +85,71 @@ static bool __init sgx_page_reclaimer_init(void)
 	return true;
 }
 
+static struct sgx_epc_page *__sgx_alloc_epc_page_from_section(struct sgx_epc_section *section)
+{
+	struct sgx_epc_page *page;
+
+	spin_lock(&section->lock);
+
+	if (list_empty(&section->page_list)) {
+		spin_unlock(&section->lock);
+		return NULL;
+	}
+
+	page = list_first_entry(&section->page_list, struct sgx_epc_page, list);
+	list_del_init(&page->list);
+
+	spin_unlock(&section->lock);
+	return page;
+}
+
+/**
+ * __sgx_alloc_epc_page() - Allocate an EPC page
+ *
+ * Iterate through EPC sections and borrow a free EPC page to the caller. When a
+ * page is no longer needed it must be released with sgx_free_epc_page().
+ *
+ * Return:
+ *   an EPC page,
+ *   -errno on error
+ */
+struct sgx_epc_page *__sgx_alloc_epc_page(void)
+{
+	struct sgx_epc_section *section;
+	struct sgx_epc_page *page;
+	int i;
+
+	for (i = 0; i < sgx_nr_epc_sections; i++) {
+		section = &sgx_epc_sections[i];
+
+		page = __sgx_alloc_epc_page_from_section(section);
+		if (page)
+			return page;
+	}
+
+	return ERR_PTR(-ENOMEM);
+}
+
+/**
+ * sgx_free_epc_page() - Free an EPC page
+ * @page:	an EPC page
+ *
+ * Call EREMOVE for an EPC page and insert it back to the list of free pages.
+ */
+void sgx_free_epc_page(struct sgx_epc_page *page)
+{
+	struct sgx_epc_section *section = &sgx_epc_sections[page->section];
+	int ret;
+
+	ret = __eremove(sgx_get_epc_virt_addr(page));
+	if (WARN_ONCE(ret, "EREMOVE returned %d (0x%x)", ret, ret))
+		return;
+
+	spin_lock(&section->lock);
+	list_add_tail(&page->list, &section->page_list);
+	spin_unlock(&section->lock);
+}
+
 static bool __init sgx_setup_epc_section(u64 phys_addr, u64 size,
 					 unsigned long index,
 					 struct sgx_epc_section *section)
diff --git a/arch/x86/kernel/cpu/sgx/sgx.h b/arch/x86/kernel/cpu/sgx/sgx.h
index 02afa84..bd9dcb1 100644
--- a/arch/x86/kernel/cpu/sgx/sgx.h
+++ b/arch/x86/kernel/cpu/sgx/sgx.h
@@ -57,4 +57,7 @@ static inline void *sgx_get_epc_virt_addr(struct sgx_epc_page *page)
 	return section->virt_addr + index * PAGE_SIZE;
 }
 
+struct sgx_epc_page *__sgx_alloc_epc_page(void);
+void sgx_free_epc_page(struct sgx_epc_page *page);
+
 #endif /* _X86_SGX_H */
