Return-Path: <linux-tip-commits+bounces-4172-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AC06A5F117
	for <lists+linux-tip-commits@lfdr.de>; Thu, 13 Mar 2025 11:42:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8F80317C78E
	for <lists+linux-tip-commits@lfdr.de>; Thu, 13 Mar 2025 10:42:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4A811EE013;
	Thu, 13 Mar 2025 10:42:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="JIt2T8As";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="soEbHpnH"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D202116BE17;
	Thu, 13 Mar 2025 10:42:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741862539; cv=none; b=pJ1HdFHD7nqXW2F9gv+0yEGYH+6o2yVcwRws9JS9x4LgJ9gWzpSxy8XvDeJMW1n+0KfWOvjqveCn0/wjSeU9xABImAnGkdgO4wwEvAknPZhmiElnkSPipRSIlh9a3KW+1cXJDZA2Y1wydc3UpRkD1k5PDRFdJ9tSAzTYmUjMA0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741862539; c=relaxed/simple;
	bh=MyDfGcjSR+l32B4n+i8hx+/DvEc0b6ieJflft7OtIFU=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=ikKOCl7c2yPZJAZUXYJytZNpCesjmT9xRt/ml5vmXd9ZOzqjat3v4SdU4wvEZlLLX1T5CXtYMszswiehh+Z4uT8lALVEWo0pQOiHsSTRn4cl2tVzZF1/8KiMm01nebD3F35lrjLTTzVkF8vzCXmWvP6ZuV6BLeDPCcaUThj+Irk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=JIt2T8As; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=soEbHpnH; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 13 Mar 2025 10:42:11 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1741862535;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sEtZG0GDr0i+LTUelLBlvHBsoo57jBGiMXvZ1EMv75I=;
	b=JIt2T8Asxw7o5SI/OGG2mAC7atLbK55jmP+Ck6t1HI7GAXTQtvztZsSOLcXfFvSODhOQQV
	UafkpTQ7e6+Bkk6H4I4PgG78fH4yLG6Ls7US8E71QiCeYMnK7RrmILeWjK32y33aBoRVfE
	L1zbvt1jmRi2ONmS2y16r9hpkbLeSl5/izfHOrc74IsScDkhUZ3Zu+7GHcyeMGfr44RuPf
	VbaAo2Rb917i2GOTPd+PMcC1gYUyGTsqwICfYO6uuyEx2kYVe9vppaZHVvk0A+0Z93pm0h
	zWY3SmNt70TX70VAIQu0LnfhYLVnR+BNnasB+xaVlw17EVWv4rxlvC7i6Q7rKA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1741862535;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sEtZG0GDr0i+LTUelLBlvHBsoo57jBGiMXvZ1EMv75I=;
	b=soEbHpnHwY10cWl68iLKg9bReu2Ifm4rcUjTMANJT8/LYiAYJFRtg2621/XCn1HUMhq3DD
	VCSch841KEh0YnBA==
From: "tip-bot2 for David Woodhouse" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/boot] x86/kexec: Add relocate_kernel() debugging support:
 Dump registers on exception
Cc: David Woodhouse <dwmw@amazon.co.uk>, Ingo Molnar <mingo@kernel.org>,
 Andy Lutomirski <luto@kernel.org>, Brian Gerst <brgerst@gmail.com>,
 "H. Peter Anvin" <hpa@zytor.com>, Kees Cook <keescook@chromium.org>,
 Ard Biesheuvel <ardb@kernel.org>,
 Linus Torvalds <torvalds@linux-foundation.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250312144257.2348250-4-dwmw2@infradead.org>
References: <20250312144257.2348250-4-dwmw2@infradead.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174186253141.14745.1690893715442978737.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/boot branch of tip:

Commit-ID:     d181cfc0609bcbbc1fb70dbd73f7aa9025c11b6b
Gitweb:        https://git.kernel.org/tip/d181cfc0609bcbbc1fb70dbd73f7aa9025c11b6b
Author:        David Woodhouse <dwmw@amazon.co.uk>
AuthorDate:    Wed, 12 Mar 2025 14:34:15 
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Thu, 13 Mar 2025 11:23:39 +01:00

x86/kexec: Add relocate_kernel() debugging support: Dump registers on exception

The actual serial output function is a no-op for now.

Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Brian Gerst <brgerst@gmail.com>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Kees Cook <keescook@chromium.org>
Cc: Ard Biesheuvel <ardb@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Link: https://lore.kernel.org/r/20250312144257.2348250-4-dwmw2@infradead.org
---
 arch/x86/kernel/relocate_kernel_64.S | 101 +++++++++++++++++++++++++-
 1 file changed, 98 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kernel/relocate_kernel_64.S b/arch/x86/kernel/relocate_kernel_64.S
index bce0cb7..e0af37e 100644
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
@@ -419,11 +482,43 @@ SYM_CODE_END(kexec_debug_exc_vectors)
 
 SYM_CODE_START_LOCAL_NOALIGN(exc_handler)
 	pushq	%rax
+	pushq	%rbx
+	pushq	%rcx
 	pushq	%rdx
-	movw	$0x3f8, %dx
-	movb	$'A', %al
-	outb	%al, %dx
+	pushq	%rsi
+
+	/* Set up %rdx/%rsi for debug output */
+	pr_setup
+
+	/* rip and exception info */
+	print_reg 'E', 'x', 'c', ':', 0x28(%rsp)
+	print_reg 'E', 'r', 'r', ':', 0x30(%rsp)
+	print_reg 'r', 'i', 'p', ':', 0x38(%rsp)
+	print_reg 'r', 's', 'p', ':', 0x50(%rsp)
+
+	/* We spilled these to the stack */
+	print_reg 'r', 'a', 'x', ':', 0x20(%rsp)
+	print_reg 'r', 'b', 'x', ':', 0x18(%rsp)
+	print_reg 'r', 'c', 'x', ':', 0x10(%rsp)
+	print_reg 'r', 'd', 'x', ':', 0x08(%rsp)
+
+	/* Other registers */
+	print_reg 'r', 's', 'i', ':', (%rsp)
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
+
+	popq	%rsi
 	popq	%rdx
+	popq	%rcx
+	popq	%rbx
 	popq	%rax
 
 	/* Only return from int3 */

