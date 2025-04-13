Return-Path: <linux-tip-commits+bounces-4943-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA5F6A8735D
	for <lists+linux-tip-commits@lfdr.de>; Sun, 13 Apr 2025 21:00:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3CBB73B615C
	for <lists+linux-tip-commits@lfdr.de>; Sun, 13 Apr 2025 18:59:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20A53204866;
	Sun, 13 Apr 2025 18:56:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ezqWa4GI";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Fc/eBbQy"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C06721F63D5;
	Sun, 13 Apr 2025 18:56:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744570590; cv=none; b=fDB22U0WTz+IiTAm/oQawYrcakND6fx7bpdtc6WAygJLUuXALR8wdZ+au1zZLdNhcs4N4F/I+Vf+ziCVho8WeBMn/VlwvnCG/lsYl2XR7FaIkoZ/hSL4jdRHCAx85XvHVK0jgxdXEeA2RUqxqMytS1zQZIdRu1kijNJHD06T92Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744570590; c=relaxed/simple;
	bh=TmEHXy+GZtGGfaQ6X7CV19XArbfZtIlbwV3dc2qAXEE=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=n5uLvf4dSP4RzBLNXQaBssJcWps+x3hInJe5drbiJbYuM69u4dqgZHsNrHRSAM+kY6rmxFKVMl4Zv+zSPN0qR+JSJ6ZQHa4LFRo5TN96Yp52Jy+jn7zwL/YtaEY77MSGDYnMoCXTGMjzWUd1wlF9osERJDHO67i4Ywlb6la5arQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ezqWa4GI; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Fc/eBbQy; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sun, 13 Apr 2025 18:56:20 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1744570582;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=PO437y3u0y/CK/uagoSdajbW7ApO/ObHCJ9xNvFtI8E=;
	b=ezqWa4GIc+S8NXR12EE8Fb+JRGTsbR3s2jdbOqPTpfEYAnmmJwSYRIfvMfjamr4hmKZrDV
	Xi9hOzMSkcYdR34NdZ6Lq9X9/3AfJoB//Q5HAjJpw6pB1NUUfHaZfxQvW72cogyxGEvG1b
	TPuh1/n0dNpTH7A6Sd+WalmLTxvGGUFjr2nibk9kzlRN6vcvmQhfJmjFq09pLTgS0TSAD3
	Uq6EHFAMCJartK/MEKA3Ns51sob7vRCYwtD183HztBSDVN8tsvVfGWLe4FmJNP8DVrUBVF
	7nQmi5QSw7C69FEs+Tn9aHbXFv+161BC/rWDUrJgsFeUBdb0Rn/Q9oa6iYtzTQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1744570582;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=PO437y3u0y/CK/uagoSdajbW7ApO/ObHCJ9xNvFtI8E=;
	b=Fc/eBbQyhr2tk1fGSUQHO37CTOQ4/DaGtT+Zscfw7dCeLyzean3MzWtKu3dVJ4Vxi4VuRZ
	Y//AMq/QPOzyK7Aw==
From: "tip-bot2 for Ingo Molnar" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/msr] x86/msr: Rename 'wrmsrl()' to 'wrmsrq()'
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
Message-ID: <174457058098.31282.7050687912692405193.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/msr branch of tip:

Commit-ID:     78255eb23973323633432d9ec40b65c15e41888a
Gitweb:        https://git.kernel.org/tip/78255eb23973323633432d9ec40b65c15e41888a
Author:        Ingo Molnar <mingo@kernel.org>
AuthorDate:    Wed, 09 Apr 2025 22:28:55 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Thu, 10 Apr 2025 11:58:33 +02:00

x86/msr: Rename 'wrmsrl()' to 'wrmsrq()'

Suggested-by: "H. Peter Anvin" <hpa@zytor.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Juergen Gross <jgross@suse.com>
Cc: Dave Hansen <dave.hansen@intel.com>
Cc: Xin Li <xin@zytor.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
---
 arch/x86/events/amd/brs.c                                     |  4 +-
 arch/x86/events/amd/core.c                                    |  8 +-
 arch/x86/events/amd/ibs.c                                     |  8 +-
 arch/x86/events/amd/lbr.c                                     | 12 +-
 arch/x86/events/amd/uncore.c                                  | 10 +-
 arch/x86/events/core.c                                        | 12 +-
 arch/x86/events/intel/core.c                                  | 44 ++---
 arch/x86/events/intel/ds.c                                    | 10 +-
 arch/x86/events/intel/knc.c                                   |  6 +-
 arch/x86/events/intel/lbr.c                                   | 28 +--
 arch/x86/events/intel/p4.c                                    |  4 +-
 arch/x86/events/intel/p6.c                                    |  4 +-
 arch/x86/events/intel/pt.c                                    | 18 +-
 arch/x86/events/intel/uncore_discovery.c                      | 10 +-
 arch/x86/events/intel/uncore_nhmex.c                          | 66 +++----
 arch/x86/events/intel/uncore_snb.c                            | 40 ++--
 arch/x86/events/intel/uncore_snbep.c                          | 42 ++--
 arch/x86/events/perf_event.h                                  | 20 +-
 arch/x86/events/zhaoxin/core.c                                | 10 +-
 arch/x86/hyperv/hv_apic.c                                     |  2 +-
 arch/x86/hyperv/hv_init.c                                     | 40 ++--
 arch/x86/include/asm/apic.h                                   |  2 +-
 arch/x86/include/asm/debugreg.h                               |  2 +-
 arch/x86/include/asm/fsgsbase.h                               |  2 +-
 arch/x86/include/asm/msr.h                                    |  4 +-
 arch/x86/include/asm/paravirt.h                               |  2 +-
 arch/x86/kernel/apic/apic.c                                   | 10 +-
 arch/x86/kernel/cpu/bugs.c                                    | 12 +-
 arch/x86/kernel/cpu/bus_lock.c                                |  6 +-
 arch/x86/kernel/cpu/common.c                                  | 34 ++--
 arch/x86/kernel/cpu/feat_ctl.c                                |  2 +-
 arch/x86/kernel/cpu/intel.c                                   |  2 +-
 arch/x86/kernel/cpu/intel_epb.c                               |  2 +-
 arch/x86/kernel/cpu/mce/amd.c                                 |  8 +-
 arch/x86/kernel/cpu/mce/core.c                                |  8 +-
 arch/x86/kernel/cpu/mce/inject.c                              | 20 +-
 arch/x86/kernel/cpu/mce/intel.c                               | 10 +-
 arch/x86/kernel/cpu/mshyperv.c                                |  6 +-
 arch/x86/kernel/cpu/resctrl/core.c                            |  6 +-
 arch/x86/kernel/cpu/resctrl/pseudo_lock.c                     |  2 +-
 arch/x86/kernel/cpu/resctrl/rdtgroup.c                        |  4 +-
 arch/x86/kernel/cpu/sgx/main.c                                |  2 +-
 arch/x86/kernel/cpu/tsx.c                                     | 10 +-
 arch/x86/kernel/fpu/xstate.c                                  | 10 +-
 arch/x86/kernel/fpu/xstate.h                                  |  2 +-
 arch/x86/kernel/fred.c                                        | 20 +-
 arch/x86/kernel/kvm.c                                         | 26 +--
 arch/x86/kernel/kvmclock.c                                    |  4 +-
 arch/x86/kernel/mmconf-fam10h_64.c                            |  2 +-
 arch/x86/kernel/process.c                                     | 14 +-
 arch/x86/kernel/process_64.c                                  |  6 +-
 arch/x86/kernel/reboot_fixups_32.c                            |  2 +-
 arch/x86/kernel/shstk.c                                       | 14 +-
 arch/x86/kernel/traps.c                                       |  6 +-
 arch/x86/kernel/tsc_sync.c                                    |  8 +-
 arch/x86/kvm/svm/avic.c                                       |  2 +-
 arch/x86/kvm/svm/svm.c                                        | 10 +-
 arch/x86/kvm/vmx/pmu_intel.c                                  |  2 +-
 arch/x86/kvm/vmx/vmx.c                                        | 24 +--
 arch/x86/kvm/x86.c                                            | 16 +-
 arch/x86/mm/pat/memtype.c                                     |  2 +-
 arch/x86/mm/tlb.c                                             |  2 +-
 arch/x86/pci/amd_bus.c                                        |  2 +-
 arch/x86/platform/olpc/olpc-xo1-sci.c                         |  2 +-
 arch/x86/power/cpu.c                                          | 12 +-
 arch/x86/virt/svm/sev.c                                       |  4 +-
 arch/x86/xen/suspend.c                                        |  4 +-
 drivers/cpufreq/acpi-cpufreq.c                                |  2 +-
 drivers/cpufreq/amd-pstate.c                                  |  2 +-
 drivers/cpufreq/e_powersaver.c                                |  2 +-
 drivers/cpufreq/intel_pstate.c                                | 12 +-
 drivers/cpufreq/longhaul.c                                    | 16 +-
 drivers/cpufreq/powernow-k7.c                                 |  4 +-
 drivers/crypto/ccp/sev-dev.c                                  |  2 +-
 drivers/idle/intel_idle.c                                     | 10 +-
 drivers/platform/x86/intel/ifs/load.c                         | 10 +-
 drivers/platform/x86/intel/ifs/runtest.c                      |  8 +-
 drivers/platform/x86/intel/pmc/cnp.c                          |  4 +-
 drivers/platform/x86/intel/speed_select_if/isst_if_mbox_msr.c |  4 +-
 drivers/platform/x86/intel_ips.c                              | 16 +-
 drivers/thermal/intel/intel_hfi.c                             |  6 +-
 drivers/thermal/intel/therm_throt.c                           |  2 +-
 drivers/video/fbdev/geode/lxfb_ops.c                          | 10 +-
 drivers/video/fbdev/geode/suspend_gx.c                        |  2 +-
 drivers/video/fbdev/geode/video_gx.c                          |  8 +-
 include/hyperv/hvgdk_mini.h                                   |  2 +-
 86 files changed, 436 insertions(+), 436 deletions(-)

diff --git a/arch/x86/events/amd/brs.c b/arch/x86/events/amd/brs.c
index 86ef0fe..ec4e8a4 100644
--- a/arch/x86/events/amd/brs.c
+++ b/arch/x86/events/amd/brs.c
@@ -187,7 +187,7 @@ void amd_brs_reset(void)
 	/*
 	 * Mark first entry as poisoned
 	 */
-	wrmsrl(brs_to(0), BRS_POISON);
+	wrmsrq(brs_to(0), BRS_POISON);
 }
 
 int __init amd_brs_init(void)
@@ -371,7 +371,7 @@ static void amd_brs_poison_buffer(void)
 	idx = amd_brs_get_tos(&cfg);
 
 	/* Poison target of entry */
-	wrmsrl(brs_to(idx), BRS_POISON);
+	wrmsrq(brs_to(idx), BRS_POISON);
 }
 
 /*
diff --git a/arch/x86/events/amd/core.c b/arch/x86/events/amd/core.c
index 94d6d24..cb62b6d 100644
--- a/arch/x86/events/amd/core.c
+++ b/arch/x86/events/amd/core.c
@@ -563,13 +563,13 @@ static void amd_pmu_cpu_reset(int cpu)
 		return;
 
 	/* Clear enable bits i.e. PerfCntrGlobalCtl.PerfCntrEn */
-	wrmsrl(MSR_AMD64_PERF_CNTR_GLOBAL_CTL, 0);
+	wrmsrq(MSR_AMD64_PERF_CNTR_GLOBAL_CTL, 0);
 
 	/*
 	 * Clear freeze and overflow bits i.e. PerfCntrGLobalStatus.LbrFreeze
 	 * and PerfCntrGLobalStatus.PerfCntrOvfl
 	 */
-	wrmsrl(MSR_AMD64_PERF_CNTR_GLOBAL_STATUS_CLR,
+	wrmsrq(MSR_AMD64_PERF_CNTR_GLOBAL_STATUS_CLR,
 	       GLOBAL_STATUS_LBRS_FROZEN | amd_pmu_global_cntr_mask);
 }
 
@@ -651,7 +651,7 @@ static void amd_pmu_cpu_dead(int cpu)
 
 static __always_inline void amd_pmu_set_global_ctl(u64 ctl)
 {
-	wrmsrl(MSR_AMD64_PERF_CNTR_GLOBAL_CTL, ctl);
+	wrmsrq(MSR_AMD64_PERF_CNTR_GLOBAL_CTL, ctl);
 }
 
 static inline u64 amd_pmu_get_global_status(void)
@@ -672,7 +672,7 @@ static inline void amd_pmu_ack_global_status(u64 status)
 	 * clears the same bit in PerfCntrGlobalStatus
 	 */
 
-	wrmsrl(MSR_AMD64_PERF_CNTR_GLOBAL_STATUS_CLR, status);
+	wrmsrq(MSR_AMD64_PERF_CNTR_GLOBAL_STATUS_CLR, status);
 }
 
 static bool amd_pmu_test_overflow_topbit(int idx)
diff --git a/arch/x86/events/amd/ibs.c b/arch/x86/events/amd/ibs.c
index ca6cc90..82fa755 100644
--- a/arch/x86/events/amd/ibs.c
+++ b/arch/x86/events/amd/ibs.c
@@ -435,9 +435,9 @@ static inline void perf_ibs_enable_event(struct perf_ibs *perf_ibs,
 	u64 tmp = hwc->config | config;
 
 	if (perf_ibs->fetch_count_reset_broken)
-		wrmsrl(hwc->config_base, tmp & ~perf_ibs->enable_mask);
+		wrmsrq(hwc->config_base, tmp & ~perf_ibs->enable_mask);
 
-	wrmsrl(hwc->config_base, tmp | perf_ibs->enable_mask);
+	wrmsrq(hwc->config_base, tmp | perf_ibs->enable_mask);
 }
 
 /*
@@ -452,9 +452,9 @@ static inline void perf_ibs_disable_event(struct perf_ibs *perf_ibs,
 {
 	config &= ~perf_ibs->cnt_mask;
 	if (boot_cpu_data.x86 == 0x10)
-		wrmsrl(hwc->config_base, config);
+		wrmsrq(hwc->config_base, config);
 	config &= ~perf_ibs->enable_mask;
-	wrmsrl(hwc->config_base, config);
+	wrmsrq(hwc->config_base, config);
 }
 
 /*
diff --git a/arch/x86/events/amd/lbr.c b/arch/x86/events/amd/lbr.c
index a1aecf5..1988519 100644
--- a/arch/x86/events/amd/lbr.c
+++ b/arch/x86/events/amd/lbr.c
@@ -61,12 +61,12 @@ struct branch_entry {
 
 static __always_inline void amd_pmu_lbr_set_from(unsigned int idx, u64 val)
 {
-	wrmsrl(MSR_AMD_SAMP_BR_FROM + idx * 2, val);
+	wrmsrq(MSR_AMD_SAMP_BR_FROM + idx * 2, val);
 }
 
 static __always_inline void amd_pmu_lbr_set_to(unsigned int idx, u64 val)
 {
-	wrmsrl(MSR_AMD_SAMP_BR_FROM + idx * 2 + 1, val);
+	wrmsrq(MSR_AMD_SAMP_BR_FROM + idx * 2 + 1, val);
 }
 
 static __always_inline u64 amd_pmu_lbr_get_from(unsigned int idx)
@@ -333,7 +333,7 @@ void amd_pmu_lbr_reset(void)
 
 	cpuc->last_task_ctx = NULL;
 	cpuc->last_log_id = 0;
-	wrmsrl(MSR_AMD64_LBR_SELECT, 0);
+	wrmsrq(MSR_AMD64_LBR_SELECT, 0);
 }
 
 void amd_pmu_lbr_add(struct perf_event *event)
@@ -396,16 +396,16 @@ void amd_pmu_lbr_enable_all(void)
 	/* Set hardware branch filter */
 	if (cpuc->lbr_select) {
 		lbr_select = cpuc->lbr_sel->config & LBR_SELECT_MASK;
-		wrmsrl(MSR_AMD64_LBR_SELECT, lbr_select);
+		wrmsrq(MSR_AMD64_LBR_SELECT, lbr_select);
 	}
 
 	if (cpu_feature_enabled(X86_FEATURE_AMD_LBR_PMC_FREEZE)) {
 		rdmsrq(MSR_IA32_DEBUGCTLMSR, dbg_ctl);
-		wrmsrl(MSR_IA32_DEBUGCTLMSR, dbg_ctl | DEBUGCTLMSR_FREEZE_LBRS_ON_PMI);
+		wrmsrq(MSR_IA32_DEBUGCTLMSR, dbg_ctl | DEBUGCTLMSR_FREEZE_LBRS_ON_PMI);
 	}
 
 	rdmsrq(MSR_AMD_DBG_EXTN_CFG, dbg_extn_cfg);
-	wrmsrl(MSR_AMD_DBG_EXTN_CFG, dbg_extn_cfg | DBG_EXTN_CFG_LBRV2EN);
+	wrmsrq(MSR_AMD_DBG_EXTN_CFG, dbg_extn_cfg | DBG_EXTN_CFG_LBRV2EN);
 }
 
 void amd_pmu_lbr_disable_all(void)
diff --git a/arch/x86/events/amd/uncore.c b/arch/x86/events/amd/uncore.c
index 4ddf542..2a3259d 100644
--- a/arch/x86/events/amd/uncore.c
+++ b/arch/x86/events/amd/uncore.c
@@ -121,10 +121,10 @@ static void amd_uncore_start(struct perf_event *event, int flags)
 	struct hw_perf_event *hwc = &event->hw;
 
 	if (flags & PERF_EF_RELOAD)
-		wrmsrl(hwc->event_base, (u64)local64_read(&hwc->prev_count));
+		wrmsrq(hwc->event_base, (u64)local64_read(&hwc->prev_count));
 
 	hwc->state = 0;
-	wrmsrl(hwc->config_base, (hwc->config | ARCH_PERFMON_EVENTSEL_ENABLE));
+	wrmsrq(hwc->config_base, (hwc->config | ARCH_PERFMON_EVENTSEL_ENABLE));
 	perf_event_update_userpage(event);
 }
 
@@ -132,7 +132,7 @@ static void amd_uncore_stop(struct perf_event *event, int flags)
 {
 	struct hw_perf_event *hwc = &event->hw;
 
-	wrmsrl(hwc->config_base, hwc->config);
+	wrmsrq(hwc->config_base, hwc->config);
 	hwc->state |= PERF_HES_STOPPED;
 
 	if ((flags & PERF_EF_UPDATE) && !(hwc->state & PERF_HES_UPTODATE)) {
@@ -883,10 +883,10 @@ static void amd_uncore_umc_start(struct perf_event *event, int flags)
 	struct hw_perf_event *hwc = &event->hw;
 
 	if (flags & PERF_EF_RELOAD)
-		wrmsrl(hwc->event_base, (u64)local64_read(&hwc->prev_count));
+		wrmsrq(hwc->event_base, (u64)local64_read(&hwc->prev_count));
 
 	hwc->state = 0;
-	wrmsrl(hwc->config_base, (hwc->config | AMD64_PERFMON_V2_ENABLE_UMC));
+	wrmsrq(hwc->config_base, (hwc->config | AMD64_PERFMON_V2_ENABLE_UMC));
 	perf_event_update_userpage(event);
 }
 
diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
index a27f2e6..0a16d6b 100644
--- a/arch/x86/events/core.c
+++ b/arch/x86/events/core.c
@@ -697,9 +697,9 @@ void x86_pmu_disable_all(void)
 		if (!(val & ARCH_PERFMON_EVENTSEL_ENABLE))
 			continue;
 		val &= ~ARCH_PERFMON_EVENTSEL_ENABLE;
-		wrmsrl(x86_pmu_config_addr(idx), val);
+		wrmsrq(x86_pmu_config_addr(idx), val);
 		if (is_counter_pair(hwc))
-			wrmsrl(x86_pmu_config_addr(idx + 1), 0);
+			wrmsrq(x86_pmu_config_addr(idx + 1), 0);
 	}
 }
 
@@ -1420,14 +1420,14 @@ int x86_perf_event_set_period(struct perf_event *event)
 	 */
 	local64_set(&hwc->prev_count, (u64)-left);
 
-	wrmsrl(hwc->event_base, (u64)(-left) & x86_pmu.cntval_mask);
+	wrmsrq(hwc->event_base, (u64)(-left) & x86_pmu.cntval_mask);
 
 	/*
 	 * Sign extend the Merge event counter's upper 16 bits since
 	 * we currently declare a 48-bit counter width
 	 */
 	if (is_counter_pair(hwc))
-		wrmsrl(x86_pmu_event_addr(idx + 1), 0xffff);
+		wrmsrq(x86_pmu_event_addr(idx + 1), 0xffff);
 
 	perf_event_update_userpage(event);
 
@@ -2496,9 +2496,9 @@ void perf_clear_dirty_counters(void)
 			if (!test_bit(i - INTEL_PMC_IDX_FIXED, hybrid(cpuc->pmu, fixed_cntr_mask)))
 				continue;
 
-			wrmsrl(x86_pmu_fixed_ctr_addr(i - INTEL_PMC_IDX_FIXED), 0);
+			wrmsrq(x86_pmu_fixed_ctr_addr(i - INTEL_PMC_IDX_FIXED), 0);
 		} else {
-			wrmsrl(x86_pmu_event_addr(i), 0);
+			wrmsrq(x86_pmu_event_addr(i), 0);
 		}
 	}
 
diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index 852b1ea..3f46737 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -2285,7 +2285,7 @@ static __always_inline void __intel_pmu_disable_all(bool bts)
 {
 	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
 
-	wrmsrl(MSR_CORE_PERF_GLOBAL_CTRL, 0);
+	wrmsrq(MSR_CORE_PERF_GLOBAL_CTRL, 0);
 
 	if (bts && test_bit(INTEL_PMC_IDX_FIXED_BTS, cpuc->active_mask))
 		intel_pmu_disable_bts();
@@ -2306,11 +2306,11 @@ static void __intel_pmu_enable_all(int added, bool pmi)
 	intel_pmu_lbr_enable_all(pmi);
 
 	if (cpuc->fixed_ctrl_val != cpuc->active_fixed_ctrl_val) {
-		wrmsrl(MSR_ARCH_PERFMON_FIXED_CTR_CTRL, cpuc->fixed_ctrl_val);
+		wrmsrq(MSR_ARCH_PERFMON_FIXED_CTR_CTRL, cpuc->fixed_ctrl_val);
 		cpuc->active_fixed_ctrl_val = cpuc->fixed_ctrl_val;
 	}
 
-	wrmsrl(MSR_CORE_PERF_GLOBAL_CTRL,
+	wrmsrq(MSR_CORE_PERF_GLOBAL_CTRL,
 	       intel_ctrl & ~cpuc->intel_ctrl_guest_mask);
 
 	if (test_bit(INTEL_PMC_IDX_FIXED_BTS, cpuc->active_mask)) {
@@ -2426,12 +2426,12 @@ static void intel_pmu_nhm_workaround(void)
 	}
 
 	for (i = 0; i < 4; i++) {
-		wrmsrl(MSR_ARCH_PERFMON_EVENTSEL0 + i, nhm_magic[i]);
-		wrmsrl(MSR_ARCH_PERFMON_PERFCTR0 + i, 0x0);
+		wrmsrq(MSR_ARCH_PERFMON_EVENTSEL0 + i, nhm_magic[i]);
+		wrmsrq(MSR_ARCH_PERFMON_PERFCTR0 + i, 0x0);
 	}
 
-	wrmsrl(MSR_CORE_PERF_GLOBAL_CTRL, 0xf);
-	wrmsrl(MSR_CORE_PERF_GLOBAL_CTRL, 0x0);
+	wrmsrq(MSR_CORE_PERF_GLOBAL_CTRL, 0xf);
+	wrmsrq(MSR_CORE_PERF_GLOBAL_CTRL, 0x0);
 
 	for (i = 0; i < 4; i++) {
 		event = cpuc->events[i];
@@ -2441,7 +2441,7 @@ static void intel_pmu_nhm_workaround(void)
 			__x86_pmu_enable_event(&event->hw,
 					ARCH_PERFMON_EVENTSEL_ENABLE);
 		} else
-			wrmsrl(MSR_ARCH_PERFMON_EVENTSEL0 + i, 0x0);
+			wrmsrq(MSR_ARCH_PERFMON_EVENTSEL0 + i, 0x0);
 	}
 }
 
@@ -2458,7 +2458,7 @@ static void intel_set_tfa(struct cpu_hw_events *cpuc, bool on)
 
 	if (cpuc->tfa_shadow != val) {
 		cpuc->tfa_shadow = val;
-		wrmsrl(MSR_TSX_FORCE_ABORT, val);
+		wrmsrq(MSR_TSX_FORCE_ABORT, val);
 	}
 }
 
@@ -2496,7 +2496,7 @@ static inline u64 intel_pmu_get_status(void)
 
 static inline void intel_pmu_ack_status(u64 ack)
 {
-	wrmsrl(MSR_CORE_PERF_GLOBAL_OVF_CTRL, ack);
+	wrmsrq(MSR_CORE_PERF_GLOBAL_OVF_CTRL, ack);
 }
 
 static inline bool event_is_checkpointed(struct perf_event *event)
