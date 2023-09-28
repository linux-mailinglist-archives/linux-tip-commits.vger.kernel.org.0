Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 038137B16D5
	for <lists+linux-tip-commits@lfdr.de>; Thu, 28 Sep 2023 11:07:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231474AbjI1JHK (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Thu, 28 Sep 2023 05:07:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231460AbjI1JHK (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Thu, 28 Sep 2023 05:07:10 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D061AC;
        Thu, 28 Sep 2023 02:07:06 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id a640c23a62f3a-99bdeae1d0aso1632765666b.1;
        Thu, 28 Sep 2023 02:07:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695892024; x=1696496824; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tbmIVcW4v3Jxso1xP5FUAKbZq6/17AVUfLWfdZb1rhw=;
        b=fjKXpxlcHerUwKTsQT91ej/7Z1T9Or/37FVICZzEndZTX/FdWfjYJMbBC+TyDPl7Kn
         WizaPqocyiFiJ51Rs7ce29dQYp9sUEB1jRZYwQ+wju0qirxKWWYXqE1JpJjid3uzNS+4
         9TgLV3+3Qp5qIqTi0Rg+zgQI/ynkh4x01WcHEY1uGuUdmMGm43j0kqB6Xt4Scp0gTVkb
         kr8YhWJzffIthndFOzEPpzdTVdJJ+juJbXJJF7KSZqpRB/a3sXpYreYv7EoO0fre6+0/
         KlWTgjS/1IQ762bmmULh2fnCA0gn1FYQ1Nm/Zw1r7LF5pJTp38CBTqJ4+hE9EXxgeEz/
         kz9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695892024; x=1696496824;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tbmIVcW4v3Jxso1xP5FUAKbZq6/17AVUfLWfdZb1rhw=;
        b=lVsDS+8A8W9QRNlfKd+ZRBgNp6F+LKh+mFInsFMoFq2tf5151ZDsZKlP7muvCQYGfU
         OTW0CMXtfj4QyGnphYEQ+PnFRbiPMItlhfvYrp5aw7hQVmJ9OemuvZ2c205DTJlwpj/4
         lrRfLb5/ND52ZCFEI4UK4HkrYHgEJSxubXeg+SxBJ2dtI1AdIDuhdj9D61Lpr9wD0cmu
         JtcS2saIPvUWxavQPxhtPxHM1sR3zPhiHzfi2XdnlOiGAJiz+IKDiA88srpf43MzxDtB
         wzt8kmefrQ+/hT2UTQfgISHttfgFX6Q1rUz4Tz3HuSWo4wE+hJpvgrzgiLbnT9scMW2N
         F3AQ==
X-Gm-Message-State: AOJu0YzXdYXuGVuQT/o9G/xelzNJmxQYbmlupzmYovPXLUD/FUDySuiI
        P/eUfOrnYHt2HnVsYFhy+87iJeFMlAI=
X-Google-Smtp-Source: AGHT+IGZ9f6sZ1BpatpzSHqqDy8R8EAy9aKDWq7VU0Iff11ueVoXU7wEnVXj9gHZRq0x2prL8/eW1g==
X-Received: by 2002:a17:906:20ce:b0:9a1:e233:e627 with SMTP id c14-20020a17090620ce00b009a1e233e627mr758046ejc.42.1695892023826;
        Thu, 28 Sep 2023 02:07:03 -0700 (PDT)
Received: from gmail.com (1F2EF49C.nat.pool.telekom.hu. [31.46.244.156])
        by smtp.gmail.com with ESMTPSA id t21-20020a170906179500b00988e953a586sm10583153eje.61.2023.09.28.02.07.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Sep 2023 02:07:03 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Thu, 28 Sep 2023 11:07:01 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     linux-kernel@vger.kernel.org,
        Frederic Weisbecker <frederic@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-tip-commits@vger.kernel.org, x86@kernel.org
Subject: [PATCH] tick/nohz: Update comments some more
Message-ID: <ZRVCNeMcSQcXS36N@gmail.com>
References: <20230912104406.312185-3-frederic@kernel.org>
 <169582689118.27769.11953848930688373230.tip-bot2@tip-bot2>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <169582689118.27769.11953848930688373230.tip-bot2@tip-bot2>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org


* tip-bot2 for Frederic Weisbecker <tip-bot2@linutronix.de> wrote:

> Author:        Frederic Weisbecker <frederic@kernel.org>
> AuthorDate:    Tue, 12 Sep 2023 12:44:03 +02:00
> Committer:     Thomas Gleixner <tglx@linutronix.de>
> CommitterDate: Wed, 27 Sep 2023 16:58:10 +02:00
> 
> tick/nohz: Update obsolete comments

Speling nits:

> --- a/kernel/time/tick-sched.c
> +++ b/kernel/time/tick-sched.c

>  /**
> + * tick_nohz_idle_exit - Update the tick upon idle task exit
> + *
> + * When the idle task exits, update the tick depending on the
> + * following situations:
> + *
> + * 1) If the CPU is not in nohz_full mode (most cases), then
> + *    restart the tick.
> + *
> + * 2) If the CPU is in nohz_full mode (corner case):
> + *   2.1) If the tick can be kept stopped (no tick dependencies)
> + *        then re-eavaluate the next tick and try to keep it stopped

s/re-eavaluate
 /re-evaluate

> + *        as long as possible.
> + *   2.2) If the tick has dependencies, restart the tick.
>   *
>   */
>  void tick_nohz_idle_exit(void)
>  {
> @@ -1364,7 +1384,13 @@ void tick_nohz_idle_exit(void)
>  }
>  
>  /*
> + * In low-resolution mode, the tick handler must be implemented directly
> + * at the clockevent level. hrtimer can't be used instead because its

s/instead because
 /instead, because

> + * infrastructure actually relies on the tick itself as a backend in
> + * low-resolution mode (see hrtimer_run_queues()).
> + *
> + * This low-resolution handler still makes use of some hrtimer APIs meanwhile
> + * for commodity with expiration calculation and forwarding.

commodity?

>   */
>  static void tick_nohz_lowres_handler(struct clock_event_device *dev)
>  {

As well-deserved penace for my nitpicking, I've fixed these on top of
tip:timers/core, and have also done a full scan of kernel/time/tick-sched.c
for spelling, consistency of style and readability of comments - see
the patch below.

Thanks,

	Ingo

===========================>
From: Ingo Molnar <mingo@kernel.org>
Date: Thu, 28 Sep 2023 10:45:54 +0200
Subject: [PATCH] tick/nohz: Update comments some more

Inspired by recent enhancements to comments in kernel/time/tick-sched.c,
go through the entire file and fix/unify its comments:

 - Fix over a dozen typos, spelling mistakes & cases of bad grammar.

 - Re-phrase sentences that I needed to read three times to understand.

    [ I used the following arbitrary rule-of-thumb:
       - if I had to read a comment twice, it was usually my fault,
       - if I had to read it a third time, it was the comment's fault. ]

 - Comma updates:

    - Add commas where needed

    - Remove commas where not needed

    - In cases where a comma is optional, choose one variant and try to
      standardize it over similar sentences in the file.   

 - Standardize on standalone 'NOHZ' spelling in free-flowing comments:

      s/nohz/NOHZ
      s/no idle tick/NOHZ

   Still keep 'dynticks' as a popular synonym.

 - Standardize on referring to variable names within free-flowing
   comments with the "'var'" nomenclature, and function names as
   "function_name()".

 - Standardize on '64-bit' and '32-bit':
     s/32bit/32-bit
     s/64bit/64-bit

 - Standardize on 'IRQ work':
     s/irq work/IRQ work

 - A few other tidyups I probably missed to list.

No change in functionality intended - other than one small change to
a syslog output string.

Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 kernel/time/tick-sched.c | 148 +++++++++++++++++++++++------------------------
 1 file changed, 73 insertions(+), 75 deletions(-)

diff --git a/kernel/time/tick-sched.c b/kernel/time/tick-sched.c
index 8e9a9dcf60d5..60f1fe653f52 100644
--- a/kernel/time/tick-sched.c
+++ b/kernel/time/tick-sched.c
@@ -4,7 +4,7 @@
  *  Copyright(C) 2005-2007, Red Hat, Inc., Ingo Molnar
  *  Copyright(C) 2006-2007  Timesys Corp., Thomas Gleixner
  *
- *  No idle tick implementation for low and high resolution timers
+ *  NOHZ implementation for low and high resolution timers
  *
  *  Started by: Thomas Gleixner and Ingo Molnar
  */
@@ -45,7 +45,7 @@ struct tick_sched *tick_get_tick_sched(int cpu)
 
 #if defined(CONFIG_NO_HZ_COMMON) || defined(CONFIG_HIGH_RES_TIMERS)
 /*
- * The time, when the last jiffy update happened. Write access must hold
+ * The time when the last jiffy update happened. Write access must hold
  * jiffies_lock and jiffies_seq. tick_nohz_next_event() needs to get a
  * consistent view of jiffies and last_jiffies_update.
  */
@@ -60,13 +60,13 @@ static void tick_do_update_jiffies64(ktime_t now)
 	ktime_t delta, nextp;
 
 	/*
-	 * 64bit can do a quick check without holding jiffies lock and
+	 * 64-bit can do a quick check without holding the jiffies lock and
 	 * without looking at the sequence count. The smp_load_acquire()
 	 * pairs with the update done later in this function.
 	 *
-	 * 32bit cannot do that because the store of tick_next_period
-	 * consists of two 32bit stores and the first store could move it
-	 * to a random point in the future.
+	 * 32-bit cannot do that because the store of 'tick_next_period'
+	 * consists of two 32-bit stores, and the first store could be
+	 * moved by the CPU to a random point in the future.
 	 */
 	if (IS_ENABLED(CONFIG_64BIT)) {
 		if (ktime_before(now, smp_load_acquire(&tick_next_period)))
@@ -75,7 +75,7 @@ static void tick_do_update_jiffies64(ktime_t now)
 		unsigned int seq;
 
 		/*
-		 * Avoid contention on jiffies_lock and protect the quick
+		 * Avoid contention on 'jiffies_lock' and protect the quick
 		 * check with the sequence count.
 		 */
 		do {
@@ -90,7 +90,7 @@ static void tick_do_update_jiffies64(ktime_t now)
 	/* Quick check failed, i.e. update is required. */
 	raw_spin_lock(&jiffies_lock);
 	/*
-	 * Reevaluate with the lock held. Another CPU might have done the
+	 * Re-evaluate with the lock held. Another CPU might have done the
 	 * update already.
 	 */
 	if (ktime_before(now, tick_next_period)) {
@@ -114,25 +114,23 @@ static void tick_do_update_jiffies64(ktime_t now)
 						   TICK_NSEC);
 	}
 
-	/* Advance jiffies to complete the jiffies_seq protected job */
+	/* Advance jiffies to complete the 'jiffies_seq' protected job */
 	jiffies_64 += ticks;
 
-	/*
-	 * Keep the tick_next_period variable up to date.
-	 */
+	/* Keep the tick_next_period variable up to date */
 	nextp = ktime_add_ns(last_jiffies_update, TICK_NSEC);
 
 	if (IS_ENABLED(CONFIG_64BIT)) {
 		/*
 		 * Pairs with smp_load_acquire() in the lockless quick
-		 * check above and ensures that the update to jiffies_64 is
-		 * not reordered vs. the store to tick_next_period, neither
+		 * check above, and ensures that the update to 'jiffies_64' is
+		 * not reordered vs. the store to 'tick_next_period', neither
 		 * by the compiler nor by the CPU.
 		 */
 		smp_store_release(&tick_next_period, nextp);
 	} else {
 		/*
-		 * A plain store is good enough on 32bit as the quick check
+		 * A plain store is good enough on 32-bit, as the quick check
 		 * above is protected by the sequence count.
 		 */
 		tick_next_period = nextp;
@@ -140,7 +138,7 @@ static void tick_do_update_jiffies64(ktime_t now)
 
 	/*
 	 * Release the sequence count. calc_global_load() below is not
-	 * protected by it, but jiffies_lock needs to be held to prevent
+	 * protected by it, but 'jiffies_lock' needs to be held to prevent
 	 * concurrent invocations.
 	 */
 	write_seqcount_end(&jiffies_seq);
@@ -160,7 +158,8 @@ static ktime_t tick_init_jiffy_update(void)
 
 	raw_spin_lock(&jiffies_lock);
 	write_seqcount_begin(&jiffies_seq);
-	/* Did we start the jiffies update yet ? */
+
+	/* Have we started the jiffies update yet ? */
 	if (last_jiffies_update == 0) {
 		u32 rem;
 
@@ -175,8 +174,10 @@ static ktime_t tick_init_jiffy_update(void)
 		last_jiffies_update = tick_next_period;
 	}
 	period = last_jiffies_update;
+
 	write_seqcount_end(&jiffies_seq);
 	raw_spin_unlock(&jiffies_lock);
+
 	return period;
 }
 
@@ -192,10 +193,10 @@ static void tick_sched_do_timer(struct tick_sched *ts, ktime_t now)
 	 * concurrency: This happens only when the CPU in charge went
 	 * into a long sleep. If two CPUs happen to assign themselves to
 	 * this duty, then the jiffies update is still serialized by
-	 * jiffies_lock.
+	 * 'jiffies_lock'.
 	 *
 	 * If nohz_full is enabled, this should not happen because the
-	 * tick_do_timer_cpu never relinquishes.
+	 * 'tick_do_timer_cpu' CPU never relinquishes.
 	 */
 	if (unlikely(tick_do_timer_cpu == TICK_DO_TIMER_NONE)) {
 #ifdef CONFIG_NO_HZ_FULL
@@ -205,12 +206,12 @@ static void tick_sched_do_timer(struct tick_sched *ts, ktime_t now)
 	}
 #endif
 
-	/* Check, if the jiffies need an update */
+	/* Check if jiffies need an update */
 	if (tick_do_timer_cpu == cpu)
 		tick_do_update_jiffies64(now);
 
 	/*
-	 * If jiffies update stalled for too long (timekeeper in stop_machine()
+	 * If the jiffies update stalled for too long (timekeeper in stop_machine()
 	 * or VMEXIT'ed for several msecs), force an update.
 	 */
 	if (ts->last_tick_jiffies != jiffies) {
@@ -234,10 +235,10 @@ static void tick_sched_handle(struct tick_sched *ts, struct pt_regs *regs)
 	/*
 	 * When we are idle and the tick is stopped, we have to touch
 	 * the watchdog as we might not schedule for a really long
-	 * time. This happens on complete idle SMP systems while
+	 * time. This happens on completely idle SMP systems while
 	 * waiting on the login prompt. We also increment the "start of
 	 * idle" jiffy stamp so the idle accounting adjustment we do
-	 * when we go busy again does not account too much ticks.
+	 * when we go busy again does not account too many ticks.
 	 */
 	if (ts->tick_stopped) {
 		touch_softlockup_watchdog_sched();
@@ -362,7 +363,7 @@ static void tick_nohz_kick_task(struct task_struct *tsk)
 
 	/*
 	 * If the task is not running, run_posix_cpu_timers()
-	 * has nothing to elapse, IPI can then be spared.
+	 * has nothing to elapse, and an IPI can then be optimized out.
 	 *
 	 * activate_task()                      STORE p->tick_dep_mask
 	 *   STORE p->on_rq
@@ -425,7 +426,7 @@ static void tick_nohz_dep_set_all(atomic_t *dep,
 
 /*
  * Set a global tick dependency. Used by perf events that rely on freq and
- * by unstable clock.
+ * unstable clocks.
  */
 void tick_nohz_dep_set(enum tick_dep_bits bit)
 {
@@ -439,7 +440,7 @@ void tick_nohz_dep_clear(enum tick_dep_bits bit)
 
 /*
  * Set per-CPU tick dependency. Used by scheduler and perf events in order to
- * manage events throttling.
+ * manage event-throttling.
  */
 void tick_nohz_dep_set_cpu(int cpu, enum tick_dep_bits bit)
 {
@@ -455,7 +456,7 @@ void tick_nohz_dep_set_cpu(int cpu, enum tick_dep_bits bit)
 		if (cpu == smp_processor_id()) {
 			tick_nohz_full_kick();
 		} else {
-			/* Remote irq work not NMI-safe */
+			/* Remote IRQ work not NMI-safe */
 			if (!WARN_ON_ONCE(in_nmi()))
 				tick_nohz_full_kick_cpu(cpu);
 		}
@@ -473,7 +474,7 @@ void tick_nohz_dep_clear_cpu(int cpu, enum tick_dep_bits bit)
 EXPORT_SYMBOL_GPL(tick_nohz_dep_clear_cpu);
 
 /*
- * Set a per-task tick dependency. RCU need this. Also posix CPU timers
+ * Set a per-task tick dependency. RCU needs this. Also posix CPU timers
  * in order to elapse per task timers.
  */
 void tick_nohz_dep_set_task(struct task_struct *tsk, enum tick_dep_bits bit)
@@ -546,7 +547,7 @@ void __init tick_nohz_full_setup(cpumask_var_t cpumask)
 bool tick_nohz_cpu_hotpluggable(unsigned int cpu)
 {
 	/*
-	 * The tick_do_timer_cpu CPU handles housekeeping duty (unbound
+	 * The 'tick_do_timer_cpu' CPU handles housekeeping duty (unbound
 	 * timers, workqueues, timekeeping, ...) on behalf of full dynticks
 	 * CPUs. It must remain online when nohz full is enabled.
 	 */
@@ -568,12 +569,12 @@ void __init tick_nohz_init(void)
 		return;
 
 	/*
-	 * Full dynticks uses irq work to drive the tick rescheduling on safe
-	 * locking contexts. But then we need irq work to raise its own
-	 * interrupts to avoid circular dependency on the tick
+	 * Full dynticks uses IRQ work to drive the tick rescheduling on safe
+	 * locking contexts. But then we need IRQ work to raise its own
+	 * interrupts to avoid circular dependency on the tick.
 	 */
 	if (!arch_irq_work_has_interrupt()) {
-		pr_warn("NO_HZ: Can't run full dynticks because arch doesn't support irq work self-IPIs\n");
+		pr_warn("NO_HZ: Can't run full dynticks because arch doesn't support IRQ work self-IPIs\n");
 		cpumask_clear(tick_nohz_full_mask);
 		tick_nohz_full_running = false;
 		return;
@@ -643,7 +644,7 @@ bool tick_nohz_tick_stopped_cpu(int cpu)
  * In case the sched_tick was stopped on this CPU, we have to check if jiffies
  * must be updated. Otherwise an interrupt handler could use a stale jiffy
  * value. We do this unconditionally on any CPU, as we don't know whether the
- * CPU, which has the update task assigned is in a long sleep.
+ * CPU, which has the update task assigned, is in a long sleep.
  */
 static void tick_nohz_update_jiffies(ktime_t now)
 {
@@ -726,7 +727,7 @@ static u64 get_cpu_sleep_time_us(struct tick_sched *ts, ktime_t *sleeptime,
  * counters if NULL.
  *
  * Return the cumulative idle time (since boot) for a given
- * CPU, in microseconds. Note this is partially broken due to
+ * CPU, in microseconds. Note that this is partially broken due to
  * the counter of iowait tasks that can be remotely updated without
  * any synchronization. Therefore it is possible to observe backward
  * values within two consecutive reads.
@@ -787,7 +788,7 @@ static void tick_nohz_restart(struct tick_sched *ts, ktime_t now)
 	}
 
 	/*
-	 * Reset to make sure next tick stop doesn't get fooled by past
+	 * Reset to make sure the next tick stop doesn't get fooled by past
 	 * cached clock deadline.
 	 */
 	ts->next_tick = 0;
@@ -816,11 +817,11 @@ static ktime_t tick_nohz_next_event(struct tick_sched *ts, int cpu)
 	/*
 	 * Keep the periodic tick, when RCU, architecture or irq_work
 	 * requests it.
-	 * Aside of that check whether the local timer softirq is
-	 * pending. If so its a bad idea to call get_next_timer_interrupt()
+	 * Aside of that, check whether the local timer softirq is
+	 * pending. If so, its a bad idea to call get_next_timer_interrupt(),
 	 * because there is an already expired timer, so it will request
 	 * immediate expiry, which rearms the hardware timer with a
-	 * minimal delta which brings us back to this place
+	 * minimal delta, which brings us back to this place
 	 * immediately. Lather, rinse and repeat...
 	 */
 	if (rcu_needs_cpu() || arch_needs_cpu() ||
@@ -861,7 +862,7 @@ static ktime_t tick_nohz_next_event(struct tick_sched *ts, int cpu)
 
 	/*
 	 * If this CPU is the one which had the do_timer() duty last, we limit
-	 * the sleep time to the timekeeping max_deferment value.
+	 * the sleep time to the timekeeping 'max_deferment' value.
 	 * Otherwise we can sleep as long as we want.
 	 */
 	delta = timekeeping_max_deferment();
@@ -895,8 +896,8 @@ static void tick_nohz_stop_tick(struct tick_sched *ts, int cpu)
 	 * If this CPU is the one which updates jiffies, then give up
 	 * the assignment and let it be taken by the CPU which runs
 	 * the tick timer next, which might be this CPU as well. If we
-	 * don't drop this here the jiffies might be stale and
-	 * do_timer() never invoked. Keep track of the fact that it
+	 * don't drop this here, the jiffies might be stale and
+	 * do_timer() never gets invoked. Keep track of the fact that it
 	 * was the one which had the do_timer() duty last.
 	 */
 	if (cpu == tick_do_timer_cpu) {
@@ -906,7 +907,7 @@ static void tick_nohz_stop_tick(struct tick_sched *ts, int cpu)
 		ts->do_timer_last = 0;
 	}
 
-	/* Skip reprogram of event if its not changed */
+	/* Skip reprogram of event if it's not changed */
 	if (ts->tick_stopped && (expires == ts->next_tick)) {
 		/* Sanity check: make sure clockevent is actually programmed */
 		if (tick == KTIME_MAX || ts->next_tick == hrtimer_get_expires(&ts->sched_timer))
@@ -919,11 +920,11 @@ static void tick_nohz_stop_tick(struct tick_sched *ts, int cpu)
 	}
 
 	/*
-	 * nohz_stop_sched_tick can be called several times before
-	 * the nohz_restart_sched_tick is called. This happens when
+	 * nohz_stop_sched_tick() can be called several times before
+	 * nohz_restart_sched_tick() is called. This happens when
 	 * interrupts arrive which do not cause a reschedule. In the
 	 * first call we save the current tick time, so we can restart
-	 * the scheduler tick in nohz_restart_sched_tick.
+	 * the scheduler tick in nohz_restart_sched_tick().
 	 */
 	if (!ts->tick_stopped) {
 		calc_load_nohz_start();
@@ -985,9 +986,8 @@ static void tick_nohz_restart_sched_tick(struct tick_sched *ts, ktime_t now)
 
 	calc_load_nohz_stop();
 	touch_softlockup_watchdog_sched();
-	/*
-	 * Cancel the scheduled timer and restore the tick
-	 */
+
+	/* Cancel the scheduled timer and restore the tick: */
 	ts->tick_stopped  = 0;
 	tick_nohz_restart(ts, now);
 }
@@ -1019,11 +1019,11 @@ static void tick_nohz_full_update_tick(struct tick_sched *ts)
 /*
  * A pending softirq outside an IRQ (or softirq disabled section) context
  * should be waiting for ksoftirqd to handle it. Therefore we shouldn't
- * reach here due to the need_resched() early check in can_stop_idle_tick().
+ * reach this code due to the need_resched() early check in can_stop_idle_tick().
  *
  * However if we are between CPUHP_AP_SMPBOOT_THREADS and CPU_TEARDOWN_CPU on the
  * cpu_down() process, softirqs can still be raised while ksoftirqd is parked,
- * triggering the below since wakep_softirqd() is ignored.
+ * triggering the code below, since wakep_softirqd() is ignored.
  *
  */
 static bool report_idle_softirq(void)
@@ -1044,7 +1044,7 @@ static bool report_idle_softirq(void)
 	if (ratelimit >= 10)
 		return false;
 
-	/* On RT, softirqs handling may be waiting on some lock */
+	/* On RT, softirq handling may be waiting on some lock */
 	if (local_bh_blocked())
 		return false;
 
@@ -1061,8 +1061,8 @@ static bool can_stop_idle_tick(int cpu, struct tick_sched *ts)
 	 * If this CPU is offline and it is the one which updates
 	 * jiffies, then give up the assignment and let it be taken by
 	 * the CPU which runs the tick timer next. If we don't drop
-	 * this here the jiffies might be stale and do_timer() never
-	 * invoked.
+	 * this here, the jiffies might be stale and do_timer() never
+	 * gets invoked.
 	 */
 	if (unlikely(!cpu_online(cpu))) {
 		if (cpu == tick_do_timer_cpu)
@@ -1219,7 +1219,7 @@ bool tick_nohz_idle_got_tick(void)
 
 /**
  * tick_nohz_get_next_hrtimer - return the next expiration time for the hrtimer
- * or the tick, whatever that expires first. Note that, if the tick has been
+ * or the tick, whichever expires first. Note that, if the tick has been
  * stopped, it returns the next hrtimer.
  *
  * Called from power state control code with interrupts disabled
@@ -1263,7 +1263,7 @@ ktime_t tick_nohz_get_sleep_length(ktime_t *delta_next)
 		return *delta_next;
 
 	/*
-	 * If the next highres timer to expire is earlier than next_event, the
+	 * If the next highres timer to expire is earlier than 'next_event', the
 	 * idle governor needs to know that.
 	 */
 	next_event = min_t(u64, next_event,
@@ -1307,9 +1307,9 @@ static void tick_nohz_account_idle_time(struct tick_sched *ts,
 	if (vtime_accounting_enabled_this_cpu())
 		return;
 	/*
-	 * We stopped the tick in idle. Update process times would miss the
-	 * time we slept as update_process_times does only a 1 tick
-	 * accounting. Enforce that this is accounted to idle !
+	 * We stopped the tick in idle. update_process_times() would miss the
+	 * time we slept, as it does only a 1 tick accounting.
+	 * Enforce that this is accounted to idle !
 	 */
 	ticks = jiffies - ts->idle_jiffies;
 	/*
@@ -1351,7 +1351,7 @@ static void tick_nohz_idle_update_tick(struct tick_sched *ts, ktime_t now)
  *
  * 2) If the CPU is in nohz_full mode (corner case):
  *   2.1) If the tick can be kept stopped (no tick dependencies)
- *        then re-eavaluate the next tick and try to keep it stopped
+ *        then re-evaluate the next tick and try to keep it stopped
  *        as long as possible.
  *   2.2) If the tick has dependencies, restart the tick.
  *
@@ -1385,7 +1385,7 @@ void tick_nohz_idle_exit(void)
 
 /*
  * In low-resolution mode, the tick handler must be implemented directly
- * at the clockevent level. hrtimer can't be used instead because its
+ * at the clockevent level. hrtimer can't be used instead, because its
  * infrastructure actually relies on the tick itself as a backend in
  * low-resolution mode (see hrtimer_run_queues()).
  *
@@ -1426,7 +1426,7 @@ static inline void tick_nohz_activate(struct tick_sched *ts, int mode)
 }
 
 /**
- * tick_nohz_switch_to_nohz - switch to nohz mode
+ * tick_nohz_switch_to_nohz - switch to NOHZ mode
  */
 static void tick_nohz_switch_to_nohz(void)
 {
@@ -1440,8 +1440,8 @@ static void tick_nohz_switch_to_nohz(void)
 		return;
 
 	/*
-	 * Recycle the hrtimer in ts, so we can share the
-	 * hrtimer_forward with the highres code.
+	 * Recycle the hrtimer in 'ts', so we can share the
+	 * hrtimer_forward_now() function with the highres code.
 	 */
 	hrtimer_init(&ts->sched_timer, CLOCK_MONOTONIC, HRTIMER_MODE_ABS_HARD);
 	/* Get the next period */
@@ -1464,7 +1464,7 @@ static inline void tick_nohz_irq_enter(void)
 	if (ts->idle_active)
 		tick_nohz_stop_idle(ts, now);
 	/*
-	 * If all CPUs are idle. We may need to update a stale jiffies value.
+	 * If all CPUs are idle we may need to update a stale jiffies value.
 	 * Note nohz_full is a special case: a timekeeper is guaranteed to stay
 	 * alive but it might be busy looping with interrupts disabled in some
 	 * rare case (typically stop machine). So we must make sure we have a
@@ -1483,7 +1483,7 @@ static inline void tick_nohz_activate(struct tick_sched *ts, int mode) { }
 #endif /* CONFIG_NO_HZ_COMMON */
 
 /*
- * Called from irq_enter to notify about the possible interruption of idle()
+ * Called from irq_enter() to notify about the possible interruption of idle()
  */
 void tick_irq_enter(void)
 {
@@ -1509,8 +1509,8 @@ static enum hrtimer_restart tick_nohz_highres_handler(struct hrtimer *timer)
 	tick_sched_do_timer(ts, now);
 
 	/*
-	 * Do not call, when we are not in irq context and have
-	 * no valid regs pointer
+	 * Do not call when we are not in IRQ context and have
+	 * no valid 'regs' pointer
 	 */
 	if (regs)
 		tick_sched_handle(ts, regs);
@@ -1548,16 +1548,14 @@ void tick_setup_sched_timer(void)
 	struct tick_sched *ts = this_cpu_ptr(&tick_cpu_sched);
 	ktime_t now = ktime_get();
 
-	/*
-	 * Emulate tick processing via per-CPU hrtimers:
-	 */
+	/* Emulate tick processing via per-CPU hrtimers: */
 	hrtimer_init(&ts->sched_timer, CLOCK_MONOTONIC, HRTIMER_MODE_ABS_HARD);
 	ts->sched_timer.function = tick_nohz_highres_handler;
 
 	/* Get the next period (per-CPU) */
 	hrtimer_set_expires(&ts->sched_timer, tick_init_jiffy_update());
 
-	/* Offset the tick to avert jiffies_lock contention. */
+	/* Offset the tick to avert 'jiffies_lock' contention. */
 	if (sched_skew_tick) {
 		u64 offset = TICK_NSEC >> 1;
 		do_div(offset, num_possible_cpus());
@@ -1607,10 +1605,10 @@ void tick_oneshot_notify(void)
 }
 
 /*
- * Check, if a change happened, which makes oneshot possible.
+ * Check if a change happened, which makes oneshot possible.
  *
- * Called cyclic from the hrtimer softirq (driven by the timer
- * softirq) allow_nohz signals, that we can switch into low-res nohz
+ * Called cyclically from the hrtimer softirq (driven by the timer
+ * softirq). 'allow_nohz' signals that we can switch into low-res NOHZ
  * mode, because high resolution timers are disabled (either compile
  * or runtime). Called with interrupts disabled.
  */
