Return-Path: <linux-tip-commits+bounces-6840-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E69EBE26DD
	for <lists+linux-tip-commits@lfdr.de>; Thu, 16 Oct 2025 11:36:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 039ED4FED55
	for <lists+linux-tip-commits@lfdr.de>; Thu, 16 Oct 2025 09:35:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3153B320A1D;
	Thu, 16 Oct 2025 09:33:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="IoO2ROeE";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Wu69U79A"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 876DF320390;
	Thu, 16 Oct 2025 09:33:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760607222; cv=none; b=EWQWwTtyNgCU9q+N4O4LFEcYL/kxwGyPiWAYWxQiCPshhaGKs5AZj323b/j4nTMr9VETf8IsaV1dqDAO498YZYAxTZe/eFE8PqwWxFcoepejEUpCO6dTNMdd2to2Nlzb0Fes+siMI0htwdRLbaG6dYsZl2TfNvow19gjWTggeAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760607222; c=relaxed/simple;
	bh=04le2Cei0s59+9jdg3U7rPiH15CIkVNtyf+xS0TAjHo=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=mwUTo59dykgkAsYxvBl8LbBv5wZnaD52WmX2u61L7LJT6rap3OGUKSkGW+HBM03DNQmUYYSSoUBeC7SybS6kSInjx30fvNjimop4pRtr8jZx1lyN9QamGqIHgFvldQVv0CzzKkbhLJ2+cpp7ELxpQb3A5KCx5mGjug/OnKKmWvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=IoO2ROeE; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Wu69U79A; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 16 Oct 2025 09:33:36 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1760607218;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fkWwANtrXW4oV2ARLP3PekSdxkHxCMRSMx/fVbOle/E=;
	b=IoO2ROeEmPDkJ+fIaUNUOhCFE4geviHKIywVzo++wj3bm+6w40Czh0wYpkpYjCv+8moy7e
	S9Pqk7yCfG6R+/g+/W4qh3tHP9+Ux/ZSOX0cS5AT7F331gX1seDiSV1eq7v4zjcwNBi/+0
	HLjmqC+zHcuzmQT9mteTM0n8EIYDN/awxrKB4jAPN74ae3P77XsiLqvxHckIepYjzsm+cc
	ejXRdqFKAJ+Ihn0ONRK5tAWheivcG7mRGJZ2KztOFDp3pi7hs3osKxTEl/HqjYsBb6vvBn
	B6x40KWHrtscZaJuEG2VLCVkPSrfEqTz2NbywYHqYcRyrl8YkNDAcwVvmhO3UA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1760607218;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fkWwANtrXW4oV2ARLP3PekSdxkHxCMRSMx/fVbOle/E=;
	b=Wu69U79AElm1LVgomTt9jMsD+pF9ge9xzvf07XrerVfxsuLQR9xf5UV+wy532S4CnA3NmJ
	9W6gqA9M3le90qBA==
From: "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched: Fold sched_class::switch{ing,ed}_{to,from}()
 into the change pattern
Cc: "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Juri Lelli <juri.lelli@redhat.com>, Tejun Heo <tj@kernel.org>,
 Vincent Guittot <vincent.guittot@linaro.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20251006104526.861755244@infradead.org>
References: <20251006104526.861755244@infradead.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176060721661.709179.13194764741989962419.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     637b0682821b144d5993211cf0a768b322138a69
Gitweb:        https://git.kernel.org/tip/637b0682821b144d5993211cf0a768b3221=
38a69
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Wed, 30 Oct 2024 15:08:15 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Thu, 16 Oct 2025 11:13:51 +02:00

sched: Fold sched_class::switch{ing,ed}_{to,from}() into the change pattern

Add {DE,EN}QUEUE_CLASS and fold the sched_class::switch* methods into
the change pattern. This completes and makes the pattern more
symmetric.

