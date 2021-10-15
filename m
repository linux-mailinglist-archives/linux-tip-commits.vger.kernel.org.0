Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E1E3942EDF4
	for <lists+linux-tip-commits@lfdr.de>; Fri, 15 Oct 2021 11:45:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237651AbhJOJrE (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 15 Oct 2021 05:47:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237599AbhJOJrD (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 15 Oct 2021 05:47:03 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6524FC061570;
        Fri, 15 Oct 2021 02:44:57 -0700 (PDT)
Date:   Fri, 15 Oct 2021 09:44:55 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1634291096;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=AE5cddRtalHTBZjtODcmF/LNiTwfjgf5Qsr2lUTLNDU=;
        b=NVWO5hvzKT4SsOItKpRPF9g12kiRHCMeP+S5tINy/Ei6IoHmivIif9ZkAHt+XtVCJLjYwP
        +V/SQloVDYJXYB/93TgUKp3q0pxmUPBv+1hk3863fPCe0iTl2/Kk2OjdU1teQDr6F6hR16
        gYGEMW3bQWwnNGAF747+1co3NH5deHpqG2gP2y/9TMsyUfk6FPIgTBCtUNUj5Urmv01wP4
        H5vmHyF7axwcDPVkrPKwWAEqBOlOTCaePmy3uMwwkvMP/iMBKxx6JYqzwosvFgr7S/pEXI
        RRX+B1/9z2AAs7CMH3gFTpE19HA57IwHmf1dfy1u9sLTeypPtWhWVmq490ISIg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1634291096;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=AE5cddRtalHTBZjtODcmF/LNiTwfjgf5Qsr2lUTLNDU=;
        b=bTSAzvPoIEBwsX0+cIiykOksm0pSZtCfMqzUQj5lHbXZW3saF3I4m4mDyfjRRt5w46reoT
        A59jcekePi8y0xCg==
From:   "tip-bot2 for Sebastian Andrzej Siewior" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] irq_work: Handle some irq_work in a per-CPU thread
 on PREEMPT_RT
Cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20211007092646.uhshe3ut2wkrcfzv@linutronix.de>
References: <20211007092646.uhshe3ut2wkrcfzv@linutronix.de>
MIME-Version: 1.0
Message-ID: <163429109512.25758.7142147762210426316.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     b4c6f86ec2f648b5e6d4b04564fbc6d5351160a8
Gitweb:        https://git.kernel.org/tip/b4c6f86ec2f648b5e6d4b04564fbc6d5351160a8
Author:        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
AuthorDate:    Thu, 07 Oct 2021 11:26:46 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 15 Oct 2021 11:25:17 +02:00

irq_work: Handle some irq_work in a per-CPU thread on PREEMPT_RT

The irq_work callback is invoked in hard IRQ context. By default all
callbacks are scheduled for invocation right away (given supported by
the architecture) except for the ones marked IRQ_WORK_LAZY which are
delayed until the next timer-tick.

While looking over the callbacks, some of them may acquire locks
(spinlock_t, rwlock_t) which are transformed into sleeping locks on
PREEMPT_RT and must not be acquired in hard IRQ context.
Changing the locks into locks which could be acquired in this context
will lead to other problems such as increased latencies if everything
in the chain has IRQ-off locks. This will not solve all the issues as
one callback has been noticed which invoked kref_put() and its callback
invokes kfree() and this can not be invoked in hardirq context.

Some callbacks are required to be invoked in hardirq context even on
PREEMPT_RT to work properly. This includes for instance the NO_HZ
callback which needs to be able to observe the idle context.

The callbacks which require to be run in hardirq have already been
marked. Use this information to split the callbacks onto the two lists
on PREEMPT_RT:
- lazy_list
  Work items which are not marked with IRQ_WORK_HARD_IRQ will be added
  to this list. Callbacks on this list will be invoked from a per-CPU
  thread.
  The handler here may acquire sleeping locks such as spinlock_t and
  invoke kfree().

- raised_list
  Work items which are marked with IRQ_WORK_HARD_IRQ will be added to
  this list. They will be invoked in hardirq context and must not
  acquire any sleeping locks.

The wake up of the per-CPU thread occurs from irq_work handler/
hardirq context. The thread runs with lowest RT priority to ensure it
runs before any SCHED_OTHER tasks do.

[bigeasy: melt tglx's irq_work_tick_soft() which splits irq_work_tick() into a
	  hard and soft variant. Collected fixes over time from Steven
	  Rostedt and Mike Galbraith. Move to per-CPU threads instead of
	  softirq as suggested by PeterZ.]

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20211007092646.uhshe3ut2wkrcfzv@linutronix.de
---
 kernel/irq_work.c | 118 ++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 106 insertions(+), 12 deletions(-)

diff --git a/kernel/irq_work.c b/kernel/irq_work.c
index e789bed..90b6b56 100644
--- a/kernel/irq_work.c
+++ b/kernel/irq_work.c
@@ -18,11 +18,36 @@
 #include <linux/cpu.h>
 #include <linux/notifier.h>
 #include <linux/smp.h>
+#include <linux/smpboot.h>
 #include <asm/processor.h>
 #include <linux/kasan.h>
 
 static DEFINE_PER_CPU(struct llist_head, raised_list);
 static DEFINE_PER_CPU(struct llist_head, lazy_list);
+static DEFINE_PER_CPU(struct task_struct *, irq_workd);
+
+static void wake_irq_workd(void)
+{
+	struct task_struct *tsk = __this_cpu_read(irq_workd);
+
+	if (!llist_empty(this_cpu_ptr(&lazy_list)) && tsk)
+		wake_up_process(tsk);
+}
+
+#ifdef CONFIG_SMP
+static void irq_work_wake(struct irq_work *entry)
+{
+	wake_irq_workd();
+}
+
+static DEFINE_PER_CPU(struct irq_work, irq_work_wakeup) =
+	IRQ_WORK_INIT_HARD(irq_work_wake);
+#endif
+
+static int irq_workd_should_run(unsigned int cpu)
+{
+	return !llist_empty(this_cpu_ptr(&lazy_list));
+}
 
 /*
  * Claim the entry so that no one else will poke at it.
@@ -52,15 +77,29 @@ void __weak arch_irq_work_raise(void)
 /* Enqueue on current CPU, work must already be claimed and preempt disabled */
 static void __irq_work_queue_local(struct irq_work *work)
 {
+	struct llist_head *list;
+	bool rt_lazy_work = false;
+	bool lazy_work = false;
+	int work_flags;
+
+	work_flags = atomic_read(&work->node.a_flags);
+	if (work_flags & IRQ_WORK_LAZY)
+		lazy_work = true;
+	else if (IS_ENABLED(CONFIG_PREEMPT_RT) &&
+		 !(work_flags & IRQ_WORK_HARD_IRQ))
+		rt_lazy_work = true;
+
+	if (lazy_work || rt_lazy_work)
+		list = this_cpu_ptr(&lazy_list);
+	else
+		list = this_cpu_ptr(&raised_list);
+
+	if (!llist_add(&work->node.llist, list))
+		return;
+
 	/* If the work is "lazy", handle it from next tick if any */
-	if (atomic_read(&work->node.a_flags) & IRQ_WORK_LAZY) {
-		if (llist_add(&work->node.llist, this_cpu_ptr(&lazy_list)) &&
-		    tick_nohz_tick_stopped())
-			arch_irq_work_raise();
-	} else {
-		if (llist_add(&work->node.llist, this_cpu_ptr(&raised_list)))
-			arch_irq_work_raise();
-	}
+	if (!lazy_work || tick_nohz_tick_stopped())
+		arch_irq_work_raise();
 }
 
 /* Enqueue the irq work @work on the current CPU */
@@ -104,17 +143,34 @@ bool irq_work_queue_on(struct irq_work *work, int cpu)
 	if (cpu != smp_processor_id()) {
 		/* Arch remote IPI send/receive backend aren't NMI safe */
 		WARN_ON_ONCE(in_nmi());
+
+		/*
+		 * On PREEMPT_RT the items which are not marked as
+		 * IRQ_WORK_HARD_IRQ are added to the lazy list and a HARD work
+		 * item is used on the remote CPU to wake the thread.
+		 */
+		if (IS_ENABLED(CONFIG_PREEMPT_RT) &&
+		    !(atomic_read(&work->node.a_flags) & IRQ_WORK_HARD_IRQ)) {
+
+			if (!llist_add(&work->node.llist, &per_cpu(lazy_list, cpu)))
+				goto out;
+
+			work = &per_cpu(irq_work_wakeup, cpu);
+			if (!irq_work_claim(work))
+				goto out;
+		}
+
 		__smp_call_single_queue(cpu, &work->node.llist);
 	} else {
 		__irq_work_queue_local(work);
 	}
+out:
 	preempt_enable();
 
 	return true;
 #endif /* CONFIG_SMP */
 }
 
