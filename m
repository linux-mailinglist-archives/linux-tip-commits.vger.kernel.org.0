Return-Path: <linux-tip-commits+bounces-3101-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B033A9F683B
	for <lists+linux-tip-commits@lfdr.de>; Wed, 18 Dec 2024 15:23:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 53DAD18937B3
	for <lists+linux-tip-commits@lfdr.de>; Wed, 18 Dec 2024 14:23:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 132321C5CDD;
	Wed, 18 Dec 2024 14:22:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="aT57gHDY";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="kNK8ZR5w"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DB0D1B4234;
	Wed, 18 Dec 2024 14:22:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734531759; cv=none; b=g4qzrOny16cuDa/Fw1Y29Dr2OWCQNeTaUJs82FA8i8inBqYXzG1SByP1LoRrfCTEZPc+C9uqKzzJNJmrmRv17HewknasFOboDhjbtbYS4hokb4b+D2gEA5xHX0YL75F3yurtkmLCpB7qDtjML6RNruS7vGVHryQaMZo/6Zkv9oc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734531759; c=relaxed/simple;
	bh=JvXpbL2M0zEHdZf+MMdpRukldSJY/YicNTmiyxAk95U=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=tPlsBZIqJGGD75zeyYGVWj1llU4DDk8xPELOxsH0HVFuGAAvqppoBGXVbpSwFrbRQHJ15Gy4IiNPRdxXs7yZl6MIVqVBIUXrz/RGwKRrueCk4uieKtT7hnTXbizoBUjdJp098UPRhFYP8a1xBBTjEJG/J0RrOiBJyWZiSI3cpbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=aT57gHDY; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=kNK8ZR5w; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 18 Dec 2024 14:22:34 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1734531755;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=+BjgjDEfF93eme1N2iJGixuQaqPafnPV2fd/34SQ5M0=;
	b=aT57gHDYXynjuVfGd25LxBt+f2rFKvSZLTItrSnwZf40R8iQlUiOIBzS8LDvOgK2cTaCbV
	ty0k46gm3tpa/C06iuvt32Fs0yww5ah0u8UR2/wsRVQAYsVF3eBPPN77MRYJtkysQRLNRn
	CGECjmRkhFMoSgo7HgXcNMjPRhgyeK4PgkAXSJMXpj5DOqoS6vDAyX4eYHjiEziy0AnvJi
	ysIlmQvctvrmTVefFfrZE11e2bxytJJ6oI1YSJ9ye6TRUFuKtCcv4KKrAjckkunJzOilc4
	L/pAXMR/pyN94GMv55lVyuwFmw431cv9BBim/XBVuty2jJ1XOTremyLZ883EDw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1734531755;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=+BjgjDEfF93eme1N2iJGixuQaqPafnPV2fd/34SQ5M0=;
	b=kNK8ZR5wBOF4Ewd1WiXGu/8AYxpO5c8P61DFiXhcGgTQgXpLx2bO8952von7XLckz2TnMi
	LuFoSWvxCtY5dCDQ==
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
Message-ID: <173453175490.7135.7624334772489922039.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/cpu branch of tip:

Commit-ID:     030c15b5610cedf7eb428dab5382f73d492a7967
Gitweb:        https://git.kernel.org/tip/030c15b5610cedf7eb428dab5382f73d492a7967
Author:        Dave Hansen <dave.hansen@linux.intel.com>
AuthorDate:    Fri, 13 Dec 2024 12:50:34 -08:00
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Wed, 18 Dec 2024 06:17:38 -08:00

x86/tsc: Move away from TSC leaf magic numbers

The TSC code has a bunch of hard-coded references to leaf 0x15.  Change
them over to the symbolic name.  Also zap the 'ART_CPUID_LEAF' definition.
It was a duplicate of 'CPUID_TSC_LEAF'.

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

