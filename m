Return-Path: <linux-tip-commits+bounces-3239-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EAED8A11D5B
	for <lists+linux-tip-commits@lfdr.de>; Wed, 15 Jan 2025 10:21:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E10A416144F
	for <lists+linux-tip-commits@lfdr.de>; Wed, 15 Jan 2025 09:21:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12441244FA8;
	Wed, 15 Jan 2025 09:17:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="CFrFW/kV";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="H35ZDk7a"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE302246A0A;
	Wed, 15 Jan 2025 09:17:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736932678; cv=none; b=TRoe6FTQU8gT9hAcOcf3zHBousLSuEFJUZFvJVgY2vfc77QUYv4Nc27Dxlv2GNH+F/oo+fbvxAzY99xL2kO0qpF/+B8PUkfmemNL5v2QV4MoNtn4SQMTJRazNP3skPC/huouP4x33Wz3KVnYP9u3J2E1lgCnsn82TKv9pUz5NHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736932678; c=relaxed/simple;
	bh=vUvPPNdHo+pMRvM472Ug7mmDQs4D+nFwZqP4Iotv9uk=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=tnVZUfQzos0bj0uSqtam+7UPCx6KvMjgBzMPSbf7CEZTnmdlUZKTslmm6xGoJrc4iCrgE3SAjkaYD3CocQUjZIVhx0tCcIUzJr0YmjRLTiSyAV5OWh5MY4Ly+xci8nHcvwbg/D9aKQjX8wSWsygJ32rRRrprI5vF26DeTPumJqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=CFrFW/kV; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=H35ZDk7a; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 15 Jan 2025 09:17:53 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1736932673;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cWfwiXdmVrlY1E/e81QNT5v1gXHvLbLsWptn6wUX0ao=;
	b=CFrFW/kV0waP3jE5WbpOfl2tYuS+VzMx9TNs01B1o/m/I0w3eo/bIfi5574mL0wWLy3vb8
	DHHcH/5lMWoiSfKcxUz/SV0O0Ek5xhime4QMtirVFLK28u8JAv6W3I9pyIyRFJi/h+q2vL
	jLiBi7tukzuiP5kO5cUO+XntGyeACClNoEohhwex4XmYZSd6Nk1PkZQoxHdwcJ0C37daSP
	5X+Wg5SHfxwvxz1DB+vAYF++WqjvnC2Q03mZOMaK75zWPKYfvbdOsAR5eRdwBR5t44kBP8
	kLOIfvtfoAD3sADv2PsElxtjjP/QDUO0f+p/eyERwPVcgXbHmvYzcFqfhQHJlQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1736932673;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cWfwiXdmVrlY1E/e81QNT5v1gXHvLbLsWptn6wUX0ao=;
	b=H35ZDk7ao1ltGAcTza6irw92YMwcjJd61ZCDlBiSvhpkcO65W24pX0/lpfUNLvj3fq7YKl
	hzU8nowWn04Y2TCQ==
From: "tip-bot2 for David Woodhouse" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/boot] x86/kexec: Fix stack and handling of re-entry point
 for ::preserve_context
Cc: David Woodhouse <dwmw@amazon.co.uk>,
 "Borislav Petkov (AMD)" <bp@alien8.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250109140757.2841269-5-dwmw2@infradead.org>
References: <20250109140757.2841269-5-dwmw2@infradead.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173693267304.31546.4208780200507168576.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/boot branch of tip:

Commit-ID:     2cacf7f23a024ab1fdc603ca6a4f4c8b2de9f64e
Gitweb:        https://git.kernel.org/tip/2cacf7f23a024ab1fdc603ca6a4f4c8b2de9f64e
Author:        David Woodhouse <dwmw@amazon.co.uk>
AuthorDate:    Thu, 09 Jan 2025 14:04:16 
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Tue, 14 Jan 2025 12:57:43 +01:00

x86/kexec: Fix stack and handling of re-entry point for ::preserve_context

A ::preserve_context kimage can be invoked more than once, and the entry point
can be different every time. When the callee returns to the kernel, it leaves
the address of its entry point for next time on the stack.

That being the case, one might reasonably assume that the caller would
allocate space for it on the stack frame before actually performing the 'call'
into the callee.

Apparently not, though. Ever since the kjump code was first added in 2009, it
has set up a *new* stack at the top of the swap_page scratch page, then just
performed the 'call' without allocating any space for the re-entry address to
be returned. It then reads the re-entry point for next time from 0(%rsp) which
is actually the first qword of the page *after* the swap page, which might not
exist at all! And if the callee has written to that, then it will have
corrupted memory it doesn't own.

Correct this by pushing the entry point of the callee onto the stack before
calling it. The callee may then adjust it, or not, as it sees fit, and
subsequent invocations should work correctly either way.

Remove a stray push of zero to the *relocate_kernel* stack, which may have
been intended for this purpose, but which was actually just noise.

Also, loading the stack for the callee relied on the address of the swap page
being in %r10 without ever documenting that fact. Recent code changes made
that no longer true, so load it directly from the local kexec_pa_swap_page
variable instead.

Fixes: b3adabae8a96 ("x86/kexec: Drop page_list argument from relocate_kernel()")
Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://lore.kernel.org/r/20250109140757.2841269-5-dwmw2@infradead.org
---
 arch/x86/kernel/relocate_kernel_64.S | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kernel/relocate_kernel_64.S b/arch/x86/kernel/relocate_kernel_64.S
index 3ca3bf6..a95691b 100644
--- a/arch/x86/kernel/relocate_kernel_64.S
+++ b/arch/x86/kernel/relocate_kernel_64.S
@@ -113,8 +113,6 @@ SYM_CODE_START_LOCAL_NOALIGN(identity_mapped)
 	 * %r13 original CR4 when relocate_kernel() was invoked
 	 */
 
-	/* set return address to 0 if not preserving context */
-	pushq	$0
 	/* store the start address on the stack */
 	pushq   %rdx
 
@@ -208,12 +206,19 @@ SYM_CODE_START_LOCAL_NOALIGN(identity_mapped)
 
 .Lrelocate:
 	popq	%rdx
+
+	/* Use the swap page for the callee's stack */
+	movq	kexec_pa_swap_page(%rip), %r10
 	leaq	PAGE_SIZE(%r10), %rsp
+
+	/* push the existing entry point onto the callee's stack */
+	pushq	%rdx
+
 	ANNOTATE_RETPOLINE_SAFE
 	call	*%rdx
 
 	/* get the re-entry point of the peer system */
-	movq	0(%rsp), %rbp
+	popq	%rbp
 	leaq	relocate_kernel(%rip), %r8
 	movq	kexec_pa_swap_page(%rip), %r10
 	movq	pa_backup_pages_map(%rip), %rdi
@@ -247,6 +252,7 @@ SYM_CODE_START_LOCAL_NOALIGN(virtual_mapped)
 	lgdt    saved_context_gdt_desc(%rax)
 #endif
 
+	/* relocate_kernel() returns the re-entry point for next time */
 	movq	%rbp, %rax
 
 	popf

