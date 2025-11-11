Return-Path: <linux-tip-commits+bounces-7286-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DE33C4D715
	for <lists+linux-tip-commits@lfdr.de>; Tue, 11 Nov 2025 12:41:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 657B54F7FB1
	for <lists+linux-tip-commits@lfdr.de>; Tue, 11 Nov 2025 11:37:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2F613570A0;
	Tue, 11 Nov 2025 11:37:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="CRS7UcwQ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="YuCODJmu"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0788357A30;
	Tue, 11 Nov 2025 11:37:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762861026; cv=none; b=jiFZDmQYuu1vlCzA+IMgVYQt01ggzrbSYJAZhf2auj8ESNIa3YkTQtrH2vkIXEF88mfsqyZqkI6zvNfaUOCrVig8joB9UHFZHilFr3lITMlHUM4LMu27EK/YFKcm3sJpjXEH5v7pm7igXwbi0GOdRIduVEuzcQQP6Q2gg0K0g3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762861026; c=relaxed/simple;
	bh=rCd8D/EBvcsgffFPsYPCMJwzvVsP3YcbthihJwsoRNQ=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=VjauYAfvCAPaOPRdWg4Im5xcFH+z8XFjJ2VwdG+AsFSejtvEPUcbpH+G/aZPJDnxDksf87zacb8z3M98Ewqfye5my7zvaKfvvcGwRWcm+p6Sf6aIveyqBdZ7zplUNJcngEg3uu56826DrJYNAs2q4jRyh2sipGcxfS82Z0tOkG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=CRS7UcwQ; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=YuCODJmu; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 11 Nov 2025 11:37:01 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1762861022;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4wQNwzLIVi+qqQTfkfGsrH3khVDqSPgMMDDNCI/7p2Q=;
	b=CRS7UcwQWVJp3MMcO6zFsSnubIkkirue2Vfi+0ETSRruDNuhweJwfD6ASH4NhDswgmq6Mt
	ued3VpEwsBMQHXr1W+pZIZbF/a6DySoUac6Gmhpf1lsE6UMvv+F/IK7s9RXCDbeu230i0G
	+FWfJnLMBKyo6G52iZObkXagiPEea9ep49aqnCYHKP6/BEtj7/Faokw5xhM65hjaFRY363
	SGEfixkNjYdN3g9nkF9ckqGLIHP+3QdI61HWpvPti1I2ucgy8gAVCjw/Dgt83p3bpLONPS
	HTIy5kDl0nxW5eZ9M1Ahal8FVPLWJ8TiiGqVf6UZGdTi+2U4PbG9kTl4iwQjJg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1762861022;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4wQNwzLIVi+qqQTfkfGsrH3khVDqSPgMMDDNCI/7p2Q=;
	b=YuCODJmuxTbUGIrTOemrI9zIKKLOBUWzR6wIcH1qocf4OI/SLih0aV8Fc34MsmsXXS2+ZK
	luSLqo8emqe6gvAg==
From: "tip-bot2 for Dapeng Mi" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf/x86/intel: Setup PEBS data configuration and
 enable legacy groups
Cc: Kan Liang <kan.liang@linux.intel.com>,
 Dapeng Mi <dapeng1.mi@linux.intel.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20251029102136.61364-12-dapeng1.mi@linux.intel.com>
References: <20251029102136.61364-12-dapeng1.mi@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176286102128.498.7244295198602088939.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     52448a0a739002eca3d051a6ec314a0b178949a1
Gitweb:        https://git.kernel.org/tip/52448a0a739002eca3d051a6ec314a0b178=
949a1
Author:        Dapeng Mi <dapeng1.mi@linux.intel.com>
AuthorDate:    Wed, 29 Oct 2025 18:21:35 +08:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 07 Nov 2025 15:08:22 +01:00

perf/x86/intel: Setup PEBS data configuration and enable legacy groups

