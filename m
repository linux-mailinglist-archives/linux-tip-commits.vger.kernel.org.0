Return-Path: <linux-tip-commits+bounces-6477-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CE2BB439F5
	for <lists+linux-tip-commits@lfdr.de>; Thu,  4 Sep 2025 13:25:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 01B1B3B06FB
	for <lists+linux-tip-commits@lfdr.de>; Thu,  4 Sep 2025 11:24:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8EFF2FD7A5;
	Thu,  4 Sep 2025 11:21:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="SUsxT+31";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="nS7i1GcH"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 973B32FD1D4;
	Thu,  4 Sep 2025 11:21:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756984872; cv=none; b=J1mbf8qyoooVjsIvL46HLekltJ7AL0L6WHAtFtMTingJc3ydqe/ZNdp2g8Nsw10BL39ZXrqjl90UVAd5zH3UrCA16EVUPCr4P0Ky2TgQD2B5TYOxA4Qiit7h9WY7Jp/ONjfOSAk6I474783PHQNzKrs46RwOl2HpMFhuycg71pY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756984872; c=relaxed/simple;
	bh=aICdoIGCuq9sLogywTGovSincleShSjS6KsROHej1gw=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=fWB5Hhai/TyrUyApsiSmnBQwfvtPV73XVqnV1HtoVqKVEOF+YTgCW2FQaFR+cNuh93Pv9y1FZpxAX9b/RgY0SHGSjiiUAdSXn4/bhdiLZuqR9ptYGZiplmivN/nKcY+4wluImYcPBSdja6mqJA5QV7GZEskMgjwh5BptALCao6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=SUsxT+31; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=nS7i1GcH; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 04 Sep 2025 11:21:07 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1756984869;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=t4xVA5wtbdn64SgRdSwxlgrkTT+nxzCmRKrrA/P3ifk=;
	b=SUsxT+31l9wVP7yAY2OpztiwHBFMjwCNZqXBLfq2/uyqiJTzFAkAH7JBKXPDfzbmbwkCGz
	i+VZhafLoqci5UQiZH0mm1bY/sYodQizN8hLLf0dmt4YvsjokuiRDHq8gvA7oKIqOWZm/V
	rFKLHQ5YynvaVsUiltnvNGy+9xvCUh/CszUitqZqAICDygZN4F8uEfIQ1YbvLjF2MA3mB9
	EfIG85z5dxN24U74AnIH83ds8Of5MigrNYFFIezt8JLG/0HXCEpO0QNQnBH66zE52EOWwx
	lulrK3Asr4rx7pd4rgSWHY/MI24nEBod2G6pSJLqTEiNuLJfcuLUajARGCreuw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1756984869;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=t4xVA5wtbdn64SgRdSwxlgrkTT+nxzCmRKrrA/P3ifk=;
	b=nS7i1GcHKo5T/8SAk6LOYuKdO27kaYLopiepac6uwhMsOMOJVxeNTmiClGsTlGM5m2jsYW
	rlQzt0+QLKANDWDQ==
From: "tip-bot2 for Ard Biesheuvel" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: x86/sev] x86/sev: Use MSR protocol only for early SVSM PVALIDATE call
Cc: Ard Biesheuvel <ardb@kernel.org>, "Borislav Petkov (AMD)" <bp@alien8.de>,
 Tom Lendacky <thomas.lendacky@amd.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250828102202.1849035-27-ardb+git@google.com>
References: <20250828102202.1849035-27-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175698486771.1920.12764453811083045602.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the x86/sev branch of tip:

Commit-ID:     7cb7b6de9cb90311a917d65c0228b6aa223dc456
Gitweb:        https://git.kernel.org/tip/7cb7b6de9cb90311a917d65c0228b6aa223=
dc456
Author:        Ard Biesheuvel <ardb@kernel.org>
AuthorDate:    Thu, 28 Aug 2025 12:22:06 +02:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Sun, 31 Aug 2025 12:40:55 +02:00

x86/sev: Use MSR protocol only for early SVSM PVALIDATE call

The early page state change API performs an SVSM call to PVALIDATE each page
when running under a SVSM, and this involves either a GHCB page based call or
a call based on the MSR protocol.

The GHCB page based variant involves VA to PA translation of the GHCB address,
and this is best avoided in the startup code, where virtual addresses are
ambiguous (1:1 or kernel virtual).

As this is the last remaining occurrence of svsm_perform_call_protocol() in
the startup code, switch to the MSR protocol exclusively in this particular
case, so that the GHCB based plumbing can be moved out of the startup code
entirely in a subsequent patch.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Tom Lendacky <thomas.lendacky@amd.com>
Link: https://lore.kernel.org/20250828102202.1849035-27-ardb+git@google.com
---
 arch/x86/boot/compressed/sev.c     | 20 --------------------
 arch/x86/boot/startup/sev-shared.c |  9 ++++++---
 2 files changed, 6 insertions(+), 23 deletions(-)

diff --git a/arch/x86/boot/compressed/sev.c b/arch/x86/boot/compressed/sev.c
index fd1b67d..b71c1ab 100644
--- a/arch/x86/boot/compressed/sev.c
+++ b/arch/x86/boot/compressed/sev.c
@@ -50,31 +50,11 @@ u64 svsm_get_caa_pa(void)
 	return boot_svsm_caa_pa;
 }
=20
-int svsm_perform_call_protocol(struct svsm_call *call);
-
 u8 snp_vmpl;
=20
 /* Include code for early handlers */
 #include "../../boot/startup/sev-shared.c"
=20
-int svsm_perform_call_protocol(struct svsm_call *call)
-{
-	struct ghcb *ghcb;
-	int ret;
-
-	if (boot_ghcb)
-		ghcb =3D boot_ghcb;
-	else
-		ghcb =3D NULL;
-
-	do {
-		ret =3D ghcb ? svsm_perform_ghcb_protocol(ghcb, call)
-			   : svsm_perform_msr_protocol(call);
-	} while (ret =3D=3D -EAGAIN);
-
-	return ret;
-}
-
 static bool sev_snp_enabled(void)
 {
 	return sev_status & MSR_AMD64_SEV_SNP_ENABLED;
diff --git a/arch/x86/boot/startup/sev-shared.c b/arch/x86/boot/startup/sev-s=
hared.c
index 975d2b0..7bd7346 100644
--- a/arch/x86/boot/startup/sev-shared.c
+++ b/arch/x86/boot/startup/sev-shared.c
@@ -741,7 +741,6 @@ static void __head svsm_pval_4k_page(unsigned long paddr,=
 bool validate)
 	struct svsm_call call =3D {};
 	unsigned long flags;
 	u64 pc_pa;
-	int ret;
=20
 	/*
 	 * This can be called very early in the boot, use native functions in
@@ -766,8 +765,12 @@ static void __head svsm_pval_4k_page(unsigned long paddr=
, bool validate)
 	call.rax =3D SVSM_CORE_CALL(SVSM_CORE_PVALIDATE);
 	call.rcx =3D pc_pa;
=20
-	ret =3D svsm_perform_call_protocol(&call);
-	if (ret)
+	/*
+	 * Use the MSR protocol exclusively, so that this code is usable in
+	 * startup code where VA/PA translations of the GHCB page's address may
+	 * be problematic.
+	 */
+	if (svsm_call_msr_protocol(&call))
 		sev_es_terminate(SEV_TERM_SET_LINUX, GHCB_TERM_PVALIDATE);
=20
 	native_local_irq_restore(flags);

