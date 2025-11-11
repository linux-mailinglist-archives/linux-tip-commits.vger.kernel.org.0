Return-Path: <linux-tip-commits+bounces-7300-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 24C1EC4D818
	for <lists+linux-tip-commits@lfdr.de>; Tue, 11 Nov 2025 12:51:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0AB083A9F4E
	for <lists+linux-tip-commits@lfdr.de>; Tue, 11 Nov 2025 11:47:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E02E35A14E;
	Tue, 11 Nov 2025 11:37:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="f5vJZFLb";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="IO4W9jIA"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44E07357A20;
	Tue, 11 Nov 2025 11:37:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762861042; cv=none; b=bZ0b75lL/KxzosGJioeeVi90lUyfmNViUa+DAgpADscUzJ1+uyWlpnWcVUgbFSwgpd+tEiG9QWM2+DSXAJk20AxcBOIwg8L/FmlIDAxPjbO+GFJeNA1uKho6Qk1BkYJgGN6TsLqH9fPMarAjYt6O0/8Llq1+0aBc5Bsn6HNJl2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762861042; c=relaxed/simple;
	bh=urXshnQLPlehlh5nTglsplxfni7RpYniQYLGv7AbBZI=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=IedO2LvSDGrAYd8Nd9My5PZeHj5mVz489xD7NMJjPHz056uCQzjHlGAFOJZUvfYtal+VzE7AA9ItevnAbKC457xIlycabn4c4ZA/CkH+fukhdW+EE+5i6E4ccoTvHrnr8kqLrpxbpLC/XleoJD4rmSLv5C8EP5QFXCnmViyZjao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=f5vJZFLb; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=IO4W9jIA; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 11 Nov 2025 11:37:17 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1762861038;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dMvMx4nticTCBWJzMv0WhmBmX7OG7Zr6AVmZNPx5u9o=;
	b=f5vJZFLbEgfy23HfczWRFhKvBBKDZE1vu/iEjXceMcyuV/A4b/9CPf33DB1BE3f/mUVTYs
	WF2ZuNb1QOUBGFScQfarVhwC5BHKGUhfACgfv7RYefczPa2Xvvz9OGVig6Ux4IskPq8jZD
	vE1+jZGB4Fzcm2XoV9fq+exfIBkEvBG2bclqMA9rmTO5OD5IT4fT9HBErOQd8CPvpTe0DI
	IipMiDxvuLI8GmGUK3fXSaYdh/UVLfLM6tW80PybSupuqgR8BdyI/y8091fH7Wjbqn+uqL
	PbIrDU3J7TH4aeBRypk0gRrrAaiRMd6ca1WPNja7kYTaGfG3ed2GA0yx3n/IzA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1762861038;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dMvMx4nticTCBWJzMv0WhmBmX7OG7Zr6AVmZNPx5u9o=;
	b=IO4W9jIAldYYKuwvA3xIA93d/kXDiQVQ6lbdGmja3x98eNMIsvUTJTOeZIrKPt7kNU3N+A
	dwhQeEQtOxQWUcCQ==
From: "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/deadline: Fix dl_server time accounting
Cc: "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20251020141130.GJ3245006@noisy.programming.kicks-ass.net>
References: <20251020141130.GJ3245006@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176286103754.498.14175426290940797285.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     e636ffb9e31b4f7dde7fef5358669266b9ce02ec
Gitweb:        https://git.kernel.org/tip/e636ffb9e31b4f7dde7fef5358669266b9c=
e02ec
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Mon, 20 Oct 2025 16:15:05 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 11 Nov 2025 12:33:38 +01:00

sched/deadline: Fix dl_server time accounting

The dl_server time accounting code is a little odd. The normal scheduler
pattern is to update curr before doing something, such that the old state is
fully accounted before changing state.

Notably, the dl_server_timer() needs to propagate the current time accounting
since the current task could be ran by dl_server and thus this can affect
dl_se->runtime. Similarly for dl_server_start().

And since the (deferred) dl_server wants idle time accounted, rework
sched_idle_class time accounting to be more like all the others.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://patch.msgid.link/20251020141130.GJ3245006@noisy.programming.kic=
ks-ass.net
---
 kernel/sched/deadline.c | 40 +++++++++++++++-------------------------
 kernel/sched/fair.c     |  9 ++-------
 kernel/sched/idle.c     | 16 +++++++++++++++-
 kernel/sched/sched.h    |  3 +--
 4 files changed, 33 insertions(+), 35 deletions(-)

diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index 13112c6..ece25ca 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -1166,8 +1166,12 @@ static enum hrtimer_restart dl_server_timer(struct hrt=
imer *timer, struct sched_
 		sched_clock_tick();
 		update_rq_clock(rq);
=20
-		if (!dl_se->dl_runtime)
-			return HRTIMER_NORESTART;
+		/*
+		 * Make sure current has propagated its pending runtime into
+		 * any relevant server through calling dl_server_update() and
+		 * friends.
+		 */
+		rq->donor->sched_class->update_curr(rq);
=20
 		if (dl_se->dl_defer_armed) {
 			/*
@@ -1543,35 +1547,16 @@ throttle:
  * as time available for the fair server, avoiding a penalty for the
  * rt scheduler that did not consumed that time.
  */
-void dl_server_update_idle_time(struct rq *rq, struct task_struct *p)
+void dl_server_update_idle(struct sched_dl_entity *dl_se, s64 delta_exec)
 {
-	s64 delta_exec;
-
-	if (!rq->fair_server.dl_defer)
-		return;
-
-	/* no need to discount more */
-	if (rq->fair_server.runtime < 0)
-		return;
-
-	delta_exec =3D rq_clock_task(rq) - p->se.exec_start;
-	if (delta_exec < 0)
-		return;
-
-	rq->fair_server.runtime -=3D delta_exec;
-
-	if (rq->fair_server.runtime < 0) {
-		rq->fair_server.dl_defer_running =3D 0;
-		rq->fair_server.runtime =3D 0;
-	}
-
-	p->se.exec_start =3D rq_clock_task(rq);
+	if (dl_se->dl_server_active && dl_se->dl_runtime && dl_se->dl_defer)
+		update_curr_dl_se(dl_se->rq, dl_se, delta_exec);
 }
=20
 void dl_server_update(struct sched_dl_entity *dl_se, s64 delta_exec)
 {
 	/* 0 runtime =3D fair server disabled */
-	if (dl_se->dl_runtime)
+	if (dl_se->dl_server_active && dl_se->dl_runtime)
 		update_curr_dl_se(dl_se->rq, dl_se, delta_exec);
 }
=20
@@ -1582,6 +1567,11 @@ void dl_server_start(struct sched_dl_entity *dl_se)
 	if (!dl_server(dl_se) || dl_se->dl_server_active)
 		return;
=20
+	/*
+	 * Update the current task to 'now'.
+	 */
+	rq->donor->sched_class->update_curr(rq);
+
 	if (WARN_ON_ONCE(!cpu_online(cpu_of(rq))))
 		return;
=20
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 8d971d4..b4617d6 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -1212,8 +1212,7 @@ static void update_curr(struct cfs_rq *cfs_rq)
 		 *    against fair_server such that it can account for this time
 		 *    and possibly avoid running this period.
 		 */
-		if (dl_server_active(&rq->fair_server))
-			dl_server_update(&rq->fair_server, delta_exec);
+		dl_server_update(&rq->fair_server, delta_exec);
 	}
=20
 	account_cfs_rq_runtime(cfs_rq, delta_exec);
@@ -6961,12 +6960,8 @@ enqueue_task_fair(struct rq *rq, struct task_struct *p=
, int flags)
 			h_nr_idle =3D 1;
 	}
=20
-	if (!rq_h_nr_queued && rq->cfs.h_nr_queued) {
-		/* Account for idle runtime */
-		if (!rq->nr_running)
-			dl_server_update_idle_time(rq, rq->curr);
+	if (!rq_h_nr_queued && rq->cfs.h_nr_queued)
 		dl_server_start(&rq->fair_server);
-	}
=20
 	/* At this point se is NULL and we are at root level*/
 	add_nr_running(rq, 1);
diff --git a/kernel/sched/idle.c b/kernel/sched/idle.c
index 7fa0b59..1cb7a3d 100644
--- a/kernel/sched/idle.c
+++ b/kernel/sched/idle.c
@@ -452,9 +452,11 @@ static void wakeup_preempt_idle(struct rq *rq, struct ta=
sk_struct *p, int flags)
 	resched_curr(rq);
 }
=20
+static void update_curr_idle(struct rq *rq);
+
 static void put_prev_task_idle(struct rq *rq, struct task_struct *prev, stru=
ct task_struct *next)
 {
-	dl_server_update_idle_time(rq, prev);
+	update_curr_idle(rq);
 	scx_update_idle(rq, false, true);
 }
=20
@@ -496,6 +498,7 @@ dequeue_task_idle(struct rq *rq, struct task_struct *p, i=
nt flags)
  */
 static void task_tick_idle(struct rq *rq, struct task_struct *curr, int queu=
ed)
 {
+	update_curr_idle(rq);
 }
=20
 static void switching_to_idle(struct rq *rq, struct task_struct *p)
@@ -514,6 +517,17 @@ prio_changed_idle(struct rq *rq, struct task_struct *p, =
u64 oldprio)
=20
 static void update_curr_idle(struct rq *rq)
 {
+	struct sched_entity *se =3D &rq->idle->se;
+	u64 now =3D rq_clock_task(rq);
+	s64 delta_exec;
+
+	delta_exec =3D now - se->exec_start;
+	if (unlikely(delta_exec <=3D 0))
+		return;
+
+	se->exec_start =3D now;
+
+	dl_server_update_idle(&rq->fair_server, delta_exec);
 }
=20
 /*
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 5a3cf81..def9ab7 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -404,6 +404,7 @@ extern s64 dl_scaled_delta_exec(struct rq *rq, struct sch=
ed_dl_entity *dl_se, s6
  * naturally thottled to once per period, avoiding high context switch
  * workloads from spamming the hrtimer program/cancel paths.
  */
+extern void dl_server_update_idle(struct sched_dl_entity *dl_se, s64 delta_e=
xec);
 extern void dl_server_update(struct sched_dl_entity *dl_se, s64 delta_exec);
 extern void dl_server_start(struct sched_dl_entity *dl_se);
 extern void dl_server_stop(struct sched_dl_entity *dl_se);
@@ -411,8 +412,6 @@ extern void dl_server_init(struct sched_dl_entity *dl_se,=
 struct rq *rq,
 		    dl_server_pick_f pick_task);
 extern void sched_init_dl_servers(void);
=20
-extern void dl_server_update_idle_time(struct rq *rq,
-		    struct task_struct *p);
 extern void fair_server_init(struct rq *rq);
 extern void __dl_server_attach_root(struct sched_dl_entity *dl_se, struct rq=
 *rq);
 extern int dl_server_apply_params(struct sched_dl_entity *dl_se,

