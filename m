Return-Path: <linux-tip-commits+bounces-1794-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 225DC93F2CF
	for <lists+linux-tip-commits@lfdr.de>; Mon, 29 Jul 2024 12:34:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 98F3E1F22AE0
	for <lists+linux-tip-commits@lfdr.de>; Mon, 29 Jul 2024 10:34:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3941145346;
	Mon, 29 Jul 2024 10:34:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="W//XaMmO";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="5E8uy83x"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2AFF1448F3;
	Mon, 29 Jul 2024 10:34:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722249248; cv=none; b=cy6idyFr6a/BAYA4l89SWftdZ0q72CEnmXr7DM9hgHCMRETVL1uHZdrhLaGI+sdyh4nwJmfzXGanoMTnSMVgoEdRo/1bVLg9ZHXvAhBRcT3nr5n9bWY9G75qogFRv1p9leo4KCKwYvf539Cls4/ROy0UISF+S0rT1PiwsYPlC+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722249248; c=relaxed/simple;
	bh=YICC0EdxUtmC3LTz6AASi3KddQQocdD9N1HyqB0o9Sg=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=BYbeo4z++tJhb/Ke+whVTnjBEQb94zZy6QQ/VHvk1HRF/Snf/PhLSMbBMeLCMRGta4fGo2qC3tgQzddyB18SEEgBOlZTFNm5b9VNHZV6ziSp5SAM7HUR5QpQDejKRLo2R2ATvWFP6X9v9J/nSpjZDYVVVrwVQG3AEdASu5pTvfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=W//XaMmO; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=5E8uy83x; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 29 Jul 2024 10:34:04 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1722249244;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sIfvDqP80s6nYTtuMBzFE6Ka4elOoQckFV3A4OniDdQ=;
	b=W//XaMmONhNxf8f/uRfk8SY+i4GOZFvA4s5PWo+H3XQg/BEC3AelAG9UGhC0/wCxHZ5UVO
	mNgQUrrY6zCGiCy12p7JnfxnntVRNGqOWToQIWHVZ4XE09GNHpCKsxlelY1yUj7xbafwVS
	CS48aq3sp3y05tBpO/ywx8ivqqCySwSenK1XxVzFgC7io8e1VT0G6t2fT8p0OZQNG61Lvo
	7418xHeHmUhlgV/+vwlHfuYSCexEbE4dICNRVhhrF7odzvKga7G7XEFTHEdGXM02JscbNT
	0yfrYkzYxdQcortaqmf8pacz1VJ+5l8CE6ZaJdIxFyzd8+xm0Am0u2eB0kY3WQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1722249244;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sIfvDqP80s6nYTtuMBzFE6Ka4elOoQckFV3A4OniDdQ=;
	b=5E8uy83xYsJ7Srl/uqkF90ghDKrYHWq7EPH/qAYwpjDJx37TdaqfxBITN0UvLD/nrQNp+l
	4HPyjoxwRZ0Xb3CQ==
From: "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/fair: Add trivial fair server
Cc: "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Daniel Bristot de Oliveira <bristot@kernel.org>,
 Juri Lelli <juri.lelli@redhat.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To:
 <b6b0bcefaf25391bcf5b6ecdb9f1218de402d42e.1716811044.git.bristot@kernel.org>
References:
 <b6b0bcefaf25391bcf5b6ecdb9f1218de402d42e.1716811044.git.bristot@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172224924449.2215.14087360548232857166.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     557a6bfc662c4d560f909b78adb1270c9862efa8
Gitweb:        https://git.kernel.org/tip/557a6bfc662c4d560f909b78adb1270c9862efa8
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Mon, 27 May 2024 14:06:50 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 29 Jul 2024 12:22:36 +02:00

sched/fair: Add trivial fair server

Use deadline servers to service fair tasks.

This patch adds a fair_server deadline entity which acts as a container
for fair entities and can be used to fix starvation when higher priority
(wrt fair) tasks are monopolizing CPU(s).

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Daniel Bristot de Oliveira <bristot@kernel.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Tested-by: Juri Lelli <juri.lelli@redhat.com>
Link: https://lore.kernel.org/r/b6b0bcefaf25391bcf5b6ecdb9f1218de402d42e.1716811044.git.bristot@kernel.org
---
 kernel/sched/core.c     |  1 +
 kernel/sched/deadline.c | 23 +++++++++++++++++++++++
 kernel/sched/fair.c     | 34 ++++++++++++++++++++++++++++++++++
 kernel/sched/sched.h    |  4 ++++
 4 files changed, 62 insertions(+)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 1074ae8..f95600c 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -8336,6 +8336,7 @@ void __init sched_init(void)
 #endif /* CONFIG_SMP */
 		hrtick_rq_init(rq);
 		atomic_set(&rq->nr_iowait, 0);
+		fair_server_init(rq);
 
 #ifdef CONFIG_SCHED_CORE
 		rq->core = rq;
diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index f59e5c1..f5b5313 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -1382,6 +1382,13 @@ throttle:
 	}
 
 	/*
+	 * The fair server (sole dl_server) does not account for real-time
+	 * workload because it is running fair work.
+	 */
+	if (dl_se == &rq->fair_server)
+		return;
+
+	/*
 	 * Because -- for now -- we share the rt bandwidth, we need to
 	 * account our runtime there too, otherwise actual rt tasks
 	 * would be able to exceed the shared quota.
@@ -1414,15 +1421,31 @@ void dl_server_update(struct sched_dl_entity *dl_se, s64 delta_exec)
 
 void dl_server_start(struct sched_dl_entity *dl_se)
 {
+	struct rq *rq = dl_se->rq;
+
 	if (!dl_server(dl_se)) {
+		/* Disabled */
+		dl_se->dl_runtime = 0;
+		dl_se->dl_deadline = 1000 * NSEC_PER_MSEC;
+		dl_se->dl_period = 1000 * NSEC_PER_MSEC;
+
 		dl_se->dl_server = 1;
 		setup_new_dl_entity(dl_se);
 	}
