Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE37137BA5A
	for <lists+linux-tip-commits@lfdr.de>; Wed, 12 May 2021 12:28:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230329AbhELK3d (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 12 May 2021 06:29:33 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:50400 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230184AbhELK3c (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 12 May 2021 06:29:32 -0400
Date:   Wed, 12 May 2021 10:28:23 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1620815303;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=C0leY1kjxh/HtMmLqv1Hc+d8iso6g1pDfvrfl88Q+vQ=;
        b=184c7bfxAxLat6GcPNfliMepLWttj0hn0DH1XHztiikvNlKbwA8iSRYx491Uzt0XUO2Ecv
        /7hBS+M3ZvnsuvvFaG/ST9s3sLOQXeb5xNKumafbjPTSSaO7pO0QxlO0JsEYZdi5STmwIn
        VK6yJvF0yyre6RjuJGZqDENaFumPk2OMM1lUpXSo0wGivG2+sZOrwzQnVXpIza6mZkuBKv
        E5kdES61l+qByq5WtKaqOktHj8lf7xKZ0Rujk8y0DFqVK9ZFRKV+tHdd8WnCWAmzcYPwko
        r6UtuyTKhjwMGJRiaP3GyVNFHYAey2rLJObeuKFa0WntYsbVynueazWUhiOQDA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1620815303;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=C0leY1kjxh/HtMmLqv1Hc+d8iso6g1pDfvrfl88Q+vQ=;
        b=x0QZBJyaSYIqEwN33lb6nih5MJMTWEfIIyua0kAsKmhWYtcRdBrF0B7earKrXiTRVAerhy
        IXMBwivQXMXvMoDw==
From:   "tip-bot2 for Joel Fernandes (Google)" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/fair: Snapshot the min_vruntime of CPUs on force idle
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Don Hiatt <dhiatt@digitalocean.com>,
        Hongyu Ning <hongyu.ning@linux.intel.com>,
        Vincent Guittot <vincent.guittot@linaro.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210422123308.738542617@infradead.org>
References: <20210422123308.738542617@infradead.org>
MIME-Version: 1.0
Message-ID: <162081530304.29796.4215651670286148093.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     c6047c2e3af68dae23ad884249e0d42ff28d2d1b
Gitweb:        https://git.kernel.org/tip/c6047c2e3af68dae23ad884249e0d42ff28d2d1b
Author:        Joel Fernandes (Google) <joel@joelfernandes.org>
AuthorDate:    Tue, 17 Nov 2020 18:19:39 -05:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 12 May 2021 11:43:29 +02:00

sched/fair: Snapshot the min_vruntime of CPUs on force idle

During force-idle, we end up doing cross-cpu comparison of vruntimes
during pick_next_task. If we simply compare (vruntime-min_vruntime)
across CPUs, and if the CPUs only have 1 task each, we will always
end up comparing 0 with 0 and pick just one of the tasks all the time.
This starves the task that was not picked. To fix this, take a snapshot
of the min_vruntime when entering force idle and use it for comparison.
This min_vruntime snapshot will only be used for cross-CPU vruntime
comparison, and nothing else.

A note about the min_vruntime snapshot and force idling:

During selection:

  When we're not fi, we need to update snapshot.
  when we're fi and we were not fi, we must update snapshot.
  When we're fi and we were already fi, we must not update snapshot.

Which gives:

  fib     fi      update
  0       0       1
  0       1       1
  1       0       1
  1       1       0

Where:

  fi:  force-idled now
  fib: force-idled before

So the min_vruntime snapshot needs to be updated when: !(fib && fi).

Also, the cfs_prio_less() function needs to be aware of whether the
core is in force idle or not, since it will be use this information to
know whether to advance a cfs_rq's min_vruntime_fi in the hierarchy.
So pass this information along via pick_task() -> prio_less().

Suggested-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Tested-by: Don Hiatt <dhiatt@digitalocean.com>
Tested-by: Hongyu Ning <hongyu.ning@linux.intel.com>
Tested-by: Vincent Guittot <vincent.guittot@linaro.org>
Link: https://lkml.kernel.org/r/20210422123308.738542617@infradead.org
---
 kernel/sched/core.c  | 59 +++++++++++++++++++---------------
 kernel/sched/fair.c  | 75 +++++++++++++++++++++++++++++++++++++++++++-
 kernel/sched/sched.h |  8 +++++-
 3 files changed, 117 insertions(+), 25 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index e506d9d..e45c1d2 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -111,7 +111,7 @@ static inline int __task_prio(struct task_struct *p)
  */
 
 /* real prio, less is less */
-static inline bool prio_less(struct task_struct *a, struct task_struct *b)
+static inline bool prio_less(struct task_struct *a, struct task_struct *b, bool in_fi)
 {
 
 	int pa = __task_prio(a), pb = __task_prio(b);
@@ -125,19 +125,8 @@ static inline bool prio_less(struct task_struct *a, struct task_struct *b)
 	if (pa == -1) /* dl_prio() doesn't work because of stop_class above */
 		return !dl_time_before(a->dl.deadline, b->dl.deadline);
 
-	if (pa == MAX_RT_PRIO + MAX_NICE)  { /* fair */
-		u64 vruntime = b->se.vruntime;
-
-		/*
-		 * Normalize the vruntime if tasks are in different cpus.
-		 */
-		if (task_cpu(a) != task_cpu(b)) {
-			vruntime -= task_cfs_rq(b)->min_vruntime;
-			vruntime += task_cfs_rq(a)->min_vruntime;
-		}
-
-		return !((s64)(a->se.vruntime - vruntime) <= 0);
-	}
+	if (pa == MAX_RT_PRIO + MAX_NICE)	/* fair */
+		return cfs_prio_less(a, b, in_fi);
 
 	return false;
 }
@@ -151,7 +140,7 @@ static inline bool __sched_core_less(struct task_struct *a, struct task_struct *
 		return false;
 
 	/* flip prio, so high prio is leftmost */
-	if (prio_less(b, a))
+	if (prio_less(b, a, task_rq(a)->core->core_forceidle))
 		return true;
 
 	return false;
@@ -5350,7 +5339,7 @@ static inline bool cookie_match(struct task_struct *a, struct task_struct *b)
  * - Else returns idle_task.
  */
 static struct task_struct *
-pick_task(struct rq *rq, const struct sched_class *class, struct task_struct *max)
+pick_task(struct rq *rq, const struct sched_class *class, struct task_struct *max, bool in_fi)
 {
 	struct task_struct *class_pick, *cookie_pick;
 	unsigned long cookie = rq->core->core_cookie;
@@ -5365,7 +5354,7 @@ pick_task(struct rq *rq, const struct sched_class *class, struct task_struct *ma
 		 * higher priority than max.
 		 */
 		if (max && class_pick->core_cookie &&
-		    prio_less(class_pick, max))
+		    prio_less(class_pick, max, in_fi))
 			return idle_sched_class.pick_task(rq);
 
 		return class_pick;
@@ -5384,19 +5373,22 @@ pick_task(struct rq *rq, const struct sched_class *class, struct task_struct *ma
 	 * the core (so far) and it must be selected, otherwise we must go with
 	 * the cookie pick in order to satisfy the constraint.
 	 */
-	if (prio_less(cookie_pick, class_pick) &&
-	    (!max || prio_less(max, class_pick)))
+	if (prio_less(cookie_pick, class_pick, in_fi) &&
+	    (!max || prio_less(max, class_pick, in_fi)))
 		return class_pick;
 
 	return cookie_pick;
 }
 
+extern void task_vruntime_update(struct rq *rq, struct task_struct *p, bool in_fi);
+
 static struct task_struct *
 pick_next_task(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
 {
 	struct task_struct *next, *max = NULL;
 	const struct sched_class *class;
 	const struct cpumask *smt_mask;
+	bool fi_before = false;
 	bool need_sync;
 	int i, j, cpu;
 
@@ -5478,9 +5470,14 @@ pick_next_task(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
 
 		if (!next->core_cookie) {
 			rq->core_pick = NULL;
+			/*
+			 * For robustness, update the min_vruntime_fi for
+			 * unconstrained picks as well.
+			 */
+			WARN_ON_ONCE(fi_before);
+			task_vruntime_update(rq, next, false);
 			goto done;
 		}
-		need_sync = true;
 	}
 
 	for_each_cpu(i, smt_mask) {
@@ -5511,11 +5508,16 @@ again:
 			 * highest priority task already selected for this
 			 * core.
 			 */
-			p = pick_task(rq_i, class, max);
+			p = pick_task(rq_i, class, max, fi_before);
 			if (!p)
 				continue;
 
 			rq_i->core_pick = p;
+			if (rq_i->idle == p && rq_i->nr_running) {
+				rq->core->core_forceidle = true;
+				if (!fi_before)
+					rq->core->core_forceidle_seq++;
+			}
 
 			/*
 			 * If this new candidate is of higher priority than the
@@ -5534,6 +5536,7 @@ again:
 				max = p;
 
 				if (old_max) {
+					rq->core->core_forceidle = false;
 					for_each_cpu(j, smt_mask) {
 						if (j == i)
 							continue;
@@ -5574,10 +5577,16 @@ again:
 		if (!rq_i->core_pick)
 			continue;
 
-		if (is_task_rq_idle(rq_i->core_pick) && rq_i->nr_running &&
-		    !rq_i->core->core_forceidle) {
-			rq_i->core->core_forceidle = true;
-		}
+		/*
+		 * Update for new !FI->FI transitions, or if continuing to be in !FI:
+		 * fi_before     fi      update?
+		 *  0            0       1
+		 *  0            1       1
+		 *  1            0       1
+		 *  1            1       0
+		 */
+		if (!(fi_before && rq->core->core_forceidle))
+			task_vruntime_update(rq_i, rq_i->core_pick, rq->core->core_forceidle);
 
 		if (i == cpu) {
 			rq_i->core_pick = NULL;
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 4d1ecab..5948dc1 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -10801,6 +10801,81 @@ static inline void task_tick_core(struct rq *rq, struct task_struct *curr)
 	    __entity_slice_used(&curr->se, MIN_NR_TASKS_DURING_FORCEIDLE))
 		resched_curr(rq);
 }
+
+/*
+ * se_fi_update - Update the cfs_rq->min_vruntime_fi in a CFS hierarchy if needed.
+ */
+static void se_fi_update(struct sched_entity *se, unsigned int fi_seq, bool forceidle)
+{
+	for_each_sched_entity(se) {
+		struct cfs_rq *cfs_rq = cfs_rq_of(se);
+
+		if (forceidle) {
+			if (cfs_rq->forceidle_seq == fi_seq)
+				break;
+			cfs_rq->forceidle_seq = fi_seq;
+		}
+
+		cfs_rq->min_vruntime_fi = cfs_rq->min_vruntime;
+	}
+}
+
+void task_vruntime_update(struct rq *rq, struct task_struct *p, bool in_fi)
+{
+	struct sched_entity *se = &p->se;
+
+	if (p->sched_class != &fair_sched_class)
+		return;
+
+	se_fi_update(se, rq->core->core_forceidle_seq, in_fi);
+}
+
+bool cfs_prio_less(struct task_struct *a, struct task_struct *b, bool in_fi)
+{
+	struct rq *rq = task_rq(a);
+	struct sched_entity *sea = &a->se;
+	struct sched_entity *seb = &b->se;
+	struct cfs_rq *cfs_rqa;
+	struct cfs_rq *cfs_rqb;
+	s64 delta;
+
+	SCHED_WARN_ON(task_rq(b)->core != rq->core);
+
+#ifdef CONFIG_FAIR_GROUP_SCHED
+	/*
+	 * Find an se in the hierarchy for tasks a and b, such that the se's
+	 * are immediate siblings.
+	 */
+	while (sea->cfs_rq->tg != seb->cfs_rq->tg) {
+		int sea_depth = sea->depth;
+		int seb_depth = seb->depth;
+
+		if (sea_depth >= seb_depth)
+			sea = parent_entity(sea);
+		if (sea_depth <= seb_depth)
+			seb = parent_entity(seb);
+	}
+
+	se_fi_update(sea, rq->core->core_forceidle_seq, in_fi);
+	se_fi_update(seb, rq->core->core_forceidle_seq, in_fi);
+
+	cfs_rqa = sea->cfs_rq;
+	cfs_rqb = seb->cfs_rq;
+#else
+	cfs_rqa = &task_rq(a)->cfs;
+	cfs_rqb = &task_rq(b)->cfs;
+#endif
+
+	/*
+	 * Find delta after normalizing se's vruntime with its cfs_rq's
+	 * min_vruntime_fi, which would have been updated in prior calls
+	 * to se_fi_update().
+	 */
+	delta = (s64)(sea->vruntime - seb->vruntime) +
+		(s64)(cfs_rqb->min_vruntime_fi - cfs_rqa->min_vruntime_fi);
+
+	return delta > 0;
+}
 #else
 static inline void task_tick_core(struct rq *rq, struct task_struct *curr) {}
 #endif
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index db55514..4a898ab 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -526,6 +526,11 @@ struct cfs_rq {
 
 	u64			exec_clock;
 	u64			min_vruntime;
+#ifdef CONFIG_SCHED_CORE
+	unsigned int		forceidle_seq;
+	u64			min_vruntime_fi;
+#endif
+
 #ifndef CONFIG_64BIT
 	u64			min_vruntime_copy;
 #endif
@@ -1089,6 +1094,7 @@ struct rq {
 	unsigned int		core_pick_seq;
 	unsigned long		core_cookie;
 	unsigned char		core_forceidle;
+	unsigned int		core_forceidle_seq;
 #endif
 };
 
@@ -1162,6 +1168,8 @@ static inline raw_spinlock_t *__rq_lockp(struct rq *rq)
 	return &rq->__lock;
 }
 
+bool cfs_prio_less(struct task_struct *a, struct task_struct *b, bool fi);
+
 #else /* !CONFIG_SCHED_CORE */
 
 static inline bool sched_core_enabled(struct rq *rq)