@@ -2619,15 +2619,15 @@ static int icl_set_topdown_event_period(struct perf_event *event)
 	 * Don't need to clear them again.
 	 */
 	if (left == x86_pmu.max_period) {
-		wrmsrl(MSR_CORE_PERF_FIXED_CTR3, 0);
-		wrmsrl(MSR_PERF_METRICS, 0);
+		wrmsrq(MSR_CORE_PERF_FIXED_CTR3, 0);
+		wrmsrq(MSR_PERF_METRICS, 0);
 		hwc->saved_slots = 0;
 		hwc->saved_metric = 0;
 	}
 
 	if ((hwc->saved_slots) && is_slots_event(event)) {
-		wrmsrl(MSR_CORE_PERF_FIXED_CTR3, hwc->saved_slots);
-		wrmsrl(MSR_PERF_METRICS, hwc->saved_metric);
+		wrmsrq(MSR_CORE_PERF_FIXED_CTR3, hwc->saved_slots);
+		wrmsrq(MSR_PERF_METRICS, hwc->saved_metric);
 	}
 
 	perf_event_update_userpage(event);
@@ -2773,8 +2773,8 @@ static u64 intel_update_topdown_event(struct perf_event *event, int metric_end, 
 
 	if (reset) {
 		/* The fixed counter 3 has to be written before the PERF_METRICS. */
-		wrmsrl(MSR_CORE_PERF_FIXED_CTR3, 0);
-		wrmsrl(MSR_PERF_METRICS, 0);
+		wrmsrq(MSR_CORE_PERF_FIXED_CTR3, 0);
+		wrmsrq(MSR_PERF_METRICS, 0);
 		if (event)
 			update_saved_topdown_regs(event, 0, 0, metric_end);
 	}
@@ -2937,7 +2937,7 @@ int intel_pmu_save_and_restart(struct perf_event *event)
 	 */
 	if (unlikely(event_is_checkpointed(event))) {
 		/* No race with NMIs because the counter should not be armed */
-		wrmsrl(event->hw.event_base, 0);
+		wrmsrq(event->hw.event_base, 0);
 		local64_set(&event->hw.prev_count, 0);
 	}
 	return static_call(x86_pmu_set_period)(event);
@@ -2991,7 +2991,7 @@ static void intel_pmu_reset(void)
 	/* Ack all overflows and disable fixed counters */
 	if (x86_pmu.version >= 2) {
 		intel_pmu_ack_status(intel_pmu_get_status());
-		wrmsrl(MSR_CORE_PERF_GLOBAL_CTRL, 0);
+		wrmsrq(MSR_CORE_PERF_GLOBAL_CTRL, 0);
 	}
 
 	/* Reset LBRs and LBR freezing */
@@ -3103,7 +3103,7 @@ static int handle_pmi_common(struct pt_regs *regs, u64 status)
 		 * Update the MSR if pebs_enabled is changed.
 		 */
 		if (pebs_enabled != cpuc->pebs_enabled)
-			wrmsrl(MSR_IA32_PEBS_ENABLE, cpuc->pebs_enabled);
+			wrmsrq(MSR_IA32_PEBS_ENABLE, cpuc->pebs_enabled);
 	}
 
 	/*
@@ -5614,7 +5614,7 @@ static bool check_msr(unsigned long msr, u64 mask)
 		return false;
 
 	/*
-	 * Only change the bits which can be updated by wrmsrl.
+	 * Only change the bits which can be updated by wrmsrq.
 	 */
 	val_tmp = val_old ^ mask;
 
@@ -5626,7 +5626,7 @@ static bool check_msr(unsigned long msr, u64 mask)
 		return false;
 
 	/*
-	 * Quirk only affects validation in wrmsr(), so wrmsrl()'s value
+	 * Quirk only affects validation in wrmsr(), so wrmsrq()'s value
 	 * should equal rdmsrq()'s even with the quirk.
 	 */
 	if (val_new != val_tmp)
@@ -5638,7 +5638,7 @@ static bool check_msr(unsigned long msr, u64 mask)
 	/* Here it's sure that the MSR can be safely accessed.
 	 * Restore the old value and return.
 	 */
-	wrmsrl(msr, val_old);
+	wrmsrq(msr, val_old);
 
 	return true;
 }
diff --git a/arch/x86/events/intel/ds.c b/arch/x86/events/intel/ds.c
index 1f7e1a6..410a897 100644
--- a/arch/x86/events/intel/ds.c
+++ b/arch/x86/events/intel/ds.c
@@ -1515,7 +1515,7 @@ static void intel_pmu_pebs_via_pt_enable(struct perf_event *event)
 		else
 			value = ds->pebs_event_reset[MAX_PEBS_EVENTS + idx];
 	}
-	wrmsrl(base + idx, value);
+	wrmsrq(base + idx, value);
 }
 
 static inline void intel_pmu_drain_large_pebs(struct cpu_hw_events *cpuc)
@@ -1552,7 +1552,7 @@ void intel_pmu_pebs_enable(struct perf_event *event)
 			 */
 			intel_pmu_drain_pebs_buffer();
 			adaptive_pebs_record_size_update();
-			wrmsrl(MSR_PEBS_DATA_CFG, pebs_data_cfg);
+			wrmsrq(MSR_PEBS_DATA_CFG, pebs_data_cfg);
 			cpuc->active_pebs_data_cfg = pebs_data_cfg;
 		}
 	}
@@ -1615,7 +1615,7 @@ void intel_pmu_pebs_disable(struct perf_event *event)
 	intel_pmu_pebs_via_pt_disable(event);
 
 	if (cpuc->enabled)
-		wrmsrl(MSR_IA32_PEBS_ENABLE, cpuc->pebs_enabled);
+		wrmsrq(MSR_IA32_PEBS_ENABLE, cpuc->pebs_enabled);
 
 	hwc->config |= ARCH_PERFMON_EVENTSEL_INT;
 }
@@ -1625,7 +1625,7 @@ void intel_pmu_pebs_enable_all(void)
 	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
 
 	if (cpuc->pebs_enabled)
-		wrmsrl(MSR_IA32_PEBS_ENABLE, cpuc->pebs_enabled);
+		wrmsrq(MSR_IA32_PEBS_ENABLE, cpuc->pebs_enabled);
 }
 
 void intel_pmu_pebs_disable_all(void)
@@ -2771,5 +2771,5 @@ void perf_restore_debug_store(void)
 	if (!x86_pmu.bts && !x86_pmu.pebs)
 		return;
 
-	wrmsrl(MSR_IA32_DS_AREA, (unsigned long)ds);
+	wrmsrq(MSR_IA32_DS_AREA, (unsigned long)ds);
 }
diff --git a/arch/x86/events/intel/knc.c b/arch/x86/events/intel/knc.c
index 0ee32a0..afb7801 100644
--- a/arch/x86/events/intel/knc.c
+++ b/arch/x86/events/intel/knc.c
@@ -161,7 +161,7 @@ static void knc_pmu_disable_all(void)
 
 	rdmsrq(MSR_KNC_IA32_PERF_GLOBAL_CTRL, val);
 	val &= ~(KNC_ENABLE_COUNTER0|KNC_ENABLE_COUNTER1);
-	wrmsrl(MSR_KNC_IA32_PERF_GLOBAL_CTRL, val);
+	wrmsrq(MSR_KNC_IA32_PERF_GLOBAL_CTRL, val);
 }
 
 static void knc_pmu_enable_all(int added)
@@ -170,7 +170,7 @@ static void knc_pmu_enable_all(int added)
 
 	rdmsrq(MSR_KNC_IA32_PERF_GLOBAL_CTRL, val);
 	val |= (KNC_ENABLE_COUNTER0|KNC_ENABLE_COUNTER1);
-	wrmsrl(MSR_KNC_IA32_PERF_GLOBAL_CTRL, val);
+	wrmsrq(MSR_KNC_IA32_PERF_GLOBAL_CTRL, val);
 }
 
 static inline void
@@ -207,7 +207,7 @@ static inline u64 knc_pmu_get_status(void)
 
 static inline void knc_pmu_ack_status(u64 ack)
 {
-	wrmsrl(MSR_KNC_IA32_PERF_GLOBAL_OVF_CONTROL, ack);
+	wrmsrq(MSR_KNC_IA32_PERF_GLOBAL_OVF_CONTROL, ack);
 }
 
 static int knc_pmu_handle_irq(struct pt_regs *regs)
diff --git a/arch/x86/events/intel/lbr.c b/arch/x86/events/intel/lbr.c
index 2b33aac..b55c59a 100644
--- a/arch/x86/events/intel/lbr.c
+++ b/arch/x86/events/intel/lbr.c
@@ -137,7 +137,7 @@ static void __intel_pmu_lbr_enable(bool pmi)
 	if (cpuc->lbr_sel)
 		lbr_select = cpuc->lbr_sel->config & x86_pmu.lbr_sel_mask;
 	if (!static_cpu_has(X86_FEATURE_ARCH_LBR) && !pmi && cpuc->lbr_sel)
-		wrmsrl(MSR_LBR_SELECT, lbr_select);
+		wrmsrq(MSR_LBR_SELECT, lbr_select);
 
 	rdmsrq(MSR_IA32_DEBUGCTLMSR, debugctl);
 	orig_debugctl = debugctl;
@@ -155,10 +155,10 @@ static void __intel_pmu_lbr_enable(bool pmi)
 		debugctl |= DEBUGCTLMSR_FREEZE_LBRS_ON_PMI;
 
 	if (orig_debugctl != debugctl)
-		wrmsrl(MSR_IA32_DEBUGCTLMSR, debugctl);
+		wrmsrq(MSR_IA32_DEBUGCTLMSR, debugctl);
 
 	if (static_cpu_has(X86_FEATURE_ARCH_LBR))
-		wrmsrl(MSR_ARCH_LBR_CTL, lbr_select | ARCH_LBR_CTL_LBREN);
+		wrmsrq(MSR_ARCH_LBR_CTL, lbr_select | ARCH_LBR_CTL_LBREN);
 }
 
 void intel_pmu_lbr_reset_32(void)
@@ -166,7 +166,7 @@ void intel_pmu_lbr_reset_32(void)
 	int i;
 
 	for (i = 0; i < x86_pmu.lbr_nr; i++)
-		wrmsrl(x86_pmu.lbr_from + i, 0);
+		wrmsrq(x86_pmu.lbr_from + i, 0);
 }
 
 void intel_pmu_lbr_reset_64(void)
@@ -174,17 +174,17 @@ void intel_pmu_lbr_reset_64(void)
 	int i;
 
 	for (i = 0; i < x86_pmu.lbr_nr; i++) {
-		wrmsrl(x86_pmu.lbr_from + i, 0);
-		wrmsrl(x86_pmu.lbr_to   + i, 0);
+		wrmsrq(x86_pmu.lbr_from + i, 0);
+		wrmsrq(x86_pmu.lbr_to   + i, 0);
 		if (x86_pmu.lbr_has_info)
-			wrmsrl(x86_pmu.lbr_info + i, 0);
+			wrmsrq(x86_pmu.lbr_info + i, 0);
 	}
 }
 
 static void intel_pmu_arch_lbr_reset(void)
 {
 	/* Write to ARCH_LBR_DEPTH MSR, all LBR entries are reset to 0 */
-	wrmsrl(MSR_ARCH_LBR_DEPTH, x86_pmu.lbr_nr);
+	wrmsrq(MSR_ARCH_LBR_DEPTH, x86_pmu.lbr_nr);
 }
 
 void intel_pmu_lbr_reset(void)
@@ -199,7 +199,7 @@ void intel_pmu_lbr_reset(void)
 	cpuc->last_task_ctx = NULL;
 	cpuc->last_log_id = 0;
 	if (!static_cpu_has(X86_FEATURE_ARCH_LBR) && cpuc->lbr_select)
-		wrmsrl(MSR_LBR_SELECT, 0);
+		wrmsrq(MSR_LBR_SELECT, 0);
 }
 
 /*
@@ -282,17 +282,17 @@ static u64 lbr_from_signext_quirk_rd(u64 val)
 static __always_inline void wrlbr_from(unsigned int idx, u64 val)
 {
 	val = lbr_from_signext_quirk_wr(val);
-	wrmsrl(x86_pmu.lbr_from + idx, val);
+	wrmsrq(x86_pmu.lbr_from + idx, val);
 }
 
 static __always_inline void wrlbr_to(unsigned int idx, u64 val)
 {
-	wrmsrl(x86_pmu.lbr_to + idx, val);
+	wrmsrq(x86_pmu.lbr_to + idx, val);
 }
 
 static __always_inline void wrlbr_info(unsigned int idx, u64 val)
 {
-	wrmsrl(x86_pmu.lbr_info + idx, val);
+	wrmsrq(x86_pmu.lbr_info + idx, val);
 }
 
 static __always_inline u64 rdlbr_from(unsigned int idx, struct lbr_entry *lbr)
@@ -380,10 +380,10 @@ void intel_pmu_lbr_restore(void *ctx)
 			wrlbr_info(lbr_idx, 0);
 	}
 
-	wrmsrl(x86_pmu.lbr_tos, tos);
+	wrmsrq(x86_pmu.lbr_tos, tos);
 
 	if (cpuc->lbr_select)
-		wrmsrl(MSR_LBR_SELECT, task_ctx->lbr_sel);
+		wrmsrq(MSR_LBR_SELECT, task_ctx->lbr_sel);
 }
 
 static void intel_pmu_arch_lbr_restore(void *ctx)
diff --git a/arch/x86/events/intel/p4.c b/arch/x86/events/intel/p4.c
index a0eb63b..36d4cd2 100644
--- a/arch/x86/events/intel/p4.c
+++ b/arch/x86/events/intel/p4.c
@@ -861,7 +861,7 @@ static inline int p4_pmu_clear_cccr_ovf(struct hw_perf_event *hwc)
 	/* an official way for overflow indication */
 	rdmsrq(hwc->config_base, v);
 	if (v & P4_CCCR_OVF) {
-		wrmsrl(hwc->config_base, v & ~P4_CCCR_OVF);
+		wrmsrq(hwc->config_base, v & ~P4_CCCR_OVF);
 		return 1;
 	}
 
@@ -1024,7 +1024,7 @@ static int p4_pmu_set_period(struct perf_event *event)
 		 *
 		 * the former idea is taken from OProfile code
 		 */
-		wrmsrl(hwc->event_base, (u64)(-left) & x86_pmu.cntval_mask);
+		wrmsrq(hwc->event_base, (u64)(-left) & x86_pmu.cntval_mask);
 	}
 
 	return ret;
diff --git a/arch/x86/events/intel/p6.c b/arch/x86/events/intel/p6.c
index 701f8a8..6a1fdbc 100644
--- a/arch/x86/events/intel/p6.c
+++ b/arch/x86/events/intel/p6.c
@@ -144,7 +144,7 @@ static void p6_pmu_disable_all(void)
 	/* p6 only has one enable register */
 	rdmsrq(MSR_P6_EVNTSEL0, val);
 	val &= ~ARCH_PERFMON_EVENTSEL_ENABLE;
-	wrmsrl(MSR_P6_EVNTSEL0, val);
+	wrmsrq(MSR_P6_EVNTSEL0, val);
 }
 
 static void p6_pmu_enable_all(int added)
@@ -154,7 +154,7 @@ static void p6_pmu_enable_all(int added)
 	/* p6 only has one enable register */
 	rdmsrq(MSR_P6_EVNTSEL0, val);
 	val |= ARCH_PERFMON_EVENTSEL_ENABLE;
-	wrmsrl(MSR_P6_EVNTSEL0, val);
+	wrmsrq(MSR_P6_EVNTSEL0, val);
 }
 
 static inline void
diff --git a/arch/x86/events/intel/pt.c b/arch/x86/events/intel/pt.c
index b8212d8..a645b09 100644
--- a/arch/x86/events/intel/pt.c
+++ b/arch/x86/events/intel/pt.c
@@ -426,7 +426,7 @@ static void pt_config_start(struct perf_event *event)
 	if (READ_ONCE(pt->vmx_on))
 		perf_aux_output_flag(&pt->handle, PERF_AUX_FLAG_PARTIAL);
 	else
-		wrmsrl(MSR_IA32_RTIT_CTL, ctl);
+		wrmsrq(MSR_IA32_RTIT_CTL, ctl);
 
 	WRITE_ONCE(event->hw.aux_config, ctl);
 }
@@ -485,12 +485,12 @@ static u64 pt_config_filters(struct perf_event *event)
 
 		/* avoid redundant msr writes */
 		if (pt->filters.filter[range].msr_a != filter->msr_a) {
-			wrmsrl(pt_address_ranges[range].msr_a, filter->msr_a);
+			wrmsrq(pt_address_ranges[range].msr_a, filter->msr_a);
 			pt->filters.filter[range].msr_a = filter->msr_a;
 		}
 
 		if (pt->filters.filter[range].msr_b != filter->msr_b) {
-			wrmsrl(pt_address_ranges[range].msr_b, filter->msr_b);
+			wrmsrq(pt_address_ranges[range].msr_b, filter->msr_b);
 			pt->filters.filter[range].msr_b = filter->msr_b;
 		}
 
@@ -509,7 +509,7 @@ static void pt_config(struct perf_event *event)
 	/* First round: clear STATUS, in particular the PSB byte counter. */
 	if (!event->hw.aux_config) {
 		perf_event_itrace_started(event);
-		wrmsrl(MSR_IA32_RTIT_STATUS, 0);
+		wrmsrq(MSR_IA32_RTIT_STATUS, 0);
 	}
 
 	reg = pt_config_filters(event);
@@ -569,7 +569,7 @@ static void pt_config_stop(struct perf_event *event)
 
 	ctl &= ~RTIT_CTL_TRACEEN;
 	if (!READ_ONCE(pt->vmx_on))
-		wrmsrl(MSR_IA32_RTIT_CTL, ctl);
+		wrmsrq(MSR_IA32_RTIT_CTL, ctl);
 
 	WRITE_ONCE(event->hw.aux_config, ctl);
 
@@ -658,13 +658,13 @@ static void pt_config_buffer(struct pt_buffer *buf)
 	reg = virt_to_phys(base);
 	if (pt->output_base != reg) {
 		pt->output_base = reg;
-		wrmsrl(MSR_IA32_RTIT_OUTPUT_BASE, reg);
+		wrmsrq(MSR_IA32_RTIT_OUTPUT_BASE, reg);
 	}
 
 	reg = 0x7f | (mask << 7) | ((u64)buf->output_off << 32);
 	if (pt->output_mask != reg) {
 		pt->output_mask = reg;
-		wrmsrl(MSR_IA32_RTIT_OUTPUT_MASK, reg);
+		wrmsrq(MSR_IA32_RTIT_OUTPUT_MASK, reg);
 	}
 }
 
@@ -970,7 +970,7 @@ static void pt_handle_status(struct pt *pt)
 	if (advance)
 		pt_buffer_advance(buf);
 
-	wrmsrl(MSR_IA32_RTIT_STATUS, status);
+	wrmsrq(MSR_IA32_RTIT_STATUS, status);
 }
 
 /**
@@ -1585,7 +1585,7 @@ void intel_pt_handle_vmx(int on)
 
 	/* Turn PTs back on */
 	if (!on && event)
-		wrmsrl(MSR_IA32_RTIT_CTL, event->hw.aux_config);
+		wrmsrq(MSR_IA32_RTIT_CTL, event->hw.aux_config);
 
 	local_irq_restore(flags);
 }
