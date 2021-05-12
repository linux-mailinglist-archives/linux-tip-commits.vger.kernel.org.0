Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 440F337BA6A
	for <lists+linux-tip-commits@lfdr.de>; Wed, 12 May 2021 12:28:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230479AbhELK3p (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 12 May 2021 06:29:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230406AbhELK3h (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 12 May 2021 06:29:37 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B801C061574;
        Wed, 12 May 2021 03:28:29 -0700 (PDT)
Date:   Wed, 12 May 2021 10:28:27 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1620815308;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Viq1vQL8eM1PSyMixJ/5wA7nMplKr+0y9LoSh0R3jJ0=;
        b=I70wlXyL0+lyqjjaDnaQSTZACJg3G6U82m8/YkkLYfQbKpmhk3uF8lFfZZPvBWsUzPVF4Z
        8Mx1+aS+mhzgdzhde3qRXuhPEmPia7CKtwagVRlyoXBnXGLuPDMR+jr7UuKkaI9pwH7V5T
        A8C//492A3f9Z028yNaIAWrB+pZsecSrdD/AEl6oo5W/JywHRXF0cgB9WupvZ227JihIvX
        sS0RQkCrsb93LXOIbenOdnYPkVz6YFAJufxj9NxcKDSQ6LZiZLh/PUofvdpHeUSl1ECEXM
        88QdWTjQ5N3dt3Dn6xMcwN4lDXaol6xKDUPLswtWjTSXqJ/5mCu89KaoT/WtJA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1620815308;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Viq1vQL8eM1PSyMixJ/5wA7nMplKr+0y9LoSh0R3jJ0=;
        b=47YjmCJD05XtROZAh1Vvz3aAX/8lHLOeyjaJwuDiafsHrnht/yAGL8vfqokwQMkDZiZh5A
        i8MHOF3cgM17xTCA==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched: Wrap rq::lock access
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Don Hiatt <dhiatt@digitalocean.com>,
        Hongyu Ning <hongyu.ning@linux.intel.com>,
        Vincent Guittot <vincent.guittot@linaro.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210422123308.136465446@infradead.org>
References: <20210422123308.136465446@infradead.org>
MIME-Version: 1.0
Message-ID: <162081530743.29796.9156339686366373082.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     5cb9eaa3d274f75539077a28cf01e3563195fa53
Gitweb:        https://git.kernel.org/tip/5cb9eaa3d274f75539077a28cf01e3563195fa53
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Tue, 17 Nov 2020 18:19:31 -05:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 12 May 2021 11:43:26 +02:00

sched: Wrap rq::lock access

In preparation of playing games with rq->lock, abstract the thing
using an accessor.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Tested-by: Don Hiatt <dhiatt@digitalocean.com>
Tested-by: Hongyu Ning <hongyu.ning@linux.intel.com>
Tested-by: Vincent Guittot <vincent.guittot@linaro.org>
Link: https://lkml.kernel.org/r/20210422123308.136465446@infradead.org
---
 kernel/sched/core.c     |  70 +++++++++++++-------------
 kernel/sched/cpuacct.c  |  12 ++--
 kernel/sched/deadline.c |  22 ++++----
 kernel/sched/debug.c    |   4 +-
 kernel/sched/fair.c     |  35 ++++++-------
 kernel/sched/idle.c     |   4 +-
 kernel/sched/pelt.h     |   2 +-
 kernel/sched/rt.c       |  16 +++---
 kernel/sched/sched.h    | 105 +++++++++++++++++++--------------------
 kernel/sched/topology.c |   4 +-
 10 files changed, 136 insertions(+), 138 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 5568018..5e6f5f5 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -211,12 +211,12 @@ struct rq *__task_rq_lock(struct task_struct *p, struct rq_flags *rf)
 
 	for (;;) {
 		rq = task_rq(p);
-		raw_spin_lock(&rq->lock);
+		raw_spin_rq_lock(rq);
 		if (likely(rq == task_rq(p) && !task_on_rq_migrating(p))) {
 			rq_pin_lock(rq, rf);
 			return rq;
 		}
-		raw_spin_unlock(&rq->lock);
+		raw_spin_rq_unlock(rq);
 
 		while (unlikely(task_on_rq_migrating(p)))
 			cpu_relax();
@@ -235,7 +235,7 @@ struct rq *task_rq_lock(struct task_struct *p, struct rq_flags *rf)
 	for (;;) {
 		raw_spin_lock_irqsave(&p->pi_lock, rf->flags);
 		rq = task_rq(p);
-		raw_spin_lock(&rq->lock);
+		raw_spin_rq_lock(rq);
 		/*
 		 *	move_queued_task()		task_rq_lock()
 		 *
@@ -257,7 +257,7 @@ struct rq *task_rq_lock(struct task_struct *p, struct rq_flags *rf)
 			rq_pin_lock(rq, rf);
 			return rq;
 		}
-		raw_spin_unlock(&rq->lock);
+		raw_spin_rq_unlock(rq);
 		raw_spin_unlock_irqrestore(&p->pi_lock, rf->flags);
 
 		while (unlikely(task_on_rq_migrating(p)))
@@ -327,7 +327,7 @@ void update_rq_clock(struct rq *rq)
 {
 	s64 delta;
 
-	lockdep_assert_held(&rq->lock);
+	lockdep_assert_rq_held(rq);
 
 	if (rq->clock_update_flags & RQCF_ACT_SKIP)
 		return;
@@ -625,7 +625,7 @@ void resched_curr(struct rq *rq)
 	struct task_struct *curr = rq->curr;
 	int cpu;
 
-	lockdep_assert_held(&rq->lock);
+	lockdep_assert_rq_held(rq);
 
 	if (test_tsk_need_resched(curr))
 		return;
@@ -649,10 +649,10 @@ void resched_cpu(int cpu)
 	struct rq *rq = cpu_rq(cpu);
 	unsigned long flags;
 
-	raw_spin_lock_irqsave(&rq->lock, flags);
+	raw_spin_rq_lock_irqsave(rq, flags);
 	if (cpu_online(cpu) || cpu == smp_processor_id())
 		resched_curr(rq);
-	raw_spin_unlock_irqrestore(&rq->lock, flags);
+	raw_spin_rq_unlock_irqrestore(rq, flags);
 }
 
 #ifdef CONFIG_SMP
@@ -1151,7 +1151,7 @@ static inline void uclamp_rq_inc_id(struct rq *rq, struct task_struct *p,
 	struct uclamp_se *uc_se = &p->uclamp[clamp_id];
 	struct uclamp_bucket *bucket;
 
-	lockdep_assert_held(&rq->lock);
+	lockdep_assert_rq_held(rq);
 
 	/* Update task effective clamp */
 	p->uclamp[clamp_id] = uclamp_eff_get(p, clamp_id);
@@ -1191,7 +1191,7 @@ static inline void uclamp_rq_dec_id(struct rq *rq, struct task_struct *p,
 	unsigned int bkt_clamp;
 	unsigned int rq_clamp;
 
-	lockdep_assert_held(&rq->lock);
+	lockdep_assert_rq_held(rq);
 
 	/*
 	 * If sched_uclamp_used was enabled after task @p was enqueued,
@@ -1864,7 +1864,7 @@ static inline bool is_cpu_allowed(struct task_struct *p, int cpu)
 static struct rq *move_queued_task(struct rq *rq, struct rq_flags *rf,
 				   struct task_struct *p, int new_cpu)
 {
-	lockdep_assert_held(&rq->lock);
+	lockdep_assert_rq_held(rq);
 
 	deactivate_task(rq, p, DEQUEUE_NOCLOCK);
 	set_task_cpu(p, new_cpu);
@@ -2038,7 +2038,7 @@ int push_cpu_stop(void *arg)
 	struct task_struct *p = arg;
 
 	raw_spin_lock_irq(&p->pi_lock);
-	raw_spin_lock(&rq->lock);
+	raw_spin_rq_lock(rq);
 
 	if (task_rq(p) != rq)
 		goto out_unlock;
@@ -2068,7 +2068,7 @@ int push_cpu_stop(void *arg)
 
 out_unlock:
 	rq->push_busy = false;
-	raw_spin_unlock(&rq->lock);
+	raw_spin_rq_unlock(rq);
 	raw_spin_unlock_irq(&p->pi_lock);
 
 	put_task_struct(p);
@@ -2121,7 +2121,7 @@ __do_set_cpus_allowed(struct task_struct *p, const struct cpumask *new_mask, u32
 		 * Because __kthread_bind() calls this on blocked tasks without
 		 * holding rq->lock.
 		 */
-		lockdep_assert_held(&rq->lock);
+		lockdep_assert_rq_held(rq);
 		dequeue_task(rq, p, DEQUEUE_SAVE | DEQUEUE_NOCLOCK);
 	}
 	if (running)
@@ -2462,7 +2462,7 @@ void set_task_cpu(struct task_struct *p, unsigned int new_cpu)
 	 * task_rq_lock().
 	 */
 	WARN_ON_ONCE(debug_locks && !(lockdep_is_held(&p->pi_lock) ||
-				      lockdep_is_held(&task_rq(p)->lock)));
+				      lockdep_is_held(rq_lockp(task_rq(p)))));
 #endif
 	/*
 	 * Clearly, migrating tasks to offline CPUs is a fairly daft thing.
@@ -3004,7 +3004,7 @@ ttwu_do_activate(struct rq *rq, struct task_struct *p, int wake_flags,
 {
 	int en_flags = ENQUEUE_WAKEUP | ENQUEUE_NOCLOCK;
 
-	lockdep_assert_held(&rq->lock);
+	lockdep_assert_rq_held(rq);
 
 	if (p->sched_contributes_to_load)
 		rq->nr_uninterruptible--;
@@ -4015,7 +4015,7 @@ static void do_balance_callbacks(struct rq *rq, struct callback_head *head)
 	void (*func)(struct rq *rq);
 	struct callback_head *next;
 
-	lockdep_assert_held(&rq->lock);
+	lockdep_assert_rq_held(rq);
 
 	while (head) {
 		func = (void (*)(struct rq *))head->func;
@@ -4038,7 +4038,7 @@ static inline struct callback_head *splice_balance_callbacks(struct rq *rq)
 {
 	struct callback_head *head = rq->balance_callback;
 
-	lockdep_assert_held(&rq->lock);
+	lockdep_assert_rq_held(rq);
 	if (head)
 		rq->balance_callback = NULL;
 
@@ -4055,9 +4055,9 @@ static inline void balance_callbacks(struct rq *rq, struct callback_head *head)
 	unsigned long flags;
 
 	if (unlikely(head)) {
-		raw_spin_lock_irqsave(&rq->lock, flags);
+		raw_spin_rq_lock_irqsave(rq, flags);
 		do_balance_callbacks(rq, head);
-		raw_spin_unlock_irqrestore(&rq->lock, flags);
+		raw_spin_rq_unlock_irqrestore(rq, flags);
 	}
 }
 
@@ -4088,10 +4088,10 @@ prepare_lock_switch(struct rq *rq, struct task_struct *next, struct rq_flags *rf
 	 * do an early lockdep release here:
 	 */
 	rq_unpin_lock(rq, rf);
-	spin_release(&rq->lock.dep_map, _THIS_IP_);
+	spin_release(&rq_lockp(rq)->dep_map, _THIS_IP_);
 #ifdef CONFIG_DEBUG_SPINLOCK
 	/* this is a valid case when another task releases the spinlock */
-	rq->lock.owner = next;
+	rq_lockp(rq)->owner = next;
 #endif
 }
 
@@ -4102,9 +4102,9 @@ static inline void finish_lock_switch(struct rq *rq)
 	 * fix up the runqueue lock - which gets 'carried over' from
 	 * prev into current:
 	 */
-	spin_acquire(&rq->lock.dep_map, 0, 0, _THIS_IP_);
+	spin_acquire(&rq_lockp(rq)->dep_map, 0, 0, _THIS_IP_);
 	__balance_callbacks(rq);
-	raw_spin_unlock_irq(&rq->lock);
+	raw_spin_rq_unlock_irq(rq);
 }
 
 /*
@@ -5164,7 +5164,7 @@ static void __sched notrace __schedule(bool preempt)
 
 		rq_unpin_lock(rq, &rf);
 		__balance_callbacks(rq);
-		raw_spin_unlock_irq(&rq->lock);
+		raw_spin_rq_unlock_irq(rq);
 	}
 }
 
@@ -5706,7 +5706,7 @@ out_unlock:
 
 	rq_unpin_lock(rq, &rf);
 	__balance_callbacks(rq);
-	raw_spin_unlock(&rq->lock);
+	raw_spin_rq_unlock(rq);
 
 	preempt_enable();
 }
@@ -7456,7 +7456,7 @@ void init_idle(struct task_struct *idle, int cpu)
 	__sched_fork(0, idle);
 
 	raw_spin_lock_irqsave(&idle->pi_lock, flags);
-	raw_spin_lock(&rq->lock);
+	raw_spin_rq_lock(rq);
 
 	idle->state = TASK_RUNNING;
 	idle->se.exec_start = sched_clock();
@@ -7494,7 +7494,7 @@ void init_idle(struct task_struct *idle, int cpu)
 #ifdef CONFIG_SMP
 	idle->on_cpu = 1;
 #endif
-	raw_spin_unlock(&rq->lock);
+	raw_spin_rq_unlock(rq);
 	raw_spin_unlock_irqrestore(&idle->pi_lock, flags);
 
 	/* Set the preempt count _outside_ the spinlocks! */
