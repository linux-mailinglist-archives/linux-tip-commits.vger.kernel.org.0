Return-Path: <linux-tip-commits+bounces-3036-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DA169E9134
	for <lists+linux-tip-commits@lfdr.de>; Mon,  9 Dec 2024 12:01:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4201E2821F4
	for <lists+linux-tip-commits@lfdr.de>; Mon,  9 Dec 2024 11:01:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72AF221A938;
	Mon,  9 Dec 2024 11:00:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="UzJLeipr";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="GL9eLtl0"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E727F219EA4;
	Mon,  9 Dec 2024 11:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733742016; cv=none; b=ONpoQMoXcr7ytkbDDqWG7DLwTq19QWiIt8UqDtgqbZpcT7FXzwwkeZQrezVcoB4LgOvR5kA9tcrKzveJQHUkAumuOGyKjV4LoOjo9dWKR7PdvJMfngbbGhS2l1zDgM0Cyfkr5xwUWXFKMeox5B7yhzwFD7BFmpQiluuSLJwr/AE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733742016; c=relaxed/simple;
	bh=QqtvclD//CUT3GRAI9J51zYs4xv3GocMYTxL+s6snDs=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=fNASR3NTulh+Aj6/XnnoyPunle6CUZqQAPJGhruwy7F08zJDuuXHoASpR7gUZgygcuKjR+iKPTBWFRfWLdq4PcnE+Cf5TGMW9ISgw//B/wpZOMfWZluvdrDGnFpNVanwFQzHEVbtwzKVt9WvLQbMs6SUe9jKLJ6Ba/F1lqzgxVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=UzJLeipr; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=GL9eLtl0; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 09 Dec 2024 11:00:11 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1733742012;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UdH5EKN3xaqvVtvoTa+ShJePB5dquDqctCN0EINDkio=;
	b=UzJLeiprxhrouOe+0/XkS37oTo38wKbzyQ2R7Ae2s007HeHJlKnZgPTYgW9oB3KuDPLKE+
	l0BFIe4g5/xLi7EFoXw7OECUOzKxLQhTVLfzHEb0sSg2TJuJ/Mg6+3LWpwcjMKnUG2XQZw
	+8ql7qDW5/OyVon5c4ynmJZCvQUqYmZTbwSeA76k2d/9v727U0Wy+YNfREyK5i9FyUSnfM
	oLLPdvm7nlPrrGO7Oyj73K+CBcaOmKyH824smUfPuW5inF85e4oXz0KN8X1AjqKsjMaD2s
	paZG6zeZTeZxkxMsq/sijOJqYgWd0DB7RbL5VoJDLy0D6e7ePq70lhs6apohAw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1733742012;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UdH5EKN3xaqvVtvoTa+ShJePB5dquDqctCN0EINDkio=;
	b=GL9eLtl0Tw0PKwqlAFauHO1iPnRVpJcGlpK9F86329vii60iZ2Q0ngqi0ELdAaty4/2fwt
	pnjddO6JuYZIpXBg==
From: "tip-bot2 for Vincent Guittot" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/fair: Rename h_nr_running into h_nr_queued
Cc: Vincent Guittot <vincent.guittot@linaro.org>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20241202174606.4074512-4-vincent.guittot@linaro.org>
References: <20241202174606.4074512-4-vincent.guittot@linaro.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173374201119.412.4001110589925286347.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     7b8a702d943827130cc00ae36075eff5500f86f1
Gitweb:        https://git.kernel.org/tip/7b8a702d943827130cc00ae36075eff5500f86f1
Author:        Vincent Guittot <vincent.guittot@linaro.org>
AuthorDate:    Mon, 02 Dec 2024 18:45:58 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 09 Dec 2024 11:48:11 +01:00

sched/fair: Rename h_nr_running into h_nr_queued

