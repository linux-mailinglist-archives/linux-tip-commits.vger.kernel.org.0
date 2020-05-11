Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D9C71CE6B8
	for <lists+linux-tip-commits@lfdr.de>; Mon, 11 May 2020 23:05:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732004AbgEKU7v (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Mon, 11 May 2020 16:59:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1732001AbgEKU7u (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Mon, 11 May 2020 16:59:50 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6306BC061A0E;
        Mon, 11 May 2020 13:59:50 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jYFWe-0005v0-Km; Mon, 11 May 2020 22:59:48 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 608821C04E3;
        Mon, 11 May 2020 22:59:36 +0200 (CEST)
Date:   Mon, 11 May 2020 20:59:36 -0000
From:   "tip-bot2 for Paul E. McKenney" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] rcu: Add comments marking transitions between RCU
 watching and not
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        "Paul E. McKenney" <paulmck@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <158923077632.390.8026861063383116954.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-tip-commits-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the core/rcu branch of tip:

Commit-ID:     ac3caf827488d3bc4d4101ff34931abbfa33839d
Gitweb:        https://git.kernel.org/tip/ac3caf827488d3bc4d4101ff34931abbfa33839d
Author:        Paul E. McKenney <paulmck@kernel.org>
AuthorDate:    Thu, 12 Mar 2020 17:01:57 -07:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Mon, 27 Apr 2020 11:03:50 -07:00

rcu: Add comments marking transitions between RCU watching and not

It is not as clear as it might be just where in RCU's idle entry/exit
code RCU stops and starts watching the current CPU.  This commit therefore
adds comments calling out the transitions.

Reported-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tree.c | 29 +++++++++++++++++++++++++----
 1 file changed, 25 insertions(+), 4 deletions(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 156ac8d..0bbcbf3 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -238,7 +238,9 @@ void rcu_softirq_qs(void)
 
 /*
  * Record entry into an extended quiescent state.  This is only to be
- * called when not already in an extended quiescent state.
+ * called when not already in an extended quiescent state, that is,
+ * RCU is watching prior to the call to this function and is no longer
+ * watching upon return.
  */
 static void rcu_dynticks_eqs_enter(void)
 {
@@ -251,7 +253,7 @@ static void rcu_dynticks_eqs_enter(void)
 	 * next idle sojourn.
 	 */
 	seq = atomic_add_return(RCU_DYNTICK_CTRL_CTR, &rdp->dynticks);
-	/* Better be in an extended quiescent state! */
+	// RCU is no longer watching.  Better be in extended quiescent state!
 	WARN_ON_ONCE(IS_ENABLED(CONFIG_RCU_EQS_DEBUG) &&
 		     (seq & RCU_DYNTICK_CTRL_CTR));
 	/* Better not have special action (TLB flush) pending! */
@@ -261,7 +263,8 @@ static void rcu_dynticks_eqs_enter(void)
 
 /*
  * Record exit from an extended quiescent state.  This is only to be
- * called from an extended quiescent state.
+ * called from an extended quiescent state, that is, RCU is not watching
+ * prior to the call to this function and is watching upon return.
  */
 static void rcu_dynticks_eqs_exit(void)
 {
@@ -274,6 +277,7 @@ static void rcu_dynticks_eqs_exit(void)
 	 * critical section.
 	 */
 	seq = atomic_add_return(RCU_DYNTICK_CTRL_CTR, &rdp->dynticks);
+	// RCU is now watching.  Better not be in an extended quiescent state!
 	WARN_ON_ONCE(IS_ENABLED(CONFIG_RCU_EQS_DEBUG) &&
 		     !(seq & RCU_DYNTICK_CTRL_CTR));
 	if (seq & RCU_DYNTICK_CTRL_MASK) {
@@ -584,6 +588,7 @@ static void rcu_eqs_enter(bool user)
 	WARN_ON_ONCE(IS_ENABLED(CONFIG_RCU_EQS_DEBUG) &&
 		     rdp->dynticks_nesting == 0);
 	if (rdp->dynticks_nesting != 1) {
+		// RCU will still be watching, so just do accounting and leave.
 		rdp->dynticks_nesting--;
 		return;
 	}
@@ -596,7 +601,9 @@ static void rcu_eqs_enter(bool user)
 	rcu_prepare_for_idle();
 	rcu_preempt_deferred_qs(current);
 	WRITE_ONCE(rdp->dynticks_nesting, 0); /* Avoid irq-access tearing. */
+	// RCU is watching here ...
 	rcu_dynticks_eqs_enter();
+	// ... but is no longer watching here.
 	rcu_dynticks_task_enter();
 }
 
@@ -676,7 +683,9 @@ static __always_inline void rcu_nmi_exit_common(bool irq)
 	if (irq)
 		rcu_prepare_for_idle();
 
+	// RCU is watching here ...
 	rcu_dynticks_eqs_enter();
+	// ... but is no longer watching here.
 
 	if (irq)
 		rcu_dynticks_task_enter();
@@ -751,11 +760,14 @@ static void rcu_eqs_exit(bool user)
 	oldval = rdp->dynticks_nesting;
 	WARN_ON_ONCE(IS_ENABLED(CONFIG_RCU_EQS_DEBUG) && oldval < 0);
 	if (oldval) {
+		// RCU was already watching, so just do accounting and leave.
 		rdp->dynticks_nesting++;
 		return;
 	}
 	rcu_dynticks_task_exit();
+	// RCU is not watching here ...
 	rcu_dynticks_eqs_exit();
+	// ... but is watching here.
 	rcu_cleanup_after_idle();
 	trace_rcu_dyntick(TPS("End"), rdp->dynticks_nesting, 1, atomic_read(&rdp->dynticks));
 	WARN_ON_ONCE(IS_ENABLED(CONFIG_RCU_EQS_DEBUG) && !user && !is_idle_task(current));
@@ -832,7 +844,9 @@ static __always_inline void rcu_nmi_enter_common(bool irq)
 		if (irq)
 			rcu_dynticks_task_exit();
 
+		// RCU is not watching here ...
 		rcu_dynticks_eqs_exit();
+		// ... but is watching here.
 
 		if (irq)
 			rcu_cleanup_after_idle();
@@ -842,9 +856,16 @@ static __always_inline void rcu_nmi_enter_common(bool irq)
 		   rdp->dynticks_nmi_nesting == DYNTICK_IRQ_NONIDLE &&
 		   READ_ONCE(rdp->rcu_urgent_qs) &&
 		   !READ_ONCE(rdp->rcu_forced_tick)) {
+		// We get here only if we had already exited the extended
+		// quiescent state and this was an interrupt (not an NMI).
+		// Therefore, (1) RCU is already watching and (2) The fact
+		// that we are in an interrupt handler and that the rcu_node
+		// lock is an irq-disabled lock prevents self-deadlock.
+		// So we can safely recheck under the lock.
 		raw_spin_lock_rcu_node(rdp->mynode);
-		// Recheck under lock.
 		if (rdp->rcu_urgent_qs && !rdp->rcu_forced_tick) {
+			// A nohz_full CPU is in the kernel and RCU
+			// needs a quiescent state.  Turn on the tick!
 			WRITE_ONCE(rdp->rcu_forced_tick, true);
 			tick_dep_set_cpu(rdp->cpu, TICK_DEP_BIT_RCU);
 		}
