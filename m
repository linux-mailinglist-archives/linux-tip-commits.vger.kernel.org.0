Return-Path: <linux-tip-commits+bounces-5035-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 02760A91D28
	for <lists+linux-tip-commits@lfdr.de>; Thu, 17 Apr 2025 15:02:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 40E5C7A793C
	for <lists+linux-tip-commits@lfdr.de>; Thu, 17 Apr 2025 13:00:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2B082475C7;
	Thu, 17 Apr 2025 13:01:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ugy7r2P4";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="AyYBl9tR"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D60BC2459C2;
	Thu, 17 Apr 2025 13:01:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744894894; cv=none; b=tanlk5PurJoy5AZqTUGC8LSguWf+0Cj9KqFKm67/6PXx85UKrOTykt/4vCQ9w+87GQRu9CmGiklhmefEIUxonIZBCpxpRJsujaCABFBcew4bT5ZvhPjuG3ngb4LslXZFOgqOuWAPLRukFit8/jJJCVTtCcXGuywHkjtuSoh0syA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744894894; c=relaxed/simple;
	bh=soQKnuibtT0YBCmxTyyPg/h2V2dSSXQyDztttX0mmBU=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=r5jYn55k95f5hyqqIXtUN9yE0iHHdm8G27Qp9bCV18YmL3riC7VuR40ARBxYCL3bGncQMkvlMsGw+FL/Hweu8L5SCgHSb+knDkhdpLtjlZ0YnCpNqNVk6F94MpIECCF/vEAOmaOC/KMckdGTas+nO4vTg/bPShlx8IDgp/ykZvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ugy7r2P4; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=AyYBl9tR; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 17 Apr 2025 13:01:29 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1744894891;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7QeU7mLqFEW6fh+4xOFZZsKtCM97G6i61GPfpNcijDE=;
	b=ugy7r2P4LevVooC5ZjGr+RvdqUiZgPZTaw7ZguuLrDHXCIAW6M0hpIl+S79FWb+zp8qFoc
	+IQbVQiIZ37PbWDqS/XTX+LcvZ7wiBwvhhWrLqbEGvtr124fpl5+EoWj5tCsQ2dfJs8ebr
	6PJm/sbr+JgsKCRdNfmKw5Xv5jzgB2MIQJNGTdMPSmKZxf4lqgVcSvgoliAQCV+HQqDHVz
	+BfhYafodYaSr2dGfEOjLUp32e0qKwzNVuJbJvh1anM2XboLA4aqoh9Bb22XWu9pMWOVTS
	ynC5AbXX/bM5QgZ7nFKGS8RzzreAuTpPl5y0tZ2Sezae9vIY5nIgFlfTJmZBhA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1744894891;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7QeU7mLqFEW6fh+4xOFZZsKtCM97G6i61GPfpNcijDE=;
	b=AyYBl9tRYH9D6ZZxzxea4pFBlks9kKUCt7Rl8bxIWykwKnFLZO3Pw+b0tP9EIhWfx6inVl
	gORbDVoE1hgKEnCA==
From: "tip-bot2 for Dapeng Mi" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf/x86/intel: Parse CPUID archPerfmonExt leaves
 for non-hybrid CPUs
Cc: Dapeng Mi <dapeng1.mi@linux.intel.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Ingo Molnar <mingo@kernel.org>, x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250415114428.341182-4-dapeng1.mi@linux.intel.com>
References: <20250415114428.341182-4-dapeng1.mi@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174489488984.31282.10181504787805707986.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     25c623f41438fafc6f63c45e2e141d7bcff78299
Gitweb:        https://git.kernel.org/tip/25c623f41438fafc6f63c45e2e141d7bcff78299
Author:        Dapeng Mi <dapeng1.mi@linux.intel.com>
AuthorDate:    Tue, 15 Apr 2025 11:44:09 
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Thu, 17 Apr 2025 14:21:24 +02:00

perf/x86/intel: Parse CPUID archPerfmonExt leaves for non-hybrid CPUs

CPUID archPerfmonExt (0x23) leaves are supported to enumerate CPU
level's PMU capabilities on non-hybrid processors as well.

This patch supports to parse archPerfmonExt leaves on non-hybrid
processors. Architectural PEBS leverages archPerfmonExt sub-leaves 0x4
and 0x5 to enumerate the PEBS capabilities as well. This patch is a
precursor of the subsequent arch-PEBS enabling patches.

Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lkml.kernel.org/r/20250415114428.341182-4-dapeng1.mi@linux.intel.com
---
 arch/x86/events/intel/core.c | 31 ++++++++++++++++++++++---------
 1 file changed, 22 insertions(+), 9 deletions(-)

diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index adc0187..c7937b8 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -5271,7 +5271,7 @@ static inline bool intel_pmu_broken_perf_cap(void)
 	return false;
 }
 
