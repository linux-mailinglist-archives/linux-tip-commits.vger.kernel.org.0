Return-Path: <linux-tip-commits+bounces-3071-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A7039F2069
	for <lists+linux-tip-commits@lfdr.de>; Sat, 14 Dec 2024 19:48:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D8B371888C3B
	for <lists+linux-tip-commits@lfdr.de>; Sat, 14 Dec 2024 18:48:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED8D21AB531;
	Sat, 14 Dec 2024 18:47:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="xTdiz+td";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="zSk6Vofu"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDE68194C61;
	Sat, 14 Dec 2024 18:47:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734202073; cv=none; b=R00ZZ0DLgDrwlkZQlcbdhdL7sJeQ2a+IbICEBZrn8l7IXjAk0GfyXzVoW2vSFCiJ4ABvXF4EJMnFqy8e/ENrPsg6arej+dKSMIFCAoMF1ufsGYbbFD239K6DKZF0XQZZMVQJb/FAm4xsjwxzbM8g+DW5WrhBmnuL39+waY/GIJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734202073; c=relaxed/simple;
	bh=W41daRO+oL0QS9zJwn6CMiaI7FbVY+8KsZqGKJmrqTA=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=t5qZSUaHWyRhubveBNaGwlCBVaJXk7obq36zvjPZ7XoVekSacznfPod0gWWEWQnv2u46iTSKMFd8aF5KgOh8LrynaIAFl2hbUAFZ7uwn5owZgd4CzH6p6zXLzGsJ0bSgUu7hSGXg4oQs7aaP36AvY+fXSN3pWy3IfJAH1vneZFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=xTdiz+td; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=zSk6Vofu; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sat, 14 Dec 2024 18:47:49 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1734202070;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RAQqGijsAD7sZWcijFiS9pm8yI3B5sHANbSQyt+AHCI=;
	b=xTdiz+tdtUzZxDdPV7CZD2er3uprfx8afhKmIR8JGlFmyukpFcpzFQl/kX/mcH2ZAEZbtt
	01jA7o/eVVe50UQRreLmVhA95w+p2PM07WhBtItbk8Eyb4Mq9dMg24YQWDNFXGir89wS5J
	EvdmPcEaYitGg51CXuHNNEfY9E1blP7hgAazoUBIeXy36w7kknklsP/xUPq7lzGqRvB6zN
	q9eWZfTnKzOK1BihAk6sOEhkPx9HA+bxEqcFmi/PvDR4BbiqRjxeiYrDOzmo4kfF9/x+fv
	lpy4IqrrUAY6pH04xy493F0lY9u+hn9IuVaFZcTqBuNcjiASdf75q2OuxQJ6Wg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1734202070;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RAQqGijsAD7sZWcijFiS9pm8yI3B5sHANbSQyt+AHCI=;
	b=zSk6VofuMDzwho+wsenAMe6c2plMZI7qgwYlqG1oYbQHDKNeB3secoXMyea5BHIWzC6HT3
	2aHhbUcvnQNLnzAg==
From: "tip-bot2 for Tom Lendacky" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/sev] x86/sev: Treat the contiguous RMP table as a single
 RMP segment
Cc: Tom Lendacky <thomas.lendacky@amd.com>,
 "Borislav Petkov (AMD)" <bp@alien8.de>, Nikunj A Dadhania <nikunj@amd.com>,
 Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: =?utf-8?q?=3C8c40fbc9c5217f0d79b37cf861eff03ab0330bef=2E17331?=
 =?utf-8?q?72653=2Egit=2Ethomas=2Elendacky=40amd=2Ecom=3E?=
References: =?utf-8?q?=3C8c40fbc9c5217f0d79b37cf861eff03ab0330bef=2E173317?=
 =?utf-8?q?2653=2Egit=2Ethomas=2Elendacky=40amd=2Ecom=3E?=
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173420206941.412.9889801350093881526.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/sev branch of tip:

Commit-ID:     0f14af0d1d7df0086b1be98d2cea1cad4b8c826f
Gitweb:        https://git.kernel.org/tip/0f14af0d1d7df0086b1be98d2cea1cad4b8c826f
Author:        Tom Lendacky <thomas.lendacky@amd.com>
AuthorDate:    Mon, 02 Dec 2024 14:50:51 -06:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Sat, 14 Dec 2024 11:40:01 +01:00

