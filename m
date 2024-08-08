Return-Path: <linux-tip-commits+bounces-2000-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 995A794BB1C
	for <lists+linux-tip-commits@lfdr.de>; Thu,  8 Aug 2024 12:33:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8E28B2845E5
	for <lists+linux-tip-commits@lfdr.de>; Thu,  8 Aug 2024 10:33:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F9E818C341;
	Thu,  8 Aug 2024 10:32:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="z4LsYiFt";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="LyCpCeQY"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBF5018A928;
	Thu,  8 Aug 2024 10:32:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723113133; cv=none; b=e3whAYeOBTzEad/lcAbWX7qitfJ5yx59buiUMghOsZuOGTOy5J6Ao0MZCdkgKbZhblIKBsewzdVOZmxpMXSuecZ/Ic9JUWFZWDrsU0QbMrqXvQus1my+i0QU66Zon63y9IxQcbOK91p4voqytRrE21jLc2CvI4thMw8qQWsUV2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723113133; c=relaxed/simple;
	bh=NO7UTvNwE5lGLo0vOd6UrASsiLTkPfYVXM3+511azFI=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=EL7OItWkC8uU5c5f1R99YZaan2VIwDLsvCTK2n7txfe0wQ0G1OWFWkL4AtfAFvHeiTSS2jxJVHcVgm3gf46iwPu9ipt/i4UJ5e0YT5B83WKpk7a6PE+ol7jgr9MSCNQISRkawqdgoGcDVgltjVi8ZZInHAlXYKF+XnERSnouOzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=z4LsYiFt; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=LyCpCeQY; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 08 Aug 2024 10:32:08 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1723113129;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WZtADNF1uBnPIl1a2/hbULiFMOj3SWM/P11CFAogtdk=;
	b=z4LsYiFtMg3iPaHDe6YmpB8zd5Qe1hfxfeFYLNs51oimrbxgMHvTzrJRDa/4ouITdn3gj0
	aK3ZMSMW2eU2yJfyidSYdKYv3JA85CDCMP7g6fd+T0zzQxs7IT6HMnT3UjpZAYqkLgoIGC
	l3FXsh0dFwz76+6owWq954k4+V1E+kI671xOSiTRSyF6KQlLhZI6UG06DPyPNt8/J3BabN
	anRWKfx+BSUQFhyS7n7p6tv8QTEWbgGQ+Qr2Srf1uPcbc+M0zwukVn5pW4rw9Ay3z4WLk3
	G8wbA+ELmu6xcAxP85KejaJ9T18TJXV1cxy3IPS8404Ys3W+xSpTxUCW7pqXcg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1723113129;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WZtADNF1uBnPIl1a2/hbULiFMOj3SWM/P11CFAogtdk=;
	b=LyCpCeQYS1CW5IJV3vxtsCQcAnAT4JNFmnwLGCnbuq2PptDxSMLjan3uj61X5vJ6VuC3Rm
	3aKk8XswCqufNKBw==
From: "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: perf/core] perf: Optimize context reschedule for single PMU cases
Cc: Namhyung Kim <namhyung@kernel.org>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Kan Liang <kan.liang@linux.intel.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240807115549.920950699@infradead.org>
References: <20240807115549.920950699@infradead.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172311312895.2215.1146187968080802121.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     2d17cf1abcbe8a45b7dc41a768ed22aac158ddd8
Gitweb:        https://git.kernel.org/tip/2d17cf1abcbe8a45b7dc41a768ed22aac158ddd8
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Wed, 07 Aug 2024 13:29:25 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Thu, 08 Aug 2024 12:27:31 +02:00

perf: Optimize context reschedule for single PMU cases

Currently re-scheduling a context will reschedule all active PMUs for
that context, even if it is known only a single event is added.

Namhyung reported that changing this to only reschedule the affected
PMU when possible provides significant performance gains under certain
conditions.

Therefore, allow partial context reschedules for a specific PMU, that
of the event modified.

