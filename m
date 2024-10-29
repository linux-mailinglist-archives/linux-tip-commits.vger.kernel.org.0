Return-Path: <linux-tip-commits+bounces-2644-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8ABC89B4A9A
	for <lists+linux-tip-commits@lfdr.de>; Tue, 29 Oct 2024 14:06:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4901C283321
	for <lists+linux-tip-commits@lfdr.de>; Tue, 29 Oct 2024 13:06:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FB03206071;
	Tue, 29 Oct 2024 13:06:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="CDLToG+x";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Ie/Rz3q6"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0967520604E;
	Tue, 29 Oct 2024 13:06:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730207187; cv=none; b=r9nEzo+RM9SjG72Kcp2x5j++DFW7S8k78Lwr3amEKpc4UETOv/ngb1o1/6+twGq8DwOdIu8xsrqfeF3C5ZznEUHOVbot08NqbPLSx1o9cmanZKKCEIySHwmbEI+AhGRpHx9+0UB+xDjOI0y+SWNTJ27tV+G3uktxx3QBiOknaZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730207187; c=relaxed/simple;
	bh=qJlIu1rwSJaaeP6GDnUlzTvKn0eqh98EQrtqA3SthE4=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=DqIyISbhuxetZvf9pMSm6uwlHh96Fh6Dk8I8NXesloMRh2xDWFQN5Ci+drcu5E68dSG0cr8uJ3nZ92S6mkIo9HLxD5nWgGIUs+U/1XQ9rPJugaf39BlEv1XtVw2F1UDrr4B9RcBYtbNRYwx0O9vQJGdrU9nAx3mp1wcMz+5z0ec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=CDLToG+x; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Ie/Rz3q6; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 29 Oct 2024 13:06:21 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1730207183;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=rfCHrr8IyiHld6GvV2AfvBgiAma/q2lRww75s5sLxy0=;
	b=CDLToG+xFjrIfxKi52vWWfthKncSeBBGjcYtLr9vSp6yH27IlY4d49FlUf+YHCxE4y+cWp
	BFUwpMlr+Az5xkZ4XuvWVJ7lpEPwC6t2t/s2BVxDzmaIs2oj5UN7QpNbSdbOrMy1eUeI6H
	J/cGpNnlDKgKyvQMrCFz4vW9QRqpzUYsynj54qt/H1mDB60pMhApJI34+0PUWNmBjL/0dZ
	d7z8qYa8GwZEF9ueXNNvyQmDZ9HkMzBMZ33DOeRwOcbjjYWHzmEDYKt7St5mxXRC1qBUw4
	nSQR0VXxbLqnMl6dBgqHoZ3PMD10ywv0FawNU8TeAV6G19bGhB4zWP9rpAe7sw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1730207183;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=rfCHrr8IyiHld6GvV2AfvBgiAma/q2lRww75s5sLxy0=;
	b=Ie/Rz3q6cZt9l+rNOK45hL2h2sl9UsjmrOdwV92gcJoPlumNuK8V4pGjMOLMjm2KcCdOGv
	eEXpRbqkNiggwkAQ==
From: "tip-bot2 for Aboorva Devarajan" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: sched/urgent] sched: Pass correct scheduling policy to
 __setscheduler_class
Cc: Aboorva Devarajan <aboorvad@linux.ibm.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, Tejun Heo <tj@kernel.org>,
 x86@kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173020718190.1442.18044798383106446595.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the sched/urgent branch of tip:

Commit-ID:     5db91545ef8150c45a526675ef99e8998b648a41
Gitweb:        https://git.kernel.org/tip/5db91545ef8150c45a526675ef99e8998b648a41
Author:        Aboorva Devarajan <aboorvad@linux.ibm.com>
AuthorDate:    Sat, 26 Oct 2024 00:20:20 +05:30
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 29 Oct 2024 13:57:51 +01:00

sched: Pass correct scheduling policy to __setscheduler_class

