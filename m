Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4976B2AEB15
	for <lists+linux-tip-commits@lfdr.de>; Wed, 11 Nov 2020 09:24:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726359AbgKKIYC (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 11 Nov 2020 03:24:02 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:36280 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726337AbgKKIXZ (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 11 Nov 2020 03:23:25 -0500
Date:   Wed, 11 Nov 2020 08:23:23 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1605083004;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4klt9/+S5bculp9gEy6o3UoHWzT81kFGXf9Egno9AiI=;
        b=LF//zVxUapkG8mlNscIKEGgPKx8vBOtbqyRzBaScl96mAtIwiW7iRhzL1g8UwkWnGoldOo
        II6Yf0JJq/Pfr0gq1YQV00zOGsUm6LCZpE4BA+Pp9SlhNJZWP8XmYeoQDbnkUnmsqmE2j6
        JrAaIQghuZ+tCFROIshCrD6uZ8QxXNfiCCpePEMujbVIggkC+kwddn3WqCnIjbVhKU7fav
        3A4TwqGmGFt5K5oaHdkjfDTnJWnhf12dvtVfIIqyxYMMijWDuUyhChwK0t0n8TkxfiAWey
        WBzSYxxnFxFABdifbfQRFO9ShNtCTq7aiIIDslDq0vrNbtLRVvF0R/gCn8EUQQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1605083004;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4klt9/+S5bculp9gEy6o3UoHWzT81kFGXf9Egno9AiI=;
        b=UynKVX+EXhccUDXL83orLQwl1MUHG+mBe2MPC4/ELS65eg3ZAY9WTTBR4VpH0L1S6+vOUh
        NXeoEB/AtnW2plAw==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/hotplug: Ensure only per-cpu kthreads run
 during hotplug
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20201023102346.292709163@infradead.org>
References: <20201023102346.292709163@infradead.org>
MIME-Version: 1.0
Message-ID: <160508300339.11244.1795848318795691065.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     2558aacff8586699bcd248b406febb28b0a25de2
Gitweb:        https://git.kernel.org/tip/2558aacff8586699bcd248b406febb28b0a25de2
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Fri, 11 Sep 2020 09:54:27 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 10 Nov 2020 18:38:57 +01:00

sched/hotplug: Ensure only per-cpu kthreads run during hotplug

In preparation for migrate_disable(), make sure only per-cpu kthreads
are allowed to run on !active CPUs.

This is ran (as one of the very first steps) from the cpu-hotplug
task which is a per-cpu kthread and completion of the hotplug
operation only requires such tasks.

This constraint enables the migrate_disable() implementation to wait
for completion of all migrate_disable regions on this CPU at hotplug
time without fear of any new ones starting.

This replaces the unlikely(rq->balance_callbacks) test at the tail of
context_switch with an unlikely(rq->balance_work), the fast path is
not affected.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Valentin Schneider <valentin.schneider@arm.com>
Reviewed-by: Daniel Bristot de Oliveira <bristot@redhat.com>
Link: https://lkml.kernel.org/r/20201023102346.292709163@infradead.org
---
 kernel/sched/core.c  | 114 +++++++++++++++++++++++++++++++++++++++++-
 kernel/sched/sched.h |   7 ++-
 2 files changed, 118 insertions(+), 3 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 0196a3f..1f8bfc9 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -3509,8 +3509,10 @@ static inline struct callback_head *splice_balance_callbacks(struct rq *rq)
 	struct callback_head *head = rq->balance_callback;
 
 	lockdep_assert_held(&rq->lock);
-	if (head)
+	if (head) {
 		rq->balance_callback = NULL;
+		rq->balance_flags &= ~BALANCE_WORK;
+	}
 
 	return head;
 }
@@ -3531,6 +3533,21 @@ static inline void balance_callbacks(struct rq *rq, struct callback_head *head)
 	}
 }
 
+static void balance_push(struct rq *rq);
+
+static inline void balance_switch(struct rq *rq)
+{
+	if (likely(!rq->balance_flags))
+		return;
+
+	if (rq->balance_flags & BALANCE_PUSH) {
+		balance_push(rq);
+		return;
+	}
+
+	__balance_callbacks(rq);
+}
+
 #else
 
 static inline void __balance_callbacks(struct rq *rq)
@@ -3546,6 +3563,10 @@ static inline void balance_callbacks(struct rq *rq, struct callback_head *head)
 {
 }
 
+static inline void balance_switch(struct rq *rq)
+{
+}
+
 #endif
 
 static inline void
@@ -3573,7 +3594,7 @@ static inline void finish_lock_switch(struct rq *rq)
 	 * prev into current:
 	 */
 	spin_acquire(&rq->lock.dep_map, 0, 0, _THIS_IP_);
-	__balance_callbacks(rq);
+	balance_switch(rq);
 	raw_spin_unlock_irq(&rq->lock);
 }
 
@@ -6833,6 +6854,90 @@ static void migrate_tasks(struct rq *dead_rq, struct rq_flags *rf)
 
 	rq->stop = stop;
 }
