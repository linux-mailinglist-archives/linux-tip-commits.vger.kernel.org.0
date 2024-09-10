Return-Path: <linux-tip-commits+bounces-2275-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6414E972BC2
	for <lists+linux-tip-commits@lfdr.de>; Tue, 10 Sep 2024 10:13:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C6B82B257D4
	for <lists+linux-tip-commits@lfdr.de>; Tue, 10 Sep 2024 08:13:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0C5D190666;
	Tue, 10 Sep 2024 08:09:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Y8Y2Xd74";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="t1c0iZmy"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C25D719005D;
	Tue, 10 Sep 2024 08:09:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725955773; cv=none; b=lX8ZjNG8J1dmKpXUcw9BgdfQsMevTbIOHD6jwSWcQVIb0SY2dlCmAMXlpFHWcyN8eHarwmikDkoW+qiZRMLyRGYS3iqCjJvpPlccETrZsbmTnX/DuOfhtqObn0bYzIWHqIDxk8kNo/YB9DkNeFEGr11+sMX8dSO+MgWJcfF5faE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725955773; c=relaxed/simple;
	bh=6IP4zbjLujschpwot9ad5eX9q9ZbDwj5sqL5bG6otfM=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=BXX9dlkQvFPcOXMMRvBx+u4S2G89HtvxVnQpEhD2bmmK5D9iksqYqB50cyl1ud2RFB/ZnBx8RqB6CiAubLlldkKpX7pYOduRzSNSOUaAm3AFy1dlhQRRRb6sRHOx6UhKIeMvsdmL9gB3nrg+6qXSUdZzFdJcwzEV43rmM+hyvLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Y8Y2Xd74; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=t1c0iZmy; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 10 Sep 2024 08:09:22 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1725955762;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dXYxH5Reg/qal7FMyBz1F1q0JStg4f9XT0+N/7lpolE=;
	b=Y8Y2Xd744GqJo0GAzeBuSRk88Rxu0D3cfa8pf+HooJXgNLS47DBK23LKp+ykv8FkjkghmA
	eZOZsEWI/x72BtfY1BeXUU/65zITT3qFUtO5Wz7SAJ6Ixqlzj9a9/X1eNsw/o85J3meap4
	Cy4dhmskYXnzc66kHV5gPQXSPyGT+FZQvJ1Y1pfYurFAyKXbRAx3AH5c1SorT0NcGPQjMp
	7oHfhZcI7Ca+KGh8yb10s0EjsP2lbeGH9yWqyc8AeR2bNrs9l+LM+xzlFonFrFS4Q641nO
	4xhnsRx5HEj7gtRNNdAtFJnd129OT8tuUkHboZ5rdkupbICSojt7qdRrWuuT+A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1725955762;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dXYxH5Reg/qal7FMyBz1F1q0JStg4f9XT0+N/7lpolE=;
	b=t1c0iZmyw2xzVfPJurFYQCpxCcvZOvEh/5VtCKg8EbGrc4YVOA9VwjVly5lz05Jw5jVu+q
	ekeIgbHPmllGq4DA==
From: "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/eevdf: More PELT vs DELAYED_DEQUEUE
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240906104525.GG4928@noisy.programming.kicks-ass.net>
References: <20240906104525.GG4928@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172595576232.2215.18027704125134691219.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     2e05f6c71d36f8ae1410a1cf3f12848cc17916e9
Gitweb:        https://git.kernel.org/tip/2e05f6c71d36f8ae1410a1cf3f12848cc17916e9
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Fri, 06 Sep 2024 12:45:25 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 10 Sep 2024 09:51:15 +02:00

sched/eevdf: More PELT vs DELAYED_DEQUEUE

Vincent and Dietmar noted that while commit fc1892becd56 fixes the
entity runnable stats, it does not adjust the cfs_rq runnable stats,
which are based off of h_nr_running.

Track h_nr_delayed such that we can discount those and adjust the
signal.

Fixes: fc1892becd56 ("sched/eevdf: Fixup PELT vs DELAYED_DEQUEUE")
Reported-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
Reported-by: Vincent Guittot <vincent.guittot@linaro.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20240906104525.GG4928@noisy.programming.kicks-ass.net
---
 kernel/sched/debug.c |  1 +-
 kernel/sched/fair.c  | 49 ++++++++++++++++++++++++++++++++++++++-----
 kernel/sched/pelt.c  |  2 +-
 kernel/sched/sched.h |  7 ++++--
 4 files changed, 51 insertions(+), 8 deletions(-)

diff --git a/kernel/sched/debug.c b/kernel/sched/debug.c
index de1dc52..35974ac 100644
--- a/kernel/sched/debug.c
+++ b/kernel/sched/debug.c
@@ -844,6 +844,7 @@ void print_cfs_rq(struct seq_file *m, int cpu, struct cfs_rq *cfs_rq)
 	SEQ_printf(m, "  .%-30s: %Ld.%06ld\n", "spread", SPLIT_NS(spread));
 	SEQ_printf(m, "  .%-30s: %d\n", "nr_running", cfs_rq->nr_running);
 	SEQ_printf(m, "  .%-30s: %d\n", "h_nr_running", cfs_rq->h_nr_running);
