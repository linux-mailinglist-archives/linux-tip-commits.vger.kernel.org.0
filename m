Return-Path: <linux-tip-commits+bounces-3033-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B6079E912E
	for <lists+linux-tip-commits@lfdr.de>; Mon,  9 Dec 2024 12:01:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E6CA62812C5
	for <lists+linux-tip-commits@lfdr.de>; Mon,  9 Dec 2024 11:01:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFADB219EA2;
	Mon,  9 Dec 2024 11:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="NoUZwOdL";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="88KPOi8l"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEFDF217F25;
	Mon,  9 Dec 2024 11:00:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733742013; cv=none; b=iEM23wAXamaftuSjzYGN5HE/dObnjxkHmEjqEgjTzKXPwMg5JkQTICsqiBNXbkKEAm8lpR/EfvFjch+zouqcoBM4Fq6DI3nb77dGVbwP09hrauYiGRqtx2I+lb2jBC76t70at3WbZquykYo/R2Pi68KwMcuXz5NNkIzSk+yoXH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733742013; c=relaxed/simple;
	bh=NZNglsTXaSuyIATv9B+5Vp9zpQyhJ5jYCiQZ/tXfxAg=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=Lfct7SYfg3cEKTpauXjLI/LHNoIZtf/IUw5ANA7O2m3Rqrp6WCzkjfdEiL43GqwL04GitZ83GQQTtdIssYmfkKQjJQj+6Too33lOAovqXJsE9bzXiQAnIH0jjpG78XHWhVQnbWljTvEcyUWKEkEvAKUjE/YvbT7XEhkFqEt/liY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=NoUZwOdL; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=88KPOi8l; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 09 Dec 2024 11:00:09 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1733742010;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+zIc43sKl1fgtV8f4/1/MrYdZoSAAsNfaenqiVHnR1A=;
	b=NoUZwOdLXa99vU1OEj6qguNaOH8vfsSs7shH2M7eZpTjLdBJk5c2/STHlC8Ela0Gvvjd5l
	ZSuJloqkpoqFNkr5H+TJkCRbFzJhl5/Lbf9IgOJfIesyavcbJyvfKHcAPqMPa+Xp1RROSe
	rRD7gxIm6Xk0b3Komwutrt9M/kmIWR0dLjuEK+g4hT0fegm71BQN7BijuxN6SJEowWO89C
	eO+n0DYZZvA7pRkNvz3EANmHIAAspc0cTSuieWnX9mdHWAJbRjfupOJbVjmA4yJaroJHsf
	t7nHcOHdYIdkxoVgVZ6MzUAGGB1FEnWXjAR6h/6dO58JBv9lvCyrhjY6qb/Qrg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1733742010;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+zIc43sKl1fgtV8f4/1/MrYdZoSAAsNfaenqiVHnR1A=;
	b=88KPOi8llLDtabeHFVJSa4rQz7iPCP572axVqIBh/ZrvEw5rKtLBl4m3+kt+sPghNWeoZA
	4oaGLDlF690+8MCw==
From: "tip-bot2 for Vincent Guittot" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/fair: Use the new cfs_rq.h_nr_runnable
Cc: Vincent Guittot <vincent.guittot@linaro.org>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20241202174606.4074512-6-vincent.guittot@linaro.org>
References: <20241202174606.4074512-6-vincent.guittot@linaro.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173374200921.412.11779983317134507568.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     1a49104496d38cdcb7d9106ec23773a52c7a7e82
Gitweb:        https://git.kernel.org/tip/1a49104496d38cdcb7d9106ec23773a52c7a7e82
Author:        Vincent Guittot <vincent.guittot@linaro.org>
AuthorDate:    Mon, 02 Dec 2024 18:46:00 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 09 Dec 2024 11:48:11 +01:00

sched/fair: Use the new cfs_rq.h_nr_runnable

Use the new h_nr_runnable that tracks only queued and runnable tasks in the
statistics that are used to balance the system:

 - PELT runnable_avg
 - deciding if a group is overloaded or has spare capacity
 - numa stats
 - reduced capacity management
 - load balance
 - nohz kick

