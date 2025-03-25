Return-Path: <linux-tip-commits+bounces-4491-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B03E1A6EC8E
	for <lists+linux-tip-commits@lfdr.de>; Tue, 25 Mar 2025 10:36:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 34F74188F831
	for <lists+linux-tip-commits@lfdr.de>; Tue, 25 Mar 2025 09:36:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04C871DE3D9;
	Tue, 25 Mar 2025 09:36:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="3Y/JS9eQ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="6l83qKyy"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90B0F1946AA;
	Tue, 25 Mar 2025 09:36:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742895378; cv=none; b=JGG4b2AsETUiM8C88GR0s6oR149vPLosmrbuZ0PymebXbXWWbFbQcsv5NcfhLWHPRCqC0U2q2eHCA70yBfZ3P/jYD15GUsQiHGxIE6H8MVSWlwrHSMn/bYril0+gTMmC86ImbYNjKXP2oRoCBljb8v2ehEF20VM2Nib27paTCGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742895378; c=relaxed/simple;
	bh=jreVPTHO2RJi3DiT3hY8o2jDQEv64Yv+/U2OXhadrkw=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=OMhMkq35T7pKNwt3X9gkLWsJocc1SMIOR5Hdikd2lX6GxsOP4xGiAD4MpOS38ckkOrwx9hrbIdxHznCyDLmcgScTBvHTIUCm8bH16q82jnb5NqZ3Yxkc4zzvG/WzhJQsGBH60UU+a1/P5OkSGUwdbCKXpfI+Uu5SUyEaGpHw8f0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=3Y/JS9eQ; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=6l83qKyy; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 25 Mar 2025 09:36:14 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1742895374;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=32uCVBam47st4HTXMHJ13fiS3tSm28Ddt5FvR15z62E=;
	b=3Y/JS9eQTaJSIZvZUQSRWqp7vehh/Oj/tNfG+vuM4DzZjyisIAQWgrIxxsD66dvshVq1j1
	88taDk3bg8XQQdQxdN7cw6PQwvxLEP6eGZld0QaITPRJPvUO+1np4I+EbKWXX2y7B+TlFY
	lXaTx6x4/ppXt9XLzVsWdArlWqZGbcOnbly97IKl93g94zlwdTM/SWsBVQzVL2WtaOVUj1
	2FiBv619vzS1HDopxbNS/fjED1jK7CpY0YbOdLyufCN/uAXBbFWVClLH8e2FPZyTzcRENX
	vmICKT9djRXlWtG8J8S1/JbXhN0Tj1oc4hNMK2ASHK0iIoYAezlmBcVEhF+UGg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1742895374;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=32uCVBam47st4HTXMHJ13fiS3tSm28Ddt5FvR15z62E=;
	b=6l83qKyyyQBx+fWfpqq7jODtB/s+pm60L4OYP3fajZ/vI0tyhXlyaDzi0VVpiwG/iLifv8
	CkEGwF3ubOI+btBA==
From: "tip-bot2 for Ahmed S. Darwish" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cpu] x86/cacheinfo: Apply maintainer-tip coding style fixes
Cc: "Ahmed S. Darwish" <darwi@linutronix.de>, Ingo Molnar <mingo@kernel.org>,
 "H. Peter Anvin" <hpa@zytor.com>,
 Linus Torvalds <torvalds@linux-foundation.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250324133324.23458-30-darwi@linutronix.de>
References: <20250324133324.23458-30-darwi@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174289537411.14745.11098649481457007120.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/cpu branch of tip:

Commit-ID:     0dd09e215a391805130338688586805fe8bf2b32
Gitweb:        https://git.kernel.org/tip/0dd09e215a391805130338688586805fe8bf2b32
Author:        Ahmed S. Darwish <darwi@linutronix.de>
AuthorDate:    Mon, 24 Mar 2025 14:33:24 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 25 Mar 2025 10:23:37 +01:00

x86/cacheinfo: Apply maintainer-tip coding style fixes

The x86/cacheinfo code has been heavily refactored and fleshed out at
parent commits, where any necessary coding style fixes were also done
in place.

Apply Documentation/process/maintainer-tip.rst coding style fixes to the
rest of the code, and align its assignment expressions for readability.

Standardize on CPUID(n) when mentioning leaf queries.

Avoid breaking long lines when doing so helps readability.

At cacheinfo_amd_init_llc_id(), rename variable 'msb' to 'index_msb' as
this is how it's called at the rest of cacheinfo.c code.

