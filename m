Return-Path: <linux-tip-commits+bounces-4213-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 04942A60E94
	for <lists+linux-tip-commits@lfdr.de>; Fri, 14 Mar 2025 11:17:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CA9641B60B97
	for <lists+linux-tip-commits@lfdr.de>; Fri, 14 Mar 2025 10:17:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59E171F03C7;
	Fri, 14 Mar 2025 10:17:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="N7rOcszd";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="kCBbWfU7"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABB5D1EEA54;
	Fri, 14 Mar 2025 10:17:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741947428; cv=none; b=jOWbfVrCdwl4I9M1pIALuE7Q+KowQfjI5U8pv+GhRqaDqqfXmzG8ogmESrJVz0gdhpgqv9xuaU8gr3v42l95h0S+vWCvwQPddcMTaMF5B8LwMTwpsvcBibL4ooQtkpn5s5itI4pp97n2eDZWKrFjLgw+kK0czwb7ATnZ5PpTNUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741947428; c=relaxed/simple;
	bh=GElny8AJlFfTQUvvFDvOBylkmwecw2sp/9Dmjh6W9h0=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=lLJpLSoVNp9a98r9MTRNqgoNxLeqPUCk/pCD8v7gnGt2AYTXZWb4hlr+2m0C8JIOyRy6hv6LOc2TvGq9q2MNcb0gsqDaYWUpRlaK0dIILX2NvDwFhqhDDwkEHIBFkAcrDUOa9OZvmOaqhAgOakkJ342OSW5gKHegmIGyFk93beI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=N7rOcszd; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=kCBbWfU7; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 14 Mar 2025 10:16:57 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1741947424;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eWymMseujqYB7Jp1PIQpjkL6tDEWb1PW/g1EZTY8mFg=;
	b=N7rOcszd7B+qgoAF6Q/fObhDBnsAzblBcNtpJA3UJnF7ZeEZYmF3K827ttMsXcFpzEhNeK
	o5ol+sjnZqXDmswAd0E4dCW3tsJonBXRDcrksu+Sv45GNHSHBlhR5QwpOUyLu+/GBkP4A8
	vc0Hqy/bSdiC4ZgEDoIB9VIs4vO7SURwNF1IteGOwRRjSnPDu1mesH7eOtUfOIlp3n8TJh
	JPI/mIVFb/hMCF4ZpZ+LBI9lKJc4tG9dCEFS2GIlpElK6QEclpENXUUiRzf0ocsK/WZ6Fi
	XG0pdaBFqLE4nrFr91gwiOWIjKntxDxOICd5LpxqjLFbv0I5TYoF3a3gV5QTvg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1741947424;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eWymMseujqYB7Jp1PIQpjkL6tDEWb1PW/g1EZTY8mFg=;
	b=kCBbWfU7YNI/cPx4MRaaiKl/XYA64Uod16ekn1Q8xtsk75LlC51IQO4jVEcQ8XbyA5GsNT
	uKVYXEK47Za6pkBQ==
From: "tip-bot2 for David Woodhouse" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/boot] x86/kexec: Add relocate_kernel() debugging support:
 Load a GDT
Cc: David Woodhouse <dwmw@amazon.co.uk>, Ingo Molnar <mingo@kernel.org>,
 Andy Lutomirski <luto@kernel.org>, Brian Gerst <brgerst@gmail.com>,
 "H. Peter Anvin" <hpa@zytor.com>, Kees Cook <keescook@chromium.org>,
 Ard Biesheuvel <ardb@kernel.org>,
 Linus Torvalds <torvalds@linux-foundation.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250312144257.2348250-2-dwmw2@infradead.org>
References: <20250312144257.2348250-2-dwmw2@infradead.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174194741889.14745.5868283555442287108.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/boot branch of tip:

Commit-ID:     b25eb5f5e419b81f124d5ba2abaaacf1948fb97e
Gitweb:        https://git.kernel.org/tip/b25eb5f5e419b81f124d5ba2abaaacf1948fb97e
Author:        David Woodhouse <dwmw@amazon.co.uk>
AuthorDate:    Wed, 12 Mar 2025 14:34:13 
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Fri, 14 Mar 2025 11:01:53 +01:00

x86/kexec: Add relocate_kernel() debugging support: Load a GDT

There are some failure modes which lead to triple-faults in the
relocate_kernel() function, which is fairly much undebuggable
for normal mortals.

Adding a GDT in the relocate_kernel() environment is step 1 towards
being able to catch faults and do something more useful.

Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Brian Gerst <brgerst@gmail.com>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Kees Cook <keescook@chromium.org>
Cc: Ard Biesheuvel <ardb@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Link: https://lore.kernel.org/r/20250312144257.2348250-2-dwmw2@infradead.org
---
 arch/x86/kernel/relocate_kernel_64.S | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/arch/x86/kernel/relocate_kernel_64.S b/arch/x86/kernel/relocate_kernel_64.S
index b44d886..ac05897 100644
--- a/arch/x86/kernel/relocate_kernel_64.S
+++ b/arch/x86/kernel/relocate_kernel_64.S
@@ -40,6 +40,16 @@ SYM_DATA(kexec_pa_table_page, .quad 0)
 SYM_DATA(kexec_pa_swap_page, .quad 0)
 SYM_DATA_LOCAL(pa_backup_pages_map, .quad 0)
 
+	.balign 16
+SYM_DATA_START_LOCAL(kexec_debug_gdt)
+	.word   kexec_debug_gdt_end - kexec_debug_gdt - 1
+	.long   0
+	.word   0
+	.quad   0x00cf9a000000ffff      /* __KERNEL32_CS */
+	.quad   0x00af9a000000ffff      /* __KERNEL_CS */
+	.quad   0x00cf92000000ffff      /* __KERNEL_DS */
+SYM_DATA_END_LABEL(kexec_debug_gdt, SYM_L_LOCAL, kexec_debug_gdt_end)
+
 	.section .text..relocate_kernel,"ax";
 	.code64
 SYM_CODE_START_NOALIGN(relocate_kernel)
@@ -116,6 +126,19 @@ SYM_CODE_START_LOCAL_NOALIGN(identity_mapped)
 	/* store the start address on the stack */
 	pushq   %rdx
 
+	/* Create a GDTR (16 bits limit, 64 bits addr) on stack */
+	leaq	kexec_debug_gdt(%rip), %rax
+	pushq	%rax
+	pushw	(%rax)
+
+	/* Load the GDT, put the stack back */
+	lgdt	(%rsp)
+	addq	$10, %rsp
+
+	/* Test that we can load segments */
+	movq	%ds, %rax
+	movq	%rax, %ds
+
 	/*
 	 * Clear X86_CR4_CET (if it was set) such that we can clear CR0_WP
 	 * below.

