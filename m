Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BC9280AA76
	for <lists+linux-tip-commits@lfdr.de>; Fri,  8 Dec 2023 18:18:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236024AbjLHRSE (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 8 Dec 2023 12:18:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1574474AbjLHRRj (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 8 Dec 2023 12:17:39 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1992485;
        Fri,  8 Dec 2023 09:17:27 -0800 (PST)
Date:   Fri, 08 Dec 2023 17:17:24 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1702055845;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=1rT7BtT0hiPEj1SNFoJ0eEct+pT2IJLMp5XyDw/ORrw=;
        b=QK688Irg75bmkDWBzuxyiE4+IUj2cLmDV0XrBp3S56OCqnKdo31MY1WoK6bqvb9/JRn20+
        d0hV2I9aPsBKbHR8h2VycBkfWdgqywz/VEdpSUwN5clC800m7KFuZmbS9TmrxVpXSgetZM
        Hv8JknmS6rHrrpRI8O6xFUL2BMrqoVf8z7fGgVwyBoYYLSrRe9NILXR1CuGVfbPYHr4jiH
        p2xN4dIoS7Z6Misia5DBEice79tpZBNpaRuiKDU1B4r1QYRrCupdfT8fVaD/Urax3/SwsG
        jZyvzwV6VLpsd7kKZ0jGd+DtpsvZVJrEGaMI+SfZ9ZkkJ3OTCda+L8E5s0IZyg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1702055845;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=1rT7BtT0hiPEj1SNFoJ0eEct+pT2IJLMp5XyDw/ORrw=;
        b=dpV63HCv/EQLcL2t8LP9XYP57wKi+Emz5jMPkRSn6Wuo+5KMKCKPLmVDOMsxm/Bny0yILp
        eYBwfRzmcaGRIRBA==
From:   "tip-bot2 for Kai Huang" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/tdx] x86/virt/tdx: Add placeholder to construct TDMRs to
 cover all TDX memory regions
Cc:     Kai Huang <kai.huang@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Isaku Yamahata <isaku.yamahata@intel.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        x86@kernel.org, linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <170205584483.398.1233742344847855738.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/tdx branch of tip:

Commit-ID:     5173d3c5d018161aca17d4ac95367cf832c7fff1
Gitweb:        https://git.kernel.org/tip/5173d3c5d018161aca17d4ac95367cf832c7fff1
Author:        Kai Huang <kai.huang@intel.com>
AuthorDate:    Fri, 08 Dec 2023 09:07:29 -08:00
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Fri, 08 Dec 2023 09:12:32 -08:00

x86/virt/tdx: Add placeholder to construct TDMRs to cover all TDX memory regions

After the kernel selects all TDX-usable memory regions, the kernel needs
to pass those regions to the TDX module via data structure "TD Memory
Region" (TDMR).

Add a placeholder to construct a list of TDMRs (in multiple steps) to
cover all TDX-usable memory regions.

=== Long Version ===

TDX provides increased levels of memory confidentiality and integrity.
This requires special hardware support for features like memory
encryption and storage of memory integrity checksums.  Not all memory
satisfies these requirements.

As a result, TDX introduced the concept of a "Convertible Memory Region"
(CMR).  During boot, the firmware builds a list of all of the memory
ranges which can provide the TDX security guarantees.  The list of these
ranges is available to the kernel by querying the TDX module.

The TDX architecture needs additional metadata to record things like
which TD guest "owns" a given page of memory.  This metadata essentially
serves as the 'struct page' for the TDX module.  The space for this
metadata is not reserved by the hardware up front and must be allocated
by the kernel and given to the TDX module.

Since this metadata consumes space, the VMM can choose whether or not to
allocate it for a given area of convertible memory.  If it chooses not
to, the memory cannot receive TDX protections and can not be used by TDX
guests as private memory.

For every memory region that the VMM wants to use as TDX memory, it sets
up a "TD Memory Region" (TDMR).  Each TDMR represents a physically
contiguous convertible range and must also have its own physically
contiguous metadata table, referred to as a Physical Address Metadata
Table (PAMT), to track status for each page in the TDMR range.

Unlike a CMR, each TDMR requires 1G granularity and alignment.  To
support physical RAM areas that don't meet those strict requirements,
each TDMR permits a number of internal "reserved areas" which can be
placed over memory holes.  If PAMT metadata is placed within a TDMR it
must be covered by one of these reserved areas.

Let's summarize the concepts:

 CMR - Firmware-enumerated physical ranges that support TDX.  CMRs are
       4K aligned.
TDMR - Physical address range which is chosen by the kernel to support
       TDX.  1G granularity and alignment required.  Each TDMR has
       reserved areas where TDX memory holes and overlapping PAMTs can
       be represented.
PAMT - Physically contiguous TDX metadata.  One table for each page size
       per TDMR.  Roughly 1/256th of TDMR in size.  256G TDMR = ~1G
       PAMT.

As one step of initializing the TDX module, the kernel configures
TDX-usable memory regions by passing a list of TDMRs to the TDX module.

Constructing the list of TDMRs consists below steps:

1) Fill out TDMRs to cover all memory regions that the TDX module will
   use for TD memory.
