Return-Path: <linux-tip-commits+bounces-6084-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 824A8B02155
	for <lists+linux-tip-commits@lfdr.de>; Fri, 11 Jul 2025 18:11:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 47EAD5C500F
	for <lists+linux-tip-commits@lfdr.de>; Fri, 11 Jul 2025 16:11:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C04B2F1FFC;
	Fri, 11 Jul 2025 16:09:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="VUNW/iYE";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="wGH+dKr8"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC3B92F19A9;
	Fri, 11 Jul 2025 16:09:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752250181; cv=none; b=auYUR1pYAvxUlEdeMZCm7wxD/Yxl85akzlnZjc/tsg6ONdsOqVQtQqtawAoPWmaV4Yg6QT/XRIJLcmg3jtCT8puPPFN3YZS0hMopl3XJSbhTc40H7U2ZvA1AjBm+/ak+RLC7F680rnmTYKO4TUzSJ/BA64rOjcTHUjmJl7/1sBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752250181; c=relaxed/simple;
	bh=lRM95djeshZU/nfvyDIb/WEL10UqQhtOrWrLZhsAs2U=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=r1+6M9ijQ3grmnqdP21oi52fDNYDTylCckYp6CtNuOGUwCvHc9xYFH5HwcLTPupJqmR+9uYNu6VPDoDmGq/gRl7+rr73sHKOLhMDcXt59/pa0dCGUxqujuMTV3GHmYEMZA5/EZjdu4M9WBEjEDb8yUUUrXKwtqHokoLis8AhEfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=VUNW/iYE; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=wGH+dKr8; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 11 Jul 2025 16:09:37 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1752250178;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Jw8xPzIu1oarJwRTlSdoF4poUlwIJ/S9OiwIh9nClxI=;
	b=VUNW/iYEqdfG8Cmn6K5/iNEJ2gwOCTqCJgvK3fWc1NCbrg45Ju+gApXiUG4Q2/JcGCD875
	wiKqxZ2zGD677nqVoSxDdE8V/mU64jREid4fogxRG0dpie+pla79BORInzz275mjFryaeC
	qe1K3Dwe4U/ochEu9pGvHGvCl0UXCwmNqi5eKVN7a17Xx44TYvnHMZl2EzG7qGP0fab2qk
	AjXZ7C80+yGVLiKCvbwDrcX9ooeuxDNcc65rJeWFf1+7LgN9cE80dvYToY6s+69oj+hDcB
	vFdi3iP3BfDSqciKLaUvw57zIlHt3sXmgbb7KBcUkqC/8vjFvpkqf9hwkP1qxw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1752250178;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Jw8xPzIu1oarJwRTlSdoF4poUlwIJ/S9OiwIh9nClxI=;
	b=wGH+dKr8rQ72JtVvJ5e3PR223UGo+yShEOgAcwgx93XN/uJoolLl8gVAK6IqfzMIx1678s
	IwHI5sd6RqdCIJDA==
From: "tip-bot2 for David Kaplan" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/bugs] x86/bugs: Add attack vector controls for retbleed
Cc: David Kaplan <david.kaplan@amd.com>,
 "Borislav Petkov (AMD)" <bp@alien8.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250707183316.1349127-13-david.kaplan@amd.com>
References: <20250707183316.1349127-13-david.kaplan@amd.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175225017715.406.15170548329810557032.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/bugs branch of tip:

Commit-ID:     9687eb2399379ae4e5b5cc1bccdf893c753dcffb
Gitweb:        https://git.kernel.org/tip/9687eb2399379ae4e5b5cc1bccdf893c753dcffb
Author:        David Kaplan <david.kaplan@amd.com>
AuthorDate:    Mon, 07 Jul 2025 13:33:07 -05:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Fri, 11 Jul 2025 17:56:41 +02:00

x86/bugs: Add attack vector controls for retbleed

Use attack vector controls to determine if retbleed mitigation is
required.

Disable SMT if cross-thread protection is desired and STIBP is not
available.

Signed-off-by: David Kaplan <david.kaplan@amd.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://lore.kernel.org/20250707183316.1349127-13-david.kaplan@amd.com
---
 arch/x86/kernel/cpu/bugs.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index 130db82..de6eb59 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -1313,7 +1313,7 @@ early_param("retbleed", retbleed_parse_cmdline);
 
 static void __init retbleed_select_mitigation(void)
 {
-	if (!boot_cpu_has_bug(X86_BUG_RETBLEED) || cpu_mitigations_off()) {
+	if (!boot_cpu_has_bug(X86_BUG_RETBLEED)) {
 		retbleed_mitigation = RETBLEED_MITIGATION_NONE;
 		return;
 	}
@@ -1350,6 +1350,11 @@ static void __init retbleed_select_mitigation(void)
 	if (retbleed_mitigation != RETBLEED_MITIGATION_AUTO)
 		return;
 
+	if (!should_mitigate_vuln(X86_BUG_RETBLEED)) {
+		retbleed_mitigation = RETBLEED_MITIGATION_NONE;
+		return;
+	}
+
 	/* Intel mitigation selected in retbleed_update_mitigation() */
 	if (boot_cpu_data.x86_vendor == X86_VENDOR_AMD ||
 	    boot_cpu_data.x86_vendor == X86_VENDOR_HYGON) {
@@ -1373,7 +1378,7 @@ static void __init retbleed_select_mitigation(void)
 
 static void __init retbleed_update_mitigation(void)
 {
-	if (!boot_cpu_has_bug(X86_BUG_RETBLEED) || cpu_mitigations_off())
+	if (!boot_cpu_has_bug(X86_BUG_RETBLEED))
 		return;
 
 	 /* ITS can also enable stuffing */
@@ -1468,7 +1473,7 @@ static void __init retbleed_apply_mitigation(void)
 	}
 
 	if (mitigate_smt && !boot_cpu_has(X86_FEATURE_STIBP) &&
-	    (retbleed_nosmt || cpu_mitigations_auto_nosmt()))
+	    (retbleed_nosmt || smt_mitigations == SMT_MITIGATIONS_ON))
 		cpu_smt_disable(false);
 }
 

