Return-Path: <linux-tip-commits+bounces-5793-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DCDDAD8475
	for <lists+linux-tip-commits@lfdr.de>; Fri, 13 Jun 2025 09:41:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6D5403BA561
	for <lists+linux-tip-commits@lfdr.de>; Fri, 13 Jun 2025 07:39:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D81F42E6D1F;
	Fri, 13 Jun 2025 07:37:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="MyGyoQ/Z";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="PqOanQgi"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B88E2E762A;
	Fri, 13 Jun 2025 07:37:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749800241; cv=none; b=bY2ZoJeAJAtUVBNdI13MAu0mloun+7oaA5mANBWtJTopx8ZMfB558KHCPOxCZzngOJq0xu6qCLUasCpm2TbHGWT55lusaiQbv3ajk4PeFJpKle9/CEHlOBzR/hlaIM5eAN5EOskJ4MqkdG1TIoexPPuGmE4iRxojvwnDMTobizA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749800241; c=relaxed/simple;
	bh=w9aNNCvcZTGvE6vN1FBlZducZcIicmK4cQeqCw1LWJs=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=oWrnOz+pYwEoBP+BwuRuPfiSQZZoS9uWEWXxi9acgfg/WUlksiOzmVbb25fsLkG/Eg/kxt+kZGv4sp9J1oxQtRoxUMCh+7Clyk9eqG3EVNykd6sr2wETW2yw6QCMdCkLLlVsbr5cYeA+dr42nvfeOK8/+TgxHo56q0PsvnoVmU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=MyGyoQ/Z; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=PqOanQgi; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 13 Jun 2025 07:37:16 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1749800237;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0Thu+GSrmN+elsfIi+LD+y2D2eDLVjc9fAT6HhzLtII=;
	b=MyGyoQ/ZCfQWAOZMXm0hW4vdkY/1/ze0m8TJnqpNsm3RDGZPwm0rZEGOEqYUw0UBl3K12E
	G+gbqD3t97Zjlis2zPB0/NlKhval+n2iDFyrpHKOMIcGTkn6NoMILTEJ2b0s1NSHH2eTXw
	W2qtnGduf5KAUhhOk23TA2onSxnkpACt3LHX44wOgPtXEo74pibrOXSHexidJO2ZWcB27m
	XYvzW8COHbDXK1v3roLYvrmX6qgf3hlJsoq4PrRJNIPnXW0bZ8Pf68bQp1I86l1tgAxWPW
	mwkJKR/uYCi/bTxeAqJZUELqsRFvwkIYZbWj758Kofy3FSGMC48IUOiJuPxrtw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1749800237;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0Thu+GSrmN+elsfIi+LD+y2D2eDLVjc9fAT6HhzLtII=;
	b=PqOanQgiEez96r471IsJ0sfO4XO/tdBvv8RD5iYVYm+JWR4c93hEhU8FFoJyNk9fem8Haf
	syjL0KsTLqeaE3BA==
From: "tip-bot2 for Ingo Molnar" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: sched/core] sched/smp: Use the SMP version of scheduler debugging data
Cc: Ingo Molnar <mingo@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Juri Lelli <juri.lelli@redhat.com>,
 Linus Torvalds <torvalds@linux-foundation.org>, Mel Gorman <mgorman@suse.de>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Shrikanth Hegde <sshegde@linux.ibm.com>, Steven Rostedt <rostedt@goodmis.org>,
 Valentin Schneider <vschneid@redhat.com>,
 Vincent Guittot <vincent.guittot@linaro.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250528080924.2273858-31-mingo@kernel.org>
References: <20250528080924.2273858-31-mingo@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174980023684.406.471722394508861936.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     02fb885ebdc4ad029aabff4b85dcbc540d7cdb32
Gitweb:        https://git.kernel.org/tip/02fb885ebdc4ad029aabff4b85dcbc540d7cdb32
Author:        Ingo Molnar <mingo@kernel.org>
AuthorDate:    Wed, 28 May 2025 10:09:11 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Fri, 13 Jun 2025 08:47:20 +02:00

sched/smp: Use the SMP version of scheduler debugging data

Simplify the scheduler by making CONFIG_SMP=y debug output
unconditional.

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
Link: https://lore.kernel.org/r/20250528080924.2273858-31-mingo@kernel.org
---
 kernel/sched/debug.c | 14 --------------
 1 file changed, 14 deletions(-)

diff --git a/kernel/sched/debug.c b/kernel/sched/debug.c
index 04c0354..f16d539 100644
--- a/kernel/sched/debug.c
+++ b/kernel/sched/debug.c
@@ -169,8 +169,6 @@ static const struct file_operations sched_feat_fops = {
 	.release	= single_release,
 };
 
