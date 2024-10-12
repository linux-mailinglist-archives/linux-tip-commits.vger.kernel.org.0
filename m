Return-Path: <linux-tip-commits+bounces-2403-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F16499B56D
	for <lists+linux-tip-commits@lfdr.de>; Sat, 12 Oct 2024 16:16:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1B02C1F217A7
	for <lists+linux-tip-commits@lfdr.de>; Sat, 12 Oct 2024 14:16:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 743501993B2;
	Sat, 12 Oct 2024 14:16:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Ocv83LS2";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="1DAMYg3f"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ED86155757;
	Sat, 12 Oct 2024 14:16:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728742572; cv=none; b=XNp+78RrLL4WeGTWmOB2Ia3QKICqRzsoOXI8Ih+s6ARW6GWmrUAHwWgOsutNyW/ZKA8vYVeeG9Q6HG/Qk+9RTK4sganOISEStOYW8XChIJhaio9ivRVXNw1aTYddCFFr6JdKEz5fjCxQBDPAGfiRmLxtklvvd9KrfV/PKoL4AII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728742572; c=relaxed/simple;
	bh=tpTWRA9aHEBcsxO6HTR7+bxkh15CTq/aTmfWu2ZQ2aY=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=aymVRfWGPM7qBKeR5XX1in0pz3e3RvYwzOF3JROYfi0d6u234ygfeTisvWRgkrvXx+iKStSSG8VgvMHVOj5KlGZgyTrpqv8vtE2MeqbXvy6E3X9pFOthG5XDwGjE0Km9HMcN/5ruiWKb8INZzqK3jqN2QrJmefU9KhsHGpc9xeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Ocv83LS2; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=1DAMYg3f; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sat, 12 Oct 2024 14:16:00 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1728742561;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pV8oUMHZnCLGMHBFwB0ZImYzUxhgk5xf56vebaK+nAA=;
	b=Ocv83LS2PcQVhvQngHZ24ar18Vxkmh8PkbypyJnToiQUJrjPDTXaDJKU/iw3JhkGnBcBOL
	l5OEUuAdohG3j4klXpsywaZwpEIY0zvQr1F/8SoIIB4tm5UmB8CLuDRUwFgR1UptPhxDJ2
	K2wE/gZPMZFf30QrVzhKTp7UOdy/6MFR7P4mkDaj/tf5GRxxu0dOpxClLHV/l3p4yTxXmL
	7L0z5kpzvCa3Ad3yUPjB/j6AtPv1nnf/d8NOsmzzgw2PE08/zAvhaR8hpsY8iC1t3rNcMr
	eScf+kPfCxjHSvkEeypWhtvxwArrD8gapgzD6CfAiILxqraPrpJWIkUvWcqBlQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1728742561;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pV8oUMHZnCLGMHBFwB0ZImYzUxhgk5xf56vebaK+nAA=;
	b=1DAMYg3fdgaw7MGw9f8TNMuPLPRIApzwthphGij0l2MRm/o0Md1se53gd2n/cgODbEMXAC
	HtsCqpM8c1XWV+AQ==
From: "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: sched/urgent] sched: Fix delayed_dequeue vs switched_from_fair()
Cc: "Paul E. McKenney" <paulmck@kernel.org>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20241003185037.GA5594@noisy.programming.kicks-ass.net>
References: <20241003185037.GA5594@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172874256025.1442.11846255500984808213.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the sched/urgent branch of tip:

Commit-ID:     98442f0ccd828ac42e89281a815e9e7a97533822
Gitweb:        https://git.kernel.org/tip/98442f0ccd828ac42e89281a815e9e7a97533822
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Thu, 10 Oct 2024 11:54:38 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 11 Oct 2024 10:49:32 +02:00

sched: Fix delayed_dequeue vs switched_from_fair()

Commit 2e0199df252a ("sched/fair: Prepare exit/cleanup paths for delayed_dequeue")
and its follow up fixes try to deal with a rather unfortunate
situation where is task is enqueued in a new class, even though it
shouldn't have been. Mostly because the existing ->switched_to/from()
hooks are in the wrong place for this case.