Commit 98442f0ccd82 ("sched: Fix delayed_dequeue vs
switched_from_fair()") overlooked that __setscheduler_prio(), now
__setscheduler_class() relies on p->policy for task_should_scx(), and
moved the call before __setscheduler_params() updates it, causing it
to be using the old p->policy value.

Resolve this by changing task_should_scx() to take the policy itself
instead of a task pointer, such that __sched_setscheduler() can pass
in the updated policy.

Fixes: 98442f0ccd82 ("sched: Fix delayed_dequeue vs switched_from_fair()")
Signed-off-by: Aboorva Devarajan <aboorvad@linux.ibm.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Tejun Heo <tj@kernel.org>
---
 kernel/sched/core.c     | 8 ++++----
 kernel/sched/ext.c      | 8 ++++----
 kernel/sched/ext.h      | 2 +-
 kernel/sched/sched.h    | 2 +-
 kernel/sched/syscalls.c | 2 +-
 5 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index dbfb571..719e0ed 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -4711,7 +4711,7 @@ int sched_fork(unsigned long clone_flags, struct task_struct *p)
 	if (rt_prio(p->prio)) {
 		p->sched_class = &rt_sched_class;
 #ifdef CONFIG_SCHED_CLASS_EXT
-	} else if (task_should_scx(p)) {
+	} else if (task_should_scx(p->policy)) {
 		p->sched_class = &ext_sched_class;
 #endif
 	} else {
@@ -7025,7 +7025,7 @@ int default_wake_function(wait_queue_entry_t *curr, unsigned mode, int wake_flag
 }
 EXPORT_SYMBOL(default_wake_function);
 
-const struct sched_class *__setscheduler_class(struct task_struct *p, int prio)
+const struct sched_class *__setscheduler_class(int policy, int prio)
 {
 	if (dl_prio(prio))
 		return &dl_sched_class;
@@ -7034,7 +7034,7 @@ const struct sched_class *__setscheduler_class(struct task_struct *p, int prio)
 		return &rt_sched_class;
 
 #ifdef CONFIG_SCHED_CLASS_EXT
-	if (task_should_scx(p))
+	if (task_should_scx(policy))
 		return &ext_sched_class;
 #endif
 
@@ -7142,7 +7142,7 @@ void rt_mutex_setprio(struct task_struct *p, struct task_struct *pi_task)
 		queue_flag &= ~DEQUEUE_MOVE;
 
 	prev_class = p->sched_class;
-	next_class = __setscheduler_class(p, prio);
+	next_class = __setscheduler_class(p->policy, prio);
 
 	if (prev_class != next_class && p->se.sched_delayed)
 		dequeue_task(rq, p, DEQUEUE_SLEEP | DEQUEUE_DELAYED | DEQUEUE_NOCLOCK);
diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index 5900b06..40bdfe8 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -4256,14 +4256,14 @@ static const struct kset_uevent_ops scx_uevent_ops = {
  * Used by sched_fork() and __setscheduler_prio() to pick the matching
  * sched_class. dl/rt are already handled.
  */
-bool task_should_scx(struct task_struct *p)
+bool task_should_scx(int policy)
 {
 	if (!scx_enabled() ||
 	    unlikely(scx_ops_enable_state() == SCX_OPS_DISABLING))
 		return false;
 	if (READ_ONCE(scx_switching_all))
 		return true;
-	return p->policy == SCHED_EXT;
+	return policy == SCHED_EXT;
 }
 
 /**
@@ -4493,7 +4493,7 @@ static void scx_ops_disable_workfn(struct kthread_work *work)
 
 		sched_deq_and_put_task(p, DEQUEUE_SAVE | DEQUEUE_MOVE, &ctx);
 
-		p->sched_class = __setscheduler_class(p, p->prio);
+		p->sched_class = __setscheduler_class(p->policy, p->prio);
 		check_class_changing(task_rq(p), p, old_class);
 
 		sched_enq_and_set_task(&ctx);
@@ -5204,7 +5204,7 @@ static int scx_ops_enable(struct sched_ext_ops *ops, struct bpf_link *link)
 		sched_deq_and_put_task(p, DEQUEUE_SAVE | DEQUEUE_MOVE, &ctx);
 
 		p->scx.slice = SCX_SLICE_DFL;
-		p->sched_class = __setscheduler_class(p, p->prio);
+		p->sched_class = __setscheduler_class(p->policy, p->prio);
 		check_class_changing(task_rq(p), p, old_class);
 
 		sched_enq_and_set_task(&ctx);
diff --git a/kernel/sched/ext.h b/kernel/sched/ext.h
index 2460195..b1675bb 100644
--- a/kernel/sched/ext.h
+++ b/kernel/sched/ext.h
@@ -18,7 +18,7 @@ bool scx_can_stop_tick(struct rq *rq);
 void scx_rq_activate(struct rq *rq);
 void scx_rq_deactivate(struct rq *rq);
 int scx_check_setscheduler(struct task_struct *p, int policy);
-bool task_should_scx(struct task_struct *p);
+bool task_should_scx(int policy);
 void init_sched_ext_class(void);
 
 static inline u32 scx_cpuperf_target(s32 cpu)
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 9f9d1cc..6c54a57 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -3830,7 +3830,7 @@ static inline int rt_effective_prio(struct task_struct *p, int prio)
 
 extern int __sched_setscheduler(struct task_struct *p, const struct sched_attr *attr, bool user, bool pi);
 extern int __sched_setaffinity(struct task_struct *p, struct affinity_context *ctx);
-extern const struct sched_class *__setscheduler_class(struct task_struct *p, int prio);
+extern const struct sched_class *__setscheduler_class(int policy, int prio);
 extern void set_load_weight(struct task_struct *p, bool update_load);
 extern void enqueue_task(struct rq *rq, struct task_struct *p, int flags);
 extern bool dequeue_task(struct rq *rq, struct task_struct *p, int flags);
diff --git a/kernel/sched/syscalls.c b/kernel/sched/syscalls.c
index 0470bcc..24f9f90 100644
--- a/kernel/sched/syscalls.c
+++ b/kernel/sched/syscalls.c
@@ -707,7 +707,7 @@ change:
 	}
 
 	prev_class = p->sched_class;
-	next_class = __setscheduler_class(p, newprio);
+	next_class = __setscheduler_class(policy, newprio);
 
 	if (prev_class != next_class && p->se.sched_delayed)
 		dequeue_task(rq, p, DEQUEUE_SLEEP | DEQUEUE_DELAYED | DEQUEUE_NOCLOCK);

