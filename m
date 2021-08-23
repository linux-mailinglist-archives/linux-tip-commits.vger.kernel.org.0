Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E30833F471F
	for <lists+linux-tip-commits@lfdr.de>; Mon, 23 Aug 2021 11:08:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231825AbhHWJIn (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Mon, 23 Aug 2021 05:08:43 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:38890 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229944AbhHWJIm (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Mon, 23 Aug 2021 05:08:42 -0400
Date:   Mon, 23 Aug 2021 09:07:58 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1629709679;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7lDEixzWEt3JjxEqVVb0RvpPyIHo5QmMMJmxpntyGe8=;
        b=YInjAM4PtYtHan97lMf8IhW0no1vdyHkcX8tMBstlwWPVYyhQtFwYw2EilcBIG+xJMY8Y1
        pgwgo+4X6ZHFQ3os7DzzGbZlQ5d9nrUhY2BxCACRc2bdK7ryy+owgNKUZd1lcMX0j1F7j5
        rwDACuv51l6/adeTG6DgBU62Ck37bgAZOXp2+2qQmZwYV4i6bjSQ3zPzosbAP0B5ITF+Ct
        ZEvuRs/jHQXxWrbyrebGpcNbFpGWXxmK8dc9C9a7KQbUoNyMY1FrFNgqKwKOdjf37ozdkm
        TWje4uJqH2tVPm0SOSlOKlPiZx78biI+5mRPw4IP7aNhokqLR+RW0n78UaNwTA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1629709679;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7lDEixzWEt3JjxEqVVb0RvpPyIHo5QmMMJmxpntyGe8=;
        b=SjDfCEtUmg36Vkx9bLgiaS9sHMY6Qb4vM1ECH2zDWe5pYLjqaagymFDsoA/3XQ8Z22i0D+
        pUzY2Ybgr3nG3YAw==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/urgent] sched: Fix Core-wide rq->lock for uninitialized CPUs
Cc:     Eugene Syromiatnikov <esyr@redhat.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Josh Don <joshdon@google.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <YR473ZGeKqMs6kw+@hirez.programming.kicks-ass.net>
References: <YR473ZGeKqMs6kw+@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Message-ID: <162970967846.25758.333277155824309635.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the sched/urgent branch of tip:

Commit-ID:     3c474b3239f12fe0b00d7e82481f36a1f31e79ab
Gitweb:        https://git.kernel.org/tip/3c474b3239f12fe0b00d7e82481f36a1f31e79ab
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Thu, 19 Aug 2021 13:09:17 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 20 Aug 2021 12:32:53 +02:00

sched: Fix Core-wide rq->lock for uninitialized CPUs

Eugene tripped over the case where rq_lock(), as called in a
for_each_possible_cpu() loop came apart because rq->core hadn't been
setup yet.

This is a somewhat unusual, but valid case.

Rework things such that rq->core is initialized to point at itself. IOW
initialize each CPU as a single threaded Core. CPU online will then join
the new CPU (thread) to an existing Core where needed.

For completeness sake, have CPU offline fully undo the state so as to
not presume the topology will match the next time it comes online.

Fixes: 9edeaea1bc45 ("sched: Core-wide rq->lock")
Reported-by: Eugene Syromiatnikov <esyr@redhat.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Josh Don <joshdon@google.com>
Tested-by: Eugene Syromiatnikov <esyr@redhat.com>
Link: https://lkml.kernel.org/r/YR473ZGeKqMs6kw+@hirez.programming.kicks-ass.net
---
 kernel/sched/core.c  | 143 ++++++++++++++++++++++++++++++++++--------
 kernel/sched/sched.h |   2 +-
 2 files changed, 118 insertions(+), 27 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 20ffcc0..f3b27c6 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -237,9 +237,30 @@ static DEFINE_MUTEX(sched_core_mutex);
 static atomic_t sched_core_count;
 static struct cpumask sched_core_mask;
 
+static void sched_core_lock(int cpu, unsigned long *flags)
+{
+	const struct cpumask *smt_mask = cpu_smt_mask(cpu);
+	int t, i = 0;
+
+	local_irq_save(*flags);
+	for_each_cpu(t, smt_mask)
+		raw_spin_lock_nested(&cpu_rq(t)->__lock, i++);
+}
+
+static void sched_core_unlock(int cpu, unsigned long *flags)
+{
+	const struct cpumask *smt_mask = cpu_smt_mask(cpu);
+	int t;
+
+	for_each_cpu(t, smt_mask)
+		raw_spin_unlock(&cpu_rq(t)->__lock);
+	local_irq_restore(*flags);
+}
+
 static void __sched_core_flip(bool enabled)
 {
-	int cpu, t, i;
+	unsigned long flags;
+	int cpu, t;
 
 	cpus_read_lock();
 
@@ -250,19 +271,12 @@ static void __sched_core_flip(bool enabled)
 	for_each_cpu(cpu, &sched_core_mask) {
 		const struct cpumask *smt_mask = cpu_smt_mask(cpu);
 
-		i = 0;
-		local_irq_disable();
-		for_each_cpu(t, smt_mask) {
-			/* supports up to SMT8 */
-			raw_spin_lock_nested(&cpu_rq(t)->__lock, i++);
-		}
+		sched_core_lock(cpu, &flags);
 
 		for_each_cpu(t, smt_mask)
 			cpu_rq(t)->core_enabled = enabled;
 
-		for_each_cpu(t, smt_mask)
-			raw_spin_unlock(&cpu_rq(t)->__lock);
-		local_irq_enable();
+		sched_core_unlock(cpu, &flags);
 
 		cpumask_andnot(&sched_core_mask, &sched_core_mask, smt_mask);
 	}
@@ -5736,35 +5750,109 @@ void queue_core_balance(struct rq *rq)
 	queue_balance_callback(rq, &per_cpu(core_balance_head, rq->cpu), sched_core_balance);
 }
 
-static inline void sched_core_cpu_starting(unsigned int cpu)
+static void sched_core_cpu_starting(unsigned int cpu)
 {
 	const struct cpumask *smt_mask = cpu_smt_mask(cpu);
-	struct rq *rq, *core_rq = NULL;
-	int i;
+	struct rq *rq = cpu_rq(cpu), *core_rq = NULL;
+	unsigned long flags;
+	int t;
 
-	core_rq = cpu_rq(cpu)->core;
+	sched_core_lock(cpu, &flags);
 
-	if (!core_rq) {
-		for_each_cpu(i, smt_mask) {
-			rq = cpu_rq(i);
-			if (rq->core && rq->core == rq)
-				core_rq = rq;
+	WARN_ON_ONCE(rq->core != rq);
+
+	/* if we're the first, we'll be our own leader */
+	if (cpumask_weight(smt_mask) == 1)
+		goto unlock;
+
+	/* find the leader */
+	for_each_cpu(t, smt_mask) {
+		if (t == cpu)
+			continue;
+		rq = cpu_rq(t);
+		if (rq->core == rq) {
+			core_rq = rq;
+			break;
 		}
+	}
 
-		if (!core_rq)
-			core_rq = cpu_rq(cpu);
+	if (WARN_ON_ONCE(!core_rq)) /* whoopsie */
+		goto unlock;
 
-		for_each_cpu(i, smt_mask) {
-			rq = cpu_rq(i);
+	/* install and validate core_rq */
+	for_each_cpu(t, smt_mask) {
+		rq = cpu_rq(t);
 
-			WARN_ON_ONCE(rq->core && rq->core != core_rq);
+		if (t == cpu)
 			rq->core = core_rq;
-		}
+
+		WARN_ON_ONCE(rq->core != core_rq);
 	}
+
+unlock:
+	sched_core_unlock(cpu, &flags);
 }
+
+static void sched_core_cpu_deactivate(unsigned int cpu)
+{
+	const struct cpumask *smt_mask = cpu_smt_mask(cpu);
+	struct rq *rq = cpu_rq(cpu), *core_rq = NULL;
+	unsigned long flags;
+	int t;
+
+	sched_core_lock(cpu, &flags);
+
+	/* if we're the last man standing, nothing to do */
+	if (cpumask_weight(smt_mask) == 1) {
+		WARN_ON_ONCE(rq->core != rq);
+		goto unlock;
+	}
+
+	/* if we're not the leader, nothing to do */
+	if (rq->core != rq)
+		goto unlock;
+
+	/* find a new leader */
+	for_each_cpu(t, smt_mask) {
+		if (t == cpu)
+			continue;
+		core_rq = cpu_rq(t);
+		break;
+	}
+
+	if (WARN_ON_ONCE(!core_rq)) /* impossible */
+		goto unlock;
+
+	/* copy the shared state to the new leader */
+	core_rq->core_task_seq      = rq->core_task_seq;
+	core_rq->core_pick_seq      = rq->core_pick_seq;
+	core_rq->core_cookie        = rq->core_cookie;
+	core_rq->core_forceidle     = rq->core_forceidle;
+	core_rq->core_forceidle_seq = rq->core_forceidle_seq;
+
+	/* install new leader */
+	for_each_cpu(t, smt_mask) {
+		rq = cpu_rq(t);
+		rq->core = core_rq;
+	}
+
+unlock:
+	sched_core_unlock(cpu, &flags);
+}
+
+static inline void sched_core_cpu_dying(unsigned int cpu)
+{
+	struct rq *rq = cpu_rq(cpu);
+
+	if (rq->core != rq)
+		rq->core = rq;
+}
+
 #else /* !CONFIG_SCHED_CORE */
 
 static inline void sched_core_cpu_starting(unsigned int cpu) {}
+static inline void sched_core_cpu_deactivate(unsigned int cpu) {}
+static inline void sched_core_cpu_dying(unsigned int cpu) {}
 
 static struct task_struct *
 pick_next_task(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
@@ -8707,6 +8795,8 @@ int sched_cpu_deactivate(unsigned int cpu)
 	 */
 	if (cpumask_weight(cpu_smt_mask(cpu)) == 2)
 		static_branch_dec_cpuslocked(&sched_smt_present);
+
+	sched_core_cpu_deactivate(cpu);
 #endif
 
 	if (!sched_smp_initialized)
@@ -8811,6 +8901,7 @@ int sched_cpu_dying(unsigned int cpu)
 	calc_load_migrate(rq);
 	update_max_interval();
 	hrtick_clear(rq);
+	sched_core_cpu_dying(cpu);
 	return 0;
 }
 #endif
@@ -9022,7 +9113,7 @@ void __init sched_init(void)
 		atomic_set(&rq->nr_iowait, 0);
 
 #ifdef CONFIG_SCHED_CORE
-		rq->core = NULL;
+		rq->core = rq;
 		rq->core_pick = NULL;
 		rq->core_enabled = 0;
 		rq->core_tree = RB_ROOT;
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 14a41a2..da4295f 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -1093,7 +1093,7 @@ struct rq {
 	unsigned int		core_sched_seq;
 	struct rb_root		core_tree;
 
-	/* shared state */
+	/* shared state -- careful with sched_core_cpu_deactivate() */
 	unsigned int		core_task_seq;
 	unsigned int		core_pick_seq;
 	unsigned long		core_cookie;
