Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CFA572498B9
	for <lists+linux-tip-commits@lfdr.de>; Wed, 19 Aug 2020 10:54:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727808AbgHSIyJ (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 19 Aug 2020 04:54:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726970AbgHSIwI (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 19 Aug 2020 04:52:08 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E346BC061342;
        Wed, 19 Aug 2020 01:52:07 -0700 (PDT)
Date:   Wed, 19 Aug 2020 08:52:05 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1597827126;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=m8E33wM0eUdDn/MICinTlKvrKptSaccIvivyRPmOpvU=;
        b=cdGLe4LNPFcTaPxs8JojP2XfGT/pQWKS8Df9YbAmAYg1L3F1Mws8H0efLPKUG3HiYnU0VH
        utlRhxbsBPPAAo3slgDPThxMjJQMd1UdQmeubp0ggFNuJCz2fPGgBhSouGRtAFxxzqB+QA
        pJUrjqkcE7MypsrI/iuCIfyeCYluiWzgw+InFnsfFOcJQbaCLg2AuQrwOAR4G8jLsl/Nlp
        BG+YFHqw+vN1ICS3Rdien2AUGccvEFaeokyw+xmUdwwUAKDKZgptDjRzVNRm/NsjNkwjAK
        vJIUs02HG7SwbXT/WxJdPQk9nRtxzKOBIryDFCPqDamrGrhgxIhIOHeHYmZrmQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1597827126;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=m8E33wM0eUdDn/MICinTlKvrKptSaccIvivyRPmOpvU=;
        b=Fv1EjGd8iYfvBNscu+2i5jkHYv1xqi/eAlbeB6ArDhenFykcJ4FC1vp3Ag7ToDwAzsmEHM
        9MKDU36sOE58FABw==
From:   "tip-bot2 for Kan Liang" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf/x86/intel: Support TopDown metrics on Ice Lake
Cc:     Kan Liang <kan.liang@linux.intel.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200723171117.9918-11-kan.liang@linux.intel.com>
References: <20200723171117.9918-11-kan.liang@linux.intel.com>
MIME-Version: 1.0
Message-ID: <159782712567.3192.16278278933877251116.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-tip-commits-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     59a854e2f3b90ad2cc7368ae392de40b981ad51d
Gitweb:        https://git.kernel.org/tip/59a854e2f3b90ad2cc7368ae392de40b981ad51d
Author:        Kan Liang <kan.liang@linux.intel.com>
AuthorDate:    Thu, 23 Jul 2020 10:11:13 -07:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 18 Aug 2020 16:34:37 +02:00

perf/x86/intel: Support TopDown metrics on Ice Lake

Ice Lake supports the hardware TopDown metrics feature, which can free
up the scarce GP counters.

Update the event constraints for the metrics events. The metric counters
do not exist, which are mapped to a dummy offset. The sharing between
multiple users of the same metric without multiplexing is not allowed.

Implement set_topdown_event_period for Ice Lake. The values in
PERF_METRICS MSR are derived from the fixed counter 3. Both registers
should start from zero.

Implement update_topdown_event for Ice Lake. The metric is reported by
multiplying the metric (fraction) with slots. To maintain accurate
measurements, both registers are cleared for each update. The fixed
counter 3 should always be cleared before the PERF_METRICS.

Implement td_attr for the new metrics events and the new slots fixed
counter. Make them visible to the perf user tools.

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20200723171117.9918-11-kan.liang@linux.intel.com
---
 arch/x86/events/intel/core.c      | 118 +++++++++++++++++++++++++++++-
 arch/x86/events/perf_event.h      |  13 +++-
 arch/x86/include/asm/msr-index.h  |   2 +-
 arch/x86/include/asm/perf_event.h |   2 +-
 4 files changed, 135 insertions(+)

diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index 4a43668..db83334 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -247,6 +247,10 @@ static struct event_constraint intel_icl_event_constraints[] = {
 	FIXED_EVENT_CONSTRAINT(0x003c, 1),	/* CPU_CLK_UNHALTED.CORE */
 	FIXED_EVENT_CONSTRAINT(0x0300, 2),	/* CPU_CLK_UNHALTED.REF */
 	FIXED_EVENT_CONSTRAINT(0x0400, 3),	/* SLOTS */
+	METRIC_EVENT_CONSTRAINT(INTEL_TD_METRIC_RETIRING, 0),
+	METRIC_EVENT_CONSTRAINT(INTEL_TD_METRIC_BAD_SPEC, 1),
+	METRIC_EVENT_CONSTRAINT(INTEL_TD_METRIC_FE_BOUND, 2),
+	METRIC_EVENT_CONSTRAINT(INTEL_TD_METRIC_BE_BOUND, 3),
 	INTEL_EVENT_CONSTRAINT_RANGE(0x03, 0x0a, 0xf),
 	INTEL_EVENT_CONSTRAINT_RANGE(0x1f, 0x28, 0xf),
 	INTEL_EVENT_CONSTRAINT(0x32, 0xf),	/* SW_PREFETCH_ACCESS.* */
@@ -309,6 +313,12 @@ EVENT_ATTR_STR_HT(topdown-recovery-bubbles, td_recovery_bubbles,
 EVENT_ATTR_STR_HT(topdown-recovery-bubbles.scale, td_recovery_bubbles_scale,
 	"4", "2");
 
+EVENT_ATTR_STR(slots,			slots,		"event=0x00,umask=0x4");
+EVENT_ATTR_STR(topdown-retiring,	td_retiring,	"event=0x00,umask=0x80");
+EVENT_ATTR_STR(topdown-bad-spec,	td_bad_spec,	"event=0x00,umask=0x81");
+EVENT_ATTR_STR(topdown-fe-bound,	td_fe_bound,	"event=0x00,umask=0x82");
+EVENT_ATTR_STR(topdown-be-bound,	td_be_bound,	"event=0x00,umask=0x83");
+
 static struct attribute *snb_events_attrs[] = {
 	EVENT_PTR(td_slots_issued),
 	EVENT_PTR(td_slots_retired),
@@ -2232,6 +2242,99 @@ static void intel_pmu_del_event(struct perf_event *event)
 		intel_pmu_pebs_del(event);
 }
 
+static int icl_set_topdown_event_period(struct perf_event *event)
+{
+	struct hw_perf_event *hwc = &event->hw;
+	s64 left = local64_read(&hwc->period_left);
+
+	/*
+	 * The values in PERF_METRICS MSR are derived from fixed counter 3.
+	 * Software should start both registers, PERF_METRICS and fixed
+	 * counter 3, from zero.
+	 * Clear PERF_METRICS and Fixed counter 3 in initialization.
+	 * After that, both MSRs will be cleared for each read.
+	 * Don't need to clear them again.
+	 */
+	if (left == x86_pmu.max_period) {
+		wrmsrl(MSR_CORE_PERF_FIXED_CTR3, 0);
+		wrmsrl(MSR_PERF_METRICS, 0);
+		local64_set(&hwc->period_left, 0);
+	}
+
+	perf_event_update_userpage(event);
+
+	return 0;
+}
+
+static inline u64 icl_get_metrics_event_value(u64 metric, u64 slots, int idx)
+{
+	u32 val;
+
+	/*
+	 * The metric is reported as an 8bit integer fraction
+	 * suming up to 0xff.
+	 * slots-in-metric = (Metric / 0xff) * slots
+	 */
+	val = (metric >> ((idx - INTEL_PMC_IDX_METRIC_BASE) * 8)) & 0xff;
+	return  mul_u64_u32_div(slots, val, 0xff);
+}
+
+static void __icl_update_topdown_event(struct perf_event *event,
+				       u64 slots, u64 metrics)
+{
+	int idx = event->hw.idx;
+	u64 delta;
+
+	if (is_metric_idx(idx))
+		delta = icl_get_metrics_event_value(metrics, slots, idx);
+	else
+		delta = slots;
+
+	local64_add(delta, &event->count);
+}
+
+/*
+ * Update all active Topdown events.
+ *
+ * The PERF_METRICS and Fixed counter 3 are read separately. The values may be
+ * modify by a NMI. PMU has to be disabled before calling this function.
+ */
+static u64 icl_update_topdown_event(struct perf_event *event)
+{
+	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
+	struct perf_event *other;
+	u64 slots, metrics;
+	int idx;
+
+	/* read Fixed counter 3 */
+	rdpmcl((3 | INTEL_PMC_FIXED_RDPMC_BASE), slots);
+	if (!slots)
+		return 0;
+
+	/* read PERF_METRICS */
+	rdpmcl(INTEL_PMC_FIXED_RDPMC_METRICS, metrics);
+
+	for_each_set_bit(idx, cpuc->active_mask, INTEL_PMC_IDX_TD_BE_BOUND + 1) {
+		if (!is_topdown_idx(idx))
+			continue;
+		other = cpuc->events[idx];
+		__icl_update_topdown_event(other, slots, metrics);
+	}
+
+	/*
+	 * Check and update this event, which may have been cleared
+	 * in active_mask e.g. x86_pmu_stop()
+	 */
+	if (event && !test_bit(event->hw.idx, cpuc->active_mask))
+		__icl_update_topdown_event(event, slots, metrics);
+
+	/* The fixed counter 3 has to be written before the PERF_METRICS. */
+	wrmsrl(MSR_CORE_PERF_FIXED_CTR3, 0);
+	wrmsrl(MSR_PERF_METRICS, 0);
+
+	return slots;
+}
+
 static void intel_pmu_read_topdown_event(struct perf_event *event)
 {
 	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
@@ -4480,6 +4583,15 @@ static struct attribute *icl_events_attrs[] = {
 	NULL,
 };
 
+static struct attribute *icl_td_events_attrs[] = {
+	EVENT_PTR(slots),
+	EVENT_PTR(td_retiring),
+	EVENT_PTR(td_bad_spec),
+	EVENT_PTR(td_fe_bound),
+	EVENT_PTR(td_be_bound),
+	NULL,
+};
+
 static struct attribute *icl_tsx_events_attrs[] = {
 	EVENT_PTR(tx_start),
 	EVENT_PTR(tx_abort),
@@ -5264,10 +5376,13 @@ __init int intel_pmu_init(void)
 			hsw_format_attr : nhm_format_attr;
 		extra_skl_attr = skl_format_attr;
 		mem_attr = icl_events_attrs;
+		td_attr = icl_td_events_attrs;
 		tsx_attr = icl_tsx_events_attrs;
 		x86_pmu.rtm_abort_event = X86_CONFIG(.event=0xca, .umask=0x02);
 		x86_pmu.lbr_pt_coexist = true;
 		intel_pmu_pebs_data_source_skl(pmem);
+		x86_pmu.update_topdown_event = icl_update_topdown_event;
+		x86_pmu.set_topdown_event_period = icl_set_topdown_event_period;
 		pr_cont("Icelake events, ");
 		name = "icelake";
 		break;
@@ -5387,6 +5502,9 @@ __init int intel_pmu_init(void)
 	if (x86_pmu.counter_freezing)
 		x86_pmu.handle_irq = intel_pmu_handle_irq_v4;
 
+	if (x86_pmu.intel_cap.perf_metrics)
+		x86_pmu.intel_ctrl |= 1ULL << GLOBAL_CTRL_EN_PERF_METRICS;
+
 	return 0;
 }
 
diff --git a/arch/x86/events/perf_event.h b/arch/x86/events/perf_event.h
index dea009c..3454424 100644
--- a/arch/x86/events/perf_event.h
+++ b/arch/x86/events/perf_event.h
@@ -407,6 +407,19 @@ struct cpu_hw_events {
 	EVENT_CONSTRAINT(c, (1ULL << (32+n)), FIXED_EVENT_FLAGS)
 
 /*
+ * The special metric counters do not actually exist. They are calculated from
+ * the combination of the FxCtr3 + MSR_PERF_METRICS.
+ *
+ * The special metric counters are mapped to a dummy offset for the scheduler.
+ * The sharing between multiple users of the same metric without multiplexing
+ * is not allowed, even though the hardware supports that in principle.
+ */
+
+#define METRIC_EVENT_CONSTRAINT(c, n)					\
+	EVENT_CONSTRAINT(c, (1ULL << (INTEL_PMC_IDX_METRIC_BASE + n)),	\
+			 INTEL_ARCH_EVENT_MASK)
+
+/*
  * Constraint on the Event code + UMask
  */
 #define INTEL_UEVENT_CONSTRAINT(c, n)	\
diff --git a/arch/x86/include/asm/msr-index.h b/arch/x86/include/asm/msr-index.h
index fabb61c..dc131b8 100644
--- a/arch/x86/include/asm/msr-index.h
+++ b/arch/x86/include/asm/msr-index.h
@@ -863,6 +863,8 @@
 #define MSR_CORE_PERF_GLOBAL_CTRL	0x0000038f
 #define MSR_CORE_PERF_GLOBAL_OVF_CTRL	0x00000390
 
+#define MSR_PERF_METRICS		0x00000329
+
 /* PERF_GLOBAL_OVF_CTL bits */
 #define MSR_CORE_PERF_GLOBAL_OVF_CTRL_TRACE_TOPA_PMI_BIT	55
 #define MSR_CORE_PERF_GLOBAL_OVF_CTRL_TRACE_TOPA_PMI		(1ULL << MSR_CORE_PERF_GLOBAL_OVF_CTRL_TRACE_TOPA_PMI_BIT)
diff --git a/arch/x86/include/asm/perf_event.h b/arch/x86/include/asm/perf_event.h
index 964ba31..e20aa58 100644
--- a/arch/x86/include/asm/perf_event.h
+++ b/arch/x86/include/asm/perf_event.h
@@ -198,6 +198,7 @@ struct x86_pmu_capability {
 
 /* RDPMC offset for Fixed PMCs */
 #define INTEL_PMC_FIXED_RDPMC_BASE		(1 << 30)
+#define INTEL_PMC_FIXED_RDPMC_METRICS		(1 << 29)
 
 /*
  * All the fixed-mode PMCs are configured via this single MSR:
@@ -305,6 +306,7 @@ static inline bool is_topdown_idx(int idx)
 #define GLOBAL_STATUS_TRACE_TOPAPMI		BIT_ULL(GLOBAL_STATUS_TRACE_TOPAPMI_BIT)
 #define GLOBAL_STATUS_PERF_METRICS_OVF_BIT	48
 
+#define GLOBAL_CTRL_EN_PERF_METRICS		48
 /*
  * We model guest LBR event tracing as another fixed-mode PMC like BTS.
  *
