Return-Path: <linux-tip-commits+bounces-1602-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D784A928E75
	for <lists+linux-tip-commits@lfdr.de>; Fri,  5 Jul 2024 23:06:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8C25D283AF5
	for <lists+linux-tip-commits@lfdr.de>; Fri,  5 Jul 2024 21:06:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2A951459FB;
	Fri,  5 Jul 2024 21:06:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="FknRAD3r";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Wpcoqd6X"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE38513CFA4;
	Fri,  5 Jul 2024 21:06:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720213604; cv=none; b=r0CI/E0edxblPRBroDytJJXv/EfUcd6yx+Z//rzBccRP7YRBvmX4w3hZPknOyorBWoFWivUWCRbSCePS9L+RtJq4CaXcUO/TFmtULtiJ4IFyhzj3OFJckSSqCzRqbOiCchiej+ew0YPuFTxj3coDh4NhUD2ryuoK3FYrNS47Fvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720213604; c=relaxed/simple;
	bh=Dtztcx+ycPUaysyOWxeeIkcLWotFd/gNfsVcwNLPpxU=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=EccIdZSMnJFqiFCXirUmEe63+601NHXjzCUEYGXBlO7EEJOfaJkLfZxqDkAbCD0Z2/u8RUt/YxXP0dkc2O4QfF9JnBl4GaKzmu0NbuGN9wttjFV/lymNVdyESQyRJlSizDrUtZ+8XPMDdzFNnkI4NCnSWGdtstntxvCjBEn1X0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=FknRAD3r; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Wpcoqd6X; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 05 Jul 2024 21:06:40 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1720213601;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=q66Hic+8Ai5Z8uo4SVWEwHUtFKiuCMfPnvEtBAcaRkU=;
	b=FknRAD3rID5PuDZdMJtmkBRp9H4br0XR+/AIdZnD6Rujk+XHxqT5i3PMzIf9zu19gXedQ5
	LMlyWkiB7a0obVyj1iyKafjPwTMo74o5bY0h7HEEpvumTufaFreJYInqJruP6Izy+K8TlO
	ILLcsCFyNwbC1dpNhfqPsYmPx7Gvpz9PBPrsMpfRwkhJ5VHqvbyTo3ETmhfQcks8TpMsJv
	LRVB7r4DkKC5tb5f28yXxt/Xy80oRFOpOaK1matXKg8oFm/dSovdr/uz9U2r3eBWy4Erom
	rNYMvAWyprRq86Efsygl1GP3wYhr2l6Ontl3/EghSg4ytfQlSq390r+PJ4MWrQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1720213601;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=q66Hic+8Ai5Z8uo4SVWEwHUtFKiuCMfPnvEtBAcaRkU=;
	b=Wpcoqd6XDKX0h5k1l5R24T2AoUZ3aU4klbrZKrbziB44KXCUoq4xu1TnXPRHMKEH3ih/yY
	e7EqSqhdARjLqUCA==
From: "tip-bot2 for Kan Liang" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf/x86/intel: Support Perfmon MSRs aliasing
Cc: Kan Liang <kan.liang@linux.intel.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Andi Kleen <ak@linux.intel.com>, Ian Rogers <irogers@google.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240626143545.480761-9-kan.liang@linux.intel.com>
References: <20240626143545.480761-9-kan.liang@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172021360097.2215.11582526253219817356.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     149fd4712bcd492a031945f92e5ce19879f62311
Gitweb:        https://git.kernel.org/tip/149fd4712bcd492a031945f92e5ce19879f62311
Author:        Kan Liang <kan.liang@linux.intel.com>
AuthorDate:    Wed, 26 Jun 2024 07:35:40 -07:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Thu, 04 Jul 2024 16:00:40 +02:00

perf/x86/intel: Support Perfmon MSRs aliasing

The architectural performance monitoring V6 supports a new range of
counters' MSRs in the 19xxH address range. They include all the GP
counter MSRs, the GP control MSRs, and the fixed counter MSRs.

The step between each sibling counter is 4. Add intel_pmu_addr_offset()
to calculate the correct offset.

