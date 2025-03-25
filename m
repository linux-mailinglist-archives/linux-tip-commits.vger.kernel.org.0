Return-Path: <linux-tip-commits+bounces-4495-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C3C4BA6EC97
	for <lists+linux-tip-commits@lfdr.de>; Tue, 25 Mar 2025 10:36:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2BE1E1895F5D
	for <lists+linux-tip-commits@lfdr.de>; Tue, 25 Mar 2025 09:37:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF97C254B05;
	Tue, 25 Mar 2025 09:36:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="BaBScgfa";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="oVhE+JyH"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5585253F04;
	Tue, 25 Mar 2025 09:36:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742895382; cv=none; b=k87+pAJYMWI+1ctJCWoUH/y+KFTdq4Ai4AFy6Ml9PyEGLDk/STPP5aFkCIpRPhIH30WF+5fYFcWvjczQHDdyzoNv+fP4m/6KT+tG9lzMCh0NMNGlWqk5iCpiiCBlx2osE/fyym/L1sUl2r62b6Mbyv3SPAqRuz9pj8WsITOVRpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742895382; c=relaxed/simple;
	bh=jG15W5li8Jx99IxQ3QmqCVKYDv00KgaLhnvyFeSpqy8=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=j/jpnLjHZiZL7jtub7xSCLphRqjsWpWgJQsFziGMYR2PA/JoaFBKqzAu7UjCCAW7VR0SUPi6C5CRJcyCs9knHHMEdgEV+lfbDK+XpHbXjBcUfAyDZWitMYOAZYR1iOlC1NemyXFA4x8ItLDMUywwkEbSHcetFNhQHqPyX7lt0Ic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=BaBScgfa; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=oVhE+JyH; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 25 Mar 2025 09:36:18 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1742895379;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=D330YhB/HXOo/LtMxrJQ/Ykg5xY+lCeXX9shOTm85go=;
	b=BaBScgfaJk6lS2/9yiDJ0SmG8xnHk8zkcILUkRyjSZIooH14eCb/dEiC8o/3YJfjQXjBPX
	VVjyIyhfJX2u9NPsgqI3FpqchV74paXjckA++Ibwsybvvfzy7D9ajLWlyIZWM0ufO30Q0j
	T61iDFx+iwkBasl5AdxWOQckyajScq/9v31GCUIuymfj0TQ/kArfzRBtemWOFoihM+blEh
	20ZrM1LrLrFCv3J+duhz+3oaEQHKxv5mCkZ/GRRCksSlkhEs5KBOAdi7hILvxrtf5rZhcO
	5J0J7gpV4RJZqurrBkwAyBs266OjTm9E0p+jSj/83ezAM5zwW+0ZAnXxa5Jn4Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1742895379;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=D330YhB/HXOo/LtMxrJQ/Ykg5xY+lCeXX9shOTm85go=;
	b=oVhE+JyHPT348Y8zpKC2wn6GNk5bdXbUjrBfIYPBFElt+bjwxC2eEd5LlpUPW1qyNY+JhB
	mjcn/VupIooWPhCw==
From: "tip-bot2 for Ahmed S. Darwish" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cpu] x86/cacheinfo: Separate Intel CPUID leaf 0x4 handling
Cc: Thomas Gleixner <tglx@linutronix.de>,
 "Ahmed S. Darwish" <darwi@linutronix.de>, Ingo Molnar <mingo@kernel.org>,
 "H. Peter Anvin" <hpa@zytor.com>,
 Linus Torvalds <torvalds@linux-foundation.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250324133324.23458-25-darwi@linutronix.de>
References: <20250324133324.23458-25-darwi@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174289537860.14745.16054353144627881192.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/cpu branch of tip:

Commit-ID:     66122616e212f1b9fee7d03582a5fdab2e8ed0e4
Gitweb:        https://git.kernel.org/tip/66122616e212f1b9fee7d03582a5fdab2e8ed0e4
Author:        Ahmed S. Darwish <darwi@linutronix.de>
AuthorDate:    Mon, 24 Mar 2025 14:33:19 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 25 Mar 2025 10:23:18 +01:00

x86/cacheinfo: Separate Intel CPUID leaf 0x4 handling

init_intel_cacheinfo() was overly complex.  It parsed leaf 0x4 data,
leaf 0x2 data, and performed post-processing, all within one function.
Parent commit moved leaf 0x2 parsing and the post-processing logic into
their own functions.

Continue the refactoring by extracting leaf 0x4 parsing into its own
function.  Initialize local L2/L3 topology ID variables to BAD_APICID by
default, thus ensuring they can be used unconditionally.

Suggested-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Ahmed S. Darwish <darwi@linutronix.de>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Link: https://lore.kernel.org/r/20250324133324.23458-25-darwi@linutronix.de
---
 arch/x86/kernel/cpu/cacheinfo.c | 110 +++++++++++++++----------------
 1 file changed, 54 insertions(+), 56 deletions(-)