This all led to Paul being able to trigger failures at something like
once per 10k CPU hours of RCU torture.

For now, do the ugly thing and move the code to the right place by
ignoring the switch hooks.

Note: Clean up the whole sched_class::switch*_{to,from}() thing.

Fixes: 2e0199df252a ("sched/fair: Prepare exit/cleanup paths for delayed_dequeue")
Reported-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20241003185037.GA5594@noisy.programming.kicks-ass.net
---
 kernel/sched/core.c     | 29 ++++++++++++++++++-----------
 kernel/sched/ext.c      |  4 ++--
 kernel/sched/fair.c     | 16 ----------------
 kernel/sched/sched.h    |  2 +-
 kernel/sched/syscalls.c | 13 +++++++++----
 5 files changed, 30 insertions(+), 34 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 0259301..a860996 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -7010,20 +7010,20 @@ int default_wake_function(wait_queue_entry_t *curr, unsigned mode, int wake_flag
 }
 EXPORT_SYMBOL(default_wake_function);
 
-void __setscheduler_prio(struct task_struct *p, int prio)
+const struct sched_class *__setscheduler_class(struct task_struct *p, int prio)
 {
 	if (dl_prio(prio))
-		p->sched_class = &dl_sched_class;
-	else if (rt_prio(prio))
-		p->sched_class = &rt_sched_class;
+		return &dl_sched_class;
+
+	if (rt_prio(prio))
+		return &rt_sched_class;
+
 #ifdef CONFIG_SCHED_CLASS_EXT
-	else if (task_should_scx(p))
-		p->sched_class = &ext_sched_class;
+	if (task_should_scx(p))
+		return &ext_sched_class;
 #endif
-	else
-		p->sched_class = &fair_sched_class;
 
-	p->prio = prio;
+	return &fair_sched_class;
 }
 
 #ifdef CONFIG_RT_MUTEXES
@@ -7069,7 +7069,7 @@ void rt_mutex_setprio(struct task_struct *p, struct task_struct *pi_task)
 {
 	int prio, oldprio, queued, running, queue_flag =
 		DEQUEUE_SAVE | DEQUEUE_MOVE | DEQUEUE_NOCLOCK;
-	const struct sched_class *prev_class;
+	const struct sched_class *prev_class, *next_class;
 	struct rq_flags rf;
 	struct rq *rq;
 
@@ -7127,6 +7127,11 @@ void rt_mutex_setprio(struct task_struct *p, struct task_struct *pi_task)
 		queue_flag &= ~DEQUEUE_MOVE;
 
 	prev_class = p->sched_class;
+	next_class = __setscheduler_class(p, prio);
+
+	if (prev_class != next_class && p->se.sched_delayed)
+		dequeue_task(rq, p, DEQUEUE_SLEEP | DEQUEUE_DELAYED | DEQUEUE_NOCLOCK);
+
 	queued = task_on_rq_queued(p);
 	running = task_current(rq, p);
 	if (queued)
@@ -7164,7 +7169,9 @@ void rt_mutex_setprio(struct task_struct *p, struct task_struct *pi_task)
 			p->rt.timeout = 0;
 	}
 
-	__setscheduler_prio(p, prio);
+	p->sched_class = next_class;
+	p->prio = prio;
+
 	check_class_changing(rq, p, prev_class);
 
 	if (queued)
diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index 3cd7c50..6f9de57 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -4471,7 +4471,7 @@ static void scx_ops_disable_workfn(struct kthread_work *work)
 		sched_deq_and_put_task(p, DEQUEUE_SAVE | DEQUEUE_MOVE, &ctx);
 
 		p->scx.slice = min_t(u64, p->scx.slice, SCX_SLICE_DFL);
-		__setscheduler_prio(p, p->prio);
+		p->sched_class = __setscheduler_class(p, p->prio);
 		check_class_changing(task_rq(p), p, old_class);
 
 		sched_enq_and_set_task(&ctx);
