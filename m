Return-Path: <linux-tip-commits+bounces-5184-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A2BFAAA6FB8
	for <lists+linux-tip-commits@lfdr.de>; Fri,  2 May 2025 12:33:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B09E09A0B7F
	for <lists+linux-tip-commits@lfdr.de>; Fri,  2 May 2025 10:33:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C07CB2417C5;
	Fri,  2 May 2025 10:33:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Y2OURHLQ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Zt9tMqgO"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF39D23E25A;
	Fri,  2 May 2025 10:33:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746182011; cv=none; b=OttZOoqbqM7dZWuQB/8oSeHq71JXSxcPsdkqDDWGRQfzbY0fMJybZDgZ+byaDr0oQQ5RjPMsU0y0sepkdadPu6tF+YfWay2pf3TbZZ61aYMPRt0lsYmQ3J3genVRvnkw67PfKmm0nzsUtWQnIiqpG1UOgDcbeBKIQUVs2+t6fkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746182011; c=relaxed/simple;
	bh=NVcf5ekFlTExlawjl9eiqCYgk6OCpjocGIJAkR89sv8=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=YHnTczObka9W+3lwHawBuYPh0HMhCycOspxVB/fi7zaXxH+vZOakaRgQ4SbaMjN4PNqdFXGpu5c5KyGqTucZCQ7NKXam8qvafWfDzH2bMWoEawMHXS18oTknqN+ZXT/ySaqOVCM2Me9T3rdn8G8L1KRuK5K84MM29fdj0sH5gr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Y2OURHLQ; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Zt9tMqgO; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 02 May 2025 10:33:27 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1746182008;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ixE3SxPYP+L949DCopHPJqzgbBUQzIpL+pxdNZpZRs0=;
	b=Y2OURHLQ8s+uwrgzvo/RuXchRgxk/xDYMCIM52wAUiDP327tFSWhWnQNhTodLSWgm6dGbr
	47SmcBh8gggo83JPwbjiMRLwzT+jF9eUj74yKf6yNLFwnCHyg1z6X62PkiKEwjNzpLnwoH
	DE3es/echhIX9F8c5AeeNfu4V9NtqkM7sMe65Qx8pgP2F+lTj2YjA5m/vUGgV05TwQD1QV
	4Tmv6FhnuhG8z3doKMIPfU22m6BX7jAf7RU15JIT5uTFneg8+LKAmvC0u2p2mJxZTbaKfj
	HlJjGqaz1nNbtzqBZivvtFwnZufcwVvY5kKBgTwIezTkBrn/ZGpPpEYpd/r4xA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1746182008;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ixE3SxPYP+L949DCopHPJqzgbBUQzIpL+pxdNZpZRs0=;
	b=Zt9tMqgOFfFHsJHZHyeVa2b3IwAuf+mYGB0NFTk/JQu95VJgjOXdB/zzWu1wFrms037WtL
	lI8jdSj4KsmJ//CA==
From: "tip-bot2 for David Kaplan" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/bugs] x86/bugs: Restructure retbleed mitigation
Cc: David Kaplan <david.kaplan@amd.com>,
 "Borislav Petkov (AMD)" <bp@alien8.de>, Josh Poimboeuf <jpoimboe@kernel.org>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250418161721.1855190-11-david.kaplan@amd.com>
References: <20250418161721.1855190-11-david.kaplan@amd.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174618200717.22196.8651223091467963937.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/bugs branch of tip:

Commit-ID:     e3b78a7ad5ea718ea1dbaeb02ba9a6aa2aee9324
Gitweb:        https://git.kernel.org/tip/e3b78a7ad5ea718ea1dbaeb02ba9a6aa2aee9324
Author:        David Kaplan <david.kaplan@amd.com>
AuthorDate:    Fri, 18 Apr 2025 11:17:15 -05:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Tue, 29 Apr 2025 10:22:08 +02:00

x86/bugs: Restructure retbleed mitigation

Restructure retbleed mitigation to use select/update/apply functions to create
consistent vulnerability handling.  The retbleed_update_mitigation()
simplifies the dependency between spectre_v2 and retbleed.

