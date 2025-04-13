Return-Path: <linux-tip-commits+bounces-4936-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 28CE6A87348
	for <lists+linux-tip-commits@lfdr.de>; Sun, 13 Apr 2025 20:58:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 21ED9171B22
	for <lists+linux-tip-commits@lfdr.de>; Sun, 13 Apr 2025 18:58:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 061D01F755B;
	Sun, 13 Apr 2025 18:56:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="wa4MPxok";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Yc3o+nmf"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FB231F5425;
	Sun, 13 Apr 2025 18:56:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744570583; cv=none; b=iYPXu4A6pOG5ehsIo1pCs2r8CeaALr9RPIfYp2xOcukiCWxkfB8i9PoayE/70I+eveZcf00kDPRba0Yuta5v+qRXvwo5QyM0YX8/A5BXyrVjIrk5x9oihFQnzrT/7SXYZUhiy1pziMGh+tQtMkNV+DF0ZtgA6p5860osv8hLbcw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744570583; c=relaxed/simple;
	bh=AHCLy/EwoNTTLLyBod4qfSNbzzzVAoxeCbZSLd0mVr0=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=mp7U7i/lBeKyis5/Vk9qO1wndptKjAeE8KvueI5cpeZlYf+FnoYhAXgEuin3sr77t7Zj5awk7OlKhqxrek0ipM1jPzmuuDVzrmZbCIRGQD5wSFdVB2kNblTwHi5dacKvs+BwxpEQA2dxoZLAFiagQxIrwvlSapWp6ODqW15dy7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=wa4MPxok; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Yc3o+nmf; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sun, 13 Apr 2025 18:56:18 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1744570579;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=iZgngcBHjZgGTViysAKlimPV+GOBrzzftxPFGdrVa50=;
	b=wa4MPxoksubkj3cYfqzw4zsd6kbwIFDknfndctZEu5ZYfMjymeZeZ7D6+I0LAUpmYr86d8
	VdP711drNKaHsCWMVrEdSkFsza30nDVAD57ff6P1hbpwLq69HPPm+wBHC2m8UvmnB1Qzq+
	Nc11cP1qrCST84nJnqRunXxRwlMj/CFtSc7SUiElvEz7fbsq8d05wqvnWuHnERgq9s+3+Q
	YzYynKL2wLTUR85SU+wao/dBNlntGObnYGdWvrLFGQ+pYHs99J5PaZ0s/SnMbwIZF88QEM
	q5fQwyVH0lbIMxOIylDeG0oieByMUJqpfQqDsUNpQ62yZtZGGTto3GlIeuRwCA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1744570579;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=iZgngcBHjZgGTViysAKlimPV+GOBrzzftxPFGdrVa50=;
	b=Yc3o+nmfm20GUgYYCybCfhXuAhkt1/BXMZsT4dQ5VvLcM3MDeiES4wk4non58vjOEwHtA+
	aufJUq5Zp/dRcXCw==
From: "tip-bot2 for Ingo Molnar" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/msr] x86/msr: Rename 'wrmsrl_safe()' to 'wrmsrq_safe()'
Cc: "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@kernel.org>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Juergen Gross <jgross@suse.com>, Dave Hansen <dave.hansen@intel.com>,
 Xin Li <xin@zytor.com>, Linus Torvalds <torvalds@linux-foundation.org>,
 x86@kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174457057849.31282.1557821601937809402.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/msr branch of tip:

Commit-ID:     6fa17efe45440f43fa4e059d7a487179bbba053e
Gitweb:        https://git.kernel.org/tip/6fa17efe45440f43fa4e059d7a487179bbba053e
Author:        Ingo Molnar <mingo@kernel.org>
AuthorDate:    Wed, 09 Apr 2025 22:28:57 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Thu, 10 Apr 2025 11:58:44 +02:00

x86/msr: Rename 'wrmsrl_safe()' to 'wrmsrq_safe()'

