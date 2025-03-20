Return-Path: <linux-tip-commits+bounces-4409-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ECFBCA6A205
	for <lists+linux-tip-commits@lfdr.de>; Thu, 20 Mar 2025 10:01:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 280C519C183A
	for <lists+linux-tip-commits@lfdr.de>; Thu, 20 Mar 2025 09:01:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AE83224226;
	Thu, 20 Mar 2025 09:00:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="iIg33Xde";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="EFWZn0gg"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69C7E223707;
	Thu, 20 Mar 2025 09:00:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742461211; cv=none; b=jpbQ+6FimYuWOJu/HNyNlcD6MXnVOf8qA2X0W4s/Jnkqx3UEtd3GoSnig/CeKAKbXKjoRFxfJ/7sSTC1zgdUBd24HP01Hm40b15hNDZCu7MQaeUpZybro8IyiAJHX4fDmYmu5xym55gDwT5LqmfIDLlkIrGdKM3CK/UDa/Zfqao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742461211; c=relaxed/simple;
	bh=SNHhtyIB3O6uhQ/brgAJYAoAT2lxSrS4Law703GLZAU=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=H21/r9EGKOPsaXuPdO9zlD8+C7Sv0jb9HHKgPzvp9UoBQMvp27MO8kDCOniBnpGKXWNts7p5qM6Z4JtwHaiXfkrFV6FLakbollksHTyyuvWcxuA90L/yegtQfAhrgFOjE207tIb/c864uK1qGkqRpLX6PT8xOcaYJX21Iq+2Hx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=iIg33Xde; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=EFWZn0gg; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 20 Mar 2025 09:00:05 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1742461206;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TMZDfrT3YY0pQ7BOd7QGT8F3oDwhA5dXxde6FMO1F1c=;
	b=iIg33XdenwGEtaCwMImW78tOfcMmHchotCv2gvuUkJS1LXSYbZjhSfh3HqAmP+uJTFiKFX
	jdhkhmcuXkvnFlBidW9PaLknHDG1j+/7n6QVGdaEPfbjfsQ8+QePZK2/ib8vtq/NaRsjln
	MyKVHJukiSlpNr70S4R4rhHbi+U17JODkZyDxAogNlAq48s7dp59tkJDt3Bg1hiOpL2h7L
	Q03ngoPp7TeFfH0EWVKKZJsSjvMi7zvxk77/gvq22fXbyJaY2kO7v2n+rnhqraSPxk25ax
	cEeGQ5mUlZZFPw6Z/lVzai/2l3TI1ES7B3yiHM5WsuH/ABzEo7iCIyi1vRyetA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1742461206;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TMZDfrT3YY0pQ7BOd7QGT8F3oDwhA5dXxde6FMO1F1c=;
	b=EFWZn0gg2EggjW0h2YHnYPJtFmc4BcckX289Exmwa2owa+5aDihNEwv4U/0qtpnDdh+b/R
	66yRIIj1tLOK6JBg==
From: "tip-bot2 for Ingo Molnar" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: sched/core] sched/debug: Change SCHED_WARN_ON() to WARN_ON_ONCE()
Cc: Ingo Molnar <mingo@kernel.org>, Shrikanth Hegde <sshegde@linux.ibm.com>,
 Peter Zijlstra <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>,
 Mel Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>,
 Linus Torvalds <torvalds@linux-foundation.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250317104257.3496611-2-mingo@kernel.org>
References: <20250317104257.3496611-2-mingo@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174246120542.14745.16936293992221722909.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     f7d2728cc032a23fccb5ecde69793a38eb30ba5c
Gitweb:        https://git.kernel.org/tip/f7d2728cc032a23fccb5ecde69793a38eb30ba5c
Author:        Ingo Molnar <mingo@kernel.org>
AuthorDate:    Mon, 17 Mar 2025 11:42:52 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Wed, 19 Mar 2025 22:20:53 +01:00

sched/debug: Change SCHED_WARN_ON() to WARN_ON_ONCE()

