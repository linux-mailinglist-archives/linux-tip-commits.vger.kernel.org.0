Return-Path: <linux-tip-commits+bounces-1343-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AF6398FCCAF
	for <lists+linux-tip-commits@lfdr.de>; Wed,  5 Jun 2024 14:26:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0CE32B228AA
	for <lists+linux-tip-commits@lfdr.de>; Wed,  5 Jun 2024 12:26:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBA4119CCFE;
	Wed,  5 Jun 2024 11:58:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="SMcqsnkN";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="4Yjnb5d9"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31A4119CCEE;
	Wed,  5 Jun 2024 11:58:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717588729; cv=none; b=ZNwSVVS/7uBIoE0QM/GI+NBXjQpUaUXv8eJu9vyCnCoTx5slx8LW5F290sPu5YLMUBuuMR0z0pW85X5GfZHt1yScR9I5XeESbwF7102uLtSPF1G8NGcbO+Duor5gbO72fpvBL17WLBlRZzDUV4qxRwp6wunKVpziTuzlMBhrbYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717588729; c=relaxed/simple;
	bh=inQ7qdqAO/X2kbBorwUsxyOsjNwl90u32J5VLBcBOWs=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=Z6pssW1voa8FWpr8wEmTdwZYHSGbpBhnq192ODwsYYmUMZcCfpY2wxVLLj51R65mWaDJg4ktLHvdLLWgxkXWrgNzfFSkLxglosFgvssmH10EnHunKR7hJshqjRU5G02RrcHQlXdqSjy29ydZULh7EcANeVtPtFetBZi67Vjg6Fo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=SMcqsnkN; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=4Yjnb5d9; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 05 Jun 2024 11:58:45 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1717588725;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=lXWHcST0D/iOeLHXnbkJJxPlFpZPpIfLeBiziaJsxeE=;
	b=SMcqsnkNwnhYlX+5Fc1lxpTQZ/gX8yiQrvlZZxu98AzD01+KdzfiJPD1ECh8mTW0k3PorS
	c/36Vv+U1XnEMfH/dJg2dcOuOikj0C4JJtz1dkG/RmVJuymnByAqoURTDUXnJtWDoypwf2
	A37OFfW3y+m3Bh0kNwqHhiyK0+qN6CQdn3DwQPeYGgUJ41Vj9hVmO0hHsg4cOcNhKfCk7y
	HtcnbueEvW3iqFntRlSfWBOXES0fwLl9w0gdbvOZyPQ34Ht6GWzJZofnKcUp6qkOGMEZLD
	cPksTAlTX7QBzzKHQySq0VCa4ksh5xvU1qIcSfMWCwG64qwny+34anlBY+UmHQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1717588725;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=lXWHcST0D/iOeLHXnbkJJxPlFpZPpIfLeBiziaJsxeE=;
	b=4Yjnb5d9oaK2Ml7UPgGNOy0FRj7+pAhCfW/w3aPsHpggxT+aE/ZFILHqpPpssQYBSUH79z
	eIlyU4laL7jaPABg==
From: "tip-bot2 for Ingo Molnar" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/core: Clean up kernel/sched/sched.h a bit
Cc: Ingo Molnar <mingo@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
 linux-kernel@vger.kernel.org, x86@kernel.org
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171758872528.10875.5286719730050985619.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     127f6bf1618868920c1f77e0a427d1f4570e450b
Gitweb:        https://git.kernel.org/tip/127f6bf1618868920c1f77e0a427d1f4570e450b
Author:        Ingo Molnar <mingo@kernel.org>
AuthorDate:    Wed, 05 Jun 2024 13:39:31 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Wed, 05 Jun 2024 13:52:21 +02:00

sched/core: Clean up kernel/sched/sched.h a bit

 - Fix whitespace noise
 - Fix col80 linebreak damage where possible
 - Apply CodingStyle consistently
 - Use consistent #else and #endif comments
 - Use consistent vertical alignment
 - Use 'extern' consistently

Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: linux-kernel@vger.kernel.org
---
 kernel/sched/sched.h | 312 ++++++++++++++++++++++++------------------
 1 file changed, 180 insertions(+), 132 deletions(-)

diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index cefa27f..078241d 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -128,7 +128,7 @@ extern struct list_head asym_cap_list;
 /*
  * Helpers for converting nanosecond timing to jiffy resolution
  */
-#define NS_TO_JIFFIES(TIME)	((unsigned long)(TIME) / (NSEC_PER_SEC / HZ))
+#define NS_TO_JIFFIES(time)	((unsigned long)(time) / (NSEC_PER_SEC/HZ))
 
 /*
  * Increase resolution of nice-level calculations for 64-bit architectures.
@@ -147,12 +147,13 @@ extern struct list_head asym_cap_list;
 #ifdef CONFIG_64BIT
 # define NICE_0_LOAD_SHIFT	(SCHED_FIXEDPOINT_SHIFT + SCHED_FIXEDPOINT_SHIFT)
 # define scale_load(w)		((w) << SCHED_FIXEDPOINT_SHIFT)
-# define scale_load_down(w) \
-({ \
-	unsigned long __w = (w); \
-	if (__w) \
-		__w = max(2UL, __w >> SCHED_FIXEDPOINT_SHIFT); \
-	__w; \
+# define scale_load_down(w)					\
+({								\
+	unsigned long __w = (w);				\
+								\
+	if (__w)						\
+		__w = max(2UL, __w >> SCHED_FIXEDPOINT_SHIFT);	\
+	__w;							\
 })
 #else
 # define NICE_0_LOAD_SHIFT	(SCHED_FIXEDPOINT_SHIFT)
@@ -187,6 +188,7 @@ static inline int idle_policy(int policy)
 {
 	return policy == SCHED_IDLE;
 }
+
 static inline int fair_policy(int policy)
 {
 	return policy == SCHED_NORMAL || policy == SCHED_BATCH;
@@ -201,6 +203,7 @@ static inline int dl_policy(int policy)
 {
 	return policy == SCHED_DEADLINE;
 }
+
 static inline bool valid_policy(int policy)
 {
 	return idle_policy(policy) || fair_policy(policy) ||
@@ -222,11 +225,12 @@ static inline int task_has_dl_policy(struct task_struct *p)
 	return dl_policy(p->policy);
 }
 
-#define cap_scale(v, s) ((v)*(s) >> SCHED_CAPACITY_SHIFT)
+#define cap_scale(v, s)		((v)*(s) >> SCHED_CAPACITY_SHIFT)
 
 static inline void update_avg(u64 *avg, u64 sample)
 {
 	s64 diff = sample - *avg;
+
 	*avg += diff / 8;
 }
 
@@ -251,7 +255,7 @@ static inline void update_avg(u64 *avg, u64 sample)
  */
 #define SCHED_FLAG_SUGOV	0x10000000
 
