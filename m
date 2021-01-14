Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 28B602F5FFA
	for <lists+linux-tip-commits@lfdr.de>; Thu, 14 Jan 2021 12:31:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725955AbhANL3w (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Thu, 14 Jan 2021 06:29:52 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:59020 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728569AbhANL3v (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Thu, 14 Jan 2021 06:29:51 -0500
Date:   Thu, 14 Jan 2021 11:29:07 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1610623747;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QDFaOxf2XcvNCvGVhyzQyEdMku6ngiVRa2B8JnboYXo=;
        b=EB6wGXqGumbQJzwvPZtWovGnckgR4IFk4or3z91txHf+mpdQph4XCy0KyUkVW5ANmwHsgq
        MCz8sKqI4GhYYvdnPh7wjgu7G80UFYybKDmEbh6Oii80/JqQGkmuqB746S5wkPqfVk86c3
        IPUCPPeuRBTGNHgCU19SAL4Ddvs3592HUwnY9M5b2yBlDzNz7o63CSDs6ujXaTcDG2sQ2w
        OMxlr20kFOB3qEGNdwA8V+GQ49UMQfhbqPxQX4nqZQHLZWRAZHTZfsnvBm2N0Ad/eeaPZ0
        BIe/Z1XLRfWnKBmgDovcgF7HQnKMGtGac9WKX1wsmH2Cvp41dAWHoWCnOAIUkw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1610623747;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QDFaOxf2XcvNCvGVhyzQyEdMku6ngiVRa2B8JnboYXo=;
        b=U9i3v5qkM8WUMHF2lWhhf0T0NsIKDg5va2+68ubMeVOQQtanF3PY2LoKFNgY7Zb3FKbKw/
        eXJUIhpgQnzpMRDg==
From:   "tip-bot2 for Viresh Kumar" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] thermal: cpufreq_cooling: Reuse sched_cpu_util()
 for SMP platforms
Cc:     Viresh Kumar <viresh.kumar@linaro.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Lukasz Luba <lukasz.luba@arm.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: =?utf-8?q?=3C9c255c83d78d58451abc06848001faef94c87a12=2E16074?=
 =?utf-8?q?00596=2Egit=2Eviresh=2Ekumar=40linaro=2Eorg=3E?=
References: =?utf-8?q?=3C9c255c83d78d58451abc06848001faef94c87a12=2E160740?=
 =?utf-8?q?0596=2Egit=2Eviresh=2Ekumar=40linaro=2Eorg=3E?=
MIME-Version: 1.0
Message-ID: <161062374702.414.16932548157501101438.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     d1515851ca075ed98fe78ac6abf24ba2dd25a63b
Gitweb:        https://git.kernel.org/tip/d1515851ca075ed98fe78ac6abf24ba2dd25a63b
Author:        Viresh Kumar <viresh.kumar@linaro.org>
AuthorDate:    Tue, 08 Dec 2020 09:46:57 +05:30
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Thu, 14 Jan 2021 11:20:09 +01:00

thermal: cpufreq_cooling: Reuse sched_cpu_util() for SMP platforms

Several parts of the kernel are already using the effective CPU
utilization (as seen by the scheduler) to get the current load on the
CPU, do the same here instead of depending on the idle time of the CPU,
which isn't that accurate comparatively.

This is also the right thing to do as it makes the cpufreq governor
(schedutil) align better with the cpufreq_cooling driver, as the power
requested by cpufreq_cooling governor will exactly match the next
frequency requested by the schedutil governor since they are both using
the same metric to calculate load.

This was tested on ARM Hikey6220 platform with hackbench, sysbench and
schbench. None of them showed any regression or significant
improvements. Schbench is the most important ones out of these as it
creates the scenario where the utilization numbers provide a better
estimate of the future.

Scenario 1: The CPUs were mostly idle in the previous polling window of
the IPA governor as the tasks were sleeping and here are the details
from traces (load is in %):

 Old: thermal_power_cpu_get_power: cpus=00000000,000000ff freq=1200000 total_load=203 load={{0x35,0x1,0x0,0x31,0x0,0x0,0x64,0x0}} dynamic_power=1339
 New: thermal_power_cpu_get_power: cpus=00000000,000000ff freq=1200000 total_load=600 load={{0x60,0x46,0x45,0x45,0x48,0x3b,0x61,0x44}} dynamic_power=3960

Here, the "Old" line gives the load and requested_power (dynamic_power
here) numbers calculated using the idle time based implementation, while
"New" is based on the CPU utilization from scheduler.

As can be clearly seen, the load and requested_power numbers are simply
incorrect in the idle time based approach and the numbers collected from
CPU's utilization are much closer to the reality.

Scenario 2: The CPUs were busy in the previous polling window of the IPA
governor:

 Old: thermal_power_cpu_get_power: cpus=00000000,000000ff freq=1200000 total_load=800 load={{0x64,0x64,0x64,0x64,0x64,0x64,0x64,0x64}} dynamic_power=5280
 New: thermal_power_cpu_get_power: cpus=00000000,000000ff freq=1200000 total_load=708 load={{0x4d,0x5c,0x5c,0x5b,0x5c,0x5c,0x51,0x5b}} dynamic_power=4672

As can be seen, the idle time based load is 100% for all the CPUs as it
took only the last window into account, but in reality the CPUs aren't
that loaded as shown by the utilization numbers.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Lukasz Luba <lukasz.luba@arm.com>
Link: https://lkml.kernel.org/r/9c255c83d78d58451abc06848001faef94c87a12.1607400596.git.viresh.kumar@linaro.org
---
 drivers/thermal/cpufreq_cooling.c | 69 +++++++++++++++++++++++-------
 1 file changed, 55 insertions(+), 14 deletions(-)

diff --git a/drivers/thermal/cpufreq_cooling.c b/drivers/thermal/cpufreq_cooling.c
index 612f063..f5af257 100644
--- a/drivers/thermal/cpufreq_cooling.c
+++ b/drivers/thermal/cpufreq_cooling.c
@@ -76,7 +76,9 @@ struct cpufreq_cooling_device {
 	struct em_perf_domain *em;
 	struct cpufreq_policy *policy;
 	struct list_head node;
+#ifndef CONFIG_SMP
 	struct time_in_idle *idle_time;
+#endif
 	struct freq_qos_request qos_req;
 };
 
@@ -132,14 +134,25 @@ static u32 cpu_power_to_freq(struct cpufreq_cooling_device *cpufreq_cdev,
 }
 
 /**
- * get_load() - get load for a cpu since last updated
- * @cpufreq_cdev:	&struct cpufreq_cooling_device for this cpu
- * @cpu:	cpu number
- * @cpu_idx:	index of the cpu in time_in_idle*
+ * get_load() - get load for a cpu
+ * @cpufreq_cdev: struct cpufreq_cooling_device for the cpu
+ * @cpu: cpu number
+ * @cpu_idx: index of the cpu in time_in_idle array
  *
  * Return: The average load of cpu @cpu in percentage since this
  * function was last called.
  */
+#ifdef CONFIG_SMP
+static u32 get_load(struct cpufreq_cooling_device *cpufreq_cdev, int cpu,
+		    int cpu_idx)
+{
+	unsigned long max = arch_scale_cpu_capacity(cpu);
+	unsigned long util;
+
+	util = sched_cpu_util(cpu, max);
+	return (util * 100) / max;
+}
+#else /* !CONFIG_SMP */
 static u32 get_load(struct cpufreq_cooling_device *cpufreq_cdev, int cpu,
 		    int cpu_idx)
 {
@@ -161,6 +174,7 @@ static u32 get_load(struct cpufreq_cooling_device *cpufreq_cdev, int cpu,
 
 	return load;
 }
+#endif /* CONFIG_SMP */
 
 /**
  * get_dynamic_power() - calculate the dynamic power
@@ -346,6 +360,36 @@ static inline bool em_is_sane(struct cpufreq_cooling_device *cpufreq_cdev,
 }
 #endif /* CONFIG_THERMAL_GOV_POWER_ALLOCATOR */
 
+#ifdef CONFIG_SMP
+static inline int allocate_idle_time(struct cpufreq_cooling_device *cpufreq_cdev)
+{
+	return 0;
+}
+
+static inline void free_idle_time(struct cpufreq_cooling_device *cpufreq_cdev)
+{
+}
+#else
+static int allocate_idle_time(struct cpufreq_cooling_device *cpufreq_cdev)
+{
+	unsigned int num_cpus = cpumask_weight(cpufreq_cdev->policy->related_cpus);
+
+	cpufreq_cdev->idle_time = kcalloc(num_cpus,
+					  sizeof(*cpufreq_cdev->idle_time),
+					  GFP_KERNEL);
+	if (!cpufreq_cdev->idle_time)
+		return -ENOMEM;
+
+	return 0;
+}
+
+static void free_idle_time(struct cpufreq_cooling_device *cpufreq_cdev)
+{
+	kfree(cpufreq_cdev->idle_time);
+	cpufreq_cdev->idle_time = NULL;
+}
+#endif /* CONFIG_SMP */
+
 static unsigned int get_state_freq(struct cpufreq_cooling_device *cpufreq_cdev,
 				   unsigned long state)
 {
@@ -485,7 +529,7 @@ __cpufreq_cooling_register(struct device_node *np,
 	struct thermal_cooling_device *cdev;
 	struct cpufreq_cooling_device *cpufreq_cdev;
 	char dev_name[THERMAL_NAME_LENGTH];
-	unsigned int i, num_cpus;
+	unsigned int i;
 	struct device *dev;
 	int ret;
 	struct thermal_cooling_device_ops *cooling_ops;
@@ -496,7 +540,6 @@ __cpufreq_cooling_register(struct device_node *np,
 		return ERR_PTR(-ENODEV);
 	}
 
-
 	if (IS_ERR_OR_NULL(policy)) {
 		pr_err("%s: cpufreq policy isn't valid: %p\n", __func__, policy);
 		return ERR_PTR(-EINVAL);
@@ -514,12 +557,10 @@ __cpufreq_cooling_register(struct device_node *np,
 		return ERR_PTR(-ENOMEM);
 
 	cpufreq_cdev->policy = policy;
-	num_cpus = cpumask_weight(policy->related_cpus);
-	cpufreq_cdev->idle_time = kcalloc(num_cpus,
-					 sizeof(*cpufreq_cdev->idle_time),
-					 GFP_KERNEL);
-	if (!cpufreq_cdev->idle_time) {
-		cdev = ERR_PTR(-ENOMEM);
+
+	ret = allocate_idle_time(cpufreq_cdev);
+	if (ret) {
+		cdev = ERR_PTR(ret);
 		goto free_cdev;
 	}
 
@@ -579,7 +620,7 @@ remove_qos_req:
 remove_ida:
 	ida_simple_remove(&cpufreq_ida, cpufreq_cdev->id);
 free_idle_time:
-	kfree(cpufreq_cdev->idle_time);
+	free_idle_time(cpufreq_cdev);
 free_cdev:
 	kfree(cpufreq_cdev);
 	return cdev;
@@ -672,7 +713,7 @@ void cpufreq_cooling_unregister(struct thermal_cooling_device *cdev)
 	thermal_cooling_device_unregister(cdev);
 	freq_qos_remove_request(&cpufreq_cdev->qos_req);
 	ida_simple_remove(&cpufreq_ida, cpufreq_cdev->id);
-	kfree(cpufreq_cdev->idle_time);
+	free_idle_time(cpufreq_cdev);
 	kfree(cpufreq_cdev);
 }
 EXPORT_SYMBOL_GPL(cpufreq_cooling_unregister);
