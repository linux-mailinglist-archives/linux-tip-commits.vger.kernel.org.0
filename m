Return-Path: <linux-tip-commits+bounces-2406-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EA9099C143
	for <lists+linux-tip-commits@lfdr.de>; Mon, 14 Oct 2024 09:28:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A02151F2397A
	for <lists+linux-tip-commits@lfdr.de>; Mon, 14 Oct 2024 07:28:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EF29148833;
	Mon, 14 Oct 2024 07:28:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="4lQx7GdE";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="eKX1kyXL"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5A7914830A;
	Mon, 14 Oct 2024 07:28:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728890929; cv=none; b=cTR2Uw1/yRGcY4Knicu69c7FLwUeHa3bpqCQG9cuPpFSlfgFbsHDfqY0KvTInyXq1j3KOgK3EXMhj3fhoChWgYuK5luBZqJZqEWgNV+GvYrUc810TbRjx8BkrUZStpM5hVJTtGRvX9tNNqIkHiDL0nqsObdVvGSul30WXrJlnZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728890929; c=relaxed/simple;
	bh=o9edveVwNe6IQQ4YcH86irGXfYoMvqmVH52UK3XBGfI=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=VrL0FjDDQ5C3mH+sXhTPI/p2m0xVeHYHuplx1uF0DLZ3tOiCnf8gd1mhAv5WKWM0l8X0FavxTBU6/kGUu6yfyz8kaenqazJQHSOCv9NHB+YjMbaTzvVoJqRDXGm/aJdK+oosY2GBXYNaIWHlvm4Qafrmcby1Kdpel0gpi3ZkXUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=4lQx7GdE; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=eKX1kyXL; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 14 Oct 2024 07:28:43 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1728890924;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nkRToY+k04xXFkwWQ/SfVA6D9ssh9EPt4TbqptN0ZQs=;
	b=4lQx7GdE54Oy/4lqVeIw4a/OADeCahN2JKwJWTWkrK7yqCCEFRzG55P0Cr59jsdLVh0H8K
	I8x9S+gENjpXgRZGhbUD6GE2RURB+I3TRaIyMdUN/Wfnq4Dqlyg24k3QEhxtJQd8VNl20M
	fsb3T+t3bchCYpeDCPg7m2NtgcuutlxTN/yNoaoGy9AJTgaWGZ3QwaikUz/aP6zToQjAVX
	jhapClPQjhOWYjaSjBAEv62XG6gqHrM8sCB1uBwzrEU3oZ9Am8JgKWogaDkkZ1tg54xH9l
	CHzuc5D6Zd9NTcI9UufzEErXFfUXS1DePuGOAPqkhAMtYoTIKrzPahgb7y8PWg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1728890924;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nkRToY+k04xXFkwWQ/SfVA6D9ssh9EPt4TbqptN0ZQs=;
	b=eKX1kyXLTrQksz3i2pxiGK9eR+Cw493kLhpY5TM4/VrZwTlbU/sDJoLDQMOcp7EUeiGX00
	f3bPm99UCs9mVqDQ==
From: "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: sched/urgent] sched/fair: Fix external p->on_rq users
Cc: Sean Christopherson <seanjc@google.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Ingo Molnar <mingo@kernel.org>, x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20241010091843.GK33184@noisy.programming.kicks-ass.net>
References: <20241010091843.GK33184@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172889092385.1442.13511131954955317922.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the sched/urgent branch of tip:

Commit-ID:     cd9626e9ebc77edec33023fe95dab4b04ffc819d
Gitweb:        https://git.kernel.org/tip/cd9626e9ebc77edec33023fe95dab4b04ffc819d
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Thu, 10 Oct 2024 11:38:10 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Mon, 14 Oct 2024 09:14:35 +02:00

sched/fair: Fix external p->on_rq users

Sean noted that ever since commit 152e11f6df29 ("sched/fair: Implement
delayed dequeue") KVM's preemption notifiers have started
mis-classifying preemption vs blocking.

Notably p->on_rq is no longer sufficient to determine if a task is
runnable or blocked -- the aforementioned commit introduces tasks that
remain on the runqueue even through they will not run again, and
should be considered blocked for many cases.

Add the task_is_runnable() helper to classify things and audit all
external users of the p->on_rq state. Also add a few comments.

Fixes: 152e11f6df29 ("sched/fair: Implement delayed dequeue")
Reported-by: Sean Christopherson <seanjc@google.com>
Tested-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lkml.kernel.org/r/20241010091843.GK33184@noisy.programming.kicks-ass.net
---
 include/linux/sched.h         |  5 +++++
 kernel/events/core.c          |  2 +-
 kernel/freezer.c              |  7 ++++++-
 kernel/rcu/tasks.h            |  9 +++++++++
 kernel/sched/core.c           | 12 +++++++++---
 kernel/time/tick-sched.c      |  6 ++++++
 kernel/trace/trace_selftest.c |  2 +-
 virt/kvm/kvm_main.c           |  2 +-
 8 files changed, 38 insertions(+), 7 deletions(-)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index e6ee425..8a9517e 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -2133,6 +2133,11 @@ static inline void set_task_cpu(struct task_struct *p, unsigned int cpu)
 
 #endif /* CONFIG_SMP */
 
+static inline bool task_is_runnable(struct task_struct *p)
+{
+	return p->on_rq && !p->se.sched_delayed;
+}
+
 extern bool sched_task_on_rq(struct task_struct *p);
 extern unsigned long get_wchan(struct task_struct *p);
 extern struct task_struct *cpu_curr_snapshot(int cpu);
diff --git a/kernel/events/core.c b/kernel/events/core.c
index e3589c4..cdd0976 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -9251,7 +9251,7 @@ static void perf_event_switch(struct task_struct *task,
 		},
 	};
 
