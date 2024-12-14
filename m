Return-Path: <linux-tip-commits+bounces-3075-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FF739F2074
	for <lists+linux-tip-commits@lfdr.de>; Sat, 14 Dec 2024 19:49:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F15C41883DCA
	for <lists+linux-tip-commits@lfdr.de>; Sat, 14 Dec 2024 18:49:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80B9C1B6CE7;
	Sat, 14 Dec 2024 18:47:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="R32F2+00";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="O0MOGfUs"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 734C01B218E;
	Sat, 14 Dec 2024 18:47:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734202078; cv=none; b=NO5/vcPY3stzbPWoY4IuQWJ8ZYR3eSH98Wrp85a3UKtLQspKtvSqZpx2FNd9UzhDGupcsqQVbXgNrvcCeWzwgQREDPDdPi4i6/vE540KyxeI1gDe6dF7VKgIBOJet7ECcG/TrhbG8oT+0W7KtCm/EqEj5ibS/xkk78SwyMdl5R4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734202078; c=relaxed/simple;
	bh=fBzX+cM0v4OwLBetwlVYEUDVhtEOuP6JYWeZnLg+gEc=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=ejzex7hAQkidj6ugd8EA6F0lvxjPEFY3QHIuFaXWXwiUwu5w9f02Cmjc1tVN5qhzflkFxjKSuXdZDhMry9iv4rVQT8/6XOASEu78hm3cVHjFIloxNA56y6GQzlW0L+kESUp50y98qLhwZFujpXmiMGT4rTEGZzp7MbR6GKNUmt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=R32F2+00; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=O0MOGfUs; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sat, 14 Dec 2024 18:47:53 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1734202074;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oTDigCKksS22uORhHpwu45z5Kw0tI223cpR9YoUDdBI=;
	b=R32F2+00wtIntAYJn95CENyBoHyoOk1mrqvdCZrjys4qB2srngFAacM/0l/K3qDFrZpBiX
	ubOtXA+3KAJfXriqktsnDQYUQJVYU+bIiTomDwIk3cBgnZsdgdbgrrNab7yc+yE+VxT8Ml
	aHovGfmWDmG345w19XCF4IY4jPTyfBeiI5j6zuG4qFKDj+jMmC/6HLjmUYkX5rLhh5yR8o
	02c1KiP/UDiWr+wVjQXSksNbWpAEPR+aQC/3Po/FRGl6kBybG/fVrh596kEWQUKn4clGUn
	siAgQGq4nHHQsPygB7G7bQJfmmC8g+cyNPBEC6H8/WJ70XVSItGniSXeg+lzbw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1734202074;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oTDigCKksS22uORhHpwu45z5Kw0tI223cpR9YoUDdBI=;
	b=O0MOGfUsSbbnRk3PaxzGnIvhDphRfqRBIqsEgGHFUaxYyHGonoaZ0fsOtRNtzw/XFWIZPw
	t+4b6h5qg08MmTCA==
From: "tip-bot2 for Tom Lendacky" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/sev] x86/sev: Prepare for using the RMPREAD instruction to
 access the RMP
Cc: Tom Lendacky <thomas.lendacky@amd.com>,
 "Borislav Petkov (AMD)" <bp@alien8.de>, Nikunj A Dadhania <nikunj@amd.com>,
 Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: =?utf-8?q?=3Cda49d5af1eb7f9039f35f14a32ca091efb2dd818=2E17331?=
 =?utf-8?q?72653=2Egit=2Ethomas=2Elendacky=40amd=2Ecom=3E?=
References: =?utf-8?q?=3Cda49d5af1eb7f9039f35f14a32ca091efb2dd818=2E173317?=
 =?utf-8?q?2653=2Egit=2Ethomas=2Elendacky=40amd=2Ecom=3E?=
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173420207384.412.8772260599010817646.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/sev branch of tip:

Commit-ID:     3e43c60eb3e3779e88635d45400f7387ec732c07
Gitweb:        https://git.kernel.org/tip/3e43c60eb3e3779e88635d45400f7387ec732c07
Author:        Tom Lendacky <thomas.lendacky@amd.com>
AuthorDate:    Mon, 02 Dec 2024 14:50:46 -06:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Fri, 13 Dec 2024 22:46:14 +01:00

x86/sev: Prepare for using the RMPREAD instruction to access the RMP

The RMPREAD instruction returns an architecture defined format of an RMP
entry. This is the preferred method for examining RMP entries.

In preparation for using the RMPREAD instruction, convert the existing code
that directly accesses the RMP to map the raw RMP information into the
architecture defined format.

RMPREAD output returns a status bit for the 2MB region status. If the input
page address is 2MB aligned and any other pages within the 2MB region are
assigned, then 2MB region status will be set to 1. Otherwise, the 2MB region
status will be set to 0.

