Return-Path: <linux-tip-commits+bounces-4532-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 47C2DA6FA7D
	for <lists+linux-tip-commits@lfdr.de>; Tue, 25 Mar 2025 12:58:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 112B3189787C
	for <lists+linux-tip-commits@lfdr.de>; Tue, 25 Mar 2025 11:58:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B17EA2566F2;
	Tue, 25 Mar 2025 11:57:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="XwW3qB3a";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="B4bMfp5N"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C703033EC;
	Tue, 25 Mar 2025 11:57:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742903878; cv=none; b=ZHoQDIOBJwsBHdsu3OwVYgyHfj323w+LI5lP8yDfNcsSHbMxwfWHoJhP4LdtFiJru7GSGDNsOpPUWEmx/IdJnyPIK5cXRsatKCMYkSjbMhmhTx66PuCL52uW+2AbX/gEa2LCa7Rliglx1tcimQg+mdwoypSsp6bxT88qYySYRm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742903878; c=relaxed/simple;
	bh=UgTwq2NBneMevPP+bZCuKovzgTvYnfLtSc+TAv1d+vs=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=iCFsrLCWAKeUf+ONJM6uREkVP74ODQPjvXE7iod336kpCaLz18YwHdg3Vdqif4TXU1YCKxyq/wLWqM965UVUE0gK65mhe6RNDg1j8Ak2+IvG/IrRSH/wlMn0XVAhfzG4JdIlQltJQ2tumhNIHgLEfgCEzcHRGxtZkWeCWsd0/dg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=XwW3qB3a; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=B4bMfp5N; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 25 Mar 2025 11:57:54 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1742903875;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=q5a8XOG/YtneO65M8TYxcglOhwTy757udMRr6gdrz1M=;
	b=XwW3qB3afxaqkMNH8/zK5o/7orvzmsXVgFHQhEqh/ipPEhDIMiGfLhuG96EBQ1JBwS0zRn
	Wp/dV1+7xYERj04VYg9/uPb31epxEhUPGHWYxo2RuQTNW65kBk/c8Qf6j2263iRWS4n20K
	XEmEwMNkDAcwJjkahM0qGmt8e2IpR6sejg3K6gRoHPD/fEgER85kPsqX/ZRutq2ssT2flK
	ICTsqR7u6E3JIbUKoO7ajs3ro8IkC+AoL7bsxsFP6JV/yq4s2PEP9mQviPgtgJ2CiF0lD+
	tjULDulF/M0gu4hZL7FlCSrGAH2eyu9EUptj9iRSvSOw+phmabPXvlz6zplPIw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1742903875;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=q5a8XOG/YtneO65M8TYxcglOhwTy757udMRr6gdrz1M=;
	b=B4bMfp5NDZO92Z+WyYFPeWZ3juMHUvZyqepQW1udOoteMJ5F67Hx5aanMcHh89PTqai3Vr
	zFp6AW/j4e86NCDw==
From: "tip-bot2 for David Woodhouse" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/asm] x86/kexec: Debugging support: Load an IDT and basic
 exception entry points
Cc: David Woodhouse <dwmw@amazon.co.uk>, Ingo Molnar <mingo@kernel.org>,
 Brian Gerst <brgerst@gmail.com>, Juergen Gross <jgross@suse.com>,
 "H. Peter Anvin" <hpa@zytor.com>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Josh Poimboeuf <jpoimboe@redhat.com>, Kees Cook <keescook@chromium.org>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250314173226.3062535-2-dwmw2@infradead.org>
References: <20250314173226.3062535-2-dwmw2@infradead.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174290387446.14745.14729239454593584550.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/asm branch of tip:

Commit-ID:     8df505af7fefe34573fdd1eacdd2b3381349c45c
Gitweb:        https://git.kernel.org/tip/8df505af7fefe34573fdd1eacdd2b3381349c45c
Author:        David Woodhouse <dwmw@amazon.co.uk>
AuthorDate:    Fri, 14 Mar 2025 17:27:33 
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 25 Mar 2025 12:49:05 +01:00

x86/kexec: Debugging support: Load an IDT and basic exception entry points

[ mingo: Minor readability edits ]

Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Brian Gerst <brgerst@gmail.com>
Cc: Juergen Gross <jgross@suse.com>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Kees Cook <keescook@chromium.org>
Link: https://lore.kernel.org/r/20250314173226.3062535-2-dwmw2@infradead.org
---
 arch/x86/include/asm/kexec.h         |  5 ++-
 arch/x86/kernel/machine_kexec_64.c   | 21 +++++++-
 arch/x86/kernel/relocate_kernel_64.S | 77 +++++++++++++++++++++++++++-
 3 files changed, 103 insertions(+)

diff --git a/arch/x86/include/asm/kexec.h b/arch/x86/include/asm/kexec.h
index 5432457..fb4537c 100644
--- a/arch/x86/include/asm/kexec.h
+++ b/arch/x86/include/asm/kexec.h
@@ -8,6 +8,9 @@
 # define PA_PGD			2
 # define PA_SWAP_PAGE		3
 # define PAGES_NR		4
+#else
+/* Size of each exception handler referenced by the IDT */
+# define KEXEC_DEBUG_EXC_HANDLER_SIZE	6 /* PUSHI, PUSHI, 2-byte JMP */
 #endif
 
 # define KEXEC_CONTROL_PAGE_SIZE	4096
@@ -59,6 +62,8 @@ struct kimage;
 extern unsigned long kexec_va_control_page;
 extern unsigned long kexec_pa_table_page;
 extern unsigned long kexec_pa_swap_page;
