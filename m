Return-Path: <linux-tip-commits+bounces-6474-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 21DF0B439F0
	for <lists+linux-tip-commits@lfdr.de>; Thu,  4 Sep 2025 13:25:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B37817C6042
	for <lists+linux-tip-commits@lfdr.de>; Thu,  4 Sep 2025 11:24:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6681F304BC4;
	Thu,  4 Sep 2025 11:21:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="vgyvdsVO";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="oxvLcBGV"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39CF8303CA1;
	Thu,  4 Sep 2025 11:21:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756984869; cv=none; b=SQ7vULNbpQUie6VyDmO6sk8cxO7KrI4U20QWq4LjFVfeV5ueTZukzUKfAfW65qIPQbJOzDOKSw2VtoyY5aSp4FAVQpHer0UZevSVTkq5Tznvs5zGZ9LcmmGY9yzbDvBCCsOdkAzw+9uDXWLWojb33vVF84d4+n+s+OpQAv+g7G0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756984869; c=relaxed/simple;
	bh=UJB1DNjRxf0Pam9JOjW6hliSjd9XK0Jo+SPvH6UJlCQ=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=TFoWuOkD43IXhPxAJoEbLv4moqmYB8kUADkPoxWgPUBeCLwCPyob99DhsstypugLnb2bRkT4j2mV1hWq7NjeOJom2tqV4eww3QOKJVnbJ+9ijm0hqS2wft8H9BYd0Cng0alrAHS6FIlUl03iZhQ11/jh+6q7AHC0BxVJ8bOXF4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=vgyvdsVO; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=oxvLcBGV; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 04 Sep 2025 11:21:04 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1756984865;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vn+4gxSJgwb4G66Q1GA5y//fDSDTlucexaHknKU72Nw=;
	b=vgyvdsVOmM1MA23xOmRbRr8MW0yXDlffr4snjN9d7OEikCanVmWD0DceyuCNtVF8zpHER3
	KrLwNf5xqRIYtGOZT/6jNXHETp0qwhhCnrByb9cfMwwdPJXegt31TyT08UBKqTxoGMDa2W
	p0zr5gVgAQX1JHmVJd1ggqrzC8T6mYb4zqfwbqbGdZAtZuh35IX7C10dLxc+YM1VIzCt1i
	ILaN/vrl1toetq8rTB+kSp30w0lAP5FZuMdPiUub9ZzRyE2g/UX51xrtiNYqQV+jPUMvqy
	7FJfjz/0Hh8VrVzCyiCj2Vcy2lHTAWy9wQhoZz09OjWs1oqy0Ue2BLBCCMDkMQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1756984865;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vn+4gxSJgwb4G66Q1GA5y//fDSDTlucexaHknKU72Nw=;
	b=oxvLcBGV3RKXmLoL+aIqK0geuy0mczps8EmuMaUHxXb+09XEfcxA4cFA7BACdX6tGZIjJO
	Q2Pg5f7dkroJ0TCw==
From: "tip-bot2 for Ard Biesheuvel" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/sev] x86/sev: Avoid global variable to store virtual
 address of SVSM area
Cc: Ard Biesheuvel <ardb@kernel.org>, "Borislav Petkov (AMD)" <bp@alien8.de>,
 Tom Lendacky <thomas.lendacky@amd.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250828102202.1849035-30-ardb+git@google.com>
References: <20250828102202.1849035-30-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175698486430.1920.14369223103809104787.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the x86/sev branch of tip:

Commit-ID:     a5f03880f06a6da6ea5f1d966fffffcb3fc65462
Gitweb:        https://git.kernel.org/tip/a5f03880f06a6da6ea5f1d966fffffcb3fc=
65462
Author:        Ard Biesheuvel <ardb@kernel.org>
AuthorDate:    Thu, 28 Aug 2025 12:22:09 +02:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Wed, 03 Sep 2025 17:58:15 +02:00

x86/sev: Avoid global variable to store virtual address of SVSM area

The boottime SVSM calling area is used both by the startup code running from
a 1:1 mapping, and potentially later on running from the ordinary kernel
mapping.

This SVSM calling area is statically allocated, and so its physical address
doesn't change. However, its virtual address depends on the calling context
(1:1 mapping or kernel virtual mapping), and even though the variable that
holds the virtual address of this calling area gets updated from 1:1 address
to kernel address during the boot, it is hard to reason about why this is
guaranteed to be safe.

