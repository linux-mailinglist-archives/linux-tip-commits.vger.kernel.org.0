Return-Path: <linux-tip-commits+bounces-4932-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EFC79A87341
	for <lists+linux-tip-commits@lfdr.de>; Sun, 13 Apr 2025 20:57:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 60EEE7A7467
	for <lists+linux-tip-commits@lfdr.de>; Sun, 13 Apr 2025 18:56:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 533D11F473A;
	Sun, 13 Apr 2025 18:56:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="iyeozTVv";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ZvNWU4eI"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FC3D1F428C;
	Sun, 13 Apr 2025 18:56:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744570579; cv=none; b=goItJ4LZkdnaBSai2szuxUk3tc1SHrC/K6Ls3SlES76j0y96PttsTNXPaZrW9JHoAxHG7l4aJfQ8jA468Ngap0qfEjSI9JjvHG4s6VHJs+oMLhRjmzXNVIy69HTMbvcFpBQnLaoUNwp5GVQXDRrTLpVTEMHieqHn8oZtD2ZAHYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744570579; c=relaxed/simple;
	bh=lEvfpsgb4PNN3kcCbfPX7UtAaa62Ua1qzxu9OozzNmM=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=Rs815Ut9OXkhYsQRSOPYaIS0yXZcry85RCFKDGQSG3gfFcN9RxaKCPzXI81OncgQtqZ6hLxMkfqwyqQ04Zbmo55Ak3GqIt5JeSwNNOw6i69W+E5Yev9Q08LaVt2Rcg7H7ewn/m5MWM8ZgFrEUjspUHJc53p89j7OM+mpDK4ZJ30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=iyeozTVv; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ZvNWU4eI; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sun, 13 Apr 2025 18:56:14 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1744570575;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=l1Us8+ccwToocTAlSS8LL6/Pk/eADNOSMdtwKPpoDjQ=;
	b=iyeozTVv/0UXihTXzvAGd5BqHLLH795uMJ+5ujERBdma+Qb4Q5dan1r6d3u4Duo3417Cd6
	e0Aj7OFshvtq23OTDG9azvWqu9rMsSdxn8XJxwH0ZfZISgRth64Z4iB1yhwzj40W+2GuTL
	9cvvIYfKN6fnitd8j/ZpDsMZTVGzbrF7UhygNmk15eQgP8rQ47BwKQrxIc8vPG6UZ0PKPi
	HGGcJecm+HrprR1jml06Gm+Nwij89KmzcJWJ656Mhb7PMP1y1or5AhqGiW/lfO5Zgw1fwP
	3JJUc1Z0SzkXXpmbSMLNZ1kXjwISEHCdq1ThsQi2tywx29+bJK/L1qwF7Hu1Sg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1744570575;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=l1Us8+ccwToocTAlSS8LL6/Pk/eADNOSMdtwKPpoDjQ=;
	b=ZvNWU4eIqVN6FXeA+Tbe66NzuRmcQqrXau/rYio6jyr+Nw/FCXtRm8OKKilwY+uQ5jJpIS
	0UTgzjUwjmRMz2CA==
From: "tip-bot2 for Ingo Molnar" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/msr] x86/msr: Rename 'wrmsrl_on_cpu()' to 'wrmsrq_on_cpu()'
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
Message-ID: <174457057455.31282.468558188319488730.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/msr branch of tip:

Commit-ID:     c895ecdab2e4ded78a362721c5a63053060030c9
Gitweb:        https://git.kernel.org/tip/c895ecdab2e4ded78a362721c5a63053060030c9
Author:        Ingo Molnar <mingo@kernel.org>
AuthorDate:    Wed, 09 Apr 2025 22:29:01 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Thu, 10 Apr 2025 11:59:05 +02:00

x86/msr: Rename 'wrmsrl_on_cpu()' to 'wrmsrq_on_cpu()'

Suggested-by: "H. Peter Anvin" <hpa@zytor.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Juergen Gross <jgross@suse.com>
Cc: Dave Hansen <dave.hansen@intel.com>
Cc: Xin Li <xin@zytor.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
---
 arch/x86/include/asm/msr.h                                     |  4 +-
 arch/x86/kernel/cpu/intel_epb.c                                |  2 +-
 arch/x86/lib/msr-smp.c                                         |  4 +-
 drivers/cpufreq/amd-pstate.c                                   |  6 +-
 drivers/cpufreq/intel_pstate.c                                 | 34 +++----
 drivers/platform/x86/intel/uncore-frequency/uncore-frequency.c |  4 +-
 6 files changed, 27 insertions(+), 27 deletions(-)

