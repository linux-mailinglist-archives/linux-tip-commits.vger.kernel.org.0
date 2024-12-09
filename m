Return-Path: <linux-tip-commits+bounces-3034-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 917649E912F
	for <lists+linux-tip-commits@lfdr.de>; Mon,  9 Dec 2024 12:01:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D0DEA2812A7
	for <lists+linux-tip-commits@lfdr.de>; Mon,  9 Dec 2024 11:01:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CCE5217731;
	Mon,  9 Dec 2024 11:00:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ffL7oM1W";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="3Z3v9AGP"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CBBA217727;
	Mon,  9 Dec 2024 11:00:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733742014; cv=none; b=NCRFZnoC3TA50K1xuFwvosd/pGHcBpHSwAWgOC7gKTrf0QX8znuB4tzkp06Q+C048Gqdwu1jDUk8EAXCUrr9mcVMbw3zKzKd7CyiI+YTuhNS+tPOEwddi4JYYRTyEBdpGMl9DGMY4fuiN0Q6OrsXzaLyTUXnIgGjM0F8UCCubVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733742014; c=relaxed/simple;
	bh=6loIiUr0/OETyrVmfY1j9ZgTiM3VY+RgjgQEuB2YJWI=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=rZ+3/bE3MSMUGlmpoxGbhvAQKwCkEHrR5PXib3u/bUHRH9DLHTnJrnS5D+DHRh5UnMIthbBp83SRaYRmkV8mHAyHnrIzhlxxXEZQkBprQkTJjVuuW6A4oOmzNIGxGlQq1Khrjlv4mLFCx1ZTWsJ90V1W3qq39SDKHuTxn1JKeM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ffL7oM1W; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=3Z3v9AGP; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 09 Dec 2024 11:00:07 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1733742009;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=07U+fJEPRlzjj/U7yRdWQbUIk0449mwoVFLSfE7SJGA=;
	b=ffL7oM1W6kLvrznA/wm95sePc8sqA/WXr0JsHoU+AsHcg4Wc6vGjIYDUCy61kxcMEsFP93
	2WJHU3hfo7MhS+nZ3P2o1jtRiJvMxx8nPfySmJ8Z4vnH3oQ//PHW7JyO7JdfZNqidf0jPO
	Eqe1+Ah6hL2iGVPzT/mZPJrWOwLG4NgeBq1+K2eOz12wjOVvo+uOW+PBW3vbElUOQx/Bmc
	GCQ5WliLsMleSyO2BFyp0y9IpnOxsgPTbVKfqurcHVyJP1lCv/J5WLVKI6TH0wWPctmDdN
	k9XdLlc5Oc9bhsndvDxIYq+71ETppbkEOjLFb7GnpuK+CSBUvSMWjlKL2LUf8w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1733742009;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=07U+fJEPRlzjj/U7yRdWQbUIk0449mwoVFLSfE7SJGA=;
	b=3Z3v9AGPN2W4eSHjrwBjRg6xdZAnfBNA3yoYMDpF5MsiEzi+URUYpkiX1AQ1iPoaWqJed8
	vNNRGJevE8mrFCDg==
From: "tip-bot2 for Vincent Guittot" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/fair: Removed unsued cfs_rq.h_nr_delayed
Cc: Vincent Guittot <vincent.guittot@linaro.org>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20241202174606.4074512-7-vincent.guittot@linaro.org>
References: <20241202174606.4074512-7-vincent.guittot@linaro.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173374200789.412.4824649308370062289.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     9216582b0bfb17889eebcf96fb41cd67a3d71133
Gitweb:        https://git.kernel.org/tip/9216582b0bfb17889eebcf96fb41cd67a3d71133
Author:        Vincent Guittot <vincent.guittot@linaro.org>
AuthorDate:    Mon, 02 Dec 2024 18:46:01 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 09 Dec 2024 11:48:11 +01:00

sched/fair: Removed unsued cfs_rq.h_nr_delayed

