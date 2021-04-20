Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2079B36568B
	for <lists+linux-tip-commits@lfdr.de>; Tue, 20 Apr 2021 12:46:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231741AbhDTKrS (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Tue, 20 Apr 2021 06:47:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231621AbhDTKrP (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Tue, 20 Apr 2021 06:47:15 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66006C06138A;
        Tue, 20 Apr 2021 03:46:44 -0700 (PDT)
Date:   Tue, 20 Apr 2021 10:46:42 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1618915603;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=oSoaBrI4oE3BmL96TIfH+Y7oRtvpKv08vJHch3dS4IU=;
        b=MFEii4J17hJl3c5KJ2AvH8DC1IjsoGnTY/Wj8z9rzKKwfrHGiho+LeMMyv6jQ6XQT5j7Qm
        Oa6m7Jto29sU32s2CwMVrF3B/e7IboGzurDH6x1+2u0HIwCPUfwYAqrZIQI/340T+x74aw
        ZG6rA9Q8uphr5rMcN7CxtV4WWcSJyRudyo5UW6e3b1lt67CCcuJdI8v7M2Bx1eujcI2zkS
        kw+XD+l1UJVc1wJbWX/sSDDldYSEZbNhiCF2R8cfssarcmNOR7kYDFV9AGCbHHo6r4pgJC
        mxGY0QNd3Ou46EMv7JTpccBcl9UH6BuRWZrvB25XM0OsVP/2XueQhpg9m7JCuw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1618915603;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=oSoaBrI4oE3BmL96TIfH+Y7oRtvpKv08vJHch3dS4IU=;
        b=Yl8HZt+2DvFqjcZoQ26v7vqXX3iKYWWD/kXvqA7PldwJUQHnuJ3ivO7KInO46+cNSaTHNr
        xTyFm6Rfuo4Z/1Bg==
From:   "tip-bot2 for Kan Liang" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf/x86/intel: Add Alder Lake Hybrid support
Cc:     Kan Liang <kan.liang@linux.intel.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Andi Kleen <ak@linux.intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <1618237865-33448-21-git-send-email-kan.liang@linux.intel.com>
References: <1618237865-33448-21-git-send-email-kan.liang@linux.intel.com>
MIME-Version: 1.0
Message-ID: <161891560244.29796.17420073506111340855.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     f83d2f91d2590318e083d05bd7b1beda2489050e
Gitweb:        https://git.kernel.org/tip/f83d2f91d2590318e083d05bd7b1beda2489050e
Author:        Kan Liang <kan.liang@linux.intel.com>
AuthorDate:    Mon, 12 Apr 2021 07:31:00 -07:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 19 Apr 2021 20:03:28 +02:00

perf/x86/intel: Add Alder Lake Hybrid support

Alder Lake Hybrid system has two different types of core, Golden Cove
core and Gracemont core. The Golden Cove core is registered to
"cpu_core" PMU. The Gracemont core is registered to "cpu_atom" PMU.

The difference between the two PMUs include:
- Number of GP and fixed counters
- Events
- The "cpu_core" PMU supports Topdown metrics.
  The "cpu_atom" PMU supports PEBS-via-PT.

The "cpu_core" PMU is similar to the Sapphire Rapids PMU, but without
PMEM.
The "cpu_atom" PMU is similar to Tremont, but with different events,
event_constraints, extra_regs and number of counters.

The mem-loads AUX event workaround only applies to the Golden Cove core.

Users may disable all CPUs of the same CPU type on the command line or
in the BIOS. For this case, perf still register a PMU for the CPU type
but the CPU mask is 0.

Current caps/pmu_name is usually the microarch codename. Assign the
"alderlake_hybrid" to the caps/pmu_name of both PMUs to indicate the
hybrid Alder Lake microarchitecture.

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Andi Kleen <ak@linux.intel.com>
Link: https://lkml.kernel.org/r/1618237865-33448-21-git-send-email-kan.liang@linux.intel.com
---
 arch/x86/events/intel/core.c | 255 +++++++++++++++++++++++++++++++++-
 arch/x86/events/intel/ds.c   |   7 +-
 arch/x86/events/perf_event.h |   7 +-
 3 files changed, 268 insertions(+), 1 deletion(-)

diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index ba24638..5272f34 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -2076,6 +2076,14 @@ static struct extra_reg intel_tnt_extra_regs[] __read_mostly = {
 	EVENT_EXTRA_END
 };
 
+static struct extra_reg intel_grt_extra_regs[] __read_mostly = {
+	/* must define OFFCORE_RSP_X first, see intel_fixup_er() */
+	INTEL_UEVENT_EXTRA_REG(0x01b7, MSR_OFFCORE_RSP_0, 0x3fffffffffull, RSP_0),
+	INTEL_UEVENT_EXTRA_REG(0x02b7, MSR_OFFCORE_RSP_1, 0x3fffffffffull, RSP_1),
+	INTEL_UEVENT_PEBS_LDLAT_EXTRA_REG(0x5d0),
+	EVENT_EXTRA_END
+};
+
 #define KNL_OT_L2_HITE		BIT_ULL(19) /* Other Tile L2 Hit */
 #define KNL_OT_L2_HITF		BIT_ULL(20) /* Other Tile L2 Hit */
 #define KNL_MCDRAM_LOCAL	BIT_ULL(21)
@@ -2430,6 +2438,16 @@ static int icl_set_topdown_event_period(struct perf_event *event)
 	return 0;
 }
 
+static int adl_set_topdown_event_period(struct perf_event *event)
+{
+	struct x86_hybrid_pmu *pmu = hybrid_pmu(event->pmu);
+
+	if (pmu->cpu_type != hybrid_big)
+		return 0;
+
+	return icl_set_topdown_event_period(event);
+}
+
 static inline u64 icl_get_metrics_event_value(u64 metric, u64 slots, int idx)
 {
 	u32 val;
@@ -2570,6 +2588,17 @@ static u64 icl_update_topdown_event(struct perf_event *event)
 						 x86_pmu.num_topdown_events - 1);
 }
 
