Return-Path: <linux-tip-commits+bounces-5192-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C6CECAA6FC8
	for <lists+linux-tip-commits@lfdr.de>; Fri,  2 May 2025 12:35:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5FDF01BC548C
	for <lists+linux-tip-commits@lfdr.de>; Fri,  2 May 2025 10:35:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF5EC254877;
	Fri,  2 May 2025 10:33:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="lgegKsMO";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="fT/m814x"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A47BF24677B;
	Fri,  2 May 2025 10:33:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746182017; cv=none; b=CMP6jp1EJJz3LlR9PKDLk8NCum2y0BzzL6TMQUyk6qra8laKi/f8wcvbyO+ps+RnHH2KU75AiWKKyGUxHXtJC29LQVB9Tsb3Q4d6RW6g2OVqMW/SjbvnRvUdqDsTymptK9GdZlcs6ufzNyi64iCXvlj+miWQwyFI9atyl8R3vj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746182017; c=relaxed/simple;
	bh=ggcrXcUAigvDR6phBKgZBaaP9ycxUx5xODYBG9ZL/a0=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=kk4Li5JaxeN013vUq1t5I3SaZHMLNVcaUWLmsp8+cmbvBt7bvktGfLI4tFP6hDzhtbC4QGwiJ+kB/ODzuzPRYl1Itp4NJi26Xu7mdkMmOUAot8SFxc10fUM4SjROffAo8fWnYJtUJBFSF/W0O0V4UcOFAGFKWsqexU60UL7dX/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=lgegKsMO; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=fT/m814x; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 02 May 2025 10:33:12 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1746182000;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mXhlmJ7nabzr/rI8smWYwFjiR/0zRgT7Vn3qMrskT5g=;
	b=lgegKsMOGpFXcTB2sxw0o800/ZMW3YZE8dKRxr9gOcCBXjfdKV6EM0MXR39Z4ZqJALTaqw
	ij9MRb+g6qgtx+MvwlO24Es3YGW7inLsXd/NPI37U5uds3z/ivcfff0FbSQ4oRkWMrE5e9
	7sTXeXyEHN0NZedQauhibBKIh3G/+NNL/HxROrJMa5shW2Iw2ytrrJtZPzRSFSp0UI/o1e
	4Z25dOQ2E+tJjBOeBA6HrU7oO+YsR1XJjrlzTCTWZoQg1JklmElxnEDjfHInuldyoDzD34
	vTLcGxzsMH+q4QXbATvrdTPt/Ty8DQdVIChUDpBK+4TdiWkuPxNm3aFayGxlEA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1746182000;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mXhlmJ7nabzr/rI8smWYwFjiR/0zRgT7Vn3qMrskT5g=;
	b=fT/m814xdNxAZlscikTj0Fvlq0paX7bn9P42Kab4bnx2v2pnkzh3a4FnUJRzF3RoU/LoLX
	teKEz9PCkK8uycBw==
From: "tip-bot2 for David Kaplan" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/bugs] x86/bugs: Restructure SRSO mitigation
Cc: David Kaplan <david.kaplan@amd.com>,
 "Borislav Petkov (AMD)" <bp@alien8.de>, Josh Poimboeuf <jpoimboe@kernel.org>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250418161721.1855190-17-david.kaplan@amd.com>
References: <20250418161721.1855190-17-david.kaplan@amd.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174618199321.22196.14882160798141871179.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/bugs branch of tip:

Commit-ID:     1f4bb068b498a544ae913764a797449463ef620c
Gitweb:        https://git.kernel.org/tip/1f4bb068b498a544ae913764a797449463ef620c
Author:        David Kaplan <david.kaplan@amd.com>
AuthorDate:    Fri, 18 Apr 2025 11:17:21 -05:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Wed, 30 Apr 2025 10:25:45 +02:00

x86/bugs: Restructure SRSO mitigation

