Return-Path: <linux-tip-commits+bounces-4498-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BF92A6EC9B
	for <lists+linux-tip-commits@lfdr.de>; Tue, 25 Mar 2025 10:37:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 040C818977AD
	for <lists+linux-tip-commits@lfdr.de>; Tue, 25 Mar 2025 09:37:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB3552561A4;
	Tue, 25 Mar 2025 09:36:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="An012MBd";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="cwNzFl32"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFCD7254AFC;
	Tue, 25 Mar 2025 09:36:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742895384; cv=none; b=UvxZx7QkobMZeCJwhnH3QYW810g9T/Y5zlDruWewuUoy8IZJ4jewi4jahiWurm8uvDlQ+vNdR7FG3IxNbwo4XsmMtgsVY3E9Mg7Nzxqxv7PzRBilEbDBbQ55CzhrcXPZRcIsw1CZJG5eR5boKpit0myDBTl+oJxVkmfWhKA8UNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742895384; c=relaxed/simple;
	bh=PvmYJIHXuh4/PNS1Yih6n4z7hKocCTLALycVtPCt8cA=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=nnQWIo2B94sUPBLMhtjZAikfuLNA0AzeRy4lOWLbLuWi2oqtyT0TjES4ZvoqewX1sHdkV/BCryaCSeCsUZpHOzAhLqF90tDc2wTbGB6BUVkE+PdKcsc2k1WsvTBBpdX/iyhhpOzrSMtWZuBM9APk0d1kHv3nRVlr627FzMrR438=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=An012MBd; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=cwNzFl32; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 25 Mar 2025 09:36:20 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1742895381;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YyRzWlVTulM47ZEh8YButD+BeIru4FieK8bSNpDuHH0=;
	b=An012MBdlsxYfRnEmW3sGWMoaZWcSSckaiXkfFaKk0HcbCfF0ZRdCivhUzw8Z0L4UOHSTU
	nB5xZCsCYw99zjC7sDzU6xvalgvfWMhDQi9XrFPAlifgQBCUbTPgi0QTyWIWAoyP3a/s9n
	O3C3IdroEFqO8bUrqH7ewiiKbDI1HEif+voaDVjJBsGOtJKVLhhj5zsl4zFyusOojK9Oct
	2+cLskC7Y53WqFVqP3z7tXkVYeLjh4bAxqULEgtF7/GNMpfQ22KgfTdKemwMT0iyu29lyC
	5TycyDySnxBuvw0XYxEmSVCgAlXOUXkZMoVEmLd4Mj+J4z8xm8CTRkriLgDP9A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1742895381;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YyRzWlVTulM47ZEh8YButD+BeIru4FieK8bSNpDuHH0=;
	b=cwNzFl32Uc6GAHQdU0oLZnBizrc7pDtAfjQurUVUvXeghhqoiOX633FXRXk/uZ/v92b3aS
	F7ZB6nA/J/+U4iBA==
From: "tip-bot2 for Ahmed S. Darwish" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: x86/cpu] x86/cpu: Use consolidated CPUID leaf 0x2 descriptor table
Cc: "Ahmed S. Darwish" <darwi@linutronix.de>, Ingo Molnar <mingo@kernel.org>,
 "H. Peter Anvin" <hpa@zytor.com>,
 Linus Torvalds <torvalds@linux-foundation.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250324133324.23458-23-darwi@linutronix.de>
References: <20250324133324.23458-23-darwi@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174289538037.14745.8750324462532221337.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/cpu branch of tip:

Commit-ID:     4772304ee651b952fd098ec80a8298af9905743f
Gitweb:        https://git.kernel.org/tip/4772304ee651b952fd098ec80a8298af9905743f
Author:        Ahmed S. Darwish <darwi@linutronix.de>
AuthorDate:    Mon, 24 Mar 2025 14:33:17 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 25 Mar 2025 10:23:12 +01:00

x86/cpu: Use consolidated CPUID leaf 0x2 descriptor table

CPUID leaf 0x2 output is a stream of one-byte descriptors, each implying
certain details about the CPU's cache and TLB entries.

At previous commits, the mapping tables for such descriptors were merged
into one consolidated table.  The mapping was also transformed into a
hash lookup instead of a loop-based lookup for each descriptor.

Use the new consolidated table and its hash-based lookup through the
for_each_leaf_0x2_tlb_entry() accessor.

Remove the TLB-specific mapping, intel_tlb_table[], as it is now no
longer used.  Remove the <cpuid/types.h> macro, for_each_leaf_0x2_desc(),
since the converted code was its last user.