diff --git a/arch/x86/include/asm/msr.h b/arch/x86/include/asm/msr.h
index 850793b..4335f91 100644
--- a/arch/x86/include/asm/msr.h
+++ b/arch/x86/include/asm/msr.h
@@ -330,7 +330,7 @@ int msr_clear_bit(u32 msr, u8 bit);
 int rdmsr_on_cpu(unsigned int cpu, u32 msr_no, u32 *l, u32 *h);
 int wrmsr_on_cpu(unsigned int cpu, u32 msr_no, u32 l, u32 h);
 int rdmsrq_on_cpu(unsigned int cpu, u32 msr_no, u64 *q);
-int wrmsrl_on_cpu(unsigned int cpu, u32 msr_no, u64 q);
+int wrmsrq_on_cpu(unsigned int cpu, u32 msr_no, u64 q);
 void rdmsr_on_cpus(const struct cpumask *mask, u32 msr_no, struct msr __percpu *msrs);
 void wrmsr_on_cpus(const struct cpumask *mask, u32 msr_no, struct msr __percpu *msrs);
 int rdmsr_safe_on_cpu(unsigned int cpu, u32 msr_no, u32 *l, u32 *h);
@@ -355,7 +355,7 @@ static inline int rdmsrq_on_cpu(unsigned int cpu, u32 msr_no, u64 *q)
 	rdmsrq(msr_no, *q);
 	return 0;
 }