Different with legacy PEBS, arch-PEBS provides per-counter PEBS data
configuration by programing MSR IA32_PMC_GPx/FXx_CFG_C MSRs.

This patch obtains PEBS data configuration from event attribute and then
writes the PEBS data configuration to MSR IA32_PMC_GPx/FXx_CFG_C and
enable corresponding PEBS groups.

Please notice this patch only enables XMM SIMD regs sampling for
arch-PEBS, the other SIMD regs (OPMASK/YMM/ZMM) sampling on arch-PEBS
would be supported after PMI based SIMD regs (OPMASK/YMM/ZMM) sampling
is supported.

Co-developed-by: Kan Liang <kan.liang@linux.intel.com>
Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://patch.msgid.link/20251029102136.61364-12-dapeng1.mi@linux.intel=
.com
---
 arch/x86/events/intel/core.c     | 136 +++++++++++++++++++++++++++++-
 arch/x86/events/intel/ds.c       |  17 ++++-
 arch/x86/events/perf_event.h     |   4 +-
 arch/x86/include/asm/intel_ds.h  |   7 ++-
 arch/x86/include/asm/msr-index.h |   8 ++-
 5 files changed, 171 insertions(+), 1 deletion(-)

diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index 40ccfd8..75cba28 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -2563,6 +2563,45 @@ static void intel_pmu_disable_fixed(struct perf_event =
*event)
 	cpuc->fixed_ctrl_val &=3D ~mask;
 }
