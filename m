Return-Path: <linux-tip-commits+bounces-5821-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 57CCFAD84B4
	for <lists+linux-tip-commits@lfdr.de>; Fri, 13 Jun 2025 09:46:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 79689163430
	for <lists+linux-tip-commits@lfdr.de>; Fri, 13 Jun 2025 07:46:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A94DD291C1D;
	Fri, 13 Jun 2025 07:37:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="uUHrs7m/";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Nj0vz/cK"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C109326B759;
	Fri, 13 Jun 2025 07:37:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749800266; cv=none; b=WUgT5ziEMPIrdBObPnUONv9653kTH72tucz16XVqhC3qxpHhxoojTa4rQaFh3S0EMkh7nb1iFNJ6juUjWZmdyIcy5MUsMWDs73Qtunzrfu4x3qcyNkxo/UkWooQa+BGN71Du/9P8g1LiH+c2SxjvnhCcLTjCbS6lKmCULhcOs/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749800266; c=relaxed/simple;
	bh=BD29r4vg5DyZe+hW3CWgVEnLijKpfqWnaEoUvVvFdEE=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=C/Cz2VFkh4/0IbQH1Jl58Oy4rwevCUpMqUFAG3kjmDxLUFuULNwyv001Bhlq0ShPx/L8ACOBE0ceiol9oymyiAE7Ows+e3nTvvvTyaXi+RUQc2GngU6dbY5aF3QzpIZ18/Ph5ZeMOc88g0GCyL/Dzr4OjTr7RrLpYZYOVLY4Tdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=uUHrs7m/; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Nj0vz/cK; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 13 Jun 2025 07:37:39 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1749800261;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ovMuP353gR3+GpS1z+jmoPrbhqVrIGHgL0AVpxDaDcI=;
	b=uUHrs7m/yoCMtol1LUOUoSBpzwEopgiwbzGEVaGbN4/6CBfDE3tq1ZgDYMUKzC6sPko+MJ
	DUCW1hFaxuAArjVZFwqYZ6XP0Nkl9Xfog1Y8kAfG+eOUBV7goXl9RAHuH0cVg/EKMD+xMy
	DgWNXJ9T5LWGcHrYUj4/un34t7qg99yoedwNtzGav9eXnXfK4sJOf8TLWct/0rkuZdaFSy
	fpVzNQ3o5NWVjM8GnW8JSVsdiPkQiVTGjNW/tm5SWc+BHtL0BcIC4WlutrFBIasJgCUkak
	YAPHQkpBcxlrrgOkgCDKbRtf47V6egVNxvz/Mgsr2PEvYq1poxrcRGFYf6CzYA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1749800261;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ovMuP353gR3+GpS1z+jmoPrbhqVrIGHgL0AVpxDaDcI=;
	b=Nj0vz/cKvildSfk0CGN37eeGj60GH6at861+y+ph8mymjw6n9FMNBH/8PN7mFqx/OEaENt
	VQPc0DaqUzkFIODg==
From: "tip-bot2 for Ingo Molnar" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched: Clean up and standardize #if/#else/#endif
 markers in sched/core.c
Cc: Ingo Molnar <mingo@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Juri Lelli <juri.lelli@redhat.com>,
 Linus Torvalds <torvalds@linux-foundation.org>, Mel Gorman <mgorman@suse.de>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Shrikanth Hegde <sshegde@linux.ibm.com>, Steven Rostedt <rostedt@goodmis.org>,
 Valentin Schneider <vschneid@redhat.com>,
 Vincent Guittot <vincent.guittot@linaro.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250528080924.2273858-4-mingo@kernel.org>
References: <20250528080924.2273858-4-mingo@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174980025994.406.8229029851964997583.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     b7ebb758568b60ae816b0c21df70a67eecb84a71
Gitweb:        https://git.kernel.org/tip/b7ebb758568b60ae816b0c21df70a67eecb84a71
Author:        Ingo Molnar <mingo@kernel.org>
AuthorDate:    Wed, 28 May 2025 10:08:44 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Fri, 13 Jun 2025 08:47:15 +02:00