While the patch looks somewhat noisy, it mostly just propagates a new
@pmu argument through the callchain and modifies the epc loop to only
pick the 'epc->pmu == @pmu' case.

Reported-by: Namhyung Kim <namhyung@kernel.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Kan Liang <kan.liang@linux.intel.com>
Reviewed-by: Namhyung Kim <namhyung@kernel.org>
Link: https://lore.kernel.org/r/20240807115549.920950699@infradead.org
---
 kernel/events/core.c | 164 ++++++++++++++++++++++--------------------
 1 file changed, 88 insertions(+), 76 deletions(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index c01a326..dad2b9a 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -685,30 +685,32 @@ do {									\
 	___p;								\
 })
 
+#define for_each_epc(_epc, _ctx, _pmu, _cgroup)				\
+	list_for_each_entry(_epc, &((_ctx)->pmu_ctx_list), pmu_ctx_entry) \
+		if (_cgroup && !_epc->nr_cgroups)			\
+			continue;					\
+		else if (_pmu && _epc->pmu != _pmu)			\
+			continue;					\
+		else
+
 static void perf_ctx_disable(struct perf_event_context *ctx, bool cgroup)
 {
 	struct perf_event_pmu_context *pmu_ctx;
 
-	list_for_each_entry(pmu_ctx, &ctx->pmu_ctx_list, pmu_ctx_entry) {
-		if (cgroup && !pmu_ctx->nr_cgroups)
-			continue;
+	for_each_epc(pmu_ctx, ctx, NULL, cgroup)
 		perf_pmu_disable(pmu_ctx->pmu);
-	}
 }
 
 static void perf_ctx_enable(struct perf_event_context *ctx, bool cgroup)
 {
 	struct perf_event_pmu_context *pmu_ctx;
 
-	list_for_each_entry(pmu_ctx, &ctx->pmu_ctx_list, pmu_ctx_entry) {
-		if (cgroup && !pmu_ctx->nr_cgroups)
-			continue;
+	for_each_epc(pmu_ctx, ctx, NULL, cgroup)
 		perf_pmu_enable(pmu_ctx->pmu);
-	}
 }
 
-static void ctx_sched_out(struct perf_event_context *ctx, enum event_type_t event_type);
-static void ctx_sched_in(struct perf_event_context *ctx, enum event_type_t event_type);
+static void ctx_sched_out(struct perf_event_context *ctx, struct pmu *pmu, enum event_type_t event_type);
+static void ctx_sched_in(struct perf_event_context *ctx, struct pmu *pmu, enum event_type_t event_type);
 
 #ifdef CONFIG_CGROUP_PERF
 
@@ -865,7 +867,7 @@ static void perf_cgroup_switch(struct task_struct *task)
 	perf_ctx_lock(cpuctx, cpuctx->task_ctx);
 	perf_ctx_disable(&cpuctx->ctx, true);
 
-	ctx_sched_out(&cpuctx->ctx, EVENT_ALL|EVENT_CGROUP);
+	ctx_sched_out(&cpuctx->ctx, NULL, EVENT_ALL|EVENT_CGROUP);
 	/*
 	 * must not be done before ctxswout due
 	 * to update_cgrp_time_from_cpuctx() in
@@ -877,7 +879,7 @@ static void perf_cgroup_switch(struct task_struct *task)
 	 * perf_cgroup_set_timestamp() in ctx_sched_in()
 	 * to not have to pass task around
 	 */
-	ctx_sched_in(&cpuctx->ctx, EVENT_ALL|EVENT_CGROUP);
+	ctx_sched_in(&cpuctx->ctx, NULL, EVENT_ALL|EVENT_CGROUP);
 
 	perf_ctx_enable(&cpuctx->ctx, true);
 	perf_ctx_unlock(cpuctx, cpuctx->task_ctx);
