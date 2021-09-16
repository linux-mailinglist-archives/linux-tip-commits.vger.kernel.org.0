Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D9E440D935
	for <lists+linux-tip-commits@lfdr.de>; Thu, 16 Sep 2021 14:00:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238782AbhIPMAw (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Thu, 16 Sep 2021 08:00:52 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:47556 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238726AbhIPMAu (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Thu, 16 Sep 2021 08:00:50 -0400
Date:   Thu, 16 Sep 2021 11:59:28 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1631793569;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kPBEu+QzY1WlKnHZKg//U6RYs4h5GU/p8+9NiBCdbVE=;
        b=ahvLE8Ox2KZ5NJ3hIFCFb8svjoxsIiqoRH6+r/ssbAxkhOnW7q5GMiZx03t3Z0B+mG1YyY
        9bJ85kJedCP1JFdzirtFKkOLBNnwsdC5yk64SsCwWKt1sMdfUTK4np6nx6nQtIlhEDGmyz
        6D/fUlmdBBqvdtR6J8E40btczizdOEKioaJ/FpUqDiNKcznaWs7R71H/oj0X4QfEag/kkD
        awgz7SSg3GAheh6yFUpyfp/UQpJlS133E1yUhRb1iA5Pms1BO6s+Ipl8zqB8NV9Z6RX147
        ZpKIqSbdtnoHS2Nf8Qr+J6te4JJLx68egDzV6s7aXxFaDPhWvZxTGqGX+Msrrw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1631793569;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kPBEu+QzY1WlKnHZKg//U6RYs4h5GU/p8+9NiBCdbVE=;
        b=mP4cC+BLqxxUmpJlf4hA05VrwKfG/G+pZ5JVJWmv+cJY3vwwzXBMQgIuW46+OPpDossQ40
        NZLgbJt8NeppjxDA==
From:   "tip-bot2 for Yafang Shao" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/rt: Support schedstats for RT sched class
Cc:     Yafang Shao <laoar.shao@gmail.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210905143547.4668-7-laoar.shao@gmail.com>
References: <20210905143547.4668-7-laoar.shao@gmail.com>
MIME-Version: 1.0
Message-ID: <163179356832.25758.14611339996645758626.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     1ff69baabc2f0f3b098ad94429d3d3cb2897f097
Gitweb:        https://git.kernel.org/tip/1ff69baabc2f0f3b098ad94429d3d3cb2897f097
Author:        Yafang Shao <laoar.shao@gmail.com>
AuthorDate:    Sun, 05 Sep 2021 14:35:45 
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 15 Sep 2021 17:49:00 +02:00

sched/rt: Support schedstats for RT sched class

We want to measure the latency of RT tasks in our production
environment with schedstats facility, but currently schedstats is only
supported for fair sched class. This patch enable it for RT sched class
as well.

After we make the struct sched_statistics and the helpers of it
independent of fair sched class, we can easily use the schedstats
facility for RT sched class.

The schedstat usage in RT sched class is similar with fair sched class,
for example,
                fair                        RT
enqueue         update_stats_enqueue_fair   update_stats_enqueue_rt
dequeue         update_stats_dequeue_fair   update_stats_dequeue_rt
put_prev_task   update_stats_wait_start     update_stats_wait_start_rt
set_next_task   update_stats_wait_end       update_stats_wait_end_rt

The user can get the schedstats information in the same way in fair sched
class. For example,
       fair                            RT
       /proc/[pid]/sched               /proc/[pid]/sched

schedstats is not supported for RT group.

The output of a RT task's schedstats as follows,
$ cat /proc/10349/sched
...
sum_sleep_runtime                            :           972.434535
sum_block_runtime                            :           960.433522
wait_start                                   :        188510.871584
sleep_start                                  :             0.000000
block_start                                  :             0.000000
sleep_max                                    :            12.001013
block_max                                    :           952.660622
exec_max                                     :             0.049629
slice_max                                    :             0.000000
wait_max                                     :             0.018538
wait_sum                                     :             0.424340
wait_count                                   :                   49
iowait_sum                                   :           956.495640
iowait_count                                 :                   24
nr_migrations_cold                           :                    0
nr_failed_migrations_affine                  :                    0
nr_failed_migrations_running                 :                    0
nr_failed_migrations_hot                     :                    0
nr_forced_migrations                         :                    0
nr_wakeups                                   :                   49
nr_wakeups_sync                              :                    0
nr_wakeups_migrate                           :                    0
nr_wakeups_local                             :                   49
nr_wakeups_remote                            :                    0
nr_wakeups_affine                            :                    0
nr_wakeups_affine_attempts                   :                    0
nr_wakeups_passive                           :                    0
nr_wakeups_idle                              :                    0
...

The sched:sched_stat_{wait, sleep, iowait, blocked} tracepoints can
be used to trace RT tasks as well. The output of these tracepoints for a
RT tasks as follows,

- runtime
          stress-10352   [004] d.h.  1035.382286: sched_stat_runtime: comm=stress pid=10352 runtime=995769 [ns] vruntime=0 [ns]
          [vruntime=0 means it is a RT task]

- wait
          <idle>-0       [004] dN..  1227.688544: sched_stat_wait: comm=stress pid=10352 delay=46849882 [ns]

- blocked
     kworker/4:1-465     [004] dN..  1585.676371: sched_stat_blocked: comm=stress pid=17194 delay=189963 [ns]

- iowait
     kworker/4:1-465     [004] dN..  1585.675330: sched_stat_iowait: comm=stress pid=17189 delay=182848 [ns]

- sleep
           sleep-18194   [023] dN..  1780.891840: sched_stat_sleep: comm=sleep.sh pid=17767 delay=1001160770 [ns]
           sleep-18196   [023] dN..  1781.893208: sched_stat_sleep: comm=sleep.sh pid=17767 delay=1001161970 [ns]
           sleep-18197   [023] dN..  1782.894544: sched_stat_sleep: comm=sleep.sh pid=17767 delay=1001128840 [ns]
           [ In sleep.sh, it sleeps 1 sec each time. ]

[lkp@intel.com: reported build failure in earlier version]

Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/r/20210905143547.4668-7-laoar.shao@gmail.com
---
 kernel/sched/rt.c | 124 +++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 124 insertions(+)

diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
index 5d25111..bb945f8 100644
--- a/kernel/sched/rt.c
+++ b/kernel/sched/rt.c
@@ -1273,6 +1273,112 @@ static void __delist_rt_entity(struct sched_rt_entity *rt_se, struct rt_prio_arr
 	rt_se->on_list = 0;
 }
 
+static inline struct sched_statistics *
+__schedstats_from_rt_se(struct sched_rt_entity *rt_se)
+{
+#ifdef CONFIG_RT_GROUP_SCHED
+	/* schedstats is not supported for rt group. */
+	if (!rt_entity_is_task(rt_se))
+		return NULL;
+#endif
+
+	return &rt_task_of(rt_se)->stats;
+}
+
+static inline void
+update_stats_wait_start_rt(struct rt_rq *rt_rq, struct sched_rt_entity *rt_se)
+{
+	struct sched_statistics *stats;
+	struct task_struct *p = NULL;
+
+	if (!schedstat_enabled())
+		return;
+
+	if (rt_entity_is_task(rt_se))
+		p = rt_task_of(rt_se);
+
+	stats = __schedstats_from_rt_se(rt_se);
+	if (!stats)
+		return;
+
+	__update_stats_wait_start(rq_of_rt_rq(rt_rq), p, stats);
+}
+
+static inline void
+update_stats_enqueue_sleeper_rt(struct rt_rq *rt_rq, struct sched_rt_entity *rt_se)
+{
+	struct sched_statistics *stats;
+	struct task_struct *p = NULL;
+
+	if (!schedstat_enabled())
+		return;
+
+	if (rt_entity_is_task(rt_se))
+		p = rt_task_of(rt_se);
+
+	stats = __schedstats_from_rt_se(rt_se);
+	if (!stats)
+		return;
+
+	__update_stats_enqueue_sleeper(rq_of_rt_rq(rt_rq), p, stats);
+}
+
+static inline void
+update_stats_enqueue_rt(struct rt_rq *rt_rq, struct sched_rt_entity *rt_se,
+			int flags)
+{
+	if (!schedstat_enabled())
+		return;
+
+	if (flags & ENQUEUE_WAKEUP)
+		update_stats_enqueue_sleeper_rt(rt_rq, rt_se);
+}
+
+static inline void
+update_stats_wait_end_rt(struct rt_rq *rt_rq, struct sched_rt_entity *rt_se)
+{
+	struct sched_statistics *stats;
+	struct task_struct *p = NULL;
+
+	if (!schedstat_enabled())
+		return;
+
+	if (rt_entity_is_task(rt_se))
+		p = rt_task_of(rt_se);
+
+	stats = __schedstats_from_rt_se(rt_se);
+	if (!stats)
+		return;
+
+	__update_stats_wait_end(rq_of_rt_rq(rt_rq), p, stats);
+}
+
+static inline void
+update_stats_dequeue_rt(struct rt_rq *rt_rq, struct sched_rt_entity *rt_se,
+			int flags)
+{
+	struct task_struct *p = NULL;
+
+	if (!schedstat_enabled())
+		return;
+
+	if (rt_entity_is_task(rt_se))
+		p = rt_task_of(rt_se);
+
+	if ((flags & DEQUEUE_SLEEP) && p) {
+		unsigned int state;
+
+		state = READ_ONCE(p->__state);
+		if (state & TASK_INTERRUPTIBLE)
+			__schedstat_set(p->stats.sleep_start,
+					rq_clock(rq_of_rt_rq(rt_rq)));
+
+		if (state & TASK_UNINTERRUPTIBLE)
+			__schedstat_set(p->stats.block_start,
+					rq_clock(rq_of_rt_rq(rt_rq)));
+	}
+}
+
 static void __enqueue_rt_entity(struct sched_rt_entity *rt_se, unsigned int flags)
 {
 	struct rt_rq *rt_rq = rt_rq_of_se(rt_se);
@@ -1346,6 +1452,8 @@ static void enqueue_rt_entity(struct sched_rt_entity *rt_se, unsigned int flags)
 {
 	struct rq *rq = rq_of_rt_se(rt_se);
 
+	update_stats_enqueue_rt(rt_rq_of_se(rt_se), rt_se, flags);
+
 	dequeue_rt_stack(rt_se, flags);
 	for_each_sched_rt_entity(rt_se)
 		__enqueue_rt_entity(rt_se, flags);
@@ -1356,6 +1464,8 @@ static void dequeue_rt_entity(struct sched_rt_entity *rt_se, unsigned int flags)
 {
 	struct rq *rq = rq_of_rt_se(rt_se);
 
+	update_stats_dequeue_rt(rt_rq_of_se(rt_se), rt_se, flags);
+
 	dequeue_rt_stack(rt_se, flags);
 
 	for_each_sched_rt_entity(rt_se) {
@@ -1378,6 +1488,9 @@ enqueue_task_rt(struct rq *rq, struct task_struct *p, int flags)
 	if (flags & ENQUEUE_WAKEUP)
 		rt_se->timeout = 0;
 
+	check_schedstat_required();
+	update_stats_wait_start_rt(rt_rq_of_se(rt_se), rt_se);
+
 	enqueue_rt_entity(rt_se, flags);
 
 	if (!task_current(rq, p) && p->nr_cpus_allowed > 1)
@@ -1578,7 +1691,12 @@ static void check_preempt_curr_rt(struct rq *rq, struct task_struct *p, int flag
 
 static inline void set_next_task_rt(struct rq *rq, struct task_struct *p, bool first)
 {
+	struct sched_rt_entity *rt_se = &p->rt;
+	struct rt_rq *rt_rq = &rq->rt;
+
 	p->se.exec_start = rq_clock_task(rq);
+	if (on_rt_rq(&p->rt))
+		update_stats_wait_end_rt(rt_rq, rt_se);
 
 	/* The running task is never eligible for pushing */
 	dequeue_pushable_task(rq, p);
@@ -1652,6 +1770,12 @@ static struct task_struct *pick_next_task_rt(struct rq *rq)
 
 static void put_prev_task_rt(struct rq *rq, struct task_struct *p)
 {
+	struct sched_rt_entity *rt_se = &p->rt;
+	struct rt_rq *rt_rq = &rq->rt;
+
+	if (on_rt_rq(&p->rt))
+		update_stats_wait_start_rt(rt_rq, rt_se);
+
 	update_curr_rt(rq);
 
 	update_rt_rq_load_avg(rq_clock_pelt(rq), rq, 1);
