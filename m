Return-Path: <linux-tip-commits+bounces-7753-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id F25BECC7C06
	for <lists+linux-tip-commits@lfdr.de>; Wed, 17 Dec 2025 14:06:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D80F030534CD
	for <lists+linux-tip-commits@lfdr.de>; Wed, 17 Dec 2025 13:03:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A070434B18A;
	Wed, 17 Dec 2025 12:38:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="gzRBc7hf";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="CEJ68u+g"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77D7034A790;
	Wed, 17 Dec 2025 12:38:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765975103; cv=none; b=kriTVL1MyKmOr3IGPIrYP1GTm3uoYkY1AFLgnooEp++aUuH59qcqjm+H5ZWE3BYLKNeNm2hpbQmYjPyjIiMqof2mCR1Vz0P7yVF2dkOSqd1/x5cdL8QNkfpFOxopIpYf/0bbvT8AR6niHg5MWNQvF9qNk8gXUxctKjgrVu/cYY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765975103; c=relaxed/simple;
	bh=fVs1NomVAqsKPjSCoYxgFv6VFq1b/2aQedAdOTlcHC4=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=FDp1lyqsR7c2fM2Hv4Vr61sjAeHvacm9FCqRoYywR+Q0aGN6KZGRieHqPibv21w2kv4WK7TOiOejbc9eCnsHrEppianWc9qyL/i8hodnkXkTfxeBWxSu2VdiBtd4GAfNWmTG6NOGIUnUArYum0qN77MWfJGEhl2lWU1zRAPdOuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=gzRBc7hf; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=CEJ68u+g; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 17 Dec 2025 12:38:18 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1765975099;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lHr2UUo6Den4OzQGyrDHfZMhwBhsHUp2QQ7BnD/hEsY=;
	b=gzRBc7hfBQwkwK0oPTOt82LYGVwBRZ309BFikdJHfIEYJWhQ75s+Hzpjbi5ID7Bd8dEXN2
	Z1YnR+56PCZdFnqrJ4D1y+VeikFa6+c0IAlFUX2NewtAO3Z45FcviUbm+eJm5OpBavC2DD
	yRE6pBmB+ocp5CSdNaeLFA4O39NnLaCrEWNM1VpASaLyA/c5+R0ggmQxxElOw2ehr7dZE8
	+A7e+zaoIGBcB0ZBkb5p9MVuHsm65GYLGNya1+HNEP+46Q1E6uCrcWxaxteV6680pOrGYD
	YIHHwVpAqyZmubqjv3N5Ya+T9yymNDprb7VapyB8PVg/XV1ZmYAtcNeHS5Neaw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1765975099;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lHr2UUo6Den4OzQGyrDHfZMhwBhsHUp2QQ7BnD/hEsY=;
	b=CEJ68u+g/YzWrh/9IeB06CBcQMotue0gO2aSQ7woMPpjRkPRkGkfgKJlfU3fj9QB8YJCtq
	HzdWLu7RBw5LyrBA==
From: "tip-bot2 for Kan Liang" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf: Skip pmu_ctx based on event_type
Cc: Kan Liang <kan.liang@linux.intel.com>, Mingwei Zhang <mizhang@google.com>,
 Sean Christopherson <seanjc@google.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Yongwei Ma <yongwei.ma@intel.com>, Xudong Hao <xudong.hao@intel.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20251206001720.468579-2-seanjc@google.com>
References: <20251206001720.468579-2-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176597509857.510.6827757011561599049.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     b825444b6179eb071e66ca3da5ac12d4dbd808d5
Gitweb:        https://git.kernel.org/tip/b825444b6179eb071e66ca3da5ac12d4dbd=
808d5
Author:        Kan Liang <kan.liang@linux.intel.com>
AuthorDate:    Fri, 05 Dec 2025 16:16:37 -08:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 17 Dec 2025 13:31:03 +01:00

perf: Skip pmu_ctx based on event_type

To optimize the cgroup context switch, the perf_event_pmu_context
iteration skips the PMUs without cgroup events. A bool cgroup was
introduced to indicate the case. It can work, but this way is hard to
extend for other cases, e.g. skipping non-mediated PMUs. It doesn't
make sense to keep adding bool variables.

