Return-Path: <linux-tip-commits+bounces-6838-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 65D02BE26EF
	for <lists+linux-tip-commits@lfdr.de>; Thu, 16 Oct 2025 11:37:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B2A013E1B67
	for <lists+linux-tip-commits@lfdr.de>; Thu, 16 Oct 2025 09:35:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43C96320383;
	Thu, 16 Oct 2025 09:33:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="MH7XVEXT";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="L0xoHfxL"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F319031DD9A;
	Thu, 16 Oct 2025 09:33:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760607219; cv=none; b=U51QV4qF2CukP9dv1e8cSO8880ZcW/PKFwZFSKfiUkXsoqtaiqZO4icpiOECWYGmyyqBCO9BjwUDeoIHY5o4L4pdtFVlt5GJhIH2gMIwWejImgQFih/tS9MeTD7sOi4S/TNfagZR9Xj1T9HqlCcseyZVL3aG1z7ZPzxY981dF7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760607219; c=relaxed/simple;
	bh=+0Gkamp5W5b8jDXkKPLBkc3GZEJkhnOYEJbjcEVhhb0=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=OCNl59+FDhEqAMhII0jo8nC+0Z88Si0Zo5aC5d4tHfksmpCpMsSKZXXBlOUDCanvofqq01eCOrT2q16OBRdjtICmK/Eonl5XdHVgI+YKDXyoSpug/YMTLNpK7j2uzYD/9m0g5NoJVcSubdewQzGH9JanuHs40Y0dvgWDcaABlxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=MH7XVEXT; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=L0xoHfxL; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 16 Oct 2025 09:33:33 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1760607215;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jsMwV2oJH8ZFwEAQb/Sqc3BkiLMwNhUfhO6KiCBCxVc=;
	b=MH7XVEXTrZ5NU8CEyYVJWsRgADxnLIZNhkrZQbYLOHnll4W30jTIYdvlU4mL9Qzu/4nvAF
	m0Hej8Zh5QekuD5mDAGIdOqi0ObN+AcMYJw3VY1iuY9+HlJXFhEUAcFM004Kj6nVJ5pLl6
	eQ6Zm+iA9XXhO8WuWp6dtefy64cS+HQDqSMPnEW7V+AW1Xo5bmsJmeyvg+yaNA7UV53owN
	AMW4LbkqdFUkYJ3dIlB7Ur6bm0QngLtwr0dLMuYS7vvSntA8QA1Wb7uqSM+7ZDHmOr8bHV
	vB8tRWc9HMelV/ljLVeHd46V78nMrCLuJThk2CQA+WYpXiEz/WhT9KeP2mVWJg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1760607215;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jsMwV2oJH8ZFwEAQb/Sqc3BkiLMwNhUfhO6KiCBCxVc=;
	b=L0xoHfxLA673h1Q71tXkYhXQoEXrCcQDvbH+K5Yg7zQ0HEuPVzcHVafxEqg91V7RGeLN4F
	DUBdYOEjxZ8gbBAw==
From: "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched: Move sched_class::prio_changed() into the
 change pattern
Cc: Tejun Heo <tj@kernel.org>, "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Juri Lelli <juri.lelli@redhat.com>,
 Vincent Guittot <vincent.guittot@linaro.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20251006104527.083607521@infradead.org>
References: <20251006104527.083607521@infradead.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176060721397.709179.10063752274577762847.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     6455ad5346c9cf755fa9dda6e326c4028fb3c853
Gitweb:        https://git.kernel.org/tip/6455ad5346c9cf755fa9dda6e326c4028fb=
3c853
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Fri, 01 Nov 2024 14:16:10 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Thu, 16 Oct 2025 11:13:52 +02:00

sched: Move sched_class::prio_changed() into the change pattern

Move sched_class::prio_changed() into the change pattern.

And while there, extend it with sched_class::get_prio() in order to
fix the deadline sitation.

Suggested-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Juri Lelli <juri.lelli@redhat.com>
Acked-by: Tejun Heo <tj@kernel.org>
Acked-by: Vincent Guittot <vincent.guittot@linaro.org>
---
 kernel/sched/core.c      | 24 +++++++++++++-----------
 kernel/sched/deadline.c  | 20 +++++++++++---------
 kernel/sched/ext.c       |  8 +-------
 kernel/sched/fair.c      |  8 ++++++--
 kernel/sched/idle.c      |  5 ++++-
 kernel/sched/rt.c        |  5 ++++-
 kernel/sched/sched.h     |  7 ++++---
 kernel/sched/stop_task.c |  5 ++++-
 kernel/sched/syscalls.c  |  9 ---------
 9 files changed, 47 insertions(+), 44 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index bd2c551..4a4dbce 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -2169,12 +2169,6 @@ inline int task_curr(const struct task_struct *p)
 	return cpu_curr(task_cpu(p)) =3D=3D p;
 }
