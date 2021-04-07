Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6AAA13568CD
	for <lists+linux-tip-commits@lfdr.de>; Wed,  7 Apr 2021 12:05:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350642AbhDGKE1 (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 7 Apr 2021 06:04:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350521AbhDGKDq (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 7 Apr 2021 06:03:46 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE5FEC0613D8;
        Wed,  7 Apr 2021 03:03:35 -0700 (PDT)
Date:   Wed, 07 Apr 2021 10:03:33 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1617789814;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cb007RPHgSSNi0Th4jIljdIL0ETcH2H74l7sGWOOfEM=;
        b=eZz7Har5xcTue4D6tsoXXknK6bDcsH8ZnaJnOA41JUyz+o1xBpHs/R8NqPQnflc86DIbtV
        LFZG3yB90x6Us2Vbb/hf+a3X27tN/KaQh3zou5v31eJBvOWjPzm3+916ko5sbNQKDdKSDL
        ra64ciNS/2zvXsgFWVjRUl46cbYARyK5FNS1KoXxQiK+/KC05ijFKcJ3wvIzmVhG46d7HC
        LM9P9H0TOss16N3vj1gorZ3X7RbCkPHgCxPY6Eezxwx7KWw/Hi7MCt9fV+SoWKLBoce1gt
        8kKArlUNStsVKlGMBISMTS1zR3VdaD435qa4VxFmMtsDkT0HN7A/D3yLHnGgkA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1617789814;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cb007RPHgSSNi0Th4jIljdIL0ETcH2H74l7sGWOOfEM=;
        b=i/fZGxsH3xw8SpnQ24M39KGJXTdM+oOd+Q67l4HO+hEC+BHjwx3kTxp0o6wTBMjcaDpvjS
        8WSDT2v4pgL3s/Dw==
From:   "tip-bot2 for Kai Huang" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/sgx] x86/sgx: Wipe out EREMOVE from sgx_free_epc_page()
Cc:     Kai Huang <kai.huang@intel.com>, Borislav Petkov <bp@suse.de>,
        Jarkko Sakkinen <jarkko@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210325093057.122834-1-kai.huang@intel.com>
References: <20210325093057.122834-1-kai.huang@intel.com>
MIME-Version: 1.0
Message-ID: <161778981394.29796.17762035834140723497.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/sgx branch of tip:

Commit-ID:     b0c7459be0670fabe080e30906ba9fe62df5e02c
Gitweb:        https://git.kernel.org/tip/b0c7459be0670fabe080e30906ba9fe62df5e02c
Author:        Kai Huang <kai.huang@intel.com>
AuthorDate:    Thu, 25 Mar 2021 22:30:57 +13:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Fri, 26 Mar 2021 22:51:23 +01:00

x86/sgx: Wipe out EREMOVE from sgx_free_epc_page()

EREMOVE takes a page and removes any association between that page and
an enclave. It must be run on a page before it can be added into another
enclave. Currently, EREMOVE is run as part of pages being freed into the
SGX page allocator. It is not expected to fail, as it would indicate a
use-after-free of EPC pages. Rather than add the page back to the pool
of available EPC pages, the kernel intentionally leaks the page to avoid
additional errors in the future.

However, KVM does not track how guest pages are used, which means that
SGX virtualization use of EREMOVE might fail. Specifically, it is
legitimate that EREMOVE returns SGX_CHILD_PRESENT for EPC assigned to
KVM guest, because KVM/kernel doesn't track SECS pages.

To allow SGX/KVM to introduce a more permissive EREMOVE helper and
to let the SGX virtualization code use the allocator directly, break
out the EREMOVE call from the SGX page allocator. Rename the original
sgx_free_epc_page() to sgx_encl_free_epc_page(), indicating that
it is used to free an EPC page assigned to a host enclave. Replace
sgx_free_epc_page() with sgx_encl_free_epc_page() in all call sites so
there's no functional change.

At the same time, improve the error message when EREMOVE fails, and
add documentation to explain to the user what that failure means and
to suggest to the user what to do when this bug happens in the case it
happens.

 [ bp: Massage commit message, fix typos and sanitize text, simplify. ]

Signed-off-by: Kai Huang <kai.huang@intel.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>
Link: https://lkml.kernel.org/r/20210325093057.122834-1-kai.huang@intel.com
---
 Documentation/x86/sgx.rst       | 25 +++++++++++++++++++++++++
 arch/x86/kernel/cpu/sgx/encl.c  | 31 ++++++++++++++++++++++++++-----
 arch/x86/kernel/cpu/sgx/encl.h  |  1 +
 arch/x86/kernel/cpu/sgx/ioctl.c |  6 +++---
 arch/x86/kernel/cpu/sgx/main.c  | 14 +++++---------
 arch/x86/kernel/cpu/sgx/sgx.h   |  4 ++++
 6 files changed, 64 insertions(+), 17 deletions(-)

diff --git a/Documentation/x86/sgx.rst b/Documentation/x86/sgx.rst
index eaee136..f90076e 100644
--- a/Documentation/x86/sgx.rst
+++ b/Documentation/x86/sgx.rst
@@ -209,3 +209,28 @@ An application may be loaded into a container enclave which is specially
 configured with a library OS and run-time which permits the application to run.
 The enclave run-time and library OS work together to execute the application
 when a thread enters the enclave.
+
+Impact of Potential Kernel SGX Bugs
+===================================
+
+EPC leaks
+---------
+
+When EPC page leaks happen, a WARNING like this is shown in dmesg:
+
+"EREMOVE returned ... and an EPC page was leaked.  SGX may become unusable..."
+
+This is effectively a kernel use-after-free of an EPC page, and due
+to the way SGX works, the bug is detected at freeing. Rather than
+adding the page back to the pool of available EPC pages, the kernel
+intentionally leaks the page to avoid additional errors in the future.
+
+When this happens, the kernel will likely soon leak more EPC pages, and
+SGX will likely become unusable because the memory available to SGX is
+limited. However, while this may be fatal to SGX, the rest of the kernel
+is unlikely to be impacted and should continue to work.
+
+As a result, when this happpens, user should stop running any new
+SGX workloads, (or just any new workloads), and migrate all valuable
+workloads. Although a machine reboot can recover all EPC memory, the bug
+should be reported to Linux developers.
diff --git a/arch/x86/kernel/cpu/sgx/encl.c b/arch/x86/kernel/cpu/sgx/encl.c
index 7449ef3..d25f2a2 100644
--- a/arch/x86/kernel/cpu/sgx/encl.c
+++ b/arch/x86/kernel/cpu/sgx/encl.c
@@ -78,7 +78,7 @@ static struct sgx_epc_page *sgx_encl_eldu(struct sgx_encl_page *encl_page,
 
 	ret = __sgx_encl_eldu(encl_page, epc_page, secs_page);
 	if (ret) {
-		sgx_free_epc_page(epc_page);
+		sgx_encl_free_epc_page(epc_page);
 		return ERR_PTR(ret);
 	}
 
@@ -404,7 +404,7 @@ void sgx_encl_release(struct kref *ref)
 			if (sgx_unmark_page_reclaimable(entry->epc_page))
 				continue;
 
-			sgx_free_epc_page(entry->epc_page);
+			sgx_encl_free_epc_page(entry->epc_page);
 			encl->secs_child_cnt--;
 			entry->epc_page = NULL;
 		}
@@ -415,7 +415,7 @@ void sgx_encl_release(struct kref *ref)
 	xa_destroy(&encl->page_array);
 
 	if (!encl->secs_child_cnt && encl->secs.epc_page) {
-		sgx_free_epc_page(encl->secs.epc_page);
+		sgx_encl_free_epc_page(encl->secs.epc_page);
 		encl->secs.epc_page = NULL;
 	}
 
@@ -423,7 +423,7 @@ void sgx_encl_release(struct kref *ref)
 		va_page = list_first_entry(&encl->va_pages, struct sgx_va_page,
 					   list);
 		list_del(&va_page->list);
-		sgx_free_epc_page(va_page->epc_page);
+		sgx_encl_free_epc_page(va_page->epc_page);
 		kfree(va_page);
 	}
 
