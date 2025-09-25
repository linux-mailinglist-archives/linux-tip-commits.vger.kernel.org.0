Return-Path: <linux-tip-commits+bounces-6717-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 638A3B9DEE6
	for <lists+linux-tip-commits@lfdr.de>; Thu, 25 Sep 2025 09:56:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ED6363839C7
	for <lists+linux-tip-commits@lfdr.de>; Thu, 25 Sep 2025 07:56:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EE7E2E7193;
	Thu, 25 Sep 2025 07:56:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="3TI/AzfZ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="bj7Up+b/"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C0CC266EEA;
	Thu, 25 Sep 2025 07:56:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758786967; cv=none; b=fX29IlrK6D1fhLy4KzRUZw9siWEdDDsSEwLAbzZk6MtlS1oA/zJX+CsQX6PaLvM64lgTS30LcKdIipOw5Rqzhn61DwpSsozTUcJAnD9OMzqKmETVZYd3lVINVB71egaM1BDQ7kX8BqljimCFOxyjHUnUj3uLRCwa+qmOzQ1vc1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758786967; c=relaxed/simple;
	bh=Ov6DvxOsJoe4/RJ7w4msvOfh7gfqUeo+hCvDMojZQUg=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=eeBfwy6RKXgYk9DyLMgUsVFjVMDW4BO4VhTu/SpaXMc/9GXsWzTP/+2WAir8XlZNmlUqaqrszF5pNf7QmxDVGEGjWzjc6p0boMCZOqHgb1a3yhW2p+ULkD5ifvfZoQci6uwfPK60kU+eQYqopMiHZkqP4ClMFtINHgci2a/SSDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=3TI/AzfZ; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=bj7Up+b/; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 25 Sep 2025 07:55:56 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1758786957;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uETLdYlTIraY1h7EWLh54tbKIGIhQMQCMzOGInKdvKw=;
	b=3TI/AzfZeXy0bDbfVOo00rHsEGEaP7ebhJsFNn1Yb70ovCZhr/a3s1BPzjpJMZHuq6QKnx
	cGRmfAV2hbwLlhctuyg68NN0/cEODiGTdrEMUccJqpaQGVm6U3+q6/wNzCtjda5w6sQzfP
	+/Hcp6E+1iLbGZeeuW6ut69gi/1JOTIkqxvXTzJ0yKfmQSZAqvErzLSQRRwrZyvhmxJpqU
	XLnBcczzm5yZD0si50QZS1SAOYRNngwNTNU5m3DJ5gepYE0aa/K+bS8QhWBGcc1W5sh2T4
	ItTsHnvBI3u6/UG+5pGKVJNkjw8gZTjaPkgvsP79Kw7qGgRT3vRyT95K2Zj5bQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1758786957;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uETLdYlTIraY1h7EWLh54tbKIGIhQMQCMzOGInKdvKw=;
	b=bj7Up+b/gktoQUlvKXe2xXqaq3Hd8gaEmS60VlFLtaQ6OkYtUiAwCMlUrC+0Bn/VWQ61eN
	Jbyt/j5fz5Rf8uCw==
From: "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: sched/urgent] sched/deadline: Fix dl_server getting stuck
Cc: John Stultz <jstultz@google.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250916110155.GH3245006@noisy.programming.kicks-ass.net>
References: <20250916110155.GH3245006@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175878695639.709179.6667557610013292048.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the sched/urgent branch of tip:

Commit-ID:     4ae8d9aa9f9dc7137ea5e564d79c5aa5af1bc45c
Gitweb:        https://git.kernel.org/tip/4ae8d9aa9f9dc7137ea5e564d79c5aa5af1=
bc45c
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Tue, 16 Sep 2025 23:02:41 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Thu, 25 Sep 2025 09:51:50 +02:00

sched/deadline: Fix dl_server getting stuck

John found it was easy to hit lockup warnings when running locktorture
on a 2 CPU VM, which he bisected down to: commit cccb45d7c429
("sched/deadline: Less agressive dl_server handling").

While debugging it seems there is a chance where we end up with the
dl_server dequeued, with dl_se->dl_server_active. This causes
dl_server_start() to return without enqueueing the dl_server, thus it
fails to run when RT tasks starve the cpu.

When this happens, dl_server_timer() catches the
'!dl_se->server_has_tasks(dl_se)' case, which then calls
replenish_dl_entity() and dl_server_stopped() and finally return
HRTIMER_NO_RESTART.

This ends in no new timer and also no enqueue, leaving the dl_server
'dead', allowing starvation.

What should have happened is for the bandwidth timer to start the
zero-laxity timer, which in turn would enqueue the dl_server and cause
dl_se->server_pick_task() to be called -- which will stop the
dl_server if no fair tasks are observed for a whole period.

IOW, it is totally irrelevant if there are fair tasks at the moment of
bandwidth refresh.

This removes all dl_se->server_has_tasks() users, so remove the whole
thing.