diff --git a/arch/x86/events/intel/uncore_discovery.c b/arch/x86/events/intel/uncore_discovery.c
index 571e44b..4fc3eec 100644
--- a/arch/x86/events/intel/uncore_discovery.c
+++ b/arch/x86/events/intel/uncore_discovery.c
@@ -441,17 +441,17 @@ static u64 intel_generic_uncore_box_ctl(struct intel_uncore_box *box)
 
 void intel_generic_uncore_msr_init_box(struct intel_uncore_box *box)
 {
-	wrmsrl(intel_generic_uncore_box_ctl(box), GENERIC_PMON_BOX_CTL_INT);
+	wrmsrq(intel_generic_uncore_box_ctl(box), GENERIC_PMON_BOX_CTL_INT);
 }
 
 void intel_generic_uncore_msr_disable_box(struct intel_uncore_box *box)
 {
-	wrmsrl(intel_generic_uncore_box_ctl(box), GENERIC_PMON_BOX_CTL_FRZ);
+	wrmsrq(intel_generic_uncore_box_ctl(box), GENERIC_PMON_BOX_CTL_FRZ);
 }
 
 void intel_generic_uncore_msr_enable_box(struct intel_uncore_box *box)
 {
-	wrmsrl(intel_generic_uncore_box_ctl(box), 0);
+	wrmsrq(intel_generic_uncore_box_ctl(box), 0);
 }
 
 static void intel_generic_uncore_msr_enable_event(struct intel_uncore_box *box,
@@ -459,7 +459,7 @@ static void intel_generic_uncore_msr_enable_event(struct intel_uncore_box *box,
 {
 	struct hw_perf_event *hwc = &event->hw;
 
-	wrmsrl(hwc->config_base, hwc->config);
+	wrmsrq(hwc->config_base, hwc->config);
 }
 
 static void intel_generic_uncore_msr_disable_event(struct intel_uncore_box *box,
@@ -467,7 +467,7 @@ static void intel_generic_uncore_msr_disable_event(struct intel_uncore_box *box,
 {
 	struct hw_perf_event *hwc = &event->hw;
 
-	wrmsrl(hwc->config_base, 0);
+	wrmsrq(hwc->config_base, 0);
 }
 
 static struct intel_uncore_ops generic_uncore_msr_ops = {
diff --git a/arch/x86/events/intel/uncore_nhmex.c b/arch/x86/events/intel/uncore_nhmex.c
index e6fccad..bef9c78 100644
--- a/arch/x86/events/intel/uncore_nhmex.c
+++ b/arch/x86/events/intel/uncore_nhmex.c
@@ -200,12 +200,12 @@ DEFINE_UNCORE_FORMAT_ATTR(mask, mask, "config2:0-63");
 
 static void nhmex_uncore_msr_init_box(struct intel_uncore_box *box)
 {
-	wrmsrl(NHMEX_U_MSR_PMON_GLOBAL_CTL, NHMEX_U_PMON_GLOBAL_EN_ALL);
+	wrmsrq(NHMEX_U_MSR_PMON_GLOBAL_CTL, NHMEX_U_PMON_GLOBAL_EN_ALL);
 }
 
 static void nhmex_uncore_msr_exit_box(struct intel_uncore_box *box)
 {
-	wrmsrl(NHMEX_U_MSR_PMON_GLOBAL_CTL, 0);
+	wrmsrq(NHMEX_U_MSR_PMON_GLOBAL_CTL, 0);
 }
 
 static void nhmex_uncore_msr_disable_box(struct intel_uncore_box *box)
@@ -219,7 +219,7 @@ static void nhmex_uncore_msr_disable_box(struct intel_uncore_box *box)
 		/* WBox has a fixed counter */
 		if (uncore_msr_fixed_ctl(box))
 			config &= ~NHMEX_W_PMON_GLOBAL_FIXED_EN;
-		wrmsrl(msr, config);
+		wrmsrq(msr, config);
 	}
 }
 
@@ -234,13 +234,13 @@ static void nhmex_uncore_msr_enable_box(struct intel_uncore_box *box)
 		/* WBox has a fixed counter */
 		if (uncore_msr_fixed_ctl(box))
 			config |= NHMEX_W_PMON_GLOBAL_FIXED_EN;
-		wrmsrl(msr, config);
+		wrmsrq(msr, config);
 	}
 }
 
 static void nhmex_uncore_msr_disable_event(struct intel_uncore_box *box, struct perf_event *event)
 {
-	wrmsrl(event->hw.config_base, 0);
+	wrmsrq(event->hw.config_base, 0);
 }
 
 static void nhmex_uncore_msr_enable_event(struct intel_uncore_box *box, struct perf_event *event)
@@ -248,11 +248,11 @@ static void nhmex_uncore_msr_enable_event(struct intel_uncore_box *box, struct p
 	struct hw_perf_event *hwc = &event->hw;
 
 	if (hwc->idx == UNCORE_PMC_IDX_FIXED)
-		wrmsrl(hwc->config_base, NHMEX_PMON_CTL_EN_BIT0);
+		wrmsrq(hwc->config_base, NHMEX_PMON_CTL_EN_BIT0);
 	else if (box->pmu->type->event_mask & NHMEX_PMON_CTL_EN_BIT0)
-		wrmsrl(hwc->config_base, hwc->config | NHMEX_PMON_CTL_EN_BIT22);
+		wrmsrq(hwc->config_base, hwc->config | NHMEX_PMON_CTL_EN_BIT22);
 	else
-		wrmsrl(hwc->config_base, hwc->config | NHMEX_PMON_CTL_EN_BIT0);
+		wrmsrq(hwc->config_base, hwc->config | NHMEX_PMON_CTL_EN_BIT0);
 }
 
 #define NHMEX_UNCORE_OPS_COMMON_INIT()				\
@@ -382,10 +382,10 @@ static void nhmex_bbox_msr_enable_event(struct intel_uncore_box *box, struct per
 	struct hw_perf_event_extra *reg2 = &hwc->branch_reg;
 
 	if (reg1->idx != EXTRA_REG_NONE) {
-		wrmsrl(reg1->reg, reg1->config);
-		wrmsrl(reg1->reg + 1, reg2->config);
+		wrmsrq(reg1->reg, reg1->config);
+		wrmsrq(reg1->reg + 1, reg2->config);
 	}
-	wrmsrl(hwc->config_base, NHMEX_PMON_CTL_EN_BIT0 |
+	wrmsrq(hwc->config_base, NHMEX_PMON_CTL_EN_BIT0 |
 		(hwc->config & NHMEX_B_PMON_CTL_EV_SEL_MASK));
 }
 
@@ -467,12 +467,12 @@ static void nhmex_sbox_msr_enable_event(struct intel_uncore_box *box, struct per
 	struct hw_perf_event_extra *reg2 = &hwc->branch_reg;
 
 	if (reg1->idx != EXTRA_REG_NONE) {
-		wrmsrl(reg1->reg, 0);
-		wrmsrl(reg1->reg + 1, reg1->config);
-		wrmsrl(reg1->reg + 2, reg2->config);
-		wrmsrl(reg1->reg, NHMEX_S_PMON_MM_CFG_EN);
+		wrmsrq(reg1->reg, 0);
+		wrmsrq(reg1->reg + 1, reg1->config);
+		wrmsrq(reg1->reg + 2, reg2->config);
+		wrmsrq(reg1->reg, NHMEX_S_PMON_MM_CFG_EN);
 	}
-	wrmsrl(hwc->config_base, hwc->config | NHMEX_PMON_CTL_EN_BIT22);
+	wrmsrq(hwc->config_base, hwc->config | NHMEX_PMON_CTL_EN_BIT22);
 }
 
 static struct attribute *nhmex_uncore_sbox_formats_attr[] = {
@@ -842,25 +842,25 @@ static void nhmex_mbox_msr_enable_event(struct intel_uncore_box *box, struct per
 
 	idx = __BITS_VALUE(reg1->idx, 0, 8);
 	if (idx != 0xff)
-		wrmsrl(__BITS_VALUE(reg1->reg, 0, 16),
+		wrmsrq(__BITS_VALUE(reg1->reg, 0, 16),
 			nhmex_mbox_shared_reg_config(box, idx));
 	idx = __BITS_VALUE(reg1->idx, 1, 8);
 	if (idx != 0xff)
-		wrmsrl(__BITS_VALUE(reg1->reg, 1, 16),
+		wrmsrq(__BITS_VALUE(reg1->reg, 1, 16),
 			nhmex_mbox_shared_reg_config(box, idx));
 
 	if (reg2->idx != EXTRA_REG_NONE) {
-		wrmsrl(reg2->reg, 0);
+		wrmsrq(reg2->reg, 0);
 		if (reg2->config != ~0ULL) {
-			wrmsrl(reg2->reg + 1,
+			wrmsrq(reg2->reg + 1,
 				reg2->config & NHMEX_M_PMON_ADDR_MATCH_MASK);
-			wrmsrl(reg2->reg + 2, NHMEX_M_PMON_ADDR_MASK_MASK &
+			wrmsrq(reg2->reg + 2, NHMEX_M_PMON_ADDR_MASK_MASK &
 				(reg2->config >> NHMEX_M_PMON_ADDR_MASK_SHIFT));
-			wrmsrl(reg2->reg, NHMEX_M_PMON_MM_CFG_EN);
+			wrmsrq(reg2->reg, NHMEX_M_PMON_MM_CFG_EN);
 		}
 	}
 
-	wrmsrl(hwc->config_base, hwc->config | NHMEX_PMON_CTL_EN_BIT0);
+	wrmsrq(hwc->config_base, hwc->config | NHMEX_PMON_CTL_EN_BIT0);
 }
 
 DEFINE_UNCORE_FORMAT_ATTR(count_mode,		count_mode,	"config:2-3");
@@ -1121,31 +1121,31 @@ static void nhmex_rbox_msr_enable_event(struct intel_uncore_box *box, struct per
 
 	switch (idx % 6) {
 	case 0:
-		wrmsrl(NHMEX_R_MSR_PORTN_IPERF_CFG0(port), reg1->config);
+		wrmsrq(NHMEX_R_MSR_PORTN_IPERF_CFG0(port), reg1->config);
 		break;
 	case 1:
-		wrmsrl(NHMEX_R_MSR_PORTN_IPERF_CFG1(port), reg1->config);
+		wrmsrq(NHMEX_R_MSR_PORTN_IPERF_CFG1(port), reg1->config);
 		break;
 	case 2:
 	case 3:
-		wrmsrl(NHMEX_R_MSR_PORTN_QLX_CFG(port),
+		wrmsrq(NHMEX_R_MSR_PORTN_QLX_CFG(port),
 			uncore_shared_reg_config(box, 2 + (idx / 6) * 5));
 		break;
 	case 4:
-		wrmsrl(NHMEX_R_MSR_PORTN_XBR_SET1_MM_CFG(port),
+		wrmsrq(NHMEX_R_MSR_PORTN_XBR_SET1_MM_CFG(port),
 			hwc->config >> 32);
-		wrmsrl(NHMEX_R_MSR_PORTN_XBR_SET1_MATCH(port), reg1->config);
-		wrmsrl(NHMEX_R_MSR_PORTN_XBR_SET1_MASK(port), reg2->config);
+		wrmsrq(NHMEX_R_MSR_PORTN_XBR_SET1_MATCH(port), reg1->config);
+		wrmsrq(NHMEX_R_MSR_PORTN_XBR_SET1_MASK(port), reg2->config);
 		break;
 	case 5:
-		wrmsrl(NHMEX_R_MSR_PORTN_XBR_SET2_MM_CFG(port),
+		wrmsrq(NHMEX_R_MSR_PORTN_XBR_SET2_MM_CFG(port),
 			hwc->config >> 32);
-		wrmsrl(NHMEX_R_MSR_PORTN_XBR_SET2_MATCH(port), reg1->config);
-		wrmsrl(NHMEX_R_MSR_PORTN_XBR_SET2_MASK(port), reg2->config);
+		wrmsrq(NHMEX_R_MSR_PORTN_XBR_SET2_MATCH(port), reg1->config);
+		wrmsrq(NHMEX_R_MSR_PORTN_XBR_SET2_MASK(port), reg2->config);
 		break;
 	}
 
-	wrmsrl(hwc->config_base, NHMEX_PMON_CTL_EN_BIT0 |
+	wrmsrq(hwc->config_base, NHMEX_PMON_CTL_EN_BIT0 |
 		(hwc->config & NHMEX_R_PMON_CTL_EV_SEL_MASK));
 }
 
diff --git a/arch/x86/events/intel/uncore_snb.c b/arch/x86/events/intel/uncore_snb.c
index 66dadf5..afc8ef0 100644
--- a/arch/x86/events/intel/uncore_snb.c
+++ b/arch/x86/events/intel/uncore_snb.c
@@ -260,34 +260,34 @@ static void snb_uncore_msr_enable_event(struct intel_uncore_box *box, struct per
 	struct hw_perf_event *hwc = &event->hw;
 
 	if (hwc->idx < UNCORE_PMC_IDX_FIXED)
-		wrmsrl(hwc->config_base, hwc->config | SNB_UNC_CTL_EN);
+		wrmsrq(hwc->config_base, hwc->config | SNB_UNC_CTL_EN);
 	else
-		wrmsrl(hwc->config_base, SNB_UNC_CTL_EN);
+		wrmsrq(hwc->config_base, SNB_UNC_CTL_EN);
 }
 
 static void snb_uncore_msr_disable_event(struct intel_uncore_box *box, struct perf_event *event)
 {
-	wrmsrl(event->hw.config_base, 0);
+	wrmsrq(event->hw.config_base, 0);
 }
 
 static void snb_uncore_msr_init_box(struct intel_uncore_box *box)
 {
 	if (box->pmu->pmu_idx == 0) {
-		wrmsrl(SNB_UNC_PERF_GLOBAL_CTL,
+		wrmsrq(SNB_UNC_PERF_GLOBAL_CTL,
 			SNB_UNC_GLOBAL_CTL_EN | SNB_UNC_GLOBAL_CTL_CORE_ALL);
 	}
 }
 
 static void snb_uncore_msr_enable_box(struct intel_uncore_box *box)
 {
-	wrmsrl(SNB_UNC_PERF_GLOBAL_CTL,
+	wrmsrq(SNB_UNC_PERF_GLOBAL_CTL,
 		SNB_UNC_GLOBAL_CTL_EN | SNB_UNC_GLOBAL_CTL_CORE_ALL);
 }
 
 static void snb_uncore_msr_exit_box(struct intel_uncore_box *box)
 {
 	if (box->pmu->pmu_idx == 0)
-		wrmsrl(SNB_UNC_PERF_GLOBAL_CTL, 0);
+		wrmsrq(SNB_UNC_PERF_GLOBAL_CTL, 0);
 }
 
 static struct uncore_event_desc snb_uncore_events[] = {
@@ -372,7 +372,7 @@ void snb_uncore_cpu_init(void)
 static void skl_uncore_msr_init_box(struct intel_uncore_box *box)
 {
 	if (box->pmu->pmu_idx == 0) {
-		wrmsrl(SKL_UNC_PERF_GLOBAL_CTL,
+		wrmsrq(SKL_UNC_PERF_GLOBAL_CTL,
 			SNB_UNC_GLOBAL_CTL_EN | SKL_UNC_GLOBAL_CTL_CORE_ALL);
 	}
 
@@ -383,14 +383,14 @@ static void skl_uncore_msr_init_box(struct intel_uncore_box *box)
 
 static void skl_uncore_msr_enable_box(struct intel_uncore_box *box)
 {
-	wrmsrl(SKL_UNC_PERF_GLOBAL_CTL,
+	wrmsrq(SKL_UNC_PERF_GLOBAL_CTL,
 		SNB_UNC_GLOBAL_CTL_EN | SKL_UNC_GLOBAL_CTL_CORE_ALL);
 }
 
 static void skl_uncore_msr_exit_box(struct intel_uncore_box *box)
 {
 	if (box->pmu->pmu_idx == 0)
-		wrmsrl(SKL_UNC_PERF_GLOBAL_CTL, 0);
+		wrmsrq(SKL_UNC_PERF_GLOBAL_CTL, 0);
 }
 
 static struct intel_uncore_ops skl_uncore_msr_ops = {
@@ -525,7 +525,7 @@ static struct intel_uncore_type *tgl_msr_uncores[] = {
 static void rkl_uncore_msr_init_box(struct intel_uncore_box *box)
 {
 	if (box->pmu->pmu_idx == 0)
-		wrmsrl(SKL_UNC_PERF_GLOBAL_CTL, SNB_UNC_GLOBAL_CTL_EN);
+		wrmsrq(SKL_UNC_PERF_GLOBAL_CTL, SNB_UNC_GLOBAL_CTL_EN);
 }
 
 void tgl_uncore_cpu_init(void)
@@ -541,24 +541,24 @@ void tgl_uncore_cpu_init(void)
 static void adl_uncore_msr_init_box(struct intel_uncore_box *box)
 {
 	if (box->pmu->pmu_idx == 0)
-		wrmsrl(ADL_UNC_PERF_GLOBAL_CTL, SNB_UNC_GLOBAL_CTL_EN);
+		wrmsrq(ADL_UNC_PERF_GLOBAL_CTL, SNB_UNC_GLOBAL_CTL_EN);
 }
 
 static void adl_uncore_msr_enable_box(struct intel_uncore_box *box)
 {
-	wrmsrl(ADL_UNC_PERF_GLOBAL_CTL, SNB_UNC_GLOBAL_CTL_EN);
+	wrmsrq(ADL_UNC_PERF_GLOBAL_CTL, SNB_UNC_GLOBAL_CTL_EN);
 }
 
 static void adl_uncore_msr_disable_box(struct intel_uncore_box *box)
 {
 	if (box->pmu->pmu_idx == 0)
-		wrmsrl(ADL_UNC_PERF_GLOBAL_CTL, 0);
+		wrmsrq(ADL_UNC_PERF_GLOBAL_CTL, 0);
 }
 
 static void adl_uncore_msr_exit_box(struct intel_uncore_box *box)
 {
 	if (box->pmu->pmu_idx == 0)
-		wrmsrl(ADL_UNC_PERF_GLOBAL_CTL, 0);
+		wrmsrq(ADL_UNC_PERF_GLOBAL_CTL, 0);
 }
 
 static struct intel_uncore_ops adl_uncore_msr_ops = {
@@ -691,7 +691,7 @@ static struct intel_uncore_type mtl_uncore_hac_cbox = {
 
 static void mtl_uncore_msr_init_box(struct intel_uncore_box *box)
 {
-	wrmsrl(uncore_msr_box_ctl(box), SNB_UNC_GLOBAL_CTL_EN);
+	wrmsrq(uncore_msr_box_ctl(box), SNB_UNC_GLOBAL_CTL_EN);
 }
 
 static struct intel_uncore_ops mtl_uncore_msr_ops = {
@@ -758,7 +758,7 @@ static struct intel_uncore_type *lnl_msr_uncores[] = {
 static void lnl_uncore_msr_init_box(struct intel_uncore_box *box)
 {
 	if (box->pmu->pmu_idx == 0)
-		wrmsrl(LNL_UNC_MSR_GLOBAL_CTL, SNB_UNC_GLOBAL_CTL_EN);
+		wrmsrq(LNL_UNC_MSR_GLOBAL_CTL, SNB_UNC_GLOBAL_CTL_EN);
 }
 
 static struct intel_uncore_ops lnl_uncore_msr_ops = {
@@ -1306,12 +1306,12 @@ int skl_uncore_pci_init(void)
 /* Nehalem uncore support */
 static void nhm_uncore_msr_disable_box(struct intel_uncore_box *box)
 {
-	wrmsrl(NHM_UNC_PERF_GLOBAL_CTL, 0);
+	wrmsrq(NHM_UNC_PERF_GLOBAL_CTL, 0);
 }
 
 static void nhm_uncore_msr_enable_box(struct intel_uncore_box *box)
 {
-	wrmsrl(NHM_UNC_PERF_GLOBAL_CTL, NHM_UNC_GLOBAL_CTL_EN_PC_ALL | NHM_UNC_GLOBAL_CTL_EN_FC);
+	wrmsrq(NHM_UNC_PERF_GLOBAL_CTL, NHM_UNC_GLOBAL_CTL_EN_PC_ALL | NHM_UNC_GLOBAL_CTL_EN_FC);
 }
 
 static void nhm_uncore_msr_enable_event(struct intel_uncore_box *box, struct perf_event *event)
@@ -1319,9 +1319,9 @@ static void nhm_uncore_msr_enable_event(struct intel_uncore_box *box, struct per
 	struct hw_perf_event *hwc = &event->hw;
 
 	if (hwc->idx < UNCORE_PMC_IDX_FIXED)
-		wrmsrl(hwc->config_base, hwc->config | SNB_UNC_CTL_EN);
+		wrmsrq(hwc->config_base, hwc->config | SNB_UNC_CTL_EN);
 	else
-		wrmsrl(hwc->config_base, NHM_UNC_FIXED_CTR_CTL_EN);
+		wrmsrq(hwc->config_base, NHM_UNC_FIXED_CTR_CTL_EN);
 }
 
 static struct attribute *nhm_uncore_formats_attr[] = {
diff --git a/arch/x86/events/intel/uncore_snbep.c b/arch/x86/events/intel/uncore_snbep.c
index e498485..756dd11 100644
--- a/arch/x86/events/intel/uncore_snbep.c
+++ b/arch/x86/events/intel/uncore_snbep.c
@@ -620,7 +620,7 @@ static void snbep_uncore_msr_disable_box(struct intel_uncore_box *box)
 	if (msr) {
 		rdmsrq(msr, config);
 		config |= SNBEP_PMON_BOX_CTL_FRZ;
-		wrmsrl(msr, config);
+		wrmsrq(msr, config);
 	}
 }
 
@@ -633,7 +633,7 @@ static void snbep_uncore_msr_enable_box(struct intel_uncore_box *box)
 	if (msr) {
 		rdmsrq(msr, config);
 		config &= ~SNBEP_PMON_BOX_CTL_FRZ;
-		wrmsrl(msr, config);
+		wrmsrq(msr, config);
 	}
 }
 
@@ -643,9 +643,9 @@ static void snbep_uncore_msr_enable_event(struct intel_uncore_box *box, struct p
 	struct hw_perf_event_extra *reg1 = &hwc->extra_reg;
 
 	if (reg1->idx != EXTRA_REG_NONE)
-		wrmsrl(reg1->reg, uncore_shared_reg_config(box, 0));
+		wrmsrq(reg1->reg, uncore_shared_reg_config(box, 0));
 
-	wrmsrl(hwc->config_base, hwc->config | SNBEP_PMON_CTL_EN);
+	wrmsrq(hwc->config_base, hwc->config | SNBEP_PMON_CTL_EN);
 }
 
 static void snbep_uncore_msr_disable_event(struct intel_uncore_box *box,
@@ -653,7 +653,7 @@ static void snbep_uncore_msr_disable_event(struct intel_uncore_box *box,
 {
 	struct hw_perf_event *hwc = &event->hw;
 
-	wrmsrl(hwc->config_base, hwc->config);
+	wrmsrq(hwc->config_base, hwc->config);
 }
 
 static void snbep_uncore_msr_init_box(struct intel_uncore_box *box)
@@ -661,7 +661,7 @@ static void snbep_uncore_msr_init_box(struct intel_uncore_box *box)
 	unsigned msr = uncore_msr_box_ctl(box);
 
 	if (msr)
-		wrmsrl(msr, SNBEP_PMON_BOX_CTL_INT);
+		wrmsrq(msr, SNBEP_PMON_BOX_CTL_INT);
 }
 
 static struct attribute *snbep_uncore_formats_attr[] = {
@@ -1532,7 +1532,7 @@ static void ivbep_uncore_msr_init_box(struct intel_uncore_box *box)
 {
 	unsigned msr = uncore_msr_box_ctl(box);
 	if (msr)
-		wrmsrl(msr, IVBEP_PMON_BOX_CTL_INT);
+		wrmsrq(msr, IVBEP_PMON_BOX_CTL_INT);
 }
 
 static void ivbep_uncore_pci_init_box(struct intel_uncore_box *box)
@@ -1783,11 +1783,11 @@ static void ivbep_cbox_enable_event(struct intel_uncore_box *box, struct perf_ev
 
 	if (reg1->idx != EXTRA_REG_NONE) {
 		u64 filter = uncore_shared_reg_config(box, 0);
-		wrmsrl(reg1->reg, filter & 0xffffffff);
-		wrmsrl(reg1->reg + 6, filter >> 32);
+		wrmsrq(reg1->reg, filter & 0xffffffff);
+		wrmsrq(reg1->reg + 6, filter >> 32);
 	}
 
-	wrmsrl(hwc->config_base, hwc->config | SNBEP_PMON_CTL_EN);
+	wrmsrq(hwc->config_base, hwc->config | SNBEP_PMON_CTL_EN);
 }
 
 static struct intel_uncore_ops ivbep_uncore_cbox_ops = {
@@ -2767,11 +2767,11 @@ static void hswep_cbox_enable_event(struct intel_uncore_box *box,
 
 	if (reg1->idx != EXTRA_REG_NONE) {
 		u64 filter = uncore_shared_reg_config(box, 0);
-		wrmsrl(reg1->reg, filter & 0xffffffff);
-		wrmsrl(reg1->reg + 1, filter >> 32);
+		wrmsrq(reg1->reg, filter & 0xffffffff);
+		wrmsrq(reg1->reg + 1, filter >> 32);
 	}
 
-	wrmsrl(hwc->config_base, hwc->config | SNBEP_PMON_CTL_EN);
+	wrmsrq(hwc->config_base, hwc->config | SNBEP_PMON_CTL_EN);
 }
 
 static struct intel_uncore_ops hswep_uncore_cbox_ops = {
@@ -2816,7 +2816,7 @@ static void hswep_uncore_sbox_msr_init_box(struct intel_uncore_box *box)
 
 		for_each_set_bit(i, (unsigned long *)&init, 64) {
 			flags |= (1ULL << i);
-			wrmsrl(msr, flags);
+			wrmsrq(msr, flags);
 		}
 	}
 }
@@ -3708,7 +3708,7 @@ static void skx_iio_enable_event(struct intel_uncore_box *box,
 {
 	struct hw_perf_event *hwc = &event->hw;
 
-	wrmsrl(hwc->config_base, hwc->config | SNBEP_PMON_CTL_EN);
+	wrmsrq(hwc->config_base, hwc->config | SNBEP_PMON_CTL_EN);
 }
 
 static struct intel_uncore_ops skx_uncore_iio_ops = {
@@ -4655,9 +4655,9 @@ static void snr_cha_enable_event(struct intel_uncore_box *box,
 	struct hw_perf_event_extra *reg1 = &hwc->extra_reg;
 
 	if (reg1->idx != EXTRA_REG_NONE)
-		wrmsrl(reg1->reg, reg1->config);
+		wrmsrq(reg1->reg, reg1->config);
 
-	wrmsrl(hwc->config_base, hwc->config | SNBEP_PMON_CTL_EN);
+	wrmsrq(hwc->config_base, hwc->config | SNBEP_PMON_CTL_EN);
 }
 
 static struct intel_uncore_ops snr_uncore_chabox_ops = {
@@ -5913,9 +5913,9 @@ static void spr_uncore_msr_enable_event(struct intel_uncore_box *box,
 	struct hw_perf_event_extra *reg1 = &hwc->extra_reg;
 
 	if (reg1->idx != EXTRA_REG_NONE)
-		wrmsrl(reg1->reg, reg1->config);
+		wrmsrq(reg1->reg, reg1->config);
 
-	wrmsrl(hwc->config_base, hwc->config);
+	wrmsrq(hwc->config_base, hwc->config);
 }
 
 static void spr_uncore_msr_disable_event(struct intel_uncore_box *box,
@@ -5925,9 +5925,9 @@ static void spr_uncore_msr_disable_event(struct intel_uncore_box *box,
 	struct hw_perf_event_extra *reg1 = &hwc->extra_reg;
 
 	if (reg1->idx != EXTRA_REG_NONE)
-		wrmsrl(reg1->reg, 0);
+		wrmsrq(reg1->reg, 0);
 
-	wrmsrl(hwc->config_base, 0);
+	wrmsrq(hwc->config_base, 0);
 }
 
 static int spr_cha_hw_config(struct intel_uncore_box *box, struct perf_event *event)
diff --git a/arch/x86/events/perf_event.h b/arch/x86/events/perf_event.h
index 34b6d35..a5166fa 100644
--- a/arch/x86/events/perf_event.h
+++ b/arch/x86/events/perf_event.h
@@ -1198,16 +1198,16 @@ static inline void __x86_pmu_enable_event(struct hw_perf_event *hwc,
 	u64 disable_mask = __this_cpu_read(cpu_hw_events.perf_ctr_virt_mask);
 
 	if (hwc->extra_reg.reg)
-		wrmsrl(hwc->extra_reg.reg, hwc->extra_reg.config);
+		wrmsrq(hwc->extra_reg.reg, hwc->extra_reg.config);
 
 	/*
 	 * Add enabled Merge event on next counter
 	 * if large increment event being enabled on this counter
 	 */
 	if (is_counter_pair(hwc))
-		wrmsrl(x86_pmu_config_addr(hwc->idx + 1), x86_pmu.perf_ctr_pair_en);
+		wrmsrq(x86_pmu_config_addr(hwc->idx + 1), x86_pmu.perf_ctr_pair_en);
 
-	wrmsrl(hwc->config_base, (hwc->config | enable_mask) & ~disable_mask);
+	wrmsrq(hwc->config_base, (hwc->config | enable_mask) & ~disable_mask);
 }
 
 void x86_pmu_enable_all(int added);
@@ -1223,10 +1223,10 @@ static inline void x86_pmu_disable_event(struct perf_event *event)
 	u64 disable_mask = __this_cpu_read(cpu_hw_events.perf_ctr_virt_mask);
 	struct hw_perf_event *hwc = &event->hw;
 
-	wrmsrl(hwc->config_base, hwc->config & ~disable_mask);
+	wrmsrq(hwc->config_base, hwc->config & ~disable_mask);
 
 	if (is_counter_pair(hwc))
-		wrmsrl(x86_pmu_config_addr(hwc->idx + 1), 0);
+		wrmsrq(x86_pmu_config_addr(hwc->idx + 1), 0);
 }
 
 void x86_pmu_enable_event(struct perf_event *event);
@@ -1395,11 +1395,11 @@ static __always_inline void __amd_pmu_lbr_disable(void)
 	u64 dbg_ctl, dbg_extn_cfg;
 
 	rdmsrq(MSR_AMD_DBG_EXTN_CFG, dbg_extn_cfg);
-	wrmsrl(MSR_AMD_DBG_EXTN_CFG, dbg_extn_cfg & ~DBG_EXTN_CFG_LBRV2EN);
+	wrmsrq(MSR_AMD_DBG_EXTN_CFG, dbg_extn_cfg & ~DBG_EXTN_CFG_LBRV2EN);
 
 	if (cpu_feature_enabled(X86_FEATURE_AMD_LBR_PMC_FREEZE)) {
 		rdmsrq(MSR_IA32_DEBUGCTLMSR, dbg_ctl);
-		wrmsrl(MSR_IA32_DEBUGCTLMSR, dbg_ctl & ~DEBUGCTLMSR_FREEZE_LBRS_ON_PMI);
+		wrmsrq(MSR_IA32_DEBUGCTLMSR, dbg_ctl & ~DEBUGCTLMSR_FREEZE_LBRS_ON_PMI);
 	}
 }
 
@@ -1531,12 +1531,12 @@ static inline bool intel_pmu_has_bts(struct perf_event *event)
 
 static __always_inline void __intel_pmu_pebs_disable_all(void)
 {
-	wrmsrl(MSR_IA32_PEBS_ENABLE, 0);
+	wrmsrq(MSR_IA32_PEBS_ENABLE, 0);
 }
 
 static __always_inline void __intel_pmu_arch_lbr_disable(void)
 {
-	wrmsrl(MSR_ARCH_LBR_CTL, 0);
+	wrmsrq(MSR_ARCH_LBR_CTL, 0);
 }
 
 static __always_inline void __intel_pmu_lbr_disable(void)
@@ -1545,7 +1545,7 @@ static __always_inline void __intel_pmu_lbr_disable(void)
 
 	rdmsrq(MSR_IA32_DEBUGCTLMSR, debugctl);
 	debugctl &= ~(DEBUGCTLMSR_LBR | DEBUGCTLMSR_FREEZE_LBRS_ON_PMI);
-	wrmsrl(MSR_IA32_DEBUGCTLMSR, debugctl);
+	wrmsrq(MSR_IA32_DEBUGCTLMSR, debugctl);
 }
 
 int intel_pmu_save_and_restart(struct perf_event *event);
diff --git a/arch/x86/events/zhaoxin/core.c b/arch/x86/events/zhaoxin/core.c
index 67ff23f..e299364 100644
--- a/arch/x86/events/zhaoxin/core.c
+++ b/arch/x86/events/zhaoxin/core.c
@@ -254,12 +254,12 @@ static __initconst const u64 zxe_hw_cache_event_ids
 
 static void zhaoxin_pmu_disable_all(void)
 {
-	wrmsrl(MSR_CORE_PERF_GLOBAL_CTRL, 0);
+	wrmsrq(MSR_CORE_PERF_GLOBAL_CTRL, 0);
 }
 
 static void zhaoxin_pmu_enable_all(int added)
 {
-	wrmsrl(MSR_CORE_PERF_GLOBAL_CTRL, x86_pmu.intel_ctrl);
+	wrmsrq(MSR_CORE_PERF_GLOBAL_CTRL, x86_pmu.intel_ctrl);
 }
 
 static inline u64 zhaoxin_pmu_get_status(void)
@@ -273,7 +273,7 @@ static inline u64 zhaoxin_pmu_get_status(void)
 
 static inline void zhaoxin_pmu_ack_status(u64 ack)
 {
-	wrmsrl(MSR_CORE_PERF_GLOBAL_OVF_CTRL, ack);
+	wrmsrq(MSR_CORE_PERF_GLOBAL_OVF_CTRL, ack);
 }
 
 static inline void zxc_pmu_ack_status(u64 ack)
@@ -295,7 +295,7 @@ static void zhaoxin_pmu_disable_fixed(struct hw_perf_event *hwc)
 
 	rdmsrq(hwc->config_base, ctrl_val);
 	ctrl_val &= ~mask;
-	wrmsrl(hwc->config_base, ctrl_val);
+	wrmsrq(hwc->config_base, ctrl_val);
 }
 
 static void zhaoxin_pmu_disable_event(struct perf_event *event)
@@ -332,7 +332,7 @@ static void zhaoxin_pmu_enable_fixed(struct hw_perf_event *hwc)
 	rdmsrq(hwc->config_base, ctrl_val);
 	ctrl_val &= ~mask;
 	ctrl_val |= bits;
-	wrmsrl(hwc->config_base, ctrl_val);
+	wrmsrq(hwc->config_base, ctrl_val);
 }
 
 static void zhaoxin_pmu_enable_event(struct perf_event *event)
diff --git a/arch/x86/hyperv/hv_apic.c b/arch/x86/hyperv/hv_apic.c
index d1d6aa5..c450e67 100644
--- a/arch/x86/hyperv/hv_apic.c
+++ b/arch/x86/hyperv/hv_apic.c
@@ -49,7 +49,7 @@ static void hv_apic_icr_write(u32 low, u32 id)
 	reg_val = reg_val << 32;
 	reg_val |= low;
 
-	wrmsrl(HV_X64_MSR_ICR, reg_val);
+	wrmsrq(HV_X64_MSR_ICR, reg_val);
 }
 
 static u32 hv_apic_read(u32 reg)
diff --git a/arch/x86/hyperv/hv_init.c b/arch/x86/hyperv/hv_init.c
index 7c58aff..ed89867 100644
--- a/arch/x86/hyperv/hv_init.c
+++ b/arch/x86/hyperv/hv_init.c
@@ -128,7 +128,7 @@ static int hv_cpu_init(unsigned int cpu)
 	}
 	if (!WARN_ON(!(*hvp))) {
 		msr.enable = 1;
-		wrmsrl(HV_X64_MSR_VP_ASSIST_PAGE, msr.as_uint64);
+		wrmsrq(HV_X64_MSR_VP_ASSIST_PAGE, msr.as_uint64);
 	}
 
 	return hyperv_init_ghcb();
@@ -155,7 +155,7 @@ void hyperv_stop_tsc_emulation(void)
 
 	rdmsrq(HV_X64_MSR_TSC_EMULATION_STATUS, *(u64 *)&emu_status);
 	emu_status.inprogress = 0;
-	wrmsrl(HV_X64_MSR_TSC_EMULATION_STATUS, *(u64 *)&emu_status);
+	wrmsrq(HV_X64_MSR_TSC_EMULATION_STATUS, *(u64 *)&emu_status);
 
 	rdmsrq(HV_X64_MSR_TSC_FREQUENCY, freq);
 	tsc_khz = div64_u64(freq, 1000);
@@ -203,8 +203,8 @@ void set_hv_tscchange_cb(void (*cb)(void))
 
 	re_ctrl.target_vp = hv_vp_index[get_cpu()];
 
-	wrmsrl(HV_X64_MSR_REENLIGHTENMENT_CONTROL, *((u64 *)&re_ctrl));
-	wrmsrl(HV_X64_MSR_TSC_EMULATION_CONTROL, *((u64 *)&emu_ctrl));
+	wrmsrq(HV_X64_MSR_REENLIGHTENMENT_CONTROL, *((u64 *)&re_ctrl));
+	wrmsrq(HV_X64_MSR_TSC_EMULATION_CONTROL, *((u64 *)&emu_ctrl));
 
 	put_cpu();
 }
@@ -219,7 +219,7 @@ void clear_hv_tscchange_cb(void)
 
 	rdmsrq(HV_X64_MSR_REENLIGHTENMENT_CONTROL, *(u64 *)&re_ctrl);
 	re_ctrl.enabled = 0;
-	wrmsrl(HV_X64_MSR_REENLIGHTENMENT_CONTROL, *(u64 *)&re_ctrl);
+	wrmsrq(HV_X64_MSR_REENLIGHTENMENT_CONTROL, *(u64 *)&re_ctrl);
 
 	hv_reenlightenment_cb = NULL;
 }
@@ -254,7 +254,7 @@ static int hv_cpu_die(unsigned int cpu)
 			rdmsrq(HV_X64_MSR_VP_ASSIST_PAGE, msr.as_uint64);
 			msr.enable = 0;
 		}
-		wrmsrl(HV_X64_MSR_VP_ASSIST_PAGE, msr.as_uint64);
+		wrmsrq(HV_X64_MSR_VP_ASSIST_PAGE, msr.as_uint64);
 	}
 
 	if (hv_reenlightenment_cb == NULL)
@@ -274,7 +274,7 @@ static int hv_cpu_die(unsigned int cpu)
 		else
 			re_ctrl.enabled = 0;
 
-		wrmsrl(HV_X64_MSR_REENLIGHTENMENT_CONTROL, *((u64 *)&re_ctrl));
+		wrmsrq(HV_X64_MSR_REENLIGHTENMENT_CONTROL, *((u64 *)&re_ctrl));
 	}
 
 	return 0;
@@ -333,7 +333,7 @@ static int hv_suspend(void)
 	/* Disable the hypercall page in the hypervisor */
 	rdmsrq(HV_X64_MSR_HYPERCALL, hypercall_msr.as_uint64);
 	hypercall_msr.enable = 0;
-	wrmsrl(HV_X64_MSR_HYPERCALL, hypercall_msr.as_uint64);
+	wrmsrq(HV_X64_MSR_HYPERCALL, hypercall_msr.as_uint64);
 
 	ret = hv_cpu_die(0);
 	return ret;
@@ -352,7 +352,7 @@ static void hv_resume(void)
 	hypercall_msr.enable = 1;
 	hypercall_msr.guest_physical_address =
 		vmalloc_to_pfn(hv_hypercall_pg_saved);
-	wrmsrl(HV_X64_MSR_HYPERCALL, hypercall_msr.as_uint64);
+	wrmsrq(HV_X64_MSR_HYPERCALL, hypercall_msr.as_uint64);
 
 	hv_hypercall_pg = hv_hypercall_pg_saved;
 	hv_hypercall_pg_saved = NULL;
@@ -499,7 +499,7 @@ void __init hyperv_init(void)
 	 * in such a VM and is only used in such a VM.
 	 */
 	guest_id = hv_generate_guest_id(LINUX_VERSION_CODE);
-	wrmsrl(HV_X64_MSR_GUEST_OS_ID, guest_id);
+	wrmsrq(HV_X64_MSR_GUEST_OS_ID, guest_id);
 
 	/* With the paravisor, the VM must also write the ID via GHCB/GHCI */
 	hv_ivm_msr_write(HV_X64_MSR_GUEST_OS_ID, guest_id);
@@ -532,7 +532,7 @@ void __init hyperv_init(void)
 		 * so it is populated with code, then copy the code to an
 		 * executable page.
 		 */
-		wrmsrl(HV_X64_MSR_HYPERCALL, hypercall_msr.as_uint64);
+		wrmsrq(HV_X64_MSR_HYPERCALL, hypercall_msr.as_uint64);
 
 		pg = vmalloc_to_page(hv_hypercall_pg);
 		src = memremap(hypercall_msr.guest_physical_address << PAGE_SHIFT, PAGE_SIZE,
@@ -544,7 +544,7 @@ void __init hyperv_init(void)
 		hv_remap_tsc_clocksource();
 	} else {
 		hypercall_msr.guest_physical_address = vmalloc_to_pfn(hv_hypercall_pg);
-		wrmsrl(HV_X64_MSR_HYPERCALL, hypercall_msr.as_uint64);
+		wrmsrq(HV_X64_MSR_HYPERCALL, hypercall_msr.as_uint64);
 	}
 
 skip_hypercall_pg_init:
@@ -608,7 +608,7 @@ skip_hypercall_pg_init:
 	return;
 
 clean_guest_os_id:
-	wrmsrl(HV_X64_MSR_GUEST_OS_ID, 0);
+	wrmsrq(HV_X64_MSR_GUEST_OS_ID, 0);
 	hv_ivm_msr_write(HV_X64_MSR_GUEST_OS_ID, 0);
 	cpuhp_remove_state(CPUHP_AP_HYPERV_ONLINE);
 free_ghcb_page:
@@ -629,7 +629,7 @@ void hyperv_cleanup(void)
 	union hv_reference_tsc_msr tsc_msr;
 
 	/* Reset our OS id */
-	wrmsrl(HV_X64_MSR_GUEST_OS_ID, 0);
+	wrmsrq(HV_X64_MSR_GUEST_OS_ID, 0);
 	hv_ivm_msr_write(HV_X64_MSR_GUEST_OS_ID, 0);
 
 	/*
@@ -669,16 +669,16 @@ void hyperv_report_panic(struct pt_regs *regs, long err, bool in_die)
 
 	rdmsrq(HV_X64_MSR_GUEST_OS_ID, guest_id);
 
-	wrmsrl(HV_X64_MSR_CRASH_P0, err);
-	wrmsrl(HV_X64_MSR_CRASH_P1, guest_id);
-	wrmsrl(HV_X64_MSR_CRASH_P2, regs->ip);
-	wrmsrl(HV_X64_MSR_CRASH_P3, regs->ax);
-	wrmsrl(HV_X64_MSR_CRASH_P4, regs->sp);
+	wrmsrq(HV_X64_MSR_CRASH_P0, err);
+	wrmsrq(HV_X64_MSR_CRASH_P1, guest_id);
+	wrmsrq(HV_X64_MSR_CRASH_P2, regs->ip);
+	wrmsrq(HV_X64_MSR_CRASH_P3, regs->ax);
+	wrmsrq(HV_X64_MSR_CRASH_P4, regs->sp);
 
 	/*
 	 * Let Hyper-V know there is crash data available
 	 */
-	wrmsrl(HV_X64_MSR_CRASH_CTL, HV_CRASH_CTL_CRASH_NOTIFY);
+	wrmsrq(HV_X64_MSR_CRASH_CTL, HV_CRASH_CTL_CRASH_NOTIFY);
 }
 EXPORT_SYMBOL_GPL(hyperv_report_panic);
 
diff --git a/arch/x86/include/asm/apic.h b/arch/x86/include/asm/apic.h
index 45819cf..36e1798 100644
--- a/arch/x86/include/asm/apic.h
+++ b/arch/x86/include/asm/apic.h
@@ -230,7 +230,7 @@ static inline u32 native_apic_msr_read(u32 reg)
 
 static inline void native_x2apic_icr_write(u32 low, u32 id)
 {
-	wrmsrl(APIC_BASE_MSR + (APIC_ICR >> 4), ((__u64) id) << 32 | low);
+	wrmsrq(APIC_BASE_MSR + (APIC_ICR >> 4), ((__u64) id) << 32 | low);
 }
 
 static inline u64 native_x2apic_icr_read(void)
diff --git a/arch/x86/include/asm/debugreg.h b/arch/x86/include/asm/debugreg.h
index 0e703c0..da6aedb 100644
--- a/arch/x86/include/asm/debugreg.h
+++ b/arch/x86/include/asm/debugreg.h
@@ -180,7 +180,7 @@ static inline void update_debugctlmsr(unsigned long debugctlmsr)
 	if (boot_cpu_data.x86 < 6)
 		return;
 #endif
-	wrmsrl(MSR_IA32_DEBUGCTLMSR, debugctlmsr);
+	wrmsrq(MSR_IA32_DEBUGCTLMSR, debugctlmsr);
 }
 
 #endif /* _ASM_X86_DEBUGREG_H */
diff --git a/arch/x86/include/asm/fsgsbase.h b/arch/x86/include/asm/fsgsbase.h
index d7708f2..ab2547f 100644
--- a/arch/x86/include/asm/fsgsbase.h
+++ b/arch/x86/include/asm/fsgsbase.h
@@ -70,7 +70,7 @@ static inline void x86_fsbase_write_cpu(unsigned long fsbase)
 	if (boot_cpu_has(X86_FEATURE_FSGSBASE))
 		wrfsbase(fsbase);
 	else
-		wrmsrl(MSR_FS_BASE, fsbase);
+		wrmsrq(MSR_FS_BASE, fsbase);
 }
 
 extern unsigned long x86_gsbase_read_cpu_inactive(void);
diff --git a/arch/x86/include/asm/msr.h b/arch/x86/include/asm/msr.h
index b35513a..2e456cd 100644
--- a/arch/x86/include/asm/msr.h
+++ b/arch/x86/include/asm/msr.h
@@ -258,7 +258,7 @@ static inline void wrmsr(u32 msr, u32 low, u32 high)
 #define rdmsrq(msr, val)			\
 	((val) = native_read_msr((msr)))
 
-static inline void wrmsrl(u32 msr, u64 val)
+static inline void wrmsrq(u32 msr, u64 val)
 {
 	native_write_msr(msr, (u32)(val & 0xffffffffULL), (u32)(val >> 32));
 }
@@ -357,7 +357,7 @@ static inline int rdmsrl_on_cpu(unsigned int cpu, u32 msr_no, u64 *q)
 }
 static inline int wrmsrl_on_cpu(unsigned int cpu, u32 msr_no, u64 q)
 {
-	wrmsrl(msr_no, q);
+	wrmsrq(msr_no, q);
 	return 0;
 }
 static inline void rdmsr_on_cpus(const struct cpumask *m, u32 msr_no,
diff --git a/arch/x86/include/asm/paravirt.h b/arch/x86/include/asm/paravirt.h
index 1cda83b..87c2597 100644
--- a/arch/x86/include/asm/paravirt.h
+++ b/arch/x86/include/asm/paravirt.h
@@ -214,7 +214,7 @@ do {						\
 	val = paravirt_read_msr(msr);		\
 } while (0)
 
-static inline void wrmsrl(unsigned msr, u64 val)
+static inline void wrmsrq(unsigned msr, u64 val)
 {
 	wrmsr(msr, (u32)val, (u32)(val>>32));
 }
diff --git a/arch/x86/kernel/apic/apic.c b/arch/x86/kernel/apic/apic.c
index dc9af05..a05871c 100644
--- a/arch/x86/kernel/apic/apic.c
+++ b/arch/x86/kernel/apic/apic.c
@@ -425,7 +425,7 @@ static int lapic_next_deadline(unsigned long delta,
 	weak_wrmsr_fence();
 
 	tsc = rdtsc();
-	wrmsrl(MSR_IA32_TSC_DEADLINE, tsc + (((u64) delta) * TSC_DIVISOR));
+	wrmsrq(MSR_IA32_TSC_DEADLINE, tsc + (((u64) delta) * TSC_DIVISOR));
 	return 0;
 }
 
@@ -449,7 +449,7 @@ static int lapic_timer_shutdown(struct clock_event_device *evt)
 	 * the timer _and_ zero the counter registers:
 	 */
 	if (v & APIC_LVT_TIMER_TSCDEADLINE)
-		wrmsrl(MSR_IA32_TSC_DEADLINE, 0);
+		wrmsrq(MSR_IA32_TSC_DEADLINE, 0);
 	else
 		apic_write(APIC_TMICT, 0);
 
@@ -1711,8 +1711,8 @@ static void __x2apic_disable(void)
 	if (!(msr & X2APIC_ENABLE))
 		return;
 	/* Disable xapic and x2apic first and then reenable xapic mode */
-	wrmsrl(MSR_IA32_APICBASE, msr & ~(X2APIC_ENABLE | XAPIC_ENABLE));
-	wrmsrl(MSR_IA32_APICBASE, msr & ~X2APIC_ENABLE);
+	wrmsrq(MSR_IA32_APICBASE, msr & ~(X2APIC_ENABLE | XAPIC_ENABLE));
+	wrmsrq(MSR_IA32_APICBASE, msr & ~X2APIC_ENABLE);
 	printk_once(KERN_INFO "x2apic disabled\n");
 }
 
@@ -1723,7 +1723,7 @@ static void __x2apic_enable(void)
 	rdmsrq(MSR_IA32_APICBASE, msr);
 	if (msr & X2APIC_ENABLE)
 		return;
-	wrmsrl(MSR_IA32_APICBASE, msr | X2APIC_ENABLE);
+	wrmsrq(MSR_IA32_APICBASE, msr | X2APIC_ENABLE);
 	printk_once(KERN_INFO "x2apic enabled\n");
 }
 
diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index 78ffe0e..86c1f0c 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -71,7 +71,7 @@ void (*x86_return_thunk)(void) __ro_after_init = __x86_return_thunk;
 static void update_spec_ctrl(u64 val)
 {
 	this_cpu_write(x86_spec_ctrl_current, val);
-	wrmsrl(MSR_IA32_SPEC_CTRL, val);
+	wrmsrq(MSR_IA32_SPEC_CTRL, val);
 }
 
 /*
@@ -90,7 +90,7 @@ void update_spec_ctrl_cond(u64 val)
 	 * forced the update can be delayed until that time.
 	 */
 	if (!cpu_feature_enabled(X86_FEATURE_KERNEL_IBRS))
-		wrmsrl(MSR_IA32_SPEC_CTRL, val);
+		wrmsrq(MSR_IA32_SPEC_CTRL, val);
 }
 
 noinstr u64 spec_ctrl_current(void)
@@ -228,9 +228,9 @@ static void x86_amd_ssb_disable(void)
 	u64 msrval = x86_amd_ls_cfg_base | x86_amd_ls_cfg_ssbd_mask;
 
 	if (boot_cpu_has(X86_FEATURE_VIRT_SSBD))
-		wrmsrl(MSR_AMD64_VIRT_SPEC_CTRL, SPEC_CTRL_SSBD);
+		wrmsrq(MSR_AMD64_VIRT_SPEC_CTRL, SPEC_CTRL_SSBD);
 	else if (boot_cpu_has(X86_FEATURE_LS_CFG_SSBD))
-		wrmsrl(MSR_AMD64_LS_CFG, msrval);
+		wrmsrq(MSR_AMD64_LS_CFG, msrval);
 }
 
 #undef pr_fmt
@@ -670,7 +670,7 @@ void update_srbds_msr(void)
 		break;
 	}
 
-	wrmsrl(MSR_IA32_MCU_OPT_CTRL, mcu_ctrl);
+	wrmsrq(MSR_IA32_MCU_OPT_CTRL, mcu_ctrl);
 }
 
 static void __init srbds_select_mitigation(void)
@@ -795,7 +795,7 @@ void update_gds_msr(void)
 		return;
 	}
 
-	wrmsrl(MSR_IA32_MCU_OPT_CTRL, mcu_ctrl);
+	wrmsrq(MSR_IA32_MCU_OPT_CTRL, mcu_ctrl);
 
 	/*
 	 * Check to make sure that the WRMSR value was not ignored. Writes to
diff --git a/arch/x86/kernel/cpu/bus_lock.c b/arch/x86/kernel/cpu/bus_lock.c
index 725072b..a96cfdc 100644
--- a/arch/x86/kernel/cpu/bus_lock.c
+++ b/arch/x86/kernel/cpu/bus_lock.c
@@ -145,7 +145,7 @@ static void __init __split_lock_setup(void)
 	}
 
 	/* Restore the MSR to its cached value. */
-	wrmsrl(MSR_TEST_CTRL, msr_test_ctrl_cache);
+	wrmsrq(MSR_TEST_CTRL, msr_test_ctrl_cache);
 
 	setup_force_cpu_cap(X86_FEATURE_SPLIT_LOCK_DETECT);
 }
@@ -162,7 +162,7 @@ static void sld_update_msr(bool on)
 	if (on)
 		test_ctrl_val |= MSR_TEST_CTRL_SPLIT_LOCK_DETECT;
 
-	wrmsrl(MSR_TEST_CTRL, test_ctrl_val);
+	wrmsrq(MSR_TEST_CTRL, test_ctrl_val);
 }
 
 void split_lock_init(void)
@@ -311,7 +311,7 @@ void bus_lock_init(void)
 		val |= DEBUGCTLMSR_BUS_LOCK_DETECT;
 	}
 
-	wrmsrl(MSR_IA32_DEBUGCTLMSR, val);
+	wrmsrq(MSR_IA32_DEBUGCTLMSR, val);
 }
 
 bool handle_user_split_lock(struct pt_regs *regs, long error_code)
diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index c3c0ba2..a1f1be8 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -564,7 +564,7 @@ __noendbr u64 ibt_save(bool disable)
 	if (cpu_feature_enabled(X86_FEATURE_IBT)) {
 		rdmsrq(MSR_IA32_S_CET, msr);
 		if (disable)
-			wrmsrl(MSR_IA32_S_CET, msr & ~CET_ENDBR_EN);
+			wrmsrq(MSR_IA32_S_CET, msr & ~CET_ENDBR_EN);
 	}
 
 	return msr;
@@ -578,7 +578,7 @@ __noendbr void ibt_restore(u64 save)
 		rdmsrq(MSR_IA32_S_CET, msr);
 		msr &= ~CET_ENDBR_EN;
 		msr |= (save & CET_ENDBR_EN);
-		wrmsrl(MSR_IA32_S_CET, msr);
+		wrmsrq(MSR_IA32_S_CET, msr);
 	}
 }
 
@@ -602,15 +602,15 @@ static __always_inline void setup_cet(struct cpuinfo_x86 *c)
 		set_cpu_cap(c, X86_FEATURE_USER_SHSTK);
 
 	if (kernel_ibt)
-		wrmsrl(MSR_IA32_S_CET, CET_ENDBR_EN);
+		wrmsrq(MSR_IA32_S_CET, CET_ENDBR_EN);
 	else
-		wrmsrl(MSR_IA32_S_CET, 0);
+		wrmsrq(MSR_IA32_S_CET, 0);
 
 	cr4_set_bits(X86_CR4_CET);
 
 	if (kernel_ibt && ibt_selftest()) {
 		pr_err("IBT selftest: Failed!\n");
-		wrmsrl(MSR_IA32_S_CET, 0);
+		wrmsrq(MSR_IA32_S_CET, 0);
 		setup_clear_cpu_cap(X86_FEATURE_IBT);
 	}
 }
