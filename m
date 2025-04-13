Return-Path: <linux-tip-commits+bounces-4935-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F5A3A87347
	for <lists+linux-tip-commits@lfdr.de>; Sun, 13 Apr 2025 20:57:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B964A7A7450
	for <lists+linux-tip-commits@lfdr.de>; Sun, 13 Apr 2025 18:56:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0D981F582B;
	Sun, 13 Apr 2025 18:56:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="l/nmfsZX";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="yS7PzHvH"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D506C1F4CBE;
	Sun, 13 Apr 2025 18:56:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744570582; cv=none; b=NamCiNvzRoMJVIfVoZlQavD39E1fac+VCUjzNsvMLEBEZBMpoTMGah8CuEk89YAJiA0ldv3nyDDWzYJbVxSew45zulKJhUKjx94hlT6qG6+mH47rEd4QppkAKDpgdFCrARFZfV4dM5UhVNTeeMRjOJW4/2fwcfUwnsaGHatU3s0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744570582; c=relaxed/simple;
	bh=FmGSIa4/f6T+U+XKHxj93MMHFW/e7LQ6+6leBixkvcQ=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=YzogZSQ4sdAU4f1h3XuRF7hQQLPVW48gXbH6/U0VDihmfLfoOQZCoiFNTU6/5kgbXtpqywtarcr4h2JMcjuyHAiKpfEH7mmpwYXpM5qk2ZKoRB3vbnw2SYXDFo/MF77nzYLh7+Zu0eFAo/sQutOfobWfZ17snwx94UD8L6HspSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=l/nmfsZX; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=yS7PzHvH; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sun, 13 Apr 2025 18:56:17 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1744570578;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=heRiygwWF4ZShQVHEPFkW2n7XrxP16tFIt5auDUXIlY=;
	b=l/nmfsZXIrwvnguotNmlr0VQDMw5NvBBtcC79ufCZKOfEGSh3QnV0hHPPIR9WSMK3pz50J
	ysDKdDYlD8GBmAvv5oQL9Q66uqeTIhJEpm2yji4iEfu4loBwuJO7RCIqu0vS9fI32L2muV
	8l9vYOGY8alvISZ/07CZGUyqv+xMMJ5gbD0SQaRnPRBHg5p+ULQoCJ+cgoSLdiHUS1cWqc
	mAipqPXVOCpbd3yhaq1Qf3L/5F/MQAbsbSlv+AF7EixMKlYrto6U6cgde0yg4gwaAbsaW6
	itnP/liWSr+HMbDc45IrHtg41A9JEvak9+In26eFhYV74L+cqwx0qQzc6jSSrQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1744570578;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=heRiygwWF4ZShQVHEPFkW2n7XrxP16tFIt5auDUXIlY=;
	b=yS7PzHvHOpgcEL+Z0452ZsSqae0QouqvuE+BmMzolIN5Qx2wfbhv2BXi/77dX0mqJNt+Wo
	D3qmuHXHL53Be5Aw==
From: "tip-bot2 for Ingo Molnar" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/msr] x86/msr: Rename 'rdmsrl_safe_on_cpu()' to
 'rdmsrq_safe_on_cpu()'
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
Message-ID: <174457057745.31282.9424947196605411884.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/msr branch of tip:

Commit-ID:     5e404cb7ac4c097e95896a4a3fba5f5aabf7f679
Gitweb:        https://git.kernel.org/tip/5e404cb7ac4c097e95896a4a3fba5f5aabf7f679
Author:        Ingo Molnar <mingo@kernel.org>
AuthorDate:    Wed, 09 Apr 2025 22:28:58 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Thu, 10 Apr 2025 11:58:49 +02:00

x86/msr: Rename 'rdmsrl_safe_on_cpu()' to 'rdmsrq_safe_on_cpu()'

Suggested-by: "H. Peter Anvin" <hpa@zytor.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Juergen Gross <jgross@suse.com>
Cc: Dave Hansen <dave.hansen@intel.com>
Cc: Xin Li <xin@zytor.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
---
 arch/x86/events/intel/pt.c                                  | 2 +-
 arch/x86/include/asm/msr.h                                  | 4 ++--
 arch/x86/kernel/acpi/cppc.c                                 | 6 +++---
 arch/x86/lib/msr-smp.c                                      | 4 ++--
 drivers/cpufreq/amd-pstate-ut.c                             | 2 +-
 drivers/cpufreq/amd-pstate.c                                | 2 +-
 drivers/cpufreq/intel_pstate.c                              | 6 +++---
 drivers/platform/x86/intel/speed_select_if/isst_if_common.c | 2 +-
 drivers/powercap/intel_rapl_msr.c                           | 2 +-
 9 files changed, 15 insertions(+), 15 deletions(-)

