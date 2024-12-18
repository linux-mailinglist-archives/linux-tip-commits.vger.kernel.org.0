Return-Path: <linux-tip-commits+bounces-3090-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BF03D9F67DE
	for <lists+linux-tip-commits@lfdr.de>; Wed, 18 Dec 2024 15:04:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7B5E5188B8AE
	for <lists+linux-tip-commits@lfdr.de>; Wed, 18 Dec 2024 14:03:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DBEE1C2DA2;
	Wed, 18 Dec 2024 14:03:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="XjUOwdAG";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="td9Q6a7m"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BB6E1B4232;
	Wed, 18 Dec 2024 14:03:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734530603; cv=none; b=q8g01poOlSPrkYF/xFvmW5p/oyBonRKxZK0OiI92sBhv8CEJRutI1sUNc0a55o/Hos3jA4NpdUHloOJmOt26gL6TSLeUGOtGoKVqOvCiPHIXcr+zOLi9VVHY9aSw5Fc4jUU8zMR6qNkblAhjIs1NLMvXfdquFzO2jbgFkOEGasQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734530603; c=relaxed/simple;
	bh=dkVWoPGH4YcBWXyjLfY+g/DEginD32ZbVOit2Y6eCm0=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=R8Qs1zYMo4pXh/GC6v9eqlEp5UizsUG0zGDVVx23Nv4+MaRf606rTHyXEFPWAXmq99+NAjNgdKPKT3MVtHGx0aZBjsbURcX6jIToaRD1y1l8OVETZva18M66nTEAY7L+kQM4lEFwqGGGQ1n1sdfNYARfSJiavtUx9+Omhs+KVag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=XjUOwdAG; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=td9Q6a7m; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 18 Dec 2024 14:03:18 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1734530599;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=9tezgDVHu5rnT/iJpyqaE5K1sSpekmyHxTTTrin4A1E=;
	b=XjUOwdAG9sXw9vZ2grNq2k8cAQjshXjqmMgZ1IEJXZsBkABgspRRL1lGIDCL0H3Vh55Z4C
	/Yva8ziYFkv2RA4uDg8w++de4pnzNPm0Q1H0Gu8OT2pF+yOtfvwDuSbd3GsYoJ80pkxZVw
	yl/mFU24Zp7xitkWB2Zm4P28lop6xFhy95jUJC4ApusRkhDXRGauhrcJntN49XYi3s8GoK
	WXMsxqkyiRJpfmC4rTKHn8DdbSup/zzsh3J1xDh9hNmGDZtd26ribT00Jpq4UV7i+5ZOwF
	Sd/H26vMp3XOrgQ0xIprl9NWVPBNNM0/ouzfWs3iSADNl9adC8uqIujOpfaVcw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1734530599;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=9tezgDVHu5rnT/iJpyqaE5K1sSpekmyHxTTTrin4A1E=;
	b=td9Q6a7msE3rHpjmAsS+8QZResTlwRt83ZfzOkwBISsNHZHUUtVmRdQNmBk7hrPtZHrKKU
	sATetH5rNCowGQDQ==
From: "tip-bot2 for Dave Hansen" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cpu] x86/tsc: Move away from TSC leaf magic numbers
Cc: Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173453059898.7135.18395162141746259799.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/cpu branch of tip:

Commit-ID:     e8a35bb2b4452d4ec5812d4add184c3d4556d75d
Gitweb:        https://git.kernel.org/tip/e8a35bb2b4452d4ec5812d4add184c3d4556d75d
Author:        Dave Hansen <dave.hansen@linux.intel.com>
AuthorDate:    Fri, 13 Dec 2024 12:50:34 -08:00
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Wed, 18 Dec 2024 05:24:43 -08:00

x86/tsc: Move away from TSC leaf magic numbers

The TSC code has a bunch of hard-coded references to leaf 0x15.  Change
them over to the symbolic name.  Also zap the 'ART_CPUID_LEAF' definition.
It was a duplicate of 'CPUID_TSC_LEAF'.

Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Link: https://lore.kernel.org/all/20241213205034.B79D6224%40davehans-spike.ostc.intel.com
---
 arch/x86/kernel/tsc.c                 | 11 +++++------
 drivers/platform/x86/intel/pmc/core.c |  7 ++++---
 2 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/arch/x86/kernel/tsc.c b/arch/x86/kernel/tsc.c