@@ -621,8 +621,8 @@ __noendbr void cet_disable(void)
 	      cpu_feature_enabled(X86_FEATURE_SHSTK)))
 		return;
 
-	wrmsrl(MSR_IA32_S_CET, 0);
-	wrmsrl(MSR_IA32_U_CET, 0);
+	wrmsrq(MSR_IA32_S_CET, 0);
+	wrmsrq(MSR_IA32_U_CET, 0);
 }
 
 /*
@@ -751,9 +751,9 @@ void __init switch_gdt_and_percpu_base(int cpu)
 	 * No need to load %gs. It is already correct.
 	 *
 	 * Writing %gs on 64bit would zero GSBASE which would make any per
-	 * CPU operation up to the point of the wrmsrl() fault.
+	 * CPU operation up to the point of the wrmsrq() fault.
 	 *
-	 * Set GSBASE to the new offset. Until the wrmsrl() happens the
+	 * Set GSBASE to the new offset. Until the wrmsrq() happens the
 	 * early mapping is still valid. That means the GSBASE update will
 	 * lose any prior per CPU data which was not copied over in
 	 * setup_per_cpu_areas().
@@ -761,7 +761,7 @@ void __init switch_gdt_and_percpu_base(int cpu)
 	 * This works even with stackprotector enabled because the
 	 * per CPU stack canary is 0 in both per CPU areas.
 	 */
