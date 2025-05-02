Return-Path: <linux-tip-commits+bounces-5189-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 77648AA6FC3
	for <lists+linux-tip-commits@lfdr.de>; Fri,  2 May 2025 12:34:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DF0F17ACAF4
	for <lists+linux-tip-commits@lfdr.de>; Fri,  2 May 2025 10:33:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49829252904;
	Fri,  2 May 2025 10:33:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="vxpjUv1p";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="PKOfPpP+"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 418EF246769;
	Fri,  2 May 2025 10:33:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746182016; cv=none; b=D/dUet8atVd7aESc3S2bDx7cx2Ry757k06JslW62P7g8ay+o9+4gCAIBzEpEHh4ybnSUXAuwCdKKiwvmYnmBD9eHYLazbgaNekZtz2WLYSNMDIPL9spKdgHBZnhvo9cz4qVBrUM0CrgXznGoSkG8KhPcHAdiU9OnoeAU46Tm1Z8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746182016; c=relaxed/simple;
	bh=argSR+pWxqIh3hqxMbZTID4p5j3LlF7ZTAHs2kZWGGU=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=PePg8CBcuEiufAWGB6D7DRiNx3a/j+Nibro0MrLCNmYcRiUh61T0Vl8BF/KMg4DkdNqYqKpJMdGv/fMrB5BRX2Uouc+3Y39eYx+icDmMKQuV28Crx6x+CA5aQjc201qVCVA46cyMkkQ9GrormKS9w9N4U7XjaE8cYh6GCcTtfh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=vxpjUv1p; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=PKOfPpP+; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 02 May 2025 10:33:31 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1746182012;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+ohcfW0fw6V4zKN19ZFhp4axbmjVuP3KhMsDYUKdQRE=;
	b=vxpjUv1pf0f4tCtuCSOlDRvSwA+SuIXpCe7npwgd+McRSrUcHdxunNAKPSzRA+OnRSmZ0M
	uXdPYU8SplSmtXoFyEgYxF8nrIFGvIev3tT8Uvbiug5ctE4pJTDYLvRUugKQMdQy6dKdrK
	BoxReKy42WrOI9n5irS3U51vZNpaCKZLD1shKH+/YQ7gunOmV3uOrNDzKgTz+ajOOgCvNY
	FTDtS6DQYK2s59ApxPiR4POlk5Q0vhHj9qYH3g+W8lP2YpIFuSxJud+ft2nWMKeo9Cqz2/
	zdlryo3tXaamLDRpb/4ciKccwKgCAjB4xHLCqcio6ZrpXvMDeH7Idand1QhdWA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1746182012;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+ohcfW0fw6V4zKN19ZFhp4axbmjVuP3KhMsDYUKdQRE=;
	b=PKOfPpP++SeKmqY0y8jns5oCB7EPyEt//t8WSOtpnbbiaQ1K7KS3wKnow4eQVkfpMpxdRq
	brP5DWo+M/J3rcDg==
From: "tip-bot2 for David Kaplan" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/bugs] x86/bugs: Restructure RFDS mitigation
Cc: David Kaplan <david.kaplan@amd.com>,
 "Borislav Petkov (AMD)" <bp@alien8.de>, Josh Poimboeuf <jpoimboe@kernel.org>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250418161721.1855190-5-david.kaplan@amd.com>
References: <20250418161721.1855190-5-david.kaplan@amd.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174618201173.22196.6101974953788091518.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/bugs branch of tip:

Commit-ID:     203d81f8e167a9e82747a14dace40e0abbd5c791
Gitweb:        https://git.kernel.org/tip/203d81f8e167a9e82747a14dace40e0abbd5c791
Author:        David Kaplan <david.kaplan@amd.com>
AuthorDate:    Fri, 18 Apr 2025 11:17:09 -05:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Mon, 28 Apr 2025 13:46:11 +02:00

x86/bugs: Restructure RFDS mitigation

Restructure RFDS mitigation to use select/update/apply functions to
create consistent vulnerability handling.

  [ bp: Rename the oneline helper to what it checks. ]

