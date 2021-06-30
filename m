Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A9F83B83FF
	for <lists+linux-tip-commits@lfdr.de>; Wed, 30 Jun 2021 15:49:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235654AbhF3Nvw (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 30 Jun 2021 09:51:52 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:33042 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235888AbhF3Nuo (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 30 Jun 2021 09:50:44 -0400
Date:   Wed, 30 Jun 2021 13:47:56 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1625060877;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=XB78Wcn4rl4VRLKS6/gWV5tmFYZBCBIBZowhi6UAF3I=;
        b=u63pB4Ogo6kQ+aDyL5VkC5UzdsoP3P3t30lBQsUpH+cSHrqQYCkbMqX6iynSyfVeCfU66V
        qlkPkpHqxIXD7UHO5rxdCDmy6zfWRfZ2GQJJTx+oxzc3grIXJ7ILvuVlU0G2ceRAkD/A0o
        3PNTDxAZdF7uWAjgFoiOw8eWE4WT6dwL5TbNBYQw+91dtPEQ/6eOXoanHib9PhD9Pas6DQ
        RP1FSLjg2SyVrvlQ/wIEC8p2otWaitht+gdio5YcLPU+UrEVkcBl4/yTiR6WOiAW5exfOg
        TQjdTFRxKH/xEvdOvzf1qsm749Zo2kZ9wAmgouU0Es5Aqh0HaDGI/J0qgXnUEw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1625060877;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=XB78Wcn4rl4VRLKS6/gWV5tmFYZBCBIBZowhi6UAF3I=;
        b=qrzgsq2RhRBnoBz+yP6M2bsE7CDO5rPnMFgxnGBbLVxyNi97VwnkxtJ7oirK8ED088i8tW
        ypwTNDoVUehSiKCg==
From:   "tip-bot2 for Uladzislau Rezki (Sony)" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] kvfree_rcu: Refactor kfree_rcu_monitor()
Cc:     "Uladzislau Rezki (Sony)" <urezki@gmail.com>,
        "Paul E. McKenney" <paulmck@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <162506087694.395.7382752866056731618.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the core/rcu branch of tip:

Commit-ID:     a78d4a2a1017dea67857a1164d73642743e89a0f
Gitweb:        https://git.kernel.org/tip/a78d4a2a1017dea67857a1164d73642743e89a0f
Author:        Uladzislau Rezki (Sony) <urezki@gmail.com>
AuthorDate:    Wed, 21 Apr 2021 13:22:52 +02:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Mon, 10 May 2021 16:00:48 -07:00

kvfree_rcu: Refactor kfree_rcu_monitor()

Currently we have three functions which depend on each other.
Two of them are quite tiny and the last one where the most
work is done. All of them are related to queuing RCU batches
to reclaim objects after a GP.

1. kfree_rcu_monitor(). It consist of few lines. It acquires a spin-lock
   and calls kfree_rcu_drain_unlock().

2. kfree_rcu_drain_unlock(). It also consists of few lines of code. It
   calls queue_kfree_rcu_work() to queue the batch.  If this fails,
   it rearms the monitor work to try again later.

3. queue_kfree_rcu_work(). This provides the bulk of the functionality,
   attempting to start a new batch to free objects after a GP.

Since there are no external users of functions [2] and [3], both
can eliminated by moving all logic directly into [1], which both
shrinks and simplifies the code.

Also replace comments which start with "/*" to "//" format to make it
unified across the file.

Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tree.c | 84 ++++++++++++++--------------------------------
 1 file changed, 26 insertions(+), 58 deletions(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index b043af7..618ec91 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -3379,29 +3379,26 @@ static void kfree_rcu_work(struct work_struct *work)
 }
 
 /*
- * Schedule the kfree batch RCU work to run in workqueue context after a GP.
- *
- * This function is invoked by kfree_rcu_monitor() when the KFREE_DRAIN_JIFFIES
- * timeout has been reached.
+ * This function is invoked after the KFREE_DRAIN_JIFFIES timeout.
  */
-static inline bool queue_kfree_rcu_work(struct kfree_rcu_cpu *krcp)
+static void kfree_rcu_monitor(struct work_struct *work)
 {
-	struct kfree_rcu_cpu_work *krwp;
-	bool repeat = false;
+	struct kfree_rcu_cpu *krcp = container_of(work,
+		struct kfree_rcu_cpu, monitor_work.work);
+	unsigned long flags;
 	int i, j;
 
-	lockdep_assert_held(&krcp->lock);
+	raw_spin_lock_irqsave(&krcp->lock, flags);
 
+	// Attempt to start a new batch.
 	for (i = 0; i < KFREE_N_BATCHES; i++) {
-		krwp = &(krcp->krw_arr[i]);
+		struct kfree_rcu_cpu_work *krwp = &(krcp->krw_arr[i]);
 
-		/*
-		 * Try to detach bkvhead or head and attach it over any
-		 * available corresponding free channel. It can be that
-		 * a previous RCU batch is in progress, it means that
-		 * immediately to queue another one is not possible so
-		 * return false to tell caller to retry.
-		 */
+		// Try to detach bkvhead or head and attach it over any
+		// available corresponding free channel. It can be that
+		// a previous RCU batch is in progress, it means that
+		// immediately to queue another one is not possible so
+		// in that case the monitor work is rearmed.
 		if ((krcp->bkvhead[0] && !krwp->bkvhead_free[0]) ||
 			(krcp->bkvhead[1] && !krwp->bkvhead_free[1]) ||
 				(krcp->head && !krwp->head_free)) {
@@ -3423,57 +3420,28 @@ static inline bool queue_kfree_rcu_work(struct kfree_rcu_cpu *krcp)
 
 			WRITE_ONCE(krcp->count, 0);
 
-			/*
-			 * One work is per one batch, so there are three
-			 * "free channels", the batch can handle. It can
-			 * be that the work is in the pending state when
-			 * channels have been detached following by each
-			 * other.
-			 */
+			// One work is per one batch, so there are three
+			// "free channels", the batch can handle. It can
+			// be that the work is in the pending state when
+			// channels have been detached following by each
+			// other.
 			queue_rcu_work(system_wq, &krwp->rcu_work);
 		}
-
-		// Repeat if any "free" corresponding channel is still busy.
-		if (krcp->bkvhead[0] || krcp->bkvhead[1] || krcp->head)
-			repeat = true;
 	}
 
-	return !repeat;
-}
-
-static inline void kfree_rcu_drain_unlock(struct kfree_rcu_cpu *krcp,
-					  unsigned long flags)
-{
-	// Attempt to start a new batch.
-	if (queue_kfree_rcu_work(krcp)) {
-		// Success! Our job is done here.
+	// If there is nothing to detach, it means that our job is
+	// successfully done here. In case of having at least one
+	// of the channels that is still busy we should rearm the
+	// work to repeat an attempt. Because previous batches are
+	// still in progress.
+	if (!krcp->bkvhead[0] && !krcp->bkvhead[1] && !krcp->head)
 		krcp->monitor_todo = false;
-		raw_spin_unlock_irqrestore(&krcp->lock, flags);
-		return;
-	}
+	else
+		schedule_delayed_work(&krcp->monitor_work, KFREE_DRAIN_JIFFIES);
 
-	// Previous RCU batch still in progress, try again later.
-	schedule_delayed_work(&krcp->monitor_work, KFREE_DRAIN_JIFFIES);
 	raw_spin_unlock_irqrestore(&krcp->lock, flags);
 }
 
-/*
- * This function is invoked after the KFREE_DRAIN_JIFFIES timeout.
- * It invokes kfree_rcu_drain_unlock() to attempt to start another batch.
- */
-static void kfree_rcu_monitor(struct work_struct *work)
-{
-	unsigned long flags;
-	struct kfree_rcu_cpu *krcp = container_of(work, struct kfree_rcu_cpu,
-						 monitor_work.work);
-
-	raw_spin_lock_irqsave(&krcp->lock, flags);
-	if (krcp->monitor_todo)
-		kfree_rcu_drain_unlock(krcp, flags);
-	else
-		raw_spin_unlock_irqrestore(&krcp->lock, flags);
-}
-
 static enum hrtimer_restart
 schedule_page_work_fn(struct hrtimer *t)
 {
