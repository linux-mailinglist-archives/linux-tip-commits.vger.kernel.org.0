Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA3902659E6
	for <lists+linux-tip-commits@lfdr.de>; Fri, 11 Sep 2020 09:04:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725810AbgIKHDt (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 11 Sep 2020 03:03:49 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:45120 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725788AbgIKHCd (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 11 Sep 2020 03:02:33 -0400
Date:   Fri, 11 Sep 2020 07:02:30 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1599807750;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Dez5WtCz8F/GZpNNa2ctZ64kCc8NF5qw3P5LIg3ei68=;
        b=kl6NBTD9H2c8cLxMxiSW9Cz01Ppc8QrdeLlAhC3oote2pjnA1u65Sti53VTOYF1rQuvEvk
        evD5ATrSBI5NYOpB+j7jF+rfMY8ddhrGz1wsoxcHYkVTWufmZHtVHwN0wYURpVEd7cemX7
        EYmadpW+m1EJZbv5QY/6zW1sKQl3rmwRfKF1Phwuf+/PbGWZgBJeLXZWWL0cUS2FuKh6ut
        JydYOK2inIRjJIfRTPoDDj5dH5PmUMdz0wsCTdd5O3AsHx0frkqp4zWpjjABPmpvpGBCIZ
        xJgl2AG5N90wadjJ9YfFKUsDS9y6r9gDCn6Mc3lA/l62L4h5oj0iE2/xOX2VKw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1599807750;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Dez5WtCz8F/GZpNNa2ctZ64kCc8NF5qw3P5LIg3ei68=;
        b=XGT16Nc2Yxdr0IlUtZyLlhfXTZgZw96AwGtxi9orQs/n55lxaq7vX6sWMkB0/uleFht2Ht
        K92ogfLxXcvsR2Cg==
From:   "tip-bot2 for Kan Liang" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf/x86/intel/ds: Fix x86_pmu_stop warning for large PEBS
Cc:     Like Xu <like.xu@linux.intel.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Kan Liang <kan.liang@linux.intel.com>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200902210649.2743-1-kan.liang@linux.intel.com>
References: <20200902210649.2743-1-kan.liang@linux.intel.com>
MIME-Version: 1.0
Message-ID: <159980775008.20229.8204795134271478943.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-tip-commits-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     35d1ce6bec133679ff16325d335217f108b84871
Gitweb:        https://git.kernel.org/tip/35d1ce6bec133679ff16325d335217f108b84871
Author:        Kan Liang <kan.liang@linux.intel.com>
AuthorDate:    Wed, 02 Sep 2020 14:06:49 -07:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Thu, 10 Sep 2020 11:19:33 +02:00

perf/x86/intel/ds: Fix x86_pmu_stop warning for large PEBS

A warning as below may be triggered when sampling with large PEBS.

[  410.411250] perf: interrupt took too long (72145 > 71975), lowering
kernel.perf_event_max_sample_rate to 2000
[  410.724923] ------------[ cut here ]------------
[  410.729822] WARNING: CPU: 0 PID: 16397 at arch/x86/events/core.c:1422
x86_pmu_stop+0x95/0xa0
[  410.933811]  x86_pmu_del+0x50/0x150
[  410.937304]  event_sched_out.isra.0+0xbc/0x210
[  410.941751]  group_sched_out.part.0+0x53/0xd0
[  410.946111]  ctx_sched_out+0x193/0x270
[  410.949862]  __perf_event_task_sched_out+0x32c/0x890
[  410.954827]  ? set_next_entity+0x98/0x2d0
[  410.958841]  __schedule+0x592/0x9c0
[  410.962332]  schedule+0x5f/0xd0
[  410.965477]  exit_to_usermode_loop+0x73/0x120
[  410.969837]  prepare_exit_to_usermode+0xcd/0xf0
[  410.974369]  ret_from_intr+0x2a/0x3a
[  410.977946] RIP: 0033:0x40123c
[  411.079661] ---[ end trace bc83adaea7bb664a ]---

In the non-overflow context, e.g., context switch, with large PEBS, perf
may stop an event twice. An example is below.

  //max_samples_per_tick is adjusted to 2
  //NMI is triggered
  intel_pmu_handle_irq()
     handle_pmi_common()
       drain_pebs()
         __intel_pmu_pebs_event()
           perf_event_overflow()
             __perf_event_account_interrupt()
               hwc->interrupts = 1
               return 0
  //A context switch happens right after the NMI.
  //In the same tick, the perf_throttled_seq is not changed.
  perf_event_task_sched_out()
     perf_pmu_sched_task()
       intel_pmu_drain_pebs_buffer()
         __intel_pmu_pebs_event()
           perf_event_overflow()
             __perf_event_account_interrupt()
               ++hwc->interrupts >= max_samples_per_tick
               return 1
           x86_pmu_stop();  # First stop
     perf_event_context_sched_out()
       task_ctx_sched_out()
         ctx_sched_out()
           event_sched_out()
             x86_pmu_del()
               x86_pmu_stop();  # Second stop and trigger the warning

Perf should only invoke the perf_event_overflow() in the overflow
context.

Current drain_pebs() is called from:
- handle_pmi_common()			-- overflow context
- intel_pmu_pebs_sched_task()		-- non-overflow context
- intel_pmu_pebs_disable()		-- non-overflow context
- intel_pmu_auto_reload_read()		-- possible overflow context
  With PERF_SAMPLE_READ + PERF_FORMAT_GROUP, the function may be
  invoked in the NMI handler. But, before calling the function, the
  PEBS buffer has already been drained. The __intel_pmu_pebs_event()
  will not be called in the possible overflow context.

To fix the issue, an indicator is required to distinguish between the
overflow context aka handle_pmi_common() and other cases.
The dummy regs pointer can be used as the indicator.

In the non-overflow context, perf should treat the last record the same
as other PEBS records, and doesn't invoke the generic overflow handler.

Fixes: 21509084f999 ("perf/x86/intel: Handle multiple records in the PEBS buffer")
Reported-by: Like Xu <like.xu@linux.intel.com>
Suggested-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Tested-by: Like Xu <like.xu@linux.intel.com>
Link: https://lkml.kernel.org/r/20200902210649.2743-1-kan.liang@linux.intel.com
---
 arch/x86/events/intel/ds.c | 32 ++++++++++++++++++++------------
 1 file changed, 20 insertions(+), 12 deletions(-)

diff --git a/arch/x86/events/intel/ds.c b/arch/x86/events/intel/ds.c
index 86848c5..404315d 100644
--- a/arch/x86/events/intel/ds.c
+++ b/arch/x86/events/intel/ds.c
@@ -670,9 +670,7 @@ unlock:
 
 static inline void intel_pmu_drain_pebs_buffer(void)
 {
-	struct pt_regs regs;
-
-	x86_pmu.drain_pebs(&regs);
+	x86_pmu.drain_pebs(NULL);
 }
 
 /*
@@ -1737,6 +1735,7 @@ static void __intel_pmu_pebs_event(struct perf_event *event,
 	struct x86_perf_regs perf_regs;
 	struct pt_regs *regs = &perf_regs.regs;
 	void *at = get_next_pebs_record_by_bit(base, top, bit);
+	struct pt_regs dummy_iregs;
 
 	if (hwc->flags & PERF_X86_EVENT_AUTO_RELOAD) {
 		/*
@@ -1749,6 +1748,9 @@ static void __intel_pmu_pebs_event(struct perf_event *event,
 	} else if (!intel_pmu_save_and_restart(event))
 		return;
 
+	if (!iregs)
+		iregs = &dummy_iregs;
+
 	while (count > 1) {
 		setup_sample(event, iregs, at, &data, regs);
 		perf_event_output(event, &data, regs);
@@ -1758,16 +1760,22 @@ static void __intel_pmu_pebs_event(struct perf_event *event,
 	}
 
 	setup_sample(event, iregs, at, &data, regs);
-
-	/*
-	 * All but the last records are processed.
-	 * The last one is left to be able to call the overflow handler.
-	 */
-	if (perf_event_overflow(event, &data, regs)) {
-		x86_pmu_stop(event, 0);
-		return;
+	if (iregs == &dummy_iregs) {
+		/*
+		 * The PEBS records may be drained in the non-overflow context,
+		 * e.g., large PEBS + context switch. Perf should treat the
+		 * last record the same as other PEBS records, and doesn't
+		 * invoke the generic overflow handler.
+		 */
+		perf_event_output(event, &data, regs);
+	} else {
+		/*
+		 * All but the last records are processed.
+		 * The last one is left to be able to call the overflow handler.
+		 */
+		if (perf_event_overflow(event, &data, regs))
+			x86_pmu_stop(event, 0);
 	}
-
 }
 
 static void intel_pmu_drain_pebs_core(struct pt_regs *iregs)