=20
-void check_prio_changed(struct rq *rq, struct task_struct *p, int oldprio)
-{
-	if (oldprio !=3D p->prio || dl_task(p))
-		p->sched_class->prio_changed(rq, p, oldprio);
-}
-
 void wakeup_preempt(struct rq *rq, struct task_struct *p, int flags)
 {
 	struct task_struct *donor =3D rq->donor;
@@ -7400,9 +7394,6 @@ void rt_mutex_setprio(struct task_struct *p, struct tas=
k_struct *pi_task)
 		p->sched_class =3D next_class;
 		p->prio =3D prio;
 	}
-
-	if (!(queue_flag & DEQUEUE_CLASS))
-		check_prio_changed(rq, p, oldprio);
 out_unlock:
 	/* Avoid rq from going away on us: */
 	preempt_disable();
@@ -10855,6 +10846,13 @@ struct sched_change_ctx *sched_change_begin(struct t=
ask_struct *p, unsigned int=20
 		.running =3D task_current_donor(rq, p),
 	};
=20
+	if (!(flags & DEQUEUE_CLASS)) {
+		if (p->sched_class->get_prio)
+			ctx->prio =3D p->sched_class->get_prio(rq, p);
+		else
+			ctx->prio =3D p->prio;
+	}
+
 	if (ctx->queued)
 		dequeue_task(rq, p, flags);
 	if (ctx->running)
@@ -10881,6 +10879,10 @@ void sched_change_end(struct sched_change_ctx *ctx)
 	if (ctx->running)
 		set_next_task(rq, p);
=20
-	if ((ctx->flags & ENQUEUE_CLASS) && p->sched_class->switched_to)
-		p->sched_class->switched_to(rq, p);
+	if (ctx->flags & ENQUEUE_CLASS) {
+		if (p->sched_class->switched_to)
+			p->sched_class->switched_to(rq, p);
+	} else {
+		p->sched_class->prio_changed(rq, p, ctx->prio);
+	}
 }
diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index fd147a7..1f94994 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -3042,23 +3042,24 @@ static void switched_to_dl(struct rq *rq, struct task=
_struct *p)
 	}
 }
=20
+static u64 get_prio_dl(struct rq *rq, struct task_struct *p)
+{
+	return p->dl.deadline;
+}
+
 /*
  * If the scheduling parameters of a -deadline task changed,
  * a push or pull operation might be needed.
  */
-static void prio_changed_dl(struct rq *rq, struct task_struct *p,
-			    int oldprio)
+static void prio_changed_dl(struct rq *rq, struct task_struct *p, u64 old_de=
adline)
 {
 	if (!task_on_rq_queued(p))
 		return;
=20
-	/*
-	 * This might be too much, but unfortunately
-	 * we don't have the old deadline value, and
-	 * we can't argue if the task is increasing
-	 * or lowering its prio, so...
-	 */
-	if (!rq->dl.overloaded)
+	if (p->dl.deadline =3D=3D old_deadline)
+		return;
+
+	if (dl_time_before(old_deadline, p->dl.deadline))
 		deadline_queue_pull_task(rq);
=20
 	if (task_current_donor(rq, p)) {
@@ -3113,6 +3114,7 @@ DEFINE_SCHED_CLASS(dl) =3D {
 	.task_tick		=3D task_tick_dl,
 	.task_fork              =3D task_fork_dl,
=20
+	.get_prio		=3D get_prio_dl,
 	.prio_changed           =3D prio_changed_dl,
 	.switched_from		=3D switched_from_dl,
 	.switched_to		=3D switched_to_dl,
diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index b0a1e2a..ad371b6 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -2961,7 +2961,7 @@ static void reweight_task_scx(struct rq *rq, struct tas=
k_struct *p,
 				 p, p->scx.weight);
 }
=20
-static void prio_changed_scx(struct rq *rq, struct task_struct *p, int oldpr=
io)
+static void prio_changed_scx(struct rq *rq, struct task_struct *p, u64 oldpr=
io)
 {
 }
=20
@@ -3926,9 +3926,6 @@ static void scx_disable_workfn(struct kthread_work *wor=
k)
 			p->sched_class =3D new_class;
 		}
=20
-		if (!(queue_flags & DEQUEUE_CLASS))
-			check_prio_changed(task_rq(p), p, p->prio);
-
 		scx_exit_task(p);
 	}
 	scx_task_iter_stop(&sti);
@@ -4675,9 +4672,6 @@ static int scx_enable(struct sched_ext_ops *ops, struct=
 bpf_link *link)
 			p->sched_class =3D new_class;
 		}
=20
-		if (!(queue_flags & DEQUEUE_CLASS))
-			check_prio_changed(task_rq(p), p, p->prio);
-
 		put_task_struct(p);
 	}
 	scx_task_iter_stop(&sti);
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 6c462e4..77a713e 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -13150,11 +13150,14 @@ static void task_fork_fair(struct task_struct *p)
  * the current task.
  */
 static void
