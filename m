Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 24DB7422A6F
	for <lists+linux-tip-commits@lfdr.de>; Tue,  5 Oct 2021 16:12:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236161AbhJEOOb (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Tue, 5 Oct 2021 10:14:31 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:51358 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235560AbhJEOOC (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Tue, 5 Oct 2021 10:14:02 -0400
Date:   Tue, 05 Oct 2021 14:12:09 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1633443130;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=eLDuY9x85l7oD9bsUXiUeOuWIUVrEJL2zv/Stwi51TQ=;
        b=SceuZhzmE505Q5pj/lHorqPCgPPBih3CPHSAH/WyfJxBgZ0Cy2k6eh0JJxeMPIcMEiPQ5x
        5bj7kVHHAFojR/tqehIP/fn3WvQbw+ULOhiQ2IfFZwdv7hR1N4z44WNGIfPy9unFQOysT1
        BW9Q/7oMHGL3srEd3j9oayiMbpbut9KZY/9gfwHATIezXuId+SqOnKrXzWZstQW5mk6TJe
        mPo/FQHF33b+/cjiihY7oJmpY0uA4zpMz3Nb+EznO9dpaYSefJ17ECTzIfUGD0Xmd8NOa3
        PpZzv5TD87bJhwJYWBHCC2MOV11m6nONFrBzNuozDtuJafym7TcbQMq6YjYgOg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1633443130;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=eLDuY9x85l7oD9bsUXiUeOuWIUVrEJL2zv/Stwi51TQ=;
        b=D4I2FlhNqcM5NBwiECWFebMAxXupRp/7HbEgKH7LoYQtR2N3IkHg9D5C8wgrK0dWuKOkG/
        3r4Rzy4Tld9sBkBw==
From:   "tip-bot2 for Yafang Shao" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched: Make struct sched_statistics independent of
 fair sched class
Cc:     Yafang Shao <laoar.shao@gmail.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Mel Gorman <mgorman@suse.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210905143547.4668-3-laoar.shao@gmail.com>
References: <20210905143547.4668-3-laoar.shao@gmail.com>
MIME-Version: 1.0
Message-ID: <163344312971.25758.1469804727908161648.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     ceeadb83aea28372e54857bf88ab7e17af48ab7b
Gitweb:        https://git.kernel.org/tip/ceeadb83aea28372e54857bf88ab7e17af48ab7b
Author:        Yafang Shao <laoar.shao@gmail.com>
AuthorDate:    Sun, 05 Sep 2021 14:35:41 
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 05 Oct 2021 15:51:45 +02:00

sched: Make struct sched_statistics independent of fair sched class

If we want to use the schedstats facility to trace other sched classes, we
should make it independent of fair sched class. The struct sched_statistics
is the schedular statistics of a task_struct or a task_group. So we can
move it into struct task_struct and struct task_group to achieve the goal.

After the patch, schestats are orgnized as follows,

    struct task_struct {
       ...
       struct sched_entity se;
       struct sched_rt_entity rt;
       struct sched_dl_entity dl;
       ...
       struct sched_statistics stats;
       ...
   };

Regarding the task group, schedstats is only supported for fair group
sched, and a new struct sched_entity_stats is introduced, suggested by
Peter -

    struct sched_entity_stats {
        struct sched_entity     se;
        struct sched_statistics stats;
    } __no_randomize_layout;

Then with the se in a task_group, we can easily get the stats.

The sched_statistics members may be frequently modified when schedstats is
enabled, in order to avoid impacting on random data which may in the same
cacheline with them, the struct sched_statistics is defined as cacheline
aligned.

As this patch changes the core struct of scheduler, so I verified the
performance it may impact on the scheduler with 'perf bench sched
pipe', suggested by Mel. Below is the result, in which all the values
are in usecs/op.
                                  Before               After
      kernel.sched_schedstats=0  5.2~5.4               5.2~5.4
      kernel.sched_schedstats=1  5.3~5.5               5.3~5.5
[These data is a little difference with the earlier version, that is
 because my old test machine is destroyed so I have to use a new
 different test machine.]

Almost no impact on the sched performance.

No functional change.

[lkp@intel.com: reported build failure in earlier version]

Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Mel Gorman <mgorman@suse.de>
Link: https://lore.kernel.org/r/20210905143547.4668-3-laoar.shao@gmail.com
---
 include/linux/sched.h    |  6 +--
 kernel/sched/core.c      | 25 ++++++-----
 kernel/sched/deadline.c  |  4 +-
 kernel/sched/debug.c     | 92 ++++++++++++++++++++-------------------
 kernel/sched/fair.c      | 89 ++++++++++++++++++++++----------------
 kernel/sched/rt.c        |  4 +-
 kernel/sched/stats.h     | 19 ++++++++-
 kernel/sched/stop_task.c |  4 +-
 8 files changed, 143 insertions(+), 100 deletions(-)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index c1a927d..2bc4c72 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -522,7 +522,7 @@ struct sched_statistics {
 	u64				nr_wakeups_passive;
 	u64				nr_wakeups_idle;
 #endif
-};
+} ____cacheline_aligned;
 
 struct sched_entity {
 	/* For load-balancing: */
@@ -538,8 +538,6 @@ struct sched_entity {
 
 	u64				nr_migrations;
 
-	struct sched_statistics		statistics;
-
 #ifdef CONFIG_FAIR_GROUP_SCHED
 	int				depth;
 	struct sched_entity		*parent;
@@ -803,6 +801,8 @@ struct task_struct {
 	struct uclamp_se		uclamp[UCLAMP_CNT];
 #endif
 
+	struct sched_statistics         stats;
+
 #ifdef CONFIG_PREEMPT_NOTIFIERS
 	/* List of struct preempt_notifier: */
 	struct hlist_head		preempt_notifiers;
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index ccb604a..a1741e0 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -3489,11 +3489,11 @@ ttwu_stat(struct task_struct *p, int cpu, int wake_flags)
 #ifdef CONFIG_SMP
 	if (cpu == rq->cpu) {
 		__schedstat_inc(rq->ttwu_local);
-		__schedstat_inc(p->se.statistics.nr_wakeups_local);
+		__schedstat_inc(p->stats.nr_wakeups_local);
 	} else {
 		struct sched_domain *sd;
 
-		__schedstat_inc(p->se.statistics.nr_wakeups_remote);
+		__schedstat_inc(p->stats.nr_wakeups_remote);
 		rcu_read_lock();
 		for_each_domain(rq->cpu, sd) {
 			if (cpumask_test_cpu(cpu, sched_domain_span(sd))) {
@@ -3505,14 +3505,14 @@ ttwu_stat(struct task_struct *p, int cpu, int wake_flags)
 	}
 
 	if (wake_flags & WF_MIGRATED)
-		__schedstat_inc(p->se.statistics.nr_wakeups_migrate);
+		__schedstat_inc(p->stats.nr_wakeups_migrate);
 #endif /* CONFIG_SMP */
 
 	__schedstat_inc(rq->ttwu_count);
-	__schedstat_inc(p->se.statistics.nr_wakeups);
+	__schedstat_inc(p->stats.nr_wakeups);
 
 	if (wake_flags & WF_SYNC)
-		__schedstat_inc(p->se.statistics.nr_wakeups_sync);
+		__schedstat_inc(p->stats.nr_wakeups_sync);
 }
 
 /*
@@ -4196,7 +4196,7 @@ static void __sched_fork(unsigned long clone_flags, struct task_struct *p)
 
 #ifdef CONFIG_SCHEDSTATS
 	/* Even if schedstat is disabled, there should not be garbage */
-	memset(&p->se.statistics, 0, sizeof(p->se.statistics));
+	memset(&p->stats, 0, sizeof(p->stats));
 #endif
 
 	RB_CLEAR_NODE(&p->dl.rb_node);
@@ -9553,9 +9553,9 @@ void normalize_rt_tasks(void)
 			continue;
 
 		p->se.exec_start = 0;
-		schedstat_set(p->se.statistics.wait_start,  0);
-		schedstat_set(p->se.statistics.sleep_start, 0);
-		schedstat_set(p->se.statistics.block_start, 0);
+		schedstat_set(p->stats.wait_start,  0);
+		schedstat_set(p->stats.sleep_start, 0);
+		schedstat_set(p->stats.block_start, 0);
 
 		if (!dl_task(p) && !rt_task(p)) {
 			/*
@@ -10397,11 +10397,14 @@ static int cpu_cfs_stat_show(struct seq_file *sf, void *v)
 	seq_printf(sf, "throttled_time %llu\n", cfs_b->throttled_time);
 
 	if (schedstat_enabled() && tg != &root_task_group) {
+		struct sched_statistics *stats;
 		u64 ws = 0;
 		int i;
 
-		for_each_possible_cpu(i)
-			ws += schedstat_val(tg->se[i]->statistics.wait_sum);
+		for_each_possible_cpu(i) {
+			stats = __schedstats_from_se(tg->se[i]);
+			ws += schedstat_val(stats->wait_sum);
+		}
 
 		seq_printf(sf, "wait_sum %llu\n", ws);
 	}
diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index e943146..51dd309 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -1265,8 +1265,8 @@ static void update_curr_dl(struct rq *rq)
 		return;
 	}
 
-	schedstat_set(curr->se.statistics.exec_max,
-		      max(curr->se.statistics.exec_max, delta_exec));
+	schedstat_set(curr->stats.exec_max,
+		      max(curr->stats.exec_max, delta_exec));
 
 	curr->se.sum_exec_runtime += delta_exec;
 	account_group_exec_runtime(curr, delta_exec);
diff --git a/kernel/sched/debug.c b/kernel/sched/debug.c
index 34913a7..76fd38e 100644
--- a/kernel/sched/debug.c
+++ b/kernel/sched/debug.c
@@ -449,9 +449,11 @@ static void print_cfs_group_stats(struct seq_file *m, int cpu, struct task_group
 	struct sched_entity *se = tg->se[cpu];
 
 #define P(F)		SEQ_printf(m, "  .%-30s: %lld\n",	#F, (long long)F)
-#define P_SCHEDSTAT(F)	SEQ_printf(m, "  .%-30s: %lld\n",	#F, (long long)schedstat_val(F))
+#define P_SCHEDSTAT(F)	SEQ_printf(m, "  .%-30s: %lld\n",	\
+		#F, (long long)schedstat_val(stats->F))
 #define PN(F)		SEQ_printf(m, "  .%-30s: %lld.%06ld\n", #F, SPLIT_NS((long long)F))
-#define PN_SCHEDSTAT(F)	SEQ_printf(m, "  .%-30s: %lld.%06ld\n", #F, SPLIT_NS((long long)schedstat_val(F)))
+#define PN_SCHEDSTAT(F)	SEQ_printf(m, "  .%-30s: %lld.%06ld\n", \
+		#F, SPLIT_NS((long long)schedstat_val(stats->F)))
 
 	if (!se)
 		return;
@@ -461,16 +463,18 @@ static void print_cfs_group_stats(struct seq_file *m, int cpu, struct task_group
 	PN(se->sum_exec_runtime);
 
 	if (schedstat_enabled()) {
-		PN_SCHEDSTAT(se->statistics.wait_start);
-		PN_SCHEDSTAT(se->statistics.sleep_start);
-		PN_SCHEDSTAT(se->statistics.block_start);
-		PN_SCHEDSTAT(se->statistics.sleep_max);
-		PN_SCHEDSTAT(se->statistics.block_max);
-		PN_SCHEDSTAT(se->statistics.exec_max);
-		PN_SCHEDSTAT(se->statistics.slice_max);
-		PN_SCHEDSTAT(se->statistics.wait_max);
-		PN_SCHEDSTAT(se->statistics.wait_sum);
-		P_SCHEDSTAT(se->statistics.wait_count);
+               struct sched_statistics *stats =  __schedstats_from_se(se);
+
+		PN_SCHEDSTAT(wait_start);
+		PN_SCHEDSTAT(sleep_start);
+		PN_SCHEDSTAT(block_start);
+		PN_SCHEDSTAT(sleep_max);
+		PN_SCHEDSTAT(block_max);
+		PN_SCHEDSTAT(exec_max);
+		PN_SCHEDSTAT(slice_max);
+		PN_SCHEDSTAT(wait_max);
+		PN_SCHEDSTAT(wait_sum);
+		P_SCHEDSTAT(wait_count);
 	}
 
 	P(se->load.weight);
@@ -537,9 +541,9 @@ print_task(struct seq_file *m, struct rq *rq, struct task_struct *p)
 		p->prio);
 
 	SEQ_printf(m, "%9Ld.%06ld %9Ld.%06ld %9Ld.%06ld",
-		SPLIT_NS(schedstat_val_or_zero(p->se.statistics.wait_sum)),
+		SPLIT_NS(schedstat_val_or_zero(p->stats.wait_sum)),
 		SPLIT_NS(p->se.sum_exec_runtime),
-		SPLIT_NS(schedstat_val_or_zero(p->se.statistics.sum_sleep_runtime)));
+		SPLIT_NS(schedstat_val_or_zero(p->stats.sum_sleep_runtime)));
 
 #ifdef CONFIG_NUMA_BALANCING
 	SEQ_printf(m, " %d %d", task_node(p), task_numa_group_id(p));
@@ -958,8 +962,8 @@ void proc_sched_show_task(struct task_struct *p, struct pid_namespace *ns,
 		"---------------------------------------------------------"
 		"----------\n");
 
-#define P_SCHEDSTAT(F)  __PS(#F, schedstat_val(p->F))
-#define PN_SCHEDSTAT(F) __PSN(#F, schedstat_val(p->F))
+#define P_SCHEDSTAT(F)  __PS(#F, schedstat_val(p->stats.F))
+#define PN_SCHEDSTAT(F) __PSN(#F, schedstat_val(p->stats.F))
 
 	PN(se.exec_start);
 	PN(se.vruntime);
@@ -972,33 +976,33 @@ void proc_sched_show_task(struct task_struct *p, struct pid_namespace *ns,
 	if (schedstat_enabled()) {
 		u64 avg_atom, avg_per_cpu;
 
-		PN_SCHEDSTAT(se.statistics.sum_sleep_runtime);
-		PN_SCHEDSTAT(se.statistics.wait_start);
-		PN_SCHEDSTAT(se.statistics.sleep_start);
-		PN_SCHEDSTAT(se.statistics.block_start);
-		PN_SCHEDSTAT(se.statistics.sleep_max);
-		PN_SCHEDSTAT(se.statistics.block_max);
-		PN_SCHEDSTAT(se.statistics.exec_max);
-		PN_SCHEDSTAT(se.statistics.slice_max);
-		PN_SCHEDSTAT(se.statistics.wait_max);
-		PN_SCHEDSTAT(se.statistics.wait_sum);
-		P_SCHEDSTAT(se.statistics.wait_count);
-		PN_SCHEDSTAT(se.statistics.iowait_sum);
-		P_SCHEDSTAT(se.statistics.iowait_count);
-		P_SCHEDSTAT(se.statistics.nr_migrations_cold);
-		P_SCHEDSTAT(se.statistics.nr_failed_migrations_affine);
-		P_SCHEDSTAT(se.statistics.nr_failed_migrations_running);
-		P_SCHEDSTAT(se.statistics.nr_failed_migrations_hot);
-		P_SCHEDSTAT(se.statistics.nr_forced_migrations);
-		P_SCHEDSTAT(se.statistics.nr_wakeups);
-		P_SCHEDSTAT(se.statistics.nr_wakeups_sync);
-		P_SCHEDSTAT(se.statistics.nr_wakeups_migrate);
-		P_SCHEDSTAT(se.statistics.nr_wakeups_local);
-		P_SCHEDSTAT(se.statistics.nr_wakeups_remote);
-		P_SCHEDSTAT(se.statistics.nr_wakeups_affine);
-		P_SCHEDSTAT(se.statistics.nr_wakeups_affine_attempts);
-		P_SCHEDSTAT(se.statistics.nr_wakeups_passive);
-		P_SCHEDSTAT(se.statistics.nr_wakeups_idle);
+		PN_SCHEDSTAT(sum_sleep_runtime);
+		PN_SCHEDSTAT(wait_start);
+		PN_SCHEDSTAT(sleep_start);
+		PN_SCHEDSTAT(block_start);
+		PN_SCHEDSTAT(sleep_max);
+		PN_SCHEDSTAT(block_max);
+		PN_SCHEDSTAT(exec_max);
+		PN_SCHEDSTAT(slice_max);
+		PN_SCHEDSTAT(wait_max);
+		PN_SCHEDSTAT(wait_sum);
+		P_SCHEDSTAT(wait_count);
+		PN_SCHEDSTAT(iowait_sum);
+		P_SCHEDSTAT(iowait_count);
+		P_SCHEDSTAT(nr_migrations_cold);
+		P_SCHEDSTAT(nr_failed_migrations_affine);
+		P_SCHEDSTAT(nr_failed_migrations_running);
+		P_SCHEDSTAT(nr_failed_migrations_hot);
+		P_SCHEDSTAT(nr_forced_migrations);
+		P_SCHEDSTAT(nr_wakeups);
+		P_SCHEDSTAT(nr_wakeups_sync);
+		P_SCHEDSTAT(nr_wakeups_migrate);
+		P_SCHEDSTAT(nr_wakeups_local);
+		P_SCHEDSTAT(nr_wakeups_remote);
+		P_SCHEDSTAT(nr_wakeups_affine);
+		P_SCHEDSTAT(nr_wakeups_affine_attempts);
+		P_SCHEDSTAT(nr_wakeups_passive);
+		P_SCHEDSTAT(nr_wakeups_idle);
 
 		avg_atom = p->se.sum_exec_runtime;
 		if (nr_switches)
@@ -1064,7 +1068,7 @@ void proc_sched_show_task(struct task_struct *p, struct pid_namespace *ns,
 void proc_sched_set_task(struct task_struct *p)
 {
 #ifdef CONFIG_SCHEDSTATS
-	memset(&p->se.statistics, 0, sizeof(p->se.statistics));
+	memset(&p->stats, 0, sizeof(p->stats));
 #endif
 }
 
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 61d3e3b..97c6ecb 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -856,8 +856,13 @@ static void update_curr(struct cfs_rq *cfs_rq)
 
 	curr->exec_start = now;
 
-	schedstat_set(curr->statistics.exec_max,
-		      max(delta_exec, curr->statistics.exec_max));
+	if (schedstat_enabled()) {
+		struct sched_statistics *stats;
+
+		stats = __schedstats_from_se(curr);
+		__schedstat_set(stats->exec_max,
+				max(delta_exec, stats->exec_max));
+	}
 
 	curr->sum_exec_runtime += delta_exec;
 	schedstat_add(cfs_rq->exec_clock, delta_exec);
@@ -885,39 +890,45 @@ static inline void
 update_stats_wait_start(struct cfs_rq *cfs_rq, struct sched_entity *se)
 {
 	u64 wait_start, prev_wait_start;
+	struct sched_statistics *stats;
 
 	if (!schedstat_enabled())
 		return;
 
+	stats = __schedstats_from_se(se);
+
 	wait_start = rq_clock(rq_of(cfs_rq));
-	prev_wait_start = schedstat_val(se->statistics.wait_start);
+	prev_wait_start = schedstat_val(stats->wait_start);
 
 	if (entity_is_task(se) && task_on_rq_migrating(task_of(se)) &&
 	    likely(wait_start > prev_wait_start))
 		wait_start -= prev_wait_start;
 
-	__schedstat_set(se->statistics.wait_start, wait_start);
+	__schedstat_set(stats->wait_start, wait_start);
 }
 
 static inline void
 update_stats_wait_end(struct cfs_rq *cfs_rq, struct sched_entity *se)
 {
-	struct task_struct *p;
+	struct sched_statistics *stats;
+	struct task_struct *p = NULL;
 	u64 delta;
 
 	if (!schedstat_enabled())
 		return;
 
+	stats = __schedstats_from_se(se);
+
 	/*
 	 * When the sched_schedstat changes from 0 to 1, some sched se
 	 * maybe already in the runqueue, the se->statistics.wait_start
 	 * will be 0.So it will let the delta wrong. We need to avoid this
 	 * scenario.
 	 */
-	if (unlikely(!schedstat_val(se->statistics.wait_start)))
+	if (unlikely(!schedstat_val(stats->wait_start)))
 		return;
 
-	delta = rq_clock(rq_of(cfs_rq)) - schedstat_val(se->statistics.wait_start);
+	delta = rq_clock(rq_of(cfs_rq)) - schedstat_val(stats->wait_start);
 
 	if (entity_is_task(se)) {
 		p = task_of(se);
@@ -927,30 +938,33 @@ update_stats_wait_end(struct cfs_rq *cfs_rq, struct sched_entity *se)
 			 * time stamp can be adjusted to accumulate wait time
 			 * prior to migration.
 			 */
-			__schedstat_set(se->statistics.wait_start, delta);
+			__schedstat_set(stats->wait_start, delta);
 			return;
 		}
 		trace_sched_stat_wait(p, delta);
 	}
 
-	__schedstat_set(se->statistics.wait_max,
-		      max(schedstat_val(se->statistics.wait_max), delta));
-	__schedstat_inc(se->statistics.wait_count);
-	__schedstat_add(se->statistics.wait_sum, delta);
-	__schedstat_set(se->statistics.wait_start, 0);
+	__schedstat_set(stats->wait_max,
+		      max(schedstat_val(stats->wait_max), delta));
+	__schedstat_inc(stats->wait_count);
+	__schedstat_add(stats->wait_sum, delta);
+	__schedstat_set(stats->wait_start, 0);
 }
 
 static inline void
 update_stats_enqueue_sleeper(struct cfs_rq *cfs_rq, struct sched_entity *se)
 {
+	struct sched_statistics *stats;
 	struct task_struct *tsk = NULL;
 	u64 sleep_start, block_start;
 
 	if (!schedstat_enabled())
 		return;
 
-	sleep_start = schedstat_val(se->statistics.sleep_start);
-	block_start = schedstat_val(se->statistics.block_start);
+	stats = __schedstats_from_se(se);
+
+	sleep_start = schedstat_val(stats->sleep_start);
+	block_start = schedstat_val(stats->block_start);
 
 	if (entity_is_task(se))
 		tsk = task_of(se);
@@ -961,11 +975,11 @@ update_stats_enqueue_sleeper(struct cfs_rq *cfs_rq, struct sched_entity *se)
 		if ((s64)delta < 0)
 			delta = 0;
 
-		if (unlikely(delta > schedstat_val(se->statistics.sleep_max)))
-			__schedstat_set(se->statistics.sleep_max, delta);
+		if (unlikely(delta > schedstat_val(stats->sleep_max)))
+			__schedstat_set(stats->sleep_max, delta);
 
-		__schedstat_set(se->statistics.sleep_start, 0);
-		__schedstat_add(se->statistics.sum_sleep_runtime, delta);
+		__schedstat_set(stats->sleep_start, 0);
+		__schedstat_add(stats->sum_sleep_runtime, delta);
 
 		if (tsk) {
 			account_scheduler_latency(tsk, delta >> 10, 1);
@@ -978,16 +992,16 @@ update_stats_enqueue_sleeper(struct cfs_rq *cfs_rq, struct sched_entity *se)
 		if ((s64)delta < 0)
 			delta = 0;
 
-		if (unlikely(delta > schedstat_val(se->statistics.block_max)))
-			__schedstat_set(se->statistics.block_max, delta);
+		if (unlikely(delta > schedstat_val(stats->block_max)))
+			__schedstat_set(stats->block_max, delta);
 
-		__schedstat_set(se->statistics.block_start, 0);
-		__schedstat_add(se->statistics.sum_sleep_runtime, delta);
+		__schedstat_set(stats->block_start, 0);
+		__schedstat_add(stats->sum_sleep_runtime, delta);
 
 		if (tsk) {
 			if (tsk->in_iowait) {
-				__schedstat_add(se->statistics.iowait_sum, delta);
-				__schedstat_inc(se->statistics.iowait_count);
+				__schedstat_add(stats->iowait_sum, delta);
+				__schedstat_inc(stats->iowait_count);
 				trace_sched_stat_iowait(tsk, delta);
 			}
 
@@ -1049,10 +1063,10 @@ update_stats_dequeue(struct cfs_rq *cfs_rq, struct sched_entity *se, int flags)
 		/* XXX racy against TTWU */
 		state = READ_ONCE(tsk->__state);
 		if (state & TASK_INTERRUPTIBLE)
-			__schedstat_set(se->statistics.sleep_start,
+			__schedstat_set(tsk->stats.sleep_start,
 				      rq_clock(rq_of(cfs_rq)));
 		if (state & TASK_UNINTERRUPTIBLE)
-			__schedstat_set(se->statistics.block_start,
+			__schedstat_set(tsk->stats.block_start,
 				      rq_clock(rq_of(cfs_rq)));
 	}
 }
@@ -4530,8 +4544,11 @@ set_next_entity(struct cfs_rq *cfs_rq, struct sched_entity *se)
 	 */
 	if (schedstat_enabled() &&
 	    rq_of(cfs_rq)->cfs.load.weight >= 2*se->load.weight) {
-		__schedstat_set(se->statistics.slice_max,
-				max((u64)se->statistics.slice_max,
+		struct sched_statistics *stats;
+
+		stats = __schedstats_from_se(se);
+		__schedstat_set(stats->slice_max,
+				max((u64)stats->slice_max,
 				    se->sum_exec_runtime - se->prev_sum_exec_runtime));
 	}
 
@@ -6046,12 +6063,12 @@ static int wake_affine(struct sched_domain *sd, struct task_struct *p,
 	if (sched_feat(WA_WEIGHT) && target == nr_cpumask_bits)
 		target = wake_affine_weight(sd, p, this_cpu, prev_cpu, sync);
 
-	schedstat_inc(p->se.statistics.nr_wakeups_affine_attempts);
+	schedstat_inc(p->stats.nr_wakeups_affine_attempts);
 	if (target == nr_cpumask_bits)
 		return prev_cpu;
 
 	schedstat_inc(sd->ttwu_move_affine);
-	schedstat_inc(p->se.statistics.nr_wakeups_affine);
+	schedstat_inc(p->stats.nr_wakeups_affine);
 	return target;
 }
 
@@ -7855,7 +7872,7 @@ int can_migrate_task(struct task_struct *p, struct lb_env *env)
 	if (!cpumask_test_cpu(env->dst_cpu, p->cpus_ptr)) {
 		int cpu;
 
-		schedstat_inc(p->se.statistics.nr_failed_migrations_affine);
+		schedstat_inc(p->stats.nr_failed_migrations_affine);
 
 		env->flags |= LBF_SOME_PINNED;
 
@@ -7889,7 +7906,7 @@ int can_migrate_task(struct task_struct *p, struct lb_env *env)
 	env->flags &= ~LBF_ALL_PINNED;
 
 	if (task_running(env->src_rq, p)) {
-		schedstat_inc(p->se.statistics.nr_failed_migrations_running);
+		schedstat_inc(p->stats.nr_failed_migrations_running);
 		return 0;
 	}
 
@@ -7911,12 +7928,12 @@ int can_migrate_task(struct task_struct *p, struct lb_env *env)
 	    env->sd->nr_balance_failed > env->sd->cache_nice_tries) {
 		if (tsk_cache_hot == 1) {
 			schedstat_inc(env->sd->lb_hot_gained[env->idle]);
-			schedstat_inc(p->se.statistics.nr_forced_migrations);
+			schedstat_inc(p->stats.nr_forced_migrations);
 		}
 		return 1;
 	}
 
-	schedstat_inc(p->se.statistics.nr_failed_migrations_hot);
+	schedstat_inc(p->stats.nr_failed_migrations_hot);
 	return 0;
 }
 
@@ -11457,7 +11474,7 @@ int alloc_fair_sched_group(struct task_group *tg, struct task_group *parent)
 		if (!cfs_rq)
 			goto err;
 
-		se = kzalloc_node(sizeof(struct sched_entity),
+		se = kzalloc_node(sizeof(struct sched_entity_stats),
 				  GFP_KERNEL, cpu_to_node(i));
 		if (!se)
 			goto err_free_rq;
diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
index 3daf42a..95a7c3a 100644
--- a/kernel/sched/rt.c
+++ b/kernel/sched/rt.c
@@ -1009,8 +1009,8 @@ static void update_curr_rt(struct rq *rq)
 	if (unlikely((s64)delta_exec <= 0))
 		return;
 
-	schedstat_set(curr->se.statistics.exec_max,
-		      max(curr->se.statistics.exec_max, delta_exec));
+	schedstat_set(curr->stats.exec_max,
+		      max(curr->stats.exec_max, delta_exec));
 
 	curr->se.sum_exec_runtime += delta_exec;
 	account_group_exec_runtime(curr, delta_exec);
diff --git a/kernel/sched/stats.h b/kernel/sched/stats.h
index d8f8eb0..fb6022e 100644
--- a/kernel/sched/stats.h
+++ b/kernel/sched/stats.h
@@ -41,6 +41,7 @@ rq_sched_info_dequeue(struct rq *rq, unsigned long long delta)
 #define   schedstat_val_or_zero(var)	((schedstat_enabled()) ? (var) : 0)
 
 #else /* !CONFIG_SCHEDSTATS: */
+
 static inline void rq_sched_info_arrive  (struct rq *rq, unsigned long long delta) { }
 static inline void rq_sched_info_dequeue(struct rq *rq, unsigned long long delta) { }
 static inline void rq_sched_info_depart  (struct rq *rq, unsigned long long delta) { }
@@ -53,8 +54,26 @@ static inline void rq_sched_info_depart  (struct rq *rq, unsigned long long delt
 # define   schedstat_set(var, val)	do { } while (0)
 # define   schedstat_val(var)		0
 # define   schedstat_val_or_zero(var)	0
+
 #endif /* CONFIG_SCHEDSTATS */
 
+#ifdef CONFIG_FAIR_GROUP_SCHED
+struct sched_entity_stats {
+	struct sched_entity     se;
+	struct sched_statistics stats;
+} __no_randomize_layout;
+#endif
+
+static inline struct sched_statistics *
+__schedstats_from_se(struct sched_entity *se)
+{
+#ifdef CONFIG_FAIR_GROUP_SCHED
+	if (!entity_is_task(se))
+		return &container_of(se, struct sched_entity_stats, se)->stats;
+#endif
+	return &task_of(se)->stats;
+}
+
 #ifdef CONFIG_PSI
 /*
  * PSI tracks state that persists across sleeps, such as iowaits and
diff --git a/kernel/sched/stop_task.c b/kernel/sched/stop_task.c
index f988ebe..0b165a2 100644
--- a/kernel/sched/stop_task.c
+++ b/kernel/sched/stop_task.c
@@ -78,8 +78,8 @@ static void put_prev_task_stop(struct rq *rq, struct task_struct *prev)
 	if (unlikely((s64)delta_exec < 0))
 		delta_exec = 0;
 
-	schedstat_set(curr->se.statistics.exec_max,
-			max(curr->se.statistics.exec_max, delta_exec));
+	schedstat_set(curr->stats.exec_max,
+		      max(curr->stats.exec_max, delta_exec));
 
 	curr->se.sum_exec_runtime += delta_exec;
 	account_group_exec_runtime(curr, delta_exec);
