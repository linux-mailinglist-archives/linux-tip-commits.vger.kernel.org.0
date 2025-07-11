Return-Path: <linux-tip-commits+bounces-6088-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE5F1B0215D
	for <lists+linux-tip-commits@lfdr.de>; Fri, 11 Jul 2025 18:12:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DE31C5C542A
	for <lists+linux-tip-commits@lfdr.de>; Fri, 11 Jul 2025 16:11:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40BF92F3631;
	Fri, 11 Jul 2025 16:09:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="BRrzc128";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="c4hosc3e"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D35B2F2705;
	Fri, 11 Jul 2025 16:09:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752250185; cv=none; b=RBD3GS7FcoEAmkcRGrU7lGHuHmQMHjUYb4E2kBhi3N9XwxYOP9hOfrh1QE2glEyFUXo9uAtslJ9dIk10MgMcWZnxa1bQHfVkNA1CJMF6RbmAi2UOvOpa4s03nevCfCvLpU3YlJhEKyzS5kdy4ep7lGDCz7/K+OildwmUapG5ymQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752250185; c=relaxed/simple;
	bh=5EVOyPcMJghLxfM0tmx9/nX13nyQLy8ZXarU6FPVJgY=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=aJW1+3ZecT2U/bsRJcvlf7utIMRpLoJnPMYIaslWf4QUYJ8w+DFMthtGoozp077xsNxQZMPD/QPUcWb/KDK4ydHbOj59CEBxhNp/8t2mjajWI1CDTHE8mwLA2TTWY4fkNxN8IChIk43aXV86DPYnTRU+AG0aG9V/DuJRN5T2mYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=BRrzc128; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=c4hosc3e; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 11 Jul 2025 16:09:39 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1752250180;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CvCjtpyec8WJbIo8Zb2QSvzP9PXTRhL6B6DrC0UJKf8=;
	b=BRrzc128gxezoXKm+Io6KORT2/L25Hi/cWkc83ppmQoDXko1hfliW4g/dUz9oxtgEHBmM9
	WTVlYZGQGJuXn/wJLq47/rwwNBCTeo019Hcr7hdICI0NP13/IfVE0xpd1EFnbmxeFveF3P
	JnsKk7QHjv3rKEvZgAdnOiZU9HEcyOt7obfqpEkEMIXKZ7oST5kmqAV4DRCXPIQVs9vhok
	A8hlKxkYrGJLIi24vOQol+ptq4wMVbcdjScA+mns1W85QHr2q0E1ArRMqqS+TrUTJEVpmO
	AFSXp4YcsZnyprISfPg7DaSHPOKhBbdiZf2wm00hP60b6V9FV3gOwLPD88BbNg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1752250180;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CvCjtpyec8WJbIo8Zb2QSvzP9PXTRhL6B6DrC0UJKf8=;
	b=c4hosc3e60rCJ7MV06er0D9AMAyWscIflykt9w/WYJgkfgzx5byJpvVC9IU1GCAwUJ485/
	zYzCEL08nWhwozBQ==
From: "tip-bot2 for David Kaplan" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/bugs] x86/bugs: Add attack vector controls for SRBDS
Cc: David Kaplan <david.kaplan@amd.com>,
 "Borislav Petkov (AMD)" <bp@alien8.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250707183316.1349127-10-david.kaplan@amd.com>
References: <20250707183316.1349127-10-david.kaplan@amd.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175225017975.406.615568639215898100.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/bugs branch of tip:

Commit-ID:     71dc301c26e9503350cf4e736022cc1eb8e986a7
Gitweb:        https://git.kernel.org/tip/71dc301c26e9503350cf4e736022cc1eb8e986a7
Author:        David Kaplan <david.kaplan@amd.com>
AuthorDate:    Mon, 07 Jul 2025 13:33:04 -05:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Fri, 11 Jul 2025 17:56:40 +02:00

x86/bugs: Add attack vector controls for SRBDS

Use attack vector controls to determine if SRBDS mitigation is required.

Signed-off-by: David Kaplan <david.kaplan@amd.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://lore.kernel.org/20250707183316.1349127-10-david.kaplan@amd.com
---
 arch/x86/kernel/cpu/bugs.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index a557d17..de0b5ef 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -870,13 +870,19 @@ void update_srbds_msr(void)
 
 static void __init srbds_select_mitigation(void)
 {
-	if (!boot_cpu_has_bug(X86_BUG_SRBDS) || cpu_mitigations_off()) {
+	if (!boot_cpu_has_bug(X86_BUG_SRBDS)) {
 		srbds_mitigation = SRBDS_MITIGATION_OFF;
 		return;
 	}
 
-	if (srbds_mitigation == SRBDS_MITIGATION_AUTO)
-		srbds_mitigation = SRBDS_MITIGATION_FULL;
+	if (srbds_mitigation == SRBDS_MITIGATION_AUTO) {
+		if (should_mitigate_vuln(X86_BUG_SRBDS))
+			srbds_mitigation = SRBDS_MITIGATION_FULL;
+		else {
+			srbds_mitigation = SRBDS_MITIGATION_OFF;
+			return;
+		}
+	}
 
 	/*
 	 * Check to see if this is one of the MDS_NO systems supporting TSX that

