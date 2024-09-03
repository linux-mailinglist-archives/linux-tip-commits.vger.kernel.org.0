Return-Path: <linux-tip-commits+bounces-2155-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A62C969F33
	for <lists+linux-tip-commits@lfdr.de>; Tue,  3 Sep 2024 15:39:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 12F92286F14
	for <lists+linux-tip-commits@lfdr.de>; Tue,  3 Sep 2024 13:39:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A748A3839C;
	Tue,  3 Sep 2024 13:38:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="fciIEO+0";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="kxtcHBM5"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 203941E505;
	Tue,  3 Sep 2024 13:38:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725370707; cv=none; b=iLoHxbexgUXvX29UxJs4IVSDNzua4KzZqFiv22Kr0ZXcD65XUR5+H/LbRkNcjiCrPSwrtZQLJwy3NMT5wbVqGprZwH6gCy1unX+UTv3EH7WW4tskgxneFKC3AUvhoGJWjiCSG4d+gWcpEJNKV8P5iF8TvAoMnX3qoZtNjqYJPOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725370707; c=relaxed/simple;
	bh=g+LF1SmUdEuv1hWcZ7eifOV16xtZGUpTMTy6+ahEH4Y=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=Mnfk6scklaIX+bKq7ZoSrTG/jHb3dXhmydYkbM4m5AzYeG4Sc1P3P09hVWorNwMZOh0hjKYA0qVDIdS545QGLCrlD2bUaN8UoYvL1K5Hssmi9hGkRZH6cRse7WHJojKz0qnQE9yk8ryB6bsGSNDUPZMfwJASIpf8N8m3wFc2uPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=fciIEO+0; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=kxtcHBM5; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 03 Sep 2024 13:38:21 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1725370701;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=m3MJnXcHI894170r2ukHyWVNpoX9Ex8+8GjZ5XsY784=;
	b=fciIEO+07smtQFAwtgZK6/gJN5LDPgorIdMwQlA4tKu5aU7rY76wSS9x4A4qZc45uShvfs
	V0qwmCUIcqSnwtL+OOWCAsuS/GWSeAwF/wKWoUhHdwmUMC9pIwHn/qAgc1jHvfqymK4k9Q
	FGme73SeeafkDQqFaAO2AdJgezYHTS4hIbG7YOGyPpmf4uFz1GsQTINesdZIHZZ1eoSTGs
	EedgCFkpJvvjQcu7/9mgWp0ntfPcFgvyel0yLi0EtW+buHDd97mvOKke4wMA5+T/LpObSk
	b64TEhc2+bzQIq0J94TQLq1K+MnQgQdW4AIHRl3ZHwxiZoruhkeBZgkiLBnpAQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1725370701;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=m3MJnXcHI894170r2ukHyWVNpoX9Ex8+8GjZ5XsY784=;
	b=kxtcHBM5ajDdxoK9DlqeV0TaqyhZVqS8mQFG2PWZDnCMGs/Y1QEx5L2xKUDjfpKQ35qpDa
	F8DR5k1EaVCPcrAA==
From: "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched: Clean up DL server vs core sched
Cc: "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240813224015.837303391@infradead.org>
References: <20240813224015.837303391@infradead.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172537070147.2215.14962008047022468221.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     4686cc598f669dea1b50dde1568e6c65c355bc67
Gitweb:        https://git.kernel.org/tip/4686cc598f669dea1b50dde1568e6c65c355bc67
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Wed, 14 Aug 2024 00:25:51 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 03 Sep 2024 15:26:31 +02:00

sched: Clean up DL server vs core sched

Abide by the simple rule:

  pick_next_task() := pick_task() + set_next_task(.first = true)

