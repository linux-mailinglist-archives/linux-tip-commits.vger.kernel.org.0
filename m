Return-Path: <linux-tip-commits+bounces-1319-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EBC88D6958
	for <lists+linux-tip-commits@lfdr.de>; Fri, 31 May 2024 21:02:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D9D50283C1A
	for <lists+linux-tip-commits@lfdr.de>; Fri, 31 May 2024 19:02:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3397A219FD;
	Fri, 31 May 2024 19:02:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="LL20CsDh";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="JYEK0UrY"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 653C61E498;
	Fri, 31 May 2024 19:02:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717182127; cv=none; b=F3NlhvcQrFKWtB0uC0fePxEmPga6Yp8xgt/SJzH1c2Cp1t5QJwXmY+8LPGFrRiCpo65tU0rDOKDUxIvED5Ja6r7Uw4B9CMd0uZdW7wvmIZh1qtHX1eMnGwYzNigNypVTTaaRxlNGzeEcOBdPue7KN7yjODCe96dvX/eHWYLC88I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717182127; c=relaxed/simple;
	bh=4/qrFOt0J60H9Q8gZg1QzL1Ob0AeG1+br64Pzy1aoLk=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=EGG9F2rNalK7CkQ2FVB5MGjqHM21JIov6lznJLvStKgQO3yIeWFbXCgmJDXbkn1GerqSzbjDrFa+aSzyuwLOr6lB/i9d4VdzpSLJXvnPmiy1z94/+CDfxU/5nOABVDWHHWPBSxsmUs1Ol8URzlWyhVz+l+6e1G0RD8W2YrkfOr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=LL20CsDh; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=JYEK0UrY; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 31 May 2024 19:02:02 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1717182123;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=y9MJU17Ekc/uxv5y4w6TjvOm/CdW/nFdhox3LjTYtqY=;
	b=LL20CsDhcM4mVsDIzcaCBCynrd2qG5CAq5x7IV8yaT+1HGEITbGXiZCJ4hzqTIh2QqxsZa
	e7k6sd8rXsGuj4dgj00dIcDnBcPVNd0eVstqFag5/x45fjdqU6HNFc/eATjrGCHoekCOxz
	/w4Yz/9Z5j0r45oykKpw6NidfCIfnvM5M0VyYbX/3EG9mI/0BfiXajI6iNkqXO0uCva3hV
	tCHwUVTi9Ml5PFfrthpyK9LHOhPj5WjzwYyMQPFvlTHlbVLi2AG9HmJCTyxYor3pQfcJ+b
	EgkG03+MdqOw4BrJ9ELHF6OxTL1N7twB5ArbXb5wnXzqtOXfHC+d65dgfJ7Wxg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1717182123;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=y9MJU17Ekc/uxv5y4w6TjvOm/CdW/nFdhox3LjTYtqY=;
	b=JYEK0UrY1N5PXVSy9GlG46i4XPXU2CNgWNetyJmzxNa1P8OPoLo/1vbY7Yx9KfRQKHuSzV
	gBOwzVmAEsvx1DBw==
From: "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: x86/urgent] x86/topology/intel: Unlock CPUID before evaluating anything
Cc: Peter Schneider <pschneider1968@googlemail.com>,
 Thomas Gleixner <tglx@linutronix.de>, "Borislav Petkov (AMD)" <bp@alien8.de>,
  <stable@kernel.org>, x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <fd3f73dc-a86f-4bcf-9c60-43556a21eb42@googlemail.com>
References: <fd3f73dc-a86f-4bcf-9c60-43556a21eb42@googlemail.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171718212254.10875.16204655017704621999.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     0c2f6d04619ec2b53ad4b0b591eafc9389786e86
Gitweb:        https://git.kernel.org/tip/0c2f6d04619ec2b53ad4b0b591eafc9389786e86
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Thu, 30 May 2024 17:29:18 +02:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Fri, 31 May 2024 20:25:56 +02:00

x86/topology/intel: Unlock CPUID before evaluating anything

Intel CPUs have a MSR bit to limit CPUID enumeration to leaf two. If
this bit is set by the BIOS then CPUID evaluation including topology
enumeration does not work correctly as the evaluation code does not try
to analyze any leaf greater than two.

This went unnoticed before because the original topology code just
repeated evaluation several times and managed to overwrite the initial
limited information with the correct one later. The new evaluation code
does it once and therefore ends up with the limited and wrong
information.

