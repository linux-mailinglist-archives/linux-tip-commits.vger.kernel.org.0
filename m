Return-Path: <linux-tip-commits+bounces-6716-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 93C64B9DEE9
	for <lists+linux-tip-commits@lfdr.de>; Thu, 25 Sep 2025 09:56:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9D1C73BC025
	for <lists+linux-tip-commits@lfdr.de>; Thu, 25 Sep 2025 07:56:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3FAD2E172E;
	Thu, 25 Sep 2025 07:56:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="T60BQXtW";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="mNRwgtZM"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1BC7265CBB;
	Thu, 25 Sep 2025 07:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758786966; cv=none; b=bsBU7yTLf8TmY85T6EvQc9g0ppENvOMfMxkoMI9MKXrWzL2ZJgmDT54pFGCL/zJpnYNh4A4oBNuX2kjPVvrZTg7XcG0Ju9kNMjfbj0kUhO9rkGL9V63YpZnLDrrcYJEPu/KTtEuL0anBiIxea+oCSv/2dhrU5Vl4S6zSm14X9ic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758786966; c=relaxed/simple;
	bh=D4J9s7QIL3AsZCZrapl8ew7Ezn82rbAYZ2a3SuR9DuI=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=DBf/12PiTt2H28MZe9zLPOy2upp+C9OzvgRANWK6RDyGVHWQJHnNb3yvJVKUYM0s75SUBKZLk88+1iP584PMFTB4h6IQJnxIsVyleS5lWRR/+EsJS7sHe6diCMMVZl5Vxasb9TkTAQTWcrjjF4iL3ZCw5GMkNH6/ZunbSwHvFOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=T60BQXtW; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=mNRwgtZM; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 25 Sep 2025 07:55:51 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1758786956;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3geGu4Wj097Gx6j6IJpzDEdbIfvxlcKAtNwJPRJ0pLI=;
	b=T60BQXtWK8lnADmhr3HJ2yEyXXZcqRhc1YKLUrOrk0CC6REvvObObD1fJyGvyqUxGm7RMc
	Zapp/x93NMtU5O1nyAcwdFEJN2oMz/s6pMwNmOAUNptXNyNy1czrQK+7D3DNEXfmhBBALX
	bYSaLY340tVsQYRGbLOkE/og8uxC7ouNgXIuZk7SlUHb8jmrzCsUDi5V9MMqRWKF/DZKtt
	Dvf/nlPhhFtPpMbnDrQeFAPjvC2hT1IeeD4MyLeNLh/5erwyaCXLX3YQsygV9qwRm+r4Xf
	pVwkOL4sQ68IT60UNLflOEgDoq31Oi6r6SgWaj1d+XLdGGjB/3kKUMX9IjbUXA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1758786956;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3geGu4Wj097Gx6j6IJpzDEdbIfvxlcKAtNwJPRJ0pLI=;
	b=mNRwgtZMrENw3A6+opT8PylZ8BFDzd7iq4fb5qPgqfF/zMxuF6GqmPYaXzp9agEEnThwnv
	tQvUiv+GudPPugBw==
From: "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: sched/urgent] sched/deadline: Fix dl_server behaviour
Cc: John Stultz <jstultz@google.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250917122616.GG1386988@noisy.programming.kicks-ass.net>
References: <20250917122616.GG1386988@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175878695126.709179.2478529191908747938.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the sched/urgent branch of tip:

Commit-ID:     a3a70caf7906708bf9bbc80018752a6b36543808
Gitweb:        https://git.kernel.org/tip/a3a70caf7906708bf9bbc80018752a6b365=
43808
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Wed, 17 Sep 2025 12:03:20 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Thu, 25 Sep 2025 09:51:50 +02:00

sched/deadline: Fix dl_server behaviour

John reported undesirable behaviour with the dl_server since commit:
cccb45d7c4295 ("sched/deadline: Less agressive dl_server handling").

When starving fair tasks on purpose (starting spinning FIFO tasks),
his fair workload, which often goes (briefly) idle, would delay fair
invocations for a second, running one invocation per second was both
unexpected and terribly slow.

The reason this happens is that when dl_se->server_pick_task() returns
NULL, indicating no runnable tasks, it would yield, pushing any later
jobs out a whole period (1 second).

Instead simply stop the server. This should restore behaviour in that
a later wakeup (which restarts the server) will be able to continue
running (subject to the CBS wakeup rules).

Notably, this does not re-introduce the behaviour cccb45d7c4295 set
out to solve, any start/stop cycle is naturally throttled by the timer
period (no active cancel).

