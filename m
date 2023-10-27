Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13C4A7D9983
	for <lists+linux-tip-commits@lfdr.de>; Fri, 27 Oct 2023 15:17:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345876AbjJ0NQ7 (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 27 Oct 2023 09:16:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345862AbjJ0NQ5 (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 27 Oct 2023 09:16:57 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17CF5128;
        Fri, 27 Oct 2023 06:16:53 -0700 (PDT)
Date:   Fri, 27 Oct 2023 13:16:49 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1698412610;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FDCzBuStnZr609VODpwW+guWhIdi7WygYFyRzreDze0=;
        b=FSCJbn4e41WZoAtBkW6aY/xGm9oMhFx+bNuI42OuR0XrP7XoN1fhnCHQI/F+qWjvZXTurm
        TF1SvFbuf0DamDDdxjp1UO1iAH40l0aD4zIZAeOsdZ76l7Q2BWcbLRTKGPfvqrZ6Su9ALe
        SHciuTfxhQjCTucCZdcc3TqNMBgx6jMPF4Kcg8AD7T+hcCz9cjnGLtvEGxVyVc0d1H8Vgp
        OWTO4/ba3o0ECgYkxtOnLqmIlQGtuJVz61MOANFjUNH4UgXG598+9odZIGGU8/QGzdMthv
        6JMjinXH/jFNKo9Z0LME5ncx2/b/Ks5w2LGVRAUtaViGf3pJWwrrO9tHfmJdkg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1698412610;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FDCzBuStnZr609VODpwW+guWhIdi7WygYFyRzreDze0=;
        b=IX4fFBRwqEbDl8IsUGdeYbLOvGrpzPkfsoxece1sCqtxA1v3PohAbViGrjdbHSSdwld0Ky
        aF0kb5nEqxZxNKCQ==
From:   "tip-bot2 for Kan Liang" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf/x86/intel: Support branch counters logging
Cc:     Kan Liang <kan.liang@linux.intel.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20231025201626.3000228-5-kan.liang@linux.intel.com>
References: <20231025201626.3000228-5-kan.liang@linux.intel.com>
MIME-Version: 1.0
Message-ID: <169841260936.3135.2817324035504724523.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     33744916196b4ed7a50f6f47af7c3ad46b730ce6
Gitweb:        https://git.kernel.org/tip/33744916196b4ed7a50f6f47af7c3ad46b730ce6
Author:        Kan Liang <kan.liang@linux.intel.com>
AuthorDate:    Wed, 25 Oct 2023 13:16:23 -07:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 27 Oct 2023 15:05:11 +02:00

perf/x86/intel: Support branch counters logging

The branch counters logging (A.K.A LBR event logging) introduces a
per-counter indication of precise event occurrences in LBRs. It can
provide a means to attribute exposed retirement latency to combinations
of events across a block of instructions. It also provides a means of
attributing Timed LBR latencies to events.

The feature is first introduced on SRF/GRR. It is an enhancement of the
ARCH LBR. It adds new fields in the LBR_INFO MSRs to log the occurrences
of events on the GP counters. The information is displayed by the order
of counters.

The design proposed in this patch requires that the events which are
logged must be in a group with the event that has LBR. If there are
more than one LBR group, the counters logging information only from the
current group (overflowed) are stored for the perf tool, otherwise the
perf tool cannot know which and when other groups are scheduled
especially when multiplexing is triggered. The user can ensure it uses
the maximum number of counters that support LBR info (4 by now) by
making the group large enough.

The HW only logs events by the order of counters. The order may be
different from the order of enabling which the perf tool can understand.
When parsing the information of each branch entry, convert the counter
order to the enabled order, and store the enabled order in the extension
space.

Unconditionally reset LBRs for an LBR event group when it's deleted. The
logged counter information is only valid for the current LBR group. If
another LBR group is scheduled later, the information from the stale
LBRs would be otherwise wrongly interpreted.

Add a sanity check in intel_pmu_hw_config(). Disable the feature if other
counter filters (inv, cmask, edge, in_tx) are set or LBR call stack mode
is enabled. (For the LBR call stack mode, we cannot simply flush the
LBR, since it will break the call stack. Also, there is no obvious usage
with the call stack mode for now.)

Only applying the PERF_SAMPLE_BRANCH_COUNTERS doesn't require any branch
stack setup.

Expose the maximum number of supported counters and the width of the
counters into the sysfs. The perf tool can use the information to parse
the logged counters in each branch.

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20231025201626.3000228-5-kan.liang@linux.intel.com
---
 arch/x86/events/intel/core.c       | 103 ++++++++++++++++++++++++++--
 arch/x86/events/intel/ds.c         |   2 +-
 arch/x86/events/intel/lbr.c        |  85 ++++++++++++++++++++++-
 arch/x86/events/perf_event.h       |  12 +++-
 arch/x86/events/perf_event_flags.h |   1 +-
 arch/x86/include/asm/msr-index.h   |   5 +-
 arch/x86/include/asm/perf_event.h  |   4 +-
 include/uapi/linux/perf_event.h    |   3 +-
 8 files changed, 207 insertions(+), 8 deletions(-)

diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index 584b58d..e068a96 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -2792,6 +2792,7 @@ static void intel_pmu_enable_fixed(struct perf_event *event)
 
 static void intel_pmu_enable_event(struct perf_event *event)
 {
+	u64 enable_mask = ARCH_PERFMON_EVENTSEL_ENABLE;
 	struct hw_perf_event *hwc = &event->hw;
 	int idx = hwc->idx;
 
@@ -2800,8 +2801,10 @@ static void intel_pmu_enable_event(struct perf_event *event)
 
 	switch (idx) {
 	case 0 ... INTEL_PMC_IDX_FIXED - 1:
+		if (branch_sample_counters(event))
+			enable_mask |= ARCH_PERFMON_EVENTSEL_BR_CNTR;
 		intel_set_masks(event, idx);
-		__x86_pmu_enable_event(hwc, ARCH_PERFMON_EVENTSEL_ENABLE);
+		__x86_pmu_enable_event(hwc, enable_mask);
 		break;
 	case INTEL_PMC_IDX_FIXED ... INTEL_PMC_IDX_FIXED_BTS - 1:
 	case INTEL_PMC_IDX_METRIC_BASE ... INTEL_PMC_IDX_METRIC_END:
@@ -3052,7 +3055,7 @@ static int handle_pmi_common(struct pt_regs *regs, u64 status)
 		perf_sample_data_init(&data, 0, event->hw.last_period);
 
 		if (has_branch_stack(event))
-			perf_sample_save_brstack(&data, event, &cpuc->lbr_stack, NULL);
+			intel_pmu_lbr_save_brstack(&data, cpuc, event);
 
 		if (perf_event_overflow(event, &data, regs))
 			x86_pmu_stop(event, 0);
@@ -3617,6 +3620,13 @@ intel_get_event_constraints(struct cpu_hw_events *cpuc, int idx,
 	if (cpuc->excl_cntrs)
 		return intel_get_excl_constraints(cpuc, event, idx, c2);
 
+	/* Not all counters support the branch counter feature. */
+	if (branch_sample_counters(event)) {
+		c2 = dyn_constraint(cpuc, c2, idx);
+		c2->idxmsk64 &= x86_pmu.lbr_counters;
+		c2->weight = hweight64(c2->idxmsk64);
+	}
+
 	return c2;
 }
 
@@ -3905,6 +3915,58 @@ static int intel_pmu_hw_config(struct perf_event *event)
 	if (needs_branch_stack(event) && is_sampling_event(event))
 		event->hw.flags  |= PERF_X86_EVENT_NEEDS_BRANCH_STACK;
 
+	if (branch_sample_counters(event)) {
+		struct perf_event *leader, *sibling;
+		int num = 0;
+
+		if (!(x86_pmu.flags & PMU_FL_BR_CNTR) ||
+		    (event->attr.config & ~INTEL_ARCH_EVENT_MASK))
+			return -EINVAL;
+
+		/*
+		 * The branch counter logging is not supported in the call stack
+		 * mode yet, since we cannot simply flush the LBR during e.g.,
+		 * multiplexing. Also, there is no obvious usage with the call
+		 * stack mode. Simply forbids it for now.
+		 *
+		 * If any events in the group enable the branch counter logging
+		 * feature, the group is treated as a branch counter logging
+		 * group, which requires the extra space to store the counters.
+		 */
+		leader = event->group_leader;
+		if (branch_sample_call_stack(leader))
+			return -EINVAL;
+		if (branch_sample_counters(leader))
+			num++;
+		leader->hw.flags |= PERF_X86_EVENT_BRANCH_COUNTERS;
+
+		for_each_sibling_event(sibling, leader) {
+			if (branch_sample_call_stack(sibling))
+				return -EINVAL;
+			if (branch_sample_counters(sibling))
+				num++;
+		}
+
+		if (num > fls(x86_pmu.lbr_counters))
+			return -EINVAL;
+		/*
+		 * Only applying the PERF_SAMPLE_BRANCH_COUNTERS doesn't
+		 * require any branch stack setup.
+		 * Clear the bit to avoid unnecessary branch stack setup.
+		 */
+		if (0 == (event->attr.branch_sample_type &
+			  ~(PERF_SAMPLE_BRANCH_PLM_ALL |
+			    PERF_SAMPLE_BRANCH_COUNTERS)))
+			event->hw.flags  &= ~PERF_X86_EVENT_NEEDS_BRANCH_STACK;
+
+		/*
+		 * Force the leader to be a LBR event. So LBRs can be reset
+		 * with the leader event. See intel_pmu_lbr_del() for details.
+		 */
+		if (!intel_pmu_needs_branch_stack(leader))
+			return -EINVAL;
+	}
+
 	if (intel_pmu_needs_branch_stack(event)) {
 		ret = intel_pmu_setup_lbr_filter(event);
 		if (ret)
@@ -4383,8 +4445,13 @@ cmt_get_event_constraints(struct cpu_hw_events *cpuc, int idx,
 	 */
 	if (event->attr.precise_ip == 3) {
 		/* Force instruction:ppp on PMC0, 1 and Fixed counter 0 */
-		if (constraint_match(&fixed0_constraint, event->hw.config))
-			return &fixed0_counter0_1_constraint;
+		if (constraint_match(&fixed0_constraint, event->hw.config)) {
+			/* The fixed counter 0 doesn't support LBR event logging. */
+			if (branch_sample_counters(event))
+				return &counter0_1_constraint;
+			else
+				return &fixed0_counter0_1_constraint;
+		}
 
 		switch (c->idxmsk64 & 0x3ull) {
 		case 0x1:
@@ -4563,7 +4630,7 @@ int intel_cpuc_prepare(struct cpu_hw_events *cpuc, int cpu)
 			goto err;
 	}
 
-	if (x86_pmu.flags & (PMU_FL_EXCL_CNTRS | PMU_FL_TFA)) {
+	if (x86_pmu.flags & (PMU_FL_EXCL_CNTRS | PMU_FL_TFA | PMU_FL_BR_CNTR)) {
 		size_t sz = X86_PMC_IDX_MAX * sizeof(struct event_constraint);
 
 		cpuc->constraint_list = kzalloc_node(sz, GFP_KERNEL, cpu_to_node(cpu));
@@ -5535,15 +5602,39 @@ static ssize_t branches_show(struct device *cdev,
 
 static DEVICE_ATTR_RO(branches);
 
+static ssize_t branch_counter_nr_show(struct device *cdev,
+				      struct device_attribute *attr,
+				      char *buf)
+{
+	return snprintf(buf, PAGE_SIZE, "%d\n", fls(x86_pmu.lbr_counters));
+}
+
+static DEVICE_ATTR_RO(branch_counter_nr);
+
+static ssize_t branch_counter_width_show(struct device *cdev,
+					 struct device_attribute *attr,
+					 char *buf)
+{
+	return snprintf(buf, PAGE_SIZE, "%d\n", LBR_INFO_BR_CNTR_BITS);
+}
+
+static DEVICE_ATTR_RO(branch_counter_width);
+
 static struct attribute *lbr_attrs[] = {
 	&dev_attr_branches.attr,
+	&dev_attr_branch_counter_nr.attr,
+	&dev_attr_branch_counter_width.attr,
 	NULL
 };
 
 static umode_t
 lbr_is_visible(struct kobject *kobj, struct attribute *attr, int i)
 {
-	return x86_pmu.lbr_nr ? attr->mode : 0;
+	/* branches */
+	if (i == 0)
+		return x86_pmu.lbr_nr ? attr->mode : 0;
+
+	return (x86_pmu.flags & PMU_FL_BR_CNTR) ? attr->mode : 0;
 }
 
 static char pmu_name_str[30];
diff --git a/arch/x86/events/intel/ds.c b/arch/x86/events/intel/ds.c
index cb3f329..d49d661 100644
--- a/arch/x86/events/intel/ds.c
+++ b/arch/x86/events/intel/ds.c
@@ -1912,7 +1912,7 @@ static void setup_pebs_adaptive_sample_data(struct perf_event *event,
 
 		if (has_branch_stack(event)) {
 			intel_pmu_store_pebs_lbrs(lbr);
-			perf_sample_save_brstack(data, event, &cpuc->lbr_stack, NULL);
+			intel_pmu_lbr_save_brstack(data, cpuc, event);
 		}
 	}
 
diff --git a/arch/x86/events/intel/lbr.c b/arch/x86/events/intel/lbr.c
index c3b0d15..78cd508 100644
--- a/arch/x86/events/intel/lbr.c
+++ b/arch/x86/events/intel/lbr.c
@@ -676,6 +676,25 @@ void intel_pmu_lbr_del(struct perf_event *event)
 	WARN_ON_ONCE(cpuc->lbr_users < 0);
 	WARN_ON_ONCE(cpuc->lbr_pebs_users < 0);
 	perf_sched_cb_dec(event->pmu);
+
+	/*
+	 * The logged occurrences information is only valid for the
+	 * current LBR group. If another LBR group is scheduled in
+	 * later, the information from the stale LBRs will be wrongly
+	 * interpreted. Reset the LBRs here.
+	 *
+	 * Only clear once for a branch counter group with the leader
+	 * event. Because
+	 * - Cannot simply reset the LBRs with the !cpuc->lbr_users.
+	 *   Because it's possible that the last LBR user is not in a
+	 *   branch counter group, e.g., a branch_counters group +
+	 *   several normal LBR events.
+	 * - The LBR reset can be done with any one of the events in a
+	 *   branch counter group, since they are always scheduled together.
+	 *   It's easy to force the leader event an LBR event.
+	 */
+	if (is_branch_counters_group(event) && event == event->group_leader)
+		intel_pmu_lbr_reset();
 }
 
 static inline bool vlbr_exclude_host(void)
@@ -866,6 +885,8 @@ static __always_inline u16 get_lbr_cycles(u64 info)
 	return cycles;
 }
 
+static_assert((64 - PERF_BRANCH_ENTRY_INFO_BITS_MAX) > LBR_INFO_BR_CNTR_NUM * LBR_INFO_BR_CNTR_BITS);
+
 static void intel_pmu_store_lbr(struct cpu_hw_events *cpuc,
 				struct lbr_entry *entries)
 {
@@ -898,11 +919,67 @@ static void intel_pmu_store_lbr(struct cpu_hw_events *cpuc,
 		e->abort	= !!(info & LBR_INFO_ABORT);
 		e->cycles	= get_lbr_cycles(info);
 		e->type		= get_lbr_br_type(info);
+
+		/*
+		 * Leverage the reserved field of cpuc->lbr_entries[i] to
+		 * temporarily store the branch counters information.
+		 * The later code will decide what content can be disclosed
+		 * to the perf tool. Pleae see intel_pmu_lbr_counters_reorder().
+		 */
+		e->reserved	= (info >> LBR_INFO_BR_CNTR_OFFSET) & LBR_INFO_BR_CNTR_FULL_MASK;
 	}
 
 	cpuc->lbr_stack.nr = i;
 }
 
+/*
+ * The enabled order may be different from the counter order.
+ * Update the lbr_counters with the enabled order.
+ */
+static void intel_pmu_lbr_counters_reorder(struct cpu_hw_events *cpuc,
+					   struct perf_event *event)
+{
+	int i, j, pos = 0, order[X86_PMC_IDX_MAX];
+	struct perf_event *leader, *sibling;
+	u64 src, dst, cnt;
+
+	leader = event->group_leader;
+	if (branch_sample_counters(leader))
+		order[pos++] = leader->hw.idx;
+
+	for_each_sibling_event(sibling, leader) {
+		if (!branch_sample_counters(sibling))
+			continue;
+		order[pos++] = sibling->hw.idx;
+	}
+
+	WARN_ON_ONCE(!pos);
+
+	for (i = 0; i < cpuc->lbr_stack.nr; i++) {
+		src = cpuc->lbr_entries[i].reserved;
+		dst = 0;
+		for (j = 0; j < pos; j++) {
+			cnt = (src >> (order[j] * LBR_INFO_BR_CNTR_BITS)) & LBR_INFO_BR_CNTR_MASK;
+			dst |= cnt << j * LBR_INFO_BR_CNTR_BITS;
+		}
+		cpuc->lbr_counters[i] = dst;
+		cpuc->lbr_entries[i].reserved = 0;
+	}
+}
+
+void intel_pmu_lbr_save_brstack(struct perf_sample_data *data,
+				struct cpu_hw_events *cpuc,
+				struct perf_event *event)
+{
+	if (is_branch_counters_group(event)) {
+		intel_pmu_lbr_counters_reorder(cpuc, event);
+		perf_sample_save_brstack(data, event, &cpuc->lbr_stack, cpuc->lbr_counters);
+		return;
+	}
+
+	perf_sample_save_brstack(data, event, &cpuc->lbr_stack, NULL);
+}
+
 static void intel_pmu_arch_lbr_read(struct cpu_hw_events *cpuc)
 {
 	intel_pmu_store_lbr(cpuc, NULL);
@@ -1173,8 +1250,10 @@ intel_pmu_lbr_filter(struct cpu_hw_events *cpuc)
 	for (i = 0; i < cpuc->lbr_stack.nr; ) {
 		if (!cpuc->lbr_entries[i].from) {
 			j = i;
-			while (++j < cpuc->lbr_stack.nr)
+			while (++j < cpuc->lbr_stack.nr) {
 				cpuc->lbr_entries[j-1] = cpuc->lbr_entries[j];
+				cpuc->lbr_counters[j-1] = cpuc->lbr_counters[j];
+			}
 			cpuc->lbr_stack.nr--;
 			if (!cpuc->lbr_entries[i].from)
 				continue;
@@ -1525,8 +1604,12 @@ void __init intel_pmu_arch_lbr_init(void)
 	x86_pmu.lbr_mispred = ecx.split.lbr_mispred;
 	x86_pmu.lbr_timed_lbr = ecx.split.lbr_timed_lbr;
 	x86_pmu.lbr_br_type = ecx.split.lbr_br_type;
+	x86_pmu.lbr_counters = ecx.split.lbr_counters;
 	x86_pmu.lbr_nr = lbr_nr;
 
+	if (!!x86_pmu.lbr_counters)
+		x86_pmu.flags |= PMU_FL_BR_CNTR;
+
 	if (x86_pmu.lbr_mispred)
 		static_branch_enable(&x86_lbr_mispred);
 	if (x86_pmu.lbr_timed_lbr)
diff --git a/arch/x86/events/perf_event.h b/arch/x86/events/perf_event.h
index 53dd5d4..fb56518 100644
--- a/arch/x86/events/perf_event.h
+++ b/arch/x86/events/perf_event.h
@@ -110,6 +110,11 @@ static inline bool is_topdown_event(struct perf_event *event)
 	return is_metric_event(event) || is_slots_event(event);
 }
 
+static inline bool is_branch_counters_group(struct perf_event *event)
+{
+	return event->group_leader->hw.flags & PERF_X86_EVENT_BRANCH_COUNTERS;
+}
+
 struct amd_nb {
 	int nb_id;  /* NorthBridge id */
 	int refcnt; /* reference count */
@@ -283,6 +288,7 @@ struct cpu_hw_events {
 	int				lbr_pebs_users;
 	struct perf_branch_stack	lbr_stack;
 	struct perf_branch_entry	lbr_entries[MAX_LBR_ENTRIES];
+	u64				lbr_counters[MAX_LBR_ENTRIES]; /* branch stack extra */
 	union {
 		struct er_account		*lbr_sel;
 		struct er_account		*lbr_ctl;
@@ -888,6 +894,7 @@ struct x86_pmu {
 	unsigned int	lbr_mispred:1;
 	unsigned int	lbr_timed_lbr:1;
 	unsigned int	lbr_br_type:1;
+	unsigned int	lbr_counters:4;
 
 	void		(*lbr_reset)(void);
 	void		(*lbr_read)(struct cpu_hw_events *cpuc);
@@ -1012,6 +1019,7 @@ do {									\
 #define PMU_FL_INSTR_LATENCY	0x80 /* Support Instruction Latency in PEBS Memory Info Record */
 #define PMU_FL_MEM_LOADS_AUX	0x100 /* Require an auxiliary event for the complete memory info */
 #define PMU_FL_RETIRE_LATENCY	0x200 /* Support Retire Latency in PEBS */
+#define PMU_FL_BR_CNTR		0x400 /* Support branch counter logging */
 
 #define EVENT_VAR(_id)  event_attr_##_id
 #define EVENT_PTR(_id) &event_attr_##_id.attr.attr
@@ -1552,6 +1560,10 @@ void intel_pmu_store_pebs_lbrs(struct lbr_entry *lbr);
 
 void intel_ds_init(void);
 
+void intel_pmu_lbr_save_brstack(struct perf_sample_data *data,
+				struct cpu_hw_events *cpuc,
+				struct perf_event *event);
+
 void intel_pmu_lbr_swap_task_ctx(struct perf_event_pmu_context *prev_epc,
 				 struct perf_event_pmu_context *next_epc);
 
diff --git a/arch/x86/events/perf_event_flags.h b/arch/x86/events/perf_event_flags.h
index a168598..6c977c1 100644
--- a/arch/x86/events/perf_event_flags.h
+++ b/arch/x86/events/perf_event_flags.h
@@ -21,3 +21,4 @@ PERF_ARCH(PEBS_STLAT,		0x08000) /* st+stlat data address sampling */
 PERF_ARCH(AMD_BRS,		0x10000) /* AMD Branch Sampling */
 PERF_ARCH(PEBS_LAT_HYBRID,	0x20000) /* ld and st lat for hybrid */
 PERF_ARCH(NEEDS_BRANCH_STACK,	0x40000) /* require branch stack setup */
+PERF_ARCH(BRANCH_COUNTERS,	0x80000) /* logs the counters in the extra space of each branch */
diff --git a/arch/x86/include/asm/msr-index.h b/arch/x86/include/asm/msr-index.h
index f8b5028..a5b0a19 100644
--- a/arch/x86/include/asm/msr-index.h
+++ b/arch/x86/include/asm/msr-index.h
@@ -236,6 +236,11 @@
 #define LBR_INFO_CYCLES			0xffff
 #define LBR_INFO_BR_TYPE_OFFSET		56
 #define LBR_INFO_BR_TYPE		(0xfull << LBR_INFO_BR_TYPE_OFFSET)
+#define LBR_INFO_BR_CNTR_OFFSET		32
+#define LBR_INFO_BR_CNTR_NUM		4
+#define LBR_INFO_BR_CNTR_BITS		2
+#define LBR_INFO_BR_CNTR_MASK		GENMASK_ULL(LBR_INFO_BR_CNTR_BITS - 1, 0)
+#define LBR_INFO_BR_CNTR_FULL_MASK	GENMASK_ULL(LBR_INFO_BR_CNTR_NUM * LBR_INFO_BR_CNTR_BITS - 1, 0)
 
 #define MSR_ARCH_LBR_CTL		0x000014ce
 #define ARCH_LBR_CTL_LBREN		BIT(0)
diff --git a/arch/x86/include/asm/perf_event.h b/arch/x86/include/asm/perf_event.h
index 2618ec7..3736b8a 100644
--- a/arch/x86/include/asm/perf_event.h
+++ b/arch/x86/include/asm/perf_event.h
@@ -31,6 +31,7 @@
 #define ARCH_PERFMON_EVENTSEL_ENABLE			(1ULL << 22)
 #define ARCH_PERFMON_EVENTSEL_INV			(1ULL << 23)
 #define ARCH_PERFMON_EVENTSEL_CMASK			0xFF000000ULL
+#define ARCH_PERFMON_EVENTSEL_BR_CNTR			(1ULL << 35)
 
 #define INTEL_FIXED_BITS_MASK				0xFULL
 #define INTEL_FIXED_BITS_STRIDE			4
@@ -223,6 +224,9 @@ union cpuid28_ecx {
 		unsigned int    lbr_timed_lbr:1;
 		/* Branch Type Field Supported */
 		unsigned int    lbr_br_type:1;
+		unsigned int	reserved:13;
+		/* Branch counters (Event Logging) Supported */
+		unsigned int	lbr_counters:4;
 	} split;
 	unsigned int            full;
 };
diff --git a/include/uapi/linux/perf_event.h b/include/uapi/linux/perf_event.h
index 4461f38..3a64499 100644
--- a/include/uapi/linux/perf_event.h
+++ b/include/uapi/linux/perf_event.h
@@ -1437,6 +1437,9 @@ struct perf_branch_entry {
 		reserved:31;
 };
 
+/* Size of used info bits in struct perf_branch_entry */
+#define PERF_BRANCH_ENTRY_INFO_BITS_MAX		33
+
 union perf_sample_weight {
 	__u64		full;
 #if defined(__LITTLE_ENDIAN_BITFIELD)
