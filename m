Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30E1C79E8BC
	for <lists+linux-tip-commits@lfdr.de>; Wed, 13 Sep 2023 15:11:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240684AbjIMNLU (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 13 Sep 2023 09:11:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240757AbjIMNLQ (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 13 Sep 2023 09:11:16 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2474C19B4;
        Wed, 13 Sep 2023 06:11:12 -0700 (PDT)
Date:   Wed, 13 Sep 2023 13:11:10 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1694610670;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=yiHtROo0mHoU96HoSj5AlQkEnX0RfB1qv0v/OKybK+0=;
        b=sRXnpgkdvD6jBp68/SmN20twhtV+b6HU9rJLmxV1wiPS6p0JnQhEGSeSuFUejXuAxp+XDQ
        1a5QRWS24UYGaaKThWCilXGOBDNz5WGZn3zNwVuVaBYQyR2ItFtrMYvyB/aEropXBlepu/
        zoSnoknPtcgwMHuYS2qz8qkA8LgYVJtzzeccP9naCxe5t/yrlMIM2razn3X6jG+6uSueJg
        qtsDs0yDtD7140JPQJSzP3ENpS2ZbJgQS74jRlVtyDPEy3ONZk61QdEkR6iadFuJoZGR7D
        qKgMTBdzNWEFWr5yjJSULWD+cSAS2coMkDYLpB9FmjI7bdQtobjL1RzL+0UrUg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1694610670;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=yiHtROo0mHoU96HoSj5AlQkEnX0RfB1qv0v/OKybK+0=;
        b=YULRz2amsND1NERB7NPsayN2wAwavIwsUEgGOpaYM4OZ11casOixVn20LIsrklAV2NlWgV
        xpiyyC3b20P3AZDA==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched: Misc cleanups
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <169461067011.27769.11049015770403504197.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     0e34600ac9317dbe5f0a7bfaa3d7187d757572ed
Gitweb:        https://git.kernel.org/tip/0e34600ac9317dbe5f0a7bfaa3d7187d757572ed
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Fri, 09 Jun 2023 20:52:49 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Wed, 13 Sep 2023 15:01:48 +02:00

sched: Misc cleanups

Random remaining guard use...

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 kernel/sched/core.c | 167 ++++++++++++++++---------------------------
 1 file changed, 63 insertions(+), 104 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 5d9f363..76662d8 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -1480,16 +1480,12 @@ static void __uclamp_update_util_min_rt_default(struct task_struct *p)
 
 static void uclamp_update_util_min_rt_default(struct task_struct *p)
 {
-	struct rq_flags rf;
-	struct rq *rq;
-
 	if (!rt_task(p))
 		return;
 
 	/* Protect updates to p->uclamp_* */
-	rq = task_rq_lock(p, &rf);
+	guard(task_rq_lock)(p);
 	__uclamp_update_util_min_rt_default(p);
-	task_rq_unlock(rq, p, &rf);
 }
 
 static inline struct uclamp_se
@@ -1785,9 +1781,8 @@ static void uclamp_update_root_tg(void)
 	uclamp_se_set(&tg->uclamp_req[UCLAMP_MAX],
 		      sysctl_sched_uclamp_util_max, false);
 
-	rcu_read_lock();
+	guard(rcu)();
 	cpu_util_update_eff(&root_task_group.css);
-	rcu_read_unlock();
 }
 #else
 static void uclamp_update_root_tg(void) { }
@@ -1814,10 +1809,9 @@ static void uclamp_sync_util_min_rt_default(void)
 	smp_mb__after_spinlock();
 	read_unlock(&tasklist_lock);
 
-	rcu_read_lock();
+	guard(rcu)();
 	for_each_process_thread(g, p)
 		uclamp_update_util_min_rt_default(p);
-	rcu_read_unlock();
 }
 
 static int sysctl_sched_uclamp_handler(struct ctl_table *table, int write,
@@ -2250,20 +2244,13 @@ static __always_inline
 int task_state_match(struct task_struct *p, unsigned int state)
 {
 #ifdef CONFIG_PREEMPT_RT
-	int match;
-
 	/*
 	 * Serialize against current_save_and_set_rtlock_wait_state() and
 	 * current_restore_rtlock_saved_state().
 	 */
-	raw_spin_lock_irq(&p->pi_lock);
-	match = __task_state_match(p, state);
-	raw_spin_unlock_irq(&p->pi_lock);
-
-	return match;
-#else
-	return __task_state_match(p, state);
+	guard(raw_spinlock_irq)(&p->pi_lock);
 #endif
+	return __task_state_match(p, state);
 }
 
 /*
@@ -2417,10 +2404,9 @@ void migrate_disable(void)
 		return;
 	}
 
-	preempt_disable();
+	guard(preempt)();
 	this_rq()->nr_pinned++;
 	p->migration_disabled = 1;
-	preempt_enable();
 }
 EXPORT_SYMBOL_GPL(migrate_disable);
 
@@ -2444,7 +2430,7 @@ void migrate_enable(void)
 	 * Ensure stop_task runs either before or after this, and that
 	 * __set_cpus_allowed_ptr(SCA_MIGRATE_ENABLE) doesn't schedule().
 	 */
-	preempt_disable();
+	guard(preempt)();
 	if (p->cpus_ptr != &p->cpus_mask)
 		__set_cpus_allowed_ptr(p, &ac);
 	/*
@@ -2455,7 +2441,6 @@ void migrate_enable(void)
 	barrier();
 	p->migration_disabled = 0;
 	this_rq()->nr_pinned--;
-	preempt_enable();
 }
 EXPORT_SYMBOL_GPL(migrate_enable);
 
@@ -3516,13 +3501,11 @@ out:
  */
 void kick_process(struct task_struct *p)
 {
-	int cpu;
+	guard(preempt)();
+	int cpu = task_cpu(p);
 
-	preempt_disable();
-	cpu = task_cpu(p);
 	if ((cpu != smp_processor_id()) && task_curr(p))
 		smp_send_reschedule(cpu);
-	preempt_enable();
 }
 EXPORT_SYMBOL_GPL(kick_process);
 
@@ -6368,8 +6351,9 @@ static void sched_core_balance(struct rq *rq)
 	struct sched_domain *sd;
 	int cpu = cpu_of(rq);
 
-	preempt_disable();
-	rcu_read_lock();
+	guard(preempt)();
+	guard(rcu)();
+
 	raw_spin_rq_unlock_irq(rq);
 	for_each_domain(cpu, sd) {
 		if (need_resched())
@@ -6379,8 +6363,6 @@ static void sched_core_balance(struct rq *rq)
 			break;
 	}
 	raw_spin_rq_lock_irq(rq);
-	rcu_read_unlock();
-	preempt_enable();
 }
 
 static DEFINE_PER_CPU(struct balance_callback, core_balance_head);
