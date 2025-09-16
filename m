Return-Path: <linux-tip-commits+bounces-6655-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D4EBB596B4
	for <lists+linux-tip-commits@lfdr.de>; Tue, 16 Sep 2025 14:55:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BD6054E4492
	for <lists+linux-tip-commits@lfdr.de>; Tue, 16 Sep 2025 12:55:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11B10306B16;
	Tue, 16 Sep 2025 12:54:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="O3KEc4yi";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Eco55TIB"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F02A27B353;
	Tue, 16 Sep 2025 12:54:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758027277; cv=none; b=VazXYToHnKEuNRediBfXQNpnAwvwuqOYpM/NG3vepGJBZXLF1pBNxy4QUiURQmYXVAbqW3jRzUnxH1SSEGMh/NeNrMkH0y7lrZK48ZOnat9FHbY1m/Q1kJDGIZM10v/PD+AziwTAp57a47oxgYbwZy4SpY5w1luVjfItdgNce/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758027277; c=relaxed/simple;
	bh=VUj6XN9BDuPCDrqMrpkoT3Fc16tt7ZHWj2ueeC5b9G8=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=VcFd0Zzu1zq7LFDcQkVXW/l9a+Bh4KkLOF76t32JZ7ablYwvKUs4glm7dOsfIsfW3e8fXQhgKNR+FHzZFlUwP039CPe4xehwzDvsXTl+42nOCqkTXFz8POGi67RtqYe9g6BRKuW53BjLiIdk6Cms9oDwWffjz2ZJMsnemH4x1Is=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=O3KEc4yi; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Eco55TIB; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 16 Sep 2025 12:54:32 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1758027273;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=n1tu0FTMbvqgMEa+SdkKu0ioo7V7ruYqzbM8TEzuhEk=;
	b=O3KEc4yiF8cYZaW4HfTRreqjvzWM1O/jS8yIH24OtdSCkizsm7AyhDoxI9r0tyJ+Gb24fh
	6+KS/x+abTJJIM2m36dSRH2uMVro1BcTvPM7HxH02+wX2PTTj+hvXrIav209p04kWaEmIV
	qEmr9MOEOJ0sPZh5NBEJhdIdkFyP3RDCSSYt8feiIFcvqxJFfGQHuwSH8gvfd8BgpfbuQN
	mup7uVHRvlxXe+eYZFYzwBcPQb1pQbD6GRksh2wNgOpy674NKiQbhi3Zk0Q2sVLlRUhJr6
	6t1ux4/5OZXHwROEabKx4y9guGgF5ZKtit7WtS74Gm5gix1lhFV6wUyfAeAUAw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1758027273;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=n1tu0FTMbvqgMEa+SdkKu0ioo7V7ruYqzbM8TEzuhEk=;
	b=Eco55TIBmXILCoRySF/7IYPcDhS4NcTbsj33mfb/30H/vqaGKi4LghVGJAsx+Ie/1blt+C
	pwUV69YafuOb9FBA==
From: "tip-bot2 for David Kaplan" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/bugs] x86/bugs: Simplify SSB cmdline parsing
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
Message-ID: <175802727212.709179.17017431377662607458.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the x86/bugs branch of tip:

Commit-ID:     02ac6cc8c5a129013695c3eee48b65fb5ba669c0
Gitweb:        https://git.kernel.org/tip/02ac6cc8c5a129013695c3eee48b65fb5ba=
669c0
Author:        David Kaplan <david.kaplan@amd.com>
AuthorDate:    Mon, 15 Sep 2025 08:47:02 -05:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Mon, 15 Sep 2025 18:04:20 +02:00

x86/bugs: Simplify SSB cmdline parsing

Simplify the SSB command line parsing by selecting a mitigation directly, as
is done in most of the simpler vulnerabilities.  Use early_param() instead of
cmdline_find_option() for consistency with the other mitigation selections.

Signed-off-by: David Kaplan <david.kaplan@amd.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
Link: https://lore.kernel.org/r/20250819192200.2003074-4-david.kaplan@amd.com
---
 arch/x86/include/asm/nospec-branch.h |   1 +-
 arch/x86/kernel/cpu/bugs.c           | 120 ++++++++------------------
 2 files changed, 41 insertions(+), 80 deletions(-)

