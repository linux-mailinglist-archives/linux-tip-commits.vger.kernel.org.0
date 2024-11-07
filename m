Return-Path: <linux-tip-commits+bounces-2800-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 807C99BFBF1
	for <lists+linux-tip-commits@lfdr.de>; Thu,  7 Nov 2024 02:49:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A388D1C219C5
	for <lists+linux-tip-commits@lfdr.de>; Thu,  7 Nov 2024 01:49:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3B3F79F6;
	Thu,  7 Nov 2024 01:48:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Ni+9AMFR";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="DrDu3LTC"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E11FEDDA9;
	Thu,  7 Nov 2024 01:48:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730944137; cv=none; b=ZfK8TUT6WyWSfzE7hQIj/BjdASyZZPRdSOGysfxd1Wyrng8NKdn2wONRgMSSvOqSR4wVE2eCxhJZ/byfaRBtc0iU3FSUXmYnWK9d3YGqfzVUh0F0pBWaR/wgFUaOKRtF16fy1n4lcdoEzE/fKpC/RctBtlLJSOmC3H7DM4qBIxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730944137; c=relaxed/simple;
	bh=tW+/QUGrQ4G4AVy/5xgJTJ9Lmcv1njdNJj6lPomNoR8=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=gJ3CrEFafHvLk3vECCOtOoy+GEca4KtcbEu53/k9yGyFhxKHW2sMgYnSvJd3/sDT0/SR7FpRMf5ZPbX6bbYG7/BgmFP5NzsqfzBTPXSgRDE+SmBg1F3UiQZn2AYxztuYIyCefpSsP4QxTqMyKxbGpi9JKPmHGiX2MrN1F5xWLjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Ni+9AMFR; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=DrDu3LTC; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 07 Nov 2024 01:48:53 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1730944134;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sAbFxJLonVEuDutPrc4GjNtbWjnj6x+yqinY98YgjMs=;
	b=Ni+9AMFRh8AOP4bCh7HcMnSQboPqcAtjZ+Xgwze20UpsIDl1g/WdtwocZwjfuZp8nmUFIe
	mNtSPHTdiOoEXNksZV7ULnukcMei7sOvbT7v7Yv/KXTwcyGeC0aCt5YmPj0Jk58SaH2iwe
	BoxceN8LvJvuYsBfj3Bf4aSRFEFhaY6rbEqcQ/wZqRdGFEd9RK8agq3u4MuXwMDt1MKtLn
	WB3pIxn8tlg8PTKJ4MwIl51HlZ9x9CTlKvNx7efJ8YJUs1sngF+ZwdcpXvt2TsoKZMiXKQ
	aChWaMOWFC6CkA4m3LhIb72tJUwwpslkukTgu+Nlh6ZcD3EOaFX3oSAfNq/YCg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1730944134;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sAbFxJLonVEuDutPrc4GjNtbWjnj6x+yqinY98YgjMs=;
	b=DrDu3LTCSsazgVH2Pogxl2G4MxJr2NPs0X4RpPi7cwCL6DvVIfC93wpSkTg5my7UhtR/dN
	ZzXVcMcrJimrVTAQ==
From: "tip-bot2 for Sebastian Andrzej Siewior" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] softirq: Use a dedicated thread for timer wakeups on
 PREEMPT_RT.
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Thomas Gleixner <tglx@linutronix.de>, "Paul E. McKenney" <paulmck@kernel.org>,
 Frederic Weisbecker <frederic@kernel.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org, maz@kernel.org
In-Reply-To: <20241106150419.2593080-4-bigeasy@linutronix.de>
References: <20241106150419.2593080-4-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173094413301.32228.3798001880154341396.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     49a17639508c3b35f90ca829e60dddeeeb750e74
Gitweb:        https://git.kernel.org/tip/49a17639508c3b35f90ca829e60dddeeeb750e74
Author:        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
AuthorDate:    Wed, 06 Nov 2024 15:51:39 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 07 Nov 2024 02:44:38 +01:00

