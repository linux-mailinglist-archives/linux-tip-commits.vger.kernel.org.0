Return-Path: <linux-tip-commits+bounces-4249-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 67899A64A4B
	for <lists+linux-tip-commits@lfdr.de>; Mon, 17 Mar 2025 11:39:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8A1563B3333
	for <lists+linux-tip-commits@lfdr.de>; Mon, 17 Mar 2025 10:34:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7623235BF3;
	Mon, 17 Mar 2025 10:34:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="mR7sbx3J";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="XjxzhsjD"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EB26231C9F;
	Mon, 17 Mar 2025 10:34:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742207654; cv=none; b=szkycny2UtBlef3u5w11gF31eD2PKiZkQhhO/6UcVjbyag2ubyi8u9/23x/XbSAiMecrTOSc+fD4+gewFNTsHsi7p+8o6tlK3Fiy/cnHUVQm2RLb5hOjQZGulLPXWbIAG9ItIhYznegkA3WFrXNWUSI0bhnXh02QOQe235RCRsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742207654; c=relaxed/simple;
	bh=p+x/hnl7H1rMlIJa/iTOIG0A2OgbNg6ZWpumdCXhOfA=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=FUUvIjh1jS8dzNgjlopuiBnGzd8jg6K8bHX9BkMyGBz/wQ/H777RsZEC/1ueG1QgF5NYjArUmUABywt0FxI/sj5cixn8Ur9k9/v0MP8D+Pcq2NjjX044rnt+aZprMqQYe1xInouzEdQHrnIvM13Q7lz/vCh50WwWp6ACKfzKgRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=mR7sbx3J; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=XjxzhsjD; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 17 Mar 2025 10:34:09 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1742207650;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hp7NSRhTskVDvDPMiYsO9Rr8g0eFDArpK9nqwYI7XsE=;
	b=mR7sbx3JKaGrkHUbUfe7G8Z6v5suHZNpIxFbKsUec0eXWuGov8G+5NeUkHooa5G5a3fvbz
	LJ4Lz5lMRNiQ8cvy9cYjuEOk5OOM/IIBv/vQFzQX+zWfucGUZ38a1z4XNE48sOtM8DXn4v
	NMrxwtUXgagEQ1Aw+z0qcT03UM4ZbwBnH2sGkL7PaTK4lDXTrTFyz3X0xirGS+QKZCPOux
	e03uLuhxdpPX/p46/di0eBRfoxfhPne3+emATFzsTu7viM6lsabcbCZ7X408fSlLMEWT9M
	nn4BN6v1HDKHnVQNcfebGe4tF6QdRnc+V1zYHKv3VzBF4LHy0TdHvyiUBop9HA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1742207650;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hp7NSRhTskVDvDPMiYsO9Rr8g0eFDArpK9nqwYI7XsE=;
	b=XjxzhsjDAzeZIsBZXMIs/p3zi8i9nQMegJL+STgMZO2MS1PmruhMzHMbWfHqZzta3UJji0
	60TS5OB6j3OmOwDA==
From: "tip-bot2 for Kan Liang" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf: Supply task information to sched_task()
Cc: Kan Liang <kan.liang@linux.intel.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250314172700.438923-4-kan.liang@linux.intel.com>
References: <20250314172700.438923-4-kan.liang@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174220764966.14745.2133675124179600172.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     d57e94f5b891925e4f2796266eba31edd5a01903
Gitweb:        https://git.kernel.org/tip/d57e94f5b891925e4f2796266eba31edd5a01903
Author:        Kan Liang <kan.liang@linux.intel.com>
AuthorDate:    Fri, 14 Mar 2025 10:26:57 -07:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 17 Mar 2025 11:23:37 +01:00

perf: Supply task information to sched_task()

To save/restore LBR call stack data in system-wide mode, the task_struct
information is required.

Extend the parameters of sched_task() to supply task_struct information.