2) Allocate and set up PAMT for each TDMR.
3) Designate reserved areas for each TDMR.

Add a placeholder to construct TDMRs to do the above steps.  To keep
things simple, just allocate enough space to hold maximum number of
TDMRs up front.

Signed-off-by: Kai Huang <kai.huang@intel.com>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Reviewed-by: Isaku Yamahata <isaku.yamahata@intel.com>
Reviewed-by: Dave Hansen <dave.hansen@linux.intel.com>
Reviewed-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Link: https://lore.kernel.org/all/20231208170740.53979-9-dave.hansen%40intel.com
---
 arch/x86/virt/vmx/tdx/tdx.c | 93 ++++++++++++++++++++++++++++++++++--
 arch/x86/virt/vmx/tdx/tdx.h | 33 +++++++++++++-
 2 files changed, 123 insertions(+), 3 deletions(-)

diff --git a/arch/x86/virt/vmx/tdx/tdx.c b/arch/x86/virt/vmx/tdx/tdx.c
index e76ad7c..eeb7bf8 100644
--- a/arch/x86/virt/vmx/tdx/tdx.c
+++ b/arch/x86/virt/vmx/tdx/tdx.c
@@ -22,6 +22,7 @@
 #include <linux/minmax.h>
 #include <linux/sizes.h>
 #include <linux/pfn.h>
+#include <linux/align.h>
 #include <asm/msr-index.h>
 #include <asm/msr.h>
 #include <asm/cpufeature.h>
@@ -34,6 +35,8 @@ static u32 tdx_nr_guest_keyids __ro_after_init;
 
 static DEFINE_PER_CPU(bool, tdx_lp_initialized);
 
+static struct tdmr_info_list tdx_tdmr_list;
+
 static enum tdx_module_status_t tdx_module_status;
 static DEFINE_MUTEX(tdx_module_lock);
 
@@ -313,6 +316,80 @@ static int get_tdx_tdmr_sysinfo(struct tdx_tdmr_sysinfo *tdmr_sysinfo)
 	return 0;
 }
 
