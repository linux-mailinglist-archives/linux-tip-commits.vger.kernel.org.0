Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B51202498C8
	for <lists+linux-tip-commits@lfdr.de>; Wed, 19 Aug 2020 10:55:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727837AbgHSIz1 (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 19 Aug 2020 04:55:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727053AbgHSIwK (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 19 Aug 2020 04:52:10 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2597EC061344;
        Wed, 19 Aug 2020 01:52:09 -0700 (PDT)
Date:   Wed, 19 Aug 2020 08:52:07 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1597827127;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TA62y9IUyNWc7TIWxXBgmZfgrV9GVGGXA76A6VvmZj0=;
        b=a1JN1v1gL35+qqweyEHX1Z0T3Pus7L5SHbR2rftRYfTut4D/XsAdAfM7uS2Uc/aWBqeVAu
        enxZN8AY2Dpyp+d/Jplg+tNc4WXoth6JtDWyi8CUNjgHFRs3keUXhStVW+3dCXiTTx2Nmf
        UkSEgUQRoiHiWtXT9CHE3rQKdwpExYRaAoU0V85FLV8CMcGp9ogNgCGIDE7EkrfahVenV5
        P3I0EPnIYavYnCjNt1V1wY3lG0ic4c05ZWIdg2w2cWcG5QVWaxlYjurlbAw09ZndtYkYad
        Zq34JZbGhBcv4QciffeFgO7d0mWR3RElyX8AnpUDf3RE3ziZbsgks/fg2XjA2w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1597827127;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TA62y9IUyNWc7TIWxXBgmZfgrV9GVGGXA76A6VvmZj0=;
        b=V3HDsZYV+/Lk8KHxBqB6cYZyqCCurP2iJIQrFAavo1QA+CzEY7+5EGpGly2YBFNi7W4cgl
        FtahxziJTfksYKAw==
From:   "tip-bot2 for Kan Liang" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf/x86/intel: Generic support for hardware TopDown metrics
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Kan Liang <kan.liang@linux.intel.com>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200723171117.9918-9-kan.liang@linux.intel.com>
References: <20200723171117.9918-9-kan.liang@linux.intel.com>
MIME-Version: 1.0
Message-ID: <159782712702.3192.7685411694978012197.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-tip-commits-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     7b2c05a15d29d0570a0d21da1e4fd5cbc85cbf13
Gitweb:        https://git.kernel.org/tip/7b2c05a15d29d0570a0d21da1e4fd5cbc85cbf13
Author:        Kan Liang <kan.liang@linux.intel.com>
AuthorDate:    Thu, 23 Jul 2020 10:11:11 -07:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 18 Aug 2020 16:34:36 +02:00

perf/x86/intel: Generic support for hardware TopDown metrics

Intro
=====

The TopDown Microarchitecture Analysis (TMA) Method is a structured
analysis methodology to identify critical performance bottlenecks in
out-of-order processors. Current perf has supported the method.

The method works well, but there is one problem. To collect the TopDown
events, several GP counters have to be used. If a user wants to collect
other events at the same time, the multiplexing probably be triggered,
which impacts the accuracy.

To free up the scarce GP counters, the hardware TopDown metrics feature
is introduced from Ice Lake. The hardware implements an additional
"metrics" register and a new Fixed Counter 3 that measures pipeline
"slots". The TopDown events can be calculated from them instead.

Events
======

The level 1 TopDown has four metrics. There is no event-code assigned to
the TopDown metrics. Four metric events are exported as separate perf
events, which map to the internal "metrics" counter register. Those
events do not exist in hardware, but can be allocated by the scheduler.

For the event mapping, a special 0x00 event code is used, which is
reserved for fake events. The metric events start from umask 0x10.

When setting up the metric events, they point to the Fixed Counter 3.
They have to be specially handled.
- Add the update_topdown_event() callback to read the additional metrics
  MSR and generate the metrics.
- Add the set_topdown_event_period() callback to initialize metrics MSR
  and the fixed counter 3.
- Add a variable n_metric_event to track the number of the accepted
  metrics events. The sharing between multiple users of the same metric
  without multiplexing is not allowed.
- Only enable/disable the fixed counter 3 when there are no other active
  TopDown events, which avoid the unnecessary writing of the fixed
  control register.
- Disable the PMU when reading the metrics event. The metrics MSR and
  the fixed counter 3 are read separately. The values may be modified by
  an NMI.

All four metric events don't support sampling. Since they will be
handled specially for event update, a flag PERF_X86_EVENT_TOPDOWN is
introduced to indicate this case.

The slots event can support both sampling and counting.
For counting, the flag is also applied.
For sampling, it will be handled normally as other normal events.

Groups
======

The slots event is required in a Topdown group.
To avoid reading the METRICS register multiple times, the metrics and
slots value can only be updated by slots event in a group.
All active slots and metrics events will be updated one time.
Therefore, the slots event must be before any metric events in a Topdown
group.

NMI
======

The METRICS related register may be overflow. The bit 48 of the STATUS
register will be set. If so, PERF_METRICS and Fixed counter 3 are
required to be reset. The patch also update all active slots and
metrics events in the NMI handler.

The update_topdown_event() has to read two registers separately. The
values may be modified by an NMI. PMU has to be disabled before calling
the function.

RDPMC
======

RDPMC is temporarily disabled. A later patch will enable it.

Suggested-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20200723171117.9918-9-kan.liang@linux.intel.com
---
 arch/x86/events/core.c            |  63 ++++++++++++---
 arch/x86/events/intel/core.c      | 124 +++++++++++++++++++++++++++--
 arch/x86/events/perf_event.h      |  37 +++++++++-
 arch/x86/include/asm/msr-index.h  |   1 +-
 arch/x86/include/asm/perf_event.h |  47 +++++++++++-
 5 files changed, 257 insertions(+), 15 deletions(-)

diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
index 8e108ea..53fcf0a 100644
--- a/arch/x86/events/core.c
+++ b/arch/x86/events/core.c
@@ -76,6 +76,9 @@ u64 x86_perf_event_update(struct perf_event *event)
 	if (unlikely(!hwc->event_base))
 		return 0;
 
+	if (unlikely(is_topdown_count(event)) && x86_pmu.update_topdown_event)
+		return x86_pmu.update_topdown_event(event);
+
 	/*
 	 * Careful: an NMI might modify the previous event value.
 	 *
@@ -1031,6 +1034,42 @@ int x86_schedule_events(struct cpu_hw_events *cpuc, int n, int *assign)
 	return unsched ? -EINVAL : 0;
 }
 
+static int add_nr_metric_event(struct cpu_hw_events *cpuc,
+			       struct perf_event *event)
+{
+	if (is_metric_event(event)) {
+		if (cpuc->n_metric == INTEL_TD_METRIC_NUM)
+			return -EINVAL;
+		cpuc->n_metric++;
+	}
+
+	return 0;
+}
+
+static void del_nr_metric_event(struct cpu_hw_events *cpuc,
+				struct perf_event *event)
+{
+	if (is_metric_event(event))
+		cpuc->n_metric--;
+}
+
+static int collect_event(struct cpu_hw_events *cpuc, struct perf_event *event,
+			 int max_count, int n)
+{
+
+	if (x86_pmu.intel_cap.perf_metrics && add_nr_metric_event(cpuc, event))
+		return -EINVAL;
+
+	if (n >= max_count + cpuc->n_metric)
+		return -EINVAL;
+
+	cpuc->event_list[n] = event;
+	if (is_counter_pair(&event->hw))
+		cpuc->n_pair++;
+
+	return 0;
+}
+
 /*
  * dogrp: true if must collect siblings events (group)
  * returns total number of events and error code
@@ -1067,28 +1106,22 @@ static int collect_events(struct cpu_hw_events *cpuc, struct perf_event *leader,
 	}
 
 	if (is_x86_event(leader)) {
-		if (n >= max_count)
+		if (collect_event(cpuc, leader, max_count, n))
 			return -EINVAL;
-		cpuc->event_list[n] = leader;
 		n++;
-		if (is_counter_pair(&leader->hw))
-			cpuc->n_pair++;
 	}
+
 	if (!dogrp)
 		return n;
 
 	for_each_sibling_event(event, leader) {
-		if (!is_x86_event(event) ||
-		    event->state <= PERF_EVENT_STATE_OFF)
+		if (!is_x86_event(event) || event->state <= PERF_EVENT_STATE_OFF)
 			continue;
 
-		if (n >= max_count)
+		if (collect_event(cpuc, event, max_count, n))
 			return -EINVAL;
 
-		cpuc->event_list[n] = event;
 		n++;
-		if (is_counter_pair(&event->hw))
-			cpuc->n_pair++;
 	}
 	return n;
 }
@@ -1110,6 +1143,10 @@ static inline void x86_assign_hw_event(struct perf_event *event,
 		hwc->event_base	= 0;
 		break;
 
+	case INTEL_PMC_IDX_METRIC_BASE ... INTEL_PMC_IDX_METRIC_END:
+		/* All the metric events are mapped onto the fixed counter 3. */
+		idx = INTEL_PMC_IDX_FIXED_SLOTS;
+		/* fall through */
 	case INTEL_PMC_IDX_FIXED ... INTEL_PMC_IDX_FIXED_BTS-1:
 		hwc->config_base = MSR_ARCH_PERFMON_FIXED_CTR_CTRL;
 		hwc->event_base = MSR_ARCH_PERFMON_FIXED_CTR0 +
@@ -1245,6 +1282,10 @@ int x86_perf_event_set_period(struct perf_event *event)
 	if (unlikely(!hwc->event_base))
 		return 0;
 
+	if (unlikely(is_topdown_count(event)) &&
+	    x86_pmu.set_topdown_event_period)
+		return x86_pmu.set_topdown_event_period(event);
+
 	/*
 	 * If we are way outside a reasonable range then just skip forward:
 	 */
@@ -1529,6 +1570,8 @@ static void x86_pmu_del(struct perf_event *event, int flags)
 	}
 	cpuc->event_constraint[i-1] = NULL;
 	--cpuc->n_events;
+	if (x86_pmu.intel_cap.perf_metrics)
+		del_nr_metric_event(cpuc, event);
 
 	perf_event_update_userpage(event);
 
diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index 76eab81..4a43668 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -2165,11 +2165,24 @@ static inline void intel_clear_masks(struct perf_event *event, int idx)
 static void intel_pmu_disable_fixed(struct perf_event *event)
 {
 	struct hw_perf_event *hwc = &event->hw;
-	int idx = hwc->idx - INTEL_PMC_IDX_FIXED;
 	u64 ctrl_val, mask;
+	int idx = hwc->idx;
 
-	mask = 0xfULL << (idx * 4);
+	if (is_topdown_idx(idx)) {
+		struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
+
+		/*
+		 * When there are other active TopDown events,
+		 * don't disable the fixed counter 3.
+		 */
+		if (*(u64 *)cpuc->active_mask & INTEL_PMC_OTHER_TOPDOWN_BITS(idx))
+			return;
+		idx = INTEL_PMC_IDX_FIXED_SLOTS;
+	}
 
+	intel_clear_masks(event, idx);
+
+	mask = 0xfULL << ((idx - INTEL_PMC_IDX_FIXED) * 4);
 	rdmsrl(hwc->config_base, ctrl_val);
 	ctrl_val &= ~mask;
 	wrmsrl(hwc->config_base, ctrl_val);
@@ -2186,7 +2199,7 @@ static void intel_pmu_disable_event(struct perf_event *event)
 		x86_pmu_disable_event(event);
 		break;
 	case INTEL_PMC_IDX_FIXED ... INTEL_PMC_IDX_FIXED_BTS - 1:
-		intel_clear_masks(event, idx);
+	case INTEL_PMC_IDX_METRIC_BASE ... INTEL_PMC_IDX_METRIC_END:
 		intel_pmu_disable_fixed(event);
 		break;
 	case INTEL_PMC_IDX_FIXED_BTS:
@@ -2219,10 +2232,26 @@ static void intel_pmu_del_event(struct perf_event *event)
 		intel_pmu_pebs_del(event);
 }
 
+static void intel_pmu_read_topdown_event(struct perf_event *event)
+{
+	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
+
+	/* Only need to call update_topdown_event() once for group read. */
+	if ((cpuc->txn_flags & PERF_PMU_TXN_READ) &&
+	    !is_slots_event(event))
+		return;
+
+	perf_pmu_disable(event->pmu);
+	x86_pmu.update_topdown_event(event);
+	perf_pmu_enable(event->pmu);
+}
+
 static void intel_pmu_read_event(struct perf_event *event)
 {
 	if (event->hw.flags & PERF_X86_EVENT_AUTO_RELOAD)
 		intel_pmu_auto_reload_read(event);
+	else if (is_topdown_count(event) && x86_pmu.update_topdown_event)
+		intel_pmu_read_topdown_event(event);
 	else
 		x86_perf_event_update(event);
 }
@@ -2230,8 +2259,22 @@ static void intel_pmu_read_event(struct perf_event *event)
 static void intel_pmu_enable_fixed(struct perf_event *event)
 {
 	struct hw_perf_event *hwc = &event->hw;
-	int idx = hwc->idx - INTEL_PMC_IDX_FIXED;
 	u64 ctrl_val, mask, bits = 0;
+	int idx = hwc->idx;
+
+	if (is_topdown_idx(idx)) {
+		struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
+		/*
+		 * When there are other active TopDown events,
+		 * don't enable the fixed counter 3 again.
+		 */
+		if (*(u64 *)cpuc->active_mask & INTEL_PMC_OTHER_TOPDOWN_BITS(idx))
+			return;
+
+		idx = INTEL_PMC_IDX_FIXED_SLOTS;
+	}
+
+	intel_set_masks(event, idx);
 
 	/*
 	 * Enable IRQ generation (0x8), if not PEBS,
@@ -2251,6 +2294,7 @@ static void intel_pmu_enable_fixed(struct perf_event *event)
 	if (x86_pmu.version > 2 && hwc->config & ARCH_PERFMON_EVENTSEL_ANY)
 		bits |= 0x4;
 
+	idx -= INTEL_PMC_IDX_FIXED;
 	bits <<= (idx * 4);
 	mask = 0xfULL << (idx * 4);
 
@@ -2279,7 +2323,7 @@ static void intel_pmu_enable_event(struct perf_event *event)
 		__x86_pmu_enable_event(hwc, ARCH_PERFMON_EVENTSEL_ENABLE);
 		break;
 	case INTEL_PMC_IDX_FIXED ... INTEL_PMC_IDX_FIXED_BTS - 1:
-		intel_set_masks(event, idx);
+	case INTEL_PMC_IDX_METRIC_BASE ... INTEL_PMC_IDX_METRIC_END:
 		intel_pmu_enable_fixed(event);
 		break;
 	case INTEL_PMC_IDX_FIXED_BTS:
@@ -2440,6 +2484,15 @@ static int handle_pmi_common(struct pt_regs *regs, u64 status)
 	}
 
 	/*
+	 * Intel Perf mertrics
+	 */
+	if (__test_and_clear_bit(GLOBAL_STATUS_PERF_METRICS_OVF_BIT, (unsigned long *)&status)) {
+		handled++;
+		if (x86_pmu.update_topdown_event)
+			x86_pmu.update_topdown_event(NULL);
+	}
+
+	/*
 	 * Checkpointed counters can lead to 'spurious' PMIs because the
 	 * rollback caused by the PMI will have cleared the overflow status
 	 * bit. Therefore always force probe these counters.
@@ -3375,6 +3428,58 @@ static int intel_pmu_hw_config(struct perf_event *event)
 	if (event->attr.type != PERF_TYPE_RAW)
 		return 0;
 
+	/*
+	 * Config Topdown slots and metric events
+	 *
+	 * The slots event on Fixed Counter 3 can support sampling,
+	 * which will be handled normally in x86_perf_event_update().
+	 *
+	 * Metric events don't support sampling and require being paired
+	 * with a slots event as group leader. When the slots event
+	 * is used in a metrics group, it too cannot support sampling.
+	 */
+	if (x86_pmu.intel_cap.perf_metrics && is_topdown_event(event)) {
+		if (event->attr.config1 || event->attr.config2)
+			return -EINVAL;
+
+		/*
+		 * The TopDown metrics events and slots event don't
+		 * support any filters.
+		 */
+		if (event->attr.config & X86_ALL_EVENT_FLAGS)
+			return -EINVAL;
+
+		if (is_metric_event(event)) {
+			struct perf_event *leader = event->group_leader;
+
+			/* The metric events don't support sampling. */
+			if (is_sampling_event(event))
+				return -EINVAL;
+
+			/* The metric events require a slots group leader. */
+			if (!is_slots_event(leader))
+				return -EINVAL;
+
+			/*
+			 * The leader/SLOTS must not be a sampling event for
+			 * metric use; hardware requires it starts at 0 when used
+			 * in conjunction with MSR_PERF_METRICS.
+			 */
+			if (is_sampling_event(leader))
+				return -EINVAL;
+
+			event->event_caps |= PERF_EV_CAP_SIBLING;
+			/*
+			 * Only once we have a METRICs sibling do we
+			 * need TopDown magic.
+			 */
+			leader->hw.flags |= PERF_X86_EVENT_TOPDOWN;
+			event->hw.flags  |= PERF_X86_EVENT_TOPDOWN;
+
+			event->hw.flags &= ~PERF_X86_EVENT_RDPMC_ALLOWED;
+		}
+	}
+
 	if (!(event->attr.config & ARCH_PERFMON_EVENTSEL_ANY))
 		return 0;
 
@@ -5218,6 +5323,15 @@ __init int intel_pmu_init(void)
 		 * counter, so do not extend mask to generic counters
 		 */
 		for_each_event_constraint(c, x86_pmu.event_constraints) {
+			/*
+			 * Don't extend the topdown slots and metrics
+			 * events to the generic counters.
+			 */
+			if (c->idxmsk64 & INTEL_PMC_MSK_TOPDOWN) {
+				c->weight = hweight64(c->idxmsk64);
+				continue;
+			}
+
 			if (c->cmask == FIXED_EVENT_FLAGS
 			    && c->idxmsk64 != INTEL_PMC_MSK_FIXED_REF_CYCLES) {
 				c->idxmsk64 |= (1ULL << x86_pmu.num_counters) - 1;
diff --git a/arch/x86/events/perf_event.h b/arch/x86/events/perf_event.h
index 5d453da..dea009c 100644
--- a/arch/x86/events/perf_event.h
+++ b/arch/x86/events/perf_event.h
@@ -79,6 +79,31 @@ static inline bool constraint_match(struct event_constraint *c, u64 ecode)
 #define PERF_X86_EVENT_PEBS_VIA_PT	0x0800 /* use PT buffer for PEBS */
 #define PERF_X86_EVENT_PAIR		0x1000 /* Large Increment per Cycle */
 #define PERF_X86_EVENT_LBR_SELECT	0x2000 /* Save/Restore MSR_LBR_SELECT */
+#define PERF_X86_EVENT_TOPDOWN		0x4000 /* Count Topdown slots/metrics events */
+
+static inline bool is_topdown_count(struct perf_event *event)
+{
+	return event->hw.flags & PERF_X86_EVENT_TOPDOWN;
+}
+
+static inline bool is_metric_event(struct perf_event *event)
+{
+	u64 config = event->attr.config;
+
+	return ((config & ARCH_PERFMON_EVENTSEL_EVENT) == 0) &&
+		((config & INTEL_ARCH_EVENT_MASK) >= INTEL_TD_METRIC_RETIRING)  &&
+		((config & INTEL_ARCH_EVENT_MASK) <= INTEL_TD_METRIC_MAX);
+}
+
+static inline bool is_slots_event(struct perf_event *event)
+{
+	return (event->attr.config & INTEL_ARCH_EVENT_MASK) == INTEL_TD_SLOTS;
+}
+
+static inline bool is_topdown_event(struct perf_event *event)
+{
+	return is_metric_event(event) || is_slots_event(event);
+}
 
 struct amd_nb {
 	int nb_id;  /* NorthBridge id */
@@ -285,6 +310,12 @@ struct cpu_hw_events {
 	u64				tfa_shadow;
 
 	/*
+	 * Perf Metrics
+	 */
+	/* number of accepted metrics events */
+	int				n_metric;
+
+	/*
 	 * AMD specific bits
 	 */
 	struct amd_nb			*amd_nb;
@@ -727,6 +758,12 @@ struct x86_pmu {
 	atomic_t	lbr_exclusive[x86_lbr_exclusive_max];
 
 	/*
+	 * Intel perf metrics
+	 */
+	u64		(*update_topdown_event)(struct perf_event *event);
+	int		(*set_topdown_event_period)(struct perf_event *event);
+
+	/*
 	 * perf task context (i.e. struct perf_event_context::task_ctx_data)
 	 * switch helper to bridge calls from perf/core to perf/x86.
 	 * See struct pmu::swap_task_ctx() usage for examples;
diff --git a/arch/x86/include/asm/msr-index.h b/arch/x86/include/asm/msr-index.h
index 2859ee4..fabb61c 100644
--- a/arch/x86/include/asm/msr-index.h
+++ b/arch/x86/include/asm/msr-index.h
@@ -857,6 +857,7 @@
 #define MSR_CORE_PERF_FIXED_CTR0	0x00000309
 #define MSR_CORE_PERF_FIXED_CTR1	0x0000030a
 #define MSR_CORE_PERF_FIXED_CTR2	0x0000030b
+#define MSR_CORE_PERF_FIXED_CTR3	0x0000030c
 #define MSR_CORE_PERF_FIXED_CTR_CTRL	0x0000038d
 #define MSR_CORE_PERF_GLOBAL_STATUS	0x0000038e
 #define MSR_CORE_PERF_GLOBAL_CTRL	0x0000038f
diff --git a/arch/x86/include/asm/perf_event.h b/arch/x86/include/asm/perf_event.h
index 58419e5..000cab7 100644
--- a/arch/x86/include/asm/perf_event.h
+++ b/arch/x86/include/asm/perf_event.h
@@ -244,6 +244,52 @@ struct x86_pmu_capability {
  */
 #define INTEL_PMC_IDX_FIXED_BTS			(INTEL_PMC_IDX_FIXED + 15)
 
+/*
+ * The PERF_METRICS MSR is modeled as several magic fixed-mode PMCs, one for
+ * each TopDown metric event.
+ *
+ * Internally the TopDown metric events are mapped to the FxCtr 3 (SLOTS).
+ */
+#define INTEL_PMC_IDX_METRIC_BASE		(INTEL_PMC_IDX_FIXED + 16)
+#define INTEL_PMC_IDX_TD_RETIRING		(INTEL_PMC_IDX_METRIC_BASE + 0)
+#define INTEL_PMC_IDX_TD_BAD_SPEC		(INTEL_PMC_IDX_METRIC_BASE + 1)
+#define INTEL_PMC_IDX_TD_FE_BOUND		(INTEL_PMC_IDX_METRIC_BASE + 2)
+#define INTEL_PMC_IDX_TD_BE_BOUND		(INTEL_PMC_IDX_METRIC_BASE + 3)
+#define INTEL_PMC_IDX_METRIC_END		INTEL_PMC_IDX_TD_BE_BOUND
+#define INTEL_PMC_MSK_TOPDOWN			((0xfull << INTEL_PMC_IDX_METRIC_BASE) | \
+						INTEL_PMC_MSK_FIXED_SLOTS)
+
+/*
+ * There is no event-code assigned to the TopDown events.
+ *
+ * For the slots event, use the pseudo code of the fixed counter 3.
+ *
+ * For the metric events, the pseudo event-code is 0x00.
+ * The pseudo umask-code starts from the middle of the pseudo event
+ * space, 0x80.
+ */
+#define INTEL_TD_SLOTS				0x0400	/* TOPDOWN.SLOTS */
+/* Level 1 metrics */
+#define INTEL_TD_METRIC_RETIRING		0x8000	/* Retiring metric */
+#define INTEL_TD_METRIC_BAD_SPEC		0x8100	/* Bad speculation metric */
+#define INTEL_TD_METRIC_FE_BOUND		0x8200	/* FE bound metric */
+#define INTEL_TD_METRIC_BE_BOUND		0x8300	/* BE bound metric */
+#define INTEL_TD_METRIC_MAX			INTEL_TD_METRIC_BE_BOUND
+#define INTEL_TD_METRIC_NUM			4
+
+static inline bool is_metric_idx(int idx)
+{
+	return (unsigned)(idx - INTEL_PMC_IDX_METRIC_BASE) < INTEL_TD_METRIC_NUM;
+}
+
+static inline bool is_topdown_idx(int idx)
+{
+	return is_metric_idx(idx) || idx == INTEL_PMC_IDX_FIXED_SLOTS;
+}
+
+#define INTEL_PMC_OTHER_TOPDOWN_BITS(bit)	\
+			(~(0x1ull << bit) & INTEL_PMC_MSK_TOPDOWN)
+
 #define GLOBAL_STATUS_COND_CHG			BIT_ULL(63)
 #define GLOBAL_STATUS_BUFFER_OVF_BIT		62
 #define GLOBAL_STATUS_BUFFER_OVF		BIT_ULL(GLOBAL_STATUS_BUFFER_OVF_BIT)
@@ -254,6 +300,7 @@ struct x86_pmu_capability {
 #define GLOBAL_STATUS_LBRS_FROZEN		BIT_ULL(GLOBAL_STATUS_LBRS_FROZEN_BIT)
 #define GLOBAL_STATUS_TRACE_TOPAPMI_BIT		55
 #define GLOBAL_STATUS_TRACE_TOPAPMI		BIT_ULL(GLOBAL_STATUS_TRACE_TOPAPMI_BIT)
+#define GLOBAL_STATUS_PERF_METRICS_OVF_BIT	48
 
 /*
  * We model guest LBR event tracing as another fixed-mode PMC like BTS.
