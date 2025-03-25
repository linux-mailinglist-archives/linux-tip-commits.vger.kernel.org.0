Return-Path: <linux-tip-commits+bounces-4492-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B50BA6EC8F
	for <lists+linux-tip-commits@lfdr.de>; Tue, 25 Mar 2025 10:36:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D290F16958C
	for <lists+linux-tip-commits@lfdr.de>; Tue, 25 Mar 2025 09:36:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A22191F0E57;
	Tue, 25 Mar 2025 09:36:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="hrC0+vjX";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="SNyM9tyD"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D02B919CC27;
	Tue, 25 Mar 2025 09:36:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742895379; cv=none; b=VRNbHIotkHqgOLFAidY2jj1jzUzr0riAh4tFqprAeNGECKkHAbVUZeBpvshoBGKJ5AQyU9R9FMmgnYctV+COax49FqaA57fjxdC8DYFnHvVDLKkXu8FYb9QiTp00Xhkmg0nIFHL+XcKgVGRtCqwCe3RnHSFM4YRjMZ75D63nu2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742895379; c=relaxed/simple;
	bh=9gy+RN0jAKL1KvujBOfnWWLYwX4dGRohdlWZNUrEChc=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=uie4B9DL7ZUvpEtvlrKzmTb9J+a7od0sLkyy9VWuXECvAsTgxwrchThSNbV03FVBbCtjLZUSKeAXLZLY/GqZzqJD4wuYYSjCj6QvMElX64/hUURhSJ+FoF6qRblRkZDt3APj7/403puzdtmdrvMn5o/ZHdIfLPR7Mg3+VQ0mM40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=hrC0+vjX; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=SNyM9tyD; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 25 Mar 2025 09:36:15 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1742895375;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+RqeqTFrb5tJSbaQYVtwAbIuuh6kQXgjEGQc0ZuBGPs=;
	b=hrC0+vjXhmisP/zN5/FIbMtIFFw8IH1EPpg+8c+qS1qh4j/iHBnc+9VcUBZyMzLQIRIRWc
	ERlLnZ8gqiJaWoCeOTsgHt+TM1z3ZJRILAtjiSAGsAN0/mnSmnDA/19msmZrQbjUFq+Zkl
	jGhpw4DeGJKcTfxRcpxsLnCsRCKyjHMvZdnN7uCAdSGepWb0qibnw3t2/jVKsFKa7+NCoE
	TsyUYKghKjxZTCVUP12QFIWK7ocZc0njmq3LaW7R2hySfAxDBLajfSlB/4o/intwaCBIXd
	q+Y/ltnmm94TsHP3DBZs5VZPiC+5xT1NvguOH8C5aQHtu/nQBGD7H6W5u134CA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1742895375;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+RqeqTFrb5tJSbaQYVtwAbIuuh6kQXgjEGQc0ZuBGPs=;
	b=SNyM9tyDvvOQPLupq9KVTxbMx9zqhVHH1jQQDn/SlQaTlOMMiXj860HerOOCo/YbpOMvSJ
	AtNioDe/oQL5MLCQ==
From: "tip-bot2 for Ahmed S. Darwish" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: x86/cpu] x86/cacheinfo: Introduce cpuid_amd_hygon_has_l3_cache()
Cc: "Ahmed S. Darwish" <darwi@linutronix.de>, Ingo Molnar <mingo@kernel.org>,
 "H. Peter Anvin" <hpa@zytor.com>,
 Linus Torvalds <torvalds@linux-foundation.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250324133324.23458-29-darwi@linutronix.de>
References: <20250324133324.23458-29-darwi@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174289537520.14745.3001878334365549946.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/cpu branch of tip:

Commit-ID:     6c963c42fc19d7c9ae9582ab75c3476d1752d979
Gitweb:        https://git.kernel.org/tip/6c963c42fc19d7c9ae9582ab75c3476d1752d979
Author:        Ahmed S. Darwish <darwi@linutronix.de>
AuthorDate:    Mon, 24 Mar 2025 14:33:23 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 25 Mar 2025 10:23:30 +01:00

x86/cacheinfo: Introduce cpuid_amd_hygon_has_l3_cache()

Multiple code paths at cacheinfo.c and amd_nb.c check for AMD/Hygon CPUs
L3 cache presensce by directly checking leaf 0x80000006 EDX output.

Extract that logic into its own function.  While at it, rework the
AMD/Hygon LLC topology ID caclculation comments for clarity.

Signed-off-by: Ahmed S. Darwish <darwi@linutronix.de>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Link: https://lore.kernel.org/r/20250324133324.23458-29-darwi@linutronix.de
---
 arch/x86/include/asm/cpuid/api.h |  9 +++++++++-
 arch/x86/kernel/amd_nb.c         |  7 +++----
 arch/x86/kernel/cpu/cacheinfo.c  | 32 +++++++++++++------------------
 3 files changed, 26 insertions(+), 22 deletions(-)

