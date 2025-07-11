Return-Path: <linux-tip-commits+bounces-6078-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A3CAEB0214D
	for <lists+linux-tip-commits@lfdr.de>; Fri, 11 Jul 2025 18:10:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 093A41CC2494
	for <lists+linux-tip-commits@lfdr.de>; Fri, 11 Jul 2025 16:10:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D5A22EF9CC;
	Fri, 11 Jul 2025 16:09:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="OOuGX4xt";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="z0HNDDk4"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFF712EF2AA;
	Fri, 11 Jul 2025 16:09:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752250176; cv=none; b=SAMmzF/zXq8QAW3qrXSMH/PhlJuAWkZAMy2GzwEkz0bP4uUlC7dzjF6prrrQV95GkbMFgcOuCWWuJmQj4z6b9qCV2KIhqAyToVmSRJ71bqCF0EyGJFgZwU+ojH+XRSdxQeccuOAHXhT4Ciz6jr1efFR7Bk0SmfBgBvD+SI5SOmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752250176; c=relaxed/simple;
	bh=Y77WtZ2hSSSu4/5gRvf+qZEnIseyrubWkB1A0+oeUa4=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=arOanuAk6AseUCtwIug6RbBynOVU8BHLUcTt6+++2AKTDvfSsgJxyt06P8dayhGQnpKz634SxWqo43eapsiwSjcYfjYfNSVIbcY1F6tQRjih78oD7Qx4tsrlY2V1LoxrXcUR/f2lcNsTxm6Pl1Rf4pSCZHiEMlvx8kEecJyXcao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=OOuGX4xt; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=z0HNDDk4; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 11 Jul 2025 16:09:31 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1752250172;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fzvbNWhfnJl46vlklgSK/DiGBDNyIDUoMJXwMFXfYbM=;
	b=OOuGX4xtaPKz3QERCVFobU5jSwFWfxe/Zn7xf3HY8DL2UzAFvv5sEAS86eJ8jjHWTF6JSq
	kzLyPkinWM8OjnR+nrEtODD7gN6FyiHbGP0scwiDvPcF56p+hpk3sKxQSuoo5ktvUv3nnt
	uN3+jsiLIY3IyBYslDGds9sTmDeVkaLJJRw6h4qLouxEjYL1vufyRYYA+mNx9798WsAP24
	cOefuYPxF2HzCWnUBsLXY+cunUAsekJjKOvo7mHURSUShTnhFk5gpH32WupBxL6sZVuZxK
	ad9lbh0JtCUVHuK6Yj+S5R2i8ansznOCOWTMLOjH0slBLgKvgBjTZiuV3zgaMQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1752250172;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fzvbNWhfnJl46vlklgSK/DiGBDNyIDUoMJXwMFXfYbM=;
	b=z0HNDDk4ELFVCvBXSxa+e781GR5WW+IMhpQQ8PAr2cv+DGL4bNhICLqB4+SyYD/7OhwFMz
	f5jqvsg+KAkn64Bg==
From: "tip-bot2 for David Kaplan" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/bugs] x86/bugs: Add attack vector controls for ITS
Cc: David Kaplan <david.kaplan@amd.com>,
 "Borislav Petkov (AMD)" <bp@alien8.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250707183316.1349127-19-david.kaplan@amd.com>
References: <20250707183316.1349127-19-david.kaplan@amd.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175225017109.406.2846188212042963198.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/bugs branch of tip:

Commit-ID:     0cdd2c4f35cf9bb9466b36724b658d11ff453f04
Gitweb:        https://git.kernel.org/tip/0cdd2c4f35cf9bb9466b36724b658d11ff453f04
Author:        David Kaplan <david.kaplan@amd.com>
AuthorDate:    Mon, 07 Jul 2025 13:33:13 -05:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Fri, 11 Jul 2025 17:56:41 +02:00

x86/bugs: Add attack vector controls for ITS

Use attack vector controls to determine if ITS mitigation is required.

Signed-off-by: David Kaplan <david.kaplan@amd.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://lore.kernel.org/20250707183316.1349127-19-david.kaplan@amd.com
---
 arch/x86/kernel/cpu/bugs.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index eef6ccd..f41d871 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -1518,13 +1518,17 @@ early_param("indirect_target_selection", its_parse_cmdline);
 
 static void __init its_select_mitigation(void)
 {
-	if (!boot_cpu_has_bug(X86_BUG_ITS) || cpu_mitigations_off()) {
+	if (!boot_cpu_has_bug(X86_BUG_ITS)) {
 		its_mitigation = ITS_MITIGATION_OFF;
 		return;
 	}
 
-	if (its_mitigation == ITS_MITIGATION_AUTO)
-		its_mitigation = ITS_MITIGATION_ALIGNED_THUNKS;
+	if (its_mitigation == ITS_MITIGATION_AUTO) {
+		if (should_mitigate_vuln(X86_BUG_ITS))
+			its_mitigation = ITS_MITIGATION_ALIGNED_THUNKS;
+		else
+			its_mitigation = ITS_MITIGATION_OFF;
+	}
 
 	if (its_mitigation == ITS_MITIGATION_OFF)
 		return;
@@ -1555,12 +1559,13 @@ static void __init its_select_mitigation(void)
 
 static void __init its_update_mitigation(void)
 {
-	if (!boot_cpu_has_bug(X86_BUG_ITS) || cpu_mitigations_off())
+	if (!boot_cpu_has_bug(X86_BUG_ITS))
 		return;
 
 	switch (spectre_v2_enabled) {
 	case SPECTRE_V2_NONE:
-		pr_err("WARNING: Spectre-v2 mitigation is off, disabling ITS\n");
+		if (its_mitigation != ITS_MITIGATION_OFF)
+			pr_err("WARNING: Spectre-v2 mitigation is off, disabling ITS\n");
 		its_mitigation = ITS_MITIGATION_OFF;
 		break;
 	case SPECTRE_V2_RETPOLINE:

