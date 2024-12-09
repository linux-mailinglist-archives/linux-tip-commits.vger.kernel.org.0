Return-Path: <linux-tip-commits+bounces-3037-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 489C19E9137
	for <lists+linux-tip-commits@lfdr.de>; Mon,  9 Dec 2024 12:01:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 114F3164BF3
	for <lists+linux-tip-commits@lfdr.de>; Mon,  9 Dec 2024 11:01:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AF1921A94C;
	Mon,  9 Dec 2024 11:00:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="JgMXnjRv";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="TvzMVULf"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22BB021A923;
	Mon,  9 Dec 2024 11:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733742017; cv=none; b=OuwKxOdWYM6/Xq8dKYwdoRzu2nkHq+1GmVnYNHirKqu5IOpsqh2oiNxyy2MlBDc6X7entQd06BQgoHWZYR5hPZVkUnaIpPMCW0bHr6VSWJlwXs1esO81TKjGEd3fohGE0vKcTWPn8NNhN6TL2X7/KYEwODqLxn55ciSmpQyT7fU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733742017; c=relaxed/simple;
	bh=l7u2gNcnjhCo/kv9R7/QEhdUqwEnV1oie0Oh/CxLQhw=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=iYlKTntGafxZo8E0UgESA57ZnUN61xKRQTpUxp4bnMDeIahF2QuESPMiIIrA8mfonY9cl8ujBxO3Tx0WFkeyBj6YD/BA1CCwKbGITXsGtG6qpeVC/xPugq3lNE2tXsSczhspOhY2QjVnEd+KYy+6LdsSz+tqL1XFGUc6SXknyQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=JgMXnjRv; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=TvzMVULf; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 09 Dec 2024 11:00:12 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1733742013;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aH6pTnB0rbRFH1gBv6G1raAnKejJn3JBy/+AIl3WLTI=;
	b=JgMXnjRvpgDdPUKn2oGZumZfW55gcgoPQSM8hDS8kARkplNkRObdj5x6sWRn/1JUUBvl7N
	iwgZNc5HQAC6Esa8FesXSUnysEveo7B2LqQwwQ7VQHythZdJMxjXQcoAHLQb01OxleShGu
	479DPnPMxMiabs6wrJd58eHP0+VbJdx/BIJSDUy/1zy9qiWaslkw23s59BiwWUC8ccfsaB
	gQhDz1iCScjmipwMdA55tTOL2PG7qcfOV88u9MaqAW1q5Y6epSuYR7cZeM85wh1x3hZ6dT
	/FNmFHhXGrMHCxN2a4QI8B4H6fUAdYMXQBcyMc84ZNHdua2m1FcZkNbrLsmhEQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1733742013;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aH6pTnB0rbRFH1gBv6G1raAnKejJn3JBy/+AIl3WLTI=;
	b=TvzMVULfouSAqMtkiLhPwX6vokqeCXg2vhE/8Zp0DC05YuVa84e+ON81EIH0VyCjvMt0Vo
	CeRHmFv7O3+YM2CA==
From: "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/eevdf: More PELT vs DELAYED_DEQUEUE
Cc: "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 K Prateek Nayak <kprateek.nayak@amd.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20241202174606.4074512-3-vincent.guittot@linaro.org>
References: <20241202174606.4074512-3-vincent.guittot@linaro.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173374201245.412.3443551874172653327.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     76f2f783294d7d55c2564e2dfb0a7279ba0bc264
Gitweb:        https://git.kernel.org/tip/76f2f783294d7d55c2564e2dfb0a7279ba0bc264
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Mon, 02 Dec 2024 18:45:57 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 09 Dec 2024 11:48:09 +01:00

sched/eevdf: More PELT vs DELAYED_DEQUEUE

Vincent and Dietmar noted that while
commit fc1892becd56 ("sched/eevdf: Fixup PELT vs DELAYED_DEQUEUE") fixes
the entity runnable stats, it does not adjust the cfs_rq runnable stats,
which are based off of h_nr_running.

Track h_nr_delayed such that we can discount those and adjust the
signal.

