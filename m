Return-Path: <linux-tip-commits+bounces-2980-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CB7B39E5577
	for <lists+linux-tip-commits@lfdr.de>; Thu,  5 Dec 2024 13:29:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1179016B632
	for <lists+linux-tip-commits@lfdr.de>; Thu,  5 Dec 2024 12:28:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CCDD218E9A;
	Thu,  5 Dec 2024 12:28:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="lktW4EUJ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ZkvvYoe4"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6390A218AA6;
	Thu,  5 Dec 2024 12:28:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733401697; cv=none; b=Xv3buKEYWLDFGjrTQyoR2y8y8YrB5pKrZTr0Wgd++ljxGUA3ZMcyykgdpeSq71FvlTljLMfwlFZ+B2qGX1BNb3ynJT/9uj5uQ9ec6NapbPJcq3EYocGIOnhCBmZraylQMbejoc+0CpEJdm/DFUU6g2AYcEPrxk218jB9gcvAGxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733401697; c=relaxed/simple;
	bh=lC6VgZ37GUxGM6VPTIfgMSWfELWOfvcfuOObCugC4Xc=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=Bu2XTyxP9jxtAsBdPrDbK0N3RqdnemzRxVsw59FwSy7btlkIup1vh6WrOUdHVaiLjeUaDyn/WZPGKNu0FRlT4XWoeEBML6iRHhzxvc26HBJE+LVY+o7TYsoJ4FOo4LOvprmjHTZhnRhTs4Fv6abZboZD2/1gdAKgxVB/WCqd3IU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=lktW4EUJ; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ZkvvYoe4; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 05 Dec 2024 12:28:12 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1733401693;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+su9hKSmzkSrhS3hMFkehxB5TII3D2pOPIrs9yle89g=;
	b=lktW4EUJhS3m0STaMbR7GPo7rNHaQQjsVREgJCQopattt3kWlHJyfjb+RUlhs28cA+Sx+u
	HkOm7ODCjFG5AAJq9lS5anQIvF03vo1e7BtPDnYsFI3SDjdEylY33LBCSoCM8KFqFxofv4
	autAzH1hoehn8mmQy4lWn4qXUyu7s0OMjuljpRJ0cCSEyF6Xz3znu2DAoF00N6reqHAU/M
	Dg1NoyoI8c9QM1dM+wJ6dy5JFLmYLCDDuY7fXtTlbDfolPwhJrcD9faQi96NDiF2oHmHH/
	x/G7QimQMXSZWb4b0oJCyFOpIhXmMqPHYKY+CSTca/WyqI0w8b6YW8yMYLjiaw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1733401693;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+su9hKSmzkSrhS3hMFkehxB5TII3D2pOPIrs9yle89g=;
	b=ZkvvYoe4AfvRbkj/0Ek+qLkQwAj232XZADCTbVaCQmcpv2VymEXCmxZGmSDEKOUzv+g5tB
	2I20rhv2lRcHHCCg==
From: "tip-bot2 for Ard Biesheuvel" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: x86/boot] x86/boot/64: Determine VA/PA offset before entering C code
Cc: Ard Biesheuvel <ardb@kernel.org>, Ingo Molnar <mingo@kernel.org>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20241205112804.3416920-11-ardb+git@google.com>
References: <20241205112804.3416920-11-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173340169291.412.18285691270633032597.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/boot branch of tip:

Commit-ID:     093562198e1a6360672954293753f4c6cb9a3316
Gitweb:        https://git.kernel.org/tip/093562198e1a6360672954293753f4c6cb9a3316
Author:        Ard Biesheuvel <ardb@kernel.org>
AuthorDate:    Thu, 05 Dec 2024 12:28:07 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Thu, 05 Dec 2024 13:18:54 +01:00

x86/boot/64: Determine VA/PA offset before entering C code

Implicit absolute symbol references (e.g., taking the address of a
global variable) must be avoided in the C code that runs from the early
1:1 mapping of the kernel, given that this is a practice that violates
assumptions on the part of the toolchain. I.e., RIP-relative and
absolute references are expected to produce the same values, and so the
compiler is free to choose either. However, the code currently assumes
that RIP-relative references are never emitted here.

So an explicit virtual-to-physical offset needs to be used instead to
derive the kernel virtual addresses of _text and _end, instead of simply
taking the addresses and assuming that the compiler will not choose to
use a RIP-relative references in this particular case.

