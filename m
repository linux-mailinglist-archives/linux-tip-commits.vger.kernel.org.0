Return-Path: <linux-tip-commits+bounces-3070-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AD009F2068
	for <lists+linux-tip-commits@lfdr.de>; Sat, 14 Dec 2024 19:48:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BB5BB1887DE7
	for <lists+linux-tip-commits@lfdr.de>; Sat, 14 Dec 2024 18:48:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4760C1AA78E;
	Sat, 14 Dec 2024 18:47:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="kMGtVUYq";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="7q5rcu3H"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20A4E18FC8F;
	Sat, 14 Dec 2024 18:47:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734202073; cv=none; b=uXbhqadatmIILVZIFjwu3R1979dywd0Dlmvd7Y/2uVPCootzg5hpHjnhi32WJvl9ydrQ0VrOUhr5fbOhDs9jRq4rh4icwKkWbGyPzBGafW/6eRbv9T8knyqOgFP9EB4c8q6aL37XjeBWJNmBtgf9H1E3rYjMERoko7lPqMl1988=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734202073; c=relaxed/simple;
	bh=Ypr0siytyWkP1lqv+B6y9YaANp+Qk/PcvoNHmC4EFPc=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=QC34+G7dTMiBSnVy4bnXOB66U61+SCsS7hz/TSw+KCNoG5gZMFFolXMvdomeTMLsMEQAkV/bFqsytuSsQ0bK79mou1vP3YGiEtwp2G7EDlVhtdMi3FX+Nz1AfoRkvtP7Jkkii4ikyCgPcbuNvcHSudd1dpGoHSTG0cKV/y4PclM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=kMGtVUYq; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=7q5rcu3H; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sat, 14 Dec 2024 18:47:48 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1734202069;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=La0asl3tX9RVRRbgFc6ptsL2EbhYo0Hs9bRmJ8eWbmY=;
	b=kMGtVUYqsWzIj74xFmP5jjGKH0gnzmVcROSPL0vJU4P8ba32SSstZ42PISQsamEL8o4T+W
	AthJXKgIm7kgSqHBC76dR2fbi+/5vqJ4xKH6UysMjrcFFK6JxBz4g1CVfKQA4vvqrGzhaR
	6B/NAyI6scvdfPhDLsZYAJaDHq9Njr7j7tJZFltDf06jpiKbE0mac4MCV9oZqH6TN8mZN1
	1PKQyVLqRbPHVQQobbGQ3XmxOxO2DkX/GWvg867hqltAC5z1Zugg072Ij/f6wvN/1hT/6/
	NYUo6FTwmf/JsX1WSbMB+zFKWamV4KOosaBAUjVC9XXIk3vQQMYJjJVkENTTrQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1734202069;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=La0asl3tX9RVRRbgFc6ptsL2EbhYo0Hs9bRmJ8eWbmY=;
	b=7q5rcu3Ha4h01SVop0gJexTrR+FHlkGiAgSb0y0EuSMjrdbJN/imTVI3pxcocmTdijk4sd
	F2B9vkQOEH+aAMDA==
From: "tip-bot2 for Tom Lendacky" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/sev] x86/sev: Add full support for a segmented RMP table
Cc: Tom Lendacky <thomas.lendacky@amd.com>,
 "Borislav Petkov (AMD)" <bp@alien8.de>, Nikunj A Dadhania <nikunj@amd.com>,
 Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: =?utf-8?q?=3C02afd0ffd097a19cb6e5fb1bb76eb110496c5b11=2E17341?=
 =?utf-8?q?01742=2Egit=2Ethomas=2Elendacky=40amd=2Ecom=3E?=
References: =?utf-8?q?=3C02afd0ffd097a19cb6e5fb1bb76eb110496c5b11=2E173410?=
 =?utf-8?q?1742=2Egit=2Ethomas=2Elendacky=40amd=2Ecom=3E?=
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173420206851.412.8568471975815045437.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/sev branch of tip:

Commit-ID:     8ae3291f773befee8fdeae11b0b1b5d380e4dfb6
Gitweb:        https://git.kernel.org/tip/8ae3291f773befee8fdeae11b0b1b5d380e4dfb6
Author:        Tom Lendacky <thomas.lendacky@amd.com>
AuthorDate:    Fri, 13 Dec 2024 08:55:42 -06:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Sat, 14 Dec 2024 11:47:42 +01:00

x86/sev: Add full support for a segmented RMP table

A segmented RMP table allows for improved locality of reference between
the memory protected by the RMP and the RMP entries themselves.