@@ -686,7 +686,7 @@ struct sgx_epc_page *sgx_alloc_va_page(void)
 	ret = __epa(sgx_get_epc_virt_addr(epc_page));
 	if (ret) {
 		WARN_ONCE(1, "EPA returned %d (0x%x)", ret, ret);
-		sgx_free_epc_page(epc_page);
+		sgx_encl_free_epc_page(epc_page);
 		return ERR_PTR(-EFAULT);
 	}
 
@@ -735,3 +735,24 @@ bool sgx_va_page_full(struct sgx_va_page *va_page)
 
 	return slot == SGX_VA_SLOT_COUNT;
 }
+
+/**
+ * sgx_encl_free_epc_page - free an EPC page assigned to an enclave
+ * @page:	EPC page to be freed
+ *
+ * Free an EPC page assigned to an enclave. It does EREMOVE for the page, and
+ * only upon success, it puts the page back to free page list.  Otherwise, it
+ * gives a WARNING to indicate page is leaked.
+ */
+void sgx_encl_free_epc_page(struct sgx_epc_page *page)
+{
+	int ret;
+
+	WARN_ON_ONCE(page->flags & SGX_EPC_PAGE_RECLAIMER_TRACKED);
+
+	ret = __eremove(sgx_get_epc_virt_addr(page));
+	if (WARN_ONCE(ret, EREMOVE_ERROR_MESSAGE, ret, ret))
+		return;
+
+	sgx_free_epc_page(page);
+}
diff --git a/arch/x86/kernel/cpu/sgx/encl.h b/arch/x86/kernel/cpu/sgx/encl.h
index d8d30cc..6e74f85 100644
--- a/arch/x86/kernel/cpu/sgx/encl.h
+++ b/arch/x86/kernel/cpu/sgx/encl.h
@@ -115,5 +115,6 @@ struct sgx_epc_page *sgx_alloc_va_page(void);
 unsigned int sgx_alloc_va_slot(struct sgx_va_page *va_page);
 void sgx_free_va_slot(struct sgx_va_page *va_page, unsigned int offset);
 bool sgx_va_page_full(struct sgx_va_page *va_page);
