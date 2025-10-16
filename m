Return-Path: <linux-tip-commits+bounces-6830-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C46D3BE269B
	for <lists+linux-tip-commits@lfdr.de>; Thu, 16 Oct 2025 11:34:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 296991A62649
	for <lists+linux-tip-commits@lfdr.de>; Thu, 16 Oct 2025 09:34:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73EEC31A7F5;
	Thu, 16 Oct 2025 09:33:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="e6rumCFQ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="y4re31E9"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68E9B31A57B;
	Thu, 16 Oct 2025 09:33:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760607209; cv=none; b=j0Ya7Xgx5KBcZJsvqEA81GcKV8D5VOSPm4Y7AhQKSJea06wRYvpGiT+7mcEb36jHtrciQZ2vgEc7A+/g88hleUdxbzk1mMMKFOp0hehMUUz/W0Jk9pGFEjmJab4wsOqPv0iCNTByt6MkQ24kXcVDTP/GnWKVdui+4YKgIFe2DjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760607209; c=relaxed/simple;
	bh=nqGA87wfEvno46asbg4QuUn+6OyQYzZzdxTldGJNG4Y=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=V6Ty/84hClMrIB2UXWApCualCWETsJJUL1bWXbnggQdHBvVQ+2emcc3OlIZFgRXvcp2vOKM/lVKY8hxj9tt3CwnPPFfAoqqI0DlesA3DELa2o8tkR3/vLdQzk//cxy4W1fIZ6wWYxcLqibWBHxAcM1SijC7aG3xN2O4L29F/AsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=e6rumCFQ; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=y4re31E9; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 16 Oct 2025 09:33:22 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1760607203;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hYv/UHTU5CAWXZ/VM0wJiyvjePlw6f7vrIibDqto/2c=;
	b=e6rumCFQO1eOQHQJWdRZmI6DNryPmDwSr3x6Kfa2patl06V1PtYWlylEx3EOeZkwk+xG9l
	gfSZ/1xnvX8NuLS+mZ1TCIQSl7QYR4ZERiXGAQjkhpb1UFaMSNlqqxMmHdEx0/y4pJfy8y
	BBCV7YwkU7yvnOtc+1oQ9zvu3XRG+BVnhWQqxHkAR+vaScyTyYPk7u84xhIKoGz1xdMV3B
	+NpBIi9+lAzKpocDXxErnqrkPvG3R7Owuv7Wd1/nREqQY3PnDfXPoGSND4PPIh+iqvOCVZ
	6sWpe5Y7SMwJioa3AkSOEFmjym9jNa4vzTldceGGX5Zc/smdNBWaK6mbMoMbeQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1760607203;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hYv/UHTU5CAWXZ/VM0wJiyvjePlw6f7vrIibDqto/2c=;
	b=y4re31E9bX1u6PAk/P2RuECS+uRhBU008QZir6z3U57eVdKsGoZkTizM5aZ5qp5Co/PpKu
	aVUH/cOJHoPio9DQ==
From: "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched: Detect per-class runqueue changes
Cc: "Peter Zijlstra (Intel)" <peterz@infradead.org>, Tejun Heo <tj@kernel.org>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20251006105453.522934521@infradead.org>
References: <20251006105453.522934521@infradead.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176060720216.709179.6681961039422919924.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     1e900f415c6082cd4bcdae4c92515d21fb389473
Gitweb:        https://git.kernel.org/tip/1e900f415c6082cd4bcdae4c92515d21fb3=
89473
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Wed, 01 Oct 2025 15:50:15 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Thu, 16 Oct 2025 11:13:55 +02:00

sched: Detect per-class runqueue changes

Have enqueue/dequeue set a per-class bit in rq->queue_mask. This then
enables easy tracking of which runqueues are modified over a
lock-break.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Tejun Heo <tj@kernel.org>
---
 kernel/sched/core.c      |  2 ++
 kernel/sched/deadline.c  |  2 ++
 kernel/sched/ext.c       |  2 ++
 kernel/sched/fair.c      |  7 +++++--
 kernel/sched/idle.c      |  2 ++
 kernel/sched/rt.c        |  2 ++
 kernel/sched/sched.h     | 25 +++++++++++++++++++++++++
 kernel/sched/stop_task.c |  2 ++
 8 files changed, 42 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index e2199e4..9fc990f 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -2089,6 +2089,7 @@ void enqueue_task(struct rq *rq, struct task_struct *p,=
 int flags)
 	 */
 	uclamp_rq_inc(rq, p, flags);
=20
+	rq->queue_mask |=3D p->sched_class->queue_mask;
 	p->sched_class->enqueue_task(rq, p, flags);
=20
 	psi_enqueue(p, flags);
@@ -2121,6 +2122,7 @@ inline bool dequeue_task(struct rq *rq, struct task_str=
uct *p, int flags)
 	 * and mark the task ->sched_delayed.
 	 */
 	uclamp_rq_dec(rq, p);
+	rq->queue_mask |=3D p->sched_class->queue_mask;
 	return p->sched_class->dequeue_task(rq, p, flags);
 }
