Return-Path: <linux-tip-commits+bounces-3880-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B086BA4D8D5
	for <lists+linux-tip-commits@lfdr.de>; Tue,  4 Mar 2025 10:41:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0E740170181
	for <lists+linux-tip-commits@lfdr.de>; Tue,  4 Mar 2025 09:38:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36D7B1FF5FC;
	Tue,  4 Mar 2025 09:37:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="AIOKMgrA";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="drumqwzg"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E60751FECDB;
	Tue,  4 Mar 2025 09:37:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741081044; cv=none; b=UOhJ70BH3MsNFcE3smgjqI6dX81LCuxEvV2aaYggCRvveqLpAVkuAhx+owctpsXtWGr1zqXfxKppwgjNH6BlivzWQqxSldULZgnSag9zeMsb5rf7sYIS+KgvdFk46BB0V0Wls/Ql+E5m4q22mQfcCuiBY1IJouThI7IFY9bV9kI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741081044; c=relaxed/simple;
	bh=0q6Hu0Ix54frFluu4TWuihuF2DEDtBfsXIN5pplwJXU=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=iplByp+NFgKkmkkpJQBRzWFLQdVJ1Yxa1fEFuadm6bN3za0mqo0Q1lfSrb5yhuwBj95fNVpbJu7NzBlqh74Pja8tcXG6r10HTdBu2c5qhGbwcJq30b3oP+6rCzs7nXxpUNGglAdvAC0Ol4qQTg2SqrqdKE1qYCZ32gIT+19MTF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=AIOKMgrA; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=drumqwzg; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 04 Mar 2025 09:37:19 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1741081040;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5u5RQ6P/FjUdF9kaQCF1Zp5GFNmNrnqNoX7u0Ae4StY=;
	b=AIOKMgrAHrh+hEDKPsgAbT4R7nEbVpwWNOdNGiOOv76X64zBd6Tl43AG/1UZtDT5ygKVS7
	XKR6k+Ys+rwpH0WXZwIRFFLuQZ7Ys+5iINP555Va3ebr0J+dYCSJzFUjwpTOSbL80USYxj
	6gpvyF/GSxPQMerNHumR2RwrEzfFZcWcke/ABxeHOr535MkDiZ/kpcXJvl1dEtRqutU4I/
	8JCKlUIKD/CHC38uMCCdklOQiJQVP0dmkZAYcqy++mV56x+B9KagoRkfuzvvLYSEoTkG70
	u6AYXCIFmjQoqcLYPxwu+29VifADaT1En6S/olRpn6o0qvAnwKMeYNyJZiT+UQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1741081040;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5u5RQ6P/FjUdF9kaQCF1Zp5GFNmNrnqNoX7u0Ae4StY=;
	b=drumqwzglN4jVKI2ZfYzxxCMa6RYgEzMnqm1FtobmNJepmpQ0a1tjYXWlZMGJEwsHeo6YE
	28fCFSvJfrQ/VBDw==
From: "tip-bot2 for Ahmed S. Darwish" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cpu] x86/cpu: Simplify TLB entry count storage
Cc: "Ahmed S. Darwish" <darwi@linutronix.de>, Ingo Molnar <mingo@kernel.org>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250304085152.51092-8-darwi@linutronix.de>
References: <20250304085152.51092-8-darwi@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174108103955.14745.12224752887219621325.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/cpu branch of tip:

Commit-ID:     849c0e9cea1a80003258fce2a5fe541574aefc38
Gitweb:        https://git.kernel.org/tip/849c0e9cea1a80003258fce2a5fe541574aefc38
Author:        Ahmed S. Darwish <darwi@linutronix.de>
AuthorDate:    Tue, 04 Mar 2025 09:51:18 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 04 Mar 2025 10:15:24 +01:00

x86/cpu: Simplify TLB entry count storage

Commit:

  e0ba94f14f74 ("x86/tlb_info: get last level TLB entry number of CPU")

introduced u16 "info" arrays for each TLB type.

Since 2012 and each array stores just one type of information: the
number of TLB entries for its respective TLB type.

Replace such arrays with simple variables.

Signed-off-by: Ahmed S. Darwish <darwi@linutronix.de>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/20250304085152.51092-8-darwi@linutronix.de
---
 arch/x86/include/asm/processor.h | 19 ++++--------
 arch/x86/kernel/cpu/amd.c        | 18 ++++++------
 arch/x86/kernel/cpu/common.c     | 20 +++++--------
 arch/x86/kernel/cpu/hygon.c      | 16 +++++-----
 arch/x86/kernel/cpu/intel.c      | 48 +++++++++++++++----------------
 5 files changed, 57 insertions(+), 64 deletions(-)

