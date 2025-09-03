Return-Path: <linux-tip-commits+bounces-6421-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F9F6B417D3
	for <lists+linux-tip-commits@lfdr.de>; Wed,  3 Sep 2025 10:05:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D7F3D4E4A8D
	for <lists+linux-tip-commits@lfdr.de>; Wed,  3 Sep 2025 08:05:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B66862E7F0D;
	Wed,  3 Sep 2025 08:05:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="AbOWQqBD";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="cr0/1xzi"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FABF2E2F0E;
	Wed,  3 Sep 2025 08:05:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756886716; cv=none; b=FvK1twbIfqHcEhz5IEl1Ogm57jhSJNbdMMvHKpY8F2MBu3nPCBMkIqw2inzPg29L3G5/YngUZA2dQiGZniA7HXeRlC0OMJscDGVKPbEblUYUkSsLVWYHgeogFs4lm+R8fo7IhVu2oZHN3TMVrSJ6/CcNcBvSAkEfGe/+1qiwxLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756886716; c=relaxed/simple;
	bh=8z2OfVwI5RaceQDCpf/IeQ/rUikfyLUz1e5BjZEUCWc=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=cWm/JWAyYWAHHQaQ5xVCcqtMLXIibezXExYcPf6es5jPLd5WFsWZpjy4wS+8m58PeM9IeCE5LUce12JQMoGXwi29ejQwNt0+ealGcHpXoHr0CXvXEMgkv/ResKekzaUGqf+ERyA3eleAeZIBe0zcaO24nwHuYJ/qjB6EaHANU6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=AbOWQqBD; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=cr0/1xzi; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 03 Sep 2025 08:05:08 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1756886709;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Kc8FMsRD6gGN7llCs1m+p3PIS7LITAq+ahPAoyNzo6Q=;
	b=AbOWQqBDe1R+ag4P4f2OSartNt5nxZt49jLhYBug3Ig+MqM3F75IlkFZqvyPrCHSbdZV+j
	ZyoyV+rmh2eiuMfkEz9uNv0WrNr2GYxjPYkYb6bYNPyROM6dSr8+kobdGweyVclK0tE589
	ZXPJeAvucwp5YgZnXKWmn+w8qjP6FAVHQtBT6UCt8moSeMyxjPhEfcKccvf+jNEjtiCIPr
	z6x+OY0VMiaEsjwH+zRYi+KyGR0TU7Zn448I/+wMNbCPIW1N2dBEIap9OnU0dw4ds02pGG
	8+yahXoJ4wbe+hG5U18stHN4AlJC1wrrqqFy9fvb6n/kWO2cVDYkl/Ize1/v+A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1756886709;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Kc8FMsRD6gGN7llCs1m+p3PIS7LITAq+ahPAoyNzo6Q=;
	b=cr0/1xziV6MIAg8xHVESTlgLl1iyx10iBUKE2EqJWbK0Rzuf5AqDaPjN8gyeo9bKUfVPmp
	ftV1pgCiXEYavPBQ==
From: "tip-bot2 for Valentin Schneider" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/fair: Switch to task based throttle model
Cc: Chengming Zhou <chengming.zhou@linux.dev>,
 Valentin Schneider <vschneid@redhat.com>, Aaron Lu <ziqianlu@bytedance.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Chen Yu <yu.c.chen@intel.com>,
 Matteo Martelli <matteo.martelli@codethink.co.uk>,
 K Prateek Nayak <kprateek.nayak@amd.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250829081120.806-4-ziqianlu@bytedance.com>
References: <20250829081120.806-4-ziqianlu@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175688670834.1920.10355703591599323996.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     e1fad12dcb66b7f35573c52b665830a1538f9886
Gitweb:        https://git.kernel.org/tip/e1fad12dcb66b7f35573c52b665830a1538=
f9886
Author:        Valentin Schneider <vschneid@redhat.com>
AuthorDate:    Fri, 29 Aug 2025 16:11:18 +08:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 03 Sep 2025 10:03:14 +02:00

