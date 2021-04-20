Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 726AB36569E
	for <lists+linux-tip-commits@lfdr.de>; Tue, 20 Apr 2021 12:49:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231944AbhDTKrZ (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Tue, 20 Apr 2021 06:47:25 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:51762 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231749AbhDTKrU (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Tue, 20 Apr 2021 06:47:20 -0400
Date:   Tue, 20 Apr 2021 10:46:48 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1618915609;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qeFq6BpYRw5hAMLaSJye7Oxv/nnefAR/8+G5p+kOoUE=;
        b=JuAKYZkc8tYgRQ/j7xFJTHcyM2csSRp4XRK141P5jOVO2jw7bcDTDzrJvwryeGVh6mW3KT
        K6s1G04AdLxxB19Dks1uh1UjhAkFracGWZYD4+X0eAIKpNvtC5SQV0KCsoQ387bTtLI8je
        L144VJ/KaaL8yKDzP6LZWKG1h4EdXHallf+2sXVF6siqFO0bzRJCSjZgMk32qKFGv/0krD
        PTc5HiR0SkXdtOs514SeprIsObunZ/a5VSIBjrAaWkxlP6J0P3+pTceotaQm2fyfCgf5S8
        lhCH1dlwrfwXkbOr9MH7nEP+waEsu49DidWmkDnuOHwZXYgZT1kzq8nMi71N5Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1618915609;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qeFq6BpYRw5hAMLaSJye7Oxv/nnefAR/8+G5p+kOoUE=;
        b=5rvoJ/3Z7/XpeQkn3RSja3EjNeII4CpczObv4RyDCMrkCONMJJBQdRDbImfU/vCcC57mS1
        W3Z3DQOEhdhogRDA==
From:   "tip-bot2 for Kan Liang" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf/x86: Hybrid PMU support for intel_ctrl
Cc:     Kan Liang <kan.liang@linux.intel.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Andi Kleen <ak@linux.intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <1618237865-33448-6-git-send-email-kan.liang@linux.intel.com>
References: <1618237865-33448-6-git-send-email-kan.liang@linux.intel.com>
MIME-Version: 1.0
Message-ID: <161891560842.29796.13328333129625623226.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     fc4b8fca2d8fc8aecd58508e81d55afe4ed76344
Gitweb:        https://git.kernel.org/tip/fc4b8fca2d8fc8aecd58508e81d55afe4ed76344
Author:        Kan Liang <kan.liang@linux.intel.com>
AuthorDate:    Mon, 12 Apr 2021 07:30:45 -07:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 19 Apr 2021 20:03:24 +02:00

perf/x86: Hybrid PMU support for intel_ctrl

The intel_ctrl is the counter mask of a PMU. The PMU counter information
may be different among hybrid PMUs, each hybrid PMU should use its own
intel_ctrl to check and access the counters.

When handling a certain hybrid PMU, apply the intel_ctrl from the
corresponding hybrid PMU.

When checking the HW existence, apply the PMU and number of counters
from the corresponding hybrid PMU as well. Perf will check the HW
existence for each Hybrid PMU before registration. Expose the
check_hw_exists() for a later patch.

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Andi Kleen <ak@linux.intel.com>
Link: https://lkml.kernel.org/r/1618237865-33448-6-git-send-email-kan.liang@linux.intel.com
---
 arch/x86/events/core.c       | 14 +++++++-------
 arch/x86/events/intel/core.c | 14 +++++++++-----
 arch/x86/events/perf_event.h | 10 ++++++++--
 3 files changed, 24 insertions(+), 14 deletions(-)

diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
index 7fc2001..7d3c19e 100644
--- a/arch/x86/events/core.c
+++ b/arch/x86/events/core.c
@@ -231,7 +231,7 @@ static void release_pmc_hardware(void) {}
 
 #endif
 
-static bool check_hw_exists(void)
+bool check_hw_exists(struct pmu *pmu, int num_counters, int num_counters_fixed)
 {
 	u64 val, val_fail = -1, val_new= ~0;
 	int i, reg, reg_fail = -1, ret = 0;
@@ -242,7 +242,7 @@ static bool check_hw_exists(void)
 	 * Check to see if the BIOS enabled any of the counters, if so
 	 * complain and bail.
 	 */
-	for (i = 0; i < x86_pmu.num_counters; i++) {
+	for (i = 0; i < num_counters; i++) {
 		reg = x86_pmu_config_addr(i);
 		ret = rdmsrl_safe(reg, &val);
 		if (ret)
@@ -256,13 +256,13 @@ static bool check_hw_exists(void)
 		}
 	}
 
-	if (x86_pmu.num_counters_fixed) {
+	if (num_counters_fixed) {
 		reg = MSR_ARCH_PERFMON_FIXED_CTR_CTRL;
 		ret = rdmsrl_safe(reg, &val);
 		if (ret)
 			goto msr_fail;
-		for (i = 0; i < x86_pmu.num_counters_fixed; i++) {
-			if (fixed_counter_disabled(i))
+		for (i = 0; i < num_counters_fixed; i++) {
+			if (fixed_counter_disabled(i, pmu))
 				continue;
 			if (val & (0x03 << i*4)) {
 				bios_fail = 1;
@@ -1547,7 +1547,7 @@ void perf_event_print_debug(void)
 			cpu, idx, prev_left);
 	}
 	for (idx = 0; idx < x86_pmu.num_counters_fixed; idx++) {
-		if (fixed_counter_disabled(idx))
+		if (fixed_counter_disabled(idx, cpuc->pmu))
 			continue;
 		rdmsrl(MSR_ARCH_PERFMON_FIXED_CTR0 + idx, pmc_count);
 
@@ -1992,7 +1992,7 @@ static int __init init_hw_perf_events(void)
 	pmu_check_apic();
 
 	/* sanity check that the hardware exists or is emulated */
-	if (!check_hw_exists())
+	if (!check_hw_exists(&pmu, x86_pmu.num_counters, x86_pmu.num_counters_fixed))
 		return 0;
 
 	pr_cont("%s PMU driver.\n", x86_pmu.name);
diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index dc9e2fb..2d56055 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -2153,10 +2153,11 @@ static void intel_pmu_disable_all(void)
 static void __intel_pmu_enable_all(int added, bool pmi)
 {
 	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
+	u64 intel_ctrl = hybrid(cpuc->pmu, intel_ctrl);
 
 	intel_pmu_lbr_enable_all(pmi);
 	wrmsrl(MSR_CORE_PERF_GLOBAL_CTRL,
-			x86_pmu.intel_ctrl & ~cpuc->intel_ctrl_guest_mask);
+	       intel_ctrl & ~cpuc->intel_ctrl_guest_mask);
 
 	if (test_bit(INTEL_PMC_IDX_FIXED_BTS, cpuc->active_mask)) {
 		struct perf_event *event =
@@ -2709,6 +2710,7 @@ int intel_pmu_save_and_restart(struct perf_event *event)
 static void intel_pmu_reset(void)
 {
 	struct debug_store *ds = __this_cpu_read(cpu_hw_events.ds);
+	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
 	unsigned long flags;
 	int idx;
 
@@ -2724,7 +2726,7 @@ static void intel_pmu_reset(void)
 		wrmsrl_safe(x86_pmu_event_addr(idx),  0ull);
 	}
 	for (idx = 0; idx < x86_pmu.num_counters_fixed; idx++) {
-		if (fixed_counter_disabled(idx))
+		if (fixed_counter_disabled(idx, cpuc->pmu))
 			continue;
 		wrmsrl_safe(MSR_ARCH_PERFMON_FIXED_CTR0 + idx, 0ull);
 	}
@@ -2753,6 +2755,7 @@ static int handle_pmi_common(struct pt_regs *regs, u64 status)
 	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
 	int bit;
 	int handled = 0;
+	u64 intel_ctrl = hybrid(cpuc->pmu, intel_ctrl);
 
 	inc_irq_stat(apic_perf_irqs);
 
@@ -2798,7 +2801,7 @@ static int handle_pmi_common(struct pt_regs *regs, u64 status)
 
 		handled++;
 		x86_pmu.drain_pebs(regs, &data);
-		status &= x86_pmu.intel_ctrl | GLOBAL_STATUS_TRACE_TOPAPMI;
+		status &= intel_ctrl | GLOBAL_STATUS_TRACE_TOPAPMI;
 
 		/*
 		 * PMI throttle may be triggered, which stops the PEBS event.
@@ -3804,10 +3807,11 @@ static struct perf_guest_switch_msr *intel_guest_get_msrs(int *nr)
 {
 	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
 	struct perf_guest_switch_msr *arr = cpuc->guest_switch_msrs;
+	u64 intel_ctrl = hybrid(cpuc->pmu, intel_ctrl);
 
 	arr[0].msr = MSR_CORE_PERF_GLOBAL_CTRL;
-	arr[0].host = x86_pmu.intel_ctrl & ~cpuc->intel_ctrl_guest_mask;
-	arr[0].guest = x86_pmu.intel_ctrl & ~cpuc->intel_ctrl_host_mask;
+	arr[0].host = intel_ctrl & ~cpuc->intel_ctrl_guest_mask;
+	arr[0].guest = intel_ctrl & ~cpuc->intel_ctrl_host_mask;
 	if (x86_pmu.flags & PMU_FL_PEBS_ALL)
 		arr[0].guest &= ~cpuc->pebs_enabled;
 	else
diff --git a/arch/x86/events/perf_event.h b/arch/x86/events/perf_event.h
index 85910e2..557c674 100644
--- a/arch/x86/events/perf_event.h
+++ b/arch/x86/events/perf_event.h
@@ -634,6 +634,7 @@ enum {
 struct x86_hybrid_pmu {
 	struct pmu			pmu;
 	union perf_capabilities		intel_cap;
+	u64				intel_ctrl;
 };
 
 static __always_inline struct x86_hybrid_pmu *hybrid_pmu(struct pmu *pmu)
@@ -998,6 +999,9 @@ static inline int x86_pmu_rdpmc_index(int index)
 	return x86_pmu.rdpmc_index ? x86_pmu.rdpmc_index(index) : index;
 }
 
+bool check_hw_exists(struct pmu *pmu, int num_counters,
+		     int num_counters_fixed);
+
 int x86_add_exclusive(unsigned int what);
 
 void x86_del_exclusive(unsigned int what);
@@ -1102,9 +1106,11 @@ ssize_t events_sysfs_show(struct device *dev, struct device_attribute *attr,
 ssize_t events_ht_sysfs_show(struct device *dev, struct device_attribute *attr,
 			  char *page);
 
-static inline bool fixed_counter_disabled(int i)
+static inline bool fixed_counter_disabled(int i, struct pmu *pmu)
 {
-	return !(x86_pmu.intel_ctrl >> (i + INTEL_PMC_IDX_FIXED));
+	u64 intel_ctrl = hybrid(pmu, intel_ctrl);
+
+	return !(intel_ctrl >> (i + INTEL_PMC_IDX_FIXED));
 }
 
 #ifdef CONFIG_CPU_SUP_AMD
