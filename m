Return-Path: <linux-tip-commits+bounces-4533-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 57DD6A6FA7B
	for <lists+linux-tip-commits@lfdr.de>; Tue, 25 Mar 2025 12:58:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8DF6D1704BA
	for <lists+linux-tip-commits@lfdr.de>; Tue, 25 Mar 2025 11:58:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF878256C65;
	Tue, 25 Mar 2025 11:57:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Dt5yk0R7";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="9Id7/MOA"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C70982566DE;
	Tue, 25 Mar 2025 11:57:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742903878; cv=none; b=TeA+nLdU8vuawWWHICWWk7GuzieC2Ifo7MI8PRLalQ9Egg4/pTJL5N0L7yqxL0T3hfkENrWpXRd7kDu18hBXc0NZeHJAHatWyGDtWHIBHXLqkz4LYt0r8ZFEqZgChjUeC1yeNYycGb1DAS3oezzTum39zfzHrTuoYPCPX4beDRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742903878; c=relaxed/simple;
	bh=gow2/ksm0v1uVcmLyDcsdHXfmC7ituNJBBiQFhQuiPI=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=DpBbO2CtNSCOZOt16zubmEdsuA4NxIJhwkiKD1XZ+lDbogJ4MyG4IbJOggCAsih0dgjLCXtoKq/oHz2lOo7drBTa57TGtjVSojafDpQu0SatpCCAOIV5jeaIGSsqiaLh9R2I0XkLwCqurDaYNjynulub05vByBfbzIJs9AL0YqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Dt5yk0R7; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=9Id7/MOA; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 25 Mar 2025 11:57:50 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1742903874;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KuoNKzDLjG3dTjyakixSvwtTm4IEEJRKl0cWeBrwvXU=;
	b=Dt5yk0R7mhtlqxUTVakN/NE/61IWryMP/nNr9BAQMsZ472cPBDlj0FLkdb5x1k9eZXa8zj
	0ECb7TOZWO6nIx9VOnrIYrkSRG24kCW4nMfxcloJk2+dTFujB636ysv+mzXNFRIMshw02a
	P2fuGbCe6jHKQXbvBw/yR8WfUgP+emfpvNEvf4KLP5HQrrJk742iHF+4nyo2Fjp8fQ2/eX
	5ez8e3LBGYfKIR/05obpHpTspNknHdH7cTESpZoTpKAYIVL5uAjGh4WGEAaRdU0BOkKbAE
	+w2rKsq0rJSslpXvqnRg9ByMgdcbkSVI29x5foArS3pezfSfbgexofj1I2VN7w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1742903874;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KuoNKzDLjG3dTjyakixSvwtTm4IEEJRKl0cWeBrwvXU=;
	b=9Id7/MOARPsR5eaUlPq7LfHX+N7vpfyYeuqpEKfFlTfp4rtoglVpwlUUYuTXwhDRi5fMS0
	BBLwPPLyZn1w9aBw==
From: "tip-bot2 for David Woodhouse" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: x86/asm] x86/kexec: Debugging support: Dump registers on exception
Cc: David Woodhouse <dwmw@amazon.co.uk>, Ingo Molnar <mingo@kernel.org>,
 Brian Gerst <brgerst@gmail.com>, Juergen Gross <jgross@suse.com>,
 "H. Peter Anvin" <hpa@zytor.com>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Josh Poimboeuf <jpoimboe@redhat.com>, Kees Cook <keescook@chromium.org>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250314173226.3062535-3-dwmw2@infradead.org>
References: <20250314173226.3062535-3-dwmw2@infradead.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174290387080.14745.5028811145419628375.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/asm branch of tip:

Commit-ID:     3d66af75b08609281cbd7b71d40bbb9829c88764
Gitweb:        https://git.kernel.org/tip/3d66af75b08609281cbd7b71d40bbb9829c88764
Author:        David Woodhouse <dwmw@amazon.co.uk>
AuthorDate:    Fri, 14 Mar 2025 17:27:34 
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 25 Mar 2025 12:49:05 +01:00

x86/kexec: Debugging support: Dump registers on exception

The actual serial output function is a no-op for now.

Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Brian Gerst <brgerst@gmail.com>
Cc: Juergen Gross <jgross@suse.com>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Kees Cook <keescook@chromium.org>
Link: https://lore.kernel.org/r/20250314173226.3062535-3-dwmw2@infradead.org
---
 arch/x86/kernel/relocate_kernel_64.S | 121 ++++++++++++++++++++++++--
 1 file changed, 115 insertions(+), 6 deletions(-)

diff --git a/arch/x86/kernel/relocate_kernel_64.S b/arch/x86/kernel/relocate_kernel_64.S
index 8f26ffd..29cb399 100644
--- a/arch/x86/kernel/relocate_kernel_64.S
+++ b/arch/x86/kernel/relocate_kernel_64.S
@@ -379,6 +379,69 @@ SYM_CODE_START_LOCAL_NOALIGN(swap_pages)
 	int3
 SYM_CODE_END(swap_pages)
 