sched/fair: Switch to task based throttle model

In current throttle model, when a cfs_rq is throttled, its entity will
be dequeued from cpu's rq, making tasks attached to it not able to run,
thus achiveing the throttle target.

This has a drawback though: assume a task is a reader of percpu_rwsem
and is waiting. When it gets woken, it can not run till its task group's
next period comes, which can be a relatively long time. Waiting writer
will have to wait longer due to this and it also makes further reader
build up and eventually trigger task hung.

To improve this situation, change the throttle model to task based, i.e.
when a cfs_rq is throttled, record its throttled status but do not remove
it from cpu's rq. Instead, for tasks that belong to this cfs_rq, when
they get picked, add a task work to them so that when they return
to user, they can be dequeued there. In this way, tasks throttled will
not hold any kernel resources. And on unthrottle, enqueue back those
tasks so they can continue to run.

Throttled cfs_rq's PELT clock is handled differently now: previously the
cfs_rq's PELT clock is stopped once it entered throttled state but since
now tasks(in kernel mode) can continue to run, change the behaviour to
stop PELT clock when the throttled cfs_rq has no tasks left.

Suggested-by: Chengming Zhou <chengming.zhou@linux.dev> # tag on pick
Signed-off-by: Valentin Schneider <vschneid@redhat.com>
Signed-off-by: Aaron Lu <ziqianlu@bytedance.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Tested-by: Valentin Schneider <vschneid@redhat.com>
Tested-by: Chen Yu <yu.c.chen@intel.com>
Tested-by: Matteo Martelli <matteo.martelli@codethink.co.uk>
Tested-by: K Prateek Nayak <kprateek.nayak@amd.com>
Link: https://lore.kernel.org/r/20250829081120.806-4-ziqianlu@bytedance.com
---
 kernel/sched/fair.c  | 341 +++++++++++++++++++++---------------------
 kernel/sched/pelt.h  |   4 +-
 kernel/sched/sched.h |   3 +-
 3 files changed, 181 insertions(+), 167 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index dab4ed8..25b1014 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -5291,18 +5291,23 @@ enqueue_entity(struct cfs_rq *cfs_rq, struct sched_en=
tity *se, int flags)
=20
 	if (cfs_rq->nr_queued =3D=3D 1) {
 		check_enqueue_throttle(cfs_rq);
-		if (!throttled_hierarchy(cfs_rq)) {
-			list_add_leaf_cfs_rq(cfs_rq);
-		} else {
+		list_add_leaf_cfs_rq(cfs_rq);
 #ifdef CONFIG_CFS_BANDWIDTH
+		if (throttled_hierarchy(cfs_rq)) {
 			struct rq *rq =3D rq_of(cfs_rq);
=20
 			if (cfs_rq_throttled(cfs_rq) && !cfs_rq->throttled_clock)
 				cfs_rq->throttled_clock =3D rq_clock(rq);
 			if (!cfs_rq->throttled_clock_self)
 				cfs_rq->throttled_clock_self =3D rq_clock(rq);
-#endif
+
+			if (cfs_rq->pelt_clock_throttled) {
+				cfs_rq->throttled_clock_pelt_time +=3D rq_clock_pelt(rq) -
+					cfs_rq->throttled_clock_pelt;
+				cfs_rq->pelt_clock_throttled =3D 0;
+			}
 		}
+#endif
 	}
 }
=20
@@ -5341,8 +5346,6 @@ static void set_delayed(struct sched_entity *se)
 		struct cfs_rq *cfs_rq =3D cfs_rq_of(se);
=20
 		cfs_rq->h_nr_runnable--;
-		if (cfs_rq_throttled(cfs_rq))
-			break;
 	}
 }
=20
@@ -5363,8 +5366,6 @@ static void clear_delayed(struct sched_entity *se)
 		struct cfs_rq *cfs_rq =3D cfs_rq_of(se);