Add support to detect and initialize a segmented RMP table with multiple
segments as configured by the system BIOS. While the RMPREAD instruction
will be used to read an RMP entry in a segmented RMP, initialization and
debugging capabilities will require the mapping of the segments.

The RMP_CFG MSR indicates if segmented RMP support is enabled and, if
enabled, the amount of memory that an RMP segment covers. When segmented
RMP support is enabled, the RMP_BASE MSR points to the start of the RMP
bookkeeping area, which is 16K in size. The RMP Segment Table (RST) is
located immediately after the bookkeeping area and is 4K in size. The RST
contains up to 512 8-byte entries that identify the location of the RMP
segment and amount of memory mapped by the segment (which must be less
than or equal to the configured segment size). The physical address that
is covered by a segment is based on the segment size and the index of the
segment in the RST. The RMP entry for a physical address is based on the
offset within the segment.

  For example, if the segment size is 64GB (0x1000000000 or 1 << 36), then
  physical address 0x9000800000 is RST entry 9 (0x9000800000 >> 36) and
  RST entry 9 covers physical memory 0x9000000000 to 0x9FFFFFFFFF.

  The RMP entry index within the RMP segment is the physical address
  AND-ed with the segment mask, 64GB - 1 (0xFFFFFFFFF), and then
  right-shifted 12 bits or PHYS_PFN(0x9000800000 & 0xFFFFFFFFF), which
  is 0x800.

CPUID 0x80000025_EBX[9:0] describes the number of RMP segments that can
be cached by the hardware. Additionally, if CPUID 0x80000025_EBX[10] is
set, then the number of actual RMP segments defined cannot exceed the
number of RMP segments that can be cached and can be used as a maximum
RST index.

  [ bp: Unify printk hex format specifiers. ]

Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Nikunj A Dadhania <nikunj@amd.com>
Reviewed-by: Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>
Link: https://lore.kernel.org/r/02afd0ffd097a19cb6e5fb1bb76eb110496c5b11.1734101742.git.thomas.lendacky@amd.com
---
 arch/x86/include/asm/cpufeatures.h |   1 +-
 arch/x86/include/asm/msr-index.h   |   8 +-
 arch/x86/virt/svm/sev.c            | 260 +++++++++++++++++++++++++---
 3 files changed, 245 insertions(+), 24 deletions(-)

diff --git a/arch/x86/include/asm/cpufeatures.h b/arch/x86/include/asm/cpufeatures.h
index 5535edc..6a6db7c 100644
--- a/arch/x86/include/asm/cpufeatures.h
+++ b/arch/x86/include/asm/cpufeatures.h
@@ -452,6 +452,7 @@
 #define X86_FEATURE_SME_COHERENT	(19*32+10) /* AMD hardware-enforced cache coherency */
 #define X86_FEATURE_DEBUG_SWAP		(19*32+14) /* "debug_swap" AMD SEV-ES full debug state swap support */
 #define X86_FEATURE_RMPREAD		(19*32+21) /* RMPREAD instruction */
+#define X86_FEATURE_SEGMENTED_RMP	(19*32+23) /* Segmented RMP support */
 #define X86_FEATURE_SVSM		(19*32+28) /* "svsm" SVSM present */
 
 /* AMD-defined Extended Feature 2 EAX, CPUID level 0x80000021 (EAX), word 20 */
diff --git a/arch/x86/include/asm/msr-index.h b/arch/x86/include/asm/msr-index.h
index 3ae84c3..3f3e2bc 100644
--- a/arch/x86/include/asm/msr-index.h
+++ b/arch/x86/include/asm/msr-index.h
@@ -644,6 +644,7 @@
 #define MSR_AMD64_IBS_REG_COUNT_MAX	8 /* includes MSR_AMD64_IBSBRTARGET */
 #define MSR_AMD64_SVM_AVIC_DOORBELL	0xc001011b
 #define MSR_AMD64_VM_PAGE_FLUSH		0xc001011e
+#define MSR_AMD64_VIRT_SPEC_CTRL	0xc001011f
 #define MSR_AMD64_SEV_ES_GHCB		0xc0010130
 #define MSR_AMD64_SEV			0xc0010131
 #define MSR_AMD64_SEV_ENABLED_BIT	0
@@ -682,11 +683,12 @@
 #define MSR_AMD64_SNP_SMT_PROT		BIT_ULL(MSR_AMD64_SNP_SMT_PROT_BIT)
 #define MSR_AMD64_SNP_RESV_BIT		18
 #define MSR_AMD64_SNP_RESERVED_MASK	GENMASK_ULL(63, MSR_AMD64_SNP_RESV_BIT)
