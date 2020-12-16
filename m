Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 89CB22DBF46
	for <lists+linux-tip-commits@lfdr.de>; Wed, 16 Dec 2020 12:19:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725802AbgLPLT1 (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 16 Dec 2020 06:19:27 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:39102 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725283AbgLPLT1 (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 16 Dec 2020 06:19:27 -0500
Date:   Wed, 16 Dec 2020 11:18:43 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1608117524;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jz3I4Tqo/lX9bY0037W7+wsY40deo+/W4vQAxpvFxAI=;
        b=BrNbW60LyVTXUhTJYk8k05rOxzfKw6cIatVUeUKxB8hGglQcvkGGWQGtnJDsxmPu6EMfMV
        SbB3eF6qlsNLgmVBbgPvO5cEME7tPlsEh2qFTpV8CaPTFt4oIx26TRPC/IionkdYqLqpmv
        wPtx+VTMaiASn+taBSbqGXEjVKZDbU74PNW4B/oavBpJNg27g/zm7r+8cAGhva/z+H1RHo
        U9MXVh9ERjrmLpIpG6hAa0qF5wywBnNDVC5DA1TN/vP0FiWPUiGjWGl/RBgxyG7I4PXX7B
        84hS6bAk5MX1Xs2srdeMoDRcArZUI3lBZZxFzaCC5+VZH7A6EC4MFXEJvrz9lg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1608117524;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jz3I4Tqo/lX9bY0037W7+wsY40deo+/W4vQAxpvFxAI=;
        b=ZRQAQ48DhPxATd0JW3c/OG9K8CPXM7VYLtM0a8Ug08XnochaQfdtkiL6C5BkNesskL5fpd
        /sAvG3HnTw9mUwBw==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/urgent] sched: Optimize finish_lock_switch()
Cc:     kernel test robot <oliver.sang@intel.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20201210161408.GX3021@hirez.programming.kicks-ass.net>
References: <20201210161408.GX3021@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Message-ID: <160811752374.3364.14062690988197592123.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the sched/urgent branch of tip:

Commit-ID:     ae7927023243dcc7389b2d59b16c09cbbeaecc36
Gitweb:        https://git.kernel.org/tip/ae7927023243dcc7389b2d59b16c09cbbeaecc36
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Thu, 10 Dec 2020 17:14:08 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 15 Dec 2020 11:27:53 +01:00

sched: Optimize finish_lock_switch()

The kernel test robot measured a -1.6% performance regression on
will-it-scale/sched_yield due to commit:

  2558aacff858 ("sched/hotplug: Ensure only per-cpu kthreads run during hotplug")

Even though we were careful to replace a single load with another
single load from the same cacheline.

Restore finish_lock_switch() to the exact state before the offending
patch and solve the problem differently.

Fixes: 2558aacff858 ("sched/hotplug: Ensure only per-cpu kthreads run during hotplug")
Reported-by: kernel test robot <oliver.sang@intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20201210161408.GX3021@hirez.programming.kicks-ass.net
---
 kernel/sched/core.c  | 40 +++++++++++++++-------------------------
 kernel/sched/sched.h | 13 +++++--------
 2 files changed, 20 insertions(+), 33 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 7af80c3..0ca7d2d 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -3985,15 +3985,20 @@ static void do_balance_callbacks(struct rq *rq, struct callback_head *head)
 	}
 }
 
+static void balance_push(struct rq *rq);
+
+struct callback_head balance_push_callback = {
+	.next = NULL,
+	.func = (void (*)(struct callback_head *))balance_push,
+};
+
 static inline struct callback_head *splice_balance_callbacks(struct rq *rq)
 {
 	struct callback_head *head = rq->balance_callback;
 
 	lockdep_assert_held(&rq->lock);
-	if (head) {
+	if (head)
 		rq->balance_callback = NULL;
-		rq->balance_flags &= ~BALANCE_WORK;
-	}
 
 	return head;
 }
@@ -4014,21 +4019,6 @@ static inline void balance_callbacks(struct rq *rq, struct callback_head *head)
 	}
 }
 
