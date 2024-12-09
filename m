Return-Path: <linux-tip-commits+bounces-3032-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E66E49E912C
	for <lists+linux-tip-commits@lfdr.de>; Mon,  9 Dec 2024 12:01:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A82E0163D12
	for <lists+linux-tip-commits@lfdr.de>; Mon,  9 Dec 2024 11:00:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAA63219A7B;
	Mon,  9 Dec 2024 11:00:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="nFss8nsB";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="N/g2On1d"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97E74218590;
	Mon,  9 Dec 2024 11:00:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733742011; cv=none; b=C47ozg6Vm1iPTCadGUZLC3Ba3IAJQPfSwj5nbuuKDAQ6shtJ1R1VIWr7l810ou/+A8md+HprDqXuWQzxn2FBAQZ6nOng+aUUPr+W0nZEDbM2rLa6mevTXrX96uRrfQ3bduewPxKc4WE1SPVtDyqwJcYthz4RKYQOMTLocktiWyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733742011; c=relaxed/simple;
	bh=yTpCQu2dg8pR1Jbrms8uvkLzhrJfZPwdeJUaiQPbOFM=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=ljRWMX5a6ZvaPzk0JuVSt5XAfPR2UOGTJSrd+yKX5rGon+oBTQMozFQAsI5t8o1ozQH05++Y9vvaetlMPYW4JAX/BS97zT8g9Ug+x6pCftiTQC4GBogyk0rMhbd73cuXs0ylF9zA3AWDBNLurwW3zc3TUsr56AbRgb9F2tMMNw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=nFss8nsB; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=N/g2On1d; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 09 Dec 2024 11:00:07 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1733742008;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QtkNFB1uEGTJqz70ZIykm62oMljk3Hl9JDoF3JibIgU=;
	b=nFss8nsBJ+HndBddTDU4/0Tj+r35aMImgqwbxfnm10SzfykVOyCZR0arSWcgKBR30hKcXN
	teQkWIqFJ6J8vJBfYnoWXI/+N5wKKNvLAlVIzMcT57ZCNPuclC3a40XO3bjAwFP9FxrsEC
	DUWzpEZi8PzImz51bfrS1MSRYp8iZWm/ZUOTXWP6u/VkrwSXsGVUeI7i7DDzSxBj6/nJu1
	fhUfcJaxefGpQya55+kFpViElLTv8tBSwKOLwC54BUyDI93P6F0t4PoAftO2PxtLUrfqxq
	RqxaGw8PSlIgrM2LEHeKD3DXH64kppXzc3J7odMbFeGmqcOuSdo0A01cs/NBQg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1733742008;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QtkNFB1uEGTJqz70ZIykm62oMljk3Hl9JDoF3JibIgU=;
	b=N/g2On1d/gGjKzRAyBIwnzUO0gItFm08T3OFftRXaEGJ05etU8qaTWr7TRmgtabu4QJ79f
	GEr94j0pihcXHcAg==
From: "tip-bot2 for Vincent Guittot" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: sched/core] sched/fair: Rename cfs_rq.idle_h_nr_running into h_nr_idle
Cc: Vincent Guittot <vincent.guittot@linaro.org>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20241202174606.4074512-8-vincent.guittot@linaro.org>
References: <20241202174606.4074512-8-vincent.guittot@linaro.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173374200708.412.3058794797794890476.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     31898e7b87dd2833eb5dd6aa60ab2a5880c4c12f
Gitweb:        https://git.kernel.org/tip/31898e7b87dd2833eb5dd6aa60ab2a5880c4c12f
Author:        Vincent Guittot <vincent.guittot@linaro.org>
AuthorDate:    Mon, 02 Dec 2024 18:46:02 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 09 Dec 2024 11:48:12 +01:00

sched/fair: Rename cfs_rq.idle_h_nr_running into h_nr_idle

Use same naming convention as others starting with h_nr_* and rename
idle_h_nr_running into h_nr_idle.
The "running" is not correct anymore as it includes delayed dequeue tasks
as well.

Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
Link: https://lore.kernel.org/r/20241202174606.4074512-8-vincent.guittot@linaro.org
---
 kernel/sched/debug.c |  3 +--
 kernel/sched/fair.c  | 52 +++++++++++++++++++++----------------------
 kernel/sched/sched.h |  2 +-
 3 files changed, 28 insertions(+), 29 deletions(-)

