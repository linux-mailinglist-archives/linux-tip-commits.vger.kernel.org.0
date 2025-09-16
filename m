Return-Path: <linux-tip-commits+bounces-6657-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E3D82B596BA
	for <lists+linux-tip-commits@lfdr.de>; Tue, 16 Sep 2025 14:56:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B42CD1897F43
	for <lists+linux-tip-commits@lfdr.de>; Tue, 16 Sep 2025 12:55:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F3AB31197D;
	Tue, 16 Sep 2025 12:54:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="XRIeylvI";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="/kL3iHcM"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B7EF30BF58;
	Tue, 16 Sep 2025 12:54:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758027279; cv=none; b=TpT4ah9if/jTIJpan86DoOPgrCw76YW7UA2mnTW94ym3q5iRGN0RlnE1+2Ra07FGWCMPN+WZbS9paEpjTZy1ONbXb8TFm0Np44TBOU8tKOmvwM2VDfI/gBlaXqeSFmYFvL7cTu46jryuwfnoZhUumh6MObua2Eh1ZmjWcGK/bFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758027279; c=relaxed/simple;
	bh=uIewIN36u/2hqE6piddHUsEt9qTJ+5xp4zuXG5Deq0c=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=W25mZtaSSIpsF4kCeTZz3EZvVdkl/O8xnM5Zw+SwjmOSh1iN9y6R5JLNc/5s9UeH0D3ChNebHcYnXdMI/g60Bsxxkea747yue/qd+vU2cCQjMiBDD8AmsvtzQDLMqBmrTeu7bu3CtXgMQsAA2VY9Gl77U+BxSXGfvULZZnDCmp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=XRIeylvI; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=/kL3iHcM; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 16 Sep 2025 12:54:34 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1758027276;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=nvRxI9Gn+44t+cH63AICYxnWtDOSNFK8XtcQmLRQrLc=;
	b=XRIeylvIIzQ5yfxMZ9S3ysihv1dqTg2E4oegmQFL0HfNuYYyIOxpO0b0XzqHMIPR0Si2F6
	LHWTWakQ58EZg6cSXKZIzrDG8f7AaJJdKqSG8FfefqZRUlz6Zl2czCYfbsAW18lSMcmtlj
	GymFO9aSD2FE8gEFJPPFlNiWql8kwAOgIuQIYVbJ1VwtafzF7gv0ZYOuUbpqcu7Aj7er9F
	iWA5WNcxiYAU0AlH1W2w9mDZZc/fl8Q7/wlko1dx1LwrsualvLN5Vq2UG5vJHGcW7b1c0S
	l74YiHZ3Y1PT+G6yFDOU8jz9G9xp0rPv8CzM2GWLRNl49ByoZaGXP6TAOcvX4Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1758027276;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=nvRxI9Gn+44t+cH63AICYxnWtDOSNFK8XtcQmLRQrLc=;
	b=/kL3iHcMZyNS7iv2DBuI9SszzyPFREIkRb20PpPueXIxF3Cx8q7cVIbY/U/qJWqTXKO9fK
	DxZxbWE1f0iuqcDQ==
From: "tip-bot2 for David Kaplan" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/bugs] x86/bugs: Use early_param() for spectre_v2_user
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
Message-ID: <175802727465.709179.15552114068758812343.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the x86/bugs branch of tip:

Commit-ID:     8edb9e77119be3cdd930e71204ee48c4994b217b
Gitweb:        https://git.kernel.org/tip/8edb9e77119be3cdd930e71204ee48c4994=
b217b
Author:        David Kaplan <david.kaplan@amd.com>
AuthorDate:    Mon, 15 Sep 2025 08:47:00 -05:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Mon, 15 Sep 2025 17:07:22 +02:00

x86/bugs: Use early_param() for spectre_v2_user

Most of the mitigations in bugs.c use early_param() to parse their command
line options.  Modify spectre_v2_user to use early_param() for consistency.

Remove spec_v2_user_print_cond() because informing a user about their
cmdline choice isn't very interesting and the chosen mitigation is already
printed in spectre_v2_user_update_mitigation().

Signed-off-by: David Kaplan <david.kaplan@amd.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
Link: https://lore.kernel.org/r/20250819192200.2003074-2-david.kaplan@amd.com
---
 arch/x86/kernel/cpu/bugs.c | 68 ++++++++++++++-----------------------
 1 file changed, 26 insertions(+), 42 deletions(-)

diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index e817bba..a5072ec 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -1847,7 +1847,7 @@ enum spectre_v2_mitigation_cmd {
=20
 static enum spectre_v2_mitigation_cmd spectre_v2_cmd __ro_after_init =3D SPE=
CTRE_V2_CMD_AUTO;
=20
-enum spectre_v2_user_cmd {
+enum spectre_v2_user_mitigation_cmd {
 	SPECTRE_V2_USER_CMD_NONE,
 	SPECTRE_V2_USER_CMD_AUTO,
 	SPECTRE_V2_USER_CMD_FORCE,
@@ -1857,6 +1857,9 @@ enum spectre_v2_user_cmd {
 	SPECTRE_V2_USER_CMD_SECCOMP_IBPB,
 };
=20
+static enum spectre_v2_user_mitigation_cmd spectre_v2_user_cmd __ro_after_in=
it =3D
+	IS_ENABLED(CONFIG_MITIGATION_SPECTRE_V2) ? SPECTRE_V2_USER_CMD_AUTO : SPECT=
RE_V2_USER_CMD_NONE;
+
 static const char * const spectre_v2_user_strings[] =3D {
 	[SPECTRE_V2_USER_NONE]			=3D "User space: Vulnerable",
 	[SPECTRE_V2_USER_STRICT]		=3D "User space: Mitigation: STIBP protection",
@@ -1865,50 +1868,31 @@ static const char * const spectre_v2_user_strings[] =
=3D {
 	[SPECTRE_V2_USER_SECCOMP]		=3D "User space: Mitigation: STIBP via seccomp a=
nd prctl",
 };
=20
-static const struct {
-	const char			*option;
-	enum spectre_v2_user_cmd	cmd;
-	bool				secure;
-} v2_user_options[] __initconst =3D {
-	{ "auto",		SPECTRE_V2_USER_CMD_AUTO,		false },
-	{ "off",		SPECTRE_V2_USER_CMD_NONE,		false },
-	{ "on",			SPECTRE_V2_USER_CMD_FORCE,		true  },
-	{ "prctl",		SPECTRE_V2_USER_CMD_PRCTL,		false },
-	{ "prctl,ibpb",		SPECTRE_V2_USER_CMD_PRCTL_IBPB,		false },
-	{ "seccomp",		SPECTRE_V2_USER_CMD_SECCOMP,		false },
-	{ "seccomp,ibpb",	SPECTRE_V2_USER_CMD_SECCOMP_IBPB,	false },
-};
-
-static void __init spec_v2_user_print_cond(const char *reason, bool secure)
-{
-	if (boot_cpu_has_bug(X86_BUG_SPECTRE_V2) !=3D secure)
-		pr_info("spectre_v2_user=3D%s forced on command line.\n", reason);
-}
-
-static enum spectre_v2_user_cmd __init spectre_v2_parse_user_cmdline(void)
+static int __init spectre_v2_user_parse_cmdline(char *str)
 {
-	char arg[20];
-	int ret, i;
-
-	if (!IS_ENABLED(CONFIG_MITIGATION_SPECTRE_V2))
-		return SPECTRE_V2_USER_CMD_NONE;
-
-	ret =3D cmdline_find_option(boot_command_line, "spectre_v2_user",
-				  arg, sizeof(arg));
-	if (ret < 0)
-		return SPECTRE_V2_USER_CMD_AUTO;
+	if (!str)
+		return -EINVAL;
=20
-	for (i =3D 0; i < ARRAY_SIZE(v2_user_options); i++) {
-		if (match_option(arg, ret, v2_user_options[i].option)) {
-			spec_v2_user_print_cond(v2_user_options[i].option,
-						v2_user_options[i].secure);
-			return v2_user_options[i].cmd;
-		}
-	}
+	if (!strcmp(str, "auto"))
+		spectre_v2_user_cmd =3D SPECTRE_V2_USER_CMD_AUTO;
+	else if (!strcmp(str, "off"))
+		spectre_v2_user_cmd =3D SPECTRE_V2_USER_CMD_NONE;
+	else if (!strcmp(str, "on"))
+		spectre_v2_user_cmd =3D SPECTRE_V2_USER_CMD_FORCE;
+	else if (!strcmp(str, "prctl"))
+		spectre_v2_user_cmd =3D SPECTRE_V2_USER_CMD_PRCTL;
+	else if (!strcmp(str, "prctl,ibpb"))
+		spectre_v2_user_cmd =3D SPECTRE_V2_USER_CMD_PRCTL_IBPB;
+	else if (!strcmp(str, "seccomp"))
+		spectre_v2_user_cmd =3D SPECTRE_V2_USER_CMD_SECCOMP;
+	else if (!strcmp(str, "seccomp,ibpb"))
+		spectre_v2_user_cmd =3D SPECTRE_V2_USER_CMD_SECCOMP_IBPB;
+	else
+		pr_err("Ignoring unknown spectre_v2_user option (%s).", str);
=20
-	pr_err("Unknown user space protection option (%s). Switching to default\n",=
 arg);
-	return SPECTRE_V2_USER_CMD_AUTO;
+	return 0;
 }
+early_param("spectre_v2_user", spectre_v2_user_parse_cmdline);
=20
 static inline bool spectre_v2_in_ibrs_mode(enum spectre_v2_mitigation mode)
 {
@@ -1920,7 +1904,7 @@ static void __init spectre_v2_user_select_mitigation(vo=
id)
 	if (!boot_cpu_has(X86_FEATURE_IBPB) && !boot_cpu_has(X86_FEATURE_STIBP))
 		return;
=20
-	switch (spectre_v2_parse_user_cmdline()) {
+	switch (spectre_v2_user_cmd) {
 	case SPECTRE_V2_USER_CMD_NONE:
 		return;
 	case SPECTRE_V2_USER_CMD_FORCE:

