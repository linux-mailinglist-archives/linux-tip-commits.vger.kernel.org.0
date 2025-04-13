Return-Path: <linux-tip-commits+bounces-4944-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E15DA8735F
	for <lists+linux-tip-commits@lfdr.de>; Sun, 13 Apr 2025 21:00:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2A3E23AD191
	for <lists+linux-tip-commits@lfdr.de>; Sun, 13 Apr 2025 18:59:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 050E4206F23;
	Sun, 13 Apr 2025 18:56:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="0KvVnJ2q";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="LqpZMBZV"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA28F1F8748;
	Sun, 13 Apr 2025 18:56:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744570591; cv=none; b=bOhTyimnoS2G7PvlXy0vxd7cyWSvn+pLbMq6G2hE0KMTtdtLi6yYk60SJhRv1Pq0xAfKX/zGfwmIUcoY04T6Yc16vOOG+GpyyLAeh9Jrzh0JLt4yQMZxIAJoqOB0u8NOtwXj1JtlCIwPGDwVfq23kYEsF01HmZDFR4f9kRORQ2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744570591; c=relaxed/simple;
	bh=8vLPJR6bt6eippYBr25e/z0y8VO8QV4aEOURGqM5CF4=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=IRhOlhjg5Scr+XLc3FbCXNpcjRCrChrl7DeGA99MLzYQvIb/QfnJKyOemWZrkLzgNQsM4yVOBLRRLNxHuuwrfHXANmuLuulaYfyMrER4MQ0klrn7vcdyFve5yRKNNqXyB8UNcpgRkKlmK3jP+vliMQXegEnVqAhmc+GZqy4Sk/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=0KvVnJ2q; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=LqpZMBZV; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sun, 13 Apr 2025 18:56:22 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1744570583;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=96V+omPxqi0c5lOPyPt395kBL8hZmPRH/CZXldONI+c=;
	b=0KvVnJ2q9fjnC736dlmu78ZXqLsf9mhnWevgc6UbahzsS6uG05CvvrLktvaQZdFuNiaDcZ
	i6uaekeZPWewJcR/SWAfJ2oCbNCJyDd+kdXEyy892uHdkbHwM55VOrioweE1AhOZJcy6Rj
	AzbjCn+nFJVZyBkcO6pHzUGoHswBVO+ENvDzcaPmeGZfMomh3enoTqtLy3nrMtjp4Ngi1M
	Bs/39jpwhWgwgzPYYgy1/6VTM27UvrIsn4n/jUpa9EUKjpi2pYbgYa68qCAYHVmMwJIUUX
	bKmWoh39waGxtXZC8GNiDWMhdNAKXo8cdijYRQyTFvCyNHQqg5BzGeaDWuxKQw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1744570583;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=96V+omPxqi0c5lOPyPt395kBL8hZmPRH/CZXldONI+c=;
	b=LqpZMBZVjP+Gz9PQcCU6Y0j5Bsd/Jscmj4IYCocSe05ISg9AtlGjP3FC5PCoONxVIQMWoL
	F8+jwz2UD+mTUTAg==
From: "tip-bot2 for Ingo Molnar" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/msr] x86/msr: Rename 'rdmsrl()' to 'rdmsrq()'
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
Message-ID: <174457058243.31282.17098395675972444447.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/msr branch of tip:

Commit-ID:     c435e608cf59ffab815aa2571182dc8c50fe4112
Gitweb:        https://git.kernel.org/tip/c435e608cf59ffab815aa2571182dc8c50fe4112
Author:        Ingo Molnar <mingo@kernel.org>
AuthorDate:    Wed, 09 Apr 2025 22:28:54 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Thu, 10 Apr 2025 11:58:27 +02:00

x86/msr: Rename 'rdmsrl()' to 'rdmsrq()'

Suggested-by: "H. Peter Anvin" <hpa@zytor.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Juergen Gross <jgross@suse.com>
Cc: Dave Hansen <dave.hansen@intel.com>
Cc: Xin Li <xin@zytor.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
---
 arch/x86/coco/sev/core.c                                      |  2 +-
 arch/x86/events/amd/brs.c                                     |  4 +-
 arch/x86/events/amd/core.c                                    |  4 +-
 arch/x86/events/amd/ibs.c                                     | 18 ++--
 arch/x86/events/amd/lbr.c                                     |  8 +-
 arch/x86/events/amd/power.c                                   |  8 +-
 arch/x86/events/amd/uncore.c                                  |  2 +-
 arch/x86/events/core.c                                        | 20 ++--
 arch/x86/events/intel/core.c                                  | 10 +-
 arch/x86/events/intel/cstate.c                                |  2 +-
 arch/x86/events/intel/knc.c                                   |  6 +-
 arch/x86/events/intel/lbr.c                                   | 14 +--
 arch/x86/events/intel/p4.c                                    |  4 +-
 arch/x86/events/intel/p6.c                                    |  4 +-
 arch/x86/events/intel/pt.c                                    | 12 +--
 arch/x86/events/intel/uncore.c                                |  2 +-
 arch/x86/events/intel/uncore_nhmex.c                          |  4 +-
 arch/x86/events/intel/uncore_snb.c                            |  2 +-
 arch/x86/events/intel/uncore_snbep.c                          |  6 +-
 arch/x86/events/msr.c                                         |  2 +-
 arch/x86/events/perf_event.h                                  |  6 +-
 arch/x86/events/rapl.c                                        |  6 +-
 arch/x86/events/zhaoxin/core.c                                |  6 +-
 arch/x86/hyperv/hv_apic.c                                     |  2 +-
 arch/x86/hyperv/hv_init.c                                     | 26 +++---
 arch/x86/hyperv/hv_spinlock.c                                 |  6 +-
 arch/x86/include/asm/apic.h                                   |  4 +-
 arch/x86/include/asm/debugreg.h                               |  2 +-
 arch/x86/include/asm/fsgsbase.h                               |  2 +-
 arch/x86/include/asm/kvm_host.h                               |  2 +-
 arch/x86/include/asm/msr.h                                    |  4 +-
 arch/x86/include/asm/paravirt.h                               |  2 +-
 arch/x86/kernel/apic/apic.c                                   |  6 +-
 arch/x86/kernel/apic/apic_numachip.c                          |  6 +-
 arch/x86/kernel/cet.c                                         |  2 +-
 arch/x86/kernel/cpu/amd.c                                     |  8 +-
 arch/x86/kernel/cpu/aperfmperf.c                              |  8 +-
 arch/x86/kernel/cpu/bugs.c                                    | 12 +--
 arch/x86/kernel/cpu/bus_lock.c                                |  8 +-
 arch/x86/kernel/cpu/common.c                                  | 10 +-
 arch/x86/kernel/cpu/hygon.c                                   |  4 +-
 arch/x86/kernel/cpu/intel.c                                   |  4 +-
 arch/x86/kernel/cpu/intel_epb.c                               |  4 +-
 arch/x86/kernel/cpu/mce/amd.c                                 | 14 +--
 arch/x86/kernel/cpu/mce/core.c                                |  6 +-
 arch/x86/kernel/cpu/mce/inject.c                              |  2 +-
 arch/x86/kernel/cpu/mce/intel.c                               | 18 ++--
 arch/x86/kernel/cpu/mshyperv.c                                |  6 +-
 arch/x86/kernel/cpu/resctrl/core.c                            |  2 +-
 arch/x86/kernel/cpu/resctrl/monitor.c                         |  2 +-
 arch/x86/kernel/cpu/resctrl/rdtgroup.c                        |  2 +-
 arch/x86/kernel/cpu/topology.c                                |  2 +-
 arch/x86/kernel/cpu/topology_amd.c                            |  4 +-
 arch/x86/kernel/cpu/tsx.c                                     | 10 +-
 arch/x86/kernel/cpu/umwait.c                                  |  2 +-
 arch/x86/kernel/fpu/core.c                                    |  2 +-
 arch/x86/kernel/hpet.c                                        |  2 +-
 arch/x86/kernel/kvm.c                                         |  2 +-
 arch/x86/kernel/mmconf-fam10h_64.c                            |  6 +-
 arch/x86/kernel/process.c                                     |  2 +-
 arch/x86/kernel/process_64.c                                  | 14 +--
 arch/x86/kernel/shstk.c                                       |  4 +-
 arch/x86/kernel/traps.c                                       |  4 +-
 arch/x86/kernel/tsc.c                                         |  2 +-
 arch/x86/kernel/tsc_sync.c                                    |  6 +-
 arch/x86/kvm/svm/svm.c                                        |  6 +-
 arch/x86/kvm/vmx/nested.c                                     |  4 +-
 arch/x86/kvm/vmx/pmu_intel.c                                  |  2 +-
 arch/x86/kvm/vmx/sgx.c                                        |  6 +-
 arch/x86/kvm/vmx/vmx.c                                        | 32 +++----
 arch/x86/kvm/x86.c                                            |  4 +-
 arch/x86/lib/insn-eval.c                                      |  6 +-
 arch/x86/mm/pat/memtype.c                                     |  2 +-
 arch/x86/pci/amd_bus.c                                        |  8 +-
 arch/x86/platform/olpc/olpc-xo1-rtc.c                         |  6 +-
 arch/x86/power/cpu.c                                          | 10 +-
 arch/x86/realmode/init.c                                      |  2 +-
 arch/x86/virt/svm/sev.c                                       | 16 ++--
 arch/x86/xen/suspend.c                                        |  2 +-
 drivers/cpufreq/acpi-cpufreq.c                                |  2 +-
 drivers/cpufreq/amd-pstate.c                                  |  4 +-
 drivers/cpufreq/e_powersaver.c                                |  4 +-
 drivers/cpufreq/intel_pstate.c                                | 28 +++---
 drivers/cpufreq/longhaul.c                                    |  8 +-
 drivers/cpufreq/powernow-k7.c                                 | 10 +-
 drivers/edac/amd64_edac.c                                     |  6 +-
 drivers/idle/intel_idle.c                                     | 24 ++---
 drivers/mtd/nand/raw/cs553x_nand.c                            |  6 +-
 drivers/platform/x86/intel/ifs/load.c                         | 10 +-
 drivers/platform/x86/intel/ifs/runtest.c                      |  8 +-
 drivers/platform/x86/intel/pmc/cnp.c                          |  2 +-
 drivers/platform/x86/intel/speed_select_if/isst_if_mbox_msr.c |  6 +-
 drivers/platform/x86/intel/speed_select_if/isst_tpmi_core.c   |  2 +-
 drivers/platform/x86/intel_ips.c                              | 20 ++--
 drivers/thermal/intel/intel_hfi.c                             |  8 +-
 drivers/thermal/intel/therm_throt.c                           |  6 +-
 drivers/video/fbdev/geode/gxfb_core.c                         |  2 +-
 drivers/video/fbdev/geode/lxfb_ops.c                          | 12 +--
 drivers/video/fbdev/geode/suspend_gx.c                        |  8 +-
 drivers/video/fbdev/geode/video_gx.c                          |  8 +-
 include/hyperv/hvgdk_mini.h                                   |  2 +-
 101 files changed, 340 insertions(+), 340 deletions(-)

diff --git a/arch/x86/coco/sev/core.c b/arch/x86/coco/sev/core.c
index b0c1a7a..b18a33f 100644
--- a/arch/x86/coco/sev/core.c
+++ b/arch/x86/coco/sev/core.c
@@ -3278,7 +3278,7 @@ void __init snp_secure_tsc_init(void)
 		return;
 
 	setup_force_cpu_cap(X86_FEATURE_TSC_KNOWN_FREQ);
-	rdmsrl(MSR_AMD64_GUEST_TSC_FREQ, tsc_freq_mhz);
+	rdmsrq(MSR_AMD64_GUEST_TSC_FREQ, tsc_freq_mhz);
 	snp_tsc_freq_khz = (unsigned long)(tsc_freq_mhz * 1000);
 
 	x86_platform.calibrate_cpu = securetsc_get_tsc_khz;
diff --git a/arch/x86/events/amd/brs.c b/arch/x86/events/amd/brs.c
index ec34274..86ef0fe 100644
--- a/arch/x86/events/amd/brs.c
+++ b/arch/x86/events/amd/brs.c
@@ -325,7 +325,7 @@ void amd_brs_drain(void)
 		u32 brs_idx = tos - i;
 		u64 from, to;
 
-		rdmsrl(brs_to(brs_idx), to);
+		rdmsrq(brs_to(brs_idx), to);
 
 		/* Entry does not belong to us (as marked by kernel) */
 		if (to == BRS_POISON)
@@ -341,7 +341,7 @@ void amd_brs_drain(void)
 		if (!amd_brs_match_plm(event, to))
 			continue;
 
-		rdmsrl(brs_from(brs_idx), from);
+		rdmsrq(brs_from(brs_idx), from);
 
 		perf_clear_branch_entry_bitfields(br+nr);
 
diff --git a/arch/x86/events/amd/core.c b/arch/x86/events/amd/core.c
index 30d6ceb..94d6d24 100644
--- a/arch/x86/events/amd/core.c
+++ b/arch/x86/events/amd/core.c
@@ -659,7 +659,7 @@ static inline u64 amd_pmu_get_global_status(void)
 	u64 status;
 
 	/* PerfCntrGlobalStatus is read-only */
-	rdmsrl(MSR_AMD64_PERF_CNTR_GLOBAL_STATUS, status);
+	rdmsrq(MSR_AMD64_PERF_CNTR_GLOBAL_STATUS, status);
 
 	return status;
 }
@@ -679,7 +679,7 @@ static bool amd_pmu_test_overflow_topbit(int idx)
 {
 	u64 counter;
 
-	rdmsrl(x86_pmu_event_addr(idx), counter);
+	rdmsrq(x86_pmu_event_addr(idx), counter);
 
 	return !(counter & BIT_ULL(x86_pmu.cntval_bits - 1));
 }
diff --git a/arch/x86/events/amd/ibs.c b/arch/x86/events/amd/ibs.c
index 0252b7e..ca6cc90 100644
--- a/arch/x86/events/amd/ibs.c
+++ b/arch/x86/events/amd/ibs.c
@@ -424,7 +424,7 @@ perf_ibs_event_update(struct perf_ibs *perf_ibs, struct perf_event *event,
 	 * prev count manually on overflow.
 	 */
 	while (!perf_event_try_update(event, count, 64)) {
-		rdmsrl(event->hw.config_base, *config);
+		rdmsrq(event->hw.config_base, *config);
 		count = perf_ibs->get_count(*config);
 	}
 }
@@ -513,7 +513,7 @@ static void perf_ibs_stop(struct perf_event *event, int flags)
 	if (!stopping && (hwc->state & PERF_HES_UPTODATE))
 		return;
 
