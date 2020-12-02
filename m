Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 469392CC689
	for <lists+linux-tip-commits@lfdr.de>; Wed,  2 Dec 2020 20:24:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389461AbgLBTXz (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 2 Dec 2020 14:23:55 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:35846 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731038AbgLBTXz (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 2 Dec 2020 14:23:55 -0500
Date:   Wed, 02 Dec 2020 19:23:11 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1606936992;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6qAd6D9egUQRd8Lz4aJAzjmTqITQ+EgcgOrUAVOoMX0=;
        b=SjAlO3ITGQjeMzEwbj1Pax6BV1AiKa8GqGuleItuzPo28qihEm/BNGfR2ou7VTTU17SnD7
        KIyEVhJTwWy4n9UeJAP1VAzhsktC04S06bnxOrTWe8v43XWvPCU2BMfbOFTf6wnnA9JIRM
        IZvzlCJu+F8+JPSgdzxlzI3RRjWuywzcX7rFVidHqNWT81v0ggMHZEpQWGEpI7/s8fH09V
        kB2gsbcPNLhVDGG1XXlGBdH9HvhWkIZCJmJXCuLZrIxK4BP8JiXOc/CA6uUP1q/H+EKc3l
        48tn44NzDC94XxKyCkoljSC1zdKzkhzvQGuRdQhSKjnwk1IpfxxWJrJorZYp2w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1606936992;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6qAd6D9egUQRd8Lz4aJAzjmTqITQ+EgcgOrUAVOoMX0=;
        b=kzUdUFIZ3AiBH7++5tmyb1s+8Hk3EaXBu+o2xLcYLtZJvq6yw21H34TaI9TRKqBS3dTvhd
        +Qx+UxFEBAH1FXDQ==
From:   "tip-bot2 for Frederic Weisbecker" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] irqtime: Move irqtime entry accounting after irq
 offset incrementation
Cc:     Frederic Weisbecker <frederic@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org, maz@kernel.org
In-Reply-To: <20201202115732.27827-5-frederic@kernel.org>
References: <20201202115732.27827-5-frederic@kernel.org>
MIME-Version: 1.0
Message-ID: <160693699114.3364.3770140200988474994.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     d3759e7184f8f6187e62f8c4e7dcb1f6c47c075a
Gitweb:        https://git.kernel.org/tip/d3759e7184f8f6187e62f8c4e7dcb1f6c47c075a
Author:        Frederic Weisbecker <frederic@kernel.org>
AuthorDate:    Wed, 02 Dec 2020 12:57:31 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 02 Dec 2020 20:20:05 +01:00

irqtime: Move irqtime entry accounting after irq offset incrementation

IRQ time entry is currently accounted before HARDIRQ_OFFSET or
SOFTIRQ_OFFSET are incremented. This is convenient to decide to which
index the cputime to account is dispatched.

Unfortunately it prevents tick_irq_enter() from being called under
HARDIRQ_OFFSET because tick_irq_enter() has to be called before the IRQ
entry accounting due to the necessary clock catch up. As a result we
don't benefit from appropriate lockdep coverage on tick_irq_enter().

To prepare for fixing this, move the IRQ entry cputime accounting after
the preempt offset is incremented. This requires the cputime dispatch
code to handle the extra offset.

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/r/20201202115732.27827-5-frederic@kernel.org

---
 include/linux/hardirq.h |  4 ++--
 include/linux/vtime.h   | 34 ++++++++++++++++++++++++----------
 kernel/sched/cputime.c  | 18 +++++++++++-------
 kernel/softirq.c        |  6 +++---
 4 files changed, 40 insertions(+), 22 deletions(-)

diff --git a/include/linux/hardirq.h b/include/linux/hardirq.h
index 754f67a..7c9d6a2 100644
--- a/include/linux/hardirq.h
+++ b/include/linux/hardirq.h
@@ -32,9 +32,9 @@ static __always_inline void rcu_irq_enter_check_tick(void)
  */
 #define __irq_enter()					\
 	do {						\
-		account_irq_enter_time(current);	\
 		preempt_count_add(HARDIRQ_OFFSET);	\
 		lockdep_hardirq_enter();		\
+		account_hardirq_enter(current);		\
 	} while (0)
 
 /*
@@ -62,8 +62,8 @@ void irq_enter_rcu(void);
  */
 #define __irq_exit()					\
 	do {						\
+		account_hardirq_exit(current);		\
 		lockdep_hardirq_exit();			\
-		account_irq_exit_time(current);		\
 		preempt_count_sub(HARDIRQ_OFFSET);	\
 	} while (0)
 
diff --git a/include/linux/vtime.h b/include/linux/vtime.h
index 6c98674..041d652 100644
--- a/include/linux/vtime.h
+++ b/include/linux/vtime.h
@@ -83,32 +83,46 @@ static inline void vtime_init_idle(struct task_struct *tsk, int cpu) { }
 #endif
 
 #ifdef CONFIG_VIRT_CPU_ACCOUNTING_NATIVE
-extern void vtime_account_irq(struct task_struct *tsk);
+extern void vtime_account_irq(struct task_struct *tsk, unsigned int offset);
 extern void vtime_account_softirq(struct task_struct *tsk);
 extern void vtime_account_hardirq(struct task_struct *tsk);
 extern void vtime_flush(struct task_struct *tsk);
 #else /* !CONFIG_VIRT_CPU_ACCOUNTING_NATIVE */
-static inline void vtime_account_irq(struct task_struct *tsk) { }
+static inline void vtime_account_irq(struct task_struct *tsk, unsigned int offset) { }
+static inline void vtime_account_softirq(struct task_struct *tsk) { }
+static inline void vtime_account_hardirq(struct task_struct *tsk) { }
 static inline void vtime_flush(struct task_struct *tsk) { }
 #endif
 
 
 #ifdef CONFIG_IRQ_TIME_ACCOUNTING
-extern void irqtime_account_irq(struct task_struct *tsk);
+extern void irqtime_account_irq(struct task_struct *tsk, unsigned int offset);
 #else
-static inline void irqtime_account_irq(struct task_struct *tsk) { }
+static inline void irqtime_account_irq(struct task_struct *tsk, unsigned int offset) { }
 #endif
 
-static inline void account_irq_enter_time(struct task_struct *tsk)
+static inline void account_softirq_enter(struct task_struct *tsk)
 {
-	vtime_account_irq(tsk);
-	irqtime_account_irq(tsk);
+	vtime_account_irq(tsk, SOFTIRQ_OFFSET);
+	irqtime_account_irq(tsk, SOFTIRQ_OFFSET);
 }
 
-static inline void account_irq_exit_time(struct task_struct *tsk)
+static inline void account_softirq_exit(struct task_struct *tsk)
 {
-	vtime_account_irq(tsk);
-	irqtime_account_irq(tsk);
+	vtime_account_softirq(tsk);
+	irqtime_account_irq(tsk, 0);
+}
+
+static inline void account_hardirq_enter(struct task_struct *tsk)
+{
+	vtime_account_irq(tsk, HARDIRQ_OFFSET);
+	irqtime_account_irq(tsk, HARDIRQ_OFFSET);
+}
+
+static inline void account_hardirq_exit(struct task_struct *tsk)
+{
+	vtime_account_hardirq(tsk);
+	irqtime_account_irq(tsk, 0);
 }
 
 #endif /* _LINUX_KERNEL_VTIME_H */
diff --git a/kernel/sched/cputime.c b/kernel/sched/cputime.c
index 02163d4..5f61165 100644
--- a/kernel/sched/cputime.c
+++ b/kernel/sched/cputime.c
@@ -44,12 +44,13 @@ static void irqtime_account_delta(struct irqtime *irqtime, u64 delta,
 }
 
 /*
- * Called before incrementing preempt_count on {soft,}irq_enter
+ * Called after incrementing preempt_count on {soft,}irq_enter
  * and before decrementing preempt_count on {soft,}irq_exit.
  */
-void irqtime_account_irq(struct task_struct *curr)
+void irqtime_account_irq(struct task_struct *curr, unsigned int offset)
 {
 	struct irqtime *irqtime = this_cpu_ptr(&cpu_irqtime);
+	unsigned int pc;
 	s64 delta;
 	int cpu;
 
@@ -59,6 +60,7 @@ void irqtime_account_irq(struct task_struct *curr)
 	cpu = smp_processor_id();
 	delta = sched_clock_cpu(cpu) - irqtime->irq_start_time;
 	irqtime->irq_start_time += delta;
+	pc = preempt_count() - offset;
 
 	/*
 	 * We do not account for softirq time from ksoftirqd here.
@@ -66,9 +68,9 @@ void irqtime_account_irq(struct task_struct *curr)
 	 * in that case, so as not to confuse scheduler with a special task
 	 * that do not consume any time, but still wants to run.
 	 */
-	if (hardirq_count())
+	if (pc & HARDIRQ_MASK)
 		irqtime_account_delta(irqtime, delta, CPUTIME_IRQ);
-	else if (in_serving_softirq() && curr != this_cpu_ksoftirqd())
+	else if ((pc & SOFTIRQ_OFFSET) && curr != this_cpu_ksoftirqd())
 		irqtime_account_delta(irqtime, delta, CPUTIME_SOFTIRQ);
 }
 
@@ -417,11 +419,13 @@ void vtime_task_switch(struct task_struct *prev)
 }
 # endif
 
