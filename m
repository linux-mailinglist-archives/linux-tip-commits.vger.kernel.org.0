Return-Path: <linux-tip-commits+bounces-1295-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F50B8D05D8
	for <lists+linux-tip-commits@lfdr.de>; Mon, 27 May 2024 17:20:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3E5981C21A81
	for <lists+linux-tip-commits@lfdr.de>; Mon, 27 May 2024 15:20:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E44E152DE3;
	Mon, 27 May 2024 15:09:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="e4RR8d0p";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="W6ZyrtqR"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62860155C99;
	Mon, 27 May 2024 15:09:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716822598; cv=none; b=Ak+cQe22/Du0tnqL0iudSvloXzJ6xARAQHu4uvUHIbhZ7Of7HdMFzvEi72Gcxt3V0l1Xmf6kCAh7gl4sw3hW9wB/vTgGcoAZgtkNwPFJIG8PTO659aciW3KbrYaZ8m6XfJ2MltcePWxywi+JcM2KyA0qD/GSIK5C2CvVNhcGyE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716822598; c=relaxed/simple;
	bh=awZZgZ2Z0qkh8t3k/cOKfYx6BraM9PDoIlJPp13DdlY=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=CG7r3ZKOq+UdEpbpem63eDJFd+eGjMZm78zFRz3BLImjfCnSaFwdEenIy8IgSZn8r4+00I1YGbmxWnRxhyAzWJU0/V/I0DumSXJVvFE3atDMJyOZEXeLmiUwrCPKryngVpDakTnYcXL8IRef0z1i/PIBv7Sw8sYcknHHAuwgmoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=e4RR8d0p; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=W6ZyrtqR; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 27 May 2024 15:09:52 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1716822593;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=pxtslJZKmAbFf+bPDUF/fxw00SV+aICZCqTQxFU+/Wo=;
	b=e4RR8d0pmckf3VUETlUw4gDPt1Hw306FRFzyGnKcrEniDCdFjwqzaC6yKfTRmL04uLggW7
	MiwTT+DkymfGYruHBDwXzyWRacTLZn8AmxCLydsNMMXuAuUl649ECnPUmyxh6+fDAElwgV
	/Kp3QF07GV3J8PtXHY4shTg4ZIJJFrPFhD7M1KtiGYiwzLmOmrmk1JramJIJVQx8M4YZHF
	iBnT+0jm3x+pD/AziUYz1Uvox0bIoVSeewZSpdmkl9FhKjY2M7G41pLOC6ceTdQxqbZQM2
	PlhuVNp6seMuyU0XDk3P2nuWAnVyYu6gw/NQ/lU8X0KkDfFG5VVPLWHoegFJTA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1716822593;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=pxtslJZKmAbFf+bPDUF/fxw00SV+aICZCqTQxFU+/Wo=;
	b=W6ZyrtqREzJJsLZuIzJ3LwIh7yN3m/ClTt2QfXwrfvPAj8AdwfHyiMJKrTIpXelFx8zqAy
	0d6jderCpwivKTDw==
From: "tip-bot2 for Ingo Molnar" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched: Fix spelling in comments
Cc: Ingo Molnar <mingo@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
 linux-kernel@vger.kernel.org, x86@kernel.org
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171682259281.10875.11056911564480265626.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     402de7fc880fef055bc984957454b532987e9ad0
Gitweb:        https://git.kernel.org/tip/402de7fc880fef055bc984957454b532987e9ad0
Author:        Ingo Molnar <mingo@kernel.org>
AuthorDate:    Mon, 27 May 2024 16:54:52 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Mon, 27 May 2024 17:00:21 +02:00

sched: Fix spelling in comments

Do a spell-checking pass.

Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 kernel/sched/clock.c      |  4 +-
 kernel/sched/core.c       | 62 +++++++++++++++++++-------------------
 kernel/sched/core_sched.c |  2 +-
 kernel/sched/cputime.c    | 14 ++++-----
 kernel/sched/deadline.c   |  8 ++---
 kernel/sched/fair.c       |  4 +-
 kernel/sched/idle.c       |  8 ++---
 kernel/sched/loadavg.c    |  4 +-
 kernel/sched/pelt.c       |  4 +-
 kernel/sched/psi.c        |  6 ++--
 kernel/sched/rt.c         | 22 ++++++-------
 kernel/sched/sched.h      | 10 +++---
 kernel/sched/stats.h      |  2 +-
 kernel/sched/syscalls.c   | 18 +++++------
 kernel/sched/topology.c   | 12 +++----
 kernel/sched/wait_bit.c   |  4 +-
 16 files changed, 92 insertions(+), 92 deletions(-)

diff --git a/kernel/sched/clock.c b/kernel/sched/clock.c
index 3c6193d..a09655b 100644
--- a/kernel/sched/clock.c
+++ b/kernel/sched/clock.c
@@ -340,7 +340,7 @@ again:
 	this_clock = sched_clock_local(my_scd);
 	/*
 	 * We must enforce atomic readout on 32-bit, otherwise the
-	 * update on the remote CPU can hit inbetween the readout of
+	 * update on the remote CPU can hit in between the readout of
 	 * the low 32-bit and the high 32-bit portion.
 	 */
 	remote_clock = cmpxchg64(&scd->clock, 0, 0);
