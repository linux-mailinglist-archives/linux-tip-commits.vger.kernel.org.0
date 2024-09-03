Return-Path: <linux-tip-commits+bounces-2149-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D1240969F27
	for <lists+linux-tip-commits@lfdr.de>; Tue,  3 Sep 2024 15:38:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 578341F251BA
	for <lists+linux-tip-commits@lfdr.de>; Tue,  3 Sep 2024 13:38:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC44A6FBF;
	Tue,  3 Sep 2024 13:38:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="eC5YmDie";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="GFqD0tPS"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C630F848E;
	Tue,  3 Sep 2024 13:38:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725370703; cv=none; b=YsjyB/kuXdFJZS9JUTrgJ5oZnOJd43syDOErObRO4WVV2rVe3X2ymxJUG75a94HLsD2AHk8fRwkajpHv7TbGumVVAV92w3M/Ci7jepvlcmZT2tt2MFP1Io04pR3q58xlVooctqqoczTtaK9eYbtaiNNU8iBY4lkZORptJOdfXaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725370703; c=relaxed/simple;
	bh=f68ZjQtnvlsf9LTPr+l2UFyI70CQQNwWkPx2rmu7EoE=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=gocna8r+vERJmcT8JLqp4GDmJD+/sQg/CVt6RBHOxjg2lKArQBxVNkP7N9gLEGCaOnMlYlD0svR8fZDmV/+iu3lv0k0+TohmVztE5+QoDmOcFy9pSQapxfmgBtGfU6+2kixLrE/4WdRtvTn7b9fkvsLRh4ah1H52A0TKQURPmXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=eC5YmDie; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=GFqD0tPS; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 03 Sep 2024 13:38:19 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1725370700;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hCFgDYNgAMe/vXESJUWXa/41jGmY/5HeE0Z2xKXKQUw=;
	b=eC5YmDie+AK7fvaRCRtiU2OacM/lQIrKvEP6J/cufUiuHMwSPsPBA3AM9oOB5emumEw3rj
	eHr+xPU3LSyMv/pzLDl110T0efqzuxQOd7zY3K/TRnVUBVkT9JMT/gVpI6GrUnlyyVDkZY
	r7j81WjNSZVRKooiqSf0tVRRv6+N1a+Nw+GY9X2OzJ+SJq6akBN/4Odb0lSjFa69SmYOtj
	dQelCfx7pHQgUHTs3O9aEON2vx0n83evz0wJUs4S1jLTn2kI5hrYNnLmNb0woD81NrKFSF
	9/RtfQa+aybpwpl6TUHF92yJbu3Z1lAcwcvGC+sDEuyMXhlVmFF8midXorbAbw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1725370700;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hCFgDYNgAMe/vXESJUWXa/41jGmY/5HeE0Z2xKXKQUw=;
	b=GFqD0tPStj3wIJhHXJVf0w488J4eF2bZObnsk+or9m0egriNERE22krBpyf9wOQ5BDXdgJ
	INYBdPUs/3fInsDw==
From: "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched: Rework dl_server
Cc: "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240813224016.259853414@infradead.org>
References: <20240813224016.259853414@infradead.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172537069975.2215.1739674532094234843.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     bd9bbc96e8356886971317f57994247ca491dbf1
Gitweb:        https://git.kernel.org/tip/bd9bbc96e8356886971317f57994247ca491dbf1
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Wed, 14 Aug 2024 00:25:55 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 03 Sep 2024 15:26:32 +02:00

sched: Rework dl_server

When a task is selected through a dl_server, it will have p->dl_server
set, such that it can account runtime to the dl_server, see
update_curr_task().

Currently p->dl_server is set in pick*task() whenever it goes through
the dl_server, clearing it is a bit of a mess though. The trivial
solution is clearing it on the final put (now that we have this
location).

However, this gives a problem when:

	p = pick_task(rq);
	if (p)
		put_prev_set_next_task(rq, prev, next);

picks the same task but through a different path, notably when it goes
from picking through the dl_server to a direct pick or vice-versa. In
that case we cannot readily determine wether we should clear or
preserve p->dl_server.

