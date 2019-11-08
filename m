Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 97019F5A49
	for <lists+linux-tip-commits@lfdr.de>; Fri,  8 Nov 2019 22:47:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732164AbfKHVlr (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 8 Nov 2019 16:41:47 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:52707 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732145AbfKHVlr (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 8 Nov 2019 16:41:47 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1iTC0b-0004QY-Q6; Fri, 08 Nov 2019 22:41:33 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 023071C0105;
        Fri,  8 Nov 2019 22:41:33 +0100 (CET)
Date:   Fri, 08 Nov 2019 21:41:32 -0000
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/urgent] sched: Fix pick_next_task() vs 'change' pattern race
Cc:     Quentin Perret <qperret@google.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <157324929261.29376.3929097391970267964.tip-bot2@tip-bot2>
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

The following commit has been merged into the sched/urgent branch of tip:

Commit-ID:     6e2df0581f569038719cf2bc2b3baa3fcc83cab4
Gitweb:        https://git.kernel.org/tip/6e2df0581f569038719cf2bc2b3baa3fcc83cab4
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Fri, 08 Nov 2019 11:11:52 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 08 Nov 2019 22:34:14 +01:00

sched: Fix pick_next_task() vs 'change' pattern race

Commit 67692435c411 ("sched: Rework pick_next_task() slow-path")
inadvertly introduced a race because it changed a previously
unexplored dependency between dropping the rq->lock and
sched_class::put_prev_task().

The comments about dropping rq->lock, in for example
newidle_balance(), only mentions the task being current and ->on_cpu
being set. But when we look at the 'change' pattern (in for example
sched_setnuma()):

	queued = task_on_rq_queued(p); /* p->on_rq == TASK_ON_RQ_QUEUED */
	running = task_current(rq, p); /* rq->curr == p */

	if (queued)
		dequeue_task(...);
	if (running)
		put_prev_task(...);

	/* change task properties */

	if (queued)
		enqueue_task(...);
	if (running)
		set_next_task(...);

It becomes obvious that if we do this after put_prev_task() has
already been called on @p, things go sideways. This is exactly what
the commit in question allows to happen when it does:

	prev->sched_class->put_prev_task(rq, prev, rf);
	if (!rq->nr_running)
		newidle_balance(rq, rf);

The newidle_balance() call will drop rq->lock after we've called
put_prev_task() and that allows the above 'change' pattern to
interleave and mess up the state.

Furthermore, it turns out we lost the RT-pull when we put the last DL
task.

Fix both problems by extracting the balancing from put_prev_task() and
doing a multi-class balance() pass before put_prev_task().

Fixes: 67692435c411 ("sched: Rework pick_next_task() slow-path")
Reported-by: Quentin Perret <qperret@google.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Tested-by: Quentin Perret <qperret@google.com>
Tested-by: Valentin Schneider <valentin.schneider@arm.com>
---
 kernel/sched/core.c      | 21 ++++++++++++++------
 kernel/sched/deadline.c  | 40 +++++++++++++++++++--------------------
 kernel/sched/fair.c      | 15 ++++++++++++---
 kernel/sched/idle.c      |  9 ++++++++-
 kernel/sched/rt.c        | 37 ++++++++++++++++++------------------
 kernel/sched/sched.h     | 30 ++++++++++++++++++++++++++---
 kernel/sched/stop_task.c | 18 +++++++++++-------
 7 files changed, 112 insertions(+), 58 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index afd4d80..0f2eb36 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -3929,13 +3929,22 @@ pick_next_task(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
 	}
 
 restart:
+#ifdef CONFIG_SMP
 	/*
-	 * Ensure that we put DL/RT tasks before the pick loop, such that they
-	 * can PULL higher prio tasks when we lower the RQ 'priority'.
+	 * We must do the balancing pass before put_next_task(), such
+	 * that when we release the rq->lock the task is in the same
+	 * state as before we took rq->lock.
+	 *
+	 * We can terminate the balance pass as soon as we know there is
+	 * a runnable task of @class priority or higher.
 	 */
-	prev->sched_class->put_prev_task(rq, prev, rf);
-	if (!rq->nr_running)
-		newidle_balance(rq, rf);
+	for_class_range(class, prev->sched_class, &idle_sched_class) {
+		if (class->balance(rq, prev, rf))
+			break;
+	}
+#endif
+
+	put_prev_task(rq, prev);
 
 	for_each_class(class) {
 		p = class->pick_next_task(rq, NULL, NULL);
@@ -6201,7 +6210,7 @@ static struct task_struct *__pick_migrate_task(struct rq *rq)
 	for_each_class(class) {
 		next = class->pick_next_task(rq, NULL, NULL);
 		if (next) {
-			next->sched_class->put_prev_task(rq, next, NULL);
+			next->sched_class->put_prev_task(rq, next);
 			return next;
 		}
 	}
diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index 2dc4872..a8a0803 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -1691,6 +1691,22 @@ static void check_preempt_equal_dl(struct rq *rq, struct task_struct *p)
 	resched_curr(rq);
 }
 
+static int balance_dl(struct rq *rq, struct task_struct *p, struct rq_flags *rf)
+{
+	if (!on_dl_rq(&p->dl) && need_pull_dl_task(rq, p)) {
+		/*
+		 * This is OK, because current is on_cpu, which avoids it being
+		 * picked for load-balance and preemption/IRQs are still
+		 * disabled avoiding further scheduler activity on it and we've
+		 * not yet started the picking loop.
+		 */
+		rq_unpin_lock(rq, rf);
+		pull_dl_task(rq);
+		rq_repin_lock(rq, rf);
+	}
+
+	return sched_stop_runnable(rq) || sched_dl_runnable(rq);
+}
 #endif /* CONFIG_SMP */
 
 /*
@@ -1758,45 +1774,28 @@ static struct task_struct *
 pick_next_task_dl(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
 {
 	struct sched_dl_entity *dl_se;
+	struct dl_rq *dl_rq = &rq->dl;
 	struct task_struct *p;
-	struct dl_rq *dl_rq;
 
 	WARN_ON_ONCE(prev || rf);
 
-	dl_rq = &rq->dl;
-
-	if (unlikely(!dl_rq->dl_nr_running))
+	if (!sched_dl_runnable(rq))
 		return NULL;
 
 	dl_se = pick_next_dl_entity(rq, dl_rq);
 	BUG_ON(!dl_se);
-
 	p = dl_task_of(dl_se);
-
 	set_next_task_dl(rq, p);
-
 	return p;
 }
 
-static void put_prev_task_dl(struct rq *rq, struct task_struct *p, struct rq_flags *rf)
+static void put_prev_task_dl(struct rq *rq, struct task_struct *p)
 {
 	update_curr_dl(rq);
 
 	update_dl_rq_load_avg(rq_clock_pelt(rq), rq, 1);
 	if (on_dl_rq(&p->dl) && p->nr_cpus_allowed > 1)
 		enqueue_pushable_dl_task(rq, p);
-
-	if (rf && !on_dl_rq(&p->dl) && need_pull_dl_task(rq, p)) {
-		/*
-		 * This is OK, because current is on_cpu, which avoids it being
-		 * picked for load-balance and preemption/IRQs are still
-		 * disabled avoiding further scheduler activity on it and we've
-		 * not yet started the picking loop.
-		 */
-		rq_unpin_lock(rq, rf);
-		pull_dl_task(rq);
-		rq_repin_lock(rq, rf);
-	}
 }
 
 /*
@@ -2442,6 +2441,7 @@ const struct sched_class dl_sched_class = {
 	.set_next_task		= set_next_task_dl,
 
 #ifdef CONFIG_SMP
+	.balance		= balance_dl,
 	.select_task_rq		= select_task_rq_dl,
 	.migrate_task_rq	= migrate_task_rq_dl,
 	.set_cpus_allowed       = set_cpus_allowed_dl,
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 682a754..22a2fed 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -6570,6 +6570,15 @@ static void task_dead_fair(struct task_struct *p)
 {
 	remove_entity_load_avg(&p->se);
 }
+
+static int
+balance_fair(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
+{
+	if (rq->nr_running)
+		return 1;
+
+	return newidle_balance(rq, rf) != 0;
+}
 #endif /* CONFIG_SMP */
 
 static unsigned long wakeup_gran(struct sched_entity *se)
