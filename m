Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C38940491D
	for <lists+linux-tip-commits@lfdr.de>; Thu,  9 Sep 2021 13:18:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235821AbhIILTu (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Thu, 9 Sep 2021 07:19:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235525AbhIILTl (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Thu, 9 Sep 2021 07:19:41 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D861C061757;
        Thu,  9 Sep 2021 04:18:32 -0700 (PDT)
Date:   Thu, 09 Sep 2021 11:18:30 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1631186311;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Bq2QnkBgStzNrOyYMIkJQOuGJ9Se60aJNexDaiL5hXY=;
        b=w/zRGKpdRbOXz+vyqH3e7Sj/P/DGjwSqWBpRkysEBMHSqUDEGyeZswqvDxgVtbudcmNWGL
        vQ6XNWIcBFYfFTYeYlIbzkDqw2uhdFgJuZ4DIfrAY07+qkqfdb3TxXDRkq6VZDHCixgBzP
        YNIseiddIjTe10oCgSzvORtfOLDCc16YF2746WIBNAXeAqfhC1TWKmJjrmRjtXXxkwzYCz
        lvY9KfzkJK49zt9pTlWaLf5hk+FBStl9S0DFeKUgV29vmLoX5QBcGx9XHhaCHHJ8aFhXb7
        NHTgH5WEaJPApQ5mNPAKdcejF6ynAshDC+9VOhcbWN3b3kflp41IM22LNIWZRQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1631186311;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Bq2QnkBgStzNrOyYMIkJQOuGJ9Se60aJNexDaiL5hXY=;
        b=W7ATd15oF67nlr7twzBGWukCjf/FZu80D78Wih7tZQ73HeUAYOmSE9+eX4GNTR0Z8yvn6p
        ER83Y5Mi7+YYrECg==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/core: Simplify core-wide task selection
Cc:     Tao Zhou <tao.zhou@linux.dev>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Josh Don <joshdon@google.com>,
        "Vineeth Pillai (Microsoft)" <vineethrp@gmail.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <YSS9+k1teA9oPEKl@hirez.programming.kicks-ass.net>
References: <YSS9+k1teA9oPEKl@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Message-ID: <163118631011.25758.9034385352078093883.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     4b2b9ed7b987eb6243b609095fe5c8c65340e5ee
Gitweb:        https://git.kernel.org/tip/4b2b9ed7b987eb6243b609095fe5c8c65340e5ee
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Tue, 24 Aug 2021 11:05:47 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Thu, 09 Sep 2021 11:27:30 +02:00

sched/core: Simplify core-wide task selection

Tao suggested a two-pass task selection to avoid the retry loop.

Not only does it avoid the retry loop, it results in *much* simpler
code.

This also fixes an issue spotted by Josh Don where, for SMT3+, we can
forget to update max on the first pass and get to do an extra round.

Suggested-by: Tao Zhou <tao.zhou@linux.dev>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Josh Don <joshdon@google.com>
Reviewed-by: Vineeth Pillai (Microsoft) <vineethrp@gmail.com>
Link: https://lkml.kernel.org/r/YSS9+k1teA9oPEKl@hirez.programming.kicks-ass.net
---
 kernel/sched/core.c | 156 ++++++++++++-------------------------------
 1 file changed, 45 insertions(+), 111 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index d19d1ba..953ff36 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -5518,8 +5518,7 @@ restart:
 			return p;
 	}
 
-	/* The idle class should always have a runnable task: */
-	BUG();
+	BUG(); /* The idle class should always have a runnable task. */
 }
 
 #ifdef CONFIG_SCHED_CORE
@@ -5541,54 +5540,18 @@ static inline bool cookie_match(struct task_struct *a, struct task_struct *b)
 	return a->core_cookie == b->core_cookie;
 }
 
