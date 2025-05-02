Return-Path: <linux-tip-commits+bounces-5193-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E310AA6FCA
	for <lists+linux-tip-commits@lfdr.de>; Fri,  2 May 2025 12:35:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 262A0983E74
	for <lists+linux-tip-commits@lfdr.de>; Fri,  2 May 2025 10:35:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CAD2254AF8;
	Fri,  2 May 2025 10:33:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="M4NDr/3Z";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="2vjH2TYL"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5825242D98;
	Fri,  2 May 2025 10:33:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746182018; cv=none; b=Qzkv9AGzBpKZlHwo/OXDptYAMe8cAtiCPD5akpZLcOruVCDf2nyMUB8alu+J7vumTbvx7fmY1xLr2czNNs3WptR5yoVgb/TeWJWd7hexNRWIq4W0mL6SuCbqtILoCkmp8YtUTaW0ovq/EHMkfK6N9vocM6h/sOk5tusg9rvbrQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746182018; c=relaxed/simple;
	bh=GKngDCaByleHECGCfn9O4iNv+u6LScjdlvoE6btevdc=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=SL0LsJaj7ZqtmdFlVCk6l1I+ettLjDMXBLESoBUxO62ZBCaF9zMrw9goKY/91ZHFtWgrAqMerOlv9ysf3d3k0Mm23jefCeATVW23YG3nCiyViMjnWmSZDN1X4JeTo8yN25lzBYBcQiTh2k8HUHjbG8TrkW/kiqaACW/BUyQv6dw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=M4NDr/3Z; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=2vjH2TYL; arc=none smtp.client-ip=193.142.43.55
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
	bh=nWneAQ5qrtCXqZyNQqntZot7NnjmfiEuipquxgf2oOg=;
	b=M4NDr/3ZEkNfVFiG8tLLFnFEEJhtMUbYfmMT0hC5r4iNymAsrKgD49FZ9af5dtsT60SC2q
	gvAO8xJZItIGZyV5MGaTkvzT/j21yZRQBWWppqKzxXsn/Hq/qRIgXktvkzs70zqMlGlYdT
	ZuNdF5jccaBndCodt/78a5Ta9MaSAKFEdFbrHh3fRBvD89cbeAN0UPdEThWDPMKZ9vssq8
	ajbSjpE76V3Z0I34fYL22+bUgnfxha72TzPTytiE99lfd1N1c/NNhQ5we0ISyY3TcAJ/Xe
	/MGe/KFEH0wkmAc3igiz6MoYOSeoGXfIbCQdFMTHt/t8rNDaDIxXisXPO/Le5g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1746182011;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nWneAQ5qrtCXqZyNQqntZot7NnjmfiEuipquxgf2oOg=;
	b=2vjH2TYLUyeMcvKZIX0u46x62DaDiVfc2tLcqnycE2FexcYfvWZjkLS5WCYu6XFuhkQHXI
	4qoJYgoZe1mLcqCA==
From: "tip-bot2 for David Kaplan" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/bugs] x86/bugs: Restructure SRBDS mitigation
Cc: David Kaplan <david.kaplan@amd.com>,
 "Borislav Petkov (AMD)" <bp@alien8.de>, Josh Poimboeuf <jpoimboe@kernel.org>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250418161721.1855190-7-david.kaplan@amd.com>
References: <20250418161721.1855190-7-david.kaplan@amd.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174618201022.22196.8778383511604906614.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/bugs branch of tip:

Commit-ID:     2178ac58e176d8e1e4529b02647f5e549bb88405
Gitweb:        https://git.kernel.org/tip/2178ac58e176d8e1e4529b02647f5e549bb88405
Author:        David Kaplan <david.kaplan@amd.com>
AuthorDate:    Fri, 18 Apr 2025 11:17:11 -05:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Mon, 28 Apr 2025 15:05:41 +02:00

x86/bugs: Restructure SRBDS mitigation

Restructure SRBDS to use select/apply functions to create consistent
vulnerability handling.

Define new AUTO mitigation for SRBDS.

Signed-off-by: David Kaplan <david.kaplan@amd.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Josh Poimboeuf <jpoimboe@kernel.org>
Link: https://lore.kernel.org/20250418161721.1855190-7-david.kaplan@amd.com
---
 arch/x86/kernel/cpu/bugs.c | 20 ++++++++++++++++----
 1 file changed, 16 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index 98476b8..25b74a7 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -72,6 +72,7 @@ static void __init rfds_select_mitigation(void);
 static void __init rfds_update_mitigation(void);
 static void __init rfds_apply_mitigation(void);
 static void __init srbds_select_mitigation(void);
+static void __init srbds_apply_mitigation(void);
 static void __init l1d_flush_select_mitigation(void);
 static void __init srso_select_mitigation(void);
 static void __init gds_select_mitigation(void);
@@ -225,6 +226,7 @@ void __init cpu_select_mitigations(void)
 	taa_apply_mitigation();
 	mmio_apply_mitigation();
 	rfds_apply_mitigation();
+	srbds_apply_mitigation();
 }
 
 /*
@@ -693,6 +695,7 @@ early_param("reg_file_data_sampling", rfds_parse_cmdline);
 
 enum srbds_mitigations {
 	SRBDS_MITIGATION_OFF,
+	SRBDS_MITIGATION_AUTO,
 	SRBDS_MITIGATION_UCODE_NEEDED,
 	SRBDS_MITIGATION_FULL,
 	SRBDS_MITIGATION_TSX_OFF,
@@ -700,7 +703,7 @@ enum srbds_mitigations {
 };
 
 static enum srbds_mitigations srbds_mitigation __ro_after_init =
-	IS_ENABLED(CONFIG_MITIGATION_SRBDS) ? SRBDS_MITIGATION_FULL : SRBDS_MITIGATION_OFF;
+	IS_ENABLED(CONFIG_MITIGATION_SRBDS) ? SRBDS_MITIGATION_AUTO : SRBDS_MITIGATION_OFF;
 
 static const char * const srbds_strings[] = {
 	[SRBDS_MITIGATION_OFF]		= "Vulnerable",
@@ -751,8 +754,13 @@ void update_srbds_msr(void)
 
 static void __init srbds_select_mitigation(void)
 {
-	if (!boot_cpu_has_bug(X86_BUG_SRBDS))
+	if (!boot_cpu_has_bug(X86_BUG_SRBDS) || cpu_mitigations_off()) {
+		srbds_mitigation = SRBDS_MITIGATION_OFF;
 		return;
+	}
+
+	if (srbds_mitigation == SRBDS_MITIGATION_AUTO)
+		srbds_mitigation = SRBDS_MITIGATION_FULL;
 
 	/*
 	 * Check to see if this is one of the MDS_NO systems supporting TSX that
@@ -766,13 +774,17 @@ static void __init srbds_select_mitigation(void)
 		srbds_mitigation = SRBDS_MITIGATION_HYPERVISOR;
 	else if (!boot_cpu_has(X86_FEATURE_SRBDS_CTRL))
 		srbds_mitigation = SRBDS_MITIGATION_UCODE_NEEDED;
-	else if (cpu_mitigations_off() || srbds_off)
+	else if (srbds_off)
 		srbds_mitigation = SRBDS_MITIGATION_OFF;
 
-	update_srbds_msr();
 	pr_info("%s\n", srbds_strings[srbds_mitigation]);
 }
 
+static void __init srbds_apply_mitigation(void)
+{
+	update_srbds_msr();
+}
+
 static int __init srbds_parse_cmdline(char *str)
 {
 	if (!str)