-	rdmsrl(hwc->config_base, config);
+	rdmsrq(hwc->config_base, config);
 
 	if (stopping) {
 		/*
@@ -1256,7 +1256,7 @@ fail:
 	hwc = &event->hw;
 	msr = hwc->config_base;
 	buf = ibs_data.regs;
-	rdmsrl(msr, *buf);
+	rdmsrq(msr, *buf);
 	if (!(*buf++ & perf_ibs->valid_mask))
 		goto fail;
 
@@ -1274,7 +1274,7 @@ fail:
 	offset_max = perf_ibs_get_offset_max(perf_ibs, event, check_rip);
 
 	do {
-		rdmsrl(msr + offset, *buf++);
+		rdmsrq(msr + offset, *buf++);
 		size++;
 		offset = find_next_bit(perf_ibs->offset_mask,
 				       perf_ibs->offset_max,
@@ -1304,17 +1304,17 @@ fail:
 	if (event->attr.sample_type & PERF_SAMPLE_RAW) {
 		if (perf_ibs == &perf_ibs_op) {
 			if (ibs_caps & IBS_CAPS_BRNTRGT) {
-				rdmsrl(MSR_AMD64_IBSBRTARGET, *buf++);
+				rdmsrq(MSR_AMD64_IBSBRTARGET, *buf++);
 				br_target_idx = size;
 				size++;
 			}
 			if (ibs_caps & IBS_CAPS_OPDATA4) {
-				rdmsrl(MSR_AMD64_IBSOPDATA4, *buf++);
+				rdmsrq(MSR_AMD64_IBSOPDATA4, *buf++);
 				size++;
 			}
 		}
 		if (perf_ibs == &perf_ibs_fetch && (ibs_caps & IBS_CAPS_FETCHCTLEXTD)) {
-			rdmsrl(MSR_AMD64_ICIBSEXTDCTL, *buf++);
+			rdmsrq(MSR_AMD64_ICIBSEXTDCTL, *buf++);
 			size++;
 		}
 	}
@@ -1565,7 +1565,7 @@ static inline int ibs_eilvt_valid(void)
 
 	preempt_disable();
 
-	rdmsrl(MSR_AMD64_IBSCTL, val);
+	rdmsrq(MSR_AMD64_IBSCTL, val);
 	offset = val & IBSCTL_LVT_OFFSET_MASK;
 
 	if (!(val & IBSCTL_LVT_OFFSET_VALID)) {
@@ -1680,7 +1680,7 @@ static inline int get_ibs_lvt_offset(void)
 {
 	u64 val;
 
-	rdmsrl(MSR_AMD64_IBSCTL, val);
+	rdmsrq(MSR_AMD64_IBSCTL, val);
 	if (!(val & IBSCTL_LVT_OFFSET_VALID))
 		return -EINVAL;
 
diff --git a/arch/x86/events/amd/lbr.c b/arch/x86/events/amd/lbr.c
index c06ccca..a1aecf5 100644
--- a/arch/x86/events/amd/lbr.c
+++ b/arch/x86/events/amd/lbr.c
@@ -73,7 +73,7 @@ static __always_inline u64 amd_pmu_lbr_get_from(unsigned int idx)
 {
 	u64 val;
 
-	rdmsrl(MSR_AMD_SAMP_BR_FROM + idx * 2, val);
+	rdmsrq(MSR_AMD_SAMP_BR_FROM + idx * 2, val);
 
 	return val;
 }
@@ -82,7 +82,7 @@ static __always_inline u64 amd_pmu_lbr_get_to(unsigned int idx)
 {
 	u64 val;
 
-	rdmsrl(MSR_AMD_SAMP_BR_FROM + idx * 2 + 1, val);
+	rdmsrq(MSR_AMD_SAMP_BR_FROM + idx * 2 + 1, val);
 
 	return val;
 }
@@ -400,11 +400,11 @@ void amd_pmu_lbr_enable_all(void)
 	}
 
 	if (cpu_feature_enabled(X86_FEATURE_AMD_LBR_PMC_FREEZE)) {
-		rdmsrl(MSR_IA32_DEBUGCTLMSR, dbg_ctl);
+		rdmsrq(MSR_IA32_DEBUGCTLMSR, dbg_ctl);
 		wrmsrl(MSR_IA32_DEBUGCTLMSR, dbg_ctl | DEBUGCTLMSR_FREEZE_LBRS_ON_PMI);
 	}
 
-	rdmsrl(MSR_AMD_DBG_EXTN_CFG, dbg_extn_cfg);
+	rdmsrq(MSR_AMD_DBG_EXTN_CFG, dbg_extn_cfg);
 	wrmsrl(MSR_AMD_DBG_EXTN_CFG, dbg_extn_cfg | DBG_EXTN_CFG_LBRV2EN);
 }
 
diff --git a/arch/x86/events/amd/power.c b/arch/x86/events/amd/power.c
index 37d5b38..7e96f46 100644
--- a/arch/x86/events/amd/power.c
+++ b/arch/x86/events/amd/power.c
@@ -48,8 +48,8 @@ static void event_update(struct perf_event *event)
 
 	prev_pwr_acc = hwc->pwr_acc;
 	prev_ptsc = hwc->ptsc;
-	rdmsrl(MSR_F15H_CU_PWR_ACCUMULATOR, new_pwr_acc);
-	rdmsrl(MSR_F15H_PTSC, new_ptsc);
+	rdmsrq(MSR_F15H_CU_PWR_ACCUMULATOR, new_pwr_acc);
+	rdmsrq(MSR_F15H_PTSC, new_ptsc);
 
 	/*
 	 * Calculate the CU power consumption over a time period, the unit of
@@ -75,8 +75,8 @@ static void __pmu_event_start(struct perf_event *event)
 
 	event->hw.state = 0;
 
-	rdmsrl(MSR_F15H_PTSC, event->hw.ptsc);
-	rdmsrl(MSR_F15H_CU_PWR_ACCUMULATOR, event->hw.pwr_acc);
+	rdmsrq(MSR_F15H_PTSC, event->hw.ptsc);
+	rdmsrq(MSR_F15H_CU_PWR_ACCUMULATOR, event->hw.pwr_acc);
 }
 
 static void pmu_event_start(struct perf_event *event, int mode)
diff --git a/arch/x86/events/amd/uncore.c b/arch/x86/events/amd/uncore.c
index 49c26ce..4ddf542 100644
--- a/arch/x86/events/amd/uncore.c
+++ b/arch/x86/events/amd/uncore.c
@@ -106,7 +106,7 @@ static void amd_uncore_read(struct perf_event *event)
 	 * read counts directly from the corresponding PERF_CTR.
 	 */
 	if (hwc->event_base_rdpmc < 0)
-		rdmsrl(hwc->event_base, new);
+		rdmsrq(hwc->event_base, new);
 	else
 		rdpmcl(hwc->event_base_rdpmc, new);
 
diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
index 6866cc5..a27f2e6 100644
--- a/arch/x86/events/core.c
+++ b/arch/x86/events/core.c
@@ -693,7 +693,7 @@ void x86_pmu_disable_all(void)
 
 		if (!test_bit(idx, cpuc->active_mask))
 			continue;
-		rdmsrl(x86_pmu_config_addr(idx), val);
+		rdmsrq(x86_pmu_config_addr(idx), val);
 		if (!(val & ARCH_PERFMON_EVENTSEL_ENABLE))
 			continue;
 		val &= ~ARCH_PERFMON_EVENTSEL_ENABLE;
@@ -1550,10 +1550,10 @@ void perf_event_print_debug(void)
 		return;
 
 	if (x86_pmu.version >= 2) {
-		rdmsrl(MSR_CORE_PERF_GLOBAL_CTRL, ctrl);
-		rdmsrl(MSR_CORE_PERF_GLOBAL_STATUS, status);
-		rdmsrl(MSR_CORE_PERF_GLOBAL_OVF_CTRL, overflow);
-		rdmsrl(MSR_ARCH_PERFMON_FIXED_CTR_CTRL, fixed);
+		rdmsrq(MSR_CORE_PERF_GLOBAL_CTRL, ctrl);
+		rdmsrq(MSR_CORE_PERF_GLOBAL_STATUS, status);
+		rdmsrq(MSR_CORE_PERF_GLOBAL_OVF_CTRL, overflow);
+		rdmsrq(MSR_ARCH_PERFMON_FIXED_CTR_CTRL, fixed);
 
 		pr_info("\n");
 		pr_info("CPU#%d: ctrl:       %016llx\n", cpu, ctrl);
@@ -1561,19 +1561,19 @@ void perf_event_print_debug(void)
 		pr_info("CPU#%d: overflow:   %016llx\n", cpu, overflow);
 		pr_info("CPU#%d: fixed:      %016llx\n", cpu, fixed);
 		if (pebs_constraints) {
-			rdmsrl(MSR_IA32_PEBS_ENABLE, pebs);
+			rdmsrq(MSR_IA32_PEBS_ENABLE, pebs);
 			pr_info("CPU#%d: pebs:       %016llx\n", cpu, pebs);
 		}
 		if (x86_pmu.lbr_nr) {
-			rdmsrl(MSR_IA32_DEBUGCTLMSR, debugctl);
+			rdmsrq(MSR_IA32_DEBUGCTLMSR, debugctl);
 			pr_info("CPU#%d: debugctl:   %016llx\n", cpu, debugctl);
 		}
 	}
 	pr_info("CPU#%d: active:     %016llx\n", cpu, *(u64 *)cpuc->active_mask);
 
 	for_each_set_bit(idx, cntr_mask, X86_PMC_IDX_MAX) {
-		rdmsrl(x86_pmu_config_addr(idx), pmc_ctrl);
-		rdmsrl(x86_pmu_event_addr(idx), pmc_count);
+		rdmsrq(x86_pmu_config_addr(idx), pmc_ctrl);
+		rdmsrq(x86_pmu_event_addr(idx), pmc_count);
 
 		prev_left = per_cpu(pmc_prev_left[idx], cpu);
 
@@ -1587,7 +1587,7 @@ void perf_event_print_debug(void)
 	for_each_set_bit(idx, fixed_cntr_mask, X86_PMC_IDX_MAX) {
 		if (fixed_counter_disabled(idx, cpuc->pmu))
 			continue;
-		rdmsrl(x86_pmu_fixed_ctr_addr(idx), pmc_count);
+		rdmsrq(x86_pmu_fixed_ctr_addr(idx), pmc_count);
 
 		pr_info("CPU#%d: fixed-PMC%d count: %016llx\n",
 			cpu, idx, pmc_count);
diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index 09d2d66..852b1ea 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -2489,7 +2489,7 @@ static inline u64 intel_pmu_get_status(void)
 {
 	u64 status;
 
-	rdmsrl(MSR_CORE_PERF_GLOBAL_STATUS, status);
+	rdmsrq(MSR_CORE_PERF_GLOBAL_STATUS, status);
 
 	return status;
 }
@@ -5054,7 +5054,7 @@ static void update_pmu_cap(struct x86_hybrid_pmu *pmu)
 
 	if (!intel_pmu_broken_perf_cap()) {
 		/* Perf Metric (Bit 15) and PEBS via PT (Bit 16) are hybrid enumeration */
-		rdmsrl(MSR_IA32_PERF_CAPABILITIES, pmu->intel_cap.capabilities);
+		rdmsrq(MSR_IA32_PERF_CAPABILITIES, pmu->intel_cap.capabilities);
 	}
 }
 
@@ -5202,7 +5202,7 @@ static void intel_pmu_cpu_starting(int cpu)
 	if (!is_hybrid() && x86_pmu.intel_cap.perf_metrics) {
 		union perf_capabilities perf_cap;
 
-		rdmsrl(MSR_IA32_PERF_CAPABILITIES, perf_cap.capabilities);
+		rdmsrq(MSR_IA32_PERF_CAPABILITIES, perf_cap.capabilities);
 		if (!perf_cap.perf_metrics) {
 			x86_pmu.intel_cap.perf_metrics = 0;
 			x86_pmu.intel_ctrl &= ~(1ULL << GLOBAL_CTRL_EN_PERF_METRICS);
@@ -5627,7 +5627,7 @@ static bool check_msr(unsigned long msr, u64 mask)
 
 	/*
 	 * Quirk only affects validation in wrmsr(), so wrmsrl()'s value
-	 * should equal rdmsrl()'s even with the quirk.
+	 * should equal rdmsrq()'s even with the quirk.
 	 */
 	if (val_new != val_tmp)
 		return false;
@@ -6642,7 +6642,7 @@ __init int intel_pmu_init(void)
 	if (boot_cpu_has(X86_FEATURE_PDCM)) {
 		u64 capabilities;
 
-		rdmsrl(MSR_IA32_PERF_CAPABILITIES, capabilities);
+		rdmsrq(MSR_IA32_PERF_CAPABILITIES, capabilities);
 		x86_pmu.intel_cap.capabilities = capabilities;
 	}
 
diff --git a/arch/x86/events/intel/cstate.c b/arch/x86/events/intel/cstate.c
index ae4ec16..56b1c39 100644
--- a/arch/x86/events/intel/cstate.c
+++ b/arch/x86/events/intel/cstate.c
@@ -320,7 +320,7 @@ static inline u64 cstate_pmu_read_counter(struct perf_event *event)
 {
 	u64 val;
 
-	rdmsrl(event->hw.event_base, val);
+	rdmsrq(event->hw.event_base, val);
 	return val;
 }
 
diff --git a/arch/x86/events/intel/knc.c b/arch/x86/events/intel/knc.c
index 034a1f6..0ee32a0 100644
--- a/arch/x86/events/intel/knc.c
+++ b/arch/x86/events/intel/knc.c
@@ -159,7 +159,7 @@ static void knc_pmu_disable_all(void)
 {
 	u64 val;
 
-	rdmsrl(MSR_KNC_IA32_PERF_GLOBAL_CTRL, val);
+	rdmsrq(MSR_KNC_IA32_PERF_GLOBAL_CTRL, val);
 	val &= ~(KNC_ENABLE_COUNTER0|KNC_ENABLE_COUNTER1);
 	wrmsrl(MSR_KNC_IA32_PERF_GLOBAL_CTRL, val);
 }
@@ -168,7 +168,7 @@ static void knc_pmu_enable_all(int added)
 {
 	u64 val;
 
-	rdmsrl(MSR_KNC_IA32_PERF_GLOBAL_CTRL, val);
+	rdmsrq(MSR_KNC_IA32_PERF_GLOBAL_CTRL, val);
 	val |= (KNC_ENABLE_COUNTER0|KNC_ENABLE_COUNTER1);
 	wrmsrl(MSR_KNC_IA32_PERF_GLOBAL_CTRL, val);
 }
@@ -200,7 +200,7 @@ static inline u64 knc_pmu_get_status(void)
 {
 	u64 status;
 
-	rdmsrl(MSR_KNC_IA32_PERF_GLOBAL_STATUS, status);
+	rdmsrq(MSR_KNC_IA32_PERF_GLOBAL_STATUS, status);
 
 	return status;
 }
diff --git a/arch/x86/events/intel/lbr.c b/arch/x86/events/intel/lbr.c
index f44c3d8..2b33aac 100644
--- a/arch/x86/events/intel/lbr.c
+++ b/arch/x86/events/intel/lbr.c
@@ -139,7 +139,7 @@ static void __intel_pmu_lbr_enable(bool pmi)
 	if (!static_cpu_has(X86_FEATURE_ARCH_LBR) && !pmi && cpuc->lbr_sel)
 		wrmsrl(MSR_LBR_SELECT, lbr_select);
 
-	rdmsrl(MSR_IA32_DEBUGCTLMSR, debugctl);
+	rdmsrq(MSR_IA32_DEBUGCTLMSR, debugctl);
 	orig_debugctl = debugctl;
 
 	if (!static_cpu_has(X86_FEATURE_ARCH_LBR))
@@ -209,7 +209,7 @@ static inline u64 intel_pmu_lbr_tos(void)
 {
 	u64 tos;
 
-	rdmsrl(x86_pmu.lbr_tos, tos);
+	rdmsrq(x86_pmu.lbr_tos, tos);
 	return tos;
 }
 
@@ -302,7 +302,7 @@ static __always_inline u64 rdlbr_from(unsigned int idx, struct lbr_entry *lbr)
 	if (lbr)
 		return lbr->from;
 
-	rdmsrl(x86_pmu.lbr_from + idx, val);
+	rdmsrq(x86_pmu.lbr_from + idx, val);
 
 	return lbr_from_signext_quirk_rd(val);
 }
@@ -314,7 +314,7 @@ static __always_inline u64 rdlbr_to(unsigned int idx, struct lbr_entry *lbr)
 	if (lbr)
 		return lbr->to;
 
-	rdmsrl(x86_pmu.lbr_to + idx, val);
+	rdmsrq(x86_pmu.lbr_to + idx, val);
 
 	return val;
 }
@@ -326,7 +326,7 @@ static __always_inline u64 rdlbr_info(unsigned int idx, struct lbr_entry *lbr)
 	if (lbr)
 		return lbr->info;
 
-	rdmsrl(x86_pmu.lbr_info + idx, val);
+	rdmsrq(x86_pmu.lbr_info + idx, val);
 
 	return val;
 }
@@ -475,7 +475,7 @@ void intel_pmu_lbr_save(void *ctx)
 	task_ctx->tos = tos;
 
 	if (cpuc->lbr_select)
-		rdmsrl(MSR_LBR_SELECT, task_ctx->lbr_sel);
+		rdmsrq(MSR_LBR_SELECT, task_ctx->lbr_sel);
 }
 
 static void intel_pmu_arch_lbr_save(void *ctx)
@@ -752,7 +752,7 @@ void intel_pmu_lbr_read_32(struct cpu_hw_events *cpuc)
 			u64     lbr;
 		} msr_lastbranch;
 
-		rdmsrl(x86_pmu.lbr_from + lbr_idx, msr_lastbranch.lbr);
+		rdmsrq(x86_pmu.lbr_from + lbr_idx, msr_lastbranch.lbr);
 
 		perf_clear_branch_entry_bitfields(br);
 
diff --git a/arch/x86/events/intel/p4.c b/arch/x86/events/intel/p4.c
index c85a9fc..a0eb63b 100644
--- a/arch/x86/events/intel/p4.c
+++ b/arch/x86/events/intel/p4.c
@@ -859,7 +859,7 @@ static inline int p4_pmu_clear_cccr_ovf(struct hw_perf_event *hwc)
 	u64 v;
 
 	/* an official way for overflow indication */
-	rdmsrl(hwc->config_base, v);
+	rdmsrq(hwc->config_base, v);
 	if (v & P4_CCCR_OVF) {
 		wrmsrl(hwc->config_base, v & ~P4_CCCR_OVF);
 		return 1;
@@ -872,7 +872,7 @@ static inline int p4_pmu_clear_cccr_ovf(struct hw_perf_event *hwc)
 	 * the counter has reached zero value and continued counting before
 	 * real NMI signal was received:
 	 */
-	rdmsrl(hwc->event_base, v);
+	rdmsrq(hwc->event_base, v);
 	if (!(v & ARCH_P4_UNFLAGGED_BIT))
 		return 1;
 
diff --git a/arch/x86/events/intel/p6.c b/arch/x86/events/intel/p6.c
index 65b45e9..701f8a8 100644
--- a/arch/x86/events/intel/p6.c
+++ b/arch/x86/events/intel/p6.c
@@ -142,7 +142,7 @@ static void p6_pmu_disable_all(void)
 	u64 val;
 
 	/* p6 only has one enable register */
-	rdmsrl(MSR_P6_EVNTSEL0, val);
+	rdmsrq(MSR_P6_EVNTSEL0, val);
 	val &= ~ARCH_PERFMON_EVENTSEL_ENABLE;
 	wrmsrl(MSR_P6_EVNTSEL0, val);
 }
@@ -152,7 +152,7 @@ static void p6_pmu_enable_all(int added)
 	unsigned long val;
 
 	/* p6 only has one enable register */
-	rdmsrl(MSR_P6_EVNTSEL0, val);
+	rdmsrq(MSR_P6_EVNTSEL0, val);
 	val |= ARCH_PERFMON_EVENTSEL_ENABLE;
 	wrmsrl(MSR_P6_EVNTSEL0, val);
 }
diff --git a/arch/x86/events/intel/pt.c b/arch/x86/events/intel/pt.c
index fa37565..b8212d8 100644
--- a/arch/x86/events/intel/pt.c
+++ b/arch/x86/events/intel/pt.c
@@ -194,7 +194,7 @@ static int __init pt_pmu_hw_init(void)
 	int ret;
 	long i;
 
-	rdmsrl(MSR_PLATFORM_INFO, reg);
+	rdmsrq(MSR_PLATFORM_INFO, reg);
 	pt_pmu.max_nonturbo_ratio = (reg & 0xff00) >> 8;
 
 	/*
@@ -230,7 +230,7 @@ static int __init pt_pmu_hw_init(void)
 		 * "IA32_VMX_MISC[bit 14]" being 1 means PT can trace
 		 * post-VMXON.
 		 */
-		rdmsrl(MSR_IA32_VMX_MISC, reg);
+		rdmsrq(MSR_IA32_VMX_MISC, reg);
 		if (reg & BIT(14))
 			pt_pmu.vmx = true;
 	}
@@ -926,7 +926,7 @@ static void pt_handle_status(struct pt *pt)
 	int advance = 0;
 	u64 status;
 