-static void update_pmu_cap(struct x86_hybrid_pmu *pmu)
+static void update_pmu_cap(struct pmu *pmu)
 {
 	unsigned int cntr, fixed_cntr, ecx, edx;
 	union cpuid35_eax eax;
@@ -5280,30 +5280,30 @@ static void update_pmu_cap(struct x86_hybrid_pmu *pmu)
 	cpuid(ARCH_PERFMON_EXT_LEAF, &eax.full, &ebx.full, &ecx, &edx);
 
 	if (ebx.split.umask2)
-		pmu->config_mask |= ARCH_PERFMON_EVENTSEL_UMASK2;
+		hybrid(pmu, config_mask) |= ARCH_PERFMON_EVENTSEL_UMASK2;
 	if (ebx.split.eq)
-		pmu->config_mask |= ARCH_PERFMON_EVENTSEL_EQ;
+		hybrid(pmu, config_mask) |= ARCH_PERFMON_EVENTSEL_EQ;
 
 	if (eax.split.cntr_subleaf) {
 		cpuid_count(ARCH_PERFMON_EXT_LEAF, ARCH_PERFMON_NUM_COUNTER_LEAF,
 			    &cntr, &fixed_cntr, &ecx, &edx);
-		pmu->cntr_mask64 = cntr;
-		pmu->fixed_cntr_mask64 = fixed_cntr;
+		hybrid(pmu, cntr_mask64) = cntr;
+		hybrid(pmu, fixed_cntr_mask64) = fixed_cntr;
 	}
 
 	if (eax.split.acr_subleaf) {
 		cpuid_count(ARCH_PERFMON_EXT_LEAF, ARCH_PERFMON_ACR_LEAF,
 			    &cntr, &fixed_cntr, &ecx, &edx);
 		/* The mask of the counters which can be reloaded */
-		pmu->acr_cntr_mask64 = cntr | ((u64)fixed_cntr << INTEL_PMC_IDX_FIXED);
+		hybrid(pmu, acr_cntr_mask64) = cntr | ((u64)fixed_cntr << INTEL_PMC_IDX_FIXED);
 
 		/* The mask of the counters which can cause a reload of reloadable counters */
-		pmu->acr_cause_mask64 = ecx | ((u64)edx << INTEL_PMC_IDX_FIXED);
+		hybrid(pmu, acr_cause_mask64) = ecx | ((u64)edx << INTEL_PMC_IDX_FIXED);
 	}
 
 	if (!intel_pmu_broken_perf_cap()) {
 		/* Perf Metric (Bit 15) and PEBS via PT (Bit 16) are hybrid enumeration */
-		rdmsrl(MSR_IA32_PERF_CAPABILITIES, pmu->intel_cap.capabilities);
+		rdmsrl(MSR_IA32_PERF_CAPABILITIES, hybrid(pmu, intel_cap).capabilities);
 	}
 }
 
@@ -5390,7 +5390,7 @@ static bool init_hybrid_pmu(int cpu)
 		goto end;
 
 	if (this_cpu_has(X86_FEATURE_ARCH_PERFMON_EXT))
-		update_pmu_cap(pmu);
+		update_pmu_cap(&pmu->pmu);
 
 	intel_pmu_check_hybrid_pmus(pmu);
 
@@ -6899,6 +6899,7 @@ __init int intel_pmu_init(void)
 
 	x86_pmu.pebs_events_mask	= intel_pmu_pebs_mask(x86_pmu.cntr_mask64);
 	x86_pmu.pebs_capable		= PEBS_COUNTER_MASK;
+	x86_pmu.config_mask		= X86_RAW_EVENT_MASK;
 
 	/*
 	 * Quirk: v2 perfmon does not report fixed-purpose events, so
@@ -7715,6 +7716,18 @@ __init int intel_pmu_init(void)
 		x86_pmu.attr_update = hybrid_attr_update;
 	}
 
+	/*
+	 * The archPerfmonExt (0x23) includes an enhanced enumeration of
+	 * PMU architectural features with a per-core view. For non-hybrid,
+	 * each core has the same PMU capabilities. It's good enough to
+	 * update the x86_pmu from the booting CPU. For hybrid, the x86_pmu
+	 * is used to keep the common capabilities. Still keep the values
+	 * from the leaf 0xa. The core specific update will be done later
+	 * when a new type is online.
+	 */
+	if (!is_hybrid() && boot_cpu_has(X86_FEATURE_ARCH_PERFMON_EXT))
+		update_pmu_cap(NULL);
+
 	intel_pmu_check_counters_mask(&x86_pmu.cntr_mask64,
 				      &x86_pmu.fixed_cntr_mask64,
 				      &x86_pmu.intel_ctrl);

