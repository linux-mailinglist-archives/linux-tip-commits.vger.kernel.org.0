Return-Path: <linux-tip-commits+bounces-1444-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F6F990C858
	for <lists+linux-tip-commits@lfdr.de>; Tue, 18 Jun 2024 13:05:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 54C821C20C61
	for <lists+linux-tip-commits@lfdr.de>; Tue, 18 Jun 2024 11:05:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C70A4202C98;
	Tue, 18 Jun 2024 09:45:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="YuD8q3cQ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="jck2e2k1"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F0421FF834;
	Tue, 18 Jun 2024 09:45:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718703910; cv=none; b=DzkDldTKT31vRGkOcE8vbBwx65qZqtJtLs21146YICck3eScf7gGX3ZQkGhc22AVaDQQDD+WE2x1cMiCn4BNUTS1Zql7TKuMd0daZfKaLRrdxUEpO7cnJyoGyGh959ozJWI/0fxfLxjtlO9zp8nwK2KmaIhtSyhF+GIgtJou2XE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718703910; c=relaxed/simple;
	bh=PiC/LFYdSbJrqLZK1KqjiGdzS4G3UL43qRCaz/MpVds=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=mMaWsx7pUGTb7k2qU4FookJdxHJQ0MU37Oz2nvy65td6piMbtnJZD3yCp2h2NMJfZtHW1TeATNGsqYpcN1zzpRm7c48D/xukfiZkK8NnCtQ8epYLDtGb1AIAjIQ2err7zBoX9ZjrNl5li4IYczt0qQx/DHAcgK52okizqVmvgX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=YuD8q3cQ; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=jck2e2k1; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 18 Jun 2024 09:45:01 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1718703901;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3R+q9FngZEKE4lBhBl1xxCDxjoVSFXtrl/rSvfJYBQI=;
	b=YuD8q3cQ8+2ofox4p7/IE374p2IIqWTdNKPsoNMBuv/5aBegFUxwCnRZOzuTKWTuH3ZTm9
	+rPpvQK+rXjSequiggY/6kqmG8n4RRmEDffydWyKZxoG6uPg2sliqVP1+AY2BHmlQdhuVO
	O6tAH8BHOQIHBVXrF7ux0u7UFg9KgQswGhNQNgcEeWywKjwfHnSDFObDuAyTxHuGOnpgvC
	N3j0Bzc5EQIVFL+Rpl3YCyvld0rDxxvTPSOLYAPx7GoMeNZ+xOKidv8qSXpWwdqfcHN0p6
	1YtZ9Qu2dFm6ArWMNWjfbsYeWDG93u8pEn96mPbZDfd+Pjk90x92dIuFAirLuQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1718703901;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3R+q9FngZEKE4lBhBl1xxCDxjoVSFXtrl/rSvfJYBQI=;
	b=jck2e2k17iQt/kJyFCM3VYkowVcXr35aprTOhbQ9uCB9pn1RXt370yrudZ7US9YL5yOg7V
	4MJWdaF/EAt+DRCg==
From: "tip-bot2 for Tom Lendacky" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/sev] x86/sev: Check for the presence of an SVSM in the SNP
 secrets page
Cc: Tom Lendacky <thomas.lendacky@amd.com>,
 "Borislav Petkov (AMD)" <bp@alien8.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: =?utf-8?q?=3C9d3fe161be93d4ea60f43c2a3f2c311fe708b63b=2E17176?=
 =?utf-8?q?00736=2Egit=2Ethomas=2Elendacky=40amd=2Ecom=3E?=
References: =?utf-8?q?=3C9d3fe161be93d4ea60f43c2a3f2c311fe708b63b=2E171760?=
 =?utf-8?q?0736=2Egit=2Ethomas=2Elendacky=40amd=2Ecom=3E?=
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171870390101.10875.17029053659846887098.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/sev branch of tip:

Commit-ID:     878e70dbd26e234e6e6941dac3a233af6f632184
Gitweb:        https://git.kernel.org/tip/878e70dbd26e234e6e6941dac3a233af6f632184
Author:        Tom Lendacky <thomas.lendacky@amd.com>
AuthorDate:    Wed, 05 Jun 2024 10:18:45 -05:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Tue, 11 Jun 2024 07:22:46 +02:00

x86/sev: Check for the presence of an SVSM in the SNP secrets page

During early boot phases, check for the presence of an SVSM when running
as an SEV-SNP guest.

