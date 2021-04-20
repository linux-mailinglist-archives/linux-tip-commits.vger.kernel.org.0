Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 09BD23656A2
	for <lists+linux-tip-commits@lfdr.de>; Tue, 20 Apr 2021 12:49:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231978AbhDTKr2 (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Tue, 20 Apr 2021 06:47:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231849AbhDTKrV (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Tue, 20 Apr 2021 06:47:21 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01A17C06174A;
        Tue, 20 Apr 2021 03:46:50 -0700 (PDT)
Date:   Tue, 20 Apr 2021 10:46:48 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1618915608;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3UMljqfmGf2z6YRUkvBLT3X6tW7yRWPtl2XdWAFuGCE=;
        b=GGyySZspPOnZW0avmq+zXffFRCeYXygYwW8u5YN9sxt04CK+nuYvrE0tlp7YTyiikzDYe5
        gyIUMUpbBtQRPkIdm0Hmfr27Tezqo4bBm2e3qctOprOPUFBzcY9WvCg75I7FL0vpCqvJZY
        qq2N66RGovBKN7FaYuzfrf/bVKPbv91LraViUV7RVTsCIM/8P1NGkDvF090FA4oN+rLuLU
        UDJng3So3MRIk9fVXUkM7DEUlIfYQFLdV4CBufF+n8M/zjwhuMoNvnJFof4G6+1GYDLHZu
        7RfhWubm753KRtICBi4gZYo5BogRVDz4mb/YzB4613cx7Ne/HuxASlwpuFb6qw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1618915608;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3UMljqfmGf2z6YRUkvBLT3X6tW7yRWPtl2XdWAFuGCE=;
        b=eQXmAsKYJT/ox1wlceKpaVwkebvZX/vG4OVBlETHTdXRWv3bod9OmsQMg1LqiVeSAluEB7
        Xjm7t70/NXy1N+CA==
From:   "tip-bot2 for Kan Liang" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf/x86: Hybrid PMU support for counters
Cc:     Kan Liang <kan.liang@linux.intel.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Andi Kleen <ak@linux.intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <1618237865-33448-7-git-send-email-kan.liang@linux.intel.com>
References: <1618237865-33448-7-git-send-email-kan.liang@linux.intel.com>
MIME-Version: 1.0
Message-ID: <161891560802.29796.878835314868081952.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     d4b294bf84db7a84e295ddf19cb8e7f71b7bd045
Gitweb:        https://git.kernel.org/tip/d4b294bf84db7a84e295ddf19cb8e7f71b7bd045
Author:        Kan Liang <kan.liang@linux.intel.com>
AuthorDate:    Mon, 12 Apr 2021 07:30:46 -07:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 19 Apr 2021 20:03:25 +02:00

perf/x86: Hybrid PMU support for counters

The number of GP and fixed counters are different among hybrid PMUs.
Each hybrid PMU should use its own counter related information.

When handling a certain hybrid PMU, apply the number of counters from
the corresponding hybrid PMU.

When reserving the counters in the initialization of a new event,
reserve all possible counters.

The number of counter recored in the global x86_pmu is for the
architecture counters which are available for all hybrid PMUs. KVM
doesn't support the hybrid PMU yet. Return the number of the
architecture counters for now.

For the functions only available for the old platforms, e.g.,
intel_pmu_drain_pebs_nhm(), nothing is changed.

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Andi Kleen <ak@linux.intel.com>
Link: https://lkml.kernel.org/r/1618237865-33448-7-git-send-email-kan.liang@linux.intel.com
---
 arch/x86/events/core.c       | 55 ++++++++++++++++++++++++-----------
 arch/x86/events/intel/core.c |  8 +++--
 arch/x86/events/intel/ds.c   | 14 +++++----
 arch/x86/events/perf_event.h |  4 +++-
 4 files changed, 56 insertions(+), 25 deletions(-)

diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
index 7d3c19e..1aeb31c 100644
--- a/arch/x86/events/core.c
+++ b/arch/x86/events/core.c
@@ -185,16 +185,29 @@ static DEFINE_MUTEX(pmc_reserve_mutex);
 
 #ifdef CONFIG_X86_LOCAL_APIC
 
+static inline int get_possible_num_counters(void)
+{
+	int i, num_counters = x86_pmu.num_counters;
+
+	if (!is_hybrid())
+		return num_counters;
+
+	for (i = 0; i < x86_pmu.num_hybrid_pmus; i++)
+		num_counters = max_t(int, num_counters, x86_pmu.hybrid_pmu[i].num_counters);
+
+	return num_counters;
+}
+
 static bool reserve_pmc_hardware(void)
 {
-	int i;
+	int i, num_counters = get_possible_num_counters();
 
-	for (i = 0; i < x86_pmu.num_counters; i++) {
+	for (i = 0; i < num_counters; i++) {
 		if (!reserve_perfctr_nmi(x86_pmu_event_addr(i)))
 			goto perfctr_fail;
 	}
 
-	for (i = 0; i < x86_pmu.num_counters; i++) {
+	for (i = 0; i < num_counters; i++) {
 		if (!reserve_evntsel_nmi(x86_pmu_config_addr(i)))
 			goto eventsel_fail;
 	}
@@ -205,7 +218,7 @@ eventsel_fail:
 	for (i--; i >= 0; i--)
 		release_evntsel_nmi(x86_pmu_config_addr(i));
 
-	i = x86_pmu.num_counters;
+	i = num_counters;
 
 perfctr_fail:
 	for (i--; i >= 0; i--)
@@ -216,9 +229,9 @@ perfctr_fail:
 
 static void release_pmc_hardware(void)
 {
-	int i;
+	int i, num_counters = get_possible_num_counters();
 
-	for (i = 0; i < x86_pmu.num_counters; i++) {
+	for (i = 0; i < num_counters; i++) {
 		release_perfctr_nmi(x86_pmu_event_addr(i));
 		release_evntsel_nmi(x86_pmu_config_addr(i));
 	}
@@ -946,6 +959,7 @@ EXPORT_SYMBOL_GPL(perf_assign_events);
 
 int x86_schedule_events(struct cpu_hw_events *cpuc, int n, int *assign)
 {
+	int num_counters = hybrid(cpuc->pmu, num_counters);
 	struct event_constraint *c;
 	struct perf_event *e;
 	int n0, i, wmin, wmax, unsched = 0;
@@ -1021,7 +1035,7 @@ int x86_schedule_events(struct cpu_hw_events *cpuc, int n, int *assign)
 
 	/* slow path */
 	if (i != n) {
-		int gpmax = x86_pmu.num_counters;
+		int gpmax = num_counters;
 
 		/*
 		 * Do not allow scheduling of more than half the available
@@ -1042,7 +1056,7 @@ int x86_schedule_events(struct cpu_hw_events *cpuc, int n, int *assign)
 		 * the extra Merge events needed by large increment events.
 		 */
 		if (x86_pmu.flags & PMU_FL_PAIR) {
-			gpmax = x86_pmu.num_counters - cpuc->n_pair;
+			gpmax = num_counters - cpuc->n_pair;
 			WARN_ON(gpmax <= 0);
 		}
 
@@ -1129,10 +1143,12 @@ static int collect_event(struct cpu_hw_events *cpuc, struct perf_event *event,
  */
 static int collect_events(struct cpu_hw_events *cpuc, struct perf_event *leader, bool dogrp)
 {
+	int num_counters = hybrid(cpuc->pmu, num_counters);
+	int num_counters_fixed = hybrid(cpuc->pmu, num_counters_fixed);
 	struct perf_event *event;
 	int n, max_count;
 
-	max_count = x86_pmu.num_counters + x86_pmu.num_counters_fixed;
+	max_count = num_counters + num_counters_fixed;
 
 	/* current number of events already accepted */
 	n = cpuc->n_events;
@@ -1499,18 +1515,18 @@ void perf_event_print_debug(void)
 {
 	u64 ctrl, status, overflow, pmc_ctrl, pmc_count, prev_left, fixed;
 	u64 pebs, debugctl;
-	struct cpu_hw_events *cpuc;
+	int cpu = smp_processor_id();
+	struct cpu_hw_events *cpuc = &per_cpu(cpu_hw_events, cpu);
+	int num_counters = hybrid(cpuc->pmu, num_counters);
+	int num_counters_fixed = hybrid(cpuc->pmu, num_counters_fixed);
 	unsigned long flags;
-	int cpu, idx;
+	int idx;
 
-	if (!x86_pmu.num_counters)
+	if (!num_counters)
 		return;
 
 	local_irq_save(flags);
 
-	cpu = smp_processor_id();
-	cpuc = &per_cpu(cpu_hw_events, cpu);
-
 	if (x86_pmu.version >= 2) {
 		rdmsrl(MSR_CORE_PERF_GLOBAL_CTRL, ctrl);
 		rdmsrl(MSR_CORE_PERF_GLOBAL_STATUS, status);
@@ -1533,7 +1549,7 @@ void perf_event_print_debug(void)
 	}
 	pr_info("CPU#%d: active:     %016llx\n", cpu, *(u64 *)cpuc->active_mask);
 
-	for (idx = 0; idx < x86_pmu.num_counters; idx++) {
+	for (idx = 0; idx < num_counters; idx++) {
 		rdmsrl(x86_pmu_config_addr(idx), pmc_ctrl);
 		rdmsrl(x86_pmu_event_addr(idx), pmc_count);
 
@@ -1546,7 +1562,7 @@ void perf_event_print_debug(void)
 		pr_info("CPU#%d:   gen-PMC%d left:  %016llx\n",
 			cpu, idx, prev_left);
 	}
-	for (idx = 0; idx < x86_pmu.num_counters_fixed; idx++) {
+	for (idx = 0; idx < num_counters_fixed; idx++) {
 		if (fixed_counter_disabled(idx, cpuc->pmu))
 			continue;
 		rdmsrl(MSR_ARCH_PERFMON_FIXED_CTR0 + idx, pmc_count);
@@ -2781,6 +2797,11 @@ unsigned long perf_misc_flags(struct pt_regs *regs)
 void perf_get_x86_pmu_capability(struct x86_pmu_capability *cap)
 {
 	cap->version		= x86_pmu.version;
+	/*
+	 * KVM doesn't support the hybrid PMU yet.
+	 * Return the common value in global x86_pmu,
+	 * which available for all cores.
+	 */
 	cap->num_counters_gp	= x86_pmu.num_counters;
 	cap->num_counters_fixed	= x86_pmu.num_counters_fixed;
 	cap->bit_width_gp	= x86_pmu.cntval_bits;
diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index 2d56055..3ea0126 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -2711,21 +2711,23 @@ static void intel_pmu_reset(void)
 {
 	struct debug_store *ds = __this_cpu_read(cpu_hw_events.ds);
 	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
+	int num_counters_fixed = hybrid(cpuc->pmu, num_counters_fixed);
+	int num_counters = hybrid(cpuc->pmu, num_counters);
 	unsigned long flags;
 	int idx;
 
-	if (!x86_pmu.num_counters)
+	if (!num_counters)
 		return;
 
 	local_irq_save(flags);
 
 	pr_info("clearing PMU state on CPU#%d\n", smp_processor_id());
 
-	for (idx = 0; idx < x86_pmu.num_counters; idx++) {
+	for (idx = 0; idx < num_counters; idx++) {
 		wrmsrl_safe(x86_pmu_config_addr(idx), 0ull);
 		wrmsrl_safe(x86_pmu_event_addr(idx),  0ull);
 	}
-	for (idx = 0; idx < x86_pmu.num_counters_fixed; idx++) {
+	for (idx = 0; idx < num_counters_fixed; idx++) {
 		if (fixed_counter_disabled(idx, cpuc->pmu))
 			continue;
 		wrmsrl_safe(MSR_ARCH_PERFMON_FIXED_CTR0 + idx, 0ull);
diff --git a/arch/x86/events/intel/ds.c b/arch/x86/events/intel/ds.c
index 9328aa1..312bf3b 100644
--- a/arch/x86/events/intel/ds.c
+++ b/arch/x86/events/intel/ds.c
@@ -1007,6 +1007,8 @@ void intel_pmu_pebs_sched_task(struct perf_event_context *ctx, bool sched_in)
 static inline void pebs_update_threshold(struct cpu_hw_events *cpuc)
 {
 	struct debug_store *ds = cpuc->ds;
+	int max_pebs_events = hybrid(cpuc->pmu, max_pebs_events);
+	int num_counters_fixed = hybrid(cpuc->pmu, num_counters_fixed);
 	u64 threshold;
 	int reserved;
 
@@ -1014,9 +1016,9 @@ static inline void pebs_update_threshold(struct cpu_hw_events *cpuc)
 		return;
 
 	if (x86_pmu.flags & PMU_FL_PEBS_ALL)
-		reserved = x86_pmu.max_pebs_events + x86_pmu.num_counters_fixed;
+		reserved = max_pebs_events + num_counters_fixed;
 	else
-		reserved = x86_pmu.max_pebs_events;
+		reserved = max_pebs_events;
 
 	if (cpuc->n_pebs == cpuc->n_large_pebs) {
 		threshold = ds->pebs_absolute_maximum -
@@ -2072,6 +2074,8 @@ static void intel_pmu_drain_pebs_icl(struct pt_regs *iregs, struct perf_sample_d
 {
 	short counts[INTEL_PMC_IDX_FIXED + MAX_FIXED_PEBS_EVENTS] = {};
 	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
+	int max_pebs_events = hybrid(cpuc->pmu, max_pebs_events);
+	int num_counters_fixed = hybrid(cpuc->pmu, num_counters_fixed);
 	struct debug_store *ds = cpuc->ds;
 	struct perf_event *event;
 	void *base, *at, *top;
@@ -2086,9 +2090,9 @@ static void intel_pmu_drain_pebs_icl(struct pt_regs *iregs, struct perf_sample_d
 
 	ds->pebs_index = ds->pebs_buffer_base;
 
-	mask = ((1ULL << x86_pmu.max_pebs_events) - 1) |
-	       (((1ULL << x86_pmu.num_counters_fixed) - 1) << INTEL_PMC_IDX_FIXED);
-	size = INTEL_PMC_IDX_FIXED + x86_pmu.num_counters_fixed;
+	mask = ((1ULL << max_pebs_events) - 1) |
+	       (((1ULL << num_counters_fixed) - 1) << INTEL_PMC_IDX_FIXED);
+	size = INTEL_PMC_IDX_FIXED + num_counters_fixed;
 
 	if (unlikely(base >= top)) {
 		intel_pmu_pebs_event_update_no_drain(cpuc, size);
diff --git a/arch/x86/events/perf_event.h b/arch/x86/events/perf_event.h
index 557c674..0539ad4 100644
--- a/arch/x86/events/perf_event.h
+++ b/arch/x86/events/perf_event.h
@@ -635,6 +635,9 @@ struct x86_hybrid_pmu {
 	struct pmu			pmu;
 	union perf_capabilities		intel_cap;
 	u64				intel_ctrl;
+	int				max_pebs_events;
+	int				num_counters;
+	int				num_counters_fixed;
 };
 
 static __always_inline struct x86_hybrid_pmu *hybrid_pmu(struct pmu *pmu)
@@ -850,6 +853,7 @@ struct x86_pmu {
 	 * are available for all PMUs. The hybrid_pmu only includes the
 	 * unique capabilities.
 	 */
+	int				num_hybrid_pmus;
 	struct x86_hybrid_pmu		*hybrid_pmu;
 };
 
