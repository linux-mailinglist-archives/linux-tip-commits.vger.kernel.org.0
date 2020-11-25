Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F21112C41A7
	for <lists+linux-tip-commits@lfdr.de>; Wed, 25 Nov 2020 15:05:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729621AbgKYODF (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 25 Nov 2020 09:03:05 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:50350 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729687AbgKYOC4 (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 25 Nov 2020 09:02:56 -0500
Date:   Wed, 25 Nov 2020 14:02:53 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1606312973;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KtKWX3Z5/vxhPuj8J5p5Ox+qApGw+pl1XOXZcRSMr1Y=;
        b=C5yT0mzR2QJCT9L6PXTr/D0zsbmOjqRyfEBubrKriRPQsLgO0esBWpc+hVutTo6s9Ep9af
        5ZjJQvqQgN3+bmsFhdIucMb6cmoWwE/I+KqYVQ48Kn1p6B3N3WKZSK8VOj+F25jMVC+w3L
        QWHcwqRMK1+pWfrEWxG2OtZA2fLtRwJ9b+Zga2KB2HgafRLeMKiYiFb3mBJPQCPEUTI0/0
        IaUaOg3ZQglfppepC1hKNFkMeOaiVl7bzPjZZ3edr1IMBOJWxWJWH2+VKtZd9dJ7aWeTek
        zaDBhR+FP+nHOYigeAad4Fu0xm7lgZuXERbDPbZogA8X4dKEni51bWn2N6FFfw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1606312973;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KtKWX3Z5/vxhPuj8J5p5Ox+qApGw+pl1XOXZcRSMr1Y=;
        b=DUBTkpxKQwApM2yqnZMxzhQYTYT1HHwm093Ah4/VmX9IKOQJqAJRWg+u4r9E+c49MHRgCz
        ycQ3MM5T+SpumeCw==
From:   "tip-bot2 for Mel Gorman" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched: Limit the amount of NUMA imbalance that can
 exist at fork time
Cc:     Mel Gorman <mgorman@techsingularity.net>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20201120090630.3286-5-mgorman@techsingularity.net>
References: <20201120090630.3286-5-mgorman@techsingularity.net>
MIME-Version: 1.0
Message-ID: <160631297307.3364.9271634433734932379.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     23e6082a522e32232f7377540b4d42d8304253b8
Gitweb:        https://git.kernel.org/tip/23e6082a522e32232f7377540b4d42d8304253b8
Author:        Mel Gorman <mgorman@techsingularity.net>
AuthorDate:    Fri, 20 Nov 2020 09:06:30 
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 24 Nov 2020 16:47:48 +01:00

sched: Limit the amount of NUMA imbalance that can exist at fork time

At fork time currently, a local node can be allowed to fill completely
and allow the periodic load balancer to fix the problem. This can be
problematic in cases where a task creates lots of threads that idle until
woken as part of a worker poll causing a memory bandwidth problem.

However, a "real" workload suffers badly from this behaviour. The workload
in question is mostly NUMA aware but spawns large numbers of threads
that act as a worker pool that can be called from anywhere. These need
to spread early to get reasonable behaviour.

This patch limits how much a local node can fill before spilling over
to another node and it will not be a universal win. Specifically,
very short-lived workloads that fit within a NUMA node would prefer
the memory bandwidth.

As I cannot describe the "real" workload, the best proxy measure I found
for illustration was a page fault microbenchmark. It's not representative
of the workload but demonstrates the hazard of the current behaviour.

pft timings
                                 5.10.0-rc2             5.10.0-rc2
                          imbalancefloat-v2          forkspread-v2
Amean     elapsed-1        46.37 (   0.00%)       46.05 *   0.69%*
Amean     elapsed-4        12.43 (   0.00%)       12.49 *  -0.47%*
Amean     elapsed-7         7.61 (   0.00%)        7.55 *   0.81%*
Amean     elapsed-12        4.79 (   0.00%)        4.80 (  -0.17%)
Amean     elapsed-21        3.13 (   0.00%)        2.89 *   7.74%*
Amean     elapsed-30        3.65 (   0.00%)        2.27 *  37.62%*
Amean     elapsed-48        3.08 (   0.00%)        2.13 *  30.69%*
Amean     elapsed-79        2.00 (   0.00%)        1.90 *   4.95%*
Amean     elapsed-80        2.00 (   0.00%)        1.90 *   4.70%*

This is showing the time to fault regions belonging to threads. The target
machine has 80 logical CPUs and two nodes. Note the ~30% gain when the
machine is approximately the point where one node becomes fully utilised.
The slower results are borderline noise.

Kernel building shows similar benefits around the same balance point.
Generally performance was either neutral or better in the tests conducted.
The main consideration with this patch is the point where fork stops
spreading a task so some workloads may benefit from different balance
points but it would be a risky tuning parameter.

Signed-off-by: Mel Gorman <mgorman@techsingularity.net>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Vincent Guittot <vincent.guittot@linaro.org>
Link: https://lkml.kernel.org/r/20201120090630.3286-5-mgorman@techsingularity.net
---
 kernel/sched/fair.c | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 377c77b..2e8aade 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -8762,6 +8762,16 @@ static bool update_pick_idlest(struct sched_group *idlest,
 }
 
 /*
+ * Allow a NUMA imbalance if busy CPUs is less than 25% of the domain.
+ * This is an approximation as the number of running tasks may not be
+ * related to the number of busy CPUs due to sched_setaffinity.
+ */
+static inline bool allow_numa_imbalance(int dst_running, int dst_weight)
+{
+	return (dst_running < (dst_weight >> 2));
+}
+
+/*
  * find_idlest_group() finds and returns the least busy CPU group within the
  * domain.
  *
@@ -8893,7 +8903,7 @@ find_idlest_group(struct sched_domain *sd, struct task_struct *p, int this_cpu)
 			 * a real need of migration, periodic load balance will
 			 * take care of it.
 			 */
-			if (local_sgs.idle_cpus)
+			if (allow_numa_imbalance(local_sgs.sum_nr_running, sd->span_weight))
 				return NULL;
 		}
 
@@ -9000,11 +9010,14 @@ next_group:
 static inline long adjust_numa_imbalance(int imbalance,
 				int dst_running, int dst_weight)
 {
+	if (!allow_numa_imbalance(dst_running, dst_weight))
+		return imbalance;
+
 	/*
 	 * Allow a small imbalance based on a simple pair of communicating
 	 * tasks that remain local when the destination is lightly loaded.
 	 */
-	if (dst_running < (dst_weight >> 2) && imbalance <= NUMA_IMBALANCE_MIN)
+	if (imbalance <= NUMA_IMBALANCE_MIN)
 		return 0;
 
 	return imbalance;
