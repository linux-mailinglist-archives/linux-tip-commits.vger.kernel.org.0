Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 04E93422A6C
	for <lists+linux-tip-commits@lfdr.de>; Tue,  5 Oct 2021 16:12:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236031AbhJEOOO (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Tue, 5 Oct 2021 10:14:14 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:51238 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235353AbhJEOOB (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Tue, 5 Oct 2021 10:14:01 -0400
Date:   Tue, 05 Oct 2021 14:12:09 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1633443129;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tfTynM/xgOo+cnY7Hsw+f0uK2vtCZqqTinCJWpBm04k=;
        b=OBMmr8XEm5gO5gZ7c7p9OGp4krpXclc4afkv4AKfHKhoXujm6NdIjrJ8jSbMwcvIipLctu
        +O+d1ZPc3DZ3Oisa3t/N9Y/wbqAaTQgBSHXAbwv3nus1O6th8oNHxPPr+5hlLd/2K8fIQo
        +U5I041VMtZmLFhxgax1C5pWUkH3MNo65iSscf5I8LqRTTkTqzkwj2kYtzwpr1kVDSTJRO
        +X5cE0hfhOJfj1smXc5N+BGJ7w+rSsaJTJsqfdFS8aqAQWt78UU1q8jSP8egj8y4qRjaz1
        pXDiLy4L+eIcnS9O1fx9A11lLM1bU+b/NRJyYkujdg+qgR7DncqFipWi1e7yhA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1633443129;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tfTynM/xgOo+cnY7Hsw+f0uK2vtCZqqTinCJWpBm04k=;
        b=vsRzY9sC5VRw63hokxcVMJeTIFMpVTD5C5ucMMXrgXBYDZ0N83Ns3KKNFmEVLo67uqF8PQ
        peGlUUsLq26aJ3Dw==
From:   "tip-bot2 for Yafang Shao" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched: Make schedstats helpers independent of fair
 sched class
Cc:     Yafang Shao <laoar.shao@gmail.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Mel Gorman <mgorman@suse.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210905143547.4668-4-laoar.shao@gmail.com>
References: <20210905143547.4668-4-laoar.shao@gmail.com>
MIME-Version: 1.0
Message-ID: <163344312903.25758.15436053600848137328.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     60f2415e19d3948641149ac6aca137a7be1d1952
Gitweb:        https://git.kernel.org/tip/60f2415e19d3948641149ac6aca137a7be1d1952
Author:        Yafang Shao <laoar.shao@gmail.com>
AuthorDate:    Sun, 05 Sep 2021 14:35:42 
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 05 Oct 2021 15:51:47 +02:00

sched: Make schedstats helpers independent of fair sched class

The original prototype of the schedstats helpers are

  update_stats_wait_*(struct cfs_rq *cfs_rq, struct sched_entity *se)

The cfs_rq in these helpers is used to get the rq_clock, and the se is
used to get the struct sched_statistics and the struct task_struct. In
order to make these helpers available by all sched classes, we can pass
the rq, sched_statistics and task_struct directly.

Then the new helpers are

  update_stats_wait_*(struct rq *rq, struct task_struct *p,
                      struct sched_statistics *stats)

which are independent of fair sched class.

To avoid vmlinux growing too large or introducing ovehead when
!schedstat_enabled(), some new helpers after schedstat_enabled() are also
introduced, Suggested by Mel. These helpers are in sched/stats.c,

  __update_stats_wait_*(struct rq *rq, struct task_struct *p,
                        struct sched_statistics *stats)

The size of vmlinux as follows,
                      Before          After
  Size of vmlinux     826308552       826304640
The size is a litte smaller as some functions are not inlined again after
the change.

I also compared the sched performance with 'perf bench sched pipe',
suggested by Mel. The result as followsi (in usecs/op),
                             Before                After
  kernel.sched_schedstats=0  5.2~5.4               5.2~5.4
  kernel.sched_schedstats=1  5.3~5.5               5.3~5.5

[These data is a little difference with the prev version, that is
because my old test machine is destroyed so I have to use a new
different test machine.]
Almost no difference.

No functional change.

[lkp@intel.com: reported build failure in prev version]

Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Mel Gorman <mgorman@suse.de>
Link: https://lore.kernel.org/r/20210905143547.4668-4-laoar.shao@gmail.com
---
 kernel/sched/fair.c  | 134 +++++-------------------------------------
 kernel/sched/stats.c | 103 ++++++++++++++++++++++++++++++++-
 kernel/sched/stats.h |  30 +++++++++-
 3 files changed, 152 insertions(+), 115 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 97c6ecb..71b30ef 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -887,32 +887,27 @@ static void update_curr_fair(struct rq *rq)
 }
 
 static inline void
-update_stats_wait_start(struct cfs_rq *cfs_rq, struct sched_entity *se)
+update_stats_wait_start_fair(struct cfs_rq *cfs_rq, struct sched_entity *se)
 {
-	u64 wait_start, prev_wait_start;
 	struct sched_statistics *stats;
+	struct task_struct *p = NULL;
 
 	if (!schedstat_enabled())
 		return;
 
 	stats = __schedstats_from_se(se);
 
-	wait_start = rq_clock(rq_of(cfs_rq));
-	prev_wait_start = schedstat_val(stats->wait_start);
-
-	if (entity_is_task(se) && task_on_rq_migrating(task_of(se)) &&
-	    likely(wait_start > prev_wait_start))
-		wait_start -= prev_wait_start;
+	if (entity_is_task(se))
+		p = task_of(se);
 
-	__schedstat_set(stats->wait_start, wait_start);
+	__update_stats_wait_start(rq_of(cfs_rq), p, stats);
 }
 
 static inline void
-update_stats_wait_end(struct cfs_rq *cfs_rq, struct sched_entity *se)
+update_stats_wait_end_fair(struct cfs_rq *cfs_rq, struct sched_entity *se)
 {
 	struct sched_statistics *stats;
 	struct task_struct *p = NULL;
-	u64 delta;
 
 	if (!schedstat_enabled())
 		return;
@@ -928,105 +923,34 @@ update_stats_wait_end(struct cfs_rq *cfs_rq, struct sched_entity *se)
 	if (unlikely(!schedstat_val(stats->wait_start)))
 		return;
 
-	delta = rq_clock(rq_of(cfs_rq)) - schedstat_val(stats->wait_start);
-
-	if (entity_is_task(se)) {
+	if (entity_is_task(se))
 		p = task_of(se);
-		if (task_on_rq_migrating(p)) {
-			/*
-			 * Preserve migrating task's wait time so wait_start
-			 * time stamp can be adjusted to accumulate wait time
-			 * prior to migration.
-			 */
-			__schedstat_set(stats->wait_start, delta);
-			return;
-		}
-		trace_sched_stat_wait(p, delta);
-	}
 
-	__schedstat_set(stats->wait_max,
-		      max(schedstat_val(stats->wait_max), delta));
-	__schedstat_inc(stats->wait_count);
-	__schedstat_add(stats->wait_sum, delta);
-	__schedstat_set(stats->wait_start, 0);
+	__update_stats_wait_end(rq_of(cfs_rq), p, stats);
 }
 
 static inline void
-update_stats_enqueue_sleeper(struct cfs_rq *cfs_rq, struct sched_entity *se)
+update_stats_enqueue_sleeper_fair(struct cfs_rq *cfs_rq, struct sched_entity *se)
 {
 	struct sched_statistics *stats;
 	struct task_struct *tsk = NULL;
-	u64 sleep_start, block_start;
 
 	if (!schedstat_enabled())
 		return;
 
 	stats = __schedstats_from_se(se);
 
-	sleep_start = schedstat_val(stats->sleep_start);
-	block_start = schedstat_val(stats->block_start);
-
 	if (entity_is_task(se))
 		tsk = task_of(se);
 
-	if (sleep_start) {
-		u64 delta = rq_clock(rq_of(cfs_rq)) - sleep_start;
-
-		if ((s64)delta < 0)
-			delta = 0;
-
-		if (unlikely(delta > schedstat_val(stats->sleep_max)))
-			__schedstat_set(stats->sleep_max, delta);
-
-		__schedstat_set(stats->sleep_start, 0);
-		__schedstat_add(stats->sum_sleep_runtime, delta);
-
-		if (tsk) {
-			account_scheduler_latency(tsk, delta >> 10, 1);
-			trace_sched_stat_sleep(tsk, delta);
-		}
-	}
-	if (block_start) {
-		u64 delta = rq_clock(rq_of(cfs_rq)) - block_start;
-
-		if ((s64)delta < 0)
-			delta = 0;
-
-		if (unlikely(delta > schedstat_val(stats->block_max)))
-			__schedstat_set(stats->block_max, delta);
-
-		__schedstat_set(stats->block_start, 0);
-		__schedstat_add(stats->sum_sleep_runtime, delta);
-
-		if (tsk) {
-			if (tsk->in_iowait) {
-				__schedstat_add(stats->iowait_sum, delta);
-				__schedstat_inc(stats->iowait_count);
-				trace_sched_stat_iowait(tsk, delta);
-			}
-
-			trace_sched_stat_blocked(tsk, delta);
-
-			/*
-			 * Blocking time is in units of nanosecs, so shift by
-			 * 20 to get a milliseconds-range estimation of the
-			 * amount of time that the task spent sleeping:
-			 */
-			if (unlikely(prof_on == SLEEP_PROFILING)) {
-				profile_hits(SLEEP_PROFILING,
-						(void *)get_wchan(tsk),
-						delta >> 20);
-			}
-			account_scheduler_latency(tsk, delta >> 10, 0);
-		}
-	}
+	__update_stats_enqueue_sleeper(rq_of(cfs_rq), tsk, stats);
 }
 
 /*
  * Task is being enqueued - update stats:
  */
 static inline void
-update_stats_enqueue(struct cfs_rq *cfs_rq, struct sched_entity *se, int flags)
+update_stats_enqueue_fair(struct cfs_rq *cfs_rq, struct sched_entity *se, int flags)
 {
 	if (!schedstat_enabled())
 		return;
@@ -1036,14 +960,14 @@ update_stats_enqueue(struct cfs_rq *cfs_rq, struct sched_entity *se, int flags)
 	 * a dequeue/enqueue event is a NOP)
 	 */
 	if (se != cfs_rq->curr)
-		update_stats_wait_start(cfs_rq, se);
+		update_stats_wait_start_fair(cfs_rq, se);
 
 	if (flags & ENQUEUE_WAKEUP)
-		update_stats_enqueue_sleeper(cfs_rq, se);
+		update_stats_enqueue_sleeper_fair(cfs_rq, se);
 }
 
 static inline void
