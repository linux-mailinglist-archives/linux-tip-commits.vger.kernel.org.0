Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3958A37BA67
	for <lists+linux-tip-commits@lfdr.de>; Wed, 12 May 2021 12:28:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230446AbhELK3l (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 12 May 2021 06:29:41 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:50472 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230377AbhELK3g (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 12 May 2021 06:29:36 -0400
Date:   Wed, 12 May 2021 10:28:27 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1620815307;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3E+sO8rFvr8nBjHvufSes3a7sxX4XuC/9fOdzZucTl8=;
        b=wuuEzAl+HzhliehLrXWNuGfedDShq6usm1yN2Y1xZcUNg0gPohaBbE8RRiLm+d+J5Kk+DU
        dcj14yehvg9r9coM7Gb5KVhNeE6kAaaQSquWxOuoNTAA2PmZSiDjLkMq+UmfHxhCI4WbVl
        yiGC2lQ7d4B7Jh1LGBx2ZiLvYhJMH5PRTKq4PRWeI1++gQshz7CkvSEYXjwNEYkBcCxRUs
        qIPVX92Gi+dce3ji6ZK6qukP3+iM2dk6iM8bT2A+knp2qU8wHmUeugSTCLPJFrMvVK+qqx
        uMRaJ1OnUFj7eTI812KYEj9fS6SGTMLDAtoN2QA2IjVjWg6JwHFlmVVPH2mxLQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1620815307;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3E+sO8rFvr8nBjHvufSes3a7sxX4XuC/9fOdzZucTl8=;
        b=CZnQaSupONi2+FC7z2Oyu0DbFKlLD6mirmOGywaqWduYP+RdPW07O22seDz+sGZfoh7o43
        SZY6rxrROU9QZzBQ==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched: Prepare for Core-wide rq->lock
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Don Hiatt <dhiatt@digitalocean.com>,
        Hongyu Ning <hongyu.ning@linux.intel.com>,
        Vincent Guittot <vincent.guittot@linaro.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <BIm@hirez.programming.kicks-ass.net>
References: <BIm@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Message-ID: <162081530701.29796.1117391153445499337.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     d66f1b06b5b438cd20ba3664b8eef1f9c79e84bf
Gitweb:        https://git.kernel.org/tip/d66f1b06b5b438cd20ba3664b8eef1f9c79e84bf
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Tue, 02 Mar 2021 12:16:48 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 12 May 2021 11:43:26 +02:00

sched: Prepare for Core-wide rq->lock

When switching on core-sched, CPUs need to agree which lock to use for
their RQ.

The new rule will be that rq->core_enabled will be toggled while
holding all rq->__locks that belong to a core. This means we need to
double check the rq->core_enabled value after each lock acquire and
retry if it changed.

This also has implications for those sites that take multiple RQ
locks, they need to be careful that the second lock doesn't end up
being the first lock.

Verify the lock pointer after acquiring the first lock, because if
they're on the same core, holding any of the rq->__lock instances will
pin the core state.

While there, change the rq->__lock order to CPU number, instead of rq
address, this greatly simplifies the next patch.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Tested-by: Don Hiatt <dhiatt@digitalocean.com>
Tested-by: Hongyu Ning <hongyu.ning@linux.intel.com>
Tested-by: Vincent Guittot <vincent.guittot@linaro.org>
Link: https://lkml.kernel.org/r/YJUNY0dmrJMD/BIm@hirez.programming.kicks-ass.net
---
 kernel/sched/core.c  | 48 +++++++++++++++++++++++++++++++++++++++++--
 kernel/sched/sched.h | 48 +++++++++++++++----------------------------
 2 files changed, 63 insertions(+), 33 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 5e6f5f5..8bd2f12 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -186,12 +186,37 @@ int sysctl_sched_rt_runtime = 950000;
 
 void raw_spin_rq_lock_nested(struct rq *rq, int subclass)
 {
-	raw_spin_lock_nested(rq_lockp(rq), subclass);
+	raw_spinlock_t *lock;
+
+	if (sched_core_disabled()) {
+		raw_spin_lock_nested(&rq->__lock, subclass);
+		return;
+	}
+
+	for (;;) {
+		lock = rq_lockp(rq);
+		raw_spin_lock_nested(lock, subclass);
+		if (likely(lock == rq_lockp(rq)))
+			return;
+		raw_spin_unlock(lock);
+	}
 }
 
 bool raw_spin_rq_trylock(struct rq *rq)
 {
-	return raw_spin_trylock(rq_lockp(rq));
+	raw_spinlock_t *lock;
+	bool ret;
+
+	if (sched_core_disabled())
+		return raw_spin_trylock(&rq->__lock);
+
+	for (;;) {
+		lock = rq_lockp(rq);
+		ret = raw_spin_trylock(lock);
+		if (!ret || (likely(lock == rq_lockp(rq))))
+			return ret;
+		raw_spin_unlock(lock);
+	}
 }
 
 void raw_spin_rq_unlock(struct rq *rq)
@@ -199,6 +224,25 @@ void raw_spin_rq_unlock(struct rq *rq)
 	raw_spin_unlock(rq_lockp(rq));
 }
 
+#ifdef CONFIG_SMP
+/*
+ * double_rq_lock - safely lock two runqueues
+ */
+void double_rq_lock(struct rq *rq1, struct rq *rq2)
+{
+	lockdep_assert_irqs_disabled();
+
+	if (rq_order_less(rq2, rq1))
+		swap(rq1, rq2);
+
+	raw_spin_rq_lock(rq1);
+	if (rq_lockp(rq1) == rq_lockp(rq2))
+		return;
+
+	raw_spin_rq_lock_nested(rq2, SINGLE_DEPTH_NESTING);
+}
+#endif
+
 /*
  * __task_rq_lock - lock the rq @p resides on.
  */
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index dbabf28..f8bd5c8 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -1113,6 +1113,11 @@ static inline bool is_migration_disabled(struct task_struct *p)
 #endif
 }
 