Currently, phys_base is already used to perform such calculations, but
it is derived from the kernel virtual address of _text, which is taken
using an implicit absolute symbol reference. So instead, derive this
VA-to-PA offset in asm code, and pass it to the C startup code.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Link: https://lore.kernel.org/r/20241205112804.3416920-11-ardb+git@google.com
---
 arch/x86/include/asm/setup.h |  2 +-
 arch/x86/kernel/head64.c     |  8 +++++---
 arch/x86/kernel/head_64.S    | 12 +++++++++---
 3 files changed, 15 insertions(+), 7 deletions(-)

diff --git a/arch/x86/include/asm/setup.h b/arch/x86/include/asm/setup.h
index 0667b2a..85f4fde 100644
--- a/arch/x86/include/asm/setup.h
+++ b/arch/x86/include/asm/setup.h
@@ -49,7 +49,7 @@ extern unsigned long saved_video_mode;
 
 extern void reserve_standard_io_resources(void);
 extern void i386_reserve_resources(void);
-extern unsigned long __startup_64(unsigned long physaddr, struct boot_params *bp);
+extern unsigned long __startup_64(unsigned long p2v_offset, struct boot_params *bp);
 extern void startup_64_setup_gdt_idt(void);
 extern void early_setup_idt(void);
 extern void __init do_early_exception(struct pt_regs *regs, int trapnr);
diff --git a/arch/x86/kernel/head64.c b/arch/x86/kernel/head64.c
index 4b9d455..a7cd405 100644
--- a/arch/x86/kernel/head64.c
+++ b/arch/x86/kernel/head64.c
@@ -138,12 +138,14 @@ static unsigned long __head sme_postprocess_startup(struct boot_params *bp, pmdv
  * doesn't have to generate PC-relative relocations when accessing globals from
  * that function. Clang actually does not generate them, which leads to
  * boot-time crashes. To work around this problem, every global pointer must
- * be accessed using RIP_REL_REF().
+ * be accessed using RIP_REL_REF(). Kernel virtual addresses can be determined
+ * by subtracting p2v_offset from the RIP-relative address.
  */
-unsigned long __head __startup_64(unsigned long physaddr,
+unsigned long __head __startup_64(unsigned long p2v_offset,
 				  struct boot_params *bp)
 {
 	pmd_t (*early_pgts)[PTRS_PER_PMD] = RIP_REL_REF(early_dynamic_pgts);
+	unsigned long physaddr = (unsigned long)&RIP_REL_REF(_text);
 	unsigned long pgtable_flags;
 	unsigned long load_delta;
 	pgdval_t *pgd;
@@ -163,7 +165,7 @@ unsigned long __head __startup_64(unsigned long physaddr,
 	 * Compute the delta between the address I am compiled to run at
 	 * and the address I am actually running at.
 	 */
-	load_delta = physaddr - (unsigned long)(_text - __START_KERNEL_map);
+	load_delta = __START_KERNEL_map + p2v_offset;
 	RIP_REL_REF(phys_base) = load_delta;
 
 	/* Is the address not 2M aligned? */
diff --git a/arch/x86/kernel/head_64.S b/arch/x86/kernel/head_64.S
index 56163e2..31345e0 100644
--- a/arch/x86/kernel/head_64.S
+++ b/arch/x86/kernel/head_64.S
@@ -95,12 +95,18 @@ SYM_CODE_START_NOALIGN(startup_64)
 	call verify_cpu
 
 	/*
+	 * Derive the kernel's physical-to-virtual offset from the physical and
+	 * virtual addresses of common_startup_64().
+	 */
+	leaq	common_startup_64(%rip), %rdi
+	subq	.Lcommon_startup_64(%rip), %rdi
+
+	/*
 	 * Perform pagetable fixups. Additionally, if SME is active, encrypt
 	 * the kernel and retrieve the modifier (SME encryption mask if SME
 	 * is active) to be added to the initial pgdir entry that will be
 	 * programmed into CR3.
 	 */
-	leaq	_text(%rip), %rdi
 	movq	%r15, %rsi
 	call	__startup_64
 
@@ -128,11 +134,11 @@ SYM_CODE_START_NOALIGN(startup_64)
 
 	/* Branch to the common startup code at its kernel virtual address */
 	ANNOTATE_RETPOLINE_SAFE
-	jmp	*0f(%rip)
+	jmp	*.Lcommon_startup_64(%rip)
 SYM_CODE_END(startup_64)
 
 	__INITRODATA
-0:	.quad	common_startup_64
+SYM_DATA_LOCAL(.Lcommon_startup_64, .quad common_startup_64)
 
 	.text
 SYM_CODE_START(secondary_startup_64)