=20
+static inline void __intel_pmu_update_event_ext(int idx, u64 ext)
+{
+	struct cpu_hw_events *cpuc =3D this_cpu_ptr(&cpu_hw_events);
+	u32 msr;
+
+	if (idx < INTEL_PMC_IDX_FIXED) {
+		msr =3D MSR_IA32_PMC_V6_GP0_CFG_C +
+		      x86_pmu.addr_offset(idx, false);
+	} else {
+		msr =3D MSR_IA32_PMC_V6_FX0_CFG_C +
+		      x86_pmu.addr_offset(idx - INTEL_PMC_IDX_FIXED, false);
+	}
+
+	cpuc->cfg_c_val[idx] =3D ext;
+	wrmsrq(msr, ext);
+}
+
+static void intel_pmu_disable_event_ext(struct perf_event *event)
+{
+	if (!x86_pmu.arch_pebs)
+		return;
+
+	/*
+	 * Only clear CFG_C MSR for PEBS counter group events,
+	 * it avoids the HW counter's value to be added into
+	 * other PEBS records incorrectly after PEBS counter
+	 * group events are disabled.
+	 *
+	 * For other events, it's unnecessary to clear CFG_C MSRs
+	 * since CFG_C doesn't take effect if counter is in
+	 * disabled state. That helps to reduce the WRMSR overhead
+	 * in context switches.
+	 */
+	if (!is_pebs_counter_event_group(event))
+		return;
+
+	__intel_pmu_update_event_ext(event->hw.idx, 0);
+}
+
 static void intel_pmu_disable_event(struct perf_event *event)
 {
 	struct hw_perf_event *hwc =3D &event->hw;
@@ -2571,9 +2610,12 @@ static void intel_pmu_disable_event(struct perf_event =
*event)
 	switch (idx) {
 	case 0 ... INTEL_PMC_IDX_FIXED - 1:
 		intel_clear_masks(event, idx);
+		intel_pmu_disable_event_ext(event);
 		x86_pmu_disable_event(event);
 		break;
 	case INTEL_PMC_IDX_FIXED ... INTEL_PMC_IDX_FIXED_BTS - 1:
+		intel_pmu_disable_event_ext(event);
+		fallthrough;
 	case INTEL_PMC_IDX_METRIC_BASE ... INTEL_PMC_IDX_METRIC_END:
 		intel_pmu_disable_fixed(event);
 		break;
@@ -2940,6 +2982,66 @@ static void intel_pmu_enable_acr(struct perf_event *ev=
ent)
=20
 DEFINE_STATIC_CALL_NULL(intel_pmu_enable_acr_event, intel_pmu_enable_acr);
=20
+static void intel_pmu_enable_event_ext(struct perf_event *event)
+{
+	struct cpu_hw_events *cpuc =3D this_cpu_ptr(&cpu_hw_events);
+	struct hw_perf_event *hwc =3D &event->hw;
+	union arch_pebs_index old, new;
+	struct arch_pebs_cap cap;
+	u64 ext =3D 0;
+
+	if (!x86_pmu.arch_pebs)
+		return;
+
+	cap =3D hybrid(cpuc->pmu, arch_pebs_cap);
+
+	if (event->attr.precise_ip) {
+		u64 pebs_data_cfg =3D intel_get_arch_pebs_data_config(event);
+
+		ext |=3D ARCH_PEBS_EN;
+		if (hwc->flags & PERF_X86_EVENT_AUTO_RELOAD)
+			ext |=3D (-hwc->sample_period) & ARCH_PEBS_RELOAD;
+
+		if (pebs_data_cfg && cap.caps) {
+			if (pebs_data_cfg & PEBS_DATACFG_MEMINFO)
+				ext |=3D ARCH_PEBS_AUX & cap.caps;
+
+			if (pebs_data_cfg & PEBS_DATACFG_GP)
+				ext |=3D ARCH_PEBS_GPR & cap.caps;
+
+			if (pebs_data_cfg & PEBS_DATACFG_XMMS)
+				ext |=3D ARCH_PEBS_VECR_XMM & cap.caps;
+
+			if (pebs_data_cfg & PEBS_DATACFG_LBRS)
+				ext |=3D ARCH_PEBS_LBR & cap.caps;
+		}
+
+		if (cpuc->n_pebs =3D=3D cpuc->n_large_pebs)
+			new.thresh =3D ARCH_PEBS_THRESH_MULTI;
+		else
+			new.thresh =3D ARCH_PEBS_THRESH_SINGLE;
+
+		rdmsrq(MSR_IA32_PEBS_INDEX, old.whole);
+		if (new.thresh !=3D old.thresh || !old.en) {
+			if (old.thresh =3D=3D ARCH_PEBS_THRESH_MULTI && old.wr > 0) {
+				/*
+				 * Large PEBS was enabled.
+				 * Drain PEBS buffer before applying the single PEBS.
+				 */
+				intel_pmu_drain_pebs_buffer();
+			} else {
+				new.wr =3D 0;
+				new.full =3D 0;
+				new.en =3D 1;
+				wrmsrq(MSR_IA32_PEBS_INDEX, new.whole);
+			}
+		}
+	}
+
+	if (cpuc->cfg_c_val[hwc->idx] !=3D ext)
+		__intel_pmu_update_event_ext(hwc->idx, ext);
+}
+
 static void intel_pmu_enable_event(struct perf_event *event)
 {
 	u64 enable_mask =3D ARCH_PERFMON_EVENTSEL_ENABLE;
@@ -2955,10 +3057,12 @@ static void intel_pmu_enable_event(struct perf_event =
*event)
 			enable_mask |=3D ARCH_PERFMON_EVENTSEL_BR_CNTR;
 		intel_set_masks(event, idx);
 		static_call_cond(intel_pmu_enable_acr_event)(event);
+		intel_pmu_enable_event_ext(event);
 		__x86_pmu_enable_event(hwc, enable_mask);
 		break;
 	case INTEL_PMC_IDX_FIXED ... INTEL_PMC_IDX_FIXED_BTS - 1:
 		static_call_cond(intel_pmu_enable_acr_event)(event);
+		intel_pmu_enable_event_ext(event);
 		fallthrough;
 	case INTEL_PMC_IDX_METRIC_BASE ... INTEL_PMC_IDX_METRIC_END:
 		intel_pmu_enable_fixed(event);
@@ -5301,6 +5405,30 @@ static inline bool intel_pmu_broken_perf_cap(void)
 	return false;
 }
=20
+static inline void __intel_update_pmu_caps(struct pmu *pmu)
+{
+	struct pmu *dest_pmu =3D pmu ? pmu : x86_get_pmu(smp_processor_id());
+
+	if (hybrid(pmu, arch_pebs_cap).caps & ARCH_PEBS_VECR_XMM)
+		dest_pmu->capabilities |=3D PERF_PMU_CAP_EXTENDED_REGS;
+}
+
+static inline void __intel_update_large_pebs_flags(struct pmu *pmu)
+{
+	u64 caps =3D hybrid(pmu, arch_pebs_cap).caps;
+
+	x86_pmu.large_pebs_flags |=3D PERF_SAMPLE_TIME;
+	if (caps & ARCH_PEBS_LBR)
+		x86_pmu.large_pebs_flags |=3D PERF_SAMPLE_BRANCH_STACK;
+
+	if (!(caps & ARCH_PEBS_AUX))
+		x86_pmu.large_pebs_flags &=3D ~PERF_SAMPLE_DATA_SRC;
+	if (!(caps & ARCH_PEBS_GPR)) {
+		x86_pmu.large_pebs_flags &=3D
+			~(PERF_SAMPLE_REGS_INTR | PERF_SAMPLE_REGS_USER);
+	}
+}
+
 #define counter_mask(_gp, _fixed) ((_gp) | ((u64)(_fixed) << INTEL_PMC_IDX_F=
IXED))
=20
 static void update_pmu_cap(struct pmu *pmu)