-static inline int wrmsrl_on_cpu(unsigned int cpu, u32 msr_no, u64 q)
+static inline int wrmsrq_on_cpu(unsigned int cpu, u32 msr_no, u64 q)
 {
 	wrmsrq(msr_no, q);
 	return 0;
diff --git a/arch/x86/kernel/cpu/intel_epb.c b/arch/x86/kernel/cpu/intel_epb.c
index 54236de..bc7671f 100644
--- a/arch/x86/kernel/cpu/intel_epb.c
+++ b/arch/x86/kernel/cpu/intel_epb.c
@@ -161,7 +161,7 @@ static ssize_t energy_perf_bias_store(struct device *dev,
 	if (ret < 0)
 		return ret;
 
-	ret = wrmsrl_on_cpu(cpu, MSR_IA32_ENERGY_PERF_BIAS,
+	ret = wrmsrq_on_cpu(cpu, MSR_IA32_ENERGY_PERF_BIAS,
 			    (epb & ~EPB_MASK) | val);
 	if (ret < 0)
 		return ret;
diff --git a/arch/x86/lib/msr-smp.c b/arch/x86/lib/msr-smp.c
index b6081fc..b8f6341 100644
--- a/arch/x86/lib/msr-smp.c
+++ b/arch/x86/lib/msr-smp.c
@@ -78,7 +78,7 @@ int wrmsr_on_cpu(unsigned int cpu, u32 msr_no, u32 l, u32 h)
 }
 EXPORT_SYMBOL(wrmsr_on_cpu);
 
-int wrmsrl_on_cpu(unsigned int cpu, u32 msr_no, u64 q)
+int wrmsrq_on_cpu(unsigned int cpu, u32 msr_no, u64 q)
 {
 	int err;
 	struct msr_info rv;
@@ -92,7 +92,7 @@ int wrmsrl_on_cpu(unsigned int cpu, u32 msr_no, u64 q)
 
 	return err;
 }
-EXPORT_SYMBOL(wrmsrl_on_cpu);
+EXPORT_SYMBOL(wrmsrq_on_cpu);
 
 static void __rwmsr_on_cpus(const struct cpumask *mask, u32 msr_no,
 			    struct msr __percpu *msrs,
diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index e987486..fd1ae77 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -261,7 +261,7 @@ static int msr_update_perf(struct cpufreq_policy *policy, u8 min_perf,
 		wrmsrq(MSR_AMD_CPPC_REQ, value);
 		return 0;
 	} else {
-		int ret = wrmsrl_on_cpu(cpudata->cpu, MSR_AMD_CPPC_REQ, value);
+		int ret = wrmsrq_on_cpu(cpudata->cpu, MSR_AMD_CPPC_REQ, value);
 
 		if (ret)
 			return ret;
@@ -309,7 +309,7 @@ static int msr_set_epp(struct cpufreq_policy *policy, u8 epp)
 	if (value == prev)
 		return 0;
 
-	ret = wrmsrl_on_cpu(cpudata->cpu, MSR_AMD_CPPC_REQ, value);
+	ret = wrmsrq_on_cpu(cpudata->cpu, MSR_AMD_CPPC_REQ, value);
 	if (ret) {
 		pr_err("failed to set energy perf value (%d)\n", ret);
 		return ret;
@@ -788,7 +788,7 @@ exit_err:
 
 static void amd_perf_ctl_reset(unsigned int cpu)
 {
-	wrmsrl_on_cpu(cpu, MSR_AMD_PERF_CTL, 0);
+	wrmsrq_on_cpu(cpu, MSR_AMD_PERF_CTL, 0);
 }
 
 /*
diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
index 8ce9d54..8e23f31 100644
--- a/drivers/cpufreq/intel_pstate.c
+++ b/drivers/cpufreq/intel_pstate.c
@@ -664,7 +664,7 @@ static int intel_pstate_set_epb(int cpu, s16 pref)
 		return ret;
 
 	epb = (epb & ~0x0f) | pref;
-	wrmsrl_on_cpu(cpu, MSR_IA32_ENERGY_PERF_BIAS, epb);
+	wrmsrq_on_cpu(cpu, MSR_IA32_ENERGY_PERF_BIAS, epb);
 
 	return 0;
 }
@@ -762,7 +762,7 @@ static int intel_pstate_set_epp(struct cpudata *cpu, u32 epp)
 	 * function, so it cannot run in parallel with the update below.
 	 */
 	WRITE_ONCE(cpu->hwp_req_cached, value);
-	ret = wrmsrl_on_cpu(cpu->cpu, MSR_HWP_REQUEST, value);
+	ret = wrmsrq_on_cpu(cpu->cpu, MSR_HWP_REQUEST, value);
 	if (!ret)
 		cpu->epp_cached = epp;
 
@@ -1209,7 +1209,7 @@ static void intel_pstate_hwp_set(unsigned int cpu)
 	}
 skip_epp:
 	WRITE_ONCE(cpu_data->hwp_req_cached, value);
-	wrmsrl_on_cpu(cpu, MSR_HWP_REQUEST, value);
+	wrmsrq_on_cpu(cpu, MSR_HWP_REQUEST, value);
 }
 
 static void intel_pstate_disable_hwp_interrupt(struct cpudata *cpudata);
@@ -1256,7 +1256,7 @@ static void intel_pstate_hwp_offline(struct cpudata *cpu)
 	if (boot_cpu_has(X86_FEATURE_HWP_EPP))
 		value |= HWP_ENERGY_PERF_PREFERENCE(HWP_EPP_POWERSAVE);
 
-	wrmsrl_on_cpu(cpu->cpu, MSR_HWP_REQUEST, value);
+	wrmsrq_on_cpu(cpu->cpu, MSR_HWP_REQUEST, value);
 
 	mutex_lock(&hybrid_capacity_lock);
 
@@ -1302,7 +1302,7 @@ static void intel_pstate_hwp_enable(struct cpudata *cpudata);
 static void intel_pstate_hwp_reenable(struct cpudata *cpu)
 {
 	intel_pstate_hwp_enable(cpu);
-	wrmsrl_on_cpu(cpu->cpu, MSR_HWP_REQUEST, READ_ONCE(cpu->hwp_req_cached));
+	wrmsrq_on_cpu(cpu->cpu, MSR_HWP_REQUEST, READ_ONCE(cpu->hwp_req_cached));
 }
 
 static int intel_pstate_suspend(struct cpufreq_policy *policy)
@@ -1855,7 +1855,7 @@ static void intel_pstate_notify_work(struct work_struct *work)
 		hybrid_update_capacity(cpudata);
 	}
 
-	wrmsrl_on_cpu(cpudata->cpu, MSR_HWP_STATUS, 0);
+	wrmsrq_on_cpu(cpudata->cpu, MSR_HWP_STATUS, 0);
 }
 
 static DEFINE_RAW_SPINLOCK(hwp_notify_lock);
@@ -1905,8 +1905,8 @@ static void intel_pstate_disable_hwp_interrupt(struct cpudata *cpudata)
 	if (!cpu_feature_enabled(X86_FEATURE_HWP_NOTIFY))
 		return;
 
-	/* wrmsrl_on_cpu has to be outside spinlock as this can result in IPC */
-	wrmsrl_on_cpu(cpudata->cpu, MSR_HWP_INTERRUPT, 0x00);
+	/* wrmsrq_on_cpu has to be outside spinlock as this can result in IPC */
+	wrmsrq_on_cpu(cpudata->cpu, MSR_HWP_INTERRUPT, 0x00);
 
 	raw_spin_lock_irq(&hwp_notify_lock);
 	cancel_work = cpumask_test_and_clear_cpu(cpudata->cpu, &hwp_intr_enable_mask);
@@ -1933,9 +1933,9 @@ static void intel_pstate_enable_hwp_interrupt(struct cpudata *cpudata)
 		if (cpu_feature_enabled(X86_FEATURE_HWP_HIGHEST_PERF_CHANGE))
 			interrupt_mask |= HWP_HIGHEST_PERF_CHANGE_REQ;
 
-		/* wrmsrl_on_cpu has to be outside spinlock as this can result in IPC */
-		wrmsrl_on_cpu(cpudata->cpu, MSR_HWP_INTERRUPT, interrupt_mask);
-		wrmsrl_on_cpu(cpudata->cpu, MSR_HWP_STATUS, 0);
+		/* wrmsrq_on_cpu has to be outside spinlock as this can result in IPC */
+		wrmsrq_on_cpu(cpudata->cpu, MSR_HWP_INTERRUPT, interrupt_mask);
+		wrmsrq_on_cpu(cpudata->cpu, MSR_HWP_STATUS, 0);
 	}
 }
 