softirq: Use a dedicated thread for timer wakeups on PREEMPT_RT.

The timer and hrtimer soft interrupts are raised in hard interrupt
context. With threaded interrupts force enabled or on PREEMPT_RT this leads
to waking the ksoftirqd for the processing of the soft interrupt.

ksoftirqd runs as SCHED_OTHER task which means it will compete with other
tasks for CPU resources.  This can introduce long delays for timer
processing on heavy loaded systems and is not desired.

Split the TIMER_SOFTIRQ and HRTIMER_SOFTIRQ processing into a dedicated
timers thread and let it run at the lowest SCHED_FIFO priority.
Wake-ups for RT tasks happen from hardirq context so only timer_list timers
and hrtimers for "regular" tasks are processed here. The higher priority
ensures that wakeups are performed before scheduling SCHED_OTHER tasks.

Using a dedicated variable to store the pending softirq bits values ensure
that the timer are not accidentally picked up by ksoftirqd and other
threaded interrupts.

It shouldn't be picked up by ksoftirqd since it runs at lower priority.
However if ksoftirqd is already running while a timer fires, then ksoftird
will be PI-boosted due to the BH-lock to ktimer's priority.

The timer thread can pick up pending softirqs from ksoftirqd but only
if the softirq load is high. It is not be desired that the picked up
softirqs are processed at SCHED_FIFO priority under high softirq load
but this can already happen by a PI-boost by a force-threaded interrupt.

[ frederic@kernel.org: rcutorture.c fixes, storm fix by introduction of
  local_timers_pending() for tick_nohz_next_event() ]

[ junxiao.chang@intel.com: Ensure ktimersd gets woken up even if a
  softirq is currently served. ]

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Paul E. McKenney <paulmck@kernel.org> [rcutorture]
Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
Link: https://lore.kernel.org/all/20241106150419.2593080-4-bigeasy@linutronix.de

---
 include/linux/interrupt.h | 47 ++++++++++++++++++++++++++-
 kernel/rcu/rcutorture.c   |  8 ++++-
 kernel/softirq.c          | 69 +++++++++++++++++++++++++++++++++++++-
 kernel/time/hrtimer.c     |  4 +-
 kernel/time/tick-sched.c  |  2 +-
 kernel/time/timer.c       |  2 +-
 6 files changed, 127 insertions(+), 5 deletions(-)

diff --git a/include/linux/interrupt.h b/include/linux/interrupt.h
index 457151f..8cd9327 100644
--- a/include/linux/interrupt.h
+++ b/include/linux/interrupt.h
@@ -616,6 +616,53 @@ extern void __raise_softirq_irqoff(unsigned int nr);
 extern void raise_softirq_irqoff(unsigned int nr);
 extern void raise_softirq(unsigned int nr);
 