diff --git a/arch/x86/events/intel/pt.c b/arch/x86/events/intel/pt.c
index a645b09..d579f10 100644
--- a/arch/x86/events/intel/pt.c
+++ b/arch/x86/events/intel/pt.c
@@ -1839,7 +1839,7 @@ static __init int pt_init(void)
 	for_each_online_cpu(cpu) {
 		u64 ctl;
 
-		ret = rdmsrl_safe_on_cpu(cpu, MSR_IA32_RTIT_CTL, &ctl);
+		ret = rdmsrq_safe_on_cpu(cpu, MSR_IA32_RTIT_CTL, &ctl);
 		if (!ret && (ctl & RTIT_CTL_TRACEEN))
 			prior_warn++;
 	}
diff --git a/arch/x86/include/asm/msr.h b/arch/x86/include/asm/msr.h
index 2317575..c86814c 100644
--- a/arch/x86/include/asm/msr.h
+++ b/arch/x86/include/asm/msr.h
@@ -335,7 +335,7 @@ void rdmsr_on_cpus(const struct cpumask *mask, u32 msr_no, struct msr __percpu *
 void wrmsr_on_cpus(const struct cpumask *mask, u32 msr_no, struct msr __percpu *msrs);
 int rdmsr_safe_on_cpu(unsigned int cpu, u32 msr_no, u32 *l, u32 *h);
 int wrmsr_safe_on_cpu(unsigned int cpu, u32 msr_no, u32 l, u32 h);
-int rdmsrl_safe_on_cpu(unsigned int cpu, u32 msr_no, u64 *q);
+int rdmsrq_safe_on_cpu(unsigned int cpu, u32 msr_no, u64 *q);
 int wrmsrl_safe_on_cpu(unsigned int cpu, u32 msr_no, u64 q);
 int rdmsr_safe_regs_on_cpu(unsigned int cpu, u32 regs[8]);
 int wrmsr_safe_regs_on_cpu(unsigned int cpu, u32 regs[8]);
@@ -379,7 +379,7 @@ static inline int wrmsr_safe_on_cpu(unsigned int cpu, u32 msr_no, u32 l, u32 h)
 {
 	return wrmsr_safe(msr_no, l, h);
 }
-static inline int rdmsrl_safe_on_cpu(unsigned int cpu, u32 msr_no, u64 *q)
+static inline int rdmsrq_safe_on_cpu(unsigned int cpu, u32 msr_no, u64 *q)
 {
 	return rdmsrq_safe(msr_no, q);
 }
diff --git a/arch/x86/kernel/acpi/cppc.c b/arch/x86/kernel/acpi/cppc.c
index 77bfb84..6a10d73 100644
--- a/arch/x86/kernel/acpi/cppc.c
+++ b/arch/x86/kernel/acpi/cppc.c
@@ -49,7 +49,7 @@ int cpc_read_ffh(int cpunum, struct cpc_reg *reg, u64 *val)
 {
 	int err;
 
-	err = rdmsrl_safe_on_cpu(cpunum, reg->address, val);
+	err = rdmsrq_safe_on_cpu(cpunum, reg->address, val);
 	if (!err) {
 		u64 mask = GENMASK_ULL(reg->bit_offset + reg->bit_width - 1,
 				       reg->bit_offset);
@@ -65,7 +65,7 @@ int cpc_write_ffh(int cpunum, struct cpc_reg *reg, u64 val)
 	u64 rd_val;
 	int err;
 
-	err = rdmsrl_safe_on_cpu(cpunum, reg->address, &rd_val);
+	err = rdmsrq_safe_on_cpu(cpunum, reg->address, &rd_val);
 	if (!err) {
 		u64 mask = GENMASK_ULL(reg->bit_offset + reg->bit_width - 1,
 				       reg->bit_offset);
@@ -147,7 +147,7 @@ int amd_get_highest_perf(unsigned int cpu, u32 *highest_perf)
 	int ret;
 
 	if (cpu_feature_enabled(X86_FEATURE_CPPC)) {
-		ret = rdmsrl_safe_on_cpu(cpu, MSR_AMD_CPPC_CAP1, &val);
+		ret = rdmsrq_safe_on_cpu(cpu, MSR_AMD_CPPC_CAP1, &val);
 		if (ret)
 			goto out;
 
diff --git a/arch/x86/lib/msr-smp.c b/arch/x86/lib/msr-smp.c
index acd463d..0360ce2 100644
--- a/arch/x86/lib/msr-smp.c
+++ b/arch/x86/lib/msr-smp.c
@@ -220,7 +220,7 @@ int wrmsrl_safe_on_cpu(unsigned int cpu, u32 msr_no, u64 q)
 }
 EXPORT_SYMBOL(wrmsrl_safe_on_cpu);
 
-int rdmsrl_safe_on_cpu(unsigned int cpu, u32 msr_no, u64 *q)
+int rdmsrq_safe_on_cpu(unsigned int cpu, u32 msr_no, u64 *q)
 {
 	u32 low, high;
 	int err;
@@ -230,7 +230,7 @@ int rdmsrl_safe_on_cpu(unsigned int cpu, u32 msr_no, u64 *q)
 
 	return err;
 }
-EXPORT_SYMBOL(rdmsrl_safe_on_cpu);
+EXPORT_SYMBOL(rdmsrq_safe_on_cpu);
 
 /*
  * These variants are significantly slower, but allows control over
diff --git a/drivers/cpufreq/amd-pstate-ut.c b/drivers/cpufreq/amd-pstate-ut.c
index 4a1f5b1..707fa81 100644
--- a/drivers/cpufreq/amd-pstate-ut.c
+++ b/drivers/cpufreq/amd-pstate-ut.c
@@ -137,7 +137,7 @@ static int amd_pstate_ut_check_perf(u32 index)
 			lowest_nonlinear_perf = cppc_perf.lowest_nonlinear_perf;
 			lowest_perf = cppc_perf.lowest_perf;
 		} else {
-			ret = rdmsrl_safe_on_cpu(cpu, MSR_AMD_CPPC_CAP1, &cap1);
+			ret = rdmsrq_safe_on_cpu(cpu, MSR_AMD_CPPC_CAP1, &cap1);
 			if (ret) {
 				pr_err("%s read CPPC_CAP1 ret=%d error!\n", __func__, ret);
 				return ret;
diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index b7caaa8..16a3fe2 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -391,7 +391,7 @@ static int msr_init_perf(struct amd_cpudata *cpudata)
 	union perf_cached perf = READ_ONCE(cpudata->perf);
 	u64 cap1, numerator;
 
-	int ret = rdmsrl_safe_on_cpu(cpudata->cpu, MSR_AMD_CPPC_CAP1,
+	int ret = rdmsrq_safe_on_cpu(cpudata->cpu, MSR_AMD_CPPC_CAP1,
 				     &cap1);
 	if (ret)
 		return ret;
diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
index 83a43c6..6f6c14e 100644
--- a/drivers/cpufreq/intel_pstate.c
+++ b/drivers/cpufreq/intel_pstate.c
@@ -2106,13 +2106,13 @@ static int core_get_tdp_ratio(int cpu, u64 plat_info)
 		int err;
 
 		/* Get the TDP level (0, 1, 2) to get ratios */
-		err = rdmsrl_safe_on_cpu(cpu, MSR_CONFIG_TDP_CONTROL, &tdp_ctrl);
+		err = rdmsrq_safe_on_cpu(cpu, MSR_CONFIG_TDP_CONTROL, &tdp_ctrl);
 		if (err)
 			return err;
 
 		/* TDP MSR are continuous starting at 0x648 */
 		tdp_msr = MSR_CONFIG_TDP_NOMINAL + (tdp_ctrl & 0x03);
-		err = rdmsrl_safe_on_cpu(cpu, tdp_msr, &tdp_ratio);
+		err = rdmsrq_safe_on_cpu(cpu, tdp_msr, &tdp_ratio);
 		if (err)
 			return err;
 
@@ -2149,7 +2149,7 @@ static int core_get_max_pstate(int cpu)
 		return tdp_ratio;
 	}
 
-	err = rdmsrl_safe_on_cpu(cpu, MSR_TURBO_ACTIVATION_RATIO, &tar);
+	err = rdmsrq_safe_on_cpu(cpu, MSR_TURBO_ACTIVATION_RATIO, &tar);
 	if (!err) {
 		int tar_levels;
 
diff --git a/drivers/platform/x86/intel/speed_select_if/isst_if_common.c b/drivers/platform/x86/intel/speed_select_if/isst_if_common.c
index 4368d59..46b96f1 100644
--- a/drivers/platform/x86/intel/speed_select_if/isst_if_common.c
+++ b/drivers/platform/x86/intel/speed_select_if/isst_if_common.c
@@ -535,7 +535,7 @@ static long isst_if_msr_cmd_req(u8 *cmd_ptr, int *write_only, int resume)
 	} else {
 		u64 data;
 
-		ret = rdmsrl_safe_on_cpu(msr_cmd->logical_cpu,
+		ret = rdmsrq_safe_on_cpu(msr_cmd->logical_cpu,
 					 msr_cmd->msr, &data);
 		if (!ret) {
 			msr_cmd->data = data;
diff --git a/drivers/powercap/intel_rapl_msr.c b/drivers/powercap/intel_rapl_msr.c
index c7f15b0..6d5853d 100644
--- a/drivers/powercap/intel_rapl_msr.c
+++ b/drivers/powercap/intel_rapl_msr.c
@@ -103,7 +103,7 @@ static int rapl_cpu_down_prep(unsigned int cpu)
 
 static int rapl_msr_read_raw(int cpu, struct reg_action *ra)
 {
-	if (rdmsrl_safe_on_cpu(cpu, ra->reg.msr, &ra->value)) {
+	if (rdmsrq_safe_on_cpu(cpu, ra->reg.msr, &ra->value)) {
 		pr_debug("failed to read msr 0x%x on cpu %d\n", ra->reg.msr, cpu);
 		return -EIO;
 	}

