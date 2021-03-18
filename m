Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F0AF340DCE
	for <lists+linux-tip-commits@lfdr.de>; Thu, 18 Mar 2021 20:06:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232357AbhCRTFs (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Thu, 18 Mar 2021 15:05:48 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:59656 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229996AbhCRTFk (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Thu, 18 Mar 2021 15:05:40 -0400
Date:   Thu, 18 Mar 2021 19:05:38 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1616094339;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=a4XRupqv6A2cx8zMOnwQgGtym9Na93Zh7gf17YaXn+c=;
        b=nUEWEzpa8jzAiUjdY3bVhJvcfSjZuQxS7SpQjOf7Ww+6MFlxtXwCXTPSzVz8LoxkXcgKj1
        /KcKSNI+rFgt/oiQK1uvsxW08cpJYgbUgBVeI37RkuH7FZWCQkuhKKyna4pI91CIScI+zS
        0+IOgRXt5IvM5Wbk3gXTYWs/gIwUOJYJKh0fjz+yE0LM5QfXh72ebN5zuDGs6joyXOvz7H
        hAqSrgp2qeMUGJL71lxEhmdU6Y/V8XvLMIsCR44Qr/JclTMVEXLifsURYvXLhMsPeDxd7U
        Qklu+6b18+jKwGEP/2DX+Qn8ya85E39T73PYP+7UP0E+JkgyGppDglOOka5taQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1616094339;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=a4XRupqv6A2cx8zMOnwQgGtym9Na93Zh7gf17YaXn+c=;
        b=nzuVF8PJoPLc5tcURqnyi2fjByV8CS945JBXl3bK03Hv3NCx8mZ8ak99U9RqvAALJLBXRc
        xgYKRwZ+R55mTWDg==
From:   "tip-bot2 for Jarkko Sakkinen" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/sgx] x86/sgx: Replace section->init_laundry_list with
 sgx_dirty_page_list
Cc:     Jarkko Sakkinen <jarkko@kernel.org>, Borislav Petkov <bp@suse.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210317235332.362001-1-jarkko.sakkinen@intel.com>
References: <20210317235332.362001-1-jarkko.sakkinen@intel.com>
MIME-Version: 1.0
Message-ID: <161609433816.398.9992116739812428895.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/sgx branch of tip:

Commit-ID:     51ab30eb2ad4c4a61f827dc18863cd70dc46dc32
Gitweb:        https://git.kernel.org/tip/51ab30eb2ad4c4a61f827dc18863cd70dc46dc32
Author:        Jarkko Sakkinen <jarkko@kernel.org>
AuthorDate:    Thu, 18 Mar 2021 01:53:30 +02:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Thu, 18 Mar 2021 16:17:26 +01:00

x86/sgx: Replace section->init_laundry_list with sgx_dirty_page_list

During normal runtime, the "ksgxd" daemon behaves like a version of
kswapd just for SGX. But, before it starts acting like kswapd, its first
job is to initialize enclave memory.

Currently, the SGX boot code places each enclave page on a
epc_section->init_laundry_list. Once it starts up, the ksgxd code walks
over that list and populates the actual SGX page allocator.

However, the per-section structures are going away to make way for the
SGX NUMA allocator. There's also little need to have a per-section
structure; the enclave pages are all treated identically, and they can
be placed on the correct allocator list from metadata stored in the
enclave page (struct sgx_epc_page) itself.

Modify sgx_sanitize_section() to take a single page list instead of
taking a section and deriving the list from there.

Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
Signed-off-by: Borislav Petkov <bp@suse.de>
Acked-by: Dave Hansen <dave.hansen@linux.intel.com>
Link: https://lkml.kernel.org/r/20210317235332.362001-1-jarkko.sakkinen@intel.com
---
 arch/x86/kernel/cpu/sgx/main.c | 54 +++++++++++++++------------------
 arch/x86/kernel/cpu/sgx/sgx.h  |  7 +----
 2 files changed, 25 insertions(+), 36 deletions(-)

diff --git a/arch/x86/kernel/cpu/sgx/main.c b/arch/x86/kernel/cpu/sgx/main.c
index 8df81a3..f3a5cd2 100644
--- a/arch/x86/kernel/cpu/sgx/main.c
+++ b/arch/x86/kernel/cpu/sgx/main.c
@@ -26,39 +26,43 @@ static LIST_HEAD(sgx_active_page_list);
 
 static DEFINE_SPINLOCK(sgx_reclaimer_lock);
 
+static LIST_HEAD(sgx_dirty_page_list);
+
 /*
- * Reset dirty EPC pages to uninitialized state. Laundry can be left with SECS
- * pages whose child pages blocked EREMOVE.
+ * Reset post-kexec EPC pages to the uninitialized state. The pages are removed
+ * from the input list, and made available for the page allocator. SECS pages
+ * prepending their children in the input list are left intact.
  */
-static void sgx_sanitize_section(struct sgx_epc_section *section)
+static void __sgx_sanitize_pages(struct list_head *dirty_page_list)
 {
 	struct sgx_epc_page *page;
 	LIST_HEAD(dirty);
 	int ret;
 
-	/* init_laundry_list is thread-local, no need for a lock: */
-	while (!list_empty(&section->init_laundry_list)) {
+	/* dirty_page_list is thread-local, no need for a lock: */
+	while (!list_empty(dirty_page_list)) {
 		if (kthread_should_stop())
 			return;
 
-		/* needed for access to ->page_list: */
-		spin_lock(&section->lock);
-
-		page = list_first_entry(&section->init_laundry_list,
-					struct sgx_epc_page, list);
+		page = list_first_entry(dirty_page_list, struct sgx_epc_page, list);
 
 		ret = __eremove(sgx_get_epc_virt_addr(page));
-		if (!ret)
-			list_move(&page->list, &section->page_list);
-		else
+		if (!ret) {
+			/*
+			 * page is now sanitized.  Make it available via the SGX
+			 * page allocator:
+			 */
+			list_del(&page->list);
+			sgx_free_epc_page(page);
+		} else {
+			/* The page is not yet clean - move to the dirty list. */
 			list_move_tail(&page->list, &dirty);
-
-		spin_unlock(&section->lock);
+		}
 
 		cond_resched();
 	}
 
-	list_splice(&dirty, &section->init_laundry_list);
+	list_splice(&dirty, dirty_page_list);
 }
 
 static bool sgx_reclaimer_age(struct sgx_epc_page *epc_page)
@@ -405,24 +409,17 @@ static bool sgx_should_reclaim(unsigned long watermark)
 
 static int ksgxd(void *p)
 {
-	int i;
-
 	set_freezable();
 
 	/*
 	 * Sanitize pages in order to recover from kexec(). The 2nd pass is
 	 * required for SECS pages, whose child pages blocked EREMOVE.
 	 */
-	for (i = 0; i < sgx_nr_epc_sections; i++)
-		sgx_sanitize_section(&sgx_epc_sections[i]);
-
-	for (i = 0; i < sgx_nr_epc_sections; i++) {
-		sgx_sanitize_section(&sgx_epc_sections[i]);
+	__sgx_sanitize_pages(&sgx_dirty_page_list);
+	__sgx_sanitize_pages(&sgx_dirty_page_list);
 
-		/* Should never happen. */
-		if (!list_empty(&sgx_epc_sections[i].init_laundry_list))
-			WARN(1, "EPC section %d has unsanitized pages.\n", i);
-	}
+	/* sanity check: */
+	WARN_ON(!list_empty(&sgx_dirty_page_list));
 
 	while (!kthread_should_stop()) {
 		if (try_to_freeze())
@@ -637,13 +634,12 @@ static bool __init sgx_setup_epc_section(u64 phys_addr, u64 size,
 	section->phys_addr = phys_addr;
 	spin_lock_init(&section->lock);
 	INIT_LIST_HEAD(&section->page_list);
-	INIT_LIST_HEAD(&section->init_laundry_list);
 
 	for (i = 0; i < nr_pages; i++) {
 		section->pages[i].section = index;
 		section->pages[i].flags = 0;
 		section->pages[i].owner = NULL;
-		list_add_tail(&section->pages[i].list, &section->init_laundry_list);
+		list_add_tail(&section->pages[i].list, &sgx_dirty_page_list);
 	}
 
 	section->free_cnt = nr_pages;
diff --git a/arch/x86/kernel/cpu/sgx/sgx.h b/arch/x86/kernel/cpu/sgx/sgx.h
index 5fa42d1..bc8af04 100644
--- a/arch/x86/kernel/cpu/sgx/sgx.h
+++ b/arch/x86/kernel/cpu/sgx/sgx.h
@@ -45,13 +45,6 @@ struct sgx_epc_section {
 	spinlock_t lock;
 	struct list_head page_list;
 	unsigned long free_cnt;
-
-	/*
-	 * Pages which need EREMOVE run on them before they can be
-	 * used.  Only safe to be accessed in ksgxd and init code.
-	 * Not protected by locks.
-	 */
-	struct list_head init_laundry_list;
 };
 
 extern struct sgx_epc_section sgx_epc_sections[SGX_MAX_EPC_SECTIONS];
