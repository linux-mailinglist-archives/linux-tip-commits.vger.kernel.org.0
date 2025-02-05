Return-Path: <linux-tip-commits+bounces-3333-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 43F31A286B7
	for <lists+linux-tip-commits@lfdr.de>; Wed,  5 Feb 2025 10:38:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0DFF918840DB
	for <lists+linux-tip-commits@lfdr.de>; Wed,  5 Feb 2025 09:39:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4715522A7EC;
	Wed,  5 Feb 2025 09:38:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="If2fQktk";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="qYKFivza"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E45BF22A7E4;
	Wed,  5 Feb 2025 09:38:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738748333; cv=none; b=KYZGynt/CMpksyf0Dmujo8fGCMD0dH6nGrPckeOYKq4EeDSq4BdZP9jNt65cOMuVr+QudQrfSBRjn7oJVKjK3PtBjoxTm17rZLXwlEgwVqNjaVXpLnDyln9vnWcBDzRwI0cqfcME+2vvqhYK2ATnEXRe6qoeHvy3lJhfT4jrd6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738748333; c=relaxed/simple;
	bh=RIwMUOaKKD8ZezIT+18HGHr/ja3CDOy4RFEJqp5/rWM=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=bMaTcWpNmpPY3bcMuCS1BQO1QkIYa9n8EzwA494ZhwOfADVRfqDWVtyVgsH8ARC8Cj7yP8JcKz75wjIeulbpmtBz0DsuaKXR59BSN41mOO8D851ggSkzDxHIcu1euksJW6wEXZoGq+UxOVnzvvkhr+G9obUNV23eMKVTkq/hfYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=If2fQktk; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=qYKFivza; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 05 Feb 2025 09:38:45 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1738748329;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=odUlnccThBk6bPei0mP5wO6ebYjMpodmLLs8dGZE3P8=;
	b=If2fQktkdYqWQZOvCiI/DrwC6hDxnbRfy7xeQs52c3uhHH4u3ob3do18hAvI4SZpMcFgGx
	VR1F9Mq5jviZsy6BPZQwNuaDvc2iG9lDE9T18Hsbkn7nY9pBXDiY0AUhoEfD2JO5ZRVqdS
	BaR7pk9n0q/caNDdjw2dFPLYrzFca8lCK/aOFHE5SlOeGg9K+8nJXUi6zH8bqcXnTNzl//
	tycjAtYw2f31EkSu6/n/YmeKEacYbA0yEEHoPXm6g1vJokCqHPClwETefE41WL9NMP96Vr
	jFiVfbhFzA8CQ6wYCN75DLVk2757T5GPcj+rp5Yc1cTaPyEgayKY95+aTuM9qg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1738748329;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=odUlnccThBk6bPei0mP5wO6ebYjMpodmLLs8dGZE3P8=;
	b=qYKFivzaJEgDuNBhwcCagTgQk0JGzZ4e8cQBko950O37q04t7noIQM4rceFsx0UGQdjRP7
	p53U9OVOd//xK8CQ==
From: "tip-bot2 for Kan Liang" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf/x86/intel: Support PEBS counters snapshotting
Cc: "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Kan Liang <kan.liang@linux.intel.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250121152303.3128733-4-kan.liang@linux.intel.com>
References: <20250121152303.3128733-4-kan.liang@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173874832555.10177.18398857610370220622.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     e02e9b0374c378aab016ae8ace60d9d98ab8caa6
Gitweb:        https://git.kernel.org/tip/e02e9b0374c378aab016ae8ace60d9d98ab8caa6
Author:        Kan Liang <kan.liang@linux.intel.com>
AuthorDate:    Tue, 21 Jan 2025 07:23:03 -08:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 05 Feb 2025 10:29:45 +01:00

perf/x86/intel: Support PEBS counters snapshotting

The counters snapshotting is a new adaptive PEBS extension, which can
capture programmable counters, fixed-function counters, and performance
metrics in a PEBS record. The feature is available in the PEBS format
V6.

The target counters can be configured in the new fields of MSR_PEBS_CFG.
Then the PEBS HW will generate the bit mask of counters (Counters Group
Header) followed by the content of all the requested counters into a
PEBS record.

