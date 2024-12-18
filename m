Return-Path: <linux-tip-commits+bounces-3099-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A79CD9F6835
	for <lists+linux-tip-commits@lfdr.de>; Wed, 18 Dec 2024 15:23:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1C3071893858
	for <lists+linux-tip-commits@lfdr.de>; Wed, 18 Dec 2024 14:23:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DB6D1B424B;
	Wed, 18 Dec 2024 14:22:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="b6hKIS/M";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Pbzo4ogl"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A81A770819;
	Wed, 18 Dec 2024 14:22:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734531757; cv=none; b=dSBmaRPLwO9uRf8jBNiTMWk9t3qO43RR+ApTZUpynayPsfMB1zzQ5kb1GGZUcVmhVEAEjMcf98WVVxs2RpEK66j+8lxckA9JxPPbP0t7JxVaACcPzvjow715c2hkXBASZ892SeZGVWSqQEd1woBv2fFW/Y+6Pht+RMzJRU+0iUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734531757; c=relaxed/simple;
	bh=ATbPhPFHoN5nk4RSQmrQDm5ZdKd22ZFEFqsIlWXMHVk=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=SLi3rY5L9tJeMlcdvt7dXMEeBLOor/SPJB6oPYJSzvLbp9ZE1u5OdI5SoBdlVR0FIUX/+hz8y5wLQWBkoJX9qVcp5ovSIVQY+71y8ktaH6Ke6+Eq7er0riYljJaf+OWQ4MTCtSJHNN0C4N02udGEQZ37YZIkghWLael3vYL1m3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=b6hKIS/M; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Pbzo4ogl; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 18 Dec 2024 14:22:31 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1734531752;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=5wxjlvmkkVd0kyR9Bx+RlqiNPK9HgPWKZ6+p//X/QJE=;
	b=b6hKIS/Moo3WV4TtJ74XdIuEO7+8ixLRPz4JqoL1XbqTRL6lhzF5bcz4F/3sDEbRVH7E/h
	QaEftPGaqtKCC4MNzoMZqkvA2f7FSXn+aLtf1T/vjJP8OpetXet5c3eg1+9mLWhJ9j+5NY
	DWQBrWxS3o+gmdKg7SKT15MCVxjSHUhTZ06Z+E5vOBYAZCgSOtGuzt663sQ3TNkXlXD4rR
	tW9+3FDPjriBTQrjR9Wif+yUbRoHpWWnkwkorA7omOPaWaSrBM8lJb7O8u07VWk1jDxHGC
	5T6Bk52c36iU5nnrCNaJDtPRIdGckXlJGjVv8l5Ku73D6s70dH3S/fYdXRn02Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1734531752;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=5wxjlvmkkVd0kyR9Bx+RlqiNPK9HgPWKZ6+p//X/QJE=;
	b=Pbzo4oglgRpF5wfMHn2eiZAMfKBWkHVX+apvhD72qJq/+HcroiQyn42nIq/ATzok8ejwz/
	wLWiRP4jNo8tu7Bw==
From: "tip-bot2 for Dave Hansen" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cpu] x86/cpu: Make all all CPUID leaf names consistent
Cc: Dave Hansen <dave.hansen@linux.intel.com>,
 Dave Jiang <dave.jiang@intel.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173453175126.7135.6208512118222296685.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/cpu branch of tip:

Commit-ID:     e5d3a57891ba500503df075b99b78d6e61f2694e
Gitweb:        https://git.kernel.org/tip/e5d3a57891ba500503df075b99b78d6e61f2694e
Author:        Dave Hansen <dave.hansen@linux.intel.com>
AuthorDate:    Fri, 13 Dec 2024 12:50:40 -08:00
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Wed, 18 Dec 2024 06:17:46 -08:00

x86/cpu: Make all all CPUID leaf names consistent

