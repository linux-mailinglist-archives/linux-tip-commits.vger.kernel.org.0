Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DDA833AC66A
	for <lists+linux-tip-commits@lfdr.de>; Fri, 18 Jun 2021 10:46:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232917AbhFRIsO (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 18 Jun 2021 04:48:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231908AbhFRIsO (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 18 Jun 2021 04:48:14 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 537EBC061574;
        Fri, 18 Jun 2021 01:46:05 -0700 (PDT)
Date:   Fri, 18 Jun 2021 08:46:01 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1624005962;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mrDSPmQpW9Wn5BMsqgTHWoVyAIA8VJnGX+pAy2ZsF+g=;
        b=2DFlPzLjEwa+jvmQhMZRB0wq2X4Tx68Vf+/rjyvCgSz1XxrBdlLFp8arPFQ0+/liUAL/4H
        MBXDdLuaheaqLYqdHTMbZlzGARc9SCZ4uf7scGZDWQlCfdlwRExk+0ChMKbHYu+Pg1kneR
        tw0OtOFIAbkfyBp/8maS9xAI+ekTrQ0fOnjXmTN5u+7oPHD+3EIBthctQwrgmohDIKtAA6
        8i3IbdQY7lzg4UFqpiDwrqciOqZ+qV+5dH4eeYelzz9t552JICc2rZELX8pxMvobk5/meH
        Ne0rEHBzmdpdvB4NWdS6DQ+BYxyxy8FdvY+j3r+oEEoXTjcGx2GbsFIYLclwsQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1624005962;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mrDSPmQpW9Wn5BMsqgTHWoVyAIA8VJnGX+pAy2ZsF+g=;
        b=h+8HvS+8dYb8fYD4+AY5caTkRNXq39meVb4duXVTuDF67MI6R9luyf5AhkQkqCz4I5pabz
        /E8UVC9JyRfU43AQ==
From:   "tip-bot2 for Kan Liang" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf/x86: Reset the dirty counter to prevent the
 leak for an RDPMC task
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Kan Liang <kan.liang@linux.intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <1623693582-187370-1-git-send-email-kan.liang@linux.intel.com>
References: <1623693582-187370-1-git-send-email-kan.liang@linux.intel.com>
MIME-Version: 1.0
Message-ID: <162400596176.19906.9473455259701503617.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     5471eea5d3bf850316f1064a6f57b34c444bce67
Gitweb:        https://git.kernel.org/tip/5471eea5d3bf850316f1064a6f57b34c444bce67
Author:        Kan Liang <kan.liang@linux.intel.com>
AuthorDate:    Mon, 14 Jun 2021 10:59:42 -07:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Thu, 17 Jun 2021 14:11:47 +02:00

perf/x86: Reset the dirty counter to prevent the leak for an RDPMC task

The counter value of a perf task may leak to another RDPMC task.
For example, a perf stat task as below is running on CPU 0.

    perf stat -e 'branches,cycles' -- taskset -c 0 ./workload

In the meantime, an RDPMC task, which is also running on CPU 0, may read
the GP counters periodically. (The RDPMC task creates a fixed event,
but read four GP counters.)

    $./rdpmc_read_all_counters
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

Three methods were considered to address the issue.

 - Unconditionally reset the counter in x86_pmu_del(). It can bring extra
   overhead even when there is no RDPMC task running.

 - Only reset the un-assigned dirty counters when the RDPMC task is
   scheduled in via sched_task(). It fails for the below case.

	Thread A			Thread B

	clone(CLONE_THREAD) --->
	set_affine(0)
					set_affine(1)
					while (!event-enabled)
						;
	event = perf_event_open()
	mmap(event)
	ioctl(event, IOC_ENABLE); --->
					RDPMC

   Counters are still leaked to the thread B.

 - Only reset the un-assigned dirty counters before updating the CR4.PCE
   bit. The method is implemented here.

The dirty counter is a counter, on which the assigned event has been
deleted, but the counter is not reset. To track the dirty counters,
add a 'dirty' variable in the struct cpu_hw_events.

The security issue can only be found with an RDPMC task. To enable the
RDMPC, the CR4.PCE bit has to be updated. Add a
perf_clear_dirty_counters() right before updating the CR4.PCE bit to
clear the existing dirty counters. Only the current un-assigned dirty
counters are reset, because the RDPMC assigned dirty counters will be
updated soon.

After applying the patch,

        $ ./rdpmc_read_all_counters
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
uses one counter; while the other user uses all available counters.
When the RDPMC task is scheduled in, all the counters, other than the
RDPMC assigned one, have to be reset.

Test results for the worst-case, using a modified lat_ctx as measured
on an Ice Lake platform, which has 8 GP and 3 FP counters (ignoring
SLOTS).

    lat_ctx -s 128K -N 1000 processes 2

Without the patch:
  The context switch time is 4.97 us

With the patch:
  The context switch time is 5.16 us

There is ~4% performance drop for the context switching time in the
worst-case.

Suggested-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/1623693582-187370-1-git-send-email-kan.liang@linux.intel.com
---
 arch/x86/events/core.c            | 28 +++++++++++++++++++++++++++-
 arch/x86/events/perf_event.h      |  1 +
 arch/x86/include/asm/perf_event.h |  1 +
 arch/x86/mm/tlb.c                 | 10 ++++++++--
 4 files changed, 37 insertions(+), 3 deletions(-)

diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
index 8e50932..c0167d5 100644
--- a/arch/x86/events/core.c
+++ b/arch/x86/events/core.c
@@ -1624,6 +1624,8 @@ static void x86_pmu_del(struct perf_event *event, int flags)
 	if (cpuc->txn_flags & PERF_PMU_TXN_ADD)
 		goto do_del;
 
+	__set_bit(event->hw.idx, cpuc->dirty);
+
 	/*
 	 * Not a TXN, therefore cleanup properly.
 	 */
@@ -2472,6 +2474,31 @@ static int x86_pmu_event_init(struct perf_event *event)
 	return err;
 }
 
+void perf_clear_dirty_counters(void)
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
@@ -2495,7 +2522,6 @@ static void x86_pmu_event_mapped(struct perf_event *event, struct mm_struct *mm)
 
 static void x86_pmu_event_unmapped(struct perf_event *event, struct mm_struct *mm)
 {
-
 	if (!(event->hw.flags & PERF_X86_EVENT_RDPMC_ALLOWED))
 		return;
 
diff --git a/arch/x86/events/perf_event.h b/arch/x86/events/perf_event.h
index 27fa85e..d6003e0 100644
--- a/arch/x86/events/perf_event.h
+++ b/arch/x86/events/perf_event.h
@@ -229,6 +229,7 @@ struct cpu_hw_events {
 	 */
 	struct perf_event	*events[X86_PMC_IDX_MAX]; /* in counter order */
 	unsigned long		active_mask[BITS_TO_LONGS(X86_PMC_IDX_MAX)];
+	unsigned long		dirty[BITS_TO_LONGS(X86_PMC_IDX_MAX)];
 	int			enabled;
 
 	int			n_events; /* the # of events in the below arrays */
diff --git a/arch/x86/include/asm/perf_event.h b/arch/x86/include/asm/perf_event.h
index 544f41a..8fc1b50 100644
--- a/arch/x86/include/asm/perf_event.h
+++ b/arch/x86/include/asm/perf_event.h
@@ -478,6 +478,7 @@ struct x86_pmu_lbr {
 
 extern void perf_get_x86_pmu_capability(struct x86_pmu_capability *cap);
 extern void perf_check_microcode(void);
+extern void perf_clear_dirty_counters(void);
 extern int x86_perf_rdpmc_index(struct perf_event *event);
 #else
 static inline void perf_get_x86_pmu_capability(struct x86_pmu_capability *cap)
diff --git a/arch/x86/mm/tlb.c b/arch/x86/mm/tlb.c
index 7880468..cfe6b1e 100644
--- a/arch/x86/mm/tlb.c
+++ b/arch/x86/mm/tlb.c
@@ -14,6 +14,7 @@
 #include <asm/nospec-branch.h>
 #include <asm/cache.h>
 #include <asm/apic.h>
+#include <asm/perf_event.h>
 
 #include "mm_internal.h"
 
@@ -404,9 +405,14 @@ static inline void cr4_update_pce_mm(struct mm_struct *mm)
 {
 	if (static_branch_unlikely(&rdpmc_always_available_key) ||
 	    (!static_branch_unlikely(&rdpmc_never_available_key) &&
-	     atomic_read(&mm->context.perf_rdpmc_allowed)))
+	     atomic_read(&mm->context.perf_rdpmc_allowed))) {
+		/*
+		 * Clear the existing dirty counters to
+		 * prevent the leak for an RDPMC task.
+		 */
+		perf_clear_dirty_counters();
 		cr4_set_bits_irqsoff(X86_CR4_PCE);
-	else
+	} else
 		cr4_clear_bits_irqsoff(X86_CR4_PCE);
 }
 