Add fixedctr in struct x86_pmu to store the address of the fixed counter
0. It can be used to calculate the rest of the fixed counters.

The MSR address of the fixed counter control is not changed.

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Andi Kleen <ak@linux.intel.com>
Reviewed-by: Ian Rogers <irogers@google.com>
Link: https://lkml.kernel.org/r/20240626143545.480761-9-kan.liang@linux.intel.com
---
 arch/x86/events/core.c           |  7 +++----
 arch/x86/events/intel/core.c     | 17 ++++++++++++++++-
 arch/x86/events/perf_event.h     |  7 +++++++
 arch/x86/include/asm/msr-index.h |  6 ++++++
 4 files changed, 32 insertions(+), 5 deletions(-)

diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
index 8ea1c98..975b0f8 100644
--- a/arch/x86/events/core.c
+++ b/arch/x86/events/core.c
@@ -1236,8 +1236,7 @@ static inline void x86_assign_hw_event(struct perf_event *event,
 		fallthrough;
 	case INTEL_PMC_IDX_FIXED ... INTEL_PMC_IDX_FIXED_BTS-1:
 		hwc->config_base = MSR_ARCH_PERFMON_FIXED_CTR_CTRL;
-		hwc->event_base = MSR_ARCH_PERFMON_FIXED_CTR0 +
-				(idx - INTEL_PMC_IDX_FIXED);
+		hwc->event_base = x86_pmu_fixed_ctr_addr(idx - INTEL_PMC_IDX_FIXED);
 		hwc->event_base_rdpmc = (idx - INTEL_PMC_IDX_FIXED) |
 					INTEL_PMC_FIXED_RDPMC_BASE;
 		break;
@@ -1573,7 +1572,7 @@ void perf_event_print_debug(void)
 	for_each_set_bit(idx, fixed_cntr_mask, X86_PMC_IDX_MAX) {
 		if (fixed_counter_disabled(idx, cpuc->pmu))
 			continue;
-		rdmsrl(MSR_ARCH_PERFMON_FIXED_CTR0 + idx, pmc_count);
+		rdmsrl(x86_pmu_fixed_ctr_addr(idx), pmc_count);
 
 		pr_info("CPU#%d: fixed-PMC%d count: %016llx\n",
 			cpu, idx, pmc_count);
@@ -2483,7 +2482,7 @@ void perf_clear_dirty_counters(void)
 			if (!test_bit(i - INTEL_PMC_IDX_FIXED, hybrid(cpuc->pmu, fixed_cntr_mask)))
 				continue;
 
-			wrmsrl(MSR_ARCH_PERFMON_FIXED_CTR0 + (i - INTEL_PMC_IDX_FIXED), 0);
+			wrmsrl(x86_pmu_fixed_ctr_addr(i - INTEL_PMC_IDX_FIXED), 0);
 		} else {
 			wrmsrl(x86_pmu_event_addr(i), 0);
 		}
diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index fa0550e..cd8f2db 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -2953,7 +2953,7 @@ static void intel_pmu_reset(void)
 	for_each_set_bit(idx, fixed_cntr_mask, INTEL_PMC_MAX_FIXED) {
 		if (fixed_counter_disabled(idx, cpuc->pmu))
 			continue;
-		wrmsrl_safe(MSR_ARCH_PERFMON_FIXED_CTR0 + idx, 0ull);
+		wrmsrl_safe(x86_pmu_fixed_ctr_addr(idx), 0ull);
 	}
 
 	if (ds)
@@ -5188,6 +5188,7 @@ static __initconst const struct x86_pmu core_pmu = {
 	.schedule_events	= x86_schedule_events,
 	.eventsel		= MSR_ARCH_PERFMON_EVENTSEL0,
 	.perfctr		= MSR_ARCH_PERFMON_PERFCTR0,
+	.fixedctr		= MSR_ARCH_PERFMON_FIXED_CTR0,
 	.event_map		= intel_pmu_event_map,
 	.max_events		= ARRAY_SIZE(intel_perfmon_event_map),
 	.apic			= 1,
@@ -5241,6 +5242,7 @@ static __initconst const struct x86_pmu intel_pmu = {
 	.schedule_events	= x86_schedule_events,
 	.eventsel		= MSR_ARCH_PERFMON_EVENTSEL0,
 	.perfctr		= MSR_ARCH_PERFMON_PERFCTR0,
+	.fixedctr		= MSR_ARCH_PERFMON_FIXED_CTR0,
 	.event_map		= intel_pmu_event_map,
 	.max_events		= ARRAY_SIZE(intel_perfmon_event_map),
 	.apic			= 1,
@@ -6176,6 +6178,11 @@ static void intel_pmu_check_extra_regs(struct extra_reg *extra_regs)
 	}
 }
 
+static inline int intel_pmu_v6_addr_offset(int index, bool eventsel)
+{
+	return MSR_IA32_PMC_V6_STEP * index;
+}
+
 static const struct { enum hybrid_pmu_type id; char *name; } intel_hybrid_pmu_type_map[] __initconst = {
 	{ hybrid_small, "cpu_atom" },
 	{ hybrid_big, "cpu_core" },
@@ -7150,6 +7157,14 @@ __init int intel_pmu_init(void)
 		pr_cont("full-width counters, ");
 	}
 
+	/* Support V6+ MSR Aliasing */
+	if (x86_pmu.version >= 6) {
+		x86_pmu.perfctr = MSR_IA32_PMC_V6_GP0_CTR;
+		x86_pmu.eventsel = MSR_IA32_PMC_V6_GP0_CFG_A;
+		x86_pmu.fixedctr = MSR_IA32_PMC_V6_FX0_CTR;
+		x86_pmu.addr_offset = intel_pmu_v6_addr_offset;
+	}
+
 	if (!is_hybrid() && x86_pmu.intel_cap.perf_metrics)
 		x86_pmu.intel_ctrl |= 1ULL << GLOBAL_CTRL_EN_PERF_METRICS;
 
diff --git a/arch/x86/events/perf_event.h b/arch/x86/events/perf_event.h
index 55468ea..ac11821 100644
--- a/arch/x86/events/perf_event.h
+++ b/arch/x86/events/perf_event.h
@@ -787,6 +787,7 @@ struct x86_pmu {
 	int		(*schedule_events)(struct cpu_hw_events *cpuc, int n, int *assign);
 	unsigned	eventsel;
 	unsigned	perfctr;
+	unsigned	fixedctr;
 	int		(*addr_offset)(int index, bool eventsel);
 	int		(*rdpmc_index)(int index);
 	u64		(*event_map)(int);
@@ -1144,6 +1145,12 @@ static inline unsigned int x86_pmu_event_addr(int index)
 				  x86_pmu.addr_offset(index, false) : index);
 }
 