@@ -5186,7 +5186,7 @@ static int scx_ops_enable(struct sched_ext_ops *ops, struct bpf_link *link)
 
 		sched_deq_and_put_task(p, DEQUEUE_SAVE | DEQUEUE_MOVE, &ctx);
 
-		__setscheduler_prio(p, p->prio);
+		p->sched_class = __setscheduler_class(p, p->prio);
 		check_class_changing(task_rq(p), p, old_class);
 
 		sched_enq_and_set_task(&ctx);
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index ab497fa..c157d48 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -13177,22 +13177,6 @@ static void attach_task_cfs_rq(struct task_struct *p)
 static void switched_from_fair(struct rq *rq, struct task_struct *p)
 {
 	detach_task_cfs_rq(p);
-	/*
-	 * Since this is called after changing class, this is a little weird
-	 * and we cannot use DEQUEUE_DELAYED.
-	 */
-	if (p->se.sched_delayed) {
-		/* First, dequeue it from its new class' structures */
-		dequeue_task(rq, p, DEQUEUE_NOCLOCK | DEQUEUE_SLEEP);
-		/*
-		 * Now, clean up the fair_sched_class side of things
-		 * related to sched_delayed being true and that wasn't done
-		 * due to the generic dequeue not using DEQUEUE_DELAYED.
-		 */
-		finish_delayed_dequeue_entity(&p->se);
-		p->se.rel_deadline = 0;
-		__block_task(rq, p);
-	}
 }
 
 static void switched_to_fair(struct rq *rq, struct task_struct *p)
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index b1c3588..fba524c 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -3797,7 +3797,7 @@ static inline int rt_effective_prio(struct task_struct *p, int prio)
 
 extern int __sched_setscheduler(struct task_struct *p, const struct sched_attr *attr, bool user, bool pi);
 extern int __sched_setaffinity(struct task_struct *p, struct affinity_context *ctx);
-extern void __setscheduler_prio(struct task_struct *p, int prio);
+extern const struct sched_class *__setscheduler_class(struct task_struct *p, int prio);
 extern void set_load_weight(struct task_struct *p, bool update_load);
 extern void enqueue_task(struct rq *rq, struct task_struct *p, int flags);
 extern bool dequeue_task(struct rq *rq, struct task_struct *p, int flags);
diff --git a/kernel/sched/syscalls.c b/kernel/sched/syscalls.c
index aa70bee..0470bcc 100644
--- a/kernel/sched/syscalls.c
+++ b/kernel/sched/syscalls.c
@@ -529,7 +529,7 @@ int __sched_setscheduler(struct task_struct *p,
 {
 	int oldpolicy = -1, policy = attr->sched_policy;
 	int retval, oldprio, newprio, queued, running;
-	const struct sched_class *prev_class;
+	const struct sched_class *prev_class, *next_class;
 	struct balance_callback *head;
 	struct rq_flags rf;
 	int reset_on_fork;
@@ -706,6 +706,12 @@ change:
 			queue_flags &= ~DEQUEUE_MOVE;
 	}
 
+	prev_class = p->sched_class;
+	next_class = __setscheduler_class(p, newprio);
+
+	if (prev_class != next_class && p->se.sched_delayed)
+		dequeue_task(rq, p, DEQUEUE_SLEEP | DEQUEUE_DELAYED | DEQUEUE_NOCLOCK);
+
 	queued = task_on_rq_queued(p);
 	running = task_current(rq, p);
 	if (queued)
@@ -713,11 +719,10 @@ change:
 	if (running)
 		put_prev_task(rq, p);
 
-	prev_class = p->sched_class;
-
 	if (!(attr->sched_flags & SCHED_FLAG_KEEP_PARAMS)) {
 		__setscheduler_params(p, attr);
-		__setscheduler_prio(p, newprio);
+		p->sched_class = next_class;
+		p->prio = newprio;
 	}
 	__setscheduler_uclamp(p, attr);
 	check_class_changing(rq, p, prev_class);

