Return-Path: <linux-tip-commits+bounces-6085-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 20A59B0215A
	for <lists+linux-tip-commits@lfdr.de>; Fri, 11 Jul 2025 18:11:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 95EC41CC25F7
	for <lists+linux-tip-commits@lfdr.de>; Fri, 11 Jul 2025 16:11:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15AB72F2722;
	Fri, 11 Jul 2025 16:09:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="I+jzMT+C";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="q+gc+S0A"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 622B62F1987;
	Fri, 11 Jul 2025 16:09:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752250182; cv=none; b=Tzh3S9W7AfprHB+EM3F2rmgixKu9AxMqZcXlwShfSKF6ABNO53nCjrE6XHNxKYAgkr6MIvKB2iN0ftatAi+sJqN7hrAAfWCAHA65zh1gjEbM35ae6Kc17bZ1c+rmo0DmSKIqpyXyU/JBWgpu2SEL4ZDufpNyU/FaDDYFKxY+GRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752250182; c=relaxed/simple;
	bh=yDiexXRRuVvWqJXUHa24kzNFS9IPQR7WlTwQrzSXlrQ=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=PJ91TYwv9AVIANxcII9xx9fjHi4Be3j7Uu+FnK8ObYBOsYU8FItF4JiqwMlER0A61BSt/HIRuslczdao4uKmUgf7p8h4HgzLPLEhi2pa72nqAC8UJ2tEmAcTJXLDQ06vhWu1So3Ubv+4rWM5LqLVbaq7WHTtcpJvfwyUV61k2XA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=I+jzMT+C; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=q+gc+S0A; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 11 Jul 2025 16:09:38 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1752250179;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0AyvecCVP5YEu1FPgPAt801o52vUQMBbiiGtnFZLgSk=;
	b=I+jzMT+Cx8774HuiSWIuR24xLlYTrqK/63nZLTfkJ8OCCuC7Q3Yjdwfx+nMjFcjb1nArkj
	u67uacm8AvL9xYhmrkqti+6Mz0D0PZP0bD+Br3WHF8whe6F8rMlMPwmCSIee3TYBKK+TRa
	PcPew8qp3PXOmDLkBhq+BQFOJd3LrblWx+5IOhXW1aFPdjamTgq/t2836D21EMMsOi4R10
	fDcb7VXrCwIYoKQrSIdxIx5ZLkuyjYI00F4BGvPe4J1awcYcxiGxtPHNdr3T2LOGsuNOaP
	pkHdAT20gCA+i53VuYneCAD+D17pOl4o08bv+QxauosaWPUbmRL4XCy/X6npAQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1752250179;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0AyvecCVP5YEu1FPgPAt801o52vUQMBbiiGtnFZLgSk=;
	b=q+gc+S0AwZzgXCG7IcdUokPCXNLJhUvCILrTbQVSDb1TPXUPG/1g/WuTSUkV0v8ijZqpO5
	Zku3Oy4X0hQXVNDA==
From: "tip-bot2 for David Kaplan" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/bugs] x86/bugs: Add attack vector controls for spectre_v1
Cc: David Kaplan <david.kaplan@amd.com>,
 "Borislav Petkov (AMD)" <bp@alien8.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250707183316.1349127-12-david.kaplan@amd.com>
References: <20250707183316.1349127-12-david.kaplan@amd.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175225017802.406.592835816716767961.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/bugs branch of tip:

Commit-ID:     19a5f3ea4394bf813a03d1ff0efe59a7f74cc12c
Gitweb:        https://git.kernel.org/tip/19a5f3ea4394bf813a03d1ff0efe59a7f74cc12c
Author:        David Kaplan <david.kaplan@amd.com>
AuthorDate:    Mon, 07 Jul 2025 13:33:06 -05:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Fri, 11 Jul 2025 17:56:41 +02:00

x86/bugs: Add attack vector controls for spectre_v1

Use attack vector controls to determine if spectre_v1 mitigation is
required.

Signed-off-by: David Kaplan <david.kaplan@amd.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://lore.kernel.org/20250707183316.1349127-12-david.kaplan@amd.com
---
 arch/x86/kernel/cpu/bugs.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index e9227e4..130db82 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -1144,13 +1144,16 @@ static bool smap_works_speculatively(void)
 
 static void __init spectre_v1_select_mitigation(void)
 {
-	if (!boot_cpu_has_bug(X86_BUG_SPECTRE_V1) || cpu_mitigations_off())
+	if (!boot_cpu_has_bug(X86_BUG_SPECTRE_V1))
+		spectre_v1_mitigation = SPECTRE_V1_MITIGATION_NONE;
+
+	if (!should_mitigate_vuln(X86_BUG_SPECTRE_V1))
 		spectre_v1_mitigation = SPECTRE_V1_MITIGATION_NONE;
 }
 
 static void __init spectre_v1_apply_mitigation(void)
 {
-	if (!boot_cpu_has_bug(X86_BUG_SPECTRE_V1) || cpu_mitigations_off())
+	if (!boot_cpu_has_bug(X86_BUG_SPECTRE_V1))
 		return;
 
 	if (spectre_v1_mitigation == SPECTRE_V1_MITIGATION_AUTO) {

