Return-Path: <linux-tip-commits+bounces-1991-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 53D3794BA96
	for <lists+linux-tip-commits@lfdr.de>; Thu,  8 Aug 2024 12:14:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0F04D2833AC
	for <lists+linux-tip-commits@lfdr.de>; Thu,  8 Aug 2024 10:14:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75993189F48;
	Thu,  8 Aug 2024 10:14:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="sZnD6nQf";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Ik8fjYs1"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 795EF13AA31;
	Thu,  8 Aug 2024 10:14:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723112079; cv=none; b=NFI5cXFqMHM8n7TTsZCFHeW3EZF+kImdREfnRmVQp8UMYP3Ql0rchVdYLSUxCh6HoeXJWhLA3VrAfEDzJJMBKC9+tglLCy+vljgjiztxCDrajaHM91QKgYdPJtJkc8SkP/4UQYbcf4OJ7388iq3nk0Q7ZMv3i73v3+YQj0oWE+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723112079; c=relaxed/simple;
	bh=4NMp+MoANrwwTO3a7QxeZtmEqXehRiizKHON4yNQHk8=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=Ngp8Ok2DjGybjKudM7iFro4LRMl21AakqYcLaOcEwkapkyKLNat54mEOsMgqPDAHaNIaIx1vMbZ54Cce0jkPURkn3SbYbL8hIE56VH6NaRVIw12cEmeQ2I0GzZPgW6xE99vg7l6tQ9ahO10TWXxFDJ2O5z3kE5qEF4eBuP76mKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=sZnD6nQf; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Ik8fjYs1; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 08 Aug 2024 10:14:34 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1723112075;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SnfTHFxXlRMMf0zE7mS8Xf4F1uoZkznrJ4DegBq8T/8=;
	b=sZnD6nQfnJz9G+ogBjjs07l2Sr0j4KoY+aGivy2rP2E7sPV4nwobXrilaihojCNas58p4t
	UZeDP1CVp509Vj0CrtMhcS8Pwnt0mC4NuEjwSnTxkjG6WOCNxqakjf9CKHrJCqXMVpjeWR
	C1+A4O52vOg3Cio0Kehy/TyfG84zjJl96+iPPLlejNnTR3Nj92g5UKvNogzYdDavgw9jK5
	jQy9bb9Qki16Y5/zqwlj9pxC8HMcWSQVK5gzTETvIBx6kj9vF/ZbHhK404bVYzQwZm5hHj
	p1F9IX7SrXMrWXsd+vmqkHE/QnqbtEA85RIlNqOXLAQiU80uN6M+2XO4KL3qbw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1723112075;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SnfTHFxXlRMMf0zE7mS8Xf4F1uoZkznrJ4DegBq8T/8=;
	b=Ik8fjYs1WVbONgfDzX0Qh8WwHTmzxvV91CmmXYXJWQ4DrnHrfed1UrEeYG4Wd7k9aYgRRJ
	PkeuNuocDTdeViCQ==
From: "tip-bot2 for Qais Yousef" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/rt: Rename realtime_{prio, task}() to
 rt_or_dl_{prio, task}()
Cc: Daniel Bristot de Oliveira <bristot@redhat.com>,
 Qais Yousef <qyousef@layalina.io>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240610192018.1567075-4-qyousef@layalina.io>
References: <20240610192018.1567075-4-qyousef@layalina.io>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172311207472.2215.2624137390891630093.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     ae04f69de0bef93c7086cf2983dbc8e8fd624ebe
Gitweb:        https://git.kernel.org/tip/ae04f69de0bef93c7086cf2983dbc8e8fd624ebe
Author:        Qais Yousef <qyousef@layalina.io>
AuthorDate:    Mon, 10 Jun 2024 20:20:18 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 07 Aug 2024 18:32:38 +02:00

sched/rt: Rename realtime_{prio, task}() to rt_or_dl_{prio, task}()

Some find the name realtime overloaded. Use rt_or_dl() as an
alternative, hopefully better, name.

