Return-Path: <linux-tip-commits+bounces-5812-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 05D5CAD8492
	for <lists+linux-tip-commits@lfdr.de>; Fri, 13 Jun 2025 09:44:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C34E3178D82
	for <lists+linux-tip-commits@lfdr.de>; Fri, 13 Jun 2025 07:44:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB1342F2C5B;
	Fri, 13 Jun 2025 07:37:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="0Q45QQc6";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="6lJIuou6"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFB222ED845;
	Fri, 13 Jun 2025 07:37:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749800259; cv=none; b=kqMMOkC2BFa7dMT8MdLEpSLrYWOBYjyQy7EBBXg1GmgL0M9pCcPV5xDbVRwdEoS1y1FzYPJvBJNvoByY2gXj8Zg/kB/UQTloqDE2u8LUAlv8jI/LzM6iZwmRNrGGhw0MbMMdhdjo66P3Pwzww/j6YCj4y5wrbLtszMdLdt/lkZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749800259; c=relaxed/simple;
	bh=ehwk764SOUQTO9fotq3vLTqgACmrv/icwsLb2ZFD/2I=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=rVtKLjn0/i7/Hey/mhS5y7XJ65C7g2ygMY4ztqHH5dgzs/OIVPSfXqltJEDS198hiFu8IDxBjyzR+yyfvZeWGrYbBGk4qpjfYLLDBw1APfzYeeBF0MVU0fZkZwqcA1WWGQEqd9SCH+Lsq3awWlyy1ieQgH+6xlG2gnpcN52oJhI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=0Q45QQc6; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=6lJIuou6; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 13 Jun 2025 07:37:34 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1749800255;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4zovlNKsAwlGuOaCg8u3rcN9Oi9l0aYTXOi9CzP9+lE=;
	b=0Q45QQc68h/y91vj1W+g8b0EZugTvFVEuJtoEjr+sAWaHi+SJ9kfgC13DgV6BtsVM+VFPH
	CbhHCf6cgzL+3zlTnPIdcKR5vuyW4AXsv6AzWfPUiuvZg0RB4mtUqhgAFuhxmQoigEuc66
	y+0OYiUUoGGmUAUH60DgfIEyx+VBZrYqZmIRbz3smgdf9LpcnwcVL2gUOpd98+L00sJCsz
	nHo60DTs3qfaQAWJgS3jC8uconvG/TRN8bjNW3/+IWoandZg83HmYkKiVCWa+SO1cRMlts
	DDx47iLKbxU2X8Lz/6vsiNMwyYTZjcGUixuRTPsCdaWzTRvhTrhOggTJ+Bfm6w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1749800255;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4zovlNKsAwlGuOaCg8u3rcN9Oi9l0aYTXOi9CzP9+lE=;
	b=6lJIuou61GHPUGld9AgBuDXviVmkJHL1ZkvjMwAlsjQ6f4OhixPCvWzXGncI4fXrxJqU7g
	jksUcI6ke5QP+PDQ==
From: "tip-bot2 for Ingo Molnar" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched: Clean up and standardize #if/#else/#endif
 markers in sched/fair.c
Cc: Ingo Molnar <mingo@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Juri Lelli <juri.lelli@redhat.com>,
 Linus Torvalds <torvalds@linux-foundation.org>, Mel Gorman <mgorman@suse.de>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Shrikanth Hegde <sshegde@linux.ibm.com>, Steven Rostedt <rostedt@goodmis.org>,
 Valentin Schneider <vschneid@redhat.com>,
 Vincent Guittot <vincent.guittot@linaro.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250528080924.2273858-10-mingo@kernel.org>
References: <20250528080924.2273858-10-mingo@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174980025458.406.16658529902407667827.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     416d5f78e4d3b010734248cb0aad9dc54b7589fa
Gitweb:        https://git.kernel.org/tip/416d5f78e4d3b010734248cb0aad9dc54b7589fa
Author:        Ingo Molnar <mingo@kernel.org>
AuthorDate:    Wed, 28 May 2025 10:08:50 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Fri, 13 Jun 2025 08:47:16 +02:00

sched: Clean up and standardize #if/#else/#endif markers in sched/fair.c

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
Link: https://lore.kernel.org/r/20250528080924.2273858-10-mingo@kernel.org
---
 kernel/sched/fair.c | 111 +++++++++++++++++++++----------------------
 1 file changed, 56 insertions(+), 55 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 83157de..1fabbe0 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -111,7 +111,7 @@ int __weak arch_asym_cpu_priority(int cpu)
  * (default: ~5%)
  */
 #define capacity_greater(cap1, cap2) ((cap1) * 1024 > (cap2) * 1078)