+extern gate_desc kexec_debug_idt[];
+extern unsigned char kexec_debug_exc_vectors[];
 #endif
 
 /*
diff --git a/arch/x86/kernel/machine_kexec_64.c b/arch/x86/kernel/machine_kexec_64.c
index a68f5a0..cc73f97 100644
--- a/arch/x86/kernel/machine_kexec_64.c
+++ b/arch/x86/kernel/machine_kexec_64.c
@@ -304,6 +304,24 @@ static void load_segments(void)
 		);
 }
 
+static void prepare_debug_idt(unsigned long control_page, unsigned long vec_ofs)
+{
+	gate_desc idtentry = { 0 };
+	int i;
+
+	idtentry.bits.p		= 1;
+	idtentry.bits.type	= GATE_TRAP;
+	idtentry.segment	= __KERNEL_CS;
+	idtentry.offset_low	= (control_page & 0xFFFF) + vec_ofs;
+	idtentry.offset_middle	= (control_page >> 16) & 0xFFFF;
+	idtentry.offset_high	= control_page >> 32;
+
+	for (i = 0; i < 16; i++) {
+		kexec_debug_idt[i] = idtentry;
+		idtentry.offset_low += KEXEC_DEBUG_EXC_HANDLER_SIZE;
+	}
+}
+
 int machine_kexec_prepare(struct kimage *image)
 {
 	void *control_page = page_address(image->control_code_page);
@@ -321,6 +339,9 @@ int machine_kexec_prepare(struct kimage *image)
 	if (image->type == KEXEC_TYPE_DEFAULT)
 		kexec_pa_swap_page = page_to_pfn(image->swap_page) << PAGE_SHIFT;
 
+	prepare_debug_idt((unsigned long)__pa(control_page),
+			  (unsigned long)kexec_debug_exc_vectors - reloc_start);
+
 	__memcpy(control_page, __relocate_kernel_start, reloc_end - reloc_start);
 
 	set_memory_rox((unsigned long)control_page, 1);
diff --git a/arch/x86/kernel/relocate_kernel_64.S b/arch/x86/kernel/relocate_kernel_64.S
index ac05897..8f26ffd 100644
--- a/arch/x86/kernel/relocate_kernel_64.S
+++ b/arch/x86/kernel/relocate_kernel_64.S
@@ -50,6 +50,11 @@ SYM_DATA_START_LOCAL(kexec_debug_gdt)
 	.quad   0x00cf92000000ffff      /* __KERNEL_DS */
 SYM_DATA_END_LABEL(kexec_debug_gdt, SYM_L_LOCAL, kexec_debug_gdt_end)
 
+	.balign 8
+SYM_DATA_START(kexec_debug_idt)
+	.skip 0x100, 0x00
+SYM_DATA_END(kexec_debug_idt)
+
 	.section .text..relocate_kernel,"ax";
 	.code64
 SYM_CODE_START_NOALIGN(relocate_kernel)
@@ -139,6 +144,15 @@ SYM_CODE_START_LOCAL_NOALIGN(identity_mapped)
 	movq	%ds, %rax
 	movq	%rax, %ds
 
+	/* Now an IDTR on the stack to load the IDT the kernel created */
+	leaq	kexec_debug_idt(%rip), %rsi
+	pushq	%rsi
+	pushw	$0xff
+	lidt	(%rsp)
+	addq	$10, %rsp
+
+	//int3
+
 	/*
 	 * Clear X86_CR4_CET (if it was set) such that we can clear CR0_WP
 	 * below.
@@ -364,3 +378,66 @@ SYM_CODE_START_LOCAL_NOALIGN(swap_pages)
 	ret
 	int3
 SYM_CODE_END(swap_pages)
+
+SYM_CODE_START_NOALIGN(kexec_debug_exc_vectors)
+	/* Each of these is 6 bytes. */
+.macro vec_err exc
+	UNWIND_HINT_ENTRY
+	. = kexec_debug_exc_vectors + (\exc * KEXEC_DEBUG_EXC_HANDLER_SIZE)
+	nop
+	nop
+	pushq	$\exc
+	jmp	exc_handler
+.endm
+
+.macro vec_noerr exc
+	UNWIND_HINT_ENTRY
+	. = kexec_debug_exc_vectors + (\exc * KEXEC_DEBUG_EXC_HANDLER_SIZE)
+	pushq	$0
+	pushq	$\exc
+	jmp	exc_handler
+.endm
+
+	ANNOTATE_NOENDBR
+	vec_noerr  0 // #DE
+	vec_noerr  1 // #DB
+	vec_noerr  2 // #NMI
+	vec_noerr  3 // #BP
+	vec_noerr  4 // #OF
+	vec_noerr  5 // #BR
+	vec_noerr  6 // #UD
+	vec_noerr  7 // #NM
+	vec_err    8 // #DF
+	vec_noerr  9
+	vec_err   10 // #TS
+	vec_err   11 // #NP
+	vec_err   12 // #SS
+	vec_err   13 // #GP
+	vec_err   14 // #PF
+	vec_noerr 15
+SYM_CODE_END(kexec_debug_exc_vectors)
+
+SYM_CODE_START_LOCAL_NOALIGN(exc_handler)
+	/* No need for RET mitigations during kexec */
+	VALIDATE_UNRET_END
+
+	pushq	%rax
+	pushq	%rdx
+	movw	$0x3f8, %dx
+	movb	$'A', %al
+	outb	%al, %dx
+	popq	%rdx
+	popq	%rax
+
+	/* Only return from INT3 */
+	cmpq	$3, (%rsp)
+	jne	.Ldie
+
+	addq	$16, %rsp
+	iretq
+
+.Ldie:
+	hlt
+	jmp	.Ldie
+
+SYM_CODE_END(exc_handler)