+static inline bool sched_core_disabled(void)
+{
+	return true;
+}
+
 static inline raw_spinlock_t *rq_lockp(struct rq *rq)
 {
 	return &rq->__lock;
@@ -2231,10 +2236,17 @@ unsigned long arch_scale_freq_capacity(int cpu)
 }
 #endif
 
+
 #ifdef CONFIG_SMP
-#ifdef CONFIG_PREEMPTION
 
-static inline void double_rq_lock(struct rq *rq1, struct rq *rq2);
+static inline bool rq_order_less(struct rq *rq1, struct rq *rq2)
+{
+	return rq1->cpu < rq2->cpu;
+}
+
+extern void double_rq_lock(struct rq *rq1, struct rq *rq2);
+
+#ifdef CONFIG_PREEMPTION
 
 /*
  * fair double_lock_balance: Safely acquires both rq->locks in a fair
@@ -2274,14 +2286,13 @@ static inline int _double_lock_balance(struct rq *this_rq, struct rq *busiest)
 	if (likely(raw_spin_rq_trylock(busiest)))
 		return 0;
 
-	if (rq_lockp(busiest) >= rq_lockp(this_rq)) {
+	if (rq_order_less(this_rq, busiest)) {
 		raw_spin_rq_lock_nested(busiest, SINGLE_DEPTH_NESTING);
 		return 0;
 	}
 
 	raw_spin_rq_unlock(this_rq);
-	raw_spin_rq_lock(busiest);
-	raw_spin_rq_lock_nested(this_rq, SINGLE_DEPTH_NESTING);
+	double_rq_lock(this_rq, busiest);
 
 	return 1;
 }
@@ -2334,31 +2345,6 @@ static inline void double_raw_lock(raw_spinlock_t *l1, raw_spinlock_t *l2)
 }
 
 /*
- * double_rq_lock - safely lock two runqueues
- *
- * Note this does not disable interrupts like task_rq_lock,
- * you need to do so manually before calling.
- */
-static inline void double_rq_lock(struct rq *rq1, struct rq *rq2)
-	__acquires(rq1->lock)
-	__acquires(rq2->lock)
-{
-	BUG_ON(!irqs_disabled());
-	if (rq_lockp(rq1) == rq_lockp(rq2)) {
-		raw_spin_rq_lock(rq1);
-		__acquire(rq2->lock);	/* Fake it out ;) */
-	} else {
-		if (rq_lockp(rq1) < rq_lockp(rq2)) {
-			raw_spin_rq_lock(rq1);
-			raw_spin_rq_lock_nested(rq2, SINGLE_DEPTH_NESTING);
-		} else {
-			raw_spin_rq_lock(rq2);
-			raw_spin_rq_lock_nested(rq1, SINGLE_DEPTH_NESTING);
-		}
-	}
-}
-
-/*
  * double_rq_unlock - safely unlock two runqueues
  *
  * Note this does not restore interrupts like task_rq_unlock,
@@ -2368,11 +2354,11 @@ static inline void double_rq_unlock(struct rq *rq1, struct rq *rq2)
 	__releases(rq1->lock)
 	__releases(rq2->lock)
 {
-	raw_spin_rq_unlock(rq1);
 	if (rq_lockp(rq1) != rq_lockp(rq2))
 		raw_spin_rq_unlock(rq2);
 	else
 		__release(rq2->lock);
+	raw_spin_rq_unlock(rq1);
 }
 
 extern void set_rq_online (struct rq *rq);