-	rdmsrl(MSR_IA32_RTIT_STATUS, status);
+	rdmsrq(MSR_IA32_RTIT_STATUS, status);
 
 	if (status & RTIT_STATUS_ERROR) {
 		pr_err_ratelimited("ToPA ERROR encountered, trying to recover\n");
@@ -985,12 +985,12 @@ static void pt_read_offset(struct pt_buffer *buf)
 	struct topa_page *tp;
 
 	if (!buf->single) {
-		rdmsrl(MSR_IA32_RTIT_OUTPUT_BASE, pt->output_base);
+		rdmsrq(MSR_IA32_RTIT_OUTPUT_BASE, pt->output_base);
 		tp = phys_to_virt(pt->output_base);
 		buf->cur = &tp->topa;
 	}
 
-	rdmsrl(MSR_IA32_RTIT_OUTPUT_MASK, pt->output_mask);
+	rdmsrq(MSR_IA32_RTIT_OUTPUT_MASK, pt->output_mask);
 	/* offset within current output region */
 	buf->output_off = pt->output_mask >> 32;
 	/* index of current output region within this table */
@@ -1611,7 +1611,7 @@ static void pt_event_start(struct perf_event *event, int mode)
 			 * PMI might have just cleared these, so resume_allowed
 			 * must be checked again also.
 			 */
-			rdmsrl(MSR_IA32_RTIT_STATUS, status);
+			rdmsrq(MSR_IA32_RTIT_STATUS, status);
 			if (!(status & (RTIT_STATUS_TRIGGEREN |
 					RTIT_STATUS_ERROR |
 					RTIT_STATUS_STOPPED)) &&
diff --git a/arch/x86/events/intel/uncore.c b/arch/x86/events/intel/uncore.c
index a34e50f..d607052 100644
--- a/arch/x86/events/intel/uncore.c
+++ b/arch/x86/events/intel/uncore.c
@@ -150,7 +150,7 @@ u64 uncore_msr_read_counter(struct intel_uncore_box *box, struct perf_event *eve
 {
 	u64 count;
 
-	rdmsrl(event->hw.event_base, count);
+	rdmsrq(event->hw.event_base, count);
 
 	return count;
 }
diff --git a/arch/x86/events/intel/uncore_nhmex.c b/arch/x86/events/intel/uncore_nhmex.c
index 4668334..e6fccad 100644
--- a/arch/x86/events/intel/uncore_nhmex.c
+++ b/arch/x86/events/intel/uncore_nhmex.c
@@ -214,7 +214,7 @@ static void nhmex_uncore_msr_disable_box(struct intel_uncore_box *box)
 	u64 config;
 
 	if (msr) {
-		rdmsrl(msr, config);
+		rdmsrq(msr, config);
 		config &= ~((1ULL << uncore_num_counters(box)) - 1);
 		/* WBox has a fixed counter */
 		if (uncore_msr_fixed_ctl(box))
@@ -229,7 +229,7 @@ static void nhmex_uncore_msr_enable_box(struct intel_uncore_box *box)
 	u64 config;
 
 	if (msr) {
-		rdmsrl(msr, config);
+		rdmsrq(msr, config);
 		config |= (1ULL << uncore_num_counters(box)) - 1;
 		/* WBox has a fixed counter */
 		if (uncore_msr_fixed_ctl(box))
diff --git a/arch/x86/events/intel/uncore_snb.c b/arch/x86/events/intel/uncore_snb.c
index edb7fd5..66dadf5 100644
--- a/arch/x86/events/intel/uncore_snb.c
+++ b/arch/x86/events/intel/uncore_snb.c
@@ -504,7 +504,7 @@ static int icl_get_cbox_num(void)
 {
 	u64 num_boxes;
 
-	rdmsrl(ICL_UNC_CBO_CONFIG, num_boxes);
+	rdmsrq(ICL_UNC_CBO_CONFIG, num_boxes);
 
 	return num_boxes & ICL_UNC_NUM_CBO_MASK;
 }
diff --git a/arch/x86/events/intel/uncore_snbep.c b/arch/x86/events/intel/uncore_snbep.c
index 60973c2..e498485 100644
--- a/arch/x86/events/intel/uncore_snbep.c
+++ b/arch/x86/events/intel/uncore_snbep.c
@@ -618,7 +618,7 @@ static void snbep_uncore_msr_disable_box(struct intel_uncore_box *box)
 
 	msr = uncore_msr_box_ctl(box);
 	if (msr) {
-		rdmsrl(msr, config);
+		rdmsrq(msr, config);
 		config |= SNBEP_PMON_BOX_CTL_FRZ;
 		wrmsrl(msr, config);
 	}
@@ -631,7 +631,7 @@ static void snbep_uncore_msr_enable_box(struct intel_uncore_box *box)
 
 	msr = uncore_msr_box_ctl(box);
 	if (msr) {
-		rdmsrl(msr, config);
+		rdmsrq(msr, config);
 		config &= ~SNBEP_PMON_BOX_CTL_FRZ;
 		wrmsrl(msr, config);
 	}
@@ -6572,7 +6572,7 @@ void spr_uncore_cpu_init(void)
 		 * of UNCORE_SPR_CHA) is incorrect on some SPR variants because of a
 		 * firmware bug. Using the value from SPR_MSR_UNC_CBO_CONFIG to replace it.
 		 */
-		rdmsrl(SPR_MSR_UNC_CBO_CONFIG, num_cbo);
+		rdmsrq(SPR_MSR_UNC_CBO_CONFIG, num_cbo);
 		/*
 		 * The MSR doesn't work on the EMR XCC, but the firmware bug doesn't impact
 		 * the EMR XCC. Don't let the value from the MSR replace the existing value.
diff --git a/arch/x86/events/msr.c b/arch/x86/events/msr.c
index 45b1866..8970ece 100644
--- a/arch/x86/events/msr.c
+++ b/arch/x86/events/msr.c
@@ -231,7 +231,7 @@ static inline u64 msr_read_counter(struct perf_event *event)
 	u64 now;
 
 	if (event->hw.event_base)
-		rdmsrl(event->hw.event_base, now);
+		rdmsrq(event->hw.event_base, now);
 	else
 		now = rdtsc_ordered();
 
diff --git a/arch/x86/events/perf_event.h b/arch/x86/events/perf_event.h
index 2c0ce0e..34b6d35 100644
--- a/arch/x86/events/perf_event.h
+++ b/arch/x86/events/perf_event.h
@@ -1394,11 +1394,11 @@ static __always_inline void __amd_pmu_lbr_disable(void)
 {
 	u64 dbg_ctl, dbg_extn_cfg;
 
-	rdmsrl(MSR_AMD_DBG_EXTN_CFG, dbg_extn_cfg);
+	rdmsrq(MSR_AMD_DBG_EXTN_CFG, dbg_extn_cfg);
 	wrmsrl(MSR_AMD_DBG_EXTN_CFG, dbg_extn_cfg & ~DBG_EXTN_CFG_LBRV2EN);
 
 	if (cpu_feature_enabled(X86_FEATURE_AMD_LBR_PMC_FREEZE)) {
-		rdmsrl(MSR_IA32_DEBUGCTLMSR, dbg_ctl);
+		rdmsrq(MSR_IA32_DEBUGCTLMSR, dbg_ctl);
 		wrmsrl(MSR_IA32_DEBUGCTLMSR, dbg_ctl & ~DEBUGCTLMSR_FREEZE_LBRS_ON_PMI);
 	}
 }
@@ -1543,7 +1543,7 @@ static __always_inline void __intel_pmu_lbr_disable(void)
 {
 	u64 debugctl;
 
-	rdmsrl(MSR_IA32_DEBUGCTLMSR, debugctl);
+	rdmsrq(MSR_IA32_DEBUGCTLMSR, debugctl);
 	debugctl &= ~(DEBUGCTLMSR_LBR | DEBUGCTLMSR_FREEZE_LBRS_ON_PMI);
 	wrmsrl(MSR_IA32_DEBUGCTLMSR, debugctl);
 }
diff --git a/arch/x86/events/rapl.c b/arch/x86/events/rapl.c
index 8ddace8..b7c256a 100644
--- a/arch/x86/events/rapl.c
+++ b/arch/x86/events/rapl.c
@@ -192,7 +192,7 @@ static inline unsigned int get_rapl_pmu_idx(int cpu, int scope)
 static inline u64 rapl_read_counter(struct perf_event *event)
 {
 	u64 raw;
-	rdmsrl(event->hw.event_base, raw);
+	rdmsrq(event->hw.event_base, raw);
 	return raw;
 }
 
@@ -221,7 +221,7 @@ static u64 rapl_event_update(struct perf_event *event)
 
 	prev_raw_count = local64_read(&hwc->prev_count);
 	do {
-		rdmsrl(event->hw.event_base, new_raw_count);
+		rdmsrq(event->hw.event_base, new_raw_count);
 	} while (!local64_try_cmpxchg(&hwc->prev_count,
 				      &prev_raw_count, new_raw_count));
 
@@ -610,7 +610,7 @@ static int rapl_check_hw_unit(void)
 	u64 msr_rapl_power_unit_bits;
 	int i;
 
-	/* protect rdmsrl() to handle virtualization */
+	/* protect rdmsrq() to handle virtualization */
 	if (rdmsrl_safe(rapl_model->msr_power_unit, &msr_rapl_power_unit_bits))
 		return -1;
 	for (i = 0; i < NR_RAPL_PKG_DOMAINS; i++)
diff --git a/arch/x86/events/zhaoxin/core.c b/arch/x86/events/zhaoxin/core.c
index 2fd9b0c..67ff23f 100644
--- a/arch/x86/events/zhaoxin/core.c
+++ b/arch/x86/events/zhaoxin/core.c
@@ -266,7 +266,7 @@ static inline u64 zhaoxin_pmu_get_status(void)
 {
 	u64 status;
 
-	rdmsrl(MSR_CORE_PERF_GLOBAL_STATUS, status);
+	rdmsrq(MSR_CORE_PERF_GLOBAL_STATUS, status);
 
 	return status;
 }
@@ -293,7 +293,7 @@ static void zhaoxin_pmu_disable_fixed(struct hw_perf_event *hwc)
 
 	mask = 0xfULL << (idx * 4);
 
-	rdmsrl(hwc->config_base, ctrl_val);
+	rdmsrq(hwc->config_base, ctrl_val);
 	ctrl_val &= ~mask;
 	wrmsrl(hwc->config_base, ctrl_val);
 }
@@ -329,7 +329,7 @@ static void zhaoxin_pmu_enable_fixed(struct hw_perf_event *hwc)
 	bits <<= (idx * 4);
 	mask = 0xfULL << (idx * 4);
 
-	rdmsrl(hwc->config_base, ctrl_val);
+	rdmsrq(hwc->config_base, ctrl_val);
 	ctrl_val &= ~mask;
 	ctrl_val |= bits;
 	wrmsrl(hwc->config_base, ctrl_val);
diff --git a/arch/x86/hyperv/hv_apic.c b/arch/x86/hyperv/hv_apic.c
index 6d91ac5..d1d6aa5 100644
--- a/arch/x86/hyperv/hv_apic.c
+++ b/arch/x86/hyperv/hv_apic.c
@@ -37,7 +37,7 @@ static u64 hv_apic_icr_read(void)
 {
 	u64 reg_val;
 
-	rdmsrl(HV_X64_MSR_ICR, reg_val);
+	rdmsrq(HV_X64_MSR_ICR, reg_val);
 	return reg_val;
 }
 
diff --git a/arch/x86/hyperv/hv_init.c b/arch/x86/hyperv/hv_init.c
index ddeb409..7c58aff 100644
--- a/arch/x86/hyperv/hv_init.c
+++ b/arch/x86/hyperv/hv_init.c
@@ -62,7 +62,7 @@ static int hyperv_init_ghcb(void)
 	 * returned by MSR_AMD64_SEV_ES_GHCB is above shared
 	 * memory boundary and map it here.
 	 */
-	rdmsrl(MSR_AMD64_SEV_ES_GHCB, ghcb_gpa);
+	rdmsrq(MSR_AMD64_SEV_ES_GHCB, ghcb_gpa);
 
 	/* Mask out vTOM bit. ioremap_cache() maps decrypted */
 	ghcb_gpa &= ~ms_hyperv.shared_gpa_boundary;
@@ -95,7 +95,7 @@ static int hv_cpu_init(unsigned int cpu)
 		 * For root partition we get the hypervisor provided VP assist
 		 * page, instead of allocating a new page.
 		 */
-		rdmsrl(HV_X64_MSR_VP_ASSIST_PAGE, msr.as_uint64);
+		rdmsrq(HV_X64_MSR_VP_ASSIST_PAGE, msr.as_uint64);
 		*hvp = memremap(msr.pfn << HV_X64_MSR_VP_ASSIST_PAGE_ADDRESS_SHIFT,
 				PAGE_SIZE, MEMREMAP_WB);
 	} else {
@@ -140,7 +140,7 @@ static void hv_reenlightenment_notify(struct work_struct *dummy)
 {
 	struct hv_tsc_emulation_status emu_status;
 
-	rdmsrl(HV_X64_MSR_TSC_EMULATION_STATUS, *(u64 *)&emu_status);
+	rdmsrq(HV_X64_MSR_TSC_EMULATION_STATUS, *(u64 *)&emu_status);
 
 	/* Don't issue the callback if TSC accesses are not emulated */
 	if (hv_reenlightenment_cb && emu_status.inprogress)
@@ -153,11 +153,11 @@ void hyperv_stop_tsc_emulation(void)
 	u64 freq;
 	struct hv_tsc_emulation_status emu_status;
 
-	rdmsrl(HV_X64_MSR_TSC_EMULATION_STATUS, *(u64 *)&emu_status);
+	rdmsrq(HV_X64_MSR_TSC_EMULATION_STATUS, *(u64 *)&emu_status);
 	emu_status.inprogress = 0;
 	wrmsrl(HV_X64_MSR_TSC_EMULATION_STATUS, *(u64 *)&emu_status);
 
-	rdmsrl(HV_X64_MSR_TSC_FREQUENCY, freq);
+	rdmsrq(HV_X64_MSR_TSC_FREQUENCY, freq);
 	tsc_khz = div64_u64(freq, 1000);
 }
 EXPORT_SYMBOL_GPL(hyperv_stop_tsc_emulation);
@@ -217,7 +217,7 @@ void clear_hv_tscchange_cb(void)
 	if (!hv_reenlightenment_available())
 		return;
 
-	rdmsrl(HV_X64_MSR_REENLIGHTENMENT_CONTROL, *(u64 *)&re_ctrl);
+	rdmsrq(HV_X64_MSR_REENLIGHTENMENT_CONTROL, *(u64 *)&re_ctrl);
 	re_ctrl.enabled = 0;
 	wrmsrl(HV_X64_MSR_REENLIGHTENMENT_CONTROL, *(u64 *)&re_ctrl);
 
@@ -251,7 +251,7 @@ static int hv_cpu_die(unsigned int cpu)
 			 */
 			memunmap(hv_vp_assist_page[cpu]);
 			hv_vp_assist_page[cpu] = NULL;
-			rdmsrl(HV_X64_MSR_VP_ASSIST_PAGE, msr.as_uint64);
+			rdmsrq(HV_X64_MSR_VP_ASSIST_PAGE, msr.as_uint64);
 			msr.enable = 0;
 		}
 		wrmsrl(HV_X64_MSR_VP_ASSIST_PAGE, msr.as_uint64);
@@ -260,7 +260,7 @@ static int hv_cpu_die(unsigned int cpu)
 	if (hv_reenlightenment_cb == NULL)
 		return 0;
 
-	rdmsrl(HV_X64_MSR_REENLIGHTENMENT_CONTROL, *((u64 *)&re_ctrl));
+	rdmsrq(HV_X64_MSR_REENLIGHTENMENT_CONTROL, *((u64 *)&re_ctrl));
 	if (re_ctrl.target_vp == hv_vp_index[cpu]) {
 		/*
 		 * Reassign reenlightenment notifications to some other online
@@ -331,7 +331,7 @@ static int hv_suspend(void)
 	hv_hypercall_pg = NULL;
 
 	/* Disable the hypercall page in the hypervisor */
-	rdmsrl(HV_X64_MSR_HYPERCALL, hypercall_msr.as_uint64);
+	rdmsrq(HV_X64_MSR_HYPERCALL, hypercall_msr.as_uint64);
 	hypercall_msr.enable = 0;
 	wrmsrl(HV_X64_MSR_HYPERCALL, hypercall_msr.as_uint64);
 
@@ -348,7 +348,7 @@ static void hv_resume(void)
 	WARN_ON(ret);
 
 	/* Re-enable the hypercall page */
-	rdmsrl(HV_X64_MSR_HYPERCALL, hypercall_msr.as_uint64);
+	rdmsrq(HV_X64_MSR_HYPERCALL, hypercall_msr.as_uint64);
 	hypercall_msr.enable = 1;
 	hypercall_msr.guest_physical_address =
 		vmalloc_to_pfn(hv_hypercall_pg_saved);
@@ -515,7 +515,7 @@ void __init hyperv_init(void)
 	if (hv_hypercall_pg == NULL)
 		goto clean_guest_os_id;
 
-	rdmsrl(HV_X64_MSR_HYPERCALL, hypercall_msr.as_uint64);
+	rdmsrq(HV_X64_MSR_HYPERCALL, hypercall_msr.as_uint64);
 	hypercall_msr.enable = 1;
 
 	if (hv_root_partition()) {
@@ -667,7 +667,7 @@ void hyperv_report_panic(struct pt_regs *regs, long err, bool in_die)
 		return;
 	panic_reported = true;
 
-	rdmsrl(HV_X64_MSR_GUEST_OS_ID, guest_id);
+	rdmsrq(HV_X64_MSR_GUEST_OS_ID, guest_id);
 
 	wrmsrl(HV_X64_MSR_CRASH_P0, err);
 	wrmsrl(HV_X64_MSR_CRASH_P1, guest_id);
@@ -701,7 +701,7 @@ bool hv_is_hyperv_initialized(void)
 	 * that the hypercall page is setup
 	 */
 	hypercall_msr.as_uint64 = 0;
-	rdmsrl(HV_X64_MSR_HYPERCALL, hypercall_msr.as_uint64);
+	rdmsrq(HV_X64_MSR_HYPERCALL, hypercall_msr.as_uint64);
 
 	return hypercall_msr.enable;
 }
diff --git a/arch/x86/hyperv/hv_spinlock.c b/arch/x86/hyperv/hv_spinlock.c
index 151e851..626f6d4 100644
--- a/arch/x86/hyperv/hv_spinlock.c
+++ b/arch/x86/hyperv/hv_spinlock.c
@@ -39,18 +39,18 @@ static void hv_qlock_wait(u8 *byte, u8 val)
 	 * To prevent a race against the unlock path it is required to
 	 * disable interrupts before accessing the HV_X64_MSR_GUEST_IDLE
 	 * MSR. Otherwise, if the IPI from hv_qlock_kick() arrives between
-	 * the lock value check and the rdmsrl() then the vCPU might be put
+	 * the lock value check and the rdmsrq() then the vCPU might be put
 	 * into 'idle' state by the hypervisor and kept in that state for
 	 * an unspecified amount of time.
 	 */
 	local_irq_save(flags);
 	/*
-	 * Only issue the rdmsrl() when the lock state has not changed.
+	 * Only issue the rdmsrq() when the lock state has not changed.
 	 */
 	if (READ_ONCE(*byte) == val) {
 		unsigned long msr_val;
 
-		rdmsrl(HV_X64_MSR_GUEST_IDLE, msr_val);
+		rdmsrq(HV_X64_MSR_GUEST_IDLE, msr_val);
 
 		(void)msr_val;
 	}
diff --git a/arch/x86/include/asm/apic.h b/arch/x86/include/asm/apic.h
index c903d35..45819cf 100644
--- a/arch/x86/include/asm/apic.h
+++ b/arch/x86/include/asm/apic.h
@@ -224,7 +224,7 @@ static inline u32 native_apic_msr_read(u32 reg)
 	if (reg == APIC_DFR)
 		return -1;
 
-	rdmsrl(APIC_BASE_MSR + (reg >> 4), msr);
+	rdmsrq(APIC_BASE_MSR + (reg >> 4), msr);
 	return (u32)msr;
 }
 
@@ -237,7 +237,7 @@ static inline u64 native_x2apic_icr_read(void)
 {
 	unsigned long val;
 
-	rdmsrl(APIC_BASE_MSR + (APIC_ICR >> 4), val);
+	rdmsrq(APIC_BASE_MSR + (APIC_ICR >> 4), val);
 	return val;
 }
 
diff --git a/arch/x86/include/asm/debugreg.h b/arch/x86/include/asm/debugreg.h
index fdbbbfe..0e703c0 100644
--- a/arch/x86/include/asm/debugreg.h
+++ b/arch/x86/include/asm/debugreg.h
@@ -169,7 +169,7 @@ static inline unsigned long get_debugctlmsr(void)
 	if (boot_cpu_data.x86 < 6)
 		return 0;
 #endif
-	rdmsrl(MSR_IA32_DEBUGCTLMSR, debugctlmsr);
+	rdmsrq(MSR_IA32_DEBUGCTLMSR, debugctlmsr);
 
 	return debugctlmsr;
 }
diff --git a/arch/x86/include/asm/fsgsbase.h b/arch/x86/include/asm/fsgsbase.h
index 02f2395..d7708f2 100644
--- a/arch/x86/include/asm/fsgsbase.h
+++ b/arch/x86/include/asm/fsgsbase.h
@@ -60,7 +60,7 @@ static inline unsigned long x86_fsbase_read_cpu(void)
 	if (boot_cpu_has(X86_FEATURE_FSGSBASE))
 		fsbase = rdfsbase();
 	else
-		rdmsrl(MSR_FS_BASE, fsbase);
+		rdmsrq(MSR_FS_BASE, fsbase);
 
 	return fsbase;
 }
diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index a884ab5..9af20b3 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -2272,7 +2272,7 @@ static inline unsigned long read_msr(unsigned long msr)
 {
 	u64 value;
 
-	rdmsrl(msr, value);
+	rdmsrq(msr, value);
 	return value;
 }
 #endif
diff --git a/arch/x86/include/asm/msr.h b/arch/x86/include/asm/msr.h
index 2f5a661..b35513a 100644
--- a/arch/x86/include/asm/msr.h
+++ b/arch/x86/include/asm/msr.h
@@ -255,7 +255,7 @@ static inline void wrmsr(u32 msr, u32 low, u32 high)
 	native_write_msr(msr, low, high);
 }
 
-#define rdmsrl(msr, val)			\
+#define rdmsrq(msr, val)			\
 	((val) = native_read_msr((msr)))
 
 static inline void wrmsrl(u32 msr, u64 val)
@@ -352,7 +352,7 @@ static inline int wrmsr_on_cpu(unsigned int cpu, u32 msr_no, u32 l, u32 h)
 }
 static inline int rdmsrl_on_cpu(unsigned int cpu, u32 msr_no, u64 *q)
 {
-	rdmsrl(msr_no, *q);
+	rdmsrq(msr_no, *q);
 	return 0;
 }
 static inline int wrmsrl_on_cpu(unsigned int cpu, u32 msr_no, u64 q)
diff --git a/arch/x86/include/asm/paravirt.h b/arch/x86/include/asm/paravirt.h
index c270ca0..1cda83b 100644
--- a/arch/x86/include/asm/paravirt.h
+++ b/arch/x86/include/asm/paravirt.h
@@ -209,7 +209,7 @@ do {						\
 	paravirt_write_msr(msr, val1, val2);	\
 } while (0)
 
-#define rdmsrl(msr, val)			\
+#define rdmsrq(msr, val)			\
 do {						\
 	val = paravirt_read_msr(msr);		\
 } while (0)
diff --git a/arch/x86/kernel/apic/apic.c b/arch/x86/kernel/apic/apic.c
index 62584a3..dc9af05 100644
--- a/arch/x86/kernel/apic/apic.c
+++ b/arch/x86/kernel/apic/apic.c
@@ -1694,7 +1694,7 @@ static bool x2apic_hw_locked(void)
 
 	x86_arch_cap_msr = x86_read_arch_cap_msr();
 	if (x86_arch_cap_msr & ARCH_CAP_XAPIC_DISABLE) {
-		rdmsrl(MSR_IA32_XAPIC_DISABLE_STATUS, msr);
+		rdmsrq(MSR_IA32_XAPIC_DISABLE_STATUS, msr);
 		return (msr & LEGACY_XAPIC_DISABLED);
 	}
 	return false;
@@ -1707,7 +1707,7 @@ static void __x2apic_disable(void)
 	if (!boot_cpu_has(X86_FEATURE_APIC))
 		return;
 
-	rdmsrl(MSR_IA32_APICBASE, msr);
+	rdmsrq(MSR_IA32_APICBASE, msr);
 	if (!(msr & X2APIC_ENABLE))
 		return;
 	/* Disable xapic and x2apic first and then reenable xapic mode */
@@ -1720,7 +1720,7 @@ static void __x2apic_enable(void)
 {
 	u64 msr;
 
-	rdmsrl(MSR_IA32_APICBASE, msr);
+	rdmsrq(MSR_IA32_APICBASE, msr);
 	if (msr & X2APIC_ENABLE)
 		return;
 	wrmsrl(MSR_IA32_APICBASE, msr | X2APIC_ENABLE);
diff --git a/arch/x86/kernel/apic/apic_numachip.c b/arch/x86/kernel/apic/apic_numachip.c
index 16410f0..fcfef70 100644
--- a/arch/x86/kernel/apic/apic_numachip.c
+++ b/arch/x86/kernel/apic/apic_numachip.c
@@ -31,7 +31,7 @@ static u32 numachip1_get_apic_id(u32 x)
 	unsigned int id = (x >> 24) & 0xff;
 
 	if (static_cpu_has(X86_FEATURE_NODEID_MSR)) {
-		rdmsrl(MSR_FAM10H_NODE_ID, value);
+		rdmsrq(MSR_FAM10H_NODE_ID, value);
 		id |= (value << 2) & 0xff00;
 	}
 
@@ -42,7 +42,7 @@ static u32 numachip2_get_apic_id(u32 x)
 {
 	u64 mcfg;
 
-	rdmsrl(MSR_FAM10H_MMIO_CONF_BASE, mcfg);
+	rdmsrq(MSR_FAM10H_MMIO_CONF_BASE, mcfg);
 	return ((mcfg >> (28 - 8)) & 0xfff00) | (x >> 24);
 }
 
@@ -150,7 +150,7 @@ static void fixup_cpu_id(struct cpuinfo_x86 *c, int node)
 
 	/* Account for nodes per socket in multi-core-module processors */
 	if (boot_cpu_has(X86_FEATURE_NODEID_MSR)) {
-		rdmsrl(MSR_FAM10H_NODE_ID, val);
+		rdmsrq(MSR_FAM10H_NODE_ID, val);
 		nodes = ((val >> 3) & 7) + 1;
 	}
 
diff --git a/arch/x86/kernel/cet.c b/arch/x86/kernel/cet.c
index 303bf74..d897aad 100644
--- a/arch/x86/kernel/cet.c
+++ b/arch/x86/kernel/cet.c
@@ -55,7 +55,7 @@ static void do_user_cp_fault(struct pt_regs *regs, unsigned long error_code)
 	 * will be whatever is live in userspace. So read the SSP before enabling
 	 * interrupts so locking the fpregs to do it later is not required.
 	 */
-	rdmsrl(MSR_IA32_PL3_SSP, ssp);
+	rdmsrq(MSR_IA32_PL3_SSP, ssp);
 
 	cond_local_irq_enable(regs);
 
diff --git a/arch/x86/kernel/cpu/amd.c b/arch/x86/kernel/cpu/amd.c
index b2ab236..7c7eca7 100644
--- a/arch/x86/kernel/cpu/amd.c
+++ b/arch/x86/kernel/cpu/amd.c
@@ -383,7 +383,7 @@ static void bsp_init_amd(struct cpuinfo_x86 *c)
 		    (c->x86 == 0x10 && c->x86_model >= 0x2)) {
 			u64 val;
 
-			rdmsrl(MSR_K7_HWCR, val);
+			rdmsrq(MSR_K7_HWCR, val);
 			if (!(val & BIT(24)))
 				pr_warn(FW_BUG "TSC doesn't count with P0 frequency!\n");
 		}
