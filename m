Return-Path: <linux-tip-commits+bounces-5190-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D2D5AA6FC4
	for <lists+linux-tip-commits@lfdr.de>; Fri,  2 May 2025 12:35:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9270D7ACD23
	for <lists+linux-tip-commits@lfdr.de>; Fri,  2 May 2025 10:33:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEB39253B71;
	Fri,  2 May 2025 10:33:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="jK9kw13w";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="H42OieW6"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C92F824678B;
	Fri,  2 May 2025 10:33:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746182016; cv=none; b=dA2Pd1v26e1GOOd1Pl6CzPpvE5+H3GnPt3sjChBB7Ii9skExRSHifDNrNYFjfxHNR2CzI9W7PA8au1FCSbGsLkoXQAXZUG/HeHdNS5Sgzt/nsWXyUJuDmaSKlrjy5wjWKSJwHJtXj99mAgiY734d0coTkvueWq5GXYeUYhehj3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746182016; c=relaxed/simple;
	bh=vGoU8qHnSqRCWdGYW+Ycijb2GkJgNdKApjIbQrD7y84=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=FF/Q7GqDydG+T1zujUIvjgfL2dJqhqffFr7KZ6P6pAFLScPOsjxxileLQfMynr4mE7s+0q6VWThJWdWDkjGJ6ffHCT43IFeV2wWrxuCknYalHRgEGwsr44ZjU5/vrttvUaX7IoRoT+MWFSOsaVyTH9jhCcuonlbzl3oPdbzzRCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=jK9kw13w; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=H42OieW6; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 02 May 2025 10:33:32 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1746182013;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sNetqPL9WWXk6yXWBsNonmQatkbzS40GiZ7fH+ZUov0=;
	b=jK9kw13wQVNKSLhTYDo4p5TAtHEgySCMgVYMCrWWSiRsqTF21D8j7hu0FXzFGo92+fr+j/
	577zt+WIMfmZMGn/6FWxBvpUgVeYdv357Afh6iSySQ6oIcvaaMcHQAbloFsERZHGht9YWw
	hF1z1hc2lAjXLO8hnyihFBoDC9SezxyTxfLxkGp9DfQdm3+gKcVzImVzzpkHlyGXQt1GOl
	i9DE/pzNlDn884tPgIIryGLUQcFPPiekIzzknM8KoSmvQLSZXU6zi6NGw0rYk3CMQyd0t/
	//3GSR01vQWoYpLjFXB4FXG1HY8wxg7nGzo786Z/Ee+chUe1jwqFglaeaVPwww==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1746182013;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sNetqPL9WWXk6yXWBsNonmQatkbzS40GiZ7fH+ZUov0=;
	b=H42OieW6/s4VcHuZGkwIVsRBDfj3DgjSRF8ls+S0i/Qw0qKtUCTko8wvlBrOCYYy7a53Ka
	oQxZNEUcYvzWoxDQ==
From: "tip-bot2 for David Kaplan" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/bugs] x86/bugs: Restructure MMIO mitigation
Cc: David Kaplan <david.kaplan@amd.com>,
 "Borislav Petkov (AMD)" <bp@alien8.de>, Josh Poimboeuf <jpoimboe@kernel.org>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250418161721.1855190-4-david.kaplan@amd.com>
References: <20250418161721.1855190-4-david.kaplan@amd.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174618201243.22196.15533937205535867214.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/bugs branch of tip:

Commit-ID:     4a5a04e61d7f8f26472f93287f6dcb669f0cf22f
Gitweb:        https://git.kernel.org/tip/4a5a04e61d7f8f26472f93287f6dcb669f0cf22f
Author:        David Kaplan <david.kaplan@amd.com>
AuthorDate:    Fri, 18 Apr 2025 11:17:08 -05:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Mon, 28 Apr 2025 13:22:24 +02:00

x86/bugs: Restructure MMIO mitigation

Restructure MMIO mitigation to use select/update/apply functions to
create consistent vulnerability handling.

Signed-off-by: David Kaplan <david.kaplan@amd.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Josh Poimboeuf <jpoimboe@kernel.org>
Link: https://lore.kernel.org/20250418161721.1855190-4-david.kaplan@amd.com
---
 arch/x86/kernel/cpu/bugs.c | 74 +++++++++++++++++++++++++------------
 1 file changed, 50 insertions(+), 24 deletions(-)

diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index 5db21d2..bc74c22 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -68,6 +68,8 @@ static void __init taa_select_mitigation(void);
 static void __init taa_update_mitigation(void);
 static void __init taa_apply_mitigation(void);
 static void __init mmio_select_mitigation(void);
+static void __init mmio_update_mitigation(void);
+static void __init mmio_apply_mitigation(void);
 static void __init srbds_select_mitigation(void);
 static void __init l1d_flush_select_mitigation(void);
 static void __init srso_select_mitigation(void);
@@ -197,6 +199,7 @@ void __init cpu_select_mitigations(void)
 	l1tf_select_mitigation();
 	mds_select_mitigation();
 	taa_select_mitigation();