sched: Clean up and standardize #if/#else/#endif markers in sched/core.c

 - Use the standard #ifdef marker format for larger blocks,
   where appropriate:

	#if CONFIG_FOO
	...
	#else /* !CONFIG_FOO: */
	...
	#endif /* !CONFIG_FOO */

 - Apply this simplification:

	-#if defined(CONFIG_FOO)
	+#ifdef CONFIG_FOO

 - Fix whitespace noise.

 - Use vertical alignment to better visualize nested #ifdef blocks,
   where appropriate:

	#ifdef CONFIG_FOO
	# ifdef CONFIG_BAR
	...
	# endif
	#endif

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
Link: https://lore.kernel.org/r/20250528080924.2273858-4-mingo@kernel.org
---
 kernel/sched/core.c | 186 +++++++++++++++++++++----------------------
 1 file changed, 93 insertions(+), 93 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index dce50fa..f1ef6d2 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -481,13 +481,13 @@ void sched_core_put(void)
 		schedule_work(&_work);
 }
 
-#else /* !CONFIG_SCHED_CORE */
+#else /* !CONFIG_SCHED_CORE: */
 
 static inline void sched_core_enqueue(struct rq *rq, struct task_struct *p) { }
 static inline void
 sched_core_dequeue(struct rq *rq, struct task_struct *p, int flags) { }
 
-#endif /* CONFIG_SCHED_CORE */
+#endif /* !CONFIG_SCHED_CORE */
 
 /* need a wrapper since we may need to trace from modules */
 EXPORT_TRACEPOINT_SYMBOL(sched_set_state_tp);
@@ -667,7 +667,7 @@ void double_rq_lock(struct rq *rq1, struct rq *rq2)
 
 	double_rq_clock_clear_update(rq1, rq2);
 }
-#endif
+#endif /* CONFIG_SMP */
 
 /*
  * __task_rq_lock - lock the rq @p resides on.
@@ -899,7 +899,7 @@ void hrtick_start(struct rq *rq, u64 delay)
 		smp_call_function_single_async(cpu_of(rq), &rq->hrtick_csd);
 }
 
-#else
+#else /* !CONFIG_SMP: */
 /*
  * Called to set the hrtick timer state.
  *
@@ -916,7 +916,7 @@ void hrtick_start(struct rq *rq, u64 delay)
 		      HRTIMER_MODE_REL_PINNED_HARD);
 }
 
-#endif /* CONFIG_SMP */
+#endif /* !CONFIG_SMP */
 
 static void hrtick_rq_init(struct rq *rq)
 {
@@ -925,7 +925,7 @@ static void hrtick_rq_init(struct rq *rq)
 #endif
 	hrtimer_setup(&rq->hrtick_timer, hrtick, CLOCK_MONOTONIC, HRTIMER_MODE_REL_HARD);
 }
-#else	/* CONFIG_SCHED_HRTICK */
+#else /* !CONFIG_SCHED_HRTICK: */
 static inline void hrtick_clear(struct rq *rq)
 {
 }
@@ -933,7 +933,7 @@ static inline void hrtick_clear(struct rq *rq)
 static inline void hrtick_rq_init(struct rq *rq)
 {
 }
-#endif	/* CONFIG_SCHED_HRTICK */
+#endif /* !CONFIG_SCHED_HRTICK */
 
 /*
  * try_cmpxchg based fetch_or() macro so it works for different integer types:
@@ -1971,7 +1971,7 @@ undo:
 	sysctl_sched_uclamp_util_min_rt_default = old_min_rt;
 	return result;
 }
-#endif
+#endif /* CONFIG_SYSCTL */
 
 static void uclamp_fork(struct task_struct *p)
 {
@@ -2037,13 +2037,13 @@ static void __init init_uclamp(void)
 	}
 }
 
-#else /* !CONFIG_UCLAMP_TASK */
+#else /* !CONFIG_UCLAMP_TASK: */
 static inline void uclamp_rq_inc(struct rq *rq, struct task_struct *p, int flags) { }
 static inline void uclamp_rq_dec(struct rq *rq, struct task_struct *p) { }
 static inline void uclamp_fork(struct task_struct *p) { }
 static inline void uclamp_post_fork(struct task_struct *p) { }
 static inline void init_uclamp(void) { }
-#endif /* CONFIG_UCLAMP_TASK */
+#endif /* !CONFIG_UCLAMP_TASK */
 
 bool sched_task_on_rq(struct task_struct *p)
 {
@@ -3661,7 +3661,7 @@ void sched_set_stop_task(int cpu, struct task_struct *stop)
 	}
 }
 
