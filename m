Return-Path: <linux-tip-commits+bounces-5191-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D0C8BAA6FC7
	for <lists+linux-tip-commits@lfdr.de>; Fri,  2 May 2025 12:35:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 752CE1BC1F58
	for <lists+linux-tip-commits@lfdr.de>; Fri,  2 May 2025 10:35:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6480254860;
	Fri,  2 May 2025 10:33:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="HdL5pGyG";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="1AKKLqPp"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91D5A24E4BF;
	Fri,  2 May 2025 10:33:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746182017; cv=none; b=W2+jxZQz+khoMS8/tCNv8SWevdlFZ7olrI8Jz0UnvxPHstXQ+0u7ZnxgFreIZV2mIRLXSrUs/fGWsZ82oGy6opLl7XOn7zOLH7HbLS6TbRfdcQqRdZ3ntxfCirIL2sbVm1+PXIwOuXK3q0nyyYqZZc/JZZDYEam5nCcluCFWOGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746182017; c=relaxed/simple;
	bh=L4vC9bWNxL+S4chDJmWcHY1drPGjay9g2ojtPOyRcfQ=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=KZblP+wnkTCBahYF0GKyWGqoDRXY3RjD85sulwn6Q0aRX91Np/5D1YAVuRkvIKz/qfPFSlVPH8XTEyUVK9csWMg+ndKbaXKeT3SGGhzIgEoPH6Nwvbp/0z2NdVDQfZSqgvJMu7LkJwDCWjqmcOhqghPS8PZX3uiJ3GW5wKV2aDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=HdL5pGyG; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=1AKKLqPp; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 02 May 2025 10:33:33 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1746182013;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MdFLoYUsFQz1Se0Ol21mGCf4ZBJB49bZB1eMmYbd7kc=;
	b=HdL5pGyGbYeGeezsrSfw6tXuEGamJX7JFNdE0flLIPrQdLFBuKzw0ZWzXqKFuyxvsgtpa3
	nLgp+8HTM1rKy4SiK0OH56W9cmhABmvqOUT+XetIZs8kd105Wc3um7KEC7MYDPgDaNTgAK
	XeftSdjAy/ZmXG21CCJ88AiH+vyY+KpyrT98IUe7RY47uleodTYQ/4qpkFk+CnnIFmu1Co
	m9dDhPEM+21XwBgErewTvaB+4NYzLArmWeybxbbRvHnmkfrVRqj55v/AljJOK4ryErNa1y
	eeUUu5U6JU5UwWWROnH/TJqNA/Uz3wk48c0Mx++oI8gRvn1lZInZNNR2Vz0dLA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1746182013;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MdFLoYUsFQz1Se0Ol21mGCf4ZBJB49bZB1eMmYbd7kc=;
	b=1AKKLqPp3uQGZgfbdnKRSdkkqtY4PwNNVyTDQ60Is8lvu/X61gY4rXTUoXlj3NXa9lmDyl
	j4iUKi7GqiQkxdDQ==
From: "tip-bot2 for David Kaplan" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/bugs] x86/bugs: Restructure TAA mitigation
Cc: David Kaplan <david.kaplan@amd.com>,
 "Borislav Petkov (AMD)" <bp@alien8.de>, Josh Poimboeuf <jpoimboe@kernel.org>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250418161721.1855190-3-david.kaplan@amd.com>
References: <20250418161721.1855190-3-david.kaplan@amd.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174618201306.22196.13862047472534777814.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/bugs branch of tip:

Commit-ID:     bdd7fce7a8168cebd400926d6352d2fbc1ac9f79
Gitweb:        https://git.kernel.org/tip/bdd7fce7a8168cebd400926d6352d2fbc1ac9f79
Author:        David Kaplan <david.kaplan@amd.com>
AuthorDate:    Fri, 18 Apr 2025 11:17:07 -05:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Mon, 28 Apr 2025 13:02:04 +02:00

x86/bugs: Restructure TAA mitigation

Restructure TAA mitigation to use select/update/apply functions to
create consistent vulnerability handling.

Signed-off-by: David Kaplan <david.kaplan@amd.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Josh Poimboeuf <jpoimboe@kernel.org>
Link: https://lore.kernel.org/20250418161721.1855190-3-david.kaplan@amd.com
---
 arch/x86/kernel/cpu/bugs.c | 94 +++++++++++++++++++++++--------------
 1 file changed, 59 insertions(+), 35 deletions(-)

diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index f697e6b..5db21d2 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -65,6 +65,8 @@ static void __init mds_apply_mitigation(void);
 static void __init md_clear_update_mitigation(void);
 static void __init md_clear_select_mitigation(void);
 static void __init taa_select_mitigation(void);
+static void __init taa_update_mitigation(void);
+static void __init taa_apply_mitigation(void);
 static void __init mmio_select_mitigation(void);
 static void __init srbds_select_mitigation(void);
 static void __init l1d_flush_select_mitigation(void);
@@ -194,6 +196,7 @@ void __init cpu_select_mitigations(void)
 	ssb_select_mitigation();
 	l1tf_select_mitigation();
 	mds_select_mitigation();
+	taa_select_mitigation();
 	md_clear_select_mitigation();
 	srbds_select_mitigation();
 	l1d_flush_select_mitigation();
@@ -210,8 +213,10 @@ void __init cpu_select_mitigations(void)
 	 * choices.
 	 */
 	mds_update_mitigation();
+	taa_update_mitigation();
 
 	mds_apply_mitigation();