-#endif
+#endif /* CONFIG_SMP */
 
 #ifdef CONFIG_CFS_BANDWIDTH
 /*
@@ -162,7 +162,7 @@ static int __init sched_fair_sysctl_init(void)
 	return 0;
 }
 late_initcall(sched_fair_sysctl_init);
-#endif
+#endif /* CONFIG_SYSCTL */
 
 static inline void update_load_add(struct load_weight *lw, unsigned long inc)
 {
@@ -471,7 +471,7 @@ static int se_is_idle(struct sched_entity *se)
 	return cfs_rq_is_idle(group_cfs_rq(se));
 }
 
-#else	/* !CONFIG_FAIR_GROUP_SCHED */
+#else /* !CONFIG_FAIR_GROUP_SCHED: */
 
 #define for_each_sched_entity(se) \
 		for (; se; se = NULL)
@@ -517,7 +517,7 @@ static int se_is_idle(struct sched_entity *se)
 	return task_has_idle_policy(task_of(se));
 }
 
-#endif	/* CONFIG_FAIR_GROUP_SCHED */
+#endif /* !CONFIG_FAIR_GROUP_SCHED */
 
 static __always_inline
 void account_cfs_rq_runtime(struct cfs_rq *cfs_rq, u64 delta_exec);
@@ -1008,7 +1008,7 @@ int sched_update_scaling(void)
 
 	return 0;
 }
-#endif
+#endif /* CONFIG_SMP */
 
 static void clear_buddies(struct cfs_rq *cfs_rq, struct sched_entity *se);
 
@@ -1041,6 +1041,7 @@ static bool update_deadline(struct cfs_rq *cfs_rq, struct sched_entity *se)
 }
 
 #include "pelt.h"
+
 #ifdef CONFIG_SMP
 
 static int select_idle_sibling(struct task_struct *p, int prev_cpu, int cpu);
@@ -1131,7 +1132,7 @@ void post_init_entity_util_avg(struct task_struct *p)
 	sa->runnable_avg = sa->util_avg;
 }
 
-#else /* !CONFIG_SMP */
+#else /* !CONFIG_SMP: */
 void init_entity_runnable_average(struct sched_entity *se)
 {
 }
@@ -1141,7 +1142,7 @@ void post_init_entity_util_avg(struct task_struct *p)
 static void update_tg_load_avg(struct cfs_rq *cfs_rq)
 {
 }
-#endif /* CONFIG_SMP */
+#endif /* !CONFIG_SMP */
 
 static s64 update_curr_se(struct rq *rq, struct sched_entity *curr)
 {
@@ -2114,12 +2115,12 @@ static inline int numa_idle_core(int idle_core, int cpu)
 
 	return idle_core;
 }
-#else
+#else /* !CONFIG_SCHED_SMT: */
 static inline int numa_idle_core(int idle_core, int cpu)
 {
 	return idle_core;
 }
-#endif
+#endif /* !CONFIG_SCHED_SMT */
 
 /*
  * Gather all necessary information to make NUMA balancing placement
@@ -3673,7 +3674,8 @@ static void update_scan_period(struct task_struct *p, int new_cpu)
 	p->numa_scan_period = task_scan_start(p);
 }
 
-#else
+#else /* !CONFIG_NUMA_BALANCING: */
+
 static void task_tick_numa(struct rq *rq, struct task_struct *curr)
 {
 }
@@ -3690,7 +3692,7 @@ static inline void update_scan_period(struct task_struct *p, int new_cpu)
 {
 }
 
-#endif /* CONFIG_NUMA_BALANCING */
+#endif /* !CONFIG_NUMA_BALANCING */
 
 static void
 account_entity_enqueue(struct cfs_rq *cfs_rq, struct sched_entity *se)
@@ -3785,12 +3787,12 @@ dequeue_load_avg(struct cfs_rq *cfs_rq, struct sched_entity *se)
 	cfs_rq->avg.load_sum = max_t(u32, cfs_rq->avg.load_sum,
 					  cfs_rq->avg.load_avg * PELT_MIN_DIVIDER);
 }
-#else
+#else /* !CONFIG_SMP: */
 static inline void
 enqueue_load_avg(struct cfs_rq *cfs_rq, struct sched_entity *se) { }
 static inline void
 dequeue_load_avg(struct cfs_rq *cfs_rq, struct sched_entity *se) { }
-#endif
+#endif /* !CONFIG_SMP */
 
 static void place_entity(struct cfs_rq *cfs_rq, struct sched_entity *se, int flags);
 
