Return-Path: <linux-tip-commits+bounces-3235-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EF3CA11D55
	for <lists+linux-tip-commits@lfdr.de>; Wed, 15 Jan 2025 10:21:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 23132188603A
	for <lists+linux-tip-commits@lfdr.de>; Wed, 15 Jan 2025 09:21:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F211242251;
	Wed, 15 Jan 2025 09:17:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ID48e+2y";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="lkEdVNAQ"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E7311EEA34;
	Wed, 15 Jan 2025 09:17:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736932675; cv=none; b=is0g+nyAI7pxP/+1BxQfJJnUWwZVfRGG3v1LmKYObdXUtIap649kf0XNJbh4zM4dvX2MvRjzJrww489w/51hDls1umhFC68PNZiLdsA8jTGBS4f5+ju/Y/Znm8wZr8+34Bp1qT0ffPUGGH3fOexzm9A5aQXcXsOIpCbeucALQi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736932675; c=relaxed/simple;
	bh=/0rovuonlF0SxtIPpJ66VyRnn6MuTBk0+bstZhTbOgA=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=OLsnY7g0TppbuBrIghFzl+tyWXYKKcpGQ8E/whhIthFKYWFAUfnpDndmuXO1y17Nm5LFJb5WLbti7vZq8NBMavoLLnRwHJZB7HOMxv3wHIV2RRltIL8JiZhAsfeexdrQ5fXRIiw5ackM/3ZSTMnpy3Gqy1YJuLj5EV2GFs33xLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ID48e+2y; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=lkEdVNAQ; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 15 Jan 2025 09:17:50 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1736932671;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JTmMYhqCuSQOl1x1OfZK8fBFCM5F9N3KNgjxqMp1Gsw=;
	b=ID48e+2yqKXIM121OWyy9zzIvpxZt7HOag+Cfw/22VuhfHVey5u710boAaQ5jhK95PJfeW
	vAYbCwvvWKoKBo79N53HcUrRImSl23CQHzwWXimQk/x5SNRlk/k5/Rp+QrmmGVEJ49Ixso
	EVG6SoBw2G461+KzOak2ES8FHOH2ksQD6+KAy0lceAQjSiOEfEIcO/Z9urHYq4AeLJ6G/1
	PPLhVXz7Zo6uWiLuP7KkE07RBCwdDsH2HCSaSK5d+KCV9M/DIGhE2Xx5RjVLFTzedQdw6+
	wudh09PqwtZGh6gY3c6XkYYXo9Iu0s8Cf1QbapXQm5kIRGxSl8f+IUhN9QOunw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1736932671;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JTmMYhqCuSQOl1x1OfZK8fBFCM5F9N3KNgjxqMp1Gsw=;
	b=lkEdVNAQht0BFAEUUZ6Aq1tUR+vIzTjrYYRIKQRbQWCZE4yJn+PPeZmNSi5o4KiJthsu2I
	hE1Ui1jT5EjsFkBQ==
From: "tip-bot2 for David Woodhouse" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/boot] x86/kexec: Use typedef for relocate_kernel_fn
 function prototype
Cc: David Woodhouse <dwmw@amazon.co.uk>,
 "Borislav Petkov (AMD)" <bp@alien8.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250109140757.2841269-10-dwmw2@infradead.org>
References: <20250109140757.2841269-10-dwmw2@infradead.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173693267099.31546.3766901516400980865.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/boot branch of tip:

Commit-ID:     7c61a3d8f7a8cf0f0cbdc8459dd86782ba7285f1
Gitweb:        https://git.kernel.org/tip/7c61a3d8f7a8cf0f0cbdc8459dd86782ba7285f1
Author:        David Woodhouse <dwmw@amazon.co.uk>
AuthorDate:    Thu, 09 Jan 2025 14:04:21 
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Tue, 14 Jan 2025 13:09:08 +01:00

x86/kexec: Use typedef for relocate_kernel_fn function prototype

Both i386 and x86_64 now copy the relocate_kernel() function into the control
page and execute it from there, using an open-coded function pointer.

