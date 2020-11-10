Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E37912AD69D
	for <lists+linux-tip-commits@lfdr.de>; Tue, 10 Nov 2020 13:45:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730515AbgKJMpZ (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Tue, 10 Nov 2020 07:45:25 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:58224 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730407AbgKJMpY (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Tue, 10 Nov 2020 07:45:24 -0500
Date:   Tue, 10 Nov 2020 12:45:22 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1605012323;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pmC0LARWDuuEAskVgbEYIBv2z3Ue8FsMLFtVsEIlgC0=;
        b=2Fvj7M1NUvI2sb/QN4tCOWjzEZa2+HQ0M9UrvXzA9cbuooYFKscDWcmGKFuHHTGj+/3ecH
        Iz68XzVAcMxHHnRvUV2NqGAA1+OTs/kEmwgKKU7xVQTu4ItZVh0jXRbNfyMOkuFm5sp6Vq
        tc+HAc3Dghm1lO8N1i6//sqz0ivO8aULphiPaCKyzWrIXN6eHhedbbYRJAmteD9w7ZC10A
        jXQ8SFllOBlS7WQ6+WBV0IH5zqPRxMjz0gBfmjTxGNVhTiBAin26vSDPPaOsDeB2xxJFEz
        Ei6gdNZvx3Zkhu2A1KVVkvUCDEDPuwJ6YVjluiOSdkS3mtafZkzlSP8BZL8EDg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1605012323;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pmC0LARWDuuEAskVgbEYIBv2z3Ue8FsMLFtVsEIlgC0=;
        b=cHxpp5nAxSR5DAADDSpqBXhi5EvsKZBxSm6cwlIttB9IrAad+HYjr1T5rG4/ivAVLcer46
        nDPt8alztj1ajlAQ==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/urgent] perf/x86: Reduce stack usage for x86_pmu::drain_pebs()
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20201030151955.054099690@infradead.org>
References: <20201030151955.054099690@infradead.org>
MIME-Version: 1.0
Message-ID: <160501232236.11244.7733226309119986075.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the perf/urgent branch of tip:

Commit-ID:     9dfa9a5c9bae3417b87824e7ac73b00c10b6a874
Gitweb:        https://git.kernel.org/tip/9dfa9a5c9bae3417b87824e7ac73b00c10b6a874
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Fri, 30 Oct 2020 14:58:48 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 09 Nov 2020 18:12:33 +01:00

perf/x86: Reduce stack usage for x86_pmu::drain_pebs()

intel_pmu_drain_pebs_*() is typically called from handle_pmi_common(),
both have an on-stack struct perf_sample_data, which is *big*. Rewire
things so that drain_pebs() can use the one handle_pmi_common() has.

Reported-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20201030151955.054099690@infradead.org
---
 arch/x86/events/intel/core.c |  2 +-
 arch/x86/events/intel/ds.c   | 47 ++++++++++++++++++-----------------
 arch/x86/events/perf_event.h |  2 +-
 3 files changed, 27 insertions(+), 24 deletions(-)

diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index f1926e9..c37387c 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -2630,7 +2630,7 @@ static int handle_pmi_common(struct pt_regs *regs, u64 status)
 		u64 pebs_enabled = cpuc->pebs_enabled;
 
 		handled++;
-		x86_pmu.drain_pebs(regs);
+		x86_pmu.drain_pebs(regs, &data);
 		status &= x86_pmu.intel_ctrl | GLOBAL_STATUS_TRACE_TOPAPMI;
 
 		/*
diff --git a/arch/x86/events/intel/ds.c b/arch/x86/events/intel/ds.c
index cd2ae14..276b29d 100644
--- a/arch/x86/events/intel/ds.c
+++ b/arch/x86/events/intel/ds.c
@@ -670,7 +670,9 @@ unlock:
 
 static inline void intel_pmu_drain_pebs_buffer(void)
 {
-	x86_pmu.drain_pebs(NULL);
+	struct perf_sample_data data;
+
+	x86_pmu.drain_pebs(NULL, &data);
 }
 
 /*
@@ -1719,19 +1721,20 @@ intel_pmu_save_and_restart_reload(struct perf_event *event, int count)
 	return 0;
 }
 
-static void __intel_pmu_pebs_event(struct perf_event *event,
-				   struct pt_regs *iregs,
-				   void *base, void *top,
-				   int bit, int count,
-				   void (*setup_sample)(struct perf_event *,
-						struct pt_regs *,
-						void *,
-						struct perf_sample_data *,
-						struct pt_regs *))
+static __always_inline void
+__intel_pmu_pebs_event(struct perf_event *event,
+		       struct pt_regs *iregs,
+		       struct perf_sample_data *data,
+		       void *base, void *top,
+		       int bit, int count,
+		       void (*setup_sample)(struct perf_event *,
+					    struct pt_regs *,
+					    void *,
+					    struct perf_sample_data *,
+					    struct pt_regs *))
 {
 	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
 	struct hw_perf_event *hwc = &event->hw;
-	struct perf_sample_data data;
 	struct x86_perf_regs perf_regs;
 	struct pt_regs *regs = &perf_regs.regs;
 	void *at = get_next_pebs_record_by_bit(base, top, bit);
@@ -1752,14 +1755,14 @@ static void __intel_pmu_pebs_event(struct perf_event *event,
 		iregs = &dummy_iregs;
 
 	while (count > 1) {
-		setup_sample(event, iregs, at, &data, regs);
-		perf_event_output(event, &data, regs);
+		setup_sample(event, iregs, at, data, regs);
+		perf_event_output(event, data, regs);
 		at += cpuc->pebs_record_size;
 		at = get_next_pebs_record_by_bit(at, top, bit);
 		count--;
 	}
 
-	setup_sample(event, iregs, at, &data, regs);
+	setup_sample(event, iregs, at, data, regs);
 	if (iregs == &dummy_iregs) {
 		/*
 		 * The PEBS records may be drained in the non-overflow context,
@@ -1767,18 +1770,18 @@ static void __intel_pmu_pebs_event(struct perf_event *event,
 		 * last record the same as other PEBS records, and doesn't
 		 * invoke the generic overflow handler.
 		 */
-		perf_event_output(event, &data, regs);
+		perf_event_output(event, data, regs);
 	} else {
 		/*
 		 * All but the last records are processed.
 		 * The last one is left to be able to call the overflow handler.
 		 */
-		if (perf_event_overflow(event, &data, regs))
+		if (perf_event_overflow(event, data, regs))
 			x86_pmu_stop(event, 0);
 	}
 }
 
