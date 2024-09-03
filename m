Return-Path: <linux-tip-commits+bounces-2148-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 41158969F26
	for <lists+linux-tip-commits@lfdr.de>; Tue,  3 Sep 2024 15:38:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EE0DB282334
	for <lists+linux-tip-commits@lfdr.de>; Tue,  3 Sep 2024 13:38:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A434C5684;
	Tue,  3 Sep 2024 13:38:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="lOGG0tUe";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="T03wFJyX"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C62E18489;
	Tue,  3 Sep 2024 13:38:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725370703; cv=none; b=hDgNYiZX+tOc1xlk4oCD2h8ulR+J5zr7EGc451mNHKssgtV11sxihXwrl/XW274YxiRVHT4YRYU+yuAIis/ZyrzhtfX0joQJSiEh5AlYBSF5rR8cNspCIlRA9+mLce7vCy/HuipfaXoyU6qqXyYRXM4YX4xqa0b7E9oluWcBsdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725370703; c=relaxed/simple;
	bh=C+sgy9ygPjkKKWYikAn16K6Zatsen+TKguANslXVzuA=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=CJgQ0GaOrNffm2EIVbJX38zUFhyxdilk/07Y8SzYvlXPoKA7xw+jto1mSJ8xuixfq5ijlbTqB541FxtQ7QGplEnC2f0QM9LAv7QOnL0eXJBY3asUborvhawJpz6WBgFVdw+Qmc0X2moDHx/m+5S0zNlyQ3Q8Fe2ok9lb0cXa8HI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=lOGG0tUe; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=T03wFJyX; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 03 Sep 2024 13:38:19 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1725370699;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0ZeKejKZoUyFGInMN6zCugIaeKk50Mi219VWLIw9NRM=;
	b=lOGG0tUet5ccZHq+A4iVUDFBTqjXS1HmwA3xQA4La9KGASZqg5LQoFXDgSsV9AlXKts+UZ
	AEVEjgG0sOlwoAdaViHO9DMPzfVCVPw6Qdi8ZzqUpAhWvndN0ogpnSgktzRmZy9HpKjPRu
	KoT5OHyIXrIFOl17cmibZnfd9Rshbld5Nvq6GKCs8R3Dmgpee5Pey5aUm3hDxT/WVA7egz
	QYpJ0zIciVNwF0IcT0Bsh/5t0XVcIQuE3pUiad01/LCngEvV6kbrV65N9PeN5I1vnz0NN9
	JD11aNfOVoDiHjyseJli+X0Do65WeXED3I5YBl1T8UDN9BJ+39EL0AbRwgLTaw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1725370699;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0ZeKejKZoUyFGInMN6zCugIaeKk50Mi219VWLIw9NRM=;
	b=T03wFJyXCrJJlLgYvbrEG/+NxQzJB9WCq6ogNtjsCcDm9Rh7GHXJI/F/0s0/6tmJGDxVqU
	5splABlI1z/+U2BA==
From: "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched: Add put_prev_task(.next)
Cc: "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240813224016.367421076@infradead.org>
References: <20240813224016.367421076@infradead.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172537069920.2215.6437489420063122852.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     b2d70222dbf2a2ff7a972a685d249a5d75afa87f
Gitweb:        https://git.kernel.org/tip/b2d70222dbf2a2ff7a972a685d249a5d75afa87f
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Wed, 14 Aug 2024 00:25:56 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 03 Sep 2024 15:26:32 +02:00

sched: Add put_prev_task(.next)

In order to tell the previous sched_class what the next task is, add
put_prev_task(.next).

Notable SCX will use this to:

 1) determine the next task will leave the SCX sched class and push
    the current task to another CPU if possible.
 2) statistics on how often and which other classes preempt it

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/r/20240813224016.367421076@infradead.org
---
 kernel/sched/deadline.c  | 2 +-
 kernel/sched/fair.c      | 2 +-
 kernel/sched/idle.c      | 2 +-
 kernel/sched/rt.c        | 2 +-
 kernel/sched/sched.h     | 6 +++---
 kernel/sched/stop_task.c | 2 +-
 6 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index e83b684..9ce93d0 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -2436,7 +2436,7 @@ static struct task_struct *pick_task_dl(struct rq *rq)
 	return __pick_task_dl(rq);
 }
 