Signed-off-by: Ahmed S. Darwish <darwi@linutronix.de>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Link: https://lore.kernel.org/r/20250324133324.23458-30-darwi@linutronix.de
---
 arch/x86/kernel/cpu/cacheinfo.c | 215 +++++++++++++++----------------
 1 file changed, 107 insertions(+), 108 deletions(-)

diff --git a/arch/x86/kernel/cpu/cacheinfo.c b/arch/x86/kernel/cpu/cacheinfo.c
index 7158757..cd48d34 100644
--- a/arch/x86/kernel/cpu/cacheinfo.c
+++ b/arch/x86/kernel/cpu/cacheinfo.c
@@ -1,11 +1,11 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
- *	Routines to identify caches on Intel CPU.
+ * x86 CPU caches detection and configuration
  *
- *	Changes:
- *	Venkatesh Pallipadi	: Adding cache identification through cpuid(4)
- *	Ashok Raj <ashok.raj@intel.com>: Work with CPU hotplug infrastructure.
- *	Andi Kleen / Andreas Herrmann	: CPUID4 emulation on AMD.
+ * Previous changes
+ * - Venkatesh Pallipadi:		Cache identification through CPUID(4)
+ * - Ashok Raj <ashok.raj@intel.com>:	Work with CPU hotplug infrastructure
+ * - Andi Kleen / Andreas Herrmann:	CPUID(4) emulation on AMD
  */
 
 #include <linux/cacheinfo.h>
@@ -35,37 +35,37 @@ static cpumask_var_t cpu_cacheinfo_mask;
 unsigned int memory_caching_control __ro_after_init;
 
 enum _cache_type {
-	CTYPE_NULL = 0,
-	CTYPE_DATA = 1,
-	CTYPE_INST = 2,
-	CTYPE_UNIFIED = 3
+	CTYPE_NULL	= 0,
+	CTYPE_DATA	= 1,
+	CTYPE_INST	= 2,
+	CTYPE_UNIFIED	= 3
 };
 
 union _cpuid4_leaf_eax {
 	struct {
-		enum _cache_type	type:5;
-		unsigned int		level:3;
-		unsigned int		is_self_initializing:1;
-		unsigned int		is_fully_associative:1;
-		unsigned int		reserved:4;
-		unsigned int		num_threads_sharing:12;
-		unsigned int		num_cores_on_die:6;
+		enum _cache_type	type			:5;
+		unsigned int		level			:3;
+		unsigned int		is_self_initializing	:1;
+		unsigned int		is_fully_associative	:1;
+		unsigned int		reserved		:4;
+		unsigned int		num_threads_sharing	:12;
+		unsigned int		num_cores_on_die	:6;
 	} split;
 	u32 full;
 };
 
 union _cpuid4_leaf_ebx {
 	struct {
-		unsigned int		coherency_line_size:12;
-		unsigned int		physical_line_partition:10;
-		unsigned int		ways_of_associativity:10;
+		unsigned int		coherency_line_size	:12;
+		unsigned int		physical_line_partition	:10;
+		unsigned int		ways_of_associativity	:10;
 	} split;
 	u32 full;
 };
 
 union _cpuid4_leaf_ecx {
 	struct {
-		unsigned int		number_of_sets:32;
+		unsigned int		number_of_sets		:32;
 	} split;
 	u32 full;
 };
