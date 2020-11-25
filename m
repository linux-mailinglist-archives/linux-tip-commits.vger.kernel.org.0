Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52ED32C41AA
	for <lists+linux-tip-commits@lfdr.de>; Wed, 25 Nov 2020 15:05:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729687AbgKYODJ (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 25 Nov 2020 09:03:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729720AbgKYOCz (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 25 Nov 2020 09:02:55 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2764C061A4E;
        Wed, 25 Nov 2020 06:02:55 -0800 (PST)
Date:   Wed, 25 Nov 2020 14:02:53 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1606312973;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XoutWbMEVCsIpMvHmpbZSanIi12GH9Iow5PKeM6F9Wo=;
        b=HFkStP2v6oezqdwJI8ME3np68exp9FU8sN3VDV0CCh0D+QohX7oV/6R0/SwKQTtwSuRisQ
        TV9ocwUSeXsx5NninJQhEqlR/WlUW653QsJIJ3Tk7exZkJlVDh17ppmW/8rZHZb0cZEyO1
        0QWJpKwrT9ksFPrJRiI1o+4k7VPP9oF8GPl0n1w5hxnzH4zYe+q/a+cPMSkhc8eYHoVLyy
        e7/znSpkVL7N5tLwqBKITA6oyrOdoEmlqkrH5pzpRcW+fJ7zD4abhPmaGzXXOQLrur+bWG
        uZpfqUV31q3SXQOSZhg2OWDhWQje697GVgMIb+kFfXEPmkx+YXHWkBjrzUrLuQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1606312973;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XoutWbMEVCsIpMvHmpbZSanIi12GH9Iow5PKeM6F9Wo=;
        b=gyK3uJtWypbHp8F6gQaZkDvZN+JT+sjzUgWrIBozexQPSFna0s4JUpYy5RR8bkStouRr27
        pn3MsWYprC3VtaAA==
From:   "tip-bot2 for Mel Gorman" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/numa: Allow a floating imbalance between NUMA nodes
Cc:     Mel Gorman <mgorman@techsingularity.net>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20201120090630.3286-4-mgorman@techsingularity.net>
References: <20201120090630.3286-4-mgorman@techsingularity.net>
MIME-Version: 1.0
Message-ID: <160631297333.3364.10427637559724972015.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     7d2b5dd0bcc48095651f1b85f751eef610b3e034
Gitweb:        https://git.kernel.org/tip/7d2b5dd0bcc48095651f1b85f751eef610b3e034
Author:        Mel Gorman <mgorman@techsingularity.net>
AuthorDate:    Fri, 20 Nov 2020 09:06:29 
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 24 Nov 2020 16:47:47 +01:00

sched/numa: Allow a floating imbalance between NUMA nodes

Currently, an imbalance is only allowed when a destination node
is almost completely idle. This solved one basic class of problems
and was the cautious approach.

This patch revisits the possibility that NUMA nodes can be imbalanced
until 25% of the CPUs are occupied. The reasoning behind 25% is somewhat
superficial -- it's half the cores when HT is enabled.  At higher
utilisations, balancing should continue as normal and keep things even
until scheduler domains are fully busy or over utilised.

Note that this is not expected to be a universal win. Any benchmark
that prefers spreading as wide as possible with limited communication
will favour the old behaviour as there is more memory bandwidth.
Workloads that communicate heavily in pairs such as netperf or tbench
benefit. For the tests I ran, the vast majority of workloads saw
a benefit so it seems to be a worthwhile trade-off.

Signed-off-by: Mel Gorman <mgorman@techsingularity.net>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Vincent Guittot <vincent.guittot@linaro.org>
Link: https://lkml.kernel.org/r/20201120090630.3286-4-mgorman@techsingularity.net
---
 kernel/sched/fair.c | 21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 2626c6b..377c77b 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -1559,7 +1559,8 @@ struct task_numa_env {
 static unsigned long cpu_load(struct rq *rq);
 static unsigned long cpu_runnable(struct rq *rq);
 static unsigned long cpu_util(int cpu);
-static inline long adjust_numa_imbalance(int imbalance, int dst_running);
+static inline long adjust_numa_imbalance(int imbalance,
+					int dst_running, int dst_weight);
 
 static inline enum
 numa_type numa_classify(unsigned int imbalance_pct,
@@ -1939,7 +1940,8 @@ static void task_numa_find_cpu(struct task_numa_env *env,
 		src_running = env->src_stats.nr_running - 1;
 		dst_running = env->dst_stats.nr_running + 1;
 		imbalance = max(0, dst_running - src_running);
-		imbalance = adjust_numa_imbalance(imbalance, dst_running);
+		imbalance = adjust_numa_imbalance(imbalance, dst_running,
+							env->dst_stats.weight);
 
 		/* Use idle CPU if there is no imbalance */
 		if (!imbalance) {
@@ -8995,16 +8997,14 @@ next_group:
 
 #define NUMA_IMBALANCE_MIN 2
 
-static inline long adjust_numa_imbalance(int imbalance, int dst_running)
+static inline long adjust_numa_imbalance(int imbalance,
+				int dst_running, int dst_weight)
 {
-	unsigned int imbalance_min;
-
 	/*
 	 * Allow a small imbalance based on a simple pair of communicating
-	 * tasks that remain local when the source domain is almost idle.
+	 * tasks that remain local when the destination is lightly loaded.
 	 */
-	imbalance_min = NUMA_IMBALANCE_MIN;
-	if (dst_running <= imbalance_min)
+	if (dst_running < (dst_weight >> 2) && imbalance <= NUMA_IMBALANCE_MIN)
 		return 0;
 
 	return imbalance;
@@ -9106,9 +9106,10 @@ static inline void calculate_imbalance(struct lb_env *env, struct sd_lb_stats *s
 		}
 
 		/* Consider allowing a small imbalance between NUMA groups */
-		if (env->sd->flags & SD_NUMA)
+		if (env->sd->flags & SD_NUMA) {
 			env->imbalance = adjust_numa_imbalance(env->imbalance,
-						busiest->sum_nr_running);
+				busiest->sum_nr_running, busiest->group_weight);
+		}
 
 		return;
 	}
