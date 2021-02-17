Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C85F31DA3A
	for <lists+linux-tip-commits@lfdr.de>; Wed, 17 Feb 2021 14:20:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232918AbhBQNT5 (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 17 Feb 2021 08:19:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232782AbhBQNTx (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 17 Feb 2021 08:19:53 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51FDCC06121C;
        Wed, 17 Feb 2021 05:17:41 -0800 (PST)
Date:   Wed, 17 Feb 2021 13:17:38 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1613567859;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Enhza+v10Ym2ixtyOL9d52WlnFvQYOluMR1bV/a0k6M=;
        b=TFE0XbLy2gO4Re80psMgSLtdhcSNY4NylqLWVAs4mQXhPPblJC+GJf17hVJjdkvW3lTnfe
        iKtjy9OoMGdAtlHqCONkMN892zZWxKJ6Qb1dzAjaAUAuizl7JUoRjPI63SR+z5OMQvu9A2
        ZWpEqTLTUWSjjlBtdBPXPz76vURYnvIb0IwBRj2/g3WlkEv9RiBSC/S6D3SVJJ9QgpF1cJ
        O0vmTJ00GeC0b/sXV/Ly71f7y63JVzYfDAO+45c1XRJVUjSMugf8yJukPv0WVAmrsqNcop
        ftjGaehJ4EcXqx8nVW5UmZ9W0Ez4wVslJxXLIZshgmXg1SH0RuC1kwn2GqQxbA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1613567859;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Enhza+v10Ym2ixtyOL9d52WlnFvQYOluMR1bV/a0k6M=;
        b=K4SrviUxo9C0N6XIgrGwcuKO3v65lw70G4vWLFaQI1tvTatUAABanMF9/4enBwigB4pxTK
        8mVc9Vjwj9WeixBg==
From:   "tip-bot2 for Mel Gorman" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/fair: Merge select_idle_core/cpu()
Cc:     Mel Gorman <mgorman@techsingularity.net>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210127135203.19633-5-mgorman@techsingularity.net>
References: <20210127135203.19633-5-mgorman@techsingularity.net>
MIME-Version: 1.0
Message-ID: <161356785893.20312.10270833120354178289.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     9fe1f127b913318c631d0041ecf71486e38c2c2d
Gitweb:        https://git.kernel.org/tip/9fe1f127b913318c631d0041ecf71486e38c2c2d
Author:        Mel Gorman <mgorman@techsingularity.net>
AuthorDate:    Wed, 27 Jan 2021 13:52:03 
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Wed, 17 Feb 2021 14:07:25 +01:00

sched/fair: Merge select_idle_core/cpu()

Both select_idle_core() and select_idle_cpu() do a loop over the same
cpumask. Observe that by clearing the already visited CPUs, we can
fold the iteration and iterate a core at a time.

All we need to do is remember any non-idle CPU we encountered while
scanning for an idle core. This way we'll only iterate every CPU once.

Signed-off-by: Mel Gorman <mgorman@techsingularity.net>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Reviewed-by: Vincent Guittot <vincent.guittot@linaro.org>
Link: https://lkml.kernel.org/r/20210127135203.19633-5-mgorman@techsingularity.net
---
 kernel/sched/fair.c |  99 +++++++++++++++++++++++++------------------
 1 file changed, 59 insertions(+), 40 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 6a0fc8a..c73d588 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -6019,6 +6019,14 @@ static inline int find_idlest_cpu(struct sched_domain *sd, struct task_struct *p
 	return new_cpu;
 }
 
+static inline int __select_idle_cpu(int cpu)
+{
+	if (available_idle_cpu(cpu) || sched_idle_cpu(cpu))
+		return cpu;
+
+	return -1;
+}
+
 #ifdef CONFIG_SCHED_SMT
 DEFINE_STATIC_KEY_FALSE(sched_smt_present);
 EXPORT_SYMBOL_GPL(sched_smt_present);
@@ -6077,48 +6085,51 @@ unlock:
  * there are no idle cores left in the system; tracked through
  * sd_llc->shared->has_idle_cores and enabled through update_idle_core() above.
  */
-static int select_idle_core(struct task_struct *p, struct sched_domain *sd, int target)
+static int select_idle_core(struct task_struct *p, int core, struct cpumask *cpus, int *idle_cpu)
 {
-	struct cpumask *cpus = this_cpu_cpumask_var_ptr(select_idle_mask);
-	int core, cpu;
+	bool idle = true;
+	int cpu;
 
 	if (!static_branch_likely(&sched_smt_present))
-		return -1;
-
-	if (!test_idle_cores(target, false))
-		return -1;
-
-	cpumask_and(cpus, sched_domain_span(sd), p->cpus_ptr);
+		return __select_idle_cpu(core);
 
-	for_each_cpu_wrap(core, cpus, target) {
-		bool idle = true;
-
-		for_each_cpu(cpu, cpu_smt_mask(core)) {
-			if (!available_idle_cpu(cpu)) {
-				idle = false;
-				break;
+	for_each_cpu(cpu, cpu_smt_mask(core)) {
+		if (!available_idle_cpu(cpu)) {
+			idle = false;
+			if (*idle_cpu == -1) {
+				if (sched_idle_cpu(cpu) && cpumask_test_cpu(cpu, p->cpus_ptr)) {
+					*idle_cpu = cpu;
+					break;
+				}
+				continue;
 			}
+			break;
 		}
-
-		if (idle)
-			return core;
-
-		cpumask_andnot(cpus, cpus, cpu_smt_mask(core));
+		if (*idle_cpu == -1 && cpumask_test_cpu(cpu, p->cpus_ptr))
+			*idle_cpu = cpu;
 	}
 
-	/*
-	 * Failed to find an idle core; stop looking for one.
-	 */
-	set_idle_cores(target, 0);
+	if (idle)
+		return core;
 
+	cpumask_andnot(cpus, cpus, cpu_smt_mask(core));
 	return -1;
 }
 
 #else /* CONFIG_SCHED_SMT */
 
-static inline int select_idle_core(struct task_struct *p, struct sched_domain *sd, int target)
+static inline void set_idle_cores(int cpu, int val)
 {
-	return -1;
+}
+
+static inline bool test_idle_cores(int cpu, bool def)
+{
+	return def;
+}
+
+static inline int select_idle_core(struct task_struct *p, int core, struct cpumask *cpus, int *idle_cpu)
+{
+	return __select_idle_cpu(core);
 }
 
 #endif /* CONFIG_SCHED_SMT */
@@ -6131,10 +6142,11 @@ static inline int select_idle_core(struct task_struct *p, struct sched_domain *s
 static int select_idle_cpu(struct task_struct *p, struct sched_domain *sd, int target)
 {
 	struct cpumask *cpus = this_cpu_cpumask_var_ptr(select_idle_mask);
+	int i, cpu, idle_cpu = -1, nr = INT_MAX;
+	bool smt = test_idle_cores(target, false);
+	int this = smp_processor_id();
 	struct sched_domain *this_sd;
 	u64 time;
-	int this = smp_processor_id();
-	int cpu, nr = INT_MAX;
 
 	this_sd = rcu_dereference(*this_cpu_ptr(&sd_llc));
 	if (!this_sd)
@@ -6142,7 +6154,7 @@ static int select_idle_cpu(struct task_struct *p, struct sched_domain *sd, int t
 
 	cpumask_and(cpus, sched_domain_span(sd), p->cpus_ptr);
 
-	if (sched_feat(SIS_PROP)) {
+	if (sched_feat(SIS_PROP) && !smt) {
 		u64 avg_cost, avg_idle, span_avg;
 
 		/*
@@ -6162,18 +6174,29 @@ static int select_idle_cpu(struct task_struct *p, struct sched_domain *sd, int t
 	}
 
 	for_each_cpu_wrap(cpu, cpus, target) {
-		if (!--nr)
-			return -1;
-		if (available_idle_cpu(cpu) || sched_idle_cpu(cpu))
-			break;
+		if (smt) {
+			i = select_idle_core(p, cpu, cpus, &idle_cpu);
+			if ((unsigned int)i < nr_cpumask_bits)
+				return i;
+
+		} else {
+			if (!--nr)
+				return -1;
+			idle_cpu = __select_idle_cpu(cpu);
+			if ((unsigned int)idle_cpu < nr_cpumask_bits)
+				break;
+		}
 	}
 
-	if (sched_feat(SIS_PROP)) {
+	if (smt)
+		set_idle_cores(this, false);
+
+	if (sched_feat(SIS_PROP) && !smt) {
 		time = cpu_clock(this) - time;
 		update_avg(&this_sd->avg_scan_cost, time);
 	}
 
-	return cpu;
+	return idle_cpu;
 }
 
 /*
@@ -6302,10 +6325,6 @@ static int select_idle_sibling(struct task_struct *p, int prev, int target)
 	if (!sd)
 		return target;
 
-	i = select_idle_core(p, sd, target);
-	if ((unsigned)i < nr_cpumask_bits)
-		return i;
-
 	i = select_idle_cpu(p, sd, target);
 	if ((unsigned)i < nr_cpumask_bits)
 		return i;