When schedule in, the LBR call stack data for new task will be restored.
When schedule out, the LBR call stack data for old task will be saved.
Only need to pass the required task_struct information.

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/r/20250314172700.438923-4-kan.liang@linux.intel.com
---
 arch/powerpc/perf/core-book3s.c    |  8 ++++++--
 arch/s390/kernel/perf_pai_crypto.c |  3 ++-
 arch/s390/kernel/perf_pai_ext.c    |  3 ++-
 arch/x86/events/amd/brs.c          |  3 ++-
 arch/x86/events/amd/lbr.c          |  3 ++-
 arch/x86/events/core.c             |  5 +++--
 arch/x86/events/intel/core.c       |  4 ++--
 arch/x86/events/intel/lbr.c        |  3 ++-
 arch/x86/events/perf_event.h       | 14 +++++++++-----
 include/linux/perf_event.h         |  2 +-
 kernel/events/core.c               | 20 +++++++++++---------
 11 files changed, 42 insertions(+), 26 deletions(-)

diff --git a/arch/powerpc/perf/core-book3s.c b/arch/powerpc/perf/core-book3s.c
index 2b79171..f4e03aa 100644
--- a/arch/powerpc/perf/core-book3s.c
+++ b/arch/powerpc/perf/core-book3s.c
@@ -132,7 +132,10 @@ static unsigned long ebb_switch_in(bool ebb, struct cpu_hw_events *cpuhw)
 
 static inline void power_pmu_bhrb_enable(struct perf_event *event) {}
 static inline void power_pmu_bhrb_disable(struct perf_event *event) {}
-static void power_pmu_sched_task(struct perf_event_pmu_context *pmu_ctx, bool sched_in) {}
+static void power_pmu_sched_task(struct perf_event_pmu_context *pmu_ctx,
+				 struct task_struct *task, bool sched_in)
+{
+}
 static inline void power_pmu_bhrb_read(struct perf_event *event, struct cpu_hw_events *cpuhw) {}
 static void pmao_restore_workaround(bool ebb) { }
 #endif /* CONFIG_PPC32 */
@@ -444,7 +447,8 @@ static void power_pmu_bhrb_disable(struct perf_event *event)
 /* Called from ctxsw to prevent one process's branch entries to
  * mingle with the other process's entries during context switch.
  */