diff --git a/arch/x86/include/asm/cpuid/api.h b/arch/x86/include/asm/cpuid/api.h
index 9c180c9..bf75c62 100644
--- a/arch/x86/include/asm/cpuid/api.h
+++ b/arch/x86/include/asm/cpuid/api.h
@@ -207,4 +207,13 @@ static inline u32 hypervisor_cpuid_base(const char *sig, u32 leaves)
 	return 0;
 }
 
+/*
+ * CPUID(0x80000006) parsing helpers
+ */
+
+static inline bool cpuid_amd_hygon_has_l3_cache(void)
+{
+	return cpuid_edx(0x80000006);
+}
+
 #endif /* _ASM_X86_CPUID_API_H */
diff --git a/arch/x86/kernel/amd_nb.c b/arch/x86/kernel/amd_nb.c
index 6d12a9b..5a8cc48 100644
--- a/arch/x86/kernel/amd_nb.c
+++ b/arch/x86/kernel/amd_nb.c
@@ -13,7 +13,9 @@
 #include <linux/export.h>
 #include <linux/spinlock.h>
 #include <linux/pci_ids.h>
+
 #include <asm/amd_nb.h>
+#include <asm/cpuid.h>
 
 static u32 *flush_words;
 
@@ -91,10 +93,7 @@ static int amd_cache_northbridges(void)
 	if (amd_gart_present())
 		amd_northbridges.flags |= AMD_NB_GART;
 
-	/*
-	 * Check for L3 cache presence.
-	 */
-	if (!cpuid_edx(0x80000006))
+	if (!cpuid_amd_hygon_has_l3_cache())
 		return 0;
 
 	/*
diff --git a/arch/x86/kernel/cpu/cacheinfo.c b/arch/x86/kernel/cpu/cacheinfo.c
index e0d531e..7158757 100644
--- a/arch/x86/kernel/cpu/cacheinfo.c
+++ b/arch/x86/kernel/cpu/cacheinfo.c
@@ -281,29 +281,29 @@ static int find_num_cache_leaves(struct cpuinfo_x86 *c)
 	return i;
 }
 
+/*
+ * AMD/Hygon CPUs may have multiple LLCs if L3 caches exist.
+ */
+
 void cacheinfo_amd_init_llc_id(struct cpuinfo_x86 *c, u16 die_id)
 {
-	/*
-	 * We may have multiple LLCs if L3 caches exist, so check if we
-	 * have an L3 cache by looking at the L3 cache CPUID leaf.
-	 */
-	if (!cpuid_edx(0x80000006))
+	if (!cpuid_amd_hygon_has_l3_cache())
 		return;
 
 	if (c->x86 < 0x17) {
-		/* LLC is at the node level. */
+		/* Pre-Zen: LLC is at the node level */
 		c->topo.llc_id = die_id;
 	} else if (c->x86 == 0x17 && c->x86_model <= 0x1F) {
 		/*
-		 * LLC is at the core complex level.
-		 * Core complex ID is ApicId[3] for these processors.
+		 * Family 17h up to 1F models: LLC is at the core
+		 * complex level.  Core complex ID is ApicId[3].
 		 */
 		c->topo.llc_id = c->topo.apicid >> 3;
 	} else {
 		/*
-		 * LLC ID is calculated from the number of threads sharing the
-		 * cache.
-		 * */
+		 * Newer families: LLC ID is calculated from the number
+		 * of threads sharing the L3 cache.
+		 */
 		u32 eax, ebx, ecx, edx, num_sharing_cache = 0;
 		u32 llc_index = find_num_cache_leaves(c) - 1;
 
@@ -321,16 +321,12 @@ void cacheinfo_amd_init_llc_id(struct cpuinfo_x86 *c, u16 die_id)
 
 void cacheinfo_hygon_init_llc_id(struct cpuinfo_x86 *c)
 {
-	/*
-	 * We may have multiple LLCs if L3 caches exist, so check if we
-	 * have an L3 cache by looking at the L3 cache CPUID leaf.
-	 */
-	if (!cpuid_edx(0x80000006))
+	if (!cpuid_amd_hygon_has_l3_cache())
 		return;
 
 	/*
-	 * LLC is at the core complex level.
-	 * Core complex ID is ApicId[3] for these processors.
+	 * Hygons are similar to AMD Family 17h up to 1F models: LLC is
+	 * at the core complex level.  Core complex ID is ApicId[3].
 	 */
 	c->topo.llc_id = c->topo.apicid >> 3;
 }