-	if (!sched_in && task->on_rq) {
+	if (!sched_in && task_is_runnable(task)) {
 		switch_event.event_id.header.misc |=
 				PERF_RECORD_MISC_SWITCH_OUT_PREEMPT;
 	}
diff --git a/kernel/freezer.c b/kernel/freezer.c
index 44bbd7d..8d530d0 100644
--- a/kernel/freezer.c
+++ b/kernel/freezer.c
@@ -109,7 +109,12 @@ static int __set_task_frozen(struct task_struct *p, void *arg)
 {
 	unsigned int state = READ_ONCE(p->__state);
 
-	if (p->on_rq)
+	/*
+	 * Allow freezing the sched_delayed tasks; they will not execute until
+	 * ttwu() fixes them up, so it is safe to swap their state now, instead
+	 * of waiting for them to get fully dequeued.
+	 */
+	if (task_is_runnable(p))
 		return 0;
 
 	if (p != current && task_curr(p))
diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
index 6333f4c..4d7ee95 100644
--- a/kernel/rcu/tasks.h
+++ b/kernel/rcu/tasks.h
@@ -986,6 +986,15 @@ static bool rcu_tasks_is_holdout(struct task_struct *t)
 		return false;
 
 	/*
+	 * t->on_rq && !t->se.sched_delayed *could* be considered sleeping but
+	 * since it is a spurious state (it will transition into the
+	 * traditional blocked state or get woken up without outside
+	 * dependencies), not considering it such should only affect timing.
+	 *
+	 * Be conservative for now and not include it.
+	 */
+
+	/*
 	 * Idle tasks (or idle injection) within the idle loop are RCU-tasks
 	 * quiescent states. But CPU boot code performed by the idle task
 	 * isn't a quiescent state.
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 71232f8..7db711b 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -548,6 +548,11 @@ sched_core_dequeue(struct rq *rq, struct task_struct *p, int flags) { }
  *   ON_RQ_MIGRATING state is used for migration without holding both
  *   rq->locks. It indicates task_cpu() is not stable, see task_rq_lock().
  *
+ *   Additionally it is possible to be ->on_rq but still be considered not
+ *   runnable when p->se.sched_delayed is true. These tasks are on the runqueue
+ *   but will be dequeued as soon as they get picked again. See the
+ *   task_is_runnable() helper.
+ *
  * p->on_cpu <- { 0, 1 }:
  *
  *   is set by prepare_task() and cleared by finish_task() such that it will be
@@ -4317,9 +4322,10 @@ static bool __task_needs_rq_lock(struct task_struct *p)
  * @arg: Argument to function.
  *
  * Fix the task in it's current state by avoiding wakeups and or rq operations
- * and call @func(@arg) on it.  This function can use ->on_rq and task_curr()
- * to work out what the state is, if required.  Given that @func can be invoked
- * with a runqueue lock held, it had better be quite lightweight.
+ * and call @func(@arg) on it.  This function can use task_is_runnable() and
+ * task_curr() to work out what the state is, if required.  Given that @func
+ * can be invoked with a runqueue lock held, it had better be quite
+ * lightweight.
  *
  * Returns:
  *   Whatever @func returns
diff --git a/kernel/time/tick-sched.c b/kernel/time/tick-sched.c
index 753a184..f203f00 100644
--- a/kernel/time/tick-sched.c
+++ b/kernel/time/tick-sched.c
@@ -434,6 +434,12 @@ static void tick_nohz_kick_task(struct task_struct *tsk)
 	 *   smp_mb__after_spin_lock()
 	 *   tick_nohz_task_switch()
 	 *     LOAD p->tick_dep_mask
+	 *
+	 * XXX given a task picks up the dependency on schedule(), should we
+	 * only care about tasks that are currently on the CPU instead of all
+	 * that are on the runqueue?
+	 *
+	 * That is, does this want to be: task_on_cpu() / task_curr()?
 	 */
 	if (!sched_task_on_rq(tsk))
 		return;
diff --git a/kernel/trace/trace_selftest.c b/kernel/trace/trace_selftest.c
index c4ad7cd..1469dd8 100644
--- a/kernel/trace/trace_selftest.c
+++ b/kernel/trace/trace_selftest.c
@@ -1485,7 +1485,7 @@ trace_selftest_startup_wakeup(struct tracer *trace, struct trace_array *tr)
 	/* reset the max latency */
 	tr->max_latency = 0;
 
-	while (p->on_rq) {
+	while (task_is_runnable(p)) {
 		/*
 		 * Sleep to make sure the -deadline thread is asleep too.
 		 * On virtual machines we can't rely on timings,
diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index 05cbb25..0c666f1 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -6387,7 +6387,7 @@ static void kvm_sched_out(struct preempt_notifier *pn,
 
 	WRITE_ONCE(vcpu->scheduled_out, true);
 
-	if (current->on_rq && vcpu->wants_to_run) {
+	if (task_is_runnable(current) && vcpu->wants_to_run) {
 		WRITE_ONCE(vcpu->preempted, true);
 		WRITE_ONCE(vcpu->ready, true);
 	}

