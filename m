Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B8B99365693
	for <lists+linux-tip-commits@lfdr.de>; Tue, 20 Apr 2021 12:46:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231840AbhDTKrU (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Tue, 20 Apr 2021 06:47:20 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:51762 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231715AbhDTKrS (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Tue, 20 Apr 2021 06:47:18 -0400
Date:   Tue, 20 Apr 2021 10:46:45 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1618915606;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZjJLfvl4bd+ZEax6jEZndx1N4U6TPLSUSUzl/pBU/5s=;
        b=31bmbIzLY5kwIyy3JIDBqwSWkQAjgSTTaSi+FLM55UPy5giJDLG7dT4lNCpyBafM5HcI6j
        ZDD9VVCo4kvzPgm/NY0z9DfxfAOYE3d0gVZY9QFan2iUd5zo1UwPUdPs2gVWC/4aUDdCMw
        JkEip038eh1hV+VP2S8KNUF5tWn2iXVxw+MU88URtoF2boWFoWP/vWDxdbRHnXM+QSzDuO
        ZsRZRshmJFmzA1KMuXDjxRfbqRgTnw0fHOlpHrhuYi/qmhWhOedxcy9H9IiuNYDB6pnCWY
        9VlICmELbRKq6f/SPqZrfoV9HbMHLk+1TSpSw8rk7egbMU1+8aEluVXVb0Waaw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1618915606;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZjJLfvl4bd+ZEax6jEZndx1N4U6TPLSUSUzl/pBU/5s=;
        b=DE3dAeYjI8FQ/38ZJWLLcOty/NJikCRSrWbpFi6c6cQAz02E8ZtnjHlEKicBeo04iR8ThO
        JYjzE2mc8iSaTfBQ==
From:   "tip-bot2 for Kan Liang" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf/x86/intel: Factor out intel_pmu_check_event_constraints
Cc:     Kan Liang <kan.liang@linux.intel.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Andi Kleen <ak@linux.intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <1618237865-33448-13-git-send-email-kan.liang@linux.intel.com>
References: <1618237865-33448-13-git-send-email-kan.liang@linux.intel.com>
MIME-Version: 1.0
Message-ID: <161891560575.29796.1293300365585282083.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     bc14fe1beeec1d80ee39f03019c10e130c8d376b
Gitweb:        https://git.kernel.org/tip/bc14fe1beeec1d80ee39f03019c10e130c8d376b
Author:        Kan Liang <kan.liang@linux.intel.com>
AuthorDate:    Mon, 12 Apr 2021 07:30:52 -07:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 19 Apr 2021 20:03:26 +02:00

perf/x86/intel: Factor out intel_pmu_check_event_constraints

Each Hybrid PMU has to check and update its own event constraints before
registration.

The intel_pmu_check_event_constraints will be reused later to check
the event constraints of each hybrid PMU.

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Andi Kleen <ak@linux.intel.com>
Link: https://lkml.kernel.org/r/1618237865-33448-13-git-send-email-kan.liang@linux.intel.com
---
 arch/x86/events/intel/core.c | 82 ++++++++++++++++++++---------------
 1 file changed, 47 insertions(+), 35 deletions(-)

diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index d7e2021..5c5f330 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -5084,6 +5084,49 @@ static void intel_pmu_check_num_counters(int *num_counters,
 	*intel_ctrl |= fixed_mask << INTEL_PMC_IDX_FIXED;
 }
 
+static void intel_pmu_check_event_constraints(struct event_constraint *event_constraints,
+					      int num_counters,
+					      int num_counters_fixed,
+					      u64 intel_ctrl)
+{
+	struct event_constraint *c;
+
+	if (!event_constraints)
+		return;
+
+	/*
+	 * event on fixed counter2 (REF_CYCLES) only works on this
+	 * counter, so do not extend mask to generic counters
+	 */
+	for_each_event_constraint(c, event_constraints) {
+		/*
+		 * Don't extend the topdown slots and metrics
+		 * events to the generic counters.
+		 */
+		if (c->idxmsk64 & INTEL_PMC_MSK_TOPDOWN) {
+			/*
+			 * Disable topdown slots and metrics events,
+			 * if slots event is not in CPUID.
+			 */
+			if (!(INTEL_PMC_MSK_FIXED_SLOTS & intel_ctrl))
+				c->idxmsk64 = 0;
+			c->weight = hweight64(c->idxmsk64);
+			continue;
+		}
+
+		if (c->cmask == FIXED_EVENT_FLAGS) {
+			/* Disabled fixed counters which are not in CPUID */
+			c->idxmsk64 &= intel_ctrl;
+
+			if (c->idxmsk64 != INTEL_PMC_MSK_FIXED_REF_CYCLES)
+				c->idxmsk64 |= (1ULL << num_counters) - 1;
+		}
+		c->idxmsk64 &=
+			~(~0ULL << (INTEL_PMC_IDX_FIXED + num_counters_fixed));
+		c->weight = hweight64(c->idxmsk64);
+	}
+}
+
 __init int intel_pmu_init(void)
 {
 	struct attribute **extra_skl_attr = &empty_attrs;
@@ -5094,7 +5137,6 @@ __init int intel_pmu_init(void)
 	union cpuid10_edx edx;
 	union cpuid10_eax eax;
 	union cpuid10_ebx ebx;
-	struct event_constraint *c;
 	unsigned int fixed_mask;
 	struct extra_reg *er;
 	bool pmem = false;
@@ -5732,40 +5774,10 @@ __init int intel_pmu_init(void)
 	if (x86_pmu.intel_cap.anythread_deprecated)
 		x86_pmu.format_attrs = intel_arch_formats_attr;
 
-	if (x86_pmu.event_constraints) {
-		/*
-		 * event on fixed counter2 (REF_CYCLES) only works on this
-		 * counter, so do not extend mask to generic counters
-		 */
-		for_each_event_constraint(c, x86_pmu.event_constraints) {
-			/*
-			 * Don't extend the topdown slots and metrics
-			 * events to the generic counters.
-			 */
-			if (c->idxmsk64 & INTEL_PMC_MSK_TOPDOWN) {
-				/*
-				 * Disable topdown slots and metrics events,
-				 * if slots event is not in CPUID.
-				 */
-				if (!(INTEL_PMC_MSK_FIXED_SLOTS & x86_pmu.intel_ctrl))
-					c->idxmsk64 = 0;
-				c->weight = hweight64(c->idxmsk64);
-				continue;
-			}
-
-			if (c->cmask == FIXED_EVENT_FLAGS) {
-				/* Disabled fixed counters which are not in CPUID */
-				c->idxmsk64 &= x86_pmu.intel_ctrl;
-
-				if (c->idxmsk64 != INTEL_PMC_MSK_FIXED_REF_CYCLES)
-					c->idxmsk64 |= (1ULL << x86_pmu.num_counters) - 1;
-			}
-			c->idxmsk64 &=
-				~(~0ULL << (INTEL_PMC_IDX_FIXED + x86_pmu.num_counters_fixed));
-			c->weight = hweight64(c->idxmsk64);
-		}
-	}
-
+	intel_pmu_check_event_constraints(x86_pmu.event_constraints,
+					  x86_pmu.num_counters,
+					  x86_pmu.num_counters_fixed,
+					  x86_pmu.intel_ctrl);
 	/*
 	 * Access LBR MSR may cause #GP under certain circumstances.
 	 * E.g. KVM doesn't support LBR MSR