-#else /* CONFIG_SMP */
+#else /* !CONFIG_SMP: */
 
 static inline void migrate_disable_switch(struct rq *rq, struct task_struct *p) { }
 
@@ -3770,7 +3770,7 @@ ttwu_do_activate(struct rq *rq, struct task_struct *p, int wake_flags,
 
 		rq->idle_stamp = 0;
 	}
-#endif
+#endif /* CONFIG_SMP */
 }
 
 /*
@@ -3992,14 +3992,14 @@ static bool ttwu_queue_wakelist(struct task_struct *p, int cpu, int wake_flags)
 	return false;
 }
 
-#else /* !CONFIG_SMP */
+#else /* !CONFIG_SMP: */
 
 static inline bool ttwu_queue_wakelist(struct task_struct *p, int cpu, int wake_flags)
 {
 	return false;
 }
 
-#endif /* CONFIG_SMP */
+#endif /* !CONFIG_SMP */
 
 static void ttwu_queue(struct task_struct *p, int cpu, int wake_flags)
 {
@@ -4335,9 +4335,9 @@ int try_to_wake_up(struct task_struct *p, unsigned int state, int wake_flags)
 			psi_ttwu_dequeue(p);
 			set_task_cpu(p, cpu);
 		}
-#else
+#else /* !CONFIG_SMP: */
 		cpu = task_cpu(p);
-#endif /* CONFIG_SMP */
+#endif /* !CONFIG_SMP */
 
 		ttwu_queue(p, cpu, wake_flags);
 	}
@@ -4599,8 +4599,8 @@ static int sysctl_numa_balancing(const struct ctl_table *table, int write,
 	}
 	return err;
 }
-#endif
-#endif
+#endif /* CONFIG_PROC_SYSCTL */
+#endif /* CONFIG_NUMA_BALANCING */
 
 #ifdef CONFIG_SCHEDSTATS
 
@@ -4787,7 +4787,7 @@ int sched_fork(unsigned long clone_flags, struct task_struct *p)
 	if (likely(sched_info_on()))
 		memset(&p->sched_info, 0, sizeof(p->sched_info));
 #endif
-#if defined(CONFIG_SMP)
+#ifdef CONFIG_SMP
 	p->on_cpu = 0;
 #endif
 	init_task_preempt_count(p);
@@ -4978,7 +4978,7 @@ fire_sched_out_preempt_notifiers(struct task_struct *curr,
 		__fire_sched_out_preempt_notifiers(curr, next);
 }
 
-#else /* !CONFIG_PREEMPT_NOTIFIERS */
+#else /* !CONFIG_PREEMPT_NOTIFIERS: */
 
 static inline void fire_sched_in_preempt_notifiers(struct task_struct *curr)
 {
@@ -4990,7 +4990,7 @@ fire_sched_out_preempt_notifiers(struct task_struct *curr,
 {
 }
 
-#endif /* CONFIG_PREEMPT_NOTIFIERS */
+#endif /* !CONFIG_PREEMPT_NOTIFIERS */
 
 static inline void prepare_task(struct task_struct *next)
 {
@@ -5107,13 +5107,13 @@ void balance_callbacks(struct rq *rq, struct balance_callback *head)
 	}
 }
 
-#else
+#else /* !CONFIG_SMP: */
 
 static inline void __balance_callbacks(struct rq *rq)
 {
 }
 
-#endif
+#endif /* !CONFIG_SMP */
 
 static inline void
 prepare_lock_switch(struct rq *rq, struct task_struct *next, struct rq_flags *rf)
@@ -5527,7 +5527,7 @@ void sched_exec(void)
 	stop_one_cpu(task_cpu(p), migration_cpu_stop, &arg);
 }
 
-#endif
+#endif /* CONFIG_SMP */
 
 DEFINE_PER_CPU(struct kernel_stat, kstat);
 DEFINE_PER_CPU(struct kernel_cpustat, kernel_cpustat);
@@ -5835,10 +5835,10 @@ int __init sched_tick_offload_init(void)
 	return 0;
 }
 
-#else /* !CONFIG_NO_HZ_FULL */
+#else /* !CONFIG_NO_HZ_FULL: */
 static inline void sched_tick_start(int cpu) { }
 static inline void sched_tick_stop(int cpu) { }
