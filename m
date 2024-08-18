Return-Path: <linux-tip-commits+bounces-2072-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0045A955B40
	for <lists+linux-tip-commits@lfdr.de>; Sun, 18 Aug 2024 08:24:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 82E621F21A24
	for <lists+linux-tip-commits@lfdr.de>; Sun, 18 Aug 2024 06:24:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FA28481CD;
	Sun, 18 Aug 2024 06:23:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="J/n6cKcU";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="DojfolIV"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C79A41BC2A;
	Sun, 18 Aug 2024 06:23:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723962197; cv=none; b=IA3vVDOrAJpCFKdW5Dr6WvvB9/7bIulI/yCHkV0xaZZ/MUEnDirjnNAAzuxEs7GMq/PBS50MjdEqPQji77aV4ERFQy288LK6JPfKfaEX8iaIiWnVpGKqnIrE+zGzoeFxwDvnCbEuMOEFjzm4zDUPqSkyqplnPrdMUGMhcpreQsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723962197; c=relaxed/simple;
	bh=OfBYAASQdKd5z5FIyGULEmMi5UhJwqnjlHexZYwX4Z0=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=NZwgcNdG7RnfCwM92RMn/4J0atMVsALuvPIr0XCkeVKjS3Nxgau98qELeXpk6nj0wUhZoceX5sTzICxGh+jrJ9L0M+2JeGTf5bSilm4csNvFAfvO6xLm71K38gDwyb8ZlWjOzTTaSYcTSSL6BbBw9Jtw1PgoMNXe5E1QZCtB61k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=J/n6cKcU; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=DojfolIV; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sun, 18 Aug 2024 06:23:10 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1723962191;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Uwrt/7oNpPb7VqOXl+yt82A8EoN/JrvDHmEf62b9Y/g=;
	b=J/n6cKcUV+b0VFI2wWrjQ9+9mIxtk5E8B8BEe5wMagknlj5Jdfcw+w28KnPANZzpg0fOnV
	v+CTglnyGcbIldzwX+QShsRqWU6kt3m18MpxVDvQkCSj0Vh4ZZNrtS6OV+kYqdipqyTRMU
	ffvOq403SUPzMXDaPgkn/g1IoHv2k2jZk0O/U0poFXjfLRRK8Yz/pxhnjL1jshMsY+exXV
	pj3za72rBrsx2lfHAbzqo8gEvRs8fv9icruiGc+8UwJZi4BEk2OdyTz2XMZSnrfISd91of
	aegHxK+9nr193c9E1GMFWOcukb4uQrvUYgytCSDL+ny8Ppq8mW/2Y8XuDhIA9A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1723962191;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Uwrt/7oNpPb7VqOXl+yt82A8EoN/JrvDHmEf62b9Y/g=;
	b=DojfolIVrJiZankJPA47t8hUC5fbpSqYvAxAGeTGLp/Tthb3EclEUQFRL/qcpdgdaUZCJ0
	AIwrXs5rFGk05uBg==
From: "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/fair: Re-organize dequeue_task_fair()
Cc: "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Valentin Schneider <vschneid@redhat.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240727105028.977256873@infradead.org>
References: <20240727105028.977256873@infradead.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172396219075.2215.11010708052044372414.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     fab4a808ba9fb59b691d7096eed9b1494812ffd6
Gitweb:        https://git.kernel.org/tip/fab4a808ba9fb59b691d7096eed9b1494812ffd6
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Wed, 03 Apr 2024 09:50:41 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Sat, 17 Aug 2024 11:06:41 +02:00

sched/fair: Re-organize dequeue_task_fair()

Working towards delaying dequeue, notably also inside the hierachy,
rework dequeue_task_fair() such that it can 'resume' an interrupted
hierarchy walk.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Valentin Schneider <vschneid@redhat.com>
Tested-by: Valentin Schneider <vschneid@redhat.com>
Link: https://lkml.kernel.org/r/20240727105028.977256873@infradead.org
---
 kernel/sched/fair.c | 62 +++++++++++++++++++++++++++++---------------
 1 file changed, 41 insertions(+), 21 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 03f76b3..59b00d7 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -6861,34 +6861,43 @@ enqueue_throttle:
 static void set_next_buddy(struct sched_entity *se);
 
 /*
- * The dequeue_task method is called before nr_running is
- * decreased. We remove the task from the rbtree and
- * update the fair scheduling stats:
+ * Basically dequeue_task_fair(), except it can deal with dequeue_entity()
+ * failing half-way through and resume the dequeue later.
+ *
+ * Returns:
+ * -1 - dequeue delayed
+ *  0 - dequeue throttled
+ *  1 - dequeue complete
  */
