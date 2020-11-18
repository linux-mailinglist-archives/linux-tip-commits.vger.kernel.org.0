Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C7BBA2B82D8
	for <lists+linux-tip-commits@lfdr.de>; Wed, 18 Nov 2020 18:21:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728079AbgKRRSU (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 18 Nov 2020 12:18:20 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:56162 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728062AbgKRRSS (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 18 Nov 2020 12:18:18 -0500
Date:   Wed, 18 Nov 2020 17:18:15 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1605719896;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GmxCj/7ZnJBKISZdax6TrGFzzg4ya64APGcVFhXUJww=;
        b=turMRdccUT+iBqIzr0XJwgqC6MpBjsN/bN96HEHm299rdaX4SfTySh6k43u8FClkGUTRmj
        AICpbiG1lgV2WCtgscOWL8rRwsLTwLX1Jcs7tcm5wOcWmECSLO5UJlILhCWYbnMGA3g4Zw
        5wylOPaao+bwcFnKJSFWJJ+0Tr8+zq+MffUEWGB6sitqx+8gpl+w0uhWRLyPaiEKbiU7e4
        javuLQ7ssYiN7prmRcyv2ELaZ+t437jlqm9QUGxVpiLTx8z1RGO10CwVB/X06H9uDT30rH
        XLaPpr6r3PuvRl1SPTEL7IFwbT/6XKru46bl9VC+z9w/BZVCkX/kqvpic174vg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1605719896;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GmxCj/7ZnJBKISZdax6TrGFzzg4ya64APGcVFhXUJww=;
        b=ZFYcSOE0Qqk+9tuBL0cbhJ+OdbS+8caMw/oq39yCTG+ENG1IM0kzOEEZmhEob2DCuSPp0h
        j6eS/A4/qHVdQ5Dw==
From:   "tip-bot2 for Dave Hansen" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/sgx] x86/sgx: Clarify 'laundry_list' locking
Cc:     Jarkko Sakkinen <jarkko@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Borislav Petkov <bp@suse.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20201116222531.4834-1-dave.hansen@intel.com>
References: <20201116222531.4834-1-dave.hansen@intel.com>
MIME-Version: 1.0
Message-ID: <160571989541.11244.7999952600961117627.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/sgx branch of tip:

Commit-ID:     67655b57f8f59467506463055d9a8398d2836377
Gitweb:        https://git.kernel.org/tip/67655b57f8f59467506463055d9a8398d2836377
Author:        Dave Hansen <dave.hansen@linux.intel.com>
AuthorDate:    Mon, 16 Nov 2020 14:25:31 -08:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Wed, 18 Nov 2020 18:16:28 +01:00

x86/sgx: Clarify 'laundry_list' locking

Short Version:

The SGX section->laundry_list structure is effectively thread-local, but
declared next to some shared structures. Its semantics are clear as mud.
Fix that. No functional changes. Compile tested only.

Long Version:

The SGX hardware keeps per-page metadata. This can provide things like
permissions, integrity and replay protection. It also prevents things
like having an enclave page mapped multiple times or shared between
enclaves.

But, that presents a problem for kexec()'d kernels (or any other kernel
that does not run immediately after a hardware reset). This is because
the last kernel may have been rude and forgotten to reset pages, which
would trigger the "shared page" sanity check.

To fix this, the SGX code "launders" the pages by running the EREMOVE
instruction on all pages at boot. This is slow and can take a long
time, so it is performed off in the SGX-specific ksgxd instead of being
synchronous at boot. The init code hands the list of pages to launder in
a per-SGX-section list: ->laundry_list. The only code to touch this list
is the init code and ksgxd. This means that no locking is necessary for
->laundry_list.

However, a lock is required for section->page_list, which is accessed
while creating enclaves and by ksgxd. This lock (section->lock) is
acquired by ksgxd while also processing ->laundry_list. It is easy to
confuse the purpose of the locking as being for ->laundry_list and
->page_list.

Rename ->laundry_list to ->init_laundry_list to make it clear that this
is not normally used at runtime. Also add some comments clarifying the
locking, and reorganize 'sgx_epc_section' to put 'lock' near the things
it protects.