-
-#define MSR_AMD64_VIRT_SPEC_CTRL	0xc001011f
-
 #define MSR_AMD64_RMP_BASE		0xc0010132
 #define MSR_AMD64_RMP_END		0xc0010133
+#define MSR_AMD64_RMP_CFG		0xc0010136
+#define MSR_AMD64_SEG_RMP_ENABLED_BIT	0
+#define MSR_AMD64_SEG_RMP_ENABLED	BIT_ULL(MSR_AMD64_SEG_RMP_ENABLED_BIT)
+#define MSR_AMD64_RMP_SEGMENT_SHIFT(x)	(((x) & GENMASK_ULL(13, 8)) >> 8)
 
 #define MSR_SVSM_CAA			0xc001f000
 
diff --git a/arch/x86/virt/svm/sev.c b/arch/x86/virt/svm/sev.c
index e50b71c..1dcc027 100644
--- a/arch/x86/virt/svm/sev.c
+++ b/arch/x86/virt/svm/sev.c
@@ -100,6 +100,10 @@ struct rmp_segment_desc {
  *     a specific portion of memory. There can be up to 512 8-byte entries,
  *     one pages worth.
  */
+#define RST_ENTRY_MAPPED_SIZE(x)	((x) & GENMASK_ULL(19, 0))
+#define RST_ENTRY_SEGMENT_BASE(x)	((x) & GENMASK_ULL(51, 20))
+
+#define RST_SIZE SZ_4K
 static struct rmp_segment_desc **rmp_segment_table __ro_after_init;
 static unsigned int rst_max_index __ro_after_init = 512;
 
@@ -110,6 +114,8 @@ static u64 rmp_segment_mask;
 #define RST_ENTRY_INDEX(x)	((x) >> rmp_segment_shift)
 #define RMP_ENTRY_INDEX(x)	((u64)(PHYS_PFN((x) & rmp_segment_mask)))
 
+static u64 rmp_cfg;
+
 /* Mask to apply to a PFN to get the first PFN of a 2MB page */
 #define PFN_PMD_MASK	GENMASK_ULL(63, PMD_SHIFT - PAGE_SHIFT)
 
@@ -198,12 +204,62 @@ static void __init __snp_fixup_e820_tables(u64 pa)
 	}
 }
 
-void __init snp_fixup_e820_tables(void)
+static void __init fixup_e820_tables_for_segmented_rmp(void)
+{
+	u64 pa, *rst, size, mapped_size;
+	unsigned int i;
+
+	__snp_fixup_e820_tables(probed_rmp_base);
+
+	pa = probed_rmp_base + RMPTABLE_CPU_BOOKKEEPING_SZ;
+
+	__snp_fixup_e820_tables(pa + RST_SIZE);
+
+	rst = early_memremap(pa, RST_SIZE);
+	if (!rst)
+		return;
+
+	for (i = 0; i < rst_max_index; i++) {
+		pa = RST_ENTRY_SEGMENT_BASE(rst[i]);
+		mapped_size = RST_ENTRY_MAPPED_SIZE(rst[i]);
+		if (!mapped_size)
+			continue;
+
+		__snp_fixup_e820_tables(pa);
+
+		/*
+		 * Mapped size in GB. Mapped size is allowed to exceed
+		 * the segment coverage size, but gets reduced to the
+		 * segment coverage size.
+		 */
+		mapped_size <<= 30;
+		if (mapped_size > rmp_segment_size)
+			mapped_size = rmp_segment_size;
+
+		/* Calculate the RMP segment size (16 bytes/page mapped) */
+		size = PHYS_PFN(mapped_size) << 4;
+
+		__snp_fixup_e820_tables(pa + size);
+	}
+
+	early_memunmap(rst, RST_SIZE);
+}
+
+static void __init fixup_e820_tables_for_contiguous_rmp(void)
 {
 	__snp_fixup_e820_tables(probed_rmp_base);
 	__snp_fixup_e820_tables(probed_rmp_base + probed_rmp_size);
 }
 
+void __init snp_fixup_e820_tables(void)
+{
+	if (rmp_cfg & MSR_AMD64_SEG_RMP_ENABLED) {
+		fixup_e820_tables_for_segmented_rmp();
+	} else {
+		fixup_e820_tables_for_contiguous_rmp();
+	}
+}
+
 static bool __init clear_rmptable_bookkeeping(void)
 {
 	void *bk;
@@ -307,29 +363,17 @@ static bool __init alloc_rmp_segment_table(void)
 	return true;
 }
 
