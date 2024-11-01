Return-Path: <linux-tip-commits+bounces-2684-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A50B09B9067
	for <lists+linux-tip-commits@lfdr.de>; Fri,  1 Nov 2024 12:41:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 990B7B21B13
	for <lists+linux-tip-commits@lfdr.de>; Fri,  1 Nov 2024 11:41:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9660319C554;
	Fri,  1 Nov 2024 11:41:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="NOQVjbv/";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="meZARsjc"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C6E4199238;
	Fri,  1 Nov 2024 11:41:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730461269; cv=none; b=q9WRfG64O2+dqRn1HExnE0/fK9tM4IQ4ay8FMDMUcnmbGJEbYCIKq/TfDW0speq8nIIXaEESoIl+OgJ6/d6Qs+F1Pk69vsJqxPDttLQeT6YE6mMeZ/ymuPYNfcJt50kgLwibeyxQ6GQjkrwYexgzJgHD9md56MsZVYFwWZbwj5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730461269; c=relaxed/simple;
	bh=x6tXHYwBIRDtTShCUUpTozgrhBMUkIiATBzmFyvMlgc=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=rsVeIeDcEb8tB4NMaGSOPFUWwxTZvvsqc1Yr89KfcvKHNe6KbWkLM6VR/Ulct1TL+ylPn1Vn6cd1c26fO43/pVJBT83a4WIM4m/sZENqhDOsHe2oZyoYqdv2hurrgAKoNJyTC9LYzjsB5OWmFcH4WhesHSV7IoIZIO06Lsoqk7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=NOQVjbv/; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=meZARsjc; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 01 Nov 2024 11:41:03 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1730461265;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=78vLclkfvDOMwI65pDOwbUMQGRF3HI1YhCLyxF4rIyI=;
	b=NOQVjbv/UUIhwxTg+IoX0Vy8I7ZX2Oh6TLu8hYcrd9ldTAVJlR6UjFvXR73Q7cYPP2ebfq
	ZmfhftKluVfCUWcCpvLKBE5By8xVN7ywtS0540iSXbnDf50ssqEzYSwKwjTOeci4A54Qns
	YMJ2agT5FZf7PJQcxSJWCTc0O9QN7bOEIf1W61HuKocp1FeEby2YKju6GRRw1fEGxiizC7
	PRTb+h5LhUcnysEbr4CC2MD5i0ounolSvsF+XV6+SIRSVPi0LBDDR6dMjL/P4jZROBMxlr
	+noBXU0gUrLXgy+Wm9jIV9E2a6YhaqoFW905/lgq03qntYNaEiFgDWnfzgmvyA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1730461265;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=78vLclkfvDOMwI65pDOwbUMQGRF3HI1YhCLyxF4rIyI=;
	b=meZARsjcMRkt3qLAf9XTCGHspO8gD3+0wyDJDJxVgHnL3EPqJcErBtDRZXCMLOQ77bcGI2
	CyVACaD4xxc4G5BA==
From: "tip-bot2 for Yazen Ghannam" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: ras/core] EDAC/mce_amd: Add support for FRU text in MCA
Cc: Yazen Ghannam <yazen.ghannam@amd.com>, Avadhut Naik <avadhut.naik@amd.com>,
 "Borislav Petkov (AMD)" <bp@alien8.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20241022194158.110073-6-avadhut.naik@amd.com>
References: <20241022194158.110073-6-avadhut.naik@amd.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173046126325.3137.7092371512802120747.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the ras/core branch of tip:

Commit-ID:     612c2addff367ee461dc99ffca2bc786f105d2ec
Gitweb:        https://git.kernel.org/tip/612c2addff367ee461dc99ffca2bc786f105d2ec
Author:        Yazen Ghannam <yazen.ghannam@amd.com>
AuthorDate:    Tue, 22 Oct 2024 19:36:31 
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Thu, 31 Oct 2024 10:53:04 +01:00

EDAC/mce_amd: Add support for FRU text in MCA

A new "FRU Text in MCA" feature is defined where the Field Replaceable
Unit (FRU) Text for a device is represented by a string in the new
MCA_SYND1 and MCA_SYND2 registers. This feature is supported per MCA
bank, and it is advertised by the McaFruTextInMca bit (MCA_CONFIG[9]).

