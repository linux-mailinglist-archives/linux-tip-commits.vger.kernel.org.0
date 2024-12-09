Return-Path: <linux-tip-commits+bounces-3030-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EDA39E9128
	for <lists+linux-tip-commits@lfdr.de>; Mon,  9 Dec 2024 12:00:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 883A51886D9E
	for <lists+linux-tip-commits@lfdr.de>; Mon,  9 Dec 2024 11:00:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D43D2218839;
	Mon,  9 Dec 2024 11:00:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ljordc0M";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ZD7dldU5"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D703820FABD;
	Mon,  9 Dec 2024 11:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733742009; cv=none; b=MDV5WUPAYSpzetKp43vwm3juL3s4uRtf6bNJu1I/eDtKV/husNLsYijcpSECJuilrWUWVRuiADRko1NNUYOmi1UVWStxBXSGpmn98heCbz03dglc7m3hhhI+I3/xXlN+NFA1o0z9CV5PRZUjAw5c2dW8jKR1g6oWN02VIsmjdUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733742009; c=relaxed/simple;
	bh=pwIYFNRi0QJhelf3hs+PZa7aWGU5ZuI3Y/bNFcUFA4c=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=CSLFP0+t3saa1PNTBckkCPFrWdVFvHcLvR9hu4N2Ylxw4tk3FXBJl7cYnM6Umzc3phRi3noewBHeGMjOkvX/2/G3zjaXuk4oQi0dwFUChihpPHl2ljHVaxLTQYmN8nO+jR4M0YynePktwP720KiAWEVyfkOqU83xrzct/pqp+tg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ljordc0M; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ZD7dldU5; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 09 Dec 2024 11:00:04 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1733742006;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lMULwidVvz1Qh32P447sUZGLss7FdGka/8D/R6YDZek=;
	b=ljordc0MHa5xtQ2ejLtS5WdNLTxH3PHD/kpgEJtCHPwW7Qf18iN+XWEZIGL9uz/tJy0Dl+
	n0uE1FjeBKk/6rHn9L5jtTgxTUVjssi5ttsZvmr2bACCoPEVvbMNe+BD32XxagVW5JyMDp
	QC6aJIAsOZfwULgnOdhY/8GanEDqOAGNUrio97Ub4SapflyntEvguvO3R+mT5tSerUOxcl
	9jZzf3WWJImXG58DVOcn1DFqBXmdb886uyXprRp1xRFrVRhfLIoiapdLXDee8JSxrxTA/C
	cx4om41tHRuq+lbXmm5/E5vkRpeMKOwZ8U5XAXqznzXG7sozbhSd4p06RpC5kQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1733742006;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lMULwidVvz1Qh32P447sUZGLss7FdGka/8D/R6YDZek=;
	b=ZD7dldU590iAEPKLeXCu9Ujgk1JbDGyxKzldyDAZQ0yVmF0ROUf1nk4Hwyo+fUUZ8FQk+O
	DhDAPeeCvq8HUcCA==
From: "tip-bot2 for Vincent Guittot" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/fair: Rename cfs_rq.nr_running into nr_queued
Cc: Vincent Guittot <vincent.guittot@linaro.org>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20241202174606.4074512-10-vincent.guittot@linaro.org>
References: <20241202174606.4074512-10-vincent.guittot@linaro.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173374200481.412.742906626520407901.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     736c55a02c477ad31c57ae4c69130f437855e051
Gitweb:        https://git.kernel.org/tip/736c55a02c477ad31c57ae4c69130f437855e051
Author:        Vincent Guittot <vincent.guittot@linaro.org>
AuthorDate:    Mon, 02 Dec 2024 18:46:04 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 09 Dec 2024 11:48:12 +01:00

sched/fair: Rename cfs_rq.nr_running into nr_queued

Rename cfs_rq.nr_running into cfs_rq.nr_queued which better reflects the
reality as the value includes both the ready to run tasks and the delayed
dequeue tasks.

Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
Link: https://lore.kernel.org/r/20241202174606.4074512-10-vincent.guittot@linaro.org
---
 kernel/sched/debug.c |  2 +-
 kernel/sched/fair.c  | 38 +++++++++++++++++++-------------------
 kernel/sched/sched.h |  4 ++--
 3 files changed, 22 insertions(+), 22 deletions(-)

diff --git a/kernel/sched/debug.c b/kernel/sched/debug.c
index e300ee4..5e8e84a 100644
--- a/kernel/sched/debug.c
+++ b/kernel/sched/debug.c
@@ -843,7 +843,7 @@ void print_cfs_rq(struct seq_file *m, int cpu, struct cfs_rq *cfs_rq)
 			SPLIT_NS(right_vruntime));
 	spread = right_vruntime - left_vruntime;
 	SEQ_printf(m, "  .%-30s: %Ld.%06ld\n", "spread", SPLIT_NS(spread));
