Return-Path: <linux-tip-commits+bounces-6833-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 37F23BE26D4
	for <lists+linux-tip-commits@lfdr.de>; Thu, 16 Oct 2025 11:36:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D06473E32B9
	for <lists+linux-tip-commits@lfdr.de>; Thu, 16 Oct 2025 09:34:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 709883191B7;
	Thu, 16 Oct 2025 09:33:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="zIU9AixT";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="gg79J+Qi"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3982831AF0E;
	Thu, 16 Oct 2025 09:33:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760607212; cv=none; b=KA02qoALHp+bftD9icfS8pasA3LDmH1cKKBoUlk0ZywNYm2/yYx7xa+vCWa4PyfNvu8m/bvVwo2ewgOEcfK6jQX8Molq+FuWFxP9U1LWLoSBvjhEDac4jGfx2fZk+t8+6zS/mnQlAwEq8xU5ffhZ7AMzU2iSQKQFZBrgIeos+ZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760607212; c=relaxed/simple;
	bh=jY652Rui5ail7+8mA5NjYZLJrbU356IInrVwinptUiM=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=jfQVbzov+5WARk25HJAntk/GD5sfWWcJlZfI/GKIMZvJ0GexXJ7PhL9djOwiJm7gU0YhHHfjFeEc18/qNBJE7dY/wH7YU/twDozDfe+BIPpU2a0RAdrHq5t4U82JJwGycoNr5kfFQpiHxVNLrn1hQCeR2AqLfLLrJzFpmFKqd6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=zIU9AixT; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=gg79J+Qi; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 16 Oct 2025 09:33:27 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1760607208;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bGSAXtgfkv8B57ZMMbkbz4fRH8dq9pMLUPgMFNFt1OY=;
	b=zIU9AixTDSBRg8vjf8mbZrj58qxD6sMjL+jzexSAoG/M89HTcPCq6qeWmhQb/YbTDCDjB/
	yrx8xAxPZpZ6r2jmyUOvXzfaD4ZOEqUaIXhO5S1IgdGOpC9acFOpK1vryMP/DV2E2xP7L+
	XNmr674YaZoLVYwvw1EchVNdGsb4nPEhyc3hl84vAq6TwHHmLFcP62wPBFoKgZ0yPC81k0
	fkqP+HS0BSUv8iGhe4V0QHx8DqFoxgXXiKCiVyPCS/AKWkPpliy+lrvQzFpDZ3BCxEUzl8
	Fh+3uhwTkvdfnnTqH/Hdezha9B0CF73LN8mzoJ8LUKWCJTr9AvyiDNrn7pSJog==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1760607208;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bGSAXtgfkv8B57ZMMbkbz4fRH8dq9pMLUPgMFNFt1OY=;
	b=gg79J+Qi5byiOUe2FYhSusUHSw2lgSls2Y/1Jxh3U2kd2mnYOSfqD6U9dbn/Ipf+wr5N0v
	5lgytxOUJ06dpzDg==
From: "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched: Add locking comments to sched_class methods
Cc: "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Juri Lelli <juri.lelli@redhat.com>, Tejun Heo <tj@kernel.org>,
 Vincent Guittot <vincent.guittot@linaro.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20251006104527.694841522@infradead.org>
References: <20251006104527.694841522@infradead.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176060720733.709179.731528996537559055.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     46a177fb01e52ec0e3f9eab9b217a0f7c8909eeb
Gitweb:        https://git.kernel.org/tip/46a177fb01e52ec0e3f9eab9b217a0f7c89=
09eeb
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Tue, 09 Sep 2025 11:58:02 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Thu, 16 Oct 2025 11:13:53 +02:00

sched: Add locking comments to sched_class methods

'Document' the locking context the various sched_class methods are
called under.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Juri Lelli <juri.lelli@redhat.com>
Acked-by: Tejun Heo <tj@kernel.org>
Acked-by: Vincent Guittot <vincent.guittot@linaro.org>
---
 kernel/sched/core.c  |   6 +-
 kernel/sched/sched.h | 108 +++++++++++++++++++++++++++++++++++++++---
 2 files changed, 105 insertions(+), 9 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index e932439..8c55740 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -583,8 +583,8 @@ EXPORT_SYMBOL(__trace_set_current_state);
  *
  * p->on_rq <- { 0, 1 =3D TASK_ON_RQ_QUEUED, 2 =3D TASK_ON_RQ_MIGRATING }:
  *