h_nr_delayed is not used anymore. We now have:
 - h_nr_runnable which tracks tasks ready to run
 - h_nr_queued which tracks enqueued tasks either ready to run or
   delayed dequeue

Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
Link: https://lore.kernel.org/r/20241202174606.4074512-7-vincent.guittot@linaro.org
---
 kernel/sched/debug.c |  1 -
 kernel/sched/fair.c  | 40 ++++++++++++----------------------------
 kernel/sched/sched.h |  1 -
 3 files changed, 12 insertions(+), 30 deletions(-)

diff --git a/kernel/sched/debug.c b/kernel/sched/debug.c
index fd711cc..56be365 100644
--- a/kernel/sched/debug.c
+++ b/kernel/sched/debug.c
@@ -846,7 +846,6 @@ void print_cfs_rq(struct seq_file *m, int cpu, struct cfs_rq *cfs_rq)
 	SEQ_printf(m, "  .%-30s: %d\n", "nr_running", cfs_rq->nr_running);
 	SEQ_printf(m, "  .%-30s: %d\n", "h_nr_runnable", cfs_rq->h_nr_runnable);
 	SEQ_printf(m, "  .%-30s: %d\n", "h_nr_queued", cfs_rq->h_nr_queued);
-	SEQ_printf(m, "  .%-30s: %d\n", "h_nr_delayed", cfs_rq->h_nr_delayed);
 	SEQ_printf(m, "  .%-30s: %d\n", "idle_nr_running",
 			cfs_rq->idle_nr_running);
 	SEQ_printf(m, "  .%-30s: %d\n", "idle_h_nr_running",
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 3a8bdfb..5c2f049 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -5470,7 +5470,6 @@ static void set_delayed(struct sched_entity *se)
 		struct cfs_rq *cfs_rq = cfs_rq_of(se);
 
 		cfs_rq->h_nr_runnable--;
-		cfs_rq->h_nr_delayed++;
 		if (cfs_rq_throttled(cfs_rq))
 			break;
 	}
@@ -5483,7 +5482,6 @@ static void clear_delayed(struct sched_entity *se)
 		struct cfs_rq *cfs_rq = cfs_rq_of(se);
 
 		cfs_rq->h_nr_runnable++;
-		cfs_rq->h_nr_delayed--;
 		if (cfs_rq_throttled(cfs_rq))
 			break;
 	}
@@ -5932,7 +5930,7 @@ static bool throttle_cfs_rq(struct cfs_rq *cfs_rq)
 	struct rq *rq = rq_of(cfs_rq);
 	struct cfs_bandwidth *cfs_b = tg_cfs_bandwidth(cfs_rq->tg);
 	struct sched_entity *se;
-	long queued_delta, runnable_delta, idle_task_delta, delayed_delta, dequeue = 1;
+	long queued_delta, runnable_delta, idle_task_delta, dequeue = 1;
 	long rq_h_nr_queued = rq->cfs.h_nr_queued;
 
 	raw_spin_lock(&cfs_b->lock);
@@ -5966,7 +5964,6 @@ static bool throttle_cfs_rq(struct cfs_rq *cfs_rq)
 	queued_delta = cfs_rq->h_nr_queued;
 	runnable_delta = cfs_rq->h_nr_runnable;
 	idle_task_delta = cfs_rq->idle_h_nr_running;
