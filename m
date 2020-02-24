Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0E00716A9D8
	for <lists+linux-tip-commits@lfdr.de>; Mon, 24 Feb 2020 16:21:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728028AbgBXPUt (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Mon, 24 Feb 2020 10:20:49 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:50320 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727701AbgBXPUs (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Mon, 24 Feb 2020 10:20:48 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1j6FX6-0005qG-JM; Mon, 24 Feb 2020 16:20:32 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 3D2C61C213D;
        Mon, 24 Feb 2020 16:20:32 +0100 (CET)
Date:   Mon, 24 Feb 2020 15:20:31 -0000
From:   "tip-bot2 for Vincent Guittot" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/pelt: Remove unused runnable load average
Cc:     Vincent Guittot <vincent.guittot@linaro.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Ingo Molnar <mingo@kernel.org>,
        "Dietmar Eggemann" <dietmar.eggemann@arm.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Juri Lelli <juri.lelli@redhat.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Phil Auld <pauld@redhat.com>, Hillf Danton <hdanton@sina.com>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200224095223.13361-8-mgorman@techsingularity.net>
References: <20200224095223.13361-8-mgorman@techsingularity.net>
MIME-Version: 1.0
Message-ID: <158255763197.28353.10118799857433634862.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-tip-commits-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     0dacee1bfa70e171be3a12a30414c228453048d2
Gitweb:        https://git.kernel.org/tip/0dacee1bfa70e171be3a12a30414c228453048d2
Author:        Vincent Guittot <vincent.guittot@linaro.org>
AuthorDate:    Mon, 24 Feb 2020 09:52:17 
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Mon, 24 Feb 2020 11:36:36 +01:00

sched/pelt: Remove unused runnable load average

Now that runnable_load_avg is no more used, we can remove it to make
space for a new signal.

Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
Signed-off-by: Mel Gorman <mgorman@techsingularity.net>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Reviewed-by: "Dietmar Eggemann <dietmar.eggemann@arm.com>"
Acked-by: Peter Zijlstra <a.p.zijlstra@chello.nl>
Cc: Juri Lelli <juri.lelli@redhat.com>
Cc: Valentin Schneider <valentin.schneider@arm.com>
Cc: Phil Auld <pauld@redhat.com>
Cc: Hillf Danton <hdanton@sina.com>
Link: https://lore.kernel.org/r/20200224095223.13361-8-mgorman@techsingularity.net
---
 include/linux/sched.h |   5 +--
 kernel/sched/core.c   |   2 +-
 kernel/sched/debug.c  |   8 +---
 kernel/sched/fair.c   | 130 +++++------------------------------------
 kernel/sched/pelt.c   |  62 +++++++-------------
 kernel/sched/sched.h  |   7 +--
 6 files changed, 43 insertions(+), 171 deletions(-)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index 0427849..037eaff 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -357,7 +357,7 @@ struct util_est {
 
 /*
  * The load_avg/util_avg accumulates an infinite geometric series
- * (see __update_load_avg() in kernel/sched/fair.c).
+ * (see __update_load_avg_cfs_rq() in kernel/sched/pelt.c).
  *
  * [load_avg definition]
  *
@@ -401,11 +401,9 @@ struct util_est {
 struct sched_avg {
 	u64				last_update_time;
 	u64				load_sum;
-	u64				runnable_load_sum;
 	u32				util_sum;
 	u32				period_contrib;
 	unsigned long			load_avg;
-	unsigned long			runnable_load_avg;
 	unsigned long			util_avg;
 	struct util_est			util_est;
 } ____cacheline_aligned;
@@ -449,7 +447,6 @@ struct sched_statistics {
 struct sched_entity {
 	/* For load-balancing: */
 	struct load_weight		load;
-	unsigned long			runnable_weight;
 	struct rb_node			run_node;
 	struct list_head		group_node;
 	unsigned int			on_rq;
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index e94819d..8e6f380 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -761,7 +761,6 @@ static void set_load_weight(struct task_struct *p, bool update_load)
 	if (task_has_idle_policy(p)) {
 		load->weight = scale_load(WEIGHT_IDLEPRIO);
 		load->inv_weight = WMULT_IDLEPRIO;
-		p->se.runnable_weight = load->weight;
 		return;
 	}
 
@@ -774,7 +773,6 @@ static void set_load_weight(struct task_struct *p, bool update_load)
 	} else {
 		load->weight = scale_load(sched_prio_to_weight[prio]);
 		load->inv_weight = sched_prio_to_wmult[prio];
-		p->se.runnable_weight = load->weight;
 	}
 }
 
diff --git a/kernel/sched/debug.c b/kernel/sched/debug.c
index 879d3cc..cfecaad 100644
--- a/kernel/sched/debug.c
+++ b/kernel/sched/debug.c
@@ -402,11 +402,9 @@ static void print_cfs_group_stats(struct seq_file *m, int cpu, struct task_group
 	}
 
 	P(se->load.weight);
-	P(se->runnable_weight);
 #ifdef CONFIG_SMP
 	P(se->avg.load_avg);
 	P(se->avg.util_avg);
-	P(se->avg.runnable_load_avg);
 #endif
 
 #undef PN_SCHEDSTAT
@@ -524,11 +522,8 @@ void print_cfs_rq(struct seq_file *m, int cpu, struct cfs_rq *cfs_rq)
 	SEQ_printf(m, "  .%-30s: %d\n", "nr_running", cfs_rq->nr_running);
 	SEQ_printf(m, "  .%-30s: %ld\n", "load", cfs_rq->load.weight);
 #ifdef CONFIG_SMP
-	SEQ_printf(m, "  .%-30s: %ld\n", "runnable_weight", cfs_rq->runnable_weight);
 	SEQ_printf(m, "  .%-30s: %lu\n", "load_avg",
 			cfs_rq->avg.load_avg);
-	SEQ_printf(m, "  .%-30s: %lu\n", "runnable_load_avg",
-			cfs_rq->avg.runnable_load_avg);
 	SEQ_printf(m, "  .%-30s: %lu\n", "util_avg",
 			cfs_rq->avg.util_avg);
 	SEQ_printf(m, "  .%-30s: %u\n", "util_est_enqueued",
@@ -947,13 +942,10 @@ void proc_sched_show_task(struct task_struct *p, struct pid_namespace *ns,
 		   "nr_involuntary_switches", (long long)p->nivcsw);
 
 	P(se.load.weight);
-	P(se.runnable_weight);
 #ifdef CONFIG_SMP
 	P(se.avg.load_sum);
-	P(se.avg.runnable_load_sum);
 	P(se.avg.util_sum);
 	P(se.avg.load_avg);
-	P(se.avg.runnable_load_avg);
 	P(se.avg.util_avg);
 	P(se.avg.last_update_time);
 	P(se.avg.util_est.ewma);
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 7a3c66f..b0fb3d6 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -741,9 +741,7 @@ void init_entity_runnable_average(struct sched_entity *se)
 	 * nothing has been attached to the task group yet.
 	 */
 	if (entity_is_task(se))
-		sa->runnable_load_avg = sa->load_avg = scale_load_down(se->load.weight);
-
-	se->runnable_weight = se->load.weight;
+		sa->load_avg = scale_load_down(se->load.weight);
 
 	/* when this task enqueue'ed, it will contribute to its cfs_rq's load_avg */
 }
@@ -2899,25 +2897,6 @@ account_entity_dequeue(struct cfs_rq *cfs_rq, struct sched_entity *se)
 
 #ifdef CONFIG_SMP
 static inline void
-enqueue_runnable_load_avg(struct cfs_rq *cfs_rq, struct sched_entity *se)
-{
-	cfs_rq->runnable_weight += se->runnable_weight;
-
-	cfs_rq->avg.runnable_load_avg += se->avg.runnable_load_avg;
-	cfs_rq->avg.runnable_load_sum += se_runnable(se) * se->avg.runnable_load_sum;
-}
-
-static inline void
-dequeue_runnable_load_avg(struct cfs_rq *cfs_rq, struct sched_entity *se)
-{
-	cfs_rq->runnable_weight -= se->runnable_weight;
-
-	sub_positive(&cfs_rq->avg.runnable_load_avg, se->avg.runnable_load_avg);
-	sub_positive(&cfs_rq->avg.runnable_load_sum,
-		     se_runnable(se) * se->avg.runnable_load_sum);
-}
-
-static inline void
 enqueue_load_avg(struct cfs_rq *cfs_rq, struct sched_entity *se)
 {
 	cfs_rq->avg.load_avg += se->avg.load_avg;
@@ -2932,28 +2911,22 @@ dequeue_load_avg(struct cfs_rq *cfs_rq, struct sched_entity *se)
 }
 #else
 static inline void
-enqueue_runnable_load_avg(struct cfs_rq *cfs_rq, struct sched_entity *se) { }
-static inline void
-dequeue_runnable_load_avg(struct cfs_rq *cfs_rq, struct sched_entity *se) { }
-static inline void
 enqueue_load_avg(struct cfs_rq *cfs_rq, struct sched_entity *se) { }
 static inline void
 dequeue_load_avg(struct cfs_rq *cfs_rq, struct sched_entity *se) { }
 #endif
 
 static void reweight_entity(struct cfs_rq *cfs_rq, struct sched_entity *se,
-			    unsigned long weight, unsigned long runnable)
+			    unsigned long weight)
 {
 	if (se->on_rq) {
 		/* commit outstanding execution time */
 		if (cfs_rq->curr == se)
 			update_curr(cfs_rq);
 		account_entity_dequeue(cfs_rq, se);
-		dequeue_runnable_load_avg(cfs_rq, se);
 	}
 	dequeue_load_avg(cfs_rq, se);
 
-	se->runnable_weight = runnable;
 	update_load_set(&se->load, weight);
 
 #ifdef CONFIG_SMP
@@ -2961,16 +2934,13 @@ static void reweight_entity(struct cfs_rq *cfs_rq, struct sched_entity *se,
 		u32 divider = LOAD_AVG_MAX - 1024 + se->avg.period_contrib;
 
 		se->avg.load_avg = div_u64(se_weight(se) * se->avg.load_sum, divider);
-		se->avg.runnable_load_avg =
-			div_u64(se_runnable(se) * se->avg.runnable_load_sum, divider);
 	} while (0);
 #endif
 
 	enqueue_load_avg(cfs_rq, se);
-	if (se->on_rq) {
+	if (se->on_rq)
 		account_entity_enqueue(cfs_rq, se);
-		enqueue_runnable_load_avg(cfs_rq, se);
-	}
+
 }
 
 void reweight_task(struct task_struct *p, int prio)
