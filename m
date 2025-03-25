Return-Path: <linux-tip-commits+bounces-4497-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 342D6A6EC9A
	for <lists+linux-tip-commits@lfdr.de>; Tue, 25 Mar 2025 10:37:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ABF6516E388
	for <lists+linux-tip-commits@lfdr.de>; Tue, 25 Mar 2025 09:37:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F217255E3C;
	Tue, 25 Mar 2025 09:36:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="gvWFUKB8";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="4pFfycAC"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04BA4254879;
	Tue, 25 Mar 2025 09:36:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742895383; cv=none; b=eIcnF4APBCI7C9CfTw1TytgBozGBLEU3wvfMKHnyL9rGfqxHKFxLIAmW7cG97r9Ya7tSGDa1kNk9IVzJsH5UkWRZEoHvdc4FhW/UafMGjxjS9aypOUSM8f5EBFl4WmHUSz7Qz6MF8ByV6wcPHmlCGlpBM4BEmsd62SEYr03feLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742895383; c=relaxed/simple;
	bh=ADPHomYeRMvZzz0zFGzKgPVqL8FsgeIl2ZNxaDhQy50=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=gXBVEMgeoOuXPohj1lwvAVmKQP/QAZMU8h60MpTkOmj8yh1EckAzVpsWUvvo0ellphQrqtuttnvF4Qp6syfR5zp0L0Rfkl6ZOwdAVCIC4nODodEEDvbfH6qiKFL8AY9zDYbASabsDLPRy1ysMx5hexYnkvwH7qtacYPxb1FEPGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=gvWFUKB8; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=4pFfycAC; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 25 Mar 2025 09:36:19 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1742895380;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=i/9xv/qxGrUnb1BLoTjYcoeO70QF3K2+2W2PxJNBoEI=;
	b=gvWFUKB8ZCfCo/vjaYzB6OrbkaFkDJY9kj+4MPJY5PTt9ibAamK3qS3aC1JuKNvFdkKSA2
	puQvFX0VfiBs+vkXERGwPBQ6kFAtIyy67W512u6/tbvIG783ay78iG/CeVF7Ah7FvggWdD
	xrfIiuB8RCF+ckI+cSu07tnotNjsAI3LDoinqqNMmdRCArS9eymMUwOrO1xSl39H5/buAD
	4kMMyjW57VIWTjL0nRXjGfsHN6RPmP2OLs0hjiV8RkIxzXvFPH9sfiu7qW3kziO1OKbj5P
	MuF/xFUM4UNMQqZllyUv0dUdccFyFvwcqLUmnXpn1fctGORoMzK2JZqjJvh0Yg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1742895380;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=i/9xv/qxGrUnb1BLoTjYcoeO70QF3K2+2W2PxJNBoEI=;
	b=4pFfycAClLHJdwrlFzb9BIrGymP4qFG/cbas7cDg87msLWabYDAEqOpmyyDxSuAxxlC/jB
	zZ7ypZT0JGz7mLAw==
From: "tip-bot2 for Ahmed S. Darwish" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cpu] x86/cacheinfo: Separate CPUID leaf 0x2 handling and
 post-processing logic
Cc: Thomas Gleixner <tglx@linutronix.de>,
 "Ahmed S. Darwish" <darwi@linutronix.de>, Ingo Molnar <mingo@kernel.org>,
 "H. Peter Anvin" <hpa@zytor.com>,
 Linus Torvalds <torvalds@linux-foundation.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250324133324.23458-24-darwi@linutronix.de>
References: <20250324133324.23458-24-darwi@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174289537943.14745.8401419363364325065.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/cpu branch of tip:

Commit-ID:     5adfd367589cf9bb984aabfab74107bcf4402fde
Gitweb:        https://git.kernel.org/tip/5adfd367589cf9bb984aabfab74107bcf4402fde
Author:        Ahmed S. Darwish <darwi@linutronix.de>
AuthorDate:    Mon, 24 Mar 2025 14:33:18 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 25 Mar 2025 10:23:15 +01:00

