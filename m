Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CAF2A35A2BF
	for <lists+linux-tip-commits@lfdr.de>; Fri,  9 Apr 2021 18:14:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232855AbhDIQOr (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 9 Apr 2021 12:14:47 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:51570 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231946AbhDIQOq (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 9 Apr 2021 12:14:46 -0400
Date:   Fri, 09 Apr 2021 16:14:31 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1617984872;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Ul0uzH2FQLFVHfSBRCinHJEz1JT+AehwcswM1KXNt+A=;
        b=YumX72Q1lt6M1YOwylzWqRkx6OyiE+h0RPTUoEa2O+I7FaTUO3bs9enq4jgNIZMON8+dUb
        S0iu6kPcPOgmARZzyPIB+W3ouqICQ7KQZFFG5ZjscvbaTIv2ZH39D//iKchmFnPbmyP0g/
        IJsyCEElR2n/3gPe33S+5yIdmnsylNl7aEX8mby4F6hUDq7r5KlOMtB4S51Q2IvV0LbsT9
        +8dCrKSH0Q73bXXzLkf+x8wDChUzZjN7gwvM8n9H5WUMoBkHX7d5Roz3CobD201WaqhYca
        XJC7c9JEermdK6kGjCwhNA7dF8bkweGWc2a38JYgveULVAYxxCohErCWtbRVlQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1617984872;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Ul0uzH2FQLFVHfSBRCinHJEz1JT+AehwcswM1KXNt+A=;
        b=uAwHwbJYw4sPhNk5gwvr4VZLa2MFtW8hOmvFb0DdRUyme6z+Y0MsBeit/6oYFppGjw0iXQ
        A7ZU/PjlkwNkdNCA==
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
Message-ID: <161798487149.29796.18250747063112261212.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     23fb06d9602b0fcfa1a16357a5d7a7f7076a39e2
Gitweb:        https://git.kernel.org/tip/23fb06d9602b0fcfa1a16357a5d7a7f7076a39e2
Author:        Valentin Schneider <valentin.schneider@arm.com>
AuthorDate:    Wed, 07 Apr 2021 23:06:27 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 09 Apr 2021 18:02:20 +02:00

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
index 1ad929b..356637a 100644
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