-#endif
+#endif /* !CONFIG_NO_HZ_FULL */
 
 #if defined(CONFIG_PREEMPTION) && (defined(CONFIG_DEBUG_PREEMPT) || \
 				defined(CONFIG_TRACE_PREEMPT_TOGGLE))
@@ -6553,7 +6553,7 @@ static inline void sched_core_cpu_dying(unsigned int cpu)
 		rq->core = rq;
 }
 
-#else /* !CONFIG_SCHED_CORE */
+#else /* !CONFIG_SCHED_CORE: */
 
 static inline void sched_core_cpu_starting(unsigned int cpu) {}
 static inline void sched_core_cpu_deactivate(unsigned int cpu) {}
@@ -6565,7 +6565,7 @@ pick_next_task(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
 	return __pick_next_task(rq, prev, rf);
 }
 
-#endif /* CONFIG_SCHED_CORE */
+#endif /* !CONFIG_SCHED_CORE */
 
 /*
  * Constants for the sched_mode argument of __schedule().
@@ -6992,14 +6992,14 @@ NOKPROBE_SYMBOL(preempt_schedule);
 EXPORT_SYMBOL(preempt_schedule);
 
 #ifdef CONFIG_PREEMPT_DYNAMIC
-#if defined(CONFIG_HAVE_PREEMPT_DYNAMIC_CALL)
-#ifndef preempt_schedule_dynamic_enabled
-#define preempt_schedule_dynamic_enabled	preempt_schedule
-#define preempt_schedule_dynamic_disabled	NULL
-#endif
+# ifdef CONFIG_HAVE_PREEMPT_DYNAMIC_CALL
+#  ifndef preempt_schedule_dynamic_enabled
+#   define preempt_schedule_dynamic_enabled	preempt_schedule
+#   define preempt_schedule_dynamic_disabled	NULL
+#  endif
 DEFINE_STATIC_CALL(preempt_schedule, preempt_schedule_dynamic_enabled);
 EXPORT_STATIC_CALL_TRAMP(preempt_schedule);
-#elif defined(CONFIG_HAVE_PREEMPT_DYNAMIC_KEY)
+# elif defined(CONFIG_HAVE_PREEMPT_DYNAMIC_KEY)
 static DEFINE_STATIC_KEY_TRUE(sk_dynamic_preempt_schedule);
 void __sched notrace dynamic_preempt_schedule(void)
 {
@@ -7009,8 +7009,8 @@ void __sched notrace dynamic_preempt_schedule(void)
 }
 NOKPROBE_SYMBOL(dynamic_preempt_schedule);
 EXPORT_SYMBOL(dynamic_preempt_schedule);
-#endif
-#endif
+# endif
+#endif /* CONFIG_PREEMPT_DYNAMIC */
 
 /**
  * preempt_schedule_notrace - preempt_schedule called by tracing
@@ -7065,14 +7065,14 @@ asmlinkage __visible void __sched notrace preempt_schedule_notrace(void)
 EXPORT_SYMBOL_GPL(preempt_schedule_notrace);
 
 #ifdef CONFIG_PREEMPT_DYNAMIC
-#if defined(CONFIG_HAVE_PREEMPT_DYNAMIC_CALL)
-#ifndef preempt_schedule_notrace_dynamic_enabled
-#define preempt_schedule_notrace_dynamic_enabled	preempt_schedule_notrace
-#define preempt_schedule_notrace_dynamic_disabled	NULL
-#endif
+# if defined(CONFIG_HAVE_PREEMPT_DYNAMIC_CALL)
+#  ifndef preempt_schedule_notrace_dynamic_enabled
+#   define preempt_schedule_notrace_dynamic_enabled	preempt_schedule_notrace
+#   define preempt_schedule_notrace_dynamic_disabled	NULL
+#  endif
 DEFINE_STATIC_CALL(preempt_schedule_notrace, preempt_schedule_notrace_dynamic_enabled);
 EXPORT_STATIC_CALL_TRAMP(preempt_schedule_notrace);
-#elif defined(CONFIG_HAVE_PREEMPT_DYNAMIC_KEY)
+# elif defined(CONFIG_HAVE_PREEMPT_DYNAMIC_KEY)
 static DEFINE_STATIC_KEY_TRUE(sk_dynamic_preempt_schedule_notrace);
 void __sched notrace dynamic_preempt_schedule_notrace(void)
 {
@@ -7082,7 +7082,7 @@ void __sched notrace dynamic_preempt_schedule_notrace(void)
 }
 NOKPROBE_SYMBOL(dynamic_preempt_schedule_notrace);
 EXPORT_SYMBOL(dynamic_preempt_schedule_notrace);
-#endif
+# endif
 #endif
 
 #endif /* CONFIG_PREEMPTION */
