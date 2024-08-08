Return-Path: <linux-tip-commits+bounces-1998-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7691994BB15
	for <lists+linux-tip-commits@lfdr.de>; Thu,  8 Aug 2024 12:32:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 087D71F26996
	for <lists+linux-tip-commits@lfdr.de>; Thu,  8 Aug 2024 10:32:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C358818A944;
	Thu,  8 Aug 2024 10:32:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="T0vIsy3F";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="NO+sy4v5"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C970518A921;
	Thu,  8 Aug 2024 10:32:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723113131; cv=none; b=Q67xTICabAfLuJsu66MmiXaIljKlxwdBM8ljWPSjnnuXIlJqDV0iG/QED+DUMV8rNaILkWqFOw+qKKK24P/n81uJGrQsQlPWQpOdG8hSLMTfSeyp2pyS/2Ip73L+VmEfc6vJlkPec2BSrZ26xwCtdnQUwZ+jht+XClyvVJWwILc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723113131; c=relaxed/simple;
	bh=PiTD9xvQqkfn/Hfr8xdYRNs7TvdGZhqok7RF4ltzk0g=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=o6XRYSofevRS7KQuznvFYCUG++AmXZjKTVVcWWIaQvQgHrVXxyPpThJKFttOyBh6WA7tc3AFAw8NjNtpenAyA76StGUnZMcMc95lMnuzbxOy/2o7UDWQIlgR+3J7j+b7NSLzpB4yY8+bfVVsN9Cs5nAJarkO9LCpasC4tVOR4UI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=T0vIsy3F; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=NO+sy4v5; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 08 Aug 2024 10:32:07 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1723113127;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mISoTvV23T7UQ7lobUHH6RWfna9PR57e7h0v5QQXbPg=;
	b=T0vIsy3F/L1B4WeGeThpI0f6E2/nRDsX+IbPOyIpnIbTJwZClqmUN47cwGdQRIa6ReXm+m
	fu1sQGhSpCnCl31jEd5tfSkGb4pnqWhr7bpGwR/Bdn0THw0CwG2vaVe+D7Wwlik/Pj9qaA
	d6B0hNbo9MLJcHr3G6DEKeAVn076gfMs51KDrk8Jhpcteu87KW/MQAkNU6tnCEOwZa8dLC
	Ps7u7pcsv46vbSBjZZLz5JYH38hjbAS3enjUkpvceDvP9DI5g4+mnVpNHA8HtueQ8P9juL
	qZ2MoM8j6t+33TKkfrTPDaF9FXzWafdzQHNDCd4YeJLbH6PJeANdqhfhFrFeWA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1723113127;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mISoTvV23T7UQ7lobUHH6RWfna9PR57e7h0v5QQXbPg=;
	b=NO+sy4v5Iy/YLzqbqj/sSSDEd3lgVX1H8vakjLuzICqwWvSKOvRMyOmYd7K3oBDF8USDsl
	t5Jfl8u/0A2IiwDw==
From: "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf: Add context time freeze
Cc: Kan Liang <kan.liang@linux.intel.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Namhyung Kim <namhyung@kernel.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240807115550.250637571@infradead.org>
References: <20240807115550.250637571@infradead.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172311312757.2215.323044538405607858.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     5d95a2af973d47260b1e1828953fc860c0094052
Gitweb:        https://git.kernel.org/tip/5d95a2af973d47260b1e1828953fc860c0094052
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Wed, 07 Aug 2024 13:29:28 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Thu, 08 Aug 2024 12:27:32 +02:00

perf: Add context time freeze

Many of the the context reschedule users are of the form:

  ctx_sched_out(.type = EVENT_TIME);
  ... modify context
  ctx_resched();

With the idea that the whole reschedule happens with a single
time-stamp, rather than with each ctx_sched_out() advancing time and
ctx_sched_in() re-starting time, creating a non-atomic experience.

However, Kan noticed that since this completely stops time, it
actually looses a bit of time between the stop and start. Worse, now
that we can do partial (per PMU) reschedules, the PMUs that are not
scheduled out still observe the time glitch.

Replace this with:

  ctx_time_freeze();
  ... modify context
  ctx_resched();

With the assumption that this happens in a perf_ctx_lock() /
perf_ctx_unlock() pair.

The new ctx_time_freeze() will update time and sets EVENT_FROZEN, and
ensures EVENT_TIME and EVENT_FROZEN remain set, this avoids
perf_event_time_now() from observing a time wobble from not seeing
EVENT_TIME for a little while.

Additionally, this avoids loosing time between
ctx_sched_out(EVENT_TIME) and ctx_sched_in(), which would re-set the
timestamp.

Reported-by: Kan Liang <kan.liang@linux.intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Kan Liang <kan.liang@linux.intel.com>
Reviewed-by: Namhyung Kim <namhyung@kernel.org>
Link: https://lore.kernel.org/r/20240807115550.250637571@infradead.org
---
 kernel/events/core.c | 128 ++++++++++++++++++++++++++++--------------
 1 file changed, 86 insertions(+), 42 deletions(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index ab49dea..197d3be 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -155,20 +155,55 @@ static int cpu_function_call(int cpu, remote_function_f func, void *info)
 	return data.ret;
 }
 