-	wrmsrl(MSR_GS_BASE, cpu_kernelmode_gs_base(cpu));
+	wrmsrq(MSR_GS_BASE, cpu_kernelmode_gs_base(cpu));
 #else
 	/*
 	 * %fs is already set to __KERNEL_PERCPU, but after switching GDT
@@ -1750,10 +1750,10 @@ static bool detect_null_seg_behavior(void)
 
 	unsigned long old_base, tmp;
 	rdmsrq(MSR_FS_BASE, old_base);
-	wrmsrl(MSR_FS_BASE, 1);
+	wrmsrq(MSR_FS_BASE, 1);
 	loadsegment(fs, 0);
 	rdmsrq(MSR_FS_BASE, tmp);
-	wrmsrl(MSR_FS_BASE, old_base);
+	wrmsrq(MSR_FS_BASE, old_base);
 	return tmp == 0;
 }
 
@@ -2099,12 +2099,12 @@ static void wrmsrl_cstar(unsigned long val)
 	 * guest. Avoid the pointless write on all Intel CPUs.
 	 */
 	if (boot_cpu_data.x86_vendor != X86_VENDOR_INTEL)
-		wrmsrl(MSR_CSTAR, val);
+		wrmsrq(MSR_CSTAR, val);
 }
 
 static inline void idt_syscall_init(void)
 {
-	wrmsrl(MSR_LSTAR, (unsigned long)entry_SYSCALL_64);
+	wrmsrq(MSR_LSTAR, (unsigned long)entry_SYSCALL_64);
 
 	if (ia32_enabled()) {
 		wrmsrl_cstar((unsigned long)entry_SYSCALL_compat);
@@ -2129,7 +2129,7 @@ static inline void idt_syscall_init(void)
 	 * Flags to clear on syscall; clear as much as possible
 	 * to minimize user space-kernel interference.
 	 */
-	wrmsrl(MSR_SYSCALL_MASK,
+	wrmsrq(MSR_SYSCALL_MASK,
 	       X86_EFLAGS_CF|X86_EFLAGS_PF|X86_EFLAGS_AF|
 	       X86_EFLAGS_ZF|X86_EFLAGS_SF|X86_EFLAGS_TF|
 	       X86_EFLAGS_IF|X86_EFLAGS_DF|X86_EFLAGS_OF|
@@ -2313,8 +2313,8 @@ void cpu_init(void)
 		memset(cur->thread.tls_array, 0, GDT_ENTRY_TLS_ENTRIES * 8);
 		syscall_init();
 
-		wrmsrl(MSR_FS_BASE, 0);
-		wrmsrl(MSR_KERNEL_GS_BASE, 0);
+		wrmsrq(MSR_FS_BASE, 0);
+		wrmsrq(MSR_KERNEL_GS_BASE, 0);
 		barrier();
 
 		x2apic_setup();
diff --git a/arch/x86/kernel/cpu/feat_ctl.c b/arch/x86/kernel/cpu/feat_ctl.c
index 4a41187..edd4195 100644
--- a/arch/x86/kernel/cpu/feat_ctl.c
+++ b/arch/x86/kernel/cpu/feat_ctl.c
@@ -165,7 +165,7 @@ void init_ia32_feat_ctl(struct cpuinfo_x86 *c)
 			msr |= FEAT_CTL_SGX_LC_ENABLED;
 	}
 
-	wrmsrl(MSR_IA32_FEAT_CTL, msr);
+	wrmsrq(MSR_IA32_FEAT_CTL, msr);
 
 update_caps:
 	set_cpu_cap(c, X86_FEATURE_MSR_IA32_FEAT_CTL);
diff --git a/arch/x86/kernel/cpu/intel.c b/arch/x86/kernel/cpu/intel.c
index e9a6e0d..72a1104 100644
--- a/arch/x86/kernel/cpu/intel.c
+++ b/arch/x86/kernel/cpu/intel.c
@@ -509,7 +509,7 @@ static void init_intel_misc_features(struct cpuinfo_x86 *c)
 	probe_xeon_phi_r3mwait(c);
 
 	msr = this_cpu_read(msr_misc_features_shadow);
-	wrmsrl(MSR_MISC_FEATURES_ENABLES, msr);
+	wrmsrq(MSR_MISC_FEATURES_ENABLES, msr);
 }
 
 /*
diff --git a/arch/x86/kernel/cpu/intel_epb.c b/arch/x86/kernel/cpu/intel_epb.c
index 6e6af07..01d81b7 100644
--- a/arch/x86/kernel/cpu/intel_epb.c
+++ b/arch/x86/kernel/cpu/intel_epb.c
@@ -111,7 +111,7 @@ static void intel_epb_restore(void)
 			pr_warn_once("ENERGY_PERF_BIAS: Set to 'normal', was 'performance'\n");
 		}
 	}
-	wrmsrl(MSR_IA32_ENERGY_PERF_BIAS, (epb & ~EPB_MASK) | val);
+	wrmsrq(MSR_IA32_ENERGY_PERF_BIAS, (epb & ~EPB_MASK) | val);
 }
 
 static struct syscore_ops intel_epb_syscore_ops = {
diff --git a/arch/x86/kernel/cpu/mce/amd.c b/arch/x86/kernel/cpu/mce/amd.c
index c29165f..9d852c3 100644
--- a/arch/x86/kernel/cpu/mce/amd.c
+++ b/arch/x86/kernel/cpu/mce/amd.c
@@ -667,7 +667,7 @@ static void disable_err_thresholding(struct cpuinfo_x86 *c, unsigned int bank)
 	/* McStatusWrEn has to be set */
 	need_toggle = !(hwcr & BIT(18));
 	if (need_toggle)
-		wrmsrl(MSR_K7_HWCR, hwcr | BIT(18));
+		wrmsrq(MSR_K7_HWCR, hwcr | BIT(18));
 
 	/* Clear CntP bit safely */
 	for (i = 0; i < num_msrs; i++)
@@ -675,7 +675,7 @@ static void disable_err_thresholding(struct cpuinfo_x86 *c, unsigned int bank)
 
 	/* restore old settings */
 	if (need_toggle)
-		wrmsrl(MSR_K7_HWCR, hwcr);
+		wrmsrq(MSR_K7_HWCR, hwcr);
 }
 
 /* cpu init entry point, called from mce.c with preempt off */
@@ -843,7 +843,7 @@ _log_error_bank(unsigned int bank, u32 msr_stat, u32 msr_addr, u64 misc)
 
 	__log_error(bank, status, addr, misc);
 
-	wrmsrl(msr_stat, 0);
+	wrmsrq(msr_stat, 0);
 
 	return status & MCI_STATUS_DEFERRED;
 }
@@ -862,7 +862,7 @@ static bool _log_error_deferred(unsigned int bank, u32 misc)
 		return true;
 
 	/* Clear MCA_DESTAT if the deferred error was logged from MCA_STATUS. */
-	wrmsrl(MSR_AMD64_SMCA_MCx_DESTAT(bank), 0);
+	wrmsrq(MSR_AMD64_SMCA_MCx_DESTAT(bank), 0);
 	return true;
 }
 
diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
index a71228d..c274024 100644
--- a/arch/x86/kernel/cpu/mce/core.c
+++ b/arch/x86/kernel/cpu/mce/core.c
@@ -1878,8 +1878,8 @@ static void __mcheck_cpu_init_clear_banks(void)
 
 		if (!b->init)
 			continue;
-		wrmsrl(mca_msr_reg(i, MCA_CTL), b->ctl);
-		wrmsrl(mca_msr_reg(i, MCA_STATUS), 0);
+		wrmsrq(mca_msr_reg(i, MCA_CTL), b->ctl);
+		wrmsrq(mca_msr_reg(i, MCA_STATUS), 0);
 	}
 }
 
@@ -2436,7 +2436,7 @@ static void mce_disable_error_reporting(void)
 		struct mce_bank *b = &mce_banks[i];
 
 		if (b->init)
-			wrmsrl(mca_msr_reg(i, MCA_CTL), 0);
+			wrmsrq(mca_msr_reg(i, MCA_CTL), 0);
 	}
 	return;
 }
@@ -2786,7 +2786,7 @@ static void mce_reenable_cpu(void)
 		struct mce_bank *b = &mce_banks[i];
 
 		if (b->init)
-			wrmsrl(mca_msr_reg(i, MCA_CTL), b->ctl);
+			wrmsrq(mca_msr_reg(i, MCA_CTL), b->ctl);
 	}
 }
 
diff --git a/arch/x86/kernel/cpu/mce/inject.c b/arch/x86/kernel/cpu/mce/inject.c
index 08d52af..75df35f 100644
--- a/arch/x86/kernel/cpu/mce/inject.c
+++ b/arch/x86/kernel/cpu/mce/inject.c
@@ -475,27 +475,27 @@ static void prepare_msrs(void *info)
 	struct mce m = *(struct mce *)info;
 	u8 b = m.bank;
 
-	wrmsrl(MSR_IA32_MCG_STATUS, m.mcgstatus);
+	wrmsrq(MSR_IA32_MCG_STATUS, m.mcgstatus);
 
 	if (boot_cpu_has(X86_FEATURE_SMCA)) {
 		if (m.inject_flags == DFR_INT_INJ) {
-			wrmsrl(MSR_AMD64_SMCA_MCx_DESTAT(b), m.status);
-			wrmsrl(MSR_AMD64_SMCA_MCx_DEADDR(b), m.addr);
+			wrmsrq(MSR_AMD64_SMCA_MCx_DESTAT(b), m.status);
+			wrmsrq(MSR_AMD64_SMCA_MCx_DEADDR(b), m.addr);
 		} else {
-			wrmsrl(MSR_AMD64_SMCA_MCx_STATUS(b), m.status);
-			wrmsrl(MSR_AMD64_SMCA_MCx_ADDR(b), m.addr);
+			wrmsrq(MSR_AMD64_SMCA_MCx_STATUS(b), m.status);
+			wrmsrq(MSR_AMD64_SMCA_MCx_ADDR(b), m.addr);
 		}
 
-		wrmsrl(MSR_AMD64_SMCA_MCx_SYND(b), m.synd);
+		wrmsrq(MSR_AMD64_SMCA_MCx_SYND(b), m.synd);
 
 		if (m.misc)
-			wrmsrl(MSR_AMD64_SMCA_MCx_MISC(b), m.misc);
+			wrmsrq(MSR_AMD64_SMCA_MCx_MISC(b), m.misc);
 	} else {
-		wrmsrl(MSR_IA32_MCx_STATUS(b), m.status);
-		wrmsrl(MSR_IA32_MCx_ADDR(b), m.addr);
+		wrmsrq(MSR_IA32_MCx_STATUS(b), m.status);
+		wrmsrq(MSR_IA32_MCx_ADDR(b), m.addr);
 
 		if (m.misc)
-			wrmsrl(MSR_IA32_MCx_MISC(b), m.misc);
+			wrmsrq(MSR_IA32_MCx_MISC(b), m.misc);
 	}
 }
 
diff --git a/arch/x86/kernel/cpu/mce/intel.c b/arch/x86/kernel/cpu/mce/intel.c
index 9fda956..28f04c6 100644
--- a/arch/x86/kernel/cpu/mce/intel.c
+++ b/arch/x86/kernel/cpu/mce/intel.c
@@ -143,7 +143,7 @@ static void cmci_set_threshold(int bank, int thresh)
 	raw_spin_lock_irqsave(&cmci_discover_lock, flags);
 	rdmsrq(MSR_IA32_MCx_CTL2(bank), val);
 	val &= ~MCI_CTL2_CMCI_THRESHOLD_MASK;
-	wrmsrl(MSR_IA32_MCx_CTL2(bank), val | thresh);
+	wrmsrq(MSR_IA32_MCx_CTL2(bank), val | thresh);
 	raw_spin_unlock_irqrestore(&cmci_discover_lock, flags);
 }
 
@@ -232,7 +232,7 @@ static void cmci_claim_bank(int bank, u64 val, int bios_zero_thresh, int *bios_w
 	struct mca_storm_desc *storm = this_cpu_ptr(&storm_desc);
 
 	val |= MCI_CTL2_CMCI_EN;
-	wrmsrl(MSR_IA32_MCx_CTL2(bank), val);
+	wrmsrq(MSR_IA32_MCx_CTL2(bank), val);
 	rdmsrq(MSR_IA32_MCx_CTL2(bank), val);
 
 	/* If the enable bit did not stick, this bank should be polled. */
@@ -326,7 +326,7 @@ static void __cmci_disable_bank(int bank)
 		return;
 	rdmsrq(MSR_IA32_MCx_CTL2(bank), val);
 	val &= ~MCI_CTL2_CMCI_EN;
-	wrmsrl(MSR_IA32_MCx_CTL2(bank), val);
+	wrmsrq(MSR_IA32_MCx_CTL2(bank), val);
 	__clear_bit(bank, this_cpu_ptr(mce_banks_owned));
 
 	if ((val & MCI_CTL2_CMCI_THRESHOLD_MASK) == CMCI_STORM_THRESHOLD)
@@ -433,7 +433,7 @@ void intel_init_lmce(void)
 	rdmsrq(MSR_IA32_MCG_EXT_CTL, val);
 
 	if (!(val & MCG_EXT_CTL_LMCE_EN))
-		wrmsrl(MSR_IA32_MCG_EXT_CTL, val | MCG_EXT_CTL_LMCE_EN);
+		wrmsrq(MSR_IA32_MCG_EXT_CTL, val | MCG_EXT_CTL_LMCE_EN);
 }
 
 void intel_clear_lmce(void)
@@ -445,7 +445,7 @@ void intel_clear_lmce(void)
 
 	rdmsrq(MSR_IA32_MCG_EXT_CTL, val);
 	val &= ~MCG_EXT_CTL_LMCE_EN;
-	wrmsrl(MSR_IA32_MCG_EXT_CTL, val);
+	wrmsrq(MSR_IA32_MCG_EXT_CTL, val);
 }
 
 /*
diff --git a/arch/x86/kernel/cpu/mshyperv.c b/arch/x86/kernel/cpu/mshyperv.c
index b1b9b4c..b924bef 100644
--- a/arch/x86/kernel/cpu/mshyperv.c
+++ b/arch/x86/kernel/cpu/mshyperv.c
@@ -82,9 +82,9 @@ void hv_set_non_nested_msr(unsigned int reg, u64 value)
 
 		/* Write proxy bit via wrmsl instruction */
 		if (hv_is_sint_msr(reg))
-			wrmsrl(reg, value | 1 << 20);
+			wrmsrq(reg, value | 1 << 20);
 	} else {
-		wrmsrl(reg, value);
+		wrmsrq(reg, value);
 	}
 }
 EXPORT_SYMBOL_GPL(hv_set_non_nested_msr);
@@ -574,7 +574,7 @@ static void __init ms_hyperv_init_platform(void)
 		 * setting of this MSR bit should happen before init_intel()
 		 * is called.
 		 */
-		wrmsrl(HV_X64_MSR_TSC_INVARIANT_CONTROL, HV_EXPOSE_INVARIANT_TSC);
+		wrmsrq(HV_X64_MSR_TSC_INVARIANT_CONTROL, HV_EXPOSE_INVARIANT_TSC);
 		setup_force_cpu_cap(X86_FEATURE_TSC_RELIABLE);
 	}
 
diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resctrl/core.c
index 76c887b..6d408f7 100644
--- a/arch/x86/kernel/cpu/resctrl/core.c
+++ b/arch/x86/kernel/cpu/resctrl/core.c
@@ -309,7 +309,7 @@ static void mba_wrmsr_amd(struct msr_param *m)
 	unsigned int i;
 
 	for (i = m->low; i < m->high; i++)
-		wrmsrl(hw_res->msr_base + i, hw_dom->ctrl_val[i]);
+		wrmsrq(hw_res->msr_base + i, hw_dom->ctrl_val[i]);
 }
 
 /*
@@ -334,7 +334,7 @@ static void mba_wrmsr_intel(struct msr_param *m)
 
 	/*  Write the delay values for mba. */
 	for (i = m->low; i < m->high; i++)
-		wrmsrl(hw_res->msr_base + i, delay_bw_map(hw_dom->ctrl_val[i], m->res));
+		wrmsrq(hw_res->msr_base + i, delay_bw_map(hw_dom->ctrl_val[i], m->res));
 }
 
 static void cat_wrmsr(struct msr_param *m)
@@ -344,7 +344,7 @@ static void cat_wrmsr(struct msr_param *m)
 	unsigned int i;
 
 	for (i = m->low; i < m->high; i++)
-		wrmsrl(hw_res->msr_base + i, hw_dom->ctrl_val[i]);
+		wrmsrq(hw_res->msr_base + i, hw_dom->ctrl_val[i]);
 }
 
 u32 resctrl_arch_get_num_closid(struct rdt_resource *r)
diff --git a/arch/x86/kernel/cpu/resctrl/pseudo_lock.c b/arch/x86/kernel/cpu/resctrl/pseudo_lock.c
index 92ea147..2a82eb6 100644
--- a/arch/x86/kernel/cpu/resctrl/pseudo_lock.c
+++ b/arch/x86/kernel/cpu/resctrl/pseudo_lock.c
@@ -534,7 +534,7 @@ int resctrl_arch_pseudo_lock_fn(void *_plr)
 	__wrmsr(MSR_IA32_PQR_ASSOC, rmid_p, closid_p);
 
 	/* Re-enable the hardware prefetcher(s) */
-	wrmsrl(MSR_MISC_FEATURE_CONTROL, saved_msr);
+	wrmsrq(MSR_MISC_FEATURE_CONTROL, saved_msr);
 	local_irq_enable();
 
 	plr->thread_done = 1;
diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index 3be9866..26f4d82 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -2326,14 +2326,14 @@ static void l3_qos_cfg_update(void *arg)
 {
 	bool *enable = arg;
 
-	wrmsrl(MSR_IA32_L3_QOS_CFG, *enable ? L3_QOS_CDP_ENABLE : 0ULL);
+	wrmsrq(MSR_IA32_L3_QOS_CFG, *enable ? L3_QOS_CDP_ENABLE : 0ULL);
 }
 
 static void l2_qos_cfg_update(void *arg)
 {
 	bool *enable = arg;
 
-	wrmsrl(MSR_IA32_L2_QOS_CFG, *enable ? L2_QOS_CDP_ENABLE : 0ULL);
+	wrmsrq(MSR_IA32_L2_QOS_CFG, *enable ? L2_QOS_CDP_ENABLE : 0ULL);
 }
 
 static inline bool is_mba_linear(void)
diff --git a/arch/x86/kernel/cpu/sgx/main.c b/arch/x86/kernel/cpu/sgx/main.c
index 8ce352f..40967d8 100644
--- a/arch/x86/kernel/cpu/sgx/main.c
+++ b/arch/x86/kernel/cpu/sgx/main.c
@@ -871,7 +871,7 @@ void sgx_update_lepubkeyhash(u64 *lepubkeyhash)
 	WARN_ON_ONCE(preemptible());
 
 	for (i = 0; i < 4; i++)
-		wrmsrl(MSR_IA32_SGXLEPUBKEYHASH0 + i, lepubkeyhash[i]);
+		wrmsrq(MSR_IA32_SGXLEPUBKEYHASH0 + i, lepubkeyhash[i]);
 }
 
 const struct file_operations sgx_provision_fops = {
diff --git a/arch/x86/kernel/cpu/tsx.c b/arch/x86/kernel/cpu/tsx.c
index c3aaa68..b0a9c9e 100644
--- a/arch/x86/kernel/cpu/tsx.c
+++ b/arch/x86/kernel/cpu/tsx.c
@@ -37,7 +37,7 @@ static void tsx_disable(void)
 	 */
 	tsx |= TSX_CTRL_CPUID_CLEAR;
 
-	wrmsrl(MSR_IA32_TSX_CTRL, tsx);
+	wrmsrq(MSR_IA32_TSX_CTRL, tsx);
 }
 
 static void tsx_enable(void)
@@ -56,7 +56,7 @@ static void tsx_enable(void)
 	 */
 	tsx &= ~TSX_CTRL_CPUID_CLEAR;
 
-	wrmsrl(MSR_IA32_TSX_CTRL, tsx);
+	wrmsrq(MSR_IA32_TSX_CTRL, tsx);
 }
 
 static enum tsx_ctrl_states x86_get_tsx_auto_mode(void)
@@ -117,11 +117,11 @@ static void tsx_clear_cpuid(void)
 	    boot_cpu_has(X86_FEATURE_TSX_FORCE_ABORT)) {
 		rdmsrq(MSR_TSX_FORCE_ABORT, msr);
 		msr |= MSR_TFA_TSX_CPUID_CLEAR;
-		wrmsrl(MSR_TSX_FORCE_ABORT, msr);
+		wrmsrq(MSR_TSX_FORCE_ABORT, msr);
 	} else if (cpu_feature_enabled(X86_FEATURE_MSR_TSX_CTRL)) {
 		rdmsrq(MSR_IA32_TSX_CTRL, msr);
 		msr |= TSX_CTRL_CPUID_CLEAR;
-		wrmsrl(MSR_IA32_TSX_CTRL, msr);
+		wrmsrq(MSR_IA32_TSX_CTRL, msr);
 	}
 }
 
@@ -150,7 +150,7 @@ static void tsx_dev_mode_disable(void)
 
 	if (mcu_opt_ctrl & RTM_ALLOW) {
 		mcu_opt_ctrl &= ~RTM_ALLOW;
-		wrmsrl(MSR_IA32_MCU_OPT_CTRL, mcu_opt_ctrl);
+		wrmsrq(MSR_IA32_MCU_OPT_CTRL, mcu_opt_ctrl);
 		setup_force_cpu_cap(X86_FEATURE_RTM_ALWAYS_ABORT);
 	}
 }
diff --git a/arch/x86/kernel/fpu/xstate.c b/arch/x86/kernel/fpu/xstate.c
index 6a41d16..2bd87b7 100644
--- a/arch/x86/kernel/fpu/xstate.c
+++ b/arch/x86/kernel/fpu/xstate.c
@@ -199,7 +199,7 @@ void fpu__init_cpu_xstate(void)
 	 * MSR_IA32_XSS sets supervisor states managed by XSAVES.
 	 */
 	if (boot_cpu_has(X86_FEATURE_XSAVES)) {
-		wrmsrl(MSR_IA32_XSS, xfeatures_mask_supervisor() |
+		wrmsrq(MSR_IA32_XSS, xfeatures_mask_supervisor() |
 				     xfeatures_mask_independent());
 	}
 }
@@ -639,7 +639,7 @@ static unsigned int __init get_xsave_compacted_size(void)
 		return get_compacted_size();
 
 	/* Disable independent features. */
-	wrmsrl(MSR_IA32_XSS, xfeatures_mask_supervisor());
+	wrmsrq(MSR_IA32_XSS, xfeatures_mask_supervisor());
 
 	/*
 	 * Ask the hardware what size is required of the buffer.
@@ -648,7 +648,7 @@ static unsigned int __init get_xsave_compacted_size(void)
 	size = get_compacted_size();
 
 	/* Re-enable independent features so XSAVES will work on them again. */
-	wrmsrl(MSR_IA32_XSS, xfeatures_mask_supervisor() | mask);
+	wrmsrq(MSR_IA32_XSS, xfeatures_mask_supervisor() | mask);
 
 	return size;
 }
@@ -904,12 +904,12 @@ void fpu__resume_cpu(void)
 	 * of XSAVES and MSR_IA32_XSS.
 	 */
 	if (cpu_feature_enabled(X86_FEATURE_XSAVES)) {
-		wrmsrl(MSR_IA32_XSS, xfeatures_mask_supervisor()  |
+		wrmsrq(MSR_IA32_XSS, xfeatures_mask_supervisor()  |
 				     xfeatures_mask_independent());
 	}
 
 	if (fpu_state_size_dynamic())
-		wrmsrl(MSR_IA32_XFD, current->thread.fpu.fpstate->xfd);
+		wrmsrq(MSR_IA32_XFD, current->thread.fpu.fpstate->xfd);
 }
 
 /*
diff --git a/arch/x86/kernel/fpu/xstate.h b/arch/x86/kernel/fpu/xstate.h
index 0fd34f5..5e5d350 100644
--- a/arch/x86/kernel/fpu/xstate.h
+++ b/arch/x86/kernel/fpu/xstate.h
@@ -171,7 +171,7 @@ static inline void xfd_validate_state(struct fpstate *fpstate, u64 mask, bool rs
 #ifdef CONFIG_X86_64
 static inline void xfd_set_state(u64 xfd)
 {
-	wrmsrl(MSR_IA32_XFD, xfd);
+	wrmsrq(MSR_IA32_XFD, xfd);
 	__this_cpu_write(xfd_state, xfd);
 }
 
diff --git a/arch/x86/kernel/fred.c b/arch/x86/kernel/fred.c
index 5e2cd10..10b0169 100644
--- a/arch/x86/kernel/fred.c
+++ b/arch/x86/kernel/fred.c
@@ -43,23 +43,23 @@ void cpu_init_fred_exceptions(void)
 	 */
 	loadsegment(ss, __KERNEL_DS);
 
