Return-Path: <linux-tip-commits+bounces-2079-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 29059955B47
	for <lists+linux-tip-commits@lfdr.de>; Sun, 18 Aug 2024 08:25:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D466C282571
	for <lists+linux-tip-commits@lfdr.de>; Sun, 18 Aug 2024 06:25:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB79981745;
	Sun, 18 Aug 2024 06:23:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="yIP36RyS";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="J5JqN0q7"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E41E2110E;
	Sun, 18 Aug 2024 06:23:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723962197; cv=none; b=ce9Q+tTeaKSHbI5g9TgEaGRiDgeVu+/xOnMxUJx8bHuV9q01xmky003OBUgiTZtlE7oyDhBGtkCPxHTjGXjLwmn/MLtPKB/AyGEEcAG2pmbKnYQxxifEsEpqsjaFmqH9XdLhs41q2iVEA8zvIRa5GOmoqssZohmoz8+s3GmNyP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723962197; c=relaxed/simple;
	bh=EwlBHZ9gy5gta/7f+72x4UTsO9uGBs8EHhx9xTnb/PE=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=a1JSH26QHJ/ogeYczQXGC0srEG30nDjSXpQnVNmdoMIiQEWji5MqShGFqZnhnNPDjUbeEKt88VtYyFOupAw7qx0IFdeEru84CSoMiXz7lvbMqHckQNFUn3zNzVH3icHtwk273LAq9b8TC+qy1tpQtS+bxh4B2XHAkRTBlOTaYco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=yIP36RyS; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=J5JqN0q7; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sun, 18 Aug 2024 06:23:11 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1723962191;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QCGGHQmEvsKZF0uh2UdAiJls5I5adendGg/FNQaGMM4=;
	b=yIP36RyS/wZqb6beLTaQE4db9dLKtoZSquIbYrzdnQOP5a613fn1gV0def/4neWzhwMBZx
	VMFlIlM6MLeQWvik+uYOedPfTSAnkoJ1fqDYNzDYcEbg7v5LKQH8xu+8FYBeWDLiV/P9+d
	OMF7UrvzRaAtQkYlCJxSliRMiOUepWwuZMWGRyjNVolsC0RLj3v4OQDcYVW/XG/ygtGBcH
	OQfFzvjgz8mkqhCVv3pDR8Vtx4ctsJis9sYtoRkXb/7TvP1SqVu2a7ZC5UzZ9I69XBmvtt
	AoNfoOf7/BgAfh8hf1lcBKs4QUHzZWe+Y7S7ClHqSvlPaQPj/r16Z6EyTX3Dhw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1723962191;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QCGGHQmEvsKZF0uh2UdAiJls5I5adendGg/FNQaGMM4=;
	b=J5JqN0q7VFCrD06MK+fJDnhtcX9fyXlUBqjsu5kThEanUaNnnZ2LnWss+17cxTNT1gmQ9G
	icASYPjSkLDaX/Cw==
From: "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched: Allow sched_class::dequeue_task() to fail
Cc: "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Valentin Schneider <vschneid@redhat.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240727105028.864630153@infradead.org>
References: <20240727105028.864630153@infradead.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172396219109.2215.13284109568756981039.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     863ccdbb918a77e3f011571f943020bf7f0b114b
Gitweb:        https://git.kernel.org/tip/863ccdbb918a77e3f011571f943020bf7f0b114b
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Wed, 03 Apr 2024 09:50:20 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Sat, 17 Aug 2024 11:06:41 +02:00

sched: Allow sched_class::dequeue_task() to fail

Change the function signature of sched_class::dequeue_task() to return
a boolean, allowing future patches to 'fail' dequeue.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Valentin Schneider <vschneid@redhat.com>
Tested-by: Valentin Schneider <vschneid@redhat.com>
Link: https://lkml.kernel.org/r/20240727105028.864630153@infradead.org
---
 kernel/sched/core.c      | 7 +++++--
 kernel/sched/deadline.c  | 4 +++-
 kernel/sched/fair.c      | 4 +++-
 kernel/sched/idle.c      | 3 ++-
 kernel/sched/rt.c        | 4 +++-
 kernel/sched/sched.h     | 4 ++--
 kernel/sched/stop_task.c | 3 ++-
 7 files changed, 20 insertions(+), 9 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index ab50100..4f7a4e9 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -2001,7 +2001,10 @@ void enqueue_task(struct rq *rq, struct task_struct *p, int flags)
 		sched_core_enqueue(rq, p);
 }
 
-void dequeue_task(struct rq *rq, struct task_struct *p, int flags)
+/*
+ * Must only return false when DEQUEUE_SLEEP.
+ */
+inline bool dequeue_task(struct rq *rq, struct task_struct *p, int flags)
 {
 	if (sched_core_enabled(rq))
 		sched_core_dequeue(rq, p, flags);
@@ -2015,7 +2018,7 @@ void dequeue_task(struct rq *rq, struct task_struct *p, int flags)
 	}
 
 	uclamp_rq_dec(rq, p);
-	p->sched_class->dequeue_task(rq, p, flags);
+	return p->sched_class->dequeue_task(rq, p, flags);
 }
 
 void activate_task(struct rq *rq, struct task_struct *p, int flags)
diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index c5f1cc7..bbaeace 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -2162,7 +2162,7 @@ static void enqueue_task_dl(struct rq *rq, struct task_struct *p, int flags)
 		enqueue_pushable_dl_task(rq, p);
 }
 
-static void dequeue_task_dl(struct rq *rq, struct task_struct *p, int flags)
+static bool dequeue_task_dl(struct rq *rq, struct task_struct *p, int flags)
 {
 	update_curr_dl(rq);
 
@@ -2172,6 +2172,8 @@ static void dequeue_task_dl(struct rq *rq, struct task_struct *p, int flags)
 	dequeue_dl_entity(&p->dl, flags);
 	if (!p->dl.dl_throttled && !dl_server(&p->dl))
 		dequeue_pushable_dl_task(rq, p);
+
+	return true;
 }
 
 /*
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 1452c53..03f76b3 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -6865,7 +6865,7 @@ static void set_next_buddy(struct sched_entity *se);
  * decreased. We remove the task from the rbtree and
  * update the fair scheduling stats:
  */
-static void dequeue_task_fair(struct rq *rq, struct task_struct *p, int flags)
+static bool dequeue_task_fair(struct rq *rq, struct task_struct *p, int flags)
 {
 	struct cfs_rq *cfs_rq;
 	struct sched_entity *se = &p->se;
@@ -6937,6 +6937,8 @@ static void dequeue_task_fair(struct rq *rq, struct task_struct *p, int flags)
 dequeue_throttle:
 	util_est_update(&rq->cfs, p, task_sleep);
 	hrtick_update(rq);
+
+	return true;
 }
 
 #ifdef CONFIG_SMP
diff --git a/kernel/sched/idle.c b/kernel/sched/idle.c
index d560f7f..1607420 100644
--- a/kernel/sched/idle.c
+++ b/kernel/sched/idle.c
@@ -482,13 +482,14 @@ struct task_struct *pick_next_task_idle(struct rq *rq)
  * It is not legal to sleep in the idle task - print a warning
  * message if some code attempts to do it:
  */
-static void
+static bool
 dequeue_task_idle(struct rq *rq, struct task_struct *p, int flags)
 {
 	raw_spin_rq_unlock_irq(rq);
 	printk(KERN_ERR "bad: scheduling from the idle thread!\n");
 	dump_stack();
 	raw_spin_rq_lock_irq(rq);
+	return true;
 }
 
 /*
diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
index a8731da..fdc8e05 100644
--- a/kernel/sched/rt.c
+++ b/kernel/sched/rt.c
@@ -1483,7 +1483,7 @@ enqueue_task_rt(struct rq *rq, struct task_struct *p, int flags)
 		enqueue_pushable_task(rq, p);
 }
 
-static void dequeue_task_rt(struct rq *rq, struct task_struct *p, int flags)
+static bool dequeue_task_rt(struct rq *rq, struct task_struct *p, int flags)
 {
 	struct sched_rt_entity *rt_se = &p->rt;
 
@@ -1491,6 +1491,8 @@ static void dequeue_task_rt(struct rq *rq, struct task_struct *p, int flags)
 	dequeue_rt_entity(rt_se, flags);
 
 	dequeue_pushable_task(rq, p);
+
+	return true;
 }
 
 /*
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index a6d6b6f..6196f90 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -2285,7 +2285,7 @@ struct sched_class {
 #endif
 
 	void (*enqueue_task) (struct rq *rq, struct task_struct *p, int flags);
-	void (*dequeue_task) (struct rq *rq, struct task_struct *p, int flags);
+	bool (*dequeue_task) (struct rq *rq, struct task_struct *p, int flags);
 	void (*yield_task)   (struct rq *rq);
 	bool (*yield_to_task)(struct rq *rq, struct task_struct *p);
 
@@ -3606,7 +3606,7 @@ extern int __sched_setaffinity(struct task_struct *p, struct affinity_context *c
 extern void __setscheduler_prio(struct task_struct *p, int prio);
 extern void set_load_weight(struct task_struct *p, bool update_load);
 extern void enqueue_task(struct rq *rq, struct task_struct *p, int flags);
-extern void dequeue_task(struct rq *rq, struct task_struct *p, int flags);
+extern bool dequeue_task(struct rq *rq, struct task_struct *p, int flags);
 
 extern void check_class_changed(struct rq *rq, struct task_struct *p,
 				const struct sched_class *prev_class,
diff --git a/kernel/sched/stop_task.c b/kernel/sched/stop_task.c
index b1b8fe6..4cf0207 100644
--- a/kernel/sched/stop_task.c
+++ b/kernel/sched/stop_task.c
@@ -57,10 +57,11 @@ enqueue_task_stop(struct rq *rq, struct task_struct *p, int flags)
 	add_nr_running(rq, 1);
 }
 
-static void
+static bool
 dequeue_task_stop(struct rq *rq, struct task_struct *p, int flags)
 {
 	sub_nr_running(rq, 1);
+	return true;
 }
 
 static void yield_task_stop(struct rq *rq)