-static bool dequeue_task_fair(struct rq *rq, struct task_struct *p, int flags)
+static int dequeue_entities(struct rq *rq, struct sched_entity *se, int flags)
 {
-	struct cfs_rq *cfs_rq;
-	struct sched_entity *se = &p->se;
-	int task_sleep = flags & DEQUEUE_SLEEP;
-	int idle_h_nr_running = task_has_idle_policy(p);
 	bool was_sched_idle = sched_idle_rq(rq);
 	int rq_h_nr_running = rq->cfs.h_nr_running;
+	bool task_sleep = flags & DEQUEUE_SLEEP;
+	struct task_struct *p = NULL;
+	int idle_h_nr_running = 0;
+	int h_nr_running = 0;
+	struct cfs_rq *cfs_rq;
 
-	util_est_dequeue(&rq->cfs, p);
+	if (entity_is_task(se)) {
+		p = task_of(se);
+		h_nr_running = 1;
+		idle_h_nr_running = task_has_idle_policy(p);
+	}
 
 	for_each_sched_entity(se) {
 		cfs_rq = cfs_rq_of(se);
 		dequeue_entity(cfs_rq, se, flags);
 
-		cfs_rq->h_nr_running--;
+		cfs_rq->h_nr_running -= h_nr_running;
 		cfs_rq->idle_h_nr_running -= idle_h_nr_running;
 
 		if (cfs_rq_is_idle(cfs_rq))
-			idle_h_nr_running = 1;
+			idle_h_nr_running = h_nr_running;
 
 		/* end evaluation on encountering a throttled cfs_rq */
 		if (cfs_rq_throttled(cfs_rq))
-			goto dequeue_throttle;
+			return 0;
 
 		/* Don't dequeue parent if it has other entities besides us */
 		if (cfs_rq->load.weight) {
@@ -6912,20 +6921,18 @@ static bool dequeue_task_fair(struct rq *rq, struct task_struct *p, int flags)
 		se_update_runnable(se);
 		update_cfs_group(se);
 
-		cfs_rq->h_nr_running--;
+		cfs_rq->h_nr_running -= h_nr_running;
 		cfs_rq->idle_h_nr_running -= idle_h_nr_running;
 
 		if (cfs_rq_is_idle(cfs_rq))
-			idle_h_nr_running = 1;
+			idle_h_nr_running = h_nr_running;
 
 		/* end evaluation on encountering a throttled cfs_rq */
 		if (cfs_rq_throttled(cfs_rq))
-			goto dequeue_throttle;
-
+			return 0;
 	}
 
-	/* At this point se is NULL and we are at root level*/
-	sub_nr_running(rq, 1);
+	sub_nr_running(rq, h_nr_running);
 
 	if (rq_h_nr_running && !rq->cfs.h_nr_running)
 		dl_server_stop(&rq->fair_server);
@@ -6934,10 +6941,23 @@ static bool dequeue_task_fair(struct rq *rq, struct task_struct *p, int flags)
 	if (unlikely(!was_sched_idle && sched_idle_rq(rq)))
 		rq->next_balance = jiffies;
 
-dequeue_throttle:
-	util_est_update(&rq->cfs, p, task_sleep);
-	hrtick_update(rq);
+	return 1;
+}
+
+/*
+ * The dequeue_task method is called before nr_running is
+ * decreased. We remove the task from the rbtree and
+ * update the fair scheduling stats:
+ */
+static bool dequeue_task_fair(struct rq *rq, struct task_struct *p, int flags)
+{
+	util_est_dequeue(&rq->cfs, p);
+
+	if (dequeue_entities(rq, &p->se, flags) < 0)
+		return false;
 
+	util_est_update(&rq->cfs, p, flags & DEQUEUE_SLEEP);
+	hrtick_update(rq);
 	return true;
 }
 

