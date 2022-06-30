Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83D4F562EDE
	for <lists+linux-tip-commits@lfdr.de>; Fri,  1 Jul 2022 10:51:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235874AbiGAItf (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 1 Jul 2022 04:49:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235015AbiGAItR (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 1 Jul 2022 04:49:17 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E322712AF2;
        Fri,  1 Jul 2022 01:49:02 -0700 (PDT)
Date:   Thu, 30 Jun 2022 15:10:37 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1656665337;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lV67F15yzlxbIMEB5xGf0C877JJaZaL5oJwKq1KMCUo=;
        b=I1d4EmI46QLEA0bAPdt4ac2h0tyaQyIw0RDZePwRN9spGDpFj3/Y+2+lDMdvHMPQtBTVSa
        y+CnG8mklR5+tAif2CVKomoxi4WMp0QdYzwDJvU3LAJfRvN03gUKk41HxV1eDat69SByfh
        +8xSeW2XLKiwe29Ix3/wSWbdHuguYauSxkjF9MvR5TCHCLdZDiMPmFFvyc/tR653uJnlop
        cK7Hc9MNlcExtV7APqshi5ehwjf81DmWf3vTiI4yOjUX82V5Rto/fCknNgibAS9hq/FbEp
        8/AWRx63stdVwAcZIxick6IDQCnqjvninVIFEwtQSfE+gjuoPUNgCjlUl11c8g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1656665337;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lV67F15yzlxbIMEB5xGf0C877JJaZaL5oJwKq1KMCUo=;
        b=zzIHmozGDKVPWf+S8sJQoK9EZjJqj4fgYNbLRoHxHNp4MA/LMB3rBVqXGd+BHOmhKcZ5du
        3NNemegRZj3qRoAw==
From:   "tip-bot2 for Vincent Donnefort" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/fair: Decay task PELT values during wakeup migration
Cc:     Vincent Donnefort <vincent.donnefort@arm.com>,
        Vincent Donnefort <vdonnefort@google.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Lukasz Luba <lukasz.luba@arm.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220621090414.433602-3-vdonnefort@google.com>
References: <20220621090414.433602-3-vdonnefort@google.com>
MIME-Version: 1.0
Message-ID: <165660183769.15455.5197187482510729004.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DATE_IN_PAST_12_24,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     e2f3e35f1f5a4dccddf352cea534542544c9b867
Gitweb:        https://git.kernel.org/tip/e2f3e35f1f5a4dccddf352cea534542544c9b867
Author:        Vincent Donnefort <vincent.donnefort@arm.com>
AuthorDate:    Tue, 21 Jun 2022 10:04:09 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 28 Jun 2022 09:17:46 +02:00

sched/fair: Decay task PELT values during wakeup migration

Before being migrated to a new CPU, a task sees its PELT values
synchronized with rq last_update_time. Once done, that same task will also
have its sched_avg last_update_time reset. This means the time between
the migration and the last clock update will not be accounted for in
util_avg and a discontinuity will appear. This issue is amplified by the
PELT clock scaling. It takes currently one tick after the CPU being idle
to let clock_pelt catching up clock_task.

This is especially problematic for asymmetric CPU capacity systems which
need stable util_avg signals for task placement and energy estimation.

Ideally, this problem would be solved by updating the runqueue clocks
before the migration. But that would require taking the runqueue lock
which is quite expensive [1]. Instead estimate the missing time and update
the task util_avg with that value.

To that end, we need sched_clock_cpu() but it is a costly function. Limit
the usage to the case where the source CPU is idle as we know this is when
the clock is having the biggest risk of being outdated.

See comment in migrate_se_pelt_lag() for more details about how the PELT
value is estimated. Notice though this estimation doesn't take into account
IRQ and Paravirt time.

[1] https://lkml.kernel.org/r/20190709115759.10451-1-chris.redpath@arm.com

Signed-off-by: Vincent Donnefort <vincent.donnefort@arm.com>
Signed-off-by: Vincent Donnefort <vdonnefort@google.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Vincent Guittot <vincent.guittot@linaro.org>
Reviewed-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
Tested-by: Lukasz Luba <lukasz.luba@arm.com>
Link: https://lkml.kernel.org/r/20220621090414.433602-3-vdonnefort@google.com
---
 kernel/sched/fair.c  | 156 ++++++++++++++++++++++++++++++++++--------
 kernel/sched/pelt.h  |  40 +++++++++--
 kernel/sched/sched.h |  10 +++-
 3 files changed, 172 insertions(+), 34 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 8dc0903..80be1f1 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -3345,6 +3345,29 @@ static inline void cfs_rq_util_change(struct cfs_rq *cfs_rq, int flags)
 }
 
 #ifdef CONFIG_SMP
+static inline bool load_avg_is_decayed(struct sched_avg *sa)
+{
+	if (sa->load_sum)
+		return false;
+
+	if (sa->util_sum)
+		return false;
+
+	if (sa->runnable_sum)
+		return false;
+
+	/*
+	 * _avg must be null when _sum are null because _avg = _sum / divider
+	 * Make sure that rounding and/or propagation of PELT values never
+	 * break this.
+	 */
+	SCHED_WARN_ON(sa->load_avg ||
+		      sa->util_avg ||
+		      sa->runnable_avg);
+
+	return true;
+}
+
 static inline u64 cfs_rq_last_update_time(struct cfs_rq *cfs_rq)
 {
 	return u64_u32_load_copy(cfs_rq->avg.last_update_time,
@@ -3382,27 +3405,12 @@ static inline bool cfs_rq_is_decayed(struct cfs_rq *cfs_rq)
 	if (cfs_rq->load.weight)
 		return false;
 
-	if (cfs_rq->avg.load_sum)
-		return false;
-
-	if (cfs_rq->avg.util_sum)
-		return false;
-
-	if (cfs_rq->avg.runnable_sum)
+	if (!load_avg_is_decayed(&cfs_rq->avg))
 		return false;
 
 	if (child_cfs_rq_on_list(cfs_rq))
 		return false;
 
-	/*
-	 * _avg must be null when _sum are null because _avg = _sum / divider
-	 * Make sure that rounding and/or propagation of PELT values never
-	 * break this.
-	 */
-	SCHED_WARN_ON(cfs_rq->avg.load_avg ||
-		      cfs_rq->avg.util_avg ||
-		      cfs_rq->avg.runnable_avg);
-
 	return true;
 }
 
@@ -3741,6 +3749,89 @@ static inline void add_tg_cfs_propagate(struct cfs_rq *cfs_rq, long runnable_sum
 
 #endif /* CONFIG_FAIR_GROUP_SCHED */
 
+#ifdef CONFIG_NO_HZ_COMMON
+static inline void migrate_se_pelt_lag(struct sched_entity *se)
+{
+	u64 throttled = 0, now, lut;
+	struct cfs_rq *cfs_rq;
+	struct rq *rq;
+	bool is_idle;
+
+	if (load_avg_is_decayed(&se->avg))
+		return;
+
+	cfs_rq = cfs_rq_of(se);
+	rq = rq_of(cfs_rq);
+
+	rcu_read_lock();
+	is_idle = is_idle_task(rcu_dereference(rq->curr));
+	rcu_read_unlock();
+
+	/*
+	 * The lag estimation comes with a cost we don't want to pay all the
+	 * time. Hence, limiting to the case where the source CPU is idle and
+	 * we know we are at the greatest risk to have an outdated clock.
+	 */
+	if (!is_idle)
+		return;
+
+	/*
+	 * Estimated "now" is: last_update_time + cfs_idle_lag + rq_idle_lag, where:
+	 *
+	 *   last_update_time (the cfs_rq's last_update_time)
+	 *	= cfs_rq_clock_pelt()@cfs_rq_idle
+	 *      = rq_clock_pelt()@cfs_rq_idle
+	 *        - cfs->throttled_clock_pelt_time@cfs_rq_idle
+	 *
+	 *   cfs_idle_lag (delta between rq's update and cfs_rq's update)
+	 *      = rq_clock_pelt()@rq_idle - rq_clock_pelt()@cfs_rq_idle
+	 *
+	 *   rq_idle_lag (delta between now and rq's update)
+	 *      = sched_clock_cpu() - rq_clock()@rq_idle
+	 *
+	 * We can then write:
+	 *
+	 *    now = rq_clock_pelt()@rq_idle - cfs->throttled_clock_pelt_time +
+	 *          sched_clock_cpu() - rq_clock()@rq_idle
+	 * Where:
+	 *      rq_clock_pelt()@rq_idle is rq->clock_pelt_idle
+	 *      rq_clock()@rq_idle      is rq->clock_idle
+	 *      cfs->throttled_clock_pelt_time@cfs_rq_idle
+	 *                              is cfs_rq->throttled_pelt_idle
+	 */
+
+#ifdef CONFIG_CFS_BANDWIDTH
+	throttled = u64_u32_load(cfs_rq->throttled_pelt_idle);
+	/* The clock has been stopped for throttling */
+	if (throttled == U64_MAX)
+		return;
+#endif
+	now = u64_u32_load(rq->clock_pelt_idle);
+	/*
+	 * Paired with _update_idle_rq_clock_pelt(). It ensures at the worst case
+	 * is observed the old clock_pelt_idle value and the new clock_idle,
+	 * which lead to an underestimation. The opposite would lead to an
+	 * overestimation.
+	 */
+	smp_rmb();
+	lut = cfs_rq_last_update_time(cfs_rq);
+
+	now -= throttled;
+	if (now < lut)
+		/*
+		 * cfs_rq->avg.last_update_time is more recent than our
+		 * estimation, let's use it.
+		 */
+		now = lut;
+	else
+		now += sched_clock_cpu(cpu_of(rq)) - u64_u32_load(rq->clock_idle);
+
+	__update_load_avg_blocked_se(now, se);
+}
+#else
+static void migrate_se_pelt_lag(struct sched_entity *se) {}
+#endif
+
 /**
  * update_cfs_rq_load_avg - update the cfs_rq's load/util averages
  * @now: current time, as per cfs_rq_clock_pelt()
@@ -4467,6 +4558,9 @@ dequeue_entity(struct cfs_rq *cfs_rq, struct sched_entity *se, int flags)
 	 */
 	if ((flags & (DEQUEUE_SAVE | DEQUEUE_MOVE)) != DEQUEUE_SAVE)
 		update_min_vruntime(cfs_rq);
+
+	if (cfs_rq->nr_running == 0)
+		update_idle_cfs_rq_clock_pelt(cfs_rq);
 }
 
 /*
@@ -6919,6 +7013,8 @@ static void detach_entity_cfs_rq(struct sched_entity *se);
  */
 static void migrate_task_rq_fair(struct task_struct *p, int new_cpu)
 {
+	struct sched_entity *se = &p->se;
+
 	/*
 	 * As blocked tasks retain absolute vruntime the migration needs to
 	 * deal with this by subtracting the old and adding the new
@@ -6926,7 +7022,6 @@ static void migrate_task_rq_fair(struct task_struct *p, int new_cpu)
 	 * the task on the new runqueue.
 	 */
 	if (READ_ONCE(p->__state) == TASK_WAKING) {
-		struct sched_entity *se = &p->se;
 		struct cfs_rq *cfs_rq = cfs_rq_of(se);
 
 		se->vruntime -= u64_u32_load(cfs_rq->min_vruntime);
@@ -6938,25 +7033,29 @@ static void migrate_task_rq_fair(struct task_struct *p, int new_cpu)
 		 * rq->lock and can modify state directly.
 		 */
 		lockdep_assert_rq_held(task_rq(p));
-		detach_entity_cfs_rq(&p->se);
+		detach_entity_cfs_rq(se);
 
 	} else {
+		remove_entity_load_avg(se);
+
 		/*
-		 * We are supposed to update the task to "current" time, then
-		 * its up to date and ready to go to new CPU/cfs_rq. But we
-		 * have difficulty in getting what current time is, so simply
-		 * throw away the out-of-date time. This will result in the
-		 * wakee task is less decayed, but giving the wakee more load
-		 * sounds not bad.
+		 * Here, the task's PELT values have been updated according to
+		 * the current rq's clock. But if that clock hasn't been
+		 * updated in a while, a substantial idle time will be missed,
+		 * leading to an inflation after wake-up on the new rq.
+		 *
+		 * Estimate the missing time from the cfs_rq last_update_time
+		 * and update sched_avg to improve the PELT continuity after
+		 * migration.
 		 */
-		remove_entity_load_avg(&p->se);
+		migrate_se_pelt_lag(se);
 	}
 
 	/* Tell new CPU we are migrated */
-	p->se.avg.last_update_time = 0;
+	se->avg.last_update_time = 0;
 
 	/* We have migrated, no longer consider this task hot */
-	p->se.exec_start = 0;
+	se->exec_start = 0;
 
 	update_scan_period(p, new_cpu);
 }
@@ -8122,6 +8221,9 @@ static bool __update_blocked_fair(struct rq *rq, bool *done)
 		if (update_cfs_rq_load_avg(cfs_rq_clock_pelt(cfs_rq), cfs_rq)) {
 			update_tg_load_avg(cfs_rq);
 
+			if (cfs_rq->nr_running == 0)
+				update_idle_cfs_rq_clock_pelt(cfs_rq);
+
 			if (cfs_rq == &rq->cfs)
 				decayed = true;
 		}
diff --git a/kernel/sched/pelt.h b/kernel/sched/pelt.h
index 4ff2ed4..3a0e0dc 100644
--- a/kernel/sched/pelt.h
+++ b/kernel/sched/pelt.h
@@ -61,6 +61,25 @@ static inline void cfs_se_util_change(struct sched_avg *avg)
 	WRITE_ONCE(avg->util_est.enqueued, enqueued);
 }
 
+static inline u64 rq_clock_pelt(struct rq *rq)
+{
+	lockdep_assert_rq_held(rq);
+	assert_clock_updated(rq);
+
+	return rq->clock_pelt - rq->lost_idle_time;
+}
+
+/* The rq is idle, we can sync to clock_task */
+static inline void _update_idle_rq_clock_pelt(struct rq *rq)
+{
+	rq->clock_pelt  = rq_clock_task(rq);
+
+	u64_u32_store(rq->clock_idle, rq_clock(rq));
+	/* Paired with smp_rmb in migrate_se_pelt_lag() */
+	smp_wmb();
+	u64_u32_store(rq->clock_pelt_idle, rq_clock_pelt(rq));
+}
+
 /*
  * The clock_pelt scales the time to reflect the effective amount of
  * computation done during the running delta time but then sync back to
@@ -76,8 +95,7 @@ static inline void cfs_se_util_change(struct sched_avg *avg)
 static inline void update_rq_clock_pelt(struct rq *rq, s64 delta)
 {
 	if (unlikely(is_idle_task(rq->curr))) {
-		/* The rq is idle, we can sync to clock_task */
-		rq->clock_pelt  = rq_clock_task(rq);
+		_update_idle_rq_clock_pelt(rq);
 		return;
 	}
 
