Return-Path: <linux-tip-commits+bounces-4020-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC795A50DCC
	for <lists+linux-tip-commits@lfdr.de>; Wed,  5 Mar 2025 22:40:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BF2251767A1
	for <lists+linux-tip-commits@lfdr.de>; Wed,  5 Mar 2025 21:39:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47FF925D90B;
	Wed,  5 Mar 2025 21:36:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="xsDF3SmM";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Qbou11Ub"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0181925CC85;
	Wed,  5 Mar 2025 21:36:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741210592; cv=none; b=ZqH+FduUyjM7untpQRkmjTRNX2j/O5vJ4yrVZH8hGqv32NfmtHEURLftaNth285wbMbLMqoYKZaatXYrzTNNmQboXFm8c84cprcPl6V2oe40jyt3KufxYr2ZIA7daecnRTjYGdqTBdMrn2PFiyH5WNQNf4n/xMXtG753/13LB+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741210592; c=relaxed/simple;
	bh=8DauXhbFIZsn4OPqjAxO7N4iZZzIj3UjKbIfeG6PX8I=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=MSpiTRC4RAqtO5gJz2/0m7XffnyXPXOPI9UM4RXvykJnqbUR6kmvcGxOMTIhY/CEffQDizZI5Typj6jr568PjPzxWoAVnGi/c2I/rji9da4OOU+HmqWazaaRW7kvRoVEYsl2q11/BUEQUJ0q1XIwrYiBep+eNMKtCDV4S3l87xw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=xsDF3SmM; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Qbou11Ub; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 05 Mar 2025 21:36:27 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1741210588;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nEXuk65mbvpXWs7dDZj4TEqIqr82PeVsSyr/Rk+3AaA=;
	b=xsDF3SmMT/jlq2OyeNjSh/p5RVSMM8PLGYGB8XA8IAHnaMM9FqFKSVs8ePSsWM1DEFlKkV
	lM+E6C+5XKN7YEORfEBMFrHopFUt8PYLqve8DAy4y7RQcYpzkWWwi9nl6ANHFDXSsLPciU
	xJZrp6mGwshvT3vBWoTrDKkwkPbyadKJb10xVHsj/UQHKA3SgiwqmIdVWGUmsTPXO2ogF/
	Xy+cNzUL3+O9Gfj3Me48XYQxiXHyrck/5w/F+Rt1RkTiSfuDELpt0EhezBtIUe1CKspPGc
	tkRLmFgXGIIolJvrGMg3ixD6k4pMqrWGH4GhF1dqZIuQOzrmYb7JecK8w4Y83Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1741210588;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nEXuk65mbvpXWs7dDZj4TEqIqr82PeVsSyr/Rk+3AaA=;
	b=Qbou11UbrTNZG42VxJ6iwkvDvunfWPfc/7SqRqeHIj8f+LJ/SOwrO/5f3hXjxaa5rC3bbM
	d+Cck9RGYnebDLDg==
From: "tip-bot2 for Rik van Riel" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/mm] x86/mm: Add INVLPGB feature and Kconfig entry
Cc: Rik van Riel <riel@surriel.com>, "Borislav Petkov (AMD)" <bp@alien8.de>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250226030129.530345-3-riel@surriel.com>
References: <20250226030129.530345-3-riel@surriel.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174121058767.14745.7357879202021681608.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/mm branch of tip:

Commit-ID:     dc9a260e96d57cc60482a147205e60de35833d08
Gitweb:        https://git.kernel.org/tip/dc9a260e96d57cc60482a147205e60de35833d08
Author:        Rik van Riel <riel@surriel.com>
AuthorDate:    Tue, 25 Feb 2025 22:00:37 -05:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Wed, 05 Mar 2025 17:19:08 +01:00

x86/mm: Add INVLPGB feature and Kconfig entry

In addition, the CPU advertises the maximum number of pages that can be
shot down with one INVLPGB instruction in CPUID. Save that information
for later use.

  [ bp: use cpu_has(), typos, massage. ]

Signed-off-by: Rik van Riel <riel@surriel.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://lore.kernel.org/r/20250226030129.530345-3-riel@surriel.com
---
 arch/x86/Kconfig.cpu                     | 4 ++++
 arch/x86/include/asm/cpufeatures.h       | 1 +
 arch/x86/include/asm/disabled-features.h | 8 +++++++-
 arch/x86/include/asm/tlbflush.h          | 3 +++
 arch/x86/kernel/cpu/amd.c                | 6 ++++++
 5 files changed, 21 insertions(+), 1 deletion(-)

diff --git a/arch/x86/Kconfig.cpu b/arch/x86/Kconfig.cpu
index 2a7279d..25c55cc 100644
--- a/arch/x86/Kconfig.cpu
+++ b/arch/x86/Kconfig.cpu
@@ -401,6 +401,10 @@ menuconfig PROCESSOR_SELECT
 	  This lets you choose what x86 vendor support code your kernel
 	  will include.
 
