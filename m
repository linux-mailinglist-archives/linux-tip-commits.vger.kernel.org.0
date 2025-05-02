Return-Path: <linux-tip-commits+bounces-5187-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 70C5DAA6FBF
	for <lists+linux-tip-commits@lfdr.de>; Fri,  2 May 2025 12:34:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CE3479C474D
	for <lists+linux-tip-commits@lfdr.de>; Fri,  2 May 2025 10:33:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B034424501C;
	Fri,  2 May 2025 10:33:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="oqhRY8ht";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Xa5MSKYb"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C734A2417E6;
	Fri,  2 May 2025 10:33:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746182013; cv=none; b=Ww0LS0VA22f4sFb/i1E5+EFJO0xBdGY3QLsEtgEBhEa1poNN+ehn1PiS3M5mSpTAE4IG1Os9OM27IK0TJn24jr1HJrq44lWgrQAFAGLdqS628piP/rk/DsBZdLDY62KPzaAFYKxWrHceoMR4icIp4/v+QktQP8KaQXV/hBHI1Tk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746182013; c=relaxed/simple;
	bh=nUaOatvLddovX68ukj37PNdiJIh8Ft8U3bud5ex3TpA=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=dVC6Vn+8hdwOVuLvGw/sAFDoKQFRgRkif8QvK8u+du78n5gnmaQpH/IhVRrPhUDkdw/dg66o0oPqbN9C+3owClmQ94bVByRg5sH7xpvSSkrjabeUJEtc01cv3MEo/JPq901vhIbcr1aK9BFeutpF65d+Um/vFaYk6GvgY7bAQQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=oqhRY8ht; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Xa5MSKYb; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 02 May 2025 10:33:29 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1746182010;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TmioW45b3uPsFC1rhlMTLJ1izYcnlHPSmxFQzvPlLaA=;
	b=oqhRY8hteyJP6n/93DQueYpk3X2WaAhcFCeu3hM97xaWjoUl2c2y3SZhjwOOgBts5xmPhh
	OemFkA6R/GSQjyA8UpIjRZORWuF4ZhnEdsn3eoDKAHbUyaWNdMDokTsvmvZ5yRc+RpSDty
	4nKZZ0XgaChGGndxLfq2RN5PQCQtpkUyTcWNoHLPlZgK0S+Za+CQDmYk3fGtWZDsBx09qe
	QFgxRlxhs9B6U90sp0p00M/f3rAfZZEoF3Ylwv4m/rNCvkCiNFo99pyfK4zJiU9rcMEAiA
	Nlo2JeuGQF+PHSFd66bH8iuCXPDoSirWVZjci5jte4G/KXH6DlgwHGDEROgwFA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1746182010;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TmioW45b3uPsFC1rhlMTLJ1izYcnlHPSmxFQzvPlLaA=;
	b=Xa5MSKYb6VWUA+P0Q7BPR526Q2RZsmGLCEeXbtU6fIRl9dd8xLNY4T8j3t0zHuFK3pEw2z
	sXi3a6g7SiDRUJBA==
From: "tip-bot2 for David Kaplan" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/bugs] x86/bugs: Restructure GDS mitigation
Cc: David Kaplan <david.kaplan@amd.com>,
 "Borislav Petkov (AMD)" <bp@alien8.de>, Josh Poimboeuf <jpoimboe@kernel.org>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250418161721.1855190-8-david.kaplan@amd.com>
References: <20250418161721.1855190-8-david.kaplan@amd.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174618200944.22196.1468944465181295139.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/bugs branch of tip:

Commit-ID:     9dcad2fb31bd9b9b860c515859625a065dd6e656
Gitweb:        https://git.kernel.org/tip/9dcad2fb31bd9b9b860c515859625a065dd6e656
Author:        David Kaplan <david.kaplan@amd.com>
AuthorDate:    Fri, 18 Apr 2025 11:17:12 -05:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Mon, 28 Apr 2025 15:19:30 +02:00

x86/bugs: Restructure GDS mitigation

Restructure GDS mitigation to use select/apply functions to create
consistent vulnerability handling.

Define new AUTO mitigation for GDS.

Signed-off-by: David Kaplan <david.kaplan@amd.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Josh Poimboeuf <jpoimboe@kernel.org>
Link: https://lore.kernel.org/20250418161721.1855190-8-david.kaplan@amd.com
---
 arch/x86/kernel/cpu/bugs.c | 43 ++++++++++++++++++++++++-------------
 1 file changed, 29 insertions(+), 14 deletions(-)

diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index 25b74a7..b070ad7 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -76,6 +76,7 @@ static void __init srbds_apply_mitigation(void);
 static void __init l1d_flush_select_mitigation(void);
 static void __init srso_select_mitigation(void);
 static void __init gds_select_mitigation(void);
+static void __init gds_apply_mitigation(void);
 
 /* The base value of the SPEC_CTRL MSR without task-specific bits set */
 u64 x86_spec_ctrl_base;
@@ -227,6 +228,7 @@ void __init cpu_select_mitigations(void)
 	mmio_apply_mitigation();
 	rfds_apply_mitigation();
 	srbds_apply_mitigation();
+	gds_apply_mitigation();
 }
 
 /*
@@ -831,6 +833,7 @@ early_param("l1d_flush", l1d_flush_parse_cmdline);
 
 enum gds_mitigations {
 	GDS_MITIGATION_OFF,
+	GDS_MITIGATION_AUTO,
 	GDS_MITIGATION_UCODE_NEEDED,
 	GDS_MITIGATION_FORCE,
 	GDS_MITIGATION_FULL,
@@ -839,7 +842,7 @@ enum gds_mitigations {
 };
 
 static enum gds_mitigations gds_mitigation __ro_after_init =
-	IS_ENABLED(CONFIG_MITIGATION_GDS) ? GDS_MITIGATION_FULL : GDS_MITIGATION_OFF;
+	IS_ENABLED(CONFIG_MITIGATION_GDS) ? GDS_MITIGATION_AUTO : GDS_MITIGATION_OFF;
 
 static const char * const gds_strings[] = {
 	[GDS_MITIGATION_OFF]		= "Vulnerable",
@@ -880,6 +883,7 @@ void update_gds_msr(void)
 	case GDS_MITIGATION_FORCE:
 	case GDS_MITIGATION_UCODE_NEEDED:
 	case GDS_MITIGATION_HYPERVISOR:
+	case GDS_MITIGATION_AUTO:
 		return;
 	}
 
@@ -903,26 +907,21 @@ static void __init gds_select_mitigation(void)
 
 	if (boot_cpu_has(X86_FEATURE_HYPERVISOR)) {
 		gds_mitigation = GDS_MITIGATION_HYPERVISOR;
-		goto out;
+		return;
 	}
 
 	if (cpu_mitigations_off())
 		gds_mitigation = GDS_MITIGATION_OFF;
 	/* Will verify below that mitigation _can_ be disabled */
 
+	if (gds_mitigation == GDS_MITIGATION_AUTO)
+		gds_mitigation = GDS_MITIGATION_FULL;
+
 	/* No microcode */
 	if (!(x86_arch_cap_msr & ARCH_CAP_GDS_CTRL)) {
-		if (gds_mitigation == GDS_MITIGATION_FORCE) {
-			/*
-			 * This only needs to be done on the boot CPU so do it
-			 * here rather than in update_gds_msr()
-			 */
-			setup_clear_cpu_cap(X86_FEATURE_AVX);
-			pr_warn("Microcode update needed! Disabling AVX as mitigation.\n");
-		} else {
+		if (gds_mitigation != GDS_MITIGATION_FORCE)
 			gds_mitigation = GDS_MITIGATION_UCODE_NEEDED;
-		}
-		goto out;
+		return;
 	}
 
 	/* Microcode has mitigation, use it */
@@ -943,9 +942,25 @@ static void __init gds_select_mitigation(void)
 		 */
 		gds_mitigation = GDS_MITIGATION_FULL_LOCKED;
 	}
+}
+
+static void __init gds_apply_mitigation(void)
+{
+	if (!boot_cpu_has_bug(X86_BUG_GDS))
+		return;
+
+	/* Microcode is present */
+	if (x86_arch_cap_msr & ARCH_CAP_GDS_CTRL)
+		update_gds_msr();
+	else if (gds_mitigation == GDS_MITIGATION_FORCE) {
+		/*
+		 * This only needs to be done on the boot CPU so do it
+		 * here rather than in update_gds_msr()
+		 */
+		setup_clear_cpu_cap(X86_FEATURE_AVX);
+		pr_warn("Microcode update needed! Disabling AVX as mitigation.\n");
+	}
 
-	update_gds_msr();
-out:
 	pr_info("%s\n", gds_strings[gds_mitigation]);
 }
 