Fixes: cccb45d7c4295 ("sched/deadline: Less agressive dl_server handling")
Reported-by: John Stultz <jstultz@google.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Tested-by: John Stultz <jstultz@google.com>
---
 include/linux/sched.h   |  1 -
 kernel/sched/deadline.c | 12 +-----------
 kernel/sched/fair.c     |  7 +------
 kernel/sched/sched.h    |  4 ----
 4 files changed, 2 insertions(+), 22 deletions(-)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index f8188b8..f89313b 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -733,7 +733,6 @@ struct sched_dl_entity {
 	 * runnable task.
 	 */
 	struct rq			*rq;
-	dl_server_has_tasks_f		server_has_tasks;
 	dl_server_pick_f		server_pick_task;
=20
 #ifdef CONFIG_RT_MUTEXES
diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index f253012..5a5080b 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -875,7 +875,7 @@ static void replenish_dl_entity(struct sched_dl_entity *d=
l_se)
 	 */
 	if (dl_se->dl_defer && !dl_se->dl_defer_running &&
 	    dl_time_before(rq_clock(dl_se->rq), dl_se->deadline - dl_se->runtime)) {
-		if (!is_dl_boosted(dl_se) && dl_se->server_has_tasks(dl_se)) {
+		if (!is_dl_boosted(dl_se)) {
=20
 			/*
 			 * Set dl_se->dl_defer_armed and dl_throttled variables to
@@ -1152,8 +1152,6 @@ static void __push_dl_task(struct rq *rq, struct rq_fla=
gs *rf)
 /* a defer timer will not be reset if the runtime consumed was < dl_server_m=
in_res */
 static const u64 dl_server_min_res =3D 1 * NSEC_PER_MSEC;
=20
-static bool dl_server_stopped(struct sched_dl_entity *dl_se);
-
 static enum hrtimer_restart dl_server_timer(struct hrtimer *timer, struct sc=
hed_dl_entity *dl_se)
 {
 	struct rq *rq =3D rq_of_dl_se(dl_se);
@@ -1171,12 +1169,6 @@ static enum hrtimer_restart dl_server_timer(struct hrt=
imer *timer, struct sched_
 		if (!dl_se->dl_runtime)
 			return HRTIMER_NORESTART;
=20
-		if (!dl_se->server_has_tasks(dl_se)) {
-			replenish_dl_entity(dl_se);
-			dl_server_stopped(dl_se);
-			return HRTIMER_NORESTART;
-		}
-
 		if (dl_se->dl_defer_armed) {
 			/*
 			 * First check if the server could consume runtime in background.
@@ -1625,11 +1617,9 @@ static bool dl_server_stopped(struct sched_dl_entity *=
dl_se)
 }
=20
 void dl_server_init(struct sched_dl_entity *dl_se, struct rq *rq,
-		    dl_server_has_tasks_f has_tasks,
 		    dl_server_pick_f pick_task)
 {
 	dl_se->rq =3D rq;
-	dl_se->server_has_tasks =3D has_tasks;
 	dl_se->server_pick_task =3D pick_task;
 }
=20
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index b173a05..8ce56a8 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -8859,11 +8859,6 @@ static struct task_struct *__pick_next_task_fair(struc=
t rq *rq, struct task_stru
 	return pick_next_task_fair(rq, prev, NULL);
 }
=20
-static bool fair_server_has_tasks(struct sched_dl_entity *dl_se)
-{
-	return !!dl_se->rq->cfs.nr_queued;
-}
-
 static struct task_struct *fair_server_pick_task(struct sched_dl_entity *dl_=
se)
 {
 	return pick_task_fair(dl_se->rq);
@@ -8875,7 +8870,7 @@ void fair_server_init(struct rq *rq)
=20
 	init_dl_entity(dl_se);
=20
-	dl_server_init(dl_se, rq, fair_server_has_tasks, fair_server_pick_task);
+	dl_server_init(dl_se, rq, fair_server_pick_task);
 }
=20
 /*
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index be9745d..f10d627 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -365,9 +365,6 @@ extern s64 dl_scaled_delta_exec(struct rq *rq, struct sch=
ed_dl_entity *dl_se, s6
  *
  *   dl_se::rq -- runqueue we belong to.
  *
- *   dl_se::server_has_tasks() -- used on bandwidth enforcement; we 'stop' t=
he
- *                                server when it runs out of tasks to run.
- *
  *   dl_se::server_pick() -- nested pick_next_task(); we yield the period if=
 this
  *                           returns NULL.
  *
@@ -383,7 +380,6 @@ extern void dl_server_update(struct sched_dl_entity *dl_s=
e, s64 delta_exec);
 extern void dl_server_start(struct sched_dl_entity *dl_se);
 extern void dl_server_stop(struct sched_dl_entity *dl_se);
 extern void dl_server_init(struct sched_dl_entity *dl_se, struct rq *rq,
-		    dl_server_has_tasks_f has_tasks,
 		    dl_server_pick_f pick_task);
 extern void sched_init_dl_servers(void);
=20

