Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C34BC451D19
	for <lists+linux-tip-commits@lfdr.de>; Tue, 16 Nov 2021 01:22:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245267AbhKPAZN (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Mon, 15 Nov 2021 19:25:13 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:47078 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350677AbhKOUZh (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Mon, 15 Nov 2021 15:25:37 -0500
Date:   Mon, 15 Nov 2021 20:22:32 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1637007753;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=sUvX0BmKsozlfMHCuwKNXwMRaywa4eTzAvhGtwPCB4M=;
        b=3B2zHavr+FkxWoIEmd48ADXPEM944jwiGePKV0WA2YvKQ4rhMVhll/FNZwZvcuKr3wq5Jo
        JiEt+UYesNeQQxi9sBv7rEl0dnkkmz3ZeEjqYBH3Uy/oyKJSNrc/8+WSyA43kqbJo8rSIz
        sFS5PZqU2Khws0Ui4HgvcR6ywniu9lpRjlfPTof9KNPRMM/raBcl1yWh9mpy3pt9dsGiu6
        PzB+e8KQOMozaeSD27v6mVC8QTDtr3ynu17Imkmwv+zRpW9Egy7HwiU/JzsHjnSM4liB5E
        Mha7HfUq++x/PnTHU5gIcbb89snDIDZ+ixZR8EyIKK5VOeKhCzfVM7y46NyFEQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1637007753;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=sUvX0BmKsozlfMHCuwKNXwMRaywa4eTzAvhGtwPCB4M=;
        b=mRZTyGmDTow92TapikTqJtbiETaKa3wJPDfgtgF8fd9vx5by7qxs/fW9xfEuENZx7obzqO
        e5NzHB+NMSu7W4Dg==
From:   "tip-bot2 for Tony Luck" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/sgx] x86/sgx: Initial poison handling for dirty and free pages
Cc:     Tony Luck <tony.luck@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Reinette Chatre <reinette.chatre@intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20211026220050.697075-4-tony.luck@intel.com>
References: <20211026220050.697075-4-tony.luck@intel.com>
MIME-Version: 1.0
Message-ID: <163700775206.414.4654413963930034337.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/sgx branch of tip:

Commit-ID:     992801ae92431761b3d8ec88abd5793d154d34ac
Gitweb:        https://git.kernel.org/tip/992801ae92431761b3d8ec88abd5793d154d34ac
Author:        Tony Luck <tony.luck@intel.com>
AuthorDate:    Tue, 26 Oct 2021 15:00:46 -07:00
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Mon, 15 Nov 2021 11:13:16 -08:00

x86/sgx: Initial poison handling for dirty and free pages

A memory controller patrol scrubber can report poison in a page
that isn't currently being used.

Add "poison" field in the sgx_epc_page that can be set for an
sgx_epc_page. Check for it:
1) When sanitizing dirty pages
2) When freeing epc pages

Poison is a new field separated from flags to avoid having to make all
updates to flags atomic, or integrate poison state changes into some
other locking scheme to protect flags (Currently just sgx_reclaimer_lock
which protects the SGX_EPC_PAGE_RECLAIMER_TRACKED bit in page->flags).

In both cases place the poisoned page on a per-node list of poisoned
epc pages to make sure it will not be reallocated.

Signed-off-by: Tony Luck <tony.luck@intel.com>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>
Tested-by: Reinette Chatre <reinette.chatre@intel.com>
Link: https://lkml.kernel.org/r/20211026220050.697075-4-tony.luck@intel.com
---
 arch/x86/kernel/cpu/sgx/main.c | 26 +++++++++++++++++++++++++-
 arch/x86/kernel/cpu/sgx/sgx.h  |  4 +++-
 2 files changed, 28 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/cpu/sgx/main.c b/arch/x86/kernel/cpu/sgx/main.c
index 5c02cff..e5fcb83 100644
--- a/arch/x86/kernel/cpu/sgx/main.c
+++ b/arch/x86/kernel/cpu/sgx/main.c
@@ -62,6 +62,24 @@ static void __sgx_sanitize_pages(struct list_head *dirty_page_list)
 
 		page = list_first_entry(dirty_page_list, struct sgx_epc_page, list);
 
+		/*
+		 * Checking page->poison without holding the node->lock
+		 * is racy, but losing the race (i.e. poison is set just
+		 * after the check) just means __eremove() will be uselessly
+		 * called for a page that sgx_free_epc_page() will put onto
+		 * the node->sgx_poison_page_list later.
+		 */
+		if (page->poison) {
+			struct sgx_epc_section *section = &sgx_epc_sections[page->section];
+			struct sgx_numa_node *node = section->node;
+
+			spin_lock(&node->lock);
+			list_move(&page->list, &node->sgx_poison_page_list);
+			spin_unlock(&node->lock);
+
+			continue;
+		}
+
 		ret = __eremove(sgx_get_epc_virt_addr(page));
 		if (!ret) {
 			/*
@@ -626,7 +644,11 @@ void sgx_free_epc_page(struct sgx_epc_page *page)
 
 	spin_lock(&node->lock);
 
-	list_add_tail(&page->list, &node->free_page_list);
+	page->owner = NULL;
+	if (page->poison)
+		list_add(&page->list, &node->sgx_poison_page_list);
+	else
+		list_add_tail(&page->list, &node->free_page_list);
 	sgx_nr_free_pages++;
 	page->flags = SGX_EPC_PAGE_IS_FREE;
 
@@ -658,6 +680,7 @@ static bool __init sgx_setup_epc_section(u64 phys_addr, u64 size,
 		section->pages[i].section = index;
 		section->pages[i].flags = 0;
 		section->pages[i].owner = NULL;
+		section->pages[i].poison = 0;
 		list_add_tail(&section->pages[i].list, &sgx_dirty_page_list);
 	}
 
@@ -724,6 +747,7 @@ static bool __init sgx_page_cache_init(void)
 		if (!node_isset(nid, sgx_numa_mask)) {
 			spin_lock_init(&sgx_numa_nodes[nid].lock);
 			INIT_LIST_HEAD(&sgx_numa_nodes[nid].free_page_list);
+			INIT_LIST_HEAD(&sgx_numa_nodes[nid].sgx_poison_page_list);
 			node_set(nid, sgx_numa_mask);
 		}
 
diff --git a/arch/x86/kernel/cpu/sgx/sgx.h b/arch/x86/kernel/cpu/sgx/sgx.h
index 5906471..9ec3136 100644
--- a/arch/x86/kernel/cpu/sgx/sgx.h
+++ b/arch/x86/kernel/cpu/sgx/sgx.h
@@ -31,7 +31,8 @@
 
 struct sgx_epc_page {
 	unsigned int section;
-	unsigned int flags;
+	u16 flags;
+	u16 poison;
 	struct sgx_encl_page *owner;
 	struct list_head list;
 };
@@ -42,6 +43,7 @@ struct sgx_epc_page {
  */
 struct sgx_numa_node {
 	struct list_head free_page_list;
+	struct list_head sgx_poison_page_list;
 	spinlock_t lock;
 };
 