@@ -2980,7 +2950,7 @@ void reweight_task(struct task_struct *p, int prio)
 	struct load_weight *load = &se->load;
 	unsigned long weight = scale_load(sched_prio_to_weight[prio]);
 
-	reweight_entity(cfs_rq, se, weight, weight);
+	reweight_entity(cfs_rq, se, weight);
 	load->inv_weight = sched_prio_to_wmult[prio];
 }
 
@@ -3092,50 +3062,6 @@ static long calc_group_shares(struct cfs_rq *cfs_rq)
 	 */
 	return clamp_t(long, shares, MIN_SHARES, tg_shares);
 }
-
-/*
- * This calculates the effective runnable weight for a group entity based on
- * the group entity weight calculated above.
- *
- * Because of the above approximation (2), our group entity weight is
- * an load_avg based ratio (3). This means that it includes blocked load and
- * does not represent the runnable weight.
- *
- * Approximate the group entity's runnable weight per ratio from the group
- * runqueue:
- *
- *					     grq->avg.runnable_load_avg
- *   ge->runnable_weight = ge->load.weight * -------------------------- (7)
- *						 grq->avg.load_avg
- *
- * However, analogous to above, since the avg numbers are slow, this leads to
- * transients in the from-idle case. Instead we use:
- *
- *   ge->runnable_weight = ge->load.weight *
- *
- *		max(grq->avg.runnable_load_avg, grq->runnable_weight)
- *		-----------------------------------------------------	(8)
- *		      max(grq->avg.load_avg, grq->load.weight)
- *
- * Where these max() serve both to use the 'instant' values to fix the slow
- * from-idle and avoid the /0 on to-idle, similar to (6).
- */
-static long calc_group_runnable(struct cfs_rq *cfs_rq, long shares)
-{
-	long runnable, load_avg;
-
-	load_avg = max(cfs_rq->avg.load_avg,
-		       scale_load_down(cfs_rq->load.weight));
-
-	runnable = max(cfs_rq->avg.runnable_load_avg,
-		       scale_load_down(cfs_rq->runnable_weight));
-
-	runnable *= shares;
-	if (load_avg)
-		runnable /= load_avg;
-
-	return clamp_t(long, runnable, MIN_SHARES, shares);
-}
 #endif /* CONFIG_SMP */
 
 static inline int throttled_hierarchy(struct cfs_rq *cfs_rq);