Suggested-by: "H. Peter Anvin" <hpa@zytor.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Juergen Gross <jgross@suse.com>
Cc: Dave Hansen <dave.hansen@intel.com>
Cc: Xin Li <xin@zytor.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
---
 arch/x86/events/core.c                                      |  2 +-
 arch/x86/events/intel/core.c                                |  8 ++--
 arch/x86/events/intel/knc.c                                 |  4 +-
 arch/x86/events/intel/lbr.c                                 |  2 +-
 arch/x86/events/intel/p4.c                                  | 16 +++----
 arch/x86/events/intel/p6.c                                  |  4 +-
 arch/x86/include/asm/msr.h                                  |  4 +-
 arch/x86/kernel/cpu/amd.c                                   |  6 +--
 arch/x86/kernel/cpu/bus_lock.c                              |  2 +-
 arch/x86/kernel/cpu/common.c                                | 14 +++---
 arch/x86/kernel/cpu/mce/inject.c                            |  4 +-
 arch/x86/kernel/cpu/mce/intel.c                             |  2 +-
 arch/x86/kernel/cpu/resctrl/core.c                          |  2 +-
 arch/x86/kvm/svm/sev.c                                      |  2 +-
 arch/x86/kvm/x86.c                                          |  6 +--
 arch/x86/lib/msr.c                                          |  2 +-
 drivers/cpufreq/intel_pstate.c                              |  2 +-
 drivers/platform/x86/intel/speed_select_if/isst_if_common.c |  2 +-
 drivers/platform/x86/intel/turbo_max_3.c                    |  2 +-
 drivers/powercap/intel_rapl_msr.c                           |  2 +-
 drivers/thermal/intel/therm_throt.c                         |  2 +-
 21 files changed, 45 insertions(+), 45 deletions(-)

diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
index 5a2eda6..85b55c1 100644
--- a/arch/x86/events/core.c
+++ b/arch/x86/events/core.c
@@ -317,7 +317,7 @@ bool check_hw_exists(struct pmu *pmu, unsigned long *cntr_mask,
 	if (rdmsrq_safe(reg, &val))
 		goto msr_fail;
 	val ^= 0xffffUL;
-	ret = wrmsrl_safe(reg, val);
+	ret = wrmsrq_safe(reg, val);
 	ret |= rdmsrq_safe(reg, &val_new);
 	if (ret || val != val_new)
 		goto msr_fail;
diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index 1e8c89f..394fa83 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -2976,13 +2976,13 @@ static void intel_pmu_reset(void)
 	pr_info("clearing PMU state on CPU#%d\n", smp_processor_id());
 
 	for_each_set_bit(idx, cntr_mask, INTEL_PMC_MAX_GENERIC) {
-		wrmsrl_safe(x86_pmu_config_addr(idx), 0ull);
-		wrmsrl_safe(x86_pmu_event_addr(idx),  0ull);
+		wrmsrq_safe(x86_pmu_config_addr(idx), 0ull);
+		wrmsrq_safe(x86_pmu_event_addr(idx),  0ull);
 	}
 	for_each_set_bit(idx, fixed_cntr_mask, INTEL_PMC_MAX_FIXED) {
 		if (fixed_counter_disabled(idx, cpuc->pmu))
 			continue;
-		wrmsrl_safe(x86_pmu_fixed_ctr_addr(idx), 0ull);
+		wrmsrq_safe(x86_pmu_fixed_ctr_addr(idx), 0ull);
 	}
 
 	if (ds)
@@ -5621,7 +5621,7 @@ static bool check_msr(unsigned long msr, u64 mask)
 	if (is_lbr_from(msr))
 		val_tmp = lbr_from_signext_quirk_wr(val_tmp);
 
-	if (wrmsrl_safe(msr, val_tmp) ||
+	if (wrmsrq_safe(msr, val_tmp) ||
 	    rdmsrq_safe(msr, &val_new))
 		return false;
 
diff --git a/arch/x86/events/intel/knc.c b/arch/x86/events/intel/knc.c
index afb7801..425f6e6 100644
--- a/arch/x86/events/intel/knc.c
+++ b/arch/x86/events/intel/knc.c
@@ -182,7 +182,7 @@ knc_pmu_disable_event(struct perf_event *event)
 	val = hwc->config;
 	val &= ~ARCH_PERFMON_EVENTSEL_ENABLE;
 
-	(void)wrmsrl_safe(hwc->config_base + hwc->idx, val);
+	(void)wrmsrq_safe(hwc->config_base + hwc->idx, val);
 }
 
 static void knc_pmu_enable_event(struct perf_event *event)
@@ -193,7 +193,7 @@ static void knc_pmu_enable_event(struct perf_event *event)
 	val = hwc->config;
 	val |= ARCH_PERFMON_EVENTSEL_ENABLE;
 
-	(void)wrmsrl_safe(hwc->config_base + hwc->idx, val);
+	(void)wrmsrq_safe(hwc->config_base + hwc->idx, val);
 }
 
 static inline u64 knc_pmu_get_status(void)
