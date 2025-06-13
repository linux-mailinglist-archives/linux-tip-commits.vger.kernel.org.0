Return-Path: <linux-tip-commits+bounces-5814-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DA5AAAD849B
	for <lists+linux-tip-commits@lfdr.de>; Fri, 13 Jun 2025 09:45:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A9E733B39F7
	for <lists+linux-tip-commits@lfdr.de>; Fri, 13 Jun 2025 07:43:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86D7D2F2C78;
	Fri, 13 Jun 2025 07:37:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="hvKWdWVs";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="mzLV5/Cb"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D67912ED863;
	Fri, 13 Jun 2025 07:37:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749800260; cv=none; b=JrcUV4tbVdnSy6YEYJqkG4cpXsbzJOqUx/Ah5UVrpOWSOvXYbDP/m7H05CPQjr8X6ACujdEWpQBCAibDHMznq2PHc/g6PwrrTsb8nVvG/1nE00k+R7LBLGNiIwWOuowuPDNUQnPfInOlS0LbtNnfsZ64Vnk6CZ8ipcn58K8lCTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749800260; c=relaxed/simple;
	bh=YLAqpfT1R2poPMoQOtKPG3dgtbs3o1s+Oj811gLsorE=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=UVwNf+hnf9pjlA2ze72r9yYv7NNV8LtYXhQOpdgAGuZe5r9tynaZnJ58EWmy8+wxUKoQcg0FoDnjbLtI6NNv1r6+/eFZiN8CAcNgih+lT2qC1pFc1MKLgyDgKMULdZRfE3M31aN0Om+iRYdPPCEkh6+x6sNb7/O62DN6VZJlxcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=hvKWdWVs; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=mzLV5/Cb; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 13 Jun 2025 07:37:35 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1749800256;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zn9RSp3waG2QngBHt2pjvkB6SuiUF/tGHzo83D+EMTo=;
	b=hvKWdWVsdKAg+RljBnEurKdnVvdHJvDiQtaeE+IuutGRbgBvZ5+qy/84kcZai/y30ZFWco
	aSUSXnfRmE8UB1alRXx6TKY9SXh785eVpVD4JORl4vnV8P7BRBhGWLkhWoj6TP65BEzMGE
	9BXB3F4rXWKsIJiELJv0LIacWS9FLpIrxg+IdjxTEQfaebd5fNYF1Kf6310J+BwT6fA1lA
	q4/2Jp8wiNF5OELpK8tKhvGleUYVSh8Jm5XBDq/gdLLOof1i0hQp3Lw6Zlosraxe1+rh0M
	Q53C38vxUkGRYCjrJ7ir0SQ/6b8iML2AjUueHYZDbcMfsLbpn8h6wM26AmDM5g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1749800256;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zn9RSp3waG2QngBHt2pjvkB6SuiUF/tGHzo83D+EMTo=;
	b=mzLV5/CbZ9xS6RhuRvgYeLqrwpH2UhtpXoFQzD0ZakcKfscb+EM+5qiumufT3h3m1Wpg/x
	boWDFGEUKPgOfqCA==
From: "tip-bot2 for Ingo Molnar" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched: Clean up and standardize #if/#else/#endif
 markers in sched/debug.c
Cc: Ingo Molnar <mingo@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Juri Lelli <juri.lelli@redhat.com>,
 Linus Torvalds <torvalds@linux-foundation.org>, Mel Gorman <mgorman@suse.de>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Shrikanth Hegde <sshegde@linux.ibm.com>, Steven Rostedt <rostedt@goodmis.org>,
 Valentin Schneider <vschneid@redhat.com>,
 Vincent Guittot <vincent.guittot@linaro.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250528080924.2273858-9-mingo@kernel.org>
References: <20250528080924.2273858-9-mingo@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174980025540.406.3791148860513592914.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     29dd6f8cd285360cc5a3e1dc696a960541020705
Gitweb:        https://git.kernel.org/tip/29dd6f8cd285360cc5a3e1dc696a960541020705
Author:        Ingo Molnar <mingo@kernel.org>
AuthorDate:    Wed, 28 May 2025 10:08:49 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Fri, 13 Jun 2025 08:47:16 +02:00

sched: Clean up and standardize #if/#else/#endif markers in sched/debug.c

 - Use the standard #ifdef marker format for larger blocks,
   where appropriate:

        #if CONFIG_FOO
        ...
        #else /* !CONFIG_FOO: */
        ...
        #endif /* !CONFIG_FOO */

 - Fix whitespace noise and other inconsistencies.

Signed-off-by: Ingo Molnar <mingo@kernel.org>
Acked-by: Peter Zijlstra <peterz@infradead.org>
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc: Juri Lelli <juri.lelli@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Mel Gorman <mgorman@suse.de>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Shrikanth Hegde <sshegde@linux.ibm.com>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Valentin Schneider <vschneid@redhat.com>
Cc: Vincent Guittot <vincent.guittot@linaro.org>
Link: https://lore.kernel.org/r/20250528080924.2273858-9-mingo@kernel.org
---
 kernel/sched/debug.c | 36 ++++++++++++++++++------------------
 1 file changed, 18 insertions(+), 18 deletions(-)

diff --git a/kernel/sched/debug.c b/kernel/sched/debug.c
index b384124..748709c 100644
--- a/kernel/sched/debug.c
+++ b/kernel/sched/debug.c
@@ -93,10 +93,10 @@ static void sched_feat_enable(int i)
 {
 	static_key_enable_cpuslocked(&sched_feat_keys[i]);
 }
