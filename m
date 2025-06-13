Return-Path: <linux-tip-commits+bounces-5806-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D60E1AD848F
	for <lists+linux-tip-commits@lfdr.de>; Fri, 13 Jun 2025 09:44:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F38753B38F0
	for <lists+linux-tip-commits@lfdr.de>; Fri, 13 Jun 2025 07:42:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2CF62EBDD6;
	Fri, 13 Jun 2025 07:37:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="iufMg9IH";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="jZv/L8di"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AEE32EACEC;
	Fri, 13 Jun 2025 07:37:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749800252; cv=none; b=bt5pnK8nh57kMF0VwMWVBr8bHl7ZS/pRGLtr4pScCUCc38gRELmAwXjMMWXf0OKbO2WykBmN8mOF11Rs8dsjSfHEVZdE/LELzAdSH8PurmPl8bBGpCXm/S51kxnEz4hMdiyzEKwzRcAGkro6IuIeSnicCDssHyw0IdgYP9BWwUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749800252; c=relaxed/simple;
	bh=POBzM27FJu80y1eKo4F2Ce1rg2pYPPUjJsPcI2SrDYM=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=UlqQxn9y+7FG4kF1dNgruLmIhVG7BiWyPLncOH/sYiNpFPDPs7tqcSCc1qEFmB/6ZmMUcznhc0YAZ77UL9DyDUPXJTxNdWP8eLTjUNGFhAnSc1dBEN4aVcA49UImrkn9BDFq9ZPZsJkVwfw/SFqlDLwz85d8GR2ipdNRs2fCoR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=iufMg9IH; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=jZv/L8di; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 13 Jun 2025 07:37:25 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1749800246;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Aqv996/G5BBkX7ew54qIUSkuJQylif43CUmyLvAgYws=;
	b=iufMg9IHjh0q7FVIqFJL6P+BtahL1W0EjW1oqQsigcEqEkNJmZpqmE3K4yp2/FHqRdm97D
	4Qtgwjfamv3lIOqKuD9B5wFApU/uwa4dmSNGMqDA+d9RST9ubncsQ4MbdEIQBIDpXztZGB
	e3705Ch5aaCEBf/qgBc6UrJrquAMFXbfNylXNKhcWET4eNHqcvmLloHh0M2s6B7WWjVCHr
	I7ux2SUoGwrrkK9Spl10aAxQ/Biz4memaD3j8PW7j0Q3rOHvI8dI6FbIMc+wQQldj1ip80
	V1wnixeh6WFu0PrPooW6Tv4BWHvsRjZL/x2u46lo5pJmaMBx/m4Qem9/4eQ2jg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1749800246;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Aqv996/G5BBkX7ew54qIUSkuJQylif43CUmyLvAgYws=;
	b=jZv/L8di7azSlf3eOEkDfBOAg5doFXLmnjLYsK27sXZ/hkrT4dXfSqINWXhsCiofiXM9ld
	KGmco41aj0+bfUBQ==
From: "tip-bot2 for Ingo Molnar" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/smp: Make SMP unconditional
Cc: Ingo Molnar <mingo@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Juri Lelli <juri.lelli@redhat.com>,
 Linus Torvalds <torvalds@linux-foundation.org>, Mel Gorman <mgorman@suse.de>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Shrikanth Hegde <sshegde@linux.ibm.com>, Steven Rostedt <rostedt@goodmis.org>,
 Valentin Schneider <vschneid@redhat.com>,
 Vincent Guittot <vincent.guittot@linaro.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250528080924.2273858-21-mingo@kernel.org>
References: <20250528080924.2273858-21-mingo@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174980024569.406.16996582207039188385.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     cac5cefbade90ff0bb0b393d301fa3b5234cf056
Gitweb:        https://git.kernel.org/tip/cac5cefbade90ff0bb0b393d301fa3b5234cf056
Author:        Ingo Molnar <mingo@kernel.org>
AuthorDate:    Wed, 28 May 2025 10:09:01 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Fri, 13 Jun 2025 08:47:18 +02:00

sched/smp: Make SMP unconditional

Simplify the scheduler by making CONFIG_SMP=y primitives and data
structures unconditional.

Introduce transitory wrappers for functionality not yet converted to SMP.

Note that this patch is pretty large, because there's no clear separation
between various aspects of the SMP scheduler, it's basically a huge block
of #ifdef CONFIG_SMP. A fair amount of it has to be switched on for it to
boot and work on UP systems.

Signed-off-by: Ingo Molnar <mingo@kernel.org>
Acked-by: Peter Zijlstra <peterz@infradead.org>
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc: Juri Lelli <juri.lelli@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Mel Gorman <mgorman@suse.de>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Shrikanth Hegde <sshegde@linux.ibm.com>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Valentin Schneider <vschneid@redhat.com>
Cc: Vincent Guittot <vincent.guittot@linaro.org>
Link: https://lore.kernel.org/r/20250528080924.2273858-21-mingo@kernel.org
---
 include/linux/preempt.h        |   9 +--
 include/linux/sched.h          |  42 +-----------
 include/linux/sched/deadline.h |   4 +-
 include/linux/sched/idle.h     |   4 +-
 include/linux/sched/nohz.h     |   4 +-
 include/linux/sched/topology.h |  32 +--------
 kernel/sched/build_policy.c    |   6 +--
 kernel/sched/build_utility.c   |   6 +--
 kernel/sched/core.c            | 106 +++-------------------------
 kernel/sched/cpudeadline.h     |   2 +-
 kernel/sched/cpupri.h          |   2 +-
 kernel/sched/deadline.c        |  95 +-------------------------
 kernel/sched/debug.c           |  12 +---
 kernel/sched/fair.c            | 115 +------------------------------
 kernel/sched/pelt.h            |  52 +--------------
 kernel/sched/rt.c              |   6 +-
 kernel/sched/sched.h           | 121 +--------------------------------
 kernel/sched/syscalls.c        |   2 +-
 kernel/sched/topology.c        |  10 +---
 19 files changed, 31 insertions(+), 599 deletions(-)