+/*
+ * Generic 'print character' routine (as yet unimplemented)
+ *  - %al: Character to be printed (may clobber %rax)
+ *  - %rdx: MMIO address or port.
+ */
+SYM_CODE_START_LOCAL_NOALIGN(pr_char)
+	UNWIND_HINT_FUNC
+	ANNOTATE_NOENDBR
+	ANNOTATE_UNRET_SAFE
+	ret
+SYM_CODE_END(pr_char)
+
+/*
+ * Load pr_char function pointer into %rsi and load %rdx with whatever
+ * that function wants to see there (typically port/MMIO address).
+ */
+.macro	pr_setup
+	/* No output; pr_char just returns */
+	leaq	pr_char(%rip), %rsi
+.endm
+
+/* Print the nybble in %bl, clobber %rax */
+SYM_CODE_START_LOCAL_NOALIGN(pr_nybble)
+	UNWIND_HINT_FUNC
+	movb	%bl, %al
+	nop
+	andb	$0x0f, %al
+	addb	$0x30, %al
+	cmpb	$0x3a, %al
+	jb	1f
+	addb	$('a' - '0' - 10), %al
+	ANNOTATE_RETPOLINE_SAFE
+1:	jmp	*%rsi
+SYM_CODE_END(pr_nybble)
+
+SYM_CODE_START_LOCAL_NOALIGN(pr_qword)
+	UNWIND_HINT_FUNC
+	movq	$16, %rcx
+1:	rolq	$4, %rbx
+	call	pr_nybble
+	loop	1b
+	movb	$'\n', %al
+	ANNOTATE_RETPOLINE_SAFE
+	jmp	*%rsi
+SYM_CODE_END(pr_qword)
+
+.macro print_reg a, b, c, d, r
+	movb	$\a, %al
+	ANNOTATE_RETPOLINE_SAFE
+	call	*%rsi
+	movb	$\b, %al
+	ANNOTATE_RETPOLINE_SAFE
+	call	*%rsi
+	movb	$\c, %al
+	ANNOTATE_RETPOLINE_SAFE
+	call	*%rsi
+	movb	$\d, %al
+	ANNOTATE_RETPOLINE_SAFE
+	call	*%rsi
+	movq	\r, %rbx
+	call	pr_qword
+.endm
+
 SYM_CODE_START_NOALIGN(kexec_debug_exc_vectors)
 	/* Each of these is 6 bytes. */
 .macro vec_err exc
@@ -422,17 +485,63 @@ SYM_CODE_START_LOCAL_NOALIGN(exc_handler)
 	VALIDATE_UNRET_END
 
 	pushq	%rax
+	pushq	%rbx
+	pushq	%rcx
 	pushq	%rdx
-	movw	$0x3f8, %dx
-	movb	$'A', %al
-	outb	%al, %dx
-	popq	%rdx
-	popq	%rax
+	pushq	%rsi
+
+	/* Stack frame */
+#define EXC_SS		0x58 /* Architectural... */
+#define EXC_RSP		0x50
+#define EXC_EFLAGS	0x48
+#define EXC_CS		0x40
+#define EXC_RIP		0x38
+#define EXC_ERRORCODE	0x30 /* Either architectural or zero pushed by handler */
+#define EXC_EXCEPTION	0x28 /* Pushed by handler entry point */
+#define EXC_RAX		0x20 /* Pushed just above in exc_handler */
+#define EXC_RBX		0x18
+#define EXC_RCX		0x10
+#define EXC_RDX		0x08
+#define EXC_RSI		0x00
+
+	/* Set up %rdx/%rsi for debug output */
+	pr_setup
+
+	/* rip and exception info */
+	print_reg 'E', 'x', 'c', ':', EXC_EXCEPTION(%rsp)
+	print_reg 'E', 'r', 'r', ':', EXC_ERRORCODE(%rsp)
+	print_reg 'r', 'i', 'p', ':', EXC_RIP(%rsp)
+	print_reg 'r', 's', 'p', ':', EXC_RSP(%rsp)
+
+	/* We spilled these to the stack */
+	print_reg 'r', 'a', 'x', ':', EXC_RAX(%rsp)
+	print_reg 'r', 'b', 'x', ':', EXC_RBX(%rsp)
+	print_reg 'r', 'c', 'x', ':', EXC_RCX(%rsp)
+	print_reg 'r', 'd', 'x', ':', EXC_RDX(%rsp)
+	print_reg 'r', 's', 'i', ':', EXC_RSI(%rsp)
+
+	/* Other registers untouched */
+	print_reg 'r', 'd', 'i', ':', %rdi
+	print_reg 'r', '8', ' ', ':', %r8
+	print_reg 'r', '9', ' ', ':', %r9
+	print_reg 'r', '1', '0', ':', %r10
+	print_reg 'r', '1', '1', ':', %r11
+	print_reg 'r', '1', '2', ':', %r12
+	print_reg 'r', '1', '3', ':', %r13
+	print_reg 'r', '1', '4', ':', %r14
+	print_reg 'r', '1', '5', ':', %r15
+	print_reg 'c', 'r', '2', ':', %cr2
 
 	/* Only return from INT3 */
-	cmpq	$3, (%rsp)
+	cmpq	$3, EXC_EXCEPTION(%rsp)
 	jne	.Ldie
 
+	popq	%rsi
+	popq	%rdx
+	popq	%rcx
+	popq	%rbx
+	popq	%rax
+
 	addq	$16, %rsp
 	iretq
 