So instead, take the RIP-relative address of the boottime SVSM calling area
whenever its virtual address is required, and only use a global variable for
the physical address.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Tom Lendacky <thomas.lendacky@amd.com>
Link: https://lore.kernel.org/20250828102202.1849035-30-ardb+git@google.com
---
 arch/x86/boot/compressed/sev.c      |  5 ++---
 arch/x86/boot/startup/sev-shared.c  |  7 +------
 arch/x86/boot/startup/sev-startup.c |  9 +++++----
 arch/x86/coco/sev/core.c            |  9 ---------
 arch/x86/include/asm/sev-internal.h |  3 +--
 arch/x86/include/asm/sev.h          |  2 --
 arch/x86/mm/mem_encrypt_amd.c       |  6 ------
 7 files changed, 9 insertions(+), 32 deletions(-)

diff --git a/arch/x86/boot/compressed/sev.c b/arch/x86/boot/compressed/sev.c
index f197173..f2b8dfb 100644
--- a/arch/x86/boot/compressed/sev.c
+++ b/arch/x86/boot/compressed/sev.c
@@ -37,12 +37,12 @@ struct ghcb *boot_ghcb;
=20
 #define __BOOT_COMPRESSED
=20
-extern struct svsm_ca *boot_svsm_caa;
 extern u64 boot_svsm_caa_pa;
=20
 struct svsm_ca *svsm_get_caa(void)
 {
-	return boot_svsm_caa;
+	/* The decompressor is mapped 1:1 so VA =3D=3D PA */
+	return (struct svsm_ca *)boot_svsm_caa_pa;
 }
=20
 u64 svsm_get_caa_pa(void)
@@ -532,7 +532,6 @@ bool early_is_sevsnp_guest(void)
=20
 			/* Obtain the address of the calling area to use */
 			boot_rdmsr(MSR_SVSM_CAA, &m);
-			boot_svsm_caa =3D (void *)m.q;
 			boot_svsm_caa_pa =3D m.q;
=20
 			/*
diff --git a/arch/x86/boot/startup/sev-shared.c b/arch/x86/boot/startup/sev-s=
hared.c
index 348811a..80d4fda 100644
--- a/arch/x86/boot/startup/sev-shared.c
+++ b/arch/x86/boot/startup/sev-shared.c
@@ -13,6 +13,7 @@
=20
 #ifndef __BOOT_COMPRESSED
 #define error(v)			pr_err(v)
+#define has_cpuflag(f)			boot_cpu_has(f)
 #else
 #undef WARN
 #define WARN(condition, format...) (!!(condition))
@@ -26,7 +27,6 @@
  *   early boot, both with identity mapped virtual addresses and proper kern=
el
  *   virtual addresses.
  */
-struct svsm_ca *boot_svsm_caa __ro_after_init;
 u64 boot_svsm_caa_pa __ro_after_init;
=20
 /*
@@ -720,11 +720,6 @@ static bool __head svsm_setup_ca(const struct cc_blob_se=
v_info *cc_info,
 	if (caa & (PAGE_SIZE - 1))
 		sev_es_terminate(SEV_TERM_SET_LINUX, GHCB_TERM_SVSM_CAA);
=20
-	/*
-	 * The CA is identity mapped when this routine is called, both by the
-	 * decompressor code and the early kernel code.
-	 */
-	boot_svsm_caa =3D (struct svsm_ca *)caa;
 	boot_svsm_caa_pa =3D caa;
=20
 	/* Advertise the SVSM presence via CPUID. */
diff --git a/arch/x86/boot/startup/sev-startup.c b/arch/x86/boot/startup/sev-=
startup.c
index fd18a00..8a06f60 100644
--- a/arch/x86/boot/startup/sev-startup.c
+++ b/arch/x86/boot/startup/sev-startup.c
@@ -252,6 +252,7 @@ found_cc_info:
=20
 static __head void svsm_setup(struct cc_blob_sev_info *cc_info)
 {
+	struct snp_secrets_page *secrets =3D (void *)cc_info->secrets_phys;
 	struct svsm_call call =3D {};
 	u64 pa;
=20
@@ -272,21 +273,21 @@ static __head void svsm_setup(struct cc_blob_sev_info *=
cc_info)
 	pa =3D (u64)rip_rel_ptr(&boot_svsm_ca_page);
=20
 	/*
-	 * Switch over to the boot SVSM CA while the current CA is still
-	 * addressable. There is no GHCB at this point so use the MSR protocol.
+	 * Switch over to the boot SVSM CA while the current CA is still 1:1
+	 * mapped and thus addressable with VA =3D=3D PA. There is no GHCB at this
+	 * point so use the MSR protocol.
 	 *
 	 * SVSM_CORE_REMAP_CA call:
 	 *   RAX =3D 0 (Protocol=3D0, CallID=3D0)
 	 *   RCX =3D New CA GPA
 	 */
-	call.caa =3D svsm_get_caa();
+	call.caa =3D (struct svsm_ca *)secrets->svsm_caa;
 	call.rax =3D SVSM_CORE_CALL(SVSM_CORE_REMAP_CA);
 	call.rcx =3D pa;
=20
 	if (svsm_call_msr_protocol(&call))
 		sev_es_terminate(SEV_TERM_SET_LINUX, GHCB_TERM_SVSM_CA_REMAP_FAIL);
=20
-	boot_svsm_caa =3D (struct svsm_ca *)pa;
 	boot_svsm_caa_pa =3D pa;
 }