+
+static int __balance_push_cpu_stop(void *arg)
+{
+	struct task_struct *p = arg;
+	struct rq *rq = this_rq();
+	struct rq_flags rf;
+	int cpu;
+
+	raw_spin_lock_irq(&p->pi_lock);
+	rq_lock(rq, &rf);
+
+	update_rq_clock(rq);
+
+	if (task_rq(p) == rq && task_on_rq_queued(p)) {
+		cpu = select_fallback_rq(rq->cpu, p);
+		rq = __migrate_task(rq, &rf, p, cpu);
+	}
+
+	rq_unlock(rq, &rf);
+	raw_spin_unlock_irq(&p->pi_lock);
+
+	put_task_struct(p);
+
+	return 0;
+}
+
+static DEFINE_PER_CPU(struct cpu_stop_work, push_work);
+
+/*
+ * Ensure we only run per-cpu kthreads once the CPU goes !active.
+ */
+static void balance_push(struct rq *rq)
+{
+	struct task_struct *push_task = rq->curr;
+
+	lockdep_assert_held(&rq->lock);
+	SCHED_WARN_ON(rq->cpu != smp_processor_id());
+
+	/*
+	 * Both the cpu-hotplug and stop task are in this case and are
+	 * required to complete the hotplug process.
+	 */
+	if (is_per_cpu_kthread(push_task))
+		return;
+
+	get_task_struct(push_task);
+	/*
+	 * Temporarily drop rq->lock such that we can wake-up the stop task.
+	 * Both preemption and IRQs are still disabled.
+	 */
+	raw_spin_unlock(&rq->lock);
+	stop_one_cpu_nowait(rq->cpu, __balance_push_cpu_stop, push_task,
+			    this_cpu_ptr(&push_work));
+	/*
+	 * At this point need_resched() is true and we'll take the loop in
+	 * schedule(). The next pick is obviously going to be the stop task
+	 * which is_per_cpu_kthread() and will push this task away.
+	 */
+	raw_spin_lock(&rq->lock);
+}
+
+static void balance_push_set(int cpu, bool on)
+{
+	struct rq *rq = cpu_rq(cpu);
+	struct rq_flags rf;
+
+	rq_lock_irqsave(rq, &rf);
+	if (on)
+		rq->balance_flags |= BALANCE_PUSH;
+	else
+		rq->balance_flags &= ~BALANCE_PUSH;
+	rq_unlock_irqrestore(rq, &rf);
+}
+
+#else
+
+static inline void balance_push(struct rq *rq)
+{
+}
+
+static inline void balance_push_set(int cpu, bool on)
+{
+}
+
 #endif /* CONFIG_HOTPLUG_CPU */
 
 void set_rq_online(struct rq *rq)
@@ -6918,6 +7023,8 @@ int sched_cpu_activate(unsigned int cpu)
 	struct rq *rq = cpu_rq(cpu);
 	struct rq_flags rf;
 
+	balance_push_set(cpu, false);
+
 #ifdef CONFIG_SCHED_SMT
 	/*
 	 * When going up, increment the number of cores with SMT present.
@@ -6965,6 +7072,8 @@ int sched_cpu_deactivate(unsigned int cpu)
 	 */
 	synchronize_rcu();
 
+	balance_push_set(cpu, true);
+
 #ifdef CONFIG_SCHED_SMT
 	/*
 	 * When going down, decrement the number of cores with SMT present.
@@ -6978,6 +7087,7 @@ int sched_cpu_deactivate(unsigned int cpu)
 
 	ret = cpuset_cpu_inactive(cpu);
 	if (ret) {
+		balance_push_set(cpu, false);
 		set_cpu_active(cpu, true);
 		return ret;
 	}
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 738a00b..a71ac84 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -973,6 +973,7 @@ struct rq {
 	unsigned long		cpu_capacity_orig;
 
 	struct callback_head	*balance_callback;
+	unsigned char		balance_flags;
 
 	unsigned char		nohz_idle_balance;
 	unsigned char		idle_balance;
@@ -1385,6 +1386,9 @@ init_numa_balancing(unsigned long clone_flags, struct task_struct *p)
 
 #ifdef CONFIG_SMP
 
+#define BALANCE_WORK	0x01
+#define BALANCE_PUSH	0x02
+
 static inline void
 queue_balance_callback(struct rq *rq,
 		       struct callback_head *head,
@@ -1392,12 +1396,13 @@ queue_balance_callback(struct rq *rq,
 {
 	lockdep_assert_held(&rq->lock);
 
-	if (unlikely(head->next))
+	if (unlikely(head->next || (rq->balance_flags & BALANCE_PUSH)))
 		return;
 
 	head->func = (void (*)(struct callback_head *))func;
 	head->next = rq->balance_callback;
 	rq->balance_callback = head;
+	rq->balance_flags |= BALANCE_WORK;
 }
 
 #define rcu_dereference_check_sched_domain(p) \
