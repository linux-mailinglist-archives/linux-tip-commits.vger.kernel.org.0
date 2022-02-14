Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E95C4B4D2A
	for <lists+linux-tip-commits@lfdr.de>; Mon, 14 Feb 2022 12:11:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349993AbiBNLC5 (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Mon, 14 Feb 2022 06:02:57 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:36260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349896AbiBNLCk (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Mon, 14 Feb 2022 06:02:40 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4930E6A38C;
        Mon, 14 Feb 2022 02:30:22 -0800 (PST)
Date:   Mon, 14 Feb 2022 10:30:19 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1644834620;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0Oat99tgLVc3VO/TCsRS+s9la///6XyEWq3GDiITFjw=;
        b=S2MQQtad3HukXRBDiZqPiQuDUBCQ+DaBfW9//Rrjafjlk05yUjR5xwt+P6jOml7REa7lFW
        uFa7UCLSAr/xB8hbuqpgdSkh7VoJvivjQ+fvgl5BaZeeS8r/B8WEqvCsSIhSuJTf7thPfV
        LPCqbzEV8gGRiaBKGJUG9GF5K/rmBhuoipyqvB6EseqQVig0FVjVpal47nzX8pnGoO6Zpg
        MPYhN/0nE2LQACc+POLGY3yFOPc3Mw7+bG4/LpFf9yuEPIzLH6gVmaRz1Q9x9d9gY82aG0
        0AdHbkKJemikj0PYHlAmLjExixy/tF27YbGj2MyEsy2jeFD0504neBjKiQ3+cw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1644834620;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0Oat99tgLVc3VO/TCsRS+s9la///6XyEWq3GDiITFjw=;
        b=iNSJPU+m+WCW7Iy8aeESrINChp9xIDmPMa424nh0moRj5daeB1vtWwIVV/YBJNgTPrHik3
        S70z53FHFhwz9TCw==
From:   "tip-bot2 for Mel Gorman" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/fair: Adjust the allowed NUMA imbalance when
 SD_NUMA spans multiple LLCs
Cc:     Mel Gorman <mgorman@techsingularity.net>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        "Gautham R. Shenoy" <gautham.shenoy@amd.com>,
        K Prateek Nayak <kprateek.nayak@amd.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220208094334.16379-3-mgorman@techsingularity.net>
References: <20220208094334.16379-3-mgorman@techsingularity.net>
MIME-Version: 1.0
Message-ID: <164483461936.16921.3057563828132780882.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     e496132ebedd870b67f1f6d2428f9bb9d7ae27fd
Gitweb:        https://git.kernel.org/tip/e496132ebedd870b67f1f6d2428f9bb9d7ae27fd
Author:        Mel Gorman <mgorman@techsingularity.net>
AuthorDate:    Tue, 08 Feb 2022 09:43:34 
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 11 Feb 2022 23:30:08 +01:00

sched/fair: Adjust the allowed NUMA imbalance when SD_NUMA spans multiple LLCs

Commit 7d2b5dd0bcc4 ("sched/numa: Allow a floating imbalance between NUMA
nodes") allowed an imbalance between NUMA nodes such that communicating
tasks would not be pulled apart by the load balancer. This works fine when
there is a 1:1 relationship between LLC and node but can be suboptimal
for multiple LLCs if independent tasks prematurely use CPUs sharing cache.

Zen* has multiple LLCs per node with local memory channels and due to
the allowed imbalance, it's far harder to tune some workloads to run
optimally than it is on hardware that has 1 LLC per node. This patch
allows an imbalance to exist up to the point where LLCs should be balanced
between nodes.

On a Zen3 machine running STREAM parallelised with OMP to have on instance
per LLC the results and without binding, the results are

                            5.17.0-rc0             5.17.0-rc0
                               vanilla       sched-numaimb-v6
MB/sec copy-16    162596.94 (   0.00%)   580559.74 ( 257.05%)
MB/sec scale-16   136901.28 (   0.00%)   374450.52 ( 173.52%)
MB/sec add-16     157300.70 (   0.00%)   564113.76 ( 258.62%)
MB/sec triad-16   151446.88 (   0.00%)   564304.24 ( 272.61%)

STREAM can use directives to force the spread if the OpenMP is new
enough but that doesn't help if an application uses threads and
it's not known in advance how many threads will be created.

Coremark is a CPU and cache intensive benchmark parallelised with
threads. When running with 1 thread per core, the vanilla kernel
allows threads to contend on cache. With the patch;

                               5.17.0-rc0             5.17.0-rc0
                                  vanilla       sched-numaimb-v5
Min       Score-16   368239.36 (   0.00%)   389816.06 (   5.86%)
Hmean     Score-16   388607.33 (   0.00%)   427877.08 *  10.11%*
Max       Score-16   408945.69 (   0.00%)   481022.17 (  17.62%)
Stddev    Score-16    15247.04 (   0.00%)    24966.82 ( -63.75%)
CoeffVar  Score-16        3.92 (   0.00%)        5.82 ( -48.48%)

It can also make a big difference for semi-realistic workloads
like specjbb which can execute arbitrary numbers of threads without
advance knowledge of how they should be placed. Even in cases where
the average performance is neutral, the results are more stable.

                               5.17.0-rc0             5.17.0-rc0
                                  vanilla       sched-numaimb-v6
Hmean     tput-1      71631.55 (   0.00%)    73065.57 (   2.00%)
Hmean     tput-8     582758.78 (   0.00%)   556777.23 (  -4.46%)
Hmean     tput-16   1020372.75 (   0.00%)  1009995.26 (  -1.02%)
Hmean     tput-24   1416430.67 (   0.00%)  1398700.11 (  -1.25%)
Hmean     tput-32   1687702.72 (   0.00%)  1671357.04 (  -0.97%)
Hmean     tput-40   1798094.90 (   0.00%)  2015616.46 *  12.10%*
Hmean     tput-48   1972731.77 (   0.00%)  2333233.72 (  18.27%)
Hmean     tput-56   2386872.38 (   0.00%)  2759483.38 (  15.61%)
Hmean     tput-64   2909475.33 (   0.00%)  2925074.69 (   0.54%)
Hmean     tput-72   2585071.36 (   0.00%)  2962443.97 (  14.60%)
Hmean     tput-80   2994387.24 (   0.00%)  3015980.59 (   0.72%)
Hmean     tput-88   3061408.57 (   0.00%)  3010296.16 (  -1.67%)
Hmean     tput-96   3052394.82 (   0.00%)  2784743.41 (  -8.77%)
Hmean     tput-104  2997814.76 (   0.00%)  2758184.50 (  -7.99%)
Hmean     tput-112  2955353.29 (   0.00%)  2859705.09 (  -3.24%)
Hmean     tput-120  2889770.71 (   0.00%)  2764478.46 (  -4.34%)
Hmean     tput-128  2871713.84 (   0.00%)  2750136.73 (  -4.23%)
Stddev    tput-1       5325.93 (   0.00%)     2002.53 (  62.40%)
Stddev    tput-8       6630.54 (   0.00%)    10905.00 ( -64.47%)
Stddev    tput-16     25608.58 (   0.00%)     6851.16 (  73.25%)
Stddev    tput-24     12117.69 (   0.00%)     4227.79 (  65.11%)
Stddev    tput-32     27577.16 (   0.00%)     8761.05 (  68.23%)
Stddev    tput-40     59505.86 (   0.00%)     2048.49 (  96.56%)
Stddev    tput-48    168330.30 (   0.00%)    93058.08 (  44.72%)
Stddev    tput-56    219540.39 (   0.00%)    30687.02 (  86.02%)
Stddev    tput-64    121750.35 (   0.00%)     9617.36 (  92.10%)
Stddev    tput-72    223387.05 (   0.00%)    34081.13 (  84.74%)
Stddev    tput-80    128198.46 (   0.00%)    22565.19 (  82.40%)
Stddev    tput-88    136665.36 (   0.00%)    27905.97 (  79.58%)
Stddev    tput-96    111925.81 (   0.00%)    99615.79 (  11.00%)
Stddev    tput-104   146455.96 (   0.00%)    28861.98 (  80.29%)
Stddev    tput-112    88740.49 (   0.00%)    58288.23 (  34.32%)
Stddev    tput-120   186384.86 (   0.00%)    45812.03 (  75.42%)
Stddev    tput-128    78761.09 (   0.00%)    57418.48 (  27.10%)

Similarly, for embarassingly parallel problems like NPB-ep, there are
improvements due to better spreading across LLC when the machine is not
fully utilised.

                              vanilla       sched-numaimb-v6
Min       ep.D       31.79 (   0.00%)       26.11 (  17.87%)
Amean     ep.D       31.86 (   0.00%)       26.17 *  17.86%*
Stddev    ep.D        0.07 (   0.00%)        0.05 (  24.41%)
CoeffVar  ep.D        0.22 (   0.00%)        0.20 (   7.97%)
Max       ep.D       31.93 (   0.00%)       26.21 (  17.91%)

Signed-off-by: Mel Gorman <mgorman@techsingularity.net>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Gautham R. Shenoy <gautham.shenoy@amd.com>
Tested-by: K Prateek Nayak <kprateek.nayak@amd.com>
Link: https://lore.kernel.org/r/20220208094334.16379-3-mgorman@techsingularity.net
---
 include/linux/sched/topology.h |  1 +-
 kernel/sched/fair.c            | 22 +++++++-------
 kernel/sched/topology.c        | 53 +++++++++++++++++++++++++++++++++-
 3 files changed, 66 insertions(+), 10 deletions(-)

diff --git a/include/linux/sched/topology.h b/include/linux/sched/topology.h
index 8054641..56cffe4 100644
--- a/include/linux/sched/topology.h
+++ b/include/linux/sched/topology.h
@@ -93,6 +93,7 @@ struct sched_domain {
 	unsigned int busy_factor;	/* less balancing by factor if busy */
 	unsigned int imbalance_pct;	/* No balance until over watermark */
 	unsigned int cache_nice_tries;	/* Leave cache hot tasks for # tries */
+	unsigned int imb_numa_nr;	/* Nr running tasks that allows a NUMA imbalance */
 
 	int nohz_idle;			/* NOHZ IDLE status */
 	int flags;			/* See SD_* */
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index ea71016..5c4bfff 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -1489,6 +1489,7 @@ struct task_numa_env {
 
 	int src_cpu, src_nid;
 	int dst_cpu, dst_nid;
+	int imb_numa_nr;
 
 	struct numa_stats src_stats, dst_stats;
 
@@ -1503,7 +1504,7 @@ struct task_numa_env {
 static unsigned long cpu_load(struct rq *rq);
 static unsigned long cpu_runnable(struct rq *rq);
 static inline long adjust_numa_imbalance(int imbalance,
-					int dst_running, int dst_weight);
+					int dst_running, int imb_numa_nr);
 
 static inline enum
 numa_type numa_classify(unsigned int imbalance_pct,
@@ -1884,7 +1885,7 @@ static void task_numa_find_cpu(struct task_numa_env *env,
 		dst_running = env->dst_stats.nr_running + 1;
 		imbalance = max(0, dst_running - src_running);
 		imbalance = adjust_numa_imbalance(imbalance, dst_running,
-							env->dst_stats.weight);
+						  env->imb_numa_nr);
 
 		/* Use idle CPU if there is no imbalance */
 		if (!imbalance) {
@@ -1949,8 +1950,10 @@ static int task_numa_migrate(struct task_struct *p)
 	 */
 	rcu_read_lock();
 	sd = rcu_dereference(per_cpu(sd_numa, env.src_cpu));
-	if (sd)
+	if (sd) {
 		env.imbalance_pct = 100 + (sd->imbalance_pct - 100) / 2;
+		env.imb_numa_nr = sd->imb_numa_nr;
+	}
 	rcu_read_unlock();
 
 	/*
@@ -9005,10 +9008,9 @@ static bool update_pick_idlest(struct sched_group *idlest,
  * This is an approximation as the number of running tasks may not be
  * related to the number of busy CPUs due to sched_setaffinity.
  */
-static inline bool
-allow_numa_imbalance(unsigned int running, unsigned int weight)
+static inline bool allow_numa_imbalance(int running, int imb_numa_nr)
 {
-	return (running < (weight >> 2));
+	return running <= imb_numa_nr;
 }
 
 /*
@@ -9148,7 +9150,7 @@ find_idlest_group(struct sched_domain *sd, struct task_struct *p, int this_cpu)
 			 * allowed. If there is a real need of migration,
 			 * periodic load balance will take care of it.
 			 */
-			if (allow_numa_imbalance(local_sgs.sum_nr_running + 1, local_sgs.group_weight))
+			if (allow_numa_imbalance(local_sgs.sum_nr_running + 1, sd->imb_numa_nr))
 				return NULL;
 		}
 
@@ -9240,9 +9242,9 @@ next_group:
 #define NUMA_IMBALANCE_MIN 2
 
 static inline long adjust_numa_imbalance(int imbalance,
-				int dst_running, int dst_weight)
+				int dst_running, int imb_numa_nr)
 {
-	if (!allow_numa_imbalance(dst_running, dst_weight))
+	if (!allow_numa_imbalance(dst_running, imb_numa_nr))
 		return imbalance;
 
 	/*
@@ -9354,7 +9356,7 @@ static inline void calculate_imbalance(struct lb_env *env, struct sd_lb_stats *s
 		/* Consider allowing a small imbalance between NUMA groups */
 		if (env->sd->flags & SD_NUMA) {
 			env->imbalance = adjust_numa_imbalance(env->imbalance,
-				local->sum_nr_running + 1, local->group_weight);
+				local->sum_nr_running + 1, env->sd->imb_numa_nr);
 		}
 
 		return;
diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
index d201a70..e6cd559 100644
--- a/kernel/sched/topology.c
+++ b/kernel/sched/topology.c
@@ -2242,6 +2242,59 @@ build_sched_domains(const struct cpumask *cpu_map, struct sched_domain_attr *att
 		}
 	}
 
+	/*
+	 * Calculate an allowed NUMA imbalance such that LLCs do not get
+	 * imbalanced.
+	 */
+	for_each_cpu(i, cpu_map) {
+		unsigned int imb = 0;
+		unsigned int imb_span = 1;
+
+		for (sd = *per_cpu_ptr(d.sd, i); sd; sd = sd->parent) {
+			struct sched_domain *child = sd->child;
+
+			if (!(sd->flags & SD_SHARE_PKG_RESOURCES) && child &&
+			    (child->flags & SD_SHARE_PKG_RESOURCES)) {
+				struct sched_domain *top, *top_p;
+				unsigned int nr_llcs;
+
+				/*
+				 * For a single LLC per node, allow an
+				 * imbalance up to 25% of the node. This is an
+				 * arbitrary cutoff based on SMT-2 to balance
+				 * between memory bandwidth and avoiding
+				 * premature sharing of HT resources and SMT-4
+				 * or SMT-8 *may* benefit from a different
+				 * cutoff.
+				 *
+				 * For multiple LLCs, allow an imbalance
+				 * until multiple tasks would share an LLC
+				 * on one node while LLCs on another node
+				 * remain idle.
+				 */
+				nr_llcs = sd->span_weight / child->span_weight;
+				if (nr_llcs == 1)
+					imb = sd->span_weight >> 2;
+				else
+					imb = nr_llcs;
+				sd->imb_numa_nr = imb;
+
+				/* Set span based on the first NUMA domain. */
+				top = sd;
+				top_p = top->parent;
+				while (top_p && !(top_p->flags & SD_NUMA)) {
+					top = top->parent;
+					top_p = top->parent;
+				}
+				imb_span = top_p ? top_p->span_weight : sd->span_weight;
+			} else {
+				int factor = max(1U, (sd->span_weight / imb_span));
+
+				sd->imb_numa_nr = imb * factor;
+			}
+		}
+	}
+
 	/* Calculate CPU capacity for physical packages and nodes */
 	for (i = nr_cpumask_bits-1; i >= 0; i--) {
 		if (!cpumask_test_cpu(i, cpu_map))
