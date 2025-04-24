Return-Path: <linux-tip-commits+bounces-5114-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 19CD8A9B2A3
	for <lists+linux-tip-commits@lfdr.de>; Thu, 24 Apr 2025 17:41:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2290E1B87A15
	for <lists+linux-tip-commits@lfdr.de>; Thu, 24 Apr 2025 15:41:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAC7E1E505;
	Thu, 24 Apr 2025 15:41:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="f41d19ZA";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="D5Xu5OGB"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0102D1A2381;
	Thu, 24 Apr 2025 15:41:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745509273; cv=none; b=SuWqb0yCX6at18LQ+0S5zwcuixfw4hXT9BUTsBV+wrIHuwHt08Fohn6IQ9fOr2YFD2VLOL3iOwyk92OKLH5SBHw3DtdwBUV1RSq6/ODkGSQmHyzcPvanE2cCq6LfcKrteYRUNJighj6KYPtOi360+v9nImoV6et11iKgOip2MZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745509273; c=relaxed/simple;
	bh=BUsfWyugC4fOI4dbDRGKFEho2nEDDQ1VSW+SJy2dCBE=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=hrxSLwcRrcycoCgRR1GYViIRG9sJ4HQhU1SK3F7OrHgIDtge9cXQ8+bbuy5yeAVcFCm/OBaPMli0Yn7RLDZoGv0X2r7s5j9AGhvMRMX0NRgBN+IzxzfJ21bVxKPiTNWiYpM74bajJTTAJdreMztwF8muROoKxzOgAqT4VVKAqIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=f41d19ZA; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=D5Xu5OGB; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 24 Apr 2025 15:41:03 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1745509269;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PuqbTaAzURsbYcqcz+do/Cu2Srz5dw7WWCHXR3VUQys=;
	b=f41d19ZAZbMeqcWjS5SkjjoxO1YI5LLZK3wh+BSpUPFicpg0chxjYJXZcAwHKyAEZVYL6A
	m3Ni2xP/vCCrHhF3Sy+bQLCNhaa8sivJvS0opFg/008/op5hcAIrVgMDt0dhs1TlHjoenR
	u31fRVN5Yal0fpUIj0vOncetahdctWcD2DkiDFKbZuS9KLABo5LlGvvnq9EIIHvxzdohC+
	lctX4+bDdEjA1A+EJSdYfVpXxKUrYSVNgd7whAbGaMpXTzkPfL1Q/G1wiOHsZapS7XCjFm
	SmGlFzJmH1OBc7n6AdDHslr7uXrwjU+Pi0DEPgNEdWDF+E/nOFFX902ixxs8Cw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1745509269;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PuqbTaAzURsbYcqcz+do/Cu2Srz5dw7WWCHXR3VUQys=;
	b=D5Xu5OGBSIpfC4GVhKnVVa5zHjqGlhMdY8yfmOs5oq3m+dlj3KuZLBCVfa7udpTXWHB9oh
	iMwGwUoS48KYbzCw==
From: "tip-bot2 for Tom Lendacky" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/boot] x86/sev: Share the sev_secrets_pa value again
Cc: Tom Lendacky <thomas.lendacky@amd.com>, Ingo Molnar <mingo@kernel.org>,
 Ard Biesheuvel <ardb@kernel.org>,
 Dionna Amalie Glaze <dionnaglaze@google.com>,
 Kevin Loughlin <kevinloughlin@google.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <cf878810-81ed-3017-52c6-ce6aa41b5f01@amd.com>
References: <cf878810-81ed-3017-52c6-ce6aa41b5f01@amd.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174550926387.31282.8024498782812144912.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/boot branch of tip:

Commit-ID:     18ea89eae404d119ced26d80ac3e62255ce15409
Gitweb:        https://git.kernel.org/tip/18ea89eae404d119ced26d80ac3e62255ce15409
Author:        Tom Lendacky <thomas.lendacky@amd.com>
AuthorDate:    Wed, 23 Apr 2025 10:22:31 -05:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Thu, 24 Apr 2025 17:20:52 +02:00

x86/sev: Share the sev_secrets_pa value again

This commits breaks SNP guests:

  234cf67fc3bd ("x86/sev: Split off startup code from core code")