-	delayed_delta = cfs_rq->h_nr_delayed;
 	for_each_sched_entity(se) {
 		struct cfs_rq *qcfs_rq = cfs_rq_of(se);
 		int flags;
@@ -5991,7 +5988,6 @@ static bool throttle_cfs_rq(struct cfs_rq *cfs_rq)
 		qcfs_rq->h_nr_queued -= queued_delta;
 		qcfs_rq->h_nr_runnable -= runnable_delta;
 		qcfs_rq->idle_h_nr_running -= idle_task_delta;
-		qcfs_rq->h_nr_delayed -= delayed_delta;
 
 		if (qcfs_rq->load.weight) {
 			/* Avoid re-evaluating load for this entity: */
@@ -6015,7 +6011,6 @@ static bool throttle_cfs_rq(struct cfs_rq *cfs_rq)
 		qcfs_rq->h_nr_queued -= queued_delta;
 		qcfs_rq->h_nr_runnable -= runnable_delta;
 		qcfs_rq->idle_h_nr_running -= idle_task_delta;
-		qcfs_rq->h_nr_delayed -= delayed_delta;
 	}
 
 	/* At this point se is NULL and we are at root level*/
@@ -6041,7 +6036,7 @@ void unthrottle_cfs_rq(struct cfs_rq *cfs_rq)
 	struct rq *rq = rq_of(cfs_rq);
 	struct cfs_bandwidth *cfs_b = tg_cfs_bandwidth(cfs_rq->tg);
 	struct sched_entity *se;
-	long queued_delta, runnable_delta, idle_task_delta, delayed_delta;
+	long queued_delta, runnable_delta, idle_task_delta;
 	long rq_h_nr_queued = rq->cfs.h_nr_queued;
 
 	se = cfs_rq->tg->se[cpu_of(rq)];
@@ -6078,7 +6073,6 @@ void unthrottle_cfs_rq(struct cfs_rq *cfs_rq)
 	queued_delta = cfs_rq->h_nr_queued;
 	runnable_delta = cfs_rq->h_nr_runnable;
 	idle_task_delta = cfs_rq->idle_h_nr_running;
-	delayed_delta = cfs_rq->h_nr_delayed;
 	for_each_sched_entity(se) {
 		struct cfs_rq *qcfs_rq = cfs_rq_of(se);
 
@@ -6097,7 +6091,6 @@ void unthrottle_cfs_rq(struct cfs_rq *cfs_rq)
 		qcfs_rq->h_nr_queued += queued_delta;
 		qcfs_rq->h_nr_runnable += runnable_delta;
 		qcfs_rq->idle_h_nr_running += idle_task_delta;
-		qcfs_rq->h_nr_delayed += delayed_delta;
 
 		/* end evaluation on encountering a throttled cfs_rq */
 		if (cfs_rq_throttled(qcfs_rq))
@@ -6116,7 +6109,6 @@ void unthrottle_cfs_rq(struct cfs_rq *cfs_rq)
 		qcfs_rq->h_nr_queued += queued_delta;
 		qcfs_rq->h_nr_runnable += runnable_delta;
 		qcfs_rq->idle_h_nr_running += idle_task_delta;
-		qcfs_rq->h_nr_delayed += delayed_delta;
 
 		/* end evaluation on encountering a throttled cfs_rq */
 		if (cfs_rq_throttled(qcfs_rq))
@@ -6979,7 +6971,7 @@ enqueue_task_fair(struct rq *rq, struct task_struct *p, int flags)
 	struct cfs_rq *cfs_rq;
 	struct sched_entity *se = &p->se;
 	int idle_h_nr_running = task_has_idle_policy(p);
-	int h_nr_delayed = 0;
+	int h_nr_runnable = 1;
 	int task_new = !(flags & ENQUEUE_WAKEUP);
 	int rq_h_nr_queued = rq->cfs.h_nr_queued;
 	u64 slice = 0;
@@ -7006,8 +6998,8 @@ enqueue_task_fair(struct rq *rq, struct task_struct *p, int flags)
 	if (p->in_iowait)
 		cpufreq_update_util(rq, SCHED_CPUFREQ_IOWAIT);
 
-	if (task_new)
-		h_nr_delayed = !!se->sched_delayed;
+	if (task_new && se->sched_delayed)
+		h_nr_runnable = 0;
 
 	for_each_sched_entity(se) {
 		if (se->on_rq) {
@@ -7029,11 +7021,9 @@ enqueue_task_fair(struct rq *rq, struct task_struct *p, int flags)
 		enqueue_entity(cfs_rq, se, flags);
 		slice = cfs_rq_min_slice(cfs_rq);
 
-		if (!h_nr_delayed)
-			cfs_rq->h_nr_runnable++;
+		cfs_rq->h_nr_runnable += h_nr_runnable;
 		cfs_rq->h_nr_queued++;
 		cfs_rq->idle_h_nr_running += idle_h_nr_running;
-		cfs_rq->h_nr_delayed += h_nr_delayed;
 
 		if (cfs_rq_is_idle(cfs_rq))
 			idle_h_nr_running = 1;
@@ -7055,11 +7045,9 @@ enqueue_task_fair(struct rq *rq, struct task_struct *p, int flags)
 		se->slice = slice;
 		slice = cfs_rq_min_slice(cfs_rq);
 
-		if (!h_nr_delayed)
-			cfs_rq->h_nr_runnable++;
+		cfs_rq->h_nr_runnable += h_nr_runnable;
 		cfs_rq->h_nr_queued++;
 		cfs_rq->idle_h_nr_running += idle_h_nr_running;
-		cfs_rq->h_nr_delayed += h_nr_delayed;
 
 		if (cfs_rq_is_idle(cfs_rq))
 			idle_h_nr_running = 1;
@@ -7122,7 +7110,7 @@ static int dequeue_entities(struct rq *rq, struct sched_entity *se, int flags)
 	struct task_struct *p = NULL;
 	int idle_h_nr_running = 0;
 	int h_nr_queued = 0;
-	int h_nr_delayed = 0;
+	int h_nr_runnable = 0;
 	struct cfs_rq *cfs_rq;
 	u64 slice = 0;
 
@@ -7130,8 +7118,8 @@ static int dequeue_entities(struct rq *rq, struct sched_entity *se, int flags)
 		p = task_of(se);
 		h_nr_queued = 1;
 		idle_h_nr_running = task_has_idle_policy(p);
-		if (!task_sleep && !task_delayed)
-			h_nr_delayed = !!se->sched_delayed;
+		if (task_sleep || task_delayed || !se->sched_delayed)
+			h_nr_runnable = 1;
 	} else {
 		cfs_rq = group_cfs_rq(se);
 		slice = cfs_rq_min_slice(cfs_rq);
@@ -7147,11 +7135,9 @@ static int dequeue_entities(struct rq *rq, struct sched_entity *se, int flags)
 			break;
 		}
 
-		if (!h_nr_delayed)
-			cfs_rq->h_nr_runnable -= h_nr_queued;
+		cfs_rq->h_nr_runnable -= h_nr_runnable;
 		cfs_rq->h_nr_queued -= h_nr_queued;
 		cfs_rq->idle_h_nr_running -= idle_h_nr_running;
-		cfs_rq->h_nr_delayed -= h_nr_delayed;
 
 		if (cfs_rq_is_idle(cfs_rq))
 			idle_h_nr_running = h_nr_queued;
@@ -7188,11 +7174,9 @@ static int dequeue_entities(struct rq *rq, struct sched_entity *se, int flags)
 		se->slice = slice;
 		slice = cfs_rq_min_slice(cfs_rq);
 
-		if (!h_nr_delayed)
-			cfs_rq->h_nr_runnable -= h_nr_queued;
+		cfs_rq->h_nr_runnable -= h_nr_runnable;
 		cfs_rq->h_nr_queued -= h_nr_queued;
 		cfs_rq->idle_h_nr_running -= idle_h_nr_running;
-		cfs_rq->h_nr_delayed -= h_nr_delayed;
 
 		if (cfs_rq_is_idle(cfs_rq))
 			idle_h_nr_running = h_nr_queued;
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 4374c66..d3ce5e9 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -650,7 +650,6 @@ struct cfs_rq {
 	unsigned int		h_nr_runnable;     /* SCHED_{NORMAL,BATCH,IDLE} */
 	unsigned int		idle_nr_running;   /* SCHED_IDLE */
 	unsigned int		idle_h_nr_running; /* SCHED_IDLE */
-	unsigned int		h_nr_delayed;
 
 	s64			avg_vruntime;
 	u64			avg_load;

