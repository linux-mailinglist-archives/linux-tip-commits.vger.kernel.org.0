Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D0784375514
	for <lists+linux-tip-commits@lfdr.de>; Thu,  6 May 2021 15:48:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234456AbhEFNt2 (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Thu, 6 May 2021 09:49:28 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:40508 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234390AbhEFNt0 (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Thu, 6 May 2021 09:49:26 -0400
Date:   Thu, 06 May 2021 13:48:26 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1620308907;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HioO09E4EUH2pJU7Pk+BXgCqwqfaD4Ra/7OV415zQDg=;
        b=PB21JhN2B5pKb/f6SI4eJBwcWCM+50T6ejvdwcPgaXUfStGG3sGtXPJM6erj1Wbxv6Uvl/
        HQBaCwCN1Pi7s6qW3PK9UDIlWlnStvDL+V0Qo1QxlXsHezrivjoENx7RGb5ygnad+k3iuh
        FRusymHSTTJut7YGMpMdmlnsf2PzrJCbumoz5BDARzHYIINxmd510mjzVCRQ4enIDC9gqC
        1ZbGA4HVxlO0C+3Rqa5yefBU/Ds+MpDIWn4poHclxZ+aazb6Sz4ZouRecj1lMNVWgN/hiP
        HdvNAdXuILcpYckm47P0L4vbMOqid8GUbrx1bwGPvudIUBnWrxRyzvMCWVUB1A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1620308907;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HioO09E4EUH2pJU7Pk+BXgCqwqfaD4Ra/7OV415zQDg=;
        b=Ri7qgRa3XR/zEcjaH/J3u/0aQRX/tpRst7d8L72McOIC0ng0Tulm7tV58ii/FUaDDbV4Hf
        rmDvgtDSmPqISRAQ==
From:   "tip-bot2 for Johannes Weiner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/urgent] psi: Fix psi state corruption when schedule()
 races with cgroup move
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210503174917.38579-1-hannes@cmpxchg.org>
References: <20210503174917.38579-1-hannes@cmpxchg.org>
MIME-Version: 1.0
Message-ID: <162030890696.29796.9937915751746267310.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the sched/urgent branch of tip:

Commit-ID:     d583d360a620e6229422b3455d0be082b8255f5e
Gitweb:        https://git.kernel.org/tip/d583d360a620e6229422b3455d0be082b8255f5e
Author:        Johannes Weiner <hannes@cmpxchg.org>
AuthorDate:    Mon, 03 May 2021 13:49:17 -04:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Thu, 06 May 2021 15:33:26 +02:00

psi: Fix psi state corruption when schedule() races with cgroup move

4117cebf1a9f ("psi: Optimize task switch inside shared cgroups")
introduced a race condition that corrupts internal psi state. This
manifests as kernel warnings, sometimes followed by bogusly high IO
pressure:

  psi: task underflow! cpu=1 t=2 tasks=[0 0 0 0] clear=c set=0
  (schedule() decreasing RUNNING and ONCPU, both of which are 0)

  psi: incosistent task state! task=2412744:systemd cpu=17 psi_flags=e clear=3 set=0
  (cgroup_move_task() clearing MEMSTALL and IOWAIT, but task is MEMSTALL | RUNNING | ONCPU)

What the offending commit does is batch the two psi callbacks in
schedule() to reduce the number of cgroup tree updates. When prev is
deactivated and removed from the runqueue, nothing is done in psi at
first; when the task switch completes, TSK_RUNNING and TSK_IOWAIT are
updated along with TSK_ONCPU.

However, the deactivation and the task switch inside schedule() aren't
atomic: pick_next_task() may drop the rq lock for load balancing. When
this happens, cgroup_move_task() can run after the task has been
physically dequeued, but the psi updates are still pending. Since it
looks at the task's scheduler state, it doesn't move everything to the
new cgroup that the task switch that follows is about to clear from
it. cgroup_move_task() will leak the TSK_RUNNING count in the old
cgroup, and psi_sched_switch() will underflow it in the new cgroup.

A similar thing can happen for iowait. TSK_IOWAIT is usually set when
a p->in_iowait task is dequeued, but again this update is deferred to
the switch. cgroup_move_task() can see an unqueued p->in_iowait task
and move a non-existent TSK_IOWAIT. This results in the inconsistent
task state warning, as well as a counter underflow that will result in
permanent IO ghost pressure being reported.

Fix this bug by making cgroup_move_task() use task->psi_flags instead
of looking at the potentially mismatching scheduler state.

[ We used the scheduler state historically in order to not rely on
  task->psi_flags for anything but debugging. But that ship has sailed
  anyway, and this is simpler and more robust.

  We previously already batched TSK_ONCPU clearing with the
  TSK_RUNNING update inside the deactivation call from schedule(). But
  that ordering was safe and didn't result in TSK_ONCPU corruption:
  unlike most places in the scheduler, cgroup_move_task() only checked
  task_current() and handled TSK_ONCPU if the task was still queued. ]

Fixes: 4117cebf1a9f ("psi: Optimize task switch inside shared cgroups")
Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20210503174917.38579-1-hannes@cmpxchg.org
---
 kernel/sched/psi.c | 36 ++++++++++++++++++++++++++----------
 1 file changed, 26 insertions(+), 10 deletions(-)

diff --git a/kernel/sched/psi.c b/kernel/sched/psi.c
index db27b69..cc25a3c 100644
--- a/kernel/sched/psi.c
+++ b/kernel/sched/psi.c
@@ -972,7 +972,7 @@ void psi_cgroup_free(struct cgroup *cgroup)
  */
 void cgroup_move_task(struct task_struct *task, struct css_set *to)
 {
-	unsigned int task_flags = 0;
+	unsigned int task_flags;
 	struct rq_flags rf;
 	struct rq *rq;
 
@@ -987,15 +987,31 @@ void cgroup_move_task(struct task_struct *task, struct css_set *to)
 
 	rq = task_rq_lock(task, &rf);
 
-	if (task_on_rq_queued(task)) {
-		task_flags = TSK_RUNNING;
-		if (task_current(rq, task))
-			task_flags |= TSK_ONCPU;
-	} else if (task->in_iowait)
-		task_flags = TSK_IOWAIT;
-
-	if (task->in_memstall)
-		task_flags |= TSK_MEMSTALL;
+	/*
+	 * We may race with schedule() dropping the rq lock between
+	 * deactivating prev and switching to next. Because the psi
+	 * updates from the deactivation are deferred to the switch
+	 * callback to save cgroup tree updates, the task's scheduling
+	 * state here is not coherent with its psi state:
+	 *
+	 * schedule()                   cgroup_move_task()
+	 *   rq_lock()
+	 *   deactivate_task()
+	 *     p->on_rq = 0
+	 *     psi_dequeue() // defers TSK_RUNNING & TSK_IOWAIT updates
+	 *   pick_next_task()
+	 *     rq_unlock()
+	 *                                rq_lock()
+	 *                                psi_task_change() // old cgroup
+	 *                                task->cgroups = to
+	 *                                psi_task_change() // new cgroup
+	 *                                rq_unlock()
+	 *     rq_lock()
+	 *   psi_sched_switch() // does deferred updates in new cgroup
+	 *
+	 * Don't rely on the scheduling state. Use psi_flags instead.
+	 */
+	task_flags = task->psi_flags;
 
 	if (task_flags)
 		psi_task_change(task, task_flags, 0);
