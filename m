Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D92983E1169
	for <lists+linux-tip-commits@lfdr.de>; Thu,  5 Aug 2021 11:34:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239946AbhHEJfK (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Thu, 5 Aug 2021 05:35:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239200AbhHEJfC (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Thu, 5 Aug 2021 05:35:02 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D33ADC0617A3;
        Thu,  5 Aug 2021 02:34:44 -0700 (PDT)
Date:   Thu, 05 Aug 2021 09:34:42 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1628156083;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tXlsExUlTgxAMcAmpVfRji7pdGz2LgIu4wCnwH8hSqQ=;
        b=VZ0GDvoLrrDZoK6TdBf89YrKqOLfdC2kgL5tfQpwkyBneeTEMu7FJ1uaaFH72rKw6exPu8
        936IGImCJBkFdyAY7IFwyIi8fT00yED57+bFfFlHC0OJ2h5HVnb2FlwoJaNnbfOlRy4mRJ
        XEwaXHiFpC+4Ez77BdbR6ROBtfWDtpbIGPt9bEbWBYKrgwXdl1Mq+AMypN8QIPsxDS1mAF
        q0QqZ+tptToPl+z/cY/SbfLSes09WW4OQFSSShZF4jAoG5OpZ81k9eL6OGIh5+j3KrPKJm
        4Gk1ZAIcKJM/+I/irxPZQGb/+GCip3Q4nnGvsKIH41B/1dXKK6cVre9TVKyUpw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1628156083;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tXlsExUlTgxAMcAmpVfRji7pdGz2LgIu4wCnwH8hSqQ=;
        b=aHY4ucOmS8qZLHSimzb2MpPriw+sPnuWDnQj/sEPz4AC6e0JcMdWsV55XKRD5wh4uXA1tx
        ChzM/yVsrrfRmRAQ==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/urgent] sched/rt: Fix double enqueue caused by rt_effective_prio
Cc:     Mark Simmons <msimmons@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210803104501.38333-1-juri.lelli@redhat.com>
References: <20210803104501.38333-1-juri.lelli@redhat.com>
MIME-Version: 1.0
Message-ID: <162815608277.395.18153532782103955545.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the sched/urgent branch of tip:

Commit-ID:     f558c2b834ec27e75d37b1c860c139e7b7c3a8e4
Gitweb:        https://git.kernel.org/tip/f558c2b834ec27e75d37b1c860c139e7b7c3a8e4
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Tue, 03 Aug 2021 12:45:01 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 04 Aug 2021 15:16:31 +02:00

sched/rt: Fix double enqueue caused by rt_effective_prio

Double enqueues in rt runqueues (list) have been reported while running
a simple test that spawns a number of threads doing a short sleep/run
pattern while being concurrently setscheduled between rt and fair class.

  WARNING: CPU: 3 PID: 2825 at kernel/sched/rt.c:1294 enqueue_task_rt+0x355/0x360
  CPU: 3 PID: 2825 Comm: setsched__13
  RIP: 0010:enqueue_task_rt+0x355/0x360
  Call Trace:
   __sched_setscheduler+0x581/0x9d0
   _sched_setscheduler+0x63/0xa0
   do_sched_setscheduler+0xa0/0x150
   __x64_sys_sched_setscheduler+0x1a/0x30
   do_syscall_64+0x33/0x40
   entry_SYSCALL_64_after_hwframe+0x44/0xae

  list_add double add: new=ffff9867cb629b40, prev=ffff9867cb629b40,
		       next=ffff98679fc67ca0.
  kernel BUG at lib/list_debug.c:31!
  invalid opcode: 0000 [#1] PREEMPT_RT SMP PTI
  CPU: 3 PID: 2825 Comm: setsched__13
  RIP: 0010:__list_add_valid+0x41/0x50
  Call Trace:
   enqueue_task_rt+0x291/0x360
   __sched_setscheduler+0x581/0x9d0
   _sched_setscheduler+0x63/0xa0
   do_sched_setscheduler+0xa0/0x150
   __x64_sys_sched_setscheduler+0x1a/0x30
   do_syscall_64+0x33/0x40
   entry_SYSCALL_64_after_hwframe+0x44/0xae

__sched_setscheduler() uses rt_effective_prio() to handle proper queuing
of priority boosted tasks that are setscheduled while being boosted.
rt_effective_prio() is however called twice per each
__sched_setscheduler() call: first directly by __sched_setscheduler()
before dequeuing the task and then by __setscheduler() to actually do
the priority change. If the priority of the pi_top_task is concurrently
being changed however, it might happen that the two calls return
different results. If, for example, the first call returned the same rt
priority the task was running at and the second one a fair priority, the
task won't be removed by the rt list (on_list still set) and then
enqueued in the fair runqueue. When eventually setscheduled back to rt
it will be seen as enqueued already and the WARNING/BUG be issued.

Fix this by calling rt_effective_prio() only once and then reusing the
return value. While at it refactor code as well for clarity. Concurrent
priority inheritance handling is still safe and will eventually converge
to a new state by following the inheritance chain(s).

Fixes: 0782e63bc6fe ("sched: Handle priority boosted tasks proper in setscheduler()")
[squashed Peterz changes; added changelog]
Reported-by: Mark Simmons <msimmons@redhat.com>
Signed-off-by: Juri Lelli <juri.lelli@redhat.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20210803104501.38333-1-juri.lelli@redhat.com
---
 kernel/sched/core.c | 90 +++++++++++++++++---------------------------
 1 file changed, 35 insertions(+), 55 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 2d9ff40..20ffcc0 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -1981,12 +1981,18 @@ void deactivate_task(struct rq *rq, struct task_struct *p, int flags)
 	dequeue_task(rq, p, flags);
 }
 
-/*
- * __normal_prio - return the priority that is based on the static prio
- */
-static inline int __normal_prio(struct task_struct *p)
+static inline int __normal_prio(int policy, int rt_prio, int nice)
 {
-	return p->static_prio;
+	int prio;
+
+	if (dl_policy(policy))
+		prio = MAX_DL_PRIO - 1;
+	else if (rt_policy(policy))
+		prio = MAX_RT_PRIO - 1 - rt_prio;
+	else
+		prio = NICE_TO_PRIO(nice);
+
+	return prio;
 }
 
 /*
@@ -1998,15 +2004,7 @@ static inline int __normal_prio(struct task_struct *p)
  */
 static inline int normal_prio(struct task_struct *p)
 {
-	int prio;
-
-	if (task_has_dl_policy(p))
-		prio = MAX_DL_PRIO-1;
-	else if (task_has_rt_policy(p))
-		prio = MAX_RT_PRIO-1 - p->rt_priority;
-	else
-		prio = __normal_prio(p);
-	return prio;
+	return __normal_prio(p->policy, p->rt_priority, PRIO_TO_NICE(p->static_prio));
 }
 
 /*
@@ -4099,7 +4097,7 @@ int sched_fork(unsigned long clone_flags, struct task_struct *p)
 		} else if (PRIO_TO_NICE(p->static_prio) < 0)
 			p->static_prio = NICE_TO_PRIO(0);
 
-		p->prio = p->normal_prio = __normal_prio(p);
+		p->prio = p->normal_prio = p->static_prio;
 		set_load_weight(p, false);
 
 		/*
@@ -6341,6 +6339,18 @@ int default_wake_function(wait_queue_entry_t *curr, unsigned mode, int wake_flag
 }
 EXPORT_SYMBOL(default_wake_function);
 
+static void __setscheduler_prio(struct task_struct *p, int prio)
+{
+	if (dl_prio(prio))
+		p->sched_class = &dl_sched_class;
+	else if (rt_prio(prio))
+		p->sched_class = &rt_sched_class;
+	else
+		p->sched_class = &fair_sched_class;
+
+	p->prio = prio;
+}
+
 #ifdef CONFIG_RT_MUTEXES
 
 static inline int __rt_effective_prio(struct task_struct *pi_task, int prio)
@@ -6456,22 +6466,19 @@ void rt_mutex_setprio(struct task_struct *p, struct task_struct *pi_task)
 		} else {
 			p->dl.pi_se = &p->dl;
 		}
-		p->sched_class = &dl_sched_class;
 	} else if (rt_prio(prio)) {
 		if (dl_prio(oldprio))
 			p->dl.pi_se = &p->dl;
 		if (oldprio < prio)
 			queue_flag |= ENQUEUE_HEAD;
-		p->sched_class = &rt_sched_class;
 	} else {
 		if (dl_prio(oldprio))
 			p->dl.pi_se = &p->dl;
 		if (rt_prio(oldprio))
 			p->rt.timeout = 0;
-		p->sched_class = &fair_sched_class;
 	}
 
-	p->prio = prio;
+	__setscheduler_prio(p, prio);
 
 	if (queued)
 		enqueue_task(rq, p, queue_flag);
@@ -6824,35 +6831,6 @@ static void __setscheduler_params(struct task_struct *p,
 	set_load_weight(p, true);
 }
 
-/* Actually do priority change: must hold pi & rq lock. */
-static void __setscheduler(struct rq *rq, struct task_struct *p,
-			   const struct sched_attr *attr, bool keep_boost)
-{
-	/*
-	 * If params can't change scheduling class changes aren't allowed
-	 * either.
-	 */
-	if (attr->sched_flags & SCHED_FLAG_KEEP_PARAMS)
-		return;
-
-	__setscheduler_params(p, attr);
-
-	/*
-	 * Keep a potential priority boosting if called from
-	 * sched_setscheduler().
-	 */
-	p->prio = normal_prio(p);
-	if (keep_boost)
-		p->prio = rt_effective_prio(p, p->prio);
-
-	if (dl_prio(p->prio))
-		p->sched_class = &dl_sched_class;
-	else if (rt_prio(p->prio))
-		p->sched_class = &rt_sched_class;
-	else
-		p->sched_class = &fair_sched_class;
-}
-
 /*
  * Check the target process has a UID that matches the current process's:
  */
@@ -6873,10 +6851,8 @@ static int __sched_setscheduler(struct task_struct *p,
 				const struct sched_attr *attr,
 				bool user, bool pi)
 {
-	int newprio = dl_policy(attr->sched_policy) ? MAX_DL_PRIO - 1 :
-		      MAX_RT_PRIO - 1 - attr->sched_priority;
-	int retval, oldprio, oldpolicy = -1, queued, running;
-	int new_effective_prio, policy = attr->sched_policy;
+	int oldpolicy = -1, policy = attr->sched_policy;
+	int retval, oldprio, newprio, queued, running;
 	const struct sched_class *prev_class;
 	struct callback_head *head;
 	struct rq_flags rf;
@@ -7074,6 +7050,7 @@ change:
 	p->sched_reset_on_fork = reset_on_fork;
 	oldprio = p->prio;
 
+	newprio = __normal_prio(policy, attr->sched_priority, attr->sched_nice);
 	if (pi) {
 		/*
 		 * Take priority boosted tasks into account. If the new
@@ -7082,8 +7059,8 @@ change:
 		 * the runqueue. This will be done when the task deboost
 		 * itself.
 		 */
-		new_effective_prio = rt_effective_prio(p, newprio);
-		if (new_effective_prio == oldprio)
+		newprio = rt_effective_prio(p, newprio);
+		if (newprio == oldprio)
 			queue_flags &= ~DEQUEUE_MOVE;
 	}
 
@@ -7096,7 +7073,10 @@ change:
 
 	prev_class = p->sched_class;
 
-	__setscheduler(rq, p, attr, pi);
+	if (!(attr->sched_flags & SCHED_FLAG_KEEP_PARAMS)) {
+		__setscheduler_params(p, attr);
+		__setscheduler_prio(p, newprio);
+	}
 	__setscheduler_uclamp(p, attr);
 
 	if (queued) {
