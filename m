Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE7222F6017
	for <lists+linux-tip-commits@lfdr.de>; Thu, 14 Jan 2021 12:31:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726984AbhANLbC (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Thu, 14 Jan 2021 06:31:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727967AbhANLaW (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Thu, 14 Jan 2021 06:30:22 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EB40C061786;
        Thu, 14 Jan 2021 03:29:08 -0800 (PST)
Date:   Thu, 14 Jan 2021 11:29:06 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1610623746;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=P+cdyo6L9objzX/ld2AADn9MmuuOJQmG6rTY9Evb4/A=;
        b=xUz0Ywab9PxwmPNBEyUYvLJDgIIoR18FLZJpdOWjtDgrKCrDCLl6n11M6zMpqrqoNAAD1a
        yZHfNwjrxyY5PY7WmL2J6cf67Sz8+zG/g+kUCwBNkGI2XnBU3thDavogRMBul2MwVaFsHv
        4uhayLa8vnLic8c0DsfiPhhCPJmae57LsdLu0r4DnvBSPqAnBMYqF8mwA0XIXBVriLwNV0
        q1n7dycljNALh9Hd0JKQXAdI92RIXNkWerc0e/g3be6RiZ23t+XC0kpWXsv/yLqVkvC/dF
        uhiNwicBNCzXi76ctM0vvoX2vodXE9XrSPl6L7JBdDginEFVmMjLQtHiQNckkg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1610623746;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=P+cdyo6L9objzX/ld2AADn9MmuuOJQmG6rTY9Evb4/A=;
        b=J3BjJCtYIkCLoGHe/YVlEnGNJOpycwkHfyGeSVrebKRWTr6W5JZ9dbrLB7w8GOXX3slzCj
        z+BDOp7ZCMsIW9Dg==
From:   "tip-bot2 for Xuewen Yan" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/fair: Avoid stale CPU util_est value for
 schedutil in task dequeue
Cc:     Xuewen Yan <xuewen.yan@unisoc.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Vincent Guittot <vincent.guittot@linaro.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <1608283672-18240-1-git-send-email-xuewen.yan94@gmail.com>
References: <1608283672-18240-1-git-send-email-xuewen.yan94@gmail.com>
MIME-Version: 1.0
Message-ID: <161062374634.414.4052128476465595493.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     8c1f560c1ea3f19e22ba356f62680d9d449c9ec2
Gitweb:        https://git.kernel.org/tip/8c1f560c1ea3f19e22ba356f62680d9d449c9ec2
Author:        Xuewen Yan <xuewen.yan@unisoc.com>
AuthorDate:    Fri, 18 Dec 2020 17:27:52 +08:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Thu, 14 Jan 2021 11:20:10 +01:00

sched/fair: Avoid stale CPU util_est value for schedutil in task dequeue

CPU (root cfs_rq) estimated utilization (util_est) is currently used in
dequeue_task_fair() to drive frequency selection before it is updated.

with:

CPU_util        : rq->cfs.avg.util_avg
CPU_util_est    : rq->cfs.avg.util_est
CPU_utilization : max(CPU_util, CPU_util_est)
task_util       : p->se.avg.util_avg
task_util_est   : p->se.avg.util_est

dequeue_task_fair():

    /* (1) CPU_util and task_util update + inform schedutil about
           CPU_utilization changes */
    for_each_sched_entity() /* 2 loops */
        (dequeue_entity() ->) update_load_avg() -> cfs_rq_util_change()
         -> cpufreq_update_util() ->...-> sugov_update_[shared\|single]
         -> sugov_get_util() -> cpu_util_cfs()

    /* (2) CPU_util_est and task_util_est update */
    util_est_dequeue()

cpu_util_cfs() uses CPU_utilization which could lead to a false (too
high) utilization value for schedutil in task ramp-down or ramp-up
scenarios during task dequeue.

To mitigate the issue split the util_est update (2) into:

 (A) CPU_util_est update in util_est_dequeue()
 (B) task_util_est update in util_est_update()

Place (A) before (1) and keep (B) where (2) is. The latter is necessary
since (B) relies on task_util update in (1).

Fixes: 7f65ea42eb00 ("sched/fair: Add util_est on top of PELT")
Signed-off-by: Xuewen Yan <xuewen.yan@unisoc.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
Reviewed-by: Vincent Guittot <vincent.guittot@linaro.org>
Link: https://lkml.kernel.org/r/1608283672-18240-1-git-send-email-xuewen.yan94@gmail.com
---
 kernel/sched/fair.c | 43 ++++++++++++++++++++++++++++---------------
 1 file changed, 28 insertions(+), 15 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 389cb58..40d3ebf 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -3943,6 +3943,22 @@ static inline void util_est_enqueue(struct cfs_rq *cfs_rq,
 	trace_sched_util_est_cfs_tp(cfs_rq);
 }
 
+static inline void util_est_dequeue(struct cfs_rq *cfs_rq,
+				    struct task_struct *p)
+{
+	unsigned int enqueued;
+
+	if (!sched_feat(UTIL_EST))
+		return;
+
+	/* Update root cfs_rq's estimated utilization */
+	enqueued  = cfs_rq->avg.util_est.enqueued;
+	enqueued -= min_t(unsigned int, enqueued, _task_util_est(p));
+	WRITE_ONCE(cfs_rq->avg.util_est.enqueued, enqueued);
+
+	trace_sched_util_est_cfs_tp(cfs_rq);
+}
+
 /*
  * Check if a (signed) value is within a specified (unsigned) margin,
  * based on the observation that:
@@ -3956,23 +3972,16 @@ static inline bool within_margin(int value, int margin)
 	return ((unsigned int)(value + margin - 1) < (2 * margin - 1));
 }
 
-static void
-util_est_dequeue(struct cfs_rq *cfs_rq, struct task_struct *p, bool task_sleep)
+static inline void util_est_update(struct cfs_rq *cfs_rq,
+				   struct task_struct *p,
+				   bool task_sleep)
 {
 	long last_ewma_diff;
 	struct util_est ue;
-	int cpu;
 
 	if (!sched_feat(UTIL_EST))
 		return;
 
-	/* Update root cfs_rq's estimated utilization */
-	ue.enqueued  = cfs_rq->avg.util_est.enqueued;
-	ue.enqueued -= min_t(unsigned int, ue.enqueued, _task_util_est(p));
-	WRITE_ONCE(cfs_rq->avg.util_est.enqueued, ue.enqueued);
-
-	trace_sched_util_est_cfs_tp(cfs_rq);
-
 	/*
 	 * Skip update of task's estimated utilization when the task has not
 	 * yet completed an activation, e.g. being migrated.
@@ -4012,8 +4021,7 @@ util_est_dequeue(struct cfs_rq *cfs_rq, struct task_struct *p, bool task_sleep)
 	 * To avoid overestimation of actual task utilization, skip updates if
 	 * we cannot grant there is idle time in this CPU.
 	 */
-	cpu = cpu_of(rq_of(cfs_rq));
-	if (task_util(p) > capacity_orig_of(cpu))
+	if (task_util(p) > capacity_orig_of(cpu_of(rq_of(cfs_rq))))
 		return;
 
 	/*
@@ -4096,8 +4104,11 @@ static inline void
 util_est_enqueue(struct cfs_rq *cfs_rq, struct task_struct *p) {}
 
 static inline void
-util_est_dequeue(struct cfs_rq *cfs_rq, struct task_struct *p,
-		 bool task_sleep) {}
+util_est_dequeue(struct cfs_rq *cfs_rq, struct task_struct *p) {}
+
+static inline void
+util_est_update(struct cfs_rq *cfs_rq, struct task_struct *p,
+		bool task_sleep) {}
 static inline void update_misfit_status(struct task_struct *p, struct rq *rq) {}
 
 #endif /* CONFIG_SMP */
@@ -5609,6 +5620,8 @@ static void dequeue_task_fair(struct rq *rq, struct task_struct *p, int flags)
 	int idle_h_nr_running = task_has_idle_policy(p);
 	bool was_sched_idle = sched_idle_rq(rq);
 
+	util_est_dequeue(&rq->cfs, p);
+
 	for_each_sched_entity(se) {
 		cfs_rq = cfs_rq_of(se);
 		dequeue_entity(cfs_rq, se, flags);
@@ -5659,7 +5672,7 @@ static void dequeue_task_fair(struct rq *rq, struct task_struct *p, int flags)
 		rq->next_balance = jiffies;
 
 dequeue_throttle:
-	util_est_dequeue(&rq->cfs, p, task_sleep);
+	util_est_update(&rq->cfs, p, task_sleep);
 	hrtick_update(rq);
 }
 
