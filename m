Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07DF82D902E
	for <lists+linux-tip-commits@lfdr.de>; Sun, 13 Dec 2020 20:30:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727909AbgLMT35 (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Sun, 13 Dec 2020 14:29:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726799AbgLMTBm (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Sun, 13 Dec 2020 14:01:42 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30F0BC0613D6;
        Sun, 13 Dec 2020 11:01:02 -0800 (PST)
Date:   Sun, 13 Dec 2020 19:01:00 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1607886060;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=JUSEeczplsDqGMKH0bJsbuS8ltO0bnOhRwdcYtDd9/s=;
        b=yzARfwVgyEX7eW7/98B4aFpSsE7TOLjIeS9lGYfoWcp2JD0QS93M/9j14/3JjokOMnKpWu
        KBKEIl6FDQXdvdCmb8nK2LBy/N2k4VVjYUapGMFjfdqE8p6y/XT8HnrO9t+e7Aq4ygZoi8
        L/3aLivAo2DnfXJsXXqLUPWYGTk8jOl7/QqgttG8edoy3HZaw+qBLObyYgFj8g/Qcq/bac
        iLqwHSfDqySNoLl6UknaNkQc7uonWFFZXly+Fmeg+TkxVkIjGkVbfYhwDugFlTZeKFq3Gr
        BIdRwqZF11B1ef9OhlZBQMm/l8pvha5qfZCCvjCz7mGsfIIDT8oJFq7HSoxqoA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1607886060;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=JUSEeczplsDqGMKH0bJsbuS8ltO0bnOhRwdcYtDd9/s=;
        b=G72YxHI7bR9Uhtl7mgXsgLHKMLk4fdKTk0DLzxoFvnE/ixkqFDPG0iIYBkzsI2Az9NM9r4
        KJED8IAVtqvVzFCA==
From:   "tip-bot2 for Paul E. McKenney" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] rcu: Prevent lockdep-RCU splats on lock acquisition/release
Cc:     "Paul E. McKenney" <paulmck@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <160788606018.3364.6771823343122064966.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the core/rcu branch of tip:

Commit-ID:     4d60b475f858ebdb06c1339f01a890f287b5e587
Gitweb:        https://git.kernel.org/tip/4d60b475f858ebdb06c1339f01a890f287b5e587
Author:        Paul E. McKenney <paulmck@kernel.org>
AuthorDate:    Tue, 13 Oct 2020 12:39:23 -07:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Thu, 19 Nov 2020 19:37:17 -08:00

rcu: Prevent lockdep-RCU splats on lock acquisition/release

The rcu_cpu_starting() and rcu_report_dead() functions transition the
current CPU between online and offline state from an RCU perspective.
Unfortunately, this means that the rcu_cpu_starting() function's lock
acquisition and the rcu_report_dead() function's lock releases happen
while the CPU is offline from an RCU perspective, which can result
in lockdep-RCU splats about using RCU from an offline CPU.  And this
situation can also result in too-short grace periods, especially in
guest OSes that are subject to vCPU preemption.

This commit therefore uses sequence-count-like synchronization to forgive
use of RCU while RCU thinks a CPU is offline across the full extent of
the rcu_cpu_starting() and rcu_report_dead() function's lock acquisitions
and releases.

One approach would have been to use the actual sequence-count primitives
provided by the Linux kernel.  Unfortunately, the resulting code looks
completely broken and wrong, and is likely to result in patches that
break RCU in an attempt to address this appearance of broken wrongness.
Plus there is no net savings in lines of code, given the additional
explicit memory barriers required.

Therefore, this sequence count is instead implemented by a new ->ofl_seq
field in the rcu_node structure.  If this counter's value is an odd
number, RCU forgives RCU read-side critical sections on other CPUs covered
by the same rcu_node structure, even if those CPUs are offline from
an RCU perspective.  In addition, if a given leaf rcu_node structure's
->ofl_seq counter value is an odd number, rcu_gp_init() delays starting
the grace period until that counter value changes.

[ paulmck: Apply Peter Zijlstra feedback. ]
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tree.c | 21 ++++++++++++++++++++-
 kernel/rcu/tree.h |  1 +
 2 files changed, 21 insertions(+), 1 deletion(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 50d90ee..3438534 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -1152,7 +1152,7 @@ bool rcu_lockdep_current_cpu_online(void)
 	preempt_disable_notrace();
 	rdp = this_cpu_ptr(&rcu_data);
 	rnp = rdp->mynode;
-	if (rdp->grpmask & rcu_rnp_online_cpus(rnp))
+	if (rdp->grpmask & rcu_rnp_online_cpus(rnp) || READ_ONCE(rnp->ofl_seq) & 0x1)
 		ret = true;
 	preempt_enable_notrace();
 	return ret;
@@ -1717,6 +1717,7 @@ static void rcu_strict_gp_boundary(void *unused)
  */
 static bool rcu_gp_init(void)
 {
+	unsigned long firstseq;
 	unsigned long flags;
 	unsigned long oldmask;
 	unsigned long mask;
@@ -1760,6 +1761,12 @@ static bool rcu_gp_init(void)
 	 */
 	rcu_state.gp_state = RCU_GP_ONOFF;
 	rcu_for_each_leaf_node(rnp) {
+		smp_mb(); // Pair with barriers used when updating ->ofl_seq to odd values.
+		firstseq = READ_ONCE(rnp->ofl_seq);
+		if (firstseq & 0x1)
+			while (firstseq == READ_ONCE(rnp->ofl_seq))
+				schedule_timeout_idle(1);  // Can't wake unless RCU is watching.
+		smp_mb(); // Pair with barriers used when updating ->ofl_seq to even values.
 		raw_spin_lock(&rcu_state.ofl_lock);
 		raw_spin_lock_irq_rcu_node(rnp);
 		if (rnp->qsmaskinit == rnp->qsmaskinitnext &&
@@ -4069,6 +4076,9 @@ void rcu_cpu_starting(unsigned int cpu)
 
 	rnp = rdp->mynode;
 	mask = rdp->grpmask;
+	WRITE_ONCE(rnp->ofl_seq, rnp->ofl_seq + 1);
+	WARN_ON_ONCE(!(rnp->ofl_seq & 0x1));
+	smp_mb(); // Pair with rcu_gp_cleanup()'s ->ofl_seq barrier().
 	raw_spin_lock_irqsave_rcu_node(rnp, flags);
 	WRITE_ONCE(rnp->qsmaskinitnext, rnp->qsmaskinitnext | mask);
 	newcpu = !(rnp->expmaskinitnext & mask);
@@ -4088,6 +4098,9 @@ void rcu_cpu_starting(unsigned int cpu)
 	} else {
 		raw_spin_unlock_irqrestore_rcu_node(rnp, flags);
 	}
+	smp_mb(); // Pair with rcu_gp_cleanup()'s ->ofl_seq barrier().
+	WRITE_ONCE(rnp->ofl_seq, rnp->ofl_seq + 1);
+	WARN_ON_ONCE(rnp->ofl_seq & 0x1);
 	smp_mb(); /* Ensure RCU read-side usage follows above initialization. */
 }
 
@@ -4115,6 +4128,9 @@ void rcu_report_dead(unsigned int cpu)
 
 	/* Remove outgoing CPU from mask in the leaf rcu_node structure. */
 	mask = rdp->grpmask;
+	WRITE_ONCE(rnp->ofl_seq, rnp->ofl_seq + 1);
+	WARN_ON_ONCE(!(rnp->ofl_seq & 0x1));
+	smp_mb(); // Pair with rcu_gp_cleanup()'s ->ofl_seq barrier().
 	raw_spin_lock(&rcu_state.ofl_lock);
 	raw_spin_lock_irqsave_rcu_node(rnp, flags); /* Enforce GP memory-order guarantee. */
 	rdp->rcu_ofl_gp_seq = READ_ONCE(rcu_state.gp_seq);
@@ -4127,6 +4143,9 @@ void rcu_report_dead(unsigned int cpu)
 	WRITE_ONCE(rnp->qsmaskinitnext, rnp->qsmaskinitnext & ~mask);
 	raw_spin_unlock_irqrestore_rcu_node(rnp, flags);
 	raw_spin_unlock(&rcu_state.ofl_lock);
+	smp_mb(); // Pair with rcu_gp_cleanup()'s ->ofl_seq barrier().
+	WRITE_ONCE(rnp->ofl_seq, rnp->ofl_seq + 1);
+	WARN_ON_ONCE(rnp->ofl_seq & 0x1);
 
 	rdp->cpu_started = false;
 }
diff --git a/kernel/rcu/tree.h b/kernel/rcu/tree.h
index 805c9eb..7708ed1 100644
--- a/kernel/rcu/tree.h
+++ b/kernel/rcu/tree.h
@@ -56,6 +56,7 @@ struct rcu_node {
 				/*  Initialized from ->qsmaskinitnext at the */
 				/*  beginning of each grace period. */
 	unsigned long qsmaskinitnext;
+	unsigned long ofl_seq;	/* CPU-hotplug operation sequence count. */
 				/* Online CPUs for next grace period. */
 	unsigned long expmask;	/* CPUs or groups that need to check in */
 				/*  to allow the current expedited GP */
