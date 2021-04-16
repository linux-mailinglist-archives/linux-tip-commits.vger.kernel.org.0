Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 509A836234D
	for <lists+linux-tip-commits@lfdr.de>; Fri, 16 Apr 2021 17:04:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245206AbhDPPCQ (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 16 Apr 2021 11:02:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245102AbhDPPCP (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 16 Apr 2021 11:02:15 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87987C061574;
        Fri, 16 Apr 2021 08:01:50 -0700 (PDT)
Date:   Fri, 16 Apr 2021 15:01:48 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1618585309;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6BRlBVM8ZJt2G5liGBKjneb4ZMZk8FOVwZtTsYVsX48=;
        b=f4lzEPe00YdHzVto0wuN1J2lKhEX/KiOaUwgsVHlevQ9R2Fp7tiurm8MQmwWiGh5Z+/rzn
        cLWR8MecCubPOHwcwuII+Lyb7uCbkSX8ayY4eepZsjTHi3191MjC6uJzul2qI0Yjcb9R4N
        blkqebjwE01IuCpvEZC+NqwfQRfUktFgm6PzL3ue3jYNlXojck7puceHXg54UJXKaKIOFE
        ozjaNeLsK4YJXmkW3TLYp3ajisnzaTkA8hxuWwj2Se7etakTNh6ECVOd/5RhmP8S0Uz2+b
        9jVhVWszOeT7xP/ALhggJ7qqBfT1v4d6913iNIq5HM90ZLLmz/wpKDTJ3tGzIA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1618585309;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6BRlBVM8ZJt2G5liGBKjneb4ZMZk8FOVwZtTsYVsX48=;
        b=kNpa8MW8tg83vOHqum93TzChepwZ7rhSGM4RadVbukdoi6hnlaI92L7LbssVlBLBKIySha
        dp19RsY3+CIEFcDw==
From:   "tip-bot2 for Kan Liang" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf/x86: Reset the dirty counter to prevent the
 leak for an RDPMC task
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Kan Liang <kan.liang@linux.intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <1618410990-21383-2-git-send-email-kan.liang@linux.intel.com>
References: <1618410990-21383-2-git-send-email-kan.liang@linux.intel.com>
MIME-Version: 1.0
Message-ID: <161858530850.29796.5870405530830102241.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     01fd9661e168de7cfc4f947e7220fca0e6791999
Gitweb:        https://git.kernel.org/tip/01fd9661e168de7cfc4f947e7220fca0e6791999
Author:        Kan Liang <kan.liang@linux.intel.com>
AuthorDate:    Wed, 14 Apr 2021 07:36:30 -07:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 16 Apr 2021 16:32:43 +02:00

perf/x86: Reset the dirty counter to prevent the leak for an RDPMC task

The counter value of a perf task may leak to another RDPMC task.
For example, a perf stat task as below is running on CPU 0.

    perf stat -e 'branches,cycles' -- taskset -c 0 ./workload

In the meantime, an RDPMC task, which is also running on CPU 0, may read
the GP counters periodically. (The RDPMC task creates a fixed event,
but read four GP counters.)

    $ taskset -c 0 ./rdpmc_read_all_counters
    index 0x0 value 0x8001e5970f99
    index 0x1 value 0x8005d750edb6
    index 0x2 value 0x0
    index 0x3 value 0x0

    index 0x0 value 0x8002358e48a5
    index 0x1 value 0x8006bd1e3bc9
    index 0x2 value 0x0
    index 0x3 value 0x0

It is a potential security issue. Once the attacker knows what the other
thread is counting. The PerfMon counter can be used as a side-channel to
attack cryptosystems.

The counter value of the perf stat task leaks to the RDPMC task because
perf never clears the counter when it's stopped.

Two methods were considered to address the issue.
- Unconditionally reset the counter in x86_pmu_del(). It can bring extra
  overhead even when there is no RDPMC task running.
- Only reset the un-assigned dirty counters when the RDPMC task is
  scheduled in. The method is implemented here.

The dirty counter is a counter, on which the assigned event has been
deleted, but the counter is not reset. To track the dirty counters,
add a 'dirty' variable in the struct cpu_hw_events.

The current code doesn't reset the counter when the assigned event is
deleted. Set the corresponding bit in the 'dirty' variable in
x86_pmu_del(), if the RDPMC feature is available on the system.

The security issue can only be found with an RDPMC task. The event for
an RDPMC task requires the mmap buffer. This can be used to detect an
RDPMC task. Once the event is detected in the event_mapped(), enable
sched_task(), which is invoked in each context switch. Add a check in
the sched_task() to clear the dirty counters, when the RDPMC task is
scheduled in. Only the current un-assigned dirty counters are reset,
bacuase the RDPMC assigned dirty counters will be updated soon.

The RDPMC instruction is also supported on the older platforms. Add
sched_task() for the core_pmu. The core_pmu doesn't support large PEBS
and LBR callstack, the intel_pmu_pebs/lbr_sched_task() will be ignored.

The RDPMC is not Intel-only feature. Add the dirty counters clear code
in the X86 generic code.

After applying the patch,

        $ taskset -c 0 ./rdpmc_read_all_counters
        index 0x0 value 0x0
        index 0x1 value 0x0
        index 0x2 value 0x0
        index 0x3 value 0x0

        index 0x0 value 0x0
        index 0x1 value 0x0
        index 0x2 value 0x0
        index 0x3 value 0x0

Performance

The performance of a context switch only be impacted when there are two
or more perf users and one of the users must be an RDPMC user. In other
cases, there is no performance impact.

The worst-case occurs when there are two users: the RDPMC user only
applies one counter; while the other user applies all available
counters. When the RDPMC task is scheduled in, all the counters, other
than the RDPMC assigned one, have to be reset.

Here is the test result for the worst-case.

The test is implemented on an Ice Lake platform, which has 8 GP
counters and 3 fixed counters (Not include SLOTS counter).

The lat_ctx is used to measure the context switching time.

    lat_ctx -s 128K -N 1000 processes 2

I instrument the lat_ctx to open all 8 GP counters and 3 fixed
counters for one task. The other task opens a fixed counter and enable
RDPMC.

Without the patch:
The context switch time is 4.97 us

With the patch:
The context switch time is 5.16 us

There is ~4% performance drop for the context switching time in the
worst-case.

Suggested-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/1618410990-21383-2-git-send-email-kan.liang@linux.intel.com
---
 arch/x86/events/core.c       | 47 +++++++++++++++++++++++++++++++++++-
 arch/x86/events/perf_event.h |  1 +-
 2 files changed, 48 insertions(+)

diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
index dd9f3c2..e34eb72 100644
--- a/arch/x86/events/core.c
+++ b/arch/x86/events/core.c
@@ -1585,6 +1585,8 @@ static void x86_pmu_del(struct perf_event *event, int flags)
 	if (cpuc->txn_flags & PERF_PMU_TXN_ADD)
 		goto do_del;
 
+	__set_bit(event->hw.idx, cpuc->dirty);
+
 	/*
 	 * Not a TXN, therefore cleanup properly.
 	 */
@@ -2304,12 +2306,46 @@ static int x86_pmu_event_init(struct perf_event *event)
 	return err;
 }
 
+static void x86_pmu_clear_dirty_counters(void)
+{
+	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
+	int i;
+
+	 /* Don't need to clear the assigned counter. */
+	for (i = 0; i < cpuc->n_events; i++)
+		__clear_bit(cpuc->assign[i], cpuc->dirty);
+
+	if (bitmap_empty(cpuc->dirty, X86_PMC_IDX_MAX))
+		return;
+
+	for_each_set_bit(i, cpuc->dirty, X86_PMC_IDX_MAX) {
+		/* Metrics and fake events don't have corresponding HW counters. */
+		if (is_metric_idx(i) || (i == INTEL_PMC_IDX_FIXED_VLBR))
+			continue;
+		else if (i >= INTEL_PMC_IDX_FIXED)
+			wrmsrl(MSR_ARCH_PERFMON_FIXED_CTR0 + (i - INTEL_PMC_IDX_FIXED), 0);
+		else
+			wrmsrl(x86_pmu_event_addr(i), 0);
+	}
+
+	bitmap_zero(cpuc->dirty, X86_PMC_IDX_MAX);
+}
+
 static void x86_pmu_event_mapped(struct perf_event *event, struct mm_struct *mm)
 {
 	if (!(event->hw.flags & PERF_X86_EVENT_RDPMC_ALLOWED))
 		return;
 
 	/*
+	 * Enable sched_task() for the RDPMC task,
+	 * and clear the existing dirty counters.
+	 */
+	if (x86_pmu.sched_task && event->hw.target) {
+		perf_sched_cb_inc(event->ctx->pmu);
+		x86_pmu_clear_dirty_counters();
+	}
+
+	/*
 	 * This function relies on not being called concurrently in two
 	 * tasks in the same mm.  Otherwise one task could observe
 	 * perf_rdpmc_allowed > 1 and return all the way back to
@@ -2331,6 +2367,9 @@ static void x86_pmu_event_unmapped(struct perf_event *event, struct mm_struct *m
 	if (!(event->hw.flags & PERF_X86_EVENT_RDPMC_ALLOWED))
 		return;
 
+	if (x86_pmu.sched_task && event->hw.target)
+		perf_sched_cb_dec(event->ctx->pmu);
+
 	if (atomic_dec_and_test(&mm->context.perf_rdpmc_allowed))
 		on_each_cpu_mask(mm_cpumask(mm), cr4_update_pce, NULL, 1);
 }
@@ -2436,6 +2475,14 @@ static const struct attribute_group *x86_pmu_attr_groups[] = {
 static void x86_pmu_sched_task(struct perf_event_context *ctx, bool sched_in)
 {
 	static_call_cond(x86_pmu_sched_task)(ctx, sched_in);
+
+	/*
+	 * If a new task has the RDPMC enabled, clear the dirty counters
+	 * to prevent the potential leak.
+	 */
+	if (sched_in && ctx && READ_ONCE(x86_pmu.attr_rdpmc) &&
+	    current->mm && atomic_read(&current->mm->context.perf_rdpmc_allowed))
+		x86_pmu_clear_dirty_counters();
 }
 
 static void x86_pmu_swap_task_ctx(struct perf_event_context *prev,
diff --git a/arch/x86/events/perf_event.h b/arch/x86/events/perf_event.h
index 54a340e..e855f20 100644
--- a/arch/x86/events/perf_event.h
+++ b/arch/x86/events/perf_event.h
@@ -228,6 +228,7 @@ struct cpu_hw_events {
 	 */
 	struct perf_event	*events[X86_PMC_IDX_MAX]; /* in counter order */
 	unsigned long		active_mask[BITS_TO_LONGS(X86_PMC_IDX_MAX)];
+	unsigned long		dirty[BITS_TO_LONGS(X86_PMC_IDX_MAX)];
 	int			enabled;
 
 	int			n_events; /* the # of events in the below arrays */