The SNP guest boots, but no longer has access to the VMPCK keys needed
to communicate with the ASP, which is used, for example, to obtain an
attestation report.

The secrets_pa value is defined as static in both startup.c and
core.c. It is set by a function in startup.c and so when used in
core.c its value will be 0.

Share it again and add the sev_ prefix to put it into the global
SEV symbols namespace.

[ mingo: Renamed to sev_secrets_pa ]

Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Acked-by: Ard Biesheuvel <ardb@kernel.org>
Cc: Dionna Amalie Glaze <dionnaglaze@google.com>
Cc: Kevin Loughlin <kevinloughlin@google.com>
Link: https://lore.kernel.org/r/cf878810-81ed-3017-52c6-ce6aa41b5f01@amd.com
---
 arch/x86/boot/startup/sev-startup.c | 4 ++--
 arch/x86/coco/sev/core.c            | 7 ++-----
 arch/x86/include/asm/sev-internal.h | 1 +
 3 files changed, 5 insertions(+), 7 deletions(-)

diff --git a/arch/x86/boot/startup/sev-startup.c b/arch/x86/boot/startup/sev-startup.c
index 36a75c5..f901ce9 100644
--- a/arch/x86/boot/startup/sev-startup.c
+++ b/arch/x86/boot/startup/sev-startup.c
@@ -55,7 +55,7 @@ struct ghcb *boot_ghcb __section(".data");
 u64 sev_hv_features __ro_after_init;
 
 /* Secrets page physical address from the CC blob */
-static u64 secrets_pa __ro_after_init;
+u64 sev_secrets_pa __ro_after_init;
 
 /* For early boot SVSM communication */
 struct svsm_ca boot_svsm_ca_page __aligned(PAGE_SIZE);
@@ -1367,7 +1367,7 @@ bool __head snp_init(struct boot_params *bp)
 		return false;
 
 	if (cc_info->secrets_phys && cc_info->secrets_len == PAGE_SIZE)
-		secrets_pa = cc_info->secrets_phys;
+		sev_secrets_pa = cc_info->secrets_phys;
 	else
 		return false;
 
diff --git a/arch/x86/coco/sev/core.c b/arch/x86/coco/sev/core.c
index 617988a..ac40052 100644
--- a/arch/x86/coco/sev/core.c
+++ b/arch/x86/coco/sev/core.c
@@ -80,9 +80,6 @@ static const char * const sev_status_feat_names[] = {
 	[MSR_AMD64_SNP_SMT_PROT_BIT]		= "SMTProt",
 };
 
-/* Secrets page physical address from the CC blob */
-static u64 secrets_pa __ro_after_init;
-
 /*
  * For Secure TSC guests, the BSP fetches TSC_INFO using SNP guest messaging and
  * initializes snp_tsc_scale and snp_tsc_offset. These values are replicated
@@ -109,7 +106,7 @@ static u64 __init get_snp_jump_table_addr(void)
 	void __iomem *mem;
 	u64 addr;
 
-	mem = ioremap_encrypted(secrets_pa, PAGE_SIZE);
+	mem = ioremap_encrypted(sev_secrets_pa, PAGE_SIZE);
 	if (!mem) {
 		pr_err("Unable to locate AP jump table address: failed to map the SNP secrets page.\n");
 		return 0;
@@ -1599,7 +1596,7 @@ struct snp_msg_desc *snp_msg_alloc(void)
 	if (!mdesc)
 		return ERR_PTR(-ENOMEM);
 
-	mem = ioremap_encrypted(secrets_pa, PAGE_SIZE);
+	mem = ioremap_encrypted(sev_secrets_pa, PAGE_SIZE);
 	if (!mem)
 		goto e_free_mdesc;
 
diff --git a/arch/x86/include/asm/sev-internal.h b/arch/x86/include/asm/sev-internal.h
index e54847a..a78f972 100644
--- a/arch/x86/include/asm/sev-internal.h
+++ b/arch/x86/include/asm/sev-internal.h
@@ -5,6 +5,7 @@
 extern struct ghcb boot_ghcb_page;
 extern struct ghcb *boot_ghcb;
 extern u64 sev_hv_features;
+extern u64 sev_secrets_pa;
 
 /* #VC handler runtime per-CPU data */
 struct sev_es_runtime_data {