An additional complication is pick_*task() setting p->dl_server for a
remote pick, it might still need to update runtime before it schedules
the core_pick.

Close all these holes and remove all the random clearing of
p->dl_server by:

 - having pick_*task() manage rq->dl_server

 - having the final put_prev_task() clear p->dl_server

 - having the first set_next_task() set p->dl_server = rq->dl_server

 - complicate the core_sched code to save/restore rq->dl_server where
   appropriate.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/r/20240813224016.259853414@infradead.org
---
 kernel/sched/core.c     | 40 +++++++++++++++-------------------------
 kernel/sched/deadline.c |  2 +-
 kernel/sched/fair.c     | 10 ++--------
 kernel/sched/sched.h    | 14 ++++++++++++++-
 4 files changed, 32 insertions(+), 34 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 8a1cf93..ffcd637 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -3668,8 +3668,6 @@ ttwu_do_activate(struct rq *rq, struct task_struct *p, int wake_flags,
 		rq->idle_stamp = 0;
 	}
 #endif
-
-	p->dl_server = NULL;
 }
 
 /*
@@ -5859,14 +5857,6 @@ static void prev_balance(struct rq *rq, struct task_struct *prev,
 			break;
 	}
 #endif
-
-	/*
-	 * We've updated @prev and no longer need the server link, clear it.
-	 * Must be done before ->pick_next_task() because that can (re)set
-	 * ->dl_server.
-	 */
-	if (prev->dl_server)
-		prev->dl_server = NULL;
 }
 
 /*
@@ -5878,6 +5868,8 @@ __pick_next_task(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
 	const struct sched_class *class;
 	struct task_struct *p;
 
+	rq->dl_server = NULL;
+
 	/*
 	 * Optimization: we know that if all tasks are in the fair class we can
 	 * call that function directly, but only if the @prev task wasn't of a
@@ -5897,20 +5889,6 @@ __pick_next_task(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
 			put_prev_set_next_task(rq, prev, p);
 		}
 
-		/*
-		 * This is a normal CFS pick, but the previous could be a DL pick.
-		 * Clear it as previous is no longer picked.
-		 */
-		if (prev->dl_server)
-			prev->dl_server = NULL;
-
-		/*
-		 * This is the fast path; it cannot be a DL server pick;
-		 * therefore even if @p == @prev, ->dl_server must be NULL.
-		 */
-		if (p->dl_server)
-			p->dl_server = NULL;
-
 		return p;
 	}
 
@@ -5958,6 +5936,8 @@ static inline struct task_struct *pick_task(struct rq *rq)
 	const struct sched_class *class;
 	struct task_struct *p;
 