The current Linux perf sample read feature can read all events in the
group when any event in the group is overflowed. But the rdpmc in the
NMI/overflow handler has a small gap from overflow. Also, there is some
overhead for each rdpmc read. The counters snapshotting feature can be
used as an accurate and low-overhead replacement.

Extend intel_update_topdown_event() to accept the value from PEBS
records.

Add a new PEBS_CNTR flag to indicate a sample read group that utilizes
the counters snapshotting feature. When the group is scheduled, the
PEBS configure can be updated accordingly.

To prevent the case that a PEBS record value might be in the past
relative to what is already in the event, perf always stops the PMU and
drains the PEBS buffer before updating the corresponding event->count.

Suggested-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20250121152303.3128733-4-kan.liang@linux.intel.com
---
 arch/x86/events/core.c             |  13 ++-
 arch/x86/events/intel/core.c       |  75 ++++++++---
 arch/x86/events/intel/ds.c         | 191 ++++++++++++++++++++++++++--
 arch/x86/events/perf_event.h       |  13 ++-
 arch/x86/events/perf_event_flags.h |   2 +-
 arch/x86/include/asm/perf_event.h  |  15 ++-
 6 files changed, 284 insertions(+), 25 deletions(-)

diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
index 8f218ac..7b6430e 100644
--- a/arch/x86/events/core.c
+++ b/arch/x86/events/core.c
@@ -94,6 +94,8 @@ DEFINE_STATIC_CALL_NULL(x86_pmu_pebs_aliases, *x86_pmu.pebs_aliases);
 
 DEFINE_STATIC_CALL_NULL(x86_pmu_filter, *x86_pmu.filter);
 
+DEFINE_STATIC_CALL_NULL(x86_pmu_late_setup, *x86_pmu.late_setup);
+
 /*
  * This one is magic, it will get called even when PMU init fails (because
  * there is no PMU), in which case it should simply return NULL.
@@ -1298,6 +1300,15 @@ static void x86_pmu_enable(struct pmu *pmu)
 
 	if (cpuc->n_added) {
 		int n_running = cpuc->n_events - cpuc->n_added;
+
+		/*
+		 * The late setup (after counters are scheduled)
+		 * is required for some cases, e.g., PEBS counters
+		 * snapshotting. Because an accurate counter index
+		 * is needed.
+		 */
+		static_call_cond(x86_pmu_late_setup)();
+
 		/*
 		 * apply assignment obtained either from
 		 * hw_perf_group_sched_in() or x86_pmu_enable()
@@ -2035,6 +2046,8 @@ static void x86_pmu_static_call_update(void)
 
 	static_call_update(x86_pmu_guest_get_msrs, x86_pmu.guest_get_msrs);
 	static_call_update(x86_pmu_filter, x86_pmu.filter);
+
+	static_call_update(x86_pmu_late_setup, x86_pmu.late_setup);
 }
 
 static void _x86_pmu_read(struct perf_event *event)
diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index 1ccc961..8ce915a 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -2720,7 +2720,7 @@ static void update_saved_topdown_regs(struct perf_event *event, u64 slots,
  * modify by a NMI. PMU has to be disabled before calling this function.
  */
 
-static u64 intel_update_topdown_event(struct perf_event *event, int metric_end)
+static u64 intel_update_topdown_event(struct perf_event *event, int metric_end, u64 *val)
 {
 	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
 	struct perf_event *other;
@@ -2728,13 +2728,24 @@ static u64 intel_update_topdown_event(struct perf_event *event, int metric_end)
 	bool reset = true;
 	int idx;
 
-	/* read Fixed counter 3 */
-	rdpmcl((3 | INTEL_PMC_FIXED_RDPMC_BASE), slots);
-	if (!slots)
-		return 0;
+	if (!val) {
+		/* read Fixed counter 3 */
+		rdpmcl((3 | INTEL_PMC_FIXED_RDPMC_BASE), slots);
+		if (!slots)
+			return 0;
 
-	/* read PERF_METRICS */
-	rdpmcl(INTEL_PMC_FIXED_RDPMC_METRICS, metrics);
+		/* read PERF_METRICS */
+		rdpmcl(INTEL_PMC_FIXED_RDPMC_METRICS, metrics);
+	} else {
+		slots = val[0];
+		metrics = val[1];
+		/*
+		 * Don't reset the PERF_METRICS and Fixed counter 3
+		 * for each PEBS record read. Utilize the RDPMC metrics
+		 * clear mode.
+		 */
+		reset = false;
+	}
 
 	for_each_set_bit(idx, cpuc->active_mask, metric_end + 1) {
 		if (!is_topdown_idx(idx))
@@ -2777,17 +2788,19 @@ static u64 intel_update_topdown_event(struct perf_event *event, int metric_end)
 	return slots;
 }
 
-static u64 icl_update_topdown_event(struct perf_event *event)
+static u64 icl_update_topdown_event(struct perf_event *event, u64 *val)
 {
 	return intel_update_topdown_event(event, INTEL_PMC_IDX_METRIC_BASE +
-						 x86_pmu.num_topdown_events - 1);
+						 x86_pmu.num_topdown_events - 1,
+					  val);
 }
 
