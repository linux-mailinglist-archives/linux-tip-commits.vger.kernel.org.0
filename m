Return-Path: <linux-tip-commits+bounces-6124-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 52A98B0732B
	for <lists+linux-tip-commits@lfdr.de>; Wed, 16 Jul 2025 12:20:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 842A1505E07
	for <lists+linux-tip-commits@lfdr.de>; Wed, 16 Jul 2025 10:19:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFC6D2F3C2B;
	Wed, 16 Jul 2025 10:19:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="IgUuimxP";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="zT5tpu6K"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A193E2F3645;
	Wed, 16 Jul 2025 10:19:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752661153; cv=none; b=BCFi3AlIqtOKNEEln75+Sql+T2cgjODNb+VLusHn21GdZfr4ws9vU1GCphYIrl+7cb/xfxLI7Jj0Xj+8jUsZi5S6rZvxrFKdiCcTHzWrP5Wr3xhui2CzHQJyjMjrbgi9RBaT27J8VvLR8E4mDkm2LNx/fc61TUe+a6/sY05ureo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752661153; c=relaxed/simple;
	bh=RKNLMQmyfTo1swR80zIawr0RFy6wqLjOQxgFPfgrfv4=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=WNAT6Qk5Sa7LZrWxuC5t9qdKPBdGrCm8Ow7cZcchxQojeEPSTby8JNfuV4Ax4ZtUQ903VIxewB77kqdoAhZjaDRhr4sO5b75+XYdLRLr9H745WijECBXzpUeQSDdxs6JKuj6UkgAhisu8DQJijF8EIyy2Jgghb3ZyTg71z9KNSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=IgUuimxP; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=zT5tpu6K; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 16 Jul 2025 10:19:07 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1752661149;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VHpZM+VGHHUP9PupzmrcjfIYPYf3kNIjN9OX9sOakq8=;
	b=IgUuimxPhjgMH0mIS/HA2aNvjYtoN7FLDvMVSsSBt+xwNoS1eePVx6FgT2hD02kcuKvOVf
	zR0q1XfnkjXYrog7KPCbHlVDU4nQt4Kme1XmqcR2Fsw8FWRfWHWXELWTGLEhtFB1kWHaMB
	zXgGG1k3kolfym6mXX3SmE2CM+uNp267/7CLrNSZXgh8es8gM/NKlafqjDq7DFU4YDnj4v
	2OnzecPC+FfojPRTkWl4mTQm0wsrdaYP00TZ5EEV04f/BOVnDWaWJTYB7lSKXUq9JKpq57
	5VY5/Dhg3Fj51HqJRz4KKhas3v2zxsfV+Ym9MN9vviFoYmXn1l6T4hp74YFbZg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1752661149;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VHpZM+VGHHUP9PupzmrcjfIYPYf3kNIjN9OX9sOakq8=;
	b=zT5tpu6Kat32555i2MJC/Yu3pdLBuP+p7owbT2dl63AI+QKuMcvymIxqXsh+nI3Uxl3PhK
	7+wMy9ks5+IZeqBw==
From: "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched: Start blocked_on chain processing in
 find_proxy_task()
Cc: "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Juri Lelli <juri.lelli@redhat.com>,
 Valentin Schneider <valentin.schneider@arm.com>,
 "Connor O'Brien" <connoro@google.com>, John Stultz <jstultz@google.com>,
 K Prateek Nayak <kprateek.nayak@amd.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250712033407.2383110-9-jstultz@google.com>
References: <20250712033407.2383110-9-jstultz@google.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175266114785.406.7717349342408539878.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     7de9d4f946383f48ec393b6e9ad0c20e49e174e7
Gitweb:        https://git.kernel.org/tip/7de9d4f946383f48ec393b6e9ad0c20e49e174e7
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Sat, 12 Jul 2025 03:33:49 
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 14 Jul 2025 17:16:33 +02:00

sched: Start blocked_on chain processing in find_proxy_task()