-#define SCHED_DL_FLAGS (SCHED_FLAG_RECLAIM | SCHED_FLAG_DL_OVERRUN | SCHED_FLAG_SUGOV)
+#define SCHED_DL_FLAGS		(SCHED_FLAG_RECLAIM | SCHED_FLAG_DL_OVERRUN | SCHED_FLAG_SUGOV)
 
 static inline bool dl_entity_is_special(const struct sched_dl_entity *dl_se)
 {
@@ -536,6 +540,7 @@ static inline void set_task_rq_fair(struct sched_entity *se,
 #else /* CONFIG_CGROUP_SCHED */
 
 struct cfs_bandwidth { };
+
 static inline bool cfs_task_bw_constrained(struct task_struct *p) { return false; }
 
 #endif	/* CONFIG_CGROUP_SCHED */
@@ -551,8 +556,8 @@ extern int alloc_rt_sched_group(struct task_group *tg, struct task_group *parent
  * applicable for 32-bits architectures.
  */
 #ifdef CONFIG_64BIT
-# define u64_u32_load_copy(var, copy)       var
-# define u64_u32_store_copy(var, copy, val) (var = val)
+# define u64_u32_load_copy(var, copy)		var
+# define u64_u32_store_copy(var, copy, val)	(var = val)
 #else
 # define u64_u32_load_copy(var, copy)					\
 ({									\
@@ -580,8 +585,8 @@ do {									\
 	copy = __val;							\
 } while (0)
 #endif
-# define u64_u32_load(var)      u64_u32_load_copy(var, var##_copy)
-# define u64_u32_store(var, val) u64_u32_store_copy(var, var##_copy, val)
+# define u64_u32_load(var)		u64_u32_load_copy(var, var##_copy)
+# define u64_u32_store(var, val)	u64_u32_store_copy(var, var##_copy, val)
 
 /* CFS-related fields in a runqueue */
 struct cfs_rq {
@@ -803,6 +808,7 @@ struct dl_rq {
 };
 
 #ifdef CONFIG_FAIR_GROUP_SCHED
+
 /* An entity is a task if it doesn't "own" a runqueue */
 #define entity_is_task(se)	(!se->my_q)
 
@@ -820,16 +826,18 @@ static inline long se_runnable(struct sched_entity *se)
 		return se->runnable_weight;
 }
 
-#else
+#else /* !CONFIG_FAIR_GROUP_SCHED: */
+
 #define entity_is_task(se)	1
 
-static inline void se_update_runnable(struct sched_entity *se) {}
+static inline void se_update_runnable(struct sched_entity *se) { }
 
 static inline long se_runnable(struct sched_entity *se)
 {
 	return !!se->on_rq;
 }
-#endif
+
+#endif /* !CONFIG_FAIR_GROUP_SCHED */
 
 #ifdef CONFIG_SMP
 /*
@@ -989,6 +997,7 @@ DECLARE_STATIC_KEY_FALSE(sched_uclamp_used);
 #endif /* CONFIG_UCLAMP_TASK */
 
 struct rq;
+
 struct balance_callback {
 	struct balance_callback *next;
 	void (*func)(struct rq *rq);
@@ -1143,7 +1152,7 @@ struct rq {
 	call_single_data_t	hrtick_csd;
 #endif
 	struct hrtimer		hrtick_timer;
-	ktime_t 		hrtick_time;
+	ktime_t			hrtick_time;
 #endif
 
 #ifdef CONFIG_SCHEDSTATS
@@ -1227,7 +1236,7 @@ static inline int cpu_of(struct rq *rq)
 #endif
 }
 
-#define MDF_PUSH	0x01
+#define MDF_PUSH		0x01
 
 static inline bool is_migration_disabled(struct task_struct *p)
 {
@@ -1247,6 +1256,7 @@ DECLARE_PER_CPU_SHARED_ALIGNED(struct rq, runqueues);
 #define raw_rq()		raw_cpu_ptr(&runqueues)
 
 struct sched_group;
+
 #ifdef CONFIG_SCHED_CORE
 static inline struct cpumask *sched_group_span(struct sched_group *sg);
 
@@ -1282,9 +1292,10 @@ static inline raw_spinlock_t *__rq_lockp(struct rq *rq)
 	return &rq->__lock;
 }
 
-bool cfs_prio_less(const struct task_struct *a, const struct task_struct *b,
-			bool fi);
-void task_vruntime_update(struct rq *rq, struct task_struct *p, bool in_fi);
+extern bool
+cfs_prio_less(const struct task_struct *a, const struct task_struct *b, bool fi);
+
+extern void task_vruntime_update(struct rq *rq, struct task_struct *p, bool in_fi);
 
 /*
  * Helpers to check if the CPU's core cookie matches with the task's cookie
@@ -1352,7 +1363,7 @@ extern void sched_core_dequeue(struct rq *rq, struct task_struct *p, int flags);
 extern void sched_core_get(void);
 extern void sched_core_put(void);
 
-#else /* !CONFIG_SCHED_CORE */
+#else /* !CONFIG_SCHED_CORE: */
 
 static inline bool sched_core_enabled(struct rq *rq)
 {
@@ -1390,7 +1401,8 @@ static inline bool sched_group_cookie_match(struct rq *rq,
 {
 	return true;
 }
-#endif /* CONFIG_SCHED_CORE */
+
+#endif /* !CONFIG_SCHED_CORE */
 
 static inline void lockdep_assert_rq_held(struct rq *rq)
 {
@@ -1421,8 +1433,10 @@ static inline void raw_spin_rq_unlock_irq(struct rq *rq)
 static inline unsigned long _raw_spin_rq_lock_irqsave(struct rq *rq)
 {
 	unsigned long flags;
+
 	local_irq_save(flags);
 	raw_spin_rq_lock(rq);
+
 	return flags;
 }
 
@@ -1451,6 +1465,7 @@ static inline void update_idle_core(struct rq *rq) { }
 #endif
 
 #ifdef CONFIG_FAIR_GROUP_SCHED
+
 static inline struct task_struct *task_of(struct sched_entity *se)
 {
 	SCHED_WARN_ON(!entity_is_task(se));
@@ -1474,9 +1489,9 @@ static inline struct cfs_rq *group_cfs_rq(struct sched_entity *grp)
 	return grp->my_q;
 }
 
-#else
+#else /* !CONFIG_FAIR_GROUP_SCHED: */
 
-#define task_of(_se)	container_of(_se, struct task_struct, se)
+#define task_of(_se)		container_of(_se, struct task_struct, se)
 
 static inline struct cfs_rq *task_cfs_rq(const struct task_struct *p)
 {
@@ -1496,7 +1511,8 @@ static inline struct cfs_rq *group_cfs_rq(struct sched_entity *grp)
 {
 	return NULL;
 }
-#endif
+
+#endif /* !CONFIG_FAIR_GROUP_SCHED */
 
 extern void update_rq_clock(struct rq *rq);
 
@@ -1622,9 +1638,9 @@ static inline void rq_pin_lock(struct rq *rq, struct rq_flags *rf)
 #ifdef CONFIG_SCHED_DEBUG
 	rq->clock_update_flags &= (RQCF_REQ_SKIP|RQCF_ACT_SKIP);
 	rf->clock_update_flags = 0;
-#ifdef CONFIG_SMP
+# ifdef CONFIG_SMP
 	SCHED_WARN_ON(rq->balance_callback && rq->balance_callback != &balance_push_callback);
-#endif
+# endif
 #endif
 }
 
@@ -1650,9 +1666,11 @@ static inline void rq_repin_lock(struct rq *rq, struct rq_flags *rf)
 #endif
 }
 
+extern
 struct rq *__task_rq_lock(struct task_struct *p, struct rq_flags *rf)
 	__acquires(rq->lock);
 
+extern
 struct rq *task_rq_lock(struct task_struct *p, struct rq_flags *rf)
 	__acquires(p->pi_lock)
 	__acquires(rq->lock);
@@ -1679,48 +1697,42 @@ DEFINE_LOCK_GUARD_1(task_rq_lock, struct task_struct,
 		    task_rq_unlock(_T->rq, _T->lock, &_T->rf),
 		    struct rq *rq; struct rq_flags rf)
 
-static inline void
-rq_lock_irqsave(struct rq *rq, struct rq_flags *rf)
+static inline void rq_lock_irqsave(struct rq *rq, struct rq_flags *rf)
 	__acquires(rq->lock)
 {
 	raw_spin_rq_lock_irqsave(rq, rf->flags);
 	rq_pin_lock(rq, rf);
 }
 
-static inline void
-rq_lock_irq(struct rq *rq, struct rq_flags *rf)
+static inline void rq_lock_irq(struct rq *rq, struct rq_flags *rf)
 	__acquires(rq->lock)
 {
 	raw_spin_rq_lock_irq(rq);
 	rq_pin_lock(rq, rf);
 }
 
-static inline void
-rq_lock(struct rq *rq, struct rq_flags *rf)
+static inline void rq_lock(struct rq *rq, struct rq_flags *rf)
 	__acquires(rq->lock)
 {
 	raw_spin_rq_lock(rq);
 	rq_pin_lock(rq, rf);
 }
 
-static inline void
-rq_unlock_irqrestore(struct rq *rq, struct rq_flags *rf)
+static inline void rq_unlock_irqrestore(struct rq *rq, struct rq_flags *rf)
 	__releases(rq->lock)
 {
 	rq_unpin_lock(rq, rf);
 	raw_spin_rq_unlock_irqrestore(rq, rf->flags);
 }
 
-static inline void
-rq_unlock_irq(struct rq *rq, struct rq_flags *rf)
+static inline void rq_unlock_irq(struct rq *rq, struct rq_flags *rf)
 	__releases(rq->lock)
 {
 	rq_unpin_lock(rq, rf);
 	raw_spin_rq_unlock_irq(rq);
 }
 
-static inline void
-rq_unlock(struct rq *rq, struct rq_flags *rf)
+static inline void rq_unlock(struct rq *rq, struct rq_flags *rf)
 	__releases(rq->lock)
 {
 	rq_unpin_lock(rq, rf);
@@ -1742,8 +1754,7 @@ DEFINE_LOCK_GUARD_1(rq_lock_irqsave, struct rq,
 		    rq_unlock_irqrestore(_T->lock, &_T->rf),
 		    struct rq_flags rf)
 
-static inline struct rq *
-this_rq_lock_irq(struct rq_flags *rf)
+static inline struct rq *this_rq_lock_irq(struct rq_flags *rf)
 	__acquires(rq->lock)
 {
 	struct rq *rq;
@@ -1751,15 +1762,18 @@ this_rq_lock_irq(struct rq_flags *rf)
 	local_irq_disable();
 	rq = this_rq();
 	rq_lock(rq, rf);
+
 	return rq;
 }
 
 #ifdef CONFIG_NUMA
+
 enum numa_topology_type {
 	NUMA_DIRECT,
 	NUMA_GLUELESS_MESH,
 	NUMA_BACKPLANE,
 };
+
 extern enum numa_topology_type sched_numa_topology_type;
 extern int sched_max_numa_distance;
 extern bool find_numa_distance(int distance);
@@ -1768,18 +1782,23 @@ extern void sched_update_numa(int cpu, bool online);
 extern void sched_domains_numa_masks_set(unsigned int cpu);
 extern void sched_domains_numa_masks_clear(unsigned int cpu);
 extern int sched_numa_find_closest(const struct cpumask *cpus, int cpu);
-#else
+
+#else /* !CONFIG_NUMA: */
+
 static inline void sched_init_numa(int offline_node) { }
 static inline void sched_update_numa(int cpu, bool online) { }
 static inline void sched_domains_numa_masks_set(unsigned int cpu) { }
 static inline void sched_domains_numa_masks_clear(unsigned int cpu) { }
+
 static inline int sched_numa_find_closest(const struct cpumask *cpus, int cpu)
 {
 	return nr_cpu_ids;
 }
-#endif
+
+#endif /* !CONFIG_NUMA */
 
 #ifdef CONFIG_NUMA_BALANCING
+
 /* The regions in numa_faults array from task_struct */
 enum numa_faults_stats {
 	NUMA_MEM = 0,
@@ -1787,17 +1806,21 @@ enum numa_faults_stats {
 	NUMA_MEMBUF,
 	NUMA_CPUBUF
 };
+
 extern void sched_setnuma(struct task_struct *p, int node);
 extern int migrate_task_to(struct task_struct *p, int cpu);
 extern int migrate_swap(struct task_struct *p, struct task_struct *t,
 			int cpu, int scpu);
 extern void init_numa_balancing(unsigned long clone_flags, struct task_struct *p);
-#else
+
+#else /* !CONFIG_NUMA_BALANCING: */
+
 static inline void
 init_numa_balancing(unsigned long clone_flags, struct task_struct *p)
 {
 }
-#endif /* CONFIG_NUMA_BALANCING */
+
+#endif /* !CONFIG_NUMA_BALANCING */
 
 #ifdef CONFIG_SMP
 
@@ -1822,8 +1845,7 @@ queue_balance_callback(struct rq *rq,
 }
 
 #define rcu_dereference_check_sched_domain(p) \
-	rcu_dereference_check((p), \
-			      lockdep_is_held(&sched_domains_mutex))
+	rcu_dereference_check((p), lockdep_is_held(&sched_domains_mutex))
 
 /*
  * The domain tree (rq->sd) is protected by RCU's quiescent state transition.
@@ -1894,6 +1916,7 @@ DECLARE_PER_CPU(struct sched_domain_shared __rcu *, sd_llc_shared);
 DECLARE_PER_CPU(struct sched_domain __rcu *, sd_numa);
 DECLARE_PER_CPU(struct sched_domain __rcu *, sd_asym_packing);
 DECLARE_PER_CPU(struct sched_domain __rcu *, sd_asym_cpucapacity);
+
 extern struct static_key_false sched_asym_cpucapacity;
 extern struct static_key_false sched_cluster_active;
 
@@ -1957,15 +1980,11 @@ static inline struct cpumask *group_balance_mask(struct sched_group *sg)
 extern int group_balance_cpu(struct sched_group *sg);
 
 #ifdef CONFIG_SCHED_DEBUG
-void update_sched_domain_debugfs(void);
-void dirty_sched_domain_sysctl(int cpu);
+extern void update_sched_domain_debugfs(void);
+extern void dirty_sched_domain_sysctl(int cpu);
 #else
-static inline void update_sched_domain_debugfs(void)
-{
-}
-static inline void dirty_sched_domain_sysctl(int cpu)
-{
-}
+static inline void update_sched_domain_debugfs(void) { }
+static inline void dirty_sched_domain_sysctl(int cpu) { }
 #endif
 
 extern int sched_update_scaling(void);
@@ -1976,6 +1995,7 @@ static inline const struct cpumask *task_user_cpus(struct task_struct *p)
 		return cpu_possible_mask; /* &init_task.cpus_mask */
 	return p->user_cpus_ptr;
 }
+
 #endif /* CONFIG_SMP */
 
 #include "stats.h"
@@ -1998,13 +2018,13 @@ static inline void sched_core_tick(struct rq *rq)
 		__sched_core_tick(rq);
 }
 
-#else
+#else /* !(CONFIG_SCHED_CORE && CONFIG_SCHEDSTATS): */
 
-static inline void sched_core_account_forceidle(struct rq *rq) {}
+static inline void sched_core_account_forceidle(struct rq *rq) { }
 
-static inline void sched_core_tick(struct rq *rq) {}
+static inline void sched_core_tick(struct rq *rq) { }
 
-#endif /* CONFIG_SCHED_CORE && CONFIG_SCHEDSTATS */
+#endif /* !(CONFIG_SCHED_CORE && CONFIG_SCHEDSTATS) */
 
 #ifdef CONFIG_CGROUP_SCHED
 
@@ -2046,15 +2066,16 @@ static inline void set_task_rq(struct task_struct *p, unsigned int cpu)
 #endif
 }
 
-#else /* CONFIG_CGROUP_SCHED */
+#else /* !CONFIG_CGROUP_SCHED: */
 
 static inline void set_task_rq(struct task_struct *p, unsigned int cpu) { }
+
 static inline struct task_group *task_group(struct task_struct *p)
 {
 	return NULL;
 }
 
-#endif /* CONFIG_CGROUP_SCHED */
+#endif /* !CONFIG_CGROUP_SCHED */
 
 static inline void __set_task_cpu(struct task_struct *p, unsigned int cpu)
 {
@@ -2099,6 +2120,7 @@ enum {
 extern const_debug unsigned int sysctl_sched_features;
 
 #ifdef CONFIG_JUMP_LABEL
+
 #define SCHED_FEAT(name, enabled)					\
 static __always_inline bool static_branch_##name(struct static_key *key) \
 {									\
@@ -2111,13 +2133,13 @@ static __always_inline bool static_branch_##name(struct static_key *key) \
 extern struct static_key sched_feat_keys[__SCHED_FEAT_NR];
 #define sched_feat(x) (static_branch_##x(&sched_feat_keys[__SCHED_FEAT_##x]))
 
-#else /* !CONFIG_JUMP_LABEL */
+#else /* !CONFIG_JUMP_LABEL: */
 
 #define sched_feat(x) (sysctl_sched_features & (1UL << __SCHED_FEAT_##x))
 
-#endif /* CONFIG_JUMP_LABEL */
+#endif /* !CONFIG_JUMP_LABEL */
 
-#else /* !SCHED_DEBUG */
+#else /* !SCHED_DEBUG: */
 
 /*
  * Each translation unit has its own copy of sysctl_sched_features to allow
@@ -2133,7 +2155,7 @@ static const_debug __maybe_unused unsigned int sysctl_sched_features =
 
 #define sched_feat(x) !!(sysctl_sched_features & (1UL << __SCHED_FEAT_##x))
 
-#endif /* SCHED_DEBUG */
+#endif /* !SCHED_DEBUG */
 
 extern struct static_key_false sched_numa_balancing;
 extern struct static_key_false sched_schedstats;
@@ -2176,13 +2198,13 @@ static inline int task_on_rq_migrating(struct task_struct *p)
 }
 
 /* Wake flags. The first three directly map to some SD flag value */
-#define WF_EXEC         0x02 /* Wakeup after exec; maps to SD_BALANCE_EXEC */
-#define WF_FORK         0x04 /* Wakeup after fork; maps to SD_BALANCE_FORK */
-#define WF_TTWU         0x08 /* Wakeup;            maps to SD_BALANCE_WAKE */
+#define WF_EXEC			0x02 /* Wakeup after exec; maps to SD_BALANCE_EXEC */
+#define WF_FORK			0x04 /* Wakeup after fork; maps to SD_BALANCE_FORK */
+#define WF_TTWU			0x08 /* Wakeup;            maps to SD_BALANCE_WAKE */
 
-#define WF_SYNC         0x10 /* Waker goes to sleep after wakeup */
-#define WF_MIGRATED     0x20 /* Internal use, task got migrated */
-#define WF_CURRENT_CPU  0x40 /* Prefer to move the wakee to the current CPU. */
+#define WF_SYNC			0x10 /* Waker goes to sleep after wakeup */
+#define WF_MIGRATED		0x20 /* Internal use, task got migrated */
+#define WF_CURRENT_CPU		0x40 /* Prefer to move the wakee to the current CPU. */
 
 #ifdef CONFIG_SMP
 static_assert(WF_EXEC == SD_BALANCE_EXEC);
@@ -2252,9 +2274,9 @@ extern const u32		sched_prio_to_wmult[40];
 #define RETRY_TASK		((void *)-1UL)
 
 struct affinity_context {
-	const struct cpumask *new_mask;
-	struct cpumask *user_mask;
-	unsigned int flags;
+	const struct cpumask	*new_mask;
+	struct cpumask		*user_mask;
+	unsigned int		flags;
 };
 
 extern s64 update_curr_common(struct rq *rq);
@@ -2452,6 +2474,7 @@ static inline cpumask_t *alloc_user_cpus_ptr(int node)
 #endif /* !CONFIG_SMP */
 
 #ifdef CONFIG_CPU_IDLE
+
 static inline void idle_set_state(struct rq *rq,
 				  struct cpuidle_state *idle_state)
 {
@@ -2464,7 +2487,9 @@ static inline struct cpuidle_state *idle_get_state(struct rq *rq)
 
 	return rq->idle_state;
 }
-#else
+
+#else /* !CONFIG_CPU_IDLE: */
+
 static inline void idle_set_state(struct rq *rq,
 				  struct cpuidle_state *idle_state)
 {
@@ -2474,7 +2499,8 @@ static inline struct cpuidle_state *idle_get_state(struct rq *rq)
 {
 	return NULL;
 }
-#endif
+
+#endif /* !CONFIG_CPU_IDLE */
 
 extern void schedule_idle(void);
 asmlinkage void schedule_user(void);
@@ -2503,7 +2529,8 @@ extern void init_dl_entity(struct sched_dl_entity *dl_se);
 #define RATIO_SHIFT		8
 #define MAX_BW_BITS		(64 - BW_SHIFT)
 #define MAX_BW			((1ULL << MAX_BW_BITS) - 1)
-unsigned long to_ratio(u64 period, u64 runtime);
+
+extern unsigned long to_ratio(u64 period, u64 runtime);
 
 extern void init_entity_runnable_average(struct sched_entity *se);
 extern void post_init_entity_util_avg(struct task_struct *p);
@@ -2529,10 +2556,10 @@ static inline void sched_update_tick_dependency(struct rq *rq)
 	else
 		tick_nohz_dep_set_cpu(cpu, TICK_DEP_BIT_SCHED);
 }
-#else
+#else /* !CONFIG_NO_HZ_FULL: */
 static inline int sched_tick_offload_init(void) { return 0; }
 static inline void sched_update_tick_dependency(struct rq *rq) { }
-#endif
+#endif /* !CONFIG_NO_HZ_FULL */
 
 static inline void add_nr_running(struct rq *rq, unsigned count)
 {
@@ -2568,9 +2595,9 @@ extern void deactivate_task(struct rq *rq, struct task_struct *p, int flags);
 extern void wakeup_preempt(struct rq *rq, struct task_struct *p, int flags);
 
 #ifdef CONFIG_PREEMPT_RT
-#define SCHED_NR_MIGRATE_BREAK 8
+# define SCHED_NR_MIGRATE_BREAK 8
 #else
-#define SCHED_NR_MIGRATE_BREAK 32
+# define SCHED_NR_MIGRATE_BREAK 32
 #endif
 
 extern const_debug unsigned int sysctl_sched_nr_migrate;
@@ -2619,9 +2646,9 @@ static inline int hrtick_enabled_dl(struct rq *rq)
 	return hrtick_enabled(rq);
 }
 
-void hrtick_start(struct rq *rq, u64 delay);
+extern void hrtick_start(struct rq *rq, u64 delay);
 
-#else
+#else /* !CONFIG_SCHED_HRTICK: */
 
 static inline int hrtick_enabled_fair(struct rq *rq)
 {
@@ -2638,13 +2665,10 @@ static inline int hrtick_enabled(struct rq *rq)
 	return 0;
 }
 
-#endif /* CONFIG_SCHED_HRTICK */
+#endif /* !CONFIG_SCHED_HRTICK */
 
 #ifndef arch_scale_freq_tick
-static __always_inline
-void arch_scale_freq_tick(void)
-{
-}
+static __always_inline void arch_scale_freq_tick(void) { }
 #endif
 
 #ifndef arch_scale_freq_capacity
@@ -2681,13 +2705,13 @@ static inline void double_rq_clock_clear_update(struct rq *rq1, struct rq *rq2)
 #endif
 }
 #else
-static inline void double_rq_clock_clear_update(struct rq *rq1, struct rq *rq2) {}
+static inline void double_rq_clock_clear_update(struct rq *rq1, struct rq *rq2) { }
 #endif
 
-#define DEFINE_LOCK_GUARD_2(name, type, _lock, _unlock, ...)		\
-__DEFINE_UNLOCK_GUARD(name, type, _unlock, type *lock2; __VA_ARGS__) \
-static inline class_##name##_t class_##name##_constructor(type *lock, type *lock2) \
-{ class_##name##_t _t = { .lock = lock, .lock2 = lock2 }, *_T = &_t;	\
+#define DEFINE_LOCK_GUARD_2(name, type, _lock, _unlock, ...)				\
+__DEFINE_UNLOCK_GUARD(name, type, _unlock, type *lock2; __VA_ARGS__)			\
+static inline class_##name##_t class_##name##_constructor(type *lock, type *lock2)	\
+{ class_##name##_t _t = { .lock = lock, .lock2 = lock2 }, *_T = &_t;			\
   _lock; return _t; }
 
 #ifdef CONFIG_SMP
@@ -2741,7 +2765,7 @@ static inline int _double_lock_balance(struct rq *this_rq, struct rq *busiest)
 	return 1;
 }
 
-#else
+#else /* !CONFIG_PREEMPTION: */
 /*
  * Unfair double_lock_balance: Optimizes throughput at the expense of
  * latency by eliminating extra atomic operations when the locks are
@@ -2772,7 +2796,7 @@ static inline int _double_lock_balance(struct rq *this_rq, struct rq *busiest)
 	return 1;
 }
 
-#endif /* CONFIG_PREEMPTION */
+#endif /* !CONFIG_PREEMPTION */
 
 /*
  * double_lock_balance - lock the busiest runqueue, this_rq is locked already.
@@ -2848,9 +2872,10 @@ static inline void double_rq_unlock(struct rq *rq1, struct rq *rq2)
 
 extern void set_rq_online (struct rq *rq);
 extern void set_rq_offline(struct rq *rq);
+
 extern bool sched_smp_initialized;
 
-#else /* CONFIG_SMP */
+#else /* !CONFIG_SMP: */
 
 /*
  * double_rq_lock - safely lock two runqueues
@@ -2884,7 +2909,7 @@ static inline void double_rq_unlock(struct rq *rq1, struct rq *rq2)
 	__release(rq2->lock);
 }
 
-#endif
+#endif /* !CONFIG_SMP */
 
 DEFINE_LOCK_GUARD_2(double_rq_lock, struct rq,
 		    double_rq_lock(_T->lock, _T->lock2),
@@ -2905,16 +2930,15 @@ extern void print_rt_rq(struct seq_file *m, int cpu, struct rt_rq *rt_rq);
 extern void print_dl_rq(struct seq_file *m, int cpu, struct dl_rq *dl_rq);
 
 extern void resched_latency_warn(int cpu, u64 latency);
-#ifdef CONFIG_NUMA_BALANCING
-extern void
-show_numa_stats(struct task_struct *p, struct seq_file *m);
+# ifdef CONFIG_NUMA_BALANCING
+extern void show_numa_stats(struct task_struct *p, struct seq_file *m);
 extern void
 print_numa_stats(struct seq_file *m, int node, unsigned long tsf,
-	unsigned long tpf, unsigned long gsf, unsigned long gpf);
-#endif /* CONFIG_NUMA_BALANCING */
-#else
-static inline void resched_latency_warn(int cpu, u64 latency) {}
-#endif /* CONFIG_SCHED_DEBUG */
+		 unsigned long tpf, unsigned long gsf, unsigned long gpf);
+# endif /* CONFIG_NUMA_BALANCING */
+#else /* !CONFIG_SCHED_DEBUG: */
+static inline void resched_latency_warn(int cpu, u64 latency) { }
+#endif /* !CONFIG_SCHED_DEBUG */
 
 extern void init_cfs_rq(struct cfs_rq *cfs_rq);
 extern void init_rt_rq(struct rt_rq *rt_rq);
@@ -2924,6 +2948,7 @@ extern void cfs_bandwidth_usage_inc(void);
 extern void cfs_bandwidth_usage_dec(void);
 
 #ifdef CONFIG_NO_HZ_COMMON
+
 #define NOHZ_BALANCE_KICK_BIT	0
 #define NOHZ_STATS_KICK_BIT	1
 #define NOHZ_NEWILB_KICK_BIT	2
@@ -2938,14 +2963,14 @@ extern void cfs_bandwidth_usage_dec(void);
 /* Update nohz.next_balance */
 #define NOHZ_NEXT_KICK		BIT(NOHZ_NEXT_KICK_BIT)
 
-#define NOHZ_KICK_MASK	(NOHZ_BALANCE_KICK | NOHZ_STATS_KICK | NOHZ_NEXT_KICK)
+#define NOHZ_KICK_MASK		(NOHZ_BALANCE_KICK | NOHZ_STATS_KICK | NOHZ_NEXT_KICK)
 
-#define nohz_flags(cpu)	(&cpu_rq(cpu)->nohz_flags)
+#define nohz_flags(cpu)		(&cpu_rq(cpu)->nohz_flags)
 
 extern void nohz_balance_exit_idle(struct rq *rq);
-#else
+#else /* !CONFIG_NO_HZ_COMMON: */
 static inline void nohz_balance_exit_idle(struct rq *rq) { }
-#endif
+#endif /* !CONFIG_NO_HZ_COMMON */
 
 #if defined(CONFIG_SMP) && defined(CONFIG_NO_HZ_COMMON)
 extern void nohz_run_idle_balance(int cpu);
@@ -2954,6 +2979,7 @@ static inline void nohz_run_idle_balance(int cpu) { }
 #endif
 
 #ifdef CONFIG_IRQ_TIME_ACCOUNTING
+
 struct irqtime {
 	u64			total;
 	u64			tick_delta;
@@ -2981,9 +3007,11 @@ static inline u64 irq_time_read(int cpu)
 
 	return total;
 }
+
 #endif /* CONFIG_IRQ_TIME_ACCOUNTING */
 
 #ifdef CONFIG_CPU_FREQ
+
 DECLARE_PER_CPU(struct update_util_data __rcu *, cpufreq_update_util_data);
 
 /**
@@ -3017,9 +3045,9 @@ static inline void cpufreq_update_util(struct rq *rq, unsigned int flags)
 	if (data)
 		data->func(data, rq_clock(rq), flags);
 }
-#else
-static inline void cpufreq_update_util(struct rq *rq, unsigned int flags) {}
-#endif /* CONFIG_CPU_FREQ */
+#else /* !CONFIG_CPU_FREQ: */
+static inline void cpufreq_update_util(struct rq *rq, unsigned int flags) { }
+#endif /* !CONFIG_CPU_FREQ */
 
 #ifdef arch_scale_freq_capacity
 # ifndef arch_scale_freq_invariant
@@ -3030,6 +3058,7 @@ static inline void cpufreq_update_util(struct rq *rq, unsigned int flags) {}
 #endif
 
 #ifdef CONFIG_SMP
+
 unsigned long effective_cpu_util(int cpu, unsigned long util_cfs,
 				 unsigned long *min,
 				 unsigned long *max);
@@ -3072,9 +3101,11 @@ static inline unsigned long cpu_util_rt(struct rq *rq)
 {
 	return READ_ONCE(rq->avg_rt.util_avg);
 }
-#endif
+
+#endif /* CONFIG_SMP */
 
 #ifdef CONFIG_UCLAMP_TASK
+
 unsigned long uclamp_eff_value(struct task_struct *p, enum uclamp_id clamp_id);
 
 static inline unsigned long uclamp_rq_get(struct rq *rq,
@@ -3143,17 +3174,18 @@ static inline unsigned int uclamp_bucket_id(unsigned int clamp_value)
 	return min_t(unsigned int, clamp_value / UCLAMP_BUCKET_DELTA, UCLAMP_BUCKETS - 1);
 }
 
-static inline void uclamp_se_set(struct uclamp_se *uc_se,
-				 unsigned int value, bool user_defined)
+static inline void
+uclamp_se_set(struct uclamp_se *uc_se, unsigned int value, bool user_defined)
 {
 	uc_se->value = value;
 	uc_se->bucket_id = uclamp_bucket_id(value);
 	uc_se->user_defined = user_defined;
 }
 
-#else /* CONFIG_UCLAMP_TASK */
-static inline unsigned long uclamp_eff_value(struct task_struct *p,
-					     enum uclamp_id clamp_id)
+#else /* !CONFIG_UCLAMP_TASK: */
+
+static inline unsigned long
+uclamp_eff_value(struct task_struct *p, enum uclamp_id clamp_id)
 {
 	if (clamp_id == UCLAMP_MIN)
 		return 0;
@@ -3168,8 +3200,8 @@ static inline bool uclamp_is_used(void)
 	return false;
 }
 
-static inline unsigned long uclamp_rq_get(struct rq *rq,
-					  enum uclamp_id clamp_id)
+static inline unsigned long
+uclamp_rq_get(struct rq *rq, enum uclamp_id clamp_id)
 {
 	if (clamp_id == UCLAMP_MIN)
 		return 0;
@@ -3177,8 +3209,8 @@ static inline unsigned long uclamp_rq_get(struct rq *rq,
 	return SCHED_CAPACITY_SCALE;
 }
 
-static inline void uclamp_rq_set(struct rq *rq, enum uclamp_id clamp_id,
-				 unsigned int value)
+static inline void
+uclamp_rq_set(struct rq *rq, enum uclamp_id clamp_id, unsigned int value)
 {
 }
 
@@ -3187,9 +3219,10 @@ static inline bool uclamp_rq_is_idle(struct rq *rq)
 	return false;
 }
 
-#endif /* CONFIG_UCLAMP_TASK */
+#endif /* !CONFIG_UCLAMP_TASK */
 
 #ifdef CONFIG_HAVE_SCHED_AVG_IRQ
+
 static inline unsigned long cpu_util_irq(struct rq *rq)
 {
 	return READ_ONCE(rq->avg_irq.util_avg);
@@ -3204,7 +3237,9 @@ unsigned long scale_irq_capacity(unsigned long util, unsigned long irq, unsigned
 	return util;
 
 }
-#else
+
+#else /* !CONFIG_HAVE_SCHED_AVG_IRQ: */
+
 static inline unsigned long cpu_util_irq(struct rq *rq)
 {
 	return 0;
@@ -3215,7 +3250,8 @@ unsigned long scale_irq_capacity(unsigned long util, unsigned long irq, unsigned
 {
 	return util;
 }
-#endif
+
+#endif /* !CONFIG_HAVE_SCHED_AVG_IRQ */
 
 #if defined(CONFIG_ENERGY_MODEL) && defined(CONFIG_CPU_FREQ_GOV_SCHEDUTIL)
 
@@ -3233,11 +3269,13 @@ extern struct cpufreq_governor schedutil_gov;
 #else /* ! (CONFIG_ENERGY_MODEL && CONFIG_CPU_FREQ_GOV_SCHEDUTIL) */
 
 #define perf_domain_span(pd) NULL
+
 static inline bool sched_energy_enabled(void) { return false; }
 
 #endif /* CONFIG_ENERGY_MODEL && CONFIG_CPU_FREQ_GOV_SCHEDUTIL */
 
 #ifdef CONFIG_MEMBARRIER
+
 /*
  * The scheduler provides memory barriers required by membarrier between:
  * - prior user-space memory accesses and store to rq->membarrier_state,
@@ -3259,13 +3297,16 @@ static inline void membarrier_switch_mm(struct rq *rq,
 
 	WRITE_ONCE(rq->membarrier_state, membarrier_state);
 }
-#else
+
+#else /* !CONFIG_MEMBARRIER :*/
+
 static inline void membarrier_switch_mm(struct rq *rq,
 					struct mm_struct *prev_mm,
 					struct mm_struct *next_mm)
 {
 }
-#endif
+
+#endif /* !CONFIG_MEMBARRIER */
 
 #ifdef CONFIG_SMP
 static inline bool is_per_cpu_kthread(struct task_struct *p)
@@ -3384,6 +3425,7 @@ static inline int __mm_cid_try_get(struct mm_struct *mm)
 	}
 	if (cpumask_test_and_set_cpu(cid, cpumask))
 		return -1;
+
 	return cid;
 }
 
@@ -3448,6 +3490,7 @@ unlock:
 	raw_spin_unlock(&cid_lock);
 end:
 	mm_cid_snapshot_time(rq, mm);
+
 	return cid;
 }
 
@@ -3470,6 +3513,7 @@ static inline int mm_cid_get(struct rq *rq, struct mm_struct *mm)
 	}
 	cid = __mm_cid_get(rq, mm);
 	__this_cpu_write(pcpu_cid->cid, cid);
+
 	return cid;
 }
 
@@ -3524,18 +3568,19 @@ static inline void switch_mm_cid(struct rq *rq,
 		next->last_mm_cid = next->mm_cid = mm_cid_get(rq, next->mm);
 }
 
-#else
+#else /* !CONFIG_SCHED_MM_CID: */
 static inline void switch_mm_cid(struct rq *rq, struct task_struct *prev, struct task_struct *next) { }
 static inline void sched_mm_cid_migrate_from(struct task_struct *t) { }
 static inline void sched_mm_cid_migrate_to(struct rq *dst_rq, struct task_struct *t) { }
 static inline void task_tick_mm_cid(struct rq *rq, struct task_struct *curr) { }
 static inline void init_sched_mm_cid(struct task_struct *t) { }
-#endif
+#endif /* !CONFIG_SCHED_MM_CID */
 
 extern u64 avg_vruntime(struct cfs_rq *cfs_rq);
 extern int entity_eligible(struct cfs_rq *cfs_rq, struct sched_entity *se);
 
 #ifdef CONFIG_RT_MUTEXES
+
 static inline int __rt_effective_prio(struct task_struct *pi_task, int prio)
 {
 	if (pi_task)
@@ -3550,12 +3595,15 @@ static inline int rt_effective_prio(struct task_struct *p, int prio)
 
 	return __rt_effective_prio(pi_task, prio);
 }
-#else
+
+#else /* !CONFIG_RT_MUTEXES: */
+
 static inline int rt_effective_prio(struct task_struct *p, int prio)
 {
 	return prio;
 }
-#endif
+
+#endif /* !CONFIG_RT_MUTEXES */
 
 extern int __sched_setscheduler(struct task_struct *p, const struct sched_attr *attr, bool user, bool pi);
 extern int __sched_setaffinity(struct task_struct *p, struct affinity_context *ctx);

