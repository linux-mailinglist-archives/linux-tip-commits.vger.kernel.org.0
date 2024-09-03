Return-Path: <linux-tip-commits+bounces-2152-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D2A39969F2C
	for <lists+linux-tip-commits@lfdr.de>; Tue,  3 Sep 2024 15:38:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8A6E0285703
	for <lists+linux-tip-commits@lfdr.de>; Tue,  3 Sep 2024 13:38:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF37217BA1;
	Tue,  3 Sep 2024 13:38:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="LL5HIJwq";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="i5QtJ/OJ"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC50B8C1E;
	Tue,  3 Sep 2024 13:38:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725370704; cv=none; b=h8IhiWpS6czeOWYoa+CGW6g5FzV80ryn7n6/du0+raAuCmt7hupxlKejaLuY4BhxG60dazKlqzo3A4F9R7JYrIXo+5J/pb2Foa2dajJ9VVjTYDdyKCZDQBE4ZGYaMTjtLjPFTuIMNZbQzXJGDML0+vBuH28zsrzkPeF716pAgEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725370704; c=relaxed/simple;
	bh=6v8UxMd2N4lBYtyvMwmIw+HlZGt5fc1emWcO7ZYBEZw=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=UY22HYVTM692OGStDRD/Eg3SIUJl9ZE1oQNZ7y6k5VF36Jw5ytpd94Jn5NVX3ZPr44QBciaOMyLegZn9OGXhpSSj///9XsPBT6++7CUAXXhjoQiqGYR4TgimK2hgycOtsUdOa5pSY+2DbMycQda2jxnLlnT82yd/tnxngJyg6CI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=LL5HIJwq; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=i5QtJ/OJ; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 03 Sep 2024 13:38:20 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1725370701;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=U8oGs+q0qnCLHoIHRlN7dBqeDhpXQ906sL9m1Eu8fh0=;
	b=LL5HIJwq2G5n3o9JGC8+1kmbwLjnSHbW9FEQvRH+3PwdNXVAJCxgBahzJBDZSGNxneJcWJ
	4rD+WcnappNV+aaaWIf3Yx0fxyYezl4IQ4ZX8wfq0Lx6vNgxJiKrDnrFs59n24XwvPtuVf
	ABCVjVtMZfTEKMZeEQIk6vWQk0XbRg7XV7dOxm67QriOBOg4bz5lCox7/DtQ6sSqQaJoEv
	bylLm2JYDmoVivm697E3l3ytYRmgp2VVFe8VORCNhMdiIprbQhkDMiDqkDX6LiXaRNru7h
	qc/DhCkZqDaz1EW0acb7RvWoKnKquQVdeydycYQzG9t6xSk1063NKJkOprgR1A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1725370701;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=U8oGs+q0qnCLHoIHRlN7dBqeDhpXQ906sL9m1Eu8fh0=;
	b=i5QtJ/OJFJ2teZ2mjHEuxemyuiz5ZR7alS73WfCF/TrjvsmF+2vNMiPmHukBELkN72xSmb
	JBoNxvuyAVMCsVAg==
From: "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched: Rework pick_next_task()
Cc: "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240813224016.051225657@infradead.org>
References: <20240813224016.051225657@infradead.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172537070063.2215.11678693046845315675.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     fd03c5b8585562d60f8b597b4332d28f48abfe7d
Gitweb:        https://git.kernel.org/tip/fd03c5b8585562d60f8b597b4332d28f48abfe7d
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Wed, 14 Aug 2024 00:25:53 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 03 Sep 2024 15:26:31 +02:00

sched: Rework pick_next_task()

The current rule is that:

  pick_next_task() := pick_task() + set_next_task(.first = true)

And many classes implement it directly as such. Change things around
to make pick_next_task() optional while also changing the definition to:

  pick_next_task(prev) := pick_task() + put_prev_task() + set_next_task(.first = true)

The reason is that sched_ext would like to have a 'final' call that
knows the next task. By placing put_prev_task() right next to
set_next_task() (as it already is for sched_core) this becomes
trivial.

