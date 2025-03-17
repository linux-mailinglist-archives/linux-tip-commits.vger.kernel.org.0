Return-Path: <linux-tip-commits+bounces-4248-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D686A64A47
	for <lists+linux-tip-commits@lfdr.de>; Mon, 17 Mar 2025 11:39:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C7EE13B27B8
	for <lists+linux-tip-commits@lfdr.de>; Mon, 17 Mar 2025 10:34:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB8FD235347;
	Mon, 17 Mar 2025 10:34:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ghpOYHA3";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="zYYsddQt"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF1441AAE28;
	Mon, 17 Mar 2025 10:34:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742207652; cv=none; b=MbXb26mrjohgYLPStG6zGsbjo93r8C+02Tu2ZNT0urmyDXiCCGGM1sHT1A4uc2/TFyXnfQJzFBxGnITd2RhNlLUziQmkKtBUIlbTfQvBuKvETTB2aYfnQFEdVdGJwJgSoolF483Ea5N2nMJH33iEW3AmqQDAOd+rFxCBZ/hYfLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742207652; c=relaxed/simple;
	bh=h22FaUrdFNwAil61PLbdLRYMfIMaHOaO8Y5t1v9fMJI=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=X5SV/vnPdD9HLWNNZJoyAdayztjPk+3ce5wc4axNZzR8z9noc91Hy8/NyQ1sGwQ8qNVNI3nSr3XKv4Hsj76oGxSC196FWkH09+6h9I+7oUTq9DGG1sz9j8Zj7JjlvmFFQQxhse1ubYEHBRe52EjVGRSwsbLSyYSe43N+bNImVRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ghpOYHA3; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=zYYsddQt; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 17 Mar 2025 10:34:07 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1742207648;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=b25JWyQrEkAyi+YvIr4rHp+aGIJKG5G8DPnc09q5vGU=;
	b=ghpOYHA3kJunWaZ0uwJP3G6k5ehaOaI+XoeK6ZPGGLDhtuSP1cZ0wUYpxIRV70i4VO8tPF
	CKqKaQYzh9phfCwSLxhj0Il8pzMCQJUfUWVNI16TLWqblyz6tYiwY0ZvXLi3/MhmW24v6p
	zheq5Y7PFUo+qbj2g4J3Dbvl7XTjgSMWeY+8BkUSXCCllvACqLWAXotKPf99gHViYdrQS1
	fUMU24S7Zix3F5WOGRkjJYp9FK2Ssam2bam5myz9j2R/3ozqCw6l0q2ZToZH15NIAO5ZHN
	n4iOPOZ5/9bhHcSR4s7EbkT4quQ+K3RyGf6dz4QifMVvdYE7iAzEZP65KuTH4w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1742207648;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=b25JWyQrEkAyi+YvIr4rHp+aGIJKG5G8DPnc09q5vGU=;
	b=zYYsddQt3265k37+2AcyQMrz2YITzQ3ZSUB8TAyts6Fxvye+0noX6orrWwyHKP5ioRjrOI
	Ytv003TsyLXJpUCw==
From: "tip-bot2 for Kan Liang" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf/x86: Remove swap_task_ctx()
Cc: Kan Liang <kan.liang@linux.intel.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250314172700.438923-6-kan.liang@linux.intel.com>
References: <20250314172700.438923-6-kan.liang@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174220764770.14745.5554603279265081469.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     1fbc6c8e5289c252867c33bf12d54c11c8cfeac4
Gitweb:        https://git.kernel.org/tip/1fbc6c8e5289c252867c33bf12d54c11c8cfeac4
Author:        Kan Liang <kan.liang@linux.intel.com>
AuthorDate:    Fri, 14 Mar 2025 10:26:59 -07:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 17 Mar 2025 11:23:37 +01:00

perf/x86: Remove swap_task_ctx()

The pmu specific data is saved in task_struct now. It doesn't need to
swap between context.

Remove swap_task_ctx() support.

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/r/20250314172700.438923-6-kan.liang@linux.intel.com
---
 arch/x86/events/core.c       |  9 ---------
 arch/x86/events/intel/core.c |  7 -------
 arch/x86/events/intel/lbr.c  | 23 -----------------------
 arch/x86/events/perf_event.h | 11 -----------
 4 files changed, 50 deletions(-)

diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
index ae8c90a..833478f 100644
--- a/arch/x86/events/core.c
+++ b/arch/x86/events/core.c
@@ -87,7 +87,6 @@ DEFINE_STATIC_CALL_NULL(x86_pmu_commit_scheduling, *x86_pmu.commit_scheduling);
 DEFINE_STATIC_CALL_NULL(x86_pmu_stop_scheduling,   *x86_pmu.stop_scheduling);
 
 DEFINE_STATIC_CALL_NULL(x86_pmu_sched_task,    *x86_pmu.sched_task);
-DEFINE_STATIC_CALL_NULL(x86_pmu_swap_task_ctx, *x86_pmu.swap_task_ctx);
 
 DEFINE_STATIC_CALL_NULL(x86_pmu_drain_pebs,   *x86_pmu.drain_pebs);
 DEFINE_STATIC_CALL_NULL(x86_pmu_pebs_aliases, *x86_pmu.pebs_aliases);