Fixes: fc1892becd56 ("sched/eevdf: Fixup PELT vs DELAYED_DEQUEUE")
Closes: https://lore.kernel.org/lkml/a9a45193-d0c6-4ba2-a822-464ad30b550e@arm.com/
Closes: https://lore.kernel.org/lkml/CAKfTPtCNUvWE_GX5LyvTF-WdxUT=ZgvZZv-4t=eWntg5uOFqiQ@mail.gmail.com/
[ Fixes checkpatch warnings and rebased ]
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reported-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
Reported-by: Vincent Guittot <vincent.guittot@linaro.org>
Signed-off-by: "Peter Zijlstra (Intel)" <peterz@infradead.org>
Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
Tested-by: K Prateek Nayak <kprateek.nayak@amd.com>
Link: https://lore.kernel.org/r/20241202174606.4074512-3-vincent.guittot@linaro.org
---
 kernel/sched/debug.c |  1 +-
 kernel/sched/fair.c  | 51 ++++++++++++++++++++++++++++++++++++++-----
 kernel/sched/pelt.c  |  2 +-
 kernel/sched/sched.h |  8 +++++--
 4 files changed, 54 insertions(+), 8 deletions(-)

diff --git a/kernel/sched/debug.c b/kernel/sched/debug.c
index a48b2a7..a1be00a 100644
--- a/kernel/sched/debug.c
+++ b/kernel/sched/debug.c
@@ -845,6 +845,7 @@ void print_cfs_rq(struct seq_file *m, int cpu, struct cfs_rq *cfs_rq)
 	SEQ_printf(m, "  .%-30s: %Ld.%06ld\n", "spread", SPLIT_NS(spread));
 	SEQ_printf(m, "  .%-30s: %d\n", "nr_running", cfs_rq->nr_running);
 	SEQ_printf(m, "  .%-30s: %d\n", "h_nr_running", cfs_rq->h_nr_running);
+	SEQ_printf(m, "  .%-30s: %d\n", "h_nr_delayed", cfs_rq->h_nr_delayed);
 	SEQ_printf(m, "  .%-30s: %d\n", "idle_nr_running",
 			cfs_rq->idle_nr_running);
 	SEQ_printf(m, "  .%-30s: %d\n", "idle_h_nr_running",
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 9d7a2dd..97ee48c 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -5465,9 +5465,33 @@ static void clear_buddies(struct cfs_rq *cfs_rq, struct sched_entity *se)
 
 static __always_inline void return_cfs_rq_runtime(struct cfs_rq *cfs_rq);
 
-static inline void finish_delayed_dequeue_entity(struct sched_entity *se)
+static void set_delayed(struct sched_entity *se)
+{
+	se->sched_delayed = 1;
+	for_each_sched_entity(se) {
+		struct cfs_rq *cfs_rq = cfs_rq_of(se);
+
+		cfs_rq->h_nr_delayed++;
+		if (cfs_rq_throttled(cfs_rq))
+			break;
+	}
+}
+
+static void clear_delayed(struct sched_entity *se)
 {
 	se->sched_delayed = 0;
+	for_each_sched_entity(se) {
+		struct cfs_rq *cfs_rq = cfs_rq_of(se);
+
+		cfs_rq->h_nr_delayed--;
+		if (cfs_rq_throttled(cfs_rq))
+			break;
+	}
+}
+
+static inline void finish_delayed_dequeue_entity(struct sched_entity *se)
+{
+	clear_delayed(se);
 	if (sched_feat(DELAY_ZERO) && se->vlag > 0)
 		se->vlag = 0;
 }
@@ -5496,7 +5520,7 @@ dequeue_entity(struct cfs_rq *cfs_rq, struct sched_entity *se, int flags)
 		if (sched_feat(DELAY_DEQUEUE) && delay &&
 		    !entity_eligible(cfs_rq, se)) {
 			update_load_avg(cfs_rq, se, 0);
-			se->sched_delayed = 1;
+			set_delayed(se);
 			return false;
 		}
 	}
@@ -5908,7 +5932,7 @@ static bool throttle_cfs_rq(struct cfs_rq *cfs_rq)
 	struct rq *rq = rq_of(cfs_rq);
 	struct cfs_bandwidth *cfs_b = tg_cfs_bandwidth(cfs_rq->tg);
 	struct sched_entity *se;
-	long task_delta, idle_task_delta, dequeue = 1;
+	long task_delta, idle_task_delta, delayed_delta, dequeue = 1;
 	long rq_h_nr_running = rq->cfs.h_nr_running;
 
 	raw_spin_lock(&cfs_b->lock);
