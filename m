Return-Path: <linux-tip-commits+bounces-1793-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 87F9C93F2CC
	for <lists+linux-tip-commits@lfdr.de>; Mon, 29 Jul 2024 12:34:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DD176B227C9
	for <lists+linux-tip-commits@lfdr.de>; Mon, 29 Jul 2024 10:34:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F718144D23;
	Mon, 29 Jul 2024 10:34:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="q4Gm7IMU";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="W+6w18kl"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7C7F143873;
	Mon, 29 Jul 2024 10:34:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722249247; cv=none; b=YsgOWZvvXSG27akh2DQnnKGoLXaFF+x6Ih+uBl3NaSnTf/WSwVxZmWVyTMlYF/F7y8b8Zb1OL3yAAOfXUqDxVgBTTLDR1ogML8PquMRrkv1PKLTL5zbtLWSr5V+3MM7KaujEuoDDkR/Fbgy9qwO1JzMnefe7XK8DN5S7UoQFz5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722249247; c=relaxed/simple;
	bh=zIHWDrJs2RXpLhehu4rA00hG9qgjdcou5i4v6wUA7MM=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=FJey5q60/Halx6UMgQ4UqwXgiN0nQukc9sBf6yqctaphxfFpV/v7biHZ4UWE/vH/WOdhAwiTg111ZEadqyl2WvtU7t6oonVEEmP5+Bm/YNGX30Q00dr6aP/R30xODqAHdLV1m3KVxJb5nC//CI3nz7WQIpJZO37naYdxKYevaD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=q4Gm7IMU; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=W+6w18kl; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 29 Jul 2024 10:34:02 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1722249243;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EvKTJcJ65cCSvd8gt7vqwEYIEh39ixGD5M1XXmMlgy4=;
	b=q4Gm7IMUn0SUYnl0LodmOLgzaVGGXLwdEqmngcDDEmBpwjOnJ3gTJaIOSI2nmSbMxSxWvW
	OqqTh/xnG4YVpdYaLP1bLO8271Pv0oktS8dYriS7wsUDtn1vXEG8x65scorzDeGVKcwjis
	gIMFIr2gbLImNa9kH9NTGcZWPJJU/W4oCCtLFqG9nY0Rz7fPYrdPToW2XSopRFoAxpIVW7
	iTTR/CaU6ZAplByR66ZLO4WOAm7C4LZ1OSgSCIg1LdT1iJVZtXnK+h9ysy63vHOQW2htKU
	T8tx7u9PuXf1A3f5e71+ncGQ0CIvQzUkmbxfpozEVJrxYyRUYrrsmBN4ZjsN0A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1722249243;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EvKTJcJ65cCSvd8gt7vqwEYIEh39ixGD5M1XXmMlgy4=;
	b=W+6w18klSNkoAqX9qAW6AQ71TyrDC+z5XaeL3x//HHTqZ3avxLWEPkPUy0OUkKZ5sCxF1o
	A2gXFZZyJmftRFCg==
From: "tip-bot2 for Joel Fernandes (Google)" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/core: Fix picking of tasks for core
 scheduling with DL server
Cc: Suleiman Souhlal <suleiman@google.com>,
 "Joel Fernandes (Google)" <joel@joelfernandes.org>,
 Daniel Bristot de Oliveira <bristot@kernel.org>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Vineeth Pillai <vineeth@bitbyteword.org>, Juri Lelli <juri.lelli@redhat.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To:
 <b10489ab1f03d23e08e6097acea47442e7d6466f.1716811044.git.bristot@kernel.org>
References:
 <b10489ab1f03d23e08e6097acea47442e7d6466f.1716811044.git.bristot@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172224924259.2215.9246085118455972956.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     c8a85394cfdb4696b4e2f8a0f3066a1c921af426
Gitweb:        https://git.kernel.org/tip/c8a85394cfdb4696b4e2f8a0f3066a1c921af426
Author:        Joel Fernandes (Google) <joel@joelfernandes.org>
AuthorDate:    Mon, 27 May 2024 14:06:54 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 29 Jul 2024 12:22:37 +02:00

sched/core: Fix picking of tasks for core scheduling with DL server

* Use simple CFS pick_task for DL pick_task

  DL server's pick_task calls CFS's pick_next_task_fair(), this is wrong
  because core scheduling's pick_task only calls CFS's pick_task() for
  evaluation / checking of the CFS task (comparing across CPUs), not for
  actually affirmatively picking the next task. This causes RB tree
  corruption issues in CFS that were found by syzbot.

* Make pick_task_fair clear DL server

  A DL task pick might set ->dl_server, but it is possible the task will
  never run (say the other HT has a stop task). If the CFS task is picked
  in the future directly (say without DL server), ->dl_server will be
  set. So clear it in pick_task_fair().

This fixes the KASAN issue reported by syzbot in set_next_entity().

(DL refactoring suggestions by Vineeth Pillai).