@@ -4000,11 +4002,11 @@ static void update_cfs_group(struct sched_entity *se)
 		reweight_entity(cfs_rq_of(se), se, shares);
 }
 
-#else /* CONFIG_FAIR_GROUP_SCHED */
+#else /* !CONFIG_FAIR_GROUP_SCHED: */
 static inline void update_cfs_group(struct sched_entity *se)
 {
 }
-#endif /* CONFIG_FAIR_GROUP_SCHED */
+#endif /* !CONFIG_FAIR_GROUP_SCHED */
 
 static inline void cfs_rq_util_change(struct cfs_rq *cfs_rq, int flags)
 {
@@ -4481,7 +4483,7 @@ static inline bool skip_blocked_update(struct sched_entity *se)
 	return true;
 }
 
-#else /* CONFIG_FAIR_GROUP_SCHED */
+#else /* !CONFIG_FAIR_GROUP_SCHED: */
 
 static inline void update_tg_load_avg(struct cfs_rq *cfs_rq) {}
 
@@ -4494,7 +4496,7 @@ static inline int propagate_entity_load_avg(struct sched_entity *se)
 
 static inline void add_tg_cfs_propagate(struct cfs_rq *cfs_rq, long runnable_sum) {}
 
-#endif /* CONFIG_FAIR_GROUP_SCHED */
+#endif /* !CONFIG_FAIR_GROUP_SCHED */
 
 #ifdef CONFIG_NO_HZ_COMMON
 static inline void migrate_se_pelt_lag(struct sched_entity *se)
@@ -4575,9 +4577,9 @@ static inline void migrate_se_pelt_lag(struct sched_entity *se)
 
 	__update_load_avg_blocked_se(now, se);
 }
-#else
+#else /* !CONFIG_NO_HZ_COMMON: */
 static void migrate_se_pelt_lag(struct sched_entity *se) {}
