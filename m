Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C39D5422A67
	for <lists+linux-tip-commits@lfdr.de>; Tue,  5 Oct 2021 16:12:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235360AbhJEOOL (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Tue, 5 Oct 2021 10:14:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235511AbhJEON6 (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Tue, 5 Oct 2021 10:13:58 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EC6DC061755;
        Tue,  5 Oct 2021 07:12:08 -0700 (PDT)
Date:   Tue, 05 Oct 2021 14:12:05 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1633443126;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Apy6zVtHi5UiUsUoLg62OvPeHdgJ949LovErzzJCmWc=;
        b=FJ/j1S0aT6joLKEpDpbHzDr8pzJKtCSdetknw17gfuR0SNCF3TUk1PQCdIkbMohUxMKQ/P
        jrlmHL97JKxF9Y/4iii2Wc2xQ7qSqhJ+lQf9WIoJ6+1kjrLzlYfEKT2WGwHEXzOjd2Bgtr
        tpxV5GGXziw1vSCPlPIg3DwjK9DcTX6yvSvhGOCyaM+AWJkwx7mDDJPWZ1wHXcx6JzO/5r
        4633ANhZw5i2P7TdmPTQ0Ny+GFjoFX84ObhG/Vh6QwvtN9hhT1Gqs2p4rSE5nwqqNSRd5b
        uABQve04IwXmhJhVADNMVcnyhTJ2+n78E+7f788o6bCgH4ox70ROjgOinJolZA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1633443126;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Apy6zVtHi5UiUsUoLg62OvPeHdgJ949LovErzzJCmWc=;
        b=pHDGovm1MevdNWX0DhRe9QcPU42KNIo6KcJwGgTPxsCWD5xPpOYgmk8AM1S6asiH/Pk7NK
        6DxB6JqsM9cpKJBg==
From:   "tip-bot2 for Yafang Shao" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/dl: Support schedstats for deadline sched class
Cc:     Yafang Shao <laoar.shao@gmail.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210905143547.4668-9-laoar.shao@gmail.com>
References: <20210905143547.4668-9-laoar.shao@gmail.com>
MIME-Version: 1.0
Message-ID: <163344312586.25758.15700722790990703471.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     b5eb4a5f6521d58d5564b8746701bd67a92a2b11
Gitweb:        https://git.kernel.org/tip/b5eb4a5f6521d58d5564b8746701bd67a92a2b11
Author:        Yafang Shao <laoar.shao@gmail.com>
AuthorDate:    Sun, 05 Sep 2021 14:35:47 
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 05 Oct 2021 15:51:53 +02:00

sched/dl: Support schedstats for deadline sched class

After we make the struct sched_statistics and the helpers of it
independent of fair sched class, we can easily use the schedstats
facility for deadline sched class.

The schedstat usage in DL sched class is similar with fair sched class,
for example,
                    fair                        deadline
    enqueue         update_stats_enqueue_fair   update_stats_enqueue_dl
    dequeue         update_stats_dequeue_fair   update_stats_dequeue_dl
    put_prev_task   update_stats_wait_start     update_stats_wait_start_dl
    set_next_task   update_stats_wait_end       update_stats_wait_end_dl

The user can get the schedstats information in the same way in fair sched
class. For example,
           fair                            deadline
           /proc/[pid]/sched               /proc/[pid]/sched

The output of a deadline task's schedstats as follows,

$ cat /proc/69662/sched
...
se.sum_exec_runtime                          :          3067.696449
se.nr_migrations                             :                    0
sum_sleep_runtime                            :        720144.029661
sum_block_runtime                            :             0.547853
wait_start                                   :             0.000000
sleep_start                                  :      14131540.828955
block_start                                  :             0.000000
sleep_max                                    :          2999.974045
block_max                                    :             0.283637
exec_max                                     :             1.000269
slice_max                                    :             0.000000
wait_max                                     :             0.002217
wait_sum                                     :             0.762179
wait_count                                   :                  733
iowait_sum                                   :             0.547853
iowait_count                                 :                    3
nr_migrations_cold                           :                    0
nr_failed_migrations_affine                  :                    0
nr_failed_migrations_running                 :                    0
nr_failed_migrations_hot                     :                    0
nr_forced_migrations                         :                    0
nr_wakeups                                   :                  246
nr_wakeups_sync                              :                    2
nr_wakeups_migrate                           :                    0
nr_wakeups_local                             :                  244
nr_wakeups_remote                            :                    2
nr_wakeups_affine                            :                    0
nr_wakeups_affine_attempts                   :                    0
nr_wakeups_passive                           :                    0
nr_wakeups_idle                              :                    0
...

The sched:sched_stat_{wait, sleep, iowait, blocked} tracepoints can
be used to trace deadlline tasks as well.

Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/r/20210905143547.4668-9-laoar.shao@gmail.com
---
 kernel/sched/deadline.c | 93 ++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 93 insertions(+)

diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index 73fb33e..d2c072b 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -1474,6 +1474,82 @@ static inline bool __dl_less(struct rb_node *a, const struct rb_node *b)
 	return dl_time_before(__node_2_dle(a)->deadline, __node_2_dle(b)->deadline);
 }
 
+static inline struct sched_statistics *
+__schedstats_from_dl_se(struct sched_dl_entity *dl_se)
+{
+	return &dl_task_of(dl_se)->stats;
+}
+
+static inline void
+update_stats_wait_start_dl(struct dl_rq *dl_rq, struct sched_dl_entity *dl_se)
+{
+	struct sched_statistics *stats;
+
+	if (!schedstat_enabled())
+		return;
+
+	stats = __schedstats_from_dl_se(dl_se);
+	__update_stats_wait_start(rq_of_dl_rq(dl_rq), dl_task_of(dl_se), stats);
+}
+
+static inline void
+update_stats_wait_end_dl(struct dl_rq *dl_rq, struct sched_dl_entity *dl_se)
+{
+	struct sched_statistics *stats;
+
+	if (!schedstat_enabled())
+		return;
+
+	stats = __schedstats_from_dl_se(dl_se);
+	__update_stats_wait_end(rq_of_dl_rq(dl_rq), dl_task_of(dl_se), stats);
+}
+
+static inline void
+update_stats_enqueue_sleeper_dl(struct dl_rq *dl_rq, struct sched_dl_entity *dl_se)
+{
+	struct sched_statistics *stats;
+
+	if (!schedstat_enabled())
+		return;
+
+	stats = __schedstats_from_dl_se(dl_se);
+	__update_stats_enqueue_sleeper(rq_of_dl_rq(dl_rq), dl_task_of(dl_se), stats);
+}
+
+static inline void
+update_stats_enqueue_dl(struct dl_rq *dl_rq, struct sched_dl_entity *dl_se,
+			int flags)
+{
+	if (!schedstat_enabled())
+		return;
+
+	if (flags & ENQUEUE_WAKEUP)
+		update_stats_enqueue_sleeper_dl(dl_rq, dl_se);
+}
+
+static inline void
+update_stats_dequeue_dl(struct dl_rq *dl_rq, struct sched_dl_entity *dl_se,
+			int flags)
+{
+	struct task_struct *p = dl_task_of(dl_se);
+
+	if (!schedstat_enabled())
+		return;
+
+	if ((flags & DEQUEUE_SLEEP)) {
+		unsigned int state;
+
+		state = READ_ONCE(p->__state);
+		if (state & TASK_INTERRUPTIBLE)
+			__schedstat_set(p->stats.sleep_start,
+					rq_clock(rq_of_dl_rq(dl_rq)));
+
+		if (state & TASK_UNINTERRUPTIBLE)
+			__schedstat_set(p->stats.block_start,
+					rq_clock(rq_of_dl_rq(dl_rq)));
+	}
+}
+
 static void __enqueue_dl_entity(struct sched_dl_entity *dl_se)
 {
 	struct dl_rq *dl_rq = dl_rq_of_se(dl_se);
@@ -1504,6 +1580,8 @@ enqueue_dl_entity(struct sched_dl_entity *dl_se, int flags)
 {
 	BUG_ON(on_dl_rq(dl_se));
 
+	update_stats_enqueue_dl(dl_rq_of_se(dl_se), dl_se, flags);
+
 	/*
 	 * If this is a wakeup or a new instance, the scheduling
 	 * parameters of the task might need updating. Otherwise,
@@ -1600,6 +1678,9 @@ static void enqueue_task_dl(struct rq *rq, struct task_struct *p, int flags)
 		return;
 	}
 
+	check_schedstat_required();
+	update_stats_wait_start_dl(dl_rq_of_se(&p->dl), &p->dl);
+
 	enqueue_dl_entity(&p->dl, flags);
 
 	if (!task_current(rq, p) && p->nr_cpus_allowed > 1)
@@ -1608,6 +1689,7 @@ static void enqueue_task_dl(struct rq *rq, struct task_struct *p, int flags)
 
 static void __dequeue_task_dl(struct rq *rq, struct task_struct *p, int flags)
 {
+	update_stats_dequeue_dl(&rq->dl, &p->dl, flags);
 	dequeue_dl_entity(&p->dl);
 	dequeue_pushable_dl_task(rq, p);
 }
@@ -1827,7 +1909,12 @@ static void start_hrtick_dl(struct rq *rq, struct task_struct *p)
 
 static void set_next_task_dl(struct rq *rq, struct task_struct *p, bool first)
 {
+	struct sched_dl_entity *dl_se = &p->dl;
+	struct dl_rq *dl_rq = &rq->dl;
+
 	p->se.exec_start = rq_clock_task(rq);
+	if (on_dl_rq(&p->dl))
+		update_stats_wait_end_dl(dl_rq, dl_se);
 
 	/* You can't push away the running task */
 	dequeue_pushable_dl_task(rq, p);
@@ -1884,6 +1971,12 @@ static struct task_struct *pick_next_task_dl(struct rq *rq)
 
 static void put_prev_task_dl(struct rq *rq, struct task_struct *p)
 {
+	struct sched_dl_entity *dl_se = &p->dl;
+	struct dl_rq *dl_rq = &rq->dl;
+
+	if (on_dl_rq(&p->dl))
+		update_stats_wait_start_dl(dl_rq, dl_se);
+
 	update_curr_dl(rq);
 
 	update_dl_rq_load_avg(rq_clock_pelt(rq), rq, 1);
