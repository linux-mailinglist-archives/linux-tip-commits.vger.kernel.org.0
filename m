Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD8EC367B2F
	for <lists+linux-tip-commits@lfdr.de>; Thu, 22 Apr 2021 09:37:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235144AbhDVHgk (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Thu, 22 Apr 2021 03:36:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235120AbhDVHgj (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Thu, 22 Apr 2021 03:36:39 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E91CEC06174A;
        Thu, 22 Apr 2021 00:36:04 -0700 (PDT)
Date:   Thu, 22 Apr 2021 07:36:02 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1619076963;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DhU8gTzVnpg60JZuzCQAP18tLhhmqQ0I95QDutSRJBg=;
        b=ldFSCWNF5c27kSX6/ElJKlqzI5XFmXD3yEjq9sfjcVOo2f9wYUYC6v2rqmSYir6NELYZFu
        O2PYsrMH5NVkrNMqRa/RFbZH6zCeWtIT8jAZrNa4Nhp++NdCwbLINaxDO0QfDUbdHRfwVs
        vtfuk9SaKfpatCFL8axdbswLVl8ILgKPc57Zfk0sBTDJ+bRiHGpVGd/U1s42fJtiDx57px
        me/DW0kdYfNDiGK6YB8hAbONCmryPzrR4QbQGCOrpvUrzmEhHt9YcfMRDZ4zhLIIUg54oI
        whR1BD6qnWVIXkxDW9moDodnhKgCaO0purpD7eDHlcMfhB+lm7u5p8pumfX4KQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1619076963;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DhU8gTzVnpg60JZuzCQAP18tLhhmqQ0I95QDutSRJBg=;
        b=5q1ZxX0ocwgzBbf20JE4PC5wsdBG/EpZmZK7vaCn50RdhBdM6NyjaOK0AiuX7smys2v2BL
        LfTzPnkAF+eM1DBg==
From:   "tip-bot2 for Paul Turner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched: Warn on long periods of pending need_resched
Cc:     Paul Turner <pjt@google.com>, Josh Don <joshdon@google.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210416212936.390566-1-joshdon@google.com>
References: <20210416212936.390566-1-joshdon@google.com>
MIME-Version: 1.0
Message-ID: <161907696286.29796.5382200918025426403.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     c006fac556e401a62054d065da168099ea5a5b10
Gitweb:        https://git.kernel.org/tip/c006fac556e401a62054d065da168099ea5a5b10
Author:        Paul Turner <pjt@google.com>
AuthorDate:    Fri, 16 Apr 2021 14:29:36 -07:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 21 Apr 2021 13:55:41 +02:00

sched: Warn on long periods of pending need_resched

CPU scheduler marks need_resched flag to signal a schedule() on a
particular CPU. But, schedule() may not happen immediately in cases
where the current task is executing in the kernel mode (no
preemption state) for extended periods of time.

This patch adds a warn_on if need_resched is pending for more than the
time specified in sysctl resched_latency_warn_ms. If it goes off, it is
likely that there is a missing cond_resched() somewhere. Monitoring is
done via the tick and the accuracy is hence limited to jiffy scale. This
also means that we won't trigger the warning if the tick is disabled.

This feature (LATENCY_WARN) is default disabled.

Signed-off-by: Paul Turner <pjt@google.com>
Signed-off-by: Josh Don <joshdon@google.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20210416212936.390566-1-joshdon@google.com
---
 include/linux/sched/sysctl.h |  3 ++-
 kernel/sched/core.c          | 70 ++++++++++++++++++++++++++++++++++-
 kernel/sched/debug.c         | 13 +++++++-
 kernel/sched/features.h      |  2 +-
 kernel/sched/sched.h         | 10 +++++-
 5 files changed, 97 insertions(+), 1 deletion(-)

diff --git a/include/linux/sched/sysctl.h b/include/linux/sched/sysctl.h
index 0a3f346..db2c0f3 100644
--- a/include/linux/sched/sysctl.h
+++ b/include/linux/sched/sysctl.h
@@ -48,6 +48,9 @@ extern unsigned int sysctl_numa_balancing_scan_size;
 #ifdef CONFIG_SCHED_DEBUG
 extern __read_mostly unsigned int sysctl_sched_migration_cost;
 extern __read_mostly unsigned int sysctl_sched_nr_migrate;
+
+extern int sysctl_resched_latency_warn_ms;
+extern int sysctl_resched_latency_warn_once;
 #endif
 
 /*
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index e6c714b..fcb35ae 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -58,7 +58,17 @@ const_debug unsigned int sysctl_sched_features =
 #include "features.h"
 	0;
 #undef SCHED_FEAT
-#endif
+
+/*
+ * Print a warning if need_resched is set for the given duration (if
+ * LATENCY_WARN is enabled).
+ *
+ * If sysctl_resched_latency_warn_once is set, only one warning will be shown
+ * per boot.
+ */
+__read_mostly int sysctl_resched_latency_warn_ms = 100;
+__read_mostly int sysctl_resched_latency_warn_once = 1;
+#endif /* CONFIG_SCHED_DEBUG */
 
 /*
  * Number of tasks to iterate in a single balance run.
@@ -4527,6 +4537,55 @@ unsigned long long task_sched_runtime(struct task_struct *p)
 	return ns;
 }
 
+#ifdef CONFIG_SCHED_DEBUG
+static u64 cpu_resched_latency(struct rq *rq)
+{
+	int latency_warn_ms = READ_ONCE(sysctl_resched_latency_warn_ms);
+	u64 resched_latency, now = rq_clock(rq);
+	static bool warned_once;
+
+	if (sysctl_resched_latency_warn_once && warned_once)
+		return 0;
+
+	if (!need_resched() || !latency_warn_ms)
+		return 0;
+
+	if (system_state == SYSTEM_BOOTING)
+		return 0;
+
+	if (!rq->last_seen_need_resched_ns) {
+		rq->last_seen_need_resched_ns = now;
+		rq->ticks_without_resched = 0;
+		return 0;
+	}
+
+	rq->ticks_without_resched++;
+	resched_latency = now - rq->last_seen_need_resched_ns;
+	if (resched_latency <= latency_warn_ms * NSEC_PER_MSEC)
+		return 0;
+
+	warned_once = true;
+
+	return resched_latency;
+}
+
+static int __init setup_resched_latency_warn_ms(char *str)
+{
+	long val;
+
+	if ((kstrtol(str, 0, &val))) {
+		pr_warn("Unable to set resched_latency_warn_ms\n");
+		return 1;
+	}
+
+	sysctl_resched_latency_warn_ms = val;
+	return 1;
+}
+__setup("resched_latency_warn_ms=", setup_resched_latency_warn_ms);
+#else
+static inline u64 cpu_resched_latency(struct rq *rq) { return 0; }
+#endif /* CONFIG_SCHED_DEBUG */
+
 /*
  * This function gets called by the timer code, with HZ frequency.
  * We call it with interrupts disabled.
@@ -4538,6 +4597,7 @@ void scheduler_tick(void)
 	struct task_struct *curr = rq->curr;
 	struct rq_flags rf;
 	unsigned long thermal_pressure;
+	u64 resched_latency;
 
 	arch_scale_freq_tick();
 	sched_clock_tick();
@@ -4548,10 +4608,15 @@ void scheduler_tick(void)
 	thermal_pressure = arch_scale_thermal_pressure(cpu_of(rq));
 	update_thermal_load_avg(rq_clock_thermal(rq), rq, thermal_pressure);
 	curr->sched_class->task_tick(rq, curr, 0);
+	if (sched_feat(LATENCY_WARN))
+		resched_latency = cpu_resched_latency(rq);
 	calc_global_load_tick(rq);
 
 	rq_unlock(rq, &rf);
 
+	if (sched_feat(LATENCY_WARN) && resched_latency)
+		resched_latency_warn(cpu, resched_latency);
+
 	perf_event_task_tick();
 
 #ifdef CONFIG_SMP
@@ -5046,6 +5111,9 @@ static void __sched notrace __schedule(bool preempt)
 	next = pick_next_task(rq, prev, &rf);
 	clear_tsk_need_resched(prev);
 	clear_preempt_need_resched();
+#ifdef CONFIG_SCHED_DEBUG
+	rq->last_seen_need_resched_ns = 0;
+#endif
 
 	if (likely(prev != next)) {
 		rq->nr_switches++;
diff --git a/kernel/sched/debug.c b/kernel/sched/debug.c
index 461342f..7251fc4 100644
--- a/kernel/sched/debug.c
+++ b/kernel/sched/debug.c
@@ -309,6 +309,9 @@ static __init int sched_init_debug(void)
 	debugfs_create_u32("min_granularity_ns", 0644, debugfs_sched, &sysctl_sched_min_granularity);
 	debugfs_create_u32("wakeup_granularity_ns", 0644, debugfs_sched, &sysctl_sched_wakeup_granularity);
 
+	debugfs_create_u32("latency_warn_ms", 0644, debugfs_sched, &sysctl_resched_latency_warn_ms);
+	debugfs_create_u32("latency_warn_once", 0644, debugfs_sched, &sysctl_resched_latency_warn_once);
+
 #ifdef CONFIG_SMP
 	debugfs_create_file("tunable_scaling", 0644, debugfs_sched, NULL, &sched_scaling_fops);
 	debugfs_create_u32("migration_cost_ns", 0644, debugfs_sched, &sysctl_sched_migration_cost);
@@ -1027,3 +1030,13 @@ void proc_sched_set_task(struct task_struct *p)
 	memset(&p->se.statistics, 0, sizeof(p->se.statistics));
 #endif
 }
+
+void resched_latency_warn(int cpu, u64 latency)
+{
+	static DEFINE_RATELIMIT_STATE(latency_check_ratelimit, 60 * 60 * HZ, 1);
+
+	WARN(__ratelimit(&latency_check_ratelimit),
+	     "sched: CPU %d need_resched set for > %llu ns (%d ticks) "
+	     "without schedule\n",
+	     cpu, latency, cpu_rq(cpu)->ticks_without_resched);
+}
diff --git a/kernel/sched/features.h b/kernel/sched/features.h
index 011c5ec..7f8dace 100644
--- a/kernel/sched/features.h
+++ b/kernel/sched/features.h
@@ -91,5 +91,7 @@ SCHED_FEAT(WA_BIAS, true)
 SCHED_FEAT(UTIL_EST, true)
 SCHED_FEAT(UTIL_EST_FASTUP, true)
 
+SCHED_FEAT(LATENCY_WARN, false)
+
 SCHED_FEAT(ALT_PERIOD, true)
 SCHED_FEAT(BASE_SLICE, true)
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index bde7248..a189bec 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -58,6 +58,7 @@
 #include <linux/prefetch.h>
 #include <linux/profile.h>
 #include <linux/psi.h>
+#include <linux/ratelimit.h>
 #include <linux/rcupdate_wait.h>
 #include <linux/security.h>
 #include <linux/stop_machine.h>
@@ -971,6 +972,11 @@ struct rq {
 
 	atomic_t		nr_iowait;
 
+#ifdef CONFIG_SCHED_DEBUG
+	u64 last_seen_need_resched_ns;
+	int ticks_without_resched;
+#endif
+
 #ifdef CONFIG_MEMBARRIER
 	int membarrier_state;
 #endif
@@ -2371,6 +2377,8 @@ extern void print_dl_stats(struct seq_file *m, int cpu);
 extern void print_cfs_rq(struct seq_file *m, int cpu, struct cfs_rq *cfs_rq);
 extern void print_rt_rq(struct seq_file *m, int cpu, struct rt_rq *rt_rq);
 extern void print_dl_rq(struct seq_file *m, int cpu, struct dl_rq *dl_rq);
+
+extern void resched_latency_warn(int cpu, u64 latency);
 #ifdef CONFIG_NUMA_BALANCING
 extern void
 show_numa_stats(struct task_struct *p, struct seq_file *m);
@@ -2378,6 +2386,8 @@ extern void
 print_numa_stats(struct seq_file *m, int node, unsigned long tsf,
 	unsigned long tpf, unsigned long gsf, unsigned long gpf);
 #endif /* CONFIG_NUMA_BALANCING */
+#else
+static inline void resched_latency_warn(int cpu, u64 latency) {}
 #endif /* CONFIG_SCHED_DEBUG */
 
 extern void init_cfs_rq(struct cfs_rq *cfs_rq);