@@ -3147,7 +3073,7 @@ static inline int throttled_hierarchy(struct cfs_rq *cfs_rq);
 static void update_cfs_group(struct sched_entity *se)
 {
 	struct cfs_rq *gcfs_rq = group_cfs_rq(se);
-	long shares, runnable;
+	long shares;
 
 	if (!gcfs_rq)
 		return;
@@ -3156,16 +3082,15 @@ static void update_cfs_group(struct sched_entity *se)
 		return;
 
 #ifndef CONFIG_SMP
-	runnable = shares = READ_ONCE(gcfs_rq->tg->shares);
+	shares = READ_ONCE(gcfs_rq->tg->shares);
 
 	if (likely(se->load.weight == shares))
 		return;
 #else
 	shares   = calc_group_shares(gcfs_rq);
-	runnable = calc_group_runnable(gcfs_rq, shares);
 #endif
 
-	reweight_entity(cfs_rq_of(se), se, shares, runnable);
+	reweight_entity(cfs_rq_of(se), se, shares);
 }
 
 #else /* CONFIG_FAIR_GROUP_SCHED */
@@ -3290,11 +3215,11 @@ void set_task_rq_fair(struct sched_entity *se,
  * _IFF_ we look at the pure running and runnable sums. Because they
  * represent the very same entity, just at different points in the hierarchy.
  *
- * Per the above update_tg_cfs_util() is trivial and simply copies the running
- * sum over (but still wrong, because the group entity and group rq do not have
- * their PELT windows aligned).
+ * Per the above update_tg_cfs_util() is trivial  * and simply copies the
+ * running sum over (but still wrong, because the group entity and group rq do
+ * not have their PELT windows aligned).
  *
- * However, update_tg_cfs_runnable() is more complex. So we have:
+ * However, update_tg_cfs_load() is more complex. So we have:
  *
  *   ge->avg.load_avg = ge->load.weight * ge->avg.runnable_avg		(2)
  *
@@ -3375,11 +3300,11 @@ update_tg_cfs_util(struct cfs_rq *cfs_rq, struct sched_entity *se, struct cfs_rq
 }
 
 static inline void
-update_tg_cfs_runnable(struct cfs_rq *cfs_rq, struct sched_entity *se, struct cfs_rq *gcfs_rq)
+update_tg_cfs_load(struct cfs_rq *cfs_rq, struct sched_entity *se, struct cfs_rq *gcfs_rq)
 {
 	long delta_avg, running_sum, runnable_sum = gcfs_rq->prop_runnable_sum;
-	unsigned long runnable_load_avg, load_avg;
-	u64 runnable_load_sum, load_sum = 0;
+	unsigned long load_avg;
+	u64 load_sum = 0;
 	s64 delta_sum;
 
 	if (!runnable_sum)
@@ -3427,20 +3352,6 @@ update_tg_cfs_runnable(struct cfs_rq *cfs_rq, struct sched_entity *se, struct cf
 	se->avg.load_avg = load_avg;
 	add_positive(&cfs_rq->avg.load_avg, delta_avg);
 	add_positive(&cfs_rq->avg.load_sum, delta_sum);
-
-	runnable_load_sum = (s64)se_runnable(se) * runnable_sum;
-	runnable_load_avg = div_s64(runnable_load_sum, LOAD_AVG_MAX);
-
-	if (se->on_rq) {
-		delta_sum = runnable_load_sum -
-				se_weight(se) * se->avg.runnable_load_sum;
-		delta_avg = runnable_load_avg - se->avg.runnable_load_avg;
-		add_positive(&cfs_rq->avg.runnable_load_avg, delta_avg);
-		add_positive(&cfs_rq->avg.runnable_load_sum, delta_sum);
-	}
-
-	se->avg.runnable_load_sum = runnable_sum;
-	se->avg.runnable_load_avg = runnable_load_avg;
 }
 
 static inline void add_tg_cfs_propagate(struct cfs_rq *cfs_rq, long runnable_sum)
@@ -3468,7 +3379,7 @@ static inline int propagate_entity_load_avg(struct sched_entity *se)
 	add_tg_cfs_propagate(cfs_rq, gcfs_rq->prop_runnable_sum);
 
 	update_tg_cfs_util(cfs_rq, se, gcfs_rq);
-	update_tg_cfs_runnable(cfs_rq, se, gcfs_rq);
+	update_tg_cfs_load(cfs_rq, se, gcfs_rq);
 
 	trace_pelt_cfs_tp(cfs_rq);
 	trace_pelt_se_tp(se);
@@ -3612,8 +3523,6 @@ static void attach_entity_load_avg(struct cfs_rq *cfs_rq, struct sched_entity *s
 			div_u64(se->avg.load_avg * se->avg.load_sum, se_weight(se));
 	}
 
-	se->avg.runnable_load_sum = se->avg.load_sum;
-
 	enqueue_load_avg(cfs_rq, se);
 	cfs_rq->avg.util_avg += se->avg.util_avg;
 	cfs_rq->avg.util_sum += se->avg.util_sum;
@@ -4074,14 +3983,12 @@ enqueue_entity(struct cfs_rq *cfs_rq, struct sched_entity *se, int flags)
 	/*
 	 * When enqueuing a sched_entity, we must:
 	 *   - Update loads to have both entity and cfs_rq synced with now.
-	 *   - Add its load to cfs_rq->runnable_avg
 	 *   - For group_entity, update its weight to reflect the new share of
 	 *     its group cfs_rq
 	 *   - Add its new weight to cfs_rq->load.weight
 	 */
 	update_load_avg(cfs_rq, se, UPDATE_TG | DO_ATTACH);
 	update_cfs_group(se);
-	enqueue_runnable_load_avg(cfs_rq, se);
 	account_entity_enqueue(cfs_rq, se);
 
 	if (flags & ENQUEUE_WAKEUP)
@@ -4158,13 +4065,11 @@ dequeue_entity(struct cfs_rq *cfs_rq, struct sched_entity *se, int flags)
 	/*
 	 * When dequeuing a sched_entity, we must:
 	 *   - Update loads to have both entity and cfs_rq synced with now.
-	 *   - Subtract its load from the cfs_rq->runnable_avg.
 	 *   - Subtract its previous weight from cfs_rq->load.weight.
 	 *   - For group entity, update its weight to reflect the new share
 	 *     of its group cfs_rq.
 	 */
 	update_load_avg(cfs_rq, se, UPDATE_TG);
-	dequeue_runnable_load_avg(cfs_rq, se);
 
 	update_stats_dequeue(cfs_rq, se, flags);
 
@@ -7649,9 +7554,6 @@ static inline bool cfs_rq_is_decayed(struct cfs_rq *cfs_rq)
 	if (cfs_rq->avg.util_sum)
 		return false;
 
-	if (cfs_rq->avg.runnable_load_sum)
-		return false;
-
 	return true;
 }
 
diff --git a/kernel/sched/pelt.c b/kernel/sched/pelt.c
index bd006b7..3eb0ed3 100644
--- a/kernel/sched/pelt.c
+++ b/kernel/sched/pelt.c
@@ -108,7 +108,7 @@ static u32 __accumulate_pelt_segments(u64 periods, u32 d1, u32 d3)
  */
 static __always_inline u32
 accumulate_sum(u64 delta, struct sched_avg *sa,
-	       unsigned long load, unsigned long runnable, int running)
+	       unsigned long load, int running)
 {
 	u32 contrib = (u32)delta; /* p == 0 -> delta < 1024 */
 	u64 periods;
@@ -121,8 +121,6 @@ accumulate_sum(u64 delta, struct sched_avg *sa,
 	 */
 	if (periods) {
 		sa->load_sum = decay_load(sa->load_sum, periods);
-		sa->runnable_load_sum =
-			decay_load(sa->runnable_load_sum, periods);
 		sa->util_sum = decay_load((u64)(sa->util_sum), periods);
 
 		/*
@@ -148,8 +146,6 @@ accumulate_sum(u64 delta, struct sched_avg *sa,
 
 	if (load)
 		sa->load_sum += load * contrib;
-	if (runnable)
-		sa->runnable_load_sum += runnable * contrib;
 	if (running)
 		sa->util_sum += contrib << SCHED_CAPACITY_SHIFT;
 
@@ -186,7 +182,7 @@ accumulate_sum(u64 delta, struct sched_avg *sa,
  */
 static __always_inline int
 ___update_load_sum(u64 now, struct sched_avg *sa,
-		  unsigned long load, unsigned long runnable, int running)
+		  unsigned long load, int running)
 {
 	u64 delta;
 
@@ -222,7 +218,7 @@ ___update_load_sum(u64 now, struct sched_avg *sa,
 	 * Also see the comment in accumulate_sum().
 	 */
 	if (!load)
-		runnable = running = 0;
+		running = 0;
 
 	/*
 	 * Now we know we crossed measurement unit boundaries. The *_avg
@@ -231,14 +227,14 @@ ___update_load_sum(u64 now, struct sched_avg *sa,
 	 * Step 1: accumulate *_sum since last_update_time. If we haven't
 	 * crossed period boundaries, finish.
 	 */
-	if (!accumulate_sum(delta, sa, load, runnable, running))
+	if (!accumulate_sum(delta, sa, load, running))
 		return 0;
 
 	return 1;
 }
 
 static __always_inline void
-___update_load_avg(struct sched_avg *sa, unsigned long load, unsigned long runnable)
+___update_load_avg(struct sched_avg *sa, unsigned long load)
 {
 	u32 divider = LOAD_AVG_MAX - 1024 + sa->period_contrib;
 
@@ -246,7 +242,6 @@ ___update_load_avg(struct sched_avg *sa, unsigned long load, unsigned long runna
 	 * Step 2: update *_avg.
 	 */
 	sa->load_avg = div_u64(load * sa->load_sum, divider);
-	sa->runnable_load_avg =	div_u64(runnable * sa->runnable_load_sum, divider);
 	WRITE_ONCE(sa->util_avg, sa->util_sum / divider);
 }
 
@@ -254,17 +249,13 @@ ___update_load_avg(struct sched_avg *sa, unsigned long load, unsigned long runna
  * sched_entity:
  *
  *   task:
- *     se_runnable() == se_weight()
+ *     se_weight()   = se->load.weight
  *
  *   group: [ see update_cfs_group() ]
  *     se_weight()   = tg->weight * grq->load_avg / tg->load_avg
- *     se_runnable() = se_weight(se) * grq->runnable_load_avg / grq->load_avg
  *
- *   load_sum := runnable_sum
- *   load_avg = se_weight(se) * runnable_avg
- *
- *   runnable_load_sum := runnable_sum
- *   runnable_load_avg = se_runnable(se) * runnable_avg
+ *   load_sum := runnable
+ *   load_avg = se_weight(se) * load_sum
  *
  * XXX collapse load_sum and runnable_load_sum
  *
@@ -272,15 +263,12 @@ ___update_load_avg(struct sched_avg *sa, unsigned long load, unsigned long runna
  *
  *   load_sum = \Sum se_weight(se) * se->avg.load_sum
  *   load_avg = \Sum se->avg.load_avg
- *
- *   runnable_load_sum = \Sum se_runnable(se) * se->avg.runnable_load_sum
- *   runnable_load_avg = \Sum se->avg.runable_load_avg
  */
 
 int __update_load_avg_blocked_se(u64 now, struct sched_entity *se)
 {
-	if (___update_load_sum(now, &se->avg, 0, 0, 0)) {
-		___update_load_avg(&se->avg, se_weight(se), se_runnable(se));
+	if (___update_load_sum(now, &se->avg, 0, 0)) {
+		___update_load_avg(&se->avg, se_weight(se));
 		trace_pelt_se_tp(se);
 		return 1;
 	}
@@ -290,10 +278,9 @@ int __update_load_avg_blocked_se(u64 now, struct sched_entity *se)
 
 int __update_load_avg_se(u64 now, struct cfs_rq *cfs_rq, struct sched_entity *se)
 {
-	if (___update_load_sum(now, &se->avg, !!se->on_rq, !!se->on_rq,
-				cfs_rq->curr == se)) {
+	if (___update_load_sum(now, &se->avg, !!se->on_rq, cfs_rq->curr == se)) {
 
-		___update_load_avg(&se->avg, se_weight(se), se_runnable(se));
+		___update_load_avg(&se->avg, se_weight(se));
 		cfs_se_util_change(&se->avg);
 		trace_pelt_se_tp(se);
 		return 1;
@@ -306,10 +293,9 @@ int __update_load_avg_cfs_rq(u64 now, struct cfs_rq *cfs_rq)
 {
 	if (___update_load_sum(now, &cfs_rq->avg,
 				scale_load_down(cfs_rq->load.weight),
-				scale_load_down(cfs_rq->runnable_weight),
 				cfs_rq->curr != NULL)) {
 
-		___update_load_avg(&cfs_rq->avg, 1, 1);
+		___update_load_avg(&cfs_rq->avg, 1);
 		trace_pelt_cfs_tp(cfs_rq);
 		return 1;
 	}
@@ -322,9 +308,9 @@ int __update_load_avg_cfs_rq(u64 now, struct cfs_rq *cfs_rq)
  *
  *   util_sum = \Sum se->avg.util_sum but se->avg.util_sum is not tracked
  *   util_sum = cpu_scale * load_sum
- *   runnable_load_sum = load_sum
+ *   runnable_sum = util_sum
  *
- *   load_avg and runnable_load_avg are not supported and meaningless.
+ *   load_avg is not supported and meaningless.
  *
  */
 
@@ -332,10 +318,9 @@ int update_rt_rq_load_avg(u64 now, struct rq *rq, int running)
 {
 	if (___update_load_sum(now, &rq->avg_rt,
 				running,
-				running,
 				running)) {
 
-		___update_load_avg(&rq->avg_rt, 1, 1);
+		___update_load_avg(&rq->avg_rt, 1);
 		trace_pelt_rt_tp(rq);
 		return 1;
 	}
@@ -348,7 +333,9 @@ int update_rt_rq_load_avg(u64 now, struct rq *rq, int running)
  *
  *   util_sum = \Sum se->avg.util_sum but se->avg.util_sum is not tracked
  *   util_sum = cpu_scale * load_sum
- *   runnable_load_sum = load_sum
+ *   runnable_sum = util_sum
+ *
+ *   load_avg is not supported and meaningless.
  *
  */
 
@@ -356,10 +343,9 @@ int update_dl_rq_load_avg(u64 now, struct rq *rq, int running)
 {
 	if (___update_load_sum(now, &rq->avg_dl,
 				running,
-				running,
 				running)) {
 
-		___update_load_avg(&rq->avg_dl, 1, 1);
+		___update_load_avg(&rq->avg_dl, 1);
 		trace_pelt_dl_tp(rq);
 		return 1;
 	}
@@ -373,7 +359,9 @@ int update_dl_rq_load_avg(u64 now, struct rq *rq, int running)
  *
  *   util_sum = \Sum se->avg.util_sum but se->avg.util_sum is not tracked
  *   util_sum = cpu_scale * load_sum
- *   runnable_load_sum = load_sum
+ *   runnable_sum = util_sum
+ *
+ *   load_avg is not supported and meaningless.
  *
  */
 
@@ -402,15 +390,13 @@ int update_irq_load_avg(struct rq *rq, u64 running)
 	 */
 	ret = ___update_load_sum(rq->clock - running, &rq->avg_irq,
 				0,
-				0,
 				0);
 	ret += ___update_load_sum(rq->clock, &rq->avg_irq,
 				1,
-				1,
 				1);
 
 	if (ret) {
-		___update_load_avg(&rq->avg_irq, 1, 1);
+		___update_load_avg(&rq->avg_irq, 1);
 		trace_pelt_irq_tp(rq);
 	}
 
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 12bf82d..ce27e58 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -489,7 +489,6 @@ struct cfs_bandwidth { };
 /* CFS-related fields in a runqueue */
 struct cfs_rq {
 	struct load_weight	load;
-	unsigned long		runnable_weight;
 	unsigned int		nr_running;
 	unsigned int		h_nr_running;      /* SCHED_{NORMAL,BATCH,IDLE} */
 	unsigned int		idle_h_nr_running; /* SCHED_IDLE */
@@ -688,8 +687,10 @@ struct dl_rq {
 #ifdef CONFIG_FAIR_GROUP_SCHED
 /* An entity is a task if it doesn't "own" a runqueue */
 #define entity_is_task(se)	(!se->my_q)
+
 #else
 #define entity_is_task(se)	1
+
 #endif
 
 #ifdef CONFIG_SMP
@@ -701,10 +702,6 @@ static inline long se_weight(struct sched_entity *se)
 	return scale_load_down(se->load.weight);
 }
 
-static inline long se_runnable(struct sched_entity *se)
-{
-	return scale_load_down(se->runnable_weight);
-}
 
 static inline bool sched_asym_prefer(int a, int b)
 {