@@ -508,7 +508,7 @@ static void early_detect_mem_encrypt(struct cpuinfo_x86 *c)
 	 */
 	if (cpu_has(c, X86_FEATURE_SME) || cpu_has(c, X86_FEATURE_SEV)) {
 		/* Check if memory encryption is enabled */
-		rdmsrl(MSR_AMD64_SYSCFG, msr);
+		rdmsrq(MSR_AMD64_SYSCFG, msr);
 		if (!(msr & MSR_AMD64_SYSCFG_MEM_ENCRYPT))
 			goto clear_all;
 
@@ -525,7 +525,7 @@ static void early_detect_mem_encrypt(struct cpuinfo_x86 *c)
 		if (!sme_me_mask)
 			setup_clear_cpu_cap(X86_FEATURE_SME);
 
-		rdmsrl(MSR_K7_HWCR, msr);
+		rdmsrq(MSR_K7_HWCR, msr);
 		if (!(msr & MSR_K7_HWCR_SMMLOCK))
 			goto clear_sev;
 
@@ -1014,7 +1014,7 @@ static void init_amd(struct cpuinfo_x86 *c)
 	init_amd_cacheinfo(c);
 
 	if (cpu_has(c, X86_FEATURE_SVM)) {
-		rdmsrl(MSR_VM_CR, vm_cr);
+		rdmsrq(MSR_VM_CR, vm_cr);
 		if (vm_cr & SVM_VM_CR_SVM_DIS_MASK) {
 			pr_notice_once("SVM disabled (by BIOS) in MSR_VM_CR\n");
 			clear_cpu_cap(c, X86_FEATURE_SVM);
diff --git a/arch/x86/kernel/cpu/aperfmperf.c b/arch/x86/kernel/cpu/aperfmperf.c
index 6cf31a1..dca7865 100644
--- a/arch/x86/kernel/cpu/aperfmperf.c
+++ b/arch/x86/kernel/cpu/aperfmperf.c
@@ -40,8 +40,8 @@ static void init_counter_refs(void)
 {
 	u64 aperf, mperf;
 
-	rdmsrl(MSR_IA32_APERF, aperf);
-	rdmsrl(MSR_IA32_MPERF, mperf);
+	rdmsrq(MSR_IA32_APERF, aperf);
+	rdmsrq(MSR_IA32_MPERF, mperf);
 
 	this_cpu_write(cpu_samples.aperf, aperf);
 	this_cpu_write(cpu_samples.mperf, mperf);
@@ -474,8 +474,8 @@ void arch_scale_freq_tick(void)
 	if (!cpu_feature_enabled(X86_FEATURE_APERFMPERF))
 		return;
 
-	rdmsrl(MSR_IA32_APERF, aperf);
-	rdmsrl(MSR_IA32_MPERF, mperf);
+	rdmsrq(MSR_IA32_APERF, aperf);
+	rdmsrq(MSR_IA32_MPERF, mperf);
 	acnt = aperf - s->aperf;
 	mcnt = mperf - s->mperf;
 
diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index 4386aa6..78ffe0e 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -140,7 +140,7 @@ void __init cpu_select_mitigations(void)
 	 * init code as it is not enumerated and depends on the family.
 	 */
 	if (cpu_feature_enabled(X86_FEATURE_MSR_SPEC_CTRL)) {
-		rdmsrl(MSR_IA32_SPEC_CTRL, x86_spec_ctrl_base);
+		rdmsrq(MSR_IA32_SPEC_CTRL, x86_spec_ctrl_base);
 
 		/*
 		 * Previously running kernel (kexec), may have some controls
@@ -656,7 +656,7 @@ void update_srbds_msr(void)
 	if (!boot_cpu_has(X86_FEATURE_SRBDS_CTRL))
 		return;
 
-	rdmsrl(MSR_IA32_MCU_OPT_CTRL, mcu_ctrl);
+	rdmsrq(MSR_IA32_MCU_OPT_CTRL, mcu_ctrl);
 
 	switch (srbds_mitigation) {
 	case SRBDS_MITIGATION_OFF:
@@ -776,7 +776,7 @@ void update_gds_msr(void)
 
 	switch (gds_mitigation) {
 	case GDS_MITIGATION_OFF:
-		rdmsrl(MSR_IA32_MCU_OPT_CTRL, mcu_ctrl);
+		rdmsrq(MSR_IA32_MCU_OPT_CTRL, mcu_ctrl);
 		mcu_ctrl |= GDS_MITG_DIS;
 		break;
 	case GDS_MITIGATION_FULL_LOCKED:
@@ -786,7 +786,7 @@ void update_gds_msr(void)
 		 * CPUs.
 		 */
 	case GDS_MITIGATION_FULL:
-		rdmsrl(MSR_IA32_MCU_OPT_CTRL, mcu_ctrl);
+		rdmsrq(MSR_IA32_MCU_OPT_CTRL, mcu_ctrl);
 		mcu_ctrl &= ~GDS_MITG_DIS;
 		break;
 	case GDS_MITIGATION_FORCE:
@@ -802,7 +802,7 @@ void update_gds_msr(void)
 	 * GDS_MITG_DIS will be ignored if this processor is locked but the boot
 	 * processor was not.
 	 */
-	rdmsrl(MSR_IA32_MCU_OPT_CTRL, mcu_ctrl_after);
+	rdmsrq(MSR_IA32_MCU_OPT_CTRL, mcu_ctrl_after);
 	WARN_ON_ONCE(mcu_ctrl != mcu_ctrl_after);
 }
 
@@ -841,7 +841,7 @@ static void __init gds_select_mitigation(void)
 	if (gds_mitigation == GDS_MITIGATION_FORCE)
 		gds_mitigation = GDS_MITIGATION_FULL;
 
-	rdmsrl(MSR_IA32_MCU_OPT_CTRL, mcu_ctrl);
+	rdmsrq(MSR_IA32_MCU_OPT_CTRL, mcu_ctrl);
 	if (mcu_ctrl & GDS_MITG_LOCKED) {
 		if (gds_mitigation == GDS_MITIGATION_OFF)
 			pr_warn("Mitigation locked. Disable failed.\n");
diff --git a/arch/x86/kernel/cpu/bus_lock.c b/arch/x86/kernel/cpu/bus_lock.c
index 237faf7..725072b 100644
--- a/arch/x86/kernel/cpu/bus_lock.c
+++ b/arch/x86/kernel/cpu/bus_lock.c
@@ -103,7 +103,7 @@ static bool split_lock_verify_msr(bool on)
 		ctrl &= ~MSR_TEST_CTRL_SPLIT_LOCK_DETECT;
 	if (wrmsrl_safe(MSR_TEST_CTRL, ctrl))
 		return false;
-	rdmsrl(MSR_TEST_CTRL, tmp);
+	rdmsrq(MSR_TEST_CTRL, tmp);
 	return ctrl == tmp;
 }
 
@@ -137,7 +137,7 @@ static void __init __split_lock_setup(void)
 		return;
 	}
 
-	rdmsrl(MSR_TEST_CTRL, msr_test_ctrl_cache);
+	rdmsrq(MSR_TEST_CTRL, msr_test_ctrl_cache);
 
 	if (!split_lock_verify_msr(true)) {
 		pr_info("MSR access failed: Disabled\n");
@@ -297,7 +297,7 @@ void bus_lock_init(void)
 	if (!boot_cpu_has(X86_FEATURE_BUS_LOCK_DETECT))
 		return;
 
-	rdmsrl(MSR_IA32_DEBUGCTLMSR, val);
+	rdmsrq(MSR_IA32_DEBUGCTLMSR, val);
 
 	if ((boot_cpu_has(X86_FEATURE_SPLIT_LOCK_DETECT) &&
 	    (sld_state == sld_warn || sld_state == sld_fatal)) ||
@@ -375,7 +375,7 @@ static void __init split_lock_setup(struct cpuinfo_x86 *c)
 	 * MSR_IA32_CORE_CAPS_SPLIT_LOCK_DETECT is.  All CPUs that set
 	 * it have split lock detection.
 	 */
-	rdmsrl(MSR_IA32_CORE_CAPS, ia32_core_caps);
+	rdmsrq(MSR_IA32_CORE_CAPS, ia32_core_caps);
 	if (ia32_core_caps & MSR_IA32_CORE_CAPS_SPLIT_LOCK_DETECT)
 		goto supported;
 
diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index 12126ad..c3c0ba2 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -562,7 +562,7 @@ __noendbr u64 ibt_save(bool disable)
 	u64 msr = 0;
 
 	if (cpu_feature_enabled(X86_FEATURE_IBT)) {
-		rdmsrl(MSR_IA32_S_CET, msr);
+		rdmsrq(MSR_IA32_S_CET, msr);
 		if (disable)
 			wrmsrl(MSR_IA32_S_CET, msr & ~CET_ENDBR_EN);
 	}
@@ -575,7 +575,7 @@ __noendbr void ibt_restore(u64 save)
 	u64 msr;
 
 	if (cpu_feature_enabled(X86_FEATURE_IBT)) {
-		rdmsrl(MSR_IA32_S_CET, msr);
+		rdmsrq(MSR_IA32_S_CET, msr);
 		msr &= ~CET_ENDBR_EN;
 		msr |= (save & CET_ENDBR_EN);
 		wrmsrl(MSR_IA32_S_CET, msr);
@@ -1288,7 +1288,7 @@ u64 x86_read_arch_cap_msr(void)
 	u64 x86_arch_cap_msr = 0;
 
 	if (boot_cpu_has(X86_FEATURE_ARCH_CAPABILITIES))
-		rdmsrl(MSR_IA32_ARCH_CAPABILITIES, x86_arch_cap_msr);
+		rdmsrq(MSR_IA32_ARCH_CAPABILITIES, x86_arch_cap_msr);
 
 	return x86_arch_cap_msr;
 }
@@ -1749,10 +1749,10 @@ static bool detect_null_seg_behavior(void)
 	 */
 
 	unsigned long old_base, tmp;
-	rdmsrl(MSR_FS_BASE, old_base);
+	rdmsrq(MSR_FS_BASE, old_base);
 	wrmsrl(MSR_FS_BASE, 1);
 	loadsegment(fs, 0);
-	rdmsrl(MSR_FS_BASE, tmp);
+	rdmsrq(MSR_FS_BASE, tmp);
 	wrmsrl(MSR_FS_BASE, old_base);
 	return tmp == 0;
 }
diff --git a/arch/x86/kernel/cpu/hygon.c b/arch/x86/kernel/cpu/hygon.c
index 6af4a4a..10eeda3 100644
--- a/arch/x86/kernel/cpu/hygon.c
+++ b/arch/x86/kernel/cpu/hygon.c
@@ -96,7 +96,7 @@ static void bsp_init_hygon(struct cpuinfo_x86 *c)
 	if (cpu_has(c, X86_FEATURE_CONSTANT_TSC)) {
 		u64 val;
 
-		rdmsrl(MSR_K7_HWCR, val);
+		rdmsrq(MSR_K7_HWCR, val);
 		if (!(val & BIT(24)))
 			pr_warn(FW_BUG "TSC doesn't count with P0 frequency!\n");
 	}
@@ -194,7 +194,7 @@ static void init_hygon(struct cpuinfo_x86 *c)
 	init_hygon_cacheinfo(c);
 
 	if (cpu_has(c, X86_FEATURE_SVM)) {
-		rdmsrl(MSR_VM_CR, vm_cr);
+		rdmsrq(MSR_VM_CR, vm_cr);
 		if (vm_cr & SVM_VM_CR_SVM_DIS_MASK) {
 			pr_notice_once("SVM disabled (by BIOS) in MSR_VM_CR\n");
 			clear_cpu_cap(c, X86_FEATURE_SVM);
diff --git a/arch/x86/kernel/cpu/intel.c b/arch/x86/kernel/cpu/intel.c
index cdc9813..e9a6e0d 100644
--- a/arch/x86/kernel/cpu/intel.c
+++ b/arch/x86/kernel/cpu/intel.c
@@ -157,7 +157,7 @@ static void detect_tme_early(struct cpuinfo_x86 *c)
 	u64 tme_activate;
 	int keyid_bits;
 
-	rdmsrl(MSR_IA32_TME_ACTIVATE, tme_activate);
+	rdmsrq(MSR_IA32_TME_ACTIVATE, tme_activate);
 
 	if (!TME_ACTIVATE_LOCKED(tme_activate) || !TME_ACTIVATE_ENABLED(tme_activate)) {
 		pr_info_once("x86/tme: not enabled by BIOS\n");
@@ -299,7 +299,7 @@ static void early_init_intel(struct cpuinfo_x86 *c)
 	 * string flag and enhanced fast string capabilities accordingly.
 	 */
 	if (c->x86_vfm >= INTEL_PENTIUM_M_DOTHAN) {
-		rdmsrl(MSR_IA32_MISC_ENABLE, misc_enable);
+		rdmsrq(MSR_IA32_MISC_ENABLE, misc_enable);
 		if (misc_enable & MSR_IA32_MISC_ENABLE_FAST_STRING) {
 			/* X86_FEATURE_ERMS is set based on CPUID */
 			set_cpu_cap(c, X86_FEATURE_REP_GOOD);
diff --git a/arch/x86/kernel/cpu/intel_epb.c b/arch/x86/kernel/cpu/intel_epb.c
index 30b1d63..6e6af07 100644
--- a/arch/x86/kernel/cpu/intel_epb.c
+++ b/arch/x86/kernel/cpu/intel_epb.c
@@ -79,7 +79,7 @@ static int intel_epb_save(void)
 {
 	u64 epb;
 
-	rdmsrl(MSR_IA32_ENERGY_PERF_BIAS, epb);
+	rdmsrq(MSR_IA32_ENERGY_PERF_BIAS, epb);
 	/*
 	 * Ensure that saved_epb will always be nonzero after this write even if
 	 * the EPB value read from the MSR is 0.
@@ -94,7 +94,7 @@ static void intel_epb_restore(void)
 	u64 val = this_cpu_read(saved_epb);
 	u64 epb;
 
-	rdmsrl(MSR_IA32_ENERGY_PERF_BIAS, epb);
+	rdmsrq(MSR_IA32_ENERGY_PERF_BIAS, epb);
 	if (val) {
 		val &= EPB_MASK;
 	} else {
diff --git a/arch/x86/kernel/cpu/mce/amd.c b/arch/x86/kernel/cpu/mce/amd.c
index 1075a90..c29165f 100644
--- a/arch/x86/kernel/cpu/mce/amd.c
+++ b/arch/x86/kernel/cpu/mce/amd.c
@@ -662,7 +662,7 @@ static void disable_err_thresholding(struct cpuinfo_x86 *c, unsigned int bank)
 		return;
 	}
 
-	rdmsrl(MSR_K7_HWCR, hwcr);
+	rdmsrq(MSR_K7_HWCR, hwcr);
 
 	/* McStatusWrEn has to be set */
 	need_toggle = !(hwcr & BIT(18));
@@ -805,12 +805,12 @@ static void __log_error(unsigned int bank, u64 status, u64 addr, u64 misc)
 	}
 
 	if (mce_flags.smca) {
-		rdmsrl(MSR_AMD64_SMCA_MCx_IPID(bank), m->ipid);
+		rdmsrq(MSR_AMD64_SMCA_MCx_IPID(bank), m->ipid);
 
 		if (m->status & MCI_STATUS_SYNDV) {
-			rdmsrl(MSR_AMD64_SMCA_MCx_SYND(bank), m->synd);
-			rdmsrl(MSR_AMD64_SMCA_MCx_SYND1(bank), err.vendor.amd.synd1);
-			rdmsrl(MSR_AMD64_SMCA_MCx_SYND2(bank), err.vendor.amd.synd2);
+			rdmsrq(MSR_AMD64_SMCA_MCx_SYND(bank), m->synd);
+			rdmsrq(MSR_AMD64_SMCA_MCx_SYND1(bank), err.vendor.amd.synd1);
+			rdmsrq(MSR_AMD64_SMCA_MCx_SYND2(bank), err.vendor.amd.synd2);
 		}
 	}
 
@@ -834,12 +834,12 @@ _log_error_bank(unsigned int bank, u32 msr_stat, u32 msr_addr, u64 misc)
 {
 	u64 status, addr = 0;
 
-	rdmsrl(msr_stat, status);
+	rdmsrq(msr_stat, status);
 	if (!(status & MCI_STATUS_VAL))
 		return false;
 
 	if (status & MCI_STATUS_ADDRV)
-		rdmsrl(msr_addr, addr);
+		rdmsrq(msr_addr, addr);
 
 	__log_error(bank, status, addr, misc);
 
diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
index f6fd71b..a71228d 100644
--- a/arch/x86/kernel/cpu/mce/core.c
+++ b/arch/x86/kernel/cpu/mce/core.c
@@ -1822,7 +1822,7 @@ static void __mcheck_cpu_cap_init(void)
 	u64 cap;
 	u8 b;
 
-	rdmsrl(MSR_IA32_MCG_CAP, cap);
+	rdmsrq(MSR_IA32_MCG_CAP, cap);
 
 	b = cap & MCG_BANKCNT_MASK;
 
@@ -1863,7 +1863,7 @@ static void __mcheck_cpu_init_generic(void)
 
 	cr4_set_bits(X86_CR4_MCE);
 
-	rdmsrl(MSR_IA32_MCG_CAP, cap);
+	rdmsrq(MSR_IA32_MCG_CAP, cap);
 	if (cap & MCG_CTL_P)
 		wrmsr(MSR_IA32_MCG_CTL, 0xffffffff, 0xffffffff);
 }
@@ -1905,7 +1905,7 @@ static void __mcheck_cpu_check_banks(void)
 		if (!b->init)
 			continue;
 
-		rdmsrl(mca_msr_reg(i, MCA_CTL), msrval);
+		rdmsrq(mca_msr_reg(i, MCA_CTL), msrval);
 		b->init = !!msrval;
 	}
 }
diff --git a/arch/x86/kernel/cpu/mce/inject.c b/arch/x86/kernel/cpu/mce/inject.c
index 06e3cf7..08d52af 100644
--- a/arch/x86/kernel/cpu/mce/inject.c
+++ b/arch/x86/kernel/cpu/mce/inject.c
@@ -741,7 +741,7 @@ static void check_hw_inj_possible(void)
 		u64 status = MCI_STATUS_VAL, ipid;
 
 		/* Check whether bank is populated */
-		rdmsrl(MSR_AMD64_SMCA_MCx_IPID(bank), ipid);
+		rdmsrq(MSR_AMD64_SMCA_MCx_IPID(bank), ipid);
 		if (!ipid)
 			continue;
 
diff --git a/arch/x86/kernel/cpu/mce/intel.c b/arch/x86/kernel/cpu/mce/intel.c
index f863df0..9fda956 100644
--- a/arch/x86/kernel/cpu/mce/intel.c
+++ b/arch/x86/kernel/cpu/mce/intel.c
@@ -94,7 +94,7 @@ static bool cmci_supported(int *banks)
 	if (!boot_cpu_has(X86_FEATURE_APIC) || lapic_get_maxlvt() < 6)
 		return false;
 
-	rdmsrl(MSR_IA32_MCG_CAP, cap);
+	rdmsrq(MSR_IA32_MCG_CAP, cap);
 	*banks = min_t(unsigned, MAX_NR_BANKS, cap & MCG_BANKCNT_MASK);
 	return !!(cap & MCG_CMCI_P);
 }
@@ -106,7 +106,7 @@ static bool lmce_supported(void)
 	if (mca_cfg.lmce_disabled)
 		return false;
 
-	rdmsrl(MSR_IA32_MCG_CAP, tmp);
+	rdmsrq(MSR_IA32_MCG_CAP, tmp);
 
 	/*
 	 * LMCE depends on recovery support in the processor. Hence both
@@ -123,7 +123,7 @@ static bool lmce_supported(void)
 	 * WARN if the MSR isn't locked as init_ia32_feat_ctl() unconditionally
 	 * locks the MSR in the event that it wasn't already locked by BIOS.
 	 */
-	rdmsrl(MSR_IA32_FEAT_CTL, tmp);
+	rdmsrq(MSR_IA32_FEAT_CTL, tmp);
 	if (WARN_ON_ONCE(!(tmp & FEAT_CTL_LOCKED)))
 		return false;
 
@@ -141,7 +141,7 @@ static void cmci_set_threshold(int bank, int thresh)
 	u64 val;
 
 	raw_spin_lock_irqsave(&cmci_discover_lock, flags);
-	rdmsrl(MSR_IA32_MCx_CTL2(bank), val);
+	rdmsrq(MSR_IA32_MCx_CTL2(bank), val);
 	val &= ~MCI_CTL2_CMCI_THRESHOLD_MASK;
 	wrmsrl(MSR_IA32_MCx_CTL2(bank), val | thresh);
 	raw_spin_unlock_irqrestore(&cmci_discover_lock, flags);
@@ -184,7 +184,7 @@ static bool cmci_skip_bank(int bank, u64 *val)
 	if (test_bit(bank, mce_banks_ce_disabled))
 		return true;
 
-	rdmsrl(MSR_IA32_MCx_CTL2(bank), *val);
+	rdmsrq(MSR_IA32_MCx_CTL2(bank), *val);
 
 	/* Already owned by someone else? */
 	if (*val & MCI_CTL2_CMCI_EN) {
@@ -233,7 +233,7 @@ static void cmci_claim_bank(int bank, u64 val, int bios_zero_thresh, int *bios_w
 
 	val |= MCI_CTL2_CMCI_EN;
 	wrmsrl(MSR_IA32_MCx_CTL2(bank), val);
-	rdmsrl(MSR_IA32_MCx_CTL2(bank), val);
+	rdmsrq(MSR_IA32_MCx_CTL2(bank), val);
 
 	/* If the enable bit did not stick, this bank should be polled. */
 	if (!(val & MCI_CTL2_CMCI_EN)) {
@@ -324,7 +324,7 @@ static void __cmci_disable_bank(int bank)
 
 	if (!test_bit(bank, this_cpu_ptr(mce_banks_owned)))
 		return;
-	rdmsrl(MSR_IA32_MCx_CTL2(bank), val);
+	rdmsrq(MSR_IA32_MCx_CTL2(bank), val);
 	val &= ~MCI_CTL2_CMCI_EN;
 	wrmsrl(MSR_IA32_MCx_CTL2(bank), val);
 	__clear_bit(bank, this_cpu_ptr(mce_banks_owned));
@@ -430,7 +430,7 @@ void intel_init_lmce(void)
 	if (!lmce_supported())
 		return;
 
-	rdmsrl(MSR_IA32_MCG_EXT_CTL, val);
+	rdmsrq(MSR_IA32_MCG_EXT_CTL, val);
 
 	if (!(val & MCG_EXT_CTL_LMCE_EN))
 		wrmsrl(MSR_IA32_MCG_EXT_CTL, val | MCG_EXT_CTL_LMCE_EN);
@@ -443,7 +443,7 @@ void intel_clear_lmce(void)
 	if (!lmce_supported())
 		return;
 
-	rdmsrl(MSR_IA32_MCG_EXT_CTL, val);
+	rdmsrq(MSR_IA32_MCG_EXT_CTL, val);
 	val &= ~MCG_EXT_CTL_LMCE_EN;
 	wrmsrl(MSR_IA32_MCG_EXT_CTL, val);
 }
diff --git a/arch/x86/kernel/cpu/mshyperv.c b/arch/x86/kernel/cpu/mshyperv.c
index 3e25339..b1b9b4c 100644
--- a/arch/x86/kernel/cpu/mshyperv.c
+++ b/arch/x86/kernel/cpu/mshyperv.c
@@ -70,7 +70,7 @@ u64 hv_get_non_nested_msr(unsigned int reg)
 	if (hv_is_synic_msr(reg) && ms_hyperv.paravisor_present)
 		hv_ivm_msr_read(reg, &value);
 	else
-		rdmsrl(reg, value);
+		rdmsrq(reg, value);
 	return value;
 }
 EXPORT_SYMBOL_GPL(hv_get_non_nested_msr);
@@ -345,7 +345,7 @@ static unsigned long hv_get_tsc_khz(void)
 {
 	unsigned long freq;
 
-	rdmsrl(HV_X64_MSR_TSC_FREQUENCY, freq);
+	rdmsrq(HV_X64_MSR_TSC_FREQUENCY, freq);
 
 	return freq / 1000;
 }
@@ -541,7 +541,7 @@ static void __init ms_hyperv_init_platform(void)
 		 */
 		u64	hv_lapic_frequency;
 
-		rdmsrl(HV_X64_MSR_APIC_FREQUENCY, hv_lapic_frequency);
+		rdmsrq(HV_X64_MSR_APIC_FREQUENCY, hv_lapic_frequency);
 		hv_lapic_frequency = div_u64(hv_lapic_frequency, HZ);
 		lapic_timer_period = hv_lapic_frequency;
 		pr_info("Hyper-V: LAPIC Timer Frequency: %#x\n",
diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resctrl/core.c
index cf29681..76c887b 100644
--- a/arch/x86/kernel/cpu/resctrl/core.c
+++ b/arch/x86/kernel/cpu/resctrl/core.c
@@ -148,7 +148,7 @@ static inline void cache_alloc_hsw_probe(void)
 	if (wrmsrl_safe(MSR_IA32_L3_CBM_BASE, max_cbm))
 		return;
 
-	rdmsrl(MSR_IA32_L3_CBM_BASE, l3_cbm_0);
+	rdmsrq(MSR_IA32_L3_CBM_BASE, l3_cbm_0);
 
 	/* If all the bits were set in MSR, return success */
 	if (l3_cbm_0 != max_cbm)
diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c b/arch/x86/kernel/cpu/resctrl/monitor.c
index a93ed7d..f73a749 100644
--- a/arch/x86/kernel/cpu/resctrl/monitor.c
+++ b/arch/x86/kernel/cpu/resctrl/monitor.c
@@ -238,7 +238,7 @@ static int __rmid_read_phys(u32 prmid, enum resctrl_event_id eventid, u64 *val)
 	 * are error bits.
 	 */
 	wrmsr(MSR_IA32_QM_EVTSEL, eventid, prmid);
-	rdmsrl(MSR_IA32_QM_CTR, msr_val);
+	rdmsrq(MSR_IA32_QM_CTR, msr_val);
 
 	if (msr_val & RMID_VAL_ERROR)
 		return -EIO;
diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index 93ec829..3be9866 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -1635,7 +1635,7 @@ void resctrl_arch_mon_event_config_read(void *_config_info)
 		pr_warn_once("Invalid event id %d\n", config_info->evtid);
 		return;
 	}
-	rdmsrl(MSR_IA32_EVT_CFG_BASE + index, msrval);
+	rdmsrq(MSR_IA32_EVT_CFG_BASE + index, msrval);
 
 	/* Report only the valid event configuration bits */
 	config_info->mon_config = msrval & MAX_EVT_CONFIG_BITS;
diff --git a/arch/x86/kernel/cpu/topology.c b/arch/x86/kernel/cpu/topology.c
index 0145623..6e1885d 100644
--- a/arch/x86/kernel/cpu/topology.c
+++ b/arch/x86/kernel/cpu/topology.c
@@ -154,7 +154,7 @@ static __init bool check_for_real_bsp(u32 apic_id)
 	 * kernel must rely on the firmware enumeration order.
 	 */
 	if (has_apic_base) {
-		rdmsrl(MSR_IA32_APICBASE, msr);
+		rdmsrq(MSR_IA32_APICBASE, msr);
 		is_bsp = !!(msr & MSR_IA32_APICBASE_BSP);
 	}
 
diff --git a/arch/x86/kernel/cpu/topology_amd.c b/arch/x86/kernel/cpu/topology_amd.c
index 03b3c9c..535dcf5 100644
--- a/arch/x86/kernel/cpu/topology_amd.c
+++ b/arch/x86/kernel/cpu/topology_amd.c
@@ -133,7 +133,7 @@ static void parse_fam10h_node_id(struct topo_scan *tscan)
 	if (!boot_cpu_has(X86_FEATURE_NODEID_MSR))
 		return;
 
-	rdmsrl(MSR_FAM10H_NODE_ID, nid.msr);
+	rdmsrq(MSR_FAM10H_NODE_ID, nid.msr);
 	store_node(tscan, nid.nodes_per_pkg + 1, nid.node_id);
 	tscan->c->topo.llc_id = nid.node_id;
 }
@@ -160,7 +160,7 @@ static void topoext_fixup(struct topo_scan *tscan)
 	if (msr_set_bit(0xc0011005, 54) <= 0)
 		return;
 
-	rdmsrl(0xc0011005, msrval);
+	rdmsrq(0xc0011005, msrval);
 	if (msrval & BIT_64(54)) {
 		set_cpu_cap(c, X86_FEATURE_TOPOEXT);
 		pr_info_once(FW_INFO "CPU: Re-enabling disabled Topology Extensions Support.\n");
diff --git a/arch/x86/kernel/cpu/tsx.c b/arch/x86/kernel/cpu/tsx.c
index b31ee4f..c3aaa68 100644
--- a/arch/x86/kernel/cpu/tsx.c
+++ b/arch/x86/kernel/cpu/tsx.c
@@ -24,7 +24,7 @@ static void tsx_disable(void)
 {
 	u64 tsx;
 
-	rdmsrl(MSR_IA32_TSX_CTRL, tsx);
+	rdmsrq(MSR_IA32_TSX_CTRL, tsx);
 
 	/* Force all transactions to immediately abort */
 	tsx |= TSX_CTRL_RTM_DISABLE;
@@ -44,7 +44,7 @@ static void tsx_enable(void)
 {
 	u64 tsx;
 
-	rdmsrl(MSR_IA32_TSX_CTRL, tsx);
+	rdmsrq(MSR_IA32_TSX_CTRL, tsx);
 
 	/* Enable the RTM feature in the cpu */
 	tsx &= ~TSX_CTRL_RTM_DISABLE;
@@ -115,11 +115,11 @@ static void tsx_clear_cpuid(void)
 	 */
 	if (boot_cpu_has(X86_FEATURE_RTM_ALWAYS_ABORT) &&
 	    boot_cpu_has(X86_FEATURE_TSX_FORCE_ABORT)) {
-		rdmsrl(MSR_TSX_FORCE_ABORT, msr);
+		rdmsrq(MSR_TSX_FORCE_ABORT, msr);
 		msr |= MSR_TFA_TSX_CPUID_CLEAR;
 		wrmsrl(MSR_TSX_FORCE_ABORT, msr);
 	} else if (cpu_feature_enabled(X86_FEATURE_MSR_TSX_CTRL)) {
-		rdmsrl(MSR_IA32_TSX_CTRL, msr);
+		rdmsrq(MSR_IA32_TSX_CTRL, msr);
 		msr |= TSX_CTRL_CPUID_CLEAR;
 		wrmsrl(MSR_IA32_TSX_CTRL, msr);
 	}
@@ -146,7 +146,7 @@ static void tsx_dev_mode_disable(void)
 	    !cpu_feature_enabled(X86_FEATURE_SRBDS_CTRL))
 		return;
 
-	rdmsrl(MSR_IA32_MCU_OPT_CTRL, mcu_opt_ctrl);
+	rdmsrq(MSR_IA32_MCU_OPT_CTRL, mcu_opt_ctrl);
 
 	if (mcu_opt_ctrl & RTM_ALLOW) {
 		mcu_opt_ctrl &= ~RTM_ALLOW;
diff --git a/arch/x86/kernel/cpu/umwait.c b/arch/x86/kernel/cpu/umwait.c
index 2293efd..0050eae 100644
--- a/arch/x86/kernel/cpu/umwait.c
+++ b/arch/x86/kernel/cpu/umwait.c
@@ -214,7 +214,7 @@ static int __init umwait_init(void)
 	 * changed. This is the only place where orig_umwait_control_cached
 	 * is modified.
 	 */
-	rdmsrl(MSR_IA32_UMWAIT_CONTROL, orig_umwait_control_cached);
+	rdmsrq(MSR_IA32_UMWAIT_CONTROL, orig_umwait_control_cached);
 
 	ret = cpuhp_setup_state(CPUHP_AP_ONLINE_DYN, "umwait:online",
 				umwait_cpu_online, umwait_cpu_offline);
diff --git a/arch/x86/kernel/fpu/core.c b/arch/x86/kernel/fpu/core.c
index 91d6341..985dfff 100644
--- a/arch/x86/kernel/fpu/core.c
+++ b/arch/x86/kernel/fpu/core.c
@@ -327,7 +327,7 @@ void fpu_sync_guest_vmexit_xfd_state(void)
 
 	lockdep_assert_irqs_disabled();
 	if (fpu_state_size_dynamic()) {
-		rdmsrl(MSR_IA32_XFD, fps->xfd);
+		rdmsrq(MSR_IA32_XFD, fps->xfd);
 		__this_cpu_write(xfd_state, fps->xfd);
 	}
 }
diff --git a/arch/x86/kernel/hpet.c b/arch/x86/kernel/hpet.c
index 7f4b296..cc5d122 100644
--- a/arch/x86/kernel/hpet.c
+++ b/arch/x86/kernel/hpet.c
@@ -970,7 +970,7 @@ static bool __init hpet_is_pc10_damaged(void)
 		return false;
 
 	/* Check whether PC10 is enabled in PKG C-state limit */
-	rdmsrl(MSR_PKG_CST_CONFIG_CONTROL, pcfg);
+	rdmsrq(MSR_PKG_CST_CONFIG_CONTROL, pcfg);
 	if ((pcfg & 0xF) < 8)
 		return false;
 
diff --git a/arch/x86/kernel/kvm.c b/arch/x86/kernel/kvm.c
index 3be9b33..f7aa39c 100644
--- a/arch/x86/kernel/kvm.c
+++ b/arch/x86/kernel/kvm.c
@@ -728,7 +728,7 @@ static int kvm_suspend(void)
 
 #ifdef CONFIG_ARCH_CPUIDLE_HALTPOLL
 	if (kvm_para_has_feature(KVM_FEATURE_POLL_CONTROL))
-		rdmsrl(MSR_KVM_POLL_CONTROL, val);
+		rdmsrq(MSR_KVM_POLL_CONTROL, val);
 	has_guest_poll = !(val & 1);
 #endif
 	return 0;
diff --git a/arch/x86/kernel/mmconf-fam10h_64.c b/arch/x86/kernel/mmconf-fam10h_64.c
index 1f54eed..5c6a55f 100644
--- a/arch/x86/kernel/mmconf-fam10h_64.c
+++ b/arch/x86/kernel/mmconf-fam10h_64.c
@@ -97,7 +97,7 @@ static void get_fam10h_pci_mmconf_base(void)
 
 	/* SYS_CFG */
 	address = MSR_AMD64_SYSCFG;
-	rdmsrl(address, val);
+	rdmsrq(address, val);
 
 	/* TOP_MEM2 is not enabled? */
 	if (!(val & (1<<21))) {
@@ -105,7 +105,7 @@ static void get_fam10h_pci_mmconf_base(void)
 	} else {
 		/* TOP_MEM2 */
 		address = MSR_K8_TOP_MEM2;
-		rdmsrl(address, val);
+		rdmsrq(address, val);
 		tom2 = max(val & 0xffffff800000ULL, 1ULL << 32);
 	}
 
@@ -177,7 +177,7 @@ void fam10h_check_enable_mmcfg(void)
 		return;
 
 	address = MSR_FAM10H_MMIO_CONF_BASE;
-	rdmsrl(address, val);
+	rdmsrq(address, val);
 
 	/* try to make sure that AP's setting is identical to BSP setting */
 	if (val & FAM10H_MMIO_CONF_ENABLE) {
diff --git a/arch/x86/kernel/process.c b/arch/x86/kernel/process.c
index 962c3ce..197be71 100644
--- a/arch/x86/kernel/process.c
+++ b/arch/x86/kernel/process.c
@@ -710,7 +710,7 @@ void __switch_to_xtra(struct task_struct *prev_p, struct task_struct *next_p)
 	    arch_has_block_step()) {
 		unsigned long debugctl, msk;
 
-		rdmsrl(MSR_IA32_DEBUGCTLMSR, debugctl);
+		rdmsrq(MSR_IA32_DEBUGCTLMSR, debugctl);
 		debugctl &= ~DEBUGCTLMSR_BTF;
 		msk = tifn & _TIF_BLOCKSTEP;
 		debugctl |= (msk >> TIF_BLOCKSTEP) << DEBUGCTLMSR_BTF_SHIFT;
diff --git a/arch/x86/kernel/process_64.c b/arch/x86/kernel/process_64.c
index 7196ca7..422c5da 100644
--- a/arch/x86/kernel/process_64.c
+++ b/arch/x86/kernel/process_64.c
@@ -95,8 +95,8 @@ void __show_regs(struct pt_regs *regs, enum show_regs_mode mode,
 		return;
 
 	if (mode == SHOW_REGS_USER) {
-		rdmsrl(MSR_FS_BASE, fs);
-		rdmsrl(MSR_KERNEL_GS_BASE, shadowgs);
+		rdmsrq(MSR_FS_BASE, fs);
+		rdmsrq(MSR_KERNEL_GS_BASE, shadowgs);
 		printk("%sFS:  %016lx GS:  %016lx\n",
 		       log_lvl, fs, shadowgs);
 		return;
@@ -107,9 +107,9 @@ void __show_regs(struct pt_regs *regs, enum show_regs_mode mode,
 	asm("movl %%fs,%0" : "=r" (fsindex));
 	asm("movl %%gs,%0" : "=r" (gsindex));
 
-	rdmsrl(MSR_FS_BASE, fs);
-	rdmsrl(MSR_GS_BASE, gs);
-	rdmsrl(MSR_KERNEL_GS_BASE, shadowgs);
+	rdmsrq(MSR_FS_BASE, fs);
+	rdmsrq(MSR_GS_BASE, gs);
+	rdmsrq(MSR_KERNEL_GS_BASE, shadowgs);
 
 	cr0 = read_cr0();
 	cr2 = read_cr2();
@@ -195,7 +195,7 @@ static noinstr unsigned long __rdgsbase_inactive(void)
 		native_swapgs();
 	} else {
 		instrumentation_begin();
-		rdmsrl(MSR_KERNEL_GS_BASE, gsbase);
+		rdmsrq(MSR_KERNEL_GS_BASE, gsbase);
 		instrumentation_end();
 	}
 
@@ -463,7 +463,7 @@ unsigned long x86_gsbase_read_cpu_inactive(void)
 		gsbase = __rdgsbase_inactive();
 		local_irq_restore(flags);
 	} else {
-		rdmsrl(MSR_KERNEL_GS_BASE, gsbase);
+		rdmsrq(MSR_KERNEL_GS_BASE, gsbase);
 	}
 
 	return gsbase;
diff --git a/arch/x86/kernel/shstk.c b/arch/x86/kernel/shstk.c
index 0596856..3d1ba20 100644
--- a/arch/x86/kernel/shstk.c
+++ b/arch/x86/kernel/shstk.c
@@ -239,7 +239,7 @@ static unsigned long get_user_shstk_addr(void)
 
 	fpregs_lock_and_load();
 
-	rdmsrl(MSR_IA32_PL3_SSP, ssp);
+	rdmsrq(MSR_IA32_PL3_SSP, ssp);
 
 	fpregs_unlock();
 
@@ -460,7 +460,7 @@ static int wrss_control(bool enable)
 		return 0;
 
 	fpregs_lock_and_load();
-	rdmsrl(MSR_IA32_U_CET, msrval);
+	rdmsrq(MSR_IA32_U_CET, msrval);
 
 	if (enable) {
 		features_set(ARCH_SHSTK_WRSS);
diff --git a/arch/x86/kernel/traps.c b/arch/x86/kernel/traps.c
index 9f88b8a..71b1467 100644
--- a/arch/x86/kernel/traps.c
+++ b/arch/x86/kernel/traps.c
@@ -1120,7 +1120,7 @@ static noinstr void exc_debug_kernel(struct pt_regs *regs, unsigned long dr6)
 		 */
 		unsigned long debugctl;
 
-		rdmsrl(MSR_IA32_DEBUGCTLMSR, debugctl);
+		rdmsrq(MSR_IA32_DEBUGCTLMSR, debugctl);
 		debugctl |= DEBUGCTLMSR_BTF;
 		wrmsrl(MSR_IA32_DEBUGCTLMSR, debugctl);
 	}
@@ -1386,7 +1386,7 @@ static bool handle_xfd_event(struct pt_regs *regs)
 	if (!IS_ENABLED(CONFIG_X86_64) || !cpu_feature_enabled(X86_FEATURE_XFD))
 		return false;
 
-	rdmsrl(MSR_IA32_XFD_ERR, xfd_err);
+	rdmsrq(MSR_IA32_XFD_ERR, xfd_err);
 	if (!xfd_err)
 		return false;
 
diff --git a/arch/x86/kernel/tsc.c b/arch/x86/kernel/tsc.c
index 88e5a4e..160fef7 100644
--- a/arch/x86/kernel/tsc.c
+++ b/arch/x86/kernel/tsc.c
@@ -1098,7 +1098,7 @@ static void __init detect_art(void)
 	if (art_base_clk.denominator < ART_MIN_DENOMINATOR)
 		return;
 
-	rdmsrl(MSR_IA32_TSC_ADJUST, art_base_clk.offset);
+	rdmsrq(MSR_IA32_TSC_ADJUST, art_base_clk.offset);
 
 	/* Make this sticky over multiple CPU init calls */
 	setup_force_cpu_cap(X86_FEATURE_ART);
diff --git a/arch/x86/kernel/tsc_sync.c b/arch/x86/kernel/tsc_sync.c
index 4334033..8260391 100644
--- a/arch/x86/kernel/tsc_sync.c
+++ b/arch/x86/kernel/tsc_sync.c
@@ -65,7 +65,7 @@ void tsc_verify_tsc_adjust(bool resume)
 
 	adj->nextcheck = jiffies + HZ;
 
-	rdmsrl(MSR_IA32_TSC_ADJUST, curval);
+	rdmsrq(MSR_IA32_TSC_ADJUST, curval);
 	if (adj->adjusted == curval)
 		return;
 
@@ -165,7 +165,7 @@ bool __init tsc_store_and_check_tsc_adjust(bool bootcpu)
 	if (check_tsc_unstable())
 		return false;
 
-	rdmsrl(MSR_IA32_TSC_ADJUST, bootval);
+	rdmsrq(MSR_IA32_TSC_ADJUST, bootval);
 	cur->bootval = bootval;
 	cur->nextcheck = jiffies + HZ;
 	tsc_sanitize_first_cpu(cur, bootval, smp_processor_id(), bootcpu);
@@ -187,7 +187,7 @@ bool tsc_store_and_check_tsc_adjust(bool bootcpu)
 	if (!boot_cpu_has(X86_FEATURE_TSC_ADJUST))
 		return false;
 
-	rdmsrl(MSR_IA32_TSC_ADJUST, bootval);
+	rdmsrq(MSR_IA32_TSC_ADJUST, bootval);
 	cur->bootval = bootval;
 	cur->nextcheck = jiffies + HZ;
 	cur->warned = false;
diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index d5d0c5c..21c3563 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -580,7 +580,7 @@ static inline void kvm_cpu_svm_disable(void)
 	uint64_t efer;
 
 	wrmsrl(MSR_VM_HSAVE_PA, 0);
-	rdmsrl(MSR_EFER, efer);
+	rdmsrq(MSR_EFER, efer);
 	if (efer & EFER_SVME) {
 		/*
 		 * Force GIF=1 prior to disabling SVM, e.g. to ensure INIT and
@@ -619,7 +619,7 @@ static int svm_enable_virtualization_cpu(void)
 	uint64_t efer;
 	int me = raw_smp_processor_id();
 
-	rdmsrl(MSR_EFER, efer);
+	rdmsrq(MSR_EFER, efer);
 	if (efer & EFER_SVME)
 		return -EBUSY;
 
@@ -5232,7 +5232,7 @@ static __init void svm_adjust_mmio_mask(void)
 		return;
 
 	/* If memory encryption is not enabled, use existing mask */
-	rdmsrl(MSR_AMD64_SYSCFG, msr);
+	rdmsrq(MSR_AMD64_SYSCFG, msr);
 	if (!(msr & MSR_AMD64_SYSCFG_MEM_ENCRYPT))
 		return;
 
diff --git a/arch/x86/kvm/vmx/nested.c b/arch/x86/kvm/vmx/nested.c
index 5504d9e..a7fea62 100644
--- a/arch/x86/kvm/vmx/nested.c
+++ b/arch/x86/kvm/vmx/nested.c
@@ -7202,8 +7202,8 @@ static void nested_vmx_setup_cr_fixed(struct nested_vmx_msrs *msrs)
 	msrs->cr4_fixed0 = VMXON_CR4_ALWAYSON;
 
 	/* These MSRs specify bits which the guest must keep fixed off. */
-	rdmsrl(MSR_IA32_VMX_CR0_FIXED1, msrs->cr0_fixed1);
-	rdmsrl(MSR_IA32_VMX_CR4_FIXED1, msrs->cr4_fixed1);
+	rdmsrq(MSR_IA32_VMX_CR0_FIXED1, msrs->cr0_fixed1);
+	rdmsrq(MSR_IA32_VMX_CR4_FIXED1, msrs->cr4_fixed1);
 
 	if (vmx_umip_emulated())
 		msrs->cr4_fixed1 |= X86_CR4_UMIP;
diff --git a/arch/x86/kvm/vmx/pmu_intel.c b/arch/x86/kvm/vmx/pmu_intel.c
index 77012b2..f0f02ee 100644
--- a/arch/x86/kvm/vmx/pmu_intel.c
+++ b/arch/x86/kvm/vmx/pmu_intel.c
@@ -279,7 +279,7 @@ static bool intel_pmu_handle_lbr_msrs_access(struct kvm_vcpu *vcpu,
 	local_irq_disable();
 	if (lbr_desc->event->state == PERF_EVENT_STATE_ACTIVE) {
 		if (read)
-			rdmsrl(index, msr_info->data);
+			rdmsrq(index, msr_info->data);
 		else
 			wrmsrl(index, msr_info->data);
 		__set_bit(INTEL_PMC_IDX_FIXED_VLBR, vcpu_to_pmu(vcpu)->pmc_in_use);
diff --git a/arch/x86/kvm/vmx/sgx.c b/arch/x86/kvm/vmx/sgx.c
index 9961e07..3cf4ef6 100644
--- a/arch/x86/kvm/vmx/sgx.c
+++ b/arch/x86/kvm/vmx/sgx.c
@@ -418,9 +418,9 @@ void setup_default_sgx_lepubkeyhash(void)
 		sgx_pubkey_hash[3] = 0xd4f8c05909f9bb3bULL;
 	} else {
 		/* MSR_IA32_SGXLEPUBKEYHASH0 is read above */
-		rdmsrl(MSR_IA32_SGXLEPUBKEYHASH1, sgx_pubkey_hash[1]);
-		rdmsrl(MSR_IA32_SGXLEPUBKEYHASH2, sgx_pubkey_hash[2]);
-		rdmsrl(MSR_IA32_SGXLEPUBKEYHASH3, sgx_pubkey_hash[3]);
+		rdmsrq(MSR_IA32_SGXLEPUBKEYHASH1, sgx_pubkey_hash[1]);
+		rdmsrq(MSR_IA32_SGXLEPUBKEYHASH2, sgx_pubkey_hash[2]);
+		rdmsrq(MSR_IA32_SGXLEPUBKEYHASH3, sgx_pubkey_hash[3]);
 	}
 }
 
diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index 5c57664..3e0762a 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -1206,13 +1206,13 @@ static inline void pt_save_msr(struct pt_ctx *ctx, u32 addr_range)
 {
 	u32 i;
 
-	rdmsrl(MSR_IA32_RTIT_STATUS, ctx->status);
-	rdmsrl(MSR_IA32_RTIT_OUTPUT_BASE, ctx->output_base);
-	rdmsrl(MSR_IA32_RTIT_OUTPUT_MASK, ctx->output_mask);
-	rdmsrl(MSR_IA32_RTIT_CR3_MATCH, ctx->cr3_match);
+	rdmsrq(MSR_IA32_RTIT_STATUS, ctx->status);
+	rdmsrq(MSR_IA32_RTIT_OUTPUT_BASE, ctx->output_base);
+	rdmsrq(MSR_IA32_RTIT_OUTPUT_MASK, ctx->output_mask);
+	rdmsrq(MSR_IA32_RTIT_CR3_MATCH, ctx->cr3_match);
 	for (i = 0; i < addr_range; i++) {
-		rdmsrl(MSR_IA32_RTIT_ADDR0_A + i * 2, ctx->addr_a[i]);
-		rdmsrl(MSR_IA32_RTIT_ADDR0_B + i * 2, ctx->addr_b[i]);
+		rdmsrq(MSR_IA32_RTIT_ADDR0_A + i * 2, ctx->addr_a[i]);
+		rdmsrq(MSR_IA32_RTIT_ADDR0_B + i * 2, ctx->addr_b[i]);
 	}
 }
 
@@ -1225,7 +1225,7 @@ static void pt_guest_enter(struct vcpu_vmx *vmx)
 	 * GUEST_IA32_RTIT_CTL is already set in the VMCS.
 	 * Save host state before VM entry.
 	 */
-	rdmsrl(MSR_IA32_RTIT_CTL, vmx->pt_desc.host.ctl);
+	rdmsrq(MSR_IA32_RTIT_CTL, vmx->pt_desc.host.ctl);
 	if (vmx->pt_desc.guest.ctl & RTIT_CTL_TRACEEN) {
 		wrmsrl(MSR_IA32_RTIT_CTL, 0);
 		pt_save_msr(&vmx->pt_desc.host, vmx->pt_desc.num_address_ranges);
@@ -1362,7 +1362,7 @@ static void vmx_prepare_switch_to_host(struct vcpu_vmx *vmx)
 	++vmx->vcpu.stat.host_state_reload;
 
 #ifdef CONFIG_X86_64
-	rdmsrl(MSR_KERNEL_GS_BASE, vmx->msr_guest_kernel_gs_base);
+	rdmsrq(MSR_KERNEL_GS_BASE, vmx->msr_guest_kernel_gs_base);
 #endif
 	if (host_state->ldt_sel || (host_state->gs_sel & 7)) {
 		kvm_load_ldt(host_state->ldt_sel);
@@ -1394,7 +1394,7 @@ static u64 vmx_read_guest_kernel_gs_base(struct vcpu_vmx *vmx)
 {
 	preempt_disable();
 	if (vmx->guest_state_loaded)
-		rdmsrl(MSR_KERNEL_GS_BASE, vmx->msr_guest_kernel_gs_base);
+		rdmsrq(MSR_KERNEL_GS_BASE, vmx->msr_guest_kernel_gs_base);
 	preempt_enable();
 	return vmx->msr_guest_kernel_gs_base;
 }
@@ -2574,7 +2574,7 @@ static u64 adjust_vmx_controls64(u64 ctl_opt, u32 msr)
 {
 	u64 allowed;
 
-	rdmsrl(msr, allowed);
+	rdmsrq(msr, allowed);
 
 	return  ctl_opt & allowed;
 }
@@ -2746,7 +2746,7 @@ static int setup_vmcs_config(struct vmcs_config *vmcs_conf,
 		break;
 	}
 
-	rdmsrl(MSR_IA32_VMX_BASIC, basic_msr);
+	rdmsrq(MSR_IA32_VMX_BASIC, basic_msr);
 
 	/* IA-32 SDM Vol 3B: VMCS size is never greater than 4kB. */
 	if (vmx_basic_vmcs_size(basic_msr) > PAGE_SIZE)
@@ -2766,7 +2766,7 @@ static int setup_vmcs_config(struct vmcs_config *vmcs_conf,
 	if (vmx_basic_vmcs_mem_type(basic_msr) != X86_MEMTYPE_WB)
 		return -EIO;
 
-	rdmsrl(MSR_IA32_VMX_MISC, misc_msr);
+	rdmsrq(MSR_IA32_VMX_MISC, misc_msr);
 
 	vmcs_conf->basic = basic_msr;
 	vmcs_conf->pin_based_exec_ctrl = _pin_based_exec_control;
@@ -4391,7 +4391,7 @@ void vmx_set_constant_host_state(struct vcpu_vmx *vmx)
 	if (!IS_ENABLED(CONFIG_IA32_EMULATION) && !IS_ENABLED(CONFIG_X86_32))
 		vmcs_writel(HOST_IA32_SYSENTER_ESP, 0);
 
-	rdmsrl(MSR_IA32_SYSENTER_EIP, tmpl);
+	rdmsrq(MSR_IA32_SYSENTER_EIP, tmpl);
 	vmcs_writel(HOST_IA32_SYSENTER_EIP, tmpl);   /* 22.2.3 */
 
 	if (vmcs_config.vmexit_ctrl & VM_EXIT_LOAD_IA32_PAT) {
@@ -7052,7 +7052,7 @@ static void handle_nm_fault_irqoff(struct kvm_vcpu *vcpu)
 	 * the #NM exception.
 	 */
 	if (is_xfd_nm_fault(vcpu))
-		rdmsrl(MSR_IA32_XFD_ERR, vcpu->arch.guest_fpu.xfd_err);
+		rdmsrq(MSR_IA32_XFD_ERR, vcpu->arch.guest_fpu.xfd_err);
 }
 
 static void handle_exception_irqoff(struct kvm_vcpu *vcpu, u32 intr_info)
@@ -7959,7 +7959,7 @@ static __init u64 vmx_get_perf_capabilities(void)
 		return 0;
 
 	if (boot_cpu_has(X86_FEATURE_PDCM))
-		rdmsrl(MSR_IA32_PERF_CAPABILITIES, host_perf_cap);
+		rdmsrq(MSR_IA32_PERF_CAPABILITIES, host_perf_cap);
 
 	if (!cpu_feature_enabled(X86_FEATURE_ARCH_LBR)) {
 		x86_perf_get_lbr(&vmx_lbr_caps);
@@ -8508,7 +8508,7 @@ __init int vmx_hardware_setup(void)
 		kvm_enable_efer_bits(EFER_NX);
 
 	if (boot_cpu_has(X86_FEATURE_MPX)) {
-		rdmsrl(MSR_IA32_BNDCFGS, host_bndcfgs);
+		rdmsrq(MSR_IA32_BNDCFGS, host_bndcfgs);
 		WARN_ONCE(host_bndcfgs, "BNDCFGS in host will be lost");
 	}
 
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index c841817..c96c2ca 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -9773,12 +9773,12 @@ int kvm_x86_vendor_init(struct kvm_x86_init_ops *ops)
 	rdmsrl_safe(MSR_EFER, &kvm_host.efer);
 
 	if (boot_cpu_has(X86_FEATURE_XSAVES))
-		rdmsrl(MSR_IA32_XSS, kvm_host.xss);
+		rdmsrq(MSR_IA32_XSS, kvm_host.xss);
 
 	kvm_init_pmu_capability(ops->pmu_ops);
 
 	if (boot_cpu_has(X86_FEATURE_ARCH_CAPABILITIES))
-		rdmsrl(MSR_IA32_ARCH_CAPABILITIES, kvm_host.arch_capabilities);
+		rdmsrq(MSR_IA32_ARCH_CAPABILITIES, kvm_host.arch_capabilities);
 
 	r = ops->hardware_setup();
 	if (r != 0)
diff --git a/arch/x86/lib/insn-eval.c b/arch/x86/lib/insn-eval.c
index 98631c0..da5af3c 100644
--- a/arch/x86/lib/insn-eval.c
+++ b/arch/x86/lib/insn-eval.c
@@ -702,16 +702,16 @@ unsigned long insn_get_seg_base(struct pt_regs *regs, int seg_reg_idx)
 		unsigned long base;
 
 		if (seg_reg_idx == INAT_SEG_REG_FS) {
-			rdmsrl(MSR_FS_BASE, base);
+			rdmsrq(MSR_FS_BASE, base);
 		} else if (seg_reg_idx == INAT_SEG_REG_GS) {
 			/*
 			 * swapgs was called at the kernel entry point. Thus,
 			 * MSR_KERNEL_GS_BASE will have the user-space GS base.
 			 */
 			if (user_mode(regs))
-				rdmsrl(MSR_KERNEL_GS_BASE, base);
+				rdmsrq(MSR_KERNEL_GS_BASE, base);
 			else
-				rdmsrl(MSR_GS_BASE, base);
+				rdmsrq(MSR_GS_BASE, base);
 		} else {
 			base = 0;
 		}
diff --git a/arch/x86/mm/pat/memtype.c b/arch/x86/mm/pat/memtype.c
index 72d8cbc..ce6105e 100644
--- a/arch/x86/mm/pat/memtype.c
+++ b/arch/x86/mm/pat/memtype.c
@@ -256,7 +256,7 @@ void __init pat_bp_init(void)
 	if (!cpu_feature_enabled(X86_FEATURE_PAT))
 		pat_disable("PAT not supported by the CPU.");
 	else
-		rdmsrl(MSR_IA32_CR_PAT, pat_msr_val);
+		rdmsrq(MSR_IA32_CR_PAT, pat_msr_val);
 
 	if (!pat_msr_val) {
 		pat_disable("PAT support disabled by the firmware.");
diff --git a/arch/x86/pci/amd_bus.c b/arch/x86/pci/amd_bus.c
index 631512f..b92917c 100644
--- a/arch/x86/pci/amd_bus.c
+++ b/arch/x86/pci/amd_bus.c
@@ -202,7 +202,7 @@ static int __init early_root_info_init(void)
 
 	/* need to take out [0, TOM) for RAM*/
 	address = MSR_K8_TOP_MEM1;
-	rdmsrl(address, val);
+	rdmsrq(address, val);
 	end = (val & 0xffffff800000ULL);
 	printk(KERN_INFO "TOM: %016llx aka %lldM\n", end, end>>20);
 	if (end < (1ULL<<32))
@@ -293,12 +293,12 @@ static int __init early_root_info_init(void)
 	/* need to take out [4G, TOM2) for RAM*/
 	/* SYS_CFG */
 	address = MSR_AMD64_SYSCFG;
-	rdmsrl(address, val);
+	rdmsrq(address, val);
 	/* TOP_MEM2 is enabled? */
 	if (val & (1<<21)) {
 		/* TOP_MEM2 */
 		address = MSR_K8_TOP_MEM2;
-		rdmsrl(address, val);
+		rdmsrq(address, val);
 		end = (val & 0xffffff800000ULL);
 		printk(KERN_INFO "TOM2: %016llx aka %lldM\n", end, end>>20);
 		subtract_range(range, RANGE_NUM, 1ULL<<32, end);
@@ -341,7 +341,7 @@ static int amd_bus_cpu_online(unsigned int cpu)
 {
 	u64 reg;
 
-	rdmsrl(MSR_AMD64_NB_CFG, reg);
+	rdmsrq(MSR_AMD64_NB_CFG, reg);
 	if (!(reg & ENABLE_CF8_EXT_CFG)) {
 		reg |= ENABLE_CF8_EXT_CFG;
 		wrmsrl(MSR_AMD64_NB_CFG, reg);
diff --git a/arch/x86/platform/olpc/olpc-xo1-rtc.c b/arch/x86/platform/olpc/olpc-xo1-rtc.c
index 57f210c..ee77d57 100644
--- a/arch/x86/platform/olpc/olpc-xo1-rtc.c
+++ b/arch/x86/platform/olpc/olpc-xo1-rtc.c
@@ -64,9 +64,9 @@ static int __init xo1_rtc_init(void)
 	of_node_put(node);
 
 	pr_info("olpc-xo1-rtc: Initializing OLPC XO-1 RTC\n");
-	rdmsrl(MSR_RTC_DOMA_OFFSET, rtc_info.rtc_day_alarm);
-	rdmsrl(MSR_RTC_MONA_OFFSET, rtc_info.rtc_mon_alarm);
-	rdmsrl(MSR_RTC_CEN_OFFSET, rtc_info.rtc_century);
+	rdmsrq(MSR_RTC_DOMA_OFFSET, rtc_info.rtc_day_alarm);
+	rdmsrq(MSR_RTC_MONA_OFFSET, rtc_info.rtc_mon_alarm);
+	rdmsrq(MSR_RTC_CEN_OFFSET, rtc_info.rtc_century);
 
 	r = platform_device_register(&xo1_rtc_device);
 	if (r)
diff --git a/arch/x86/power/cpu.c b/arch/x86/power/cpu.c
index 08e76a5..874fe98 100644
--- a/arch/x86/power/cpu.c
+++ b/arch/x86/power/cpu.c
@@ -44,7 +44,7 @@ static void msr_save_context(struct saved_context *ctxt)
 
 	while (msr < end) {
 		if (msr->valid)
-			rdmsrl(msr->info.msr_no, msr->info.reg.q);
+			rdmsrq(msr->info.msr_no, msr->info.reg.q);
 		msr++;
 	}
 }
@@ -110,12 +110,12 @@ static void __save_processor_state(struct saved_context *ctxt)
 	savesegment(ds, ctxt->ds);
 	savesegment(es, ctxt->es);
 
-	rdmsrl(MSR_FS_BASE, ctxt->fs_base);
-	rdmsrl(MSR_GS_BASE, ctxt->kernelmode_gs_base);
-	rdmsrl(MSR_KERNEL_GS_BASE, ctxt->usermode_gs_base);
+	rdmsrq(MSR_FS_BASE, ctxt->fs_base);
+	rdmsrq(MSR_GS_BASE, ctxt->kernelmode_gs_base);
+	rdmsrq(MSR_KERNEL_GS_BASE, ctxt->usermode_gs_base);
 	mtrr_save_fixed_ranges(NULL);
 
-	rdmsrl(MSR_EFER, ctxt->efer);
+	rdmsrq(MSR_EFER, ctxt->efer);
 #endif
 
 	/*
diff --git a/arch/x86/realmode/init.c b/arch/x86/realmode/init.c
index f9bc444..263787b 100644
--- a/arch/x86/realmode/init.c
+++ b/arch/x86/realmode/init.c
@@ -145,7 +145,7 @@ static void __init setup_real_mode(void)
 	 * Some AMD processors will #GP(0) if EFER.LMA is set in WRMSR
 	 * so we need to mask it out.
 	 */
-	rdmsrl(MSR_EFER, efer);
+	rdmsrq(MSR_EFER, efer);
 	trampoline_header->efer = efer & ~EFER_LMA;
 
 	trampoline_header->start = (u64) secondary_startup_64;
diff --git a/arch/x86/virt/svm/sev.c b/arch/x86/virt/svm/sev.c
index fc473ca..9ddd102 100644
--- a/arch/x86/virt/svm/sev.c
+++ b/arch/x86/virt/svm/sev.c
@@ -136,7 +136,7 @@ static int __mfd_enable(unsigned int cpu)
 	if (!cc_platform_has(CC_ATTR_HOST_SEV_SNP))
 		return 0;
 
-	rdmsrl(MSR_AMD64_SYSCFG, val);
+	rdmsrq(MSR_AMD64_SYSCFG, val);
 
 	val |= MSR_AMD64_SYSCFG_MFDM;
 
@@ -157,7 +157,7 @@ static int __snp_enable(unsigned int cpu)
 	if (!cc_platform_has(CC_ATTR_HOST_SEV_SNP))
 		return 0;
 
-	rdmsrl(MSR_AMD64_SYSCFG, val);
+	rdmsrq(MSR_AMD64_SYSCFG, val);
 
 	val |= MSR_AMD64_SYSCFG_SNP_EN;
 	val |= MSR_AMD64_SYSCFG_SNP_VMPL_EN;
@@ -522,7 +522,7 @@ int __init snp_rmptable_init(void)
 	 * Check if SEV-SNP is already enabled, this can happen in case of
 	 * kexec boot.
 	 */
-	rdmsrl(MSR_AMD64_SYSCFG, val);
+	rdmsrq(MSR_AMD64_SYSCFG, val);
 	if (val & MSR_AMD64_SYSCFG_SNP_EN)
 		goto skip_enable;
 
@@ -576,8 +576,8 @@ static bool probe_contiguous_rmptable_info(void)
 {
 	u64 rmp_sz, rmp_base, rmp_end;
 
-	rdmsrl(MSR_AMD64_RMP_BASE, rmp_base);
-	rdmsrl(MSR_AMD64_RMP_END, rmp_end);
+	rdmsrq(MSR_AMD64_RMP_BASE, rmp_base);
+	rdmsrq(MSR_AMD64_RMP_END, rmp_end);
 
 	if (!(rmp_base & RMP_ADDR_MASK) || !(rmp_end & RMP_ADDR_MASK)) {
 		pr_err("Memory for the RMP table has not been reserved by BIOS\n");
@@ -610,13 +610,13 @@ static bool probe_segmented_rmptable_info(void)
 	unsigned int eax, ebx, segment_shift, segment_shift_min, segment_shift_max;
 	u64 rmp_base, rmp_end;
 
-	rdmsrl(MSR_AMD64_RMP_BASE, rmp_base);
+	rdmsrq(MSR_AMD64_RMP_BASE, rmp_base);
 	if (!(rmp_base & RMP_ADDR_MASK)) {
 		pr_err("Memory for the RMP table has not been reserved by BIOS\n");
 		return false;
 	}
 
-	rdmsrl(MSR_AMD64_RMP_END, rmp_end);
+	rdmsrq(MSR_AMD64_RMP_END, rmp_end);
 	WARN_ONCE(rmp_end & RMP_ADDR_MASK,
 		  "Segmented RMP enabled but RMP_END MSR is non-zero\n");
 
@@ -652,7 +652,7 @@ static bool probe_segmented_rmptable_info(void)
 bool snp_probe_rmptable_info(void)
 {
 	if (cpu_feature_enabled(X86_FEATURE_SEGMENTED_RMP))
-		rdmsrl(MSR_AMD64_RMP_CFG, rmp_cfg);
+		rdmsrq(MSR_AMD64_RMP_CFG, rmp_cfg);
 
 	if (rmp_cfg & MSR_AMD64_SEG_RMP_ENABLED)
 		return probe_segmented_rmptable_info();
diff --git a/arch/x86/xen/suspend.c b/arch/x86/xen/suspend.c
index 77a6ea1..cacac3d 100644
--- a/arch/x86/xen/suspend.c
+++ b/arch/x86/xen/suspend.c
@@ -55,7 +55,7 @@ static void xen_vcpu_notify_suspend(void *data)
 	tick_suspend_local();
 
 	if (xen_pv_domain() && boot_cpu_has(X86_FEATURE_SPEC_CTRL)) {
-		rdmsrl(MSR_IA32_SPEC_CTRL, tmp);
+		rdmsrq(MSR_IA32_SPEC_CTRL, tmp);
 		this_cpu_write(spec_ctrl, tmp);
 		wrmsrl(MSR_IA32_SPEC_CTRL, 0);
 	}
diff --git a/drivers/cpufreq/acpi-cpufreq.c b/drivers/cpufreq/acpi-cpufreq.c
index 924314c..8e31c25 100644
--- a/drivers/cpufreq/acpi-cpufreq.c
+++ b/drivers/cpufreq/acpi-cpufreq.c
@@ -110,7 +110,7 @@ static int boost_set_msr(bool enable)
 		return -EINVAL;
 	}
 
-	rdmsrl(msr_addr, val);
+	rdmsrq(msr_addr, val);
 
 	if (enable)
 		val &= ~msr_mask;
diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index 6789eed..2b673ac 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -518,8 +518,8 @@ static inline bool amd_pstate_sample(struct amd_cpudata *cpudata)
 	unsigned long flags;
 
 	local_irq_save(flags);
-	rdmsrl(MSR_IA32_APERF, aperf);
-	rdmsrl(MSR_IA32_MPERF, mperf);
+	rdmsrq(MSR_IA32_APERF, aperf);
+	rdmsrq(MSR_IA32_MPERF, mperf);
 	tsc = rdtsc();
 
 	if (cpudata->prev.mperf == mperf || cpudata->prev.tsc == tsc) {
diff --git a/drivers/cpufreq/e_powersaver.c b/drivers/cpufreq/e_powersaver.c
index d23a97b..6d6afcd 100644
--- a/drivers/cpufreq/e_powersaver.c
+++ b/drivers/cpufreq/e_powersaver.c
@@ -225,12 +225,12 @@ static int eps_cpu_init(struct cpufreq_policy *policy)
 		return -ENODEV;
 	}
 	/* Enable Enhanced PowerSaver */
-	rdmsrl(MSR_IA32_MISC_ENABLE, val);
+	rdmsrq(MSR_IA32_MISC_ENABLE, val);
 	if (!(val & MSR_IA32_MISC_ENABLE_ENHANCED_SPEEDSTEP)) {
 		val |= MSR_IA32_MISC_ENABLE_ENHANCED_SPEEDSTEP;
 		wrmsrl(MSR_IA32_MISC_ENABLE, val);
 		/* Can be locked at 0 */
-		rdmsrl(MSR_IA32_MISC_ENABLE, val);
+		rdmsrq(MSR_IA32_MISC_ENABLE, val);
 		if (!(val & MSR_IA32_MISC_ENABLE_ENHANCED_SPEEDSTEP)) {
 			pr_info("Can't enable Enhanced PowerSaver\n");
 			return -ENODEV;
diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
index 4aad79d..d66a474 100644
--- a/drivers/cpufreq/intel_pstate.c
+++ b/drivers/cpufreq/intel_pstate.c
@@ -598,7 +598,7 @@ static bool turbo_is_disabled(void)
 {
 	u64 misc_en;
 
-	rdmsrl(MSR_IA32_MISC_ENABLE, misc_en);
+	rdmsrq(MSR_IA32_MISC_ENABLE, misc_en);
 
 	return !!(misc_en & MSR_IA32_MISC_ENABLE_TURBO_DISABLE);
 }
@@ -1285,7 +1285,7 @@ static void set_power_ctl_ee_state(bool input)
 	u64 power_ctl;
 
 	mutex_lock(&intel_pstate_driver_lock);
-	rdmsrl(MSR_IA32_POWER_CTL, power_ctl);
+	rdmsrq(MSR_IA32_POWER_CTL, power_ctl);
 	if (input) {
 		power_ctl &= ~BIT(MSR_IA32_POWER_CTL_BIT_EE);
 		power_ctl_ee_state = POWER_CTL_EE_ENABLE;
@@ -1703,7 +1703,7 @@ static ssize_t show_energy_efficiency(struct kobject *kobj, struct kobj_attribut
 	u64 power_ctl;
 	int enable;
 
-	rdmsrl(MSR_IA32_POWER_CTL, power_ctl);
+	rdmsrq(MSR_IA32_POWER_CTL, power_ctl);
 	enable = !!(power_ctl & BIT(MSR_IA32_POWER_CTL_BIT_EE));
 	return sprintf(buf, "%d\n", !enable);
 }
@@ -1990,7 +1990,7 @@ static int atom_get_min_pstate(int not_used)
 {
 	u64 value;
 
-	rdmsrl(MSR_ATOM_CORE_RATIOS, value);
+	rdmsrq(MSR_ATOM_CORE_RATIOS, value);
 	return (value >> 8) & 0x7F;
 }
 
@@ -1998,7 +1998,7 @@ static int atom_get_max_pstate(int not_used)
 {
 	u64 value;
 
-	rdmsrl(MSR_ATOM_CORE_RATIOS, value);
+	rdmsrq(MSR_ATOM_CORE_RATIOS, value);
 	return (value >> 16) & 0x7F;
 }
 
@@ -2006,7 +2006,7 @@ static int atom_get_turbo_pstate(int not_used)
 {
 	u64 value;
 
-	rdmsrl(MSR_ATOM_CORE_TURBO_RATIOS, value);
+	rdmsrq(MSR_ATOM_CORE_TURBO_RATIOS, value);
 	return value & 0x7F;
 }
 
@@ -2041,7 +2041,7 @@ static int silvermont_get_scaling(void)
 	static int silvermont_freq_table[] = {
 		83300, 100000, 133300, 116700, 80000};
 
-	rdmsrl(MSR_FSB_FREQ, value);
+	rdmsrq(MSR_FSB_FREQ, value);
 	i = value & 0x7;
 	WARN_ON(i > 4);
 
@@ -2057,7 +2057,7 @@ static int airmont_get_scaling(void)
 		83300, 100000, 133300, 116700, 80000,
 		93300, 90000, 88900, 87500};
 
-	rdmsrl(MSR_FSB_FREQ, value);
+	rdmsrq(MSR_FSB_FREQ, value);
 	i = value & 0xF;
 	WARN_ON(i > 8);
 
@@ -2068,7 +2068,7 @@ static void atom_get_vid(struct cpudata *cpudata)
 {
 	u64 value;
 
-	rdmsrl(MSR_ATOM_CORE_VIDS, value);
+	rdmsrq(MSR_ATOM_CORE_VIDS, value);
 	cpudata->vid.min = int_tofp((value >> 8) & 0x7f);
 	cpudata->vid.max = int_tofp((value >> 16) & 0x7f);
 	cpudata->vid.ratio = div_fp(
@@ -2076,7 +2076,7 @@ static void atom_get_vid(struct cpudata *cpudata)
 		int_tofp(cpudata->pstate.max_pstate -
 			cpudata->pstate.min_pstate));
 
-	rdmsrl(MSR_ATOM_CORE_TURBO_VIDS, value);
+	rdmsrq(MSR_ATOM_CORE_TURBO_VIDS, value);
 	cpudata->vid.turbo = value & 0x7f;
 }
 
@@ -2425,8 +2425,8 @@ static inline bool intel_pstate_sample(struct cpudata *cpu, u64 time)
 	u64 tsc;
 
 	local_irq_save(flags);
-	rdmsrl(MSR_IA32_APERF, aperf);
-	rdmsrl(MSR_IA32_MPERF, mperf);
+	rdmsrq(MSR_IA32_APERF, aperf);
+	rdmsrq(MSR_IA32_MPERF, mperf);
 	tsc = rdtsc();
 	if (cpu->prev_mperf == mperf || cpu->prev_tsc == tsc) {
 		local_irq_restore(flags);
@@ -3573,7 +3573,7 @@ static bool __init intel_pstate_platform_pwr_mgmt_exists(void)
 
 	id = x86_match_cpu(intel_pstate_cpu_oob_ids);
 	if (id) {
-		rdmsrl(MSR_MISC_PWR_MGMT, misc_pwr);
+		rdmsrq(MSR_MISC_PWR_MGMT, misc_pwr);
 		if (misc_pwr & BITMASK_OOB) {
 			pr_debug("Bit 8 or 18 in the MISC_PWR_MGMT MSR set\n");
 			pr_debug("P states are controlled in Out of Band mode by the firmware/hardware\n");
@@ -3629,7 +3629,7 @@ static bool intel_pstate_hwp_is_enabled(void)
 {
 	u64 value;
 
-	rdmsrl(MSR_PM_ENABLE, value);
+	rdmsrq(MSR_PM_ENABLE, value);
 	return !!(value & 0x1);
 }
 
diff --git a/drivers/cpufreq/longhaul.c b/drivers/cpufreq/longhaul.c
index 68ccd73..d3146f0 100644
--- a/drivers/cpufreq/longhaul.c
+++ b/drivers/cpufreq/longhaul.c
@@ -136,7 +136,7 @@ static void do_longhaul1(unsigned int mults_index)
 {
 	union msr_bcr2 bcr2;
 
-	rdmsrl(MSR_VIA_BCR2, bcr2.val);
+	rdmsrq(MSR_VIA_BCR2, bcr2.val);
 	/* Enable software clock multiplier */
 	bcr2.bits.ESOFTBF = 1;
 	bcr2.bits.CLOCKMUL = mults_index & 0xff;
@@ -151,7 +151,7 @@ static void do_longhaul1(unsigned int mults_index)
 
 	/* Disable software clock multiplier */
 	local_irq_disable();
-	rdmsrl(MSR_VIA_BCR2, bcr2.val);
+	rdmsrq(MSR_VIA_BCR2, bcr2.val);
 	bcr2.bits.ESOFTBF = 0;
 	wrmsrl(MSR_VIA_BCR2, bcr2.val);
 }
@@ -164,7 +164,7 @@ static void do_powersaver(int cx_address, unsigned int mults_index,
 	union msr_longhaul longhaul;
 	u32 t;
 
-	rdmsrl(MSR_VIA_LONGHAUL, longhaul.val);
+	rdmsrq(MSR_VIA_LONGHAUL, longhaul.val);
 	/* Setup new frequency */
 	if (!revid_errata)
 		longhaul.bits.RevisionKey = longhaul.bits.RevisionID;
@@ -534,7 +534,7 @@ static void longhaul_setup_voltagescaling(void)
 	unsigned int j, speed, pos, kHz_step, numvscales;
 	int min_vid_speed;
 
-	rdmsrl(MSR_VIA_LONGHAUL, longhaul.val);
+	rdmsrq(MSR_VIA_LONGHAUL, longhaul.val);
 	if (!(longhaul.bits.RevisionID & 1)) {
 		pr_info("Voltage scaling not supported by CPU\n");
 		return;
diff --git a/drivers/cpufreq/powernow-k7.c b/drivers/cpufreq/powernow-k7.c
index fb2197d..dbbc27c 100644
--- a/drivers/cpufreq/powernow-k7.c
+++ b/drivers/cpufreq/powernow-k7.c
@@ -219,7 +219,7 @@ static void change_FID(int fid)
 {
 	union msr_fidvidctl fidvidctl;
 
-	rdmsrl(MSR_K7_FID_VID_CTL, fidvidctl.val);
+	rdmsrq(MSR_K7_FID_VID_CTL, fidvidctl.val);
 	if (fidvidctl.bits.FID != fid) {
 		fidvidctl.bits.SGTC = latency;
 		fidvidctl.bits.FID = fid;
@@ -234,7 +234,7 @@ static void change_VID(int vid)
 {
 	union msr_fidvidctl fidvidctl;
 
-	rdmsrl(MSR_K7_FID_VID_CTL, fidvidctl.val);
+	rdmsrq(MSR_K7_FID_VID_CTL, fidvidctl.val);
 	if (fidvidctl.bits.VID != vid) {
 		fidvidctl.bits.SGTC = latency;
 		fidvidctl.bits.VID = vid;
@@ -260,7 +260,7 @@ static int powernow_target(struct cpufreq_policy *policy, unsigned int index)
 	fid = powernow_table[index].driver_data & 0xFF;
 	vid = (powernow_table[index].driver_data & 0xFF00) >> 8;
 
-	rdmsrl(MSR_K7_FID_VID_STATUS, fidvidstatus.val);
+	rdmsrq(MSR_K7_FID_VID_STATUS, fidvidstatus.val);
 	cfid = fidvidstatus.bits.CFID;
 	freqs.old = fsb * fid_codes[cfid] / 10;
 
@@ -557,7 +557,7 @@ static unsigned int powernow_get(unsigned int cpu)
 
 	if (cpu)
 		return 0;
-	rdmsrl(MSR_K7_FID_VID_STATUS, fidvidstatus.val);
+	rdmsrq(MSR_K7_FID_VID_STATUS, fidvidstatus.val);
 	cfid = fidvidstatus.bits.CFID;
 
 	return fsb * fid_codes[cfid] / 10;
@@ -598,7 +598,7 @@ static int powernow_cpu_init(struct cpufreq_policy *policy)
 	if (policy->cpu != 0)
 		return -ENODEV;
 
-	rdmsrl(MSR_K7_FID_VID_STATUS, fidvidstatus.val);
+	rdmsrq(MSR_K7_FID_VID_STATUS, fidvidstatus.val);
 
 	recalibrate_cpu_khz();
 
diff --git a/drivers/edac/amd64_edac.c b/drivers/edac/amd64_edac.c
index 90f0eb7..db758aa 100644
--- a/drivers/edac/amd64_edac.c
+++ b/drivers/edac/amd64_edac.c
@@ -2942,13 +2942,13 @@ static void dct_read_mc_regs(struct amd64_pvt *pvt)
 	 * Retrieve TOP_MEM and TOP_MEM2; no masking off of reserved bits since
 	 * those are Read-As-Zero.
 	 */
-	rdmsrl(MSR_K8_TOP_MEM1, pvt->top_mem);
+	rdmsrq(MSR_K8_TOP_MEM1, pvt->top_mem);
 	edac_dbg(0, "  TOP_MEM:  0x%016llx\n", pvt->top_mem);
 
 	/* Check first whether TOP_MEM2 is enabled: */
-	rdmsrl(MSR_AMD64_SYSCFG, msr_val);
+	rdmsrq(MSR_AMD64_SYSCFG, msr_val);
 	if (msr_val & BIT(21)) {
-		rdmsrl(MSR_K8_TOP_MEM2, pvt->top_mem2);
+		rdmsrq(MSR_K8_TOP_MEM2, pvt->top_mem2);
 		edac_dbg(0, "  TOP_MEM2: 0x%016llx\n", pvt->top_mem2);
 	} else {
 		edac_dbg(0, "  TOP_MEM2 disabled\n");
diff --git a/drivers/idle/intel_idle.c b/drivers/idle/intel_idle.c
index 976f5be..6e4b5b3 100644
--- a/drivers/idle/intel_idle.c
+++ b/drivers/idle/intel_idle.c
@@ -1928,35 +1928,35 @@ static void __init bxt_idle_state_table_update(void)
 	unsigned long long msr;
 	unsigned int usec;
 
-	rdmsrl(MSR_PKGC6_IRTL, msr);
+	rdmsrq(MSR_PKGC6_IRTL, msr);
 	usec = irtl_2_usec(msr);
 	if (usec) {
 		bxt_cstates[2].exit_latency = usec;
 		bxt_cstates[2].target_residency = usec;
 	}
 
-	rdmsrl(MSR_PKGC7_IRTL, msr);
+	rdmsrq(MSR_PKGC7_IRTL, msr);
 	usec = irtl_2_usec(msr);
 	if (usec) {
 		bxt_cstates[3].exit_latency = usec;
 		bxt_cstates[3].target_residency = usec;
 	}
 
-	rdmsrl(MSR_PKGC8_IRTL, msr);
+	rdmsrq(MSR_PKGC8_IRTL, msr);
 	usec = irtl_2_usec(msr);
 	if (usec) {
 		bxt_cstates[4].exit_latency = usec;
 		bxt_cstates[4].target_residency = usec;
 	}
 
-	rdmsrl(MSR_PKGC9_IRTL, msr);
+	rdmsrq(MSR_PKGC9_IRTL, msr);
 	usec = irtl_2_usec(msr);
 	if (usec) {
 		bxt_cstates[5].exit_latency = usec;
 		bxt_cstates[5].target_residency = usec;
 	}
 
-	rdmsrl(MSR_PKGC10_IRTL, msr);
+	rdmsrq(MSR_PKGC10_IRTL, msr);
 	usec = irtl_2_usec(msr);
 	if (usec) {
 		bxt_cstates[6].exit_latency = usec;
@@ -1984,7 +1984,7 @@ static void __init sklh_idle_state_table_update(void)
 	if ((mwait_substates & (0xF << 28)) == 0)
 		return;
 
-	rdmsrl(MSR_PKG_CST_CONFIG_CONTROL, msr);
+	rdmsrq(MSR_PKG_CST_CONFIG_CONTROL, msr);
 
 	/* PC10 is not enabled in PKG C-state limit */
 	if ((msr & 0xF) != 8)
@@ -1996,7 +1996,7 @@ static void __init sklh_idle_state_table_update(void)
 	/* if SGX is present */
 	if (ebx & (1 << 2)) {
 
-		rdmsrl(MSR_IA32_FEAT_CTL, msr);
+		rdmsrq(MSR_IA32_FEAT_CTL, msr);
 
 		/* if SGX is enabled */
 		if (msr & (1 << 18))
@@ -2015,7 +2015,7 @@ static void __init skx_idle_state_table_update(void)
 {
 	unsigned long long msr;
 
-	rdmsrl(MSR_PKG_CST_CONFIG_CONTROL, msr);
+	rdmsrq(MSR_PKG_CST_CONFIG_CONTROL, msr);
 
 	/*
 	 * 000b: C0/C1 (no package C-state support)
@@ -2068,7 +2068,7 @@ static void __init spr_idle_state_table_update(void)
 	 * C6. However, if PC6 is disabled, we update the numbers to match
 	 * core C6.
 	 */
-	rdmsrl(MSR_PKG_CST_CONFIG_CONTROL, msr);
+	rdmsrq(MSR_PKG_CST_CONFIG_CONTROL, msr);
 
 	/* Limit value 2 and above allow for PC6. */
 	if ((msr & 0x7) < 2) {
@@ -2241,7 +2241,7 @@ static void auto_demotion_disable(void)
 {
 	unsigned long long msr_bits;
 
-	rdmsrl(MSR_PKG_CST_CONFIG_CONTROL, msr_bits);
+	rdmsrq(MSR_PKG_CST_CONFIG_CONTROL, msr_bits);
 	msr_bits &= ~auto_demotion_disable_flags;
 	wrmsrl(MSR_PKG_CST_CONFIG_CONTROL, msr_bits);
 }
@@ -2250,7 +2250,7 @@ static void c1e_promotion_enable(void)
 {
 	unsigned long long msr_bits;
 
-	rdmsrl(MSR_IA32_POWER_CTL, msr_bits);
+	rdmsrq(MSR_IA32_POWER_CTL, msr_bits);
 	msr_bits |= 0x2;
 	wrmsrl(MSR_IA32_POWER_CTL, msr_bits);
 }
@@ -2259,7 +2259,7 @@ static void c1e_promotion_disable(void)
 {
 	unsigned long long msr_bits;
 
-	rdmsrl(MSR_IA32_POWER_CTL, msr_bits);
+	rdmsrq(MSR_IA32_POWER_CTL, msr_bits);
 	msr_bits &= ~0x2;
 	wrmsrl(MSR_IA32_POWER_CTL, msr_bits);
 }
diff --git a/drivers/mtd/nand/raw/cs553x_nand.c b/drivers/mtd/nand/raw/cs553x_nand.c
index 3413180..ec95d78 100644
--- a/drivers/mtd/nand/raw/cs553x_nand.c
+++ b/drivers/mtd/nand/raw/cs553x_nand.c
@@ -351,20 +351,20 @@ static int __init cs553x_init(void)
 		return -ENXIO;
 
 	/* If it doesn't have the CS553[56], abort */
-	rdmsrl(MSR_DIVIL_GLD_CAP, val);
+	rdmsrq(MSR_DIVIL_GLD_CAP, val);
 	val &= ~0xFFULL;
 	if (val != CAP_CS5535 && val != CAP_CS5536)
 		return -ENXIO;
 
 	/* If it doesn't have the NAND controller enabled, abort */
-	rdmsrl(MSR_DIVIL_BALL_OPTS, val);
+	rdmsrq(MSR_DIVIL_BALL_OPTS, val);
 	if (val & PIN_OPT_IDE) {
 		pr_info("CS553x NAND controller: Flash I/O not enabled in MSR_DIVIL_BALL_OPTS.\n");
 		return -ENXIO;
 	}
 
 	for (i = 0; i < NR_CS553X_CONTROLLERS; i++) {
-		rdmsrl(MSR_DIVIL_LBAR_FLSH0 + i, val);
+		rdmsrq(MSR_DIVIL_LBAR_FLSH0 + i, val);
 
 		if ((val & (FLSH_LBAR_EN|FLSH_NOR_NAND)) == (FLSH_LBAR_EN|FLSH_NOR_NAND))
 			err = cs553x_init_one(i, !!(val & FLSH_MEM_IO), val & 0xFFFFFFFF);
diff --git a/drivers/platform/x86/intel/ifs/load.c b/drivers/platform/x86/intel/ifs/load.c
index de54bd1..d3e4866 100644
--- a/drivers/platform/x86/intel/ifs/load.c
+++ b/drivers/platform/x86/intel/ifs/load.c
@@ -128,7 +128,7 @@ static void copy_hashes_authenticate_chunks(struct work_struct *work)
 	msrs = ifs_get_test_msrs(dev);
 	/* run scan hash copy */
 	wrmsrl(msrs->copy_hashes, ifs_hash_ptr);
-	rdmsrl(msrs->copy_hashes_status, hashes_status.data);
+	rdmsrq(msrs->copy_hashes_status, hashes_status.data);
 
 	/* enumerate the scan image information */
 	num_chunks = hashes_status.num_chunks;
@@ -150,7 +150,7 @@ static void copy_hashes_authenticate_chunks(struct work_struct *work)
 		linear_addr |= i;
 
 		wrmsrl(msrs->copy_chunks, linear_addr);
-		rdmsrl(msrs->copy_chunks_status, chunk_status.data);
+		rdmsrq(msrs->copy_chunks_status, chunk_status.data);
 
 		ifsd->valid_chunks = chunk_status.valid_chunks;
 		err_code = chunk_status.error_code;
@@ -196,7 +196,7 @@ static int copy_hashes_authenticate_chunks_gen2(struct device *dev)
 
 	if (need_copy_scan_hashes(ifsd)) {
 		wrmsrl(msrs->copy_hashes, ifs_hash_ptr);
-		rdmsrl(msrs->copy_hashes_status, hashes_status.data);
+		rdmsrq(msrs->copy_hashes_status, hashes_status.data);
 
 		/* enumerate the scan image information */
 		chunk_size = hashes_status.chunk_size * SZ_1K;
@@ -217,7 +217,7 @@ static int copy_hashes_authenticate_chunks_gen2(struct device *dev)
 
 	if (ifsd->generation >= IFS_GEN_STRIDE_AWARE) {
 		wrmsrl(msrs->test_ctrl, INVALIDATE_STRIDE);
-		rdmsrl(msrs->copy_chunks_status, chunk_status.data);
+		rdmsrq(msrs->copy_chunks_status, chunk_status.data);
 		if (chunk_status.valid_chunks != 0) {
 			dev_err(dev, "Couldn't invalidate installed stride - %d\n",
 				chunk_status.valid_chunks);
@@ -240,7 +240,7 @@ static int copy_hashes_authenticate_chunks_gen2(struct device *dev)
 			local_irq_disable();
 			wrmsrl(msrs->copy_chunks, (u64)chunk_table);
 			local_irq_enable();
-			rdmsrl(msrs->copy_chunks_status, chunk_status.data);
+			rdmsrq(msrs->copy_chunks_status, chunk_status.data);
 			err_code = chunk_status.error_code;
 		} while (err_code == AUTH_INTERRUPTED_ERROR && --retry_count);
 
diff --git a/drivers/platform/x86/intel/ifs/runtest.c b/drivers/platform/x86/intel/ifs/runtest.c
index f978dd0..8e66954 100644
--- a/drivers/platform/x86/intel/ifs/runtest.c
+++ b/drivers/platform/x86/intel/ifs/runtest.c
@@ -210,7 +210,7 @@ static int doscan(void *data)
 	 * are processed in a single pass) before it retires.
 	 */
 	wrmsrl(MSR_ACTIVATE_SCAN, params->activate->data);
-	rdmsrl(MSR_SCAN_STATUS, status.data);
+	rdmsrq(MSR_SCAN_STATUS, status.data);
 
 	trace_ifs_status(ifsd->cur_batch, start, stop, status.data);
 
@@ -323,7 +323,7 @@ static int do_array_test(void *data)
 	if (cpu == first) {
 		wrmsrl(MSR_ARRAY_BIST, command->data);
 		/* Pass back the result of the test */
-		rdmsrl(MSR_ARRAY_BIST, command->data);
+		rdmsrq(MSR_ARRAY_BIST, command->data);
 	}
 
 	return 0;
@@ -375,7 +375,7 @@ static int do_array_test_gen1(void *status)
 
 	if (cpu == first) {
 		wrmsrl(MSR_ARRAY_TRIGGER, ARRAY_GEN1_TEST_ALL_ARRAYS);
-		rdmsrl(MSR_ARRAY_STATUS, *((u64 *)status));
+		rdmsrq(MSR_ARRAY_STATUS, *((u64 *)status));
 	}
 
 	return 0;
@@ -527,7 +527,7 @@ static int dosbaf(void *data)
 	 * during the "execution" of the WRMSR.
 	 */
 	wrmsrl(MSR_ACTIVATE_SBAF, run_params->activate->data);
-	rdmsrl(MSR_SBAF_STATUS, status.data);
+	rdmsrq(MSR_SBAF_STATUS, status.data);
 	trace_ifs_sbaf(ifsd->cur_batch, *run_params->activate, status);
 
 	/* Pass back the result of the test */
diff --git a/drivers/platform/x86/intel/pmc/cnp.c b/drivers/platform/x86/intel/pmc/cnp.c
index 2c5af15..aa9aa1c 100644
--- a/drivers/platform/x86/intel/pmc/cnp.c
+++ b/drivers/platform/x86/intel/pmc/cnp.c
@@ -227,7 +227,7 @@ static void disable_c1_auto_demote(void *unused)
 	int cpunum = smp_processor_id();
 	u64 val;
 
-	rdmsrl(MSR_PKG_CST_CONFIG_CONTROL, val);
+	rdmsrq(MSR_PKG_CST_CONFIG_CONTROL, val);
 	per_cpu(pkg_cst_config, cpunum) = val;
 	val &= ~NHM_C1_AUTO_DEMOTE;
 	wrmsrl(MSR_PKG_CST_CONFIG_CONTROL, val);
diff --git a/drivers/platform/x86/intel/speed_select_if/isst_if_mbox_msr.c b/drivers/platform/x86/intel/speed_select_if/isst_if_mbox_msr.c
index c4b7af0..20624fc 100644
--- a/drivers/platform/x86/intel/speed_select_if/isst_if_mbox_msr.c
+++ b/drivers/platform/x86/intel/speed_select_if/isst_if_mbox_msr.c
@@ -39,7 +39,7 @@ static int isst_if_send_mbox_cmd(u8 command, u8 sub_command, u32 parameter,
 	/* Poll for rb bit == 0 */
 	retries = OS_MAILBOX_RETRY_COUNT;
 	do {
-		rdmsrl(MSR_OS_MAILBOX_INTERFACE, data);
+		rdmsrq(MSR_OS_MAILBOX_INTERFACE, data);
 		if (data & BIT_ULL(MSR_OS_MAILBOX_BUSY_BIT)) {
 			ret = -EBUSY;
 			continue;
@@ -64,7 +64,7 @@ static int isst_if_send_mbox_cmd(u8 command, u8 sub_command, u32 parameter,
 	/* Poll for rb bit == 0 */
 	retries = OS_MAILBOX_RETRY_COUNT;
 	do {
-		rdmsrl(MSR_OS_MAILBOX_INTERFACE, data);
+		rdmsrq(MSR_OS_MAILBOX_INTERFACE, data);
 		if (data & BIT_ULL(MSR_OS_MAILBOX_BUSY_BIT)) {
 			ret = -EBUSY;
 			continue;
@@ -74,7 +74,7 @@ static int isst_if_send_mbox_cmd(u8 command, u8 sub_command, u32 parameter,
 			return -ENXIO;
 
 		if (response_data) {
-			rdmsrl(MSR_OS_MAILBOX_DATA, data);
+			rdmsrq(MSR_OS_MAILBOX_DATA, data);
 			*response_data = data;
 		}
 		ret = 0;
diff --git a/drivers/platform/x86/intel/speed_select_if/isst_tpmi_core.c b/drivers/platform/x86/intel/speed_select_if/isst_tpmi_core.c
index 9978cdd..0b8ef0c 100644
--- a/drivers/platform/x86/intel/speed_select_if/isst_tpmi_core.c
+++ b/drivers/platform/x86/intel/speed_select_if/isst_tpmi_core.c
@@ -556,7 +556,7 @@ static bool disable_dynamic_sst_features(void)
 {
 	u64 value;
 
-	rdmsrl(MSR_PM_ENABLE, value);
+	rdmsrq(MSR_PM_ENABLE, value);
 	return !(value & 0x1);
 }
 
diff --git a/drivers/platform/x86/intel_ips.c b/drivers/platform/x86/intel_ips.c
index 5d717b1..74b2a87 100644
--- a/drivers/platform/x86/intel_ips.c
+++ b/drivers/platform/x86/intel_ips.c
@@ -370,7 +370,7 @@ static void ips_cpu_raise(struct ips_driver *ips)
 	if (!ips->cpu_turbo_enabled)
 		return;
 
-	rdmsrl(TURBO_POWER_CURRENT_LIMIT, turbo_override);
+	rdmsrq(TURBO_POWER_CURRENT_LIMIT, turbo_override);
 
 	cur_tdp_limit = turbo_override & TURBO_TDP_MASK;
 	new_tdp_limit = cur_tdp_limit + 8; /* 1W increase */
@@ -405,7 +405,7 @@ static void ips_cpu_lower(struct ips_driver *ips)
 	u64 turbo_override;
 	u16 cur_limit, new_limit;
 
-	rdmsrl(TURBO_POWER_CURRENT_LIMIT, turbo_override);
+	rdmsrq(TURBO_POWER_CURRENT_LIMIT, turbo_override);
 
 	cur_limit = turbo_override & TURBO_TDP_MASK;
 	new_limit = cur_limit - 8; /* 1W decrease */
@@ -437,7 +437,7 @@ static void do_enable_cpu_turbo(void *data)
 {
 	u64 perf_ctl;
 
-	rdmsrl(IA32_PERF_CTL, perf_ctl);
+	rdmsrq(IA32_PERF_CTL, perf_ctl);
 	if (perf_ctl & IA32_PERF_TURBO_DIS) {
 		perf_ctl &= ~IA32_PERF_TURBO_DIS;
 		wrmsrl(IA32_PERF_CTL, perf_ctl);
@@ -475,7 +475,7 @@ static void do_disable_cpu_turbo(void *data)
 {
 	u64 perf_ctl;
 
-	rdmsrl(IA32_PERF_CTL, perf_ctl);
+	rdmsrq(IA32_PERF_CTL, perf_ctl);
 	if (!(perf_ctl & IA32_PERF_TURBO_DIS)) {
 		perf_ctl |= IA32_PERF_TURBO_DIS;
 		wrmsrl(IA32_PERF_CTL, perf_ctl);
@@ -1215,7 +1215,7 @@ static int cpu_clamp_show(struct seq_file *m, void *data)
 	u64 turbo_override;
 	int tdp, tdc;
 
-	rdmsrl(TURBO_POWER_CURRENT_LIMIT, turbo_override);
+	rdmsrq(TURBO_POWER_CURRENT_LIMIT, turbo_override);
 
 	tdp = (int)(turbo_override & TURBO_TDP_MASK);
 	tdc = (int)((turbo_override & TURBO_TDC_MASK) >> TURBO_TDC_SHIFT);
@@ -1290,7 +1290,7 @@ static struct ips_mcp_limits *ips_detect_cpu(struct ips_driver *ips)
 		return NULL;
 	}
 
-	rdmsrl(IA32_MISC_ENABLE, misc_en);
+	rdmsrq(IA32_MISC_ENABLE, misc_en);
 	/*
 	 * If the turbo enable bit isn't set, we shouldn't try to enable/disable
 	 * turbo manually or we'll get an illegal MSR access, even though
@@ -1312,7 +1312,7 @@ static struct ips_mcp_limits *ips_detect_cpu(struct ips_driver *ips)
 		return NULL;
 	}
 
-	rdmsrl(TURBO_POWER_CURRENT_LIMIT, turbo_power);
+	rdmsrq(TURBO_POWER_CURRENT_LIMIT, turbo_power);
 	tdp = turbo_power & TURBO_TDP_MASK;
 
 	/* Sanity check TDP against CPU */
@@ -1496,7 +1496,7 @@ static int ips_probe(struct pci_dev *dev, const struct pci_device_id *id)
 	 * Check PLATFORM_INFO MSR to make sure this chip is
 	 * turbo capable.
 	 */
-	rdmsrl(PLATFORM_INFO, platform_info);
+	rdmsrq(PLATFORM_INFO, platform_info);
 	if (!(platform_info & PLATFORM_TDP)) {
 		dev_err(&dev->dev, "platform indicates TDP override unavailable, aborting\n");
 		return -ENODEV;
@@ -1529,7 +1529,7 @@ static int ips_probe(struct pci_dev *dev, const struct pci_device_id *id)
 	ips->mgta_val = thm_readw(THM_MGTA);
 
 	/* Save turbo limits & ratios */
-	rdmsrl(TURBO_POWER_CURRENT_LIMIT, ips->orig_turbo_limit);
+	rdmsrq(TURBO_POWER_CURRENT_LIMIT, ips->orig_turbo_limit);
 
 	ips_disable_cpu_turbo(ips);
 	ips->cpu_turbo_enabled = false;
@@ -1596,7 +1596,7 @@ static void ips_remove(struct pci_dev *dev)
 	if (ips->gpu_turbo_disable)
 		symbol_put(i915_gpu_turbo_disable);
 
-	rdmsrl(TURBO_POWER_CURRENT_LIMIT, turbo_override);
+	rdmsrq(TURBO_POWER_CURRENT_LIMIT, turbo_override);
 	turbo_override &= ~(TURBO_TDC_OVR_EN | TURBO_TDP_OVR_EN);
 	wrmsrl(TURBO_POWER_CURRENT_LIMIT, turbo_override);
 	wrmsrl(TURBO_POWER_CURRENT_LIMIT, ips->orig_turbo_limit);
diff --git a/drivers/thermal/intel/intel_hfi.c b/drivers/thermal/intel/intel_hfi.c
index 5b18a46..2aaac15 100644
--- a/drivers/thermal/intel/intel_hfi.c
+++ b/drivers/thermal/intel/intel_hfi.c
@@ -284,7 +284,7 @@ void intel_hfi_process_event(__u64 pkg_therm_status_msr_val)
 	if (!raw_spin_trylock(&hfi_instance->event_lock))
 		return;
 
-	rdmsrl(MSR_IA32_PACKAGE_THERM_STATUS, msr);
+	rdmsrq(MSR_IA32_PACKAGE_THERM_STATUS, msr);
 	hfi = msr & PACKAGE_THERM_STATUS_HFI_UPDATED;
 	if (!hfi) {
 		raw_spin_unlock(&hfi_instance->event_lock);
@@ -356,7 +356,7 @@ static void hfi_enable(void)
 {
 	u64 msr_val;
 
-	rdmsrl(MSR_IA32_HW_FEEDBACK_CONFIG, msr_val);
+	rdmsrq(MSR_IA32_HW_FEEDBACK_CONFIG, msr_val);
 	msr_val |= HW_FEEDBACK_CONFIG_HFI_ENABLE_BIT;
 	wrmsrl(MSR_IA32_HW_FEEDBACK_CONFIG, msr_val);
 }
@@ -377,7 +377,7 @@ static void hfi_disable(void)
 	u64 msr_val;
 	int i;
 
-	rdmsrl(MSR_IA32_HW_FEEDBACK_CONFIG, msr_val);
+	rdmsrq(MSR_IA32_HW_FEEDBACK_CONFIG, msr_val);
 	msr_val &= ~HW_FEEDBACK_CONFIG_HFI_ENABLE_BIT;
 	wrmsrl(MSR_IA32_HW_FEEDBACK_CONFIG, msr_val);
 
@@ -388,7 +388,7 @@ static void hfi_disable(void)
 	 * memory.
 	 */
 	for (i = 0; i < 2000; i++) {
-		rdmsrl(MSR_IA32_PACKAGE_THERM_STATUS, msr_val);
+		rdmsrq(MSR_IA32_PACKAGE_THERM_STATUS, msr_val);
 		if (msr_val & PACKAGE_THERM_STATUS_HFI_UPDATED)
 			break;
 
diff --git a/drivers/thermal/intel/therm_throt.c b/drivers/thermal/intel/therm_throt.c
index e69868e..f296f35 100644
--- a/drivers/thermal/intel/therm_throt.c
+++ b/drivers/thermal/intel/therm_throt.c
@@ -287,7 +287,7 @@ static void get_therm_status(int level, bool *proc_hot, u8 *temp)
 	else
 		msr = MSR_IA32_PACKAGE_THERM_STATUS;
 
-	rdmsrl(msr, msr_val);
+	rdmsrq(msr, msr_val);
 	if (msr_val & THERM_STATUS_PROCHOT_LOG)
 		*proc_hot = true;
 	else
@@ -654,7 +654,7 @@ void intel_thermal_interrupt(void)
 	if (static_cpu_has(X86_FEATURE_HWP))
 		notify_hwp_interrupt();
 
-	rdmsrl(MSR_IA32_THERM_STATUS, msr_val);
+	rdmsrq(MSR_IA32_THERM_STATUS, msr_val);
 
 	/* Check for violation of core thermal thresholds*/
 	notify_thresholds(msr_val);
@@ -669,7 +669,7 @@ void intel_thermal_interrupt(void)
 					CORE_LEVEL);
 
 	if (this_cpu_has(X86_FEATURE_PTS)) {
-		rdmsrl(MSR_IA32_PACKAGE_THERM_STATUS, msr_val);
+		rdmsrq(MSR_IA32_PACKAGE_THERM_STATUS, msr_val);
 		/* check violations of package thermal thresholds */
 		notify_package_thresholds(msr_val);
 		therm_throt_process(msr_val & PACKAGE_THERM_STATUS_PROCHOT,
diff --git a/drivers/video/fbdev/geode/gxfb_core.c b/drivers/video/fbdev/geode/gxfb_core.c
index af99663..2b27d65 100644
--- a/drivers/video/fbdev/geode/gxfb_core.c
+++ b/drivers/video/fbdev/geode/gxfb_core.c
@@ -377,7 +377,7 @@ static int gxfb_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 
 	/* Figure out if this is a TFT or CRT part */
 
-	rdmsrl(MSR_GX_GLD_MSR_CONFIG, val);
+	rdmsrq(MSR_GX_GLD_MSR_CONFIG, val);
 
 	if ((val & MSR_GX_GLD_MSR_CONFIG_FP) == MSR_GX_GLD_MSR_CONFIG_FP)
 		par->enable_crt = 0;
diff --git a/drivers/video/fbdev/geode/lxfb_ops.c b/drivers/video/fbdev/geode/lxfb_ops.c
index 32baaf5..5402c00 100644
--- a/drivers/video/fbdev/geode/lxfb_ops.c
+++ b/drivers/video/fbdev/geode/lxfb_ops.c
@@ -358,7 +358,7 @@ void lx_set_mode(struct fb_info *info)
 
 	/* Set output mode */
 
-	rdmsrl(MSR_LX_GLD_MSR_CONFIG, msrval);
+	rdmsrq(MSR_LX_GLD_MSR_CONFIG, msrval);
 	msrval &= ~MSR_LX_GLD_MSR_CONFIG_FMT;
 
 	if (par->output & OUTPUT_PANEL) {
@@ -419,7 +419,7 @@ void lx_set_mode(struct fb_info *info)
 
 	/* Set default watermark values */
 
-	rdmsrl(MSR_LX_SPARE_MSR, msrval);
+	rdmsrq(MSR_LX_SPARE_MSR, msrval);
 
 	msrval &= ~(MSR_LX_SPARE_MSR_DIS_CFIFO_HGO
 			| MSR_LX_SPARE_MSR_VFIFO_ARB_SEL
@@ -591,10 +591,10 @@ static void lx_save_regs(struct lxfb_par *par)
 	} while ((i & GP_BLT_STATUS_PB) || !(i & GP_BLT_STATUS_CE));
 
 	/* save MSRs */
-	rdmsrl(MSR_LX_MSR_PADSEL, par->msr.padsel);
-	rdmsrl(MSR_GLCP_DOTPLL, par->msr.dotpll);
-	rdmsrl(MSR_LX_GLD_MSR_CONFIG, par->msr.dfglcfg);
-	rdmsrl(MSR_LX_SPARE_MSR, par->msr.dcspare);
+	rdmsrq(MSR_LX_MSR_PADSEL, par->msr.padsel);
+	rdmsrq(MSR_GLCP_DOTPLL, par->msr.dotpll);
+	rdmsrq(MSR_LX_GLD_MSR_CONFIG, par->msr.dfglcfg);
+	rdmsrq(MSR_LX_SPARE_MSR, par->msr.dcspare);
 
 	write_dc(par, DC_UNLOCK, DC_UNLOCK_UNLOCK);
 
diff --git a/drivers/video/fbdev/geode/suspend_gx.c b/drivers/video/fbdev/geode/suspend_gx.c
index 8c49d4e..ed49977 100644
--- a/drivers/video/fbdev/geode/suspend_gx.c
+++ b/drivers/video/fbdev/geode/suspend_gx.c
@@ -21,8 +21,8 @@ static void gx_save_regs(struct gxfb_par *par)
 	} while (i & (GP_BLT_STATUS_BLT_PENDING | GP_BLT_STATUS_BLT_BUSY));
 
 	/* save MSRs */
-	rdmsrl(MSR_GX_MSR_PADSEL, par->msr.padsel);
-	rdmsrl(MSR_GLCP_DOTPLL, par->msr.dotpll);
+	rdmsrq(MSR_GX_MSR_PADSEL, par->msr.padsel);
+	rdmsrq(MSR_GLCP_DOTPLL, par->msr.dotpll);
 
 	write_dc(par, DC_UNLOCK, DC_UNLOCK_UNLOCK);
 
@@ -43,14 +43,14 @@ static void gx_set_dotpll(uint32_t dotpll_hi)
 	uint32_t dotpll_lo;
 	int i;
 
-	rdmsrl(MSR_GLCP_DOTPLL, dotpll_lo);
+	rdmsrq(MSR_GLCP_DOTPLL, dotpll_lo);
 	dotpll_lo |= MSR_GLCP_DOTPLL_DOTRESET;
 	dotpll_lo &= ~MSR_GLCP_DOTPLL_BYPASS;
 	wrmsr(MSR_GLCP_DOTPLL, dotpll_lo, dotpll_hi);
 
 	/* wait for the PLL to lock */
 	for (i = 0; i < 200; i++) {
-		rdmsrl(MSR_GLCP_DOTPLL, dotpll_lo);
+		rdmsrq(MSR_GLCP_DOTPLL, dotpll_lo);
 		if (dotpll_lo & MSR_GLCP_DOTPLL_LOCK)
 			break;
 		udelay(1);
diff --git a/drivers/video/fbdev/geode/video_gx.c b/drivers/video/fbdev/geode/video_gx.c
index 91dac2a..9bee017 100644
--- a/drivers/video/fbdev/geode/video_gx.c
+++ b/drivers/video/fbdev/geode/video_gx.c
@@ -142,8 +142,8 @@ void gx_set_dclk_frequency(struct fb_info *info)
 		}
 	}
 
-	rdmsrl(MSR_GLCP_SYS_RSTPLL, sys_rstpll);
-	rdmsrl(MSR_GLCP_DOTPLL, dotpll);
+	rdmsrq(MSR_GLCP_SYS_RSTPLL, sys_rstpll);
+	rdmsrq(MSR_GLCP_DOTPLL, dotpll);
 
 	/* Program new M, N and P. */
 	dotpll &= 0x00000000ffffffffull;
@@ -167,7 +167,7 @@ void gx_set_dclk_frequency(struct fb_info *info)
 
 	/* Wait for LOCK bit. */
 	do {
-		rdmsrl(MSR_GLCP_DOTPLL, dotpll);
+		rdmsrq(MSR_GLCP_DOTPLL, dotpll);
 	} while (timeout-- && !(dotpll & MSR_GLCP_DOTPLL_LOCK));
 }
 
@@ -180,7 +180,7 @@ gx_configure_tft(struct fb_info *info)
 
 	/* Set up the DF pad select MSR */
 
-	rdmsrl(MSR_GX_MSR_PADSEL, val);
+	rdmsrq(MSR_GX_MSR_PADSEL, val);
 	val &= ~MSR_GX_MSR_PADSEL_MASK;
 	val |= MSR_GX_MSR_PADSEL_TFT;
 	wrmsrl(MSR_GX_MSR_PADSEL, val);
diff --git a/include/hyperv/hvgdk_mini.h b/include/hyperv/hvgdk_mini.h
index abf0bd7..5369975 100644
--- a/include/hyperv/hvgdk_mini.h
+++ b/include/hyperv/hvgdk_mini.h
@@ -1013,7 +1013,7 @@ enum hv_register_name {
 
 /*
  * To support arch-generic code calling hv_set/get_register:
- * - On x86, HV_MSR_ indicates an MSR accessed via rdmsrl/wrmsrl
+ * - On x86, HV_MSR_ indicates an MSR accessed via rdmsrq/wrmsrl
  * - On ARM, HV_MSR_ indicates a VP register accessed via hypercall
  */
 #define HV_MSR_CRASH_P0		(HV_X64_MSR_CRASH_P0)

