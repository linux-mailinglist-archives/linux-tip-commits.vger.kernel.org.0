Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E6A530BD88
	for <lists+linux-tip-commits@lfdr.de>; Tue,  2 Feb 2021 12:59:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229631AbhBBL6B (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Tue, 2 Feb 2021 06:58:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230091AbhBBL5q (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Tue, 2 Feb 2021 06:57:46 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 686FAC0613D6;
        Tue,  2 Feb 2021 03:57:06 -0800 (PST)
Date:   Tue, 02 Feb 2021 11:57:04 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1612267024;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pyYbw7qwO504szOI1StzKcIxOn6HL+YVYSKnlsB/ohQ=;
        b=wVAcbUrFJWyqq9Pu8Ax56/AXhdqtWZDxv5mvwxZ8lyXcAlydAjN+Z/2xnxeV1GcqNkAgEH
        KXuCaoiG2A5uyFF3VCckF+ttwy7MRo0zfB7zgikruVsautk9eCITv2WJKxy2PaaxgUXU77
        Zf7KpwK5G27fAzHT83QKgIztUgptlf5tDspGCTcMqJKAQGZRd+n/PmUSeiUcDTasdor/90
        yQSuzPGR6+Ge4KDbOVEEfeD60Mi7Ch2gcnjok5Hh1EANpACQW620VbPoWrSepU/j0FfGHy
        mK0Q8pPZfU18DWQ4GWmb6zMy+ijT6Zi1uT82ecqWY3ieacf9JXtowjVeZX+Ipg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1612267024;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pyYbw7qwO504szOI1StzKcIxOn6HL+YVYSKnlsB/ohQ=;
        b=EcqgT8wfKRw+IRIqqlMYrXSTx3FovtIezSUsglqFqcRhbp06a0O7MIXmXEfgKl+IPsCT+T
        egIQWetvMJcaSsCg==
From:   "tip-bot2 for Kan Liang" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf/x86/intel: Factor out intel_update_topdown_event()
Cc:     Kan Liang <kan.liang@linux.intel.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <1611873611-156687-3-git-send-email-kan.liang@linux.intel.com>
References: <1611873611-156687-3-git-send-email-kan.liang@linux.intel.com>
MIME-Version: 1.0
Message-ID: <161226702426.23325.16073275084016150300.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     628d923a3c464db98c1c98bb1e0cd50804caf681
Gitweb:        https://git.kernel.org/tip/628d923a3c464db98c1c98bb1e0cd50804caf681
Author:        Kan Liang <kan.liang@linux.intel.com>
AuthorDate:    Thu, 28 Jan 2021 14:40:08 -08:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 01 Feb 2021 15:31:36 +01:00

perf/x86/intel: Factor out intel_update_topdown_event()

Similar to Ice Lake, Intel Sapphire Rapids server also supports the
topdown performance metrics feature. The difference is that Intel
Sapphire Rapids server extends the PERF_METRICS MSR to feature TMA
method level two metrics, which will introduce 8 metrics events. Current
icl_update_topdown_event() only check 4 level one metrics events.

Factor out intel_update_topdown_event() to facilitate the code sharing
between Ice Lake and Sapphire Rapids.

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/1611873611-156687-3-git-send-email-kan.liang@linux.intel.com
---
 arch/x86/events/intel/core.c | 20 +++++++++++++-------
 1 file changed, 13 insertions(+), 7 deletions(-)

diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index fe94008..d07408d 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -2325,8 +2325,8 @@ static void __icl_update_topdown_event(struct perf_event *event,
 	}
 }
 
-static void update_saved_topdown_regs(struct perf_event *event,
-				      u64 slots, u64 metrics)
+static void update_saved_topdown_regs(struct perf_event *event, u64 slots,
+				      u64 metrics, int metric_end)
 {
 	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
 	struct perf_event *other;
@@ -2335,7 +2335,7 @@ static void update_saved_topdown_regs(struct perf_event *event,
 	event->hw.saved_slots = slots;
 	event->hw.saved_metric = metrics;
 
-	for_each_set_bit(idx, cpuc->active_mask, INTEL_PMC_IDX_TD_BE_BOUND + 1) {
+	for_each_set_bit(idx, cpuc->active_mask, metric_end + 1) {
 		if (!is_topdown_idx(idx))
 			continue;
 		other = cpuc->events[idx];
@@ -2350,7 +2350,8 @@ static void update_saved_topdown_regs(struct perf_event *event,
  * The PERF_METRICS and Fixed counter 3 are read separately. The values may be
  * modify by a NMI. PMU has to be disabled before calling this function.
  */
-static u64 icl_update_topdown_event(struct perf_event *event)
+
+static u64 intel_update_topdown_event(struct perf_event *event, int metric_end)
 {
 	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
 	struct perf_event *other;
@@ -2366,7 +2367,7 @@ static u64 icl_update_topdown_event(struct perf_event *event)
 	/* read PERF_METRICS */
 	rdpmcl(INTEL_PMC_FIXED_RDPMC_METRICS, metrics);
 
-	for_each_set_bit(idx, cpuc->active_mask, INTEL_PMC_IDX_TD_BE_BOUND + 1) {
+	for_each_set_bit(idx, cpuc->active_mask, metric_end + 1) {
 		if (!is_topdown_idx(idx))
 			continue;
 		other = cpuc->events[idx];
@@ -2392,7 +2393,7 @@ static u64 icl_update_topdown_event(struct perf_event *event)
 		 * Don't need to reset the PERF_METRICS and Fixed counter 3.
 		 * Because the values will be restored in next schedule in.
 		 */
-		update_saved_topdown_regs(event, slots, metrics);
+		update_saved_topdown_regs(event, slots, metrics, metric_end);
 		reset = false;
 	}
 
@@ -2401,12 +2402,17 @@ static u64 icl_update_topdown_event(struct perf_event *event)
 		wrmsrl(MSR_CORE_PERF_FIXED_CTR3, 0);
 		wrmsrl(MSR_PERF_METRICS, 0);
 		if (event)
-			update_saved_topdown_regs(event, 0, 0);
+			update_saved_topdown_regs(event, 0, 0, metric_end);
 	}
 
 	return slots;
 }
 
+static u64 icl_update_topdown_event(struct perf_event *event)
+{
+	return intel_update_topdown_event(event, INTEL_PMC_IDX_TD_BE_BOUND);
+}
+
 static void intel_pmu_read_topdown_event(struct perf_event *event)
 {
 	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
