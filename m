Return-Path: <linux-tip-commits+bounces-5188-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C608AA6FC1
	for <lists+linux-tip-commits@lfdr.de>; Fri,  2 May 2025 12:34:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B9F1B7ABCA5
	for <lists+linux-tip-commits@lfdr.de>; Fri,  2 May 2025 10:33:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3EDB2512C3;
	Fri,  2 May 2025 10:33:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="JZSLOx3l";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="QBHrrOYA"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93674245010;
	Fri,  2 May 2025 10:33:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746182015; cv=none; b=G+yVZOB/4WuzQf31zdpxMnsuNXOoF+wP275B4AoD3tlarjFvxCapE9xcOCl4iIjgYYrst1/6pJ7ONzRHY42QljoaHQSfpnrtMmRsYD6SkhkbK9CdYl8lO67aOHRCJFyHUUEYwn02VnMcCO4P7Yx+8KDNhpH6DU23fXY3CYSFm1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746182015; c=relaxed/simple;
	bh=vgC/ptgV5igon0Nlc68CzyHZCcrjeQQ//dfw+/kbvV8=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=iARnW1vrSmaL7vT1qq9m4HLAlAEAmWrrK9fGVoltTpSgRejsVJy8ei8qMIxs26LAUG7sDbkXVr1DlWJjtSMexKPKjWjr7OWb9tiLBl3Z+AongHsOruPz3SWQfbUrTIhZz2C7kVE4lzeIpwydnahIlasCskt+yTmlHmztjA4VZb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=JZSLOx3l; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=QBHrrOYA; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 02 May 2025 10:33:30 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1746182011;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aPuAwQQuQ06+wlbY33d7/P1kF1oMXzdbCUjitJkcaJM=;
	b=JZSLOx3lntMnHE3HPDxAQor88wANuTBpW/jf0WEj1Qgt/N9crQCjE128T19ENnqgC5vAY6
	cc3W1eBrHASIKi/pQdFnVttG8Yj/maFjjSBgYeWyYger8VP+7qZO0/0sVc1wSDubNEuBPB
	eTYv7g+R8eyF9Xb9J71fwRH1pjNfHNXscBjRU34ien3IDZgEL6UzeczxpTLzYwhXbLeixQ
	sVcSeBVnXVyuHYgcjTzr0Z3nHpesmh+Mq5zPWlZvEUnPPxWhxN9HSic1G6Hp6wAbIe6Xwu
	FHgXL7wZe1ovYVxdC8rcymWc491AG+Lb2kv5ef+nDv8zzLfa/05qs7o2uYCQNw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1746182011;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aPuAwQQuQ06+wlbY33d7/P1kF1oMXzdbCUjitJkcaJM=;
	b=QBHrrOYAQmdNE+2LnzNmT5I0xBx8C6x+vpX3oyBuSOV3WNqR5XpGSZUt3BJ8xYHAWEFOmG
	9VJFoHxCPL2bPVDw==
From: "tip-bot2 for David Kaplan" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/bugs] x86/bugs: Remove md_clear_*_mitigation()
Cc: David Kaplan <david.kaplan@amd.com>,
 "Borislav Petkov (AMD)" <bp@alien8.de>, Josh Poimboeuf <jpoimboe@kernel.org>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250418161721.1855190-6-david.kaplan@amd.com>
References: <20250418161721.1855190-6-david.kaplan@amd.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174618201097.22196.1284620919752584947.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/bugs branch of tip:

Commit-ID:     6f0960a760eb926d8a2b9fe6fc7a1086cba14dd1
Gitweb:        https://git.kernel.org/tip/6f0960a760eb926d8a2b9fe6fc7a1086cba14dd1
Author:        David Kaplan <david.kaplan@amd.com>
AuthorDate:    Sun, 27 Apr 2025 17:12:41 +02:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Mon, 28 Apr 2025 14:50:33 +02:00

x86/bugs: Remove md_clear_*_mitigation()

The functionality in md_clear_update_mitigation() and
md_clear_select_mitigation() is now integrated into the select/update
functions for the MDS, TAA, MMIO, and RFDS vulnerabilities.

