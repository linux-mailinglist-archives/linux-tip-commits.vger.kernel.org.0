Return-Path: <linux-tip-commits+bounces-6472-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A9C4B439E4
	for <lists+linux-tip-commits@lfdr.de>; Thu,  4 Sep 2025 13:23:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6E1DD5A2436
	for <lists+linux-tip-commits@lfdr.de>; Thu,  4 Sep 2025 11:23:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5357302CC3;
	Thu,  4 Sep 2025 11:21:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ZXH1KHl6";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="qdNrhbtq"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 833BF3019C1;
	Thu,  4 Sep 2025 11:21:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756984866; cv=none; b=R7oSbDpuXX1AX6tubxDteuUxXj/8kDGsdgKtmjuUw7UI+cfaUM0CQcrvZyBu2EyJhS9r9jHGnUTrxvl47DnodCj9unD5x7FQY/pfAj/zAXGF/cXuxFm7e2fHcHlsSJWmfh381SI7pFdZyguolvIz0QXqqkWL1RBVJmkCi7ddn4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756984866; c=relaxed/simple;
	bh=UdonHWyEQxxZWQhu3l22069s1L2Xhyv2c3ukQv2wcEo=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=eaOEuqOYadsEz+t2IVbkkZVRMepUCwv0zaOEpm9bpx80GRtTHWmwc+GkxqnBphx19ME95vxYIvk2j7gsOhuwidkTm9kFdqtQ1qmwPp/E2iGkdTAA+4E2XMefeObnpO6qUJrL7mvdbKyIJzH+TkhZN32VTWxKtdsuNM1bBL5dlgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ZXH1KHl6; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=qdNrhbtq; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 04 Sep 2025 11:21:01 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1756984863;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=G+rLi0iG6qLVqsYBDTaW1+PAydPDdWs5dc6Yf3Pufdg=;
	b=ZXH1KHl6VZByNdPpbdqxlKyh7irDkCRu1FwHaW56xOftCxAYrW+LGsXbGZanSv5YScwbJM
	dfzMwnKESy2sCsRzfTdUbGoWmeTUmtXzTQJEEeClbqhWToS1k8ujULULKtruf/M8O8bjth
	6tlYejNPzH7BnsrTCwafhug8GZi1siRaKvgeTKrXm3ovYo/c0a8dEjKl9pyv7zDcD3D5UT
	i5DYqslJrrPdbsHmx0ElMDHcqXsnX76JljzSyp1RRpjmI7w3G45tjvArPt12Dp0lwMmXlx
	TCoeMYLTDlKi2YK0NGFvvTGjiNKerTmPcgIwNZNcXJ1r2i70qYMXMIThD8VpAg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1756984863;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=G+rLi0iG6qLVqsYBDTaW1+PAydPDdWs5dc6Yf3Pufdg=;
	b=qdNrhbtqflmH+iB+DgCeSfldN0+bUh+So6P9OZRsrmypjbWCIluWmq9R3nBcJ2lga7vhsI
	8FRSjuGKvFzh9ABQ==
From: "tip-bot2 for Ard Biesheuvel" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/sev] x86/sev: Pass SVSM calling area down to early page
 state change API
Cc: Ard Biesheuvel <ardb@kernel.org>, "Borislav Petkov (AMD)" <bp@alien8.de>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250828102202.1849035-32-ardb+git@google.com>
References: <20250828102202.1849035-32-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175698486184.1920.12659815691498229145.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the x86/sev branch of tip:

Commit-ID:     00d25566761746ba53934ad3a89ea79923a38d01
Gitweb:        https://git.kernel.org/tip/00d25566761746ba53934ad3a89ea79923a=
38d01
Author:        Ard Biesheuvel <ardb@kernel.org>
AuthorDate:    Thu, 28 Aug 2025 12:22:11 +02:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Wed, 03 Sep 2025 17:58:22 +02:00

x86/sev: Pass SVSM calling area down to early page state change API

The early page state change API is mostly only used very early, when only the
boot time SVSM calling area is in use. However, this API is also called by the
kexec finishing code, which runs very late, and potentially from a different
CPU (which uses a different calling area).

