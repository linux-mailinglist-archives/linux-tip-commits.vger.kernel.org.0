Return-Path: <linux-tip-commits+bounces-1797-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 18A0693F2D5
	for <lists+linux-tip-commits@lfdr.de>; Mon, 29 Jul 2024 12:35:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3AF061C21C58
	for <lists+linux-tip-commits@lfdr.de>; Mon, 29 Jul 2024 10:35:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E90B142E60;
	Mon, 29 Jul 2024 10:34:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="qNBGXLLR";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="kUtPSExk"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2ABD1448F1;
	Mon, 29 Jul 2024 10:34:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722249249; cv=none; b=b1DyD92sOk9R+rPBFz8SIpPUCLRrRTTpHYTbMFEnKooq4TjunLYNNqSq5dqV37Q1WgKx55B1LMQ6naCb2cFhvOGKDvRizZGTmZfOVGWKv/2jEyZ20UL0CbIrYJ1WTngA32gGV0/EsHwvXc+D3VB4Ihr6HQztFkhMNtxuoWuzOwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722249249; c=relaxed/simple;
	bh=40yJUPpl4ogaHUr69DbrginbWc5J9fl0ZRsBI1RnvwU=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=j1n5aZWTGa3IZyLjG+fO1NPBJfoZiOCygBTGtxY8OqqLB5nByiimCcmvdq1seaDxxztiJl5gCu+waZpRMiv1xc1jRu0E550kZqt1F1tZ83ovjpYNXMddQ8BghG2o4uhydA95vVr3I9Gy0gidtssLxlWpT33vuzcmi+wszDSbWQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=qNBGXLLR; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=kUtPSExk; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 29 Jul 2024 10:34:03 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1722249244;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3MnW7Hz7iwecCfe96rZTc4oaJp1SlM/skQ52HnoiVj4=;
	b=qNBGXLLR97+JZpoAzq/UWAo/6lOSVYuCeiCGFIf/4l0w2w8nfYAT30ynBd8DzLs2SwCC0m
	pJTD4FdfgmcqIquykEtoIlscyWFHqux/3/kyKT264qtUeVDFYyQE6pKWx+VpJpYZECQ1sm
	jh5sFLzxsQ+hx6qOZ3wq0SyrTPcq3/A+ghZ/UOhgC1hgQR8fY7iJeA5q9qoEsP3Hq0AAud
	vubcHQ4Bdx6TkZxDethhlXw1+Ps5GoAKpX0AdV8EgF0Yl8yebkkdC5DU8Dn4KMFUnXLwQl
	+YT3cXF7YPBTLmEcMbVSn+Jr8DxyNMAv1dnyxUXQdtQAtpbJnE9PWNZbSSCpOw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1722249244;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3MnW7Hz7iwecCfe96rZTc4oaJp1SlM/skQ52HnoiVj4=;
	b=kUtPSExkApB0SOuNByHxEwLlO3pxuBFdLgb6AMCrzJDDMoK6E2SNUwFjmcIn1ZA9CT3pGt
	zaOJUip5pT+doPDQ==
From: "tip-bot2 for Daniel Bristot de Oliveira" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/deadline: Deferrable dl server
Cc: Daniel Bristot de Oliveira <bristot@kernel.org>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Juri Lelli <juri.lelli@redhat.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To:
 <dd175943c72533cd9f0b87767c6499204879cc38.1716811044.git.bristot@kernel.org>
References:
 <dd175943c72533cd9f0b87767c6499204879cc38.1716811044.git.bristot@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172224924396.2215.3885071729330734.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     a110a81c52a9de73e2e57e826dd3bf0fd4c22226
Gitweb:        https://git.kernel.org/tip/a110a81c52a9de73e2e57e826dd3bf0fd4c22226
Author:        Daniel Bristot de Oliveira <bristot@kernel.org>
AuthorDate:    Mon, 27 May 2024 14:06:51 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 29 Jul 2024 12:22:36 +02:00

