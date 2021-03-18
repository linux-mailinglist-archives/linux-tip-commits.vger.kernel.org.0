Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B99F2340E53
	for <lists+linux-tip-commits@lfdr.de>; Thu, 18 Mar 2021 20:35:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232904AbhCRTeu (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Thu, 18 Mar 2021 15:34:50 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:59912 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232879AbhCRTeh (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Thu, 18 Mar 2021 15:34:37 -0400
Date:   Thu, 18 Mar 2021 19:34:35 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1616096075;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JaQqJ9i/oXUWaA49KZkJd91DpN7A1d5CH1gL/IeO8Pg=;
        b=oJ0xALdyjvS9aU1DtfLLRjX/tNdHzmM6VXCILYED1kM2UYBcxwVRORHbnqBhhI/9HXyxWj
        7Rc73Ke5rApQ/MgqGTeevrCYN9GPJZipsITfbLGvt38crQqU0RtRahqxR5ngH49qTawG7+
        DNMpm7/161mgFXj9JLzvLYLImYF29ipqEYEipHOWlax3cBdmaAsMWRRjtuUayU2Ir4StbS
        CexUTv15T/L4BWGpEDvrcbMGrc2XVRvhWO4z8ANrEFMYJZdUtc4sHNeyigOCeKbNE1KXHr
        mMYG+w6s27tC8l2JNdrF81+EmKrJ0wHX2VLCbbNz38vRcd40TPX61N4NbQq12Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1616096075;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JaQqJ9i/oXUWaA49KZkJd91DpN7A1d5CH1gL/IeO8Pg=;
        b=oGcc2Yi6qZlymCGJJTasdsmbf/x4z5YXyHqVCfNwMcqfzAEUpq75W7pCEjh8XdHtQDXq94
        v3zMKbd3yEwwbNBw==
From:   "tip-bot2 for Joerg Roedel" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/seves] x86/sev: Do not require Hypervisor CPUID bit for SEV guests
Cc:     Joerg Roedel <jroedel@suse.de>, Borislav Petkov <bp@suse.de>,
        Tom Lendacky <thomas.lendacky@amd.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210312123824.306-3-joro@8bytes.org>
References: <20210312123824.306-3-joro@8bytes.org>
MIME-Version: 1.0
Message-ID: <161609607530.398.12282364656918586276.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/seves branch of tip:

Commit-ID:     eab696d8e8b9c9d600be6fad8dd8dfdfaca6ca7c
Gitweb:        https://git.kernel.org/tip/eab696d8e8b9c9d600be6fad8dd8dfdfaca6ca7c
Author:        Joerg Roedel <jroedel@suse.de>
AuthorDate:    Fri, 12 Mar 2021 13:38:18 +01:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Thu, 18 Mar 2021 16:44:40 +01:00

x86/sev: Do not require Hypervisor CPUID bit for SEV guests

A malicious hypervisor could disable the CPUID intercept for an SEV or
SEV-ES guest and trick it into the no-SEV boot path, where it could
potentially reveal secrets. This is not an issue for SEV-SNP guests,
as the CPUID intercept can't be disabled for those.

Remove the Hypervisor CPUID bit check from the SEV detection code to
protect against this kind of attack and add a Hypervisor bit equals zero
check to the SME detection path to prevent non-encrypted guests from
trying to enable SME.

This handles the following cases:

	1) SEV(-ES) guest where CPUID intercept is disabled. The guest
	   will still see leaf 0x8000001f and the SEV bit. It can
	   retrieve the C-bit and boot normally.

	2) Non-encrypted guests with intercepted CPUID will check
	   the SEV_STATUS MSR and find it 0 and will try to enable SME.
	   This will fail when the guest finds MSR_K8_SYSCFG to be zero,
	   as it is emulated by KVM. But we can't rely on that, as there
	   might be other hypervisors which return this MSR with bit
	   23 set. The Hypervisor bit check will prevent that the guest
	   tries to enable SME in this case.

	3) Non-encrypted guests on SEV capable hosts with CPUID intercept
	   disabled (by a malicious hypervisor) will try to boot into
	   the SME path. This will fail, but it is also not considered
	   a problem because non-encrypted guests have no protection
	   against the hypervisor anyway.

 [ bp: s/non-SEV/non-encrypted/g ]

Signed-off-by: Joerg Roedel <jroedel@suse.de>
Signed-off-by: Borislav Petkov <bp@suse.de>
Acked-by: Tom Lendacky <thomas.lendacky@amd.com>
Link: https://lkml.kernel.org/r/20210312123824.306-3-joro@8bytes.org
---
 arch/x86/boot/compressed/mem_encrypt.S |  6 +----
 arch/x86/kernel/sev-es-shared.c        |  6 +----
 arch/x86/mm/mem_encrypt_identity.c     | 35 +++++++++++++------------
 3 files changed, 20 insertions(+), 27 deletions(-)

