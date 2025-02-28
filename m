Return-Path: <linux-tip-commits+bounces-3737-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BD6E1A49894
	for <lists+linux-tip-commits@lfdr.de>; Fri, 28 Feb 2025 12:53:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BBE6E171498
	for <lists+linux-tip-commits@lfdr.de>; Fri, 28 Feb 2025 11:53:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEC4D25F96A;
	Fri, 28 Feb 2025 11:53:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="whHUIvK8";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="HfXTk+p2"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0701723E32A;
	Fri, 28 Feb 2025 11:53:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740743627; cv=none; b=Yzj6LfFhF5PAngVmeBhwX3scySc2oGm0AHKpI2K/yRPLU9YSK8L/eS/5giHDH9KCrR97MlmpDyjousgRhNuj2j/D76u0hFtCmy9LqKyBlVci7BaLlbTOstX6vAh8WSPJjyCacZAQA3BQz+6ERUKIlGVk62GwJ7HTndyAvnfJ90k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740743627; c=relaxed/simple;
	bh=qRL1JrJfU/+UhGR8BWAX6aHsQdeLBi92hFuPj6Krv+0=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=UCTG+yahYZY1jNV7uepDCmOBQllNiTbrSNJ+9aUFO9/WG6X7Bk6mu+Dd0VCGxa8mPaZSiXY5g1yHG4bqzIgoXb/mkzwFWZ2jN29e6yjcxWB7AbBwM3aNMETHdkOK/41KtXlq4U+pl20XNeWLt6a0Gs9NZSJQPzjoru9RaODR+O0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=whHUIvK8; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=HfXTk+p2; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 28 Feb 2025 11:53:42 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1740743623;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=X9zGFeSx0STFrcDuWpCm246dqLdwUqDb17I+NiVchwU=;
	b=whHUIvK8qYgXoDsH0XjDprf9FnA3Z2umDYh1lXDiSUGYCa+4w6ipPnnZ+oe/dMM+I4/+Hj
	JyGvkzhm9IbqNxt2Wlv4jmzPRqXDmSplSgQ0DvWci+K7FJ88KY7pFJYmkKYVA9Oj8h3oDV
	rgE7evEe0EV/B67ceEXVce5phfWbEe9WF1FWfwyacWDfgOtuLs7/W8HYs1It0ZGHMnl2pR
	c34+V7pH6ebFuWpft6t+pGBO9+oaX/8IbDkwzr6uHrVBHgMF0Cuq+Ms4BFAFWsczTfWqPm
	u44fuzTGvDqn5pQd1vtZtzJ0Y/9GMcgRZqTdOe5Nr5mPG5jFoBCv4yQl+TtyoQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1740743623;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=X9zGFeSx0STFrcDuWpCm246dqLdwUqDb17I+NiVchwU=;
	b=HfXTk+p2r24wRVRJdNxTy7L25XrEfrDZsuCACe6mrXMlLZRt+aZt0WI810oI4qYEu31yl/
	4LDFkE5UhQYlKgAg==
From: "tip-bot2 for David Kaplan" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/bugs] x86/bugs: Add AUTO mitigations for mds/taa/mmio/rfds
Cc: David Kaplan <david.kaplan@amd.com>,
 "Borislav Petkov (AMD)" <bp@alien8.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250108202515.385902-4-david.kaplan@amd.com>
References: <20250108202515.385902-4-david.kaplan@amd.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174074362237.10177.13779022409559637481.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/bugs branch of tip:

Commit-ID:     b8ce25df2999ac6a135ce1bd14b7243030a1338a
Gitweb:        https://git.kernel.org/tip/b8ce25df2999ac6a135ce1bd14b7243030a1338a
Author:        David Kaplan <david.kaplan@amd.com>
AuthorDate:    Wed, 08 Jan 2025 14:24:43 -06:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Fri, 28 Feb 2025 12:40:21 +01:00

x86/bugs: Add AUTO mitigations for mds/taa/mmio/rfds

Add AUTO mitigations for mds/taa/mmio/rfds to create consistent vulnerability
handling.  These AUTO mitigations will be turned into the appropriate default
mitigations in the <vuln>_select_mitigation() functions.  Later, these will be
used with the new attack vector controls to help select appropriate
mitigations.

Signed-off-by: David Kaplan <david.kaplan@amd.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://lore.kernel.org/r/20250108202515.385902-4-david.kaplan@amd.com
---
 arch/x86/include/asm/processor.h |  1 +
 arch/x86/kernel/cpu/bugs.c       | 20 ++++++++++++++++----
 2 files changed, 17 insertions(+), 4 deletions(-)

diff --git a/arch/x86/include/asm/processor.h b/arch/x86/include/asm/processor.h
index c0cd101..90278d0 100644
--- a/arch/x86/include/asm/processor.h
+++ b/arch/x86/include/asm/processor.h
@@ -757,6 +757,7 @@ extern enum l1tf_mitigations l1tf_mitigation;
 
 enum mds_mitigations {
 	MDS_MITIGATION_OFF,
+	MDS_MITIGATION_AUTO,
 	MDS_MITIGATION_FULL,
 	MDS_MITIGATION_VMWERV,
 };
diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index 4269ed1..93c437f 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -238,7 +238,7 @@ static void x86_amd_ssb_disable(void)
 
 /* Default mitigation for MDS-affected CPUs */
 static enum mds_mitigations mds_mitigation __ro_after_init =
-	IS_ENABLED(CONFIG_MITIGATION_MDS) ? MDS_MITIGATION_FULL : MDS_MITIGATION_OFF;
+	IS_ENABLED(CONFIG_MITIGATION_MDS) ? MDS_MITIGATION_AUTO : MDS_MITIGATION_OFF;
 static bool mds_nosmt __ro_after_init = false;
 
 static const char * const mds_strings[] = {
@@ -249,6 +249,7 @@ static const char * const mds_strings[] = {
 
 enum taa_mitigations {
 	TAA_MITIGATION_OFF,
+	TAA_MITIGATION_AUTO,
 	TAA_MITIGATION_UCODE_NEEDED,
 	TAA_MITIGATION_VERW,
 	TAA_MITIGATION_TSX_DISABLED,
@@ -256,27 +257,29 @@ enum taa_mitigations {
 
 /* Default mitigation for TAA-affected CPUs */
 static enum taa_mitigations taa_mitigation __ro_after_init =
-	IS_ENABLED(CONFIG_MITIGATION_TAA) ? TAA_MITIGATION_VERW : TAA_MITIGATION_OFF;
+	IS_ENABLED(CONFIG_MITIGATION_TAA) ? TAA_MITIGATION_AUTO : TAA_MITIGATION_OFF;
 
 enum mmio_mitigations {
 	MMIO_MITIGATION_OFF,
+	MMIO_MITIGATION_AUTO,
 	MMIO_MITIGATION_UCODE_NEEDED,
 	MMIO_MITIGATION_VERW,
 };
 
 /* Default mitigation for Processor MMIO Stale Data vulnerabilities */
 static enum mmio_mitigations mmio_mitigation __ro_after_init =
-	IS_ENABLED(CONFIG_MITIGATION_MMIO_STALE_DATA) ? MMIO_MITIGATION_VERW : MMIO_MITIGATION_OFF;
+	IS_ENABLED(CONFIG_MITIGATION_MMIO_STALE_DATA) ?	MMIO_MITIGATION_AUTO : MMIO_MITIGATION_OFF;
 
 enum rfds_mitigations {
 	RFDS_MITIGATION_OFF,
+	RFDS_MITIGATION_AUTO,
 	RFDS_MITIGATION_VERW,
 	RFDS_MITIGATION_UCODE_NEEDED,
 };
 
 /* Default mitigation for Register File Data Sampling */
 static enum rfds_mitigations rfds_mitigation __ro_after_init =
-	IS_ENABLED(CONFIG_MITIGATION_RFDS) ? RFDS_MITIGATION_VERW : RFDS_MITIGATION_OFF;
+	IS_ENABLED(CONFIG_MITIGATION_RFDS) ? RFDS_MITIGATION_AUTO : RFDS_MITIGATION_OFF;
 
 static void __init mds_select_mitigation(void)
 {
@@ -285,6 +288,9 @@ static void __init mds_select_mitigation(void)
 		return;
 	}
 
+	if (mds_mitigation == MDS_MITIGATION_AUTO)
+		mds_mitigation = MDS_MITIGATION_FULL;
+
 	if (mds_mitigation == MDS_MITIGATION_FULL) {
 		if (!boot_cpu_has(X86_FEATURE_MD_CLEAR))
 			mds_mitigation = MDS_MITIGATION_VMWERV;
@@ -514,6 +520,9 @@ static void __init rfds_select_mitigation(void)
 	if (rfds_mitigation == RFDS_MITIGATION_OFF)
 		return;
 
+	if (rfds_mitigation == RFDS_MITIGATION_AUTO)
+		rfds_mitigation = RFDS_MITIGATION_VERW;
+
 	if (x86_arch_cap_msr & ARCH_CAP_RFDS_CLEAR)
 		setup_force_cpu_cap(X86_FEATURE_CLEAR_CPU_BUF);
 	else
@@ -1979,6 +1988,7 @@ void cpu_bugs_smt_update(void)
 
 	switch (mds_mitigation) {
 	case MDS_MITIGATION_FULL:
+	case MDS_MITIGATION_AUTO:
 	case MDS_MITIGATION_VMWERV:
 		if (sched_smt_active() && !boot_cpu_has(X86_BUG_MSBDS_ONLY))
 			pr_warn_once(MDS_MSG_SMT);
@@ -1990,6 +2000,7 @@ void cpu_bugs_smt_update(void)
 
 	switch (taa_mitigation) {
 	case TAA_MITIGATION_VERW:
+	case TAA_MITIGATION_AUTO:
 	case TAA_MITIGATION_UCODE_NEEDED:
 		if (sched_smt_active())
 			pr_warn_once(TAA_MSG_SMT);
@@ -2001,6 +2012,7 @@ void cpu_bugs_smt_update(void)
 
 	switch (mmio_mitigation) {
 	case MMIO_MITIGATION_VERW:
+	case MMIO_MITIGATION_AUTO:
 	case MMIO_MITIGATION_UCODE_NEEDED:
 		if (sched_smt_active())
 			pr_warn_once(MMIO_MSG_SMT);

