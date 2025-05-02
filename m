Return-Path: <linux-tip-commits+bounces-5183-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 02AC8AA6FB7
	for <lists+linux-tip-commits@lfdr.de>; Fri,  2 May 2025 12:33:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5BF554A820C
	for <lists+linux-tip-commits@lfdr.de>; Fri,  2 May 2025 10:33:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2E4C241697;
	Fri,  2 May 2025 10:33:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="cp1/+YFp";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Ad/iEdUz"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D52819D07B;
	Fri,  2 May 2025 10:33:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746182011; cv=none; b=UP3pPEYkFPDIPqP4Fs4yUjm20hh1iBA2iPqKkcJV+bPU6qcpiDUHNtDNxF+04Meg5kIfjEIiertrp3ctvCt4ikEiJ6GxdBImjZRZZJBB2JCnKBPRRHXzWtQdsLBgctnP2eMJIRDccdr/VApA/BSfVAtskFcmUPoAiIGwUypufm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746182011; c=relaxed/simple;
	bh=wv/m5XFngLvg5HqCuNwcLS5i2RaGH88tm9vNtPiIMIo=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=mYlxjnv/eGU4p7EUZUutiswFe+VZoTBBdX67tCy7foCkuFfMlMyBnzv8xw+e9sUbAnG4eO16oYnfmEpZvR4cEcxovET1BupHlSrlNNT80GPBLhOONUjBufmqofa5x4vsDT23W5cqNZZLN+4hcbxH+MGdOhdBMSXPbBtM+sxt8ac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=cp1/+YFp; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Ad/iEdUz; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 02 May 2025 10:33:26 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1746182007;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yrD0LDWBY7hXJ7TpipTnyw2+BtM90UenpiWZI6ebr6o=;
	b=cp1/+YFpH9XFpOuRkwcQJT34CABSouta5dV8bVNKN4TfuA+4Gr3ixIFy8qDU7eWj+mPGH+
	XaAfvCXBPuSNJZoFLN4QIJLUKBpMuJLrGGQChsEDf6T4gVoukPaCuUhmtugHQ2eaDILQsB
	M9HaL4OllM+E1t4Ad6P6BPnUD4rnQDFFz2ahf4b4II2IQXPOc0X4Qh14BW3hR92g27lICx
	8elqnrrXaHSbPSyOZ8p3r44jJ8XZ7m97FAR5llfQcn7NcWXIm5vGpgnrVNIsRaZuCpbzZ7
	Ox7R1ffIzk25G1lH7ffPq6izAG89prhZ6RlDw1Haex267LKN3F6PNbUnES7CEw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1746182007;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yrD0LDWBY7hXJ7TpipTnyw2+BtM90UenpiWZI6ebr6o=;
	b=Ad/iEdUzdbvzdtKYzeC3IscCE7CqqunxZgeq8D1ijheOgiXr5vHO9/bew13B4Zl1aRrivb
	T4OftI8L+HBRd4Cg==
From: "tip-bot2 for David Kaplan" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/bugs] x86/bugs: Restructure spectre_v2_user mitigation
Cc: David Kaplan <david.kaplan@amd.com>,
 "Borislav Petkov (AMD)" <bp@alien8.de>, Josh Poimboeuf <jpoimboe@kernel.org>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250418161721.1855190-12-david.kaplan@amd.com>
References: <20250418161721.1855190-12-david.kaplan@amd.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174618200650.22196.1931491127552746457.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/bugs branch of tip:

Commit-ID:     ddfca9430a617780c8ad9691bf44660ae49e2a35
Gitweb:        https://git.kernel.org/tip/ddfca9430a617780c8ad9691bf44660ae49e2a35
Author:        David Kaplan <david.kaplan@amd.com>
AuthorDate:    Fri, 18 Apr 2025 11:17:16 -05:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Tue, 29 Apr 2025 18:51:21 +02:00

x86/bugs: Restructure spectre_v2_user mitigation

Restructure spectre_v2_user to use select/update/apply functions to
create consistent vulnerability handling.

The IBPB/STIBP choices are first decided based on the spectre_v2_user
command line but can be modified by the spectre_v2 command line option
as well.

Signed-off-by: David Kaplan <david.kaplan@amd.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Josh Poimboeuf <jpoimboe@kernel.org>
Link: https://lore.kernel.org/20250418161721.1855190-12-david.kaplan@amd.com
---
 arch/x86/kernel/cpu/bugs.c | 168 ++++++++++++++++++++----------------
 1 file changed, 94 insertions(+), 74 deletions(-)

diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index 207a472..dc75195 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -60,6 +60,8 @@ static void __init retbleed_select_mitigation(void);
 static void __init retbleed_update_mitigation(void);
 static void __init retbleed_apply_mitigation(void);
 static void __init spectre_v2_user_select_mitigation(void);
+static void __init spectre_v2_user_update_mitigation(void);
+static void __init spectre_v2_user_apply_mitigation(void);
 static void __init ssb_select_mitigation(void);
 static void __init l1tf_select_mitigation(void);
 static void __init mds_select_mitigation(void);
@@ -190,11 +192,6 @@ void __init cpu_select_mitigations(void)
 	spectre_v1_select_mitigation();
 	spectre_v2_select_mitigation();
 	retbleed_select_mitigation();
-	/*
-	 * spectre_v2_user_select_mitigation() relies on the state set by
-	 * retbleed_select_mitigation(); specifically the STIBP selection is
-	 * forced for UNRET or IBPB.
-	 */
 	spectre_v2_user_select_mitigation();
 	ssb_select_mitigation();
 	l1tf_select_mitigation();
@@ -217,6 +214,13 @@ void __init cpu_select_mitigations(void)
 	 * choices.
 	 */
 	retbleed_update_mitigation();
+
+	/*
+	 * spectre_v2_user_update_mitigation() depends on
+	 * retbleed_update_mitigation(), specifically the STIBP
+	 * selection is forced for UNRET or IBPB.
+	 */
+	spectre_v2_user_update_mitigation();
 	mds_update_mitigation();
 	taa_update_mitigation();
 	mmio_update_mitigation();
@@ -224,6 +228,7 @@ void __init cpu_select_mitigations(void)
 
 	spectre_v1_apply_mitigation();
 	retbleed_apply_mitigation();
+	spectre_v2_user_apply_mitigation();
 	mds_apply_mitigation();
 	taa_apply_mitigation();
 	mmio_apply_mitigation();
@@ -1379,6 +1384,8 @@ enum spectre_v2_mitigation_cmd {
 	SPECTRE_V2_CMD_IBRS,
 };
 
+static enum spectre_v2_mitigation_cmd spectre_v2_cmd __ro_after_init = SPECTRE_V2_CMD_AUTO;
+
 enum spectre_v2_user_cmd {
 	SPECTRE_V2_USER_CMD_NONE,
 	SPECTRE_V2_USER_CMD_AUTO,
@@ -1417,31 +1424,18 @@ static void __init spec_v2_user_print_cond(const char *reason, bool secure)
 		pr_info("spectre_v2_user=%s forced on command line.\n", reason);
 }
 
-static __ro_after_init enum spectre_v2_mitigation_cmd spectre_v2_cmd;
-
-static enum spectre_v2_user_cmd __init
-spectre_v2_parse_user_cmdline(void)
+static enum spectre_v2_user_cmd __init spectre_v2_parse_user_cmdline(void)
 {
-	enum spectre_v2_user_cmd mode;
 	char arg[20];
 	int ret, i;
 
-	mode = IS_ENABLED(CONFIG_MITIGATION_SPECTRE_V2) ?
-		SPECTRE_V2_USER_CMD_AUTO : SPECTRE_V2_USER_CMD_NONE;
-
-	switch (spectre_v2_cmd) {
-	case SPECTRE_V2_CMD_NONE:
+	if (cpu_mitigations_off() || !IS_ENABLED(CONFIG_MITIGATION_SPECTRE_V2))
 		return SPECTRE_V2_USER_CMD_NONE;
-	case SPECTRE_V2_CMD_FORCE:
-		return SPECTRE_V2_USER_CMD_FORCE;
-	default:
-		break;
-	}
 
 	ret = cmdline_find_option(boot_command_line, "spectre_v2_user",
 				  arg, sizeof(arg));
 	if (ret < 0)
-		return mode;
+		return SPECTRE_V2_USER_CMD_AUTO;
 
 	for (i = 0; i < ARRAY_SIZE(v2_user_options); i++) {
 		if (match_option(arg, ret, v2_user_options[i].option)) {
@@ -1452,7 +1446,7 @@ spectre_v2_parse_user_cmdline(void)
 	}
 
 	pr_err("Unknown user space protection option (%s). Switching to default\n", arg);
-	return mode;
+	return SPECTRE_V2_USER_CMD_AUTO;
 }
 
 static inline bool spectre_v2_in_ibrs_mode(enum spectre_v2_mitigation mode)
@@ -1460,60 +1454,72 @@ static inline bool spectre_v2_in_ibrs_mode(enum spectre_v2_mitigation mode)
 	return spectre_v2_in_eibrs_mode(mode) || mode == SPECTRE_V2_IBRS;
 }
 
