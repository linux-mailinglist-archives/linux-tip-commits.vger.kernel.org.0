Return-Path: <linux-tip-commits+bounces-6063-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F562B00256
	for <lists+linux-tip-commits@lfdr.de>; Thu, 10 Jul 2025 14:47:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 480DB1BC6044
	for <lists+linux-tip-commits@lfdr.de>; Thu, 10 Jul 2025 12:47:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CE152DBF45;
	Thu, 10 Jul 2025 12:46:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="I+bi+mFs";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="8Dt7ZRvV"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AA34280CF6;
	Thu, 10 Jul 2025 12:46:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752151601; cv=none; b=LfmNBP99+tLGi9AjCEida7IIVsP7SE44U3JFumWAyvPpLBX0zfeiXJ+4dRg0E83d0xVPXCHq1bJfQbo24RjE9iEAt+z3uH0gmBzpUsFaMnRasIwnKXcZ9PK12q0SFTOE7MltuBDjyzzVp8orYWiS6lBN0F0bH7DOEQBaBADXils=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752151601; c=relaxed/simple;
	bh=8VReMq0E8WGQo6ieWLZ8kWg5CHf1fPxlFfRsaXuZHCE=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=sII5WeMHt6nU13YdCFG87JQ+ag+PUM8M+Avwf7ylfOdB8XiZW/BlzCca44OGqMhtNcBlWxyS/W/Gh58yt5cOdBwqqnJZWIF589gVRYLEeIRyJRodB4lfUK40FkXE9a5DelFDNed8QHJxVQyjy2wzKClP91rWdtbwQg7QTBmkmn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=I+bi+mFs; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=8Dt7ZRvV; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 10 Jul 2025 12:46:36 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1752151597;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qU/861oLmAcaxtHas9J4VkDTr5vymcmMeTwWp2YrEV0=;
	b=I+bi+mFsOGyTw2zORlgrRkGkWATNcOH8kAGo/aM2GC9SSDYUty14OfuJz/jwt3zua2lUjJ
	M7PTiMiYr3MCvyu7VKrW94ETsDIbz+8Z3Omo4la2+P++VdtY+u81ynXcj13uclmSZMhhUW
	Ly1pB/FTpPoSFJJF1qAA0IGRIi2DvbX9nr2oqP6rV+6Pn3VjPZvVmSHiheQPujw0AUOx+6
	zNQs6afQmvxEFUIv2ui5Xz/1TWurPNWu7ouPNTshUkms/E3rDOrItG4ruOrxcLHetfk4Fy
	Vjxvx6xD+WnLiVg3MVKHs6x648ZddmdSCuvCeAWVLbzxozIpaczt4JFL/DwPKA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1752151597;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qU/861oLmAcaxtHas9J4VkDTr5vymcmMeTwWp2YrEV0=;
	b=8Dt7ZRvV222GHEZ9ReUG5AHfdh6xn2Ht6VUmlFrvOqHUkVJee9/5DEqN7RVu/nrRmeWR86
	CHaFETihQeZ0zyBQ==
From: "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/deadline: Less agressive dl_server handling
Cc: Chris Mason <clm@meta.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Juri Lelli <juri.lelli@redhat.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250702121158.465086194@infradead.org>
References: <20250702121158.465086194@infradead.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175215159636.406.7563515663197958072.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     cccb45d7c4295bbfeba616582d0249f2d21e6df5
Gitweb:        https://git.kernel.org/tip/cccb45d7c4295bbfeba616582d0249f2d21e6df5
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Tue, 20 May 2025 11:19:30 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 09 Jul 2025 13:40:21 +02:00

sched/deadline: Less agressive dl_server handling

