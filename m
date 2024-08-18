Return-Path: <linux-tip-commits+bounces-2065-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 86FDC955B30
	for <lists+linux-tip-commits@lfdr.de>; Sun, 18 Aug 2024 08:24:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 05BA1B212BA
	for <lists+linux-tip-commits@lfdr.de>; Sun, 18 Aug 2024 06:24:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 365E31862F;
	Sun, 18 Aug 2024 06:23:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="DzqXnLHz";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="aSa9WKL3"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E28AD15E86;
	Sun, 18 Aug 2024 06:23:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723962194; cv=none; b=SiKrVkulWCSPvI9MjizccHr9m8OZVT0DUzgXWnn8Iqw3e/FNuaoM27veHwLJ+myGtNAAKbs61qLCs/qQRYQB71prVjwzwNdjg7AO/g8BJrZB2Lag21WRamD6Mc+B20dB3B4IDp5Dnd4YSqRqfJ8AI0WPZKzJWlpsQPaqt8do9Y4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723962194; c=relaxed/simple;
	bh=RvzXxYY4Ug4tgi0oeX95q3qK5GMP4cbQwrRBqhoAUv0=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=s2aTAW9WfLWj/OS4VDeMMGH++dl9Z+2u5jMSkh5qwOoDla1D0q6Poqq5T0bMbjZf2n4RrPtlDqSXbRvjLL2yy7t7JvmfzhcMLPhJNJ9ntxgxZh9D/BB36L8iwauUkSozaAW3BLJnXMPRvK77joWRRSjbxKVzBk/V8wgqY0tQEm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=DzqXnLHz; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=aSa9WKL3; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sun, 18 Aug 2024 06:23:07 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1723962188;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tf29XoGTLB8rkg8x7MCxRIqiO6sBpmIxWfbkixgAP/w=;
	b=DzqXnLHz8aGqbRkS8C2Frb0pU6ECZIJZtIPPxKJtbIxgnpVLbDeh3F3ZOS3gakLWTt0Bei
	cnxEMIy0Dr2JmghViCoaqkn3XGNVrOIUI+jofhUNdVHo8pF+wcin1b9uJOqR4YHEmLFE+u
	JjYz7DcEKPTyXtq6GbH+favzwtx7jHmTQK8rwIBrsB0m5Xmi2AlxN33h02tdcI3Xp7e8kf
	L+IRWZ4Nga4C7R2KkiQD5s14/H+d4sidli0+e4RHCYRQs/b0DEJwj0fFongCYKON3/fYXj
	WBk8/R42IB0gOciaxUezmh/UfFwazsfdMLI+X7jxedzM1BTdOdVhS9Ez3DDcWA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1723962188;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tf29XoGTLB8rkg8x7MCxRIqiO6sBpmIxWfbkixgAP/w=;
	b=aSa9WKL31YSyNK7JvuIyVYqiH5L4D6o8gjsp4lTPf5F+annElRUlLZGGfR7D5dmwQN/SRf
	FmjViTCUO4iSW+CQ==
From: "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/fair: Implement delayed dequeue
Cc: "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Valentin Schneider <vschneid@redhat.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240727105030.226163742@infradead.org>
References: <20240727105030.226163742@infradead.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172396218770.2215.10414003605653657609.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     152e11f6df293e816a6a37c69757033cdc72667d
Gitweb:        https://git.kernel.org/tip/152e11f6df293e816a6a37c69757033cdc72667d
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Thu, 23 May 2024 12:25:32 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Sat, 17 Aug 2024 11:06:44 +02:00

sched/fair: Implement delayed dequeue

Extend / fix 86bfbb7ce4f6 ("sched/fair: Add lag based placement") by
noting that lag is fundamentally a temporal measure. It should not be
carried around indefinitely.

OTOH it should also not be instantly discarded, doing so will allow a
task to game the system by purposefully (micro) sleeping at the end of
its time quantum.

Since lag is intimately tied to the virtual time base, a wall-time
based decay is also insufficient, notably competition is required for
any of this to make sense.

Instead, delay the dequeue and keep the 'tasks' on the runqueue,
competing until they are eligible.

