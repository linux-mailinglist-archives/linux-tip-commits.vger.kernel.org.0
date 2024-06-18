Return-Path: <linux-tip-commits+bounces-1440-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DE0190C851
	for <lists+linux-tip-commits@lfdr.de>; Tue, 18 Jun 2024 13:04:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F1E691F22078
	for <lists+linux-tip-commits@lfdr.de>; Tue, 18 Jun 2024 11:04:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 451D920006A;
	Tue, 18 Jun 2024 09:45:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="q28M5vK7";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="SDkVVT7G"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4BAC1FF83B;
	Tue, 18 Jun 2024 09:45:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718703909; cv=none; b=FjVzKdm0Cp9fgHQpL3pOEMW7xN8LVAoJEGD5Au27/7AjDqrcZMcfJNRGfZKVqdqYNTTNl5iUH1dyXsxUwhk/WTF95YW7lGivZkZs2d7ELdNVlCF1KlbUH/+rKfeycKmJpu6imPDCEgUEvC8ETRQnIOU3+jpQbxwG/5MksK3trxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718703909; c=relaxed/simple;
	bh=Bwf++ZgSc92HQoKvrxw3tJquAMlVIoWKxkkqeB1eMEA=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=YVU6qLVWeC/QstRAPlOeeK7/fEbMCEebL6Hws4vuJPUC/D/+4L7/1ALzaaXsSpabRlEdPBLCkDn5+ODkVTqwAiviF2tNd/m6W+5JXfoEReLchrJzrT671mLHg5AT597OZOKdo4DpvSL1iFODIArBEllTbPbAqWgjD5/uR7OVXvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=q28M5vK7; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=SDkVVT7G; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 18 Jun 2024 09:44:59 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1718703900;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=C0CIRWkVOWz66oI1gLwIKD2mM74jEPFWu57nGYD+vuc=;
	b=q28M5vK7ul6UOLRk4RznwPgMKx62mm3qeU8VQaPjQ9sABcjagh919/PYLMl7azFh8TsHWA
	Qtobe+zxLQ4U3QMMDv7guxgBA93Poyadh/ANv5kG/2+nYUfm+fWrr+cFclieNtokloLC7z
	WqWiFaB/AcXgbyN3uszJP7U9Xy9DBHt5rC5J1++5+MSWm85wNpxMnjcw0zWWg2TBgC+9bD
	thkiETxAUUEraViklh3ssFqbIpGsQ4/JLrKm4qDgFixsVCuHckrIdJZ0UVgwGKS7J+fvZG
	1V4Qsb/JcVZxBmrmac1khoBnVEAIYaIw41DN91yUbUvezKb7T+hCvFHh763ysQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1718703900;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=C0CIRWkVOWz66oI1gLwIKD2mM74jEPFWu57nGYD+vuc=;
	b=SDkVVT7GrYQJjio1qgB57/ZwmTNMR8HeWlNu2mY5icXvXpVQM+6TRAvQpt6L/qkA34E5xB
	C/fz8IZLDBI6FGDQ==
From: "tip-bot2 for Tom Lendacky" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/sev] x86/sev: Provide SVSM discovery support
Cc: Tom Lendacky <thomas.lendacky@amd.com>,
 "Borislav Petkov (AMD)" <bp@alien8.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: =?utf-8?q?=3C4f93f10a2ff3e9f368fd64a5920d51bf38d0c19e=2E17176?=
 =?utf-8?q?00736=2Egit=2Ethomas=2Elendacky=40amd=2Ecom=3E?=
References: =?utf-8?q?=3C4f93f10a2ff3e9f368fd64a5920d51bf38d0c19e=2E171760?=
 =?utf-8?q?0736=2Egit=2Ethomas=2Elendacky=40amd=2Ecom=3E?=
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171870389977.10875.18185818265677223072.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/sev branch of tip:

Commit-ID:     1beb348d5c7fdef502a581bd73f792a2cf1535d6
Gitweb:        https://git.kernel.org/tip/1beb348d5c7fdef502a581bd73f792a2cf1535d6
Author:        Tom Lendacky <thomas.lendacky@amd.com>
AuthorDate:    Wed, 05 Jun 2024 10:18:49 -05:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Mon, 17 Jun 2024 20:42:57 +02:00

x86/sev: Provide SVSM discovery support

The SVSM specification documents an alternative method of discovery for
the SVSM using a reserved CPUID bit and a reserved MSR. This is intended
for guest components that do not have access to the secrets page in
order to be able to call the SVSM (e.g. UEFI runtime services).

For the MSR support, a new reserved MSR 0xc001f000 has been defined. A #VC
should be generated when accessing this MSR. The #VC handler is expected
to ignore writes to this MSR and return the physical calling area address
(CAA) on reads of this MSR.

