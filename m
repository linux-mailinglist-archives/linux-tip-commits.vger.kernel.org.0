Return-Path: <linux-tip-commits+bounces-5918-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E23DAE99A9
	for <lists+linux-tip-commits@lfdr.de>; Thu, 26 Jun 2025 11:10:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8E39F3A47CE
	for <lists+linux-tip-commits@lfdr.de>; Thu, 26 Jun 2025 09:09:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69CC32957C2;
	Thu, 26 Jun 2025 09:10:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="vGmyXDEO";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="YNsgfzbZ"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 929E61A8F94;
	Thu, 26 Jun 2025 09:10:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750929004; cv=none; b=lNdcFrgO2AVPdRATaIAQccpj2rtx/xnO3ad5b3hrrib4qC4oaCy0us0RWt+YnQuYXBGHVLrDdVDK9Zjvkhn4d1naaVbNG4Iy57iji/rC0Ot4DZd2dzJR0Yg+Wa5bUaLpGnp7Jgx3s4ijgmEUvkq/U6hCbmA1wuVlxFoIs/Q/ckc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750929004; c=relaxed/simple;
	bh=eHcQbvdP1tsbsy9rUU2nU0v69r0DHH5Cjv0cpzXEJHI=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=iemU+UIoZ0GMpHauolzwcvG1WhTbSxLSAn6bQoEwTwlCJQkaboD8Wwj+ElvmKjxIBsjpUQ0x5QhAAyB25zZzXn5sSmK5FhpxtMkyEt+BGgJvzS+iLxam1nmZ7kd9hHIDCL7t/hZ1uoo307HSJ8LuQ4BhfJX6Xfe6+5pik86TyPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=vGmyXDEO; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=YNsgfzbZ; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 26 Jun 2025 09:09:59 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1750929000;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dPN0jWReGrNbE2ue0+ZV0QVPGtNZ6PIlpBrMVw7PQJc=;
	b=vGmyXDEOp2X2xhP3Q3Pj4eyvl7Kqumqq8T36AUjp5u2546UmAsGp4z6hRCEfCGNUL1mjv8
	xkQ97cYZs5Ykx3zciLUY28jviPNHVnYughslRKOiNSqXoz9k4msz+xb3znYXwr0Bx/hU7j
	jZOpd0qwWAhosy1jdCZkGWKQJWbhFVpBBabXm5bDj3e8Wj8M46i22HYvA0aV7qcDUXypay
	OVNlAOyG5IfBlREfmjJWX80EKeFHdAN9nxfeWAcDBTr/gXrWCTlgetEN4gxu/Bmrf5SmqF
	eUxDc6Y3dsM2WwP8SZbuuJkdhYQDwC17Shn9Psxtg3/B8oyzca55rpiicUbnmw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1750929000;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dPN0jWReGrNbE2ue0+ZV0QVPGtNZ6PIlpBrMVw7PQJc=;
	b=YNsgfzbZkN0ehyzZWQ8fQH5EZR1JSd4ytTZbmk5v4xmwg4J/he5tSphw8PXsmV1LxpmESF
	+GqQzMUrsvGJKJBA==
From: "tip-bot2 for David Kaplan" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/bugs] x86/bugs: Use IBPB for retbleed if used by SRSO
Cc: David Kaplan <david.kaplan@amd.com>, Ingo Molnar <mingo@kernel.org>,
 "Borislav Petkov (AMD)" <bp@alien8.de>, "H . Peter Anvin" <hpa@zytor.com>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 Josh Poimboeuf <jpoimboe@kernel.org>,
 Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
 Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250625155805.600376-3-david.kaplan@amd.com>
References: <20250625155805.600376-3-david.kaplan@amd.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175092899935.406.14417210191129837726.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/bugs branch of tip:

Commit-ID:     ff54ae7314962699749869a3475da7a702ae991a
Gitweb:        https://git.kernel.org/tip/ff54ae7314962699749869a3475da7a702ae991a
Author:        David Kaplan <david.kaplan@amd.com>
AuthorDate:    Wed, 25 Jun 2025 10:58:04 -05:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Thu, 26 Jun 2025 10:56:39 +02:00

