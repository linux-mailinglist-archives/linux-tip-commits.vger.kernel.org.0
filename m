Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3941637BA58
	for <lists+linux-tip-commits@lfdr.de>; Wed, 12 May 2021 12:28:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230096AbhELK3d (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 12 May 2021 06:29:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230217AbhELK3c (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 12 May 2021 06:29:32 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A58CC061574;
        Wed, 12 May 2021 03:28:24 -0700 (PDT)
Date:   Wed, 12 May 2021 10:28:22 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1620815302;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jb8qboO6SgQ6YNRKd5eZVOysg7mnGg6A2PAsKc8o6Pw=;
        b=MwDdQ+u1UgbPd+qcu6dnnlqDUCNg3e7svq1qMMvXMnqFAUvKz/DGkfDyRLEtgRPGuNguAd
        dgrNC92MueETMNKOIVIeNdrH+lT3d5dEDEP9lmA6XhBaN4F4HU9z0WlyPq3lttJhoWltnq
        jB9/jFAUCNT6tMMt2DTTwKzEpnfX7pejO2QVGkPNjeLFvmg3aMHIeG9Vmzxunq//kxtmbk
        vlruN4TpAOkJLECTP2a38g8wibJtTCWMVW+SJFdIBBjxa5ZP+t8DIm82ErqAATUKJFBomj
        WGkVAZD3tv/yyfvyZh08t3sVFxoXPTvsYmS2HfIkmNy3+936X8H+dp63X8xxSQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1620815302;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jb8qboO6SgQ6YNRKd5eZVOysg7mnGg6A2PAsKc8o6Pw=;
        b=LMXmZ7QS6ddF84Q+bJHurVYzbvYwm1rBsnKO2C5yONWhhstqF64EvJVNDD2ldxeeZAgIw5
        qR4b9/wa9WOKYuBw==
From:   "tip-bot2 for Aubrey Li" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched: Migration changes for core scheduling
Cc:     Aubrey Li <aubrey.li@linux.intel.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Don Hiatt <dhiatt@digitalocean.com>,
        Hongyu Ning <hongyu.ning@linux.intel.com>,
        Vincent Guittot <vincent.guittot@linaro.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210422123308.860083871@infradead.org>
References: <20210422123308.860083871@infradead.org>
MIME-Version: 1.0
Message-ID: <162081530211.29796.10655018659981537851.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     97886d9dcd86820bdbc1fa73b455982809cbc8c2
Gitweb:        https://git.kernel.org/tip/97886d9dcd86820bdbc1fa73b455982809cbc8c2
Author:        Aubrey Li <aubrey.li@linux.intel.com>
AuthorDate:    Wed, 24 Mar 2021 17:40:13 -04:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 12 May 2021 11:43:30 +02:00

sched: Migration changes for core scheduling

 - Don't migrate if there is a cookie mismatch
     Load balance tries to move task from busiest CPU to the
     destination CPU. When core scheduling is enabled, if the
     task's cookie does not match with the destination CPU's
     core cookie, this task may be skipped by this CPU. This
     mitigates the forced idle time on the destination CPU.

 - Select cookie matched idle CPU
     In the fast path of task wakeup, select the first cookie matched
     idle CPU instead of the first idle CPU.

 - Find cookie matched idlest CPU
     In the slow path of task wakeup, find the idlest CPU whose core
     cookie matches with task's cookie

Signed-off-by: Aubrey Li <aubrey.li@linux.intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Tested-by: Don Hiatt <dhiatt@digitalocean.com>
Tested-by: Hongyu Ning <hongyu.ning@linux.intel.com>
Tested-by: Vincent Guittot <vincent.guittot@linaro.org>
Link: https://lkml.kernel.org/r/20210422123308.860083871@infradead.org
---
 kernel/sched/fair.c  | 29 +++++++++++++----
 kernel/sched/sched.h | 73 +++++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 96 insertions(+), 6 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 5948dc1..2635e10 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -5889,11 +5889,15 @@ find_idlest_group_cpu(struct sched_group *group, struct task_struct *p, int this
 
 	/* Traverse only the allowed CPUs */
 	for_each_cpu_and(i, sched_group_span(group), p->cpus_ptr) {
+		struct rq *rq = cpu_rq(i);
+
+		if (!sched_core_cookie_match(rq, p))
+			continue;
+
 		if (sched_idle_cpu(i))
 			return i;
 
 		if (available_idle_cpu(i)) {
-			struct rq *rq = cpu_rq(i);
 			struct cpuidle_state *idle = idle_get_state(rq);
 			if (idle && idle->exit_latency < min_exit_latency) {
 				/*
@@ -5979,9 +5983,10 @@ static inline int find_idlest_cpu(struct sched_domain *sd, struct task_struct *p
 	return new_cpu;
 }
 
-static inline int __select_idle_cpu(int cpu)
+static inline int __select_idle_cpu(int cpu, struct task_struct *p)
 {
-	if (available_idle_cpu(cpu) || sched_idle_cpu(cpu))
+	if ((available_idle_cpu(cpu) || sched_idle_cpu(cpu)) &&
+	    sched_cpu_cookie_match(cpu_rq(cpu), p))
 		return cpu;
 
 	return -1;
@@ -6051,7 +6056,7 @@ static int select_idle_core(struct task_struct *p, int core, struct cpumask *cpu
 	int cpu;
 
 	if (!static_branch_likely(&sched_smt_present))
-		return __select_idle_cpu(core);
+		return __select_idle_cpu(core, p);
 
 	for_each_cpu(cpu, cpu_smt_mask(core)) {
 		if (!available_idle_cpu(cpu)) {
@@ -6107,7 +6112,7 @@ static inline bool test_idle_cores(int cpu, bool def)
 
 static inline int select_idle_core(struct task_struct *p, int core, struct cpumask *cpus, int *idle_cpu)
 {
-	return __select_idle_cpu(core);
+	return __select_idle_cpu(core, p);
 }
 
 static inline int select_idle_smt(struct task_struct *p, struct sched_domain *sd, int target)
@@ -6164,7 +6169,7 @@ static int select_idle_cpu(struct task_struct *p, struct sched_domain *sd, bool 
 		} else {
 			if (!--nr)
 				return -1;
-			idle_cpu = __select_idle_cpu(cpu);
+			idle_cpu = __select_idle_cpu(cpu, p);
 			if ((unsigned int)idle_cpu < nr_cpumask_bits)
 				break;
 		}
@@ -7527,6 +7532,14 @@ static int task_hot(struct task_struct *p, struct lb_env *env)
 
 	if (sysctl_sched_migration_cost == -1)
 		return 1;
+
+	/*
+	 * Don't migrate task if the task's cookie does not match
+	 * with the destination CPU's core cookie.
+	 */
+	if (!sched_core_cookie_match(cpu_rq(env->dst_cpu), p))
+		return 1;
+
 	if (sysctl_sched_migration_cost == 0)
 		return 0;
 
@@ -8857,6 +8870,10 @@ find_idlest_group(struct sched_domain *sd, struct task_struct *p, int this_cpu)
 					p->cpus_ptr))
 			continue;
 
+		/* Skip over this group if no cookie matched */
+		if (!sched_group_cookie_match(cpu_rq(this_cpu), p, group))
+			continue;
+
 		local_group = cpumask_test_cpu(this_cpu,
 					       sched_group_span(group));
 
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 91ca1fe..3878386 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -1134,7 +1134,9 @@ static inline bool is_migration_disabled(struct task_struct *p)
 #endif
 }
 
+struct sched_group;
 #ifdef CONFIG_SCHED_CORE
+static inline struct cpumask *sched_group_span(struct sched_group *sg);
 
 DECLARE_STATIC_KEY_FALSE(__sched_core_enabled);
 
@@ -1170,6 +1172,61 @@ static inline raw_spinlock_t *__rq_lockp(struct rq *rq)
 
 bool cfs_prio_less(struct task_struct *a, struct task_struct *b, bool fi);
 
+/*
+ * Helpers to check if the CPU's core cookie matches with the task's cookie
+ * when core scheduling is enabled.
+ * A special case is that the task's cookie always matches with CPU's core
+ * cookie if the CPU is in an idle core.
+ */
+static inline bool sched_cpu_cookie_match(struct rq *rq, struct task_struct *p)
+{
+	/* Ignore cookie match if core scheduler is not enabled on the CPU. */
+	if (!sched_core_enabled(rq))
+		return true;
+
+	return rq->core->core_cookie == p->core_cookie;
+}
+
+static inline bool sched_core_cookie_match(struct rq *rq, struct task_struct *p)
+{
+	bool idle_core = true;
+	int cpu;
+
+	/* Ignore cookie match if core scheduler is not enabled on the CPU. */
+	if (!sched_core_enabled(rq))
+		return true;
+
+	for_each_cpu(cpu, cpu_smt_mask(cpu_of(rq))) {
+		if (!available_idle_cpu(cpu)) {
+			idle_core = false;
+			break;
+		}
+	}
+
+	/*
+	 * A CPU in an idle core is always the best choice for tasks with
+	 * cookies.
+	 */
+	return idle_core || rq->core->core_cookie == p->core_cookie;
+}
+
+static inline bool sched_group_cookie_match(struct rq *rq,
+					    struct task_struct *p,
+					    struct sched_group *group)
+{
+	int cpu;
+
+	/* Ignore cookie match if core scheduler is not enabled on the CPU. */
+	if (!sched_core_enabled(rq))
+		return true;
+
+	for_each_cpu_and(cpu, sched_group_span(group), p->cpus_ptr) {
+		if (sched_core_cookie_match(rq, p))
+			return true;
+	}
+	return false;
+}
+
 extern void queue_core_balance(struct rq *rq);
 
 #else /* !CONFIG_SCHED_CORE */
@@ -1198,6 +1255,22 @@ static inline void queue_core_balance(struct rq *rq)
 {
 }
 
+static inline bool sched_cpu_cookie_match(struct rq *rq, struct task_struct *p)
+{
+	return true;
+}
+
+static inline bool sched_core_cookie_match(struct rq *rq, struct task_struct *p)
+{
+	return true;
+}
+
+static inline bool sched_group_cookie_match(struct rq *rq,
+					    struct task_struct *p,
+					    struct sched_group *group)
+{
+	return true;
+}
 #endif /* CONFIG_SCHED_CORE */
 
 static inline void lockdep_assert_rq_held(struct rq *rq)
