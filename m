Return-Path: <linux-tip-commits+bounces-2643-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E3099B4802
	for <lists+linux-tip-commits@lfdr.de>; Tue, 29 Oct 2024 12:11:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E166AB240A8
	for <lists+linux-tip-commits@lfdr.de>; Tue, 29 Oct 2024 11:11:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D659207217;
	Tue, 29 Oct 2024 11:09:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="aFpxFixL";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="abyEzUPn"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48F45206076;
	Tue, 29 Oct 2024 11:09:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730200165; cv=none; b=CReiq0VoLpBjXpLEtsLmQY+2lg+sNeJ4llFtLHgzJPOtkF3jD7TE+nDyq6knaCKnSiwjiEEZeYYNbv6OAZf3MRGB8KyM1Nn1giwea1XYiR62zlpiOADzCzRtfha8qq38AUU/mqVPz1a4XkARux+AiRD7gqZNQYI/6Z68DfxBj+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730200165; c=relaxed/simple;
	bh=JqcgweFU3N+Gg/4P5cftYvxrCUGCukR8ePqyjXLERN4=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=qtgfZbZeUTVjHGWvLn1tGYLuIh887NZOUBOxxvcD+Hw5u7UXzp7jI+KJQlDuM2tkelE6kO3Ln+OicHbBLzgic+U17ddX9IhG4x2kQbava3o9dzeeX60FOehODKUo6nPCZjf9o1pCqbBOy/J39092IGiK2bIwQ/VhhIv9Rr9ShPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=aFpxFixL; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=abyEzUPn; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 29 Oct 2024 11:09:18 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1730200159;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Dxdjp2ONVYKycG3udUqKLT5xQHqsFwho1FcU4HI1Wt0=;
	b=aFpxFixLotnqL0txn1mZmfdQmdW1BjBquvsJGlq3Sj1d7SXo1kqmZc9xKxo86t1GYDgtyW
	7URo4gRXDL47v95HB8ZgFd/qXmOw/J42mm96KIgdq69LL9syDqk5uIDGc+k5xAZGzkd0z2
	gMudVg5DkXJEhCmgtQUB+Zzx4tC2XwT9wvSo52XfB31Vy2aTL8wdfZbA1VnFoo/9x1IL+m
	o1QI9v8roZNAc/cgIQEH5m6L3Af1WjtVCPqpQalANl+5OfVSccxYPykZgjbrcqR4BMi2VG
	yeS6xYEnQVm6xJq/2qCcWDgt3x4CDGA04gIuBmedOWNa+t1V5yDNVkevvUMh+A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1730200159;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Dxdjp2ONVYKycG3udUqKLT5xQHqsFwho1FcU4HI1Wt0=;
	b=abyEzUPnbDPA6yCIRu7TsPqofC6YwlyHPJPnEOf3aQADsanrZenpVl/z5ja9opu765nvYm
	+k/85fvlQWBPbmCg==
From: "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] signal: Confine POSIX_TIMERS properly
Cc: Thomas Gleixner <tglx@linutronix.de>,
 Frederic Weisbecker <frederic@kernel.org>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20241001083835.314100569@linutronix.de>
References: <20241001083835.314100569@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173020015880.1442.17508225957940591714.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     68f99be287a59d50a9ad231d523f7e578f8bd28a
Gitweb:        https://git.kernel.org/tip/68f99be287a59d50a9ad231d523f7e578f8bd28a
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Tue, 01 Oct 2024 10:42:00 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 29 Oct 2024 11:43:18 +01:00

signal: Confine POSIX_TIMERS properly

Move the itimer rearming out of the signal code and consolidate all posix
timer related functions in the signal code under one ifdef.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/all/20241001083835.314100569@linutronix.de

---
 include/linux/posix-timers.h |   5 +-
 kernel/signal.c              | 125 +++++++++++-----------------------
 kernel/time/itimer.c         |  22 +++++-
 kernel/time/posix-timers.c   |  15 +++-
 4 files changed, 81 insertions(+), 86 deletions(-)

