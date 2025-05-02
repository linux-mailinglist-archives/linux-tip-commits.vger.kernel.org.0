Return-Path: <linux-tip-commits+bounces-5195-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 93D41AA6FD2
	for <lists+linux-tip-commits@lfdr.de>; Fri,  2 May 2025 12:36:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F188A4A1CD4
	for <lists+linux-tip-commits@lfdr.de>; Fri,  2 May 2025 10:36:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2A4323E355;
	Fri,  2 May 2025 10:33:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="M4yyUHzV";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="F0PeAbnd"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5B2A2417D4;
	Fri,  2 May 2025 10:33:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746182026; cv=none; b=XbQbwT3WOjdRbEqzdW+byFa9Q/6am4DvdWZIcWZhlKn2hRHJy8/8JmMhW8CiBlaSi2zx8esiukA4M5IRPCYVBDVNl+zyXDW0Qw3YAKy2r7ucfQaAaj4tmr9XS9reNIcbnRm43uzGHohrY2I0VLFJ6wGDfSpmOfqDGLbI6kHab+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746182026; c=relaxed/simple;
	bh=yOxjetuqqOyOvWRrmZdwg8prepClTFz0bFi9YA3X7ow=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=VltdjtVSR2oJoN83pkGFMznYtqPwqTmtT0gztJdnw3l/+ydy1EL18XQkLJIU2RLmm+ZU83fG84TTYdXlVUFhQ3ENVh6ap5Ncb3UCHACGO6CU3svuHkMxppigs5SMgwCitVRirurW+f+024FitF1G5U5HqZ7XIOmzhUy2wuIG2Zs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=M4yyUHzV; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=F0PeAbnd; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 02 May 2025 10:33:20 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1746182001;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zTkTXrqLeoUw9pnH2gzozbdT2kuUq/Dnyvt9SNW58nw=;
	b=M4yyUHzVL3xYx8obWwdOLNsSQJi/Y77c1d8WT9C/B8rhAmF/DR16wtUmC45UV27Zvu1mDz
	W6ZihVTm1QHM4ZDbI8uOGSWABfl6KPftkJL6+nqvC0RN3eDH8+QFw4CZoLtAzKvUyfcwst
	2IsBChFB9v1UOgT4X+sJUpqrOmACGDEN6cVaL/lzsJumA+r2yLmGU7QSnY9v5kcV0GTz1v
	B2uNaHE0+GtNMI9mU+cPhBhE0kdY7ejmNMySyiQ5B42O//XIHq2tTAzmLhwRM9RF3wV388
	fRW6m7WIbsa1eoTjUQESibueiMKJ41pJdCRZp7w4moxO7qJkwvXkgyhVN9Y8fQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1746182001;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zTkTXrqLeoUw9pnH2gzozbdT2kuUq/Dnyvt9SNW58nw=;
	b=F0PeAbndzNZRWac12JfrYxBUY/zR2B+qcDWECVv3aM2tbdFpE53fFBahyKPRbTLl0yLIWP
	jQMhV3pjl1DQPHAQ==
From: "tip-bot2 for David Kaplan" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/bugs] x86/bugs: Restructure SSB mitigation
Cc: David Kaplan <david.kaplan@amd.com>,
 "Borislav Petkov (AMD)" <bp@alien8.de>, Josh Poimboeuf <jpoimboe@kernel.org>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250418161721.1855190-15-david.kaplan@amd.com>
References: <20250418161721.1855190-15-david.kaplan@amd.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174618200065.22196.16669598075085540965.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/bugs branch of tip:

Commit-ID:     5ece59a2fca6e1467558467a05cf742b7e52d1b7
Gitweb:        https://git.kernel.org/tip/5ece59a2fca6e1467558467a05cf742b7e52d1b7
Author:        David Kaplan <david.kaplan@amd.com>
AuthorDate:    Fri, 18 Apr 2025 11:17:19 -05:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Tue, 29 Apr 2025 18:57:26 +02:00

x86/bugs: Restructure SSB mitigation

Restructure SSB to use select/apply functions to create consistent
vulnerability handling.

Remove __ssb_select_mitigation() and split the functionality between the
select/apply functions.

Signed-off-by: David Kaplan <david.kaplan@amd.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Josh Poimboeuf <jpoimboe@kernel.org>
Link: https://lore.kernel.org/20250418161721.1855190-15-david.kaplan@amd.com
---
 arch/x86/kernel/cpu/bugs.c | 36 +++++++++++++++++-------------------
 1 file changed, 17 insertions(+), 19 deletions(-)

diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index 93d0743..fbb4f13 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -65,6 +65,7 @@ static void __init spectre_v2_user_select_mitigation(void);
 static void __init spectre_v2_user_update_mitigation(void);
 static void __init spectre_v2_user_apply_mitigation(void);
 static void __init ssb_select_mitigation(void);
+static void __init ssb_apply_mitigation(void);
 static void __init l1tf_select_mitigation(void);
 static void __init mds_select_mitigation(void);
 static void __init mds_update_mitigation(void);
@@ -243,6 +244,7 @@ void __init cpu_select_mitigations(void)
 	spectre_v2_apply_mitigation();
 	retbleed_apply_mitigation();
 	spectre_v2_user_apply_mitigation();
+	ssb_apply_mitigation();
 	mds_apply_mitigation();
 	taa_apply_mitigation();
 	mmio_apply_mitigation();
@@ -2219,19 +2221,18 @@ static enum ssb_mitigation_cmd __init ssb_parse_cmdline(void)
 	return cmd;
 }
 
-static enum ssb_mitigation __init __ssb_select_mitigation(void)
+static void __init ssb_select_mitigation(void)
 {
-	enum ssb_mitigation mode = SPEC_STORE_BYPASS_NONE;
 	enum ssb_mitigation_cmd cmd;
 
 	if (!boot_cpu_has(X86_FEATURE_SSBD))
-		return mode;
+		goto out;
 
 	cmd = ssb_parse_cmdline();
 	if (!boot_cpu_has_bug(X86_BUG_SPEC_STORE_BYPASS) &&
 	    (cmd == SPEC_STORE_BYPASS_CMD_NONE ||
 	     cmd == SPEC_STORE_BYPASS_CMD_AUTO))
-		return mode;
+		return;
 
 	switch (cmd) {
 	case SPEC_STORE_BYPASS_CMD_SECCOMP:
@@ -2240,28 +2241,35 @@ static enum ssb_mitigation __init __ssb_select_mitigation(void)
 		 * enabled.
 		 */
 		if (IS_ENABLED(CONFIG_SECCOMP))
-			mode = SPEC_STORE_BYPASS_SECCOMP;
+			ssb_mode = SPEC_STORE_BYPASS_SECCOMP;
 		else
-			mode = SPEC_STORE_BYPASS_PRCTL;
+			ssb_mode = SPEC_STORE_BYPASS_PRCTL;
 		break;
 	case SPEC_STORE_BYPASS_CMD_ON:
-		mode = SPEC_STORE_BYPASS_DISABLE;
+		ssb_mode = SPEC_STORE_BYPASS_DISABLE;
 		break;
 	case SPEC_STORE_BYPASS_CMD_AUTO:
 	case SPEC_STORE_BYPASS_CMD_PRCTL:
-		mode = SPEC_STORE_BYPASS_PRCTL;
+		ssb_mode = SPEC_STORE_BYPASS_PRCTL;
 		break;
 	case SPEC_STORE_BYPASS_CMD_NONE:
 		break;
 	}
 
+out:
+	if (boot_cpu_has_bug(X86_BUG_SPEC_STORE_BYPASS))
+		pr_info("%s\n", ssb_strings[ssb_mode]);
+}
+
+static void __init ssb_apply_mitigation(void)
+{
 	/*
 	 * We have three CPU feature flags that are in play here:
 	 *  - X86_BUG_SPEC_STORE_BYPASS - CPU is susceptible.
 	 *  - X86_FEATURE_SSBD - CPU is able to turn off speculative store bypass
 	 *  - X86_FEATURE_SPEC_STORE_BYPASS_DISABLE - engage the mitigation
 	 */
-	if (mode == SPEC_STORE_BYPASS_DISABLE) {
+	if (ssb_mode == SPEC_STORE_BYPASS_DISABLE) {
 		setup_force_cpu_cap(X86_FEATURE_SPEC_STORE_BYPASS_DISABLE);
 		/*
 		 * Intel uses the SPEC CTRL MSR Bit(2) for this, while AMD may
@@ -2275,16 +2283,6 @@ static enum ssb_mitigation __init __ssb_select_mitigation(void)
 			update_spec_ctrl(x86_spec_ctrl_base);
 		}
 	}
-
-	return mode;
-}
-
-static void ssb_select_mitigation(void)
-{
-	ssb_mode = __ssb_select_mitigation();
-
-	if (boot_cpu_has_bug(X86_BUG_SPEC_STORE_BYPASS))
-		pr_info("%s\n", ssb_strings[ssb_mode]);
 }
 
 #undef pr_fmt

