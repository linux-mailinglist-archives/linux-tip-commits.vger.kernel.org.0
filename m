Return-Path: <linux-tip-commits+bounces-6486-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 34783B454C0
	for <lists+linux-tip-commits@lfdr.de>; Fri,  5 Sep 2025 12:30:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DB7111CC1AF5
	for <lists+linux-tip-commits@lfdr.de>; Fri,  5 Sep 2025 10:30:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A0222DEA6A;
	Fri,  5 Sep 2025 10:30:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="LZS3o2cH";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="2V6jnqen"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFB7E2DE6F5;
	Fri,  5 Sep 2025 10:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757068218; cv=none; b=V8mNYg5BL4+LCArZMw+uzsFLmILzyQpZr7/YKMt070Im3g6RpKyhqO4LY1eKu6fdj8OW+UbeQWI9DF8OG60DbhN2AouFplAi/6COhhkgfxGNsVaQC6S+qy1HWMW+ipPJNr3dGsMxA4VqzbVIIx87b7UwMIgMeZhPWmOj/wnDKiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757068218; c=relaxed/simple;
	bh=79OR8/t6tB/XwzGzgobK9/FrcuxXg2cNEpOfXg0/XB4=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=Hk3cXl6qUZ5v1YS8pWyiOUjJeG7to+0Z9Rj0kJEQAMueoLMcIXspGZGu3OBrjZEYyHZmuXMTNvrN5qw0UQ5jBhQ96Uje8LCT/RhFxP3GdQMnbzTUXX5gH9McNNpjUZY5Tm9+q4nlGL74xp72LIBQAGHvPh+95OnEsLjYO4VxIAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=LZS3o2cH; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=2V6jnqen; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 05 Sep 2025 10:30:11 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1757068213;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TMpMiNLg6i0nLiA/Y9Ga9ras61GexwtwyFNZXzstWX8=;
	b=LZS3o2cH7w8iB0GMsNwfiGnfdBkVHf5w/g8J3Uj7UZAF6WJUoXBUbazHS7jlUG4KMbAhDK
	CRQ4f+pQnVmsLLOZglIn/x7iYzE0OZD6/xjV4JzIhLuqrTx+rcKc/KEWTZSeF9ZXQM+/MY
	6IY3J/VMJpQxzdlZKXt4IA0zqEJQ3uIkBzBV2ObGOFxbE0S9WdzGUIDg8IcTo2++znnF0q
	cwJH6guWzphqZpcUTl/ouM8YyL+gItAIg/A3LJ808H8NCNwAS/QJ36HHVPV9udjhOgVi3J
	BcJiceACQs8J1JxiNCHqp1cPIeMWNkCXrN8Xz00FknvcLbU3RxAuqvpt1q7g9w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1757068213;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TMpMiNLg6i0nLiA/Y9Ga9ras61GexwtwyFNZXzstWX8=;
	b=2V6jnqenfesfuvnJb9Bcdry3CxxwxdIbXfcZBXE2+fAuJ7eqDlva2ruR/iEYeelEvNg/oD
	PueCt7I9nGXbixAA==
From: "tip-bot2 for Borislav Petkov (AMD)" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/microcode] x86/microcode: Add microcode= cmdline parsing
Cc: "Borislav Petkov (AMD)" <bp@alien8.de>,
 Sohil Mehta <sohil.mehta@intel.com>,
 "Chang S. Bae" <chang.seok.bae@intel.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250820135043.19048-2-bp@kernel.org>
References: <20250820135043.19048-2-bp@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175706821167.1920.8357300911170308187.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the x86/microcode branch of tip:

Commit-ID:     632ff61706473127cdc3b779bf24d368e3856ab3
Gitweb:        https://git.kernel.org/tip/632ff61706473127cdc3b779bf24d368e38=
56ab3
Author:        Borislav Petkov (AMD) <bp@alien8.de>
AuthorDate:    Wed, 20 Aug 2025 15:50:42 +02:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Thu, 04 Sep 2025 16:02:20 +02:00

x86/microcode: Add microcode=3D cmdline parsing

