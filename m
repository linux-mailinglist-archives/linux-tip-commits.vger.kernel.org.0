Return-Path: <linux-tip-commits+bounces-6998-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E12CDC080E9
	for <lists+linux-tip-commits@lfdr.de>; Fri, 24 Oct 2025 22:27:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 342B63A3464
	for <lists+linux-tip-commits@lfdr.de>; Fri, 24 Oct 2025 20:27:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53F352F1FE9;
	Fri, 24 Oct 2025 20:27:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Qx34mGTZ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="rlmVpyVU"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A224C2F12DA;
	Fri, 24 Oct 2025 20:27:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761337625; cv=none; b=PTOsDu1l42nSd+ddjeWImbETmPET83Qg9xiJPh+5rFmctN2jRQ4YMeO6Xg2XUVpxzRi7wo+50ioEUwCfyhqZzJJnJrIskj6vIUQ4LjZm/ldvtJ/gGDZpvdX0hhJFI16M65yWVoWT/NNek8Z8Fhy3TWhB1CnZzir1RDOwDZHtjo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761337625; c=relaxed/simple;
	bh=SzmUYBtpvNKbrWVWyeLk79Sq4UGbFLdrgMh/op9IeFg=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=pT+7RWN8yYj3FUBG0hFTNHQAaOROika5sHv3q8pPtcsBWa/5yOhKJjlz6iT9UzwbL1GnUlj2cZSmC+j0CD/kihw5bmg7JuK2+ZagJ4shk4r0QX4+wzvvRknnnlkoQ5wcLHRNLa+eof+Uurfr4t2iyV3MJdwSbdTdMmk6f1v8i9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Qx34mGTZ; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=rlmVpyVU; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 24 Oct 2025 20:26:59 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1761337621;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=ct9sWhPGK01d50YlVO+hatLeh1S+otgna/CWnbA0xBI=;
	b=Qx34mGTZfX900IQp1uCUcreX5j7sL5JDhCnAMWJ2V2QA/JxVEaQBlD0MKJjpFRFu4LJHaP
	ttLMv/ZaPpiXNV+b7FlWJZs3i1XL5EYQk908ZA+Fmeyp6ub22YdyIci3Hwdy/dC5ZLB41a
	XVKdsPBFimsgYoYnbSLqKah02ToGNVdYH5yqPIo9G7xqJdolsx0zXyxrH2dAcCSxuCaQIE
	dr5gFdoB14GLoG9aVmTYj5n6dd9jDbiUAD9JFM3mXobLlhJDo8ZbVs3IkVrb1YIc1eaYx6
	C4oh6ACogF2zwv9yGlcCz1xGYMhsHmPk+lJ2p36OSMzpsh/h3h0UrcclQzwnhA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1761337621;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=ct9sWhPGK01d50YlVO+hatLeh1S+otgna/CWnbA0xBI=;
	b=rlmVpyVUo0dAthUtXLQj6HDV0EYRVl11Z1WjmPNIApXafFIj8q/kDu1WayWCBC4xJf3ssS
	8cIJ9f6Ib8ZGpzCQ==
From: "tip-bot2 for Petr Tesarik" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/bugs] x86/tsx: Get the tsx= command line parameter with
 early_param()
Cc: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
 Petr Tesarik <ptesarik@suse.com>, "Borislav Petkov (AMD)" <bp@alien8.de>,
 x86@kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176133761939.2601451.14224710551714814303.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the x86/bugs branch of tip:

Commit-ID:     e9cc99142a145efc04b7fb871c2e19bffee2729c
Gitweb:        https://git.kernel.org/tip/e9cc99142a145efc04b7fb871c2e19bffee=
2729c
Author:        Petr Tesarik <ptesarik@suse.com>
AuthorDate:    Wed, 22 Oct 2025 12:26:13 +02:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Fri, 24 Oct 2025 18:35:17 +02:00

x86/tsx: Get the tsx=3D command line parameter with early_param()

Use early_param() to get the value of the tsx=3D command line parameter. It is
an early parameter, because it must be parsed before tsx_init(), which is
called long before kernel_init(), where normal parameters are parsed.

Although cmdline_find_option() from tsx_init() works fine, the option is later
reported as unknown and passed to user space. The latter is not a real issue,
but the former is confusing and makes people wonder if the tsx=3D parameter h=
ad
any effect and double-check for typos unnecessarily.