Pass the event_type instead of the specific bool variable. Check both
the event_type and related pmu_ctx variables to decide whether skipping
a PMU.

Event flags, e.g., EVENT_CGROUP, should be cleard in the ctx->is_active.
Add EVENT_FLAGS to indicate such event flags.

No functional change.

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
Signed-off-by: Mingwei Zhang <mizhang@google.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Tested-by: Yongwei Ma <yongwei.ma@intel.com>
Tested-by: Xudong Hao <xudong.hao@intel.com>
Link: https://patch.msgid.link/20251206001720.468579-2-seanjc@google.com
---
 kernel/events/core.c | 74 +++++++++++++++++++++++--------------------
 1 file changed, 40 insertions(+), 34 deletions(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index dad0d3d..406371c 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -165,7 +165,7 @@ enum event_type_t {
 	/* see ctx_resched() for details */
 	EVENT_CPU	=3D 0x10,
 	EVENT_CGROUP	=3D 0x20,
-
+	EVENT_FLAGS	=3D EVENT_CGROUP,
 	/* compound helpers */
 	EVENT_ALL         =3D EVENT_FLEXIBLE | EVENT_PINNED,
 	EVENT_TIME_FROZEN =3D EVENT_TIME | EVENT_FROZEN,
@@ -779,27 +779,37 @@ do {									\
 	___p;								\
 })
=20
-#define for_each_epc(_epc, _ctx, _pmu, _cgroup)				\
+static bool perf_skip_pmu_ctx(struct perf_event_pmu_context *pmu_ctx,
+			      enum event_type_t event_type)
+{
+	if ((event_type & EVENT_CGROUP) && !pmu_ctx->nr_cgroups)
+		return true;
+	return false;
+}
+
+#define for_each_epc(_epc, _ctx, _pmu, _event_type)			\
 	list_for_each_entry(_epc, &((_ctx)->pmu_ctx_list), pmu_ctx_entry) \
-		if (_cgroup && !_epc->nr_cgroups)			\
+		if (perf_skip_pmu_ctx(_epc, _event_type))		\
 			continue;					\
 		else if (_pmu && _epc->pmu !=3D _pmu)			\
 			continue;					\
 		else
=20
-static void perf_ctx_disable(struct perf_event_context *ctx, bool cgroup)
+static void perf_ctx_disable(struct perf_event_context *ctx,
+			     enum event_type_t event_type)
 {
 	struct perf_event_pmu_context *pmu_ctx;
=20
-	for_each_epc(pmu_ctx, ctx, NULL, cgroup)
+	for_each_epc(pmu_ctx, ctx, NULL, event_type)
 		perf_pmu_disable(pmu_ctx->pmu);
 }
=20
-static void perf_ctx_enable(struct perf_event_context *ctx, bool cgroup)
+static void perf_ctx_enable(struct perf_event_context *ctx,
+			    enum event_type_t event_type)
 {
 	struct perf_event_pmu_context *pmu_ctx;
=20
-	for_each_epc(pmu_ctx, ctx, NULL, cgroup)
+	for_each_epc(pmu_ctx, ctx, NULL, event_type)
 		perf_pmu_enable(pmu_ctx->pmu);
 }
=20
@@ -964,8 +974,7 @@ static void perf_cgroup_switch(struct task_struct *task)
 		return;
=20
 	WARN_ON_ONCE(cpuctx->ctx.nr_cgroups =3D=3D 0);
-
-	perf_ctx_disable(&cpuctx->ctx, true);
+	perf_ctx_disable(&cpuctx->ctx, EVENT_CGROUP);
=20
 	ctx_sched_out(&cpuctx->ctx, NULL, EVENT_ALL|EVENT_CGROUP);
 	/*
@@ -981,7 +990,7 @@ static void perf_cgroup_switch(struct task_struct *task)
 	 */
 	ctx_sched_in(&cpuctx->ctx, NULL, EVENT_ALL|EVENT_CGROUP);
=20
-	perf_ctx_enable(&cpuctx->ctx, true);
+	perf_ctx_enable(&cpuctx->ctx, EVENT_CGROUP);
 }