-static void put_prev_task_dl(struct rq *rq, struct task_struct *p)
+static void put_prev_task_dl(struct rq *rq, struct task_struct *p, struct task_struct *next)
 {
 	struct sched_dl_entity *dl_se = &p->dl;
 	struct dl_rq *dl_rq = &rq->dl;
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index f673112..d697a0a 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -8869,7 +8869,7 @@ void fair_server_init(struct rq *rq)
 /*
  * Account for a descheduled task:
  */
-static void put_prev_task_fair(struct rq *rq, struct task_struct *prev)
+static void put_prev_task_fair(struct rq *rq, struct task_struct *prev, struct task_struct *next)
 {
 	struct sched_entity *se = &prev->se;
 	struct cfs_rq *cfs_rq;
diff --git a/kernel/sched/idle.c b/kernel/sched/idle.c
index a343e1c..7a105a0 100644
--- a/kernel/sched/idle.c
+++ b/kernel/sched/idle.c
@@ -450,7 +450,7 @@ static void wakeup_preempt_idle(struct rq *rq, struct task_struct *p, int flags)
 	resched_curr(rq);
 }
 
-static void put_prev_task_idle(struct rq *rq, struct task_struct *prev)
+static void put_prev_task_idle(struct rq *rq, struct task_struct *prev, struct task_struct *next)
 {
 	dl_server_update_idle_time(rq, prev);
 }
diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
index 8025f39..172c588 100644
--- a/kernel/sched/rt.c
+++ b/kernel/sched/rt.c
@@ -1748,7 +1748,7 @@ static struct task_struct *pick_task_rt(struct rq *rq)
 	return p;
 }
 
-static void put_prev_task_rt(struct rq *rq, struct task_struct *p)
+static void put_prev_task_rt(struct rq *rq, struct task_struct *p, struct task_struct *next)
 {
 	struct sched_rt_entity *rt_se = &p->rt;
 	struct rt_rq *rt_rq = &rq->rt;
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 2a216c9..3744f16 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -2314,7 +2314,7 @@ struct sched_class {
 	 */
 	struct task_struct *(*pick_next_task)(struct rq *rq, struct task_struct *prev);
 
-	void (*put_prev_task)(struct rq *rq, struct task_struct *p);
+	void (*put_prev_task)(struct rq *rq, struct task_struct *p, struct task_struct *next);
 	void (*set_next_task)(struct rq *rq, struct task_struct *p, bool first);
 
 #ifdef CONFIG_SMP
@@ -2364,7 +2364,7 @@ struct sched_class {
 static inline void put_prev_task(struct rq *rq, struct task_struct *prev)
 {
 	WARN_ON_ONCE(rq->curr != prev);
-	prev->sched_class->put_prev_task(rq, prev);
+	prev->sched_class->put_prev_task(rq, prev, NULL);
 }
 
 static inline void set_next_task(struct rq *rq, struct task_struct *next)
@@ -2393,7 +2393,7 @@ static inline void put_prev_set_next_task(struct rq *rq,
 	if (next == prev)
 		return;
 
-	prev->sched_class->put_prev_task(rq, prev);
+	prev->sched_class->put_prev_task(rq, prev, next);
 	next->sched_class->set_next_task(rq, next, true);
 }
 
diff --git a/kernel/sched/stop_task.c b/kernel/sched/stop_task.c
index 0fd5352..058dd42 100644
--- a/kernel/sched/stop_task.c
+++ b/kernel/sched/stop_task.c
@@ -59,7 +59,7 @@ static void yield_task_stop(struct rq *rq)
 	BUG(); /* the stop task should never yield, its pointless. */
 }
 
-static void put_prev_task_stop(struct rq *rq, struct task_struct *prev)
+static void put_prev_task_stop(struct rq *rq, struct task_struct *prev, struct task_struct *next)
 {
 	update_curr_common(rq);
 }

