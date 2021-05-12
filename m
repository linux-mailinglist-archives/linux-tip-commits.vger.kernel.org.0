Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3935837BA5B
	for <lists+linux-tip-commits@lfdr.de>; Wed, 12 May 2021 12:28:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230349AbhELK3e (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 12 May 2021 06:29:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230265AbhELK3c (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 12 May 2021 06:29:32 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C92FEC06175F;
        Wed, 12 May 2021 03:28:24 -0700 (PDT)
Date:   Wed, 12 May 2021 10:28:22 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1620815303;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PNzVZ3LZfOsjyXjcbV1zdYWYsMD8G4aUdxYoc6cR6s4=;
        b=GpuPX8TTw1uFBj1USDA3yrKglh10J9mmDyh/Xy2XEs12B3Bgdv5YKtKjdtOGd60+RicyCT
        +awFlhfUFlLzZA6IzN7mnDXnpr7Ft6eexd08O3UsIOh1ksKUqZ0EzIEADhMO82fky6rKAj
        UK/JJmZlWcjS4F5P0+BFO+2X2VzKcIG1A9LOHSMYqUGPpp3yFHn03dfmUjRwX1ZRq/NSHP
        8aLnnrs3w5dplhzd+RM9W9mRql1HBb/6W/+PACe08urYrvlMVxTE0v3Uj/4xYz7A+0zct1
        mlt2fDq5yt/RMS72IsMFsdgL+KRvAK8U6DLpDwvTDc00X+tNjZ2z34N5UJx38g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1620815303;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PNzVZ3LZfOsjyXjcbV1zdYWYsMD8G4aUdxYoc6cR6s4=;
        b=+NKVh/b3Xzu2YiHGVLDxc0nMzxY50pomMM1QFgkab3yM9WPbADAEBG9zLtOV8jfXCVG+1b
        SsXB5o5scvefL6CQ==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched: Trivial forced-newidle balancer
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Don Hiatt <dhiatt@digitalocean.com>,
        Hongyu Ning <hongyu.ning@linux.intel.com>,
        Vincent Guittot <vincent.guittot@linaro.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210422123308.800048269@infradead.org>
References: <20210422123308.800048269@infradead.org>
MIME-Version: 1.0
Message-ID: <162081530256.29796.9269859141153310893.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     d2dfa17bc7de67e99685c4d6557837bf801a102c
Gitweb:        https://git.kernel.org/tip/d2dfa17bc7de67e99685c4d6557837bf801a102c
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Tue, 17 Nov 2020 18:19:43 -05:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 12 May 2021 11:43:30 +02:00

sched: Trivial forced-newidle balancer

When a sibling is forced-idle to match the core-cookie; search for
matching tasks to fill the core.

rcu_read_unlock() can incur an infrequent deadlock in
sched_core_balance(). Fix this by using the RCU-sched flavor instead.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Tested-by: Don Hiatt <dhiatt@digitalocean.com>
Tested-by: Hongyu Ning <hongyu.ning@linux.intel.com>
Tested-by: Vincent Guittot <vincent.guittot@linaro.org>
Link: https://lkml.kernel.org/r/20210422123308.800048269@infradead.org
---
 include/linux/sched.h |   1 +-
 kernel/sched/core.c   | 130 ++++++++++++++++++++++++++++++++++++++++-
 kernel/sched/idle.c   |   1 +-
 kernel/sched/sched.h  |   6 ++-
 4 files changed, 137 insertions(+), 1 deletion(-)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index 45eedcc..9b822e3 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -705,6 +705,7 @@ struct task_struct {
 #ifdef CONFIG_SCHED_CORE
 	struct rb_node			core_node;
 	unsigned long			core_cookie;
+	unsigned int			core_occupation;
 #endif
 
 #ifdef CONFIG_CGROUP_SCHED
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index e45c1d2..b498888 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -204,6 +204,21 @@ static struct task_struct *sched_core_find(struct rq *rq, unsigned long cookie)
 	return __node_2_sc(node);
 }
 
+static struct task_struct *sched_core_next(struct task_struct *p, unsigned long cookie)
+{
+	struct rb_node *node = &p->core_node;
+
+	node = rb_next(node);
+	if (!node)
+		return NULL;
+
+	p = container_of(node, struct task_struct, core_node);
+	if (p->core_cookie != cookie)
+		return NULL;
+
+	return p;
+}
+
 /*
  * Magic required such that:
  *
@@ -5389,8 +5404,8 @@ pick_next_task(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
 	const struct sched_class *class;
 	const struct cpumask *smt_mask;
 	bool fi_before = false;
+	int i, j, cpu, occ = 0;
 	bool need_sync;
-	int i, j, cpu;
 
 	if (!sched_core_enabled(rq))
 		return __pick_next_task(rq, prev, rf);
@@ -5512,6 +5527,9 @@ again:
 			if (!p)
 				continue;
 
+			if (!is_task_rq_idle(p))
+				occ++;
+
 			rq_i->core_pick = p;
 			if (rq_i->idle == p && rq_i->nr_running) {
 				rq->core->core_forceidle = true;
@@ -5543,6 +5561,7 @@ again:
 
 						cpu_rq(j)->core_pick = NULL;
 					}
+					occ = 1;
 					goto again;
 				}
 			}
@@ -5588,6 +5607,8 @@ again:
 		if (!(fi_before && rq->core->core_forceidle))
 			task_vruntime_update(rq_i, rq_i->core_pick, rq->core->core_forceidle);
 
+		rq_i->core_pick->core_occupation = occ;
+
 		if (i == cpu) {
 			rq_i->core_pick = NULL;
 			continue;
@@ -5609,6 +5630,113 @@ done:
 	return next;
 }
 
+static bool try_steal_cookie(int this, int that)
+{
+	struct rq *dst = cpu_rq(this), *src = cpu_rq(that);
+	struct task_struct *p;
+	unsigned long cookie;
+	bool success = false;
+
+	local_irq_disable();
+	double_rq_lock(dst, src);
+
+	cookie = dst->core->core_cookie;
+	if (!cookie)
+		goto unlock;
+
+	if (dst->curr != dst->idle)
+		goto unlock;
+
+	p = sched_core_find(src, cookie);
+	if (p == src->idle)
+		goto unlock;
+
+	do {
+		if (p == src->core_pick || p == src->curr)
+			goto next;
+
+		if (!cpumask_test_cpu(this, &p->cpus_mask))
+			goto next;
+
+		if (p->core_occupation > dst->idle->core_occupation)
+			goto next;
+
+		p->on_rq = TASK_ON_RQ_MIGRATING;
+		deactivate_task(src, p, 0);
+		set_task_cpu(p, this);
+		activate_task(dst, p, 0);
+		p->on_rq = TASK_ON_RQ_QUEUED;
+
+		resched_curr(dst);
+
+		success = true;
+		break;
+
+next:
+		p = sched_core_next(p, cookie);
+	} while (p);
+
+unlock:
+	double_rq_unlock(dst, src);
+	local_irq_enable();
+
+	return success;
+}
+
+static bool steal_cookie_task(int cpu, struct sched_domain *sd)
+{
+	int i;
+
+	for_each_cpu_wrap(i, sched_domain_span(sd), cpu) {
+		if (i == cpu)
+			continue;
+
+		if (need_resched())
+			break;
+
+		if (try_steal_cookie(cpu, i))
+			return true;
+	}
+
+	return false;
+}
+
+static void sched_core_balance(struct rq *rq)
+{
+	struct sched_domain *sd;
+	int cpu = cpu_of(rq);
+
+	preempt_disable();
+	rcu_read_lock();
+	raw_spin_rq_unlock_irq(rq);
+	for_each_domain(cpu, sd) {
+		if (need_resched())
+			break;
+
+		if (steal_cookie_task(cpu, sd))
+			break;
+	}
+	raw_spin_rq_lock_irq(rq);
+	rcu_read_unlock();
+	preempt_enable();
+}
+
+static DEFINE_PER_CPU(struct callback_head, core_balance_head);
+
+void queue_core_balance(struct rq *rq)
+{
+	if (!sched_core_enabled(rq))
+		return;
+
+	if (!rq->core->core_cookie)
+		return;
+
+	if (!rq->nr_running) /* not forced idle */
+		return;
+
+	queue_balance_callback(rq, &per_cpu(core_balance_head, rq->cpu), sched_core_balance);
+}
+
 static inline void sched_core_cpu_starting(unsigned int cpu)
 {
 	const struct cpumask *smt_mask = cpu_smt_mask(cpu);
diff --git a/kernel/sched/idle.c b/kernel/sched/idle.c
index 43646e7..912b47a 100644
--- a/kernel/sched/idle.c
+++ b/kernel/sched/idle.c
@@ -437,6 +437,7 @@ static void set_next_task_idle(struct rq *rq, struct task_struct *next, bool fir
 {
 	update_idle_core(rq);
 	schedstat_inc(rq->sched_goidle);
+	queue_core_balance(rq);
 }
 
 #ifdef CONFIG_SMP
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 4a898ab..91ca1fe 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -1170,6 +1170,8 @@ static inline raw_spinlock_t *__rq_lockp(struct rq *rq)
 
 bool cfs_prio_less(struct task_struct *a, struct task_struct *b, bool fi);
 
+extern void queue_core_balance(struct rq *rq);
+
 #else /* !CONFIG_SCHED_CORE */
 
 static inline bool sched_core_enabled(struct rq *rq)
@@ -1192,6 +1194,10 @@ static inline raw_spinlock_t *__rq_lockp(struct rq *rq)
 	return &rq->__lock;
 }
 
+static inline void queue_core_balance(struct rq *rq)
+{
+}
+
 #endif /* CONFIG_SCHED_CORE */
 
 static inline void lockdep_assert_rq_held(struct rq *rq)
