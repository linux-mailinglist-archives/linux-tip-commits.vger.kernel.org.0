Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E56DE35B4F6
	for <lists+linux-tip-commits@lfdr.de>; Sun, 11 Apr 2021 15:48:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235945AbhDKNoa (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Sun, 11 Apr 2021 09:44:30 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:33476 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235789AbhDKNoI (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Sun, 11 Apr 2021 09:44:08 -0400
Date:   Sun, 11 Apr 2021 13:43:35 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1618148616;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=2vYqOH2mJ3Zmu2DX/Dyn773QAKrauH6M2ZhX4Uyza8A=;
        b=v7vQimwO2UZ2ZhUAB0fYFItubQ43qWN4+gIrM4L81tVO4eyWH5bNTp93ZAfb/N1v1Y8mVW
        1CxVlQ/Ym2q6PSFx5hEcDgVBl48Piw7RjC//8qZEgjts/veV4CqozFy4ezmUNo5JXSNGHg
        cmPsmY+z0X8ZWvm98oH6rV1CzbTa9ZrNrHVKSok2qcgaHIbpIVtJdcGcSWqBJd2MulnoHF
        BLl4YtVVksImeuvW1mJxMz+ShrKaetj1mo/U8XqDT6qW5O3gki6wUIiW8WJkFIDClGAbTy
        3vgSzLUEuFfewDavMPwqBMbLyFIolQqGZTHn2GmoQpinDJJpqdGQfRbTRU8kPg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1618148616;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=2vYqOH2mJ3Zmu2DX/Dyn773QAKrauH6M2ZhX4Uyza8A=;
        b=cvQ5Pum/9QI91Enc2Xdp67j2DlsxNaiRCYCPgik74BzZpJK1SW7iCf+yjn1C75s38/Vqz1
        ZujSSHvNMhLVCZAg==
From:   "tip-bot2 for Paul E. McKenney" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] rcu: Expedite deboost in case of deferred quiescent state
Cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Scott Wood <swood@redhat.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Paul E. McKenney" <paulmck@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <161814861597.29796.5026063196269367003.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the core/rcu branch of tip:

Commit-ID:     39bbfc62cc90d33f8f5f940464d08075e0275f8a
Gitweb:        https://git.kernel.org/tip/39bbfc62cc90d33f8f5f940464d08075e0275f8a
Author:        Paul E. McKenney <paulmck@kernel.org>
AuthorDate:    Thu, 14 Jan 2021 10:39:31 -08:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Mon, 08 Mar 2021 14:21:40 -08:00

rcu: Expedite deboost in case of deferred quiescent state

Historically, a task that has been subjected to RCU priority boosting is
deboosted at rcu_read_unlock() time.  However, with the advent of deferred
quiescent states, if the outermost rcu_read_unlock() was invoked with
either bottom halves, interrupts, or preemption disabled, the deboosting
will be delayed for some time.  During this time, a low-priority process
might be incorrectly running at a high real-time priority level.

Fortunately, rcu_read_unlock_special() already provides mechanisms for
forcing a minimal deferral of quiescent states, at least for kernels
built with CONFIG_IRQ_WORK=y.  These mechanisms are currently used
when expedited grace periods are pending that might be blocked by the
current task.  This commit therefore causes those mechanisms to also be
used in cases where the current task has been or might soon be subjected
to RCU priority boosting.  Note that this applies to all kernels built
with CONFIG_RCU_BOOST=y, regardless of whether or not they are also
built with CONFIG_PREEMPT_RT=y.

This approach assumes that kernels build for use with aggressive real-time
applications are built with CONFIG_IRQ_WORK=y.  It is likely to be far
simpler to enable CONFIG_IRQ_WORK=y than to implement a fast-deboosting
scheme that works correctly in its absence.

While in the area, alphabetize the rcu_preempt_deferred_qs_handler()
function's local variables.

Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Scott Wood <swood@redhat.com>
Cc: Lai Jiangshan <jiangshanlai@gmail.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tree_plugin.h | 26 ++++++++++++++------------
 1 file changed, 14 insertions(+), 12 deletions(-)

diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
index 2d60377..e17cb23 100644
--- a/kernel/rcu/tree_plugin.h
+++ b/kernel/rcu/tree_plugin.h
@@ -598,9 +598,9 @@ static void rcu_preempt_deferred_qs_handler(struct irq_work *iwp)
 static void rcu_read_unlock_special(struct task_struct *t)
 {
 	unsigned long flags;
+	bool irqs_were_disabled;
 	bool preempt_bh_were_disabled =
 			!!(preempt_count() & (PREEMPT_MASK | SOFTIRQ_MASK));
-	bool irqs_were_disabled;
 
 	/* NMI handlers cannot block and cannot safely manipulate state. */
 	if (in_nmi())
@@ -609,30 +609,32 @@ static void rcu_read_unlock_special(struct task_struct *t)
 	local_irq_save(flags);
 	irqs_were_disabled = irqs_disabled_flags(flags);
 	if (preempt_bh_were_disabled || irqs_were_disabled) {
-		bool exp;
+		bool expboost; // Expedited GP in flight or possible boosting.
 		struct rcu_data *rdp = this_cpu_ptr(&rcu_data);
 		struct rcu_node *rnp = rdp->mynode;
 
-		exp = (t->rcu_blocked_node &&
-		       READ_ONCE(t->rcu_blocked_node->exp_tasks)) ||
-		      (rdp->grpmask & READ_ONCE(rnp->expmask));
+		expboost = (t->rcu_blocked_node && READ_ONCE(t->rcu_blocked_node->exp_tasks)) ||
+			   (rdp->grpmask & READ_ONCE(rnp->expmask)) ||
+			   (IS_ENABLED(CONFIG_RCU_BOOST) && irqs_were_disabled &&
+			    t->rcu_blocked_node);
 		// Need to defer quiescent state until everything is enabled.
-		if (use_softirq && (in_irq() || (exp && !irqs_were_disabled))) {
+		if (use_softirq && (in_irq() || (expboost && !irqs_were_disabled))) {
 			// Using softirq, safe to awaken, and either the
-			// wakeup is free or there is an expedited GP.
+			// wakeup is free or there is either an expedited
+			// GP in flight or a potential need to deboost.
 			raise_softirq_irqoff(RCU_SOFTIRQ);
 		} else {
 			// Enabling BH or preempt does reschedule, so...
-			// Also if no expediting, slow is OK.
-			// Plus nohz_full CPUs eventually get tick enabled.
+			// Also if no expediting and no possible deboosting,
+			// slow is OK.  Plus nohz_full CPUs eventually get
+			// tick enabled.
 			set_tsk_need_resched(current);
 			set_preempt_need_resched();
 			if (IS_ENABLED(CONFIG_IRQ_WORK) && irqs_were_disabled &&
-			    !rdp->defer_qs_iw_pending && exp && cpu_online(rdp->cpu)) {
+			    expboost && !rdp->defer_qs_iw_pending && cpu_online(rdp->cpu)) {
 				// Get scheduler to re-evaluate and call hooks.
 				// If !IRQ_WORK, FQS scan will eventually IPI.
-				init_irq_work(&rdp->defer_qs_iw,
-					      rcu_preempt_deferred_qs_handler);
+				init_irq_work(&rdp->defer_qs_iw, rcu_preempt_deferred_qs_handler);
 				rdp->defer_qs_iw_pending = true;
 				irq_work_queue_on(&rdp->defer_qs_iw, rdp->cpu);
 			}