=20
 static int perf_cgroup_ensure_storage(struct perf_event *event,
@@ -2902,11 +2911,11 @@ static void ctx_resched(struct perf_cpu_context *cpuc=
tx,
=20
 	event_type &=3D EVENT_ALL;
=20
-	for_each_epc(epc, &cpuctx->ctx, pmu, false)
+	for_each_epc(epc, &cpuctx->ctx, pmu, 0)
 		perf_pmu_disable(epc->pmu);
=20
 	if (task_ctx) {
-		for_each_epc(epc, task_ctx, pmu, false)
+		for_each_epc(epc, task_ctx, pmu, 0)
 			perf_pmu_disable(epc->pmu);
=20
 		task_ctx_sched_out(task_ctx, pmu, event_type);
@@ -2926,11 +2935,11 @@ static void ctx_resched(struct perf_cpu_context *cpuc=
tx,
=20
 	perf_event_sched_in(cpuctx, task_ctx, pmu);
=20
-	for_each_epc(epc, &cpuctx->ctx, pmu, false)
+	for_each_epc(epc, &cpuctx->ctx, pmu, 0)
 		perf_pmu_enable(epc->pmu);
=20
 	if (task_ctx) {
-		for_each_epc(epc, task_ctx, pmu, false)
+		for_each_epc(epc, task_ctx, pmu, 0)
 			perf_pmu_enable(epc->pmu);
 	}
 }
@@ -3479,11 +3488,10 @@ static void
 ctx_sched_out(struct perf_event_context *ctx, struct pmu *pmu, enum event_ty=
pe_t event_type)
 {
 	struct perf_cpu_context *cpuctx =3D this_cpu_ptr(&perf_cpu_context);
+	enum event_type_t active_type =3D event_type & ~EVENT_FLAGS;
 	struct perf_event_pmu_context *pmu_ctx;
 	int is_active =3D ctx->is_active;
-	bool cgroup =3D event_type & EVENT_CGROUP;
=20
-	event_type &=3D ~EVENT_CGROUP;
=20
 	lockdep_assert_held(&ctx->lock);
=20
@@ -3514,7 +3522,7 @@ ctx_sched_out(struct perf_event_context *ctx, struct pm=
u *pmu, enum event_type_t
 	 * see __load_acquire() in perf_event_time_now()
 	 */
 	barrier();
-	ctx->is_active &=3D ~event_type;
+	ctx->is_active &=3D ~active_type;
=20
 	if (!(ctx->is_active & EVENT_ALL)) {
 		/*
@@ -3535,7 +3543,7 @@ ctx_sched_out(struct perf_event_context *ctx, struct pm=
u *pmu, enum event_type_t
=20
 	is_active ^=3D ctx->is_active; /* changed bits */
=20
-	for_each_epc(pmu_ctx, ctx, pmu, cgroup)
+	for_each_epc(pmu_ctx, ctx, pmu, event_type)
 		__pmu_ctx_sched_out(pmu_ctx, is_active);
 }
=20
@@ -3691,7 +3699,7 @@ perf_event_context_sched_out(struct task_struct *task, =
struct task_struct *next)
 		raw_spin_lock_nested(&next_ctx->lock, SINGLE_DEPTH_NESTING);
 		if (context_equiv(ctx, next_ctx)) {
=20
-			perf_ctx_disable(ctx, false);
+			perf_ctx_disable(ctx, 0);
=20
 			/* PMIs are disabled; ctx->nr_no_switch_fast is stable. */
 			if (local_read(&ctx->nr_no_switch_fast) ||
@@ -3715,7 +3723,7 @@ perf_event_context_sched_out(struct task_struct *task, =
struct task_struct *next)
=20
 			perf_ctx_sched_task_cb(ctx, task, false);
=20
-			perf_ctx_enable(ctx, false);
+			perf_ctx_enable(ctx, 0);
=20
 			/*
 			 * RCU_INIT_POINTER here is safe because we've not
@@ -3739,13 +3747,13 @@ unlock:
=20
 	if (do_switch) {
 		raw_spin_lock(&ctx->lock);
-		perf_ctx_disable(ctx, false);
+		perf_ctx_disable(ctx, 0);
=20
 inside_switch:
 		perf_ctx_sched_task_cb(ctx, task, false);
 		task_ctx_sched_out(ctx, NULL, EVENT_ALL);
=20
-		perf_ctx_enable(ctx, false);
+		perf_ctx_enable(ctx, 0);
 		raw_spin_unlock(&ctx->lock);
 	}
 }
@@ -4054,11 +4062,9 @@ static void
 ctx_sched_in(struct perf_event_context *ctx, struct pmu *pmu, enum event_typ=
e_t event_type)
 {
 	struct perf_cpu_context *cpuctx =3D this_cpu_ptr(&perf_cpu_context);
+	enum event_type_t active_type =3D event_type & ~EVENT_FLAGS;
 	struct perf_event_pmu_context *pmu_ctx;
 	int is_active =3D ctx->is_active;
-	bool cgroup =3D event_type & EVENT_CGROUP;
-
-	event_type &=3D ~EVENT_CGROUP;
=20
 	lockdep_assert_held(&ctx->lock);
=20
@@ -4076,7 +4082,7 @@ ctx_sched_in(struct perf_event_context *ctx, struct pmu=
 *pmu, enum event_type_t=20
 		barrier();
 	}
=20
-	ctx->is_active |=3D (event_type | EVENT_TIME);
+	ctx->is_active |=3D active_type | EVENT_TIME;
 	if (ctx->task) {
 		if (!(is_active & EVENT_ALL))
 			cpuctx->task_ctx =3D ctx;
@@ -4091,13 +4097,13 @@ ctx_sched_in(struct perf_event_context *ctx, struct p=
mu *pmu, enum event_type_t=20
 	 * in order to give them the best chance of going on.
 	 */
 	if (is_active & EVENT_PINNED) {
-		for_each_epc(pmu_ctx, ctx, pmu, cgroup)
+		for_each_epc(pmu_ctx, ctx, pmu, event_type)
 			__pmu_ctx_sched_in(pmu_ctx, EVENT_PINNED);
 	}
=20
 	/* Then walk through the lower prio flexible groups */
 	if (is_active & EVENT_FLEXIBLE) {
-		for_each_epc(pmu_ctx, ctx, pmu, cgroup)
+		for_each_epc(pmu_ctx, ctx, pmu, event_type)
 			__pmu_ctx_sched_in(pmu_ctx, EVENT_FLEXIBLE);
 	}
 }
@@ -4114,11 +4120,11 @@ static void perf_event_context_sched_in(struct task_s=
truct *task)
=20
 	if (cpuctx->task_ctx =3D=3D ctx) {
 		perf_ctx_lock(cpuctx, ctx);
-		perf_ctx_disable(ctx, false);
+		perf_ctx_disable(ctx, 0);
=20
 		perf_ctx_sched_task_cb(ctx, task, true);
=20
-		perf_ctx_enable(ctx, false);
+		perf_ctx_enable(ctx, 0);
 		perf_ctx_unlock(cpuctx, ctx);
 		goto rcu_unlock;
 	}
@@ -4131,7 +4137,7 @@ static void perf_event_context_sched_in(struct task_str=
uct *task)
 	if (!ctx->nr_events)
 		goto unlock;
=20
-	perf_ctx_disable(ctx, false);
+	perf_ctx_disable(ctx, 0);
 	/*
 	 * We want to keep the following priority order:
 	 * cpu pinned (that don't need to move), task pinned,
@@ -4141,7 +4147,7 @@ static void perf_event_context_sched_in(struct task_str=
uct *task)
 	 * events, no need to flip the cpuctx's events around.
 	 */
 	if (!RB_EMPTY_ROOT(&ctx->pinned_groups.tree)) {
-		perf_ctx_disable(&cpuctx->ctx, false);
+		perf_ctx_disable(&cpuctx->ctx, 0);
 		ctx_sched_out(&cpuctx->ctx, NULL, EVENT_FLEXIBLE);
 	}
=20
@@ -4150,9 +4156,9 @@ static void perf_event_context_sched_in(struct task_str=
uct *task)
 	perf_ctx_sched_task_cb(cpuctx->task_ctx, task, true);
=20
 	if (!RB_EMPTY_ROOT(&ctx->pinned_groups.tree))
-		perf_ctx_enable(&cpuctx->ctx, false);
+		perf_ctx_enable(&cpuctx->ctx, 0);
=20
-	perf_ctx_enable(ctx, false);
+	perf_ctx_enable(ctx, 0);
=20
 unlock:
 	perf_ctx_unlock(cpuctx, ctx);

