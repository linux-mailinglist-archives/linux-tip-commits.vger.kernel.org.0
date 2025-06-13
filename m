Return-Path: <linux-tip-commits+bounces-5807-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D8B75AD8487
	for <lists+linux-tip-commits@lfdr.de>; Fri, 13 Jun 2025 09:43:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7F46A165887
	for <lists+linux-tip-commits@lfdr.de>; Fri, 13 Jun 2025 07:42:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49C24238C26;
	Fri, 13 Jun 2025 07:37:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="vruLjOpz";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="pznRs+Zb"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 087502C326C;
	Fri, 13 Jun 2025 07:37:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749800254; cv=none; b=Iu6QW5Ao8tqMlPhiaX10kgQdt60nrbDlAA11meRe/lwKAuD+7IKeUDDFh13TFajQ4l7bm+XPUdKG1yZjtSjmG7bb48ZyzAhBIUc+9HZi5HBew2zhT/a7dxz2bzW5YbA25AqyfEmHMR1qnrI/oyNTb+mmlSNmAAbLTqbjDkOk6WE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749800254; c=relaxed/simple;
	bh=AvRVj3iT0eNOCiiwKbML+x1aZ1dnc1exjnhlDcyJ6J0=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=hDyLTXIc7Sad199RwgL9AgrI+YkH5kMB9iq+I3ArWayQtc3hMWWwjlz1bgk2YHkGQCUcCY5VELKyCVJAfz6Q3x9i0CA36bxJ/CHIyGeBWng6BHyBeTExJcc6ikGzJLjM6fteik3lrQ9RrL4NLMW+f6PN3ab809QfbDOgVNOJKWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=vruLjOpz; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=pznRs+Zb; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 13 Jun 2025 07:37:29 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1749800250;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xjuNSDBwS62pVSjlIGunB9neG20w7CbBw1+zl4+c0ng=;
	b=vruLjOpzk9Hj1gV+fOEJb80dxyUtrbUU0apJmQnelb7yQ550yBfidFgtueJfN7+M84UpSX
	4w7n1348/hr/2xiwgaM2rHBUQWf1/UMZlIHWxoSLoToQ+i5RXfroOIbl0h/iSqalwgSrVt
	F0K1+k6Il3kNQI0fTcZye6bTyTt0+Fza9MFqGNaLjvbCxk0s/BVeoDEkOBe08rTMlsE6xf
	SmPwfBBJlKtZ+A8zWt8wc4wu2JVGyREy/JAD4CScm01L2Pr8GgGwAdB1OPzP7w5SahRgpz
	sjnDNO2Tu8RNoWEsurV3pVZf91zheSYx7xgQYadpQXC+b4qaimo85fj7Fj47Vg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1749800250;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xjuNSDBwS62pVSjlIGunB9neG20w7CbBw1+zl4+c0ng=;
	b=pznRs+ZbznrfD6m9fZ5s6d0p4OBCJZm4RrOxSirNOp4PUDSqTn3UZmlJPf9DYuNOu4x+5Q
	gXaMVBXPE9nDTeAg==
From: "tip-bot2 for Ingo Molnar" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched: Clean up and standardize #if/#else/#endif
 markers in sched/sched.h
Cc: Ingo Molnar <mingo@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Juri Lelli <juri.lelli@redhat.com>,
 Linus Torvalds <torvalds@linux-foundation.org>, Mel Gorman <mgorman@suse.de>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Shrikanth Hegde <sshegde@linux.ibm.com>, Steven Rostedt <rostedt@goodmis.org>,
 Valentin Schneider <vschneid@redhat.com>,
 Vincent Guittot <vincent.guittot@linaro.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250528080924.2273858-16-mingo@kernel.org>
References: <20250528080924.2273858-16-mingo@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174980024975.406.13537408799902860467.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     fdccd0c79280da0a332f1370d2ad17192d563c95
Gitweb:        https://git.kernel.org/tip/fdccd0c79280da0a332f1370d2ad17192d563c95
Author:        Ingo Molnar <mingo@kernel.org>
AuthorDate:    Wed, 28 May 2025 10:08:56 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Fri, 13 Jun 2025 08:47:17 +02:00

sched: Clean up and standardize #if/#else/#endif markers in sched/sched.h

 - Use the standard #ifdef marker format for larger blocks,
   where appropriate:

        #if CONFIG_FOO
        ...
        #else /* !CONFIG_FOO: */
        ...
        #endif /* !CONFIG_FOO */

 - Fix whitespace noise and other inconsistencies.

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
Link: https://lore.kernel.org/r/20250528080924.2273858-16-mingo@kernel.org
---
 kernel/sched/sched.h | 82 ++++++++++++++++++++++---------------------
 1 file changed, 42 insertions(+), 40 deletions(-)

diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index f3a4148..2bf804b 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -425,7 +425,7 @@ struct cfs_bandwidth {
 	int			nr_burst;
 	u64			throttled_time;
 	u64			burst_time;
-#endif
+#endif /* CONFIG_CFS_BANDWIDTH */
 };
 
 /* Task group related information */
@@ -443,15 +443,15 @@ struct task_group {
 	/* runqueue "owned" by this group on each CPU */
 	struct cfs_rq		**cfs_rq;
 	unsigned long		shares;
-#ifdef	CONFIG_SMP
+#ifdef CONFIG_SMP
 	/*
 	 * load_avg can be heavily contended at clock tick time, so put
 	 * it in its own cache-line separated from the fields above which
 	 * will also be accessed at each tick.
 	 */
 	atomic_long_t		load_avg ____cacheline_aligned;
-#endif
-#endif
+#endif /* CONFIG_SMP */
+#endif /* CONFIG_FAIR_GROUP_SCHED */
 
 #ifdef CONFIG_RT_GROUP_SCHED
 	struct sched_rt_entity	**rt_se;
@@ -532,7 +532,7 @@ extern void free_fair_sched_group(struct task_group *tg);
 extern int alloc_fair_sched_group(struct task_group *tg, struct task_group *parent);
 extern void online_fair_sched_group(struct task_group *tg);
 extern void unregister_fair_sched_group(struct task_group *tg);
-#else
+#else /* !CONFIG_FAIR_GROUP_SCHED: */
 static inline void free_fair_sched_group(struct task_group *tg) { }
 static inline int alloc_fair_sched_group(struct task_group *tg, struct task_group *parent)
 {
@@ -540,7 +540,7 @@ static inline int alloc_fair_sched_group(struct task_group *tg, struct task_grou
 }
 static inline void online_fair_sched_group(struct task_group *tg) { }
 static inline void unregister_fair_sched_group(struct task_group *tg) { }
-#endif
+#endif /* !CONFIG_FAIR_GROUP_SCHED */
 
 extern void init_tg_cfs_entry(struct task_group *tg, struct cfs_rq *cfs_rq,
 			struct sched_entity *se, int cpu,
@@ -577,22 +577,22 @@ extern int sched_group_set_idle(struct task_group *tg, long idle);
 #ifdef CONFIG_SMP
 extern void set_task_rq_fair(struct sched_entity *se,
 			     struct cfs_rq *prev, struct cfs_rq *next);
-#else /* !CONFIG_SMP */
+#else /* !CONFIG_SMP: */
 static inline void set_task_rq_fair(struct sched_entity *se,
 			     struct cfs_rq *prev, struct cfs_rq *next) { }
-#endif /* CONFIG_SMP */
-#else /* !CONFIG_FAIR_GROUP_SCHED */
+#endif /* !CONFIG_SMP */
+#else /* !CONFIG_FAIR_GROUP_SCHED: */
 static inline int sched_group_set_shares(struct task_group *tg, unsigned long shares) { return 0; }
 static inline int sched_group_set_idle(struct task_group *tg, long idle) { return 0; }
-#endif /* CONFIG_FAIR_GROUP_SCHED */
+#endif /* !CONFIG_FAIR_GROUP_SCHED */
 
-#else /* CONFIG_CGROUP_SCHED */
+#else /* !CONFIG_CGROUP_SCHED: */
 
 struct cfs_bandwidth { };
 
 static inline bool cfs_task_bw_constrained(struct task_struct *p) { return false; }
 
-#endif	/* CONFIG_CGROUP_SCHED */
+#endif /* !CONFIG_CGROUP_SCHED */
 
 extern void unregister_rt_sched_group(struct task_group *tg);
 extern void free_rt_sched_group(struct task_group *tg);
@@ -860,9 +860,9 @@ struct dl_rq {
 	 * of the leftmost (earliest deadline) element.
 	 */
 	struct rb_root_cached	pushable_dl_tasks_root;
-#else
+#else /* !CONFIG_SMP: */
 	struct dl_bw		dl_bw;
-#endif
+#endif /* !CONFIG_SMP */
 	/*
 	 * "Active utilization" for this runqueue: increased when a
 	 * task wakes up (becomes TASK_RUNNING) and decreased when a
@@ -1009,7 +1009,7 @@ struct root_domain {
 	/* These atomics are updated outside of a lock */
 	atomic_t		rto_loop_next;
 	atomic_t		rto_loop_start;
-#endif
+#endif /* HAVE_RT_PUSH_IPI */
 	/*
 	 * The "RT overload" flag: it gets set if a CPU has more than
 	 * one runnable RT task.
@@ -1295,7 +1295,7 @@ struct rq {
 	unsigned int		core_forceidle_seq;
 	unsigned int		core_forceidle_occupation;
 	u64			core_forceidle_start;
-#endif
+#endif /* CONFIG_SCHED_CORE */
 
 	/* Scratch cpumask to be temporarily used under rq_lock */
 	cpumask_var_t		scratch_mask;
@@ -1314,13 +1314,13 @@ static inline struct rq *rq_of(struct cfs_rq *cfs_rq)
 	return cfs_rq->rq;
 }
 
-#else
+#else /* !CONFIG_FAIR_GROUP_SCHED: */
 
 static inline struct rq *rq_of(struct cfs_rq *cfs_rq)
 {
 	return container_of(cfs_rq, struct rq, cfs);
 }
-#endif
+#endif /* !CONFIG_FAIR_GROUP_SCHED */
 
 static inline int cpu_of(struct rq *rq)
 {
@@ -1501,6 +1501,7 @@ static inline bool sched_group_cookie_match(struct rq *rq,
 }
 
 #endif /* !CONFIG_SCHED_CORE */
+
 #ifdef CONFIG_RT_GROUP_SCHED
 # ifdef CONFIG_RT_GROUP_SCHED_DEFAULT_DISABLED
 DECLARE_STATIC_KEY_FALSE(rt_group_sched);
@@ -1508,16 +1509,16 @@ static inline bool rt_group_sched_enabled(void)
 {
 	return static_branch_unlikely(&rt_group_sched);
 }
-# else
+# else /* !CONFIG_RT_GROUP_SCHED_DEFAULT_DISABLED: */
 DECLARE_STATIC_KEY_TRUE(rt_group_sched);
 static inline bool rt_group_sched_enabled(void)
 {
 	return static_branch_likely(&rt_group_sched);
 }
-# endif /* CONFIG_RT_GROUP_SCHED_DEFAULT_DISABLED */
-#else
+# endif /* !CONFIG_RT_GROUP_SCHED_DEFAULT_DISABLED */
+#else /* !CONFIG_RT_GROUP_SCHED: */
 # define rt_group_sched_enabled()	false
-#endif /* CONFIG_RT_GROUP_SCHED */
+#endif /* !CONFIG_RT_GROUP_SCHED */
 
 static inline void lockdep_assert_rq_held(struct rq *rq)
 {
@@ -1575,9 +1576,9 @@ static inline void update_idle_core(struct rq *rq)
 		__update_idle_core(rq);
 }
 
-#else
+#else /* !CONFIG_SCHED_SMT: */
 static inline void update_idle_core(struct rq *rq) { }
-#endif
+#endif /* !CONFIG_SCHED_SMT */
 
 #ifdef CONFIG_FAIR_GROUP_SCHED
 
@@ -1758,7 +1759,7 @@ static inline void scx_rq_clock_invalidate(struct rq *rq)
 	WRITE_ONCE(rq->scx.flags, rq->scx.flags & ~SCX_RQ_CLK_VALID);
 }
 
-#else /* !CONFIG_SCHED_CLASS_EXT */
+#else /* !CONFIG_SCHED_CLASS_EXT: */
 #define scx_enabled()		false
 #define scx_switched_all()	false
 
@@ -2175,7 +2176,7 @@ static inline void set_task_rq(struct task_struct *p, unsigned int cpu)
 		tg = &root_task_group;
 	p->rt.rt_rq  = tg->rt_rq[cpu];
 	p->rt.parent = tg->rt_se[cpu];
-#endif
+#endif /* CONFIG_RT_GROUP_SCHED */
 }
 
 #else /* !CONFIG_CGROUP_SCHED: */
@@ -2201,7 +2202,7 @@ static inline void __set_task_cpu(struct task_struct *p, unsigned int cpu)
 	smp_wmb();
 	WRITE_ONCE(task_thread_info(p)->cpu, cpu);
 	p->wake_cpu = cpu;
-#endif
+#endif /* CONFIG_SMP */
 }
 
 /*
@@ -2430,7 +2431,7 @@ struct sched_class {
 	void (*rq_offline)(struct rq *rq);
 
 	struct rq *(*find_lock_rq)(struct task_struct *p, struct rq *rq);
-#endif
+#endif /* CONFIG_SMP */
 
 	void (*task_tick)(struct rq *rq, struct task_struct *p, int queued);
 	void (*task_fork)(struct task_struct *p);
@@ -2955,7 +2956,7 @@ static inline bool rq_order_less(struct rq *rq1, struct rq *rq2)
 	/*
 	 * __sched_core_flip() relies on SMT having cpu-id lock order.
 	 */
-#endif
+#endif /* CONFIG_SCHED_CORE */
 	return rq1->cpu < rq2->cpu;
 }
 