+void sgx_encl_free_epc_page(struct sgx_epc_page *page);
 
 #endif /* _X86_ENCL_H */
diff --git a/arch/x86/kernel/cpu/sgx/ioctl.c b/arch/x86/kernel/cpu/sgx/ioctl.c
index 2e10367..354e309 100644
--- a/arch/x86/kernel/cpu/sgx/ioctl.c
+++ b/arch/x86/kernel/cpu/sgx/ioctl.c
@@ -47,7 +47,7 @@ static void sgx_encl_shrink(struct sgx_encl *encl, struct sgx_va_page *va_page)
 	encl->page_cnt--;
 
 	if (va_page) {
-		sgx_free_epc_page(va_page->epc_page);
+		sgx_encl_free_epc_page(va_page->epc_page);
 		list_del(&va_page->list);
 		kfree(va_page);
 	}
@@ -117,7 +117,7 @@ static int sgx_encl_create(struct sgx_encl *encl, struct sgx_secs *secs)
 	return 0;
 
 err_out:
-	sgx_free_epc_page(encl->secs.epc_page);
+	sgx_encl_free_epc_page(encl->secs.epc_page);
 	encl->secs.epc_page = NULL;
 
 err_out_backing:
@@ -365,7 +365,7 @@ err_out_unlock:
 	mmap_read_unlock(current->mm);
 
 err_out_free:
-	sgx_free_epc_page(epc_page);
+	sgx_encl_free_epc_page(epc_page);
 	kfree(encl_page);
 
 	return ret;
diff --git a/arch/x86/kernel/cpu/sgx/main.c b/arch/x86/kernel/cpu/sgx/main.c
index 13a7599..b227629 100644
--- a/arch/x86/kernel/cpu/sgx/main.c
+++ b/arch/x86/kernel/cpu/sgx/main.c
@@ -294,7 +294,7 @@ static void sgx_reclaimer_write(struct sgx_epc_page *epc_page,
 
 		sgx_encl_ewb(encl->secs.epc_page, &secs_backing);
 
-		sgx_free_epc_page(encl->secs.epc_page);
+		sgx_encl_free_epc_page(encl->secs.epc_page);
 		encl->secs.epc_page = NULL;
 
 		sgx_encl_put_backing(&secs_backing, true);
@@ -609,19 +609,15 @@ struct sgx_epc_page *sgx_alloc_epc_page(void *owner, bool reclaim)
  * sgx_free_epc_page() - Free an EPC page
  * @page:	an EPC page
  *
- * Call EREMOVE for an EPC page and insert it back to the list of free pages.
+ * Put the EPC page back to the list of free pages. It's the caller's
+ * responsibility to make sure that the page is in uninitialized state. In other
+ * words, do EREMOVE, EWB or whatever operation is necessary before calling
+ * this function.
  */
 void sgx_free_epc_page(struct sgx_epc_page *page)
 {
 	struct sgx_epc_section *section = &sgx_epc_sections[page->section];
 	struct sgx_numa_node *node = section->node;
-	int ret;
-
-	WARN_ON_ONCE(page->flags & SGX_EPC_PAGE_RECLAIMER_TRACKED);
-
-	ret = __eremove(sgx_get_epc_virt_addr(page));
-	if (WARN_ONCE(ret, "EREMOVE returned %d (0x%x)", ret, ret))
-		return;
 
 	spin_lock(&node->lock);
 
diff --git a/arch/x86/kernel/cpu/sgx/sgx.h b/arch/x86/kernel/cpu/sgx/sgx.h
index 653af8c..4aa40c6 100644
--- a/arch/x86/kernel/cpu/sgx/sgx.h
+++ b/arch/x86/kernel/cpu/sgx/sgx.h
@@ -13,6 +13,10 @@
 #undef pr_fmt
 #define pr_fmt(fmt) "sgx: " fmt
 
+#define EREMOVE_ERROR_MESSAGE \
+	"EREMOVE returned %d (0x%x) and an EPC page was leaked. SGX may become unusable. " \
+	"Refer to Documentation/x86/sgx.rst for more information."
+
 #define SGX_MAX_EPC_SECTIONS		8
 #define SGX_EEXTEND_BLOCK_SIZE		256
 #define SGX_NR_TO_SCAN			16