The scheduler has this special SCHED_WARN() facility that
depends on CONFIG_SCHED_DEBUG.

Since CONFIG_SCHED_DEBUG is getting removed, convert
SCHED_WARN() to WARN_ON_ONCE().

Note that the warning output isn't 100% equivalent:

   #define SCHED_WARN_ON(x)      WARN_ONCE(x, #x)

Because SCHED_WARN_ON() would output the 'x' condition
as well, while WARN_ONCE() will only show a backtrace.

Hopefully these are rare enough to not really matter.

If it does, we should probably introduce a new WARN_ON()
variant that outputs the condition in stringified form,
or improve WARN_ON() itself.

Signed-off-by: Ingo Molnar <mingo@kernel.org>
Tested-by: Shrikanth Hegde <sshegde@linux.ibm.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Juri Lelli <juri.lelli@redhat.com>
Cc: Vincent Guittot <vincent.guittot@linaro.org>
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Ben Segall <bsegall@google.com>
Cc: Mel Gorman <mgorman@suse.de>
Cc: Valentin Schneider <vschneid@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Link: https://lore.kernel.org/r/20250317104257.3496611-2-mingo@kernel.org
---
 kernel/sched/core.c       | 24 ++++++++--------
 kernel/sched/core_sched.c |  2 +-
 kernel/sched/deadline.c   | 12 ++++----
 kernel/sched/ext.c        |  2 +-
 kernel/sched/fair.c       | 58 +++++++++++++++++++-------------------
 kernel/sched/rt.c         |  2 +-
 kernel/sched/sched.h      | 16 +++-------
 kernel/sched/stats.h      |  2 +-
 8 files changed, 56 insertions(+), 62 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index affa99f..6f666b4 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -801,7 +801,7 @@ void update_rq_clock(struct rq *rq)
 
 #ifdef CONFIG_SCHED_DEBUG
 	if (sched_feat(WARN_DOUBLE_CLOCK))
-		SCHED_WARN_ON(rq->clock_update_flags & RQCF_UPDATED);
+		WARN_ON_ONCE(rq->clock_update_flags & RQCF_UPDATED);
 	rq->clock_update_flags |= RQCF_UPDATED;
 #endif
 	clock = sched_clock_cpu(cpu_of(rq));