diff --git a/include/linux/posix-timers.h b/include/linux/posix-timers.h
index 4536917..670bf03 100644
--- a/include/linux/posix-timers.h
+++ b/include/linux/posix-timers.h
@@ -100,6 +100,8 @@ static inline void posix_cputimers_rt_watchdog(struct posix_cputimers *pct,
 {
 	pct->bases[CPUCLOCK_SCHED].nextevt = runtime;
 }
+void posixtimer_rearm_itimer(struct task_struct *p);
+void posixtimer_rearm(struct kernel_siginfo *info);
 
 /* Init task static initializer */
 #define INIT_CPU_TIMERBASE(b) {						\
@@ -122,6 +124,8 @@ struct cpu_timer { };
 static inline void posix_cputimers_init(struct posix_cputimers *pct) { }
 static inline void posix_cputimers_group_init(struct posix_cputimers *pct,
 					      u64 cpu_limit) { }
+static inline void posixtimer_rearm_itimer(struct task_struct *p) { }
+static inline void posixtimer_rearm(struct kernel_siginfo *info) { }
 #endif
 
 #ifdef CONFIG_POSIX_CPU_TIMERS_TASK_WORK
@@ -196,5 +200,4 @@ void set_process_cpu_timer(struct task_struct *task, unsigned int clock_idx,
 
 int update_rlimit_cpu(struct task_struct *task, unsigned long rlim_new);
 
-void posixtimer_rearm(struct kernel_siginfo *info);
 #endif
diff --git a/kernel/signal.c b/kernel/signal.c
index 4344860..b65cc18 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -478,42 +478,6 @@ void flush_signals(struct task_struct *t)
 }
 EXPORT_SYMBOL(flush_signals);
 
-#ifdef CONFIG_POSIX_TIMERS
-static void __flush_itimer_signals(struct sigpending *pending)
-{
-	sigset_t signal, retain;
-	struct sigqueue *q, *n;
-
-	signal = pending->signal;
-	sigemptyset(&retain);
-
-	list_for_each_entry_safe(q, n, &pending->list, list) {
-		int sig = q->info.si_signo;
-
-		if (likely(q->info.si_code != SI_TIMER)) {
-			sigaddset(&retain, sig);
-		} else {
-			sigdelset(&signal, sig);
-			list_del_init(&q->list);
-			__sigqueue_free(q);
-		}
-	}
-
-	sigorsets(&pending->signal, &signal, &retain);
-}
-
-void flush_itimer_signals(void)
-{
-	struct task_struct *tsk = current;
-	unsigned long flags;
-
-	spin_lock_irqsave(&tsk->sighand->siglock, flags);
-	__flush_itimer_signals(&tsk->pending);
-	__flush_itimer_signals(&tsk->signal->shared_pending);
-	spin_unlock_irqrestore(&tsk->sighand->siglock, flags);
-}
-#endif
-
 void ignore_signals(struct task_struct *t)
 {
 	int i;
@@ -636,31 +600,9 @@ int dequeue_signal(sigset_t *mask, kernel_siginfo_t *info, enum pid_type *type)
 		*type = PIDTYPE_TGID;
 		signr = __dequeue_signal(&tsk->signal->shared_pending,
 					 mask, info, &resched_timer);
-#ifdef CONFIG_POSIX_TIMERS
-		/*
-		 * itimer signal ?
-		 *
-		 * itimers are process shared and we restart periodic
-		 * itimers in the signal delivery path to prevent DoS
-		 * attacks in the high resolution timer case. This is
-		 * compliant with the old way of self-restarting
-		 * itimers, as the SIGALRM is a legacy signal and only
-		 * queued once. Changing the restart behaviour to
-		 * restart the timer in the signal dequeue path is
-		 * reducing the timer noise on heavy loaded !highres
-		 * systems too.
-		 */
-		if (unlikely(signr == SIGALRM)) {
-			struct hrtimer *tmr = &tsk->signal->real_timer;
-
-			if (!hrtimer_is_queued(tmr) &&
-			    tsk->signal->it_real_incr != 0) {
-				hrtimer_forward(tmr, tmr->base->get_time(),
-						tsk->signal->it_real_incr);
-				hrtimer_restart(tmr);
-			}
-		}
-#endif
+
+		if (unlikely(signr == SIGALRM))
+			posixtimer_rearm_itimer(tsk);
 	}
 
 	recalc_sigpending();
@@ -682,22 +624,12 @@ int dequeue_signal(sigset_t *mask, kernel_siginfo_t *info, enum pid_type *type)
 		 */
 		current->jobctl |= JOBCTL_STOP_DEQUEUED;
 	}
-#ifdef CONFIG_POSIX_TIMERS
-	if (resched_timer) {
-		/*
-		 * Release the siglock to ensure proper locking order
-		 * of timer locks outside of siglocks.  Note, we leave
-		 * irqs disabled here, since the posix-timers code is
-		 * about to disable them again anyway.
-		 */
-		spin_unlock(&tsk->sighand->siglock);
-		posixtimer_rearm(info);
-		spin_lock(&tsk->sighand->siglock);
 
-		/* Don't expose the si_sys_private value to userspace */
-		info->si_sys_private = 0;
+	if (IS_ENABLED(CONFIG_POSIX_TIMERS)) {
+		if (unlikely(resched_timer))
+			posixtimer_rearm(info);
 	}
-#endif
+
 	return signr;
 }
 EXPORT_SYMBOL_GPL(dequeue_signal);
@@ -1922,15 +1854,43 @@ int kill_pid(struct pid *pid, int sig, int priv)
 }
 EXPORT_SYMBOL(kill_pid);
 