@@ -93,60 +93,59 @@ static const enum cache_type cache_type_map[] = {
 
 union l1_cache {
 	struct {
-		unsigned line_size:8;
-		unsigned lines_per_tag:8;
-		unsigned assoc:8;
-		unsigned size_in_kb:8;
+		unsigned line_size	:8;
+		unsigned lines_per_tag	:8;
+		unsigned assoc		:8;
+		unsigned size_in_kb	:8;
 	};
-	unsigned val;
+	unsigned int val;
 };
 
 union l2_cache {
 	struct {
-		unsigned line_size:8;
-		unsigned lines_per_tag:4;
-		unsigned assoc:4;
-		unsigned size_in_kb:16;
+		unsigned line_size	:8;
+		unsigned lines_per_tag	:4;
+		unsigned assoc		:4;
+		unsigned size_in_kb	:16;
 	};
-	unsigned val;
+	unsigned int val;
 };
 
 union l3_cache {
 	struct {
-		unsigned line_size:8;
-		unsigned lines_per_tag:4;
-		unsigned assoc:4;
-		unsigned res:2;
-		unsigned size_encoded:14;
+		unsigned line_size	:8;
+		unsigned lines_per_tag	:4;
+		unsigned assoc		:4;
+		unsigned res		:2;
+		unsigned size_encoded	:14;
 	};
-	unsigned val;
+	unsigned int val;
 };
 
 static const unsigned short assocs[] = {
-	[1] = 1,
-	[2] = 2,
-	[4] = 4,
-	[6] = 8,
-	[8] = 16,
-	[0xa] = 32,
-	[0xb] = 48,
-	[0xc] = 64,
-	[0xd] = 96,
-	[0xe] = 128,
-	[0xf] = 0xffff /* fully associative - no way to show this currently */
+	[1]		= 1,
+	[2]		= 2,
+	[4]		= 4,
+	[6]		= 8,
+	[8]		= 16,
+	[0xa]		= 32,
+	[0xb]		= 48,
+	[0xc]		= 64,
+	[0xd]		= 96,
+	[0xe]		= 128,
+	[0xf]		= 0xffff	/* Fully associative */
 };
 
 static const unsigned char levels[] = { 1, 1, 2, 3 };
-static const unsigned char types[] = { 1, 2, 3, 3 };
+static const unsigned char types[]  = { 1, 2, 3, 3 };
 
 static void legacy_amd_cpuid4(int index, union _cpuid4_leaf_eax *eax,
 			      union _cpuid4_leaf_ebx *ebx, union _cpuid4_leaf_ecx *ecx)
 {
 	unsigned int dummy, line_size, lines_per_tag, assoc, size_in_kb;
-	union l1_cache l1i, l1d;
+	union l1_cache l1i, l1d, *l1;
 	union l2_cache l2;
 	union l3_cache l3;
-	union l1_cache *l1 = &l1d;
 
 	eax->full = 0;
 	ebx->full = 0;
@@ -155,6 +154,7 @@ static void legacy_amd_cpuid4(int index, union _cpuid4_leaf_eax *eax,
 	cpuid(0x80000005, &dummy, &dummy, &l1d.val, &l1i.val);
 	cpuid(0x80000006, &dummy, &dummy, &l2.val, &l3.val);
 
+	l1 = &l1d;
 	switch (index) {
 	case 1:
 		l1 = &l1i;
@@ -162,48 +162,52 @@ static void legacy_amd_cpuid4(int index, union _cpuid4_leaf_eax *eax,
 	case 0:
 		if (!l1->val)
 			return;
-		assoc = assocs[l1->assoc];
-		line_size = l1->line_size;
-		lines_per_tag = l1->lines_per_tag;
-		size_in_kb = l1->size_in_kb;
+
+		assoc		= assocs[l1->assoc];
+		line_size	= l1->line_size;
+		lines_per_tag	= l1->lines_per_tag;
+		size_in_kb	= l1->size_in_kb;
 		break;
 	case 2:
 		if (!l2.val)
 			return;
-		assoc = assocs[l2.assoc];
-		line_size = l2.line_size;
-		lines_per_tag = l2.lines_per_tag;
-		/* cpu_data has errata corrections for K7 applied */
-		size_in_kb = __this_cpu_read(cpu_info.x86_cache_size);
+
+		/* Use x86_cache_size as it might have K7 errata fixes */
+		assoc		= assocs[l2.assoc];
+		line_size	= l2.line_size;
+		lines_per_tag	= l2.lines_per_tag;
+		size_in_kb	= __this_cpu_read(cpu_info.x86_cache_size);
 		break;
 	case 3:
 		if (!l3.val)
 			return;
-		assoc = assocs[l3.assoc];
-		line_size = l3.line_size;
-		lines_per_tag = l3.lines_per_tag;
-		size_in_kb = l3.size_encoded * 512;
+
+		assoc		= assocs[l3.assoc];
+		line_size	= l3.line_size;
+		lines_per_tag	= l3.lines_per_tag;
+		size_in_kb	= l3.size_encoded * 512;
 		if (boot_cpu_has(X86_FEATURE_AMD_DCM)) {
-			size_in_kb = size_in_kb >> 1;
-			assoc = assoc >> 1;
+			size_in_kb	= size_in_kb >> 1;
+			assoc		= assoc >> 1;
 		}
 		break;
 	default:
 		return;
 	}
 
-	eax->split.is_self_initializing = 1;
-	eax->split.type = types[index];
-	eax->split.level = levels[index];
-	eax->split.num_threads_sharing = 0;
-	eax->split.num_cores_on_die = topology_num_cores_per_package();
+	eax->split.is_self_initializing		= 1;
+	eax->split.type				= types[index];
+	eax->split.level			= levels[index];
+	eax->split.num_threads_sharing		= 0;
+	eax->split.num_cores_on_die		= topology_num_cores_per_package();
 
 	if (assoc == 0xffff)
 		eax->split.is_fully_associative = 1;
-	ebx->split.coherency_line_size = line_size - 1;
-	ebx->split.ways_of_associativity = assoc - 1;
-	ebx->split.physical_line_partition = lines_per_tag - 1;
-	ecx->split.number_of_sets = (size_in_kb * 1024) / line_size /
+
+	ebx->split.coherency_line_size		= line_size - 1;
+	ebx->split.ways_of_associativity	= assoc - 1;
+	ebx->split.physical_line_partition	= lines_per_tag - 1;
+	ecx->split.number_of_sets		= (size_in_kb * 1024) / line_size /
 		(ebx->split.ways_of_associativity + 1) - 1;
 }
 
@@ -262,19 +266,14 @@ static int fill_cpuid4_info(int index, struct _cpuid4_info *id4)
 
 static int find_num_cache_leaves(struct cpuinfo_x86 *c)
 {
-	unsigned int		eax, ebx, ecx, edx, op;
-	union _cpuid4_leaf_eax	cache_eax;
-	int 			i = -1;
-
-	if (c->x86_vendor == X86_VENDOR_AMD ||
-	    c->x86_vendor == X86_VENDOR_HYGON)
-		op = 0x8000001d;
-	else
-		op = 4;
+	unsigned int eax, ebx, ecx, edx, op;
+	union _cpuid4_leaf_eax cache_eax;
+	int i = -1;
 
+	/* Do a CPUID(op) loop to calculate num_cache_leaves */
+	op = (c->x86_vendor == X86_VENDOR_AMD || c->x86_vendor == X86_VENDOR_HYGON) ? 0x8000001d : 4;
 	do {
 		++i;
-		/* Do cpuid(op) loop to find out num_cache_leaves */
 		cpuid_count(op, i, &eax, &ebx, &ecx, &edx);
 		cache_eax.full = eax;
 	} while (cache_eax.split.type != CTYPE_NULL);
@@ -312,9 +311,9 @@ void cacheinfo_amd_init_llc_id(struct cpuinfo_x86 *c, u16 die_id)
 			num_sharing_cache = ((eax >> 14) & 0xfff) + 1;
 
 		if (num_sharing_cache) {
-			int bits = get_count_order(num_sharing_cache);
+			int index_msb = get_count_order(num_sharing_cache);
 
-			c->topo.llc_id = c->topo.apicid >> bits;
+			c->topo.llc_id = c->topo.apicid >> index_msb;
 		}
 	}
 }
@@ -335,14 +334,10 @@ void init_amd_cacheinfo(struct cpuinfo_x86 *c)
 {
 	struct cpu_cacheinfo *ci = get_cpu_cacheinfo(c->cpu_index);
 
-	if (boot_cpu_has(X86_FEATURE_TOPOEXT)) {
+	if (boot_cpu_has(X86_FEATURE_TOPOEXT))
 		ci->num_leaves = find_num_cache_leaves(c);
-	} else if (c->extended_cpuid_level >= 0x80000006) {
-		if (cpuid_edx(0x80000006) & 0xf000)
-			ci->num_leaves = 4;
-		else
-			ci->num_leaves = 3;
-	}
+	else if (c->extended_cpuid_level >= 0x80000006)
+		ci->num_leaves = (cpuid_edx(0x80000006) & 0xf000) ? 4 : 3;
 }
 
 void init_hygon_cacheinfo(struct cpuinfo_x86 *c)
@@ -469,6 +464,9 @@ void init_intel_cacheinfo(struct cpuinfo_x86 *c)
 	intel_cacheinfo_0x2(c);
 }
 
+/*
+ * linux/cacheinfo.h shared_cpu_map setup, AMD/Hygon
+ */
 static int __cache_amd_cpumap_setup(unsigned int cpu, int index,
 				    const struct _cpuid4_info *id4)
 {
@@ -485,12 +483,12 @@ static int __cache_amd_cpumap_setup(unsigned int cpu, int index,
 			this_cpu_ci = get_cpu_cacheinfo(i);
 			if (!this_cpu_ci->info_list)
 				continue;
+
 			ci = this_cpu_ci->info_list + index;
 			for_each_cpu(sibling, cpu_llc_shared_mask(cpu)) {
 				if (!cpu_online(sibling))
 					continue;
-				cpumask_set_cpu(sibling,
-						&ci->shared_cpu_map);
+				cpumask_set_cpu(sibling, &ci->shared_cpu_map);
 			}
 		}
 	} else if (boot_cpu_has(X86_FEATURE_TOPOEXT)) {
@@ -516,8 +514,7 @@ static int __cache_amd_cpumap_setup(unsigned int cpu, int index,
 				apicid = cpu_data(sibling).topo.apicid;
 				if ((apicid < first) || (apicid > last))
 					continue;
-				cpumask_set_cpu(sibling,
-						&ci->shared_cpu_map);
+				cpumask_set_cpu(sibling, &ci->shared_cpu_map);
 			}
 		}
 	} else
