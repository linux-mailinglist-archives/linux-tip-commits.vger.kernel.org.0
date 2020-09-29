Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E305827BE85
	for <lists+linux-tip-commits@lfdr.de>; Tue, 29 Sep 2020 09:57:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727646AbgI2H4v (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Tue, 29 Sep 2020 03:56:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727629AbgI2H4u (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Tue, 29 Sep 2020 03:56:50 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A05FEC061755;
        Tue, 29 Sep 2020 00:56:50 -0700 (PDT)
Date:   Tue, 29 Sep 2020 07:56:48 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1601366208;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CVaGrnlsQT5XIvUiqa942fvawW70lERRsxwNz0sqPjY=;
        b=vDT34XdRoFAQGsK7qF48xv6NODQ7j73I89gZT71FD7gu1tOfms2jHswR5ujOnmwsKT/eqv
        rJX49TKyJbEiCbkhK/ftzc8/YxPyTbbDJPVn3ZQTnGawb8t+mL9iOZHAgdvbMdXj7JinQU
        srVjzkHB0wHVhY3hek0o6yplwlqkL5ObcYCINC7FyW7gFdhQGpuP5g54iEyibfQBwgUL+C
        OCEsHUG+/FkMGVJI3UInkelOKimXvJClaPSGeoVWNjkNCU8jLQZQiNs4YyDOGRyCNe5Kqz
        My4MoDcdCgEdtUoUrQSGJHCArz0i91EgYdyzGjHVpEfXCVD8MpHCeNnzzExVaQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1601366208;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CVaGrnlsQT5XIvUiqa942fvawW70lERRsxwNz0sqPjY=;
        b=kmzX4yp0Y55K+8KRcCn2vze9IkTyhwNhPRnhsdydYpcmytOg7V/mrCW6gHQj077h5e3HJ+
        dYAkm5EVqAVfuUBA==
From:   "tip-bot2 for Barry Song" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/fair: Use dst group while checking imbalance
 for NUMA balancer
Cc:     Barry Song <song.bao.hua@hisilicon.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200921221849.GI3179@techsingularity.net>
References: <20200921221849.GI3179@techsingularity.net>
MIME-Version: 1.0
Message-ID: <160136620809.7002.11067816921925358115.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     233e7aca4c8a2c764f556bba9644c36154017e7f
Gitweb:        https://git.kernel.org/tip/233e7aca4c8a2c764f556bba9644c36154017e7f
Author:        Barry Song <song.bao.hua@hisilicon.com>
AuthorDate:    Mon, 21 Sep 2020 23:18:49 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 25 Sep 2020 14:23:26 +02:00

sched/fair: Use dst group while checking imbalance for NUMA balancer

Barry Song noted the following

	Something is wrong. In find_busiest_group(), we are checking if
	src has higher load, however, in task_numa_find_cpu(), we are
	checking if dst will have higher load after balancing. It seems
	it is not sensible to check src.

	It maybe cause wrong imbalance value, for example,

	if dst_running = env->dst_stats.nr_running + 1 results in 3 or
	above, and src_running = env->src_stats.nr_running - 1 results
	in 1;

	The current code is thinking imbalance as 0 since src_running is
	smaller than 2.  This is inconsistent with load balancer.

Basically, in find_busiest_group(), the NUMA imbalance is ignored if moving
a task "from an almost idle domain" to a "domain with spare capacity". This
patch forbids movement "from a misplaced domain" to "an almost idle domain"
as that is closer to what the CPU load balancer expects.

This patch is not a universal win. The old behaviour was intended to allow
a task from an almost idle NUMA node to migrate to its preferred node if
the destination had capacity but there are corner cases.  For example,
a NAS compute load could be parallelised to use 1/3rd of available CPUs
but not all those potential tasks are active at all times allowing this
logic to trigger. An obvious example is specjbb 2005 running various
numbers of warehouses on a 2 socket box with 80 cpus.

specjbb
                               5.9.0-rc4              5.9.0-rc4
                                 vanilla        dstbalance-v1r1
Hmean     tput-1     46425.00 (   0.00%)    43394.00 *  -6.53%*
Hmean     tput-2     98416.00 (   0.00%)    96031.00 *  -2.42%*
Hmean     tput-3    150184.00 (   0.00%)   148783.00 *  -0.93%*
Hmean     tput-4    200683.00 (   0.00%)   197906.00 *  -1.38%*
Hmean     tput-5    236305.00 (   0.00%)   245549.00 *   3.91%*
Hmean     tput-6    281559.00 (   0.00%)   285692.00 *   1.47%*
Hmean     tput-7    338558.00 (   0.00%)   334467.00 *  -1.21%*
Hmean     tput-8    340745.00 (   0.00%)   372501.00 *   9.32%*
Hmean     tput-9    424343.00 (   0.00%)   413006.00 *  -2.67%*
Hmean     tput-10   421854.00 (   0.00%)   434261.00 *   2.94%*
Hmean     tput-11   493256.00 (   0.00%)   485330.00 *  -1.61%*
Hmean     tput-12   549573.00 (   0.00%)   529959.00 *  -3.57%*
Hmean     tput-13   593183.00 (   0.00%)   555010.00 *  -6.44%*
Hmean     tput-14   588252.00 (   0.00%)   599166.00 *   1.86%*
Hmean     tput-15   623065.00 (   0.00%)   642713.00 *   3.15%*
Hmean     tput-16   703924.00 (   0.00%)   660758.00 *  -6.13%*
Hmean     tput-17   666023.00 (   0.00%)   697675.00 *   4.75%*
Hmean     tput-18   761502.00 (   0.00%)   758360.00 *  -0.41%*
Hmean     tput-19   796088.00 (   0.00%)   798368.00 *   0.29%*
Hmean     tput-20   733564.00 (   0.00%)   823086.00 *  12.20%*
Hmean     tput-21   840980.00 (   0.00%)   856711.00 *   1.87%*
Hmean     tput-22   804285.00 (   0.00%)   872238.00 *   8.45%*
Hmean     tput-23   795208.00 (   0.00%)   889374.00 *  11.84%*
Hmean     tput-24   848619.00 (   0.00%)   966783.00 *  13.92%*
Hmean     tput-25   750848.00 (   0.00%)   903790.00 *  20.37%*
Hmean     tput-26   780523.00 (   0.00%)   962254.00 *  23.28%*
Hmean     tput-27  1042245.00 (   0.00%)   991544.00 *  -4.86%*
Hmean     tput-28  1090580.00 (   0.00%)  1035926.00 *  -5.01%*
Hmean     tput-29   999483.00 (   0.00%)  1082948.00 *   8.35%*
Hmean     tput-30  1098663.00 (   0.00%)  1113427.00 *   1.34%*
Hmean     tput-31  1125671.00 (   0.00%)  1134175.00 *   0.76%*
Hmean     tput-32   968167.00 (   0.00%)  1250286.00 *  29.14%*
Hmean     tput-33  1077676.00 (   0.00%)  1060893.00 *  -1.56%*
Hmean     tput-34  1090538.00 (   0.00%)  1090933.00 *   0.04%*
Hmean     tput-35   967058.00 (   0.00%)  1107421.00 *  14.51%*
Hmean     tput-36  1051745.00 (   0.00%)  1210663.00 *  15.11%*
Hmean     tput-37  1019465.00 (   0.00%)  1351446.00 *  32.56%*
Hmean     tput-38  1083102.00 (   0.00%)  1064541.00 *  -1.71%*
Hmean     tput-39  1232990.00 (   0.00%)  1303623.00 *   5.73%*
Hmean     tput-40  1175542.00 (   0.00%)  1340943.00 *  14.07%*
Hmean     tput-41  1127826.00 (   0.00%)  1339492.00 *  18.77%*
Hmean     tput-42  1198313.00 (   0.00%)  1411023.00 *  17.75%*
Hmean     tput-43  1163733.00 (   0.00%)  1228253.00 *   5.54%*
Hmean     tput-44  1305562.00 (   0.00%)  1357886.00 *   4.01%*
Hmean     tput-45  1326752.00 (   0.00%)  1406061.00 *   5.98%*
Hmean     tput-46  1339424.00 (   0.00%)  1418451.00 *   5.90%*
Hmean     tput-47  1415057.00 (   0.00%)  1381570.00 *  -2.37%*
Hmean     tput-48  1392003.00 (   0.00%)  1421167.00 *   2.10%*
Hmean     tput-49  1408374.00 (   0.00%)  1418659.00 *   0.73%*
Hmean     tput-50  1359822.00 (   0.00%)  1391070.00 *   2.30%*
Hmean     tput-51  1414246.00 (   0.00%)  1392679.00 *  -1.52%*
Hmean     tput-52  1432352.00 (   0.00%)  1354020.00 *  -5.47%*
Hmean     tput-53  1387563.00 (   0.00%)  1409563.00 *   1.59%*
Hmean     tput-54  1406420.00 (   0.00%)  1388711.00 *  -1.26%*
Hmean     tput-55  1438804.00 (   0.00%)  1387472.00 *  -3.57%*
Hmean     tput-56  1399465.00 (   0.00%)  1400296.00 *   0.06%*
Hmean     tput-57  1428132.00 (   0.00%)  1396399.00 *  -2.22%*
Hmean     tput-58  1432385.00 (   0.00%)  1386253.00 *  -3.22%*
Hmean     tput-59  1421612.00 (   0.00%)  1371416.00 *  -3.53%*
Hmean     tput-60  1429423.00 (   0.00%)  1389412.00 *  -2.80%*
Hmean     tput-61  1396230.00 (   0.00%)  1351122.00 *  -3.23%*
Hmean     tput-62  1418396.00 (   0.00%)  1383098.00 *  -2.49%*
Hmean     tput-63  1409918.00 (   0.00%)  1374662.00 *  -2.50%*
Hmean     tput-64  1410236.00 (   0.00%)  1376216.00 *  -2.41%*
Hmean     tput-65  1396405.00 (   0.00%)  1364418.00 *  -2.29%*
Hmean     tput-66  1395975.00 (   0.00%)  1357326.00 *  -2.77%*
Hmean     tput-67  1392986.00 (   0.00%)  1349642.00 *  -3.11%*
Hmean     tput-68  1386541.00 (   0.00%)  1343261.00 *  -3.12%*
Hmean     tput-69  1374407.00 (   0.00%)  1342588.00 *  -2.32%*
Hmean     tput-70  1377513.00 (   0.00%)  1334654.00 *  -3.11%*
Hmean     tput-71  1369319.00 (   0.00%)  1334952.00 *  -2.51%*
Hmean     tput-72  1354635.00 (   0.00%)  1329005.00 *  -1.89%*
Hmean     tput-73  1350933.00 (   0.00%)  1318942.00 *  -2.37%*
Hmean     tput-74  1351714.00 (   0.00%)  1316347.00 *  -2.62%*
Hmean     tput-75  1352198.00 (   0.00%)  1309974.00 *  -3.12%*
Hmean     tput-76  1349490.00 (   0.00%)  1286064.00 *  -4.70%*
Hmean     tput-77  1336131.00 (   0.00%)  1303684.00 *  -2.43%*
Hmean     tput-78  1308896.00 (   0.00%)  1271024.00 *  -2.89%*
Hmean     tput-79  1326703.00 (   0.00%)  1290862.00 *  -2.70%*
Hmean     tput-80  1336199.00 (   0.00%)  1291629.00 *  -3.34%*

The performance at the mid-point is better but not universally better. The
patch is a mixed bag depending on the workload, machine and overall
levels of utilisation. Sometimes it's better (sometimes much better),
other times it is worse (sometimes much worse). Given that there isn't a
universally good decision in this section and more people seem to prefer
the patch then it may be best to keep the LB decisions consistent and
revisit imbalance handling when the load balancer code changes settle down.

Jirka Hladky added the following observation.

	Our results are mostly in line with what you see. We observe
	big gains (20-50%) when the system is loaded to 1/3 of the
	maximum capacity and mixed results at the full load - some
	workloads benefit from the patch at the full load, others not,
	but performance changes at the full load are mostly within the
	noise of results (+/-5%). Overall, we think this patch is helpful.

[mgorman@techsingularity.net: Rewrote changelog]
Fixes: fb86f5b211 ("sched/numa: Use similar logic to the load balancer for moving between domains with spare capacity")
Signed-off-by: Barry Song <song.bao.hua@hisilicon.com>
Signed-off-by: Mel Gorman <mgorman@techsingularity.net>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20200921221849.GI3179@techsingularity.net
---
 kernel/sched/fair.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 24a5ee6..fc3410b 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -1550,7 +1550,7 @@ struct task_numa_env {
 static unsigned long cpu_load(struct rq *rq);
 static unsigned long cpu_runnable(struct rq *rq);
 static unsigned long cpu_util(int cpu);
-static inline long adjust_numa_imbalance(int imbalance, int src_nr_running);
+static inline long adjust_numa_imbalance(int imbalance, int nr_running);
 
 static inline enum
 numa_type numa_classify(unsigned int imbalance_pct,
@@ -1930,7 +1930,7 @@ static void task_numa_find_cpu(struct task_numa_env *env,
 		src_running = env->src_stats.nr_running - 1;
 		dst_running = env->dst_stats.nr_running + 1;
 		imbalance = max(0, dst_running - src_running);
-		imbalance = adjust_numa_imbalance(imbalance, src_running);
+		imbalance = adjust_numa_imbalance(imbalance, dst_running);
 
 		/* Use idle CPU if there is no imbalance */
 		if (!imbalance) {
@@ -8967,7 +8967,7 @@ next_group:
 	}
 }
 
-static inline long adjust_numa_imbalance(int imbalance, int src_nr_running)
+static inline long adjust_numa_imbalance(int imbalance, int nr_running)
 {
 	unsigned int imbalance_min;
 
@@ -8976,7 +8976,7 @@ static inline long adjust_numa_imbalance(int imbalance, int src_nr_running)
 	 * tasks that remain local when the source domain is almost idle.
 	 */
 	imbalance_min = 2;
-	if (src_nr_running <= imbalance_min)
+	if (nr_running <= imbalance_min)
 		return 0;
 
 	return imbalance;
