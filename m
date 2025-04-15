Return-Path: <linux-tip-commits+bounces-4992-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 55412A8A941
	for <lists+linux-tip-commits@lfdr.de>; Tue, 15 Apr 2025 22:26:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8990419009F5
	for <lists+linux-tip-commits@lfdr.de>; Tue, 15 Apr 2025 20:27:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95D2F253323;
	Tue, 15 Apr 2025 20:26:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="A2yFx5d1";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="HqueY0KA"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98E24254848;
	Tue, 15 Apr 2025 20:26:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744748804; cv=none; b=b2WpGQ/Wf8zx2bNLZc5yvJ4jz0cneAKRMTXZHhBQo+E2zHPEo/+DPIPZeMzWc4OpDiBMRNY1p+AC6kduJHYT2XwthYms0rLmIJHeoB0yeFdguOZmffUHmMlM1vwVVyaHp5zkiWpCwxX/exuaBwp8PDygSTfFYRqxQiEKA/X463A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744748804; c=relaxed/simple;
	bh=SZ05gaZMA5JVkKHPiFvRvLzr0lgvzW0VYZRquAxG1K0=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=SnybA9tqxONqT6Y8dTa5U5cR4sxSQw/Jwn4fVvd2aspF//fCAOEbDVtkqZwMMmJ9kj14Pp0CzVVYEJI24Ay8UCYYTdJOZR2QxExuWtx014Odl/zN6efv/pyb5V6kLWn80Uz/H5anVkQxtUJ4iiof3yvpVCYBdYnopxp2k6hk4Ns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=A2yFx5d1; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=HqueY0KA; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 15 Apr 2025 20:26:28 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1744748794;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CQbZBn1ckwYSGZifm3PodLOTGWlBhRy/B2yw5rHj+O0=;
	b=A2yFx5d1DaS9/W2jcvKEvyrhajgC/rMPcsoBtyb1/PzGdRojFTsJyiZRGGtMxE2ROMOUUC
	e+/W6fZmaN5Z+z+z1MGfSZTxOP6ykijHcVA0KclV9XVk9ECdMZ6Tr+3eQxZcwT5d5MRhCQ
	DbKus+t0k13uXVg8x5BCytW6VS9qV2elAtOvixj3mJtNgK455Rn+SUspIFzIT/CBo5rDyp
	cEmQGFbyQD/ybQmXWMYWSpyO/nlEN8B5GzcARBQnFyEFKakYl9ekdq58aLcBF+9qZs2425
	N5Oj6ySzrOSRY4pvaQhTaSobCInQIR0u4ZtBHlgqmDn7oYW2DqvxTMIOZXboJA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1744748794;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CQbZBn1ckwYSGZifm3PodLOTGWlBhRy/B2yw5rHj+O0=;
	b=HqueY0KAkIQiq2j2a51vlg76Qi8eO5oUuA++mVJ1u3fomOd3LpvDkB97BxQPmc6MFXCq6p
	O9qoKRHRQgg9vADQ==
From: "tip-bot2 for Xin Li (Intel)" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: x86/cpu] x86/cpufeatures: Shorten X86_FEATURE_AMD_HETEROGENEOUS_CORES
Cc: "Borislav Petkov (AMD)" <bp@alien8.de>, "Xin Li (Intel)" <xin@zytor.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250415175410.2944032-4-xin@zytor.com>
References: <20250415175410.2944032-4-xin@zytor.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174474878899.31282.14609854394955863221.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/cpu branch of tip:

Commit-ID:     3aba0b40cacdfba4a604dd09315fa6cdbeb0ed90
Gitweb:        https://git.kernel.org/tip/3aba0b40cacdfba4a604dd09315fa6cdbeb0ed90
Author:        Xin Li (Intel) <xin@zytor.com>
AuthorDate:    Tue, 15 Apr 2025 10:54:10 -07:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Tue, 15 Apr 2025 22:09:20 +02:00

x86/cpufeatures: Shorten X86_FEATURE_AMD_HETEROGENEOUS_CORES

Shorten X86_FEATURE_AMD_HETEROGENEOUS_CORES to X86_FEATURE_AMD_HTR_CORES
to make the last column aligned consistently in the whole file.

No functional changes.

Suggested-by: Borislav Petkov (AMD) <bp@alien8.de>
Signed-off-by: Xin Li (Intel) <xin@zytor.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://lore.kernel.org/20250415175410.2944032-4-xin@zytor.com
---
 arch/x86/include/asm/cpufeatures.h       | 2 +-
 arch/x86/kernel/acpi/cppc.c              | 2 +-
 arch/x86/kernel/cpu/scattered.c          | 2 +-
 arch/x86/kernel/cpu/topology_amd.c       | 2 +-
 tools/arch/x86/include/asm/cpufeatures.h | 2 +-
 5 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/x86/include/asm/cpufeatures.h b/arch/x86/include/asm/cpufeatures.h
