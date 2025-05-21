Return-Path: <linux-tip-commits+bounces-5676-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CF848ABEC88
	for <lists+linux-tip-commits@lfdr.de>; Wed, 21 May 2025 08:56:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 70E3B188BB6E
	for <lists+linux-tip-commits@lfdr.de>; Wed, 21 May 2025 06:57:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D1C923370F;
	Wed, 21 May 2025 06:56:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="1NyJNoqC";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="gAZyev3B"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05FCF201266;
	Wed, 21 May 2025 06:56:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747810605; cv=none; b=NxnpDPqNILiS0t1JAk78MrzJqVbrNR+CHs2nDomhvtUKhHGVTcxXbPRfP22tckWH6q4bBJHy0Lrt8Hxn0gsuC0frn85CAFYaODpFO5r07PWAqNsjSUchVMWtFDzhV7EV9Hpijoin1EIsKIco3CphPzRSYUetzSB32S0uvPB6NEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747810605; c=relaxed/simple;
	bh=tqdtDhnlzy6YdOODtMk30ooPSibNXswrxTGYE7byeW4=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=DaVQb+8zVAMrKDuhxNCYwodOO7PNhAc+hCdQ2ssRfIxJdI1VPbR/tw012mGTBDOGypKawf0+naH+WYYgboRtZIl+mS+TTrI8NIy6nXN+/exW5LCNFPwmeGPsH/echypWSA6JHTYyWAlCqsOtA0am5CHSvf3x3fGjzsZba6L5Od8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=1NyJNoqC; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=gAZyev3B; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 21 May 2025 06:56:39 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1747810600;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VXoXAo4wUxw50VKFS3FaNdh2gtY10JcNGm0jTgyjPG8=;
	b=1NyJNoqCVuYjrYQmAxYJ2jdnhq4K/tGMUzeHDmE+TOfKKr82s5TvwPE8QEJaFoyxXaPKQu
	2v6K9UPPvBwgQ5qZzvg8XPxOykz9C9XACerBGDehUMw7HiUZ6oeLU9bvYbLZfGZcx5vNZE
	c/Fug5iVxNwztinUdSvcA3TjyDJ326w26a9oBS5KTi1K8s0sdY+XK9kvE9GHD2Drjeasr0
	OgZ9rzbE8qn3loxMavf5Wf/ga81VhZp0Tgu9qRaJCtp/yYAmBQDn6Y3K3dBVN4U71gF0qf
	utVxmjtjgYYDt9QR/VQl+ReDuAyjhwS4ZZENTVcVJYEuKBgYZikrDpfSbUOtCQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1747810600;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VXoXAo4wUxw50VKFS3FaNdh2gtY10JcNGm0jTgyjPG8=;
	b=gAZyev3BpmnJUOQp2/y8msQWA4lF6vGlgrFl4gEMYyko/0/aXXH+JBlQNAaGGcYe9hVy1b
	zpBvb1+u+uwzRGDw==
From: "tip-bot2 for David Kaplan" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/core] x86/bugs: Restructure ITS mitigation
Cc: David Kaplan <david.kaplan@amd.com>,
 "Borislav Petkov (AMD)" <bp@alien8.de>, Ingo Molnar <mingo@kernel.org>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250516193212.128782-1-david.kaplan@amd.com>
References: <20250516193212.128782-1-david.kaplan@amd.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174781059941.406.2237870351760542190.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/core branch of tip:

Commit-ID:     61ab72c2c6bf24f28b3dbfd3126e984d5afa8424
Gitweb:        https://git.kernel.org/tip/61ab72c2c6bf24f28b3dbfd3126e984d5afa8424
Author:        David Kaplan <david.kaplan@amd.com>
AuthorDate:    Fri, 16 May 2025 14:32:11 -05:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Wed, 21 May 2025 08:45:27 +02:00

x86/bugs: Restructure ITS mitigation

Restructure the ITS mitigation to use select/update/apply functions like
the other mitigations.

There is a particularly complex interaction between ITS and Retbleed as CDT
(Call Depth Tracking) is a mitigation for both, and either its=stuff or
retbleed=stuff will attempt to enable CDT.

retbleed_update_mitigation() runs first and will check the necessary
pre-conditions for CDT if either ITS or Retbleed stuffing is selected.  If
checks pass and ITS stuffing is selected, it will select stuffing for
Retbleed as well.

its_update_mitigation() runs after and will either select stuffing if
retbleed stuffing was enabled, or fall back to the default (aligned thunks)
if stuffing could not be enabled.

