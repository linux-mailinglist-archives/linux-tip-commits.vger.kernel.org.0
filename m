Return-Path: <linux-tip-commits+bounces-5881-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 270FFAE2B46
	for <lists+linux-tip-commits@lfdr.de>; Sat, 21 Jun 2025 20:52:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AF16A3B07A9
	for <lists+linux-tip-commits@lfdr.de>; Sat, 21 Jun 2025 18:51:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 172EE221FCF;
	Sat, 21 Jun 2025 18:52:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="qd+BSnWz";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="d3l4iGdy"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEA1C215F72;
	Sat, 21 Jun 2025 18:52:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750531931; cv=none; b=g4TRgbu7OyAzpcIMnQdJW7r+51jZ0QD4cutSe52CntLK6/kslm88e/F6NdVu1rY7anhpNV3yS3gbB1weBg9MArzczJip5/0l1zPUuYvrkkXkjUZ6pLBtBFQ7EKKCYU598J7b/jSiVgnhwKm97nfY4abgX4//oprzLDNrHeLLxmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750531931; c=relaxed/simple;
	bh=du5tvO7Li2+pLdqMqCURWDWSYTvThc6+FWKILHM1KS0=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=HRrT7XUoG2gdW8Gnx5U47EdaBD4g4xjoX4BTMXV3SPXb4M2qPb5KOSraO5af6wcxZzy9DRA/8KFpg7WrtGStukDvIOGy0vTOf1kxYd9QNunWVWXSrsHMl6pHfOW9nkMnTSdD9vKyhM2OjgkZCEo3LhRJ0srUOTIkRDyNkI8wXZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=qd+BSnWz; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=d3l4iGdy; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sat, 21 Jun 2025 18:52:05 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1750531926;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=k/HXwOw6cbW5nt22tty6Sl98jnGVpBaI64y4RgrfXVA=;
	b=qd+BSnWzcx8ngKt36mtMS9tFZg++qo40H3DV7VsgA2MGsKYUhshx8c6pyTbEY1uWTiRil+
	67gkzoGX940Bo193GYPHax0WylsF/r2+G31PGXyRwzoa2uKFLowEglkZN8jMvI2Z3/htX7
	83F3q7pU/9FieZn0L624esoOxLPJVrdLStRXsgCAvf18k/ck46ppOmLQPfO1PH3sW3Pxpn
	zhiKFHsBcxSScAi10gwleAPGPYnUCuRt5fPCBhH+vOec1hibBXudNGJD8LkjICLchj+Z79
	uGKktaB2Xvuj6BL6ylCcXO39F1zyVhrI86F76QupjNFtk9aKbXzRJ3WijYRykw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1750531926;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=k/HXwOw6cbW5nt22tty6Sl98jnGVpBaI64y4RgrfXVA=;
	b=d3l4iGdymIhjichFn60YMfWktFw7WkPdAJKB3oU7ah5fkmKgyj/fOI5HQFXxCUJerc8jrj
	WJ5GKdOSvNYUkvDA==
From: "tip-bot2 for Borislav Petkov (AMD)" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cpu] x86/CPU/AMD: Add CPUID faulting support
Cc: "Borislav Petkov (AMD)" <bp@alien8.de>,
 Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250528213105.1149-1-bp@kernel.org>
References: <20250528213105.1149-1-bp@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175053192543.406.1923423835308666303.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/cpu branch of tip:

Commit-ID:     65f55a30176662ee37fe18b47430ee30b57bfc98
Gitweb:        https://git.kernel.org/tip/65f55a30176662ee37fe18b47430ee30b57bfc98
Author:        Borislav Petkov (AMD) <bp@alien8.de>
AuthorDate:    Wed, 28 May 2025 23:31:05 +02:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Sat, 21 Jun 2025 20:30:26 +02:00

x86/CPU/AMD: Add CPUID faulting support

Add CPUID faulting support on AMD using the same user interface.

Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/20250528213105.1149-1-bp@kernel.org
---
 arch/x86/include/asm/cpufeatures.h |  3 +++
 arch/x86/include/asm/msr-index.h   |  1 +
 arch/x86/kernel/cpu/amd.c          |  4 ++++
 arch/x86/kernel/process.c          | 20 ++++++++++++++------
 4 files changed, 22 insertions(+), 6 deletions(-)

