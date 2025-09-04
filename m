Return-Path: <linux-tip-commits+bounces-6473-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 70415B439E5
	for <lists+linux-tip-commits@lfdr.de>; Thu,  4 Sep 2025 13:24:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ED65E7ACCC5
	for <lists+linux-tip-commits@lfdr.de>; Thu,  4 Sep 2025 11:22:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1E193043C8;
	Thu,  4 Sep 2025 11:21:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="c+43qsd6";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="2bbTRavL"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1DE5302CA3;
	Thu,  4 Sep 2025 11:21:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756984867; cv=none; b=u9EsGiaBf+seV2MMnFl+xpSbp5M20HEDMNznoCxo1/499jtxJdliLVqHBhHtA+XdZ1kpedmXruDsRKl1C5SKj/Pf7uXLVxsxDXj87l1bpBU+GT1T83Pan8FecQQtkwQ8ci/uO+5fFkvu2dRsjasMHYzlP9Ywj53nj8IukwQsx1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756984867; c=relaxed/simple;
	bh=mcSd9bs9Hfe/65OuztCu33YAU5ximID4FkfCevPFNL8=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=nH84vKOx+xuMNV33Ld21gw6dXgCCmroTUhNn7tIuQrzHL+jGj6D5sKBZeRyZKw+CqAUsoYQSWxtiE0nrVcLztCpfcOLgtQG83dsHY1tAe2XeQIybvsbIj1FRDNtNdP3cQEvDtdharKQMnPijH0xJot4gCJqqpyHJ4SFsM0r46KQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=c+43qsd6; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=2bbTRavL; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 04 Sep 2025 11:21:03 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1756984864;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NMimr66HeH4c9lAtSS+q89xaeTEFVL6IXuMD1SspKUM=;
	b=c+43qsd6XDNbv82fxf7LNWPvs2nrvulB9et/+dNS18nwNvRu3sfT/Hu0PjXWwRURzd9Y42
	pmKYNHeD5EbtGSXmJDcnhNIWX2JWiixxHWTOq3lYHehdxIiI1bRfMhO4Whv81o2UQUDiyL
	Zznlthgzr4LnZQwC/avQshrU+3dmdfr/kT3m/M4V3+0g4BzHpsVFDlleyqRjHYPtQe9RYw
	efRfAKfTjZ5JGmjRKAUt0/mVGA8iTPq1DffmV67Fkh7MOb0EegeyKuPsKvwqTAJUjYIee+
	yBaS9wZNbGK3uNatEfVK6k070GecUYuopTuhDcfq88fe5J7ma2vrAgZ71V22Qg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1756984864;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NMimr66HeH4c9lAtSS+q89xaeTEFVL6IXuMD1SspKUM=;
	b=2bbTRavLwF0pnxLThztI/NS2Gl226zTu/IbCOE5b71XbqYPYGcGOhdMBCYrcU5cx38JI97
	cMPUzLaYPIAhZoBA==
From: "tip-bot2 for Ard Biesheuvel" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: x86/sev] x86/sev: Share implementation of MSR-based page state change
Cc: Ard Biesheuvel <ardb@kernel.org>, "Borislav Petkov (AMD)" <bp@alien8.de>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250828102202.1849035-31-ardb+git@google.com>
References: <20250828102202.1849035-31-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175698486303.1920.3187575001915603229.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the x86/sev branch of tip:

Commit-ID:     d5949ea50c5642ab7e3c4dd6020e23725c079b25
Gitweb:        https://git.kernel.org/tip/d5949ea50c5642ab7e3c4dd6020e23725c0=
79b25
Author:        Ard Biesheuvel <ardb@kernel.org>
AuthorDate:    Thu, 28 Aug 2025 12:22:10 +02:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Wed, 03 Sep 2025 17:58:19 +02:00

x86/sev: Share implementation of MSR-based page state change

Both the decompressor and the SEV startup code implement the exact same
sequence for invoking the MSR based communication protocol to effectuate
a page state change.