+#ifdef CONFIG_POSIX_TIMERS
 /*
- * These functions support sending signals using preallocated sigqueue
- * structures.  This is needed "because realtime applications cannot
- * afford to lose notifications of asynchronous events, like timer
- * expirations or I/O completions".  In the case of POSIX Timers
- * we allocate the sigqueue structure from the timer_create.  If this
- * allocation fails we are able to report the failure to the application
- * with an EAGAIN error.
+ * These functions handle POSIX timer signals. POSIX timers use
+ * preallocated sigqueue structs for sending signals.
  */
+static void __flush_itimer_signals(struct sigpending *pending)
+{
+	sigset_t signal, retain;
+	struct sigqueue *q, *n;
+
+	signal = pending->signal;
+	sigemptyset(&retain);
+
+	list_for_each_entry_safe(q, n, &pending->list, list) {
+		int sig = q->info.si_signo;
+
+		if (likely(q->info.si_code != SI_TIMER)) {
+			sigaddset(&retain, sig);
+		} else {
+			sigdelset(&signal, sig);
+			list_del_init(&q->list);
+			__sigqueue_free(q);
+		}
+	}
+
+	sigorsets(&pending->signal, &signal, &retain);
+}
+
+void flush_itimer_signals(void)
+{
+	struct task_struct *tsk = current;
+
+	guard(spinlock_irqsave)(&tsk->sighand->siglock);
+	__flush_itimer_signals(&tsk->pending);
+	__flush_itimer_signals(&tsk->signal->shared_pending);
+}
+
 struct sigqueue *sigqueue_alloc(void)
 {
 	return __sigqueue_alloc(-1, current, GFP_KERNEL, 0, SIGQUEUE_PREALLOC);
@@ -2027,6 +1987,7 @@ ret:
 	rcu_read_unlock();
 	return ret;
 }
+#endif /* CONFIG_POSIX_TIMERS */
 
 void do_notify_pidfd(struct task_struct *task)
 {
diff --git a/kernel/time/itimer.c b/kernel/time/itimer.c
index 00629e6..876d389 100644
--- a/kernel/time/itimer.c
+++ b/kernel/time/itimer.c
@@ -151,7 +151,27 @@ COMPAT_SYSCALL_DEFINE2(getitimer, int, which,
 #endif
 
 /*
- * The timer is automagically restarted, when interval != 0
+ * Invoked from dequeue_signal() when SIG_ALRM is delivered.
+ *
+ * Restart the ITIMER_REAL timer if it is armed as periodic timer.  Doing
+ * this in the signal delivery path instead of self rearming prevents a DoS
+ * with small increments in the high reolution timer case and reduces timer
+ * noise in general.
+ */
+void posixtimer_rearm_itimer(struct task_struct *tsk)
+{
+	struct hrtimer *tmr = &tsk->signal->real_timer;
+
+	if (!hrtimer_is_queued(tmr) && tsk->signal->it_real_incr != 0) {
+		hrtimer_forward(tmr, tmr->base->get_time(),
+				tsk->signal->it_real_incr);
+		hrtimer_restart(tmr);
+	}
+}
+
+/*
+ * Interval timers are restarted in the signal delivery path.  See
+ * posixtimer_rearm_itimer().
  */
 enum hrtimer_restart it_real_fn(struct hrtimer *timer)
 {
diff --git a/kernel/time/posix-timers.c b/kernel/time/posix-timers.c
index fc40dac..d461a32 100644
--- a/kernel/time/posix-timers.c
+++ b/kernel/time/posix-timers.c
@@ -251,7 +251,7 @@ static void common_hrtimer_rearm(struct k_itimer *timr)
 
 /*
  * This function is called from the signal delivery code if
- * info->si_sys_private is not zero, which indicates that the timer has to
+ * info::si_sys_private is not zero, which indicates that the timer has to
  * be rearmed. Restart the timer and update info::si_overrun.
  */
 void posixtimer_rearm(struct kernel_siginfo *info)
@@ -259,9 +259,15 @@ void posixtimer_rearm(struct kernel_siginfo *info)
 	struct k_itimer *timr;
 	unsigned long flags;
 
+	/*
+	 * Release siglock to ensure proper locking order versus
+	 * timr::it_lock. Keep interrupts disabled.
+	 */
+	spin_unlock(&current->sighand->siglock);
+
 	timr = lock_timer(info->si_tid, &flags);
 	if (!timr)
-		return;
+		goto out;
 
 	if (timr->it_interval && timr->it_requeue_pending == info->si_sys_private) {
 		timr->kclock->timer_rearm(timr);
@@ -275,6 +281,11 @@ void posixtimer_rearm(struct kernel_siginfo *info)
 	}
 
 	unlock_timer(timr, flags);
+out:
+	spin_lock(&current->sighand->siglock);
+
+	/* Don't expose the si_sys_private value to userspace */
+	info->si_sys_private = 0;
 }
 
 int posix_timer_queue_signal(struct k_itimer *timr)

