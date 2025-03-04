Return-Path: <linux-tip-commits+bounces-3868-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 30CFDA4D74D
	for <lists+linux-tip-commits@lfdr.de>; Tue,  4 Mar 2025 10:04:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3984F188DCC9
	for <lists+linux-tip-commits@lfdr.de>; Tue,  4 Mar 2025 09:02:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BA3E1FF61E;
	Tue,  4 Mar 2025 08:57:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ABbiMOi6";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="i4w7OvW6"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4459A1FECDE;
	Tue,  4 Mar 2025 08:57:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741078627; cv=none; b=dJIILZxQwDQJAUH7Y+O0LAM8eOseDsnkOpvWcqatJudZiff4Tw3j/uY9Uf6e8upXR2FXPvgHhsXqLpL9//7wA8lYQ4pZmW9J038jTdkocYcwb2tjWm8+Q2i8lb4aqi0iDRp4V2DmGPXiZ4G7xp6C4STMDHV5Y+UotWUXwvmOVzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741078627; c=relaxed/simple;
	bh=oRdrPqYzx/VPNj17mAK4HtUswcK4w3sUsS5wYGbT73o=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=Pzl8f5fti2qARnZxxhaKcOiVVboyMsv7my8UVDBOTMclXMviMARrP+TotEqaz7Dp7AC6GmSkM+XiwDkDmWZ7f4THYQ+dL1s4LRGY8kWPI4UNZpc6rt9SQyG+nqgUMtErDRVyKcB3fBPWafKujWkASvr1b2k28tpgZqL4l7rJq8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ABbiMOi6; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=i4w7OvW6; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 04 Mar 2025 08:57:02 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1741078623;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sG+s+Vjx/VDudmwR7WyYhvCEmZEyWzCQN+mS6rnHvgw=;
	b=ABbiMOi6jKsCcVQq5PFO5ZhHsnwVOXJPh1taYpRlIaYA8zxwaIsFKgClyQz9eO7EeRzuTf
	WiIkrIjGztlY5vTofEb13/zDIFjW356s9Nc3wlTUJJxNXT8Mv5NmEJ7Jf3HnqIt3SqYtZ4
	gBASiQ2PMBTkl/Uviik0TYEPE97EARWWo4XSFfQ6q04IjmPSqQMMTSlP37rpMeGng4MuU9
	8lE5nfKqAFwGsUcVFK8uiiQJLTE45t5lnsX8GbQwmKEfAJ4EabNNAxgABx6jogF6L1v8lH
	mA2EzLqjU9jKHHraBwSTJgPCl3I1uAstINlkMy3ApUDP9cwyqjPAzOUGC//94A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1741078623;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sG+s+Vjx/VDudmwR7WyYhvCEmZEyWzCQN+mS6rnHvgw=;
	b=i4w7OvW6JwaJwwGY9tssm1XIUlKnMB56d3Wyo1TRwe6oCbCfR/Bv15uEDsG+wFXAbUevTG
	DzEtEbcoVU24ohAw==
From: "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf/core: Add this_cpc() helper
Cc: "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Ingo Molnar <mingo@kernel.org>, Ravi Bangoria <ravi.bangoria@amd.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20241104135518.650051565@infradead.org>
References: <20241104135518.650051565@infradead.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174107862281.14745.4338989590283810562.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     b2996f56556e389a13377158904c218da6fffa91
Gitweb:        https://git.kernel.org/tip/b2996f56556e389a13377158904c218da6fffa91
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Mon, 04 Nov 2024 14:39:19 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 04 Mar 2025 09:42:51 +01:00

perf/core: Add this_cpc() helper

As a preparation for adding yet another indirection.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Reviewed-by: Ravi Bangoria <ravi.bangoria@amd.com>
Link: https://lore.kernel.org/r/20241104135518.650051565@infradead.org
---
 kernel/events/core.c | 34 ++++++++++++++++++----------------
 1 file changed, 18 insertions(+), 16 deletions(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index 8321b71..0c7015f 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -1217,23 +1217,28 @@ static int perf_mux_hrtimer_restart_ipi(void *arg)
 	return perf_mux_hrtimer_restart(arg);
 }
 
+static __always_inline struct perf_cpu_pmu_context *this_cpc(struct pmu *pmu)
+{
+	return this_cpu_ptr(pmu->cpu_pmu_context);
+}
+
 void perf_pmu_disable(struct pmu *pmu)
 {
-	int *count = &this_cpu_ptr(pmu->cpu_pmu_context)->pmu_disable_count;
+	int *count = &this_cpc(pmu)->pmu_disable_count;
 	if (!(*count)++)
 		pmu->pmu_disable(pmu);
 }
 
 void perf_pmu_enable(struct pmu *pmu)
 {
-	int *count = &this_cpu_ptr(pmu->cpu_pmu_context)->pmu_disable_count;
+	int *count = &this_cpc(pmu)->pmu_disable_count;
 	if (!--(*count))
 		pmu->pmu_enable(pmu);
 }
 
 static void perf_assert_pmu_disabled(struct pmu *pmu)
 {
-	int *count = &this_cpu_ptr(pmu->cpu_pmu_context)->pmu_disable_count;
+	int *count = &this_cpc(pmu)->pmu_disable_count;
 	WARN_ON_ONCE(*count == 0);
 }
 