+	rq->dl_server = NULL;
+
 	for_each_class(class) {
 		p = class->pick_task(rq);
 		if (p)
@@ -5996,6 +5976,7 @@ pick_next_task(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
 		 * another cpu during offline.
 		 */
 		rq->core_pick = NULL;
+		rq->core_dl_server = NULL;
 		return __pick_next_task(rq, prev, rf);
 	}
 
@@ -6014,7 +5995,9 @@ pick_next_task(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
 		WRITE_ONCE(rq->core_sched_seq, rq->core->core_pick_seq);
 
 		next = rq->core_pick;
+		rq->dl_server = rq->core_dl_server;
 		rq->core_pick = NULL;
+		rq->core_dl_server = NULL;
 		goto out_set_next;
 	}
 
@@ -6059,6 +6042,7 @@ pick_next_task(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
 		next = pick_task(rq);
 		if (!next->core_cookie) {
 			rq->core_pick = NULL;
+			rq->core_dl_server = NULL;
 			/*
 			 * For robustness, update the min_vruntime_fi for
 			 * unconstrained picks as well.
@@ -6086,7 +6070,9 @@ pick_next_task(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
 		if (i != cpu && (rq_i != rq->core || !core_clock_updated))
 			update_rq_clock(rq_i);
 
-		p = rq_i->core_pick = pick_task(rq_i);
+		rq_i->core_pick = p = pick_task(rq_i);
+		rq_i->core_dl_server = rq_i->dl_server;
+
 		if (!max || prio_less(max, p, fi_before))
 			max = p;
 	}
@@ -6110,6 +6096,7 @@ pick_next_task(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
 		}
 
 		rq_i->core_pick = p;
+		rq_i->core_dl_server = NULL;
 
 		if (p == rq_i->idle) {
 			if (rq_i->nr_running) {
@@ -6170,6 +6157,7 @@ pick_next_task(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
 
 		if (i == cpu) {
 			rq_i->core_pick = NULL;
+			rq_i->core_dl_server = NULL;
 			continue;
 		}
 
@@ -6178,6 +6166,7 @@ pick_next_task(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
 
 		if (rq_i->curr == rq_i->core_pick) {
 			rq_i->core_pick = NULL;
+			rq_i->core_dl_server = NULL;
 			continue;
 		}
 
@@ -8401,6 +8390,7 @@ void __init sched_init(void)
 #ifdef CONFIG_SCHED_CORE
 		rq->core = rq;
 		rq->core_pick = NULL;
+		rq->core_dl_server = NULL;
 		rq->core_enabled = 0;
 		rq->core_tree = RB_ROOT;
 		rq->core_forceidle_count = 0;
diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index a1547e1..e83b684 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -2423,7 +2423,7 @@ again:
 			update_curr_dl_se(rq, dl_se, 0);
 			goto again;
 		}
-		p->dl_server = dl_se;
+		rq->dl_server = dl_se;
 	} else {
 		p = dl_task_of(dl_se);
 	}
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index c5b7873..f673112 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -8749,14 +8749,6 @@ again:
 		cfs_rq = group_cfs_rq(se);
 	} while (cfs_rq);
 
-	/*
-	 * This can be called from directly from CFS's ->pick_task() or indirectly
-	 * from DL's ->pick_task when fair server is enabled. In the indirect case,
-	 * DL will set ->dl_server just after this function is called, so its Ok to
-	 * clear. In the direct case, we are picking directly so we must clear it.
-	 */
-	task_of(se)->dl_server = NULL;
-
 	return task_of(se);
 }
 
@@ -8780,6 +8772,8 @@ again:
 	if (prev->sched_class != &fair_sched_class)
 		goto simple;
 
+	__put_prev_set_next_dl_server(rq, prev, p);
+
 	/*
 	 * Because of the set_next_buddy() in dequeue_task_fair() it is rather
 	 * likely that a next task is from the same cgroup as the current.
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index aae3581..2a216c9 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -1066,6 +1066,7 @@ struct rq {
 	unsigned int		nr_uninterruptible;
 
 	struct task_struct __rcu	*curr;
+	struct sched_dl_entity	*dl_server;
 	struct task_struct	*idle;
 	struct task_struct	*stop;
 	unsigned long		next_balance;
@@ -1193,6 +1194,7 @@ struct rq {
 	/* per rq */
 	struct rq		*core;
 	struct task_struct	*core_pick;
+	struct sched_dl_entity	*core_dl_server;
 	unsigned int		core_enabled;
 	unsigned int		core_sched_seq;
 	struct rb_root		core_tree;
@@ -2370,12 +2372,24 @@ static inline void set_next_task(struct rq *rq, struct task_struct *next)
 	next->sched_class->set_next_task(rq, next, false);
 }
 
+static inline void
+__put_prev_set_next_dl_server(struct rq *rq,
+			      struct task_struct *prev,
+			      struct task_struct *next)
+{
+	prev->dl_server = NULL;
+	next->dl_server = rq->dl_server;
+	rq->dl_server = NULL;
+}
+
 static inline void put_prev_set_next_task(struct rq *rq,
 					  struct task_struct *prev,
 					  struct task_struct *next)
 {
 	WARN_ON_ONCE(rq->curr != prev);
 
+	__put_prev_set_next_dl_server(rq, prev, next);
+
 	if (next == prev)
 		return;
 