Signed-off-by: Ahmed S. Darwish <darwi@linutronix.de>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Link: https://lore.kernel.org/r/20250324133324.23458-23-darwi@linutronix.de
---
 arch/x86/include/asm/cpuid/types.h | 10 +++-
 arch/x86/kernel/cpu/intel.c        | 83 ++---------------------------
 2 files changed, 17 insertions(+), 76 deletions(-)

diff --git a/arch/x86/include/asm/cpuid/types.h b/arch/x86/include/asm/cpuid/types.h
index 24f643f..c95fee6 100644
--- a/arch/x86/include/asm/cpuid/types.h
+++ b/arch/x86/include/asm/cpuid/types.h
@@ -115,4 +115,14 @@ struct leaf_0x2_table {
 
 extern const struct leaf_0x2_table cpuid_0x2_table[256];
 
+/*
+ * All of leaf 0x2's one-byte TLB descriptors implies the same number of entries
+ * for their respective TLB types.  TLB descriptor 0x63 is an exception: it
+ * implies 4 dTLB entries for 1GB pages and 32 dTLB entries for 2MB or 4MB pages.
+ *
+ * Encode that descriptor's dTLB entry count for 2MB/4MB pages here, as the entry
+ * count for dTLB 1GB pages is already encoded at the cpuid_0x2_table[]'s mapping.
+ */
+#define TLB_0x63_2M_4M_ENTRIES		32
+
 #endif /* _ASM_X86_CPUID_TYPES_H */
diff --git a/arch/x86/kernel/cpu/intel.c b/arch/x86/kernel/cpu/intel.c
index def433e..e5d8147 100644
--- a/arch/x86/kernel/cpu/intel.c
+++ b/arch/x86/kernel/cpu/intel.c
@@ -626,81 +626,11 @@ static unsigned int intel_size_cache(struct cpuinfo_x86 *c, unsigned int size)
 }
 #endif
 