=20
 		cfs_rq->h_nr_runnable++;
-		if (cfs_rq_throttled(cfs_rq))
-			break;
 	}
 }
=20
@@ -5450,8 +5451,18 @@ dequeue_entity(struct cfs_rq *cfs_rq, struct sched_ent=
ity *se, int flags)
 	if (flags & DEQUEUE_DELAYED)
 		finish_delayed_dequeue_entity(se);
=20
-	if (cfs_rq->nr_queued =3D=3D 0)
+	if (cfs_rq->nr_queued =3D=3D 0) {
 		update_idle_cfs_rq_clock_pelt(cfs_rq);
+#ifdef CONFIG_CFS_BANDWIDTH
+		if (throttled_hierarchy(cfs_rq)) {
+			struct rq *rq =3D rq_of(cfs_rq);
+
+			list_del_leaf_cfs_rq(cfs_rq);
+			cfs_rq->throttled_clock_pelt =3D rq_clock_pelt(rq);
+			cfs_rq->pelt_clock_throttled =3D 1;
+		}
+#endif
+	}
=20
 	return true;
 }
@@ -5790,6 +5801,10 @@ static void throttle_cfs_rq_work(struct callback_head =
*work)
 		WARN_ON_ONCE(p->throttled || !list_empty(&p->throttle_node));
 		dequeue_task_fair(rq, p, DEQUEUE_SLEEP | DEQUEUE_SPECIAL);
 		list_add(&p->throttle_node, &cfs_rq->throttled_limbo_list);
+		/*
+		 * Must not set throttled before dequeue or dequeue will
+		 * mistakenly regard this task as an already throttled one.
+		 */
 		p->throttled =3D true;
 		resched_curr(rq);
 	}
@@ -5803,32 +5818,124 @@ void init_cfs_throttle_work(struct task_struct *p)
 	INIT_LIST_HEAD(&p->throttle_node);
 }