x86/sev: Treat the contiguous RMP table as a single RMP segment

In preparation for support of a segmented RMP table, treat the contiguous
RMP table as a segmented RMP table with a single segment covering all
of memory. By treating a contiguous RMP table as a single segment, much
of the code that initializes and accesses the RMP can be re-used.

Segmented RMP tables can have up to 512 segment entries. Each segment
will have metadata associated with it to identify the segment location,
the segment size, etc. The segment data and the physical address are used
to determine the index of the segment within the table and then the RMP
entry within the segment. For an actual segmented RMP table environment,
much of the segment information will come from a configuration MSR. For
the contiguous RMP, though, much of the information will be statically
defined.

  [ bp: Touchups, explain array_index_nospec() usage. ]

Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Nikunj A Dadhania <nikunj@amd.com>
Reviewed-by: Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>
Link: https://lore.kernel.org/r/8c40fbc9c5217f0d79b37cf861eff03ab0330bef.1733172653.git.thomas.lendacky@amd.com
---
 arch/x86/virt/svm/sev.c | 199 +++++++++++++++++++++++++++++++++++----
 1 file changed, 180 insertions(+), 19 deletions(-)

diff --git a/arch/x86/virt/svm/sev.c b/arch/x86/virt/svm/sev.c
index 2899c2e..e50b71c 100644
--- a/arch/x86/virt/svm/sev.c
+++ b/arch/x86/virt/svm/sev.c
@@ -18,6 +18,7 @@
 #include <linux/cpumask.h>
 #include <linux/iommu.h>
 #include <linux/amd-iommu.h>
+#include <linux/nospec.h>
 
 #include <asm/sev.h>
 #include <asm/processor.h>
@@ -77,12 +78,42 @@ struct rmpentry_raw {
  */
 #define RMPTABLE_CPU_BOOKKEEPING_SZ	0x4000
 
+/*
+ * For a non-segmented RMP table, use the maximum physical addressing as the
+ * segment size in order to always arrive at index 0 in the table.
+ */
+#define RMPTABLE_NON_SEGMENTED_SHIFT	52
+
+struct rmp_segment_desc {
+	struct rmpentry_raw *rmp_entry;
+	u64 max_index;
+	u64 size;
+};
+
+/*
+ * Segmented RMP Table support.
+ *   - The segment size is used for two purposes:
+ *     - Identify the amount of memory covered by an RMP segment
+ *     - Quickly locate an RMP segment table entry for a physical address
+ *
+ *   - The RMP segment table contains pointers to an RMP table that covers
+ *     a specific portion of memory. There can be up to 512 8-byte entries,
+ *     one pages worth.
+ */
+static struct rmp_segment_desc **rmp_segment_table __ro_after_init;
+static unsigned int rst_max_index __ro_after_init = 512;
+
+static unsigned int rmp_segment_shift;
+static u64 rmp_segment_size;
+static u64 rmp_segment_mask;
+
+#define RST_ENTRY_INDEX(x)	((x) >> rmp_segment_shift)
+#define RMP_ENTRY_INDEX(x)	((u64)(PHYS_PFN((x) & rmp_segment_mask)))
+
 /* Mask to apply to a PFN to get the first PFN of a 2MB page */
 #define PFN_PMD_MASK	GENMASK_ULL(63, PMD_SHIFT - PAGE_SHIFT)
 
 static u64 probed_rmp_base, probed_rmp_size;
-static struct rmpentry_raw *rmptable __ro_after_init;
-static u64 rmptable_max_pfn __ro_after_init;
 
 static LIST_HEAD(snp_leaked_pages_list);
 static DEFINE_SPINLOCK(snp_leaked_pages_list_lock);
@@ -190,6 +221,92 @@ static bool __init clear_rmptable_bookkeeping(void)
 	return true;
 }
 
