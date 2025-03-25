Return-Path: <linux-tip-commits+bounces-4499-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DDF10A6ECAC
	for <lists+linux-tip-commits@lfdr.de>; Tue, 25 Mar 2025 10:38:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9302A3A8733
	for <lists+linux-tip-commits@lfdr.de>; Tue, 25 Mar 2025 09:37:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C686A2566C4;
	Tue, 25 Mar 2025 09:36:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="GxE7GU1U";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="VmvEGnkg"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BEE5255E20;
	Tue, 25 Mar 2025 09:36:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742895385; cv=none; b=YY7AV8/acpli/3Y+40tsZvy+wlJDLWSmW92JnPmUOhJa8pid5qiBKAoSpTTVIgnv1SZxTYeaIAJ0FUyul0wvXHaLyNZUBpBzl7LSznceLXib0LU2H5PBbFUDSGqx5m2uFCe68cMx82PIWd2Z5ANsEm0WxMq2XbKByJU2VtB8VPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742895385; c=relaxed/simple;
	bh=QAn8OW63BVBy1OaixKgMpK66w4goWAmrc8DhaUkwWJ0=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=g6pgemxfWckhJkfnBfmAt6wuYZ03D4fRv34+DgGMPykf+Q2hTutcuqb3+gzLfvvv+I2t6Gvy5hs0xMau5oa9F5QjDaGlIbVlHCLTTIgDokRK1hIiGHhXEzKoCJdMUBz+nuDMkgbOu0ukKyR74WqK05fF3FkVTQqxhCOBbSm1hjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=GxE7GU1U; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=VmvEGnkg; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 25 Mar 2025 09:36:21 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1742895381;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mr99gRrZyIGtfDjiTA0v4TRrIJpwcsXpW8lcsPM2i3M=;
	b=GxE7GU1Uo1pXvKtrVUHGGiCNu8rUEbnyDpVk/XKpIF5IGW0EGY+5vMLcNhXYnqld3RDHnz
	4mLG104WdpCBIn00T4Yusfs5vNYEhckZUZemH1q1uhzVyLvhutyB9zmV0F/Y02nC6m54KD
	TSZoZ0hYumw/VoK2KwTrgj4krKe80QuFtMGQN6sZCVZBnxrtxE+5tszU2yUiO0UIoCkjkA
	EugV03tAVzshv3RuJEfcOSdTRSWFnFRdjx9hrGucPy+yCC1z/UhUhBWwjMVY8s1SRjnx4e
	tZ8pTyTu5PJCvWY7ijt7eOnGgxHEDA16HVWFIxIzCXLrQ+68ERYaCByei5I9Bw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1742895381;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mr99gRrZyIGtfDjiTA0v4TRrIJpwcsXpW8lcsPM2i3M=;
	b=VmvEGnkguw3mV9JRMNPqa1MYy+npuTvsILyntkNvzhDIuv7THk9QqT7pOxQAYx88d+DlAS
	+GAWYIsN/T5JtSCw==
From: "tip-bot2 for Ahmed S. Darwish" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cpu] x86/cacheinfo: Use consolidated CPUID leaf 0x2
 descriptor table
Cc: "Ahmed S. Darwish" <darwi@linutronix.de>, Ingo Molnar <mingo@kernel.org>,
 "H. Peter Anvin" <hpa@zytor.com>,
 Linus Torvalds <torvalds@linux-foundation.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250324133324.23458-22-darwi@linutronix.de>
References: <20250324133324.23458-22-darwi@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174289538119.14745.2812738895510094479.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/cpu branch of tip:

Commit-ID:     da23a6259844b576d98ad5c633eb437d3a2d90d3
Gitweb:        https://git.kernel.org/tip/da23a6259844b576d98ad5c633eb437d3a2d90d3
Author:        Ahmed S. Darwish <darwi@linutronix.de>
AuthorDate:    Mon, 24 Mar 2025 14:33:16 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 25 Mar 2025 10:23:08 +01:00