It should be noticed that the rq->nr_running still counts the delayed
dequeued tasks as delayed dequeue is a fair feature that is meaningless
at core level.

Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
Link: https://lore.kernel.org/r/20241202174606.4074512-6-vincent.guittot@linaro.org
---
 kernel/sched/fair.c  | 18 +++++++++---------
 kernel/sched/pelt.c  |  4 ++--
 kernel/sched/sched.h |  7 ++-----
 3 files changed, 13 insertions(+), 16 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index ed01e72..3a8bdfb 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -2128,7 +2128,7 @@ static void update_numa_stats(struct task_numa_env *env,
 		ns->load += cpu_load(rq);
 		ns->runnable += cpu_runnable(rq);
 		ns->util += cpu_util_cfs(cpu);
-		ns->nr_running += rq->cfs.h_nr_queued;
+		ns->nr_running += rq->cfs.h_nr_runnable;
 		ns->compute_capacity += capacity_of(cpu);
 
 		if (find_idle && idle_core < 0 && !rq->nr_running && idle_cpu(cpu)) {
@@ -5394,7 +5394,7 @@ enqueue_entity(struct cfs_rq *cfs_rq, struct sched_entity *se, int flags)
 	 * When enqueuing a sched_entity, we must:
 	 *   - Update loads to have both entity and cfs_rq synced with now.
 	 *   - For group_entity, update its runnable_weight to reflect the new
-	 *     h_nr_queued of its group cfs_rq.
+	 *     h_nr_runnable of its group cfs_rq.
 	 *   - For group_entity, update its weight to reflect the new share of
 	 *     its group cfs_rq
 	 *   - Add its new weight to cfs_rq->load.weight
@@ -5533,7 +5533,7 @@ dequeue_entity(struct cfs_rq *cfs_rq, struct sched_entity *se, int flags)
 	 * When dequeuing a sched_entity, we must:
 	 *   - Update loads to have both entity and cfs_rq synced with now.
 	 *   - For group_entity, update its runnable_weight to reflect the new
-	 *     h_nr_queued of its group cfs_rq.
+	 *     h_nr_runnable of its group cfs_rq.
 	 *   - Subtract its previous weight from cfs_rq->load.weight.
 	 *   - For group entity, update its weight to reflect the new share
 	 *     of its group cfs_rq.
@@ -10332,7 +10332,7 @@ sched_reduced_capacity(struct rq *rq, struct sched_domain *sd)
 	 * When there is more than 1 task, the group_overloaded case already
 	 * takes care of cpu with reduced capacity
 	 */
-	if (rq->cfs.h_nr_queued != 1)
+	if (rq->cfs.h_nr_runnable != 1)
 		return false;
 
 	return check_cpu_capacity(rq, sd);
@@ -10367,7 +10367,7 @@ static inline void update_sg_lb_stats(struct lb_env *env,
 		sgs->group_load += load;
 		sgs->group_util += cpu_util_cfs(i);
 		sgs->group_runnable += cpu_runnable(rq);
-		sgs->sum_h_nr_running += rq->cfs.h_nr_queued;
+		sgs->sum_h_nr_running += rq->cfs.h_nr_runnable;
 
 		nr_running = rq->nr_running;
 		sgs->sum_nr_running += nr_running;
@@ -10682,7 +10682,7 @@ static inline void update_sg_wakeup_stats(struct sched_domain *sd,
 		sgs->group_util += cpu_util_without(i, p);
 		sgs->group_runnable += cpu_runnable_without(rq, p);
 		local = task_running_on_cpu(i, p);
-		sgs->sum_h_nr_running += rq->cfs.h_nr_queued - local;
+		sgs->sum_h_nr_running += rq->cfs.h_nr_runnable - local;
 
 		nr_running = rq->nr_running - local;
 		sgs->sum_nr_running += nr_running;
@@ -11464,7 +11464,7 @@ static struct rq *sched_balance_find_src_rq(struct lb_env *env,
 		if (rt > env->fbq_type)
 			continue;
 
-		nr_running = rq->cfs.h_nr_queued;
+		nr_running = rq->cfs.h_nr_runnable;
 		if (!nr_running)
 			continue;
 
@@ -11623,7 +11623,7 @@ static int need_active_balance(struct lb_env *env)
 	 * available on dst_cpu.
 	 */
 	if (env->idle &&
-	    (env->src_rq->cfs.h_nr_queued == 1)) {
+	    (env->src_rq->cfs.h_nr_runnable == 1)) {
 		if ((check_cpu_capacity(env->src_rq, sd)) &&
 		    (capacity_of(env->src_cpu)*sd->imbalance_pct < capacity_of(env->dst_cpu)*100))
 			return 1;
@@ -12364,7 +12364,7 @@ static void nohz_balancer_kick(struct rq *rq)
 		 * If there's a runnable CFS task and the current CPU has reduced
 		 * capacity, kick the ILB to see if there's a better CPU to run on:
 		 */
-		if (rq->cfs.h_nr_queued >= 1 && check_cpu_capacity(rq, sd)) {
+		if (rq->cfs.h_nr_runnable >= 1 && check_cpu_capacity(rq, sd)) {
 			flags = NOHZ_STATS_KICK | NOHZ_BALANCE_KICK;
 			goto unlock;
 		}
diff --git a/kernel/sched/pelt.c b/kernel/sched/pelt.c
index 2bad0b5..7a8534a 100644
--- a/kernel/sched/pelt.c
+++ b/kernel/sched/pelt.c
@@ -275,7 +275,7 @@ ___update_load_avg(struct sched_avg *sa, unsigned long load)
  *
  *   group: [ see update_cfs_group() ]
  *     se_weight()   = tg->weight * grq->load_avg / tg->load_avg
- *     se_runnable() = grq->h_nr_queued
+ *     se_runnable() = grq->h_nr_runnable
  *
  *   runnable_sum = se_runnable() * runnable = grq->runnable_sum
  *   runnable_avg = runnable_sum
@@ -321,7 +321,7 @@ int __update_load_avg_cfs_rq(u64 now, struct cfs_rq *cfs_rq)
 {
 	if (___update_load_sum(now, &cfs_rq->avg,
 				scale_load_down(cfs_rq->load.weight),
-				cfs_rq->h_nr_queued - cfs_rq->h_nr_delayed,
+				cfs_rq->h_nr_runnable,
 				cfs_rq->curr != NULL)) {
 
 		___update_load_avg(&cfs_rq->avg, 1);
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 869d5d3..4374c66 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -900,11 +900,8 @@ struct dl_rq {
 
 static inline void se_update_runnable(struct sched_entity *se)
 {
-	if (!entity_is_task(se)) {
-		struct cfs_rq *cfs_rq = se->my_q;
-
-		se->runnable_weight = cfs_rq->h_nr_queued - cfs_rq->h_nr_delayed;
-	}
+	if (!entity_is_task(se))
+		se->runnable_weight = se->my_q->h_nr_runnable;
 }
 
 static inline long se_runnable(struct sched_entity *se)