Start to flesh out the real find_proxy_task() implementation,
but avoid the migration cases for now, in those cases just
deactivate the donor task and pick again.

To ensure the donor task or other blocked tasks in the chain
aren't migrated away while we're running the proxy, also tweak
the fair class logic to avoid migrating donor or mutex blocked
tasks.

[jstultz: This change was split out from the larger proxy patch]
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Juri Lelli <juri.lelli@redhat.com>
Signed-off-by: Valentin Schneider <valentin.schneider@arm.com>
Signed-off-by: Connor O'Brien <connoro@google.com>
Signed-off-by: John Stultz <jstultz@google.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Tested-by: K Prateek Nayak <kprateek.nayak@amd.com>
Link: https://lkml.kernel.org/r/20250712033407.2383110-9-jstultz@google.com
---
 kernel/locking/mutex.h |   3 +-
 kernel/sched/core.c    | 146 +++++++++++++++++++++++++++++++++-------
 kernel/sched/fair.c    |  12 ++-
 3 files changed, 135 insertions(+), 26 deletions(-)

diff --git a/kernel/locking/mutex.h b/kernel/locking/mutex.h
index cbff35b..2e8080a 100644
--- a/kernel/locking/mutex.h
+++ b/kernel/locking/mutex.h
@@ -6,7 +6,7 @@
  *
  *  Copyright (C) 2004, 2005, 2006 Red Hat, Inc., Ingo Molnar <mingo@redhat.com>
  */
-
+#ifndef CONFIG_PREEMPT_RT
 /*
  * This is the control structure for tasks blocked on mutex, which resides
  * on the blocked task's kernel stack:
@@ -70,3 +70,4 @@ extern void debug_mutex_init(struct mutex *lock, const char *name,
 # define debug_mutex_unlock(lock)			do { } while (0)
 # define debug_mutex_init(lock, name, key)		do { } while (0)
 #endif /* !CONFIG_DEBUG_MUTEXES */
+#endif /* CONFIG_PREEMPT_RT */
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index a0b1120..f7f576a 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -96,6 +96,7 @@
 #include "../workqueue_internal.h"
 #include "../../io_uring/io-wq.h"
 #include "../smpboot.h"
+#include "../locking/mutex.h"
 
 EXPORT_TRACEPOINT_SYMBOL_GPL(ipi_send_cpu);
 EXPORT_TRACEPOINT_SYMBOL_GPL(ipi_send_cpumask);