The command line options now directly select a preferred mitigation
which simplifies the logic.

Signed-off-by: David Kaplan <david.kaplan@amd.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Josh Poimboeuf <jpoimboe@kernel.org>
Link: https://lore.kernel.org/20250418161721.1855190-11-david.kaplan@amd.com
---
 arch/x86/kernel/cpu/bugs.c | 195 ++++++++++++++++++------------------
 1 file changed, 98 insertions(+), 97 deletions(-)

diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index 7edf429..207a472 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -57,6 +57,8 @@ static void __init spectre_v1_select_mitigation(void);
 static void __init spectre_v1_apply_mitigation(void);
 static void __init spectre_v2_select_mitigation(void);
 static void __init retbleed_select_mitigation(void);
+static void __init retbleed_update_mitigation(void);
+static void __init retbleed_apply_mitigation(void);
 static void __init spectre_v2_user_select_mitigation(void);
 static void __init ssb_select_mitigation(void);
 static void __init l1tf_select_mitigation(void);
@@ -187,11 +189,6 @@ void __init cpu_select_mitigations(void)
 	/* Select the proper CPU mitigations before patching alternatives: */
 	spectre_v1_select_mitigation();
 	spectre_v2_select_mitigation();
-	/*
-	 * retbleed_select_mitigation() relies on the state set by
-	 * spectre_v2_select_mitigation(); specifically it wants to know about
-	 * spectre_v2=ibrs.
-	 */
 	retbleed_select_mitigation();
 	/*
 	 * spectre_v2_user_select_mitigation() relies on the state set by
@@ -219,12 +216,14 @@ void __init cpu_select_mitigations(void)
 	 * After mitigations are selected, some may need to update their
 	 * choices.
 	 */
+	retbleed_update_mitigation();
 	mds_update_mitigation();
 	taa_update_mitigation();
 	mmio_update_mitigation();
 	rfds_update_mitigation();
 
 	spectre_v1_apply_mitigation();
+	retbleed_apply_mitigation();
 	mds_apply_mitigation();
 	taa_apply_mitigation();
 	mmio_apply_mitigation();
