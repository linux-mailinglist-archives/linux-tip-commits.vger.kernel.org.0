Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE4322F600A
	for <lists+linux-tip-commits@lfdr.de>; Thu, 14 Jan 2021 12:31:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728926AbhANLal (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Thu, 14 Jan 2021 06:30:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728815AbhANLaY (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Thu, 14 Jan 2021 06:30:24 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C514C061796;
        Thu, 14 Jan 2021 03:29:10 -0800 (PST)
Date:   Thu, 14 Jan 2021 11:29:07 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1610623748;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PEYmuMc7tapdwrjk4hjKXYOZ2ppQ+JqKQtvE5R6stlE=;
        b=YwPc0KtlE9FPUzbLV+/gC5geE40EwJIGRkbX7B/XCD2pTU8MD1S4UjYgpMdBvqktwVBp6n
        IkR7kWi563Tw4HBXkmDRuhp92nnMXj7X998JqjOWyq+C/rAK89eSWH7kvfL30A/8yS2Nt/
        csExCetwW8fxpiaFI2oi+/3V6CS/6vtkyKCf5xb1ArVSBjWVbveFzFAfe9xCfB25PeKeuu
        c7UmE1v0l8V7RMdn8trZx0fJVtHJhx59B40AfBDZwCzb4O8b3k72ps2DmFkbv9DrZjJ1NH
        NNDgp79WtJfz6rsNVsUFSB02aEuz1pRp8mYeCyVrYRQ6H6PIBvqf5NgSOq7ViQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1610623748;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PEYmuMc7tapdwrjk4hjKXYOZ2ppQ+JqKQtvE5R6stlE=;
        b=s7jgT8mVa/kCwbNAblq4sAJxrcXC9/I/Xh/nbV/oYcWMMbXcKRwG93TL87Qzz0O/5z5TlT
        Wn7Q6SvOssWPEAAQ==
From:   "tip-bot2 for Viresh Kumar" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/core: Move schedutil_cpu_util() to core.c
Cc:     Viresh Kumar <viresh.kumar@linaro.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: =?utf-8?q?=3Cc921a362c78e1324f8ebc5aaa12f53e309c5a8a2=2E16074?=
 =?utf-8?q?00596=2Egit=2Eviresh=2Ekumar=40linaro=2Eorg=3E?=
References: =?utf-8?q?=3Cc921a362c78e1324f8ebc5aaa12f53e309c5a8a2=2E160740?=
 =?utf-8?q?0596=2Egit=2Eviresh=2Ekumar=40linaro=2Eorg=3E?=
MIME-Version: 1.0
Message-ID: <161062374746.414.1655281398965366292.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     7d6a905f3dd62c4502cdd772c71319de4058ec89
Gitweb:        https://git.kernel.org/tip/7d6a905f3dd62c4502cdd772c71319de4058ec89
Author:        Viresh Kumar <viresh.kumar@linaro.org>
AuthorDate:    Tue, 08 Dec 2020 09:46:55 +05:30
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Thu, 14 Jan 2021 11:20:08 +01:00

sched/core: Move schedutil_cpu_util() to core.c

There is nothing schedutil specific in schedutil_cpu_util(), move it to
core.c and define it only for CONFIG_SMP.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Link: https://lkml.kernel.org/r/c921a362c78e1324f8ebc5aaa12f53e309c5a8a2.1607400596.git.viresh.kumar@linaro.org
---
 kernel/sched/core.c              | 108 ++++++++++++++++++++++++++++++-
 kernel/sched/cpufreq_schedutil.c | 106 +-----------------------------
 kernel/sched/sched.h             |  12 +---
 3 files changed, 109 insertions(+), 117 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 15d2562..d89d682 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -5662,6 +5662,114 @@ struct task_struct *idle_task(int cpu)
 	return cpu_rq(cpu)->idle;
 }
 
+#ifdef CONFIG_SMP
+/*
+ * This function computes an effective utilization for the given CPU, to be
+ * used for frequency selection given the linear relation: f = u * f_max.
+ *
+ * The scheduler tracks the following metrics:
+ *
+ *   cpu_util_{cfs,rt,dl,irq}()
+ *   cpu_bw_dl()
+ *
+ * Where the cfs,rt and dl util numbers are tracked with the same metric and
+ * synchronized windows and are thus directly comparable.
+ *
+ * The cfs,rt,dl utilization are the running times measured with rq->clock_task
+ * which excludes things like IRQ and steal-time. These latter are then accrued
+ * in the irq utilization.
+ *
+ * The DL bandwidth number otoh is not a measured metric but a value computed
+ * based on the task model parameters and gives the minimal utilization
+ * required to meet deadlines.
+ */
+unsigned long schedutil_cpu_util(int cpu, unsigned long util_cfs,
+				 unsigned long max, enum schedutil_type type,
+				 struct task_struct *p)
+{
+	unsigned long dl_util, util, irq;
+	struct rq *rq = cpu_rq(cpu);
+
+	if (!uclamp_is_used() &&
+	    type == FREQUENCY_UTIL && rt_rq_is_runnable(&rq->rt)) {
+		return max;
+	}
+
+	/*
+	 * Early check to see if IRQ/steal time saturates the CPU, can be
+	 * because of inaccuracies in how we track these -- see
+	 * update_irq_load_avg().
+	 */
+	irq = cpu_util_irq(rq);
+	if (unlikely(irq >= max))
+		return max;
+
+	/*
+	 * Because the time spend on RT/DL tasks is visible as 'lost' time to
+	 * CFS tasks and we use the same metric to track the effective
+	 * utilization (PELT windows are synchronized) we can directly add them
+	 * to obtain the CPU's actual utilization.
+	 *
+	 * CFS and RT utilization can be boosted or capped, depending on
+	 * utilization clamp constraints requested by currently RUNNABLE
+	 * tasks.
+	 * When there are no CFS RUNNABLE tasks, clamps are released and
+	 * frequency will be gracefully reduced with the utilization decay.
+	 */
+	util = util_cfs + cpu_util_rt(rq);
+	if (type == FREQUENCY_UTIL)
+		util = uclamp_rq_util_with(rq, util, p);
+
+	dl_util = cpu_util_dl(rq);
+
+	/*
+	 * For frequency selection we do not make cpu_util_dl() a permanent part
+	 * of this sum because we want to use cpu_bw_dl() later on, but we need
+	 * to check if the CFS+RT+DL sum is saturated (ie. no idle time) such
+	 * that we select f_max when there is no idle time.
+	 *
+	 * NOTE: numerical errors or stop class might cause us to not quite hit
+	 * saturation when we should -- something for later.
+	 */
+	if (util + dl_util >= max)
+		return max;
+
+	/*
+	 * OTOH, for energy computation we need the estimated running time, so
+	 * include util_dl and ignore dl_bw.
+	 */
+	if (type == ENERGY_UTIL)
+		util += dl_util;
+
+	/*
+	 * There is still idle time; further improve the number by using the
+	 * irq metric. Because IRQ/steal time is hidden from the task clock we
+	 * need to scale the task numbers:
+	 *
+	 *              max - irq
+	 *   U' = irq + --------- * U
+	 *                 max
+	 */
+	util = scale_irq_capacity(util, irq, max);
+	util += irq;
+
+	/*
+	 * Bandwidth required by DEADLINE must always be granted while, for
+	 * FAIR and RT, we use blocked utilization of IDLE CPUs as a mechanism
+	 * to gracefully reduce the frequency when no tasks show up for longer
+	 * periods of time.
+	 *
+	 * Ideally we would like to set bw_dl as min/guaranteed freq and util +
+	 * bw_dl as requested freq. However, cpufreq is not yet ready for such
+	 * an interface. So, we only do the latter for now.
+	 */
+	if (type == FREQUENCY_UTIL)
+		util += cpu_bw_dl(rq);
+
+	return min(max, util);
+}
+#endif /* CONFIG_SMP */
+
 /**
  * find_process_by_pid - find a process with a matching PID value.
  * @pid: the pid in question.
diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
index 6931f0c..1dfa692 100644
--- a/kernel/sched/cpufreq_schedutil.c
+++ b/kernel/sched/cpufreq_schedutil.c
@@ -171,112 +171,6 @@ static unsigned int get_next_freq(struct sugov_policy *sg_policy,
 	return cpufreq_driver_resolve_freq(policy, freq);
 }
 
-/*
- * This function computes an effective utilization for the given CPU, to be
- * used for frequency selection given the linear relation: f = u * f_max.
- *
- * The scheduler tracks the following metrics:
- *
- *   cpu_util_{cfs,rt,dl,irq}()
- *   cpu_bw_dl()
- *
- * Where the cfs,rt and dl util numbers are tracked with the same metric and
- * synchronized windows and are thus directly comparable.
- *
- * The cfs,rt,dl utilization are the running times measured with rq->clock_task
- * which excludes things like IRQ and steal-time. These latter are then accrued
- * in the irq utilization.
- *
- * The DL bandwidth number otoh is not a measured metric but a value computed
- * based on the task model parameters and gives the minimal utilization
- * required to meet deadlines.
- */
-unsigned long schedutil_cpu_util(int cpu, unsigned long util_cfs,
-				 unsigned long max, enum schedutil_type type,
-				 struct task_struct *p)
-{
-	unsigned long dl_util, util, irq;
-	struct rq *rq = cpu_rq(cpu);
-
-	if (!uclamp_is_used() &&
-	    type == FREQUENCY_UTIL && rt_rq_is_runnable(&rq->rt)) {
-		return max;
-	}
-
-	/*
-	 * Early check to see if IRQ/steal time saturates the CPU, can be
-	 * because of inaccuracies in how we track these -- see
-	 * update_irq_load_avg().
-	 */
-	irq = cpu_util_irq(rq);
-	if (unlikely(irq >= max))
-		return max;
-
-	/*
-	 * Because the time spend on RT/DL tasks is visible as 'lost' time to
-	 * CFS tasks and we use the same metric to track the effective
-	 * utilization (PELT windows are synchronized) we can directly add them
-	 * to obtain the CPU's actual utilization.
-	 *
-	 * CFS and RT utilization can be boosted or capped, depending on
-	 * utilization clamp constraints requested by currently RUNNABLE
-	 * tasks.
-	 * When there are no CFS RUNNABLE tasks, clamps are released and
-	 * frequency will be gracefully reduced with the utilization decay.
-	 */
-	util = util_cfs + cpu_util_rt(rq);
-	if (type == FREQUENCY_UTIL)
-		util = uclamp_rq_util_with(rq, util, p);
-
-	dl_util = cpu_util_dl(rq);
-
-	/*
-	 * For frequency selection we do not make cpu_util_dl() a permanent part
-	 * of this sum because we want to use cpu_bw_dl() later on, but we need
-	 * to check if the CFS+RT+DL sum is saturated (ie. no idle time) such
-	 * that we select f_max when there is no idle time.
-	 *
-	 * NOTE: numerical errors or stop class might cause us to not quite hit
-	 * saturation when we should -- something for later.
-	 */
-	if (util + dl_util >= max)
-		return max;
-
-	/*
-	 * OTOH, for energy computation we need the estimated running time, so
-	 * include util_dl and ignore dl_bw.
-	 */
-	if (type == ENERGY_UTIL)
-		util += dl_util;
-
-	/*
-	 * There is still idle time; further improve the number by using the
-	 * irq metric. Because IRQ/steal time is hidden from the task clock we
-	 * need to scale the task numbers:
-	 *
-	 *              max - irq
-	 *   U' = irq + --------- * U
-	 *                 max
-	 */
-	util = scale_irq_capacity(util, irq, max);
-	util += irq;
-
-	/*
-	 * Bandwidth required by DEADLINE must always be granted while, for
-	 * FAIR and RT, we use blocked utilization of IDLE CPUs as a mechanism
-	 * to gracefully reduce the frequency when no tasks show up for longer
-	 * periods of time.
-	 *
-	 * Ideally we would like to set bw_dl as min/guaranteed freq and util +
-	 * bw_dl as requested freq. However, cpufreq is not yet ready for such
-	 * an interface. So, we only do the latter for now.
-	 */
-	if (type == FREQUENCY_UTIL)
-		util += cpu_bw_dl(rq);
-
-	return min(max, util);
-}
-
 static void sugov_get_util(struct sugov_cpu *sg_cpu)
 {
 	struct rq *rq = cpu_rq(sg_cpu->cpu);
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 12ada79..242d4c5 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -2557,7 +2557,6 @@ static inline unsigned long capacity_orig_of(int cpu)
 {
 	return cpu_rq(cpu)->cpu_capacity_orig;
 }
-#endif
 
 /**
  * enum schedutil_type - CPU utilization type
@@ -2574,8 +2573,6 @@ enum schedutil_type {
 	ENERGY_UTIL,
 };
 
-#ifdef CONFIG_CPU_FREQ_GOV_SCHEDUTIL
-
 unsigned long schedutil_cpu_util(int cpu, unsigned long util_cfs,
 				 unsigned long max, enum schedutil_type type,
 				 struct task_struct *p);
@@ -2606,14 +2603,7 @@ static inline unsigned long cpu_util_rt(struct rq *rq)
 {
 	return READ_ONCE(rq->avg_rt.util_avg);
 }
-#else /* CONFIG_CPU_FREQ_GOV_SCHEDUTIL */
-static inline unsigned long schedutil_cpu_util(int cpu, unsigned long util_cfs,
-				 unsigned long max, enum schedutil_type type,
-				 struct task_struct *p)
-{
-	return 0;
-}
-#endif /* CONFIG_CPU_FREQ_GOV_SCHEDUTIL */
+#endif
 
 #ifdef CONFIG_HAVE_SCHED_AVG_IRQ
 static inline unsigned long cpu_util_irq(struct rq *rq)
