Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 28428319ECE
	for <lists+linux-tip-commits@lfdr.de>; Fri, 12 Feb 2021 13:43:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231546AbhBLMll (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 12 Feb 2021 07:41:41 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:45338 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230484AbhBLMkG (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 12 Feb 2021 07:40:06 -0500
Date:   Fri, 12 Feb 2021 12:37:19 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1613133440;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=9bJUFtXeB2auKF4a4ZONtsooyby8H+ENKrSP3FYybEw=;
        b=t0tSwvGynVy6wcRqiU/mdPjjZ3NMWLkZNjZ3tLmCBRIhj0kEFuLYp6delKm44e89eUE73z
        n14BhHdi6KRKCcmuEvWi3CamRuqv++SzvZb3m0AtPNXBIxDQHnLXF1uqcv7uzeKGKXZQ36
        R0f7pdlUBsYzgo3vP3KP8MFrVH5HD27J7wSZIRnhN1jqUnwCMvUnwG7VqWkUAC0So8+Ldr
        nONpr+2pD0OTAGK1A6+0WCWn2SFQtrIInUbmBkez8hdDdnXGwRrn1Lzx7XIbovIvJzU+Go
        886QBx9bSMKvOWJ4cL/2uYl7XkqTGTZWpuGgyZtNCgkfpNeNQROYpbpMlcjxwA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1613133440;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=9bJUFtXeB2auKF4a4ZONtsooyby8H+ENKrSP3FYybEw=;
        b=xRBp84csZVIVL0FRHNF0F7p6vgzSEz2x9xtblBkfmknZSk2l74AzUsYPF2yQLYKqHpV8jG
        /aPUUTRCiaSuaoAw==
From:   "tip-bot2 for Frederic Weisbecker" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] rcu/nocb: De-offloading GP kthread
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
Message-ID: <161313343950.23325.15842852853541510969.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the core/rcu branch of tip:

Commit-ID:     5bb39dc956f3d4f1bb75b5962b503426c45340ae
Gitweb:        https://git.kernel.org/tip/5bb39dc956f3d4f1bb75b5962b503426c45340ae
Author:        Frederic Weisbecker <frederic@kernel.org>
AuthorDate:    Fri, 13 Nov 2020 13:13:21 +01:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Wed, 06 Jan 2021 16:24:20 -08:00

rcu/nocb: De-offloading GP kthread

To de-offload callback processing back onto a CPU, it is necessary
to clear SEGCBLIST_OFFLOAD and notify the nocb GP kthread, which will
then clear its own bit flag and ignore this CPU until further notice.
Whichever of the nocb CB and nocb GP kthreads is last to clear its own
bit notifies the de-offloading worker kthread.  Once notified, this
worker kthread can proceed safe in the knowledge that the nocb CB and
GP kthreads will no longer be manipulating this CPU's RCU callback list.

This commit makes this change.

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
 kernel/rcu/tree_plugin.h | 54 ++++++++++++++++++++++++++++++++++++---
 1 file changed, 51 insertions(+), 3 deletions(-)

diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
index b70cc91..fe46e70 100644
--- a/kernel/rcu/tree_plugin.h
+++ b/kernel/rcu/tree_plugin.h
@@ -1928,6 +1928,33 @@ static void do_nocb_bypass_wakeup_timer(struct timer_list *t)
 	__call_rcu_nocb_wake(rdp, true, flags);
 }
 