@@ -1974,9 +1974,9 @@ static void intel_pstate_hwp_enable(struct cpudata *cpudata)
 {
 	/* First disable HWP notification interrupt till we activate again */
 	if (boot_cpu_has(X86_FEATURE_HWP_NOTIFY))
-		wrmsrl_on_cpu(cpudata->cpu, MSR_HWP_INTERRUPT, 0x00);
+		wrmsrq_on_cpu(cpudata->cpu, MSR_HWP_INTERRUPT, 0x00);
 
-	wrmsrl_on_cpu(cpudata->cpu, MSR_PM_ENABLE, 0x1);
+	wrmsrq_on_cpu(cpudata->cpu, MSR_PM_ENABLE, 0x1);
 
 	intel_pstate_enable_hwp_interrupt(cpudata);
 
@@ -2244,7 +2244,7 @@ static void intel_pstate_set_pstate(struct cpudata *cpu, int pstate)
 	 * the CPU being updated, so force the register update to run on the
 	 * right CPU.
 	 */
-	wrmsrl_on_cpu(cpu->cpu, MSR_IA32_PERF_CTL,
+	wrmsrq_on_cpu(cpu->cpu, MSR_IA32_PERF_CTL,
 		      pstate_funcs.get_val(cpu, pstate));
 }
 
@@ -3102,7 +3102,7 @@ static void intel_cpufreq_hwp_update(struct cpudata *cpu, u32 min, u32 max,
 	if (fast_switch)
 		wrmsrq(MSR_HWP_REQUEST, value);
 	else
-		wrmsrl_on_cpu(cpu->cpu, MSR_HWP_REQUEST, value);
+		wrmsrq_on_cpu(cpu->cpu, MSR_HWP_REQUEST, value);
 }
 
 static void intel_cpufreq_perf_ctl_update(struct cpudata *cpu,
@@ -3112,7 +3112,7 @@ static void intel_cpufreq_perf_ctl_update(struct cpudata *cpu,
 		wrmsrq(MSR_IA32_PERF_CTL,
 		       pstate_funcs.get_val(cpu, target_pstate));
 	else
-		wrmsrl_on_cpu(cpu->cpu, MSR_IA32_PERF_CTL,
+		wrmsrq_on_cpu(cpu->cpu, MSR_IA32_PERF_CTL,
 			      pstate_funcs.get_val(cpu, target_pstate));
 }
 
@@ -3323,7 +3323,7 @@ static int intel_cpufreq_suspend(struct cpufreq_policy *policy)
 		 * written by it may not be suitable.
 		 */
 		value &= ~HWP_DESIRED_PERF(~0L);
-		wrmsrl_on_cpu(cpu->cpu, MSR_HWP_REQUEST, value);
+		wrmsrq_on_cpu(cpu->cpu, MSR_HWP_REQUEST, value);
 		WRITE_ONCE(cpu->hwp_req_cached, value);
 	}
 
diff --git a/drivers/platform/x86/intel/uncore-frequency/uncore-frequency.c b/drivers/platform/x86/intel/uncore-frequency/uncore-frequency.c
index 5295cd1..6f87376 100644
--- a/drivers/platform/x86/intel/uncore-frequency/uncore-frequency.c
+++ b/drivers/platform/x86/intel/uncore-frequency/uncore-frequency.c
@@ -88,7 +88,7 @@ static int uncore_write_control_freq(struct uncore_data *data, unsigned int inpu
 		cap |= FIELD_PREP(UNCORE_MIN_RATIO_MASK, input);
 	}
 
-	ret = wrmsrl_on_cpu(data->control_cpu, MSR_UNCORE_RATIO_LIMIT, cap);
+	ret = wrmsrq_on_cpu(data->control_cpu, MSR_UNCORE_RATIO_LIMIT, cap);
 	if (ret)
 		return ret;
 
@@ -207,7 +207,7 @@ static int uncore_pm_notify(struct notifier_block *nb, unsigned long mode,
 			if (!data || !data->valid || !data->stored_uncore_data)
 				return 0;
 
-			wrmsrl_on_cpu(data->control_cpu, MSR_UNCORE_RATIO_LIMIT,
+			wrmsrq_on_cpu(data->control_cpu, MSR_UNCORE_RATIO_LIMIT,
 				      data->stored_uncore_data);
 		}
 		break;

