Return-Path: <linux-tip-commits+bounces-5181-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 16328AA6FB3
	for <lists+linux-tip-commits@lfdr.de>; Fri,  2 May 2025 12:33:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A62451BC16BE
	for <lists+linux-tip-commits@lfdr.de>; Fri,  2 May 2025 10:33:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9769523D29B;
	Fri,  2 May 2025 10:33:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="kGz2irc9";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="PTCsZRck"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A11CB23C51B;
	Fri,  2 May 2025 10:33:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746182009; cv=none; b=e5qOwycvUPJwGhoYL23NzrOxhuknWcGv6g/DMLjf0UyRpXTJfxipI6iInykKa85SoJ8HRTadxjhd0aA18eAnTeZQ68H6zoyVmWc5oay4fEEBHL/WtBLVLatALpWPBRo2d3zzVrFdi+vL/5gx99otN20/HK4YXzfAmxnAt0sqvYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746182009; c=relaxed/simple;
	bh=5ucMLBw4DrXPSysWTEYG/pJKd4QMGZ/Waml3aQ2Zn7w=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=f0aARGzK81hT/I4qR924asXwrgfy87zbFRraQ5AMPOwfLS9aGV+VTTFWa5vEJGmIssU9Z3TU+GHmDwNCrahgFzHA72Te9d1mMGSMdHCxlURzR0ObF2sLMPKX+pcPgeJPA1V/IkMgIpahcDrLS5rExeNd1rBqSPAVOqfk9YL5bOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=kGz2irc9; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=PTCsZRck; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 02 May 2025 10:33:21 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1746182005;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gK8AN0dtZlymjaLj41HLawgVZHb5tnNqg3ibHIfWGsY=;
	b=kGz2irc90cAt3OfvSf3I8MT1qKTKSQhWP3ZAbyvY6NTbxGN/dCBLENL1sn9SSEZ+z5QHmc
	KUByuW9L7MyVdkOiQ9XN1Cf8tLZQ7J3EvMUUSxCLGWPM/3hY1W4hpluE+z+yy85+cfnqrA
	OTuVG+IlB1SVHBFEhY4FTgcGIXMfQ+JMQPbpDJVg+TAZFoihpzf+cMPXoP3Tczk05eVuNX
	C2FPI6KXr9KFF2kOIicvEZhuVMyRwj7xs0dp3b+GXGNq0WS2OKPPtoc4GSyywkPy3O28vN
	LL7ZMuXdemaGuNqIOTsLE+B74UJob2pecUvvxn1qkYqteN1PcuzQvM/t1k6C3g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1746182005;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gK8AN0dtZlymjaLj41HLawgVZHb5tnNqg3ibHIfWGsY=;
	b=PTCsZRckJ8DRkmL+0DmAo8Yb1Jpqbron7TKnLNx59ivmcpHcchYy0M9+rNa26ofJn1JNFA
	NOttc/Q+oi11E/CA==
From: "tip-bot2 for David Kaplan" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/bugs] x86/bugs: Restructure spectre_v2 mitigation
Cc: David Kaplan <david.kaplan@amd.com>,
 "Borislav Petkov (AMD)" <bp@alien8.de>, Josh Poimboeuf <jpoimboe@kernel.org>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250418161721.1855190-14-david.kaplan@amd.com>
References: <20250418161721.1855190-14-david.kaplan@amd.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174618200499.22196.10311249412545642840.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/bugs branch of tip:

Commit-ID:     480e803dacf8be92b1104ca65f2be4cb0e191375
Gitweb:        https://git.kernel.org/tip/480e803dacf8be92b1104ca65f2be4cb0e191375
Author:        David Kaplan <david.kaplan@amd.com>
AuthorDate:    Fri, 18 Apr 2025 11:17:18 -05:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Tue, 29 Apr 2025 18:53:35 +02:00

x86/bugs: Restructure spectre_v2 mitigation

Restructure spectre_v2 to use select/update/apply functions to create
consistent vulnerability handling.

The spectre_v2 mitigation may be updated based on the selected retbleed
mitigation.

Signed-off-by: David Kaplan <david.kaplan@amd.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Josh Poimboeuf <jpoimboe@kernel.org>
Link: https://lore.kernel.org/20250418161721.1855190-14-david.kaplan@amd.com
---
 arch/x86/kernel/cpu/bugs.c | 101 +++++++++++++++++++-----------------
 1 file changed, 56 insertions(+), 45 deletions(-)

diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index 100a320..93d0743 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -56,6 +56,8 @@
 static void __init spectre_v1_select_mitigation(void);
 static void __init spectre_v1_apply_mitigation(void);
 static void __init spectre_v2_select_mitigation(void);
+static void __init spectre_v2_update_mitigation(void);
+static void __init spectre_v2_apply_mitigation(void);
 static void __init retbleed_select_mitigation(void);
 static void __init retbleed_update_mitigation(void);
 static void __init retbleed_apply_mitigation(void);
