Return-Path: <linux-tip-commits+bounces-6459-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 33C28B439D0
	for <lists+linux-tip-commits@lfdr.de>; Thu,  4 Sep 2025 13:22:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B79693A1CE1
	for <lists+linux-tip-commits@lfdr.de>; Thu,  4 Sep 2025 11:21:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 981902FC02F;
	Thu,  4 Sep 2025 11:20:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="vWnS2ONH";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="OUyDRsIx"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 513162FD7D3;
	Thu,  4 Sep 2025 11:20:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756984852; cv=none; b=MqXH1TymJ/zIeIno53HXrnMtCkDTC41kCxWWvWUNmFKAZvjQ/OQHNTBPFVKuFb68EVkAvSX9TFZkFyYf4JDL03qwstpIONBu1UxO4ayNzH77UgVrVuz53WnGYJuamKHAJijHu+GyGEFHrtEJWZ65mmDv27InjNLgs5Er2zEk6mY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756984852; c=relaxed/simple;
	bh=KqfYgkrj9Jil4rk9ug35lzYfsdM8CdbEGrEEVhAcPfc=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=GeJds17ODnnfvF0VF0nRRMMS6wtO+Yp8mVTXtkEvcbHk2Uz3f2HEM1GFJc3l8GUEcFNoj7vUyqYOSz+Y8sBQVxCKBM132LJ6J/0oOgnoBRkSWC8e3h1/ZvXv0B/o8gHRZSvw/oKPB2NSlbN2RMzvTgx25jP2J2Y2X8fgJqBAhAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=vWnS2ONH; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=OUyDRsIx; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 04 Sep 2025 11:20:46 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1756984848;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9pIxiWtOKALGXrEgQfHyijzDrybGy3o9I7MAvK11K8s=;
	b=vWnS2ONHCU91Eq2q34jXCwgzqttu7jFHXwjQBzp/YdL6mDetDVu0mE6oweHapM016iHOdt
	U6BZeEhGJrBIDKVCTKQa5lh6P2RNu/vFOpsBpVo6k7kbiuWfk+67nikpZvya6uWOQ+bEdl
	C2vvO6vdiEepAVWDyD73JzP280nUz0B2sZUQwZYNaHSLFGB/qz/8XfBLGwgp+XKL0Le//R
	wHxstsF4AN7vjUCxvPH5k8H+wi3SyBDMKVfNDFXatxgJUL2ch7dzuABfOB52iPTG8R6Au2
	oazYvinFx8ypoZYkAF5zbdVOofi8NDxAwjtNaw5ZA/74r+vI6jMBdwuWj+VfwQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1756984848;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9pIxiWtOKALGXrEgQfHyijzDrybGy3o9I7MAvK11K8s=;
	b=OUyDRsIx0jqtI2Q5QmsPdS1zE5iE9SEQrhbMV16OIBizNMIgzVnAJTYaaq3qplF320vqRv
	MBt8OIlNv9mNxiCQ==
From: "tip-bot2 for Ard Biesheuvel" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/sev] x86/boot: Move startup code out of __head section
Cc: kernel test robot <oliver.sang@intel.com>,
 Ard Biesheuvel <ardb@kernel.org>, "Borislav Petkov (AMD)" <bp@alien8.de>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250828102202.1849035-45-ardb+git@google.com>
References: <20250828102202.1849035-45-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175698484697.1920.3925477624200038682.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the x86/sev branch of tip:

Commit-ID:     c5c30a37369313d1f8b84e96e6a4397b4e2b4eb8
Gitweb:        https://git.kernel.org/tip/c5c30a37369313d1f8b84e96e6a4397b4e2=
b4eb8
Author:        Ard Biesheuvel <ardb@kernel.org>
AuthorDate:    Thu, 28 Aug 2025 12:22:24 +02:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Wed, 03 Sep 2025 18:06:04 +02:00

x86/boot: Move startup code out of __head section

