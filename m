Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BD697BF58B
	for <lists+linux-tip-commits@lfdr.de>; Tue, 10 Oct 2023 10:19:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442747AbjJJITj (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Tue, 10 Oct 2023 04:19:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442730AbjJJITg (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Tue, 10 Oct 2023 04:19:36 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A344BA7;
        Tue, 10 Oct 2023 01:19:32 -0700 (PDT)
Date:   Tue, 10 Oct 2023 08:19:30 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1696925971;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uFcrSlmz0vzKoZCoGjeUz32KUDi6r6mYIggXErj/xdk=;
        b=e3O7NMUV6Gs97aV3YdsL8FeKrCPCPpDLyGUc3RGpohzbpXfTavHKrw+K81SfeiurqAjqu+
        9caoWpRJ5KGu3SOUMbbUdvASf86MVhEQEI7crK8ClXvRTdY1rrLkVHp43RFphyFWdqmmoF
        m44qXC3wRSuv8fvB9e0rpmhiP2xeFaw1kREDBEdYnKRcV2oiDBcLTvcEEadfN8m3b8Dand
        n9kza1AP8DJbfA4mh79QH8nfy2Agn+AFpgFUB9thk7dft0N0FXG659gRJI792nd6GLGux7
        1IrkAA6Q+umDhY/y9N2oldt/Y0AD68flKFwlbv3pJN3DNldrdIZYrPeCdBdCXA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1696925971;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uFcrSlmz0vzKoZCoGjeUz32KUDi6r6mYIggXErj/xdk=;
        b=vYRuMuDoR8rUV9GfaI9+086E++lqHDjRBC6hiK/6T0PwYbJgp0HGgvyLTAMlGVO7uOdT2i
        fjjwPDLLvgD6LpDg==
From:   "tip-bot2 for Sandipan Das" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf/x86/amd/uncore: Refactor uncore management
Cc:     Sandipan Das <sandipan.das@amd.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: =?utf-8?q?=3C24b38c49a5dae65d8c96e5d75a2b96ae97aaa651=2E16964?=
 =?utf-8?q?25185=2Egit=2Esandipan=2Edas=40amd=2Ecom=3E?=
References: =?utf-8?q?=3C24b38c49a5dae65d8c96e5d75a2b96ae97aaa651=2E169642?=
 =?utf-8?q?5185=2Egit=2Esandipan=2Edas=40amd=2Ecom=3E?=
MIME-Version: 1.0
Message-ID: <169692597062.3135.2529737485792230446.tip-bot2@tip-bot2>
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

Commit-ID:     d6389d3ccc136a4229a8d497899c64f80fd3c5b3
Gitweb:        https://git.kernel.org/tip/d6389d3ccc136a4229a8d497899c64f80fd3c5b3
Author:        Sandipan Das <sandipan.das@amd.com>
AuthorDate:    Thu, 05 Oct 2023 10:53:11 +05:30
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 09 Oct 2023 16:12:23 +02:00

perf/x86/amd/uncore: Refactor uncore management

Since struct amd_uncore is used to manage per-cpu contexts, rename it to
amd_uncore_ctx in order to better reflect its purpose. Add a new struct
amd_uncore_pmu to encapsulate all attributes which are shared by per-cpu
contexts for a corresponding PMU. These include the number of counters,
active mask, MSR and RDPMC base addresses, etc. Since the struct pmu is
now embedded, the corresponding amd_uncore_pmu for a given event can be
found by simply using container_of().

Finally, move all PMU-specific code to separate functions. While the
original event management functions continue to provide the base
functionality, all PMU-specific quirks and customizations are applied in
separate functions.

The motivation is to simplify the management of uncore PMUs.

Signed-off-by: Sandipan Das <sandipan.das@amd.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/r/24b38c49a5dae65d8c96e5d75a2b96ae97aaa651.1696425185.git.sandipan.das@amd.com
---
 arch/x86/events/amd/uncore.c | 737 +++++++++++++++++-----------------
 1 file changed, 379 insertions(+), 358 deletions(-)

diff --git a/arch/x86/events/amd/uncore.c b/arch/x86/events/amd/uncore.c
index 83f15fe..ffcecda 100644
--- a/arch/x86/events/amd/uncore.c
+++ b/arch/x86/events/amd/uncore.c
@@ -27,56 +27,41 @@
 
 #define COUNTER_SHIFT		16
 
+#define NUM_UNCORES_MAX		2	/* DF (or NB) and L3 (or L2) */
+#define UNCORE_NAME_LEN		16
+
 #undef pr_fmt
 #define pr_fmt(fmt)	"amd_uncore: " fmt
 
 static int pmu_version;
-static int num_counters_llc;
-static int num_counters_nb;
-static bool l3_mask;
 
 static HLIST_HEAD(uncore_unused_list);
 
-struct amd_uncore {
+struct amd_uncore_ctx {
 	int id;
 	int refcnt;
 	int cpu;
-	int num_counters;
-	int rdpmc_base;
-	u32 msr_base;
-	cpumask_t *active_mask;
-	struct pmu *pmu;
 	struct perf_event **events;
 	struct hlist_node node;
 };
 
-static struct amd_uncore * __percpu *amd_uncore_nb;
-static struct amd_uncore * __percpu *amd_uncore_llc;
-
-static struct pmu amd_nb_pmu;
-static struct pmu amd_llc_pmu;
-
-static cpumask_t amd_nb_active_mask;
-static cpumask_t amd_llc_active_mask;
-
-static bool is_nb_event(struct perf_event *event)
-{
-	return event->pmu->type == amd_nb_pmu.type;
-}
+struct amd_uncore_pmu {
+	char name[UNCORE_NAME_LEN];
+	int num_counters;
+	int rdpmc_base;
+	u32 msr_base;
+	cpumask_t active_mask;
+	struct pmu pmu;
+	struct amd_uncore_ctx * __percpu *ctx;
+	int (*id)(unsigned int cpu);
+};
 
-static bool is_llc_event(struct perf_event *event)
-{
-	return event->pmu->type == amd_llc_pmu.type;
-}
+static struct amd_uncore_pmu pmus[NUM_UNCORES_MAX];
+static int num_pmus __read_mostly;
 
-static struct amd_uncore *event_to_amd_uncore(struct perf_event *event)
+static struct amd_uncore_pmu *event_to_amd_uncore_pmu(struct perf_event *event)
 {
-	if (is_nb_event(event) && amd_uncore_nb)
-		return *per_cpu_ptr(amd_uncore_nb, event->cpu);
-	else if (is_llc_event(event) && amd_uncore_llc)
-		return *per_cpu_ptr(amd_uncore_llc, event->cpu);
-
-	return NULL;
+	return container_of(event->pmu, struct amd_uncore_pmu, pmu);
 }
 
 static void amd_uncore_read(struct perf_event *event)
@@ -118,7 +103,7 @@ static void amd_uncore_stop(struct perf_event *event, int flags)
 	hwc->state |= PERF_HES_STOPPED;
 
 	if ((flags & PERF_EF_UPDATE) && !(hwc->state & PERF_HES_UPTODATE)) {
-		amd_uncore_read(event);
+		event->pmu->read(event);
 		hwc->state |= PERF_HES_UPTODATE;
 	}
 }
@@ -126,15 +111,16 @@ static void amd_uncore_stop(struct perf_event *event, int flags)
 static int amd_uncore_add(struct perf_event *event, int flags)
 {
 	int i;
-	struct amd_uncore *uncore = event_to_amd_uncore(event);
+	struct amd_uncore_pmu *pmu = event_to_amd_uncore_pmu(event);
+	struct amd_uncore_ctx *ctx = *per_cpu_ptr(pmu->ctx, event->cpu);
 	struct hw_perf_event *hwc = &event->hw;
 
 	/* are we already assigned? */
-	if (hwc->idx != -1 && uncore->events[hwc->idx] == event)
+	if (hwc->idx != -1 && ctx->events[hwc->idx] == event)
 		goto out;
 
-	for (i = 0; i < uncore->num_counters; i++) {
-		if (uncore->events[i] == event) {
+	for (i = 0; i < pmu->num_counters; i++) {
+		if (ctx->events[i] == event) {
 			hwc->idx = i;
 			goto out;
 		}
@@ -142,8 +128,8 @@ static int amd_uncore_add(struct perf_event *event, int flags)
 
 	/* if not, take the first available counter */
 	hwc->idx = -1;
-	for (i = 0; i < uncore->num_counters; i++) {
-		if (cmpxchg(&uncore->events[i], NULL, event) == NULL) {
+	for (i = 0; i < pmu->num_counters; i++) {
+		if (cmpxchg(&ctx->events[i], NULL, event) == NULL) {
 			hwc->idx = i;
 			break;
 		}
@@ -153,23 +139,13 @@ out:
 	if (hwc->idx == -1)
 		return -EBUSY;
 
-	hwc->config_base = uncore->msr_base + (2 * hwc->idx);
-	hwc->event_base = uncore->msr_base + 1 + (2 * hwc->idx);
-	hwc->event_base_rdpmc = uncore->rdpmc_base + hwc->idx;
+	hwc->config_base = pmu->msr_base + (2 * hwc->idx);
+	hwc->event_base = pmu->msr_base + 1 + (2 * hwc->idx);
+	hwc->event_base_rdpmc = pmu->rdpmc_base + hwc->idx;
 	hwc->state = PERF_HES_UPTODATE | PERF_HES_STOPPED;
 
-	/*
-	 * The first four DF counters are accessible via RDPMC index 6 to 9
-	 * followed by the L3 counters from index 10 to 15. For processors
-	 * with more than four DF counters, the DF RDPMC assignments become
-	 * discontiguous as the additional counters are accessible starting
-	 * from index 16.
-	 */
-	if (is_nb_event(event) && hwc->idx >= NUM_COUNTERS_NB)
-		hwc->event_base_rdpmc += NUM_COUNTERS_L3;
-
 	if (flags & PERF_EF_START)
-		amd_uncore_start(event, PERF_EF_RELOAD);
+		event->pmu->start(event, PERF_EF_RELOAD);
 
 	return 0;
 }
@@ -177,55 +153,36 @@ out:
 static void amd_uncore_del(struct perf_event *event, int flags)
 {
 	int i;
-	struct amd_uncore *uncore = event_to_amd_uncore(event);
+	struct amd_uncore_pmu *pmu = event_to_amd_uncore_pmu(event);
+	struct amd_uncore_ctx *ctx = *per_cpu_ptr(pmu->ctx, event->cpu);
 	struct hw_perf_event *hwc = &event->hw;
 
-	amd_uncore_stop(event, PERF_EF_UPDATE);
+	event->pmu->stop(event, PERF_EF_UPDATE);
 
-	for (i = 0; i < uncore->num_counters; i++) {
-		if (cmpxchg(&uncore->events[i], event, NULL) == event)
+	for (i = 0; i < pmu->num_counters; i++) {
+		if (cmpxchg(&ctx->events[i], event, NULL) == event)
 			break;
 	}
 
 	hwc->idx = -1;
 }
 
-/*
- * Return a full thread and slice mask unless user
- * has provided them
- */
-static u64 l3_thread_slice_mask(u64 config)
-{
-	if (boot_cpu_data.x86 <= 0x18)
-		return ((config & AMD64_L3_SLICE_MASK) ? : AMD64_L3_SLICE_MASK) |
-		       ((config & AMD64_L3_THREAD_MASK) ? : AMD64_L3_THREAD_MASK);
-
-	/*
-	 * If the user doesn't specify a threadmask, they're not trying to
-	 * count core 0, so we enable all cores & threads.
-	 * We'll also assume that they want to count slice 0 if they specify
-	 * a threadmask and leave sliceid and enallslices unpopulated.
-	 */
-	if (!(config & AMD64_L3_F19H_THREAD_MASK))
-		return AMD64_L3_F19H_THREAD_MASK | AMD64_L3_EN_ALL_SLICES |
-		       AMD64_L3_EN_ALL_CORES;
-
-	return config & (AMD64_L3_F19H_THREAD_MASK | AMD64_L3_SLICEID_MASK |
-			 AMD64_L3_EN_ALL_CORES | AMD64_L3_EN_ALL_SLICES |
-			 AMD64_L3_COREID_MASK);
-}
-
 static int amd_uncore_event_init(struct perf_event *event)
 {
-	struct amd_uncore *uncore;
+	struct amd_uncore_pmu *pmu;
+	struct amd_uncore_ctx *ctx;
 	struct hw_perf_event *hwc = &event->hw;
-	u64 event_mask = AMD64_RAW_EVENT_MASK_NB;
 
 	if (event->attr.type != event->pmu->type)
 		return -ENOENT;
 
-	if (pmu_version >= 2 && is_nb_event(event))
-		event_mask = AMD64_PERFMON_V2_RAW_EVENT_MASK_NB;
+	if (event->cpu < 0)
+		return -EINVAL;
+
+	pmu = event_to_amd_uncore_pmu(event);
+	ctx = *per_cpu_ptr(pmu->ctx, event->cpu);
+	if (!ctx)
+		return -ENODEV;
 
 	/*
 	 * NB and Last level cache counters (MSRs) are shared across all cores
@@ -235,28 +192,14 @@ static int amd_uncore_event_init(struct perf_event *event)
 	 * out. So we do not support sampling and per-thread events via
 	 * CAP_NO_INTERRUPT, and we do not enable counter overflow interrupts:
 	 */
-	hwc->config = event->attr.config & event_mask;
+	hwc->config = event->attr.config;
 	hwc->idx = -1;
 
-	if (event->cpu < 0)
-		return -EINVAL;
-
-	/*
-	 * SliceMask and ThreadMask need to be set for certain L3 events.
-	 * For other events, the two fields do not affect the count.
-	 */
-	if (l3_mask && is_llc_event(event))
-		hwc->config |= l3_thread_slice_mask(event->attr.config);
-
-	uncore = event_to_amd_uncore(event);
-	if (!uncore)
-		return -ENODEV;
-
 	/*
 	 * since request can come in to any of the shared cores, we will remap
 	 * to a single common cpu.
 	 */
-	event->cpu = uncore->cpu;
+	event->cpu = ctx->cpu;
 
 	return 0;
 }
@@ -278,17 +221,10 @@ static ssize_t amd_uncore_attr_show_cpumask(struct device *dev,
 					    struct device_attribute *attr,
 					    char *buf)
 {
-	cpumask_t *active_mask;
-	struct pmu *pmu = dev_get_drvdata(dev);
-
-	if (pmu->type == amd_nb_pmu.type)
-		active_mask = &amd_nb_active_mask;
-	else if (pmu->type == amd_llc_pmu.type)
-		active_mask = &amd_llc_active_mask;
-	else
-		return 0;
+	struct pmu *ptr = dev_get_drvdata(dev);
+	struct amd_uncore_pmu *pmu = container_of(ptr, struct amd_uncore_pmu, pmu);
 
-	return cpumap_print_to_pagebuf(true, buf, active_mask);
+	return cpumap_print_to_pagebuf(true, buf, &pmu->active_mask);
 }
 static DEVICE_ATTR(cpumask, S_IRUGO, amd_uncore_attr_show_cpumask, NULL);
 
@@ -396,113 +332,57 @@ static const struct attribute_group *amd_uncore_l3_attr_update[] = {
 	NULL,
 };
 
-static struct pmu amd_nb_pmu = {
-	.task_ctx_nr	= perf_invalid_context,
-	.attr_groups	= amd_uncore_df_attr_groups,
-	.name		= "amd_nb",
-	.event_init	= amd_uncore_event_init,
-	.add		= amd_uncore_add,
-	.del		= amd_uncore_del,
-	.start		= amd_uncore_start,
-	.stop		= amd_uncore_stop,
-	.read		= amd_uncore_read,
-	.capabilities	= PERF_PMU_CAP_NO_EXCLUDE | PERF_PMU_CAP_NO_INTERRUPT,
-	.module		= THIS_MODULE,
-};
-
-static struct pmu amd_llc_pmu = {
-	.task_ctx_nr	= perf_invalid_context,
-	.attr_groups	= amd_uncore_l3_attr_groups,
-	.attr_update	= amd_uncore_l3_attr_update,
-	.name		= "amd_l2",
-	.event_init	= amd_uncore_event_init,
-	.add		= amd_uncore_add,
-	.del		= amd_uncore_del,
-	.start		= amd_uncore_start,
-	.stop		= amd_uncore_stop,
-	.read		= amd_uncore_read,
-	.capabilities	= PERF_PMU_CAP_NO_EXCLUDE | PERF_PMU_CAP_NO_INTERRUPT,
-	.module		= THIS_MODULE,
-};
-
-static struct amd_uncore *amd_uncore_alloc(unsigned int cpu)
-{
-	return kzalloc_node(sizeof(struct amd_uncore), GFP_KERNEL,
-			cpu_to_node(cpu));
-}
-
-static inline struct perf_event **
-amd_uncore_events_alloc(unsigned int num, unsigned int cpu)
-{
-	return kzalloc_node(sizeof(struct perf_event *) * num, GFP_KERNEL,
-			    cpu_to_node(cpu));
-}
-
 static int amd_uncore_cpu_up_prepare(unsigned int cpu)
 {
-	struct amd_uncore *uncore_nb = NULL, *uncore_llc = NULL;
-
-	if (amd_uncore_nb) {
-		*per_cpu_ptr(amd_uncore_nb, cpu) = NULL;
-		uncore_nb = amd_uncore_alloc(cpu);
-		if (!uncore_nb)
-			goto fail;
-		uncore_nb->cpu = cpu;
-		uncore_nb->num_counters = num_counters_nb;
-		uncore_nb->rdpmc_base = RDPMC_BASE_NB;
-		uncore_nb->msr_base = MSR_F15H_NB_PERF_CTL;
-		uncore_nb->active_mask = &amd_nb_active_mask;
-		uncore_nb->pmu = &amd_nb_pmu;
-		uncore_nb->events = amd_uncore_events_alloc(num_counters_nb, cpu);
-		if (!uncore_nb->events)
+	struct amd_uncore_pmu *pmu;
+	struct amd_uncore_ctx *ctx;
+	int node = cpu_to_node(cpu), i;
+
+	for (i = 0; i < num_pmus; i++) {
+		pmu = &pmus[i];
+		*per_cpu_ptr(pmu->ctx, cpu) = NULL;
+		ctx = kzalloc_node(sizeof(struct amd_uncore_ctx), GFP_KERNEL,
+				   node);
+		if (!ctx)
 			goto fail;
-		uncore_nb->id = -1;
-		*per_cpu_ptr(amd_uncore_nb, cpu) = uncore_nb;
-	}
 
-	if (amd_uncore_llc) {
-		*per_cpu_ptr(amd_uncore_llc, cpu) = NULL;
-		uncore_llc = amd_uncore_alloc(cpu);
-		if (!uncore_llc)
-			goto fail;
-		uncore_llc->cpu = cpu;
-		uncore_llc->num_counters = num_counters_llc;
-		uncore_llc->rdpmc_base = RDPMC_BASE_LLC;
-		uncore_llc->msr_base = MSR_F16H_L2I_PERF_CTL;
-		uncore_llc->active_mask = &amd_llc_active_mask;
-		uncore_llc->pmu = &amd_llc_pmu;
-		uncore_llc->events = amd_uncore_events_alloc(num_counters_llc, cpu);
-		if (!uncore_llc->events)
+		ctx->cpu = cpu;
+		ctx->events = kzalloc_node(sizeof(struct perf_event *) *
+					   pmu->num_counters, GFP_KERNEL,
+					   node);
+		if (!ctx->events)
 			goto fail;
-		uncore_llc->id = -1;
-		*per_cpu_ptr(amd_uncore_llc, cpu) = uncore_llc;
+
+		ctx->id = -1;
+		*per_cpu_ptr(pmu->ctx, cpu) = ctx;
 	}
 
 	return 0;
 
 fail:
-	if (uncore_nb) {
-		kfree(uncore_nb->events);
-		kfree(uncore_nb);
-	}
+	/* Rollback */
+	for (; i >= 0; i--) {
+		pmu = &pmus[i];
+		ctx = *per_cpu_ptr(pmu->ctx, cpu);
+		if (!ctx)
+			continue;
 
-	if (uncore_llc) {
-		kfree(uncore_llc->events);
-		kfree(uncore_llc);
+		kfree(ctx->events);
+		kfree(ctx);
 	}
 
 	return -ENOMEM;
 }
 
-static struct amd_uncore *
-amd_uncore_find_online_sibling(struct amd_uncore *this,
-			       struct amd_uncore * __percpu *uncores)
+static struct amd_uncore_ctx *
+amd_uncore_find_online_sibling(struct amd_uncore_ctx *this,
+			       struct amd_uncore_pmu *pmu)
 {
 	unsigned int cpu;
-	struct amd_uncore *that;
+	struct amd_uncore_ctx *that;
 
 	for_each_online_cpu(cpu) {
-		that = *per_cpu_ptr(uncores, cpu);
+		that = *per_cpu_ptr(pmu->ctx, cpu);
 
 		if (!that)
 			continue;
@@ -523,24 +403,16 @@ amd_uncore_find_online_sibling(struct amd_uncore *this,
 
 static int amd_uncore_cpu_starting(unsigned int cpu)
 {
-	unsigned int eax, ebx, ecx, edx;
-	struct amd_uncore *uncore;
-
-	if (amd_uncore_nb) {
-		uncore = *per_cpu_ptr(amd_uncore_nb, cpu);
-		cpuid(0x8000001e, &eax, &ebx, &ecx, &edx);
-		uncore->id = ecx & 0xff;
-
-		uncore = amd_uncore_find_online_sibling(uncore, amd_uncore_nb);
-		*per_cpu_ptr(amd_uncore_nb, cpu) = uncore;
-	}
-
-	if (amd_uncore_llc) {
-		uncore = *per_cpu_ptr(amd_uncore_llc, cpu);
-		uncore->id = get_llc_id(cpu);
+	struct amd_uncore_pmu *pmu;
+	struct amd_uncore_ctx *ctx;
+	int i;
 
-		uncore = amd_uncore_find_online_sibling(uncore, amd_uncore_llc);
-		*per_cpu_ptr(amd_uncore_llc, cpu) = uncore;
+	for (i = 0; i < num_pmus; i++) {
+		pmu = &pmus[i];
+		ctx = *per_cpu_ptr(pmu->ctx, cpu);
+		ctx->id = pmu->id(cpu);
+		ctx = amd_uncore_find_online_sibling(ctx, pmu);
+		*per_cpu_ptr(pmu->ctx, cpu) = ctx;
 	}
 
 	return 0;
@@ -548,195 +420,359 @@ static int amd_uncore_cpu_starting(unsigned int cpu)
 
 static void uncore_clean_online(void)
 {
-	struct amd_uncore *uncore;
+	struct amd_uncore_ctx *ctx;
 	struct hlist_node *n;
 
-	hlist_for_each_entry_safe(uncore, n, &uncore_unused_list, node) {
-		hlist_del(&uncore->node);
-		kfree(uncore->events);
-		kfree(uncore);
+	hlist_for_each_entry_safe(ctx, n, &uncore_unused_list, node) {
+		hlist_del(&ctx->node);
+		kfree(ctx->events);
+		kfree(ctx);
 	}
 }
 
-static void uncore_online(unsigned int cpu,
-			  struct amd_uncore * __percpu *uncores)
+static int amd_uncore_cpu_online(unsigned int cpu)
 {
-	struct amd_uncore *uncore = *per_cpu_ptr(uncores, cpu);
+	struct amd_uncore_pmu *pmu;
+	struct amd_uncore_ctx *ctx;
+	int i;
 
 	uncore_clean_online();
 
-	if (cpu == uncore->cpu)
-		cpumask_set_cpu(cpu, uncore->active_mask);
+	for (i = 0; i < num_pmus; i++) {
+		pmu = &pmus[i];
+		ctx = *per_cpu_ptr(pmu->ctx, cpu);
+		if (cpu == ctx->cpu)
+			cpumask_set_cpu(cpu, &pmu->active_mask);
+	}
+
+	return 0;
 }
 
-static int amd_uncore_cpu_online(unsigned int cpu)
+static int amd_uncore_cpu_down_prepare(unsigned int cpu)
 {
-	if (amd_uncore_nb)
-		uncore_online(cpu, amd_uncore_nb);
+	struct amd_uncore_ctx *this, *that;
+	struct amd_uncore_pmu *pmu;
+	int i, j;
+
+	for (i = 0; i < num_pmus; i++) {
+		pmu = &pmus[i];
+		this = *per_cpu_ptr(pmu->ctx, cpu);
+
+		/* this cpu is going down, migrate to a shared sibling if possible */
+		for_each_online_cpu(j) {
+			that = *per_cpu_ptr(pmu->ctx, j);
+
+			if (cpu == j)
+				continue;
+
+			if (this == that) {
+				perf_pmu_migrate_context(&pmu->pmu, cpu, j);
+				cpumask_clear_cpu(cpu, &pmu->active_mask);
+				cpumask_set_cpu(j, &pmu->active_mask);
+				that->cpu = j;
+				break;
+			}
+		}
+	}
 
-	if (amd_uncore_llc)
-		uncore_online(cpu, amd_uncore_llc);
+	return 0;
+}
+
+static int amd_uncore_cpu_dead(unsigned int cpu)
+{
+	struct amd_uncore_ctx *ctx;
+	struct amd_uncore_pmu *pmu;
+	int i;
+
+	for (i = 0; i < num_pmus; i++) {
+		pmu = &pmus[i];
+		ctx = *per_cpu_ptr(pmu->ctx, cpu);
+		if (cpu == ctx->cpu)
+			cpumask_clear_cpu(cpu, &pmu->active_mask);
+
+		if (!--ctx->refcnt) {
+			kfree(ctx->events);
+			kfree(ctx);
+		}
+
+		*per_cpu_ptr(pmu->ctx, cpu) = NULL;
+	}
 
 	return 0;
 }
 
-static void uncore_down_prepare(unsigned int cpu,
-				struct amd_uncore * __percpu *uncores)
+static int amd_uncore_df_id(unsigned int cpu)
 {
-	unsigned int i;
-	struct amd_uncore *this = *per_cpu_ptr(uncores, cpu);
+	unsigned int eax, ebx, ecx, edx;
 
-	if (this->cpu != cpu)
-		return;
+	cpuid(0x8000001e, &eax, &ebx, &ecx, &edx);
 
-	/* this cpu is going down, migrate to a shared sibling if possible */
-	for_each_online_cpu(i) {
-		struct amd_uncore *that = *per_cpu_ptr(uncores, i);
+	return ecx & 0xff;
+}
 
-		if (cpu == i)
-			continue;
+static int amd_uncore_df_event_init(struct perf_event *event)
+{
+	struct hw_perf_event *hwc = &event->hw;
+	int ret = amd_uncore_event_init(event);
 
-		if (this == that) {
-			perf_pmu_migrate_context(this->pmu, cpu, i);
-			cpumask_clear_cpu(cpu, that->active_mask);
-			cpumask_set_cpu(i, that->active_mask);
-			that->cpu = i;
-			break;
-		}
-	}
+	if (ret || pmu_version < 2)
+		return ret;
+
+	hwc->config = event->attr.config &
+		      (pmu_version >= 2 ? AMD64_PERFMON_V2_RAW_EVENT_MASK_NB :
+					  AMD64_RAW_EVENT_MASK_NB);
+
+	return 0;
 }
 
-static int amd_uncore_cpu_down_prepare(unsigned int cpu)
+static int amd_uncore_df_add(struct perf_event *event, int flags)
 {
-	if (amd_uncore_nb)
-		uncore_down_prepare(cpu, amd_uncore_nb);
+	int ret = amd_uncore_add(event, flags & ~PERF_EF_START);
+	struct hw_perf_event *hwc = &event->hw;
+
+	if (ret)
+		return ret;
+
+	/*
+	 * The first four DF counters are accessible via RDPMC index 6 to 9
+	 * followed by the L3 counters from index 10 to 15. For processors
+	 * with more than four DF counters, the DF RDPMC assignments become
+	 * discontiguous as the additional counters are accessible starting
+	 * from index 16.
+	 */
+	if (hwc->idx >= NUM_COUNTERS_NB)
+		hwc->event_base_rdpmc += NUM_COUNTERS_L3;
 
-	if (amd_uncore_llc)
-		uncore_down_prepare(cpu, amd_uncore_llc);
+	/* Delayed start after rdpmc base update */
+	if (flags & PERF_EF_START)
+		amd_uncore_start(event, PERF_EF_RELOAD);
 
 	return 0;
 }
 
-static void uncore_dead(unsigned int cpu, struct amd_uncore * __percpu *uncores)
+static int amd_uncore_df_init(void)
 {
-	struct amd_uncore *uncore = *per_cpu_ptr(uncores, cpu);
+	struct attribute **df_attr = amd_uncore_df_format_attr;
+	struct amd_uncore_pmu *pmu = &pmus[num_pmus];
+	union cpuid_0x80000022_ebx ebx;
+	int ret;
 
-	if (cpu == uncore->cpu)
-		cpumask_clear_cpu(cpu, uncore->active_mask);
+	if (!boot_cpu_has(X86_FEATURE_PERFCTR_NB))
+		return 0;
 
-	if (!--uncore->refcnt) {
-		kfree(uncore->events);
-		kfree(uncore);
+	/*
+	 * For Family 17h and above, the Northbridge counters are repurposed
+	 * as Data Fabric counters. The PMUs are exported based on family as
+	 * either NB or DF.
+	 */
+	strscpy(pmu->name, boot_cpu_data.x86 >= 0x17 ? "amd_df" : "amd_nb",
+		sizeof(pmu->name));
+
+	pmu->num_counters = NUM_COUNTERS_NB;
+	pmu->msr_base = MSR_F15H_NB_PERF_CTL;
+	pmu->rdpmc_base = RDPMC_BASE_NB;
+	pmu->id = amd_uncore_df_id;
+
+	if (pmu_version >= 2) {
+		*df_attr++ = &format_attr_event14v2.attr;
+		*df_attr++ = &format_attr_umask12.attr;
+		ebx.full = cpuid_ebx(EXT_PERFMON_DEBUG_FEATURES);
+		pmu->num_counters = ebx.split.num_df_pmc;
+	} else if (boot_cpu_data.x86 >= 0x17) {
+		*df_attr = &format_attr_event14.attr;
+	}
+
+	pmu->ctx = alloc_percpu(struct amd_uncore_ctx *);
+	if (!pmu->ctx)
+		return -ENOMEM;
+
+	pmu->pmu = (struct pmu) {
+		.task_ctx_nr	= perf_invalid_context,
+		.attr_groups	= amd_uncore_df_attr_groups,
+		.name		= pmu->name,
+		.event_init	= amd_uncore_df_event_init,
+		.add		= amd_uncore_df_add,
+		.del		= amd_uncore_del,
+		.start		= amd_uncore_start,
+		.stop		= amd_uncore_stop,
+		.read		= amd_uncore_read,
+		.capabilities	= PERF_PMU_CAP_NO_EXCLUDE | PERF_PMU_CAP_NO_INTERRUPT,
+		.module		= THIS_MODULE,
+	};
+
+	ret = perf_pmu_register(&pmu->pmu, pmu->pmu.name, -1);
+	if (ret) {
+		free_percpu(pmu->ctx);
+		pmu->ctx = NULL;
+		return ret;
 	}
 
-	*per_cpu_ptr(uncores, cpu) = NULL;
+	pr_info("%d %s %s counters detected\n", pmu->num_counters,
+		boot_cpu_data.x86_vendor == X86_VENDOR_HYGON ?  "HYGON" : "",
+		pmu->pmu.name);
+
+	num_pmus++;
+
+	return 0;
 }
 
-static int amd_uncore_cpu_dead(unsigned int cpu)
+static int amd_uncore_l3_id(unsigned int cpu)
 {
-	if (amd_uncore_nb)
-		uncore_dead(cpu, amd_uncore_nb);
+	return get_llc_id(cpu);
+}
+
+static int amd_uncore_l3_event_init(struct perf_event *event)
+{
+	int ret = amd_uncore_event_init(event);
+	struct hw_perf_event *hwc = &event->hw;
+	u64 config = event->attr.config;
+	u64 mask;
+
+	hwc->config = config & AMD64_RAW_EVENT_MASK_NB;
+
+	/*
+	 * SliceMask and ThreadMask need to be set for certain L3 events.
+	 * For other events, the two fields do not affect the count.
+	 */
+	if (ret || boot_cpu_data.x86 < 0x17)
+		return ret;
+
+	mask = config & (AMD64_L3_F19H_THREAD_MASK | AMD64_L3_SLICEID_MASK |
+			 AMD64_L3_EN_ALL_CORES | AMD64_L3_EN_ALL_SLICES |
+			 AMD64_L3_COREID_MASK);
+
+	if (boot_cpu_data.x86 <= 0x18)
+		mask = ((config & AMD64_L3_SLICE_MASK) ? : AMD64_L3_SLICE_MASK) |
+		       ((config & AMD64_L3_THREAD_MASK) ? : AMD64_L3_THREAD_MASK);
+
+	/*
+	 * If the user doesn't specify a ThreadMask, they're not trying to
+	 * count core 0, so we enable all cores & threads.
+	 * We'll also assume that they want to count slice 0 if they specify
+	 * a ThreadMask and leave SliceId and EnAllSlices unpopulated.
+	 */
+	else if (!(config & AMD64_L3_F19H_THREAD_MASK))
+		mask = AMD64_L3_F19H_THREAD_MASK | AMD64_L3_EN_ALL_SLICES |
+		       AMD64_L3_EN_ALL_CORES;
 
-	if (amd_uncore_llc)
-		uncore_dead(cpu, amd_uncore_llc);
+	hwc->config |= mask;
 
 	return 0;
 }
 
-static int __init amd_uncore_init(void)
+static int amd_uncore_l3_init(void)
 {
-	struct attribute **df_attr = amd_uncore_df_format_attr;
 	struct attribute **l3_attr = amd_uncore_l3_format_attr;
-	union cpuid_0x80000022_ebx ebx;
-	int ret = -ENODEV;
+	struct amd_uncore_pmu *pmu = &pmus[num_pmus];
+	int ret;
 
-	if (boot_cpu_data.x86_vendor != X86_VENDOR_AMD &&
-	    boot_cpu_data.x86_vendor != X86_VENDOR_HYGON)
-		return -ENODEV;
+	if (!boot_cpu_has(X86_FEATURE_PERFCTR_LLC))
+		return 0;
 
-	if (!boot_cpu_has(X86_FEATURE_TOPOEXT))
-		return -ENODEV;
+	/*
+	 * For Family 17h and above, L3 cache counters are available instead
+	 * of L2 cache counters. The PMUs are exported based on family as
+	 * either L2 or L3.
+	 */
+	strscpy(pmu->name, boot_cpu_data.x86 >= 0x17 ? "amd_l3" : "amd_l2",
+		sizeof(pmu->name));
 
-	if (boot_cpu_has(X86_FEATURE_PERFMON_V2))
-		pmu_version = 2;
+	pmu->num_counters = NUM_COUNTERS_L2;
+	pmu->msr_base = MSR_F16H_L2I_PERF_CTL;
+	pmu->rdpmc_base = RDPMC_BASE_LLC;
+	pmu->id = amd_uncore_l3_id;
 
-	num_counters_nb	= NUM_COUNTERS_NB;
-	num_counters_llc = NUM_COUNTERS_L2;
 	if (boot_cpu_data.x86 >= 0x17) {
-		/*
-		 * For F17h and above, the Northbridge counters are
-		 * repurposed as Data Fabric counters. Also, L3
-		 * counters are supported too. The PMUs are exported
-		 * based on family as either L2 or L3 and NB or DF.
-		 */
-		num_counters_llc	  = NUM_COUNTERS_L3;
-		amd_nb_pmu.name		  = "amd_df";
-		amd_llc_pmu.name	  = "amd_l3";
-		l3_mask			  = true;
+		*l3_attr++ = &format_attr_event8.attr;
+		*l3_attr++ = &format_attr_umask8.attr;
+		*l3_attr++ = boot_cpu_data.x86 >= 0x19 ?
+			     &format_attr_threadmask2.attr :
+			     &format_attr_threadmask8.attr;
+		pmu->num_counters = NUM_COUNTERS_L3;
 	}
 
-	if (boot_cpu_has(X86_FEATURE_PERFCTR_NB)) {
-		if (pmu_version >= 2) {
-			*df_attr++ = &format_attr_event14v2.attr;
-			*df_attr++ = &format_attr_umask12.attr;
-		} else if (boot_cpu_data.x86 >= 0x17) {
-			*df_attr = &format_attr_event14.attr;
-		}
+	pmu->ctx = alloc_percpu(struct amd_uncore_ctx *);
+	if (!pmu->ctx)
+		return -ENOMEM;
+
+	pmu->pmu = (struct pmu) {
+		.task_ctx_nr	= perf_invalid_context,
+		.attr_groups	= amd_uncore_l3_attr_groups,
+		.attr_update	= amd_uncore_l3_attr_update,
+		.name		= pmu->name,
+		.event_init	= amd_uncore_l3_event_init,
+		.add		= amd_uncore_add,
+		.del		= amd_uncore_del,
+		.start		= amd_uncore_start,
+		.stop		= amd_uncore_stop,
+		.read		= amd_uncore_read,
+		.capabilities	= PERF_PMU_CAP_NO_EXCLUDE | PERF_PMU_CAP_NO_INTERRUPT,
+		.module		= THIS_MODULE,
+	};
+
+	ret = perf_pmu_register(&pmu->pmu, pmu->pmu.name, -1);
+	if (ret) {
+		free_percpu(pmu->ctx);
+		pmu->ctx = NULL;
+		return ret;
+	}
 
-		amd_uncore_nb = alloc_percpu(struct amd_uncore *);
-		if (!amd_uncore_nb) {
-			ret = -ENOMEM;
-			goto fail_nb;
-		}
-		ret = perf_pmu_register(&amd_nb_pmu, amd_nb_pmu.name, -1);
-		if (ret)
-			goto fail_nb;
+	pr_info("%d %s %s counters detected\n", pmu->num_counters,
+		boot_cpu_data.x86_vendor == X86_VENDOR_HYGON ?  "HYGON" : "",
+		pmu->pmu.name);
 
-		if (pmu_version >= 2) {
-			ebx.full = cpuid_ebx(EXT_PERFMON_DEBUG_FEATURES);
-			num_counters_nb = ebx.split.num_df_pmc;
-		}
+	num_pmus++;
 
-		pr_info("%d %s %s counters detected\n", num_counters_nb,
-			boot_cpu_data.x86_vendor == X86_VENDOR_HYGON ?  "HYGON" : "",
-			amd_nb_pmu.name);
+	return 0;
+}
 
-		ret = 0;
-	}
+static void uncore_free(void)
+{
+	struct amd_uncore_pmu *pmu;
+	int i;
 
-	if (boot_cpu_has(X86_FEATURE_PERFCTR_LLC)) {
-		if (boot_cpu_data.x86 >= 0x19) {
-			*l3_attr++ = &format_attr_event8.attr;
-			*l3_attr++ = &format_attr_umask8.attr;
-			*l3_attr++ = &format_attr_threadmask2.attr;
-		} else if (boot_cpu_data.x86 >= 0x17) {
-			*l3_attr++ = &format_attr_event8.attr;
-			*l3_attr++ = &format_attr_umask8.attr;
-			*l3_attr++ = &format_attr_threadmask8.attr;
-		}
+	for (i = 0; i < num_pmus; i++) {
+		pmu = &pmus[i];
+		if (!pmu->ctx)
+			continue;
 
-		amd_uncore_llc = alloc_percpu(struct amd_uncore *);
-		if (!amd_uncore_llc) {
-			ret = -ENOMEM;
-			goto fail_llc;
-		}
-		ret = perf_pmu_register(&amd_llc_pmu, amd_llc_pmu.name, -1);
-		if (ret)
-			goto fail_llc;
-
-		pr_info("%d %s %s counters detected\n", num_counters_llc,
-			boot_cpu_data.x86_vendor == X86_VENDOR_HYGON ?  "HYGON" : "",
-			amd_llc_pmu.name);
-		ret = 0;
+		perf_pmu_unregister(&pmu->pmu);
+		free_percpu(pmu->ctx);
+		pmu->ctx = NULL;
 	}
 
+	num_pmus = 0;
+}
+
+static int __init amd_uncore_init(void)
+{
+	int ret;
+
+	if (boot_cpu_data.x86_vendor != X86_VENDOR_AMD &&
+	    boot_cpu_data.x86_vendor != X86_VENDOR_HYGON)
+		return -ENODEV;
+
+	if (!boot_cpu_has(X86_FEATURE_TOPOEXT))
+		return -ENODEV;
+
+	if (boot_cpu_has(X86_FEATURE_PERFMON_V2))
+		pmu_version = 2;
+
+	ret = amd_uncore_df_init();
+	if (ret)
+		goto fail;
+
+	ret = amd_uncore_l3_init();
+	if (ret)
+		goto fail;
+
 	/*
 	 * Install callbacks. Core will call them for each online cpu.
 	 */
 	if (cpuhp_setup_state(CPUHP_PERF_X86_AMD_UNCORE_PREP,
 			      "perf/x86/amd/uncore:prepare",
 			      amd_uncore_cpu_up_prepare, amd_uncore_cpu_dead))
-		goto fail_llc;
+		goto fail;
 
 	if (cpuhp_setup_state(CPUHP_AP_PERF_X86_AMD_UNCORE_STARTING,
 			      "perf/x86/amd/uncore:starting",
@@ -753,12 +789,8 @@ fail_start:
 	cpuhp_remove_state(CPUHP_AP_PERF_X86_AMD_UNCORE_STARTING);
 fail_prep:
 	cpuhp_remove_state(CPUHP_PERF_X86_AMD_UNCORE_PREP);
-fail_llc:
-	if (boot_cpu_has(X86_FEATURE_PERFCTR_NB))
-		perf_pmu_unregister(&amd_nb_pmu);
-	free_percpu(amd_uncore_llc);
-fail_nb:
-	free_percpu(amd_uncore_nb);
+fail:
+	uncore_free();
 
 	return ret;
 }
@@ -768,18 +800,7 @@ static void __exit amd_uncore_exit(void)
 	cpuhp_remove_state(CPUHP_AP_PERF_X86_AMD_UNCORE_ONLINE);
 	cpuhp_remove_state(CPUHP_AP_PERF_X86_AMD_UNCORE_STARTING);
 	cpuhp_remove_state(CPUHP_PERF_X86_AMD_UNCORE_PREP);
-
-	if (boot_cpu_has(X86_FEATURE_PERFCTR_LLC)) {
-		perf_pmu_unregister(&amd_llc_pmu);
-		free_percpu(amd_uncore_llc);
-		amd_uncore_llc = NULL;
-	}
-
-	if (boot_cpu_has(X86_FEATURE_PERFCTR_NB)) {
-		perf_pmu_unregister(&amd_nb_pmu);
-		free_percpu(amd_uncore_nb);
-		amd_uncore_nb = NULL;
-	}
+	uncore_free();
 }
 
 module_init(amd_uncore_init);