Fixes: cccb45d7c4295 ("sched/deadline: Less agressive dl_server handling")
Reported-by: John Stultz <jstultz@google.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Tested-by: John Stultz <jstultz@google.com>
---
 include/linux/sched.h   |  1 -
 kernel/sched/deadline.c | 23 ++---------------------
 kernel/sched/sched.h    | 33 +++++++++++++++++++++++++++++++--
 3 files changed, 33 insertions(+), 24 deletions(-)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index f89313b..e4ce0a7 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -706,7 +706,6 @@ struct sched_dl_entity {
 	unsigned int			dl_defer	  : 1;
 	unsigned int			dl_defer_armed	  : 1;
 	unsigned int			dl_defer_running  : 1;
-	unsigned int			dl_server_idle    : 1;
=20
 	/*
 	 * Bandwidth enforcement timer. Each -deadline task has its
diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index 5a5080b..72c1f72 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -1571,10 +1571,8 @@ void dl_server_update_idle_time(struct rq *rq, struct =
task_struct *p)
 void dl_server_update(struct sched_dl_entity *dl_se, s64 delta_exec)
 {
 	/* 0 runtime =3D fair server disabled */
-	if (dl_se->dl_runtime) {
-		dl_se->dl_server_idle =3D 0;
+	if (dl_se->dl_runtime)
 		update_curr_dl_se(dl_se->rq, dl_se, delta_exec);
-	}
 }
=20
 void dl_server_start(struct sched_dl_entity *dl_se)
@@ -1602,20 +1600,6 @@ void dl_server_stop(struct sched_dl_entity *dl_se)
 	dl_se->dl_server_active =3D 0;
 }
=20
-static bool dl_server_stopped(struct sched_dl_entity *dl_se)
-{
-	if (!dl_se->dl_server_active)
-		return true;
-
-	if (dl_se->dl_server_idle) {
-		dl_server_stop(dl_se);
-		return true;
-	}
-
-	dl_se->dl_server_idle =3D 1;
-	return false;
-}
-
 void dl_server_init(struct sched_dl_entity *dl_se, struct rq *rq,
 		    dl_server_pick_f pick_task)
 {
@@ -2384,10 +2368,7 @@ again:
 	if (dl_server(dl_se)) {
 		p =3D dl_se->server_pick_task(dl_se);
 		if (!p) {
-			if (!dl_server_stopped(dl_se)) {
-				dl_se->dl_yielded =3D 1;
-				update_curr_dl_se(rq, dl_se, 0);
-			}
+			dl_server_stop(dl_se);
 			goto again;
 		}
 		rq->dl_server =3D dl_se;
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index f10d627..cf2109b 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -371,10 +371,39 @@ extern s64 dl_scaled_delta_exec(struct rq *rq, struct s=
ched_dl_entity *dl_se, s6
  *   dl_server_update() -- called from update_curr_common(), propagates runt=
ime
  *                         to the server.
  *
- *   dl_server_start()
- *   dl_server_stop()  -- start/stop the server when it has (no) tasks.
+ *   dl_server_start() -- start the server when it has tasks; it will stop
+ *			  automatically when there are no more tasks, per
+ *			  dl_se::server_pick() returning NULL.
+ *
+ *   dl_server_stop() -- (force) stop the server; use when updating
+ *                       parameters.
  *
  *   dl_server_init() -- initializes the server.
+ *
+ * When started the dl_server will (per dl_defer) schedule a timer for its
+ * zero-laxity point -- that is, unlike regular EDF tasks which run ASAP, a
+ * server will run at the very end of its period.
+ *
+ * This is done such that any runtime from the target class can be accounted
+ * against the server -- through dl_server_update() above -- such that when =
it
+ * becomes time to run, it might already be out of runtime and get deferred
+ * until the next period. In this case dl_server_timer() will alternate
+ * between defer and replenish but never actually enqueue the server.
+ *
+ * Only when the target class does not manage to exhaust the server's runtime
+ * (there's actualy starvation in the given period), will the dl_server get =
on
+ * the runqueue. Once queued it will pick tasks from the target class and run
+ * them until either its runtime is exhaused, at which point its back to
+ * dl_server_timer, or until there are no more tasks to run, at which point
+ * the dl_server stops itself.
+ *
+ * By stopping at this point the dl_server retains bandwidth, which, if a new
+ * task wakes up imminently (starting the server again), can be used --
+ * subject to CBS wakeup rules -- without having to wait for the next period.
+ *
+ * Additionally, because of the dl_defer behaviour the start/stop behaviour =
is
+ * naturally thottled to once per period, avoiding high context switch
+ * workloads from spamming the hrtimer program/cancel paths.
  */
 extern void dl_server_update(struct sched_dl_entity *dl_se, s64 delta_exec);
 extern void dl_server_start(struct sched_dl_entity *dl_se);