-	SEQ_printf(m, "  .%-30s: %d\n", "nr_running", cfs_rq->nr_running);
+	SEQ_printf(m, "  .%-30s: %d\n", "nr_queued", cfs_rq->nr_queued);
 	SEQ_printf(m, "  .%-30s: %d\n", "h_nr_runnable", cfs_rq->h_nr_runnable);
 	SEQ_printf(m, "  .%-30s: %d\n", "h_nr_queued", cfs_rq->h_nr_queued);
 	SEQ_printf(m, "  .%-30s: %d\n", "h_nr_idle", cfs_rq->h_nr_idle);
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 8afa0a4..84c0191 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -915,7 +915,7 @@ static struct sched_entity *pick_eevdf(struct cfs_rq *cfs_rq)
 	 * We can safely skip eligibility check if there is only one entity
 	 * in this cfs_rq, saving some cycles.
 	 */
-	if (cfs_rq->nr_running == 1)
+	if (cfs_rq->nr_queued == 1)
 		return curr && curr->on_rq ? curr : se;
 
 	if (curr && (!curr->on_rq || !entity_eligible(cfs_rq, curr)))
@@ -1247,7 +1247,7 @@ static void update_curr(struct cfs_rq *cfs_rq)
 
 	account_cfs_rq_runtime(cfs_rq, delta_exec);
 
-	if (cfs_rq->nr_running == 1)
+	if (cfs_rq->nr_queued == 1)
 		return;
 
 	if (resched || did_preempt_short(cfs_rq, curr)) {
@@ -3673,7 +3673,7 @@ account_entity_enqueue(struct cfs_rq *cfs_rq, struct sched_entity *se)
 		list_add(&se->group_node, &rq->cfs_tasks);
 	}
 #endif
-	cfs_rq->nr_running++;
+	cfs_rq->nr_queued++;
 }
 
 static void
@@ -3686,7 +3686,7 @@ account_entity_dequeue(struct cfs_rq *cfs_rq, struct sched_entity *se)
 		list_del_init(&se->group_node);
 	}
 #endif
-	cfs_rq->nr_running--;
+	cfs_rq->nr_queued--;
 }
 
 /*
@@ -5220,7 +5220,7 @@ static inline void update_misfit_status(struct task_struct *p, struct rq *rq)
 
 static inline bool cfs_rq_is_decayed(struct cfs_rq *cfs_rq)
 {
-	return !cfs_rq->nr_running;
+	return !cfs_rq->nr_queued;
 }
 
 #define UPDATE_TG	0x0
@@ -5276,7 +5276,7 @@ place_entity(struct cfs_rq *cfs_rq, struct sched_entity *se, int flags)
 	 *
 	 * EEVDF: placement strategy #1 / #2
 	 */
