Return-Path: <linux-tip-commits+bounces-1789-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CC7693F2C5
	for <lists+linux-tip-commits@lfdr.de>; Mon, 29 Jul 2024 12:34:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1B5961F2269F
	for <lists+linux-tip-commits@lfdr.de>; Mon, 29 Jul 2024 10:34:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7924174055;
	Mon, 29 Jul 2024 10:34:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="TYPpS1Wf";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="xb0Q1ETf"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D031E142E60;
	Mon, 29 Jul 2024 10:34:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722249245; cv=none; b=sbZrSEK6mg7+jQo5tf8iWgqqyxudHEUe4e3fRxbdxd/j4z2ALzuhCS9swqZklkFrokAz+cLqiNyu9AGcjumZlGPlNfPrxHCGdhl69Wh5jOi0eaABKMRGUepVUJmZftEyB/PCLGSYGfLTaTctqVCHvfOmYGtup2AJskAhL6BvQJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722249245; c=relaxed/simple;
	bh=GXykx07upjboy+rQvDxyBu6yu0XCtZFcn5nwlGy1Z30=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=KvL3C10mCvE8sBMqKOj9x5Mr2Ii7ikCWfe6QWLhLDe+hlhMnREZIqHFraVMNs+xIQ111mQKxBD/IdlkxyBLk9Gqid0lVo8lZJTBNFGuyy9GeHLBxc/jgVV8AkhxFU8WOdMlGaahZoJ4EfuPEYPU6EPzBFKNdHFA4Dwe7HRi/qi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=TYPpS1Wf; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=xb0Q1ETf; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 29 Jul 2024 10:34:01 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1722249242;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=KkSh9HmgnIEc7i9rWYjamN9DQ+ha7qGBOUyx7dNUbkE=;
	b=TYPpS1WftVmW8Uws553XTFL/L3xFXMygaBoIKC3/3QmHLZE0dkf4zmbb5PYvDwlrHrLxAO
	6KCbjlZURq3x11EUfz4WmDhuU9bgqA/GJVlR0lH7CIMkHPAw2rXBpG0cxyZoBTkd072RC2
	na/zdrFouSGQpVke5QSk0EwcmfWgcJ8uUZYW5A8FQWtzUQ8mT9nuxl/JIjDxeGt/kZ/ony
	2Q/X+S+Rdk0/jaWqHYu/ImdnYk3A66igoHrQ4iyZW15bXzrNFIvYliphkI3wPj+zm2ZA5/
	LcCicl3trX38Bunb2lxnAzrV6xJI5MOGag5b1kaBVyJTZBXwGYCCWx9hlPbDiw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1722249242;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=KkSh9HmgnIEc7i9rWYjamN9DQ+ha7qGBOUyx7dNUbkE=;
	b=xb0Q1ETfQ0GDAWdCxAVWnntjWmTFJd4u+pLHDUdtpK18MkCBK720vY2uzobt+eyEjS9okU
	9vEaAqtcwn1aceDQ==
From: "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/fair: Cleanup fair_server
Cc: "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172224924149.2215.6350653470281116147.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     cea5a3472ac43f18590e1bd6b842f808347a810c
Gitweb:        https://git.kernel.org/tip/cea5a3472ac43f18590e1bd6b842f808347a810c
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Fri, 26 Jul 2024 16:27:04 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 29 Jul 2024 12:22:37 +02:00

sched/fair: Cleanup fair_server

The throttle interaction made my brain hurt, make it consistently
about 0 transitions of h_nr_running.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 kernel/sched/fair.c | 32 +++++++++++++++++---------------
 1 file changed, 17 insertions(+), 15 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index ee251ac..795ceef 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -5849,10 +5849,10 @@ static bool throttle_cfs_rq(struct cfs_rq *cfs_rq)
 	/* At this point se is NULL and we are at root level*/
 	sub_nr_running(rq, task_delta);
 
-done:
 	/* Stop the fair server if throttling resulted in no runnable tasks */
 	if (rq_h_nr_running && !rq->cfs.h_nr_running)
 		dl_server_stop(&rq->fair_server);