@@ -7301,7 +7301,7 @@ out_unlock:
 
 	preempt_enable();
 }
-#endif
+#endif /* CONFIG_RT_MUTEXES */
 
 #if !defined(CONFIG_PREEMPTION) || defined(CONFIG_PREEMPT_DYNAMIC)
 int __sched __cond_resched(void)
@@ -7332,17 +7332,17 @@ EXPORT_SYMBOL(__cond_resched);
 #endif
 
 #ifdef CONFIG_PREEMPT_DYNAMIC
-#if defined(CONFIG_HAVE_PREEMPT_DYNAMIC_CALL)
-#define cond_resched_dynamic_enabled	__cond_resched
-#define cond_resched_dynamic_disabled	((void *)&__static_call_return0)
+# ifdef CONFIG_HAVE_PREEMPT_DYNAMIC_CALL
+#  define cond_resched_dynamic_enabled	__cond_resched
+#  define cond_resched_dynamic_disabled	((void *)&__static_call_return0)
 DEFINE_STATIC_CALL_RET0(cond_resched, __cond_resched);
 EXPORT_STATIC_CALL_TRAMP(cond_resched);
 
-#define might_resched_dynamic_enabled	__cond_resched
-#define might_resched_dynamic_disabled	((void *)&__static_call_return0)
+#  define might_resched_dynamic_enabled	__cond_resched
+#  define might_resched_dynamic_disabled ((void *)&__static_call_return0)
 DEFINE_STATIC_CALL_RET0(might_resched, __cond_resched);
 EXPORT_STATIC_CALL_TRAMP(might_resched);
-#elif defined(CONFIG_HAVE_PREEMPT_DYNAMIC_KEY)
+# elif defined(CONFIG_HAVE_PREEMPT_DYNAMIC_KEY)
 static DEFINE_STATIC_KEY_FALSE(sk_dynamic_cond_resched);
 int __sched dynamic_cond_resched(void)
 {
@@ -7360,8 +7360,8 @@ int __sched dynamic_might_resched(void)
 	return __cond_resched();
 }
 EXPORT_SYMBOL(dynamic_might_resched);