sched/deadline: Deferrable dl server

Among the motivations for the DL servers is the real-time throttling
mechanism. This mechanism works by throttling the rt_rq after
running for a long period without leaving space for fair tasks.

The base dl server avoids this problem by boosting fair tasks instead
of throttling the rt_rq. The point is that it boosts without waiting
for potential starvation, causing some non-intuitive cases.

For example, an IRQ dispatches two tasks on an idle system, a fair
and an RT. The DL server will be activated, running the fair task
before the RT one. This problem can be avoided by deferring the
dl server activation.

By setting the defer option, the dl_server will dispatch an
SCHED_DEADLINE reservation with replenished runtime, but throttled.

The dl_timer will be set for the defer time at (period - runtime) ns
from start time. Thus boosting the fair rq at defer time.

If the fair scheduler has the opportunity to run while waiting
for defer time, the dl server runtime will be consumed. If
the runtime is completely consumed before the defer time, the
server will be replenished while still in a throttled state. Then,
the dl_timer will be reset to the new defer time

If the fair server reaches the defer time without consuming
its runtime, the server will start running, following CBS rules
(thus without breaking SCHED_DEADLINE). Then the server will
continue the running state (without deferring) until it fair
tasks are able to execute as regular fair scheduler (end of
the starvation).

Signed-off-by: Daniel Bristot de Oliveira <bristot@kernel.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Tested-by: Juri Lelli <juri.lelli@redhat.com>
Link: https://lore.kernel.org/r/dd175943c72533cd9f0b87767c6499204879cc38.1716811044.git.bristot@kernel.org
---
 include/linux/sched.h   |  12 ++-
 kernel/sched/deadline.c | 301 +++++++++++++++++++++++++++++++++------
 kernel/sched/fair.c     |  24 ++-
 kernel/sched/idle.c     |   2 +-
 kernel/sched/sched.h    |   4 +-
 5 files changed, 298 insertions(+), 45 deletions(-)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index 1c771ea..4edd7e2 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -641,12 +641,24 @@ struct sched_dl_entity {
 	 * overruns.
 	 *
 	 * @dl_server tells if this is a server entity.
+	 *
+	 * @dl_defer tells if this is a deferred or regular server. For
+	 * now only defer server exists.
+	 *
+	 * @dl_defer_armed tells if the deferrable server is waiting
+	 * for the replenishment timer to activate it.
+	 *
+	 * @dl_defer_running tells if the deferrable server is actually
+	 * running, skipping the defer phase.
 	 */
 	unsigned int			dl_throttled      : 1;
 	unsigned int			dl_yielded        : 1;
 	unsigned int			dl_non_contending : 1;
 	unsigned int			dl_overrun	  : 1;
 	unsigned int			dl_server         : 1;
+	unsigned int			dl_defer	  : 1;
+	unsigned int			dl_defer_armed	  : 1;
+	unsigned int			dl_defer_running  : 1;
 
 	/*
 	 * Bandwidth enforcement timer. Each -deadline task has its
diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index f5b5313..1b29531 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -771,6 +771,15 @@ static inline void replenish_dl_new_period(struct sched_dl_entity *dl_se,
 	/* for non-boosted task, pi_of(dl_se) == dl_se */
 	dl_se->deadline = rq_clock(rq) + pi_of(dl_se)->dl_deadline;
 	dl_se->runtime = pi_of(dl_se)->dl_runtime;
+
+	/*
+	 * If it is a deferred reservation, and the server
+	 * is not handling an starvation case, defer it.
+	 */
+	if (dl_se->dl_defer & !dl_se->dl_defer_running) {
+		dl_se->dl_throttled = 1;
+		dl_se->dl_defer_armed = 1;
+	}
 }
 
 /*
@@ -809,6 +818,9 @@ static inline void setup_new_dl_entity(struct sched_dl_entity *dl_se)
 	replenish_dl_new_period(dl_se, rq);
 }
 
+static int start_dl_timer(struct sched_dl_entity *dl_se);
+static bool dl_entity_overflow(struct sched_dl_entity *dl_se, u64 t);
+
 /*
  * Pure Earliest Deadline First (EDF) scheduling does not deal with the
  * possibility of a entity lasting more than what it declared, and thus
@@ -837,9 +849,18 @@ static void replenish_dl_entity(struct sched_dl_entity *dl_se)
 	/*
 	 * This could be the case for a !-dl task that is boosted.
 	 * Just go with full inherited parameters.
+	 *
+	 * Or, it could be the case of a deferred reservation that
+	 * was not able to consume its runtime in background and
+	 * reached this point with current u > U.
+	 *
+	 * In both cases, set a new period.
 	 */
