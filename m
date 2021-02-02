Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6C3330BD8C
	for <lists+linux-tip-commits@lfdr.de>; Tue,  2 Feb 2021 12:59:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230430AbhBBL6Q (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Tue, 2 Feb 2021 06:58:16 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:36156 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbhBBL5s (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Tue, 2 Feb 2021 06:57:48 -0500
Date:   Tue, 02 Feb 2021 11:57:03 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1612267024;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Qc1WtAnlI3l3O4xD8GBnlXUvp6PPz23xwRmCyLVWMuE=;
        b=gDi7tSoEJsytt+pSpr2KMaw4ZMY4yTksyeSxCAA3HZh9MTA7f7jlxiPzywdIrgYLLJXaYq
        0+BSj4UUgWcCguvLa2k15kxVJ9tXqB7od0EAPMPGGxD6g6Pw7vi1triCtHmFYJp+zHNRxo
        3XBqY3h8X+CgDL3Zm3QtCKuAtoxIoWC3G6U1XgSDfIMYjLLPnO45A78/0wgTJV6KNjXq9N
        Mvps5LSflUKPLrwg046EUjAAaiTmDJa1V2+HaOi8LSc8bY2Q/vvGKA4uTaymZ7AYa3nKdg
        zDnFttj5MhAawnh/yfMYxpUANYQ3QTrEHoBOiBz8lhjDLkosqpsmLIIn8oVCiQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1612267024;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Qc1WtAnlI3l3O4xD8GBnlXUvp6PPz23xwRmCyLVWMuE=;
        b=E9CPyWb6T9tO29XS4WAo4uuMgtzlpcJyYrXkdKBXPtjgWBp7F1laXMcInHdf68RMmWElUE
        //ntxgfEz+iKZSCA==
From:   "tip-bot2 for Kan Liang" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf/x86/intel: Support CPUID 10.ECX to disable
 fixed counters
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Andi Kleen <ak@linux.intel.com>,
        Kan Liang <kan.liang@linux.intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <1611873611-156687-6-git-send-email-kan.liang@linux.intel.com>
References: <1611873611-156687-6-git-send-email-kan.liang@linux.intel.com>
MIME-Version: 1.0
Message-ID: <161226702346.23325.5387584964216583611.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     32451614da2a9cf4296f90d3606ac77814fb519d
Gitweb:        https://git.kernel.org/tip/32451614da2a9cf4296f90d3606ac77814fb519d
Author:        Kan Liang <kan.liang@linux.intel.com>
AuthorDate:    Thu, 28 Jan 2021 14:40:11 -08:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 01 Feb 2021 15:31:37 +01:00

perf/x86/intel: Support CPUID 10.ECX to disable fixed counters

With Architectural Performance Monitoring Version 5, CPUID 10.ECX cpu
leaf indicates the fixed counter enumeration. This extends the previous
count to a bitmap which allows disabling even lower fixed counters.
It could be used by a Hypervisor.

The existing intel_ctrl variable is used to remember the bitmask of the
counters. All code that reads all counters is fixed to check this extra
bitmask.

Suggested-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Originally-by: Andi Kleen <ak@linux.intel.com>
Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/1611873611-156687-6-git-send-email-kan.liang@linux.intel.com
---
 arch/x86/events/core.c       |  8 +++++++-
 arch/x86/events/intel/core.c | 34 ++++++++++++++++++++++++----------
 arch/x86/events/perf_event.h |  5 +++++
 3 files changed, 36 insertions(+), 11 deletions(-)

diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
index cf0a52c..6ddeed3 100644
--- a/arch/x86/events/core.c
+++ b/arch/x86/events/core.c
@@ -255,6 +255,8 @@ static bool check_hw_exists(void)
 		if (ret)
 			goto msr_fail;
 		for (i = 0; i < x86_pmu.num_counters_fixed; i++) {
+			if (fixed_counter_disabled(i))
+				continue;
 			if (val & (0x03 << i*4)) {
 				bios_fail = 1;
 				val_fail = val;
@@ -1531,6 +1533,8 @@ void perf_event_print_debug(void)
 			cpu, idx, prev_left);
 	}
 	for (idx = 0; idx < x86_pmu.num_counters_fixed; idx++) {
+		if (fixed_counter_disabled(idx))
+			continue;
 		rdmsrl(MSR_ARCH_PERFMON_FIXED_CTR0 + idx, pmc_count);
 
 		pr_info("CPU#%d: fixed-PMC%d count: %016llx\n",
@@ -2012,7 +2016,9 @@ static int __init init_hw_perf_events(void)
 	pr_info("... generic registers:      %d\n",     x86_pmu.num_counters);
 	pr_info("... value mask:             %016Lx\n", x86_pmu.cntval_mask);
 	pr_info("... max period:             %016Lx\n", x86_pmu.max_period);
-	pr_info("... fixed-purpose events:   %d\n",     x86_pmu.num_counters_fixed);
+	pr_info("... fixed-purpose events:   %lu\n",
+			hweight64((((1ULL << x86_pmu.num_counters_fixed) - 1)
+					<< INTEL_PMC_IDX_FIXED) & x86_pmu.intel_ctrl));
 	pr_info("... event mask:             %016Lx\n", x86_pmu.intel_ctrl);
 
 	if (!x86_pmu.read)
diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index 58cd64e..67a7246 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -2723,8 +2723,11 @@ static void intel_pmu_reset(void)
 		wrmsrl_safe(x86_pmu_config_addr(idx), 0ull);
 		wrmsrl_safe(x86_pmu_event_addr(idx),  0ull);
 	}
-	for (idx = 0; idx < x86_pmu.num_counters_fixed; idx++)
+	for (idx = 0; idx < x86_pmu.num_counters_fixed; idx++) {
+		if (fixed_counter_disabled(idx))
+			continue;
 		wrmsrl_safe(MSR_ARCH_PERFMON_FIXED_CTR0 + idx, 0ull);
+	}
 
 	if (ds)
 		ds->bts_index = ds->bts_buffer_base;
@@ -5042,7 +5045,7 @@ __init int intel_pmu_init(void)
 	union cpuid10_eax eax;
 	union cpuid10_ebx ebx;
 	struct event_constraint *c;
-	unsigned int unused;
+	unsigned int fixed_mask;
 	struct extra_reg *er;
 	bool pmem = false;
 	int version, i;
@@ -5064,7 +5067,7 @@ __init int intel_pmu_init(void)
 	 * Check whether the Architectural PerfMon supports
 	 * Branch Misses Retired hw_event or not.
 	 */
-	cpuid(10, &eax.full, &ebx.full, &unused, &edx.full);
+	cpuid(10, &eax.full, &ebx.full, &fixed_mask, &edx.full);
 	if (eax.split.mask_length < ARCH_PERFMON_EVENTS_COUNT)
 		return -ENODEV;
 
@@ -5088,12 +5091,15 @@ __init int intel_pmu_init(void)
 	 * Quirk: v2 perfmon does not report fixed-purpose events, so
 	 * assume at least 3 events, when not running in a hypervisor:
 	 */
-	if (version > 1) {
+	if (version > 1 && version < 5) {
 		int assume = 3 * !boot_cpu_has(X86_FEATURE_HYPERVISOR);
 
 		x86_pmu.num_counters_fixed =
 			max((int)edx.split.num_counters_fixed, assume);
-	}
+
+		fixed_mask = (1L << x86_pmu.num_counters_fixed) - 1;
+	} else if (version >= 5)
+		x86_pmu.num_counters_fixed = fls(fixed_mask);
 
 	if (boot_cpu_has(X86_FEATURE_PDCM)) {
 		u64 capabilities;
@@ -5680,8 +5686,7 @@ __init int intel_pmu_init(void)
 		x86_pmu.num_counters_fixed = INTEL_PMC_MAX_FIXED;
 	}
 
-	x86_pmu.intel_ctrl |=
-		((1LL << x86_pmu.num_counters_fixed)-1) << INTEL_PMC_IDX_FIXED;
+	x86_pmu.intel_ctrl |= (u64)fixed_mask << INTEL_PMC_IDX_FIXED;
 
 	/* AnyThread may be deprecated on arch perfmon v5 or later */
 	if (x86_pmu.intel_cap.anythread_deprecated)
@@ -5698,13 +5703,22 @@ __init int intel_pmu_init(void)
 			 * events to the generic counters.
 			 */
 			if (c->idxmsk64 & INTEL_PMC_MSK_TOPDOWN) {
+				/*
+				 * Disable topdown slots and metrics events,
+				 * if slots event is not in CPUID.
+				 */
+				if (!(INTEL_PMC_MSK_FIXED_SLOTS & x86_pmu.intel_ctrl))
+					c->idxmsk64 = 0;
 				c->weight = hweight64(c->idxmsk64);
 				continue;
 			}
 
-			if (c->cmask == FIXED_EVENT_FLAGS
-			    && c->idxmsk64 != INTEL_PMC_MSK_FIXED_REF_CYCLES) {
-				c->idxmsk64 |= (1ULL << x86_pmu.num_counters) - 1;
+			if (c->cmask == FIXED_EVENT_FLAGS) {
+				/* Disabled fixed counters which are not in CPUID */
+				c->idxmsk64 &= x86_pmu.intel_ctrl;
+
+				if (c->idxmsk64 != INTEL_PMC_MSK_FIXED_REF_CYCLES)
+					c->idxmsk64 |= (1ULL << x86_pmu.num_counters) - 1;
 			}
 			c->idxmsk64 &=
 				~(~0ULL << (INTEL_PMC_IDX_FIXED + x86_pmu.num_counters_fixed));
diff --git a/arch/x86/events/perf_event.h b/arch/x86/events/perf_event.h
index b8bf2ce..53b2b5f 100644
--- a/arch/x86/events/perf_event.h
+++ b/arch/x86/events/perf_event.h
@@ -1068,6 +1068,11 @@ ssize_t events_sysfs_show(struct device *dev, struct device_attribute *attr,
 ssize_t events_ht_sysfs_show(struct device *dev, struct device_attribute *attr,
 			  char *page);
 
+static inline bool fixed_counter_disabled(int i)
+{
+	return !(x86_pmu.intel_ctrl >> (i + INTEL_PMC_IDX_FIXED));
+}
+
 #ifdef CONFIG_CPU_SUP_AMD
 
 int amd_pmu_init(void);