-void vtime_account_irq(struct task_struct *tsk)
+void vtime_account_irq(struct task_struct *tsk, unsigned int offset)
 {
-	if (hardirq_count()) {
+	unsigned int pc = preempt_count() - offset;
+
+	if (pc & HARDIRQ_OFFSET) {
 		vtime_account_hardirq(tsk);
-	} else if (in_serving_softirq()) {
+	} else if (pc & SOFTIRQ_OFFSET) {
 		vtime_account_softirq(tsk);
 	} else if (!IS_ENABLED(CONFIG_HAVE_VIRT_CPU_ACCOUNTING_IDLE) &&
 		   is_idle_task(tsk)) {
diff --git a/kernel/softirq.c b/kernel/softirq.c
index 617009c..b8f42b3 100644
--- a/kernel/softirq.c
+++ b/kernel/softirq.c
@@ -315,10 +315,10 @@ asmlinkage __visible void __softirq_entry __do_softirq(void)
 	current->flags &= ~PF_MEMALLOC;
 
 	pending = local_softirq_pending();
-	account_irq_enter_time(current);
 
 	__local_bh_disable_ip(_RET_IP_, SOFTIRQ_OFFSET);
 	in_hardirq = lockdep_softirq_start();
+	account_softirq_enter(current);
 
 restart:
 	/* Reset the pending bitmask before enabling irqs */
@@ -365,8 +365,8 @@ restart:
 		wakeup_softirqd();
 	}
 
+	account_softirq_exit(current);
 	lockdep_softirq_end(in_hardirq);
-	account_irq_exit_time(current);
 	__local_bh_enable(SOFTIRQ_OFFSET);
 	WARN_ON_ONCE(in_interrupt());
 	current_restore_flags(old_flags, PF_MEMALLOC);
@@ -418,7 +418,7 @@ static inline void __irq_exit_rcu(void)
 #else
 	lockdep_assert_irqs_disabled();
 #endif
-	account_irq_exit_time(current);
+	account_hardirq_exit(current);
 	preempt_count_sub(HARDIRQ_OFFSET);
 	if (!in_interrupt() && local_softirq_pending())
 		invoke_softirq();