@@ -5941,6 +5965,7 @@ static bool throttle_cfs_rq(struct cfs_rq *cfs_rq)
 
 	task_delta = cfs_rq->h_nr_running;
 	idle_task_delta = cfs_rq->idle_h_nr_running;
+	delayed_delta = cfs_rq->h_nr_delayed;
 	for_each_sched_entity(se) {
 		struct cfs_rq *qcfs_rq = cfs_rq_of(se);
 		int flags;
@@ -5964,6 +5989,7 @@ static bool throttle_cfs_rq(struct cfs_rq *cfs_rq)
 
 		qcfs_rq->h_nr_running -= task_delta;
 		qcfs_rq->idle_h_nr_running -= idle_task_delta;
+		qcfs_rq->h_nr_delayed -= delayed_delta;
 
 		if (qcfs_rq->load.weight) {
 			/* Avoid re-evaluating load for this entity: */
@@ -5986,6 +6012,7 @@ static bool throttle_cfs_rq(struct cfs_rq *cfs_rq)
 
 		qcfs_rq->h_nr_running -= task_delta;
 		qcfs_rq->idle_h_nr_running -= idle_task_delta;
+		qcfs_rq->h_nr_delayed -= delayed_delta;
 	}
 
 	/* At this point se is NULL and we are at root level*/
@@ -6011,7 +6038,7 @@ void unthrottle_cfs_rq(struct cfs_rq *cfs_rq)
 	struct rq *rq = rq_of(cfs_rq);
 	struct cfs_bandwidth *cfs_b = tg_cfs_bandwidth(cfs_rq->tg);
 	struct sched_entity *se;
-	long task_delta, idle_task_delta;
+	long task_delta, idle_task_delta, delayed_delta;
 	long rq_h_nr_running = rq->cfs.h_nr_running;
 
 	se = cfs_rq->tg->se[cpu_of(rq)];
@@ -6047,6 +6074,7 @@ void unthrottle_cfs_rq(struct cfs_rq *cfs_rq)
 
 	task_delta = cfs_rq->h_nr_running;
 	idle_task_delta = cfs_rq->idle_h_nr_running;
+	delayed_delta = cfs_rq->h_nr_delayed;
 	for_each_sched_entity(se) {
 		struct cfs_rq *qcfs_rq = cfs_rq_of(se);
 
@@ -6064,6 +6092,7 @@ void unthrottle_cfs_rq(struct cfs_rq *cfs_rq)
 
 		qcfs_rq->h_nr_running += task_delta;
 		qcfs_rq->idle_h_nr_running += idle_task_delta;
+		qcfs_rq->h_nr_delayed += delayed_delta;
 
 		/* end evaluation on encountering a throttled cfs_rq */
 		if (cfs_rq_throttled(qcfs_rq))
@@ -6081,6 +6110,7 @@ void unthrottle_cfs_rq(struct cfs_rq *cfs_rq)
 
 		qcfs_rq->h_nr_running += task_delta;
 		qcfs_rq->idle_h_nr_running += idle_task_delta;
+		qcfs_rq->h_nr_delayed += delayed_delta;
 
 		/* end evaluation on encountering a throttled cfs_rq */
 		if (cfs_rq_throttled(qcfs_rq))
@@ -6934,7 +6964,7 @@ requeue_delayed_entity(struct sched_entity *se)
 	}
 
 	update_load_avg(cfs_rq, se, 0);
-	se->sched_delayed = 0;
+	clear_delayed(se);
 }
 
 /*
@@ -6948,6 +6978,7 @@ enqueue_task_fair(struct rq *rq, struct task_struct *p, int flags)
 	struct cfs_rq *cfs_rq;
 	struct sched_entity *se = &p->se;
 	int idle_h_nr_running = task_has_idle_policy(p);
+	int h_nr_delayed = 0;
 	int task_new = !(flags & ENQUEUE_WAKEUP);
 	int rq_h_nr_running = rq->cfs.h_nr_running;
 	u64 slice = 0;
@@ -6974,6 +7005,9 @@ enqueue_task_fair(struct rq *rq, struct task_struct *p, int flags)
 	if (p->in_iowait)
 		cpufreq_update_util(rq, SCHED_CPUFREQ_IOWAIT);
 
+	if (task_new)
+		h_nr_delayed = !!se->sched_delayed;
+
 	for_each_sched_entity(se) {
 		if (se->on_rq) {
 			if (se->sched_delayed)
@@ -6996,6 +7030,7 @@ enqueue_task_fair(struct rq *rq, struct task_struct *p, int flags)
 
 		cfs_rq->h_nr_running++;
 		cfs_rq->idle_h_nr_running += idle_h_nr_running;
+		cfs_rq->h_nr_delayed += h_nr_delayed;
 
 		if (cfs_rq_is_idle(cfs_rq))
 			idle_h_nr_running = 1;
@@ -7019,6 +7054,7 @@ enqueue_task_fair(struct rq *rq, struct task_struct *p, int flags)
 
 		cfs_rq->h_nr_running++;
 		cfs_rq->idle_h_nr_running += idle_h_nr_running;
+		cfs_rq->h_nr_delayed += h_nr_delayed;
 
 		if (cfs_rq_is_idle(cfs_rq))
 			idle_h_nr_running = 1;
@@ -7081,6 +7117,7 @@ static int dequeue_entities(struct rq *rq, struct sched_entity *se, int flags)
 	struct task_struct *p = NULL;
 	int idle_h_nr_running = 0;
 	int h_nr_running = 0;
+	int h_nr_delayed = 0;
 	struct cfs_rq *cfs_rq;
 	u64 slice = 0;
 
@@ -7088,6 +7125,8 @@ static int dequeue_entities(struct rq *rq, struct sched_entity *se, int flags)
 		p = task_of(se);
 		h_nr_running = 1;
 		idle_h_nr_running = task_has_idle_policy(p);
+		if (!task_sleep && !task_delayed)
+			h_nr_delayed = !!se->sched_delayed;
 	} else {
 		cfs_rq = group_cfs_rq(se);
 		slice = cfs_rq_min_slice(cfs_rq);
@@ -7105,6 +7144,7 @@ static int dequeue_entities(struct rq *rq, struct sched_entity *se, int flags)
 
 		cfs_rq->h_nr_running -= h_nr_running;
 		cfs_rq->idle_h_nr_running -= idle_h_nr_running;
+		cfs_rq->h_nr_delayed -= h_nr_delayed;
 
 		if (cfs_rq_is_idle(cfs_rq))
 			idle_h_nr_running = h_nr_running;
@@ -7143,6 +7183,7 @@ static int dequeue_entities(struct rq *rq, struct sched_entity *se, int flags)
 
 		cfs_rq->h_nr_running -= h_nr_running;
 		cfs_rq->idle_h_nr_running -= idle_h_nr_running;
+		cfs_rq->h_nr_delayed -= h_nr_delayed;
 
 		if (cfs_rq_is_idle(cfs_rq))
 			idle_h_nr_running = h_nr_running;
diff --git a/kernel/sched/pelt.c b/kernel/sched/pelt.c
index fc07382..fee75cc 100644
--- a/kernel/sched/pelt.c
+++ b/kernel/sched/pelt.c
@@ -321,7 +321,7 @@ int __update_load_avg_cfs_rq(u64 now, struct cfs_rq *cfs_rq)
 {
 	if (___update_load_sum(now, &cfs_rq->avg,
 				scale_load_down(cfs_rq->load.weight),
-				cfs_rq->h_nr_running,
+				cfs_rq->h_nr_running - cfs_rq->h_nr_delayed,
 				cfs_rq->curr != NULL)) {
 
 		___update_load_avg(&cfs_rq->avg, 1);
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 76f5f53..1e494af 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -649,6 +649,7 @@ struct cfs_rq {
 	unsigned int		h_nr_running;      /* SCHED_{NORMAL,BATCH,IDLE} */
 	unsigned int		idle_nr_running;   /* SCHED_IDLE */
 	unsigned int		idle_h_nr_running; /* SCHED_IDLE */
+	unsigned int		h_nr_delayed;
 
 	s64			avg_vruntime;
 	u64			avg_load;
@@ -898,8 +899,11 @@ struct dl_rq {
 
 static inline void se_update_runnable(struct sched_entity *se)
 {
-	if (!entity_is_task(se))
-		se->runnable_weight = se->my_q->h_nr_running;
+	if (!entity_is_task(se)) {
+		struct cfs_rq *cfs_rq = se->my_q;
+
+		se->runnable_weight = cfs_rq->h_nr_running - cfs_rq->h_nr_delayed;
+	}
 }
 
 static inline long se_runnable(struct sched_entity *se)

