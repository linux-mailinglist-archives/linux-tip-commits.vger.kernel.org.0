Return-Path: <linux-tip-commits+bounces-5182-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C58FFAA6FB5
	for <lists+linux-tip-commits@lfdr.de>; Fri,  2 May 2025 12:33:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3ABA97A384C
	for <lists+linux-tip-commits@lfdr.de>; Fri,  2 May 2025 10:32:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5754923E346;
	Fri,  2 May 2025 10:33:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="GRmlHvBx";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="qEEm2848"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A9E279D2;
	Fri,  2 May 2025 10:33:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746182010; cv=none; b=aCH79Ql9lV+1hXzrl11kYFzTmL7Zt9lVzEq0c54iT+XL71JKVfkuRJXYSGlRXR7DdpcOgP4dWdyxUk8aWvPVmIKAomFToALk921W0Nyjo64PWMLBsbGbHs/oiBuhC5RJ6i8JOwqOeEPWvpE7HuhA7dJAHqb3CHGxvlsQWRZX1J8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746182010; c=relaxed/simple;
	bh=IIY2BFC/gCiOqmObT0jMHgCJi9hjERXLLf5rFvHprFc=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=OtznLWb5oau4S74xAto9glKxKvMQnfmQ2F8jlELnxi9zXLQDszPXJSQLasklq6DWK1dN0uEHBidzWaWX85X+WN36hApeOzLZVglVwc43zOoEwbzGzpgZfVWfDdkJCNsl4kcuQWeUIYr0+pQ5i4F12r0A2RTDCDWM6Fbt7zZyKZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=GRmlHvBx; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=qEEm2848; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 02 May 2025 10:33:25 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1746182006;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9uMNlKex9ex4RFB/3qtioONqy7cgylFnUMP4QMsEB2Y=;
	b=GRmlHvBxloASP94dvUy6GaL23vLYKdPG0xoKtCha59L+SvyV/ILuS+7v71nknyKKSnp3RI
	Da8E6WvdU9YqWoheLYfZfng+dbK46ArtU3R6G5e77eufuA+sWr5/FcOhg+NszIgVb/j6FZ
	sPQ4y3gJLpBzqz7eca7UzY/84guOEves7eFDUNtEbLG3aYdKL4e7ov1g1dW28WliV8mBh6
	126opCmsG8Xb8Ap+7Ae2zJZokBSqrcVgPgHDGU1tSVb6TSsRF+e8bXuvDLS+ODQmlEqroE
	KwHxuw9x5oiYbZVh1fortLa1n6+fLkeEoNUOYpcb22LMpVVerIj6U6OLbmv+/Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1746182006;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9uMNlKex9ex4RFB/3qtioONqy7cgylFnUMP4QMsEB2Y=;
	b=qEEm2848toWbOaQNbomKZ2jWoTRzaRnnuKrUR1f0zxO/NX6r474vR0IaE89OzI4NyBDhPa
	an0Ml9ekTBoLJ5DA==
From: "tip-bot2 for David Kaplan" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/bugs] x86/bugs: Restructure BHI mitigation
Cc: David Kaplan <david.kaplan@amd.com>,
 "Borislav Petkov (AMD)" <bp@alien8.de>, Josh Poimboeuf <jpoimboe@kernel.org>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250418161721.1855190-13-david.kaplan@amd.com>
References: <20250418161721.1855190-13-david.kaplan@amd.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174618200578.22196.13700533581605582970.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/bugs branch of tip:

Commit-ID:     efe313827c98c81156dea9b004877db4ca728b1a
Gitweb:        https://git.kernel.org/tip/efe313827c98c81156dea9b004877db4ca728b1a
Author:        David Kaplan <david.kaplan@amd.com>
AuthorDate:    Fri, 18 Apr 2025 11:17:17 -05:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Tue, 29 Apr 2025 18:51:29 +02:00

x86/bugs: Restructure BHI mitigation

Restructure BHI mitigation to use select/update/apply functions to create
consistent vulnerability handling.  BHI mitigation was previously selected
from within spectre_v2_select_mitigation() and now is selected from
cpu_select_mitigation() like with all others.

