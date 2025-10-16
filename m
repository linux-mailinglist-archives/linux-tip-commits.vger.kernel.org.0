Return-Path: <linux-tip-commits+bounces-6843-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 49EB5BE26EC
	for <lists+linux-tip-commits@lfdr.de>; Thu, 16 Oct 2025 11:37:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1B59E4FFED7
	for <lists+linux-tip-commits@lfdr.de>; Thu, 16 Oct 2025 09:36:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E874E320CD8;
	Thu, 16 Oct 2025 09:33:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Ijn6HI5l";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="OciC6h4I"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7291A320CA0;
	Thu, 16 Oct 2025 09:33:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760607225; cv=none; b=hLtC7QfCFxYaoPfAFHWZWRwSv1WA0uB62LJRG0gWgtECy88IaoMvj47qgGeVeeOarzQmqlZnCx+54CQwuW7GNh1hJqFzPw6NVjCddEzbJriswzQRUZciK7bNDgMW3yxl8gglWlbs1SKyEZ4utc2Doig9VqsUl8IMDPCVymPF9So=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760607225; c=relaxed/simple;
	bh=ueOM/HjwS7nWNG+nGU67VqLfdq8w5iAyuzKb8/LDJH0=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=XSQshQHP793gB7wE94qV5153hgRJC+83a84t/UisuZVH235seY7wh7LVb1mWzz3lS5IYScfPeuscdoyjsIh7QFwfr0snKAkwayVXMDIqOSw1TqR8DGGZXXzjC8lXRes00Er+txOXIw4wSWmlLaY4uyyPrBNhPh/DNxG92CujSeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Ijn6HI5l; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=OciC6h4I; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 16 Oct 2025 09:33:40 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1760607222;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YEHoEeZmDY/TZxfPXUNI8C5QGub0DnCIRodNf9ZROU0=;
	b=Ijn6HI5liTkaBVSRdp3JZensVPcrjKdMb2/k7qQazlzOzyFzg2mnT+opkBo9cWsSE+Q5Aa
	OU0ZyZ/WGEYUVXL2n+2P7JKCwcEVW1VoDkXzTa0nU1BDbtGmqMvye/EFzbe9btz+Y+8Rxl
	sk5KI8MLu2t7aOjZxt+PtJMey/Kot63Ih2YiNvyi8WnCbV7/3iVSrYuQG1OQJjD4B2ktP9
	BANeAWBFHye5rqo5d8ye8JJVteU7dLV5ebrn3tllzNnWep31cLXJw4zZyPP/ZI8VE4q0JJ
	jo2kqe2/umh5GwqN8H3mVXQcrMbcD/fkuTcOUfzvUQ0N+ZThFrwCZdtNYNbgDQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1760607222;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YEHoEeZmDY/TZxfPXUNI8C5QGub0DnCIRodNf9ZROU0=;
	b=OciC6h4Io2OfIYM4u3WBQ9s2+Vl5Wv8ql7Svxg8fjzCsZ8JEREyQH8OvtKNx3KSKvQYWO0
	diLHHxWWBUBttzBQ==
From: "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched: Employ sched_change guards
Cc: "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Juri Lelli <juri.lelli@redhat.com>, Tejun Heo <tj@kernel.org>,
 Vincent Guittot <vincent.guittot@linaro.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20251006104526.613879143@infradead.org>
References: <20251006104526.613879143@infradead.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176060722063.709179.6120435537198225166.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     e9139f765ac7048cadc9981e962acdf8b08eabf3
Gitweb:        https://git.kernel.org/tip/e9139f765ac7048cadc9981e962acdf8b08=
eabf3
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Wed, 30 Oct 2024 13:43:43 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Thu, 16 Oct 2025 11:13:50 +02:00

sched: Employ sched_change guards

As proposed a long while ago -- and half done by scx -- wrap the
scheduler's 'change' pattern in a guard helper.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Juri Lelli <juri.lelli@redhat.com>
Acked-by: Tejun Heo <tj@kernel.org>
Acked-by: Vincent Guittot <vincent.guittot@linaro.org>
---
 include/linux/cleanup.h |   5 +-
 kernel/sched/core.c     | 159 ++++++++++++++-------------------------
 kernel/sched/ext.c      |  39 ++++------
 kernel/sched/sched.h    |  33 +++++---
 kernel/sched/syscalls.c |  65 +++++-----------
 5 files changed, 131 insertions(+), 170 deletions(-)

