Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 557873974EF
	for <lists+linux-tip-commits@lfdr.de>; Tue,  1 Jun 2021 16:05:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234234AbhFAOGk (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Tue, 1 Jun 2021 10:06:40 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:33148 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234179AbhFAOGi (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Tue, 1 Jun 2021 10:06:38 -0400
Date:   Tue, 01 Jun 2021 14:04:55 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1622556296;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/anJoGY66lTm18QohSp7zbrtC/47XBUCTHDencbsvZ4=;
        b=WlgNjT6fULWaaUX6tUkuOwcfSjEOrULP/aRVV19L0NDrwy3iUJMzpFTFA6AWH31rFVrS/z
        ZeMEchOjfY4b98b0PNbDhO8TLjEN5M2ddVBXLVf/1tVZGVgbznmOW5snGPJI6gOlOO+ncK
        70ZA1NI7dCsJAbEfagSCTt7VExqJpZkCLSBn02MNOiJbm5pCHqddNNVPDNH8/IS5Z4J9nO
        QUJDkDGZRw2Cl/Nno7fGafKJEPeLcsdFsp1lJXyysdar4jJAWUsFx3QVpqo2ymjvKMB2R5
        +jlaI9tgUuY0VeUwUqHfZcFrzunBZYOX/blt/kDrgpXCX9uvNDFha/kprTFzYg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1622556296;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/anJoGY66lTm18QohSp7zbrtC/47XBUCTHDencbsvZ4=;
        b=0BoExO7THO4P1nuit4rLjS7T1OCrIUftYEE29OcU3S0L7HdFtSZdDqrEUg/3DgUAGmtBpD
        6NKGhHk2uZ5HuOBA==
From:   "tip-bot2 for Valentin Schneider" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched: Don't defer CPU pick to migration_cpu_stop()
Cc:     Will Deacon <will@kernel.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210526205751.842360-2-valentin.schneider@arm.com>
References: <20210526205751.842360-2-valentin.schneider@arm.com>
MIME-Version: 1.0
Message-ID: <162255629595.29796.17462979182739834450.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     475ea6c60279e9f2ddf7e4cf2648cd8ae0608361
Gitweb:        https://git.kernel.org/tip/475ea6c60279e9f2ddf7e4cf2648cd8ae0608361
Author:        Valentin Schneider <valentin.schneider@arm.com>
AuthorDate:    Wed, 26 May 2021 21:57:50 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 01 Jun 2021 16:00:11 +02:00

sched: Don't defer CPU pick to migration_cpu_stop()

Will reported that the 'XXX __migrate_task() can fail' in migration_cpu_stop()
can happen, and it *is* sort of a big deal. Looking at it some more, one
will note there is a glaring hole in the deferred CPU selection:

  (w/ CONFIG_CPUSET=n, so that the affinity mask passed via taskset doesn't
  get AND'd with cpu_online_mask)

  $ taskset -pc 0-2 $PID
  # offline CPUs 3-4
  $ taskset -pc 3-5 $PID
    `\
      $PID may stay on 0-2 due to the cpumask_any_distribute() picking an
      offline CPU and __migrate_task() refusing to do anything due to
      cpu_is_allowed().

set_cpus_allowed_ptr() goes to some length to pick a dest_cpu that matches
the right constraints vs affinity and the online/active state of the
CPUs. Reuse that instead of discarding it in the affine_move_task() case.

Fixes: 6d337eab041d ("sched: Fix migrate_disable() vs set_cpus_allowed_ptr()")
Reported-by: Will Deacon <will@kernel.org>
Signed-off-by: Valentin Schneider <valentin.schneider@arm.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20210526205751.842360-2-valentin.schneider@arm.com
---
 kernel/sched/core.c | 20 ++++++++++++--------
 1 file changed, 12 insertions(+), 8 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index e205c19..7e59466 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -2273,7 +2273,6 @@ static int migration_cpu_stop(void *data)
 	struct migration_arg *arg = data;
 	struct set_affinity_pending *pending = arg->pending;
 	struct task_struct *p = arg->task;
-	int dest_cpu = arg->dest_cpu;
 	struct rq *rq = this_rq();
 	bool complete = false;
 	struct rq_flags rf;
@@ -2311,19 +2310,15 @@ static int migration_cpu_stop(void *data)
 		if (pending) {
 			p->migration_pending = NULL;
 			complete = true;
-		}
 
-		if (dest_cpu < 0) {
 			if (cpumask_test_cpu(task_cpu(p), &p->cpus_mask))
 				goto out;
-
-			dest_cpu = cpumask_any_distribute(&p->cpus_mask);
 		}
 
 		if (task_on_rq_queued(p))
-			rq = __migrate_task(rq, &rf, p, dest_cpu);
+			rq = __migrate_task(rq, &rf, p, arg->dest_cpu);
 		else
-			p->wake_cpu = dest_cpu;
+			p->wake_cpu = arg->dest_cpu;
 
 		/*
 		 * XXX __migrate_task() can fail, at which point we might end
@@ -2606,7 +2601,7 @@ static int affine_move_task(struct rq *rq, struct task_struct *p, struct rq_flag
 			init_completion(&my_pending.done);
 			my_pending.arg = (struct migration_arg) {
 				.task = p,
-				.dest_cpu = -1,		/* any */
+				.dest_cpu = dest_cpu,
 				.pending = &my_pending,
 			};
 
@@ -2614,6 +2609,15 @@ static int affine_move_task(struct rq *rq, struct task_struct *p, struct rq_flag
 		} else {
 			pending = p->migration_pending;
 			refcount_inc(&pending->refs);
+			/*
+			 * Affinity has changed, but we've already installed a
+			 * pending. migration_cpu_stop() *must* see this, else
+			 * we risk a completion of the pending despite having a
+			 * task on a disallowed CPU.
+			 *
+			 * Serialized by p->pi_lock, so this is safe.
+			 */
+			pending->arg.dest_cpu = dest_cpu;
 		}
 	}
 	pending = p->migration_pending;
