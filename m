Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D09237BA65
	for <lists+linux-tip-commits@lfdr.de>; Wed, 12 May 2021 12:28:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230372AbhELK3j (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 12 May 2021 06:29:39 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:50450 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230363AbhELK3f (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 12 May 2021 06:29:35 -0400
Date:   Wed, 12 May 2021 10:28:26 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1620815306;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qJlKcQ1Es+YhVojY3MaM+PcDCwzs1wie0mbL7bxN0+4=;
        b=0BBH8RSPQuEk5grj0R0JGnHggHPZkV4VRtjIZkqr0ETMd5QlY+zJOoGnU0UVx1FnCWnCa0
        8AjetpIjdK0W5bKulZVzLNJuidvk2dER7SFeTNgpZSVPbSRKEixlk6abQypPAgAedIG+kY
        fJBNyC3x+gsEMxDKrDj1/kKaejj6lhVByrYAg71pwhARcpIH1mQcw6CIQE5PA7Zzgcxpj7
        /fCud2blHNcZx8NRePgKNwKSF3R7rHoytWpIJ2C4FbayFI87Uhv0kZU/hEw3hx2TRyxqL1
        Fhu4VKJrgtWLKSAr2ZV3hk9vZykq2hO5QCMba+IBWLdVO5OHmHFxFI/DW1mPoA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1620815306;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qJlKcQ1Es+YhVojY3MaM+PcDCwzs1wie0mbL7bxN0+4=;
        b=2NRE5JQid0zXoW65MTieMQjFzNvnjaRZJFgKaEPIYvghJr10K2b8Evq6s7gegGtrrf74yy
        IQdJMV2PNpdzfVAQ==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched: Optimize rq_lockp() usage
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Don Hiatt <dhiatt@digitalocean.com>,
        Hongyu Ning <hongyu.ning@linux.intel.com>,
        Vincent Guittot <vincent.guittot@linaro.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210422123308.316696988@infradead.org>
References: <20210422123308.316696988@infradead.org>
MIME-Version: 1.0
Message-ID: <162081530619.29796.11256820252103924811.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     9ef7e7e33bcdb57be1afb28884053c28b5f05240
Gitweb:        https://git.kernel.org/tip/9ef7e7e33bcdb57be1afb28884053c28b5f05240
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Wed, 03 Mar 2021 16:45:41 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 12 May 2021 11:43:27 +02:00

sched: Optimize rq_lockp() usage

rq_lockp() includes a static_branch(), which is asm-goto, which is
asm volatile which defeats regular CSE. This means that:

	if (!static_branch(&foo))
		return simple;

	if (static_branch(&foo) && cond)
		return complex;

Doesn't fold and we get horrible code. Introduce __rq_lockp() without
the static_branch() on.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Tested-by: Don Hiatt <dhiatt@digitalocean.com>
Tested-by: Hongyu Ning <hongyu.ning@linux.intel.com>
Tested-by: Vincent Guittot <vincent.guittot@linaro.org>
Link: https://lkml.kernel.org/r/20210422123308.316696988@infradead.org
---
 kernel/sched/core.c     | 16 ++++++++--------
 kernel/sched/deadline.c |  4 ++--
 kernel/sched/fair.c     |  2 +-
 kernel/sched/sched.h    | 33 +++++++++++++++++++++++++--------
 4 files changed, 36 insertions(+), 19 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 384b793..42c1c88 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -300,9 +300,9 @@ void raw_spin_rq_lock_nested(struct rq *rq, int subclass)
 	}
 
 	for (;;) {
-		lock = rq_lockp(rq);
+		lock = __rq_lockp(rq);
 		raw_spin_lock_nested(lock, subclass);
-		if (likely(lock == rq_lockp(rq))) {
+		if (likely(lock == __rq_lockp(rq))) {
 			/* preempt_count *MUST* be > 1 */
 			preempt_enable_no_resched();
 			return;
@@ -325,9 +325,9 @@ bool raw_spin_rq_trylock(struct rq *rq)
 	}
 
 	for (;;) {
-		lock = rq_lockp(rq);
+		lock = __rq_lockp(rq);
 		ret = raw_spin_trylock(lock);
-		if (!ret || (likely(lock == rq_lockp(rq)))) {
+		if (!ret || (likely(lock == __rq_lockp(rq)))) {
 			preempt_enable();
 			return ret;
 		}
@@ -352,7 +352,7 @@ void double_rq_lock(struct rq *rq1, struct rq *rq2)
 		swap(rq1, rq2);
 
 	raw_spin_rq_lock(rq1);
-	if (rq_lockp(rq1) == rq_lockp(rq2))
+	if (__rq_lockp(rq1) == __rq_lockp(rq2))
 		return;
 
 	raw_spin_rq_lock_nested(rq2, SINGLE_DEPTH_NESTING);
@@ -2622,7 +2622,7 @@ void set_task_cpu(struct task_struct *p, unsigned int new_cpu)
 	 * task_rq_lock().
 	 */
 	WARN_ON_ONCE(debug_locks && !(lockdep_is_held(&p->pi_lock) ||
-				      lockdep_is_held(rq_lockp(task_rq(p)))));
+				      lockdep_is_held(__rq_lockp(task_rq(p)))));
 #endif
 	/*
 	 * Clearly, migrating tasks to offline CPUs is a fairly daft thing.
@@ -4248,7 +4248,7 @@ prepare_lock_switch(struct rq *rq, struct task_struct *next, struct rq_flags *rf
 	 * do an early lockdep release here:
 	 */
 	rq_unpin_lock(rq, rf);
-	spin_release(&rq_lockp(rq)->dep_map, _THIS_IP_);
+	spin_release(&__rq_lockp(rq)->dep_map, _THIS_IP_);
 #ifdef CONFIG_DEBUG_SPINLOCK
 	/* this is a valid case when another task releases the spinlock */
 	rq_lockp(rq)->owner = next;
@@ -4262,7 +4262,7 @@ static inline void finish_lock_switch(struct rq *rq)
 	 * fix up the runqueue lock - which gets 'carried over' from
 	 * prev into current:
 	 */
-	spin_acquire(&rq_lockp(rq)->dep_map, 0, 0, _THIS_IP_);
+	spin_acquire(&__rq_lockp(rq)->dep_map, 0, 0, _THIS_IP_);
 	__balance_callbacks(rq);
 	raw_spin_rq_unlock_irq(rq);
 }
diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index 6e99b8b..fb0eb9a 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -1097,9 +1097,9 @@ static enum hrtimer_restart dl_task_timer(struct hrtimer *timer)
 		 * If the runqueue is no longer available, migrate the
 		 * task elsewhere. This necessarily changes rq.
 		 */
-		lockdep_unpin_lock(rq_lockp(rq), rf.cookie);
+		lockdep_unpin_lock(__rq_lockp(rq), rf.cookie);
 		rq = dl_task_offline_migration(rq, p);
-		rf.cookie = lockdep_pin_lock(rq_lockp(rq));
+		rf.cookie = lockdep_pin_lock(__rq_lockp(rq));
 		update_rq_clock(rq);
 
 		/*
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index e50bd75..18960d0 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -1107,7 +1107,7 @@ struct numa_group {
 static struct numa_group *deref_task_numa_group(struct task_struct *p)
 {
 	return rcu_dereference_check(p->numa_group, p == current ||
-		(lockdep_is_held(rq_lockp(task_rq(p))) && !READ_ONCE(p->on_cpu)));
+		(lockdep_is_held(__rq_lockp(task_rq(p))) && !READ_ONCE(p->on_cpu)));
 }
 
 static struct numa_group *deref_curr_numa_group(struct task_struct *p)
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 29418b8..ca30af3 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -1133,6 +1133,10 @@ static inline bool sched_core_disabled(void)
 	return !static_branch_unlikely(&__sched_core_enabled);
 }
 
+/*
+ * Be careful with this function; not for general use. The return value isn't
+ * stable unless you actually hold a relevant rq->__lock.
+ */
 static inline raw_spinlock_t *rq_lockp(struct rq *rq)
 {
 	if (sched_core_enabled(rq))
@@ -1141,6 +1145,14 @@ static inline raw_spinlock_t *rq_lockp(struct rq *rq)
 	return &rq->__lock;
 }
 
+static inline raw_spinlock_t *__rq_lockp(struct rq *rq)
+{
+	if (rq->core_enabled)
+		return &rq->core->__lock;
+
+	return &rq->__lock;
+}
+
 #else /* !CONFIG_SCHED_CORE */
 
 static inline bool sched_core_enabled(struct rq *rq)
@@ -1158,11 +1170,16 @@ static inline raw_spinlock_t *rq_lockp(struct rq *rq)
 	return &rq->__lock;
 }
 
+static inline raw_spinlock_t *__rq_lockp(struct rq *rq)
+{
+	return &rq->__lock;
+}
+
 #endif /* CONFIG_SCHED_CORE */
 
 static inline void lockdep_assert_rq_held(struct rq *rq)
 {
-	lockdep_assert_held(rq_lockp(rq));
+	lockdep_assert_held(__rq_lockp(rq));
 }
 
 extern void raw_spin_rq_lock_nested(struct rq *rq, int subclass);
@@ -1346,7 +1363,7 @@ extern struct callback_head balance_push_callback;
  */
 static inline void rq_pin_lock(struct rq *rq, struct rq_flags *rf)
 {
-	rf->cookie = lockdep_pin_lock(rq_lockp(rq));
+	rf->cookie = lockdep_pin_lock(__rq_lockp(rq));
 
 #ifdef CONFIG_SCHED_DEBUG
 	rq->clock_update_flags &= (RQCF_REQ_SKIP|RQCF_ACT_SKIP);
@@ -1364,12 +1381,12 @@ static inline void rq_unpin_lock(struct rq *rq, struct rq_flags *rf)
 		rf->clock_update_flags = RQCF_UPDATED;
 #endif
 
-	lockdep_unpin_lock(rq_lockp(rq), rf->cookie);
+	lockdep_unpin_lock(__rq_lockp(rq), rf->cookie);
 }
 
 static inline void rq_repin_lock(struct rq *rq, struct rq_flags *rf)
 {
-	lockdep_repin_lock(rq_lockp(rq), rf->cookie);
+	lockdep_repin_lock(__rq_lockp(rq), rf->cookie);
 
 #ifdef CONFIG_SCHED_DEBUG
 	/*
@@ -2338,7 +2355,7 @@ static inline int _double_lock_balance(struct rq *this_rq, struct rq *busiest)
 	__acquires(busiest->lock)
 	__acquires(this_rq->lock)
 {
-	if (rq_lockp(this_rq) == rq_lockp(busiest))
+	if (__rq_lockp(this_rq) == __rq_lockp(busiest))
 		return 0;
 
 	if (likely(raw_spin_rq_trylock(busiest)))
@@ -2370,9 +2387,9 @@ static inline int double_lock_balance(struct rq *this_rq, struct rq *busiest)
 static inline void double_unlock_balance(struct rq *this_rq, struct rq *busiest)
 	__releases(busiest->lock)
 {
-	if (rq_lockp(this_rq) != rq_lockp(busiest))
+	if (__rq_lockp(this_rq) != __rq_lockp(busiest))
 		raw_spin_rq_unlock(busiest);
-	lock_set_subclass(&rq_lockp(this_rq)->dep_map, 0, _RET_IP_);
+	lock_set_subclass(&__rq_lockp(this_rq)->dep_map, 0, _RET_IP_);
 }
 
 static inline void double_lock(spinlock_t *l1, spinlock_t *l2)
@@ -2412,7 +2429,7 @@ static inline void double_rq_unlock(struct rq *rq1, struct rq *rq2)
 	__releases(rq1->lock)
 	__releases(rq2->lock)
 {
-	if (rq_lockp(rq1) != rq_lockp(rq2))
+	if (__rq_lockp(rq1) != __rq_lockp(rq2))
 		raw_spin_rq_unlock(rq2);
 	else
 		__release(rq2->lock);
