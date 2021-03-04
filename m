Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C5E2A32CF57
	for <lists+linux-tip-commits@lfdr.de>; Thu,  4 Mar 2021 10:13:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235265AbhCDJKW (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Thu, 4 Mar 2021 04:10:22 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:48334 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230109AbhCDJJy (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Thu, 4 Mar 2021 04:09:54 -0500
Date:   Thu, 04 Mar 2021 09:09:12 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1614848952;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=M8xfzFUaBTJOTcpAKbYYMhpsyx7zYBrBiW+dM8dbDZY=;
        b=1ww5Ha0ZRV7SbFHRzVmgSsrOaTPbMODO4nWlK1KlVIOlItvuYLE91vlH7/NqP92i0SOzrR
        U7eEC/74RjMRbfJizr2hmzrXbph1vTuRczZRBZO0SU/MEjpCUKBXtXSs9w9im87ZLh1qFP
        w/wi7RhlvpMJhnZI0IKvr3uxSNBxY1YFhKPfAJhrxQm7TRgRoofPfGL4VBk7CvO6OSNTeR
        AvjCgBWEU+1fKcCTxisYHE4sfo1MAwnoAALGxFbILqIZ+OnUghVLzGhL2r3H9EFXyzU03L
        +/71LFHKp4sswyDFSroxz/Q9zW6TFYhr+Qps6X8xb8k04EjaCB7BVXIqP0j+Bg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1614848952;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=M8xfzFUaBTJOTcpAKbYYMhpsyx7zYBrBiW+dM8dbDZY=;
        b=9Wc9nUpXo0n04AUG3bZQ2GYnQ3WzwpJNzlLlZanNIyilanjPwB5EdbHowTUJn2M6fxlU2c
        aC3+lglmWlyUEFDg==
From:   "tip-bot2 for Chengming Zhou" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] psi: Use ONCPU state tracking machinery to detect reclaim
Cc:     Muchun Song <songmuchun@bytedance.com>,
        Chengming Zhou <zhouchengming@bytedance.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Johannes Weiner <hannes@cmpxchg.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210303034659.91735-3-zhouchengming@bytedance.com>
References: <20210303034659.91735-3-zhouchengming@bytedance.com>
MIME-Version: 1.0
Message-ID: <161484895224.398.2048137489219409630.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     f3f7feec57b9141dfed9825874d0191b1ac18ad2
Gitweb:        https://git.kernel.org/tip/f3f7feec57b9141dfed9825874d0191b1ac18ad2
Author:        Chengming Zhou <zhouchengming@bytedance.com>
AuthorDate:    Wed, 03 Mar 2021 11:46:57 +08:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Thu, 04 Mar 2021 09:56:01 +01:00

psi: Use ONCPU state tracking machinery to detect reclaim

Move the reclaim detection from the timer tick to the task state
tracking machinery using the recently added ONCPU state. And we
also add task psi_flags changes checking in the psi_task_switch()
optimization to update the parents properly.

In terms of performance and cost, this ONCPU task state tracking
is not cheaper than previous timer tick in aggregate. But the code is
simpler and shorter this way, so it's a maintainability win. And
Johannes did some testing with perf bench, the performace and cost
changes would be acceptable for real workloads.

Thanks to Johannes Weiner for pointing out the psi_task_switch()
optimization things and the clearer changelog.

Co-developed-by: Muchun Song <songmuchun@bytedance.com>
Signed-off-by: Muchun Song <songmuchun@bytedance.com>
Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Johannes Weiner <hannes@cmpxchg.org>
Link: https://lkml.kernel.org/r/20210303034659.91735-3-zhouchengming@bytedance.com
---
 include/linux/psi.h  |  1 +-
 kernel/sched/core.c  |  1 +-
 kernel/sched/psi.c   | 65 +++++++++++++++----------------------------
 kernel/sched/stats.h |  9 +------
 4 files changed, 24 insertions(+), 52 deletions(-)

diff --git a/include/linux/psi.h b/include/linux/psi.h
index 7361023..65eb147 100644
--- a/include/linux/psi.h
+++ b/include/linux/psi.h
@@ -20,7 +20,6 @@ void psi_task_change(struct task_struct *task, int clear, int set);
 void psi_task_switch(struct task_struct *prev, struct task_struct *next,
 		     bool sleep);
 
-void psi_memstall_tick(struct task_struct *task, int cpu);
 void psi_memstall_enter(unsigned long *flags);
 void psi_memstall_leave(unsigned long *flags);
 
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 361974e..d2629fd 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -4551,7 +4551,6 @@ void scheduler_tick(void)
 	update_thermal_load_avg(rq_clock_thermal(rq), rq, thermal_pressure);
 	curr->sched_class->task_tick(rq, curr, 0);
 	calc_global_load_tick(rq);
-	psi_task_tick(rq);
 
 	rq_unlock(rq, &rf);
 
diff --git a/kernel/sched/psi.c b/kernel/sched/psi.c
index 2293c45..0fe6ff6 100644
--- a/kernel/sched/psi.c
+++ b/kernel/sched/psi.c
@@ -644,8 +644,7 @@ static void poll_timer_fn(struct timer_list *t)
 	wake_up_interruptible(&group->poll_wait);
 }
 
