Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D98D3F4775
	for <lists+linux-tip-commits@lfdr.de>; Mon, 23 Aug 2021 11:26:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235918AbhHWJ1N (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Mon, 23 Aug 2021 05:27:13 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:39068 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235925AbhHWJ1K (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Mon, 23 Aug 2021 05:27:10 -0400
Date:   Mon, 23 Aug 2021 09:26:26 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1629710787;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=eF7+H43DdgngmHRDe3JrMOEx0KxRqQhOKahTjLDxbO4=;
        b=nDOzA6UtIxIMY0rtzC3DecIXDp12bFRPinLzlzCCI8Llj07yINCnyZRNfzLVVwhoXcSphu
        CJK7+S32aMP3nc+g747Fuc7M2urPFyLp0P7lOf4w5FHeVmBULVVbDTpdrPkkddmnqVbsNh
        Qh2uWGAWnBpwX2AXoapBheeEDHl4uZvYzNeGGfDG+/wec79Ekwt4pCK0ZsQv2rYA1jbQlo
        vCd20e6p7fFHa4afIaS5uR/EZyIfBJk5sAktaS/sy3MyMQtSuBxR3Q/NU1yhsvmhlZYI5H
        RQmzna2wP1P+lySWeZbVf74Sz2zvfJUPX3Gz5j1RvVBwgikcCBbFIsgvu9Uqgg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1629710787;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=eF7+H43DdgngmHRDe3JrMOEx0KxRqQhOKahTjLDxbO4=;
        b=TZW/OdoQ2KE9NLqG9ga7cs9gUJKOTPCjhIJGyK46/5/eLe58cfFSoz7EDUOYUaGnRh6R/L
        od4k3VvMJbQK3mDw==
From:   "tip-bot2 for Josh Don" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched: Cgroup SCHED_IDLE support
Cc:     Josh Don <joshdon@google.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210730020019.1487127-2-joshdon@google.com>
References: <20210730020019.1487127-2-joshdon@google.com>
MIME-Version: 1.0
Message-ID: <162971078674.25758.15464079371945307825.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     304000390f88d049c85e9a0958ac5567f38816ee
Gitweb:        https://git.kernel.org/tip/304000390f88d049c85e9a0958ac5567f38816ee
Author:        Josh Don <joshdon@google.com>
AuthorDate:    Thu, 29 Jul 2021 19:00:18 -07:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 20 Aug 2021 12:32:58 +02:00

sched: Cgroup SCHED_IDLE support

This extends SCHED_IDLE to cgroups.

Interface: cgroup/cpu.idle.
 0: default behavior
 1: SCHED_IDLE

Extending SCHED_IDLE to cgroups means that we incorporate the existing
aspects of SCHED_IDLE; a SCHED_IDLE cgroup will count all of its
descendant threads towards the idle_h_nr_running count of all of its
ancestor cgroups. Thus, sched_idle_rq() will work properly.
Additionally, SCHED_IDLE cgroups are configured with minimum weight.

There are two key differences between the per-task and per-cgroup
SCHED_IDLE interface:

  - The cgroup interface allows tasks within a SCHED_IDLE hierarchy to
    maintain their relative weights. The entity that is "idle" is the
    cgroup, not the tasks themselves.

  - Since the idle entity is the cgroup, our SCHED_IDLE wakeup preemption
    decision is not made by comparing the current task with the woken
    task, but rather by comparing their matching sched_entity.

A typical use-case for this is a user that creates an idle and a
non-idle subtree. The non-idle subtree will dominate competition vs
the idle subtree, but the idle subtree will still be high priority vs
other users on the system. The latter is accomplished via comparing
matching sched_entity in the waken preemption path (this could also be
improved by making the sched_idle_rq() decision dependent on the
perspective of a specific task).

For now, we maintain the existing SCHED_IDLE semantics. Future patches
may make improvements that extend how we treat SCHED_IDLE entities.

The per-task_group idle field is an integer that currently only holds
either a 0 or a 1. This is explicitly typed as an integer to allow for
further extensions to this API. For example, a negative value may
indicate a highly latency-sensitive cgroup that should be preferred
for preemption/placement/etc.

Signed-off-by: Josh Don <joshdon@google.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Vincent Guittot <vincent.guittot@linaro.org>
Link: https://lore.kernel.org/r/20210730020019.1487127-2-joshdon@google.com
---
 kernel/sched/core.c  |  25 +++++-
 kernel/sched/debug.c |   3 +-
 kernel/sched/fair.c  | 197 ++++++++++++++++++++++++++++++++++++------
 kernel/sched/sched.h |   8 ++-
 4 files changed, 208 insertions(+), 25 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index d67c5dd..7fa6ce7 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -10135,6 +10135,20 @@ static u64 cpu_rt_period_read_uint(struct cgroup_subsys_state *css,
 }
 #endif /* CONFIG_RT_GROUP_SCHED */
 
+#ifdef CONFIG_FAIR_GROUP_SCHED
+static s64 cpu_idle_read_s64(struct cgroup_subsys_state *css,
+			       struct cftype *cft)
+{
+	return css_tg(css)->idle;
+}
+
+static int cpu_idle_write_s64(struct cgroup_subsys_state *css,
+				struct cftype *cft, s64 idle)
+{
+	return sched_group_set_idle(css_tg(css), idle);
+}
+#endif
+
 static struct cftype cpu_legacy_files[] = {
 #ifdef CONFIG_FAIR_GROUP_SCHED
 	{
@@ -10142,6 +10156,11 @@ static struct cftype cpu_legacy_files[] = {
 		.read_u64 = cpu_shares_read_u64,
 		.write_u64 = cpu_shares_write_u64,
 	},
+	{
+		.name = "idle",
+		.read_s64 = cpu_idle_read_s64,
+		.write_s64 = cpu_idle_write_s64,
+	},
 #endif
 #ifdef CONFIG_CFS_BANDWIDTH
 	{
@@ -10349,6 +10368,12 @@ static struct cftype cpu_files[] = {
 		.read_s64 = cpu_weight_nice_read_s64,
 		.write_s64 = cpu_weight_nice_write_s64,
 	},
+	{
+		.name = "idle",
+		.flags = CFTYPE_NOT_ON_ROOT,
+		.read_s64 = cpu_idle_read_s64,
+		.write_s64 = cpu_idle_write_s64,
+	},
 #endif
 #ifdef CONFIG_CFS_BANDWIDTH
 	{
diff --git a/kernel/sched/debug.c b/kernel/sched/debug.c
index 7e08e3d..4971622 100644
--- a/kernel/sched/debug.c
+++ b/kernel/sched/debug.c
@@ -607,6 +607,9 @@ void print_cfs_rq(struct seq_file *m, int cpu, struct cfs_rq *cfs_rq)
 	SEQ_printf(m, "  .%-30s: %d\n", "nr_spread_over",
 			cfs_rq->nr_spread_over);
 	SEQ_printf(m, "  .%-30s: %d\n", "nr_running", cfs_rq->nr_running);
+	SEQ_printf(m, "  .%-30s: %d\n", "h_nr_running", cfs_rq->h_nr_running);
+	SEQ_printf(m, "  .%-30s: %d\n", "idle_h_nr_running",
+			cfs_rq->idle_h_nr_running);
 	SEQ_printf(m, "  .%-30s: %ld\n", "load", cfs_rq->load.weight);
 #ifdef CONFIG_SMP
 	SEQ_printf(m, "  .%-30s: %lu\n", "load_avg",
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 47a0fbf..6cd05f1 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -431,6 +431,23 @@ find_matching_se(struct sched_entity **se, struct sched_entity **pse)
 	}
 }
 
+static int tg_is_idle(struct task_group *tg)
+{
+	return tg->idle > 0;
+}
+
+static int cfs_rq_is_idle(struct cfs_rq *cfs_rq)
+{
+	return cfs_rq->idle > 0;
+}
+
+static int se_is_idle(struct sched_entity *se)
+{
+	if (entity_is_task(se))
+		return task_has_idle_policy(task_of(se));
+	return cfs_rq_is_idle(group_cfs_rq(se));
+}
+
 #else	/* !CONFIG_FAIR_GROUP_SCHED */
 
 #define for_each_sched_entity(se) \
@@ -468,6 +485,21 @@ find_matching_se(struct sched_entity **se, struct sched_entity **pse)
 {
 }
 
+static int tg_is_idle(struct task_group *tg)
+{
+	return 0;
+}
+
+static int cfs_rq_is_idle(struct cfs_rq *cfs_rq)
+{
+	return 0;
+}
+
+static int se_is_idle(struct sched_entity *se)
+{
+	return 0;
+}
+
 #endif	/* CONFIG_FAIR_GROUP_SCHED */
 
 static __always_inline
@@ -4812,6 +4844,9 @@ static bool throttle_cfs_rq(struct cfs_rq *cfs_rq)
 
 		dequeue_entity(qcfs_rq, se, DEQUEUE_SLEEP);
 
+		if (cfs_rq_is_idle(group_cfs_rq(se)))
+			idle_task_delta = cfs_rq->h_nr_running;
+
 		qcfs_rq->h_nr_running -= task_delta;
 		qcfs_rq->idle_h_nr_running -= idle_task_delta;
 
@@ -4831,6 +4866,9 @@ static bool throttle_cfs_rq(struct cfs_rq *cfs_rq)
 		update_load_avg(qcfs_rq, se, 0);
 		se_update_runnable(se);
 
+		if (cfs_rq_is_idle(group_cfs_rq(se)))
+			idle_task_delta = cfs_rq->h_nr_running;
+
 		qcfs_rq->h_nr_running -= task_delta;
 		qcfs_rq->idle_h_nr_running -= idle_task_delta;
 	}
@@ -4875,39 +4913,45 @@ void unthrottle_cfs_rq(struct cfs_rq *cfs_rq)
 	task_delta = cfs_rq->h_nr_running;
 	idle_task_delta = cfs_rq->idle_h_nr_running;
 	for_each_sched_entity(se) {
+		struct cfs_rq *qcfs_rq = cfs_rq_of(se);
+
 		if (se->on_rq)
 			break;
-		cfs_rq = cfs_rq_of(se);
-		enqueue_entity(cfs_rq, se, ENQUEUE_WAKEUP);
+		enqueue_entity(qcfs_rq, se, ENQUEUE_WAKEUP);
+
+		if (cfs_rq_is_idle(group_cfs_rq(se)))
+			idle_task_delta = cfs_rq->h_nr_running;
 
-		cfs_rq->h_nr_running += task_delta;
-		cfs_rq->idle_h_nr_running += idle_task_delta;
+		qcfs_rq->h_nr_running += task_delta;
+		qcfs_rq->idle_h_nr_running += idle_task_delta;
 
 		/* end evaluation on encountering a throttled cfs_rq */
-		if (cfs_rq_throttled(cfs_rq))
+		if (cfs_rq_throttled(qcfs_rq))
 			goto unthrottle_throttle;
 	}
 
 	for_each_sched_entity(se) {
-		cfs_rq = cfs_rq_of(se);
+		struct cfs_rq *qcfs_rq = cfs_rq_of(se);
 
-		update_load_avg(cfs_rq, se, UPDATE_TG);
+		update_load_avg(qcfs_rq, se, UPDATE_TG);
 		se_update_runnable(se);
 
-		cfs_rq->h_nr_running += task_delta;
-		cfs_rq->idle_h_nr_running += idle_task_delta;
+		if (cfs_rq_is_idle(group_cfs_rq(se)))
+			idle_task_delta = cfs_rq->h_nr_running;
 
+		qcfs_rq->h_nr_running += task_delta;
+		qcfs_rq->idle_h_nr_running += idle_task_delta;
 
 		/* end evaluation on encountering a throttled cfs_rq */
-		if (cfs_rq_throttled(cfs_rq))
+		if (cfs_rq_throttled(qcfs_rq))
 			goto unthrottle_throttle;
 
 		/*
 		 * One parent has been throttled and cfs_rq removed from the
 		 * list. Add it back to not break the leaf list.
 		 */
-		if (throttled_hierarchy(cfs_rq))
-			list_add_leaf_cfs_rq(cfs_rq);
+		if (throttled_hierarchy(qcfs_rq))
+			list_add_leaf_cfs_rq(qcfs_rq);
 	}
 
 	/* At this point se is NULL and we are at root level*/
@@ -4920,9 +4964,9 @@ unthrottle_throttle:
 	 * assertion below.
 	 */
 	for_each_sched_entity(se) {
-		cfs_rq = cfs_rq_of(se);
+		struct cfs_rq *qcfs_rq = cfs_rq_of(se);
 
-		if (list_add_leaf_cfs_rq(cfs_rq))
+		if (list_add_leaf_cfs_rq(qcfs_rq))
 			break;
 	}
 
@@ -5545,6 +5589,9 @@ enqueue_task_fair(struct rq *rq, struct task_struct *p, int flags)
 		cfs_rq->h_nr_running++;
 		cfs_rq->idle_h_nr_running += idle_h_nr_running;
 
+		if (cfs_rq_is_idle(cfs_rq))
+			idle_h_nr_running = 1;
+
 		/* end evaluation on encountering a throttled cfs_rq */
 		if (cfs_rq_throttled(cfs_rq))
 			goto enqueue_throttle;
@@ -5562,6 +5609,9 @@ enqueue_task_fair(struct rq *rq, struct task_struct *p, int flags)
 		cfs_rq->h_nr_running++;
 		cfs_rq->idle_h_nr_running += idle_h_nr_running;
 
+		if (cfs_rq_is_idle(cfs_rq))
+			idle_h_nr_running = 1;
+
 		/* end evaluation on encountering a throttled cfs_rq */
 		if (cfs_rq_throttled(cfs_rq))
 			goto enqueue_throttle;
@@ -5639,6 +5689,9 @@ static void dequeue_task_fair(struct rq *rq, struct task_struct *p, int flags)
 		cfs_rq->h_nr_running--;
 		cfs_rq->idle_h_nr_running -= idle_h_nr_running;
 
+		if (cfs_rq_is_idle(cfs_rq))
+			idle_h_nr_running = 1;
+
 		/* end evaluation on encountering a throttled cfs_rq */
 		if (cfs_rq_throttled(cfs_rq))
 			goto dequeue_throttle;
@@ -5668,6 +5721,9 @@ static void dequeue_task_fair(struct rq *rq, struct task_struct *p, int flags)
 		cfs_rq->h_nr_running--;
 		cfs_rq->idle_h_nr_running -= idle_h_nr_running;
 
+		if (cfs_rq_is_idle(cfs_rq))
+			idle_h_nr_running = 1;
+
 		/* end evaluation on encountering a throttled cfs_rq */
 		if (cfs_rq_throttled(cfs_rq))
 			goto dequeue_throttle;
@@ -7010,24 +7066,22 @@ wakeup_preempt_entity(struct sched_entity *curr, struct sched_entity *se)
 
 static void set_last_buddy(struct sched_entity *se)
 {
-	if (entity_is_task(se) && unlikely(task_has_idle_policy(task_of(se))))
-		return;
-
 	for_each_sched_entity(se) {
 		if (SCHED_WARN_ON(!se->on_rq))
 			return;
+		if (se_is_idle(se))
+			return;
 		cfs_rq_of(se)->last = se;
 	}
 }
 
 static void set_next_buddy(struct sched_entity *se)
 {
-	if (entity_is_task(se) && unlikely(task_has_idle_policy(task_of(se))))
-		return;
-
 	for_each_sched_entity(se) {
 		if (SCHED_WARN_ON(!se->on_rq))
 			return;
+		if (se_is_idle(se))
+			return;
 		cfs_rq_of(se)->next = se;
 	}
 }
@@ -7048,6 +7102,7 @@ static void check_preempt_wakeup(struct rq *rq, struct task_struct *p, int wake_
 	struct cfs_rq *cfs_rq = task_cfs_rq(curr);
 	int scale = cfs_rq->nr_running >= sched_nr_latency;
 	int next_buddy_marked = 0;
+	int cse_is_idle, pse_is_idle;
 
 	if (unlikely(se == pse))
 		return;
@@ -7092,8 +7147,21 @@ static void check_preempt_wakeup(struct rq *rq, struct task_struct *p, int wake_
 		return;
 
 	find_matching_se(&se, &pse);
-	update_curr(cfs_rq_of(se));
 	BUG_ON(!pse);
+
+	cse_is_idle = se_is_idle(se);
+	pse_is_idle = se_is_idle(pse);
+
+	/*
+	 * Preempt an idle group in favor of a non-idle group (and don't preempt
+	 * in the inverse case).
+	 */
+	if (cse_is_idle && !pse_is_idle)
+		goto preempt;
+	if (cse_is_idle != pse_is_idle)
+		return;
+
+	update_curr(cfs_rq_of(se));
 	if (wakeup_preempt_entity(se, pse) == 1) {
 		/*
 		 * Bias pick_next to pick the sched entity that is
@@ -11387,10 +11455,12 @@ void init_tg_cfs_entry(struct task_group *tg, struct cfs_rq *cfs_rq,
 
 static DEFINE_MUTEX(shares_mutex);
 
-int sched_group_set_shares(struct task_group *tg, unsigned long shares)
+static int __sched_group_set_shares(struct task_group *tg, unsigned long shares)
 {
 	int i;
 
+	lockdep_assert_held(&shares_mutex);
+
 	/*
 	 * We can't change the weight of the root cgroup.
 	 */
@@ -11399,9 +11469,8 @@ int sched_group_set_shares(struct task_group *tg, unsigned long shares)
 
 	shares = clamp(shares, scale_load(MIN_SHARES), scale_load(MAX_SHARES));
 
-	mutex_lock(&shares_mutex);
 	if (tg->shares == shares)
-		goto done;
+		return 0;
 
 	tg->shares = shares;
 	for_each_possible_cpu(i) {
@@ -11419,10 +11488,88 @@ int sched_group_set_shares(struct task_group *tg, unsigned long shares)
 		rq_unlock_irqrestore(rq, &rf);
 	}
 
-done:
+	return 0;
+}
+
+int sched_group_set_shares(struct task_group *tg, unsigned long shares)
+{
+	int ret;
+
+	mutex_lock(&shares_mutex);
+	if (tg_is_idle(tg))
+		ret = -EINVAL;
+	else
+		ret = __sched_group_set_shares(tg, shares);
+	mutex_unlock(&shares_mutex);
+
+	return ret;
+}
+
+int sched_group_set_idle(struct task_group *tg, long idle)
+{
+	int i;
+
+	if (tg == &root_task_group)
+		return -EINVAL;
+
+	if (idle < 0 || idle > 1)
+		return -EINVAL;
+
+	mutex_lock(&shares_mutex);
+
+	if (tg->idle == idle) {
+		mutex_unlock(&shares_mutex);
+		return 0;
+	}
+
+	tg->idle = idle;
+
+	for_each_possible_cpu(i) {
+		struct rq *rq = cpu_rq(i);
+		struct sched_entity *se = tg->se[i];
+		struct cfs_rq *grp_cfs_rq = tg->cfs_rq[i];
+		bool was_idle = cfs_rq_is_idle(grp_cfs_rq);
+		long idle_task_delta;
+		struct rq_flags rf;
+
+		rq_lock_irqsave(rq, &rf);
+
+		grp_cfs_rq->idle = idle;
+		if (WARN_ON_ONCE(was_idle == cfs_rq_is_idle(grp_cfs_rq)))
+			goto next_cpu;
+
+		idle_task_delta = grp_cfs_rq->h_nr_running -
+				  grp_cfs_rq->idle_h_nr_running;
+		if (!cfs_rq_is_idle(grp_cfs_rq))
+			idle_task_delta *= -1;
+
+		for_each_sched_entity(se) {
+			struct cfs_rq *cfs_rq = cfs_rq_of(se);
+
+			if (!se->on_rq)
+				break;
+
+			cfs_rq->idle_h_nr_running += idle_task_delta;
+
+			/* Already accounted at parent level and above. */
+			if (cfs_rq_is_idle(cfs_rq))
+				break;
+		}
+
+next_cpu:
+		rq_unlock_irqrestore(rq, &rf);
+	}
+
+	/* Idle groups have minimum weight. */
+	if (tg_is_idle(tg))
+		__sched_group_set_shares(tg, scale_load(WEIGHT_IDLEPRIO));
+	else
+		__sched_group_set_shares(tg, NICE_0_LOAD);
+
 	mutex_unlock(&shares_mutex);
 	return 0;
 }
+
 #else /* CONFIG_FAIR_GROUP_SCHED */
 
 void free_fair_sched_group(struct task_group *tg) { }
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 75a5c12..5fa0290 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -396,6 +396,9 @@ struct task_group {
 	struct cfs_rq		**cfs_rq;
 	unsigned long		shares;
 
+	/* A positive value indicates that this is a SCHED_IDLE group. */
+	int			idle;
+
 #ifdef	CONFIG_SMP
 	/*
 	 * load_avg can be heavily contended at clock tick time, so put
@@ -505,6 +508,8 @@ extern void sched_move_task(struct task_struct *tsk);
 #ifdef CONFIG_FAIR_GROUP_SCHED
 extern int sched_group_set_shares(struct task_group *tg, unsigned long shares);
 
+extern int sched_group_set_idle(struct task_group *tg, long idle);
+
 #ifdef CONFIG_SMP
 extern void set_task_rq_fair(struct sched_entity *se,
 			     struct cfs_rq *prev, struct cfs_rq *next);
@@ -601,6 +606,9 @@ struct cfs_rq {
 	struct list_head	leaf_cfs_rq_list;
 	struct task_group	*tg;	/* group that "owns" this runqueue */
 
+	/* Locally cached copy of our task_group's idle value */
+	int			idle;
+
 #ifdef CONFIG_CFS_BANDWIDTH
 	int			runtime_enabled;
 	s64			runtime_remaining;
