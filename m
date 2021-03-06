Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 358D632FA17
	for <lists+linux-tip-commits@lfdr.de>; Sat,  6 Mar 2021 12:43:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231222AbhCFLmj (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Sat, 6 Mar 2021 06:42:39 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:34364 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230425AbhCFLm1 (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Sat, 6 Mar 2021 06:42:27 -0500
Date:   Sat, 06 Mar 2021 11:42:25 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1615030946;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Fno3Ajqht06kdZu7tcv6zfgqtvG3z9WHUnvZfDIidEM=;
        b=ewEhkB75fdI8qcRwbEha7PDnktvNCM8D+V45MtHJ5G7wOqDGPxvAryt6rJzeTH/PWr4Chu
        21p1GIC3QSGkNttrtlZbKYgBbVgrXJG07bC4E1ePVZ1Hn84AbNzH02qrW5l44bHOvJBx4z
        ofOyQ7/nu+BMPxfmydtU5qWVY81l6pYw6STageMo/Qspv2sCgndTiuzrozG8/5CFLlRbl4
        x2dx+MlC1Sff3xVLoIXC6qMfVtDcgLHo7gywIvp4pGBJh+fMjQGaQMO5NGcABMBblbt9Jr
        N4GFp3keXwLj6R9xUKzzIeBiuYWflRWc5HPdGPjC6T/c5uWJg76RNMbC2SX0og==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1615030946;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Fno3Ajqht06kdZu7tcv6zfgqtvG3z9WHUnvZfDIidEM=;
        b=6b4RnRnqgINyGkR5jQCiLZG5QPyTkfRffW7DSDItYm1YLwpBiM6ofvKrwbKkgtulHdF+1t
        xgmXfTjztAMO3gCA==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched: Simplify migration_cpu_stop()
Cc:     stable@kernel.org, "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20210224131355.430014682@infradead.org>
References: <20210224131355.430014682@infradead.org>
MIME-Version: 1.0
Message-ID: <161503094585.398.14130589483162476516.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     c20cf065d4a619d394d23290093b1002e27dff86
Gitweb:        https://git.kernel.org/tip/c20cf065d4a619d394d23290093b1002e27dff86
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Wed, 24 Feb 2021 11:50:39 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Sat, 06 Mar 2021 12:40:20 +01:00

sched: Simplify migration_cpu_stop()

When affine_move_task() issues a migration_cpu_stop(), the purpose of
that function is to complete that @pending, not any random other
p->migration_pending that might have gotten installed since.

This realization much simplifies migration_cpu_stop() and allows
further necessary steps to fix all this as it provides the guarantee
that @pending's stopper will complete @pending (and not some random
other @pending).

Fixes: 6d337eab041d ("sched: Fix migrate_disable() vs set_cpus_allowed_ptr()")
Cc: stable@kernel.org
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Reviewed-by: Valentin Schneider <valentin.schneider@arm.com>
Link: https://lkml.kernel.org/r/20210224131355.430014682@infradead.org
---
 kernel/sched/core.c | 56 ++++++--------------------------------------
 1 file changed, 8 insertions(+), 48 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 79ddba5..088e8f4 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -1898,8 +1898,8 @@ static struct rq *__migrate_task(struct rq *rq, struct rq_flags *rf,
  */
 static int migration_cpu_stop(void *data)
 {
-	struct set_affinity_pending *pending;
 	struct migration_arg *arg = data;
+	struct set_affinity_pending *pending = arg->pending;
 	struct task_struct *p = arg->task;
 	int dest_cpu = arg->dest_cpu;
 	struct rq *rq = this_rq();
@@ -1921,25 +1921,6 @@ static int migration_cpu_stop(void *data)
 	raw_spin_lock(&p->pi_lock);
 	rq_lock(rq, &rf);
 
-	pending = p->migration_pending;
-	if (pending && !arg->pending) {
-		/*
-		 * This happens from sched_exec() and migrate_task_to(),
-		 * neither of them care about pending and just want a task to
-		 * maybe move about.
-		 *
-		 * Even if there is a pending, we can ignore it, since
-		 * affine_move_task() will have it's own stop_work's in flight
-		 * which will manage the completion.
-		 *
-		 * Notably, pending doesn't need to match arg->pending. This can
-		 * happen when tripple concurrent affine_move_task() first sets
-		 * pending, then clears pending and eventually sets another
-		 * pending.
-		 */
-		pending = NULL;
-	}
-
 	/*
 	 * If task_rq(p) != rq, it cannot be migrated here, because we're
 	 * holding rq->lock, if p->on_rq == 0 it cannot get enqueued because
@@ -1950,31 +1931,20 @@ static int migration_cpu_stop(void *data)
 			goto out;
 
 		if (pending) {
-			p->migration_pending = NULL;
+			if (p->migration_pending == pending)
+				p->migration_pending = NULL;
 			complete = true;
 		}
 
-		/* migrate_enable() --  we must not race against SCA */
-		if (dest_cpu < 0) {
-			/*
-			 * When this was migrate_enable() but we no longer
-			 * have a @pending, a concurrent SCA 'fixed' things
-			 * and we should be valid again. Nothing to do.
-			 */
-			if (!pending) {
-				WARN_ON_ONCE(!cpumask_test_cpu(task_cpu(p), &p->cpus_mask));
-				goto out;
-			}
-
+		if (dest_cpu < 0)
 			dest_cpu = cpumask_any_distribute(&p->cpus_mask);
-		}
 
 		if (task_on_rq_queued(p))
 			rq = __migrate_task(rq, &rf, p, dest_cpu);
 		else
 			p->wake_cpu = dest_cpu;
 
-	} else if (dest_cpu < 0 || pending) {
+	} else if (pending) {
 		/*
 		 * This happens when we get migrated between migrate_enable()'s
 		 * preempt_enable() and scheduling the stopper task. At that
@@ -1989,23 +1959,14 @@ static int migration_cpu_stop(void *data)
 		 * ->pi_lock, so the allowed mask is stable - if it got
 		 * somewhere allowed, we're done.
 		 */
-		if (pending && cpumask_test_cpu(task_cpu(p), p->cpus_ptr)) {
-			p->migration_pending = NULL;
+		if (cpumask_test_cpu(task_cpu(p), p->cpus_ptr)) {
+			if (p->migration_pending == pending)
+				p->migration_pending = NULL;
 			complete = true;
 			goto out;
 		}
 
 		/*
-		 * When this was migrate_enable() but we no longer have an
-		 * @pending, a concurrent SCA 'fixed' things and we should be
-		 * valid again. Nothing to do.
-		 */
-		if (!pending) {
-			WARN_ON_ONCE(!cpumask_test_cpu(task_cpu(p), &p->cpus_mask));
-			goto out;
-		}
-
-		/*
 		 * When migrate_enable() hits a rq mis-match we can't reliably
 		 * determine is_migration_disabled() and so have to chase after
 		 * it.
@@ -2022,7 +1983,6 @@ out:
 		complete_all(&pending->done);
 
 	/* For pending->{arg,stop_work} */
-	pending = arg->pending;
 	if (pending && refcount_dec_and_test(&pending->refs))
 		wake_up_var(&pending->refs);
 