-static void record_times(struct psi_group_cpu *groupc, int cpu,
-			 bool memstall_tick)
+static void record_times(struct psi_group_cpu *groupc, int cpu)
 {
 	u32 delta;
 	u64 now;
@@ -664,23 +663,6 @@ static void record_times(struct psi_group_cpu *groupc, int cpu,
 		groupc->times[PSI_MEM_SOME] += delta;
 		if (groupc->state_mask & (1 << PSI_MEM_FULL))
 			groupc->times[PSI_MEM_FULL] += delta;
-		else if (memstall_tick) {
-			u32 sample;
-			/*
-			 * Since we care about lost potential, a
-			 * memstall is FULL when there are no other
-			 * working tasks, but also when the CPU is
-			 * actively reclaiming and nothing productive
-			 * could run even if it were runnable.
-			 *
-			 * When the timer tick sees a reclaiming CPU,
-			 * regardless of runnable tasks, sample a FULL
-			 * tick (or less if it hasn't been a full tick
-			 * since the last state change).
-			 */
-			sample = min(delta, (u32)jiffies_to_nsecs(1));
-			groupc->times[PSI_MEM_FULL] += sample;
-		}
 	}
 
 	if (groupc->state_mask & (1 << PSI_CPU_SOME)) {
@@ -714,7 +696,7 @@ static void psi_group_change(struct psi_group *group, int cpu,
 	 */
 	write_seqcount_begin(&groupc->seq);
 
-	record_times(groupc, cpu, false);
+	record_times(groupc, cpu);
 
 	for (t = 0, m = clear; m; m &= ~(1 << t), t++) {
 		if (!(m & (1 << t)))
@@ -738,6 +720,18 @@ static void psi_group_change(struct psi_group *group, int cpu,
 		if (test_state(groupc->tasks, s))
 			state_mask |= (1 << s);
 	}
+
+	/*
+	 * Since we care about lost potential, a memstall is FULL
+	 * when there are no other working tasks, but also when
+	 * the CPU is actively reclaiming and nothing productive
+	 * could run even if it were runnable. So when the current
+	 * task in a cgroup is in_memstall, the corresponding groupc
+	 * on that cpu is in PSI_MEM_FULL state.
+	 */
+	if (groupc->tasks[NR_ONCPU] && cpu_curr(cpu)->in_memstall)
+		state_mask |= (1 << PSI_MEM_FULL);
+
 	groupc->state_mask = state_mask;
 
 	write_seqcount_end(&groupc->seq);
@@ -823,17 +817,21 @@ void psi_task_switch(struct task_struct *prev, struct task_struct *next,
 	void *iter;
 
 	if (next->pid) {
+		bool identical_state;
+
 		psi_flags_change(next, 0, TSK_ONCPU);
 		/*
-		 * When moving state between tasks, the group that
-		 * contains them both does not change: we can stop
-		 * updating the tree once we reach the first common
-		 * ancestor. Iterate @next's ancestors until we
-		 * encounter @prev's state.
+		 * When switching between tasks that have an identical
+		 * runtime state, the cgroup that contains both tasks
+		 * runtime state, the cgroup that contains both tasks
+		 * we reach the first common ancestor. Iterate @next's
+		 * ancestors only until we encounter @prev's ONCPU.
 		 */
+		identical_state = prev->psi_flags == next->psi_flags;
 		iter = NULL;
 		while ((group = iterate_groups(next, &iter))) {
-			if (per_cpu_ptr(group->pcpu, cpu)->tasks[NR_ONCPU]) {
+			if (identical_state &&
+			    per_cpu_ptr(group->pcpu, cpu)->tasks[NR_ONCPU]) {
 				common = group;
 				break;
 			}
@@ -859,21 +857,6 @@ void psi_task_switch(struct task_struct *prev, struct task_struct *next,
 	}
 }
 
-void psi_memstall_tick(struct task_struct *task, int cpu)
-{
-	struct psi_group *group;
-	void *iter = NULL;
-
-	while ((group = iterate_groups(task, &iter))) {
-		struct psi_group_cpu *groupc;
-
-		groupc = per_cpu_ptr(group->pcpu, cpu);
-		write_seqcount_begin(&groupc->seq);
-		record_times(groupc, cpu, true);
-		write_seqcount_end(&groupc->seq);
-	}
-}
-
 /**
  * psi_memstall_enter - mark the beginning of a memory stall section
  * @flags: flags to handle nested sections
diff --git a/kernel/sched/stats.h b/kernel/sched/stats.h
index 33d0daf..9e4e67a 100644
--- a/kernel/sched/stats.h
+++ b/kernel/sched/stats.h
@@ -144,14 +144,6 @@ static inline void psi_sched_switch(struct task_struct *prev,
 	psi_task_switch(prev, next, sleep);
 }
 
-static inline void psi_task_tick(struct rq *rq)
-{
-	if (static_branch_likely(&psi_disabled))
-		return;
-
-	if (unlikely(rq->curr->in_memstall))
-		psi_memstall_tick(rq->curr, cpu_of(rq));
-}
 #else /* CONFIG_PSI */
 static inline void psi_enqueue(struct task_struct *p, bool wakeup) {}
 static inline void psi_dequeue(struct task_struct *p, bool sleep) {}
@@ -159,7 +151,6 @@ static inline void psi_ttwu_dequeue(struct task_struct *p) {}
 static inline void psi_sched_switch(struct task_struct *prev,
 				    struct task_struct *next,
 				    bool sleep) {}
-static inline void psi_task_tick(struct rq *rq) {}
 #endif /* CONFIG_PSI */
 
 #ifdef CONFIG_SCHED_INFO