To avoid pulling the per-CPU SVSM calling area pointers and related SEV state
into the startup code, refactor the page state change API so the SVSM calling
area virtual and physical addresses can be provided by the caller.

No functional change intended.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://lore.kernel.org/20250828102202.1849035-32-ardb+git@google.com
---
 arch/x86/boot/compressed/sev.c      | 24 +++++++++++++++++++++---
 arch/x86/boot/startup/sev-shared.c  | 23 ++++++++++++-----------
 arch/x86/boot/startup/sev-startup.c | 16 ++++++++++++----
 arch/x86/coco/sev/core.c            |  7 +++++--
 arch/x86/include/asm/sev-internal.h |  2 +-
 arch/x86/include/asm/sev.h          |  6 ++++++
 6 files changed, 57 insertions(+), 21 deletions(-)

diff --git a/arch/x86/boot/compressed/sev.c b/arch/x86/boot/compressed/sev.c
index 6b62c75..0e56741 100644
--- a/arch/x86/boot/compressed/sev.c
+++ b/arch/x86/boot/compressed/sev.c
@@ -62,18 +62,30 @@ static bool sev_snp_enabled(void)
=20
 void snp_set_page_private(unsigned long paddr)
 {
+	struct psc_desc d =3D {
+		SNP_PAGE_STATE_PRIVATE,
+		(struct svsm_ca *)boot_svsm_caa_pa,
+		boot_svsm_caa_pa
+	};
+
 	if (!sev_snp_enabled())
 		return;
=20
-	__page_state_change(paddr, paddr, SNP_PAGE_STATE_PRIVATE);
+	__page_state_change(paddr, paddr, &d);
 }
=20
 void snp_set_page_shared(unsigned long paddr)
 {
+	struct psc_desc d =3D {
+		SNP_PAGE_STATE_SHARED,
+		(struct svsm_ca *)boot_svsm_caa_pa,
+		boot_svsm_caa_pa
+	};
+
 	if (!sev_snp_enabled())
 		return;
=20
-	__page_state_change(paddr, paddr, SNP_PAGE_STATE_SHARED);
+	__page_state_change(paddr, paddr, &d);
 }
=20
 bool early_setup_ghcb(void)
@@ -98,8 +110,14 @@ bool early_setup_ghcb(void)
=20
 void snp_accept_memory(phys_addr_t start, phys_addr_t end)
 {
+	struct psc_desc d =3D {
+		SNP_PAGE_STATE_PRIVATE,
+		(struct svsm_ca *)boot_svsm_caa_pa,
+		boot_svsm_caa_pa
+	};
+
 	for (phys_addr_t pa =3D start; pa < end; pa +=3D PAGE_SIZE)
-		__page_state_change(pa, pa, SNP_PAGE_STATE_PRIVATE);
+		__page_state_change(pa, pa, &d);
 }
=20
 void sev_es_shutdown_ghcb(void)
diff --git a/arch/x86/boot/startup/sev-shared.c b/arch/x86/boot/startup/sev-s=
hared.c
index 00220d7..fb86f03 100644
--- a/arch/x86/boot/startup/sev-shared.c
+++ b/arch/x86/boot/startup/sev-shared.c
@@ -602,7 +602,8 @@ static int __head svsm_call_msr_protocol(struct svsm_call=
 *call)
 	return ret;
 }
=20
-static void __head svsm_pval_4k_page(unsigned long paddr, bool validate)
+static void __head svsm_pval_4k_page(unsigned long paddr, bool validate,
+				     struct svsm_ca *caa, u64 caa_pa)
 {
 	struct svsm_pvalidate_call *pc;
 	struct svsm_call call =3D {};
@@ -615,10 +616,10 @@ static void __head svsm_pval_4k_page(unsigned long padd=
r, bool validate)
 	 */
 	flags =3D native_local_irq_save();
=20
-	call.caa =3D svsm_get_caa();
+	call.caa =3D caa;
=20
 	pc =3D (struct svsm_pvalidate_call *)call.caa->svsm_buffer;
-	pc_pa =3D svsm_get_caa_pa() + offsetof(struct svsm_ca, svsm_buffer);
+	pc_pa =3D caa_pa + offsetof(struct svsm_ca, svsm_buffer);
=20
 	pc->num_entries =3D 1;
 	pc->cur_index   =3D 0;
@@ -644,12 +645,12 @@ static void __head svsm_pval_4k_page(unsigned long padd=
r, bool validate)
 }