+	mmio_select_mitigation();
 	md_clear_select_mitigation();
 	srbds_select_mitigation();
 	l1d_flush_select_mitigation();
@@ -214,9 +217,11 @@ void __init cpu_select_mitigations(void)
 	 */
 	mds_update_mitigation();
 	taa_update_mitigation();
+	mmio_update_mitigation();
 
 	mds_apply_mitigation();
 	taa_apply_mitigation();
+	mmio_apply_mitigation();
 }
 
 /*
@@ -520,25 +525,62 @@ static void __init mmio_select_mitigation(void)
 		return;
 	}
 
+	/* Microcode will be checked in mmio_update_mitigation(). */
+	if (mmio_mitigation == MMIO_MITIGATION_AUTO)
+		mmio_mitigation = MMIO_MITIGATION_VERW;
+
 	if (mmio_mitigation == MMIO_MITIGATION_OFF)
 		return;
 
 	/*
 	 * Enable CPU buffer clear mitigation for host and VMM, if also affected
-	 * by MDS or TAA. Otherwise, enable mitigation for VMM only.
+	 * by MDS or TAA.
 	 */
-	if (boot_cpu_has_bug(X86_BUG_MDS) || (boot_cpu_has_bug(X86_BUG_TAA) &&
-					      boot_cpu_has(X86_FEATURE_RTM)))
-		setup_force_cpu_cap(X86_FEATURE_CLEAR_CPU_BUF);
+	if (boot_cpu_has_bug(X86_BUG_MDS) || taa_vulnerable())
+		verw_clear_cpu_buf_mitigation_selected = true;
+}
+
+static void __init mmio_update_mitigation(void)
+{
+	if (!boot_cpu_has_bug(X86_BUG_MMIO_STALE_DATA) || cpu_mitigations_off())
+		return;
+
+	if (verw_clear_cpu_buf_mitigation_selected)
+		mmio_mitigation = MMIO_MITIGATION_VERW;
+
+	if (mmio_mitigation == MMIO_MITIGATION_VERW) {
+		/*
+		 * Check if the system has the right microcode.
+		 *
+		 * CPU Fill buffer clear mitigation is enumerated by either an explicit
+		 * FB_CLEAR or by the presence of both MD_CLEAR and L1D_FLUSH on MDS
+		 * affected systems.
+		 */
+		if (!((x86_arch_cap_msr & ARCH_CAP_FB_CLEAR) ||
+		      (boot_cpu_has(X86_FEATURE_MD_CLEAR) &&
+		       boot_cpu_has(X86_FEATURE_FLUSH_L1D) &&
+		     !(x86_arch_cap_msr & ARCH_CAP_MDS_NO))))
+			mmio_mitigation = MMIO_MITIGATION_UCODE_NEEDED;
+	}
+
+	pr_info("%s\n", mmio_strings[mmio_mitigation]);
+}
+
+static void __init mmio_apply_mitigation(void)
+{
+	if (mmio_mitigation == MMIO_MITIGATION_OFF)
+		return;
 
 	/*
-	 * X86_FEATURE_CLEAR_CPU_BUF could be enabled by other VERW based
-	 * mitigations, disable KVM-only mitigation in that case.
+	 * Only enable the VMM mitigation if the CPU buffer clear mitigation is
+	 * not being used.
 	 */
-	if (boot_cpu_has(X86_FEATURE_CLEAR_CPU_BUF))
+	if (verw_clear_cpu_buf_mitigation_selected) {
+		setup_force_cpu_cap(X86_FEATURE_CLEAR_CPU_BUF);
 		static_branch_disable(&cpu_buf_vm_clear);
-	else
+	} else {
 		static_branch_enable(&cpu_buf_vm_clear);
+	}
 
 	/*
 	 * If Processor-MMIO-Stale-Data bug is present and Fill Buffer data can
@@ -548,21 +590,6 @@ static void __init mmio_select_mitigation(void)
 	if (!(x86_arch_cap_msr & ARCH_CAP_FBSDP_NO))
 		static_branch_enable(&mds_idle_clear);
 
-	/*
-	 * Check if the system has the right microcode.
-	 *
-	 * CPU Fill buffer clear mitigation is enumerated by either an explicit
-	 * FB_CLEAR or by the presence of both MD_CLEAR and L1D_FLUSH on MDS
-	 * affected systems.
-	 */
-	if ((x86_arch_cap_msr & ARCH_CAP_FB_CLEAR) ||
-	    (boot_cpu_has(X86_FEATURE_MD_CLEAR) &&
-	     boot_cpu_has(X86_FEATURE_FLUSH_L1D) &&
-	     !(x86_arch_cap_msr & ARCH_CAP_MDS_NO)))
-		mmio_mitigation = MMIO_MITIGATION_VERW;
-	else
-		mmio_mitigation = MMIO_MITIGATION_UCODE_NEEDED;
-
 	if (mmio_nosmt || cpu_mitigations_auto_nosmt())
 		cpu_smt_disable(false);
 }
@@ -685,7 +712,6 @@ out:
 
 static void __init md_clear_select_mitigation(void)
 {
-	mmio_select_mitigation();
 	rfds_select_mitigation();
 
 	/*