@@ -130,17 +148,23 @@ static inline void update_idle_rq_clock_pelt(struct rq *rq)
 	 */
 	if (util_sum >= divider)
 		rq->lost_idle_time += rq_clock_task(rq) - rq->clock_pelt;
+
+	_update_idle_rq_clock_pelt(rq);
 }
 
-static inline u64 rq_clock_pelt(struct rq *rq)
+#ifdef CONFIG_CFS_BANDWIDTH
+static inline void update_idle_cfs_rq_clock_pelt(struct cfs_rq *cfs_rq)
 {
-	lockdep_assert_rq_held(rq);
-	assert_clock_updated(rq);
+	u64 throttled;
 
-	return rq->clock_pelt - rq->lost_idle_time;
+	if (unlikely(cfs_rq->throttle_count))
+		throttled = U64_MAX;
+	else
+		throttled = cfs_rq->throttled_clock_pelt_time;
+
+	u64_u32_store(cfs_rq->throttled_pelt_idle, throttled);
 }
 
-#ifdef CONFIG_CFS_BANDWIDTH
 /* rq->task_clock normalized against any time this cfs_rq has spent throttled */
 static inline u64 cfs_rq_clock_pelt(struct cfs_rq *cfs_rq)
 {
@@ -150,6 +174,7 @@ static inline u64 cfs_rq_clock_pelt(struct cfs_rq *cfs_rq)
 	return rq_clock_pelt(rq_of(cfs_rq)) - cfs_rq->throttled_clock_pelt_time;
 }
 #else