+static u64 adl_update_topdown_event(struct perf_event *event)
+{
+	struct x86_hybrid_pmu *pmu = hybrid_pmu(event->pmu);
+
+	if (pmu->cpu_type != hybrid_big)
+		return 0;
+
+	return icl_update_topdown_event(event);
+}
+
+
 static void intel_pmu_read_topdown_event(struct perf_event *event)
 {
 	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
@@ -3655,6 +3684,17 @@ static inline bool is_mem_loads_aux_event(struct perf_event *event)
 	return (event->attr.config & INTEL_ARCH_EVENT_MASK) == X86_CONFIG(.event=0x03, .umask=0x82);
 }
 
+static inline bool require_mem_loads_aux_event(struct perf_event *event)
+{
+	if (!(x86_pmu.flags & PMU_FL_MEM_LOADS_AUX))
+		return false;
+
+	if (is_hybrid())
+		return hybrid_pmu(event->pmu)->cpu_type == hybrid_big;
+
+	return true;
+}
+
 static inline bool intel_pmu_has_cap(struct perf_event *event, int idx)
 {
 	union perf_capabilities *intel_cap = &hybrid(event->pmu, intel_cap);
@@ -3779,7 +3819,7 @@ static int intel_pmu_hw_config(struct perf_event *event)
 	 * event. The rule is to simplify the implementation of the check.
 	 * That's because perf cannot have a complete group at the moment.
 	 */
-	if (x86_pmu.flags & PMU_FL_MEM_LOADS_AUX &&
+	if (require_mem_loads_aux_event(event) &&
 	    (event->attr.sample_type & PERF_SAMPLE_DATA_SRC) &&
 	    is_mem_loads_event(event)) {
 		struct perf_event *leader = event->group_leader;
@@ -4056,6 +4096,39 @@ tfa_get_event_constraints(struct cpu_hw_events *cpuc, int idx,
 	return c;
 }
 
+static struct event_constraint *
+adl_get_event_constraints(struct cpu_hw_events *cpuc, int idx,
+			  struct perf_event *event)
+{
+	struct x86_hybrid_pmu *pmu = hybrid_pmu(event->pmu);
+
+	if (pmu->cpu_type == hybrid_big)
+		return spr_get_event_constraints(cpuc, idx, event);
+	else if (pmu->cpu_type == hybrid_small)
+		return tnt_get_event_constraints(cpuc, idx, event);
+
+	WARN_ON(1);
+	return &emptyconstraint;
+}
+
+static int adl_hw_config(struct perf_event *event)
+{
+	struct x86_hybrid_pmu *pmu = hybrid_pmu(event->pmu);
+
+	if (pmu->cpu_type == hybrid_big)
+		return hsw_hw_config(event);
+	else if (pmu->cpu_type == hybrid_small)
+		return intel_pmu_hw_config(event);
+
+	WARN_ON(1);
+	return -EOPNOTSUPP;
+}
+
+static u8 adl_get_hybrid_cpu_type(void)
+{
+	return hybrid_big;
+}
+
 /*
  * Broadwell:
  *
@@ -4416,6 +4489,14 @@ static int intel_pmu_aux_output_match(struct perf_event *event)
 	return is_intel_pt_event(event);
 }
 
+static int intel_pmu_filter_match(struct perf_event *event)
+{
+	struct x86_hybrid_pmu *pmu = hybrid_pmu(event->pmu);
+	unsigned int cpu = smp_processor_id();
+
+	return cpumask_test_cpu(cpu, &pmu->supported_cpus);
+}
+
 PMU_FORMAT_ATTR(offcore_rsp, "config1:0-63");
 
 PMU_FORMAT_ATTR(ldlat, "config1:0-15");
@@ -5118,6 +5199,84 @@ static const struct attribute_group *attr_update[] = {
 	NULL,
 };
 
+EVENT_ATTR_STR_HYBRID(slots,                 slots_adl,        "event=0x00,umask=0x4",                       hybrid_big);
+EVENT_ATTR_STR_HYBRID(topdown-retiring,      td_retiring_adl,  "event=0xc2,umask=0x0;event=0x00,umask=0x80", hybrid_big_small);
+EVENT_ATTR_STR_HYBRID(topdown-bad-spec,      td_bad_spec_adl,  "event=0x73,umask=0x0;event=0x00,umask=0x81", hybrid_big_small);
+EVENT_ATTR_STR_HYBRID(topdown-fe-bound,      td_fe_bound_adl,  "event=0x71,umask=0x0;event=0x00,umask=0x82", hybrid_big_small);
+EVENT_ATTR_STR_HYBRID(topdown-be-bound,      td_be_bound_adl,  "event=0x74,umask=0x0;event=0x00,umask=0x83", hybrid_big_small);
+EVENT_ATTR_STR_HYBRID(topdown-heavy-ops,     td_heavy_ops_adl, "event=0x00,umask=0x84",                      hybrid_big);
+EVENT_ATTR_STR_HYBRID(topdown-br-mispredict, td_br_mis_adl,    "event=0x00,umask=0x85",                      hybrid_big);
+EVENT_ATTR_STR_HYBRID(topdown-fetch-lat,     td_fetch_lat_adl, "event=0x00,umask=0x86",                      hybrid_big);
+EVENT_ATTR_STR_HYBRID(topdown-mem-bound,     td_mem_bound_adl, "event=0x00,umask=0x87",                      hybrid_big);
+
+static struct attribute *adl_hybrid_events_attrs[] = {
+	EVENT_PTR(slots_adl),
+	EVENT_PTR(td_retiring_adl),
+	EVENT_PTR(td_bad_spec_adl),
+	EVENT_PTR(td_fe_bound_adl),
+	EVENT_PTR(td_be_bound_adl),
+	EVENT_PTR(td_heavy_ops_adl),
+	EVENT_PTR(td_br_mis_adl),
+	EVENT_PTR(td_fetch_lat_adl),
+	EVENT_PTR(td_mem_bound_adl),
+	NULL,
+};
+
+/* Must be in IDX order */
+EVENT_ATTR_STR_HYBRID(mem-loads,     mem_ld_adl,     "event=0xd0,umask=0x5,ldlat=3;event=0xcd,umask=0x1,ldlat=3", hybrid_big_small);
+EVENT_ATTR_STR_HYBRID(mem-stores,    mem_st_adl,     "event=0xd0,umask=0x6;event=0xcd,umask=0x2",                 hybrid_big_small);
+EVENT_ATTR_STR_HYBRID(mem-loads-aux, mem_ld_aux_adl, "event=0x03,umask=0x82",                                     hybrid_big);
+
+static struct attribute *adl_hybrid_mem_attrs[] = {
+	EVENT_PTR(mem_ld_adl),
+	EVENT_PTR(mem_st_adl),
+	EVENT_PTR(mem_ld_aux_adl),
+	NULL,
+};
+
+EVENT_ATTR_STR_HYBRID(tx-start,          tx_start_adl,          "event=0xc9,umask=0x1",          hybrid_big);
+EVENT_ATTR_STR_HYBRID(tx-commit,         tx_commit_adl,         "event=0xc9,umask=0x2",          hybrid_big);
+EVENT_ATTR_STR_HYBRID(tx-abort,          tx_abort_adl,          "event=0xc9,umask=0x4",          hybrid_big);
+EVENT_ATTR_STR_HYBRID(tx-conflict,       tx_conflict_adl,       "event=0x54,umask=0x1",          hybrid_big);
+EVENT_ATTR_STR_HYBRID(cycles-t,          cycles_t_adl,          "event=0x3c,in_tx=1",            hybrid_big);
+EVENT_ATTR_STR_HYBRID(cycles-ct,         cycles_ct_adl,         "event=0x3c,in_tx=1,in_tx_cp=1", hybrid_big);
+EVENT_ATTR_STR_HYBRID(tx-capacity-read,  tx_capacity_read_adl,  "event=0x54,umask=0x80",         hybrid_big);
+EVENT_ATTR_STR_HYBRID(tx-capacity-write, tx_capacity_write_adl, "event=0x54,umask=0x2",          hybrid_big);
+
+static struct attribute *adl_hybrid_tsx_attrs[] = {
+	EVENT_PTR(tx_start_adl),
+	EVENT_PTR(tx_abort_adl),
+	EVENT_PTR(tx_commit_adl),
+	EVENT_PTR(tx_capacity_read_adl),
+	EVENT_PTR(tx_capacity_write_adl),
+	EVENT_PTR(tx_conflict_adl),
+	EVENT_PTR(cycles_t_adl),
+	EVENT_PTR(cycles_ct_adl),
+	NULL,
+};
+
+FORMAT_ATTR_HYBRID(in_tx,       hybrid_big);
+FORMAT_ATTR_HYBRID(in_tx_cp,    hybrid_big);
+FORMAT_ATTR_HYBRID(offcore_rsp, hybrid_big_small);
+FORMAT_ATTR_HYBRID(ldlat,       hybrid_big_small);
+FORMAT_ATTR_HYBRID(frontend,    hybrid_big);
+
+static struct attribute *adl_hybrid_extra_attr_rtm[] = {
+	FORMAT_HYBRID_PTR(in_tx),
+	FORMAT_HYBRID_PTR(in_tx_cp),
+	FORMAT_HYBRID_PTR(offcore_rsp),
+	FORMAT_HYBRID_PTR(ldlat),
+	FORMAT_HYBRID_PTR(frontend),
+	NULL,
+};
+
+static struct attribute *adl_hybrid_extra_attr[] = {
+	FORMAT_HYBRID_PTR(offcore_rsp),
+	FORMAT_HYBRID_PTR(ldlat),
+	FORMAT_HYBRID_PTR(frontend),
+	NULL,
+};
+
 static bool is_attr_for_this_pmu(struct kobject *kobj, struct attribute *attr)
 {
 	struct device *dev = kobj_to_dev(kobj);
@@ -5347,6 +5506,7 @@ __init int intel_pmu_init(void)
 	bool pmem = false;
 	int version, i;
 	char *name;
+	struct x86_hybrid_pmu *pmu;
 
 	if (!cpu_has(&boot_cpu_data, X86_FEATURE_ARCH_PERFMON)) {
 		switch (boot_cpu_data.x86) {
@@ -5941,6 +6101,99 @@ __init int intel_pmu_init(void)
 		name = "sapphire_rapids";
 		break;
 
+	case INTEL_FAM6_ALDERLAKE:
+	case INTEL_FAM6_ALDERLAKE_L:
+		/*
+		 * Alder Lake has 2 types of CPU, core and atom.
+		 *
+		 * Initialize the common PerfMon capabilities here.
+		 */
+		x86_pmu.hybrid_pmu = kcalloc(X86_HYBRID_NUM_PMUS,
+					     sizeof(struct x86_hybrid_pmu),
+					     GFP_KERNEL);
+		if (!x86_pmu.hybrid_pmu)
+			return -ENOMEM;
+		static_branch_enable(&perf_is_hybrid);
+		x86_pmu.num_hybrid_pmus = X86_HYBRID_NUM_PMUS;
+
+		x86_pmu.late_ack = true;
+		x86_pmu.pebs_aliases = NULL;
+		x86_pmu.pebs_prec_dist = true;
+		x86_pmu.pebs_block = true;
+		x86_pmu.flags |= PMU_FL_HAS_RSP_1;
+		x86_pmu.flags |= PMU_FL_NO_HT_SHARING;
+		x86_pmu.flags |= PMU_FL_PEBS_ALL;
+		x86_pmu.flags |= PMU_FL_INSTR_LATENCY;
+		x86_pmu.flags |= PMU_FL_MEM_LOADS_AUX;
+		x86_pmu.lbr_pt_coexist = true;
+		intel_pmu_pebs_data_source_skl(false);
+		x86_pmu.num_topdown_events = 8;
+		x86_pmu.update_topdown_event = adl_update_topdown_event;
+		x86_pmu.set_topdown_event_period = adl_set_topdown_event_period;
+
+		x86_pmu.filter_match = intel_pmu_filter_match;
+		x86_pmu.get_event_constraints = adl_get_event_constraints;
+		x86_pmu.hw_config = adl_hw_config;
+		x86_pmu.limit_period = spr_limit_period;
+		x86_pmu.get_hybrid_cpu_type = adl_get_hybrid_cpu_type;
+		/*
+		 * The rtm_abort_event is used to check whether to enable GPRs
+		 * for the RTM abort event. Atom doesn't have the RTM abort
+		 * event. There is no harmful to set it in the common
+		 * x86_pmu.rtm_abort_event.
+		 */
+		x86_pmu.rtm_abort_event = X86_CONFIG(.event=0xc9, .umask=0x04);
+
+		td_attr = adl_hybrid_events_attrs;
+		mem_attr = adl_hybrid_mem_attrs;
+		tsx_attr = adl_hybrid_tsx_attrs;
+		extra_attr = boot_cpu_has(X86_FEATURE_RTM) ?
+			adl_hybrid_extra_attr_rtm : adl_hybrid_extra_attr;
+
+		/* Initialize big core specific PerfMon capabilities.*/
+		pmu = &x86_pmu.hybrid_pmu[X86_HYBRID_PMU_CORE_IDX];
+		pmu->name = "cpu_core";
+		pmu->cpu_type = hybrid_big;
+		pmu->num_counters = x86_pmu.num_counters + 2;
+		pmu->num_counters_fixed = x86_pmu.num_counters_fixed + 1;
+		pmu->max_pebs_events = min_t(unsigned, MAX_PEBS_EVENTS, pmu->num_counters);
+		pmu->unconstrained = (struct event_constraint)
+					__EVENT_CONSTRAINT(0, (1ULL << pmu->num_counters) - 1,
+							   0, pmu->num_counters, 0, 0);
+		pmu->intel_cap.capabilities = x86_pmu.intel_cap.capabilities;
+		pmu->intel_cap.perf_metrics = 1;
+		pmu->intel_cap.pebs_output_pt_available = 0;
+
+		memcpy(pmu->hw_cache_event_ids, spr_hw_cache_event_ids, sizeof(pmu->hw_cache_event_ids));
+		memcpy(pmu->hw_cache_extra_regs, spr_hw_cache_extra_regs, sizeof(pmu->hw_cache_extra_regs));
+		pmu->event_constraints = intel_spr_event_constraints;
+		pmu->pebs_constraints = intel_spr_pebs_event_constraints;
+		pmu->extra_regs = intel_spr_extra_regs;
+
+		/* Initialize Atom core specific PerfMon capabilities.*/
+		pmu = &x86_pmu.hybrid_pmu[X86_HYBRID_PMU_ATOM_IDX];
+		pmu->name = "cpu_atom";
+		pmu->cpu_type = hybrid_small;
+		pmu->num_counters = x86_pmu.num_counters;
+		pmu->num_counters_fixed = x86_pmu.num_counters_fixed;
+		pmu->max_pebs_events = x86_pmu.max_pebs_events;
+		pmu->unconstrained = (struct event_constraint)
+					__EVENT_CONSTRAINT(0, (1ULL << pmu->num_counters) - 1,
+							   0, pmu->num_counters, 0, 0);
+		pmu->intel_cap.capabilities = x86_pmu.intel_cap.capabilities;
+		pmu->intel_cap.perf_metrics = 0;
+		pmu->intel_cap.pebs_output_pt_available = 1;
+
+		memcpy(pmu->hw_cache_event_ids, glp_hw_cache_event_ids, sizeof(pmu->hw_cache_event_ids));
+		memcpy(pmu->hw_cache_extra_regs, tnt_hw_cache_extra_regs, sizeof(pmu->hw_cache_extra_regs));
+		pmu->hw_cache_event_ids[C(ITLB)][C(OP_READ)][C(RESULT_ACCESS)] = -1;
+		pmu->event_constraints = intel_slm_event_constraints;
+		pmu->pebs_constraints = intel_grt_pebs_event_constraints;
+		pmu->extra_regs = intel_grt_extra_regs;
+		pr_cont("Alderlake Hybrid events, ");
+		name = "alderlake_hybrid";
+		break;
+
 	default:
 		switch (x86_pmu.version) {
 		case 1:
diff --git a/arch/x86/events/intel/ds.c b/arch/x86/events/intel/ds.c
index f1402bc..2780cb5 100644
--- a/arch/x86/events/intel/ds.c
+++ b/arch/x86/events/intel/ds.c
@@ -779,6 +779,13 @@ struct event_constraint intel_glm_pebs_event_constraints[] = {
 	EVENT_CONSTRAINT_END
 };
 
+struct event_constraint intel_grt_pebs_event_constraints[] = {
+	/* Allow all events as PEBS with no flags */
+	INTEL_PLD_CONSTRAINT(0x5d0, 0xf),
+	INTEL_PSD_CONSTRAINT(0x6d0, 0xf),
+	EVENT_CONSTRAINT_END
+};
+
 struct event_constraint intel_nehalem_pebs_event_constraints[] = {
 	INTEL_PLD_CONSTRAINT(0x100b, 0xf),      /* MEM_INST_RETIRED.* */
 	INTEL_FLAGS_EVENT_CONSTRAINT(0x0f, 0xf),    /* MEM_UNCORE_RETIRED.* */
diff --git a/arch/x86/events/perf_event.h b/arch/x86/events/perf_event.h
index 606fb6e..27fa85e 100644
--- a/arch/x86/events/perf_event.h
+++ b/arch/x86/events/perf_event.h
@@ -692,6 +692,11 @@ enum hybrid_pmu_type {
 	hybrid_big_small	= hybrid_big | hybrid_small,
 };
 
+#define X86_HYBRID_PMU_ATOM_IDX		0
+#define X86_HYBRID_PMU_CORE_IDX		1
+
+#define X86_HYBRID_NUM_PMUS		2
+
 /*
  * struct x86_pmu - generic x86 pmu
  */
@@ -1258,6 +1263,8 @@ extern struct event_constraint intel_glm_pebs_event_constraints[];
 
 extern struct event_constraint intel_glp_pebs_event_constraints[];
 
+extern struct event_constraint intel_grt_pebs_event_constraints[];
+
 extern struct event_constraint intel_nehalem_pebs_event_constraints[];
 
 extern struct event_constraint intel_westmere_pebs_event_constraints[];