-#ifdef CONFIG_SMP
-
 static ssize_t sched_scaling_write(struct file *filp, const char __user *ubuf,
 				   size_t cnt, loff_t *ppos)
 {
@@ -217,8 +215,6 @@ static const struct file_operations sched_scaling_fops = {
 	.release	= single_release,
 };
 
-#endif /* CONFIG_SMP */
-
 #ifdef CONFIG_PREEMPT_DYNAMIC
 
 static ssize_t sched_dynamic_write(struct file *filp, const char __user *ubuf,
@@ -511,7 +507,6 @@ static __init int sched_init_debug(void)
 	debugfs_create_u32("latency_warn_ms", 0644, debugfs_sched, &sysctl_resched_latency_warn_ms);
 	debugfs_create_u32("latency_warn_once", 0644, debugfs_sched, &sysctl_resched_latency_warn_once);
 
-#ifdef CONFIG_SMP
 	debugfs_create_file("tunable_scaling", 0644, debugfs_sched, NULL, &sched_scaling_fops);
 	debugfs_create_u32("migration_cost_ns", 0644, debugfs_sched, &sysctl_sched_migration_cost);
 	debugfs_create_u32("nr_migrate", 0644, debugfs_sched, &sysctl_sched_nr_migrate);
@@ -519,7 +514,6 @@ static __init int sched_init_debug(void)
 	sched_domains_mutex_lock();
 	update_sched_domain_debugfs();
 	sched_domains_mutex_unlock();
-#endif /* CONFIG_SMP */
 
 #ifdef CONFIG_NUMA_BALANCING
 	numa = debugfs_create_dir("numa_balancing", debugfs_sched);
@@ -685,11 +679,9 @@ static void print_cfs_group_stats(struct seq_file *m, int cpu, struct task_group
 	}
 
 	P(se->load.weight);
-#ifdef CONFIG_SMP
 	P(se->avg.load_avg);
 	P(se->avg.util_avg);
 	P(se->avg.runnable_avg);
-#endif /* CONFIG_SMP */
 
 #undef PN_SCHEDSTAT
 #undef PN
@@ -849,7 +841,6 @@ void print_cfs_rq(struct seq_file *m, int cpu, struct cfs_rq *cfs_rq)
 	SEQ_printf(m, "  .%-30s: %d\n", "h_nr_queued", cfs_rq->h_nr_queued);
 	SEQ_printf(m, "  .%-30s: %d\n", "h_nr_idle", cfs_rq->h_nr_idle);
 	SEQ_printf(m, "  .%-30s: %ld\n", "load", cfs_rq->load.weight);
-#ifdef CONFIG_SMP
 	SEQ_printf(m, "  .%-30s: %lu\n", "load_avg",
 			cfs_rq->avg.load_avg);
 	SEQ_printf(m, "  .%-30s: %lu\n", "runnable_avg",
@@ -870,7 +861,6 @@ void print_cfs_rq(struct seq_file *m, int cpu, struct cfs_rq *cfs_rq)
 	SEQ_printf(m, "  .%-30s: %ld\n", "tg_load_avg",
 			atomic_long_read(&cfs_rq->tg->load_avg));
 #endif /* CONFIG_FAIR_GROUP_SCHED */
-#endif /* CONFIG_SMP */
 #ifdef CONFIG_CFS_BANDWIDTH
 	SEQ_printf(m, "  .%-30s: %d\n", "throttled",
 			cfs_rq->throttled);
@@ -967,12 +957,10 @@ do {									\
 #undef P
 #undef PN
 
-#ifdef CONFIG_SMP
 #define P64(n) SEQ_printf(m, "  .%-30s: %Ld\n", #n, rq->n);
 	P64(avg_idle);
 	P64(max_idle_balance_cost);
 #undef P64
-#endif /* CONFIG_SMP */
 
 #define P(n) SEQ_printf(m, "  .%-30s: %d\n", #n, schedstat_val(rq->n));
 	if (schedstat_enabled()) {
@@ -1242,7 +1230,6 @@ void proc_sched_show_task(struct task_struct *p, struct pid_namespace *ns,
 	__PS("nr_involuntary_switches", p->nivcsw);
 
 	P(se.load.weight);
-#ifdef CONFIG_SMP
 	P(se.avg.load_sum);
 	P(se.avg.runnable_sum);
 	P(se.avg.util_sum);
@@ -1251,7 +1238,6 @@ void proc_sched_show_task(struct task_struct *p, struct pid_namespace *ns,
 	P(se.avg.util_avg);
 	P(se.avg.last_update_time);
 	PM(se.avg.util_est, ~UTIL_AVG_UNCHANGED);
-#endif /* CONFIG_SMP */
 #ifdef CONFIG_UCLAMP_TASK
 	__PS("uclamp.min", p->uclamp_req[UCLAMP_MIN].value);
 	__PS("uclamp.max", p->uclamp_req[UCLAMP_MAX].value);

