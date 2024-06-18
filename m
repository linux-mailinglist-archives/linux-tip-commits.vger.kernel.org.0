Return-Path: <linux-tip-commits+bounces-1433-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E3A6790C843
	for <lists+linux-tip-commits@lfdr.de>; Tue, 18 Jun 2024 13:03:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7CB521F243AB
	for <lists+linux-tip-commits@lfdr.de>; Tue, 18 Jun 2024 11:03:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D00BD3DABE4;
	Tue, 18 Jun 2024 09:45:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="eZM3MPKF";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="mABUynCX"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C0D021C182;
	Tue, 18 Jun 2024 09:45:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718703903; cv=none; b=S3pb9yFrGX5Wynx9lwQ5foDxhEhKP1jzEyAhpHMuNkqFmE44vbWM1tKS3U7q09HItWS4VUH/XkMAXn5GHKpBFgI586i2ulx9cnPK8Em1mYy+aXXAAQYWs/WtDqG7ZoSONnZlz3uHrxQM61vXKMh7MPVWiCsspPLsaU5h/AA1zV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718703903; c=relaxed/simple;
	bh=xDOJH9QGA9nkiobcKvyoyM2cZxpscpkobDKyo0Cvo00=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=Vu3QVUcWtRRv2CK0o7GbLuE+rDTqJe3FHcpa08jS7qiuqJXR5m1esvHMjgEYMVpiGPgHYSl//qoniVU6L6IEf+OcrtQ965jLdNA31l2DKIIPkEx/O0ls20hlV3Gs27GLvISiuIBoUiGB+1Sj09osST8yZOP2trwgDmZme3AJrD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=eZM3MPKF; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=mABUynCX; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 18 Jun 2024 09:44:57 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1718703898;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/L7w44N1Ohz0K0uBbVS84Qujb3/y5mujvugWLEGTW+U=;
	b=eZM3MPKFyy6PAFPTPoHn9TXi3f1kskMdgBk3FH2AIxnBw/e1qJVGYmT/QTmuGwti2egOav
	STFGwpnE8BhFxGIQ4cP3VzZ0d69DCtHqsH4Vk0r61/nbz99vE7OGZnnPRLpJmwMEaJwbDd
	6l6yyWwhLlNAuLXgzXk3tYwJXMKyFgXsV0rAceyD+uIfX1EvjP+18uK9k67+l4jd/Fmgj3
	2o5zmLDnEUdvSs4xWAvAji9aUjjEkGPJW4tSN1IPPlWE492nVHe63dFn3L47IlyEoZPE8d
	4OUd7qzxaBjBTTtDUbIUDBdlyk2qGez1+VOOJ7NieoUp15EPhCcAbN8PvSTacQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1718703898;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/L7w44N1Ohz0K0uBbVS84Qujb3/y5mujvugWLEGTW+U=;
	b=mABUynCXCevOxHiGX4NEIKjkMuESzNXJfSkMEA70by2UT2LX7nlmGYZQA8xDsg2+Q0meLD
	AlX/67j/c/nNnoDA==
From: "tip-bot2 for Tom Lendacky" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: x86/sev] x86/sev: Allow non-VMPL0 execution when an SVSM is present
Cc: Tom Lendacky <thomas.lendacky@amd.com>,
 "Borislav Petkov (AMD)" <bp@alien8.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: =?utf-8?q?=3C2ce7cf281cce1d0cba88f3f576687ef75dc3c953=2E17176?=
 =?utf-8?q?00736=2Egit=2Ethomas=2Elendacky=40amd=2Ecom=3E?=
References: =?utf-8?q?=3C2ce7cf281cce1d0cba88f3f576687ef75dc3c953=2E171760?=
 =?utf-8?q?0736=2Egit=2Ethomas=2Elendacky=40amd=2Ecom=3E?=
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171870389765.10875.470184657623651765.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/sev branch of tip:

Commit-ID:     99ef9f59847cab1f9091cd4b9d7efbee0ae4fc86
Gitweb:        https://git.kernel.org/tip/99ef9f59847cab1f9091cd4b9d7efbee0ae4fc86
Author:        Tom Lendacky <thomas.lendacky@amd.com>
AuthorDate:    Wed, 05 Jun 2024 10:18:56 -05:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Mon, 17 Jun 2024 20:42:58 +02:00

x86/sev: Allow non-VMPL0 execution when an SVSM is present