+	SEQ_printf(m, "  .%-30s: %d\n", "h_nr_delayed", cfs_rq->h_nr_delayed);
 	SEQ_printf(m, "  .%-30s: %d\n", "idle_nr_running",
 			cfs_rq->idle_nr_running);
 	SEQ_printf(m, "  .%-30s: %d\n", "idle_h_nr_running",
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 922d690..0bc5e62 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -5456,9 +5456,31 @@ static void clear_buddies(struct cfs_rq *cfs_rq, struct sched_entity *se)
 
 static __always_inline void return_cfs_rq_runtime(struct cfs_rq *cfs_rq);
 
-static inline void finish_delayed_dequeue_entity(struct sched_entity *se)
+static void set_delayed(struct sched_entity *se)
+{
+	se->sched_delayed = 1;
+	for_each_sched_entity(se) {
+		struct cfs_rq *cfs_rq = cfs_rq_of(se);
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
@@ -5488,7 +5510,7 @@ dequeue_entity(struct cfs_rq *cfs_rq, struct sched_entity *se, int flags)
 			if (cfs_rq->next == se)
 				cfs_rq->next = NULL;
 			update_load_avg(cfs_rq, se, 0);
-			se->sched_delayed = 1;
+			set_delayed(se);
 			return false;
 		}
 	}
@@ -5907,7 +5929,7 @@ static bool throttle_cfs_rq(struct cfs_rq *cfs_rq)
 	struct rq *rq = rq_of(cfs_rq);
 	struct cfs_bandwidth *cfs_b = tg_cfs_bandwidth(cfs_rq->tg);
 	struct sched_entity *se;
-	long task_delta, idle_task_delta, dequeue = 1;
+	long task_delta, idle_task_delta, delayed_delta, dequeue = 1;
 	long rq_h_nr_running = rq->cfs.h_nr_running;
 
 	raw_spin_lock(&cfs_b->lock);
@@ -5940,6 +5962,7 @@ static bool throttle_cfs_rq(struct cfs_rq *cfs_rq)
 
 	task_delta = cfs_rq->h_nr_running;
 	idle_task_delta = cfs_rq->idle_h_nr_running;
+	delayed_delta = cfs_rq->h_nr_delayed;
 	for_each_sched_entity(se) {
 		struct cfs_rq *qcfs_rq = cfs_rq_of(se);
 		int flags;
@@ -5963,6 +5986,7 @@ static bool throttle_cfs_rq(struct cfs_rq *cfs_rq)
 
 		qcfs_rq->h_nr_running -= task_delta;
 		qcfs_rq->idle_h_nr_running -= idle_task_delta;
+		qcfs_rq->h_nr_delayed -= delayed_delta;
 
 		if (qcfs_rq->load.weight) {
 			/* Avoid re-evaluating load for this entity: */
@@ -5985,6 +6009,7 @@ static bool throttle_cfs_rq(struct cfs_rq *cfs_rq)
 
 		qcfs_rq->h_nr_running -= task_delta;
 		qcfs_rq->idle_h_nr_running -= idle_task_delta;
+		qcfs_rq->h_nr_delayed -= delayed_delta;
 	}
 
 	/* At this point se is NULL and we are at root level*/
@@ -6010,7 +6035,7 @@ void unthrottle_cfs_rq(struct cfs_rq *cfs_rq)
 	struct rq *rq = rq_of(cfs_rq);
 	struct cfs_bandwidth *cfs_b = tg_cfs_bandwidth(cfs_rq->tg);
 	struct sched_entity *se;
-	long task_delta, idle_task_delta;
+	long task_delta, idle_task_delta, delayed_delta;
 	long rq_h_nr_running = rq->cfs.h_nr_running;
 
 	se = cfs_rq->tg->se[cpu_of(rq)];
@@ -6046,6 +6071,7 @@ void unthrottle_cfs_rq(struct cfs_rq *cfs_rq)
 
 	task_delta = cfs_rq->h_nr_running;
 	idle_task_delta = cfs_rq->idle_h_nr_running;
+	delayed_delta = cfs_rq->h_nr_delayed;
 	for_each_sched_entity(se) {
 		struct cfs_rq *qcfs_rq = cfs_rq_of(se);
 
@@ -6060,6 +6086,7 @@ void unthrottle_cfs_rq(struct cfs_rq *cfs_rq)
 
 		qcfs_rq->h_nr_running += task_delta;
 		qcfs_rq->idle_h_nr_running += idle_task_delta;
+		qcfs_rq->h_nr_delayed += delayed_delta;
 
 		/* end evaluation on encountering a throttled cfs_rq */
 		if (cfs_rq_throttled(qcfs_rq))
@@ -6077,6 +6104,7 @@ void unthrottle_cfs_rq(struct cfs_rq *cfs_rq)
 
 		qcfs_rq->h_nr_running += task_delta;
 		qcfs_rq->idle_h_nr_running += idle_task_delta;
+		qcfs_rq->h_nr_delayed += delayed_delta;
 
 		/* end evaluation on encountering a throttled cfs_rq */
 		if (cfs_rq_throttled(qcfs_rq))
@@ -6930,7 +6958,7 @@ requeue_delayed_entity(struct sched_entity *se)
 	}
 
 	update_load_avg(cfs_rq, se, 0);
-	se->sched_delayed = 0;
+	clear_delayed(se);
 }
 
 /*
@@ -6944,6 +6972,7 @@ enqueue_task_fair(struct rq *rq, struct task_struct *p, int flags)
 	struct cfs_rq *cfs_rq;
 	struct sched_entity *se = &p->se;
 	int idle_h_nr_running = task_has_idle_policy(p);
+	int h_nr_delayed = 0;
 	int task_new = !(flags & ENQUEUE_WAKEUP);
 	int rq_h_nr_running = rq->cfs.h_nr_running;
 	u64 slice = 0;
@@ -6970,6 +6999,9 @@ enqueue_task_fair(struct rq *rq, struct task_struct *p, int flags)
 	if (p->in_iowait)
 		cpufreq_update_util(rq, SCHED_CPUFREQ_IOWAIT);
 
+	if (task_new)
+		h_nr_delayed = !!se->sched_delayed;
+
 	for_each_sched_entity(se) {
 		if (se->on_rq) {
 			if (se->sched_delayed)
@@ -6992,6 +7024,7 @@ enqueue_task_fair(struct rq *rq, struct task_struct *p, int flags)
 
 		cfs_rq->h_nr_running++;
 		cfs_rq->idle_h_nr_running += idle_h_nr_running;
+		cfs_rq->h_nr_delayed += h_nr_delayed;
 
 		if (cfs_rq_is_idle(cfs_rq))
 			idle_h_nr_running = 1;
@@ -7015,6 +7048,7 @@ enqueue_task_fair(struct rq *rq, struct task_struct *p, int flags)
 
 		cfs_rq->h_nr_running++;
 		cfs_rq->idle_h_nr_running += idle_h_nr_running;
+		cfs_rq->h_nr_delayed += h_nr_delayed;
 
 		if (cfs_rq_is_idle(cfs_rq))
 			idle_h_nr_running = 1;
@@ -7077,6 +7111,7 @@ static int dequeue_entities(struct rq *rq, struct sched_entity *se, int flags)
 	struct task_struct *p = NULL;
 	int idle_h_nr_running = 0;
 	int h_nr_running = 0;
+	int h_nr_delayed = 0;
 	struct cfs_rq *cfs_rq;
 	u64 slice = 0;
 
@@ -7084,6 +7119,8 @@ static int dequeue_entities(struct rq *rq, struct sched_entity *se, int flags)
 		p = task_of(se);
 		h_nr_running = 1;
 		idle_h_nr_running = task_has_idle_policy(p);
+		if (!task_sleep && !task_delayed)
+			h_nr_delayed = !!se->sched_delayed;
 	} else {
 		cfs_rq = group_cfs_rq(se);
 		slice = cfs_rq_min_slice(cfs_rq);
@@ -7101,6 +7138,7 @@ static int dequeue_entities(struct rq *rq, struct sched_entity *se, int flags)
 
 		cfs_rq->h_nr_running -= h_nr_running;
 		cfs_rq->idle_h_nr_running -= idle_h_nr_running;
+		cfs_rq->h_nr_delayed -= h_nr_delayed;
 
 		if (cfs_rq_is_idle(cfs_rq))
 			idle_h_nr_running = h_nr_running;
@@ -7139,6 +7177,7 @@ static int dequeue_entities(struct rq *rq, struct sched_entity *se, int flags)
 
 		cfs_rq->h_nr_running -= h_nr_running;
 		cfs_rq->idle_h_nr_running -= idle_h_nr_running;
+		cfs_rq->h_nr_delayed -= h_nr_delayed;
 
 		if (cfs_rq_is_idle(cfs_rq))
 			idle_h_nr_running = h_nr_running;
diff --git a/kernel/sched/pelt.c b/kernel/sched/pelt.c
index fa52906..21e3ff5 100644
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
index 3744f16..d91360b 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -603,6 +603,7 @@ struct cfs_rq {
 	unsigned int		h_nr_running;      /* SCHED_{NORMAL,BATCH,IDLE} */
 	unsigned int		idle_nr_running;   /* SCHED_IDLE */
 	unsigned int		idle_h_nr_running; /* SCHED_IDLE */
+	unsigned int		h_nr_delayed;
 
 	s64			avg_vruntime;
 	u64			avg_load;
@@ -813,8 +814,10 @@ struct dl_rq {
 
 static inline void se_update_runnable(struct sched_entity *se)
 {
-	if (!entity_is_task(se))
-		se->runnable_weight = se->my_q->h_nr_running;
+	if (!entity_is_task(se)) {
+		struct cfs_rq *cfs_rq = se->my_q;
+		se->runnable_weight = cfs_rq->h_nr_running - cfs_rq->h_nr_delayed;
+	}
 }
 
 static inline long se_runnable(struct sched_entity *se)