=20
 static void __head pvalidate_4k_page(unsigned long vaddr, unsigned long padd=
r,
-				     bool validate)
+				     bool validate, struct svsm_ca *caa, u64 caa_pa)
 {
 	int ret;
=20
 	if (snp_vmpl) {
-		svsm_pval_4k_page(paddr, validate);
+		svsm_pval_4k_page(paddr, validate, caa, caa_pa);
 	} else {
 		ret =3D pvalidate(vaddr, RMP_PG_SIZE_4K, validate);
 		if (ret)
@@ -665,7 +666,7 @@ static void __head pvalidate_4k_page(unsigned long vaddr,=
 unsigned long paddr,
 }
=20
 static void __head __page_state_change(unsigned long vaddr, unsigned long pa=
ddr,
-				       enum psc_op op)
+				       const struct psc_desc *desc)
 {
 	u64 val, msr;
=20
@@ -673,14 +674,14 @@ static void __head __page_state_change(unsigned long va=
ddr, unsigned long paddr,
 	 * If private -> shared then invalidate the page before requesting the
 	 * state change in the RMP table.
 	 */
-	if (op =3D=3D SNP_PAGE_STATE_SHARED)
-		pvalidate_4k_page(vaddr, paddr, false);
+	if (desc->op =3D=3D SNP_PAGE_STATE_SHARED)
+		pvalidate_4k_page(vaddr, paddr, false, desc->ca, desc->caa_pa);
=20
 	/* Save the current GHCB MSR value */
 	msr =3D sev_es_rd_ghcb_msr();
=20
 	/* Issue VMGEXIT to change the page state in RMP table. */
-	sev_es_wr_ghcb_msr(GHCB_MSR_PSC_REQ_GFN(paddr >> PAGE_SHIFT, op));
+	sev_es_wr_ghcb_msr(GHCB_MSR_PSC_REQ_GFN(paddr >> PAGE_SHIFT, desc->op));
 	VMGEXIT();
=20
 	/* Read the response of the VMGEXIT. */
@@ -695,8 +696,8 @@ static void __head __page_state_change(unsigned long vadd=
r, unsigned long paddr,
 	 * Now that page state is changed in the RMP table, validate it so that it =
is
 	 * consistent with the RMP entry.
 	 */
-	if (op =3D=3D SNP_PAGE_STATE_PRIVATE)
-		pvalidate_4k_page(vaddr, paddr, true);
+	if (desc->op =3D=3D SNP_PAGE_STATE_PRIVATE)
+		pvalidate_4k_page(vaddr, paddr, true, desc->ca, desc->caa_pa);
 }
=20
 /*
diff --git a/arch/x86/boot/startup/sev-startup.c b/arch/x86/boot/startup/sev-=
startup.c
index 5eb7d93..8009a37 100644
--- a/arch/x86/boot/startup/sev-startup.c
+++ b/arch/x86/boot/startup/sev-startup.c
@@ -132,7 +132,7 @@ noinstr void __sev_put_ghcb(struct ghcb_state *state)
=20
 void __head
 early_set_pages_state(unsigned long vaddr, unsigned long paddr,
-		      unsigned long npages, enum psc_op op)
+		      unsigned long npages, const struct psc_desc *desc)
 {
 	unsigned long paddr_end;
=20
@@ -142,7 +142,7 @@ early_set_pages_state(unsigned long vaddr, unsigned long =
paddr,
 	paddr_end =3D paddr + (npages << PAGE_SHIFT);
=20
 	while (paddr < paddr_end) {
-		__page_state_change(vaddr, paddr, op);
+		__page_state_change(vaddr, paddr, desc);
=20
 		vaddr +=3D PAGE_SIZE;
 		paddr +=3D PAGE_SIZE;
@@ -152,6 +152,10 @@ early_set_pages_state(unsigned long vaddr, unsigned long=
 paddr,
 void __head early_snp_set_memory_private(unsigned long vaddr, unsigned long =
paddr,
 					 unsigned long npages)
 {
+	struct psc_desc d =3D {
+		SNP_PAGE_STATE_PRIVATE, svsm_get_caa(), svsm_get_caa_pa()
+	};
+
 	/*
 	 * This can be invoked in early boot while running identity mapped, so
 	 * use an open coded check for SNP instead of using cc_platform_has().
@@ -165,12 +169,16 @@ void __head early_snp_set_memory_private(unsigned long =
vaddr, unsigned long padd
 	  * Ask the hypervisor to mark the memory pages as private in the RMP
 	  * table.
 	  */
-	early_set_pages_state(vaddr, paddr, npages, SNP_PAGE_STATE_PRIVATE);
+	early_set_pages_state(vaddr, paddr, npages, &d);
 }
=20
 void __head early_snp_set_memory_shared(unsigned long vaddr, unsigned long p=
addr,
 					unsigned long npages)
 {
+	struct psc_desc d =3D {
+		SNP_PAGE_STATE_SHARED, svsm_get_caa(), svsm_get_caa_pa()
+	};
+
 	/*
 	 * This can be invoked in early boot while running identity mapped, so
 	 * use an open coded check for SNP instead of using cc_platform_has().
@@ -181,7 +189,7 @@ void __head early_snp_set_memory_shared(unsigned long vad=
dr, unsigned long paddr
 		return;
=20
 	 /* Ask hypervisor to mark the memory pages shared in the RMP table. */
-	early_set_pages_state(vaddr, paddr, npages, SNP_PAGE_STATE_SHARED);
+	early_set_pages_state(vaddr, paddr, npages, &d);
 }
=20
 /*
diff --git a/arch/x86/coco/sev/core.c b/arch/x86/coco/sev/core.c
index ff1e2be..a833b2b 100644
--- a/arch/x86/coco/sev/core.c
+++ b/arch/x86/coco/sev/core.c
@@ -607,8 +607,11 @@ static void set_pages_state(unsigned long vaddr, unsigne=
d long npages, int op)
 	unsigned long vaddr_end;
=20
 	/* Use the MSR protocol when a GHCB is not available. */
-	if (!boot_ghcb)
-		return early_set_pages_state(vaddr, __pa(vaddr), npages, op);
+	if (!boot_ghcb) {
+		struct psc_desc d =3D { op, svsm_get_caa(), svsm_get_caa_pa() };
+
+		return early_set_pages_state(vaddr, __pa(vaddr), npages, &d);
+	}
=20
 	vaddr =3D vaddr & PAGE_MASK;
 	vaddr_end =3D vaddr + (npages << PAGE_SHIFT);
diff --git a/arch/x86/include/asm/sev-internal.h b/arch/x86/include/asm/sev-i=
nternal.h
index ffe4755..9ff8245 100644
--- a/arch/x86/include/asm/sev-internal.h
+++ b/arch/x86/include/asm/sev-internal.h
@@ -55,7 +55,7 @@ DECLARE_PER_CPU(struct sev_es_runtime_data*, runtime_data);
 DECLARE_PER_CPU(struct sev_es_save_area *, sev_vmsa);
=20
 void early_set_pages_state(unsigned long vaddr, unsigned long paddr,
-			   unsigned long npages, enum psc_op op);
+			   unsigned long npages, const struct psc_desc *desc);
=20
 DECLARE_PER_CPU(struct svsm_ca *, svsm_caa);
 DECLARE_PER_CPU(u64, svsm_caa_pa);
diff --git a/arch/x86/include/asm/sev.h b/arch/x86/include/asm/sev.h
index 92b1269..0030c71 100644
--- a/arch/x86/include/asm/sev.h
+++ b/arch/x86/include/asm/sev.h
@@ -570,6 +570,12 @@ extern u16 ghcb_version;
 extern struct ghcb *boot_ghcb;
 extern bool sev_snp_needs_sfw;
=20
+struct psc_desc {
+	enum psc_op op;
+	struct svsm_ca *ca;
+	u64 caa_pa;
+};
+
 #else	/* !CONFIG_AMD_MEM_ENCRYPT */
=20
 #define snp_vmpl 0