-	if (dl_se->dl_deadline == 0)
-		replenish_dl_new_period(dl_se, rq);
+	if (dl_se->dl_deadline == 0 ||
+	    (dl_se->dl_defer_armed && dl_entity_overflow(dl_se, rq_clock(rq)))) {
+		dl_se->deadline = rq_clock(rq) + pi_of(dl_se)->dl_deadline;
+		dl_se->runtime = pi_of(dl_se)->dl_runtime;
+	}
 
 	if (dl_se->dl_yielded && dl_se->runtime > 0)
 		dl_se->runtime = 0;
@@ -873,6 +894,44 @@ static void replenish_dl_entity(struct sched_dl_entity *dl_se)
 		dl_se->dl_yielded = 0;
 	if (dl_se->dl_throttled)
 		dl_se->dl_throttled = 0;
+
+	/*
+	 * If this is the replenishment of a deferred reservation,
+	 * clear the flag and return.
+	 */
+	if (dl_se->dl_defer_armed) {
+		dl_se->dl_defer_armed = 0;
+		return;
+	}
+
+	/*
+	 * A this point, if the deferred server is not armed, and the deadline
+	 * is in the future, if it is not running already, throttle the server
+	 * and arm the defer timer.
+	 */
+	if (dl_se->dl_defer && !dl_se->dl_defer_running &&
+	    dl_time_before(rq_clock(dl_se->rq), dl_se->deadline - dl_se->runtime)) {
+		if (!is_dl_boosted(dl_se) && dl_se->server_has_tasks(dl_se)) {
+
+			/*
+			 * Set dl_se->dl_defer_armed and dl_throttled variables to
+			 * inform the start_dl_timer() that this is a deferred
+			 * activation.
+			 */
+			dl_se->dl_defer_armed = 1;
+			dl_se->dl_throttled = 1;
+			if (!start_dl_timer(dl_se)) {
+				/*
+				 * If for whatever reason (delays), a previous timer was
+				 * queued but not serviced, cancel it and clean the
+				 * deferrable server variables intended for start_dl_timer().
+				 */
+				hrtimer_try_to_cancel(&dl_se->dl_timer);
+				dl_se->dl_defer_armed = 0;
+				dl_se->dl_throttled = 0;
+			}
+		}
+	}
 }
 
 /*
@@ -1023,6 +1082,15 @@ static void update_dl_entity(struct sched_dl_entity *dl_se)
 		}
 
 		replenish_dl_new_period(dl_se, rq);
+	} else if (dl_server(dl_se) && dl_se->dl_defer) {
+		/*
+		 * The server can still use its previous deadline, so check if
+		 * it left the dl_defer_running state.
+		 */
+		if (!dl_se->dl_defer_running) {
+			dl_se->dl_defer_armed = 1;
+			dl_se->dl_throttled = 1;
+		}
 	}
 }
 
@@ -1055,8 +1123,21 @@ static int start_dl_timer(struct sched_dl_entity *dl_se)
 	 * We want the timer to fire at the deadline, but considering
 	 * that it is actually coming from rq->clock and not from
 	 * hrtimer's time base reading.
+	 *
+	 * The deferred reservation will have its timer set to
+	 * (deadline - runtime). At that point, the CBS rule will decide
+	 * if the current deadline can be used, or if a replenishment is
+	 * required to avoid add too much pressure on the system
+	 * (current u > U).
 	 */