As a bonus, this is a nice cleanup on its own.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/r/20240813224016.051225657@infradead.org
---
 kernel/sched/core.c      | 21 +++++++++++++++------
 kernel/sched/deadline.c  | 21 +--------------------
 kernel/sched/fair.c      | 11 +++++------
 kernel/sched/idle.c      | 16 ++--------------
 kernel/sched/rt.c        | 13 +------------
 kernel/sched/sched.h     | 16 ++++++++++++----
 kernel/sched/stop_task.c | 13 +------------
 7 files changed, 37 insertions(+), 74 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 36f9bc5..b9429eb 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -5893,8 +5893,9 @@ __pick_next_task(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
 
 		/* Assume the next prioritized class is idle_sched_class */
 		if (!p) {
+			p = pick_task_idle(rq);
 			put_prev_task(rq, prev);
-			p = pick_next_task_idle(rq);
+			set_next_task_first(rq, p);
 		}
 
 		/*
@@ -5916,12 +5917,20 @@ __pick_next_task(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
 
 restart:
 	prev_balance(rq, prev, rf);
-	put_prev_task(rq, prev);
 
 	for_each_class(class) {
-		p = class->pick_next_task(rq);
-		if (p)
-			return p;
+		if (class->pick_next_task) {
+			p = class->pick_next_task(rq, prev);
+			if (p)
+				return p;
+		} else {
+			p = class->pick_task(rq);
+			if (p) {
+				put_prev_task(rq, prev);
+				set_next_task_first(rq, p);
+				return p;
+			}
+		}
 	}
 
 	BUG(); /* The idle class should always have a runnable task. */
@@ -6017,7 +6026,6 @@ pick_next_task(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
 	}
 
 	prev_balance(rq, prev, rf);
-	put_prev_task(rq, prev);
 
 	smt_mask = cpu_smt_mask(cpu);
 	need_sync = !!rq->core->core_cookie;
@@ -6184,6 +6192,7 @@ pick_next_task(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
 	}
 
 out_set_next:
+	put_prev_task(rq, prev);
 	set_next_task_first(rq, next);
 out:
 	if (rq->core->core_forceidle_count && next == rq->idle)
diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index 2ea929c..a1547e1 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -2431,28 +2431,10 @@ again:
 	return p;
 }
 
-#ifdef CONFIG_SMP
 static struct task_struct *pick_task_dl(struct rq *rq)
 {
 	return __pick_task_dl(rq);
 }