-/*
- * All of leaf 0x2's one-byte TLB descriptors implies the same number of
- * entries for their respective TLB types.  The 0x63 descriptor is an
- * exception: it implies 4 dTLB entries for 1GB pages 32 dTLB entries
- * for 2MB or 4MB pages.  Encode descriptor 0x63 dTLB entry count for
- * 2MB/4MB pages here, as its count for dTLB 1GB pages is already at the
- * intel_tlb_table[] mapping.
- */
-#define TLB_0x63_2M_4M_ENTRIES	32
-
-struct _tlb_table {
-	unsigned char descriptor;
-	enum _tlb_table_type type;
-	unsigned int entries;
-};
-
-static const struct _tlb_table intel_tlb_table[] = {
-	{ 0x01, TLB_INST_4K,		32},	/* TLB_INST 4 KByte pages, 4-way set associative */
-	{ 0x02, TLB_INST_4M,		2},	/* TLB_INST 4 MByte pages, full associative */
-	{ 0x03, TLB_DATA_4K,		64},	/* TLB_DATA 4 KByte pages, 4-way set associative */
-	{ 0x04, TLB_DATA_4M,		8},	/* TLB_DATA 4 MByte pages, 4-way set associative */
-	{ 0x05, TLB_DATA_4M,		32},	/* TLB_DATA 4 MByte pages, 4-way set associative */
-	{ 0x0b, TLB_INST_4M,		4},	/* TLB_INST 4 MByte pages, 4-way set associative */
-	{ 0x4f, TLB_INST_4K,		32},	/* TLB_INST 4 KByte pages */
-	{ 0x50, TLB_INST_ALL,		64},	/* TLB_INST 4 KByte and 2-MByte or 4-MByte pages */
-	{ 0x51, TLB_INST_ALL,		128},	/* TLB_INST 4 KByte and 2-MByte or 4-MByte pages */
-	{ 0x52, TLB_INST_ALL,		256},	/* TLB_INST 4 KByte and 2-MByte or 4-MByte pages */
-	{ 0x55, TLB_INST_2M_4M,		7},	/* TLB_INST 2-MByte or 4-MByte pages, fully associative */
-	{ 0x56, TLB_DATA0_4M,		16},	/* TLB_DATA0 4 MByte pages, 4-way set associative */
-	{ 0x57, TLB_DATA0_4K,		16},	/* TLB_DATA0 4 KByte pages, 4-way associative */
-	{ 0x59, TLB_DATA0_4K,		16},	/* TLB_DATA0 4 KByte pages, fully associative */
-	{ 0x5a, TLB_DATA0_2M_4M,	32},	/* TLB_DATA0 2-MByte or 4 MByte pages, 4-way set associative */
-	{ 0x5b, TLB_DATA_4K_4M,		64},	/* TLB_DATA 4 KByte and 4 MByte pages */
-	{ 0x5c, TLB_DATA_4K_4M,		128},	/* TLB_DATA 4 KByte and 4 MByte pages */
-	{ 0x5d, TLB_DATA_4K_4M,		256},	/* TLB_DATA 4 KByte and 4 MByte pages */
-	{ 0x61, TLB_INST_4K,		48},	/* TLB_INST 4 KByte pages, full associative */
-	{ 0x63, TLB_DATA_1G_2M_4M,	4},	/* TLB_DATA 1 GByte pages, 4-way set associative
-						 * (plus 32 entries TLB_DATA 2 MByte or 4 MByte pages, not encoded here) */
-	{ 0x6b, TLB_DATA_4K,		256},	/* TLB_DATA 4 KByte pages, 8-way associative */
-	{ 0x6c, TLB_DATA_2M_4M,		128},	/* TLB_DATA 2 MByte or 4 MByte pages, 8-way associative */
-	{ 0x6d, TLB_DATA_1G,		16},	/* TLB_DATA 1 GByte pages, fully associative */
-	{ 0x76, TLB_INST_2M_4M,		8},	/* TLB_INST 2-MByte or 4-MByte pages, fully associative */
-	{ 0xb0, TLB_INST_4K,		128},	/* TLB_INST 4 KByte pages, 4-way set associative */
-	{ 0xb1, TLB_INST_2M_4M,		4},	/* TLB_INST 2M pages, 4-way, 8 entries or 4M pages, 4-way entries */
-	{ 0xb2, TLB_INST_4K,		64},	/* TLB_INST 4KByte pages, 4-way set associative */
-	{ 0xb3, TLB_DATA_4K,		128},	/* TLB_DATA 4 KByte pages, 4-way set associative */
-	{ 0xb4, TLB_DATA_4K,		256},	/* TLB_DATA 4 KByte pages, 4-way associative */
-	{ 0xb5, TLB_INST_4K,		64},	/* TLB_INST 4 KByte pages, 8-way set associative */
-	{ 0xb6, TLB_INST_4K,		128},	/* TLB_INST 4 KByte pages, 8-way set associative */
-	{ 0xba, TLB_DATA_4K,		64},	/* TLB_DATA 4 KByte pages, 4-way associative */
-	{ 0xc0, TLB_DATA_4K_4M,		8},	/* TLB_DATA 4 KByte and 4 MByte pages, 4-way associative */
-	{ 0xc1, STLB_4K_2M,		1024},	/* STLB 4 KByte and 2 MByte pages, 8-way associative */
-	{ 0xc2, TLB_DATA_2M_4M,		16},	/* TLB_DATA 2 MByte/4MByte pages, 4-way associative */
-	{ 0xca, STLB_4K,		512},	/* STLB 4 KByte pages, 4-way associative */
-	{ 0x00, 0, 0 }
-};
-
-static void intel_tlb_lookup(const unsigned char desc)
+static void intel_tlb_lookup(const struct leaf_0x2_table *entry)
 {
-	unsigned int entries;
-	unsigned char k;
-
-	if (desc == 0)
-		return;
-
-	/* look up this descriptor in the table */
-	for (k = 0; intel_tlb_table[k].descriptor != desc &&
-	     intel_tlb_table[k].descriptor != 0; k++)
-		;
-
-	if (intel_tlb_table[k].type == 0)
-		return;
+	short entries = entry->entries;
 
-	entries = intel_tlb_table[k].entries;
-	switch (intel_tlb_table[k].type) {
+	switch (entry->t_type) {
 	case STLB_4K:
 		tlb_lli_4k = max(tlb_lli_4k, entries);
 		tlb_lld_4k = max(tlb_lld_4k, entries);
@@ -757,15 +687,16 @@ static void intel_tlb_lookup(const unsigned char desc)
 
 static void intel_detect_tlb(struct cpuinfo_x86 *c)
 {
+	const struct leaf_0x2_table *entry;
 	union leaf_0x2_regs regs;
-	u8 *desc;
+	u8 *ptr;
 
 	if (c->cpuid_level < 2)
 		return;
 
 	cpuid_get_leaf_0x2_regs(&regs);
-	for_each_leaf_0x2_desc(regs, desc)
-		intel_tlb_lookup(*desc);
+	for_each_leaf_0x2_entry(regs, ptr, entry)
+		intel_tlb_lookup(entry);
 }
 
 static const struct cpu_dev intel_cpu_dev = {