@@ -7660,7 +7660,7 @@ static void balance_push(struct rq *rq)
 {
 	struct task_struct *push_task = rq->curr;
 
-	lockdep_assert_held(&rq->lock);
+	lockdep_assert_rq_held(rq);
 	SCHED_WARN_ON(rq->cpu != smp_processor_id());
 
 	/*
@@ -7698,9 +7698,9 @@ static void balance_push(struct rq *rq)
 		 */
 		if (!rq->nr_running && !rq_has_pinned_tasks(rq) &&
 		    rcuwait_active(&rq->hotplug_wait)) {
-			raw_spin_unlock(&rq->lock);
+			raw_spin_rq_unlock(rq);
 			rcuwait_wake_up(&rq->hotplug_wait);
-			raw_spin_lock(&rq->lock);
+			raw_spin_rq_lock(rq);
 		}
 		return;
 	}
@@ -7710,7 +7710,7 @@ static void balance_push(struct rq *rq)
 	 * Temporarily drop rq->lock such that we can wake-up the stop task.
 	 * Both preemption and IRQs are still disabled.
 	 */
-	raw_spin_unlock(&rq->lock);
+	raw_spin_rq_unlock(rq);
 	stop_one_cpu_nowait(rq->cpu, __balance_push_cpu_stop, push_task,
 			    this_cpu_ptr(&push_work));
 	/*
@@ -7718,7 +7718,7 @@ static void balance_push(struct rq *rq)
 	 * schedule(). The next pick is obviously going to be the stop task
 	 * which kthread_is_per_cpu() and will push this task away.
 	 */
