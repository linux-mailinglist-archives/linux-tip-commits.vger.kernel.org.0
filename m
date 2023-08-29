Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5ACF678CCFC
	for <lists+linux-tip-commits@lfdr.de>; Tue, 29 Aug 2023 21:32:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238737AbjH2TcL (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Tue, 29 Aug 2023 15:32:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240399AbjH2Tby (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Tue, 29 Aug 2023 15:31:54 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7665CEC;
        Tue, 29 Aug 2023 12:31:46 -0700 (PDT)
Date:   Tue, 29 Aug 2023 19:31:44 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1693337505;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MdsoUj7+bAg2PGo4GIE6bYGtSOymE/HHQmcTfo85d/E=;
        b=ZL8FH9bIvWXj9fcQpuSGerG1lX+KiXO9zWRqTVbnGyEl4BOTaTcan5tuRa2TCi8y2/9wR7
        MqQxisblQlYiyNnxHbhBJOCi6YpPT1lZQe3uRO+VBGqrp0FVGGuQ39U3B1JRs/G/p5DG19
        0B+7/NMd7LKMi/xrC3/Sv41sAAh+c+i35L/CZfcKx0z73Zm08IPqknCahqQe1ZQMQ4QdEH
        WhvL5+k8JZ+e+8QOIQDsGOjmHH5jr2WFPZWvBMiiNrGWrHjVDgk+zJPPXs3DTHZpk9HI2N
        WSKhgzF28ylsXOIKay5X6LXwRy0cDhMQonmjlKSiH7QcKdaTrgMgQ7MYKGgG1g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1693337505;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MdsoUj7+bAg2PGo4GIE6bYGtSOymE/HHQmcTfo85d/E=;
        b=nHHkZzp1NYgCSqFL5x3ktFlyDF7GyeOOf23P/btNcYdv4wYzpEHE8y9ikw1n5Hw2wyABff
        vBSBnfjBn9vePNCw==
From:   "tip-bot2 for Kan Liang" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf/x86/intel: Clean up the hybrid CPU type handling code
Cc:     Dave Hansen <dave.hansen@linux.intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Ingo Molnar <mingo@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230829125806.3016082-6-kan.liang@linux.intel.com>
References: <20230829125806.3016082-6-kan.liang@linux.intel.com>
MIME-Version: 1.0
Message-ID: <169333750455.27769.1237607997232629210.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     b0560bfd4b70277a4936c82e50e940aa253c95bf
Gitweb:        https://git.kernel.org/tip/b0560bfd4b70277a4936c82e50e940aa253c95bf
Author:        Kan Liang <kan.liang@linux.intel.com>
AuthorDate:    Tue, 29 Aug 2023 05:58:05 -07:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 29 Aug 2023 20:59:23 +02:00

perf/x86/intel: Clean up the hybrid CPU type handling code

There is a fairly long list of grievances about the current code. The
main beefs:

   1. hybrid_big_small assumes that the *HARDWARE* (CPUID) provided
      core types are a bitmap. They are not. If Intel happened to
      make a core type of 0xff, hilarity would ensue.
   2. adl_get_hybrid_cpu_type() utterly inscrutable.  There are
      precisely zero comments and zero changelog about what it is
      attempting to do.

According to Kan, the adl_get_hybrid_cpu_type() is there because some
Alder Lake (ADL) CPUs can do some silly things. Some ADL models are
*supposed* to be hybrid CPUs with big and little cores, but there are
some SKUs that only have big cores. CPUID(0x1a) on those CPUs does
not say that the CPUs are big cores. It apparently just returns 0x0.
It confuses perf because it expects to see either 0x40 (Core) or
0x20 (Atom).

The perf workaround for this is to watch for a CPU core saying it is
type 0x0. If that happens on an Alder Lake, it calls
x86_pmu.get_hybrid_cpu_type() and just assumes that the core is a
Core (0x40) CPU.

To fix up the mess, separate out the CPU types and the 'pmu' types.
This allows 'hybrid_pmu_type' bitmaps without worrying that some
future CPU type will set multiple bits.

Since the types are now separate, add a function to glue them back
together again. Actual comment on the situation in the glue
function (find_hybrid_pmu_for_cpu()).

Also, give ->get_hybrid_cpu_type() a real return type and make it
clear that it is overriding the *CPU* type, not the PMU type.

Rename cpu_type to pmu_type in the struct x86_hybrid_pmu to reflect the
change.

Originally-by: Dave Hansen <dave.hansen@linux.intel.com>
Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/20230829125806.3016082-6-kan.liang@linux.intel.com
---
 arch/x86/events/core.c       |  6 +--
 arch/x86/events/intel/core.c | 69 +++++++++++++++++++++++------------
 arch/x86/events/intel/ds.c   |  2 +-
 arch/x86/events/perf_event.h | 35 ++++++++++--------
 4 files changed, 72 insertions(+), 40 deletions(-)

diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
index 185f902..40ad142 100644
--- a/arch/x86/events/core.c
+++ b/arch/x86/events/core.c
@@ -1887,9 +1887,9 @@ ssize_t events_hybrid_sysfs_show(struct device *dev,
 
 	str = pmu_attr->event_str;
 	for (i = 0; i < x86_pmu.num_hybrid_pmus; i++) {
-		if (!(x86_pmu.hybrid_pmu[i].cpu_type & pmu_attr->pmu_type))
+		if (!(x86_pmu.hybrid_pmu[i].pmu_type & pmu_attr->pmu_type))
 			continue;
-		if (x86_pmu.hybrid_pmu[i].cpu_type & pmu->cpu_type) {
+		if (x86_pmu.hybrid_pmu[i].pmu_type & pmu->pmu_type) {
 			next_str = strchr(str, ';');
 			if (next_str)
 				return snprintf(page, next_str - str + 1, "%s", str);
@@ -2169,7 +2169,7 @@ static int __init init_hw_perf_events(void)
 			hybrid_pmu->pmu.capabilities |= PERF_PMU_CAP_EXTENDED_HW_TYPE;
 
 			err = perf_pmu_register(&hybrid_pmu->pmu, hybrid_pmu->name,
-						(hybrid_pmu->cpu_type == hybrid_big) ? PERF_TYPE_RAW : -1);
+						(hybrid_pmu->pmu_type == hybrid_big) ? PERF_TYPE_RAW : -1);
 			if (err)
 				break;
 		}
diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index a5ba491..9ac2e12 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -3849,7 +3849,7 @@ static inline bool require_mem_loads_aux_event(struct perf_event *event)
 		return false;
 
 	if (is_hybrid())
-		return hybrid_pmu(event->pmu)->cpu_type == hybrid_big;
+		return hybrid_pmu(event->pmu)->pmu_type == hybrid_big;
 
 	return true;
 }
@@ -4341,9 +4341,9 @@ adl_get_event_constraints(struct cpu_hw_events *cpuc, int idx,
 {
 	struct x86_hybrid_pmu *pmu = hybrid_pmu(event->pmu);
 
-	if (pmu->cpu_type == hybrid_big)
+	if (pmu->pmu_type == hybrid_big)
 		return glc_get_event_constraints(cpuc, idx, event);
-	else if (pmu->cpu_type == hybrid_small)
+	else if (pmu->pmu_type == hybrid_small)
 		return tnt_get_event_constraints(cpuc, idx, event);
 
 	WARN_ON(1);
@@ -4413,9 +4413,9 @@ mtl_get_event_constraints(struct cpu_hw_events *cpuc, int idx,
 {
 	struct x86_hybrid_pmu *pmu = hybrid_pmu(event->pmu);
 
-	if (pmu->cpu_type == hybrid_big)
+	if (pmu->pmu_type == hybrid_big)
 		return rwc_get_event_constraints(cpuc, idx, event);
-	if (pmu->cpu_type == hybrid_small)
+	if (pmu->pmu_type == hybrid_small)
 		return cmt_get_event_constraints(cpuc, idx, event);
 
 	WARN_ON(1);
@@ -4426,18 +4426,18 @@ static int adl_hw_config(struct perf_event *event)
 {
 	struct x86_hybrid_pmu *pmu = hybrid_pmu(event->pmu);
 
-	if (pmu->cpu_type == hybrid_big)
+	if (pmu->pmu_type == hybrid_big)
 		return hsw_hw_config(event);
-	else if (pmu->cpu_type == hybrid_small)
+	else if (pmu->pmu_type == hybrid_small)
 		return intel_pmu_hw_config(event);
 
 	WARN_ON(1);
 	return -EOPNOTSUPP;
 }
 
-static u8 adl_get_hybrid_cpu_type(void)
+static enum hybrid_cpu_type adl_get_hybrid_cpu_type(void)
 {
-	return hybrid_big;
+	return HYBRID_INTEL_CORE;
 }
 
 /*
@@ -4613,22 +4613,47 @@ static void update_pmu_cap(struct x86_hybrid_pmu *pmu)
 	}
 }
 
-static bool init_hybrid_pmu(int cpu)
+static struct x86_hybrid_pmu *find_hybrid_pmu_for_cpu(void)
 {
-	struct cpu_hw_events *cpuc = &per_cpu(cpu_hw_events, cpu);
 	u8 cpu_type = get_this_hybrid_cpu_type();
-	struct x86_hybrid_pmu *pmu = NULL;
 	int i;
 
-	if (!cpu_type && x86_pmu.get_hybrid_cpu_type)
-		cpu_type = x86_pmu.get_hybrid_cpu_type();
+	/*
+	 * This is running on a CPU model that is known to have hybrid
+	 * configurations. But the CPU told us it is not hybrid, shame
+	 * on it. There should be a fixup function provided for these
+	 * troublesome CPUs (->get_hybrid_cpu_type).
+	 */
+	if (cpu_type == HYBRID_INTEL_NONE) {
+		if (x86_pmu.get_hybrid_cpu_type)
+			cpu_type = x86_pmu.get_hybrid_cpu_type();
+		else
+			return NULL;
+	}
 
+	/*
+	 * This essentially just maps between the 'hybrid_cpu_type'
+	 * and 'hybrid_pmu_type' enums:
+	 */
 	for (i = 0; i < x86_pmu.num_hybrid_pmus; i++) {
-		if (x86_pmu.hybrid_pmu[i].cpu_type == cpu_type) {
-			pmu = &x86_pmu.hybrid_pmu[i];
-			break;
-		}
+		enum hybrid_pmu_type pmu_type = x86_pmu.hybrid_pmu[i].pmu_type;
+
+		if (cpu_type == HYBRID_INTEL_CORE &&
+		    pmu_type == hybrid_big)
+			return &x86_pmu.hybrid_pmu[i];
+		if (cpu_type == HYBRID_INTEL_ATOM &&
+		    pmu_type == hybrid_small)
+			return &x86_pmu.hybrid_pmu[i];
 	}
+
+	return NULL;
+}
+
+static bool init_hybrid_pmu(int cpu)
+{
+	struct cpu_hw_events *cpuc = &per_cpu(cpu_hw_events, cpu);
+	struct x86_hybrid_pmu *pmu = find_hybrid_pmu_for_cpu();
+
 	if (WARN_ON_ONCE(!pmu || (pmu->pmu.type == -1))) {
 		cpuc->pmu = NULL;
 		return false;
@@ -5679,7 +5704,7 @@ static bool is_attr_for_this_pmu(struct kobject *kobj, struct attribute *attr)
 	struct perf_pmu_events_hybrid_attr *pmu_attr =
 		container_of(attr, struct perf_pmu_events_hybrid_attr, attr.attr);
 
-	return pmu->cpu_type & pmu_attr->pmu_type;
+	return pmu->pmu_type & pmu_attr->pmu_type;
 }
 
 static umode_t hybrid_events_is_visible(struct kobject *kobj,
@@ -5716,7 +5741,7 @@ static umode_t hybrid_format_is_visible(struct kobject *kobj,
 		container_of(attr, struct perf_pmu_format_hybrid_attr, attr.attr);
 	int cpu = hybrid_find_supported_cpu(pmu);
 
-	return (cpu >= 0) && (pmu->cpu_type & pmu_attr->pmu_type) ? attr->mode : 0;
+	return (cpu >= 0) && (pmu->pmu_type & pmu_attr->pmu_type) ? attr->mode : 0;
 }
 
 static struct attribute_group hybrid_group_events_td  = {
@@ -6607,7 +6632,7 @@ __init int intel_pmu_init(void)
 		/* Initialize big core specific PerfMon capabilities.*/
 		pmu = &x86_pmu.hybrid_pmu[X86_HYBRID_PMU_CORE_IDX];
 		pmu->name = "cpu_core";
-		pmu->cpu_type = hybrid_big;
+		pmu->pmu_type = hybrid_big;
 		intel_pmu_init_glc(&pmu->pmu);
 		pmu->late_ack = true;
 		if (cpu_feature_enabled(X86_FEATURE_HYBRID_CPU)) {
@@ -6643,7 +6668,7 @@ __init int intel_pmu_init(void)
 		/* Initialize Atom core specific PerfMon capabilities.*/
 		pmu = &x86_pmu.hybrid_pmu[X86_HYBRID_PMU_ATOM_IDX];
 		pmu->name = "cpu_atom";
-		pmu->cpu_type = hybrid_small;
+		pmu->pmu_type = hybrid_small;
 		intel_pmu_init_grt(&pmu->pmu);
 		pmu->mid_ack = true;
 		pmu->num_counters = x86_pmu.num_counters;
diff --git a/arch/x86/events/intel/ds.c b/arch/x86/events/intel/ds.c
index 7464246..bf97ab9 100644
--- a/arch/x86/events/intel/ds.c
+++ b/arch/x86/events/intel/ds.c
@@ -261,7 +261,7 @@ static u64 __adl_latency_data_small(struct perf_event *event, u64 status,
 {
 	u64 val;
 
-	WARN_ON_ONCE(hybrid_pmu(event->pmu)->cpu_type == hybrid_big);
+	WARN_ON_ONCE(hybrid_pmu(event->pmu)->pmu_type == hybrid_big);
 
 	dse &= PERF_PEBS_DATA_SOURCE_MASK;
 	val = hybrid_var(event->pmu, pebs_data_source)[dse];
diff --git a/arch/x86/events/perf_event.h b/arch/x86/events/perf_event.h
index 96a427f..53dd5d4 100644
--- a/arch/x86/events/perf_event.h
+++ b/arch/x86/events/perf_event.h
@@ -652,10 +652,29 @@ enum {
 #define PERF_PEBS_DATA_SOURCE_MAX	0x10
 #define PERF_PEBS_DATA_SOURCE_MASK	(PERF_PEBS_DATA_SOURCE_MAX - 1)
 
+enum hybrid_cpu_type {
+	HYBRID_INTEL_NONE,
+	HYBRID_INTEL_ATOM	= 0x20,
+	HYBRID_INTEL_CORE	= 0x40,
+};
+
+enum hybrid_pmu_type {
+	not_hybrid,
+	hybrid_small		= BIT(0),
+	hybrid_big		= BIT(1),
+
+	hybrid_big_small	= hybrid_big | hybrid_small, /* only used for matching */
+};
+
+#define X86_HYBRID_PMU_ATOM_IDX		0
+#define X86_HYBRID_PMU_CORE_IDX		1
+
+#define X86_HYBRID_NUM_PMUS		2
+
 struct x86_hybrid_pmu {
 	struct pmu			pmu;
 	const char			*name;
-	u8				cpu_type;
+	enum hybrid_pmu_type		pmu_type;
 	cpumask_t			supported_cpus;
 	union perf_capabilities		intel_cap;
 	u64				intel_ctrl;
@@ -721,18 +740,6 @@ extern struct static_key_false perf_is_hybrid;
 	__Fp;						\
 })
 
-enum hybrid_pmu_type {
-	hybrid_big		= 0x40,
-	hybrid_small		= 0x20,
-
-	hybrid_big_small	= hybrid_big | hybrid_small,
-};
-
-#define X86_HYBRID_PMU_ATOM_IDX		0
-#define X86_HYBRID_PMU_CORE_IDX		1
-
-#define X86_HYBRID_NUM_PMUS		2
-
 /*
  * struct x86_pmu - generic x86 pmu
  */
@@ -940,7 +947,7 @@ struct x86_pmu {
 	 */
 	int				num_hybrid_pmus;
 	struct x86_hybrid_pmu		*hybrid_pmu;
-	u8 (*get_hybrid_cpu_type)	(void);
+	enum hybrid_cpu_type (*get_hybrid_cpu_type)	(void);
 };
 
 struct x86_perf_task_context_opt {
