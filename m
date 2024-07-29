Return-Path: <linux-tip-commits+bounces-1790-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 61CBB93F2C7
	for <lists+linux-tip-commits@lfdr.de>; Mon, 29 Jul 2024 12:34:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DA3671F226BC
	for <lists+linux-tip-commits@lfdr.de>; Mon, 29 Jul 2024 10:34:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C24E1422D5;
	Mon, 29 Jul 2024 10:34:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Edp1GyZq";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Wr3I8Ycu"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D7C2142E7C;
	Mon, 29 Jul 2024 10:34:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722249246; cv=none; b=QTTnyqeNLmPkbaO9XOsz8R1SAfSKAsk4WiNf6GHx1Ex6bG2WZffsG/lSKoZF7Z34iFToCOc4qB+jswPI9KMzyJVt37XNRvKqp8iOMaWx+s5W4fs2skYLNQiHqIBNu6pUbRGs50JUVYGCwkDNvYiNI31//oyK/yKeIcMo2pmuvms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722249246; c=relaxed/simple;
	bh=kEqgqMKoHljP+Wcbjz+fV6FLMSoxWd9EPlZPIQVsANA=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=uV8LOq9EY4m9hv1FdvZpD5/qxg81kRW55g/hjgK8qnRCzfPPp6HKKDewR5MFNHcD4e5mgYLnYs20USjtgqZLg99eMFXArYj0tB85QDujS0fQD7j2SvXONEsGiLaTtHxVfePAtbWbJlscZO/aWlxgoeVaYDnWHNkNHfA4osod+FE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Edp1GyZq; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Wr3I8Ycu; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 29 Jul 2024 10:34:02 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1722249242;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9KTbibSjP01Ua+JGFkt3yqvZXyz4hrK/dw8XWdyD3UY=;
	b=Edp1GyZqPyFZyT74/wX+265bwsoVSd9oHGlnsVm5ikAcd1imda+b7n3PzLXndIegZBoTLz
	0bF6PtXpVnCKtLe32aaCtGYKz013JKPqdkcchCQEg2dTqTqbgvENoxyhjSD/JfmyPQQpDs
	qsRA2w++W2iCyWaT22zuIrqFDp/ihotrBcAPObkTOwkBTD5csQPfFIIeS/fLj8WjqG/YZH
	QT+XP7HLEY1RQSWH9ETTYgYg9ery3Kq1Uh1MbXUAT9iUdx7GACuF92jOQJQekdwK/GrjP8
	kmFc0u+qEGPXSpu4PBCsVbJflPKjnZZJxa139LIbrwDR9F661YeadE1r/nRMtQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1722249242;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9KTbibSjP01Ua+JGFkt3yqvZXyz4hrK/dw8XWdyD3UY=;
	b=Wr3I8YcuHldtfXyOV7TvugPHb0hGY1Nbjo1fvd3eZ2Hig7dyw+jOdJfv2cJuSJ45bZL7cj
	aFBtAgbhPRZ7cvDg==
From: "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/rt: Remove default bandwidth control
Cc: "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Daniel Bristot de Oliveira <bristot@kernel.org>,
 "Vineeth Pillai (Google)" <vineeth@bitbyteword.org>,
 Juri Lelli <juri.lelli@redhat.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To:
 <14d562db55df5c3c780d91940743acb166895ef7.1716811044.git.bristot@kernel.org>
References:
 <14d562db55df5c3c780d91940743acb166895ef7.1716811044.git.bristot@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172224924216.2215.1362872184696992440.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     5f6bd380c7bdbe10f7b4e8ddcceed60ce0714c6d
Gitweb:        https://git.kernel.org/tip/5f6bd380c7bdbe10f7b4e8ddcceed60ce0714c6d
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Mon, 27 May 2024 14:06:55 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 29 Jul 2024 12:22:37 +02:00

sched/rt: Remove default bandwidth control

Now that fair_server exists, we no longer need RT bandwidth control
unless RT_GROUP_SCHED.

Enable fair_server with parameters equivalent to RT throttling.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: "Peter Zijlstra (Intel)" <peterz@infradead.org>
Signed-off-by: Daniel Bristot de Oliveira <bristot@kernel.org>
Signed-off-by: "Vineeth Pillai (Google)" <vineeth@bitbyteword.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Tested-by: Juri Lelli <juri.lelli@redhat.com>
Link: https://lore.kernel.org/r/14d562db55df5c3c780d91940743acb166895ef7.1716811044.git.bristot@kernel.org
---
 kernel/sched/core.c     |   9 +-
 kernel/sched/deadline.c |   5 +-
 kernel/sched/debug.c    |   3 +-
 kernel/sched/rt.c       | 242 +++++++++++++++++----------------------
 kernel/sched/sched.h    |   3 +-
 5 files changed, 120 insertions(+), 142 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 11abfcd..29fde99 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -8266,8 +8266,6 @@ void __init sched_init(void)
 #endif /* CONFIG_RT_GROUP_SCHED */
 	}
 