@@ -3146,6 +3147,7 @@ extern void print_rt_rq(struct seq_file *m, int cpu, struct rt_rq *rt_rq);
 extern void print_dl_rq(struct seq_file *m, int cpu, struct dl_rq *dl_rq);
 
 extern void resched_latency_warn(int cpu, u64 latency);
+
 #ifdef CONFIG_NUMA_BALANCING
 extern void show_numa_stats(struct task_struct *p, struct seq_file *m);
 extern void
@@ -3255,14 +3257,14 @@ static inline u64 irq_time_read(int cpu)
 	return total;
 }
 
-#else
+#else /* !CONFIG_IRQ_TIME_ACCOUNTING: */
 
 static inline int irqtime_enabled(void)
 {
 	return 0;
 }
 
-#endif /* CONFIG_IRQ_TIME_ACCOUNTING */
+#endif /* !CONFIG_IRQ_TIME_ACCOUNTING */
 
 #ifdef CONFIG_CPU_FREQ
 
@@ -3356,9 +3358,9 @@ static inline unsigned long cpu_util_rt(struct rq *rq)
 	return READ_ONCE(rq->avg_rt.util_avg);
 }
 
-#else /* !CONFIG_SMP */
+#else /* !CONFIG_SMP: */
 static inline bool update_other_load_avgs(struct rq *rq) { return false; }
