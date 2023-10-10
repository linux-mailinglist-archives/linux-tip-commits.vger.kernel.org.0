Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B4847BF585
	for <lists+linux-tip-commits@lfdr.de>; Tue, 10 Oct 2023 10:19:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442728AbjJJITg (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Tue, 10 Oct 2023 04:19:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442722AbjJJITe (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Tue, 10 Oct 2023 04:19:34 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04D75C4;
        Tue, 10 Oct 2023 01:19:32 -0700 (PDT)
Date:   Tue, 10 Oct 2023 08:19:30 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1696925970;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2JShZ/qmS4R4hJHfCI29gW1zZ9Q1M+ckFvNFyFRnGeQ=;
        b=b3p9T0LPE2dxXNqdwxWFSajFq+7VGc9YQy8aikOQCIdZw+DKUYmf/LChJu9/zZs/0nOekt
        2KSfT3qvejiwAkpG2QlBHCGIYUDYZ1UoD/x645eoSbv3OytFdz+COq2JqcjpUnDYmBQdkO
        He7K4kDl9aOcc2+wmwyPEBbLBi+l2TqOYgOpyCdUqVwm4hgF5TGj/nqyNajAsTCCSxg1vn
        UVrgQkuU0SAA45FwdXUglWHWCw6fYWkBV0hqe8EXCqmTjbiqKU770WjjQRc5EG7ySte7P4
        S/Hn8iTO7Ef3Gl4aqTmiISfq1SZk7LSZOHwI98yUWZFq+iEult1mPR39ejvtoQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1696925970;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2JShZ/qmS4R4hJHfCI29gW1zZ9Q1M+ckFvNFyFRnGeQ=;
        b=fvKhOTe2MosIBAVsiI5FXlj36nl5OO5W5lod5gBIW6CMNowgKkYf9hVpZGR4yyHPzvbz0W
        hOf6uwFK6J7wsoAA==
From:   "tip-bot2 for Sandipan Das" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf/x86/amd/uncore: Move discovery and registration
Cc:     Sandipan Das <sandipan.das@amd.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: =?utf-8?q?=3Ce6c447e48872fcab8452e0dd81b1c9cb09f39eb4=2E16964?=
 =?utf-8?q?25185=2Egit=2Esandipan=2Edas=40amd=2Ecom=3E?=
References: =?utf-8?q?=3Ce6c447e48872fcab8452e0dd81b1c9cb09f39eb4=2E169642?=
 =?utf-8?q?5185=2Egit=2Esandipan=2Edas=40amd=2Ecom=3E?=
MIME-Version: 1.0
Message-ID: <169692597000.3135.5055717684957726771.tip-bot2@tip-bot2>
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

Commit-ID:     07888daa056e809de0b6b234116b575c11f9f99d
Gitweb:        https://git.kernel.org/tip/07888daa056e809de0b6b234116b575c11f9f99d
Author:        Sandipan Das <sandipan.das@amd.com>
AuthorDate:    Thu, 05 Oct 2023 10:53:12 +05:30
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 09 Oct 2023 16:12:23 +02:00

perf/x86/amd/uncore: Move discovery and registration

Uncore PMUs have traditionally been registered in the module init path.
This is fine for the existing DF and L3 PMUs since the CPUID information
does not vary across CPUs but not for the memory controller (UMC) PMUs
since information like active memory channels can vary for each socket
depending on how the DIMMs have been physically populated.

To overcome this, the discovery of PMU information using CPUID is moved
to the startup of UNCORE_STARTING. This cannot be done in the startup of
UNCORE_PREP since the hotplug callback does not run on the CPU that is
being brought online.

Previously, the startup of UNCORE_PREP was used for allocating uncore
contexts following which, the startup of UNCORE_STARTING was used to
find and reuse an existing sibling context, if possible. Any unused
contexts were added to a list for reclaimation later during the startup
of UNCORE_ONLINE.

Since all required CPUID info is now available only after the startup of
UNCORE_STARTING has completed, context allocation has been moved to the
startup of UNCORE_ONLINE. Before allocating contexts, the first CPU that
comes online has to take up the additional responsibility of registering
the PMUs. This is a one-time process though. Since sibling discovery now
happens prior to deciding whether a new context is required, there is no
longer a need to track and free up unused contexts.

The teardown of UNCORE_ONLINE and UNCORE_PREP functionally remain the
same.

Overall, the flow of control described above is achieved using the
following handlers for managing uncore PMUs. It is mandatory to define
them for each type of uncore PMU.

  * scan() runs during startup of UNCORE_STARTING and collects PMU info
    using CPUID.

  * init() runs during startup of UNCORE_ONLINE, registers PMUs and sets
    up uncore contexts.

  * move() runs during teardown of UNCORE_ONLINE and migrates uncore
    contexts to a shared sibling, if possible.

  * free() runs during teardown of UNCORE_PREP and frees up uncore
    contexts.

Signed-off-by: Sandipan Das <sandipan.das@amd.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/r/e6c447e48872fcab8452e0dd81b1c9cb09f39eb4.1696425185.git.sandipan.das@amd.com
---
 arch/x86/events/amd/uncore.c | 494 ++++++++++++++++++++--------------
 1 file changed, 305 insertions(+), 189 deletions(-)

diff --git a/arch/x86/events/amd/uncore.c b/arch/x86/events/amd/uncore.c
index ffcecda..ff1d09c 100644
--- a/arch/x86/events/amd/uncore.c
+++ b/arch/x86/events/amd/uncore.c
@@ -26,8 +26,6 @@
 #define RDPMC_BASE_LLC		10
 
 #define COUNTER_SHIFT		16
-
-#define NUM_UNCORES_MAX		2	/* DF (or NB) and L3 (or L2) */
 #define UNCORE_NAME_LEN		16
 
 #undef pr_fmt
@@ -35,10 +33,7 @@
 
 static int pmu_version;
 
-static HLIST_HEAD(uncore_unused_list);
-
 struct amd_uncore_ctx {
-	int id;
 	int refcnt;
 	int cpu;
 	struct perf_event **events;
@@ -53,11 +48,36 @@ struct amd_uncore_pmu {
 	cpumask_t active_mask;
 	struct pmu pmu;
 	struct amd_uncore_ctx * __percpu *ctx;
-	int (*id)(unsigned int cpu);
 };
 
-static struct amd_uncore_pmu pmus[NUM_UNCORES_MAX];
-static int num_pmus __read_mostly;
+enum {
+	UNCORE_TYPE_DF,
+	UNCORE_TYPE_L3,
+
+	UNCORE_TYPE_MAX
+};
+
+union amd_uncore_info {
+	struct {
+		u64	aux_data:32;	/* auxiliary data */
+		u64	num_pmcs:8;	/* number of counters */
+		u64	cid:8;		/* context id */
+	} split;
+	u64		full;
+};
+
+struct amd_uncore {
+	union amd_uncore_info * __percpu info;
+	struct amd_uncore_pmu *pmus;
+	unsigned int num_pmus;
+	bool init_done;
+	void (*scan)(struct amd_uncore *uncore, unsigned int cpu);
+	int  (*init)(struct amd_uncore *uncore, unsigned int cpu);
+	void (*move)(struct amd_uncore *uncore, unsigned int cpu);
+	void (*free)(struct amd_uncore *uncore, unsigned int cpu);
+};
+
+static struct amd_uncore uncores[UNCORE_TYPE_MAX];
 
 static struct amd_uncore_pmu *event_to_amd_uncore_pmu(struct perf_event *event)
 {
@@ -332,182 +352,192 @@ static const struct attribute_group *amd_uncore_l3_attr_update[] = {
 	NULL,
 };
 
-static int amd_uncore_cpu_up_prepare(unsigned int cpu)
+static __always_inline
+int amd_uncore_ctx_cid(struct amd_uncore *uncore, unsigned int cpu)
 {
-	struct amd_uncore_pmu *pmu;
-	struct amd_uncore_ctx *ctx;
-	int node = cpu_to_node(cpu), i;
-
-	for (i = 0; i < num_pmus; i++) {
-		pmu = &pmus[i];
-		*per_cpu_ptr(pmu->ctx, cpu) = NULL;
-		ctx = kzalloc_node(sizeof(struct amd_uncore_ctx), GFP_KERNEL,
-				   node);
-		if (!ctx)
-			goto fail;
-
-		ctx->cpu = cpu;
-		ctx->events = kzalloc_node(sizeof(struct perf_event *) *
-					   pmu->num_counters, GFP_KERNEL,
-					   node);
-		if (!ctx->events)
-			goto fail;
-
-		ctx->id = -1;
-		*per_cpu_ptr(pmu->ctx, cpu) = ctx;
-	}
-
-	return 0;
-
-fail:
-	/* Rollback */
-	for (; i >= 0; i--) {
-		pmu = &pmus[i];
-		ctx = *per_cpu_ptr(pmu->ctx, cpu);
-		if (!ctx)
-			continue;
-
-		kfree(ctx->events);
-		kfree(ctx);
-	}
+	union amd_uncore_info *info = per_cpu_ptr(uncore->info, cpu);
+	return info->split.cid;
+}
 
-	return -ENOMEM;
+static __always_inline
+int amd_uncore_ctx_num_pmcs(struct amd_uncore *uncore, unsigned int cpu)
+{
+	union amd_uncore_info *info = per_cpu_ptr(uncore->info, cpu);
+	return info->split.num_pmcs;
 }
 
-static struct amd_uncore_ctx *
-amd_uncore_find_online_sibling(struct amd_uncore_ctx *this,
-			       struct amd_uncore_pmu *pmu)
+static void amd_uncore_ctx_free(struct amd_uncore *uncore, unsigned int cpu)
 {
-	unsigned int cpu;
-	struct amd_uncore_ctx *that;
+	struct amd_uncore_pmu *pmu;
+	struct amd_uncore_ctx *ctx;
+	int i;
 
-	for_each_online_cpu(cpu) {
-		that = *per_cpu_ptr(pmu->ctx, cpu);
+	if (!uncore->init_done)
+		return;
 
-		if (!that)
+	for (i = 0; i < uncore->num_pmus; i++) {
+		pmu = &uncore->pmus[i];
+		ctx = *per_cpu_ptr(pmu->ctx, cpu);
+		if (!ctx)
 			continue;
 
-		if (this == that)
-			continue;
+		if (cpu == ctx->cpu)
+			cpumask_clear_cpu(cpu, &pmu->active_mask);
 
-		if (this->id == that->id) {
-			hlist_add_head(&this->node, &uncore_unused_list);
-			this = that;
-			break;
+		if (!--ctx->refcnt) {
+			kfree(ctx->events);
+			kfree(ctx);
 		}
-	}
 
-	this->refcnt++;
-	return this;
+		*per_cpu_ptr(pmu->ctx, cpu) = NULL;
+	}
 }
 
-static int amd_uncore_cpu_starting(unsigned int cpu)
+static int amd_uncore_ctx_init(struct amd_uncore *uncore, unsigned int cpu)
 {
+	struct amd_uncore_ctx *curr, *prev;
 	struct amd_uncore_pmu *pmu;
-	struct amd_uncore_ctx *ctx;
-	int i;
+	int node, cid, i, j;
 
-	for (i = 0; i < num_pmus; i++) {
-		pmu = &pmus[i];
-		ctx = *per_cpu_ptr(pmu->ctx, cpu);
-		ctx->id = pmu->id(cpu);
-		ctx = amd_uncore_find_online_sibling(ctx, pmu);
-		*per_cpu_ptr(pmu->ctx, cpu) = ctx;
-	}
+	if (!uncore->init_done || !uncore->num_pmus)
+		return 0;
 
-	return 0;
-}
+	cid = amd_uncore_ctx_cid(uncore, cpu);
 
-static void uncore_clean_online(void)
-{
-	struct amd_uncore_ctx *ctx;
-	struct hlist_node *n;
+	for (i = 0; i < uncore->num_pmus; i++) {
+		pmu = &uncore->pmus[i];
+		*per_cpu_ptr(pmu->ctx, cpu) = NULL;
+		curr = NULL;
 
-	hlist_for_each_entry_safe(ctx, n, &uncore_unused_list, node) {
-		hlist_del(&ctx->node);
-		kfree(ctx->events);
-		kfree(ctx);
-	}
-}
+		/* Find a sibling context */
+		for_each_online_cpu(j) {
+			if (cpu == j)
+				continue;
 
-static int amd_uncore_cpu_online(unsigned int cpu)
-{
-	struct amd_uncore_pmu *pmu;
-	struct amd_uncore_ctx *ctx;
-	int i;
+			prev = *per_cpu_ptr(pmu->ctx, j);
+			if (!prev)
+				continue;
 
-	uncore_clean_online();
+			if (cid == amd_uncore_ctx_cid(uncore, j)) {
+				curr = prev;
+				break;
+			}
+		}
+
+		/* Allocate context if sibling does not exist */
+		if (!curr) {
+			node = cpu_to_node(cpu);
+			curr = kzalloc_node(sizeof(*curr), GFP_KERNEL, node);
+			if (!curr)
+				goto fail;
+
+			curr->cpu = cpu;
+			curr->events = kzalloc_node(sizeof(*curr->events) *
+						    pmu->num_counters,
+						    GFP_KERNEL, node);
+			if (!curr->events) {
+				kfree(curr);
+				goto fail;
+			}
 
-	for (i = 0; i < num_pmus; i++) {
-		pmu = &pmus[i];
-		ctx = *per_cpu_ptr(pmu->ctx, cpu);
-		if (cpu == ctx->cpu)
 			cpumask_set_cpu(cpu, &pmu->active_mask);
+		}
+
+		curr->refcnt++;
+		*per_cpu_ptr(pmu->ctx, cpu) = curr;
 	}
 
 	return 0;
+
+fail:
+	amd_uncore_ctx_free(uncore, cpu);
+
+	return -ENOMEM;
 }
 
-static int amd_uncore_cpu_down_prepare(unsigned int cpu)
+static void amd_uncore_ctx_move(struct amd_uncore *uncore, unsigned int cpu)
 {
-	struct amd_uncore_ctx *this, *that;
+	struct amd_uncore_ctx *curr, *next;
 	struct amd_uncore_pmu *pmu;
 	int i, j;
 
-	for (i = 0; i < num_pmus; i++) {
-		pmu = &pmus[i];
-		this = *per_cpu_ptr(pmu->ctx, cpu);
+	if (!uncore->init_done)
+		return;
 
-		/* this cpu is going down, migrate to a shared sibling if possible */
-		for_each_online_cpu(j) {
-			that = *per_cpu_ptr(pmu->ctx, j);
+	for (i = 0; i < uncore->num_pmus; i++) {
+		pmu = &uncore->pmus[i];
+		curr = *per_cpu_ptr(pmu->ctx, cpu);
+		if (!curr)
+			continue;
 
-			if (cpu == j)
+		/* Migrate to a shared sibling if possible */
+		for_each_online_cpu(j) {
+			next = *per_cpu_ptr(pmu->ctx, j);
+			if (!next || cpu == j)
 				continue;
 
-			if (this == that) {
+			if (curr == next) {
 				perf_pmu_migrate_context(&pmu->pmu, cpu, j);
 				cpumask_clear_cpu(cpu, &pmu->active_mask);
 				cpumask_set_cpu(j, &pmu->active_mask);
-				that->cpu = j;
+				next->cpu = j;
 				break;
 			}
 		}
 	}
+}
+
+static int amd_uncore_cpu_starting(unsigned int cpu)
+{
+	struct amd_uncore *uncore;
+	int i;
+
+	for (i = 0; i < UNCORE_TYPE_MAX; i++) {
+		uncore = &uncores[i];
+		uncore->scan(uncore, cpu);
+	}
 
 	return 0;
 }
 
-static int amd_uncore_cpu_dead(unsigned int cpu)
+static int amd_uncore_cpu_online(unsigned int cpu)
 {
-	struct amd_uncore_ctx *ctx;
-	struct amd_uncore_pmu *pmu;
+	struct amd_uncore *uncore;
 	int i;
 
-	for (i = 0; i < num_pmus; i++) {
-		pmu = &pmus[i];
-		ctx = *per_cpu_ptr(pmu->ctx, cpu);
-		if (cpu == ctx->cpu)
-			cpumask_clear_cpu(cpu, &pmu->active_mask);
+	for (i = 0; i < UNCORE_TYPE_MAX; i++) {
+		uncore = &uncores[i];
+		if (uncore->init(uncore, cpu))
+			break;
+	}
 
-		if (!--ctx->refcnt) {
-			kfree(ctx->events);
-			kfree(ctx);
-		}
+	return 0;
+}
 
-		*per_cpu_ptr(pmu->ctx, cpu) = NULL;
+static int amd_uncore_cpu_down_prepare(unsigned int cpu)
+{
+	struct amd_uncore *uncore;
+	int i;
+
+	for (i = 0; i < UNCORE_TYPE_MAX; i++) {
+		uncore = &uncores[i];
+		uncore->move(uncore, cpu);
 	}
 
 	return 0;
 }
 
-static int amd_uncore_df_id(unsigned int cpu)
+static int amd_uncore_cpu_dead(unsigned int cpu)
 {
-	unsigned int eax, ebx, ecx, edx;
+	struct amd_uncore *uncore;
+	int i;
 
-	cpuid(0x8000001e, &eax, &ebx, &ecx, &edx);
+	for (i = 0; i < UNCORE_TYPE_MAX; i++) {
+		uncore = &uncores[i];
+		uncore->free(uncore, cpu);
+	}
 
-	return ecx & 0xff;
+	return 0;
 }
 
 static int amd_uncore_df_event_init(struct perf_event *event)
@@ -550,41 +580,66 @@ static int amd_uncore_df_add(struct perf_event *event, int flags)
 	return 0;
 }
 
-static int amd_uncore_df_init(void)
+static
+void amd_uncore_df_ctx_scan(struct amd_uncore *uncore, unsigned int cpu)
 {
-	struct attribute **df_attr = amd_uncore_df_format_attr;
-	struct amd_uncore_pmu *pmu = &pmus[num_pmus];
 	union cpuid_0x80000022_ebx ebx;
-	int ret;
+	union amd_uncore_info info;
 
 	if (!boot_cpu_has(X86_FEATURE_PERFCTR_NB))
-		return 0;
+		return;
+
+	info.split.aux_data = 0;
+	info.split.num_pmcs = NUM_COUNTERS_NB;
+	info.split.cid = topology_die_id(cpu);
+
+	if (pmu_version >= 2) {
+		ebx.full = cpuid_ebx(EXT_PERFMON_DEBUG_FEATURES);
+		info.split.num_pmcs = ebx.split.num_df_pmc;
+	}
+
+	*per_cpu_ptr(uncore->info, cpu) = info;
+}
+
+static
+int amd_uncore_df_ctx_init(struct amd_uncore *uncore, unsigned int cpu)
+{
+	struct attribute **df_attr = amd_uncore_df_format_attr;
+	struct amd_uncore_pmu *pmu;
+
+	/* Run just once */
+	if (uncore->init_done)
+		return amd_uncore_ctx_init(uncore, cpu);
+
+	/* No grouping, single instance for a system */
+	uncore->pmus = kzalloc(sizeof(*uncore->pmus), GFP_KERNEL);
+	if (!uncore->pmus) {
+		uncore->num_pmus = 0;
+		goto done;
+	}
 
 	/*
 	 * For Family 17h and above, the Northbridge counters are repurposed
 	 * as Data Fabric counters. The PMUs are exported based on family as
 	 * either NB or DF.
 	 */
+	pmu = &uncore->pmus[0];
 	strscpy(pmu->name, boot_cpu_data.x86 >= 0x17 ? "amd_df" : "amd_nb",
 		sizeof(pmu->name));
-
-	pmu->num_counters = NUM_COUNTERS_NB;
+	pmu->num_counters = amd_uncore_ctx_num_pmcs(uncore, cpu);
 	pmu->msr_base = MSR_F15H_NB_PERF_CTL;
 	pmu->rdpmc_base = RDPMC_BASE_NB;
-	pmu->id = amd_uncore_df_id;
 
 	if (pmu_version >= 2) {
 		*df_attr++ = &format_attr_event14v2.attr;
 		*df_attr++ = &format_attr_umask12.attr;
-		ebx.full = cpuid_ebx(EXT_PERFMON_DEBUG_FEATURES);
-		pmu->num_counters = ebx.split.num_df_pmc;
 	} else if (boot_cpu_data.x86 >= 0x17) {
 		*df_attr = &format_attr_event14.attr;
 	}
 
 	pmu->ctx = alloc_percpu(struct amd_uncore_ctx *);
 	if (!pmu->ctx)
-		return -ENOMEM;
+		goto done;
 
 	pmu->pmu = (struct pmu) {
 		.task_ctx_nr	= perf_invalid_context,
@@ -600,25 +655,22 @@ static int amd_uncore_df_init(void)
 		.module		= THIS_MODULE,
 	};
 
-	ret = perf_pmu_register(&pmu->pmu, pmu->pmu.name, -1);
-	if (ret) {
+	if (perf_pmu_register(&pmu->pmu, pmu->pmu.name, -1)) {
 		free_percpu(pmu->ctx);
 		pmu->ctx = NULL;
-		return ret;
+		goto done;
 	}
 
-	pr_info("%d %s %s counters detected\n", pmu->num_counters,
-		boot_cpu_data.x86_vendor == X86_VENDOR_HYGON ?  "HYGON" : "",
+	pr_info("%d %s%s counters detected\n", pmu->num_counters,
+		boot_cpu_data.x86_vendor == X86_VENDOR_HYGON ?  "HYGON " : "",
 		pmu->pmu.name);
 
-	num_pmus++;
+	uncore->num_pmus = 1;
 
-	return 0;
-}
+done:
+	uncore->init_done = true;
 
-static int amd_uncore_l3_id(unsigned int cpu)
-{
-	return get_llc_id(cpu);
+	return amd_uncore_ctx_init(uncore, cpu);
 }
 
 static int amd_uncore_l3_event_init(struct perf_event *event)
@@ -660,27 +712,52 @@ static int amd_uncore_l3_event_init(struct perf_event *event)
 	return 0;
 }
 
-static int amd_uncore_l3_init(void)
+static
+void amd_uncore_l3_ctx_scan(struct amd_uncore *uncore, unsigned int cpu)
 {
-	struct attribute **l3_attr = amd_uncore_l3_format_attr;
-	struct amd_uncore_pmu *pmu = &pmus[num_pmus];
-	int ret;
+	union amd_uncore_info info;
 
 	if (!boot_cpu_has(X86_FEATURE_PERFCTR_LLC))
-		return 0;
+		return;
+
+	info.split.aux_data = 0;
+	info.split.num_pmcs = NUM_COUNTERS_L2;
+	info.split.cid = get_llc_id(cpu);
+
+	if (boot_cpu_data.x86 >= 0x17)
+		info.split.num_pmcs = NUM_COUNTERS_L3;
+
+	*per_cpu_ptr(uncore->info, cpu) = info;
+}
+
+static
+int amd_uncore_l3_ctx_init(struct amd_uncore *uncore, unsigned int cpu)
+{
+	struct attribute **l3_attr = amd_uncore_l3_format_attr;
+	struct amd_uncore_pmu *pmu;
+
+	/* Run just once */
+	if (uncore->init_done)
+		return amd_uncore_ctx_init(uncore, cpu);
+
+	/* No grouping, single instance for a system */
+	uncore->pmus = kzalloc(sizeof(*uncore->pmus), GFP_KERNEL);
+	if (!uncore->pmus) {
+		uncore->num_pmus = 0;
+		goto done;
+	}
 
 	/*
 	 * For Family 17h and above, L3 cache counters are available instead
 	 * of L2 cache counters. The PMUs are exported based on family as
 	 * either L2 or L3.
 	 */
+	pmu = &uncore->pmus[0];
 	strscpy(pmu->name, boot_cpu_data.x86 >= 0x17 ? "amd_l3" : "amd_l2",
 		sizeof(pmu->name));
-
-	pmu->num_counters = NUM_COUNTERS_L2;
+	pmu->num_counters = amd_uncore_ctx_num_pmcs(uncore, cpu);
 	pmu->msr_base = MSR_F16H_L2I_PERF_CTL;
 	pmu->rdpmc_base = RDPMC_BASE_LLC;
-	pmu->id = amd_uncore_l3_id;
 
 	if (boot_cpu_data.x86 >= 0x17) {
 		*l3_attr++ = &format_attr_event8.attr;
@@ -688,12 +765,11 @@ static int amd_uncore_l3_init(void)
 		*l3_attr++ = boot_cpu_data.x86 >= 0x19 ?
 			     &format_attr_threadmask2.attr :
 			     &format_attr_threadmask8.attr;
-		pmu->num_counters = NUM_COUNTERS_L3;
 	}
 
 	pmu->ctx = alloc_percpu(struct amd_uncore_ctx *);
 	if (!pmu->ctx)
-		return -ENOMEM;
+		goto done;
 
 	pmu->pmu = (struct pmu) {
 		.task_ctx_nr	= perf_invalid_context,
@@ -710,43 +786,45 @@ static int amd_uncore_l3_init(void)
 		.module		= THIS_MODULE,
 	};
 
-	ret = perf_pmu_register(&pmu->pmu, pmu->pmu.name, -1);
-	if (ret) {
+	if (perf_pmu_register(&pmu->pmu, pmu->pmu.name, -1)) {
 		free_percpu(pmu->ctx);
 		pmu->ctx = NULL;
-		return ret;
+		goto done;
 	}
 
-	pr_info("%d %s %s counters detected\n", pmu->num_counters,
-		boot_cpu_data.x86_vendor == X86_VENDOR_HYGON ?  "HYGON" : "",
+	pr_info("%d %s%s counters detected\n", pmu->num_counters,
+		boot_cpu_data.x86_vendor == X86_VENDOR_HYGON ?  "HYGON " : "",
 		pmu->pmu.name);
 
-	num_pmus++;
-
-	return 0;
-}
-
-static void uncore_free(void)
-{
-	struct amd_uncore_pmu *pmu;
-	int i;
+	uncore->num_pmus = 1;
 
-	for (i = 0; i < num_pmus; i++) {
-		pmu = &pmus[i];
-		if (!pmu->ctx)
-			continue;
-
-		perf_pmu_unregister(&pmu->pmu);
-		free_percpu(pmu->ctx);
-		pmu->ctx = NULL;
-	}
+done:
+	uncore->init_done = true;
 
-	num_pmus = 0;
+	return amd_uncore_ctx_init(uncore, cpu);
 }
 
+static struct amd_uncore uncores[UNCORE_TYPE_MAX] = {
+	/* UNCORE_TYPE_DF */
+	{
+		.scan = amd_uncore_df_ctx_scan,
+		.init = amd_uncore_df_ctx_init,
+		.move = amd_uncore_ctx_move,
+		.free = amd_uncore_ctx_free,
+	},
+	/* UNCORE_TYPE_L3 */
+	{
+		.scan = amd_uncore_l3_ctx_scan,
+		.init = amd_uncore_l3_ctx_init,
+		.move = amd_uncore_ctx_move,
+		.free = amd_uncore_ctx_free,
+	},
+};
+
 static int __init amd_uncore_init(void)
 {
-	int ret;
+	struct amd_uncore *uncore;
+	int ret, i;
 
 	if (boot_cpu_data.x86_vendor != X86_VENDOR_AMD &&
 	    boot_cpu_data.x86_vendor != X86_VENDOR_HYGON)
@@ -758,20 +836,27 @@ static int __init amd_uncore_init(void)
 	if (boot_cpu_has(X86_FEATURE_PERFMON_V2))
 		pmu_version = 2;
 
-	ret = amd_uncore_df_init();
-	if (ret)
-		goto fail;
+	for (i = 0; i < UNCORE_TYPE_MAX; i++) {
+		uncore = &uncores[i];
 
-	ret = amd_uncore_l3_init();
-	if (ret)
-		goto fail;
+		BUG_ON(!uncore->scan);
+		BUG_ON(!uncore->init);
+		BUG_ON(!uncore->move);
+		BUG_ON(!uncore->free);
+
+		uncore->info = alloc_percpu(union amd_uncore_info);
+		if (!uncore->info) {
+			ret = -ENOMEM;
+			goto fail;
+		}
+	};
 
 	/*
 	 * Install callbacks. Core will call them for each online cpu.
 	 */
 	if (cpuhp_setup_state(CPUHP_PERF_X86_AMD_UNCORE_PREP,
 			      "perf/x86/amd/uncore:prepare",
-			      amd_uncore_cpu_up_prepare, amd_uncore_cpu_dead))
+			      NULL, amd_uncore_cpu_dead))
 		goto fail;
 
 	if (cpuhp_setup_state(CPUHP_AP_PERF_X86_AMD_UNCORE_STARTING,
@@ -790,17 +875,48 @@ fail_start:
 fail_prep:
 	cpuhp_remove_state(CPUHP_PERF_X86_AMD_UNCORE_PREP);
 fail:
-	uncore_free();
+	for (i = 0; i < UNCORE_TYPE_MAX; i++) {
+		uncore = &uncores[i];
+		if (uncore->info) {
+			free_percpu(uncore->info);
+			uncore->info = NULL;
+		}
+	}
 
 	return ret;
 }
 
 static void __exit amd_uncore_exit(void)
 {
+	struct amd_uncore *uncore;
+	struct amd_uncore_pmu *pmu;
+	int i, j;
+
 	cpuhp_remove_state(CPUHP_AP_PERF_X86_AMD_UNCORE_ONLINE);
 	cpuhp_remove_state(CPUHP_AP_PERF_X86_AMD_UNCORE_STARTING);
 	cpuhp_remove_state(CPUHP_PERF_X86_AMD_UNCORE_PREP);
-	uncore_free();
+
+	for (i = 0; i < UNCORE_TYPE_MAX; i++) {
+		uncore = &uncores[i];
+		if (!uncore->info)
+			continue;
+
+		free_percpu(uncore->info);
+		uncore->info = NULL;
+
+		for (j = 0; j < uncore->num_pmus; j++) {
+			pmu = &uncore->pmus[j];
+			if (!pmu->ctx)
+				continue;
+
+			perf_pmu_unregister(&pmu->pmu);
+			free_percpu(pmu->ctx);
+			pmu->ctx = NULL;
+		}
+
+		kfree(uncore->pmus);
+		uncore->pmus = NULL;
+	}
 }
 
 module_init(amd_uncore_init);