=20
diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index 1f94994..83e6175 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -3092,6 +3092,8 @@ static int task_is_throttled_dl(struct task_struct *p, =
int cpu)
=20
 DEFINE_SCHED_CLASS(dl) =3D {
=20
+	.queue_mask		=3D 8,
+
 	.enqueue_task		=3D enqueue_task_dl,
 	.dequeue_task		=3D dequeue_task_dl,
 	.yield_task		=3D yield_task_dl,
diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index 5717042..949c3a6 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -3234,6 +3234,8 @@ static void scx_cgroup_unlock(void) {}
  *   their current sched_class. Call them directly from sched core instead.
  */
 DEFINE_SCHED_CLASS(ext) =3D {
+	.queue_mask		=3D 1,
+
 	.enqueue_task		=3D enqueue_task_scx,
 	.dequeue_task		=3D dequeue_task_scx,
 	.yield_task		=3D yield_task_scx,
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 77a713e..23ac05c 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -12841,6 +12841,7 @@ static int sched_balance_newidle(struct rq *this_rq, =
struct rq_flags *rf)
 	}
 	rcu_read_unlock();
=20
+	rq_modified_clear(this_rq);
 	raw_spin_rq_unlock(this_rq);
=20
 	t0 =3D sched_clock_cpu(this_cpu);
@@ -12898,8 +12899,8 @@ static int sched_balance_newidle(struct rq *this_rq, =
struct rq_flags *rf)
 	if (this_rq->cfs.h_nr_queued && !pulled_task)
 		pulled_task =3D 1;
=20
-	/* Is there a task of a high priority class? */
-	if (this_rq->nr_running !=3D this_rq->cfs.h_nr_queued)
+	/* If a higher prio class was modified, restart the pick */
+	if (rq_modified_above(this_rq, &fair_sched_class))
 		pulled_task =3D -1;
=20
 out:
@@ -13633,6 +13634,8 @@ static unsigned int get_rr_interval_fair(struct rq *r=
q, struct task_struct *task
  */
 DEFINE_SCHED_CLASS(fair) =3D {
=20
+	.queue_mask		=3D 2,
+
 	.enqueue_task		=3D enqueue_task_fair,
 	.dequeue_task		=3D dequeue_task_fair,
 	.yield_task		=3D yield_task_fair,
diff --git a/kernel/sched/idle.c b/kernel/sched/idle.c
index dee6e01..055b0dd 100644
--- a/kernel/sched/idle.c
+++ b/kernel/sched/idle.c
@@ -521,6 +521,8 @@ static void update_curr_idle(struct rq *rq)
  */
 DEFINE_SCHED_CLASS(idle) =3D {
=20
+	.queue_mask		=3D 0,
+
 	/* no enqueue/yield_task for idle tasks */
=20
 	/* dequeue is not valid, we print a debug message there: */
diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
index c2347e4..9bc828d 100644
--- a/kernel/sched/rt.c
+++ b/kernel/sched/rt.c
@@ -2569,6 +2569,8 @@ static int task_is_throttled_rt(struct task_struct *p, =
int cpu)
=20
 DEFINE_SCHED_CLASS(rt) =3D {
=20
+	.queue_mask		=3D 4,
+
 	.enqueue_task		=3D enqueue_task_rt,
 	.dequeue_task		=3D dequeue_task_rt,
 	.yield_task		=3D yield_task_rt,
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index e3d2710..f4a3230 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -1118,6 +1118,8 @@ struct rq {
 	/* runqueue lock: */
 	raw_spinlock_t		__lock;
=20
+	/* Per class runqueue modification mask; bits in class order. */
+	unsigned int		queue_mask;
 	unsigned int		nr_running;
 #ifdef CONFIG_NUMA_BALANCING
 	unsigned int		nr_numa_running;
@@ -2414,6 +2416,15 @@ struct sched_class {
 #ifdef CONFIG_UCLAMP_TASK
 	int uclamp_enabled;
 #endif
+	/*
+	 * idle:  0
+	 * ext:   1
+	 * fair:  2
+	 * rt:    4
+	 * dl:    8
+	 * stop: 16
+	 */
+	unsigned int queue_mask;
=20
 	/*
 	 * move_queued_task/activate_task/enqueue_task: rq->lock
@@ -2571,6 +2582,20 @@ struct sched_class {
 #endif
 };
=20
+/*
+ * Does not nest; only used around sched_class::pick_task() rq-lock-breaks.
+ */
+static inline void rq_modified_clear(struct rq *rq)
+{
+	rq->queue_mask =3D 0;
+}
+
+static inline bool rq_modified_above(struct rq *rq, const struct sched_class=
 * class)
+{
+	unsigned int mask =3D class->queue_mask;
+	return rq->queue_mask & ~((mask << 1) - 1);
+}
+
 static inline void put_prev_task(struct rq *rq, struct task_struct *prev)
 {
 	WARN_ON_ONCE(rq->donor !=3D prev);
diff --git a/kernel/sched/stop_task.c b/kernel/sched/stop_task.c
index 73aa8de..d98c453 100644
--- a/kernel/sched/stop_task.c
+++ b/kernel/sched/stop_task.c
@@ -98,6 +98,8 @@ static void update_curr_stop(struct rq *rq)
  */
 DEFINE_SCHED_CLASS(stop) =3D {
=20
+	.queue_mask		=3D 16,
+
 	.enqueue_task		=3D enqueue_task_stop,
 	.dequeue_task		=3D dequeue_task_stop,
 	.yield_task		=3D yield_task_stop,