@@ -2933,8 +2934,15 @@ static int affine_move_task(struct rq *rq, struct task_struct *p, struct rq_flag
 	struct set_affinity_pending my_pending = { }, *pending = NULL;
 	bool stop_pending, complete = false;
 
-	/* Can the task run on the task's current CPU? If so, we're done */
-	if (cpumask_test_cpu(task_cpu(p), &p->cpus_mask)) {
+	/*
+	 * Can the task run on the task's current CPU? If so, we're done
+	 *
+	 * We are also done if the task is the current donor, boosting a lock-
+	 * holding proxy, (and potentially has been migrated outside its
+	 * current or previous affinity mask)
+	 */
+	if (cpumask_test_cpu(task_cpu(p), &p->cpus_mask) ||
+	    (task_current_donor(rq, p) && !task_current(rq, p))) {
 		struct task_struct *push_task = NULL;
 
 		if ((flags & SCA_MIGRATE_ENABLE) &&
@@ -6573,11 +6581,12 @@ static bool try_to_block_task(struct rq *rq, struct task_struct *p,
 }
 
 #ifdef CONFIG_SCHED_PROXY_EXEC
-static inline void proxy_resched_idle(struct rq *rq)
+static inline struct task_struct *proxy_resched_idle(struct rq *rq)
 {
 	put_prev_set_next_task(rq, rq->donor, rq->idle);
 	rq_set_donor(rq, rq->idle);
 	set_tsk_need_resched(rq->idle);
+	return rq->idle;
 }
 
 static bool __proxy_deactivate(struct rq *rq, struct task_struct *donor)
@@ -6614,36 +6623,124 @@ static struct task_struct *proxy_deactivate(struct rq *rq, struct task_struct *d
 }
 
 /*
- * Initial simple sketch that just deactivates the blocked task
- * chosen by pick_next_task() so we can then pick something that
- * isn't blocked.
+ * Find runnable lock owner to proxy for mutex blocked donor
+ *
+ * Follow the blocked-on relation:
+ *   task->blocked_on -> mutex->owner -> task...
+ *
+ * Lock order:
+ *
+ *   p->pi_lock
+ *     rq->lock
+ *       mutex->wait_lock
+ *
+ * Returns the task that is going to be used as execution context (the one
+ * that is actually going to be run on cpu_of(rq)).
  */
 static struct task_struct *
 find_proxy_task(struct rq *rq, struct task_struct *donor, struct rq_flags *rf)
 {
+	struct task_struct *owner = NULL;
+	int this_cpu = cpu_of(rq);
+	struct task_struct *p;
 	struct mutex *mutex;
 
-	mutex = donor->blocked_on;
-	/* Something changed in the chain, so pick again */
-	if (!mutex)
-		return NULL;
-	/*
-	 * By taking mutex->wait_lock we hold off concurrent mutex_unlock()
-	 * and ensure @owner sticks around.
-	 */
-	guard(raw_spinlock)(&mutex->wait_lock);
+	/* Follow blocked_on chain. */
+	for (p = donor; task_is_blocked(p); p = owner) {
+		mutex = p->blocked_on;
+		/* Something changed in the chain, so pick again */
+		if (!mutex)
+			return NULL;
+		/*
+		 * By taking mutex->wait_lock we hold off concurrent mutex_unlock()
+		 * and ensure @owner sticks around.
+		 */
+		guard(raw_spinlock)(&mutex->wait_lock);
 
-	/* Check again that donor is blocked with blocked_lock held */
-	if (!task_is_blocked(donor) || mutex != __get_task_blocked_on(donor)) {
+		/* Check again that p is blocked with wait_lock held */
+		if (mutex != __get_task_blocked_on(p)) {
+			/*
+			 * Something changed in the blocked_on chain and
+			 * we don't know if only at this level. So, let's
+			 * just bail out completely and let __schedule()
+			 * figure things out (pick_again loop).
+			 */
+			return NULL;
+		}
+
+		owner = __mutex_owner(mutex);
+		if (!owner) {
+			__clear_task_blocked_on(p, mutex);
+			return p;
+		}
+
+		if (!READ_ONCE(owner->on_rq) || owner->se.sched_delayed) {
+			/* XXX Don't handle blocked owners/delayed dequeue yet */
+			return proxy_deactivate(rq, donor);
+		}
+
+		if (task_cpu(owner) != this_cpu) {
+			/* XXX Don't handle migrations yet */
+			return proxy_deactivate(rq, donor);
+		}
+
+		if (task_on_rq_migrating(owner)) {
+			/*
+			 * One of the chain of mutex owners is currently migrating to this
+			 * CPU, but has not yet been enqueued because we are holding the
+			 * rq lock. As a simple solution, just schedule rq->idle to give
+			 * the migration a chance to complete. Much like the migrate_task
+			 * case we should end up back in find_proxy_task(), this time
+			 * hopefully with all relevant tasks already enqueued.
+			 */
+			return proxy_resched_idle(rq);
+		}
+
+		/*
+		 * Its possible to race where after we check owner->on_rq
+		 * but before we check (owner_cpu != this_cpu) that the
+		 * task on another cpu was migrated back to this cpu. In
+		 * that case it could slip by our  checks. So double check
+		 * we are still on this cpu and not migrating. If we get
+		 * inconsistent results, try again.
+		 */
+		if (!task_on_rq_queued(owner) || task_cpu(owner) != this_cpu)
+			return NULL;
+
+		if (owner == p) {
+			/*
+			 * It's possible we interleave with mutex_unlock like:
+			 *
+			 *				lock(&rq->lock);
+			 *				  find_proxy_task()
+			 * mutex_unlock()
+			 *   lock(&wait_lock);
+			 *   donor(owner) = current->blocked_donor;
+			 *   unlock(&wait_lock);
+			 *
+			 *   wake_up_q();
+			 *     ...
+			 *       ttwu_runnable()
+			 *         __task_rq_lock()
+			 *				  lock(&wait_lock);
+			 *				  owner == p
+			 *
+			 * Which leaves us to finish the ttwu_runnable() and make it go.
+			 *
+			 * So schedule rq->idle so that ttwu_runnable() can get the rq
+			 * lock and mark owner as running.
+			 */
+			return proxy_resched_idle(rq);
+		}
 		/*
-		 * Something changed in the blocked_on chain and
-		 * we don't know if only at this level. So, let's
-		 * just bail out completely and let __schedule()
-		 * figure things out (pick_again loop).
+		 * OK, now we're absolutely sure @owner is on this
+		 * rq, therefore holding @rq->lock is sufficient to
+		 * guarantee its existence, as per ttwu_remote().
 		 */
-		return NULL; /* do pick_next_task() again */
 	}
-	return proxy_deactivate(rq, donor);
+
+	WARN_ON_ONCE(owner && !owner->on_rq);
+	return owner;
 }
 #else /* SCHED_PROXY_EXEC */
 static struct task_struct *
@@ -6801,10 +6898,13 @@ pick_again:
 		next = find_proxy_task(rq, next, &rf);
 		if (!next)
 			goto pick_again;
+		if (next == rq->idle)
+			goto keep_resched;
 	}
 picked:
 	clear_tsk_need_resched(prev);
 	clear_preempt_need_resched();
+keep_resched:
 	rq->last_seen_need_resched_ns = 0;
 
 	is_switch = prev != next;
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 9717645..b173a05 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -9291,7 +9291,8 @@ int can_migrate_task(struct task_struct *p, struct lb_env *env)
 	 * 2) throttled_lb_pair, or
 	 * 3) cannot be migrated to this CPU due to cpus_ptr, or
 	 * 4) running (obviously), or
-	 * 5) are cache-hot on their current CPU.
+	 * 5) are cache-hot on their current CPU, or
+	 * 6) are blocked on mutexes (if SCHED_PROXY_EXEC is enabled)
 	 */
 	if ((p->se.sched_delayed) && (env->migration_type != migrate_load))
 		return 0;
