Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07B23319EC9
	for <lists+linux-tip-commits@lfdr.de>; Fri, 12 Feb 2021 13:42:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231771AbhBLMlH (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 12 Feb 2021 07:41:07 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:45848 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230228AbhBLMj7 (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 12 Feb 2021 07:39:59 -0500
Date:   Fri, 12 Feb 2021 12:37:19 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1613133439;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=1ywynmfD14SqBVCGKEq3XnaxhM4ntky2Hf/tLRfPJ3A=;
        b=NGQ6EW+mEh31Qva5Of17OoHA9MC2dPQn5Cyr+O0PXUy0ZGjNVqiFr3luBZPSgYa2pRuByE
        K3tlR45q1Qosek8lYqm4EmLRv5sZIJhxjhuuEYCzMvkPaahFTLtky1uPRCK3gbxxeUNg7j
        Q11BE2OMakOyhrrC+VxtVfU5is7nSQmm+QRRirf1iL5ZhVTNROIzHbMCWSqtR6dEuwYD4Y
        43u42lpiVITy7vaHN/4r5k5jVKsuVlhRx/Au6O4PcwyEi6jZEJHoAKcQLG3EHNkVLn3uZX
        CeDnEut6wOtHhO2Q8up64sXK9GOX+mEEWHl47U6Qfe7LACnBmpE2O6IlXdtOEg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1613133439;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=1ywynmfD14SqBVCGKEq3XnaxhM4ntky2Hf/tLRfPJ3A=;
        b=4b5OU62H+ziX2et+FIeAM3RnKNRUxM0AXJUM66V3xvQfFO3/qdkMBK3vk64VOMK5jXz7zr
        HZ2op1u9J+p+4qBw==
From:   "tip-bot2 for Frederic Weisbecker" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] rcu/nocb: Shutdown nocb timer on de-offloading
Cc:     Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Neeraj Upadhyay <neeraju@codeaurora.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Boqun Feng <boqun.feng@gmail.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <161313343905.23325.10526401831468637946.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the core/rcu branch of tip:

Commit-ID:     69cdea873cde261586a2cae2440178df1a313bbe
Gitweb:        https://git.kernel.org/tip/69cdea873cde261586a2cae2440178df1a313bbe
Author:        Frederic Weisbecker <frederic@kernel.org>
AuthorDate:    Fri, 13 Nov 2020 13:13:23 +01:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Wed, 06 Jan 2021 16:24:59 -08:00

rcu/nocb: Shutdown nocb timer on de-offloading

This commit ensures that the nocb timer is shut down before reaching the
final de-offloaded state.  The key goal is to prevent the timer handler
from manipulating the callbacks without the protection of the nocb locks.

Cc: Josh Triplett <josh@joshtriplett.org>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Lai Jiangshan <jiangshanlai@gmail.com>
Cc: Joel Fernandes <joel@joelfernandes.org>
Cc: Neeraj Upadhyay <neeraju@codeaurora.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Inspired-by: Paul E. McKenney <paulmck@kernel.org>
Tested-by: Boqun Feng <boqun.feng@gmail.com>
Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tree.h        |  1 +
 kernel/rcu/tree_plugin.h | 12 +++++++++++-
 2 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/kernel/rcu/tree.h b/kernel/rcu/tree.h
index e0deb48..5d359b9 100644
--- a/kernel/rcu/tree.h
+++ b/kernel/rcu/tree.h
@@ -257,6 +257,7 @@ struct rcu_data {
 };
 
 /* Values for nocb_defer_wakeup field in struct rcu_data. */
+#define RCU_NOCB_WAKE_OFF	-1
 #define RCU_NOCB_WAKE_NOT	0
 #define RCU_NOCB_WAKE		1
 #define RCU_NOCB_WAKE_FORCE	2
diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
index 03ae1ce..c88ad62 100644
--- a/kernel/rcu/tree_plugin.h
+++ b/kernel/rcu/tree_plugin.h
@@ -1665,6 +1665,8 @@ static void wake_nocb_gp(struct rcu_data *rdp, bool force,
 static void wake_nocb_gp_defer(struct rcu_data *rdp, int waketype,
 			       const char *reason)
 {
+	if (rdp->nocb_defer_wakeup == RCU_NOCB_WAKE_OFF)
+		return;
 	if (rdp->nocb_defer_wakeup == RCU_NOCB_WAKE_NOT)
 		mod_timer(&rdp->nocb_timer, jiffies + 1);
 	if (rdp->nocb_defer_wakeup < waketype)
@@ -2243,7 +2245,7 @@ static int rcu_nocb_cb_kthread(void *arg)
 /* Is a deferred wakeup of rcu_nocb_kthread() required? */
 static int rcu_nocb_need_deferred_wakeup(struct rcu_data *rdp)
 {
-	return READ_ONCE(rdp->nocb_defer_wakeup);
+	return READ_ONCE(rdp->nocb_defer_wakeup) > RCU_NOCB_WAKE_NOT;
 }
 
 /* Do a deferred wakeup of rcu_nocb_kthread(). */
@@ -2337,6 +2339,12 @@ static int __rcu_nocb_rdp_deoffload(struct rcu_data *rdp)
 	swait_event_exclusive(rdp->nocb_state_wq,
 			      !rcu_segcblist_test_flags(cblist, SEGCBLIST_KTHREAD_CB |
 							SEGCBLIST_KTHREAD_GP));
+	/* Make sure nocb timer won't stay around */
+	rcu_nocb_lock_irqsave(rdp, flags);
+	WRITE_ONCE(rdp->nocb_defer_wakeup, RCU_NOCB_WAKE_OFF);
+	rcu_nocb_unlock_irqrestore(rdp, flags);
+	del_timer_sync(&rdp->nocb_timer);
+
 	return ret;
 }
 
@@ -2394,6 +2402,8 @@ static int __rcu_nocb_rdp_offload(struct rcu_data *rdp)
 	 * SEGCBLIST_SOFTIRQ_ONLY mode.
 	 */
 	raw_spin_lock_irqsave(&rdp->nocb_lock, flags);
+	/* Re-enable nocb timer */
+	WRITE_ONCE(rdp->nocb_defer_wakeup, RCU_NOCB_WAKE_NOT);
 	/*
 	 * We didn't take the nocb lock while working on the
 	 * rdp->cblist in SEGCBLIST_SOFTIRQ_ONLY mode.
