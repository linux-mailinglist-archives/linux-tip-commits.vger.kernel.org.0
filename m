Return-Path: <linux-tip-commits+bounces-5093-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D3D8DA96419
	for <lists+linux-tip-commits@lfdr.de>; Tue, 22 Apr 2025 11:22:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0E15516936B
	for <lists+linux-tip-commits@lfdr.de>; Tue, 22 Apr 2025 09:22:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 806AA1F4C90;
	Tue, 22 Apr 2025 09:22:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Vpb0t38f";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="GXzyRDB2"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69F771E22FC;
	Tue, 22 Apr 2025 09:22:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745313757; cv=none; b=KK14UzylaWDTrfE+U8zYnTr0W0sLRBtdKDxCuvVpJFhF+8ZFYpsvx3aYirVtPVqnuuJe6TuLUnNhYqan2VxrwjdPEi8aemkw3d1JBvLivAXDeXLp6YeMxpNYhTj8pe5LMESmH+qMoocGFU7zOgSzqNlDOX3yBhLkjFBy2ueUDdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745313757; c=relaxed/simple;
	bh=19T7mowFMz6z2SMZkPj99Ad7LDfPKQxZRLPAhxc1gQM=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=leP+CyvTV32BOjAXG2YdFUjTuk1CPgdWcwta4BNlIGtsFpZlqdJGqOsMIajXjXHvnLMXqWfdgF8EG2kKiVDUjvtZLYw+pvrHtph+y9P6uvr1LHYe8eWmX58min9O7b4IFC/EmDmWKf/ofOrIPNxOTgnO76bEnfzD5A9y908yB5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Vpb0t38f; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=GXzyRDB2; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 22 Apr 2025 09:22:32 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1745313753;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=biW+JLH0w8aJ6Z7mSqO1VaJHWzSJPQqzsbD3mRVjxNM=;
	b=Vpb0t38fQQ7wwGxWdZXYOAEtFUJMytNr6l2Wnw+KlsRiPQkko41pewtB5fBqzq7JO4mZfp
	D04xQjtpP3k84/JkhS5WcJyh27WMI6RYSgASBNm8tGN8105c1y7MjrZLkfnfSS9rWYhugI
	TvkoCglsUbY/Zt+3WYpyyguG8bV60QYjze2l6YqlkDi7DtyUNlwsViP9nNJ2cluwUbKGeE
	soyUJY06pd8F/L5y3zQQzNCpCNezyy+PanVbElBoqnus9i4RzhpFmi44FYgTyyxMJZ44+P
	ChyILMMmQoDSvDMSRwFqf1GsHFxHLw3R8wuQzBtWQW83jP4OqV2M0OFpsn8EcA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1745313753;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=biW+JLH0w8aJ6Z7mSqO1VaJHWzSJPQqzsbD3mRVjxNM=;
	b=GXzyRDB2fxfo5tmxwp3WP038Fw2tAZKLLY3sft6eJ99amZDx38Fg3dhAgMdNYCVN1Ld/TG
	NyaQJZGHBqwqtEAQ==
From: "tip-bot2 for Ard Biesheuvel" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/boot] x86/boot: Drop RIP_REL_REF() uses from early SEV code
Cc: Ard Biesheuvel <ardb@kernel.org>, Ingo Molnar <mingo@kernel.org>,
 Brian Gerst <brgerst@gmail.com>, David Woodhouse <dwmw@amazon.co.uk>,
 Dionna Amalie Glaze <dionnaglaze@google.com>,
 "H. Peter Anvin" <hpa@zytor.com>, Juergen Gross <jgross@suse.com>,
 Kees Cook <keescook@chromium.org>, Kevin Loughlin <kevinloughlin@google.com>,
 Len Brown <len.brown@intel.com>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
 Tom Lendacky <thomas.lendacky@amd.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250418141253.2601348-13-ardb+git@google.com>
References: <20250418141253.2601348-13-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174531375276.31282.7493159999821662970.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/boot branch of tip:

Commit-ID:     681e2901330c5c27ce8b58dfdd92a3c339e47caf
Gitweb:        https://git.kernel.org/tip/681e2901330c5c27ce8b58dfdd92a3c339e47caf
Author:        Ard Biesheuvel <ardb@kernel.org>
AuthorDate:    Fri, 18 Apr 2025 16:12:59 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 22 Apr 2025 09:12:01 +02:00

x86/boot: Drop RIP_REL_REF() uses from early SEV code