-	act = ns_to_ktime(dl_next_period(dl_se));
+	if (dl_se->dl_defer_armed) {
+		WARN_ON_ONCE(!dl_se->dl_throttled);
+		act = ns_to_ktime(dl_se->deadline - dl_se->runtime);
+	} else {
+		/* act = deadline - rel-deadline + period */
+		act = ns_to_ktime(dl_next_period(dl_se));
+	}
+
 	now = hrtimer_cb_get_time(timer);
 	delta = ktime_to_ns(now) - rq_clock(rq);
 	act = ktime_add_ns(act, delta);
@@ -1106,6 +1187,62 @@ static void __push_dl_task(struct rq *rq, struct rq_flags *rf)
 #endif
 }
 
+/* a defer timer will not be reset if the runtime consumed was < dl_server_min_res */
+static const u64 dl_server_min_res = 1 * NSEC_PER_MSEC;
+
+static enum hrtimer_restart dl_server_timer(struct hrtimer *timer, struct sched_dl_entity *dl_se)
+{
+	struct rq *rq = rq_of_dl_se(dl_se);
+	u64 fw;
+
+	scoped_guard (rq_lock, rq) {
+		struct rq_flags *rf = &scope.rf;
+
+		if (!dl_se->dl_throttled || !dl_se->dl_runtime)
+			return HRTIMER_NORESTART;
+
+		sched_clock_tick();
+		update_rq_clock(rq);
+
+		if (!dl_se->dl_runtime)
+			return HRTIMER_NORESTART;
+
+		if (!dl_se->server_has_tasks(dl_se)) {
+			replenish_dl_entity(dl_se);
+			return HRTIMER_NORESTART;
+		}
+
+		if (dl_se->dl_defer_armed) {
+			/*
+			 * First check if the server could consume runtime in background.
+			 * If so, it is possible to push the defer timer for this amount
+			 * of time. The dl_server_min_res serves as a limit to avoid
+			 * forwarding the timer for a too small amount of time.
+			 */
+			if (dl_time_before(rq_clock(dl_se->rq),
+					   (dl_se->deadline - dl_se->runtime - dl_server_min_res))) {
+
+				/* reset the defer timer */
+				fw = dl_se->deadline - rq_clock(dl_se->rq) - dl_se->runtime;
+
+				hrtimer_forward_now(timer, ns_to_ktime(fw));
+				return HRTIMER_RESTART;
+			}
+
+			dl_se->dl_defer_running = 1;
+		}
+
+		enqueue_dl_entity(dl_se, ENQUEUE_REPLENISH);
+
+		if (!dl_task(dl_se->rq->curr) || dl_entity_preempt(dl_se, &dl_se->rq->curr->dl))
+			resched_curr(rq);
+
+		__push_dl_task(rq, rf);
+	}
+
+	return HRTIMER_NORESTART;
+}
+
 /*
  * This is the bandwidth enforcement timer callback. If here, we know
  * a task is not on its dl_rq, since the fact that the timer was running
@@ -1128,28 +1265,8 @@ static enum hrtimer_restart dl_task_timer(struct hrtimer *timer)
 	struct rq_flags rf;
 	struct rq *rq;
 
-	if (dl_server(dl_se)) {
-		struct rq *rq = rq_of_dl_se(dl_se);
-		struct rq_flags rf;
-
-		rq_lock(rq, &rf);
-		if (dl_se->dl_throttled) {
-			sched_clock_tick();
-			update_rq_clock(rq);
-
-			if (dl_se->server_has_tasks(dl_se)) {
-				enqueue_dl_entity(dl_se, ENQUEUE_REPLENISH);
-				resched_curr(rq);
-				__push_dl_task(rq, &rf);
-			} else {
-				replenish_dl_entity(dl_se);
-			}
-
-		}
-		rq_unlock(rq, &rf);
-
-		return HRTIMER_NORESTART;
-	}
+	if (dl_server(dl_se))
+		return dl_server_timer(timer, dl_se);
 
 	p = dl_task_of(dl_se);
 	rq = task_rq_lock(p, &rf);
@@ -1319,22 +1436,10 @@ static u64 grub_reclaim(u64 delta, struct rq *rq, struct sched_dl_entity *dl_se)
 	return (delta * u_act) >> BW_SHIFT;
 }
 
-static inline void
-update_stats_dequeue_dl(struct dl_rq *dl_rq, struct sched_dl_entity *dl_se,
-                        int flags);
-static void update_curr_dl_se(struct rq *rq, struct sched_dl_entity *dl_se, s64 delta_exec)
+s64 dl_scaled_delta_exec(struct rq *rq, struct sched_dl_entity *dl_se, s64 delta_exec)
 {
 	s64 scaled_delta_exec;
 
-	if (unlikely(delta_exec <= 0)) {
-		if (unlikely(dl_se->dl_yielded))
-			goto throttle;
-		return;
-	}
-
-	if (dl_entity_is_special(dl_se))
-		return;
-
 	/*
 	 * For tasks that participate in GRUB, we implement GRUB-PA: the
 	 * spare reclaimed bandwidth is used to clock down frequency.
@@ -1353,8 +1458,64 @@ static void update_curr_dl_se(struct rq *rq, struct sched_dl_entity *dl_se, s64 
 		scaled_delta_exec = cap_scale(scaled_delta_exec, scale_cpu);
 	}
 
+	return scaled_delta_exec;
+}
+
+static inline void
+update_stats_dequeue_dl(struct dl_rq *dl_rq, struct sched_dl_entity *dl_se,
+			int flags);
+static void update_curr_dl_se(struct rq *rq, struct sched_dl_entity *dl_se, s64 delta_exec)
+{
+	s64 scaled_delta_exec;
+
+	if (unlikely(delta_exec <= 0)) {
+		if (unlikely(dl_se->dl_yielded))
+			goto throttle;
+		return;
+	}
+
+	if (dl_server(dl_se) && dl_se->dl_throttled && !dl_se->dl_defer)
+		return;
+
+	if (dl_entity_is_special(dl_se))
+		return;
+
+	scaled_delta_exec = dl_scaled_delta_exec(rq, dl_se, delta_exec);
+
 	dl_se->runtime -= scaled_delta_exec;
 
+	/*
+	 * The fair server can consume its runtime while throttled (not queued/
+	 * running as regular CFS).
+	 *
+	 * If the server consumes its entire runtime in this state. The server
+	 * is not required for the current period. Thus, reset the server by
+	 * starting a new period, pushing the activation.
+	 */
+	if (dl_se->dl_defer && dl_se->dl_throttled && dl_runtime_exceeded(dl_se)) {
+		/*
+		 * If the server was previously activated - the starving condition
+		 * took place, it this point it went away because the fair scheduler
+		 * was able to get runtime in background. So return to the initial
+		 * state.
+		 */
+		dl_se->dl_defer_running = 0;
+
+		hrtimer_try_to_cancel(&dl_se->dl_timer);
+
+		replenish_dl_new_period(dl_se, dl_se->rq);
+
+		/*
+		 * Not being able to start the timer seems problematic. If it could not
+		 * be started for whatever reason, we need to "unthrottle" the DL server
+		 * and queue right away. Otherwise nothing might queue it. That's similar
+		 * to what enqueue_dl_entity() does on start_dl_timer==0. For now, just warn.
+		 */
+		WARN_ON_ONCE(!start_dl_timer(dl_se));
+
+		return;
+	}
+
 throttle:
 	if (dl_runtime_exceeded(dl_se) || dl_se->dl_yielded) {
 		dl_se->dl_throttled = 1;
@@ -1414,9 +1575,46 @@ throttle:
 	}
 }
 