diff --git a/arch/x86/kernel/cpu/cacheinfo.c b/arch/x86/kernel/cpu/cacheinfo.c
index b39aad1..72cc32d 100644
--- a/arch/x86/kernel/cpu/cacheinfo.c
+++ b/arch/x86/kernel/cpu/cacheinfo.c
@@ -400,73 +400,71 @@ static void intel_cacheinfo_0x2(struct cpuinfo_x86 *c)
 	intel_cacheinfo_done(c, l3, l2, l1i, l1d);
 }
 
-void init_intel_cacheinfo(struct cpuinfo_x86 *c)
+static bool intel_cacheinfo_0x4(struct cpuinfo_x86 *c)
 {
 	struct cpu_cacheinfo *ci = get_cpu_cacheinfo(c->cpu_index);
-	unsigned int l1i = 0, l1d = 0, l2 = 0, l3 = 0;
-	unsigned int l2_id = 0, l3_id = 0;
-
-	if (c->cpuid_level > 3) {
-		/*
-		 * There should be at least one leaf. A non-zero value means
-		 * that the number of leaves has been initialized.
-		 */
-		if (!ci->num_leaves)
-			ci->num_leaves = find_num_cache_leaves(c);
+	unsigned int l2_id = BAD_APICID, l3_id = BAD_APICID;
+	unsigned int l1d = 0, l1i = 0, l2 = 0, l3 = 0;
 
-		/*
-		 * Whenever possible use cpuid(4), deterministic cache
-		 * parameters cpuid leaf to find the cache details
-		 */
-		for (int i = 0; i < ci->num_leaves; i++) {
-			unsigned int num_threads_sharing, index_msb;
-			struct _cpuid4_info id4 = {};
-			int retval;
+	if (c->cpuid_level < 4)
+		return false;
 
-			retval = intel_fill_cpuid4_info(i, &id4);
-			if (retval < 0)
-				continue;
+	/*
+	 * There should be at least one leaf. A non-zero value means
+	 * that the number of leaves has been previously initialized.
+	 */
+	if (!ci->num_leaves)
+		ci->num_leaves = find_num_cache_leaves(c);
 
-			switch (id4.eax.split.level) {
-			case 1:
-				if (id4.eax.split.type == CTYPE_DATA)
-					l1d = id4.size / 1024;
-				else if (id4.eax.split.type == CTYPE_INST)
-					l1i = id4.size / 1024;
-				break;
-			case 2:
-				l2 = id4.size / 1024;
-				num_threads_sharing = 1 + id4.eax.split.num_threads_sharing;
-				index_msb = get_count_order(num_threads_sharing);
-				l2_id = c->topo.apicid & ~((1 << index_msb) - 1);
-				break;
-			case 3:
-				l3 = id4.size / 1024;
-				num_threads_sharing = 1 + id4.eax.split.num_threads_sharing;
-				index_msb = get_count_order(num_threads_sharing);
-				l3_id = c->topo.apicid & ~((1 << index_msb) - 1);
-				break;
-			default:
-				break;
-			}
+	if (!ci->num_leaves)
+		return false;
+
+	for (int i = 0; i < ci->num_leaves; i++) {
+		unsigned int num_threads_sharing, index_msb;
+		struct _cpuid4_info id4 = {};
+		int ret;
+
+		ret = intel_fill_cpuid4_info(i, &id4);
+		if (ret < 0)
+			continue;
+
+		switch (id4.eax.split.level) {
+		case 1:
+			if (id4.eax.split.type == CTYPE_DATA)
+				l1d = id4.size / 1024;
+			else if (id4.eax.split.type == CTYPE_INST)
+				l1i = id4.size / 1024;
+			break;
+		case 2:
+			l2 = id4.size / 1024;
+			num_threads_sharing = 1 + id4.eax.split.num_threads_sharing;
+			index_msb = get_count_order(num_threads_sharing);
+			l2_id = c->topo.apicid & ~((1 << index_msb) - 1);
+			break;
+		case 3:
+			l3 = id4.size / 1024;
+			num_threads_sharing = 1 + id4.eax.split.num_threads_sharing;
+			index_msb = get_count_order(num_threads_sharing);
+			l3_id = c->topo.apicid & ~((1 << index_msb) - 1);
+			break;
+		default:
+			break;
 		}
 	}
 
+	c->topo.l2c_id = l2_id;
+	c->topo.llc_id = (l3_id == BAD_APICID) ? l2_id : l3_id;
+	intel_cacheinfo_done(c, l3, l2, l1i, l1d);
+	return true;
+}
+
+void init_intel_cacheinfo(struct cpuinfo_x86 *c)
+{
 	/* Don't use CPUID(2) if CPUID(4) is supported. */
-	if (!ci->num_leaves && c->cpuid_level > 1) {
-		intel_cacheinfo_0x2(c);
+	if (intel_cacheinfo_0x4(c))
 		return;
-	}
-
-	if (l2) {
-		c->topo.llc_id = l2_id;
-		c->topo.l2c_id = l2_id;
-	}
-
-	if (l3)
-		c->topo.llc_id = l3_id;
 
-	intel_cacheinfo_done(c, l3, l2, l1i, l1d);
+	intel_cacheinfo_0x2(c);
 }
 
 static int __cache_amd_cpumap_setup(unsigned int cpu, int index,

