Return-Path: <linux-tip-commits+bounces-5795-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C9DDAD8479
	for <lists+linux-tip-commits@lfdr.de>; Fri, 13 Jun 2025 09:42:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7F1A43BADFC
	for <lists+linux-tip-commits@lfdr.de>; Fri, 13 Jun 2025 07:40:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C1042E88BB;
	Fri, 13 Jun 2025 07:37:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="UU+XWHnt";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="29Nr71Sg"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59CED2E7F3F;
	Fri, 13 Jun 2025 07:37:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749800243; cv=none; b=pbi7vUHFBNowV6+hUX8SeeSMWrgwd9iyLXPrZ4f3ncTnfJ8K8Mtcb7tRdgpNfzZyo2FjnbxOXEmpRrbqFZylKpEDZqobiNZDeoebMK5H2QRgKEXB5P1E+2Ab91uau8RMXK1vYcdpj/AlfBMUciZpqkmIqUsmtlieL/xGtWNcJJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749800243; c=relaxed/simple;
	bh=oSWuiizfZ5x5qBIR6ZzW1aO+lzKNHmUzRskTyDQ7ZBA=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=HpyLwRFz5usyqgR5DEuivZCwe2Huj/Hp2aScVeM90JorfLCr+9LsOkMRK7jQPRU1j3gUIitmYxZHUlI7IQswJIaOOVO3rSWnLap7ucHRqeiP+r/8uN9aNNJReJ5offFHRYCX7HKm7HxOf/FpdsX4viQa0sgKxzbn/8jzscFnqL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=UU+XWHnt; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=29Nr71Sg; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 13 Jun 2025 07:37:18 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1749800239;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=c+WCke6SZhjiFyi2nLIWakDiNTNsEUfLA1LctwdlbIA=;
	b=UU+XWHntPSzv3jxT5MhQI6jWSuLOU3SP2ASB4oHsHqmAQz9XiyIDirJ8UXOhJs+RuTXE5b
	O4b8xkLAZLuwSxZkq6pIFnLREOHrf8oWvR7Zr3EeheW6+5U+3v7i8xX6lCx+4+SaRKfSlW
	1HuMEFvTUkfuNxzknsAk/RLShJ/TtkBTGMYhcP34GmkEOfrEFFvwcr5SIedgTMd4zw9gz6
	uvAgCC8o6eS2PWP5HW85EwDzA3IMxuHv/LRwcoBuBciyulmwomRJT4KBXggHCkf2723anm
	Btdb/A00QzOPa73rCRqxsfnKClI4bijz5xiu3E2+ZSWBTsgrSzKS/t7F5xUzRQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1749800239;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=c+WCke6SZhjiFyi2nLIWakDiNTNsEUfLA1LctwdlbIA=;
	b=29Nr71SgwdXck3kH28mFrxfnD4R2VkgOHcJ8uHzzKLk+kd1j7f2LeS8UyrN31fgSFBmE32
	lcCdolN14Yd2JyCg==
From: "tip-bot2 for Ingo Molnar" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: sched/core] sched/smp: Use the SMP version of the RT scheduling class
Cc: Ingo Molnar <mingo@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Juri Lelli <juri.lelli@redhat.com>,
 Linus Torvalds <torvalds@linux-foundation.org>, Mel Gorman <mgorman@suse.de>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Shrikanth Hegde <sshegde@linux.ibm.com>, Steven Rostedt <rostedt@goodmis.org>,
 Valentin Schneider <vschneid@redhat.com>,
 Vincent Guittot <vincent.guittot@linaro.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250528080924.2273858-29-mingo@kernel.org>
References: <20250528080924.2273858-29-mingo@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174980023863.406.13463237870718828169.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     15125a229abc2404a264ce493e64a9ffa7850f6e
Gitweb:        https://git.kernel.org/tip/15125a229abc2404a264ce493e64a9ffa7850f6e
Author:        Ingo Molnar <mingo@kernel.org>
AuthorDate:    Wed, 28 May 2025 10:09:09 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Fri, 13 Jun 2025 08:47:20 +02:00

sched/smp: Use the SMP version of the RT scheduling class

Simplify the scheduler by making CONFIG_SMP=y primitives and data
structures unconditional in the RT policies scheduler.

Signed-off-by: Ingo Molnar <mingo@kernel.org>
Acked-by: Peter Zijlstra <peterz@infradead.org>
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc: Juri Lelli <juri.lelli@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Mel Gorman <mgorman@suse.de>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Shrikanth Hegde <sshegde@linux.ibm.com>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Valentin Schneider <vschneid@redhat.com>
Cc: Vincent Guittot <vincent.guittot@linaro.org>
Link: https://lore.kernel.org/r/20250528080924.2273858-29-mingo@kernel.org
---
 kernel/sched/rt.c    | 72 +-------------------------------------------
 kernel/sched/sched.h |  2 +-
 2 files changed, 74 deletions(-)

diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
index ab21170..15d5855 100644
--- a/kernel/sched/rt.c
+++ b/kernel/sched/rt.c
@@ -78,12 +78,10 @@ void init_rt_rq(struct rt_rq *rt_rq)
 	/* delimiter for bitsearch: */
 	__set_bit(MAX_RT_PRIO, array->bitmap);
 
-#if defined CONFIG_SMP
 	rt_rq->highest_prio.curr = MAX_RT_PRIO-1;
 	rt_rq->highest_prio.next = MAX_RT_PRIO-1;
 	rt_rq->overloaded = 0;
 	plist_head_init(&rt_rq->pushable_tasks);
-#endif /* CONFIG_SMP */
 	/* We start is dequeued state, because no RT tasks are queued */
 	rt_rq->rt_queued = 0;
 
@@ -332,8 +330,6 @@ int alloc_rt_sched_group(struct task_group *tg, struct task_group *parent)
 }
 #endif /* !CONFIG_RT_GROUP_SCHED */
 
-#ifdef CONFIG_SMP
-
 static inline bool need_pull_rt_task(struct rq *rq, struct task_struct *prev)
 {
 	/* Try to pull RT tasks here if we lower this rq's prio */
@@ -433,21 +429,6 @@ static void dequeue_pushable_task(struct rq *rq, struct task_struct *p)
 	}
 }
 
-#else /* !CONFIG_SMP: */
-
-static inline void enqueue_pushable_task(struct rq *rq, struct task_struct *p)
-{
-}
-
-static inline void dequeue_pushable_task(struct rq *rq, struct task_struct *p)
-{
-}
-
-static inline void rt_queue_push_tasks(struct rq *rq)
-{
-}
-#endif /* !CONFIG_SMP */
-
 static void enqueue_top_rt_rq(struct rt_rq *rt_rq);
 static void dequeue_top_rt_rq(struct rt_rq *rt_rq, unsigned int count);
 
@@ -597,17 +578,10 @@ static int rt_se_boosted(struct sched_rt_entity *rt_se)
 	return p->prio != p->normal_prio;
 }
 
-#ifdef CONFIG_SMP
 static inline const struct cpumask *sched_rt_period_mask(void)
 {
 	return this_rq()->rd->span;
 }
-#else
-static inline const struct cpumask *sched_rt_period_mask(void)
-{
-	return cpu_online_mask;
-}
-#endif
 
 static inline
 struct rt_rq *sched_rt_period_rt_rq(struct rt_bandwidth *rt_b, int cpu)
@@ -628,7 +602,6 @@ bool sched_rt_bandwidth_account(struct rt_rq *rt_rq)
 		rt_rq->rt_time < rt_b->rt_runtime);
 }
 
-#ifdef CONFIG_SMP
 /*
  * We ran out of runtime, see if we can borrow some from our neighbours.
  */
@@ -801,9 +774,6 @@ static void balance_runtime(struct rt_rq *rt_rq)
 		raw_spin_lock(&rt_rq->rt_runtime_lock);
 	}
 }
-#else /* !CONFIG_SMP: */
-static inline void balance_runtime(struct rt_rq *rt_rq) {}
-#endif /* !CONFIG_SMP */
 
 static int do_sched_rt_period_timer(struct rt_bandwidth *rt_b, int overrun)
 {
@@ -980,10 +950,8 @@ struct rt_rq *sched_rt_period_rt_rq(struct rt_bandwidth *rt_b, int cpu)
 	return &cpu_rq(cpu)->rt;
 }
 
-#ifdef CONFIG_SMP
 static void __enable_runtime(struct rq *rq) { }
 static void __disable_runtime(struct rq *rq) { }
-#endif
 
 #endif /* !CONFIG_RT_GROUP_SCHED */
 
@@ -1078,8 +1046,6 @@ enqueue_top_rt_rq(struct rt_rq *rt_rq)
 	cpufreq_update_util(rq, 0);
 }
 
-#if defined CONFIG_SMP
-
 static void
 inc_rt_prio_smp(struct rt_rq *rt_rq, int prio, int prev_prio)
 {
@@ -1110,16 +1076,6 @@ dec_rt_prio_smp(struct rt_rq *rt_rq, int prio, int prev_prio)
 		cpupri_set(&rq->rd->cpupri, rq->cpu, rt_rq->highest_prio.curr);
 }
 
-#else /* !CONFIG_SMP: */
-
-static inline
-void inc_rt_prio_smp(struct rt_rq *rt_rq, int prio, int prev_prio) {}
-static inline
-void dec_rt_prio_smp(struct rt_rq *rt_rq, int prio, int prev_prio) {}
-
-#endif /* !CONFIG_SMP */
-
-#if defined CONFIG_SMP || defined CONFIG_RT_GROUP_SCHED
 static void
 inc_rt_prio(struct rt_rq *rt_rq, int prio)
 {
@@ -1158,13 +1114,6 @@ dec_rt_prio(struct rt_rq *rt_rq, int prio)
 	dec_rt_prio_smp(rt_rq, prio, prev_prio);
 }
 