+/*
+ * In the non-defer mode, the idle time is not accounted, as the
+ * server provides a guarantee.
+ *
+ * If the dl_server is in defer mode, the idle time is also considered
+ * as time available for the fair server, avoiding a penalty for the
+ * rt scheduler that did not consumed that time.
+ */
+void dl_server_update_idle_time(struct rq *rq, struct task_struct *p)
+{
+	s64 delta_exec, scaled_delta_exec;
+
+	if (!rq->fair_server.dl_defer)
+		return;
+
+	/* no need to discount more */
+	if (rq->fair_server.runtime < 0)
+		return;
+
+	delta_exec = rq_clock_task(rq) - p->se.exec_start;
+	if (delta_exec < 0)
+		return;
+
+	scaled_delta_exec = dl_scaled_delta_exec(rq, &rq->fair_server, delta_exec);
+
+	rq->fair_server.runtime -= scaled_delta_exec;
+
+	if (rq->fair_server.runtime < 0) {
+		rq->fair_server.dl_defer_running = 0;
+		rq->fair_server.runtime = 0;
+	}
+
+	p->se.exec_start = rq_clock_task(rq);
+}
+
 void dl_server_update(struct sched_dl_entity *dl_se, s64 delta_exec)
 {
-	update_curr_dl_se(dl_se->rq, dl_se, delta_exec);
+	/* 0 runtime = fair server disabled */
+	if (dl_se->dl_runtime)
+		update_curr_dl_se(dl_se->rq, dl_se, delta_exec);
 }
 
 void dl_server_start(struct sched_dl_entity *dl_se)