-
 bool irq_work_needs_cpu(void)
 {
 	struct llist_head *raised, *lazy;
@@ -170,7 +226,12 @@ static void irq_work_run_list(struct llist_head *list)
 	struct irq_work *work, *tmp;
 	struct llist_node *llnode;
 
-	BUG_ON(!irqs_disabled());
+	/*
+	 * On PREEMPT_RT IRQ-work which is not marked as HARD will be processed
+	 * in a per-CPU thread in preemptible context. Only the items which are
+	 * marked as IRQ_WORK_HARD_IRQ will be processed in hardirq context.
+	 */
+	BUG_ON(!irqs_disabled() && !IS_ENABLED(CONFIG_PREEMPT_RT));
 
 	if (llist_empty(list))
 		return;
@@ -187,7 +248,10 @@ static void irq_work_run_list(struct llist_head *list)
 void irq_work_run(void)
 {
 	irq_work_run_list(this_cpu_ptr(&raised_list));
-	irq_work_run_list(this_cpu_ptr(&lazy_list));
+	if (!IS_ENABLED(CONFIG_PREEMPT_RT))
+		irq_work_run_list(this_cpu_ptr(&lazy_list));
+	else
+		wake_irq_workd();
 }
 EXPORT_SYMBOL_GPL(irq_work_run);
 
@@ -197,7 +261,11 @@ void irq_work_tick(void)
 
 	if (!llist_empty(raised) && !arch_irq_work_has_interrupt())
 		irq_work_run_list(raised);
-	irq_work_run_list(this_cpu_ptr(&lazy_list));
+
+	if (!IS_ENABLED(CONFIG_PREEMPT_RT))
+		irq_work_run_list(this_cpu_ptr(&lazy_list));
+	else
+		wake_irq_workd();
 }
 
 /*
@@ -219,3 +287,29 @@ void irq_work_sync(struct irq_work *work)
 		cpu_relax();
 }
 EXPORT_SYMBOL_GPL(irq_work_sync);
+
+static void run_irq_workd(unsigned int cpu)
+{
+	irq_work_run_list(this_cpu_ptr(&lazy_list));
+}
+
+static void irq_workd_setup(unsigned int cpu)
+{
+	sched_set_fifo_low(current);
+}
+
+static struct smp_hotplug_thread irqwork_threads = {
+	.store                  = &irq_workd,
+	.setup			= irq_workd_setup,
+	.thread_should_run      = irq_workd_should_run,
+	.thread_fn              = run_irq_workd,
+	.thread_comm            = "irq_work/%u",
+};
+
+static __init int irq_work_init_threads(void)
+{
+	if (IS_ENABLED(CONFIG_PREEMPT_RT))
+		BUG_ON(smpboot_register_percpu_thread(&irqwork_threads));
+	return 0;
+}
+early_initcall(irq_work_init_threads);
