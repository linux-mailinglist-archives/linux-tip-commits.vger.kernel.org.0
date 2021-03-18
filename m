Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D3BD340E52
	for <lists+linux-tip-commits@lfdr.de>; Thu, 18 Mar 2021 20:35:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232842AbhCRTes (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Thu, 18 Mar 2021 15:34:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232889AbhCRTeg (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Thu, 18 Mar 2021 15:34:36 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 402DDC06174A;
        Thu, 18 Mar 2021 12:34:36 -0700 (PDT)
Date:   Thu, 18 Mar 2021 19:34:34 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1616096074;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=USl8hGacE0poctAFuf1J4iuO5V88cZXuaoegcFFFPps=;
        b=xX3hOV+gNiGaFnEN5WyQgIDXyHq2t94Oqy8/OcUTIrT3lt3hF1d2feaqRNJ+zqeU6xm3zb
        S0WwKe6kfaJbFm2pwTpWJegSK6ZWBOBtDVlAMRlrWHAtrkFga/dHiBRoCy7wMdXGo+hlwG
        cPstYXN2HFEJmFaZjKAr+Y4FcxrDIsgWc77BvWHroz0ACwvtiPio0sKdOX3gkvFgX75x0l
        EqP7IyszkYWSxtBAjOqaUrzWFsFIJQiPZ4cfrAS1Zgd02Ycy/lKr5Rf7SphJcMMtBEWfl+
        hJ9svGNC5KQshb87LPiQG5N4Z+DI1SvsUDYQf0b1jYnm5LeOAcdmbO1q4j4ZnA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1616096074;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=USl8hGacE0poctAFuf1J4iuO5V88cZXuaoegcFFFPps=;
        b=nq8G7lLgnbJjg4rg1nESCsS3/J/mC/e1cckqFLPPzz9dPw8ish8HNaHo6gosgmjG4UHurC
        iMOJK23sVXL/soDA==
From:   "tip-bot2 for Joerg Roedel" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/seves] x86/boot/compressed/64: Add 32-bit boot #VC handler
Cc:     Joerg Roedel <jroedel@suse.de>, Borislav Petkov <bp@suse.de>,
        x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20210312123824.306-6-joro@8bytes.org>
References: <20210312123824.306-6-joro@8bytes.org>
MIME-Version: 1.0
Message-ID: <161609607421.398.2630208851205185725.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/seves branch of tip:

Commit-ID:     9e373ba233b236a831d0d9578be095a4b7435abe
Gitweb:        https://git.kernel.org/tip/9e373ba233b236a831d0d9578be095a4b7435abe
Author:        Joerg Roedel <jroedel@suse.de>
AuthorDate:    Wed, 10 Mar 2021 09:43:22 +01:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Thu, 18 Mar 2021 16:44:48 +01:00

x86/boot/compressed/64: Add 32-bit boot #VC handler

Add a #VC exception handler which is used when the kernel still executes
in protected mode. This boot-path already uses CPUID, which will cause

Signed-off-by: Joerg Roedel <jroedel@suse.de>
Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lkml.kernel.org/r/20210312123824.306-6-joro@8bytes.org
---
 arch/x86/boot/compressed/head_64.S     |  6 ++-
 arch/x86/boot/compressed/mem_encrypt.S | 96 ++++++++++++++++++++++++-
 2 files changed, 101 insertions(+), 1 deletion(-)

diff --git a/arch/x86/boot/compressed/head_64.S b/arch/x86/boot/compressed/head_64.S
index 2001c3b..ee448ae 100644
--- a/arch/x86/boot/compressed/head_64.S
+++ b/arch/x86/boot/compressed/head_64.S
@@ -34,6 +34,7 @@
 #include <asm/asm-offsets.h>
 #include <asm/bootparam.h>
 #include <asm/desc_defs.h>
+#include <asm/trapnr.h>
 #include "pgtable.h"
 
 /*
@@ -857,6 +858,11 @@ SYM_FUNC_END(startup32_set_idt_entry)
 
 SYM_FUNC_START(startup32_load_idt)
 #ifdef CONFIG_AMD_MEM_ENCRYPT
+	/* #VC handler */
+	leal    rva(startup32_vc_handler)(%ebp), %eax
+	movl    $X86_TRAP_VC, %edx
+	call    startup32_set_idt_entry
+
 	/* Load IDT */
 	leal	rva(boot32_idt)(%ebp), %eax
 	movl	%eax, rva(boot32_idt_desc+2)(%ebp)
diff --git a/arch/x86/boot/compressed/mem_encrypt.S b/arch/x86/boot/compressed/mem_encrypt.S
index a6dea4e..ebc4a29 100644
--- a/arch/x86/boot/compressed/mem_encrypt.S
+++ b/arch/x86/boot/compressed/mem_encrypt.S
@@ -61,10 +61,104 @@ SYM_FUNC_START(get_sev_encryption_bit)
 	ret
 SYM_FUNC_END(get_sev_encryption_bit)
 
+/**
+ * sev_es_req_cpuid - Request a CPUID value from the Hypervisor using
+ *		      the GHCB MSR protocol
+ *
+ * @%eax:	Register to request (0=EAX, 1=EBX, 2=ECX, 3=EDX)
+ * @%edx:	CPUID Function
+ *
+ * Returns 0 in %eax on success, non-zero on failure
+ * %edx returns CPUID value on success
+ */
+SYM_CODE_START_LOCAL(sev_es_req_cpuid)
+	shll	$30, %eax
+	orl     $0x00000004, %eax
+	movl    $MSR_AMD64_SEV_ES_GHCB, %ecx
+	wrmsr
+	rep; vmmcall		# VMGEXIT
+	rdmsr
+
+	/* Check response */
+	movl	%eax, %ecx
+	andl	$0x3ffff000, %ecx	# Bits [12-29] MBZ
+	jnz	2f
+
+	/* Check return code */
+	andl    $0xfff, %eax
+	cmpl    $5, %eax
+	jne	2f
+
+	/* All good - return success */
+	xorl	%eax, %eax
+1:
+	ret
+2:
+	movl	$-1, %eax
+	jmp	1b
+SYM_CODE_END(sev_es_req_cpuid)
+
+SYM_CODE_START(startup32_vc_handler)
+	pushl	%eax
+	pushl	%ebx
+	pushl	%ecx
+	pushl	%edx
+
+	/* Keep CPUID function in %ebx */
+	movl	%eax, %ebx
+
+	/* Check if error-code == SVM_EXIT_CPUID */
+	cmpl	$0x72, 16(%esp)
+	jne	.Lfail
+
+	movl	$0, %eax		# Request CPUID[fn].EAX
+	movl	%ebx, %edx		# CPUID fn
+	call	sev_es_req_cpuid	# Call helper
+	testl	%eax, %eax		# Check return code
+	jnz	.Lfail
+	movl	%edx, 12(%esp)		# Store result
+
+	movl	$1, %eax		# Request CPUID[fn].EBX
+	movl	%ebx, %edx		# CPUID fn
+	call	sev_es_req_cpuid	# Call helper
+	testl	%eax, %eax		# Check return code
+	jnz	.Lfail
+	movl	%edx, 8(%esp)		# Store result
+
+	movl	$2, %eax		# Request CPUID[fn].ECX
+	movl	%ebx, %edx		# CPUID fn
+	call	sev_es_req_cpuid	# Call helper
+	testl	%eax, %eax		# Check return code
+	jnz	.Lfail
+	movl	%edx, 4(%esp)		# Store result
+
+	movl	$3, %eax		# Request CPUID[fn].EDX
+	movl	%ebx, %edx		# CPUID fn
+	call	sev_es_req_cpuid	# Call helper
+	testl	%eax, %eax		# Check return code
+	jnz	.Lfail
+	movl	%edx, 0(%esp)		# Store result
+
+	popl	%edx
+	popl	%ecx
+	popl	%ebx
+	popl	%eax
+
+	/* Remove error code */
+	addl	$4, %esp
+
+	/* Jump over CPUID instruction */
+	addl	$2, (%esp)
+
+	iret
+.Lfail:
+	hlt
+	jmp .Lfail
+SYM_CODE_END(startup32_vc_handler)
+
 	.code64
 
 #include "../../kernel/sev_verify_cbit.S"
-
 SYM_FUNC_START(set_sev_encryption_mask)
 #ifdef CONFIG_AMD_MEM_ENCRYPT
 	push	%rbp