While the CPUID leaf is updated, allowing the creation of a CPU feature,
the code will continue to use the VMPL level as an indication of the
presence of an SVSM. This is because the SVSM can be called well before
the CPU feature is in place and a non-zero VMPL requires that an SVSM be
present.

Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://lore.kernel.org/r/4f93f10a2ff3e9f368fd64a5920d51bf38d0c19e.1717600736.git.thomas.lendacky@amd.com
---
 arch/x86/include/asm/cpufeatures.h |  1 +
 arch/x86/include/asm/msr-index.h   |  2 ++
 arch/x86/kernel/sev-shared.c       | 11 +++++++++++
 arch/x86/kernel/sev.c              | 11 +++++++++++
 4 files changed, 25 insertions(+)

diff --git a/arch/x86/include/asm/cpufeatures.h b/arch/x86/include/asm/cpufeatures.h
index 3c74343..1826f1f 100644
--- a/arch/x86/include/asm/cpufeatures.h
+++ b/arch/x86/include/asm/cpufeatures.h
@@ -446,6 +446,7 @@
 #define X86_FEATURE_V_TSC_AUX		(19*32+ 9) /* "" Virtual TSC_AUX */
 #define X86_FEATURE_SME_COHERENT	(19*32+10) /* "" AMD hardware-enforced cache coherency */
 #define X86_FEATURE_DEBUG_SWAP		(19*32+14) /* AMD SEV-ES full debug state swap support */
+#define X86_FEATURE_SVSM		(19*32+28) /* SVSM present */
 
 /* AMD-defined Extended Feature 2 EAX, CPUID level 0x80000021 (EAX), word 20 */
 #define X86_FEATURE_NO_NESTED_DATA_BP	(20*32+ 0) /* "" No Nested Data Breakpoints */
diff --git a/arch/x86/include/asm/msr-index.h b/arch/x86/include/asm/msr-index.h
index e022e6e..45ffa27 100644
--- a/arch/x86/include/asm/msr-index.h
+++ b/arch/x86/include/asm/msr-index.h
@@ -660,6 +660,8 @@
 #define MSR_AMD64_RMP_BASE		0xc0010132
 #define MSR_AMD64_RMP_END		0xc0010133
 
+#define MSR_SVSM_CAA			0xc001f000
+
 /* AMD Collaborative Processor Performance Control MSRs */
 #define MSR_AMD_CPPC_CAP1		0xc00102b0
 #define MSR_AMD_CPPC_ENABLE		0xc00102b1
diff --git a/arch/x86/kernel/sev-shared.c b/arch/x86/kernel/sev-shared.c
index 7933c12..2f50910 100644
--- a/arch/x86/kernel/sev-shared.c
+++ b/arch/x86/kernel/sev-shared.c
@@ -1648,6 +1648,8 @@ static enum es_result vc_check_opcode_bytes(struct es_em_ctxt *ctxt,
 static bool __head svsm_setup_ca(const struct cc_blob_sev_info *cc_info)
 {
 	struct snp_secrets_page *secrets_page;
+	struct snp_cpuid_table *cpuid_table;
+	unsigned int i;
 	u64 caa;
 
 	BUILD_BUG_ON(sizeof(*secrets_page) != PAGE_SIZE);
@@ -1701,5 +1703,14 @@ static bool __head svsm_setup_ca(const struct cc_blob_sev_info *cc_info)
 	RIP_REL_REF(boot_svsm_caa) = (struct svsm_ca *)caa;
 	RIP_REL_REF(boot_svsm_caa_pa) = caa;
 
+	/* Advertise the SVSM presence via CPUID. */
+	cpuid_table = (struct snp_cpuid_table *)snp_cpuid_get_table();
+	for (i = 0; i < cpuid_table->count; i++) {
+		struct snp_cpuid_fn *fn = &cpuid_table->fn[i];
+
+		if (fn->eax_in == 0x8000001f)
+			fn->eax |= BIT(28);
+	}
+
 	return true;
 }
diff --git a/arch/x86/kernel/sev.c b/arch/x86/kernel/sev.c
index 2586ba6..84f3731 100644
--- a/arch/x86/kernel/sev.c
+++ b/arch/x86/kernel/sev.c
@@ -1340,6 +1340,17 @@ static enum es_result vc_handle_msr(struct ghcb *ghcb, struct es_em_ctxt *ctxt)
 	/* Is it a WRMSR? */
 	exit_info_1 = (ctxt->insn.opcode.bytes[1] == 0x30) ? 1 : 0;
 
+	if (regs->cx == MSR_SVSM_CAA) {
+		/* Writes to the SVSM CAA msr are ignored */
+		if (exit_info_1)
+			return ES_OK;
+
+		regs->ax = lower_32_bits(this_cpu_read(svsm_caa_pa));
+		regs->dx = upper_32_bits(this_cpu_read(svsm_caa_pa));
+
+		return ES_OK;
+	}
+
 	ghcb_set_rcx(ghcb, regs->cx);
 	if (exit_info_1) {
 		ghcb_set_rax(ghcb, regs->ax);