Restructure SRSO to use select/update/apply functions to create
consistent vulnerability handling.  Like with retbleed, the command line
options directly select mitigations which can later be modified.

While at it, remove a comment which doesn't apply anymore due to the
changed mitigation detection flow.

Signed-off-by: David Kaplan <david.kaplan@amd.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Josh Poimboeuf <jpoimboe@kernel.org>
Link: https://lore.kernel.org/20250418161721.1855190-17-david.kaplan@amd.com
---
 arch/x86/kernel/cpu/bugs.c | 215 ++++++++++++++++--------------------
 1 file changed, 101 insertions(+), 114 deletions(-)

diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index 25d84e2..a4f3b1d 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -84,6 +84,8 @@ static void __init srbds_select_mitigation(void);
 static void __init srbds_apply_mitigation(void);
 static void __init l1d_flush_select_mitigation(void);
 static void __init srso_select_mitigation(void);
+static void __init srso_update_mitigation(void);
+static void __init srso_apply_mitigation(void);
 static void __init gds_select_mitigation(void);
 static void __init gds_apply_mitigation(void);
 static void __init bhi_select_mitigation(void);
@@ -208,11 +210,6 @@ void __init cpu_select_mitigations(void)
 	rfds_select_mitigation();
 	srbds_select_mitigation();
 	l1d_flush_select_mitigation();
-
-	/*
-	 * srso_select_mitigation() depends and must run after
-	 * retbleed_select_mitigation().
-	 */
 	srso_select_mitigation();
 	gds_select_mitigation();
 	bhi_select_mitigation();
@@ -240,6 +237,8 @@ void __init cpu_select_mitigations(void)
 	mmio_update_mitigation();
 	rfds_update_mitigation();
 	bhi_update_mitigation();
+	/* srso_update_mitigation() depends on retbleed_update_mitigation(). */
+	srso_update_mitigation();
 
 	spectre_v1_apply_mitigation();
 	spectre_v2_apply_mitigation();
@@ -252,6 +251,7 @@ void __init cpu_select_mitigations(void)
 	mmio_apply_mitigation();
 	rfds_apply_mitigation();
 	srbds_apply_mitigation();
+	srso_apply_mitigation();
 	gds_apply_mitigation();
 	bhi_apply_mitigation();
 }