+/* Calculate the actual TDMR size */
+static int tdmr_size_single(u16 max_reserved_per_tdmr)
+{
+	int tdmr_sz;
+
+	/*
+	 * The actual size of TDMR depends on the maximum
+	 * number of reserved areas.
+	 */
+	tdmr_sz = sizeof(struct tdmr_info);
+	tdmr_sz += sizeof(struct tdmr_reserved_area) * max_reserved_per_tdmr;
+
+	return ALIGN(tdmr_sz, TDMR_INFO_ALIGNMENT);
+}
+
+static int alloc_tdmr_list(struct tdmr_info_list *tdmr_list,
+			   struct tdx_tdmr_sysinfo *tdmr_sysinfo)
+{
+	size_t tdmr_sz, tdmr_array_sz;
+	void *tdmr_array;
+
+	tdmr_sz = tdmr_size_single(tdmr_sysinfo->max_reserved_per_tdmr);
+	tdmr_array_sz = tdmr_sz * tdmr_sysinfo->max_tdmrs;
+
+	/*
+	 * To keep things simple, allocate all TDMRs together.
+	 * The buffer needs to be physically contiguous to make
+	 * sure each TDMR is physically contiguous.
+	 */
+	tdmr_array = alloc_pages_exact(tdmr_array_sz,
+			GFP_KERNEL | __GFP_ZERO);
+	if (!tdmr_array)
+		return -ENOMEM;
+
+	tdmr_list->tdmrs = tdmr_array;
+
+	/*
+	 * Keep the size of TDMR to find the target TDMR
+	 * at a given index in the TDMR list.
+	 */
+	tdmr_list->tdmr_sz = tdmr_sz;
+	tdmr_list->max_tdmrs = tdmr_sysinfo->max_tdmrs;
+	tdmr_list->nr_consumed_tdmrs = 0;
+
+	return 0;
+}
+
+static void free_tdmr_list(struct tdmr_info_list *tdmr_list)
+{
+	free_pages_exact(tdmr_list->tdmrs,
+			tdmr_list->max_tdmrs * tdmr_list->tdmr_sz);
+}
+
+/*
+ * Construct a list of TDMRs on the preallocated space in @tdmr_list
+ * to cover all TDX memory regions in @tmb_list based on the TDX module
+ * TDMR global information in @tdmr_sysinfo.
+ */
+static int construct_tdmrs(struct list_head *tmb_list,
+			   struct tdmr_info_list *tdmr_list,
+			   struct tdx_tdmr_sysinfo *tdmr_sysinfo)
+{
+	/*
+	 * TODO:
+	 *
+	 *  - Fill out TDMRs to cover all TDX memory regions.
+	 *  - Allocate and set up PAMTs for each TDMR.
+	 *  - Designate reserved areas for each TDMR.
+	 *
+	 * Return -EINVAL until constructing TDMRs is done
+	 */
+	return -EINVAL;
+}
+
 static int init_tdx_module(void)
 {
 	struct tdx_tdmr_sysinfo tdmr_sysinfo;
@@ -338,11 +415,19 @@ static int init_tdx_module(void)
 	if (ret)
 		goto err_free_tdxmem;
 
+	/* Allocate enough space for constructing TDMRs */
+	ret = alloc_tdmr_list(&tdx_tdmr_list, &tdmr_sysinfo);
+	if (ret)
+		goto err_free_tdxmem;
+
+	/* Cover all TDX-usable memory regions in TDMRs */
+	ret = construct_tdmrs(&tdx_memlist, &tdx_tdmr_list, &tdmr_sysinfo);
+	if (ret)
+		goto err_free_tdmrs;
+
 	/*
 	 * TODO:
 	 *
-	 *  - Construct a list of TDMRs to cover all TDX-usable memory
-	 *    regions.
 	 *  - Configure the TDMRs and the global KeyID to the TDX module.
 	 *  - Configure the global KeyID on all packages.
 	 *  - Initialize all TDMRs.
@@ -351,7 +436,7 @@ static int init_tdx_module(void)
 	 */
 	ret = -EINVAL;
 	if (ret)
-		goto err_free_tdxmem;
+		goto err_free_tdmrs;
 out_put_tdxmem:
 	/*
 	 * @tdx_memlist is written here and read at memory hotplug time.
@@ -360,6 +445,8 @@ out_put_tdxmem:
 	put_online_mems();
 	return ret;
 
+err_free_tdmrs:
+	free_tdmr_list(&tdx_tdmr_list);
 err_free_tdxmem:
 	free_tdx_memlist(&tdx_memlist);
 	goto out_put_tdxmem;
diff --git a/arch/x86/virt/vmx/tdx/tdx.h b/arch/x86/virt/vmx/tdx/tdx.h
index 29cdf5e..9b6b5d7 100644
--- a/arch/x86/virt/vmx/tdx/tdx.h
+++ b/arch/x86/virt/vmx/tdx/tdx.h
@@ -47,6 +47,30 @@
 
 #define MD_FIELD_ID_ELE_SIZE_16BIT	1
 
+struct tdmr_reserved_area {
+	u64 offset;
+	u64 size;
+} __packed;
+
+#define TDMR_INFO_ALIGNMENT	512
+
+struct tdmr_info {
+	u64 base;
+	u64 size;
+	u64 pamt_1g_base;
+	u64 pamt_1g_size;
+	u64 pamt_2m_base;
+	u64 pamt_2m_size;
+	u64 pamt_4k_base;
+	u64 pamt_4k_size;
+	/*
+	 * The actual number of reserved areas depends on the value of
+	 * field MD_FIELD_ID_MAX_RESERVED_PER_TDMR in the TDX module
+	 * global metadata.
+	 */
+	DECLARE_FLEX_ARRAY(struct tdmr_reserved_area, reserved_areas);
+} __packed __aligned(TDMR_INFO_ALIGNMENT);
+
 /*
  * Do not put any hardware-defined TDX structure representations below
  * this comment!
@@ -72,4 +96,13 @@ struct tdx_tdmr_sysinfo {
 	u16 pamt_entry_size[TDX_PS_NR];
 };
 
+struct tdmr_info_list {
+	void *tdmrs;	/* Flexible array to hold 'tdmr_info's */
+	int nr_consumed_tdmrs;	/* How many 'tdmr_info's are in use */
+
+	/* Metadata for finding target 'tdmr_info' and freeing @tdmrs */
+	int tdmr_sz;	/* Size of one 'tdmr_info' */
+	int max_tdmrs;	/* How many 'tdmr_info's are allocated */
+};
+
 #endif