The FRU Text is populated dynamically for each individual error state
(MCA_STATUS, MCA_ADDR, et al.). Handle the case where an MCA bank covers
multiple devices, for example, a Unified Memory Controller (UMC) bank
that manages two DIMMs.

  [ Yazen: Add Avadhut as co-developer for wrapper changes. ]
  [ bp: Do not expose MCA_CONFIG to userspace yet. ]

Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
Co-developed-by: Avadhut Naik <avadhut.naik@amd.com>
Signed-off-by: Avadhut Naik <avadhut.naik@amd.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://lore.kernel.org/r/20241022194158.110073-6-avadhut.naik@amd.com
---
 arch/x86/include/asm/mce.h |  1 +
 drivers/edac/mce_amd.c     | 18 ++++++++++++------
 2 files changed, 13 insertions(+), 6 deletions(-)

diff --git a/arch/x86/include/asm/mce.h b/arch/x86/include/asm/mce.h
index 4d936ee..4543cf2 100644
--- a/arch/x86/include/asm/mce.h
+++ b/arch/x86/include/asm/mce.h
@@ -61,6 +61,7 @@
  *  - TCC bit is present in MCx_STATUS.
  */
 #define MCI_CONFIG_MCAX		0x1
+#define MCI_CONFIG_FRUTEXT	BIT_ULL(9)
 #define MCI_IPID_MCATYPE	0xFFFF0000
 #define MCI_IPID_HWID		0xFFF
 
diff --git a/drivers/edac/mce_amd.c b/drivers/edac/mce_amd.c
index 194d9fd..50d74d3 100644
--- a/drivers/edac/mce_amd.c
+++ b/drivers/edac/mce_amd.c
@@ -795,6 +795,7 @@ amd_decode_mce(struct notifier_block *nb, unsigned long val, void *data)
 	struct mce *m = (struct mce *)data;
 	struct mce_hw_err *err = to_mce_hw_err(m);
 	unsigned int fam = x86_family(m->cpuid);
+	u32 mca_config_lo = 0, dummy;
 	int ecc;
 
 	if (m->kflags & MCE_HANDLED_CEC)
@@ -814,11 +815,9 @@ amd_decode_mce(struct notifier_block *nb, unsigned long val, void *data)
 		((m->status & MCI_STATUS_PCC)	? "PCC"	  : "-"));
 
 	if (boot_cpu_has(X86_FEATURE_SMCA)) {
-		u32 low, high;
-		u32 addr = MSR_AMD64_SMCA_MCx_CONFIG(m->bank);
+		rdmsr_safe(MSR_AMD64_SMCA_MCx_CONFIG(m->bank), &mca_config_lo, &dummy);
 
-		if (!rdmsr_safe(addr, &low, &high) &&
-		    (low & MCI_CONFIG_MCAX))
+		if (mca_config_lo & MCI_CONFIG_MCAX)
 			pr_cont("|%s", ((m->status & MCI_STATUS_TCC) ? "TCC" : "-"));
 
 		pr_cont("|%s", ((m->status & MCI_STATUS_SYNDV) ? "SyndV" : "-"));
@@ -853,8 +852,15 @@ amd_decode_mce(struct notifier_block *nb, unsigned long val, void *data)
 
 		if (m->status & MCI_STATUS_SYNDV) {
 			pr_cont(", Syndrome: 0x%016llx\n", m->synd);
-			pr_emerg(HW_ERR "Syndrome1: 0x%016llx, Syndrome2: 0x%016llx",
-				 err->vendor.amd.synd1, err->vendor.amd.synd2);
+			if (mca_config_lo & MCI_CONFIG_FRUTEXT) {
+				char frutext[17];
+
+				frutext[16] = '\0';
+				memcpy(&frutext[0], &err->vendor.amd.synd1, 8);
+				memcpy(&frutext[8], &err->vendor.amd.synd2, 8);
+
+				pr_emerg(HW_ERR "FRU Text: %s", frutext);
+			}
 		}
 
 		pr_cont("\n");