-// XXX fairness/fwd progress conditions
-/*
- * Returns
- * - NULL if there is no runnable task for this class.
- * - the highest priority task for this runqueue if it matches
- *   rq->core->core_cookie or its priority is greater than max.
- * - Else returns idle_task.
- */
-static struct task_struct *
-pick_task(struct rq *rq, const struct sched_class *class, struct task_struct *max, bool in_fi)
+static inline struct task_struct *pick_task(struct rq *rq)
 {
-	struct task_struct *class_pick, *cookie_pick;
-	unsigned long cookie = rq->core->core_cookie;
-
-	class_pick = class->pick_task(rq);
-	if (!class_pick)
-		return NULL;
-
-	if (!cookie) {
-		/*
-		 * If class_pick is tagged, return it only if it has
-		 * higher priority than max.
-		 */
-		if (max && class_pick->core_cookie &&
-		    prio_less(class_pick, max, in_fi))
-			return idle_sched_class.pick_task(rq);
+	const struct sched_class *class;
+	struct task_struct *p;
 
-		return class_pick;
+	for_each_class(class) {
+		p = class->pick_task(rq);
+		if (p)
+			return p;
 	}
 
-	/*
-	 * If class_pick is idle or matches cookie, return early.
-	 */
-	if (cookie_equals(class_pick, cookie))
-		return class_pick;
-
-	cookie_pick = sched_core_find(rq, cookie);
-
-	/*
-	 * If class > max && class > cookie, it is the highest priority task on
-	 * the core (so far) and it must be selected, otherwise we must go with
-	 * the cookie pick in order to satisfy the constraint.
-	 */
-	if (prio_less(cookie_pick, class_pick, in_fi) &&
-	    (!max || prio_less(max, class_pick, in_fi)))
-		return class_pick;
-
-	return cookie_pick;
+	BUG(); /* The idle class should always have a runnable task. */
 }
 
 extern void task_vruntime_update(struct rq *rq, struct task_struct *p, bool in_fi);
@@ -5596,11 +5559,12 @@ extern void task_vruntime_update(struct rq *rq, struct task_struct *p, bool in_f
 static struct task_struct *
 pick_next_task(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
 {
-	struct task_struct *next, *max = NULL;
-	const struct sched_class *class;
+	struct task_struct *next, *p, *max = NULL;
 	const struct cpumask *smt_mask;
 	bool fi_before = false;
-	int i, j, cpu, occ = 0;
+	unsigned long cookie;
+	int i, cpu, occ = 0;
+	struct rq *rq_i;
 	bool need_sync;
 
 	if (!sched_core_enabled(rq))
@@ -5673,12 +5637,7 @@ pick_next_task(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
 	 * and there are no cookied tasks running on siblings.
 	 */
 	if (!need_sync) {
-		for_each_class(class) {
-			next = class->pick_task(rq);
-			if (next)
-				break;
-		}
-
+		next = pick_task(rq);
 		if (!next->core_cookie) {
 			rq->core_pick = NULL;
 			/*
@@ -5691,76 +5650,51 @@ pick_next_task(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
 		}
 	}
 
-	for_each_cpu(i, smt_mask) {
-		struct rq *rq_i = cpu_rq(i);
-
-		rq_i->core_pick = NULL;
+	/*
+	 * For each thread: do the regular task pick and find the max prio task
+	 * amongst them.
+	 *
+	 * Tie-break prio towards the current CPU
+	 */
+	for_each_cpu_wrap(i, smt_mask, cpu) {
+		rq_i = cpu_rq(i);
 
 		if (i != cpu)
 			update_rq_clock(rq_i);
+
+		p = rq_i->core_pick = pick_task(rq_i);
+		if (!max || prio_less(max, p, fi_before))
+			max = p;
 	}
 
+	cookie = rq->core->core_cookie = max->core_cookie;
+
 	/*
-	 * Try and select tasks for each sibling in descending sched_class
-	 * order.
+	 * For each thread: try and find a runnable task that matches @max or
+	 * force idle.
 	 */
-	for_each_class(class) {
-again:
-		for_each_cpu_wrap(i, smt_mask, cpu) {
-			struct rq *rq_i = cpu_rq(i);
-			struct task_struct *p;
-
-			if (rq_i->core_pick)
-				continue;
+	for_each_cpu(i, smt_mask) {
+		rq_i = cpu_rq(i);
+		p = rq_i->core_pick;
 
-			/*
-			 * If this sibling doesn't yet have a suitable task to
-			 * run; ask for the most eligible task, given the
-			 * highest priority task already selected for this
-			 * core.
-			 */
-			p = pick_task(rq_i, class, max, fi_before);
+		if (!cookie_equals(p, cookie)) {
+			p = NULL;
+			if (cookie)
+				p = sched_core_find(rq_i, cookie);
 			if (!p)
-				continue;
+				p = idle_sched_class.pick_task(rq_i);
+		}
 
-			if (!is_task_rq_idle(p))
-				occ++;
+		rq_i->core_pick = p;
 
-			rq_i->core_pick = p;
-			if (rq_i->idle == p && rq_i->nr_running) {
+		if (p == rq_i->idle) {
+			if (rq_i->nr_running) {
 				rq->core->core_forceidle = true;
 				if (!fi_before)
 					rq->core->core_forceidle_seq++;
 			}
-
-			/*
-			 * If this new candidate is of higher priority than the
-			 * previous; and they're incompatible; we need to wipe
-			 * the slate and start over. pick_task makes sure that
-			 * p's priority is more than max if it doesn't match
-			 * max's cookie.
-			 *
-			 * NOTE: this is a linear max-filter and is thus bounded
-			 * in execution time.
-			 */
-			if (!max || !cookie_match(max, p)) {
-				struct task_struct *old_max = max;
-
-				rq->core->core_cookie = p->core_cookie;
-				max = p;
-
-				if (old_max) {
-					rq->core->core_forceidle = false;
-					for_each_cpu(j, smt_mask) {
-						if (j == i)
-							continue;
-
-						cpu_rq(j)->core_pick = NULL;
-					}
-					occ = 1;
-					goto again;
-				}
-			}
+		} else {
+			occ++;
 		}
 	}
 
@@ -5780,7 +5714,7 @@ again:
 	 * non-matching user state.
 	 */
 	for_each_cpu(i, smt_mask) {
-		struct rq *rq_i = cpu_rq(i);
+		rq_i = cpu_rq(i);
 
 		/*
 		 * An online sibling might have gone offline before a task