This changes the order of callbacks slightly:

  OLD                              NEW
				|
				|  switching_from()
  dequeue_task();		|  dequeue_task()
  put_prev_task();		|  put_prev_task()
				|  switched_from()
				|
  ... change task ...		|  ... change task ...
				|
  switching_to();		|  switching_to()
  enqueue_task();		|  enqueue_task()
  set_next_task();		|  set_next_task()
  prev_class->switched_from()	|
  switched_to()			|  switched_to()
				|

Notably, it moves the switched_from() callback right after the
dequeue/put. Existing implementations don't appear to be affected by
this change in location -- specifically the task isn't enqueued on the
class in question in either location.

Make (CLASS)^(SAVE|MOVE), because there is nothing to save-restore
when changing scheduling classes.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Juri Lelli <juri.lelli@redhat.com>
Acked-by: Tejun Heo <tj@kernel.org>
Acked-by: Vincent Guittot <vincent.guittot@linaro.org>
---
 kernel/sched/core.c      | 51 ++++++++++++++++-----------------------
 kernel/sched/ext.c       | 22 ++++++++++++-----
 kernel/sched/idle.c      |  4 +--
 kernel/sched/rt.c        |  2 +-
 kernel/sched/sched.h     | 22 ++++++-----------
 kernel/sched/stop_task.c |  4 +--
 kernel/sched/syscalls.c  |  7 +++--
 7 files changed, 55 insertions(+), 57 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index eca40df..4dbd206 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -2169,34 +2169,9 @@ inline int task_curr(const struct task_struct *p)
 	return cpu_curr(task_cpu(p)) =3D=3D p;
 }
=20
-/*
- * ->switching_to() is called with the pi_lock and rq_lock held and must not
- * mess with locking.
- */
-void check_class_changing(struct rq *rq, struct task_struct *p,
-			  const struct sched_class *prev_class)
-{
-	if (prev_class !=3D p->sched_class && p->sched_class->switching_to)
-		p->sched_class->switching_to(rq, p);
-}
-
-/*
- * switched_from, switched_to and prio_changed must _NOT_ drop rq->lock,
- * use the balance_callback list if you want balancing.
- *
- * this means any call to check_class_changed() must be followed by a call to
- * balance_callback().
- */
-void check_class_changed(struct rq *rq, struct task_struct *p,
-			 const struct sched_class *prev_class,
-			 int oldprio)
+void check_prio_changed(struct rq *rq, struct task_struct *p, int oldprio)
 {
-	if (prev_class !=3D p->sched_class) {
-		if (prev_class->switched_from)
-			prev_class->switched_from(rq, p);
-
-		p->sched_class->switched_to(rq, p);
-	} else if (oldprio !=3D p->prio || dl_task(p))
+	if (oldprio !=3D p->prio || dl_task(p))
 		p->sched_class->prio_changed(rq, p, oldprio);
 }
=20
@@ -7388,6 +7363,9 @@ void rt_mutex_setprio(struct task_struct *p, struct tas=
k_struct *pi_task)
 	prev_class =3D p->sched_class;
 	next_class =3D __setscheduler_class(p->policy, prio);
=20
+	if (prev_class !=3D next_class)
+		queue_flag |=3D DEQUEUE_CLASS;
+
 	if (prev_class !=3D next_class && p->se.sched_delayed)
 		dequeue_task(rq, p, DEQUEUE_SLEEP | DEQUEUE_DELAYED | DEQUEUE_NOCLOCK);
=20
@@ -7424,11 +7402,10 @@ void rt_mutex_setprio(struct task_struct *p, struct t=
ask_struct *pi_task)
=20
 		p->sched_class =3D next_class;
 		p->prio =3D prio;
-
-		check_class_changing(rq, p, prev_class);
 	}
=20
-	check_class_changed(rq, p, prev_class, oldprio);
+	if (!(queue_flag & DEQUEUE_CLASS))
+		check_prio_changed(rq, p, oldprio);
 out_unlock:
 	/* Avoid rq from going away on us: */
 	preempt_disable();