diff --git a/include/linux/preempt.h b/include/linux/preempt.h
index b0af8d4..1fad1c8 100644
--- a/include/linux/preempt.h
+++ b/include/linux/preempt.h
@@ -369,8 +369,6 @@ static inline void preempt_notifier_init(struct preempt_notifier *notifier,
 
 #endif
 
-#ifdef CONFIG_SMP
-
 /*
  * Migrate-Disable and why it is undesired.
  *
@@ -429,13 +427,6 @@ static inline void preempt_notifier_init(struct preempt_notifier *notifier,
 extern void migrate_disable(void);
 extern void migrate_enable(void);
 
-#else
-
-static inline void migrate_disable(void) { }
-static inline void migrate_enable(void) { }
-
-#endif /* CONFIG_SMP */
-
 /**
  * preempt_disable_nested - Disable preemption inside a normally preempt disabled section
  *
diff --git a/include/linux/sched.h b/include/linux/sched.h
index aa54d75..376befd 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -599,7 +599,6 @@ struct sched_entity {
 	unsigned long			runnable_weight;
 #endif
 
-#ifdef CONFIG_SMP
 	/*
 	 * Per entity load average tracking.
 	 *
@@ -607,7 +606,6 @@ struct sched_entity {
 	 * collide with read-mostly values above.
 	 */
 	struct sched_avg		avg;
-#endif
 };
 
 struct sched_rt_entity {
@@ -837,7 +835,6 @@ struct task_struct {
 	struct alloc_tag		*alloc_tag;
 #endif
 
-#ifdef CONFIG_SMP
 	int				on_cpu;
 	struct __call_single_node	wake_entry;
 	unsigned int			wakee_flips;
@@ -853,7 +850,6 @@ struct task_struct {
 	 */
 	int				recent_used_cpu;
 	int				wake_cpu;
-#endif
 	int				on_rq;
 
 	int				prio;
@@ -912,9 +908,7 @@ struct task_struct {
 	cpumask_t			*user_cpus_ptr;
 	cpumask_t			cpus_mask;
 	void				*migration_pending;
-#ifdef CONFIG_SMP
 	unsigned short			migration_disabled;
-#endif
 	unsigned short			migration_flags;
 
 #ifdef CONFIG_PREEMPT_RCU
@@ -946,10 +940,8 @@ struct task_struct {
 	struct sched_info		sched_info;
 
 	struct list_head		tasks;
-#ifdef CONFIG_SMP
 	struct plist_node		pushable_tasks;
 	struct rb_node			pushable_dl_tasks;
-#endif
 
 	struct mm_struct		*mm;
 	struct mm_struct		*active_mm;
@@ -1843,7 +1835,6 @@ extern int cpuset_cpumask_can_shrink(const struct cpumask *cur, const struct cpu
 extern int task_can_attach(struct task_struct *p);
 extern int dl_bw_alloc(int cpu, u64 dl_bw);
 extern void dl_bw_free(int cpu, u64 dl_bw);
-#ifdef CONFIG_SMP
 
 /* do_set_cpus_allowed() - consider using set_cpus_allowed_ptr() instead */
 extern void do_set_cpus_allowed(struct task_struct *p, const struct cpumask *new_mask);
@@ -1861,33 +1852,6 @@ extern void release_user_cpus_ptr(struct task_struct *p);
 extern int dl_task_check_affinity(struct task_struct *p, const struct cpumask *mask);
 extern void force_compatible_cpus_allowed_ptr(struct task_struct *p);
 extern void relax_compatible_cpus_allowed_ptr(struct task_struct *p);
-#else
-static inline void do_set_cpus_allowed(struct task_struct *p, const struct cpumask *new_mask)
-{
-}
-static inline int set_cpus_allowed_ptr(struct task_struct *p, const struct cpumask *new_mask)
-{
-	/* Opencoded cpumask_test_cpu(0, new_mask) to avoid dependency on cpumask.h */
-	if ((*cpumask_bits(new_mask) & 1) == 0)
-		return -EINVAL;
-	return 0;
-}
-static inline int dup_user_cpus_ptr(struct task_struct *dst, struct task_struct *src, int node)
-{
-	if (src->user_cpus_ptr)
-		return -EINVAL;
-	return 0;
-}
-static inline void release_user_cpus_ptr(struct task_struct *p)
-{
-	WARN_ON(p->user_cpus_ptr);
-}
-
-static inline int dl_task_check_affinity(struct task_struct *p, const struct cpumask *mask)
-{
-	return 0;
-}
-#endif
 
 extern int yield_to(struct task_struct *p, bool preempt);
 extern void set_user_nice(struct task_struct *p, long nice);
@@ -1976,11 +1940,7 @@ extern int wake_up_state(struct task_struct *tsk, unsigned int state);
 extern int wake_up_process(struct task_struct *tsk);
 extern void wake_up_new_task(struct task_struct *tsk);
 
-#ifdef CONFIG_SMP
 extern void kick_process(struct task_struct *tsk);
-#else
-static inline void kick_process(struct task_struct *tsk) { }
-#endif
 
 extern void __set_task_comm(struct task_struct *tsk, const char *from, bool exec);
 #define set_task_comm(tsk, from) ({			\
@@ -2225,7 +2185,6 @@ extern long sched_getaffinity(pid_t pid, struct cpumask *mask);
 #define TASK_SIZE_OF(tsk)	TASK_SIZE
 #endif
 
-#ifdef CONFIG_SMP
 static inline bool owner_on_cpu(struct task_struct *owner)
 {
 	/*
@@ -2237,7 +2196,6 @@ static inline bool owner_on_cpu(struct task_struct *owner)
 
 /* Returns effective CPU energy utilization, as seen by the scheduler */
 unsigned long sched_cpu_util(int cpu);
-#endif /* CONFIG_SMP */
 
 #ifdef CONFIG_SCHED_CORE
 extern void sched_core_free(struct task_struct *tsk);
diff --git a/include/linux/sched/deadline.h b/include/linux/sched/deadline.h
index f9aabbc..c40115d 100644
--- a/include/linux/sched/deadline.h
+++ b/include/linux/sched/deadline.h
@@ -29,15 +29,11 @@ static inline bool dl_time_before(u64 a, u64 b)
 	return (s64)(a - b) < 0;
 }
 
-#ifdef CONFIG_SMP
-
 struct root_domain;
 extern void dl_add_task_root_domain(struct task_struct *p);
 extern void dl_clear_root_domain(struct root_domain *rd);
 extern void dl_clear_root_domain_cpu(int cpu);
 
-#endif /* CONFIG_SMP */
-
 extern u64 dl_cookie;
 extern bool dl_bw_visited(int cpu, u64 cookie);
 
diff --git a/include/linux/sched/idle.h b/include/linux/sched/idle.h
index 439f602..8465ff1 100644
--- a/include/linux/sched/idle.h
+++ b/include/linux/sched/idle.h
@@ -11,11 +11,7 @@ enum cpu_idle_type {
 	CPU_MAX_IDLE_TYPES
 };
 
-#ifdef CONFIG_SMP
 extern void wake_up_if_idle(int cpu);
-#else
-static inline void wake_up_if_idle(int cpu) { }
-#endif
 
 /*
  * Idle thread specific functions to determine the need_resched
diff --git a/include/linux/sched/nohz.h b/include/linux/sched/nohz.h
index 6d67e9a..0db7f67 100644
--- a/include/linux/sched/nohz.h
+++ b/include/linux/sched/nohz.h
@@ -6,7 +6,7 @@
  * This is the interface between the scheduler and nohz/dynticks:
  */
 
-#if defined(CONFIG_SMP) && defined(CONFIG_NO_HZ_COMMON)
+#ifdef CONFIG_NO_HZ_COMMON
 extern void nohz_balance_enter_idle(int cpu);
 extern int get_nohz_timer_target(void);
 #else
@@ -23,7 +23,7 @@ static inline void calc_load_nohz_remote(struct rq *rq) { }
 static inline void calc_load_nohz_stop(void) { }
 #endif /* CONFIG_NO_HZ_COMMON */
 
-#if defined(CONFIG_NO_HZ_COMMON) && defined(CONFIG_SMP)
+#ifdef CONFIG_NO_HZ_COMMON
 extern void wake_up_nohz_cpu(int cpu);
 #else
 static inline void wake_up_nohz_cpu(int cpu) { }
diff --git a/include/linux/sched/topology.h b/include/linux/sched/topology.h
index 198bb5c..e54e7fa 100644
--- a/include/linux/sched/topology.h
+++ b/include/linux/sched/topology.h
@@ -9,7 +9,6 @@
 /*
  * sched-domains (multiprocessor balancing) declarations:
  */
-#ifdef CONFIG_SMP
 
 /* Generate SD flag indexes */
 #define SD_FLAG(name, mflags) __##name,
@@ -200,37 +199,6 @@ extern void sched_update_asym_prefer_cpu(int cpu, int old_prio, int new_prio);
 
 # define SD_INIT_NAME(type)		.name = #type
 
-#else /* CONFIG_SMP */
-
-struct sched_domain_attr;
-
-static inline void
-partition_sched_domains(int ndoms_new, cpumask_var_t doms_new[],
-			struct sched_domain_attr *dattr_new)
-{
-}
-
-static inline bool cpus_equal_capacity(int this_cpu, int that_cpu)
-{
-	return true;
-}
-
-static inline bool cpus_share_cache(int this_cpu, int that_cpu)
-{
-	return true;
-}
-
-static inline bool cpus_share_resources(int this_cpu, int that_cpu)
-{
-	return true;
-}
-
-static inline void sched_update_asym_prefer_cpu(int cpu, int old_prio, int new_prio)
-{
-}
-
-#endif	/* !CONFIG_SMP */
-
 #if defined(CONFIG_ENERGY_MODEL) && defined(CONFIG_CPU_FREQ_GOV_SCHEDUTIL)
 extern void rebuild_sched_domains_energy(void);
 #else
diff --git a/kernel/sched/build_policy.c b/kernel/sched/build_policy.c
index 72d97aa..c4a488e 100644
--- a/kernel/sched/build_policy.c
+++ b/kernel/sched/build_policy.c
@@ -50,11 +50,9 @@
 #include "idle.c"
 
 #include "rt.c"
+#include "cpudeadline.c"
 
-#ifdef CONFIG_SMP
-# include "cpudeadline.c"
-# include "pelt.c"
-#endif
+#include "pelt.c"
 
 #include "cputime.c"
 #include "deadline.c"
diff --git a/kernel/sched/build_utility.c b/kernel/sched/build_utility.c
index 5c485b2..e2cf3b0 100644
--- a/kernel/sched/build_utility.c
+++ b/kernel/sched/build_utility.c
@@ -80,10 +80,8 @@
 #include "wait_bit.c"
 #include "wait.c"
 
-#ifdef CONFIG_SMP
-# include "cpupri.c"
-# include "stop_task.c"
-#endif
+#include "cpupri.c"
+#include "stop_task.c"
 
 #include "topology.c"
 
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index f1ef6d2..9fc44f4 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -650,7 +650,6 @@ void raw_spin_rq_unlock(struct rq *rq)
 	raw_spin_unlock(rq_lockp(rq));
 }
 
-#ifdef CONFIG_SMP
 /*
  * double_rq_lock - safely lock two runqueues
  */
@@ -667,7 +666,6 @@ void double_rq_lock(struct rq *rq1, struct rq *rq2)
 
 	double_rq_clock_clear_update(rq1, rq2);
 }
-#endif /* CONFIG_SMP */
 
 /*
  * __task_rq_lock - lock the rq @p resides on.
@@ -949,7 +947,7 @@ static inline void hrtick_rq_init(struct rq *rq)
 	_val;								\
 })
 
-#if defined(CONFIG_SMP) && defined(TIF_POLLING_NRFLAG)
+#ifdef TIF_POLLING_NRFLAG
 /*
  * Atomically set TIF_NEED_RESCHED and test for TIF_POLLING_NRFLAG,
  * this avoids any races wrt polling state changes and thereby avoids
@@ -988,13 +986,11 @@ static inline bool set_nr_and_not_polling(struct thread_info *ti, int tif)
 	return true;
 }
 
-#ifdef CONFIG_SMP
 static inline bool set_nr_if_polling(struct task_struct *p)
 {
 	return false;
 }
 #endif
-#endif
 
 static bool __wake_q_add(struct wake_q_head *head, struct task_struct *task)
 {
@@ -1167,7 +1163,6 @@ void resched_cpu(int cpu)
 	raw_spin_rq_unlock_irqrestore(rq, flags);
 }
 
-#ifdef CONFIG_SMP
 #ifdef CONFIG_NO_HZ_COMMON
 /*
  * In the semi idle case, use the nearest busy CPU for migrating timers
@@ -1374,10 +1369,8 @@ bool sched_can_stop_tick(struct rq *rq)
 	return true;
 }
 #endif /* CONFIG_NO_HZ_FULL */
-#endif /* CONFIG_SMP */
 
-#if defined(CONFIG_RT_GROUP_SCHED) || (defined(CONFIG_FAIR_GROUP_SCHED) && \
-			(defined(CONFIG_SMP) || defined(CONFIG_CFS_BANDWIDTH)))
+#if defined(CONFIG_RT_GROUP_SCHED) || defined(CONFIG_FAIR_GROUP_SCHED)
 /*
  * Iterate task_group tree rooted at *from, calling @down when first entering a
  * node and @up when leaving it for the final time.
@@ -2353,8 +2346,6 @@ unsigned long wait_task_inactive(struct task_struct *p, unsigned int match_state
 	return ncsw;
 }
 
-#ifdef CONFIG_SMP
-
 static void
 __do_set_cpus_allowed(struct task_struct *p, struct affinity_context *ctx);
 
@@ -3305,6 +3296,8 @@ void relax_compatible_cpus_allowed_ptr(struct task_struct *p)
 	WARN_ON_ONCE(ret);
 }
 
+#ifdef CONFIG_SMP
+
 void set_task_cpu(struct task_struct *p, unsigned int new_cpu)
 {
 	unsigned int state = READ_ONCE(p->__state);
@@ -3358,6 +3351,7 @@ void set_task_cpu(struct task_struct *p, unsigned int new_cpu)
 
 	__set_task_cpu(p, new_cpu);
 }
+#endif /* CONFIG_SMP */
 
 #ifdef CONFIG_NUMA_BALANCING
 static void __migrate_swap_task(struct task_struct *p, int cpu)
@@ -3661,17 +3655,6 @@ void sched_set_stop_task(int cpu, struct task_struct *stop)
 	}
 }
 
-#else /* !CONFIG_SMP: */
-
-static inline void migrate_disable_switch(struct rq *rq, struct task_struct *p) { }
-
-static inline bool rq_has_pinned_tasks(struct rq *rq)
-{
-	return false;
-}
-
-#endif /* !CONFIG_SMP */
-
 static void
 ttwu_stat(struct task_struct *p, int cpu, int wake_flags)
 {
@@ -3682,7 +3665,6 @@ ttwu_stat(struct task_struct *p, int cpu, int wake_flags)
 
 	rq = this_rq();
 
-#ifdef CONFIG_SMP
 	if (cpu == rq->cpu) {
 		__schedstat_inc(rq->ttwu_local);
 		__schedstat_inc(p->stats.nr_wakeups_local);
@@ -3702,7 +3684,6 @@ ttwu_stat(struct task_struct *p, int cpu, int wake_flags)
 
 	if (wake_flags & WF_MIGRATED)
 		__schedstat_inc(p->stats.nr_wakeups_migrate);
-#endif /* CONFIG_SMP */
 
 	__schedstat_inc(rq->ttwu_count);
 	__schedstat_inc(p->stats.nr_wakeups);
@@ -3731,13 +3712,11 @@ ttwu_do_activate(struct rq *rq, struct task_struct *p, int wake_flags,
 	if (p->sched_contributes_to_load)
 		rq->nr_uninterruptible--;
 
-#ifdef CONFIG_SMP
 	if (wake_flags & WF_RQ_SELECTED)
 		en_flags |= ENQUEUE_RQ_SELECTED;
 	if (wake_flags & WF_MIGRATED)
 		en_flags |= ENQUEUE_MIGRATED;
 	else
-#endif
 	if (p->in_iowait) {
 		delayacct_blkio_end(p);
 		atomic_dec(&task_rq(p)->nr_iowait);
@@ -3748,7 +3727,6 @@ ttwu_do_activate(struct rq *rq, struct task_struct *p, int wake_flags,
 
 	ttwu_do_wakeup(p);
 
-#ifdef CONFIG_SMP
 	if (p->sched_class->task_woken) {
 		/*
 		 * Our task @p is fully woken up and running; so it's safe to
@@ -3770,7 +3748,6 @@ ttwu_do_activate(struct rq *rq, struct task_struct *p, int wake_flags,
 
 		rq->idle_stamp = 0;
 	}
-#endif /* CONFIG_SMP */
 }
 
 /*
@@ -3824,7 +3801,6 @@ static int ttwu_runnable(struct task_struct *p, int wake_flags)
 	return ret;
 }
 
-#ifdef CONFIG_SMP
 void sched_ttwu_pending(void *arg)
 {
 	struct llist_node *llist = arg;
@@ -3891,7 +3867,9 @@ static void __ttwu_queue_wakelist(struct task_struct *p, int cpu, int wake_flags
 	p->sched_remote_wakeup = !!(wake_flags & WF_MIGRATED);
 
 	WRITE_ONCE(rq->ttwu_pending, 1);
+#ifdef CONFIG_SMP
 	__smp_call_single_queue(cpu, &p->wake_entry.llist);
+#endif
 }
 
 void wake_up_if_idle(int cpu)
@@ -3992,15 +3970,6 @@ static bool ttwu_queue_wakelist(struct task_struct *p, int cpu, int wake_flags)
 	return false;
 }
 
-#else /* !CONFIG_SMP: */
-
-static inline bool ttwu_queue_wakelist(struct task_struct *p, int cpu, int wake_flags)
-{
-	return false;
-}
-
-#endif /* !CONFIG_SMP */
-
 static void ttwu_queue(struct task_struct *p, int cpu, int wake_flags)
 {
 	struct rq *rq = cpu_rq(cpu);
@@ -4533,10 +4502,8 @@ static void __sched_fork(unsigned long clone_flags, struct task_struct *p)
 	p->capture_control = NULL;
 #endif
 	init_numa_balancing(clone_flags, p);
-#ifdef CONFIG_SMP
 	p->wake_entry.u_flags = CSD_TYPE_TTWU;
 	p->migration_pending = NULL;
-#endif
 	init_sched_mm_cid(p);
 }
 
@@ -4787,14 +4754,11 @@ int sched_fork(unsigned long clone_flags, struct task_struct *p)
 	if (likely(sched_info_on()))
 		memset(&p->sched_info, 0, sizeof(p->sched_info));
 #endif
-#ifdef CONFIG_SMP
 	p->on_cpu = 0;
-#endif
 	init_task_preempt_count(p);
-#ifdef CONFIG_SMP
 	plist_node_init(&p->pushable_tasks, MAX_PRIO);
 	RB_CLEAR_NODE(&p->pushable_dl_tasks);
-#endif
+
 	return 0;
 }
 
@@ -4871,7 +4835,6 @@ void wake_up_new_task(struct task_struct *p)
 
 	raw_spin_lock_irqsave(&p->pi_lock, rf.flags);
 	WRITE_ONCE(p->__state, TASK_RUNNING);
-#ifdef CONFIG_SMP
 	/*
 	 * Fork balancing, do it here and not earlier because:
 	 *  - cpus_ptr can change in the fork path
@@ -4883,7 +4846,6 @@ void wake_up_new_task(struct task_struct *p)
 	p->recent_used_cpu = task_cpu(p);
 	rseq_migrate(p);
 	__set_task_cpu(p, select_task_rq(p, task_cpu(p), &wake_flags));
-#endif
 	rq = __task_rq_lock(p, &rf);
 	update_rq_clock(rq);
 	post_init_entity_util_avg(p);
@@ -4994,7 +4956,6 @@ fire_sched_out_preempt_notifiers(struct task_struct *curr,
 
 static inline void prepare_task(struct task_struct *next)
 {
-#ifdef CONFIG_SMP
 	/*
 	 * Claim the task as running, we do this before switching to it
 	 * such that any running task will have this set.
@@ -5003,12 +4964,10 @@ static inline void prepare_task(struct task_struct *next)
 	 * its ordering comment.
 	 */
 	WRITE_ONCE(next->on_cpu, 1);
-#endif
 }
 
 static inline void finish_task(struct task_struct *prev)
 {
-#ifdef CONFIG_SMP
 	/*
 	 * This must be the very last reference to @prev from this CPU. After
 	 * p->on_cpu is cleared, the task can be moved to a different CPU. We
@@ -5021,11 +4980,8 @@ static inline void finish_task(struct task_struct *prev)
 	 * Pairs with the smp_cond_load_acquire() in try_to_wake_up().
 	 */
 	smp_store_release(&prev->on_cpu, 0);
-#endif
 }
 
-#ifdef CONFIG_SMP
-
 static void do_balance_callbacks(struct rq *rq, struct balance_callback *head)
 {
 	void (*func)(struct rq *rq);
@@ -5107,14 +5063,6 @@ void balance_callbacks(struct rq *rq, struct balance_callback *head)
 	}
 }
 
-#else /* !CONFIG_SMP: */
-
-static inline void __balance_callbacks(struct rq *rq)
-{
-}
-
-#endif /* !CONFIG_SMP */
-
 static inline void
 prepare_lock_switch(struct rq *rq, struct task_struct *next, struct rq_flags *rf)
 {
@@ -5563,7 +5511,7 @@ unsigned long long task_sched_runtime(struct task_struct *p)
 	struct rq *rq;
 	u64 ns;
 
-#if defined(CONFIG_64BIT) && defined(CONFIG_SMP)
+#ifdef CONFIG_64BIT
 	/*
 	 * 64-bit doesn't need locks to atomically read a 64-bit value.
 	 * So we have a optimization chance when the task's delta_exec is 0.
@@ -5690,12 +5638,10 @@ void sched_tick(void)
 	if (donor->flags & PF_WQ_WORKER)
 		wq_worker_tick(donor);
 
-#ifdef CONFIG_SMP
 	if (!scx_switched_all()) {
 		rq->idle_balance = idle_cpu(cpu);
 		sched_balance_trigger(rq);
 	}
-#endif
 }
 
 #ifdef CONFIG_NO_HZ_FULL
@@ -7819,12 +7765,10 @@ void show_state_filter(unsigned int state_filter)
  */
 void __init init_idle(struct task_struct *idle, int cpu)
 {
-#ifdef CONFIG_SMP
 	struct affinity_context ac = (struct affinity_context) {
 		.new_mask  = cpumask_of(cpu),
 		.flags     = 0,
 	};
-#endif
 	struct rq *rq = cpu_rq(cpu);
 	unsigned long flags;
 
@@ -7840,13 +7784,11 @@ void __init init_idle(struct task_struct *idle, int cpu)
 	idle->flags |= PF_KTHREAD | PF_NO_SETAFFINITY;
 	kthread_set_per_cpu(idle, cpu);
 
-#ifdef CONFIG_SMP
 	/*
 	 * No validation and serialization required at boot time and for
 	 * setting up the idle tasks of not yet online CPUs.
 	 */
 	set_cpus_allowed_common(idle, &ac);
-#endif
 	/*
 	 * We're having a chicken and egg problem, even though we are
 	 * holding rq->lock, the CPU isn't yet set to this CPU so the
@@ -7865,9 +7807,7 @@ void __init init_idle(struct task_struct *idle, int cpu)
 	rq_set_donor(rq, idle);
 	rcu_assign_pointer(rq->curr, idle);
 	idle->on_rq = TASK_ON_RQ_QUEUED;
-#ifdef CONFIG_SMP
 	idle->on_cpu = 1;
-#endif
 	raw_spin_rq_unlock(rq);
 	raw_spin_unlock_irqrestore(&idle->pi_lock, flags);
 
@@ -7880,13 +7820,9 @@ void __init init_idle(struct task_struct *idle, int cpu)
 	idle->sched_class = &idle_sched_class;
 	ftrace_graph_init_idle_task(idle, cpu);
 	vtime_init_idle(idle, cpu);
-#ifdef CONFIG_SMP
 	sprintf(idle->comm, "%s/%d", INIT_TASK_COMM, cpu);
-#endif
 }
 
-#ifdef CONFIG_SMP
-
 int cpuset_cpumask_can_shrink(const struct cpumask *cur,
 			      const struct cpumask *trial)
 {
@@ -8480,13 +8416,6 @@ static int __init migration_init(void)
 }
 early_initcall(migration_init);
 
-#else /* !CONFIG_SMP: */
-void __init sched_init_smp(void)
-{
-	sched_init_granularity();
-}
-#endif /* !CONFIG_SMP */
-
 int in_sched_functions(unsigned long addr)
 {
 	return in_lock_functions(addr) ||
@@ -8512,9 +8441,7 @@ void __init sched_init(void)
 	int i;
 
 	/* Make sure the linker didn't screw up */
-#ifdef CONFIG_SMP
 	BUG_ON(!sched_class_above(&stop_sched_class, &dl_sched_class));
-#endif
 	BUG_ON(!sched_class_above(&dl_sched_class, &rt_sched_class));
 	BUG_ON(!sched_class_above(&rt_sched_class, &fair_sched_class));
 	BUG_ON(!sched_class_above(&fair_sched_class, &idle_sched_class));
@@ -8557,9 +8484,7 @@ void __init sched_init(void)
 #endif /* CONFIG_RT_GROUP_SCHED */
 	}
 
-#ifdef CONFIG_SMP
 	init_defrootdomain();
-#endif
 
 #ifdef CONFIG_RT_GROUP_SCHED
 	init_rt_bandwidth(&root_task_group.rt_bandwidth,
@@ -8620,7 +8545,6 @@ void __init sched_init(void)
 		rq->rt.rt_runtime = global_rt_runtime();
 		init_tg_rt_entry(&root_task_group, &rq->rt, NULL, i, NULL);
 #endif
-#ifdef CONFIG_SMP
 		rq->sd = NULL;
 		rq->rd = NULL;
 		rq->cpu_capacity = SCHED_CAPACITY_SCALE;
@@ -8637,16 +8561,15 @@ void __init sched_init(void)
 		INIT_LIST_HEAD(&rq->cfs_tasks);
 
 		rq_attach_root(rq, &def_root_domain);
-# ifdef CONFIG_NO_HZ_COMMON
+#ifdef CONFIG_NO_HZ_COMMON
 		rq->last_blocked_load_update_tick = jiffies;
 		atomic_set(&rq->nohz_flags, 0);
 
 		INIT_CSD(&rq->nohz_csd, nohz_csd_func, rq);
-# endif
-# ifdef CONFIG_HOTPLUG_CPU
+#endif
+#ifdef CONFIG_HOTPLUG_CPU
 		rcuwait_init(&rq->hotplug_wait);
-# endif
-#endif /* CONFIG_SMP */
+#endif
 		hrtick_rq_init(rq);
 		atomic_set(&rq->nr_iowait, 0);
 		fair_server_init(rq);
@@ -8696,8 +8619,9 @@ void __init sched_init(void)
 
 #ifdef CONFIG_SMP
 	idle_thread_set_boot_cpu();
-	balance_push_set(smp_processor_id(), false);
 #endif
+
+	balance_push_set(smp_processor_id(), false);
 	init_sched_fair_class();
 	init_sched_ext_class();
 
diff --git a/kernel/sched/cpudeadline.h b/kernel/sched/cpudeadline.h
index 3f7c73d..11c0f1f 100644
--- a/kernel/sched/cpudeadline.h
+++ b/kernel/sched/cpudeadline.h
@@ -17,7 +17,6 @@ struct cpudl {
 	struct cpudl_item	*elements;
 };
 
-#ifdef CONFIG_SMP
 int  cpudl_find(struct cpudl *cp, struct task_struct *p, struct cpumask *later_mask);
 void cpudl_set(struct cpudl *cp, int cpu, u64 dl);
 void cpudl_clear(struct cpudl *cp, int cpu);
@@ -25,4 +24,3 @@ int  cpudl_init(struct cpudl *cp);
 void cpudl_set_freecpu(struct cpudl *cp, int cpu);
 void cpudl_clear_freecpu(struct cpudl *cp, int cpu);
 void cpudl_cleanup(struct cpudl *cp);
-#endif /* CONFIG_SMP */
diff --git a/kernel/sched/cpupri.h b/kernel/sched/cpupri.h
index 24add19..6f56208 100644
--- a/kernel/sched/cpupri.h
+++ b/kernel/sched/cpupri.h
@@ -20,7 +20,6 @@ struct cpupri {
 	int			*cpu_to_pri;
 };
 
-#ifdef CONFIG_SMP
 int  cpupri_find(struct cpupri *cp, struct task_struct *p,
 		 struct cpumask *lowest_mask);
 int  cpupri_find_fitness(struct cpupri *cp, struct task_struct *p,
@@ -29,4 +28,3 @@ int  cpupri_find_fitness(struct cpupri *cp, struct task_struct *p,
 void cpupri_set(struct cpupri *cp, int cpu, int pri);
 int  cpupri_init(struct cpupri *cp);
 void cpupri_cleanup(struct cpupri *cp);
-#endif /* CONFIG_SMP */
diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index a2cea68..bf9b70a 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -115,7 +115,6 @@ static inline bool is_dl_boosted(struct sched_dl_entity *dl_se)
 }
 #endif /* !CONFIG_RT_MUTEXES */
 
-#ifdef CONFIG_SMP
 static inline struct dl_bw *dl_bw_of(int i)
 {
 	RCU_LOCKDEP_WARN(!rcu_read_lock_sched_held(),
@@ -195,35 +194,6 @@ void __dl_update(struct dl_bw *dl_b, s64 bw)
 		rq->dl.extra_bw += bw;
 	}
 }
-#else /* !CONFIG_SMP: */
-static inline struct dl_bw *dl_bw_of(int i)
-{
-	return &cpu_rq(i)->dl.dl_bw;
-}
-
-static inline int dl_bw_cpus(int i)
-{
-	return 1;
-}
-
-static inline unsigned long dl_bw_capacity(int i)
-{
-	return SCHED_CAPACITY_SCALE;
-}
-
-bool dl_bw_visited(int cpu, u64 cookie)
-{
-	return false;
-}
-
-static inline
-void __dl_update(struct dl_bw *dl_b, s64 bw)
-{
-	struct dl_rq *dl = container_of(dl_b, struct dl_rq, dl_bw);
-
-	dl->extra_bw += bw;
-}
-#endif /* !CONFIG_SMP */
 
 static inline
 void __dl_sub(struct dl_bw *dl_b, u64 tsk_bw, int cpus)
@@ -556,23 +526,17 @@ void init_dl_rq(struct dl_rq *dl_rq)
 {
 	dl_rq->root = RB_ROOT_CACHED;
 
-#ifdef CONFIG_SMP
 	/* zero means no -deadline tasks */
 	dl_rq->earliest_dl.curr = dl_rq->earliest_dl.next = 0;
 
 	dl_rq->overloaded = 0;
 	dl_rq->pushable_dl_tasks_root = RB_ROOT_CACHED;
-#else
-	init_dl_bw(&dl_rq->dl_bw);
-#endif
 
 	dl_rq->running_bw = 0;
 	dl_rq->this_bw = 0;
 	init_dl_rq_bw_ratio(dl_rq);
 }
 
-#ifdef CONFIG_SMP
-
 static inline int dl_overloaded(struct rq *rq)
 {
 	return atomic_read(&rq->rd->dlo_count);
@@ -757,37 +721,6 @@ static struct rq *dl_task_offline_migration(struct rq *rq, struct task_struct *p
 	return later_rq;
 }
 
-#else /* !CONFIG_SMP: */
-
-static inline
-void enqueue_pushable_dl_task(struct rq *rq, struct task_struct *p)
-{
-}
-
-static inline
-void dequeue_pushable_dl_task(struct rq *rq, struct task_struct *p)
-{
-}
-
-static inline
-void inc_dl_migration(struct sched_dl_entity *dl_se, struct dl_rq *dl_rq)
-{
-}
-
-static inline
-void dec_dl_migration(struct sched_dl_entity *dl_se, struct dl_rq *dl_rq)
-{
-}
-
-static inline void deadline_queue_push_tasks(struct rq *rq)
-{
-}
-
-static inline void deadline_queue_pull_task(struct rq *rq)
-{
-}
-#endif /* !CONFIG_SMP */
-
 static void
 enqueue_dl_entity(struct sched_dl_entity *dl_se, int flags);
 static void enqueue_task_dl(struct rq *rq, struct task_struct *p, int flags);
@@ -1199,7 +1132,6 @@ static int start_dl_timer(struct sched_dl_entity *dl_se)
 
 static void __push_dl_task(struct rq *rq, struct rq_flags *rf)
 {
-#ifdef CONFIG_SMP
 	/*
 	 * Queueing this task back might have overloaded rq, check if we need
 	 * to kick someone away.
@@ -1213,7 +1145,6 @@ static void __push_dl_task(struct rq *rq, struct rq_flags *rf)
 		push_dl_task(rq);
 		rq_repin_lock(rq, rf);
 	}
-#endif /* CONFIG_SMP */
 }
 
 /* a defer timer will not be reset if the runtime consumed was < dl_server_min_res */
@@ -1343,7 +1274,6 @@ static enum hrtimer_restart dl_task_timer(struct hrtimer *timer)
 		goto unlock;
 	}
 
-#ifdef CONFIG_SMP
 	if (unlikely(!rq->online)) {
 		/*
 		 * If the runqueue is no longer available, migrate the
@@ -1360,7 +1290,6 @@ static enum hrtimer_restart dl_task_timer(struct hrtimer *timer)
 		 * there.
 		 */
 	}
-#endif /* CONFIG_SMP */
 
 	enqueue_task_dl(rq, p, ENQUEUE_REPLENISH);
 	if (dl_task(rq->donor))
@@ -1848,8 +1777,6 @@ static void init_dl_inactive_task_timer(struct sched_dl_entity *dl_se)
 #define __node_2_dle(node) \
 	rb_entry((node), struct sched_dl_entity, rb_node)
 
-#ifdef CONFIG_SMP
-
 static void inc_dl_deadline(struct dl_rq *dl_rq, u64 deadline)
 {
 	struct rq *rq = rq_of_dl_rq(dl_rq);
@@ -1885,13 +1812,6 @@ static void dec_dl_deadline(struct dl_rq *dl_rq, u64 deadline)
 	}
 }
 
-#else /* !CONFIG_SMP: */
-
-static inline void inc_dl_deadline(struct dl_rq *dl_rq, u64 deadline) {}
-static inline void dec_dl_deadline(struct dl_rq *dl_rq, u64 deadline) {}
-
-#endif /* !CONFIG_SMP */
-
 static inline
 void inc_dl_tasks(struct sched_dl_entity *dl_se, struct dl_rq *dl_rq)
 {
@@ -2218,8 +2138,6 @@ static void yield_task_dl(struct rq *rq)
 	rq_clock_skip_update(rq);
 }
 
-#ifdef CONFIG_SMP
-
 static inline bool dl_task_is_earliest_deadline(struct task_struct *p,
 						 struct rq *rq)
 {
@@ -2349,7 +2267,6 @@ static int balance_dl(struct rq *rq, struct task_struct *p, struct rq_flags *rf)
 
 	return sched_stop_runnable(rq) || sched_dl_runnable(rq);
 }
-#endif /* CONFIG_SMP */
 
 /*
  * Only called when both the current and waking task are -deadline
@@ -2363,7 +2280,6 @@ static void wakeup_preempt_dl(struct rq *rq, struct task_struct *p,
 		return;
 	}
 
-#ifdef CONFIG_SMP
 	/*
 	 * In the unlikely case current and p have the same deadline
 	 * let us try to decide what's the best thing to do...
@@ -2371,7 +2287,6 @@ static void wakeup_preempt_dl(struct rq *rq, struct task_struct *p,
 	if ((p->dl.deadline == rq->donor->dl.deadline) &&
 	    !test_tsk_need_resched(rq->curr))
 		check_preempt_equal_dl(rq, p);
-#endif /* CONFIG_SMP */
 }
 
 #ifdef CONFIG_SCHED_HRTICK
@@ -2504,8 +2419,6 @@ static void task_fork_dl(struct task_struct *p)
 	 */
 }
 
-#ifdef CONFIG_SMP
-
 /* Only try algorithms three times */
 #define DL_MAX_TRIES 3
 
@@ -2999,8 +2912,6 @@ void dl_clear_root_domain_cpu(int cpu)
 	dl_clear_root_domain(cpu_rq(cpu)->rd);
 }
 
-#endif /* CONFIG_SMP */
-
 static void switched_from_dl(struct rq *rq, struct task_struct *p)
 {
 	/*
@@ -3073,10 +2984,8 @@ static void switched_to_dl(struct rq *rq, struct task_struct *p)
 	}
 
 	if (rq->donor != p) {
-#ifdef CONFIG_SMP
 		if (p->nr_cpus_allowed > 1 && rq->dl.overloaded)
 			deadline_queue_push_tasks(rq);
-#endif
 		if (dl_task(rq->donor))
 			wakeup_preempt_dl(rq, p, 0);
 		else
@@ -3153,7 +3062,6 @@ DEFINE_SCHED_CLASS(dl) = {
 	.put_prev_task		= put_prev_task_dl,
 	.set_next_task		= set_next_task_dl,
 
-#ifdef CONFIG_SMP
 	.balance		= balance_dl,
 	.select_task_rq		= select_task_rq_dl,
 	.migrate_task_rq	= migrate_task_rq_dl,
@@ -3162,7 +3070,6 @@ DEFINE_SCHED_CLASS(dl) = {
 	.rq_offline             = rq_offline_dl,
 	.task_woken		= task_woken_dl,
 	.find_lock_rq		= find_lock_later_rq,
-#endif /* CONFIG_SMP */
 
 	.task_tick		= task_tick_dl,
 	.task_fork              = task_fork_dl,
@@ -3462,7 +3369,6 @@ bool dl_param_changed(struct task_struct *p, const struct sched_attr *attr)
 	return false;
 }
 
-#ifdef CONFIG_SMP
 int dl_cpuset_cpumask_can_shrink(const struct cpumask *cur,
 				 const struct cpumask *trial)
 {
@@ -3574,7 +3480,6 @@ void dl_bw_free(int cpu, u64 dl_bw)
 {
 	dl_bw_manage(dl_bw_req_free, cpu, dl_bw);
 }
-#endif /* CONFIG_SMP */
 
 void print_dl_stats(struct seq_file *m, int cpu)
 {
diff --git a/kernel/sched/debug.c b/kernel/sched/debug.c
index 748709c..04c0354 100644
--- a/kernel/sched/debug.c
+++ b/kernel/sched/debug.c
@@ -286,7 +286,6 @@ static const struct file_operations sched_dynamic_fops = {
 
 __read_mostly bool sched_debug_verbose;
 
-#ifdef CONFIG_SMP
 static struct dentry           *sd_dentry;
 
 
@@ -314,9 +313,6 @@ static ssize_t sched_verbose_write(struct file *filp, const char __user *ubuf,
 
 	return result;
 }
-#else /* !CONFIG_SMP: */
-# define sched_verbose_write debugfs_write_file_bool
-#endif /* !CONFIG_SMP */
 
 static const struct file_operations sched_verbose_fops = {
 	.read =         debugfs_read_file_bool,
@@ -543,8 +539,6 @@ static __init int sched_init_debug(void)
 }
 late_initcall(sched_init_debug);
 
-#ifdef CONFIG_SMP
-
 static cpumask_var_t		sd_sysctl_cpus;
 
 static int sd_flags_show(struct seq_file *m, void *v)
@@ -655,8 +649,6 @@ void dirty_sched_domain_sysctl(int cpu)
 		__cpumask_set_cpu(cpu, sd_sysctl_cpus);
 }
 
-#endif /* CONFIG_SMP */
-
 #ifdef CONFIG_FAIR_GROUP_SCHED
 static void print_cfs_group_stats(struct seq_file *m, int cpu, struct task_group *tg)
 {
@@ -932,11 +924,7 @@ void print_dl_rq(struct seq_file *m, int cpu, struct dl_rq *dl_rq)
 	SEQ_printf(m, "  .%-30s: %lu\n", #x, (unsigned long)(dl_rq->x))
 
 	PU(dl_nr_running);
-#ifdef CONFIG_SMP
 	dl_bw = &cpu_rq(cpu)->rd->dl_bw;
-#else
-	dl_bw = &dl_rq->dl_bw;
-#endif
 	SEQ_printf(m, "  .%-30s: %lld\n", "dl_bw->bw", dl_bw->bw);
 	SEQ_printf(m, "  .%-30s: %lld\n", "dl_bw->total_bw", dl_bw->total_bw);
 
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 1fabbe0..6b17d3d 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -88,7 +88,6 @@ static int __init setup_sched_thermal_decay_shift(char *str)
 }
 __setup("sched_thermal_decay_shift=", setup_sched_thermal_decay_shift);
 
-#ifdef CONFIG_SMP
 /*
  * For asym packing, by default the lower numbered CPU has higher priority.
  */
@@ -111,7 +110,6 @@ int __weak arch_asym_cpu_priority(int cpu)
  * (default: ~5%)
  */
 #define capacity_greater(cap1, cap2) ((cap1) * 1024 > (cap2) * 1078)
-#endif /* CONFIG_SMP */
 
 #ifdef CONFIG_CFS_BANDWIDTH
 /*
@@ -996,7 +994,6 @@ struct sched_entity *__pick_last_entity(struct cfs_rq *cfs_rq)
 /**************************************************************
  * Scheduling class statistics methods:
  */
-#ifdef CONFIG_SMP
 int sched_update_scaling(void)
 {
 	unsigned int factor = get_update_sysctl_factor();
@@ -1008,7 +1005,6 @@ int sched_update_scaling(void)
 
 	return 0;
 }
-#endif /* CONFIG_SMP */
 
 static void clear_buddies(struct cfs_rq *cfs_rq, struct sched_entity *se);
 
@@ -1042,8 +1038,6 @@ static bool update_deadline(struct cfs_rq *cfs_rq, struct sched_entity *se)
 
 #include "pelt.h"
 
-#ifdef CONFIG_SMP
-
 static int select_idle_sibling(struct task_struct *p, int prev_cpu, int cpu);
 static unsigned long task_h_load(struct task_struct *p);
 static unsigned long capacity_of(int cpu);
@@ -1132,18 +1126,6 @@ void post_init_entity_util_avg(struct task_struct *p)
 	sa->runnable_avg = sa->util_avg;
 }
 
-#else /* !CONFIG_SMP: */
-void init_entity_runnable_average(struct sched_entity *se)
-{
-}
-void post_init_entity_util_avg(struct task_struct *p)
-{
-}
-static void update_tg_load_avg(struct cfs_rq *cfs_rq)
-{
-}
-#endif /* !CONFIG_SMP */
-
 static s64 update_curr_se(struct rq *rq, struct sched_entity *curr)
 {
 	u64 now = rq_clock_task(rq);
@@ -3698,14 +3680,12 @@ static void
 account_entity_enqueue(struct cfs_rq *cfs_rq, struct sched_entity *se)
 {
 	update_load_add(&cfs_rq->load, se->load.weight);
-#ifdef CONFIG_SMP
 	if (entity_is_task(se)) {
 		struct rq *rq = rq_of(cfs_rq);
 
 		account_numa_enqueue(rq, task_of(se));
 		list_add(&se->group_node, &rq->cfs_tasks);
 	}
-#endif
 	cfs_rq->nr_queued++;
 }
 
@@ -3713,12 +3693,10 @@ static void
 account_entity_dequeue(struct cfs_rq *cfs_rq, struct sched_entity *se)
 {
 	update_load_sub(&cfs_rq->load, se->load.weight);
-#ifdef CONFIG_SMP
 	if (entity_is_task(se)) {
 		account_numa_dequeue(rq_of(cfs_rq), task_of(se));
 		list_del_init(&se->group_node);
 	}
-#endif
 	cfs_rq->nr_queued--;
 }
 
@@ -3770,7 +3748,6 @@ account_entity_dequeue(struct cfs_rq *cfs_rq, struct sched_entity *se)
 	*ptr -= min_t(typeof(*ptr), *ptr, _val);		\
 } while (0)
 
-#ifdef CONFIG_SMP
 static inline void
 enqueue_load_avg(struct cfs_rq *cfs_rq, struct sched_entity *se)
 {
@@ -3787,12 +3764,6 @@ dequeue_load_avg(struct cfs_rq *cfs_rq, struct sched_entity *se)
 	cfs_rq->avg.load_sum = max_t(u32, cfs_rq->avg.load_sum,
 					  cfs_rq->avg.load_avg * PELT_MIN_DIVIDER);
 }
-#else /* !CONFIG_SMP: */
-static inline void
-enqueue_load_avg(struct cfs_rq *cfs_rq, struct sched_entity *se) { }
-static inline void
-dequeue_load_avg(struct cfs_rq *cfs_rq, struct sched_entity *se) { }
-#endif /* !CONFIG_SMP */
 
 static void place_entity(struct cfs_rq *cfs_rq, struct sched_entity *se, int flags);
 
@@ -3824,13 +3795,11 @@ static void reweight_entity(struct cfs_rq *cfs_rq, struct sched_entity *se,
 
 	update_load_set(&se->load, weight);
 
-#ifdef CONFIG_SMP
 	do {
 		u32 divider = get_pelt_divider(&se->avg);
 
 		se->avg.load_avg = div_u64(se_weight(se) * se->avg.load_sum, divider);
 	} while (0);
-#endif
 
 	enqueue_load_avg(cfs_rq, se);
 	if (se->on_rq) {
@@ -3865,7 +3834,6 @@ static void reweight_task_fair(struct rq *rq, struct task_struct *p,
 static inline int throttled_hierarchy(struct cfs_rq *cfs_rq);
 
 #ifdef CONFIG_FAIR_GROUP_SCHED
-#ifdef CONFIG_SMP
 /*
  * All this does is approximate the hierarchical proportion which includes that
  * global sum we all love to hate.
@@ -3972,7 +3940,6 @@ static long calc_group_shares(struct cfs_rq *cfs_rq)
 	 */
 	return clamp_t(long, shares, MIN_SHARES, tg_shares);
 }
-#endif /* CONFIG_SMP */
 
 /*
  * Recomputes the group entity based on the current state of its group
@@ -3993,11 +3960,7 @@ static void update_cfs_group(struct sched_entity *se)
 	if (throttled_hierarchy(gcfs_rq))
 		return;
 
-#ifndef CONFIG_SMP
-	shares = READ_ONCE(gcfs_rq->tg->shares);
-#else
 	shares = calc_group_shares(gcfs_rq);
-#endif
 	if (unlikely(se->load.weight != shares))
 		reweight_entity(cfs_rq_of(se), se, shares);
 }
@@ -4031,7 +3994,6 @@ static inline void cfs_rq_util_change(struct cfs_rq *cfs_rq, int flags)
 	}
 }
 
-#ifdef CONFIG_SMP
 static inline bool load_avg_is_decayed(struct sched_avg *sa)
 {
 	if (sa->load_sum)
@@ -5146,48 +5108,6 @@ static inline void update_misfit_status(struct task_struct *p, struct rq *rq)
 	rq->misfit_task_load = max_t(unsigned long, task_h_load(p), 1);
 }
 
-#else /* !CONFIG_SMP: */
-
-static inline bool cfs_rq_is_decayed(struct cfs_rq *cfs_rq)
-{
-	return !cfs_rq->nr_queued;
-}
-
-#define UPDATE_TG	0x0
-#define SKIP_AGE_LOAD	0x0
-#define DO_ATTACH	0x0
-#define DO_DETACH	0x0
-
-static inline void update_load_avg(struct cfs_rq *cfs_rq, struct sched_entity *se, int not_used1)
-{
-	cfs_rq_util_change(cfs_rq, 0);
-}
-
-static inline void remove_entity_load_avg(struct sched_entity *se) {}
-
-static inline void
-attach_entity_load_avg(struct cfs_rq *cfs_rq, struct sched_entity *se) {}
-static inline void
-detach_entity_load_avg(struct cfs_rq *cfs_rq, struct sched_entity *se) {}
-
-static inline int sched_balance_newidle(struct rq *rq, struct rq_flags *rf)
-{
-	return 0;
-}
-
-static inline void
-util_est_enqueue(struct cfs_rq *cfs_rq, struct task_struct *p) {}
-
-static inline void
-util_est_dequeue(struct cfs_rq *cfs_rq, struct task_struct *p) {}
-
-static inline void
-util_est_update(struct cfs_rq *cfs_rq, struct task_struct *p,
-		bool task_sleep) {}
-static inline void update_misfit_status(struct task_struct *p, struct rq *rq) {}
-
-#endif /* !CONFIG_SMP */
-
 void __setparam_fair(struct task_struct *p, const struct sched_attr *attr)
 {
 	struct sched_entity *se = &p->se;
@@ -6090,7 +6010,6 @@ unthrottle_throttle:
 		resched_curr(rq);
 }
 
-#ifdef CONFIG_SMP
 static void __cfsb_csd_unthrottle(void *arg)
 {
 	struct cfs_rq *cursor, *tmp;
@@ -6149,12 +6068,6 @@ static inline void __unthrottle_cfs_rq_async(struct cfs_rq *cfs_rq)
 	if (first)
 		smp_call_function_single_async(cpu_of(rq), &rq->cfsb_csd);
 }
-#else /* !CONFIG_SMP: */
-static inline void __unthrottle_cfs_rq_async(struct cfs_rq *cfs_rq)
-{
-	unthrottle_cfs_rq(cfs_rq);
-}
-#endif /* !CONFIG_SMP */
 
 static void unthrottle_cfs_rq_async(struct cfs_rq *cfs_rq)
 {
@@ -6610,7 +6523,6 @@ static void destroy_cfs_bandwidth(struct cfs_bandwidth *cfs_b)
 	 * guaranteed at this point that no additional cfs_rq of this group can
 	 * join a CSD list.
 	 */
-#ifdef CONFIG_SMP
 	for_each_possible_cpu(i) {
 		struct rq *rq = cpu_rq(i);
 		unsigned long flags;
@@ -6622,7 +6534,6 @@ static void destroy_cfs_bandwidth(struct cfs_bandwidth *cfs_b)
 		__cfsb_csd_unthrottle(rq);
 		local_irq_restore(flags);
 	}
-#endif
 }
 
 /*
@@ -6835,7 +6746,6 @@ static inline void hrtick_update(struct rq *rq)
 }
 #endif /* !CONFIG_SCHED_HRTICK */
 
-#ifdef CONFIG_SMP
 static inline bool cpu_overutilized(int cpu)
 {
 	unsigned long  rq_util_min, rq_util_max;
@@ -6877,9 +6787,6 @@ static inline void check_update_overutilized_status(struct rq *rq)
 	if (!is_rd_overutilized(rq->rd) && cpu_overutilized(rq->cpu))
 		set_rd_overutilized(rq->rd, 1);
 }
-#else /* !CONFIG_SMP: */
-static inline void check_update_overutilized_status(struct rq *rq) { }
-#endif /* !CONFIG_SMP */
 
 /* Runqueue only has SCHED_IDLE tasks enqueued */
 static int sched_idle_rq(struct rq *rq)
@@ -6888,12 +6795,10 @@ static int sched_idle_rq(struct rq *rq)
 			rq->nr_running);
 }
 
-#ifdef CONFIG_SMP
 static int sched_idle_cpu(int cpu)
 {
 	return sched_idle_rq(cpu_rq(cpu));
 }
-#endif
 
 static void
 requeue_delayed_entity(struct sched_entity *se)
@@ -7208,8 +7113,6 @@ static inline unsigned int cfs_h_nr_delayed(struct rq *rq)
 	return (rq->cfs.h_nr_queued - rq->cfs.h_nr_runnable);
 }
 
-#ifdef CONFIG_SMP
-
 /* Working cpumask for: sched_balance_rq(), sched_balance_newidle(). */
 static DEFINE_PER_CPU(cpumask_var_t, load_balance_mask);
 static DEFINE_PER_CPU(cpumask_var_t, select_rq_mask);
@@ -8745,9 +8648,6 @@ balance_fair(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
 
 	return sched_balance_newidle(rq, rf) != 0;
 }
-#else /* !CONFIG_SMP: */
-static inline void set_task_max_allowed_capacity(struct task_struct *p) {}
-#endif /* !CONFIG_SMP */
 
 static void set_next_buddy(struct sched_entity *se)
 {
@@ -9057,7 +8957,6 @@ static bool yield_to_task_fair(struct rq *rq, struct task_struct *p)
 	return true;
 }
 
-#ifdef CONFIG_SMP
 /**************************************************
  * Fair scheduling class load-balancing methods.
  *
@@ -12980,8 +12879,6 @@ static void rq_offline_fair(struct rq *rq)
 	clear_tg_offline_cfs_rqs(rq);
 }
 
-#endif /* CONFIG_SMP */
-
 #ifdef CONFIG_SCHED_CORE
 static inline bool
 __entity_slice_used(struct sched_entity *se, int min_nr_tasks)
@@ -13209,7 +13106,6 @@ static void detach_entity_cfs_rq(struct sched_entity *se)
 {
 	struct cfs_rq *cfs_rq = cfs_rq_of(se);
 
-#ifdef CONFIG_SMP
 	/*
 	 * In case the task sched_avg hasn't been attached:
 	 * - A forked task which hasn't been woken up by wake_up_new_task().
@@ -13218,7 +13114,6 @@ static void detach_entity_cfs_rq(struct sched_entity *se)
 	 */
 	if (!se->avg.last_update_time)
 		return;
-#endif
 
 	/* Catch up with the cfs_rq and remove our load when we leave */
 	update_load_avg(cfs_rq, se, 0);
@@ -13282,7 +13177,6 @@ static void __set_next_task_fair(struct rq *rq, struct task_struct *p, bool firs
 {
 	struct sched_entity *se = &p->se;
 
-#ifdef CONFIG_SMP
 	if (task_on_rq_queued(p)) {
 		/*
 		 * Move the next running task to the front of the list, so our
@@ -13290,7 +13184,6 @@ static void __set_next_task_fair(struct rq *rq, struct task_struct *p, bool firs
 		 */
 		list_move(&se->group_node, &rq->cfs_tasks);
 	}
-#endif
 	if (!first)
 		return;
 
@@ -13328,9 +13221,7 @@ void init_cfs_rq(struct cfs_rq *cfs_rq)
 {
 	cfs_rq->tasks_timeline = RB_ROOT_CACHED;
 	cfs_rq->min_vruntime = (u64)(-(1LL << 20));
-#ifdef CONFIG_SMP
 	raw_spin_lock_init(&cfs_rq->removed.lock);
-#endif
 }
 
 #ifdef CONFIG_FAIR_GROUP_SCHED
@@ -13345,10 +13236,8 @@ static void task_change_group_fair(struct task_struct *p)
 
 	detach_task_cfs_rq(p);
 
-#ifdef CONFIG_SMP
 	/* Tell se's cfs_rq has been changed -- migrated */
 	p->se.avg.last_update_time = 0;
-#endif
 	set_task_rq(p, task_cpu(p));
 	attach_task_cfs_rq(p);
 }
@@ -13644,7 +13533,6 @@ DEFINE_SCHED_CLASS(fair) = {
 	.put_prev_task		= put_prev_task_fair,
 	.set_next_task          = set_next_task_fair,
 
-#ifdef CONFIG_SMP
 	.balance		= balance_fair,
 	.select_task_rq		= select_task_rq_fair,
 	.migrate_task_rq	= migrate_task_rq_fair,
@@ -13654,7 +13542,6 @@ DEFINE_SCHED_CLASS(fair) = {
 
 	.task_dead		= task_dead_fair,
 	.set_cpus_allowed	= set_cpus_allowed_fair,
-#endif
 
 	.task_tick		= task_tick_fair,
 	.task_fork		= task_fork_fair,
@@ -13717,7 +13604,6 @@ void show_numa_stats(struct task_struct *p, struct seq_file *m)
 
 __init void init_sched_fair_class(void)
 {
-#ifdef CONFIG_SMP
 	int i;
 
 	for_each_possible_cpu(i) {
@@ -13739,5 +13625,4 @@ __init void init_sched_fair_class(void)
 	nohz.next_blocked = jiffies;
 	zalloc_cpumask_var(&nohz.idle_cpus_mask, GFP_NOWAIT);
 #endif
-#endif /* CONFIG_SMP */
 }
diff --git a/kernel/sched/pelt.h b/kernel/sched/pelt.h
index a5d4933..62c3fa5 100644
--- a/kernel/sched/pelt.h
+++ b/kernel/sched/pelt.h
@@ -3,7 +3,6 @@
 #define _KERNEL_SCHED_PELT_H
 #include "sched.h"
 
-#ifdef CONFIG_SMP
 #include "sched-pelt.h"
 
 int __update_load_avg_blocked_se(u64 now, struct sched_entity *se);
@@ -187,55 +186,4 @@ static inline u64 cfs_rq_clock_pelt(struct cfs_rq *cfs_rq)
 }
 #endif /* !CONFIG_CFS_BANDWIDTH */
 
-#else /* !CONFIG_SMP: */
-
-static inline int
-update_cfs_rq_load_avg(u64 now, struct cfs_rq *cfs_rq)
-{
-	return 0;
-}
-
-static inline int
-update_rt_rq_load_avg(u64 now, struct rq *rq, int running)
-{
-	return 0;
-}
-
-static inline int
-update_dl_rq_load_avg(u64 now, struct rq *rq, int running)
-{
-	return 0;
-}
-
-static inline int
-update_hw_load_avg(u64 now, struct rq *rq, u64 capacity)
-{
-	return 0;
-}
-
-static inline u64 hw_load_avg(struct rq *rq)
-{
-	return 0;
-}
-
-static inline int
-update_irq_load_avg(struct rq *rq, u64 running)
-{
-	return 0;
-}
-
-static inline u64 rq_clock_pelt(struct rq *rq)
-{
-	return rq_clock_task(rq);
-}
-
-static inline void
-update_rq_clock_pelt(struct rq *rq, s64 delta) { }
-
-static inline void
-update_idle_rq_clock_pelt(struct rq *rq) { }
-
-static inline void update_idle_cfs_rq_clock_pelt(struct cfs_rq *cfs_rq) { }
-#endif /* !CONFIG_SMP */
-
 #endif /* _KERNEL_SCHED_PELT_H */
diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
index 7e8ed05..ab21170 100644
--- a/kernel/sched/rt.c
+++ b/kernel/sched/rt.c
@@ -2454,7 +2454,11 @@ void __init init_sched_rt_class(void)
 					GFP_KERNEL, cpu_to_node(i));
 	}
 }
-#endif /* CONFIG_SMP */
+#else /* !CONFIG_SMP: */
+void __init init_sched_rt_class(void)
+{
+}
+#endif /* !CONFIG_SMP */
 
 /*
  * When switching a task to RT, we may overload the runqueue
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 2bf804b..7a7ebc2 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -443,14 +443,12 @@ struct task_group {
 	/* runqueue "owned" by this group on each CPU */
 	struct cfs_rq		**cfs_rq;
 	unsigned long		shares;
-#ifdef CONFIG_SMP
 	/*
 	 * load_avg can be heavily contended at clock tick time, so put
 	 * it in its own cache-line separated from the fields above which
 	 * will also be accessed at each tick.
 	 */
 	atomic_long_t		load_avg ____cacheline_aligned;
-#endif /* CONFIG_SMP */
 #endif /* CONFIG_FAIR_GROUP_SCHED */
 
 #ifdef CONFIG_RT_GROUP_SCHED
@@ -574,13 +572,8 @@ extern int sched_group_set_shares(struct task_group *tg, unsigned long shares);
 
 extern int sched_group_set_idle(struct task_group *tg, long idle);
 
-#ifdef CONFIG_SMP
 extern void set_task_rq_fair(struct sched_entity *se,
 			     struct cfs_rq *prev, struct cfs_rq *next);
-#else /* !CONFIG_SMP: */
-static inline void set_task_rq_fair(struct sched_entity *se,
-			     struct cfs_rq *prev, struct cfs_rq *next) { }
-#endif /* !CONFIG_SMP */
 #else /* !CONFIG_FAIR_GROUP_SCHED: */
 static inline int sched_group_set_shares(struct task_group *tg, unsigned long shares) { return 0; }
 static inline int sched_group_set_idle(struct task_group *tg, long idle) { return 0; }
@@ -668,7 +661,6 @@ struct cfs_rq {
 	struct sched_entity	*curr;
 	struct sched_entity	*next;
 
-#ifdef CONFIG_SMP
 	/*
 	 * CFS load tracking
 	 */
@@ -700,7 +692,6 @@ struct cfs_rq {
 	u64			last_h_load_update;
 	struct sched_entity	*h_load_next;
 #endif /* CONFIG_FAIR_GROUP_SCHED */
-#endif /* CONFIG_SMP */
 
 #ifdef CONFIG_FAIR_GROUP_SCHED
 	struct rq		*rq;	/* CPU runqueue to which this cfs_rq is attached */
@@ -797,14 +788,10 @@ struct rt_rq {
 	struct rt_prio_array	active;
 	unsigned int		rt_nr_running;
 	unsigned int		rr_nr_running;
-#if defined CONFIG_SMP || defined CONFIG_RT_GROUP_SCHED
 	struct {
 		int		curr; /* highest queued rt task prio */
-#ifdef CONFIG_SMP
 		int		next; /* next highest */
-#endif
 	} highest_prio;
-#endif
 #ifdef CONFIG_SMP
 	bool			overloaded;
 	struct plist_head	pushable_tasks;
@@ -840,7 +827,6 @@ struct dl_rq {
 
 	unsigned int		dl_nr_running;
 
-#ifdef CONFIG_SMP
 	/*
 	 * Deadline values of the currently executing and the
 	 * earliest ready task on this rq. Caching these facilitates
@@ -860,9 +846,7 @@ struct dl_rq {
 	 * of the leftmost (earliest deadline) element.
 	 */
 	struct rb_root_cached	pushable_dl_tasks_root;
-#else /* !CONFIG_SMP: */
-	struct dl_bw		dl_bw;
-#endif /* !CONFIG_SMP */
+
 	/*
 	 * "Active utilization" for this runqueue: increased when a
 	 * task wakes up (becomes TASK_RUNNING) and decreased when a
@@ -933,7 +917,6 @@ static inline long se_runnable(struct sched_entity *se)
 
 #endif /* !CONFIG_FAIR_GROUP_SCHED */
 
-#ifdef CONFIG_SMP
 /*
  * XXX we want to get rid of these helpers and use the full load resolution.
  */
@@ -1044,7 +1027,6 @@ static inline void set_rd_overloaded(struct root_domain *rd, int status)
 #ifdef HAVE_RT_PUSH_IPI
 extern void rto_push_irq_work_func(struct irq_work *work);
 #endif
-#endif /* CONFIG_SMP */
 
 #ifdef CONFIG_UCLAMP_TASK
 /*
@@ -1108,18 +1090,14 @@ struct rq {
 	unsigned int		numa_migrate_on;
 #endif
 #ifdef CONFIG_NO_HZ_COMMON
-#ifdef CONFIG_SMP
 	unsigned long		last_blocked_load_update_tick;
 	unsigned int		has_blocked_load;
 	call_single_data_t	nohz_csd;
-#endif /* CONFIG_SMP */
 	unsigned int		nohz_tick_stopped;
 	atomic_t		nohz_flags;
 #endif /* CONFIG_NO_HZ_COMMON */
 
-#ifdef CONFIG_SMP
 	unsigned int		ttwu_pending;
-#endif
 	u64			nr_switches;
 
 #ifdef CONFIG_UCLAMP_TASK
@@ -1184,7 +1162,6 @@ struct rq {
 	int membarrier_state;
 #endif
 
-#ifdef CONFIG_SMP
 	struct root_domain		*rd;
 	struct sched_domain __rcu	*sd;
 
@@ -1225,7 +1202,6 @@ struct rq {
 #ifdef CONFIG_HOTPLUG_CPU
 	struct rcuwait		hotplug_wait;
 #endif
-#endif /* CONFIG_SMP */
 
 #ifdef CONFIG_IRQ_TIME_ACCOUNTING
 	u64			prev_irq_time;
@@ -1272,9 +1248,7 @@ struct rq {
 	struct cpuidle_state	*idle_state;
 #endif
 
-#ifdef CONFIG_SMP
 	unsigned int		nr_pinned;
-#endif
 	unsigned int		push_busy;
 	struct cpu_stop_work	push_work;
 
@@ -1300,7 +1274,7 @@ struct rq {
 	/* Scratch cpumask to be temporarily used under rq_lock */
 	cpumask_var_t		scratch_mask;
 
-#if defined(CONFIG_CFS_BANDWIDTH) && defined(CONFIG_SMP)
+#ifdef CONFIG_CFS_BANDWIDTH
 	call_single_data_t	cfsb_csd;
 	struct list_head	cfsb_csd_list;
 #endif
@@ -1963,8 +1937,6 @@ init_numa_balancing(unsigned long clone_flags, struct task_struct *p)
 
 #endif /* !CONFIG_NUMA_BALANCING */
 
-#ifdef CONFIG_SMP
-
 static inline void
 queue_balance_callback(struct rq *rq,
 		       struct balance_callback *head,
@@ -2130,8 +2102,6 @@ static inline const struct cpumask *task_user_cpus(struct task_struct *p)
 	return p->user_cpus_ptr;
 }
 
-#endif /* CONFIG_SMP */
-
 #ifdef CONFIG_CGROUP_SCHED
 
 /*
@@ -2418,7 +2388,6 @@ struct sched_class {
 	void (*put_prev_task)(struct rq *rq, struct task_struct *p, struct task_struct *next);
 	void (*set_next_task)(struct rq *rq, struct task_struct *p, bool first);
 
-#ifdef CONFIG_SMP
 	int  (*select_task_rq)(struct task_struct *p, int task_cpu, int flags);
 
 	void (*migrate_task_rq)(struct task_struct *p, int new_cpu);
@@ -2431,7 +2400,6 @@ struct sched_class {
 	void (*rq_offline)(struct rq *rq);
 
 	struct rq *(*find_lock_rq)(struct task_struct *p, struct rq *rq);
-#endif /* CONFIG_SMP */
 
 	void (*task_tick)(struct rq *rq, struct task_struct *p, int queued);
 	void (*task_fork)(struct task_struct *p);
@@ -2583,8 +2551,6 @@ extern struct task_struct *pick_task_idle(struct rq *rq);
 #define SCA_MIGRATE_ENABLE	0x04
 #define SCA_USER		0x08
 
-#ifdef CONFIG_SMP
-
 extern void update_group_capacity(struct sched_domain *sd, int cpu);
 
 extern void sched_balance_trigger(struct rq *rq);
@@ -2636,26 +2602,6 @@ static inline struct task_struct *get_push_task(struct rq *rq)
 
 extern int push_cpu_stop(void *arg);
 
-#else /* !CONFIG_SMP: */
-
-static inline bool task_allowed_on_cpu(struct task_struct *p, int cpu)
-{
-	return true;
-}
-
-static inline int __set_cpus_allowed_ptr(struct task_struct *p,
-					 struct affinity_context *ctx)
-{
-	return set_cpus_allowed_ptr(p, ctx->new_mask);
-}
-
-static inline cpumask_t *alloc_user_cpus_ptr(int node)
-{
-	return NULL;
-}
-
-#endif /* !CONFIG_SMP */
-
 #ifdef CONFIG_CPU_IDLE
 
 static inline void idle_set_state(struct rq *rq,
@@ -2932,8 +2878,6 @@ static inline class_##name##_t class_##name##_constructor(type *lock, type *lock
 { class_##name##_t _t = { .lock = lock, .lock2 = lock2 }, *_T = &_t;			\
   _lock; return _t; }
 
-#ifdef CONFIG_SMP
-
 static inline bool rq_order_less(struct rq *rq1, struct rq *rq2)
 {
 #ifdef CONFIG_SCHED_CORE
@@ -3093,42 +3037,6 @@ extern void set_rq_offline(struct rq *rq);
 
 extern bool sched_smp_initialized;
 
-#else /* !CONFIG_SMP: */
-
-/*
- * double_rq_lock - safely lock two runqueues
- *
- * Note this does not disable interrupts like task_rq_lock,
- * you need to do so manually before calling.
- */
-static inline void double_rq_lock(struct rq *rq1, struct rq *rq2)
-	__acquires(rq1->lock)
-	__acquires(rq2->lock)
-{
-	WARN_ON_ONCE(!irqs_disabled());
-	WARN_ON_ONCE(rq1 != rq2);
-	raw_spin_rq_lock(rq1);
-	__acquire(rq2->lock);	/* Fake it out ;) */
-	double_rq_clock_clear_update(rq1, rq2);
-}
-
-/*
- * double_rq_unlock - safely unlock two runqueues
- *
- * Note this does not restore interrupts like task_rq_unlock,
- * you need to do so manually after calling.
- */
-static inline void double_rq_unlock(struct rq *rq1, struct rq *rq2)
-	__releases(rq1->lock)
-	__releases(rq2->lock)
-{
-	WARN_ON_ONCE(rq1 != rq2);
-	raw_spin_rq_unlock(rq1);
-	__release(rq2->lock);
-}
-
-#endif /* !CONFIG_SMP */
-
 DEFINE_LOCK_GUARD_2(double_rq_lock, struct rq,
 		    double_rq_lock(_T->lock, _T->lock2),
 		    double_rq_unlock(_T->lock, _T->lock2))
@@ -3187,7 +3095,7 @@ extern void nohz_balance_exit_idle(struct rq *rq);
 static inline void nohz_balance_exit_idle(struct rq *rq) { }
 #endif /* !CONFIG_NO_HZ_COMMON */
 
-#if defined(CONFIG_SMP) && defined(CONFIG_NO_HZ_COMMON)
+#ifdef CONFIG_NO_HZ_COMMON
 extern void nohz_run_idle_balance(int cpu);
 #else
 static inline void nohz_run_idle_balance(int cpu) { }
@@ -3313,8 +3221,6 @@ static inline void cpufreq_update_util(struct rq *rq, unsigned int flags) { }
 # define arch_scale_freq_invariant()	false
 #endif
 
-#ifdef CONFIG_SMP
-
 unsigned long effective_cpu_util(int cpu, unsigned long util_cfs,
 				 unsigned long *min,
 				 unsigned long *max);
@@ -3358,10 +3264,6 @@ static inline unsigned long cpu_util_rt(struct rq *rq)
 	return READ_ONCE(rq->avg_rt.util_avg);
 }
 
-#else /* !CONFIG_SMP: */
-static inline bool update_other_load_avgs(struct rq *rq) { return false; }
-#endif /* !CONFIG_SMP */
-
 #ifdef CONFIG_UCLAMP_TASK
 
 unsigned long uclamp_eff_value(struct task_struct *p, enum uclamp_id clamp_id);
@@ -3580,7 +3482,6 @@ static inline void membarrier_switch_mm(struct rq *rq,
 
 #endif /* !CONFIG_MEMBARRIER */
 
-#ifdef CONFIG_SMP
 static inline bool is_per_cpu_kthread(struct task_struct *p)
 {
 	if (!(p->flags & PF_KTHREAD))
@@ -3591,7 +3492,6 @@ static inline bool is_per_cpu_kthread(struct task_struct *p)
 
 	return true;
 }
-#endif /* CONFIG_SMP */
 
 extern void swake_up_all_locked(struct swait_queue_head *q);
 extern void __prepare_to_swait(struct swait_queue_head *q, struct swait_queue *wait);
@@ -3890,7 +3790,6 @@ static inline void init_sched_mm_cid(struct task_struct *t) { }
 
 extern u64 avg_vruntime(struct cfs_rq *cfs_rq);
 extern int entity_eligible(struct cfs_rq *cfs_rq, struct sched_entity *se);
-#ifdef CONFIG_SMP
 static inline
 void move_queued_task_locked(struct rq *src_rq, struct rq *dst_rq, struct task_struct *task)
 {
@@ -3911,7 +3810,6 @@ bool task_is_pushable(struct rq *rq, struct task_struct *p, int cpu)
 
 	return false;
 }
-#endif /* CONFIG_SMP */
 
 #ifdef CONFIG_RT_MUTEXES
 
@@ -3952,21 +3850,8 @@ extern void check_class_changed(struct rq *rq, struct task_struct *p,
 				const struct sched_class *prev_class,
 				int oldprio);
 
-#ifdef CONFIG_SMP
 extern struct balance_callback *splice_balance_callbacks(struct rq *rq);
 extern void balance_callbacks(struct rq *rq, struct balance_callback *head);
-#else /* !CONFIG_SMP: */
-
-static inline struct balance_callback *splice_balance_callbacks(struct rq *rq)
-{
-	return NULL;
-}
-
-static inline void balance_callbacks(struct rq *rq, struct balance_callback *head)
-{
-}
-
-#endif /* !CONFIG_SMP */
 
 #ifdef CONFIG_SCHED_CLASS_EXT
 /*
diff --git a/kernel/sched/syscalls.c b/kernel/sched/syscalls.c
index 5cb5e94..d7fccf8 100644
--- a/kernel/sched/syscalls.c
+++ b/kernel/sched/syscalls.c
@@ -1119,7 +1119,6 @@ SYSCALL_DEFINE4(sched_getattr, pid_t, pid, struct sched_attr __user *, uattr,
 	return copy_struct_to_user(uattr, usize, &kattr, sizeof(kattr), NULL);
 }
 
-#ifdef CONFIG_SMP
 int dl_task_check_affinity(struct task_struct *p, const struct cpumask *mask)
 {
 	/*
@@ -1148,7 +1147,6 @@ int dl_task_check_affinity(struct task_struct *p, const struct cpumask *mask)
 
 	return 0;
 }
-#endif /* CONFIG_SMP */
 
 int __sched_setaffinity(struct task_struct *p, struct affinity_context *ctx)
 {
diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
index ee347d9..f2c1016 100644
--- a/kernel/sched/topology.c
+++ b/kernel/sched/topology.c
@@ -17,8 +17,6 @@ void sched_domains_mutex_unlock(void)
 	mutex_unlock(&sched_domains_mutex);
 }
 
-#ifdef CONFIG_SMP
-
 /* Protected by sched_domains_mutex: */
 static cpumask_var_t sched_domains_tmpmask;
 static cpumask_var_t sched_domains_tmpmask2;
@@ -1322,11 +1320,10 @@ next:
 	update_group_capacity(sd, cpu);
 }
 
-#ifdef CONFIG_SMP
-
 /* Update the "asym_prefer_cpu" when arch_asym_cpu_priority() changes. */
 void sched_update_asym_prefer_cpu(int cpu, int old_prio, int new_prio)
 {
+#ifdef CONFIG_SMP
 	int asym_prefer_cpu = cpu;
 	struct sched_domain *sd;
 
@@ -1376,9 +1373,8 @@ void sched_update_asym_prefer_cpu(int cpu, int old_prio, int new_prio)
 
 		WRITE_ONCE(sg->asym_prefer_cpu, asym_prefer_cpu);
 	}
-}
-
 #endif /* CONFIG_SMP */
+}
 
 /*
  * Set of available CPUs grouped by their corresponding capacities
@@ -2844,5 +2840,3 @@ void partition_sched_domains(int ndoms_new, cpumask_var_t doms_new[],
 	partition_sched_domains_locked(ndoms_new, doms_new, dattr_new);
 	sched_domains_mutex_unlock();
 }
-
-#endif /* CONFIG_SMP */