diff --git a/arch/x86/boot/compressed/mem_encrypt.S b/arch/x86/boot/compressed/mem_encrypt.S
index aa56179..a6dea4e 100644
--- a/arch/x86/boot/compressed/mem_encrypt.S
+++ b/arch/x86/boot/compressed/mem_encrypt.S
@@ -23,12 +23,6 @@ SYM_FUNC_START(get_sev_encryption_bit)
 	push	%ecx
 	push	%edx
 
-	/* Check if running under a hypervisor */
-	movl	$1, %eax
-	cpuid
-	bt	$31, %ecx		/* Check the hypervisor bit */
-	jnc	.Lno_sev
-
 	movl	$0x80000000, %eax	/* CPUID to check the highest leaf */
 	cpuid
 	cmpl	$0x8000001f, %eax	/* See if 0x8000001f is available */
diff --git a/arch/x86/kernel/sev-es-shared.c b/arch/x86/kernel/sev-es-shared.c
index cdc04d0..387b716 100644
--- a/arch/x86/kernel/sev-es-shared.c
+++ b/arch/x86/kernel/sev-es-shared.c
@@ -186,7 +186,6 @@ void __init do_vc_no_ghcb(struct pt_regs *regs, unsigned long exit_code)
 	 * make it accessible to the hypervisor.
 	 *
 	 * In particular, check for:
-	 *	- Hypervisor CPUID bit
 	 *	- Availability of CPUID leaf 0x8000001f
 	 *	- SEV CPUID bit.
 	 *
@@ -194,10 +193,7 @@ void __init do_vc_no_ghcb(struct pt_regs *regs, unsigned long exit_code)
 	 * can't be checked here.
 	 */
 
-	if ((fn == 1 && !(regs->cx & BIT(31))))
-		/* Hypervisor bit */
-		goto fail;
-	else if (fn == 0x80000000 && (regs->ax < 0x8000001f))
+	if (fn == 0x80000000 && (regs->ax < 0x8000001f))
 		/* SEV leaf check */
 		goto fail;
 	else if ((fn == 0x8000001f && !(regs->ax & BIT(1))))
diff --git a/arch/x86/mm/mem_encrypt_identity.c b/arch/x86/mm/mem_encrypt_identity.c
index 6c5eb6f..a19374d 100644
--- a/arch/x86/mm/mem_encrypt_identity.c
+++ b/arch/x86/mm/mem_encrypt_identity.c
@@ -503,14 +503,10 @@ void __init sme_enable(struct boot_params *bp)
 
 #define AMD_SME_BIT	BIT(0)
 #define AMD_SEV_BIT	BIT(1)
-	/*
-	 * Set the feature mask (SME or SEV) based on whether we are
-	 * running under a hypervisor.
-	 */
-	eax = 1;
-	ecx = 0;
-	native_cpuid(&eax, &ebx, &ecx, &edx);
-	feature_mask = (ecx & BIT(31)) ? AMD_SEV_BIT : AMD_SME_BIT;
+
+	/* Check the SEV MSR whether SEV or SME is enabled */
+	sev_status   = __rdmsr(MSR_AMD64_SEV);
+	feature_mask = (sev_status & MSR_AMD64_SEV_ENABLED) ? AMD_SEV_BIT : AMD_SME_BIT;
 
 	/*
 	 * Check for the SME/SEV feature:
@@ -530,19 +526,26 @@ void __init sme_enable(struct boot_params *bp)
 
 	/* Check if memory encryption is enabled */
 	if (feature_mask == AMD_SME_BIT) {
+		/*
+		 * No SME if Hypervisor bit is set. This check is here to
+		 * prevent a guest from trying to enable SME. For running as a
+		 * KVM guest the MSR_K8_SYSCFG will be sufficient, but there
+		 * might be other hypervisors which emulate that MSR as non-zero
+		 * or even pass it through to the guest.
+		 * A malicious hypervisor can still trick a guest into this
+		 * path, but there is no way to protect against that.
+		 */
+		eax = 1;
+		ecx = 0;
+		native_cpuid(&eax, &ebx, &ecx, &edx);
+		if (ecx & BIT(31))
+			return;
+
 		/* For SME, check the SYSCFG MSR */
 		msr = __rdmsr(MSR_K8_SYSCFG);
 		if (!(msr & MSR_K8_SYSCFG_MEM_ENCRYPT))
 			return;
 	} else {
-		/* For SEV, check the SEV MSR */
-		msr = __rdmsr(MSR_AMD64_SEV);
-		if (!(msr & MSR_AMD64_SEV_ENABLED))
-			return;
-
-		/* Save SEV_STATUS to avoid reading MSR again */
-		sev_status = msr;
-
 		/* SEV state cannot be controlled by a command line option */
 		sme_me_mask = me_mask;
 		sev_enabled = true;