-#endif
-
-static struct task_struct *pick_next_task_dl(struct rq *rq)
-{
-	struct task_struct *p;
-
-	p = __pick_task_dl(rq);
-	if (!p)
-		return p;
-
-	if (p->dl_server)
-		p->sched_class->set_next_task(rq, p, true);
-	else
-		set_next_task_dl(rq, p, true);
-
-	return p;
-}
 
 static void put_prev_task_dl(struct rq *rq, struct task_struct *p)
 {
@@ -3146,13 +3128,12 @@ DEFINE_SCHED_CLASS(dl) = {
 
 	.wakeup_preempt		= wakeup_preempt_dl,
 
-	.pick_next_task		= pick_next_task_dl,
+	.pick_task		= pick_task_dl,
 	.put_prev_task		= put_prev_task_dl,
 	.set_next_task		= set_next_task_dl,
 
 #ifdef CONFIG_SMP
 	.balance		= balance_dl,
-	.pick_task		= pick_task_dl,
 	.select_task_rq		= select_task_rq_dl,
 	.migrate_task_rq	= migrate_task_rq_dl,
 	.set_cpus_allowed       = set_cpus_allowed_dl,
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 8379100..53556b0 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -8777,7 +8777,7 @@ again:
 	se = &p->se;
 
 #ifdef CONFIG_FAIR_GROUP_SCHED
-	if (!prev || prev->sched_class != &fair_sched_class)
+	if (prev->sched_class != &fair_sched_class)
 		goto simple;
 
 	/*
@@ -8819,8 +8819,7 @@ again:
 
 simple:
 #endif
-	if (prev)
-		put_prev_task(rq, prev);
+	put_prev_task(rq, prev);
 	set_next_task_fair(rq, p, true);
 	return p;
 
@@ -8850,9 +8849,9 @@ idle:
 	return NULL;
 }
 
-static struct task_struct *__pick_next_task_fair(struct rq *rq)
+static struct task_struct *__pick_next_task_fair(struct rq *rq, struct task_struct *prev)
 {
-	return pick_next_task_fair(rq, NULL, NULL);
+	return pick_next_task_fair(rq, prev, NULL);
 }
 
 static bool fair_server_has_tasks(struct sched_dl_entity *dl_se)
@@ -13490,13 +13489,13 @@ DEFINE_SCHED_CLASS(fair) = {
 
 	.wakeup_preempt		= check_preempt_wakeup_fair,
 
+	.pick_task		= pick_task_fair,
 	.pick_next_task		= __pick_next_task_fair,
 	.put_prev_task		= put_prev_task_fair,
 	.set_next_task          = set_next_task_fair,
 
 #ifdef CONFIG_SMP
 	.balance		= balance_fair,
-	.pick_task		= pick_task_fair,
 	.select_task_rq		= select_task_rq_fair,
 	.migrate_task_rq	= migrate_task_rq_fair,
 
diff --git a/kernel/sched/idle.c b/kernel/sched/idle.c
index 1607420..a343e1c 100644
--- a/kernel/sched/idle.c
+++ b/kernel/sched/idle.c
@@ -462,21 +462,10 @@ static void set_next_task_idle(struct rq *rq, struct task_struct *next, bool fir
 	next->se.exec_start = rq_clock_task(rq);
 }
 
-#ifdef CONFIG_SMP
-static struct task_struct *pick_task_idle(struct rq *rq)
+struct task_struct *pick_task_idle(struct rq *rq)
 {
 	return rq->idle;
 }
-#endif
-
-struct task_struct *pick_next_task_idle(struct rq *rq)
-{
-	struct task_struct *next = rq->idle;
-
-	set_next_task_idle(rq, next, true);
-
-	return next;
-}
 
 /*
  * It is not legal to sleep in the idle task - print a warning
@@ -531,13 +520,12 @@ DEFINE_SCHED_CLASS(idle) = {
 
 	.wakeup_preempt		= wakeup_preempt_idle,
 
-	.pick_next_task		= pick_next_task_idle,
+	.pick_task		= pick_task_idle,
 	.put_prev_task		= put_prev_task_idle,
 	.set_next_task          = set_next_task_idle,
 
 #ifdef CONFIG_SMP
 	.balance		= balance_idle,
-	.pick_task		= pick_task_idle,
 	.select_task_rq		= select_task_rq_idle,
 	.set_cpus_allowed	= set_cpus_allowed_common,
 #endif
diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
index fdc8e05..8025f39 100644
--- a/kernel/sched/rt.c
+++ b/kernel/sched/rt.c
@@ -1748,16 +1748,6 @@ static struct task_struct *pick_task_rt(struct rq *rq)
 	return p;
 }
 
-static struct task_struct *pick_next_task_rt(struct rq *rq)
-{
-	struct task_struct *p = pick_task_rt(rq);
-
-	if (p)
-		set_next_task_rt(rq, p, true);
-
-	return p;
-}
-
 static void put_prev_task_rt(struct rq *rq, struct task_struct *p)
 {
 	struct sched_rt_entity *rt_se = &p->rt;
@@ -2645,13 +2635,12 @@ DEFINE_SCHED_CLASS(rt) = {
 
 	.wakeup_preempt		= wakeup_preempt_rt,
 
-	.pick_next_task		= pick_next_task_rt,
+	.pick_task		= pick_task_rt,
 	.put_prev_task		= put_prev_task_rt,
 	.set_next_task          = set_next_task_rt,
 
 #ifdef CONFIG_SMP
 	.balance		= balance_rt,
-	.pick_task		= pick_task_rt,
 	.select_task_rq		= select_task_rq_rt,
 	.set_cpus_allowed       = set_cpus_allowed_common,
 	.rq_online              = rq_online_rt,
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 80605e2..64a4ed7 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -2300,7 +2300,17 @@ struct sched_class {
 
 	void (*wakeup_preempt)(struct rq *rq, struct task_struct *p, int flags);
 
-	struct task_struct *(*pick_next_task)(struct rq *rq);
+	struct task_struct *(*pick_task)(struct rq *rq);
+	/*
+	 * Optional! When implemented pick_next_task() should be equivalent to:
+	 *
+	 *   next = pick_task();
+	 *   if (next) {
+	 *       put_prev_task(prev);
+	 *       set_next_task_first(next);
+	 *   }
+	 */
+	struct task_struct *(*pick_next_task)(struct rq *rq, struct task_struct *prev);
 
 	void (*put_prev_task)(struct rq *rq, struct task_struct *p);
 	void (*set_next_task)(struct rq *rq, struct task_struct *p, bool first);
@@ -2309,8 +2319,6 @@ struct sched_class {
 	int (*balance)(struct rq *rq, struct task_struct *prev, struct rq_flags *rf);
 	int  (*select_task_rq)(struct task_struct *p, int task_cpu, int flags);
 
-	struct task_struct * (*pick_task)(struct rq *rq);
-
 	void (*migrate_task_rq)(struct task_struct *p, int new_cpu);
 
 	void (*task_woken)(struct rq *this_rq, struct task_struct *task);
@@ -2421,7 +2429,7 @@ static inline bool sched_fair_runnable(struct rq *rq)
 }
 
 extern struct task_struct *pick_next_task_fair(struct rq *rq, struct task_struct *prev, struct rq_flags *rf);
-extern struct task_struct *pick_next_task_idle(struct rq *rq);
+extern struct task_struct *pick_task_idle(struct rq *rq);
 
 #define SCA_CHECK		0x01
 #define SCA_MIGRATE_DISABLE	0x02
diff --git a/kernel/sched/stop_task.c b/kernel/sched/stop_task.c
index 4cf0207..0fd5352 100644
--- a/kernel/sched/stop_task.c
+++ b/kernel/sched/stop_task.c
@@ -41,16 +41,6 @@ static struct task_struct *pick_task_stop(struct rq *rq)
 	return rq->stop;
 }
 
-static struct task_struct *pick_next_task_stop(struct rq *rq)
-{
-	struct task_struct *p = pick_task_stop(rq);
-
-	if (p)
-		set_next_task_stop(rq, p, true);
-
-	return p;
-}
-
 static void
 enqueue_task_stop(struct rq *rq, struct task_struct *p, int flags)
 {
@@ -112,13 +102,12 @@ DEFINE_SCHED_CLASS(stop) = {
 
 	.wakeup_preempt		= wakeup_preempt_stop,
 
-	.pick_next_task		= pick_next_task_stop,
+	.pick_task		= pick_task_stop,
 	.put_prev_task		= put_prev_task_stop,
 	.set_next_task          = set_next_task_stop,
 
 #ifdef CONFIG_SMP
 	.balance		= balance_stop,
-	.pick_task		= pick_task_stop,
 	.select_task_rq		= select_task_rq_stop,
 	.set_cpus_allowed	= set_cpus_allowed_common,
 #endif