+static bool __init alloc_rmp_segment_desc(u64 segment_pa, u64 segment_size, u64 pa)
+{
+	u64 rst_index, rmp_segment_size_max;
+	struct rmp_segment_desc *desc;
+	void *rmp_segment;
+
+	/* Calculate the maximum size an RMP can be (16 bytes/page mapped) */
+	rmp_segment_size_max = PHYS_PFN(rmp_segment_size) << 4;
+
+	/* Validate the RMP segment size */
+	if (segment_size > rmp_segment_size_max) {
+		pr_err("Invalid RMP size 0x%llx for configured segment size 0x%llx\n",
+		       segment_size, rmp_segment_size_max);
+		return false;
+	}
+
+	/* Validate the RMP segment table index */
+	rst_index = RST_ENTRY_INDEX(pa);
+	if (rst_index >= rst_max_index) {
+		pr_err("Invalid RMP segment base address 0x%llx for configured segment size 0x%llx\n",
+		       pa, rmp_segment_size);
+		return false;
+	}
+
+	if (rmp_segment_table[rst_index]) {
+		pr_err("RMP segment descriptor already exists at index %llu\n", rst_index);
+		return false;
+	}
+
+	rmp_segment = memremap(segment_pa, segment_size, MEMREMAP_WB);
+	if (!rmp_segment) {
+		pr_err("Failed to map RMP segment addr 0x%llx size 0x%llx\n",
+		       segment_pa, segment_size);
+		return false;
+	}
+
+	desc = kzalloc(sizeof(*desc), GFP_KERNEL);
+	if (!desc) {
+		memunmap(rmp_segment);
+		return false;
+	}
+
+	desc->rmp_entry = rmp_segment;
+	desc->max_index = segment_size / sizeof(*desc->rmp_entry);
+	desc->size = segment_size;
+
+	rmp_segment_table[rst_index] = desc;
+
+	return true;
+}
+
+static void __init free_rmp_segment_table(void)
+{
+	unsigned int i;
+
+	for (i = 0; i < rst_max_index; i++) {
+		struct rmp_segment_desc *desc;
+
+		desc = rmp_segment_table[i];
+		if (!desc)
+			continue;
+
+		memunmap(desc->rmp_entry);
+
+		kfree(desc);
+	}
+
+	free_page((unsigned long)rmp_segment_table);
+
+	rmp_segment_table = NULL;
+}
+
+/* Allocate the table used to index into the RMP segments */
+static bool __init alloc_rmp_segment_table(void)
+{
+	struct page *page;
+
+	page = alloc_page(__GFP_ZERO);
+	if (!page)
+		return false;
+
+	rmp_segment_table = page_address(page);
+
+	return true;
+}
+
 /*
  * Do the necessary preparations which are verified by the firmware as
  * described in the SNP_INIT_EX firmware command description in the SNP
@@ -197,8 +314,8 @@ static bool __init clear_rmptable_bookkeeping(void)
  */
 static int __init snp_rmptable_init(void)
 {
-	u64 max_rmp_pfn, calc_rmp_sz, rmptable_size, rmp_end, val;
-	void *rmptable_start;
+	u64 max_rmp_pfn, calc_rmp_sz, rmptable_segment, rmptable_size, rmp_end, val;
+	unsigned int i;
 
 	if (!cc_platform_has(CC_ATTR_HOST_SEV_SNP))
 		return 0;
@@ -227,17 +344,18 @@ static int __init snp_rmptable_init(void)
 		goto nosnp;
 	}
 
+	if (!alloc_rmp_segment_table())
+		goto nosnp;
+
 	/* Map only the RMP entries */
