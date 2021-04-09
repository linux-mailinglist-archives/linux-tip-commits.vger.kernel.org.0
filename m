Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1845E359D3B
	for <lists+linux-tip-commits@lfdr.de>; Fri,  9 Apr 2021 13:24:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233603AbhDILYy (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 9 Apr 2021 07:24:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233530AbhDILYx (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 9 Apr 2021 07:24:53 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBBF4C061760;
        Fri,  9 Apr 2021 04:24:40 -0700 (PDT)
Date:   Fri, 09 Apr 2021 11:24:38 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1617967479;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GupfPbMFLG2dZb9KV4r1W8VTdn4zIFxcottG8a8oJ8s=;
        b=Ia/Et+gCoWMCA1Xh1NFb0SZQkU7A1N4T3XWgsP+h4GgOEdDtXRiq4Jny7FZ8uP4On9XItl
        hpB5PhH35RrpIlLGYlhbYqO9t++hz7zcgaxGzWGf+SPjY2GCG+S7xaadqPLJL0ytwhLkMu
        93yAnRQj4okqe8vvPr9f0v99PScyr9BDHqkojAu9Dl7k0gIloMM2UQLda1LgOXKVWMMw/2
        CsAnPxqWajcWXfJUrZ5vDDkc0vQURyq5Pt+Cx3qghyOrO6daMV9WSdvD1DvGrxrLixXsen
        UGmP7LctKJ2zMMkzmLSJwFOnVxfh1WQaK8T2jgSvkr9cWb23J/3abvasaCagjQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1617967479;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GupfPbMFLG2dZb9KV4r1W8VTdn4zIFxcottG8a8oJ8s=;
        b=Zn/tbxeJPVyqJ0Jk9pXFbzZSJ0GYxeOuY1sMkV9CdSsFuglMW/ytBQdFFdKvuQgUWNbMg9
        pXMXD2cTSlE2GdDA==
From:   "tip-bot2 for Valentin Schneider" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/fair: Clean up active balance
 nr_balance_failed trickery
Cc:     Valentin Schneider <valentin.schneider@arm.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Vincent Guittot <vincent.guittot@linaro.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210407220628.3798191-3-valentin.schneider@arm.com>
References: <20210407220628.3798191-3-valentin.schneider@arm.com>
MIME-Version: 1.0
Message-ID: <161796747887.29796.11018079836109616303.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     91771246031b9196279c8c6c2d43bbb433324eab
Gitweb:        https://git.kernel.org/tip/91771246031b9196279c8c6c2d43bbb433324eab
Author:        Valentin Schneider <valentin.schneider@arm.com>
AuthorDate:    Wed, 07 Apr 2021 23:06:27 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Thu, 08 Apr 2021 23:09:45 +02:00

sched/fair: Clean up active balance nr_balance_failed trickery

When triggering an active load balance, sd->nr_balance_failed is set to
such a value that any further can_migrate_task() using said sd will ignore
the output of task_hot().

This behaviour makes sense, as active load balance intentionally preempts a
rq's running task to migrate it right away, but this asynchronous write is
a bit shoddy, as the stopper thread might run active_load_balance_cpu_stop
before the sd->nr_balance_failed write either becomes visible to the
stopper's CPU or even happens on the CPU that appended the stopper work.

Add a struct lb_env flag to denote active balancing, and use it in
can_migrate_task(). Remove the sd->nr_balance_failed write that served the
same purpose. Cleanup the LBF_DST_PINNED active balance special case.

Signed-off-by: Valentin Schneider <valentin.schneider@arm.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
Reviewed-by: Vincent Guittot <vincent.guittot@linaro.org>
Link: https://lkml.kernel.org/r/20210407220628.3798191-3-valentin.schneider@arm.com
---
 kernel/sched/fair.c | 31 +++++++++++++++----------------
 1 file changed, 15 insertions(+), 16 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index d10e33d..3ed436e 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -7453,6 +7453,7 @@ enum migration_type {
 #define LBF_NEED_BREAK	0x02
 #define LBF_DST_PINNED  0x04
 #define LBF_SOME_PINNED	0x08
+#define LBF_ACTIVE_LB	0x10
 
 struct lb_env {
 	struct sched_domain	*sd;
@@ -7614,10 +7615,13 @@ int can_migrate_task(struct task_struct *p, struct lb_env *env)
 		 * our sched_group. We may want to revisit it if we couldn't
 		 * meet load balance goals by pulling other tasks on src_cpu.
 		 *
-		 * Avoid computing new_dst_cpu for NEWLY_IDLE or if we have
-		 * already computed one in current iteration.
+		 * Avoid computing new_dst_cpu
+		 * - for NEWLY_IDLE
+		 * - if we have already computed one in current iteration
+		 * - if it's an active balance
 		 */
-		if (env->idle == CPU_NEWLY_IDLE || (env->flags & LBF_DST_PINNED))
+		if (env->idle == CPU_NEWLY_IDLE ||
+		    env->flags & (LBF_DST_PINNED | LBF_ACTIVE_LB))
 			return 0;
 
 		/* Prevent to re-select dst_cpu via env's CPUs: */
@@ -7642,10 +7646,14 @@ int can_migrate_task(struct task_struct *p, struct lb_env *env)
 
 	/*
 	 * Aggressive migration if:
-	 * 1) destination numa is preferred
-	 * 2) task is cache cold, or
-	 * 3) too many balance attempts have failed.
+	 * 1) active balance
+	 * 2) destination numa is preferred
+	 * 3) task is cache cold, or
+	 * 4) too many balance attempts have failed.
 	 */
+	if (env->flags & LBF_ACTIVE_LB)
+		return 1;
+
 	tsk_cache_hot = migrate_degrades_locality(p, env);
 	if (tsk_cache_hot == -1)
 		tsk_cache_hot = task_hot(p, env);
@@ -9836,9 +9844,6 @@ more_balance:
 					active_load_balance_cpu_stop, busiest,
 					&busiest->active_balance_work);
 			}
-
-			/* We've kicked active balancing, force task migration. */
-			sd->nr_balance_failed = sd->cache_nice_tries+1;
 		}
 	} else {
 		sd->nr_balance_failed = 0;
@@ -9988,13 +9993,7 @@ static int active_load_balance_cpu_stop(void *data)
 			.src_cpu	= busiest_rq->cpu,
 			.src_rq		= busiest_rq,
 			.idle		= CPU_IDLE,
-			/*
-			 * can_migrate_task() doesn't need to compute new_dst_cpu
-			 * for active balancing. Since we have CPU_IDLE, but no
-			 * @dst_grpmask we need to make that test go away with lying
-			 * about DST_PINNED.
-			 */
-			.flags		= LBF_DST_PINNED,
+			.flags		= LBF_ACTIVE_LB,
 		};
 
 		schedstat_inc(sd->alb_count);