+done:
 	/*
 	 * Note: distribution will already see us throttled via the
 	 * throttled-list.  rq->lock protects completion.
@@ -5940,16 +5940,16 @@ void unthrottle_cfs_rq(struct cfs_rq *cfs_rq)
 			goto unthrottle_throttle;
 	}
 
+	/* Start the fair server if un-throttling resulted in new runnable tasks */
+	if (!rq_h_nr_running && rq->cfs.h_nr_running)
+		dl_server_start(&rq->fair_server);
+
 	/* At this point se is NULL and we are at root level*/
 	add_nr_running(rq, task_delta);
 
 unthrottle_throttle:
 	assert_list_leaf_cfs_rq(rq);
 
-	/* Start the fair server if un-throttling resulted in new runnable tasks */
-	if (!rq_h_nr_running && rq->cfs.h_nr_running)
-		dl_server_start(&rq->fair_server);
-
 	/* Determine whether we need to wake up potentially idle CPU: */
 	if (rq->curr == rq->idle && rq->cfs.nr_running)
 		resched_curr(rq);
@@ -6771,6 +6771,7 @@ enqueue_task_fair(struct rq *rq, struct task_struct *p, int flags)
 	struct sched_entity *se = &p->se;
 	int idle_h_nr_running = task_has_idle_policy(p);
 	int task_new = !(flags & ENQUEUE_WAKEUP);
+	int rq_h_nr_running = rq->cfs.h_nr_running;
 
 	/*
 	 * The code below (indirectly) updates schedutil which looks at
@@ -6780,13 +6781,6 @@ enqueue_task_fair(struct rq *rq, struct task_struct *p, int flags)
 	 */
 	util_est_enqueue(&rq->cfs, p);
 
-	if (!throttled_hierarchy(task_cfs_rq(p)) && !rq->cfs.h_nr_running) {
-		/* Account for idle runtime */
-		if (!rq->nr_running)
-			dl_server_update_idle_time(rq, rq->curr);
-		dl_server_start(&rq->fair_server);
-	}
-
 	/*
 	 * If in_iowait is set, the code below may not trigger any cpufreq
 	 * utilization updates, so do it here explicitly with the IOWAIT flag
@@ -6832,6 +6826,13 @@ enqueue_task_fair(struct rq *rq, struct task_struct *p, int flags)
 			goto enqueue_throttle;
 	}
 
+	if (!rq_h_nr_running && rq->cfs.h_nr_running) {
+		/* Account for idle runtime */
+		if (!rq->nr_running)
+			dl_server_update_idle_time(rq, rq->curr);
+		dl_server_start(&rq->fair_server);
+	}
+
 	/* At this point se is NULL and we are at root level*/
 	add_nr_running(rq, 1);
 
@@ -6872,6 +6873,7 @@ static void dequeue_task_fair(struct rq *rq, struct task_struct *p, int flags)
 	int task_sleep = flags & DEQUEUE_SLEEP;
 	int idle_h_nr_running = task_has_idle_policy(p);
 	bool was_sched_idle = sched_idle_rq(rq);
+	int rq_h_nr_running = rq->cfs.h_nr_running;
 
 	util_est_dequeue(&rq->cfs, p);
 
@@ -6926,14 +6928,14 @@ static void dequeue_task_fair(struct rq *rq, struct task_struct *p, int flags)
 	/* At this point se is NULL and we are at root level*/
 	sub_nr_running(rq, 1);
 
+	if (rq_h_nr_running && !rq->cfs.h_nr_running)
+		dl_server_stop(&rq->fair_server);
+
 	/* balance early to pull high priority tasks */
 	if (unlikely(!was_sched_idle && sched_idle_rq(rq)))
 		rq->next_balance = jiffies;
 
 dequeue_throttle:
-	if (!throttled_hierarchy(task_cfs_rq(p)) && !rq->cfs.h_nr_running)
-		dl_server_stop(&rq->fair_server);
-
 	util_est_update(&rq->cfs, p, task_sleep);
 	hrtick_update(rq);
 }

