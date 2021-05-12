Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE06137BA5F
	for <lists+linux-tip-commits@lfdr.de>; Wed, 12 May 2021 12:28:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230375AbhELK3f (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 12 May 2021 06:29:35 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:50450 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230300AbhELK3d (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 12 May 2021 06:29:33 -0400
Date:   Wed, 12 May 2021 10:28:24 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1620815305;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+Ikb/Y6JNPtXr7qFgakA6WQGAtdNJo7DfNZ31t/U5PI=;
        b=txFHBu1fYhpJNimum+82SC6y2+gt47dwkMHtQeEQhC4iNifkrvecUiqKX8pWq2kpVMgrpA
        vcRtrFDopqtgrummcOdtSPJUFuJthuSRgJ6mfIa4xRoWWItGo+fKMAGGLRB/0Xmfqs2m04
        34WwFUshXM9qniP+VN5S05cgpv/Tnkn6Q1Qm4PBHIFOOP6TzfAIxJeD4vy3mJeL9lZuAu1
        smSrFO/n1IyAsaezw3tf96qjVj/3Geu0O/MXkpo1s1KXyZCusifxR3eVJW6XgkUFYgjSdH
        CcL7in63/gSXZj+tLDfcQfzUZU6+XC0z5U0aGlkDipjddzCEW8SNAefPKguOzA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1620815305;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+Ikb/Y6JNPtXr7qFgakA6WQGAtdNJo7DfNZ31t/U5PI=;
        b=wcoPoY7PI1wVqvO+Uof1WqJpjHIzFlcYeNRE4b7Hd+cTTlePYacEQNM4Gs2dY2Qe3J5N16
        pyy8/aENUTCM4bBg==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched: Add core wide task selection and scheduling
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Don Hiatt <dhiatt@digitalocean.com>,
        Hongyu Ning <hongyu.ning@linux.intel.com>,
        Vincent Guittot <vincent.guittot@linaro.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210422123308.557559654@infradead.org>
References: <20210422123308.557559654@infradead.org>
MIME-Version: 1.0
Message-ID: <162081530440.29796.4267709137372239781.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     539f65125d20aacab54d02d77f10a839f45b09dc
Gitweb:        https://git.kernel.org/tip/539f65125d20aacab54d02d77f10a839f45b09dc
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Tue, 17 Nov 2020 18:19:37 -05:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 12 May 2021 11:43:28 +02:00

sched: Add core wide task selection and scheduling

Instead of only selecting a local task, select a task for all SMT
siblings for every reschedule on the core (irrespective which logical
CPU does the reschedule).

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Tested-by: Don Hiatt <dhiatt@digitalocean.com>
Tested-by: Hongyu Ning <hongyu.ning@linux.intel.com>
Tested-by: Vincent Guittot <vincent.guittot@linaro.org>
Link: https://lkml.kernel.org/r/20210422123308.557559654@infradead.org
---
 kernel/sched/core.c  | 301 +++++++++++++++++++++++++++++++++++++++++-
 kernel/sched/sched.h |   6 +-
 2 files changed, 305 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index c057d47..db763f4 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -5282,7 +5282,7 @@ static void put_prev_task_balance(struct rq *rq, struct task_struct *prev,
  * Pick up the highest-prio task:
  */
 static inline struct task_struct *
-pick_next_task(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
+__pick_next_task(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
 {
 	const struct sched_class *class;
 	struct task_struct *p;
@@ -5323,6 +5323,294 @@ restart:
 }
 
 #ifdef CONFIG_SCHED_CORE
+static inline bool is_task_rq_idle(struct task_struct *t)
+{
+	return (task_rq(t)->idle == t);
+}
+
+static inline bool cookie_equals(struct task_struct *a, unsigned long cookie)
+{
+	return is_task_rq_idle(a) || (a->core_cookie == cookie);
+}
+
+static inline bool cookie_match(struct task_struct *a, struct task_struct *b)
+{
+	if (is_task_rq_idle(a) || is_task_rq_idle(b))
+		return true;
+
+	return a->core_cookie == b->core_cookie;
+}
+
+// XXX fairness/fwd progress conditions
+/*
+ * Returns
+ * - NULL if there is no runnable task for this class.
+ * - the highest priority task for this runqueue if it matches
+ *   rq->core->core_cookie or its priority is greater than max.
+ * - Else returns idle_task.
+ */
+static struct task_struct *
+pick_task(struct rq *rq, const struct sched_class *class, struct task_struct *max)
+{
+	struct task_struct *class_pick, *cookie_pick;
+	unsigned long cookie = rq->core->core_cookie;
+
+	class_pick = class->pick_task(rq);
+	if (!class_pick)
+		return NULL;
+
+	if (!cookie) {
+		/*
+		 * If class_pick is tagged, return it only if it has
+		 * higher priority than max.
+		 */
+		if (max && class_pick->core_cookie &&
+		    prio_less(class_pick, max))
+			return idle_sched_class.pick_task(rq);
+
+		return class_pick;
+	}
+
+	/*
+	 * If class_pick is idle or matches cookie, return early.
+	 */
+	if (cookie_equals(class_pick, cookie))
+		return class_pick;
+
+	cookie_pick = sched_core_find(rq, cookie);
+
+	/*
+	 * If class > max && class > cookie, it is the highest priority task on
+	 * the core (so far) and it must be selected, otherwise we must go with
+	 * the cookie pick in order to satisfy the constraint.
+	 */
+	if (prio_less(cookie_pick, class_pick) &&
+	    (!max || prio_less(max, class_pick)))
+		return class_pick;
+
+	return cookie_pick;
+}
+
+static struct task_struct *
+pick_next_task(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
+{
+	struct task_struct *next, *max = NULL;
+	const struct sched_class *class;
+	const struct cpumask *smt_mask;
+	bool need_sync;
+	int i, j, cpu;
+
+	if (!sched_core_enabled(rq))
+		return __pick_next_task(rq, prev, rf);
+
+	cpu = cpu_of(rq);
+
+	/* Stopper task is switching into idle, no need core-wide selection. */
+	if (cpu_is_offline(cpu)) {
+		/*
+		 * Reset core_pick so that we don't enter the fastpath when
+		 * coming online. core_pick would already be migrated to
+		 * another cpu during offline.
+		 */
+		rq->core_pick = NULL;
+		return __pick_next_task(rq, prev, rf);
+	}
+
+	/*
+	 * If there were no {en,de}queues since we picked (IOW, the task
+	 * pointers are all still valid), and we haven't scheduled the last
+	 * pick yet, do so now.
+	 *
+	 * rq->core_pick can be NULL if no selection was made for a CPU because
+	 * it was either offline or went offline during a sibling's core-wide
+	 * selection. In this case, do a core-wide selection.
+	 */
+	if (rq->core->core_pick_seq == rq->core->core_task_seq &&
+	    rq->core->core_pick_seq != rq->core_sched_seq &&
+	    rq->core_pick) {
+		WRITE_ONCE(rq->core_sched_seq, rq->core->core_pick_seq);
+
+		next = rq->core_pick;
+		if (next != prev) {
+			put_prev_task(rq, prev);
+			set_next_task(rq, next);
+		}
+
+		rq->core_pick = NULL;
+		return next;
+	}
+
+	put_prev_task_balance(rq, prev, rf);
+
+	smt_mask = cpu_smt_mask(cpu);
+
+	/*
+	 * core->core_task_seq, core->core_pick_seq, rq->core_sched_seq
+	 *
+	 * @task_seq guards the task state ({en,de}queues)
+	 * @pick_seq is the @task_seq we did a selection on
+	 * @sched_seq is the @pick_seq we scheduled
+	 *
+	 * However, preemptions can cause multiple picks on the same task set.
+	 * 'Fix' this by also increasing @task_seq for every pick.
+	 */
+	rq->core->core_task_seq++;
+	need_sync = !!rq->core->core_cookie;
+
+	/* reset state */
+	rq->core->core_cookie = 0UL;
+	for_each_cpu(i, smt_mask) {
+		struct rq *rq_i = cpu_rq(i);
+
+		rq_i->core_pick = NULL;
+
+		if (rq_i->core_forceidle) {
+			need_sync = true;
+			rq_i->core_forceidle = false;
+		}
+
+		if (i != cpu)
+			update_rq_clock(rq_i);
+	}
+
+	/*
+	 * Try and select tasks for each sibling in decending sched_class
+	 * order.
+	 */
+	for_each_class(class) {
+again:
+		for_each_cpu_wrap(i, smt_mask, cpu) {
+			struct rq *rq_i = cpu_rq(i);
+			struct task_struct *p;
+
+			if (rq_i->core_pick)
+				continue;
+
+			/*
+			 * If this sibling doesn't yet have a suitable task to
+			 * run; ask for the most elegible task, given the
+			 * highest priority task already selected for this
+			 * core.
+			 */
+			p = pick_task(rq_i, class, max);
+			if (!p) {
+				/*
+				 * If there weren't no cookies; we don't need to
+				 * bother with the other siblings.
+				 * If the rest of the core is not running a tagged
+				 * task, i.e.  need_sync == 0, and the current CPU
+				 * which called into the schedule() loop does not
+				 * have any tasks for this class, skip selecting for
+				 * other siblings since there's no point. We don't skip
+				 * for RT/DL because that could make CFS force-idle RT.
+				 */
+				if (i == cpu && !need_sync && class == &fair_sched_class)
+					goto next_class;
+
+				continue;
+			}
+
+			/*
+			 * Optimize the 'normal' case where there aren't any
+			 * cookies and we don't need to sync up.
+			 */
+			if (i == cpu && !need_sync && !p->core_cookie) {
+				next = p;
+				goto done;
+			}
+
+			rq_i->core_pick = p;
+
+			/*
+			 * If this new candidate is of higher priority than the
+			 * previous; and they're incompatible; we need to wipe
+			 * the slate and start over. pick_task makes sure that
+			 * p's priority is more than max if it doesn't match
+			 * max's cookie.
+			 *
+			 * NOTE: this is a linear max-filter and is thus bounded
+			 * in execution time.
+			 */
+			if (!max || !cookie_match(max, p)) {
+				struct task_struct *old_max = max;
+
+				rq->core->core_cookie = p->core_cookie;
+				max = p;
+
+				if (old_max) {
+					for_each_cpu(j, smt_mask) {
+						if (j == i)
+							continue;
+
+						cpu_rq(j)->core_pick = NULL;
+					}
+					goto again;
+				} else {
+					/*
+					 * Once we select a task for a cpu, we
+					 * should not be doing an unconstrained
+					 * pick because it might starve a task
+					 * on a forced idle cpu.
+					 */
+					need_sync = true;
+				}
+
+			}
+		}
+next_class:;
+	}
+
+	rq->core->core_pick_seq = rq->core->core_task_seq;
+	next = rq->core_pick;
+	rq->core_sched_seq = rq->core->core_pick_seq;
+
+	/* Something should have been selected for current CPU */
+	WARN_ON_ONCE(!next);
+
+	/*
+	 * Reschedule siblings
+	 *
+	 * NOTE: L1TF -- at this point we're no longer running the old task and
+	 * sending an IPI (below) ensures the sibling will no longer be running
+	 * their task. This ensures there is no inter-sibling overlap between
+	 * non-matching user state.
+	 */
+	for_each_cpu(i, smt_mask) {
+		struct rq *rq_i = cpu_rq(i);
+
+		/*
+		 * An online sibling might have gone offline before a task
+		 * could be picked for it, or it might be offline but later
+		 * happen to come online, but its too late and nothing was
+		 * picked for it.  That's Ok - it will pick tasks for itself,
+		 * so ignore it.
+		 */
+		if (!rq_i->core_pick)
+			continue;
+
+		if (is_task_rq_idle(rq_i->core_pick) && rq_i->nr_running)
+			rq_i->core_forceidle = true;
+
+		if (i == cpu) {
+			rq_i->core_pick = NULL;
+			continue;
+		}
+
+		/* Did we break L1TF mitigation requirements? */
+		WARN_ON_ONCE(!cookie_match(next, rq_i->core_pick));
+
+		if (rq_i->curr == rq_i->core_pick) {
+			rq_i->core_pick = NULL;
+			continue;
+		}
+
+		resched_curr(rq_i);
+	}
+
+done:
+	set_next_task(rq, next);
+	return next;
+}
 
 static inline void sched_core_cpu_starting(unsigned int cpu)
 {
@@ -5354,6 +5642,12 @@ static inline void sched_core_cpu_starting(unsigned int cpu)
 
 static inline void sched_core_cpu_starting(unsigned int cpu) {}
 
+static struct task_struct *
+pick_next_task(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
+{
+	return __pick_next_task(rq, prev, rf);
+}
+
 #endif /* CONFIG_SCHED_CORE */
 
 /*
@@ -8609,7 +8903,12 @@ void __init sched_init(void)
 
 #ifdef CONFIG_SCHED_CORE
 		rq->core = NULL;
+		rq->core_pick = NULL;
 		rq->core_enabled = 0;
+		rq->core_tree = RB_ROOT;
+		rq->core_forceidle = false;
+
+		rq->core_cookie = 0UL;
 #endif
 	}
 
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index e43a217..dd44a31 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -1079,11 +1079,16 @@ struct rq {
 #ifdef CONFIG_SCHED_CORE
 	/* per rq */
 	struct rq		*core;
+	struct task_struct	*core_pick;
 	unsigned int		core_enabled;
+	unsigned int		core_sched_seq;
 	struct rb_root		core_tree;
+	unsigned char		core_forceidle;
 
 	/* shared state */
 	unsigned int		core_task_seq;
+	unsigned int		core_pick_seq;
+	unsigned long		core_cookie;
 #endif
 };
 
@@ -2060,7 +2065,6 @@ static inline void put_prev_task(struct rq *rq, struct task_struct *prev)
 
 static inline void set_next_task(struct rq *rq, struct task_struct *next)
 {
-	WARN_ON_ONCE(rq->curr != next);
 	next->sched_class->set_next_task(rq, next, false);
 }
 
