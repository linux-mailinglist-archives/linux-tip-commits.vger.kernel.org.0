Return-Path: <linux-tip-commits+bounces-6089-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1933FB02162
	for <lists+linux-tip-commits@lfdr.de>; Fri, 11 Jul 2025 18:12:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DB59E1CC315D
	for <lists+linux-tip-commits@lfdr.de>; Fri, 11 Jul 2025 16:12:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E24E92F365C;
	Fri, 11 Jul 2025 16:09:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Ohwrtnea";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="9z71y5VR"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BDA92EF2B8;
	Fri, 11 Jul 2025 16:09:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752250185; cv=none; b=W9J2YdkduQHvGNB9IDrgHV9oLcRlWqhgWuQFupS6gqPUg7uMeSNrHNomHTxo0XD1UjYA8pJkCSXzYAEc5SZmqD5VOI4zE2fPutPM+R2qwM75VsE6DaG/L16s+gZQLP4FQs6GdxRai8AfIFiIKBPSSkBGSMpZprOvg24njZjv5cE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752250185; c=relaxed/simple;
	bh=XpTHGfpGT8WMGiL12dMYaeiMnNZyn3Ldd+B5+3xgGTc=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=Jn5q1ZVLFuqO2VXcLBJp64+qXcuR8d4pjV1MoZ9UHAGYeAj9dckLalQQURQ3/o9uBH0QvCfHvs49PXFwDiDVDis40RldZzErEwmDiyxdGuUOSfHUEgjcXiNLWEQuXbPgnx40iJ/U/A52MtqnYTli0px1UIEzoURnq7jwC63BmR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Ohwrtnea; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=9z71y5VR; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 11 Jul 2025 16:09:41 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1752250182;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+LRr2FDYpdlxEM8Avy++JinMHXom2cZgiisz0NMENDo=;
	b=Ohwrtnea46Bej4f8awN4zQ5cCZWX9KvX6dGq7higmsWpdLt4/a+MPVFhKl7e0rZvySXm/1
	QVPZU6tapvH+kXHk3ce2DMfkTX0LoBX2rqeVyPLmlAy3rLH2HmomvgB8DySxzcTX4OZGtD
	ZaG4Rz6MQWvOP6eiRNjTS4j0gsbILlpfkGZiCzngr0s5fxurf5dCzT99LH1hvCVwaQuAE7
	VHxnoIbd+Ewiaes1RRpFjByDL/D+uoJK5ocGGbHNNXoU+bwkfHfMWuyhBg4qTkzd0F9I2H
	X8stlNuj0lY9hL/Avj1DWW4+1PQtRBkAkjoTkA0o0MnULXcae+Uxf1661FSLQg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1752250182;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+LRr2FDYpdlxEM8Avy++JinMHXom2cZgiisz0NMENDo=;
	b=9z71y5VRN1OAZ0cdVkQm3igxdmpB1sT8Q9EZmOs0bd9SlnWsGxYQNWafEfn/1VPBp/QVB8
	+bhZj8YVJ1TEhnAg==
From: "tip-bot2 for David Kaplan" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/bugs] x86/bugs: Add attack vector controls for MMIO
Cc: David Kaplan <david.kaplan@amd.com>,
 "Borislav Petkov (AMD)" <bp@alien8.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250707183316.1349127-8-david.kaplan@amd.com>
References: <20250707183316.1349127-8-david.kaplan@amd.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175225018142.406.15627389474878237417.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/bugs branch of tip:

Commit-ID:     de6f0921ba49f5e07f57eb227dcb69ebb4776911
Gitweb:        https://git.kernel.org/tip/de6f0921ba49f5e07f57eb227dcb69ebb4776911
Author:        David Kaplan <david.kaplan@amd.com>
AuthorDate:    Mon, 07 Jul 2025 13:33:02 -05:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Fri, 11 Jul 2025 17:56:40 +02:00

x86/bugs: Add attack vector controls for MMIO

Use attack vectors controls to determine if MMIO mitigation is required.

Signed-off-by: David Kaplan <david.kaplan@amd.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://lore.kernel.org/20250707183316.1349127-8-david.kaplan@amd.com
---
 arch/x86/kernel/cpu/bugs.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index 438c482..39ff556 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -639,8 +639,12 @@ static void __init mmio_select_mitigation(void)
 	}
 
 	/* Microcode will be checked in mmio_update_mitigation(). */
-	if (mmio_mitigation == MMIO_MITIGATION_AUTO)
-		mmio_mitigation = MMIO_MITIGATION_VERW;
+	if (mmio_mitigation == MMIO_MITIGATION_AUTO) {
+		if (should_mitigate_vuln(X86_BUG_MMIO_STALE_DATA))
+			mmio_mitigation = MMIO_MITIGATION_VERW;
+		else
+			mmio_mitigation = MMIO_MITIGATION_OFF;
+	}
 
 	if (mmio_mitigation == MMIO_MITIGATION_OFF)
 		return;
@@ -655,7 +659,7 @@ static void __init mmio_select_mitigation(void)
 
 static void __init mmio_update_mitigation(void)
 {
-	if (!boot_cpu_has_bug(X86_BUG_MMIO_STALE_DATA) || cpu_mitigations_off())
+	if (!boot_cpu_has_bug(X86_BUG_MMIO_STALE_DATA))
 		return;
 
 	if (verw_clear_cpu_buf_mitigation_selected)
@@ -703,7 +707,7 @@ static void __init mmio_apply_mitigation(void)
 	if (!(x86_arch_cap_msr & ARCH_CAP_FBSDP_NO))
 		static_branch_enable(&cpu_buf_idle_clear);
 
-	if (mmio_nosmt || cpu_mitigations_auto_nosmt())
+	if (mmio_nosmt || smt_mitigations == SMT_MITIGATIONS_ON)
 		cpu_smt_disable(false);
 }
 