Now that the early SEV code is built with -fPIC, RIP_REL_REF() has no
effect and can be dropped.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Brian Gerst <brgerst@gmail.com>
Cc: David Woodhouse <dwmw@amazon.co.uk>
Cc: Dionna Amalie Glaze <dionnaglaze@google.com>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Juergen Gross <jgross@suse.com>
Cc: Kees Cook <keescook@chromium.org>
Cc: Kevin Loughlin <kevinloughlin@google.com>
Cc: Len Brown <len.brown@intel.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Cc: Tom Lendacky <thomas.lendacky@amd.com>
Link: https://lore.kernel.org/r/20250418141253.2601348-13-ardb+git@google.com
---
 arch/x86/boot/startup/sev-shared.c  | 26 +++++++++++---------------
 arch/x86/boot/startup/sev-startup.c | 21 ++++++++-------------
 arch/x86/include/asm/sev-internal.h | 18 ++++--------------
 3 files changed, 23 insertions(+), 42 deletions(-)

diff --git a/arch/x86/boot/startup/sev-shared.c b/arch/x86/boot/startup/sev-shared.c
index 8155422..173f3d1 100644
--- a/arch/x86/boot/startup/sev-shared.c
+++ b/arch/x86/boot/startup/sev-shared.c
@@ -299,7 +299,7 @@ static int svsm_perform_ghcb_protocol(struct ghcb *ghcb, struct svsm_call *call)
 	 * Fill in protocol and format specifiers. This can be called very early
 	 * in the boot, so use rip-relative references as needed.
 	 */
-	ghcb->protocol_version = RIP_REL_REF(ghcb_version);
+	ghcb->protocol_version = ghcb_version;
 	ghcb->ghcb_usage       = GHCB_DEFAULT_USAGE;
 
 	ghcb_set_sw_exit_code(ghcb, SVM_VMGEXIT_SNP_RUN_VMPL);
@@ -656,9 +656,9 @@ snp_cpuid(struct ghcb *ghcb, struct es_em_ctxt *ctxt, struct cpuid_leaf *leaf)
 		leaf->eax = leaf->ebx = leaf->ecx = leaf->edx = 0;
 
 		/* Skip post-processing for out-of-range zero leafs. */
-		if (!(leaf->fn <= RIP_REL_REF(cpuid_std_range_max) ||
-		      (leaf->fn >= 0x40000000 && leaf->fn <= RIP_REL_REF(cpuid_hyp_range_max)) ||
-		      (leaf->fn >= 0x80000000 && leaf->fn <= RIP_REL_REF(cpuid_ext_range_max))))
+		if (!(leaf->fn <= cpuid_std_range_max ||
+		      (leaf->fn >= 0x40000000 && leaf->fn <= cpuid_hyp_range_max) ||
+		      (leaf->fn >= 0x80000000 && leaf->fn <= cpuid_ext_range_max)))
 			return 0;
 	}
 
@@ -1179,11 +1179,11 @@ static void __head setup_cpuid_table(const struct cc_blob_sev_info *cc_info)
 		const struct snp_cpuid_fn *fn = &cpuid_table->fn[i];
 
 		if (fn->eax_in == 0x0)
-			RIP_REL_REF(cpuid_std_range_max) = fn->eax;
+			cpuid_std_range_max = fn->eax;
 		else if (fn->eax_in == 0x40000000)
-			RIP_REL_REF(cpuid_hyp_range_max) = fn->eax;
+			cpuid_hyp_range_max = fn->eax;
 		else if (fn->eax_in == 0x80000000)
-			RIP_REL_REF(cpuid_ext_range_max) = fn->eax;
+			cpuid_ext_range_max = fn->eax;
 	}
 }
 