-#else
+#else /* !CONFIG_JUMP_LABEL: */
 static void sched_feat_disable(int i) { };
 static void sched_feat_enable(int i) { };
-#endif /* CONFIG_JUMP_LABEL */
+#endif /* !CONFIG_JUMP_LABEL */
 
 static int sched_feat_set(char *cmp)
 {
@@ -217,7 +217,7 @@ static const struct file_operations sched_scaling_fops = {
 	.release	= single_release,
 };
 
-#endif /* SMP */
+#endif /* CONFIG_SMP */
 
 #ifdef CONFIG_PREEMPT_DYNAMIC
 
@@ -314,9 +314,9 @@ static ssize_t sched_verbose_write(struct file *filp, const char __user *ubuf,
 
 	return result;
 }
-#else
-#define sched_verbose_write debugfs_write_file_bool
-#endif
+#else /* !CONFIG_SMP: */
+# define sched_verbose_write debugfs_write_file_bool
+#endif /* !CONFIG_SMP */
 
 static const struct file_operations sched_verbose_fops = {
 	.read =         debugfs_read_file_bool,
@@ -523,7 +523,7 @@ static __init int sched_init_debug(void)
 	sched_domains_mutex_lock();
 	update_sched_domain_debugfs();
 	sched_domains_mutex_unlock();
-#endif
+#endif /* CONFIG_SMP */
 
 #ifdef CONFIG_NUMA_BALANCING
 	numa = debugfs_create_dir("numa_balancing", debugfs_sched);
@@ -533,7 +533,7 @@ static __init int sched_init_debug(void)
 	debugfs_create_u32("scan_period_max_ms", 0644, numa, &sysctl_numa_balancing_scan_period_max);
 	debugfs_create_u32("scan_size_mb", 0644, numa, &sysctl_numa_balancing_scan_size);
 	debugfs_create_u32("hot_threshold_ms", 0644, numa, &sysctl_numa_balancing_hot_threshold);
-#endif
+#endif /* CONFIG_NUMA_BALANCING */
 
 	debugfs_create_file("debug", 0444, debugfs_sched, NULL, &sched_debug_fops);
 
@@ -697,14 +697,14 @@ static void print_cfs_group_stats(struct seq_file *m, int cpu, struct task_group
 	P(se->avg.load_avg);
 	P(se->avg.util_avg);
 	P(se->avg.runnable_avg);
-#endif
+#endif /* CONFIG_SMP */
 
 #undef PN_SCHEDSTAT
 #undef PN
 #undef P_SCHEDSTAT
 #undef P
 }
-#endif
+#endif /* CONFIG_FAIR_GROUP_SCHED */
 
 #ifdef CONFIG_CGROUP_SCHED
 static DEFINE_SPINLOCK(sched_debug_lock);
@@ -877,8 +877,8 @@ void print_cfs_rq(struct seq_file *m, int cpu, struct cfs_rq *cfs_rq)
 			cfs_rq->tg_load_avg_contrib);
 	SEQ_printf(m, "  .%-30s: %ld\n", "tg_load_avg",
 			atomic_long_read(&cfs_rq->tg->load_avg));
-#endif
-#endif
+#endif /* CONFIG_FAIR_GROUP_SCHED */
+#endif /* CONFIG_SMP */
 #ifdef CONFIG_CFS_BANDWIDTH
 	SEQ_printf(m, "  .%-30s: %d\n", "throttled",
 			cfs_rq->throttled);
@@ -954,9 +954,9 @@ static void print_cpu(struct seq_file *m, int cpu)
 		SEQ_printf(m, "cpu#%d, %u.%03u MHz\n",
 			   cpu, freq / 1000, (freq % 1000));
 	}
-#else
+#else /* !CONFIG_X86: */
 	SEQ_printf(m, "cpu#%d\n", cpu);
-#endif
+#endif /* !CONFIG_X86 */
 
 #define P(x)								\
 do {									\
@@ -984,7 +984,7 @@ do {									\
 	P64(avg_idle);
 	P64(max_idle_balance_cost);
 #undef P64
-#endif
+#endif /* CONFIG_SMP */
 
 #define P(n) SEQ_printf(m, "  .%-30s: %d\n", #n, schedstat_val(rq->n));
 	if (schedstat_enabled()) {
@@ -1166,7 +1166,7 @@ static void sched_show_numa(struct task_struct *p, struct seq_file *m)
 	SEQ_printf(m, "current_node=%d, numa_group_id=%d\n",
 			task_node(p), task_numa_group_id(p));
 	show_numa_stats(p, m);
-#endif
+#endif /* CONFIG_NUMA_BALANCING */
 }
 
 void proc_sched_show_task(struct task_struct *p, struct pid_namespace *ns,
@@ -1263,13 +1263,13 @@ void proc_sched_show_task(struct task_struct *p, struct pid_namespace *ns,
 	P(se.avg.util_avg);
 	P(se.avg.last_update_time);
 	PM(se.avg.util_est, ~UTIL_AVG_UNCHANGED);
-#endif
+#endif /* CONFIG_SMP */
 #ifdef CONFIG_UCLAMP_TASK
 	__PS("uclamp.min", p->uclamp_req[UCLAMP_MIN].value);
 	__PS("uclamp.max", p->uclamp_req[UCLAMP_MAX].value);
 	__PS("effective uclamp.min", uclamp_eff_value(p, UCLAMP_MIN));
 	__PS("effective uclamp.max", uclamp_eff_value(p, UCLAMP_MAX));
-#endif
+#endif /* CONFIG_UCLAMP_TASK */
 	P(policy);
 	P(prio);
 	if (task_has_dl_policy(p)) {

