Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D3CB35B4D4
	for <lists+linux-tip-commits@lfdr.de>; Sun, 11 Apr 2021 15:44:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235834AbhDKNoN (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Sun, 11 Apr 2021 09:44:13 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:33412 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235663AbhDKNoD (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Sun, 11 Apr 2021 09:44:03 -0400
Date:   Sun, 11 Apr 2021 13:43:25 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1618148605;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=F4SWF7xTh05Y+D5HrSvDZK04z3UFSbbUytSDhTk6874=;
        b=aRXlx4gV+b/zR6BoeyuJnrnNg22CczVyHAs7DI3vtGIwWnyghDnR1Z470VJxuynM4/0J39
        bTxQMby2sv7hrXVhbyRpOE/NylEWuTB/d5Iq/fVRKkjws30G3IYZF55/4bx+zdRuccm3Vn
        9xzxXARzsruX83XJaFlCSzF9nGSwR/IbC7mXsTVlwiDUWSScxzfOJIgcjDUIThQLLK6/NG
        JVifKgAIjE2jK5PpBqBUi0f1vHC4J6dYG4RpcZW3LSq0mHnDxo8OVtdENzrUZpd5kGfsYG
        BzwtUjptLjgYRYA4Iz5970GyWwZbhjlml1B6yMvt9LPQXFlkMFuwkXcBj1nQxQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1618148605;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=F4SWF7xTh05Y+D5HrSvDZK04z3UFSbbUytSDhTk6874=;
        b=z+9llQwZ7tGKsPVhL1nk897PpsXXZjdhEbTATO7j8Gz2hm8uhEE93I9GwtEU2NBt79D0Gb
        wKritcnFbX6tjLBw==
From:   "tip-bot2 for Paul E. McKenney" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] rcu: Provide polling interfaces for Tree RCU grace periods
Cc:     Frederic Weisbecker <frederic@kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <161814860511.29796.5603206002698007045.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the core/rcu branch of tip:

Commit-ID:     7abb18bd7567480e34f46d3512369ec49499064e
Gitweb:        https://git.kernel.org/tip/7abb18bd7567480e34f46d3512369ec49499064e
Author:        Paul E. McKenney <paulmck@kernel.org>
AuthorDate:    Thu, 25 Feb 2021 16:10:38 -08:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Mon, 22 Mar 2021 08:23:48 -07:00

rcu: Provide polling interfaces for Tree RCU grace periods

There is a need for a non-blocking polling interface for RCU grace
periods, so this commit supplies start_poll_synchronize_rcu() and
poll_state_synchronize_rcu() for this purpose.  Note that the existing
get_state_synchronize_rcu() may be used if future grace periods are
inevitable (perhaps due to a later call_rcu() invocation).  The new
start_poll_synchronize_rcu() is to be used if future grace periods
might not otherwise happen.  Finally, poll_state_synchronize_rcu()
provides a lockless check for a grace period having elapsed since
the corresponding call to either of the get_state_synchronize_rcu()
or start_poll_synchronize_rcu().

As with get_state_synchronize_rcu(), the return value from either
get_state_synchronize_rcu() or start_poll_synchronize_rcu() is passed in
to a later call to either poll_state_synchronize_rcu() or the existing
(might_sleep) cond_synchronize_rcu().

[ paulmck: Remove redundant smp_mb() per Frederic Weisbecker feedback. ]
[ Update poll_state_synchronize_rcu() docbook per Frederic Weisbecker feedback. ]
Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 include/linux/rcutree.h |  2 +-
 kernel/rcu/tree.c       | 75 ++++++++++++++++++++++++++++++++++++----
 2 files changed, 70 insertions(+), 7 deletions(-)

diff --git a/include/linux/rcutree.h b/include/linux/rcutree.h
index df578b7..b89b541 100644
--- a/include/linux/rcutree.h
+++ b/include/linux/rcutree.h
@@ -41,6 +41,8 @@ void rcu_momentary_dyntick_idle(void);
 void kfree_rcu_scheduler_running(void);
 bool rcu_gp_might_be_stalled(void);
 unsigned long get_state_synchronize_rcu(void);
+unsigned long start_poll_synchronize_rcu(void);
+bool poll_state_synchronize_rcu(unsigned long oldstate);
 void cond_synchronize_rcu(unsigned long oldstate);
 
 void rcu_idle_enter(void);
diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index da6f521..07e8122 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -3774,8 +3774,8 @@ EXPORT_SYMBOL_GPL(synchronize_rcu);
  * get_state_synchronize_rcu - Snapshot current RCU state
  *
  * Returns a cookie that is used by a later call to cond_synchronize_rcu()
- * to determine whether or not a full grace period has elapsed in the
- * meantime.
+ * or poll_state_synchronize_rcu() to determine whether or not a full
+ * grace period has elapsed in the meantime.
  */
 unsigned long get_state_synchronize_rcu(void)
 {
@@ -3789,13 +3789,76 @@ unsigned long get_state_synchronize_rcu(void)
 EXPORT_SYMBOL_GPL(get_state_synchronize_rcu);
 
 /**
+ * start_poll_synchronize_rcu - Snapshot and start RCU grace period
+ *
+ * Returns a cookie that is used by a later call to cond_synchronize_rcu()
+ * or poll_state_synchronize_rcu() to determine whether or not a full
+ * grace period has elapsed in the meantime.  If the needed grace period
+ * is not already slated to start, notifies RCU core of the need for that
+ * grace period.
+ *
+ * Interrupts must be enabled for the case where it is necessary to awaken
+ * the grace-period kthread.
+ */
+unsigned long start_poll_synchronize_rcu(void)
+{
+	unsigned long flags;
+	unsigned long gp_seq = get_state_synchronize_rcu();
+	bool needwake;
+	struct rcu_data *rdp;
+	struct rcu_node *rnp;
+
+	lockdep_assert_irqs_enabled();
+	local_irq_save(flags);
+	rdp = this_cpu_ptr(&rcu_data);
+	rnp = rdp->mynode;
+	raw_spin_lock_rcu_node(rnp); // irqs already disabled.
+	needwake = rcu_start_this_gp(rnp, rdp, gp_seq);
+	raw_spin_unlock_irqrestore_rcu_node(rnp, flags);
+	if (needwake)
+		rcu_gp_kthread_wake();
+	return gp_seq;
+}
+EXPORT_SYMBOL_GPL(start_poll_synchronize_rcu);
+
+/**
+ * poll_state_synchronize_rcu - Conditionally wait for an RCU grace period
+ *
+ * @oldstate: return from call to get_state_synchronize_rcu() or start_poll_synchronize_rcu()
+ *
+ * If a full RCU grace period has elapsed since the earlier call from
+ * which oldstate was obtained, return @true, otherwise return @false.
+ * If @false is returned, it is the caller's responsibilty to invoke this
+ * function later on until it does return @true.  Alternatively, the caller
+ * can explicitly wait for a grace period, for example, by passing @oldstate
+ * to cond_synchronize_rcu() or by directly invoking synchronize_rcu().
+ *
+ * Yes, this function does not take counter wrap into account.
+ * But counter wrap is harmless.  If the counter wraps, we have waited for
+ * more than 2 billion grace periods (and way more on a 64-bit system!).
+ * Those needing to keep oldstate values for very long time periods
+ * (many hours even on 32-bit systems) should check them occasionally
+ * and either refresh them or set a flag indicating that the grace period
+ * has completed.
+ */
+bool poll_state_synchronize_rcu(unsigned long oldstate)
+{
+	if (rcu_seq_done(&rcu_state.gp_seq, oldstate)) {
+		smp_mb(); /* Ensure GP ends before subsequent accesses. */
+		return true;
+	}
+	return false;
+}
+EXPORT_SYMBOL_GPL(poll_state_synchronize_rcu);
+
+/**
  * cond_synchronize_rcu - Conditionally wait for an RCU grace period
  *
  * @oldstate: return value from earlier call to get_state_synchronize_rcu()
  *
  * If a full RCU grace period has elapsed since the earlier call to
- * get_state_synchronize_rcu(), just return.  Otherwise, invoke
- * synchronize_rcu() to wait for a full grace period.
+ * get_state_synchronize_rcu() or start_poll_synchronize_rcu(), just return.
+ * Otherwise, invoke synchronize_rcu() to wait for a full grace period.
  *
  * Yes, this function does not take counter wrap into account.  But
  * counter wrap is harmless.  If the counter wraps, we have waited for
@@ -3804,10 +3867,8 @@ EXPORT_SYMBOL_GPL(get_state_synchronize_rcu);
  */
 void cond_synchronize_rcu(unsigned long oldstate)
 {
-	if (!rcu_seq_done(&rcu_state.gp_seq, oldstate))
+	if (!poll_state_synchronize_rcu(oldstate))
 		synchronize_rcu();
-	else
-		smp_mb(); /* Ensure GP ends before subsequent accesses. */
 }
 EXPORT_SYMBOL_GPL(cond_synchronize_rcu);
 
