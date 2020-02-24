Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D21FB16A9DD
	for <lists+linux-tip-commits@lfdr.de>; Mon, 24 Feb 2020 16:21:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727874AbgBXPU7 (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Mon, 24 Feb 2020 10:20:59 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:50335 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728002AbgBXPUt (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Mon, 24 Feb 2020 10:20:49 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1j6FX6-0005qC-7H; Mon, 24 Feb 2020 16:20:32 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id D97581C213A;
        Mon, 24 Feb 2020 16:20:31 +0100 (CET)
Date:   Mon, 24 Feb 2020 15:20:31 -0000
From:   "tip-bot2 for Vincent Guittot" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/pelt: Add a new runnable average signal
Cc:     Vincent Guittot <vincent.guittot@linaro.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Ingo Molnar <mingo@kernel.org>,
        "Dietmar Eggemann" <dietmar.eggemann@arm.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Juri Lelli <juri.lelli@redhat.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Phil Auld <pauld@redhat.com>, Hillf Danton <hdanton@sina.com>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200224095223.13361-9-mgorman@techsingularity.net>
References: <20200224095223.13361-9-mgorman@techsingularity.net>
MIME-Version: 1.0
Message-ID: <158255763157.28353.3693734020236686000.tip-bot2@tip-bot2>
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

Commit-ID:     9f68395333ad7f5bfe2f83473fed363d4229f11c
Gitweb:        https://git.kernel.org/tip/9f68395333ad7f5bfe2f83473fed363d4229f11c
Author:        Vincent Guittot <vincent.guittot@linaro.org>
AuthorDate:    Mon, 24 Feb 2020 09:52:18 
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Mon, 24 Feb 2020 11:36:36 +01:00

sched/pelt: Add a new runnable average signal

Now that runnable_load_avg has been removed, we can replace it by a new
signal that will highlight the runnable pressure on a cfs_rq. This signal
track the waiting time of tasks on rq and can help to better define the
state of rqs.

At now, only util_avg is used to define the state of a rq:
  A rq with more that around 80% of utilization and more than 1 tasks is
  considered as overloaded.

But the util_avg signal of a rq can become temporaly low after that a task
migrated onto another rq which can bias the classification of the rq.

When tasks compete for the same rq, their runnable average signal will be
higher than util_avg as it will include the waiting time and we can use
this signal to better classify cfs_rqs.

The new runnable_avg will track the runnable time of a task which simply
adds the waiting time to the running time. The runnable _avg of cfs_rq
will be the /Sum of se's runnable_avg and the runnable_avg of group entity
will follow the one of the rq similarly to util_avg.

Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
Signed-off-by: Mel Gorman <mgorman@techsingularity.net>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Reviewed-by: "Dietmar Eggemann <dietmar.eggemann@arm.com>"
Acked-by: Peter Zijlstra <a.p.zijlstra@chello.nl>
Cc: Juri Lelli <juri.lelli@redhat.com>
Cc: Valentin Schneider <valentin.schneider@arm.com>
Cc: Phil Auld <pauld@redhat.com>
Cc: Hillf Danton <hdanton@sina.com>
Link: https://lore.kernel.org/r/20200224095223.13361-9-mgorman@techsingularity.net
---
 include/linux/sched.h | 26 ++++++++------
 kernel/sched/debug.c  |  9 +++--
 kernel/sched/fair.c   | 77 ++++++++++++++++++++++++++++++++++++++----
 kernel/sched/pelt.c   | 39 +++++++++++++++------
 kernel/sched/sched.h  | 22 +++++++++++-
 5 files changed, 142 insertions(+), 31 deletions(-)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index 037eaff..2e9199b 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -356,28 +356,30 @@ struct util_est {
 } __attribute__((__aligned__(sizeof(u64))));
 
 /*
- * The load_avg/util_avg accumulates an infinite geometric series
+ * The load/runnable/util_avg accumulates an infinite geometric series
  * (see __update_load_avg_cfs_rq() in kernel/sched/pelt.c).
  *
  * [load_avg definition]
  *
  *   load_avg = runnable% * scale_load_down(load)
  *
- * where runnable% is the time ratio that a sched_entity is runnable.
- * For cfs_rq, it is the aggregated load_avg of all runnable and
- * blocked sched_entities.
+ * [runnable_avg definition]
+ *
+ *   runnable_avg = runnable% * SCHED_CAPACITY_SCALE
  *
  * [util_avg definition]
  *
  *   util_avg = running% * SCHED_CAPACITY_SCALE
  *
- * where running% is the time ratio that a sched_entity is running on
- * a CPU. For cfs_rq, it is the aggregated util_avg of all runnable
- * and blocked sched_entities.
+ * where runnable% is the time ratio that a sched_entity is runnable and
+ * running% the time ratio that a sched_entity is running.
+ *
+ * For cfs_rq, they are the aggregated values of all runnable and blocked
+ * sched_entities.
  *
- * load_avg and util_avg don't direcly factor frequency scaling and CPU
- * capacity scaling. The scaling is done through the rq_clock_pelt that
- * is used for computing those signals (see update_rq_clock_pelt())
+ * The load/runnable/util_avg doesn't direcly factor frequency scaling and CPU
+ * capacity scaling. The scaling is done through the rq_clock_pelt that is used
+ * for computing those signals (see update_rq_clock_pelt())
  *
  * N.B., the above ratios (runnable% and running%) themselves are in the
  * range of [0, 1]. To do fixed point arithmetics, we therefore scale them
@@ -401,9 +403,11 @@ struct util_est {
 struct sched_avg {
 	u64				last_update_time;
 	u64				load_sum;
+	u64				runnable_sum;
 	u32				util_sum;
 	u32				period_contrib;
 	unsigned long			load_avg;
+	unsigned long			runnable_avg;
 	unsigned long			util_avg;
 	struct util_est			util_est;
 } ____cacheline_aligned;
@@ -467,6 +471,8 @@ struct sched_entity {
 	struct cfs_rq			*cfs_rq;
 	/* rq "owned" by this entity/group: */
 	struct cfs_rq			*my_q;
+	/* cached value of my_q->h_nr_running */
+	unsigned long			runnable_weight;
 #endif
 
 #ifdef CONFIG_SMP
diff --git a/kernel/sched/debug.c b/kernel/sched/debug.c
index cfecaad..8331bc0 100644
--- a/kernel/sched/debug.c
+++ b/kernel/sched/debug.c
@@ -405,6 +405,7 @@ static void print_cfs_group_stats(struct seq_file *m, int cpu, struct task_group
 #ifdef CONFIG_SMP
 	P(se->avg.load_avg);
 	P(se->avg.util_avg);
+	P(se->avg.runnable_avg);
 #endif
 
 #undef PN_SCHEDSTAT
@@ -524,6 +525,8 @@ void print_cfs_rq(struct seq_file *m, int cpu, struct cfs_rq *cfs_rq)
 #ifdef CONFIG_SMP
 	SEQ_printf(m, "  .%-30s: %lu\n", "load_avg",
 			cfs_rq->avg.load_avg);
+	SEQ_printf(m, "  .%-30s: %lu\n", "runnable_avg",
+			cfs_rq->avg.runnable_avg);
 	SEQ_printf(m, "  .%-30s: %lu\n", "util_avg",
 			cfs_rq->avg.util_avg);
 	SEQ_printf(m, "  .%-30s: %u\n", "util_est_enqueued",
@@ -532,8 +535,8 @@ void print_cfs_rq(struct seq_file *m, int cpu, struct cfs_rq *cfs_rq)
 			cfs_rq->removed.load_avg);
 	SEQ_printf(m, "  .%-30s: %ld\n", "removed.util_avg",
 			cfs_rq->removed.util_avg);
-	SEQ_printf(m, "  .%-30s: %ld\n", "removed.runnable_sum",
-			cfs_rq->removed.runnable_sum);
+	SEQ_printf(m, "  .%-30s: %ld\n", "removed.runnable_avg",
+			cfs_rq->removed.runnable_avg);
 #ifdef CONFIG_FAIR_GROUP_SCHED
 	SEQ_printf(m, "  .%-30s: %lu\n", "tg_load_avg_contrib",
 			cfs_rq->tg_load_avg_contrib);
@@ -944,8 +947,10 @@ void proc_sched_show_task(struct task_struct *p, struct pid_namespace *ns,
 	P(se.load.weight);
 #ifdef CONFIG_SMP
 	P(se.avg.load_sum);
+	P(se.avg.runnable_sum);
 	P(se.avg.util_sum);
 	P(se.avg.load_avg);
+	P(se.avg.runnable_avg);
 	P(se.avg.util_avg);
 	P(se.avg.last_update_time);
 	P(se.avg.util_est.ewma);
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index b0fb3d6..49b36d6 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -794,6 +794,8 @@ void post_init_entity_util_avg(struct task_struct *p)
 		}
 	}
 
+	sa->runnable_avg = cpu_scale;
+
 	if (p->sched_class != &fair_sched_class) {
 		/*
 		 * For !fair tasks do:
@@ -3215,9 +3217,9 @@ void set_task_rq_fair(struct sched_entity *se,
  * _IFF_ we look at the pure running and runnable sums. Because they
  * represent the very same entity, just at different points in the hierarchy.
  *
- * Per the above update_tg_cfs_util() is trivial  * and simply copies the
- * running sum over (but still wrong, because the group entity and group rq do
- * not have their PELT windows aligned).
+ * Per the above update_tg_cfs_util() and update_tg_cfs_runnable() are trivial
+ * and simply copies the running/runnable sum over (but still wrong, because
+ * the group entity and group rq do not have their PELT windows aligned).
  *
  * However, update_tg_cfs_load() is more complex. So we have:
  *
@@ -3300,6 +3302,32 @@ update_tg_cfs_util(struct cfs_rq *cfs_rq, struct sched_entity *se, struct cfs_rq
 }
 
 static inline void
+update_tg_cfs_runnable(struct cfs_rq *cfs_rq, struct sched_entity *se, struct cfs_rq *gcfs_rq)
+{
+	long delta = gcfs_rq->avg.runnable_avg - se->avg.runnable_avg;
+
+	/* Nothing to update */
+	if (!delta)
+		return;
+
+	/*
+	 * The relation between sum and avg is:
+	 *
+	 *   LOAD_AVG_MAX - 1024 + sa->period_contrib
+	 *
+	 * however, the PELT windows are not aligned between grq and gse.
+	 */
+
+	/* Set new sched_entity's runnable */
+	se->avg.runnable_avg = gcfs_rq->avg.runnable_avg;
+	se->avg.runnable_sum = se->avg.runnable_avg * LOAD_AVG_MAX;
+
+	/* Update parent cfs_rq runnable */
+	add_positive(&cfs_rq->avg.runnable_avg, delta);
+	cfs_rq->avg.runnable_sum = cfs_rq->avg.runnable_avg * LOAD_AVG_MAX;
+}
+
+static inline void
 update_tg_cfs_load(struct cfs_rq *cfs_rq, struct sched_entity *se, struct cfs_rq *gcfs_rq)
 {
 	long delta_avg, running_sum, runnable_sum = gcfs_rq->prop_runnable_sum;
@@ -3379,6 +3407,7 @@ static inline int propagate_entity_load_avg(struct sched_entity *se)
 	add_tg_cfs_propagate(cfs_rq, gcfs_rq->prop_runnable_sum);
 
 	update_tg_cfs_util(cfs_rq, se, gcfs_rq);
+	update_tg_cfs_runnable(cfs_rq, se, gcfs_rq);
 	update_tg_cfs_load(cfs_rq, se, gcfs_rq);
 
 	trace_pelt_cfs_tp(cfs_rq);
@@ -3449,7 +3478,7 @@ static inline void add_tg_cfs_propagate(struct cfs_rq *cfs_rq, long runnable_sum
 static inline int
 update_cfs_rq_load_avg(u64 now, struct cfs_rq *cfs_rq)
 {
-	unsigned long removed_load = 0, removed_util = 0, removed_runnable_sum = 0;
+	unsigned long removed_load = 0, removed_util = 0, removed_runnable = 0;
 	struct sched_avg *sa = &cfs_rq->avg;
 	int decayed = 0;
 
@@ -3460,7 +3489,7 @@ update_cfs_rq_load_avg(u64 now, struct cfs_rq *cfs_rq)
 		raw_spin_lock(&cfs_rq->removed.lock);
 		swap(cfs_rq->removed.util_avg, removed_util);
 		swap(cfs_rq->removed.load_avg, removed_load);
-		swap(cfs_rq->removed.runnable_sum, removed_runnable_sum);
+		swap(cfs_rq->removed.runnable_avg, removed_runnable);
 		cfs_rq->removed.nr = 0;
 		raw_spin_unlock(&cfs_rq->removed.lock);
 
@@ -3472,7 +3501,16 @@ update_cfs_rq_load_avg(u64 now, struct cfs_rq *cfs_rq)
 		sub_positive(&sa->util_avg, r);
 		sub_positive(&sa->util_sum, r * divider);
 
-		add_tg_cfs_propagate(cfs_rq, -(long)removed_runnable_sum);
+		r = removed_runnable;
+		sub_positive(&sa->runnable_avg, r);
+		sub_positive(&sa->runnable_sum, r * divider);
+
+		/*
+		 * removed_runnable is the unweighted version of removed_load so we
+		 * can use it to estimate removed_load_sum.
+		 */
+		add_tg_cfs_propagate(cfs_rq,
+			-(long)(removed_runnable * divider) >> SCHED_CAPACITY_SHIFT);
 
 		decayed = 1;
 	}
@@ -3517,6 +3555,8 @@ static void attach_entity_load_avg(struct cfs_rq *cfs_rq, struct sched_entity *s
 	 */
 	se->avg.util_sum = se->avg.util_avg * divider;
 
+	se->avg.runnable_sum = se->avg.runnable_avg * divider;
+
 	se->avg.load_sum = divider;
 	if (se_weight(se)) {
 		se->avg.load_sum =
@@ -3526,6 +3566,8 @@ static void attach_entity_load_avg(struct cfs_rq *cfs_rq, struct sched_entity *s
 	enqueue_load_avg(cfs_rq, se);
 	cfs_rq->avg.util_avg += se->avg.util_avg;
 	cfs_rq->avg.util_sum += se->avg.util_sum;
+	cfs_rq->avg.runnable_avg += se->avg.runnable_avg;
+	cfs_rq->avg.runnable_sum += se->avg.runnable_sum;
 
 	add_tg_cfs_propagate(cfs_rq, se->avg.load_sum);
 
@@ -3547,6 +3589,8 @@ static void detach_entity_load_avg(struct cfs_rq *cfs_rq, struct sched_entity *s
 	dequeue_load_avg(cfs_rq, se);
 	sub_positive(&cfs_rq->avg.util_avg, se->avg.util_avg);
 	sub_positive(&cfs_rq->avg.util_sum, se->avg.util_sum);
+	sub_positive(&cfs_rq->avg.runnable_avg, se->avg.runnable_avg);
+	sub_positive(&cfs_rq->avg.runnable_sum, se->avg.runnable_sum);
 
 	add_tg_cfs_propagate(cfs_rq, -se->avg.load_sum);
 
@@ -3653,10 +3697,15 @@ static void remove_entity_load_avg(struct sched_entity *se)
 	++cfs_rq->removed.nr;
 	cfs_rq->removed.util_avg	+= se->avg.util_avg;
 	cfs_rq->removed.load_avg	+= se->avg.load_avg;
-	cfs_rq->removed.runnable_sum	+= se->avg.load_sum; /* == runnable_sum */
+	cfs_rq->removed.runnable_avg	+= se->avg.runnable_avg;
 	raw_spin_unlock_irqrestore(&cfs_rq->removed.lock, flags);
 }
 
+static inline unsigned long cfs_rq_runnable_avg(struct cfs_rq *cfs_rq)
+{
+	return cfs_rq->avg.runnable_avg;
+}
+
 static inline unsigned long cfs_rq_load_avg(struct cfs_rq *cfs_rq)
 {
 	return cfs_rq->avg.load_avg;
@@ -3983,11 +4032,13 @@ enqueue_entity(struct cfs_rq *cfs_rq, struct sched_entity *se, int flags)
 	/*
 	 * When enqueuing a sched_entity, we must:
 	 *   - Update loads to have both entity and cfs_rq synced with now.
+	 *   - Add its load to cfs_rq->runnable_avg
 	 *   - For group_entity, update its weight to reflect the new share of
 	 *     its group cfs_rq
 	 *   - Add its new weight to cfs_rq->load.weight
 	 */
 	update_load_avg(cfs_rq, se, UPDATE_TG | DO_ATTACH);
+	se_update_runnable(se);
 	update_cfs_group(se);
 	account_entity_enqueue(cfs_rq, se);
 
@@ -4065,11 +4116,13 @@ dequeue_entity(struct cfs_rq *cfs_rq, struct sched_entity *se, int flags)
 	/*
 	 * When dequeuing a sched_entity, we must:
 	 *   - Update loads to have both entity and cfs_rq synced with now.
+	 *   - Subtract its load from the cfs_rq->runnable_avg.
 	 *   - Subtract its previous weight from cfs_rq->load.weight.
 	 *   - For group entity, update its weight to reflect the new share
 	 *     of its group cfs_rq.
 	 */
 	update_load_avg(cfs_rq, se, UPDATE_TG);
+	se_update_runnable(se);
 
 	update_stats_dequeue(cfs_rq, se, flags);
 
@@ -5240,6 +5293,7 @@ enqueue_task_fair(struct rq *rq, struct task_struct *p, int flags)
 			goto enqueue_throttle;
 
 		update_load_avg(cfs_rq, se, UPDATE_TG);
+		se_update_runnable(se);
 		update_cfs_group(se);
 
 		cfs_rq->h_nr_running++;
@@ -5337,6 +5391,7 @@ static void dequeue_task_fair(struct rq *rq, struct task_struct *p, int flags)
 			goto dequeue_throttle;
 
 		update_load_avg(cfs_rq, se, UPDATE_TG);
+		se_update_runnable(se);
 		update_cfs_group(se);
 
 		cfs_rq->h_nr_running--;
@@ -5409,6 +5464,11 @@ static unsigned long cpu_load_without(struct rq *rq, struct task_struct *p)
 	return load;
 }
 
+static unsigned long cpu_runnable(struct rq *rq)
+{
+	return cfs_rq_runnable_avg(&rq->cfs);
+}
+
 static unsigned long capacity_of(int cpu)
 {
 	return cpu_rq(cpu)->cpu_capacity;
@@ -7554,6 +7614,9 @@ static inline bool cfs_rq_is_decayed(struct cfs_rq *cfs_rq)
 	if (cfs_rq->avg.util_sum)
 		return false;
 
+	if (cfs_rq->avg.runnable_sum)
+		return false;
+
 	return true;
 }
 
diff --git a/kernel/sched/pelt.c b/kernel/sched/pelt.c
index 3eb0ed3..c40d57a 100644
--- a/kernel/sched/pelt.c
+++ b/kernel/sched/pelt.c
@@ -108,7 +108,7 @@ static u32 __accumulate_pelt_segments(u64 periods, u32 d1, u32 d3)
  */
 static __always_inline u32
 accumulate_sum(u64 delta, struct sched_avg *sa,
-	       unsigned long load, int running)
+	       unsigned long load, unsigned long runnable, int running)
 {
 	u32 contrib = (u32)delta; /* p == 0 -> delta < 1024 */
 	u64 periods;
@@ -121,6 +121,8 @@ accumulate_sum(u64 delta, struct sched_avg *sa,
 	 */
 	if (periods) {
 		sa->load_sum = decay_load(sa->load_sum, periods);
+		sa->runnable_sum =
+			decay_load(sa->runnable_sum, periods);
 		sa->util_sum = decay_load((u64)(sa->util_sum), periods);
 
 		/*
@@ -146,6 +148,8 @@ accumulate_sum(u64 delta, struct sched_avg *sa,
 
 	if (load)
 		sa->load_sum += load * contrib;
+	if (runnable)
+		sa->runnable_sum += runnable * contrib << SCHED_CAPACITY_SHIFT;
 	if (running)
 		sa->util_sum += contrib << SCHED_CAPACITY_SHIFT;
 
@@ -182,7 +186,7 @@ accumulate_sum(u64 delta, struct sched_avg *sa,
  */
 static __always_inline int
 ___update_load_sum(u64 now, struct sched_avg *sa,
-		  unsigned long load, int running)
+		  unsigned long load, unsigned long runnable, int running)
 {
 	u64 delta;
 
@@ -218,7 +222,7 @@ ___update_load_sum(u64 now, struct sched_avg *sa,
 	 * Also see the comment in accumulate_sum().
 	 */
 	if (!load)
-		running = 0;
+		runnable = running = 0;
 
 	/*
 	 * Now we know we crossed measurement unit boundaries. The *_avg
@@ -227,7 +231,7 @@ ___update_load_sum(u64 now, struct sched_avg *sa,
 	 * Step 1: accumulate *_sum since last_update_time. If we haven't
 	 * crossed period boundaries, finish.
 	 */
-	if (!accumulate_sum(delta, sa, load, running))
+	if (!accumulate_sum(delta, sa, load, runnable, running))
 		return 0;
 
 	return 1;
@@ -242,6 +246,7 @@ ___update_load_avg(struct sched_avg *sa, unsigned long load)
 	 * Step 2: update *_avg.
 	 */
 	sa->load_avg = div_u64(load * sa->load_sum, divider);
+	sa->runnable_avg = div_u64(sa->runnable_sum, divider);
 	WRITE_ONCE(sa->util_avg, sa->util_sum / divider);
 }
 
@@ -250,24 +255,30 @@ ___update_load_avg(struct sched_avg *sa, unsigned long load)
  *
  *   task:
  *     se_weight()   = se->load.weight
+ *     se_runnable() = !!on_rq
  *
  *   group: [ see update_cfs_group() ]
  *     se_weight()   = tg->weight * grq->load_avg / tg->load_avg
+ *     se_runnable() = grq->h_nr_running
+ *
+ *   runnable_sum = se_runnable() * runnable = grq->runnable_sum
+ *   runnable_avg = runnable_sum
  *
  *   load_sum := runnable
  *   load_avg = se_weight(se) * load_sum
  *
- * XXX collapse load_sum and runnable_load_sum
- *
  * cfq_rq:
  *
+ *   runnable_sum = \Sum se->avg.runnable_sum
+ *   runnable_avg = \Sum se->avg.runnable_avg
+ *
  *   load_sum = \Sum se_weight(se) * se->avg.load_sum
  *   load_avg = \Sum se->avg.load_avg
  */
 
 int __update_load_avg_blocked_se(u64 now, struct sched_entity *se)
 {
-	if (___update_load_sum(now, &se->avg, 0, 0)) {
+	if (___update_load_sum(now, &se->avg, 0, 0, 0)) {
 		___update_load_avg(&se->avg, se_weight(se));
 		trace_pelt_se_tp(se);
 		return 1;
@@ -278,7 +289,8 @@ int __update_load_avg_blocked_se(u64 now, struct sched_entity *se)
 
 int __update_load_avg_se(u64 now, struct cfs_rq *cfs_rq, struct sched_entity *se)
 {
-	if (___update_load_sum(now, &se->avg, !!se->on_rq, cfs_rq->curr == se)) {
+	if (___update_load_sum(now, &se->avg, !!se->on_rq, se_runnable(se),
+				cfs_rq->curr == se)) {
 
 		___update_load_avg(&se->avg, se_weight(se));
 		cfs_se_util_change(&se->avg);
@@ -293,6 +305,7 @@ int __update_load_avg_cfs_rq(u64 now, struct cfs_rq *cfs_rq)
 {
 	if (___update_load_sum(now, &cfs_rq->avg,
 				scale_load_down(cfs_rq->load.weight),
+				cfs_rq->h_nr_running,
 				cfs_rq->curr != NULL)) {
 
 		___update_load_avg(&cfs_rq->avg, 1);
@@ -310,7 +323,7 @@ int __update_load_avg_cfs_rq(u64 now, struct cfs_rq *cfs_rq)
  *   util_sum = cpu_scale * load_sum
  *   runnable_sum = util_sum
  *
- *   load_avg is not supported and meaningless.
+ *   load_avg and runnable_avg are not supported and meaningless.
  *
  */
 
@@ -318,6 +331,7 @@ int update_rt_rq_load_avg(u64 now, struct rq *rq, int running)
 {
 	if (___update_load_sum(now, &rq->avg_rt,
 				running,
+				running,
 				running)) {
 
 		___update_load_avg(&rq->avg_rt, 1);
@@ -335,7 +349,7 @@ int update_rt_rq_load_avg(u64 now, struct rq *rq, int running)
  *   util_sum = cpu_scale * load_sum
  *   runnable_sum = util_sum
  *
- *   load_avg is not supported and meaningless.
+ *   load_avg and runnable_avg are not supported and meaningless.
  *
  */
 
@@ -343,6 +357,7 @@ int update_dl_rq_load_avg(u64 now, struct rq *rq, int running)
 {
 	if (___update_load_sum(now, &rq->avg_dl,
 				running,
+				running,
 				running)) {
 
 		___update_load_avg(&rq->avg_dl, 1);
@@ -361,7 +376,7 @@ int update_dl_rq_load_avg(u64 now, struct rq *rq, int running)
  *   util_sum = cpu_scale * load_sum
  *   runnable_sum = util_sum
  *
- *   load_avg is not supported and meaningless.
+ *   load_avg and runnable_avg are not supported and meaningless.
  *
  */
 
@@ -390,9 +405,11 @@ int update_irq_load_avg(struct rq *rq, u64 running)
 	 */
 	ret = ___update_load_sum(rq->clock - running, &rq->avg_irq,
 				0,
+				0,
 				0);
 	ret += ___update_load_sum(rq->clock, &rq->avg_irq,
 				1,
+				1,
 				1);
 
 	if (ret) {
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index ce27e58..2a0caf3 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -527,7 +527,7 @@ struct cfs_rq {
 		int		nr;
 		unsigned long	load_avg;
 		unsigned long	util_avg;
-		unsigned long	runnable_sum;
+		unsigned long	runnable_avg;
 	} removed;
 
 #ifdef CONFIG_FAIR_GROUP_SCHED
@@ -688,9 +688,29 @@ struct dl_rq {
 /* An entity is a task if it doesn't "own" a runqueue */
 #define entity_is_task(se)	(!se->my_q)
 
+static inline void se_update_runnable(struct sched_entity *se)
+{
+	if (!entity_is_task(se))
+		se->runnable_weight = se->my_q->h_nr_running;
+}
+
+static inline long se_runnable(struct sched_entity *se)
+{
+	if (entity_is_task(se))
+		return !!se->on_rq;
+	else
+		return se->runnable_weight;
+}
+
 #else
 #define entity_is_task(se)	1
 
+static inline void se_update_runnable(struct sched_entity *se) {}
+
+static inline long se_runnable(struct sched_entity *se)
+{
+	return !!se->on_rq;
+}
 #endif
 
 #ifdef CONFIG_SMP