-update_stats_dequeue(struct cfs_rq *cfs_rq, struct sched_entity *se, int flags)
+update_stats_dequeue_fair(struct cfs_rq *cfs_rq, struct sched_entity *se, int flags)
 {
 
 	if (!schedstat_enabled())
@@ -1054,7 +978,7 @@ update_stats_dequeue(struct cfs_rq *cfs_rq, struct sched_entity *se, int flags)
 	 * waiting task:
 	 */
 	if (se != cfs_rq->curr)
-		update_stats_wait_end(cfs_rq, se);
+		update_stats_wait_end_fair(cfs_rq, se);
 
 	if ((flags & DEQUEUE_SLEEP) && entity_is_task(se)) {
 		struct task_struct *tsk = task_of(se);
@@ -4267,26 +4191,6 @@ place_entity(struct cfs_rq *cfs_rq, struct sched_entity *se, int initial)
 
 static void check_enqueue_throttle(struct cfs_rq *cfs_rq);
 
-static inline void check_schedstat_required(void)
-{
-#ifdef CONFIG_SCHEDSTATS
-	if (schedstat_enabled())
-		return;
-
-	/* Force schedstat enabled if a dependent tracepoint is active */
-	if (trace_sched_stat_wait_enabled()    ||
-			trace_sched_stat_sleep_enabled()   ||
-			trace_sched_stat_iowait_enabled()  ||
-			trace_sched_stat_blocked_enabled() ||
-			trace_sched_stat_runtime_enabled())  {
-		printk_deferred_once("Scheduler tracepoints stat_sleep, stat_iowait, "
-			     "stat_blocked and stat_runtime require the "
-			     "kernel parameter schedstats=enable or "
-			     "kernel.sched_schedstats=1\n");
-	}
-#endif
-}
-
 static inline bool cfs_bandwidth_used(void);
 
 /*
@@ -4360,7 +4264,7 @@ enqueue_entity(struct cfs_rq *cfs_rq, struct sched_entity *se, int flags)
 		place_entity(cfs_rq, se, 0);
 
 	check_schedstat_required();
-	update_stats_enqueue(cfs_rq, se, flags);
+	update_stats_enqueue_fair(cfs_rq, se, flags);
 	check_spread(cfs_rq, se);
 	if (!curr)
 		__enqueue_entity(cfs_rq, se);
@@ -4444,7 +4348,7 @@ dequeue_entity(struct cfs_rq *cfs_rq, struct sched_entity *se, int flags)
 	update_load_avg(cfs_rq, se, UPDATE_TG);
 	se_update_runnable(se);
 
-	update_stats_dequeue(cfs_rq, se, flags);
+	update_stats_dequeue_fair(cfs_rq, se, flags);
 
 	clear_buddies(cfs_rq, se);
 
@@ -4529,7 +4433,7 @@ set_next_entity(struct cfs_rq *cfs_rq, struct sched_entity *se)
 		 * a CPU. So account for the time it spent waiting on the
 		 * runqueue.
 		 */
-		update_stats_wait_end(cfs_rq, se);
+		update_stats_wait_end_fair(cfs_rq, se);
 		__dequeue_entity(cfs_rq, se);
 		update_load_avg(cfs_rq, se, UPDATE_TG);
 	}
@@ -4631,7 +4535,7 @@ static void put_prev_entity(struct cfs_rq *cfs_rq, struct sched_entity *prev)
 	check_spread(cfs_rq, prev);
 
 	if (prev->on_rq) {
-		update_stats_wait_start(cfs_rq, prev);
+		update_stats_wait_start_fair(cfs_rq, prev);
 		/* Put 'current' back into the tree. */
 		__enqueue_entity(cfs_rq, prev);
 		/* in !on_rq case, update occurred at dequeue */
diff --git a/kernel/sched/stats.c b/kernel/sched/stats.c
index 3f93fc3..fad781c 100644
--- a/kernel/sched/stats.c
+++ b/kernel/sched/stats.c
@@ -4,6 +4,109 @@
  */
 #include "sched.h"
 
+void __update_stats_wait_start(struct rq *rq, struct task_struct *p,
+			       struct sched_statistics *stats)
+{
+	u64 wait_start, prev_wait_start;
+
+	wait_start = rq_clock(rq);
+	prev_wait_start = schedstat_val(stats->wait_start);
+
+	if (p && likely(wait_start > prev_wait_start))
+		wait_start -= prev_wait_start;
+
+	__schedstat_set(stats->wait_start, wait_start);
+}
+
+void __update_stats_wait_end(struct rq *rq, struct task_struct *p,
+			     struct sched_statistics *stats)
+{
+	u64 delta = rq_clock(rq) - schedstat_val(stats->wait_start);
+
+	if (p) {
+		if (task_on_rq_migrating(p)) {
+			/*
+			 * Preserve migrating task's wait time so wait_start
+			 * time stamp can be adjusted to accumulate wait time
+			 * prior to migration.
+			 */
+			__schedstat_set(stats->wait_start, delta);
+
+			return;
+		}
+
+		trace_sched_stat_wait(p, delta);
+	}
+
+	__schedstat_set(stats->wait_max,
+			max(schedstat_val(stats->wait_max), delta));
+	__schedstat_inc(stats->wait_count);
+	__schedstat_add(stats->wait_sum, delta);
+	__schedstat_set(stats->wait_start, 0);
+}
+
+void __update_stats_enqueue_sleeper(struct rq *rq, struct task_struct *p,
+				    struct sched_statistics *stats)
+{
+	u64 sleep_start, block_start;
+
+	sleep_start = schedstat_val(stats->sleep_start);
+	block_start = schedstat_val(stats->block_start);
+
+	if (sleep_start) {
+		u64 delta = rq_clock(rq) - sleep_start;
+
+		if ((s64)delta < 0)
+			delta = 0;
+
+		if (unlikely(delta > schedstat_val(stats->sleep_max)))
+			__schedstat_set(stats->sleep_max, delta);
+
+		__schedstat_set(stats->sleep_start, 0);
+		__schedstat_add(stats->sum_sleep_runtime, delta);
+
+		if (p) {
+			account_scheduler_latency(p, delta >> 10, 1);
+			trace_sched_stat_sleep(p, delta);
+		}
+	}
+
+	if (block_start) {
+		u64 delta = rq_clock(rq) - block_start;
+
+		if ((s64)delta < 0)
+			delta = 0;
+
+		if (unlikely(delta > schedstat_val(stats->block_max)))
+			__schedstat_set(stats->block_max, delta);
+
+		__schedstat_set(stats->block_start, 0);
+		__schedstat_add(stats->sum_sleep_runtime, delta);
+
+		if (p) {
+			if (p->in_iowait) {
+				__schedstat_add(stats->iowait_sum, delta);
+				__schedstat_inc(stats->iowait_count);
+				trace_sched_stat_iowait(p, delta);
+			}
+
+			trace_sched_stat_blocked(p, delta);
+
+			/*
+			 * Blocking time is in units of nanosecs, so shift by
+			 * 20 to get a milliseconds-range estimation of the
+			 * amount of time that the task spent sleeping:
+			 */
+			if (unlikely(prof_on == SLEEP_PROFILING)) {
+				profile_hits(SLEEP_PROFILING,
+					     (void *)get_wchan(p),
+					     delta >> 20);
+			}
+			account_scheduler_latency(p, delta >> 10, 0);
+		}
+	}
+}
+
 /*
  * Current schedstat API version.
  *
diff --git a/kernel/sched/stats.h b/kernel/sched/stats.h
index fb6022e..cfb0893 100644
--- a/kernel/sched/stats.h
+++ b/kernel/sched/stats.h
@@ -2,6 +2,8 @@
 
 #ifdef CONFIG_SCHEDSTATS
 
+extern struct static_key_false sched_schedstats;
+
 /*
  * Expects runqueue lock to be held for atomicity of update
  */
@@ -40,6 +42,29 @@ rq_sched_info_dequeue(struct rq *rq, unsigned long long delta)
 #define   schedstat_val(var)		(var)
 #define   schedstat_val_or_zero(var)	((schedstat_enabled()) ? (var) : 0)
 
+void __update_stats_wait_start(struct rq *rq, struct task_struct *p,
+			       struct sched_statistics *stats);
+
+void __update_stats_wait_end(struct rq *rq, struct task_struct *p,
+			     struct sched_statistics *stats);
+void __update_stats_enqueue_sleeper(struct rq *rq, struct task_struct *p,
+				    struct sched_statistics *stats);
+
+static inline void
+check_schedstat_required(void)
+{
+	if (schedstat_enabled())
+		return;
+
+	/* Force schedstat enabled if a dependent tracepoint is active */
+	if (trace_sched_stat_wait_enabled()    ||
+	    trace_sched_stat_sleep_enabled()   ||
+	    trace_sched_stat_iowait_enabled()  ||
+	    trace_sched_stat_blocked_enabled() ||
+	    trace_sched_stat_runtime_enabled())
+		printk_deferred_once("Scheduler tracepoints stat_sleep, stat_iowait, stat_blocked and stat_runtime require the kernel parameter schedstats=enable or kernel.sched_schedstats=1\n");
+}
+
 #else /* !CONFIG_SCHEDSTATS: */
 
 static inline void rq_sched_info_arrive  (struct rq *rq, unsigned long long delta) { }
@@ -55,6 +80,11 @@ static inline void rq_sched_info_depart  (struct rq *rq, unsigned long long delt
 # define   schedstat_val(var)		0
 # define   schedstat_val_or_zero(var)	0
 
+# define __update_stats_wait_start(rq, p, stats)       do { } while (0)
+# define __update_stats_wait_end(rq, p, stats)         do { } while (0)
+# define __update_stats_enqueue_sleeper(rq, p, stats)  do { } while (0)
+# define check_schedstat_required()                    do { } while (0)
+
 #endif /* CONFIG_SCHEDSTATS */
 
 #ifdef CONFIG_FAIR_GROUP_SCHED
