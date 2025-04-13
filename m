Return-Path: <linux-tip-commits+bounces-4933-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F0DCAA87349
	for <lists+linux-tip-commits@lfdr.de>; Sun, 13 Apr 2025 20:58:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 81E821885267
	for <lists+linux-tip-commits@lfdr.de>; Sun, 13 Apr 2025 18:57:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF36B1F4C9F;
	Sun, 13 Apr 2025 18:56:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="4dmBOSOh";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="C+yUQ63L"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4ABB1F2B8B;
	Sun, 13 Apr 2025 18:56:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744570579; cv=none; b=tx16bSAWnUOekT1H6TCkUMxmFT1zQFQlYgR3HCu0/iVQew0g1JuFaIeLiKwSGlccn1wrnEKdNqdVcZ4VpA1jdGTmngCcugnad508x7ZMXHgO94o4nvEYVhjm0Rr3abTDDSSBSwE7bZKfbpr+dKGTIWnP37yDN7o5xGXXkWQTwDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744570579; c=relaxed/simple;
	bh=yfL2W9/JlW7hjmDyXwSD10QxfwWjLNd6xvC+aZ27DZQ=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=NTNGD+H+zruiEJQYS0N4tw7YTdtVY+Ys3OZAsujEg0JyJ+9u9qqNk0uIVPArvTMWYex/k61q+IssOQ7U2BbT8xXINhtH1fxsVSZ5CwSLwQl7yGqYDcIGbQ3WVnWNnr1UAWTXQMOqtiTEW8rB7Tn54xMQ/LEQUdrPVnSfV1anHm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=4dmBOSOh; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=C+yUQ63L; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sun, 13 Apr 2025 18:56:15 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1744570576;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=wJEGnbConH/KiomyycsGdTRBf4n7sH+Lr84H6/y/VAI=;
	b=4dmBOSOhVWz4A4+XtqdamulhLfYVtBBK2Tun6CJ89vH2li2Co/aWpNpgu0mLOeBuKWIuY1
	LbQh2+Fl6VTB6VDh+NT9MwquHi3SzbQvSNetJ01GQza3ezFPvNzGqRz0SyoUmR0lqvWuVV
	FylXkF1YJpghd6t7FAFoF9lN1hDuY3ZhbSTNC3Wm1U/ix5BGYdSeDTehIUcEARyLHLY5db
	95VhOOVUPivTTcgSEJCR+ybSvIOPtymhgs0Rdkfho8bCheEssCywp3IiYlc+CnFvINsYJy
	2wNNBf+IgYQwTBXa1SjHicaZ8t1AYVDIdssjdgDmu7ST3qlwwZNnzOibSCgXbg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1744570576;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=wJEGnbConH/KiomyycsGdTRBf4n7sH+Lr84H6/y/VAI=;
	b=C+yUQ63LdaxK8/7ziITQd+NKHZbyiJensfX/Es6qpukM/Fhnj6HbQK5VCTpD57R0mvcTco
	Nc9le1KQZgq9GBCg==
From: "tip-bot2 for Ingo Molnar" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/msr] x86/msr: Rename 'rdmsrl_on_cpu()' to 'rdmsrq_on_cpu()'
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
Message-ID: <174457057558.31282.2740346326120908774.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/msr branch of tip:

Commit-ID:     d7484babd2c4dcfa1ca02e7e303fab3fab529d75
Gitweb:        https://git.kernel.org/tip/d7484babd2c4dcfa1ca02e7e303fab3fab529d75
Author:        Ingo Molnar <mingo@kernel.org>
AuthorDate:    Wed, 09 Apr 2025 22:29:00 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Thu, 10 Apr 2025 11:59:00 +02:00

x86/msr: Rename 'rdmsrl_on_cpu()' to 'rdmsrq_on_cpu()'

Suggested-by: "H. Peter Anvin" <hpa@zytor.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Juergen Gross <jgross@suse.com>
Cc: Dave Hansen <dave.hansen@intel.com>
Cc: Xin Li <xin@zytor.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
---
 arch/x86/events/intel/uncore_snbep.c                           |  2 +-
 arch/x86/include/asm/msr.h                                     |  4 +-
 arch/x86/kernel/cpu/intel_epb.c                                |  4 +-
 arch/x86/kernel/cpu/mce/inject.c                               |  4 +-
 arch/x86/lib/msr-smp.c                                         |  4 +-
 drivers/cpufreq/acpi-cpufreq.c                                 |  4 +-
 drivers/cpufreq/amd-pstate.c                                   |  6 +-
 drivers/cpufreq/intel_pstate.c                                 | 24 +++----
 drivers/platform/x86/intel/uncore-frequency/uncore-frequency.c |  6 +-
 9 files changed, 29 insertions(+), 29 deletions(-)