-static void balance_push(struct rq *rq);
-
-static inline void balance_switch(struct rq *rq)
-{
-	if (likely(!rq->balance_flags))
-		return;
-
-	if (rq->balance_flags & BALANCE_PUSH) {
-		balance_push(rq);
-		return;
-	}
-
-	__balance_callbacks(rq);
-}
-
 #else
 
 static inline void __balance_callbacks(struct rq *rq)
@@ -4044,10 +4034,6 @@ static inline void balance_callbacks(struct rq *rq, struct callback_head *head)
 {
 }
 
-static inline void balance_switch(struct rq *rq)
-{
-}
-
 #endif
 
 static inline void
@@ -4075,7 +4061,7 @@ static inline void finish_lock_switch(struct rq *rq)
 	 * prev into current:
 	 */
 	spin_acquire(&rq->lock.dep_map, 0, 0, _THIS_IP_);
-	balance_switch(rq);
+	__balance_callbacks(rq);
 	raw_spin_unlock_irq(&rq->lock);
 }
 
@@ -7256,6 +7242,10 @@ static void balance_push(struct rq *rq)
 
 	lockdep_assert_held(&rq->lock);
 	SCHED_WARN_ON(rq->cpu != smp_processor_id());
+	/*
+	 * Ensure the thing is persistent until balance_push_set(.on = false);
+	 */
+	rq->balance_callback = &balance_push_callback;
 
 	/*
 	 * Both the cpu-hotplug and stop task are in this case and are
@@ -7305,9 +7295,9 @@ static void balance_push_set(int cpu, bool on)
 
 	rq_lock_irqsave(rq, &rf);
 	if (on)
-		rq->balance_flags |= BALANCE_PUSH;
+		rq->balance_callback = &balance_push_callback;
 	else
-		rq->balance_flags &= ~BALANCE_PUSH;
+		rq->balance_callback = NULL;
 	rq_unlock_irqrestore(rq, &rf);
 }
 
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index f5acb6c..12ada79 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -975,7 +975,6 @@ struct rq {
 	unsigned long		cpu_capacity_orig;
 
 	struct callback_head	*balance_callback;
-	unsigned char		balance_flags;
 
 	unsigned char		nohz_idle_balance;
 	unsigned char		idle_balance;
@@ -1226,6 +1225,8 @@ struct rq_flags {
 #endif
 };
 
+extern struct callback_head balance_push_callback;
+
 /*
  * Lockdep annotation that avoids accidental unlocks; it's like a
  * sticky/continuous lockdep_assert_held().
@@ -1243,9 +1244,9 @@ static inline void rq_pin_lock(struct rq *rq, struct rq_flags *rf)
 #ifdef CONFIG_SCHED_DEBUG
 	rq->clock_update_flags &= (RQCF_REQ_SKIP|RQCF_ACT_SKIP);
 	rf->clock_update_flags = 0;
-#endif
 #ifdef CONFIG_SMP
-	SCHED_WARN_ON(rq->balance_callback);
+	SCHED_WARN_ON(rq->balance_callback && rq->balance_callback != &balance_push_callback);
+#endif
 #endif
 }
 
@@ -1408,9 +1409,6 @@ init_numa_balancing(unsigned long clone_flags, struct task_struct *p)
 
 #ifdef CONFIG_SMP
 
-#define BALANCE_WORK	0x01
-#define BALANCE_PUSH	0x02
-
 static inline void
 queue_balance_callback(struct rq *rq,
 		       struct callback_head *head,
@@ -1418,13 +1416,12 @@ queue_balance_callback(struct rq *rq,
 {
 	lockdep_assert_held(&rq->lock);
 
-	if (unlikely(head->next || (rq->balance_flags & BALANCE_PUSH)))
+	if (unlikely(head->next || rq->balance_callback == &balance_push_callback))
 		return;
 
 	head->func = (void (*)(struct callback_head *))func;
 	head->next = rq->balance_callback;
 	rq->balance_callback = head;
-	rq->balance_flags |= BALANCE_WORK;
 }
 
 #define rcu_dereference_check_sched_domain(p) \