@@ -10862,6 +10839,11 @@ struct sched_change_ctx *sched_change_begin(struct t=
ask_struct *p, unsigned int=20
=20
 	lockdep_assert_rq_held(rq);
=20
+	if (flags & DEQUEUE_CLASS) {
+		if (p->sched_class->switching_from)
+			p->sched_class->switching_from(rq, p);
+	}
+
 	*ctx =3D (struct sched_change_ctx){
 		.p =3D p,
 		.flags =3D flags,
@@ -10874,6 +10856,9 @@ struct sched_change_ctx *sched_change_begin(struct ta=
sk_struct *p, unsigned int=20
 	if (ctx->running)
 		put_prev_task(rq, p);
=20
+	if ((flags & DEQUEUE_CLASS) && p->sched_class->switched_from)
+		p->sched_class->switched_from(rq, p);
+
 	return ctx;
 }
=20
@@ -10884,8 +10869,14 @@ void sched_change_end(struct sched_change_ctx *ctx)
=20
 	lockdep_assert_rq_held(rq);
=20
+	if ((ctx->flags & ENQUEUE_CLASS) && p->sched_class->switching_to)
+		p->sched_class->switching_to(rq, p);
+
 	if (ctx->queued)
 		enqueue_task(rq, p, ctx->flags | ENQUEUE_NOCLOCK);
 	if (ctx->running)
 		set_next_task(rq, p);
+
+	if ((ctx->flags & ENQUEUE_CLASS) && p->sched_class->switched_to)
+		p->sched_class->switched_to(rq, p);
 }
diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index 4566a7c..a408c39 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -3912,21 +3912,26 @@ static void scx_disable_workfn(struct kthread_work *w=
ork)
=20
 	scx_task_iter_start(&sti);
 	while ((p =3D scx_task_iter_next_locked(&sti))) {
+		unsigned int queue_flags =3D DEQUEUE_SAVE | DEQUEUE_MOVE | DEQUEUE_NOCLOCK;
 		const struct sched_class *old_class =3D p->sched_class;
 		const struct sched_class *new_class =3D
 			__setscheduler_class(p->policy, p->prio);
=20
 		update_rq_clock(task_rq(p));
=20
+		if (old_class !=3D new_class)
+			queue_flags |=3D DEQUEUE_CLASS;
+
 		if (old_class !=3D new_class && p->se.sched_delayed)
 			dequeue_task(task_rq(p), p, DEQUEUE_SLEEP | DEQUEUE_DELAYED | DEQUEUE_NOC=
LOCK);
=20
-		scoped_guard (sched_change, p, DEQUEUE_SAVE | DEQUEUE_MOVE | DEQUEUE_NOCLO=
CK) {
+		scoped_guard (sched_change, p, queue_flags) {
 			p->sched_class =3D new_class;
-			check_class_changing(task_rq(p), p, old_class);
 		}
=20
-		check_class_changed(task_rq(p), p, old_class, p->prio);
+		if (!(queue_flags & DEQUEUE_CLASS))
+			check_prio_changed(task_rq(p), p, p->prio);
+
 		scx_exit_task(p);
 	}
 	scx_task_iter_stop(&sti);
@@ -4655,6 +4660,7 @@ static int scx_enable(struct sched_ext_ops *ops, struct=
 bpf_link *link)
 	percpu_down_write(&scx_fork_rwsem);
 	scx_task_iter_start(&sti);
 	while ((p =3D scx_task_iter_next_locked(&sti))) {
+		unsigned int queue_flags =3D DEQUEUE_SAVE | DEQUEUE_MOVE | DEQUEUE_NOCLOCK;
 		const struct sched_class *old_class =3D p->sched_class;
 		const struct sched_class *new_class =3D
 			__setscheduler_class(p->policy, p->prio);
@@ -4664,16 +4670,20 @@ static int scx_enable(struct sched_ext_ops *ops, stru=
ct bpf_link *link)
=20
 		update_rq_clock(task_rq(p));
=20
+		if (old_class !=3D new_class)
+			queue_flags |=3D DEQUEUE_CLASS;
+
 		if (old_class !=3D new_class && p->se.sched_delayed)
 			dequeue_task(task_rq(p), p, DEQUEUE_SLEEP | DEQUEUE_DELAYED | DEQUEUE_NOC=
LOCK);
=20
-		scoped_guard (sched_change, p, DEQUEUE_SAVE | DEQUEUE_MOVE | DEQUEUE_NOCLO=
CK) {
+		scoped_guard (sched_change, p, queue_flags) {
 			p->scx.slice =3D SCX_SLICE_DFL;
 			p->sched_class =3D new_class;
-			check_class_changing(task_rq(p), p, old_class);
 		}
=20
-		check_class_changed(task_rq(p), p, old_class, p->prio);
+		if (!(queue_flags & DEQUEUE_CLASS))
+			check_prio_changed(task_rq(p), p, p->prio);
+
 		put_task_struct(p);
 	}
 	scx_task_iter_stop(&sti);
diff --git a/kernel/sched/idle.c b/kernel/sched/idle.c
index c39b089..f02dced 100644
--- a/kernel/sched/idle.c
+++ b/kernel/sched/idle.c
@@ -498,7 +498,7 @@ static void task_tick_idle(struct rq *rq, struct task_str=
uct *curr, int queued)
 {
 }
=20
-static void switched_to_idle(struct rq *rq, struct task_struct *p)
+static void switching_to_idle(struct rq *rq, struct task_struct *p)
 {
 	BUG();
 }
@@ -536,6 +536,6 @@ DEFINE_SCHED_CLASS(idle) =3D {
 	.task_tick		=3D task_tick_idle,
=20
 	.prio_changed		=3D prio_changed_idle,
-	.switched_to		=3D switched_to_idle,
+	.switching_to		=3D switching_to_idle,
 	.update_curr		=3D update_curr_idle,
 };
diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
index 7936d43..6b2e811 100644
--- a/kernel/sched/rt.c
+++ b/kernel/sched/rt.c
@@ -2589,8 +2589,8 @@ DEFINE_SCHED_CLASS(rt) =3D {
=20
 	.get_rr_interval	=3D get_rr_interval_rt,
=20
-	.prio_changed		=3D prio_changed_rt,
 	.switched_to		=3D switched_to_rt,
+	.prio_changed		=3D prio_changed_rt,
=20
 	.update_curr		=3D update_curr_rt,
=20
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 24b3c6c..e3f4215 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -20,7 +20,6 @@
 #include <linux/sched/task_flags.h>
 #include <linux/sched/task.h>
 #include <linux/sched/topology.h>
-
 #include <linux/atomic.h>
 #include <linux/bitmap.h>
 #include <linux/bug.h>
@@ -2369,6 +2368,7 @@ extern const u32		sched_prio_to_wmult[40];
=20
 #define DEQUEUE_MIGRATING	0x0010 /* Matches ENQUEUE_MIGRATING */
 #define DEQUEUE_DELAYED		0x0020 /* Matches ENQUEUE_DELAYED */
+#define DEQUEUE_CLASS		0x0040 /* Matches ENQUEUE_CLASS */
=20
 #define DEQUEUE_SPECIAL		0x00010000
 #define DEQUEUE_THROTTLE	0x00020000
@@ -2380,6 +2380,7 @@ extern const u32		sched_prio_to_wmult[40];
=20
 #define ENQUEUE_MIGRATING	0x0010
 #define ENQUEUE_DELAYED		0x0020
+#define ENQUEUE_CLASS		0x0040
=20
 #define ENQUEUE_HEAD		0x00010000
 #define ENQUEUE_REPLENISH	0x00020000
@@ -2443,14 +2444,11 @@ struct sched_class {
 	void (*task_fork)(struct task_struct *p);
 	void (*task_dead)(struct task_struct *p);
=20
-	/*
-	 * The switched_from() call is allowed to drop rq->lock, therefore we
-	 * cannot assume the switched_from/switched_to pair is serialized by
-	 * rq->lock. They are however serialized by p->pi_lock.
-	 */
-	void (*switching_to) (struct rq *this_rq, struct task_struct *task);
-	void (*switched_from)(struct rq *this_rq, struct task_struct *task);
-	void (*switched_to)  (struct rq *this_rq, struct task_struct *task);
+	void (*switching_from)(struct rq *this_rq, struct task_struct *task);
+	void (*switched_from) (struct rq *this_rq, struct task_struct *task);
+	void (*switching_to)  (struct rq *this_rq, struct task_struct *task);
+	void (*switched_to)   (struct rq *this_rq, struct task_struct *task);
+
 	void (*reweight_task)(struct rq *this_rq, struct task_struct *task,
 			      const struct load_weight *lw);
 	void (*prio_changed) (struct rq *this_rq, struct task_struct *task,
@@ -3879,11 +3877,7 @@ extern void set_load_weight(struct task_struct *p, boo=
l update_load);
 extern void enqueue_task(struct rq *rq, struct task_struct *p, int flags);
 extern bool dequeue_task(struct rq *rq, struct task_struct *p, int flags);
=20
-extern void check_class_changing(struct rq *rq, struct task_struct *p,
-				 const struct sched_class *prev_class);
-extern void check_class_changed(struct rq *rq, struct task_struct *p,
-				const struct sched_class *prev_class,
-				int oldprio);
+extern void check_prio_changed(struct rq *rq, struct task_struct *p, int old=
prio);
=20
 extern struct balance_callback *splice_balance_callbacks(struct rq *rq);
 extern void balance_callbacks(struct rq *rq, struct balance_callback *head);
diff --git a/kernel/sched/stop_task.c b/kernel/sched/stop_task.c
index 2d4e279..fcc4c54 100644
--- a/kernel/sched/stop_task.c
+++ b/kernel/sched/stop_task.c
@@ -75,7 +75,7 @@ static void task_tick_stop(struct rq *rq, struct task_struc=
t *curr, int queued)
 {
 }
=20
-static void switched_to_stop(struct rq *rq, struct task_struct *p)
+static void switching_to_stop(struct rq *rq, struct task_struct *p)
 {
 	BUG(); /* its impossible to change to this class */
 }
@@ -112,6 +112,6 @@ DEFINE_SCHED_CLASS(stop) =3D {
 	.task_tick		=3D task_tick_stop,
=20
 	.prio_changed		=3D prio_changed_stop,
-	.switched_to		=3D switched_to_stop,
+	.switching_to		=3D switching_to_stop,
 	.update_curr		=3D update_curr_stop,
 };
diff --git a/kernel/sched/syscalls.c b/kernel/sched/syscalls.c
index 09ffe91..bcef5c7 100644
--- a/kernel/sched/syscalls.c
+++ b/kernel/sched/syscalls.c
@@ -684,6 +684,9 @@ change:
 	prev_class =3D p->sched_class;
 	next_class =3D __setscheduler_class(policy, newprio);
=20
+	if (prev_class !=3D next_class)
+		queue_flags |=3D DEQUEUE_CLASS;
+
 	if (prev_class !=3D next_class && p->se.sched_delayed)
 		dequeue_task(rq, p, DEQUEUE_SLEEP | DEQUEUE_DELAYED | DEQUEUE_NOCLOCK);
=20
@@ -695,7 +698,6 @@ change:
 			p->prio =3D newprio;
 		}
 		__setscheduler_uclamp(p, attr);
-		check_class_changing(rq, p, prev_class);
=20
 		if (scope->queued) {
 			/*
@@ -707,7 +709,8 @@ change:
 		}
 	}
=20
-	check_class_changed(rq, p, prev_class, oldprio);
+	if (!(queue_flags & DEQUEUE_CLASS))
+		check_prio_changed(rq, p, oldprio);
=20
 	/* Avoid rq from going away on us: */
 	preempt_disable();

