Return-Path: <linux-tip-commits+bounces-5920-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F0F4AE9E12
	for <lists+linux-tip-commits@lfdr.de>; Thu, 26 Jun 2025 15:01:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A87A11C42523
	for <lists+linux-tip-commits@lfdr.de>; Thu, 26 Jun 2025 13:01:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24AAE2E5412;
	Thu, 26 Jun 2025 13:01:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="o+ZMS2of";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="XqNMV6hD"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 370A82E336E;
	Thu, 26 Jun 2025 13:01:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750942883; cv=none; b=QXC0kWaDzbMg74yNujXxIpQJfvR7C0kBERp76nPB+LEtv1lhlN56nY8KiSl8/iUc/SGcmhGPTrYBgCjSix4ol1CrcZUKsoIPGItUSePb1wGBsF93VwVHlixCKP57pxdjO088A7BZnCuPvLGSUu/CjmqpdkUY+E2G7ZSL1GyNo5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750942883; c=relaxed/simple;
	bh=8E+3n1QtwchzZWQx5O5Q/cKJIfNTzXwQQ9R2UsIGlOo=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=I97fkkWK1KxdiWL0oD5o/PNHsd1I7XFwpvI3ON5Yo1a/7xh6hn2wNzrvM7oM5OoIuORNehdnriG5uXEstg2eGcJ6U0XQRjJ5r9DGPq1cfQJPXlRABwI3+iLjOuKi1eDzDJvM/bX+ZZVP6uM5aZn80LR1yH2zWhslKWeUKfLqHDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=o+ZMS2of; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=XqNMV6hD; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 26 Jun 2025 13:01:17 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1750942879;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=f41wVf+xOCYKXJ2qv7Qx7MXNwZzykuwtDlgdJhUhcCY=;
	b=o+ZMS2ofRvZ/WX9R3I1kS+Xsuds3yZiAjVYwP/pHASQgZcbbCFtlURyheGXMxOQL+joeap
	ENlWGQluCJuKPTuzs4x9Gd2aRl6zsDYy2pSqF05Z9CJANlDc4fLdhCojVPT2mUdTSJFpGM
	LZz8Nhrp9Iz48kwf2FY3VJIxgqzptpOj3yAoZCQI8nUOW3QNIFYGwhGP16Dk/+2F6u0Q82
	gFPsiz9pxkTMNq76d/JwW6bV2zalFB+H69mSNWpSc5lP/hWVeVoo7ZJdcwYi+mmRuo387L
	G8i8jFSgaNF8CsJ+kxXizZ7s0lrTZSRcd7EBf4gce8zzL4cUlr6pA9iPJUVk6w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1750942879;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=f41wVf+xOCYKXJ2qv7Qx7MXNwZzykuwtDlgdJhUhcCY=;
	b=XqNMV6hDREXnuOI/FIbB1izUJdxAOlJ0d1gKy25CoqffHBficgFNssme/N6Y9J1/P9WcXY
	wNgzIHceuxrMvSAg==
From: "tip-bot2 for David Kaplan" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/bugs] x86/bugs: Clean up SRSO microcode handling
Cc: David Kaplan <david.kaplan@amd.com>,
 "Borislav Petkov (AMD)" <bp@alien8.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250625155805.600376-4-david.kaplan@amd.com>
References: <20250625155805.600376-4-david.kaplan@amd.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175094287763.406.9381570505281070631.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/bugs branch of tip:

Commit-ID:     98b5dab4d22181c931f2bf63c060416badbb49ab
Gitweb:        https://git.kernel.org/tip/98b5dab4d22181c931f2bf63c060416badbb49ab
Author:        David Kaplan <david.kaplan@amd.com>
AuthorDate:    Wed, 25 Jun 2025 10:58:05 -05:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Thu, 26 Jun 2025 13:32:31 +02:00

x86/bugs: Clean up SRSO microcode handling

SRSO microcode only exists for Zen3/Zen4 CPUs.  For those CPUs, the microcode
is required for any mitigation other than Safe-RET to be effective.  Safe-RET
can still protect user->kernel and guest->host attacks without microcode.

