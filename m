Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BEC96319EEB
	for <lists+linux-tip-commits@lfdr.de>; Fri, 12 Feb 2021 13:47:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230448AbhBLMna (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 12 Feb 2021 07:43:30 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:45294 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231391AbhBLMlL (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 12 Feb 2021 07:41:11 -0500
Date:   Fri, 12 Feb 2021 12:37:24 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1613133444;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=0uWQouaHdTNr4Rz4dnXIsHn8uSYGN60tJaRAyuK/TNs=;
        b=ksdgNN9GUgBavjCmfrfeSbX0SUPjl6BP4p+gMx+nR5Avl2NF0+mnUVUSjYDdQSsXa9DqsR
        V0tkXaLSbiYM+/B7CJyNvk8RFzuMKs6s5iXz1bn58j9dxRyg97PNQlyA2oP4gDLn3F83ck
        dwUzoYF0xcHKs2ltxTK9qe/kauKpX5OXL91Afp/PkhjZA/XDKKFom03OhyiBAqSaKaANT1
        nVam9a9i8ZOYg+ARCASpKqa9qY1B5dA5cc/w14d70e0oe8SqW5lwyR8Q0Il9C26iSmdj33
        7dLW5+EsAZY7JprgMHyrNHER0aeySlWVuPvfI8yUCyjSY/sJTe7IeO5HLYXZYw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1613133444;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=0uWQouaHdTNr4Rz4dnXIsHn8uSYGN60tJaRAyuK/TNs=;
        b=voYFe9huZm8QgWWwePHKnYf2owxtrlp5in3xhvffp1/SvVHvd+BRHGuWa5fdp8bRoUD6Wv
        /HW5ggpNMySCAKCA==
From:   "tip-bot2 for Paul E. McKenney" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] rcu: Add lockdep_assert_irqs_disabled() to
 rcu_sched_clock_irq() and callees
Cc:     "Paul E. McKenney" <paulmck@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <161313344404.23325.1167006462840978391.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the core/rcu branch of tip:

Commit-ID:     a649d25dcc671a33b9cc3176411920fdc5fbd98e
Gitweb:        https://git.kernel.org/tip/a649d25dcc671a33b9cc3176411920fdc5fbd98e
Author:        Paul E. McKenney <paulmck@kernel.org>
AuthorDate:    Thu, 19 Nov 2020 10:13:06 -08:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Mon, 04 Jan 2021 15:54:49 -08:00

rcu: Add lockdep_assert_irqs_disabled() to rcu_sched_clock_irq() and callees

This commit adds a number of lockdep_assert_irqs_disabled() calls
to rcu_sched_clock_irq() and a number of the functions that it calls.
The point of this is to help track down a situation where lockdep appears
to be insisting that interrupts are enabled within these functions, which
should only ever be invoked from the scheduling-clock interrupt handler.

Link: https://lore.kernel.org/lkml/20201111133813.GA81547@elver.google.com/
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tree.c        | 4 ++++
 kernel/rcu/tree_plugin.h | 1 +
 kernel/rcu/tree_stall.h  | 8 ++++++++
 3 files changed, 13 insertions(+)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index bd04b09..f70634f 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -2553,6 +2553,7 @@ static void rcu_do_batch(struct rcu_data *rdp)
 void rcu_sched_clock_irq(int user)
 {
 	trace_rcu_utilization(TPS("Start scheduler-tick"));
+	lockdep_assert_irqs_disabled();
 	raw_cpu_inc(rcu_data.ticks_this_gp);
 	/* The load-acquire pairs with the store-release setting to true. */
 	if (smp_load_acquire(this_cpu_ptr(&rcu_data.rcu_urgent_qs))) {
@@ -2566,6 +2567,7 @@ void rcu_sched_clock_irq(int user)
 	rcu_flavor_sched_clock_irq(user);
 	if (rcu_pending(user))
 		invoke_rcu_core();
+	lockdep_assert_irqs_disabled();
 
 	trace_rcu_utilization(TPS("End scheduler-tick"));
 }
@@ -3690,6 +3692,8 @@ static int rcu_pending(int user)
 	struct rcu_data *rdp = this_cpu_ptr(&rcu_data);
 	struct rcu_node *rnp = rdp->mynode;
 
+	lockdep_assert_irqs_disabled();
+
 	/* Check for CPU stalls, if enabled. */
 	check_cpu_stall(rdp);
 
diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
index fd8a52e..cb76e70 100644
--- a/kernel/rcu/tree_plugin.h
+++ b/kernel/rcu/tree_plugin.h
@@ -682,6 +682,7 @@ static void rcu_flavor_sched_clock_irq(int user)
 {
 	struct task_struct *t = current;
 
+	lockdep_assert_irqs_disabled();
 	if (user || rcu_is_cpu_rrupt_from_idle()) {
 		rcu_note_voluntary_context_switch(current);
 	}
diff --git a/kernel/rcu/tree_stall.h b/kernel/rcu/tree_stall.h
index ca21d28..4024dcc 100644
--- a/kernel/rcu/tree_stall.h
+++ b/kernel/rcu/tree_stall.h
@@ -260,6 +260,7 @@ static int rcu_print_task_stall(struct rcu_node *rnp, unsigned long flags)
 	struct task_struct *t;
 	struct task_struct *ts[8];
 
+	lockdep_assert_irqs_disabled();
 	if (!rcu_preempt_blocked_readers_cgp(rnp))
 		return 0;
 	pr_err("\tTasks blocked on level-%d rcu_node (CPUs %d-%d):",
@@ -284,6 +285,7 @@ static int rcu_print_task_stall(struct rcu_node *rnp, unsigned long flags)
 				".q"[rscr.rs.b.need_qs],
 				".e"[rscr.rs.b.exp_hint],
 				".l"[rscr.on_blkd_list]);
+		lockdep_assert_irqs_disabled();
 		put_task_struct(t);
 		ndetected++;
 	}
@@ -472,6 +474,8 @@ static void print_other_cpu_stall(unsigned long gp_seq, unsigned long gps)
 	struct rcu_node *rnp;
 	long totqlen = 0;
 
+	lockdep_assert_irqs_disabled();
+
 	/* Kick and suppress, if so configured. */
 	rcu_stall_kick_kthreads();
 	if (rcu_stall_is_suppressed())
@@ -493,6 +497,7 @@ static void print_other_cpu_stall(unsigned long gp_seq, unsigned long gps)
 				}
 		}
 		ndetected += rcu_print_task_stall(rnp, flags); // Releases rnp->lock.
+		lockdep_assert_irqs_disabled();
 	}
 
 	for_each_possible_cpu(cpu)
@@ -538,6 +543,8 @@ static void print_cpu_stall(unsigned long gps)
 	struct rcu_node *rnp = rcu_get_root();
 	long totqlen = 0;
 
+	lockdep_assert_irqs_disabled();
+
 	/* Kick and suppress, if so configured. */
 	rcu_stall_kick_kthreads();
 	if (rcu_stall_is_suppressed())
@@ -592,6 +599,7 @@ static void check_cpu_stall(struct rcu_data *rdp)
 	unsigned long js;
 	struct rcu_node *rnp;
 
+	lockdep_assert_irqs_disabled();
 	if ((rcu_stall_is_suppressed() && !READ_ONCE(rcu_kick_kthreads)) ||
 	    !rcu_gp_in_progress())
 		return;
