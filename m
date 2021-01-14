Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 71F5E2F6016
	for <lists+linux-tip-commits@lfdr.de>; Thu, 14 Jan 2021 12:31:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728958AbhANLar (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Thu, 14 Jan 2021 06:30:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728813AbhANLaY (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Thu, 14 Jan 2021 06:30:24 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7F1DC061793;
        Thu, 14 Jan 2021 03:29:08 -0800 (PST)
Date:   Thu, 14 Jan 2021 11:29:06 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1610623747;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lQIgjEuuH1IetOZY28Wud2BCP7qYo2Sm8OWZlbVgmxI=;
        b=UKn8rw/hxbsW2C1nhqcKQxRmi/0tA611GqnzkezwahTaDwaT1/Tzxd8KAAADHfpSXcmTGr
        KjnKoWk4X4i/8wh+EfAQC0bENClAUrwsUsS4P45e54nt4xppgAh43JYA2592Vxd64t8raa
        qyhbG4vxP1IiogxsFfKZnzYOBa6HLvuopq2UKKFaibLVGQUDOLk17pccrbSY+tsb8axzU5
        16HcnpbaTDLbqUhB64Fy2FTQ3QkB9k8XnXG9XTzQyR3CFF+r9ShD+No6vNRCKs54fQjXdl
        6lLFjmw6hioVE0N8adfqCcLfYA2dcOt2iuBjux/2Lw5oDw7Ce4qw3kDBllsmkw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1610623747;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lQIgjEuuH1IetOZY28Wud2BCP7qYo2Sm8OWZlbVgmxI=;
        b=RlFquetpk7OomRCKa0cobXA3/LtJzWMzlrTMLs3ohkVtkW/gSw0TkoAXftRP2+/Iknb9P6
        +83bX6pwEObMiLAQ==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched: Add schedutil overview
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Morten Rasmussen <morten.rasmussen@arm.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20201218103258.GA3040@hirez.programming.kicks-ass.net>
References: <20201218103258.GA3040@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Message-ID: <161062374655.414.4068390745030943804.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     0301925dd004539adbcf11f68a3a785472376e27
Gitweb:        https://git.kernel.org/tip/0301925dd004539adbcf11f68a3a785472376e27
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Fri, 18 Dec 2020 11:28:12 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Thu, 14 Jan 2021 11:20:10 +01:00

sched: Add schedutil overview

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Morten Rasmussen <morten.rasmussen@arm.com>
Link: https://lkml.kernel.org/r/20201218103258.GA3040@hirez.programming.kicks-ass.net
---
 Documentation/scheduler/schedutil.txt | 169 +++++++++++++++++++++++++-
 1 file changed, 169 insertions(+)
 create mode 100644 Documentation/scheduler/schedutil.txt

diff --git a/Documentation/scheduler/schedutil.txt b/Documentation/scheduler/schedutil.txt
new file mode 100644
index 0000000..78f6b91
--- /dev/null
+++ b/Documentation/scheduler/schedutil.txt
@@ -0,0 +1,169 @@
+
+
+NOTE; all this assumes a linear relation between frequency and work capacity,
+we know this is flawed, but it is the best workable approximation.
+
+
+PELT (Per Entity Load Tracking)
+-------------------------------
+
+With PELT we track some metrics across the various scheduler entities, from
+individual tasks to task-group slices to CPU runqueues. As the basis for this
+we use an Exponentially Weighted Moving Average (EWMA), each period (1024us)
+is decayed such that y^32 = 0.5. That is, the most recent 32ms contribute
+half, while the rest of history contribute the other half.
+
+Specifically:
+
+  ewma_sum(u) := u_0 + u_1*y + u_2*y^2 + ...
+
+  ewma(u) = ewma_sum(u) / ewma_sum(1)
+
+Since this is essentially a progression of an infinite geometric series, the
+results are composable, that is ewma(A) + ewma(B) = ewma(A+B). This property
+is key, since it gives the ability to recompose the averages when tasks move
+around.
+
+Note that blocked tasks still contribute to the aggregates (task-group slices
+and CPU runqueues), which reflects their expected contribution when they
+resume running.
+
+Using this we track 2 key metrics: 'running' and 'runnable'. 'Running'
+reflects the time an entity spends on the CPU, while 'runnable' reflects the
+time an entity spends on the runqueue. When there is only a single task these
+two metrics are the same, but once there is contention for the CPU 'running'
+will decrease to reflect the fraction of time each task spends on the CPU
+while 'runnable' will increase to reflect the amount of contention.
+
+For more detail see: kernel/sched/pelt.c
+
+
+Frequency- / CPU Invariance
+---------------------------
+
+Because consuming the CPU for 50% at 1GHz is not the same as consuming the CPU
+for 50% at 2GHz, nor is running 50% on a LITTLE CPU the same as running 50% on
+a big CPU, we allow architectures to scale the time delta with two ratios, one
+Dynamic Voltage and Frequency Scaling (DVFS) ratio and one microarch ratio.
+
+For simple DVFS architectures (where software is in full control) we trivially
+compute the ratio as:
+
+	    f_cur
+  r_dvfs := -----
+            f_max
+
+For more dynamic systems where the hardware is in control of DVFS we use
+hardware counters (Intel APERF/MPERF, ARMv8.4-AMU) to provide us this ratio.
+For Intel specifically, we use:
+
+	   APERF
+  f_cur := ----- * P0
+	   MPERF
+
+	     4C-turbo;	if available and turbo enabled
+  f_max := { 1C-turbo;	if turbo enabled
+	     P0;	otherwise
+
+                    f_cur
+  r_dvfs := min( 1, ----- )
+                    f_max
+
+We pick 4C turbo over 1C turbo to make it slightly more sustainable.
+
+r_cpu is determined as the ratio of highest performance level of the current
+CPU vs the highest performance level of any other CPU in the system.
+
+  r_tot = r_dvfs * r_cpu
+
+The result is that the above 'running' and 'runnable' metrics become invariant
+of DVFS and CPU type. IOW. we can transfer and compare them between CPUs.
+
+For more detail see:
+
+ - kernel/sched/pelt.h:update_rq_clock_pelt()
+ - arch/x86/kernel/smpboot.c:"APERF/MPERF frequency ratio computation."
+ - Documentation/scheduler/sched-capacity.rst:"1. CPU Capacity + 2. Task utilization"
+
+
+UTIL_EST / UTIL_EST_FASTUP
+--------------------------
+
+Because periodic tasks have their averages decayed while they sleep, even
+though when running their expected utilization will be the same, they suffer a
+(DVFS) ramp-up after they are running again.
+
+To alleviate this (a default enabled option) UTIL_EST drives an Infinite
+Impulse Response (IIR) EWMA with the 'running' value on dequeue -- when it is
+highest. A further default enabled option UTIL_EST_FASTUP modifies the IIR
+filter to instantly increase and only decay on decrease.
+
+A further runqueue wide sum (of runnable tasks) is maintained of:
+
+  util_est := \Sum_t max( t_running, t_util_est_ewma )
+
+For more detail see: kernel/sched/fair.c:util_est_dequeue()
+
+
+UCLAMP
+------
+
+It is possible to set effective u_min and u_max clamps on each CFS or RT task;
+the runqueue keeps an max aggregate of these clamps for all running tasks.
+
+For more detail see: include/uapi/linux/sched/types.h
+
+
+Schedutil / DVFS
+----------------
+
+Every time the scheduler load tracking is updated (task wakeup, task
+migration, time progression) we call out to schedutil to update the hardware
+DVFS state.
+
+The basis is the CPU runqueue's 'running' metric, which per the above it is
+the frequency invariant utilization estimate of the CPU. From this we compute
+a desired frequency like:
+
+             max( running, util_est );	if UTIL_EST
+  u_cfs := { running;			otherwise
+
+               clamp( u_cfs + u_rt , u_min, u_max );	if UCLAMP_TASK
+  u_clamp := { u_cfs + u_rt;				otherwise
+
+  u := u_clamp + u_irq + u_dl;		[approx. see source for more detail]
+
+  f_des := min( f_max, 1.25 u * f_max )
+
+XXX IO-wait; when the update is due to a task wakeup from IO-completion we
+boost 'u' above.
+
+This frequency is then used to select a P-state/OPP or directly munged into a
+CPPC style request to the hardware.
+
+XXX: deadline tasks (Sporadic Task Model) allows us to calculate a hard f_min
+required to satisfy the workload.
+
+Because these callbacks are directly from the scheduler, the DVFS hardware
+interaction should be 'fast' and non-blocking. Schedutil supports
+rate-limiting DVFS requests for when hardware interaction is slow and
+expensive, this reduces effectiveness.
+
+For more information see: kernel/sched/cpufreq_schedutil.c
+
+
+NOTES
+-----
+
+ - On low-load scenarios, where DVFS is most relevant, the 'running' numbers
+   will closely reflect utilization.
+
+ - In saturated scenarios task movement will cause some transient dips,
+   suppose we have a CPU saturated with 4 tasks, then when we migrate a task
+   to an idle CPU, the old CPU will have a 'running' value of 0.75 while the
+   new CPU will gain 0.25. This is inevitable and time progression will
+   correct this. XXX do we still guarantee f_max due to no idle-time?
+
+ - Much of the above is about avoiding DVFS dips, and independent DVFS domains
+   having to re-learn / ramp-up when load shifts.
+