diff --git a/kernel/sched/debug.c b/kernel/sched/debug.c
index 56be365..e21b66b 100644
--- a/kernel/sched/debug.c
+++ b/kernel/sched/debug.c
@@ -848,8 +848,7 @@ void print_cfs_rq(struct seq_file *m, int cpu, struct cfs_rq *cfs_rq)
 	SEQ_printf(m, "  .%-30s: %d\n", "h_nr_queued", cfs_rq->h_nr_queued);
 	SEQ_printf(m, "  .%-30s: %d\n", "idle_nr_running",
 			cfs_rq->idle_nr_running);
-	SEQ_printf(m, "  .%-30s: %d\n", "idle_h_nr_running",
-			cfs_rq->idle_h_nr_running);
+	SEQ_printf(m, "  .%-30s: %d\n", "h_nr_idle", cfs_rq->h_nr_idle);
 	SEQ_printf(m, "  .%-30s: %ld\n", "load", cfs_rq->load.weight);
 #ifdef CONFIG_SMP
 	SEQ_printf(m, "  .%-30s: %lu\n", "load_avg",
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 5c2f049..2ef3378 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -5930,7 +5930,7 @@ static bool throttle_cfs_rq(struct cfs_rq *cfs_rq)
 	struct rq *rq = rq_of(cfs_rq);
 	struct cfs_bandwidth *cfs_b = tg_cfs_bandwidth(cfs_rq->tg);
 	struct sched_entity *se;
-	long queued_delta, runnable_delta, idle_task_delta, dequeue = 1;
+	long queued_delta, runnable_delta, idle_delta, dequeue = 1;
 	long rq_h_nr_queued = rq->cfs.h_nr_queued;
 
 	raw_spin_lock(&cfs_b->lock);
@@ -5963,7 +5963,7 @@ static bool throttle_cfs_rq(struct cfs_rq *cfs_rq)
 
 	queued_delta = cfs_rq->h_nr_queued;
 	runnable_delta = cfs_rq->h_nr_runnable;
-	idle_task_delta = cfs_rq->idle_h_nr_running;
+	idle_delta = cfs_rq->h_nr_idle;
 	for_each_sched_entity(se) {
 		struct cfs_rq *qcfs_rq = cfs_rq_of(se);
 		int flags;
@@ -5983,11 +5983,11 @@ static bool throttle_cfs_rq(struct cfs_rq *cfs_rq)
 		dequeue_entity(qcfs_rq, se, flags);
 
 		if (cfs_rq_is_idle(group_cfs_rq(se)))
-			idle_task_delta = cfs_rq->h_nr_queued;
+			idle_delta = cfs_rq->h_nr_queued;
 
 		qcfs_rq->h_nr_queued -= queued_delta;
 		qcfs_rq->h_nr_runnable -= runnable_delta;
-		qcfs_rq->idle_h_nr_running -= idle_task_delta;
+		qcfs_rq->h_nr_idle -= idle_delta;
 
 		if (qcfs_rq->load.weight) {
 			/* Avoid re-evaluating load for this entity: */
@@ -6006,11 +6006,11 @@ static bool throttle_cfs_rq(struct cfs_rq *cfs_rq)
 		se_update_runnable(se);
 
 		if (cfs_rq_is_idle(group_cfs_rq(se)))
-			idle_task_delta = cfs_rq->h_nr_queued;
+			idle_delta = cfs_rq->h_nr_queued;
 
 		qcfs_rq->h_nr_queued -= queued_delta;
 		qcfs_rq->h_nr_runnable -= runnable_delta;
-		qcfs_rq->idle_h_nr_running -= idle_task_delta;
+		qcfs_rq->h_nr_idle -= idle_delta;
 	}
 
 	/* At this point se is NULL and we are at root level*/
@@ -6036,7 +6036,7 @@ void unthrottle_cfs_rq(struct cfs_rq *cfs_rq)
 	struct rq *rq = rq_of(cfs_rq);
 	struct cfs_bandwidth *cfs_b = tg_cfs_bandwidth(cfs_rq->tg);
 	struct sched_entity *se;
-	long queued_delta, runnable_delta, idle_task_delta;
+	long queued_delta, runnable_delta, idle_delta;
 	long rq_h_nr_queued = rq->cfs.h_nr_queued;
 
 	se = cfs_rq->tg->se[cpu_of(rq)];
@@ -6072,7 +6072,7 @@ void unthrottle_cfs_rq(struct cfs_rq *cfs_rq)
 
 	queued_delta = cfs_rq->h_nr_queued;
 	runnable_delta = cfs_rq->h_nr_runnable;
-	idle_task_delta = cfs_rq->idle_h_nr_running;
+	idle_delta = cfs_rq->h_nr_idle;
 	for_each_sched_entity(se) {
 		struct cfs_rq *qcfs_rq = cfs_rq_of(se);
 
@@ -6086,11 +6086,11 @@ void unthrottle_cfs_rq(struct cfs_rq *cfs_rq)
 		enqueue_entity(qcfs_rq, se, ENQUEUE_WAKEUP);
 
 		if (cfs_rq_is_idle(group_cfs_rq(se)))
-			idle_task_delta = cfs_rq->h_nr_queued;
+			idle_delta = cfs_rq->h_nr_queued;
 
 		qcfs_rq->h_nr_queued += queued_delta;
 		qcfs_rq->h_nr_runnable += runnable_delta;
-		qcfs_rq->idle_h_nr_running += idle_task_delta;
+		qcfs_rq->h_nr_idle += idle_delta;
 
 		/* end evaluation on encountering a throttled cfs_rq */
 		if (cfs_rq_throttled(qcfs_rq))
@@ -6104,11 +6104,11 @@ void unthrottle_cfs_rq(struct cfs_rq *cfs_rq)
 		se_update_runnable(se);
 
 		if (cfs_rq_is_idle(group_cfs_rq(se)))
-			idle_task_delta = cfs_rq->h_nr_queued;
+			idle_delta = cfs_rq->h_nr_queued;
 
 		qcfs_rq->h_nr_queued += queued_delta;
 		qcfs_rq->h_nr_runnable += runnable_delta;
-		qcfs_rq->idle_h_nr_running += idle_task_delta;
+		qcfs_rq->h_nr_idle += idle_delta;
 
 		/* end evaluation on encountering a throttled cfs_rq */
 		if (cfs_rq_throttled(qcfs_rq))
@@ -6918,7 +6918,7 @@ static inline void check_update_overutilized_status(struct rq *rq) { }
 /* Runqueue only has SCHED_IDLE tasks enqueued */
 static int sched_idle_rq(struct rq *rq)
 {
-	return unlikely(rq->nr_running == rq->cfs.idle_h_nr_running &&
+	return unlikely(rq->nr_running == rq->cfs.h_nr_idle &&
 			rq->nr_running);
 }
 
@@ -6970,7 +6970,7 @@ enqueue_task_fair(struct rq *rq, struct task_struct *p, int flags)
 {
 	struct cfs_rq *cfs_rq;
 	struct sched_entity *se = &p->se;
-	int idle_h_nr_running = task_has_idle_policy(p);
+	int h_nr_idle = task_has_idle_policy(p);
 	int h_nr_runnable = 1;
 	int task_new = !(flags & ENQUEUE_WAKEUP);
 	int rq_h_nr_queued = rq->cfs.h_nr_queued;
@@ -7023,10 +7023,10 @@ enqueue_task_fair(struct rq *rq, struct task_struct *p, int flags)
 
 		cfs_rq->h_nr_runnable += h_nr_runnable;
 		cfs_rq->h_nr_queued++;
-		cfs_rq->idle_h_nr_running += idle_h_nr_running;
+		cfs_rq->h_nr_idle += h_nr_idle;
 
 		if (cfs_rq_is_idle(cfs_rq))
-			idle_h_nr_running = 1;
+			h_nr_idle = 1;
 
 		/* end evaluation on encountering a throttled cfs_rq */
 		if (cfs_rq_throttled(cfs_rq))
@@ -7047,10 +7047,10 @@ enqueue_task_fair(struct rq *rq, struct task_struct *p, int flags)
 
 		cfs_rq->h_nr_runnable += h_nr_runnable;
 		cfs_rq->h_nr_queued++;
-		cfs_rq->idle_h_nr_running += idle_h_nr_running;
+		cfs_rq->h_nr_idle += h_nr_idle;
 
 		if (cfs_rq_is_idle(cfs_rq))
-			idle_h_nr_running = 1;
+			h_nr_idle = 1;
 
 		/* end evaluation on encountering a throttled cfs_rq */
 		if (cfs_rq_throttled(cfs_rq))
@@ -7108,7 +7108,7 @@ static int dequeue_entities(struct rq *rq, struct sched_entity *se, int flags)
 	bool task_sleep = flags & DEQUEUE_SLEEP;
 	bool task_delayed = flags & DEQUEUE_DELAYED;
 	struct task_struct *p = NULL;
-	int idle_h_nr_running = 0;
+	int h_nr_idle = 0;
 	int h_nr_queued = 0;
 	int h_nr_runnable = 0;
 	struct cfs_rq *cfs_rq;
@@ -7117,7 +7117,7 @@ static int dequeue_entities(struct rq *rq, struct sched_entity *se, int flags)
 	if (entity_is_task(se)) {
 		p = task_of(se);
 		h_nr_queued = 1;
-		idle_h_nr_running = task_has_idle_policy(p);
+		h_nr_idle = task_has_idle_policy(p);
 		if (task_sleep || task_delayed || !se->sched_delayed)
 			h_nr_runnable = 1;
 	} else {
@@ -7137,10 +7137,10 @@ static int dequeue_entities(struct rq *rq, struct sched_entity *se, int flags)
 
 		cfs_rq->h_nr_runnable -= h_nr_runnable;
 		cfs_rq->h_nr_queued -= h_nr_queued;
-		cfs_rq->idle_h_nr_running -= idle_h_nr_running;
+		cfs_rq->h_nr_idle -= h_nr_idle;
 
 		if (cfs_rq_is_idle(cfs_rq))
-			idle_h_nr_running = h_nr_queued;
+			h_nr_idle = h_nr_queued;
 
 		/* end evaluation on encountering a throttled cfs_rq */
 		if (cfs_rq_throttled(cfs_rq))
@@ -7176,10 +7176,10 @@ static int dequeue_entities(struct rq *rq, struct sched_entity *se, int flags)
 
 		cfs_rq->h_nr_runnable -= h_nr_runnable;
 		cfs_rq->h_nr_queued -= h_nr_queued;
-		cfs_rq->idle_h_nr_running -= idle_h_nr_running;
+		cfs_rq->h_nr_idle -= h_nr_idle;
 
 		if (cfs_rq_is_idle(cfs_rq))
-			idle_h_nr_running = h_nr_queued;
+			h_nr_idle = h_nr_queued;
 
 		/* end evaluation on encountering a throttled cfs_rq */
 		if (cfs_rq_throttled(cfs_rq))
@@ -13527,7 +13527,7 @@ int sched_group_set_idle(struct task_group *tg, long idle)
 		}
 
 		idle_task_delta = grp_cfs_rq->h_nr_queued -
-				  grp_cfs_rq->idle_h_nr_running;
+				  grp_cfs_rq->h_nr_idle;
 		if (!cfs_rq_is_idle(grp_cfs_rq))
 			idle_task_delta *= -1;
 
@@ -13537,7 +13537,7 @@ int sched_group_set_idle(struct task_group *tg, long idle)
 			if (!se->on_rq)
 				break;
 
-			cfs_rq->idle_h_nr_running += idle_task_delta;
+			cfs_rq->h_nr_idle += idle_task_delta;
 
 			/* Already accounted at parent level and above. */
 			if (cfs_rq_is_idle(cfs_rq))
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index d3ce5e9..afe5cb9 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -649,7 +649,7 @@ struct cfs_rq {
 	unsigned int		h_nr_queued;       /* SCHED_{NORMAL,BATCH,IDLE} */
 	unsigned int		h_nr_runnable;     /* SCHED_{NORMAL,BATCH,IDLE} */
 	unsigned int		idle_nr_running;   /* SCHED_IDLE */
-	unsigned int		idle_h_nr_running; /* SCHED_IDLE */
+	unsigned int		h_nr_idle; /* SCHED_IDLE */
 
 	s64			avg_vruntime;
 	u64			avg_load;

