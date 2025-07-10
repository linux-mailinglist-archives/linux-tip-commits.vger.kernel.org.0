Return-Path: <linux-tip-commits+bounces-6064-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 48AD9B00259
	for <lists+linux-tip-commits@lfdr.de>; Thu, 10 Jul 2025 14:47:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EBDA356621F
	for <lists+linux-tip-commits@lfdr.de>; Thu, 10 Jul 2025 12:47:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 459822E7161;
	Thu, 10 Jul 2025 12:46:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="WEUF84QM";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="xf/Yry1/"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15AAE2BE7AF;
	Thu, 10 Jul 2025 12:46:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752151602; cv=none; b=uhwxFoI5Yof5uyz/JPx5Jrh1ra8FbwMD1732TEVGr7907ml7qArCHKumUID1psyOJOMKz/UJWwWxZ58POq4gx7cr+sg9/LN9/3cwq0hT/TErtFDioBqWndIPfS81tPC4dCfB5YR4eLqCLFLi1Oy37dLzNDSsdfows2Zdrs/YHes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752151602; c=relaxed/simple;
	bh=agUyhLt6EgfqKM4/TkHDm5eingaxr8ea3n9UW4LSSis=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=I0s7wMopxogfzIij+AmzzEY7rIZd9R94qW4IwkURkXKnK2rZLsJIovvJnysTIeuYximkO36Qb9K2KM9KxZfDl7htoyto5IcghTJk2eFyjOJrQLXv3Xqkx2QgAEkZ8mDGhspPdv0rAopfEVFYxAYeli2+c32MMo8XcMrCBitG5r8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=WEUF84QM; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=xf/Yry1/; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 10 Jul 2025 12:46:37 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1752151598;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ol/1hFRLoQrOuPkfTKOE3kbeVsIQFGb5orsISDapgf8=;
	b=WEUF84QMDeXD+abqSCzs4E2hg79xbJUK2HxvlU2x8l7n9ku6k/NMr0QdtyWOPZfiHOWhP3
	7fvIkJi4XVJAGcWDcC4kyl3nDlf2z8tCrihPFTHuW7ssPDtW+dQpW+OLxHMI2QGMenVPuE
	SUOSCFJM7rvG4W0mNr1Fa0JUkKDi86M8dl4g4DkrqZqBJzoYMAvqWdplyDlx57mpNpqCcG
	3S9yoR1RQ1z2bWf1LnEql8XDL9/9C9i43x48DvSAL1GsKYSoRCdFOz1UiMcTglIFWRQCgi
	XD6QjIc7F+5mLJVBCsHZDECcTrw5hpbkxr+BRD3byKEym8lxh3Yh7+s7bEoW0A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1752151598;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ol/1hFRLoQrOuPkfTKOE3kbeVsIQFGb5orsISDapgf8=;
	b=xf/Yry1/P5Ce6K7cRCSmgIYmJpXKBCX6RzRDhY6wUORfHw4VKI/csRZzxH+HfuGeUsoEy3
	WsPFErZM1kVHDnCg==
From: "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: sched/core] sched/psi: Optimize psi_group_change() cpu_clock() usage
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Johannes Weiner <hannes@cmpxchg.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250522084844.GC31726@noisy.programming.kicks-ass.net>
References: <20250522084844.GC31726@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175215159730.406.1083098672208051904.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     570c8efd5eb79c3725ba439ce105ed1bedc5acd9
Gitweb:        https://git.kernel.org/tip/570c8efd5eb79c3725ba439ce105ed1bedc5acd9
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Fri, 23 May 2025 17:28:00 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 09 Jul 2025 13:40:21 +02:00

sched/psi: Optimize psi_group_change() cpu_clock() usage