+static inline void update_idle_cfs_rq_clock_pelt(struct cfs_rq *cfs_rq) { }
 static inline u64 cfs_rq_clock_pelt(struct cfs_rq *cfs_rq)
 {
 	return rq_clock_pelt(rq_of(cfs_rq));
@@ -204,6 +229,7 @@ update_rq_clock_pelt(struct rq *rq, s64 delta) { }
 static inline void
 update_idle_rq_clock_pelt(struct rq *rq) { }
 
+static inline void update_idle_cfs_rq_clock_pelt(struct cfs_rq *cfs_rq) { }
 #endif
 
 
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 8a3c8a0..76b0027 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -648,6 +648,10 @@ struct cfs_rq {
 	int			runtime_enabled;
 	s64			runtime_remaining;
 
+	u64			throttled_pelt_idle;
+#ifndef CONFIG_64BIT
+	u64                     throttled_pelt_idle_copy;
+#endif
 	u64			throttled_clock;
 	u64			throttled_clock_pelt;
 	u64			throttled_clock_pelt_time;
@@ -1020,6 +1024,12 @@ struct rq {
 	u64			clock_task ____cacheline_aligned;
 	u64			clock_pelt;
 	unsigned long		lost_idle_time;
+	u64			clock_pelt_idle;
+	u64			clock_idle;
+#ifndef CONFIG_64BIT
+	u64			clock_pelt_idle_copy;
+	u64			clock_idle_copy;
+#endif
 
 	atomic_t		nr_iowait;
 