=20
diff --git a/arch/x86/coco/sev/core.c b/arch/x86/coco/sev/core.c
index 2a28d14..ff1e2be 100644
--- a/arch/x86/coco/sev/core.c
+++ b/arch/x86/coco/sev/core.c
@@ -1666,15 +1666,6 @@ void sev_show_status(void)
 	pr_cont("\n");
 }
=20
-void __init snp_update_svsm_ca(void)
-{
-	if (!snp_vmpl)
-		return;
-
-	/* Update the CAA to a proper kernel address */
-	boot_svsm_caa =3D &boot_svsm_ca_page;
-}
-
 #ifdef CONFIG_SYSFS
 static ssize_t vmpl_show(struct kobject *kobj,
 			 struct kobj_attribute *attr, char *buf)
diff --git a/arch/x86/include/asm/sev-internal.h b/arch/x86/include/asm/sev-i=
nternal.h
index 6199b35..ffe4755 100644
--- a/arch/x86/include/asm/sev-internal.h
+++ b/arch/x86/include/asm/sev-internal.h
@@ -60,7 +60,6 @@ void early_set_pages_state(unsigned long vaddr, unsigned lo=
ng paddr,
 DECLARE_PER_CPU(struct svsm_ca *, svsm_caa);
 DECLARE_PER_CPU(u64, svsm_caa_pa);
=20
-extern struct svsm_ca *boot_svsm_caa;
 extern u64 boot_svsm_caa_pa;
=20
 static __always_inline struct svsm_ca *svsm_get_caa(void)
@@ -68,7 +67,7 @@ static __always_inline struct svsm_ca *svsm_get_caa(void)
 	if (sev_cfg.use_cas)
 		return this_cpu_read(svsm_caa);
 	else
-		return boot_svsm_caa;
+		return rip_rel_ptr(&boot_svsm_ca_page);
 }
=20
 static __always_inline u64 svsm_get_caa_pa(void)
diff --git a/arch/x86/include/asm/sev.h b/arch/x86/include/asm/sev.h
index be9d7cb..92b1269 100644
--- a/arch/x86/include/asm/sev.h
+++ b/arch/x86/include/asm/sev.h
@@ -519,7 +519,6 @@ void snp_accept_memory(phys_addr_t start, phys_addr_t end=
);
 u64 snp_get_unsupported_features(u64 status);
 u64 sev_get_status(void);
 void sev_show_status(void);
-void snp_update_svsm_ca(void);
 int prepare_pte_enc(struct pte_enc_desc *d);
 void set_pte_enc_mask(pte_t *kpte, unsigned long pfn, pgprot_t new_prot);
 void snp_kexec_finish(void);
@@ -601,7 +600,6 @@ static inline void snp_accept_memory(phys_addr_t start, p=
hys_addr_t end) { }
 static inline u64 snp_get_unsupported_features(u64 status) { return 0; }
 static inline u64 sev_get_status(void) { return 0; }
 static inline void sev_show_status(void) { }
-static inline void snp_update_svsm_ca(void) { }
 static inline int prepare_pte_enc(struct pte_enc_desc *d) { return 0; }
 static inline void set_pte_enc_mask(pte_t *kpte, unsigned long pfn, pgprot_t=
 new_prot) { }
 static inline void snp_kexec_finish(void) { }
diff --git a/arch/x86/mm/mem_encrypt_amd.c b/arch/x86/mm/mem_encrypt_amd.c
index faf3a13..2f8c321 100644
--- a/arch/x86/mm/mem_encrypt_amd.c
+++ b/arch/x86/mm/mem_encrypt_amd.c
@@ -536,12 +536,6 @@ void __init sme_early_init(void)
 		x86_init.resources.dmi_setup =3D snp_dmi_setup;
 	}
=20
-	/*
-	 * Switch the SVSM CA mapping (if active) from identity mapped to
-	 * kernel mapped.
-	 */
-	snp_update_svsm_ca();
-
 	if (sev_status & MSR_AMD64_SNP_SECURE_TSC)
 		setup_force_cpu_cap(X86_FEATURE_TSC_RELIABLE);
 }

