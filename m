Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 87EA2253FC8
	for <lists+linux-tip-commits@lfdr.de>; Thu, 27 Aug 2020 09:56:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728480AbgH0H4L (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Thu, 27 Aug 2020 03:56:11 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:36802 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728425AbgH0Hyb (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Thu, 27 Aug 2020 03:54:31 -0400
Date:   Thu, 27 Aug 2020 07:54:28 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1598514868;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=998Mxj6ZR4cuWBvKgZEKUei+GKcasgYRPJGfg/A/+is=;
        b=Mq44+TdW4fmGkTr3Z5oXcr9skYGWUdIkVy3HcPZiTwDimJaoHkHXmmG4v/FWAqvC7bWvVs
        p+iMvISLBU24ih7QInfK4NBO5tHQAuqPBHwZ8Qq4LESGG+oyEqJAnkKeaBuoc5td4Vur6D
        PJ9rVa9p7TaFWrA7addISUgy/66hLkYa+ph9XlO/fUdnT57h5TQPjzxbMwsIPkCGtE+V30
        sCuHQ+n6OnHuFuOOiXooQJRpo4v2A95vBgnyDWSjOLVbJd2A1kAiEEBiazsZuRo7fC02eC
        XYSpmbSmVxTqjVOOfLpIzXaLSft8Sri52DMyI0XSVmoRT/5U2wspIAGoCh1Jxw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1598514868;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=998Mxj6ZR4cuWBvKgZEKUei+GKcasgYRPJGfg/A/+is=;
        b=sg9PfaILdjV+oxXEPJblH7gIAIFzgxF4G5e1zhrQVPEJGCJfAvt4KNq2nNPJX2VCQeObsp
        7S3xCBqJBCJX/xDg==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] sched,idle,rcu: Push rcu_idle deeper into the idle path
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Marco Elver <elver@google.com>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200821085348.310943801@infradead.org>
References: <20200821085348.310943801@infradead.org>
MIME-Version: 1.0
Message-ID: <159851486807.20229.7903134121913378872.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-tip-commits-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     1098582a0f6c4e8fd28da0a6305f9233d02c9c1d
Gitweb:        https://git.kernel.org/tip/1098582a0f6c4e8fd28da0a6305f9233d02c9c1d
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Fri, 07 Aug 2020 20:50:19 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 26 Aug 2020 12:41:53 +02:00

sched,idle,rcu: Push rcu_idle deeper into the idle path

Lots of things take locks, due to a wee bug, rcu_lockdep didn't notice
that the locking tracepoints were using RCU.

Push rcu_idle_{enter,exit}() as deep as possible into the idle paths,
this also resolves a lot of _rcuidle()/RCU_NONIDLE() usage.

Specifically, sched_clock_idle_wakeup_event() will use ktime which
will use seqlocks which will tickle lockdep, and
stop_critical_timings() uses lock.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Tested-by: Marco Elver <elver@google.com>
Link: https://lkml.kernel.org/r/20200821085348.310943801@infradead.org
---
 drivers/cpuidle/cpuidle.c | 12 ++++++++----
 kernel/sched/idle.c       | 22 ++++++++--------------
 2 files changed, 16 insertions(+), 18 deletions(-)

diff --git a/drivers/cpuidle/cpuidle.c b/drivers/cpuidle/cpuidle.c
index 2fe4f3c..9bcda41 100644
--- a/drivers/cpuidle/cpuidle.c
+++ b/drivers/cpuidle/cpuidle.c
@@ -145,13 +145,14 @@ static void enter_s2idle_proper(struct cpuidle_driver *drv,
 	 * executing it contains RCU usage regarded as invalid in the idle
 	 * context, so tell RCU about that.
 	 */
-	RCU_NONIDLE(tick_freeze());
+	tick_freeze();
 	/*
 	 * The state used here cannot be a "coupled" one, because the "coupled"
 	 * cpuidle mechanism enables interrupts and doing that with timekeeping
 	 * suspended is generally unsafe.
 	 */
 	stop_critical_timings();
+	rcu_idle_enter();
 	drv->states[index].enter_s2idle(dev, drv, index);
 	if (WARN_ON_ONCE(!irqs_disabled()))
 		local_irq_disable();
@@ -160,7 +161,8 @@ static void enter_s2idle_proper(struct cpuidle_driver *drv,
 	 * first CPU executing it calls functions containing RCU read-side
 	 * critical sections, so tell RCU about that.
 	 */
-	RCU_NONIDLE(tick_unfreeze());
+	rcu_idle_exit();
+	tick_unfreeze();
 	start_critical_timings();
 
 	time_end = ns_to_ktime(local_clock());
@@ -229,16 +231,18 @@ int cpuidle_enter_state(struct cpuidle_device *dev, struct cpuidle_driver *drv,
 	/* Take note of the planned idle state. */
 	sched_idle_set_state(target_state);
 
-	trace_cpu_idle_rcuidle(index, dev->cpu);
+	trace_cpu_idle(index, dev->cpu);
 	time_start = ns_to_ktime(local_clock());
 
 	stop_critical_timings();
+	rcu_idle_enter();
 	entered_state = target_state->enter(dev, drv, index);
+	rcu_idle_exit();
 	start_critical_timings();
 
 	sched_clock_idle_wakeup_event();
 	time_end = ns_to_ktime(local_clock());
-	trace_cpu_idle_rcuidle(PWR_EVENT_EXIT, dev->cpu);
+	trace_cpu_idle(PWR_EVENT_EXIT, dev->cpu);
 
 	/* The cpu is no longer idle or about to enter idle. */
 	sched_idle_set_state(NULL);
diff --git a/kernel/sched/idle.c b/kernel/sched/idle.c
index 6bf3498..ea3a098 100644
--- a/kernel/sched/idle.c
+++ b/kernel/sched/idle.c
@@ -54,17 +54,18 @@ __setup("hlt", cpu_idle_nopoll_setup);
 
 static noinline int __cpuidle cpu_idle_poll(void)
 {
+	trace_cpu_idle(0, smp_processor_id());
+	stop_critical_timings();
 	rcu_idle_enter();
-	trace_cpu_idle_rcuidle(0, smp_processor_id());
 	local_irq_enable();
-	stop_critical_timings();
 
 	while (!tif_need_resched() &&
-		(cpu_idle_force_poll || tick_check_broadcast_expired()))
+	       (cpu_idle_force_poll || tick_check_broadcast_expired()))
 		cpu_relax();
-	start_critical_timings();
-	trace_cpu_idle_rcuidle(PWR_EVENT_EXIT, smp_processor_id());
+
 	rcu_idle_exit();
+	start_critical_timings();
+	trace_cpu_idle(PWR_EVENT_EXIT, smp_processor_id());
 
 	return 1;
 }
@@ -91,7 +92,9 @@ void __cpuidle default_idle_call(void)
 		local_irq_enable();
 	} else {
 		stop_critical_timings();
+		rcu_idle_enter();
 		arch_cpu_idle();
+		rcu_idle_exit();
 		start_critical_timings();
 	}
 }
@@ -158,7 +161,6 @@ static void cpuidle_idle_call(void)
 
 	if (cpuidle_not_available(drv, dev)) {
 		tick_nohz_idle_stop_tick();
-		rcu_idle_enter();
 
 		default_idle_call();
 		goto exit_idle;
@@ -178,21 +180,17 @@ static void cpuidle_idle_call(void)
 		u64 max_latency_ns;
 
 		if (idle_should_enter_s2idle()) {
-			rcu_idle_enter();
 
 			entered_state = call_cpuidle_s2idle(drv, dev);
 			if (entered_state > 0)
 				goto exit_idle;
 
-			rcu_idle_exit();
-
 			max_latency_ns = U64_MAX;
 		} else {
 			max_latency_ns = dev->forced_idle_latency_limit_ns;
 		}
 
 		tick_nohz_idle_stop_tick();
-		rcu_idle_enter();
 
 		next_state = cpuidle_find_deepest_state(drv, dev, max_latency_ns);
 		call_cpuidle(drv, dev, next_state);
@@ -209,8 +207,6 @@ static void cpuidle_idle_call(void)
 		else
 			tick_nohz_idle_retain_tick();
 
-		rcu_idle_enter();
-
 		entered_state = call_cpuidle(drv, dev, next_state);
 		/*
 		 * Give the governor an opportunity to reflect on the outcome
@@ -226,8 +222,6 @@ exit_idle:
 	 */
 	if (WARN_ON_ONCE(irqs_disabled()))
 		local_irq_enable();
-
-	rcu_idle_exit();
 }
 
 /*
