Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9EF37BD92F
	for <lists+linux-tip-commits@lfdr.de>; Mon,  9 Oct 2023 13:04:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234513AbjJILEt (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Mon, 9 Oct 2023 07:04:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234504AbjJILEs (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Mon, 9 Oct 2023 07:04:48 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2E17A6;
        Mon,  9 Oct 2023 04:04:45 -0700 (PDT)
Date:   Mon, 09 Oct 2023 11:04:43 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1696849484;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DmfNzHKe3WC4wTGy1cgkzoUz5dIwH308LfcwFR5ZNUI=;
        b=jt4BHtYo4ZWnWsYhHeIhGaE6rm3yHbeuvyoPQh9QQSdltZ4xhddd8hY6QJEMyCMSb3o9t6
        VZV/kYKxaH6xjafCtKmWiq4nq/1OQJVX4aMAf3g3+4oJoMptGBUWjNFoTwV6/CGOs/ayae
        k/ulHyI182jVIRynwnx9Q4cimtKYheTuNji/f9qQzDbe0l/Xijnbxn2/SqSyljs1HPsb82
        mpCwR5NYbtII5qRmIUkgOqSabU12k8CegDmooQR8WUIQsCzDnKZ26nqkmh0UrJZUr2/SIU
        bDE9x5mx/GAGorfJ8gIbq0HS1wJNuH/lS8IxxmHBoIEr5b8nQ2D4xnbznJkm/Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1696849484;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DmfNzHKe3WC4wTGy1cgkzoUz5dIwH308LfcwFR5ZNUI=;
        b=rKAlZdlucQUrklvLerQoCg24YCXZfmBKA/ZNe62DSLzjupp2ibEqqy3oirFedaZRHjl06x
        C5TphKqnju8Uk0DA==
From:   "tip-bot2 for Vincent Guittot" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/topology: Consolidate and clean up access to
 a CPU's max compute capacity
Cc:     Vincent Guittot <vincent.guittot@linaro.org>,
        Ingo Molnar <mingo@kernel.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20231009103621.374412-2-vincent.guittot@linaro.org>
References: <20231009103621.374412-2-vincent.guittot@linaro.org>
MIME-Version: 1.0
Message-ID: <169684948368.3135.4051998165953426711.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     7bc263840bc3377186cb06b003ac287bb2f18ce2
Gitweb:        https://git.kernel.org/tip/7bc263840bc3377186cb06b003ac287bb2f18ce2
Author:        Vincent Guittot <vincent.guittot@linaro.org>
AuthorDate:    Mon, 09 Oct 2023 12:36:16 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Mon, 09 Oct 2023 12:59:48 +02:00

sched/topology: Consolidate and clean up access to a CPU's max compute capacity

Remove the rq::cpu_capacity_orig field and use arch_scale_cpu_capacity()
instead.

The scheduler uses 3 methods to get access to a CPU's max compute capacity:

 - arch_scale_cpu_capacity(cpu) which is the default way to get a CPU's capacity.

 - cpu_capacity_orig field which is periodically updated with
   arch_scale_cpu_capacity().

 - capacity_orig_of(cpu) which encapsulates rq->cpu_capacity_orig.

There is no real need to save the value returned by arch_scale_cpu_capacity()
in struct rq. arch_scale_cpu_capacity() returns:

 - either a per_cpu variable.

 - or a const value for systems which have only one capacity.

Remove rq::cpu_capacity_orig and use arch_scale_cpu_capacity() everywhere.

No functional changes.

Some performance tests on Arm64:

  - small SMP device (hikey): no noticeable changes
  - HMP device (RB5):         hackbench shows minor improvement (1-2%)
  - large smp (thx2):         hackbench and tbench shows minor improvement (1%)

Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Reviewed-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
Link: https://lore.kernel.org/r/20231009103621.374412-2-vincent.guittot@linaro.org
---
 Documentation/scheduler/sched-capacity.rst | 13 +++++++------
 kernel/sched/core.c                        |  2 +-
 kernel/sched/cpudeadline.c                 |  2 +-
 kernel/sched/deadline.c                    |  4 ++--
 kernel/sched/fair.c                        | 18 ++++++++----------
 kernel/sched/rt.c                          |  2 +-
 kernel/sched/sched.h                       |  6 ------
 kernel/sched/topology.c                    |  7 +++++--
 8 files changed, 25 insertions(+), 29 deletions(-)

diff --git a/Documentation/scheduler/sched-capacity.rst b/Documentation/scheduler/sched-capacity.rst
index e2c1cf7..de414b3 100644
--- a/Documentation/scheduler/sched-capacity.rst
+++ b/Documentation/scheduler/sched-capacity.rst
@@ -39,14 +39,15 @@ per Hz, leading to::
 -------------------
 
 Two different capacity values are used within the scheduler. A CPU's
-``capacity_orig`` is its maximum attainable capacity, i.e. its maximum
-attainable performance level. A CPU's ``capacity`` is its ``capacity_orig`` to
-which some loss of available performance (e.g. time spent handling IRQs) is
-subtracted.
+``original capacity`` is its maximum attainable capacity, i.e. its maximum
+attainable performance level. This original capacity is returned by
+the function arch_scale_cpu_capacity(). A CPU's ``capacity`` is its ``original
+capacity`` to which some loss of available performance (e.g. time spent
+handling IRQs) is subtracted.
 
 Note that a CPU's ``capacity`` is solely intended to be used by the CFS class,
-while ``capacity_orig`` is class-agnostic. The rest of this document will use
-the term ``capacity`` interchangeably with ``capacity_orig`` for the sake of
+while ``original capacity`` is class-agnostic. The rest of this document will use
+the term ``capacity`` interchangeably with ``original capacity`` for the sake of
 brevity.
 
 1.3 Platform examples
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index cf6d3fd..a3f9cd5 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -9929,7 +9929,7 @@ void __init sched_init(void)
 #ifdef CONFIG_SMP
 		rq->sd = NULL;
 		rq->rd = NULL;
-		rq->cpu_capacity = rq->cpu_capacity_orig = SCHED_CAPACITY_SCALE;
+		rq->cpu_capacity = SCHED_CAPACITY_SCALE;
 		rq->balance_callback = &balance_push_callback;
 		rq->active_balance = 0;
 		rq->next_balance = jiffies;
diff --git a/kernel/sched/cpudeadline.c b/kernel/sched/cpudeadline.c
index 57c92d7..95baa12 100644
--- a/kernel/sched/cpudeadline.c
+++ b/kernel/sched/cpudeadline.c
@@ -131,7 +131,7 @@ int cpudl_find(struct cpudl *cp, struct task_struct *p,
 			if (!dl_task_fits_capacity(p, cpu)) {
 				cpumask_clear_cpu(cpu, later_mask);
 
-				cap = capacity_orig_of(cpu);
+				cap = arch_scale_cpu_capacity(cpu);
 
 				if (cap > max_cap ||
 				    (cpu == task_cpu(p) && cap == max_cap)) {
diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index d98408a..7039a8d 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -132,7 +132,7 @@ static inline unsigned long __dl_bw_capacity(const struct cpumask *mask)
 	int i;
 
 	for_each_cpu_and(i, mask, cpu_active_mask)
-		cap += capacity_orig_of(i);
+		cap += arch_scale_cpu_capacity(i);
 
 	return cap;
 }
@@ -144,7 +144,7 @@ static inline unsigned long __dl_bw_capacity(const struct cpumask *mask)
 static inline unsigned long dl_bw_capacity(int i)
 {
 	if (!sched_asym_cpucap_active() &&
-	    capacity_orig_of(i) == SCHED_CAPACITY_SCALE) {
+	    arch_scale_cpu_capacity(i) == SCHED_CAPACITY_SCALE) {
 		return dl_bw_cpus(i) << SCHED_CAPACITY_SHIFT;
 	} else {
 		RCU_LOCKDEP_WARN(!rcu_read_lock_sched_held(),
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 19bb4ac..e7c1baf 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -4669,7 +4669,7 @@ static inline void util_est_update(struct cfs_rq *cfs_rq,
 	 * To avoid overestimation of actual task utilization, skip updates if
 	 * we cannot grant there is idle time in this CPU.
 	 */
-	if (task_util(p) > capacity_orig_of(cpu_of(rq_of(cfs_rq))))
+	if (task_util(p) > arch_scale_cpu_capacity(cpu_of(rq_of(cfs_rq))))
 		return;
 
 	/*
@@ -4717,14 +4717,14 @@ static inline int util_fits_cpu(unsigned long util,
 		return fits;
 
 	/*
-	 * We must use capacity_orig_of() for comparing against uclamp_min and
+	 * We must use arch_scale_cpu_capacity() for comparing against uclamp_min and
 	 * uclamp_max. We only care about capacity pressure (by using
 	 * capacity_of()) for comparing against the real util.
 	 *
 	 * If a task is boosted to 1024 for example, we don't want a tiny
 	 * pressure to skew the check whether it fits a CPU or not.
 	 *
-	 * Similarly if a task is capped to capacity_orig_of(little_cpu), it
+	 * Similarly if a task is capped to arch_scale_cpu_capacity(little_cpu), it
 	 * should fit a little cpu even if there's some pressure.
 	 *
 	 * Only exception is for thermal pressure since it has a direct impact
@@ -4736,7 +4736,7 @@ static inline int util_fits_cpu(unsigned long util,
 	 * For uclamp_max, we can tolerate a drop in performance level as the
 	 * goal is to cap the task. So it's okay if it's getting less.
 	 */
-	capacity_orig = capacity_orig_of(cpu);
+	capacity_orig = arch_scale_cpu_capacity(cpu);
 	capacity_orig_thermal = capacity_orig - arch_scale_thermal_pressure(cpu);
 
 	/*
@@ -7217,7 +7217,7 @@ select_idle_capacity(struct task_struct *p, struct sched_domain *sd, int target)
 		 * Look for the CPU with best capacity.
 		 */
 		else if (fits < 0)
-			cpu_cap = capacity_orig_of(cpu) - thermal_load_avg(cpu_rq(cpu));
+			cpu_cap = arch_scale_cpu_capacity(cpu) - thermal_load_avg(cpu_rq(cpu));
 
 		/*
 		 * First, select CPU which fits better (-1 being better than 0).
@@ -7459,7 +7459,7 @@ cpu_util(int cpu, struct task_struct *p, int dst_cpu, int boost)
 		util = max(util, util_est);
 	}
 
-	return min(util, capacity_orig_of(cpu));
+	return min(util, arch_scale_cpu_capacity(cpu));
 }
 
 unsigned long cpu_util_cfs(int cpu)
@@ -9250,8 +9250,6 @@ static void update_cpu_capacity(struct sched_domain *sd, int cpu)
 	unsigned long capacity = scale_rt_capacity(cpu);
 	struct sched_group *sdg = sd->groups;
 
-	cpu_rq(cpu)->cpu_capacity_orig = arch_scale_cpu_capacity(cpu);
-
 	if (!capacity)
 		capacity = 1;
 
@@ -9327,7 +9325,7 @@ static inline int
 check_cpu_capacity(struct rq *rq, struct sched_domain *sd)
 {
 	return ((rq->cpu_capacity * sd->imbalance_pct) <
-				(rq->cpu_capacity_orig * 100));
+				(arch_scale_cpu_capacity(cpu_of(rq)) * 100));
 }
 
 /*
@@ -9338,7 +9336,7 @@ check_cpu_capacity(struct rq *rq, struct sched_domain *sd)
 static inline int check_misfit_status(struct rq *rq, struct sched_domain *sd)
 {
 	return rq->misfit_task_load &&
-		(rq->cpu_capacity_orig < rq->rd->max_cpu_capacity ||
+		(arch_scale_cpu_capacity(rq->cpu) < rq->rd->max_cpu_capacity ||
 		 check_cpu_capacity(rq, sd));
 }
 
diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
index 76d82a0..e93b69e 100644
--- a/kernel/sched/rt.c
+++ b/kernel/sched/rt.c
@@ -471,7 +471,7 @@ static inline bool rt_task_fits_capacity(struct task_struct *p, int cpu)
 	min_cap = uclamp_eff_value(p, UCLAMP_MIN);
 	max_cap = uclamp_eff_value(p, UCLAMP_MAX);
 
-	cpu_cap = capacity_orig_of(cpu);
+	cpu_cap = arch_scale_cpu_capacity(cpu);
 
 	return cpu_cap >= min(min_cap, max_cap);
 }
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 515eb4c..7e7fedc 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -1033,7 +1033,6 @@ struct rq {
 	struct sched_domain __rcu	*sd;
 
 	unsigned long		cpu_capacity;
-	unsigned long		cpu_capacity_orig;
 
 	struct balance_callback *balance_callback;
 
@@ -2967,11 +2966,6 @@ static inline void cpufreq_update_util(struct rq *rq, unsigned int flags) {}
 #endif
 
 #ifdef CONFIG_SMP
-static inline unsigned long capacity_orig_of(int cpu)
-{
-	return cpu_rq(cpu)->cpu_capacity_orig;
-}
-
 /**
  * enum cpu_util_type - CPU utilization type
  * @FREQUENCY_UTIL:	Utilization used to select frequency
diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
index a7b50bb..1cc5959 100644
--- a/kernel/sched/topology.c
+++ b/kernel/sched/topology.c
@@ -2488,12 +2488,15 @@ build_sched_domains(const struct cpumask *cpu_map, struct sched_domain_attr *att
 	/* Attach the domains */
 	rcu_read_lock();
 	for_each_cpu(i, cpu_map) {
+		unsigned long capacity;
+
 		rq = cpu_rq(i);
 		sd = *per_cpu_ptr(d.sd, i);
 
+		capacity = arch_scale_cpu_capacity(i);
 		/* Use READ_ONCE()/WRITE_ONCE() to avoid load/store tearing: */
-		if (rq->cpu_capacity_orig > READ_ONCE(d.rd->max_cpu_capacity))
-			WRITE_ONCE(d.rd->max_cpu_capacity, rq->cpu_capacity_orig);
+		if (capacity > READ_ONCE(d.rd->max_cpu_capacity))
+			WRITE_ONCE(d.rd->max_cpu_capacity, capacity);
 
 		cpu_attach_domain(sd, d.rd, i);
 	}