Enablement of CDT is done exclusively in retbleed_apply_mitigation().
its_apply_mitigation() is only used to enable aligned thunks.

Signed-off-by: David Kaplan <david.kaplan@amd.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/20250516193212.128782-1-david.kaplan@amd.com
---
 arch/x86/kernel/cpu/bugs.c | 167 +++++++++++++++++++-----------------
 1 file changed, 90 insertions(+), 77 deletions(-)

diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index d1a03ff..3d5796d 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -92,6 +92,8 @@ static void __init bhi_select_mitigation(void);
 static void __init bhi_update_mitigation(void);
 static void __init bhi_apply_mitigation(void);
 static void __init its_select_mitigation(void);
+static void __init its_update_mitigation(void);
+static void __init its_apply_mitigation(void);
 
 /* The base value of the SPEC_CTRL MSR without task-specific bits set */
 u64 x86_spec_ctrl_base;
@@ -235,6 +237,11 @@ void __init cpu_select_mitigations(void)
 	 * spectre_v2=ibrs.
 	 */
 	retbleed_update_mitigation();
+	/*
+	 * its_update_mitigation() depends on spectre_v2_update_mitigation()
+	 * and retbleed_update_mitigation().
+	 */
+	its_update_mitigation();
 
 	/*
 	 * spectre_v2_user_update_mitigation() depends on
@@ -263,6 +270,7 @@ void __init cpu_select_mitigations(void)
 	srbds_apply_mitigation();
 	srso_apply_mitigation();
 	gds_apply_mitigation();
+	its_apply_mitigation();
 	bhi_apply_mitigation();
 }
 
@@ -1115,6 +1123,17 @@ enum spectre_v2_mitigation spectre_v2_enabled __ro_after_init = SPECTRE_V2_NONE;
 #undef pr_fmt
 #define pr_fmt(fmt)     "RETBleed: " fmt
 
+enum its_mitigation {
+	ITS_MITIGATION_OFF,
+	ITS_MITIGATION_AUTO,
+	ITS_MITIGATION_VMEXIT_ONLY,
+	ITS_MITIGATION_ALIGNED_THUNKS,
+	ITS_MITIGATION_RETPOLINE_STUFF,
+};
+
+static enum its_mitigation its_mitigation __ro_after_init =
+	IS_ENABLED(CONFIG_MITIGATION_ITS) ? ITS_MITIGATION_AUTO : ITS_MITIGATION_OFF;
+
 enum retbleed_mitigation {
 	RETBLEED_MITIGATION_NONE,
 	RETBLEED_MITIGATION_AUTO,
@@ -1242,11 +1261,19 @@ static void __init retbleed_update_mitigation(void)
 	/*
 	 * retbleed=stuff is only allowed on Intel.  If stuffing can't be used
 	 * then a different mitigation will be selected below.
+	 *
+	 * its=stuff will also attempt to enable stuffing.
 	 */