Add a "microcode=3D" command line argument after which all options can be
passed in a comma-separated list.

Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Sohil Mehta <sohil.mehta@intel.com>
Reviewed-by: Chang S. Bae <chang.seok.bae@intel.com>
Link: https://lore.kernel.org/20250820135043.19048-2-bp@kernel.org
---
 Documentation/admin-guide/kernel-parameters.txt |  8 +++--
 arch/x86/Kconfig                                |  4 +-
 arch/x86/kernel/cpu/microcode/core.c            | 26 +++++++++++++---
 3 files changed, 30 insertions(+), 8 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/=
admin-guide/kernel-parameters.txt
index 747a55a..9e3bbce 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -3767,8 +3767,12 @@
=20
 	mga=3D		[HW,DRM]
=20
-	microcode.force_minrev=3D	[X86]
-			Format: <bool>
+	microcode=3D      [X86] Control the behavior of the microcode loader.
+	                Available options, comma separated:
+
+			dis_ucode_ldr: disable the microcode loader
+
+			force_minrev:
 			Enable or disable the microcode minimal revision
 			enforcement for the runtime microcode loader.
=20
diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 58d890f..aa250d9 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -1340,7 +1340,7 @@ config MICROCODE_LATE_LOADING
 	  use this at your own risk. Late loading taints the kernel unless the
 	  microcode header indicates that it is safe for late loading via the
 	  minimal revision check. This minimal revision check can be enforced on
-	  the kernel command line with "microcode.minrev=3DY".
+	  the kernel command line with "microcode=3Dforce_minrev".
=20
 config MICROCODE_LATE_FORCE_MINREV
 	bool "Enforce late microcode loading minimal revision check"
@@ -1356,7 +1356,7 @@ config MICROCODE_LATE_FORCE_MINREV
 	  revision check fails.
=20
 	  This minimal revision check can also be controlled via the
-	  "microcode.minrev" parameter on the kernel command line.
+	  "microcode=3Dforce_minrev" parameter on the kernel command line.
=20
 	  If unsure say Y.
=20
diff --git a/arch/x86/kernel/cpu/microcode/core.c b/arch/x86/kernel/cpu/micro=
code/core.c
index b92e09a..7d59063 100644
--- a/arch/x86/kernel/cpu/microcode/core.c
+++ b/arch/x86/kernel/cpu/microcode/core.c
@@ -43,10 +43,9 @@
 #include "internal.h"
=20
 static struct microcode_ops *microcode_ops;
-static bool dis_ucode_ldr =3D false;
+static bool dis_ucode_ldr;
=20
 bool force_minrev =3D IS_ENABLED(CONFIG_MICROCODE_LATE_FORCE_MINREV);
-module_param(force_minrev, bool, S_IRUSR | S_IWUSR);
=20
 /*
  * Synchronization.
@@ -126,13 +125,32 @@ bool __init microcode_loader_disabled(void)
 	return dis_ucode_ldr;
 }
=20
+static void early_parse_cmdline(void)
+{
+	char cmd_buf[64] =3D {};
+	char *s, *p =3D cmd_buf;
+
+	if (cmdline_find_option(boot_command_line, "microcode", cmd_buf, sizeof(cmd=
_buf)) > 0) {
+		while ((s =3D strsep(&p, ","))) {
+			if (!strcmp("force_minrev", s))
+				force_minrev =3D true;
+
+			if (!strcmp(s, "dis_ucode_ldr"))
+				dis_ucode_ldr =3D true;
+		}
+	}
+
+	/* old, compat option */
+	if (cmdline_find_option_bool(boot_command_line, "dis_ucode_ldr") > 0)
+		dis_ucode_ldr =3D true;
+}
+
 void __init load_ucode_bsp(void)
 {
 	unsigned int cpuid_1_eax;
 	bool intel =3D true;
=20
-	if (cmdline_find_option_bool(boot_command_line, "dis_ucode_ldr") > 0)
-		dis_ucode_ldr =3D true;
+	early_parse_cmdline();
=20
 	if (microcode_loader_disabled())
 		return;