Cure this by unlocking CPUID right before evaluating anything which
depends on the maximum CPUID leaf being greater than two instead of
rereading stuff after unlock.

Fixes: 22d63660c35e ("x86/cpu: Use common topology code for Intel")
Reported-by: Peter Schneider <pschneider1968@googlemail.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Tested-by: Peter Schneider <pschneider1968@googlemail.com>
Cc: <stable@kernel.org>
Link: https://lore.kernel.org/r/fd3f73dc-a86f-4bcf-9c60-43556a21eb42@googlemail.com
---
 arch/x86/kernel/cpu/common.c |  3 ++-
 arch/x86/kernel/cpu/cpu.h    |  2 ++
 arch/x86/kernel/cpu/intel.c  | 25 ++++++++++++++++---------
 3 files changed, 20 insertions(+), 10 deletions(-)

diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index e31293c..d4e539d 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -1589,6 +1589,7 @@ static void __init early_identify_cpu(struct cpuinfo_x86 *c)
 	if (have_cpuid_p()) {
 		cpu_detect(c);
 		get_cpu_vendor(c);
+		intel_unlock_cpuid_leafs(c);
 		get_cpu_cap(c);
 		setup_force_cpu_cap(X86_FEATURE_CPUID);
 		get_cpu_address_sizes(c);
@@ -1748,7 +1749,7 @@ static void generic_identify(struct cpuinfo_x86 *c)
 	cpu_detect(c);
 
 	get_cpu_vendor(c);
-
+	intel_unlock_cpuid_leafs(c);
 	get_cpu_cap(c);
 
 	get_cpu_address_sizes(c);
diff --git a/arch/x86/kernel/cpu/cpu.h b/arch/x86/kernel/cpu/cpu.h
index ea9e07d..1beccef 100644
--- a/arch/x86/kernel/cpu/cpu.h
+++ b/arch/x86/kernel/cpu/cpu.h
@@ -61,9 +61,11 @@ extern __ro_after_init enum tsx_ctrl_states tsx_ctrl_state;
 
 extern void __init tsx_init(void);
 void tsx_ap_init(void);
+void intel_unlock_cpuid_leafs(struct cpuinfo_x86 *c);
 #else
 static inline void tsx_init(void) { }
 static inline void tsx_ap_init(void) { }
+static inline void intel_unlock_cpuid_leafs(struct cpuinfo_x86 *c) { }
 #endif /* CONFIG_CPU_SUP_INTEL */
 
 extern void init_spectral_chicken(struct cpuinfo_x86 *c);
diff --git a/arch/x86/kernel/cpu/intel.c b/arch/x86/kernel/cpu/intel.c
index 3c3e7e5..fdf3489 100644
--- a/arch/x86/kernel/cpu/intel.c
+++ b/arch/x86/kernel/cpu/intel.c
@@ -269,19 +269,26 @@ detect_keyid_bits:
 	c->x86_phys_bits -= keyid_bits;
 }
 
+void intel_unlock_cpuid_leafs(struct cpuinfo_x86 *c)
+{
+	if (boot_cpu_data.x86_vendor != X86_VENDOR_INTEL)
+		return;
+
+	if (c->x86 < 6 || (c->x86 == 6 && c->x86_model < 0xd))
+		return;
+
+	/*
+	 * The BIOS can have limited CPUID to leaf 2, which breaks feature
+	 * enumeration. Unlock it and update the maximum leaf info.
+	 */
+	if (msr_clear_bit(MSR_IA32_MISC_ENABLE, MSR_IA32_MISC_ENABLE_LIMIT_CPUID_BIT) > 0)
+		c->cpuid_level = cpuid_eax(0);
+}
+
 static void early_init_intel(struct cpuinfo_x86 *c)
 {
 	u64 misc_enable;
 
-	/* Unmask CPUID levels if masked: */
-	if (c->x86 > 6 || (c->x86 == 6 && c->x86_model >= 0xd)) {
-		if (msr_clear_bit(MSR_IA32_MISC_ENABLE,
-				  MSR_IA32_MISC_ENABLE_LIMIT_CPUID_BIT) > 0) {
-			c->cpuid_level = cpuid_eax(0);
-			get_cpu_cap(c);
-		}
-	}
-
 	if ((c->x86 == 0xf && c->x86_model >= 0x03) ||
 		(c->x86 == 0x6 && c->x86_model >= 0x0e))
 		set_cpu_cap(c, X86_FEATURE_CONSTANT_TSC);