For systems that do not support RMPREAD, calculating this value would require
looping over all of the RMP table entries within that range until one is found
with the assigned bit set. Since this bit is not defined in the current
format, and so not used today, do not incur the overhead associated with
calculating it.

Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Nikunj A Dadhania <nikunj@amd.com>
Reviewed-by: Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>
Link: https://lore.kernel.org/r/da49d5af1eb7f9039f35f14a32ca091efb2dd818.1733172653.git.thomas.lendacky@amd.com
---
 arch/x86/virt/svm/sev.c | 132 +++++++++++++++++++++++++++------------
 1 file changed, 94 insertions(+), 38 deletions(-)

diff --git a/arch/x86/virt/svm/sev.c b/arch/x86/virt/svm/sev.c
index 9a6a943..cf64e93 100644
--- a/arch/x86/virt/svm/sev.c
+++ b/arch/x86/virt/svm/sev.c
@@ -31,10 +31,29 @@
 #include <asm/iommu.h>
 
 /*
- * The RMP entry format is not architectural. The format is defined in PPR
- * Family 19h Model 01h, Rev B1 processor.
+ * The RMP entry information as returned by the RMPREAD instruction.
  */
 struct rmpentry {
+	u64 gpa;
+	u8  assigned		:1,
+	    rsvd1		:7;
+	u8  pagesize		:1,
+	    hpage_region_status	:1,
+	    rsvd2		:6;
+	u8  immutable		:1,
+	    rsvd3		:7;
+	u8  rsvd4;
+	u32 asid;
+} __packed;
+
+/*
+ * The raw RMP entry format is not architectural. The format is defined in PPR
+ * Family 19h Model 01h, Rev B1 processor. This format represents the actual
+ * entry in the RMP table memory. The bitfield definitions are used for machines
+ * without the RMPREAD instruction (Zen3 and Zen4), otherwise the "hi" and "lo"
+ * fields are only used for dumping the raw data.
+ */
+struct rmpentry_raw {
 	union {
 		struct {
 			u64 assigned	: 1,
@@ -62,7 +81,7 @@ struct rmpentry {
 #define PFN_PMD_MASK	GENMASK_ULL(63, PMD_SHIFT - PAGE_SHIFT)
 
 static u64 probed_rmp_base, probed_rmp_size;
-static struct rmpentry *rmptable __ro_after_init;
+static struct rmpentry_raw *rmptable __ro_after_init;
 static u64 rmptable_max_pfn __ro_after_init;
 
 static LIST_HEAD(snp_leaked_pages_list);
@@ -249,8 +268,8 @@ skip_enable:
 	rmptable_start += RMPTABLE_CPU_BOOKKEEPING_SZ;
 	rmptable_size = probed_rmp_size - RMPTABLE_CPU_BOOKKEEPING_SZ;
 
-	rmptable = (struct rmpentry *)rmptable_start;
-	rmptable_max_pfn = rmptable_size / sizeof(struct rmpentry) - 1;
+	rmptable = (struct rmpentry_raw *)rmptable_start;
+	rmptable_max_pfn = rmptable_size / sizeof(struct rmpentry_raw) - 1;
 
 	cpuhp_setup_state(CPUHP_AP_ONLINE_DYN, "x86/rmptable_init:online", __snp_enable, NULL);
 
@@ -272,48 +291,77 @@ nosnp:
  */
 device_initcall(snp_rmptable_init);
 
-static struct rmpentry *get_rmpentry(u64 pfn)
+static struct rmpentry_raw *get_raw_rmpentry(u64 pfn)
 {
-	if (WARN_ON_ONCE(pfn > rmptable_max_pfn))
+	if (!rmptable)
+		return ERR_PTR(-ENODEV);
+
+	if (unlikely(pfn > rmptable_max_pfn))
 		return ERR_PTR(-EFAULT);
 
-	return &rmptable[pfn];
+	return rmptable + pfn;
+}
+
+static int get_rmpentry(u64 pfn, struct rmpentry *e)
+{
+	struct rmpentry_raw *e_raw;
+
+	e_raw = get_raw_rmpentry(pfn);
+	if (IS_ERR(e_raw))
+		return PTR_ERR(e_raw);
+
+	/*
+	 * Map the raw RMP table entry onto the RMPREAD output format.
+	 * The 2MB region status indicator (hpage_region_status field) is not
+	 * calculated, since the overhead could be significant and the field
+	 * is not used.
+	 */
+	memset(e, 0, sizeof(*e));
+	e->gpa       = e_raw->gpa << PAGE_SHIFT;
+	e->asid      = e_raw->asid;
+	e->assigned  = e_raw->assigned;
+	e->pagesize  = e_raw->pagesize;
+	e->immutable = e_raw->immutable;
+
+	return 0;
 }
 
-static struct rmpentry *__snp_lookup_rmpentry(u64 pfn, int *level)
+static int __snp_lookup_rmpentry(u64 pfn, struct rmpentry *e, int *level)
 {
-	struct rmpentry *large_entry, *entry;
+	struct rmpentry e_large;
+	int ret;
 
 	if (!cc_platform_has(CC_ATTR_HOST_SEV_SNP))
-		return ERR_PTR(-ENODEV);
+		return -ENODEV;
 
-	entry = get_rmpentry(pfn);
-	if (IS_ERR(entry))
-		return entry;
+	ret = get_rmpentry(pfn, e);
+	if (ret)
+		return ret;
 
 	/*
 	 * Find the authoritative RMP entry for a PFN. This can be either a 4K
 	 * RMP entry or a special large RMP entry that is authoritative for a
 	 * whole 2M area.
 	 */
-	large_entry = get_rmpentry(pfn & PFN_PMD_MASK);
-	if (IS_ERR(large_entry))
-		return large_entry;
+	ret = get_rmpentry(pfn & PFN_PMD_MASK, &e_large);
+	if (ret)
+		return ret;
 
-	*level = RMP_TO_PG_LEVEL(large_entry->pagesize);
+	*level = RMP_TO_PG_LEVEL(e_large.pagesize);
 
-	return entry;
+	return 0;
 }
 
 int snp_lookup_rmpentry(u64 pfn, bool *assigned, int *level)
 {
-	struct rmpentry *e;
+	struct rmpentry e;
+	int ret;
 
-	e = __snp_lookup_rmpentry(pfn, level);
-	if (IS_ERR(e))
-		return PTR_ERR(e);
+	ret = __snp_lookup_rmpentry(pfn, &e, level);
+	if (ret)
+		return ret;
 
-	*assigned = !!e->assigned;
+	*assigned = !!e.assigned;
 	return 0;
 }
 EXPORT_SYMBOL_GPL(snp_lookup_rmpentry);
@@ -326,20 +374,28 @@ EXPORT_SYMBOL_GPL(snp_lookup_rmpentry);
  */
 static void dump_rmpentry(u64 pfn)
 {
+	struct rmpentry_raw *e_raw;
 	u64 pfn_i, pfn_end;
-	struct rmpentry *e;
-	int level;
+	struct rmpentry e;
+	int level, ret;
 
-	e = __snp_lookup_rmpentry(pfn, &level);
-	if (IS_ERR(e)) {
-		pr_err("Failed to read RMP entry for PFN 0x%llx, error %ld\n",
-		       pfn, PTR_ERR(e));
+	ret = __snp_lookup_rmpentry(pfn, &e, &level);
+	if (ret) {
+		pr_err("Failed to read RMP entry for PFN 0x%llx, error %d\n",
+		       pfn, ret);
 		return;
 	}
 
-	if (e->assigned) {
+	if (e.assigned) {
+		e_raw = get_raw_rmpentry(pfn);
+		if (IS_ERR(e_raw)) {
+			pr_err("Failed to read RMP contents for PFN 0x%llx, error %ld\n",
+			       pfn, PTR_ERR(e_raw));
+			return;
+		}
+
 		pr_info("PFN 0x%llx, RMP entry: [0x%016llx - 0x%016llx]\n",
-			pfn, e->lo, e->hi);
+			pfn, e_raw->lo, e_raw->hi);
 		return;
 	}
 
@@ -358,16 +414,16 @@ static void dump_rmpentry(u64 pfn)
 		pfn, pfn_i, pfn_end);
 
 	while (pfn_i < pfn_end) {
-		e = __snp_lookup_rmpentry(pfn_i, &level);
-		if (IS_ERR(e)) {
-			pr_err("Error %ld reading RMP entry for PFN 0x%llx\n",
-			       PTR_ERR(e), pfn_i);
+		e_raw = get_raw_rmpentry(pfn_i);
+		if (IS_ERR(e_raw)) {
+			pr_err("Error %ld reading RMP contents for PFN 0x%llx\n",
+			       PTR_ERR(e_raw), pfn_i);
 			pfn_i++;
 			continue;
 		}
 
-		if (e->lo || e->hi)
-			pr_info("PFN: 0x%llx, [0x%016llx - 0x%016llx]\n", pfn_i, e->lo, e->hi);
+		if (e_raw->lo || e_raw->hi)
+			pr_info("PFN: 0x%llx, [0x%016llx - 0x%016llx]\n", pfn_i, e_raw->lo, e_raw->hi);
 		pfn_i++;
 	}
 }

