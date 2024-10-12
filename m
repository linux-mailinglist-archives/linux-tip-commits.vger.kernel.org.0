Return-Path: <linux-tip-commits+bounces-2399-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7972E99B565
	for <lists+linux-tip-commits@lfdr.de>; Sat, 12 Oct 2024 16:16:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9BF771C215B7
	for <lists+linux-tip-commits@lfdr.de>; Sat, 12 Oct 2024 14:16:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5767D1898F2;
	Sat, 12 Oct 2024 14:16:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="kzj5zkXH";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="2zwbb5l5"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 068CC1E526;
	Sat, 12 Oct 2024 14:16:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728742569; cv=none; b=dfOaZEWkf+/rhamcifhPp7Gyu4/BoaHpcVBgZg2QQ64hiI2nl7GzkEBvQRMGg058s7uVWakFSm5NMuHbXHRCnQl3FvGZgL1gOaQbgTpu5xqMrxozYzmTXPljxBNhrWrPQcNOtOcTFFKIPkch/QzB9S6HYxSLnXlunjWgXjwEaS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728742569; c=relaxed/simple;
	bh=q4lzSb4mhyElHXqrkJUtsN1mesy0JXYPWsfWQs++QBc=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=NssQ6E56Z7QUAdSrcNUE507TAWDPzhjo1IUBMkkBvvOEi5lIi7W068qZ9sQRBOoBzn8XuVXITUJq9ifA+PALznA+U71sS60DmehR16u9B0higizCX/mC/vjoEypDHhHvufgz1w0wkpZGGnVusJVgxFOf55rqVSJINxCUgJOwAuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=kzj5zkXH; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=2zwbb5l5; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sat, 12 Oct 2024 14:15:58 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1728742559;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DSJUsJmMXuNxAW3lPFWmBxeMILn5o2oWAWv+n5b7Cc4=;
	b=kzj5zkXHkN2HPUz3uiSRzulK2gc77hMWwigBp5f6BZUotkUSJU3mxfXblwBxRTknhWTxig
	OB50iS93GYEpYN5rS3vymMa1rPx9QsjCJ+HF3Rr4ccw5jEipM0xh+PtMoBwdcPM6qikTGs
	i1jt6CGCXzlLJWmXyain6S/EQ7MCPZ+3srHiPiGVnsQb/PMvx+B89ZC1vlEzPGRG2afARF
	9rRdREVxessgBiavuG3Km9T5ZYWID+ttePmgjkVCQ6H2qGWcR3Yhu+9k0nBwXhNKmyti2a
	xakPzRZFlq/JxWUAuyVC/b8NjDOXPKALwcucnD7KHKE6d4MovA5dnZSCLd696A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1728742559;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DSJUsJmMXuNxAW3lPFWmBxeMILn5o2oWAWv+n5b7Cc4=;
	b=2zwbb5l5PNfAWGstPWj63rc5fjl3FwERjjQcMrdKs0E7bXhGAcq83mT9OpWdWwtnF9fKxT
	Wk22Kho8mieWlgDQ==
From: "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: sched/urgent] sched: Fix external p->on_rq users
Cc: Sean Christopherson <seanjc@google.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20241010091843.GK33184@noisy.programming.kicks-ass.net>
References: <20241010091843.GK33184@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172874255804.1442.16221172414886128944.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the sched/urgent branch of tip:

Commit-ID:     1cc2f68c016ad3ac8b3a0495797dd61e19a10025
Gitweb:        https://git.kernel.org/tip/1cc2f68c016ad3ac8b3a0495797dd61e19a10025
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Thu, 10 Oct 2024 11:38:10 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 11 Oct 2024 10:49:33 +02:00

sched: Fix external p->on_rq users

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
Link: https://lkml.kernel.org/r/20241010091843.GK33184@noisy.programming.kicks-ass.net
---
 include/linux/sched.h         |  5 +++++
 kernel/events/core.c          |  2 +-
 kernel/freezer.c              |  7 ++++++-
 kernel/rcu/tasks.h            |  9 +++++++++
 kernel/sched/core.c           | 12 +++++++++---
 kernel/time/tick-sched.c      |  5 +++++
 kernel/trace/trace_selftest.c |  2 +-
 virt/kvm/kvm_main.c           |  2 +-
 8 files changed, 37 insertions(+), 7 deletions(-)

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
index 753a184..59efa14 100644
--- a/kernel/time/tick-sched.c
+++ b/kernel/time/tick-sched.c
@@ -435,6 +435,11 @@ static void tick_nohz_kick_task(struct task_struct *tsk)
 	 *   tick_nohz_task_switch()
 	 *     LOAD p->tick_dep_mask
 	 */
+	// XXX given a task picks up the dependency on schedule(), should we
+	// only care about tasks that are currently on the CPU instead of all
+	// that are on the runqueue?
+	//
+	// That is, does this want to be: task_on_cpu() / task_curr()?
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

