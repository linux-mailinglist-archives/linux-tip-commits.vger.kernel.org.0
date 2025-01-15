Return-Path: <linux-tip-commits+bounces-3234-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E529DA11D5E
	for <lists+linux-tip-commits@lfdr.de>; Wed, 15 Jan 2025 10:21:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 814A43AA246
	for <lists+linux-tip-commits@lfdr.de>; Wed, 15 Jan 2025 09:21:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F34701FECBD;
	Wed, 15 Jan 2025 09:17:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="TDcduMpn";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="AyXT+bEx"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4835D23F29F;
	Wed, 15 Jan 2025 09:17:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736932674; cv=none; b=Pz/GU50D8oAFsVMKbFA6A5l8quGREVaOphVXdDDNy/lvPv0unv7NkMpRBGUOfkwB1/IXdKpC+DvNC4fJeIzQOaV0e2xpAAwsPPAko/rlSaucU4bjXqrDY/tjImL0UpxLFWvXiuZ2xgd5JHBP5TkwSg5KWVTWxVrEJNWaxAP0Qv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736932674; c=relaxed/simple;
	bh=+sl1m2h/Y5rYRTWdBbMGhpTYJfNSqyhPYHbmQ3uTGJI=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=NfGCIZDxL5gciALZ4GJ3ysum3+m8WFlaKs9R40acWBHH0PBX/pA+W12SDwxNHbOgjh9VzxMWSGT/w32ms89evqDa/ULMG6T8A19DnRtf5JHxRR7lx1v4CpvhKz9QuACmnwhnH4phk0tnnQE+nejtpqTBtALMLiShbTh6MBYx7pI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=TDcduMpn; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=AyXT+bEx; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 15 Jan 2025 09:17:51 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1736932671;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UNG1awlwPgIkaqXO83JX3cLphsyFaweNiUJFiQ1JOgU=;
	b=TDcduMpnOppNYeF95Aw8ZC0tRI3wXyR01+cS0sUqgotx4jV9WRu8CoYJuGKdaNyodUdVun
	t6yirP6fBAIsQL1C/gt7vN96X3IQY7lD8yat6oNZs+PTh25OxROwOWVFyprX9gRy8S3ZHk
	8IytsJadEczYCemLOxLB0ErADFAoSyQzp+oZrjhuR5LbSDB6jB7rH26zS94pgzlrMM+iEd
	6jZC0/+VUXVgcpoPr6rRZwgFAce2AJhbJuhmbzp7hZzh3k8hgHfFws/YvTeM0d/rG/CA7w
	dNKpPvKNBF2UboLhxsjpbG+VgEX8/gI5/u/WMR6vdP1T9QAF657V0N5QUqYaXg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1736932671;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UNG1awlwPgIkaqXO83JX3cLphsyFaweNiUJFiQ1JOgU=;
	b=AyXT+bExb86vfe45Md6Yu3Dpg28z+9eCUMgSYB849NJOwjWROwDUqWhyKtLZZn55+dBfyF
	bOQVntFwaUbU/PCw==
From: "tip-bot2 for David Woodhouse" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/boot] x86/kexec: Cope with relocate_kernel() not being at
 the start of the page
Cc: David Woodhouse <dwmw@amazon.co.uk>,
 "Borislav Petkov (AMD)" <bp@alien8.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250109140757.2841269-9-dwmw2@infradead.org>
References: <20250109140757.2841269-9-dwmw2@infradead.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173693267141.31546.5740974396625504050.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/boot branch of tip:

Commit-ID:     e536057543791fbfa0d979f4e782933ea312c38c
Gitweb:        https://git.kernel.org/tip/e536057543791fbfa0d979f4e782933ea312c38c
Author:        David Woodhouse <dwmw@amazon.co.uk>
AuthorDate:    Thu, 09 Jan 2025 14:04:20 
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Tue, 14 Jan 2025 13:05:14 +01:00

x86/kexec: Cope with relocate_kernel() not being at the start of the page

A few places in the kexec control code page make the assumption that the first
instruction of relocate_kernel is at the very start of the page.

To allow for Clang CFI information to be added to relocate_kernel(), as well
as the general principle of removing unwarranted assumptions, fix them to use
the external __relocate_kernel_start symbol that the linker adds. This means
using a separate addq and subq for calculating offsets, as the assembler can
no longer calculate the delta directly for itself and relocations aren't that
versatile. But those values can at least be used relative to a local label to
avoid absolute relocations.

Turn the jump from relocate_kernel() to identity_mapped() into a real indirect
'jmp *%rsi' too, while touching it. There was no real reason for it to be
a push+ret in the first place, and adding Clang CFI info will also give
objtool enough visibility to start complaining 'return with modified stack
frame' about it.

  [ bp: Massage commit message. ]

Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://lore.kernel.org/r/20250109140757.2841269-9-dwmw2@infradead.org
---
 arch/x86/kernel/relocate_kernel_64.S | 18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

diff --git a/arch/x86/kernel/relocate_kernel_64.S b/arch/x86/kernel/relocate_kernel_64.S
index 14ed40b..af2cd06 100644
--- a/arch/x86/kernel/relocate_kernel_64.S
+++ b/arch/x86/kernel/relocate_kernel_64.S
@@ -95,11 +95,10 @@ SYM_CODE_START_NOALIGN(relocate_kernel)
 	lea	PAGE_SIZE(%rsi), %rsp
 
 	/* jump to identity mapped page */
-	addq	$(identity_mapped - relocate_kernel), %rsi
-	pushq	%rsi
-	ANNOTATE_UNRET_SAFE
-	ret
-	int3
+0:	addq	$identity_mapped - 0b, %rsi
+	subq	$__relocate_kernel_start - 0b, %rsi
+	ANNOTATE_RETPOLINE_SAFE
+	jmp	*%rsi
 SYM_CODE_END(relocate_kernel)
 
 SYM_CODE_START_LOCAL_NOALIGN(identity_mapped)
@@ -219,16 +218,21 @@ SYM_CODE_START_LOCAL_NOALIGN(identity_mapped)
 
 	/* get the re-entry point of the peer system */
 	popq	%rbp
-	leaq	relocate_kernel(%rip), %r8
 	movq	kexec_pa_swap_page(%rip), %r10
 	movq	pa_backup_pages_map(%rip), %rdi
 	movq	kexec_pa_table_page(%rip), %rax
 	movq	%rax, %cr3
+
+	/* Find start (and end) of this physical mapping of control page */
+	leaq	(%rip), %r8
+	ANNOTATE_NOENDBR
+	andq	$PAGE_MASK, %r8
 	lea	PAGE_SIZE(%r8), %rsp
 	movl	$1, %r11d	/* Ensure preserve_context flag is set */
 	call	swap_pages
 	movq	kexec_va_control_page(%rip), %rax
-	addq	$(virtual_mapped - relocate_kernel), %rax
+0:	addq	$virtual_mapped - 0b, %rax
+	subq	$__relocate_kernel_start - 0b, %rax
 	pushq	%rax
 	ANNOTATE_UNRET_SAFE
 	ret