diff --git a/arch/x86/events/intel/lbr.c b/arch/x86/events/intel/lbr.c
index b55c59a..48894f7 100644
--- a/arch/x86/events/intel/lbr.c
+++ b/arch/x86/events/intel/lbr.c
@@ -1602,7 +1602,7 @@ void __init intel_pmu_arch_lbr_init(void)
 		goto clear_arch_lbr;
 
 	/* Apply the max depth of Arch LBR */
-	if (wrmsrl_safe(MSR_ARCH_LBR_DEPTH, lbr_nr))
+	if (wrmsrq_safe(MSR_ARCH_LBR_DEPTH, lbr_nr))
 		goto clear_arch_lbr;
 
 	x86_pmu.lbr_depth_mask = eax.split.lbr_depth_mask;
diff --git a/arch/x86/events/intel/p4.c b/arch/x86/events/intel/p4.c
index 36d4cd2..24d811a 100644
--- a/arch/x86/events/intel/p4.c
+++ b/arch/x86/events/intel/p4.c
@@ -897,8 +897,8 @@ static void p4_pmu_disable_pebs(void)
 	 * So at moment let leave metrics turned on forever -- it's
 	 * ok for now but need to be revisited!
 	 *
-	 * (void)wrmsrl_safe(MSR_IA32_PEBS_ENABLE, 0);
-	 * (void)wrmsrl_safe(MSR_P4_PEBS_MATRIX_VERT, 0);
+	 * (void)wrmsrq_safe(MSR_IA32_PEBS_ENABLE, 0);
+	 * (void)wrmsrq_safe(MSR_P4_PEBS_MATRIX_VERT, 0);
 	 */
 }
 
@@ -911,7 +911,7 @@ static inline void p4_pmu_disable_event(struct perf_event *event)
 	 * state we need to clear P4_CCCR_OVF, otherwise interrupt get
 	 * asserted again and again
 	 */
-	(void)wrmsrl_safe(hwc->config_base,
+	(void)wrmsrq_safe(hwc->config_base,
 		p4_config_unpack_cccr(hwc->config) & ~P4_CCCR_ENABLE & ~P4_CCCR_OVF & ~P4_CCCR_RESERVED);
 }
 
@@ -944,8 +944,8 @@ static void p4_pmu_enable_pebs(u64 config)
 
 	bind = &p4_pebs_bind_map[idx];
 
-	(void)wrmsrl_safe(MSR_IA32_PEBS_ENABLE,	(u64)bind->metric_pebs);
-	(void)wrmsrl_safe(MSR_P4_PEBS_MATRIX_VERT,	(u64)bind->metric_vert);
+	(void)wrmsrq_safe(MSR_IA32_PEBS_ENABLE,	(u64)bind->metric_pebs);
+	(void)wrmsrq_safe(MSR_P4_PEBS_MATRIX_VERT,	(u64)bind->metric_vert);
 }
 
 static void __p4_pmu_enable_event(struct perf_event *event)
@@ -979,8 +979,8 @@ static void __p4_pmu_enable_event(struct perf_event *event)
 	 */
 	p4_pmu_enable_pebs(hwc->config);
 
-	(void)wrmsrl_safe(escr_addr, escr_conf);
-	(void)wrmsrl_safe(hwc->config_base,
+	(void)wrmsrq_safe(escr_addr, escr_conf);
+	(void)wrmsrq_safe(hwc->config_base,
 				(cccr & ~P4_CCCR_RESERVED) | P4_CCCR_ENABLE);
 }
 
