Return-Path: <linux-tip-commits+bounces-4500-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 63F85A6EC9F
	for <lists+linux-tip-commits@lfdr.de>; Tue, 25 Mar 2025 10:37:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 934FE18978FC
	for <lists+linux-tip-commits@lfdr.de>; Tue, 25 Mar 2025 09:37:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0ADA2566F2;
	Tue, 25 Mar 2025 09:36:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="3TfvdHw+";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="TqcBBRSm"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD2322561BC;
	Tue, 25 Mar 2025 09:36:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742895386; cv=none; b=KGhKwiGr2kVt6TMsBJ7JisH78Q/hPjElE0ptugTmBdjd+eucpLWrm5B0ouosjOis5/GUeKfhuui5X46OY/fqBaC6w7e25Aeut3YWv7pw+ji8prk/oVmowkL3aQIGmmA9gmPv6a3HiJrdCGYE0Q3rIFe9XErmAQNd06uS8DOwQYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742895386; c=relaxed/simple;
	bh=Nzlr073dQBMasIY7d0yXaMSdfj2hyhC6SZjr2f/7cEc=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=tEEYgsMhdyTDcoZoEj/N2ryFucZdwayS1JS8kckr13gODDlCggabpTfLIMQsZBSEImSAanSn7FijGUHbTQEgrLM+ODhu0DcRoLx1SufEGvcAy+qZMjafnD/BVEApItYiymtJovvtzhHIM007EbT5d/2mCjHrgK8nzkMhwX1MBUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=3TfvdHw+; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=TqcBBRSm; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 25 Mar 2025 09:36:22 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1742895383;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kYcVqlyGSDQ8tPKvw69gxWJzeEIb26plZkVqyLiAau8=;
	b=3TfvdHw+BnGLDziX8N15bruAEJ7lAvgblXCnmCy4wVr10dUhL0WxDxhdT8+fnwjFT+80QR
	+K04cwpGuHhUoQJA/3gB7qm3bYp/sveE2Lce/17Qlab6lyo43bkYk8EgJWR5RzQQo3sosB
	fws/5WcQhM3oOgYMoTnBOtx5LkI62psIoTueBMxjGi1Q9hWQcMI7gADvZ3EGAFmnMScOzw
	+hGGH41cSbknQHQJbpEndT56aF/I9ggkYBWhqrco7HUJMJ9oAlEf9x7sFkwvTYqaGfAFlo
	rk4qfqiJaXIJxbJ6n1QU8o1kCDYO2OjQ2eQ8NjxNrxT27G4Dm/L6uJdbKsfV7g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1742895383;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kYcVqlyGSDQ8tPKvw69gxWJzeEIb26plZkVqyLiAau8=;
	b=TqcBBRSmIoc0HeN6OVHtktgm0qF2vkh20Bqvv2Zv/4rWMOw1ad+B6J8W+ajpRAj+k/s1DW
	/A91WcXwkoMjC1Dw==
From: "tip-bot2 for Ahmed S. Darwish" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cpu] x86/cpu: Use enums for TLB descriptor types
Cc: "Ahmed S. Darwish" <darwi@linutronix.de>, Ingo Molnar <mingo@kernel.org>,
 "H. Peter Anvin" <hpa@zytor.com>,
 Linus Torvalds <torvalds@linux-foundation.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250324133324.23458-20-darwi@linutronix.de>
References: <20250324133324.23458-20-darwi@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174289538275.14745.15529363240425062884.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/cpu branch of tip:

Commit-ID:     543904cdfe1eb53ff4267f561a4d59cb1fe6ceb7
Gitweb:        https://git.kernel.org/tip/543904cdfe1eb53ff4267f561a4d59cb1fe6ceb7
Author:        Ahmed S. Darwish <darwi@linutronix.de>
AuthorDate:    Mon, 24 Mar 2025 14:33:14 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 25 Mar 2025 10:23:00 +01:00

x86/cpu: Use enums for TLB descriptor types

The leaf 0x2 one-byte TLB descriptor types:

	TLB_INST_4K
	TLB_INST_4M
	TLB_INST_2M_4M
	...

are just discriminators to be used within the intel_tlb_table[] mapping.
Their specific values are irrelevant.

Use enums for such types.

Make the enum packed and static assert that its values remain within a
single byte so that the intel_tlb_table[] size do not go out of hand.

Use a __CHECKER__ guard for the static_assert(sizeof(enum) == 1) line as
sparse ignores the __packed annotation on enums.