@@ -217,6 +219,12 @@ void __init cpu_select_mitigations(void)
 	 * After mitigations are selected, some may need to update their
 	 * choices.
 	 */
+	spectre_v2_update_mitigation();
+	/*
+	 * retbleed_update_mitigation() relies on the state set by
+	 * spectre_v2_update_mitigation(); specifically it wants to know about
+	 * spectre_v2=ibrs.
+	 */
 	retbleed_update_mitigation();
 
 	/*
@@ -232,6 +240,7 @@ void __init cpu_select_mitigations(void)
 	bhi_update_mitigation();
 
 	spectre_v1_apply_mitigation();
+	spectre_v2_apply_mitigation();
 	retbleed_apply_mitigation();
 	spectre_v2_user_apply_mitigation();
 	mds_apply_mitigation();
@@ -1878,75 +1887,80 @@ static void __init bhi_apply_mitigation(void)
 
 static void __init spectre_v2_select_mitigation(void)
 {
-	enum spectre_v2_mitigation_cmd cmd = spectre_v2_parse_cmdline();
-	enum spectre_v2_mitigation mode = SPECTRE_V2_NONE;
+	spectre_v2_cmd = spectre_v2_parse_cmdline();
 
-	/*
-	 * If the CPU is not affected and the command line mode is NONE or AUTO
-	 * then nothing to do.
-	 */
 	if (!boot_cpu_has_bug(X86_BUG_SPECTRE_V2) &&
-	    (cmd == SPECTRE_V2_CMD_NONE || cmd == SPECTRE_V2_CMD_AUTO))
+	    (spectre_v2_cmd == SPECTRE_V2_CMD_NONE || spectre_v2_cmd == SPECTRE_V2_CMD_AUTO))
 		return;
 
-	switch (cmd) {
+	switch (spectre_v2_cmd) {
 	case SPECTRE_V2_CMD_NONE:
 		return;
 
 	case SPECTRE_V2_CMD_FORCE:
 	case SPECTRE_V2_CMD_AUTO:
 		if (boot_cpu_has(X86_FEATURE_IBRS_ENHANCED)) {
-			mode = SPECTRE_V2_EIBRS;
-			break;
-		}
-
-		if (IS_ENABLED(CONFIG_MITIGATION_IBRS_ENTRY) &&
-		    boot_cpu_has_bug(X86_BUG_RETBLEED) &&
-		    retbleed_mitigation != RETBLEED_MITIGATION_NONE &&
-		    retbleed_mitigation != RETBLEED_MITIGATION_STUFF &&
-		    boot_cpu_has(X86_FEATURE_IBRS) &&
-		    boot_cpu_data.x86_vendor == X86_VENDOR_INTEL) {
-			mode = SPECTRE_V2_IBRS;
+			spectre_v2_enabled = SPECTRE_V2_EIBRS;
 			break;
 		}
 
-		mode = spectre_v2_select_retpoline();
+		spectre_v2_enabled = spectre_v2_select_retpoline();
 		break;
 
 	case SPECTRE_V2_CMD_RETPOLINE_LFENCE:
 		pr_err(SPECTRE_V2_LFENCE_MSG);
-		mode = SPECTRE_V2_LFENCE;
+		spectre_v2_enabled = SPECTRE_V2_LFENCE;
 		break;
 
 	case SPECTRE_V2_CMD_RETPOLINE_GENERIC:
-		mode = SPECTRE_V2_RETPOLINE;
+		spectre_v2_enabled = SPECTRE_V2_RETPOLINE;
 		break;
 
 	case SPECTRE_V2_CMD_RETPOLINE:
-		mode = spectre_v2_select_retpoline();
+		spectre_v2_enabled = spectre_v2_select_retpoline();
 		break;
 
 	case SPECTRE_V2_CMD_IBRS:
-		mode = SPECTRE_V2_IBRS;
+		spectre_v2_enabled = SPECTRE_V2_IBRS;
 		break;
 
 	case SPECTRE_V2_CMD_EIBRS:
-		mode = SPECTRE_V2_EIBRS;
+		spectre_v2_enabled = SPECTRE_V2_EIBRS;
 		break;
 
 	case SPECTRE_V2_CMD_EIBRS_LFENCE:
-		mode = SPECTRE_V2_EIBRS_LFENCE;
+		spectre_v2_enabled = SPECTRE_V2_EIBRS_LFENCE;
 		break;
 
 	case SPECTRE_V2_CMD_EIBRS_RETPOLINE:
-		mode = SPECTRE_V2_EIBRS_RETPOLINE;
+		spectre_v2_enabled = SPECTRE_V2_EIBRS_RETPOLINE;
 		break;
 	}
+}
 
