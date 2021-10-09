Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 832704278E8
	for <lists+linux-tip-commits@lfdr.de>; Sat,  9 Oct 2021 12:09:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244747AbhJIKKy (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Sat, 9 Oct 2021 06:10:54 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:49670 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244856AbhJIKKD (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Sat, 9 Oct 2021 06:10:03 -0400
Date:   Sat, 09 Oct 2021 10:07:41 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1633774062;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6OEW6C2kmbWCboFTZZyPhyBSqs3FF2YnSUxMMgmxw5k=;
        b=D8QS38+7TT8+baKRVrq7HBz+4aRPwRqLKqW/RzT3Vt3DCRhR+IqqIRHK5rFPjSoVS9AVo3
        Ihpz/BsdXgS7pzIp7EMbOkHTWEp1sJKMayD8AlMZWFUx83Vd5d0oNSAqyCeLGlzZlNFLxV
        mypaD+urpsnew0EU8qFZFAxWozzLlD82SS4F/vEPviBGeYliErhO9sVcR1un5GM1cC1iWW
        MOmiSOevyEvDY7SW2kydw8ExgKJJArKwOm/2+LEpPMFDQTIYzrjVne6gcfemQMFzkPLewI
        0OdFnhAQOQ/KeWwNXMaf78RpGQz31jfVhr6we9eAjxWYCI5nNLfc4gNvLaLSZw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1633774062;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6OEW6C2kmbWCboFTZZyPhyBSqs3FF2YnSUxMMgmxw5k=;
        b=WinDC2dl3OGhaGXPPl7NTql+1jYQs2p2ry895LDmJlK8BYx/xTUnRklNDeQan1pbgc5pxv
        qgOiklWBNdrmPwAA==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched: Improve try_invoke_on_locked_down_task()
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Vasily Gorbik <gor@linux.ibm.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210929152428.589323576@infradead.org>
References: <20210929152428.589323576@infradead.org>
MIME-Version: 1.0
Message-ID: <163377406117.25758.17925995825744110256.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     f6ac18fafcf6cc5e41c26766d12ad335ed81012e
Gitweb:        https://git.kernel.org/tip/f6ac18fafcf6cc5e41c26766d12ad335ed81012e
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Wed, 22 Sep 2021 10:14:15 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Thu, 07 Oct 2021 13:51:15 +02:00

sched: Improve try_invoke_on_locked_down_task()

Clarify and tighten try_invoke_on_locked_down_task().

Basically the function calls @func under task_rq_lock(), except it
avoids taking rq->lock when possible.

This makes calling @func unconditional (the function will get renamed
in a later patch to remove the try).

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Vasily Gorbik <gor@linux.ibm.com>
Tested-by: Vasily Gorbik <gor@linux.ibm.com> # on s390
Link: https://lkml.kernel.org/r/20210929152428.589323576@infradead.org
---
 kernel/sched/core.c | 63 +++++++++++++++++++++++++++-----------------
 1 file changed, 39 insertions(+), 24 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index e47d7e5..8a9aeac 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -4115,41 +4115,56 @@ out:
  * @func: Function to invoke.
  * @arg: Argument to function.
  *
- * If the specified task can be quickly locked into a definite state
- * (either sleeping or on a given runqueue), arrange to keep it in that
- * state while invoking @func(@arg).  This function can use ->on_rq and
- * task_curr() to work out what the state is, if required.  Given that
- * @func can be invoked with a runqueue lock held, it had better be quite
- * lightweight.
+ * Fix the task in it's current state by avoiding wakeups and or rq operations
+ * and call @func(@arg) on it.  This function can use ->on_rq and task_curr()
+ * to work out what the state is, if required.  Given that @func can be invoked
+ * with a runqueue lock held, it had better be quite lightweight.
  *
  * Returns:
- *	@false if the task slipped out from under the locks.
- *	@true if the task was locked onto a runqueue or is sleeping.
- *		However, @func can override this by returning @false.
+ *   Whatever @func returns
  */
 bool try_invoke_on_locked_down_task(struct task_struct *p, bool (*func)(struct task_struct *t, void *arg), void *arg)
 {
+	struct rq *rq = NULL;
+	unsigned int state;
 	struct rq_flags rf;
 	bool ret = false;
-	struct rq *rq;
 
 	raw_spin_lock_irqsave(&p->pi_lock, rf.flags);
-	if (p->on_rq) {
+
+	state = READ_ONCE(p->__state);
+
+	/*
+	 * Ensure we load p->on_rq after p->__state, otherwise it would be
+	 * possible to, falsely, observe p->on_rq == 0.
+	 *
+	 * See try_to_wake_up() for a longer comment.
+	 */
+	smp_rmb();
+
+	/*
+	 * Since pi->lock blocks try_to_wake_up(), we don't need rq->lock when
+	 * the task is blocked. Make sure to check @state since ttwu() can drop
+	 * locks at the end, see ttwu_queue_wakelist().
+	 */
+	if (state == TASK_RUNNING || state == TASK_WAKING || p->on_rq)
 		rq = __task_rq_lock(p, &rf);
-		if (task_rq(p) == rq)
-			ret = func(p, arg);
+
+	/*
+	 * At this point the task is pinned; either:
+	 *  - blocked and we're holding off wakeups	 (pi->lock)
+	 *  - woken, and we're holding off enqueue	 (rq->lock)
+	 *  - queued, and we're holding off schedule	 (rq->lock)
+	 *  - running, and we're holding off de-schedule (rq->lock)
+	 *
+	 * The called function (@func) can use: task_curr(), p->on_rq and
+	 * p->__state to differentiate between these states.
+	 */
+	ret = func(p, arg);
+
+	if (rq)
 		rq_unlock(rq, &rf);
-	} else {
-		switch (READ_ONCE(p->__state)) {
-		case TASK_RUNNING:
-		case TASK_WAKING:
-			break;
-		default:
-			smp_rmb(); // See smp_rmb() comment in try_to_wake_up().
-			if (!p->on_rq)
-				ret = func(p, arg);
-		}
-	}
+
 	raw_spin_unlock_irqrestore(&p->pi_lock, rf.flags);
 	return ret;
 }
