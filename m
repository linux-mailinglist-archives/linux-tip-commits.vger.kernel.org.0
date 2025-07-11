Return-Path: <linux-tip-commits+bounces-6081-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 952DEB0214C
	for <lists+linux-tip-commits@lfdr.de>; Fri, 11 Jul 2025 18:10:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2D2B0169241
	for <lists+linux-tip-commits@lfdr.de>; Fri, 11 Jul 2025 16:10:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DBE72F0C55;
	Fri, 11 Jul 2025 16:09:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="S6vEGaFx";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="rjCE/0x3"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D11152EFD81;
	Fri, 11 Jul 2025 16:09:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752250178; cv=none; b=FCd3rbM/QI+y1cEnshdYI8JWGwNjvOo+l1PFHFBVaVfRCGf+tV3DlUyF1Vw2rwsfTCQWE2yKTZmEg+TgZh2l1mrIIDLZuj5HQ1zemJ2S0OpATEwt13QkwFnOzXmXRjmNG3UR6reEn0XnA2eEMx6nWnXQrlr1W39QoNYLySNVniY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752250178; c=relaxed/simple;
	bh=zFOz+OBWDdUQyb8V3Q1tclJXyy2h0J0o9vKumGzEm0g=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=G1XbgZqNg6hi4xYr08FBBv8JCmNcdJBDduPJOCrOZAd29qDS8YkrYPe/XvlfKX9wXYv8RNsjsQW4kjOZ8xadeqqJUTMqSe4rntfW3RvuwSDjRM3DM163Rr1w9Pv6p8Mgwu6OI+srpbb1MZ0I9msQv96iywREADwLJYb75Krf1YA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=S6vEGaFx; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=rjCE/0x3; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 11 Jul 2025 16:09:34 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1752250175;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NEjP9yFfS4Xvo1mqL64VsmsXGcWRCZxoQqyFcE3oQMQ=;
	b=S6vEGaFxNNMZ/+lRzIvixZjb7tXoZ8RtG3fSLPkE5FY7KWWvhKHqTkY9P0BosMFMrBi6zl
	pb7NjwDJw0f6rZbLXKqPAHTlGcQEtQWXrc4+++y966fVt8pn0n2yr8UDnBee/OCi1vmLYE
	hvj8Uqqbywp2jgnqRbPpV01kobJLqhnoz/W27mVccFi8GnnJudmL/FO6cJOa8YmExvJ3St
	iisk6w7hHL4BNP/HFhHqZqLfxyhQqJt7h2LcL/+3ngnYp5UAHMrljS0gRTOZjPZfIi4Ari
	omunset9so581hYiTj5siJnAsZtP0KuJ7DXrWi/aOpuIy18zO5mcvgk3a3dGnQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1752250175;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NEjP9yFfS4Xvo1mqL64VsmsXGcWRCZxoQqyFcE3oQMQ=;
	b=rjCE/0x3qTdZafnox0fwm6TuM8535WqWJi1DSYlQ3Kn7NrH8xs3RJxkrLcfol1OmzrVtg/
	6sh4SL1Z37Q3kDDg==
From: "tip-bot2 for David Kaplan" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/bugs] x86/bugs: Add attack vector controls for spectre_v2
Cc: David Kaplan <david.kaplan@amd.com>,
 "Borislav Petkov (AMD)" <bp@alien8.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250707183316.1349127-16-david.kaplan@amd.com>
References: <20250707183316.1349127-16-david.kaplan@amd.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175225017409.406.12311808103426494557.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/bugs branch of tip:

Commit-ID:     fdf99228e2f4e0486dc629e87fcece42abfe3f9c
Gitweb:        https://git.kernel.org/tip/fdf99228e2f4e0486dc629e87fcece42abfe3f9c
Author:        David Kaplan <david.kaplan@amd.com>
AuthorDate:    Mon, 07 Jul 2025 13:33:10 -05:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Fri, 11 Jul 2025 17:56:41 +02:00

x86/bugs: Add attack vector controls for spectre_v2

Use attack vector controls to determine if spectre_v2 mitigation is
required.

Signed-off-by: David Kaplan <david.kaplan@amd.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://lore.kernel.org/20250707183316.1349127-16-david.kaplan@amd.com
---
 arch/x86/kernel/cpu/bugs.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index 2022f05..94c72f4 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -2013,8 +2013,7 @@ static enum spectre_v2_mitigation_cmd __init spectre_v2_parse_cmdline(void)
 	int ret, i;
 
 	cmd = IS_ENABLED(CONFIG_MITIGATION_SPECTRE_V2) ?  SPECTRE_V2_CMD_AUTO : SPECTRE_V2_CMD_NONE;
-	if (cmdline_find_option_bool(boot_command_line, "nospectre_v2") ||
-	    cpu_mitigations_off())
+	if (cmdline_find_option_bool(boot_command_line, "nospectre_v2"))
 		return SPECTRE_V2_CMD_NONE;
 
 	ret = cmdline_find_option(boot_command_line, "spectre_v2", arg, sizeof(arg));
@@ -2286,8 +2285,11 @@ static void __init spectre_v2_select_mitigation(void)
 	case SPECTRE_V2_CMD_NONE:
 		return;
 
-	case SPECTRE_V2_CMD_FORCE:
 	case SPECTRE_V2_CMD_AUTO:
+		if (!should_mitigate_vuln(X86_BUG_SPECTRE_V2))
+			break;
+		fallthrough;
+	case SPECTRE_V2_CMD_FORCE:
 		if (boot_cpu_has(X86_FEATURE_IBRS_ENHANCED)) {
 			spectre_v2_enabled = SPECTRE_V2_EIBRS;
 			break;
@@ -2341,7 +2343,7 @@ static void __init spectre_v2_update_mitigation(void)
 		}
 	}
 
-	if (boot_cpu_has_bug(X86_BUG_SPECTRE_V2) && !cpu_mitigations_off())
+	if (boot_cpu_has_bug(X86_BUG_SPECTRE_V2))
 		pr_info("%s\n", spectre_v2_strings[spectre_v2_enabled]);
 }
 