Strictly speaking, we only care about keeping them until the 0-lag
point, but that is a difficult proposition, instead carry them around
until they get picked again, and dequeue them at that point.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Valentin Schneider <vschneid@redhat.com>
Tested-by: Valentin Schneider <vschneid@redhat.com>
Link: https://lkml.kernel.org/r/20240727105030.226163742@infradead.org
---
 kernel/sched/deadline.c |  1 +-
 kernel/sched/fair.c     | 80 +++++++++++++++++++++++++++++++++++-----
 kernel/sched/features.h |  9 +++++-
 3 files changed, 79 insertions(+), 11 deletions(-)

diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index bbaeace..0f2df67 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -2428,7 +2428,6 @@ again:
 		else
 			p = dl_se->server_pick_next(dl_se);
 		if (!p) {
-			WARN_ON_ONCE(1);
 			dl_se->dl_yielded = 1;
 			update_curr_dl_se(rq, dl_se, 0);
 			goto again;
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 25b14df..da5065a 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -5379,20 +5379,39 @@ static void clear_buddies(struct cfs_rq *cfs_rq, struct sched_entity *se)
 
 static __always_inline void return_cfs_rq_runtime(struct cfs_rq *cfs_rq);
 
-static void
+static bool
 dequeue_entity(struct cfs_rq *cfs_rq, struct sched_entity *se, int flags)
 {
-	int action = UPDATE_TG;
+	update_curr(cfs_rq);
+
+	if (flags & DEQUEUE_DELAYED) {
+		SCHED_WARN_ON(!se->sched_delayed);
+	} else {
+		bool sleep = flags & DEQUEUE_SLEEP;
 
+		/*
+		 * DELAY_DEQUEUE relies on spurious wakeups, special task
+		 * states must not suffer spurious wakeups, excempt them.
+		 */
+		if (flags & DEQUEUE_SPECIAL)
+			sleep = false;
+
+		SCHED_WARN_ON(sleep && se->sched_delayed);
+
+		if (sched_feat(DELAY_DEQUEUE) && sleep &&
+		    !entity_eligible(cfs_rq, se)) {
+			if (cfs_rq->next == se)
+				cfs_rq->next = NULL;
+			se->sched_delayed = 1;
+			return false;
+		}
+	}
+
+	int action = UPDATE_TG;
 	if (entity_is_task(se) && task_on_rq_migrating(task_of(se)))
 		action |= DO_DETACH;
 
 	/*
-	 * Update run-time statistics of the 'current'.
-	 */
-	update_curr(cfs_rq);
-
-	/*
 	 * When dequeuing a sched_entity, we must:
 	 *   - Update loads to have both entity and cfs_rq synced with now.
 	 *   - For group_entity, update its runnable_weight to reflect the new
@@ -5428,8 +5447,13 @@ dequeue_entity(struct cfs_rq *cfs_rq, struct sched_entity *se, int flags)
 	if ((flags & (DEQUEUE_SAVE | DEQUEUE_MOVE)) != DEQUEUE_SAVE)
 		update_min_vruntime(cfs_rq);
 
+	if (flags & DEQUEUE_DELAYED)
+		se->sched_delayed = 0;
+
 	if (cfs_rq->nr_running == 0)
 		update_idle_cfs_rq_clock_pelt(cfs_rq);
+
+	return true;
 }
 
 static void
@@ -5828,11 +5852,21 @@ static bool throttle_cfs_rq(struct cfs_rq *cfs_rq)
 	idle_task_delta = cfs_rq->idle_h_nr_running;
 	for_each_sched_entity(se) {
 		struct cfs_rq *qcfs_rq = cfs_rq_of(se);
+		int flags;
+
 		/* throttled entity or throttle-on-deactivate */
 		if (!se->on_rq)
 			goto done;
 
-		dequeue_entity(qcfs_rq, se, DEQUEUE_SLEEP);
+		/*
+		 * Abuse SPECIAL to avoid delayed dequeue in this instance.
+		 * This avoids teaching dequeue_entities() about throttled
+		 * entities and keeps things relatively simple.
+		 */
+		flags = DEQUEUE_SLEEP | DEQUEUE_SPECIAL;
+		if (se->sched_delayed)
+			flags |= DEQUEUE_DELAYED;
+		dequeue_entity(qcfs_rq, se, flags);
 
 		if (cfs_rq_is_idle(group_cfs_rq(se)))
 			idle_task_delta = cfs_rq->h_nr_running;
@@ -6918,6 +6952,7 @@ static int dequeue_entities(struct rq *rq, struct sched_entity *se, int flags)
 	bool was_sched_idle = sched_idle_rq(rq);
 	int rq_h_nr_running = rq->cfs.h_nr_running;
 	bool task_sleep = flags & DEQUEUE_SLEEP;
+	bool task_delayed = flags & DEQUEUE_DELAYED;
 	struct task_struct *p = NULL;
 	int idle_h_nr_running = 0;
 	int h_nr_running = 0;
@@ -6931,7 +6966,13 @@ static int dequeue_entities(struct rq *rq, struct sched_entity *se, int flags)
 
 	for_each_sched_entity(se) {
 		cfs_rq = cfs_rq_of(se);
-		dequeue_entity(cfs_rq, se, flags);
+
+		if (!dequeue_entity(cfs_rq, se, flags)) {
+			if (p && &p->se == se)
+				return -1;
+
+			break;
+		}
 
 		cfs_rq->h_nr_running -= h_nr_running;
 		cfs_rq->idle_h_nr_running -= idle_h_nr_running;
@@ -6956,6 +6997,7 @@ static int dequeue_entities(struct rq *rq, struct sched_entity *se, int flags)
 			break;
 		}
 		flags |= DEQUEUE_SLEEP;
+		flags &= ~(DEQUEUE_DELAYED | DEQUEUE_SPECIAL);
 	}
 
 	for_each_sched_entity(se) {
@@ -6985,6 +7027,17 @@ static int dequeue_entities(struct rq *rq, struct sched_entity *se, int flags)
 	if (unlikely(!was_sched_idle && sched_idle_rq(rq)))
 		rq->next_balance = jiffies;
 
+	if (p && task_delayed) {
+		SCHED_WARN_ON(!task_sleep);
+		SCHED_WARN_ON(p->on_rq != 1);
+
+		/* Fix-up what dequeue_task_fair() skipped */
+		hrtick_update(rq);
+
+		/* Fix-up what block_task() skipped. */
+		__block_task(rq, p);
+	}
+
 	return 1;
 }
 
@@ -6997,8 +7050,10 @@ static bool dequeue_task_fair(struct rq *rq, struct task_struct *p, int flags)
 {
 	util_est_dequeue(&rq->cfs, p);
 
-	if (dequeue_entities(rq, &p->se, flags) < 0)
+	if (dequeue_entities(rq, &p->se, flags) < 0) {
+		util_est_update(&rq->cfs, p, DEQUEUE_SLEEP);
 		return false;
+	}
 
 	util_est_update(&rq->cfs, p, flags & DEQUEUE_SLEEP);
 	hrtick_update(rq);
@@ -12971,6 +13026,11 @@ static void set_next_task_fair(struct rq *rq, struct task_struct *p, bool first)
 		/* ensure bandwidth has been allocated on our new cfs_rq */
 		account_cfs_rq_runtime(cfs_rq, 0);
 	}
+
+	if (!first)
+		return;
+
+	SCHED_WARN_ON(se->sched_delayed);
 }
 
 void init_cfs_rq(struct cfs_rq *cfs_rq)
diff --git a/kernel/sched/features.h b/kernel/sched/features.h
index 97fb2d4..1feaa7b 100644
--- a/kernel/sched/features.h
+++ b/kernel/sched/features.h
@@ -29,6 +29,15 @@ SCHED_FEAT(NEXT_BUDDY, false)
 SCHED_FEAT(CACHE_HOT_BUDDY, true)
 
 /*
+ * Delay dequeueing tasks until they get selected or woken.
+ *
+ * By delaying the dequeue for non-eligible tasks, they remain in the
+ * competition and can burn off their negative lag. When they get selected
+ * they'll have positive lag by definition.
+ */
+SCHED_FEAT(DELAY_DEQUEUE, true)
+
+/*
  * Allow wakeup-time preemption of the current task:
  */
 SCHED_FEAT(WAKEUP_PREEMPTION, true)