@@ -5349,8 +5477,12 @@ static void update_pmu_cap(struct pmu *pmu)
 		hybrid(pmu, arch_pebs_cap).counters =3D pebs_mask;
 		hybrid(pmu, arch_pebs_cap).pdists =3D pdists_mask;
=20
-		if (WARN_ON((pebs_mask | pdists_mask) & ~cntrs_mask))
+		if (WARN_ON((pebs_mask | pdists_mask) & ~cntrs_mask)) {
 			x86_pmu.arch_pebs =3D 0;
+		} else {
+			__intel_update_pmu_caps(pmu);
+			__intel_update_large_pebs_flags(pmu);
+		}
 	} else {
 		WARN_ON(x86_pmu.arch_pebs =3D=3D 1);
 		x86_pmu.arch_pebs =3D 0;
@@ -5514,6 +5646,8 @@ static void intel_pmu_cpu_starting(int cpu)
 		}
 	}
=20
+	__intel_update_pmu_caps(cpuc->pmu);
+
 	if (!cpuc->shared_regs)
 		return;
=20
diff --git a/arch/x86/events/intel/ds.c b/arch/x86/events/intel/ds.c
index 1179980..c66e9b5 100644
--- a/arch/x86/events/intel/ds.c
+++ b/arch/x86/events/intel/ds.c
@@ -1528,6 +1528,18 @@ pebs_update_state(bool needed_cb, struct cpu_hw_events=
 *cpuc,
 	}
 }