-#endif /* CONFIG_SMP */
+#endif /* !CONFIG_SMP */
 
 #ifdef CONFIG_UCLAMP_TASK
 
@@ -3536,13 +3538,13 @@ static inline bool sched_energy_enabled(void)
 	return static_branch_unlikely(&sched_energy_present);
 }
 
-#else /* ! (CONFIG_ENERGY_MODEL && CONFIG_CPU_FREQ_GOV_SCHEDUTIL) */
+#else /* !(CONFIG_ENERGY_MODEL && CONFIG_CPU_FREQ_GOV_SCHEDUTIL): */
 
 #define perf_domain_span(pd) NULL
 
 static inline bool sched_energy_enabled(void) { return false; }
 
-#endif /* CONFIG_ENERGY_MODEL && CONFIG_CPU_FREQ_GOV_SCHEDUTIL */
+#endif /* !(CONFIG_ENERGY_MODEL && CONFIG_CPU_FREQ_GOV_SCHEDUTIL) */
 
 #ifdef CONFIG_MEMBARRIER
 
@@ -3568,7 +3570,7 @@ static inline void membarrier_switch_mm(struct rq *rq,
 	WRITE_ONCE(rq->membarrier_state, membarrier_state);
 }
 
-#else /* !CONFIG_MEMBARRIER :*/
+#else /* !CONFIG_MEMBARRIER: */
 
 static inline void membarrier_switch_mm(struct rq *rq,
 					struct mm_struct *prev_mm,
@@ -3589,7 +3591,7 @@ static inline bool is_per_cpu_kthread(struct task_struct *p)
 
 	return true;
 }
-#endif
+#endif /* CONFIG_SMP */
 
 extern void swake_up_all_locked(struct swait_queue_head *q);
 extern void __prepare_to_swait(struct swait_queue_head *q, struct swait_queue *wait);
@@ -3909,7 +3911,7 @@ bool task_is_pushable(struct rq *rq, struct task_struct *p, int cpu)
 
 	return false;
 }
-#endif
+#endif /* CONFIG_SMP */
 
 #ifdef CONFIG_RT_MUTEXES
 
@@ -3953,7 +3955,7 @@ extern void check_class_changed(struct rq *rq, struct task_struct *p,
 #ifdef CONFIG_SMP
 extern struct balance_callback *splice_balance_callbacks(struct rq *rq);
 extern void balance_callbacks(struct rq *rq, struct balance_callback *head);
-#else
+#else /* !CONFIG_SMP: */
 
 static inline struct balance_callback *splice_balance_callbacks(struct rq *rq)
 {
@@ -3964,7 +3966,7 @@ static inline void balance_callbacks(struct rq *rq, struct balance_callback *hea
 {
 }
 
-#endif
+#endif /* !CONFIG_SMP */
 
 #ifdef CONFIG_SCHED_CLASS_EXT
 /*