@@ -9313,6 +9314,9 @@ int can_migrate_task(struct task_struct *p, struct lb_env *env)
 	if (kthread_is_per_cpu(p))
 		return 0;
 
+	if (task_is_blocked(p))
+		return 0;
+
 	if (!cpumask_test_cpu(env->dst_cpu, p->cpus_ptr)) {
 		int cpu;
 
@@ -9348,7 +9352,8 @@ int can_migrate_task(struct task_struct *p, struct lb_env *env)
 	/* Record that we found at least one task that could run on dst_cpu */
 	env->flags &= ~LBF_ALL_PINNED;
 
-	if (task_on_cpu(env->src_rq, p)) {
+	if (task_on_cpu(env->src_rq, p) ||
+	    task_current_donor(env->src_rq, p)) {
 		schedstat_inc(p->stats.nr_failed_migrations_running);
 		return 0;
 	}
@@ -9392,6 +9397,9 @@ static void detach_task(struct task_struct *p, struct lb_env *env)
 		schedstat_inc(p->stats.nr_forced_migrations);
 	}
 
+	WARN_ON(task_current(env->src_rq, p));
+	WARN_ON(task_current_donor(env->src_rq, p));
+
 	deactivate_task(env->src_rq, p, DEQUEUE_NOCLOCK);
 	set_task_cpu(p, env->dst_cpu);
 }

