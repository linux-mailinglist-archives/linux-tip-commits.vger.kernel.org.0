Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A4539362350
	for <lists+linux-tip-commits@lfdr.de>; Fri, 16 Apr 2021 17:04:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245336AbhDPPCR (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 16 Apr 2021 11:02:17 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:57832 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245016AbhDPPCP (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 16 Apr 2021 11:02:15 -0400
Date:   Fri, 16 Apr 2021 15:01:48 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1618585309;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=EfNsaAKFgrlJTgiYwqy/0Gk77Zs1acOnMeF6fRzmH5w=;
        b=XoG7/lk6YmEkubkjF+3sUivIqCp1J8rkC0EVyUSz2sGNqVF4LiTlBuYkB47knqLHgrR2Gr
        Jdmw664GCgZSYVXnUaFdD4BHG4LC4sw1GFWlo/S/fyQKlVUxt5PTGeRW5v4pn36dgtrT6P
        ZDg96NCNUSwV0AI1cJZiwBqmLG1IgFRIWKM55YmdE/Zb5R5s+zK7hSinYrzp1Gf46FizrN
        5te65Ny1J2nh5202VvVFYnLNU5nApbIyolTRdZ1ErirnV8Ax9/nK34+99WG4qvfuoREXX4
        ITsIJQlb/ilArbTG+f5/lK7vxb7t1VNr7O6S24Sf5TdKk/eMhgr0FgeT+mFEhw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1618585309;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=EfNsaAKFgrlJTgiYwqy/0Gk77Zs1acOnMeF6fRzmH5w=;
        b=NlbXSSeTptrBi3AfEutn0hiD8hdHlTjxisnDzcKn6fHCtixBbxA2OqSWYFbdVozsqdg3AC
        SjdkspOE7lflhuCg==
From:   "tip-bot2 for Kan Liang" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf/x86: Move cpuc->running into P4 specific code
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Kan Liang <kan.liang@linux.intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <1618410990-21383-1-git-send-email-kan.liang@linux.intel.com>
References: <1618410990-21383-1-git-send-email-kan.liang@linux.intel.com>
MIME-Version: 1.0
Message-ID: <161858530884.29796.6826658469436606903.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     46ade4740bbf9bf4e804ddb2c85845cccd219f3c
Gitweb:        https://git.kernel.org/tip/46ade4740bbf9bf4e804ddb2c85845cccd219f3c
Author:        Kan Liang <kan.liang@linux.intel.com>
AuthorDate:    Wed, 14 Apr 2021 07:36:29 -07:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 16 Apr 2021 16:32:42 +02:00

perf/x86: Move cpuc->running into P4 specific code

The 'running' variable is only used in the P4 PMU. Current perf sets the
variable in the critical function x86_pmu_start(), which wastes cycles
for everybody not running on P4.

Move cpuc->running into the P4 specific p4_pmu_enable_event().

Add a static per-CPU 'p4_running' variable to replace the 'running'
variable in the struct cpu_hw_events. Saves space for the generic
structure.

The p4_pmu_enable_all() also invokes the p4_pmu_enable_event(), but it
should not set cpuc->running. Factor out __p4_pmu_enable_event() for
p4_pmu_enable_all().

Suggested-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/1618410990-21383-1-git-send-email-kan.liang@linux.intel.com
---
 arch/x86/events/core.c       |  1 -
 arch/x86/events/intel/p4.c   | 16 +++++++++++++---
 arch/x86/events/perf_event.h |  1 -
 3 files changed, 13 insertions(+), 5 deletions(-)

diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
index 18df171..dd9f3c2 100644
--- a/arch/x86/events/core.c
+++ b/arch/x86/events/core.c
@@ -1480,7 +1480,6 @@ static void x86_pmu_start(struct perf_event *event, int flags)
 
 	cpuc->events[idx] = event;
 	__set_bit(idx, cpuc->active_mask);
-	__set_bit(idx, cpuc->running);
 	static_call(x86_pmu_enable)(event);
 	perf_event_update_userpage(event);
 }
diff --git a/arch/x86/events/intel/p4.c b/arch/x86/events/intel/p4.c
index a4cc660..9c10cbb 100644
--- a/arch/x86/events/intel/p4.c
+++ b/arch/x86/events/intel/p4.c
@@ -947,7 +947,7 @@ static void p4_pmu_enable_pebs(u64 config)
 	(void)wrmsrl_safe(MSR_P4_PEBS_MATRIX_VERT,	(u64)bind->metric_vert);
 }
 
-static void p4_pmu_enable_event(struct perf_event *event)
+static void __p4_pmu_enable_event(struct perf_event *event)
 {
 	struct hw_perf_event *hwc = &event->hw;
 	int thread = p4_ht_config_thread(hwc->config);
@@ -983,6 +983,16 @@ static void p4_pmu_enable_event(struct perf_event *event)
 				(cccr & ~P4_CCCR_RESERVED) | P4_CCCR_ENABLE);
 }
 
+static DEFINE_PER_CPU(unsigned long [BITS_TO_LONGS(X86_PMC_IDX_MAX)], p4_running);
+
+static void p4_pmu_enable_event(struct perf_event *event)
+{
+	int idx = event->hw.idx;
+
+	__set_bit(idx, per_cpu(p4_running, smp_processor_id()));
+	__p4_pmu_enable_event(event);
+}
+
 static void p4_pmu_enable_all(int added)
 {
 	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
@@ -992,7 +1002,7 @@ static void p4_pmu_enable_all(int added)
 		struct perf_event *event = cpuc->events[idx];
 		if (!test_bit(idx, cpuc->active_mask))
 			continue;
-		p4_pmu_enable_event(event);
+		__p4_pmu_enable_event(event);
 	}
 }
 
@@ -1012,7 +1022,7 @@ static int p4_pmu_handle_irq(struct pt_regs *regs)
 
 		if (!test_bit(idx, cpuc->active_mask)) {
 			/* catch in-flight IRQs */
-			if (__test_and_clear_bit(idx, cpuc->running))
+			if (__test_and_clear_bit(idx, per_cpu(p4_running, smp_processor_id())))
 				handled++;
 			continue;
 		}
diff --git a/arch/x86/events/perf_event.h b/arch/x86/events/perf_event.h
index 53b2b5f..54a340e 100644
--- a/arch/x86/events/perf_event.h
+++ b/arch/x86/events/perf_event.h
@@ -228,7 +228,6 @@ struct cpu_hw_events {
 	 */
 	struct perf_event	*events[X86_PMC_IDX_MAX]; /* in counter order */
 	unsigned long		active_mask[BITS_TO_LONGS(X86_PMC_IDX_MAX)];
-	unsigned long		running[BITS_TO_LONGS(X86_PMC_IDX_MAX)];
 	int			enabled;
 
 	int			n_events; /* the # of events in the below arrays */