Dietmar reported that commit 3840cbe24cf0 ("sched: psi: fix bogus
pressure spikes from aggregation race") caused a regression for him on
a high context switch rate benchmark (schbench) due to the now
repeating cpu_clock() calls.

In particular the problem is that get_recent_times() will extrapolate
the current state to 'now'. But if an update uses a timestamp from
before the start of the update, it is possible to get two reads
with inconsistent results. It is effectively back-dating an update.

(note that this all hard-relies on the clock being synchronized across
CPUs -- if this is not the case, all bets are off).

Combine this problem with the fact that there are per-group-per-cpu
seqcounts, the commit in question pushed the clock read into the group
iteration, causing tree-depth cpu_clock() calls. On architectures
where cpu_clock() has appreciable overhead, this hurts.

Instead move to a per-cpu seqcount, which allows us to have a single
clock read for all group updates, increasing internal consistency and
lowering update overhead. This comes at the cost of a longer update
side (proportional to the tree depth) which can cause the read side to
retry more often.

Fixes: 3840cbe24cf0 ("sched: psi: fix bogus pressure spikes from aggregation race")
Reported-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Johannes Weiner <hannes@cmpxchg.org>
Tested-by: Dietmar Eggemann <dietmar.eggemann@arm.com>,
Link: https://lkml.kernel.org/20250522084844.GC31726@noisy.programming.kicks-ass.net
---
 include/linux/psi_types.h |   6 +--
 kernel/sched/psi.c        | 121 ++++++++++++++++++++-----------------
 2 files changed, 68 insertions(+), 59 deletions(-)

diff --git a/include/linux/psi_types.h b/include/linux/psi_types.h
index f1fd3a8..dd10c22 100644
--- a/include/linux/psi_types.h
+++ b/include/linux/psi_types.h
@@ -84,11 +84,9 @@ enum psi_aggregators {
 struct psi_group_cpu {
 	/* 1st cacheline updated by the scheduler */
 
-	/* Aggregator needs to know of concurrent changes */
-	seqcount_t seq ____cacheline_aligned_in_smp;
-
 	/* States of the tasks belonging to this group */
-	unsigned int tasks[NR_PSI_TASK_COUNTS];
+	unsigned int tasks[NR_PSI_TASK_COUNTS]
+			____cacheline_aligned_in_smp;
 
 	/* Aggregate pressure state derived from the tasks */
 	u32 state_mask;
diff --git a/kernel/sched/psi.c b/kernel/sched/psi.c
index 5837cd8..2024c1d 100644
--- a/kernel/sched/psi.c
+++ b/kernel/sched/psi.c
@@ -176,6 +176,28 @@ struct psi_group psi_system = {
 	.pcpu = &system_group_pcpu,
 };
 
+static DEFINE_PER_CPU(seqcount_t, psi_seq);
+
+static inline void psi_write_begin(int cpu)
+{
+	write_seqcount_begin(per_cpu_ptr(&psi_seq, cpu));
+}
+
+static inline void psi_write_end(int cpu)
+{
+	write_seqcount_end(per_cpu_ptr(&psi_seq, cpu));
+}
+
+static inline u32 psi_read_begin(int cpu)
+{
+	return read_seqcount_begin(per_cpu_ptr(&psi_seq, cpu));
+}
+
+static inline bool psi_read_retry(int cpu, u32 seq)
+{
+	return read_seqcount_retry(per_cpu_ptr(&psi_seq, cpu), seq);
+}
+
 static void psi_avgs_work(struct work_struct *work);
 
 static void poll_timer_fn(struct timer_list *t);
@@ -186,7 +208,7 @@ static void group_init(struct psi_group *group)
 
 	group->enabled = true;
 	for_each_possible_cpu(cpu)
-		seqcount_init(&per_cpu_ptr(group->pcpu, cpu)->seq);
+		seqcount_init(per_cpu_ptr(&psi_seq, cpu));
 	group->avg_last_update = sched_clock();
 	group->avg_next_update = group->avg_last_update + psi_period;
 	mutex_init(&group->avgs_lock);
@@ -266,14 +288,14 @@ static void get_recent_times(struct psi_group *group, int cpu,
 
 	/* Snapshot a coherent view of the CPU state */
 	do {
-		seq = read_seqcount_begin(&groupc->seq);
+		seq = psi_read_begin(cpu);
 		now = cpu_clock(cpu);
 		memcpy(times, groupc->times, sizeof(groupc->times));
 		state_mask = groupc->state_mask;
 		state_start = groupc->state_start;
 		if (cpu == current_cpu)
 			memcpy(tasks, groupc->tasks, sizeof(groupc->tasks));
-	} while (read_seqcount_retry(&groupc->seq, seq));
+	} while (psi_read_retry(cpu, seq));
 
 	/* Calculate state time deltas against the previous snapshot */
 	for (s = 0; s < NR_PSI_STATES; s++) {
@@ -772,31 +794,21 @@ static void record_times(struct psi_group_cpu *groupc, u64 now)
 		groupc->times[PSI_NONIDLE] += delta;
 }
 
+#define for_each_group(iter, group) \
+	for (typeof(group) iter = group; iter; iter = iter->parent)
+
 static void psi_group_change(struct psi_group *group, int cpu,
 			     unsigned int clear, unsigned int set,
-			     bool wake_clock)
+			     u64 now, bool wake_clock)
 {
 	struct psi_group_cpu *groupc;
 	unsigned int t, m;
 	u32 state_mask;
-	u64 now;
 
 	lockdep_assert_rq_held(cpu_rq(cpu));
 	groupc = per_cpu_ptr(group->pcpu, cpu);
 
 	/*
-	 * First we update the task counts according to the state
-	 * change requested through the @clear and @set bits.
-	 *
-	 * Then if the cgroup PSI stats accounting enabled, we
-	 * assess the aggregate resource states this CPU's tasks
-	 * have been in since the last change, and account any
-	 * SOME and FULL time these may have resulted in.
-	 */
-	write_seqcount_begin(&groupc->seq);
-	now = cpu_clock(cpu);
-
-	/*
 	 * Start with TSK_ONCPU, which doesn't have a corresponding
 	 * task count - it's just a boolean flag directly encoded in
 	 * the state mask. Clear, set, or carry the current state if
@@ -847,7 +859,6 @@ static void psi_group_change(struct psi_group *group, int cpu,
 
 		groupc->state_mask = state_mask;
 
-		write_seqcount_end(&groupc->seq);
 		return;
 	}
 
@@ -868,8 +879,6 @@ static void psi_group_change(struct psi_group *group, int cpu,
 
 	groupc->state_mask = state_mask;
 
-	write_seqcount_end(&groupc->seq);
-
 	if (state_mask & group->rtpoll_states)
 		psi_schedule_rtpoll_work(group, 1, false);
 
@@ -904,24 +913,29 @@ static void psi_flags_change(struct task_struct *task, int clear, int set)
 void psi_task_change(struct task_struct *task, int clear, int set)
 {
 	int cpu = task_cpu(task);
-	struct psi_group *group;
+	u64 now;
 
 	if (!task->pid)
 		return;
 
 	psi_flags_change(task, clear, set);
 
-	group = task_psi_group(task);
-	do {
-		psi_group_change(group, cpu, clear, set, true);
-	} while ((group = group->parent));
+	psi_write_begin(cpu);
+	now = cpu_clock(cpu);
+	for_each_group(group, task_psi_group(task))
+		psi_group_change(group, cpu, clear, set, now, true);
+	psi_write_end(cpu);
 }
 
 void psi_task_switch(struct task_struct *prev, struct task_struct *next,
 		     bool sleep)
 {
-	struct psi_group *group, *common = NULL;
+	struct psi_group *common = NULL;
 	int cpu = task_cpu(prev);
+	u64 now;
+
+	psi_write_begin(cpu);
+	now = cpu_clock(cpu);
 
 	if (next->pid) {
 		psi_flags_change(next, 0, TSK_ONCPU);
@@ -930,16 +944,15 @@ void psi_task_switch(struct task_struct *prev, struct task_struct *next,
 		 * ancestors with @prev, those will already have @prev's
 		 * TSK_ONCPU bit set, and we can stop the iteration there.
 		 */
-		group = task_psi_group(next);
-		do {
-			if (per_cpu_ptr(group->pcpu, cpu)->state_mask &
-			    PSI_ONCPU) {
+		for_each_group(group, task_psi_group(next)) {
+			struct psi_group_cpu *groupc = per_cpu_ptr(group->pcpu, cpu);
+
+			if (groupc->state_mask & PSI_ONCPU) {
 				common = group;
 				break;
 			}
-
-			psi_group_change(group, cpu, 0, TSK_ONCPU, true);
-		} while ((group = group->parent));
+			psi_group_change(group, cpu, 0, TSK_ONCPU, now, true);
+		}
 	}
 
 	if (prev->pid) {
@@ -972,12 +985,11 @@ void psi_task_switch(struct task_struct *prev, struct task_struct *next,
 
 		psi_flags_change(prev, clear, set);
 
-		group = task_psi_group(prev);
-		do {
+		for_each_group(group, task_psi_group(prev)) {
 			if (group == common)
 				break;
-			psi_group_change(group, cpu, clear, set, wake_clock);
-		} while ((group = group->parent));
+			psi_group_change(group, cpu, clear, set, now, wake_clock);
+		}
 
 		/*
 		 * TSK_ONCPU is handled up to the common ancestor. If there are
@@ -987,20 +999,21 @@ void psi_task_switch(struct task_struct *prev, struct task_struct *next,
 		 */
 		if ((prev->psi_flags ^ next->psi_flags) & ~TSK_ONCPU) {
 			clear &= ~TSK_ONCPU;
-			for (; group; group = group->parent)
-				psi_group_change(group, cpu, clear, set, wake_clock);
+			for_each_group(group, common)
+				psi_group_change(group, cpu, clear, set, now, wake_clock);
 		}
 	}
+	psi_write_end(cpu);
 }
 
 #ifdef CONFIG_IRQ_TIME_ACCOUNTING
 void psi_account_irqtime(struct rq *rq, struct task_struct *curr, struct task_struct *prev)
 {
 	int cpu = task_cpu(curr);
-	struct psi_group *group;
 	struct psi_group_cpu *groupc;
 	s64 delta;
 	u64 irq;
+	u64 now;
 
 	if (static_branch_likely(&psi_disabled) || !irqtime_enabled())
 		return;
@@ -1009,8 +1022,7 @@ void psi_account_irqtime(struct rq *rq, struct task_struct *curr, struct task_st
 		return;
 
 	lockdep_assert_rq_held(rq);
-	group = task_psi_group(curr);
-	if (prev && task_psi_group(prev) == group)
+	if (prev && task_psi_group(prev) == task_psi_group(curr))
 		return;
 
 	irq = irq_time_read(cpu);
@@ -1019,25 +1031,22 @@ void psi_account_irqtime(struct rq *rq, struct task_struct *curr, struct task_st
 		return;
 	rq->psi_irq_time = irq;
 
-	do {
-		u64 now;
+	psi_write_begin(cpu);
+	now = cpu_clock(cpu);
 
+	for_each_group(group, task_psi_group(curr)) {
 		if (!group->enabled)
 			continue;
 
 		groupc = per_cpu_ptr(group->pcpu, cpu);
 
-		write_seqcount_begin(&groupc->seq);
-		now = cpu_clock(cpu);
-
 		record_times(groupc, now);
 		groupc->times[PSI_IRQ_FULL] += delta;
 
-		write_seqcount_end(&groupc->seq);
-
 		if (group->rtpoll_states & (1 << PSI_IRQ_FULL))
 			psi_schedule_rtpoll_work(group, 1, false);
-	} while ((group = group->parent));
+	}
+	psi_write_end(cpu);
 }
 #endif /* CONFIG_IRQ_TIME_ACCOUNTING */
 
@@ -1225,12 +1234,14 @@ void psi_cgroup_restart(struct psi_group *group)
 		return;
 
 	for_each_possible_cpu(cpu) {
-		struct rq *rq = cpu_rq(cpu);
-		struct rq_flags rf;
+		u64 now;
 
-		rq_lock_irq(rq, &rf);
-		psi_group_change(group, cpu, 0, 0, true);
-		rq_unlock_irq(rq, &rf);
+		guard(rq_lock_irq)(cpu_rq(cpu));
+
+		psi_write_begin(cpu);
+		now = cpu_clock(cpu);
+		psi_group_change(group, cpu, 0, 0, now, true);
+		psi_write_end(cpu);
 	}
 }
 #endif /* CONFIG_CGROUPS */