x86/cacheinfo: Use consolidated CPUID leaf 0x2 descriptor table

CPUID leaf 0x2 output is a stream of one-byte descriptors, each implying
certain details about the CPU's cache and TLB entries.

At previous commits, the mapping tables for such descriptors were merged
into one consolidated table.  The mapping was also transformed into a
hash lookup instead of a loop-based lookup for each descriptor.

Use the new consolidated table and its hash-based lookup through the
for_each_leaf_0x2_tlb_entry() accessor.  Remove the old cache-specific
mapping, cache_table[], as it is no longer used.

Signed-off-by: Ahmed S. Darwish <darwi@linutronix.de>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Link: https://lore.kernel.org/r/20250324133324.23458-22-darwi@linutronix.de
---
 arch/x86/kernel/cpu/cacheinfo.c | 114 ++-----------------------------
 1 file changed, 8 insertions(+), 106 deletions(-)

diff --git a/arch/x86/kernel/cpu/cacheinfo.c b/arch/x86/kernel/cpu/cacheinfo.c
index 09c5aa9..e399bf2 100644
--- a/arch/x86/kernel/cpu/cacheinfo.c
+++ b/arch/x86/kernel/cpu/cacheinfo.c
@@ -34,90 +34,6 @@ static cpumask_var_t cpu_cacheinfo_mask;
 /* Kernel controls MTRR and/or PAT MSRs. */
 unsigned int memory_caching_control __ro_after_init;
 