index 67aeaba..8091b0e 100644
--- a/arch/x86/kernel/tsc.c
+++ b/arch/x86/kernel/tsc.c
@@ -16,6 +16,7 @@
 #include <linux/static_key.h>
 #include <linux/static_call.h>
 
+#include <asm/cpuid.h>
 #include <asm/hpet.h>
 #include <asm/timer.h>
 #include <asm/vgtod.h>
@@ -665,13 +666,13 @@ unsigned long native_calibrate_tsc(void)
 	if (boot_cpu_data.x86_vendor != X86_VENDOR_INTEL)
 		return 0;
 
-	if (boot_cpu_data.cpuid_level < 0x15)
+	if (boot_cpu_data.cpuid_level < CPUID_TSC_LEAF)
 		return 0;
 
 	eax_denominator = ebx_numerator = ecx_hz = edx = 0;
 
 	/* CPUID 15H TSC/Crystal ratio, plus optionally Crystal Hz */
-	cpuid(0x15, &eax_denominator, &ebx_numerator, &ecx_hz, &edx);
+	cpuid(CPUID_TSC_LEAF, &eax_denominator, &ebx_numerator, &ecx_hz, &edx);
 
 	if (ebx_numerator == 0 || eax_denominator == 0)
 		return 0;
@@ -1067,10 +1068,8 @@ core_initcall(cpufreq_register_tsc_scaling);
 
 #endif /* CONFIG_CPU_FREQ */
 
-#define ART_CPUID_LEAF (0x15)
 #define ART_MIN_DENOMINATOR (1)
 
-
 /*
  * If ART is present detect the numerator:denominator to convert to TSC
  */
@@ -1078,7 +1077,7 @@ static void __init detect_art(void)
 {
 	unsigned int unused;
 
-	if (boot_cpu_data.cpuid_level < ART_CPUID_LEAF)
+	if (boot_cpu_data.cpuid_level < CPUID_TSC_LEAF)
 		return;
 
 	/*
@@ -1091,7 +1090,7 @@ static void __init detect_art(void)
 	    tsc_async_resets)
 		return;
 
-	cpuid(ART_CPUID_LEAF, &art_base_clk.denominator,
+	cpuid(CPUID_TSC_LEAF, &art_base_clk.denominator,
 	      &art_base_clk.numerator, &art_base_clk.freq_khz, &unused);
 
 	art_base_clk.freq_khz /= KHZ;
diff --git a/drivers/platform/x86/intel/pmc/core.c b/drivers/platform/x86/intel/pmc/core.c
index 3e7f99a..ac8231e 100644
--- a/drivers/platform/x86/intel/pmc/core.c
+++ b/drivers/platform/x86/intel/pmc/core.c
@@ -22,6 +22,7 @@
 #include <linux/suspend.h>
 #include <linux/units.h>
 
+#include <asm/cpuid.h>
 #include <asm/cpu_device_id.h>
 #include <asm/intel-family.h>
 #include <asm/msr.h>
@@ -935,13 +936,13 @@ static unsigned int pmc_core_get_crystal_freq(void)
 {
 	unsigned int eax_denominator, ebx_numerator, ecx_hz, edx;
 
-	if (boot_cpu_data.cpuid_level < 0x15)
+	if (boot_cpu_data.cpuid_level < CPUID_TSC_LEAF)
 		return 0;
 
 	eax_denominator = ebx_numerator = ecx_hz = edx = 0;
 
-	/* CPUID 15H TSC/Crystal ratio, plus optionally Crystal Hz */
-	cpuid(0x15, &eax_denominator, &ebx_numerator, &ecx_hz, &edx);
+	/* TSC/Crystal ratio, plus optionally Crystal Hz */
+	cpuid(CPUID_TSC_LEAF, &eax_denominator, &ebx_numerator, &ecx_hz, &edx);
 
 	if (ebx_numerator == 0 || eax_denominator == 0)
 		return 0;

