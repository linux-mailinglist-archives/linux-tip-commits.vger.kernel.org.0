Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F20C327BC9
	for <lists+linux-tip-commits@lfdr.de>; Mon,  1 Mar 2021 11:17:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232688AbhCAKRY (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Mon, 1 Mar 2021 05:17:24 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:58344 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232598AbhCAKRC (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Mon, 1 Mar 2021 05:17:02 -0500
Date:   Mon, 01 Mar 2021 10:16:17 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1614593778;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Zew5FNCUyfMEdnnLYzMjmTtDhs49lkJI/jKzLsbubGw=;
        b=FkkZCmZ9eo8LlXS9ElrejitqXaMbadPedQGMZoGUT+lcIedG0DTFWc48L4QPmSPUlo54xa
        83WarlzbZUTO6clt0FQ2HF2K8kgPTFkpMGtzDWJD4vztm8XljIiedE8lJ4ki1syfaCEevu
        f4YSHZWBVzgFoElBVmB41oM+DZ4QSPEM7QooT15b8k4nIeDXwH6VAaYHk7gopFM5rIKOeY
        WdQ5ssUEV+kZ59ly/R+Nzvwx8WCaoAWoq4uK4ynLAi0CP5+wkPSAWq/ngVqbMA9QacMUj9
        xLrWNggBkv4bXqNgE1jjALFtyPQtmtPgq4zawa0gf+0i4h9z9hEnsMB2nGFZ4w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1614593778;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Zew5FNCUyfMEdnnLYzMjmTtDhs49lkJI/jKzLsbubGw=;
        b=KXQEN2DerXM2rO8rhdPRHoCnsbo3yFpKJdo/Rznb6KQwlxZxN0NXY58Q7R4oAQu/9YArDI
        xYR/ejDa5LdKYACw==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/urgent] sched: Fix migration_cpu_stop() requeueing
Cc:     stable@kernel.org, "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20210224131355.357743989@infradead.org>
References: <20210224131355.357743989@infradead.org>
MIME-Version: 1.0
Message-ID: <161459377794.20312.10867668454281912865.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the sched/urgent branch of tip:

Commit-ID:     b8e45e2a14bab684713f5dfc70c9e578c333dcdd
Gitweb:        https://git.kernel.org/tip/b8e45e2a14bab684713f5dfc70c9e578c333dcdd
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Sat, 13 Feb 2021 13:10:35 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 01 Mar 2021 11:02:13 +01:00

sched: Fix migration_cpu_stop() requeueing

When affine_move_task(p) is called on a running task @p, which is not
otherwise already changing affinity, we'll first set
p->migration_pending and then do:

	 stop_one_cpu(cpu_of_rq(rq), migration_cpu_stop, &arg);

This then gets us to migration_cpu_stop() running on the CPU that was
previously running our victim task @p.

If we find that our task is no longer on that runqueue (this can
happen because of a concurrent migration due to load-balance etc.),
then we'll end up at the:

	} else if (dest_cpu < 1 || pending) {

branch. Which we'll take because we set pending earlier. Here we first
check if the task @p has already satisfied the affinity constraints,
if so we bail early [A]. Otherwise we'll reissue migration_cpu_stop()
onto the CPU that is now hosting our task @p:

	stop_one_cpu_nowait(cpu_of(rq), migration_cpu_stop,
			    &pending->arg, &pending->stop_work);

Except, we've never initialized pending->arg, which will be all 0s.

This then results in running migration_cpu_stop() on the next CPU with
arg->p == NULL, which gives the by now obvious result of fireworks.

The cure is to change affine_move_task() to always use pending->arg,
furthermore we can use the exact same pattern as the
SCA_MIGRATE_ENABLE case, since we'll block on the pending->done
completion anyway, no point in adding yet another completion in
stop_one_cpu().

This then gives a clear distinction between the two
migration_cpu_stop() use cases:

  - sched_exec() / migrate_task_to() : arg->pending == NULL
  - affine_move_task() : arg->pending != NULL;

And we can have it ignore p->migration_pending when !arg->pending. Any
stop work from sched_exec() / migrate_task_to() is in addition to stop
works from affine_move_task(), which will be sufficient to issue the
completion.

Fixes: 6d337eab041d ("sched: Fix migrate_disable() vs set_cpus_allowed_ptr()")
Cc: stable@kernel.org
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Valentin Schneider <valentin.schneider@arm.com>
Link: https://lkml.kernel.org/r/20210224131355.357743989@infradead.org
---
 kernel/sched/core.c | 39 ++++++++++++++++++++++++++++-----------
 1 file changed, 28 insertions(+), 11 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index ca2bb62..79ddba5 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -1922,6 +1922,24 @@ static int migration_cpu_stop(void *data)
 	rq_lock(rq, &rf);
 
 	pending = p->migration_pending;
+	if (pending && !arg->pending) {
+		/*
+		 * This happens from sched_exec() and migrate_task_to(),
+		 * neither of them care about pending and just want a task to
+		 * maybe move about.
+		 *
+		 * Even if there is a pending, we can ignore it, since
+		 * affine_move_task() will have it's own stop_work's in flight
+		 * which will manage the completion.
+		 *
+		 * Notably, pending doesn't need to match arg->pending. This can
+		 * happen when tripple concurrent affine_move_task() first sets
+		 * pending, then clears pending and eventually sets another
+		 * pending.
+		 */
+		pending = NULL;
+	}
+
 	/*
 	 * If task_rq(p) != rq, it cannot be migrated here, because we're
 	 * holding rq->lock, if p->on_rq == 0 it cannot get enqueued because
@@ -2194,10 +2212,6 @@ static int affine_move_task(struct rq *rq, struct task_struct *p, struct rq_flag
 			    int dest_cpu, unsigned int flags)
 {
 	struct set_affinity_pending my_pending = { }, *pending = NULL;
-	struct migration_arg arg = {
-		.task = p,
-		.dest_cpu = dest_cpu,
-	};
 	bool complete = false;
 
 	/* Can the task run on the task's current CPU? If so, we're done */
@@ -2235,6 +2249,12 @@ static int affine_move_task(struct rq *rq, struct task_struct *p, struct rq_flag
 			/* Install the request */
 			refcount_set(&my_pending.refs, 1);
 			init_completion(&my_pending.done);
+			my_pending.arg = (struct migration_arg) {
+				.task = p,
+				.dest_cpu = -1,		/* any */
+				.pending = &my_pending,
+			};
+
 			p->migration_pending = &my_pending;
 		} else {
 			pending = p->migration_pending;
@@ -2265,12 +2285,6 @@ static int affine_move_task(struct rq *rq, struct task_struct *p, struct rq_flag
 		p->migration_flags &= ~MDF_PUSH;
 		task_rq_unlock(rq, p, rf);
 
-		pending->arg = (struct migration_arg) {
-			.task = p,
-			.dest_cpu = -1,
-			.pending = pending,
-		};
-
 		stop_one_cpu_nowait(cpu_of(rq), migration_cpu_stop,
 				    &pending->arg, &pending->stop_work);
 
@@ -2283,8 +2297,11 @@ static int affine_move_task(struct rq *rq, struct task_struct *p, struct rq_flag
 		 * is_migration_disabled(p) checks to the stopper, which will
 		 * run on the same CPU as said p.
 		 */
+		refcount_inc(&pending->refs); /* pending->{arg,stop_work} */
 		task_rq_unlock(rq, p, rf);
-		stop_one_cpu(cpu_of(rq), migration_cpu_stop, &arg);
+
+		stop_one_cpu_nowait(cpu_of(rq), migration_cpu_stop,
+				    &pending->arg, &pending->stop_work);
 
 	} else {
 