@@ -2355,7 +2360,7 @@ static void
 event_sched_out(struct perf_event *event, struct perf_event_context *ctx)
 {
 	struct perf_event_pmu_context *epc = event->pmu_ctx;
-	struct perf_cpu_pmu_context *cpc = this_cpu_ptr(epc->pmu->cpu_pmu_context);
+	struct perf_cpu_pmu_context *cpc = this_cpc(epc->pmu);
 	enum perf_event_state state = PERF_EVENT_STATE_INACTIVE;
 
 	// XXX cpc serialization, probably per-cpu IRQ disabled
@@ -2496,9 +2501,8 @@ __perf_remove_from_context(struct perf_event *event,
 		pmu_ctx->rotate_necessary = 0;
 
 		if (ctx->task && ctx->is_active) {
-			struct perf_cpu_pmu_context *cpc;
+			struct perf_cpu_pmu_context *cpc = this_cpc(pmu_ctx->pmu);
 
-			cpc = this_cpu_ptr(pmu_ctx->pmu->cpu_pmu_context);
 			WARN_ON_ONCE(cpc->task_epc && cpc->task_epc != pmu_ctx);
 			cpc->task_epc = NULL;
 		}
@@ -2636,7 +2640,7 @@ static int
 event_sched_in(struct perf_event *event, struct perf_event_context *ctx)
 {
 	struct perf_event_pmu_context *epc = event->pmu_ctx;
-	struct perf_cpu_pmu_context *cpc = this_cpu_ptr(epc->pmu->cpu_pmu_context);
+	struct perf_cpu_pmu_context *cpc = this_cpc(epc->pmu);
 	int ret = 0;
 
 	WARN_ON_ONCE(event->ctx != ctx);
@@ -2743,7 +2747,7 @@ error:
 static int group_can_go_on(struct perf_event *event, int can_add_hw)
 {
 	struct perf_event_pmu_context *epc = event->pmu_ctx;
-	struct perf_cpu_pmu_context *cpc = this_cpu_ptr(epc->pmu->cpu_pmu_context);
+	struct perf_cpu_pmu_context *cpc = this_cpc(epc->pmu);
 
 	/*
 	 * Groups consisting entirely of software events can always go on.
@@ -3366,9 +3370,8 @@ static void __pmu_ctx_sched_out(struct perf_event_pmu_context *pmu_ctx,
 	struct pmu *pmu = pmu_ctx->pmu;
 
 	if (ctx->task && !(ctx->is_active & EVENT_ALL)) {
-		struct perf_cpu_pmu_context *cpc;
+		struct perf_cpu_pmu_context *cpc = this_cpc(pmu);
 
-		cpc = this_cpu_ptr(pmu->cpu_pmu_context);
 		WARN_ON_ONCE(cpc->task_epc && cpc->task_epc != pmu_ctx);
 		cpc->task_epc = NULL;
 	}
@@ -3615,7 +3618,7 @@ static void perf_ctx_sched_task_cb(struct perf_event_context *ctx, bool sched_in
 	struct perf_cpu_pmu_context *cpc;
 
 	list_for_each_entry(pmu_ctx, &ctx->pmu_ctx_list, pmu_ctx_entry) {
-		cpc = this_cpu_ptr(pmu_ctx->pmu->cpu_pmu_context);
+		cpc = this_cpc(pmu_ctx->pmu);
 
 		if (cpc->sched_cb_usage && pmu_ctx->pmu->sched_task)
 			pmu_ctx->pmu->sched_task(pmu_ctx, sched_in);
@@ -3724,7 +3727,7 @@ static DEFINE_PER_CPU(int, perf_sched_cb_usages);
 
 void perf_sched_cb_dec(struct pmu *pmu)
 {
-	struct perf_cpu_pmu_context *cpc = this_cpu_ptr(pmu->cpu_pmu_context);
+	struct perf_cpu_pmu_context *cpc = this_cpc(pmu);
 
 	this_cpu_dec(perf_sched_cb_usages);
 	barrier();
@@ -3736,7 +3739,7 @@ void perf_sched_cb_dec(struct pmu *pmu)
 
 void perf_sched_cb_inc(struct pmu *pmu)
 {
-	struct perf_cpu_pmu_context *cpc = this_cpu_ptr(pmu->cpu_pmu_context);
+	struct perf_cpu_pmu_context *cpc = this_cpc(pmu);
 
 	if (!cpc->sched_cb_usage++)
 		list_add(&cpc->sched_cb_entry, this_cpu_ptr(&sched_cb_list));
@@ -3853,7 +3856,7 @@ static void __link_epc(struct perf_event_pmu_context *pmu_ctx)
 	if (!pmu_ctx->ctx->task)
 		return;
 
-	cpc = this_cpu_ptr(pmu_ctx->pmu->cpu_pmu_context);
+	cpc = this_cpc(pmu_ctx->pmu);
 	WARN_ON_ONCE(cpc->task_epc && cpc->task_epc != pmu_ctx);
 	cpc->task_epc = pmu_ctx;
 }
@@ -3982,10 +3985,9 @@ static int merge_sched_in(struct perf_event *event, void *data)
 			perf_cgroup_event_disable(event, ctx);
 			perf_event_set_state(event, PERF_EVENT_STATE_ERROR);
 		} else {
-			struct perf_cpu_pmu_context *cpc;
+			struct perf_cpu_pmu_context *cpc = this_cpc(event->pmu_ctx->pmu);
 
 			event->pmu_ctx->rotate_necessary = 1;
-			cpc = this_cpu_ptr(event->pmu_ctx->pmu->cpu_pmu_context);
 			perf_mux_hrtimer_restart(cpc);
 			group_update_userpage(event);
 		}

