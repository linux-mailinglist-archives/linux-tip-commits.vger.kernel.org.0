Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7EDF73656A3
	for <lists+linux-tip-commits@lfdr.de>; Tue, 20 Apr 2021 12:49:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231920AbhDTKr2 (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Tue, 20 Apr 2021 06:47:28 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:51708 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231846AbhDTKrV (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Tue, 20 Apr 2021 06:47:21 -0400
Date:   Tue, 20 Apr 2021 10:46:49 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1618915609;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=l0J+uBombrZkllhKXkGnokCZ54lOQzYajtca4+PB2OE=;
        b=csvu9uhoZpXrc353nVw9TqnAEeVR20O5l5TApCS8N8B2fUGLaQuk3ANk6guzpaRge2Qax9
        Ne9uixlV4fDvHUtaUM0VQoLIK7kBV2z3o2R32zyJm7cwPO+5pPUrE8hHQWhWhH5UtslLBJ
        VV3GdeGt+xDkEHUTedpBg/90LKfDBeuoUI+cxROW03/jo/9PLQ7JurgWza3hJ4qlH+ytcZ
        0LruY2cZsmPd/UyuXBTrizaf5sqXTlFUP/Qlnww0rO8UiAVBjyCPnAIWbPer6Xj2vPnCef
        iL37bELlCLiBHJpc5+APc4Uu0BLOQ32R2vhdaLihGkJZ6TYwKteGMC0CYfWRVA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1618915609;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=l0J+uBombrZkllhKXkGnokCZ54lOQzYajtca4+PB2OE=;
        b=UaTKWnZnPcfwzbu4xlhYANog4wTtELzPyxT0lLSTMwHbuj4T2Sd5hQW3soGcnqbqExHAQH
        m/JA5gAEIxDE2eBg==
From:   "tip-bot2 for Kan Liang" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf/x86: Track pmu in per-CPU cpu_hw_events
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Kan Liang <kan.liang@linux.intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <1618237865-33448-4-git-send-email-kan.liang@linux.intel.com>
References: <1618237865-33448-4-git-send-email-kan.liang@linux.intel.com>
MIME-Version: 1.0
Message-ID: <161891560922.29796.12178605451839953247.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     61e76d53c39bb768ad264d379837cfc56b9e35b4
Gitweb:        https://git.kernel.org/tip/61e76d53c39bb768ad264d379837cfc56b9e35b4
Author:        Kan Liang <kan.liang@linux.intel.com>
AuthorDate:    Mon, 12 Apr 2021 07:30:43 -07:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 19 Apr 2021 20:03:24 +02:00

perf/x86: Track pmu in per-CPU cpu_hw_events

Some platforms, e.g. Alder Lake, have hybrid architecture. In the same
package, there may be more than one type of CPU. The PMU capabilities
are different among different types of CPU. Perf will register a
dedicated PMU for each type of CPU.

Add a 'pmu' variable in the struct cpu_hw_events to track the dedicated
PMU of the current CPU.

Current x86_get_pmu() use the global 'pmu', which will be broken on a
hybrid platform. Modify it to apply the 'pmu' of the specific CPU.

Initialize the per-CPU 'pmu' variable with the global 'pmu'. There is
nothing changed for the non-hybrid platforms.

The is_x86_event() will be updated in the later patch ("perf/x86:
Register hybrid PMUs") for hybrid platforms. For the non-hybrid
platforms, nothing is changed here.

Suggested-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/1618237865-33448-4-git-send-email-kan.liang@linux.intel.com
---
 arch/x86/events/core.c       | 17 +++++++++++++----
 arch/x86/events/intel/core.c |  2 +-
 arch/x86/events/intel/ds.c   |  4 ++--
 arch/x86/events/intel/lbr.c  |  9 +++++----
 arch/x86/events/perf_event.h |  4 +++-
 5 files changed, 24 insertions(+), 12 deletions(-)

diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
index dd9f3c2..a49a8bd 100644
--- a/arch/x86/events/core.c
+++ b/arch/x86/events/core.c
@@ -45,9 +45,11 @@
 #include "perf_event.h"
 
 struct x86_pmu x86_pmu __read_mostly;
+static struct pmu pmu;
 
 DEFINE_PER_CPU(struct cpu_hw_events, cpu_hw_events) = {
 	.enabled = 1,
+	.pmu = &pmu,
 };
 
 DEFINE_STATIC_KEY_FALSE(rdpmc_never_available_key);
@@ -724,16 +726,23 @@ void x86_pmu_enable_all(int added)
 	}
 }
 
-static struct pmu pmu;
-
 static inline int is_x86_event(struct perf_event *event)
 {
 	return event->pmu == &pmu;
 }
 
-struct pmu *x86_get_pmu(void)
+struct pmu *x86_get_pmu(unsigned int cpu)
 {
-	return &pmu;
+	struct cpu_hw_events *cpuc = &per_cpu(cpu_hw_events, cpu);
+
+	/*
+	 * All CPUs of the hybrid type have been offline.
+	 * The x86_get_pmu() should not be invoked.
+	 */
+	if (WARN_ON_ONCE(!cpuc->pmu))
+		return &pmu;
+
+	return cpuc->pmu;
 }
 /*
  * Event scheduler state:
diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index 7bbb5bb..f116c63 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -4876,7 +4876,7 @@ static void update_tfa_sched(void *ignored)
 	 * and if so force schedule out for all event types all contexts
 	 */
 	if (test_bit(3, cpuc->active_mask))
-		perf_pmu_resched(x86_get_pmu());
+		perf_pmu_resched(x86_get_pmu(smp_processor_id()));
 }
 
 static ssize_t show_sysctl_tfa(struct device *cdev,
diff --git a/arch/x86/events/intel/ds.c b/arch/x86/events/intel/ds.c
index 7ebae18..1bfea8c 100644
--- a/arch/x86/events/intel/ds.c
+++ b/arch/x86/events/intel/ds.c
@@ -2192,7 +2192,7 @@ void __init intel_ds_init(void)
 					PERF_SAMPLE_TIME;
 				x86_pmu.flags |= PMU_FL_PEBS_ALL;
 				pebs_qual = "-baseline";
-				x86_get_pmu()->capabilities |= PERF_PMU_CAP_EXTENDED_REGS;
+				x86_get_pmu(smp_processor_id())->capabilities |= PERF_PMU_CAP_EXTENDED_REGS;
 			} else {
 				/* Only basic record supported */
 				x86_pmu.large_pebs_flags &=
@@ -2207,7 +2207,7 @@ void __init intel_ds_init(void)
 
 			if (x86_pmu.intel_cap.pebs_output_pt_available) {
 				pr_cont("PEBS-via-PT, ");
-				x86_get_pmu()->capabilities |= PERF_PMU_CAP_AUX_OUTPUT;
+				x86_get_pmu(smp_processor_id())->capabilities |= PERF_PMU_CAP_AUX_OUTPUT;
 			}
 
 			break;
diff --git a/arch/x86/events/intel/lbr.c b/arch/x86/events/intel/lbr.c
index 21890da..bb4486c 100644
--- a/arch/x86/events/intel/lbr.c
+++ b/arch/x86/events/intel/lbr.c
@@ -705,7 +705,7 @@ void intel_pmu_lbr_add(struct perf_event *event)
 
 void release_lbr_buffers(void)
 {
-	struct kmem_cache *kmem_cache = x86_get_pmu()->task_ctx_cache;
+	struct kmem_cache *kmem_cache;
 	struct cpu_hw_events *cpuc;
 	int cpu;
 
@@ -714,6 +714,7 @@ void release_lbr_buffers(void)
 
 	for_each_possible_cpu(cpu) {
 		cpuc = per_cpu_ptr(&cpu_hw_events, cpu);
+		kmem_cache = x86_get_pmu(cpu)->task_ctx_cache;
 		if (kmem_cache && cpuc->lbr_xsave) {
 			kmem_cache_free(kmem_cache, cpuc->lbr_xsave);
 			cpuc->lbr_xsave = NULL;
@@ -1609,7 +1610,7 @@ void intel_pmu_lbr_init_hsw(void)
 	x86_pmu.lbr_sel_mask = LBR_SEL_MASK;
 	x86_pmu.lbr_sel_map  = hsw_lbr_sel_map;
 
-	x86_get_pmu()->task_ctx_cache = create_lbr_kmem_cache(size, 0);
+	x86_get_pmu(smp_processor_id())->task_ctx_cache = create_lbr_kmem_cache(size, 0);
 
 	if (lbr_from_signext_quirk_needed())
 		static_branch_enable(&lbr_from_quirk_key);
@@ -1629,7 +1630,7 @@ __init void intel_pmu_lbr_init_skl(void)
 	x86_pmu.lbr_sel_mask = LBR_SEL_MASK;
 	x86_pmu.lbr_sel_map  = hsw_lbr_sel_map;
 
-	x86_get_pmu()->task_ctx_cache = create_lbr_kmem_cache(size, 0);
+	x86_get_pmu(smp_processor_id())->task_ctx_cache = create_lbr_kmem_cache(size, 0);
 
 	/*
 	 * SW branch filter usage:
@@ -1726,7 +1727,7 @@ static bool is_arch_lbr_xsave_available(void)
 
 void __init intel_pmu_arch_lbr_init(void)
 {
-	struct pmu *pmu = x86_get_pmu();
+	struct pmu *pmu = x86_get_pmu(smp_processor_id());
 	union cpuid28_eax eax;
 	union cpuid28_ebx ebx;
 	union cpuid28_ecx ecx;
diff --git a/arch/x86/events/perf_event.h b/arch/x86/events/perf_event.h
index 54a340e..da947d3 100644
--- a/arch/x86/events/perf_event.h
+++ b/arch/x86/events/perf_event.h
@@ -326,6 +326,8 @@ struct cpu_hw_events {
 	int				n_pair; /* Large increment events */
 
 	void				*kfree_on_online[X86_PERF_KFREE_MAX];
+
+	struct pmu			*pmu;
 };
 
 #define __EVENT_CONSTRAINT_RANGE(c, e, n, m, w, o, f) {	\
@@ -904,7 +906,7 @@ static struct perf_pmu_events_ht_attr event_attr_##v = {		\
 	.event_str_ht	= ht,						\
 }
 
-struct pmu *x86_get_pmu(void);
+struct pmu *x86_get_pmu(unsigned int cpu);
 extern struct x86_pmu x86_pmu __read_mostly;
 
 static __always_inline struct x86_perf_task_context_opt *task_context_opt(void *ctx)
