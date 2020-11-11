Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B9C472AEB26
	for <lists+linux-tip-commits@lfdr.de>; Wed, 11 Nov 2020 09:25:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726301AbgKKIYo (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 11 Nov 2020 03:24:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726299AbgKKIXW (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 11 Nov 2020 03:23:22 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC52BC0613D4;
        Wed, 11 Nov 2020 00:23:21 -0800 (PST)
Date:   Wed, 11 Nov 2020 08:23:19 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1605083000;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Vy6wZi3FBlGyJ1pxp9NaeHNZ5INWcwtwSjCg5FRVXaE=;
        b=poyO30pJReKsqkW5eV2HiQ6ApgwlfxLXC80EcPvGNFlrkZ/ccGsNGfBdViw9b8lknkLMyf
        o9WJMuO3w8pHBnKLhWA5kif39Wf/CgiZgL1OePEXLNvN62BJ6NK7CoC/gqhCOa4cPKlkND
        tw2KT4dwO+JxzlzG3PFRKmHUQAttPqjroCFC7qunZPkUM10neFcZLg61+uUX8/AES7aMO7
        phRbavvoGXezqFcg7NlnMkz1gdHFVnOsS3E2G4gDs16tgCcnQzXtLFYZs2+SjlNh/3aYSC
        vZSH1OcX2zzDknwpvORmbsoqtpWjwWMnRVaC/rffAsRAXzUm+TpLUwVt/5oQwQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1605083000;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Vy6wZi3FBlGyJ1pxp9NaeHNZ5INWcwtwSjCg5FRVXaE=;
        b=4yOGg/gQIjzSwB/OljAOokOKz7BCYpqojEjNG117vJCUGzBl6rezOhigaSTALDq0cS6PzN
        /ArHzoF7TH4R1vCA==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched: Fix migrate_disable() vs set_cpus_allowed_ptr()
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20201023102346.921768277@infradead.org>
References: <20201023102346.921768277@infradead.org>
MIME-Version: 1.0
Message-ID: <160508299932.11244.12438436189857516756.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     6d337eab041d56bb8f0e7794f39906c21054c512
Gitweb:        https://git.kernel.org/tip/6d337eab041d56bb8f0e7794f39906c21054c512
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Fri, 18 Sep 2020 17:24:31 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 10 Nov 2020 18:39:00 +01:00

sched: Fix migrate_disable() vs set_cpus_allowed_ptr()

Concurrent migrate_disable() and set_cpus_allowed_ptr() has
interesting features. We rely on set_cpus_allowed_ptr() to not return
until the task runs inside the provided mask. This expectation is
exported to userspace.

This means that any set_cpus_allowed_ptr() caller must wait until
migrate_enable() allows migrations.

At the same time, we don't want migrate_enable() to schedule, due to
patterns like:

	preempt_disable();
	migrate_disable();
	...
	migrate_enable();
	preempt_enable();

And:

	raw_spin_lock(&B);
	spin_unlock(&A);

this means that when migrate_enable() must restore the affinity
mask, it cannot wait for completion thereof. Luck will have it that
that is exactly the case where there is a pending
set_cpus_allowed_ptr(), so let that provide storage for the async stop
machine.

Much thanks to Valentin who used TLA+ most effective and found lots of
'interesting' cases.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Valentin Schneider <valentin.schneider@arm.com>
Reviewed-by: Daniel Bristot de Oliveira <bristot@redhat.com>
Link: https://lkml.kernel.org/r/20201023102346.921768277@infradead.org
---
 include/linux/sched.h |   1 +-
 kernel/sched/core.c   | 236 +++++++++++++++++++++++++++++++++++------
 2 files changed, 207 insertions(+), 30 deletions(-)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index 0732356..90a0c92 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -714,6 +714,7 @@ struct task_struct {
 	int				nr_cpus_allowed;
 	const cpumask_t			*cpus_ptr;
 	cpumask_t			cpus_mask;
+	void				*migration_pending;
 #if defined(CONFIG_SMP) && defined(CONFIG_PREEMPT_RT)
 	int				migration_disabled;
 #endif
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 6a3f1c2..0efc1e4 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -1732,15 +1732,26 @@ void migrate_enable(void)
 {
 	struct task_struct *p = current;
 
-	if (--p->migration_disabled)
+	if (p->migration_disabled > 1) {
+		p->migration_disabled--;
 		return;
+	}
 
+	/*
+	 * Ensure stop_task runs either before or after this, and that
+	 * __set_cpus_allowed_ptr(SCA_MIGRATE_ENABLE) doesn't schedule().
+	 */
+	preempt_disable();
+	if (p->cpus_ptr != &p->cpus_mask)
+		__set_cpus_allowed_ptr(p, &p->cpus_mask, SCA_MIGRATE_ENABLE);
+	/*
+	 * Mustn't clear migration_disabled() until cpus_ptr points back at the
+	 * regular cpus_mask, otherwise things that race (eg.
+	 * select_fallback_rq) get confused.
+	 */
 	barrier();
-
-	if (p->cpus_ptr == &p->cpus_mask)
-		return;
-
-	__set_cpus_allowed_ptr(p, &p->cpus_mask, SCA_MIGRATE_ENABLE);
+	p->migration_disabled = 0;
+	preempt_enable();
 }
 EXPORT_SYMBOL_GPL(migrate_enable);
 
@@ -1805,8 +1816,16 @@ static struct rq *move_queued_task(struct rq *rq, struct rq_flags *rf,
 }
 
 struct migration_arg {
-	struct task_struct *task;
-	int dest_cpu;
+	struct task_struct		*task;
+	int				dest_cpu;
+	struct set_affinity_pending	*pending;
+};
+
+struct set_affinity_pending {
+	refcount_t		refs;
+	struct completion	done;
+	struct cpu_stop_work	stop_work;
+	struct migration_arg	arg;
 };
 
 /*
@@ -1838,16 +1857,19 @@ static struct rq *__migrate_task(struct rq *rq, struct rq_flags *rf,
  */
 static int migration_cpu_stop(void *data)
 {
+	struct set_affinity_pending *pending;
 	struct migration_arg *arg = data;
 	struct task_struct *p = arg->task;
+	int dest_cpu = arg->dest_cpu;
 	struct rq *rq = this_rq();
+	bool complete = false;
 	struct rq_flags rf;
 
 	/*
 	 * The original target CPU might have gone down and we might
 	 * be on another CPU but it doesn't matter.
 	 */
-	local_irq_disable();
+	local_irq_save(rf.flags);
 	/*
 	 * We need to explicitly wake pending tasks before running
 	 * __migrate_task() such that we will not miss enforcing cpus_ptr
@@ -1857,21 +1879,83 @@ static int migration_cpu_stop(void *data)
 
 	raw_spin_lock(&p->pi_lock);
 	rq_lock(rq, &rf);
+
+	pending = p->migration_pending;
 	/*
 	 * If task_rq(p) != rq, it cannot be migrated here, because we're
 	 * holding rq->lock, if p->on_rq == 0 it cannot get enqueued because
 	 * we're holding p->pi_lock.
 	 */
 	if (task_rq(p) == rq) {
+		if (is_migration_disabled(p))
+			goto out;
+
+		if (pending) {
+			p->migration_pending = NULL;
+			complete = true;
+		}
+
+		/* migrate_enable() --  we must not race against SCA */
+		if (dest_cpu < 0) {
+			/*
+			 * When this was migrate_enable() but we no longer
+			 * have a @pending, a concurrent SCA 'fixed' things
+			 * and we should be valid again. Nothing to do.
+			 */
+			if (!pending) {
+				WARN_ON_ONCE(!is_cpu_allowed(p, cpu_of(rq)));
+				goto out;
+			}
+
+			dest_cpu = cpumask_any_distribute(&p->cpus_mask);
+		}
+
 		if (task_on_rq_queued(p))
-			rq = __migrate_task(rq, &rf, p, arg->dest_cpu);
+			rq = __migrate_task(rq, &rf, p, dest_cpu);
 		else
-			p->wake_cpu = arg->dest_cpu;
+			p->wake_cpu = dest_cpu;
+
+	} else if (dest_cpu < 0) {
+		/*
+		 * This happens when we get migrated between migrate_enable()'s
+		 * preempt_enable() and scheduling the stopper task. At that
+		 * point we're a regular task again and not current anymore.
+		 *
+		 * A !PREEMPT kernel has a giant hole here, which makes it far
+		 * more likely.
+		 */
+
+		/*
+		 * When this was migrate_enable() but we no longer have an
+		 * @pending, a concurrent SCA 'fixed' things and we should be
+		 * valid again. Nothing to do.
+		 */
+		if (!pending) {
+			WARN_ON_ONCE(!is_cpu_allowed(p, cpu_of(rq)));
+			goto out;
+		}
+
+		/*
+		 * When migrate_enable() hits a rq mis-match we can't reliably
+		 * determine is_migration_disabled() and so have to chase after
+		 * it.
+		 */
+		task_rq_unlock(rq, p, &rf);
+		stop_one_cpu_nowait(task_cpu(p), migration_cpu_stop,
+				    &pending->arg, &pending->stop_work);
+		return 0;
 	}
-	rq_unlock(rq, &rf);
-	raw_spin_unlock(&p->pi_lock);
+out:
+	task_rq_unlock(rq, p, &rf);
+
+	if (complete)
+		complete_all(&pending->done);
+
+	/* For pending->{arg,stop_work} */
+	pending = arg->pending;
+	if (pending && refcount_dec_and_test(&pending->refs))
+		wake_up_var(&pending->refs);
 
-	local_irq_enable();
 	return 0;
 }
 
@@ -1941,6 +2025,112 @@ void do_set_cpus_allowed(struct task_struct *p, const struct cpumask *new_mask)
 }
 
 /*
+ * This function is wildly self concurrent, consider at least 3 times.
+ */
+static int affine_move_task(struct rq *rq, struct task_struct *p, struct rq_flags *rf,
+			    int dest_cpu, unsigned int flags)
+{
+	struct set_affinity_pending my_pending = { }, *pending = NULL;
+	struct migration_arg arg = {
+		.task = p,
+		.dest_cpu = dest_cpu,
+	};
+	bool complete = false;
+
+	/* Can the task run on the task's current CPU? If so, we're done */
+	if (cpumask_test_cpu(task_cpu(p), &p->cpus_mask)) {
+		pending = p->migration_pending;
+		if (pending) {
+			refcount_inc(&pending->refs);
+			p->migration_pending = NULL;
+			complete = true;
+		}
+		task_rq_unlock(rq, p, rf);
+
+		if (complete)
+			goto do_complete;
+
+		return 0;
+	}
+
+	if (!(flags & SCA_MIGRATE_ENABLE)) {
+		/* serialized by p->pi_lock */
+		if (!p->migration_pending) {
+			refcount_set(&my_pending.refs, 1);
+			init_completion(&my_pending.done);
+			p->migration_pending = &my_pending;
+		} else {
+			pending = p->migration_pending;
+			refcount_inc(&pending->refs);
+		}
+	}
+	pending = p->migration_pending;
+	/*
+	 * - !MIGRATE_ENABLE:
+	 *   we'll have installed a pending if there wasn't one already.
+	 *
+	 * - MIGRATE_ENABLE:
+	 *   we're here because the current CPU isn't matching anymore,
+	 *   the only way that can happen is because of a concurrent
+	 *   set_cpus_allowed_ptr() call, which should then still be
+	 *   pending completion.
+	 *
+	 * Either way, we really should have a @pending here.
+	 */
+	if (WARN_ON_ONCE(!pending)) {
+		task_rq_unlock(rq, p, rf);
+		return -EINVAL;
+	}
+
+	if (flags & SCA_MIGRATE_ENABLE) {
+
+		refcount_inc(&pending->refs); /* pending->{arg,stop_work} */
+		task_rq_unlock(rq, p, rf);
+
+		pending->arg = (struct migration_arg) {
+			.task = p,
+			.dest_cpu = -1,
+			.pending = pending,
+		};
+
+		stop_one_cpu_nowait(cpu_of(rq), migration_cpu_stop,
+				    &pending->arg, &pending->stop_work);
+
+		return 0;
+	}
+
+	if (task_running(rq, p) || p->state == TASK_WAKING) {
+
+		task_rq_unlock(rq, p, rf);
+		stop_one_cpu(cpu_of(rq), migration_cpu_stop, &arg);
+
+	} else {
+
+		if (!is_migration_disabled(p)) {
+			if (task_on_rq_queued(p))
+				rq = move_queued_task(rq, rf, p, dest_cpu);
+
+			p->migration_pending = NULL;
+			complete = true;
+		}
+		task_rq_unlock(rq, p, rf);
+
+do_complete:
+		if (complete)
+			complete_all(&pending->done);
+	}
+
+	wait_for_completion(&pending->done);
+
+	if (refcount_dec_and_test(&pending->refs))
+		wake_up_var(&pending->refs);
+
+	wait_var_event(&my_pending.refs, !refcount_read(&my_pending.refs));
+
+	return 0;
+}
+
+/*
  * Change a given task's CPU affinity. Migrate the thread to a
  * proper CPU and schedule it away if the CPU it's executing on
  * is removed from the allowed bitmask.
@@ -2009,23 +2199,8 @@ static int __set_cpus_allowed_ptr(struct task_struct *p,
 			p->nr_cpus_allowed != 1);
 	}
 
-	/* Can the task run on the task's current CPU? If so, we're done */
-	if (cpumask_test_cpu(task_cpu(p), new_mask))
-		goto out;
+	return affine_move_task(rq, p, &rf, dest_cpu, flags);
 
-	if (task_running(rq, p) || p->state == TASK_WAKING) {
-		struct migration_arg arg = { p, dest_cpu };
-		/* Need help from migration thread: drop lock and wait. */
-		task_rq_unlock(rq, p, &rf);
-		stop_one_cpu(cpu_of(rq), migration_cpu_stop, &arg);
-		return 0;
-	} else if (task_on_rq_queued(p)) {
-		/*
-		 * OK, since we're going to drop the lock immediately
-		 * afterwards anyway.
-		 */
-		rq = move_queued_task(rq, &rf, p, dest_cpu);
-	}
 out:
 	task_rq_unlock(rq, p, &rf);
 
@@ -3205,6 +3380,7 @@ static void __sched_fork(unsigned long clone_flags, struct task_struct *p)
 	init_numa_balancing(clone_flags, p);
 #ifdef CONFIG_SMP
 	p->wake_entry.u_flags = CSD_TYPE_TTWU;
+	p->migration_pending = NULL;
 #endif
 }
 