-	rmptable_start = memremap(probed_rmp_base + RMPTABLE_CPU_BOOKKEEPING_SZ,
-				  probed_rmp_size - RMPTABLE_CPU_BOOKKEEPING_SZ,
-				  MEMREMAP_WB);
-	if (!rmptable_start) {
-		pr_err("Failed to map RMP table\n");
+	rmptable_segment = probed_rmp_base + RMPTABLE_CPU_BOOKKEEPING_SZ;
+	rmptable_size    = probed_rmp_size - RMPTABLE_CPU_BOOKKEEPING_SZ;
+
+	if (!alloc_rmp_segment_desc(rmptable_segment, rmptable_size, 0)) {
+		free_rmp_segment_table();
 		goto nosnp;
 	}
 
-	rmptable_size = probed_rmp_size - RMPTABLE_CPU_BOOKKEEPING_SZ;
-
 	/*
 	 * Check if SEV-SNP is already enabled, this can happen in case of
 	 * kexec boot.
@@ -248,12 +366,20 @@ static int __init snp_rmptable_init(void)
 
 	/* Zero out the RMP bookkeeping area */
 	if (!clear_rmptable_bookkeeping()) {
-		memunmap(rmptable_start);
+		free_rmp_segment_table();
 		goto nosnp;
 	}
 
 	/* Zero out the RMP entries */
-	memset(rmptable_start, 0, rmptable_size);
+	for (i = 0; i < rst_max_index; i++) {
+		struct rmp_segment_desc *desc;
+
+		desc = rmp_segment_table[i];
+		if (!desc)
+			continue;
+
+		memset(desc->rmp_entry, 0, desc->size);
+	}
 
 	/* Flush the caches to ensure that data is written before SNP is enabled. */
 	wbinvd_on_all_cpus();
@@ -264,9 +390,6 @@ static int __init snp_rmptable_init(void)
 	on_each_cpu(snp_enable, NULL, 1);
 
 skip_enable:
-	rmptable = (struct rmpentry_raw *)rmptable_start;
-	rmptable_max_pfn = rmptable_size / sizeof(struct rmpentry_raw) - 1;
-
 	cpuhp_setup_state(CPUHP_AP_ONLINE_DYN, "x86/rmptable_init:online", __snp_enable, NULL);
 
 	/*
@@ -287,6 +410,13 @@ nosnp:
  */
 device_initcall(snp_rmptable_init);
 
+static void set_rmp_segment_info(unsigned int segment_shift)
+{
+	rmp_segment_shift = segment_shift;
+	rmp_segment_size  = 1ULL << rmp_segment_shift;
+	rmp_segment_mask  = rmp_segment_size - 1;
+}
+
 #define RMP_ADDR_MASK GENMASK_ULL(51, 13)
 
 bool snp_probe_rmptable_info(void)
@@ -308,6 +438,11 @@ bool snp_probe_rmptable_info(void)
 
 	rmp_sz = rmp_end - rmp_base + 1;
 
+	/* Treat the contiguous RMP table as a single segment */
+	rst_max_index = 1;
+
+	set_rmp_segment_info(RMPTABLE_NON_SEGMENTED_SHIFT);
+
 	probed_rmp_base = rmp_base;
 	probed_rmp_size = rmp_sz;
 
@@ -317,15 +452,41 @@ bool snp_probe_rmptable_info(void)
 	return true;
 }
 
+/*
+ * About the array_index_nospec() usage below:
+ *
+ * This function can get called by exported functions like
+ * snp_lookup_rmpentry(), which is used by the KVM #PF handler, among
+ * others, and since the @pfn passed in cannot always be trusted,
+ * speculation should be stopped as a protective measure.
+ */
 static struct rmpentry_raw *get_raw_rmpentry(u64 pfn)
 {
-	if (!rmptable)
+	u64 paddr, rst_index, segment_index;
+	struct rmp_segment_desc *desc;
+
+	if (!rmp_segment_table)
 		return ERR_PTR(-ENODEV);
 
-	if (unlikely(pfn > rmptable_max_pfn))
+	paddr = pfn << PAGE_SHIFT;
+
+	rst_index = RST_ENTRY_INDEX(paddr);
+	if (unlikely(rst_index >= rst_max_index))
 		return ERR_PTR(-EFAULT);
 
-	return rmptable + pfn;
+	rst_index = array_index_nospec(rst_index, rst_max_index);
+
+	desc = rmp_segment_table[rst_index];
+	if (unlikely(!desc))
+		return ERR_PTR(-EFAULT);
+
+	segment_index = RMP_ENTRY_INDEX(paddr);
+	if (unlikely(segment_index >= desc->max_index))
+		return ERR_PTR(-EFAULT);
+
+	segment_index = array_index_nospec(segment_index, desc->max_index);
+
+	return desc->rmp_entry + segment_index;
 }
 
 static int get_rmpentry(u64 pfn, struct rmpentry *e)