diff --git a/arch/x86/include/asm/processor.h b/arch/x86/include/asm/processor.h
index c0cd101..0ea227f 100644
--- a/arch/x86/include/asm/processor.h
+++ b/arch/x86/include/asm/processor.h
@@ -60,18 +60,13 @@ struct vm86;
 # define ARCH_MIN_MMSTRUCT_ALIGN	0
 #endif
 
-enum tlb_infos {
-	ENTRIES,
-	NR_INFO
-};
-
-extern u16 __read_mostly tlb_lli_4k[NR_INFO];
-extern u16 __read_mostly tlb_lli_2m[NR_INFO];
-extern u16 __read_mostly tlb_lli_4m[NR_INFO];
-extern u16 __read_mostly tlb_lld_4k[NR_INFO];
-extern u16 __read_mostly tlb_lld_2m[NR_INFO];
-extern u16 __read_mostly tlb_lld_4m[NR_INFO];
-extern u16 __read_mostly tlb_lld_1g[NR_INFO];
+extern u16 __read_mostly tlb_lli_4k;
+extern u16 __read_mostly tlb_lli_2m;
+extern u16 __read_mostly tlb_lli_4m;
+extern u16 __read_mostly tlb_lld_4k;
+extern u16 __read_mostly tlb_lld_2m;
+extern u16 __read_mostly tlb_lld_4m;
+extern u16 __read_mostly tlb_lld_1g;
 
 /*
  * CPU type and hardware bug flags. Kept separately for each CPU.
diff --git a/arch/x86/kernel/cpu/amd.c b/arch/x86/kernel/cpu/amd.c
index d747515..3157664 100644
--- a/arch/x86/kernel/cpu/amd.c
+++ b/arch/x86/kernel/cpu/amd.c
@@ -1105,8 +1105,8 @@ static void cpu_detect_tlb_amd(struct cpuinfo_x86 *c)
 
 	cpuid(0x80000006, &eax, &ebx, &ecx, &edx);
 
-	tlb_lld_4k[ENTRIES] = (ebx >> 16) & mask;
-	tlb_lli_4k[ENTRIES] = ebx & mask;
+	tlb_lld_4k = (ebx >> 16) & mask;
+	tlb_lli_4k = ebx & mask;
 
 	/*
 	 * K8 doesn't have 2M/4M entries in the L2 TLB so read out the L1 TLB
@@ -1119,26 +1119,26 @@ static void cpu_detect_tlb_amd(struct cpuinfo_x86 *c)
 
 	/* Handle DTLB 2M and 4M sizes, fall back to L1 if L2 is disabled */
 	if (!((eax >> 16) & mask))
-		tlb_lld_2m[ENTRIES] = (cpuid_eax(0x80000005) >> 16) & 0xff;
+		tlb_lld_2m = (cpuid_eax(0x80000005) >> 16) & 0xff;
 	else
-		tlb_lld_2m[ENTRIES] = (eax >> 16) & mask;
+		tlb_lld_2m = (eax >> 16) & mask;
 
 	/* a 4M entry uses two 2M entries */
-	tlb_lld_4m[ENTRIES] = tlb_lld_2m[ENTRIES] >> 1;
+	tlb_lld_4m = tlb_lld_2m >> 1;
 
 	/* Handle ITLB 2M and 4M sizes, fall back to L1 if L2 is disabled */
 	if (!(eax & mask)) {
 		/* Erratum 658 */
 		if (c->x86 == 0x15 && c->x86_model <= 0x1f) {
-			tlb_lli_2m[ENTRIES] = 1024;
+			tlb_lli_2m = 1024;
 		} else {
 			cpuid(0x80000005, &eax, &ebx, &ecx, &edx);
-			tlb_lli_2m[ENTRIES] = eax & 0xff;
+			tlb_lli_2m = eax & 0xff;
 		}
 	} else
-		tlb_lli_2m[ENTRIES] = eax & mask;
+		tlb_lli_2m = eax & mask;
 
-	tlb_lli_4m[ENTRIES] = tlb_lli_2m[ENTRIES] >> 1;
+	tlb_lli_4m = tlb_lli_2m >> 1;
 }
 
 static const struct cpu_dev amd_cpu_dev = {
diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index 8eba9ca..3a1a957 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -846,13 +846,13 @@ void cpu_detect_cache_sizes(struct cpuinfo_x86 *c)
 	c->x86_cache_size = l2size;
 }
 