+enum event_type_t {
+	EVENT_FLEXIBLE	= 0x01,
+	EVENT_PINNED	= 0x02,
+	EVENT_TIME	= 0x04,
+	EVENT_FROZEN	= 0x08,
+	/* see ctx_resched() for details */
+	EVENT_CPU	= 0x10,
+	EVENT_CGROUP	= 0x20,
+
+	/* compound helpers */
+	EVENT_ALL         = EVENT_FLEXIBLE | EVENT_PINNED,
+	EVENT_TIME_FROZEN = EVENT_TIME | EVENT_FROZEN,
+};
+
+static inline void __perf_ctx_lock(struct perf_event_context *ctx)
+{
+	raw_spin_lock(&ctx->lock);
+	WARN_ON_ONCE(ctx->is_active & EVENT_FROZEN);
+}
+
 static void perf_ctx_lock(struct perf_cpu_context *cpuctx,
 			  struct perf_event_context *ctx)
 {
-	raw_spin_lock(&cpuctx->ctx.lock);
+	__perf_ctx_lock(&cpuctx->ctx);
 	if (ctx)
-		raw_spin_lock(&ctx->lock);
+		__perf_ctx_lock(ctx);
+}
+
+static inline void __perf_ctx_unlock(struct perf_event_context *ctx)
+{
+	/*
+	 * If ctx_sched_in() didn't again set any ALL flags, clean up
+	 * after ctx_sched_out() by clearing is_active.
+	 */
+	if (ctx->is_active & EVENT_FROZEN) {
+		if (!(ctx->is_active & EVENT_ALL))
+			ctx->is_active = 0;
+		else
+			ctx->is_active &= ~EVENT_FROZEN;
+	}
+	raw_spin_unlock(&ctx->lock);
 }
 
 static void perf_ctx_unlock(struct perf_cpu_context *cpuctx,
 			    struct perf_event_context *ctx)
 {
 	if (ctx)
-		raw_spin_unlock(&ctx->lock);
-	raw_spin_unlock(&cpuctx->ctx.lock);
+		__perf_ctx_unlock(ctx);
+	__perf_ctx_unlock(&cpuctx->ctx);
 }
 
 #define TASK_TOMBSTONE ((void *)-1L)
@@ -370,16 +405,6 @@ unlock:
 	(PERF_SAMPLE_BRANCH_KERNEL |\
 	 PERF_SAMPLE_BRANCH_HV)
 
-enum event_type_t {
-	EVENT_FLEXIBLE = 0x1,
-	EVENT_PINNED = 0x2,
-	EVENT_TIME = 0x4,
-	/* see ctx_resched() for details */
-	EVENT_CPU = 0x8,
-	EVENT_CGROUP = 0x10,
-	EVENT_ALL = EVENT_FLEXIBLE | EVENT_PINNED,
-};
-
 /*
  * perf_sched_events : >0 events exist
  */
@@ -2332,18 +2357,39 @@ group_sched_out(struct perf_event *group_event, struct perf_event_context *ctx)
 }
 
 static inline void
-ctx_time_update(struct perf_cpu_context *cpuctx, struct perf_event_context *ctx)
+__ctx_time_update(struct perf_cpu_context *cpuctx, struct perf_event_context *ctx, bool final)
 {
 	if (ctx->is_active & EVENT_TIME) {
+		if (ctx->is_active & EVENT_FROZEN)
+			return;
 		update_context_time(ctx);
-		update_cgrp_time_from_cpuctx(cpuctx, false);
+		update_cgrp_time_from_cpuctx(cpuctx, final);
 	}
 }
 
 static inline void
