Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 358932F600F
	for <lists+linux-tip-commits@lfdr.de>; Thu, 14 Jan 2021 12:31:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728964AbhANLar (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Thu, 14 Jan 2021 06:30:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728814AbhANLaY (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Thu, 14 Jan 2021 06:30:24 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 184C1C061795;
        Thu, 14 Jan 2021 03:29:10 -0800 (PST)
Date:   Thu, 14 Jan 2021 11:29:07 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1610623747;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Jj5vVRZBtqnAfJy8dky3jq/Os8/iyU/xJg/chTv7SsA=;
        b=aK3aCvM+ahNYXS6Yz6/yXANQKHYTsMxvd+b1AVU1N1jlcqm7Ktx+rbz75dRUrHjb2/l9hf
        aXBflEvgeTI/MMVBdQ9ZN4mgfcbl9/W6F/key6fTdJWfMiMGe9LKjbA2HKdC3c4LiPkghJ
        BJjhqR9/MDriWCOnloAql3oShlHeqBtTUxOJCY7n18dBjqrJc4MygCNfgfgbw2A/lGpbDZ
        0n9pdQJEHJm4nopY8Mp4Vleu04DBsVdzAwSMbF9v80ItgdA5WgVV+UMk02mnm+Quemq2G8
        fcp6zqe5ozCLxB+xNbxuGzcbmlfq30ISNWVb9ZqQFotnShJ2WZHzE3bl0KnZyA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1610623747;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Jj5vVRZBtqnAfJy8dky3jq/Os8/iyU/xJg/chTv7SsA=;
        b=dxuak0e6332AD6l+w3H84GwpNhmeb4r39LnYw02gJx53Fl0xHlcLeNYT98QCPkSglIojko
        7MTXr9VZEB54oKBg==
From:   "tip-bot2 for Viresh Kumar" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/core: Rename schedutil_cpu_util() and allow
 rest of the kernel to use it
Cc:     Viresh Kumar <viresh.kumar@linaro.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: =?utf-8?q?=3Cdb011961fb3bb8bef1c0eda5cd64564637d3ef31=2E16074?=
 =?utf-8?q?00596=2Egit=2Eviresh=2Ekumar=40linaro=2Eorg=3E?=
References: =?utf-8?q?=3Cdb011961fb3bb8bef1c0eda5cd64564637d3ef31=2E160740?=
 =?utf-8?q?0596=2Egit=2Eviresh=2Ekumar=40linaro=2Eorg=3E?=
MIME-Version: 1.0
Message-ID: <161062374723.414.15375550750639828007.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     a5418be9dffe70ccbb0b4bd5ea3881c81927e965
Gitweb:        https://git.kernel.org/tip/a5418be9dffe70ccbb0b4bd5ea3881c81927e965
Author:        Viresh Kumar <viresh.kumar@linaro.org>
AuthorDate:    Tue, 08 Dec 2020 09:46:56 +05:30
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Thu, 14 Jan 2021 11:20:09 +01:00

sched/core: Rename schedutil_cpu_util() and allow rest of the kernel to use it

There is nothing schedutil specific in schedutil_cpu_util(), rename it
to effective_cpu_util(). Also create and expose another wrapper
sched_cpu_util() which can be used by other parts of the kernel, like
thermal core (that will be done in a later commit).

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Link: https://lkml.kernel.org/r/db011961fb3bb8bef1c0eda5cd64564637d3ef31.1607400596.git.viresh.kumar@linaro.org
---
 include/linux/sched.h            |  5 +++++
 kernel/sched/core.c              | 10 ++++++++--
 kernel/sched/cpufreq_schedutil.c |  2 +-
 kernel/sched/fair.c              |  6 +++---
 kernel/sched/sched.h             | 10 +++++-----
 5 files changed, 22 insertions(+), 11 deletions(-)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index 6e3a5ee..31169e7 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1968,6 +1968,11 @@ extern long sched_getaffinity(pid_t pid, struct cpumask *mask);
 #define TASK_SIZE_OF(tsk)	TASK_SIZE
 #endif
 
+#ifdef CONFIG_SMP
+/* Returns effective CPU energy utilization, as seen by the scheduler */
+unsigned long sched_cpu_util(int cpu, unsigned long max);
+#endif /* CONFIG_SMP */
+
 #ifdef CONFIG_RSEQ
 
 /*
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index d89d682..4fe4cbf 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -5683,8 +5683,8 @@ struct task_struct *idle_task(int cpu)
  * based on the task model parameters and gives the minimal utilization
  * required to meet deadlines.
  */
-unsigned long schedutil_cpu_util(int cpu, unsigned long util_cfs,
-				 unsigned long max, enum schedutil_type type,
+unsigned long effective_cpu_util(int cpu, unsigned long util_cfs,
+				 unsigned long max, enum cpu_util_type type,
 				 struct task_struct *p)
 {
 	unsigned long dl_util, util, irq;
@@ -5768,6 +5768,12 @@ unsigned long schedutil_cpu_util(int cpu, unsigned long util_cfs,
 
 	return min(max, util);
 }
+
+unsigned long sched_cpu_util(int cpu, unsigned long max)
+{
+	return effective_cpu_util(cpu, cpu_util_cfs(cpu_rq(cpu)), max,
+				  ENERGY_UTIL, NULL);
+}
 #endif /* CONFIG_SMP */
 
 /**
diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
index 1dfa692..41e498b 100644
--- a/kernel/sched/cpufreq_schedutil.c
+++ b/kernel/sched/cpufreq_schedutil.c
@@ -178,7 +178,7 @@ static void sugov_get_util(struct sugov_cpu *sg_cpu)
 
 	sg_cpu->max = max;
 	sg_cpu->bw_dl = cpu_bw_dl(rq);
-	sg_cpu->util = schedutil_cpu_util(sg_cpu->cpu, cpu_util_cfs(rq), max,
+	sg_cpu->util = effective_cpu_util(sg_cpu->cpu, cpu_util_cfs(rq), max,
 					  FREQUENCY_UTIL, NULL);
 }
 
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 04a3ce2..39c5bda 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -6543,7 +6543,7 @@ compute_energy(struct task_struct *p, int dst_cpu, struct perf_domain *pd)
 		 * is already enough to scale the EM reported power
 		 * consumption at the (eventually clamped) cpu_capacity.
 		 */
-		sum_util += schedutil_cpu_util(cpu, util_cfs, cpu_cap,
+		sum_util += effective_cpu_util(cpu, util_cfs, cpu_cap,
 					       ENERGY_UTIL, NULL);
 
 		/*
@@ -6553,7 +6553,7 @@ compute_energy(struct task_struct *p, int dst_cpu, struct perf_domain *pd)
 		 * NOTE: in case RT tasks are running, by default the
 		 * FREQUENCY_UTIL's utilization can be max OPP.
 		 */
-		cpu_util = schedutil_cpu_util(cpu, util_cfs, cpu_cap,
+		cpu_util = effective_cpu_util(cpu, util_cfs, cpu_cap,
 					      FREQUENCY_UTIL, tsk);
 		max_util = max(max_util, cpu_util);
 	}
@@ -6651,7 +6651,7 @@ static int find_energy_efficient_cpu(struct task_struct *p, int prev_cpu)
 			 * IOW, placing the task there would make the CPU
 			 * overutilized. Take uclamp into account to see how
 			 * much capacity we can get out of the CPU; this is
-			 * aligned with schedutil_cpu_util().
+			 * aligned with sched_cpu_util().
 			 */
 			util = uclamp_rq_util_with(cpu_rq(cpu), util, p);
 			if (!fits_capacity(util, cpu_cap))
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 242d4c5..045b010 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -2559,22 +2559,22 @@ static inline unsigned long capacity_orig_of(int cpu)
 }
 
 /**
- * enum schedutil_type - CPU utilization type
+ * enum cpu_util_type - CPU utilization type
  * @FREQUENCY_UTIL:	Utilization used to select frequency
  * @ENERGY_UTIL:	Utilization used during energy calculation
  *
  * The utilization signals of all scheduling classes (CFS/RT/DL) and IRQ time
  * need to be aggregated differently depending on the usage made of them. This
- * enum is used within schedutil_freq_util() to differentiate the types of
+ * enum is used within effective_cpu_util() to differentiate the types of
  * utilization expected by the callers, and adjust the aggregation accordingly.
  */
-enum schedutil_type {
+enum cpu_util_type {
 	FREQUENCY_UTIL,
 	ENERGY_UTIL,
 };
 
-unsigned long schedutil_cpu_util(int cpu, unsigned long util_cfs,
-				 unsigned long max, enum schedutil_type type,
+unsigned long effective_cpu_util(int cpu, unsigned long util_cfs,
+				 unsigned long max, enum cpu_util_type type,
 				 struct task_struct *p);
 
 static inline unsigned long cpu_bw_dl(struct rq *rq)