-u16 __read_mostly tlb_lli_4k[NR_INFO];
-u16 __read_mostly tlb_lli_2m[NR_INFO];
-u16 __read_mostly tlb_lli_4m[NR_INFO];
-u16 __read_mostly tlb_lld_4k[NR_INFO];
-u16 __read_mostly tlb_lld_2m[NR_INFO];
-u16 __read_mostly tlb_lld_4m[NR_INFO];
-u16 __read_mostly tlb_lld_1g[NR_INFO];
+u16 __read_mostly tlb_lli_4k;
+u16 __read_mostly tlb_lli_2m;
+u16 __read_mostly tlb_lli_4m;
+u16 __read_mostly tlb_lld_4k;
+u16 __read_mostly tlb_lld_2m;
+u16 __read_mostly tlb_lld_4m;
+u16 __read_mostly tlb_lld_1g;
 
 static void cpu_detect_tlb(struct cpuinfo_x86 *c)
 {
@@ -860,12 +860,10 @@ static void cpu_detect_tlb(struct cpuinfo_x86 *c)
 		this_cpu->c_detect_tlb(c);
 
 	pr_info("Last level iTLB entries: 4KB %d, 2MB %d, 4MB %d\n",
-		tlb_lli_4k[ENTRIES], tlb_lli_2m[ENTRIES],
-		tlb_lli_4m[ENTRIES]);
+		tlb_lli_4k, tlb_lli_2m, tlb_lli_4m);
 
 	pr_info("Last level dTLB entries: 4KB %d, 2MB %d, 4MB %d, 1GB %d\n",
-		tlb_lld_4k[ENTRIES], tlb_lld_2m[ENTRIES],
-		tlb_lld_4m[ENTRIES], tlb_lld_1g[ENTRIES]);
+		tlb_lld_4k, tlb_lld_2m, tlb_lld_4m, tlb_lld_1g);
 }
 
 void get_cpu_vendor(struct cpuinfo_x86 *c)
diff --git a/arch/x86/kernel/cpu/hygon.c b/arch/x86/kernel/cpu/hygon.c
index c5191b0..6af4a4a 100644
--- a/arch/x86/kernel/cpu/hygon.c
+++ b/arch/x86/kernel/cpu/hygon.c
@@ -240,26 +240,26 @@ static void cpu_detect_tlb_hygon(struct cpuinfo_x86 *c)
 
 	cpuid(0x80000006, &eax, &ebx, &ecx, &edx);
 
-	tlb_lld_4k[ENTRIES] = (ebx >> 16) & mask;
-	tlb_lli_4k[ENTRIES] = ebx & mask;
+	tlb_lld_4k = (ebx >> 16) & mask;
+	tlb_lli_4k = ebx & mask;
 
 	/* Handle DTLB 2M and 4M sizes, fall back to L1 if L2 is disabled */
 	if (!((eax >> 16) & mask))
-		tlb_lld_2m[ENTRIES] = (cpuid_eax(0x80000005) >> 16) & 0xff;
+		tlb_lld_2m = (cpuid_eax(0x80000005) >> 16) & 0xff;
 	else
-		tlb_lld_2m[ENTRIES] = (eax >> 16) & mask;
+		tlb_lld_2m = (eax >> 16) & mask;
 
 	/* a 4M entry uses two 2M entries */
-	tlb_lld_4m[ENTRIES] = tlb_lld_2m[ENTRIES] >> 1;
+	tlb_lld_4m = tlb_lld_2m >> 1;
 
 	/* Handle ITLB 2M and 4M sizes, fall back to L1 if L2 is disabled */
 	if (!(eax & mask)) {
 		cpuid(0x80000005, &eax, &ebx, &ecx, &edx);
-		tlb_lli_2m[ENTRIES] = eax & 0xff;
+		tlb_lli_2m = eax & 0xff;
 	} else
-		tlb_lli_2m[ENTRIES] = eax & mask;
+		tlb_lli_2m = eax & mask;
 