@@ -1398,7 +1398,7 @@ __init int p4_pmu_init(void)
 	 */
 	for_each_set_bit(i, x86_pmu.cntr_mask, X86_PMC_IDX_MAX) {
 		reg = x86_pmu_config_addr(i);
-		wrmsrl_safe(reg, 0ULL);
+		wrmsrq_safe(reg, 0ULL);
 	}
 
 	return 0;
diff --git a/arch/x86/events/intel/p6.c b/arch/x86/events/intel/p6.c
index 6a1fdbc..35917a7 100644
--- a/arch/x86/events/intel/p6.c
+++ b/arch/x86/events/intel/p6.c
@@ -163,7 +163,7 @@ p6_pmu_disable_event(struct perf_event *event)
 	struct hw_perf_event *hwc = &event->hw;
 	u64 val = P6_NOP_EVENT;
 
-	(void)wrmsrl_safe(hwc->config_base, val);
+	(void)wrmsrq_safe(hwc->config_base, val);
 }
 
 static void p6_pmu_enable_event(struct perf_event *event)
@@ -180,7 +180,7 @@ static void p6_pmu_enable_event(struct perf_event *event)
 	 * to actually enable the events.
 	 */
 
-	(void)wrmsrl_safe(hwc->config_base, val);
+	(void)wrmsrq_safe(hwc->config_base, val);
 }
 
 PMU_FORMAT_ATTR(event,	"config:0-7"	);
diff --git a/arch/x86/include/asm/msr.h b/arch/x86/include/asm/msr.h
index 58554b5..2317575 100644
--- a/arch/x86/include/asm/msr.h
+++ b/arch/x86/include/asm/msr.h
@@ -316,7 +316,7 @@ static __always_inline void wrmsrns(u32 msr, u64 val)
 /*
  * 64-bit version of wrmsr_safe():
  */
-static inline int wrmsrl_safe(u32 msr, u64 val)
+static inline int wrmsrq_safe(u32 msr, u64 val)
 {
 	return wrmsr_safe(msr, (u32)val,  (u32)(val >> 32));
 }