Signed-off-by: David Kaplan <david.kaplan@amd.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Josh Poimboeuf <jpoimboe@kernel.org>
Link: https://lore.kernel.org/20250418161721.1855190-5-david.kaplan@amd.com
---
 arch/x86/kernel/cpu/bugs.c | 41 ++++++++++++++++++++++++++++++++-----
 1 file changed, 36 insertions(+), 5 deletions(-)

diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index bc74c22..2705105 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -70,6 +70,9 @@ static void __init taa_apply_mitigation(void);
 static void __init mmio_select_mitigation(void);
 static void __init mmio_update_mitigation(void);
 static void __init mmio_apply_mitigation(void);
+static void __init rfds_select_mitigation(void);
+static void __init rfds_update_mitigation(void);
+static void __init rfds_apply_mitigation(void);
 static void __init srbds_select_mitigation(void);
 static void __init l1d_flush_select_mitigation(void);
 static void __init srso_select_mitigation(void);
@@ -200,6 +203,7 @@ void __init cpu_select_mitigations(void)
 	mds_select_mitigation();
 	taa_select_mitigation();
 	mmio_select_mitigation();
+	rfds_select_mitigation();
 	md_clear_select_mitigation();
 	srbds_select_mitigation();
 	l1d_flush_select_mitigation();
@@ -218,10 +222,12 @@ void __init cpu_select_mitigations(void)
 	mds_update_mitigation();
 	taa_update_mitigation();
 	mmio_update_mitigation();
+	rfds_update_mitigation();
 
 	mds_apply_mitigation();
 	taa_apply_mitigation();
 	mmio_apply_mitigation();
+	rfds_apply_mitigation();
 }
 
 /*
@@ -624,22 +630,48 @@ static const char * const rfds_strings[] = {
 	[RFDS_MITIGATION_UCODE_NEEDED]		= "Vulnerable: No microcode",
 };
 
+static inline bool __init verw_clears_cpu_reg_file(void)
+{
+	return (x86_arch_cap_msr & ARCH_CAP_RFDS_CLEAR);
+}
+
 static void __init rfds_select_mitigation(void)
 {
 	if (!boot_cpu_has_bug(X86_BUG_RFDS) || cpu_mitigations_off()) {
 		rfds_mitigation = RFDS_MITIGATION_OFF;
 		return;
 	}
+
+	if (rfds_mitigation == RFDS_MITIGATION_AUTO)
+		rfds_mitigation = RFDS_MITIGATION_VERW;
+
 	if (rfds_mitigation == RFDS_MITIGATION_OFF)
 		return;
 
-	if (rfds_mitigation == RFDS_MITIGATION_AUTO)
+	if (verw_clears_cpu_reg_file())
+		verw_clear_cpu_buf_mitigation_selected = true;
+}
+
+static void __init rfds_update_mitigation(void)
+{
+	if (!boot_cpu_has_bug(X86_BUG_RFDS) || cpu_mitigations_off())
+		return;
+
+	if (verw_clear_cpu_buf_mitigation_selected)
 		rfds_mitigation = RFDS_MITIGATION_VERW;
 
-	if (x86_arch_cap_msr & ARCH_CAP_RFDS_CLEAR)
+	if (rfds_mitigation == RFDS_MITIGATION_VERW) {
+		if (!verw_clears_cpu_reg_file())
+			rfds_mitigation = RFDS_MITIGATION_UCODE_NEEDED;
+	}
+
+	pr_info("%s\n", rfds_strings[rfds_mitigation]);
+}
+
+static void __init rfds_apply_mitigation(void)
+{
+	if (rfds_mitigation == RFDS_MITIGATION_VERW)
 		setup_force_cpu_cap(X86_FEATURE_CLEAR_CPU_BUF);
-	else
-		rfds_mitigation = RFDS_MITIGATION_UCODE_NEEDED;
 }
 
 static __init int rfds_parse_cmdline(char *str)
@@ -712,7 +744,6 @@ out:
 
 static void __init md_clear_select_mitigation(void)
 {
-	rfds_select_mitigation();
 
 	/*
 	 * As these mitigations are inter-related and rely on VERW instruction