@@ -2656,7 +2658,8 @@ static void add_event_to_ctx(struct perf_event *event,
 }
 
 static void task_ctx_sched_out(struct perf_event_context *ctx,
-				enum event_type_t event_type)
+			       struct pmu *pmu,
+			       enum event_type_t event_type)
 {
 	struct perf_cpu_context *cpuctx = this_cpu_ptr(&perf_cpu_context);
 
@@ -2666,18 +2669,19 @@ static void task_ctx_sched_out(struct perf_event_context *ctx,
 	if (WARN_ON_ONCE(ctx != cpuctx->task_ctx))
 		return;
 
-	ctx_sched_out(ctx, event_type);
+	ctx_sched_out(ctx, pmu, event_type);
 }
 
 static void perf_event_sched_in(struct perf_cpu_context *cpuctx,
-				struct perf_event_context *ctx)
+				struct perf_event_context *ctx,
+				struct pmu *pmu)
 {
-	ctx_sched_in(&cpuctx->ctx, EVENT_PINNED);
+	ctx_sched_in(&cpuctx->ctx, pmu, EVENT_PINNED);
 	if (ctx)
-		 ctx_sched_in(ctx, EVENT_PINNED);
-	ctx_sched_in(&cpuctx->ctx, EVENT_FLEXIBLE);
+		 ctx_sched_in(ctx, pmu, EVENT_PINNED);
+	ctx_sched_in(&cpuctx->ctx, pmu, EVENT_FLEXIBLE);
 	if (ctx)
-		 ctx_sched_in(ctx, EVENT_FLEXIBLE);
+		 ctx_sched_in(ctx, pmu, EVENT_FLEXIBLE);
 }
 
 /*
@@ -2695,16 +2699,12 @@ static void perf_event_sched_in(struct perf_cpu_context *cpuctx,
  * event_type is a bit mask of the types of events involved. For CPU events,
  * event_type is only either EVENT_PINNED or EVENT_FLEXIBLE.
  */
-/*
- * XXX: ctx_resched() reschedule entire perf_event_context while adding new
- * event to the context or enabling existing event in the context. We can
- * probably optimize it by rescheduling only affected pmu_ctx.
- */
 static void ctx_resched(struct perf_cpu_context *cpuctx,
 			struct perf_event_context *task_ctx,
-			enum event_type_t event_type)
+			struct pmu *pmu, enum event_type_t event_type)
 {
 	bool cpu_event = !!(event_type & EVENT_CPU);
+	struct perf_event_pmu_context *epc;
 
 	/*
 	 * If pinned groups are involved, flexible groups also need to be
@@ -2715,10 +2715,14 @@ static void ctx_resched(struct perf_cpu_context *cpuctx,
 
 	event_type &= EVENT_ALL;
 
-	perf_ctx_disable(&cpuctx->ctx, false);
+	for_each_epc(epc, &cpuctx->ctx, pmu, false)
+		perf_pmu_disable(epc->pmu);
+
 	if (task_ctx) {
-		perf_ctx_disable(task_ctx, false);
-		task_ctx_sched_out(task_ctx, event_type);
+		for_each_epc(epc, task_ctx, pmu, false)
+			perf_pmu_disable(epc->pmu);
+
+		task_ctx_sched_out(task_ctx, pmu, event_type);
 	}
 
 	/*
@@ -2729,15 +2733,19 @@ static void ctx_resched(struct perf_cpu_context *cpuctx,
 	 *  - otherwise, do nothing more.
 	 */
 	if (cpu_event)
-		ctx_sched_out(&cpuctx->ctx, event_type);
+		ctx_sched_out(&cpuctx->ctx, pmu, event_type);
 	else if (event_type & EVENT_PINNED)
-		ctx_sched_out(&cpuctx->ctx, EVENT_FLEXIBLE);
+		ctx_sched_out(&cpuctx->ctx, pmu, EVENT_FLEXIBLE);
+
+	perf_event_sched_in(cpuctx, task_ctx, pmu);
 
-	perf_event_sched_in(cpuctx, task_ctx);
+	for_each_epc(epc, &cpuctx->ctx, pmu, false)
+		perf_pmu_enable(epc->pmu);
 
-	perf_ctx_enable(&cpuctx->ctx, false);
-	if (task_ctx)
-		perf_ctx_enable(task_ctx, false);
+	if (task_ctx) {
+		for_each_epc(epc, task_ctx, pmu, false)
+			perf_pmu_enable(epc->pmu);
+	}
 }
 
 void perf_pmu_resched(struct pmu *pmu)
