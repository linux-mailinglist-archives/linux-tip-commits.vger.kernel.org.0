Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 071FA3B83B0
	for <lists+linux-tip-commits@lfdr.de>; Wed, 30 Jun 2021 15:48:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235117AbhF3Nud (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 30 Jun 2021 09:50:33 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:33014 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235557AbhF3NuH (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 30 Jun 2021 09:50:07 -0400
Date:   Wed, 30 Jun 2021 13:47:37 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1625060858;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=Wi1n39qA+y9I0IDhMqCmiugPxVsCd+Hp4rUGjDohLfs=;
        b=Uqtyer8SrzOxurrN1uiOU2pURVJWLxrlSYNOCVfavp4XRwSKqAx3y6t62ZEITzPucjYt1E
        BjIta3CAj/c++2HxI1B7n5ywWSwvbMZ+cPsfr88L0rTJJBIpxR7XiXhPKoedbLo/b1xSCF
        m0zJq5tUJak03KViVH595GpDfPF30HDtMKQOiqM/RqOK5NP4ba4UwmLVIdqkJtsWnGMpzf
        n0/gNDXIkGSxvK1XvENvPyV3KQcGrxGjcbLXbIkWUIZZvCYnFTgOiYTRRCHhSH/hDlTkOU
        BCITh73cJydN2/10qgyp2OZ03jyI+4Oz9wCdu9sKPHHo1jmoe2e77pN/T6KRbw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1625060858;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=Wi1n39qA+y9I0IDhMqCmiugPxVsCd+Hp4rUGjDohLfs=;
        b=0StmxO+zBvT+WPuJqrDfWRn+w9CqiLAy0IyVtsYCB2jmNsybaPeqHYPCmdPGauH6KobgUz
        NSPl4RZstWFZY4CA==
From:   "tip-bot2 for Zhouyi Zhou" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] rcu: Improve tree.c comments and add code cleanups
Cc:     Zhouyi Zhou <zhouzhouyi@gmail.com>,
        "Paul E. McKenney" <paulmck@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <162506085751.395.7738881198337510388.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the core/rcu branch of tip:

Commit-ID:     277ffe1b709280856391663c2ca5685a28308fc5
Gitweb:        https://git.kernel.org/tip/277ffe1b709280856391663c2ca5685a28308fc5
Author:        Zhouyi Zhou <zhouzhouyi@gmail.com>
AuthorDate:    Tue, 30 Mar 2021 13:47:42 -07:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Mon, 10 May 2021 16:22:53 -07:00

rcu: Improve tree.c comments and add code cleanups

This commit cleans up some comments and code in kernel/rcu/tree.c.

Signed-off-by: Zhouyi Zhou <zhouzhouyi@gmail.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tree.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index f6543b8..06f3de9 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -202,7 +202,7 @@ EXPORT_SYMBOL_GPL(rcu_get_gp_kthreads_prio);
  * the need for long delays to increase some race probabilities with the
  * need for fast grace periods to increase other race probabilities.
  */
-#define PER_RCU_NODE_PERIOD 3	/* Number of grace periods between delays. */
+#define PER_RCU_NODE_PERIOD 3	/* Number of grace periods between delays for debugging. */
 
 /*
  * Compute the mask of online CPUs for the specified rcu_node structure.
@@ -937,7 +937,7 @@ EXPORT_SYMBOL_GPL(rcu_idle_exit);
  */
 void noinstr rcu_user_exit(void)
 {
-	rcu_eqs_exit(1);
+	rcu_eqs_exit(true);
 }
 
 /**
@@ -1203,7 +1203,7 @@ EXPORT_SYMBOL_GPL(rcu_lockdep_current_cpu_online);
 #endif /* #if defined(CONFIG_PROVE_RCU) && defined(CONFIG_HOTPLUG_CPU) */
 
 /*
- * We are reporting a quiescent state on behalf of some other CPU, so
+ * When trying to report a quiescent state on behalf of some other CPU,
  * it is our responsibility to check for and handle potential overflow
  * of the rcu_node ->gp_seq counter with respect to the rcu_data counters.
  * After all, the CPU might be in deep idle state, and thus executing no
@@ -2607,7 +2607,7 @@ static void rcu_do_batch(struct rcu_data *rdp)
  * state, for example, user mode or idle loop.  It also schedules RCU
  * core processing.  If the current grace period has gone on too long,
  * it will ask the scheduler to manufacture a context switch for the sole
- * purpose of providing a providing the needed quiescent state.
+ * purpose of providing the needed quiescent state.
  */
 void rcu_sched_clock_irq(int user)
 {
@@ -3236,7 +3236,7 @@ put_cached_bnode(struct kfree_rcu_cpu *krcp,
 
 /*
  * This function is invoked in workqueue context after a grace period.
- * It frees all the objects queued on ->bhead_free or ->head_free.
+ * It frees all the objects queued on ->bkvhead_free or ->head_free.
  */
 static void kfree_rcu_work(struct work_struct *work)
 {
@@ -3263,7 +3263,7 @@ static void kfree_rcu_work(struct work_struct *work)
 	krwp->head_free = NULL;
 	raw_spin_unlock_irqrestore(&krcp->lock, flags);
 
-	// Handle two first channels.
+	// Handle the first two channels.
 	for (i = 0; i < FREE_N_CHANNELS; i++) {
 		for (; bkvhead[i]; bkvhead[i] = bnext) {
 			bnext = bkvhead[i]->next;
@@ -3530,11 +3530,11 @@ add_ptr_to_bulk_krc_lock(struct kfree_rcu_cpu **krcp,
 }
 
 /*
- * Queue a request for lazy invocation of appropriate free routine after a
- * grace period. Please note there are three paths are maintained, two are the
- * main ones that use array of pointers interface and third one is emergency
- * one, that is used only when the main path can not be maintained temporary,
- * due to memory pressure.
+ * Queue a request for lazy invocation of the appropriate free routine
+ * after a grace period.  Please note that three paths are maintained,
+ * two for the common case using arrays of pointers and a third one that
+ * is used only when the main paths cannot be used, for example, due to
+ * memory pressure.
  *
  * Each kvfree_call_rcu() request is added to a batch. The batch will be drained
  * every KFREE_DRAIN_JIFFIES number of jiffies. All the objects in the batch will
@@ -4708,7 +4708,7 @@ void __init rcu_init(void)
 		rcutree_online_cpu(cpu);
 	}
 
-	/* Create workqueue for expedited GPs and for Tree SRCU. */
+	/* Create workqueue for Tree SRCU and for expedited GPs. */
 	rcu_gp_wq = alloc_workqueue("rcu_gp", WQ_MEM_RECLAIM, 0);
 	WARN_ON(!rcu_gp_wq);
 	rcu_par_gp_wq = alloc_workqueue("rcu_par_gp", WQ_MEM_RECLAIM, 0);
