Return-Path: <linux-tip-commits+bounces-3035-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 67F6F9E9132
	for <lists+linux-tip-commits@lfdr.de>; Mon,  9 Dec 2024 12:01:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5A3781886ED0
	for <lists+linux-tip-commits@lfdr.de>; Mon,  9 Dec 2024 11:01:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13D0B217F35;
	Mon,  9 Dec 2024 11:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="fe/6rLl2";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="t6nQQUYH"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8691219E91;
	Mon,  9 Dec 2024 11:00:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733742015; cv=none; b=JrwCaM5TzkX6FMLDrgj52MWvf6AwE8G4b5HrH1KcdgFmV7Iox+4xFyYiPvW9f8yWsSVqXVCwtG5jtAY4OdejoVrmtukFyDzpACwksr1+8/2wt0EtAagaJZpDXY67c/QdSyF/qfzzCYDdKbfyNKgN+aNdKmybwshYlOJ87BjTKU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733742015; c=relaxed/simple;
	bh=nE1l4t+tWL/tm5uljs5v43cqNLUK+2YJe5qzTVgaQR8=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=potPMyE8w/ihReDTtswF5KDa+Mk6U19ro7FY1kytto0KgJLdpGU40UJT/aaaODC3hO00mSho53nQEpNkZSnhgn84yW2fxixtKZzcQ6EPzOICCVhaXOZaTX2VdAcQt3+3yf2xi7Wbqcd/n4ofg9ey21Pl3OhheVXrL4LbccFiNU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=fe/6rLl2; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=t6nQQUYH; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 09 Dec 2024 11:00:10 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1733742011;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NBEponRWmAHt9G/L/HVAZlNVEE6RLAw+AKGet45EMHM=;
	b=fe/6rLl2RNee7Jo0B9F1UJvDMgOrmDSp2n82nRf5KJVuDQRYYli7UDQGxwhaFBpKDUcQ/Y
	L8E6qYyisZriOKU4HtoIHiROvz/bSqZuvmz8NPkHqOuHUebcm0l/wXAZbR+Oaa1p3Xeawt
	5j1zD+A7ARe43B4ukyDvK/Ri94YYTwZE7m7634kmxET1g67PFv5mfH49fcmxEjnu/NOfjC
	XeXlYINsr0lZ6fNNw7EPfqguT3sjh8leys/laN8wLS4VA1xeoF9305lhcu8dXSSL3UewOW
	zHZ3k8lMM3wbaGiBOl3jnSaDblqsoWD25qv028x3hqRfNyf3cTS8sS3Wa9miNQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1733742011;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NBEponRWmAHt9G/L/HVAZlNVEE6RLAw+AKGet45EMHM=;
	b=t6nQQUYHnP4OQNkQkMdYkwcdbuxsQmp+onf671qv/iKz4uq5+dr8E3pMG8C0OCF7rLDXqg
	sHxD1SwoY8/cjSAg==
From: "tip-bot2 for Vincent Guittot" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/fair: Add new cfs_rq.h_nr_runnable
Cc: Vincent Guittot <vincent.guittot@linaro.org>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20241202174606.4074512-5-vincent.guittot@linaro.org>
References: <20241202174606.4074512-5-vincent.guittot@linaro.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173374201019.412.6096280015269912802.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     c2a295bffeaf9461ecba76dc9e4780c898c94f03
Gitweb:        https://git.kernel.org/tip/c2a295bffeaf9461ecba76dc9e4780c898c94f03
Author:        Vincent Guittot <vincent.guittot@linaro.org>
AuthorDate:    Mon, 02 Dec 2024 18:45:59 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 09 Dec 2024 11:48:11 +01:00

sched/fair: Add new cfs_rq.h_nr_runnable

With delayed dequeued feature, a sleeping sched_entity remains queued in
the rq until its lag has elapsed. As a result, it stays also visible
in the statistics that are used to balance the system and in particular
the field cfs.h_nr_queued when the sched_entity is associated to a task.

Create a new h_nr_runnable that tracks only queued and runnable tasks.

Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
Link: https://lore.kernel.org/r/20241202174606.4074512-5-vincent.guittot@linaro.org
---
 kernel/sched/debug.c |  1 +
 kernel/sched/fair.c  | 20 ++++++++++++++++++--
 kernel/sched/sched.h |  1 +
 3 files changed, 20 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/debug.c b/kernel/sched/debug.c