+config BROADCAST_TLB_FLUSH
+	def_bool y
+	depends on CPU_SUP_AMD && 64BIT
+
 config CPU_SUP_INTEL
 	default y
 	bool "Support Intel processors" if PROCESSOR_SELECT
diff --git a/arch/x86/include/asm/cpufeatures.h b/arch/x86/include/asm/cpufeatures.h
index 508c0da..8770dc1 100644
--- a/arch/x86/include/asm/cpufeatures.h
+++ b/arch/x86/include/asm/cpufeatures.h
@@ -338,6 +338,7 @@
 #define X86_FEATURE_CLZERO		(13*32+ 0) /* "clzero" CLZERO instruction */
 #define X86_FEATURE_IRPERF		(13*32+ 1) /* "irperf" Instructions Retired Count */
 #define X86_FEATURE_XSAVEERPTR		(13*32+ 2) /* "xsaveerptr" Always save/restore FP error pointers */
+#define X86_FEATURE_INVLPGB		(13*32+ 3) /* INVLPGB and TLBSYNC instructions supported */
 #define X86_FEATURE_RDPRU		(13*32+ 4) /* "rdpru" Read processor register at user level */
 #define X86_FEATURE_WBNOINVD		(13*32+ 9) /* "wbnoinvd" WBNOINVD instruction */
 #define X86_FEATURE_AMD_IBPB		(13*32+12) /* Indirect Branch Prediction Barrier */
diff --git a/arch/x86/include/asm/disabled-features.h b/arch/x86/include/asm/disabled-features.h
index c492bdc..be8c388 100644
--- a/arch/x86/include/asm/disabled-features.h
+++ b/arch/x86/include/asm/disabled-features.h
@@ -129,6 +129,12 @@
 #define DISABLE_SEV_SNP		(1 << (X86_FEATURE_SEV_SNP & 31))
 #endif
 
+#ifdef CONFIG_BROADCAST_TLB_FLUSH
+#define DISABLE_INVLPGB		0
+#else
+#define DISABLE_INVLPGB		(1 << (X86_FEATURE_INVLPGB & 31))
+#endif
+
 /*
  * Make sure to add features to the correct mask
  */
@@ -146,7 +152,7 @@
 #define DISABLED_MASK11	(DISABLE_RETPOLINE|DISABLE_RETHUNK|DISABLE_UNRET| \
 			 DISABLE_CALL_DEPTH_TRACKING|DISABLE_USER_SHSTK)
 #define DISABLED_MASK12	(DISABLE_FRED|DISABLE_LAM)
-#define DISABLED_MASK13	0
+#define DISABLED_MASK13	(DISABLE_INVLPGB)
 #define DISABLED_MASK14	0
 #define DISABLED_MASK15	0
 #define DISABLED_MASK16	(DISABLE_PKU|DISABLE_OSPKE|DISABLE_LA57|DISABLE_UMIP| \
diff --git a/arch/x86/include/asm/tlbflush.h b/arch/x86/include/asm/tlbflush.h
index 3da6451..855c13d 100644
--- a/arch/x86/include/asm/tlbflush.h
+++ b/arch/x86/include/asm/tlbflush.h
@@ -183,6 +183,9 @@ static inline void cr4_init_shadow(void)
 extern unsigned long mmu_cr4_features;
 extern u32 *trampoline_cr4_features;
 
+/* How many pages can be invalidated with one INVLPGB. */
+extern u16 invlpgb_count_max;
+
 extern void initialize_tlbstate_and_flush(void);
 
 /*
diff --git a/arch/x86/kernel/cpu/amd.c b/arch/x86/kernel/cpu/amd.c
index 54194f5..7a72ef4 100644
--- a/arch/x86/kernel/cpu/amd.c
+++ b/arch/x86/kernel/cpu/amd.c
@@ -29,6 +29,8 @@
 
 #include "cpu.h"
 
+u16 invlpgb_count_max __ro_after_init;
+
 static inline int rdmsrl_amd_safe(unsigned msr, unsigned long long *p)
 {
 	u32 gprs[8] = { 0 };
@@ -1139,6 +1141,10 @@ static void cpu_detect_tlb_amd(struct cpuinfo_x86 *c)
 		tlb_lli_2m[ENTRIES] = eax & mask;
 
 	tlb_lli_4m[ENTRIES] = tlb_lli_2m[ENTRIES] >> 1;
+
+	/* Max number of pages INVLPGB can invalidate in one shot */
+	if (cpu_has(c, X86_FEATURE_INVLPGB))
+		invlpgb_count_max = (cpuid_edx(0x80000008) & 0xffff) + 1;
 }
 
 static const struct cpu_dev amd_cpu_dev = {