-	wrmsrl(MSR_IA32_FRED_CONFIG,
+	wrmsrq(MSR_IA32_FRED_CONFIG,
 	       /* Reserve for CALL emulation */
 	       FRED_CONFIG_REDZONE |
 	       FRED_CONFIG_INT_STKLVL(0) |
 	       FRED_CONFIG_ENTRYPOINT(asm_fred_entrypoint_user));
 
-	wrmsrl(MSR_IA32_FRED_STKLVLS, 0);
+	wrmsrq(MSR_IA32_FRED_STKLVLS, 0);
 
 	/*
 	 * Ater a CPU offline/online cycle, the FRED RSP0 MSR should be
 	 * resynchronized with its per-CPU cache.
 	 */
-	wrmsrl(MSR_IA32_FRED_RSP0, __this_cpu_read(fred_rsp0));
+	wrmsrq(MSR_IA32_FRED_RSP0, __this_cpu_read(fred_rsp0));
 
-	wrmsrl(MSR_IA32_FRED_RSP1, 0);
-	wrmsrl(MSR_IA32_FRED_RSP2, 0);
-	wrmsrl(MSR_IA32_FRED_RSP3, 0);
+	wrmsrq(MSR_IA32_FRED_RSP1, 0);
+	wrmsrq(MSR_IA32_FRED_RSP2, 0);
+	wrmsrq(MSR_IA32_FRED_RSP3, 0);
 
 	/* Enable FRED */
 	cr4_set_bits(X86_CR4_FRED);
@@ -79,14 +79,14 @@ void cpu_init_fred_rsps(void)
 	 * (remember that user space faults are always taken on stack level 0)
 	 * is to avoid overflowing the kernel stack.
 	 */
-	wrmsrl(MSR_IA32_FRED_STKLVLS,
+	wrmsrq(MSR_IA32_FRED_STKLVLS,
 	       FRED_STKLVL(X86_TRAP_DB,  FRED_DB_STACK_LEVEL) |
 	       FRED_STKLVL(X86_TRAP_NMI, FRED_NMI_STACK_LEVEL) |
 	       FRED_STKLVL(X86_TRAP_MC,  FRED_MC_STACK_LEVEL) |
 	       FRED_STKLVL(X86_TRAP_DF,  FRED_DF_STACK_LEVEL));
 
 	/* The FRED equivalents to IST stacks... */
-	wrmsrl(MSR_IA32_FRED_RSP1, __this_cpu_ist_top_va(DB));
-	wrmsrl(MSR_IA32_FRED_RSP2, __this_cpu_ist_top_va(NMI));
-	wrmsrl(MSR_IA32_FRED_RSP3, __this_cpu_ist_top_va(DF));
+	wrmsrq(MSR_IA32_FRED_RSP1, __this_cpu_ist_top_va(DB));
+	wrmsrq(MSR_IA32_FRED_RSP2, __this_cpu_ist_top_va(NMI));
+	wrmsrq(MSR_IA32_FRED_RSP3, __this_cpu_ist_top_va(DF));
 }
diff --git a/arch/x86/kernel/kvm.c b/arch/x86/kernel/kvm.c
index f7aa39c..44a45df 100644
--- a/arch/x86/kernel/kvm.c
+++ b/arch/x86/kernel/kvm.c
@@ -301,7 +301,7 @@ DEFINE_IDTENTRY_SYSVEC(sysvec_kvm_asyncpf_interrupt)
 		token = __this_cpu_read(apf_reason.token);
 		kvm_async_pf_task_wake(token);
 		__this_cpu_write(apf_reason.token, 0);
-		wrmsrl(MSR_KVM_ASYNC_PF_ACK, 1);
+		wrmsrq(MSR_KVM_ASYNC_PF_ACK, 1);
 	}
 
 	set_irq_regs(old_regs);
@@ -327,7 +327,7 @@ static void kvm_register_steal_time(void)
 	if (!has_steal_clock)
 		return;
 
-	wrmsrl(MSR_KVM_STEAL_TIME, (slow_virt_to_phys(st) | KVM_MSR_ENABLED));
+	wrmsrq(MSR_KVM_STEAL_TIME, (slow_virt_to_phys(st) | KVM_MSR_ENABLED));
 	pr_debug("stealtime: cpu %d, msr %llx\n", cpu,
 		(unsigned long long) slow_virt_to_phys(st));
 }
@@ -361,9 +361,9 @@ static void kvm_guest_cpu_init(void)
 		if (kvm_para_has_feature(KVM_FEATURE_ASYNC_PF_VMEXIT))
 			pa |= KVM_ASYNC_PF_DELIVERY_AS_PF_VMEXIT;
 
-		wrmsrl(MSR_KVM_ASYNC_PF_INT, HYPERVISOR_CALLBACK_VECTOR);
+		wrmsrq(MSR_KVM_ASYNC_PF_INT, HYPERVISOR_CALLBACK_VECTOR);
 
-		wrmsrl(MSR_KVM_ASYNC_PF_EN, pa);
+		wrmsrq(MSR_KVM_ASYNC_PF_EN, pa);
 		__this_cpu_write(async_pf_enabled, true);
 		pr_debug("setup async PF for cpu %d\n", smp_processor_id());
 	}
@@ -376,7 +376,7 @@ static void kvm_guest_cpu_init(void)
 		__this_cpu_write(kvm_apic_eoi, 0);
 		pa = slow_virt_to_phys(this_cpu_ptr(&kvm_apic_eoi))
 			| KVM_MSR_ENABLED;
-		wrmsrl(MSR_KVM_PV_EOI_EN, pa);
+		wrmsrq(MSR_KVM_PV_EOI_EN, pa);
 	}
 
 	if (has_steal_clock)
@@ -388,7 +388,7 @@ static void kvm_pv_disable_apf(void)
 	if (!__this_cpu_read(async_pf_enabled))
 		return;
 
-	wrmsrl(MSR_KVM_ASYNC_PF_EN, 0);
+	wrmsrq(MSR_KVM_ASYNC_PF_EN, 0);
 	__this_cpu_write(async_pf_enabled, false);
 
 	pr_debug("disable async PF for cpu %d\n", smp_processor_id());
@@ -451,9 +451,9 @@ static void kvm_guest_cpu_offline(bool shutdown)
 {
 	kvm_disable_steal_time();
 	if (kvm_para_has_feature(KVM_FEATURE_PV_EOI))
-		wrmsrl(MSR_KVM_PV_EOI_EN, 0);
+		wrmsrq(MSR_KVM_PV_EOI_EN, 0);
 	if (kvm_para_has_feature(KVM_FEATURE_MIGRATION_CONTROL))
-		wrmsrl(MSR_KVM_MIGRATION_CONTROL, 0);
+		wrmsrq(MSR_KVM_MIGRATION_CONTROL, 0);
 	kvm_pv_disable_apf();
 	if (!shutdown)
 		apf_task_wake_all();
@@ -615,7 +615,7 @@ static int __init setup_efi_kvm_sev_migration(void)
 	}
 
 	pr_info("%s : live migration enabled in EFI\n", __func__);
-	wrmsrl(MSR_KVM_MIGRATION_CONTROL, KVM_MIGRATION_READY);
+	wrmsrq(MSR_KVM_MIGRATION_CONTROL, KVM_MIGRATION_READY);
 
 	return 1;
 }
@@ -740,7 +740,7 @@ static void kvm_resume(void)
 
 #ifdef CONFIG_ARCH_CPUIDLE_HALTPOLL
 	if (kvm_para_has_feature(KVM_FEATURE_POLL_CONTROL) && has_guest_poll)
-		wrmsrl(MSR_KVM_POLL_CONTROL, 0);
+		wrmsrq(MSR_KVM_POLL_CONTROL, 0);
 #endif
 }
 
@@ -975,7 +975,7 @@ static void __init kvm_init_platform(void)
 		 * If not booted using EFI, enable Live migration support.
 		 */
 		if (!efi_enabled(EFI_BOOT))
-			wrmsrl(MSR_KVM_MIGRATION_CONTROL,
+			wrmsrq(MSR_KVM_MIGRATION_CONTROL,
 			       KVM_MIGRATION_READY);
 	}
 	kvmclock_init();
@@ -1124,12 +1124,12 @@ out:
 
 static void kvm_disable_host_haltpoll(void *i)
 {
-	wrmsrl(MSR_KVM_POLL_CONTROL, 0);
+	wrmsrq(MSR_KVM_POLL_CONTROL, 0);
 }
 
 static void kvm_enable_host_haltpoll(void *i)
 {
-	wrmsrl(MSR_KVM_POLL_CONTROL, 1);
+	wrmsrq(MSR_KVM_POLL_CONTROL, 1);
 }
 
 void arch_haltpoll_enable(unsigned int cpu)
diff --git a/arch/x86/kernel/kvmclock.c b/arch/x86/kernel/kvmclock.c
index 5b2c152..0af7979 100644
--- a/arch/x86/kernel/kvmclock.c
+++ b/arch/x86/kernel/kvmclock.c
@@ -60,7 +60,7 @@ EXPORT_PER_CPU_SYMBOL_GPL(hv_clock_per_cpu);
  */
 static void kvm_get_wallclock(struct timespec64 *now)
 {
-	wrmsrl(msr_kvm_wall_clock, slow_virt_to_phys(&wall_clock));
+	wrmsrq(msr_kvm_wall_clock, slow_virt_to_phys(&wall_clock));
 	preempt_disable();
 	pvclock_read_wallclock(&wall_clock, this_cpu_pvti(), now);
 	preempt_enable();
@@ -173,7 +173,7 @@ static void kvm_register_clock(char *txt)
 		return;
 
 	pa = slow_virt_to_phys(&src->pvti) | 0x01ULL;
-	wrmsrl(msr_kvm_system_time, pa);
+	wrmsrq(msr_kvm_system_time, pa);
 	pr_debug("kvm-clock: cpu %d, msr %llx, %s", smp_processor_id(), pa, txt);
 }
 
diff --git a/arch/x86/kernel/mmconf-fam10h_64.c b/arch/x86/kernel/mmconf-fam10h_64.c
index 5c6a55f..ef6104e 100644
--- a/arch/x86/kernel/mmconf-fam10h_64.c
+++ b/arch/x86/kernel/mmconf-fam10h_64.c
@@ -212,7 +212,7 @@ void fam10h_check_enable_mmcfg(void)
 	     (FAM10H_MMIO_CONF_BUSRANGE_MASK<<FAM10H_MMIO_CONF_BUSRANGE_SHIFT));
 	val |= fam10h_pci_mmconf_base | (8 << FAM10H_MMIO_CONF_BUSRANGE_SHIFT) |
 	       FAM10H_MMIO_CONF_ENABLE;
-	wrmsrl(address, val);
+	wrmsrq(address, val);
 }
 
 static int __init set_check_enable_amd_mmconf(const struct dmi_system_id *d)
diff --git a/arch/x86/kernel/process.c b/arch/x86/kernel/process.c
index 197be71..c168f99 100644
--- a/arch/x86/kernel/process.c
+++ b/arch/x86/kernel/process.c
@@ -344,7 +344,7 @@ static void set_cpuid_faulting(bool on)
 	msrval &= ~MSR_MISC_FEATURES_ENABLES_CPUID_FAULT;
 	msrval |= (on << MSR_MISC_FEATURES_ENABLES_CPUID_FAULT_BIT);
 	this_cpu_write(msr_misc_features_shadow, msrval);
-	wrmsrl(MSR_MISC_FEATURES_ENABLES, msrval);
+	wrmsrq(MSR_MISC_FEATURES_ENABLES, msrval);
 }
 
 static void disable_cpuid(void)
@@ -561,7 +561,7 @@ static __always_inline void amd_set_core_ssb_state(unsigned long tifn)
 
 	if (!static_cpu_has(X86_FEATURE_ZEN)) {
 		msr |= ssbd_tif_to_amd_ls_cfg(tifn);
-		wrmsrl(MSR_AMD64_LS_CFG, msr);
+		wrmsrq(MSR_AMD64_LS_CFG, msr);
 		return;
 	}
 
@@ -578,7 +578,7 @@ static __always_inline void amd_set_core_ssb_state(unsigned long tifn)
 		raw_spin_lock(&st->shared_state->lock);
 		/* First sibling enables SSBD: */
 		if (!st->shared_state->disable_state)
-			wrmsrl(MSR_AMD64_LS_CFG, msr);
+			wrmsrq(MSR_AMD64_LS_CFG, msr);
 		st->shared_state->disable_state++;
 		raw_spin_unlock(&st->shared_state->lock);
 	} else {
@@ -588,7 +588,7 @@ static __always_inline void amd_set_core_ssb_state(unsigned long tifn)
 		raw_spin_lock(&st->shared_state->lock);
 		st->shared_state->disable_state--;
 		if (!st->shared_state->disable_state)
-			wrmsrl(MSR_AMD64_LS_CFG, msr);
+			wrmsrq(MSR_AMD64_LS_CFG, msr);
 		raw_spin_unlock(&st->shared_state->lock);
 	}
 }
@@ -597,7 +597,7 @@ static __always_inline void amd_set_core_ssb_state(unsigned long tifn)
 {
 	u64 msr = x86_amd_ls_cfg_base | ssbd_tif_to_amd_ls_cfg(tifn);
 
-	wrmsrl(MSR_AMD64_LS_CFG, msr);
+	wrmsrq(MSR_AMD64_LS_CFG, msr);
 }
 #endif
 
@@ -607,7 +607,7 @@ static __always_inline void amd_set_ssb_virt_state(unsigned long tifn)
 	 * SSBD has the same definition in SPEC_CTRL and VIRT_SPEC_CTRL,
 	 * so ssbd_tif_to_spec_ctrl() just works.
 	 */
-	wrmsrl(MSR_AMD64_VIRT_SPEC_CTRL, ssbd_tif_to_spec_ctrl(tifn));
+	wrmsrq(MSR_AMD64_VIRT_SPEC_CTRL, ssbd_tif_to_spec_ctrl(tifn));
 }
 
 /*
@@ -714,7 +714,7 @@ void __switch_to_xtra(struct task_struct *prev_p, struct task_struct *next_p)
 		debugctl &= ~DEBUGCTLMSR_BTF;
 		msk = tifn & _TIF_BLOCKSTEP;
 		debugctl |= (msk >> TIF_BLOCKSTEP) << DEBUGCTLMSR_BTF_SHIFT;
-		wrmsrl(MSR_IA32_DEBUGCTLMSR, debugctl);
+		wrmsrq(MSR_IA32_DEBUGCTLMSR, debugctl);
 	}
 
 	if ((tifp ^ tifn) & _TIF_NOTSC)
diff --git a/arch/x86/kernel/process_64.c b/arch/x86/kernel/process_64.c
index 422c5da..24e1ccf 100644
--- a/arch/x86/kernel/process_64.c
+++ b/arch/x86/kernel/process_64.c
@@ -221,7 +221,7 @@ static noinstr void __wrgsbase_inactive(unsigned long gsbase)
 		native_swapgs();
 	} else {
 		instrumentation_begin();
-		wrmsrl(MSR_KERNEL_GS_BASE, gsbase);
+		wrmsrq(MSR_KERNEL_GS_BASE, gsbase);
 		instrumentation_end();
 	}
 }
@@ -353,7 +353,7 @@ static __always_inline void load_seg_legacy(unsigned short prev_index,
 		} else {
 			if (prev_index != next_index)
 				loadseg(which, next_index);
-			wrmsrl(which == FS ? MSR_FS_BASE : MSR_KERNEL_GS_BASE,
+			wrmsrq(which == FS ? MSR_FS_BASE : MSR_KERNEL_GS_BASE,
 			       next_base);
 		}
 	} else {
@@ -478,7 +478,7 @@ void x86_gsbase_write_cpu_inactive(unsigned long gsbase)
 		__wrgsbase_inactive(gsbase);
 		local_irq_restore(flags);
 	} else {
-		wrmsrl(MSR_KERNEL_GS_BASE, gsbase);
+		wrmsrq(MSR_KERNEL_GS_BASE, gsbase);
 	}
 }
 
diff --git a/arch/x86/kernel/reboot_fixups_32.c b/arch/x86/kernel/reboot_fixups_32.c
index b7c0f14..4679ac0 100644
--- a/arch/x86/kernel/reboot_fixups_32.c
+++ b/arch/x86/kernel/reboot_fixups_32.c
@@ -27,7 +27,7 @@ static void cs5530a_warm_reset(struct pci_dev *dev)
 static void cs5536_warm_reset(struct pci_dev *dev)
 {
 	/* writing 1 to the LSB of this MSR causes a hard reset */
-	wrmsrl(MSR_DIVIL_SOFT_RESET, 1ULL);
+	wrmsrq(MSR_DIVIL_SOFT_RESET, 1ULL);
 	udelay(50); /* shouldn't get here but be safe and spin a while */
 }
 
diff --git a/arch/x86/kernel/shstk.c b/arch/x86/kernel/shstk.c
index 3d1ba20..2ddf233 100644
--- a/arch/x86/kernel/shstk.c
+++ b/arch/x86/kernel/shstk.c
@@ -173,8 +173,8 @@ static int shstk_setup(void)
 		return PTR_ERR((void *)addr);
 
 	fpregs_lock_and_load();
-	wrmsrl(MSR_IA32_PL3_SSP, addr + size);
-	wrmsrl(MSR_IA32_U_CET, CET_SHSTK_EN);
+	wrmsrq(MSR_IA32_PL3_SSP, addr + size);
+	wrmsrq(MSR_IA32_U_CET, CET_SHSTK_EN);
 	fpregs_unlock();
 
 	shstk->base = addr;
@@ -372,7 +372,7 @@ int setup_signal_shadow_stack(struct ksignal *ksig)
 		return -EFAULT;
 
 	fpregs_lock_and_load();
-	wrmsrl(MSR_IA32_PL3_SSP, ssp);
+	wrmsrq(MSR_IA32_PL3_SSP, ssp);
 	fpregs_unlock();
 
 	return 0;
@@ -396,7 +396,7 @@ int restore_signal_shadow_stack(void)
 		return err;
 
 	fpregs_lock_and_load();
-	wrmsrl(MSR_IA32_PL3_SSP, ssp);
+	wrmsrq(MSR_IA32_PL3_SSP, ssp);
 	fpregs_unlock();
 
 	return 0;
@@ -473,7 +473,7 @@ static int wrss_control(bool enable)
 		msrval &= ~CET_WRSS_EN;
 	}
 
-	wrmsrl(MSR_IA32_U_CET, msrval);
+	wrmsrq(MSR_IA32_U_CET, msrval);
 
 unlock:
 	fpregs_unlock();
@@ -492,8 +492,8 @@ static int shstk_disable(void)
 
 	fpregs_lock_and_load();
 	/* Disable WRSS too when disabling shadow stack */
-	wrmsrl(MSR_IA32_U_CET, 0);
-	wrmsrl(MSR_IA32_PL3_SSP, 0);
+	wrmsrq(MSR_IA32_U_CET, 0);
+	wrmsrq(MSR_IA32_PL3_SSP, 0);
 	fpregs_unlock();
 
 	shstk_free(current);
diff --git a/arch/x86/kernel/traps.c b/arch/x86/kernel/traps.c
index 71b1467..823410a 100644
--- a/arch/x86/kernel/traps.c
+++ b/arch/x86/kernel/traps.c
@@ -749,7 +749,7 @@ static bool try_fixup_enqcmd_gp(void)
 	if (current->pasid_activated)
 		return false;
 
-	wrmsrl(MSR_IA32_PASID, pasid | MSR_IA32_PASID_VALID);
+	wrmsrq(MSR_IA32_PASID, pasid | MSR_IA32_PASID_VALID);
 	current->pasid_activated = 1;
 
 	return true;
@@ -1122,7 +1122,7 @@ static noinstr void exc_debug_kernel(struct pt_regs *regs, unsigned long dr6)
 
 		rdmsrq(MSR_IA32_DEBUGCTLMSR, debugctl);
 		debugctl |= DEBUGCTLMSR_BTF;
-		wrmsrl(MSR_IA32_DEBUGCTLMSR, debugctl);
+		wrmsrq(MSR_IA32_DEBUGCTLMSR, debugctl);
 	}
 
 	/*
@@ -1390,7 +1390,7 @@ static bool handle_xfd_event(struct pt_regs *regs)
 	if (!xfd_err)
 		return false;
 
-	wrmsrl(MSR_IA32_XFD_ERR, 0);
+	wrmsrq(MSR_IA32_XFD_ERR, 0);
 
 	/* Die if that happens in kernel space */
 	if (WARN_ON(!user_mode(regs)))
diff --git a/arch/x86/kernel/tsc_sync.c b/arch/x86/kernel/tsc_sync.c
index 8260391..f1c7a86 100644
--- a/arch/x86/kernel/tsc_sync.c
+++ b/arch/x86/kernel/tsc_sync.c
@@ -70,7 +70,7 @@ void tsc_verify_tsc_adjust(bool resume)
 		return;
 
 	/* Restore the original value */
