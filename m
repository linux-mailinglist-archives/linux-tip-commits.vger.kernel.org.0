Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 416833E2AF8
	for <lists+linux-tip-commits@lfdr.de>; Fri,  6 Aug 2021 14:51:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236250AbhHFMvn (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 6 Aug 2021 08:51:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229604AbhHFMvn (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 6 Aug 2021 08:51:43 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94BCEC061798;
        Fri,  6 Aug 2021 05:51:27 -0700 (PDT)
Date:   Fri, 06 Aug 2021 12:51:24 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1628254286;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=x2fJw3SRKQ3YnDxmO+jjHfO86GMycdOIpUrD1oQCj5U=;
        b=lLdLBAjnHXAr59QdagVKzR2sSEAkuFrj+XH/rSSnlORG+ipS5tWdefyhMRgUiFBX02kca+
        jNfVnl7wUaEhpQ30HjZob4dv4mMbNmLLSTqqShociDACx0JrC+p9m2RIHBlsnkuODLvhQ5
        nF+DZNd/s7oXRayxSwuc1CNDQtvA1Rrb6joC2Q1oKzabRBC9Fbndr+ovlcz0stfzz+PCsX
        CMExlNjbGE17uK3n6nFjd0lN4rQdiKcG5lzHkRbWFdf/O0zZML+DcXkHaGtLvoH7JSaf3E
        UtAPJ+Np37dJLtuW8tfpD2toUeSmBmO/BjKjI0Wdd386tYeBcKncRnHzdDUkBw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1628254286;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=x2fJw3SRKQ3YnDxmO+jjHfO86GMycdOIpUrD1oQCj5U=;
        b=nuuu6CUNWAp7lulhKnLcCptxIf5WkK1/paeOmqMTbdT6nPFEOdnKKvjdObQSkmsRw7HFFo
        c+l7dQictkgv2hCA==
From:   "tip-bot2 for Kan Liang" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/urgent] perf/x86/intel: Apply mid ACK for small core
Cc:     Ammy Yi <ammy.yi@intel.com>, Kan Liang <kan.liang@linux.intel.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Andi Kleen <ak@linux.intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <1627997128-57891-1-git-send-email-kan.liang@linux.intel.com>
References: <1627997128-57891-1-git-send-email-kan.liang@linux.intel.com>
MIME-Version: 1.0
Message-ID: <162825428489.395.90520755660551249.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the perf/urgent branch of tip:

Commit-ID:     acade6379930dfa7987f4bd9b26d1a701cc1b542
Gitweb:        https://git.kernel.org/tip/acade6379930dfa7987f4bd9b26d1a701cc1b542
Author:        Kan Liang <kan.liang@linux.intel.com>
AuthorDate:    Tue, 03 Aug 2021 06:25:28 -07:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 06 Aug 2021 14:25:15 +02:00

perf/x86/intel: Apply mid ACK for small core

A warning as below may be occasionally triggered in an ADL machine when
these conditions occur:

 - Two perf record commands run one by one. Both record a PEBS event.
 - Both runs on small cores.
 - They have different adaptive PEBS configuration (PEBS_DATA_CFG).

  [ ] WARNING: CPU: 4 PID: 9874 at arch/x86/events/intel/ds.c:1743 setup_pebs_adaptive_sample_data+0x55e/0x5b0
  [ ] RIP: 0010:setup_pebs_adaptive_sample_data+0x55e/0x5b0
  [ ] Call Trace:
  [ ]  <NMI>
  [ ]  intel_pmu_drain_pebs_icl+0x48b/0x810
  [ ]  perf_event_nmi_handler+0x41/0x80
  [ ]  </NMI>
  [ ]  __perf_event_task_sched_in+0x2c2/0x3a0

Different from the big core, the small core requires the ACK right
before re-enabling counters in the NMI handler, otherwise a stale PEBS
record may be dumped into the later NMI handler, which trigger the
warning.

Add a new mid_ack flag to track the case. Add all PMI handler bits in
the struct x86_hybrid_pmu to track the bits for different types of
PMUs.  Apply mid ACK for the small cores on an Alder Lake machine.

The existing hybrid() macro has a compile error when taking address of
a bit-field variable. Add a new macro hybrid_bit() to get the
bit-field value of a given PMU.

Fixes: f83d2f91d259 ("perf/x86/intel: Add Alder Lake Hybrid support")
Reported-by: Ammy Yi <ammy.yi@intel.com>
Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Andi Kleen <ak@linux.intel.com>
Tested-by: Ammy Yi <ammy.yi@intel.com>
Link: https://lkml.kernel.org/r/1627997128-57891-1-git-send-email-kan.liang@linux.intel.com
---
 arch/x86/events/intel/core.c | 23 +++++++++++++++--------
 arch/x86/events/perf_event.h | 15 +++++++++++++++
 2 files changed, 30 insertions(+), 8 deletions(-)

diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index fca7a6e..ac6fd2d 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -2904,24 +2904,28 @@ static int handle_pmi_common(struct pt_regs *regs, u64 status)
  */
 static int intel_pmu_handle_irq(struct pt_regs *regs)
 {
-	struct cpu_hw_events *cpuc;
+	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
+	bool late_ack = hybrid_bit(cpuc->pmu, late_ack);
+	bool mid_ack = hybrid_bit(cpuc->pmu, mid_ack);
 	int loops;
 	u64 status;
 	int handled;
 	int pmu_enabled;
 
-	cpuc = this_cpu_ptr(&cpu_hw_events);
-
 	/*
 	 * Save the PMU state.
 	 * It needs to be restored when leaving the handler.
 	 */
 	pmu_enabled = cpuc->enabled;
 	/*
-	 * No known reason to not always do late ACK,
-	 * but just in case do it opt-in.
+	 * In general, the early ACK is only applied for old platforms.
+	 * For the big core starts from Haswell, the late ACK should be
+	 * applied.
+	 * For the small core after Tremont, we have to do the ACK right
+	 * before re-enabling counters, which is in the middle of the
+	 * NMI handler.
 	 */
-	if (!x86_pmu.late_ack)
+	if (!late_ack && !mid_ack)
 		apic_write(APIC_LVTPC, APIC_DM_NMI);
 	intel_bts_disable_local();
 	cpuc->enabled = 0;
@@ -2958,6 +2962,8 @@ again:
 		goto again;
 
 done:
+	if (mid_ack)
+		apic_write(APIC_LVTPC, APIC_DM_NMI);
 	/* Only restore PMU state when it's active. See x86_pmu_disable(). */
 	cpuc->enabled = pmu_enabled;
 	if (pmu_enabled)
@@ -2969,7 +2975,7 @@ done:
 	 * have been reset. This avoids spurious NMIs on
 	 * Haswell CPUs.
 	 */
-	if (x86_pmu.late_ack)
+	if (late_ack)
 		apic_write(APIC_LVTPC, APIC_DM_NMI);
 	return handled;
 }
@@ -6129,7 +6135,6 @@ __init int intel_pmu_init(void)
 		static_branch_enable(&perf_is_hybrid);
 		x86_pmu.num_hybrid_pmus = X86_HYBRID_NUM_PMUS;
 
-		x86_pmu.late_ack = true;
 		x86_pmu.pebs_aliases = NULL;
 		x86_pmu.pebs_prec_dist = true;
 		x86_pmu.pebs_block = true;
@@ -6167,6 +6172,7 @@ __init int intel_pmu_init(void)
 		pmu = &x86_pmu.hybrid_pmu[X86_HYBRID_PMU_CORE_IDX];
 		pmu->name = "cpu_core";
 		pmu->cpu_type = hybrid_big;
+		pmu->late_ack = true;
 		if (cpu_feature_enabled(X86_FEATURE_HYBRID_CPU)) {
 			pmu->num_counters = x86_pmu.num_counters + 2;
 			pmu->num_counters_fixed = x86_pmu.num_counters_fixed + 1;
@@ -6192,6 +6198,7 @@ __init int intel_pmu_init(void)
 		pmu = &x86_pmu.hybrid_pmu[X86_HYBRID_PMU_ATOM_IDX];
 		pmu->name = "cpu_atom";
 		pmu->cpu_type = hybrid_small;
+		pmu->mid_ack = true;
 		pmu->num_counters = x86_pmu.num_counters;
 		pmu->num_counters_fixed = x86_pmu.num_counters_fixed;
 		pmu->max_pebs_events = x86_pmu.max_pebs_events;
diff --git a/arch/x86/events/perf_event.h b/arch/x86/events/perf_event.h
index 2938c90..e3ac05c 100644
--- a/arch/x86/events/perf_event.h
+++ b/arch/x86/events/perf_event.h
@@ -656,6 +656,10 @@ struct x86_hybrid_pmu {
 	struct event_constraint		*event_constraints;
 	struct event_constraint		*pebs_constraints;
 	struct extra_reg		*extra_regs;
+
+	unsigned int			late_ack	:1,
+					mid_ack		:1,
+					enabled_ack	:1;
 };
 
 static __always_inline struct x86_hybrid_pmu *hybrid_pmu(struct pmu *pmu)
@@ -686,6 +690,16 @@ extern struct static_key_false perf_is_hybrid;
 	__Fp;						\
 }))
 
+#define hybrid_bit(_pmu, _field)			\
+({							\
+	bool __Fp = x86_pmu._field;			\
+							\
+	if (is_hybrid() && (_pmu))			\
+		__Fp = hybrid_pmu(_pmu)->_field;	\
+							\
+	__Fp;						\
+})
+
 enum hybrid_pmu_type {
 	hybrid_big		= 0x40,
 	hybrid_small		= 0x20,
@@ -755,6 +769,7 @@ struct x86_pmu {
 
 	/* PMI handler bits */
 	unsigned int	late_ack		:1,
+			mid_ack			:1,
 			enabled_ack		:1;
 	/*
 	 * sysfs attrs