Move startup code out of the __head section, now that this no longer has
a special significance. Move everything into .text or .init.text as
appropriate, so that startup code is not kept around unnecessarily.

  [ bp: Fold in hunk to fix 32-bit CPU hotplug:
    Reported-by: kernel test robot <oliver.sang@intel.com>
    Closes: https://lore.kernel.org/oe-lkp/202509022207.56fd97f4-lkp@intel.co=
m ]

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://lore.kernel.org/20250828102202.1849035-45-ardb+git@google.com
---
 arch/x86/boot/compressed/sev.c      |  3 +--
 arch/x86/boot/startup/gdt_idt.c     |  4 +--
 arch/x86/boot/startup/map_kernel.c  |  4 +--
 arch/x86/boot/startup/sev-shared.c  | 36 ++++++++++++++--------------
 arch/x86/boot/startup/sev-startup.c | 14 +++++------
 arch/x86/boot/startup/sme.c         | 26 ++++++++++----------
 arch/x86/include/asm/init.h         |  6 +-----
 arch/x86/kernel/head_32.S           |  5 +++-
 arch/x86/kernel/head_64.S           |  2 +-
 arch/x86/platform/pvh/head.S        |  2 +-
 10 files changed, 48 insertions(+), 54 deletions(-)

diff --git a/arch/x86/boot/compressed/sev.c b/arch/x86/boot/compressed/sev.c
index a5e002f..57670c1 100644
--- a/arch/x86/boot/compressed/sev.c
+++ b/arch/x86/boot/compressed/sev.c
@@ -32,9 +32,6 @@ struct ghcb *boot_ghcb;
 #undef __init
 #define __init
=20
-#undef __head
-#define __head
-
 #define __BOOT_COMPRESSED
=20
 u8 snp_vmpl;
diff --git a/arch/x86/boot/startup/gdt_idt.c b/arch/x86/boot/startup/gdt_idt.c
index a3112a6..d16102a 100644
--- a/arch/x86/boot/startup/gdt_idt.c
+++ b/arch/x86/boot/startup/gdt_idt.c
@@ -24,7 +24,7 @@
 static gate_desc bringup_idt_table[NUM_EXCEPTION_VECTORS] __page_aligned_dat=
a;
=20
 /* This may run while still in the direct mapping */