Chris reported that commit 5f6bd380c7bd ("sched/rt: Remove default
bandwidth control") caused a significant dip in his favourite
benchmark of the day. Simply disabling dl_server cured things.

His workload hammers the 0->1, 1->0 transitions, and the
dl_server_{start,stop}() overhead kills it -- fairly obviously a bad
idea in hind sight and all that.

Change things around to only disable the dl_server when there has not
been a fair task around for a whole period. Since the default period
is 1 second, this ensures the benchmark never trips this, overhead
gone.

Fixes: 557a6bfc662c ("sched/fair: Add trivial fair server")
Reported-by: Chris Mason <clm@meta.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Juri Lelli <juri.lelli@redhat.com>
Acked-by: Juri Lelli <juri.lelli@redhat.com>
Link: https://lkml.kernel.org/r/20250702121158.465086194@infradead.org
---
 include/linux/sched.h   |  1 +
 kernel/sched/deadline.c | 25 ++++++++++++++++++++++---
 kernel/sched/fair.c     |  9 ---------
 3 files changed, 23 insertions(+), 12 deletions(-)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index eec6b22..4802fcf 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -698,6 +698,7 @@ struct sched_dl_entity {
 	unsigned int			dl_defer	  : 1;
 	unsigned int			dl_defer_armed	  : 1;
 	unsigned int			dl_defer_running  : 1;
+	unsigned int			dl_server_idle    : 1;
 
 	/*
 	 * Bandwidth enforcement timer. Each -deadline task has its
diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index 0f30697..23668fc 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -1150,6 +1150,8 @@ static void __push_dl_task(struct rq *rq, struct rq_flags *rf)
 /* a defer timer will not be reset if the runtime consumed was < dl_server_min_res */
 static const u64 dl_server_min_res = 1 * NSEC_PER_MSEC;
 
+static bool dl_server_stopped(struct sched_dl_entity *dl_se);
+
 static enum hrtimer_restart dl_server_timer(struct hrtimer *timer, struct sched_dl_entity *dl_se)
 {
 	struct rq *rq = rq_of_dl_se(dl_se);
@@ -1169,6 +1171,7 @@ static enum hrtimer_restart dl_server_timer(struct hrtimer *timer, struct sched_
 
 		if (!dl_se->server_has_tasks(dl_se)) {
 			replenish_dl_entity(dl_se);
+			dl_server_stopped(dl_se);
 			return HRTIMER_NORESTART;
 		}
 
@@ -1572,8 +1575,10 @@ void dl_server_update_idle_time(struct rq *rq, struct task_struct *p)
 void dl_server_update(struct sched_dl_entity *dl_se, s64 delta_exec)
 {
 	/* 0 runtime = fair server disabled */
-	if (dl_se->dl_runtime)
+	if (dl_se->dl_runtime) {
+		dl_se->dl_server_idle = 0;
 		update_curr_dl_se(dl_se->rq, dl_se, delta_exec);
+	}
 }
 
 void dl_server_start(struct sched_dl_entity *dl_se)
@@ -1596,7 +1601,7 @@ void dl_server_start(struct sched_dl_entity *dl_se)
 		setup_new_dl_entity(dl_se);
 	}
 
-	if (!dl_se->dl_runtime)
+	if (!dl_se->dl_runtime || dl_se->dl_server_active)
 		return;
 
 	dl_se->dl_server_active = 1;
@@ -1617,6 +1622,20 @@ void dl_server_stop(struct sched_dl_entity *dl_se)
 	dl_se->dl_server_active = 0;
 }
 
+static bool dl_server_stopped(struct sched_dl_entity *dl_se)
+{
+	if (!dl_se->dl_server_active)
+		return false;
+
+	if (dl_se->dl_server_idle) {
+		dl_server_stop(dl_se);
+		return true;
+	}
+
+	dl_se->dl_server_idle = 1;
+	return false;
+}
+
 void dl_server_init(struct sched_dl_entity *dl_se, struct rq *rq,
 		    dl_server_has_tasks_f has_tasks,
 		    dl_server_pick_f pick_task)
@@ -2354,7 +2373,7 @@ again:
 	if (dl_server(dl_se)) {
 		p = dl_se->server_pick_task(dl_se);
 		if (!p) {
-			if (dl_server_active(dl_se)) {
+			if (!dl_server_stopped(dl_se)) {
 				dl_se->dl_yielded = 1;
 				update_curr_dl_se(rq, dl_se, 0);
 			}
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index ab0822c..a1350c5 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -5802,7 +5802,6 @@ static bool throttle_cfs_rq(struct cfs_rq *cfs_rq)
 	struct cfs_bandwidth *cfs_b = tg_cfs_bandwidth(cfs_rq->tg);
 	struct sched_entity *se;
 	long queued_delta, runnable_delta, idle_delta, dequeue = 1;
-	long rq_h_nr_queued = rq->cfs.h_nr_queued;
 
 	raw_spin_lock(&cfs_b->lock);
 	/* This will start the period timer if necessary */
@@ -5886,10 +5885,6 @@ static bool throttle_cfs_rq(struct cfs_rq *cfs_rq)
 
 	/* At this point se is NULL and we are at root level*/
 	sub_nr_running(rq, queued_delta);
-
-	/* Stop the fair server if throttling resulted in no runnable tasks */
-	if (rq_h_nr_queued && !rq->cfs.h_nr_queued)
-		dl_server_stop(&rq->fair_server);
 done:
 	/*
 	 * Note: distribution will already see us throttled via the
@@ -6966,7 +6961,6 @@ static void set_next_buddy(struct sched_entity *se);
 static int dequeue_entities(struct rq *rq, struct sched_entity *se, int flags)
 {
 	bool was_sched_idle = sched_idle_rq(rq);
-	int rq_h_nr_queued = rq->cfs.h_nr_queued;
 	bool task_sleep = flags & DEQUEUE_SLEEP;
 	bool task_delayed = flags & DEQUEUE_DELAYED;
 	struct task_struct *p = NULL;
@@ -7050,9 +7044,6 @@ static int dequeue_entities(struct rq *rq, struct sched_entity *se, int flags)
 
 	sub_nr_running(rq, h_nr_queued);
 
-	if (rq_h_nr_queued && !rq->cfs.h_nr_queued)
-		dl_server_stop(&rq->fair_server);
-
 	/* balance early to pull high priority tasks */
 	if (unlikely(!was_sched_idle && sched_idle_rq(rq)))
 		rq->next_balance = jiffies;

