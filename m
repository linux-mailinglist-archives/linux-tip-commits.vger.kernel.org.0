Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6857136248C
	for <lists+linux-tip-commits@lfdr.de>; Fri, 16 Apr 2021 17:55:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235913AbhDPPyM (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 16 Apr 2021 11:54:12 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:58208 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235890AbhDPPyI (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 16 Apr 2021 11:54:08 -0400
Date:   Fri, 16 Apr 2021 15:53:41 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1618588422;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QIGyW2vtnrWu1C6GgUWW5iEzLps1sh6zroMV1GPrKzo=;
        b=YNz92SjrEFNmAzZdsCfnHmivxkMJyHUiHHc1w1OfQjYQM8D/cMXWxSHa4dyqGrK1GUQVvb
        bSQBwMWKQsxA8aAlbIO7m+/hUBpL7dRhZVh57IfcZTe4QqCAaYqPKblMqVaP6+8RmjqNd9
        JGUNVHju8OcBVeB5BRHaCdmmDm4zJ7Iyo+Ff46UU7XSGjKGEXHTLlvh+RPX66nuKFXDaOm
        v+Fk3TDzReTGHL3uUd9tJhLgMZA0H5kedh3PAlHen9vYgB7B2pLa2msQhBFfBOk5aBdUDu
        4YgQilhkszmYZyqS+cT34LEG8tP7bEOnSn5e+RnudGGL7Vj4F28+Z998E90KOA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1618588422;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QIGyW2vtnrWu1C6GgUWW5iEzLps1sh6zroMV1GPrKzo=;
        b=7oOqO8GhbUusV6OlZOoqf4cT8TgZU9ryd7z0UM7afLCLS3qaCoEMOsn6qSLW+yzyDsGiO+
        Ghml3Fzs7tWqDgBg==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched,debug: Convert sysctl sched_domains to debugfs
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <s4KCBQ1ifdm@hirez.programming.kicks-ass.net>
References: <s4KCBQ1ifdm@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Message-ID: <161858842162.29796.1693217441845241647.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     3b87f136f8fccddf7da016ab7d04bb3cf9b180f0
Gitweb:        https://git.kernel.org/tip/3b87f136f8fccddf7da016ab7d04bb3cf9b180f0
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Thu, 25 Mar 2021 11:31:20 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 16 Apr 2021 17:06:35 +02:00

sched,debug: Convert sysctl sched_domains to debugfs

Stop polluting sysctl, move to debugfs for SCHED_DEBUG stuff.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
Reviewed-by: Valentin Schneider <valentin.schneider@arm.com>
Tested-by: Valentin Schneider <valentin.schneider@arm.com>
Link: https://lkml.kernel.org/r/YHgB/s4KCBQ1ifdm@hirez.programming.kicks-ass.net
---
 kernel/sched/debug.c    | 254 ++++++++-------------------------------
 kernel/sched/sched.h    |  10 +--
 kernel/sched/topology.c |   6 +-
 3 files changed, 59 insertions(+), 211 deletions(-)

diff --git a/kernel/sched/debug.c b/kernel/sched/debug.c
index bdd344f..b25de7b 100644
--- a/kernel/sched/debug.c
+++ b/kernel/sched/debug.c
@@ -299,6 +299,10 @@ static __init int sched_init_debug(void)
 	debugfs_create_file("tunable_scaling", 0644, debugfs_sched, NULL, &sched_scaling_fops);
 	debugfs_create_u32("migration_cost_ns", 0644, debugfs_sched, &sysctl_sched_migration_cost);
 	debugfs_create_u32("nr_migrate", 0644, debugfs_sched, &sysctl_sched_nr_migrate);
+
+	mutex_lock(&sched_domains_mutex);
+	update_sched_domain_debugfs();
+	mutex_unlock(&sched_domains_mutex);
 #endif
 
 #ifdef CONFIG_NUMA_BALANCING
@@ -316,229 +320,88 @@ late_initcall(sched_init_debug);
 
 #ifdef CONFIG_SMP
 
-#ifdef CONFIG_SYSCTL
-
-static struct ctl_table sd_ctl_dir[] = {
-	{
-		.procname	= "sched_domain",
-		.mode		= 0555,
-	},
-	{}
-};
-
-static struct ctl_table sd_ctl_root[] = {
-	{
-		.procname	= "kernel",
-		.mode		= 0555,
-		.child		= sd_ctl_dir,
-	},
-	{}
-};
-
-static struct ctl_table *sd_alloc_ctl_entry(int n)
-{
-	struct ctl_table *entry =
-		kcalloc(n, sizeof(struct ctl_table), GFP_KERNEL);
-
-	return entry;
-}
-
-static void sd_free_ctl_entry(struct ctl_table **tablep)
-{
-	struct ctl_table *entry;
-
-	/*
-	 * In the intermediate directories, both the child directory and
-	 * procname are dynamically allocated and could fail but the mode
-	 * will always be set. In the lowest directory the names are
-	 * static strings and all have proc handlers.
-	 */
-	for (entry = *tablep; entry->mode; entry++) {
-		if (entry->child)
-			sd_free_ctl_entry(&entry->child);
-		if (entry->proc_handler == NULL)
-			kfree(entry->procname);
-	}
-
-	kfree(*tablep);
-	*tablep = NULL;
-}
-
-static void
-set_table_entry(struct ctl_table *entry,
-		const char *procname, void *data, int maxlen,
-		umode_t mode, proc_handler *proc_handler)
-{
-	entry->procname = procname;
-	entry->data = data;
-	entry->maxlen = maxlen;
-	entry->mode = mode;
-	entry->proc_handler = proc_handler;
-}
+static cpumask_var_t		sd_sysctl_cpus;
+static struct dentry		*sd_dentry;
 
-static int sd_ctl_doflags(struct ctl_table *table, int write,
-			  void *buffer, size_t *lenp, loff_t *ppos)
+static int sd_flags_show(struct seq_file *m, void *v)
 {
-	unsigned long flags = *(unsigned long *)table->data;
-	size_t data_size = 0;
-	size_t len = 0;
-	char *tmp, *buf;
+	unsigned long flags = *(unsigned int *)m->private;
 	int idx;
 
-	if (write)
-		return 0;
-
-	for_each_set_bit(idx, &flags, __SD_FLAG_CNT) {
-		char *name = sd_flag_debug[idx].name;
-
-		/* Name plus whitespace */
-		data_size += strlen(name) + 1;
-	}
-
-	if (*ppos > data_size) {
-		*lenp = 0;
-		return 0;
-	}
-
-	buf = kcalloc(data_size + 1, sizeof(*buf), GFP_KERNEL);
-	if (!buf)
-		return -ENOMEM;
-
 	for_each_set_bit(idx, &flags, __SD_FLAG_CNT) {
-		char *name = sd_flag_debug[idx].name;
-
-		len += snprintf(buf + len, strlen(name) + 2, "%s ", name);
-	}
-
-	tmp = buf + *ppos;
-	len -= *ppos;
-
-	if (len > *lenp)
-		len = *lenp;
-	if (len)
-		memcpy(buffer, tmp, len);
-	if (len < *lenp) {
-		((char *)buffer)[len] = '\n';
-		len++;
+		seq_puts(m, sd_flag_debug[idx].name);
+		seq_puts(m, " ");
 	}
-
-	*lenp = len;
-	*ppos += len;
-
-	kfree(buf);
+	seq_puts(m, "\n");
 
 	return 0;
 }
 
-static struct ctl_table *
-sd_alloc_ctl_domain_table(struct sched_domain *sd)
-{
-	struct ctl_table *table = sd_alloc_ctl_entry(9);
-
-	if (table == NULL)
-		return NULL;
-
-	set_table_entry(&table[0], "min_interval",	  &sd->min_interval,	    sizeof(long), 0644, proc_doulongvec_minmax);
-	set_table_entry(&table[1], "max_interval",	  &sd->max_interval,	    sizeof(long), 0644, proc_doulongvec_minmax);
-	set_table_entry(&table[2], "busy_factor",	  &sd->busy_factor,	    sizeof(int),  0644, proc_dointvec_minmax);
-	set_table_entry(&table[3], "imbalance_pct",	  &sd->imbalance_pct,	    sizeof(int),  0644, proc_dointvec_minmax);
-	set_table_entry(&table[4], "cache_nice_tries",	  &sd->cache_nice_tries,    sizeof(int),  0644, proc_dointvec_minmax);
-	set_table_entry(&table[5], "flags",		  &sd->flags,		    sizeof(int),  0444, sd_ctl_doflags);
-	set_table_entry(&table[6], "max_newidle_lb_cost", &sd->max_newidle_lb_cost, sizeof(long), 0644, proc_doulongvec_minmax);
-	set_table_entry(&table[7], "name",		  sd->name,	       CORENAME_MAX_SIZE, 0444, proc_dostring);
-	/* &table[8] is terminator */
-
-	return table;
-}
-
-static struct ctl_table *sd_alloc_ctl_cpu_table(int cpu)
+static int sd_flags_open(struct inode *inode, struct file *file)
 {
-	struct ctl_table *entry, *table;
-	struct sched_domain *sd;
-	int domain_num = 0, i;
-	char buf[32];
-
-	for_each_domain(cpu, sd)
-		domain_num++;
-	entry = table = sd_alloc_ctl_entry(domain_num + 1);
-	if (table == NULL)
-		return NULL;
-
-	i = 0;
-	for_each_domain(cpu, sd) {
-		snprintf(buf, 32, "domain%d", i);
-		entry->procname = kstrdup(buf, GFP_KERNEL);
-		entry->mode = 0555;
-		entry->child = sd_alloc_ctl_domain_table(sd);
-		entry++;
-		i++;
-	}
-	return table;
+	return single_open(file, sd_flags_show, inode->i_private);
 }
 
-static cpumask_var_t		sd_sysctl_cpus;
-static struct ctl_table_header	*sd_sysctl_header;
+static const struct file_operations sd_flags_fops = {
+	.open		= sd_flags_open,
+	.read		= seq_read,
+	.llseek		= seq_lseek,
+	.release	= single_release,
+};
 
-void register_sched_domain_sysctl(void)
+static void register_sd(struct sched_domain *sd, struct dentry *parent)
 {
-	static struct ctl_table *cpu_entries;
-	static struct ctl_table **cpu_idx;
-	static bool init_done = false;
-	char buf[32];
-	int i;
+#define SDM(type, mode, member)	\
+	debugfs_create_##type(#member, mode, parent, &sd->member)
 
-	if (!cpu_entries) {
-		cpu_entries = sd_alloc_ctl_entry(num_possible_cpus() + 1);
-		if (!cpu_entries)
-			return;
-
-		WARN_ON(sd_ctl_dir[0].child);
-		sd_ctl_dir[0].child = cpu_entries;
-	}
+	SDM(ulong, 0644, min_interval);
+	SDM(ulong, 0644, max_interval);
+	SDM(u64,   0644, max_newidle_lb_cost);
+	SDM(u32,   0644, busy_factor);
+	SDM(u32,   0644, imbalance_pct);
+	SDM(u32,   0644, cache_nice_tries);
+	SDM(str,   0444, name);
 
-	if (!cpu_idx) {
-		struct ctl_table *e = cpu_entries;
+#undef SDM
 
-		cpu_idx = kcalloc(nr_cpu_ids, sizeof(struct ctl_table*), GFP_KERNEL);
-		if (!cpu_idx)
-			return;
+	debugfs_create_file("flags", 0444, parent, &sd->flags, &sd_flags_fops);
+}
 
-		/* deal with sparse possible map */
-		for_each_possible_cpu(i) {
-			cpu_idx[i] = e;
-			e++;
-		}
-	}
+void update_sched_domain_debugfs(void)
+{
+	int cpu, i;
 
 	if (!cpumask_available(sd_sysctl_cpus)) {
 		if (!alloc_cpumask_var(&sd_sysctl_cpus, GFP_KERNEL))
 			return;
-	}
-
-	if (!init_done) {
-		init_done = true;
-		/* init to possible to not have holes in @cpu_entries */
 		cpumask_copy(sd_sysctl_cpus, cpu_possible_mask);
 	}
 
-	for_each_cpu(i, sd_sysctl_cpus) {
-		struct ctl_table *e = cpu_idx[i];
+	if (!sd_dentry)
+		sd_dentry = debugfs_create_dir("domains", debugfs_sched);
+
+	for_each_cpu(cpu, sd_sysctl_cpus) {
+		struct sched_domain *sd;
+		struct dentry *d_cpu;
+		char buf[32];
+
+		snprintf(buf, sizeof(buf), "cpu%d", cpu);
+		debugfs_remove(debugfs_lookup(buf, sd_dentry));
+		d_cpu = debugfs_create_dir(buf, sd_dentry);
 
-		if (e->child)
-			sd_free_ctl_entry(&e->child);
+		i = 0;
+		for_each_domain(cpu, sd) {
+			struct dentry *d_sd;
 
-		if (!e->procname) {
-			snprintf(buf, 32, "cpu%d", i);
-			e->procname = kstrdup(buf, GFP_KERNEL);
+			snprintf(buf, sizeof(buf), "domain%d", i);
+			d_sd = debugfs_create_dir(buf, d_cpu);
+
+			register_sd(sd, d_sd);
+			i++;
 		}
-		e->mode = 0555;
-		e->child = sd_alloc_ctl_cpu_table(i);
 
-		__cpumask_clear_cpu(i, sd_sysctl_cpus);
+		__cpumask_clear_cpu(cpu, sd_sysctl_cpus);
 	}
-
-	WARN_ON(sd_sysctl_header);
-	sd_sysctl_header = register_sysctl_table(sd_ctl_root);
 }
 
 void dirty_sched_domain_sysctl(int cpu)
@@ -547,13 +410,6 @@ void dirty_sched_domain_sysctl(int cpu)
 		__cpumask_set_cpu(cpu, sd_sysctl_cpus);
 }
 
-/* may be called multiple times per register */
-void unregister_sched_domain_sysctl(void)
-{
-	unregister_sysctl_table(sd_sysctl_header);
-	sd_sysctl_header = NULL;
-}
-#endif /* CONFIG_SYSCTL */
 #endif /* CONFIG_SMP */
 
 #ifdef CONFIG_FAIR_GROUP_SCHED
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index c312389..55232db 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -1552,20 +1552,16 @@ static inline unsigned int group_first_cpu(struct sched_group *group)
 
 extern int group_balance_cpu(struct sched_group *sg);
 
-#if defined(CONFIG_SCHED_DEBUG) && defined(CONFIG_SYSCTL)
-void register_sched_domain_sysctl(void);
+#ifdef CONFIG_SCHED_DEBUG
+void update_sched_domain_debugfs(void);
 void dirty_sched_domain_sysctl(int cpu);
-void unregister_sched_domain_sysctl(void);
 #else
-static inline void register_sched_domain_sysctl(void)
+static inline void update_sched_domain_debugfs(void)
 {
 }
 static inline void dirty_sched_domain_sysctl(int cpu)
 {
 }
-static inline void unregister_sched_domain_sysctl(void)
-{
-}
 #endif
 
 extern int sched_update_scaling(void);
diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
index d1aec24..c343aed 100644
--- a/kernel/sched/topology.c
+++ b/kernel/sched/topology.c
@@ -2223,7 +2223,6 @@ int sched_init_domains(const struct cpumask *cpu_map)
 		doms_cur = &fallback_doms;
 	cpumask_and(doms_cur[0], cpu_map, housekeeping_cpumask(HK_FLAG_DOMAIN));
 	err = build_sched_domains(doms_cur[0], NULL);
-	register_sched_domain_sysctl();
 
 	return err;
 }
@@ -2298,9 +2297,6 @@ void partition_sched_domains_locked(int ndoms_new, cpumask_var_t doms_new[],
 
 	lockdep_assert_held(&sched_domains_mutex);
 
-	/* Always unregister in case we don't destroy any domains: */
-	unregister_sched_domain_sysctl();
-
 	/* Let the architecture update CPU core mappings: */
 	new_topology = arch_update_cpu_topology();
 
@@ -2389,7 +2385,7 @@ match3:
 	dattr_cur = dattr_new;
 	ndoms_cur = ndoms_new;
 
-	register_sched_domain_sysctl();
+	update_sched_domain_debugfs();
 }
 
 /*