An SVSM is present if not running at VMPL0 and the 64-bit value at offset
0x148 into the secrets page is non-zero. If an SVSM is present, save the
SVSM Calling Area address (CAA), located at offset 0x150 into the secrets
page, and set the VMPL level of the guest, which should be non-zero, to
indicate the presence of an SVSM.

  [ bp: Touchups. ]

Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://lore.kernel.org/r/9d3fe161be93d4ea60f43c2a3f2c311fe708b63b.1717600736.git.thomas.lendacky@amd.com
---
 Documentation/arch/x86/amd-memory-encryption.rst | 29 +++++-
 arch/x86/boot/compressed/sev.c                   | 21 ++--
 arch/x86/include/asm/sev-common.h                |  4 +-
 arch/x86/include/asm/sev.h                       | 33 ++++++-
 arch/x86/kernel/sev-shared.c                     | 76 +++++++++++++++-
 arch/x86/kernel/sev.c                            |  7 +-
 6 files changed, 160 insertions(+), 10 deletions(-)

diff --git a/Documentation/arch/x86/amd-memory-encryption.rst b/Documentation/arch/x86/amd-memory-encryption.rst
index 414bc74..6df3264 100644
--- a/Documentation/arch/x86/amd-memory-encryption.rst
+++ b/Documentation/arch/x86/amd-memory-encryption.rst
@@ -130,4 +130,31 @@ SNP feature support.
 
 More details in AMD64 APM[1] Vol 2: 15.34.10 SEV_STATUS MSR
 
-[1] https://www.amd.com/content/dam/amd/en/documents/processor-tech-docs/programmer-references/24593.pdf
+Secure VM Service Module (SVSM)
+===============================
+SNP provides a feature called Virtual Machine Privilege Levels (VMPL) which
+defines four privilege levels at which guest software can run. The most
+privileged level is 0 and numerically higher numbers have lesser privileges.
+More details in the AMD64 APM Vol 2, section "15.35.7 Virtual Machine
+Privilege Levels", docID: 24593.
+
+When using that feature, different services can run at different protection
+levels, apart from the guest OS but still within the secure SNP environment.
+They can provide services to the guest, like a vTPM, for example.
+
+When a guest is not running at VMPL0, it needs to communicate with the software
+running at VMPL0 to perform privileged operations or to interact with secure
+services. An example fur such a privileged operation is PVALIDATE which is
+*required* to be executed at VMPL0.
+
+In this scenario, the software running at VMPL0 is usually called a Secure VM
+Service Module (SVSM). Discovery of an SVSM and the API used to communicate
+with it is documented in "Secure VM Service Module for SEV-SNP Guests", docID:
+58019.
+
+(Latest versions of the above-mentioned documents can be found by using
+a search engine like duckduckgo.com and typing in:
+
+  site:amd.com "Secure VM Service Module for SEV-SNP Guests", docID: 58019
+
+for example.)
diff --git a/arch/x86/boot/compressed/sev.c b/arch/x86/boot/compressed/sev.c
index 0457a9d..c65820b 100644
--- a/arch/x86/boot/compressed/sev.c
+++ b/arch/x86/boot/compressed/sev.c
@@ -463,6 +463,13 @@ static bool early_snp_init(struct boot_params *bp)
 	setup_cpuid_table(cc_info);
 
 	/*
+	 * Record the SVSM Calling Area (CA) address if the guest is not
+	 * running at VMPL0. The CA will be used to communicate with the
+	 * SVSM and request its services.
+	 */
+	svsm_setup_ca(cc_info);
+
+	/*
 	 * Pass run-time kernel a pointer to CC info via boot_params so EFI
 	 * config table doesn't need to be searched again during early startup
 	 * phase.
@@ -571,14 +578,12 @@ void sev_enable(struct boot_params *bp)
 		/*
 		 * Enforce running at VMPL0.
 		 *
-		 * RMPADJUST modifies RMP permissions of a lesser-privileged (numerically
-		 * higher) privilege level. Here, clear the VMPL1 permission mask of the
-		 * GHCB page. If the guest is not running at VMPL0, this will fail.
-		 *
-		 * If the guest is running at VMPL0, it will succeed. Even if that operation
-		 * modifies permission bits, it is still ok to do so currently because Linux
-		 * SNP guests running at VMPL0 only run at VMPL0, so VMPL1 or higher
-		 * permission mask changes are a don't-care.
+		 * Use RMPADJUST (see the rmpadjust() function for a description of
+		 * what the instruction does) to update the VMPL1 permissions of a
+		 * page. If the guest is running at VMPL0, this will succeed. If the
+		 * guest is running at any other VMPL, this will fail. Linux SNP guests
+		 * only ever run at a single VMPL level so permission mask changes of a
+		 * lesser-privileged VMPL are a don't-care.
 		 */
 		if (rmpadjust((unsigned long)&boot_ghcb_page, RMP_PG_SIZE_4K, 1))
 			sev_es_terminate(SEV_TERM_SET_LINUX, GHCB_TERM_NOT_VMPL0);