+	taa_apply_mitigation();
 }
 
 /*
@@ -397,6 +402,11 @@ static const char * const taa_strings[] = {
 	[TAA_MITIGATION_TSX_DISABLED]	= "Mitigation: TSX disabled",
 };
 
+static bool __init taa_vulnerable(void)
+{
+	return boot_cpu_has_bug(X86_BUG_TAA) && boot_cpu_has(X86_FEATURE_RTM);
+}
+
 static void __init taa_select_mitigation(void)
 {
 	if (!boot_cpu_has_bug(X86_BUG_TAA)) {
@@ -410,48 +420,63 @@ static void __init taa_select_mitigation(void)
 		return;
 	}
 
-	if (cpu_mitigations_off()) {
+	if (cpu_mitigations_off())
 		taa_mitigation = TAA_MITIGATION_OFF;
-		return;
-	}
 
-	/*
-	 * TAA mitigation via VERW is turned off if both
-	 * tsx_async_abort=off and mds=off are specified.
-	 */
-	if (taa_mitigation == TAA_MITIGATION_OFF &&
-	    mds_mitigation == MDS_MITIGATION_OFF)
+	/* Microcode will be checked in taa_update_mitigation(). */
+	if (taa_mitigation == TAA_MITIGATION_AUTO)
+		taa_mitigation = TAA_MITIGATION_VERW;
+
+	if (taa_mitigation != TAA_MITIGATION_OFF)
+		verw_clear_cpu_buf_mitigation_selected = true;
+}
+
+static void __init taa_update_mitigation(void)
+{
+	if (!taa_vulnerable() || cpu_mitigations_off())
 		return;
 
-	if (boot_cpu_has(X86_FEATURE_MD_CLEAR))
+	if (verw_clear_cpu_buf_mitigation_selected)
 		taa_mitigation = TAA_MITIGATION_VERW;
-	else
-		taa_mitigation = TAA_MITIGATION_UCODE_NEEDED;
 
-	/*
-	 * VERW doesn't clear the CPU buffers when MD_CLEAR=1 and MDS_NO=1.
-	 * A microcode update fixes this behavior to clear CPU buffers. It also
-	 * adds support for MSR_IA32_TSX_CTRL which is enumerated by the
-	 * ARCH_CAP_TSX_CTRL_MSR bit.
-	 *
-	 * On MDS_NO=1 CPUs if ARCH_CAP_TSX_CTRL_MSR is not set, microcode
-	 * update is required.
-	 */
-	if ( (x86_arch_cap_msr & ARCH_CAP_MDS_NO) &&
-	    !(x86_arch_cap_msr & ARCH_CAP_TSX_CTRL_MSR))
-		taa_mitigation = TAA_MITIGATION_UCODE_NEEDED;
+	if (taa_mitigation == TAA_MITIGATION_VERW) {
+		/* Check if the requisite ucode is available. */
+		if (!boot_cpu_has(X86_FEATURE_MD_CLEAR))
+			taa_mitigation = TAA_MITIGATION_UCODE_NEEDED;
 
-	/*
-	 * TSX is enabled, select alternate mitigation for TAA which is
-	 * the same as MDS. Enable MDS static branch to clear CPU buffers.
-	 *
-	 * For guests that can't determine whether the correct microcode is
-	 * present on host, enable the mitigation for UCODE_NEEDED as well.
-	 */
-	setup_force_cpu_cap(X86_FEATURE_CLEAR_CPU_BUF);
+		/*
+		 * VERW doesn't clear the CPU buffers when MD_CLEAR=1 and MDS_NO=1.
+		 * A microcode update fixes this behavior to clear CPU buffers. It also
+		 * adds support for MSR_IA32_TSX_CTRL which is enumerated by the
+		 * ARCH_CAP_TSX_CTRL_MSR bit.
+		 *
+		 * On MDS_NO=1 CPUs if ARCH_CAP_TSX_CTRL_MSR is not set, microcode
+		 * update is required.
+		 */
+		if ((x86_arch_cap_msr & ARCH_CAP_MDS_NO) &&
+		   !(x86_arch_cap_msr & ARCH_CAP_TSX_CTRL_MSR))
+			taa_mitigation = TAA_MITIGATION_UCODE_NEEDED;
+	}
 
-	if (taa_nosmt || cpu_mitigations_auto_nosmt())
-		cpu_smt_disable(false);
+	pr_info("%s\n", taa_strings[taa_mitigation]);
+}
+
+static void __init taa_apply_mitigation(void)
+{
+	if (taa_mitigation == TAA_MITIGATION_VERW ||
+	    taa_mitigation == TAA_MITIGATION_UCODE_NEEDED) {
+		/*
+		 * TSX is enabled, select alternate mitigation for TAA which is
+		 * the same as MDS. Enable MDS static branch to clear CPU buffers.
+		 *
+		 * For guests that can't determine whether the correct microcode is
+		 * present on host, enable the mitigation for UCODE_NEEDED as well.
+		 */
+		setup_force_cpu_cap(X86_FEATURE_CLEAR_CPU_BUF);
+
+		if (taa_nosmt || cpu_mitigations_auto_nosmt())
+			cpu_smt_disable(false);
+	}
 }
 
 static int __init tsx_async_abort_parse_cmdline(char *str)
@@ -660,7 +685,6 @@ out:
 
 static void __init md_clear_select_mitigation(void)
 {
-	taa_select_mitigation();
 	mmio_select_mitigation();
 	rfds_select_mitigation();
 

