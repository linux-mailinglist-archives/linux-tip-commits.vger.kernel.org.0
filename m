Return-Path: <linux-tip-commits+bounces-7299-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 04676C4D724
	for <lists+linux-tip-commits@lfdr.de>; Tue, 11 Nov 2025 12:41:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 905E41899337
	for <lists+linux-tip-commits@lfdr.de>; Tue, 11 Nov 2025 11:40:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFA4D357A23;
	Tue, 11 Nov 2025 11:37:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="eaxOqs7m";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="c1qH7/Ep"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3484635971B;
	Tue, 11 Nov 2025 11:37:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762861041; cv=none; b=IkOGUePnCupx+NxuaxtvazAcRTQXgHvjJcWlisQd3J0J7qMXGfnIEOwHFvNPWXJ71TMVhUzZKWLyNzJAOo9May1W7w6FgzgXoqshDV6BrMZyBAYGZOdsXfbIQnW3n+vXbt0TNOL6swwvvQkx/DPtQHq76/hvFpPU5AnuUBX4JFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762861041; c=relaxed/simple;
	bh=4iq1x/w/6POpiIv9b52jAyI6bhfnCiFH1daobdTm310=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=snLBWRVaxZzcyA0/dQxjQqY7ByjOiPcgu8ch2HdkRxXDeM1nWRV+HAgYAY24CKW/xEpPXFgoeWd0PlwFMAVHupCmPtJbPO8mH1wGvBlpbznAEhp+aRsfLH99Oe2MNe7ltS2qsAMoTlFdFB3tFIN/WhElmirnyT3DjMumK1gyAwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=eaxOqs7m; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=c1qH7/Ep; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 11 Nov 2025 11:37:16 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1762861037;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=K6KMaKACUotsC3FXo5xj8pfROp5P4IyZ/TmrFVDwkpc=;
	b=eaxOqs7mvWh/X5ca8YVpy1AvSLrkivqKBePM9bFN0J5ICLQeWButIacUE7YAE2Aqrks5Zp
	GNxBjF4rC+encuZuGsZ1gB9hoqyV13CKNiVDvQSgpSkjY/jOqKGdWng9BNUbUOK6yw6w3u
	ihFQXL4rUD7z1hQVdgmq9VanG+wIcL5BBjQ5UoI9U/iL91z1pxusxeGDj5e0YoU23qTPTf
	LbOt1qG3CuwQ6oYgWbJaqDFbhV0SpXf66GmQbFzbj6Roy/TpdmYdJc1wEOl7RyXC90+1kp
	X0pEr7/7pedceGU6slvppCWgs5/5DeMnGvo1GL9354cxXhaarHNw3wfXIR9aRA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1762861037;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=K6KMaKACUotsC3FXo5xj8pfROp5P4IyZ/TmrFVDwkpc=;
	b=c1qH7/EpzBvnPxaXFMqYzdswSqvQ/FCnvNKdwuepjRQz2ApNiaMznXfhY3VruWmhIEOAX8
	+yoh6aV0roF0yjBw==
From: "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/deadline: Fix dl_server stop condition
Cc: Gabriele Monaco <gmonaco@redhat.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20251101000057.GA2184199@noisy.programming.kicks-ass.net>
References: <20251101000057.GA2184199@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176286103658.498.4925042436168385783.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     f5a538c07df26f5c601e41f7b9c7ade3e1e75803
Gitweb:        https://git.kernel.org/tip/f5a538c07df26f5c601e41f7b9c7ade3e1e=
75803
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Fri, 31 Oct 2025 13:54:24 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 11 Nov 2025 12:33:39 +01:00

sched/deadline: Fix dl_server stop condition

Gabriel reported that the dl_server doesn't stop as expected.

The problem was found to be the fact that idle time and fair runtime are
treated equally. Both will count towards dl_server runtime and push the
activation forwards when it is in the zero-laxity wait state.

Notably:

  dl_server_update_idle()
    update_curr_dl_se()
      if (dl_defer && dl_throttled && dl_runtime_exceeded())
        hrtimer_try_to_cancel(); // stop timer
	replenish_dl_new_period()
	  deadline =3D now + dl_deadline; // fwd period
	  runtime =3D dl_runtime;
        start_dl_timer(); // restart timer

And while we do want idle time accounted towards the *current* activation of
the dl_server -- after all, a fair task could've ran if we had any -- we don't
necessarily want idle time to cause or push forward an activation.

Introduce dl_defer_idle to make this distinction. It will be set once idle ti=
me
pushed the activation forward, once set idle time will only be allowed to
consume any runtime but not push the activation. This will then cause
dl_server_timer() to fire, which will stop the dl_server.

Any non-idle time accounting during this phase will clear dl_defer_idle, so
only a full period of idle will cause the dl_server to stop.

