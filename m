Return-Path: <linux-tip-commits+bounces-7730-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E635CCC706A
	for <lists+linux-tip-commits@lfdr.de>; Wed, 17 Dec 2025 11:17:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 79C7230FFE9B
	for <lists+linux-tip-commits@lfdr.de>; Wed, 17 Dec 2025 10:11:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DE9433D6FA;
	Wed, 17 Dec 2025 10:03:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="bxtmJbuV";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="UZVvR+xk"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCB5129A322;
	Wed, 17 Dec 2025 10:03:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765965787; cv=none; b=KsfjqYk9TqDDmpcXZmdLqg4KjyX4DSZF5W4u/XwSLnulo5Fw8Vjl/HLA4AbjQux7VrmvW9VIomzVqxanGgtu4PbzLaEsO5h/NgKoTJ+2Mshhw8bnvL56xdfsP/6GX0PZJWy1yrOiFjUrIdsTAmRMM2WxjVmtocfY1u8Mw0m/i0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765965787; c=relaxed/simple;
	bh=Hl5FSBq762VqBE6p9uzQ5T3vJTJFfJ/diMlva1R05DI=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=XdlgO0pkxt/JMvVBdFCQIlJAuMkSu5xdE6UK1fO/dNjvIpM4RhjkVfgvUx/cD+tf2KQFWJCa2nYUlsCZRtdFsgueyVXNcmgFEBUitiVx7BEfjN0LXoexPRrAkn9TYoHjn6QtMgN4adU5uq7KW1RJWfh9MI+4MPpFzzpnTNfWnFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=bxtmJbuV; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=UZVvR+xk; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 17 Dec 2025 10:02:55 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1765965776;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vkIWol6zpAB6cTVh3VrMUospMpnVopveBmUwsxLqRmA=;
	b=bxtmJbuVAGg/DAOrFrdtHqhzHYq1ez3CUotjapGhaRiQwafh1rVhnCBB8OkuvTzzZCMmCo
	IFNJ8jY5pEL3msJoNYQr5kkfRGJjsivau6fRuednP6E/FbwYwwkeHtHK92fY7XhD4FMVpd
	aika8BTbi6ObHeuBOsB0L0iUVQ/TD+2W0/4idFOSHkW1xINNnsOSDJWIj8DtuxtNdIN28H
	ryVVSD6l6YZ3v4pWng5t7lqVqzYNlCKg7wpvq4xxHdNI8NAT+EDLF97SpeKxssx/iJmBj9
	SYwtM8CUti9UCKLivhv2IIelJmEJikUNMrys8uu3r9Qe0hlxOZGQb4MDlsLMAA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1765965776;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vkIWol6zpAB6cTVh3VrMUospMpnVopveBmUwsxLqRmA=;
	b=UZVvR+xkW4mpfLGpMALqjF5Lp+Qtcq+L7EcRWDnin7IusPmVhDrL5On/US5PatV9IqfwQz
	MYiBz0mZEERAoCAg==
From: "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/core: Rework sched_class::wakeup_preempt()
 and rq_modified_*()
Cc: "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Ingo Molnar <mingo@kernel.org>, x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20251127154725.901391274@infradead.org>
References: <20251127154725.901391274@infradead.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176596577520.510.1359093287731832331.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     704069649b5bfb7bf1fe32c0281fe9036806a59a
Gitweb:        https://git.kernel.org/tip/704069649b5bfb7bf1fe32c0281fe903680=
6a59a
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Wed, 10 Dec 2025 09:06:50 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 17 Dec 2025 10:53:25 +01:00

sched/core: Rework sched_class::wakeup_preempt() and rq_modified_*()

Change sched_class::wakeup_preempt() to also get called for
cross-class wakeups, specifically those where the woken task
is of a higher class than the previous highest class.

In order to do this, track the current highest class of the runqueue
in rq::next_class and have wakeup_preempt() track this upwards for
each new wakeup. Additionally have schedule() re-set the value on
pick.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://patch.msgid.link/20251127154725.901391274@infradead.org
---
 kernel/sched/core.c      | 32 +++++++++++++++++++++++---------
 kernel/sched/deadline.c  | 14 +++++++++-----
 kernel/sched/ext.c       |  9 ++++-----
 kernel/sched/fair.c      | 17 ++++++++++-------
 kernel/sched/idle.c      |  3 ---
 kernel/sched/rt.c        |  9 ++++++---
 kernel/sched/sched.h     | 27 ++-------------------------
 kernel/sched/stop_task.c |  3 ---
 8 files changed, 54 insertions(+), 60 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 4479f7d..7d0a862 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -2090,7 +2090,6 @@ void enqueue_task(struct rq *rq, struct task_struct *p,=
 int flags)
 	 */
 	uclamp_rq_inc(rq, p, flags);
