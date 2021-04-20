Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1635D36568E
	for <lists+linux-tip-commits@lfdr.de>; Tue, 20 Apr 2021 12:46:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231706AbhDTKrT (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Tue, 20 Apr 2021 06:47:19 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:51726 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231661AbhDTKrQ (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Tue, 20 Apr 2021 06:47:16 -0400
Date:   Tue, 20 Apr 2021 10:46:44 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1618915604;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=p4ysjpJFIYGaWxm3m+gdkyZl/o4VL7BiPznEx9keZE0=;
        b=BAnOMxIVX2L9j5HPckcPTNbakmwWWGdsZjT5jDspMgJlPUB2F2t+hbAkojHGvA3Rl4bwWy
        UWpld/y68su/C6qRyXNx9ROd7iEaKSVE1Ps88H4iuB41NklpntAR/aBoNcheblVyRL2Hgu
        X9mbMTpSr0yP0jsV4XSt+0FVxyWa1gTtOu08SohwKUWYrpY2F5mYvlys7YMyYb7/dw2mTw
        yswB0JIFOdvUZv+SGXRBcy84vQAB80I8jA6IURvflifvoA+HUSnF96ClZRCuoafX4FHR3w
        PDEzj15Rum3IGYD0SFsg1KEfmhHi7EKROxGUXbNNQSGv3f9YTxS9/VirG8Zf8w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1618915604;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=p4ysjpJFIYGaWxm3m+gdkyZl/o4VL7BiPznEx9keZE0=;
        b=tuZEfMFLJiSsSBKrsLDh7060fukV8+ehB7nH9PuIiARg/Xo2qG82E0yL2Nx9z9Zo4F2CCj
        2CFaM5QKHG5M/VBA==
From:   "tip-bot2 for Kan Liang" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf/x86: Register hybrid PMUs
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Kan Liang <kan.liang@linux.intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <1618237865-33448-17-git-send-email-kan.liang@linux.intel.com>
References: <1618237865-33448-17-git-send-email-kan.liang@linux.intel.com>
MIME-Version: 1.0
Message-ID: <161891560408.29796.6386885185243495121.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     d9977c43bff895ed49a9d25e1f382b0a98bb271f
Gitweb:        https://git.kernel.org/tip/d9977c43bff895ed49a9d25e1f382b0a98bb271f
Author:        Kan Liang <kan.liang@linux.intel.com>
AuthorDate:    Mon, 12 Apr 2021 07:30:56 -07:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 19 Apr 2021 20:03:27 +02:00

perf/x86: Register hybrid PMUs

Different hybrid PMUs have different PMU capabilities and events. Perf
should registers a dedicated PMU for each of them.

To check the X86 event, perf has to go through all possible hybrid pmus.

All the hybrid PMUs are registered at boot time. Before the
registration, add intel_pmu_check_hybrid_pmus() to check and update the
counters information, the event constraints, the extra registers and the
unique capabilities for each hybrid PMUs.

Postpone the display of the PMU information and HW check to
CPU_STARTING, because the boot CPU is the only online CPU in the
init_hw_perf_events(). Perf doesn't know the availability of the other
PMUs. Perf should display the PMU information only if the counters of
the PMU are available.

One type of CPUs may be all offline. For this case, users can still
observe the PMU in /sys/devices, but its CPU mask is 0.

All hybrid PMUs have capability PERF_PMU_CAP_HETEROGENEOUS_CPUS.
The PMU name for hybrid PMUs will be "cpu_XXX", which will be assigned
later in a separated patch.

The PMU type id for the core PMU is still PERF_TYPE_RAW. For the other
hybrid PMUs, the PMU type id is not hard code.

The event->cpu must be compatitable with the supported CPUs of the PMU.
Add a check in the x86_pmu_event_init().

The events in a group must be from the same type of hybrid PMU.
The fake cpuc used in the validation must be from the supported CPU of
the event->pmu.

Perf may not retrieve a valid core type from get_this_hybrid_cpu_type().
For example, ADL may have an alternative configuration. With that
configuration, Perf cannot retrieve the core type from the CPUID leaf
0x1a. Add a platform specific get_hybrid_cpu_type(). If the generic way
fails, invoke the platform specific get_hybrid_cpu_type().

Suggested-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/1618237865-33448-17-git-send-email-kan.liang@linux.intel.com
---
 arch/x86/events/core.c       | 137 +++++++++++++++++++++++++++++-----
 arch/x86/events/intel/core.c |  93 ++++++++++++++++++++++-
 arch/x86/events/perf_event.h |  14 +++-
 3 files changed, 223 insertions(+), 21 deletions(-)

diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
index 2e7ae52..bd465a8 100644
--- a/arch/x86/events/core.c
+++ b/arch/x86/events/core.c
@@ -478,7 +478,7 @@ int x86_setup_perfctr(struct perf_event *event)
 		local64_set(&hwc->period_left, hwc->sample_period);
 	}
 
-	if (attr->type == PERF_TYPE_RAW)
+	if (attr->type == event->pmu->type)
 		return x86_pmu_extra_regs(event->attr.config, event);
 
 	if (attr->type == PERF_TYPE_HW_CACHE)
@@ -613,7 +613,7 @@ int x86_pmu_hw_config(struct perf_event *event)
 	if (!event->attr.exclude_kernel)
 		event->hw.config |= ARCH_PERFMON_EVENTSEL_OS;
 
-	if (event->attr.type == PERF_TYPE_RAW)
+	if (event->attr.type == event->pmu->type)
 		event->hw.config |= event->attr.config & X86_RAW_EVENT_MASK;
 
 	if (event->attr.sample_period && x86_pmu.limit_period) {
@@ -742,7 +742,17 @@ void x86_pmu_enable_all(int added)
 
 static inline int is_x86_event(struct perf_event *event)
 {
-	return event->pmu == &pmu;
+	int i;
+
+	if (!is_hybrid())
+		return event->pmu == &pmu;
+
+	for (i = 0; i < x86_pmu.num_hybrid_pmus; i++) {
+		if (event->pmu == &x86_pmu.hybrid_pmu[i].pmu)
+			return true;
+	}
+
+	return false;
 }
 
 struct pmu *x86_get_pmu(unsigned int cpu)
@@ -1990,6 +2000,23 @@ void x86_pmu_show_pmu_cap(int num_counters, int num_counters_fixed,
 	pr_info("... event mask:             %016Lx\n", intel_ctrl);
 }
 
+/*
+ * The generic code is not hybrid friendly. The hybrid_pmu->pmu
+ * of the first registered PMU is unconditionally assigned to
+ * each possible cpuctx->ctx.pmu.
+ * Update the correct hybrid PMU to the cpuctx->ctx.pmu.
+ */
+void x86_pmu_update_cpu_context(struct pmu *pmu, int cpu)
+{
+	struct perf_cpu_context *cpuctx;
+
+	if (!pmu->pmu_cpu_context)
+		return;
+
+	cpuctx = per_cpu_ptr(pmu->pmu_cpu_context, cpu);
+	cpuctx->ctx.pmu = pmu;
+}
+
 static int __init init_hw_perf_events(void)
 {
 	struct x86_pmu_quirk *quirk;
@@ -2050,8 +2077,11 @@ static int __init init_hw_perf_events(void)
 
 	pmu.attr_update = x86_pmu.attr_update;
 
-	x86_pmu_show_pmu_cap(x86_pmu.num_counters, x86_pmu.num_counters_fixed,
-			     x86_pmu.intel_ctrl);
+	if (!is_hybrid()) {
+		x86_pmu_show_pmu_cap(x86_pmu.num_counters,
+				     x86_pmu.num_counters_fixed,
+				     x86_pmu.intel_ctrl);
+	}
 
 	if (!x86_pmu.read)
 		x86_pmu.read = _x86_pmu_read;
@@ -2081,9 +2111,45 @@ static int __init init_hw_perf_events(void)
 	if (err)
 		goto out1;
 
-	err = perf_pmu_register(&pmu, "cpu", PERF_TYPE_RAW);
-	if (err)
-		goto out2;
+	if (!is_hybrid()) {
+		err = perf_pmu_register(&pmu, "cpu", PERF_TYPE_RAW);
+		if (err)
+			goto out2;
+	} else {
+		u8 cpu_type = get_this_hybrid_cpu_type();
+		struct x86_hybrid_pmu *hybrid_pmu;
+		int i, j;
+
+		if (!cpu_type && x86_pmu.get_hybrid_cpu_type)
+			cpu_type = x86_pmu.get_hybrid_cpu_type();
+
+		for (i = 0; i < x86_pmu.num_hybrid_pmus; i++) {
+			hybrid_pmu = &x86_pmu.hybrid_pmu[i];
+
+			hybrid_pmu->pmu = pmu;
+			hybrid_pmu->pmu.type = -1;
+			hybrid_pmu->pmu.attr_update = x86_pmu.attr_update;
+			hybrid_pmu->pmu.capabilities |= PERF_PMU_CAP_HETEROGENEOUS_CPUS;
+
+			err = perf_pmu_register(&hybrid_pmu->pmu, hybrid_pmu->name,
+						(hybrid_pmu->cpu_type == hybrid_big) ? PERF_TYPE_RAW : -1);
+			if (err)
+				break;
+
+			if (cpu_type == hybrid_pmu->cpu_type)
+				x86_pmu_update_cpu_context(&hybrid_pmu->pmu, raw_smp_processor_id());
+		}
+
+		if (i < x86_pmu.num_hybrid_pmus) {
+			for (j = 0; j < i; j++)
+				perf_pmu_unregister(&x86_pmu.hybrid_pmu[j].pmu);
+			pr_warn("Failed to register hybrid PMUs\n");
+			kfree(x86_pmu.hybrid_pmu);
+			x86_pmu.hybrid_pmu = NULL;
+			x86_pmu.num_hybrid_pmus = 0;
+			goto out2;
+		}
+	}
 
 	return 0;
 
@@ -2208,16 +2274,27 @@ static void free_fake_cpuc(struct cpu_hw_events *cpuc)
 	kfree(cpuc);
 }
 
-static struct cpu_hw_events *allocate_fake_cpuc(void)
+static struct cpu_hw_events *allocate_fake_cpuc(struct pmu *event_pmu)
 {
 	struct cpu_hw_events *cpuc;
-	int cpu = raw_smp_processor_id();
+	int cpu;
 
 	cpuc = kzalloc(sizeof(*cpuc), GFP_KERNEL);
 	if (!cpuc)
 		return ERR_PTR(-ENOMEM);
 	cpuc->is_fake = 1;
 
+	if (is_hybrid()) {
+		struct x86_hybrid_pmu *h_pmu;
+
+		h_pmu = hybrid_pmu(event_pmu);
+		if (cpumask_empty(&h_pmu->supported_cpus))
+			goto error;
+		cpu = cpumask_first(&h_pmu->supported_cpus);
+	} else
+		cpu = raw_smp_processor_id();
+	cpuc->pmu = event_pmu;
+
 	if (intel_cpuc_prepare(cpuc, cpu))
 		goto error;
 
@@ -2236,7 +2313,7 @@ static int validate_event(struct perf_event *event)
 	struct event_constraint *c;
 	int ret = 0;
 
-	fake_cpuc = allocate_fake_cpuc();
+	fake_cpuc = allocate_fake_cpuc(event->pmu);
 	if (IS_ERR(fake_cpuc))
 		return PTR_ERR(fake_cpuc);
 
@@ -2270,7 +2347,27 @@ static int validate_group(struct perf_event *event)
 	struct cpu_hw_events *fake_cpuc;
 	int ret = -EINVAL, n;
 
-	fake_cpuc = allocate_fake_cpuc();
+	/*
+	 * Reject events from different hybrid PMUs.
+	 */
+	if (is_hybrid()) {
+		struct perf_event *sibling;
+		struct pmu *pmu = NULL;
+
+		if (is_x86_event(leader))
+			pmu = leader->pmu;
+
+		for_each_sibling_event(sibling, leader) {
+			if (!is_x86_event(sibling))
+				continue;
+			if (!pmu)
+				pmu = sibling->pmu;
+			else if (pmu != sibling->pmu)
+				return ret;
+		}
+	}
+
+	fake_cpuc = allocate_fake_cpuc(event->pmu);
 	if (IS_ERR(fake_cpuc))
 		return PTR_ERR(fake_cpuc);
 	/*
@@ -2298,16 +2395,18 @@ out:
 
 static int x86_pmu_event_init(struct perf_event *event)
 {
+	struct x86_hybrid_pmu *pmu = NULL;
 	int err;
 
-	switch (event->attr.type) {
-	case PERF_TYPE_RAW:
-	case PERF_TYPE_HARDWARE:
-	case PERF_TYPE_HW_CACHE:
-		break;
-
-	default:
+	if ((event->attr.type != event->pmu->type) &&
+	    (event->attr.type != PERF_TYPE_HARDWARE) &&
+	    (event->attr.type != PERF_TYPE_HW_CACHE))
 		return -ENOENT;
+
+	if (is_hybrid() && (event->cpu != -1)) {
+		pmu = hybrid_pmu(event->pmu);
+		if (!cpumask_test_cpu(event->cpu, &pmu->supported_cpus))
+			return -ENOENT;
 	}
 
 	err = __x86_pmu_event_init(event);
diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index 55ccfbb..4881209 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -3714,7 +3714,8 @@ static int intel_pmu_hw_config(struct perf_event *event)
 		event->hw.flags |= PERF_X86_EVENT_PEBS_VIA_PT;
 	}
 
-	if (event->attr.type != PERF_TYPE_RAW)
+	if ((event->attr.type == PERF_TYPE_HARDWARE) ||
+	    (event->attr.type == PERF_TYPE_HW_CACHE))
 		return 0;
 
 	/*
@@ -4212,12 +4213,62 @@ static void flip_smm_bit(void *data)
 	}
 }
 
+static bool init_hybrid_pmu(int cpu)
+{
+	struct cpu_hw_events *cpuc = &per_cpu(cpu_hw_events, cpu);
+	u8 cpu_type = get_this_hybrid_cpu_type();
+	struct x86_hybrid_pmu *pmu = NULL;
+	int i;
+
+	if (!cpu_type && x86_pmu.get_hybrid_cpu_type)
+		cpu_type = x86_pmu.get_hybrid_cpu_type();
+
+	for (i = 0; i < x86_pmu.num_hybrid_pmus; i++) {
+		if (x86_pmu.hybrid_pmu[i].cpu_type == cpu_type) {
+			pmu = &x86_pmu.hybrid_pmu[i];
+			break;
+		}
+	}
+	if (WARN_ON_ONCE(!pmu || (pmu->pmu.type == -1))) {
+		cpuc->pmu = NULL;
+		return false;
+	}
+
+	/* Only check and dump the PMU information for the first CPU */
+	if (!cpumask_empty(&pmu->supported_cpus))
+		goto end;
+
+	if (!check_hw_exists(&pmu->pmu, pmu->num_counters, pmu->num_counters_fixed))
+		return false;
+
+	pr_info("%s PMU driver: ", pmu->name);
+
+	if (pmu->intel_cap.pebs_output_pt_available)
+		pr_cont("PEBS-via-PT ");
+
+	pr_cont("\n");
+
+	x86_pmu_show_pmu_cap(pmu->num_counters, pmu->num_counters_fixed,
+			     pmu->intel_ctrl);
+
+end:
+	cpumask_set_cpu(cpu, &pmu->supported_cpus);
+	cpuc->pmu = &pmu->pmu;
+
+	x86_pmu_update_cpu_context(&pmu->pmu, cpu);
+
+	return true;
+}
+
 static void intel_pmu_cpu_starting(int cpu)
 {
 	struct cpu_hw_events *cpuc = &per_cpu(cpu_hw_events, cpu);
 	int core_id = topology_core_id(cpu);
 	int i;
 
+	if (is_hybrid() && !init_hybrid_pmu(cpu))
+		return;
+
 	init_debug_store_on_cpu(cpu);
 	/*
 	 * Deal with CPUs that don't clear their LBRs on power-up.
@@ -4331,7 +4382,12 @@ void intel_cpuc_finish(struct cpu_hw_events *cpuc)
 
 static void intel_pmu_cpu_dead(int cpu)
 {
-	intel_cpuc_finish(&per_cpu(cpu_hw_events, cpu));
+	struct cpu_hw_events *cpuc = &per_cpu(cpu_hw_events, cpu);
+
+	intel_cpuc_finish(cpuc);
+
+	if (is_hybrid() && cpuc->pmu)
+		cpumask_clear_cpu(cpu, &hybrid_pmu(cpuc->pmu)->supported_cpus);
 }
 
 static void intel_pmu_sched_task(struct perf_event_context *ctx,
@@ -5147,6 +5203,36 @@ static void intel_pmu_check_extra_regs(struct extra_reg *extra_regs)
 	}
 }
 
+static void intel_pmu_check_hybrid_pmus(u64 fixed_mask)
+{
+	struct x86_hybrid_pmu *pmu;
+	int i;
+
+	for (i = 0; i < x86_pmu.num_hybrid_pmus; i++) {
+		pmu = &x86_pmu.hybrid_pmu[i];
+
+		intel_pmu_check_num_counters(&pmu->num_counters,
+					     &pmu->num_counters_fixed,
+					     &pmu->intel_ctrl,
+					     fixed_mask);
+
+		if (pmu->intel_cap.perf_metrics) {
+			pmu->intel_ctrl |= 1ULL << GLOBAL_CTRL_EN_PERF_METRICS;
+			pmu->intel_ctrl |= INTEL_PMC_MSK_FIXED_SLOTS;
+		}
+
+		if (pmu->intel_cap.pebs_output_pt_available)
+			pmu->pmu.capabilities |= PERF_PMU_CAP_AUX_OUTPUT;
+
+		intel_pmu_check_event_constraints(pmu->event_constraints,
+						  pmu->num_counters,
+						  pmu->num_counters_fixed,
+						  pmu->intel_ctrl);
+
+		intel_pmu_check_extra_regs(pmu->extra_regs);
+	}
+}
+
 __init int intel_pmu_init(void)
 {
 	struct attribute **extra_skl_attr = &empty_attrs;
@@ -5826,6 +5912,9 @@ __init int intel_pmu_init(void)
 	if (!is_hybrid() && x86_pmu.intel_cap.perf_metrics)
 		x86_pmu.intel_ctrl |= 1ULL << GLOBAL_CTRL_EN_PERF_METRICS;
 
+	if (is_hybrid())
+		intel_pmu_check_hybrid_pmus((u64)fixed_mask);
+
 	return 0;
 }
 
diff --git a/arch/x86/events/perf_event.h b/arch/x86/events/perf_event.h
index a3534e3..4282ce4 100644
--- a/arch/x86/events/perf_event.h
+++ b/arch/x86/events/perf_event.h
@@ -15,6 +15,7 @@
 #include <linux/perf_event.h>
 
 #include <asm/intel_ds.h>
+#include <asm/cpu.h>
 
 /* To enable MSR tracing please use the generic trace points. */
 
@@ -633,6 +634,9 @@ enum {
 
 struct x86_hybrid_pmu {
 	struct pmu			pmu;
+	const char			*name;
+	u8				cpu_type;
+	cpumask_t			supported_cpus;
 	union perf_capabilities		intel_cap;
 	u64				intel_ctrl;
 	int				max_pebs_events;
@@ -681,6 +685,13 @@ extern struct static_key_false perf_is_hybrid;
 	__Fp;						\
 }))
 
+enum hybrid_pmu_type {
+	hybrid_big		= 0x40,
+	hybrid_small		= 0x20,
+
+	hybrid_big_small	= hybrid_big | hybrid_small,
+};
+
 /*
  * struct x86_pmu - generic x86 pmu
  */
@@ -878,6 +889,7 @@ struct x86_pmu {
 	 */
 	int				num_hybrid_pmus;
 	struct x86_hybrid_pmu		*hybrid_pmu;
+	u8 (*get_hybrid_cpu_type)	(void);
 };
 
 struct x86_perf_task_context_opt {
@@ -1095,6 +1107,8 @@ int x86_pmu_handle_irq(struct pt_regs *regs);
 void x86_pmu_show_pmu_cap(int num_counters, int num_counters_fixed,
 			  u64 intel_ctrl);
 
+void x86_pmu_update_cpu_context(struct pmu *pmu, int cpu);
+
 extern struct event_constraint emptyconstraint;
 
 extern struct event_constraint unconstrained;