+ctx_time_update(struct perf_cpu_context *cpuctx, struct perf_event_context *ctx)
+{
+	__ctx_time_update(cpuctx, ctx, false);
+}
+
+/*
+ * To be used inside perf_ctx_lock() / perf_ctx_unlock(). Lasts until perf_ctx_unlock().
+ */
+static inline void
+ctx_time_freeze(struct perf_cpu_context *cpuctx, struct perf_event_context *ctx)
+{
+	ctx_time_update(cpuctx, ctx);
+	if (ctx->is_active & EVENT_TIME)
+		ctx->is_active |= EVENT_FROZEN;
+}
+
+static inline void
 ctx_time_update_event(struct perf_event_context *ctx, struct perf_event *event)
 {
 	if (ctx->is_active & EVENT_TIME) {
+		if (ctx->is_active & EVENT_FROZEN)
+			return;
 		update_context_time(ctx);
 		update_cgrp_time_from_event(event);
 	}
@@ -2822,7 +2868,7 @@ static int  __perf_install_in_context(void *info)
 #endif
 
 	if (reprogram) {
-		ctx_sched_out(ctx, NULL, EVENT_TIME);
+		ctx_time_freeze(cpuctx, ctx);
 		add_event_to_ctx(event, ctx);
 		ctx_resched(cpuctx, task_ctx, event->pmu_ctx->pmu,
 			    get_event_type(event));
@@ -2968,8 +3014,7 @@ static void __perf_event_enable(struct perf_event *event,
 	    event->state <= PERF_EVENT_STATE_ERROR)
 		return;
 
-	if (ctx->is_active)
-		ctx_sched_out(ctx, NULL, EVENT_TIME);
+	ctx_time_freeze(cpuctx, ctx);
 
 	perf_event_set_state(event, PERF_EVENT_STATE_INACTIVE);
 	perf_cgroup_event_enable(event, ctx);
@@ -2977,19 +3022,15 @@ static void __perf_event_enable(struct perf_event *event,
 	if (!ctx->is_active)
 		return;
 
-	if (!event_filter_match(event)) {
-		ctx_sched_in(ctx, NULL, EVENT_TIME);
+	if (!event_filter_match(event))
 		return;
-	}
 
 	/*
 	 * If the event is in a group and isn't the group leader,
 	 * then don't put it on unless the group is on.
 	 */
-	if (leader != event && leader->state != PERF_EVENT_STATE_ACTIVE) {
-		ctx_sched_in(ctx, NULL, EVENT_TIME);
+	if (leader != event && leader->state != PERF_EVENT_STATE_ACTIVE)
 		return;
-	}
 
 	task_ctx = cpuctx->task_ctx;
 	if (ctx->task)
@@ -3263,7 +3304,7 @@ static void __pmu_ctx_sched_out(struct perf_event_pmu_context *pmu_ctx,
 	struct perf_event *event, *tmp;
 	struct pmu *pmu = pmu_ctx->pmu;
 
-	if (ctx->task && !ctx->is_active) {
+	if (ctx->task && !(ctx->is_active & EVENT_ALL)) {
 		struct perf_cpu_pmu_context *cpc;
 
 		cpc = this_cpu_ptr(pmu->cpu_pmu_context);
@@ -3338,24 +3379,29 @@ ctx_sched_out(struct perf_event_context *ctx, struct pmu *pmu, enum event_type_t
 	 *
 	 * would only update time for the pinned events.
 	 */
-	if (is_active & EVENT_TIME) {
-		/* update (and stop) ctx time */
-		update_context_time(ctx);
-		update_cgrp_time_from_cpuctx(cpuctx, ctx == &cpuctx->ctx);
+	__ctx_time_update(cpuctx, ctx, ctx == &cpuctx->ctx);
+
+	/*
+	 * CPU-release for the below ->is_active store,
+	 * see __load_acquire() in perf_event_time_now()
+	 */
+	barrier();
+	ctx->is_active &= ~event_type;
+
+	if (!(ctx->is_active & EVENT_ALL)) {
 		/*
-		 * CPU-release for the below ->is_active store,
-		 * see __load_acquire() in perf_event_time_now()
+		 * For FROZEN, preserve TIME|FROZEN such that perf_event_time_now()
+		 * does not observe a hole. perf_ctx_unlock() will clean up.
 		 */
-		barrier();
+		if (ctx->is_active & EVENT_FROZEN)
+			ctx->is_active &= EVENT_TIME_FROZEN;
+		else
+			ctx->is_active = 0;
 	}
 
-	ctx->is_active &= ~event_type;
-	if (!(ctx->is_active & EVENT_ALL))
-		ctx->is_active = 0;
-
 	if (ctx->task) {
 		WARN_ON_ONCE(cpuctx->task_ctx != ctx);
-		if (!ctx->is_active)
+		if (!(ctx->is_active & EVENT_ALL))
 			cpuctx->task_ctx = NULL;
 	}
 
@@ -3943,7 +3989,7 @@ ctx_sched_in(struct perf_event_context *ctx, struct pmu *pmu, enum event_type_t 
 
 	ctx->is_active |= (event_type | EVENT_TIME);
 	if (ctx->task) {
-		if (!is_active)
+		if (!(is_active & EVENT_ALL))
 			cpuctx->task_ctx = ctx;
 		else
 			WARN_ON_ONCE(cpuctx->task_ctx != ctx);
@@ -4424,7 +4470,7 @@ static void perf_event_enable_on_exec(struct perf_event_context *ctx)
 
 	cpuctx = this_cpu_ptr(&perf_cpu_context);
 	perf_ctx_lock(cpuctx, ctx);
-	ctx_sched_out(ctx, NULL, EVENT_TIME);
+	ctx_time_freeze(cpuctx, ctx);
 
 	list_for_each_entry(event, &ctx->event_list, event_entry) {
 		enabled |= event_enable_on_exec(event, ctx);
@@ -4437,8 +4483,6 @@ static void perf_event_enable_on_exec(struct perf_event_context *ctx)
 	if (enabled) {
 		clone_ctx = unclone_ctx(ctx);
 		ctx_resched(cpuctx, ctx, NULL, event_type);
-	} else {
-		ctx_sched_in(ctx, NULL, EVENT_TIME);
 	}
 	perf_ctx_unlock(cpuctx, ctx);
 