-static void power_pmu_sched_task(struct perf_event_pmu_context *pmu_ctx, bool sched_in)
+static void power_pmu_sched_task(struct perf_event_pmu_context *pmu_ctx,
+				 struct task_struct *task, bool sched_in)
 {
 	if (!ppmu->bhrb_nr)
 		return;
diff --git a/arch/s390/kernel/perf_pai_crypto.c b/arch/s390/kernel/perf_pai_crypto.c
index 10725f5..6387527 100644
--- a/arch/s390/kernel/perf_pai_crypto.c
+++ b/arch/s390/kernel/perf_pai_crypto.c
@@ -518,7 +518,8 @@ static void paicrypt_have_samples(void)
 /* Called on schedule-in and schedule-out. No access to event structure,
  * but for sampling only event CRYPTO_ALL is allowed.
  */
-static void paicrypt_sched_task(struct perf_event_pmu_context *pmu_ctx, bool sched_in)
+static void paicrypt_sched_task(struct perf_event_pmu_context *pmu_ctx,
+				struct task_struct *task, bool sched_in)
 {
 	/* We started with a clean page on event installation. So read out
 	 * results on schedule_out and if page was dirty, save old values.
diff --git a/arch/s390/kernel/perf_pai_ext.c b/arch/s390/kernel/perf_pai_ext.c
index a8f0bad..fd14d5e 100644
--- a/arch/s390/kernel/perf_pai_ext.c
+++ b/arch/s390/kernel/perf_pai_ext.c
@@ -542,7 +542,8 @@ static void paiext_have_samples(void)
 /* Called on schedule-in and schedule-out. No access to event structure,
  * but for sampling only event NNPA_ALL is allowed.
  */
-static void paiext_sched_task(struct perf_event_pmu_context *pmu_ctx, bool sched_in)
+static void paiext_sched_task(struct perf_event_pmu_context *pmu_ctx,
+			      struct task_struct *task, bool sched_in)
 {
 	/* We started with a clean page on event installation. So read out
 	 * results on schedule_out and if page was dirty, save old values.
diff --git a/arch/x86/events/amd/brs.c b/arch/x86/events/amd/brs.c
index 780acd3..ec34274 100644
--- a/arch/x86/events/amd/brs.c
+++ b/arch/x86/events/amd/brs.c
@@ -381,7 +381,8 @@ static void amd_brs_poison_buffer(void)
  * On ctxswin, sched_in = true, called after the PMU has started
  * On ctxswout, sched_in = false, called before the PMU is stopped
  */
-void amd_pmu_brs_sched_task(struct perf_event_pmu_context *pmu_ctx, bool sched_in)
+void amd_pmu_brs_sched_task(struct perf_event_pmu_context *pmu_ctx,
+			    struct task_struct *task, bool sched_in)
 {
 	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
 
diff --git a/arch/x86/events/amd/lbr.c b/arch/x86/events/amd/lbr.c
index 19c7b76..c06ccca 100644
--- a/arch/x86/events/amd/lbr.c
+++ b/arch/x86/events/amd/lbr.c
@@ -371,7 +371,8 @@ void amd_pmu_lbr_del(struct perf_event *event)
 	perf_sched_cb_dec(event->pmu);
 }
 
-void amd_pmu_lbr_sched_task(struct perf_event_pmu_context *pmu_ctx, bool sched_in)
+void amd_pmu_lbr_sched_task(struct perf_event_pmu_context *pmu_ctx,
+			    struct task_struct *task, bool sched_in)
 {
 	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
 
diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
index 20ad5cc..ae8c90a 100644
--- a/arch/x86/events/core.c
+++ b/arch/x86/events/core.c
@@ -2638,9 +2638,10 @@ static const struct attribute_group *x86_pmu_attr_groups[] = {
 	NULL,
 };
 
-static void x86_pmu_sched_task(struct perf_event_pmu_context *pmu_ctx, bool sched_in)
+static void x86_pmu_sched_task(struct perf_event_pmu_context *pmu_ctx,
+			       struct task_struct *task, bool sched_in)
 {
-	static_call_cond(x86_pmu_sched_task)(pmu_ctx, sched_in);
+	static_call_cond(x86_pmu_sched_task)(pmu_ctx, task, sched_in);
 }
 
 static void x86_pmu_swap_task_ctx(struct perf_event_pmu_context *prev_epc,
diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index 5a8d6e1..3efbb03 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -5294,10 +5294,10 @@ static void intel_pmu_cpu_dead(int cpu)
 }
 
 static void intel_pmu_sched_task(struct perf_event_pmu_context *pmu_ctx,
-				 bool sched_in)
+				 struct task_struct *task, bool sched_in)
 {
 	intel_pmu_pebs_sched_task(pmu_ctx, sched_in);
-	intel_pmu_lbr_sched_task(pmu_ctx, sched_in);
+	intel_pmu_lbr_sched_task(pmu_ctx, task, sched_in);
 }
 
 static void intel_pmu_swap_task_ctx(struct perf_event_pmu_context *prev_epc,
diff --git a/arch/x86/events/intel/lbr.c b/arch/x86/events/intel/lbr.c
index dc641b5..dafeee2 100644
--- a/arch/x86/events/intel/lbr.c
+++ b/arch/x86/events/intel/lbr.c
@@ -539,7 +539,8 @@ void intel_pmu_lbr_swap_task_ctx(struct perf_event_pmu_context *prev_epc,
 	     task_context_opt(next_ctx_data)->lbr_callstack_users);
 }
 
-void intel_pmu_lbr_sched_task(struct perf_event_pmu_context *pmu_ctx, bool sched_in)
+void intel_pmu_lbr_sched_task(struct perf_event_pmu_context *pmu_ctx,
+			      struct task_struct *task, bool sched_in)
 {
 	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
 	void *task_ctx;
diff --git a/arch/x86/events/perf_event.h b/arch/x86/events/perf_event.h
index a698e64..0d5019f 100644
--- a/arch/x86/events/perf_event.h
+++ b/arch/x86/events/perf_event.h
@@ -875,7 +875,7 @@ struct x86_pmu {
 
 	void		(*check_microcode)(void);
 	void		(*sched_task)(struct perf_event_pmu_context *pmu_ctx,
-				      bool sched_in);
+				      struct task_struct *task, bool sched_in);
 
 	/*
 	 * Intel Arch Perfmon v2+
@@ -1408,7 +1408,8 @@ void amd_pmu_lbr_reset(void);
 void amd_pmu_lbr_read(void);
 void amd_pmu_lbr_add(struct perf_event *event);
 void amd_pmu_lbr_del(struct perf_event *event);
-void amd_pmu_lbr_sched_task(struct perf_event_pmu_context *pmu_ctx, bool sched_in);
+void amd_pmu_lbr_sched_task(struct perf_event_pmu_context *pmu_ctx,
+			    struct task_struct *task, bool sched_in);
 void amd_pmu_lbr_enable_all(void);
 void amd_pmu_lbr_disable_all(void);
 int amd_pmu_lbr_hw_config(struct perf_event *event);
@@ -1462,7 +1463,8 @@ static inline void amd_pmu_brs_del(struct perf_event *event)
 	perf_sched_cb_dec(event->pmu);
 }
 
-void amd_pmu_brs_sched_task(struct perf_event_pmu_context *pmu_ctx, bool sched_in);
+void amd_pmu_brs_sched_task(struct perf_event_pmu_context *pmu_ctx,
+			    struct task_struct *task, bool sched_in);
 #else
 static inline int amd_brs_init(void)
 {
@@ -1487,7 +1489,8 @@ static inline void amd_pmu_brs_del(struct perf_event *event)
 {
 }
 
-static inline void amd_pmu_brs_sched_task(struct perf_event_pmu_context *pmu_ctx, bool sched_in)
+static inline void amd_pmu_brs_sched_task(struct perf_event_pmu_context *pmu_ctx,
+					  struct task_struct *task, bool sched_in)
 {
 }
 
@@ -1670,7 +1673,8 @@ void intel_pmu_lbr_save_brstack(struct perf_sample_data *data,
 void intel_pmu_lbr_swap_task_ctx(struct perf_event_pmu_context *prev_epc,
 				 struct perf_event_pmu_context *next_epc);
 
-void intel_pmu_lbr_sched_task(struct perf_event_pmu_context *pmu_ctx, bool sched_in);
+void intel_pmu_lbr_sched_task(struct perf_event_pmu_context *pmu_ctx,
+			      struct task_struct *task, bool sched_in);
 
 u64 lbr_from_signext_quirk_wr(u64 val);
 
diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index 2551170..58f40c8 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -494,7 +494,7 @@ struct pmu {
 	 * context-switches callback
 	 */
 	void (*sched_task)		(struct perf_event_pmu_context *pmu_ctx,
-					bool sched_in);
+					 struct task_struct *task, bool sched_in);
 
 	/*
 	 * Kmem cache of PMU specific data
diff --git a/kernel/events/core.c b/kernel/events/core.c
index e86d35e..9928292 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -3613,7 +3613,8 @@ static void perf_event_swap_task_ctx_data(struct perf_event_context *prev_ctx,
 	}
 }
 
-static void perf_ctx_sched_task_cb(struct perf_event_context *ctx, bool sched_in)
+static void perf_ctx_sched_task_cb(struct perf_event_context *ctx,
+				   struct task_struct *task, bool sched_in)
 {
 	struct perf_event_pmu_context *pmu_ctx;
 	struct perf_cpu_pmu_context *cpc;
@@ -3622,7 +3623,7 @@ static void perf_ctx_sched_task_cb(struct perf_event_context *ctx, bool sched_in
 		cpc = this_cpc(pmu_ctx->pmu);
 
 		if (cpc->sched_cb_usage && pmu_ctx->pmu->sched_task)
-			pmu_ctx->pmu->sched_task(pmu_ctx, sched_in);
+			pmu_ctx->pmu->sched_task(pmu_ctx, task, sched_in);
 	}
 }
 
@@ -3685,7 +3686,7 @@ perf_event_context_sched_out(struct task_struct *task, struct task_struct *next)
 			WRITE_ONCE(ctx->task, next);
 			WRITE_ONCE(next_ctx->task, task);
 
-			perf_ctx_sched_task_cb(ctx, false);
+			perf_ctx_sched_task_cb(ctx, task, false);
 			perf_event_swap_task_ctx_data(ctx, next_ctx);
 
 			perf_ctx_enable(ctx, false);
@@ -3715,7 +3716,7 @@ unlock:
 		perf_ctx_disable(ctx, false);
 
 inside_switch:
-		perf_ctx_sched_task_cb(ctx, false);
+		perf_ctx_sched_task_cb(ctx, task, false);
 		task_ctx_sched_out(ctx, NULL, EVENT_ALL);
 
 		perf_ctx_enable(ctx, false);
@@ -3757,7 +3758,8 @@ void perf_sched_cb_inc(struct pmu *pmu)
  * PEBS requires this to provide PID/TID information. This requires we flush
  * all queued PEBS records before we context switch to a new task.
  */
-static void __perf_pmu_sched_task(struct perf_cpu_pmu_context *cpc, bool sched_in)
+static void __perf_pmu_sched_task(struct perf_cpu_pmu_context *cpc,
+				  struct task_struct *task, bool sched_in)
 {
 	struct perf_cpu_context *cpuctx = this_cpu_ptr(&perf_cpu_context);
 	struct pmu *pmu;
@@ -3771,7 +3773,7 @@ static void __perf_pmu_sched_task(struct perf_cpu_pmu_context *cpc, bool sched_i
 	perf_ctx_lock(cpuctx, cpuctx->task_ctx);
 	perf_pmu_disable(pmu);
 
-	pmu->sched_task(cpc->task_epc, sched_in);
+	pmu->sched_task(cpc->task_epc, task, sched_in);
 
 	perf_pmu_enable(pmu);
 	perf_ctx_unlock(cpuctx, cpuctx->task_ctx);
@@ -3789,7 +3791,7 @@ static void perf_pmu_sched_task(struct task_struct *prev,
 		return;
 
 	list_for_each_entry(cpc, this_cpu_ptr(&sched_cb_list), sched_cb_entry)
-		__perf_pmu_sched_task(cpc, sched_in);
+		__perf_pmu_sched_task(cpc, sched_in ? next : prev, sched_in);
 }
 
 static void perf_event_switch(struct task_struct *task,
@@ -4088,7 +4090,7 @@ static void perf_event_context_sched_in(struct task_struct *task)
 		perf_ctx_lock(cpuctx, ctx);
 		perf_ctx_disable(ctx, false);
 
-		perf_ctx_sched_task_cb(ctx, true);
+		perf_ctx_sched_task_cb(ctx, task, true);
 
 		perf_ctx_enable(ctx, false);
 		perf_ctx_unlock(cpuctx, ctx);
@@ -4119,7 +4121,7 @@ static void perf_event_context_sched_in(struct task_struct *task)
 
 	perf_event_sched_in(cpuctx, ctx, NULL);
 
-	perf_ctx_sched_task_cb(cpuctx->task_ctx, true);
+	perf_ctx_sched_task_cb(cpuctx->task_ctx, task, true);
 
 	if (!RB_EMPTY_ROOT(&ctx->pinned_groups.tree))
 		perf_ctx_enable(&cpuctx->ctx, false);