To allow execution at a level other than VMPL0, an SVSM must be present.
Allow the SEV-SNP guest to continue booting if an SVSM is detected and
the hypervisor supports the SVSM feature as indicated in the GHCB
hypervisor features bitmap.

  [ bp: Massage a bit. ]

Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://lore.kernel.org/r/2ce7cf281cce1d0cba88f3f576687ef75dc3c953.1717600736.git.thomas.lendacky@amd.com
---
 arch/x86/boot/compressed/sev.c    | 17 ++++++++++++++---
 arch/x86/include/asm/sev-common.h |  1 +
 arch/x86/kernel/sev.c             | 20 ++++++++++++--------
 3 files changed, 27 insertions(+), 11 deletions(-)

diff --git a/arch/x86/boot/compressed/sev.c b/arch/x86/boot/compressed/sev.c
index ce941a9..6970572 100644
--- a/arch/x86/boot/compressed/sev.c
+++ b/arch/x86/boot/compressed/sev.c
@@ -610,11 +610,15 @@ void sev_enable(struct boot_params *bp)
 	 * features.
 	 */
 	if (sev_status & MSR_AMD64_SEV_SNP_ENABLED) {
-		if (!(get_hv_features() & GHCB_HV_FT_SNP))
+		u64 hv_features;
+		int ret;
+
+		hv_features = get_hv_features();
+		if (!(hv_features & GHCB_HV_FT_SNP))
 			sev_es_terminate(SEV_TERM_SET_GEN, GHCB_SNP_UNSUPPORTED);
 
 		/*
-		 * Enforce running at VMPL0.
+		 * Enforce running at VMPL0 or with an SVSM.
 		 *
 		 * Use RMPADJUST (see the rmpadjust() function for a description of
 		 * what the instruction does) to update the VMPL1 permissions of a
@@ -623,7 +627,14 @@ void sev_enable(struct boot_params *bp)
 		 * only ever run at a single VMPL level so permission mask changes of a
 		 * lesser-privileged VMPL are a don't-care.
 		 */
-		if (rmpadjust((unsigned long)&boot_ghcb_page, RMP_PG_SIZE_4K, 1))
+		ret = rmpadjust((unsigned long)&boot_ghcb_page, RMP_PG_SIZE_4K, 1);
+
+		/*
+		 * Running at VMPL0 is not required if an SVSM is present and the hypervisor
+		 * supports the required SVSM GHCB events.
+		 */
+		if (ret &&
+		    !(snp_vmpl && (hv_features & GHCB_HV_FT_SNP_MULTI_VMPL)))
 			sev_es_terminate(SEV_TERM_SET_LINUX, GHCB_TERM_NOT_VMPL0);
 	}
 
diff --git a/arch/x86/include/asm/sev-common.h b/arch/x86/include/asm/sev-common.h
index 78a4c25..e90d403 100644
--- a/arch/x86/include/asm/sev-common.h
+++ b/arch/x86/include/asm/sev-common.h
@@ -122,6 +122,7 @@ enum psc_op {
 
 #define GHCB_HV_FT_SNP			BIT_ULL(0)
 #define GHCB_HV_FT_SNP_AP_CREATION	BIT_ULL(1)
+#define GHCB_HV_FT_SNP_MULTI_VMPL	BIT_ULL(5)
 
 /*
  * SNP Page State Change NAE event
diff --git a/arch/x86/kernel/sev.c b/arch/x86/kernel/sev.c
index 53ac3e0..726d9df 100644
--- a/arch/x86/kernel/sev.c
+++ b/arch/x86/kernel/sev.c
@@ -2352,23 +2352,27 @@ static void dump_cpuid_table(void)
  * expected, but that initialization happens too early in boot to print any
  * sort of indicator, and there's not really any other good place to do it,
  * so do it here.
+ *
+ * If running as an SNP guest, report the current VM privilege level (VMPL).
  */
-static int __init report_cpuid_table(void)
+static int __init report_snp_info(void)
 {
 	const struct snp_cpuid_table *cpuid_table = snp_cpuid_get_table();
 
-	if (!cpuid_table->count)
-		return 0;
+	if (cpuid_table->count) {
+		pr_info("Using SNP CPUID table, %d entries present.\n",
+			cpuid_table->count);
 
-	pr_info("Using SNP CPUID table, %d entries present.\n",
-		cpuid_table->count);
+		if (sev_cfg.debug)
+			dump_cpuid_table();
+	}
 
-	if (sev_cfg.debug)
-		dump_cpuid_table();
+	if (cc_platform_has(CC_ATTR_GUEST_SEV_SNP))
+		pr_info("SNP running at VMPL%u.\n", snp_vmpl);
 
 	return 0;
 }
-arch_initcall(report_cpuid_table);
+arch_initcall(report_snp_info);
 
 static int __init init_sev_config(char *str)
 {