+/*
+ * With forced-threaded interrupts enabled a raised softirq is deferred to
+ * ksoftirqd unless it can be handled within the threaded interrupt. This
+ * affects timer_list timers and hrtimers which are explicitly marked with
+ * HRTIMER_MODE_SOFT.
+ * With PREEMPT_RT enabled more hrtimers are moved to softirq for processing
+ * which includes all timers which are not explicitly marked HRTIMER_MODE_HARD.
+ * Userspace controlled timers (like the clock_nanosleep() interface) is divided
+ * into two categories: Tasks with elevated scheduling policy including
+ * SCHED_{FIFO|RR|DL} and the remaining scheduling policy. The tasks with the
+ * elevated scheduling policy are woken up directly from the HARDIRQ while all
+ * other wake ups are delayed to softirq and so to ksoftirqd.
+ *
+ * The ksoftirqd runs at SCHED_OTHER policy at which it should remain since it
+ * handles the softirq in an overloaded situation (not handled everything
+ * within its last run).
+ * If the timers are handled at SCHED_OTHER priority then they competes with all
+ * other SCHED_OTHER tasks for CPU resources are possibly delayed.
+ * Moving timers softirqs to a low priority SCHED_FIFO thread instead ensures
+ * that timer are performed before scheduling any SCHED_OTHER thread.
+ */
+DECLARE_PER_CPU(struct task_struct *, ktimerd);
+DECLARE_PER_CPU(unsigned long, pending_timer_softirq);
+void raise_ktimers_thread(unsigned int nr);
+
+static inline unsigned int local_timers_pending_force_th(void)
+{
+	return __this_cpu_read(pending_timer_softirq);
+}
+
+static inline void raise_timer_softirq(unsigned int nr)
+{
+	lockdep_assert_in_irq();
+	if (force_irqthreads())
+		raise_ktimers_thread(nr);
+	else
+		__raise_softirq_irqoff(nr);
+}
+
+static inline unsigned int local_timers_pending(void)
+{
+	if (force_irqthreads())
+		return local_timers_pending_force_th();
+	else
+		return local_softirq_pending();
+}
+
 DECLARE_PER_CPU(struct task_struct *, ksoftirqd);
 
 static inline struct task_struct *this_cpu_ksoftirqd(void)
diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
index bb75dbf..270c31a 100644
--- a/kernel/rcu/rcutorture.c
+++ b/kernel/rcu/rcutorture.c
@@ -2440,6 +2440,14 @@ static int rcutorture_booster_init(unsigned int cpu)
 		WARN_ON_ONCE(!t);
 		sp.sched_priority = 2;
 		sched_setscheduler_nocheck(t, SCHED_FIFO, &sp);
+#ifdef CONFIG_IRQ_FORCED_THREADING
+		if (force_irqthreads()) {
+			t = per_cpu(ktimerd, cpu);
+			WARN_ON_ONCE(!t);
+			sp.sched_priority = 2;
+			sched_setscheduler_nocheck(t, SCHED_FIFO, &sp);
+		}
+#endif
 	}
 
 	/* Don't allow time recalculation while creating a new task. */
diff --git a/kernel/softirq.c b/kernel/softirq.c
index d082e78..7b525c9 100644
--- a/kernel/softirq.c
+++ b/kernel/softirq.c
@@ -624,6 +624,24 @@ static inline void tick_irq_exit(void)
 #endif
 }
 
+#ifdef CONFIG_IRQ_FORCED_THREADING
+DEFINE_PER_CPU(struct task_struct *, ktimerd);
+DEFINE_PER_CPU(unsigned long, pending_timer_softirq);
+
+static void wake_timersd(void)
+{
+	struct task_struct *tsk = __this_cpu_read(ktimerd);
+
+	if (tsk)
+		wake_up_process(tsk);
+}
+
+#else
+
+static inline void wake_timersd(void) { }
+
+#endif
+
 static inline void __irq_exit_rcu(void)
 {
 #ifndef __ARCH_IRQ_EXIT_IRQS_DISABLED
@@ -636,6 +654,10 @@ static inline void __irq_exit_rcu(void)
 	if (!in_interrupt() && local_softirq_pending())
 		invoke_softirq();
 
+	if (IS_ENABLED(CONFIG_IRQ_FORCED_THREADING) && force_irqthreads() &&
+	    local_timers_pending_force_th() && !(in_nmi() | in_hardirq()))
+		wake_timersd();
+
 	tick_irq_exit();
 }
 
@@ -971,12 +993,57 @@ static struct smp_hotplug_thread softirq_threads = {
 	.thread_comm		= "ksoftirqd/%u",
 };
 