-struct _cache_table {
-	u8 descriptor;
-	enum _cache_table_type type;
-	short size;
-};
-
-#define MB(x)	((x) * 1024)
-
-/* All the cache descriptor types we care about (no TLB or
-   trace cache entries) */
-
-static const struct _cache_table cache_table[] =
-{
-	{ 0x06, CACHE_L1_INST,	8	},	/* 4-way set assoc, 32 byte line size */
-	{ 0x08, CACHE_L1_INST,	16	},	/* 4-way set assoc, 32 byte line size */
-	{ 0x09, CACHE_L1_INST,	32	},	/* 4-way set assoc, 64 byte line size */
-	{ 0x0a, CACHE_L1_DATA,	8	},	/* 2 way set assoc, 32 byte line size */
-	{ 0x0c, CACHE_L1_DATA,	16	},	/* 4-way set assoc, 32 byte line size */
-	{ 0x0d, CACHE_L1_DATA,	16	},	/* 4-way set assoc, 64 byte line size */
-	{ 0x0e, CACHE_L1_DATA,	24	},	/* 6-way set assoc, 64 byte line size */
-	{ 0x21, CACHE_L2,	256	},	/* 8-way set assoc, 64 byte line size */
-	{ 0x22, CACHE_L3,	512	},	/* 4-way set assoc, sectored cache, 64 byte line size */
-	{ 0x23, CACHE_L3,	MB(1)	},	/* 8-way set assoc, sectored cache, 64 byte line size */
-	{ 0x25, CACHE_L3,	MB(2)	},	/* 8-way set assoc, sectored cache, 64 byte line size */
-	{ 0x29, CACHE_L3,	MB(4)	},	/* 8-way set assoc, sectored cache, 64 byte line size */
-	{ 0x2c, CACHE_L1_DATA,	32	},	/* 8-way set assoc, 64 byte line size */
-	{ 0x30, CACHE_L1_INST,	32	},	/* 8-way set assoc, 64 byte line size */
-	{ 0x39, CACHE_L2,	128	},	/* 4-way set assoc, sectored cache, 64 byte line size */
-	{ 0x3a, CACHE_L2,	192	},	/* 6-way set assoc, sectored cache, 64 byte line size */
-	{ 0x3b, CACHE_L2,	128	},	/* 2-way set assoc, sectored cache, 64 byte line size */
-	{ 0x3c, CACHE_L2,	256	},	/* 4-way set assoc, sectored cache, 64 byte line size */
-	{ 0x3d, CACHE_L2,	384	},	/* 6-way set assoc, sectored cache, 64 byte line size */
-	{ 0x3e, CACHE_L2,	512	},	/* 4-way set assoc, sectored cache, 64 byte line size */
-	{ 0x3f, CACHE_L2,	256	},	/* 2-way set assoc, 64 byte line size */
-	{ 0x41, CACHE_L2,	128	},	/* 4-way set assoc, 32 byte line size */
-	{ 0x42, CACHE_L2,	256	},	/* 4-way set assoc, 32 byte line size */
-	{ 0x43, CACHE_L2,	512	},	/* 4-way set assoc, 32 byte line size */
-	{ 0x44, CACHE_L2,	MB(1)	},	/* 4-way set assoc, 32 byte line size */
-	{ 0x45, CACHE_L2,	MB(2)	},	/* 4-way set assoc, 32 byte line size */
-	{ 0x46, CACHE_L3,	MB(4)	},	/* 4-way set assoc, 64 byte line size */
-	{ 0x47, CACHE_L3,	MB(8)	},	/* 8-way set assoc, 64 byte line size */
-	{ 0x48, CACHE_L2,	MB(3)	},	/* 12-way set assoc, 64 byte line size */
-	{ 0x49, CACHE_L3,	MB(4)	},	/* 16-way set assoc, 64 byte line size */
-	{ 0x4a, CACHE_L3,	MB(6)	},	/* 12-way set assoc, 64 byte line size */
-	{ 0x4b, CACHE_L3,	MB(8)	},	/* 16-way set assoc, 64 byte line size */
-	{ 0x4c, CACHE_L3,	MB(12)	},	/* 12-way set assoc, 64 byte line size */
-	{ 0x4d, CACHE_L3,	MB(16)	},	/* 16-way set assoc, 64 byte line size */
-	{ 0x4e, CACHE_L2,	MB(6)	},	/* 24-way set assoc, 64 byte line size */
-	{ 0x60, CACHE_L1_DATA,	16	},	/* 8-way set assoc, sectored cache, 64 byte line size */
-	{ 0x66, CACHE_L1_DATA,	8	},	/* 4-way set assoc, sectored cache, 64 byte line size */
-	{ 0x67, CACHE_L1_DATA,	16	},	/* 4-way set assoc, sectored cache, 64 byte line size */
-	{ 0x68, CACHE_L1_DATA,	32	},	/* 4-way set assoc, sectored cache, 64 byte line size */
-	{ 0x78, CACHE_L2,	MB(1)	},	/* 4-way set assoc, 64 byte line size */
-	{ 0x79, CACHE_L2,	128	},	/* 8-way set assoc, sectored cache, 64 byte line size */
-	{ 0x7a, CACHE_L2,	256	},	/* 8-way set assoc, sectored cache, 64 byte line size */
-	{ 0x7b, CACHE_L2,	512	},	/* 8-way set assoc, sectored cache, 64 byte line size */
-	{ 0x7c, CACHE_L2,	MB(1)	},	/* 8-way set assoc, sectored cache, 64 byte line size */
-	{ 0x7d, CACHE_L2,	MB(2)	},	/* 8-way set assoc, 64 byte line size */
-	{ 0x7f, CACHE_L2,	512	},	/* 2-way set assoc, 64 byte line size */
-	{ 0x80, CACHE_L2,	512	},	/* 8-way set assoc, 64 byte line size */
-	{ 0x82, CACHE_L2,	256	},	/* 8-way set assoc, 32 byte line size */
-	{ 0x83, CACHE_L2,	512	},	/* 8-way set assoc, 32 byte line size */
-	{ 0x84, CACHE_L2,	MB(1)	},	/* 8-way set assoc, 32 byte line size */
-	{ 0x85, CACHE_L2,	MB(2)	},	/* 8-way set assoc, 32 byte line size */
-	{ 0x86, CACHE_L2,	512	},	/* 4-way set assoc, 64 byte line size */
-	{ 0x87, CACHE_L2,	MB(1)	},	/* 8-way set assoc, 64 byte line size */
-	{ 0xd0, CACHE_L3,	512	},	/* 4-way set assoc, 64 byte line size */
-	{ 0xd1, CACHE_L3,	MB(1)	},	/* 4-way set assoc, 64 byte line size */
-	{ 0xd2, CACHE_L3,	MB(2)	},	/* 4-way set assoc, 64 byte line size */
-	{ 0xd6, CACHE_L3,	MB(1)	},	/* 8-way set assoc, 64 byte line size */
-	{ 0xd7, CACHE_L3,	MB(2)	},	/* 8-way set assoc, 64 byte line size */
-	{ 0xd8, CACHE_L3,	MB(4)	},	/* 12-way set assoc, 64 byte line size */
-	{ 0xdc, CACHE_L3,	MB(2)	},	/* 12-way set assoc, 64 byte line size */
-	{ 0xdd, CACHE_L3,	MB(4)	},	/* 12-way set assoc, 64 byte line size */
-	{ 0xde, CACHE_L3,	MB(8)	},	/* 12-way set assoc, 64 byte line size */
-	{ 0xe2, CACHE_L3,	MB(2)	},	/* 16-way set assoc, 64 byte line size */
-	{ 0xe3, CACHE_L3,	MB(4)	},	/* 16-way set assoc, 64 byte line size */
-	{ 0xe4, CACHE_L3,	MB(8)	},	/* 16-way set assoc, 64 byte line size */
-	{ 0xea, CACHE_L3,	MB(12)	},	/* 24-way set assoc, 64 byte line size */
-	{ 0xeb, CACHE_L3,	MB(18)	},	/* 24-way set assoc, 64 byte line size */
-	{ 0xec, CACHE_L3,	MB(24)	},	/* 24-way set assoc, 64 byte line size */
-};
-
-
 enum _cache_type {
 	CTYPE_NULL = 0,
 	CTYPE_DATA = 1,
@@ -439,16 +355,6 @@ void init_hygon_cacheinfo(struct cpuinfo_x86 *c)
 	ci->num_leaves = find_num_cache_leaves(c);
 }
 