x86/bugs: Use IBPB for retbleed if used by SRSO

If spec_rstack_overflow=ibpb then this mitigates retbleed as well.  This
is relevant for AMD Zen1 and Zen2 CPUs which are vulnerable to both bugs.

Signed-off-by: David Kaplan <david.kaplan@amd.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Reviewed-by: Borislav Petkov (AMD) <bp@alien8.de>
Cc: H . Peter Anvin <hpa@zytor.com>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Josh Poimboeuf <jpoimboe@kernel.org>
Cc: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: https://lore.kernel.org/r/20250625155805.600376-3-david.kaplan@amd.com
---
 arch/x86/kernel/cpu/bugs.c | 34 +++++++++++++++++++---------------
 1 file changed, 19 insertions(+), 15 deletions(-)

diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index 6c991af..b263419 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -1171,6 +1171,21 @@ static enum retbleed_mitigation retbleed_mitigation __ro_after_init =
 
 static int __ro_after_init retbleed_nosmt = false;
 
+enum srso_mitigation {
+	SRSO_MITIGATION_NONE,
+	SRSO_MITIGATION_AUTO,
+	SRSO_MITIGATION_UCODE_NEEDED,
+	SRSO_MITIGATION_SAFE_RET_UCODE_NEEDED,
+	SRSO_MITIGATION_MICROCODE,
+	SRSO_MITIGATION_NOSMT,
+	SRSO_MITIGATION_SAFE_RET,
+	SRSO_MITIGATION_IBPB,
+	SRSO_MITIGATION_IBPB_ON_VMEXIT,
+	SRSO_MITIGATION_BP_SPEC_REDUCE,
+};
+
+static enum srso_mitigation srso_mitigation __ro_after_init = SRSO_MITIGATION_AUTO;
+
 static int __init retbleed_parse_cmdline(char *str)
 {
 	if (!str)
@@ -1280,6 +1295,10 @@ static void __init retbleed_update_mitigation(void)
 	if (its_mitigation == ITS_MITIGATION_RETPOLINE_STUFF)
 		retbleed_mitigation = RETBLEED_MITIGATION_STUFF;
 
+	/* If SRSO is using IBPB, that works for retbleed too */
+	if (srso_mitigation == SRSO_MITIGATION_IBPB)
+		retbleed_mitigation = RETBLEED_MITIGATION_IBPB;
+
 	if (retbleed_mitigation == RETBLEED_MITIGATION_STUFF &&
 	    !cdt_possible(spectre_v2_enabled)) {
 		pr_err("WARNING: retbleed=stuff depends on retpoline\n");
@@ -2845,19 +2864,6 @@ early_param("l1tf", l1tf_cmdline);
 #undef pr_fmt
 #define pr_fmt(fmt)	"Speculative Return Stack Overflow: " fmt
 
-enum srso_mitigation {
-	SRSO_MITIGATION_NONE,
-	SRSO_MITIGATION_AUTO,
-	SRSO_MITIGATION_UCODE_NEEDED,
-	SRSO_MITIGATION_SAFE_RET_UCODE_NEEDED,
-	SRSO_MITIGATION_MICROCODE,
-	SRSO_MITIGATION_NOSMT,
-	SRSO_MITIGATION_SAFE_RET,
-	SRSO_MITIGATION_IBPB,
-	SRSO_MITIGATION_IBPB_ON_VMEXIT,
-	SRSO_MITIGATION_BP_SPEC_REDUCE,
-};
-
 static const char * const srso_strings[] = {
 	[SRSO_MITIGATION_NONE]			= "Vulnerable",
 	[SRSO_MITIGATION_UCODE_NEEDED]		= "Vulnerable: No microcode",
@@ -2870,8 +2876,6 @@ static const char * const srso_strings[] = {
 	[SRSO_MITIGATION_BP_SPEC_REDUCE]	= "Mitigation: Reduced Speculation"
 };
 
-static enum srso_mitigation srso_mitigation __ro_after_init = SRSO_MITIGATION_AUTO;
-
 static int __init srso_parse_cmdline(char *str)
 {
 	if (!str)