-DEFINE_STATIC_CALL(intel_pmu_update_topdown_event, x86_perf_event_update);
+DEFINE_STATIC_CALL(intel_pmu_update_topdown_event, intel_pmu_topdown_event_update);
 
 static void intel_pmu_read_event(struct perf_event *event)
 {
-	if (event->hw.flags & (PERF_X86_EVENT_AUTO_RELOAD | PERF_X86_EVENT_TOPDOWN)) {
+	if (event->hw.flags & (PERF_X86_EVENT_AUTO_RELOAD | PERF_X86_EVENT_TOPDOWN) ||
+	    is_pebs_counter_event_group(event)) {
 		struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
 		bool pmu_enabled = cpuc->enabled;
 
@@ -2799,8 +2812,12 @@ static void intel_pmu_read_event(struct perf_event *event)
 		if (pmu_enabled)
 			intel_pmu_disable_all();
 
-		if (is_topdown_event(event))
-			static_call(intel_pmu_update_topdown_event)(event);
+		/*
+		 * If the PEBS counters snapshotting is enabled,
+		 * the topdown event is available in PEBS records.
+		 */
+		if (is_topdown_event(event) && !is_pebs_counter_event_group(event))
+			static_call(intel_pmu_update_topdown_event)(event, NULL);
 		else
 			intel_pmu_drain_pebs_buffer();
 
@@ -2943,7 +2960,7 @@ static int intel_pmu_set_period(struct perf_event *event)
 static u64 intel_pmu_update(struct perf_event *event)
 {
 	if (unlikely(is_topdown_count(event)))
-		return static_call(intel_pmu_update_topdown_event)(event);
+		return static_call(intel_pmu_update_topdown_event)(event, NULL);
 
 	return x86_perf_event_update(event);
 }
@@ -3109,7 +3126,7 @@ static int handle_pmi_common(struct pt_regs *regs, u64 status)
 	 */
 	if (__test_and_clear_bit(GLOBAL_STATUS_PERF_METRICS_OVF_BIT, (unsigned long *)&status)) {
 		handled++;
-		static_call(intel_pmu_update_topdown_event)(NULL);
+		static_call(intel_pmu_update_topdown_event)(NULL, NULL);
 	}
 
 	/*
@@ -3127,6 +3144,27 @@ static int handle_pmi_common(struct pt_regs *regs, u64 status)
 		if (!test_bit(bit, cpuc->active_mask))
 			continue;
 
+		/*
+		 * There may be unprocessed PEBS records in the PEBS buffer,
+		 * which still stores the previous values.
+		 * Process those records first before handling the latest value.
+		 * For example,
+		 * A is a regular counter
+		 * B is a PEBS event which reads A
+		 * C is a PEBS event
+		 *
+		 * The following can happen:
+		 * B-assist			A=1
+		 * C				A=2
+		 * B-assist			A=3
+		 * A-overflow-PMI		A=4
+		 * C-assist-PMI (PEBS buffer)	A=5
+		 *
+		 * The PEBS buffer has to be drained before handling the A-PMI
+		 */
+		if (is_pebs_counter_event_group(event))
+			x86_pmu.drain_pebs(regs, &data);
+
 		if (!intel_pmu_save_and_restart(event))
 			continue;
 
@@ -4074,6 +4112,13 @@ static int intel_pmu_hw_config(struct perf_event *event)
 		event->hw.flags |= PERF_X86_EVENT_PEBS_VIA_PT;
 	}
 
+	if ((event->attr.sample_type & PERF_SAMPLE_READ) &&
+	    (x86_pmu.intel_cap.pebs_format >= 6) &&
+	    x86_pmu.intel_cap.pebs_baseline &&
+	    is_sampling_event(event) &&
+	    event->attr.precise_ip)
+		event->group_leader->hw.flags |= PERF_X86_EVENT_PEBS_CNTR;
+
 	if ((event->attr.type == PERF_TYPE_HARDWARE) ||
 	    (event->attr.type == PERF_TYPE_HW_CACHE))
 		return 0;
diff --git a/arch/x86/events/intel/ds.c b/arch/x86/events/intel/ds.c
index eb14b46..13a78a8 100644
--- a/arch/x86/events/intel/ds.c
+++ b/arch/x86/events/intel/ds.c
@@ -1294,6 +1294,19 @@ static inline void pebs_update_threshold(struct cpu_hw_events *cpuc)
 	ds->pebs_interrupt_threshold = threshold;
 }
 
+#define PEBS_DATACFG_CNTRS(x)						\
+	((x >> PEBS_DATACFG_CNTR_SHIFT) & PEBS_DATACFG_CNTR_MASK)
+
+#define PEBS_DATACFG_CNTR_BIT(x)					\
+	(((1ULL << x) & PEBS_DATACFG_CNTR_MASK) << PEBS_DATACFG_CNTR_SHIFT)
+
+#define PEBS_DATACFG_FIX(x)						\
+	((x >> PEBS_DATACFG_FIX_SHIFT) & PEBS_DATACFG_FIX_MASK)
+
+#define PEBS_DATACFG_FIX_BIT(x)						\
+	(((1ULL << (x)) & PEBS_DATACFG_FIX_MASK)			\
+	 << PEBS_DATACFG_FIX_SHIFT)
+
 static void adaptive_pebs_record_size_update(void)
 {
 	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
@@ -1308,10 +1321,58 @@ static void adaptive_pebs_record_size_update(void)
 		sz += sizeof(struct pebs_xmm);
 	if (pebs_data_cfg & PEBS_DATACFG_LBRS)
 		sz += x86_pmu.lbr_nr * sizeof(struct lbr_entry);
+	if (pebs_data_cfg & (PEBS_DATACFG_METRICS | PEBS_DATACFG_CNTR)) {
+		sz += sizeof(struct pebs_cntr_header);
+
+		/* Metrics base and Metrics Data */
+		if (pebs_data_cfg & PEBS_DATACFG_METRICS)
+			sz += 2 * sizeof(u64);
+
+		if (pebs_data_cfg & PEBS_DATACFG_CNTR) {
+			sz += (hweight64(PEBS_DATACFG_CNTRS(pebs_data_cfg)) +
+			       hweight64(PEBS_DATACFG_FIX(pebs_data_cfg))) *
+			      sizeof(u64);
+		}
+	}
 
 	cpuc->pebs_record_size = sz;
 }
 
+static void __intel_pmu_pebs_update_cfg(struct perf_event *event,
+					int idx, u64 *pebs_data_cfg)
+{
+	if (is_metric_event(event)) {
+		*pebs_data_cfg |= PEBS_DATACFG_METRICS;
+		return;
+	}
+
+	*pebs_data_cfg |= PEBS_DATACFG_CNTR;
+
+	if (idx >= INTEL_PMC_IDX_FIXED)
+		*pebs_data_cfg |= PEBS_DATACFG_FIX_BIT(idx - INTEL_PMC_IDX_FIXED);
+	else
+		*pebs_data_cfg |= PEBS_DATACFG_CNTR_BIT(idx);
+}
+
+
+static void intel_pmu_late_setup(void)
+{
+	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
+	struct perf_event *event;
+	u64 pebs_data_cfg = 0;
+	int i;
+
+	for (i = 0; i < cpuc->n_events; i++) {
+		event = cpuc->event_list[i];
+		if (!is_pebs_counter_event_group(event))
+			continue;
+		__intel_pmu_pebs_update_cfg(event, cpuc->assign[i], &pebs_data_cfg);
+	}
+
+	if (pebs_data_cfg & ~cpuc->pebs_data_cfg)
+		cpuc->pebs_data_cfg |= pebs_data_cfg | PEBS_UPDATE_DS_SW;
+}
+
 #define PERF_PEBS_MEMINFO_TYPE	(PERF_SAMPLE_ADDR | PERF_SAMPLE_DATA_SRC |   \
 				PERF_SAMPLE_PHYS_ADDR |			     \
 				PERF_SAMPLE_WEIGHT_TYPE |		     \
@@ -1914,12 +1975,89 @@ static void adaptive_pebs_save_regs(struct pt_regs *regs,
 #endif
 }
 
+static void intel_perf_event_update_pmc(struct perf_event *event, u64 pmc)
+{
+	int shift = 64 - x86_pmu.cntval_bits;
+	struct hw_perf_event *hwc;
+	u64 delta, prev_pmc;
+
+	/*
+	 * A recorded counter may not have an assigned event in the
+	 * following cases. The value should be dropped.
+	 * - An event is deleted. There is still an active PEBS event.
+	 *   The PEBS record doesn't shrink on pmu::del().
+	 *   If the counter of the deleted event once occurred in a PEBS
+	 *   record, PEBS still records the counter until the counter is
+	 *   reassigned.
+	 * - An event is stopped for some reason, e.g., throttled.
+	 *   During this period, another event is added and takes the
+	 *   counter of the stopped event. The stopped event is assigned
+	 *   to another new and uninitialized counter, since the
+	 *   x86_pmu_start(RELOAD) is not invoked for a stopped event.
+	 *   The PEBS__DATA_CFG is updated regardless of the event state.
+	 *   The uninitialized counter can be recorded in a PEBS record.
+	 *   But the cpuc->events[uninitialized_counter] is always NULL,
+	 *   because the event is stopped. The uninitialized value is
+	 *   safely dropped.
+	 */
+	if (!event)
+		return;
+
+	hwc = &event->hw;
+	prev_pmc = local64_read(&hwc->prev_count);
+
+	/* Only update the count when the PMU is disabled */
+	WARN_ON(this_cpu_read(cpu_hw_events.enabled));
+	local64_set(&hwc->prev_count, pmc);
+
+	delta = (pmc << shift) - (prev_pmc << shift);
+	delta >>= shift;
+
+	local64_add(delta, &event->count);
+	local64_sub(delta, &hwc->period_left);
+}
+
+static inline void __setup_pebs_counter_group(struct cpu_hw_events *cpuc,
+					      struct perf_event *event,
+					      struct pebs_cntr_header *cntr,
+					      void *next_record)
+{
+	int bit;
+
+	for_each_set_bit(bit, (unsigned long *)&cntr->cntr, INTEL_PMC_MAX_GENERIC) {
+		intel_perf_event_update_pmc(cpuc->events[bit], *(u64 *)next_record);
+		next_record += sizeof(u64);
+	}
+
+	for_each_set_bit(bit, (unsigned long *)&cntr->fixed, INTEL_PMC_MAX_FIXED) {
+		/* The slots event will be handled with perf_metric later */
+		if ((cntr->metrics == INTEL_CNTR_METRICS) &&
+		    (bit + INTEL_PMC_IDX_FIXED == INTEL_PMC_IDX_FIXED_SLOTS)) {
+			next_record += sizeof(u64);
+			continue;
+		}
+		intel_perf_event_update_pmc(cpuc->events[bit + INTEL_PMC_IDX_FIXED],
+					    *(u64 *)next_record);
+		next_record += sizeof(u64);
+	}
+
+	/* HW will reload the value right after the overflow. */
+	if (event->hw.flags & PERF_X86_EVENT_AUTO_RELOAD)
+		local64_set(&event->hw.prev_count, (u64)-event->hw.sample_period);
+
+	if (cntr->metrics == INTEL_CNTR_METRICS) {
+		static_call(intel_pmu_update_topdown_event)
+			   (cpuc->events[INTEL_PMC_IDX_FIXED_SLOTS],
+			    (u64 *)next_record);
+		next_record += 2 * sizeof(u64);
+	}
+}
+
 #define PEBS_LATENCY_MASK			0xffff
 
 /*
  * With adaptive PEBS the layout depends on what fields are configured.
  */
-
 static void setup_pebs_adaptive_sample_data(struct perf_event *event,
 					    struct pt_regs *iregs, void *__pebs,
 					    struct perf_sample_data *data,
@@ -2049,6 +2187,28 @@ static void setup_pebs_adaptive_sample_data(struct perf_event *event,
 		}
 	}
 
+	if (format_group & (PEBS_DATACFG_CNTR | PEBS_DATACFG_METRICS)) {
+		struct pebs_cntr_header *cntr = next_record;
+		unsigned int nr;
+
+		next_record += sizeof(struct pebs_cntr_header);
+		/*
+		 * The PEBS_DATA_CFG is a global register, which is the
+		 * superset configuration for all PEBS events.
+		 * For the PEBS record of non-sample-read group, ignore
+		 * the counter snapshot fields.
+		 */
+		if (is_pebs_counter_event_group(event)) {
+			__setup_pebs_counter_group(cpuc, event, cntr, next_record);
+			data->sample_flags |= PERF_SAMPLE_READ;
+		}
+
+		nr = hweight32(cntr->cntr) + hweight32(cntr->fixed);
+		if (cntr->metrics == INTEL_CNTR_METRICS)
+			nr += 2;
+		next_record += nr * sizeof(u64);
+	}
+
 	WARN_ONCE(next_record != __pebs + basic->format_size,
 			"PEBS record size %u, expected %llu, config %llx\n",
 			basic->format_size,
@@ -2202,13 +2362,21 @@ __intel_pmu_pebs_last_event(struct perf_event *event,
 	}
 
 	if (hwc->flags & PERF_X86_EVENT_AUTO_RELOAD) {
-		/*
-		 * Now, auto-reload is only enabled in fixed period mode.
-		 * The reload value is always hwc->sample_period.
-		 * May need to change it, if auto-reload is enabled in
-		 * freq mode later.
-		 */
-		intel_pmu_save_and_restart_reload(event, count);
+		if ((is_pebs_counter_event_group(event))) {
+			/*
+			 * The value of each sample has been updated when setup
+			 * the corresponding sample data.
+			 */
+			perf_event_update_userpage(event);
+		} else {
+			/*
+			 * Now, auto-reload is only enabled in fixed period mode.
+			 * The reload value is always hwc->sample_period.
+			 * May need to change it, if auto-reload is enabled in
+			 * freq mode later.
+			 */
+			intel_pmu_save_and_restart_reload(event, count);
+		}
 	} else
 		intel_pmu_save_and_restart(event);
 }
@@ -2543,6 +2711,11 @@ void __init intel_ds_init(void)
 			break;
 
 		case 6:
+			if (x86_pmu.intel_cap.pebs_baseline) {
+				x86_pmu.large_pebs_flags |= PERF_SAMPLE_READ;
+				x86_pmu.late_setup = intel_pmu_late_setup;
+			}
+			fallthrough;
 		case 5:
 			x86_pmu.pebs_ept = 1;
 			fallthrough;
@@ -2567,7 +2740,7 @@ void __init intel_ds_init(void)
 					  PERF_SAMPLE_REGS_USER |
 					  PERF_SAMPLE_REGS_INTR);
 			}