- *   is set by activate_task() and cleared by deactivate_task(), under
- *   rq->lock. Non-zero indicates the task is runnable, the special
+ *   is set by activate_task() and cleared by deactivate_task()/block_task(),
+ *   under rq->lock. Non-zero indicates the task is runnable, the special
  *   ON_RQ_MIGRATING state is used for migration without holding both
  *   rq->locks. It indicates task_cpu() is not stable, see task_rq_lock().
  *
@@ -4162,7 +4162,7 @@ int try_to_wake_up(struct task_struct *p, unsigned int =
state, int wake_flags)
 		 * __schedule().  See the comment for smp_mb__after_spinlock().
 		 *
 		 * Form a control-dep-acquire with p->on_rq =3D=3D 0 above, to ensure
-		 * schedule()'s deactivate_task() has 'happened' and p will no longer
+		 * schedule()'s block_task() has 'happened' and p will no longer
 		 * care about it's own p->state. See the comment in __schedule().
 		 */
 		smp_acquire__after_ctrl_dep();
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index ea2ea8f..3462145 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -2345,8 +2345,7 @@ extern const u32		sched_prio_to_wmult[40];
 /*
  * {de,en}queue flags:
  *
- * DEQUEUE_SLEEP  - task is no longer runnable
- * ENQUEUE_WAKEUP - task just became runnable
+ * SLEEP/WAKEUP - task is no-longer/just-became runnable
  *
  * SAVE/RESTORE - an otherwise spurious dequeue/enqueue, done to ensure tasks
  *                are in a known state which allows modification. Such pairs
@@ -2359,11 +2358,18 @@ extern const u32		sched_prio_to_wmult[40];
  *
  * MIGRATION - p->on_rq =3D=3D TASK_ON_RQ_MIGRATING (used for DEADLINE)
  *
+ * DELAYED - de/re-queue a sched_delayed task
+ *
+ * CLASS - going to update p->sched_class; makes sched_change call the
+ *         various switch methods.
+ *
  * ENQUEUE_HEAD      - place at front of runqueue (tail if not specified)
  * ENQUEUE_REPLENISH - CBS (replenish runtime and postpone deadline)
  * ENQUEUE_MIGRATED  - the task was migrated during wakeup
  * ENQUEUE_RQ_SELECTED - ->select_task_rq() was called
  *
+ * XXX SAVE/RESTORE in combination with CLASS doesn't really make sense, but
+ * SCHED_DEADLINE seems to rely on this for now.
  */
=20
 #define DEQUEUE_SLEEP		0x0001 /* Matches ENQUEUE_WAKEUP */