=20
+/*
+ * Task is throttled and someone wants to dequeue it again:
+ * it could be sched/core when core needs to do things like
+ * task affinity change, task group change, task sched class
+ * change etc. and in these cases, DEQUEUE_SLEEP is not set;
+ * or the task is blocked after throttled due to freezer etc.
+ * and in these cases, DEQUEUE_SLEEP is set.
+ */
+static void detach_task_cfs_rq(struct task_struct *p);
+static void dequeue_throttled_task(struct task_struct *p, int flags)
+{
+	WARN_ON_ONCE(p->se.on_rq);
+	list_del_init(&p->throttle_node);
+
+	/* task blocked after throttled */
+	if (flags & DEQUEUE_SLEEP) {
+		p->throttled =3D false;
+		return;
+	}
+
+	/*
+	 * task is migrating off its old cfs_rq, detach
+	 * the task's load from its old cfs_rq.
+	 */
+	if (task_on_rq_migrating(p))
+		detach_task_cfs_rq(p);
+}
+
+static bool enqueue_throttled_task(struct task_struct *p)
+{
+	struct cfs_rq *cfs_rq =3D cfs_rq_of(&p->se);
+
+	/* @p should have gone through dequeue_throttled_task() first */
+	WARN_ON_ONCE(!list_empty(&p->throttle_node));
+
+	/*
+	 * If the throttled task @p is enqueued to a throttled cfs_rq,
+	 * take the fast path by directly putting the task on the
+	 * target cfs_rq's limbo list.
+	 *
+	 * Do not do that when @p is current because the following race can
+	 * cause @p's group_node to be incorectly re-insterted in its rq's
+	 * cfs_tasks list, despite being throttled:
+	 *
+	 *     cpuX                       cpuY
+	 *   p ret2user
+	 *  throttle_cfs_rq_work()  sched_move_task(p)
+	 *  LOCK task_rq_lock
+	 *  dequeue_task_fair(p)
+	 *  UNLOCK task_rq_lock
+	 *                          LOCK task_rq_lock
+	 *                          task_current_donor(p) =3D=3D true
+	 *                          task_on_rq_queued(p) =3D=3D true
+	 *                          dequeue_task(p)
+	 *                          put_prev_task(p)
+	 *                          sched_change_group()
+	 *                          enqueue_task(p) -> p's new cfs_rq
+	 *                                             is throttled, go
+	 *                                             fast path and skip
+	 *                                             actual enqueue
+	 *                          set_next_task(p)
+	 *                    list_move(&se->group_node, &rq->cfs_tasks); // bug
+	 *  schedule()
+	 *
+	 * In the above race case, @p current cfs_rq is in the same rq as
+	 * its previous cfs_rq because sched_move_task() only moves a task
+	 * to a different group from the same rq, so we can use its current
+	 * cfs_rq to derive rq and test if the task is current.
+	 */
+	if (throttled_hierarchy(cfs_rq) &&
+	    !task_current_donor(rq_of(cfs_rq), p)) {
+		list_add(&p->throttle_node, &cfs_rq->throttled_limbo_list);
+		return true;
+	}
+
+	/* we can't take the fast path, do an actual enqueue*/
+	p->throttled =3D false;
+	return false;
+}
+
+static void enqueue_task_fair(struct rq *rq, struct task_struct *p, int flag=
s);
 static int tg_unthrottle_up(struct task_group *tg, void *data)
 {
 	struct rq *rq =3D data;
 	struct cfs_rq *cfs_rq =3D tg->cfs_rq[cpu_of(rq)];
+	struct task_struct *p, *tmp;
+
+	if (--cfs_rq->throttle_count)
+		return 0;
=20
-	cfs_rq->throttle_count--;
-	if (!cfs_rq->throttle_count) {
+	if (cfs_rq->pelt_clock_throttled) {
 		cfs_rq->throttled_clock_pelt_time +=3D rq_clock_pelt(rq) -
 					     cfs_rq->throttled_clock_pelt;
+		cfs_rq->pelt_clock_throttled =3D 0;
+	}
=20
-		/* Add cfs_rq with load or one or more already running entities to the lis=
t */
-		if (!cfs_rq_is_decayed(cfs_rq))
-			list_add_leaf_cfs_rq(cfs_rq);
+	if (cfs_rq->throttled_clock_self) {
+		u64 delta =3D rq_clock(rq) - cfs_rq->throttled_clock_self;
=20
-		if (cfs_rq->throttled_clock_self) {
-			u64 delta =3D rq_clock(rq) - cfs_rq->throttled_clock_self;
+		cfs_rq->throttled_clock_self =3D 0;
=20
-			cfs_rq->throttled_clock_self =3D 0;
+		if (WARN_ON_ONCE((s64)delta < 0))
+			delta =3D 0;
=20
-			if (WARN_ON_ONCE((s64)delta < 0))
-				delta =3D 0;
+		cfs_rq->throttled_clock_self_time +=3D delta;
+	}
=20
-			cfs_rq->throttled_clock_self_time +=3D delta;
-		}
+	/* Re-enqueue the tasks that have been throttled at this level. */
+	list_for_each_entry_safe(p, tmp, &cfs_rq->throttled_limbo_list, throttle_no=
de) {
+		list_del_init(&p->throttle_node);
+		p->throttled =3D false;
+		enqueue_task_fair(rq_of(cfs_rq), p, ENQUEUE_WAKEUP);
 	}
=20
+	/* Add cfs_rq with load or one or more already running entities to the list=
 */
+	if (!cfs_rq_is_decayed(cfs_rq))
+		list_add_leaf_cfs_rq(cfs_rq);
+
 	return 0;
 }
=20
@@ -5857,17 +5964,25 @@ static int tg_throttle_down(struct task_group *tg, vo=
id *data)
 	struct rq *rq =3D data;
 	struct cfs_rq *cfs_rq =3D tg->cfs_rq[cpu_of(rq)];
=20
+	if (cfs_rq->throttle_count++)
+		return 0;
+
+
 	/* group is entering throttled state, stop time */
-	if (!cfs_rq->throttle_count) {
-		cfs_rq->throttled_clock_pelt =3D rq_clock_pelt(rq);
+	WARN_ON_ONCE(cfs_rq->throttled_clock_self);
+	if (cfs_rq->nr_queued)
+		cfs_rq->throttled_clock_self =3D rq_clock(rq);
+	else {
+		/*
+		 * For cfs_rqs that still have entities enqueued, PELT clock
+		 * stop happens at dequeue time when all entities are dequeued.
+		 */
 		list_del_leaf_cfs_rq(cfs_rq);
-
-		WARN_ON_ONCE(cfs_rq->throttled_clock_self);
-		if (cfs_rq->nr_queued)
-			cfs_rq->throttled_clock_self =3D rq_clock(rq);
+		cfs_rq->throttled_clock_pelt =3D rq_clock_pelt(rq);
+		cfs_rq->pelt_clock_throttled =3D 1;
 	}
-	cfs_rq->throttle_count++;
=20
+	WARN_ON_ONCE(!list_empty(&cfs_rq->throttled_limbo_list));
 	return 0;
 }
=20
@@ -5875,8 +5990,7 @@ static bool throttle_cfs_rq(struct cfs_rq *cfs_rq)
 {
 	struct rq *rq =3D rq_of(cfs_rq);
 	struct cfs_bandwidth *cfs_b =3D tg_cfs_bandwidth(cfs_rq->tg);
-	struct sched_entity *se;
-	long queued_delta, runnable_delta, idle_delta, dequeue =3D 1;
+	int dequeue =3D 1;
=20
 	raw_spin_lock(&cfs_b->lock);
 	/* This will start the period timer if necessary */
@@ -5899,68 +6013,11 @@ static bool throttle_cfs_rq(struct cfs_rq *cfs_rq)
 	if (!dequeue)
 		return false;  /* Throttle no longer required. */
=20
-	se =3D cfs_rq->tg->se[cpu_of(rq_of(cfs_rq))];
-
 	/* freeze hierarchy runnable averages while throttled */
 	rcu_read_lock();
 	walk_tg_tree_from(cfs_rq->tg, tg_throttle_down, tg_nop, (void *)rq);
 	rcu_read_unlock();
=20
-	queued_delta =3D cfs_rq->h_nr_queued;
-	runnable_delta =3D cfs_rq->h_nr_runnable;
-	idle_delta =3D cfs_rq->h_nr_idle;
-	for_each_sched_entity(se) {
-		struct cfs_rq *qcfs_rq =3D cfs_rq_of(se);
-		int flags;
-
-		/* throttled entity or throttle-on-deactivate */
-		if (!se->on_rq)
-			goto done;
-
-		/*
-		 * Abuse SPECIAL to avoid delayed dequeue in this instance.
-		 * This avoids teaching dequeue_entities() about throttled
-		 * entities and keeps things relatively simple.
-		 */
-		flags =3D DEQUEUE_SLEEP | DEQUEUE_SPECIAL;
-		if (se->sched_delayed)
-			flags |=3D DEQUEUE_DELAYED;
-		dequeue_entity(qcfs_rq, se, flags);
-
-		if (cfs_rq_is_idle(group_cfs_rq(se)))
-			idle_delta =3D cfs_rq->h_nr_queued;
-
-		qcfs_rq->h_nr_queued -=3D queued_delta;
-		qcfs_rq->h_nr_runnable -=3D runnable_delta;
-		qcfs_rq->h_nr_idle -=3D idle_delta;
-
-		if (qcfs_rq->load.weight) {
-			/* Avoid re-evaluating load for this entity: */
-			se =3D parent_entity(se);
-			break;
-		}
-	}
-
-	for_each_sched_entity(se) {
-		struct cfs_rq *qcfs_rq =3D cfs_rq_of(se);
-		/* throttled entity or throttle-on-deactivate */
-		if (!se->on_rq)
-			goto done;
-
-		update_load_avg(qcfs_rq, se, 0);
-		se_update_runnable(se);
-
-		if (cfs_rq_is_idle(group_cfs_rq(se)))
-			idle_delta =3D cfs_rq->h_nr_queued;
-
-		qcfs_rq->h_nr_queued -=3D queued_delta;
-		qcfs_rq->h_nr_runnable -=3D runnable_delta;
-		qcfs_rq->h_nr_idle -=3D idle_delta;
-	}
-
-	/* At this point se is NULL and we are at root level*/
-	sub_nr_running(rq, queued_delta);
-done:
 	/*
 	 * Note: distribution will already see us throttled via the
 	 * throttled-list.  rq->lock protects completion.
@@ -5976,9 +6033,20 @@ void unthrottle_cfs_rq(struct cfs_rq *cfs_rq)
 {
 	struct rq *rq =3D rq_of(cfs_rq);
 	struct cfs_bandwidth *cfs_b =3D tg_cfs_bandwidth(cfs_rq->tg);
-	struct sched_entity *se;
-	long queued_delta, runnable_delta, idle_delta;
-	long rq_h_nr_queued =3D rq->cfs.h_nr_queued;
+	struct sched_entity *se =3D cfs_rq->tg->se[cpu_of(rq)];
+
+	/*
+	 * It's possible we are called with !runtime_remaining due to things
+	 * like user changed quota setting(see tg_set_cfs_bandwidth()) or async
+	 * unthrottled us with a positive runtime_remaining but other still
+	 * running entities consumed those runtime before we reached here.
+	 *
+	 * Anyway, we can't unthrottle this cfs_rq without any runtime remaining
+	 * because any enqueue in tg_unthrottle_up() will immediately trigger a
+	 * throttle, which is not supposed to happen on unthrottle path.
+	 */
+	if (cfs_rq->runtime_enabled && cfs_rq->runtime_remaining <=3D 0)
+		return;
=20
 	se =3D cfs_rq->tg->se[cpu_of(rq)];
=20
@@ -6008,62 +6076,8 @@ void unthrottle_cfs_rq(struct cfs_rq *cfs_rq)
 			if (list_add_leaf_cfs_rq(cfs_rq_of(se)))
 				break;
 		}
-		goto unthrottle_throttle;
-	}
-
-	queued_delta =3D cfs_rq->h_nr_queued;
-	runnable_delta =3D cfs_rq->h_nr_runnable;
-	idle_delta =3D cfs_rq->h_nr_idle;
-	for_each_sched_entity(se) {
-		struct cfs_rq *qcfs_rq =3D cfs_rq_of(se);
-
-		/* Handle any unfinished DELAY_DEQUEUE business first. */
-		if (se->sched_delayed) {
-			int flags =3D DEQUEUE_SLEEP | DEQUEUE_DELAYED;
-
-			dequeue_entity(qcfs_rq, se, flags);
-		} else if (se->on_rq)
-			break;
-		enqueue_entity(qcfs_rq, se, ENQUEUE_WAKEUP);
-
-		if (cfs_rq_is_idle(group_cfs_rq(se)))
-			idle_delta =3D cfs_rq->h_nr_queued;
-
-		qcfs_rq->h_nr_queued +=3D queued_delta;
-		qcfs_rq->h_nr_runnable +=3D runnable_delta;
-		qcfs_rq->h_nr_idle +=3D idle_delta;
-
-		/* end evaluation on encountering a throttled cfs_rq */
-		if (cfs_rq_throttled(qcfs_rq))
-			goto unthrottle_throttle;
 	}