-#else /* !(CONFIG_SMP || CONFIG_RT_GROUP_SCHED): */
-
-static inline void inc_rt_prio(struct rt_rq *rt_rq, int prio) {}
-static inline void dec_rt_prio(struct rt_rq *rt_rq, int prio) {}
-
-#endif /* !(CONFIG_SMP || CONFIG_RT_GROUP_SCHED) */
-
 #ifdef CONFIG_RT_GROUP_SCHED
 
 static void
@@ -1541,7 +1490,6 @@ static void yield_task_rt(struct rq *rq)
 	requeue_task_rt(rq, rq->curr, 0);
 }
 
-#ifdef CONFIG_SMP
 static int find_lowest_rq(struct task_struct *task);
 
 static int
@@ -1656,7 +1604,6 @@ static int balance_rt(struct rq *rq, struct task_struct *p, struct rq_flags *rf)
 
 	return sched_stop_runnable(rq) || sched_dl_runnable(rq) || sched_rt_runnable(rq);
 }
-#endif /* CONFIG_SMP */
 
 /*
  * Preempt the current task with a newly woken task if needed:
@@ -1670,7 +1617,6 @@ static void wakeup_preempt_rt(struct rq *rq, struct task_struct *p, int flags)
 		return;
 	}
 
-#ifdef CONFIG_SMP
 	/*
 	 * If:
 	 *
@@ -1685,7 +1631,6 @@ static void wakeup_preempt_rt(struct rq *rq, struct task_struct *p, int flags)
 	 */
 	if (p->prio == donor->prio && !test_tsk_need_resched(rq->curr))
 		check_preempt_equal_prio(rq, p);
-#endif /* CONFIG_SMP */
 }
 
 static inline void set_next_task_rt(struct rq *rq, struct task_struct *p, bool first)
@@ -1779,8 +1724,6 @@ static void put_prev_task_rt(struct rq *rq, struct task_struct *p, struct task_s
 		enqueue_pushable_task(rq, p);
 }
 
-#ifdef CONFIG_SMP
-
 /* Only try algorithms three times */
 #define RT_MAX_TRIES 3
 
@@ -2454,11 +2397,6 @@ void __init init_sched_rt_class(void)
 					GFP_KERNEL, cpu_to_node(i));
 	}
 }
-#else /* !CONFIG_SMP: */
-void __init init_sched_rt_class(void)
-{
-}
-#endif /* !CONFIG_SMP */
 
 /*
  * When switching a task to RT, we may overload the runqueue
@@ -2482,10 +2420,8 @@ static void switched_to_rt(struct rq *rq, struct task_struct *p)
 	 * then see if we can move to another run queue.
 	 */
 	if (task_on_rq_queued(p)) {
-#ifdef CONFIG_SMP
 		if (p->nr_cpus_allowed > 1 && rq->rt.overloaded)
 			rt_queue_push_tasks(rq);
-#endif /* CONFIG_SMP */
 		if (p->prio < rq->donor->prio && cpu_online(cpu_of(rq)))
 			resched_curr(rq);
 	}
@@ -2502,7 +2438,6 @@ prio_changed_rt(struct rq *rq, struct task_struct *p, int oldprio)
 		return;
 
 	if (task_current_donor(rq, p)) {
-#ifdef CONFIG_SMP
 		/*
 		 * If our priority decreases while running, we
 		 * may need to pull tasks to this runqueue.
@@ -2516,11 +2451,6 @@ prio_changed_rt(struct rq *rq, struct task_struct *p, int oldprio)
 		 */
 		if (p->prio > rq->rt.highest_prio.curr)
 			resched_curr(rq);
-#else /* !CONFIG_SMP: */
-		/* For UP simply resched on drop of prio */
-		if (oldprio < p->prio)
-			resched_curr(rq);
-#endif /* !CONFIG_SMP */
 	} else {
 		/*
 		 * This task is not running, but if it is
@@ -2641,7 +2571,6 @@ DEFINE_SCHED_CLASS(rt) = {
 	.put_prev_task		= put_prev_task_rt,
 	.set_next_task          = set_next_task_rt,
 
-#ifdef CONFIG_SMP
 	.balance		= balance_rt,
 	.select_task_rq		= select_task_rq_rt,
 	.set_cpus_allowed       = set_cpus_allowed_common,
@@ -2650,7 +2579,6 @@ DEFINE_SCHED_CLASS(rt) = {
 	.task_woken		= task_woken_rt,
 	.switched_from		= switched_from_rt,
 	.find_lock_rq		= find_lock_lowest_rq,
-#endif /* !CONFIG_SMP */
 
 	.task_tick		= task_tick_rt,
 
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 3e7151e..6bc8e42 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -792,11 +792,9 @@ struct rt_rq {
 		int		curr; /* highest queued rt task prio */
 		int		next; /* next highest */
 	} highest_prio;
-#ifdef CONFIG_SMP
 	bool			overloaded;
 	struct plist_head	pushable_tasks;
 
-#endif /* CONFIG_SMP */
 	int			rt_queued;
 
 #ifdef CONFIG_RT_GROUP_SCHED

