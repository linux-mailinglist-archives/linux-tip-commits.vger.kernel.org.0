Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F3E763AC66C
	for <lists+linux-tip-commits@lfdr.de>; Fri, 18 Jun 2021 10:46:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233916AbhFRIsT (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 18 Jun 2021 04:48:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233900AbhFRIsQ (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 18 Jun 2021 04:48:16 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B96FC061574;
        Fri, 18 Jun 2021 01:46:07 -0700 (PDT)
Date:   Fri, 18 Jun 2021 08:46:05 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1624005965;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LRcv8wfSgRWmMiZp5DD6p1a8ySzM1T1XAwn5Sl3hc3U=;
        b=ywq27+iQ9GMRS79rPTB/miPsaxzG6cVq67ngvTH/8SE8KuMppO79zjvAzRzWG0kXAYEk5/
        8D7/zliMLOftnFR61qGkLtzCZSKB9akjzzEyCzKjnGISlGMeohsRMmACbzH3s6Gmc608eN
        y37H5zyTp4Qt+5RaXfeWgZN6dHMl0h0ijx4K1NXRktCPqTtHvIVvwypNdhA26KOyIjjKfp
        8+yZ8EagPcYsjmSoEDsY4njOZVVLMVTOZxAJESCQ9wWXkhokzWG/RmYcpPD6jLGt5nYWSE
        RdlDHoJTyIT/JhCiEMSdV/ZGdP+JEq9TdHi+aj5dIWyZlKVJTh28oZzIVAZ4bQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1624005965;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LRcv8wfSgRWmMiZp5DD6p1a8ySzM1T1XAwn5Sl3hc3U=;
        b=L21duY/9soYaSOh4W+FUnqUK63NpeqyMLq5Vl7jjorkiiO4RvtKtbJrZFwbKoyv8MFW6LH
        9livR+XpCdTpSuCA==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/fair: Age the average idle time
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Mel Gorman <mgorman@techsingularity.net>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210615111611.GH30378@techsingularity.net>
References: <20210615111611.GH30378@techsingularity.net>
MIME-Version: 1.0
Message-ID: <162400596505.19906.6909108086024980212.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     94aafc3ee31dc199d1078ffac9edd976b7f47b3d
Gitweb:        https://git.kernel.org/tip/94aafc3ee31dc199d1078ffac9edd976b7f47b3d
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Tue, 15 Jun 2021 12:16:11 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Thu, 17 Jun 2021 14:11:44 +02:00

sched/fair: Age the average idle time

This is a partial forward-port of Peter Ziljstra's work first posted
at:

   https://lore.kernel.org/lkml/20180530142236.667774973@infradead.org/

Currently select_idle_cpu()'s proportional scheme uses the average idle
time *for when we are idle*, that is temporally challenged.  When a CPU
is not at all idle, we'll happily continue using whatever value we did
see when the CPU goes idle. To fix this, introduce a separate average
idle and age it (the existing value still makes sense for things like
new-idle balancing, which happens when we do go idle).

The overall goal is to not spend more time scanning for idle CPUs than
we're idle for. Otherwise we're inhibiting work. This means that we need to
consider the cost over all the wake-ups between consecutive idle periods.
To track this, the scan cost is subtracted from the estimated average
idle time.

The impact of this patch is related to workloads that have domains that
are fully busy or overloaded. Without the patch, the scan depth may be
too high because a CPU is not reaching idle.

Due to the nature of the patch, this is a regression magnet. It
potentially wins when domains are almost fully busy or overloaded --
at that point searches are likely to fail but idle is not being aged
as CPUs are active so search depth is too large and useless. It will
potentially show regressions when there are idle CPUs and a deep search is
beneficial. This tbench result on a 2-socket broadwell machine partially
illustates the problem

                          5.13.0-rc2             5.13.0-rc2
                             vanilla     sched-avgidle-v1r5
Hmean     1        445.02 (   0.00%)      451.36 *   1.42%*
Hmean     2        830.69 (   0.00%)      846.03 *   1.85%*
Hmean     4       1350.80 (   0.00%)     1505.56 *  11.46%*
Hmean     8       2888.88 (   0.00%)     2586.40 * -10.47%*
Hmean     16      5248.18 (   0.00%)     5305.26 *   1.09%*
Hmean     32      8914.03 (   0.00%)     9191.35 *   3.11%*
Hmean     64     10663.10 (   0.00%)    10192.65 *  -4.41%*
Hmean     128    18043.89 (   0.00%)    18478.92 *   2.41%*
Hmean     256    16530.89 (   0.00%)    17637.16 *   6.69%*
Hmean     320    16451.13 (   0.00%)    17270.97 *   4.98%*

Note that 8 was a regression point where a deeper search would have helped
but it gains for high thread counts when searches are useless. Hackbench
is a more extreme example although not perfect as the tasks idle rapidly

hackbench-process-pipes
                          5.13.0-rc2             5.13.0-rc2
                             vanilla     sched-avgidle-v1r5
Amean     1        0.3950 (   0.00%)      0.3887 (   1.60%)
Amean     4        0.9450 (   0.00%)      0.9677 (  -2.40%)
Amean     7        1.4737 (   0.00%)      1.4890 (  -1.04%)
Amean     12       2.3507 (   0.00%)      2.3360 *   0.62%*
Amean     21       4.0807 (   0.00%)      4.0993 *  -0.46%*
Amean     30       5.6820 (   0.00%)      5.7510 *  -1.21%*
Amean     48       8.7913 (   0.00%)      8.7383 (   0.60%)
Amean     79      14.3880 (   0.00%)     13.9343 *   3.15%*
Amean     110     21.2233 (   0.00%)     19.4263 *   8.47%*
Amean     141     28.2930 (   0.00%)     25.1003 *  11.28%*
Amean     172     34.7570 (   0.00%)     30.7527 *  11.52%*
Amean     203     41.0083 (   0.00%)     36.4267 *  11.17%*
Amean     234     47.7133 (   0.00%)     42.0623 *  11.84%*
Amean     265     53.0353 (   0.00%)     47.7720 *   9.92%*
Amean     296     60.0170 (   0.00%)     53.4273 *  10.98%*
Stddev    1        0.0052 (   0.00%)      0.0025 (  51.57%)
Stddev    4        0.0357 (   0.00%)      0.0370 (  -3.75%)
Stddev    7        0.0190 (   0.00%)      0.0298 ( -56.64%)
Stddev    12       0.0064 (   0.00%)      0.0095 ( -48.38%)
Stddev    21       0.0065 (   0.00%)      0.0097 ( -49.28%)
Stddev    30       0.0185 (   0.00%)      0.0295 ( -59.54%)
Stddev    48       0.0559 (   0.00%)      0.0168 (  69.92%)
Stddev    79       0.1559 (   0.00%)      0.0278 (  82.17%)
Stddev    110      1.1728 (   0.00%)      0.0532 (  95.47%)
Stddev    141      0.7867 (   0.00%)      0.0968 (  87.69%)
Stddev    172      1.0255 (   0.00%)      0.0420 (  95.91%)
Stddev    203      0.8106 (   0.00%)      0.1384 (  82.92%)
Stddev    234      1.1949 (   0.00%)      0.1328 (  88.89%)
Stddev    265      0.9231 (   0.00%)      0.0820 (  91.11%)
Stddev    296      1.0456 (   0.00%)      0.1327 (  87.31%)

Again, higher thread counts benefit and the standard deviation
shows that results are also a lot more stable when the idle
time is aged.

The patch potentially matters when a socket was multiple LLCs as the
maximum search depth is lower. However, some of the test results were
suspiciously good (e.g. specjbb2005 gaining 50% on a Zen1 machine) and
other results were not dramatically different to other mcahines.

Given the nature of the patch, Peter's full series is not being forward
ported as each part should stand on its own. Preferably they would be
merged at different times to reduce the risk of false bisections.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Mel Gorman <mgorman@techsingularity.net>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20210615111611.GH30378@techsingularity.net
---
 kernel/sched/core.c  |  5 +++++
 kernel/sched/fair.c  | 25 +++++++++++++++++++++----
 kernel/sched/sched.h |  3 +++
 3 files changed, 29 insertions(+), 4 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 9e9a5be..75655cd 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -3340,6 +3340,9 @@ static void ttwu_do_wakeup(struct rq *rq, struct task_struct *p, int wake_flags,
 		if (rq->avg_idle > max)
 			rq->avg_idle = max;
 
+		rq->wake_stamp = jiffies;
+		rq->wake_avg_idle = rq->avg_idle / 2;
+
 		rq->idle_stamp = 0;
 	}
 #endif
@@ -9023,6 +9026,8 @@ void __init sched_init(void)
 		rq->online = 0;
 		rq->idle_stamp = 0;
 		rq->avg_idle = 2*sysctl_sched_migration_cost;
+		rq->wake_stamp = jiffies;
+		rq->wake_avg_idle = rq->avg_idle;
 		rq->max_idle_balance_cost = sysctl_sched_migration_cost;
 
 		INIT_LIST_HEAD(&rq->cfs_tasks);
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index ed7df1b..3af4afe 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -6139,9 +6139,10 @@ static int select_idle_cpu(struct task_struct *p, struct sched_domain *sd, bool 
 {
 	struct cpumask *cpus = this_cpu_cpumask_var_ptr(select_idle_mask);
 	int i, cpu, idle_cpu = -1, nr = INT_MAX;
+	struct rq *this_rq = this_rq();
 	int this = smp_processor_id();
 	struct sched_domain *this_sd;
-	u64 time;
+	u64 time = 0;
 
 	this_sd = rcu_dereference(*this_cpu_ptr(&sd_llc));
 	if (!this_sd)
@@ -6151,12 +6152,21 @@ static int select_idle_cpu(struct task_struct *p, struct sched_domain *sd, bool 
 
 	if (sched_feat(SIS_PROP) && !has_idle_core) {
 		u64 avg_cost, avg_idle, span_avg;
+		unsigned long now = jiffies;
 
 		/*
-		 * Due to large variance we need a large fuzz factor;
-		 * hackbench in particularly is sensitive here.
+		 * If we're busy, the assumption that the last idle period
+		 * predicts the future is flawed; age away the remaining
+		 * predicted idle time.
 		 */
-		avg_idle = this_rq()->avg_idle / 512;
+		if (unlikely(this_rq->wake_stamp < now)) {
+			while (this_rq->wake_stamp < now && this_rq->wake_avg_idle) {
+				this_rq->wake_stamp++;
+				this_rq->wake_avg_idle >>= 1;
+			}
+		}
+
+		avg_idle = this_rq->wake_avg_idle;
 		avg_cost = this_sd->avg_scan_cost + 1;
 
 		span_avg = sd->span_weight * avg_idle;
@@ -6188,6 +6198,13 @@ static int select_idle_cpu(struct task_struct *p, struct sched_domain *sd, bool 
 
 	if (sched_feat(SIS_PROP) && !has_idle_core) {
 		time = cpu_clock(this) - time;
+
+		/*
+		 * Account for the scan cost of wakeups against the average
+		 * idle time.
+		 */
+		this_rq->wake_avg_idle -= min(this_rq->wake_avg_idle, time);
+
 		update_avg(&this_sd->avg_scan_cost, time);
 	}
 
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 8f0194c..01e48f6 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -1022,6 +1022,9 @@ struct rq {
 	u64			idle_stamp;
 	u64			avg_idle;
 
+	unsigned long		wake_stamp;
+	u64			wake_avg_idle;
+
 	/* This is used to determine avg_idle's max value */
 	u64			max_idle_balance_cost;
 
