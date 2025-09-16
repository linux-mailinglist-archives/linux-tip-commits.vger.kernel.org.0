Return-Path: <linux-tip-commits+bounces-6656-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D5DEB596B5
	for <lists+linux-tip-commits@lfdr.de>; Tue, 16 Sep 2025 14:55:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3517B324ED2
	for <lists+linux-tip-commits@lfdr.de>; Tue, 16 Sep 2025 12:55:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F1D130F812;
	Tue, 16 Sep 2025 12:54:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="u+9k3Kae";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Et2TJfNe"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 531462DBF49;
	Tue, 16 Sep 2025 12:54:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758027278; cv=none; b=QkWhq6rGRMdg1dcF/0ncvt76uJtSR8hnXawnAhZxw+m6aswKkWU/8MA1fPj+cToMKDRAPOAsrBCAwADppdtOV667cgVJ6y7uI9ZHrCBMhzwDs6Pr56HCSqeJIeXjHIdxG6y+I4s9CuR1zmAoXYx94LgPQwXYwOxxRG9yqHMjVDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758027278; c=relaxed/simple;
	bh=VXb5aEIhxSZ55U/1hW69ItNwZJJZqxCEhPJP8UVqK8s=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=URx8vrLSMmAV4fsfVv1uMYQJ56KLd5sesTt1fRypoEWcKw/OU+ZI0Ukzcpj94IxmVeIUWE8w+J+a7zyoFXFEh4AhrXYXHIfb9OuaF5UxkF7pz8JiXXmVUPGGnMGiDFXJExdz5f1Ox3ItRD4G14Baiu4w0HV2XKincN8zd6MbvWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=u+9k3Kae; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Et2TJfNe; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 16 Sep 2025 12:54:33 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1758027274;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=1MgthP84RKG3PSLfbhBbuHvE7gwUXSkm284oLBj8PE8=;
	b=u+9k3KaePC15OmApbURpmcTG9CtFD0Skf/RrmiwdgjsKyZy+uyBD/cCvH84dkR8bkrej2J
	aiwpdpoInYDlwRmliwWV7uEZdya4UXfYeN+x2xJCPoGMmB1iji1FvLf1MKMFlrf0Rc4ahw
	PTIVllN1KvcXNFYlNS2K2zqk2qLlcGimgddJG/cnEYId/NvTGRIIsfcr6xeEwEAod5PMad
	XhK/9x1g2NyeVNbrMqUhfWzNLuQP0OFjeoT0G1ECTz2Et1Rpf+uhIc5ulM3I+ue4fox66j
	fFTtXXYvfUu7SX/C28qauXxRTJIenqsxjatuxYUtTRQJ8+GRzOCsuwJbLt+pFw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1758027274;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=1MgthP84RKG3PSLfbhBbuHvE7gwUXSkm284oLBj8PE8=;
	b=Et2TJfNeOQ4XjT2HMDGWEyHQ/H4uFFql43lGEtiDRZed8l40ocQncT5unr0uCmrf4qPVI+
	7CBnkeYMmtrb2kAQ==
From: "tip-bot2 for David Kaplan" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/bugs] x86/bugs: Use early_param() for spectre_v2
Cc: David Kaplan <david.kaplan@amd.com>,
 "Borislav Petkov (AMD)" <bp@alien8.de>,
 Pawan Gupta <pawan.kumar.gupta@linux.intel.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175802727337.709179.17070411559160880479.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the x86/bugs branch of tip:

Commit-ID:     9a9f8147ae7fd558d6f0d40b560ffbdd408768df
Gitweb:        https://git.kernel.org/tip/9a9f8147ae7fd558d6f0d40b560ffbdd408=
768df
Author:        David Kaplan <david.kaplan@amd.com>
AuthorDate:    Mon, 15 Sep 2025 08:47:01 -05:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Mon, 15 Sep 2025 17:26:49 +02:00

x86/bugs: Use early_param() for spectre_v2

Most of the mitigations in bugs.c use early_param() for command line parsing.
Rework the spectre_v2 and nospectre_v2 command line options to be
consistent with the others.

Remove spec_v2_print_cond() as informing the user of the their cmdline
choice isn't interesting.

  [ bp: Zap spectre_v2_check_cmd(). ]

Signed-off-by: David Kaplan <david.kaplan@amd.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
Link: https://lore.kernel.org/r/20250819192200.2003074-3-david.kaplan@amd.com
---
 arch/x86/kernel/cpu/bugs.c | 181 ++++++++++++++++--------------------
 1 file changed, 82 insertions(+), 99 deletions(-)

diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index a5072ec..c348f14 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -1845,7 +1845,8 @@ enum spectre_v2_mitigation_cmd {
 	SPECTRE_V2_CMD_IBRS,
 };
=20
-static enum spectre_v2_mitigation_cmd spectre_v2_cmd __ro_after_init =3D SPE=
CTRE_V2_CMD_AUTO;
+static enum spectre_v2_mitigation_cmd spectre_v2_cmd __ro_after_init =3D
+	IS_ENABLED(CONFIG_MITIGATION_SPECTRE_V2) ? SPECTRE_V2_CMD_AUTO : SPECTRE_V2=
_CMD_NONE;
=20
 enum spectre_v2_user_mitigation_cmd {
 	SPECTRE_V2_USER_CMD_NONE,
@@ -2039,112 +2040,51 @@ static const char * const spectre_v2_strings[] =3D {
 	[SPECTRE_V2_IBRS]			=3D "Mitigation: IBRS",
 };
=20
-static const struct {
-	const char *option;
-	enum spectre_v2_mitigation_cmd cmd;
-	bool secure;
-} mitigation_options[] __initconst =3D {
-	{ "off",		SPECTRE_V2_CMD_NONE,		  false },
-	{ "on",			SPECTRE_V2_CMD_FORCE,		  true  },
-	{ "retpoline",		SPECTRE_V2_CMD_RETPOLINE,	  false },
-	{ "retpoline,amd",	SPECTRE_V2_CMD_RETPOLINE_LFENCE,  false },
-	{ "retpoline,lfence",	SPECTRE_V2_CMD_RETPOLINE_LFENCE,  false },
-	{ "retpoline,generic",	SPECTRE_V2_CMD_RETPOLINE_GENERIC, false },
-	{ "eibrs",		SPECTRE_V2_CMD_EIBRS,		  false },
-	{ "eibrs,lfence",	SPECTRE_V2_CMD_EIBRS_LFENCE,	  false },
-	{ "eibrs,retpoline",	SPECTRE_V2_CMD_EIBRS_RETPOLINE,	  false },
-	{ "auto",		SPECTRE_V2_CMD_AUTO,		  false },
-	{ "ibrs",		SPECTRE_V2_CMD_IBRS,              false },
-};
+static bool nospectre_v2 __ro_after_init;
=20
-static void __init spec_v2_print_cond(const char *reason, bool secure)
+static int __init nospectre_v2_parse_cmdline(char *str)
 {
-	if (boot_cpu_has_bug(X86_BUG_SPECTRE_V2) !=3D secure)
-		pr_info("%s selected on command line.\n", reason);
+	nospectre_v2 =3D true;
+	spectre_v2_cmd =3D SPECTRE_V2_CMD_NONE;
+	return 0;
 }
+early_param("nospectre_v2", nospectre_v2_parse_cmdline);
=20
-static enum spectre_v2_mitigation_cmd __init spectre_v2_parse_cmdline(void)
+static int __init spectre_v2_parse_cmdline(char *str)
 {
-	enum spectre_v2_mitigation_cmd cmd;
-	char arg[20];
-	int ret, i;
-
-	cmd =3D IS_ENABLED(CONFIG_MITIGATION_SPECTRE_V2) ?  SPECTRE_V2_CMD_AUTO : S=
PECTRE_V2_CMD_NONE;
-	if (cmdline_find_option_bool(boot_command_line, "nospectre_v2"))
-		return SPECTRE_V2_CMD_NONE;
-
-	ret =3D cmdline_find_option(boot_command_line, "spectre_v2", arg, sizeof(ar=
g));
-	if (ret < 0)
-		return cmd;
-
-	for (i =3D 0; i < ARRAY_SIZE(mitigation_options); i++) {
-		if (!match_option(arg, ret, mitigation_options[i].option))
-			continue;
-		cmd =3D mitigation_options[i].cmd;
-		break;
-	}
-
-	if (i >=3D ARRAY_SIZE(mitigation_options)) {
-		pr_err("unknown option (%s). Switching to default mode\n", arg);
-		return cmd;
-	}
-
-	if ((cmd =3D=3D SPECTRE_V2_CMD_RETPOLINE ||
-	     cmd =3D=3D SPECTRE_V2_CMD_RETPOLINE_LFENCE ||
-	     cmd =3D=3D SPECTRE_V2_CMD_RETPOLINE_GENERIC ||
-	     cmd =3D=3D SPECTRE_V2_CMD_EIBRS_LFENCE ||
-	     cmd =3D=3D SPECTRE_V2_CMD_EIBRS_RETPOLINE) &&
-	    !IS_ENABLED(CONFIG_MITIGATION_RETPOLINE)) {
-		pr_err("%s selected but not compiled in. Switching to AUTO select\n",
-		       mitigation_options[i].option);
-		return SPECTRE_V2_CMD_AUTO;
-	}
-
-	if ((cmd =3D=3D SPECTRE_V2_CMD_EIBRS ||
-	     cmd =3D=3D SPECTRE_V2_CMD_EIBRS_LFENCE ||
-	     cmd =3D=3D SPECTRE_V2_CMD_EIBRS_RETPOLINE) &&
-	    !boot_cpu_has(X86_FEATURE_IBRS_ENHANCED)) {
-		pr_err("%s selected but CPU doesn't have Enhanced or Automatic IBRS. Switc=
hing to AUTO select\n",
-		       mitigation_options[i].option);
-		return SPECTRE_V2_CMD_AUTO;
-	}
-
-	if ((cmd =3D=3D SPECTRE_V2_CMD_RETPOLINE_LFENCE ||
-	     cmd =3D=3D SPECTRE_V2_CMD_EIBRS_LFENCE) &&
-	    !boot_cpu_has(X86_FEATURE_LFENCE_RDTSC)) {
-		pr_err("%s selected, but CPU doesn't have a serializing LFENCE. Switching =
to AUTO select\n",
-		       mitigation_options[i].option);
-		return SPECTRE_V2_CMD_AUTO;
-	}
-
-	if (cmd =3D=3D SPECTRE_V2_CMD_IBRS && !IS_ENABLED(CONFIG_MITIGATION_IBRS_EN=
TRY)) {
-		pr_err("%s selected but not compiled in. Switching to AUTO select\n",
-		       mitigation_options[i].option);
-		return SPECTRE_V2_CMD_AUTO;
-	}
-
-	if (cmd =3D=3D SPECTRE_V2_CMD_IBRS && boot_cpu_data.x86_vendor !=3D X86_VEN=
DOR_INTEL) {
-		pr_err("%s selected but not Intel CPU. Switching to AUTO select\n",
-		       mitigation_options[i].option);
-		return SPECTRE_V2_CMD_AUTO;
-	}
+	if (!str)
+		return -EINVAL;
=20
-	if (cmd =3D=3D SPECTRE_V2_CMD_IBRS && !boot_cpu_has(X86_FEATURE_IBRS)) {
-		pr_err("%s selected but CPU doesn't have IBRS. Switching to AUTO select\n",
-		       mitigation_options[i].option);
-		return SPECTRE_V2_CMD_AUTO;
-	}
+	if (nospectre_v2)
+		return 0;
=20
-	if (cmd =3D=3D SPECTRE_V2_CMD_IBRS && cpu_feature_enabled(X86_FEATURE_XENPV=
)) {
-		pr_err("%s selected but running as XenPV guest. Switching to AUTO select\n=
",
-		       mitigation_options[i].option);
-		return SPECTRE_V2_CMD_AUTO;
-	}
+	if (!strcmp(str, "off"))
+		spectre_v2_cmd =3D SPECTRE_V2_CMD_NONE;
+	else if (!strcmp(str, "on"))
+		spectre_v2_cmd =3D SPECTRE_V2_CMD_FORCE;
+	else if (!strcmp(str, "retpoline"))
+		spectre_v2_cmd =3D SPECTRE_V2_CMD_RETPOLINE;
+	else if (!strcmp(str, "retpoline,amd") ||
+		 !strcmp(str, "retpoline,lfence"))
+		spectre_v2_cmd =3D SPECTRE_V2_CMD_RETPOLINE_LFENCE;
+	else if (!strcmp(str, "retpoline,generic"))
+		spectre_v2_cmd =3D SPECTRE_V2_CMD_RETPOLINE_GENERIC;
+	else if (!strcmp(str, "eibrs"))
+		spectre_v2_cmd =3D SPECTRE_V2_CMD_EIBRS;
+	else if (!strcmp(str, "eibrs,lfence"))
+		spectre_v2_cmd =3D SPECTRE_V2_CMD_EIBRS_LFENCE;
+	else if (!strcmp(str, "eibrs,retpoline"))
+		spectre_v2_cmd =3D SPECTRE_V2_CMD_EIBRS_RETPOLINE;
+	else if (!strcmp(str, "auto"))
+		spectre_v2_cmd =3D SPECTRE_V2_CMD_AUTO;
+	else if (!strcmp(str, "ibrs"))
+		spectre_v2_cmd =3D SPECTRE_V2_CMD_IBRS;
+	else
+		pr_err("Ignoring unknown spectre_v2 option (%s).", str);
=20
-	spec_v2_print_cond(mitigation_options[i].option,
-			   mitigation_options[i].secure);
-	return cmd;
+	return 0;
 }
+early_param("spectre_v2", spectre_v2_parse_cmdline);
=20
 static enum spectre_v2_mitigation __init spectre_v2_select_retpoline(void)
 {
@@ -2332,7 +2272,50 @@ static void __init bhi_apply_mitigation(void)
=20
 static void __init spectre_v2_select_mitigation(void)
 {
-	spectre_v2_cmd =3D spectre_v2_parse_cmdline();
+	if ((spectre_v2_cmd =3D=3D SPECTRE_V2_CMD_RETPOLINE ||
+	     spectre_v2_cmd =3D=3D SPECTRE_V2_CMD_RETPOLINE_LFENCE ||
+	     spectre_v2_cmd =3D=3D SPECTRE_V2_CMD_RETPOLINE_GENERIC ||
+	     spectre_v2_cmd =3D=3D SPECTRE_V2_CMD_EIBRS_LFENCE ||
+	     spectre_v2_cmd =3D=3D SPECTRE_V2_CMD_EIBRS_RETPOLINE) &&
+	    !IS_ENABLED(CONFIG_MITIGATION_RETPOLINE)) {
+		pr_err("RETPOLINE selected but not compiled in. Switching to AUTO select\n=
");
+		spectre_v2_cmd =3D SPECTRE_V2_CMD_AUTO;
+	}
+
+	if ((spectre_v2_cmd =3D=3D SPECTRE_V2_CMD_EIBRS ||
+	     spectre_v2_cmd =3D=3D SPECTRE_V2_CMD_EIBRS_LFENCE ||
+	     spectre_v2_cmd =3D=3D SPECTRE_V2_CMD_EIBRS_RETPOLINE) &&
+	    !boot_cpu_has(X86_FEATURE_IBRS_ENHANCED)) {
+		pr_err("EIBRS selected but CPU doesn't have Enhanced or Automatic IBRS. Sw=
itching to AUTO select\n");
+		spectre_v2_cmd =3D SPECTRE_V2_CMD_AUTO;
+	}
+
+	if ((spectre_v2_cmd =3D=3D SPECTRE_V2_CMD_RETPOLINE_LFENCE ||
+	     spectre_v2_cmd =3D=3D SPECTRE_V2_CMD_EIBRS_LFENCE) &&
+	    !boot_cpu_has(X86_FEATURE_LFENCE_RDTSC)) {
+		pr_err("LFENCE selected, but CPU doesn't have a serializing LFENCE. Switch=
ing to AUTO select\n");
+		spectre_v2_cmd =3D SPECTRE_V2_CMD_AUTO;
+	}
+
+	if (spectre_v2_cmd =3D=3D SPECTRE_V2_CMD_IBRS && !IS_ENABLED(CONFIG_MITIGAT=
ION_IBRS_ENTRY)) {
+		pr_err("IBRS selected but not compiled in. Switching to AUTO select\n");
+		spectre_v2_cmd =3D SPECTRE_V2_CMD_AUTO;
+	}
+
+	if (spectre_v2_cmd =3D=3D SPECTRE_V2_CMD_IBRS && boot_cpu_data.x86_vendor !=
=3D X86_VENDOR_INTEL) {
+		pr_err("IBRS selected but not Intel CPU. Switching to AUTO select\n");
+		spectre_v2_cmd =3D SPECTRE_V2_CMD_AUTO;
+	}
+
+	if (spectre_v2_cmd =3D=3D SPECTRE_V2_CMD_IBRS && !boot_cpu_has(X86_FEATURE_=
IBRS)) {
+		pr_err("IBRS selected but CPU doesn't have IBRS. Switching to AUTO select\=
n");
+		spectre_v2_cmd =3D SPECTRE_V2_CMD_AUTO;
+	}
+
+	if (spectre_v2_cmd =3D=3D SPECTRE_V2_CMD_IBRS && cpu_feature_enabled(X86_FE=
ATURE_XENPV)) {
+		pr_err("IBRS selected but running as XenPV guest. Switching to AUTO select=
\n");
+		spectre_v2_cmd =3D SPECTRE_V2_CMD_AUTO;
+	}
=20
 	if (!boot_cpu_has_bug(X86_BUG_SPECTRE_V2) &&
 	    (spectre_v2_cmd =3D=3D SPECTRE_V2_CMD_NONE || spectre_v2_cmd =3D=3D SPE=
CTRE_V2_CMD_AUTO))

