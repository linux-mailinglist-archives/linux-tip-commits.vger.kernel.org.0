Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6853C2882A9
	for <lists+linux-tip-commits@lfdr.de>; Fri,  9 Oct 2020 08:39:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731729AbgJIGik (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 9 Oct 2020 02:38:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731898AbgJIGfV (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 9 Oct 2020 02:35:21 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD8CCC0613D7;
        Thu,  8 Oct 2020 23:35:20 -0700 (PDT)
Date:   Fri, 09 Oct 2020 06:35:18 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1602225319;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=X5kdZu7n3+f8CFrEeKbWTrypmdfa66TquDNQG2yHPU8=;
        b=BU3XfeksZabsQditYRbN3wZ0L9d5jxjbhE7kvkn7TrrBSLX3wNIUssqfqp4iDpsi10oRRR
        Czp2d2tIJiPMZBSrC+AIloxcUa0l2W5FPu/aUJYEg9ejIp6V03xeFdAkU3mf3xdjfeDyIN
        zo0sgVs8HVJSc5QJZit0ASf2uywyENQ/tzUKKQopWiCZfSqVfQnZKOGEBvuOvq51uk8j2s
        j0wkHvhLPLfW/zZpvk4MWn5P7t2JO3VvKfRsec6OTzdDA41pGb9Ub2A56EzPfbL0xaNpcW
        Ct1sodFKrH8nWxSrwnkAe8Q25mJqCpLxGyll4v0M9kK6hiFxG/4+ArMHPLIFsg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1602225319;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=X5kdZu7n3+f8CFrEeKbWTrypmdfa66TquDNQG2yHPU8=;
        b=Eam3/SIS3Pe4DbxM5/9JPaL3kwOcKHwTNFZKyUPauSpFQQjd1LgNNhyJgJK7PhCk7AtsxV
        19XenxNihewL5ZDQ==
From:   "tip-bot2 for Paul E. McKenney" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] rcu: Execute RCU reader shortly after rcu_core for strict GPs
Cc:     "Paul E. McKenney" <paulmck@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <160222531842.7002.5174998361216437833.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the core/rcu branch of tip:

Commit-ID:     a657f2617010ae237db5693f875968c28e8f732f
Gitweb:        https://git.kernel.org/tip/a657f2617010ae237db5693f875968c28e8f732f
Author:        Paul E. McKenney <paulmck@kernel.org>
AuthorDate:    Sat, 08 Aug 2020 07:56:31 -07:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Mon, 24 Aug 2020 18:40:27 -07:00

rcu: Execute RCU reader shortly after rcu_core for strict GPs

A kernel built with CONFIG_RCU_STRICT_GRACE_PERIOD=y needs a quiescent
state to appear very shortly after a CPU has noticed a new grace period.
Placing an RCU reader immediately after this point is ineffective because
this normally happens in softirq context, which acts as a big RCU reader.
This commit therefore introduces a new per-CPU work_struct, which is
used at the end of rcu_core() processing to schedule an RCU read-side
critical section from within a clean environment.

Reported-by Jann Horn <jannh@google.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tree.c | 13 +++++++++++++
 kernel/rcu/tree.h |  1 +
 2 files changed, 14 insertions(+)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 4bbedfc..31995b3 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -2646,6 +2646,14 @@ void rcu_force_quiescent_state(void)
 }
 EXPORT_SYMBOL_GPL(rcu_force_quiescent_state);
 
+// Workqueue handler for an RCU reader for kernels enforcing struct RCU
+// grace periods.
+static void strict_work_handler(struct work_struct *work)
+{
+	rcu_read_lock();
+	rcu_read_unlock();
+}
+
 /* Perform RCU core processing work for the current CPU.  */
 static __latent_entropy void rcu_core(void)
 {
@@ -2690,6 +2698,10 @@ static __latent_entropy void rcu_core(void)
 	/* Do any needed deferred wakeups of rcuo kthreads. */
 	do_nocb_deferred_wakeup(rdp);
 	trace_rcu_utilization(TPS("End RCU core"));
+
+	// If strict GPs, schedule an RCU reader in a clean environment.
+	if (IS_ENABLED(CONFIG_RCU_STRICT_GRACE_PERIOD))
+		queue_work_on(rdp->cpu, rcu_gp_wq, &rdp->strict_work);
 }
 
 static void rcu_core_si(struct softirq_action *h)
@@ -3887,6 +3899,7 @@ rcu_boot_init_percpu_data(int cpu)
 
 	/* Set up local state, ensuring consistent view of global state. */
 	rdp->grpmask = leaf_node_cpu_bit(rdp->mynode, cpu);
+	INIT_WORK(&rdp->strict_work, strict_work_handler);
 	WARN_ON_ONCE(rdp->dynticks_nesting != 1);
 	WARN_ON_ONCE(rcu_dynticks_in_eqs(rcu_dynticks_snap(rdp)));
 	rdp->rcu_ofl_gp_seq = rcu_state.gp_seq;
diff --git a/kernel/rcu/tree.h b/kernel/rcu/tree.h
index c96ae35..5831ac0 100644
--- a/kernel/rcu/tree.h
+++ b/kernel/rcu/tree.h
@@ -164,6 +164,7 @@ struct rcu_data {
 					/* period it is aware of. */
 	struct irq_work defer_qs_iw;	/* Obtain later scheduler attention. */
 	bool defer_qs_iw_pending;	/* Scheduler attention pending? */
+	struct work_struct strict_work;	/* Schedule readers for strict GPs. */
 
 	/* 2) batch handling */
 	struct rcu_segcblist cblist;	/* Segmented callback list, with */