-#endif
-#endif
+# endif
+#endif /* CONFIG_PREEMPT_DYNAMIC */
 
 /*
  * __cond_resched_lock() - if a reschedule is pending, drop the given lock,
@@ -7427,9 +7427,9 @@ EXPORT_SYMBOL(__cond_resched_rwlock_write);
 
 #ifdef CONFIG_PREEMPT_DYNAMIC
 
-#ifdef CONFIG_GENERIC_ENTRY
-#include <linux/entry-common.h>
-#endif
+# ifdef CONFIG_GENERIC_ENTRY
+#  include <linux/entry-common.h>
+# endif
 
 /*
  * SC:cond_resched
@@ -7484,37 +7484,37 @@ int preempt_dynamic_mode = preempt_dynamic_undefined;
 
 int sched_dynamic_mode(const char *str)
 {
-#ifndef CONFIG_PREEMPT_RT
+# ifndef CONFIG_PREEMPT_RT
 	if (!strcmp(str, "none"))
 		return preempt_dynamic_none;
 
 	if (!strcmp(str, "voluntary"))
 		return preempt_dynamic_voluntary;
-#endif
+# endif
 
 	if (!strcmp(str, "full"))
 		return preempt_dynamic_full;
 
-#ifdef CONFIG_ARCH_HAS_PREEMPT_LAZY
+# ifdef CONFIG_ARCH_HAS_PREEMPT_LAZY
 	if (!strcmp(str, "lazy"))
 		return preempt_dynamic_lazy;
-#endif
+# endif
 
 	return -EINVAL;
 }
 
-#define preempt_dynamic_key_enable(f)	static_key_enable(&sk_dynamic_##f.key)
-#define preempt_dynamic_key_disable(f)	static_key_disable(&sk_dynamic_##f.key)
+# define preempt_dynamic_key_enable(f)	static_key_enable(&sk_dynamic_##f.key)
+# define preempt_dynamic_key_disable(f)	static_key_disable(&sk_dynamic_##f.key)
 
-#if defined(CONFIG_HAVE_PREEMPT_DYNAMIC_CALL)
-#define preempt_dynamic_enable(f)	static_call_update(f, f##_dynamic_enabled)
-#define preempt_dynamic_disable(f)	static_call_update(f, f##_dynamic_disabled)
-#elif defined(CONFIG_HAVE_PREEMPT_DYNAMIC_KEY)
-#define preempt_dynamic_enable(f)	preempt_dynamic_key_enable(f)
-#define preempt_dynamic_disable(f)	preempt_dynamic_key_disable(f)
-#else
-#error "Unsupported PREEMPT_DYNAMIC mechanism"
-#endif
+# if defined(CONFIG_HAVE_PREEMPT_DYNAMIC_CALL)
+#  define preempt_dynamic_enable(f)	static_call_update(f, f##_dynamic_enabled)
+#  define preempt_dynamic_disable(f)	static_call_update(f, f##_dynamic_disabled)
+# elif defined(CONFIG_HAVE_PREEMPT_DYNAMIC_KEY)
+#  define preempt_dynamic_enable(f)	preempt_dynamic_key_enable(f)
+#  define preempt_dynamic_disable(f)	preempt_dynamic_key_disable(f)
+# else
+#  error "Unsupported PREEMPT_DYNAMIC mechanism"
+# endif
 
 static DEFINE_MUTEX(sched_dynamic_mutex);
 
@@ -7618,7 +7618,7 @@ static void __init preempt_dynamic_init(void)
 	}
 }
 
-#define PREEMPT_MODEL_ACCESSOR(mode) \
+# define PREEMPT_MODEL_ACCESSOR(mode) \
 	bool preempt_model_##mode(void)						 \
 	{									 \
 		WARN_ON_ONCE(preempt_dynamic_mode == preempt_dynamic_undefined); \
@@ -8123,7 +8123,7 @@ static void balance_hotplug_wait(void)
 			   TASK_UNINTERRUPTIBLE);
 }
 
-#else
+#else /* !CONFIG_HOTPLUG_CPU: */
 
 static inline void balance_push(struct rq *rq)
 {
@@ -8137,7 +8137,7 @@ static inline void balance_hotplug_wait(void)
 {
 }
 
-#endif /* CONFIG_HOTPLUG_CPU */
+#endif /* !CONFIG_HOTPLUG_CPU */
 
 void set_rq_online(struct rq *rq)
 {
@@ -8446,7 +8446,7 @@ int sched_cpu_dying(unsigned int cpu)
 	sched_core_cpu_dying(cpu);
 	return 0;
 }
-#endif
+#endif /* CONFIG_HOTPLUG_CPU */
 
 void __init sched_init_smp(void)
 {
@@ -8480,12 +8480,12 @@ static int __init migration_init(void)
 }
 early_initcall(migration_init);
 
-#else
+#else /* !CONFIG_SMP: */
 void __init sched_init_smp(void)
 {
 	sched_init_granularity();
 }
-#endif /* CONFIG_SMP */
+#endif /* !CONFIG_SMP */
 
 int in_sched_functions(unsigned long addr)
 {
@@ -8637,15 +8637,15 @@ void __init sched_init(void)
 		INIT_LIST_HEAD(&rq->cfs_tasks);
 
 		rq_attach_root(rq, &def_root_domain);
-#ifdef CONFIG_NO_HZ_COMMON
+# ifdef CONFIG_NO_HZ_COMMON
 		rq->last_blocked_load_update_tick = jiffies;
 		atomic_set(&rq->nohz_flags, 0);
 
 		INIT_CSD(&rq->nohz_csd, nohz_csd_func, rq);
-#endif
-#ifdef CONFIG_HOTPLUG_CPU
+# endif
+# ifdef CONFIG_HOTPLUG_CPU
 		rcuwait_init(&rq->hotplug_wait);
-#endif
+# endif
 #endif /* CONFIG_SMP */
 		hrtick_rq_init(rq);
 		atomic_set(&rq->nr_iowait, 0);
@@ -8830,7 +8830,7 @@ void __cant_sleep(const char *file, int line, int preempt_offset)
 }
 EXPORT_SYMBOL_GPL(__cant_sleep);
 
-#ifdef CONFIG_SMP
+# ifdef CONFIG_SMP
 void __cant_migrate(const char *file, int line)
 {
 	static unsigned long prev_jiffy;
@@ -8861,8 +8861,8 @@ void __cant_migrate(const char *file, int line)
 	add_taint(TAINT_WARN, LOCKDEP_STILL_OK);
 }
 EXPORT_SYMBOL_GPL(__cant_migrate);
-#endif
-#endif
+# endif /* CONFIG_SMP */
+#endif /* CONFIG_DEBUG_ATOMIC_SLEEP */
 
 #ifdef CONFIG_MAGIC_SYSRQ
 void normalize_rt_tasks(void)
@@ -8902,7 +8902,7 @@ void normalize_rt_tasks(void)
 
 #endif /* CONFIG_MAGIC_SYSRQ */
 
-#if defined(CONFIG_KGDB_KDB)
+#ifdef CONFIG_KGDB_KDB
 /*
  * These functions are only useful for KDB.
  *
@@ -8926,7 +8926,7 @@ struct task_struct *curr_task(int cpu)
 	return cpu_curr(cpu);
 }
 
-#endif /* defined(CONFIG_KGDB_KDB) */
+#endif /* CONFIG_KGDB_KDB */
 
 #ifdef CONFIG_CGROUP_SCHED
 /* task_group_lock serializes the addition/removal of task groups */
@@ -9807,7 +9807,7 @@ static int cpu_idle_write_s64(struct cgroup_subsys_state *css,
 		scx_group_set_idle(css_tg(css), idle);
 	return ret;
 }
-#endif
+#endif /* CONFIG_GROUP_SCHED_WEIGHT */
 
 static struct cftype cpu_legacy_files[] = {
 #ifdef CONFIG_GROUP_SCHED_WEIGHT
@@ -9935,7 +9935,7 @@ static int cpu_extra_stat_show(struct seq_file *sf,
 			   cfs_b->nr_periods, cfs_b->nr_throttled,
 			   throttled_usec, cfs_b->nr_burst, burst_usec);
 	}
-#endif
+#endif /* CONFIG_CFS_BANDWIDTH */
 	return 0;
 }
 