@@ -2674,6 +2674,7 @@ early_param("l1tf", l1tf_cmdline);
 
 enum srso_mitigation {
 	SRSO_MITIGATION_NONE,
+	SRSO_MITIGATION_AUTO,
 	SRSO_MITIGATION_UCODE_NEEDED,
 	SRSO_MITIGATION_SAFE_RET_UCODE_NEEDED,
 	SRSO_MITIGATION_MICROCODE,
@@ -2683,14 +2684,6 @@ enum srso_mitigation {
 	SRSO_MITIGATION_BP_SPEC_REDUCE,
 };
 
-enum srso_mitigation_cmd {
-	SRSO_CMD_OFF,
-	SRSO_CMD_MICROCODE,
-	SRSO_CMD_SAFE_RET,
-	SRSO_CMD_IBPB,
-	SRSO_CMD_IBPB_ON_VMEXIT,
-};
-
 static const char * const srso_strings[] = {
 	[SRSO_MITIGATION_NONE]			= "Vulnerable",
 	[SRSO_MITIGATION_UCODE_NEEDED]		= "Vulnerable: No microcode",
@@ -2702,8 +2695,7 @@ static const char * const srso_strings[] = {
 	[SRSO_MITIGATION_BP_SPEC_REDUCE]	= "Mitigation: Reduced Speculation"
 };
 
-static enum srso_mitigation srso_mitigation __ro_after_init = SRSO_MITIGATION_NONE;
-static enum srso_mitigation_cmd srso_cmd __ro_after_init = SRSO_CMD_SAFE_RET;
+static enum srso_mitigation srso_mitigation __ro_after_init = SRSO_MITIGATION_AUTO;
 
 static int __init srso_parse_cmdline(char *str)
 {
@@ -2711,15 +2703,15 @@ static int __init srso_parse_cmdline(char *str)
 		return -EINVAL;
 
 	if (!strcmp(str, "off"))
-		srso_cmd = SRSO_CMD_OFF;
+		srso_mitigation = SRSO_MITIGATION_NONE;
 	else if (!strcmp(str, "microcode"))
-		srso_cmd = SRSO_CMD_MICROCODE;
+		srso_mitigation = SRSO_MITIGATION_MICROCODE;
 	else if (!strcmp(str, "safe-ret"))
-		srso_cmd = SRSO_CMD_SAFE_RET;
+		srso_mitigation = SRSO_MITIGATION_SAFE_RET;
 	else if (!strcmp(str, "ibpb"))
-		srso_cmd = SRSO_CMD_IBPB;
+		srso_mitigation = SRSO_MITIGATION_IBPB;
 	else if (!strcmp(str, "ibpb-vmexit"))
-		srso_cmd = SRSO_CMD_IBPB_ON_VMEXIT;
+		srso_mitigation = SRSO_MITIGATION_IBPB_ON_VMEXIT;
 	else
 		pr_err("Ignoring unknown SRSO option (%s).", str);
 
@@ -2731,132 +2723,83 @@ early_param("spec_rstack_overflow", srso_parse_cmdline);
 
 static void __init srso_select_mitigation(void)
 {
-	bool has_microcode = boot_cpu_has(X86_FEATURE_IBPB_BRTYPE);
+	bool has_microcode;
 
-	if (!boot_cpu_has_bug(X86_BUG_SRSO) ||
-	    cpu_mitigations_off() ||
-	    srso_cmd == SRSO_CMD_OFF) {
-		if (boot_cpu_has(X86_FEATURE_SBPB))
-			x86_pred_cmd = PRED_CMD_SBPB;
-		goto out;
-	}
+	if (!boot_cpu_has_bug(X86_BUG_SRSO) || cpu_mitigations_off())
+		srso_mitigation = SRSO_MITIGATION_NONE;
 
+	if (srso_mitigation == SRSO_MITIGATION_NONE)
+		return;
+
+	if (srso_mitigation == SRSO_MITIGATION_AUTO)
+		srso_mitigation = SRSO_MITIGATION_SAFE_RET;
+
+	has_microcode = boot_cpu_has(X86_FEATURE_IBPB_BRTYPE);
 	if (has_microcode) {
 		/*
 		 * Zen1/2 with SMT off aren't vulnerable after the right
 		 * IBPB microcode has been applied.
-		 *
-		 * Zen1/2 don't have SBPB, no need to try to enable it here.
 		 */
 		if (boot_cpu_data.x86 < 0x19 && !cpu_smt_possible()) {
 			setup_force_cpu_cap(X86_FEATURE_SRSO_NO);
-			goto out;
-		}
-
-		if (retbleed_mitigation == RETBLEED_MITIGATION_IBPB) {
-			srso_mitigation = SRSO_MITIGATION_IBPB;
-			goto out;
+			srso_mitigation = SRSO_MITIGATION_NONE;
+			return;
 		}
 	} else {
 		pr_warn("IBPB-extending microcode not applied!\n");
 		pr_warn(SRSO_NOTICE);
-
-		/* may be overwritten by SRSO_CMD_SAFE_RET below */
-		srso_mitigation = SRSO_MITIGATION_UCODE_NEEDED;
 	}
 
-	switch (srso_cmd) {
-	case SRSO_CMD_MICROCODE:
-		if (has_microcode) {
-			srso_mitigation = SRSO_MITIGATION_MICROCODE;
-			pr_warn(SRSO_NOTICE);
-		}
-		break;
-
-	case SRSO_CMD_SAFE_RET:
-		if (boot_cpu_has(X86_FEATURE_SRSO_USER_KERNEL_NO))
+	switch (srso_mitigation) {
+	case SRSO_MITIGATION_SAFE_RET:
+		if (boot_cpu_has(X86_FEATURE_SRSO_USER_KERNEL_NO)) {
+			srso_mitigation = SRSO_MITIGATION_IBPB_ON_VMEXIT;
 			goto ibpb_on_vmexit;
+		}
 
-		if (IS_ENABLED(CONFIG_MITIGATION_SRSO)) {
-			/*
-			 * Enable the return thunk for generated code
-			 * like ftrace, static_call, etc.
-			 */
-			setup_force_cpu_cap(X86_FEATURE_RETHUNK);
-			setup_force_cpu_cap(X86_FEATURE_UNRET);
-
-			if (boot_cpu_data.x86 == 0x19) {
-				setup_force_cpu_cap(X86_FEATURE_SRSO_ALIAS);
-				x86_return_thunk = srso_alias_return_thunk;
-			} else {
-				setup_force_cpu_cap(X86_FEATURE_SRSO);
-				x86_return_thunk = srso_return_thunk;
-			}
-			if (has_microcode)
-				srso_mitigation = SRSO_MITIGATION_SAFE_RET;
-			else
-				srso_mitigation = SRSO_MITIGATION_SAFE_RET_UCODE_NEEDED;
-		} else {
+		if (!IS_ENABLED(CONFIG_MITIGATION_SRSO)) {
 			pr_err("WARNING: kernel not compiled with MITIGATION_SRSO.\n");
+			srso_mitigation = SRSO_MITIGATION_NONE;
 		}
-		break;
 
-	case SRSO_CMD_IBPB:
-		if (IS_ENABLED(CONFIG_MITIGATION_IBPB_ENTRY)) {
-			if (has_microcode) {
-				setup_force_cpu_cap(X86_FEATURE_ENTRY_IBPB);
-				setup_force_cpu_cap(X86_FEATURE_IBPB_ON_VMEXIT);
-				srso_mitigation = SRSO_MITIGATION_IBPB;
-
-				/*
-				 * IBPB on entry already obviates the need for
-				 * software-based untraining so clear those in case some
-				 * other mitigation like Retbleed has selected them.
-				 */
-				setup_clear_cpu_cap(X86_FEATURE_UNRET);
-				setup_clear_cpu_cap(X86_FEATURE_RETHUNK);
-
-				/*
-				 * There is no need for RSB filling: write_ibpb() ensures
-				 * all predictions, including the RSB, are invalidated,
-				 * regardless of IBPB implementation.
-				 */
-				setup_clear_cpu_cap(X86_FEATURE_RSB_VMEXIT);
-			}
-		} else {
-			pr_err("WARNING: kernel not compiled with MITIGATION_IBPB_ENTRY.\n");
-		}
+		if (!has_microcode)
+			srso_mitigation = SRSO_MITIGATION_SAFE_RET_UCODE_NEEDED;
 		break;
-
 ibpb_on_vmexit:
-	case SRSO_CMD_IBPB_ON_VMEXIT:
+	case SRSO_MITIGATION_IBPB_ON_VMEXIT:
 		if (boot_cpu_has(X86_FEATURE_SRSO_BP_SPEC_REDUCE)) {
 			pr_notice("Reducing speculation to address VM/HV SRSO attack vector.\n");
 			srso_mitigation = SRSO_MITIGATION_BP_SPEC_REDUCE;
 			break;
 		}
-
-		if (IS_ENABLED(CONFIG_MITIGATION_IBPB_ENTRY)) {
-			if (has_microcode) {
-				setup_force_cpu_cap(X86_FEATURE_IBPB_ON_VMEXIT);
-				srso_mitigation = SRSO_MITIGATION_IBPB_ON_VMEXIT;
-
-				/*
-				 * There is no need for RSB filling: write_ibpb() ensures
-				 * all predictions, including the RSB, are invalidated,
-				 * regardless of IBPB implementation.
-				 */
-				setup_clear_cpu_cap(X86_FEATURE_RSB_VMEXIT);
-			}
-		} else {
+		fallthrough;
+	case SRSO_MITIGATION_IBPB:
+		if (!IS_ENABLED(CONFIG_MITIGATION_IBPB_ENTRY)) {
 			pr_err("WARNING: kernel not compiled with MITIGATION_IBPB_ENTRY.\n");
+			srso_mitigation = SRSO_MITIGATION_NONE;
 		}
+
+		if (!has_microcode)
+			srso_mitigation = SRSO_MITIGATION_UCODE_NEEDED;
 		break;
 	default:
 		break;
 	}
+}
 
-out:
+static void __init srso_update_mitigation(void)
+{
+	/* If retbleed is using IBPB, that works for SRSO as well */
+	if (retbleed_mitigation == RETBLEED_MITIGATION_IBPB &&
+	    boot_cpu_has(X86_FEATURE_IBPB_BRTYPE))
+		srso_mitigation = SRSO_MITIGATION_IBPB;
+
+	if (boot_cpu_has_bug(X86_BUG_SRSO) && !cpu_mitigations_off())
+		pr_info("%s\n", srso_strings[srso_mitigation]);
+}
+
+static void __init srso_apply_mitigation(void)
+{
 	/*
 	 * Clear the feature flag if this mitigation is not selected as that
 	 * feature flag controls the BpSpecReduce MSR bit toggling in KVM.
@@ -2864,8 +2807,52 @@ out:
 	if (srso_mitigation != SRSO_MITIGATION_BP_SPEC_REDUCE)
 		setup_clear_cpu_cap(X86_FEATURE_SRSO_BP_SPEC_REDUCE);
 
-	if (srso_mitigation != SRSO_MITIGATION_NONE)
-		pr_info("%s\n", srso_strings[srso_mitigation]);
+	if (srso_mitigation == SRSO_MITIGATION_NONE) {
+		if (boot_cpu_has(X86_FEATURE_SBPB))
+			x86_pred_cmd = PRED_CMD_SBPB;
+		return;
+	}
+
+	switch (srso_mitigation) {
+	case SRSO_MITIGATION_SAFE_RET:
+	case SRSO_MITIGATION_SAFE_RET_UCODE_NEEDED:
+		/*
+		 * Enable the return thunk for generated code
+		 * like ftrace, static_call, etc.
+		 */
+		setup_force_cpu_cap(X86_FEATURE_RETHUNK);
+		setup_force_cpu_cap(X86_FEATURE_UNRET);
+
+		if (boot_cpu_data.x86 == 0x19) {
+			setup_force_cpu_cap(X86_FEATURE_SRSO_ALIAS);
+			x86_return_thunk = srso_alias_return_thunk;
+		} else {
+			setup_force_cpu_cap(X86_FEATURE_SRSO);
+			x86_return_thunk = srso_return_thunk;
+		}
+		break;
+	case SRSO_MITIGATION_IBPB:
+		setup_force_cpu_cap(X86_FEATURE_ENTRY_IBPB);
+		/*
+		 * IBPB on entry already obviates the need for
+		 * software-based untraining so clear those in case some
+		 * other mitigation like Retbleed has selected them.
+		 */
+		setup_clear_cpu_cap(X86_FEATURE_UNRET);
+		setup_clear_cpu_cap(X86_FEATURE_RETHUNK);
+		fallthrough;
+	case SRSO_MITIGATION_IBPB_ON_VMEXIT:
+		setup_force_cpu_cap(X86_FEATURE_IBPB_ON_VMEXIT);
+		/*
+		 * There is no need for RSB filling: entry_ibpb() ensures
+		 * all predictions, including the RSB, are invalidated,
+		 * regardless of IBPB implementation.
+		 */
+		setup_clear_cpu_cap(X86_FEATURE_RSB_VMEXIT);
+		break;
+	default:
+		break;
+	}
 }
 
 #undef pr_fmt