@@ -1430,6 +1628,7 @@ void dl_server_start(struct sched_dl_entity *dl_se)
 		dl_se->dl_period = 1000 * NSEC_PER_MSEC;
 
 		dl_se->dl_server = 1;
+		dl_se->dl_defer = 1;
 		setup_new_dl_entity(dl_se);
 	}
 
@@ -1447,6 +1646,9 @@ void dl_server_stop(struct sched_dl_entity *dl_se)
 		return;
 
 	dequeue_dl_entity(dl_se, DEQUEUE_SLEEP);
+	hrtimer_try_to_cancel(&dl_se->dl_timer);
+	dl_se->dl_defer_armed = 0;
+	dl_se->dl_throttled = 0;
 }
 
 void dl_server_init(struct sched_dl_entity *dl_se, struct rq *rq,
@@ -1758,7 +1960,7 @@ enqueue_dl_entity(struct sched_dl_entity *dl_se, int flags)
 	 * be counted in the active utilization; hence, we need to call
 	 * add_running_bw().
 	 */
-	if (dl_se->dl_throttled && !(flags & ENQUEUE_REPLENISH)) {
+	if (!dl_se->dl_defer && dl_se->dl_throttled && !(flags & ENQUEUE_REPLENISH)) {
 		if (flags & ENQUEUE_WAKEUP)
 			task_contending(dl_se, flags);
 
@@ -1780,6 +1982,25 @@ enqueue_dl_entity(struct sched_dl_entity *dl_se, int flags)
 		setup_new_dl_entity(dl_se);
 	}
 
+	/*
+	 * If the reservation is still throttled, e.g., it got replenished but is a
+	 * deferred task and still got to wait, don't enqueue.
+	 */
+	if (dl_se->dl_throttled && start_dl_timer(dl_se))
+		return;
+
+	/*
+	 * We're about to enqueue, make sure we're not ->dl_throttled!
+	 * In case the timer was not started, say because the defer time
+	 * has passed, mark as not throttled and mark unarmed.
+	 * Also cancel earlier timers, since letting those run is pointless.
+	 */
+	if (dl_se->dl_throttled) {
+		hrtimer_try_to_cancel(&dl_se->dl_timer);
+		dl_se->dl_defer_armed = 0;
+		dl_se->dl_throttled = 0;
+	}
+
 	__enqueue_dl_entity(dl_se);
 }
 
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index aba23b0..1ea5ec8 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -1156,12 +1156,13 @@ s64 update_curr_common(struct rq *rq)
 static void update_curr(struct cfs_rq *cfs_rq)
 {
 	struct sched_entity *curr = cfs_rq->curr;
+	struct rq *rq = rq_of(cfs_rq);
 	s64 delta_exec;
 
 	if (unlikely(!curr))
 		return;
 
-	delta_exec = update_curr_se(rq_of(cfs_rq), curr);
+	delta_exec = update_curr_se(rq, curr);
 	if (unlikely(delta_exec <= 0))
 		return;
 
@@ -1169,8 +1170,19 @@ static void update_curr(struct cfs_rq *cfs_rq)
 	update_deadline(cfs_rq, curr);
 	update_min_vruntime(cfs_rq);
 
-	if (entity_is_task(curr))
-		update_curr_task(task_of(curr), delta_exec);
+	if (entity_is_task(curr)) {
+		struct task_struct *p = task_of(curr);
+
+		update_curr_task(p, delta_exec);
+
+		/*
+		 * Any fair task that runs outside of fair_server should
+		 * account against fair_server such that it can account for
+		 * this time and possibly avoid running this period.
+		 */
+		if (p->dl_server != &rq->fair_server)
+			dl_server_update(&rq->fair_server, delta_exec);
+	}
 
 	account_cfs_rq_runtime(cfs_rq, delta_exec);
 }
@@ -6768,8 +6780,12 @@ enqueue_task_fair(struct rq *rq, struct task_struct *p, int flags)
 	 */
 	util_est_enqueue(&rq->cfs, p);
 
-	if (!throttled_hierarchy(task_cfs_rq(p)) && !rq->cfs.h_nr_running)
+	if (!throttled_hierarchy(task_cfs_rq(p)) && !rq->cfs.h_nr_running) {
+		/* Account for idle runtime */
+		if (!rq->nr_running)
+			dl_server_update_idle_time(rq, rq->curr);
 		dl_server_start(&rq->fair_server);
+	}
 
 	/*
 	 * If in_iowait is set, the code below may not trigger any cpufreq
diff --git a/kernel/sched/idle.c b/kernel/sched/idle.c
index 6e78d07..d560f7f 100644
--- a/kernel/sched/idle.c
+++ b/kernel/sched/idle.c
@@ -452,12 +452,14 @@ static void wakeup_preempt_idle(struct rq *rq, struct task_struct *p, int flags)
 
 static void put_prev_task_idle(struct rq *rq, struct task_struct *prev)
 {
+	dl_server_update_idle_time(rq, prev);
 }
 
 static void set_next_task_idle(struct rq *rq, struct task_struct *next, bool first)
 {
 	update_idle_core(rq);
 	schedstat_inc(rq->sched_goidle);
+	next->se.exec_start = rq_clock_task(rq);
 }
 
 #ifdef CONFIG_SMP
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 7416bcd..64fb677 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -335,7 +335,7 @@ extern bool __checkparam_dl(const struct sched_attr *attr);
 extern bool dl_param_changed(struct task_struct *p, const struct sched_attr *attr);
 extern int  dl_cpuset_cpumask_can_shrink(const struct cpumask *cur, const struct cpumask *trial);
 extern int  dl_bw_check_overflow(int cpu);
-
+extern s64 dl_scaled_delta_exec(struct rq *rq, struct sched_dl_entity *dl_se, s64 delta_exec);
 /*
  * SCHED_DEADLINE supports servers (nested scheduling) with the following
  * interface:
@@ -363,6 +363,8 @@ extern void dl_server_init(struct sched_dl_entity *dl_se, struct rq *rq,
 		    dl_server_has_tasks_f has_tasks,
 		    dl_server_pick_f pick);
 
+extern void dl_server_update_idle_time(struct rq *rq,
+		    struct task_struct *p);
 extern void fair_server_init(struct rq *rq);
 
 #ifdef CONFIG_CGROUP_SCHED