This is similar to:

  fe3944fb245a ("fs: Move enum rw_hint into a new header file")

for the core SCSI code.

Signed-off-by: Ahmed S. Darwish <darwi@linutronix.de>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Link: https://lore.kernel.org/r/Z9rsTirs9lLfEPD9@lx-t490
Link: https://lore.kernel.org/r/20250324133324.23458-20-darwi@linutronix.de
---
 arch/x86/include/asm/cpuid/types.h | 31 +++++++++++++++++++++++++++++-
 arch/x86/kernel/cpu/intel.c        | 28 ++------------------------
 2 files changed, 34 insertions(+), 25 deletions(-)

diff --git a/arch/x86/include/asm/cpuid/types.h b/arch/x86/include/asm/cpuid/types.h
index 39c3c79..e756327 100644
--- a/arch/x86/include/asm/cpuid/types.h
+++ b/arch/x86/include/asm/cpuid/types.h
@@ -60,4 +60,35 @@ enum _cache_table_type {
 static_assert(sizeof(enum _cache_table_type) == 1);
 #endif
 
+/*
+ * Leaf 0x2 1-byte descriptors' TLB types
+ * To be used for their mappings at intel_tlb_table[]
+ *
+ * Start at 1 since type 0 is reserved for HW byte descriptors which are
+ * not recognized by the kernel; i.e., those without an explicit mapping.
+ */
+enum _tlb_table_type {
+	TLB_INST_4K		= 1,
+	TLB_INST_4M,
+	TLB_INST_2M_4M,
+	TLB_INST_ALL,
+
+	TLB_DATA_4K,
+	TLB_DATA_4M,
+	TLB_DATA_2M_4M,
+	TLB_DATA_4K_4M,
+	TLB_DATA_1G,
+	TLB_DATA_1G_2M_4M,
+
+	TLB_DATA0_4K,
+	TLB_DATA0_4M,
+	TLB_DATA0_2M_4M,
+
+	STLB_4K,
+	STLB_4K_2M,
+} __packed;
+#ifndef __CHECKER__
+static_assert(sizeof(enum _tlb_table_type) == 1);
+#endif
+
 #endif /* _ASM_X86_CPUID_TYPES_H */
diff --git a/arch/x86/kernel/cpu/intel.c b/arch/x86/kernel/cpu/intel.c
index aeb7d6d..def433e 100644
--- a/arch/x86/kernel/cpu/intel.c
+++ b/arch/x86/kernel/cpu/intel.c
@@ -626,28 +626,6 @@ static unsigned int intel_size_cache(struct cpuinfo_x86 *c, unsigned int size)
 }
 #endif
 
-#define TLB_INST_4K		0x01
-#define TLB_INST_4M		0x02
-#define TLB_INST_2M_4M		0x03
-
-#define TLB_INST_ALL		0x05
-#define TLB_INST_1G		0x06
-
-#define TLB_DATA_4K		0x11
-#define TLB_DATA_4M		0x12
-#define TLB_DATA_2M_4M		0x13
-#define TLB_DATA_4K_4M		0x14
-
-#define TLB_DATA_1G		0x16
-#define TLB_DATA_1G_2M_4M	0x17
-
-#define TLB_DATA0_4K		0x21
-#define TLB_DATA0_4M		0x22
-#define TLB_DATA0_2M_4M		0x23
-
-#define STLB_4K			0x41
-#define STLB_4K_2M		0x42
-
 /*
  * All of leaf 0x2's one-byte TLB descriptors implies the same number of
  * entries for their respective TLB types.  The 0x63 descriptor is an
@@ -660,7 +638,7 @@ static unsigned int intel_size_cache(struct cpuinfo_x86 *c, unsigned int size)
 
 struct _tlb_table {
 	unsigned char descriptor;
-	char tlb_type;
+	enum _tlb_table_type type;
 	unsigned int entries;
 };
 
@@ -718,11 +696,11 @@ static void intel_tlb_lookup(const unsigned char desc)
 	     intel_tlb_table[k].descriptor != 0; k++)
 		;
 
-	if (intel_tlb_table[k].tlb_type == 0)
+	if (intel_tlb_table[k].type == 0)
 		return;
 
 	entries = intel_tlb_table[k].entries;
-	switch (intel_tlb_table[k].tlb_type) {
+	switch (intel_tlb_table[k].type) {
 	case STLB_4K:
 		tlb_lli_4k = max(tlb_lli_4k, entries);
 		tlb_lld_4k = max(tlb_lld_4k, entries);