diff --git a/arch/x86/include/asm/sev-common.h b/arch/x86/include/asm/sev-common.h
index 5a8246d..d31f2ed 100644
--- a/arch/x86/include/asm/sev-common.h
+++ b/arch/x86/include/asm/sev-common.h
@@ -163,6 +163,10 @@ struct snp_psc_desc {
 #define GHCB_TERM_NOT_VMPL0		3	/* SNP guest is not running at VMPL-0 */
 #define GHCB_TERM_CPUID			4	/* CPUID-validation failure */
 #define GHCB_TERM_CPUID_HV		5	/* CPUID failure during hypervisor fallback */
+#define GHCB_TERM_SECRETS_PAGE		6	/* Secrets page failure */
+#define GHCB_TERM_NO_SVSM		7	/* SVSM is not advertised in the secrets page */
+#define GHCB_TERM_SVSM_VMPL0		8	/* SVSM is present but has set VMPL to 0 */
+#define GHCB_TERM_SVSM_CAA		9	/* SVSM is present but CAA is not page aligned */
 
 #define GHCB_RESP_CODE(v)		((v) & GHCB_MSR_INFO_MASK)
 
diff --git a/arch/x86/include/asm/sev.h b/arch/x86/include/asm/sev.h
index ca20cc4..2a44376 100644
--- a/arch/x86/include/asm/sev.h
+++ b/arch/x86/include/asm/sev.h
@@ -152,9 +152,32 @@ struct snp_secrets_page {
 	u8 vmpck2[VMPCK_KEY_LEN];
 	u8 vmpck3[VMPCK_KEY_LEN];
 	struct secrets_os_area os_area;
-	u8 rsvd3[3840];
+
+	u8 vmsa_tweak_bitmap[64];
+
+	/* SVSM fields */
+	u64 svsm_base;
+	u64 svsm_size;
+	u64 svsm_caa;
+	u32 svsm_max_version;
+	u8 svsm_guest_vmpl;
+	u8 rsvd3[3];
+
+	/* Remainder of page */
+	u8 rsvd4[3744];
 } __packed;
 
+/*
+ * The SVSM Calling Area (CA) related structures.
+ */
+struct svsm_ca {
+	u8 call_pending;
+	u8 mem_available;
+	u8 rsvd1[6];
+
+	u8 svsm_buffer[PAGE_SIZE - 8];
+};
+
 #ifdef CONFIG_AMD_MEM_ENCRYPT
 extern void __sev_es_ist_enter(struct pt_regs *regs);
 extern void __sev_es_ist_exit(void);
@@ -181,6 +204,14 @@ static __always_inline void sev_es_nmi_complete(void)
 extern int __init sev_es_efi_map_ghcbs(pgd_t *pgd);
 extern void sev_enable(struct boot_params *bp);
 
+/*
+ * RMPADJUST modifies the RMP permissions of a page of a lesser-
+ * privileged (numerically higher) VMPL.
+ *
+ * If the guest is running at a higher-privilege than the privilege
+ * level the instruction is targeting, the instruction will succeed,
+ * otherwise, it will fail.
+ */
 static inline int rmpadjust(unsigned long vaddr, bool rmp_psize, unsigned long attrs)
 {
 	int rc;
diff --git a/arch/x86/kernel/sev-shared.c b/arch/x86/kernel/sev-shared.c
index b4f8fa0..06a5078 100644
--- a/arch/x86/kernel/sev-shared.c
+++ b/arch/x86/kernel/sev-shared.c
@@ -23,6 +23,21 @@
 #define sev_printk_rtl(fmt, ...)
 #endif
 
+/*
+ * SVSM related information:
+ *   When running under an SVSM, the VMPL that Linux is executing at must be
+ *   non-zero. The VMPL is therefore used to indicate the presence of an SVSM.
+ *
+ *   During boot, the page tables are set up as identity mapped and later
+ *   changed to use kernel virtual addresses. Maintain separate virtual and
+ *   physical addresses for the CAA to allow SVSM functions to be used during
+ *   early boot, both with identity mapped virtual addresses and proper kernel
+ *   virtual addresses.
+ */
+static u8 snp_vmpl __ro_after_init;
+static struct svsm_ca *boot_svsm_caa __ro_after_init;
+static u64 boot_svsm_caa_pa __ro_after_init;
+
 /* I/O parameters for CPUID-related helpers */
 struct cpuid_leaf {
 	u32 fn;
@@ -1269,3 +1284,64 @@ static enum es_result vc_check_opcode_bytes(struct es_em_ctxt *ctxt,
 
 	return ES_UNSUPPORTED;
 }
+
+/*
+ * Maintain the GPA of the SVSM Calling Area (CA) in order to utilize the SVSM
+ * services needed when not running in VMPL0.
+ */
+static void __head svsm_setup_ca(const struct cc_blob_sev_info *cc_info)
+{
+	struct snp_secrets_page *secrets_page;
+	u64 caa;
+
+	BUILD_BUG_ON(sizeof(*secrets_page) != PAGE_SIZE);
+
+	/*
+	 * Check if running at VMPL0.
+	 *
+	 * Use RMPADJUST (see the rmpadjust() function for a description of what
+	 * the instruction does) to update the VMPL1 permissions of a page. If
+	 * the guest is running at VMPL0, this will succeed and implies there is
+	 * no SVSM. If the guest is running at any other VMPL, this will fail.
+	 * Linux SNP guests only ever run at a single VMPL level so permission mask
+	 * changes of a lesser-privileged VMPL are a don't-care.
+	 *
+	 * Use a rip-relative reference to obtain the proper address, since this
+	 * routine is running identity mapped when called, both by the decompressor
+	 * code and the early kernel code.
+	 */
+	if (!rmpadjust((unsigned long)&RIP_REL_REF(boot_ghcb_page), RMP_PG_SIZE_4K, 1))
+		return;
+
+	/*
+	 * Not running at VMPL0, ensure everything has been properly supplied
+	 * for running under an SVSM.
+	 */
+	if (!cc_info || !cc_info->secrets_phys || cc_info->secrets_len != PAGE_SIZE)
+		sev_es_terminate(SEV_TERM_SET_LINUX, GHCB_TERM_SECRETS_PAGE);
+
+	secrets_page = (struct snp_secrets_page *)cc_info->secrets_phys;
+	if (!secrets_page->svsm_size)
+		sev_es_terminate(SEV_TERM_SET_LINUX, GHCB_TERM_NO_SVSM);
+
+	if (!secrets_page->svsm_guest_vmpl)
+		sev_es_terminate(SEV_TERM_SET_LINUX, GHCB_TERM_SVSM_VMPL0);
+
+	RIP_REL_REF(snp_vmpl) = secrets_page->svsm_guest_vmpl;
+
+	caa = secrets_page->svsm_caa;
+
+	/*
+	 * An open-coded PAGE_ALIGNED() in order to avoid including
+	 * kernel-proper headers into the decompressor.
+	 */
+	if (caa & (PAGE_SIZE - 1))
+		sev_es_terminate(SEV_TERM_SET_LINUX, GHCB_TERM_SVSM_CAA);
+
+	/*
+	 * The CA is identity mapped when this routine is called, both by the
+	 * decompressor code and the early kernel code.
+	 */
+	RIP_REL_REF(boot_svsm_caa) = (struct svsm_ca *)caa;
+	RIP_REL_REF(boot_svsm_caa_pa) = caa;
+}
diff --git a/arch/x86/kernel/sev.c b/arch/x86/kernel/sev.c
index 3342ed5..36a117a 100644
--- a/arch/x86/kernel/sev.c
+++ b/arch/x86/kernel/sev.c
@@ -2109,6 +2109,13 @@ bool __head snp_init(struct boot_params *bp)
 	setup_cpuid_table(cc_info);
 
 	/*
+	 * Record the SVSM Calling Area address (CAA) if the guest is not
+	 * running at VMPL0. The CA will be used to communicate with the
+	 * SVSM to perform the SVSM services.
+	 */
+	svsm_setup_ca(cc_info);
+
+	/*
 	 * The CC blob will be used later to access the secrets page. Cache
 	 * it here like the boot kernel does.
 	 */