The leaf names are not consistent.  Give them all a CPUID_LEAF_ prefix
for consistency and vertical alignment.

Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Acked-by: Dave Jiang <dave.jiang@intel.com> # for ioatdma bits
Link: https://lore.kernel.org/all/20241213205040.7B0C3241%40davehans-spike.ostc.intel.com
---
 arch/x86/events/intel/pt.c            |  4 ++--
 arch/x86/include/asm/cpuid.h          | 12 ++++++------
 arch/x86/kernel/acpi/cstate.c         |  4 ++--
 arch/x86/kernel/cpu/common.c          |  6 +++---
 arch/x86/kernel/fpu/xstate.c          | 20 ++++++++++----------
 arch/x86/kernel/hpet.c                |  2 +-
 arch/x86/kernel/process.c             |  2 +-
 arch/x86/kernel/smpboot.c             |  2 +-
 arch/x86/kernel/tsc.c                 | 18 +++++++++---------
 arch/x86/xen/enlighten_pv.c           |  4 ++--
 drivers/acpi/acpi_pad.c               |  2 +-
 drivers/dma/ioat/dca.c                |  2 +-
 drivers/idle/intel_idle.c             |  2 +-
 drivers/platform/x86/intel/pmc/core.c |  4 ++--
 14 files changed, 42 insertions(+), 42 deletions(-)

diff --git a/arch/x86/events/intel/pt.c b/arch/x86/events/intel/pt.c
index 6081455..fa37565 100644
--- a/arch/x86/events/intel/pt.c
+++ b/arch/x86/events/intel/pt.c
@@ -202,10 +202,10 @@ static int __init pt_pmu_hw_init(void)
 	 * otherwise, zero for numerator stands for "not enumerated"
 	 * as per SDM
 	 */