-	wrmsrl(MSR_IA32_TSC_ADJUST, adj->adjusted);
+	wrmsrq(MSR_IA32_TSC_ADJUST, adj->adjusted);
 
 	if (!adj->warned || resume) {
 		pr_warn(FW_BUG "TSC ADJUST differs: CPU%u %lld --> %lld. Restoring\n",
@@ -142,7 +142,7 @@ static void tsc_sanitize_first_cpu(struct tsc_adjust *cur, s64 bootval,
 		if (likely(!tsc_async_resets)) {
 			pr_warn(FW_BUG "TSC ADJUST: CPU%u: %lld force to 0\n",
 				cpu, bootval);
-			wrmsrl(MSR_IA32_TSC_ADJUST, 0);
+			wrmsrq(MSR_IA32_TSC_ADJUST, 0);
 			bootval = 0;
 		} else {
 			pr_info("TSC ADJUST: CPU%u: %lld NOT forced to 0\n",
@@ -229,7 +229,7 @@ bool tsc_store_and_check_tsc_adjust(bool bootcpu)
 	 */
 	if (bootval != ref->adjusted) {
 		cur->adjusted = ref->adjusted;
-		wrmsrl(MSR_IA32_TSC_ADJUST, ref->adjusted);
+		wrmsrq(MSR_IA32_TSC_ADJUST, ref->adjusted);
 	}
 	/*
 	 * We have the TSCs forced to be in sync on this package. Skip sync
@@ -518,7 +518,7 @@ retry:
 	pr_warn("TSC ADJUST compensate: CPU%u observed %lld warp. Adjust: %lld\n",
 		cpu, cur_max_warp, cur->adjusted);
 
-	wrmsrl(MSR_IA32_TSC_ADJUST, cur->adjusted);
+	wrmsrq(MSR_IA32_TSC_ADJUST, cur->adjusted);
 	goto retry;
 
 }
diff --git a/arch/x86/kvm/svm/avic.c b/arch/x86/kvm/svm/avic.c
index 65fd245..5184210 100644
--- a/arch/x86/kvm/svm/avic.c
+++ b/arch/x86/kvm/svm/avic.c
@@ -330,7 +330,7 @@ void avic_ring_doorbell(struct kvm_vcpu *vcpu)
 	int cpu = READ_ONCE(vcpu->cpu);
 
 	if (cpu != get_cpu()) {
-		wrmsrl(MSR_AMD64_SVM_AVIC_DOORBELL, kvm_cpu_get_apicid(cpu));
+		wrmsrq(MSR_AMD64_SVM_AVIC_DOORBELL, kvm_cpu_get_apicid(cpu));
 		trace_kvm_avic_doorbell(vcpu->vcpu_id, kvm_cpu_get_apicid(cpu));
 	}
 	put_cpu();
diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index 21c3563..67657b3 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -566,7 +566,7 @@ static void __svm_write_tsc_multiplier(u64 multiplier)
 	if (multiplier == __this_cpu_read(current_tsc_ratio))
 		return;
 
-	wrmsrl(MSR_AMD64_TSC_RATIO, multiplier);
+	wrmsrq(MSR_AMD64_TSC_RATIO, multiplier);
 	__this_cpu_write(current_tsc_ratio, multiplier);
 }
 
@@ -579,7 +579,7 @@ static inline void kvm_cpu_svm_disable(void)
 {
 	uint64_t efer;
 
-	wrmsrl(MSR_VM_HSAVE_PA, 0);
+	wrmsrq(MSR_VM_HSAVE_PA, 0);
 	rdmsrq(MSR_EFER, efer);
 	if (efer & EFER_SVME) {
 		/*
@@ -587,7 +587,7 @@ static inline void kvm_cpu_svm_disable(void)
 		 * NMI aren't blocked.
 		 */
 		stgi();
-		wrmsrl(MSR_EFER, efer & ~EFER_SVME);
+		wrmsrq(MSR_EFER, efer & ~EFER_SVME);
 	}
 }
 
@@ -629,9 +629,9 @@ static int svm_enable_virtualization_cpu(void)
 	sd->next_asid = sd->max_asid + 1;
 	sd->min_asid = max_sev_asid + 1;
 
-	wrmsrl(MSR_EFER, efer | EFER_SVME);
+	wrmsrq(MSR_EFER, efer | EFER_SVME);
 
-	wrmsrl(MSR_VM_HSAVE_PA, sd->save_area_pa);
+	wrmsrq(MSR_VM_HSAVE_PA, sd->save_area_pa);
 
 	if (static_cpu_has(X86_FEATURE_TSCRATEMSR)) {
 		/*
diff --git a/arch/x86/kvm/vmx/pmu_intel.c b/arch/x86/kvm/vmx/pmu_intel.c
index f0f02ee..5e0bb82 100644
--- a/arch/x86/kvm/vmx/pmu_intel.c
+++ b/arch/x86/kvm/vmx/pmu_intel.c
@@ -281,7 +281,7 @@ static bool intel_pmu_handle_lbr_msrs_access(struct kvm_vcpu *vcpu,
 		if (read)
 			rdmsrq(index, msr_info->data);
 		else
-			wrmsrl(index, msr_info->data);
+			wrmsrq(index, msr_info->data);
 		__set_bit(INTEL_PMC_IDX_FIXED_VLBR, vcpu_to_pmu(vcpu)->pmc_in_use);
 		local_irq_enable();
 		return true;
diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index 3e0762a..0e12a3a 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -1063,7 +1063,7 @@ static void add_atomic_switch_msr(struct vcpu_vmx *vmx, unsigned msr,
 		 * provide that period, so a CPU could write host's record into
 		 * guest's memory.
 		 */
-		wrmsrl(MSR_IA32_PEBS_ENABLE, 0);
+		wrmsrq(MSR_IA32_PEBS_ENABLE, 0);
 	}
 
 	i = vmx_find_loadstore_msr_slot(&m->guest, msr);
@@ -1192,13 +1192,13 @@ static inline void pt_load_msr(struct pt_ctx *ctx, u32 addr_range)
 {
 	u32 i;
 
-	wrmsrl(MSR_IA32_RTIT_STATUS, ctx->status);
-	wrmsrl(MSR_IA32_RTIT_OUTPUT_BASE, ctx->output_base);
-	wrmsrl(MSR_IA32_RTIT_OUTPUT_MASK, ctx->output_mask);
-	wrmsrl(MSR_IA32_RTIT_CR3_MATCH, ctx->cr3_match);
+	wrmsrq(MSR_IA32_RTIT_STATUS, ctx->status);
+	wrmsrq(MSR_IA32_RTIT_OUTPUT_BASE, ctx->output_base);
+	wrmsrq(MSR_IA32_RTIT_OUTPUT_MASK, ctx->output_mask);
+	wrmsrq(MSR_IA32_RTIT_CR3_MATCH, ctx->cr3_match);
 	for (i = 0; i < addr_range; i++) {
-		wrmsrl(MSR_IA32_RTIT_ADDR0_A + i * 2, ctx->addr_a[i]);
-		wrmsrl(MSR_IA32_RTIT_ADDR0_B + i * 2, ctx->addr_b[i]);
+		wrmsrq(MSR_IA32_RTIT_ADDR0_A + i * 2, ctx->addr_a[i]);
+		wrmsrq(MSR_IA32_RTIT_ADDR0_B + i * 2, ctx->addr_b[i]);
 	}
 }
 
@@ -1227,7 +1227,7 @@ static void pt_guest_enter(struct vcpu_vmx *vmx)
 	 */
 	rdmsrq(MSR_IA32_RTIT_CTL, vmx->pt_desc.host.ctl);
 	if (vmx->pt_desc.guest.ctl & RTIT_CTL_TRACEEN) {
-		wrmsrl(MSR_IA32_RTIT_CTL, 0);
+		wrmsrq(MSR_IA32_RTIT_CTL, 0);
 		pt_save_msr(&vmx->pt_desc.host, vmx->pt_desc.num_address_ranges);
 		pt_load_msr(&vmx->pt_desc.guest, vmx->pt_desc.num_address_ranges);
 	}
@@ -1248,7 +1248,7 @@ static void pt_guest_exit(struct vcpu_vmx *vmx)
 	 * i.e. RTIT_CTL is always cleared on VM-Exit.  Restore it if necessary.
 	 */
 	if (vmx->pt_desc.host.ctl)
-		wrmsrl(MSR_IA32_RTIT_CTL, vmx->pt_desc.host.ctl);
+		wrmsrq(MSR_IA32_RTIT_CTL, vmx->pt_desc.host.ctl);
 }
 
 void vmx_set_host_fs_gs(struct vmcs_host_state *host, u16 fs_sel, u16 gs_sel,
@@ -1338,7 +1338,7 @@ void vmx_prepare_switch_to_guest(struct kvm_vcpu *vcpu)
 		vmx->msr_host_kernel_gs_base = read_msr(MSR_KERNEL_GS_BASE);
 	}
 
-	wrmsrl(MSR_KERNEL_GS_BASE, vmx->msr_guest_kernel_gs_base);
+	wrmsrq(MSR_KERNEL_GS_BASE, vmx->msr_guest_kernel_gs_base);
 #else
 	savesegment(fs, fs_sel);
 	savesegment(gs, gs_sel);
@@ -1382,7 +1382,7 @@ static void vmx_prepare_switch_to_host(struct vcpu_vmx *vmx)
 #endif
 	invalidate_tss_limit();
 #ifdef CONFIG_X86_64
-	wrmsrl(MSR_KERNEL_GS_BASE, vmx->msr_host_kernel_gs_base);
+	wrmsrq(MSR_KERNEL_GS_BASE, vmx->msr_host_kernel_gs_base);
 #endif
 	load_fixmap_gdt(raw_smp_processor_id());
 	vmx->guest_state_loaded = false;
@@ -1403,7 +1403,7 @@ static void vmx_write_guest_kernel_gs_base(struct vcpu_vmx *vmx, u64 data)
 {
 	preempt_disable();
 	if (vmx->guest_state_loaded)
-		wrmsrl(MSR_KERNEL_GS_BASE, data);
+		wrmsrq(MSR_KERNEL_GS_BASE, data);
 	preempt_enable();
 	vmx->msr_guest_kernel_gs_base = data;
 }
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index c96c2ca..36504a1 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -578,7 +578,7 @@ static void kvm_on_user_return(struct user_return_notifier *urn)
 	for (slot = 0; slot < kvm_nr_uret_msrs; ++slot) {
 		values = &msrs->values[slot];
 		if (values->host != values->curr) {
-			wrmsrl(kvm_uret_msrs_list[slot], values->host);
+			wrmsrq(kvm_uret_msrs_list[slot], values->host);
 			values->curr = values->host;
 		}
 	}
@@ -1174,7 +1174,7 @@ void kvm_load_guest_xsave_state(struct kvm_vcpu *vcpu)
 
 		if (guest_cpu_cap_has(vcpu, X86_FEATURE_XSAVES) &&
 		    vcpu->arch.ia32_xss != kvm_host.xss)
-			wrmsrl(MSR_IA32_XSS, vcpu->arch.ia32_xss);
+			wrmsrq(MSR_IA32_XSS, vcpu->arch.ia32_xss);
 	}
 
 	if (cpu_feature_enabled(X86_FEATURE_PKU) &&
@@ -1205,7 +1205,7 @@ void kvm_load_host_xsave_state(struct kvm_vcpu *vcpu)
 
 		if (guest_cpu_cap_has(vcpu, X86_FEATURE_XSAVES) &&
 		    vcpu->arch.ia32_xss != kvm_host.xss)
-			wrmsrl(MSR_IA32_XSS, kvm_host.xss);
+			wrmsrq(MSR_IA32_XSS, kvm_host.xss);
 	}
 
 }
@@ -3827,7 +3827,7 @@ int kvm_set_msr_common(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
 		if (!data)
 			break;
 
-		wrmsrl(MSR_IA32_PRED_CMD, data);
+		wrmsrq(MSR_IA32_PRED_CMD, data);
 		break;
 	}
 	case MSR_IA32_FLUSH_CMD:
@@ -3840,7 +3840,7 @@ int kvm_set_msr_common(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
 		if (!data)
 			break;
 
-		wrmsrl(MSR_IA32_FLUSH_CMD, L1D_FLUSH);
+		wrmsrq(MSR_IA32_FLUSH_CMD, L1D_FLUSH);
 		break;
 	case MSR_EFER:
 		return set_efer(vcpu, msr_info);
@@ -10974,7 +10974,7 @@ static int vcpu_enter_guest(struct kvm_vcpu *vcpu)
 		switch_fpu_return();
 
 	if (vcpu->arch.guest_fpu.xfd_err)
-		wrmsrl(MSR_IA32_XFD_ERR, vcpu->arch.guest_fpu.xfd_err);
+		wrmsrq(MSR_IA32_XFD_ERR, vcpu->arch.guest_fpu.xfd_err);
 
 	if (unlikely(vcpu->arch.switch_db_regs)) {
 		set_debugreg(0, 7);
@@ -11060,7 +11060,7 @@ static int vcpu_enter_guest(struct kvm_vcpu *vcpu)
 	kvm_x86_call(handle_exit_irqoff)(vcpu);
 
 	if (vcpu->arch.guest_fpu.xfd_err)
-		wrmsrl(MSR_IA32_XFD_ERR, 0);
+		wrmsrq(MSR_IA32_XFD_ERR, 0);
 
 	/*
 	 * Consume any pending interrupts, including the possible source of
@@ -13657,7 +13657,7 @@ int kvm_spec_ctrl_test_value(u64 value)
 	else if (wrmsrl_safe(MSR_IA32_SPEC_CTRL, value))
 		ret = 1;
 	else
-		wrmsrl(MSR_IA32_SPEC_CTRL, saved_value);
+		wrmsrq(MSR_IA32_SPEC_CTRL, saved_value);
 
 	local_irq_restore(flags);
 
diff --git a/arch/x86/mm/pat/memtype.c b/arch/x86/mm/pat/memtype.c
index ce6105e..72e87ee 100644
--- a/arch/x86/mm/pat/memtype.c
+++ b/arch/x86/mm/pat/memtype.c
@@ -232,7 +232,7 @@ void pat_cpu_init(void)
 		panic("x86/PAT: PAT enabled, but not supported by secondary CPU\n");
 	}
 
-	wrmsrl(MSR_IA32_CR_PAT, pat_msr_val);
+	wrmsrq(MSR_IA32_CR_PAT, pat_msr_val);
 
 	__flush_tlb_all();
 }
diff --git a/arch/x86/mm/tlb.c b/arch/x86/mm/tlb.c
index e459d97..b1d5212 100644
--- a/arch/x86/mm/tlb.c
+++ b/arch/x86/mm/tlb.c
@@ -623,7 +623,7 @@ static void l1d_flush_evaluate(unsigned long prev_mm, unsigned long next_mm,
 {
 	/* Flush L1D if the outgoing task requests it */
 	if (prev_mm & LAST_USER_MM_L1D_FLUSH)
-		wrmsrl(MSR_IA32_FLUSH_CMD, L1D_FLUSH);
+		wrmsrq(MSR_IA32_FLUSH_CMD, L1D_FLUSH);
 
 	/* Check whether the incoming task opted in for L1D flush */
 	if (likely(!(next_mm & LAST_USER_MM_L1D_FLUSH)))
diff --git a/arch/x86/pci/amd_bus.c b/arch/x86/pci/amd_bus.c
index b92917c..6158f65 100644
--- a/arch/x86/pci/amd_bus.c
+++ b/arch/x86/pci/amd_bus.c
@@ -344,7 +344,7 @@ static int amd_bus_cpu_online(unsigned int cpu)
 	rdmsrq(MSR_AMD64_NB_CFG, reg);
 	if (!(reg & ENABLE_CF8_EXT_CFG)) {
 		reg |= ENABLE_CF8_EXT_CFG;
-		wrmsrl(MSR_AMD64_NB_CFG, reg);
+		wrmsrq(MSR_AMD64_NB_CFG, reg);
 	}
 	return 0;
 }
diff --git a/arch/x86/platform/olpc/olpc-xo1-sci.c b/arch/x86/platform/olpc/olpc-xo1-sci.c
index 63066e7..30751b4 100644
--- a/arch/x86/platform/olpc/olpc-xo1-sci.c
+++ b/arch/x86/platform/olpc/olpc-xo1-sci.c
@@ -325,7 +325,7 @@ static int setup_sci_interrupt(struct platform_device *pdev)
 		dev_info(&pdev->dev, "SCI unmapped. Mapping to IRQ 3\n");
 		sci_irq = 3;
 		lo |= 0x00300000;
-		wrmsrl(0x51400020, lo);
+		wrmsrq(0x51400020, lo);
 	}
 
 	/* Select level triggered in PIC */
diff --git a/arch/x86/power/cpu.c b/arch/x86/power/cpu.c
index 874fe98..78903d3 100644
--- a/arch/x86/power/cpu.c
+++ b/arch/x86/power/cpu.c
@@ -56,7 +56,7 @@ static void msr_restore_context(struct saved_context *ctxt)
 
 	while (msr < end) {
 		if (msr->valid)
-			wrmsrl(msr->info.msr_no, msr->info.reg.q);
+			wrmsrq(msr->info.msr_no, msr->info.reg.q);
 		msr++;
 	}
 }
@@ -198,7 +198,7 @@ static void notrace __restore_processor_state(struct saved_context *ctxt)
 	struct cpuinfo_x86 *c;
 
 	if (ctxt->misc_enable_saved)
-		wrmsrl(MSR_IA32_MISC_ENABLE, ctxt->misc_enable);
+		wrmsrq(MSR_IA32_MISC_ENABLE, ctxt->misc_enable);
 	/*
 	 * control registers
 	 */
@@ -208,7 +208,7 @@ static void notrace __restore_processor_state(struct saved_context *ctxt)
 		__write_cr4(ctxt->cr4);
 #else
 /* CONFIG X86_64 */
-	wrmsrl(MSR_EFER, ctxt->efer);
+	wrmsrq(MSR_EFER, ctxt->efer);
 	__write_cr4(ctxt->cr4);
 #endif
 	write_cr3(ctxt->cr3);
@@ -231,7 +231,7 @@ static void notrace __restore_processor_state(struct saved_context *ctxt)
 	 * handlers or in complicated helpers like load_gs_index().
 	 */
 #ifdef CONFIG_X86_64
-	wrmsrl(MSR_GS_BASE, ctxt->kernelmode_gs_base);
+	wrmsrq(MSR_GS_BASE, ctxt->kernelmode_gs_base);
 
 	/*
 	 * Reinitialize FRED to ensure the FRED MSRs contain the same values
@@ -267,8 +267,8 @@ static void notrace __restore_processor_state(struct saved_context *ctxt)
 	 * restoring the selectors clobbers the bases.  Keep in mind
 	 * that MSR_KERNEL_GS_BASE is horribly misnamed.
 	 */
-	wrmsrl(MSR_FS_BASE, ctxt->fs_base);
-	wrmsrl(MSR_KERNEL_GS_BASE, ctxt->usermode_gs_base);
+	wrmsrq(MSR_FS_BASE, ctxt->fs_base);
+	wrmsrq(MSR_KERNEL_GS_BASE, ctxt->usermode_gs_base);
 #else
 	loadsegment(gs, ctxt->gs);
 #endif
diff --git a/arch/x86/virt/svm/sev.c b/arch/x86/virt/svm/sev.c
index 9ddd102..334177c 100644
--- a/arch/x86/virt/svm/sev.c
+++ b/arch/x86/virt/svm/sev.c
@@ -140,7 +140,7 @@ static int __mfd_enable(unsigned int cpu)
 
 	val |= MSR_AMD64_SYSCFG_MFDM;
 
-	wrmsrl(MSR_AMD64_SYSCFG, val);
+	wrmsrq(MSR_AMD64_SYSCFG, val);
 
 	return 0;
 }
@@ -162,7 +162,7 @@ static int __snp_enable(unsigned int cpu)
 	val |= MSR_AMD64_SYSCFG_SNP_EN;
 	val |= MSR_AMD64_SYSCFG_SNP_VMPL_EN;
 
-	wrmsrl(MSR_AMD64_SYSCFG, val);
+	wrmsrq(MSR_AMD64_SYSCFG, val);
 
 	return 0;
 }
diff --git a/arch/x86/xen/suspend.c b/arch/x86/xen/suspend.c
index cacac3d..7bb3ac2 100644
--- a/arch/x86/xen/suspend.c
+++ b/arch/x86/xen/suspend.c
@@ -39,7 +39,7 @@ void xen_arch_post_suspend(int cancelled)
 static void xen_vcpu_notify_restore(void *data)
 {
 	if (xen_pv_domain() && boot_cpu_has(X86_FEATURE_SPEC_CTRL))
-		wrmsrl(MSR_IA32_SPEC_CTRL, this_cpu_read(spec_ctrl));
+		wrmsrq(MSR_IA32_SPEC_CTRL, this_cpu_read(spec_ctrl));
 
 	/* Boot processor notified via generic timekeeping_resume() */
 	if (smp_processor_id() == 0)
@@ -57,7 +57,7 @@ static void xen_vcpu_notify_suspend(void *data)
 	if (xen_pv_domain() && boot_cpu_has(X86_FEATURE_SPEC_CTRL)) {
 		rdmsrq(MSR_IA32_SPEC_CTRL, tmp);
 		this_cpu_write(spec_ctrl, tmp);
-		wrmsrl(MSR_IA32_SPEC_CTRL, 0);
+		wrmsrq(MSR_IA32_SPEC_CTRL, 0);
 	}
 }
 
diff --git a/drivers/cpufreq/acpi-cpufreq.c b/drivers/cpufreq/acpi-cpufreq.c
index 8e31c25..d19867c 100644
--- a/drivers/cpufreq/acpi-cpufreq.c
+++ b/drivers/cpufreq/acpi-cpufreq.c
@@ -117,7 +117,7 @@ static int boost_set_msr(bool enable)
 	else
 		val |= msr_mask;
 
-	wrmsrl(msr_addr, val);
+	wrmsrq(msr_addr, val);
 	return 0;
 }
 
diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index 2b673ac..b7caaa8 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -258,7 +258,7 @@ static int msr_update_perf(struct cpufreq_policy *policy, u8 min_perf,
 		return 0;
 
 	if (fast_switch) {
-		wrmsrl(MSR_AMD_CPPC_REQ, value);
+		wrmsrq(MSR_AMD_CPPC_REQ, value);
 		return 0;
 	} else {
 		int ret = wrmsrl_on_cpu(cpudata->cpu, MSR_AMD_CPPC_REQ, value);
diff --git a/drivers/cpufreq/e_powersaver.c b/drivers/cpufreq/e_powersaver.c
index 6d6afcd..320a0af 100644
--- a/drivers/cpufreq/e_powersaver.c
+++ b/drivers/cpufreq/e_powersaver.c
@@ -228,7 +228,7 @@ static int eps_cpu_init(struct cpufreq_policy *policy)
 	rdmsrq(MSR_IA32_MISC_ENABLE, val);
 	if (!(val & MSR_IA32_MISC_ENABLE_ENHANCED_SPEEDSTEP)) {
 		val |= MSR_IA32_MISC_ENABLE_ENHANCED_SPEEDSTEP;
-		wrmsrl(MSR_IA32_MISC_ENABLE, val);
+		wrmsrq(MSR_IA32_MISC_ENABLE, val);
 		/* Can be locked at 0 */
 		rdmsrq(MSR_IA32_MISC_ENABLE, val);
 		if (!(val & MSR_IA32_MISC_ENABLE_ENHANCED_SPEEDSTEP)) {
diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
index d66a474..3883a2b 100644
--- a/drivers/cpufreq/intel_pstate.c
+++ b/drivers/cpufreq/intel_pstate.c
@@ -1293,7 +1293,7 @@ static void set_power_ctl_ee_state(bool input)
 		power_ctl |= BIT(MSR_IA32_POWER_CTL_BIT_EE);
 		power_ctl_ee_state = POWER_CTL_EE_DISABLE;
 	}
-	wrmsrl(MSR_IA32_POWER_CTL, power_ctl);
+	wrmsrq(MSR_IA32_POWER_CTL, power_ctl);
 	mutex_unlock(&intel_pstate_driver_lock);
 }
 
@@ -2351,7 +2351,7 @@ static inline void intel_pstate_hwp_boost_up(struct cpudata *cpu)
 		return;
 
 	hwp_req = (hwp_req & ~GENMASK_ULL(7, 0)) | cpu->hwp_boost_min;
-	wrmsrl(MSR_HWP_REQUEST, hwp_req);
+	wrmsrq(MSR_HWP_REQUEST, hwp_req);
 	cpu->last_update = cpu->sample.time;
 }
 
@@ -2364,7 +2364,7 @@ static inline void intel_pstate_hwp_boost_down(struct cpudata *cpu)
 		expired = time_after64(cpu->sample.time, cpu->last_update +
 				       hwp_boost_hold_time_ns);
 		if (expired) {
-			wrmsrl(MSR_HWP_REQUEST, cpu->hwp_req_cached);
+			wrmsrq(MSR_HWP_REQUEST, cpu->hwp_req_cached);
 			cpu->hwp_boost_min = 0;
 		}
 	}
@@ -2520,7 +2520,7 @@ static void intel_pstate_update_pstate(struct cpudata *cpu, int pstate)
 		return;
 
 	cpu->pstate.current_pstate = pstate;
-	wrmsrl(MSR_IA32_PERF_CTL, pstate_funcs.get_val(cpu, pstate));
+	wrmsrq(MSR_IA32_PERF_CTL, pstate_funcs.get_val(cpu, pstate));
 }
 
 static void intel_pstate_adjust_pstate(struct cpudata *cpu)
@@ -3100,7 +3100,7 @@ static void intel_cpufreq_hwp_update(struct cpudata *cpu, u32 min, u32 max,
 
 	WRITE_ONCE(cpu->hwp_req_cached, value);
 	if (fast_switch)
-		wrmsrl(MSR_HWP_REQUEST, value);
+		wrmsrq(MSR_HWP_REQUEST, value);
 	else
 		wrmsrl_on_cpu(cpu->cpu, MSR_HWP_REQUEST, value);
 }