@@ -1229,11 +1229,7 @@ static void __head pvalidate_4k_page(unsigned long vaddr, unsigned long paddr,
 {
 	int ret;
 
-	/*
-	 * This can be called very early during boot, so use rIP-relative
-	 * references as needed.
-	 */
-	if (RIP_REL_REF(snp_vmpl)) {
+	if (snp_vmpl) {
 		svsm_pval_4k_page(paddr, validate);
 	} else {
 		ret = pvalidate(vaddr, RMP_PG_SIZE_4K, validate);
@@ -1377,7 +1373,7 @@ static bool __head svsm_setup_ca(const struct cc_blob_sev_info *cc_info)
 	if (!secrets_page->svsm_guest_vmpl)
 		sev_es_terminate(SEV_TERM_SET_LINUX, GHCB_TERM_SVSM_VMPL0);
 
-	RIP_REL_REF(snp_vmpl) = secrets_page->svsm_guest_vmpl;
+	snp_vmpl = secrets_page->svsm_guest_vmpl;
 
 	caa = secrets_page->svsm_caa;
 
@@ -1392,8 +1388,8 @@ static bool __head svsm_setup_ca(const struct cc_blob_sev_info *cc_info)
 	 * The CA is identity mapped when this routine is called, both by the
 	 * decompressor code and the early kernel code.
 	 */
-	RIP_REL_REF(boot_svsm_caa) = (struct svsm_ca *)caa;
-	RIP_REL_REF(boot_svsm_caa_pa) = caa;
+	boot_svsm_caa = (struct svsm_ca *)caa;
+	boot_svsm_caa_pa = caa;
 
 	/* Advertise the SVSM presence via CPUID. */
 	cpuid_table = (struct snp_cpuid_table *)snp_cpuid_get_table();
diff --git a/arch/x86/boot/startup/sev-startup.c b/arch/x86/boot/startup/sev-startup.c
index 10b6360..36a75c5 100644
--- a/arch/x86/boot/startup/sev-startup.c
+++ b/arch/x86/boot/startup/sev-startup.c
@@ -462,15 +462,10 @@ int svsm_perform_call_protocol(struct svsm_call *call)
 	 */
 	flags = native_local_irq_save();
 
-	/*
-	 * Use rip-relative references when called early in the boot. If
-	 * ghcbs_initialized is set, then it is late in the boot and no need
-	 * to worry about rip-relative references in called functions.
-	 */
-	if (RIP_REL_REF(sev_cfg).ghcbs_initialized)
+	if (sev_cfg.ghcbs_initialized)
 		ghcb = __sev_get_ghcb(&state);
-	else if (RIP_REL_REF(boot_ghcb))
-		ghcb = RIP_REL_REF(boot_ghcb);
+	else if (boot_ghcb)
+		ghcb = boot_ghcb;
 	else
 		ghcb = NULL;
 
@@ -479,7 +474,7 @@ int svsm_perform_call_protocol(struct svsm_call *call)
 			   : svsm_perform_msr_protocol(call);
 	} while (ret == -EAGAIN);
 
-	if (RIP_REL_REF(sev_cfg).ghcbs_initialized)
+	if (sev_cfg.ghcbs_initialized)
 		__sev_put_ghcb(&state);
 
 	native_local_irq_restore(flags);
@@ -542,7 +537,7 @@ void __head early_snp_set_memory_private(unsigned long vaddr, unsigned long padd
 	 * This eliminates worries about jump tables or checking boot_cpu_data
 	 * in the cc_platform_has() function.
 	 */
-	if (!(RIP_REL_REF(sev_status) & MSR_AMD64_SEV_SNP_ENABLED))
+	if (!(sev_status & MSR_AMD64_SEV_SNP_ENABLED))
 		return;
 
 	 /*
@@ -561,7 +556,7 @@ void __head early_snp_set_memory_shared(unsigned long vaddr, unsigned long paddr
 	 * This eliminates worries about jump tables or checking boot_cpu_data
 	 * in the cc_platform_has() function.
 	 */
-	if (!(RIP_REL_REF(sev_status) & MSR_AMD64_SEV_SNP_ENABLED))
+	if (!(sev_status & MSR_AMD64_SEV_SNP_ENABLED))
 		return;
 
 	 /* Ask hypervisor to mark the memory pages shared in the RMP table. */
@@ -1356,8 +1351,8 @@ static __head void svsm_setup(struct cc_blob_sev_info *cc_info)
 	if (ret)
 		sev_es_terminate(SEV_TERM_SET_LINUX, GHCB_TERM_SVSM_CA_REMAP_FAIL);
 
-	RIP_REL_REF(boot_svsm_caa) = (struct svsm_ca *)pa;
-	RIP_REL_REF(boot_svsm_caa_pa) = pa;
+	boot_svsm_caa = (struct svsm_ca *)pa;
+	boot_svsm_caa_pa = pa;
 }
 
 bool __head snp_init(struct boot_params *bp)
diff --git a/arch/x86/include/asm/sev-internal.h b/arch/x86/include/asm/sev-internal.h
index 73cb774..e54847a 100644
--- a/arch/x86/include/asm/sev-internal.h
+++ b/arch/x86/include/asm/sev-internal.h
@@ -68,28 +68,18 @@ extern u64 boot_svsm_caa_pa;
 
 static __always_inline struct svsm_ca *svsm_get_caa(void)
 {
-	/*
-	 * Use rIP-relative references when called early in the boot. If
-	 * ->use_cas is set, then it is late in the boot and no need
-	 * to worry about rIP-relative references.
-	 */
-	if (RIP_REL_REF(sev_cfg).use_cas)
+	if (sev_cfg.use_cas)
 		return this_cpu_read(svsm_caa);
 	else
-		return RIP_REL_REF(boot_svsm_caa);
+		return boot_svsm_caa;
 }
 
 static __always_inline u64 svsm_get_caa_pa(void)
 {
-	/*
-	 * Use rIP-relative references when called early in the boot. If
-	 * ->use_cas is set, then it is late in the boot and no need
-	 * to worry about rIP-relative references.
-	 */
-	if (RIP_REL_REF(sev_cfg).use_cas)
+	if (sev_cfg.use_cas)
 		return this_cpu_read(svsm_caa_pa);
 	else
-		return RIP_REL_REF(boot_svsm_caa_pa);
+		return boot_svsm_caa_pa;
 }
 
 int svsm_perform_call_protocol(struct svsm_call *call);

