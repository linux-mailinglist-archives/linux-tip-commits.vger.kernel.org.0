Return-Path: <linux-tip-commits+bounces-3242-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D04B5A11D6C
	for <lists+linux-tip-commits@lfdr.de>; Wed, 15 Jan 2025 10:22:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EB5543A9599
	for <lists+linux-tip-commits@lfdr.de>; Wed, 15 Jan 2025 09:21:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 803EE244FB6;
	Wed, 15 Jan 2025 09:17:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="UqRfkMld";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="7ttWjuDz"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 736EB244F85;
	Wed, 15 Jan 2025 09:17:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736932678; cv=none; b=fQdwrJeLPgETkBU4THMBd0Ecw5HhF0/t9Igqm88CJ7J2eqGNiVI8fJCi6+ELr/q9SRDIQ+FvvcSwenekhXI0wd4jmfg+oBhoMhSOwbEEzHlwFuOsuoFNu6LSLaZcowE2RtC3JS7sR+ddiTikHGq5GFXjm6+dN1JLKc/7tMeswk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736932678; c=relaxed/simple;
	bh=Y8UtbOsKk9W3hTElzLt7oVDt4cXW7xREH2WyVF3ynWc=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=MCCsxibT37mvyCvnoWFwgI1+HCHE6A49G8HJa/DMHkcZCzn/5Qzai87HmikrQfXfHQ7luggU5UvoNdfRUw8CtVIKcWEQ/iPhCe7yx1p6OHvVcCfnizuX3P54t3vSBdhofMXK8jYZm1JjNuCUNBgeHMm80paFOZIOY633wfUfrZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=UqRfkMld; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=7ttWjuDz; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 15 Jan 2025 09:17:53 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1736932674;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UynKoL4rcc0Vc9u09FdOwWmVduX4w6D6RKdPsULxbM4=;
	b=UqRfkMldmqjxTwNZYdsvBAjH1+rcrFkLATFiLKhv5iIZp48bceup+py4Tau59fAjIdSsxH
	iP9wsu0+qM8Fi1Lbe0ppgtXACLpZ8ejpv48F21mp8/d+lBZ6Fd23ZnHruJ+X34ZbKB5VRG
	o4WaTwQ+qs1CrKnktsCHMQ5R46Emn88x3sze5wjRy1ZhDq1eL6kxpZ7erMTPQ4+1UARJDc
	uSChnKCBoYssE+AaQTrlwzdgEyWqZTKtbbxpWCeIp+AIYFLpues08f+imhnjXo1h2tQKLy
	sAPXm9+kX8tf1ZleWh30JZQb6rMJQ4aleIzVSbA1Cg6v53pTTXilI78QhS99wg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1736932674;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UynKoL4rcc0Vc9u09FdOwWmVduX4w6D6RKdPsULxbM4=;
	b=7ttWjuDzJYWQarFFyvT1Qfc+MKppw2SkeXl7eKQrFt/x2SpviL33uF1AbzZcJbbpSPkNqG
	fHpARAFTRqS+vPBA==
From: "tip-bot2 for David Woodhouse" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/boot] x86/kexec: Ensure preserve_context flag is set on
 return to kernel
Cc: David Woodhouse <dwmw@amazon.co.uk>,
 "Borislav Petkov (AMD)" <bp@alien8.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250109140757.2841269-3-dwmw2@infradead.org>
References: <20250109140757.2841269-3-dwmw2@infradead.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173693267387.31546.10614687190445554474.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/boot branch of tip:

Commit-ID:     4d5f1da98f5e94ecc39d6e7a990db2efe0ae3810
Gitweb:        https://git.kernel.org/tip/4d5f1da98f5e94ecc39d6e7a990db2efe0ae3810
Author:        David Woodhouse <dwmw@amazon.co.uk>
AuthorDate:    Thu, 09 Jan 2025 14:04:14 
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Tue, 14 Jan 2025 12:52:47 +01:00

x86/kexec: Ensure preserve_context flag is set on return to kernel

The swap_pages() function will only actually *swap*, as its name implies, if
the preserve_context flag in the %r11 register is non-zero. On the way back
from a ::preserve_context kexec, ensure that the %r11 register is non-zero so
that the pages get swapped back.

Fixes: 9e5683e2d0b5 ("x86/kexec: Only swap pages for ::preserve_context mode")
Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://lore.kernel.org/r/20250109140757.2841269-3-dwmw2@infradead.org
---
 arch/x86/kernel/relocate_kernel_64.S | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/kernel/relocate_kernel_64.S b/arch/x86/kernel/relocate_kernel_64.S
index 9bd601d..6fce4b4 100644
--- a/arch/x86/kernel/relocate_kernel_64.S
+++ b/arch/x86/kernel/relocate_kernel_64.S
@@ -220,6 +220,7 @@ SYM_CODE_START_LOCAL_NOALIGN(identity_mapped)
 	movq	kexec_pa_table_page(%rip), %rax
 	movq	%rax, %cr3
 	lea	PAGE_SIZE(%r8), %rsp
+	movl	$1, %r11d	/* Ensure preserve_context flag is set */
 	call	swap_pages
 	movq	kexec_va_control_page(%rip), %rax
 	addq	$(virtual_mapped - relocate_kernel), %rax