Note: init_laundry_list is 128 bytes of wasted space at runtime. It
could theoretically be dynamically allocated and then freed after
the laundering process. But it would take nearly 128 bytes of extra
instructions to do that.

Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lkml.kernel.org/r/20201116222531.4834-1-dave.hansen@intel.com
---
 arch/x86/kernel/cpu/sgx/main.c | 14 ++++++++------
 arch/x86/kernel/cpu/sgx/sgx.h  | 15 ++++++++++++---
 2 files changed, 20 insertions(+), 9 deletions(-)

diff --git a/arch/x86/kernel/cpu/sgx/main.c b/arch/x86/kernel/cpu/sgx/main.c
index 3426785..c519fc5 100644
--- a/arch/x86/kernel/cpu/sgx/main.c
+++ b/arch/x86/kernel/cpu/sgx/main.c
@@ -36,13 +36,15 @@ static void sgx_sanitize_section(struct sgx_epc_section *section)
 	LIST_HEAD(dirty);
 	int ret;
 
-	while (!list_empty(&section->laundry_list)) {
+	/* init_laundry_list is thread-local, no need for a lock: */
+	while (!list_empty(&section->init_laundry_list)) {
 		if (kthread_should_stop())
 			return;
 
+		/* needed for access to ->page_list: */
 		spin_lock(&section->lock);
 
-		page = list_first_entry(&section->laundry_list,
+		page = list_first_entry(&section->init_laundry_list,
 					struct sgx_epc_page, list);
 
 		ret = __eremove(sgx_get_epc_virt_addr(page));
@@ -56,7 +58,7 @@ static void sgx_sanitize_section(struct sgx_epc_section *section)
 		cond_resched();
 	}
 
-	list_splice(&dirty, &section->laundry_list);
+	list_splice(&dirty, &section->init_laundry_list);
 }
 
 static bool sgx_reclaimer_age(struct sgx_epc_page *epc_page)
@@ -418,7 +420,7 @@ static int ksgxd(void *p)
 		sgx_sanitize_section(&sgx_epc_sections[i]);
 
 		/* Should never happen. */
-		if (!list_empty(&sgx_epc_sections[i].laundry_list))
+		if (!list_empty(&sgx_epc_sections[i].init_laundry_list))
 			WARN(1, "EPC section %d has unsanitized pages.\n", i);
 	}
 
@@ -635,13 +637,13 @@ static bool __init sgx_setup_epc_section(u64 phys_addr, u64 size,
 	section->phys_addr = phys_addr;
 	spin_lock_init(&section->lock);
 	INIT_LIST_HEAD(&section->page_list);
-	INIT_LIST_HEAD(&section->laundry_list);
+	INIT_LIST_HEAD(&section->init_laundry_list);
 
 	for (i = 0; i < nr_pages; i++) {
 		section->pages[i].section = index;
 		section->pages[i].flags = 0;
 		section->pages[i].owner = NULL;
-		list_add_tail(&section->pages[i].list, &section->laundry_list);
+		list_add_tail(&section->pages[i].list, &section->init_laundry_list);
 	}
 
 	section->free_cnt = nr_pages;
diff --git a/arch/x86/kernel/cpu/sgx/sgx.h b/arch/x86/kernel/cpu/sgx/sgx.h
index a188a68..5fa42d1 100644
--- a/arch/x86/kernel/cpu/sgx/sgx.h
+++ b/arch/x86/kernel/cpu/sgx/sgx.h
@@ -34,15 +34,24 @@ struct sgx_epc_page {
  * physical memory e.g. for memory areas of the each node. This structure is
  * used to store EPC pages for one EPC section and virtual memory area where
  * the pages have been mapped.
+ *
+ * 'lock' must be held before accessing 'page_list' or 'free_cnt'.
  */
 struct sgx_epc_section {
 	unsigned long phys_addr;
 	void *virt_addr;
-	struct list_head page_list;
-	struct list_head laundry_list;
 	struct sgx_epc_page *pages;
-	unsigned long free_cnt;
+
 	spinlock_t lock;
+	struct list_head page_list;
+	unsigned long free_cnt;
+
+	/*
+	 * Pages which need EREMOVE run on them before they can be
+	 * used.  Only safe to be accessed in ksgxd and init code.
+	 * Not protected by locks.
+	 */
+	struct list_head init_laundry_list;
 };
 
 extern struct sgx_epc_section sgx_epc_sections[SGX_MAX_EPC_SECTIONS];
