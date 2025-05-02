Return-Path: <linux-tip-commits+bounces-5194-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EE47AA6FCE
	for <lists+linux-tip-commits@lfdr.de>; Fri,  2 May 2025 12:35:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C860D1790A1
	for <lists+linux-tip-commits@lfdr.de>; Fri,  2 May 2025 10:35:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A52F423C517;
	Fri,  2 May 2025 10:33:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="PZ5wDCqd";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="OXcl0jrs"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 421C92528E9;
	Fri,  2 May 2025 10:33:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746182019; cv=none; b=nT7lk2xA0/VnnpTt/Fscap8kptfA38D37ps9FYDjJ7xeM4n8CqErH/6UtJ7rYxZ2S0+sYA5ROoL9b7fj/UeMKBD7xyS39NJc+RHpoHg+HDA9HokEFpDRiIVtbm9BC/AbJ2b6IptgvE58S28wB7hP1ihdo987FQ7Dn6VgkYuvxpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746182019; c=relaxed/simple;
	bh=NN+tl93u89HMakhZg0Bu/quEEHipIPYaArMjK+yb8DE=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=V82IbOP9dtnJTlTCieo+DT6gvxKergt/PSkk1vcqvHGlBBMWkbJ1vYm20klYQiDtld6aUyECrwg1Oz8fOeO7fiFVipfguh5Umh5gsuNEmKeLPylhUNF4yAM35V1jzZBsBetr9UQdr+7bI5e0V2kBrDF29d59IN/JEFtIri9ibaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=PZ5wDCqd; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=OXcl0jrs; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 02 May 2025 10:33:33 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1746182014;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xWps/TqteYyqyQvyJzEzdui3HSb4UQD4s5gtkLlCJLM=;
	b=PZ5wDCqdR7OHBjg3siUZN0dNRA4Yf8pRLJtuAVinCl47exU6N00LOrGvTSs6MUmjNFW6Vc
	ItD0WgBNAJYsUFTrykWBsIxrSPBguitAEvuo+3PGgIyF7F8CeWRZQ0GAqb/oISeNXn1EzE
	6Q4bmZpAM1hA3zy12b4hPDOlBrZ4bPsc68d00vxbOa+IUrWny+ecIuoCq/5mL8Dpyo+QH9
	eJ9YTKGTtyAsPCWgpkhM8iTHoGLNlpmwEJt5nOgCziXmqJ3ZfWUn3NlSQshLVlQXqba0tU
	e4mY+E+tiqqLwb0q/KDazqzxvdjXnCvMuAWnZ8l2BYsupfNPjEEkczQ6bEAZIw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1746182014;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xWps/TqteYyqyQvyJzEzdui3HSb4UQD4s5gtkLlCJLM=;
	b=OXcl0jrs/FTd4tv1woxNPjSEoVjog3WXatEfxcLgYTxnyAD9oA9MmIAy2vvIvZt3jKT4MC
	Jx82+UY8iM6bHVCw==
From: "tip-bot2 for David Kaplan" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/bugs] x86/bugs: Restructure MDS mitigation
Cc: David Kaplan <david.kaplan@amd.com>,
 "Borislav Petkov (AMD)" <bp@alien8.de>, Josh Poimboeuf <jpoimboe@kernel.org>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250418161721.1855190-2-david.kaplan@amd.com>
References: <20250418161721.1855190-2-david.kaplan@amd.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174618201374.22196.15610752935421268143.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/bugs branch of tip:

Commit-ID:     559c758bc722ca0630d2b7f433f490cb76fe6128
Gitweb:        https://git.kernel.org/tip/559c758bc722ca0630d2b7f433f490cb76fe6128
Author:        David Kaplan <david.kaplan@amd.com>
AuthorDate:    Fri, 18 Apr 2025 11:17:06 -05:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Mon, 28 Apr 2025 12:53:33 +02:00

x86/bugs: Restructure MDS mitigation

Restructure MDS mitigation selection to use select/update/apply
functions to create consistent vulnerability handling.

  [ bp: rename and beef up comment over VERW mitigation selected var for
    maximum clarity. ]

Signed-off-by: David Kaplan <david.kaplan@amd.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Josh Poimboeuf <jpoimboe@kernel.org>
Link: https://lore.kernel.org/20250418161721.1855190-2-david.kaplan@amd.com
---
 arch/x86/kernel/cpu/bugs.c | 61 +++++++++++++++++++++++++++++++++++--
 1 file changed, 59 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index 9131e61..f697e6b 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -34,6 +34,25 @@
 
 #include "cpu.h"
 