@@ -1719,7 +1719,7 @@ static inline void uclamp_rq_dec_id(struct rq *rq, struct task_struct *p,
 
 	bucket = &uc_rq->bucket[uc_se->bucket_id];
 
-	SCHED_WARN_ON(!bucket->tasks);
+	WARN_ON_ONCE(!bucket->tasks);
 	if (likely(bucket->tasks))
 		bucket->tasks--;
 
@@ -1739,7 +1739,7 @@ static inline void uclamp_rq_dec_id(struct rq *rq, struct task_struct *p,
 	 * Defensive programming: this should never happen. If it happens,
 	 * e.g. due to future modification, warn and fix up the expected value.
 	 */
-	SCHED_WARN_ON(bucket->value > rq_clamp);
+	WARN_ON_ONCE(bucket->value > rq_clamp);
 	if (bucket->value >= rq_clamp) {
 		bkt_clamp = uclamp_rq_max_value(rq, clamp_id, uc_se->value);
 		uclamp_rq_set(rq, clamp_id, bkt_clamp);
@@ -2121,7 +2121,7 @@ void activate_task(struct rq *rq, struct task_struct *p, int flags)
 
 void deactivate_task(struct rq *rq, struct task_struct *p, int flags)
 {
-	SCHED_WARN_ON(flags & DEQUEUE_SLEEP);
+	WARN_ON_ONCE(flags & DEQUEUE_SLEEP);
 
 	WRITE_ONCE(p->on_rq, TASK_ON_RQ_MIGRATING);
 	ASSERT_EXCLUSIVE_WRITER(p->on_rq);
@@ -2726,7 +2726,7 @@ __do_set_cpus_allowed(struct task_struct *p, struct affinity_context *ctx)
 	 * XXX do further audits, this smells like something putrid.
 	 */
 	if (ctx->flags & SCA_MIGRATE_DISABLE)
-		SCHED_WARN_ON(!p->on_cpu);
+		WARN_ON_ONCE(!p->on_cpu);
 	else
 		lockdep_assert_held(&p->pi_lock);
 
@@ -4195,7 +4195,7 @@ int try_to_wake_up(struct task_struct *p, unsigned int state, int wake_flags)
 		 *  - we're serialized against set_special_state() by virtue of
 		 *    it disabling IRQs (this allows not taking ->pi_lock).
 		 */
-		SCHED_WARN_ON(p->se.sched_delayed);
+		WARN_ON_ONCE(p->se.sched_delayed);
 		if (!ttwu_state_match(p, state, &success))
 			goto out;
 
@@ -4489,7 +4489,7 @@ static void __sched_fork(unsigned long clone_flags, struct task_struct *p)
 	INIT_LIST_HEAD(&p->se.group_node);
 
 	/* A delayed task cannot be in clone(). */
-	SCHED_WARN_ON(p->se.sched_delayed);
+	WARN_ON_ONCE(p->se.sched_delayed);
 
 #ifdef CONFIG_FAIR_GROUP_SCHED
 	p->se.cfs_rq			= NULL;
@@ -5745,7 +5745,7 @@ static void sched_tick_remote(struct work_struct *work)
 			 * we are always sure that there is no proxy (only a
 			 * single task is running).
 			 */
-			SCHED_WARN_ON(rq->curr != rq->donor);
+			WARN_ON_ONCE(rq->curr != rq->donor);
 			update_rq_clock(rq);
 
 			if (!is_idle_task(curr)) {
@@ -5965,7 +5965,7 @@ static inline void schedule_debug(struct task_struct *prev, bool preempt)
 		preempt_count_set(PREEMPT_DISABLED);
 	}
 	rcu_sleep_check();
-	SCHED_WARN_ON(ct_state() == CT_STATE_USER);
+	WARN_ON_ONCE(ct_state() == CT_STATE_USER);
 
 	profile_hit(SCHED_PROFILING, __builtin_return_address(0));
 
@@ -6811,7 +6811,7 @@ static inline void sched_submit_work(struct task_struct *tsk)
 	 * deadlock if the callback attempts to acquire a lock which is
 	 * already acquired.
 	 */
-	SCHED_WARN_ON(current->__state & TASK_RTLOCK_WAIT);
+	WARN_ON_ONCE(current->__state & TASK_RTLOCK_WAIT);
 
 	/*
 	 * If we are going to sleep and we have plugged IO queued,
@@ -9249,7 +9249,7 @@ static void cpu_util_update_eff(struct cgroup_subsys_state *css)
 	unsigned int clamps;
 
 	lockdep_assert_held(&uclamp_mutex);
-	SCHED_WARN_ON(!rcu_read_lock_held());
+	WARN_ON_ONCE(!rcu_read_lock_held());
 
 	css_for_each_descendant_pre(css, top_css) {
 		uc_parent = css_tg(css)->parent
@@ -10584,7 +10584,7 @@ static void task_mm_cid_work(struct callback_head *work)
 	struct mm_struct *mm;
 	int weight, cpu;
 
-	SCHED_WARN_ON(t != container_of(work, struct task_struct, cid_work));
+	WARN_ON_ONCE(t != container_of(work, struct task_struct, cid_work));
 
 	work->next = work;	/* Prevent double-add */
 	if (t->flags & PF_EXITING)
diff --git a/kernel/sched/core_sched.c b/kernel/sched/core_sched.c
index 1ef98a9..c4606ca 100644
--- a/kernel/sched/core_sched.c
+++ b/kernel/sched/core_sched.c
@@ -65,7 +65,7 @@ static unsigned long sched_core_update_cookie(struct task_struct *p,
 	 * a cookie until after we've removed it, we must have core scheduling
 	 * enabled here.
 	 */
-	SCHED_WARN_ON((p->core_cookie || cookie) && !sched_core_enabled(rq));
+	WARN_ON_ONCE((p->core_cookie || cookie) && !sched_core_enabled(rq));
 
 	if (sched_core_enqueued(p))
 		sched_core_dequeue(rq, p, DEQUEUE_SAVE);
diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index 5dca336..d4f7cbf 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -249,8 +249,8 @@ void __add_running_bw(u64 dl_bw, struct dl_rq *dl_rq)
 
 	lockdep_assert_rq_held(rq_of_dl_rq(dl_rq));
 	dl_rq->running_bw += dl_bw;
-	SCHED_WARN_ON(dl_rq->running_bw < old); /* overflow */
-	SCHED_WARN_ON(dl_rq->running_bw > dl_rq->this_bw);
+	WARN_ON_ONCE(dl_rq->running_bw < old); /* overflow */
+	WARN_ON_ONCE(dl_rq->running_bw > dl_rq->this_bw);
 	/* kick cpufreq (see the comment in kernel/sched/sched.h). */
 	cpufreq_update_util(rq_of_dl_rq(dl_rq), 0);
 }
@@ -262,7 +262,7 @@ void __sub_running_bw(u64 dl_bw, struct dl_rq *dl_rq)
 
 	lockdep_assert_rq_held(rq_of_dl_rq(dl_rq));
 	dl_rq->running_bw -= dl_bw;
-	SCHED_WARN_ON(dl_rq->running_bw > old); /* underflow */
+	WARN_ON_ONCE(dl_rq->running_bw > old); /* underflow */
 	if (dl_rq->running_bw > old)
 		dl_rq->running_bw = 0;
 	/* kick cpufreq (see the comment in kernel/sched/sched.h). */
@@ -276,7 +276,7 @@ void __add_rq_bw(u64 dl_bw, struct dl_rq *dl_rq)
 
 	lockdep_assert_rq_held(rq_of_dl_rq(dl_rq));
 	dl_rq->this_bw += dl_bw;
-	SCHED_WARN_ON(dl_rq->this_bw < old); /* overflow */
+	WARN_ON_ONCE(dl_rq->this_bw < old); /* overflow */
 }
 
 static inline
@@ -286,10 +286,10 @@ void __sub_rq_bw(u64 dl_bw, struct dl_rq *dl_rq)
 
 	lockdep_assert_rq_held(rq_of_dl_rq(dl_rq));
 	dl_rq->this_bw -= dl_bw;
-	SCHED_WARN_ON(dl_rq->this_bw > old); /* underflow */
+	WARN_ON_ONCE(dl_rq->this_bw > old); /* underflow */
 	if (dl_rq->this_bw > old)
 		dl_rq->this_bw = 0;
-	SCHED_WARN_ON(dl_rq->running_bw > dl_rq->this_bw);
+	WARN_ON_ONCE(dl_rq->running_bw > dl_rq->this_bw);
 }
 
 static inline
diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index 0f1da19..953a5b9 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -2341,7 +2341,7 @@ static bool task_can_run_on_remote_rq(struct task_struct *p, struct rq *rq,
 {
 	int cpu = cpu_of(rq);
 
-	SCHED_WARN_ON(task_cpu(p) == cpu);
+	WARN_ON_ONCE(task_cpu(p) == cpu);
 
 	/*
 	 * If @p has migration disabled, @p->cpus_ptr is updated to contain only
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 9dafb37..89609eb 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -399,7 +399,7 @@ static inline void list_del_leaf_cfs_rq(struct cfs_rq *cfs_rq)
 
 static inline void assert_list_leaf_cfs_rq(struct rq *rq)
 {
-	SCHED_WARN_ON(rq->tmp_alone_branch != &rq->leaf_cfs_rq_list);
+	WARN_ON_ONCE(rq->tmp_alone_branch != &rq->leaf_cfs_rq_list);
 }
 
 /* Iterate through all leaf cfs_rq's on a runqueue */
@@ -696,7 +696,7 @@ static void update_entity_lag(struct cfs_rq *cfs_rq, struct sched_entity *se)
 {
 	s64 vlag, limit;
 
-	SCHED_WARN_ON(!se->on_rq);
+	WARN_ON_ONCE(!se->on_rq);
 
 	vlag = avg_vruntime(cfs_rq) - se->vruntime;
 	limit = calc_delta_fair(max_t(u64, 2*se->slice, TICK_NSEC), se);
@@ -3317,7 +3317,7 @@ static void task_numa_work(struct callback_head *work)
 	bool vma_pids_skipped;
 	bool vma_pids_forced = false;
 
-	SCHED_WARN_ON(p != container_of(work, struct task_struct, numa_work));
+	WARN_ON_ONCE(p != container_of(work, struct task_struct, numa_work));
 
 	work->next = work;
 	/*
@@ -4036,7 +4036,7 @@ static inline bool load_avg_is_decayed(struct sched_avg *sa)
 	 * Make sure that rounding and/or propagation of PELT values never
 	 * break this.
 	 */
-	SCHED_WARN_ON(sa->load_avg ||
+	WARN_ON_ONCE(sa->load_avg ||
 		      sa->util_avg ||
 		      sa->runnable_avg);
 
@@ -5460,7 +5460,7 @@ dequeue_entity(struct cfs_rq *cfs_rq, struct sched_entity *se, int flags)
 	clear_buddies(cfs_rq, se);
 
 	if (flags & DEQUEUE_DELAYED) {
-		SCHED_WARN_ON(!se->sched_delayed);
+		WARN_ON_ONCE(!se->sched_delayed);
 	} else {
 		bool delay = sleep;
 		/*
@@ -5470,7 +5470,7 @@ dequeue_entity(struct cfs_rq *cfs_rq, struct sched_entity *se, int flags)
 		if (flags & DEQUEUE_SPECIAL)
 			delay = false;
 
-		SCHED_WARN_ON(delay && se->sched_delayed);
+		WARN_ON_ONCE(delay && se->sched_delayed);
 
 		if (sched_feat(DELAY_DEQUEUE) && delay &&
 		    !entity_eligible(cfs_rq, se)) {
@@ -5551,7 +5551,7 @@ set_next_entity(struct cfs_rq *cfs_rq, struct sched_entity *se)
 	}
 
 	update_stats_curr_start(cfs_rq, se);
-	SCHED_WARN_ON(cfs_rq->curr);
+	WARN_ON_ONCE(cfs_rq->curr);
 	cfs_rq->curr = se;
 
 	/*
@@ -5592,7 +5592,7 @@ pick_next_entity(struct rq *rq, struct cfs_rq *cfs_rq)
 	if (sched_feat(PICK_BUDDY) &&
 	    cfs_rq->next && entity_eligible(cfs_rq, cfs_rq->next)) {
 		/* ->next will never be delayed */
-		SCHED_WARN_ON(cfs_rq->next->sched_delayed);
+		WARN_ON_ONCE(cfs_rq->next->sched_delayed);
 		return cfs_rq->next;
 	}
 
@@ -5628,7 +5628,7 @@ static void put_prev_entity(struct cfs_rq *cfs_rq, struct sched_entity *prev)
 		/* in !on_rq case, update occurred at dequeue */
 		update_load_avg(cfs_rq, prev, 0);
 	}
-	SCHED_WARN_ON(cfs_rq->curr != prev);
+	WARN_ON_ONCE(cfs_rq->curr != prev);
 	cfs_rq->curr = NULL;
 }
 
@@ -5851,7 +5851,7 @@ static int tg_unthrottle_up(struct task_group *tg, void *data)
 
 			cfs_rq->throttled_clock_self = 0;
 
-			if (SCHED_WARN_ON((s64)delta < 0))
+			if (WARN_ON_ONCE((s64)delta < 0))
 				delta = 0;
 
 			cfs_rq->throttled_clock_self_time += delta;
@@ -5871,7 +5871,7 @@ static int tg_throttle_down(struct task_group *tg, void *data)
 		cfs_rq->throttled_clock_pelt = rq_clock_pelt(rq);
 		list_del_leaf_cfs_rq(cfs_rq);
 
-		SCHED_WARN_ON(cfs_rq->throttled_clock_self);
+		WARN_ON_ONCE(cfs_rq->throttled_clock_self);
 		if (cfs_rq->nr_queued)
 			cfs_rq->throttled_clock_self = rq_clock(rq);
 	}
@@ -5980,7 +5980,7 @@ done:
 	 * throttled-list.  rq->lock protects completion.
 	 */
 	cfs_rq->throttled = 1;
-	SCHED_WARN_ON(cfs_rq->throttled_clock);
+	WARN_ON_ONCE(cfs_rq->throttled_clock);
 	if (cfs_rq->nr_queued)
 		cfs_rq->throttled_clock = rq_clock(rq);
 	return true;
@@ -6136,7 +6136,7 @@ static inline void __unthrottle_cfs_rq_async(struct cfs_rq *cfs_rq)
 	}
 
 	/* Already enqueued */
-	if (SCHED_WARN_ON(!list_empty(&cfs_rq->throttled_csd_list)))
+	if (WARN_ON_ONCE(!list_empty(&cfs_rq->throttled_csd_list)))
 		return;
 
 	first = list_empty(&rq->cfsb_csd_list);
@@ -6155,7 +6155,7 @@ static void unthrottle_cfs_rq_async(struct cfs_rq *cfs_rq)
 {
 	lockdep_assert_rq_held(rq_of(cfs_rq));
 
-	if (SCHED_WARN_ON(!cfs_rq_throttled(cfs_rq) ||
+	if (WARN_ON_ONCE(!cfs_rq_throttled(cfs_rq) ||
 	    cfs_rq->runtime_remaining <= 0))
 		return;
 
@@ -6191,7 +6191,7 @@ static bool distribute_cfs_runtime(struct cfs_bandwidth *cfs_b)
 			goto next;
 
 		/* By the above checks, this should never be true */
-		SCHED_WARN_ON(cfs_rq->runtime_remaining > 0);
+		WARN_ON_ONCE(cfs_rq->runtime_remaining > 0);
 
 		raw_spin_lock(&cfs_b->lock);
 		runtime = -cfs_rq->runtime_remaining + 1;
@@ -6212,7 +6212,7 @@ static bool distribute_cfs_runtime(struct cfs_bandwidth *cfs_b)
 				 * We currently only expect to be unthrottling
 				 * a single cfs_rq locally.
 				 */
-				SCHED_WARN_ON(!list_empty(&local_unthrottle));
+				WARN_ON_ONCE(!list_empty(&local_unthrottle));
 				list_add_tail(&cfs_rq->throttled_csd_list,
 					      &local_unthrottle);
 			}
@@ -6237,7 +6237,7 @@ next:
 
 		rq_unlock_irqrestore(rq, &rf);
 	}
-	SCHED_WARN_ON(!list_empty(&local_unthrottle));
+	WARN_ON_ONCE(!list_empty(&local_unthrottle));
 
 	rcu_read_unlock();
 
@@ -6789,7 +6789,7 @@ static void hrtick_start_fair(struct rq *rq, struct task_struct *p)
 {
 	struct sched_entity *se = &p->se;
 
-	SCHED_WARN_ON(task_rq(p) != rq);
+	WARN_ON_ONCE(task_rq(p) != rq);
 
 	if (rq->cfs.h_nr_queued > 1) {
 		u64 ran = se->sum_exec_runtime - se->prev_sum_exec_runtime;
@@ -6900,8 +6900,8 @@ requeue_delayed_entity(struct sched_entity *se)
 	 * Because a delayed entity is one that is still on
 	 * the runqueue competing until elegibility.
 	 */
-	SCHED_WARN_ON(!se->sched_delayed);
-	SCHED_WARN_ON(!se->on_rq);
+	WARN_ON_ONCE(!se->sched_delayed);
+	WARN_ON_ONCE(!se->on_rq);
 
 	if (sched_feat(DELAY_ZERO)) {
 		update_entity_lag(cfs_rq, se);
@@ -7161,8 +7161,8 @@ static int dequeue_entities(struct rq *rq, struct sched_entity *se, int flags)
 		rq->next_balance = jiffies;
 
 	if (p && task_delayed) {
-		SCHED_WARN_ON(!task_sleep);
-		SCHED_WARN_ON(p->on_rq != 1);
+		WARN_ON_ONCE(!task_sleep);
+		WARN_ON_ONCE(p->on_rq != 1);
 
 		/* Fix-up what dequeue_task_fair() skipped */
 		hrtick_update(rq);
@@ -8740,7 +8740,7 @@ static inline void set_task_max_allowed_capacity(struct task_struct *p) {}
 static void set_next_buddy(struct sched_entity *se)
 {
 	for_each_sched_entity(se) {
-		if (SCHED_WARN_ON(!se->on_rq))
+		if (WARN_ON_ONCE(!se->on_rq))
 			return;
 		if (se_is_idle(se))
 			return;
@@ -12484,7 +12484,7 @@ unlock:
 
 void nohz_balance_exit_idle(struct rq *rq)
 {
-	SCHED_WARN_ON(rq != this_rq());
+	WARN_ON_ONCE(rq != this_rq());
 
 	if (likely(!rq->nohz_tick_stopped))
 		return;
@@ -12520,7 +12520,7 @@ void nohz_balance_enter_idle(int cpu)
 {
 	struct rq *rq = cpu_rq(cpu);
 
-	SCHED_WARN_ON(cpu != smp_processor_id());
+	WARN_ON_ONCE(cpu != smp_processor_id());
 
 	/* If this CPU is going down, then nothing needs to be done: */
 	if (!cpu_active(cpu))
@@ -12603,7 +12603,7 @@ static void _nohz_idle_balance(struct rq *this_rq, unsigned int flags)
 	int balance_cpu;
 	struct rq *rq;
 
-	SCHED_WARN_ON((flags & NOHZ_KICK_MASK) == NOHZ_BALANCE_KICK);
+	WARN_ON_ONCE((flags & NOHZ_KICK_MASK) == NOHZ_BALANCE_KICK);
 
 	/*
 	 * We assume there will be no idle load after this update and clear
@@ -13043,7 +13043,7 @@ bool cfs_prio_less(const struct task_struct *a, const struct task_struct *b,
 	struct cfs_rq *cfs_rqb;
 	s64 delta;
 
-	SCHED_WARN_ON(task_rq(b)->core != rq->core);
+	WARN_ON_ONCE(task_rq(b)->core != rq->core);
 
 #ifdef CONFIG_FAIR_GROUP_SCHED
 	/*
@@ -13246,7 +13246,7 @@ static void switched_from_fair(struct rq *rq, struct task_struct *p)
 
 static void switched_to_fair(struct rq *rq, struct task_struct *p)
 {
-	SCHED_WARN_ON(p->se.sched_delayed);
+	WARN_ON_ONCE(p->se.sched_delayed);
 
 	attach_task_cfs_rq(p);
 
@@ -13281,7 +13281,7 @@ static void __set_next_task_fair(struct rq *rq, struct task_struct *p, bool firs
 	if (!first)
 		return;
 
-	SCHED_WARN_ON(se->sched_delayed);
+	WARN_ON_ONCE(se->sched_delayed);
 
 	if (hrtick_enabled_fair(rq))
 		hrtick_start_fair(rq, p);
diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
index 8cebe71..8b8d2c1 100644
--- a/kernel/sched/rt.c
+++ b/kernel/sched/rt.c
@@ -1713,7 +1713,7 @@ static struct sched_rt_entity *pick_next_rt_entity(struct rt_rq *rt_rq)
 	BUG_ON(idx >= MAX_RT_PRIO);
 
 	queue = array->queue + idx;
-	if (SCHED_WARN_ON(list_empty(queue)))
+	if (WARN_ON_ONCE(list_empty(queue)))
 		return NULL;
 	next = list_entry(queue->next, struct sched_rt_entity, run_list);
 
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 5d853f9..fadaabe 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -91,12 +91,6 @@ struct cpuidle_state;
 #include "cpupri.h"
 #include "cpudeadline.h"
 
-#ifdef CONFIG_SCHED_DEBUG
-# define SCHED_WARN_ON(x)      WARN_ONCE(x, #x)
-#else
-# define SCHED_WARN_ON(x)      ({ (void)(x), 0; })
-#endif
-
 /* task_struct::on_rq states: */
 #define TASK_ON_RQ_QUEUED	1
 #define TASK_ON_RQ_MIGRATING	2
@@ -1571,7 +1565,7 @@ static inline void update_idle_core(struct rq *rq) { }
 
 static inline struct task_struct *task_of(struct sched_entity *se)
 {
-	SCHED_WARN_ON(!entity_is_task(se));
+	WARN_ON_ONCE(!entity_is_task(se));
 	return container_of(se, struct task_struct, se);
 }
 
@@ -1652,7 +1646,7 @@ static inline void assert_clock_updated(struct rq *rq)
 	 * The only reason for not seeing a clock update since the
 	 * last rq_pin_lock() is if we're currently skipping updates.
 	 */
-	SCHED_WARN_ON(rq->clock_update_flags < RQCF_ACT_SKIP);
+	WARN_ON_ONCE(rq->clock_update_flags < RQCF_ACT_SKIP);
 }
 
 static inline u64 rq_clock(struct rq *rq)
@@ -1699,7 +1693,7 @@ static inline void rq_clock_cancel_skipupdate(struct rq *rq)
 static inline void rq_clock_start_loop_update(struct rq *rq)
 {
 	lockdep_assert_rq_held(rq);
-	SCHED_WARN_ON(rq->clock_update_flags & RQCF_ACT_SKIP);
+	WARN_ON_ONCE(rq->clock_update_flags & RQCF_ACT_SKIP);
 	rq->clock_update_flags |= RQCF_ACT_SKIP;
 }
 
@@ -1774,7 +1768,7 @@ static inline void rq_pin_lock(struct rq *rq, struct rq_flags *rf)
 	rq->clock_update_flags &= (RQCF_REQ_SKIP|RQCF_ACT_SKIP);
 	rf->clock_update_flags = 0;
 # ifdef CONFIG_SMP
-	SCHED_WARN_ON(rq->balance_callback && rq->balance_callback != &balance_push_callback);
+	WARN_ON_ONCE(rq->balance_callback && rq->balance_callback != &balance_push_callback);
 # endif
 #endif
 }
@@ -2685,7 +2679,7 @@ static inline void idle_set_state(struct rq *rq,
 
 static inline struct cpuidle_state *idle_get_state(struct rq *rq)
 {
-	SCHED_WARN_ON(!rcu_read_lock_held());
+	WARN_ON_ONCE(!rcu_read_lock_held());
 
 	return rq->idle_state;
 }
diff --git a/kernel/sched/stats.h b/kernel/sched/stats.h
index 19cdbe9..452826d 100644
--- a/kernel/sched/stats.h
+++ b/kernel/sched/stats.h
@@ -144,7 +144,7 @@ static inline void psi_enqueue(struct task_struct *p, int flags)
 
 	if (p->se.sched_delayed) {
 		/* CPU migration of "sleeping" task */
-		SCHED_WARN_ON(!(flags & ENQUEUE_MIGRATED));
+		WARN_ON_ONCE(!(flags & ENQUEUE_MIGRATED));
 		if (p->in_memstall)
 			set |= TSK_MEMSTALL;
 		if (p->in_iowait)

