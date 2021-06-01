Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D9A0397AA9
	for <lists+linux-tip-commits@lfdr.de>; Tue,  1 Jun 2021 21:23:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234671AbhFATZP (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Tue, 1 Jun 2021 15:25:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234539AbhFATZP (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Tue, 1 Jun 2021 15:25:15 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14BF5C061574;
        Tue,  1 Jun 2021 12:23:33 -0700 (PDT)
Date:   Tue, 01 Jun 2021 19:23:27 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1622575409;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=sxCSdpFRtrgxrKSeiwck9rPJUmddxOlUbySrg0xuHOw=;
        b=Nn7pax/Mu33FGrXe0z9F61toZ9Or1bj+2urpJq2CW0sle7jMNlnP9CvaPXukgZy1yjqJGA
        0yoO4kZ1BkwBpdLzvXS4VHnw/Cmu/DcXQ2LxvELJgw7oaN/ofC2Wtt4CTz83sTOpEw0T8x
        /e17thJbbOX3SAcUvhX2JDDjXLpMD4I8KynKIRByqrnanTbuSSVNXUfrVMcIs32DJW0H5N
        D2c6mkrdr0HwlznbfajPnMvL0utPIA6JEqugcYMVYDwm7dR0cER3tjttGHyLxc6aWoBeEw
        uautc+p5c8HPKtFTOE39hFsFPudRIU4SbZYhO+kZZsOfSCXZnZAGBE7m3aESYA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1622575409;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=sxCSdpFRtrgxrKSeiwck9rPJUmddxOlUbySrg0xuHOw=;
        b=BpfSRaGzI6IvzNpQU1dv5YRkI7PLNGsfIaZRlK49DrXcaD2p1nu6gslKMMV02AQKbfdXCM
        2tDVLqXEDIXavVCQ==
From:   "tip-bot2 for Andrew Cooper" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cpu] perf/x86/rapl: Use CPUID bit on AMD and Hygon parts
Cc:     Andrew Cooper <andrew.cooper3@citrix.com>,
        Borislav Petkov <bp@suse.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210514135920.16093-1-andrew.cooper3@citrix.com>
References: <20210514135920.16093-1-andrew.cooper3@citrix.com>
MIME-Version: 1.0
Message-ID: <162257540743.29796.5658741433704678582.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/cpu branch of tip:

Commit-ID:     cbcddaa33d7e11a053cb80a4a635c023b4f8b906
Gitweb:        https://git.kernel.org/tip/cbcddaa33d7e11a053cb80a4a635c023b4f8b906
Author:        Andrew Cooper <andrew.cooper3@citrix.com>
AuthorDate:    Fri, 14 May 2021 14:59:20 +01:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Tue, 01 Jun 2021 21:10:33 +02:00

perf/x86/rapl: Use CPUID bit on AMD and Hygon parts

AMD and Hygon CPUs have a CPUID bit for RAPL.  Drop the fam17h suffix as
it is stale already.

Make use of this instead of a model check to work more nicely in virtual
environments where RAPL typically isn't available.

 [ bp: drop the ../cpu/powerflags.c hunk which is superfluous as the
   "rapl" bit name appears already in flags. ]

Signed-off-by: Andrew Cooper <andrew.cooper3@citrix.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lkml.kernel.org/r/20210514135920.16093-1-andrew.cooper3@citrix.com
---
 arch/x86/events/rapl.c             | 6 ++----
 arch/x86/include/asm/cpufeatures.h | 2 +-
 arch/x86/kernel/cpu/amd.c          | 4 ++++
 arch/x86/kernel/cpu/hygon.c        | 4 ++++
 4 files changed, 11 insertions(+), 5 deletions(-)

diff --git a/arch/x86/events/rapl.c b/arch/x86/events/rapl.c
index 84a1042..85feafa 100644
--- a/arch/x86/events/rapl.c
+++ b/arch/x86/events/rapl.c
@@ -764,13 +764,14 @@ static struct rapl_model model_spr = {
 	.rapl_msrs      = intel_rapl_spr_msrs,
 };
 
-static struct rapl_model model_amd_fam17h = {
+static struct rapl_model model_amd_hygon = {
 	.events		= BIT(PERF_RAPL_PKG),
 	.msr_power_unit = MSR_AMD_RAPL_POWER_UNIT,
 	.rapl_msrs      = amd_rapl_msrs,
 };
 
 static const struct x86_cpu_id rapl_model_match[] __initconst = {
+	X86_MATCH_FEATURE(X86_FEATURE_RAPL,		&model_amd_hygon),
 	X86_MATCH_INTEL_FAM6_MODEL(SANDYBRIDGE,		&model_snb),
 	X86_MATCH_INTEL_FAM6_MODEL(SANDYBRIDGE_X,	&model_snbep),
 	X86_MATCH_INTEL_FAM6_MODEL(IVYBRIDGE,		&model_snb),
@@ -803,9 +804,6 @@ static const struct x86_cpu_id rapl_model_match[] __initconst = {
 	X86_MATCH_INTEL_FAM6_MODEL(ALDERLAKE,		&model_skl),
 	X86_MATCH_INTEL_FAM6_MODEL(ALDERLAKE_L,		&model_skl),
 	X86_MATCH_INTEL_FAM6_MODEL(SAPPHIRERAPIDS_X,	&model_spr),
-	X86_MATCH_VENDOR_FAM(AMD,	0x17,		&model_amd_fam17h),
-	X86_MATCH_VENDOR_FAM(HYGON,	0x18,		&model_amd_fam17h),
-	X86_MATCH_VENDOR_FAM(AMD,	0x19,		&model_amd_fam17h),
 	{},
 };
 MODULE_DEVICE_TABLE(x86cpu, rapl_model_match);
diff --git a/arch/x86/include/asm/cpufeatures.h b/arch/x86/include/asm/cpufeatures.h
index ac37830..81269c7 100644
--- a/arch/x86/include/asm/cpufeatures.h
+++ b/arch/x86/include/asm/cpufeatures.h
@@ -108,7 +108,7 @@
 #define X86_FEATURE_EXTD_APICID		( 3*32+26) /* Extended APICID (8 bits) */
 #define X86_FEATURE_AMD_DCM		( 3*32+27) /* AMD multi-node processor */
 #define X86_FEATURE_APERFMPERF		( 3*32+28) /* P-State hardware coordination feedback capability (APERF/MPERF MSRs) */
-/* free					( 3*32+29) */
+#define X86_FEATURE_RAPL		( 3*32+29) /* AMD/Hygon RAPL interface */
 #define X86_FEATURE_NONSTOP_TSC_S3	( 3*32+30) /* TSC doesn't stop in S3 state */
 #define X86_FEATURE_TSC_KNOWN_FREQ	( 3*32+31) /* TSC has known frequency */
 
diff --git a/arch/x86/kernel/cpu/amd.c b/arch/x86/kernel/cpu/amd.c
index 2d11384..da57b96 100644
--- a/arch/x86/kernel/cpu/amd.c
+++ b/arch/x86/kernel/cpu/amd.c
@@ -646,6 +646,10 @@ static void early_init_amd(struct cpuinfo_x86 *c)
 	if (c->x86_power & BIT(12))
 		set_cpu_cap(c, X86_FEATURE_ACC_POWER);
 
+	/* Bit 14 indicates the Runtime Average Power Limit interface. */
+	if (c->x86_power & BIT(14))
+		set_cpu_cap(c, X86_FEATURE_RAPL);
+
 #ifdef CONFIG_X86_64
 	set_cpu_cap(c, X86_FEATURE_SYSCALL32);
 #else
diff --git a/arch/x86/kernel/cpu/hygon.c b/arch/x86/kernel/cpu/hygon.c
index 0bd6c74..6d50136 100644
--- a/arch/x86/kernel/cpu/hygon.c
+++ b/arch/x86/kernel/cpu/hygon.c
@@ -260,6 +260,10 @@ static void early_init_hygon(struct cpuinfo_x86 *c)
 	if (c->x86_power & BIT(12))
 		set_cpu_cap(c, X86_FEATURE_ACC_POWER);
 
+	/* Bit 14 indicates the Runtime Average Power Limit interface. */
+	if (c->x86_power & BIT(14))
+		set_cpu_cap(c, X86_FEATURE_RAPL);
+
 #ifdef CONFIG_X86_64
 	set_cpu_cap(c, X86_FEATURE_SYSCALL32);
 #endif