@@ -2039,7 +2038,6 @@ static void x86_pmu_static_call_update(void)
 	static_call_update(x86_pmu_stop_scheduling, x86_pmu.stop_scheduling);
 
 	static_call_update(x86_pmu_sched_task, x86_pmu.sched_task);
-	static_call_update(x86_pmu_swap_task_ctx, x86_pmu.swap_task_ctx);
 
 	static_call_update(x86_pmu_drain_pebs, x86_pmu.drain_pebs);
 	static_call_update(x86_pmu_pebs_aliases, x86_pmu.pebs_aliases);
@@ -2644,12 +2642,6 @@ static void x86_pmu_sched_task(struct perf_event_pmu_context *pmu_ctx,
 	static_call_cond(x86_pmu_sched_task)(pmu_ctx, task, sched_in);
 }
 
-static void x86_pmu_swap_task_ctx(struct perf_event_pmu_context *prev_epc,
-				  struct perf_event_pmu_context *next_epc)
-{
-	static_call_cond(x86_pmu_swap_task_ctx)(prev_epc, next_epc);
-}
-
 void perf_check_microcode(void)
 {
 	if (x86_pmu.check_microcode)
@@ -2714,7 +2706,6 @@ static struct pmu pmu = {
 
 	.event_idx		= x86_pmu_event_idx,
 	.sched_task		= x86_pmu_sched_task,
-	.swap_task_ctx		= x86_pmu_swap_task_ctx,
 	.check_period		= x86_pmu_check_period,
 
 	.aux_output_match	= x86_pmu_aux_output_match,
diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index 3efbb03..dc38dec 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -5300,12 +5300,6 @@ static void intel_pmu_sched_task(struct perf_event_pmu_context *pmu_ctx,
 	intel_pmu_lbr_sched_task(pmu_ctx, task, sched_in);
 }
 
-static void intel_pmu_swap_task_ctx(struct perf_event_pmu_context *prev_epc,
-				    struct perf_event_pmu_context *next_epc)
-{
-	intel_pmu_lbr_swap_task_ctx(prev_epc, next_epc);
-}
-
 static int intel_pmu_check_period(struct perf_event *event, u64 value)
 {
 	return intel_pmu_has_bts_period(event, value) ? -EINVAL : 0;
@@ -5474,7 +5468,6 @@ static __initconst const struct x86_pmu intel_pmu = {
 
 	.guest_get_msrs		= intel_guest_get_msrs,
 	.sched_task		= intel_pmu_sched_task,
-	.swap_task_ctx		= intel_pmu_swap_task_ctx,
 
 	.check_period		= intel_pmu_check_period,
 
diff --git a/arch/x86/events/intel/lbr.c b/arch/x86/events/intel/lbr.c
index 24719ad..f44c3d8 100644
--- a/arch/x86/events/intel/lbr.c
+++ b/arch/x86/events/intel/lbr.c
@@ -522,29 +522,6 @@ static void __intel_pmu_lbr_save(void *ctx)
 	cpuc->last_log_id = ++task_context_opt(ctx)->log_id;
 }
 
-void intel_pmu_lbr_swap_task_ctx(struct perf_event_pmu_context *prev_epc,
-				 struct perf_event_pmu_context *next_epc)
-{
-	void *prev_ctx_data, *next_ctx_data;
-
-	swap(prev_epc->task_ctx_data, next_epc->task_ctx_data);
-
-	/*
-	 * Architecture specific synchronization makes sense in case
-	 * both prev_epc->task_ctx_data and next_epc->task_ctx_data
-	 * pointers are allocated.
-	 */
-
-	prev_ctx_data = next_epc->task_ctx_data;
-	next_ctx_data = prev_epc->task_ctx_data;
-
-	if (!prev_ctx_data || !next_ctx_data)
-		return;
-
-	swap(task_context_opt(prev_ctx_data)->lbr_callstack_users,
-	     task_context_opt(next_ctx_data)->lbr_callstack_users);
-}
-
 void intel_pmu_lbr_sched_task(struct perf_event_pmu_context *pmu_ctx,
 			      struct task_struct *task, bool sched_in)
 {
diff --git a/arch/x86/events/perf_event.h b/arch/x86/events/perf_event.h
index 67d2d25..8e5a4c3 100644
--- a/arch/x86/events/perf_event.h
+++ b/arch/x86/events/perf_event.h
@@ -959,14 +959,6 @@ struct x86_pmu {
 	int		num_topdown_events;
 
 	/*
-	 * perf task context (i.e. struct perf_event_pmu_context::task_ctx_data)
-	 * switch helper to bridge calls from perf/core to perf/x86.
-	 * See struct pmu::swap_task_ctx() usage for examples;
-	 */
-	void		(*swap_task_ctx)(struct perf_event_pmu_context *prev_epc,
-					 struct perf_event_pmu_context *next_epc);
-
-	/*
 	 * AMD bits
 	 */
 	unsigned int	amd_nb_constraints : 1;
@@ -1671,9 +1663,6 @@ void intel_pmu_lbr_save_brstack(struct perf_sample_data *data,
 				struct cpu_hw_events *cpuc,
 				struct perf_event *event);
 
-void intel_pmu_lbr_swap_task_ctx(struct perf_event_pmu_context *prev_epc,
-				 struct perf_event_pmu_context *next_epc);
-
 void intel_pmu_lbr_sched_task(struct perf_event_pmu_context *pmu_ctx,
 			      struct task_struct *task, bool sched_in);
 