@@ -1085,6 +1084,7 @@ enum spectre_v2_mitigation spectre_v2_enabled __ro_after_init = SPECTRE_V2_NONE;
 
 enum retbleed_mitigation {
 	RETBLEED_MITIGATION_NONE,
+	RETBLEED_MITIGATION_AUTO,
 	RETBLEED_MITIGATION_UNRET,
 	RETBLEED_MITIGATION_IBPB,
 	RETBLEED_MITIGATION_IBRS,
@@ -1092,14 +1092,6 @@ enum retbleed_mitigation {
 	RETBLEED_MITIGATION_STUFF,
 };
 
-enum retbleed_mitigation_cmd {
-	RETBLEED_CMD_OFF,
-	RETBLEED_CMD_AUTO,
-	RETBLEED_CMD_UNRET,
-	RETBLEED_CMD_IBPB,
-	RETBLEED_CMD_STUFF,
-};
-
 static const char * const retbleed_strings[] = {
 	[RETBLEED_MITIGATION_NONE]	= "Vulnerable",
 	[RETBLEED_MITIGATION_UNRET]	= "Mitigation: untrained return thunk",
@@ -1110,9 +1102,7 @@ static const char * const retbleed_strings[] = {
 };
 
 static enum retbleed_mitigation retbleed_mitigation __ro_after_init =
-	RETBLEED_MITIGATION_NONE;
-static enum retbleed_mitigation_cmd retbleed_cmd __ro_after_init =
-	IS_ENABLED(CONFIG_MITIGATION_RETBLEED) ? RETBLEED_CMD_AUTO : RETBLEED_CMD_OFF;
+	IS_ENABLED(CONFIG_MITIGATION_RETBLEED) ? RETBLEED_MITIGATION_AUTO : RETBLEED_MITIGATION_NONE;
 
 static int __ro_after_init retbleed_nosmt = false;
 
@@ -1129,15 +1119,15 @@ static int __init retbleed_parse_cmdline(char *str)
 		}
 
 		if (!strcmp(str, "off")) {
-			retbleed_cmd = RETBLEED_CMD_OFF;
+			retbleed_mitigation = RETBLEED_MITIGATION_NONE;
 		} else if (!strcmp(str, "auto")) {
-			retbleed_cmd = RETBLEED_CMD_AUTO;
+			retbleed_mitigation = RETBLEED_MITIGATION_AUTO;
 		} else if (!strcmp(str, "unret")) {
-			retbleed_cmd = RETBLEED_CMD_UNRET;
+			retbleed_mitigation = RETBLEED_MITIGATION_UNRET;
 		} else if (!strcmp(str, "ibpb")) {
-			retbleed_cmd = RETBLEED_CMD_IBPB;
+			retbleed_mitigation = RETBLEED_MITIGATION_IBPB;
 		} else if (!strcmp(str, "stuff")) {
-			retbleed_cmd = RETBLEED_CMD_STUFF;
+			retbleed_mitigation = RETBLEED_MITIGATION_STUFF;
 		} else if (!strcmp(str, "nosmt")) {
 			retbleed_nosmt = true;
 		} else if (!strcmp(str, "force")) {
@@ -1158,76 +1148,109 @@ early_param("retbleed", retbleed_parse_cmdline);
 
 static void __init retbleed_select_mitigation(void)
 {
-	bool mitigate_smt = false;
-
-	if (!boot_cpu_has_bug(X86_BUG_RETBLEED) || cpu_mitigations_off())
-		return;
-
-	switch (retbleed_cmd) {
-	case RETBLEED_CMD_OFF:
+	if (!boot_cpu_has_bug(X86_BUG_RETBLEED) || cpu_mitigations_off()) {
+		retbleed_mitigation = RETBLEED_MITIGATION_NONE;
 		return;
+	}
 
-	case RETBLEED_CMD_UNRET:
-		if (IS_ENABLED(CONFIG_MITIGATION_UNRET_ENTRY)) {
-			retbleed_mitigation = RETBLEED_MITIGATION_UNRET;
-		} else {
+	switch (retbleed_mitigation) {
+	case RETBLEED_MITIGATION_UNRET:
+		if (!IS_ENABLED(CONFIG_MITIGATION_UNRET_ENTRY)) {
+			retbleed_mitigation = RETBLEED_MITIGATION_AUTO;
 			pr_err("WARNING: kernel not compiled with MITIGATION_UNRET_ENTRY.\n");
-			goto do_cmd_auto;
 		}
 		break;
-
-	case RETBLEED_CMD_IBPB:
+	case RETBLEED_MITIGATION_IBPB:
 		if (!boot_cpu_has(X86_FEATURE_IBPB)) {
 			pr_err("WARNING: CPU does not support IBPB.\n");
-			goto do_cmd_auto;
-		} else if (IS_ENABLED(CONFIG_MITIGATION_IBPB_ENTRY)) {
-			retbleed_mitigation = RETBLEED_MITIGATION_IBPB;
-		} else {
+			retbleed_mitigation = RETBLEED_MITIGATION_AUTO;
+		} else if (!IS_ENABLED(CONFIG_MITIGATION_IBPB_ENTRY)) {
 			pr_err("WARNING: kernel not compiled with MITIGATION_IBPB_ENTRY.\n");
-			goto do_cmd_auto;
+			retbleed_mitigation = RETBLEED_MITIGATION_AUTO;
+		}
+		break;
+	case RETBLEED_MITIGATION_STUFF:
+		if (!IS_ENABLED(CONFIG_MITIGATION_CALL_DEPTH_TRACKING)) {
+			pr_err("WARNING: kernel not compiled with MITIGATION_CALL_DEPTH_TRACKING.\n");
+			retbleed_mitigation = RETBLEED_MITIGATION_AUTO;
+		} else if (boot_cpu_data.x86_vendor != X86_VENDOR_INTEL) {
+			pr_err("WARNING: retbleed=stuff only supported for Intel CPUs.\n");
+			retbleed_mitigation = RETBLEED_MITIGATION_AUTO;
 		}
 		break;
+	default:
+		break;
+	}
 
-	case RETBLEED_CMD_STUFF:
-		if (IS_ENABLED(CONFIG_MITIGATION_CALL_DEPTH_TRACKING) &&
-		    spectre_v2_enabled == SPECTRE_V2_RETPOLINE) {
-			if (boot_cpu_data.x86_vendor != X86_VENDOR_INTEL) {
-				pr_err("WARNING: retbleed=stuff only supported for Intel CPUs.\n");
-				goto do_cmd_auto;
-			}
-			retbleed_mitigation = RETBLEED_MITIGATION_STUFF;
+	if (retbleed_mitigation != RETBLEED_MITIGATION_AUTO)
+		return;
 
-		} else {
-			if (IS_ENABLED(CONFIG_MITIGATION_CALL_DEPTH_TRACKING))
-				pr_err("WARNING: retbleed=stuff depends on spectre_v2=retpoline\n");
-			else
-				pr_err("WARNING: kernel not compiled with MITIGATION_CALL_DEPTH_TRACKING.\n");
+	/* Intel mitigation selected in retbleed_update_mitigation() */
+	if (boot_cpu_data.x86_vendor == X86_VENDOR_AMD ||
+	    boot_cpu_data.x86_vendor == X86_VENDOR_HYGON) {
+		if (IS_ENABLED(CONFIG_MITIGATION_UNRET_ENTRY))
+			retbleed_mitigation = RETBLEED_MITIGATION_UNRET;
+		else if (IS_ENABLED(CONFIG_MITIGATION_IBPB_ENTRY) &&
+			 boot_cpu_has(X86_FEATURE_IBPB))
+			retbleed_mitigation = RETBLEED_MITIGATION_IBPB;
+		else
+			retbleed_mitigation = RETBLEED_MITIGATION_NONE;
+	}
+}
 
-			goto do_cmd_auto;
-		}
-		break;
+static void __init retbleed_update_mitigation(void)
+{
+	if (!boot_cpu_has_bug(X86_BUG_RETBLEED) || cpu_mitigations_off())
+		return;
+
+	if (retbleed_mitigation == RETBLEED_MITIGATION_NONE)
+		goto out;
 
-do_cmd_auto:
-	case RETBLEED_CMD_AUTO:
-		if (boot_cpu_data.x86_vendor == X86_VENDOR_AMD ||
-		    boot_cpu_data.x86_vendor == X86_VENDOR_HYGON) {
-			if (IS_ENABLED(CONFIG_MITIGATION_UNRET_ENTRY))
-				retbleed_mitigation = RETBLEED_MITIGATION_UNRET;
-			else if (IS_ENABLED(CONFIG_MITIGATION_IBPB_ENTRY) &&
-				 boot_cpu_has(X86_FEATURE_IBPB))
-				retbleed_mitigation = RETBLEED_MITIGATION_IBPB;
+	/*
+	 * retbleed=stuff is only allowed on Intel.  If stuffing can't be used
+	 * then a different mitigation will be selected below.
+	 */
+	if (retbleed_mitigation == RETBLEED_MITIGATION_STUFF) {
+		if (spectre_v2_enabled != SPECTRE_V2_RETPOLINE) {
+			pr_err("WARNING: retbleed=stuff depends on spectre_v2=retpoline\n");
+			retbleed_mitigation = RETBLEED_MITIGATION_AUTO;
 		}
+	}
+	/*
+	 * Let IBRS trump all on Intel without affecting the effects of the
+	 * retbleed= cmdline option except for call depth based stuffing
+	 */
+	if (boot_cpu_data.x86_vendor == X86_VENDOR_INTEL) {
+		switch (spectre_v2_enabled) {
+		case SPECTRE_V2_IBRS:
+			retbleed_mitigation = RETBLEED_MITIGATION_IBRS;
+			break;
+		case SPECTRE_V2_EIBRS:
+		case SPECTRE_V2_EIBRS_RETPOLINE:
+		case SPECTRE_V2_EIBRS_LFENCE:
+			retbleed_mitigation = RETBLEED_MITIGATION_EIBRS;
+			break;
+		default:
+			if (retbleed_mitigation != RETBLEED_MITIGATION_STUFF)
+				pr_err(RETBLEED_INTEL_MSG);
+		}
+		/* If nothing has set the mitigation yet, default to NONE. */
+		if (retbleed_mitigation == RETBLEED_MITIGATION_AUTO)
+			retbleed_mitigation = RETBLEED_MITIGATION_NONE;
+	}
+out:
+	pr_info("%s\n", retbleed_strings[retbleed_mitigation]);
+}
 
-		/*
-		 * The Intel mitigation (IBRS or eIBRS) was already selected in
-		 * spectre_v2_select_mitigation().  'retbleed_mitigation' will
-		 * be set accordingly below.
-		 */
 
-		break;
-	}
+static void __init retbleed_apply_mitigation(void)
+{
+	bool mitigate_smt = false;
 
 	switch (retbleed_mitigation) {
+	case RETBLEED_MITIGATION_NONE:
+		return;
+
 	case RETBLEED_MITIGATION_UNRET:
 		setup_force_cpu_cap(X86_FEATURE_RETHUNK);
 		setup_force_cpu_cap(X86_FEATURE_UNRET);
@@ -1277,28 +1300,6 @@ do_cmd_auto:
 	if (mitigate_smt && !boot_cpu_has(X86_FEATURE_STIBP) &&
 	    (retbleed_nosmt || cpu_mitigations_auto_nosmt()))
 		cpu_smt_disable(false);
-
-	/*
-	 * Let IBRS trump all on Intel without affecting the effects of the
-	 * retbleed= cmdline option except for call depth based stuffing
-	 */
-	if (boot_cpu_data.x86_vendor == X86_VENDOR_INTEL) {
-		switch (spectre_v2_enabled) {
-		case SPECTRE_V2_IBRS:
-			retbleed_mitigation = RETBLEED_MITIGATION_IBRS;
-			break;
-		case SPECTRE_V2_EIBRS:
-		case SPECTRE_V2_EIBRS_RETPOLINE:
-		case SPECTRE_V2_EIBRS_LFENCE:
-			retbleed_mitigation = RETBLEED_MITIGATION_EIBRS;
-			break;
-		default:
-			if (retbleed_mitigation != RETBLEED_MITIGATION_STUFF)
-				pr_err(RETBLEED_INTEL_MSG);
-		}
-	}
-
-	pr_info("%s\n", retbleed_strings[retbleed_mitigation]);
 }
 
 #undef pr_fmt
@@ -1855,8 +1856,8 @@ static void __init spectre_v2_select_mitigation(void)
 
 		if (IS_ENABLED(CONFIG_MITIGATION_IBRS_ENTRY) &&
 		    boot_cpu_has_bug(X86_BUG_RETBLEED) &&
-		    retbleed_cmd != RETBLEED_CMD_OFF &&
-		    retbleed_cmd != RETBLEED_CMD_STUFF &&
+		    retbleed_mitigation != RETBLEED_MITIGATION_NONE &&
+		    retbleed_mitigation != RETBLEED_MITIGATION_STUFF &&
 		    boot_cpu_has(X86_FEATURE_IBRS) &&
 		    boot_cpu_data.x86_vendor == X86_VENDOR_INTEL) {
 			mode = SPECTRE_V2_IBRS;
@@ -1964,7 +1965,7 @@ static void __init spectre_v2_select_mitigation(void)
 	    (boot_cpu_data.x86_vendor == X86_VENDOR_AMD ||
 	     boot_cpu_data.x86_vendor == X86_VENDOR_HYGON)) {
 
-		if (retbleed_cmd != RETBLEED_CMD_IBPB) {
+		if (retbleed_mitigation != RETBLEED_MITIGATION_IBPB) {
 			setup_force_cpu_cap(X86_FEATURE_USE_IBPB_FW);
 			pr_info("Enabling Speculation Barrier for firmware calls\n");
 		}