+
+	if (!dl_se->dl_runtime)
+		return;
+
 	enqueue_dl_entity(dl_se, ENQUEUE_WAKEUP);
+	if (!dl_task(dl_se->rq->curr) || dl_entity_preempt(dl_se, &rq->curr->dl))
+		resched_curr(dl_se->rq);
 }
 
 void dl_server_stop(struct sched_dl_entity *dl_se)
 {
+	if (!dl_se->dl_runtime)
+		return;
+
 	dequeue_dl_entity(dl_se, DEQUEUE_SLEEP);
 }
 
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 99c80ab..aba23b0 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -5765,6 +5765,7 @@ static bool throttle_cfs_rq(struct cfs_rq *cfs_rq)
 	struct cfs_bandwidth *cfs_b = tg_cfs_bandwidth(cfs_rq->tg);
 	struct sched_entity *se;
 	long task_delta, idle_task_delta, dequeue = 1;
+	long rq_h_nr_running = rq->cfs.h_nr_running;
 
 	raw_spin_lock(&cfs_b->lock);
 	/* This will start the period timer if necessary */
@@ -5837,6 +5838,9 @@ static bool throttle_cfs_rq(struct cfs_rq *cfs_rq)
 	sub_nr_running(rq, task_delta);
 
 done:
+	/* Stop the fair server if throttling resulted in no runnable tasks */
+	if (rq_h_nr_running && !rq->cfs.h_nr_running)
+		dl_server_stop(&rq->fair_server);
 	/*
 	 * Note: distribution will already see us throttled via the
 	 * throttled-list.  rq->lock protects completion.
@@ -5854,6 +5858,7 @@ void unthrottle_cfs_rq(struct cfs_rq *cfs_rq)
 	struct cfs_bandwidth *cfs_b = tg_cfs_bandwidth(cfs_rq->tg);
 	struct sched_entity *se;
 	long task_delta, idle_task_delta;
+	long rq_h_nr_running = rq->cfs.h_nr_running;
 
 	se = cfs_rq->tg->se[cpu_of(rq)];
 
@@ -5929,6 +5934,10 @@ void unthrottle_cfs_rq(struct cfs_rq *cfs_rq)
 unthrottle_throttle:
 	assert_list_leaf_cfs_rq(rq);
 
+	/* Start the fair server if un-throttling resulted in new runnable tasks */
+	if (!rq_h_nr_running && rq->cfs.h_nr_running)
+		dl_server_start(&rq->fair_server);
+
 	/* Determine whether we need to wake up potentially idle CPU: */
 	if (rq->curr == rq->idle && rq->cfs.nr_running)
 		resched_curr(rq);
@@ -6759,6 +6768,9 @@ enqueue_task_fair(struct rq *rq, struct task_struct *p, int flags)
 	 */
 	util_est_enqueue(&rq->cfs, p);
 
+	if (!throttled_hierarchy(task_cfs_rq(p)) && !rq->cfs.h_nr_running)
+		dl_server_start(&rq->fair_server);
+
 	/*
 	 * If in_iowait is set, the code below may not trigger any cpufreq
 	 * utilization updates, so do it here explicitly with the IOWAIT flag
@@ -6903,6 +6915,9 @@ static void dequeue_task_fair(struct rq *rq, struct task_struct *p, int flags)
 		rq->next_balance = jiffies;
 
 dequeue_throttle:
+	if (!throttled_hierarchy(task_cfs_rq(p)) && !rq->cfs.h_nr_running)
+		dl_server_stop(&rq->fair_server);
+
 	util_est_update(&rq->cfs, p, task_sleep);
 	hrtick_update(rq);
 }
@@ -8602,6 +8617,25 @@ static struct task_struct *__pick_next_task_fair(struct rq *rq)
 	return pick_next_task_fair(rq, NULL, NULL);
 }
 
+static bool fair_server_has_tasks(struct sched_dl_entity *dl_se)
+{
+	return !!dl_se->rq->cfs.nr_running;
+}
+
+static struct task_struct *fair_server_pick(struct sched_dl_entity *dl_se)
+{
+	return pick_next_task_fair(dl_se->rq, NULL, NULL);
+}
+
+void fair_server_init(struct rq *rq)
+{
+	struct sched_dl_entity *dl_se = &rq->fair_server;
+
+	init_dl_entity(dl_se);
+
+	dl_server_init(dl_se, rq, fair_server_has_tasks, fair_server_pick);
+}
+
 /*
  * Account for a descheduled task:
  */
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 8a07102..7416bcd 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -363,6 +363,8 @@ extern void dl_server_init(struct sched_dl_entity *dl_se, struct rq *rq,
 		    dl_server_has_tasks_f has_tasks,
 		    dl_server_pick_f pick);
 
+extern void fair_server_init(struct rq *rq);
+
 #ifdef CONFIG_CGROUP_SCHED
 
 extern struct list_head task_groups;
@@ -1039,6 +1041,8 @@ struct rq {
 	struct rt_rq		rt;
 	struct dl_rq		dl;
 
+	struct sched_dl_entity	fair_server;
+
 #ifdef CONFIG_FAIR_GROUP_SCHED
 	/* list of leaf cfs_rq on this CPU: */
 	struct list_head	leaf_cfs_rq_list;