=20
-	rq->queue_mask |=3D p->sched_class->queue_mask;
 	p->sched_class->enqueue_task(rq, p, flags);
=20
 	psi_enqueue(p, flags);
@@ -2123,7 +2122,6 @@ inline bool dequeue_task(struct rq *rq, struct task_str=
uct *p, int flags)
 	 * and mark the task ->sched_delayed.
 	 */
 	uclamp_rq_dec(rq, p);
-	rq->queue_mask |=3D p->sched_class->queue_mask;
 	return p->sched_class->dequeue_task(rq, p, flags);
 }
=20
@@ -2174,10 +2172,14 @@ void wakeup_preempt(struct rq *rq, struct task_struct=
 *p, int flags)
 {
 	struct task_struct *donor =3D rq->donor;
=20
-	if (p->sched_class =3D=3D donor->sched_class)
-		donor->sched_class->wakeup_preempt(rq, p, flags);
-	else if (sched_class_above(p->sched_class, donor->sched_class))
+	if (p->sched_class =3D=3D rq->next_class) {
+		rq->next_class->wakeup_preempt(rq, p, flags);
+
+	} else if (sched_class_above(p->sched_class, rq->next_class)) {
+		rq->next_class->wakeup_preempt(rq, p, flags);
 		resched_curr(rq);
+		rq->next_class =3D p->sched_class;
+	}
=20
 	/*
 	 * A queue event has occurred, and we're going to schedule.  In
@@ -6804,6 +6806,7 @@ static void __sched notrace __schedule(int sched_mode)
 pick_again:
 	next =3D pick_next_task(rq, rq->donor, &rf);
 	rq_set_donor(rq, next);
+	rq->next_class =3D next->sched_class;
 	if (unlikely(task_is_blocked(next))) {
 		next =3D find_proxy_task(rq, next, &rf);
 		if (!next)
@@ -8650,6 +8653,8 @@ void __init sched_init(void)
 		rq->rt.rt_runtime =3D global_rt_runtime();
 		init_tg_rt_entry(&root_task_group, &rq->rt, NULL, i, NULL);
 #endif
+		rq->next_class =3D &idle_sched_class;
+
 		rq->sd =3D NULL;
 		rq->rd =3D NULL;
 		rq->cpu_capacity =3D SCHED_CAPACITY_SCALE;
@@ -10775,10 +10780,8 @@ struct sched_change_ctx *sched_change_begin(struct t=
ask_struct *p, unsigned int=20
 		flags |=3D DEQUEUE_NOCLOCK;
 	}
=20
-	if (flags & DEQUEUE_CLASS) {
-		if (p->sched_class->switching_from)
-			p->sched_class->switching_from(rq, p);
-	}
+	if ((flags & DEQUEUE_CLASS) && p->sched_class->switching_from)
+		p->sched_class->switching_from(rq, p);
=20
 	*ctx =3D (struct sched_change_ctx){
 		.p =3D p,
@@ -10831,6 +10834,17 @@ void sched_change_end(struct sched_change_ctx *ctx)
 			p->sched_class->switched_to(rq, p);
=20
 		/*
+		 * If this was a class promotion; let the old class know it
+		 * got preempted. Note that none of the switch*_from() methods
+		 * know the new class and none of the switch*_to() methods
+		 * know the old class.
+		 */
+		if (ctx->running && sched_class_above(p->sched_class, ctx->class)) {
+			rq->next_class->wakeup_preempt(rq, p, 0);
+			rq->next_class =3D p->sched_class;
+		}
+
+		/*
 		 * If this was a degradation in class someone should have set
 		 * need_resched by now.
 		 */
diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index 319439f..80c9559 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -2499,9 +2499,16 @@ static int balance_dl(struct rq *rq, struct task_struc=
t *p, struct rq_flags *rf)
  * Only called when both the current and waking task are -deadline
  * tasks.
  */
-static void wakeup_preempt_dl(struct rq *rq, struct task_struct *p,
-				  int flags)
+static void wakeup_preempt_dl(struct rq *rq, struct task_struct *p, int flag=
s)
 {
+	/*
+	 * Can only get preempted by stop-class, and those should be
+	 * few and short lived, doesn't really make sense to push
+	 * anything away for that.
+	 */
+	if (p->sched_class !=3D &dl_sched_class)
+		return;
+
 	if (dl_entity_preempt(&p->dl, &rq->donor->dl)) {
 		resched_curr(rq);
 		return;
@@ -3346,9 +3353,6 @@ static int task_is_throttled_dl(struct task_struct *p, =
int cpu)
 #endif
=20
 DEFINE_SCHED_CLASS(dl) =3D {
-
-	.queue_mask		=3D 8,
-
 	.enqueue_task		=3D enqueue_task_dl,
 	.dequeue_task		=3D dequeue_task_dl,
 	.yield_task		=3D yield_task_dl,
diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index 05f5a49..3b32e64 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -2431,7 +2431,7 @@ do_pick_task_scx(struct rq *rq, struct rq_flags *rf, bo=
ol force_scx)
 	/* see kick_cpus_irq_workfn() */
 	smp_store_release(&rq->scx.kick_sync, rq->scx.kick_sync + 1);
=20
-	rq_modified_clear(rq);
+	rq->next_class =3D &ext_sched_class;
=20
 	rq_unpin_lock(rq, rf);
 	balance_one(rq, prev);
@@ -2446,7 +2446,7 @@ do_pick_task_scx(struct rq *rq, struct rq_flags *rf, bo=
ol force_scx)
 	 * If @force_scx is true, always try to pick a SCHED_EXT task,
 	 * regardless of any higher-priority sched classes activity.
 	 */
-	if (!force_scx && rq_modified_above(rq, &ext_sched_class))
+	if (!force_scx && sched_class_above(rq->next_class, &ext_sched_class))
 		return RETRY_TASK;
=20
 	keep_prev =3D rq->scx.flags & SCX_RQ_BAL_KEEP;
@@ -3075,7 +3075,8 @@ static void switched_from_scx(struct rq *rq, struct tas=
k_struct *p)
 	scx_disable_task(p);
 }
=20
-static void wakeup_preempt_scx(struct rq *rq, struct task_struct *p,int wake=
_flags) {}
+static void wakeup_preempt_scx(struct rq *rq, struct task_struct *p, int wak=
e_flags) {}
+
 static void switched_to_scx(struct rq *rq, struct task_struct *p) {}
=20
 int scx_check_setscheduler(struct task_struct *p, int policy)
@@ -3336,8 +3337,6 @@ static void scx_cgroup_unlock(void) {}
  *   their current sched_class. Call them directly from sched core instead.
  */
 DEFINE_SCHED_CLASS(ext) =3D {
-	.queue_mask		=3D 1,
-
 	.enqueue_task		=3D enqueue_task_scx,
 	.dequeue_task		=3D dequeue_task_scx,
 	.yield_task		=3D yield_task_scx,
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index d588eb8..76f5e4b 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -8736,7 +8736,7 @@ preempt_sync(struct rq *rq, int wake_flags,
 /*
  * Preempt the current task with a newly woken task if needed:
  */
-static void check_preempt_wakeup_fair(struct rq *rq, struct task_struct *p, =
int wake_flags)
+static void wakeup_preempt_fair(struct rq *rq, struct task_struct *p, int wa=
ke_flags)
 {
 	enum preempt_wakeup_action preempt_action =3D PREEMPT_WAKEUP_PICK;
 	struct task_struct *donor =3D rq->donor;
@@ -8744,6 +8744,12 @@ static void check_preempt_wakeup_fair(struct rq *rq, s=
truct task_struct *p, int=20
 	struct cfs_rq *cfs_rq =3D task_cfs_rq(donor);
 	int cse_is_idle, pse_is_idle;
=20
+	/*
+	 * XXX Getting preempted by higher class, try and find idle CPU?
+	 */
+	if (p->sched_class !=3D &fair_sched_class)
+		return;
+
 	if (unlikely(se =3D=3D pse))
 		return;
=20
@@ -12911,7 +12917,7 @@ static int sched_balance_newidle(struct rq *this_rq, =
struct rq_flags *rf)
 	t0 =3D sched_clock_cpu(this_cpu);
 	__sched_balance_update_blocked_averages(this_rq);
=20
-	rq_modified_clear(this_rq);
+	this_rq->next_class =3D &fair_sched_class;
 	raw_spin_rq_unlock(this_rq);
=20
 	for_each_domain(this_cpu, sd) {
@@ -12978,7 +12984,7 @@ static int sched_balance_newidle(struct rq *this_rq, =
struct rq_flags *rf)
 		pulled_task =3D 1;
=20
 	/* If a higher prio class was modified, restart the pick */
-	if (rq_modified_above(this_rq, &fair_sched_class))
+	if (sched_class_above(this_rq->next_class, &fair_sched_class))
 		pulled_task =3D -1;
=20
 out:
@@ -13882,15 +13888,12 @@ static unsigned int get_rr_interval_fair(struct rq =
*rq, struct task_struct *task
  * All the scheduling class methods:
  */
 DEFINE_SCHED_CLASS(fair) =3D {
-
-	.queue_mask		=3D 2,
-
 	.enqueue_task		=3D enqueue_task_fair,
 	.dequeue_task		=3D dequeue_task_fair,
 	.yield_task		=3D yield_task_fair,
 	.yield_to_task		=3D yield_to_task_fair,
=20
-	.wakeup_preempt		=3D check_preempt_wakeup_fair,
+	.wakeup_preempt		=3D wakeup_preempt_fair,
=20
 	.pick_task		=3D pick_task_fair,
 	.pick_next_task		=3D pick_next_task_fair,
diff --git a/kernel/sched/idle.c b/kernel/sched/idle.c
index c174afe..65eb8f8 100644
--- a/kernel/sched/idle.c
+++ b/kernel/sched/idle.c
@@ -536,9 +536,6 @@ static void update_curr_idle(struct rq *rq)
  * Simple, special scheduling class for the per-CPU idle tasks:
  */
 DEFINE_SCHED_CLASS(idle) =3D {
-
-	.queue_mask		=3D 0,
-
 	/* no enqueue/yield_task for idle tasks */
=20
 	/* dequeue is not valid, we print a debug message there: */
diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
index f1867fe..0a9b2cd 100644
--- a/kernel/sched/rt.c
+++ b/kernel/sched/rt.c
@@ -1615,6 +1615,12 @@ static void wakeup_preempt_rt(struct rq *rq, struct ta=
sk_struct *p, int flags)
 {
 	struct task_struct *donor =3D rq->donor;
=20
+	/*
+	 * XXX If we're preempted by DL, queue a push?
+	 */
+	if (p->sched_class !=3D &rt_sched_class)
+		return;
+
 	if (p->prio < donor->prio) {
 		resched_curr(rq);
 		return;
@@ -2568,9 +2574,6 @@ static int task_is_throttled_rt(struct task_struct *p, =
int cpu)
 #endif /* CONFIG_SCHED_CORE */
=20
 DEFINE_SCHED_CLASS(rt) =3D {
-
-	.queue_mask		=3D 4,
-
 	.enqueue_task		=3D enqueue_task_rt,
 	.dequeue_task		=3D dequeue_task_rt,
 	.yield_task		=3D yield_task_rt,
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index ab1bfa0..3ceaa9d 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -1118,8 +1118,6 @@ struct rq {
 	/* runqueue lock: */
 	raw_spinlock_t		__lock;
=20
-	/* Per class runqueue modification mask; bits in class order. */
-	unsigned int		queue_mask;
 	unsigned int		nr_running;
 #ifdef CONFIG_NUMA_BALANCING
 	unsigned int		nr_numa_running;
@@ -1179,6 +1177,7 @@ struct rq {
 	struct sched_dl_entity	*dl_server;
 	struct task_struct	*idle;
 	struct task_struct	*stop;
+	const struct sched_class *next_class;
 	unsigned long		next_balance;
 	struct mm_struct	*prev_mm;
=20
@@ -2426,15 +2425,6 @@ struct sched_class {
 #ifdef CONFIG_UCLAMP_TASK
 	int uclamp_enabled;
 #endif
-	/*
-	 * idle:  0
-	 * ext:   1
-	 * fair:  2
-	 * rt:    4
-	 * dl:    8
-	 * stop: 16
-	 */
-	unsigned int queue_mask;
=20
 	/*
 	 * move_queued_task/activate_task/enqueue_task: rq->lock
@@ -2593,20 +2583,6 @@ struct sched_class {
 #endif
 };
=20
-/*
- * Does not nest; only used around sched_class::pick_task() rq-lock-breaks.
- */
-static inline void rq_modified_clear(struct rq *rq)
-{
-	rq->queue_mask =3D 0;
-}
-
-static inline bool rq_modified_above(struct rq *rq, const struct sched_class=
 * class)
-{
-	unsigned int mask =3D class->queue_mask;
-	return rq->queue_mask & ~((mask << 1) - 1);
-}
-
 static inline void put_prev_task(struct rq *rq, struct task_struct *prev)
 {
 	WARN_ON_ONCE(rq->donor !=3D prev);
@@ -3899,6 +3875,7 @@ void move_queued_task_locked(struct rq *src_rq, struct =
rq *dst_rq, struct task_s
 	deactivate_task(src_rq, task, 0);
 	set_task_cpu(task, dst_rq->cpu);
 	activate_task(dst_rq, task, 0);
+	wakeup_preempt(dst_rq, task, 0);
 }
=20
 static inline
diff --git a/kernel/sched/stop_task.c b/kernel/sched/stop_task.c
index 4f9192b..f95798b 100644
--- a/kernel/sched/stop_task.c
+++ b/kernel/sched/stop_task.c
@@ -97,9 +97,6 @@ static void update_curr_stop(struct rq *rq)
  * Simple, special scheduling class for the per-CPU stop tasks:
  */
 DEFINE_SCHED_CLASS(stop) =3D {
-
-	.queue_mask		=3D 16,
-
 	.enqueue_task		=3D enqueue_task_stop,
 	.dequeue_task		=3D dequeue_task_stop,
 	.yield_task		=3D yield_task_stop,

