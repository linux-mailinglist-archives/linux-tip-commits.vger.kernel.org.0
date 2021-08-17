Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F40FA3EF32B
	for <lists+linux-tip-commits@lfdr.de>; Tue, 17 Aug 2021 22:15:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234214AbhHQUOe (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Tue, 17 Aug 2021 16:14:34 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:34586 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234120AbhHQUOd (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Tue, 17 Aug 2021 16:14:33 -0400
Date:   Tue, 17 Aug 2021 20:13:58 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1629231239;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=o5/C9s4BlOf4NhAuxugeefjxljfJNCvTCU//Hbla9WI=;
        b=0JbX6CEmJko6vOS5ED4xI8OtI3O12L8i5/bFcztSTi1vZ9J+d2a4DAUeP7/xqDdti3rwd2
        G7ANCOTw0KLVXG8mwxebrCLUuv0wX3cMASLX561JmEPW3eNiKbaVwK2X6ktR9yhixPKsVo
        U4f2Kvjnf/tS3oXKAdmCXdQ4ULO/pGXv8GW2P82ijNbBkkKIwdlFUDNvX8GTTrom/vJE9/
        S2jegMzchBBHzXwl8oAUggByPEdOjKu7LjmjHIZG3PiIn3NQt80g4aUeGNVUIAn8ihJXqh
        9P3bvAiAjhZXTCIDxnIFY6PSpf4BpskL5ZvdAdgdBXJI+rKD8sAj0XhGcqdsRg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1629231239;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=o5/C9s4BlOf4NhAuxugeefjxljfJNCvTCU//Hbla9WI=;
        b=FKN/+hTF1R/xOMnqlMs3oOERTPBLugW/L9OHH8USSseUiKxy5c6O3K0ujHkz8mXPXIS3Se
        tLQjh9aZf9RB/MCw==
From:   "tip-bot2 for Gregory Haskins" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] locking/rtmutex: Implement equal priority lock stealing
Cc:     Gregory Haskins <ghaskins@novell.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210815211305.857240222@linutronix.de>
References: <20210815211305.857240222@linutronix.de>
MIME-Version: 1.0
Message-ID: <162923123818.25758.13559046048201252355.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     48eb3f4fcfd35495a8357459aa6fe437aa430b00
Gitweb:        https://git.kernel.org/tip/48eb3f4fcfd35495a8357459aa6fe437aa430b00
Author:        Gregory Haskins <ghaskins@novell.com>
AuthorDate:    Sun, 15 Aug 2021 23:29:23 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 17 Aug 2021 19:06:07 +02:00

locking/rtmutex: Implement equal priority lock stealing

The current logic only allows lock stealing to occur if the current task is
of higher priority than the pending owner.

Significant throughput improvements can be gained by allowing the lock
stealing to include tasks of equal priority when the contended lock is a
spin_lock or a rw_lock and the tasks are not in a RT scheduling task.

The assumption was that the system will make faster progress by allowing
the task already on the CPU to take the lock rather than waiting for the
system to wake up a different task.

This does add a degree of unfairness, but in reality no negative side
effects have been observed in the many years that this has been used in the
RT kernel.

[ tglx: Refactored and rewritten several times by Steve Rostedt, Sebastian
  	Siewior and myself ]

Signed-off-by: Gregory Haskins <ghaskins@novell.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/20210815211305.857240222@linutronix.de
---
 kernel/locking/rtmutex.c | 52 ++++++++++++++++++++++++++-------------
 1 file changed, 35 insertions(+), 17 deletions(-)

diff --git a/kernel/locking/rtmutex.c b/kernel/locking/rtmutex.c
index af7e3af..3eaf636 100644
--- a/kernel/locking/rtmutex.c
+++ b/kernel/locking/rtmutex.c
@@ -338,6 +338,26 @@ static __always_inline int rt_mutex_waiter_equal(struct rt_mutex_waiter *left,
 	return 1;
 }
 
+static inline bool rt_mutex_steal(struct rt_mutex_waiter *waiter,
+				  struct rt_mutex_waiter *top_waiter)
+{
+	if (rt_mutex_waiter_less(waiter, top_waiter))
+		return true;
+
+#ifdef RT_MUTEX_BUILD_SPINLOCKS
+	/*
+	 * Note that RT tasks are excluded from same priority (lateral)
+	 * steals to prevent the introduction of an unbounded latency.
+	 */
+	if (rt_prio(waiter->prio) || dl_prio(waiter->prio))
+		return false;
+
+	return rt_mutex_waiter_equal(waiter, top_waiter);
+#else
+	return false;
+#endif
+}
+
 #define __node_2_waiter(node) \
 	rb_entry((node), struct rt_mutex_waiter, tree_entry)
 
@@ -932,19 +952,21 @@ try_to_take_rt_mutex(struct rt_mutex_base *lock, struct task_struct *task,
 	 * trylock attempt.
 	 */
 	if (waiter) {
-		/*
-		 * If waiter is not the highest priority waiter of
-		 * @lock, give up.
-		 */
-		if (waiter != rt_mutex_top_waiter(lock))
-			return 0;
+		struct rt_mutex_waiter *top_waiter = rt_mutex_top_waiter(lock);
 
 		/*
-		 * We can acquire the lock. Remove the waiter from the
-		 * lock waiters tree.
+		 * If waiter is the highest priority waiter of @lock,
+		 * or allowed to steal it, take it over.
 		 */
-		rt_mutex_dequeue(lock, waiter);
-
+		if (waiter == top_waiter || rt_mutex_steal(waiter, top_waiter)) {
+			/*
+			 * We can acquire the lock. Remove the waiter from the
+			 * lock waiters tree.
+			 */
+			rt_mutex_dequeue(lock, waiter);
+		} else {
+			return 0;
+		}
 	} else {
 		/*
 		 * If the lock has waiters already we check whether @task is
@@ -955,13 +977,9 @@ try_to_take_rt_mutex(struct rt_mutex_base *lock, struct task_struct *task,
 		 * not need to be dequeued.
 		 */
 		if (rt_mutex_has_waiters(lock)) {
-			/*
-			 * If @task->prio is greater than or equal to
-			 * the top waiter priority (kernel view),
-			 * @task lost.
-			 */
-			if (!rt_mutex_waiter_less(task_to_waiter(task),
-						  rt_mutex_top_waiter(lock)))
+			/* Check whether the trylock can steal it. */
+			if (!rt_mutex_steal(task_to_waiter(task),
+					    rt_mutex_top_waiter(lock)))
 				return 0;
 
 			/*