-	if (mode == SPECTRE_V2_EIBRS && unprivileged_ebpf_enabled())
+static void __init spectre_v2_update_mitigation(void)
+{
+	if (spectre_v2_cmd == SPECTRE_V2_CMD_AUTO) {
+		if (IS_ENABLED(CONFIG_MITIGATION_IBRS_ENTRY) &&
+		    boot_cpu_has_bug(X86_BUG_RETBLEED) &&
+		    retbleed_mitigation != RETBLEED_MITIGATION_NONE &&
+		    retbleed_mitigation != RETBLEED_MITIGATION_STUFF &&
+		    boot_cpu_has(X86_FEATURE_IBRS) &&
+		    boot_cpu_data.x86_vendor == X86_VENDOR_INTEL) {
+			spectre_v2_enabled = SPECTRE_V2_IBRS;
+		}
+	}
+
+	if (boot_cpu_has_bug(X86_BUG_SPECTRE_V2) && !cpu_mitigations_off())
+		pr_info("%s\n", spectre_v2_strings[spectre_v2_enabled]);
+}
+
+static void __init spectre_v2_apply_mitigation(void)
+{
+	if (spectre_v2_enabled == SPECTRE_V2_EIBRS && unprivileged_ebpf_enabled())
 		pr_err(SPECTRE_V2_EIBRS_EBPF_MSG);
 
-	if (spectre_v2_in_ibrs_mode(mode)) {
+	if (spectre_v2_in_ibrs_mode(spectre_v2_enabled)) {
 		if (boot_cpu_has(X86_FEATURE_AUTOIBRS)) {
 			msr_set_bit(MSR_EFER, _EFER_AUTOIBRS);
 		} else {
@@ -1955,8 +1969,10 @@ static void __init spectre_v2_select_mitigation(void)
 		}
 	}
 
-	switch (mode) {
+	switch (spectre_v2_enabled) {
 	case SPECTRE_V2_NONE:
+		return;
+
 	case SPECTRE_V2_EIBRS:
 		break;
 
@@ -1982,15 +1998,12 @@ static void __init spectre_v2_select_mitigation(void)
 	 * JMPs gets protection against BHI and Intramode-BTI, but RET
 	 * prediction from a non-RSB predictor is still a risk.
 	 */
-	if (mode == SPECTRE_V2_EIBRS_LFENCE ||
-	    mode == SPECTRE_V2_EIBRS_RETPOLINE ||
-	    mode == SPECTRE_V2_RETPOLINE)
+	if (spectre_v2_enabled == SPECTRE_V2_EIBRS_LFENCE ||
+	    spectre_v2_enabled == SPECTRE_V2_EIBRS_RETPOLINE ||
+	    spectre_v2_enabled == SPECTRE_V2_RETPOLINE)
 		spec_ctrl_disable_kernel_rrsba();
 
-	spectre_v2_enabled = mode;
-	pr_info("%s\n", spectre_v2_strings[mode]);
-
-	spectre_v2_select_rsb_mitigation(mode);
+	spectre_v2_select_rsb_mitigation(spectre_v2_enabled);
 
 	/*
 	 * Retpoline protects the kernel, but doesn't protect firmware.  IBRS
@@ -1998,10 +2011,10 @@ static void __init spectre_v2_select_mitigation(void)
 	 * firmware calls only when IBRS / Enhanced / Automatic IBRS aren't
 	 * otherwise enabled.
 	 *
-	 * Use "mode" to check Enhanced IBRS instead of boot_cpu_has(), because
-	 * the user might select retpoline on the kernel command line and if
-	 * the CPU supports Enhanced IBRS, kernel might un-intentionally not
-	 * enable IBRS around firmware calls.
+	 * Use "spectre_v2_enabled" to check Enhanced IBRS instead of
+	 * boot_cpu_has(), because the user might select retpoline on the kernel
+	 * command line and if the CPU supports Enhanced IBRS, kernel might
+	 * un-intentionally not enable IBRS around firmware calls.
 	 */
 	if (boot_cpu_has_bug(X86_BUG_RETBLEED) &&
 	    boot_cpu_has(X86_FEATURE_IBPB) &&
@@ -2013,13 +2026,11 @@ static void __init spectre_v2_select_mitigation(void)
 			pr_info("Enabling Speculation Barrier for firmware calls\n");
 		}
 
-	} else if (boot_cpu_has(X86_FEATURE_IBRS) && !spectre_v2_in_ibrs_mode(mode)) {
+	} else if (boot_cpu_has(X86_FEATURE_IBRS) &&
+		   !spectre_v2_in_ibrs_mode(spectre_v2_enabled)) {
 		setup_force_cpu_cap(X86_FEATURE_USE_IBRS_FW);
 		pr_info("Enabling Restricted Speculation for firmware calls\n");
 	}
-
-	/* Set up IBPB and STIBP depending on the general spectre V2 command */
-	spectre_v2_cmd = cmd;
 }
 
 static void update_stibp_msr(void * __unused)