-prio_changed_fair(struct rq *rq, struct task_struct *p, int oldprio)
+prio_changed_fair(struct rq *rq, struct task_struct *p, u64 oldprio)
 {
 	if (!task_on_rq_queued(p))
 		return;
=20
+	if (p->prio =3D=3D oldprio)
+		return;
+
 	if (rq->cfs.nr_queued =3D=3D 1)
 		return;
=20
@@ -13166,8 +13169,9 @@ prio_changed_fair(struct rq *rq, struct task_struct *=
p, int oldprio)
 	if (task_current_donor(rq, p)) {
 		if (p->prio > oldprio)
 			resched_curr(rq);
-	} else
+	} else {
 		wakeup_preempt(rq, p, 0);
+	}
 }
=20
 #ifdef CONFIG_FAIR_GROUP_SCHED
diff --git a/kernel/sched/idle.c b/kernel/sched/idle.c
index f02dced..dee6e01 100644
--- a/kernel/sched/idle.c
+++ b/kernel/sched/idle.c
@@ -504,8 +504,11 @@ static void switching_to_idle(struct rq *rq, struct task=
_struct *p)
 }
=20
 static void
-prio_changed_idle(struct rq *rq, struct task_struct *p, int oldprio)
+prio_changed_idle(struct rq *rq, struct task_struct *p, u64 oldprio)
 {
+	if (p->prio =3D=3D oldprio)
+		return;
+
 	BUG();
 }
=20
diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
index 6b2e811..c2347e4 100644
--- a/kernel/sched/rt.c
+++ b/kernel/sched/rt.c
@@ -2437,11 +2437,14 @@ static void switched_to_rt(struct rq *rq, struct task=
_struct *p)
  * us to initiate a push or pull.
  */
 static void
-prio_changed_rt(struct rq *rq, struct task_struct *p, int oldprio)
+prio_changed_rt(struct rq *rq, struct task_struct *p, u64 oldprio)
 {
 	if (!task_on_rq_queued(p))
 		return;
=20
+	if (p->prio =3D=3D oldprio)
+		return;
+
 	if (task_current_donor(rq, p)) {
 		/*
 		 * If our priority decreases while running, we
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index e3f4215..bcde43d 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -2451,8 +2451,10 @@ struct sched_class {
=20
 	void (*reweight_task)(struct rq *this_rq, struct task_struct *task,
 			      const struct load_weight *lw);
+
+	u64  (*get_prio)     (struct rq *this_rq, struct task_struct *task);
 	void (*prio_changed) (struct rq *this_rq, struct task_struct *task,
-			      int oldprio);
+			      u64 oldprio);
=20
 	unsigned int (*get_rr_interval)(struct rq *rq,
 					struct task_struct *task);
@@ -3877,8 +3879,6 @@ extern void set_load_weight(struct task_struct *p, bool=
 update_load);
 extern void enqueue_task(struct rq *rq, struct task_struct *p, int flags);
 extern bool dequeue_task(struct rq *rq, struct task_struct *p, int flags);
=20
-extern void check_prio_changed(struct rq *rq, struct task_struct *p, int old=
prio);
-
 extern struct balance_callback *splice_balance_callbacks(struct rq *rq);
 extern void balance_callbacks(struct rq *rq, struct balance_callback *head);
=20
@@ -3899,6 +3899,7 @@ extern void balance_callbacks(struct rq *rq, struct bal=
ance_callback *head);
  * the task's queueing state is idempotent across the operation.
  */
 struct sched_change_ctx {
+	u64			prio;
 	struct task_struct	*p;
 	int			flags;
 	bool			queued;
diff --git a/kernel/sched/stop_task.c b/kernel/sched/stop_task.c
index fcc4c54..73aa8de 100644
--- a/kernel/sched/stop_task.c
+++ b/kernel/sched/stop_task.c
@@ -81,8 +81,11 @@ static void switching_to_stop(struct rq *rq, struct task_s=
truct *p)
 }
=20
 static void
-prio_changed_stop(struct rq *rq, struct task_struct *p, int oldprio)
+prio_changed_stop(struct rq *rq, struct task_struct *p, u64 oldprio)
 {
+	if (p->prio =3D=3D oldprio)
+		return;
+
 	BUG(); /* how!?, what priority? */
 }
=20
diff --git a/kernel/sched/syscalls.c b/kernel/sched/syscalls.c
index 6583faf..20af564 100644
--- a/kernel/sched/syscalls.c
+++ b/kernel/sched/syscalls.c
@@ -95,12 +95,6 @@ void set_user_nice(struct task_struct *p, long nice)
 		old_prio =3D p->prio;
 		p->prio =3D effective_prio(p);
 	}
-
-	/*
-	 * If the task increased its priority or is running and
-	 * lowered its priority, then reschedule its CPU:
-	 */
-	p->sched_class->prio_changed(rq, p, old_prio);
 }
 EXPORT_SYMBOL(set_user_nice);
=20
@@ -706,9 +700,6 @@ change:
 		}
 	}
=20
-	if (!(queue_flags & DEQUEUE_CLASS))
-		check_prio_changed(rq, p, oldprio);
-
 	/* Avoid rq from going away on us: */
 	preempt_disable();
 	head =3D splice_balance_callbacks(rq);