@@ -385,7 +385,7 @@ static inline int rdmsrl_safe_on_cpu(unsigned int cpu, u32 msr_no, u64 *q)
 }
 static inline int wrmsrl_safe_on_cpu(unsigned int cpu, u32 msr_no, u64 q)
 {
-	return wrmsrl_safe(msr_no, q);
+	return wrmsrq_safe(msr_no, q);
 }
 static inline int rdmsr_safe_regs_on_cpu(unsigned int cpu, u32 regs[8])
 {
diff --git a/arch/x86/kernel/cpu/amd.c b/arch/x86/kernel/cpu/amd.c
index 3c49a92..8937923 100644
--- a/arch/x86/kernel/cpu/amd.c
+++ b/arch/x86/kernel/cpu/amd.c
@@ -612,7 +612,7 @@ static void early_init_amd(struct cpuinfo_x86 *c)
 	if (!cpu_has(c, X86_FEATURE_HYPERVISOR) && !cpu_has(c, X86_FEATURE_IBPB_BRTYPE)) {
 		if (c->x86 == 0x17 && boot_cpu_has(X86_FEATURE_AMD_IBPB))
 			setup_force_cpu_cap(X86_FEATURE_IBPB_BRTYPE);
-		else if (c->x86 >= 0x19 && !wrmsrl_safe(MSR_IA32_PRED_CMD, PRED_CMD_SBPB)) {
+		else if (c->x86 >= 0x19 && !wrmsrq_safe(MSR_IA32_PRED_CMD, PRED_CMD_SBPB)) {
 			setup_force_cpu_cap(X86_FEATURE_IBPB_BRTYPE);
 			setup_force_cpu_cap(X86_FEATURE_SBPB);
 		}
@@ -790,7 +790,7 @@ static void init_amd_bd(struct cpuinfo_x86 *c)
 	if ((c->x86_model >= 0x02) && (c->x86_model < 0x20)) {
 		if (!rdmsrq_safe(MSR_F15H_IC_CFG, &value) && !(value & 0x1E)) {
 			value |= 0x1E;
-			wrmsrl_safe(MSR_F15H_IC_CFG, value);
+			wrmsrq_safe(MSR_F15H_IC_CFG, value);
 		}
 	}
 
@@ -840,7 +840,7 @@ void init_spectral_chicken(struct cpuinfo_x86 *c)
 	if (!cpu_has(c, X86_FEATURE_HYPERVISOR)) {
 		if (!rdmsrq_safe(MSR_ZEN2_SPECTRAL_CHICKEN, &value)) {
 			value |= MSR_ZEN2_SPECTRAL_CHICKEN_BIT;
-			wrmsrl_safe(MSR_ZEN2_SPECTRAL_CHICKEN, value);
+			wrmsrq_safe(MSR_ZEN2_SPECTRAL_CHICKEN, value);
 		}
 	}
 #endif
diff --git a/arch/x86/kernel/cpu/bus_lock.c b/arch/x86/kernel/cpu/bus_lock.c
index 18bd8a8..a18d0f2 100644
--- a/arch/x86/kernel/cpu/bus_lock.c
+++ b/arch/x86/kernel/cpu/bus_lock.c
@@ -101,7 +101,7 @@ static bool split_lock_verify_msr(bool on)
 		ctrl |= MSR_TEST_CTRL_SPLIT_LOCK_DETECT;
 	else
 		ctrl &= ~MSR_TEST_CTRL_SPLIT_LOCK_DETECT;
-	if (wrmsrl_safe(MSR_TEST_CTRL, ctrl))
+	if (wrmsrq_safe(MSR_TEST_CTRL, ctrl))
 		return false;
 	rdmsrq(MSR_TEST_CTRL, tmp);
 	return ctrl == tmp;
diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index dfccea1..bb986ba 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -158,7 +158,7 @@ static void ppin_init(struct cpuinfo_x86 *c)
 
 	/* If PPIN is disabled, try to enable */
 	if (!(val & 2UL)) {
-		wrmsrl_safe(info->msr_ppin_ctl,  val | 2UL);
+		wrmsrq_safe(info->msr_ppin_ctl,  val | 2UL);
 		rdmsrq_safe(info->msr_ppin_ctl, &val);
 	}
 
@@ -2114,15 +2114,15 @@ static inline void idt_syscall_init(void)
 		 * This does not cause SYSENTER to jump to the wrong location, because
 		 * AMD doesn't allow SYSENTER in long mode (either 32- or 64-bit).
 		 */
-		wrmsrl_safe(MSR_IA32_SYSENTER_CS, (u64)__KERNEL_CS);
-		wrmsrl_safe(MSR_IA32_SYSENTER_ESP,
+		wrmsrq_safe(MSR_IA32_SYSENTER_CS, (u64)__KERNEL_CS);
+		wrmsrq_safe(MSR_IA32_SYSENTER_ESP,
 			    (unsigned long)(cpu_entry_stack(smp_processor_id()) + 1));
-		wrmsrl_safe(MSR_IA32_SYSENTER_EIP, (u64)entry_SYSENTER_compat);
+		wrmsrq_safe(MSR_IA32_SYSENTER_EIP, (u64)entry_SYSENTER_compat);
 	} else {
 		wrmsrl_cstar((unsigned long)entry_SYSCALL32_ignore);
-		wrmsrl_safe(MSR_IA32_SYSENTER_CS, (u64)GDT_ENTRY_INVALID_SEG);
-		wrmsrl_safe(MSR_IA32_SYSENTER_ESP, 0ULL);
-		wrmsrl_safe(MSR_IA32_SYSENTER_EIP, 0ULL);
+		wrmsrq_safe(MSR_IA32_SYSENTER_CS, (u64)GDT_ENTRY_INVALID_SEG);
+		wrmsrq_safe(MSR_IA32_SYSENTER_ESP, 0ULL);
+		wrmsrq_safe(MSR_IA32_SYSENTER_EIP, 0ULL);
 	}
 
 	/*
diff --git a/arch/x86/kernel/cpu/mce/inject.c b/arch/x86/kernel/cpu/mce/inject.c
index 75ff605..5226f8f 100644
--- a/arch/x86/kernel/cpu/mce/inject.c
+++ b/arch/x86/kernel/cpu/mce/inject.c
@@ -747,9 +747,9 @@ static void check_hw_inj_possible(void)
 
 		toggle_hw_mce_inject(cpu, true);
 
-		wrmsrl_safe(mca_msr_reg(bank, MCA_STATUS), status);
+		wrmsrq_safe(mca_msr_reg(bank, MCA_STATUS), status);
 		rdmsrq_safe(mca_msr_reg(bank, MCA_STATUS), &status);
-		wrmsrl_safe(mca_msr_reg(bank, MCA_STATUS), 0);
+		wrmsrq_safe(mca_msr_reg(bank, MCA_STATUS), 0);
 
 		if (!status) {
 			hw_injection_possible = false;
diff --git a/arch/x86/kernel/cpu/mce/intel.c b/arch/x86/kernel/cpu/mce/intel.c
index 9b9ef7d..efcf21e 100644
--- a/arch/x86/kernel/cpu/mce/intel.c
+++ b/arch/x86/kernel/cpu/mce/intel.c
@@ -463,7 +463,7 @@ static void intel_imc_init(struct cpuinfo_x86 *c)
 		if (rdmsrq_safe(MSR_ERROR_CONTROL, &error_control))
 			return;
 		error_control |= 2;
-		wrmsrl_safe(MSR_ERROR_CONTROL, error_control);
+		wrmsrq_safe(MSR_ERROR_CONTROL, error_control);
 		break;
 	}
 }
diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resctrl/core.c
index 6d408f7..280d690 100644
--- a/arch/x86/kernel/cpu/resctrl/core.c
+++ b/arch/x86/kernel/cpu/resctrl/core.c
@@ -145,7 +145,7 @@ static inline void cache_alloc_hsw_probe(void)
 	struct rdt_resource *r  = &hw_res->r_resctrl;
 	u64 max_cbm = BIT_ULL_MASK(20) - 1, l3_cbm_0;
 
-	if (wrmsrl_safe(MSR_IA32_L3_CBM_BASE, max_cbm))
+	if (wrmsrq_safe(MSR_IA32_L3_CBM_BASE, max_cbm))
 		return;
 
 	rdmsrq(MSR_IA32_L3_CBM_BASE, l3_cbm_0);
diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
index 0bc708e..a4aabd6 100644
--- a/arch/x86/kvm/svm/sev.c
+++ b/arch/x86/kvm/svm/sev.c
@@ -3119,7 +3119,7 @@ static void sev_flush_encrypted_page(struct kvm_vcpu *vcpu, void *va)
 	 * back to WBINVD if this faults so as not to make any problems worse
 	 * by leaving stale encrypted data in the cache.
 	 */
-	if (WARN_ON_ONCE(wrmsrl_safe(MSR_AMD64_VM_PAGE_FLUSH, addr | asid)))
+	if (WARN_ON_ONCE(wrmsrq_safe(MSR_AMD64_VM_PAGE_FLUSH, addr | asid)))
 		goto do_wbinvd;
 
 	return;
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 134c4a1..b922428 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -593,7 +593,7 @@ static int kvm_probe_user_return_msr(u32 msr)
 	ret = rdmsrq_safe(msr, &val);
 	if (ret)
 		goto out;
-	ret = wrmsrl_safe(msr, val);
+	ret = wrmsrq_safe(msr, val);
 out:
 	preempt_enable();
 	return ret;
@@ -644,7 +644,7 @@ int kvm_set_user_return_msr(unsigned slot, u64 value, u64 mask)
 	value = (value & mask) | (msrs->values[slot].host & ~mask);
 	if (value == msrs->values[slot].curr)
 		return 0;
-	err = wrmsrl_safe(kvm_uret_msrs_list[slot], value);
+	err = wrmsrq_safe(kvm_uret_msrs_list[slot], value);
 	if (err)
 		return 1;
 
@@ -13654,7 +13654,7 @@ int kvm_spec_ctrl_test_value(u64 value)
 
 	if (rdmsrq_safe(MSR_IA32_SPEC_CTRL, &saved_value))
 		ret = 1;
-	else if (wrmsrl_safe(MSR_IA32_SPEC_CTRL, value))
+	else if (wrmsrq_safe(MSR_IA32_SPEC_CTRL, value))
 		ret = 1;
 	else
 		wrmsrq(MSR_IA32_SPEC_CTRL, saved_value);
diff --git a/arch/x86/lib/msr.c b/arch/x86/lib/msr.c
index d533881..4ef7c6d 100644
--- a/arch/x86/lib/msr.c
+++ b/arch/x86/lib/msr.c
@@ -58,7 +58,7 @@ static int msr_read(u32 msr, struct msr *m)
  */
 static int msr_write(u32 msr, struct msr *m)
 {
-	return wrmsrl_safe(msr, m->q);
+	return wrmsrq_safe(msr, m->q);
 }
 
 static inline int __flip_bit(u32 msr, u8 bit, bool set)
diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
index a57f494..83a43c6 100644
--- a/drivers/cpufreq/intel_pstate.c
+++ b/drivers/cpufreq/intel_pstate.c
@@ -1894,7 +1894,7 @@ void notify_hwp_interrupt(void)
 	return;
 
 ack_intr:
-	wrmsrl_safe(MSR_HWP_STATUS, 0);
+	wrmsrq_safe(MSR_HWP_STATUS, 0);
 	raw_spin_unlock_irqrestore(&hwp_notify_lock, flags);
 }
 
diff --git a/drivers/platform/x86/intel/speed_select_if/isst_if_common.c b/drivers/platform/x86/intel/speed_select_if/isst_if_common.c
index 1ebf562..4368d59 100644
--- a/drivers/platform/x86/intel/speed_select_if/isst_if_common.c
+++ b/drivers/platform/x86/intel/speed_select_if/isst_if_common.c
@@ -211,7 +211,7 @@ static void isst_restore_msr_local(int cpu)
 		hash_for_each_possible(isst_hash, sst_cmd, hnode,
 				       punit_msr_white_list[i]) {
 			if (!sst_cmd->mbox_cmd_type && sst_cmd->cpu == cpu)
-				wrmsrl_safe(sst_cmd->cmd, sst_cmd->data);
+				wrmsrq_safe(sst_cmd->cmd, sst_cmd->data);
 		}
 	}
 	mutex_unlock(&isst_hash_lock);
diff --git a/drivers/platform/x86/intel/turbo_max_3.c b/drivers/platform/x86/intel/turbo_max_3.c
index c411ec5..7e538bb 100644
--- a/drivers/platform/x86/intel/turbo_max_3.c
+++ b/drivers/platform/x86/intel/turbo_max_3.c
@@ -41,7 +41,7 @@ static int get_oc_core_priority(unsigned int cpu)
 	value = cmd << MSR_OC_MAILBOX_CMD_OFFSET;
 	/* Set the busy bit to indicate OS is trying to issue command */
 	value |=  BIT_ULL(MSR_OC_MAILBOX_BUSY_BIT);
-	ret = wrmsrl_safe(MSR_OC_MAILBOX, value);
+	ret = wrmsrq_safe(MSR_OC_MAILBOX, value);
 	if (ret) {
 		pr_debug("cpu %d OC mailbox write failed\n", cpu);
 		return ret;
diff --git a/drivers/powercap/intel_rapl_msr.c b/drivers/powercap/intel_rapl_msr.c
index 9100300..c7f15b0 100644
--- a/drivers/powercap/intel_rapl_msr.c
+++ b/drivers/powercap/intel_rapl_msr.c
@@ -123,7 +123,7 @@ static void rapl_msr_update_func(void *info)
 	val &= ~ra->mask;
 	val |= ra->value;
 
-	ra->err = wrmsrl_safe(ra->reg.msr, val);
+	ra->err = wrmsrq_safe(ra->reg.msr, val);
 }
 
 static int rapl_msr_write_raw(int cpu, struct reg_action *ra)
diff --git a/drivers/thermal/intel/therm_throt.c b/drivers/thermal/intel/therm_throt.c
index c4f3f13..debc94e 100644
--- a/drivers/thermal/intel/therm_throt.c
+++ b/drivers/thermal/intel/therm_throt.c
@@ -643,7 +643,7 @@ static void notify_thresholds(__u64 msr_val)
 
 void __weak notify_hwp_interrupt(void)
 {
-	wrmsrl_safe(MSR_HWP_STATUS, 0);
+	wrmsrq_safe(MSR_HWP_STATUS, 0);
 }
 
 /* Thermal transition interrupt handler */

