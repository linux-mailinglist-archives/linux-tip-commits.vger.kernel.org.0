Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 28F3F35A2C1
	for <lists+linux-tip-commits@lfdr.de>; Fri,  9 Apr 2021 18:14:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233577AbhDIQOs (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 9 Apr 2021 12:14:48 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:51616 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232642AbhDIQOq (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 9 Apr 2021 12:14:46 -0400
Date:   Fri, 09 Apr 2021 16:14:32 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1617984872;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7hpCSZzOobafpSrSatk3g1IP76KIISPLcnKKUD58Kko=;
        b=wyynWcf05jj/XpSDv3DIKt/l0ndFj+CYlMhRY0EiU3P6Uxg7wC9vtIzHKh25CjxeW4Oee+
        JabfNFVq2bKuURAnfZG1OaPm2dT0gx4fqp6IePxoD4iDF9QMxSqKVl0lzde9INtVAyLs/Q
        MtuOYI9qkjrdidBUJPd29BszeI2vKu3J83i7g0v5z6RMgfEFNlI2TX54KULAFmrSw6rTNr
        0e+iT4j1CrG79NG5MrkbRZ7SnGvbzHIsyfxXdmJFP9GcJUbaNnWJdPxJDRPrfVemMIeA68
        Q/cXnbOSkK5I9QELhwNr/9cgsu5qeR30U8FA9lCJYwh9aa3UBYHB1sGBuy2A5Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1617984872;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7hpCSZzOobafpSrSatk3g1IP76KIISPLcnKKUD58Kko=;
        b=BDbmlvhrq5QIOHIngGGMcn3ZQ+K6rAH2/LOBMvj6l2R/A1jAw4R81z/nEGrtNG34zF1XHt
        vJsZsgp/o/+TrDCQ==
From:   "tip-bot2 for Rik van Riel" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/fair: Bring back select_idle_smt(), but differently
Cc:     Rik van Riel <riel@surriel.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Vincent Guittot <vincent.guittot@linaro.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210326151932.2c187840@imladris.surriel.com>
References: <20210326151932.2c187840@imladris.surriel.com>
MIME-Version: 1.0
Message-ID: <161798487221.29796.406298137826542407.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     c722f35b513f807629603bbf24640b1a48be21b5
Gitweb:        https://git.kernel.org/tip/c722f35b513f807629603bbf24640b1a48be21b5
Author:        Rik van Riel <riel@surriel.com>
AuthorDate:    Fri, 26 Mar 2021 15:19:32 -04:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 09 Apr 2021 18:01:39 +02:00

sched/fair: Bring back select_idle_smt(), but differently

Mel Gorman did some nice work in 9fe1f127b913 ("sched/fair: Merge
select_idle_core/cpu()"), resulting in the kernel being more efficient
at finding an idle CPU, and in tasks spending less time waiting to be
run, both according to the schedstats run_delay numbers, and according
to measured application latencies. Yay.

The flip side of this is that we see more task migrations (about 30%
more), higher cache misses, higher memory bandwidth utilization, and
higher CPU use, for the same number of requests/second.

This is most pronounced on a memcache type workload, which saw a
consistent 1-3% increase in total CPU use on the system, due to those
increased task migrations leading to higher L2 cache miss numbers, and
higher memory utilization. The exclusive L3 cache on Skylake does us
no favors there.

On our web serving workload, that effect is usually negligible.

It appears that the increased number of CPU migrations is generally a
good thing, since it leads to lower cpu_delay numbers, reflecting the
fact that tasks get to run faster. However, the reduced locality and
the corresponding increase in L2 cache misses hurts a little.

The patch below appears to fix the regression, while keeping the
benefit of the lower cpu_delay numbers, by reintroducing
select_idle_smt with a twist: when a socket has no idle cores, check
to see if the sibling of "prev" is idle, before searching all the
other CPUs.

This fixes both the occasional 9% regression on the web serving
workload, and the continuous 2% CPU use regression on the memcache
type workload.

With Mel's patches and this patch together, task migrations are still
high, but L2 cache misses, memory bandwidth, and CPU time used are
back down to what they were before. The p95 and p99 response times for
the memcache type application improve by about 10% over what they were
before Mel's patches got merged.

Signed-off-by: Rik van Riel <riel@surriel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Mel Gorman <mgorman@techsingularity.net>
Acked-by: Vincent Guittot <vincent.guittot@linaro.org>
Link: https://lkml.kernel.org/r/20210326151932.2c187840@imladris.surriel.com
---
 kernel/sched/fair.c | 55 ++++++++++++++++++++++++++++++++++----------
 1 file changed, 43 insertions(+), 12 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 6d73bdb..bc34e35 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -6038,11 +6038,9 @@ static inline bool test_idle_cores(int cpu, bool def)
 {
 	struct sched_domain_shared *sds;
 
-	if (static_branch_likely(&sched_smt_present)) {
-		sds = rcu_dereference(per_cpu(sd_llc_shared, cpu));
-		if (sds)
-			return READ_ONCE(sds->has_idle_cores);
-	}
+	sds = rcu_dereference(per_cpu(sd_llc_shared, cpu));
+	if (sds)
+		return READ_ONCE(sds->has_idle_cores);
 
 	return def;
 }
@@ -6112,6 +6110,24 @@ static int select_idle_core(struct task_struct *p, int core, struct cpumask *cpu
 	return -1;
 }
 
+/*
+ * Scan the local SMT mask for idle CPUs.
+ */
+static int select_idle_smt(struct task_struct *p, struct sched_domain *sd, int target)
+{
+	int cpu;
+
+	for_each_cpu(cpu, cpu_smt_mask(target)) {
+		if (!cpumask_test_cpu(cpu, p->cpus_ptr) ||
+		    !cpumask_test_cpu(cpu, sched_domain_span(sd)))
+			continue;
+		if (available_idle_cpu(cpu) || sched_idle_cpu(cpu))
+			return cpu;
+	}
+
+	return -1;
+}
+
 #else /* CONFIG_SCHED_SMT */
 
 static inline void set_idle_cores(int cpu, int val)
@@ -6128,6 +6144,11 @@ static inline int select_idle_core(struct task_struct *p, int core, struct cpuma
 	return __select_idle_cpu(core);
 }
 
+static inline int select_idle_smt(struct task_struct *p, struct sched_domain *sd, int target)
+{
+	return -1;
+}
+
 #endif /* CONFIG_SCHED_SMT */
 
 /*
@@ -6135,11 +6156,10 @@ static inline int select_idle_core(struct task_struct *p, int core, struct cpuma
  * comparing the average scan cost (tracked in sd->avg_scan_cost) against the
  * average idle time for this rq (as found in rq->avg_idle).
  */
-static int select_idle_cpu(struct task_struct *p, struct sched_domain *sd, int target)
+static int select_idle_cpu(struct task_struct *p, struct sched_domain *sd, bool has_idle_core, int target)
 {
 	struct cpumask *cpus = this_cpu_cpumask_var_ptr(select_idle_mask);
 	int i, cpu, idle_cpu = -1, nr = INT_MAX;
-	bool smt = test_idle_cores(target, false);
 	int this = smp_processor_id();
 	struct sched_domain *this_sd;
 	u64 time;
@@ -6150,7 +6170,7 @@ static int select_idle_cpu(struct task_struct *p, struct sched_domain *sd, int t
 
 	cpumask_and(cpus, sched_domain_span(sd), p->cpus_ptr);
 
-	if (sched_feat(SIS_PROP) && !smt) {
+	if (sched_feat(SIS_PROP) && !has_idle_core) {
 		u64 avg_cost, avg_idle, span_avg;
 
 		/*
@@ -6170,7 +6190,7 @@ static int select_idle_cpu(struct task_struct *p, struct sched_domain *sd, int t
 	}
 
 	for_each_cpu_wrap(cpu, cpus, target) {
-		if (smt) {
+		if (has_idle_core) {
 			i = select_idle_core(p, cpu, cpus, &idle_cpu);
 			if ((unsigned int)i < nr_cpumask_bits)
 				return i;
@@ -6184,10 +6204,10 @@ static int select_idle_cpu(struct task_struct *p, struct sched_domain *sd, int t
 		}
 	}
 
-	if (smt)
+	if (has_idle_core)
 		set_idle_cores(this, false);
 
-	if (sched_feat(SIS_PROP) && !smt) {
+	if (sched_feat(SIS_PROP) && !has_idle_core) {
 		time = cpu_clock(this) - time;
 		update_avg(&this_sd->avg_scan_cost, time);
 	}
@@ -6242,6 +6262,7 @@ static inline bool asym_fits_capacity(int task_util, int cpu)
  */
 static int select_idle_sibling(struct task_struct *p, int prev, int target)
 {
+	bool has_idle_core = false;
 	struct sched_domain *sd;
 	unsigned long task_util;
 	int i, recent_used_cpu;
@@ -6321,7 +6342,17 @@ static int select_idle_sibling(struct task_struct *p, int prev, int target)
 	if (!sd)
 		return target;
 
-	i = select_idle_cpu(p, sd, target);
+	if (sched_smt_active()) {
+		has_idle_core = test_idle_cores(target, false);
+
+		if (!has_idle_core && cpus_share_cache(prev, target)) {
+			i = select_idle_smt(p, sd, prev);
+			if ((unsigned int)i < nr_cpumask_bits)
+				return i;
+		}
+	}
+
+	i = select_idle_cpu(p, sd, has_idle_core, target);
 	if ((unsigned)i < nr_cpumask_bits)
 		return i;
 