Suggested-by: Daniel Bristot de Oliveira <bristot@redhat.com>
Signed-off-by: Qais Yousef <qyousef@layalina.io>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/r/20240610192018.1567075-4-qyousef@layalina.io
---
 fs/bcachefs/six.c                 |  2 +-
 fs/select.c                       |  2 +-
 include/linux/ioprio.h            |  2 +-
 include/linux/sched/rt.h          | 10 +++++-----
 kernel/locking/rtmutex.c          |  4 ++--
 kernel/locking/rwsem.c            |  4 ++--
 kernel/locking/ww_mutex.h         |  2 +-
 kernel/sched/core.c               |  4 ++--
 kernel/sched/syscalls.c           |  2 +-
 kernel/time/hrtimer.c             |  6 +++---
 kernel/trace/trace_sched_wakeup.c |  2 +-
 mm/page-writeback.c               |  4 ++--
 mm/page_alloc.c                   |  2 +-
 13 files changed, 23 insertions(+), 23 deletions(-)

diff --git a/fs/bcachefs/six.c b/fs/bcachefs/six.c
index b30870b..9cbd3c1 100644
--- a/fs/bcachefs/six.c
+++ b/fs/bcachefs/six.c
@@ -335,7 +335,7 @@ static inline bool six_owner_running(struct six_lock *lock)
 	 */
 	rcu_read_lock();
 	struct task_struct *owner = READ_ONCE(lock->owner);
-	bool ret = owner ? owner_on_cpu(owner) : !realtime_task(current);
+	bool ret = owner ? owner_on_cpu(owner) : !rt_or_dl_task(current);
 	rcu_read_unlock();
 
 	return ret;
diff --git a/fs/select.c b/fs/select.c
index 8d5c141..73fce14 100644
--- a/fs/select.c
+++ b/fs/select.c
@@ -82,7 +82,7 @@ u64 select_estimate_accuracy(struct timespec64 *tv)
 	 * Realtime tasks get a slack of 0 for obvious reasons.
 	 */
 
-	if (realtime_task(current))
+	if (rt_or_dl_task(current))
 		return 0;
 
 	ktime_get_ts64(&now);
diff --git a/include/linux/ioprio.h b/include/linux/ioprio.h
index 75859b7..b25377b 100644
--- a/include/linux/ioprio.h
+++ b/include/linux/ioprio.h
@@ -40,7 +40,7 @@ static inline int task_nice_ioclass(struct task_struct *task)
 {
 	if (task->policy == SCHED_IDLE)
 		return IOPRIO_CLASS_IDLE;
-	else if (realtime_task_policy(task))
+	else if (rt_or_dl_task_policy(task))
 		return IOPRIO_CLASS_RT;
 	else
 		return IOPRIO_CLASS_BE;
diff --git a/include/linux/sched/rt.h b/include/linux/sched/rt.h
index 91ef1ef..4e33381 100644
--- a/include/linux/sched/rt.h
+++ b/include/linux/sched/rt.h
@@ -11,7 +11,7 @@ static inline bool rt_prio(int prio)
 	return unlikely(prio < MAX_RT_PRIO && prio >= MAX_DL_PRIO);
 }
 
-static inline bool realtime_prio(int prio)
+static inline bool rt_or_dl_prio(int prio)
 {
 	return unlikely(prio < MAX_RT_PRIO);
 }
@@ -27,19 +27,19 @@ static inline bool rt_task(struct task_struct *p)
 
 /*
  * Returns true if a task has a priority that belongs to RT or DL classes.
- * PI-boosted tasks will return true. Use realtime_task_policy() to ignore
+ * PI-boosted tasks will return true. Use rt_or_dl_task_policy() to ignore
  * PI-boosted tasks.
  */
-static inline bool realtime_task(struct task_struct *p)
+static inline bool rt_or_dl_task(struct task_struct *p)
 {
-	return realtime_prio(p->prio);
+	return rt_or_dl_prio(p->prio);
 }
 
 /*
  * Returns true if a task has a policy that belongs to RT or DL classes.
  * PI-boosted tasks will return false.
  */