Reported-by: Suleiman Souhlal <suleiman@google.com>
Signed-off-by: "Joel Fernandes (Google)" <joel@joelfernandes.org>
Signed-off-by: Daniel Bristot de Oliveira <bristot@kernel.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Vineeth Pillai <vineeth@bitbyteword.org>
Tested-by: Juri Lelli <juri.lelli@redhat.com>
Link: https://lore.kernel.org/r/b10489ab1f03d23e08e6097acea47442e7d6466f.1716811044.git.bristot@kernel.org
---
 include/linux/sched.h   |  3 ++-
 kernel/sched/deadline.c | 27 ++++++++++++++++++++++-----
 kernel/sched/fair.c     | 23 +++++++++++++++++++++--
 kernel/sched/sched.h    |  3 ++-
 4 files changed, 47 insertions(+), 9 deletions(-)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index 4edd7e2..2c1b4ee 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -686,7 +686,8 @@ struct sched_dl_entity {
 	 */
 	struct rq			*rq;
 	dl_server_has_tasks_f		server_has_tasks;
-	dl_server_pick_f		server_pick;
+	dl_server_pick_f		server_pick_next;
+	dl_server_pick_f		server_pick_task;
 
 #ifdef CONFIG_RT_MUTEXES
 	/*
diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index 747c0c5..8571bc9 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -1664,11 +1664,13 @@ void dl_server_stop(struct sched_dl_entity *dl_se)
 
 void dl_server_init(struct sched_dl_entity *dl_se, struct rq *rq,
 		    dl_server_has_tasks_f has_tasks,
-		    dl_server_pick_f pick)
+		    dl_server_pick_f pick_next,
+		    dl_server_pick_f pick_task)
 {
 	dl_se->rq = rq;
 	dl_se->server_has_tasks = has_tasks;
-	dl_se->server_pick = pick;
+	dl_se->server_pick_next = pick_next;
+	dl_se->server_pick_task = pick_task;
 }
 
 void __dl_server_attach_root(struct sched_dl_entity *dl_se, struct rq *rq)
@@ -2399,7 +2401,12 @@ static struct sched_dl_entity *pick_next_dl_entity(struct dl_rq *dl_rq)
 	return __node_2_dle(left);
 }
 
-static struct task_struct *pick_task_dl(struct rq *rq)
+/*
+ * __pick_next_task_dl - Helper to pick the next -deadline task to run.
+ * @rq: The runqueue to pick the next task from.
+ * @peek: If true, just peek at the next task. Only relevant for dlserver.
+ */
+static struct task_struct *__pick_next_task_dl(struct rq *rq, bool peek)
 {
 	struct sched_dl_entity *dl_se;
 	struct dl_rq *dl_rq = &rq->dl;
@@ -2413,7 +2420,10 @@ again:
 	WARN_ON_ONCE(!dl_se);
 
 	if (dl_server(dl_se)) {
-		p = dl_se->server_pick(dl_se);
+		if (IS_ENABLED(CONFIG_SMP) && peek)
+			p = dl_se->server_pick_task(dl_se);
+		else
+			p = dl_se->server_pick_next(dl_se);
 		if (!p) {
 			WARN_ON_ONCE(1);
 			dl_se->dl_yielded = 1;
@@ -2428,11 +2438,18 @@ again:
 	return p;
 }
 
+#ifdef CONFIG_SMP
+static struct task_struct *pick_task_dl(struct rq *rq)
+{
+	return __pick_next_task_dl(rq, true);
+}
+#endif
+
 static struct task_struct *pick_next_task_dl(struct rq *rq)
 {
 	struct task_struct *p;
 
-	p = pick_task_dl(rq);
+	p = __pick_next_task_dl(rq, false);
 	if (!p)
 		return p;
 
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 1ea5ec8..ee251ac 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -8479,6 +8479,14 @@ again:
 		cfs_rq = group_cfs_rq(se);
 	} while (cfs_rq);
 
+	/*
+	 * This can be called from directly from CFS's ->pick_task() or indirectly
+	 * from DL's ->pick_task when fair server is enabled. In the indirect case,
+	 * DL will set ->dl_server just after this function is called, so its Ok to
+	 * clear. In the direct case, we are picking directly so we must clear it.
+	 */
+	task_of(se)->dl_server = NULL;
+
 	return task_of(se);
 }
 #endif
@@ -8638,7 +8646,16 @@ static bool fair_server_has_tasks(struct sched_dl_entity *dl_se)
 	return !!dl_se->rq->cfs.nr_running;
 }
 
-static struct task_struct *fair_server_pick(struct sched_dl_entity *dl_se)
+static struct task_struct *fair_server_pick_task(struct sched_dl_entity *dl_se)
+{
+#ifdef CONFIG_SMP
+	return pick_task_fair(dl_se->rq);
+#else
+	return NULL;
+#endif
+}
+
+static struct task_struct *fair_server_pick_next(struct sched_dl_entity *dl_se)
 {
 	return pick_next_task_fair(dl_se->rq, NULL, NULL);
 }
@@ -8649,7 +8666,9 @@ void fair_server_init(struct rq *rq)
 
 	init_dl_entity(dl_se);
 
-	dl_server_init(dl_se, rq, fair_server_has_tasks, fair_server_pick);
+	dl_server_init(dl_se, rq, fair_server_has_tasks, fair_server_pick_next,
+		       fair_server_pick_task);
+
 }
 
 /*
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index b777ac3..f7e028b 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -361,7 +361,8 @@ extern void dl_server_start(struct sched_dl_entity *dl_se);
 extern void dl_server_stop(struct sched_dl_entity *dl_se);
 extern void dl_server_init(struct sched_dl_entity *dl_se, struct rq *rq,
 		    dl_server_has_tasks_f has_tasks,
-		    dl_server_pick_f pick);
+		    dl_server_pick_f pick_next,
+		    dl_server_pick_f pick_task);
 
 extern void dl_server_update_idle_time(struct rq *rq,
 		    struct task_struct *p);