@@ -3109,7 +3109,7 @@ static void intel_cpufreq_perf_ctl_update(struct cpudata *cpu,
 					  u32 target_pstate, bool fast_switch)
 {
 	if (fast_switch)
-		wrmsrl(MSR_IA32_PERF_CTL,
+		wrmsrq(MSR_IA32_PERF_CTL,
 		       pstate_funcs.get_val(cpu, target_pstate));
 	else
 		wrmsrl_on_cpu(cpu->cpu, MSR_IA32_PERF_CTL,
diff --git a/drivers/cpufreq/longhaul.c b/drivers/cpufreq/longhaul.c
index d3146f0..ba0e08c 100644
--- a/drivers/cpufreq/longhaul.c
+++ b/drivers/cpufreq/longhaul.c
@@ -144,7 +144,7 @@ static void do_longhaul1(unsigned int mults_index)
 	/* Sync to timer tick */
 	safe_halt();
 	/* Change frequency on next halt or sleep */
-	wrmsrl(MSR_VIA_BCR2, bcr2.val);
+	wrmsrq(MSR_VIA_BCR2, bcr2.val);
 	/* Invoke transition */
 	ACPI_FLUSH_CPU_CACHE();
 	halt();
@@ -153,7 +153,7 @@ static void do_longhaul1(unsigned int mults_index)
 	local_irq_disable();
 	rdmsrq(MSR_VIA_BCR2, bcr2.val);
 	bcr2.bits.ESOFTBF = 0;
-	wrmsrl(MSR_VIA_BCR2, bcr2.val);
+	wrmsrq(MSR_VIA_BCR2, bcr2.val);
 }
 
 /* For processor with Longhaul MSR */
@@ -180,7 +180,7 @@ static void do_powersaver(int cx_address, unsigned int mults_index,
 	/* Raise voltage if necessary */
 	if (can_scale_voltage && dir) {
 		longhaul.bits.EnableSoftVID = 1;
-		wrmsrl(MSR_VIA_LONGHAUL, longhaul.val);
+		wrmsrq(MSR_VIA_LONGHAUL, longhaul.val);
 		/* Change voltage */
 		if (!cx_address) {
 			ACPI_FLUSH_CPU_CACHE();
@@ -194,12 +194,12 @@ static void do_powersaver(int cx_address, unsigned int mults_index,
 			t = inl(acpi_gbl_FADT.xpm_timer_block.address);
 		}
 		longhaul.bits.EnableSoftVID = 0;
-		wrmsrl(MSR_VIA_LONGHAUL, longhaul.val);
+		wrmsrq(MSR_VIA_LONGHAUL, longhaul.val);
 	}
 
 	/* Change frequency on next halt or sleep */
 	longhaul.bits.EnableSoftBusRatio = 1;
-	wrmsrl(MSR_VIA_LONGHAUL, longhaul.val);
+	wrmsrq(MSR_VIA_LONGHAUL, longhaul.val);
 	if (!cx_address) {
 		ACPI_FLUSH_CPU_CACHE();
 		halt();
@@ -212,12 +212,12 @@ static void do_powersaver(int cx_address, unsigned int mults_index,
 	}
 	/* Disable bus ratio bit */
 	longhaul.bits.EnableSoftBusRatio = 0;
-	wrmsrl(MSR_VIA_LONGHAUL, longhaul.val);
+	wrmsrq(MSR_VIA_LONGHAUL, longhaul.val);
 
 	/* Reduce voltage if necessary */
 	if (can_scale_voltage && !dir) {
 		longhaul.bits.EnableSoftVID = 1;
-		wrmsrl(MSR_VIA_LONGHAUL, longhaul.val);
+		wrmsrq(MSR_VIA_LONGHAUL, longhaul.val);
 		/* Change voltage */
 		if (!cx_address) {
 			ACPI_FLUSH_CPU_CACHE();
@@ -231,7 +231,7 @@ static void do_powersaver(int cx_address, unsigned int mults_index,
 			t = inl(acpi_gbl_FADT.xpm_timer_block.address);
 		}
 		longhaul.bits.EnableSoftVID = 0;
-		wrmsrl(MSR_VIA_LONGHAUL, longhaul.val);
+		wrmsrq(MSR_VIA_LONGHAUL, longhaul.val);
 	}
 }
 
diff --git a/drivers/cpufreq/powernow-k7.c b/drivers/cpufreq/powernow-k7.c
index dbbc27c..3103933 100644
--- a/drivers/cpufreq/powernow-k7.c
+++ b/drivers/cpufreq/powernow-k7.c
@@ -225,7 +225,7 @@ static void change_FID(int fid)
 		fidvidctl.bits.FID = fid;
 		fidvidctl.bits.VIDC = 0;
 		fidvidctl.bits.FIDC = 1;
-		wrmsrl(MSR_K7_FID_VID_CTL, fidvidctl.val);
+		wrmsrq(MSR_K7_FID_VID_CTL, fidvidctl.val);
 	}
 }
 
@@ -240,7 +240,7 @@ static void change_VID(int vid)
 		fidvidctl.bits.VID = vid;
 		fidvidctl.bits.FIDC = 0;
 		fidvidctl.bits.VIDC = 1;
-		wrmsrl(MSR_K7_FID_VID_CTL, fidvidctl.val);
+		wrmsrq(MSR_K7_FID_VID_CTL, fidvidctl.val);
 	}
 }
 
diff --git a/drivers/crypto/ccp/sev-dev.c b/drivers/crypto/ccp/sev-dev.c
index 2e87ca0..bb8a25e 100644
--- a/drivers/crypto/ccp/sev-dev.c
+++ b/drivers/crypto/ccp/sev-dev.c
@@ -1060,7 +1060,7 @@ static inline int __sev_do_init_locked(int *psp_ret)
 
 static void snp_set_hsave_pa(void *arg)
 {
-	wrmsrl(MSR_VM_HSAVE_PA, 0);
+	wrmsrq(MSR_VM_HSAVE_PA, 0);
 }
 
 static int snp_filter_reserved_mem_regions(struct resource *rs, void *arg)
diff --git a/drivers/idle/intel_idle.c b/drivers/idle/intel_idle.c
index 6e4b5b3..517b28a 100644
--- a/drivers/idle/intel_idle.c
+++ b/drivers/idle/intel_idle.c
@@ -2082,8 +2082,8 @@ static void __init spr_idle_state_table_update(void)
  */
 static void __init byt_cht_auto_demotion_disable(void)
 {
-	wrmsrl(MSR_CC6_DEMOTION_POLICY_CONFIG, 0);
-	wrmsrl(MSR_MC6_DEMOTION_POLICY_CONFIG, 0);
+	wrmsrq(MSR_CC6_DEMOTION_POLICY_CONFIG, 0);
+	wrmsrq(MSR_MC6_DEMOTION_POLICY_CONFIG, 0);
 }
 
 static bool __init intel_idle_verify_cstate(unsigned int mwait_hint)
@@ -2243,7 +2243,7 @@ static void auto_demotion_disable(void)
 
 	rdmsrq(MSR_PKG_CST_CONFIG_CONTROL, msr_bits);
 	msr_bits &= ~auto_demotion_disable_flags;
-	wrmsrl(MSR_PKG_CST_CONFIG_CONTROL, msr_bits);
+	wrmsrq(MSR_PKG_CST_CONFIG_CONTROL, msr_bits);
 }
 
 static void c1e_promotion_enable(void)
@@ -2252,7 +2252,7 @@ static void c1e_promotion_enable(void)
 
 	rdmsrq(MSR_IA32_POWER_CTL, msr_bits);
 	msr_bits |= 0x2;
-	wrmsrl(MSR_IA32_POWER_CTL, msr_bits);
+	wrmsrq(MSR_IA32_POWER_CTL, msr_bits);
 }
 
 static void c1e_promotion_disable(void)
@@ -2261,7 +2261,7 @@ static void c1e_promotion_disable(void)
 
 	rdmsrq(MSR_IA32_POWER_CTL, msr_bits);
 	msr_bits &= ~0x2;
-	wrmsrl(MSR_IA32_POWER_CTL, msr_bits);
+	wrmsrq(MSR_IA32_POWER_CTL, msr_bits);
 }
 
 /**
diff --git a/drivers/platform/x86/intel/ifs/load.c b/drivers/platform/x86/intel/ifs/load.c
index d3e4866..0289391 100644
--- a/drivers/platform/x86/intel/ifs/load.c
+++ b/drivers/platform/x86/intel/ifs/load.c
@@ -127,7 +127,7 @@ static void copy_hashes_authenticate_chunks(struct work_struct *work)
 	ifsd = ifs_get_data(dev);
 	msrs = ifs_get_test_msrs(dev);
 	/* run scan hash copy */
-	wrmsrl(msrs->copy_hashes, ifs_hash_ptr);
+	wrmsrq(msrs->copy_hashes, ifs_hash_ptr);
 	rdmsrq(msrs->copy_hashes_status, hashes_status.data);
 
 	/* enumerate the scan image information */
@@ -149,7 +149,7 @@ static void copy_hashes_authenticate_chunks(struct work_struct *work)
 		linear_addr = base + i * chunk_size;
 		linear_addr |= i;
 
-		wrmsrl(msrs->copy_chunks, linear_addr);
+		wrmsrq(msrs->copy_chunks, linear_addr);
 		rdmsrq(msrs->copy_chunks_status, chunk_status.data);
 
 		ifsd->valid_chunks = chunk_status.valid_chunks;
@@ -195,7 +195,7 @@ static int copy_hashes_authenticate_chunks_gen2(struct device *dev)
 	msrs = ifs_get_test_msrs(dev);
 
 	if (need_copy_scan_hashes(ifsd)) {
-		wrmsrl(msrs->copy_hashes, ifs_hash_ptr);
+		wrmsrq(msrs->copy_hashes, ifs_hash_ptr);
 		rdmsrq(msrs->copy_hashes_status, hashes_status.data);
 
 		/* enumerate the scan image information */
@@ -216,7 +216,7 @@ static int copy_hashes_authenticate_chunks_gen2(struct device *dev)
 	}
 
 	if (ifsd->generation >= IFS_GEN_STRIDE_AWARE) {
-		wrmsrl(msrs->test_ctrl, INVALIDATE_STRIDE);
+		wrmsrq(msrs->test_ctrl, INVALIDATE_STRIDE);
 		rdmsrq(msrs->copy_chunks_status, chunk_status.data);
 		if (chunk_status.valid_chunks != 0) {
 			dev_err(dev, "Couldn't invalidate installed stride - %d\n",
@@ -238,7 +238,7 @@ static int copy_hashes_authenticate_chunks_gen2(struct device *dev)
 		chunk_table[1] = linear_addr;
 		do {
 			local_irq_disable();
-			wrmsrl(msrs->copy_chunks, (u64)chunk_table);
+			wrmsrq(msrs->copy_chunks, (u64)chunk_table);
 			local_irq_enable();
 			rdmsrq(msrs->copy_chunks_status, chunk_status.data);
 			err_code = chunk_status.error_code;
diff --git a/drivers/platform/x86/intel/ifs/runtest.c b/drivers/platform/x86/intel/ifs/runtest.c
index 8e66954..6b6ed7b 100644
--- a/drivers/platform/x86/intel/ifs/runtest.c
+++ b/drivers/platform/x86/intel/ifs/runtest.c
@@ -209,7 +209,7 @@ static int doscan(void *data)
 	 * take up to 200 milliseconds (in the case where all chunks
 	 * are processed in a single pass) before it retires.
 	 */
-	wrmsrl(MSR_ACTIVATE_SCAN, params->activate->data);
+	wrmsrq(MSR_ACTIVATE_SCAN, params->activate->data);
 	rdmsrq(MSR_SCAN_STATUS, status.data);
 
 	trace_ifs_status(ifsd->cur_batch, start, stop, status.data);
@@ -321,7 +321,7 @@ static int do_array_test(void *data)
 	first = cpumask_first(cpu_smt_mask(cpu));
 
 	if (cpu == first) {
-		wrmsrl(MSR_ARRAY_BIST, command->data);
+		wrmsrq(MSR_ARRAY_BIST, command->data);
 		/* Pass back the result of the test */
 		rdmsrq(MSR_ARRAY_BIST, command->data);
 	}
@@ -374,7 +374,7 @@ static int do_array_test_gen1(void *status)
 	first = cpumask_first(cpu_smt_mask(cpu));
 
 	if (cpu == first) {
-		wrmsrl(MSR_ARRAY_TRIGGER, ARRAY_GEN1_TEST_ALL_ARRAYS);
+		wrmsrq(MSR_ARRAY_TRIGGER, ARRAY_GEN1_TEST_ALL_ARRAYS);
 		rdmsrq(MSR_ARRAY_STATUS, *((u64 *)status));
 	}
 
@@ -526,7 +526,7 @@ static int dosbaf(void *data)
 	 * starts scan of each requested bundle. The core test happens
 	 * during the "execution" of the WRMSR.
 	 */
-	wrmsrl(MSR_ACTIVATE_SBAF, run_params->activate->data);
+	wrmsrq(MSR_ACTIVATE_SBAF, run_params->activate->data);
 	rdmsrq(MSR_SBAF_STATUS, status.data);
 	trace_ifs_sbaf(ifsd->cur_batch, *run_params->activate, status);
 
diff --git a/drivers/platform/x86/intel/pmc/cnp.c b/drivers/platform/x86/intel/pmc/cnp.c
index aa9aa1c..547bdf1 100644
--- a/drivers/platform/x86/intel/pmc/cnp.c
+++ b/drivers/platform/x86/intel/pmc/cnp.c
@@ -230,7 +230,7 @@ static void disable_c1_auto_demote(void *unused)
 	rdmsrq(MSR_PKG_CST_CONFIG_CONTROL, val);
 	per_cpu(pkg_cst_config, cpunum) = val;
 	val &= ~NHM_C1_AUTO_DEMOTE;
-	wrmsrl(MSR_PKG_CST_CONFIG_CONTROL, val);
+	wrmsrq(MSR_PKG_CST_CONFIG_CONTROL, val);
 
 	pr_debug("%s: cpu:%d cst %llx\n", __func__, cpunum, val);
 }
@@ -239,7 +239,7 @@ static void restore_c1_auto_demote(void *unused)
 {
 	int cpunum = smp_processor_id();
 
-	wrmsrl(MSR_PKG_CST_CONFIG_CONTROL, per_cpu(pkg_cst_config, cpunum));
+	wrmsrq(MSR_PKG_CST_CONFIG_CONTROL, per_cpu(pkg_cst_config, cpunum));
 
 	pr_debug("%s: cpu:%d cst %llx\n", __func__, cpunum,
 		 per_cpu(pkg_cst_config, cpunum));
diff --git a/drivers/platform/x86/intel/speed_select_if/isst_if_mbox_msr.c b/drivers/platform/x86/intel/speed_select_if/isst_if_mbox_msr.c
index 20624fc..0d4d677 100644
--- a/drivers/platform/x86/intel/speed_select_if/isst_if_mbox_msr.c
+++ b/drivers/platform/x86/intel/speed_select_if/isst_if_mbox_msr.c
@@ -52,14 +52,14 @@ static int isst_if_send_mbox_cmd(u8 command, u8 sub_command, u32 parameter,
 		return ret;
 
 	/* Write DATA register */
-	wrmsrl(MSR_OS_MAILBOX_DATA, command_data);
+	wrmsrq(MSR_OS_MAILBOX_DATA, command_data);
 
 	/* Write command register */
 	data = BIT_ULL(MSR_OS_MAILBOX_BUSY_BIT) |
 		      (parameter & GENMASK_ULL(13, 0)) << 16 |
 		      (sub_command << 8) |
 		      command;
-	wrmsrl(MSR_OS_MAILBOX_INTERFACE, data);
+	wrmsrq(MSR_OS_MAILBOX_INTERFACE, data);
 
 	/* Poll for rb bit == 0 */
 	retries = OS_MAILBOX_RETRY_COUNT;
diff --git a/drivers/platform/x86/intel_ips.c b/drivers/platform/x86/intel_ips.c
index 74b2a87..9506f28 100644
--- a/drivers/platform/x86/intel_ips.c
+++ b/drivers/platform/x86/intel_ips.c
@@ -382,12 +382,12 @@ static void ips_cpu_raise(struct ips_driver *ips)
 	thm_writew(THM_MPCPC, (new_tdp_limit * 10) / 8);
 
 	turbo_override |= TURBO_TDC_OVR_EN | TURBO_TDP_OVR_EN;
-	wrmsrl(TURBO_POWER_CURRENT_LIMIT, turbo_override);
+	wrmsrq(TURBO_POWER_CURRENT_LIMIT, turbo_override);
 
 	turbo_override &= ~TURBO_TDP_MASK;
 	turbo_override |= new_tdp_limit;
 
-	wrmsrl(TURBO_POWER_CURRENT_LIMIT, turbo_override);
+	wrmsrq(TURBO_POWER_CURRENT_LIMIT, turbo_override);
 }
 
 /**
@@ -417,12 +417,12 @@ static void ips_cpu_lower(struct ips_driver *ips)
 	thm_writew(THM_MPCPC, (new_limit * 10) / 8);
 
 	turbo_override |= TURBO_TDC_OVR_EN | TURBO_TDP_OVR_EN;
-	wrmsrl(TURBO_POWER_CURRENT_LIMIT, turbo_override);
+	wrmsrq(TURBO_POWER_CURRENT_LIMIT, turbo_override);
 
 	turbo_override &= ~TURBO_TDP_MASK;
 	turbo_override |= new_limit;
 
-	wrmsrl(TURBO_POWER_CURRENT_LIMIT, turbo_override);
+	wrmsrq(TURBO_POWER_CURRENT_LIMIT, turbo_override);
 }
 
 /**
@@ -440,7 +440,7 @@ static void do_enable_cpu_turbo(void *data)
 	rdmsrq(IA32_PERF_CTL, perf_ctl);
 	if (perf_ctl & IA32_PERF_TURBO_DIS) {
 		perf_ctl &= ~IA32_PERF_TURBO_DIS;
-		wrmsrl(IA32_PERF_CTL, perf_ctl);
+		wrmsrq(IA32_PERF_CTL, perf_ctl);
 	}
 }
 
@@ -478,7 +478,7 @@ static void do_disable_cpu_turbo(void *data)
 	rdmsrq(IA32_PERF_CTL, perf_ctl);
 	if (!(perf_ctl & IA32_PERF_TURBO_DIS)) {
 		perf_ctl |= IA32_PERF_TURBO_DIS;
-		wrmsrl(IA32_PERF_CTL, perf_ctl);
+		wrmsrq(IA32_PERF_CTL, perf_ctl);
 	}
 }
 
@@ -1598,8 +1598,8 @@ static void ips_remove(struct pci_dev *dev)
 
 	rdmsrq(TURBO_POWER_CURRENT_LIMIT, turbo_override);
 	turbo_override &= ~(TURBO_TDC_OVR_EN | TURBO_TDP_OVR_EN);
-	wrmsrl(TURBO_POWER_CURRENT_LIMIT, turbo_override);
-	wrmsrl(TURBO_POWER_CURRENT_LIMIT, ips->orig_turbo_limit);
+	wrmsrq(TURBO_POWER_CURRENT_LIMIT, turbo_override);
+	wrmsrq(TURBO_POWER_CURRENT_LIMIT, ips->orig_turbo_limit);
 
 	free_irq(ips->irq, ips);
 	pci_free_irq_vectors(dev);
diff --git a/drivers/thermal/intel/intel_hfi.c b/drivers/thermal/intel/intel_hfi.c
index 2aaac15..bd2fca7 100644
--- a/drivers/thermal/intel/intel_hfi.c
+++ b/drivers/thermal/intel/intel_hfi.c
@@ -358,7 +358,7 @@ static void hfi_enable(void)
 
 	rdmsrq(MSR_IA32_HW_FEEDBACK_CONFIG, msr_val);
 	msr_val |= HW_FEEDBACK_CONFIG_HFI_ENABLE_BIT;
-	wrmsrl(MSR_IA32_HW_FEEDBACK_CONFIG, msr_val);
+	wrmsrq(MSR_IA32_HW_FEEDBACK_CONFIG, msr_val);
 }
 
 static void hfi_set_hw_table(struct hfi_instance *hfi_instance)
@@ -368,7 +368,7 @@ static void hfi_set_hw_table(struct hfi_instance *hfi_instance)
 
 	hw_table_pa = virt_to_phys(hfi_instance->hw_table);
 	msr_val = hw_table_pa | HW_FEEDBACK_PTR_VALID_BIT;
-	wrmsrl(MSR_IA32_HW_FEEDBACK_PTR, msr_val);
+	wrmsrq(MSR_IA32_HW_FEEDBACK_PTR, msr_val);
 }
 
 /* Caller must hold hfi_instance_lock. */
@@ -379,7 +379,7 @@ static void hfi_disable(void)
 
 	rdmsrq(MSR_IA32_HW_FEEDBACK_CONFIG, msr_val);
 	msr_val &= ~HW_FEEDBACK_CONFIG_HFI_ENABLE_BIT;
-	wrmsrl(MSR_IA32_HW_FEEDBACK_CONFIG, msr_val);
+	wrmsrq(MSR_IA32_HW_FEEDBACK_CONFIG, msr_val);
 
 	/*
 	 * Wait for hardware to acknowledge the disabling of HFI. Some
diff --git a/drivers/thermal/intel/therm_throt.c b/drivers/thermal/intel/therm_throt.c
index f296f35..c4f3f13 100644
--- a/drivers/thermal/intel/therm_throt.c
+++ b/drivers/thermal/intel/therm_throt.c
@@ -273,7 +273,7 @@ void thermal_clear_package_intr_status(int level, u64 bit_mask)
 	}
 
 	msr_val &= ~bit_mask;
-	wrmsrl(msr, msr_val);
+	wrmsrq(msr, msr_val);
 }
 EXPORT_SYMBOL_GPL(thermal_clear_package_intr_status);
 
diff --git a/drivers/video/fbdev/geode/lxfb_ops.c b/drivers/video/fbdev/geode/lxfb_ops.c
index 5402c00..a27531b 100644
--- a/drivers/video/fbdev/geode/lxfb_ops.c
+++ b/drivers/video/fbdev/geode/lxfb_ops.c
@@ -371,7 +371,7 @@ void lx_set_mode(struct fb_info *info)
 	} else
 		msrval |= MSR_LX_GLD_MSR_CONFIG_FMT_CRT;
 
-	wrmsrl(MSR_LX_GLD_MSR_CONFIG, msrval);
+	wrmsrq(MSR_LX_GLD_MSR_CONFIG, msrval);
 
 	/* Clear the various buffers */
 	/* FIXME:  Adjust for panning here */
@@ -427,7 +427,7 @@ void lx_set_mode(struct fb_info *info)
 			| MSR_LX_SPARE_MSR_WM_LPEN_OVRD);
 	msrval |= MSR_LX_SPARE_MSR_DIS_VIFO_WM |
 			MSR_LX_SPARE_MSR_DIS_INIT_V_PRI;
-	wrmsrl(MSR_LX_SPARE_MSR, msrval);
+	wrmsrq(MSR_LX_SPARE_MSR, msrval);
 
 	gcfg = DC_GENERAL_CFG_DFLE;   /* Display fifo enable */
 	gcfg |= (0x6 << DC_GENERAL_CFG_DFHPSL_SHIFT) | /* default priority */
@@ -664,7 +664,7 @@ static void lx_restore_display_ctlr(struct lxfb_par *par)
 	uint32_t filt;
 	int i;
 
-	wrmsrl(MSR_LX_SPARE_MSR, par->msr.dcspare);
+	wrmsrq(MSR_LX_SPARE_MSR, par->msr.dcspare);
 
 	for (i = 0; i < ARRAY_SIZE(par->dc); i++) {
 		switch (i) {
@@ -729,8 +729,8 @@ static void lx_restore_video_proc(struct lxfb_par *par)
 {
 	int i;
 
-	wrmsrl(MSR_LX_GLD_MSR_CONFIG, par->msr.dfglcfg);
-	wrmsrl(MSR_LX_MSR_PADSEL, par->msr.padsel);
+	wrmsrq(MSR_LX_GLD_MSR_CONFIG, par->msr.dfglcfg);
+	wrmsrq(MSR_LX_MSR_PADSEL, par->msr.padsel);
 
 	for (i = 0; i < ARRAY_SIZE(par->vp); i++) {
 		switch (i) {
diff --git a/drivers/video/fbdev/geode/suspend_gx.c b/drivers/video/fbdev/geode/suspend_gx.c
index ed49977..73307f4 100644
--- a/drivers/video/fbdev/geode/suspend_gx.c
+++ b/drivers/video/fbdev/geode/suspend_gx.c
@@ -133,7 +133,7 @@ static void gx_restore_video_proc(struct gxfb_par *par)
 {
 	int i;
 
-	wrmsrl(MSR_GX_MSR_PADSEL, par->msr.padsel);
+	wrmsrq(MSR_GX_MSR_PADSEL, par->msr.padsel);
 
 	for (i = 0; i < ARRAY_SIZE(par->vp); i++) {
 		switch (i) {
diff --git a/drivers/video/fbdev/geode/video_gx.c b/drivers/video/fbdev/geode/video_gx.c
index 9bee017..5717c33 100644
--- a/drivers/video/fbdev/geode/video_gx.c
+++ b/drivers/video/fbdev/geode/video_gx.c
@@ -151,7 +151,7 @@ void gx_set_dclk_frequency(struct fb_info *info)
 	dotpll |= MSR_GLCP_DOTPLL_DOTRESET;
 	dotpll &= ~MSR_GLCP_DOTPLL_BYPASS;
 
-	wrmsrl(MSR_GLCP_DOTPLL, dotpll);
+	wrmsrq(MSR_GLCP_DOTPLL, dotpll);
 
 	/* Program dividers. */
 	sys_rstpll &= ~( MSR_GLCP_SYS_RSTPLL_DOTPREDIV2
@@ -159,11 +159,11 @@ void gx_set_dclk_frequency(struct fb_info *info)
 			 | MSR_GLCP_SYS_RSTPLL_DOTPOSTDIV3 );
 	sys_rstpll |= pll_table[best_i].sys_rstpll_bits;
 
-	wrmsrl(MSR_GLCP_SYS_RSTPLL, sys_rstpll);
+	wrmsrq(MSR_GLCP_SYS_RSTPLL, sys_rstpll);
 
 	/* Clear reset bit to start PLL. */
 	dotpll &= ~(MSR_GLCP_DOTPLL_DOTRESET);
-	wrmsrl(MSR_GLCP_DOTPLL, dotpll);
+	wrmsrq(MSR_GLCP_DOTPLL, dotpll);
 
 	/* Wait for LOCK bit. */
 	do {
@@ -183,7 +183,7 @@ gx_configure_tft(struct fb_info *info)
 	rdmsrq(MSR_GX_MSR_PADSEL, val);
 	val &= ~MSR_GX_MSR_PADSEL_MASK;
 	val |= MSR_GX_MSR_PADSEL_TFT;
-	wrmsrl(MSR_GX_MSR_PADSEL, val);
+	wrmsrq(MSR_GX_MSR_PADSEL, val);
 
 	/* Turn off the panel */
 
diff --git a/include/hyperv/hvgdk_mini.h b/include/hyperv/hvgdk_mini.h
index 5369975..68606fa 100644
--- a/include/hyperv/hvgdk_mini.h
+++ b/include/hyperv/hvgdk_mini.h
@@ -1013,7 +1013,7 @@ enum hv_register_name {
 
 /*
  * To support arch-generic code calling hv_set/get_register:
- * - On x86, HV_MSR_ indicates an MSR accessed via rdmsrq/wrmsrl
+ * - On x86, HV_MSR_ indicates an MSR accessed via rdmsrq/wrmsrq
  * - On ARM, HV_MSR_ indicates a VP register accessed via hypercall
  */
 #define HV_MSR_CRASH_P0		(HV_X64_MSR_CRASH_P0)

