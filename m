Return-Path: <linux-tip-commits+bounces-5885-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D1513AE61E9
	for <lists+linux-tip-commits@lfdr.de>; Tue, 24 Jun 2025 12:15:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5E38516BABA
	for <lists+linux-tip-commits@lfdr.de>; Tue, 24 Jun 2025 10:15:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF5FB281366;
	Tue, 24 Jun 2025 10:15:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="lIYaXr1M";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="I1oUC0aw"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FA5D221578;
	Tue, 24 Jun 2025 10:15:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750760139; cv=none; b=i0ZOObgzirqdfBo9XWoidsaml9Hs6dznPfEM7VTiX0t72Q51VIgYxBMGH4Z5yMcXvsSzwwzMgyxTRfHlwzfYJS6mcFbdssGZ1F4Co0l9oiVj7vDVf2aEzH1Ienf0M3zjnyEADMuCjzeX5EPOYGmgyW7H4dxnQwfUdWdD5NdgYTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750760139; c=relaxed/simple;
	bh=UYdj9GvZ4o73rFcCybTpsDQ4/t9LzvI/mDXnYBPjnrA=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=abziV+uElM3xLxmG+1KhW70gkq8mTIhO7qmhkFwT1G+EIoH2/evegg5nWF1yQgE8qplG3NHiHB+uzHi5BqQYu6UQmFX3OM6ejiBTw3D/+idroLVD/k34ckwPMMbHSJxUPzSZHxcSMzvahKZ7XNpcba3DngjBj49MHsMgGJneZ7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=lIYaXr1M; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=I1oUC0aw; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 24 Jun 2025 10:05:50 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1750760136;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3fNcd+vX6ujxcX4LPO7q/jd+Ihe7DIb0hc7fOgbnZWs=;
	b=lIYaXr1MMtcF/R5BpQk1BC6JVw/KJ9At/QI0tMohFMNTrv55l8PGAobMQ/CnH0N4TfXaIN
	xz/YAxxOoXZ5Xw0Lz1ffQpIuxNY0nc1FrM3CtyGiV695Y13WBDw4cg05GjbuoUCVRYeP/6
	IadSSegSffJg33jHNvkio7Zzka+LMGE0Mo87i1Xi6Y4pLQ1pPR+4Qim6f8X03EY8qgGB35
	2mtf5m+zJnEgdZcE8LEdSrJ0/U5QubQSSXSfftUfPRsM0q+CTWKhlIR/ELx7baANEv5lM/
	Rl7pgQtbl6qEnZdAwDFEUq/0On9HCmnHp/VIVlu0XvBsD1sL0pd5dFdiXofONA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1750760136;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3fNcd+vX6ujxcX4LPO7q/jd+Ihe7DIb0hc7fOgbnZWs=;
	b=I1oUC0awewzgWEXPRAfNH5ItFt/o5QqcrOXjNrxa5NrtmbTgseQt7NiPHx6+E3ncGTITYW
	CpY4xBxMSTe/UjBA==
From: "tip-bot2 for Pawan Gupta" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/bugs] x86/bugs: Avoid AUTO after the select step in the
 retbleed mitigation
Cc: Borislav Petkov <bp@alien8.de>,
 Pawan Gupta <pawan.kumar.gupta@linux.intel.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250611-eibrs-fix-v4-1-5ff86cac6c61@linux.intel.com>
References: <20250611-eibrs-fix-v4-1-5ff86cac6c61@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175075955023.406.17412527665448494816.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/bugs branch of tip:

Commit-ID:     98ff5c071d1cde9426b0bfa449c43d49ec58f1c4
Gitweb:        https://git.kernel.org/tip/98ff5c071d1cde9426b0bfa449c43d49ec58f1c4
Author:        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
AuthorDate:    Wed, 11 Jun 2025 10:29:00 -07:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Mon, 23 Jun 2025 12:16:23 +02:00

x86/bugs: Avoid AUTO after the select step in the retbleed mitigation

The retbleed select function leaves the mitigation to AUTO in some cases.
Moreover, the update function can also set the mitigation to AUTO. This
is inconsistent with other mitigations and requires explicit handling of
AUTO at the end of update step.

Make sure a mitigation gets selected in the select step, and do not change
it to AUTO in the update step. When no mitigation can be selected leave it
to NONE, which is what AUTO was getting changed to in the end.

Suggested-by: Borislav Petkov <bp@alien8.de>
Signed-off-by: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Acked-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://lore.kernel.org/20250611-eibrs-fix-v4-1-5ff86cac6c61@linux.intel.com
---
 arch/x86/kernel/cpu/bugs.c | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index 7f94e6a..53649df 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -1247,6 +1247,14 @@ static void __init retbleed_select_mitigation(void)
 			retbleed_mitigation = RETBLEED_MITIGATION_IBPB;
 		else
 			retbleed_mitigation = RETBLEED_MITIGATION_NONE;
+	} else if (boot_cpu_data.x86_vendor == X86_VENDOR_INTEL) {
+		/* Final mitigation depends on spectre-v2 selection */
+		if (boot_cpu_has(X86_FEATURE_IBRS_ENHANCED))
+			retbleed_mitigation = RETBLEED_MITIGATION_EIBRS;
+		else if (boot_cpu_has(X86_FEATURE_IBRS))
+			retbleed_mitigation = RETBLEED_MITIGATION_IBRS;
+		else
+			retbleed_mitigation = RETBLEED_MITIGATION_NONE;
 	}
 }
 
@@ -1255,9 +1263,6 @@ static void __init retbleed_update_mitigation(void)
 	if (!boot_cpu_has_bug(X86_BUG_RETBLEED) || cpu_mitigations_off())
 		return;
 
-	if (retbleed_mitigation == RETBLEED_MITIGATION_NONE)
-		goto out;
-
 	/*
 	 * retbleed=stuff is only allowed on Intel.  If stuffing can't be used
 	 * then a different mitigation will be selected below.
@@ -1268,7 +1273,7 @@ static void __init retbleed_update_mitigation(void)
 	    its_mitigation == ITS_MITIGATION_RETPOLINE_STUFF) {
 		if (spectre_v2_enabled != SPECTRE_V2_RETPOLINE) {
 			pr_err("WARNING: retbleed=stuff depends on spectre_v2=retpoline\n");
-			retbleed_mitigation = RETBLEED_MITIGATION_AUTO;
+			retbleed_mitigation = RETBLEED_MITIGATION_NONE;
 		} else {
 			if (retbleed_mitigation != RETBLEED_MITIGATION_STUFF)
 				pr_info("Retbleed mitigation updated to stuffing\n");
@@ -1294,15 +1299,11 @@ static void __init retbleed_update_mitigation(void)
 			if (retbleed_mitigation != RETBLEED_MITIGATION_STUFF)
 				pr_err(RETBLEED_INTEL_MSG);
 		}
-		/* If nothing has set the mitigation yet, default to NONE. */
-		if (retbleed_mitigation == RETBLEED_MITIGATION_AUTO)
-			retbleed_mitigation = RETBLEED_MITIGATION_NONE;
 	}
-out:
+
 	pr_info("%s\n", retbleed_strings[retbleed_mitigation]);
 }
 
-
 static void __init retbleed_apply_mitigation(void)
 {
 	bool mitigate_smt = false;

