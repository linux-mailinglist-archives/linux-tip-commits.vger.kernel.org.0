Return-Path: <linux-tip-commits+bounces-4507-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FC56A6ECB1
	for <lists+linux-tip-commits@lfdr.de>; Tue, 25 Mar 2025 10:39:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4393816F638
	for <lists+linux-tip-commits@lfdr.de>; Tue, 25 Mar 2025 09:39:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E72E2257AEC;
	Tue, 25 Mar 2025 09:36:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="PIe3Y0Nx";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="AHHuoEgI"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB014253B79;
	Tue, 25 Mar 2025 09:36:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742895394; cv=none; b=V+c41K+Rc3RZJXpBDTQFu5YrjFJ9EOU35U9/RbrHKYEijF7ffPvynov2tcBSawbUWYQRnkKGnhVMrA5lGwuYqjB5oy2hudOkvpHzsZYXAgRD51DYBj/6LLtqif4/6Ta01GKwSRZktl2Ru90ZO1l909ACELwUoWCjnTtifY2xfBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742895394; c=relaxed/simple;
	bh=AOEHuRCIebmpdiPLaD/Z8yXXSKEHMJwDENBqwY9E+sI=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=Cm4iMJlyX8x4OtoZzNdNYQ8+mgfiOFnhNdeA95J6yScVdxZGdYNN3OakEQzzM8UX0y8B4LquWZhnZEI1oCAQKpVIyFoKo7+anN8RPJu7uAJXv4ZOiK6olBUCTndBuc4nyiC51z+UzMQHmTUdISvFCFtCZ3Y2g/zurTkwPIHXo7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=PIe3Y0Nx; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=AHHuoEgI; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 25 Mar 2025 09:36:30 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1742895391;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TzZQsTes/rU5/zUraSqMrIpVAKWUC57GhwzbVYx9FA0=;
	b=PIe3Y0NxmlGcJLgvQak26JMJvOOUyav/ZDbyuBqtKWxlYM2W0e55izHSmIwGo1zlkpcwGB
	tLLr/l6CFWYxPHLAiFsJEuPcu1fEzwAb5OKLJPEDXmSTEidZp5WkIEF063C5JPO/cQBWFZ
	+XcmHm+InZi+zzQP+64hkYqBTBfWmefUXN4tfDnULXnMVyJOXMloLg4h9VcpFmrYqZpTF9
	mzzxXRTsZ0AwPaNIEwPWIGIJw8kAo1qniqGrEFtrBrIlbrwS2RA1U26iwkF4UMcmtpJ4HC
	2LROHYeQhy/mc53BMOpTfOlZ6OPX+8zp/Zl7ic29VYRXeWbogf1Ojc+mTNAsZw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1742895391;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TzZQsTes/rU5/zUraSqMrIpVAKWUC57GhwzbVYx9FA0=;
	b=AHHuoEgIRanzy2UVXUKt/bbjPlGzhj+/mBiFufTyL3lguIlu4+OV7wbSn1hQtwn2wH3ODc
	He73UsTnMqODFrDA==
From: "tip-bot2 for Ahmed S. Darwish" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: x86/cpu] x86/cacheinfo: Separate amd_northbridge from _cpuid4_info_regs
Cc: "Ahmed S. Darwish" <darwi@linutronix.de>, Ingo Molnar <mingo@kernel.org>,
 "H. Peter Anvin" <hpa@zytor.com>,
 Linus Torvalds <torvalds@linux-foundation.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250324133324.23458-13-darwi@linutronix.de>
References: <20250324133324.23458-13-darwi@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174289539083.14745.18001318734650641416.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/cpu branch of tip:

Commit-ID:     c58ed2d4da8dced3fa4505f498bd393f565b471a
Gitweb:        https://git.kernel.org/tip/c58ed2d4da8dced3fa4505f498bd393f565b471a
Author:        Ahmed S. Darwish <darwi@linutronix.de>
AuthorDate:    Mon, 24 Mar 2025 14:33:07 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 25 Mar 2025 10:22:36 +01:00

x86/cacheinfo: Separate amd_northbridge from _cpuid4_info_regs

'struct _cpuid4_info_regs' is meant to hold the CPUID leaf 0x4
output registers (EAX, EBX, and ECX), as well as derived information
such as the cache node ID and size.

It also contains a reference to amd_northbridge, which is there only to
be "parked" until ci_info_init() can store it in the priv pointer of the
<linux/cacheinfo.h> API.  That priv pointer is then used by AMD-specific
L3 cache_disable_0/1 sysfs attributes.

Decouple amd_northbridge from _cpuid4_info_regs and pass it explicitly
through the functions at x86/cacheinfo.  Doing so clarifies when
amd_northbridge is actually needed (AMD-only code) and when it is
not (Intel-specific code).  It also prepares for moving the AMD-specific
L3 cache_disable_0/1 sysfs code into its own file in next commit.

Signed-off-by: Ahmed S. Darwish <darwi@linutronix.de>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Link: https://lore.kernel.org/r/20250324133324.23458-13-darwi@linutronix.de
---
 arch/x86/kernel/cpu/cacheinfo.c | 45 ++++++++++++++++++++------------
 1 file changed, 29 insertions(+), 16 deletions(-)

