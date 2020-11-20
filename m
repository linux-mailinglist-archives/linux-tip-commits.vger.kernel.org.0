Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B6DE82BAA34
	for <lists+linux-tip-commits@lfdr.de>; Fri, 20 Nov 2020 13:34:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728120AbgKTMeM (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 20 Nov 2020 07:34:12 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:40348 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727181AbgKTMeL (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 20 Nov 2020 07:34:11 -0500
Date:   Fri, 20 Nov 2020 12:34:06 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1605875647;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JeiKEIak/njKGnYUn4264/CND1oYi0mRDyo0XkKBMI8=;
        b=dGc+GEa6m9PebsqaADW00+mdEIveu8eV1aIjiNv4lh2Pb5UK7SOLUVx4qBsz3kav9WUEs5
        aeQ2ksS+yIhYRj/1dB3NoSOP3qizH9eO1Oz6wb85/HUpehc9s4O0Kg6mhdpRk15CQiGE90
        lyTvdQZDAjuMsjHyFyt+grsGbPcNwY/OseHw2aNd4J8D8+1DIAiptJD2TWva8nWn0qEYTC
        Fm+icQMenDe5T5C3+5Z9DOFNmNSoYEwNF8rbG02+auTsizgfj/Ec92N7sRatCRxaHZk4zm
        aC0sBHAFsUERNbvGNntICOka7afdFbjTPG3zNCCM6XJYgRUc79bKbHmEEVvLLA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1605875647;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JeiKEIak/njKGnYUn4264/CND1oYi0mRDyo0XkKBMI8=;
        b=OnddJoDDPhpe6zej4t/0581vv293b+R85bQBHdB295ea5nE79Ktev7BPZEIRxTci7Z2EDe
        33+rLC7IMInBlpAw==
From:   "tip-bot2 for Tal Zussman" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/core: Fix typos in comments
Cc:     Tal Zussman <tz2294@columbia.edu>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20201113005156.GA8408@charmander>
References: <20201113005156.GA8408@charmander>
MIME-Version: 1.0
Message-ID: <160587564685.11244.3824993384257850199.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     b19a888c1e9bdf12e0d8dd9aeb887ca7de91c8a5
Gitweb:        https://git.kernel.org/tip/b19a888c1e9bdf12e0d8dd9aeb887ca7de91c8a5
Author:        Tal Zussman <tz2294@columbia.edu>
AuthorDate:    Thu, 12 Nov 2020 19:51:56 -05:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Thu, 19 Nov 2020 11:25:46 +01:00

sched/core: Fix typos in comments

Signed-off-by: Tal Zussman <tz2294@columbia.edu>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20201113005156.GA8408@charmander
---
 kernel/sched/core.c | 30 +++++++++++++++---------------
 1 file changed, 15 insertions(+), 15 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 28d541a..a9e6d63 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -97,7 +97,7 @@ int sysctl_sched_rt_runtime = 950000;
  *
  * Normal scheduling state is serialized by rq->lock. __schedule() takes the
  * local CPU's rq->lock, it optionally removes the task from the runqueue and
- * always looks at the local rq data structures to find the most elegible task
+ * always looks at the local rq data structures to find the most eligible task
  * to run next.
  *
  * Task enqueue is also under rq->lock, possibly taken from another CPU.
@@ -518,7 +518,7 @@ static bool __wake_q_add(struct wake_q_head *head, struct task_struct *task)
 
 	/*
 	 * Atomically grab the task, if ->wake_q is !nil already it means
-	 * its already queued (either by us or someone else) and will get the
+	 * it's already queued (either by us or someone else) and will get the
 	 * wakeup due to that.
 	 *
 	 * In order to ensure that a pending wakeup will observe our pending
@@ -769,7 +769,7 @@ bool sched_can_stop_tick(struct rq *rq)
 		return false;
 
 	/*
-	 * If there are more than one RR tasks, we need the tick to effect the
+	 * If there are more than one RR tasks, we need the tick to affect the
 	 * actual RR behaviour.
 	 */
 	if (rq->rt.rr_nr_running) {
@@ -1187,14 +1187,14 @@ static inline void uclamp_rq_dec_id(struct rq *rq, struct task_struct *p,
 	 * accounting was performed at enqueue time and we can just return
 	 * here.
 	 *
-	 * Need to be careful of the following enqeueue/dequeue ordering
+	 * Need to be careful of the following enqueue/dequeue ordering
 	 * problem too
 	 *
 	 *	enqueue(taskA)
 	 *	// sched_uclamp_used gets enabled
 	 *	enqueue(taskB)
 	 *	dequeue(taskA)
-	 *	// Must not decrement bukcet->tasks here
+	 *	// Must not decrement bucket->tasks here
 	 *	dequeue(taskB)
 	 *
 	 * where we could end up with stale data in uc_se and
@@ -2924,7 +2924,7 @@ static void ttwu_do_wakeup(struct rq *rq, struct task_struct *p, int wake_flags,
 #ifdef CONFIG_SMP
 	if (p->sched_class->task_woken) {
 		/*
-		 * Our task @p is fully woken up and running; so its safe to
+		 * Our task @p is fully woken up and running; so it's safe to
 		 * drop the rq->lock, hereafter rq is only used for statistics.
 		 */
 		rq_unpin_lock(rq, rf);
@@ -3411,7 +3411,7 @@ try_to_wake_up(struct task_struct *p, unsigned int state, int wake_flags)
 
 	/*
 	 * If the owning (remote) CPU is still in the middle of schedule() with
-	 * this task as prev, wait until its done referencing the task.
+	 * this task as prev, wait until it's done referencing the task.
 	 *
 	 * Pairs with the smp_store_release() in finish_task().
 	 *
@@ -3816,7 +3816,7 @@ void wake_up_new_task(struct task_struct *p)
 #ifdef CONFIG_SMP
 	if (p->sched_class->task_woken) {
 		/*
-		 * Nothing relies on rq->lock after this, so its fine to
+		 * Nothing relies on rq->lock after this, so it's fine to
 		 * drop it.
 		 */
 		rq_unpin_lock(rq, &rf);
@@ -4343,7 +4343,7 @@ unsigned long nr_iowait_cpu(int cpu)
 }
 
 /*
- * IO-wait accounting, and how its mostly bollocks (on SMP).
+ * IO-wait accounting, and how it's mostly bollocks (on SMP).
  *
  * The idea behind IO-wait account is to account the idle time that we could
  * have spend running if it were not for IO. That is, if we were to improve the
@@ -4838,7 +4838,7 @@ pick_next_task(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
 	/*
 	 * Optimization: we know that if all tasks are in the fair class we can
 	 * call that function directly, but only if the @prev task wasn't of a
-	 * higher scheduling class, because otherwise those loose the
+	 * higher scheduling class, because otherwise those lose the
 	 * opportunity to pull in more work from other CPUs.
 	 */
 	if (likely(prev->sched_class <= &fair_sched_class &&
@@ -5361,7 +5361,7 @@ void rt_mutex_setprio(struct task_struct *p, struct task_struct *pi_task)
 	 * right. rt_mutex_slowunlock()+rt_mutex_postunlock() work together to
 	 * ensure a task is de-boosted (pi_task is set to NULL) before the
 	 * task is allowed to run again (and can exit). This ensures the pointer
-	 * points to a blocked task -- which guaratees the task is present.
+	 * points to a blocked task -- which guarantees the task is present.
 	 */
 	p->pi_top_task = pi_task;
 
@@ -5479,7 +5479,7 @@ void set_user_nice(struct task_struct *p, long nice)
 	/*
 	 * The RT priorities are set via sched_setscheduler(), but we still
 	 * allow the 'normal' nice value to be set - but as expected
-	 * it wont have any effect on scheduling until the task is
+	 * it won't have any effect on scheduling until the task is
 	 * SCHED_DEADLINE, SCHED_FIFO or SCHED_RR:
 	 */
 	if (task_has_dl_policy(p) || task_has_rt_policy(p)) {
@@ -6668,7 +6668,7 @@ EXPORT_SYMBOL(__cond_resched_lock);
  *
  * The scheduler is at all times free to pick the calling task as the most
  * eligible task to run, if removing the yield() call from your code breaks
- * it, its already broken.
+ * it, it's already broken.
  *
  * Typical broken usage is:
  *
@@ -7042,7 +7042,7 @@ void init_idle(struct task_struct *idle, int cpu)
 
 #ifdef CONFIG_SMP
 	/*
-	 * Its possible that init_idle() gets called multiple times on a task,
+	 * It's possible that init_idle() gets called multiple times on a task,
 	 * in that case do_set_cpus_allowed() will not do the right thing.
 	 *
 	 * And since this is boot we can forgo the serialization.
@@ -8225,7 +8225,7 @@ static int cpu_cgroup_can_attach(struct cgroup_taskset *tset)
 			return -EINVAL;
 #endif
 		/*
-		 * Serialize against wake_up_new_task() such that if its
+		 * Serialize against wake_up_new_task() such that if it's
 		 * running, we're sure to observe its full state.
 		 */
 		raw_spin_lock_irq(&task->pi_lock);
