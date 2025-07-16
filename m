Return-Path: <linux-tip-commits+bounces-6125-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 29F70B0732E
	for <lists+linux-tip-commits@lfdr.de>; Wed, 16 Jul 2025 12:20:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DE72E177B29
	for <lists+linux-tip-commits@lfdr.de>; Wed, 16 Jul 2025 10:19:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1EE72F4303;
	Wed, 16 Jul 2025 10:19:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="SLh1/7YZ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="WTws38qJ"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B4CC2309B2;
	Wed, 16 Jul 2025 10:19:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752661154; cv=none; b=p1W47QEE/ZxUW1bBCzHuDaUblKN2uAoJhoyWgCkBt6Tl0FaCxNqCUUpvfFteSOr3073hwqylLPpRa99icUhTeYfKMHNrQ4a2kx5DqoMm0LB2fuexHwEHS7nsIexvWMvpdinXGB7klDpEQH45m9eLz4yGLzOaColjPUyws18dIp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752661154; c=relaxed/simple;
	bh=s3mqHaY008HhCNhKeA+yfRfYjaxyJiSDlz1B8aL9g6k=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=l4LXqPnhwaGDI5Y3KN65viDWyOYoij12Y7k9u7s6TrnBFQgFa62BPNvsS7t99glcCldqiiXTPwgntZnfepcy0em4kPS8O35cvnNjlp/ykWFCuGLNo+J5SKRkaVw5RbrAMdQqAXt95N+dSGvYSAQmOfyrxzqJNsK4IS0e0SF0+mI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=SLh1/7YZ; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=WTws38qJ; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 16 Jul 2025 10:19:09 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1752661150;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qHH7rbDCXw7cAx1xPUyKeIY/SLYZ8qzwm9UhfViFy+o=;
	b=SLh1/7YZP9T0QhHQg1V1LISKEH1QLDJvonICzmezBFhHIzrxH76ErRYKGJbOR4jfL7nmyW
	L3zj0Oa++lfVDZ9ktUXWVI7liISfKE8iguhxgfRwpKp6u93mA8QYC2WSnguHIKr08DILv9
	zviUhpeFMVff7BaT8Gb1VYem75v2fvdxReapmok7je0NvChB7ozael6NZ7ya3eWc7KxVjU
	5Y4msW/0I6MALkJQ3hKAk90au/lPGGPvqDf9Qpf3+gckjCGHlIKaOSQ/yHHCsOSWBb1+T3
	0NtJbLK3LXFInRWPwrVcHM1S0JWUM7eCdIp+u9iDsOGqZodo7dx0YrpVXMXDBA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1752661150;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qHH7rbDCXw7cAx1xPUyKeIY/SLYZ8qzwm9UhfViFy+o=;
	b=WTws38qJ9oJMDO6JTo3e6HqATDTUDXqUKT8X/MWvu2TTXaedXL8SV0moZUdfp1iUbwqrRg
	hQD6QcbtcYY6EaDg==
From: "tip-bot2 for John Stultz" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched: Add an initial sketch of the
 find_proxy_task() function
Cc: John Stultz <jstultz@google.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 K Prateek Nayak <kprateek.nayak@amd.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250712033407.2383110-7-jstultz@google.com>
References: <20250712033407.2383110-7-jstultz@google.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175266114976.406.14071558270134791669.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     be41bde4c3a86de4be5cd3d1ca613e24664e68dc
Gitweb:        https://git.kernel.org/tip/be41bde4c3a86de4be5cd3d1ca613e24664e68dc
Author:        John Stultz <jstultz@google.com>
AuthorDate:    Sat, 12 Jul 2025 03:33:47 
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 14 Jul 2025 17:16:32 +02:00

sched: Add an initial sketch of the find_proxy_task() function

Add a find_proxy_task() function which doesn't do much.

When we select a blocked task to run, we will just deactivate it
and pick again. The exception being if it has become unblocked
after find_proxy_task() was called.

This allows us to validate keeping blocked tasks on the runqueue
and later deactivating them is working ok, stressing the failure
cases for when a proxy isn't found.

Greatly simplified from patch by:
  Peter Zijlstra (Intel) <peterz@infradead.org>
  Juri Lelli <juri.lelli@redhat.com>
  Valentin Schneider <valentin.schneider@arm.com>
  Connor O'Brien <connoro@google.com>

[jstultz: Split out from larger proxy patch and simplified
 for review and testing.]
