Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC1092AEB12
	for <lists+linux-tip-commits@lfdr.de>; Wed, 11 Nov 2020 09:24:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726494AbgKKIXs (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 11 Nov 2020 03:23:48 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:36274 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726343AbgKKIX1 (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 11 Nov 2020 03:23:27 -0500
Date:   Wed, 11 Nov 2020 08:23:23 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1605083004;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6yCVxYMkpImpziLXmx7wh5PCfnLqi/hobcwWfR1qL+Q=;
        b=m1o2TKEYeXvdJcgfqn3cej9y8PQqxqlyOJmVWw/rO9iKriJ2p39Vzm36obacP9m9ER3J7C
        0O3ao0e4zR8Z4fiFvmpLGpGo0wJ8f2JhAyrmRjpWbDXqmCKvJ7fYp60z1q6D+BvAkrcG3L
        PqwFCKxm1CNepjzelOM7x6UhHdmGiPRDKLpSNuzrHzXvkgAix9TrtdjORhlQjyliOHARSK
        rwr7fx+JVudWCkh9juUyZ8csR7vaKW4C7rUgQAZBHW0o5bLKaDIO9KCIpCg9/E+dcy/VNm
        PCovN6/WdwtUmIGK+YvSBPJzHeBD5rbrV44ZPUoew4eliyC8V8QNnrAH1FDPqg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1605083004;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6yCVxYMkpImpziLXmx7wh5PCfnLqi/hobcwWfR1qL+Q=;
        b=9SPtRX+8gUOS3ySBFfq1BU1pBF6ROhkFs4r50mciYAIbu0TzkMWNfkO/mwggNJ7lVHQrcE
        6xChUK7Fbu3JiTCg==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched: Fix balance_callback()
Cc:     Scott Wood <swood@redhat.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20201023102346.203901269@infradead.org>
References: <20201023102346.203901269@infradead.org>
MIME-Version: 1.0
Message-ID: <160508300397.11244.13967684821070428528.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     565790d28b1e33ee2f77bad5348b99f6dfc366fd
Gitweb:        https://git.kernel.org/tip/565790d28b1e33ee2f77bad5348b99f6dfc366fd
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Mon, 11 May 2020 14:13:00 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 10 Nov 2020 18:38:57 +01:00

sched: Fix balance_callback()

The intent of balance_callback() has always been to delay executing
balancing operations until the end of the current rq->lock section.
This is because balance operations must often drop rq->lock, and that
isn't safe in general.

However, as noted by Scott, there were a few holes in that scheme;
balance_callback() was called after rq->lock was dropped, which means
another CPU can interleave and touch the callback list.

Rework code to call the balance callbacks before dropping rq->lock
where possible, and otherwise splice the balance list onto a local
stack.

This guarantees that the balance list must be empty when we take
rq->lock. IOW, we'll only ever run our own balance callbacks.

Reported-by: Scott Wood <swood@redhat.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Valentin Schneider <valentin.schneider@arm.com>
Reviewed-by: Daniel Bristot de Oliveira <bristot@redhat.com>
Link: https://lkml.kernel.org/r/20201023102346.203901269@infradead.org
---
 kernel/sched/core.c  | 119 ++++++++++++++++++++++++++----------------
 kernel/sched/sched.h |   3 +-
 2 files changed, 78 insertions(+), 44 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 5e24104..0196a3f 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -3485,6 +3485,69 @@ static inline void finish_task(struct task_struct *prev)
 #endif
 }
 
+#ifdef CONFIG_SMP
+
+static void do_balance_callbacks(struct rq *rq, struct callback_head *head)
+{
+	void (*func)(struct rq *rq);
+	struct callback_head *next;
+
+	lockdep_assert_held(&rq->lock);
+
+	while (head) {
+		func = (void (*)(struct rq *))head->func;
+		next = head->next;
+		head->next = NULL;
+		head = next;
+
+		func(rq);
+	}
+}
+
+static inline struct callback_head *splice_balance_callbacks(struct rq *rq)
+{
+	struct callback_head *head = rq->balance_callback;
+
+	lockdep_assert_held(&rq->lock);
+	if (head)
+		rq->balance_callback = NULL;
+
+	return head;
+}
+
+static void __balance_callbacks(struct rq *rq)
+{
+	do_balance_callbacks(rq, splice_balance_callbacks(rq));
+}
+
+static inline void balance_callbacks(struct rq *rq, struct callback_head *head)
+{
+	unsigned long flags;
+
+	if (unlikely(head)) {
+		raw_spin_lock_irqsave(&rq->lock, flags);
+		do_balance_callbacks(rq, head);
+		raw_spin_unlock_irqrestore(&rq->lock, flags);
+	}
+}
+
+#else
+
+static inline void __balance_callbacks(struct rq *rq)
+{
+}
+
+static inline struct callback_head *splice_balance_callbacks(struct rq *rq)
+{
+	return NULL;
+}
+
+static inline void balance_callbacks(struct rq *rq, struct callback_head *head)
+{
+}
+
+#endif
+
 static inline void
 prepare_lock_switch(struct rq *rq, struct task_struct *next, struct rq_flags *rf)
 {
@@ -3510,6 +3573,7 @@ static inline void finish_lock_switch(struct rq *rq)
 	 * prev into current:
 	 */
 	spin_acquire(&rq->lock.dep_map, 0, 0, _THIS_IP_);
+	__balance_callbacks(rq);
 	raw_spin_unlock_irq(&rq->lock);
 }
 
@@ -3651,43 +3715,6 @@ static struct rq *finish_task_switch(struct task_struct *prev)
 	return rq;
 }
 