@@ -2409,14 +2415,50 @@ struct sched_class {
 	int uclamp_enabled;
 #endif
=20
+	/*
+	 * move_queued_task/activate_task/enqueue_task: rq->lock
+	 * ttwu_do_activate/activate_task/enqueue_task: rq->lock
+	 * wake_up_new_task/activate_task/enqueue_task: task_rq_lock
+	 * ttwu_runnable/enqueue_task: task_rq_lock
+	 * proxy_task_current: rq->lock
+	 * sched_change_end
+	 */
 	void (*enqueue_task) (struct rq *rq, struct task_struct *p, int flags);
+	/*
+	 * move_queued_task/deactivate_task/dequeue_task: rq->lock
+	 * __schedule/block_task/dequeue_task: rq->lock
+	 * proxy_task_current: rq->lock
+	 * wait_task_inactive: task_rq_lock
+	 * sched_change_begin
+	 */
 	bool (*dequeue_task) (struct rq *rq, struct task_struct *p, int flags);
+
+	/*
+	 * do_sched_yield: rq->lock
+	 */
 	void (*yield_task)   (struct rq *rq);
+	/*
+	 * yield_to: rq->lock (double)
+	 */
 	bool (*yield_to_task)(struct rq *rq, struct task_struct *p);
=20
+	/*
+	 * move_queued_task: rq->lock
+	 * __migrate_swap_task: rq->lock
+	 * ttwu_do_activate: rq->lock
+	 * ttwu_runnable: task_rq_lock
+	 * wake_up_new_task: task_rq_lock
+	 */
 	void (*wakeup_preempt)(struct rq *rq, struct task_struct *p, int flags);
=20
+	/*
+	 * schedule/pick_next_task/prev_balance: rq->lock
+	 */
 	int (*balance)(struct rq *rq, struct task_struct *prev, struct rq_flags *rf=
);
+
+	/*
+	 * schedule/pick_next_task: rq->lock
+	 */
 	struct task_struct *(*pick_task)(struct rq *rq);
 	/*
 	 * Optional! When implemented pick_next_task() should be equivalent to:
@@ -2429,48 +2471,102 @@ struct sched_class {
 	 */
 	struct task_struct *(*pick_next_task)(struct rq *rq, struct task_struct *pr=
ev);
=20
+	/*
+	 * sched_change:
+	 * __schedule: rq->lock
+	 */
 	void (*put_prev_task)(struct rq *rq, struct task_struct *p, struct task_str=
uct *next);
 	void (*set_next_task)(struct rq *rq, struct task_struct *p, bool first);
=20
+	/*
+	 * select_task_rq: p->pi_lock
+	 * sched_exec: p->pi_lock
+	 */
 	int  (*select_task_rq)(struct task_struct *p, int task_cpu, int flags);
=20
+	/*
+	 * set_task_cpu: p->pi_lock || rq->lock (ttwu like)
+	 */
 	void (*migrate_task_rq)(struct task_struct *p, int new_cpu);
=20
+	/*
+	 * ttwu_do_activate: rq->lock
+	 * wake_up_new_task: task_rq_lock
+	 */
 	void (*task_woken)(struct rq *this_rq, struct task_struct *task);
=20
+	/*
+	 * do_set_cpus_allowed: task_rq_lock + sched_change
+	 */
 	void (*set_cpus_allowed)(struct task_struct *p, struct affinity_context *ct=
x);
=20
+	/*
+	 * sched_set_rq_{on,off}line: rq->lock
+	 */
 	void (*rq_online)(struct rq *rq);
 	void (*rq_offline)(struct rq *rq);
=20
+	/*
+	 * push_cpu_stop: p->pi_lock && rq->lock
+	 */
 	struct rq *(*find_lock_rq)(struct task_struct *p, struct rq *rq);
=20
+	/*
+	 * hrtick: rq->lock
+	 * sched_tick: rq->lock
+	 * sched_tick_remote: rq->lock
+	 */
 	void (*task_tick)(struct rq *rq, struct task_struct *p, int queued);
+	/*
+	 * sched_cgroup_fork: p->pi_lock
+	 */
 	void (*task_fork)(struct task_struct *p);
+	/*
+	 * finish_task_switch: no locks
+	 */
 	void (*task_dead)(struct task_struct *p);
=20
+	/*
+	 * sched_change
+	 */
 	void (*switching_from)(struct rq *this_rq, struct task_struct *task);
 	void (*switched_from) (struct rq *this_rq, struct task_struct *task);
 	void (*switching_to)  (struct rq *this_rq, struct task_struct *task);
 	void (*switched_to)   (struct rq *this_rq, struct task_struct *task);
-
-	void (*reweight_task)(struct rq *this_rq, struct task_struct *task,
-			      const struct load_weight *lw);
-
 	u64  (*get_prio)     (struct rq *this_rq, struct task_struct *task);
 	void (*prio_changed) (struct rq *this_rq, struct task_struct *task,
 			      u64 oldprio);
=20
+	/*
+	 * set_load_weight: task_rq_lock + sched_change
+	 * __setscheduler_parms: task_rq_lock + sched_change
+	 */
+	void (*reweight_task)(struct rq *this_rq, struct task_struct *task,
+			      const struct load_weight *lw);
+
+	/*
+	 * sched_rr_get_interval: task_rq_lock
+	 */
 	unsigned int (*get_rr_interval)(struct rq *rq,
 					struct task_struct *task);
=20
+	/*
+	 * task_sched_runtime: task_rq_lock
+	 */
 	void (*update_curr)(struct rq *rq);
=20
 #ifdef CONFIG_FAIR_GROUP_SCHED
+	/*
+	 * sched_change_group: task_rq_lock + sched_change
+	 */
 	void (*task_change_group)(struct task_struct *p);
 #endif
=20
 #ifdef CONFIG_SCHED_CORE
+	/*
+	 * pick_next_task: rq->lock
+	 * try_steal_cookie: rq->lock (double)
+	 */
 	int (*task_is_throttled)(struct task_struct *p, int cpu);
 #endif
 };