-	raw_spin_lock(&rq->lock);
+	raw_spin_rq_lock(rq);
 }
 
 static void balance_push_set(int cpu, bool on)
@@ -8008,7 +8008,7 @@ static void dump_rq_tasks(struct rq *rq, const char *loglvl)
 	struct task_struct *g, *p;
 	int cpu = cpu_of(rq);
 
-	lockdep_assert_held(&rq->lock);
+	lockdep_assert_rq_held(rq);
 
 	printk("%sCPU%d enqueued tasks (%u total):\n", loglvl, cpu, rq->nr_running);
 	for_each_process_thread(g, p) {
@@ -8181,7 +8181,7 @@ void __init sched_init(void)
 		struct rq *rq;
 
 		rq = cpu_rq(i);
-		raw_spin_lock_init(&rq->lock);
+		raw_spin_lock_init(&rq->__lock);
 		rq->nr_running = 0;
 		rq->calc_load_active = 0;
 		rq->calc_load_update = jiffies + LOAD_FREQ;
diff --git a/kernel/sched/cpuacct.c b/kernel/sched/cpuacct.c
index 104a1ba..893eece 100644
--- a/kernel/sched/cpuacct.c
+++ b/kernel/sched/cpuacct.c
@@ -112,7 +112,7 @@ static u64 cpuacct_cpuusage_read(struct cpuacct *ca, int cpu,
 	/*
 	 * Take rq->lock to make 64-bit read safe on 32-bit platforms.
 	 */
-	raw_spin_lock_irq(&cpu_rq(cpu)->lock);
+	raw_spin_rq_lock_irq(cpu_rq(cpu));
 #endif
 
 	if (index == CPUACCT_STAT_NSTATS) {
@@ -126,7 +126,7 @@ static u64 cpuacct_cpuusage_read(struct cpuacct *ca, int cpu,
 	}
 
 #ifndef CONFIG_64BIT
-	raw_spin_unlock_irq(&cpu_rq(cpu)->lock);
+	raw_spin_rq_unlock_irq(cpu_rq(cpu));
 #endif
 
 	return data;
@@ -141,14 +141,14 @@ static void cpuacct_cpuusage_write(struct cpuacct *ca, int cpu, u64 val)
 	/*
 	 * Take rq->lock to make 64-bit write safe on 32-bit platforms.
 	 */
-	raw_spin_lock_irq(&cpu_rq(cpu)->lock);
+	raw_spin_rq_lock_irq(cpu_rq(cpu));
 #endif
 
 	for (i = 0; i < CPUACCT_STAT_NSTATS; i++)
 		cpuusage->usages[i] = val;
 
 #ifndef CONFIG_64BIT
-	raw_spin_unlock_irq(&cpu_rq(cpu)->lock);
+	raw_spin_rq_unlock_irq(cpu_rq(cpu));
 #endif
 }
 
@@ -253,13 +253,13 @@ static int cpuacct_all_seq_show(struct seq_file *m, void *V)
 			 * Take rq->lock to make 64-bit read safe on 32-bit
 			 * platforms.
 			 */
-			raw_spin_lock_irq(&cpu_rq(cpu)->lock);
+			raw_spin_rq_lock_irq(cpu_rq(cpu));
 #endif
 
 			seq_printf(m, " %llu", cpuusage->usages[index]);
 
 #ifndef CONFIG_64BIT
-			raw_spin_unlock_irq(&cpu_rq(cpu)->lock);
+			raw_spin_rq_unlock_irq(cpu_rq(cpu));
 #endif
 		}
 		seq_puts(m, "\n");
diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index 9a29897..6e99b8b 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -157,7 +157,7 @@ void __add_running_bw(u64 dl_bw, struct dl_rq *dl_rq)
 {
 	u64 old = dl_rq->running_bw;
 
-	lockdep_assert_held(&(rq_of_dl_rq(dl_rq))->lock);
+	lockdep_assert_rq_held(rq_of_dl_rq(dl_rq));
 	dl_rq->running_bw += dl_bw;
 	SCHED_WARN_ON(dl_rq->running_bw < old); /* overflow */
 	SCHED_WARN_ON(dl_rq->running_bw > dl_rq->this_bw);
@@ -170,7 +170,7 @@ void __sub_running_bw(u64 dl_bw, struct dl_rq *dl_rq)
 {
 	u64 old = dl_rq->running_bw;
 
-	lockdep_assert_held(&(rq_of_dl_rq(dl_rq))->lock);
+	lockdep_assert_rq_held(rq_of_dl_rq(dl_rq));
 	dl_rq->running_bw -= dl_bw;
 	SCHED_WARN_ON(dl_rq->running_bw > old); /* underflow */
 	if (dl_rq->running_bw > old)
@@ -184,7 +184,7 @@ void __add_rq_bw(u64 dl_bw, struct dl_rq *dl_rq)
 {
 	u64 old = dl_rq->this_bw;
 
-	lockdep_assert_held(&(rq_of_dl_rq(dl_rq))->lock);
+	lockdep_assert_rq_held(rq_of_dl_rq(dl_rq));
 	dl_rq->this_bw += dl_bw;
 	SCHED_WARN_ON(dl_rq->this_bw < old); /* overflow */
 }
@@ -194,7 +194,7 @@ void __sub_rq_bw(u64 dl_bw, struct dl_rq *dl_rq)
 {
 	u64 old = dl_rq->this_bw;
 
-	lockdep_assert_held(&(rq_of_dl_rq(dl_rq))->lock);
+	lockdep_assert_rq_held(rq_of_dl_rq(dl_rq));
 	dl_rq->this_bw -= dl_bw;
 	SCHED_WARN_ON(dl_rq->this_bw > old); /* underflow */
 	if (dl_rq->this_bw > old)
@@ -987,7 +987,7 @@ static int start_dl_timer(struct task_struct *p)
 	ktime_t now, act;
 	s64 delta;
 
-	lockdep_assert_held(&rq->lock);
+	lockdep_assert_rq_held(rq);
 
 	/*
 	 * We want the timer to fire at the deadline, but considering
@@ -1097,9 +1097,9 @@ static enum hrtimer_restart dl_task_timer(struct hrtimer *timer)
 		 * If the runqueue is no longer available, migrate the
 		 * task elsewhere. This necessarily changes rq.
 		 */
-		lockdep_unpin_lock(&rq->lock, rf.cookie);
+		lockdep_unpin_lock(rq_lockp(rq), rf.cookie);
 		rq = dl_task_offline_migration(rq, p);
-		rf.cookie = lockdep_pin_lock(&rq->lock);
+		rf.cookie = lockdep_pin_lock(rq_lockp(rq));
 		update_rq_clock(rq);
 
 		/*
@@ -1731,7 +1731,7 @@ static void migrate_task_rq_dl(struct task_struct *p, int new_cpu __maybe_unused
 	 * from try_to_wake_up(). Hence, p->pi_lock is locked, but
 	 * rq->lock is not... So, lock it
 	 */
-	raw_spin_lock(&rq->lock);
+	raw_spin_rq_lock(rq);
 	if (p->dl.dl_non_contending) {
 		sub_running_bw(&p->dl, &rq->dl);
 		p->dl.dl_non_contending = 0;
@@ -1746,7 +1746,7 @@ static void migrate_task_rq_dl(struct task_struct *p, int new_cpu __maybe_unused
 			put_task_struct(p);
 	}
 	sub_rq_bw(&p->dl, &rq->dl);
-	raw_spin_unlock(&rq->lock);
+	raw_spin_rq_unlock(rq);
 }
 
 static void check_preempt_equal_dl(struct rq *rq, struct task_struct *p)
@@ -2291,10 +2291,10 @@ skip:
 		double_unlock_balance(this_rq, src_rq);
 
 		if (push_task) {
-			raw_spin_unlock(&this_rq->lock);
+			raw_spin_rq_unlock(this_rq);
 			stop_one_cpu_nowait(src_rq->cpu, push_cpu_stop,
 					    push_task, &src_rq->push_work);
-			raw_spin_lock(&this_rq->lock);
+			raw_spin_rq_lock(this_rq);
 		}
 	}
 
diff --git a/kernel/sched/debug.c b/kernel/sched/debug.c
index 9c882f2..3bdee5f 100644
--- a/kernel/sched/debug.c
+++ b/kernel/sched/debug.c
@@ -576,7 +576,7 @@ void print_cfs_rq(struct seq_file *m, int cpu, struct cfs_rq *cfs_rq)
 	SEQ_printf(m, "  .%-30s: %Ld.%06ld\n", "exec_clock",
 			SPLIT_NS(cfs_rq->exec_clock));
 
-	raw_spin_lock_irqsave(&rq->lock, flags);
+	raw_spin_rq_lock_irqsave(rq, flags);
 	if (rb_first_cached(&cfs_rq->tasks_timeline))
 		MIN_vruntime = (__pick_first_entity(cfs_rq))->vruntime;
 	last = __pick_last_entity(cfs_rq);
@@ -584,7 +584,7 @@ void print_cfs_rq(struct seq_file *m, int cpu, struct cfs_rq *cfs_rq)
 		max_vruntime = last->vruntime;
 	min_vruntime = cfs_rq->min_vruntime;
 	rq0_min_vruntime = cpu_rq(0)->cfs.min_vruntime;
-	raw_spin_unlock_irqrestore(&rq->lock, flags);
+	raw_spin_rq_unlock_irqrestore(rq, flags);
 	SEQ_printf(m, "  .%-30s: %Ld.%06ld\n", "MIN_vruntime",
 			SPLIT_NS(MIN_vruntime));
 	SEQ_printf(m, "  .%-30s: %Ld.%06ld\n", "min_vruntime",
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 6bdbb7b..e50bd75 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -1107,7 +1107,7 @@ struct numa_group {
 static struct numa_group *deref_task_numa_group(struct task_struct *p)
 {
 	return rcu_dereference_check(p->numa_group, p == current ||
-		(lockdep_is_held(&task_rq(p)->lock) && !READ_ONCE(p->on_cpu)));
+		(lockdep_is_held(rq_lockp(task_rq(p))) && !READ_ONCE(p->on_cpu)));
 }
 
 static struct numa_group *deref_curr_numa_group(struct task_struct *p)
@@ -5328,7 +5328,7 @@ static void __maybe_unused update_runtime_enabled(struct rq *rq)
 {
 	struct task_group *tg;
 
-	lockdep_assert_held(&rq->lock);
+	lockdep_assert_rq_held(rq);
 
 	rcu_read_lock();
 	list_for_each_entry_rcu(tg, &task_groups, list) {
@@ -5347,7 +5347,7 @@ static void __maybe_unused unthrottle_offline_cfs_rqs(struct rq *rq)
 {
 	struct task_group *tg;
 
-	lockdep_assert_held(&rq->lock);
+	lockdep_assert_rq_held(rq);
 
 	rcu_read_lock();
 	list_for_each_entry_rcu(tg, &task_groups, list) {
@@ -6891,7 +6891,7 @@ static void migrate_task_rq_fair(struct task_struct *p, int new_cpu)
 		 * In case of TASK_ON_RQ_MIGRATING we in fact hold the 'old'
 		 * rq->lock and can modify state directly.
 		 */
-		lockdep_assert_held(&task_rq(p)->lock);
+		lockdep_assert_rq_held(task_rq(p));
 		detach_entity_cfs_rq(&p->se);
 
 	} else {
@@ -7518,7 +7518,7 @@ static int task_hot(struct task_struct *p, struct lb_env *env)
 {
 	s64 delta;
 
-	lockdep_assert_held(&env->src_rq->lock);
+	lockdep_assert_rq_held(env->src_rq);
 
 	if (p->sched_class != &fair_sched_class)
 		return 0;
@@ -7616,7 +7616,7 @@ int can_migrate_task(struct task_struct *p, struct lb_env *env)
 {
 	int tsk_cache_hot;
 
-	lockdep_assert_held(&env->src_rq->lock);
+	lockdep_assert_rq_held(env->src_rq);
 
 	/*
 	 * We do not migrate tasks that are:
@@ -7705,7 +7705,7 @@ int can_migrate_task(struct task_struct *p, struct lb_env *env)
  */
 static void detach_task(struct task_struct *p, struct lb_env *env)
 {
-	lockdep_assert_held(&env->src_rq->lock);
+	lockdep_assert_rq_held(env->src_rq);
 
 	deactivate_task(env->src_rq, p, DEQUEUE_NOCLOCK);
 	set_task_cpu(p, env->dst_cpu);
@@ -7721,7 +7721,7 @@ static struct task_struct *detach_one_task(struct lb_env *env)
 {
 	struct task_struct *p;
 
-	lockdep_assert_held(&env->src_rq->lock);
+	lockdep_assert_rq_held(env->src_rq);
 
 	list_for_each_entry_reverse(p,
 			&env->src_rq->cfs_tasks, se.group_node) {
@@ -7757,7 +7757,7 @@ static int detach_tasks(struct lb_env *env)
 	struct task_struct *p;
 	int detached = 0;
 
-	lockdep_assert_held(&env->src_rq->lock);
+	lockdep_assert_rq_held(env->src_rq);
 
 	/*
 	 * Source run queue has been emptied by another CPU, clear
@@ -7887,7 +7887,7 @@ next:
  */
 static void attach_task(struct rq *rq, struct task_struct *p)
 {
-	lockdep_assert_held(&rq->lock);
+	lockdep_assert_rq_held(rq);
 
 	BUG_ON(task_rq(p) != rq);
 	activate_task(rq, p, ENQUEUE_NOCLOCK);
@@ -9798,7 +9798,7 @@ more_balance:
 		if (need_active_balance(&env)) {
 			unsigned long flags;
 
-			raw_spin_lock_irqsave(&busiest->lock, flags);
+			raw_spin_rq_lock_irqsave(busiest, flags);
 
 			/*
 			 * Don't kick the active_load_balance_cpu_stop,
@@ -9806,8 +9806,7 @@ more_balance:
 			 * moved to this_cpu:
 			 */
 			if (!cpumask_test_cpu(this_cpu, busiest->curr->cpus_ptr)) {
-				raw_spin_unlock_irqrestore(&busiest->lock,
-							    flags);
+				raw_spin_rq_unlock_irqrestore(busiest, flags);
 				goto out_one_pinned;
 			}
 
@@ -9824,7 +9823,7 @@ more_balance:
 				busiest->push_cpu = this_cpu;
 				active_balance = 1;
 			}
-			raw_spin_unlock_irqrestore(&busiest->lock, flags);
+			raw_spin_rq_unlock_irqrestore(busiest, flags);
 
 			if (active_balance) {
 				stop_one_cpu_nowait(cpu_of(busiest),
@@ -10649,7 +10648,7 @@ static int newidle_balance(struct rq *this_rq, struct rq_flags *rf)
 		goto out;
 	}
 
-	raw_spin_unlock(&this_rq->lock);
+	raw_spin_rq_unlock(this_rq);
 
 	update_blocked_averages(this_cpu);
 	rcu_read_lock();
@@ -10688,7 +10687,7 @@ static int newidle_balance(struct rq *this_rq, struct rq_flags *rf)
 	}
 	rcu_read_unlock();
 
-	raw_spin_lock(&this_rq->lock);
+	raw_spin_rq_lock(this_rq);
 
 	if (curr_cost > this_rq->max_idle_balance_cost)
 		this_rq->max_idle_balance_cost = curr_cost;
@@ -11175,9 +11174,9 @@ void unregister_fair_sched_group(struct task_group *tg)
 
 		rq = cpu_rq(cpu);
 
-		raw_spin_lock_irqsave(&rq->lock, flags);
+		raw_spin_rq_lock_irqsave(rq, flags);
 		list_del_leaf_cfs_rq(tg->cfs_rq[cpu]);
-		raw_spin_unlock_irqrestore(&rq->lock, flags);
+		raw_spin_rq_unlock_irqrestore(rq, flags);
 	}
 }
 
diff --git a/kernel/sched/idle.c b/kernel/sched/idle.c
index 7ca3d3d..0194768 100644
--- a/kernel/sched/idle.c
+++ b/kernel/sched/idle.c
@@ -455,10 +455,10 @@ struct task_struct *pick_next_task_idle(struct rq *rq)
 static void
 dequeue_task_idle(struct rq *rq, struct task_struct *p, int flags)
 {
-	raw_spin_unlock_irq(&rq->lock);
+	raw_spin_rq_unlock_irq(rq);
 	printk(KERN_ERR "bad: scheduling from the idle thread!\n");
 	dump_stack();
-	raw_spin_lock_irq(&rq->lock);
+	raw_spin_rq_lock_irq(rq);
 }
 
 /*
diff --git a/kernel/sched/pelt.h b/kernel/sched/pelt.h
index 1462846..9ed6d8c 100644
--- a/kernel/sched/pelt.h
+++ b/kernel/sched/pelt.h
@@ -141,7 +141,7 @@ static inline void update_idle_rq_clock_pelt(struct rq *rq)
 
 static inline u64 rq_clock_pelt(struct rq *rq)
 {
-	lockdep_assert_held(&rq->lock);
+	lockdep_assert_rq_held(rq);
 	assert_clock_updated(rq);
 
 	return rq->clock_pelt - rq->lost_idle_time;
diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
index c286e5b..b3d39c3 100644
--- a/kernel/sched/rt.c
+++ b/kernel/sched/rt.c
@@ -888,7 +888,7 @@ static int do_sched_rt_period_timer(struct rt_bandwidth *rt_b, int overrun)
 		if (skip)
 			continue;
 
-		raw_spin_lock(&rq->lock);
+		raw_spin_rq_lock(rq);
 		update_rq_clock(rq);
 
 		if (rt_rq->rt_time) {
@@ -926,7 +926,7 @@ static int do_sched_rt_period_timer(struct rt_bandwidth *rt_b, int overrun)
 
 		if (enqueue)
 			sched_rt_rq_enqueue(rt_rq);
-		raw_spin_unlock(&rq->lock);
+		raw_spin_rq_unlock(rq);
 	}
 
 	if (!throttled && (!rt_bandwidth_enabled() || rt_b->rt_runtime == RUNTIME_INF))
@@ -1894,10 +1894,10 @@ retry:
 		 */
 		push_task = get_push_task(rq);
 		if (push_task) {
-			raw_spin_unlock(&rq->lock);
+			raw_spin_rq_unlock(rq);
 			stop_one_cpu_nowait(rq->cpu, push_cpu_stop,
 					    push_task, &rq->push_work);
-			raw_spin_lock(&rq->lock);
+			raw_spin_rq_lock(rq);
 		}
 
 		return 0;
@@ -2122,10 +2122,10 @@ void rto_push_irq_work_func(struct irq_work *work)
 	 * When it gets updated, a check is made if a push is possible.
 	 */
 	if (has_pushable_tasks(rq)) {
-		raw_spin_lock(&rq->lock);
+		raw_spin_rq_lock(rq);
 		while (push_rt_task(rq, true))
 			;
-		raw_spin_unlock(&rq->lock);
+		raw_spin_rq_unlock(rq);
 	}
 
 	raw_spin_lock(&rd->rto_lock);
@@ -2243,10 +2243,10 @@ skip:
 		double_unlock_balance(this_rq, src_rq);
 
 		if (push_task) {
-			raw_spin_unlock(&this_rq->lock);
+			raw_spin_rq_unlock(this_rq);
 			stop_one_cpu_nowait(src_rq->cpu, push_cpu_stop,
 					    push_task, &src_rq->push_work);
-			raw_spin_lock(&this_rq->lock);
+			raw_spin_rq_lock(this_rq);
 		}
 	}
 
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index f654587..dbabf28 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -905,7 +905,7 @@ DECLARE_STATIC_KEY_FALSE(sched_uclamp_used);
  */
 struct rq {
 	/* runqueue lock: */
-	raw_spinlock_t		lock;
+	raw_spinlock_t		__lock;
 
 	/*
 	 * nr_running and cpu_load should be in the same cacheline because
@@ -1115,7 +1115,7 @@ static inline bool is_migration_disabled(struct task_struct *p)
 
 static inline raw_spinlock_t *rq_lockp(struct rq *rq)
 {
-	return &rq->lock;
+	return &rq->__lock;
 }
 
 static inline void lockdep_assert_rq_held(struct rq *rq)
@@ -1229,7 +1229,7 @@ static inline void assert_clock_updated(struct rq *rq)
 
 static inline u64 rq_clock(struct rq *rq)
 {
-	lockdep_assert_held(&rq->lock);
+	lockdep_assert_rq_held(rq);
 	assert_clock_updated(rq);
 
 	return rq->clock;
@@ -1237,7 +1237,7 @@ static inline u64 rq_clock(struct rq *rq)
 
 static inline u64 rq_clock_task(struct rq *rq)
 {
-	lockdep_assert_held(&rq->lock);
+	lockdep_assert_rq_held(rq);
 	assert_clock_updated(rq);
 
 	return rq->clock_task;
@@ -1263,7 +1263,7 @@ static inline u64 rq_clock_thermal(struct rq *rq)
 
 static inline void rq_clock_skip_update(struct rq *rq)
 {
-	lockdep_assert_held(&rq->lock);
+	lockdep_assert_rq_held(rq);
 	rq->clock_update_flags |= RQCF_REQ_SKIP;
 }
 
@@ -1273,7 +1273,7 @@ static inline void rq_clock_skip_update(struct rq *rq)
  */
 static inline void rq_clock_cancel_skipupdate(struct rq *rq)
 {
-	lockdep_assert_held(&rq->lock);
+	lockdep_assert_rq_held(rq);
 	rq->clock_update_flags &= ~RQCF_REQ_SKIP;
 }
 
@@ -1304,7 +1304,7 @@ extern struct callback_head balance_push_callback;
  */
 static inline void rq_pin_lock(struct rq *rq, struct rq_flags *rf)
 {
-	rf->cookie = lockdep_pin_lock(&rq->lock);
+	rf->cookie = lockdep_pin_lock(rq_lockp(rq));
 
 #ifdef CONFIG_SCHED_DEBUG
 	rq->clock_update_flags &= (RQCF_REQ_SKIP|RQCF_ACT_SKIP);
@@ -1322,12 +1322,12 @@ static inline void rq_unpin_lock(struct rq *rq, struct rq_flags *rf)
 		rf->clock_update_flags = RQCF_UPDATED;
 #endif
 
-	lockdep_unpin_lock(&rq->lock, rf->cookie);
+	lockdep_unpin_lock(rq_lockp(rq), rf->cookie);
 }
 
 static inline void rq_repin_lock(struct rq *rq, struct rq_flags *rf)
 {
-	lockdep_repin_lock(&rq->lock, rf->cookie);
+	lockdep_repin_lock(rq_lockp(rq), rf->cookie);
 
 #ifdef CONFIG_SCHED_DEBUG
 	/*
@@ -1348,7 +1348,7 @@ static inline void __task_rq_unlock(struct rq *rq, struct rq_flags *rf)
 	__releases(rq->lock)
 {
 	rq_unpin_lock(rq, rf);
-	raw_spin_unlock(&rq->lock);
+	raw_spin_rq_unlock(rq);
 }
 
 static inline void
@@ -1357,7 +1357,7 @@ task_rq_unlock(struct rq *rq, struct task_struct *p, struct rq_flags *rf)
 	__releases(p->pi_lock)
 {
 	rq_unpin_lock(rq, rf);
-	raw_spin_unlock(&rq->lock);
+	raw_spin_rq_unlock(rq);
 	raw_spin_unlock_irqrestore(&p->pi_lock, rf->flags);
 }
 
@@ -1365,7 +1365,7 @@ static inline void
 rq_lock_irqsave(struct rq *rq, struct rq_flags *rf)
 	__acquires(rq->lock)
 {
-	raw_spin_lock_irqsave(&rq->lock, rf->flags);
+	raw_spin_rq_lock_irqsave(rq, rf->flags);
 	rq_pin_lock(rq, rf);
 }
 
@@ -1373,7 +1373,7 @@ static inline void
 rq_lock_irq(struct rq *rq, struct rq_flags *rf)
 	__acquires(rq->lock)
 {
-	raw_spin_lock_irq(&rq->lock);
+	raw_spin_rq_lock_irq(rq);
 	rq_pin_lock(rq, rf);
 }
 
@@ -1381,7 +1381,7 @@ static inline void
 rq_lock(struct rq *rq, struct rq_flags *rf)
 	__acquires(rq->lock)
 {
-	raw_spin_lock(&rq->lock);
+	raw_spin_rq_lock(rq);
 	rq_pin_lock(rq, rf);
 }
 
@@ -1389,7 +1389,7 @@ static inline void
 rq_relock(struct rq *rq, struct rq_flags *rf)
 	__acquires(rq->lock)
 {
-	raw_spin_lock(&rq->lock);
+	raw_spin_rq_lock(rq);
 	rq_repin_lock(rq, rf);
 }
 
@@ -1398,7 +1398,7 @@ rq_unlock_irqrestore(struct rq *rq, struct rq_flags *rf)
 	__releases(rq->lock)
 {
 	rq_unpin_lock(rq, rf);
-	raw_spin_unlock_irqrestore(&rq->lock, rf->flags);
+	raw_spin_rq_unlock_irqrestore(rq, rf->flags);
 }
 
 static inline void
@@ -1406,7 +1406,7 @@ rq_unlock_irq(struct rq *rq, struct rq_flags *rf)
 	__releases(rq->lock)
 {
 	rq_unpin_lock(rq, rf);
-	raw_spin_unlock_irq(&rq->lock);
+	raw_spin_rq_unlock_irq(rq);
 }
 
 static inline void
@@ -1414,7 +1414,7 @@ rq_unlock(struct rq *rq, struct rq_flags *rf)
 	__releases(rq->lock)
 {
 	rq_unpin_lock(rq, rf);
-	raw_spin_unlock(&rq->lock);
+	raw_spin_rq_unlock(rq);
 }
 
 static inline struct rq *
@@ -1479,7 +1479,7 @@ queue_balance_callback(struct rq *rq,
 		       struct callback_head *head,
 		       void (*func)(struct rq *rq))
 {
-	lockdep_assert_held(&rq->lock);
+	lockdep_assert_rq_held(rq);
 
 	if (unlikely(head->next || rq->balance_callback == &balance_push_callback))
 		return;
@@ -2019,7 +2019,7 @@ static inline struct task_struct *get_push_task(struct rq *rq)
 {
 	struct task_struct *p = rq->curr;
 
-	lockdep_assert_held(&rq->lock);
+	lockdep_assert_rq_held(rq);
 
 	if (rq->push_busy)
 		return NULL;
@@ -2249,7 +2249,7 @@ static inline int _double_lock_balance(struct rq *this_rq, struct rq *busiest)
 	__acquires(busiest->lock)
 	__acquires(this_rq->lock)
 {
-	raw_spin_unlock(&this_rq->lock);
+	raw_spin_rq_unlock(this_rq);
 	double_rq_lock(this_rq, busiest);
 
 	return 1;
@@ -2268,20 +2268,22 @@ static inline int _double_lock_balance(struct rq *this_rq, struct rq *busiest)
 	__acquires(busiest->lock)
 	__acquires(this_rq->lock)
 {
-	int ret = 0;
-
-	if (unlikely(!raw_spin_trylock(&busiest->lock))) {
-		if (busiest < this_rq) {
-			raw_spin_unlock(&this_rq->lock);
-			raw_spin_lock(&busiest->lock);
-			raw_spin_lock_nested(&this_rq->lock,
-					      SINGLE_DEPTH_NESTING);
-			ret = 1;
-		} else
-			raw_spin_lock_nested(&busiest->lock,
-					      SINGLE_DEPTH_NESTING);
+	if (rq_lockp(this_rq) == rq_lockp(busiest))
+		return 0;
+
+	if (likely(raw_spin_rq_trylock(busiest)))
+		return 0;
+
+	if (rq_lockp(busiest) >= rq_lockp(this_rq)) {
+		raw_spin_rq_lock_nested(busiest, SINGLE_DEPTH_NESTING);
+		return 0;
 	}
-	return ret;
+
+	raw_spin_rq_unlock(this_rq);
+	raw_spin_rq_lock(busiest);
+	raw_spin_rq_lock_nested(this_rq, SINGLE_DEPTH_NESTING);
+
+	return 1;
 }
 
 #endif /* CONFIG_PREEMPTION */
@@ -2291,11 +2293,7 @@ static inline int _double_lock_balance(struct rq *this_rq, struct rq *busiest)
  */
 static inline int double_lock_balance(struct rq *this_rq, struct rq *busiest)
 {
-	if (unlikely(!irqs_disabled())) {
-		/* printk() doesn't work well under rq->lock */
-		raw_spin_unlock(&this_rq->lock);
-		BUG_ON(1);
-	}
+	lockdep_assert_irqs_disabled();
 
 	return _double_lock_balance(this_rq, busiest);
 }
@@ -2303,8 +2301,9 @@ static inline int double_lock_balance(struct rq *this_rq, struct rq *busiest)
 static inline void double_unlock_balance(struct rq *this_rq, struct rq *busiest)
 	__releases(busiest->lock)
 {
-	raw_spin_unlock(&busiest->lock);
-	lock_set_subclass(&this_rq->lock.dep_map, 0, _RET_IP_);
+	if (rq_lockp(this_rq) != rq_lockp(busiest))
+		raw_spin_rq_unlock(busiest);
+	lock_set_subclass(&rq_lockp(this_rq)->dep_map, 0, _RET_IP_);
 }
 
 static inline void double_lock(spinlock_t *l1, spinlock_t *l2)
@@ -2345,16 +2344,16 @@ static inline void double_rq_lock(struct rq *rq1, struct rq *rq2)
 	__acquires(rq2->lock)
 {
 	BUG_ON(!irqs_disabled());
-	if (rq1 == rq2) {
-		raw_spin_lock(&rq1->lock);
+	if (rq_lockp(rq1) == rq_lockp(rq2)) {
+		raw_spin_rq_lock(rq1);
 		__acquire(rq2->lock);	/* Fake it out ;) */
 	} else {
-		if (rq1 < rq2) {
-			raw_spin_lock(&rq1->lock);
-			raw_spin_lock_nested(&rq2->lock, SINGLE_DEPTH_NESTING);
+		if (rq_lockp(rq1) < rq_lockp(rq2)) {
+			raw_spin_rq_lock(rq1);
+			raw_spin_rq_lock_nested(rq2, SINGLE_DEPTH_NESTING);
 		} else {
-			raw_spin_lock(&rq2->lock);
-			raw_spin_lock_nested(&rq1->lock, SINGLE_DEPTH_NESTING);
+			raw_spin_rq_lock(rq2);
+			raw_spin_rq_lock_nested(rq1, SINGLE_DEPTH_NESTING);
 		}
 	}
 }
@@ -2369,9 +2368,9 @@ static inline void double_rq_unlock(struct rq *rq1, struct rq *rq2)
 	__releases(rq1->lock)
 	__releases(rq2->lock)
 {
-	raw_spin_unlock(&rq1->lock);
-	if (rq1 != rq2)
-		raw_spin_unlock(&rq2->lock);
+	raw_spin_rq_unlock(rq1);
+	if (rq_lockp(rq1) != rq_lockp(rq2))
+		raw_spin_rq_unlock(rq2);
 	else
 		__release(rq2->lock);
 }
@@ -2394,7 +2393,7 @@ static inline void double_rq_lock(struct rq *rq1, struct rq *rq2)
 {
 	BUG_ON(!irqs_disabled());
 	BUG_ON(rq1 != rq2);
-	raw_spin_lock(&rq1->lock);
+	raw_spin_rq_lock(rq1);
 	__acquire(rq2->lock);	/* Fake it out ;) */
 }
 
@@ -2409,7 +2408,7 @@ static inline void double_rq_unlock(struct rq *rq1, struct rq *rq2)
 	__releases(rq2->lock)
 {
 	BUG_ON(rq1 != rq2);
-	raw_spin_unlock(&rq1->lock);
+	raw_spin_rq_unlock(rq1);
 	__release(rq2->lock);
 }
 
diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
index 55a0a24..053115b 100644
--- a/kernel/sched/topology.c
+++ b/kernel/sched/topology.c
@@ -467,7 +467,7 @@ void rq_attach_root(struct rq *rq, struct root_domain *rd)
 	struct root_domain *old_rd = NULL;
 	unsigned long flags;
 
-	raw_spin_lock_irqsave(&rq->lock, flags);
+	raw_spin_rq_lock_irqsave(rq, flags);
 
 	if (rq->rd) {
 		old_rd = rq->rd;
@@ -493,7 +493,7 @@ void rq_attach_root(struct rq *rq, struct root_domain *rd)
 	if (cpumask_test_cpu(rq->cpu, cpu_active_mask))
 		set_rq_online(rq);
 
-	raw_spin_unlock_irqrestore(&rq->lock, flags);
+	raw_spin_rq_unlock_irqrestore(rq, flags);
 
 	if (old_rd)
 		call_rcu(&old_rd->rcu, free_rootdomain);