-static inline bool realtime_task_policy(struct task_struct *tsk)
+static inline bool rt_or_dl_task_policy(struct task_struct *tsk)
 {
 	int policy = tsk->policy;
 
diff --git a/kernel/locking/rtmutex.c b/kernel/locking/rtmutex.c
index 55c9dab..c2a530d 100644
--- a/kernel/locking/rtmutex.c
+++ b/kernel/locking/rtmutex.c
@@ -347,7 +347,7 @@ static __always_inline int __waiter_prio(struct task_struct *task)
 {
 	int prio = task->prio;
 
-	if (!realtime_prio(prio))
+	if (!rt_or_dl_prio(prio))
 		return DEFAULT_PRIO;
 
 	return prio;
@@ -435,7 +435,7 @@ static inline bool rt_mutex_steal(struct rt_mutex_waiter *waiter,
 	 * Note that RT tasks are excluded from same priority (lateral)
 	 * steals to prevent the introduction of an unbounded latency.
 	 */
-	if (realtime_prio(waiter->tree.prio))
+	if (rt_or_dl_prio(waiter->tree.prio))
 		return false;
 
 	return rt_waiter_node_equal(&waiter->tree, &top_waiter->tree);
diff --git a/kernel/locking/rwsem.c b/kernel/locking/rwsem.c
index 516174a..5ded7df 100644
--- a/kernel/locking/rwsem.c
+++ b/kernel/locking/rwsem.c
@@ -631,7 +631,7 @@ static inline bool rwsem_try_write_lock(struct rw_semaphore *sem,
 			 * if it is an RT task or wait in the wait queue
 			 * for too long.
 			 */
-			if (has_handoff || (!realtime_task(waiter->task) &&
+			if (has_handoff || (!rt_or_dl_task(waiter->task) &&
 					    !time_after(jiffies, waiter->timeout)))
 				return false;
 
@@ -914,7 +914,7 @@ static bool rwsem_optimistic_spin(struct rw_semaphore *sem)
 		if (owner_state != OWNER_WRITER) {
 			if (need_resched())
 				break;
-			if (realtime_task(current) &&
+			if (rt_or_dl_task(current) &&
 			   (prev_owner_state != OWNER_WRITER))
 				break;
 		}
diff --git a/kernel/locking/ww_mutex.h b/kernel/locking/ww_mutex.h
index fa4b416..76d204b 100644
--- a/kernel/locking/ww_mutex.h
+++ b/kernel/locking/ww_mutex.h
@@ -237,7 +237,7 @@ __ww_ctx_less(struct ww_acquire_ctx *a, struct ww_acquire_ctx *b)
 	int a_prio = a->task->prio;
 	int b_prio = b->task->prio;
 
-	if (realtime_prio(a_prio) || realtime_prio(b_prio)) {
+	if (rt_or_dl_prio(a_prio) || rt_or_dl_prio(b_prio)) {
 
 		if (a_prio > b_prio)
 			return true;
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 673cbeb..ab50100 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -166,7 +166,7 @@ static inline int __task_prio(const struct task_struct *p)
 	if (p->dl_server)
 		return -1; /* deadline */
 
-	if (realtime_prio(p->prio)) /* includes deadline */
+	if (rt_or_dl_prio(p->prio))
 		return p->prio; /* [-1, 99] */
 
 	if (p->sched_class == &idle_sched_class)
@@ -8590,7 +8590,7 @@ void normalize_rt_tasks(void)
 		schedstat_set(p->stats.sleep_start, 0);
 		schedstat_set(p->stats.block_start, 0);
 
-		if (!realtime_task(p)) {
+		if (!rt_or_dl_task(p)) {
 			/*
 			 * Renice negative nice level userspace
 			 * tasks back to 0:
diff --git a/kernel/sched/syscalls.c b/kernel/sched/syscalls.c
index 6d60326..60e70c8 100644
--- a/kernel/sched/syscalls.c
+++ b/kernel/sched/syscalls.c
@@ -57,7 +57,7 @@ static int effective_prio(struct task_struct *p)
 	 * keep the priority unchanged. Otherwise, update priority
 	 * to the normal priority:
 	 */
-	if (!realtime_prio(p->prio))
+	if (!rt_or_dl_prio(p->prio))
 		return p->normal_prio;
 	return p->prio;
 }
diff --git a/kernel/time/hrtimer.c b/kernel/time/hrtimer.c
index a1d1d8d..f4be3ab 100644
--- a/kernel/time/hrtimer.c
+++ b/kernel/time/hrtimer.c
@@ -1975,7 +1975,7 @@ static void __hrtimer_init_sleeper(struct hrtimer_sleeper *sl,
 	 * expiry.
 	 */
 	if (IS_ENABLED(CONFIG_PREEMPT_RT)) {
-		if (realtime_task_policy(current) && !(mode & HRTIMER_MODE_SOFT))
+		if (rt_or_dl_task_policy(current) && !(mode & HRTIMER_MODE_SOFT))
 			mode |= HRTIMER_MODE_HARD;
 	}
 
@@ -2075,7 +2075,7 @@ long hrtimer_nanosleep(ktime_t rqtp, const enum hrtimer_mode mode,
 	u64 slack;
 
 	slack = current->timer_slack_ns;
-	if (realtime_task(current))
+	if (rt_or_dl_task(current))
 		slack = 0;
 
 	hrtimer_init_sleeper_on_stack(&t, clockid, mode);
@@ -2280,7 +2280,7 @@ schedule_hrtimeout_range_clock(ktime_t *expires, u64 delta,
 	 * Override any slack passed by the user if under
 	 * rt contraints.
 	 */
-	if (realtime_task(current))
+	if (rt_or_dl_task(current))
 		delta = 0;
 
 	hrtimer_init_sleeper_on_stack(&t, clock_id, mode);
diff --git a/kernel/trace/trace_sched_wakeup.c b/kernel/trace/trace_sched_wakeup.c
index 1824e17..ae2ace5 100644
--- a/kernel/trace/trace_sched_wakeup.c
+++ b/kernel/trace/trace_sched_wakeup.c
@@ -547,7 +547,7 @@ probe_wakeup(void *ignore, struct task_struct *p)
 	 *  - wakeup_dl handles tasks belonging to sched_dl class only.
 	 */
 	if (tracing_dl || (wakeup_dl && !dl_task(p)) ||
-	    (wakeup_rt && !realtime_task(p)) ||
+	    (wakeup_rt && !rt_or_dl_task(p)) ||
 	    (!dl_task(p) && (p->prio >= wakeup_prio || p->prio >= current->prio)))
 		return;
 
diff --git a/mm/page-writeback.c b/mm/page-writeback.c
index 78dcad7..7a04cb1 100644
--- a/mm/page-writeback.c
+++ b/mm/page-writeback.c
@@ -418,7 +418,7 @@ static void domain_dirty_limits(struct dirty_throttle_control *dtc)
 		bg_thresh = (bg_ratio * available_memory) / PAGE_SIZE;
 
 	tsk = current;
-	if (realtime_task(tsk)) {
+	if (rt_or_dl_task(tsk)) {
 		bg_thresh += bg_thresh / 4 + global_wb_domain.dirty_limit / 32;
 		thresh += thresh / 4 + global_wb_domain.dirty_limit / 32;
 	}
@@ -477,7 +477,7 @@ static unsigned long node_dirty_limit(struct pglist_data *pgdat)
 	else
 		dirty = vm_dirty_ratio * node_memory / 100;
 
-	if (realtime_task(tsk))
+	if (rt_or_dl_task(tsk))
 		dirty += dirty / 4;
 
 	/*
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 54274e4..36f8abd 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -4002,7 +4002,7 @@ gfp_to_alloc_flags(gfp_t gfp_mask, unsigned int order)
 		 */
 		if (alloc_flags & ALLOC_MIN_RESERVE)
 			alloc_flags &= ~ALLOC_CPUSET;
-	} else if (unlikely(realtime_task(current)) && in_task())
+	} else if (unlikely(rt_or_dl_task(current)) && in_task())
 		alloc_flags |= ALLOC_MIN_RESERVE;
 
 	alloc_flags = gfp_to_alloc_flags_cma(gfp_mask, alloc_flags);