-static void __init
-spectre_v2_user_select_mitigation(void)
+static void __init spectre_v2_user_select_mitigation(void)
 {
-	enum spectre_v2_user_mitigation mode = SPECTRE_V2_USER_NONE;
-	enum spectre_v2_user_cmd cmd;
-
 	if (!boot_cpu_has(X86_FEATURE_IBPB) && !boot_cpu_has(X86_FEATURE_STIBP))
 		return;
 
-	cmd = spectre_v2_parse_user_cmdline();
-	switch (cmd) {
+	switch (spectre_v2_parse_user_cmdline()) {
 	case SPECTRE_V2_USER_CMD_NONE:
-		goto set_mode;
+		return;
 	case SPECTRE_V2_USER_CMD_FORCE:
-		mode = SPECTRE_V2_USER_STRICT;
+		spectre_v2_user_ibpb  = SPECTRE_V2_USER_STRICT;
+		spectre_v2_user_stibp = SPECTRE_V2_USER_STRICT;
 		break;
 	case SPECTRE_V2_USER_CMD_AUTO:
 	case SPECTRE_V2_USER_CMD_PRCTL:
+		spectre_v2_user_ibpb  = SPECTRE_V2_USER_PRCTL;
+		spectre_v2_user_stibp = SPECTRE_V2_USER_PRCTL;
+		break;
 	case SPECTRE_V2_USER_CMD_PRCTL_IBPB:
-		mode = SPECTRE_V2_USER_PRCTL;
+		spectre_v2_user_ibpb  = SPECTRE_V2_USER_STRICT;
+		spectre_v2_user_stibp = SPECTRE_V2_USER_PRCTL;
 		break;
 	case SPECTRE_V2_USER_CMD_SECCOMP:
+		if (IS_ENABLED(CONFIG_SECCOMP))
+			spectre_v2_user_ibpb = SPECTRE_V2_USER_SECCOMP;
+		else
+			spectre_v2_user_ibpb = SPECTRE_V2_USER_PRCTL;
+		spectre_v2_user_stibp = spectre_v2_user_ibpb;
+		break;
 	case SPECTRE_V2_USER_CMD_SECCOMP_IBPB:
+		spectre_v2_user_ibpb = SPECTRE_V2_USER_STRICT;
 		if (IS_ENABLED(CONFIG_SECCOMP))
-			mode = SPECTRE_V2_USER_SECCOMP;
+			spectre_v2_user_stibp = SPECTRE_V2_USER_SECCOMP;
 		else
-			mode = SPECTRE_V2_USER_PRCTL;
+			spectre_v2_user_stibp = SPECTRE_V2_USER_PRCTL;
 		break;
 	}
 
-	/* Initialize Indirect Branch Prediction Barrier */
-	if (boot_cpu_has(X86_FEATURE_IBPB)) {
-		static_branch_enable(&switch_vcpu_ibpb);
+	/*
+	 * At this point, an STIBP mode other than "off" has been set.
+	 * If STIBP support is not being forced, check if STIBP always-on
+	 * is preferred.
+	 */
+	if ((spectre_v2_user_stibp == SPECTRE_V2_USER_PRCTL ||
+	     spectre_v2_user_stibp == SPECTRE_V2_USER_SECCOMP) &&
+	    boot_cpu_has(X86_FEATURE_AMD_STIBP_ALWAYS_ON))
+		spectre_v2_user_stibp = SPECTRE_V2_USER_STRICT_PREFERRED;
 
-		spectre_v2_user_ibpb = mode;
-		switch (cmd) {
-		case SPECTRE_V2_USER_CMD_NONE:
-			break;
-		case SPECTRE_V2_USER_CMD_FORCE:
-		case SPECTRE_V2_USER_CMD_PRCTL_IBPB:
-		case SPECTRE_V2_USER_CMD_SECCOMP_IBPB:
-			static_branch_enable(&switch_mm_always_ibpb);
-			spectre_v2_user_ibpb = SPECTRE_V2_USER_STRICT;
-			break;
-		case SPECTRE_V2_USER_CMD_PRCTL:
-		case SPECTRE_V2_USER_CMD_AUTO:
-		case SPECTRE_V2_USER_CMD_SECCOMP:
-			static_branch_enable(&switch_mm_cond_ibpb);
-			break;
-		}
+	if (!boot_cpu_has(X86_FEATURE_IBPB))
+		spectre_v2_user_ibpb = SPECTRE_V2_USER_NONE;
 
-		pr_info("mitigation: Enabling %s Indirect Branch Prediction Barrier\n",
-			static_key_enabled(&switch_mm_always_ibpb) ?
-			"always-on" : "conditional");
+	if (!boot_cpu_has(X86_FEATURE_STIBP))
+		spectre_v2_user_stibp = SPECTRE_V2_USER_NONE;
+}
+
+static void __init spectre_v2_user_update_mitigation(void)
+{
+	if (!boot_cpu_has(X86_FEATURE_IBPB) && !boot_cpu_has(X86_FEATURE_STIBP))
+		return;
+
+	/* The spectre_v2 cmd line can override spectre_v2_user options */
+	if (spectre_v2_cmd == SPECTRE_V2_CMD_NONE) {
+		spectre_v2_user_ibpb = SPECTRE_V2_USER_NONE;
+		spectre_v2_user_stibp = SPECTRE_V2_USER_NONE;
+	} else if (spectre_v2_cmd == SPECTRE_V2_CMD_FORCE) {
+		spectre_v2_user_ibpb = SPECTRE_V2_USER_STRICT;
+		spectre_v2_user_stibp = SPECTRE_V2_USER_STRICT;
 	}
 
 	/*
@@ -1531,30 +1537,44 @@ spectre_v2_user_select_mitigation(void)
 	if (!boot_cpu_has(X86_FEATURE_STIBP) ||
 	    !cpu_smt_possible() ||
 	    (spectre_v2_in_eibrs_mode(spectre_v2_enabled) &&
-	     !boot_cpu_has(X86_FEATURE_AUTOIBRS)))
+	     !boot_cpu_has(X86_FEATURE_AUTOIBRS))) {
+		spectre_v2_user_stibp = SPECTRE_V2_USER_NONE;
 		return;
+	}
 
-	/*
-	 * At this point, an STIBP mode other than "off" has been set.
-	 * If STIBP support is not being forced, check if STIBP always-on
-	 * is preferred.
-	 */
-	if (mode != SPECTRE_V2_USER_STRICT &&
-	    boot_cpu_has(X86_FEATURE_AMD_STIBP_ALWAYS_ON))
-		mode = SPECTRE_V2_USER_STRICT_PREFERRED;
-
-	if (retbleed_mitigation == RETBLEED_MITIGATION_UNRET ||
-	    retbleed_mitigation == RETBLEED_MITIGATION_IBPB) {
-		if (mode != SPECTRE_V2_USER_STRICT &&
-		    mode != SPECTRE_V2_USER_STRICT_PREFERRED)
+	if (spectre_v2_user_stibp != SPECTRE_V2_USER_NONE &&
+	    (retbleed_mitigation == RETBLEED_MITIGATION_UNRET ||
+	     retbleed_mitigation == RETBLEED_MITIGATION_IBPB)) {
+		if (spectre_v2_user_stibp != SPECTRE_V2_USER_STRICT &&
+		    spectre_v2_user_stibp != SPECTRE_V2_USER_STRICT_PREFERRED)
 			pr_info("Selecting STIBP always-on mode to complement retbleed mitigation\n");
-		mode = SPECTRE_V2_USER_STRICT_PREFERRED;
+		spectre_v2_user_stibp = SPECTRE_V2_USER_STRICT_PREFERRED;
 	}
+	pr_info("%s\n", spectre_v2_user_strings[spectre_v2_user_stibp]);
+}
 
-	spectre_v2_user_stibp = mode;
+static void __init spectre_v2_user_apply_mitigation(void)
+{
+	/* Initialize Indirect Branch Prediction Barrier */
+	if (spectre_v2_user_ibpb != SPECTRE_V2_USER_NONE) {
+		static_branch_enable(&switch_vcpu_ibpb);
+
+		switch (spectre_v2_user_ibpb) {
+		case SPECTRE_V2_USER_STRICT:
+			static_branch_enable(&switch_mm_always_ibpb);
+			break;
+		case SPECTRE_V2_USER_PRCTL:
+		case SPECTRE_V2_USER_SECCOMP:
+			static_branch_enable(&switch_mm_cond_ibpb);
+			break;
+		default:
+			break;
+		}
 
-set_mode:
-	pr_info("%s\n", spectre_v2_user_strings[mode]);
+		pr_info("mitigation: Enabling %s Indirect Branch Prediction Barrier\n",
+			static_key_enabled(&switch_mm_always_ibpb) ?
+			"always-on" : "conditional");
+	}
 }
 
 static const char * const spectre_v2_strings[] = {

