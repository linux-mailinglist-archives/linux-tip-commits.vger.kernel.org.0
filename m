Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A94827BE8C
	for <lists+linux-tip-commits@lfdr.de>; Tue, 29 Sep 2020 09:57:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727630AbgI2H5I (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Tue, 29 Sep 2020 03:57:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727697AbgI2H4z (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Tue, 29 Sep 2020 03:56:55 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42325C0613D0;
        Tue, 29 Sep 2020 00:56:55 -0700 (PDT)
Date:   Tue, 29 Sep 2020 07:56:52 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1601366213;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hcgWzVVHPrOcK7GAbCCBw2GHpraNSPQv1d0tkOlRPzU=;
        b=PKUHiXCAyOaBuEdROP2hC6vYurt41cpb/qBYaf+xYyx4S3eENP68qZKhub2CU9dGGfg2xn
        WYs+rYmjaWD56jEAxS5m+U0j8B9tOFZebw+87bk7VmQvo4XDs6f472PMcfUEGflQkoR1PC
        g3ykeAmkpvR+P8YTkF0M5cDhNL3NB8zPLdv1lbJCK0VgVDyhMrJwXrShm6q3Q4MwzXMIzl
        /i3JiY483vZK5us/r5uPJmC/Sq2F8XvPTyyKqtU6CkpzpRbDSt8pdJKqMNZhnA85Lr1YF7
        nWflQNysM66kX+uvf2IY69ZvfKF03wXiVTUr7CTys0BXFbKaEIRGH+mIhRyWzg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1601366213;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hcgWzVVHPrOcK7GAbCCBw2GHpraNSPQv1d0tkOlRPzU=;
        b=vFqh1ZquBwBKkGwSnRoU2kD71H7b0q0LIjFz4myGyPiJIxgeBlU9ir6AD3a0IiiSqs3j+t
        QKPqziubIgQQNeDg==
From:   "tip-bot2 for Vincent Guittot" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/numa: Use runnable_avg to classify node
Cc:     Vincent Guittot <vincent.guittot@linaro.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Mel Gorman <mgorman@suse.de>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200921072959.16317-1-vincent.guittot@linaro.org>
References: <20200921072959.16317-1-vincent.guittot@linaro.org>
MIME-Version: 1.0
Message-ID: <160136621295.7002.7186616848185614077.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     8e0e0eda6a13e242239799263cc354796c05434a
Gitweb:        https://git.kernel.org/tip/8e0e0eda6a13e242239799263cc354796c05434a
Author:        Vincent Guittot <vincent.guittot@linaro.org>
AuthorDate:    Mon, 21 Sep 2020 09:29:59 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 25 Sep 2020 14:23:24 +02:00

sched/numa: Use runnable_avg to classify node

Use runnable_avg to classify numa node state similarly to what is done for
normal load balancer. This helps to ensure that numa and normal balancers
use the same view of the state of the system.

Large arm64system: 2 nodes / 224 CPUs:

  hackbench -l (256000/#grp) -g #grp

  grp    tip/sched/core         +patchset              improvement
  1      14,008(+/- 4,99 %)     13,800(+/- 3.88 %)     1,48 %
  4       4,340(+/- 5.35 %)      4.283(+/- 4.85 %)     1,33 %
  16      3,357(+/- 0.55 %)      3.359(+/- 0.54 %)    -0,06 %
  32      3,050(+/- 0.94 %)      3.039(+/- 1,06 %)     0,38 %
  64      2.968(+/- 1,85 %)      3.006(+/- 2.92 %)    -1.27 %
  128     3,290(+/-12.61 %)      3,108(+/- 5.97 %)     5.51 %
  256     3.235(+/- 3.95 %)      3,188(+/- 2.83 %)     1.45 %

Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Mel Gorman <mgorman@suse.de>
Link: https://lkml.kernel.org/r/20200921072959.16317-1-vincent.guittot@linaro.org
---
 kernel/sched/fair.c |  9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 33699db..a15deb2 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -1504,6 +1504,7 @@ enum numa_type {
 /* Cached statistics for all CPUs within a node */
 struct numa_stats {
 	unsigned long load;
+	unsigned long runnable;
 	unsigned long util;
 	/* Total compute capacity of CPUs on a node */
 	unsigned long compute_capacity;
@@ -1547,6 +1548,7 @@ struct task_numa_env {
 };
 
 static unsigned long cpu_load(struct rq *rq);
+static unsigned long cpu_runnable(struct rq *rq);
 static unsigned long cpu_util(int cpu);
 static inline long adjust_numa_imbalance(int imbalance, int src_nr_running);
 
@@ -1555,11 +1557,13 @@ numa_type numa_classify(unsigned int imbalance_pct,
 			 struct numa_stats *ns)
 {
 	if ((ns->nr_running > ns->weight) &&
-	    ((ns->compute_capacity * 100) < (ns->util * imbalance_pct)))
+	    (((ns->compute_capacity * 100) < (ns->util * imbalance_pct)) ||
+	     ((ns->compute_capacity * imbalance_pct) < (ns->runnable * 100))))
 		return node_overloaded;
 
 	if ((ns->nr_running < ns->weight) ||
-	    ((ns->compute_capacity * 100) > (ns->util * imbalance_pct)))
+	    (((ns->compute_capacity * 100) > (ns->util * imbalance_pct)) &&
+	     ((ns->compute_capacity * imbalance_pct) > (ns->runnable * 100))))
 		return node_has_spare;
 
 	return node_fully_busy;
@@ -1610,6 +1614,7 @@ static void update_numa_stats(struct task_numa_env *env,
 		struct rq *rq = cpu_rq(cpu);
 
 		ns->load += cpu_load(rq);
+		ns->runnable += cpu_runnable(rq);
 		ns->util += cpu_util(cpu);
 		ns->nr_running += rq->cfs.h_nr_running;
 		ns->compute_capacity += capacity_of(cpu);
