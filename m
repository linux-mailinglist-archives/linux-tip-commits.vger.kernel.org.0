Return-Path: <linux-tip-commits+bounces-6076-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A5F4BB02144
	for <lists+linux-tip-commits@lfdr.de>; Fri, 11 Jul 2025 18:09:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 49E7DA6354B
	for <lists+linux-tip-commits@lfdr.de>; Fri, 11 Jul 2025 16:09:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E5D42EF29B;
	Fri, 11 Jul 2025 16:09:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="pSkPeuJ0";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="xWU9L0Sh"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C793E2ED862;
	Fri, 11 Jul 2025 16:09:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752250173; cv=none; b=asAYZVrMJfICC0XJTElyGpMJlKewIgdHMRfglkSFpiWScoSWuxvMYICbSu3TyE1aPq8M2vFG5ugEOr7R9keoY/uN2PN/QkGbEeWwhPjNDrPAu4XCIFpam+ejoSN6EpaDiOYVN/A6x3Ri3ytZ1ISTgIAl4xp+X+GZmDMKVn8wHEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752250173; c=relaxed/simple;
	bh=mtQALymuuhqIY9LzGDYTGEU1sxv8D+zDXyDF+41zu04=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=jZ05P6dmvsuj45B1kpm/Y5KmJXOXxyPBopddu854dmtvp434fajB30YLaoo95RCYJhDFq+1CvNuKTMHWP2koeNbYzkikHkFnCY2d1M2fy9Af6mAUF6sdK8sI+RzYr2lJGz4c5VQ2YwPLgBvECBE6pz06NEcNMLSd5HzuMvfsgQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=pSkPeuJ0; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=xWU9L0Sh; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 11 Jul 2025 16:09:29 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1752250170;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Dk/ACniDj+UBCFv5c4bG9rfez4J4o9r5BC512bsRvTQ=;
	b=pSkPeuJ0okyBHM+NAsChXA36571jJXnZF7EpNajvQTzXk4MeEUZBXS7kP4HBkENGFRwCY9
	7/+2F7WprlyZBoAHCjAfyNL++yGF8sgFpRT1jh/s2O/31oHLD4E8lzqQMEX3GJ+CNDIdDc
	8ITxgGe1aIWjrMfsachQrJg+r/Vv1ltBPQmFSckEd9iZmw+tzH3yve8EEnsNIjBeDqE0EU
	qiz1GDJWeOK+p12kmjzjFgk+En+cKORQPMw7GxYRnF/im7mDra4O8CFcPEtTKIrHXOZWmS
	ikkdpvSFPcUZfen5LaQewSI/vbmQXkm9k9kzI63KZDJm7ztW7z9+pEHqH4noWg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1752250170;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Dk/ACniDj+UBCFv5c4bG9rfez4J4o9r5BC512bsRvTQ=;
	b=xWU9L0ShNuWpvRIQUWgZN+Ha4QqpoxxY1nd6puKw9Ba/B5aeOmJaFPCEPicHv0zsrN9yMm
	dyiOnXjNLgpW4eCw==
From: "tip-bot2 for David Kaplan" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/bugs] x86/bugs: Add attack vector controls for TSA
Cc: David Kaplan <david.kaplan@amd.com>,
 "Borislav Petkov (AMD)" <bp@alien8.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250709155844.3279471-1-david.kaplan@amd.com>
References: <20250709155844.3279471-1-david.kaplan@amd.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175225016911.406.2277651739982822266.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/bugs branch of tip:

Commit-ID:     6b21d2f0dc73699e468c877515472c52a5837f8f
Gitweb:        https://git.kernel.org/tip/6b21d2f0dc73699e468c877515472c52a5837f8f
Author:        David Kaplan <david.kaplan@amd.com>
AuthorDate:    Wed, 09 Jul 2025 10:58:44 -05:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Fri, 11 Jul 2025 17:56:41 +02:00

x86/bugs: Add attack vector controls for TSA

Use attack vector controls to determine which TSA mitigation to use.

  [ bp: Simplify the condition in the select function for better
    readability. ]

Signed-off-by: David Kaplan <david.kaplan@amd.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://lore.kernel.org/20250709155844.3279471-1-david.kaplan@amd.com
---
 arch/x86/kernel/cpu/bugs.c | 31 +++++++++++++++++++++++--------
 1 file changed, 23 insertions(+), 8 deletions(-)

diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index f41d871..b9d0509 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -1657,28 +1657,43 @@ early_param("tsa", tsa_parse_cmdline);
 
 static void __init tsa_select_mitigation(void)
 {
-	if (cpu_mitigations_off() || !boot_cpu_has_bug(X86_BUG_TSA)) {
+	if (!boot_cpu_has_bug(X86_BUG_TSA)) {
 		tsa_mitigation = TSA_MITIGATION_NONE;
 		return;
 	}
 
+	if (tsa_mitigation == TSA_MITIGATION_AUTO) {
+		bool vm = false, uk = false;
+
+		tsa_mitigation = TSA_MITIGATION_NONE;
+
+		if (cpu_attack_vector_mitigated(CPU_MITIGATE_USER_KERNEL) ||
+		    cpu_attack_vector_mitigated(CPU_MITIGATE_USER_USER)) {
+			tsa_mitigation = TSA_MITIGATION_USER_KERNEL;
+			uk = true;
+		}
+
+		if (cpu_attack_vector_mitigated(CPU_MITIGATE_GUEST_HOST) ||
+		    cpu_attack_vector_mitigated(CPU_MITIGATE_GUEST_GUEST)) {
+			tsa_mitigation = TSA_MITIGATION_VM;
+			vm = true;
+		}
+
+		if (uk && vm)
+			tsa_mitigation = TSA_MITIGATION_FULL;
+	}
+
 	if (tsa_mitigation == TSA_MITIGATION_NONE)
 		return;
 
-	if (!boot_cpu_has(X86_FEATURE_VERW_CLEAR)) {
+	if (!boot_cpu_has(X86_FEATURE_VERW_CLEAR))
 		tsa_mitigation = TSA_MITIGATION_UCODE_NEEDED;
-		goto out;
-	}
-
-	if (tsa_mitigation == TSA_MITIGATION_AUTO)
-		tsa_mitigation = TSA_MITIGATION_FULL;
 
 	/*
 	 * No need to set verw_clear_cpu_buf_mitigation_selected - it
 	 * doesn't fit all cases here and it is not needed because this
 	 * is the only VERW-based mitigation on AMD.
 	 */
-out:
 	pr_info("%s\n", tsa_strings[tsa_mitigation]);
 }
 