Before tweaking the internal APIs used in both versions, merge them and
share them so those tweaks are only needed in a single place.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://lore.kernel.org/20250828102202.1849035-31-ardb+git@google.com
---
 arch/x86/boot/compressed/sev.c      | 40 ++--------------------------
 arch/x86/boot/startup/sev-shared.c  | 35 +++++++++++++++++++++++++-
 arch/x86/boot/startup/sev-startup.c | 29 +--------------------
 3 files changed, 39 insertions(+), 65 deletions(-)

diff --git a/arch/x86/boot/compressed/sev.c b/arch/x86/boot/compressed/sev.c
index f2b8dfb..6b62c75 100644
--- a/arch/x86/boot/compressed/sev.c
+++ b/arch/x86/boot/compressed/sev.c
@@ -60,46 +60,12 @@ static bool sev_snp_enabled(void)
 	return sev_status & MSR_AMD64_SEV_SNP_ENABLED;
 }
=20
-static void __page_state_change(unsigned long paddr, enum psc_op op)
-{
-	u64 val, msr;
-
-	/*
-	 * If private -> shared then invalidate the page before requesting the
-	 * state change in the RMP table.
-	 */
-	if (op =3D=3D SNP_PAGE_STATE_SHARED)
-		pvalidate_4k_page(paddr, paddr, false);
-
-	/* Save the current GHCB MSR value */
-	msr =3D sev_es_rd_ghcb_msr();
-
-	/* Issue VMGEXIT to change the page state in RMP table. */
-	sev_es_wr_ghcb_msr(GHCB_MSR_PSC_REQ_GFN(paddr >> PAGE_SHIFT, op));
-	VMGEXIT();
-
-	/* Read the response of the VMGEXIT. */
-	val =3D sev_es_rd_ghcb_msr();
-	if ((GHCB_RESP_CODE(val) !=3D GHCB_MSR_PSC_RESP) || GHCB_MSR_PSC_RESP_VAL(v=
al))
-		sev_es_terminate(SEV_TERM_SET_LINUX, GHCB_TERM_PSC);
-
-	/* Restore the GHCB MSR value */
-	sev_es_wr_ghcb_msr(msr);
-
-	/*
-	 * Now that page state is changed in the RMP table, validate it so that it =
is
-	 * consistent with the RMP entry.
-	 */
-	if (op =3D=3D SNP_PAGE_STATE_PRIVATE)
-		pvalidate_4k_page(paddr, paddr, true);
-}
-
 void snp_set_page_private(unsigned long paddr)
 {
 	if (!sev_snp_enabled())
 		return;
=20
-	__page_state_change(paddr, SNP_PAGE_STATE_PRIVATE);
+	__page_state_change(paddr, paddr, SNP_PAGE_STATE_PRIVATE);
 }
=20
 void snp_set_page_shared(unsigned long paddr)
@@ -107,7 +73,7 @@ void snp_set_page_shared(unsigned long paddr)
 	if (!sev_snp_enabled())
 		return;
=20
-	__page_state_change(paddr, SNP_PAGE_STATE_SHARED);
+	__page_state_change(paddr, paddr, SNP_PAGE_STATE_SHARED);
 }
=20
 bool early_setup_ghcb(void)
@@ -133,7 +99,7 @@ bool early_setup_ghcb(void)
 void snp_accept_memory(phys_addr_t start, phys_addr_t end)
 {
 	for (phys_addr_t pa =3D start; pa < end; pa +=3D PAGE_SIZE)
-		__page_state_change(pa, SNP_PAGE_STATE_PRIVATE);
+		__page_state_change(pa, pa, SNP_PAGE_STATE_PRIVATE);
 }
=20
 void sev_es_shutdown_ghcb(void)
diff --git a/arch/x86/boot/startup/sev-shared.c b/arch/x86/boot/startup/sev-s=
hared.c
index 80d4fda..00220d7 100644
--- a/arch/x86/boot/startup/sev-shared.c
+++ b/arch/x86/boot/startup/sev-shared.c
@@ -664,6 +664,41 @@ static void __head pvalidate_4k_page(unsigned long vaddr=
, unsigned long paddr,
 		sev_evict_cache((void *)vaddr, 1);
 }