-	if (sched_feat(PLACE_LAG) && cfs_rq->nr_running && se->vlag) {
+	if (sched_feat(PLACE_LAG) && cfs_rq->nr_queued && se->vlag) {
 		struct sched_entity *curr = cfs_rq->curr;
 		unsigned long load;
 
@@ -5423,7 +5423,7 @@ enqueue_entity(struct cfs_rq *cfs_rq, struct sched_entity *se, int flags)
 		__enqueue_entity(cfs_rq, se);
 	se->on_rq = 1;
 
-	if (cfs_rq->nr_running == 1) {
+	if (cfs_rq->nr_queued == 1) {
 		check_enqueue_throttle(cfs_rq);
 		if (!throttled_hierarchy(cfs_rq)) {
 			list_add_leaf_cfs_rq(cfs_rq);
@@ -5565,7 +5565,7 @@ dequeue_entity(struct cfs_rq *cfs_rq, struct sched_entity *se, int flags)
 	if (flags & DEQUEUE_DELAYED)
 		finish_delayed_dequeue_entity(se);
 
-	if (cfs_rq->nr_running == 0)
+	if (cfs_rq->nr_queued == 0)
 		update_idle_cfs_rq_clock_pelt(cfs_rq);
 
 	return true;
@@ -5913,7 +5913,7 @@ static int tg_throttle_down(struct task_group *tg, void *data)
 		list_del_leaf_cfs_rq(cfs_rq);
 
 		SCHED_WARN_ON(cfs_rq->throttled_clock_self);
-		if (cfs_rq->nr_running)
+		if (cfs_rq->nr_queued)
 			cfs_rq->throttled_clock_self = rq_clock(rq);
 	}
 	cfs_rq->throttle_count++;
@@ -6022,7 +6022,7 @@ done:
 	 */
 	cfs_rq->throttled = 1;
 	SCHED_WARN_ON(cfs_rq->throttled_clock);
-	if (cfs_rq->nr_running)
+	if (cfs_rq->nr_queued)
 		cfs_rq->throttled_clock = rq_clock(rq);
 	return true;
 }
@@ -6122,7 +6122,7 @@ unthrottle_throttle:
 	assert_list_leaf_cfs_rq(rq);
 
 	/* Determine whether we need to wake up potentially idle CPU: */
-	if (rq->curr == rq->idle && rq->cfs.nr_running)
+	if (rq->curr == rq->idle && rq->cfs.nr_queued)
 		resched_curr(rq);
 }
 
@@ -6423,7 +6423,7 @@ static __always_inline void return_cfs_rq_runtime(struct cfs_rq *cfs_rq)
 	if (!cfs_bandwidth_used())
 		return;
 
-	if (!cfs_rq->runtime_enabled || cfs_rq->nr_running)
+	if (!cfs_rq->runtime_enabled || cfs_rq->nr_queued)
 		return;
 
 	__return_cfs_rq_runtime(cfs_rq);
@@ -6941,14 +6941,14 @@ requeue_delayed_entity(struct sched_entity *se)
 	if (sched_feat(DELAY_ZERO)) {
 		update_entity_lag(cfs_rq, se);
 		if (se->vlag > 0) {
-			cfs_rq->nr_running--;
+			cfs_rq->nr_queued--;
 			if (se != cfs_rq->curr)
 				__dequeue_entity(cfs_rq, se);
 			se->vlag = 0;
 			place_entity(cfs_rq, se, 0);
 			if (se != cfs_rq->curr)
 				__enqueue_entity(cfs_rq, se);
-			cfs_rq->nr_running++;
+			cfs_rq->nr_queued++;
 		}
 	}
 
@@ -8873,7 +8873,7 @@ static struct task_struct *pick_task_fair(struct rq *rq)
 
 again:
 	cfs_rq = &rq->cfs;
-	if (!cfs_rq->nr_running)
+	if (!cfs_rq->nr_queued)
 		return NULL;
 
 	do {
@@ -8990,7 +8990,7 @@ static struct task_struct *__pick_next_task_fair(struct rq *rq, struct task_stru
 
 static bool fair_server_has_tasks(struct sched_dl_entity *dl_se)
 {
-	return !!dl_se->rq->cfs.nr_running;
+	return !!dl_se->rq->cfs.nr_queued;
 }
 
 static struct task_struct *fair_server_pick_task(struct sched_dl_entity *dl_se)
@@ -9780,7 +9780,7 @@ static bool __update_blocked_fair(struct rq *rq, bool *done)
 		if (update_cfs_rq_load_avg(cfs_rq_clock_pelt(cfs_rq), cfs_rq)) {
 			update_tg_load_avg(cfs_rq);
 
-			if (cfs_rq->nr_running == 0)
+			if (cfs_rq->nr_queued == 0)
 				update_idle_cfs_rq_clock_pelt(cfs_rq);
 
 			if (cfs_rq == &rq->cfs)
@@ -12949,7 +12949,7 @@ static inline void task_tick_core(struct rq *rq, struct task_struct *curr)
 	 * MIN_NR_TASKS_DURING_FORCEIDLE - 1 tasks and use that to check
 	 * if we need to give up the CPU.
 	 */
-	if (rq->core->core_forceidle_count && rq->cfs.nr_running == 1 &&
+	if (rq->core->core_forceidle_count && rq->cfs.nr_queued == 1 &&
 	    __entity_slice_used(&curr->se, MIN_NR_TASKS_DURING_FORCEIDLE))
 		resched_curr(rq);
 }
@@ -13093,7 +13093,7 @@ prio_changed_fair(struct rq *rq, struct task_struct *p, int oldprio)
 	if (!task_on_rq_queued(p))
 		return;
 
-	if (rq->cfs.nr_running == 1)
+	if (rq->cfs.nr_queued == 1)
 		return;
 
 	/*
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 9a9220a..aef716c 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -645,7 +645,7 @@ struct balance_callback {
 /* CFS-related fields in a runqueue */
 struct cfs_rq {
 	struct load_weight	load;
-	unsigned int		nr_running;
+	unsigned int		nr_queued;
 	unsigned int		h_nr_queued;       /* SCHED_{NORMAL,BATCH,IDLE} */
 	unsigned int		h_nr_runnable;     /* SCHED_{NORMAL,BATCH,IDLE} */
 	unsigned int		h_nr_idle; /* SCHED_IDLE */
@@ -2565,7 +2565,7 @@ static inline bool sched_rt_runnable(struct rq *rq)
 
 static inline bool sched_fair_runnable(struct rq *rq)
 {
-	return rq->cfs.nr_running > 0;
+	return rq->cfs.nr_queued > 0;
 }
 
 extern struct task_struct *pick_next_task_fair(struct rq *rq, struct task_struct *prev, struct rq_flags *rf);