@@ -10076,7 +10076,7 @@ static ssize_t cpu_max_write(struct kernfs_open_file *of,
 		ret = tg_set_cfs_bandwidth(tg, period, quota, burst);
 	return ret ?: nbytes;
 }
-#endif
+#endif /* CONFIG_CFS_BANDWIDTH */
 
 static struct cftype cpu_files[] = {
 #ifdef CONFIG_GROUP_SCHED_WEIGHT
@@ -10112,7 +10112,7 @@ static struct cftype cpu_files[] = {
 		.read_u64 = cpu_cfs_burst_read_u64,
 		.write_u64 = cpu_cfs_burst_write_u64,
 	},
-#endif
+#endif /* CONFIG_CFS_BANDWIDTH */
 #ifdef CONFIG_UCLAMP_TASK_GROUP
 	{
 		.name = "uclamp.min",
@@ -10126,7 +10126,7 @@ static struct cftype cpu_files[] = {
 		.seq_show = cpu_uclamp_max_show,
 		.write = cpu_uclamp_max_write,
 	},
-#endif
+#endif /* CONFIG_UCLAMP_TASK_GROUP */
 	{ }	/* terminate */
 };
 
@@ -10147,7 +10147,7 @@ struct cgroup_subsys cpu_cgrp_subsys = {
 	.threaded	= true,
 };
 
-#endif	/* CONFIG_CGROUP_SCHED */
+#endif /* CONFIG_CGROUP_SCHED */
 
 void dump_cpu_task(int cpu)
 {
@@ -10733,7 +10733,7 @@ void sched_mm_cid_fork(struct task_struct *t)
 	WARN_ON_ONCE(!t->mm || t->mm_cid != -1);
 	t->mm_cid_active = 1;
 }
-#endif
+#endif /* CONFIG_SCHED_MM_CID */
 
 #ifdef CONFIG_SCHED_CLASS_EXT
 void sched_deq_and_put_task(struct task_struct *p, int queue_flags,
@@ -10768,4 +10768,4 @@ void sched_enq_and_set_task(struct sched_enq_and_set_ctx *ctx)
 	if (ctx->running)
 		set_next_task(rq, ctx->p);
 }
-#endif	/* CONFIG_SCHED_CLASS_EXT */
+#endif /* CONFIG_SCHED_CLASS_EXT */