=20
+static void __head __page_state_change(unsigned long vaddr, unsigned long pa=
ddr,
+				       enum psc_op op)
+{
+	u64 val, msr;
+
+	/*
+	 * If private -> shared then invalidate the page before requesting the
+	 * state change in the RMP table.
+	 */
+	if (op =3D=3D SNP_PAGE_STATE_SHARED)
+		pvalidate_4k_page(vaddr, paddr, false);
+
+	/* Save the current GHCB MSR value */
+	msr =3D sev_es_rd_ghcb_msr();
+
+	/* Issue VMGEXIT to change the page state in RMP table. */
+	sev_es_wr_ghcb_msr(GHCB_MSR_PSC_REQ_GFN(paddr >> PAGE_SHIFT, op));
+	VMGEXIT();
+
+	/* Read the response of the VMGEXIT. */
+	val =3D sev_es_rd_ghcb_msr();
+	if ((GHCB_RESP_CODE(val) !=3D GHCB_MSR_PSC_RESP) || GHCB_MSR_PSC_RESP_VAL(v=
al))
+		sev_es_terminate(SEV_TERM_SET_LINUX, GHCB_TERM_PSC);
+
+	/* Restore the GHCB MSR value */
+	sev_es_wr_ghcb_msr(msr);
+
+	/*
+	 * Now that page state is changed in the RMP table, validate it so that it =
is
+	 * consistent with the RMP entry.
+	 */
+	if (op =3D=3D SNP_PAGE_STATE_PRIVATE)
+		pvalidate_4k_page(vaddr, paddr, true);
+}
+
 /*
  * Maintain the GPA of the SVSM Calling Area (CA) in order to utilize the SV=
SM
  * services needed when not running in VMPL0.
diff --git a/arch/x86/boot/startup/sev-startup.c b/arch/x86/boot/startup/sev-=
startup.c
index 8a06f60..5eb7d93 100644
--- a/arch/x86/boot/startup/sev-startup.c
+++ b/arch/x86/boot/startup/sev-startup.c
@@ -135,7 +135,6 @@ early_set_pages_state(unsigned long vaddr, unsigned long =
paddr,
 		      unsigned long npages, enum psc_op op)
 {
 	unsigned long paddr_end;
-	u64 val;
=20
 	vaddr =3D vaddr & PAGE_MASK;
=20
@@ -143,37 +142,11 @@ early_set_pages_state(unsigned long vaddr, unsigned lon=
g paddr,
 	paddr_end =3D paddr + (npages << PAGE_SHIFT);
=20
 	while (paddr < paddr_end) {
-		/* Page validation must be rescinded before changing to shared */
-		if (op =3D=3D SNP_PAGE_STATE_SHARED)
-			pvalidate_4k_page(vaddr, paddr, false);
-
-		/*
-		 * Use the MSR protocol because this function can be called before
-		 * the GHCB is established.
-		 */
-		sev_es_wr_ghcb_msr(GHCB_MSR_PSC_REQ_GFN(paddr >> PAGE_SHIFT, op));
-		VMGEXIT();
-
-		val =3D sev_es_rd_ghcb_msr();
-
-		if (GHCB_RESP_CODE(val) !=3D GHCB_MSR_PSC_RESP)
-			goto e_term;
-
-		if (GHCB_MSR_PSC_RESP_VAL(val))
-			goto e_term;
-
-		/* Page validation must be performed after changing to private */
-		if (op =3D=3D SNP_PAGE_STATE_PRIVATE)
-			pvalidate_4k_page(vaddr, paddr, true);
+		__page_state_change(vaddr, paddr, op);
=20
 		vaddr +=3D PAGE_SIZE;
 		paddr +=3D PAGE_SIZE;
 	}
-
-	return;
-
-e_term:
-	sev_es_terminate(SEV_TERM_SET_LINUX, GHCB_TERM_PSC);
 }
=20
 void __head early_snp_set_memory_private(unsigned long vaddr, unsigned long =
paddr,