diff --git a/arch/x86/events/intel/uncore_snbep.c b/arch/x86/events/intel/uncore_snbep.c
index 756dd11..dd53dd8 100644
--- a/arch/x86/events/intel/uncore_snbep.c
+++ b/arch/x86/events/intel/uncore_snbep.c
@@ -3765,7 +3765,7 @@ static int skx_msr_cpu_bus_read(int cpu, u64 *topology)
 {
 	u64 msr_value;
 
-	if (rdmsrl_on_cpu(cpu, SKX_MSR_CPU_BUS_NUMBER, &msr_value) ||
+	if (rdmsrq_on_cpu(cpu, SKX_MSR_CPU_BUS_NUMBER, &msr_value) ||
 			!(msr_value & SKX_MSR_CPU_BUS_VALID_BIT))
 		return -ENXIO;
 
diff --git a/arch/x86/include/asm/msr.h b/arch/x86/include/asm/msr.h
index 5298327..850793b 100644
--- a/arch/x86/include/asm/msr.h
+++ b/arch/x86/include/asm/msr.h
@@ -329,7 +329,7 @@ int msr_clear_bit(u32 msr, u8 bit);
 #ifdef CONFIG_SMP
 int rdmsr_on_cpu(unsigned int cpu, u32 msr_no, u32 *l, u32 *h);
 int wrmsr_on_cpu(unsigned int cpu, u32 msr_no, u32 l, u32 h);
-int rdmsrl_on_cpu(unsigned int cpu, u32 msr_no, u64 *q);
+int rdmsrq_on_cpu(unsigned int cpu, u32 msr_no, u64 *q);
 int wrmsrl_on_cpu(unsigned int cpu, u32 msr_no, u64 q);
 void rdmsr_on_cpus(const struct cpumask *mask, u32 msr_no, struct msr __percpu *msrs);
 void wrmsr_on_cpus(const struct cpumask *mask, u32 msr_no, struct msr __percpu *msrs);
@@ -350,7 +350,7 @@ static inline int wrmsr_on_cpu(unsigned int cpu, u32 msr_no, u32 l, u32 h)
 	wrmsr(msr_no, l, h);
 	return 0;
 }
-static inline int rdmsrl_on_cpu(unsigned int cpu, u32 msr_no, u64 *q)
+static inline int rdmsrq_on_cpu(unsigned int cpu, u32 msr_no, u64 *q)
 {
 	rdmsrq(msr_no, *q);
 	return 0;
diff --git a/arch/x86/kernel/cpu/intel_epb.c b/arch/x86/kernel/cpu/intel_epb.c
index 01d81b7..54236de 100644
--- a/arch/x86/kernel/cpu/intel_epb.c
+++ b/arch/x86/kernel/cpu/intel_epb.c
@@ -135,7 +135,7 @@ static ssize_t energy_perf_bias_show(struct device *dev,
 	u64 epb;
 	int ret;
 
-	ret = rdmsrl_on_cpu(cpu, MSR_IA32_ENERGY_PERF_BIAS, &epb);
+	ret = rdmsrq_on_cpu(cpu, MSR_IA32_ENERGY_PERF_BIAS, &epb);
 	if (ret < 0)
 		return ret;
 
@@ -157,7 +157,7 @@ static ssize_t energy_perf_bias_store(struct device *dev,
 	else if (kstrtou64(buf, 0, &val) || val > MAX_EPB)
 		return -EINVAL;
 
-	ret = rdmsrl_on_cpu(cpu, MSR_IA32_ENERGY_PERF_BIAS, &epb);
+	ret = rdmsrq_on_cpu(cpu, MSR_IA32_ENERGY_PERF_BIAS, &epb);
 	if (ret < 0)
 		return ret;
 
diff --git a/arch/x86/kernel/cpu/mce/inject.c b/arch/x86/kernel/cpu/mce/inject.c
index 5226f8f..338aeee 100644
--- a/arch/x86/kernel/cpu/mce/inject.c
+++ b/arch/x86/kernel/cpu/mce/inject.c
@@ -589,7 +589,7 @@ static int inj_bank_set(void *data, u64 val)
 	u64 cap;
 
 	/* Get bank count on target CPU so we can handle non-uniform values. */
-	rdmsrl_on_cpu(m->extcpu, MSR_IA32_MCG_CAP, &cap);
+	rdmsrq_on_cpu(m->extcpu, MSR_IA32_MCG_CAP, &cap);
 	n_banks = cap & MCG_BANKCNT_MASK;
 
 	if (val >= n_banks) {
@@ -613,7 +613,7 @@ static int inj_bank_set(void *data, u64 val)
 	if (cpu_feature_enabled(X86_FEATURE_SMCA)) {
 		u64 ipid;
 
-		if (rdmsrl_on_cpu(m->extcpu, MSR_AMD64_SMCA_MCx_IPID(val), &ipid)) {
+		if (rdmsrq_on_cpu(m->extcpu, MSR_AMD64_SMCA_MCx_IPID(val), &ipid)) {
 			pr_err("Error reading IPID on CPU%d\n", m->extcpu);
 			return -EINVAL;
 		}
diff --git a/arch/x86/lib/msr-smp.c b/arch/x86/lib/msr-smp.c
index 434fdc2..b6081fc 100644
--- a/arch/x86/lib/msr-smp.c
+++ b/arch/x86/lib/msr-smp.c
@@ -47,7 +47,7 @@ int rdmsr_on_cpu(unsigned int cpu, u32 msr_no, u32 *l, u32 *h)
 }
 EXPORT_SYMBOL(rdmsr_on_cpu);
 
-int rdmsrl_on_cpu(unsigned int cpu, u32 msr_no, u64 *q)
+int rdmsrq_on_cpu(unsigned int cpu, u32 msr_no, u64 *q)
 {
 	int err;
 	struct msr_info rv;
@@ -60,7 +60,7 @@ int rdmsrl_on_cpu(unsigned int cpu, u32 msr_no, u64 *q)
 
 	return err;
 }
-EXPORT_SYMBOL(rdmsrl_on_cpu);
+EXPORT_SYMBOL(rdmsrq_on_cpu);
 
 int wrmsr_on_cpu(unsigned int cpu, u32 msr_no, u32 l, u32 h)
 {
diff --git a/drivers/cpufreq/acpi-cpufreq.c b/drivers/cpufreq/acpi-cpufreq.c
index d19867c..8bc08f3 100644
--- a/drivers/cpufreq/acpi-cpufreq.c
+++ b/drivers/cpufreq/acpi-cpufreq.c
@@ -79,11 +79,11 @@ static bool boost_state(unsigned int cpu)
 	case X86_VENDOR_INTEL:
 	case X86_VENDOR_CENTAUR:
 	case X86_VENDOR_ZHAOXIN:
-		rdmsrl_on_cpu(cpu, MSR_IA32_MISC_ENABLE, &msr);
+		rdmsrq_on_cpu(cpu, MSR_IA32_MISC_ENABLE, &msr);
 		return !(msr & MSR_IA32_MISC_ENABLE_TURBO_DISABLE);
 	case X86_VENDOR_HYGON:
 	case X86_VENDOR_AMD:
-		rdmsrl_on_cpu(cpu, MSR_K7_HWCR, &msr);
+		rdmsrq_on_cpu(cpu, MSR_K7_HWCR, &msr);
 		return !(msr & MSR_K7_HWCR_CPB_DIS);
 	}
 	return false;
diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index 0615c73..e987486 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -197,7 +197,7 @@ static u8 msr_get_epp(struct amd_cpudata *cpudata)
 	u64 value;
 	int ret;
 
-	ret = rdmsrl_on_cpu(cpudata->cpu, MSR_AMD_CPPC_REQ, &value);
+	ret = rdmsrq_on_cpu(cpudata->cpu, MSR_AMD_CPPC_REQ, &value);
 	if (ret < 0) {
 		pr_debug("Could not retrieve energy perf value (%d)\n", ret);
 		return ret;
@@ -769,7 +769,7 @@ static int amd_pstate_init_boost_support(struct amd_cpudata *cpudata)
 		goto exit_err;
 	}
 
-	ret = rdmsrl_on_cpu(cpudata->cpu, MSR_K7_HWCR, &boost_val);
+	ret = rdmsrq_on_cpu(cpudata->cpu, MSR_K7_HWCR, &boost_val);
 	if (ret) {
 		pr_err_once("failed to read initial CPU boost state!\n");
 		ret = -EIO;
@@ -1491,7 +1491,7 @@ static int amd_pstate_epp_cpu_init(struct cpufreq_policy *policy)
 	}
 
 	if (cpu_feature_enabled(X86_FEATURE_CPPC)) {
-		ret = rdmsrl_on_cpu(cpudata->cpu, MSR_AMD_CPPC_REQ, &value);
+		ret = rdmsrq_on_cpu(cpudata->cpu, MSR_AMD_CPPC_REQ, &value);
 		if (ret)
 			return ret;
 		WRITE_ONCE(cpudata->cppc_req_cached, value);
diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
index 6f6c14e..8ce9d54 100644
--- a/drivers/cpufreq/intel_pstate.c
+++ b/drivers/cpufreq/intel_pstate.c
@@ -620,7 +620,7 @@ static s16 intel_pstate_get_epb(struct cpudata *cpu_data)
 	if (!boot_cpu_has(X86_FEATURE_EPB))
 		return -ENXIO;
 
-	ret = rdmsrl_on_cpu(cpu_data->cpu, MSR_IA32_ENERGY_PERF_BIAS, &epb);
+	ret = rdmsrq_on_cpu(cpu_data->cpu, MSR_IA32_ENERGY_PERF_BIAS, &epb);
 	if (ret)
 		return (s16)ret;
 
@@ -637,7 +637,7 @@ static s16 intel_pstate_get_epp(struct cpudata *cpu_data, u64 hwp_req_data)
 		 * MSR_HWP_REQUEST, so need to read and get EPP.
 		 */
 		if (!hwp_req_data) {
-			epp = rdmsrl_on_cpu(cpu_data->cpu, MSR_HWP_REQUEST,
+			epp = rdmsrq_on_cpu(cpu_data->cpu, MSR_HWP_REQUEST,
 					    &hwp_req_data);
 			if (epp)
 				return epp;
@@ -659,7 +659,7 @@ static int intel_pstate_set_epb(int cpu, s16 pref)
 	if (!boot_cpu_has(X86_FEATURE_EPB))
 		return -ENXIO;
 
-	ret = rdmsrl_on_cpu(cpu, MSR_IA32_ENERGY_PERF_BIAS, &epb);
+	ret = rdmsrq_on_cpu(cpu, MSR_IA32_ENERGY_PERF_BIAS, &epb);
 	if (ret)
 		return ret;
 
@@ -916,7 +916,7 @@ static ssize_t show_base_frequency(struct cpufreq_policy *policy, char *buf)
 	if (ratio <= 0) {
 		u64 cap;
 
-		rdmsrl_on_cpu(policy->cpu, MSR_HWP_CAPABILITIES, &cap);
+		rdmsrq_on_cpu(policy->cpu, MSR_HWP_CAPABILITIES, &cap);
 		ratio = HWP_GUARANTEED_PERF(cap);
 	}
 
@@ -1088,7 +1088,7 @@ static void __intel_pstate_get_hwp_cap(struct cpudata *cpu)
 {
 	u64 cap;
 
-	rdmsrl_on_cpu(cpu->cpu, MSR_HWP_CAPABILITIES, &cap);
+	rdmsrq_on_cpu(cpu->cpu, MSR_HWP_CAPABILITIES, &cap);
 	WRITE_ONCE(cpu->hwp_cap_cached, cap);
 	cpu->pstate.max_pstate = HWP_GUARANTEED_PERF(cap);
 	cpu->pstate.turbo_pstate = HWP_HIGHEST_PERF(cap);
@@ -1162,7 +1162,7 @@ static void intel_pstate_hwp_set(unsigned int cpu)
 	if (cpu_data->policy == CPUFREQ_POLICY_PERFORMANCE)
 		min = max;
 
-	rdmsrl_on_cpu(cpu, MSR_HWP_REQUEST, &value);
+	rdmsrq_on_cpu(cpu, MSR_HWP_REQUEST, &value);
 
 	value &= ~HWP_MIN_PERF(~0L);
 	value |= HWP_MIN_PERF(min);
@@ -2084,7 +2084,7 @@ static int core_get_min_pstate(int cpu)
 {
 	u64 value;
 
-	rdmsrl_on_cpu(cpu, MSR_PLATFORM_INFO, &value);
+	rdmsrq_on_cpu(cpu, MSR_PLATFORM_INFO, &value);
 	return (value >> 40) & 0xFF;
 }
 
@@ -2092,7 +2092,7 @@ static int core_get_max_pstate_physical(int cpu)
 {
 	u64 value;
 
-	rdmsrl_on_cpu(cpu, MSR_PLATFORM_INFO, &value);
+	rdmsrq_on_cpu(cpu, MSR_PLATFORM_INFO, &value);
 	return (value >> 8) & 0xFF;
 }
 
@@ -2137,7 +2137,7 @@ static int core_get_max_pstate(int cpu)
 	int tdp_ratio;
 	int err;
 
-	rdmsrl_on_cpu(cpu, MSR_PLATFORM_INFO, &plat_info);
+	rdmsrq_on_cpu(cpu, MSR_PLATFORM_INFO, &plat_info);
 	max_pstate = (plat_info >> 8) & 0xFF;
 
 	tdp_ratio = core_get_tdp_ratio(cpu, plat_info);
@@ -2169,7 +2169,7 @@ static int core_get_turbo_pstate(int cpu)
 	u64 value;
 	int nont, ret;
 
-	rdmsrl_on_cpu(cpu, MSR_TURBO_RATIO_LIMIT, &value);
+	rdmsrq_on_cpu(cpu, MSR_TURBO_RATIO_LIMIT, &value);
 	nont = core_get_max_pstate(cpu);
 	ret = (value) & 255;
 	if (ret <= nont)
@@ -2198,7 +2198,7 @@ static int knl_get_turbo_pstate(int cpu)
 	u64 value;
 	int nont, ret;
 
-	rdmsrl_on_cpu(cpu, MSR_TURBO_RATIO_LIMIT, &value);
+	rdmsrq_on_cpu(cpu, MSR_TURBO_RATIO_LIMIT, &value);
 	nont = core_get_max_pstate(cpu);
 	ret = (((value) >> 8) & 0xFF);
 	if (ret <= nont)
@@ -3256,7 +3256,7 @@ static int intel_cpufreq_cpu_init(struct cpufreq_policy *policy)
 
 		intel_pstate_get_hwp_cap(cpu);
 
-		rdmsrl_on_cpu(cpu->cpu, MSR_HWP_REQUEST, &value);
+		rdmsrq_on_cpu(cpu->cpu, MSR_HWP_REQUEST, &value);
 		WRITE_ONCE(cpu->hwp_req_cached, value);
 
 		cpu->epp_cached = intel_pstate_get_epp(cpu, value);
diff --git a/drivers/platform/x86/intel/uncore-frequency/uncore-frequency.c b/drivers/platform/x86/intel/uncore-frequency/uncore-frequency.c
index 40bbf8e..5295cd1 100644
--- a/drivers/platform/x86/intel/uncore-frequency/uncore-frequency.c
+++ b/drivers/platform/x86/intel/uncore-frequency/uncore-frequency.c
@@ -51,7 +51,7 @@ static int uncore_read_control_freq(struct uncore_data *data, unsigned int *valu
 	if (data->control_cpu < 0)
 		return -ENXIO;
 
-	ret = rdmsrl_on_cpu(data->control_cpu, MSR_UNCORE_RATIO_LIMIT, &cap);
+	ret = rdmsrq_on_cpu(data->control_cpu, MSR_UNCORE_RATIO_LIMIT, &cap);
 	if (ret)
 		return ret;
 
@@ -76,7 +76,7 @@ static int uncore_write_control_freq(struct uncore_data *data, unsigned int inpu
 	if (data->control_cpu < 0)
 		return -ENXIO;
 
-	ret = rdmsrl_on_cpu(data->control_cpu, MSR_UNCORE_RATIO_LIMIT, &cap);
+	ret = rdmsrq_on_cpu(data->control_cpu, MSR_UNCORE_RATIO_LIMIT, &cap);
 	if (ret)
 		return ret;
 
@@ -105,7 +105,7 @@ static int uncore_read_freq(struct uncore_data *data, unsigned int *freq)
 	if (data->control_cpu < 0)
 		return -ENXIO;
 
-	ret = rdmsrl_on_cpu(data->control_cpu, MSR_UNCORE_PERF_STATUS, &ratio);
+	ret = rdmsrq_on_cpu(data->control_cpu, MSR_UNCORE_PERF_STATUS, &ratio);
 	if (ret)
 		return ret;
 

