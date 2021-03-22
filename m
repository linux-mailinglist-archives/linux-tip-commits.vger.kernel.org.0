Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D5753452C6
	for <lists+linux-tip-commits@lfdr.de>; Tue, 23 Mar 2021 00:08:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230272AbhCVXHa (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Mon, 22 Mar 2021 19:07:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230232AbhCVXHN (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Mon, 22 Mar 2021 19:07:13 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E731BC061574;
        Mon, 22 Mar 2021 16:07:12 -0700 (PDT)
Date:   Mon, 22 Mar 2021 23:07:06 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1616454429;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=4+wTAUXefXbQj/iP2/lwWR+ApPoyb996Eu08WrXJybk=;
        b=OYW8h4ui1miwCP++fC2pLMzTXTq9Y/fgk9f/MZhu51m6mz8JygfDQFItAdgabbkIGikLWj
        PVdBUPNBny8nfRR7EmE8SdjeiQERhNwfVfTZBKmPMaDzdkpHOFj4k5tB4KYKkr1EOLCowf
        uFH0Smx2hz5PJ7bQonUE01IKjz2p/zelOvTpT+kY7RSsKTGYlL+LO/vb5bYMMATNey5wxD
        pGm2+I1nKMhcmpJfc3LQzHguLRmLQ5lBlLXuhuZQHOy7lplMW+PEgeQa9TWw3fMs6A8gHw
        ncQllbMwS0SXmaFcE0mPp3oE2TT+trSMZ1Sw5L8+wuYCfgdUrQZlfUTPMc/vgw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1616454429;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=4+wTAUXefXbQj/iP2/lwWR+ApPoyb996Eu08WrXJybk=;
        b=jRN2smbvFB5e+9Tw85pmj4e1gjBJT207UI3I27BUCwhhyIxUBr9T3AqV0gwyMRbtKaB/WG
        33YuSY0iZ3K5oBBw==
From:   "tip-bot2 for Ingo Molnar" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] timekeeping, clocksource: Fix various typos in comments
Cc:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        John Stultz <john.stultz@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        linux-kernel@vger.kernel.org, x86@kernel.org
MIME-Version: 1.0
Message-ID: <161645442689.398.5576455713253194712.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     4bf07f6562a01a488877e05267808da7147f44a5
Gitweb:        https://git.kernel.org/tip/4bf07f6562a01a488877e05267808da7147f44a5
Author:        Ingo Molnar <mingo@kernel.org>
AuthorDate:    Mon, 22 Mar 2021 22:39:03 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Mon, 22 Mar 2021 23:06:48 +01:00

timekeeping, clocksource: Fix various typos in comments

Fix ~56 single-word typos in timekeeping & clocksource code comments.

Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: John Stultz <john.stultz@linaro.org>
Cc: Stephen Boyd <sboyd@kernel.org>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: linux-kernel@vger.kernel.org
---
 drivers/clocksource/clksrc-dbx500-prcmu.c           |  8 ++---
 drivers/clocksource/dw_apb_timer_of.c               |  2 +-
 drivers/clocksource/hyperv_timer.c                  |  2 +-
 drivers/clocksource/timer-atmel-tcb.c               |  4 +--
 drivers/clocksource/timer-fsl-ftm.c                 |  2 +-
 drivers/clocksource/timer-microchip-pit64b.c        |  2 +-
 drivers/clocksource/timer-of.c                      |  4 +--
 drivers/clocksource/timer-ti-dm-systimer.c          |  2 +-
 drivers/clocksource/timer-vf-pit.c                  |  2 +-
 include/linux/clocksource.h                         |  2 +-
 include/linux/timex.h                               |  2 +-
 kernel/time/alarmtimer.c                            |  6 ++--
 kernel/time/clocksource.c                           |  4 +--
 kernel/time/hrtimer.c                               | 18 ++++++------
 kernel/time/jiffies.c                               |  2 +-
 kernel/time/ntp.c                                   |  2 +-
 kernel/time/posix-cpu-timers.c                      |  6 ++--
 kernel/time/tick-broadcast-hrtimer.c                |  2 +-
 kernel/time/tick-broadcast.c                        |  4 +--
 kernel/time/tick-oneshot.c                          |  2 +-
 kernel/time/tick-sched.c                            |  2 +-
 kernel/time/tick-sched.h                            |  2 +-
 kernel/time/time.c                                  |  2 +-
 kernel/time/timekeeping.c                           | 10 +++----
 kernel/time/timer.c                                 |  4 +--
 kernel/time/vsyscall.c                              |  2 +-
 tools/testing/selftests/timers/clocksource-switch.c |  4 +--
 tools/testing/selftests/timers/leap-a-day.c         |  2 +-
 tools/testing/selftests/timers/leapcrash.c          |  4 +--
 tools/testing/selftests/timers/threadtest.c         |  2 +-
 30 files changed, 56 insertions(+), 56 deletions(-)

diff --git a/drivers/clocksource/clksrc-dbx500-prcmu.c b/drivers/clocksource/clksrc-dbx500-prcmu.c
index 996900d..2fc93e4 100644
--- a/drivers/clocksource/clksrc-dbx500-prcmu.c
+++ b/drivers/clocksource/clksrc-dbx500-prcmu.c
@@ -18,7 +18,7 @@
 
 #define RATE_32K		32768
 
-#define TIMER_MODE_CONTINOUS	0x1
+#define TIMER_MODE_CONTINUOUS	0x1
 #define TIMER_DOWNCOUNT_VAL	0xffffffff
 
 #define PRCMU_TIMER_REF		0
@@ -55,13 +55,13 @@ static int __init clksrc_dbx500_prcmu_init(struct device_node *node)
 
 	/*
 	 * The A9 sub system expects the timer to be configured as
-	 * a continous looping timer.
+	 * a continuous looping timer.
 	 * The PRCMU should configure it but if it for some reason
 	 * don't we do it here.
 	 */
 	if (readl(clksrc_dbx500_timer_base + PRCMU_TIMER_MODE) !=
-	    TIMER_MODE_CONTINOUS) {
-		writel(TIMER_MODE_CONTINOUS,
+	    TIMER_MODE_CONTINUOUS) {
+		writel(TIMER_MODE_CONTINUOUS,
 		       clksrc_dbx500_timer_base + PRCMU_TIMER_MODE);
 		writel(TIMER_DOWNCOUNT_VAL,
 		       clksrc_dbx500_timer_base + PRCMU_TIMER_REF);
diff --git a/drivers/clocksource/dw_apb_timer_of.c b/drivers/clocksource/dw_apb_timer_of.c
index 42e7e43..2b2c3b5 100644
--- a/drivers/clocksource/dw_apb_timer_of.c
+++ b/drivers/clocksource/dw_apb_timer_of.c
@@ -38,7 +38,7 @@ static int __init timer_get_base_and_rate(struct device_node *np,
 	}
 
 	/*
-	 * Not all implementations use a periphal clock, so don't panic
+	 * Not all implementations use a peripheral clock, so don't panic
 	 * if it's not present
 	 */
 	pclk = of_clk_get_by_name(np, "pclk");
diff --git a/drivers/clocksource/hyperv_timer.c b/drivers/clocksource/hyperv_timer.c
index 269a691..a02b0a2 100644
--- a/drivers/clocksource/hyperv_timer.c
+++ b/drivers/clocksource/hyperv_timer.c
@@ -457,7 +457,7 @@ void __init hv_init_clocksource(void)
 {
 	/*
 	 * Try to set up the TSC page clocksource. If it succeeds, we're
-	 * done. Otherwise, set up the MSR clocksoruce.  At least one of
+	 * done. Otherwise, set up the MSR clocksource.  At least one of
 	 * these will always be available except on very old versions of
 	 * Hyper-V on x86.  In that case we won't have a Hyper-V
 	 * clocksource, but Linux will still run with a clocksource based
diff --git a/drivers/clocksource/timer-atmel-tcb.c b/drivers/clocksource/timer-atmel-tcb.c
index 787dbeb..27af17c 100644
--- a/drivers/clocksource/timer-atmel-tcb.c
+++ b/drivers/clocksource/timer-atmel-tcb.c
@@ -455,9 +455,9 @@ static int __init tcb_clksrc_init(struct device_node *node)
 	tcaddr = tc.regs;
 
 	if (bits == 32) {
-		/* use apropriate function to read 32 bit counter */
+		/* use appropriate function to read 32 bit counter */
 		clksrc.read = tc_get_cycles32;
-		/* setup ony channel 0 */
+		/* setup only channel 0 */
 		tcb_setup_single_chan(&tc, best_divisor_idx);
 		tc_sched_clock = tc_sched_clock_read32;
 		tc_delay_timer.read_current_timer = tc_delay_timer_read32;
diff --git a/drivers/clocksource/timer-fsl-ftm.c b/drivers/clocksource/timer-fsl-ftm.c
index 12a2ed7..93f336e 100644
--- a/drivers/clocksource/timer-fsl-ftm.c
+++ b/drivers/clocksource/timer-fsl-ftm.c
@@ -116,7 +116,7 @@ static int ftm_set_next_event(unsigned long delta,
 	 * to the MOD register latches the value into a buffer. The MOD
 	 * register is updated with the value of its write buffer with
 	 * the following scenario:
-	 * a, the counter source clock is diabled.
+	 * a, the counter source clock is disabled.
 	 */
 	ftm_counter_disable(priv->clkevt_base);
 
diff --git a/drivers/clocksource/timer-microchip-pit64b.c b/drivers/clocksource/timer-microchip-pit64b.c
index ab623b2..cfa4ec7 100644
--- a/drivers/clocksource/timer-microchip-pit64b.c
+++ b/drivers/clocksource/timer-microchip-pit64b.c
@@ -237,7 +237,7 @@ static void __init mchp_pit64b_pres_compute(u32 *pres, u32 clk_rate,
 			break;
 	}
 
-	/* Use the bigest prescaler if we didn't match one. */
+	/* Use the biggest prescaler if we didn't match one. */
 	if (*pres == MCHP_PIT64B_PRES_MAX)
 		*pres = MCHP_PIT64B_PRES_MAX - 1;
 }
diff --git a/drivers/clocksource/timer-of.c b/drivers/clocksource/timer-of.c
index 572da47..529cc6a 100644
--- a/drivers/clocksource/timer-of.c
+++ b/drivers/clocksource/timer-of.c
@@ -211,10 +211,10 @@ out_fail:
 }
 
 /**
- * timer_of_cleanup - release timer_of ressources
+ * timer_of_cleanup - release timer_of resources
  * @to: timer_of structure
  *
- * Release the ressources that has been used in timer_of_init().
+ * Release the resources that has been used in timer_of_init().
  * This function should be called in init error cases
  */
 void __init timer_of_cleanup(struct timer_of *to)
diff --git a/drivers/clocksource/timer-ti-dm-systimer.c b/drivers/clocksource/timer-ti-dm-systimer.c
index 33b3e8a..614c838 100644
--- a/drivers/clocksource/timer-ti-dm-systimer.c
+++ b/drivers/clocksource/timer-ti-dm-systimer.c
@@ -589,7 +589,7 @@ static int __init dmtimer_clockevent_init(struct device_node *np)
 		"always-on " : "", t->rate, np->parent);
 
 	clockevents_config_and_register(dev, t->rate,
-					3, /* Timer internal resynch latency */
+					3, /* Timer internal resync latency */
 					0xffffffff);
 
 	if (of_machine_is_compatible("ti,am33xx") ||
diff --git a/drivers/clocksource/timer-vf-pit.c b/drivers/clocksource/timer-vf-pit.c
index 1a86a4e..911c921 100644
--- a/drivers/clocksource/timer-vf-pit.c
+++ b/drivers/clocksource/timer-vf-pit.c
@@ -136,7 +136,7 @@ static int __init pit_clockevent_init(unsigned long rate, int irq)
 	/*
 	 * The value for the LDVAL register trigger is calculated as:
 	 * LDVAL trigger = (period / clock period) - 1
-	 * The pit is a 32-bit down count timer, when the conter value
+	 * The pit is a 32-bit down count timer, when the counter value
 	 * reaches 0, it will generate an interrupt, thus the minimal
 	 * LDVAL trigger value is 1. And then the min_delta is
 	 * minimal LDVAL trigger value + 1, and the max_delta is full 32-bit.
diff --git a/include/linux/clocksource.h b/include/linux/clocksource.h
index 86d143d..a247b08 100644
--- a/include/linux/clocksource.h
+++ b/include/linux/clocksource.h
@@ -70,7 +70,7 @@ struct module;
  * @mark_unstable:	Optional function to inform the clocksource driver that
  *			the watchdog marked the clocksource unstable
  * @tick_stable:        Optional function called periodically from the watchdog
- *			code to provide stable syncrhonization points
+ *			code to provide stable synchronization points
  * @wd_list:		List head to enqueue into the watchdog list (internal)
  * @cs_last:		Last clocksource value for clocksource watchdog
  * @wd_last:		Last watchdog value corresponding to @cs_last
diff --git a/include/linux/timex.h b/include/linux/timex.h
index 9c2e54f..059b18e 100644
--- a/include/linux/timex.h
+++ b/include/linux/timex.h
@@ -133,7 +133,7 @@
 
 /*
  * kernel variables
- * Note: maximum error = NTP synch distance = dispersion + delay / 2;
+ * Note: maximum error = NTP sync distance = dispersion + delay / 2;
  * estimated error = NTP dispersion.
  */
 extern unsigned long tick_usec;		/* USER_HZ period (usec) */
diff --git a/kernel/time/alarmtimer.c b/kernel/time/alarmtimer.c
index 98d7a15..e9af8fa 100644
--- a/kernel/time/alarmtimer.c
+++ b/kernel/time/alarmtimer.c
@@ -2,13 +2,13 @@
 /*
  * Alarmtimer interface
  *
- * This interface provides a timer which is similarto hrtimers,
+ * This interface provides a timer which is similar to hrtimers,
  * but triggers a RTC alarm if the box is suspend.
  *
  * This interface is influenced by the Android RTC Alarm timer
  * interface.
  *
- * Copyright (C) 2010 IBM Corperation
+ * Copyright (C) 2010 IBM Corporation
  *
  * Author: John Stultz <john.stultz@linaro.org>
  */
@@ -811,7 +811,7 @@ static long __sched alarm_timer_nsleep_restart(struct restart_block *restart)
 /**
  * alarm_timer_nsleep - alarmtimer nanosleep
  * @which_clock: clockid
- * @flags: determins abstime or relative
+ * @flags: determines abstime or relative
  * @tsreq: requested sleep time (abs or rel)
  *
  * Handles clock_nanosleep calls against _ALARM clockids
diff --git a/kernel/time/clocksource.c b/kernel/time/clocksource.c
index cce484a..1d1a613 100644
--- a/kernel/time/clocksource.c
+++ b/kernel/time/clocksource.c
@@ -38,7 +38,7 @@
  * calculated mult and shift factors. This guarantees that no 64bit
  * overflow happens when the input value of the conversion is
  * multiplied with the calculated mult factor. Larger ranges may
- * reduce the conversion accuracy by chosing smaller mult and shift
+ * reduce the conversion accuracy by choosing smaller mult and shift
  * factors.
  */
 void
@@ -518,7 +518,7 @@ static void clocksource_suspend_select(bool fallback)
  * the suspend time when resuming system.
  *
  * This function is called late in the suspend process from timekeeping_suspend(),
- * that means processes are freezed, non-boot cpus and interrupts are disabled
+ * that means processes are frozen, non-boot cpus and interrupts are disabled
  * now. It is therefore possible to start the suspend timer without taking the
  * clocksource mutex.
  */
diff --git a/kernel/time/hrtimer.c b/kernel/time/hrtimer.c
index 788b9d1..30b356c 100644
--- a/kernel/time/hrtimer.c
+++ b/kernel/time/hrtimer.c
@@ -683,7 +683,7 @@ hrtimer_force_reprogram(struct hrtimer_cpu_base *cpu_base, int skip_equal)
 	 * T1 is removed, so this code is called and would reprogram
 	 * the hardware to 5s from now. Any hrtimer_start after that
 	 * will not reprogram the hardware due to hang_detected being
-	 * set. So we'd effectivly block all timers until the T2 event
+	 * set. So we'd effectively block all timers until the T2 event
 	 * fires.
 	 */
 	if (!__hrtimer_hres_active(cpu_base) || cpu_base->hang_detected)
@@ -1019,7 +1019,7 @@ static void __remove_hrtimer(struct hrtimer *timer,
 	 * cpu_base->next_timer. This happens when we remove the first
 	 * timer on a remote cpu. No harm as we never dereference
 	 * cpu_base->next_timer. So the worst thing what can happen is
-	 * an superflous call to hrtimer_force_reprogram() on the
+	 * an superfluous call to hrtimer_force_reprogram() on the
 	 * remote cpu later on if the same timer gets enqueued again.
 	 */
 	if (reprogram && timer == cpu_base->next_timer)
@@ -1212,7 +1212,7 @@ static void hrtimer_cpu_base_unlock_expiry(struct hrtimer_cpu_base *base)
  * The counterpart to hrtimer_cancel_wait_running().
  *
  * If there is a waiter for cpu_base->expiry_lock, then it was waiting for
- * the timer callback to finish. Drop expiry_lock and reaquire it. That
+ * the timer callback to finish. Drop expiry_lock and reacquire it. That
  * allows the waiter to acquire the lock and make progress.
  */
 static void hrtimer_sync_wait_running(struct hrtimer_cpu_base *cpu_base,
@@ -1398,7 +1398,7 @@ static void __hrtimer_init(struct hrtimer *timer, clockid_t clock_id,
 	int base;
 
 	/*
-	 * On PREEMPT_RT enabled kernels hrtimers which are not explicitely
+	 * On PREEMPT_RT enabled kernels hrtimers which are not explicitly
 	 * marked for hard interrupt expiry mode are moved into soft
 	 * interrupt context for latency reasons and because the callbacks
 	 * can invoke functions which might sleep on RT, e.g. spin_lock().
@@ -1430,7 +1430,7 @@ static void __hrtimer_init(struct hrtimer *timer, clockid_t clock_id,
  * hrtimer_init - initialize a timer to the given clock
  * @timer:	the timer to be initialized
  * @clock_id:	the clock to be used
- * @mode:       The modes which are relevant for intitialization:
+ * @mode:       The modes which are relevant for initialization:
  *              HRTIMER_MODE_ABS, HRTIMER_MODE_REL, HRTIMER_MODE_ABS_SOFT,
  *              HRTIMER_MODE_REL_SOFT
  *
@@ -1487,7 +1487,7 @@ EXPORT_SYMBOL_GPL(hrtimer_active);
  * insufficient for that.
  *
  * The sequence numbers are required because otherwise we could still observe
- * a false negative if the read side got smeared over multiple consequtive
+ * a false negative if the read side got smeared over multiple consecutive
  * __run_hrtimer() invocations.
  */
 
@@ -1588,7 +1588,7 @@ static void __hrtimer_run_queues(struct hrtimer_cpu_base *cpu_base, ktime_t now,
 			 * minimizing wakeups, not running timers at the
 			 * earliest interrupt after their soft expiration.
 			 * This allows us to avoid using a Priority Search
-			 * Tree, which can answer a stabbing querry for
+			 * Tree, which can answer a stabbing query for
 			 * overlapping intervals and instead use the simple
 			 * BST we already have.
 			 * We don't add extra wakeups by delaying timers that
@@ -1822,7 +1822,7 @@ static void __hrtimer_init_sleeper(struct hrtimer_sleeper *sl,
 				   clockid_t clock_id, enum hrtimer_mode mode)
 {
 	/*
-	 * On PREEMPT_RT enabled kernels hrtimers which are not explicitely
+	 * On PREEMPT_RT enabled kernels hrtimers which are not explicitly
 	 * marked for hard interrupt expiry mode are moved into soft
 	 * interrupt context either for latency reasons or because the
 	 * hrtimer callback takes regular spinlocks or invokes other
@@ -1835,7 +1835,7 @@ static void __hrtimer_init_sleeper(struct hrtimer_sleeper *sl,
 	 * the same CPU. That causes a latency spike due to the wakeup of
 	 * a gazillion threads.
 	 *
-	 * OTOH, priviledged real-time user space applications rely on the
+	 * OTOH, privileged real-time user space applications rely on the
 	 * low latency of hard interrupt wakeups. If the current task is in
 	 * a real-time scheduling class, mark the mode for hard interrupt
 	 * expiry.
diff --git a/kernel/time/jiffies.c b/kernel/time/jiffies.c
index a5cffe2..a492e4d 100644
--- a/kernel/time/jiffies.c
+++ b/kernel/time/jiffies.c
@@ -44,7 +44,7 @@ static u64 jiffies_read(struct clocksource *cs)
  * the timer interrupt frequency HZ and it suffers
  * inaccuracies caused by missed or lost timer
  * interrupts and the inability for the timer
- * interrupt hardware to accuratly tick at the
+ * interrupt hardware to accurately tick at the
  * requested HZ value. It is also not recommended
  * for "tick-less" systems.
  */
diff --git a/kernel/time/ntp.c b/kernel/time/ntp.c
index 5247afd..406dccb 100644
--- a/kernel/time/ntp.c
+++ b/kernel/time/ntp.c
@@ -544,7 +544,7 @@ static inline bool rtc_tv_nsec_ok(unsigned long set_offset_nsec,
 				  struct timespec64 *to_set,
 				  const struct timespec64 *now)
 {
-	/* Allowed error in tv_nsec, arbitarily set to 5 jiffies in ns. */
+	/* Allowed error in tv_nsec, arbitrarily set to 5 jiffies in ns. */
 	const unsigned long TIME_SET_NSEC_FUZZ = TICK_NSEC * 5;
 	struct timespec64 delay = {.tv_sec = -1,
 				   .tv_nsec = set_offset_nsec};
diff --git a/kernel/time/posix-cpu-timers.c b/kernel/time/posix-cpu-timers.c
index a71758e..b145e68 100644
--- a/kernel/time/posix-cpu-timers.c
+++ b/kernel/time/posix-cpu-timers.c
@@ -279,7 +279,7 @@ void thread_group_sample_cputime(struct task_struct *tsk, u64 *samples)
  * @tsk:	Task for which cputime needs to be started
  * @samples:	Storage for time samples
  *
- * The thread group cputime accouting is avoided when there are no posix
+ * The thread group cputime accounting is avoided when there are no posix
  * CPU timers armed. Before starting a timer it's required to check whether
  * the time accounting is active. If not, a full update of the atomic
  * accounting store needs to be done and the accounting enabled.
@@ -390,7 +390,7 @@ static int posix_cpu_timer_create(struct k_itimer *new_timer)
 	/*
 	 * If posix timer expiry is handled in task work context then
 	 * timer::it_lock can be taken without disabling interrupts as all
-	 * other locking happens in task context. This requires a seperate
+	 * other locking happens in task context. This requires a separate
 	 * lock class key otherwise regular posix timer expiry would record
 	 * the lock class being taken in interrupt context and generate a
 	 * false positive warning.
@@ -1216,7 +1216,7 @@ static void handle_posix_cpu_timers(struct task_struct *tsk)
 		check_process_timers(tsk, &firing);
 
 		/*
-		 * The above timer checks have updated the exipry cache and
+		 * The above timer checks have updated the expiry cache and
 		 * because nothing can have queued or modified timers after
 		 * sighand lock was taken above it is guaranteed to be
 		 * consistent. So the next timer interrupt fastpath check
diff --git a/kernel/time/tick-broadcast-hrtimer.c b/kernel/time/tick-broadcast-hrtimer.c
index b5a65e2..797eb93 100644
--- a/kernel/time/tick-broadcast-hrtimer.c
+++ b/kernel/time/tick-broadcast-hrtimer.c
@@ -53,7 +53,7 @@ static int bc_set_next(ktime_t expires, struct clock_event_device *bc)
 	 * reasons.
 	 *
 	 * Each caller tries to arm the hrtimer on its own CPU, but if the
-	 * hrtimer callbback function is currently running, then
+	 * hrtimer callback function is currently running, then
 	 * hrtimer_start() cannot move it and the timer stays on the CPU on
 	 * which it is assigned at the moment.
 	 *
diff --git a/kernel/time/tick-broadcast.c b/kernel/time/tick-broadcast.c
index 5a23829..6ec7855 100644
--- a/kernel/time/tick-broadcast.c
+++ b/kernel/time/tick-broadcast.c
@@ -157,7 +157,7 @@ static void tick_device_setup_broadcast_func(struct clock_event_device *dev)
 }
 
 /*
- * Check, if the device is disfunctional and a place holder, which
+ * Check, if the device is dysfunctional and a placeholder, which
  * needs to be handled by the broadcast device.
  */
 int tick_device_uses_broadcast(struct clock_event_device *dev, int cpu)
@@ -391,7 +391,7 @@ void tick_broadcast_control(enum tick_broadcast_mode mode)
 			 * - the broadcast device exists
 			 * - the broadcast device is not a hrtimer based one
 			 * - the broadcast device is in periodic mode to
-			 *   avoid a hickup during switch to oneshot mode
+			 *   avoid a hiccup during switch to oneshot mode
 			 */
 			if (bc && !(bc->features & CLOCK_EVT_FEAT_HRTIMER) &&
 			    tick_broadcast_device.mode == TICKDEV_MODE_PERIODIC)
diff --git a/kernel/time/tick-oneshot.c b/kernel/time/tick-oneshot.c
index f9745d4..475ecce 100644
--- a/kernel/time/tick-oneshot.c
+++ b/kernel/time/tick-oneshot.c
@@ -45,7 +45,7 @@ int tick_program_event(ktime_t expires, int force)
 }
 
 /**
- * tick_resume_onshot - resume oneshot mode
+ * tick_resume_oneshot - resume oneshot mode
  */
 void tick_resume_oneshot(void)
 {
diff --git a/kernel/time/tick-sched.c b/kernel/time/tick-sched.c
index e10a4af..128735e 100644
--- a/kernel/time/tick-sched.c
+++ b/kernel/time/tick-sched.c
@@ -751,7 +751,7 @@ static ktime_t tick_nohz_next_event(struct tick_sched *ts, int cpu)
 	 * Aside of that check whether the local timer softirq is
 	 * pending. If so its a bad idea to call get_next_timer_interrupt()
 	 * because there is an already expired timer, so it will request
-	 * immeditate expiry, which rearms the hardware timer with a
+	 * immediate expiry, which rearms the hardware timer with a
 	 * minimal delta which brings us back to this place
 	 * immediately. Lather, rinse and repeat...
 	 */
diff --git a/kernel/time/tick-sched.h b/kernel/time/tick-sched.h
index 4fb0652..d952ae3 100644
--- a/kernel/time/tick-sched.h
+++ b/kernel/time/tick-sched.h
@@ -29,7 +29,7 @@ enum tick_nohz_mode {
  * @inidle:		Indicator that the CPU is in the tick idle mode
  * @tick_stopped:	Indicator that the idle tick has been stopped
  * @idle_active:	Indicator that the CPU is actively in the tick idle mode;
- *			it is resetted during irq handling phases.
+ *			it is reset during irq handling phases.
  * @do_timer_lst:	CPU was the last one doing do_timer before going idle
  * @got_idle_tick:	Tick timer function has run with @inidle set
  * @last_tick:		Store the last tick expiry time when the tick
diff --git a/kernel/time/time.c b/kernel/time/time.c
index 3985b2b..29923b2 100644
--- a/kernel/time/time.c
+++ b/kernel/time/time.c
@@ -571,7 +571,7 @@ EXPORT_SYMBOL(__usecs_to_jiffies);
 /*
  * The TICK_NSEC - 1 rounds up the value to the next resolution.  Note
  * that a remainder subtract here would not do the right thing as the
- * resolution values don't fall on second boundries.  I.e. the line:
+ * resolution values don't fall on second boundaries.  I.e. the line:
  * nsec -= nsec % TICK_NSEC; is NOT a correct resolution rounding.
  * Note that due to the small error in the multiplier here, this
  * rounding is incorrect for sufficiently large values of tv_nsec, but
diff --git a/kernel/time/timekeeping.c b/kernel/time/timekeeping.c
index 6aee576..77bafd8 100644
--- a/kernel/time/timekeeping.c
+++ b/kernel/time/timekeeping.c
@@ -596,14 +596,14 @@ EXPORT_SYMBOL_GPL(ktime_get_real_fast_ns);
  * careful cache layout of the timekeeper because the sequence count and
  * struct tk_read_base would then need two cache lines instead of one.
  *
- * Access to the time keeper clock source is disabled accross the innermost
+ * Access to the time keeper clock source is disabled across the innermost
  * steps of suspend/resume. The accessors still work, but the timestamps
  * are frozen until time keeping is resumed which happens very early.
  *
  * For regular suspend/resume there is no observable difference vs. sched
  * clock, but it might affect some of the nasty low level debug printks.
  *
- * OTOH, access to sched clock is not guaranteed accross suspend/resume on
+ * OTOH, access to sched clock is not guaranteed across suspend/resume on
  * all systems either so it depends on the hardware in use.
  *
  * If that turns out to be a real problem then this could be mitigated by
@@ -899,7 +899,7 @@ ktime_t ktime_get_coarse_with_offset(enum tk_offsets offs)
 EXPORT_SYMBOL_GPL(ktime_get_coarse_with_offset);
 
 /**
- * ktime_mono_to_any() - convert mononotic time to any other time
+ * ktime_mono_to_any() - convert monotonic time to any other time
  * @tmono:	time to convert.
  * @offs:	which offset to use
  */
@@ -1948,7 +1948,7 @@ static __always_inline void timekeeping_apply_adjustment(struct timekeeper *tk,
 	 *	xtime_nsec_1 = offset + xtime_nsec_2
 	 * Which gives us:
 	 *	xtime_nsec_2 = xtime_nsec_1 - offset
-	 * Which simplfies to:
+	 * Which simplifies to:
 	 *	xtime_nsec -= offset
 	 */
 	if ((mult_adj > 0) && (tk->tkr_mono.mult + mult_adj < mult_adj)) {
@@ -2336,7 +2336,7 @@ static int timekeeping_validate_timex(const struct __kernel_timex *txc)
 
 		/*
 		 * Validate if a timespec/timeval used to inject a time
-		 * offset is valid.  Offsets can be postive or negative, so
+		 * offset is valid.  Offsets can be positive or negative, so
 		 * we don't check tv_sec. The value of the timeval/timespec
 		 * is the sum of its fields,but *NOTE*:
 		 * The field tv_usec/tv_nsec must always be non-negative and
diff --git a/kernel/time/timer.c b/kernel/time/timer.c
index f475f1a..d111adf 100644
--- a/kernel/time/timer.c
+++ b/kernel/time/timer.c
@@ -894,7 +894,7 @@ static inline void forward_timer_base(struct timer_base *base)
 	/*
 	 * No need to forward if we are close enough below jiffies.
 	 * Also while executing timers, base->clk is 1 offset ahead
-	 * of jiffies to avoid endless requeuing to current jffies.
+	 * of jiffies to avoid endless requeuing to current jiffies.
 	 */
 	if ((long)(jnow - base->clk) < 1)
 		return;
@@ -1271,7 +1271,7 @@ static inline void timer_base_unlock_expiry(struct timer_base *base)
  * The counterpart to del_timer_wait_running().
  *
  * If there is a waiter for base->expiry_lock, then it was waiting for the
- * timer callback to finish. Drop expiry_lock and reaquire it. That allows
+ * timer callback to finish. Drop expiry_lock and reacquire it. That allows
  * the waiter to acquire the lock and make progress.
  */
 static void timer_sync_wait_running(struct timer_base *base)
diff --git a/kernel/time/vsyscall.c b/kernel/time/vsyscall.c
index 88e6b8e..f0d5062 100644
--- a/kernel/time/vsyscall.c
+++ b/kernel/time/vsyscall.c
@@ -108,7 +108,7 @@ void update_vsyscall(struct timekeeper *tk)
 
 	/*
 	 * If the current clocksource is not VDSO capable, then spare the
-	 * update of the high reolution parts.
+	 * update of the high resolution parts.
 	 */
 	if (clock_mode != VDSO_CLOCKMODE_NONE)
 		update_vdso_data(vdata, tk);
diff --git a/tools/testing/selftests/timers/clocksource-switch.c b/tools/testing/selftests/timers/clocksource-switch.c
index bfc974b..ef8eb36 100644
--- a/tools/testing/selftests/timers/clocksource-switch.c
+++ b/tools/testing/selftests/timers/clocksource-switch.c
@@ -3,7 +3,7 @@
  *		(C) Copyright IBM 2012
  *		Licensed under the GPLv2
  *
- *  NOTE: This is a meta-test which quickly changes the clocksourc and
+ *  NOTE: This is a meta-test which quickly changes the clocksource and
  *  then uses other tests to detect problems. Thus this test requires
  *  that the inconsistency-check and nanosleep tests be present in the
  *  same directory it is run from.
@@ -134,7 +134,7 @@ int main(int argv, char **argc)
 		return -1;
 	}
 
-	/* Check everything is sane before we start switching asyncrhonously */
+	/* Check everything is sane before we start switching asynchronously */
 	for (i = 0; i < count; i++) {
 		printf("Validating clocksource %s\n", clocksource_list[i]);
 		if (change_clocksource(clocksource_list[i])) {
diff --git a/tools/testing/selftests/timers/leap-a-day.c b/tools/testing/selftests/timers/leap-a-day.c
index 19e46ed..23eb398 100644
--- a/tools/testing/selftests/timers/leap-a-day.c
+++ b/tools/testing/selftests/timers/leap-a-day.c
@@ -5,7 +5,7 @@
  *              Licensed under the GPLv2
  *
  *  This test signals the kernel to insert a leap second
- *  every day at midnight GMT. This allows for stessing the
+ *  every day at midnight GMT. This allows for stressing the
  *  kernel's leap-second behavior, as well as how well applications
  *  handle the leap-second discontinuity.
  *
diff --git a/tools/testing/selftests/timers/leapcrash.c b/tools/testing/selftests/timers/leapcrash.c
index dc80728..f70802c 100644
--- a/tools/testing/selftests/timers/leapcrash.c
+++ b/tools/testing/selftests/timers/leapcrash.c
@@ -4,10 +4,10 @@
  *              (C) Copyright 2013, 2015 Linaro Limited
  *              Licensed under the GPL
  *
- * This test demonstrates leapsecond deadlock that is possibe
+ * This test demonstrates leapsecond deadlock that is possible
  * on kernels from 2.6.26 to 3.3.
  *
- * WARNING: THIS WILL LIKELY HARDHANG SYSTEMS AND MAY LOSE DATA
+ * WARNING: THIS WILL LIKELY HARD HANG SYSTEMS AND MAY LOSE DATA
  * RUN AT YOUR OWN RISK!
  *  To build:
  *	$ gcc leapcrash.c -o leapcrash -lrt
diff --git a/tools/testing/selftests/timers/threadtest.c b/tools/testing/selftests/timers/threadtest.c
index cf3e489..80aed4b 100644
--- a/tools/testing/selftests/timers/threadtest.c
+++ b/tools/testing/selftests/timers/threadtest.c
@@ -76,7 +76,7 @@ void checklist(struct timespec *list, int size)
 
 /* The shared thread shares a global list
  * that each thread fills while holding the lock.
- * This stresses clock syncronization across cpus.
+ * This stresses clock synchronization across cpus.
  */
 void *shared_thread(void *arg)
 {
