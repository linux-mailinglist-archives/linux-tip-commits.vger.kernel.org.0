Return-Path: <linux-tip-commits+bounces-4174-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D127FA5F11D
	for <lists+linux-tip-commits@lfdr.de>; Thu, 13 Mar 2025 11:42:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 201CF17D9F3
	for <lists+linux-tip-commits@lfdr.de>; Thu, 13 Mar 2025 10:42:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 926FF26618A;
	Thu, 13 Mar 2025 10:42:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="RoBKK+Rs";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="vb+9PQhI"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00DA9265CA5;
	Thu, 13 Mar 2025 10:42:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741862542; cv=none; b=gyB/oLx6b6029nkwGw+y1TPWDZJACWBPF0S11OzcB1jxlHRE0CMuae05rtwkUWyqAPObdHnaQkRWJsMePCQJZvY1jRePhajx8JrHuBrPMglrgWSbRZiexN+P24taInt+nCeW2SusjMwlK6I1QnTYUUT/UOMKJ/Q0B5K7bpDwO0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741862542; c=relaxed/simple;
	bh=89frrpae59407/seHN/aD3rSRAGpNQPZqXGHx1V5aA4=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=mq31UH/ErTqHBMbz85CokbVSqH4plIIpaqIF9lH+OC4nyMK5DDS3diC2xojepbRQ1FzOPOKjqznhopacBIAmwgeIEASS2R0m2JmDgR/73qF8owHKnCdhBgPuWQQafXijjBQO8fcSmGB/2ey6kP+bWwKDJVvDm8cLQnwU77YqY+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=RoBKK+Rs; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=vb+9PQhI; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 13 Mar 2025 10:42:16 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1741862536;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HmnHQgUoVSCfRTrbeU9Vm3AHKaQxKZYU1I4ZxcDroyE=;
	b=RoBKK+RsXVnVH3HP1rwXZpzQPgUmexMunXKnoyjNiB7G3Pczs1O1A/SnBk4sQ69PRV/rB0
	rc2ON8JSCqfdJr6Gi1wnlK7GSxJp+LGIKToJTL0MxnYmLWZwOp19MvSgo5hoceR8wMa/Dq
	/lGdFXfK7BO98d61CL8WSs5t4EMJVGL9rx6UoogRrOlncTgKe6cxKgipdy8aW479t8JBjF
	TIrypp5zdbicUxhSDaXXhEOovmlO7hkJuLKPcr7RZNKzxG8O0Y4Pd4ULP9R/rP82/dJVyA
	153lgfOEB37eE5feosiyKYy/QloyNslg1k6VyQnaGf+5r1OqFRMuPE9PQ4vV4Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1741862536;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HmnHQgUoVSCfRTrbeU9Vm3AHKaQxKZYU1I4ZxcDroyE=;
	b=vb+9PQhIDNoB/D1MfPw1JNAj0BUC+TPZtryIPSf3/7/DGzqdeVRw24T0xnm1SjwI/v4TgI
	GsRo4VmBYL4iXxDw==
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
Message-ID: <174186253602.14745.9025061893846353110.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/boot branch of tip:

Commit-ID:     afb305d6831b930571b5413cec239289ef164b55
Gitweb:        https://git.kernel.org/tip/afb305d6831b930571b5413cec239289ef164b55
Author:        David Woodhouse <dwmw@amazon.co.uk>
AuthorDate:    Wed, 12 Mar 2025 14:34:13 
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Thu, 13 Mar 2025 11:23:31 +01:00

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