@@ -2746,7 +2754,7 @@ void perf_pmu_resched(struct pmu *pmu)
 	struct perf_event_context *task_ctx = cpuctx->task_ctx;
 
 	perf_ctx_lock(cpuctx, task_ctx);
-	ctx_resched(cpuctx, task_ctx, EVENT_ALL|EVENT_CPU);
+	ctx_resched(cpuctx, task_ctx, pmu, EVENT_ALL|EVENT_CPU);
 	perf_ctx_unlock(cpuctx, task_ctx);
 }
 
@@ -2802,9 +2810,10 @@ static int  __perf_install_in_context(void *info)
 #endif
 
 	if (reprogram) {
-		ctx_sched_out(ctx, EVENT_TIME);
+		ctx_sched_out(ctx, NULL, EVENT_TIME);
 		add_event_to_ctx(event, ctx);
-		ctx_resched(cpuctx, task_ctx, get_event_type(event));
+		ctx_resched(cpuctx, task_ctx, event->pmu_ctx->pmu,
+			    get_event_type(event));
 	} else {
 		add_event_to_ctx(event, ctx);
 	}
@@ -2948,7 +2957,7 @@ static void __perf_event_enable(struct perf_event *event,
 		return;
 
 	if (ctx->is_active)
-		ctx_sched_out(ctx, EVENT_TIME);
+		ctx_sched_out(ctx, NULL, EVENT_TIME);
 
 	perf_event_set_state(event, PERF_EVENT_STATE_INACTIVE);
 	perf_cgroup_event_enable(event, ctx);
@@ -2957,7 +2966,7 @@ static void __perf_event_enable(struct perf_event *event,
 		return;
 
 	if (!event_filter_match(event)) {
-		ctx_sched_in(ctx, EVENT_TIME);
+		ctx_sched_in(ctx, NULL, EVENT_TIME);
 		return;
 	}
 
@@ -2966,7 +2975,7 @@ static void __perf_event_enable(struct perf_event *event,
 	 * then don't put it on unless the group is on.
 	 */
 	if (leader != event && leader->state != PERF_EVENT_STATE_ACTIVE) {
-		ctx_sched_in(ctx, EVENT_TIME);
+		ctx_sched_in(ctx, NULL, EVENT_TIME);
 		return;
 	}
 
@@ -2974,7 +2983,7 @@ static void __perf_event_enable(struct perf_event *event,
 	if (ctx->task)
 		WARN_ON_ONCE(task_ctx != ctx);
 
-	ctx_resched(cpuctx, task_ctx, get_event_type(event));
+	ctx_resched(cpuctx, task_ctx, event->pmu_ctx->pmu, get_event_type(event));
 }
 
 /*
@@ -3276,8 +3285,17 @@ static void __pmu_ctx_sched_out(struct perf_event_pmu_context *pmu_ctx,
 	perf_pmu_enable(pmu);
 }
 
+/*
+ * Be very careful with the @pmu argument since this will change ctx state.
+ * The @pmu argument works for ctx_resched(), because that is symmetric in
+ * ctx_sched_out() / ctx_sched_in() usage and the ctx state ends up invariant.
+ *
+ * However, if you were to be asymmetrical, you could end up with messed up
+ * state, eg. ctx->is_active cleared even though most EPCs would still actually
+ * be active.
+ */
 static void
-ctx_sched_out(struct perf_event_context *ctx, enum event_type_t event_type)
+ctx_sched_out(struct perf_event_context *ctx, struct pmu *pmu, enum event_type_t event_type)
 {
 	struct perf_cpu_context *cpuctx = this_cpu_ptr(&perf_cpu_context);
 	struct perf_event_pmu_context *pmu_ctx;
@@ -3331,11 +3349,8 @@ ctx_sched_out(struct perf_event_context *ctx, enum event_type_t event_type)
 
 	is_active ^= ctx->is_active; /* changed bits */
 
-	list_for_each_entry(pmu_ctx, &ctx->pmu_ctx_list, pmu_ctx_entry) {
-		if (cgroup && !pmu_ctx->nr_cgroups)
-			continue;
+	for_each_epc(pmu_ctx, ctx, pmu, cgroup)
 		__pmu_ctx_sched_out(pmu_ctx, is_active);
-	}
 }
 
 /*
@@ -3579,7 +3594,7 @@ unlock:
 
 inside_switch:
 		perf_ctx_sched_task_cb(ctx, false);
-		task_ctx_sched_out(ctx, EVENT_ALL);
+		task_ctx_sched_out(ctx, NULL, EVENT_ALL);
 
 		perf_ctx_enable(ctx, false);
 		raw_spin_unlock(&ctx->lock);
@@ -3877,29 +3892,22 @@ static void pmu_groups_sched_in(struct perf_event_context *ctx,
 			   merge_sched_in, &can_add_hw);
 }
 
-static void ctx_groups_sched_in(struct perf_event_context *ctx,
-				struct perf_event_groups *groups,
-				bool cgroup)
+static void __pmu_ctx_sched_in(struct perf_event_pmu_context *pmu_ctx,
+			       enum event_type_t event_type)
 {
-	struct perf_event_pmu_context *pmu_ctx;
-
-	list_for_each_entry(pmu_ctx, &ctx->pmu_ctx_list, pmu_ctx_entry) {
-		if (cgroup && !pmu_ctx->nr_cgroups)
-			continue;
-		pmu_groups_sched_in(ctx, groups, pmu_ctx->pmu);
-	}
-}
+	struct perf_event_context *ctx = pmu_ctx->ctx;
 
-static void __pmu_ctx_sched_in(struct perf_event_context *ctx,
-			       struct pmu *pmu)
-{
-	pmu_groups_sched_in(ctx, &ctx->flexible_groups, pmu);
+	if (event_type & EVENT_PINNED)
+		pmu_groups_sched_in(ctx, &ctx->pinned_groups, pmu_ctx->pmu);
+	if (event_type & EVENT_FLEXIBLE)
+		pmu_groups_sched_in(ctx, &ctx->flexible_groups, pmu_ctx->pmu);
 }
 
 static void
-ctx_sched_in(struct perf_event_context *ctx, enum event_type_t event_type)
+ctx_sched_in(struct perf_event_context *ctx, struct pmu *pmu, enum event_type_t event_type)
 {
 	struct perf_cpu_context *cpuctx = this_cpu_ptr(&perf_cpu_context);
+	struct perf_event_pmu_context *pmu_ctx;
 	int is_active = ctx->is_active;
 	bool cgroup = event_type & EVENT_CGROUP;
 
@@ -3935,12 +3943,16 @@ ctx_sched_in(struct perf_event_context *ctx, enum event_type_t event_type)
 	 * First go through the list and put on any pinned groups
 	 * in order to give them the best chance of going on.
 	 */
-	if (is_active & EVENT_PINNED)
-		ctx_groups_sched_in(ctx, &ctx->pinned_groups, cgroup);
+	if (is_active & EVENT_PINNED) {
+		for_each_epc(pmu_ctx, ctx, pmu, cgroup)
+			__pmu_ctx_sched_in(pmu_ctx, EVENT_PINNED);
+	}
 
 	/* Then walk through the lower prio flexible groups */
-	if (is_active & EVENT_FLEXIBLE)
-		ctx_groups_sched_in(ctx, &ctx->flexible_groups, cgroup);
+	if (is_active & EVENT_FLEXIBLE) {
+		for_each_epc(pmu_ctx, ctx, pmu, cgroup)
+			__pmu_ctx_sched_in(pmu_ctx, EVENT_FLEXIBLE);
+	}
 }
 
 static void perf_event_context_sched_in(struct task_struct *task)
@@ -3983,10 +3995,10 @@ static void perf_event_context_sched_in(struct task_struct *task)
 	 */
 	if (!RB_EMPTY_ROOT(&ctx->pinned_groups.tree)) {
 		perf_ctx_disable(&cpuctx->ctx, false);
-		ctx_sched_out(&cpuctx->ctx, EVENT_FLEXIBLE);
+		ctx_sched_out(&cpuctx->ctx, NULL, EVENT_FLEXIBLE);
 	}
 
-	perf_event_sched_in(cpuctx, ctx);
+	perf_event_sched_in(cpuctx, ctx, NULL);
 
 	perf_ctx_sched_task_cb(cpuctx->task_ctx, true);
 
@@ -4327,14 +4339,14 @@ static bool perf_rotate_context(struct perf_cpu_pmu_context *cpc)
 		update_context_time(&cpuctx->ctx);
 		__pmu_ctx_sched_out(cpu_epc, EVENT_FLEXIBLE);
 		rotate_ctx(&cpuctx->ctx, cpu_event);
-		__pmu_ctx_sched_in(&cpuctx->ctx, pmu);
+		__pmu_ctx_sched_in(cpu_epc, EVENT_FLEXIBLE);
 	}
 
 	if (task_event)
 		rotate_ctx(task_epc->ctx, task_event);
 
 	if (task_event || (task_epc && cpu_event))
-		__pmu_ctx_sched_in(task_epc->ctx, pmu);
+		__pmu_ctx_sched_in(task_epc, EVENT_FLEXIBLE);
 
 	perf_pmu_enable(pmu);
 	perf_ctx_unlock(cpuctx, cpuctx->task_ctx);
@@ -4400,7 +4412,7 @@ static void perf_event_enable_on_exec(struct perf_event_context *ctx)
 
 	cpuctx = this_cpu_ptr(&perf_cpu_context);
 	perf_ctx_lock(cpuctx, ctx);
-	ctx_sched_out(ctx, EVENT_TIME);
+	ctx_sched_out(ctx, NULL, EVENT_TIME);
 
 	list_for_each_entry(event, &ctx->event_list, event_entry) {
 		enabled |= event_enable_on_exec(event, ctx);
@@ -4412,9 +4424,9 @@ static void perf_event_enable_on_exec(struct perf_event_context *ctx)
 	 */
 	if (enabled) {
 		clone_ctx = unclone_ctx(ctx);
-		ctx_resched(cpuctx, ctx, event_type);
+		ctx_resched(cpuctx, ctx, NULL, event_type);
 	} else {
-		ctx_sched_in(ctx, EVENT_TIME);
+		ctx_sched_in(ctx, NULL, EVENT_TIME);
 	}
 	perf_ctx_unlock(cpuctx, ctx);
 
@@ -13202,7 +13214,7 @@ static void perf_event_exit_task_context(struct task_struct *child)
 	 * in.
 	 */
 	raw_spin_lock_irq(&child_ctx->lock);
-	task_ctx_sched_out(child_ctx, EVENT_ALL);
+	task_ctx_sched_out(child_ctx, NULL, EVENT_ALL);
 
 	/*
 	 * Now that the context is inactive, destroy the task <-> ctx relation
@@ -13751,7 +13763,7 @@ static void __perf_event_exit_context(void *__info)
 	struct perf_event *event;
 
 	raw_spin_lock(&ctx->lock);
-	ctx_sched_out(ctx, EVENT_TIME);
+	ctx_sched_out(ctx, NULL, EVENT_TIME);
 	list_for_each_entry(event, &ctx->event_list, event_entry)
 		__perf_remove_from_context(event, cpuctx, ctx, (void *)DETACH_GROUP);
 	raw_spin_unlock(&ctx->lock);