Signed-off-by: John Stultz <jstultz@google.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Tested-by: K Prateek Nayak <kprateek.nayak@amd.com>
Link: https://lkml.kernel.org/r/20250712033407.2383110-7-jstultz@google.com
---
 kernel/sched/core.c  | 117 ++++++++++++++++++++++++++++++++++++++++--
 kernel/sched/sched.h |  10 +++-
 2 files changed, 121 insertions(+), 6 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index dd9f5c0..cb55d42 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -6522,11 +6522,13 @@ pick_next_task(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
 /*
  * Helper function for __schedule()
  *
- * If a task does not have signals pending, deactivate it
- * Otherwise marks the task's __state as RUNNING
+ * Tries to deactivate the task, unless the should_block arg
+ * is false or if a signal is pending. In the case a signal
+ * is pending, marks the task's __state as RUNNING (and clear
+ * blocked_on).
  */
 static bool try_to_block_task(struct rq *rq, struct task_struct *p,
-			      unsigned long *task_state_p)
+			      unsigned long *task_state_p, bool should_block)
 {
 	unsigned long task_state = *task_state_p;
 	int flags = DEQUEUE_NOCLOCK;
@@ -6537,6 +6539,16 @@ static bool try_to_block_task(struct rq *rq, struct task_struct *p,
 		return false;
 	}
 
+	/*
+	 * We check should_block after signal_pending because we
+	 * will want to wake the task in that case. But if
+	 * should_block is false, its likely due to the task being
+	 * blocked on a mutex, and we want to keep it on the runqueue
+	 * to be selectable for proxy-execution.
+	 */
+	if (!should_block)
+		return false;
+
 	p->sched_contributes_to_load =
 		(task_state & TASK_UNINTERRUPTIBLE) &&
 		!(task_state & TASK_NOLOAD) &&
@@ -6560,6 +6572,88 @@ static bool try_to_block_task(struct rq *rq, struct task_struct *p,
 	return true;
 }
 
+#ifdef CONFIG_SCHED_PROXY_EXEC
+static inline void proxy_resched_idle(struct rq *rq)
+{
+	put_prev_set_next_task(rq, rq->donor, rq->idle);
+	rq_set_donor(rq, rq->idle);
+	set_tsk_need_resched(rq->idle);
+}
+
+static bool __proxy_deactivate(struct rq *rq, struct task_struct *donor)
+{
+	unsigned long state = READ_ONCE(donor->__state);
+
+	/* Don't deactivate if the state has been changed to TASK_RUNNING */
+	if (state == TASK_RUNNING)
+		return false;
+	/*
+	 * Because we got donor from pick_next_task(), it is *crucial*
+	 * that we call proxy_resched_idle() before we deactivate it.
+	 * As once we deactivate donor, donor->on_rq is set to zero,
+	 * which allows ttwu() to immediately try to wake the task on
+	 * another rq. So we cannot use *any* references to donor
+	 * after that point. So things like cfs_rq->curr or rq->donor
+	 * need to be changed from next *before* we deactivate.
+	 */
+	proxy_resched_idle(rq);
+	return try_to_block_task(rq, donor, &state, true);
+}
+
+static struct task_struct *proxy_deactivate(struct rq *rq, struct task_struct *donor)
+{
+	if (!__proxy_deactivate(rq, donor)) {
+		/*
+		 * XXX: For now, if deactivation failed, set donor
+		 * as unblocked, as we aren't doing proxy-migrations
+		 * yet (more logic will be needed then).
+		 */
+		donor->blocked_on = NULL;
+	}
+	return NULL;
+}
+
+/*
+ * Initial simple sketch that just deactivates the blocked task
+ * chosen by pick_next_task() so we can then pick something that
+ * isn't blocked.
+ */
+static struct task_struct *
+find_proxy_task(struct rq *rq, struct task_struct *donor, struct rq_flags *rf)
+{
+	struct mutex *mutex;
+
+	mutex = donor->blocked_on;
+	/* Something changed in the chain, so pick again */
+	if (!mutex)
+		return NULL;
+	/*
+	 * By taking mutex->wait_lock we hold off concurrent mutex_unlock()
+	 * and ensure @owner sticks around.
+	 */
+	guard(raw_spinlock)(&mutex->wait_lock);
+
+	/* Check again that donor is blocked with blocked_lock held */
+	if (!task_is_blocked(donor) || mutex != __get_task_blocked_on(donor)) {
+		/*
+		 * Something changed in the blocked_on chain and
+		 * we don't know if only at this level. So, let's
+		 * just bail out completely and let __schedule()
+		 * figure things out (pick_again loop).
+		 */
+		return NULL; /* do pick_next_task() again */
+	}
+	return proxy_deactivate(rq, donor);
+}
+#else /* SCHED_PROXY_EXEC */
+static struct task_struct *
+find_proxy_task(struct rq *rq, struct task_struct *donor, struct rq_flags *rf)
+{
+	WARN_ONCE(1, "This should never be called in the !SCHED_PROXY_EXEC case\n");
+	return donor;
+}
+#endif /* SCHED_PROXY_EXEC */
+
 /*
  * __schedule() is the main scheduler function.
  *
@@ -6672,12 +6766,25 @@ static void __sched notrace __schedule(int sched_mode)
 			goto picked;
 		}
 	} else if (!preempt && prev_state) {
-		try_to_block_task(rq, prev, &prev_state);
+		/*
+		 * We pass task_is_blocked() as the should_block arg
+		 * in order to keep mutex-blocked tasks on the runqueue
+		 * for slection with proxy-exec (without proxy-exec
+		 * task_is_blocked() will always be false).
+		 */
+		try_to_block_task(rq, prev, &prev_state,
+				  !task_is_blocked(prev));
 		switch_count = &prev->nvcsw;
 	}
 
-	next = pick_next_task(rq, prev, &rf);
+pick_again:
+	next = pick_next_task(rq, rq->donor, &rf);
 	rq_set_donor(rq, next);
+	if (unlikely(task_is_blocked(next))) {
+		next = find_proxy_task(rq, next, &rf);
+		if (!next)
+			goto pick_again;
+	}
 picked:
 	clear_tsk_need_resched(prev);
 	clear_preempt_need_resched();
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index e53d0b8..d3f33d1 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -2262,6 +2262,14 @@ static inline int task_current_donor(struct rq *rq, struct task_struct *p)
 	return rq->donor == p;
 }
 
+static inline bool task_is_blocked(struct task_struct *p)
+{
+	if (!sched_proxy_exec())
+		return false;
+
+	return !!p->blocked_on;
+}
+
 static inline int task_on_cpu(struct rq *rq, struct task_struct *p)
 {
 	return p->on_cpu;
@@ -2459,7 +2467,7 @@ static inline void put_prev_set_next_task(struct rq *rq,
 					  struct task_struct *prev,
 					  struct task_struct *next)
 {
-	WARN_ON_ONCE(rq->curr != prev);
+	WARN_ON_ONCE(rq->donor != prev);
 
 	__put_prev_set_next_dl_server(rq, prev, next);
 