+static inline bool nocb_gp_enabled_cb(struct rcu_data *rdp)
+{
+	u8 flags = SEGCBLIST_OFFLOADED | SEGCBLIST_KTHREAD_GP;
+
+	return rcu_segcblist_test_flags(&rdp->cblist, flags);
+}
+
+static inline bool nocb_gp_update_state(struct rcu_data *rdp, bool *needwake_state)
+{
+	struct rcu_segcblist *cblist = &rdp->cblist;
+
+	if (rcu_segcblist_test_flags(cblist, SEGCBLIST_OFFLOADED)) {
+		return true;
+	} else {
+		/*
+		 * De-offloading. Clear our flag and notify the de-offload worker.
+		 * We will ignore this rdp until it ever gets re-offloaded.
+		 */
+		WARN_ON_ONCE(!rcu_segcblist_test_flags(cblist, SEGCBLIST_KTHREAD_GP));
+		rcu_segcblist_clear_flags(cblist, SEGCBLIST_KTHREAD_GP);
+		if (!rcu_segcblist_test_flags(cblist, SEGCBLIST_KTHREAD_CB))
+			*needwake_state = true;
+		return false;
+	}
+}
+
+
 /*
  * No-CBs GP kthreads come here to wait for additional callbacks to show up
  * or for grace periods to end.
@@ -1956,8 +1983,17 @@ static void nocb_gp_wait(struct rcu_data *my_rdp)
 	 */
 	WARN_ON_ONCE(my_rdp->nocb_gp_rdp != my_rdp);
 	for (rdp = my_rdp; rdp; rdp = rdp->nocb_next_cb_rdp) {
+		bool needwake_state = false;
+		if (!nocb_gp_enabled_cb(rdp))
+			continue;
 		trace_rcu_nocb_wake(rcu_state.name, rdp->cpu, TPS("Check"));
 		rcu_nocb_lock_irqsave(rdp, flags);
+		if (!nocb_gp_update_state(rdp, &needwake_state)) {
+			rcu_nocb_unlock_irqrestore(rdp, flags);
+			if (needwake_state)
+				swake_up_one(&rdp->nocb_state_wq);
+			continue;
+		}
 		bypass_ncbs = rcu_cblist_n_cbs(&rdp->nocb_bypass);
 		if (bypass_ncbs &&
 		    (time_after(j, READ_ONCE(rdp->nocb_bypass_first) + 1) ||
@@ -2221,7 +2257,8 @@ static void do_nocb_deferred_wakeup(struct rcu_data *rdp)
 static int __rcu_nocb_rdp_deoffload(struct rcu_data *rdp)
 {
 	struct rcu_segcblist *cblist = &rdp->cblist;
-	bool wake_cb = false;
+	struct rcu_data *rdp_gp = rdp->nocb_gp_rdp;
+	bool wake_cb = false, wake_gp = false;
 	unsigned long flags;
 
 	printk("De-offloading %d\n", rdp->cpu);
@@ -2247,9 +2284,19 @@ static int __rcu_nocb_rdp_deoffload(struct rcu_data *rdp)
 	if (wake_cb)
 		swake_up_one(&rdp->nocb_cb_wq);
 
-	swait_event_exclusive(rdp->nocb_state_wq,
-			      !rcu_segcblist_test_flags(cblist, SEGCBLIST_KTHREAD_CB));
+	raw_spin_lock_irqsave(&rdp_gp->nocb_gp_lock, flags);
+	if (rdp_gp->nocb_gp_sleep) {
+		rdp_gp->nocb_gp_sleep = false;
+		wake_gp = true;
+	}
+	raw_spin_unlock_irqrestore(&rdp_gp->nocb_gp_lock, flags);
 
+	if (wake_gp)
+		wake_up_process(rdp_gp->nocb_gp_kthread);
+
+	swait_event_exclusive(rdp->nocb_state_wq,
+			      !rcu_segcblist_test_flags(cblist, SEGCBLIST_KTHREAD_CB |
+							SEGCBLIST_KTHREAD_GP));
 	return 0;
 }
 
@@ -2332,6 +2379,7 @@ void __init rcu_init_nohz(void)
 			rcu_segcblist_init(&rdp->cblist);
 		rcu_segcblist_offload(&rdp->cblist, true);
 		rcu_segcblist_set_flags(&rdp->cblist, SEGCBLIST_KTHREAD_CB);
+		rcu_segcblist_set_flags(&rdp->cblist, SEGCBLIST_KTHREAD_GP);
 	}
 	rcu_organize_nocb_kthreads();
 }