index 08d6c2b..fd711cc 100644
--- a/kernel/sched/debug.c
+++ b/kernel/sched/debug.c
@@ -844,6 +844,7 @@ void print_cfs_rq(struct seq_file *m, int cpu, struct cfs_rq *cfs_rq)
 	spread = right_vruntime - left_vruntime;
 	SEQ_printf(m, "  .%-30s: %Ld.%06ld\n", "spread", SPLIT_NS(spread));
 	SEQ_printf(m, "  .%-30s: %d\n", "nr_running", cfs_rq->nr_running);
+	SEQ_printf(m, "  .%-30s: %d\n", "h_nr_runnable", cfs_rq->h_nr_runnable);
 	SEQ_printf(m, "  .%-30s: %d\n", "h_nr_queued", cfs_rq->h_nr_queued);
 	SEQ_printf(m, "  .%-30s: %d\n", "h_nr_delayed", cfs_rq->h_nr_delayed);
 	SEQ_printf(m, "  .%-30s: %d\n", "idle_nr_running",
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index d6a9447..ed01e72 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -5469,6 +5469,7 @@ static void set_delayed(struct sched_entity *se)
 	for_each_sched_entity(se) {
 		struct cfs_rq *cfs_rq = cfs_rq_of(se);
 
+		cfs_rq->h_nr_runnable--;
 		cfs_rq->h_nr_delayed++;
 		if (cfs_rq_throttled(cfs_rq))
 			break;
@@ -5481,6 +5482,7 @@ static void clear_delayed(struct sched_entity *se)
 	for_each_sched_entity(se) {
 		struct cfs_rq *cfs_rq = cfs_rq_of(se);
 
+		cfs_rq->h_nr_runnable++;
 		cfs_rq->h_nr_delayed--;
 		if (cfs_rq_throttled(cfs_rq))
 			break;
@@ -5930,7 +5932,7 @@ static bool throttle_cfs_rq(struct cfs_rq *cfs_rq)
 	struct rq *rq = rq_of(cfs_rq);
 	struct cfs_bandwidth *cfs_b = tg_cfs_bandwidth(cfs_rq->tg);
 	struct sched_entity *se;
-	long queued_delta, idle_task_delta, delayed_delta, dequeue = 1;
+	long queued_delta, runnable_delta, idle_task_delta, delayed_delta, dequeue = 1;
 	long rq_h_nr_queued = rq->cfs.h_nr_queued;
 
 	raw_spin_lock(&cfs_b->lock);
@@ -5962,6 +5964,7 @@ static bool throttle_cfs_rq(struct cfs_rq *cfs_rq)
 	rcu_read_unlock();
 
 	queued_delta = cfs_rq->h_nr_queued;
+	runnable_delta = cfs_rq->h_nr_runnable;
 	idle_task_delta = cfs_rq->idle_h_nr_running;
 	delayed_delta = cfs_rq->h_nr_delayed;
 	for_each_sched_entity(se) {
@@ -5986,6 +5989,7 @@ static bool throttle_cfs_rq(struct cfs_rq *cfs_rq)
 			idle_task_delta = cfs_rq->h_nr_queued;
 
 		qcfs_rq->h_nr_queued -= queued_delta;
+		qcfs_rq->h_nr_runnable -= runnable_delta;
 		qcfs_rq->idle_h_nr_running -= idle_task_delta;
 		qcfs_rq->h_nr_delayed -= delayed_delta;
 
@@ -6009,6 +6013,7 @@ static bool throttle_cfs_rq(struct cfs_rq *cfs_rq)
 			idle_task_delta = cfs_rq->h_nr_queued;
 
 		qcfs_rq->h_nr_queued -= queued_delta;
+		qcfs_rq->h_nr_runnable -= runnable_delta;
 		qcfs_rq->idle_h_nr_running -= idle_task_delta;
 		qcfs_rq->h_nr_delayed -= delayed_delta;
 	}
@@ -6036,7 +6041,7 @@ void unthrottle_cfs_rq(struct cfs_rq *cfs_rq)
 	struct rq *rq = rq_of(cfs_rq);
 	struct cfs_bandwidth *cfs_b = tg_cfs_bandwidth(cfs_rq->tg);
 	struct sched_entity *se;
-	long queued_delta, idle_task_delta, delayed_delta;
+	long queued_delta, runnable_delta, idle_task_delta, delayed_delta;
 	long rq_h_nr_queued = rq->cfs.h_nr_queued;
 
 	se = cfs_rq->tg->se[cpu_of(rq)];
@@ -6071,6 +6076,7 @@ void unthrottle_cfs_rq(struct cfs_rq *cfs_rq)
 	}
 
 	queued_delta = cfs_rq->h_nr_queued;
+	runnable_delta = cfs_rq->h_nr_runnable;
 	idle_task_delta = cfs_rq->idle_h_nr_running;
 	delayed_delta = cfs_rq->h_nr_delayed;
 	for_each_sched_entity(se) {
@@ -6089,6 +6095,7 @@ void unthrottle_cfs_rq(struct cfs_rq *cfs_rq)
 			idle_task_delta = cfs_rq->h_nr_queued;
 
 		qcfs_rq->h_nr_queued += queued_delta;
+		qcfs_rq->h_nr_runnable += runnable_delta;
 		qcfs_rq->idle_h_nr_running += idle_task_delta;
 		qcfs_rq->h_nr_delayed += delayed_delta;
 
@@ -6107,6 +6114,7 @@ void unthrottle_cfs_rq(struct cfs_rq *cfs_rq)
 			idle_task_delta = cfs_rq->h_nr_queued;
 
 		qcfs_rq->h_nr_queued += queued_delta;
+		qcfs_rq->h_nr_runnable += runnable_delta;
 		qcfs_rq->idle_h_nr_running += idle_task_delta;
 		qcfs_rq->h_nr_delayed += delayed_delta;
 
@@ -7021,6 +7029,8 @@ enqueue_task_fair(struct rq *rq, struct task_struct *p, int flags)
 		enqueue_entity(cfs_rq, se, flags);
 		slice = cfs_rq_min_slice(cfs_rq);
 
+		if (!h_nr_delayed)
+			cfs_rq->h_nr_runnable++;
 		cfs_rq->h_nr_queued++;
 		cfs_rq->idle_h_nr_running += idle_h_nr_running;
 		cfs_rq->h_nr_delayed += h_nr_delayed;
@@ -7045,6 +7055,8 @@ enqueue_task_fair(struct rq *rq, struct task_struct *p, int flags)
 		se->slice = slice;
 		slice = cfs_rq_min_slice(cfs_rq);
 
+		if (!h_nr_delayed)
+			cfs_rq->h_nr_runnable++;
 		cfs_rq->h_nr_queued++;
 		cfs_rq->idle_h_nr_running += idle_h_nr_running;
 		cfs_rq->h_nr_delayed += h_nr_delayed;
@@ -7135,6 +7147,8 @@ static int dequeue_entities(struct rq *rq, struct sched_entity *se, int flags)
 			break;
 		}
 
+		if (!h_nr_delayed)
+			cfs_rq->h_nr_runnable -= h_nr_queued;
 		cfs_rq->h_nr_queued -= h_nr_queued;
 		cfs_rq->idle_h_nr_running -= idle_h_nr_running;
 		cfs_rq->h_nr_delayed -= h_nr_delayed;
@@ -7174,6 +7188,8 @@ static int dequeue_entities(struct rq *rq, struct sched_entity *se, int flags)
 		se->slice = slice;
 		slice = cfs_rq_min_slice(cfs_rq);
 
+		if (!h_nr_delayed)
+			cfs_rq->h_nr_runnable -= h_nr_queued;
 		cfs_rq->h_nr_queued -= h_nr_queued;
 		cfs_rq->idle_h_nr_running -= idle_h_nr_running;
 		cfs_rq->h_nr_delayed -= h_nr_delayed;
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index b011081..869d5d3 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -647,6 +647,7 @@ struct cfs_rq {
 	struct load_weight	load;
 	unsigned int		nr_running;
 	unsigned int		h_nr_queued;       /* SCHED_{NORMAL,BATCH,IDLE} */
+	unsigned int		h_nr_runnable;     /* SCHED_{NORMAL,BATCH,IDLE} */
 	unsigned int		idle_nr_running;   /* SCHED_IDLE */
 	unsigned int		idle_h_nr_running; /* SCHED_IDLE */
 	unsigned int		h_nr_delayed;

