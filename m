Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C2C3A36569F
	for <lists+linux-tip-commits@lfdr.de>; Tue, 20 Apr 2021 12:49:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231897AbhDTKr1 (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Tue, 20 Apr 2021 06:47:27 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:51726 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231824AbhDTKrV (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Tue, 20 Apr 2021 06:47:21 -0400
Date:   Tue, 20 Apr 2021 10:46:48 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1618915609;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fig7v/Ftkui9CU2mBt+N8CKamssgx9IC6k2wFkCFB1Y=;
        b=wC8jWMXf+AZgaHhV62bKqJFoEuaMW9bUqLewKhfPn1ZP/nRtNw6a+Wf/Hejt3ad0O55LdZ
        Ak08Czf0zj8ekWHpNRaRz7KJSDPnjRxeRakV6FbpCee+YqNmkYtc6xYC5gJqlpNvJHTnZ7
        gOuh9EH21nzqgvobTw4oT+ntAW0C0Q2Ldc8SpSJ9UpwTi5Cr9Hcgpinmgp5vaSsfxIMoR/
        qJXfg1PVKpcUSDotHwz/NgZfR7BtfJPVKDTQWpnS8dB8hBReMfLJK/YHMxF/Pl07i1UVd4
        XRZRte/v0dgUzSNbyICgBiKTGkD3c7aXXKD4c9fo8PJ9tAbW1XzF1vR8ritCEg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1618915609;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fig7v/Ftkui9CU2mBt+N8CKamssgx9IC6k2wFkCFB1Y=;
        b=r+nETJUa8fSdniltXXOgPxsDdNFvYA/A4Nem9OVjdJWvuMr2GlCs8ri/ZaLVZEXBEvUNON
        SpDEgQF5hCE8wZCw==
From:   "tip-bot2 for Kan Liang" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf/x86/intel: Hybrid PMU support for perf capabilities
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Kan Liang <kan.liang@linux.intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <1618237865-33448-5-git-send-email-kan.liang@linux.intel.com>
References: <1618237865-33448-5-git-send-email-kan.liang@linux.intel.com>
MIME-Version: 1.0
Message-ID: <161891560881.29796.17827673173920620899.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     d0946a882e6220229a29f9031641e54379be5a1e
Gitweb:        https://git.kernel.org/tip/d0946a882e6220229a29f9031641e54379be5a1e
Author:        Kan Liang <kan.liang@linux.intel.com>
AuthorDate:    Mon, 12 Apr 2021 07:30:44 -07:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 19 Apr 2021 20:03:24 +02:00

perf/x86/intel: Hybrid PMU support for perf capabilities

Some platforms, e.g. Alder Lake, have hybrid architecture. Although most
PMU capabilities are the same, there are still some unique PMU
capabilities for different hybrid PMUs. Perf should register a dedicated
pmu for each hybrid PMU.

Add a new struct x86_hybrid_pmu, which saves the dedicated pmu and
capabilities for each hybrid PMU.

The architecture MSR, MSR_IA32_PERF_CAPABILITIES, only indicates the
architecture features which are available on all hybrid PMUs. The
architecture features are stored in the global x86_pmu.intel_cap.

For Alder Lake, the model-specific features are perf metrics and
PEBS-via-PT. The corresponding bits of the global x86_pmu.intel_cap
should be 0 for these two features. Perf should not use the global
intel_cap to check the features on a hybrid system.
Add a dedicated intel_cap in the x86_hybrid_pmu to store the
model-specific capabilities. Use the dedicated intel_cap to replace
the global intel_cap for thse two features. The dedicated intel_cap
will be set in the following "Add Alder Lake Hybrid support" patch.

Add is_hybrid() to distinguish a hybrid system. ADL may have an
alternative configuration. With that configuration, the
X86_FEATURE_HYBRID_CPU is not set. Perf cannot rely on the feature bit.
Add a new static_key_false, perf_is_hybrid, to indicate a hybrid system.
It will be assigned in the following "Add Alder Lake Hybrid support"
patch as well.

Suggested-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/1618237865-33448-5-git-send-email-kan.liang@linux.intel.com
---
 arch/x86/events/core.c           |  7 +++++--
 arch/x86/events/intel/core.c     | 22 +++++++++++++++++----
 arch/x86/events/intel/ds.c       |  2 +-
 arch/x86/events/perf_event.h     | 33 +++++++++++++++++++++++++++++++-
 arch/x86/include/asm/msr-index.h |  3 +++-
 5 files changed, 60 insertions(+), 7 deletions(-)

diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
index a49a8bd..7fc2001 100644
--- a/arch/x86/events/core.c
+++ b/arch/x86/events/core.c
@@ -54,6 +54,7 @@ DEFINE_PER_CPU(struct cpu_hw_events, cpu_hw_events) = {
 
 DEFINE_STATIC_KEY_FALSE(rdpmc_never_available_key);
 DEFINE_STATIC_KEY_FALSE(rdpmc_always_available_key);
+DEFINE_STATIC_KEY_FALSE(perf_is_hybrid);
 
 /*
  * This here uses DEFINE_STATIC_CALL_NULL() to get a static_call defined
@@ -1105,8 +1106,9 @@ static void del_nr_metric_event(struct cpu_hw_events *cpuc,
 static int collect_event(struct cpu_hw_events *cpuc, struct perf_event *event,
 			 int max_count, int n)
 {
+	union perf_capabilities intel_cap = hybrid(cpuc->pmu, intel_cap);
 
-	if (x86_pmu.intel_cap.perf_metrics && add_nr_metric_event(cpuc, event))
+	if (intel_cap.perf_metrics && add_nr_metric_event(cpuc, event))
 		return -EINVAL;
 
 	if (n >= max_count + cpuc->n_metric)
@@ -1581,6 +1583,7 @@ void x86_pmu_stop(struct perf_event *event, int flags)
 static void x86_pmu_del(struct perf_event *event, int flags)
 {
 	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
+	union perf_capabilities intel_cap = hybrid(cpuc->pmu, intel_cap);
 	int i;
 
 	/*
@@ -1620,7 +1623,7 @@ static void x86_pmu_del(struct perf_event *event, int flags)
 	}
 	cpuc->event_constraint[i-1] = NULL;
 	--cpuc->n_events;
-	if (x86_pmu.intel_cap.perf_metrics)
+	if (intel_cap.perf_metrics)
 		del_nr_metric_event(cpuc, event);
 
 	perf_event_update_userpage(event);
diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index f116c63..dc9e2fb 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -3646,6 +3646,12 @@ static inline bool is_mem_loads_aux_event(struct perf_event *event)
 	return (event->attr.config & INTEL_ARCH_EVENT_MASK) == X86_CONFIG(.event=0x03, .umask=0x82);
 }
 
+static inline bool intel_pmu_has_cap(struct perf_event *event, int idx)
+{
+	union perf_capabilities *intel_cap = &hybrid(event->pmu, intel_cap);
+
+	return test_bit(idx, (unsigned long *)&intel_cap->capabilities);
+}
 
 static int intel_pmu_hw_config(struct perf_event *event)
 {
@@ -3712,7 +3718,7 @@ static int intel_pmu_hw_config(struct perf_event *event)
 	 * with a slots event as group leader. When the slots event
 	 * is used in a metrics group, it too cannot support sampling.
 	 */
-	if (x86_pmu.intel_cap.perf_metrics && is_topdown_event(event)) {
+	if (intel_pmu_has_cap(event, PERF_CAP_METRICS_IDX) && is_topdown_event(event)) {
 		if (event->attr.config1 || event->attr.config2)
 			return -EINVAL;
 
@@ -4219,8 +4225,16 @@ static void intel_pmu_cpu_starting(int cpu)
 	if (x86_pmu.version > 1)
 		flip_smm_bit(&x86_pmu.attr_freeze_on_smi);
 
-	/* Disable perf metrics if any added CPU doesn't support it. */
-	if (x86_pmu.intel_cap.perf_metrics) {
+	/*
+	 * Disable perf metrics if any added CPU doesn't support it.
+	 *
+	 * Turn off the check for a hybrid architecture, because the
+	 * architecture MSR, MSR_IA32_PERF_CAPABILITIES, only indicate
+	 * the architecture features. The perf metrics is a model-specific
+	 * feature for now. The corresponding bit should always be 0 on
+	 * a hybrid platform, e.g., Alder Lake.
+	 */
+	if (!is_hybrid() && x86_pmu.intel_cap.perf_metrics) {
 		union perf_capabilities perf_cap;
 
 		rdmsrl(MSR_IA32_PERF_CAPABILITIES, perf_cap.capabilities);
@@ -5770,7 +5784,7 @@ __init int intel_pmu_init(void)
 		pr_cont("full-width counters, ");
 	}
 
-	if (x86_pmu.intel_cap.perf_metrics)
+	if (!is_hybrid() && x86_pmu.intel_cap.perf_metrics)
 		x86_pmu.intel_ctrl |= 1ULL << GLOBAL_CTRL_EN_PERF_METRICS;
 
 	return 0;
diff --git a/arch/x86/events/intel/ds.c b/arch/x86/events/intel/ds.c
index 1bfea8c..9328aa1 100644
--- a/arch/x86/events/intel/ds.c
+++ b/arch/x86/events/intel/ds.c
@@ -2205,7 +2205,7 @@ void __init intel_ds_init(void)
 			}
 			pr_cont("PEBS fmt4%c%s, ", pebs_type, pebs_qual);
 
-			if (x86_pmu.intel_cap.pebs_output_pt_available) {
+			if (!is_hybrid() && x86_pmu.intel_cap.pebs_output_pt_available) {
 				pr_cont("PEBS-via-PT, ");
 				x86_get_pmu(smp_processor_id())->capabilities |= PERF_PMU_CAP_AUX_OUTPUT;
 			}
diff --git a/arch/x86/events/perf_event.h b/arch/x86/events/perf_event.h
index da947d3..85910e2 100644
--- a/arch/x86/events/perf_event.h
+++ b/arch/x86/events/perf_event.h
@@ -631,6 +631,29 @@ enum {
 	x86_lbr_exclusive_max,
 };
 
+struct x86_hybrid_pmu {
+	struct pmu			pmu;
+	union perf_capabilities		intel_cap;
+};
+
+static __always_inline struct x86_hybrid_pmu *hybrid_pmu(struct pmu *pmu)
+{
+	return container_of(pmu, struct x86_hybrid_pmu, pmu);
+}
+
+extern struct static_key_false perf_is_hybrid;
+#define is_hybrid()		static_branch_unlikely(&perf_is_hybrid)
+
+#define hybrid(_pmu, _field)				\
+(*({							\
+	typeof(&x86_pmu._field) __Fp = &x86_pmu._field;	\
+							\
+	if (is_hybrid() && (_pmu))			\
+		__Fp = &hybrid_pmu(_pmu)->_field;	\
+							\
+	__Fp;						\
+}))
+
 /*
  * struct x86_pmu - generic x86 pmu
  */
@@ -817,6 +840,16 @@ struct x86_pmu {
 	int (*check_period) (struct perf_event *event, u64 period);
 
 	int (*aux_output_match) (struct perf_event *event);
+
+	/*
+	 * Hybrid support
+	 *
+	 * Most PMU capabilities are the same among different hybrid PMUs.
+	 * The global x86_pmu saves the architecture capabilities, which
+	 * are available for all PMUs. The hybrid_pmu only includes the
+	 * unique capabilities.
+	 */
+	struct x86_hybrid_pmu		*hybrid_pmu;
 };
 
 struct x86_perf_task_context_opt {
diff --git a/arch/x86/include/asm/msr-index.h b/arch/x86/include/asm/msr-index.h
index 546d6ec..163f5d2 100644
--- a/arch/x86/include/asm/msr-index.h
+++ b/arch/x86/include/asm/msr-index.h
@@ -185,6 +185,9 @@
 #define MSR_PEBS_DATA_CFG		0x000003f2
 #define MSR_IA32_DS_AREA		0x00000600
 #define MSR_IA32_PERF_CAPABILITIES	0x00000345
+#define PERF_CAP_METRICS_IDX		15
+#define PERF_CAP_PT_IDX			16
+
 #define MSR_PEBS_LD_LAT_THRESHOLD	0x000003f6
 
 #define MSR_IA32_RTIT_CTL		0x00000570
