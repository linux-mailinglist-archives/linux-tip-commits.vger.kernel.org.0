Return-Path: <linux-tip-commits+bounces-6079-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 31894B02148
	for <lists+linux-tip-commits@lfdr.de>; Fri, 11 Jul 2025 18:10:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DD70A1666E5
	for <lists+linux-tip-commits@lfdr.de>; Fri, 11 Jul 2025 16:10:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B77472EF9DC;
	Fri, 11 Jul 2025 16:09:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="NM1UReH2";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="7FtQw7TH"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B2362EF293;
	Fri, 11 Jul 2025 16:09:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752250176; cv=none; b=KfpJB80coBbaoYsK+b8/1OPjG2nm9tyNRVcoxmK/nLYpySNiQFKF8JlW3MOAUXHL+Eo7S+ZBvbZqsVYXcpdvIp3a5xOWy3I+BMYqjGRsJeI6/BW08mQtx1ZZnkQ+JFH77B8zcvC/Zx3GWYaA7zJNybgTW0/l45Y+COA5TsQ6zPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752250176; c=relaxed/simple;
	bh=X86Ze2Zydlnob7CJkpjWbCWIBR91vYZQp5uIwQyNg3I=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=V4zCbkzOfOdbQH3zGM2noDGuleIvaiDTyGI8AvgVPSVCU/dtR0TzDLyHkva03fRQ4qxHPbVAcv4KN4shjzoWwlOZQqU3K/bl6rjbfe/JZKbMwei7JaW0hHnn5aWzyoDHnjXCiX/W7tiCxS+V/7mtVYZxDOOp2Bc+J9cXQIIWwQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=NM1UReH2; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=7FtQw7TH; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 11 Jul 2025 16:09:32 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1752250173;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZBuqCveR3kvP1lxHGPDQnykARz39toEo9xz8YvhW1c4=;
	b=NM1UReH2W5JGfulWg6r7WCKRBpVwUi/gxFmSIBkG7e35hX7Z3GWKRgkEtlXzaFKuHD+WT7
	LGHf8EvMwpIm8hdRZu62DuNBq74gnFfgfrWYURvCD0NLXsZ048QHRZJj2venFnqSopV971
	teUGLge5eXzfSVV/JOkxVEnvSGC8qNKiqZL+6GjrqhMIjndLJvNJzl42ccAmfgXUW4UQCP
	IsueRIaQhGNWH1zQdnl2p4QHHwqGO6adxxJTwUc4ppsbwveigGeI0vVy6WrByGcXOrkyiu
	zDTeUtnx7P/PXclSqrRcL7BeSNuyv/6RBPLlb/xTY4CQ3jxZnEspLfCswu9GPQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1752250173;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZBuqCveR3kvP1lxHGPDQnykARz39toEo9xz8YvhW1c4=;
	b=7FtQw7THct8CFOllb8pT5uF/yMaOPrxDMCBL+fjnXlITNwORK9FcZIZ1DsXG28euyK+Zr5
	0+VIbjO+o2yXyaAg==
From: "tip-bot2 for David Kaplan" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/bugs] x86/bugs: Add attack vector controls for SRSO
Cc: David Kaplan <david.kaplan@amd.com>,
 "Borislav Petkov (AMD)" <bp@alien8.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250707183316.1349127-18-david.kaplan@amd.com>
References: <20250707183316.1349127-18-david.kaplan@amd.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175225017205.406.15490827974113086965.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/bugs branch of tip:

Commit-ID:     eda718fde6159b2e64978637ebb3f1ae98180555
Gitweb:        https://git.kernel.org/tip/eda718fde6159b2e64978637ebb3f1ae98180555
Author:        David Kaplan <david.kaplan@amd.com>
AuthorDate:    Mon, 07 Jul 2025 13:33:12 -05:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Fri, 11 Jul 2025 17:56:41 +02:00

x86/bugs: Add attack vector controls for SRSO

Use attack vector controls to determine if SRSO mitigation is required.

Signed-off-by: David Kaplan <david.kaplan@amd.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://lore.kernel.org/20250707183316.1349127-18-david.kaplan@amd.com
---
 arch/x86/kernel/cpu/bugs.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index 2128623..eef6ccd 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -3123,14 +3123,19 @@ early_param("spec_rstack_overflow", srso_parse_cmdline);
 
 static void __init srso_select_mitigation(void)
 {
-	if (!boot_cpu_has_bug(X86_BUG_SRSO) || cpu_mitigations_off())
+	if (!boot_cpu_has_bug(X86_BUG_SRSO)) {
 		srso_mitigation = SRSO_MITIGATION_NONE;
-
-	if (srso_mitigation == SRSO_MITIGATION_NONE)
 		return;
+	}
 
-	if (srso_mitigation == SRSO_MITIGATION_AUTO)
-		srso_mitigation = SRSO_MITIGATION_SAFE_RET;
+	if (srso_mitigation == SRSO_MITIGATION_AUTO) {
+		if (should_mitigate_vuln(X86_BUG_SRSO)) {
+			srso_mitigation = SRSO_MITIGATION_SAFE_RET;
+		} else {
+			srso_mitigation = SRSO_MITIGATION_NONE;
+			return;
+		}
+	}
 
 	/* Zen1/2 with SMT off aren't vulnerable to SRSO. */
 	if (boot_cpu_data.x86 < 0x19 && !cpu_smt_possible()) {