index bd27a1d..bc81b9d 100644
--- a/arch/x86/include/asm/cpufeatures.h
+++ b/arch/x86/include/asm/cpufeatures.h
@@ -478,7 +478,7 @@
 #define X86_FEATURE_CLEAR_BHB_HW	(21*32+ 3) /* BHI_DIS_S HW control enabled */
 #define X86_FEATURE_CLEAR_BHB_VMEXIT	(21*32+ 4) /* Clear branch history at vmexit using SW loop */
 #define X86_FEATURE_AMD_FAST_CPPC	(21*32+ 5) /* Fast CPPC */
-#define X86_FEATURE_AMD_HETEROGENEOUS_CORES (21*32+ 6) /* Heterogeneous Core Topology */
+#define X86_FEATURE_AMD_HTR_CORES	(21*32+ 6) /* Heterogeneous Core Topology */
 #define X86_FEATURE_AMD_WORKLOAD_CLASS	(21*32+ 7) /* Workload Classification */
 #define X86_FEATURE_PREFER_YMM		(21*32+ 8) /* Avoid ZMM registers due to downclocking */
 
diff --git a/arch/x86/kernel/acpi/cppc.c b/arch/x86/kernel/acpi/cppc.c
index 77bfb84..62ca714 100644
--- a/arch/x86/kernel/acpi/cppc.c
+++ b/arch/x86/kernel/acpi/cppc.c
@@ -272,7 +272,7 @@ int amd_get_boost_ratio_numerator(unsigned int cpu, u64 *numerator)
 	}
 
 	/* detect if running on heterogeneous design */
-	if (cpu_feature_enabled(X86_FEATURE_AMD_HETEROGENEOUS_CORES)) {
+	if (cpu_feature_enabled(X86_FEATURE_AMD_HTR_CORES)) {
 		switch (core_type) {
 		case TOPO_CPU_TYPE_UNKNOWN:
 			pr_warn("Undefined core type found for cpu %d\n", cpu);
diff --git a/arch/x86/kernel/cpu/scattered.c b/arch/x86/kernel/cpu/scattered.c
index 16f3ca3..c75c57b 100644
--- a/arch/x86/kernel/cpu/scattered.c
+++ b/arch/x86/kernel/cpu/scattered.c
@@ -53,7 +53,7 @@ static const struct cpuid_bit cpuid_bits[] = {
 	{ X86_FEATURE_PERFMON_V2,		CPUID_EAX,  0, 0x80000022, 0 },
 	{ X86_FEATURE_AMD_LBR_V2,		CPUID_EAX,  1, 0x80000022, 0 },
 	{ X86_FEATURE_AMD_LBR_PMC_FREEZE,	CPUID_EAX,  2, 0x80000022, 0 },
-	{ X86_FEATURE_AMD_HETEROGENEOUS_CORES,	CPUID_EAX, 30, 0x80000026, 0 },
+	{ X86_FEATURE_AMD_HTR_CORES,		CPUID_EAX, 30, 0x80000026, 0 },
 	{ 0, 0, 0, 0, 0 }
 };
 
diff --git a/arch/x86/kernel/cpu/topology_amd.c b/arch/x86/kernel/cpu/topology_amd.c
index 03b3c9c..eb799e2 100644
--- a/arch/x86/kernel/cpu/topology_amd.c
+++ b/arch/x86/kernel/cpu/topology_amd.c
@@ -182,7 +182,7 @@ static void parse_topology_amd(struct topo_scan *tscan)
 	if (cpu_feature_enabled(X86_FEATURE_TOPOEXT))
 		has_topoext = cpu_parse_topology_ext(tscan);
 
-	if (cpu_feature_enabled(X86_FEATURE_AMD_HETEROGENEOUS_CORES))
+	if (cpu_feature_enabled(X86_FEATURE_AMD_HTR_CORES))
 		tscan->c->topo.cpu_type = cpuid_ebx(0x80000026);
 
 	if (!has_topoext && !parse_8000_0008(tscan))
diff --git a/tools/arch/x86/include/asm/cpufeatures.h b/tools/arch/x86/include/asm/cpufeatures.h
index e10c3f4..fdbc92a 100644
--- a/tools/arch/x86/include/asm/cpufeatures.h
+++ b/tools/arch/x86/include/asm/cpufeatures.h
@@ -468,7 +468,7 @@
 #define X86_FEATURE_CLEAR_BHB_HW	(21*32+ 3) /* BHI_DIS_S HW control enabled */
 #define X86_FEATURE_CLEAR_BHB_VMEXIT	(21*32+ 4) /* Clear branch history at vmexit using SW loop */
 #define X86_FEATURE_AMD_FAST_CPPC	(21*32+ 5) /* Fast CPPC */
-#define X86_FEATURE_AMD_HETEROGENEOUS_CORES (21*32+ 6) /* Heterogeneous Core Topology */
+#define X86_FEATURE_AMD_HTR_CORES	(21*32+ 6) /* Heterogeneous Core Topology */
 #define X86_FEATURE_AMD_WORKLOAD_CLASS	(21*32+ 7) /* Workload Classification */
 #define X86_FEATURE_PREFER_YMM		(21*32+ 8) /* Avoid ZMM registers due to downclocking */
 