Signed-off-by: David Kaplan <david.kaplan@amd.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Josh Poimboeuf <jpoimboe@kernel.org>
Link: https://lore.kernel.org/20250418161721.1855190-6-david.kaplan@amd.com
---
 arch/x86/kernel/cpu/bugs.c | 65 +-------------------------------------
 1 file changed, 65 deletions(-)

diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index 2705105..98476b8 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -62,8 +62,6 @@ static void __init l1tf_select_mitigation(void);
 static void __init mds_select_mitigation(void);
 static void __init mds_update_mitigation(void);
 static void __init mds_apply_mitigation(void);
-static void __init md_clear_update_mitigation(void);
-static void __init md_clear_select_mitigation(void);
 static void __init taa_select_mitigation(void);
 static void __init taa_update_mitigation(void);
 static void __init taa_apply_mitigation(void);
@@ -204,7 +202,6 @@ void __init cpu_select_mitigations(void)
 	taa_select_mitigation();
 	mmio_select_mitigation();
 	rfds_select_mitigation();
-	md_clear_select_mitigation();
 	srbds_select_mitigation();
 	l1d_flush_select_mitigation();
 
@@ -692,68 +689,6 @@ static __init int rfds_parse_cmdline(char *str)
 early_param("reg_file_data_sampling", rfds_parse_cmdline);
 
 #undef pr_fmt
-#define pr_fmt(fmt)     "" fmt
-
-static void __init md_clear_update_mitigation(void)
-{
-	if (cpu_mitigations_off())
-		return;
-
-	if (!boot_cpu_has(X86_FEATURE_CLEAR_CPU_BUF))
-		goto out;
-
-	/*
-	 * X86_FEATURE_CLEAR_CPU_BUF is now enabled. Update MDS, TAA and MMIO
-	 * Stale Data mitigation, if necessary.
-	 */
-	if (mds_mitigation == MDS_MITIGATION_OFF &&
-	    boot_cpu_has_bug(X86_BUG_MDS)) {
-		mds_mitigation = MDS_MITIGATION_FULL;
-		mds_select_mitigation();
-	}
-	if (taa_mitigation == TAA_MITIGATION_OFF &&
-	    boot_cpu_has_bug(X86_BUG_TAA)) {
-		taa_mitigation = TAA_MITIGATION_VERW;
-		taa_select_mitigation();
-	}
-	/*
-	 * MMIO_MITIGATION_OFF is not checked here so that cpu_buf_vm_clear
-	 * gets updated correctly as per X86_FEATURE_CLEAR_CPU_BUF state.
-	 */
-	if (boot_cpu_has_bug(X86_BUG_MMIO_STALE_DATA)) {
-		mmio_mitigation = MMIO_MITIGATION_VERW;
-		mmio_select_mitigation();
-	}
-	if (rfds_mitigation == RFDS_MITIGATION_OFF &&
-	    boot_cpu_has_bug(X86_BUG_RFDS)) {
-		rfds_mitigation = RFDS_MITIGATION_VERW;
-		rfds_select_mitigation();
-	}
-out:
-	if (boot_cpu_has_bug(X86_BUG_MDS))
-		pr_info("MDS: %s\n", mds_strings[mds_mitigation]);
-	if (boot_cpu_has_bug(X86_BUG_TAA))
-		pr_info("TAA: %s\n", taa_strings[taa_mitigation]);
-	if (boot_cpu_has_bug(X86_BUG_MMIO_STALE_DATA))
-		pr_info("MMIO Stale Data: %s\n", mmio_strings[mmio_mitigation]);
-	else if (boot_cpu_has_bug(X86_BUG_MMIO_UNKNOWN))
-		pr_info("MMIO Stale Data: Unknown: No mitigations\n");
-	if (boot_cpu_has_bug(X86_BUG_RFDS))
-		pr_info("Register File Data Sampling: %s\n", rfds_strings[rfds_mitigation]);
-}
-
-static void __init md_clear_select_mitigation(void)
-{
-
-	/*
-	 * As these mitigations are inter-related and rely on VERW instruction
-	 * to clear the microarchitural buffers, update and print their status
-	 * after mitigation selection is done for each of these vulnerabilities.
-	 */
-	md_clear_update_mitigation();
-}
-
-#undef pr_fmt
 #define pr_fmt(fmt)	"SRBDS: " fmt
 
 enum srbds_mitigations {