diff --git a/arch/x86/kernel/cpu/cacheinfo.c b/arch/x86/kernel/cpu/cacheinfo.c
index f1055e8..8c2b51b 100644
--- a/arch/x86/kernel/cpu/cacheinfo.c
+++ b/arch/x86/kernel/cpu/cacheinfo.c
@@ -168,7 +168,6 @@ struct _cpuid4_info_regs {
 	union _cpuid4_leaf_ecx ecx;
 	unsigned int id;
 	unsigned long size;
-	struct amd_northbridge *nb;
 };
 
 /* AMD doesn't have CPUID4. Emulate it here to report the same
@@ -573,25 +572,36 @@ cache_get_priv_group(struct cacheinfo *ci)
 	return &cache_private_group;
 }
 
-static void amd_init_l3_cache(struct _cpuid4_info_regs *id4, int index)
+static struct amd_northbridge *amd_init_l3_cache(int index)
 {
+	struct amd_northbridge *nb;
 	int node;
 
 	/* only for L3, and not in virtualized environments */
 	if (index < 3)
-		return;
+		return NULL;
 
 	node = topology_amd_node_id(smp_processor_id());
-	id4->nb = node_to_amd_nb(node);
-	if (id4->nb && !id4->nb->l3_cache.indices)
-		amd_calc_l3_indices(id4->nb);
+	nb = node_to_amd_nb(node);
+	if (nb && !nb->l3_cache.indices)
+		amd_calc_l3_indices(nb);
+
+	return nb;
 }
 #else
-#define amd_init_l3_cache(x, y)
+static struct amd_northbridge *amd_init_l3_cache(int index)
+{
+	return NULL;
+}
 #endif  /* CONFIG_AMD_NB && CONFIG_SYSFS */
 
-static int
-cpuid4_cache_lookup_regs(int index, struct _cpuid4_info_regs *id4)
+/*
+ * Fill passed _cpuid4_info_regs structure.
+ * Intel-only code paths should pass NULL for the amd_northbridge
+ * return pointer.
+ */
+static int cpuid4_cache_lookup_regs(int index, struct _cpuid4_info_regs *id4,
+				    struct amd_northbridge **nb)
 {
 	u8 cpu_vendor = boot_cpu_data.x86_vendor;
 	union _cpuid4_leaf_eax eax;
@@ -607,7 +617,9 @@ cpuid4_cache_lookup_regs(int index, struct _cpuid4_info_regs *id4)
 			/* Legacy AMD fallback */
 			amd_cpuid4(index, &eax, &ebx, &ecx);
 		}
-		amd_init_l3_cache(id4, index);
+
+		if (nb)
+			*nb = amd_init_l3_cache(index);
 	} else {
 		/* Intel */
 		cpuid_count(4, index, &eax.full, &ebx.full, &ecx.full, &edx);
@@ -758,7 +770,7 @@ void init_intel_cacheinfo(struct cpuinfo_x86 *c)
 			struct _cpuid4_info_regs id4 = {};
 			int retval;
 
-			retval = cpuid4_cache_lookup_regs(i, &id4);
+			retval = cpuid4_cache_lookup_regs(i, &id4, NULL);
 			if (retval < 0)
 				continue;
 
@@ -934,8 +946,8 @@ static void __cache_cpumap_setup(unsigned int cpu, int index,
 		}
 }
 
-static void ci_info_init(struct cacheinfo *ci,
-			 const struct _cpuid4_info_regs *id4)
+static void ci_info_init(struct cacheinfo *ci, const struct _cpuid4_info_regs *id4,
+			 struct amd_northbridge *nb)
 {
 	ci->id				= id4->id;
 	ci->attributes			= CACHE_ID;
@@ -946,7 +958,7 @@ static void ci_info_init(struct cacheinfo *ci,
 	ci->size			= id4->size;
 	ci->number_of_sets		= id4->ecx.split.number_of_sets + 1;
 	ci->physical_line_partition	= id4->ebx.split.physical_line_partition + 1;
-	ci->priv			= id4->nb;
+	ci->priv			= nb;
 }
 
 int init_cache_level(unsigned int cpu)
@@ -982,13 +994,14 @@ int populate_cache_leaves(unsigned int cpu)
 	struct cpu_cacheinfo *this_cpu_ci = get_cpu_cacheinfo(cpu);
 	struct cacheinfo *ci = this_cpu_ci->info_list;
 	struct _cpuid4_info_regs id4 = {};
+	struct amd_northbridge *nb;
 
 	for (idx = 0; idx < this_cpu_ci->num_leaves; idx++) {
-		ret = cpuid4_cache_lookup_regs(idx, &id4);
+		ret = cpuid4_cache_lookup_regs(idx, &id4, &nb);
 		if (ret)
 			return ret;
 		get_cache_id(cpu, &id4);
-		ci_info_init(ci++, &id4);
+		ci_info_init(ci++, &id4, nb);
 		__cache_cpumap_setup(cpu, idx, &id4);
 	}
 	this_cpu_ci->cpu_map_populated = true;