Define new AUTO mitigation for BHI.

Signed-off-by: David Kaplan <david.kaplan@amd.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Josh Poimboeuf <jpoimboe@kernel.org>
Link: https://lore.kernel.org/20250418161721.1855190-13-david.kaplan@amd.com
---
 arch/x86/kernel/cpu/bugs.c | 31 +++++++++++++++++++++++++++----
 1 file changed, 27 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index dc75195..100a320 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -82,6 +82,9 @@ static void __init l1d_flush_select_mitigation(void);
 static void __init srso_select_mitigation(void);
 static void __init gds_select_mitigation(void);
 static void __init gds_apply_mitigation(void);
+static void __init bhi_select_mitigation(void);
+static void __init bhi_update_mitigation(void);
+static void __init bhi_apply_mitigation(void);
 
 /* The base value of the SPEC_CTRL MSR without task-specific bits set */
 u64 x86_spec_ctrl_base;
@@ -208,6 +211,7 @@ void __init cpu_select_mitigations(void)
 	 */
 	srso_select_mitigation();
 	gds_select_mitigation();
+	bhi_select_mitigation();
 
 	/*
 	 * After mitigations are selected, some may need to update their
@@ -225,6 +229,7 @@ void __init cpu_select_mitigations(void)
 	taa_update_mitigation();
 	mmio_update_mitigation();
 	rfds_update_mitigation();
+	bhi_update_mitigation();
 
 	spectre_v1_apply_mitigation();
 	retbleed_apply_mitigation();
@@ -235,6 +240,7 @@ void __init cpu_select_mitigations(void)
 	rfds_apply_mitigation();
 	srbds_apply_mitigation();
 	gds_apply_mitigation();
+	bhi_apply_mitigation();
 }
 
 /*
@@ -1794,12 +1800,13 @@ static bool __init spec_ctrl_bhi_dis(void)
 
 enum bhi_mitigations {
 	BHI_MITIGATION_OFF,
+	BHI_MITIGATION_AUTO,
 	BHI_MITIGATION_ON,
 	BHI_MITIGATION_VMEXIT_ONLY,
 };
 
 static enum bhi_mitigations bhi_mitigation __ro_after_init =
-	IS_ENABLED(CONFIG_MITIGATION_SPECTRE_BHI) ? BHI_MITIGATION_ON : BHI_MITIGATION_OFF;
+	IS_ENABLED(CONFIG_MITIGATION_SPECTRE_BHI) ? BHI_MITIGATION_AUTO : BHI_MITIGATION_OFF;
 
 static int __init spectre_bhi_parse_cmdline(char *str)
 {
@@ -1821,6 +1828,25 @@ early_param("spectre_bhi", spectre_bhi_parse_cmdline);
 
 static void __init bhi_select_mitigation(void)
 {
+	if (!boot_cpu_has(X86_BUG_BHI) || cpu_mitigations_off())
+		bhi_mitigation = BHI_MITIGATION_OFF;
+
+	if (bhi_mitigation == BHI_MITIGATION_AUTO)
+		bhi_mitigation = BHI_MITIGATION_ON;
+}
+
+static void __init bhi_update_mitigation(void)
+{
+	if (spectre_v2_cmd == SPECTRE_V2_CMD_NONE)
+		bhi_mitigation = BHI_MITIGATION_OFF;
+
+	if (!boot_cpu_has_bug(X86_BUG_SPECTRE_V2) &&
+	     spectre_v2_cmd == SPECTRE_V2_CMD_AUTO)
+		bhi_mitigation = BHI_MITIGATION_OFF;
+}
+
+static void __init bhi_apply_mitigation(void)
+{
 	if (bhi_mitigation == BHI_MITIGATION_OFF)
 		return;
 
@@ -1961,9 +1987,6 @@ static void __init spectre_v2_select_mitigation(void)
 	    mode == SPECTRE_V2_RETPOLINE)
 		spec_ctrl_disable_kernel_rrsba();
 
-	if (boot_cpu_has(X86_BUG_BHI))
-		bhi_select_mitigation();
-
 	spectre_v2_enabled = mode;
 	pr_info("%s\n", spectre_v2_strings[mode]);
 