+#ifdef CONFIG_IRQ_FORCED_THREADING
+static void ktimerd_setup(unsigned int cpu)
+{
+	/* Above SCHED_NORMAL to handle timers before regular tasks. */
+	sched_set_fifo_low(current);
+}
+
+static int ktimerd_should_run(unsigned int cpu)
+{
+	return local_timers_pending_force_th();
+}
+
+void raise_ktimers_thread(unsigned int nr)
+{
+	trace_softirq_raise(nr);
+	__this_cpu_or(pending_timer_softirq, BIT(nr));
+}
+
+static void run_ktimerd(unsigned int cpu)
+{
+	unsigned int timer_si;
+
+	ksoftirqd_run_begin();
+
+	timer_si = local_timers_pending_force_th();
+	__this_cpu_write(pending_timer_softirq, 0);
+	or_softirq_pending(timer_si);
+
+	__do_softirq();
+
+	ksoftirqd_run_end();
+}
+
+static struct smp_hotplug_thread timer_thread = {
+	.store			= &ktimerd,
+	.setup			= ktimerd_setup,
+	.thread_should_run	= ktimerd_should_run,
+	.thread_fn		= run_ktimerd,
+	.thread_comm		= "ktimers/%u",
+};
+#endif
+
 static __init int spawn_ksoftirqd(void)
 {
 	cpuhp_setup_state_nocalls(CPUHP_SOFTIRQ_DEAD, "softirq:dead", NULL,
 				  takeover_tasklets);
 	BUG_ON(smpboot_register_percpu_thread(&softirq_threads));
-
+#ifdef CONFIG_IRQ_FORCED_THREADING
+	if (force_irqthreads())
+		BUG_ON(smpboot_register_percpu_thread(&timer_thread));
+#endif
 	return 0;
 }
 early_initcall(spawn_ksoftirqd);
diff --git a/kernel/time/hrtimer.c b/kernel/time/hrtimer.c
index 5402e0f..d991151 100644
--- a/kernel/time/hrtimer.c
+++ b/kernel/time/hrtimer.c
@@ -1811,7 +1811,7 @@ retry:
 	if (!ktime_before(now, cpu_base->softirq_expires_next)) {
 		cpu_base->softirq_expires_next = KTIME_MAX;
 		cpu_base->softirq_activated = 1;
-		__raise_softirq_irqoff(HRTIMER_SOFTIRQ);
+		raise_timer_softirq(HRTIMER_SOFTIRQ);
 	}
 
 	__hrtimer_run_queues(cpu_base, now, flags, HRTIMER_ACTIVE_HARD);
@@ -1906,7 +1906,7 @@ void hrtimer_run_queues(void)
 	if (!ktime_before(now, cpu_base->softirq_expires_next)) {
 		cpu_base->softirq_expires_next = KTIME_MAX;
 		cpu_base->softirq_activated = 1;
-		__raise_softirq_irqoff(HRTIMER_SOFTIRQ);
+		raise_timer_softirq(HRTIMER_SOFTIRQ);
 	}
 
 	__hrtimer_run_queues(cpu_base, now, flags, HRTIMER_ACTIVE_HARD);
diff --git a/kernel/time/tick-sched.c b/kernel/time/tick-sched.c
index 753a184..976a212 100644
--- a/kernel/time/tick-sched.c
+++ b/kernel/time/tick-sched.c
@@ -859,7 +859,7 @@ static void tick_nohz_restart(struct tick_sched *ts, ktime_t now)
 
 static inline bool local_timer_softirq_pending(void)
 {
-	return local_softirq_pending() & BIT(TIMER_SOFTIRQ);
+	return local_timers_pending() & BIT(TIMER_SOFTIRQ);
 }
 
 /*
diff --git a/kernel/time/timer.c b/kernel/time/timer.c
index 1759de9..06f0bc1 100644
--- a/kernel/time/timer.c
+++ b/kernel/time/timer.c
@@ -2499,7 +2499,7 @@ static void run_local_timers(void)
 		 */
 		if (time_after_eq(jiffies, READ_ONCE(base->next_expiry)) ||
 		    (i == BASE_DEF && tmigr_requires_handle_remote())) {
-			__raise_softirq_irqoff(TIMER_SOFTIRQ);
+			raise_timer_softirq(TIMER_SOFTIRQ);
 			return;
 		}
 	}