-/*
- * Do the necessary preparations which are verified by the firmware as
- * described in the SNP_INIT_EX firmware command description in the SNP
- * firmware ABI spec.
- */
-static int __init snp_rmptable_init(void)
+static bool __init setup_contiguous_rmptable(void)
 {
-	u64 max_rmp_pfn, calc_rmp_sz, rmptable_segment, rmptable_size, rmp_end, val;
-	unsigned int i;
-
-	if (!cc_platform_has(CC_ATTR_HOST_SEV_SNP))
-		return 0;
-
-	if (!amd_iommu_snp_en)
-		goto nosnp;
+	u64 max_rmp_pfn, calc_rmp_sz, rmptable_segment, rmptable_size, rmp_end;
 
 	if (!probed_rmp_size)
-		goto nosnp;
+		return false;
 
 	rmp_end = probed_rmp_base + probed_rmp_size - 1;
 
 	/*
-	 * Calculate the amount the memory that must be reserved by the BIOS to
+	 * Calculate the amount of memory that must be reserved by the BIOS to
 	 * address the whole RAM, including the bookkeeping area. The RMP itself
 	 * must also be covered.
 	 */
@@ -341,11 +385,11 @@ static int __init snp_rmptable_init(void)
 	if (calc_rmp_sz > probed_rmp_size) {
 		pr_err("Memory reserved for the RMP table does not cover full system RAM (expected 0x%llx got 0x%llx)\n",
 		       calc_rmp_sz, probed_rmp_size);
-		goto nosnp;
+		return false;
 	}
 
 	if (!alloc_rmp_segment_table())
-		goto nosnp;
+		return false;
 
 	/* Map only the RMP entries */
 	rmptable_segment = probed_rmp_base + RMPTABLE_CPU_BOOKKEEPING_SZ;
@@ -353,9 +397,128 @@ static int __init snp_rmptable_init(void)
 
 	if (!alloc_rmp_segment_desc(rmptable_segment, rmptable_size, 0)) {
 		free_rmp_segment_table();
-		goto nosnp;
+		return false;
 	}
 
+	return true;
+}
+
+static bool __init setup_segmented_rmptable(void)
+{
+	u64 rst_pa, *rst, pa, ram_pa_end, ram_pa_max;
+	unsigned int i, max_index;
+
+	if (!probed_rmp_base)
+		return false;
+
+	if (!alloc_rmp_segment_table())
+		return false;
+
+	rst_pa = probed_rmp_base + RMPTABLE_CPU_BOOKKEEPING_SZ;
+	rst = memremap(rst_pa, RST_SIZE, MEMREMAP_WB);
+	if (!rst) {
+		pr_err("Failed to map RMP segment table addr 0x%llx\n", rst_pa);
+		goto e_free;
+	}
+
+	pr_info("Segmented RMP using %lluGB segments\n", rmp_segment_size >> 30);
+
+	ram_pa_max = max_pfn << PAGE_SHIFT;
+
+	max_index = 0;
+	ram_pa_end = 0;
+	for (i = 0; i < rst_max_index; i++) {
+		u64 rmp_segment, rmp_size, mapped_size;
+
+		mapped_size = RST_ENTRY_MAPPED_SIZE(rst[i]);
+		if (!mapped_size)
+			continue;
+
+		max_index = i;
+
+		/*
+		 * Mapped size in GB. Mapped size is allowed to exceed the
+		 * segment coverage size, but gets reduced to the segment
+		 * coverage size.
+		 */
+		mapped_size <<= 30;
+		if (mapped_size > rmp_segment_size) {
+			pr_info("RMP segment %u mapped size (0x%llx) reduced to 0x%llx\n",
+				i, mapped_size, rmp_segment_size);
+			mapped_size = rmp_segment_size;
+		}
+
+		rmp_segment = RST_ENTRY_SEGMENT_BASE(rst[i]);
+
+		/* Calculate the RMP segment size (16 bytes/page mapped) */
+		rmp_size = PHYS_PFN(mapped_size) << 4;
+
+		pa = (u64)i << rmp_segment_shift;
+
+		/*
+		 * Some segments may be for MMIO mapped above system RAM. These
+		 * segments are used for Trusted I/O.
+		 */
+		if (pa < ram_pa_max)
+			ram_pa_end = pa + mapped_size;
+
+		if (!alloc_rmp_segment_desc(rmp_segment, rmp_size, pa))
+			goto e_unmap;
+
+		pr_info("RMP segment %u physical address [0x%llx - 0x%llx] covering [0x%llx - 0x%llx]\n",
+			i, rmp_segment, rmp_segment + rmp_size - 1, pa, pa + mapped_size - 1);
+	}
+
+	if (ram_pa_max > ram_pa_end) {
+		pr_err("Segmented RMP does not cover full system RAM (expected 0x%llx got 0x%llx)\n",
+		       ram_pa_max, ram_pa_end);
+		goto e_unmap;
+	}
+
+	/* Adjust the maximum index based on the found segments */
+	rst_max_index = max_index + 1;
+
+	memunmap(rst);
+
+	return true;
+
+e_unmap:
+	memunmap(rst);
+
+e_free:
+	free_rmp_segment_table();
+
+	return false;
+}
+
+static bool __init setup_rmptable(void)
+{
+	if (rmp_cfg & MSR_AMD64_SEG_RMP_ENABLED) {
+		return setup_segmented_rmptable();
+	} else {
+		return setup_contiguous_rmptable();
+	}
+}
+
+/*
+ * Do the necessary preparations which are verified by the firmware as
+ * described in the SNP_INIT_EX firmware command description in the SNP
+ * firmware ABI spec.
+ */
+static int __init snp_rmptable_init(void)
+{
+	unsigned int i;
+	u64 val;
+
+	if (!cc_platform_has(CC_ATTR_HOST_SEV_SNP))
+		return 0;
+
+	if (!amd_iommu_snp_en)
+		goto nosnp;
+
+	if (!setup_rmptable())
+		goto nosnp;
+
 	/*
 	 * Check if SEV-SNP is already enabled, this can happen in case of
 	 * kexec boot.
@@ -419,7 +582,7 @@ static void set_rmp_segment_info(unsigned int segment_shift)
 
 #define RMP_ADDR_MASK GENMASK_ULL(51, 13)
 
-bool snp_probe_rmptable_info(void)
+static bool probe_contiguous_rmptable_info(void)
 {
 	u64 rmp_sz, rmp_base, rmp_end;
 
@@ -452,6 +615,61 @@ bool snp_probe_rmptable_info(void)
 	return true;
 }
 
+static bool probe_segmented_rmptable_info(void)
+{
+	unsigned int eax, ebx, segment_shift, segment_shift_min, segment_shift_max;
+	u64 rmp_base, rmp_end;
+
+	rdmsrl(MSR_AMD64_RMP_BASE, rmp_base);
+	if (!(rmp_base & RMP_ADDR_MASK)) {
+		pr_err("Memory for the RMP table has not been reserved by BIOS\n");
+		return false;
+	}
+
+	rdmsrl(MSR_AMD64_RMP_END, rmp_end);
+	WARN_ONCE(rmp_end & RMP_ADDR_MASK,
+		  "Segmented RMP enabled but RMP_END MSR is non-zero\n");
+
+	/* Obtain the min and max supported RMP segment size */
+	eax = cpuid_eax(0x80000025);
+	segment_shift_min = eax & GENMASK(5, 0);
+	segment_shift_max = (eax & GENMASK(11, 6)) >> 6;
+
+	/* Verify the segment size is within the supported limits */
+	segment_shift = MSR_AMD64_RMP_SEGMENT_SHIFT(rmp_cfg);
+	if (segment_shift > segment_shift_max || segment_shift < segment_shift_min) {
+		pr_err("RMP segment size (%u) is not within advertised bounds (min=%u, max=%u)\n",
+		       segment_shift, segment_shift_min, segment_shift_max);
+		return false;
+	}
+
+	/* Override the max supported RST index if a hardware limit exists */
+	ebx = cpuid_ebx(0x80000025);
+	if (ebx & BIT(10))
+		rst_max_index = ebx & GENMASK(9, 0);
+
+	set_rmp_segment_info(segment_shift);
+
+	probed_rmp_base = rmp_base;
+	probed_rmp_size = 0;
+
+	pr_info("Segmented RMP base table physical range [0x%016llx - 0x%016llx]\n",
+		rmp_base, rmp_base + RMPTABLE_CPU_BOOKKEEPING_SZ + RST_SIZE);
+
+	return true;
+}
+
+bool snp_probe_rmptable_info(void)
+{
+	if (cpu_feature_enabled(X86_FEATURE_SEGMENTED_RMP))
+		rdmsrl(MSR_AMD64_RMP_CFG, rmp_cfg);
+
+	if (rmp_cfg & MSR_AMD64_SEG_RMP_ENABLED)
+		return probe_segmented_rmptable_info();
+	else
+		return probe_contiguous_rmptable_info();
+}
+
 /*
  * About the array_index_nospec() usage below:
  *

