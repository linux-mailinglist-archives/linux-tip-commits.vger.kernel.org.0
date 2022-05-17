Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2C3752AA4B
	for <lists+linux-tip-commits@lfdr.de>; Tue, 17 May 2022 20:14:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352074AbiEQSOA (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Tue, 17 May 2022 14:14:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352082AbiEQSME (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Tue, 17 May 2022 14:12:04 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 600421FA68;
        Tue, 17 May 2022 11:12:03 -0700 (PDT)
Date:   Tue, 17 May 2022 18:12:00 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1652811121;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UxD8CS6pMeck4OJaVT0KbFkUCie2agGd4iD7l0qWSNE=;
        b=kKpx4guuA83kfoe2x2nXny1WfEl1a9DlZEZRCCMvohbv6DRuSIiBIGsm5BvSUnjyYcFLs+
        VbuxFYT9lrZSEZt3Wqiw9krCYcyfDeKEpfO6yFlIyK/ybvm8b7M3X1g2CrTPCSr7+jmhuj
        hAUz2fRdpTrm4GBrpCs8uy5tshDd/eyKwPwt5fppnaKD1GDLSzIyR3clU5MGCnOwvuRryV
        MODrFmlqDx5EzAhPJtW17bFJxCKu4Mdx4ApsZxcGIViWAxy5Kz0pPgHxpeF3+h6k7gibMZ
        PiTX9gteRcyF8WihCOryNItehSAZaoF31PrSnX/vEvdomDeG9cRVFuf0gme9Hg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1652811121;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UxD8CS6pMeck4OJaVT0KbFkUCie2agGd4iD7l0qWSNE=;
        b=n8jFSzRST4GieyTeuelzewgSY+rYg+AibyBBKXkGbvQvJpRMbNgsS5nKgiQ3EOBjkdQx3M
        5zzh5u7jwBErF5Bg==
From:   "tip-bot2 for Reinette Chatre" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/sgx] x86/sgx: Fix race between reclaimer and page fault handler
Cc:     stable@vger.kernel.org, Haitao Huang <haitao.huang@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Jarkko Sakkinen <jarkko@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: =?utf-8?q?=3Ced20a5db516aa813873268e125680041ae11dfcf=2E16523?=
 =?utf-8?q?89823=2Egit=2Ereinette=2Echatre=40intel=2Ecom=3E?=
References: =?utf-8?q?=3Ced20a5db516aa813873268e125680041ae11dfcf=2E165238?=
 =?utf-8?q?9823=2Egit=2Ereinette=2Echatre=40intel=2Ecom=3E?=
MIME-Version: 1.0
Message-ID: <165281112043.4207.5882169061890771904.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/sgx branch of tip:

Commit-ID:     af117837ceb9a78e995804ade4726ad2c2c8981f
Gitweb:        https://git.kernel.org/tip/af117837ceb9a78e995804ade4726ad2c2c8981f
Author:        Reinette Chatre <reinette.chatre@intel.com>
AuthorDate:    Thu, 12 May 2022 14:51:00 -07:00
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Mon, 16 May 2022 15:17:39 -07:00

x86/sgx: Fix race between reclaimer and page fault handler

Haitao reported encountering a WARN triggered by the ENCLS[ELDU]
instruction faulting with a #GP.

The WARN is encountered when the reclaimer evicts a range of
pages from the enclave when the same pages are faulted back right away.

Consider two enclave pages (ENCLAVE_A and ENCLAVE_B)
sharing a PCMD page (PCMD_AB). ENCLAVE_A is in the
enclave memory and ENCLAVE_B is in the backing store. PCMD_AB contains
just one entry, that of ENCLAVE_B.

Scenario proceeds where ENCLAVE_A is being evicted from the enclave
while ENCLAVE_B is faulted in.

sgx_reclaim_pages() {

  ...

  /*
   * Reclaim ENCLAVE_A
   */
  mutex_lock(&encl->lock);
  /*
   * Get a reference to ENCLAVE_A's
   * shmem page where enclave page
   * encrypted data will be stored
   * as well as a reference to the
   * enclave page's PCMD data page,
   * PCMD_AB.
   * Release mutex before writing
   * any data to the shmem pages.
   */
  sgx_encl_get_backing(...);
  encl_page->desc |= SGX_ENCL_PAGE_BEING_RECLAIMED;
  mutex_unlock(&encl->lock);

                                    /*
                                     * Fault ENCLAVE_B
                                     */

                                    sgx_vma_fault() {

                                      mutex_lock(&encl->lock);
                                      /*
                                       * Get reference to
                                       * ENCLAVE_B's shmem page
                                       * as well as PCMD_AB.
                                       */
                                      sgx_encl_get_backing(...)
                                     /*
                                      * Load page back into
                                      * enclave via ELDU.
                                      */
                                     /*
                                      * Release reference to
                                      * ENCLAVE_B' shmem page and
                                      * PCMD_AB.
                                      */
                                     sgx_encl_put_backing(...);
                                     /*
                                      * PCMD_AB is found empty so
                                      * it and ENCLAVE_B's shmem page
                                      * are truncated.
                                      */
                                     /* Truncate ENCLAVE_B backing page */
                                     sgx_encl_truncate_backing_page();
                                     /* Truncate PCMD_AB */
                                     sgx_encl_truncate_backing_page();

                                     mutex_unlock(&encl->lock);

                                     ...
                                     }
  mutex_lock(&encl->lock);
  encl_page->desc &=
       ~SGX_ENCL_PAGE_BEING_RECLAIMED;
  /*
  * Write encrypted contents of
  * ENCLAVE_A to ENCLAVE_A shmem
  * page and its PCMD data to
  * PCMD_AB.
  */
  sgx_encl_put_backing(...)

  /*
   * Reference to PCMD_AB is
   * dropped and it is truncated.
   * ENCLAVE_A's PCMD data is lost.
   */
  mutex_unlock(&encl->lock);
}

What happens next depends on whether it is ENCLAVE_A being faulted
in or ENCLAVE_B being evicted - but both end up with ENCLS[ELDU] faulting
with a #GP.

If ENCLAVE_A is faulted then at the time sgx_encl_get_backing() is called
a new PCMD page is allocated and providing the empty PCMD data for
ENCLAVE_A would cause ENCLS[ELDU] to #GP

If ENCLAVE_B is evicted first then a new PCMD_AB would be allocated by the
reclaimer but later when ENCLAVE_A is faulted the ENCLS[ELDU] instruction
would #GP during its checks of the PCMD value and the WARN would be
encountered.

Noting that the reclaimer sets SGX_ENCL_PAGE_BEING_RECLAIMED at the time
it obtains a reference to the backing store pages of an enclave page it
is in the process of reclaiming, fix the race by only truncating the PCMD
page after ensuring that no page sharing the PCMD page is in the process
of being reclaimed.

Cc: stable@vger.kernel.org
Fixes: 08999b2489b4 ("x86/sgx: Free backing memory after faulting the enclave page")
Reported-by: Haitao Huang <haitao.huang@intel.com>
Signed-off-by: Reinette Chatre <reinette.chatre@intel.com>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>
Tested-by: Haitao Huang <haitao.huang@intel.com>
Link: https://lkml.kernel.org/r/ed20a5db516aa813873268e125680041ae11dfcf.1652389823.git.reinette.chatre@intel.com
---
 arch/x86/kernel/cpu/sgx/encl.c | 94 ++++++++++++++++++++++++++++++++-
 1 file changed, 93 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/cpu/sgx/encl.c b/arch/x86/kernel/cpu/sgx/encl.c
index 5104a42..243f3bd 100644
--- a/arch/x86/kernel/cpu/sgx/encl.c
+++ b/arch/x86/kernel/cpu/sgx/encl.c
@@ -12,6 +12,92 @@
 #include "encls.h"
 #include "sgx.h"
 
+#define PCMDS_PER_PAGE (PAGE_SIZE / sizeof(struct sgx_pcmd))
+/*
+ * 32 PCMD entries share a PCMD page. PCMD_FIRST_MASK is used to
+ * determine the page index associated with the first PCMD entry
+ * within a PCMD page.
+ */
+#define PCMD_FIRST_MASK GENMASK(4, 0)
+
+/**
+ * reclaimer_writing_to_pcmd() - Query if any enclave page associated with
+ *                               a PCMD page is in process of being reclaimed.
+ * @encl:        Enclave to which PCMD page belongs
+ * @start_addr:  Address of enclave page using first entry within the PCMD page
+ *
+ * When an enclave page is reclaimed some Paging Crypto MetaData (PCMD) is
+ * stored. The PCMD data of a reclaimed enclave page contains enough
+ * information for the processor to verify the page at the time
+ * it is loaded back into the Enclave Page Cache (EPC).
+ *
+ * The backing storage to which enclave pages are reclaimed is laid out as
+ * follows:
+ * Encrypted enclave pages:SECS page:PCMD pages
+ *
+ * Each PCMD page contains the PCMD metadata of
+ * PAGE_SIZE/sizeof(struct sgx_pcmd) enclave pages.
+ *
+ * A PCMD page can only be truncated if it is (a) empty, and (b) not in the
+ * process of getting data (and thus soon being non-empty). (b) is tested with
+ * a check if an enclave page sharing the PCMD page is in the process of being
+ * reclaimed.
+ *
+ * The reclaimer sets the SGX_ENCL_PAGE_BEING_RECLAIMED flag when it
+ * intends to reclaim that enclave page - it means that the PCMD page
+ * associated with that enclave page is about to get some data and thus
+ * even if the PCMD page is empty, it should not be truncated.
+ *
+ * Context: Enclave mutex (&sgx_encl->lock) must be held.
+ * Return: 1 if the reclaimer is about to write to the PCMD page
+ *         0 if the reclaimer has no intention to write to the PCMD page
+ */
+static int reclaimer_writing_to_pcmd(struct sgx_encl *encl,
+				     unsigned long start_addr)
+{
+	int reclaimed = 0;
+	int i;
+
+	/*
+	 * PCMD_FIRST_MASK is based on number of PCMD entries within
+	 * PCMD page being 32.
+	 */
+	BUILD_BUG_ON(PCMDS_PER_PAGE != 32);
+
+	for (i = 0; i < PCMDS_PER_PAGE; i++) {
+		struct sgx_encl_page *entry;
+		unsigned long addr;
+
+		addr = start_addr + i * PAGE_SIZE;
+
+		/*
+		 * Stop when reaching the SECS page - it does not
+		 * have a page_array entry and its reclaim is
+		 * started and completed with enclave mutex held so
+		 * it does not use the SGX_ENCL_PAGE_BEING_RECLAIMED
+		 * flag.
+		 */
+		if (addr == encl->base + encl->size)
+			break;
+
+		entry = xa_load(&encl->page_array, PFN_DOWN(addr));
+		if (!entry)
+			continue;
+
+		/*
+		 * VA page slot ID uses same bit as the flag so it is important
+		 * to ensure that the page is not already in backing store.
+		 */
+		if (entry->epc_page &&
+		    (entry->desc & SGX_ENCL_PAGE_BEING_RECLAIMED)) {
+			reclaimed = 1;
+			break;
+		}
+	}
+
+	return reclaimed;
+}
+
 /*
  * Calculate byte offset of a PCMD struct associated with an enclave page. PCMD's
  * follow right after the EPC data in the backing storage. In addition to the
@@ -47,6 +133,7 @@ static int __sgx_encl_eldu(struct sgx_encl_page *encl_page,
 	unsigned long va_offset = encl_page->desc & SGX_ENCL_PAGE_VA_OFFSET_MASK;
 	struct sgx_encl *encl = encl_page->encl;
 	pgoff_t page_index, page_pcmd_off;
+	unsigned long pcmd_first_page;
 	struct sgx_pageinfo pginfo;
 	struct sgx_backing b;
 	bool pcmd_page_empty;
@@ -58,6 +145,11 @@ static int __sgx_encl_eldu(struct sgx_encl_page *encl_page,
 	else
 		page_index = PFN_DOWN(encl->size);
 
+	/*
+	 * Address of enclave page using the first entry within the PCMD page.
+	 */
+	pcmd_first_page = PFN_PHYS(page_index & ~PCMD_FIRST_MASK) + encl->base;
+
 	page_pcmd_off = sgx_encl_get_backing_page_pcmd_offset(encl, page_index);
 
 	ret = sgx_encl_get_backing(encl, page_index, &b);
@@ -99,7 +191,7 @@ static int __sgx_encl_eldu(struct sgx_encl_page *encl_page,
 
 	sgx_encl_truncate_backing_page(encl, page_index);
 
-	if (pcmd_page_empty)
+	if (pcmd_page_empty && !reclaimer_writing_to_pcmd(encl, pcmd_first_page))
 		sgx_encl_truncate_backing_page(encl, PFN_DOWN(page_pcmd_off));
 
 	return ret;