+static inline unsigned int x86_pmu_fixed_ctr_addr(int index)
+{
+	return x86_pmu.fixedctr + (x86_pmu.addr_offset ?
+				   x86_pmu.addr_offset(index, false) : index);
+}
+
 static inline int x86_pmu_rdpmc_index(int index)
 {
 	return x86_pmu.rdpmc_index ? x86_pmu.rdpmc_index(index) : index;
diff --git a/arch/x86/include/asm/msr-index.h b/arch/x86/include/asm/msr-index.h
index e022e6e..048081b 100644
--- a/arch/x86/include/asm/msr-index.h
+++ b/arch/x86/include/asm/msr-index.h
@@ -566,6 +566,12 @@
 #define MSR_RELOAD_PMC0			0x000014c1
 #define MSR_RELOAD_FIXED_CTR0		0x00001309
 
+/* V6 PMON MSR range */
+#define MSR_IA32_PMC_V6_GP0_CTR		0x1900
+#define MSR_IA32_PMC_V6_GP0_CFG_A	0x1901
+#define MSR_IA32_PMC_V6_FX0_CTR		0x1980
+#define MSR_IA32_PMC_V6_STEP		4
+
 /* KeyID partitioning between MKTME and TDX */
 #define MSR_IA32_MKTME_KEYID_PARTITIONING	0x00000087
 