The behavior changes slightly if "tsx" is given without any argument (which is
invalid syntax). Until now, the kernel logged an error message and disabled
TSX. Now, the kernel still issues a warning (Malformed early option 'tsx'),
but TSX state is unchanged. The new behavior is consistent with other
parameters, e.g. "tsx_async_abort".

   [ bp: Fixup minor formatting request during review. ]

Suggested-by: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
Signed-off-by: Petr Tesarik <ptesarik@suse.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://lore.kernel.org/all/cover.1758906115.git.ptesarik@suse.com
---
 arch/x86/kernel/cpu/tsx.c | 51 +++++++++++++++++++-------------------
 1 file changed, 26 insertions(+), 25 deletions(-)

diff --git a/arch/x86/kernel/cpu/tsx.c b/arch/x86/kernel/cpu/tsx.c
index 8be08ec..209b5a2 100644
--- a/arch/x86/kernel/cpu/tsx.c
+++ b/arch/x86/kernel/cpu/tsx.c
@@ -20,13 +20,16 @@
 #define pr_fmt(fmt) "tsx: " fmt
=20
 enum tsx_ctrl_states {
+	TSX_CTRL_AUTO,
 	TSX_CTRL_ENABLE,
 	TSX_CTRL_DISABLE,
 	TSX_CTRL_RTM_ALWAYS_ABORT,
 	TSX_CTRL_NOT_SUPPORTED,
 };
=20
-static enum tsx_ctrl_states tsx_ctrl_state __ro_after_init =3D TSX_CTRL_NOT_=
SUPPORTED;
+static enum tsx_ctrl_states tsx_ctrl_state __ro_after_init =3D
+	IS_ENABLED(CONFIG_X86_INTEL_TSX_MODE_AUTO) ? TSX_CTRL_AUTO   :
+	IS_ENABLED(CONFIG_X86_INTEL_TSX_MODE_OFF) ? TSX_CTRL_DISABLE : TSX_CTRL_ENA=
BLE;
=20
 static void tsx_disable(void)
 {
@@ -163,11 +166,28 @@ static void tsx_dev_mode_disable(void)
 	}
 }
=20
-void __init tsx_init(void)
+static int __init tsx_parse_cmdline(char *str)
 {
-	char arg[5] =3D {};
-	int ret;
+	if (!str)
+		return -EINVAL;
+
+	if (!strcmp(str, "on")) {
+		tsx_ctrl_state =3D TSX_CTRL_ENABLE;
+	} else if (!strcmp(str, "off")) {
+		tsx_ctrl_state =3D TSX_CTRL_DISABLE;
+	} else if (!strcmp(str, "auto")) {
+		tsx_ctrl_state =3D TSX_CTRL_AUTO;
+	} else {
+		tsx_ctrl_state =3D TSX_CTRL_DISABLE;
+		pr_err("invalid option, defaulting to off\n");
+	}
+
+	return 0;
+}
+early_param("tsx", tsx_parse_cmdline);
=20
+void __init tsx_init(void)
+{
 	tsx_dev_mode_disable();
=20
 	/*
@@ -201,27 +221,8 @@ void __init tsx_init(void)
 		return;
 	}
=20
-	ret =3D cmdline_find_option(boot_command_line, "tsx", arg, sizeof(arg));
-	if (ret >=3D 0) {
-		if (!strcmp(arg, "on")) {
-			tsx_ctrl_state =3D TSX_CTRL_ENABLE;
-		} else if (!strcmp(arg, "off")) {
-			tsx_ctrl_state =3D TSX_CTRL_DISABLE;
-		} else if (!strcmp(arg, "auto")) {
-			tsx_ctrl_state =3D x86_get_tsx_auto_mode();
-		} else {
-			tsx_ctrl_state =3D TSX_CTRL_DISABLE;
-			pr_err("invalid option, defaulting to off\n");
-		}
-	} else {
-		/* tsx=3D not provided */
-		if (IS_ENABLED(CONFIG_X86_INTEL_TSX_MODE_AUTO))
-			tsx_ctrl_state =3D x86_get_tsx_auto_mode();
-		else if (IS_ENABLED(CONFIG_X86_INTEL_TSX_MODE_OFF))
-			tsx_ctrl_state =3D TSX_CTRL_DISABLE;
-		else
-			tsx_ctrl_state =3D TSX_CTRL_ENABLE;
-	}
+	if (tsx_ctrl_state =3D=3D TSX_CTRL_AUTO)
+		tsx_ctrl_state =3D x86_get_tsx_auto_mode();
=20
 	if (tsx_ctrl_state =3D=3D TSX_CTRL_DISABLE) {
 		tsx_disable();