-static void intel_pmu_drain_pebs_core(struct pt_regs *iregs)
+static void intel_pmu_drain_pebs_core(struct pt_regs *iregs, struct perf_sample_data *data)
 {
 	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
 	struct debug_store *ds = cpuc->ds;
@@ -1812,7 +1815,7 @@ static void intel_pmu_drain_pebs_core(struct pt_regs *iregs)
 		return;
 	}
 
-	__intel_pmu_pebs_event(event, iregs, at, top, 0, n,
+	__intel_pmu_pebs_event(event, iregs, data, at, top, 0, n,
 			       setup_pebs_fixed_sample_data);
 }
 
@@ -1835,7 +1838,7 @@ static void intel_pmu_pebs_event_update_no_drain(struct cpu_hw_events *cpuc, int
 	}
 }
 
-static void intel_pmu_drain_pebs_nhm(struct pt_regs *iregs)
+static void intel_pmu_drain_pebs_nhm(struct pt_regs *iregs, struct perf_sample_data *data)
 {
 	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
 	struct debug_store *ds = cpuc->ds;
@@ -1942,14 +1945,14 @@ static void intel_pmu_drain_pebs_nhm(struct pt_regs *iregs)
 		}
 
 		if (counts[bit]) {
-			__intel_pmu_pebs_event(event, iregs, base,
+			__intel_pmu_pebs_event(event, iregs, data, base,
 					       top, bit, counts[bit],
 					       setup_pebs_fixed_sample_data);
 		}
 	}
 }
 
-static void intel_pmu_drain_pebs_icl(struct pt_regs *iregs)
+static void intel_pmu_drain_pebs_icl(struct pt_regs *iregs, struct perf_sample_data *data)
 {
 	short counts[INTEL_PMC_IDX_FIXED + MAX_FIXED_PEBS_EVENTS] = {};
 	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
@@ -1997,7 +2000,7 @@ static void intel_pmu_drain_pebs_icl(struct pt_regs *iregs)
 		if (WARN_ON_ONCE(!event->attr.precise_ip))
 			continue;
 
-		__intel_pmu_pebs_event(event, iregs, base,
+		__intel_pmu_pebs_event(event, iregs, data, base,
 				       top, bit, counts[bit],
 				       setup_pebs_adaptive_sample_data);
 	}
diff --git a/arch/x86/events/perf_event.h b/arch/x86/events/perf_event.h
index ee2b9b9..1d1fe46 100644
--- a/arch/x86/events/perf_event.h
+++ b/arch/x86/events/perf_event.h
@@ -727,7 +727,7 @@ struct x86_pmu {
 	int		pebs_record_size;
 	int		pebs_buffer_size;
 	int		max_pebs_events;
-	void		(*drain_pebs)(struct pt_regs *regs);
+	void		(*drain_pebs)(struct pt_regs *regs, struct perf_sample_data *data);
 	struct event_constraint *pebs_constraints;
 	void		(*pebs_aliases)(struct perf_event *event);
 	unsigned long	large_pebs_flags;