-	tlb_lli_4m[ENTRIES] = tlb_lli_2m[ENTRIES] >> 1;
+	tlb_lli_4m = tlb_lli_2m >> 1;
 }
 
 static const struct cpu_dev hygon_cpu_dev = {
diff --git a/arch/x86/kernel/cpu/intel.c b/arch/x86/kernel/cpu/intel.c
index 42a57b8..61d3fd3 100644
--- a/arch/x86/kernel/cpu/intel.c
+++ b/arch/x86/kernel/cpu/intel.c
@@ -718,55 +718,55 @@ static void intel_tlb_lookup(const unsigned char desc)
 	entries = intel_tlb_table[k].entries;
 	switch (intel_tlb_table[k].tlb_type) {
 	case STLB_4K:
-		tlb_lli_4k[ENTRIES] = max(tlb_lli_4k[ENTRIES], entries);
-		tlb_lld_4k[ENTRIES] = max(tlb_lld_4k[ENTRIES], entries);
+		tlb_lli_4k = max(tlb_lli_4k, entries);
+		tlb_lld_4k = max(tlb_lld_4k, entries);
 		break;
 	case STLB_4K_2M:
-		tlb_lli_4k[ENTRIES] = max(tlb_lli_4k[ENTRIES], entries);
-		tlb_lld_4k[ENTRIES] = max(tlb_lld_4k[ENTRIES], entries);
-		tlb_lli_2m[ENTRIES] = max(tlb_lli_2m[ENTRIES], entries);
-		tlb_lld_2m[ENTRIES] = max(tlb_lld_2m[ENTRIES], entries);
-		tlb_lli_4m[ENTRIES] = max(tlb_lli_4m[ENTRIES], entries);
-		tlb_lld_4m[ENTRIES] = max(tlb_lld_4m[ENTRIES], entries);
+		tlb_lli_4k = max(tlb_lli_4k, entries);
+		tlb_lld_4k = max(tlb_lld_4k, entries);
+		tlb_lli_2m = max(tlb_lli_2m, entries);
+		tlb_lld_2m = max(tlb_lld_2m, entries);
+		tlb_lli_4m = max(tlb_lli_4m, entries);
+		tlb_lld_4m = max(tlb_lld_4m, entries);
 		break;
 	case TLB_INST_ALL:
-		tlb_lli_4k[ENTRIES] = max(tlb_lli_4k[ENTRIES], entries);
-		tlb_lli_2m[ENTRIES] = max(tlb_lli_2m[ENTRIES], entries);
-		tlb_lli_4m[ENTRIES] = max(tlb_lli_4m[ENTRIES], entries);
+		tlb_lli_4k = max(tlb_lli_4k, entries);
+		tlb_lli_2m = max(tlb_lli_2m, entries);
+		tlb_lli_4m = max(tlb_lli_4m, entries);
 		break;
 	case TLB_INST_4K:
-		tlb_lli_4k[ENTRIES] = max(tlb_lli_4k[ENTRIES], entries);
+		tlb_lli_4k = max(tlb_lli_4k, entries);
 		break;
 	case TLB_INST_4M:
-		tlb_lli_4m[ENTRIES] = max(tlb_lli_4m[ENTRIES], entries);
+		tlb_lli_4m = max(tlb_lli_4m, entries);
 		break;
 	case TLB_INST_2M_4M:
-		tlb_lli_2m[ENTRIES] = max(tlb_lli_2m[ENTRIES], entries);
-		tlb_lli_4m[ENTRIES] = max(tlb_lli_4m[ENTRIES], entries);
+		tlb_lli_2m = max(tlb_lli_2m, entries);
+		tlb_lli_4m = max(tlb_lli_4m, entries);
 		break;
 	case TLB_DATA_4K:
 	case TLB_DATA0_4K:
-		tlb_lld_4k[ENTRIES] = max(tlb_lld_4k[ENTRIES], entries);
+		tlb_lld_4k = max(tlb_lld_4k, entries);
 		break;
 	case TLB_DATA_4M:
 	case TLB_DATA0_4M:
-		tlb_lld_4m[ENTRIES] = max(tlb_lld_4m[ENTRIES], entries);
+		tlb_lld_4m = max(tlb_lld_4m, entries);
 		break;
 	case TLB_DATA_2M_4M:
 	case TLB_DATA0_2M_4M:
-		tlb_lld_2m[ENTRIES] = max(tlb_lld_2m[ENTRIES], entries);
-		tlb_lld_4m[ENTRIES] = max(tlb_lld_4m[ENTRIES], entries);
+		tlb_lld_2m = max(tlb_lld_2m, entries);
+		tlb_lld_4m = max(tlb_lld_4m, entries);
 		break;
 	case TLB_DATA_4K_4M:
-		tlb_lld_4k[ENTRIES] = max(tlb_lld_4k[ENTRIES], entries);
-		tlb_lld_4m[ENTRIES] = max(tlb_lld_4m[ENTRIES], entries);
+		tlb_lld_4k = max(tlb_lld_4k, entries);
+		tlb_lld_4m = max(tlb_lld_4m, entries);
 		break;
 	case TLB_DATA_1G_2M_4M:
-		tlb_lld_2m[ENTRIES] = max(tlb_lld_2m[ENTRIES], TLB_0x63_2M_4M_ENTRIES);
-		tlb_lld_4m[ENTRIES] = max(tlb_lld_4m[ENTRIES], TLB_0x63_2M_4M_ENTRIES);
+		tlb_lld_2m = max(tlb_lld_2m, TLB_0x63_2M_4M_ENTRIES);
+		tlb_lld_4m = max(tlb_lld_4m, TLB_0x63_2M_4M_ENTRIES);
 		fallthrough;
 	case TLB_DATA_1G:
-		tlb_lld_1g[ENTRIES] = max(tlb_lld_1g[ENTRIES], entries);
+		tlb_lld_1g = max(tlb_lld_1g, entries);
 		break;
 	}
 }