-			pr_cont("PEBS fmt4%c%s, ", pebs_type, pebs_qual);
+			pr_cont("PEBS fmt%d%c%s, ", format, pebs_type, pebs_qual);
 
 			if (!is_hybrid() && x86_pmu.intel_cap.pebs_output_pt_available) {
 				pr_cont("PEBS-via-PT, ");
diff --git a/arch/x86/events/perf_event.h b/arch/x86/events/perf_event.h
index 536a112..a698e64 100644
--- a/arch/x86/events/perf_event.h
+++ b/arch/x86/events/perf_event.h
@@ -115,6 +115,11 @@ static inline bool is_branch_counters_group(struct perf_event *event)
 	return event->group_leader->hw.flags & PERF_X86_EVENT_BRANCH_COUNTERS;
 }
 
+static inline bool is_pebs_counter_event_group(struct perf_event *event)
+{
+	return event->group_leader->hw.flags & PERF_X86_EVENT_PEBS_CNTR;
+}
+
 struct amd_nb {
 	int nb_id;  /* NorthBridge id */
 	int refcnt; /* reference count */
@@ -800,6 +805,7 @@ struct x86_pmu {
 	u64		(*update)(struct perf_event *event);
 	int		(*hw_config)(struct perf_event *event);
 	int		(*schedule_events)(struct cpu_hw_events *cpuc, int n, int *assign);
+	void		(*late_setup)(void);
 	unsigned	eventsel;
 	unsigned	perfctr;
 	unsigned	fixedctr;
@@ -1108,6 +1114,7 @@ extern struct x86_pmu x86_pmu __read_mostly;
 DECLARE_STATIC_CALL(x86_pmu_set_period, *x86_pmu.set_period);
 DECLARE_STATIC_CALL(x86_pmu_update,     *x86_pmu.update);
 DECLARE_STATIC_CALL(x86_pmu_drain_pebs,	*x86_pmu.drain_pebs);
+DECLARE_STATIC_CALL(x86_pmu_late_setup,	*x86_pmu.late_setup);
 
 static __always_inline struct x86_perf_task_context_opt *task_context_opt(void *ctx)
 {
@@ -1149,6 +1156,12 @@ extern u64 __read_mostly hw_cache_extra_regs
 
 u64 x86_perf_event_update(struct perf_event *event);
 
+static inline u64 intel_pmu_topdown_event_update(struct perf_event *event, u64 *val)
+{
+	return x86_perf_event_update(event);
+}
+DECLARE_STATIC_CALL(intel_pmu_update_topdown_event, intel_pmu_topdown_event_update);
+
 static inline unsigned int x86_pmu_config_addr(int index)
 {
 	return x86_pmu.eventsel + (x86_pmu.addr_offset ?
diff --git a/arch/x86/events/perf_event_flags.h b/arch/x86/events/perf_event_flags.h
index 6c977c1..1d9e385 100644
--- a/arch/x86/events/perf_event_flags.h
+++ b/arch/x86/events/perf_event_flags.h
@@ -9,7 +9,7 @@ PERF_ARCH(PEBS_LD_HSW,		0x00008) /* haswell style datala, load */
 PERF_ARCH(PEBS_NA_HSW,		0x00010) /* haswell style datala, unknown */
 PERF_ARCH(EXCL,			0x00020) /* HT exclusivity on counter */
 PERF_ARCH(DYNAMIC,		0x00040) /* dynamic alloc'd constraint */
-			/*	0x00080	*/
+PERF_ARCH(PEBS_CNTR,		0x00080) /* PEBS counters snapshot */
 PERF_ARCH(EXCL_ACCT,		0x00100) /* accounted EXCL event */
 PERF_ARCH(AUTO_RELOAD,		0x00200) /* use PEBS auto-reload */
 PERF_ARCH(LARGE_PEBS,		0x00400) /* use large PEBS */
diff --git a/arch/x86/include/asm/perf_event.h b/arch/x86/include/asm/perf_event.h
index ee55817..73b1040 100644
--- a/arch/x86/include/asm/perf_event.h
+++ b/arch/x86/include/asm/perf_event.h
@@ -141,6 +141,12 @@
 #define PEBS_DATACFG_XMMS	BIT_ULL(2)
 #define PEBS_DATACFG_LBRS	BIT_ULL(3)
 #define PEBS_DATACFG_LBR_SHIFT	24
+#define PEBS_DATACFG_CNTR	BIT_ULL(4)
+#define PEBS_DATACFG_CNTR_SHIFT	32
+#define PEBS_DATACFG_CNTR_MASK	GENMASK_ULL(15, 0)
+#define PEBS_DATACFG_FIX_SHIFT	48
+#define PEBS_DATACFG_FIX_MASK	GENMASK_ULL(7, 0)
+#define PEBS_DATACFG_METRICS	BIT_ULL(5)
 
 /* Steal the highest bit of pebs_data_cfg for SW usage */
 #define PEBS_UPDATE_DS_SW	BIT_ULL(63)
@@ -460,6 +466,15 @@ struct pebs_xmm {
 	u64 xmm[16*2];	/* two entries for each register */
 };
 
+struct pebs_cntr_header {
+	u32 cntr;
+	u32 fixed;
+	u32 metrics;
+	u32 reserved;
+};
+
+#define INTEL_CNTR_METRICS		0x3
+
 /*
  * AMD Extended Performance Monitoring and Debug cpuid feature detection
  */