-#ifdef CONFIG_SMP
-
-/* rq->lock is NOT held, but preemption is disabled */
-static void __balance_callback(struct rq *rq)
-{
-	struct callback_head *head, *next;
-	void (*func)(struct rq *rq);
-	unsigned long flags;
-
-	raw_spin_lock_irqsave(&rq->lock, flags);
-	head = rq->balance_callback;
-	rq->balance_callback = NULL;
-	while (head) {
-		func = (void (*)(struct rq *))head->func;
-		next = head->next;
-		head->next = NULL;
-		head = next;
-
-		func(rq);
-	}
-	raw_spin_unlock_irqrestore(&rq->lock, flags);
-}
-
-static inline void balance_callback(struct rq *rq)
-{
-	if (unlikely(rq->balance_callback))
-		__balance_callback(rq);
-}
-
-#else
-
-static inline void balance_callback(struct rq *rq)
-{
-}
-
-#endif
-
 /**
  * schedule_tail - first thing a freshly forked thread must call.
  * @prev: the thread we just switched away from.
@@ -3707,7 +3734,6 @@ asmlinkage __visible void schedule_tail(struct task_struct *prev)
 	 */
 
 	rq = finish_task_switch(prev);
-	balance_callback(rq);
 	preempt_enable();
 
 	if (current->set_child_tid)
@@ -4523,10 +4549,11 @@ static void __sched notrace __schedule(bool preempt)
 		rq = context_switch(rq, prev, next, &rf);
 	} else {
 		rq->clock_update_flags &= ~(RQCF_ACT_SKIP|RQCF_REQ_SKIP);
-		rq_unlock_irq(rq, &rf);
-	}
 
-	balance_callback(rq);
+		rq_unpin_lock(rq, &rf);
+		__balance_callbacks(rq);
+		raw_spin_unlock_irq(&rq->lock);
+	}
 }
 
 void __noreturn do_task_dead(void)
@@ -4937,9 +4964,11 @@ void rt_mutex_setprio(struct task_struct *p, struct task_struct *pi_task)
 out_unlock:
 	/* Avoid rq from going away on us: */
 	preempt_disable();
-	__task_rq_unlock(rq, &rf);
 
-	balance_callback(rq);
+	rq_unpin_lock(rq, &rf);
+	__balance_callbacks(rq);
+	raw_spin_unlock(&rq->lock);
+
 	preempt_enable();
 }
 #else
@@ -5213,6 +5242,7 @@ static int __sched_setscheduler(struct task_struct *p,
 	int retval, oldprio, oldpolicy = -1, queued, running;
 	int new_effective_prio, policy = attr->sched_policy;
 	const struct sched_class *prev_class;
+	struct callback_head *head;
 	struct rq_flags rf;
 	int reset_on_fork;
 	int queue_flags = DEQUEUE_SAVE | DEQUEUE_MOVE | DEQUEUE_NOCLOCK;
@@ -5451,6 +5481,7 @@ change:
 
 	/* Avoid rq from going away on us: */
 	preempt_disable();
+	head = splice_balance_callbacks(rq);
 	task_rq_unlock(rq, p, &rf);
 
 	if (pi) {
@@ -5459,7 +5490,7 @@ change:
 	}
 
 	/* Run balance callbacks after we've adjusted the PI chain: */
-	balance_callback(rq);
+	balance_callbacks(rq, head);
 	preempt_enable();
 
 	return 0;
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index df80bfc..738a00b 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -1221,6 +1221,9 @@ static inline void rq_pin_lock(struct rq *rq, struct rq_flags *rf)
 	rq->clock_update_flags &= (RQCF_REQ_SKIP|RQCF_ACT_SKIP);
 	rf->clock_update_flags = 0;
 #endif
+#ifdef CONFIG_SMP
+	SCHED_WARN_ON(rq->balance_callback);
+#endif
 }
 
 static inline void rq_unpin_lock(struct rq *rq, struct rq_flags *rf)
