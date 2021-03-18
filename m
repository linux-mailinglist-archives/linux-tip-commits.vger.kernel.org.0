Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2006A340DCD
	for <lists+linux-tip-commits@lfdr.de>; Thu, 18 Mar 2021 20:06:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232622AbhCRTFs (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Thu, 18 Mar 2021 15:05:48 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:59660 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230021AbhCRTFk (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Thu, 18 Mar 2021 15:05:40 -0400
Date:   Thu, 18 Mar 2021 19:05:37 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1616094339;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HY+w/nyf7362a8GdjpCghaKVR4nDUpkF8hyQUhSgVtA=;
        b=cpJXgUehBE7WzS+XYESEgpC3D+zEFIld/frAG7aOn1BjZceYd9FNSunOgfCIKOA2wFIyQo
        Ziv1ysK6kwQWr/GT7ALow1DL311EHbb1KOP3vDPT+ysMyjud35ilJ3O8tkqDRJA0gRLyVo
        QY4Ce1zarr1Zsk23gpHSIoy9AlAh8u9cfpA8nnNmiVxmBgyf01ygm4JYy81CWVT8vFXr0X
        qebThmKsY6J/dOuQR2dYtA7/eMOooLBMYGpaeR19YwaYcVOVcl/X8Z7Q4RXbVZst1divx8
        E6A7COJDAkcxc5oFEAkGfA24E2rPLkumJxVXCZWnXs9x1/sM89MVNOqml0PNMw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1616094339;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HY+w/nyf7362a8GdjpCghaKVR4nDUpkF8hyQUhSgVtA=;
        b=CTm0Q9mQn8g5pgE4osVT0zjpoP1JgCoiOv5HurPKBS1lj+AnhOqx+XoqPcW1nSyglMkMUt
        GkGRxV18j60vN0BQ==
From:   "tip-bot2 for Jarkko Sakkinen" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/sgx] x86/sgx: Add a basic NUMA allocation scheme to
 sgx_alloc_epc_page()
Cc:     Jarkko Sakkinen <jarkko@kernel.org>, Borislav Petkov <bp@suse.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210317235332.362001-2-jarkko.sakkinen@intel.com>
References: <20210317235332.362001-2-jarkko.sakkinen@intel.com>
MIME-Version: 1.0
Message-ID: <161609433763.398.7835527852068629393.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/sgx branch of tip:

Commit-ID:     5b8719504e3adf47646273781591ad439b3c3c7a
Gitweb:        https://git.kernel.org/tip/5b8719504e3adf47646273781591ad439b3c3c7a
Author:        Jarkko Sakkinen <jarkko@kernel.org>
AuthorDate:    Thu, 18 Mar 2021 01:53:31 +02:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Thu, 18 Mar 2021 16:32:19 +01:00

x86/sgx: Add a basic NUMA allocation scheme to sgx_alloc_epc_page()

Background
==========

SGX enclave memory is enumerated by the processor in contiguous physical
ranges called Enclave Page Cache (EPC) sections.  Currently, there is a
free list per section, but allocations simply target the lowest-numbered
sections.  This is functional, but has no NUMA awareness.

Fortunately, EPC sections are covered by entries in the ACPI SRAT table.
These entries allow each EPC section to be associated with a NUMA node,
just like normal RAM.

Solution
========

Implement a NUMA-aware enclave page allocator.  Mirror the buddy allocator
and maintain a list of enclave pages for each NUMA node.  Attempt to
allocate enclave memory first from local nodes, then fall back to other
nodes.

Note that the fallback is not as sophisticated as the buddy allocator
and is itself not aware of NUMA distances.  When a node's free list is
empty, it searches for the next-highest node with enclave pages (and
will wrap if necessary).  This could be improved in the future.

Other
=====

NUMA_KEEP_MEMINFO dependency is required for phys_to_target_node().

Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
Signed-off-by: Borislav Petkov <bp@suse.de>
Acked-by: Dave Hansen <dave.hansen@linux.intel.com>
Link: https://lore.kernel.org/lkml/158188326978.894464.217282995221175417.stgit@dwillia2-desk3.amr.corp.intel.com/
Link: https://lkml.kernel.org/r/20210317235332.362001-2-jarkko.sakkinen@intel.com
---
 arch/x86/Kconfig               |   1 +-
 arch/x86/kernel/cpu/sgx/main.c | 123 ++++++++++++++++++++------------
 arch/x86/kernel/cpu/sgx/sgx.h  |  16 ++--
 3 files changed, 90 insertions(+), 50 deletions(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 2792879..35391e9 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -1931,6 +1931,7 @@ config X86_SGX
 	depends on CRYPTO_SHA256=y
 	select SRCU
 	select MMU_NOTIFIER
+	select NUMA_KEEP_MEMINFO if NUMA
 	help
 	  Intel(R) Software Guard eXtensions (SGX) is a set of CPU instructions
 	  that can be used by applications to set aside private regions of code
diff --git a/arch/x86/kernel/cpu/sgx/main.c b/arch/x86/kernel/cpu/sgx/main.c
index f3a5cd2..2a0031e 100644
--- a/arch/x86/kernel/cpu/sgx/main.c
+++ b/arch/x86/kernel/cpu/sgx/main.c
@@ -23,9 +23,21 @@ static DECLARE_WAIT_QUEUE_HEAD(ksgxd_waitq);
  * with sgx_reclaimer_lock acquired.
  */
 static LIST_HEAD(sgx_active_page_list);
-
 static DEFINE_SPINLOCK(sgx_reclaimer_lock);
 
+/* The free page list lock protected variables prepend the lock. */
+static unsigned long sgx_nr_free_pages;
+
+/* Nodes with one or more EPC sections. */
+static nodemask_t sgx_numa_mask;
+
+/*
+ * Array with one list_head for each possible NUMA node.  Each
+ * list contains all the sgx_epc_section's which are on that
+ * node.
+ */
+static struct sgx_numa_node *sgx_numa_nodes;
+
 static LIST_HEAD(sgx_dirty_page_list);
 
 /*
@@ -312,6 +324,7 @@ static void sgx_reclaim_pages(void)
 	struct sgx_epc_section *section;
 	struct sgx_encl_page *encl_page;
 	struct sgx_epc_page *epc_page;
+	struct sgx_numa_node *node;
 	pgoff_t page_index;
 	int cnt = 0;
 	int ret;
@@ -383,28 +396,18 @@ skip:
 		epc_page->flags &= ~SGX_EPC_PAGE_RECLAIMER_TRACKED;
 
 		section = &sgx_epc_sections[epc_page->section];
-		spin_lock(&section->lock);
-		list_add_tail(&epc_page->list, &section->page_list);
-		section->free_cnt++;
-		spin_unlock(&section->lock);
-	}
-}
+		node = section->node;
 
-static unsigned long sgx_nr_free_pages(void)
-{
-	unsigned long cnt = 0;
-	int i;
-
-	for (i = 0; i < sgx_nr_epc_sections; i++)
-		cnt += sgx_epc_sections[i].free_cnt;
-
-	return cnt;
+		spin_lock(&node->lock);
+		list_add_tail(&epc_page->list, &node->free_page_list);
+		sgx_nr_free_pages++;
+		spin_unlock(&node->lock);
+	}
 }
 
 static bool sgx_should_reclaim(unsigned long watermark)
 {
-	return sgx_nr_free_pages() < watermark &&
-	       !list_empty(&sgx_active_page_list);
+	return sgx_nr_free_pages < watermark && !list_empty(&sgx_active_page_list);
 }
 
 static int ksgxd(void *p)
@@ -451,50 +454,61 @@ static bool __init sgx_page_reclaimer_init(void)
 	return true;
 }
 
-static struct sgx_epc_page *__sgx_alloc_epc_page_from_section(struct sgx_epc_section *section)
+static struct sgx_epc_page *__sgx_alloc_epc_page_from_node(int nid)
 {
-	struct sgx_epc_page *page;
+	struct sgx_numa_node *node = &sgx_numa_nodes[nid];
+	struct sgx_epc_page *page = NULL;
 
-	spin_lock(&section->lock);
+	spin_lock(&node->lock);
 
-	if (list_empty(&section->page_list)) {
-		spin_unlock(&section->lock);
+	if (list_empty(&node->free_page_list)) {
+		spin_unlock(&node->lock);
 		return NULL;
 	}
 
-	page = list_first_entry(&section->page_list, struct sgx_epc_page, list);
+	page = list_first_entry(&node->free_page_list, struct sgx_epc_page, list);
 	list_del_init(&page->list);
-	section->free_cnt--;
+	sgx_nr_free_pages--;
+
+	spin_unlock(&node->lock);
 
-	spin_unlock(&section->lock);
 	return page;
 }
 
 /**
  * __sgx_alloc_epc_page() - Allocate an EPC page
  *
- * Iterate through EPC sections and borrow a free EPC page to the caller. When a
- * page is no longer needed it must be released with sgx_free_epc_page().
+ * Iterate through NUMA nodes and reserve ia free EPC page to the caller. Start
+ * from the NUMA node, where the caller is executing.
  *
  * Return:
- *   an EPC page,
- *   -errno on error
+ * - an EPC page:	A borrowed EPC pages were available.
+ * - NULL:		Out of EPC pages.
  */
 struct sgx_epc_page *__sgx_alloc_epc_page(void)
 {
-	struct sgx_epc_section *section;
 	struct sgx_epc_page *page;
-	int i;
-
-	for (i = 0; i < sgx_nr_epc_sections; i++) {
-		section = &sgx_epc_sections[i];
+	int nid_of_current = numa_node_id();
+	int nid;
 
-		page = __sgx_alloc_epc_page_from_section(section);
+	if (node_isset(nid_of_current, sgx_numa_mask)) {
+		page = __sgx_alloc_epc_page_from_node(nid_of_current);
 		if (page)
 			return page;
 	}
 
-	return ERR_PTR(-ENOMEM);
+	/* Fall back to the non-local NUMA nodes: */
+	while (true) {
+		nid = next_node_in(nid, sgx_numa_mask);
+		if (nid == nid_of_current)
+			break;
+
+		page = __sgx_alloc_epc_page_from_node(nid);
+		if (page)
+			break;
+	}
+
+	return page;
 }
 
 /**
@@ -600,6 +614,7 @@ struct sgx_epc_page *sgx_alloc_epc_page(void *owner, bool reclaim)
 void sgx_free_epc_page(struct sgx_epc_page *page)
 {
 	struct sgx_epc_section *section = &sgx_epc_sections[page->section];
+	struct sgx_numa_node *node = section->node;
 	int ret;
 
 	WARN_ON_ONCE(page->flags & SGX_EPC_PAGE_RECLAIMER_TRACKED);
@@ -608,10 +623,12 @@ void sgx_free_epc_page(struct sgx_epc_page *page)
 	if (WARN_ONCE(ret, "EREMOVE returned %d (0x%x)", ret, ret))
 		return;
 
-	spin_lock(&section->lock);
-	list_add_tail(&page->list, &section->page_list);
-	section->free_cnt++;
-	spin_unlock(&section->lock);
+	spin_lock(&node->lock);
+
+	list_add_tail(&page->list, &node->free_page_list);
+	sgx_nr_free_pages++;
+
+	spin_unlock(&node->lock);
 }
 
 static bool __init sgx_setup_epc_section(u64 phys_addr, u64 size,
@@ -632,8 +649,6 @@ static bool __init sgx_setup_epc_section(u64 phys_addr, u64 size,
 	}
 
 	section->phys_addr = phys_addr;
-	spin_lock_init(&section->lock);
-	INIT_LIST_HEAD(&section->page_list);
 
 	for (i = 0; i < nr_pages; i++) {
 		section->pages[i].section = index;
@@ -642,7 +657,7 @@ static bool __init sgx_setup_epc_section(u64 phys_addr, u64 size,
 		list_add_tail(&section->pages[i].list, &sgx_dirty_page_list);
 	}
 
-	section->free_cnt = nr_pages;
+	sgx_nr_free_pages += nr_pages;
 	return true;
 }
 
@@ -661,8 +676,13 @@ static bool __init sgx_page_cache_init(void)
 {
 	u32 eax, ebx, ecx, edx, type;
 	u64 pa, size;
+	int nid;
 	int i;
 
+	sgx_numa_nodes = kmalloc_array(num_possible_nodes(), sizeof(*sgx_numa_nodes), GFP_KERNEL);
+	if (!sgx_numa_nodes)
+		return false;
+
 	for (i = 0; i < ARRAY_SIZE(sgx_epc_sections); i++) {
 		cpuid_count(SGX_CPUID, i + SGX_CPUID_EPC, &eax, &ebx, &ecx, &edx);
 
@@ -685,6 +705,21 @@ static bool __init sgx_page_cache_init(void)
 			break;
 		}
 
+		nid = numa_map_to_online_node(phys_to_target_node(pa));
+		if (nid == NUMA_NO_NODE) {
+			/* The physical address is already printed above. */
+			pr_warn(FW_BUG "Unable to map EPC section to online node. Fallback to the NUMA node 0.\n");
+			nid = 0;
+		}
+
+		if (!node_isset(nid, sgx_numa_mask)) {
+			spin_lock_init(&sgx_numa_nodes[nid].lock);
+			INIT_LIST_HEAD(&sgx_numa_nodes[nid].free_page_list);
+			node_set(nid, sgx_numa_mask);
+		}
+
+		sgx_epc_sections[i].node =  &sgx_numa_nodes[nid];
+
 		sgx_nr_epc_sections++;
 	}
 
diff --git a/arch/x86/kernel/cpu/sgx/sgx.h b/arch/x86/kernel/cpu/sgx/sgx.h
index bc8af04..653af8c 100644
--- a/arch/x86/kernel/cpu/sgx/sgx.h
+++ b/arch/x86/kernel/cpu/sgx/sgx.h
@@ -30,21 +30,25 @@ struct sgx_epc_page {
 };
 
 /*
+ * Contains the tracking data for NUMA nodes having EPC pages. Most importantly,
+ * the free page list local to the node is stored here.
+ */
+struct sgx_numa_node {
+	struct list_head free_page_list;
+	spinlock_t lock;
+};
+
+/*
  * The firmware can define multiple chunks of EPC to the different areas of the
  * physical memory e.g. for memory areas of the each node. This structure is
  * used to store EPC pages for one EPC section and virtual memory area where
  * the pages have been mapped.
- *
- * 'lock' must be held before accessing 'page_list' or 'free_cnt'.
  */
 struct sgx_epc_section {
 	unsigned long phys_addr;
 	void *virt_addr;
 	struct sgx_epc_page *pages;
-
-	spinlock_t lock;
-	struct list_head page_list;
-	unsigned long free_cnt;
+	struct sgx_numa_node *node;
 };
 
 extern struct sgx_epc_section sgx_epc_sections[SGX_MAX_EPC_SECTIONS];