-static const struct _cache_table *cache_table_get(u8 desc)
-{
-	for (int i = 0; i < ARRAY_SIZE(cache_table); i++) {
-		if (cache_table[i].descriptor == desc)
-			return &cache_table[i];
-	}
-
-	return NULL;
-}
-
 void init_intel_cacheinfo(struct cpuinfo_x86 *c)
 {
 	/* Cache sizes */
@@ -505,21 +411,17 @@ void init_intel_cacheinfo(struct cpuinfo_x86 *c)
 
 	/* Don't use CPUID(2) if CPUID(4) is supported. */
 	if (!ci->num_leaves && c->cpuid_level > 1) {
-		const struct _cache_table *entry;
+		const struct leaf_0x2_table *entry;
 		union leaf_0x2_regs regs;
-		u8 *desc;
+		u8 *ptr;
 
 		cpuid_get_leaf_0x2_regs(&regs);
-		for_each_leaf_0x2_desc(regs, desc) {
-			entry = cache_table_get(*desc);
-			if (!entry)
-				continue;
-
-			switch (entry->type) {
-			case CACHE_L1_INST:	l1i += entry->size; break;
-			case CACHE_L1_DATA:	l1d += entry->size; break;
-			case CACHE_L2:		l2  += entry->size; break;
-			case CACHE_L3:		l3  += entry->size; break;
+		for_each_leaf_0x2_entry(regs, ptr, entry) {
+			switch (entry->c_type) {
+			case CACHE_L1_INST:	l1i += entry->c_size; break;
+			case CACHE_L1_DATA:	l1d += entry->c_size; break;
+			case CACHE_L2:		l2  += entry->c_size; break;
+			case CACHE_L3:		l3  += entry->c_size; break;
 			}
 		}
 	}