@@ -6746,7 +6755,7 @@ pick_next_task_fair(struct rq *rq, struct task_struct *prev, struct rq_flags *rf
 	int new_tasks;
 
 again:
-	if (!cfs_rq->nr_running)
+	if (!sched_fair_runnable(rq))
 		goto idle;
 
 #ifdef CONFIG_FAIR_GROUP_SCHED
@@ -6884,7 +6893,7 @@ idle:
 /*
  * Account for a descheduled task:
  */
-static void put_prev_task_fair(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
+static void put_prev_task_fair(struct rq *rq, struct task_struct *prev)
 {
 	struct sched_entity *se = &prev->se;
 	struct cfs_rq *cfs_rq;
@@ -10414,11 +10423,11 @@ const struct sched_class fair_sched_class = {
 	.check_preempt_curr	= check_preempt_wakeup,
 
 	.pick_next_task		= pick_next_task_fair,
-
 	.put_prev_task		= put_prev_task_fair,
 	.set_next_task          = set_next_task_fair,
 
 #ifdef CONFIG_SMP
+	.balance		= balance_fair,
 	.select_task_rq		= select_task_rq_fair,
 	.migrate_task_rq	= migrate_task_rq_fair,
 
diff --git a/kernel/sched/idle.c b/kernel/sched/idle.c
index 8dad5aa..f65ef1e 100644
--- a/kernel/sched/idle.c
+++ b/kernel/sched/idle.c
@@ -365,6 +365,12 @@ select_task_rq_idle(struct task_struct *p, int cpu, int sd_flag, int flags)
 {
 	return task_cpu(p); /* IDLE tasks as never migrated */
 }
+
+static int
+balance_idle(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
+{
+	return WARN_ON_ONCE(1);
+}
 #endif
 
 /*
@@ -375,7 +381,7 @@ static void check_preempt_curr_idle(struct rq *rq, struct task_struct *p, int fl
 	resched_curr(rq);
 }
 
-static void put_prev_task_idle(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
+static void put_prev_task_idle(struct rq *rq, struct task_struct *prev)
 {
 }
 
@@ -460,6 +466,7 @@ const struct sched_class idle_sched_class = {
 	.set_next_task          = set_next_task_idle,
 
 #ifdef CONFIG_SMP
+	.balance		= balance_idle,
 	.select_task_rq		= select_task_rq_idle,
 	.set_cpus_allowed	= set_cpus_allowed_common,
 #endif
diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
index ebaa4e6..9b8adc0 100644
--- a/kernel/sched/rt.c
+++ b/kernel/sched/rt.c
@@ -1469,6 +1469,22 @@ static void check_preempt_equal_prio(struct rq *rq, struct task_struct *p)
 	resched_curr(rq);
 }
 
+static int balance_rt(struct rq *rq, struct task_struct *p, struct rq_flags *rf)
+{
+	if (!on_rt_rq(&p->rt) && need_pull_rt_task(rq, p)) {
+		/*
+		 * This is OK, because current is on_cpu, which avoids it being
+		 * picked for load-balance and preemption/IRQs are still
+		 * disabled avoiding further scheduler activity on it and we've
+		 * not yet started the picking loop.
+		 */
+		rq_unpin_lock(rq, rf);
+		pull_rt_task(rq);
+		rq_repin_lock(rq, rf);
+	}
+
+	return sched_stop_runnable(rq) || sched_dl_runnable(rq) || sched_rt_runnable(rq);
+}
 #endif /* CONFIG_SMP */
 
 /*
@@ -1552,21 +1568,18 @@ static struct task_struct *
 pick_next_task_rt(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
 {
 	struct task_struct *p;
-	struct rt_rq *rt_rq = &rq->rt;
 
 	WARN_ON_ONCE(prev || rf);
 
-	if (!rt_rq->rt_queued)
+	if (!sched_rt_runnable(rq))
 		return NULL;
 
 	p = _pick_next_task_rt(rq);
-
 	set_next_task_rt(rq, p);
-
 	return p;
 }
 
-static void put_prev_task_rt(struct rq *rq, struct task_struct *p, struct rq_flags *rf)
+static void put_prev_task_rt(struct rq *rq, struct task_struct *p)
 {
 	update_curr_rt(rq);
 
@@ -1578,18 +1591,6 @@ static void put_prev_task_rt(struct rq *rq, struct task_struct *p, struct rq_fla
 	 */
 	if (on_rt_rq(&p->rt) && p->nr_cpus_allowed > 1)
 		enqueue_pushable_task(rq, p);
-
-	if (rf && !on_rt_rq(&p->rt) && need_pull_rt_task(rq, p)) {
-		/*
-		 * This is OK, because current is on_cpu, which avoids it being
-		 * picked for load-balance and preemption/IRQs are still
-		 * disabled avoiding further scheduler activity on it and we've
-		 * not yet started the picking loop.
-		 */
-		rq_unpin_lock(rq, rf);
-		pull_rt_task(rq);
-		rq_repin_lock(rq, rf);
-	}
 }
 
 #ifdef CONFIG_SMP
@@ -2366,8 +2367,8 @@ const struct sched_class rt_sched_class = {
 	.set_next_task          = set_next_task_rt,
 
 #ifdef CONFIG_SMP
+	.balance		= balance_rt,
 	.select_task_rq		= select_task_rq_rt,
-
 	.set_cpus_allowed       = set_cpus_allowed_common,
 	.rq_online              = rq_online_rt,
 	.rq_offline             = rq_offline_rt,
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 0db2c1b..c8870c5 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -1727,10 +1727,11 @@ struct sched_class {
 	struct task_struct * (*pick_next_task)(struct rq *rq,
 					       struct task_struct *prev,
 					       struct rq_flags *rf);
-	void (*put_prev_task)(struct rq *rq, struct task_struct *p, struct rq_flags *rf);
+	void (*put_prev_task)(struct rq *rq, struct task_struct *p);
 	void (*set_next_task)(struct rq *rq, struct task_struct *p);
 
 #ifdef CONFIG_SMP
+	int (*balance)(struct rq *rq, struct task_struct *prev, struct rq_flags *rf);
 	int  (*select_task_rq)(struct task_struct *p, int task_cpu, int sd_flag, int flags);
 	void (*migrate_task_rq)(struct task_struct *p, int new_cpu);
 
@@ -1773,7 +1774,7 @@ struct sched_class {
 static inline void put_prev_task(struct rq *rq, struct task_struct *prev)
 {
 	WARN_ON_ONCE(rq->curr != prev);
-	prev->sched_class->put_prev_task(rq, prev, NULL);
+	prev->sched_class->put_prev_task(rq, prev);
 }
 
 static inline void set_next_task(struct rq *rq, struct task_struct *next)
@@ -1787,8 +1788,12 @@ static inline void set_next_task(struct rq *rq, struct task_struct *next)
 #else
 #define sched_class_highest (&dl_sched_class)
 #endif
+
+#define for_class_range(class, _from, _to) \
+	for (class = (_from); class != (_to); class = class->next)
+
 #define for_each_class(class) \
-   for (class = sched_class_highest; class; class = class->next)
+	for_class_range(class, sched_class_highest, NULL)
 
 extern const struct sched_class stop_sched_class;
 extern const struct sched_class dl_sched_class;
@@ -1796,6 +1801,25 @@ extern const struct sched_class rt_sched_class;
 extern const struct sched_class fair_sched_class;
 extern const struct sched_class idle_sched_class;
 
+static inline bool sched_stop_runnable(struct rq *rq)
+{
+	return rq->stop && task_on_rq_queued(rq->stop);
+}
+
+static inline bool sched_dl_runnable(struct rq *rq)
+{
+	return rq->dl.dl_nr_running > 0;
+}
+
+static inline bool sched_rt_runnable(struct rq *rq)
+{
+	return rq->rt.rt_queued > 0;
+}
+
+static inline bool sched_fair_runnable(struct rq *rq)
+{
+	return rq->cfs.nr_running > 0;
+}
 
 #ifdef CONFIG_SMP
 
diff --git a/kernel/sched/stop_task.c b/kernel/sched/stop_task.c
index 7e1cee4..c064073 100644
--- a/kernel/sched/stop_task.c
+++ b/kernel/sched/stop_task.c
@@ -15,6 +15,12 @@ select_task_rq_stop(struct task_struct *p, int cpu, int sd_flag, int flags)
 {
 	return task_cpu(p); /* stop tasks as never migrate */
 }
+
+static int
+balance_stop(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
+{
+	return sched_stop_runnable(rq);
+}
 #endif /* CONFIG_SMP */
 
 static void
@@ -31,16 +37,13 @@ static void set_next_task_stop(struct rq *rq, struct task_struct *stop)
 static struct task_struct *
 pick_next_task_stop(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
 {
-	struct task_struct *stop = rq->stop;
-
 	WARN_ON_ONCE(prev || rf);
 
-	if (!stop || !task_on_rq_queued(stop))
+	if (!sched_stop_runnable(rq))
 		return NULL;
 
-	set_next_task_stop(rq, stop);
-
-	return stop;
+	set_next_task_stop(rq, rq->stop);
+	return rq->stop;
 }
 
 static void
@@ -60,7 +63,7 @@ static void yield_task_stop(struct rq *rq)
 	BUG(); /* the stop task should never yield, its pointless. */
 }
 
-static void put_prev_task_stop(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
+static void put_prev_task_stop(struct rq *rq, struct task_struct *prev)
 {
 	struct task_struct *curr = rq->curr;
 	u64 delta_exec;
@@ -129,6 +132,7 @@ const struct sched_class stop_sched_class = {
 	.set_next_task          = set_next_task_stop,
 
 #ifdef CONFIG_SMP
+	.balance		= balance_stop,
 	.select_task_rq		= select_task_rq_stop,
 	.set_cpus_allowed	= set_cpus_allowed_common,
 #endif