With delayed dequeued feature, a sleeping sched_entity remains queued
in the rq until its lag has elapsed but can't run.
Rename h_nr_running into h_nr_queued to reflect this new behavior.

Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
Link: https://lore.kernel.org/r/20241202174606.4074512-4-vincent.guittot@linaro.org
---
 kernel/sched/core.c  |  4 +-
 kernel/sched/debug.c |  6 +--
 kernel/sched/fair.c  | 88 +++++++++++++++++++++----------------------
 kernel/sched/pelt.c  |  4 +-
 kernel/sched/sched.h |  4 +-
 5 files changed, 53 insertions(+), 53 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 2167d38..8490293 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -1343,7 +1343,7 @@ bool sched_can_stop_tick(struct rq *rq)
 	if (scx_enabled() && !scx_can_stop_tick(rq))
 		return false;
 
-	if (rq->cfs.h_nr_running > 1)
+	if (rq->cfs.h_nr_queued > 1)
 		return false;
 
 	/*
@@ -6020,7 +6020,7 @@ __pick_next_task(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
 	 * opportunity to pull in more work from other CPUs.
 	 */
 	if (likely(!sched_class_above(prev->sched_class, &fair_sched_class) &&
-		   rq->nr_running == rq->cfs.h_nr_running)) {
+		   rq->nr_running == rq->cfs.h_nr_queued)) {
 
 		p = pick_next_task_fair(rq, prev, rf);
 		if (unlikely(p == RETRY_TASK))
diff --git a/kernel/sched/debug.c b/kernel/sched/debug.c
index a1be00a..08d6c2b 100644
--- a/kernel/sched/debug.c
+++ b/kernel/sched/debug.c
@@ -379,7 +379,7 @@ static ssize_t sched_fair_server_write(struct file *filp, const char __user *ubu
 			return  -EINVAL;
 		}
 
-		if (rq->cfs.h_nr_running) {
+		if (rq->cfs.h_nr_queued) {
 			update_rq_clock(rq);
 			dl_server_stop(&rq->fair_server);
 		}
@@ -392,7 +392,7 @@ static ssize_t sched_fair_server_write(struct file *filp, const char __user *ubu
 			printk_deferred("Fair server disabled in CPU %d, system may crash due to starvation.\n",
 					cpu_of(rq));
 
-		if (rq->cfs.h_nr_running)
+		if (rq->cfs.h_nr_queued)
 			dl_server_start(&rq->fair_server);
 	}
 
@@ -844,7 +844,7 @@ void print_cfs_rq(struct seq_file *m, int cpu, struct cfs_rq *cfs_rq)
 	spread = right_vruntime - left_vruntime;
 	SEQ_printf(m, "  .%-30s: %Ld.%06ld\n", "spread", SPLIT_NS(spread));
 	SEQ_printf(m, "  .%-30s: %d\n", "nr_running", cfs_rq->nr_running);
-	SEQ_printf(m, "  .%-30s: %d\n", "h_nr_running", cfs_rq->h_nr_running);
+	SEQ_printf(m, "  .%-30s: %d\n", "h_nr_queued", cfs_rq->h_nr_queued);
 	SEQ_printf(m, "  .%-30s: %d\n", "h_nr_delayed", cfs_rq->h_nr_delayed);
 	SEQ_printf(m, "  .%-30s: %d\n", "idle_nr_running",
 			cfs_rq->idle_nr_running);
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 1f73cb4..d6a9447 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -2128,7 +2128,7 @@ static void update_numa_stats(struct task_numa_env *env,
 		ns->load += cpu_load(rq);
 		ns->runnable += cpu_runnable(rq);
 		ns->util += cpu_util_cfs(cpu);
-		ns->nr_running += rq->cfs.h_nr_running;
+		ns->nr_running += rq->cfs.h_nr_queued;
 		ns->compute_capacity += capacity_of(cpu);
 
 		if (find_idle && idle_core < 0 && !rq->nr_running && idle_cpu(cpu)) {
@@ -5394,7 +5394,7 @@ enqueue_entity(struct cfs_rq *cfs_rq, struct sched_entity *se, int flags)
 	 * When enqueuing a sched_entity, we must:
 	 *   - Update loads to have both entity and cfs_rq synced with now.
 	 *   - For group_entity, update its runnable_weight to reflect the new
-	 *     h_nr_running of its group cfs_rq.
+	 *     h_nr_queued of its group cfs_rq.
 	 *   - For group_entity, update its weight to reflect the new share of
 	 *     its group cfs_rq
 	 *   - Add its new weight to cfs_rq->load.weight
@@ -5531,7 +5531,7 @@ dequeue_entity(struct cfs_rq *cfs_rq, struct sched_entity *se, int flags)
 	 * When dequeuing a sched_entity, we must:
 	 *   - Update loads to have both entity and cfs_rq synced with now.
 	 *   - For group_entity, update its runnable_weight to reflect the new
-	 *     h_nr_running of its group cfs_rq.
+	 *     h_nr_queued of its group cfs_rq.
 	 *   - Subtract its previous weight from cfs_rq->load.weight.
 	 *   - For group entity, update its weight to reflect the new share
 	 *     of its group cfs_rq.
@@ -5930,8 +5930,8 @@ static bool throttle_cfs_rq(struct cfs_rq *cfs_rq)
 	struct rq *rq = rq_of(cfs_rq);
 	struct cfs_bandwidth *cfs_b = tg_cfs_bandwidth(cfs_rq->tg);
 	struct sched_entity *se;
-	long task_delta, idle_task_delta, delayed_delta, dequeue = 1;
-	long rq_h_nr_running = rq->cfs.h_nr_running;
+	long queued_delta, idle_task_delta, delayed_delta, dequeue = 1;
+	long rq_h_nr_queued = rq->cfs.h_nr_queued;
 
 	raw_spin_lock(&cfs_b->lock);
 	/* This will start the period timer if necessary */
@@ -5961,7 +5961,7 @@ static bool throttle_cfs_rq(struct cfs_rq *cfs_rq)
 	walk_tg_tree_from(cfs_rq->tg, tg_throttle_down, tg_nop, (void *)rq);
 	rcu_read_unlock();
 
-	task_delta = cfs_rq->h_nr_running;
+	queued_delta = cfs_rq->h_nr_queued;
 	idle_task_delta = cfs_rq->idle_h_nr_running;
 	delayed_delta = cfs_rq->h_nr_delayed;
 	for_each_sched_entity(se) {
@@ -5983,9 +5983,9 @@ static bool throttle_cfs_rq(struct cfs_rq *cfs_rq)
 		dequeue_entity(qcfs_rq, se, flags);
 
 		if (cfs_rq_is_idle(group_cfs_rq(se)))
-			idle_task_delta = cfs_rq->h_nr_running;
+			idle_task_delta = cfs_rq->h_nr_queued;
 
-		qcfs_rq->h_nr_running -= task_delta;
+		qcfs_rq->h_nr_queued -= queued_delta;
 		qcfs_rq->idle_h_nr_running -= idle_task_delta;
 		qcfs_rq->h_nr_delayed -= delayed_delta;
 
@@ -6006,18 +6006,18 @@ static bool throttle_cfs_rq(struct cfs_rq *cfs_rq)
 		se_update_runnable(se);
 
 		if (cfs_rq_is_idle(group_cfs_rq(se)))
-			idle_task_delta = cfs_rq->h_nr_running;
+			idle_task_delta = cfs_rq->h_nr_queued;
 
-		qcfs_rq->h_nr_running -= task_delta;
+		qcfs_rq->h_nr_queued -= queued_delta;
 		qcfs_rq->idle_h_nr_running -= idle_task_delta;
 		qcfs_rq->h_nr_delayed -= delayed_delta;
 	}
 
 	/* At this point se is NULL and we are at root level*/
-	sub_nr_running(rq, task_delta);
+	sub_nr_running(rq, queued_delta);
 
 	/* Stop the fair server if throttling resulted in no runnable tasks */
-	if (rq_h_nr_running && !rq->cfs.h_nr_running)
+	if (rq_h_nr_queued && !rq->cfs.h_nr_queued)
 		dl_server_stop(&rq->fair_server);
 done:
 	/*
@@ -6036,8 +6036,8 @@ void unthrottle_cfs_rq(struct cfs_rq *cfs_rq)
 	struct rq *rq = rq_of(cfs_rq);
 	struct cfs_bandwidth *cfs_b = tg_cfs_bandwidth(cfs_rq->tg);
 	struct sched_entity *se;
-	long task_delta, idle_task_delta, delayed_delta;
-	long rq_h_nr_running = rq->cfs.h_nr_running;
+	long queued_delta, idle_task_delta, delayed_delta;
+	long rq_h_nr_queued = rq->cfs.h_nr_queued;
 
 	se = cfs_rq->tg->se[cpu_of(rq)];
 
@@ -6070,7 +6070,7 @@ void unthrottle_cfs_rq(struct cfs_rq *cfs_rq)
 		goto unthrottle_throttle;
 	}
 
-	task_delta = cfs_rq->h_nr_running;
+	queued_delta = cfs_rq->h_nr_queued;
 	idle_task_delta = cfs_rq->idle_h_nr_running;
 	delayed_delta = cfs_rq->h_nr_delayed;
 	for_each_sched_entity(se) {
@@ -6086,9 +6086,9 @@ void unthrottle_cfs_rq(struct cfs_rq *cfs_rq)
 		enqueue_entity(qcfs_rq, se, ENQUEUE_WAKEUP);
 
 		if (cfs_rq_is_idle(group_cfs_rq(se)))
-			idle_task_delta = cfs_rq->h_nr_running;
+			idle_task_delta = cfs_rq->h_nr_queued;
 
-		qcfs_rq->h_nr_running += task_delta;
+		qcfs_rq->h_nr_queued += queued_delta;
 		qcfs_rq->idle_h_nr_running += idle_task_delta;
 		qcfs_rq->h_nr_delayed += delayed_delta;
 
@@ -6104,9 +6104,9 @@ void unthrottle_cfs_rq(struct cfs_rq *cfs_rq)
 		se_update_runnable(se);
 
 		if (cfs_rq_is_idle(group_cfs_rq(se)))
-			idle_task_delta = cfs_rq->h_nr_running;
+			idle_task_delta = cfs_rq->h_nr_queued;
 
-		qcfs_rq->h_nr_running += task_delta;
+		qcfs_rq->h_nr_queued += queued_delta;
 		qcfs_rq->idle_h_nr_running += idle_task_delta;
 		qcfs_rq->h_nr_delayed += delayed_delta;
 
@@ -6116,11 +6116,11 @@ void unthrottle_cfs_rq(struct cfs_rq *cfs_rq)
 	}
 
 	/* Start the fair server if un-throttling resulted in new runnable tasks */
-	if (!rq_h_nr_running && rq->cfs.h_nr_running)
+	if (!rq_h_nr_queued && rq->cfs.h_nr_queued)
 		dl_server_start(&rq->fair_server);
 
 	/* At this point se is NULL and we are at root level*/
-	add_nr_running(rq, task_delta);
+	add_nr_running(rq, queued_delta);
 
 unthrottle_throttle:
 	assert_list_leaf_cfs_rq(rq);
@@ -6830,7 +6830,7 @@ static void hrtick_start_fair(struct rq *rq, struct task_struct *p)
 
 	SCHED_WARN_ON(task_rq(p) != rq);
 
-	if (rq->cfs.h_nr_running > 1) {
+	if (rq->cfs.h_nr_queued > 1) {
 		u64 ran = se->sum_exec_runtime - se->prev_sum_exec_runtime;
 		u64 slice = se->slice;
 		s64 delta = slice - ran;
@@ -6973,7 +6973,7 @@ enqueue_task_fair(struct rq *rq, struct task_struct *p, int flags)
 	int idle_h_nr_running = task_has_idle_policy(p);
 	int h_nr_delayed = 0;
 	int task_new = !(flags & ENQUEUE_WAKEUP);
-	int rq_h_nr_running = rq->cfs.h_nr_running;
+	int rq_h_nr_queued = rq->cfs.h_nr_queued;
 	u64 slice = 0;
 
 	/*
@@ -7021,7 +7021,7 @@ enqueue_task_fair(struct rq *rq, struct task_struct *p, int flags)
 		enqueue_entity(cfs_rq, se, flags);
 		slice = cfs_rq_min_slice(cfs_rq);
 
-		cfs_rq->h_nr_running++;
+		cfs_rq->h_nr_queued++;
 		cfs_rq->idle_h_nr_running += idle_h_nr_running;
 		cfs_rq->h_nr_delayed += h_nr_delayed;
 
@@ -7045,7 +7045,7 @@ enqueue_task_fair(struct rq *rq, struct task_struct *p, int flags)
 		se->slice = slice;
 		slice = cfs_rq_min_slice(cfs_rq);
 
-		cfs_rq->h_nr_running++;
+		cfs_rq->h_nr_queued++;
 		cfs_rq->idle_h_nr_running += idle_h_nr_running;
 		cfs_rq->h_nr_delayed += h_nr_delayed;
 
@@ -7057,7 +7057,7 @@ enqueue_task_fair(struct rq *rq, struct task_struct *p, int flags)
 			goto enqueue_throttle;
 	}
 
-	if (!rq_h_nr_running && rq->cfs.h_nr_running) {
+	if (!rq_h_nr_queued && rq->cfs.h_nr_queued) {
 		/* Account for idle runtime */
 		if (!rq->nr_running)
 			dl_server_update_idle_time(rq, rq->curr);
@@ -7104,19 +7104,19 @@ static void set_next_buddy(struct sched_entity *se);
 static int dequeue_entities(struct rq *rq, struct sched_entity *se, int flags)
 {
 	bool was_sched_idle = sched_idle_rq(rq);
-	int rq_h_nr_running = rq->cfs.h_nr_running;
+	int rq_h_nr_queued = rq->cfs.h_nr_queued;
 	bool task_sleep = flags & DEQUEUE_SLEEP;
 	bool task_delayed = flags & DEQUEUE_DELAYED;
 	struct task_struct *p = NULL;
 	int idle_h_nr_running = 0;
-	int h_nr_running = 0;
+	int h_nr_queued = 0;
 	int h_nr_delayed = 0;
 	struct cfs_rq *cfs_rq;
 	u64 slice = 0;
 
 	if (entity_is_task(se)) {
 		p = task_of(se);
-		h_nr_running = 1;
+		h_nr_queued = 1;
 		idle_h_nr_running = task_has_idle_policy(p);
 		if (!task_sleep && !task_delayed)
 			h_nr_delayed = !!se->sched_delayed;
@@ -7135,12 +7135,12 @@ static int dequeue_entities(struct rq *rq, struct sched_entity *se, int flags)
 			break;
 		}
 
-		cfs_rq->h_nr_running -= h_nr_running;
+		cfs_rq->h_nr_queued -= h_nr_queued;
 		cfs_rq->idle_h_nr_running -= idle_h_nr_running;
 		cfs_rq->h_nr_delayed -= h_nr_delayed;
 
 		if (cfs_rq_is_idle(cfs_rq))
-			idle_h_nr_running = h_nr_running;
+			idle_h_nr_running = h_nr_queued;
 
 		/* end evaluation on encountering a throttled cfs_rq */
 		if (cfs_rq_throttled(cfs_rq))
@@ -7174,21 +7174,21 @@ static int dequeue_entities(struct rq *rq, struct sched_entity *se, int flags)
 		se->slice = slice;
 		slice = cfs_rq_min_slice(cfs_rq);
 
-		cfs_rq->h_nr_running -= h_nr_running;
+		cfs_rq->h_nr_queued -= h_nr_queued;
 		cfs_rq->idle_h_nr_running -= idle_h_nr_running;
 		cfs_rq->h_nr_delayed -= h_nr_delayed;
 
 		if (cfs_rq_is_idle(cfs_rq))
-			idle_h_nr_running = h_nr_running;
+			idle_h_nr_running = h_nr_queued;
 
 		/* end evaluation on encountering a throttled cfs_rq */
 		if (cfs_rq_throttled(cfs_rq))
 			return 0;
 	}
 
-	sub_nr_running(rq, h_nr_running);
+	sub_nr_running(rq, h_nr_queued);
 
-	if (rq_h_nr_running && !rq->cfs.h_nr_running)
+	if (rq_h_nr_queued && !rq->cfs.h_nr_queued)
 		dl_server_stop(&rq->fair_server);
 
 	/* balance early to pull high priority tasks */
@@ -10316,7 +10316,7 @@ sched_reduced_capacity(struct rq *rq, struct sched_domain *sd)
 	 * When there is more than 1 task, the group_overloaded case already
 	 * takes care of cpu with reduced capacity
 	 */
-	if (rq->cfs.h_nr_running != 1)
+	if (rq->cfs.h_nr_queued != 1)
 		return false;
 
 	return check_cpu_capacity(rq, sd);
@@ -10351,7 +10351,7 @@ static inline void update_sg_lb_stats(struct lb_env *env,
 		sgs->group_load += load;
 		sgs->group_util += cpu_util_cfs(i);
 		sgs->group_runnable += cpu_runnable(rq);
-		sgs->sum_h_nr_running += rq->cfs.h_nr_running;
+		sgs->sum_h_nr_running += rq->cfs.h_nr_queued;
 
 		nr_running = rq->nr_running;
 		sgs->sum_nr_running += nr_running;
@@ -10666,7 +10666,7 @@ static inline void update_sg_wakeup_stats(struct sched_domain *sd,
 		sgs->group_util += cpu_util_without(i, p);
 		sgs->group_runnable += cpu_runnable_without(rq, p);
 		local = task_running_on_cpu(i, p);
-		sgs->sum_h_nr_running += rq->cfs.h_nr_running - local;
+		sgs->sum_h_nr_running += rq->cfs.h_nr_queued - local;
 
 		nr_running = rq->nr_running - local;
 		sgs->sum_nr_running += nr_running;
@@ -11448,7 +11448,7 @@ static struct rq *sched_balance_find_src_rq(struct lb_env *env,
 		if (rt > env->fbq_type)
 			continue;
 
-		nr_running = rq->cfs.h_nr_running;
+		nr_running = rq->cfs.h_nr_queued;
 		if (!nr_running)
 			continue;
 
@@ -11607,7 +11607,7 @@ static int need_active_balance(struct lb_env *env)
 	 * available on dst_cpu.
 	 */
 	if (env->idle &&
-	    (env->src_rq->cfs.h_nr_running == 1)) {
+	    (env->src_rq->cfs.h_nr_queued == 1)) {
 		if ((check_cpu_capacity(env->src_rq, sd)) &&
 		    (capacity_of(env->src_cpu)*sd->imbalance_pct < capacity_of(env->dst_cpu)*100))
 			return 1;
@@ -12348,7 +12348,7 @@ static void nohz_balancer_kick(struct rq *rq)
 		 * If there's a runnable CFS task and the current CPU has reduced
 		 * capacity, kick the ILB to see if there's a better CPU to run on:
 		 */
-		if (rq->cfs.h_nr_running >= 1 && check_cpu_capacity(rq, sd)) {
+		if (rq->cfs.h_nr_queued >= 1 && check_cpu_capacity(rq, sd)) {
 			flags = NOHZ_STATS_KICK | NOHZ_BALANCE_KICK;
 			goto unlock;
 		}
@@ -12835,11 +12835,11 @@ static int sched_balance_newidle(struct rq *this_rq, struct rq_flags *rf)
 	 * have been enqueued in the meantime. Since we're not going idle,
 	 * pretend we pulled a task.
 	 */
-	if (this_rq->cfs.h_nr_running && !pulled_task)
+	if (this_rq->cfs.h_nr_queued && !pulled_task)
 		pulled_task = 1;
 
 	/* Is there a task of a high priority class? */
-	if (this_rq->nr_running != this_rq->cfs.h_nr_running)
+	if (this_rq->nr_running != this_rq->cfs.h_nr_queued)
 		pulled_task = -1;
 
 out:
@@ -13526,7 +13526,7 @@ int sched_group_set_idle(struct task_group *tg, long idle)
 				parent_cfs_rq->idle_nr_running--;
 		}
 
-		idle_task_delta = grp_cfs_rq->h_nr_running -
+		idle_task_delta = grp_cfs_rq->h_nr_queued -
 				  grp_cfs_rq->idle_h_nr_running;
 		if (!cfs_rq_is_idle(grp_cfs_rq))
 			idle_task_delta *= -1;
diff --git a/kernel/sched/pelt.c b/kernel/sched/pelt.c
index fee75cc..2bad0b5 100644
--- a/kernel/sched/pelt.c
+++ b/kernel/sched/pelt.c
@@ -275,7 +275,7 @@ ___update_load_avg(struct sched_avg *sa, unsigned long load)
  *
  *   group: [ see update_cfs_group() ]
  *     se_weight()   = tg->weight * grq->load_avg / tg->load_avg
- *     se_runnable() = grq->h_nr_running
+ *     se_runnable() = grq->h_nr_queued
  *
  *   runnable_sum = se_runnable() * runnable = grq->runnable_sum
  *   runnable_avg = runnable_sum
@@ -321,7 +321,7 @@ int __update_load_avg_cfs_rq(u64 now, struct cfs_rq *cfs_rq)
 {
 	if (___update_load_sum(now, &cfs_rq->avg,
 				scale_load_down(cfs_rq->load.weight),
-				cfs_rq->h_nr_running - cfs_rq->h_nr_delayed,
+				cfs_rq->h_nr_queued - cfs_rq->h_nr_delayed,
 				cfs_rq->curr != NULL)) {
 
 		___update_load_avg(&cfs_rq->avg, 1);
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 99d19c6..b011081 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -646,7 +646,7 @@ struct balance_callback {
 struct cfs_rq {
 	struct load_weight	load;
 	unsigned int		nr_running;
-	unsigned int		h_nr_running;      /* SCHED_{NORMAL,BATCH,IDLE} */
+	unsigned int		h_nr_queued;       /* SCHED_{NORMAL,BATCH,IDLE} */
 	unsigned int		idle_nr_running;   /* SCHED_IDLE */
 	unsigned int		idle_h_nr_running; /* SCHED_IDLE */
 	unsigned int		h_nr_delayed;
@@ -902,7 +902,7 @@ static inline void se_update_runnable(struct sched_entity *se)
 	if (!entity_is_task(se)) {
 		struct cfs_rq *cfs_rq = se->my_q;
 
-		se->runnable_weight = cfs_rq->h_nr_running - cfs_rq->h_nr_delayed;
+		se->runnable_weight = cfs_rq->h_nr_queued - cfs_rq->h_nr_delayed;
 	}
 }
 