-	if (boot_cpu_data.cpuid_level >= CPUID_TSC_LEAF) {
+	if (boot_cpu_data.cpuid_level >= CPUID_LEAF_TSC) {
 		u32 eax, ebx, ecx, edx;
 
-		cpuid(CPUID_TSC_LEAF, &eax, &ebx, &ecx, &edx);
+		cpuid(CPUID_LEAF_TSC, &eax, &ebx, &ecx, &edx);
 
 		pt_pmu.tsc_art_num = ebx;
 		pt_pmu.tsc_art_den = eax;
diff --git a/arch/x86/include/asm/cpuid.h b/arch/x86/include/asm/cpuid.h
index a86097e..b2b9b4e 100644
--- a/arch/x86/include/asm/cpuid.h
+++ b/arch/x86/include/asm/cpuid.h
@@ -21,12 +21,12 @@ enum cpuid_regs_idx {
 	CPUID_EDX,
 };
 
-#define CPUID_MWAIT_LEAF	0x5
-#define CPUID_DCA_LEAF		0x9
-#define XSTATE_CPUID		0x0d
-#define CPUID_TSC_LEAF		0x15
-#define CPUID_FREQ_LEAF		0x16
-#define TILE_CPUID		0x1d
+#define CPUID_LEAF_MWAIT	0x5
+#define CPUID_LEAF_DCA		0x9
+#define CPUID_LEAF_XSTATE	0x0d
+#define CPUID_LEAF_TSC		0x15
+#define CPUID_LEAF_FREQ		0x16
+#define CPUID_LEAF_TILE		0x1d
 
 #ifdef CONFIG_X86_32
 bool have_cpuid_p(void);
diff --git a/arch/x86/kernel/acpi/cstate.c b/arch/x86/kernel/acpi/cstate.c
index 2779a93..5854f0b 100644
--- a/arch/x86/kernel/acpi/cstate.c
+++ b/arch/x86/kernel/acpi/cstate.c
@@ -129,7 +129,7 @@ static long acpi_processor_ffh_cstate_probe_cpu(void *_cx)
 	unsigned int cstate_type; /* C-state type and not ACPI C-state type */
 	unsigned int num_cstate_subtype;
 
-	cpuid(CPUID_MWAIT_LEAF, &eax, &ebx, &ecx, &edx);
+	cpuid(CPUID_LEAF_MWAIT, &eax, &ebx, &ecx, &edx);
 
 	/* Check whether this particular cx_type (in CST) is supported or not */
 	cstate_type = (((cx->address >> MWAIT_SUBSTATE_SIZE) &
@@ -173,7 +173,7 @@ int acpi_processor_ffh_cstate_probe(unsigned int cpu,
 	struct cpuinfo_x86 *c = &cpu_data(cpu);
 	long retval;
 
-	if (!cpu_cstate_entry || c->cpuid_level < CPUID_MWAIT_LEAF)
+	if (!cpu_cstate_entry || c->cpuid_level < CPUID_LEAF_MWAIT)
 		return -1;
 
 	if (reg->bit_offset != NATIVE_CSTATE_BEYOND_HALT)
diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index f5c33e1..2bdb9e0 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -637,9 +637,9 @@ struct cpuid_dependent_feature {
 
 static const struct cpuid_dependent_feature
 cpuid_dependent_features[] = {
-	{ X86_FEATURE_MWAIT,		CPUID_MWAIT_LEAF },
-	{ X86_FEATURE_DCA,		CPUID_DCA_LEAF },
-	{ X86_FEATURE_XSAVE,		XSTATE_CPUID },
+	{ X86_FEATURE_MWAIT,		CPUID_LEAF_MWAIT },
+	{ X86_FEATURE_DCA,		CPUID_LEAF_DCA },
+	{ X86_FEATURE_XSAVE,		CPUID_LEAF_XSTATE },
 	{ 0, 0 }
 };
 
diff --git a/arch/x86/kernel/fpu/xstate.c b/arch/x86/kernel/fpu/xstate.c
index edacd34..27417b6 100644
--- a/arch/x86/kernel/fpu/xstate.c
+++ b/arch/x86/kernel/fpu/xstate.c
@@ -233,7 +233,7 @@ static void __init setup_xstate_cache(void)
 						       xmm_space);
 
 	for_each_extended_xfeature(i, fpu_kernel_cfg.max_features) {
-		cpuid_count(XSTATE_CPUID, i, &eax, &ebx, &ecx, &edx);
+		cpuid_count(CPUID_LEAF_XSTATE, i, &eax, &ebx, &ecx, &edx);
 
 		xstate_sizes[i] = eax;
 		xstate_flags[i] = ecx;
@@ -399,7 +399,7 @@ int xfeature_size(int xfeature_nr)
 	u32 eax, ebx, ecx, edx;
 
 	CHECK_XFEATURE(xfeature_nr);
-	cpuid_count(XSTATE_CPUID, xfeature_nr, &eax, &ebx, &ecx, &edx);
+	cpuid_count(CPUID_LEAF_XSTATE, xfeature_nr, &eax, &ebx, &ecx, &edx);
 	return eax;
 }
 
@@ -442,9 +442,9 @@ static void __init __xstate_dump_leaves(void)
 	 * just in case there are some goodies up there
 	 */
 	for (i = 0; i < XFEATURE_MAX + 10; i++) {
-		cpuid_count(XSTATE_CPUID, i, &eax, &ebx, &ecx, &edx);
+		cpuid_count(CPUID_LEAF_XSTATE, i, &eax, &ebx, &ecx, &edx);
 		pr_warn("CPUID[%02x, %02x]: eax=%08x ebx=%08x ecx=%08x edx=%08x\n",
-			XSTATE_CPUID, i, eax, ebx, ecx, edx);
+			CPUID_LEAF_XSTATE, i, eax, ebx, ecx, edx);
 	}
 }
 
@@ -485,7 +485,7 @@ static int __init check_xtile_data_against_struct(int size)
 	 * Check the maximum palette id:
 	 *   eax: the highest numbered palette subleaf.
 	 */
-	cpuid_count(TILE_CPUID, 0, &max_palid, &ebx, &ecx, &edx);
+	cpuid_count(CPUID_LEAF_TILE, 0, &max_palid, &ebx, &ecx, &edx);
 
 	/*
 	 * Cross-check each tile size and find the maximum number of
@@ -499,7 +499,7 @@ static int __init check_xtile_data_against_struct(int size)
 		 *   eax[31:16]:  bytes per title
 		 *   ebx[31:16]:  the max names (or max number of tiles)
 		 */
-		cpuid_count(TILE_CPUID, palid, &eax, &ebx, &edx, &edx);
+		cpuid_count(CPUID_LEAF_TILE, palid, &eax, &ebx, &edx, &edx);
 		tile_size = eax >> 16;
 		max = ebx >> 16;
 
@@ -634,7 +634,7 @@ static unsigned int __init get_compacted_size(void)
 	 * are no supervisor states, but XSAVEC still uses compacted
 	 * format.
 	 */
-	cpuid_count(XSTATE_CPUID, 1, &eax, &ebx, &ecx, &edx);
+	cpuid_count(CPUID_LEAF_XSTATE, 1, &eax, &ebx, &ecx, &edx);
 	return ebx;
 }
 
@@ -675,7 +675,7 @@ static unsigned int __init get_xsave_size_user(void)
 	 *    containing all the *user* state components
 	 *    corresponding to bits currently set in XCR0.
 	 */
-	cpuid_count(XSTATE_CPUID, 0, &eax, &ebx, &ecx, &edx);
+	cpuid_count(CPUID_LEAF_XSTATE, 0, &eax, &ebx, &ecx, &edx);
 	return ebx;
 }
 
@@ -767,13 +767,13 @@ void __init fpu__init_system_xstate(unsigned int legacy_size)
 	/*
 	 * Find user xstates supported by the processor.
 	 */
-	cpuid_count(XSTATE_CPUID, 0, &eax, &ebx, &ecx, &edx);
+	cpuid_count(CPUID_LEAF_XSTATE, 0, &eax, &ebx, &ecx, &edx);
 	fpu_kernel_cfg.max_features = eax + ((u64)edx << 32);
 
 	/*
 	 * Find supervisor xstates supported by the processor.
 	 */
-	cpuid_count(XSTATE_CPUID, 1, &eax, &ebx, &ecx, &edx);
+	cpuid_count(CPUID_LEAF_XSTATE, 1, &eax, &ebx, &ecx, &edx);
 	fpu_kernel_cfg.max_features |= ecx + ((u64)edx << 32);
 
 	if ((fpu_kernel_cfg.max_features & XFEATURE_MASK_FPSSE) != XFEATURE_MASK_FPSSE) {
diff --git a/arch/x86/kernel/hpet.c b/arch/x86/kernel/hpet.c
index 953de5b..2b1a62b 100644
--- a/arch/x86/kernel/hpet.c
+++ b/arch/x86/kernel/hpet.c
@@ -928,7 +928,7 @@ static bool __init mwait_pc10_supported(void)
 	if (!cpu_feature_enabled(X86_FEATURE_MWAIT))
 		return false;
 
-	cpuid(CPUID_MWAIT_LEAF, &eax, &ebx, &ecx, &mwait_substates);
+	cpuid(CPUID_LEAF_MWAIT, &eax, &ebx, &ecx, &mwait_substates);
 
 	return (ecx & CPUID5_ECX_EXTENSIONS_SUPPORTED) &&
 	       (ecx & CPUID5_ECX_INTERRUPT_BREAK) &&
diff --git a/arch/x86/kernel/process.c b/arch/x86/kernel/process.c
index d40fc49..69f7867 100644
--- a/arch/x86/kernel/process.c
+++ b/arch/x86/kernel/process.c
@@ -878,7 +878,7 @@ static __init bool prefer_mwait_c1_over_halt(void)
 	if (boot_cpu_has_bug(X86_BUG_MONITOR) || boot_cpu_has_bug(X86_BUG_AMD_APIC_C1E))
 		return false;
 
-	cpuid(CPUID_MWAIT_LEAF, &eax, &ebx, &ecx, &edx);
+	cpuid(CPUID_LEAF_MWAIT, &eax, &ebx, &ecx, &edx);
 
 	/*
 	 * If MWAIT extensions are not available, it is safe to use MWAIT
diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
index 116c46f..0e3f9ba 100644
--- a/arch/x86/kernel/smpboot.c
+++ b/arch/x86/kernel/smpboot.c
@@ -1293,7 +1293,7 @@ static inline void mwait_play_dead(void)
 	if (!this_cpu_has(X86_FEATURE_CLFLUSH))
 		return;
 
-	eax = CPUID_MWAIT_LEAF;
+	eax = CPUID_LEAF_MWAIT;
 	ecx = 0;
 	native_cpuid(&eax, &ebx, &ecx, &edx);
 
diff --git a/arch/x86/kernel/tsc.c b/arch/x86/kernel/tsc.c
index 678c36f..a855946 100644
--- a/arch/x86/kernel/tsc.c
+++ b/arch/x86/kernel/tsc.c
@@ -666,13 +666,13 @@ unsigned long native_calibrate_tsc(void)
 	if (boot_cpu_data.x86_vendor != X86_VENDOR_INTEL)
 		return 0;
 
-	if (boot_cpu_data.cpuid_level < CPUID_TSC_LEAF)
+	if (boot_cpu_data.cpuid_level < CPUID_LEAF_TSC)
 		return 0;
 
 	eax_denominator = ebx_numerator = ecx_hz = edx = 0;
 
 	/* CPUID 15H TSC/Crystal ratio, plus optionally Crystal Hz */
-	cpuid(CPUID_TSC_LEAF, &eax_denominator, &ebx_numerator, &ecx_hz, &edx);
+	cpuid(CPUID_LEAF_TSC, &eax_denominator, &ebx_numerator, &ecx_hz, &edx);
 
 	if (ebx_numerator == 0 || eax_denominator == 0)
 		return 0;
@@ -681,7 +681,7 @@ unsigned long native_calibrate_tsc(void)
 
 	/*
 	 * Denverton SoCs don't report crystal clock, and also don't support
-	 * CPUID_FREQ_LEAF for the calculation below, so hardcode the 25MHz
+	 * CPUID_LEAF_FREQ for the calculation below, so hardcode the 25MHz
 	 * crystal clock.
 	 */
 	if (crystal_khz == 0 &&
@@ -701,10 +701,10 @@ unsigned long native_calibrate_tsc(void)
 	 * clock, but we can easily calculate it to a high degree of accuracy
 	 * by considering the crystal ratio and the CPU speed.
 	 */
-	if (crystal_khz == 0 && boot_cpu_data.cpuid_level >= CPUID_FREQ_LEAF) {
+	if (crystal_khz == 0 && boot_cpu_data.cpuid_level >= CPUID_LEAF_FREQ) {
 		unsigned int eax_base_mhz, ebx, ecx, edx;
 
-		cpuid(CPUID_FREQ_LEAF, &eax_base_mhz, &ebx, &ecx, &edx);
+		cpuid(CPUID_LEAF_FREQ, &eax_base_mhz, &ebx, &ecx, &edx);
 		crystal_khz = eax_base_mhz * 1000 *
 			eax_denominator / ebx_numerator;
 	}
@@ -739,12 +739,12 @@ static unsigned long cpu_khz_from_cpuid(void)
 	if (boot_cpu_data.x86_vendor != X86_VENDOR_INTEL)
 		return 0;
 
-	if (boot_cpu_data.cpuid_level < CPUID_FREQ_LEAF)
+	if (boot_cpu_data.cpuid_level < CPUID_LEAF_FREQ)
 		return 0;
 
 	eax_base_mhz = ebx_max_mhz = ecx_bus_mhz = edx = 0;
 
-	cpuid(CPUID_FREQ_LEAF, &eax_base_mhz, &ebx_max_mhz, &ecx_bus_mhz, &edx);
+	cpuid(CPUID_LEAF_FREQ, &eax_base_mhz, &ebx_max_mhz, &ecx_bus_mhz, &edx);
 
 	return eax_base_mhz * 1000;
 }
@@ -1077,7 +1077,7 @@ static void __init detect_art(void)
 {
 	unsigned int unused;
 
-	if (boot_cpu_data.cpuid_level < CPUID_TSC_LEAF)
+	if (boot_cpu_data.cpuid_level < CPUID_LEAF_TSC)
 		return;
 
 	/*
@@ -1090,7 +1090,7 @@ static void __init detect_art(void)
 	    tsc_async_resets)
 		return;
 
-	cpuid(CPUID_TSC_LEAF, &art_base_clk.denominator,
+	cpuid(CPUID_LEAF_TSC, &art_base_clk.denominator,
 	      &art_base_clk.numerator, &art_base_clk.freq_khz, &unused);
 
 	art_base_clk.freq_khz /= KHZ;
diff --git a/arch/x86/xen/enlighten_pv.c b/arch/x86/xen/enlighten_pv.c
index b355070..55727d5 100644
--- a/arch/x86/xen/enlighten_pv.c
+++ b/arch/x86/xen/enlighten_pv.c
@@ -231,7 +231,7 @@ static void xen_cpuid(unsigned int *ax, unsigned int *bx,
 		or_ebx = smp_processor_id() << 24;
 		break;
 
-	case CPUID_MWAIT_LEAF:
+	case CPUID_LEAF_MWAIT:
 		/* Synthesize the values.. */
 		*ax = 0;
 		*bx = 0;
@@ -301,7 +301,7 @@ static bool __init xen_check_mwait(void)
 	 * ecx and edx. The hypercall provides only partial information.
 	 */
 
-	ax = CPUID_MWAIT_LEAF;
+	ax = CPUID_LEAF_MWAIT;
 	bx = 0;
 	cx = 0;
 	dx = 0;
diff --git a/drivers/acpi/acpi_pad.c b/drivers/acpi/acpi_pad.c
index f3cffae..3fde449 100644
--- a/drivers/acpi/acpi_pad.c
+++ b/drivers/acpi/acpi_pad.c
@@ -48,7 +48,7 @@ static void power_saving_mwait_init(void)
 	if (!boot_cpu_has(X86_FEATURE_MWAIT))
 		return;
 
-	cpuid(CPUID_MWAIT_LEAF, &eax, &ebx, &ecx, &edx);
+	cpuid(CPUID_LEAF_MWAIT, &eax, &ebx, &ecx, &edx);
 
 	if (!(ecx & CPUID5_ECX_EXTENSIONS_SUPPORTED) ||
 	    !(ecx & CPUID5_ECX_INTERRUPT_BREAK))
diff --git a/drivers/dma/ioat/dca.c b/drivers/dma/ioat/dca.c
index 658ea2e..c9aba23 100644
--- a/drivers/dma/ioat/dca.c
+++ b/drivers/dma/ioat/dca.c
@@ -63,7 +63,7 @@ static int dca_enabled_in_bios(struct pci_dev *pdev)
 	u32 eax;
 	int res;
 
-	eax = cpuid_eax(CPUID_DCA_LEAF);
+	eax = cpuid_eax(CPUID_LEAF_DCA);
 	res = eax & BIT(0);
 	if (!res)
 		dev_dbg(&pdev->dev, "DCA is disabled in BIOS\n");
diff --git a/drivers/idle/intel_idle.c b/drivers/idle/intel_idle.c
index efa32d2..239ce0d 100644
--- a/drivers/idle/intel_idle.c
+++ b/drivers/idle/intel_idle.c
@@ -2317,7 +2317,7 @@ static int __init intel_idle_init(void)
 			return -ENODEV;
 	}
 
-	cpuid(CPUID_MWAIT_LEAF, &eax, &ebx, &ecx, &mwait_substates);
+	cpuid(CPUID_LEAF_MWAIT, &eax, &ebx, &ecx, &mwait_substates);
 
 	if (!(ecx & CPUID5_ECX_EXTENSIONS_SUPPORTED) ||
 	    !(ecx & CPUID5_ECX_INTERRUPT_BREAK) ||
diff --git a/drivers/platform/x86/intel/pmc/core.c b/drivers/platform/x86/intel/pmc/core.c
index ac8231e..10f04b9 100644
--- a/drivers/platform/x86/intel/pmc/core.c
+++ b/drivers/platform/x86/intel/pmc/core.c
@@ -936,13 +936,13 @@ static unsigned int pmc_core_get_crystal_freq(void)
 {
 	unsigned int eax_denominator, ebx_numerator, ecx_hz, edx;
 
-	if (boot_cpu_data.cpuid_level < CPUID_TSC_LEAF)
+	if (boot_cpu_data.cpuid_level < CPUID_LEAF_TSC)
 		return 0;
 
 	eax_denominator = ebx_numerator = ecx_hz = edx = 0;
 
 	/* TSC/Crystal ratio, plus optionally Crystal Hz */
-	cpuid(CPUID_TSC_LEAF, &eax_denominator, &ebx_numerator, &ecx_hz, &edx);
+	cpuid(CPUID_LEAF_TSC, &eax_denominator, &ebx_numerator, &ecx_hz, &edx);
 
 	if (ebx_numerator == 0 || eax_denominator == 0)
 		return 0;

