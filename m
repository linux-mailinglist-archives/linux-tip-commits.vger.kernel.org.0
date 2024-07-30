Return-Path: <linux-tip-commits+bounces-1860-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A55BE941423
	for <lists+linux-tip-commits@lfdr.de>; Tue, 30 Jul 2024 16:16:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6014B285224
	for <lists+linux-tip-commits@lfdr.de>; Tue, 30 Jul 2024 14:16:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1E781A2C37;
	Tue, 30 Jul 2024 14:15:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="zYx2jNiK";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="uvS56mNu"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E45C11A2C3C;
	Tue, 30 Jul 2024 14:15:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722348919; cv=none; b=GnHmuuda7dA75J4Im+pCR3d7oeb06AxHVODkDusrlHjJPg30wSXxrRWsdmJXpKdd82iCQv6DngHYpgrYURzw+2lmqnxDd+s6y+6m+5UO96deWTv9cY1zq2ISBmJpouzGWRxMu3xs6cL0r5PG+RNd1tPh2CTfiUi89PhTrfREm+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722348919; c=relaxed/simple;
	bh=8tIRizM4Xbt2bUf/fS+z2XNK2a4c6RRqO8DKOkGObx0=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=EH00ISqpxFZhYf6MgBV997mS5Zoh4WMDuMzB7PSkNKnr6e6vSBimR64Zb94T1i8/26ojvak2fUCjLoccLIPULBti30bNoYxVO7AEVQualCe+mqKUSunFaQ1Guosgd7A301nNdjuuV3k1hvElVvvWzVRvkOULZgAIGVkDNoKHxFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=zYx2jNiK; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=uvS56mNu; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 30 Jul 2024 14:15:14 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1722348915;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=x+bFXow4F2+5gGrd9BCEjhx1evB6TQrq3yDuhljSBHc=;
	b=zYx2jNiKs2D/2xreZZeOWfFelMvfZIR7f5PB4WNBMiNCJw8zS4EKY8aiyqtCO9NK7ylE9Z
	5bp9ays6mWy71u7MhktfHkVin4uTTQKYj7QZ5/+fFPik/T9QGmN4hhu1u5SAl4GAHHTuBq
	vlMdLdcoi8tWoup/KBXchVJAxg2TIpHkLtlQbCz5IY/+vYP79olKr00vTIfrvZfTjsDef7
	JYmv4CqocLBOz9zNfSLteIGraweoEDfAxmiJWsD+45INPO/nQaT+QGEVDMy2eLQGURDFJn
	ThPXleZjs8nJamuvWPpvJn5fuZGPDxWJNgDlMaoBZjYHiTFtoBc5qZlf6ejoyA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1722348915;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=x+bFXow4F2+5gGrd9BCEjhx1evB6TQrq3yDuhljSBHc=;
	b=uvS56mNu4A4/ipXsyZTpk/BlP4tnR7WS5ioxegi2tQq5tLMXQ6xlmGBDMl2h0Hc9MN6p/f
	1DMI6qk+WJysDIDg==
From: "tip-bot2 for Breno Leitao" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/bugs] x86/bugs: Add a separate config for MDS
Cc: Breno Leitao <leitao@debian.org>, "Borislav Petkov (AMD)" <bp@alien8.de>,
 Josh Poimboeuf <jpoimboe@kernel.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240729164105.554296-2-leitao@debian.org>
References: <20240729164105.554296-2-leitao@debian.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172234891482.2215.11832191435134470420.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/bugs branch of tip:

Commit-ID:     940455681d94a4100f024097737e502e93273f26
Gitweb:        https://git.kernel.org/tip/940455681d94a4100f024097737e502e93273f26
Author:        Breno Leitao <leitao@debian.org>
AuthorDate:    Mon, 29 Jul 2024 09:40:49 -07:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Tue, 30 Jul 2024 10:17:36 +02:00

x86/bugs: Add a separate config for MDS

Currently, the CONFIG_SPECULATION_MITIGATIONS is halfway populated,
where some mitigations have entries in Kconfig, and they could be
modified, while others mitigations do not have Kconfig entries, and
could not be controlled at build time.

Create an entry for the MDS CPU mitigation under
CONFIG_SPECULATION_MITIGATIONS. This allow users to enable or disable
it at compilation time.

Signed-off-by: Breno Leitao <leitao@debian.org>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Acked-by: Josh Poimboeuf <jpoimboe@kernel.org>
Link: https://lore.kernel.org/r/20240729164105.554296-2-leitao@debian.org
---
 arch/x86/Kconfig           |  9 +++++++++
 arch/x86/kernel/cpu/bugs.c |  3 ++-
 2 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 007bab9..36e871a 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -2650,6 +2650,15 @@ config MITIGATION_SPECTRE_BHI
 	  indirect branches.
 	  See <file:Documentation/admin-guide/hw-vuln/spectre.rst>
 
+config MITIGATION_MDS
+	bool "Mitigate Microarchitectural Data Sampling (MDS) hardware bug"
+	depends on CPU_SUP_INTEL
+	default y
+	help
+	  Enable mitigation for Microarchitectural Data Sampling (MDS). MDS is
+	  a hardware vulnerability which allows unprivileged speculative access
+	  to data which is available in various CPU internal buffers.
+	  See also <file:Documentation/admin-guide/hw-vuln/mds.rst>
 endif
 
 config ARCH_HAS_ADD_PAGES
diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index 45675da..dbfc7d5 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -233,7 +233,8 @@ static void x86_amd_ssb_disable(void)
 #define pr_fmt(fmt)	"MDS: " fmt
 
 /* Default mitigation for MDS-affected CPUs */
-static enum mds_mitigations mds_mitigation __ro_after_init = MDS_MITIGATION_FULL;
+static enum mds_mitigations mds_mitigation __ro_after_init =
+	IS_ENABLED(CONFIG_MITIGATION_MDS) ? MDS_MITIGATION_FULL : MDS_MITIGATION_OFF;
 static bool mds_nosmt __ro_after_init = false;
 
 static const char * const mds_strings[] = {

