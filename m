Return-Path: <linux-tip-commits+bounces-3507-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C46EA39BDC
	for <lists+linux-tip-commits@lfdr.de>; Tue, 18 Feb 2025 13:14:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3C0C33B06CD
	for <lists+linux-tip-commits@lfdr.de>; Tue, 18 Feb 2025 12:12:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B90CB24338B;
	Tue, 18 Feb 2025 12:11:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="yO+Ia+Gk";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="fkH9EiTn"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FBA5241C90;
	Tue, 18 Feb 2025 12:11:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739880708; cv=none; b=RekZvg+x67pt/KEbl5OIx9LLKPtmIJuxOpweOf5AGEcXPo8A/Q4luo9O/O+CdiOVPSmupG9wIlMjS9658qA1y/Mg7eJcPAr/sSzroPacEfpbhgVfGgNQPy6Syf0U6LXJgf0HILK//fF/3t2dDxDmGDfnWRzTKRQiomNsoWcf0xQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739880708; c=relaxed/simple;
	bh=PitH3zRQotHcY74so7tzkwUHJlILD64KpIzJFShVboI=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=fU1d5Fc18RvgIwWRJq2DBpoAXzIWP9mJ4NFh59mD0oilec51OaHvTPMzPsvevpQhTnu7E4QAB9mshMszSQrbyKtskSGf9VhaceUKkuYB1IaZW8BETo3Sl49mvIIUKnuWi62ykVZ7LgS3GH+VWq76CXsNodYeEMb2r09Cern9Jig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=yO+Ia+Gk; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=fkH9EiTn; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 18 Feb 2025 12:11:45 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1739880705;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OHyyHQ3XIObgWehefI3ZFi4JWuFAu1lpuUiQ1uao1eE=;
	b=yO+Ia+GkWC0q98iLhL8feP+wwf0JRHX/uhliDBGtEdqgU5e3IF9fC6asZ+gmaJ5PfwgCzm
	/+oPjN8XLEo+N4YIo9bLtJkmH0dW/CVKhGMLGsW7kfvps2xCvTWh+3lxqxv83hK3C1cZZj
	EBXgGkMbDwa9+JNGlCF98u4oWRxkSfeqNde94kjFh+Wsb66dr2s5u7lO44cfaPNT80zfX5
	qbXxVP9yPqgfd0jJIUZ13AfpGqYNS6iwrxp9+2wOZASq0bbmqk4MnBbAo8QONQKO8D6Iqw
	iRyIWdsxmUfDhIklHkUvLb6iPcFn7TSaOcv+xagYotjsIBxclQaDlNDiMC/s3w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1739880705;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OHyyHQ3XIObgWehefI3ZFi4JWuFAu1lpuUiQ1uao1eE=;
	b=fkH9EiTnBQBe+F1Lpzeky0K11z7nN1c1nO1jtnyE3wVF+jKF0uDCsffkUqsCvFzcQhhMUZ
	7vkFNejqcWkCG+DQ==
From: "tip-bot2 for Brian Gerst" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/asm] x86/percpu/64: Remove fixed_percpu_data
Cc: Brian Gerst <brgerst@gmail.com>, Ingo Molnar <mingo@kernel.org>,
 Ard Biesheuvel <ardb@kernel.org>, Uros Bizjak <ubizjak@gmail.com>,
 Linus Torvalds <torvalds@linux-foundation.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250123190747.745588-10-brgerst@gmail.com>
References: <20250123190747.745588-10-brgerst@gmail.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173988070520.10177.816809442742762032.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/asm branch of tip:

Commit-ID:     b5c4f95351a097a635c1a7fc8d9efa18308491b5
Gitweb:        https://git.kernel.org/tip/b5c4f95351a097a635c1a7fc8d9efa18308491b5
Author:        Brian Gerst <brgerst@gmail.com>
AuthorDate:    Thu, 23 Jan 2025 14:07:41 -05:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 18 Feb 2025 10:15:43 +01:00

x86/percpu/64: Remove fixed_percpu_data

Now that the stack protector canary value is a normal percpu variable,
fixed_percpu_data is unused and can be removed.

Signed-off-by: Brian Gerst <brgerst@gmail.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Reviewed-by: Ard Biesheuvel <ardb@kernel.org>
Reviewed-by: Uros Bizjak <ubizjak@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Link: https://lore.kernel.org/r/20250123190747.745588-10-brgerst@gmail.com
---
 arch/x86/include/asm/processor.h | 8 --------
 arch/x86/kernel/cpu/common.c     | 4 ----
 arch/x86/kernel/vmlinux.lds.S    | 1 -
 arch/x86/tools/relocs.c          | 1 -
 4 files changed, 14 deletions(-)

diff --git a/arch/x86/include/asm/processor.h b/arch/x86/include/asm/processor.h
index b8fee88..b3d1537 100644
--- a/arch/x86/include/asm/processor.h
+++ b/arch/x86/include/asm/processor.h
@@ -421,14 +421,6 @@ struct irq_stack {
 } __aligned(IRQ_STACK_SIZE);
 
 #ifdef CONFIG_X86_64
-struct fixed_percpu_data {
-	char		gs_base[40];
-	unsigned long	reserved;
-};
-
-DECLARE_PER_CPU_FIRST(struct fixed_percpu_data, fixed_percpu_data) __visible;
-DECLARE_INIT_PER_CPU(fixed_percpu_data);
-
 static inline unsigned long cpu_kernelmode_gs_base(int cpu)
 {
 #ifdef CONFIG_SMP
diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index b71178f..8b49b13 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -2023,10 +2023,6 @@ EXPORT_PER_CPU_SYMBOL(pcpu_hot);
 EXPORT_PER_CPU_SYMBOL(const_pcpu_hot);
 
 #ifdef CONFIG_X86_64
-DEFINE_PER_CPU_FIRST(struct fixed_percpu_data,
-		     fixed_percpu_data) __aligned(PAGE_SIZE) __visible;
-EXPORT_PER_CPU_SYMBOL_GPL(fixed_percpu_data);
-
 static void wrmsrl_cstar(unsigned long val)
 {
 	/*
diff --git a/arch/x86/kernel/vmlinux.lds.S b/arch/x86/kernel/vmlinux.lds.S
index 8a59851..93c2fa8 100644
--- a/arch/x86/kernel/vmlinux.lds.S
+++ b/arch/x86/kernel/vmlinux.lds.S
@@ -477,7 +477,6 @@ PROVIDE(__ref_stack_chk_guard = __stack_chk_guard);
  */
 #define INIT_PER_CPU(x) init_per_cpu__##x = ABSOLUTE(x)
 INIT_PER_CPU(gdt_page);
-INIT_PER_CPU(fixed_percpu_data);
 INIT_PER_CPU(irq_stack_backing_store);
 
 #ifdef CONFIG_MITIGATION_UNRET_ENTRY
diff --git a/arch/x86/tools/relocs.c b/arch/x86/tools/relocs.c
index 3cb3b30..b5e3695 100644
--- a/arch/x86/tools/relocs.c
+++ b/arch/x86/tools/relocs.c
@@ -830,7 +830,6 @@ static void percpu_init(void)
  *	__per_cpu_load
  *
  * The "gold" linker incorrectly associates:
- *	init_per_cpu__fixed_percpu_data
  *	init_per_cpu__gdt_page
  */
 static int is_percpu_sym(ElfW(Sym) *sym, const char *symname)

