Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5CDC9300A48
	for <lists+linux-tip-commits@lfdr.de>; Fri, 22 Jan 2021 18:51:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729230AbhAVRvR (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 22 Jan 2021 12:51:17 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:55714 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729262AbhAVRm0 (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 22 Jan 2021 12:42:26 -0500
Date:   Fri, 22 Jan 2021 17:41:34 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1611337294;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Az+PoTXpLqxvP3LiNbuDza0hmAwcbScjUUcNPnKjSm0=;
        b=rhYPSiWhuPyvwrWk+ewnk/JwfSAyYRLa6AwUj2SkE9y3iOZ1RezUPKxsy6+sRoIHTIcARp
        PZ7fawsYGgtcUzKzKQ53Drd+PY5hH1Z1YZV8W+1sRgKqnR49pp5VSPbvt4xMxpur8AIsAp
        CddmI0rQLtXOnETSEeqOReezuNMpAQXqwYomtfA0dWV0+/M05UHAvx5SY26OPM+9UQ/j6o
        z9Kc1vKGPE0dBUMYKK7ZhQvfytstSGQnSl5KGBGpHk2fH7JBKyMXe+VjZ9biajaG1vJsNV
        570ZPvLOVeZWPM/Rk5yM4o9be3TPUyM9weGmDkH5drl9dEoC+1f9IX3lpVVWZA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1611337294;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Az+PoTXpLqxvP3LiNbuDza0hmAwcbScjUUcNPnKjSm0=;
        b=EfM1eJR8xrNWn3g4AAgD3PX7Ygu3rRClCAEYxbUpNpnfbpZkqmAGhcdDsVmKkwUpxtn7eq
        Mtzo6C39+FCQDnCA==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/urgent] sched: Fix CPU hotplug / tighten is_per_cpu_kthread()
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20210121103507.102416009@infradead.org>
References: <20210121103507.102416009@infradead.org>
MIME-Version: 1.0
Message-ID: <161133729428.414.5493367534012099042.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the sched/urgent branch of tip:

Commit-ID:     5ba2ffba13a1e24e7b153683e97300f9cc6f605a
Gitweb:        https://git.kernel.org/tip/5ba2ffba13a1e24e7b153683e97300f9cc6f605a
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Tue, 12 Jan 2021 11:28:16 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 22 Jan 2021 15:09:44 +01:00

sched: Fix CPU hotplug / tighten is_per_cpu_kthread()

Prior to commit 1cf12e08bc4d ("sched/hotplug: Consolidate task
migration on CPU unplug") we'd leave any task on the dying CPU and
break affinity and force them off at the very end.

This scheme had to change in order to enable migrate_disable(). One
cannot wait for migrate_disable() to complete while stuck in
stop_machine(). Furthermore, since we need at the very least: idle,
hotplug and stop threads at any point before stop_machine, we can't
break affinity and/or push those away.

Under the assumption that all per-cpu kthreads are sanely handled by
CPU hotplug, the new code no long breaks affinity or migrates any of
them (which then includes the critical ones above).

However, there's an important difference between per-cpu kthreads and
kthreads that happen to have a single CPU affinity which is lost. The
latter class very much relies on the forced affinity breaking and
migration semantics previously provided.

Use the new kthread_is_per_cpu() infrastructure to tighten
is_per_cpu_kthread() and fix the hot-unplug problems stemming from the
change.

Fixes: 1cf12e08bc4d ("sched/hotplug: Consolidate task migration on CPU unplug")
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Valentin Schneider <valentin.schneider@arm.com>
Tested-by: Valentin Schneider <valentin.schneider@arm.com>
Link: https://lkml.kernel.org/r/20210121103507.102416009@infradead.org
---
 kernel/sched/core.c | 39 +++++++++++++++++++++++++++++++++++----
 1 file changed, 35 insertions(+), 4 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 16946b5..56b0962 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -1796,13 +1796,28 @@ static inline bool rq_has_pinned_tasks(struct rq *rq)
  */
 static inline bool is_cpu_allowed(struct task_struct *p, int cpu)
 {
+	/* When not in the task's cpumask, no point in looking further. */
 	if (!cpumask_test_cpu(cpu, p->cpus_ptr))
 		return false;
 
-	if (is_per_cpu_kthread(p) || is_migration_disabled(p))
+	/* migrate_disabled() must be allowed to finish. */
+	if (is_migration_disabled(p))
 		return cpu_online(cpu);
 
-	return cpu_active(cpu);
+	/* Non kernel threads are not allowed during either online or offline. */
+	if (!(p->flags & PF_KTHREAD))
+		return cpu_active(cpu);
+
+	/* KTHREAD_IS_PER_CPU is always allowed. */
+	if (kthread_is_per_cpu(p))
+		return cpu_online(cpu);
+
+	/* Regular kernel threads don't get to stay during offline. */
+	if (cpu_rq(cpu)->balance_push)
+		return false;
+
+	/* But are allowed during online. */
+	return cpu_online(cpu);
 }
 
 /*
@@ -3122,6 +3137,13 @@ bool cpus_share_cache(int this_cpu, int that_cpu)
 static inline bool ttwu_queue_cond(int cpu, int wake_flags)
 {
 	/*
+	 * Do not complicate things with the async wake_list while the CPU is
+	 * in hotplug state.
+	 */
+	if (!cpu_active(cpu))
+		return false;
+
+	/*
 	 * If the CPU does not share cache, then queue the task on the
 	 * remote rqs wakelist to avoid accessing remote data.
 	 */
@@ -7276,8 +7298,14 @@ static void balance_push(struct rq *rq)
 	/*
 	 * Both the cpu-hotplug and stop task are in this case and are
 	 * required to complete the hotplug process.
+	 *
+	 * XXX: the idle task does not match kthread_is_per_cpu() due to
+	 * histerical raisins.
 	 */
-	if (is_per_cpu_kthread(push_task) || is_migration_disabled(push_task)) {
+	if (rq->idle == push_task ||
+	    ((push_task->flags & PF_KTHREAD) && kthread_is_per_cpu(push_task)) ||
+	    is_migration_disabled(push_task)) {
+
 		/*
 		 * If this is the idle task on the outgoing CPU try to wake
 		 * up the hotplug control thread which might wait for the
@@ -7309,7 +7337,7 @@ static void balance_push(struct rq *rq)
 	/*
 	 * At this point need_resched() is true and we'll take the loop in
 	 * schedule(). The next pick is obviously going to be the stop task
-	 * which is_per_cpu_kthread() and will push this task away.
+	 * which kthread_is_per_cpu() and will push this task away.
 	 */
 	raw_spin_lock(&rq->lock);
 }
@@ -7497,6 +7525,9 @@ int sched_cpu_deactivate(unsigned int cpu)
 	 * preempt-disabled and RCU users of this state to go away such that
 	 * all new such users will observe it.
 	 *
+	 * Specifically, we rely on ttwu to no longer target this CPU, see
+	 * ttwu_queue_cond() and is_cpu_allowed().
+	 *
 	 * Do sync before park smpboot threads to take care the rcu boost case.
 	 */
 	synchronize_rcu();