-void __head startup_64_load_idt(void *vc_handler)
+void startup_64_load_idt(void *vc_handler)
 {
 	struct desc_ptr desc =3D {
 		.address =3D (unsigned long)rip_rel_ptr(bringup_idt_table),
@@ -46,7 +46,7 @@ void __head startup_64_load_idt(void *vc_handler)
 /*
  * Setup boot CPU state needed before kernel switches to virtual addresses.
  */
-void __head startup_64_setup_gdt_idt(void)
+void __init startup_64_setup_gdt_idt(void)
 {
 	struct gdt_page *gp =3D rip_rel_ptr((void *)(__force unsigned long)&gdt_pag=
e);
 	void *handler =3D NULL;
diff --git a/arch/x86/boot/startup/map_kernel.c b/arch/x86/boot/startup/map_k=
ernel.c
index 332dbe6..83ba98d 100644
--- a/arch/x86/boot/startup/map_kernel.c
+++ b/arch/x86/boot/startup/map_kernel.c
@@ -30,7 +30,7 @@ static inline bool check_la57_support(void)
 	return true;
 }
=20
-static unsigned long __head sme_postprocess_startup(struct boot_params *bp,
+static unsigned long __init sme_postprocess_startup(struct boot_params *bp,
 						    pmdval_t *pmd,
 						    unsigned long p2v_offset)
 {
@@ -84,7 +84,7 @@ static unsigned long __head sme_postprocess_startup(struct =
boot_params *bp,
  * the 1:1 mapping of memory. Kernel virtual addresses can be determined by
  * subtracting p2v_offset from the RIP-relative address.
  */
-unsigned long __head __startup_64(unsigned long p2v_offset,
+unsigned long __init __startup_64(unsigned long p2v_offset,
 				  struct boot_params *bp)
 {
 	pmd_t (*early_pgts)[PTRS_PER_PMD] =3D rip_rel_ptr(early_dynamic_pgts);
diff --git a/arch/x86/boot/startup/sev-shared.c b/arch/x86/boot/startup/sev-s=
hared.c
index e09c668..08cc156 100644
--- a/arch/x86/boot/startup/sev-shared.c
+++ b/arch/x86/boot/startup/sev-shared.c
@@ -33,7 +33,7 @@ static u32 cpuid_ext_range_max __ro_after_init;
=20
 bool sev_snp_needs_sfw;
=20
-void __head __noreturn
+void __noreturn
 sev_es_terminate(unsigned int set, unsigned int reason)
 {
 	u64 val =3D GHCB_MSR_TERM_REQ;
@@ -52,7 +52,7 @@ sev_es_terminate(unsigned int set, unsigned int reason)
 /*
  * The hypervisor features are available from GHCB version 2 onward.
  */
-u64 get_hv_features(void)
+u64 __init get_hv_features(void)
 {
 	u64 val;
=20
@@ -222,7 +222,7 @@ const struct snp_cpuid_table *snp_cpuid_get_table(void)
  *
  * Return: XSAVE area size on success, 0 otherwise.
  */
-static u32 __head snp_cpuid_calc_xsave_size(u64 xfeatures_en, bool compacted)
+static u32 snp_cpuid_calc_xsave_size(u64 xfeatures_en, bool compacted)
 {
 	const struct snp_cpuid_table *cpuid_table =3D snp_cpuid_get_table();
 	u64 xfeatures_found =3D 0;
@@ -258,7 +258,7 @@ static u32 __head snp_cpuid_calc_xsave_size(u64 xfeatures=
_en, bool compacted)
 	return xsave_size;
 }
=20
-static bool __head
+static bool
 snp_cpuid_get_validated_func(struct cpuid_leaf *leaf)
 {
 	const struct snp_cpuid_table *cpuid_table =3D snp_cpuid_get_table();
@@ -300,7 +300,7 @@ static void snp_cpuid_hv_msr(void *ctx, struct cpuid_leaf=
 *leaf)
 		sev_es_terminate(SEV_TERM_SET_LINUX, GHCB_TERM_CPUID_HV);
 }
=20
-static int __head
+static int
 snp_cpuid_postprocess(void (*cpuid_fn)(void *ctx, struct cpuid_leaf *leaf),
 		      void *ctx, struct cpuid_leaf *leaf)
 {
@@ -396,8 +396,8 @@ snp_cpuid_postprocess(void (*cpuid_fn)(void *ctx, struct =
cpuid_leaf *leaf),
  * Returns -EOPNOTSUPP if feature not enabled. Any other non-zero return val=
ue
  * should be treated as fatal by caller.
  */
-int __head snp_cpuid(void (*cpuid_fn)(void *ctx, struct cpuid_leaf *leaf),
-		     void *ctx, struct cpuid_leaf *leaf)
+int snp_cpuid(void (*cpuid_fn)(void *ctx, struct cpuid_leaf *leaf),
+	      void *ctx, struct cpuid_leaf *leaf)
 {
 	const struct snp_cpuid_table *cpuid_table =3D snp_cpuid_get_table();
=20
@@ -439,7 +439,7 @@ int __head snp_cpuid(void (*cpuid_fn)(void *ctx, struct c=
puid_leaf *leaf),
  * page yet, so it only supports the MSR based communication with the
  * hypervisor and only the CPUID exit-code.
  */
-void __head do_vc_no_ghcb(struct pt_regs *regs, unsigned long exit_code)
+void do_vc_no_ghcb(struct pt_regs *regs, unsigned long exit_code)
 {
 	unsigned int subfn =3D lower_bits(regs->cx, 32);
 	unsigned int fn =3D lower_bits(regs->ax, 32);
@@ -515,7 +515,7 @@ struct cc_setup_data {
  * Search for a Confidential Computing blob passed in as a setup_data entry
  * via the Linux Boot Protocol.
  */
-static __head
+static __init
 struct cc_blob_sev_info *find_cc_blob_setup_data(struct boot_params *bp)
 {
 	struct cc_setup_data *sd =3D NULL;
@@ -543,7 +543,7 @@ struct cc_blob_sev_info *find_cc_blob_setup_data(struct b=
oot_params *bp)
  * mapping needs to be updated in sync with all the changes to virtual memory
  * layout and related mapping facilities throughout the boot process.
  */
-static void __head setup_cpuid_table(const struct cc_blob_sev_info *cc_info)
+static void __init setup_cpuid_table(const struct cc_blob_sev_info *cc_info)
 {
 	const struct snp_cpuid_table *cpuid_table_fw, *cpuid_table;
 	int i;
@@ -571,7 +571,7 @@ static void __head setup_cpuid_table(const struct cc_blob=
_sev_info *cc_info)
 	}
 }
=20
-static int __head svsm_call_msr_protocol(struct svsm_call *call)
+static int svsm_call_msr_protocol(struct svsm_call *call)
 {
 	int ret;
=20
@@ -582,8 +582,8 @@ static int __head svsm_call_msr_protocol(struct svsm_call=
 *call)
 	return ret;
 }
=20
-static void __head svsm_pval_4k_page(unsigned long paddr, bool validate,
-				     struct svsm_ca *caa, u64 caa_pa)
+static void svsm_pval_4k_page(unsigned long paddr, bool validate,
+			      struct svsm_ca *caa, u64 caa_pa)
 {
 	struct svsm_pvalidate_call *pc;
 	struct svsm_call call =3D {};
@@ -624,8 +624,8 @@ static void __head svsm_pval_4k_page(unsigned long paddr,=
 bool validate,
 	native_local_irq_restore(flags);
 }
=20
-static void __head pvalidate_4k_page(unsigned long vaddr, unsigned long padd=
r,
-				     bool validate, struct svsm_ca *caa, u64 caa_pa)
+static void pvalidate_4k_page(unsigned long vaddr, unsigned long paddr,
+			      bool validate, struct svsm_ca *caa, u64 caa_pa)
 {
 	int ret;
=20
@@ -645,8 +645,8 @@ static void __head pvalidate_4k_page(unsigned long vaddr,=
 unsigned long paddr,
 		sev_evict_cache((void *)vaddr, 1);
 }
=20
-static void __head __page_state_change(unsigned long vaddr, unsigned long pa=
ddr,
-				       const struct psc_desc *desc)
+static void __page_state_change(unsigned long vaddr, unsigned long paddr,
+			        const struct psc_desc *desc)
 {
 	u64 val, msr;
=20
@@ -684,7 +684,7 @@ static void __head __page_state_change(unsigned long vadd=
r, unsigned long paddr,
  * Maintain the GPA of the SVSM Calling Area (CA) in order to utilize the SV=
SM
  * services needed when not running in VMPL0.
  */
-static bool __head svsm_setup_ca(const struct cc_blob_sev_info *cc_info,
+static bool __init svsm_setup_ca(const struct cc_blob_sev_info *cc_info,
 				 void *page)
 {
 	struct snp_secrets_page *secrets_page;
diff --git a/arch/x86/boot/startup/sev-startup.c b/arch/x86/boot/startup/sev-=
startup.c
index 9f4b4ca..39465a0 100644
--- a/arch/x86/boot/startup/sev-startup.c
+++ b/arch/x86/boot/startup/sev-startup.c
@@ -44,7 +44,7 @@
 /* Include code shared with pre-decompression boot stage */
 #include "sev-shared.c"
=20
-void __head
+void __init
 early_set_pages_state(unsigned long vaddr, unsigned long paddr,
 		      unsigned long npages, const struct psc_desc *desc)
 {
@@ -63,7 +63,7 @@ early_set_pages_state(unsigned long vaddr, unsigned long pa=
ddr,
 	}
 }
=20
-void __head early_snp_set_memory_private(unsigned long vaddr, unsigned long =
paddr,
+void __init early_snp_set_memory_private(unsigned long vaddr, unsigned long =
paddr,
 					 unsigned long npages)
 {
 	struct psc_desc d =3D {
@@ -88,7 +88,7 @@ void __head early_snp_set_memory_private(unsigned long vadd=
r, unsigned long padd
 	early_set_pages_state(vaddr, paddr, npages, &d);
 }
=20
-void __head early_snp_set_memory_shared(unsigned long vaddr, unsigned long p=
addr,
+void __init early_snp_set_memory_shared(unsigned long vaddr, unsigned long p=
addr,
 					unsigned long npages)
 {
 	struct psc_desc d =3D {
@@ -123,7 +123,7 @@ void __head early_snp_set_memory_shared(unsigned long vad=
dr, unsigned long paddr
  *
  * Scan for the blob in that order.
  */
-static __head struct cc_blob_sev_info *find_cc_blob(struct boot_params *bp)
+static struct cc_blob_sev_info *__init find_cc_blob(struct boot_params *bp)
 {
 	struct cc_blob_sev_info *cc_info;
=20
@@ -149,7 +149,7 @@ found_cc_info:
 	return cc_info;
 }
=20
-static __head void svsm_setup(struct cc_blob_sev_info *cc_info)
+static void __init svsm_setup(struct cc_blob_sev_info *cc_info)
 {
 	struct snp_secrets_page *secrets =3D (void *)cc_info->secrets_phys;
 	struct svsm_call call =3D {};
@@ -190,7 +190,7 @@ static __head void svsm_setup(struct cc_blob_sev_info *cc=
_info)
 	boot_svsm_caa_pa =3D pa;
 }
=20
-bool __head snp_init(struct boot_params *bp)
+bool __init snp_init(struct boot_params *bp)
 {
 	struct cc_blob_sev_info *cc_info;
=20
@@ -219,7 +219,7 @@ bool __head snp_init(struct boot_params *bp)
 	return true;
 }
=20
-void __head __noreturn snp_abort(void)
+void __init __noreturn snp_abort(void)
 {
 	sev_es_terminate(SEV_TERM_SET_GEN, GHCB_SNP_UNSUPPORTED);
 }
diff --git a/arch/x86/boot/startup/sme.c b/arch/x86/boot/startup/sme.c
index 52b98e7..2ddde90 100644
--- a/arch/x86/boot/startup/sme.c
+++ b/arch/x86/boot/startup/sme.c
@@ -91,7 +91,7 @@ struct sme_populate_pgd_data {
  */
 static char sme_workarea[2 * PMD_SIZE] __section(".init.scratch");
=20
-static void __head sme_clear_pgd(struct sme_populate_pgd_data *ppd)
+static void __init sme_clear_pgd(struct sme_populate_pgd_data *ppd)
 {
 	unsigned long pgd_start, pgd_end, pgd_size;
 	pgd_t *pgd_p;
@@ -106,7 +106,7 @@ static void __head sme_clear_pgd(struct sme_populate_pgd_=
data *ppd)
 	memset(pgd_p, 0, pgd_size);
 }
=20
-static pud_t __head *sme_prepare_pgd(struct sme_populate_pgd_data *ppd)
+static pud_t __init *sme_prepare_pgd(struct sme_populate_pgd_data *ppd)
 {
 	pgd_t *pgd;
 	p4d_t *p4d;
@@ -143,7 +143,7 @@ static pud_t __head *sme_prepare_pgd(struct sme_populate_=
pgd_data *ppd)
 	return pud;
 }
=20
-static void __head sme_populate_pgd_large(struct sme_populate_pgd_data *ppd)
+static void __init sme_populate_pgd_large(struct sme_populate_pgd_data *ppd)
 {
 	pud_t *pud;
 	pmd_t *pmd;
@@ -159,7 +159,7 @@ static void __head sme_populate_pgd_large(struct sme_popu=
late_pgd_data *ppd)
 	set_pmd(pmd, __pmd(ppd->paddr | ppd->pmd_flags));
 }
=20
-static void __head sme_populate_pgd(struct sme_populate_pgd_data *ppd)
+static void __init sme_populate_pgd(struct sme_populate_pgd_data *ppd)
 {
 	pud_t *pud;
 	pmd_t *pmd;
@@ -185,7 +185,7 @@ static void __head sme_populate_pgd(struct sme_populate_p=
gd_data *ppd)
 		set_pte(pte, __pte(ppd->paddr | ppd->pte_flags));
 }
=20
-static void __head __sme_map_range_pmd(struct sme_populate_pgd_data *ppd)
+static void __init __sme_map_range_pmd(struct sme_populate_pgd_data *ppd)
 {
 	while (ppd->vaddr < ppd->vaddr_end) {
 		sme_populate_pgd_large(ppd);
@@ -195,7 +195,7 @@ static void __head __sme_map_range_pmd(struct sme_populat=
e_pgd_data *ppd)
 	}
 }
=20
-static void __head __sme_map_range_pte(struct sme_populate_pgd_data *ppd)
+static void __init __sme_map_range_pte(struct sme_populate_pgd_data *ppd)
 {
 	while (ppd->vaddr < ppd->vaddr_end) {
 		sme_populate_pgd(ppd);
@@ -205,7 +205,7 @@ static void __head __sme_map_range_pte(struct sme_populat=
e_pgd_data *ppd)
 	}
 }
=20
-static void __head __sme_map_range(struct sme_populate_pgd_data *ppd,
+static void __init __sme_map_range(struct sme_populate_pgd_data *ppd,
 				   pmdval_t pmd_flags, pteval_t pte_flags)
 {
 	unsigned long vaddr_end;
@@ -229,22 +229,22 @@ static void __head __sme_map_range(struct sme_populate_=
pgd_data *ppd,
 	__sme_map_range_pte(ppd);
 }
=20
-static void __head sme_map_range_encrypted(struct sme_populate_pgd_data *ppd)
+static void __init sme_map_range_encrypted(struct sme_populate_pgd_data *ppd)
 {
 	__sme_map_range(ppd, PMD_FLAGS_ENC, PTE_FLAGS_ENC);
 }
=20
-static void __head sme_map_range_decrypted(struct sme_populate_pgd_data *ppd)
+static void __init sme_map_range_decrypted(struct sme_populate_pgd_data *ppd)
 {
 	__sme_map_range(ppd, PMD_FLAGS_DEC, PTE_FLAGS_DEC);
 }
=20
-static void __head sme_map_range_decrypted_wp(struct sme_populate_pgd_data *=
ppd)
+static void __init sme_map_range_decrypted_wp(struct sme_populate_pgd_data *=
ppd)
 {
 	__sme_map_range(ppd, PMD_FLAGS_DEC_WP, PTE_FLAGS_DEC_WP);
 }
=20
-static unsigned long __head sme_pgtable_calc(unsigned long len)
+static unsigned long __init sme_pgtable_calc(unsigned long len)
 {
 	unsigned long entries =3D 0, tables =3D 0;
=20
@@ -281,7 +281,7 @@ static unsigned long __head sme_pgtable_calc(unsigned lon=
g len)
 	return entries + tables;
 }
=20
-void __head sme_encrypt_kernel(struct boot_params *bp)
+void __init sme_encrypt_kernel(struct boot_params *bp)
 {
 	unsigned long workarea_start, workarea_end, workarea_len;
 	unsigned long execute_start, execute_end, execute_len;
@@ -485,7 +485,7 @@ void __head sme_encrypt_kernel(struct boot_params *bp)
 	native_write_cr3(__native_read_cr3());
 }
=20
-void __head sme_enable(struct boot_params *bp)
+void __init sme_enable(struct boot_params *bp)
 {
 	unsigned int eax, ebx, ecx, edx;
 	unsigned long feature_mask;
diff --git a/arch/x86/include/asm/init.h b/arch/x86/include/asm/init.h
index 5a68e9d..01ccdd1 100644
--- a/arch/x86/include/asm/init.h
+++ b/arch/x86/include/asm/init.h
@@ -2,12 +2,6 @@
 #ifndef _ASM_X86_INIT_H
 #define _ASM_X86_INIT_H
=20
-#if defined(CONFIG_CC_IS_CLANG) && CONFIG_CLANG_VERSION < 170000
-#define __head	__section(".head.text") __no_sanitize_undefined __no_stack_pr=
otector
-#else
-#define __head	__section(".head.text") __no_sanitize_undefined __no_kstack_e=
rase
-#endif
-
 struct x86_mapping_info {
 	void *(*alloc_pgt_page)(void *); /* allocate buf for page table */
 	void (*free_pgt_page)(void *, void *); /* free buf for page table */
diff --git a/arch/x86/kernel/head_32.S b/arch/x86/kernel/head_32.S
index 76743df..80ef5d3 100644
--- a/arch/x86/kernel/head_32.S
+++ b/arch/x86/kernel/head_32.S
@@ -61,7 +61,7 @@ RESERVE_BRK(pagetables, INIT_MAP_SIZE)
  * any particular GDT layout, because we load our own as soon as we
  * can.
  */
-__HEAD
+	__INIT
 SYM_CODE_START(startup_32)
 	movl pa(initial_stack),%ecx
 =09
@@ -136,6 +136,9 @@ SYM_CODE_END(startup_32)
  * If cpu hotplug is not supported then this code can go in init section
  * which will be freed later
  */
+#ifdef CONFIG_HOTPLUG_CPU
+       .text
+#endif
 SYM_FUNC_START(startup_32_smp)
 	cld
 	movl $(__BOOT_DS),%eax
diff --git a/arch/x86/kernel/head_64.S b/arch/x86/kernel/head_64.S
index d219963..21816b4 100644
--- a/arch/x86/kernel/head_64.S
+++ b/arch/x86/kernel/head_64.S
@@ -33,7 +33,7 @@
  * because we need identity-mapped pages.
  */
=20
-	__HEAD
+	__INIT
 	.code64
 SYM_CODE_START_NOALIGN(startup_64)
 	UNWIND_HINT_END_OF_STACK
diff --git a/arch/x86/platform/pvh/head.S b/arch/x86/platform/pvh/head.S
index 1d78e56..344030c 100644
--- a/arch/x86/platform/pvh/head.S
+++ b/arch/x86/platform/pvh/head.S
@@ -24,7 +24,7 @@
 #include <asm/nospec-branch.h>
 #include <xen/interface/elfnote.h>
=20
-	__HEAD
+	__INIT
=20
 /*
  * Entry point for PVH guests.