Reported-by: Gabriele Monaco <gmonaco@redhat.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://patch.msgid.link/20251101000057.GA2184199@noisy.programming.kic=
ks-ass.net
---
 include/linux/sched.h   | 15 +++++++++------
 kernel/sched/deadline.c | 40 ++++++++++++++++++++++++++++++++++++++--
 2 files changed, 47 insertions(+), 8 deletions(-)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index 0757647..bb436ee 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -685,20 +685,22 @@ struct sched_dl_entity {
 	 *
 	 * @dl_server tells if this is a server entity.
 	 *
-	 * @dl_defer tells if this is a deferred or regular server. For
-	 * now only defer server exists.
-	 *
-	 * @dl_defer_armed tells if the deferrable server is waiting
-	 * for the replenishment timer to activate it.
-	 *
 	 * @dl_server_active tells if the dlserver is active(started).
 	 * dlserver is started on first cfs enqueue on an idle runqueue
 	 * and is stopped when a dequeue results in 0 cfs tasks on the
 	 * runqueue. In other words, dlserver is active only when cpu's
 	 * runqueue has atleast one cfs task.
 	 *
+	 * @dl_defer tells if this is a deferred or regular server. For
+	 * now only defer server exists.
+	 *
+	 * @dl_defer_armed tells if the deferrable server is waiting
+	 * for the replenishment timer to activate it.
+	 *
 	 * @dl_defer_running tells if the deferrable server is actually
 	 * running, skipping the defer phase.
+	 *
+	 * @dl_defer_idle tracks idle state
 	 */
 	unsigned int			dl_throttled      : 1;
 	unsigned int			dl_yielded        : 1;
@@ -709,6 +711,7 @@ struct sched_dl_entity {
 	unsigned int			dl_defer	  : 1;
 	unsigned int			dl_defer_armed	  : 1;
 	unsigned int			dl_defer_running  : 1;
+	unsigned int			dl_defer_idle     : 1;
=20
 	/*
 	 * Bandwidth enforcement timer. Each -deadline task has its
diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index ece25ca..8307f24 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -1173,6 +1173,11 @@ static enum hrtimer_restart dl_server_timer(struct hrt=
imer *timer, struct sched_
 		 */
 		rq->donor->sched_class->update_curr(rq);
=20
+		if (dl_se->dl_defer_idle) {
+			dl_server_stop(dl_se);
+			return HRTIMER_NORESTART;
+		}
+
 		if (dl_se->dl_defer_armed) {
 			/*
 			 * First check if the server could consume runtime in background.
@@ -1420,10 +1425,11 @@ s64 dl_scaled_delta_exec(struct rq *rq, struct sched_=
dl_entity *dl_se, s64 delta
 }
=20
 static inline void
-update_stats_dequeue_dl(struct dl_rq *dl_rq, struct sched_dl_entity *dl_se,
-			int flags);
+update_stats_dequeue_dl(struct dl_rq *dl_rq, struct sched_dl_entity *dl_se, =
int flags);
+
 static void update_curr_dl_se(struct rq *rq, struct sched_dl_entity *dl_se, =
s64 delta_exec)
 {
+	bool idle =3D rq->curr =3D=3D rq->idle;
 	s64 scaled_delta_exec;
=20
 	if (unlikely(delta_exec <=3D 0)) {
@@ -1444,6 +1450,9 @@ static void update_curr_dl_se(struct rq *rq, struct sch=
ed_dl_entity *dl_se, s64=20
=20
 	dl_se->runtime -=3D scaled_delta_exec;
=20
+	if (dl_se->dl_defer_idle && !idle)
+		dl_se->dl_defer_idle =3D 0;
+
 	/*
 	 * The fair server can consume its runtime while throttled (not queued/
 	 * running as regular CFS).
@@ -1454,6 +1463,29 @@ static void update_curr_dl_se(struct rq *rq, struct sc=
hed_dl_entity *dl_se, s64=20
 	 */
 	if (dl_se->dl_defer && dl_se->dl_throttled && dl_runtime_exceeded(dl_se)) {
 		/*
+		 * Non-servers would never get time accounted while throttled.
+		 */
+		WARN_ON_ONCE(!dl_server(dl_se));
+
+		/*
+		 * While the server is marked idle, do not push out the
+		 * activation further, instead wait for the period timer
+		 * to lapse and stop the server.
+		 */
+		if (dl_se->dl_defer_idle && idle) {
+			/*
+			 * The timer is at the zero-laxity point, this means
+			 * dl_server_stop() / dl_server_start() can happen
+			 * while now < deadline. This means update_dl_entity()
+			 * will not replenish. Additionally start_dl_timer()
+			 * will be set for 'deadline - runtime'. Negative
+			 * runtime will not do.
+			 */
+			dl_se->runtime =3D 0;
+			return;
+		}
+
+		/*
 		 * If the server was previously activated - the starving condition
 		 * took place, it this point it went away because the fair scheduler
 		 * was able to get runtime in background. So return to the initial
@@ -1465,6 +1497,9 @@ static void update_curr_dl_se(struct rq *rq, struct sch=
ed_dl_entity *dl_se, s64=20
=20
 		replenish_dl_new_period(dl_se, dl_se->rq);
=20
+		if (idle)
+			dl_se->dl_defer_idle =3D 1;
+
 		/*
 		 * Not being able to start the timer seems problematic. If it could not
 		 * be started for whatever reason, we need to "unthrottle" the DL server
@@ -1590,6 +1625,7 @@ void dl_server_stop(struct sched_dl_entity *dl_se)
 	hrtimer_try_to_cancel(&dl_se->dl_timer);
 	dl_se->dl_defer_armed =3D 0;
 	dl_se->dl_throttled =3D 0;
+	dl_se->dl_defer_idle =3D 0;
 	dl_se->dl_server_active =3D 0;
 }
=20