diff --git a/include/linux/cleanup.h b/include/linux/cleanup.h
index 2573585..ae38167 100644
--- a/include/linux/cleanup.h
+++ b/include/linux/cleanup.h
@@ -340,6 +340,11 @@ _label:                                                 =
        \
 #define __DEFINE_CLASS_IS_CONDITIONAL(_name, _is_cond)	\
 static __maybe_unused const bool class_##_name##_is_conditional =3D _is_cond
=20
+#define DEFINE_CLASS_IS_UNCONDITIONAL(_name)		\
+	__DEFINE_CLASS_IS_CONDITIONAL(_name, false);	\
+	static inline void * class_##_name##_lock_ptr(class_##_name##_t *_T) \
+	{ return (void *)1; }
+
 #define __GUARD_IS_ERR(_ptr)                                       \
 	({                                                         \
 		unsigned long _rc =3D (__force unsigned long)(_ptr); \
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 198d2dd..eca40df 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -7326,7 +7326,7 @@ void rt_mutex_post_schedule(void)
  */
 void rt_mutex_setprio(struct task_struct *p, struct task_struct *pi_task)
 {
-	int prio, oldprio, queued, running, queue_flag =3D
+	int prio, oldprio, queue_flag =3D
 		DEQUEUE_SAVE | DEQUEUE_MOVE | DEQUEUE_NOCLOCK;
 	const struct sched_class *prev_class, *next_class;
 	struct rq_flags rf;
@@ -7391,52 +7391,42 @@ void rt_mutex_setprio(struct task_struct *p, struct t=
ask_struct *pi_task)
 	if (prev_class !=3D next_class && p->se.sched_delayed)
 		dequeue_task(rq, p, DEQUEUE_SLEEP | DEQUEUE_DELAYED | DEQUEUE_NOCLOCK);
=20
-	queued =3D task_on_rq_queued(p);
-	running =3D task_current_donor(rq, p);
-	if (queued)
-		dequeue_task(rq, p, queue_flag);
-	if (running)
-		put_prev_task(rq, p);
-
-	/*
-	 * Boosting condition are:
-	 * 1. -rt task is running and holds mutex A
-	 *      --> -dl task blocks on mutex A
-	 *
-	 * 2. -dl task is running and holds mutex A
-	 *      --> -dl task blocks on mutex A and could preempt the
-	 *          running task
-	 */
-	if (dl_prio(prio)) {
-		if (!dl_prio(p->normal_prio) ||
-		    (pi_task && dl_prio(pi_task->prio) &&
-		     dl_entity_preempt(&pi_task->dl, &p->dl))) {
-			p->dl.pi_se =3D pi_task->dl.pi_se;
-			queue_flag |=3D ENQUEUE_REPLENISH;
+	scoped_guard (sched_change, p, queue_flag) {
+		/*
+		 * Boosting condition are:
+		 * 1. -rt task is running and holds mutex A
+		 *      --> -dl task blocks on mutex A
+		 *
+		 * 2. -dl task is running and holds mutex A
+		 *      --> -dl task blocks on mutex A and could preempt the
+		 *          running task
+		 */
+		if (dl_prio(prio)) {
+			if (!dl_prio(p->normal_prio) ||
+			    (pi_task && dl_prio(pi_task->prio) &&
+			     dl_entity_preempt(&pi_task->dl, &p->dl))) {
+				p->dl.pi_se =3D pi_task->dl.pi_se;
+				scope->flags |=3D ENQUEUE_REPLENISH;
+			} else {
+				p->dl.pi_se =3D &p->dl;
+			}
+		} else if (rt_prio(prio)) {
+			if (dl_prio(oldprio))
+				p->dl.pi_se =3D &p->dl;
+			if (oldprio < prio)
+				scope->flags |=3D ENQUEUE_HEAD;
 		} else {
-			p->dl.pi_se =3D &p->dl;
+			if (dl_prio(oldprio))
+				p->dl.pi_se =3D &p->dl;
+			if (rt_prio(oldprio))
+				p->rt.timeout =3D 0;
 		}
-	} else if (rt_prio(prio)) {
-		if (dl_prio(oldprio))
-			p->dl.pi_se =3D &p->dl;
-		if (oldprio < prio)
-			queue_flag |=3D ENQUEUE_HEAD;
-	} else {
-		if (dl_prio(oldprio))
-			p->dl.pi_se =3D &p->dl;
-		if (rt_prio(oldprio))
-			p->rt.timeout =3D 0;
-	}
=20
-	p->sched_class =3D next_class;
-	p->prio =3D prio;
+		p->sched_class =3D next_class;
+		p->prio =3D prio;
=20
-	check_class_changing(rq, p, prev_class);
-
-	if (queued)
-		enqueue_task(rq, p, queue_flag);
-	if (running)
-		set_next_task(rq, p);
+		check_class_changing(rq, p, prev_class);
+	}
=20
 	check_class_changed(rq, p, prev_class, oldprio);
 out_unlock:
@@ -8084,26 +8074,9 @@ int migrate_task_to(struct task_struct *p, int target_=
cpu)
  */
 void sched_setnuma(struct task_struct *p, int nid)
 {
-	bool queued, running;
-	struct rq_flags rf;
-	struct rq *rq;
-
-	rq =3D task_rq_lock(p, &rf);
-	queued =3D task_on_rq_queued(p);
-	running =3D task_current_donor(rq, p);
-
-	if (queued)
-		dequeue_task(rq, p, DEQUEUE_SAVE);
-	if (running)
-		put_prev_task(rq, p);
-
-	p->numa_preferred_nid =3D nid;
-
-	if (queued)
-		enqueue_task(rq, p, ENQUEUE_RESTORE | ENQUEUE_NOCLOCK);
-	if (running)
-		set_next_task(rq, p);
-	task_rq_unlock(rq, p, &rf);
+	guard(task_rq_lock)(p);
+	scoped_guard (sched_change, p, DEQUEUE_SAVE)
+		p->numa_preferred_nid =3D nid;
 }
 #endif /* CONFIG_NUMA_BALANCING */
=20
@@ -9205,8 +9178,9 @@ static void sched_change_group(struct task_struct *tsk)
  */
 void sched_move_task(struct task_struct *tsk, bool for_autogroup)
 {
-	int queued, running, queue_flags =3D
+	unsigned int queue_flags =3D
 		DEQUEUE_SAVE | DEQUEUE_MOVE | DEQUEUE_NOCLOCK;
+	bool resched =3D false;
 	struct rq *rq;
=20
 	CLASS(task_rq_lock, rq_guard)(tsk);
@@ -9214,29 +9188,16 @@ void sched_move_task(struct task_struct *tsk, bool fo=
r_autogroup)
=20
 	update_rq_clock(rq);
=20
-	running =3D task_current_donor(rq, tsk);
-	queued =3D task_on_rq_queued(tsk);
-
-	if (queued)
-		dequeue_task(rq, tsk, queue_flags);
-	if (running)
-		put_prev_task(rq, tsk);
-
-	sched_change_group(tsk);
-	if (!for_autogroup)
-		scx_cgroup_move_task(tsk);
+	scoped_guard (sched_change, tsk, queue_flags) {
+		sched_change_group(tsk);
+		if (!for_autogroup)
+			scx_cgroup_move_task(tsk);
+		if (scope->running)
+			resched =3D true;
+	}
=20
-	if (queued)
-		enqueue_task(rq, tsk, queue_flags);
-	if (running) {
-		set_next_task(rq, tsk);
-		/*
-		 * After changing group, the running task may have joined a
-		 * throttled one but it's still the running task. Trigger a
-		 * resched to make sure that task can still run.
-		 */
+	if (resched)
 		resched_curr(rq);
-	}
 }
=20
 static struct cgroup_subsys_state *
@@ -10892,37 +10853,39 @@ void sched_mm_cid_fork(struct task_struct *t)
 }
 #endif /* CONFIG_SCHED_MM_CID */
=20
-#ifdef CONFIG_SCHED_CLASS_EXT
-void sched_deq_and_put_task(struct task_struct *p, int queue_flags,
-			    struct sched_enq_and_set_ctx *ctx)
+static DEFINE_PER_CPU(struct sched_change_ctx, sched_change_ctx);
+
+struct sched_change_ctx *sched_change_begin(struct task_struct *p, unsigned =
int flags)
 {
+	struct sched_change_ctx *ctx =3D this_cpu_ptr(&sched_change_ctx);
 	struct rq *rq =3D task_rq(p);
=20
 	lockdep_assert_rq_held(rq);
=20
-	*ctx =3D (struct sched_enq_and_set_ctx){
+	*ctx =3D (struct sched_change_ctx){
 		.p =3D p,
-		.queue_flags =3D queue_flags,
+		.flags =3D flags,
 		.queued =3D task_on_rq_queued(p),
-		.running =3D task_current(rq, p),
+		.running =3D task_current_donor(rq, p),
 	};
=20
-	update_rq_clock(rq);
 	if (ctx->queued)
-		dequeue_task(rq, p, queue_flags | DEQUEUE_NOCLOCK);
+		dequeue_task(rq, p, flags);
 	if (ctx->running)
 		put_prev_task(rq, p);
+
+	return ctx;
 }
=20
-void sched_enq_and_set_task(struct sched_enq_and_set_ctx *ctx)
+void sched_change_end(struct sched_change_ctx *ctx)
 {
-	struct rq *rq =3D task_rq(ctx->p);
+	struct task_struct *p =3D ctx->p;
+	struct rq *rq =3D task_rq(p);
=20
 	lockdep_assert_rq_held(rq);
=20
 	if (ctx->queued)
-		enqueue_task(rq, ctx->p, ctx->queue_flags | ENQUEUE_NOCLOCK);
+		enqueue_task(rq, p, ctx->flags | ENQUEUE_NOCLOCK);
 	if (ctx->running)
-		set_next_task(rq, ctx->p);
+		set_next_task(rq, p);
 }
-#endif /* CONFIG_SCHED_CLASS_EXT */
diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index 2b0e882..4566a7c 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -3780,11 +3780,10 @@ static void scx_bypass(bool bypass)
 		 */
 		list_for_each_entry_safe_reverse(p, n, &rq->scx.runnable_list,
 						 scx.runnable_node) {
-			struct sched_enq_and_set_ctx ctx;
-
 			/* cycling deq/enq is enough, see the function comment */
-			sched_deq_and_put_task(p, DEQUEUE_SAVE | DEQUEUE_MOVE, &ctx);
-			sched_enq_and_set_task(&ctx);
+			scoped_guard (sched_change, p, DEQUEUE_SAVE | DEQUEUE_MOVE) {
+				/* nothing */ ;
+			}
 		}
=20
 		/* resched to restore ticks and idle state */
@@ -3916,17 +3915,16 @@ static void scx_disable_workfn(struct kthread_work *w=
ork)
 		const struct sched_class *old_class =3D p->sched_class;
 		const struct sched_class *new_class =3D
 			__setscheduler_class(p->policy, p->prio);
-		struct sched_enq_and_set_ctx ctx;
=20
-		if (old_class !=3D new_class && p->se.sched_delayed)
-			dequeue_task(task_rq(p), p, DEQUEUE_SLEEP | DEQUEUE_DELAYED);
+		update_rq_clock(task_rq(p));
=20
-		sched_deq_and_put_task(p, DEQUEUE_SAVE | DEQUEUE_MOVE, &ctx);
-
-		p->sched_class =3D new_class;
-		check_class_changing(task_rq(p), p, old_class);
+		if (old_class !=3D new_class && p->se.sched_delayed)
+			dequeue_task(task_rq(p), p, DEQUEUE_SLEEP | DEQUEUE_DELAYED | DEQUEUE_NOC=
LOCK);
=20
-		sched_enq_and_set_task(&ctx);
+		scoped_guard (sched_change, p, DEQUEUE_SAVE | DEQUEUE_MOVE | DEQUEUE_NOCLO=
CK) {
+			p->sched_class =3D new_class;
+			check_class_changing(task_rq(p), p, old_class);
+		}
=20
 		check_class_changed(task_rq(p), p, old_class, p->prio);
 		scx_exit_task(p);
@@ -4660,21 +4658,20 @@ static int scx_enable(struct sched_ext_ops *ops, stru=
ct bpf_link *link)
 		const struct sched_class *old_class =3D p->sched_class;
 		const struct sched_class *new_class =3D
 			__setscheduler_class(p->policy, p->prio);
-		struct sched_enq_and_set_ctx ctx;
=20
 		if (!tryget_task_struct(p))
 			continue;
=20
-		if (old_class !=3D new_class && p->se.sched_delayed)
-			dequeue_task(task_rq(p), p, DEQUEUE_SLEEP | DEQUEUE_DELAYED);
-
-		sched_deq_and_put_task(p, DEQUEUE_SAVE | DEQUEUE_MOVE, &ctx);
+		update_rq_clock(task_rq(p));
=20
-		p->scx.slice =3D SCX_SLICE_DFL;
-		p->sched_class =3D new_class;
-		check_class_changing(task_rq(p), p, old_class);
+		if (old_class !=3D new_class && p->se.sched_delayed)
+			dequeue_task(task_rq(p), p, DEQUEUE_SLEEP | DEQUEUE_DELAYED | DEQUEUE_NOC=
LOCK);
=20
-		sched_enq_and_set_task(&ctx);
+		scoped_guard (sched_change, p, DEQUEUE_SAVE | DEQUEUE_MOVE | DEQUEUE_NOCLO=
CK) {
+			p->scx.slice =3D SCX_SLICE_DFL;
+			p->sched_class =3D new_class;
+			check_class_changing(task_rq(p), p, old_class);
+		}
=20
 		check_class_changed(task_rq(p), p, old_class, p->prio);
 		put_task_struct(p);
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 1f5d070..6546849 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -3885,23 +3885,38 @@ extern void check_class_changed(struct rq *rq, struct=
 task_struct *p,
 extern struct balance_callback *splice_balance_callbacks(struct rq *rq);
 extern void balance_callbacks(struct rq *rq, struct balance_callback *head);
=20
-#ifdef CONFIG_SCHED_CLASS_EXT
 /*
- * Used by SCX in the enable/disable paths to move tasks between sched_class=
es
- * and establish invariants.
+ * The 'sched_change' pattern is the safe, easy and slow way of changing a
+ * task's scheduling properties. It dequeues a task, such that the scheduler
+ * is fully unaware of it; at which point its properties can be modified;
+ * after which it is enqueued again.
+ *
+ * Typically this must be called while holding task_rq_lock, since most/all
+ * properties are serialized under those locks. There is currently one
+ * exception to this rule in sched/ext which only holds rq->lock.
+ */
+
+/*
+ * This structure is a temporary, used to preserve/convey the queueing state
+ * of the task between sched_change_begin() and sched_change_end(). Ensuring
+ * the task's queueing state is idempotent across the operation.
  */
-struct sched_enq_and_set_ctx {
+struct sched_change_ctx {
 	struct task_struct	*p;
-	int			queue_flags;
+	int			flags;
 	bool			queued;
 	bool			running;
 };
=20
-void sched_deq_and_put_task(struct task_struct *p, int queue_flags,
-			    struct sched_enq_and_set_ctx *ctx);
-void sched_enq_and_set_task(struct sched_enq_and_set_ctx *ctx);
+struct sched_change_ctx *sched_change_begin(struct task_struct *p, unsigned =
int flags);
+void sched_change_end(struct sched_change_ctx *ctx);
=20
-#endif /* CONFIG_SCHED_CLASS_EXT */
+DEFINE_CLASS(sched_change, struct sched_change_ctx *,
+	     sched_change_end(_T),
+	     sched_change_begin(p, flags),
+	     struct task_struct *p, unsigned int flags)
+
+DEFINE_CLASS_IS_UNCONDITIONAL(sched_change)
=20
 #include "ext.h"
=20
diff --git a/kernel/sched/syscalls.c b/kernel/sched/syscalls.c
index 77ae87f..09ffe91 100644
--- a/kernel/sched/syscalls.c
+++ b/kernel/sched/syscalls.c
@@ -64,7 +64,6 @@ static int effective_prio(struct task_struct *p)
=20
 void set_user_nice(struct task_struct *p, long nice)
 {
-	bool queued, running;
 	struct rq *rq;
 	int old_prio;
=20
@@ -90,22 +89,12 @@ void set_user_nice(struct task_struct *p, long nice)
 		return;
 	}
=20
-	queued =3D task_on_rq_queued(p);
-	running =3D task_current_donor(rq, p);
-	if (queued)
-		dequeue_task(rq, p, DEQUEUE_SAVE | DEQUEUE_NOCLOCK);
-	if (running)
-		put_prev_task(rq, p);
-
-	p->static_prio =3D NICE_TO_PRIO(nice);
-	set_load_weight(p, true);
-	old_prio =3D p->prio;
-	p->prio =3D effective_prio(p);
-
-	if (queued)
-		enqueue_task(rq, p, ENQUEUE_RESTORE | ENQUEUE_NOCLOCK);
-	if (running)
-		set_next_task(rq, p);
+	scoped_guard (sched_change, p, DEQUEUE_SAVE | DEQUEUE_NOCLOCK) {
+		p->static_prio =3D NICE_TO_PRIO(nice);
+		set_load_weight(p, true);
+		old_prio =3D p->prio;
+		p->prio =3D effective_prio(p);
+	}
=20
 	/*
 	 * If the task increased its priority or is running and
@@ -515,7 +504,7 @@ int __sched_setscheduler(struct task_struct *p,
 			 bool user, bool pi)
 {
 	int oldpolicy =3D -1, policy =3D attr->sched_policy;
-	int retval, oldprio, newprio, queued, running;
+	int retval, oldprio, newprio;
 	const struct sched_class *prev_class, *next_class;
 	struct balance_callback *head;
 	struct rq_flags rf;
@@ -698,33 +687,25 @@ change:
 	if (prev_class !=3D next_class && p->se.sched_delayed)
 		dequeue_task(rq, p, DEQUEUE_SLEEP | DEQUEUE_DELAYED | DEQUEUE_NOCLOCK);
=20
-	queued =3D task_on_rq_queued(p);
-	running =3D task_current_donor(rq, p);
-	if (queued)
-		dequeue_task(rq, p, queue_flags);
-	if (running)
-		put_prev_task(rq, p);
-
-	if (!(attr->sched_flags & SCHED_FLAG_KEEP_PARAMS)) {
-		__setscheduler_params(p, attr);
-		p->sched_class =3D next_class;
-		p->prio =3D newprio;
-	}
-	__setscheduler_uclamp(p, attr);
-	check_class_changing(rq, p, prev_class);
+	scoped_guard (sched_change, p, queue_flags) {
=20
-	if (queued) {
-		/*
-		 * We enqueue to tail when the priority of a task is
-		 * increased (user space view).
-		 */
-		if (oldprio < p->prio)
-			queue_flags |=3D ENQUEUE_HEAD;
+		if (!(attr->sched_flags & SCHED_FLAG_KEEP_PARAMS)) {
+			__setscheduler_params(p, attr);
+			p->sched_class =3D next_class;
+			p->prio =3D newprio;
+		}
+		__setscheduler_uclamp(p, attr);
+		check_class_changing(rq, p, prev_class);
=20
-		enqueue_task(rq, p, queue_flags);
+		if (scope->queued) {
+			/*
+			 * We enqueue to tail when the priority of a task is
+			 * increased (user space view).
+			 */
+			if (oldprio < p->prio)
+				scope->flags |=3D ENQUEUE_HEAD;
+		}
 	}
-	if (running)
-		set_next_task(rq, p);
=20
 	check_class_changed(rq, p, prev_class, oldprio);
=20