=20
-	for_each_sched_entity(se) {
-		struct cfs_rq *qcfs_rq =3D cfs_rq_of(se);
-
-		update_load_avg(qcfs_rq, se, UPDATE_TG);
-		se_update_runnable(se);
-
-		if (cfs_rq_is_idle(group_cfs_rq(se)))
-			idle_delta =3D cfs_rq->h_nr_queued;
-
-		qcfs_rq->h_nr_queued +=3D queued_delta;
-		qcfs_rq->h_nr_runnable +=3D runnable_delta;
-		qcfs_rq->h_nr_idle +=3D idle_delta;
-
-		/* end evaluation on encountering a throttled cfs_rq */
-		if (cfs_rq_throttled(qcfs_rq))
-			goto unthrottle_throttle;
-	}
-
-	/* Start the fair server if un-throttling resulted in new runnable tasks */
-	if (!rq_h_nr_queued && rq->cfs.h_nr_queued)
-		dl_server_start(&rq->fair_server);
-
-	/* At this point se is NULL and we are at root level*/
-	add_nr_running(rq, queued_delta);
-
-unthrottle_throttle:
 	assert_list_leaf_cfs_rq(rq);
=20
 	/* Determine whether we need to wake up potentially idle CPU: */
@@ -6717,6 +6731,8 @@ static inline void sync_throttle(struct task_group *tg,=
 int cpu) {}
 static __always_inline void return_cfs_rq_runtime(struct cfs_rq *cfs_rq) {}
 static void task_throttle_setup_work(struct task_struct *p) {}
 static bool task_is_throttled(struct task_struct *p) { return false; }