This allows us to trivially get rid of server_pick_next() and things
collapse nicely.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/r/20240813224015.837303391@infradead.org
---
 include/linux/sched.h   |  1 -
 kernel/sched/deadline.c | 18 +++++++-----------
 kernel/sched/fair.c     | 13 +------------
 kernel/sched/sched.h    |  1 -
 4 files changed, 8 insertions(+), 25 deletions(-)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index 3709ded..57cf27a 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -692,7 +692,6 @@ struct sched_dl_entity {
 	 */
 	struct rq			*rq;
 	dl_server_has_tasks_f		server_has_tasks;
-	dl_server_pick_f		server_pick_next;
 	dl_server_pick_f		server_pick_task;
 
 #ifdef CONFIG_RT_MUTEXES
diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index f7ac7cf..2ea929c 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -1665,12 +1665,10 @@ void dl_server_stop(struct sched_dl_entity *dl_se)
 
 void dl_server_init(struct sched_dl_entity *dl_se, struct rq *rq,
 		    dl_server_has_tasks_f has_tasks,
-		    dl_server_pick_f pick_next,
 		    dl_server_pick_f pick_task)
 {
 	dl_se->rq = rq;
 	dl_se->server_has_tasks = has_tasks;
-	dl_se->server_pick_next = pick_next;
 	dl_se->server_pick_task = pick_task;
 }
 
@@ -2404,9 +2402,8 @@ static struct sched_dl_entity *pick_next_dl_entity(struct dl_rq *dl_rq)
 /*
  * __pick_next_task_dl - Helper to pick the next -deadline task to run.
  * @rq: The runqueue to pick the next task from.
- * @peek: If true, just peek at the next task. Only relevant for dlserver.
  */
-static struct task_struct *__pick_next_task_dl(struct rq *rq, bool peek)
+static struct task_struct *__pick_task_dl(struct rq *rq)
 {
 	struct sched_dl_entity *dl_se;
 	struct dl_rq *dl_rq = &rq->dl;
@@ -2420,10 +2417,7 @@ again:
 	WARN_ON_ONCE(!dl_se);
 
 	if (dl_server(dl_se)) {
-		if (IS_ENABLED(CONFIG_SMP) && peek)
-			p = dl_se->server_pick_task(dl_se);
-		else
-			p = dl_se->server_pick_next(dl_se);
+		p = dl_se->server_pick_task(dl_se);
 		if (!p) {
 			dl_se->dl_yielded = 1;
 			update_curr_dl_se(rq, dl_se, 0);
@@ -2440,7 +2434,7 @@ again:
 #ifdef CONFIG_SMP
 static struct task_struct *pick_task_dl(struct rq *rq)
 {
-	return __pick_next_task_dl(rq, true);
+	return __pick_task_dl(rq);
 }
 #endif
 
@@ -2448,11 +2442,13 @@ static struct task_struct *pick_next_task_dl(struct rq *rq)
 {
 	struct task_struct *p;
 
-	p = __pick_next_task_dl(rq, false);
+	p = __pick_task_dl(rq);
 	if (!p)
 		return p;
 
-	if (!p->dl_server)
+	if (p->dl_server)
+		p->sched_class->set_next_task(rq, p, true);
+	else
 		set_next_task_dl(rq, p, true);
 
 	return p;
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index eaeb8b2..8379100 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -8862,16 +8862,7 @@ static bool fair_server_has_tasks(struct sched_dl_entity *dl_se)
 
 static struct task_struct *fair_server_pick_task(struct sched_dl_entity *dl_se)
 {
-#ifdef CONFIG_SMP
 	return pick_task_fair(dl_se->rq);
-#else
-	return NULL;
-#endif
-}
-
-static struct task_struct *fair_server_pick_next(struct sched_dl_entity *dl_se)
-{
-	return pick_next_task_fair(dl_se->rq, NULL, NULL);
 }
 
 void fair_server_init(struct rq *rq)
@@ -8880,9 +8871,7 @@ void fair_server_init(struct rq *rq)
 
 	init_dl_entity(dl_se);
 
-	dl_server_init(dl_se, rq, fair_server_has_tasks, fair_server_pick_next,
-		       fair_server_pick_task);
-
+	dl_server_init(dl_se, rq, fair_server_has_tasks, fair_server_pick_task);
 }
 
 /*
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index d33311d..80605e2 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -362,7 +362,6 @@ extern void dl_server_start(struct sched_dl_entity *dl_se);
 extern void dl_server_stop(struct sched_dl_entity *dl_se);
 extern void dl_server_init(struct sched_dl_entity *dl_se, struct rq *rq,
 		    dl_server_has_tasks_f has_tasks,
-		    dl_server_pick_f pick_next,
 		    dl_server_pick_f pick_task);
 
 extern void dl_server_update_idle_time(struct rq *rq,