x86/cacheinfo: Separate CPUID leaf 0x2 handling and post-processing logic

The logic of init_intel_cacheinfo() is quite convoluted: it mixes leaf
0x4 parsing, leaf 0x2 parsing, plus some post-processing, in a single
place.

Begin simplifying its logic by extracting the leaf 0x2 parsing code, and
the post-processing logic, into their own functions.  While at it,
rework the SMT LLC topology ID comment for clarity.

Suggested-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Ahmed S. Darwish <darwi@linutronix.de>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Link: https://lore.kernel.org/r/20250324133324.23458-24-darwi@linutronix.de
---
 arch/x86/kernel/cpu/cacheinfo.c | 106 ++++++++++++++++---------------
 1 file changed, 58 insertions(+), 48 deletions(-)

diff --git a/arch/x86/kernel/cpu/cacheinfo.c b/arch/x86/kernel/cpu/cacheinfo.c
index e399bf2..b39aad1 100644
--- a/arch/x86/kernel/cpu/cacheinfo.c
+++ b/arch/x86/kernel/cpu/cacheinfo.c
@@ -355,14 +355,56 @@ void init_hygon_cacheinfo(struct cpuinfo_x86 *c)
 	ci->num_leaves = find_num_cache_leaves(c);
 }
 
-void init_intel_cacheinfo(struct cpuinfo_x86 *c)
+static void intel_cacheinfo_done(struct cpuinfo_x86 *c, unsigned int l3,
+				 unsigned int l2, unsigned int l1i, unsigned int l1d)
+{
+	/*
+	 * If llc_id is still unset, then cpuid_level < 4, which implies
+	 * that the only possibility left is SMT.  Since CPUID(2) doesn't
+	 * specify any shared caches and SMT shares all caches, we can
+	 * unconditionally set LLC ID to the package ID so that all
+	 * threads share it.
+	 */
+	if (c->topo.llc_id == BAD_APICID)
+		c->topo.llc_id = c->topo.pkg_id;
+
+	c->x86_cache_size = l3 ? l3 : (l2 ? l2 : l1i + l1d);
+
+	if (!l2)
+		cpu_detect_cache_sizes(c);
+}
+
+/*
+ * Legacy Intel CPUID(2) path if CPUID(4) is not available.
+ */
+static void intel_cacheinfo_0x2(struct cpuinfo_x86 *c)
 {
-	/* Cache sizes */
 	unsigned int l1i = 0, l1d = 0, l2 = 0, l3 = 0;
-	unsigned int new_l1d = 0, new_l1i = 0; /* Cache sizes from cpuid(4) */
-	unsigned int new_l2 = 0, new_l3 = 0, i; /* Cache sizes from cpuid(4) */
-	unsigned int l2_id = 0, l3_id = 0, num_threads_sharing, index_msb;
+	const struct leaf_0x2_table *entry;
+	union leaf_0x2_regs regs;
+	u8 *ptr;
+
+	if (c->cpuid_level < 2)
+		return;
+
+	cpuid_get_leaf_0x2_regs(&regs);
+	for_each_leaf_0x2_entry(regs, ptr, entry) {
+		switch (entry->c_type) {
+		case CACHE_L1_INST:	l1i += entry->c_size; break;
+		case CACHE_L1_DATA:	l1d += entry->c_size; break;
+		case CACHE_L2:		l2  += entry->c_size; break;
+		case CACHE_L3:		l3  += entry->c_size; break;
+		}
+	}
+
+	intel_cacheinfo_done(c, l3, l2, l1i, l1d);
+}
+
+void init_intel_cacheinfo(struct cpuinfo_x86 *c)
+{
 	struct cpu_cacheinfo *ci = get_cpu_cacheinfo(c->cpu_index);
+	unsigned int l1i = 0, l1d = 0, l2 = 0, l3 = 0;
+	unsigned int l2_id = 0, l3_id = 0;
 
 	if (c->cpuid_level > 3) {
 		/*
@@ -376,7 +418,8 @@ void init_intel_cacheinfo(struct cpuinfo_x86 *c)
 		 * Whenever possible use cpuid(4), deterministic cache
 		 * parameters cpuid leaf to find the cache details
 		 */
-		for (i = 0; i < ci->num_leaves; i++) {
+		for (int i = 0; i < ci->num_leaves; i++) {
+			unsigned int num_threads_sharing, index_msb;
 			struct _cpuid4_info id4 = {};
 			int retval;
 
@@ -387,18 +430,18 @@ void init_intel_cacheinfo(struct cpuinfo_x86 *c)
 			switch (id4.eax.split.level) {
 			case 1:
 				if (id4.eax.split.type == CTYPE_DATA)
-					new_l1d = id4.size/1024;
+					l1d = id4.size / 1024;
 				else if (id4.eax.split.type == CTYPE_INST)
-					new_l1i = id4.size/1024;
+					l1i = id4.size / 1024;
 				break;
 			case 2:
-				new_l2 = id4.size/1024;
+				l2 = id4.size / 1024;
 				num_threads_sharing = 1 + id4.eax.split.num_threads_sharing;
 				index_msb = get_count_order(num_threads_sharing);
 				l2_id = c->topo.apicid & ~((1 << index_msb) - 1);
 				break;
 			case 3:
-				new_l3 = id4.size/1024;
+				l3 = id4.size / 1024;
 				num_threads_sharing = 1 + id4.eax.split.num_threads_sharing;
 				index_msb = get_count_order(num_threads_sharing);
 				l3_id = c->topo.apicid & ~((1 << index_msb) - 1);
@@ -411,52 +454,19 @@ void init_intel_cacheinfo(struct cpuinfo_x86 *c)
 
 	/* Don't use CPUID(2) if CPUID(4) is supported. */
 	if (!ci->num_leaves && c->cpuid_level > 1) {
-		const struct leaf_0x2_table *entry;
-		union leaf_0x2_regs regs;
-		u8 *ptr;
-
-		cpuid_get_leaf_0x2_regs(&regs);
-		for_each_leaf_0x2_entry(regs, ptr, entry) {
-			switch (entry->c_type) {
-			case CACHE_L1_INST:	l1i += entry->c_size; break;
-			case CACHE_L1_DATA:	l1d += entry->c_size; break;
-			case CACHE_L2:		l2  += entry->c_size; break;
-			case CACHE_L3:		l3  += entry->c_size; break;
-			}
-		}
+		intel_cacheinfo_0x2(c);
+		return;
 	}
 
-	if (new_l1d)
-		l1d = new_l1d;
-
-	if (new_l1i)
-		l1i = new_l1i;
-
-	if (new_l2) {
-		l2 = new_l2;
+	if (l2) {
 		c->topo.llc_id = l2_id;
 		c->topo.l2c_id = l2_id;
 	}
 
-	if (new_l3) {
-		l3 = new_l3;
+	if (l3)
 		c->topo.llc_id = l3_id;
-	}
 
-	/*
-	 * If llc_id is not yet set, this means cpuid_level < 4 which in
-	 * turns means that the only possibility is SMT (as indicated in
-	 * cpuid1). Since cpuid2 doesn't specify shared caches, and we know
-	 * that SMT shares all caches, we can unconditionally set cpu_llc_id to
-	 * c->topo.pkg_id.
-	 */
-	if (c->topo.llc_id == BAD_APICID)
-		c->topo.llc_id = c->topo.pkg_id;
-
-	c->x86_cache_size = l3 ? l3 : (l2 ? l2 : (l1i+l1d));
-
-	if (!l2)
-		cpu_detect_cache_sizes(c);
+	intel_cacheinfo_done(c, l3, l2, l1i, l1d);
 }
 
 static int __cache_amd_cpumap_setup(unsigned int cpu, int index,