diff --git a/arch/x86/include/asm/nospec-branch.h b/arch/x86/include/asm/nosp=
ec-branch.h
index e29f824..08ed5a2 100644
--- a/arch/x86/include/asm/nospec-branch.h
+++ b/arch/x86/include/asm/nospec-branch.h
@@ -514,6 +514,7 @@ enum spectre_v2_user_mitigation {
 /* The Speculative Store Bypass disable variants */
 enum ssb_mitigation {
 	SPEC_STORE_BYPASS_NONE,
+	SPEC_STORE_BYPASS_AUTO,
 	SPEC_STORE_BYPASS_DISABLE,
 	SPEC_STORE_BYPASS_PRCTL,
 	SPEC_STORE_BYPASS_SECCOMP,
diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index c348f14..570de55 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -2525,16 +2525,8 @@ static void update_mds_branch_idle(void)
 #undef pr_fmt
 #define pr_fmt(fmt)	"Speculative Store Bypass: " fmt
=20
-static enum ssb_mitigation ssb_mode __ro_after_init =3D SPEC_STORE_BYPASS_NO=
NE;
-
-/* The kernel command line selection */
-enum ssb_mitigation_cmd {
-	SPEC_STORE_BYPASS_CMD_NONE,
-	SPEC_STORE_BYPASS_CMD_AUTO,
-	SPEC_STORE_BYPASS_CMD_ON,
-	SPEC_STORE_BYPASS_CMD_PRCTL,
-	SPEC_STORE_BYPASS_CMD_SECCOMP,
-};
+static enum ssb_mitigation ssb_mode __ro_after_init =3D
+	IS_ENABLED(CONFIG_MITIGATION_SSB) ? SPEC_STORE_BYPASS_AUTO : SPEC_STORE_BYP=
ASS_NONE;
=20
 static const char * const ssb_strings[] =3D {
 	[SPEC_STORE_BYPASS_NONE]	=3D "Vulnerable",
@@ -2543,94 +2535,61 @@ static const char * const ssb_strings[] =3D {
 	[SPEC_STORE_BYPASS_SECCOMP]	=3D "Mitigation: Speculative Store Bypass disab=
led via prctl and seccomp",
 };
=20
-static const struct {
-	const char *option;
-	enum ssb_mitigation_cmd cmd;
-} ssb_mitigation_options[]  __initconst =3D {
-	{ "auto",	SPEC_STORE_BYPASS_CMD_AUTO },    /* Platform decides */
-	{ "on",		SPEC_STORE_BYPASS_CMD_ON },      /* Disable Speculative Store Bypa=
ss */
-	{ "off",	SPEC_STORE_BYPASS_CMD_NONE },    /* Don't touch Speculative Store =
Bypass */
-	{ "prctl",	SPEC_STORE_BYPASS_CMD_PRCTL },   /* Disable Speculative Store By=
pass via prctl */
-	{ "seccomp",	SPEC_STORE_BYPASS_CMD_SECCOMP }, /* Disable Speculative Store =
Bypass via prctl and seccomp */
-};
+static bool nossb __ro_after_init;
=20
-static enum ssb_mitigation_cmd __init ssb_parse_cmdline(void)
+static int __init nossb_parse_cmdline(char *str)
 {
-	enum ssb_mitigation_cmd cmd;
-	char arg[20];
-	int ret, i;
-
-	cmd =3D IS_ENABLED(CONFIG_MITIGATION_SSB) ?
-		SPEC_STORE_BYPASS_CMD_AUTO : SPEC_STORE_BYPASS_CMD_NONE;
-	if (cmdline_find_option_bool(boot_command_line, "nospec_store_bypass_disabl=
e") ||
-	    cpu_mitigations_off()) {
-		return SPEC_STORE_BYPASS_CMD_NONE;
-	} else {
-		ret =3D cmdline_find_option(boot_command_line, "spec_store_bypass_disable",
-					  arg, sizeof(arg));
-		if (ret < 0)
-			return cmd;
+	nossb =3D true;
+	ssb_mode =3D SPEC_STORE_BYPASS_NONE;
+	return 0;
+}
+early_param("nospec_store_bypass_disable", nossb_parse_cmdline);
=20
-		for (i =3D 0; i < ARRAY_SIZE(ssb_mitigation_options); i++) {
-			if (!match_option(arg, ret, ssb_mitigation_options[i].option))
-				continue;
+static int __init ssb_parse_cmdline(char *str)
+{
+	if (!str)
+		return -EINVAL;
=20
-			cmd =3D ssb_mitigation_options[i].cmd;
-			break;
-		}
+	if (nossb)
+		return 0;
=20
-		if (i >=3D ARRAY_SIZE(ssb_mitigation_options)) {
-			pr_err("unknown option (%s). Switching to default mode\n", arg);
-			return cmd;
-		}
-	}
+	if (!strcmp(str, "auto"))
+		ssb_mode =3D SPEC_STORE_BYPASS_AUTO;
+	else if (!strcmp(str, "on"))
+		ssb_mode =3D SPEC_STORE_BYPASS_DISABLE;
+	else if (!strcmp(str, "off"))
+		ssb_mode =3D SPEC_STORE_BYPASS_NONE;
+	else if (!strcmp(str, "prctl"))
+		ssb_mode =3D SPEC_STORE_BYPASS_PRCTL;
+	else if (!strcmp(str, "seccomp"))
+		ssb_mode =3D IS_ENABLED(CONFIG_SECCOMP) ?
+			SPEC_STORE_BYPASS_SECCOMP : SPEC_STORE_BYPASS_PRCTL;
+	else
+		pr_err("Ignoring unknown spec_store_bypass_disable option (%s).\n",
+			str);
=20
-	return cmd;
+	return 0;
 }
+early_param("spec_store_bypass_disable", ssb_parse_cmdline);
=20
 static void __init ssb_select_mitigation(void)
 {
-	enum ssb_mitigation_cmd cmd;
-
-	if (!boot_cpu_has(X86_FEATURE_SSBD))
-		goto out;
-
-	cmd =3D ssb_parse_cmdline();
-	if (!boot_cpu_has_bug(X86_BUG_SPEC_STORE_BYPASS) &&
-	    (cmd =3D=3D SPEC_STORE_BYPASS_CMD_NONE ||
-	     cmd =3D=3D SPEC_STORE_BYPASS_CMD_AUTO))
+	if (!boot_cpu_has_bug(X86_BUG_SPEC_STORE_BYPASS)) {
+		ssb_mode =3D SPEC_STORE_BYPASS_NONE;
 		return;
+	}
=20
-	switch (cmd) {
-	case SPEC_STORE_BYPASS_CMD_SECCOMP:
-		/*
-		 * Choose prctl+seccomp as the default mode if seccomp is
-		 * enabled.
-		 */
-		if (IS_ENABLED(CONFIG_SECCOMP))
-			ssb_mode =3D SPEC_STORE_BYPASS_SECCOMP;
-		else
-			ssb_mode =3D SPEC_STORE_BYPASS_PRCTL;
-		break;
-	case SPEC_STORE_BYPASS_CMD_ON:
-		ssb_mode =3D SPEC_STORE_BYPASS_DISABLE;
-		break;
-	case SPEC_STORE_BYPASS_CMD_AUTO:
+	if (ssb_mode =3D=3D SPEC_STORE_BYPASS_AUTO) {
 		if (should_mitigate_vuln(X86_BUG_SPEC_STORE_BYPASS))
 			ssb_mode =3D SPEC_STORE_BYPASS_PRCTL;
 		else
 			ssb_mode =3D SPEC_STORE_BYPASS_NONE;
-		break;
-	case SPEC_STORE_BYPASS_CMD_PRCTL:
-		ssb_mode =3D SPEC_STORE_BYPASS_PRCTL;
-		break;
-	case SPEC_STORE_BYPASS_CMD_NONE:
-		break;
 	}
=20
-out:
-	if (boot_cpu_has_bug(X86_BUG_SPEC_STORE_BYPASS))
-		pr_info("%s\n", ssb_strings[ssb_mode]);
+	if (!boot_cpu_has(X86_FEATURE_SSBD))
+		ssb_mode =3D SPEC_STORE_BYPASS_NONE;
+
+	pr_info("%s\n", ssb_strings[ssb_mode]);
 }
=20
 static void __init ssb_apply_mitigation(void)
@@ -2846,6 +2805,7 @@ static int ssb_prctl_get(struct task_struct *task)
 		return PR_SPEC_DISABLE;
 	case SPEC_STORE_BYPASS_SECCOMP:
 	case SPEC_STORE_BYPASS_PRCTL:
+	case SPEC_STORE_BYPASS_AUTO:
 		if (task_spec_ssb_force_disable(task))
 			return PR_SPEC_PRCTL | PR_SPEC_FORCE_DISABLE;
 		if (task_spec_ssb_noexec(task))