@@ -444,7 +444,7 @@ notrace void sched_clock_tick_stable(void)
 }
 
 /*
- * We are going deep-idle (irqs are disabled):
+ * We are going deep-idle (IRQs are disabled):
  */
 notrace void sched_clock_idle_sleep_event(void)
 {
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 8cb5b7e..5d861b5 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -707,14 +707,14 @@ static void update_rq_clock_task(struct rq *rq, s64 delta)
 	/*
 	 * Since irq_time is only updated on {soft,}irq_exit, we might run into
 	 * this case when a previous update_rq_clock() happened inside a
-	 * {soft,}irq region.
+	 * {soft,}IRQ region.
 	 *
 	 * When this happens, we stop ->clock_task and only update the
 	 * prev_irq_time stamp to account for the part that fit, so that a next
 	 * update will consume the rest. This ensures ->clock_task is
 	 * monotonic.
 	 *
-	 * It does however cause some slight miss-attribution of {soft,}irq
+	 * It does however cause some slight miss-attribution of {soft,}IRQ
 	 * time, a more accurate solution would be to update the irq_time using
 	 * the current rq->clock timestamp, except that would require using
 	 * atomic ops.
@@ -827,7 +827,7 @@ static void __hrtick_start(void *arg)
 /*
  * Called to set the hrtick timer state.
  *
- * called with rq->lock held and irqs disabled
+ * called with rq->lock held and IRQs disabled
  */
 void hrtick_start(struct rq *rq, u64 delay)
 {
@@ -851,7 +851,7 @@ void hrtick_start(struct rq *rq, u64 delay)
 /*
  * Called to set the hrtick timer state.
  *
- * called with rq->lock held and irqs disabled
+ * called with rq->lock held and IRQs disabled
  */
 void hrtick_start(struct rq *rq, u64 delay)
 {
@@ -885,7 +885,7 @@ static inline void hrtick_rq_init(struct rq *rq)
 #endif	/* CONFIG_SCHED_HRTICK */
 
 /*
- * cmpxchg based fetch_or, macro so it works for different integer types
+ * try_cmpxchg based fetch_or() macro so it works for different integer types:
  */
 #define fetch_or(ptr, mask)						\
 	({								\
@@ -1082,7 +1082,7 @@ void resched_cpu(int cpu)
  *
  * We don't do similar optimization for completely idle system, as
  * selecting an idle CPU will add more delays to the timers than intended
- * (as that CPU's timer base may not be uptodate wrt jiffies etc).
+ * (as that CPU's timer base may not be up to date wrt jiffies etc).
  */
 int get_nohz_timer_target(void)
 {
@@ -1142,7 +1142,7 @@ static void wake_up_idle_cpu(int cpu)
 	 * nohz functions that would need to follow TIF_NR_POLLING
 	 * clearing:
 	 *
-	 * - On most archs, a simple fetch_or on ti::flags with a
+	 * - On most architectures, a simple fetch_or on ti::flags with a
 	 *   "0" value would be enough to know if an IPI needs to be sent.
 	 *
 	 * - x86 needs to perform a last need_resched() check between
@@ -1651,7 +1651,7 @@ static inline void uclamp_rq_dec_id(struct rq *rq, struct task_struct *p,
 	rq_clamp = uclamp_rq_get(rq, clamp_id);
 	/*
 	 * Defensive programming: this should never happen. If it happens,
-	 * e.g. due to future modification, warn and fixup the expected value.
+	 * e.g. due to future modification, warn and fix up the expected value.
 	 */
 	SCHED_WARN_ON(bucket->value > rq_clamp);
 	if (bucket->value >= rq_clamp) {
@@ -2227,7 +2227,7 @@ static void migrate_disable_switch(struct rq *rq, struct task_struct *p)
 		return;
 
 	/*
-	 * Violates locking rules! see comment in __do_set_cpus_allowed().
+	 * Violates locking rules! See comment in __do_set_cpus_allowed().
 	 */
 	__do_set_cpus_allowed(p, &ac);
 }
@@ -2394,7 +2394,7 @@ static struct rq *__migrate_task(struct rq *rq, struct rq_flags *rf,
 }
 
 /*
- * migration_cpu_stop - this will be executed by a highprio stopper thread
+ * migration_cpu_stop - this will be executed by a high-prio stopper thread
  * and performs thread migration by bumping thread off CPU then
  * 'pushing' onto another runqueue.
  */
@@ -3694,8 +3694,8 @@ void sched_ttwu_pending(void *arg)
 	 * it is possible for select_idle_siblings() to stack a number
 	 * of tasks on this CPU during that window.
 	 *
-	 * It is ok to clear ttwu_pending when another task pending.
-	 * We will receive IPI after local irq enabled and then enqueue it.
+	 * It is OK to clear ttwu_pending when another task pending.
+	 * We will receive IPI after local IRQ enabled and then enqueue it.
 	 * Since now nr_running > 0, idle_cpu() will always get correct result.
 	 */
 	WRITE_ONCE(rq->ttwu_pending, 0);
@@ -5017,7 +5017,7 @@ prepare_task_switch(struct rq *rq, struct task_struct *prev,
  *
  * The context switch have flipped the stack from under us and restored the
  * local variables which were saved when this task called schedule() in the
- * past. prev == current is still correct but we need to recalculate this_rq
+ * past. 'prev == current' is still correct but we need to recalculate this_rq
  * because prev may have moved to another CPU.
  */
 static struct rq *finish_task_switch(struct task_struct *prev)
@@ -5363,7 +5363,7 @@ unsigned long long task_sched_runtime(struct task_struct *p)
 	/*
 	 * 64-bit doesn't need locks to atomically read a 64-bit value.
 	 * So we have a optimization chance when the task's delta_exec is 0.
-	 * Reading ->on_cpu is racy, but this is ok.
+	 * Reading ->on_cpu is racy, but this is OK.
 	 *
 	 * If we race with it leaving CPU, we'll take a lock. So we're correct.
 	 * If we race with it entering CPU, unaccounted time is 0. This is
@@ -6637,7 +6637,7 @@ void __sched schedule_idle(void)
 {
 	/*
 	 * As this skips calling sched_submit_work(), which the idle task does
-	 * regardless because that function is a nop when the task is in a
+	 * regardless because that function is a NOP when the task is in a
 	 * TASK_RUNNING state, make sure this isn't used someplace that the
 	 * current task can be in any other state. Note, idle is always in the
 	 * TASK_RUNNING state.
@@ -6832,9 +6832,9 @@ EXPORT_SYMBOL(dynamic_preempt_schedule_notrace);
 
 /*
  * This is the entry point to schedule() from kernel preemption
- * off of irq context.
- * Note, that this is called and return with irqs disabled. This will
- * protect us against recursive calling from irq.
+ * off of IRQ context.
+ * Note, that this is called and return with IRQs disabled. This will
+ * protect us against recursive calling from IRQ contexts.
  */
 asmlinkage __visible void __sched preempt_schedule_irq(void)
 {
@@ -6953,7 +6953,7 @@ void rt_mutex_setprio(struct task_struct *p, struct task_struct *pi_task)
 		goto out_unlock;
 
 	/*
-	 * Idle task boosting is a nono in general. There is one
+	 * Idle task boosting is a no-no in general. There is one
 	 * exception, when PREEMPT_RT and NOHZ is active:
 	 *
 	 * The idle task calls get_next_timer_interrupt() and holds
@@ -7356,11 +7356,11 @@ PREEMPT_MODEL_ACCESSOR(none);
 PREEMPT_MODEL_ACCESSOR(voluntary);
 PREEMPT_MODEL_ACCESSOR(full);
 
-#else /* !CONFIG_PREEMPT_DYNAMIC */
+#else /* !CONFIG_PREEMPT_DYNAMIC: */
 
 static inline void preempt_dynamic_init(void) { }
 
-#endif /* #ifdef CONFIG_PREEMPT_DYNAMIC */
+#endif /* CONFIG_PREEMPT_DYNAMIC */
 
 int io_schedule_prepare(void)
 {
@@ -7970,7 +7970,7 @@ int sched_cpu_deactivate(unsigned int cpu)
 	 * Specifically, we rely on ttwu to no longer target this CPU, see
 	 * ttwu_queue_cond() and is_cpu_allowed().
 	 *
-	 * Do sync before park smpboot threads to take care the rcu boost case.
+	 * Do sync before park smpboot threads to take care the RCU boost case.
 	 */
 	synchronize_rcu();
 
@@ -8045,7 +8045,7 @@ int sched_cpu_wait_empty(unsigned int cpu)
  * Since this CPU is going 'away' for a while, fold any nr_active delta we
  * might have. Called from the CPU stopper task after ensuring that the
  * stopper is the last running task on the CPU, so nr_active count is
- * stable. We need to take the teardown thread which is calling this into
+ * stable. We need to take the tear-down thread which is calling this into
  * account, so we hand in adjust = 1 to the load calculation.
  *
  * Also see the comment "Global load-average calculations".
@@ -8239,7 +8239,7 @@ void __init sched_init(void)
 		/*
 		 * How much CPU bandwidth does root_task_group get?
 		 *
-		 * In case of task-groups formed thr' the cgroup filesystem, it
+		 * In case of task-groups formed through the cgroup filesystem, it
 		 * gets 100% of the CPU resources in the system. This overall
 		 * system CPU resource is divided among the tasks of
 		 * root_task_group and its child task-groups in a fair manner,
@@ -8541,7 +8541,7 @@ void normalize_rt_tasks(void)
 
 #if defined(CONFIG_KGDB_KDB)
 /*
- * These functions are only useful for kdb.
+ * These functions are only useful for KDB.
  *
  * They can only be called when the whole system has been
  * stopped - every CPU needs to be quiescent, and no scheduling
@@ -8649,7 +8649,7 @@ void sched_online_group(struct task_group *tg, struct task_group *parent)
 	online_fair_sched_group(tg);
 }
 
-/* rcu callback to free various structures associated with a task group */
+/* RCU callback to free various structures associated with a task group */
 static void sched_unregister_group_rcu(struct rcu_head *rhp)
 {
 	/* Now it should be safe to free those cfs_rqs: */
@@ -9767,10 +9767,10 @@ const int sched_prio_to_weight[40] = {
 };
 
 /*
- * Inverse (2^32/x) values of the sched_prio_to_weight[] array, precalculated.
+ * Inverse (2^32/x) values of the sched_prio_to_weight[] array, pre-calculated.
  *
  * In cases where the weight does not change often, we can use the
- * precalculated inverse to speed up arithmetics by turning divisions
+ * pre-calculated inverse to speed up arithmetics by turning divisions
  * into multiplications:
  */
 const u32 sched_prio_to_wmult[40] = {
@@ -10026,16 +10026,16 @@ void sched_mm_cid_migrate_to(struct rq *dst_rq, struct task_struct *t)
 	/*
 	 * Move the src cid if the dst cid is unset. This keeps id
 	 * allocation closest to 0 in cases where few threads migrate around
-	 * many cpus.
+	 * many CPUs.
 	 *
 	 * If destination cid is already set, we may have to just clear
 	 * the src cid to ensure compactness in frequent migrations
 	 * scenarios.
 	 *
 	 * It is not useful to clear the src cid when the number of threads is
-	 * greater or equal to the number of allowed cpus, because user-space
+	 * greater or equal to the number of allowed CPUs, because user-space
 	 * can expect that the number of allowed cids can reach the number of
-	 * allowed cpus.
+	 * allowed CPUs.
 	 */
 	dst_pcpu_cid = per_cpu_ptr(mm->pcpu_cid, cpu_of(dst_rq));
 	dst_cid = READ_ONCE(dst_pcpu_cid->cid);
diff --git a/kernel/sched/core_sched.c b/kernel/sched/core_sched.c
index a57fd8f..1ef98a9 100644
--- a/kernel/sched/core_sched.c
+++ b/kernel/sched/core_sched.c
@@ -279,7 +279,7 @@ void __sched_core_account_forceidle(struct rq *rq)
 			continue;
 
 		/*
-		 * Note: this will account forceidle to the current cpu, even
+		 * Note: this will account forceidle to the current CPU, even
 		 * if it comes from our SMT sibling.
 		 */
 		__account_forceidle_time(p, delta);
diff --git a/kernel/sched/cputime.c b/kernel/sched/cputime.c
index aa48b2e..a5e0029 100644
--- a/kernel/sched/cputime.c
+++ b/kernel/sched/cputime.c
@@ -14,11 +14,11 @@
  * They are only modified in vtime_account, on corresponding CPU
  * with interrupts disabled. So, writes are safe.
  * They are read and saved off onto struct rq in update_rq_clock().
- * This may result in other CPU reading this CPU's irq time and can
+ * This may result in other CPU reading this CPU's IRQ time and can
  * race with irq/vtime_account on this CPU. We would either get old
- * or new value with a side effect of accounting a slice of irq time to wrong
- * task when irq is in progress while we read rq->clock. That is a worthy
- * compromise in place of having locks on each irq in account_system_time.
+ * or new value with a side effect of accounting a slice of IRQ time to wrong
+ * task when IRQ is in progress while we read rq->clock. That is a worthy
+ * compromise in place of having locks on each IRQ in account_system_time.
  */
 DEFINE_PER_CPU(struct irqtime, cpu_irqtime);
 
@@ -269,7 +269,7 @@ static __always_inline u64 steal_account_process_time(u64 maxtime)
 }
 
 /*
- * Account how much elapsed time was spent in steal, irq, or softirq time.
+ * Account how much elapsed time was spent in steal, IRQ, or softirq time.
  */
 static inline u64 account_other_time(u64 max)
 {
@@ -370,7 +370,7 @@ void thread_group_cputime(struct task_struct *tsk, struct task_cputime *times)
  * Check for hardirq is done both for system and user time as there is
  * no timer going off while we are on hardirq and hence we may never get an
  * opportunity to update it solely in system time.
- * p->stime and friends are only updated on system time and not on irq
+ * p->stime and friends are only updated on system time and not on IRQ
  * softirq as those do not count in task exec_runtime any more.
  */
 static void irqtime_account_process_tick(struct task_struct *p, int user_tick,
@@ -380,7 +380,7 @@ static void irqtime_account_process_tick(struct task_struct *p, int user_tick,
 
 	/*
 	 * When returning from idle, many ticks can get accounted at
-	 * once, including some ticks of steal, irq, and softirq time.
+	 * once, including some ticks of steal, IRQ, and softirq time.
 	 * Subtract those ticks from the amount of time accounted to
 	 * idle, or potentially user or system time. Due to rounding,
 	 * other time can exceed ticks occasionally.
diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index c75d130..b216e6d 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -708,7 +708,7 @@ static struct rq *dl_task_offline_migration(struct rq *rq, struct task_struct *p
 	}
 
 	/*
-	 * And we finally need to fixup root_domain(s) bandwidth accounting,
+	 * And we finally need to fix up root_domain(s) bandwidth accounting,
 	 * since p is still hanging out in the old (now moved to default) root
 	 * domain.
 	 */
@@ -992,7 +992,7 @@ static inline bool dl_is_implicit(struct sched_dl_entity *dl_se)
  * is detected, the runtime and deadline need to be updated.
  *
  * If the task has an implicit deadline, i.e., deadline == period, the Original
- * CBS is applied. the runtime is replenished and a new absolute deadline is
+ * CBS is applied. The runtime is replenished and a new absolute deadline is
  * set, as in the previous cases.
  *
  * However, the Original CBS does not work properly for tasks with
@@ -1294,7 +1294,7 @@ int dl_runtime_exceeded(struct sched_dl_entity *dl_se)
  * Since rq->dl.running_bw and rq->dl.this_bw contain utilizations multiplied
  * by 2^BW_SHIFT, the result has to be shifted right by BW_SHIFT.
  * Since rq->dl.bw_ratio contains 1 / Umax multiplied by 2^RATIO_SHIFT, dl_bw
- * is multiped by rq->dl.bw_ratio and shifted right by RATIO_SHIFT.
+ * is multiplied by rq->dl.bw_ratio and shifted right by RATIO_SHIFT.
  * Since delta is a 64 bit variable, to have an overflow its value should be
  * larger than 2^(64 - 20 - 8), which is more than 64 seconds. So, overflow is
  * not an issue here.
@@ -2488,7 +2488,7 @@ static void pull_dl_task(struct rq *this_rq)
 		src_rq = cpu_rq(cpu);
 
 		/*
-		 * It looks racy, abd it is! However, as in sched_rt.c,
+		 * It looks racy, and it is! However, as in sched_rt.c,
 		 * we are fine with this.
 		 */
 		if (this_rq->dl.dl_nr_running &&
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 8a5b1ae..63113dc 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -61,7 +61,7 @@
  * Options are:
  *
  *   SCHED_TUNABLESCALING_NONE - unscaled, always *1
- *   SCHED_TUNABLESCALING_LOG - scaled logarithmical, *1+ilog(ncpus)
+ *   SCHED_TUNABLESCALING_LOG - scaled logarithmically, *1+ilog(ncpus)
  *   SCHED_TUNABLESCALING_LINEAR - scaled linear, *ncpus
  *
  * (default SCHED_TUNABLESCALING_LOG = *(1+ilog(ncpus))
@@ -8719,7 +8719,7 @@ static bool yield_to_task_fair(struct rq *rq, struct task_struct *p)
  * topology where each level pairs two lower groups (or better). This results
  * in O(log n) layers. Furthermore we reduce the number of CPUs going up the
  * tree to only the first of the previous level and we decrease the frequency
- * of load-balance at each level inv. proportional to the number of CPUs in
+ * of load-balance at each level inversely proportional to the number of CPUs in
  * the groups.
  *
  * This yields:
diff --git a/kernel/sched/idle.c b/kernel/sched/idle.c
index 6135fbe..770e698 100644
--- a/kernel/sched/idle.c
+++ b/kernel/sched/idle.c
@@ -172,7 +172,7 @@ static void cpuidle_idle_call(void)
 
 	/*
 	 * Check if the idle task must be rescheduled. If it is the
-	 * case, exit the function after re-enabling the local irq.
+	 * case, exit the function after re-enabling the local IRQ.
 	 */
 	if (need_resched()) {
 		local_irq_enable();
@@ -181,7 +181,7 @@ static void cpuidle_idle_call(void)
 
 	/*
 	 * The RCU framework needs to be told that we are entering an idle
-	 * section, so no more rcu read side critical sections and one more
+	 * section, so no more RCU read side critical sections and one more
 	 * step to the grace period
 	 */
 
@@ -244,7 +244,7 @@ exit_idle:
 	__current_set_polling();
 
 	/*
-	 * It is up to the idle functions to reenable local interrupts
+	 * It is up to the idle functions to re-enable local interrupts
 	 */
 	if (WARN_ON_ONCE(irqs_disabled()))
 		local_irq_enable();
@@ -320,7 +320,7 @@ static void do_idle(void)
 		rcu_nocb_flush_deferred_wakeup();
 
 		/*
-		 * In poll mode we reenable interrupts and spin. Also if we
+		 * In poll mode we re-enable interrupts and spin. Also if we
 		 * detected in the wakeup from idle path that the tick
 		 * broadcast device expired for us, we don't want to go deep
 		 * idle as we know that the IPI is going to arrive right away.
diff --git a/kernel/sched/loadavg.c b/kernel/sched/loadavg.c
index ca9da66..c48900b 100644
--- a/kernel/sched/loadavg.c
+++ b/kernel/sched/loadavg.c
@@ -45,7 +45,7 @@
  *    again, being late doesn't loose the delta, just wrecks the sample.
  *
  *  - cpu_rq()->nr_uninterruptible isn't accurately tracked per-CPU because
- *    this would add another cross-CPU cacheline miss and atomic operation
+ *    this would add another cross-CPU cache-line miss and atomic operation
  *    to the wakeup path. Instead we increment on whatever CPU the task ran
  *    when it went into uninterruptible state and decrement on whatever CPU
  *    did the wakeup. This means that only the sum of nr_uninterruptible over
@@ -62,7 +62,7 @@ EXPORT_SYMBOL(avenrun); /* should be removed */
 
 /**
  * get_avenrun - get the load average array
- * @loads:	pointer to dest load array
+ * @loads:	pointer to destination load array
  * @offset:	offset to add
  * @shift:	shift count to shift the result left
  *
diff --git a/kernel/sched/pelt.c b/kernel/sched/pelt.c
index ef00382..fa52906 100644
--- a/kernel/sched/pelt.c
+++ b/kernel/sched/pelt.c
@@ -417,7 +417,7 @@ int update_hw_load_avg(u64 now, struct rq *rq, u64 capacity)
 
 #ifdef CONFIG_HAVE_SCHED_AVG_IRQ
 /*
- * irq:
+ * IRQ:
  *
  *   util_sum = \Sum se->avg.util_sum but se->avg.util_sum is not tracked
  *   util_sum = cpu_scale * load_sum
@@ -432,7 +432,7 @@ int update_irq_load_avg(struct rq *rq, u64 running)
 	int ret = 0;
 
 	/*
-	 * We can't use clock_pelt because irq time is not accounted in
+	 * We can't use clock_pelt because IRQ time is not accounted in
 	 * clock_task. Instead we directly scale the running time to
 	 * reflect the real amount of computation
 	 */
diff --git a/kernel/sched/psi.c b/kernel/sched/psi.c
index 7b4aa58..146baa9 100644
--- a/kernel/sched/psi.c
+++ b/kernel/sched/psi.c
@@ -41,7 +41,7 @@
  * What it means for a task to be productive is defined differently
  * for each resource. For IO, productive means a running task. For
  * memory, productive means a running task that isn't a reclaimer. For
- * CPU, productive means an oncpu task.
+ * CPU, productive means an on-CPU task.
  *
  * Naturally, the FULL state doesn't exist for the CPU resource at the
  * system level, but exist at the cgroup level. At the cgroup level,
@@ -49,7 +49,7 @@
  * resource which is being used by others outside of the cgroup or
  * throttled by the cgroup cpu.max configuration.
  *
- * The percentage of wallclock time spent in those compound stall
+ * The percentage of wall clock time spent in those compound stall
  * states gives pressure numbers between 0 and 100 for each resource,
  * where the SOME percentage indicates workload slowdowns and the FULL
  * percentage indicates reduced CPU utilization:
@@ -345,7 +345,7 @@ static void collect_percpu_times(struct psi_group *group,
 
 	/*
 	 * Collect the per-cpu time buckets and average them into a
-	 * single time sample that is normalized to wallclock time.
+	 * single time sample that is normalized to wall clock time.
 	 *
 	 * For averaging, each CPU is weighted by its non-idle time in
 	 * the sampling period. This eliminates artifacts from uneven
diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
index aa4c1c8..63e49c8 100644
--- a/kernel/sched/rt.c
+++ b/kernel/sched/rt.c
@@ -140,7 +140,7 @@ void init_rt_rq(struct rt_rq *rt_rq)
 		INIT_LIST_HEAD(array->queue + i);
 		__clear_bit(i, array->bitmap);
 	}
-	/* delimiter for bitsearch: */
+	/* delimiter for bit-search: */
 	__set_bit(MAX_RT_PRIO, array->bitmap);
 
 #if defined CONFIG_SMP
@@ -1135,7 +1135,7 @@ dec_rt_prio(struct rt_rq *rt_rq, int prio)
 
 		/*
 		 * This may have been our highest task, and therefore
-		 * we may have some recomputation to do
+		 * we may have some re-computation to do
 		 */
 		if (prio == prev_prio) {
 			struct rt_prio_array *array = &rt_rq->active;
@@ -1571,7 +1571,7 @@ select_task_rq_rt(struct task_struct *p, int cpu, int flags)
 	 *
 	 * For equal prio tasks, we just let the scheduler sort it out.
 	 *
-	 * Otherwise, just let it ride on the affined RQ and the
+	 * Otherwise, just let it ride on the affine RQ and the
 	 * post-schedule router will push the preempted task away
 	 *
 	 * This test is optimistic, if we get it wrong the load-balancer
@@ -2147,14 +2147,14 @@ static void push_rt_tasks(struct rq *rq)
  * if its the only CPU with multiple RT tasks queued, and a large number
  * of CPUs scheduling a lower priority task at the same time.
  *
- * Each root domain has its own irq work function that can iterate over
+ * Each root domain has its own IRQ work function that can iterate over
  * all CPUs with RT overloaded tasks. Since all CPUs with overloaded RT
  * task must be checked if there's one or many CPUs that are lowering
- * their priority, there's a single irq work iterator that will try to
+ * their priority, there's a single IRQ work iterator that will try to
  * push off RT tasks that are waiting to run.
  *
  * When a CPU schedules a lower priority task, it will kick off the
- * irq work iterator that will jump to each CPU with overloaded RT tasks.
+ * IRQ work iterator that will jump to each CPU with overloaded RT tasks.
  * As it only takes the first CPU that schedules a lower priority task
  * to start the process, the rto_start variable is incremented and if
  * the atomic result is one, then that CPU will try to take the rto_lock.
@@ -2162,7 +2162,7 @@ static void push_rt_tasks(struct rq *rq)
  * CPUs scheduling lower priority tasks.
  *
  * All CPUs that are scheduling a lower priority task will increment the
- * rt_loop_next variable. This will make sure that the irq work iterator
+ * rt_loop_next variable. This will make sure that the IRQ work iterator
  * checks all RT overloaded CPUs whenever a CPU schedules a new lower
  * priority task, even if the iterator is in the middle of a scan. Incrementing
  * the rt_loop_next will cause the iterator to perform another scan.
@@ -2242,7 +2242,7 @@ static void tell_cpu_to_push(struct rq *rq)
 	 * The rto_cpu is updated under the lock, if it has a valid CPU
 	 * then the IPI is still running and will continue due to the
 	 * update to loop_next, and nothing needs to be done here.
-	 * Otherwise it is finishing up and an ipi needs to be sent.
+	 * Otherwise it is finishing up and an IPI needs to be sent.
 	 */
 	if (rq->rd->rto_cpu < 0)
 		cpu = rto_next_cpu(rq->rd);
@@ -2594,7 +2594,7 @@ static void task_tick_rt(struct rq *rq, struct task_struct *p, int queued)
 	watchdog(rq, p);
 
 	/*
-	 * RR tasks need a special form of timeslice management.
+	 * RR tasks need a special form of time-slice management.
 	 * FIFO tasks have no timeslices.
 	 */
 	if (p->policy != SCHED_RR)
@@ -2900,7 +2900,7 @@ static int sched_rt_global_constraints(void)
 
 int sched_rt_can_attach(struct task_group *tg, struct task_struct *tsk)
 {
-	/* Don't accept realtime tasks when there is no way for them to run */
+	/* Don't accept real-time tasks when there is no way for them to run */
 	if (rt_task(tsk) && tg->rt_bandwidth.rt_runtime == 0)
 		return 0;
 
@@ -3001,7 +3001,7 @@ static int sched_rr_handler(struct ctl_table *table, int write, void *buffer,
 	ret = proc_dointvec(table, write, buffer, lenp, ppos);
 	/*
 	 * Make sure that internally we keep jiffies.
-	 * Also, writing zero resets the timeslice to default:
+	 * Also, writing zero resets the time-slice to default:
 	 */
 	if (!ret && write) {
 		sched_rr_timeslice =
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 24c0f4a..cefa27f 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -133,7 +133,7 @@ extern struct list_head asym_cap_list;
 /*
  * Increase resolution of nice-level calculations for 64-bit architectures.
  * The extra resolution improves shares distribution and load balancing of
- * low-weight task groups (eg. nice +19 on an autogroup), deeper taskgroup
+ * low-weight task groups (eg. nice +19 on an autogroup), deeper task-group
  * hierarchies, especially on larger systems. This is not a user-visible change
  * and does not change the user-interface for setting shares/weights.
  *
@@ -406,7 +406,7 @@ struct task_group {
 #ifdef	CONFIG_SMP
 	/*
 	 * load_avg can be heavily contended at clock tick time, so put
-	 * it in its own cacheline separated from the fields above which
+	 * it in its own cache-line separated from the fields above which
 	 * will also be accessed at each tick.
 	 */
 	atomic_long_t		load_avg ____cacheline_aligned;
@@ -874,7 +874,7 @@ struct root_domain {
 	 */
 	bool			overloaded;
 
-	/* Indicate one or more cpus over-utilized (tipping point) */
+	/* Indicate one or more CPUs over-utilized (tipping point) */
 	bool			overutilized;
 
 	/*
@@ -1165,7 +1165,7 @@ struct rq {
 #endif
 
 #ifdef CONFIG_CPU_IDLE
-	/* Must be inspected within a rcu lock section */
+	/* Must be inspected within a RCU lock section */
 	struct cpuidle_state	*idle_state;
 #endif
 
@@ -3317,7 +3317,7 @@ static inline void __mm_cid_put(struct mm_struct *mm, int cid)
  * be held to transition to other states.
  *
  * State transitions synchronized with cmpxchg or try_cmpxchg need to be
- * consistent across cpus, which prevents use of this_cpu_cmpxchg.
+ * consistent across CPUs, which prevents use of this_cpu_cmpxchg.
  */
 static inline void mm_cid_put_lazy(struct task_struct *t)
 {
diff --git a/kernel/sched/stats.h b/kernel/sched/stats.h
index 38f3698..d144541 100644
--- a/kernel/sched/stats.h
+++ b/kernel/sched/stats.h
@@ -219,7 +219,7 @@ static inline void sched_info_dequeue(struct rq *rq, struct task_struct *t)
 /*
  * Called when a task finally hits the CPU.  We can now calculate how
  * long it was waiting to run.  We also note when it began so that we
- * can keep stats on how long its timeslice is.
+ * can keep stats on how long its time-slice is.
  */
 static void sched_info_arrive(struct rq *rq, struct task_struct *t)
 {
diff --git a/kernel/sched/syscalls.c b/kernel/sched/syscalls.c
index 093f936..ae1b427 100644
--- a/kernel/sched/syscalls.c
+++ b/kernel/sched/syscalls.c
@@ -273,9 +273,9 @@ int sched_core_idle_cpu(int cpu)
  *
  * The cfs,rt,dl utilization are the running times measured with rq->clock_task
  * which excludes things like IRQ and steal-time. These latter are then accrued
- * in the irq utilization.
+ * in the IRQ utilization.
  *
- * The DL bandwidth number otoh is not a measured metric but a value computed
+ * The DL bandwidth number OTOH is not a measured metric but a value computed
  * based on the task model parameters and gives the minimal utilization
  * required to meet deadlines.
  */
@@ -340,7 +340,7 @@ unsigned long effective_cpu_util(int cpu, unsigned long util_cfs,
 
 	/*
 	 * There is still idle time; further improve the number by using the
-	 * irq metric. Because IRQ/steal time is hidden from the task clock we
+	 * IRQ metric. Because IRQ/steal time is hidden from the task clock we
 	 * need to scale the task numbers:
 	 *
 	 *              max - irq
@@ -718,7 +718,7 @@ change:
 	if (user) {
 #ifdef CONFIG_RT_GROUP_SCHED
 		/*
-		 * Do not allow realtime tasks into groups that have no runtime
+		 * Do not allow real-time tasks into groups that have no runtime
 		 * assigned.
 		 */
 		if (rt_bandwidth_enabled() && rt_policy(policy) &&
@@ -885,7 +885,7 @@ int sched_setattr_nocheck(struct task_struct *p, const struct sched_attr *attr)
 EXPORT_SYMBOL_GPL(sched_setattr_nocheck);
 
 /**
- * sched_setscheduler_nocheck - change the scheduling policy and/or RT priority of a thread from kernelspace.
+ * sched_setscheduler_nocheck - change the scheduling policy and/or RT priority of a thread from kernel-space.
  * @p: the task in question.
  * @policy: new policy.
  * @param: structure containing the new RT priority.
@@ -1663,14 +1663,14 @@ static int sched_rr_get_interval(pid_t pid, struct timespec64 *t)
 }
 
 /**
- * sys_sched_rr_get_interval - return the default timeslice of a process.
+ * sys_sched_rr_get_interval - return the default time-slice of a process.
  * @pid: pid of the process.
- * @interval: userspace pointer to the timeslice value.
+ * @interval: userspace pointer to the time-slice value.
  *
- * this syscall writes the default timeslice value of a given process
+ * this syscall writes the default time-slice value of a given process
  * into the user-space timespec buffer. A value of '0' means infinity.
  *
- * Return: On success, 0 and the timeslice is in @interval. Otherwise,
+ * Return: On success, 0 and the time-slice is in @interval. Otherwise,
  * an error code.
  */
 SYSCALL_DEFINE2(sched_rr_get_interval, pid_t, pid,
diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
index a6994a1..784a0be 100644
--- a/kernel/sched/topology.c
+++ b/kernel/sched/topology.c
@@ -501,7 +501,7 @@ void rq_attach_root(struct rq *rq, struct root_domain *rd)
 		cpumask_clear_cpu(rq->cpu, old_rd->span);
 
 		/*
-		 * If we dont want to free the old_rd yet then
+		 * If we don't want to free the old_rd yet then
 		 * set old_rd to NULL to skip the freeing later
 		 * in this function:
 		 */
@@ -1176,7 +1176,7 @@ fail:
  * uniquely identify each group (for a given domain):
  *
  *  - The first is the balance_cpu (see should_we_balance() and the
- *    load-balance blub in fair.c); for each group we only want 1 CPU to
+ *    load-balance blurb in fair.c); for each group we only want 1 CPU to
  *    continue balancing at a higher domain.
  *
  *  - The second is the sched_group_capacity; we want all identical groups
@@ -1388,7 +1388,7 @@ static inline void asym_cpu_capacity_update_data(int cpu)
 
 	/*
 	 * Search if capacity already exits. If not, track which the entry
-	 * where we should insert to keep the list ordered descendingly.
+	 * where we should insert to keep the list ordered descending.
 	 */
 	list_for_each_entry(entry, &asym_cap_list, link) {
 		if (capacity == entry->capacity)
@@ -1853,7 +1853,7 @@ void sched_init_numa(int offline_node)
 	struct cpumask ***masks;
 
 	/*
-	 * O(nr_nodes^2) deduplicating selection sort -- in order to find the
+	 * O(nr_nodes^2) de-duplicating selection sort -- in order to find the
 	 * unique distances in the node_distance() table.
 	 */
 	distance_map = bitmap_alloc(NR_DISTANCE_VALUES, GFP_KERNEL);
@@ -2750,7 +2750,7 @@ match2:
 	}
 
 #if defined(CONFIG_ENERGY_MODEL) && defined(CONFIG_CPU_FREQ_GOV_SCHEDUTIL)
-	/* Build perf. domains: */
+	/* Build perf domains: */
 	for (i = 0; i < ndoms_new; i++) {
 		for (j = 0; j < n && !sched_energy_update; j++) {
 			if (cpumask_equal(doms_new[i], doms_cur[j]) &&
@@ -2759,7 +2759,7 @@ match2:
 				goto match3;
 			}
 		}
-		/* No match - add perf. domains for a new rd */
+		/* No match - add perf domains for a new rd */
 		has_eas |= build_perf_domains(doms_new[i]);
 match3:
 		;
diff --git a/kernel/sched/wait_bit.c b/kernel/sched/wait_bit.c
index 0b1cd98..134d711 100644
--- a/kernel/sched/wait_bit.c
+++ b/kernel/sched/wait_bit.c
@@ -33,7 +33,7 @@ int wake_bit_function(struct wait_queue_entry *wq_entry, unsigned mode, int sync
 EXPORT_SYMBOL(wake_bit_function);
 
 /*
- * To allow interruptible waiting and asynchronous (i.e. nonblocking)
+ * To allow interruptible waiting and asynchronous (i.e. non-blocking)
  * waiting, the actions of __wait_on_bit() and __wait_on_bit_lock() are
  * permitted return codes. Nonzero return codes halt waiting and return.
  */
@@ -133,7 +133,7 @@ EXPORT_SYMBOL(__wake_up_bit);
  * @bit: the bit of the word being waited on
  *
  * There is a standard hashed waitqueue table for generic use. This
- * is the part of the hashtable's accessor API that wakes up waiters
+ * is the part of the hash-table's accessor API that wakes up waiters
  * on a bit. For instance, if one were to have waiters on a bitflag,
  * one would call wake_up_bit() after clearing the bit.
  *