@@ -8258,8 +8240,6 @@ SYSCALL_DEFINE4(sched_getattr, pid_t, pid, struct sched_attr __user *, uattr,
 #ifdef CONFIG_SMP
 int dl_task_check_affinity(struct task_struct *p, const struct cpumask *mask)
 {
-	int ret = 0;
-
 	/*
 	 * If the task isn't a deadline task or admission control is
 	 * disabled then we don't care about affinity changes.
@@ -8273,11 +8253,11 @@ int dl_task_check_affinity(struct task_struct *p, const struct cpumask *mask)
 	 * tasks allowed to run on all the CPUs in the task's
 	 * root_domain.
 	 */
-	rcu_read_lock();
+	guard(rcu)();
 	if (!cpumask_subset(task_rq(p)->rd->span, mask))
-		ret = -EBUSY;
-	rcu_read_unlock();
-	return ret;
+		return -EBUSY;
+
+	return 0;
 }
 #endif
 
@@ -10509,11 +10489,9 @@ static int cpu_cgroup_css_online(struct cgroup_subsys_state *css)
 
 #ifdef CONFIG_UCLAMP_TASK_GROUP
 	/* Propagate the effective uclamp value for the new group */
-	mutex_lock(&uclamp_mutex);
-	rcu_read_lock();
+	guard(mutex)(&uclamp_mutex);
+	guard(rcu)();
 	cpu_util_update_eff(css);
-	rcu_read_unlock();
-	mutex_unlock(&uclamp_mutex);
 #endif
 
 	return 0;
@@ -10664,8 +10642,8 @@ static ssize_t cpu_uclamp_write(struct kernfs_open_file *of, char *buf,
 
 	static_branch_enable(&sched_uclamp_used);
 
-	mutex_lock(&uclamp_mutex);
-	rcu_read_lock();
+	guard(mutex)(&uclamp_mutex);
+	guard(rcu)();
 
 	tg = css_tg(of_css(of));
 	if (tg->uclamp_req[clamp_id].value != req.util)
@@ -10680,9 +10658,6 @@ static ssize_t cpu_uclamp_write(struct kernfs_open_file *of, char *buf,
 	/* Update effective clamps to track the most restrictive value */
 	cpu_util_update_eff(of_css(of));
 
-	rcu_read_unlock();
-	mutex_unlock(&uclamp_mutex);
-
 	return nbytes;
 }
 
@@ -10708,10 +10683,10 @@ static inline void cpu_uclamp_print(struct seq_file *sf,
 	u64 percent;
 	u32 rem;
 
-	rcu_read_lock();
-	tg = css_tg(seq_css(sf));
-	util_clamp = tg->uclamp_req[clamp_id].value;
-	rcu_read_unlock();
+	scoped_guard (rcu) {
+		tg = css_tg(seq_css(sf));
+		util_clamp = tg->uclamp_req[clamp_id].value;
+	}
 
 	if (util_clamp == SCHED_CAPACITY_SCALE) {
 		seq_puts(sf, "max\n");
@@ -11033,7 +11008,6 @@ static int tg_cfs_schedulable_down(struct task_group *tg, void *data)
 
 static int __cfs_schedulable(struct task_group *tg, u64 period, u64 quota)
 {
-	int ret;
 	struct cfs_schedulable_data data = {
 		.tg = tg,
 		.period = period,
@@ -11045,11 +11019,8 @@ static int __cfs_schedulable(struct task_group *tg, u64 period, u64 quota)
 		do_div(data.quota, NSEC_PER_USEC);
 	}
 
-	rcu_read_lock();
-	ret = walk_tg_tree(tg_cfs_schedulable_down, tg_nop, &data);
-	rcu_read_unlock();
-
-	return ret;
+	guard(rcu)();
+	return walk_tg_tree(tg_cfs_schedulable_down, tg_nop, &data);
 }
 
 static int cpu_cfs_stat_show(struct seq_file *sf, void *v)
@@ -11654,14 +11625,12 @@ int __sched_mm_cid_migrate_from_fetch_cid(struct rq *src_rq,
 	 * are not the last task to be migrated from this cpu for this mm, so
 	 * there is no need to move src_cid to the destination cpu.
 	 */
-	rcu_read_lock();
+	guard(rcu)();
 	src_task = rcu_dereference(src_rq->curr);
 	if (READ_ONCE(src_task->mm_cid_active) && src_task->mm == mm) {
-		rcu_read_unlock();
 		t->last_mm_cid = -1;
 		return -1;
 	}
-	rcu_read_unlock();
 
 	return src_cid;
 }
@@ -11705,18 +11674,17 @@ int __sched_mm_cid_migrate_from_try_steal_cid(struct rq *src_rq,
 	 * the lazy-put flag, this task will be responsible for transitioning
 	 * from lazy-put flag set to MM_CID_UNSET.
 	 */
-	rcu_read_lock();
-	src_task = rcu_dereference(src_rq->curr);
-	if (READ_ONCE(src_task->mm_cid_active) && src_task->mm == mm) {
-		rcu_read_unlock();
-		/*
-		 * We observed an active task for this mm, there is therefore
-		 * no point in moving this cid to the destination cpu.
-		 */
-		t->last_mm_cid = -1;
-		return -1;
+	scoped_guard (rcu) {
+		src_task = rcu_dereference(src_rq->curr);
+		if (READ_ONCE(src_task->mm_cid_active) && src_task->mm == mm) {
+			/*
+			 * We observed an active task for this mm, there is therefore
+			 * no point in moving this cid to the destination cpu.
+			 */
+			t->last_mm_cid = -1;
+			return -1;
+		}
 	}
-	rcu_read_unlock();
 
 	/*
 	 * The src_cid is unused, so it can be unset.
@@ -11789,7 +11757,6 @@ static void sched_mm_cid_remote_clear(struct mm_struct *mm, struct mm_cid *pcpu_
 {
 	struct rq *rq = cpu_rq(cpu);
 	struct task_struct *t;
-	unsigned long flags;
 	int cid, lazy_cid;
 
 	cid = READ_ONCE(pcpu_cid->cid);
@@ -11824,23 +11791,21 @@ static void sched_mm_cid_remote_clear(struct mm_struct *mm, struct mm_cid *pcpu_
 	 * the lazy-put flag, that task will be responsible for transitioning
 	 * from lazy-put flag set to MM_CID_UNSET.
 	 */
-	rcu_read_lock();
-	t = rcu_dereference(rq->curr);
-	if (READ_ONCE(t->mm_cid_active) && t->mm == mm) {
-		rcu_read_unlock();
-		return;
+	scoped_guard (rcu) {
+		t = rcu_dereference(rq->curr);
+		if (READ_ONCE(t->mm_cid_active) && t->mm == mm)
+			return;
 	}
-	rcu_read_unlock();
 
 	/*
 	 * The cid is unused, so it can be unset.
 	 * Disable interrupts to keep the window of cid ownership without rq
 	 * lock small.
 	 */
-	local_irq_save(flags);
-	if (try_cmpxchg(&pcpu_cid->cid, &lazy_cid, MM_CID_UNSET))
-		__mm_cid_put(mm, cid);
-	local_irq_restore(flags);
+	scoped_guard (irqsave) {
+		if (try_cmpxchg(&pcpu_cid->cid, &lazy_cid, MM_CID_UNSET))
+			__mm_cid_put(mm, cid);
+	}
 }
 
 static void sched_mm_cid_remote_clear_old(struct mm_struct *mm, int cpu)
@@ -11862,14 +11827,13 @@ static void sched_mm_cid_remote_clear_old(struct mm_struct *mm, int cpu)
 	 * snapshot associated with this cid if an active task using the mm is
 	 * observed on this rq.
 	 */
-	rcu_read_lock();
-	curr = rcu_dereference(rq->curr);
-	if (READ_ONCE(curr->mm_cid_active) && curr->mm == mm) {
-		WRITE_ONCE(pcpu_cid->time, rq_clock);
-		rcu_read_unlock();
-		return;
+	scoped_guard (rcu) {
+		curr = rcu_dereference(rq->curr);
+		if (READ_ONCE(curr->mm_cid_active) && curr->mm == mm) {
+			WRITE_ONCE(pcpu_cid->time, rq_clock);
+			return;
+		}
 	}
-	rcu_read_unlock();
 
 	if (rq_clock < pcpu_cid->time + SCHED_MM_CID_PERIOD_NS)
 		return;
@@ -11963,7 +11927,6 @@ void task_tick_mm_cid(struct rq *rq, struct task_struct *curr)
 void sched_mm_cid_exit_signals(struct task_struct *t)
 {
 	struct mm_struct *mm = t->mm;
-	struct rq_flags rf;
 	struct rq *rq;
 
 	if (!mm)
@@ -11971,7 +11934,7 @@ void sched_mm_cid_exit_signals(struct task_struct *t)
 
 	preempt_disable();
 	rq = this_rq();
-	rq_lock_irqsave(rq, &rf);
+	guard(rq_lock_irqsave)(rq);
 	preempt_enable_no_resched();	/* holding spinlock */
 	WRITE_ONCE(t->mm_cid_active, 0);
 	/*
@@ -11981,13 +11944,11 @@ void sched_mm_cid_exit_signals(struct task_struct *t)
 	smp_mb();
 	mm_cid_put(mm);
 	t->last_mm_cid = t->mm_cid = -1;
-	rq_unlock_irqrestore(rq, &rf);
 }
 
 void sched_mm_cid_before_execve(struct task_struct *t)
 {
 	struct mm_struct *mm = t->mm;
-	struct rq_flags rf;
 	struct rq *rq;
 
 	if (!mm)
@@ -11995,7 +11956,7 @@ void sched_mm_cid_before_execve(struct task_struct *t)
 
 	preempt_disable();
 	rq = this_rq();
-	rq_lock_irqsave(rq, &rf);
+	guard(rq_lock_irqsave)(rq);
 	preempt_enable_no_resched();	/* holding spinlock */
 	WRITE_ONCE(t->mm_cid_active, 0);
 	/*
@@ -12005,13 +11966,11 @@ void sched_mm_cid_before_execve(struct task_struct *t)
 	smp_mb();
 	mm_cid_put(mm);
 	t->last_mm_cid = t->mm_cid = -1;
-	rq_unlock_irqrestore(rq, &rf);
 }
 
 void sched_mm_cid_after_execve(struct task_struct *t)
 {
 	struct mm_struct *mm = t->mm;
-	struct rq_flags rf;
 	struct rq *rq;
 
 	if (!mm)
@@ -12019,16 +11978,16 @@ void sched_mm_cid_after_execve(struct task_struct *t)
 
 	preempt_disable();
 	rq = this_rq();
-	rq_lock_irqsave(rq, &rf);
-	preempt_enable_no_resched();	/* holding spinlock */
-	WRITE_ONCE(t->mm_cid_active, 1);
-	/*
-	 * Store t->mm_cid_active before loading per-mm/cpu cid.
-	 * Matches barrier in sched_mm_cid_remote_clear_old().
-	 */
-	smp_mb();
-	t->last_mm_cid = t->mm_cid = mm_cid_get(rq, mm);
-	rq_unlock_irqrestore(rq, &rf);
+	scoped_guard (rq_lock_irqsave, rq) {
+		preempt_enable_no_resched();	/* holding spinlock */
+		WRITE_ONCE(t->mm_cid_active, 1);
+		/*
+		 * Store t->mm_cid_active before loading per-mm/cpu cid.
+		 * Matches barrier in sched_mm_cid_remote_clear_old().
+		 */
+		smp_mb();
+		t->last_mm_cid = t->mm_cid = mm_cid_get(rq, mm);
+	}
 	rseq_set_notify_resume(t);
 }
 
