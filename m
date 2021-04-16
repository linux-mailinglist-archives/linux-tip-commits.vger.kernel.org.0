Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3604A362493
	for <lists+linux-tip-commits@lfdr.de>; Fri, 16 Apr 2021 17:55:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236214AbhDPPyR (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 16 Apr 2021 11:54:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235976AbhDPPyJ (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 16 Apr 2021 11:54:09 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D88DDC061756;
        Fri, 16 Apr 2021 08:53:44 -0700 (PDT)
Date:   Fri, 16 Apr 2021 15:53:42 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1618588423;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UhW2gRea8qcyEIBHPmVodnEM2KLLrp/GfJ7mLerg8eo=;
        b=WzkuTLZrVcUfqxOMkQo0tsRoiEIvlMJMM3UNCrnPSKTdE35/LapmpctSrXz/NPlqDXxYlV
        jC6ML1o4rsf9lCUK9Vc62o3vWkbSeIi0TGBjHup7lJhIpdnlyHYCkXANf+BLivHE5vTWe+
        8Sc2vmIMmq05NSj32E1F1ro0yseSaP3wkOGLifOT5a8uWuO/eM1JfkBQtoflWY1fipdvUL
        DxI2U1+Jr0FUUqBVy3wmyKr/og2i6oyS1qGsGLWe6kHrgafkOvoeqJGeXPQHI5hTm6Brhf
        KYBwJP61MaGQh4clPG0F7J3YCwekuNd9v3tLB6yEM2G6wR1ra/895iu7kR/6gw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1618588423;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UhW2gRea8qcyEIBHPmVodnEM2KLLrp/GfJ7mLerg8eo=;
        b=17DS8q0nGa6CoDZRQBP9kHDE+R0ci33w3PtNqchAURt3BeWqmTUUL/xfC8bTDBuZIMnEV8
        uZONypMUg+zFIVDw==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched: Move SCHED_DEBUG sysctl to debugfs
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20210412102001.287610138@infradead.org>
References: <20210412102001.287610138@infradead.org>
MIME-Version: 1.0
Message-ID: <161858842284.29796.3853677323211839924.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     8a99b6833c884fa0e7919030d93fecedc69fc625
Gitweb:        https://git.kernel.org/tip/8a99b6833c884fa0e7919030d93fecedc69fc625
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Wed, 24 Mar 2021 11:43:21 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 16 Apr 2021 17:06:34 +02:00

sched: Move SCHED_DEBUG sysctl to debugfs

Stop polluting sysctl with undocumented knobs that really are debug
only, move them all to /debug/sched/ along with the existing
/debug/sched_* files that already exist.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Tested-by: Valentin Schneider <valentin.schneider@arm.com>
Link: https://lkml.kernel.org/r/20210412102001.287610138@infradead.org
---
 include/linux/sched/sysctl.h |  8 +--
 kernel/sched/core.c          |  4 +-
 kernel/sched/debug.c         | 74 +++++++++++++++++++++++++--
 kernel/sched/fair.c          |  9 +---
 kernel/sched/sched.h         |  2 +-
 kernel/sysctl.c              | 96 +-----------------------------------
 6 files changed, 80 insertions(+), 113 deletions(-)

diff --git a/include/linux/sched/sysctl.h b/include/linux/sched/sysctl.h
index 3c31ba8..0a3f346 100644
--- a/include/linux/sched/sysctl.h
+++ b/include/linux/sched/sysctl.h
@@ -26,10 +26,11 @@ int proc_dohung_task_timeout_secs(struct ctl_table *table, int write,
 enum { sysctl_hung_task_timeout_secs = 0 };
 #endif
 
+extern unsigned int sysctl_sched_child_runs_first;
+
 extern unsigned int sysctl_sched_latency;
 extern unsigned int sysctl_sched_min_granularity;
 extern unsigned int sysctl_sched_wakeup_granularity;
-extern unsigned int sysctl_sched_child_runs_first;
 
 enum sched_tunable_scaling {
 	SCHED_TUNABLESCALING_NONE,
@@ -37,7 +38,7 @@ enum sched_tunable_scaling {
 	SCHED_TUNABLESCALING_LINEAR,
 	SCHED_TUNABLESCALING_END,
 };
-extern enum sched_tunable_scaling sysctl_sched_tunable_scaling;
+extern unsigned int sysctl_sched_tunable_scaling;
 
 extern unsigned int sysctl_numa_balancing_scan_delay;
 extern unsigned int sysctl_numa_balancing_scan_period_min;
@@ -47,9 +48,6 @@ extern unsigned int sysctl_numa_balancing_scan_size;
 #ifdef CONFIG_SCHED_DEBUG
 extern __read_mostly unsigned int sysctl_sched_migration_cost;
 extern __read_mostly unsigned int sysctl_sched_nr_migrate;
-
-int sched_proc_update_handler(struct ctl_table *table, int write,
-		void *buffer, size_t *length, loff_t *ppos);
 #endif
 
 /*
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 7d031da..bac30db 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -5504,9 +5504,11 @@ static const struct file_operations sched_dynamic_fops = {
 	.release	= single_release,
 };
 
+extern struct dentry *debugfs_sched;
+
 static __init int sched_init_debug_dynamic(void)
 {
-	debugfs_create_file("sched_preempt", 0644, NULL, NULL, &sched_dynamic_fops);
+	debugfs_create_file("sched_preempt", 0644, debugfs_sched, NULL, &sched_dynamic_fops);
 	return 0;
 }
 late_initcall(sched_init_debug_dynamic);
diff --git a/kernel/sched/debug.c b/kernel/sched/debug.c
index 4b49cc2..2093b90 100644
--- a/kernel/sched/debug.c
+++ b/kernel/sched/debug.c
@@ -169,15 +169,81 @@ static const struct file_operations sched_feat_fops = {
 	.release	= single_release,
 };
 
+#ifdef CONFIG_SMP
+
+static ssize_t sched_scaling_write(struct file *filp, const char __user *ubuf,
+				   size_t cnt, loff_t *ppos)
+{
+	char buf[16];
+
+	if (cnt > 15)
+		cnt = 15;
+
+	if (copy_from_user(&buf, ubuf, cnt))
+		return -EFAULT;
+
+	if (kstrtouint(buf, 10, &sysctl_sched_tunable_scaling))
+		return -EINVAL;
+
+	if (sched_update_scaling())
+		return -EINVAL;
+
+	*ppos += cnt;
+	return cnt;
+}
+
+static int sched_scaling_show(struct seq_file *m, void *v)
+{
+	seq_printf(m, "%d\n", sysctl_sched_tunable_scaling);
+	return 0;
+}
+
+static int sched_scaling_open(struct inode *inode, struct file *filp)
+{
+	return single_open(filp, sched_scaling_show, NULL);
+}
+
+static const struct file_operations sched_scaling_fops = {
+	.open		= sched_scaling_open,
+	.write		= sched_scaling_write,
+	.read		= seq_read,
+	.llseek		= seq_lseek,
+	.release	= single_release,
+};
+
+#endif /* SMP */
+
 __read_mostly bool sched_debug_enabled;
 
+struct dentry *debugfs_sched;
+
 static __init int sched_init_debug(void)
 {
-	debugfs_create_file("sched_features", 0644, NULL, NULL,
-			&sched_feat_fops);
+	struct dentry __maybe_unused *numa;
 
-	debugfs_create_bool("sched_debug", 0644, NULL,
-			&sched_debug_enabled);
+	debugfs_sched = debugfs_create_dir("sched", NULL);
+
+	debugfs_create_file("features", 0644, debugfs_sched, NULL, &sched_feat_fops);
+	debugfs_create_bool("debug_enabled", 0644, debugfs_sched, &sched_debug_enabled);
+
+	debugfs_create_u32("latency_ns", 0644, debugfs_sched, &sysctl_sched_latency);
+	debugfs_create_u32("min_granularity_ns", 0644, debugfs_sched, &sysctl_sched_min_granularity);
+	debugfs_create_u32("wakeup_granularity_ns", 0644, debugfs_sched, &sysctl_sched_wakeup_granularity);
+
+#ifdef CONFIG_SMP
+	debugfs_create_file("tunable_scaling", 0644, debugfs_sched, NULL, &sched_scaling_fops);
+	debugfs_create_u32("migration_cost_ns", 0644, debugfs_sched, &sysctl_sched_migration_cost);
+	debugfs_create_u32("nr_migrate", 0644, debugfs_sched, &sysctl_sched_nr_migrate);
+#endif
+
+#ifdef CONFIG_NUMA_BALANCING
+	numa = debugfs_create_dir("numa_balancing", debugfs_sched);
+
+	debugfs_create_u32("scan_delay_ms", 0644, numa, &sysctl_numa_balancing_scan_delay);
+	debugfs_create_u32("scan_period_min_ms", 0644, numa, &sysctl_numa_balancing_scan_period_min);
+	debugfs_create_u32("scan_period_max_ms", 0644, numa, &sysctl_numa_balancing_scan_period_max);
+	debugfs_create_u32("scan_size_mb", 0644, numa, &sysctl_numa_balancing_scan_size);
+#endif
 
 	return 0;
 }
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 9b8ae02..b3ea14c 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -49,7 +49,7 @@ static unsigned int normalized_sysctl_sched_latency	= 6000000ULL;
  *
  * (default SCHED_TUNABLESCALING_LOG = *(1+ilog(ncpus))
  */
-enum sched_tunable_scaling sysctl_sched_tunable_scaling = SCHED_TUNABLESCALING_LOG;
+unsigned int sysctl_sched_tunable_scaling = SCHED_TUNABLESCALING_LOG;
 
 /*
  * Minimal preemption granularity for CPU-bound tasks:
@@ -634,15 +634,10 @@ struct sched_entity *__pick_last_entity(struct cfs_rq *cfs_rq)
  * Scheduling class statistics methods:
  */
 
-int sched_proc_update_handler(struct ctl_table *table, int write,
-		void *buffer, size_t *lenp, loff_t *ppos)
+int sched_update_scaling(void)
 {
-	int ret = proc_dointvec_minmax(table, write, buffer, lenp, ppos);
 	unsigned int factor = get_update_sysctl_factor();
 
-	if (ret || !write)
-		return ret;
-
 	sched_nr_latency = DIV_ROUND_UP(sysctl_sched_latency,
 					sysctl_sched_min_granularity);
 
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 7e7e936..123ff3b 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -1568,6 +1568,8 @@ static inline void unregister_sched_domain_sysctl(void)
 }
 #endif
 
+extern int sched_update_scaling(void);
+
 extern void flush_smp_call_function_from_idle(void);
 
 #else /* !CONFIG_SMP: */
diff --git a/kernel/sysctl.c b/kernel/sysctl.c
index 17f1cc9..4bff44d 100644
--- a/kernel/sysctl.c
+++ b/kernel/sysctl.c
@@ -184,17 +184,6 @@ static enum sysctl_writes_mode sysctl_writes_strict = SYSCTL_WRITES_STRICT;
 int sysctl_legacy_va_layout;
 #endif
 
-#ifdef CONFIG_SCHED_DEBUG
-static int min_sched_granularity_ns = 100000;		/* 100 usecs */
-static int max_sched_granularity_ns = NSEC_PER_SEC;	/* 1 second */
-static int min_wakeup_granularity_ns;			/* 0 usecs */
-static int max_wakeup_granularity_ns = NSEC_PER_SEC;	/* 1 second */
-#ifdef CONFIG_SMP
-static int min_sched_tunable_scaling = SCHED_TUNABLESCALING_NONE;
-static int max_sched_tunable_scaling = SCHED_TUNABLESCALING_END-1;
-#endif /* CONFIG_SMP */
-#endif /* CONFIG_SCHED_DEBUG */
-
 #ifdef CONFIG_COMPACTION
 static int min_extfrag_threshold;
 static int max_extfrag_threshold = 1000;
@@ -1659,91 +1648,6 @@ static struct ctl_table kern_table[] = {
 		.mode		= 0644,
 		.proc_handler	= proc_dointvec,
 	},
-#ifdef CONFIG_SCHED_DEBUG
-	{
-		.procname	= "sched_min_granularity_ns",
-		.data		= &sysctl_sched_min_granularity,
-		.maxlen		= sizeof(unsigned int),
-		.mode		= 0644,
-		.proc_handler	= sched_proc_update_handler,
-		.extra1		= &min_sched_granularity_ns,
-		.extra2		= &max_sched_granularity_ns,
-	},
-	{
-		.procname	= "sched_latency_ns",
-		.data		= &sysctl_sched_latency,
-		.maxlen		= sizeof(unsigned int),
-		.mode		= 0644,
-		.proc_handler	= sched_proc_update_handler,
-		.extra1		= &min_sched_granularity_ns,
-		.extra2		= &max_sched_granularity_ns,
-	},
-	{
-		.procname	= "sched_wakeup_granularity_ns",
-		.data		= &sysctl_sched_wakeup_granularity,
-		.maxlen		= sizeof(unsigned int),
-		.mode		= 0644,
-		.proc_handler	= sched_proc_update_handler,
-		.extra1		= &min_wakeup_granularity_ns,
-		.extra2		= &max_wakeup_granularity_ns,
-	},
-#ifdef CONFIG_SMP
-	{
-		.procname	= "sched_tunable_scaling",
-		.data		= &sysctl_sched_tunable_scaling,
-		.maxlen		= sizeof(enum sched_tunable_scaling),
-		.mode		= 0644,
-		.proc_handler	= sched_proc_update_handler,
-		.extra1		= &min_sched_tunable_scaling,
-		.extra2		= &max_sched_tunable_scaling,
-	},
-	{
-		.procname	= "sched_migration_cost_ns",
-		.data		= &sysctl_sched_migration_cost,
-		.maxlen		= sizeof(unsigned int),
-		.mode		= 0644,
-		.proc_handler	= proc_dointvec,
-	},
-	{
-		.procname	= "sched_nr_migrate",
-		.data		= &sysctl_sched_nr_migrate,
-		.maxlen		= sizeof(unsigned int),
-		.mode		= 0644,
-		.proc_handler	= proc_dointvec,
-	},
-#endif /* CONFIG_SMP */
-#ifdef CONFIG_NUMA_BALANCING
-	{
-		.procname	= "numa_balancing_scan_delay_ms",
-		.data		= &sysctl_numa_balancing_scan_delay,
-		.maxlen		= sizeof(unsigned int),
-		.mode		= 0644,
-		.proc_handler	= proc_dointvec,
-	},
-	{
-		.procname	= "numa_balancing_scan_period_min_ms",
-		.data		= &sysctl_numa_balancing_scan_period_min,
-		.maxlen		= sizeof(unsigned int),
-		.mode		= 0644,
-		.proc_handler	= proc_dointvec,
-	},
-	{
-		.procname	= "numa_balancing_scan_period_max_ms",
-		.data		= &sysctl_numa_balancing_scan_period_max,
-		.maxlen		= sizeof(unsigned int),
-		.mode		= 0644,
-		.proc_handler	= proc_dointvec,
-	},
-	{
-		.procname	= "numa_balancing_scan_size_mb",
-		.data		= &sysctl_numa_balancing_scan_size,
-		.maxlen		= sizeof(unsigned int),
-		.mode		= 0644,
-		.proc_handler	= proc_dointvec_minmax,
-		.extra1		= SYSCTL_ONE,
-	},
-#endif /* CONFIG_NUMA_BALANCING */
-#endif /* CONFIG_SCHED_DEBUG */
 #ifdef CONFIG_SCHEDSTATS
 	{
 		.procname	= "sched_schedstats",