diff --git a/arch/x86/include/asm/cpufeatures.h b/arch/x86/include/asm/cpufeatures.h
index ee17623..b78af55 100644
--- a/arch/x86/include/asm/cpufeatures.h
+++ b/arch/x86/include/asm/cpufeatures.h
@@ -457,9 +457,12 @@
 #define X86_FEATURE_WRMSR_XX_BASE_NS	(20*32+ 1) /* WRMSR to {FS,GS,KERNEL_GS}_BASE is non-serializing */
 #define X86_FEATURE_LFENCE_RDTSC	(20*32+ 2) /* LFENCE always serializing / synchronizes RDTSC */
 #define X86_FEATURE_NULL_SEL_CLR_BASE	(20*32+ 6) /* Null Selector Clears Base */
+
 #define X86_FEATURE_AUTOIBRS		(20*32+ 8) /* Automatic IBRS */
 #define X86_FEATURE_NO_SMM_CTL_MSR	(20*32+ 9) /* SMM_CTL MSR is not present */
 
+#define X86_FEATURE_GP_ON_USER_CPUID	(20*32+17) /* User CPUID faulting */
+
 #define X86_FEATURE_PREFETCHI		(20*32+20) /* Prefetch Data/Instruction to Cache Level */
 #define X86_FEATURE_SBPB		(20*32+27) /* Selective Branch Prediction Barrier */
 #define X86_FEATURE_IBPB_BRTYPE		(20*32+28) /* MSR_PRED_CMD[IBPB] flushes all branch type predictions */
diff --git a/arch/x86/include/asm/msr-index.h b/arch/x86/include/asm/msr-index.h
index b7dded3..ff7e974 100644
--- a/arch/x86/include/asm/msr-index.h
+++ b/arch/x86/include/asm/msr-index.h
@@ -830,6 +830,7 @@
 #define MSR_K7_HWCR_SMMLOCK		BIT_ULL(MSR_K7_HWCR_SMMLOCK_BIT)
 #define MSR_K7_HWCR_IRPERF_EN_BIT	30
 #define MSR_K7_HWCR_IRPERF_EN		BIT_ULL(MSR_K7_HWCR_IRPERF_EN_BIT)
+#define MSR_K7_HWCR_CPUID_USER_DIS_BIT	35
 #define MSR_K7_FID_VID_CTL		0xc0010041
 #define MSR_K7_FID_VID_STATUS		0xc0010042
 #define MSR_K7_HWCR_CPB_DIS_BIT		25
diff --git a/arch/x86/kernel/cpu/amd.c b/arch/x86/kernel/cpu/amd.c
index 93da466..50f88fe 100644
--- a/arch/x86/kernel/cpu/amd.c
+++ b/arch/x86/kernel/cpu/amd.c
@@ -489,6 +489,10 @@ static void bsp_init_amd(struct cpuinfo_x86 *c)
 	}
 
 	bsp_determine_snp(c);
+
+	if (cpu_has(c, X86_FEATURE_GP_ON_USER_CPUID))
+		setup_force_cpu_cap(X86_FEATURE_CPUID_FAULT);
+
 	return;
 
 warn:
diff --git a/arch/x86/kernel/process.c b/arch/x86/kernel/process.c
index 704883c..7b94851 100644
--- a/arch/x86/kernel/process.c
+++ b/arch/x86/kernel/process.c
@@ -334,13 +334,21 @@ DEFINE_PER_CPU(u64, msr_misc_features_shadow);
 
 static void set_cpuid_faulting(bool on)
 {
-	u64 msrval;
 
-	msrval = this_cpu_read(msr_misc_features_shadow);
-	msrval &= ~MSR_MISC_FEATURES_ENABLES_CPUID_FAULT;
-	msrval |= (on << MSR_MISC_FEATURES_ENABLES_CPUID_FAULT_BIT);
-	this_cpu_write(msr_misc_features_shadow, msrval);
-	wrmsrq(MSR_MISC_FEATURES_ENABLES, msrval);
+	if (boot_cpu_data.x86_vendor == X86_VENDOR_INTEL) {
+		u64 msrval;
+
+		msrval = this_cpu_read(msr_misc_features_shadow);
+		msrval &= ~MSR_MISC_FEATURES_ENABLES_CPUID_FAULT;
+		msrval |= (on << MSR_MISC_FEATURES_ENABLES_CPUID_FAULT_BIT);
+		this_cpu_write(msr_misc_features_shadow, msrval);
+		wrmsrq(MSR_MISC_FEATURES_ENABLES, msrval);
+	} else if (boot_cpu_data.x86_vendor == X86_VENDOR_AMD) {
+		if (on)
+			msr_set_bit(MSR_K7_HWCR, MSR_K7_HWCR_CPUID_USER_DIS_BIT);
+		else
+			msr_clear_bit(MSR_K7_HWCR, MSR_K7_HWCR_CPUID_USER_DIS_BIT);
+	}
 }
 
 static void disable_cpuid(void)

