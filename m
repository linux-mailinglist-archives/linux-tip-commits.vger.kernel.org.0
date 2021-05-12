Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F9F537BA61
	for <lists+linux-tip-commits@lfdr.de>; Wed, 12 May 2021 12:28:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230388AbhELK3g (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 12 May 2021 06:29:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230357AbhELK3e (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 12 May 2021 06:29:34 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D1FBC06174A;
        Wed, 12 May 2021 03:28:26 -0700 (PDT)
Date:   Wed, 12 May 2021 10:28:23 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1620815304;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=teDgoqbbyHPBFSFxf5VmvnJDjavswgCwPqLiKnvqnNk=;
        b=jZIefxli097OnCxZCPJ+ntIWVZrkDsSABEomBpnBklcl+/7tSF9fytaAFOcY6IEWWGcXD+
        gR56gUqMBkAiEO8WXazysOOiGl1j4LwHtSm+scqL4lgY5NHH3zw8q98NEc7ygeIoq1ZhQa
        17x6wRhhz593jG2Is9cL6j2k5amlGMJ4t5shMZqGcUUB4H/BG+xB4FyGWRvKWQ2a6v1QLD
        cVBWGjYk7HjVCKmiJaxSEcawpr1LW+4EzobTzi988u8ZKaswxY8v2EEyC23PWvhZLUhleo
        DspMEyImOWf29AlHwz1YeZ9cVma6bFGoNmmMAgRHgzMAZvQs9kktnpy0O86SRg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1620815304;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=teDgoqbbyHPBFSFxf5VmvnJDjavswgCwPqLiKnvqnNk=;
        b=YDUSTIcx/ntGW4pJ6iOWhqtxm3XRBzTzDDrFITSz9SyorqYUWK/42qcL9pzqb/PTPENzdD
        qdojEovpjZ5oowDg==
From:   "tip-bot2 for Vineeth Pillai" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/fair: Fix forced idle sibling starvation corner case
Cc:     Vineeth Pillai <viremana@linux.microsoft.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Don Hiatt <dhiatt@digitalocean.com>,
        Hongyu Ning <hongyu.ning@linux.intel.com>,
        Vincent Guittot <vincent.guittot@linaro.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210422123308.617407840@infradead.org>
References: <20210422123308.617407840@infradead.org>
MIME-Version: 1.0
Message-ID: <162081530396.29796.6078425028359112311.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     8039e96fcc1de30d5bcaf05da9ca2de46a800826
Gitweb:        https://git.kernel.org/tip/8039e96fcc1de30d5bcaf05da9ca2de46a800826
Author:        Vineeth Pillai <viremana@linux.microsoft.com>
AuthorDate:    Tue, 17 Nov 2020 18:19:38 -05:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 12 May 2021 11:43:29 +02:00

sched/fair: Fix forced idle sibling starvation corner case

If there is only one long running local task and the sibling is
forced idle, it  might not get a chance to run until a schedule
event happens on any cpu in the core.

So we check for this condition during a tick to see if a sibling
is starved and then give it a chance to schedule.

Signed-off-by: Vineeth Pillai <viremana@linux.microsoft.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Tested-by: Don Hiatt <dhiatt@digitalocean.com>
Tested-by: Hongyu Ning <hongyu.ning@linux.intel.com>
Tested-by: Vincent Guittot <vincent.guittot@linaro.org>
Link: https://lkml.kernel.org/r/20210422123308.617407840@infradead.org
---
 kernel/sched/core.c  | 15 ++++++++-------
 kernel/sched/fair.c  | 40 ++++++++++++++++++++++++++++++++++++++++
 kernel/sched/sched.h |  2 +-
 3 files changed, 49 insertions(+), 8 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index db763f4..f5e1e6f 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -5459,16 +5459,15 @@ pick_next_task(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
 
 	/* reset state */
 	rq->core->core_cookie = 0UL;
+	if (rq->core->core_forceidle) {
+		need_sync = true;
+		rq->core->core_forceidle = false;
+	}
 	for_each_cpu(i, smt_mask) {
 		struct rq *rq_i = cpu_rq(i);
 
 		rq_i->core_pick = NULL;
 
-		if (rq_i->core_forceidle) {
-			need_sync = true;
-			rq_i->core_forceidle = false;
-		}
-
 		if (i != cpu)
 			update_rq_clock(rq_i);
 	}
@@ -5588,8 +5587,10 @@ next_class:;
 		if (!rq_i->core_pick)
 			continue;
 
-		if (is_task_rq_idle(rq_i->core_pick) && rq_i->nr_running)
-			rq_i->core_forceidle = true;
+		if (is_task_rq_idle(rq_i->core_pick) && rq_i->nr_running &&
+		    !rq_i->core->core_forceidle) {
+			rq_i->core->core_forceidle = true;
+		}
 
 		if (i == cpu) {
 			rq_i->core_pick = NULL;
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 08be7a2..4d1ecab 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -10767,6 +10767,44 @@ static void rq_offline_fair(struct rq *rq)
 
 #endif /* CONFIG_SMP */
 
+#ifdef CONFIG_SCHED_CORE
+static inline bool
+__entity_slice_used(struct sched_entity *se, int min_nr_tasks)
+{
+	u64 slice = sched_slice(cfs_rq_of(se), se);
+	u64 rtime = se->sum_exec_runtime - se->prev_sum_exec_runtime;
+
+	return (rtime * min_nr_tasks > slice);
+}
+
+#define MIN_NR_TASKS_DURING_FORCEIDLE	2
+static inline void task_tick_core(struct rq *rq, struct task_struct *curr)
+{
+	if (!sched_core_enabled(rq))
+		return;
+
+	/*
+	 * If runqueue has only one task which used up its slice and
+	 * if the sibling is forced idle, then trigger schedule to
+	 * give forced idle task a chance.
+	 *
+	 * sched_slice() considers only this active rq and it gets the
+	 * whole slice. But during force idle, we have siblings acting
+	 * like a single runqueue and hence we need to consider runnable
+	 * tasks on this cpu and the forced idle cpu. Ideally, we should
+	 * go through the forced idle rq, but that would be a perf hit.
+	 * We can assume that the forced idle cpu has atleast
+	 * MIN_NR_TASKS_DURING_FORCEIDLE - 1 tasks and use that to check
+	 * if we need to give up the cpu.
+	 */
+	if (rq->core->core_forceidle && rq->cfs.nr_running == 1 &&
+	    __entity_slice_used(&curr->se, MIN_NR_TASKS_DURING_FORCEIDLE))
+		resched_curr(rq);
+}
+#else
+static inline void task_tick_core(struct rq *rq, struct task_struct *curr) {}
+#endif
+
 /*
  * scheduler tick hitting a task of our scheduling class.
  *
@@ -10790,6 +10828,8 @@ static void task_tick_fair(struct rq *rq, struct task_struct *curr, int queued)
 
 	update_misfit_status(curr, rq);
 	update_overutilized_status(task_rq(curr));
+
+	task_tick_core(rq, curr);
 }
 
 /*
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index dd44a31..db55514 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -1083,12 +1083,12 @@ struct rq {
 	unsigned int		core_enabled;
 	unsigned int		core_sched_seq;
 	struct rb_root		core_tree;
-	unsigned char		core_forceidle;
 
 	/* shared state */
 	unsigned int		core_task_seq;
 	unsigned int		core_pick_seq;
 	unsigned long		core_cookie;
+	unsigned char		core_forceidle;
 #endif
 };
 