@@ -526,17 +523,19 @@ static int __cache_amd_cpumap_setup(unsigned int cpu, int index,
 	return 1;
 }
 
+/*
+ * linux/cacheinfo.h shared_cpu_map setup, Intel + fallback AMD/Hygon
+ */
 static void __cache_cpumap_setup(unsigned int cpu, int index,
 				 const struct _cpuid4_info *id4)
 {
 	struct cpu_cacheinfo *this_cpu_ci = get_cpu_cacheinfo(cpu);
+	struct cpuinfo_x86 *c = &cpu_data(cpu);
 	struct cacheinfo *ci, *sibling_ci;
 	unsigned long num_threads_sharing;
 	int index_msb, i;
-	struct cpuinfo_x86 *c = &cpu_data(cpu);
 
-	if (c->x86_vendor == X86_VENDOR_AMD ||
-	    c->x86_vendor == X86_VENDOR_HYGON) {
+	if (c->x86_vendor == X86_VENDOR_AMD || c->x86_vendor == X86_VENDOR_HYGON) {
 		if (__cache_amd_cpumap_setup(cpu, index, id4))
 			return;
 	}
@@ -554,8 +553,10 @@ static void __cache_cpumap_setup(unsigned int cpu, int index,
 		if (cpu_data(i).topo.apicid >> index_msb == c->topo.apicid >> index_msb) {
 			struct cpu_cacheinfo *sib_cpu_ci = get_cpu_cacheinfo(i);
 
+			/* Skip if itself or no cacheinfo */
 			if (i == cpu || !sib_cpu_ci->info_list)
-				continue;/* skip if itself or no cacheinfo */
+				continue;
+
 			sibling_ci = sib_cpu_ci->info_list + index;
 			cpumask_set_cpu(i, &ci->shared_cpu_map);
 			cpumask_set_cpu(cpu, &sibling_ci->shared_cpu_map);
@@ -589,7 +590,7 @@ int init_cache_level(unsigned int cpu)
 }
 
 /*
- * The max shared threads number comes from CPUID.4:EAX[25-14] with input
+ * The max shared threads number comes from CPUID(4) EAX[25-14] with input
  * ECX as cache index. Then right shift apicid by the number's order to get
  * cache id for this cache node.
  */
@@ -626,8 +627,8 @@ int populate_cache_leaves(unsigned int cpu)
 		ci_info_init(ci++, &id4, nb);
 		__cache_cpumap_setup(cpu, idx, &id4);
 	}
-	this_cpu_ci->cpu_map_populated = true;
 
+	this_cpu_ci->cpu_map_populated = true;
 	return 0;
 }
 
@@ -659,12 +660,10 @@ void cache_disable(void) __acquires(cache_disable_lock)
 	unsigned long cr0;
 
 	/*
-	 * Note that this is not ideal
-	 * since the cache is only flushed/disabled for this CPU while the
-	 * MTRRs are changed, but changing this requires more invasive
-	 * changes to the way the kernel boots
+	 * This is not ideal since the cache is only flushed/disabled
+	 * for this CPU while the MTRRs are changed, but changing this
+	 * requires more invasive changes to the way the kernel boots.
 	 */
-
 	raw_spin_lock(&cache_disable_lock);
 
 	/* Enter the no-fill (CD=1, NW=0) cache mode and flush caches. */

