Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57E8E35B4D6
	for <lists+linux-tip-commits@lfdr.de>; Sun, 11 Apr 2021 15:44:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235842AbhDKNoO (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Sun, 11 Apr 2021 09:44:14 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:33032 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235669AbhDKNoE (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Sun, 11 Apr 2021 09:44:04 -0400
Date:   Sun, 11 Apr 2021 13:43:26 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1618148606;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=nOcyLVAkLfK8IpMzoQCct8TR/K7mVK5dOt96BPErnz0=;
        b=uJYpQUZeHxV+EAhMVx7f966I304ap3GDjIMlSF7EX1kZi/0wdQtQUO7Ez+6TXCBiW3vHXd
        qOiA7nvMep0wbKRqOSmKv+pk0+yHP1IfOK4He64XLs3Ic2jKxP9dw5lthgZ/wfbeW+feJ4
        OB6SSRx8ezHTV7RWj4wG4ZBlirG9pSmNWK0k5ZUGNGug16+Gs4egy1QYhgFxgJ4u6Ro+rT
        bWD1OJTUM0wa8mck4MKLgdxdFOtgqwUUBgRpK+kRbHOmxKJWiovwPHOtE9ZiNeJ0IPkFfU
        bDP8h0InEh/cEjyh5S12qAIMmU/zfL+HakzU979i88HBTSEF1MaG7vXjLKBBfQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1618148606;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=nOcyLVAkLfK8IpMzoQCct8TR/K7mVK5dOt96BPErnz0=;
        b=5puX8yJRTO59yDfOsSPcsAGqNpUYlPkgnPkuLOqRnJIb/g7bwWl0Dxct24fRkKGVv9NHxC
        BW68Z2UAksZiLTAw==
From:   "tip-bot2 for Frederic Weisbecker" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] rcu/nocb: Disable bypass when CPU isn't completely offloaded
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Neeraj Upadhyay <neeraju@codeaurora.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Frederic Weisbecker <frederic@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <161814860604.29796.7866400610798245735.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the core/rcu branch of tip:

Commit-ID:     76d00b494d7962e88d4bbd4135f34aba9019c67f
Gitweb:        https://git.kernel.org/tip/76d00b494d7962e88d4bbd4135f34aba9019c67f
Author:        Frederic Weisbecker <frederic@kernel.org>
AuthorDate:    Tue, 23 Feb 2021 01:10:00 +01:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Mon, 15 Mar 2021 13:54:54 -07:00

rcu/nocb: Disable bypass when CPU isn't completely offloaded

Currently, the bypass is flushed at the very last moment in the
deoffloading procedure.  However, this approach leads to a larger state
space than would be preferred.  This commit therefore disables the
bypass at soon as the deoffloading procedure begins, then flushes it.
This guarantees that the bypass remains empty and thus out of the way
of the deoffloading procedure.

Symmetrically, this commit waits to enable the bypass until the offloading
procedure has completed.

Reported-by: Paul E. McKenney <paulmck@kernel.org>
Cc: Josh Triplett <josh@joshtriplett.org>
Cc: Lai Jiangshan <jiangshanlai@gmail.com>
Cc: Joel Fernandes <joel@joelfernandes.org>
Cc: Neeraj Upadhyay <neeraju@codeaurora.org>
Cc: Boqun Feng <boqun.feng@gmail.com>
Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 include/linux/rcu_segcblist.h |  7 +++---
 kernel/rcu/tree_plugin.h      | 38 +++++++++++++++++++++++++---------
 2 files changed, 33 insertions(+), 12 deletions(-)

diff --git a/include/linux/rcu_segcblist.h b/include/linux/rcu_segcblist.h
index 8afe886..3db96c4 100644
--- a/include/linux/rcu_segcblist.h
+++ b/include/linux/rcu_segcblist.h
@@ -109,7 +109,7 @@ struct rcu_cblist {
  *  |                           SEGCBLIST_KTHREAD_GP                           |
  *  |                                                                          |
  *  |   Kthreads handle callbacks holding nocb_lock, local rcu_core() stops    |
- *  |   handling callbacks.                                                    |
+ *  |   handling callbacks. Enable bypass queueing.                            |
  *  ----------------------------------------------------------------------------
  */
 
@@ -125,7 +125,7 @@ struct rcu_cblist {
  *  |                           SEGCBLIST_KTHREAD_GP                           |
  *  |                                                                          |
  *  |   CB/GP kthreads handle callbacks holding nocb_lock, local rcu_core()    |
- *  |   ignores callbacks.                                                     |
+ *  |   ignores callbacks. Bypass enqueue is enabled.                          |
  *  ----------------------------------------------------------------------------
  *                                      |
  *                                      v
@@ -134,7 +134,8 @@ struct rcu_cblist {
  *  |                           SEGCBLIST_KTHREAD_GP                           |
  *  |                                                                          |
  *  |   CB/GP kthreads and local rcu_core() handle callbacks concurrently      |
- *  |   holding nocb_lock. Wake up CB and GP kthreads if necessary.            |
+ *  |   holding nocb_lock. Wake up CB and GP kthreads if necessary. Disable    |
+ *  |   bypass enqueue.                                                        |
  *  ----------------------------------------------------------------------------
  *                                      |
  *                                      v
diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
index e392bd1..b08564b 100644
--- a/kernel/rcu/tree_plugin.h
+++ b/kernel/rcu/tree_plugin.h
@@ -1830,11 +1830,22 @@ static bool rcu_nocb_try_bypass(struct rcu_data *rdp, struct rcu_head *rhp,
 	unsigned long j = jiffies;
 	long ncbs = rcu_cblist_n_cbs(&rdp->nocb_bypass);
 
+	lockdep_assert_irqs_disabled();
+
+	// Pure softirq/rcuc based processing: no bypassing, no
+	// locking.
 	if (!rcu_rdp_is_offloaded(rdp)) {
 		*was_alldone = !rcu_segcblist_pend_cbs(&rdp->cblist);
+		return false;
+	}
+
+	// In the process of (de-)offloading: no bypassing, but
+	// locking.
+	if (!rcu_segcblist_completely_offloaded(&rdp->cblist)) {
+		rcu_nocb_lock(rdp);
+		*was_alldone = !rcu_segcblist_pend_cbs(&rdp->cblist);
 		return false; /* Not offloaded, no bypassing. */
 	}
-	lockdep_assert_irqs_disabled();
 
 	// Don't use ->nocb_bypass during early boot.
 	if (rcu_scheduler_active != RCU_SCHEDULER_RUNNING) {
@@ -2416,7 +2427,16 @@ static long rcu_nocb_rdp_deoffload(void *arg)
 	pr_info("De-offloading %d\n", rdp->cpu);
 
 	rcu_nocb_lock_irqsave(rdp, flags);
-
+	/*
+	 * Flush once and for all now. This suffices because we are
+	 * running on the target CPU holding ->nocb_lock (thus having
+	 * interrupts disabled), and because rdp_offload_toggle()
+	 * invokes rcu_segcblist_offload(), which clears SEGCBLIST_OFFLOADED.
+	 * Thus future calls to rcu_segcblist_completely_offloaded() will
+	 * return false, which means that future calls to rcu_nocb_try_bypass()
+	 * will refuse to put anything into the bypass.
+	 */
+	WARN_ON_ONCE(!rcu_nocb_flush_bypass(rdp, NULL, jiffies));
 	ret = rdp_offload_toggle(rdp, false, flags);
 	swait_event_exclusive(rdp->nocb_state_wq,
 			      !rcu_segcblist_test_flags(cblist, SEGCBLIST_KTHREAD_CB |
@@ -2428,21 +2448,21 @@ static long rcu_nocb_rdp_deoffload(void *arg)
 	del_timer_sync(&rdp->nocb_timer);
 
 	/*
-	 * Flush bypass. While IRQs are disabled and once we set
-	 * SEGCBLIST_SOFTIRQ_ONLY, no callback is supposed to be
-	 * enqueued on bypass.
+	 * Theoretically we could set SEGCBLIST_SOFTIRQ_ONLY with CB unlocked
+	 * and IRQs disabled but let's be paranoid.
 	 */
 	rcu_nocb_lock_irqsave(rdp, flags);
-	rcu_nocb_flush_bypass(rdp, NULL, jiffies);
 	rcu_segcblist_set_flags(cblist, SEGCBLIST_SOFTIRQ_ONLY);
 	/*
 	 * With SEGCBLIST_SOFTIRQ_ONLY, we can't use
-	 * rcu_nocb_unlock_irqrestore() anymore. Theoretically we
-	 * could set SEGCBLIST_SOFTIRQ_ONLY with cb unlocked and IRQs
-	 * disabled now, but let's be paranoid.
+	 * rcu_nocb_unlock_irqrestore() anymore.
 	 */
 	raw_spin_unlock_irqrestore(&rdp->nocb_lock, flags);
 
+	/* Sanity check */
+	WARN_ON_ONCE(rcu_cblist_n_cbs(&rdp->nocb_bypass));
+
+
 	return ret;
 }
 
