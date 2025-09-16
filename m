Return-Path: <linux-tip-commits+bounces-6653-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 784F3B596AF
	for <lists+linux-tip-commits@lfdr.de>; Tue, 16 Sep 2025 14:54:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 00569324D6F
	for <lists+linux-tip-commits@lfdr.de>; Tue, 16 Sep 2025 12:54:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D5DE242D9A;
	Tue, 16 Sep 2025 12:54:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="JN/j9dQH";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="n5o7PP2T"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDDF71B6CE9;
	Tue, 16 Sep 2025 12:54:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758027275; cv=none; b=jIwpcaWepudV03fZZBigaI8g9W+0I31IQU8/Jy+JpbYAqiBKR/Ot7Sta5QTFgU5+5NhI+ctVByEUQY6T/nB6Aqc1lXl55xWeuD0rE9YcY6Ufc6ZMAhhMbcmDdrJ+cDnXrhN1gA7aT6ugSBVORJ33jiNL6RoJ75q4kw4JRhnev6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758027275; c=relaxed/simple;
	bh=OU9tOND33JXLsFqqUgS075xxdS2mrqgUa8meOT1qokU=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=mqp3PPaaJINUVizGu8zyCPmhqM/yBNBDOGtd2zinmcIoRDGCRRm+3ZnXkzJ16ckrZMMFXvWQ1SB6QPcm0Re43b5MYST2G2whowlgtOqcbHOF9GIATajMEK6Aq5TkuvtoFyMAtVetti40cEEqRkQHHEDB6OQXDlWfkTZWq63fziY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=JN/j9dQH; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=n5o7PP2T; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 16 Sep 2025 12:54:29 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1758027271;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=mPkVgnS71ghCBF2rX/MXIbHoi/4a7DPgiMb1a13mynk=;
	b=JN/j9dQHumkknUfJVdxKbpRW9zbjs7MJFrCo+U+lkCQ/mxBrsS0PWdAdLtfkJTRyjsp3Yc
	xylVsV5af7vyZdJ/77Rj8xQ4uYnjFk7xAJRJpNkEIapgw/NJCfEtb5znCyrGMgf055c8CZ
	Jg5m+pyLS1N78MLF2WaVFp2Cm+H+3oK0FUvKak9FfWPv/y7ZA55rEpMDNL2dQmtHHHgVFU
	8OI5Mc8Dj6OBFUXU3+Tg1ghjO1bXYfBy/x7RiqlwzMt50kPlhZ2Ut7tzVv4bAybJBHz47X
	wFrUCwR9Kx/uPmPxxGNY7x/zMaYMUBPNwpeTX1zhf1CyKt0JvYkxAwttoyH1eg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1758027271;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=mPkVgnS71ghCBF2rX/MXIbHoi/4a7DPgiMb1a13mynk=;
	b=n5o7PP2T37rWtO1MIhhHk022LhmS361Icr322b06ge51+XXLIQZkFZU76yullYEDH0waXk
	zEfwtzh60ROzIKCA==
From: "tip-bot2 for David Kaplan" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/bugs] x86/bugs: Fix spectre_v2 forcing
Cc: David Kaplan <david.kaplan@amd.com>,
 "Borislav Petkov (AMD)" <bp@alien8.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175802726991.709179.18063733313741451004.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the x86/bugs branch of tip:

Commit-ID:     30ef245c6f5a6842d60308590cf26d0ae836fbf0
Gitweb:        https://git.kernel.org/tip/30ef245c6f5a6842d60308590cf26d0ae83=
6fbf0
Author:        David Kaplan <david.kaplan@amd.com>
AuthorDate:    Mon, 15 Sep 2025 08:47:04 -05:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Tue, 16 Sep 2025 12:59:55 +02:00

x86/bugs: Fix spectre_v2 forcing

There were two oddities with spectre_v2 command line options.

First, any option other than 'off' or 'auto' would force spectre_v2
mitigations even if the CPU (hypothetically) wasn't vulnerable to spectre_v2.
That was inconsistent with all the other bugs where mitigations are ignored
unless an explicit 'force' option is specified.

Second, even though spectre_v2 mitigations would be enabled in these cases,
the X86_BUG_SPECTRE_V2 bit wasn't set.  This is again inconsistent with the
forcing behavior of other bugs and arguably incorrect as it doesn't make sense
to enable a mitigation if the X86_BUG bit isn't set.

Fix both issues by only forcing spectre_v2 mitigations when the
'spectre_v2=3Don' option is specified (which was already called
SPECTRE_V2_CMD_FORCE) and setting the relevant X86_BUG_* bits in that case.