+static void dequeue_throttled_task(struct task_struct *p, int flags) {}
+static bool enqueue_throttled_task(struct task_struct *p) { return false; }
=20
 static inline int cfs_rq_throttled(struct cfs_rq *cfs_rq)
 {
@@ -6909,6 +6925,9 @@ enqueue_task_fair(struct rq *rq, struct task_struct *p,=
 int flags)
 	int rq_h_nr_queued =3D rq->cfs.h_nr_queued;
 	u64 slice =3D 0;
=20
+	if (task_is_throttled(p) && enqueue_throttled_task(p))
+		return;
+
 	/*
 	 * The code below (indirectly) updates schedutil which looks at
 	 * the cfs_rq utilization to select a frequency.
@@ -6961,10 +6980,6 @@ enqueue_task_fair(struct rq *rq, struct task_struct *p=
, int flags)
 		if (cfs_rq_is_idle(cfs_rq))
 			h_nr_idle =3D 1;
=20
-		/* end evaluation on encountering a throttled cfs_rq */
-		if (cfs_rq_throttled(cfs_rq))
-			goto enqueue_throttle;
-
 		flags =3D ENQUEUE_WAKEUP;
 	}
=20
@@ -6986,10 +7001,6 @@ enqueue_task_fair(struct rq *rq, struct task_struct *p=
, int flags)
=20
 		if (cfs_rq_is_idle(cfs_rq))
 			h_nr_idle =3D 1;