=20
+u64 intel_get_arch_pebs_data_config(struct perf_event *event)
+{
+	u64 pebs_data_cfg =3D 0;
+
+	if (WARN_ON(event->hw.idx < 0 || event->hw.idx >=3D X86_PMC_IDX_MAX))
+		return 0;
+
+	pebs_data_cfg |=3D pebs_update_adaptive_cfg(event);
+
+	return pebs_data_cfg;
+}
+
 void intel_pmu_pebs_add(struct perf_event *event)
 {
 	struct cpu_hw_events *cpuc =3D this_cpu_ptr(&cpu_hw_events);
@@ -2947,6 +2959,11 @@ static void intel_pmu_drain_arch_pebs(struct pt_regs *=
iregs,
=20
 	index.wr =3D 0;
 	index.full =3D 0;
+	index.en =3D 1;
+	if (cpuc->n_pebs =3D=3D cpuc->n_large_pebs)
+		index.thresh =3D ARCH_PEBS_THRESH_MULTI;
+	else
+		index.thresh =3D ARCH_PEBS_THRESH_SINGLE;
 	wrmsrq(MSR_IA32_PEBS_INDEX, index.whole);
=20
 	mask =3D hybrid(cpuc->pmu, arch_pebs_cap).counters & cpuc->pebs_enabled;
diff --git a/arch/x86/events/perf_event.h b/arch/x86/events/perf_event.h
index 13f411b..3161ec0 100644
--- a/arch/x86/events/perf_event.h
+++ b/arch/x86/events/perf_event.h
@@ -304,6 +304,8 @@ struct cpu_hw_events {
 	/* Intel ACR configuration */
 	u64			acr_cfg_b[X86_PMC_IDX_MAX];
 	u64			acr_cfg_c[X86_PMC_IDX_MAX];
+	/* Cached CFG_C values */
+	u64			cfg_c_val[X86_PMC_IDX_MAX];
=20
 	/*
 	 * Intel LBR bits
@@ -1782,6 +1784,8 @@ void intel_pmu_pebs_data_source_cmt(void);
=20
 void intel_pmu_pebs_data_source_lnl(void);
=20
+u64 intel_get_arch_pebs_data_config(struct perf_event *event);
+
 int intel_pmu_setup_lbr_filter(struct perf_event *event);
=20
 void intel_pt_interrupt(void);
diff --git a/arch/x86/include/asm/intel_ds.h b/arch/x86/include/asm/intel_ds.h
index 023c288..695f87e 100644
--- a/arch/x86/include/asm/intel_ds.h
+++ b/arch/x86/include/asm/intel_ds.h
@@ -7,6 +7,13 @@
 #define PEBS_BUFFER_SHIFT	4
 #define PEBS_BUFFER_SIZE	(PAGE_SIZE << PEBS_BUFFER_SHIFT)
=20
+/*
+ * The largest PEBS record could consume a page, ensure
+ * a record at least can be written after triggering PMI.
+ */
+#define ARCH_PEBS_THRESH_MULTI	((PEBS_BUFFER_SIZE - PAGE_SIZE) >> PEBS_BUFFE=
R_SHIFT)
+#define ARCH_PEBS_THRESH_SINGLE	1
+
 /* The maximal number of PEBS events: */
 #define MAX_PEBS_EVENTS_FMT4	8
 #define MAX_PEBS_EVENTS		32
diff --git a/arch/x86/include/asm/msr-index.h b/arch/x86/include/asm/msr-inde=
x.h
index fc7a4e7..f1ef9ac 100644
--- a/arch/x86/include/asm/msr-index.h
+++ b/arch/x86/include/asm/msr-index.h
@@ -333,6 +333,14 @@
 #define ARCH_PEBS_OFFSET_MASK		0x7fffff
 #define ARCH_PEBS_INDEX_WR_SHIFT	4
=20
+#define ARCH_PEBS_RELOAD		0xffffffff
+#define ARCH_PEBS_LBR_SHIFT		40
+#define ARCH_PEBS_LBR			(0x3ull << ARCH_PEBS_LBR_SHIFT)
+#define ARCH_PEBS_VECR_XMM		BIT_ULL(49)
+#define ARCH_PEBS_GPR			BIT_ULL(61)
+#define ARCH_PEBS_AUX			BIT_ULL(62)
+#define ARCH_PEBS_EN			BIT_ULL(63)
+
 #define MSR_IA32_RTIT_CTL		0x00000570
 #define RTIT_CTL_TRACEEN		BIT(0)
 #define RTIT_CTL_CYCLEACC		BIT(1)