-	init_rt_bandwidth(&def_rt_bandwidth, global_rt_period(), global_rt_runtime());
-
 #ifdef CONFIG_SMP
 	init_defrootdomain();
 #endif
@@ -8322,8 +8320,13 @@ void __init sched_init(void)
 		init_tg_cfs_entry(&root_task_group, &rq->cfs, NULL, i, NULL);
 #endif /* CONFIG_FAIR_GROUP_SCHED */
 
-		rq->rt.rt_runtime = def_rt_bandwidth.rt_runtime;
 #ifdef CONFIG_RT_GROUP_SCHED
+		/*
+		 * This is required for init cpu because rt.c:__enable_runtime()
+		 * starts working after scheduler_running, which is not the case
+		 * yet.
+		 */
+		rq->rt.rt_runtime = global_rt_runtime();
 		init_tg_rt_entry(&root_task_group, &rq->rt, NULL, i, NULL);
 #endif
 #ifdef CONFIG_SMP
diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index 8571bc9..c5f1cc7 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -1554,6 +1554,7 @@ throttle:
 	if (dl_se == &rq->fair_server)
 		return;
 
+#ifdef CONFIG_RT_GROUP_SCHED
 	/*
 	 * Because -- for now -- we share the rt bandwidth, we need to
 	 * account our runtime there too, otherwise actual rt tasks
@@ -1578,6 +1579,7 @@ throttle:
 			rt_rq->rt_time += delta_exec;
 		raw_spin_unlock(&rt_rq->rt_runtime_lock);
 	}
+#endif
 }
 
 /*
@@ -1632,8 +1634,7 @@ void dl_server_start(struct sched_dl_entity *dl_se)
 	 * this before getting generic.
 	 */
 	if (!dl_server(dl_se)) {
-		/* Disabled */
-		u64 runtime = 0;
+		u64 runtime =  50 * NSEC_PER_MSEC;
 		u64 period = 1000 * NSEC_PER_MSEC;
 
 		dl_server_apply_params(dl_se, runtime, period, 1);
diff --git a/kernel/sched/debug.c b/kernel/sched/debug.c
index 72f2715..e75914e 100644
--- a/kernel/sched/debug.c
+++ b/kernel/sched/debug.c
@@ -885,9 +885,12 @@ void print_rt_rq(struct seq_file *m, int cpu, struct rt_rq *rt_rq)
 	SEQ_printf(m, "  .%-30s: %Ld.%06ld\n", #x, SPLIT_NS(rt_rq->x))
 
 	PU(rt_nr_running);
+
+#ifdef CONFIG_RT_GROUP_SCHED
 	P(rt_throttled);
 	PN(rt_time);
 	PN(rt_runtime);
+#endif
 
 #undef PN
 #undef PU
diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
index 310523c..a8731da 100644
--- a/kernel/sched/rt.c
+++ b/kernel/sched/rt.c
@@ -8,10 +8,6 @@ int sched_rr_timeslice = RR_TIMESLICE;
 /* More than 4 hours if BW_SHIFT equals 20. */
 static const u64 max_rt_runtime = MAX_BW;
 
-static int do_sched_rt_period_timer(struct rt_bandwidth *rt_b, int overrun);
-
-struct rt_bandwidth def_rt_bandwidth;
-
 /*
  * period over which we measure -rt task CPU usage in us.
  * default: 1s
@@ -66,6 +62,40 @@ static int __init sched_rt_sysctl_init(void)
 late_initcall(sched_rt_sysctl_init);
 #endif
 
+void init_rt_rq(struct rt_rq *rt_rq)
+{
+	struct rt_prio_array *array;
+	int i;
+
+	array = &rt_rq->active;
+	for (i = 0; i < MAX_RT_PRIO; i++) {
+		INIT_LIST_HEAD(array->queue + i);
+		__clear_bit(i, array->bitmap);
+	}
+	/* delimiter for bitsearch: */
+	__set_bit(MAX_RT_PRIO, array->bitmap);
+
+#if defined CONFIG_SMP
+	rt_rq->highest_prio.curr = MAX_RT_PRIO-1;
+	rt_rq->highest_prio.next = MAX_RT_PRIO-1;
+	rt_rq->overloaded = 0;
+	plist_head_init(&rt_rq->pushable_tasks);
+#endif /* CONFIG_SMP */
+	/* We start is dequeued state, because no RT tasks are queued */
+	rt_rq->rt_queued = 0;
+
+#ifdef CONFIG_RT_GROUP_SCHED
+	rt_rq->rt_time = 0;
+	rt_rq->rt_throttled = 0;
+	rt_rq->rt_runtime = 0;
+	raw_spin_lock_init(&rt_rq->rt_runtime_lock);
+#endif
+}
+
+#ifdef CONFIG_RT_GROUP_SCHED
+
+static int do_sched_rt_period_timer(struct rt_bandwidth *rt_b, int overrun);
+
 static enum hrtimer_restart sched_rt_period_timer(struct hrtimer *timer)
 {
 	struct rt_bandwidth *rt_b =
@@ -130,35 +160,6 @@ static void start_rt_bandwidth(struct rt_bandwidth *rt_b)
 	do_start_rt_bandwidth(rt_b);
 }
 
-void init_rt_rq(struct rt_rq *rt_rq)
-{
-	struct rt_prio_array *array;
-	int i;
-
-	array = &rt_rq->active;
-	for (i = 0; i < MAX_RT_PRIO; i++) {
-		INIT_LIST_HEAD(array->queue + i);
-		__clear_bit(i, array->bitmap);
-	}
-	/* delimiter for bit-search: */
-	__set_bit(MAX_RT_PRIO, array->bitmap);
-
-#if defined CONFIG_SMP
-	rt_rq->highest_prio.curr = MAX_RT_PRIO-1;
-	rt_rq->highest_prio.next = MAX_RT_PRIO-1;
-	rt_rq->overloaded = 0;
-	plist_head_init(&rt_rq->pushable_tasks);
-#endif /* CONFIG_SMP */
-	/* We start is dequeued state, because no RT tasks are queued */
-	rt_rq->rt_queued = 0;
-
-	rt_rq->rt_time = 0;
-	rt_rq->rt_throttled = 0;
-	rt_rq->rt_runtime = 0;
-	raw_spin_lock_init(&rt_rq->rt_runtime_lock);
-}
-
-#ifdef CONFIG_RT_GROUP_SCHED
 static void destroy_rt_bandwidth(struct rt_bandwidth *rt_b)
 {
 	hrtimer_cancel(&rt_b->rt_period_timer);
@@ -195,7 +196,6 @@ void unregister_rt_sched_group(struct task_group *tg)
 {
 	if (tg->rt_se)
 		destroy_rt_bandwidth(&tg->rt_bandwidth);
-
 }
 
 void free_rt_sched_group(struct task_group *tg)
@@ -253,8 +253,7 @@ int alloc_rt_sched_group(struct task_group *tg, struct task_group *parent)
 	if (!tg->rt_se)
 		goto err;
 
-	init_rt_bandwidth(&tg->rt_bandwidth,
-			ktime_to_ns(def_rt_bandwidth.rt_period), 0);
+	init_rt_bandwidth(&tg->rt_bandwidth, ktime_to_ns(global_rt_period()), 0);
 
 	for_each_possible_cpu(i) {
 		rt_rq = kzalloc_node(sizeof(struct rt_rq),
@@ -604,70 +603,6 @@ static inline struct rt_bandwidth *sched_rt_bandwidth(struct rt_rq *rt_rq)
 	return &rt_rq->tg->rt_bandwidth;
 }
 
-#else /* !CONFIG_RT_GROUP_SCHED */
-
-static inline u64 sched_rt_runtime(struct rt_rq *rt_rq)
-{
-	return rt_rq->rt_runtime;
-}
-
-static inline u64 sched_rt_period(struct rt_rq *rt_rq)
-{
-	return ktime_to_ns(def_rt_bandwidth.rt_period);
-}
-
-typedef struct rt_rq *rt_rq_iter_t;
-
-#define for_each_rt_rq(rt_rq, iter, rq) \
-	for ((void) iter, rt_rq = &rq->rt; rt_rq; rt_rq = NULL)
-
-#define for_each_sched_rt_entity(rt_se) \
-	for (; rt_se; rt_se = NULL)
-
-static inline struct rt_rq *group_rt_rq(struct sched_rt_entity *rt_se)
-{
-	return NULL;
-}
-
-static inline void sched_rt_rq_enqueue(struct rt_rq *rt_rq)
-{
-	struct rq *rq = rq_of_rt_rq(rt_rq);
-
-	if (!rt_rq->rt_nr_running)
-		return;
-
-	enqueue_top_rt_rq(rt_rq);
-	resched_curr(rq);
-}
-
-static inline void sched_rt_rq_dequeue(struct rt_rq *rt_rq)
-{
-	dequeue_top_rt_rq(rt_rq, rt_rq->rt_nr_running);
-}
-
-static inline int rt_rq_throttled(struct rt_rq *rt_rq)
-{
-	return rt_rq->rt_throttled;
-}
-
-static inline const struct cpumask *sched_rt_period_mask(void)
-{
-	return cpu_online_mask;
-}
-
-static inline
-struct rt_rq *sched_rt_period_rt_rq(struct rt_bandwidth *rt_b, int cpu)
-{
-	return &cpu_rq(cpu)->rt;
-}
-
-static inline struct rt_bandwidth *sched_rt_bandwidth(struct rt_rq *rt_rq)
-{
-	return &def_rt_bandwidth;
-}
-
-#endif /* CONFIG_RT_GROUP_SCHED */
-
 bool sched_rt_bandwidth_account(struct rt_rq *rt_rq)
 {
 	struct rt_bandwidth *rt_b = sched_rt_bandwidth(rt_rq);
@@ -859,7 +794,7 @@ static int do_sched_rt_period_timer(struct rt_bandwidth *rt_b, int overrun)
 	const struct cpumask *span;
 
 	span = sched_rt_period_mask();
-#ifdef CONFIG_RT_GROUP_SCHED
+
 	/*
 	 * FIXME: isolated CPUs should really leave the root task group,
 	 * whether they are isolcpus or were isolated via cpusets, lest
@@ -871,7 +806,7 @@ static int do_sched_rt_period_timer(struct rt_bandwidth *rt_b, int overrun)
 	 */
 	if (rt_b == &root_task_group.rt_bandwidth)
 		span = cpu_online_mask;
-#endif
+
 	for_each_cpu(i, span) {
 		int enqueue = 0;
 		struct rt_rq *rt_rq = sched_rt_period_rt_rq(rt_b, i);
@@ -938,18 +873,6 @@ static int do_sched_rt_period_timer(struct rt_bandwidth *rt_b, int overrun)
 	return idle;
 }
 
-static inline int rt_se_prio(struct sched_rt_entity *rt_se)
-{
-#ifdef CONFIG_RT_GROUP_SCHED
-	struct rt_rq *rt_rq = group_rt_rq(rt_se);
-
-	if (rt_rq)
-		return rt_rq->highest_prio.curr;
-#endif
-
-	return rt_task_of(rt_se)->prio;
-}
-
 static int sched_rt_runtime_exceeded(struct rt_rq *rt_rq)
 {
 	u64 runtime = sched_rt_runtime(rt_rq);
@@ -993,6 +916,72 @@ static int sched_rt_runtime_exceeded(struct rt_rq *rt_rq)
 	return 0;
 }
 
+#else /* !CONFIG_RT_GROUP_SCHED */
+
+typedef struct rt_rq *rt_rq_iter_t;
+
+#define for_each_rt_rq(rt_rq, iter, rq) \
+	for ((void) iter, rt_rq = &rq->rt; rt_rq; rt_rq = NULL)
+
+#define for_each_sched_rt_entity(rt_se) \
+	for (; rt_se; rt_se = NULL)
+
+static inline struct rt_rq *group_rt_rq(struct sched_rt_entity *rt_se)
+{
+	return NULL;
+}
+
+static inline void sched_rt_rq_enqueue(struct rt_rq *rt_rq)
+{
+	struct rq *rq = rq_of_rt_rq(rt_rq);
+
+	if (!rt_rq->rt_nr_running)
+		return;
+
+	enqueue_top_rt_rq(rt_rq);
+	resched_curr(rq);
+}
+
+static inline void sched_rt_rq_dequeue(struct rt_rq *rt_rq)
+{
+	dequeue_top_rt_rq(rt_rq, rt_rq->rt_nr_running);
+}
+
+static inline int rt_rq_throttled(struct rt_rq *rt_rq)
+{
+	return false;
+}
+
+static inline const struct cpumask *sched_rt_period_mask(void)
+{
+	return cpu_online_mask;
+}
+
+static inline
+struct rt_rq *sched_rt_period_rt_rq(struct rt_bandwidth *rt_b, int cpu)
+{
+	return &cpu_rq(cpu)->rt;
+}
+
+#ifdef CONFIG_SMP
+static void __enable_runtime(struct rq *rq) { }
+static void __disable_runtime(struct rq *rq) { }
+#endif
+
+#endif /* CONFIG_RT_GROUP_SCHED */
+
+static inline int rt_se_prio(struct sched_rt_entity *rt_se)
+{
+#ifdef CONFIG_RT_GROUP_SCHED
+	struct rt_rq *rt_rq = group_rt_rq(rt_se);
+
+	if (rt_rq)
+		return rt_rq->highest_prio.curr;
+#endif
+
+	return rt_task_of(rt_se)->prio;
+}
+
 /*
  * Update the current task's runtime statistics. Skip current tasks that
  * are not in our scheduling class.
@@ -1000,7 +989,6 @@ static int sched_rt_runtime_exceeded(struct rt_rq *rt_rq)
 static void update_curr_rt(struct rq *rq)
 {
 	struct task_struct *curr = rq->curr;
-	struct sched_rt_entity *rt_se = &curr->rt;
 	s64 delta_exec;
 
 	if (curr->sched_class != &rt_sched_class)
@@ -1010,6 +998,9 @@ static void update_curr_rt(struct rq *rq)
 	if (unlikely(delta_exec <= 0))
 		return;
 
+#ifdef CONFIG_RT_GROUP_SCHED
+	struct sched_rt_entity *rt_se = &curr->rt;
+
 	if (!rt_bandwidth_enabled())
 		return;
 
@@ -1028,6 +1019,7 @@ static void update_curr_rt(struct rq *rq)
 				do_start_rt_bandwidth(sched_rt_bandwidth(rt_rq));
 		}
 	}
+#endif
 }
 
 static void
@@ -1184,7 +1176,6 @@ dec_rt_group(struct sched_rt_entity *rt_se, struct rt_rq *rt_rq)
 static void
 inc_rt_group(struct sched_rt_entity *rt_se, struct rt_rq *rt_rq)
 {
-	start_rt_bandwidth(&def_rt_bandwidth);
 }
 
 static inline
@@ -2912,19 +2903,6 @@ int sched_rt_can_attach(struct task_group *tg, struct task_struct *tsk)
 #ifdef CONFIG_SYSCTL
 static int sched_rt_global_constraints(void)
 {
-	unsigned long flags;
-	int i;
-
-	raw_spin_lock_irqsave(&def_rt_bandwidth.rt_runtime_lock, flags);
-	for_each_possible_cpu(i) {
-		struct rt_rq *rt_rq = &cpu_rq(i)->rt;
-
-		raw_spin_lock(&rt_rq->rt_runtime_lock);
-		rt_rq->rt_runtime = global_rt_runtime();
-		raw_spin_unlock(&rt_rq->rt_runtime_lock);
-	}
-	raw_spin_unlock_irqrestore(&def_rt_bandwidth.rt_runtime_lock, flags);
-
 	return 0;
 }
 #endif /* CONFIG_SYSCTL */
@@ -2944,12 +2922,6 @@ static int sched_rt_global_validate(void)
 
 static void sched_rt_do_global(void)
 {
-	unsigned long flags;
-
-	raw_spin_lock_irqsave(&def_rt_bandwidth.rt_runtime_lock, flags);
-	def_rt_bandwidth.rt_runtime = global_rt_runtime();
-	def_rt_bandwidth.rt_period = ns_to_ktime(global_rt_period());
-	raw_spin_unlock_irqrestore(&def_rt_bandwidth.rt_runtime_lock, flags);
 }
 
 static int sched_rt_handler(const struct ctl_table *table, int write, void *buffer,
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index f7e028b..1e1d1b4 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -729,13 +729,13 @@ struct rt_rq {
 #endif /* CONFIG_SMP */
 	int			rt_queued;
 
+#ifdef CONFIG_RT_GROUP_SCHED
 	int			rt_throttled;
 	u64			rt_time;
 	u64			rt_runtime;
 	/* Nests inside the rq lock: */
 	raw_spinlock_t		rt_runtime_lock;
 
-#ifdef CONFIG_RT_GROUP_SCHED
 	unsigned int		rt_nr_boosted;
 
 	struct rq		*rq;
@@ -2519,7 +2519,6 @@ extern void reweight_task(struct task_struct *p, const struct load_weight *lw);
 extern void resched_curr(struct rq *rq);
 extern void resched_cpu(int cpu);
 
-extern struct rt_bandwidth def_rt_bandwidth;
 extern void init_rt_bandwidth(struct rt_bandwidth *rt_b, u64 period, u64 runtime);
 extern bool sched_rt_bandwidth_account(struct rt_rq *rt_rq);
 