+/*
+ * Speculation Vulnerability Handling
+ *
+ * Each vulnerability is handled with the following functions:
+ *   <vuln>_select_mitigation() -- Selects a mitigation to use.  This should
+ *				   take into account all relevant command line
+ *				   options.
+ *   <vuln>_update_mitigation() -- This is called after all vulnerabilities have
+ *				   selected a mitigation, in case the selection
+ *				   may want to change based on other choices
+ *				   made.  This function is optional.
+ *   <vuln>_apply_mitigation() -- Enable the selected mitigation.
+ *
+ * The compile-time mitigation in all cases should be AUTO.  An explicit
+ * command-line option can override AUTO.  If no such option is
+ * provided, <vuln>_select_mitigation() will override AUTO to the best
+ * mitigation option.
+ */
+
 static void __init spectre_v1_select_mitigation(void);
 static void __init spectre_v2_select_mitigation(void);
 static void __init retbleed_select_mitigation(void);
@@ -41,6 +60,8 @@ static void __init spectre_v2_user_select_mitigation(void);
 static void __init ssb_select_mitigation(void);
 static void __init l1tf_select_mitigation(void);
 static void __init mds_select_mitigation(void);
+static void __init mds_update_mitigation(void);
+static void __init mds_apply_mitigation(void);
 static void __init md_clear_update_mitigation(void);
 static void __init md_clear_select_mitigation(void);
 static void __init taa_select_mitigation(void);
@@ -172,6 +193,7 @@ void __init cpu_select_mitigations(void)
 	spectre_v2_user_select_mitigation();
 	ssb_select_mitigation();
 	l1tf_select_mitigation();
+	mds_select_mitigation();
 	md_clear_select_mitigation();
 	srbds_select_mitigation();
 	l1d_flush_select_mitigation();
@@ -182,6 +204,14 @@ void __init cpu_select_mitigations(void)
 	 */
 	srso_select_mitigation();
 	gds_select_mitigation();
+
+	/*
+	 * After mitigations are selected, some may need to update their
+	 * choices.
+	 */
+	mds_update_mitigation();
+
+	mds_apply_mitigation();
 }
 
 /*
@@ -284,6 +314,12 @@ enum rfds_mitigations {
 static enum rfds_mitigations rfds_mitigation __ro_after_init =
 	IS_ENABLED(CONFIG_MITIGATION_RFDS) ? RFDS_MITIGATION_AUTO : RFDS_MITIGATION_OFF;
 
+/*
+ * Set if any of MDS/TAA/MMIO/RFDS are going to enable VERW clearing
+ * through X86_FEATURE_CLEAR_CPU_BUF on kernel and guest entry.
+ */
+static bool verw_clear_cpu_buf_mitigation_selected __ro_after_init;
+
 static void __init mds_select_mitigation(void)
 {
 	if (!boot_cpu_has_bug(X86_BUG_MDS) || cpu_mitigations_off()) {
@@ -294,12 +330,34 @@ static void __init mds_select_mitigation(void)
 	if (mds_mitigation == MDS_MITIGATION_AUTO)
 		mds_mitigation = MDS_MITIGATION_FULL;
 
+	if (mds_mitigation == MDS_MITIGATION_OFF)
+		return;
+
+	verw_clear_cpu_buf_mitigation_selected = true;
+}
+
+static void __init mds_update_mitigation(void)
+{
+	if (!boot_cpu_has_bug(X86_BUG_MDS) || cpu_mitigations_off())
+		return;
+
+	/* If TAA, MMIO, or RFDS are being mitigated, MDS gets mitigated too. */
+	if (verw_clear_cpu_buf_mitigation_selected)
+		mds_mitigation = MDS_MITIGATION_FULL;
+
 	if (mds_mitigation == MDS_MITIGATION_FULL) {
 		if (!boot_cpu_has(X86_FEATURE_MD_CLEAR))
 			mds_mitigation = MDS_MITIGATION_VMWERV;
+	}
 
-		setup_force_cpu_cap(X86_FEATURE_CLEAR_CPU_BUF);
+	pr_info("%s\n", mds_strings[mds_mitigation]);
+}
 
+static void __init mds_apply_mitigation(void)
+{
+	if (mds_mitigation == MDS_MITIGATION_FULL ||
+	    mds_mitigation == MDS_MITIGATION_VMWERV) {
+		setup_force_cpu_cap(X86_FEATURE_CLEAR_CPU_BUF);
 		if (!boot_cpu_has(X86_BUG_MSBDS_ONLY) &&
 		    (mds_nosmt || cpu_mitigations_auto_nosmt()))
 			cpu_smt_disable(false);
@@ -602,7 +660,6 @@ out:
 
 static void __init md_clear_select_mitigation(void)
 {
-	mds_select_mitigation();
 	taa_select_mitigation();
 	mmio_select_mitigation();
 	rfds_select_mitigation();

