Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DAFA93436DB
	for <lists+linux-tip-commits@lfdr.de>; Mon, 22 Mar 2021 03:55:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229897AbhCVCyf (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Sun, 21 Mar 2021 22:54:35 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:51032 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229870AbhCVCy2 (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Sun, 21 Mar 2021 22:54:28 -0400
Date:   Mon, 22 Mar 2021 02:54:25 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1616381666;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=TMVV7wbiEk7b7cZd6FXGX3DSWyIxTc9Q9hBw3vVRTGo=;
        b=Q+K7TuzebItXbpCbF4H4CyySWsH2Fn9WDary5TWDQKjDN9lAONqq22MID6+3TB4rcAuHK/
        iIP2mM+RIY2THXrnvocRWnHa1Mu2L6z31kCuZogf0OxUmykRDnBgMB9AJu9wlcFw4OlzGB
        Gz/bkBvmTZp0ZXOj+LYrSlfyHLZ8YwcFBJtLuSYP4uF5lShnQjhD9zclB3Icc0PqHpMkoP
        YMIt25ZjvO+wxdGVIBoyJqWZypU6fADSjsS0+bS5XbmWp0d86hQ/HFkjJLPp8rWtBXmNn9
        X25Dp1p3B792eWpjqimctIG4z0QjV32WsfBzDb+g2XfpgzJmNXWmfvgqLgFdKw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1616381666;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=TMVV7wbiEk7b7cZd6FXGX3DSWyIxTc9Q9hBw3vVRTGo=;
        b=1LbhoY5BwS2k+QnUUvYscnlF7Oclb2dMs4f9BgU+3RrmC7C36Tn5Pw/UwYR6DLUeqSUFg8
        QYW3FMAgV90vxkDQ==
From:   "tip-bot2 for Ingo Molnar" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched: Fix various typos
Cc:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Mike Galbraith <efault@gmx.de>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        linux-kernel@vger.kernel.org, x86@kernel.org
MIME-Version: 1.0
Message-ID: <161638166597.398.16889565063718547507.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     3b03706fa621ce31a3e9ef6307020fde4e6aae16
Gitweb:        https://git.kernel.org/tip/3b03706fa621ce31a3e9ef6307020fde4e6aae16
Author:        Ingo Molnar <mingo@kernel.org>
AuthorDate:    Thu, 18 Mar 2021 13:38:50 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Mon, 22 Mar 2021 00:11:52 +01:00

sched: Fix various typos

Fix ~42 single-word typos in scheduler code comments.

We have accumulated a few fun ones over the years. :-)

Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Mike Galbraith <efault@gmx.de>
Cc: Juri Lelli <juri.lelli@redhat.com>
Cc: Vincent Guittot <vincent.guittot@linaro.org>
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Ben Segall <bsegall@google.com>
Cc: Mel Gorman <mgorman@suse.de>
Cc: linux-kernel@vger.kernel.org
---
 include/linux/sched.h            |  2 +-
 kernel/sched/clock.c             |  2 +-
 kernel/sched/core.c              |  2 +-
 kernel/sched/cpuacct.c           |  2 +-
 kernel/sched/cpufreq_schedutil.c |  2 +-
 kernel/sched/cpupri.c            |  4 ++--
 kernel/sched/cputime.c           |  2 +-
 kernel/sched/deadline.c          | 12 ++++++------
 kernel/sched/debug.c             |  2 +-
 kernel/sched/fair.c              | 18 +++++++++---------
 kernel/sched/features.h          |  2 +-
 kernel/sched/idle.c              |  4 ++--
 kernel/sched/loadavg.c           |  2 +-
 kernel/sched/pelt.c              |  2 +-
 kernel/sched/pelt.h              |  2 +-
 kernel/sched/psi.c               |  6 +++---
 kernel/sched/rt.c                |  6 +++---
 kernel/sched/sched.h             |  8 ++++----
 kernel/sched/stats.c             |  2 +-
 kernel/sched/topology.c          |  2 +-
 20 files changed, 42 insertions(+), 42 deletions(-)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index cf245bc..05572e2 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1097,7 +1097,7 @@ struct task_struct {
 #ifdef CONFIG_CPUSETS
 	/* Protected by ->alloc_lock: */
 	nodemask_t			mems_allowed;
-	/* Seqence number to catch updates: */
+	/* Sequence number to catch updates: */
 	seqcount_spinlock_t		mems_allowed_seq;
 	int				cpuset_mem_spread_rotor;
 	int				cpuset_slab_spread_rotor;
diff --git a/kernel/sched/clock.c b/kernel/sched/clock.c
index 12bca64..c2b2859 100644
--- a/kernel/sched/clock.c
+++ b/kernel/sched/clock.c
@@ -41,7 +41,7 @@
  * Otherwise it tries to create a semi stable clock from a mixture of other
  * clocks, including:
  *
- *  - GTOD (clock monotomic)
+ *  - GTOD (clock monotonic)
  *  - sched_clock()
  *  - explicit idle events
  *
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 28c4df6..3384ea7 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -8975,7 +8975,7 @@ static int tg_set_cfs_bandwidth(struct task_group *tg, u64 period, u64 quota)
 		return -EINVAL;
 
 	/*
-	 * Likewise, bound things on the otherside by preventing insane quota
+	 * Likewise, bound things on the other side by preventing insane quota
 	 * periods.  This also allows us to normalize in computing quota
 	 * feasibility.
 	 */
diff --git a/kernel/sched/cpuacct.c b/kernel/sched/cpuacct.c
index 941c28c..104a1ba 100644
--- a/kernel/sched/cpuacct.c
+++ b/kernel/sched/cpuacct.c
@@ -104,7 +104,7 @@ static u64 cpuacct_cpuusage_read(struct cpuacct *ca, int cpu,
 
 	/*
 	 * We allow index == CPUACCT_STAT_NSTATS here to read
-	 * the sum of suages.
+	 * the sum of usages.
 	 */
 	BUG_ON(index > CPUACCT_STAT_NSTATS);
 
diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
index 50cbad8..7cc2e11 100644
--- a/kernel/sched/cpufreq_schedutil.c
+++ b/kernel/sched/cpufreq_schedutil.c
@@ -471,7 +471,7 @@ static void sugov_work(struct kthread_work *work)
 
 	/*
 	 * Hold sg_policy->update_lock shortly to handle the case where:
-	 * incase sg_policy->next_freq is read here, and then updated by
+	 * in case sg_policy->next_freq is read here, and then updated by
 	 * sugov_deferred_update() just before work_in_progress is set to false
 	 * here, we may miss queueing the new update.
 	 *
diff --git a/kernel/sched/cpupri.c b/kernel/sched/cpupri.c
index ec9be78..d583f2a 100644
--- a/kernel/sched/cpupri.c
+++ b/kernel/sched/cpupri.c
@@ -77,7 +77,7 @@ static inline int __cpupri_find(struct cpupri *cp, struct task_struct *p,
 	 * When looking at the vector, we need to read the counter,
 	 * do a memory barrier, then read the mask.
 	 *
-	 * Note: This is still all racey, but we can deal with it.
+	 * Note: This is still all racy, but we can deal with it.
 	 *  Ideally, we only want to look at masks that are set.
 	 *
 	 *  If a mask is not set, then the only thing wrong is that we
@@ -186,7 +186,7 @@ int cpupri_find_fitness(struct cpupri *cp, struct task_struct *p,
 	 * The cost of this trade-off is not entirely clear and will probably
 	 * be good for some workloads and bad for others.
 	 *
-	 * The main idea here is that if some CPUs were overcommitted, we try
+	 * The main idea here is that if some CPUs were over-committed, we try
 	 * to spread which is what the scheduler traditionally did. Sys admins
 	 * must do proper RT planning to avoid overloading the system if they
 	 * really care.
diff --git a/kernel/sched/cputime.c b/kernel/sched/cputime.c
index 5f61165..3b36644 100644
--- a/kernel/sched/cputime.c
+++ b/kernel/sched/cputime.c
@@ -563,7 +563,7 @@ void cputime_adjust(struct task_cputime *curr, struct prev_cputime *prev,
 
 	/*
 	 * If either stime or utime are 0, assume all runtime is userspace.
-	 * Once a task gets some ticks, the monotonicy code at 'update:'
+	 * Once a task gets some ticks, the monotonicity code at 'update:'
 	 * will ensure things converge to the observed ratio.
 	 */
 	if (stime == 0) {
diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index aac3539..9a29897 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -245,7 +245,7 @@ static void dl_change_utilization(struct task_struct *p, u64 new_bw)
 		p->dl.dl_non_contending = 0;
 		/*
 		 * If the timer handler is currently running and the
-		 * timer cannot be cancelled, inactive_task_timer()
+		 * timer cannot be canceled, inactive_task_timer()
 		 * will see that dl_not_contending is not set, and
 		 * will not touch the rq's active utilization,
 		 * so we are still safe.
@@ -267,7 +267,7 @@ static void dl_change_utilization(struct task_struct *p, u64 new_bw)
  * fires.
  *
  * If the task wakes up again before the inactive timer fires,
- * the timer is cancelled, whereas if the task wakes up after the
+ * the timer is canceled, whereas if the task wakes up after the
  * inactive timer fired (and running_bw has been decreased) the
  * task's utilization has to be added to running_bw again.
  * A flag in the deadline scheduling entity (dl_non_contending)
@@ -385,7 +385,7 @@ static void task_contending(struct sched_dl_entity *dl_se, int flags)
 		dl_se->dl_non_contending = 0;
 		/*
 		 * If the timer handler is currently running and the
-		 * timer cannot be cancelled, inactive_task_timer()
+		 * timer cannot be canceled, inactive_task_timer()
 		 * will see that dl_not_contending is not set, and
 		 * will not touch the rq's active utilization,
 		 * so we are still safe.
@@ -1206,7 +1206,7 @@ extern bool sched_rt_bandwidth_account(struct rt_rq *rt_rq);
  * Since rq->dl.running_bw and rq->dl.this_bw contain utilizations
  * multiplied by 2^BW_SHIFT, the result has to be shifted right by
  * BW_SHIFT.
- * Since rq->dl.bw_ratio contains 1 / Umax multipled by 2^RATIO_SHIFT,
+ * Since rq->dl.bw_ratio contains 1 / Umax multiplied by 2^RATIO_SHIFT,
  * dl_bw is multiped by rq->dl.bw_ratio and shifted right by RATIO_SHIFT.
  * Since delta is a 64 bit variable, to have an overflow its value
  * should be larger than 2^(64 - 20 - 8), which is more than 64 seconds.
@@ -1737,7 +1737,7 @@ static void migrate_task_rq_dl(struct task_struct *p, int new_cpu __maybe_unused
 		p->dl.dl_non_contending = 0;
 		/*
 		 * If the timer handler is currently running and the
-		 * timer cannot be cancelled, inactive_task_timer()
+		 * timer cannot be canceled, inactive_task_timer()
 		 * will see that dl_not_contending is not set, and
 		 * will not touch the rq's active utilization,
 		 * so we are still safe.
@@ -2745,7 +2745,7 @@ void __getparam_dl(struct task_struct *p, struct sched_attr *attr)
 
 /*
  * Default limits for DL period; on the top end we guard against small util
- * tasks still getting rediculous long effective runtimes, on the bottom end we
+ * tasks still getting ridiculously long effective runtimes, on the bottom end we
  * guard against timer DoS.
  */
 unsigned int sysctl_sched_dl_period_max = 1 << 22; /* ~4 seconds */
diff --git a/kernel/sched/debug.c b/kernel/sched/debug.c
index 486f403..4b49cc2 100644
--- a/kernel/sched/debug.c
+++ b/kernel/sched/debug.c
@@ -815,7 +815,7 @@ void sysrq_sched_debug_show(void)
 }
 
 /*
- * This itererator needs some explanation.
+ * This iterator needs some explanation.
  * It returns 1 for the header position.
  * This means 2 is CPU 0.
  * In a hotplugged system some CPUs, including CPU 0, may be missing so we have
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 2e2ab1e..6aad028 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -1125,7 +1125,7 @@ static unsigned int task_nr_scan_windows(struct task_struct *p)
 	return rss / nr_scan_pages;
 }
 
-/* For sanitys sake, never scan more PTEs than MAX_SCAN_WINDOW MB/sec. */
+/* For sanity's sake, never scan more PTEs than MAX_SCAN_WINDOW MB/sec. */
 #define MAX_SCAN_WINDOW 2560
 
 static unsigned int task_scan_min(struct task_struct *p)
@@ -2577,7 +2577,7 @@ no_join:
 }
 
 /*
- * Get rid of NUMA staticstics associated with a task (either current or dead).
+ * Get rid of NUMA statistics associated with a task (either current or dead).
  * If @final is set, the task is dead and has reached refcount zero, so we can
  * safely free all relevant data structures. Otherwise, there might be
  * concurrent reads from places like load balancing and procfs, and we should
@@ -3952,7 +3952,7 @@ static inline void util_est_dequeue(struct cfs_rq *cfs_rq,
  *
  *     abs(x) < y := (unsigned)(x + y - 1) < (2 * y - 1)
  *
- * NOTE: this only works when value + maring < INT_MAX.
+ * NOTE: this only works when value + margin < INT_MAX.
  */
 static inline bool within_margin(int value, int margin)
 {
@@ -4256,7 +4256,7 @@ enqueue_entity(struct cfs_rq *cfs_rq, struct sched_entity *se, int flags)
 	/*
 	 * When bandwidth control is enabled, cfs might have been removed
 	 * because of a parent been throttled but cfs->nr_running > 1. Try to
-	 * add it unconditionnally.
+	 * add it unconditionally.
 	 */
 	if (cfs_rq->nr_running == 1 || cfs_bandwidth_used())
 		list_add_leaf_cfs_rq(cfs_rq);
@@ -5311,7 +5311,7 @@ static void destroy_cfs_bandwidth(struct cfs_bandwidth *cfs_b)
  * bits doesn't do much.
  */
 
-/* cpu online calback */
+/* cpu online callback */
 static void __maybe_unused update_runtime_enabled(struct rq *rq)
 {
 	struct task_group *tg;
@@ -6963,7 +6963,7 @@ static void check_preempt_wakeup(struct rq *rq, struct task_struct *p, int wake_
 
 	/*
 	 * This is possible from callers such as attach_tasks(), in which we
-	 * unconditionally check_prempt_curr() after an enqueue (which may have
+	 * unconditionally check_preempt_curr() after an enqueue (which may have
 	 * lead to a throttle).  This both saves work and prevents false
 	 * next-buddy nomination below.
 	 */
@@ -7595,7 +7595,7 @@ int can_migrate_task(struct task_struct *p, struct lb_env *env)
 		return 0;
 	}
 
-	/* Record that we found atleast one task that could run on dst_cpu */
+	/* Record that we found at least one task that could run on dst_cpu */
 	env->flags &= ~LBF_ALL_PINNED;
 
 	if (task_running(env->src_rq, p)) {
@@ -9690,7 +9690,7 @@ more_balance:
 		 * load to given_cpu. In rare situations, this may cause
 		 * conflicts (balance_cpu and given_cpu/ilb_cpu deciding
 		 * _independently_ and at _same_ time to move some load to
-		 * given_cpu) causing exceess load to be moved to given_cpu.
+		 * given_cpu) causing excess load to be moved to given_cpu.
 		 * This however should not happen so much in practice and
 		 * moreover subsequent load balance cycles should correct the
 		 * excess load moved.
@@ -9834,7 +9834,7 @@ out_one_pinned:
 	/*
 	 * newidle_balance() disregards balance intervals, so we could
 	 * repeatedly reach this code, which would lead to balance_interval
-	 * skyrocketting in a short amount of time. Skip the balance_interval
+	 * skyrocketing in a short amount of time. Skip the balance_interval
 	 * increase logic to avoid that.
 	 */
 	if (env.idle == CPU_NEWLY_IDLE)
diff --git a/kernel/sched/features.h b/kernel/sched/features.h
index 1bc2b15..422fa68 100644
--- a/kernel/sched/features.h
+++ b/kernel/sched/features.h
@@ -27,7 +27,7 @@ SCHED_FEAT(NEXT_BUDDY, false)
 SCHED_FEAT(LAST_BUDDY, true)
 
 /*
- * Consider buddies to be cache hot, decreases the likelyness of a
+ * Consider buddies to be cache hot, decreases the likeliness of a
  * cache buddy being migrated away, increases cache locality.
  */
 SCHED_FEAT(CACHE_HOT_BUDDY, true)
diff --git a/kernel/sched/idle.c b/kernel/sched/idle.c
index 7a92d60..7ca3d3d 100644
--- a/kernel/sched/idle.c
+++ b/kernel/sched/idle.c
@@ -163,7 +163,7 @@ static int call_cpuidle(struct cpuidle_driver *drv, struct cpuidle_device *dev,
  *
  * NOTE: no locks or semaphores should be used here
  *
- * On archs that support TIF_POLLING_NRFLAG, is called with polling
+ * On architectures that support TIF_POLLING_NRFLAG, is called with polling
  * set, and it returns with polling set.  If it ever stops polling, it
  * must clear the polling bit.
  */
@@ -199,7 +199,7 @@ static void cpuidle_idle_call(void)
 	 * Suspend-to-idle ("s2idle") is a system state in which all user space
 	 * has been frozen, all I/O devices have been suspended and the only
 	 * activity happens here and in interrupts (if any). In that case bypass
-	 * the cpuidle governor and go stratight for the deepest idle state
+	 * the cpuidle governor and go straight for the deepest idle state
 	 * available.  Possibly also suspend the local tick and the entire
 	 * timekeeping to prevent timer interrupts from kicking us out of idle
 	 * until a proper wakeup interrupt happens.
diff --git a/kernel/sched/loadavg.c b/kernel/sched/loadavg.c
index d2a6556..1c79896 100644
--- a/kernel/sched/loadavg.c
+++ b/kernel/sched/loadavg.c
@@ -189,7 +189,7 @@ calc_load_n(unsigned long load, unsigned long exp,
  *    w:0 1 1           0 0           1 1           0 0
  *
  *    This ensures we'll fold the old NO_HZ contribution in this window while
- *    accumlating the new one.
+ *    accumulating the new one.
  *
  *  - When we wake up from NO_HZ during the window, we push up our
  *    contribution, since we effectively move our sample point to a known
diff --git a/kernel/sched/pelt.c b/kernel/sched/pelt.c
index 2c613e1..a554e3b 100644
--- a/kernel/sched/pelt.c
+++ b/kernel/sched/pelt.c
@@ -133,7 +133,7 @@ accumulate_sum(u64 delta, struct sched_avg *sa,
 			 *	runnable = running = 0;
 			 *
 			 * clause from ___update_load_sum(); this results in
-			 * the below usage of @contrib to dissapear entirely,
+			 * the below usage of @contrib to disappear entirely,
 			 * so no point in calculating it.
 			 */
 			contrib = __accumulate_pelt_segments(periods,
diff --git a/kernel/sched/pelt.h b/kernel/sched/pelt.h
index 795e43e..1462846 100644
--- a/kernel/sched/pelt.h
+++ b/kernel/sched/pelt.h
@@ -130,7 +130,7 @@ static inline void update_idle_rq_clock_pelt(struct rq *rq)
 	 * Reflecting stolen time makes sense only if the idle
 	 * phase would be present at max capacity. As soon as the
 	 * utilization of a rq has reached the maximum value, it is
-	 * considered as an always runnig rq without idle time to
+	 * considered as an always running rq without idle time to
 	 * steal. This potential idle time is considered as lost in
 	 * this case. We keep track of this lost idle time compare to
 	 * rq's clock_task.
diff --git a/kernel/sched/psi.c b/kernel/sched/psi.c
index ee3c5b4..c8480d7 100644
--- a/kernel/sched/psi.c
+++ b/kernel/sched/psi.c
@@ -62,7 +62,7 @@
  * states, we would have to conclude a CPU SOME pressure number of
  * 100%, since *somebody* is waiting on a runqueue at all
  * times. However, that is clearly not the amount of contention the
- * workload is experiencing: only one out of 256 possible exceution
+ * workload is experiencing: only one out of 256 possible execution
  * threads will be contended at any given time, or about 0.4%.
  *
  * Conversely, consider a scenario of 4 tasks and 4 CPUs where at any
@@ -76,7 +76,7 @@
  * we have to base our calculation on the number of non-idle tasks in
  * conjunction with the number of available CPUs, which is the number
  * of potential execution threads. SOME becomes then the proportion of
- * delayed tasks to possibe threads, and FULL is the share of possible
+ * delayed tasks to possible threads, and FULL is the share of possible
  * threads that are unproductive due to delays:
  *
  *	threads = min(nr_nonidle_tasks, nr_cpus)
@@ -446,7 +446,7 @@ static void psi_avgs_work(struct work_struct *work)
 	mutex_unlock(&group->avgs_lock);
 }
 
-/* Trigger tracking window manupulations */
+/* Trigger tracking window manipulations */
 static void window_reset(struct psi_window *win, u64 now, u64 value,
 			 u64 prev_growth)
 {
diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
index 8f720b7..c286e5b 100644
--- a/kernel/sched/rt.c
+++ b/kernel/sched/rt.c
@@ -700,7 +700,7 @@ static void do_balance_runtime(struct rt_rq *rt_rq)
 		/*
 		 * Either all rqs have inf runtime and there's nothing to steal
 		 * or __disable_runtime() below sets a specific rq to inf to
-		 * indicate its been disabled and disalow stealing.
+		 * indicate its been disabled and disallow stealing.
 		 */
 		if (iter->rt_runtime == RUNTIME_INF)
 			goto next;
@@ -1998,7 +1998,7 @@ static void push_rt_tasks(struct rq *rq)
  *
  * Each root domain has its own irq work function that can iterate over
  * all CPUs with RT overloaded tasks. Since all CPUs with overloaded RT
- * tassk must be checked if there's one or many CPUs that are lowering
+ * task must be checked if there's one or many CPUs that are lowering
  * their priority, there's a single irq work iterator that will try to
  * push off RT tasks that are waiting to run.
  *
@@ -2216,7 +2216,7 @@ static void pull_rt_task(struct rq *this_rq)
 			/*
 			 * There's a chance that p is higher in priority
 			 * than what's currently running on its CPU.
-			 * This is just that p is wakeing up and hasn't
+			 * This is just that p is waking up and hasn't
 			 * had a chance to schedule. We only pull
 			 * p if it is lower in priority than the
 			 * current task on the run queue
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index d2e09a6..cbb0b01 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -1155,7 +1155,7 @@ static inline u64 __rq_clock_broken(struct rq *rq)
  *
  *	if (rq-clock_update_flags >= RQCF_UPDATED)
  *
- * to check if %RQCF_UPADTED is set. It'll never be shifted more than
+ * to check if %RQCF_UPDATED is set. It'll never be shifted more than
  * one position though, because the next rq_unpin_lock() will shift it
  * back.
  */
@@ -1214,7 +1214,7 @@ static inline void rq_clock_skip_update(struct rq *rq)
 
 /*
  * See rt task throttling, which is the only time a skip
- * request is cancelled.
+ * request is canceled.
  */
 static inline void rq_clock_cancel_skipupdate(struct rq *rq)
 {
@@ -1861,7 +1861,7 @@ struct sched_class {
 
 	/*
 	 * The switched_from() call is allowed to drop rq->lock, therefore we
-	 * cannot assume the switched_from/switched_to pair is serliazed by
+	 * cannot assume the switched_from/switched_to pair is serialized by
 	 * rq->lock. They are however serialized by p->pi_lock.
 	 */
 	void (*switched_from)(struct rq *this_rq, struct task_struct *task);
@@ -2452,7 +2452,7 @@ DECLARE_PER_CPU(struct irqtime, cpu_irqtime);
 
 /*
  * Returns the irqtime minus the softirq time computed by ksoftirqd.
- * Otherwise ksoftirqd's sum_exec_runtime is substracted its own runtime
+ * Otherwise ksoftirqd's sum_exec_runtime is subtracted its own runtime
  * and never move forward.
  */
 static inline u64 irq_time_read(int cpu)
diff --git a/kernel/sched/stats.c b/kernel/sched/stats.c
index 750fb3c..3f93fc3 100644
--- a/kernel/sched/stats.c
+++ b/kernel/sched/stats.c
@@ -74,7 +74,7 @@ static int show_schedstat(struct seq_file *seq, void *v)
 }
 
 /*
- * This itererator needs some explanation.
+ * This iterator needs some explanation.
  * It returns 1 for the header position.
  * This means 2 is cpu 0.
  * In a hotplugged system some CPUs, including cpu 0, may be missing so we have
diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
index 12f8058..f2066d6 100644
--- a/kernel/sched/topology.c
+++ b/kernel/sched/topology.c
@@ -2159,7 +2159,7 @@ static cpumask_var_t			*doms_cur;
 /* Number of sched domains in 'doms_cur': */
 static int				ndoms_cur;
 
-/* Attribues of custom domains in 'doms_cur' */
+/* Attributes of custom domains in 'doms_cur' */
 static struct sched_domain_attr		*dattr_cur;
 
 /*
