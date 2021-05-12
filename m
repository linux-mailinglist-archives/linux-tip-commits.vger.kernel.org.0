Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0375637BA60
	for <lists+linux-tip-commits@lfdr.de>; Wed, 12 May 2021 12:28:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230364AbhELK3f (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 12 May 2021 06:29:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230343AbhELK3d (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 12 May 2021 06:29:33 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE83AC061574;
        Wed, 12 May 2021 03:28:25 -0700 (PDT)
Date:   Wed, 12 May 2021 10:28:23 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1620815304;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5tcAkEcP5Xjk22abmLI0QSFltkXwA4pC4WOFdhyxXZI=;
        b=ZWi+hOdQO9DJH4Hy9Ffu+cQBBBOirQ+j1BL05ae3JFimEU63Y48ZFbN+MXD2+2t96d9V3E
        bwf+EsiQL3GaBnWeSYDNsSybWRqYndBPj6dptlO2wKgeHsg5q7S/BPZodaVw6fcXvfD1nC
        rrVDmOvqaCSkQkwwZpyzLzEmjvXz+gYbZESPM6toTjepC7C3BMOIwLMKXXV7rReHV4moQL
        MnjfYoyAZxkItXlGfXunrHgUoMMfSfEamEmHeIRvS92nMzlY9arsKooqV9D4ozE4lzgma2
        5AOhwwh9OHgLdb5MXIVRBmxaLYOUCS2KF2Q4M95ULlhFZBNURzZ6TueYNPrc0A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1620815304;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5tcAkEcP5Xjk22abmLI0QSFltkXwA4pC4WOFdhyxXZI=;
        b=rRhz3VUbSh3l18RO5SJIdIfkxWcCk3qMh4R/siQUtzykrxLbnAHTaccdHvilhufX3aksez
        0QhdERdEbT9sr+Dg==
From:   "tip-bot2 for Joel Fernandes (Google)" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched: Fix priority inversion of cookied task with sibling
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Don Hiatt <dhiatt@digitalocean.com>,
        Hongyu Ning <hongyu.ning@linux.intel.com>,
        Vincent Guittot <vincent.guittot@linaro.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210422123308.678425748@infradead.org>
References: <20210422123308.678425748@infradead.org>
MIME-Version: 1.0
Message-ID: <162081530355.29796.7473259809509648260.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     7afbba119f0da09824d723f8081608ea1f74ff57
Gitweb:        https://git.kernel.org/tip/7afbba119f0da09824d723f8081608ea1f74ff57
Author:        Joel Fernandes (Google) <joel@joelfernandes.org>
AuthorDate:    Tue, 17 Nov 2020 18:19:42 -05:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 12 May 2021 11:43:29 +02:00

sched: Fix priority inversion of cookied task with sibling

The rationale is as follows. In the core-wide pick logic, even if
need_sync == false, we need to go look at other CPUs (non-local CPUs)
to see if they could be running RT.

Say the RQs in a particular core look like this:

Let CFS1 and CFS2 be 2 tagged CFS tags.
Let RT1 be an untagged RT task.

	rq0		rq1
	CFS1 (tagged)	RT1 (no tag)
	CFS2 (tagged)

Say schedule() runs on rq0. Now, it will enter the above loop and
pick_task(RT) will return NULL for 'p'. It will enter the above if()
block and see that need_sync == false and will skip RT entirely.

The end result of the selection will be (say prio(CFS1) > prio(CFS2)):

	rq0             rq1
	CFS1            IDLE

When it should have selected:

	rq0             rq1
	IDLE            RT

Suggested-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Tested-by: Don Hiatt <dhiatt@digitalocean.com>
Tested-by: Hongyu Ning <hongyu.ning@linux.intel.com>
Tested-by: Vincent Guittot <vincent.guittot@linaro.org>
Link: https://lkml.kernel.org/r/20210422123308.678425748@infradead.org
---
 kernel/sched/core.c | 65 +++++++++++++++++---------------------------
 1 file changed, 26 insertions(+), 39 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index f5e1e6f..e506d9d 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -5443,6 +5443,15 @@ pick_next_task(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
 	put_prev_task_balance(rq, prev, rf);
 
 	smt_mask = cpu_smt_mask(cpu);
+	need_sync = !!rq->core->core_cookie;
+
+	/* reset state */
+	rq->core->core_cookie = 0UL;
+	if (rq->core->core_forceidle) {
+		need_sync = true;
+		fi_before = true;
+		rq->core->core_forceidle = false;
+	}
 
 	/*
 	 * core->core_task_seq, core->core_pick_seq, rq->core_sched_seq
@@ -5455,14 +5464,25 @@ pick_next_task(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
 	 * 'Fix' this by also increasing @task_seq for every pick.
 	 */
 	rq->core->core_task_seq++;
-	need_sync = !!rq->core->core_cookie;
 
-	/* reset state */
-	rq->core->core_cookie = 0UL;
-	if (rq->core->core_forceidle) {
+	/*
+	 * Optimize for common case where this CPU has no cookies
+	 * and there are no cookied tasks running on siblings.
+	 */
+	if (!need_sync) {
+		for_each_class(class) {
+			next = class->pick_task(rq);
+			if (next)
+				break;
+		}
+
+		if (!next->core_cookie) {
+			rq->core_pick = NULL;
+			goto done;
+		}
 		need_sync = true;
-		rq->core->core_forceidle = false;
 	}
+
 	for_each_cpu(i, smt_mask) {
 		struct rq *rq_i = cpu_rq(i);
 
@@ -5492,31 +5512,8 @@ again:
 			 * core.
 			 */
 			p = pick_task(rq_i, class, max);
-			if (!p) {
-				/*
-				 * If there weren't no cookies; we don't need to
-				 * bother with the other siblings.
-				 * If the rest of the core is not running a tagged
-				 * task, i.e.  need_sync == 0, and the current CPU
-				 * which called into the schedule() loop does not
-				 * have any tasks for this class, skip selecting for
-				 * other siblings since there's no point. We don't skip
-				 * for RT/DL because that could make CFS force-idle RT.
-				 */
-				if (i == cpu && !need_sync && class == &fair_sched_class)
-					goto next_class;
-
+			if (!p)
 				continue;
-			}
-
-			/*
-			 * Optimize the 'normal' case where there aren't any
-			 * cookies and we don't need to sync up.
-			 */
-			if (i == cpu && !need_sync && !p->core_cookie) {
-				next = p;
-				goto done;
-			}
 
 			rq_i->core_pick = p;
 
@@ -5544,19 +5541,9 @@ again:
 						cpu_rq(j)->core_pick = NULL;
 					}
 					goto again;
-				} else {
-					/*
-					 * Once we select a task for a cpu, we
-					 * should not be doing an unconstrained
-					 * pick because it might starve a task
-					 * on a forced idle cpu.
-					 */
-					need_sync = true;
 				}
-
 			}
 		}
-next_class:;
 	}
 
 	rq->core->core_pick_seq = rq->core->core_task_seq;