-	if (retbleed_mitigation == RETBLEED_MITIGATION_STUFF) {
+	if (retbleed_mitigation == RETBLEED_MITIGATION_STUFF ||
+	    its_mitigation == ITS_MITIGATION_RETPOLINE_STUFF) {
 		if (spectre_v2_enabled != SPECTRE_V2_RETPOLINE) {
 			pr_err("WARNING: retbleed=stuff depends on spectre_v2=retpoline\n");
 			retbleed_mitigation = RETBLEED_MITIGATION_AUTO;
+		} else {
+			if (retbleed_mitigation != RETBLEED_MITIGATION_STUFF)
+				pr_info("Retbleed mitigation updated to stuffing\n");
+
+			retbleed_mitigation = RETBLEED_MITIGATION_STUFF;
 		}
 	}
 	/*
@@ -1338,20 +1365,6 @@ static void __init retbleed_apply_mitigation(void)
 #undef pr_fmt
 #define pr_fmt(fmt)     "ITS: " fmt
 
-enum its_mitigation_cmd {
-	ITS_CMD_OFF,
-	ITS_CMD_ON,
-	ITS_CMD_VMEXIT,
-	ITS_CMD_RSB_STUFF,
-};
-
-enum its_mitigation {
-	ITS_MITIGATION_OFF,
-	ITS_MITIGATION_VMEXIT_ONLY,
-	ITS_MITIGATION_ALIGNED_THUNKS,
-	ITS_MITIGATION_RETPOLINE_STUFF,
-};
-
 static const char * const its_strings[] = {
 	[ITS_MITIGATION_OFF]			= "Vulnerable",
 	[ITS_MITIGATION_VMEXIT_ONLY]		= "Mitigation: Vulnerable, KVM: Not affected",
@@ -1359,11 +1372,6 @@ static const char * const its_strings[] = {
 	[ITS_MITIGATION_RETPOLINE_STUFF]	= "Mitigation: Retpolines, Stuffing RSB",
 };
 
-static enum its_mitigation its_mitigation __ro_after_init = ITS_MITIGATION_ALIGNED_THUNKS;
-
-static enum its_mitigation_cmd its_cmd __ro_after_init =
-	IS_ENABLED(CONFIG_MITIGATION_ITS) ? ITS_CMD_ON : ITS_CMD_OFF;
-
 static int __init its_parse_cmdline(char *str)
 {
 	if (!str)
@@ -1375,16 +1383,16 @@ static int __init its_parse_cmdline(char *str)
 	}
 
 	if (!strcmp(str, "off")) {
-		its_cmd = ITS_CMD_OFF;
+		its_mitigation = ITS_MITIGATION_OFF;
 	} else if (!strcmp(str, "on")) {
-		its_cmd = ITS_CMD_ON;
+		its_mitigation = ITS_MITIGATION_ALIGNED_THUNKS;
 	} else if (!strcmp(str, "force")) {
-		its_cmd = ITS_CMD_ON;
+		its_mitigation = ITS_MITIGATION_ALIGNED_THUNKS;
 		setup_force_cpu_bug(X86_BUG_ITS);
 	} else if (!strcmp(str, "vmexit")) {
-		its_cmd = ITS_CMD_VMEXIT;
+		its_mitigation = ITS_MITIGATION_VMEXIT_ONLY;
 	} else if (!strcmp(str, "stuff")) {
-		its_cmd = ITS_CMD_RSB_STUFF;
+		its_mitigation = ITS_MITIGATION_RETPOLINE_STUFF;
 	} else {
 		pr_err("Ignoring unknown indirect_target_selection option (%s).", str);
 	}
@@ -1395,85 +1403,90 @@ early_param("indirect_target_selection", its_parse_cmdline);
 
 static void __init its_select_mitigation(void)
 {
-	enum its_mitigation_cmd cmd = its_cmd;
-
 	if (!boot_cpu_has_bug(X86_BUG_ITS) || cpu_mitigations_off()) {
 		its_mitigation = ITS_MITIGATION_OFF;
 		return;
 	}
 
-	/* Retpoline+CDT mitigates ITS, bail out */
-	if (boot_cpu_has(X86_FEATURE_RETPOLINE) &&
-	    boot_cpu_has(X86_FEATURE_CALL_DEPTH)) {
-		its_mitigation = ITS_MITIGATION_RETPOLINE_STUFF;
-		goto out;
-	}
+	if (its_mitigation == ITS_MITIGATION_AUTO)
+		its_mitigation = ITS_MITIGATION_ALIGNED_THUNKS;
+
+	if (its_mitigation == ITS_MITIGATION_OFF)
+		return;
 
-	/* Exit early to avoid irrelevant warnings */
-	if (cmd == ITS_CMD_OFF) {
-		its_mitigation = ITS_MITIGATION_OFF;
-		goto out;
-	}
-	if (spectre_v2_enabled == SPECTRE_V2_NONE) {
-		pr_err("WARNING: Spectre-v2 mitigation is off, disabling ITS\n");
-		its_mitigation = ITS_MITIGATION_OFF;
-		goto out;
-	}
 	if (!IS_ENABLED(CONFIG_MITIGATION_RETPOLINE) ||
 	    !IS_ENABLED(CONFIG_MITIGATION_RETHUNK)) {
 		pr_err("WARNING: ITS mitigation depends on retpoline and rethunk support\n");
 		its_mitigation = ITS_MITIGATION_OFF;
-		goto out;
+		return;
 	}
+
 	if (IS_ENABLED(CONFIG_DEBUG_FORCE_FUNCTION_ALIGN_64B)) {
 		pr_err("WARNING: ITS mitigation is not compatible with CONFIG_DEBUG_FORCE_FUNCTION_ALIGN_64B\n");
 		its_mitigation = ITS_MITIGATION_OFF;
-		goto out;
-	}
-	if (boot_cpu_has(X86_FEATURE_RETPOLINE_LFENCE)) {
-		pr_err("WARNING: ITS mitigation is not compatible with lfence mitigation\n");
-		its_mitigation = ITS_MITIGATION_OFF;
-		goto out;
+		return;
 	}
 
-	if (cmd == ITS_CMD_RSB_STUFF &&
-	    (!boot_cpu_has(X86_FEATURE_RETPOLINE) || !IS_ENABLED(CONFIG_MITIGATION_CALL_DEPTH_TRACKING))) {
+	if (its_mitigation == ITS_MITIGATION_RETPOLINE_STUFF &&
+	    !IS_ENABLED(CONFIG_MITIGATION_CALL_DEPTH_TRACKING)) {
 		pr_err("RSB stuff mitigation not supported, using default\n");
-		cmd = ITS_CMD_ON;
+		its_mitigation = ITS_MITIGATION_ALIGNED_THUNKS;
 	}
 
-	switch (cmd) {
-	case ITS_CMD_OFF:
+	if (its_mitigation == ITS_MITIGATION_VMEXIT_ONLY &&
+	    !boot_cpu_has_bug(X86_BUG_ITS_NATIVE_ONLY))
+		its_mitigation = ITS_MITIGATION_ALIGNED_THUNKS;
+}
+
+static void __init its_update_mitigation(void)
+{
+	if (!boot_cpu_has_bug(X86_BUG_ITS) || cpu_mitigations_off())
+		return;
+
+	switch (spectre_v2_enabled) {
+	case SPECTRE_V2_NONE:
+		pr_err("WARNING: Spectre-v2 mitigation is off, disabling ITS\n");
 		its_mitigation = ITS_MITIGATION_OFF;
 		break;
-	case ITS_CMD_VMEXIT:
-		if (boot_cpu_has_bug(X86_BUG_ITS_NATIVE_ONLY)) {
-			its_mitigation = ITS_MITIGATION_VMEXIT_ONLY;
-			goto out;
-		}
-		fallthrough;
-	case ITS_CMD_ON:
-		its_mitigation = ITS_MITIGATION_ALIGNED_THUNKS;
-		if (!boot_cpu_has(X86_FEATURE_RETPOLINE))
-			setup_force_cpu_cap(X86_FEATURE_INDIRECT_THUNK_ITS);
-		setup_force_cpu_cap(X86_FEATURE_RETHUNK);
-		set_return_thunk(its_return_thunk);
+	case SPECTRE_V2_RETPOLINE:
+		/* Retpoline+CDT mitigates ITS */
+		if (retbleed_mitigation == RETBLEED_MITIGATION_STUFF)
+			its_mitigation = ITS_MITIGATION_RETPOLINE_STUFF;
 		break;
-	case ITS_CMD_RSB_STUFF:
-		its_mitigation = ITS_MITIGATION_RETPOLINE_STUFF;
-		setup_force_cpu_cap(X86_FEATURE_RETHUNK);
-		setup_force_cpu_cap(X86_FEATURE_CALL_DEPTH);
-		set_return_thunk(call_depth_return_thunk);
-		if (retbleed_mitigation == RETBLEED_MITIGATION_NONE) {
-			retbleed_mitigation = RETBLEED_MITIGATION_STUFF;
-			pr_info("Retbleed mitigation updated to stuffing\n");
-		}
+	case SPECTRE_V2_LFENCE:
+	case SPECTRE_V2_EIBRS_LFENCE:
+		pr_err("WARNING: ITS mitigation is not compatible with lfence mitigation\n");
+		its_mitigation = ITS_MITIGATION_OFF;
+		break;
+	default:
 		break;
 	}
-out:
+
+	/*
+	 * retbleed_update_mitigation() will try to do stuffing if its=stuff.
+	 * If it can't, such as if spectre_v2!=retpoline, then fall back to
+	 * aligned thunks.
+	 */
+	if (its_mitigation == ITS_MITIGATION_RETPOLINE_STUFF &&
+	    retbleed_mitigation != RETBLEED_MITIGATION_STUFF)
+		its_mitigation = ITS_MITIGATION_ALIGNED_THUNKS;
+
 	pr_info("%s\n", its_strings[its_mitigation]);
 }
 
+static void __init its_apply_mitigation(void)
+{
+	/* its=stuff forces retbleed stuffing and is enabled there. */
+	if (its_mitigation != ITS_MITIGATION_ALIGNED_THUNKS)
+		return;
+
+	if (!boot_cpu_has(X86_FEATURE_RETPOLINE))
+		setup_force_cpu_cap(X86_FEATURE_INDIRECT_THUNK_ITS);
+
+	setup_force_cpu_cap(X86_FEATURE_RETHUNK);
+	set_return_thunk(its_return_thunk);
+}
+
 #undef pr_fmt
 #define pr_fmt(fmt)     "Spectre V2 : " fmt
 

