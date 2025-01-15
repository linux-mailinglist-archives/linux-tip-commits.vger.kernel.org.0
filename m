Return-Path: <linux-tip-commits+bounces-3241-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 652F0A11D5C
	for <lists+linux-tip-commits@lfdr.de>; Wed, 15 Jan 2025 10:21:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AC38E18867D8
	for <lists+linux-tip-commits@lfdr.de>; Wed, 15 Jan 2025 09:21:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 502D9244FAF;
	Wed, 15 Jan 2025 09:17:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="4g9TpA4D";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="SZboW/G6"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E82B244F84;
	Wed, 15 Jan 2025 09:17:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736932678; cv=none; b=izlE3NsatC1mP4Xoe849pZx3/l1s30Lye8F/rtMSdyxxehvbC4nWJ4hotsULF8qT1dd80ketqnGOuenYozk9WoAJBBEefkWKmjUVEjEwHcr+1hxoF+NO5reUDbYmjH9ZzmQnX7eItj3T8rAq7Xlvf9C8O8jfYIJW9WUIUmhc5MQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736932678; c=relaxed/simple;
	bh=lwtoSzqNjksGWDDy0GVdLsYLno+LFxMFbjjwksghPY8=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=iAabI2w6a2MssBPsnFzZLQIa4ZwcxoU0z+D0RRzXEpfXk1rCUaVRgz8/C0ve4pmMnDJOnj/Z+u0iSN+1huX/NZH427qwgMnnLSjxRrKUPGr8uHutd6w9SakckQ5zWH2zEHMFMnKMlrewIVCfEXsMdyJManToW6x/m0BvriV0hAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=4g9TpA4D; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=SZboW/G6; arc=none smtp.client-ip=193.142.43.55
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
	bh=kbMiKed2/lgDISkkzwPz9ppCUcVQHcqpTttm63mOZxY=;
	b=4g9TpA4D/yQKkMf2EJW9CHsTYH4VEJGcrh8v8FjCodqBNXRb7IHIMnpxxqQmMW2dWozHf6
	Fgh17JKxefonRWH6E9nSX3SpxG6CYhWV/CIqXc35ON9HBV1Lma6lHDP0RvPJPCSW/Zx4or
	Z3x9SqmXyBj8xLWJ1UiYfFR1HFMZ9YPCLSbrHJwGkBlvN9nF/SZmYpw58Hfb7rKmXm5RAf
	tzV1zhHLfEoZNdHg5exdD9sF59EjbWbjNRg3l2CcrydvXkbH5DOYig2GwEwPzZ6k/yDe/N
	Oc/HWgvxqL8uGGNguR4GwRQHu5GjEQBAJp4Pf/WrvLwZr0z2gN54WdU/0EZRvw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1736932674;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kbMiKed2/lgDISkkzwPz9ppCUcVQHcqpTttm63mOZxY=;
	b=SZboW/G6lEXq824nMZO1avdIgO9lt1ZdMdVslxym2Ukdk6ky1+m3uCj/mzs1dCfEX++imH
	9jnNI62RzXXrH9CA==
From: "tip-bot2 for David Woodhouse" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: x86/boot] x86/kexec: Use correct swap page in swap_pages function
Cc: David Woodhouse <dwmw@amazon.co.uk>,
 "Borislav Petkov (AMD)" <bp@alien8.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250109140757.2841269-4-dwmw2@infradead.org>
References: <20250109140757.2841269-4-dwmw2@infradead.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173693267343.31546.9337371110273352401.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/boot branch of tip:

Commit-ID:     85d724df8c82c060dcdeb8d0de0bd986e6c37b72
Gitweb:        https://git.kernel.org/tip/85d724df8c82c060dcdeb8d0de0bd986e6c37b72
Author:        David Woodhouse <dwmw@amazon.co.uk>
AuthorDate:    Thu, 09 Jan 2025 14:04:15 
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Tue, 14 Jan 2025 12:54:36 +01:00

x86/kexec: Use correct swap page in swap_pages function

The swap_pages function expects the swap page to be in %r10, but there
was no documentation to that effect. Once upon a time the setup code
used to load its value from a kernel virtual address and save it to an
address which is accessible in the identity-mapped page tables, and
*happened* to use %r10 to do so, with no comment that it was left there
on *purpose* instead of just being a scratch register. Once that was no
longer necessary, %r10 just holds whatever the kernel happened to leave
in it.

Now that the original value passed by the kernel is accessible via
%rip-relative addressing, load directly from there instead of using %r10
for it. But document the other parameters that the swap_pages function
*does* expect in registers.

Fixes: b3adabae8a96 ("x86/kexec: Drop page_list argument from relocate_kernel()")
Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://lore.kernel.org/r/20250109140757.2841269-4-dwmw2@infradead.org
---
 arch/x86/kernel/relocate_kernel_64.S | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/relocate_kernel_64.S b/arch/x86/kernel/relocate_kernel_64.S
index 6fce4b4..3ca3bf6 100644
--- a/arch/x86/kernel/relocate_kernel_64.S
+++ b/arch/x86/kernel/relocate_kernel_64.S
@@ -264,6 +264,10 @@ SYM_CODE_END(virtual_mapped)
 	/* Do the copies */
 SYM_CODE_START_LOCAL_NOALIGN(swap_pages)
 	UNWIND_HINT_END_OF_STACK
+	/*
+	 * %rdi indirection page
+	 * %r11 preserve_context
+	 */
 	movq	%rdi, %rcx	/* Put the indirection_page in %rcx */
 	xorl	%edi, %edi
 	xorl	%esi, %esi
@@ -302,7 +306,7 @@ SYM_CODE_START_LOCAL_NOALIGN(swap_pages)
 	jz	.Lnoswap
 
 	/* copy source page to swap page */
-	movq	%r10, %rdi
+	movq	kexec_pa_swap_page(%rip), %rdi
 	movl	$512, %ecx
 	rep ; movsq
 
@@ -314,7 +318,7 @@ SYM_CODE_START_LOCAL_NOALIGN(swap_pages)
 
 	/* copy swap page to destination page */
 	movq	%rdx, %rdi
-	movq	%r10, %rsi
+	movq	kexec_pa_swap_page(%rip), %rsi
 .Lnoswap:
 	movl	$512, %ecx
 	rep ; movsq