-#endif
+#endif /* !CONFIG_NO_HZ_COMMON */
 
 /**
  * update_cfs_rq_load_avg - update the cfs_rq's load/util averages
@@ -5144,7 +5146,7 @@ static inline void update_misfit_status(struct task_struct *p, struct rq *rq)
 	rq->misfit_task_load = max_t(unsigned long, task_h_load(p), 1);
 }
 
-#else /* CONFIG_SMP */
+#else /* !CONFIG_SMP: */
 
 static inline bool cfs_rq_is_decayed(struct cfs_rq *cfs_rq)
 {
@@ -5184,7 +5186,7 @@ util_est_update(struct cfs_rq *cfs_rq, struct task_struct *p,
 		bool task_sleep) {}
 static inline void update_misfit_status(struct task_struct *p, struct rq *rq) {}
 
-#endif /* CONFIG_SMP */
+#endif /* !CONFIG_SMP */
 
 void __setparam_fair(struct task_struct *p, const struct sched_attr *attr)
 {
@@ -5685,7 +5687,7 @@ void cfs_bandwidth_usage_dec(void)
 {
 	static_key_slow_dec_cpuslocked(&__cfs_bandwidth_used);
 }
-#else /* CONFIG_JUMP_LABEL */
+#else /* !CONFIG_JUMP_LABEL: */
 static bool cfs_bandwidth_used(void)
 {
 	return true;
@@ -5693,7 +5695,7 @@ static bool cfs_bandwidth_used(void)
 
 void cfs_bandwidth_usage_inc(void) {}
 void cfs_bandwidth_usage_dec(void) {}
-#endif /* CONFIG_JUMP_LABEL */
+#endif /* !CONFIG_JUMP_LABEL */
 
 /*
  * default period for cfs group bandwidth.
@@ -6147,12 +6149,12 @@ static inline void __unthrottle_cfs_rq_async(struct cfs_rq *cfs_rq)
 	if (first)
 		smp_call_function_single_async(cpu_of(rq), &rq->cfsb_csd);
 }
-#else
+#else /* !CONFIG_SMP: */
 static inline void __unthrottle_cfs_rq_async(struct cfs_rq *cfs_rq)
 {
 	unthrottle_cfs_rq(cfs_rq);
 }
-#endif
+#endif /* !CONFIG_SMP */
 
 static void unthrottle_cfs_rq_async(struct cfs_rq *cfs_rq)
 {
@@ -6733,9 +6735,9 @@ static void sched_fair_update_stop_tick(struct rq *rq, struct task_struct *p)
 	if (cfs_task_bw_constrained(p))
 		tick_nohz_dep_set_cpu(cpu, TICK_DEP_BIT_SCHED);
 }
-#endif
+#endif /* CONFIG_NO_HZ_FULL */
 
-#else /* CONFIG_CFS_BANDWIDTH */
+#else /* !CONFIG_CFS_BANDWIDTH: */
 
 static void account_cfs_rq_runtime(struct cfs_rq *cfs_rq, u64 delta_exec) {}
 static bool check_cfs_rq_runtime(struct cfs_rq *cfs_rq) { return false; }
@@ -6777,7 +6779,7 @@ bool cfs_task_bw_constrained(struct task_struct *p)
 	return false;
 }
 #endif
-#endif /* CONFIG_CFS_BANDWIDTH */
+#endif /* !CONFIG_CFS_BANDWIDTH */
 
 #if !defined(CONFIG_CFS_BANDWIDTH) || !defined(CONFIG_NO_HZ_FULL)
 static inline void sched_fair_update_stop_tick(struct rq *rq, struct task_struct *p) {}
@@ -6822,7 +6824,7 @@ static void hrtick_update(struct rq *rq)
 
 	hrtick_start_fair(rq, donor);
 }
-#else /* !CONFIG_SCHED_HRTICK */
+#else /* !CONFIG_SCHED_HRTICK: */
 static inline void
 hrtick_start_fair(struct rq *rq, struct task_struct *p)
 {
@@ -6831,7 +6833,7 @@ hrtick_start_fair(struct rq *rq, struct task_struct *p)
 static inline void hrtick_update(struct rq *rq)
 {
 }
-#endif
+#endif /* !CONFIG_SCHED_HRTICK */
 
 #ifdef CONFIG_SMP
 static inline bool cpu_overutilized(int cpu)
@@ -6875,9 +6877,9 @@ static inline void check_update_overutilized_status(struct rq *rq)
 	if (!is_rd_overutilized(rq->rd) && cpu_overutilized(rq->cpu))
 		set_rd_overutilized(rq->rd, 1);
 }
-#else
+#else /* !CONFIG_SMP: */
 static inline void check_update_overutilized_status(struct rq *rq) { }
-#endif
+#endif /* !CONFIG_SMP */
 
 /* Runqueue only has SCHED_IDLE tasks enqueued */
 static int sched_idle_rq(struct rq *rq)
@@ -7677,7 +7679,7 @@ static int select_idle_smt(struct task_struct *p, struct sched_domain *sd, int t
 	return -1;
 }
 
-#else /* CONFIG_SCHED_SMT */
+#else /* !CONFIG_SCHED_SMT: */
 
 static inline void set_idle_cores(int cpu, int val)
 {
@@ -7698,7 +7700,7 @@ static inline int select_idle_smt(struct task_struct *p, struct sched_domain *sd
 	return -1;
 }
 
-#endif /* CONFIG_SCHED_SMT */
+#endif /* !CONFIG_SCHED_SMT */
 
 /*
  * Scan the LLC domain for idle CPUs; this is dynamically regulated by
@@ -8743,9 +8745,9 @@ balance_fair(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
 
 	return sched_balance_newidle(rq, rf) != 0;
 }
-#else
+#else /* !CONFIG_SMP: */
 static inline void set_task_max_allowed_capacity(struct task_struct *p) {}
-#endif /* CONFIG_SMP */
+#endif /* !CONFIG_SMP */
 
 static void set_next_buddy(struct sched_entity *se)
 {
@@ -8939,7 +8941,7 @@ again:
 	return p;
 
 simple:
-#endif
+#endif /* CONFIG_FAIR_GROUP_SCHED */
 	put_prev_set_next_task(rq, prev, p);
 	return p;
 
@@ -9357,13 +9359,13 @@ static long migrate_degrades_locality(struct task_struct *p, struct lb_env *env)
 	return src_weight - dst_weight;
 }
 
-#else
+#else /* !CONFIG_NUMA_BALANCING: */
 static inline long migrate_degrades_locality(struct task_struct *p,
 					     struct lb_env *env)
 {
 	return 0;
 }
-#endif
+#endif /* !CONFIG_NUMA_BALANCING */
 
 /*
  * Check whether the task is ineligible on the destination cpu
@@ -9772,12 +9774,12 @@ static inline void update_blocked_load_status(struct rq *rq, bool has_blocked)
 	if (!has_blocked)
 		rq->has_blocked_load = 0;
 }
-#else
+#else /* !CONFIG_NO_HZ_COMMON: */
 static inline bool cfs_rq_has_blocked(struct cfs_rq *cfs_rq) { return false; }
 static inline bool others_have_blocked(struct rq *rq) { return false; }
 static inline void update_blocked_load_tick(struct rq *rq) {}
 static inline void update_blocked_load_status(struct rq *rq, bool has_blocked) {}
-#endif
+#endif /* !CONFIG_NO_HZ_COMMON */
 
 static bool __update_blocked_others(struct rq *rq, bool *done)
 {
@@ -9886,7 +9888,7 @@ static unsigned long task_h_load(struct task_struct *p)
 	return div64_ul(p->se.avg.load_avg * cfs_rq->h_load,
 			cfs_rq_load_avg(cfs_rq) + 1);
 }
-#else
+#else /* !CONFIG_FAIR_GROUP_SCHED: */
 static bool __update_blocked_fair(struct rq *rq, bool *done)
 {
 	struct cfs_rq *cfs_rq = &rq->cfs;
@@ -9903,7 +9905,7 @@ static unsigned long task_h_load(struct task_struct *p)
 {
 	return p->se.avg.load_avg;
 }
-#endif
+#endif /* !CONFIG_FAIR_GROUP_SCHED */
 
 static void sched_balance_update_blocked_averages(int cpu)
 {
@@ -10616,7 +10618,7 @@ static inline enum fbq_type fbq_classify_rq(struct rq *rq)
 		return remote;
 	return all;
 }
-#else
+#else /* !CONFIG_NUMA_BALANCING: */
 static inline enum fbq_type fbq_classify_group(struct sg_lb_stats *sgs)
 {
 	return all;
@@ -10626,7 +10628,7 @@ static inline enum fbq_type fbq_classify_rq(struct rq *rq)
 {
 	return regular;
 }
-#endif /* CONFIG_NUMA_BALANCING */
+#endif /* !CONFIG_NUMA_BALANCING */
 
 
 struct sg_lb_stats;
@@ -12772,7 +12774,7 @@ static void nohz_newidle_balance(struct rq *this_rq)
 	atomic_or(NOHZ_NEWILB_KICK, nohz_flags(this_cpu));
 }
 
-#else /* !CONFIG_NO_HZ_COMMON */
+#else /* !CONFIG_NO_HZ_COMMON: */
 static inline void nohz_balancer_kick(struct rq *rq) { }
 
 static inline bool nohz_idle_balance(struct rq *this_rq, enum cpu_idle_type idle)
@@ -12781,7 +12783,7 @@ static inline bool nohz_idle_balance(struct rq *this_rq, enum cpu_idle_type idle
 }
 
 static inline void nohz_newidle_balance(struct rq *this_rq) { }
-#endif /* CONFIG_NO_HZ_COMMON */
+#endif /* !CONFIG_NO_HZ_COMMON */
 
 /*
  * sched_balance_newidle is called by schedule() if this_cpu is about to become
@@ -13076,10 +13078,10 @@ bool cfs_prio_less(const struct task_struct *a, const struct task_struct *b,
 
 	cfs_rqa = sea->cfs_rq;
 	cfs_rqb = seb->cfs_rq;
-#else
+#else /* !CONFIG_FAIR_GROUP_SCHED: */
 	cfs_rqa = &task_rq(a)->cfs;
 	cfs_rqb = &task_rq(b)->cfs;
-#endif
+#endif /* !CONFIG_FAIR_GROUP_SCHED */
 
 	/*
 	 * Find delta after normalizing se's vruntime with its cfs_rq's
@@ -13103,9 +13105,9 @@ static int task_is_throttled_fair(struct task_struct *p, int cpu)
 #endif
 	return throttled_hierarchy(cfs_rq);
 }
-#else
+#else /* !CONFIG_SCHED_CORE: */
 static inline void task_tick_core(struct rq *rq, struct task_struct *curr) {}
-#endif
+#endif /* !CONFIG_SCHED_CORE */
 
 /*
  * scheduler tick hitting a task of our scheduling class.
@@ -13199,9 +13201,9 @@ static void propagate_entity_cfs_rq(struct sched_entity *se)
 			list_add_leaf_cfs_rq(cfs_rq);
 	}
 }
-#else
+#else /* !CONFIG_FAIR_GROUP_SCHED: */
 static void propagate_entity_cfs_rq(struct sched_entity *se) { }
-#endif
+#endif /* !CONFIG_FAIR_GROUP_SCHED */
 
 static void detach_entity_cfs_rq(struct sched_entity *se)
 {
@@ -13737,6 +13739,5 @@ __init void init_sched_fair_class(void)
 	nohz.next_blocked = jiffies;
 	zalloc_cpumask_var(&nohz.idle_cpus_mask, GFP_NOWAIT);
 #endif
-#endif /* SMP */
-
+#endif /* CONFIG_SMP */
 }