Use a typedef for it instead.

  [ bp: Put relocate_kernel_ptr ptr arithmetic on a single line. ]

Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://lore.kernel.org/r/20250109140757.2841269-10-dwmw2@infradead.org
---
 arch/x86/include/asm/kexec.h       | 26 +++++++++++++-------------
 arch/x86/kernel/machine_kexec_32.c |  7 +------
 arch/x86/kernel/machine_kexec_64.c |  9 ++-------
 3 files changed, 16 insertions(+), 26 deletions(-)

diff --git a/arch/x86/include/asm/kexec.h b/arch/x86/include/asm/kexec.h
index 48e4f44..8ad1874 100644
--- a/arch/x86/include/asm/kexec.h
+++ b/arch/x86/include/asm/kexec.h
@@ -111,21 +111,21 @@ static inline void crash_setup_regs(struct pt_regs *newregs,
 }
 
 #ifdef CONFIG_X86_32
-asmlinkage unsigned long
-relocate_kernel(unsigned long indirection_page,
-		unsigned long control_page,
-		unsigned long start_address,
-		unsigned int has_pae,
-		unsigned int preserve_context);
+typedef asmlinkage unsigned long
+relocate_kernel_fn(unsigned long indirection_page,
+		   unsigned long control_page,
+		   unsigned long start_address,
+		   unsigned int has_pae,
+		   unsigned int preserve_context);
 #else
-unsigned long
-relocate_kernel(unsigned long indirection_page,
-		unsigned long pa_control_page,
-		unsigned long start_address,
-		unsigned int preserve_context,
-		unsigned int host_mem_enc_active);
+typedef unsigned long
+relocate_kernel_fn(unsigned long indirection_page,
+		   unsigned long pa_control_page,
+		   unsigned long start_address,
+		   unsigned int preserve_context,
+		   unsigned int host_mem_enc_active);
 #endif
-
+extern relocate_kernel_fn relocate_kernel;
 #define ARCH_HAS_KIMAGE_ARCH
 
 #ifdef CONFIG_X86_32
diff --git a/arch/x86/kernel/machine_kexec_32.c b/arch/x86/kernel/machine_kexec_32.c
index 1b373d7..8026516 100644
--- a/arch/x86/kernel/machine_kexec_32.c
+++ b/arch/x86/kernel/machine_kexec_32.c
@@ -160,15 +160,10 @@ void machine_kexec_cleanup(struct kimage *image)
  */
 void machine_kexec(struct kimage *image)
 {
+	relocate_kernel_fn *relocate_kernel_ptr;
 	unsigned long page_list[PAGES_NR];
 	void *control_page;
 	int save_ftrace_enabled;
-	asmlinkage unsigned long
-		(*relocate_kernel_ptr)(unsigned long indirection_page,
-				       unsigned long control_page,
-				       unsigned long start_address,
-				       unsigned int has_pae,
-				       unsigned int preserve_context);
 
 #ifdef CONFIG_KEXEC_JUMP
 	if (image->preserve_context)
diff --git a/arch/x86/kernel/machine_kexec_64.c b/arch/x86/kernel/machine_kexec_64.c
index 1440f79..a68f5a0 100644
--- a/arch/x86/kernel/machine_kexec_64.c
+++ b/arch/x86/kernel/machine_kexec_64.c
@@ -344,12 +344,8 @@ void machine_kexec_cleanup(struct kimage *image)
  */
 void __nocfi machine_kexec(struct kimage *image)
 {
-	unsigned long (*relocate_kernel_ptr)(unsigned long indirection_page,
-					     unsigned long pa_control_page,
-					     unsigned long start_address,
-					     unsigned int preserve_context,
-					     unsigned int host_mem_enc_active);
 	unsigned long reloc_start = (unsigned long)__relocate_kernel_start;
+	relocate_kernel_fn *relocate_kernel_ptr;
 	unsigned int host_mem_enc_active;
 	int save_ftrace_enabled;
 	void *control_page;
@@ -391,8 +387,7 @@ void __nocfi machine_kexec(struct kimage *image)
 	 * Allow for the possibility that relocate_kernel might not be at
 	 * the very start of the page.
 	 */
-	relocate_kernel_ptr = control_page + (unsigned long)relocate_kernel -
-		reloc_start;
+	relocate_kernel_ptr = control_page + (unsigned long)relocate_kernel - reloc_start;
 
 	/*
 	 * The segment registers are funny things, they have both a