Clarify this in the code and ensure that SRSO_MITIGATION_UCODE_NEEDED is
selected for any mitigation besides Safe-RET if the required microcode isn't
present.

Signed-off-by: David Kaplan <david.kaplan@amd.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://lore.kernel.org/20250625155805.600376-4-david.kaplan@amd.com
---
 arch/x86/kernel/cpu/bugs.c | 37 ++++++++++++++++++-------------------
 1 file changed, 18 insertions(+), 19 deletions(-)

diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index b263419..e2a8a21 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -2902,8 +2902,6 @@ early_param("spec_rstack_overflow", srso_parse_cmdline);
 
 static void __init srso_select_mitigation(void)
 {
-	bool has_microcode;
-
 	if (!boot_cpu_has_bug(X86_BUG_SRSO) || cpu_mitigations_off())
 		srso_mitigation = SRSO_MITIGATION_NONE;
 
@@ -2913,23 +2911,30 @@ static void __init srso_select_mitigation(void)
 	if (srso_mitigation == SRSO_MITIGATION_AUTO)
 		srso_mitigation = SRSO_MITIGATION_SAFE_RET;
 
-	has_microcode = boot_cpu_has(X86_FEATURE_IBPB_BRTYPE);
-	if (has_microcode) {
-		/*
-		 * Zen1/2 with SMT off aren't vulnerable after the right
-		 * IBPB microcode has been applied.
-		 */
-		if (boot_cpu_data.x86 < 0x19 && !cpu_smt_possible()) {
-			srso_mitigation = SRSO_MITIGATION_NOSMT;
-			return;
-		}
-	} else {
+	/* Zen1/2 with SMT off aren't vulnerable to SRSO. */
+	if (boot_cpu_data.x86 < 0x19 && !cpu_smt_possible()) {
+		srso_mitigation = SRSO_MITIGATION_NOSMT;
+		return;
+	}
+
+	if (!boot_cpu_has(X86_FEATURE_IBPB_BRTYPE)) {
 		pr_warn("IBPB-extending microcode not applied!\n");
 		pr_warn(SRSO_NOTICE);
+
+		/*
+		 * Safe-RET provides partial mitigation without microcode, but
+		 * other mitigations require microcode to provide any
+		 * mitigations.
+		 */
+		if (srso_mitigation == SRSO_MITIGATION_SAFE_RET)
+			srso_mitigation = SRSO_MITIGATION_SAFE_RET_UCODE_NEEDED;
+		else
+			srso_mitigation = SRSO_MITIGATION_UCODE_NEEDED;
 	}
 
 	switch (srso_mitigation) {
 	case SRSO_MITIGATION_SAFE_RET:
+	case SRSO_MITIGATION_SAFE_RET_UCODE_NEEDED:
 		if (boot_cpu_has(X86_FEATURE_SRSO_USER_KERNEL_NO)) {
 			srso_mitigation = SRSO_MITIGATION_IBPB_ON_VMEXIT;
 			goto ibpb_on_vmexit;
@@ -2939,9 +2944,6 @@ static void __init srso_select_mitigation(void)
 			pr_err("WARNING: kernel not compiled with MITIGATION_SRSO.\n");
 			srso_mitigation = SRSO_MITIGATION_NONE;
 		}
-
-		if (!has_microcode)
-			srso_mitigation = SRSO_MITIGATION_SAFE_RET_UCODE_NEEDED;
 		break;
 ibpb_on_vmexit:
 	case SRSO_MITIGATION_IBPB_ON_VMEXIT:
@@ -2956,9 +2958,6 @@ ibpb_on_vmexit:
 			pr_err("WARNING: kernel not compiled with MITIGATION_IBPB_ENTRY.\n");
 			srso_mitigation = SRSO_MITIGATION_NONE;
 		}
-
-		if (!has_microcode)
-			srso_mitigation = SRSO_MITIGATION_UCODE_NEEDED;
 		break;
 	default:
 		break;