-
-		/* end evaluation on encountering a throttled cfs_rq */
-		if (cfs_rq_throttled(cfs_rq))
-			goto enqueue_throttle;
 	}
=20
 	if (!rq_h_nr_queued && rq->cfs.h_nr_queued) {
@@ -7019,7 +7030,6 @@ enqueue_task_fair(struct rq *rq, struct task_struct *p,=
 int flags)
 	if (!task_new)
 		check_update_overutilized_status(rq);
=20
-enqueue_throttle:
 	assert_list_leaf_cfs_rq(rq);
=20
 	hrtick_update(rq);
@@ -7074,10 +7084,6 @@ static int dequeue_entities(struct rq *rq, struct sche=
d_entity *se, int flags)
 		if (cfs_rq_is_idle(cfs_rq))
 			h_nr_idle =3D h_nr_queued;
=20
-		/* end evaluation on encountering a throttled cfs_rq */
-		if (cfs_rq_throttled(cfs_rq))
-			return 0;
-
 		/* Don't dequeue parent if it has other entities besides us */
 		if (cfs_rq->load.weight) {
 			slice =3D cfs_rq_min_slice(cfs_rq);
@@ -7114,10 +7120,6 @@ static int dequeue_entities(struct rq *rq, struct sche=
d_entity *se, int flags)
=20
 		if (cfs_rq_is_idle(cfs_rq))
 			h_nr_idle =3D h_nr_queued;
-
-		/* end evaluation on encountering a throttled cfs_rq */
-		if (cfs_rq_throttled(cfs_rq))
-			return 0;
 	}
=20
 	sub_nr_running(rq, h_nr_queued);
@@ -7151,6 +7153,11 @@ static int dequeue_entities(struct rq *rq, struct sche=
d_entity *se, int flags)
  */
 static bool dequeue_task_fair(struct rq *rq, struct task_struct *p, int flag=
s)
 {
+	if (task_is_throttled(p)) {
+		dequeue_throttled_task(p, flags);
+		return true;
+	}
+
 	if (!p->se.sched_delayed)
 		util_est_dequeue(&rq->cfs, p);
=20
@@ -8819,19 +8826,22 @@ static struct task_struct *pick_task_fair(struct rq *=
rq)
 {
 	struct sched_entity *se;
 	struct cfs_rq *cfs_rq;
+	struct task_struct *p;
+	bool throttled;
=20
 again:
 	cfs_rq =3D &rq->cfs;
 	if (!cfs_rq->nr_queued)
 		return NULL;
=20
+	throttled =3D false;
+
 	do {
 		/* Might not have done put_prev_entity() */
 		if (cfs_rq->curr && cfs_rq->curr->on_rq)
 			update_curr(cfs_rq);
=20
-		if (unlikely(check_cfs_rq_runtime(cfs_rq)))
-			goto again;
+		throttled |=3D check_cfs_rq_runtime(cfs_rq);
=20
 		se =3D pick_next_entity(rq, cfs_rq);
 		if (!se)
@@ -8839,7 +8849,10 @@ again:
 		cfs_rq =3D group_cfs_rq(se);
 	} while (cfs_rq);
=20
-	return task_of(se);
+	p =3D task_of(se);
+	if (unlikely(throttled))
+		task_throttle_setup_work(p);
+	return p;
 }
=20
 static void __set_next_task_fair(struct rq *rq, struct task_struct *p, bool =
first);
diff --git a/kernel/sched/pelt.h b/kernel/sched/pelt.h
index 62c3fa5..f921302 100644
--- a/kernel/sched/pelt.h
+++ b/kernel/sched/pelt.h
@@ -162,7 +162,7 @@ static inline void update_idle_cfs_rq_clock_pelt(struct c=
fs_rq *cfs_rq)
 {
 	u64 throttled;
=20
-	if (unlikely(cfs_rq->throttle_count))
+	if (unlikely(cfs_rq->pelt_clock_throttled))
 		throttled =3D U64_MAX;
 	else
 		throttled =3D cfs_rq->throttled_clock_pelt_time;
@@ -173,7 +173,7 @@ static inline void update_idle_cfs_rq_clock_pelt(struct c=
fs_rq *cfs_rq)
 /* rq->task_clock normalized against any time this cfs_rq has spent throttle=
d */
 static inline u64 cfs_rq_clock_pelt(struct cfs_rq *cfs_rq)
 {
-	if (unlikely(cfs_rq->throttle_count))
+	if (unlikely(cfs_rq->pelt_clock_throttled))
 		return cfs_rq->throttled_clock_pelt - cfs_rq->throttled_clock_pelt_time;
=20
 	return rq_clock_pelt(rq_of(cfs_rq)) - cfs_rq->throttled_clock_pelt_time;
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index a6493d2..6e1b37b 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -735,7 +735,8 @@ struct cfs_rq {
 	u64			throttled_clock_pelt_time;
 	u64			throttled_clock_self;
 	u64			throttled_clock_self_time;
-	int			throttled;
+	bool			throttled:1;
+	bool			pelt_clock_throttled:1;
 	int			throttle_count;
 	struct list_head	throttled_list;
 	struct list_head	throttled_csd_list;