This also allows for simplifying bhi_update_mitigation() because
spectre_v2_cmd will now always be SPECTRE_V2_CMD_NONE if the CPU is immune to
spectre_v2.

Signed-off-by: David Kaplan <david.kaplan@amd.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://lore.kernel.org/20250915134706.3201818-1-david.kaplan@amd.com
---
 arch/x86/kernel/cpu/bugs.c | 36 ++++++++++++++++++------------------
 1 file changed, 18 insertions(+), 18 deletions(-)

diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index f28a738..145f877 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -2057,29 +2057,32 @@ static int __init spectre_v2_parse_cmdline(char *str)
 	if (nospectre_v2)
 		return 0;
=20
-	if (!strcmp(str, "off"))
+	if (!strcmp(str, "off")) {
 		spectre_v2_cmd =3D SPECTRE_V2_CMD_NONE;
-	else if (!strcmp(str, "on"))
+	} else if (!strcmp(str, "on")) {
 		spectre_v2_cmd =3D SPECTRE_V2_CMD_FORCE;
-	else if (!strcmp(str, "retpoline"))
+		setup_force_cpu_bug(X86_BUG_SPECTRE_V2);
+		setup_force_cpu_bug(X86_BUG_SPECTRE_V2_USER);
+	} else if (!strcmp(str, "retpoline")) {
 		spectre_v2_cmd =3D SPECTRE_V2_CMD_RETPOLINE;
-	else if (!strcmp(str, "retpoline,amd") ||
-		 !strcmp(str, "retpoline,lfence"))
+	} else if (!strcmp(str, "retpoline,amd") ||
+		 !strcmp(str, "retpoline,lfence")) {
 		spectre_v2_cmd =3D SPECTRE_V2_CMD_RETPOLINE_LFENCE;
-	else if (!strcmp(str, "retpoline,generic"))
+	} else if (!strcmp(str, "retpoline,generic")) {
 		spectre_v2_cmd =3D SPECTRE_V2_CMD_RETPOLINE_GENERIC;
-	else if (!strcmp(str, "eibrs"))
+	} else if (!strcmp(str, "eibrs")) {
 		spectre_v2_cmd =3D SPECTRE_V2_CMD_EIBRS;
-	else if (!strcmp(str, "eibrs,lfence"))
+	} else if (!strcmp(str, "eibrs,lfence")) {
 		spectre_v2_cmd =3D SPECTRE_V2_CMD_EIBRS_LFENCE;
-	else if (!strcmp(str, "eibrs,retpoline"))
+	} else if (!strcmp(str, "eibrs,retpoline")) {
 		spectre_v2_cmd =3D SPECTRE_V2_CMD_EIBRS_RETPOLINE;
-	else if (!strcmp(str, "auto"))
+	} else if (!strcmp(str, "auto")) {
 		spectre_v2_cmd =3D SPECTRE_V2_CMD_AUTO;
-	else if (!strcmp(str, "ibrs"))
+	} else if (!strcmp(str, "ibrs")) {
 		spectre_v2_cmd =3D SPECTRE_V2_CMD_IBRS;
-	else
+	} else {
 		pr_err("Ignoring unknown spectre_v2 option (%s).", str);
+	}
=20
 	return 0;
 }
@@ -2232,10 +2235,6 @@ static void __init bhi_update_mitigation(void)
 {
 	if (spectre_v2_cmd =3D=3D SPECTRE_V2_CMD_NONE)
 		bhi_mitigation =3D BHI_MITIGATION_OFF;
-
-	if (!boot_cpu_has_bug(X86_BUG_SPECTRE_V2) &&
-	     spectre_v2_cmd =3D=3D SPECTRE_V2_CMD_AUTO)
-		bhi_mitigation =3D BHI_MITIGATION_OFF;
 }
=20
 static void __init bhi_apply_mitigation(void)
@@ -2316,9 +2315,10 @@ static void __init spectre_v2_select_mitigation(void)
 		spectre_v2_cmd =3D SPECTRE_V2_CMD_AUTO;
 	}
=20
-	if (!boot_cpu_has_bug(X86_BUG_SPECTRE_V2) &&
-	    (spectre_v2_cmd =3D=3D SPECTRE_V2_CMD_NONE || spectre_v2_cmd =3D=3D SPE=
CTRE_V2_CMD_AUTO))
+	if (!boot_cpu_has_bug(X86_BUG_SPECTRE_V2)) {
+		spectre_v2_cmd =3D SPECTRE_V2_CMD_NONE;
 		return;
+	}
=20
 	switch (spectre_v2_cmd) {
 	case SPECTRE_V2_CMD_NONE:

