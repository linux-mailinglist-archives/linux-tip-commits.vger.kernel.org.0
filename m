Return-Path: <linux-tip-commits+bounces-3008-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D1A579E6BED
	for <lists+linux-tip-commits@lfdr.de>; Fri,  6 Dec 2024 11:21:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8C850288477
	for <lists+linux-tip-commits@lfdr.de>; Fri,  6 Dec 2024 10:21:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A307720D50E;
	Fri,  6 Dec 2024 10:17:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="oz4l/PLT";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="NUWNfOD0"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E338B202C30;
	Fri,  6 Dec 2024 10:16:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733480220; cv=none; b=lr3UMP85lTx5AY/0k8KwoZzdTIr6j8WcOQX4Me/JHE311/UbWOTNbsr83thx+IGUJ4Yz5tJtmLFTuHevDpQKjdOM7kzDClvqwV8iIQhs4oVXqOCccVHccWg4I4ziiNvjRPSG2JDPaTv5iJRBRvzy8DtFUfz17TOCrckiU4oMv3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733480220; c=relaxed/simple;
	bh=iWiSHoNLaq/SDNDeTdJC672hXxTN4CmbTwp/zeU0JSI=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=bIwg/ZSHX898aZcKd6OJo18ofXL0+E4NEsomXjaDQVptEcg+cIlPtgLy2A+61BWl9V8Sufw/4tlU4J+5sWK12+rYLi2vaN/qroxH3IjthMk9vvCcVVhFlZwOF4K2W9GP9J7bc3XkQZbhK7gU5orNCtsTdRO3TdpZbOVD9tz8HTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=oz4l/PLT; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=NUWNfOD0; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 06 Dec 2024 10:16:54 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1733480215;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=r8tAJFRrpYxeW7nKhc1TQcqdug4vI72WIluKt88nAm0=;
	b=oz4l/PLTO5X3JyrVyP+RfRbzo4yV3mq9oKta024uqgW6D62ty3KrjVSTdBWx0Ng4njHREO
	cahMXKU3dITY7PSm+CTKnsynqcwXSvPAc1M08JoMC64PwjMGOqQV3WbPs/8TfZrl5pT6h0
	x1R83Co+ZKvCfbai80zIlojRfkjwb7Jkoiv5/6jbymfI7/KK1LtzwnVP1QQ+RkTAPTIlHS
	ROqx3hkNrmn5Q/lPhcyhUab0QbO2rBUF4BbLv1NQis78o2FlKfrZzUV/8uzmh/dEWaUezS
	vTIhBGtTSy3yOuQMXZFwqCmuRmmFBlzL5/ZbMnP8fisoghuzXelTaR9KTFljMw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1733480215;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=r8tAJFRrpYxeW7nKhc1TQcqdug4vI72WIluKt88nAm0=;
	b=NUWNfOD0rXBGVRa9M9ebW+m8bAl3L4109hW7//zdZIZLrSnkj7/rXGrufbMkKp4lrzSdEJ
	HGTG7fR+utbXPLDQ==
From: "tip-bot2 for Juergen Gross" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cpu] x86/paravirt: Remove the WBINVD callback
Cc: Juergen Gross <jgross@suse.com>, Ingo Molnar <mingo@kernel.org>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20241203071550.26487-1-jgross@suse.com>
References: <20241203071550.26487-1-jgross@suse.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173348021446.412.8378612838011605003.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/cpu branch of tip:

Commit-ID:     29188c16006176caee6cb6729103be51a29c1a93
Gitweb:        https://git.kernel.org/tip/29188c16006176caee6cb6729103be51a29c1a93
Author:        Juergen Gross <jgross@suse.com>
AuthorDate:    Tue, 03 Dec 2024 08:15:50 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Fri, 06 Dec 2024 11:01:36 +01:00

x86/paravirt: Remove the WBINVD callback

The pv_ops::cpu.wbinvd paravirt callback is a leftover of lguest times.
Today it is no longer needed, as all users use the native WBINVD
implementation.

Remove the callback and rename native_wbinvd() to wbinvd().

Signed-off-by: Juergen Gross <jgross@suse.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/20241203071550.26487-1-jgross@suse.com
---
 arch/x86/include/asm/paravirt.h           | 7 -------
 arch/x86/include/asm/paravirt_types.h     | 2 --
 arch/x86/include/asm/special_insns.h      | 8 +-------
 arch/x86/kernel/cpu/resctrl/pseudo_lock.c | 2 +-
 arch/x86/kernel/paravirt.c                | 6 ------
 arch/x86/kernel/process.c                 | 4 ++--
 arch/x86/xen/enlighten_pv.c               | 2 --
 7 files changed, 4 insertions(+), 27 deletions(-)

diff --git a/arch/x86/include/asm/paravirt.h b/arch/x86/include/asm/paravirt.h
index d4eb9e1..041aff5 100644
--- a/arch/x86/include/asm/paravirt.h
+++ b/arch/x86/include/asm/paravirt.h
@@ -180,13 +180,6 @@ static inline void halt(void)
 	PVOP_VCALL0(irq.halt);
 }
 
-extern noinstr void pv_native_wbinvd(void);
-
-static __always_inline void wbinvd(void)
-{
-	PVOP_ALT_VCALL0(cpu.wbinvd, "wbinvd", ALT_NOT_XEN);
-}
-
 static inline u64 paravirt_read_msr(unsigned msr)
 {
 	return PVOP_CALL1(u64, cpu.read_msr, msr);
diff --git a/arch/x86/include/asm/paravirt_types.h b/arch/x86/include/asm/paravirt_types.h
index 8d4fbe1..fea56b0 100644
--- a/arch/x86/include/asm/paravirt_types.h
+++ b/arch/x86/include/asm/paravirt_types.h
@@ -86,8 +86,6 @@ struct pv_cpu_ops {
 	void (*update_io_bitmap)(void);
 #endif
 
-	void (*wbinvd)(void);
-
 	/* cpuid emulation, mostly so that caps bits can be disabled */
 	void (*cpuid)(unsigned int *eax, unsigned int *ebx,
 		      unsigned int *ecx, unsigned int *edx);
diff --git a/arch/x86/include/asm/special_insns.h b/arch/x86/include/asm/special_insns.h
index aec6e2d..fab7c8a 100644
--- a/arch/x86/include/asm/special_insns.h
+++ b/arch/x86/include/asm/special_insns.h
@@ -115,7 +115,7 @@ static inline void wrpkru(u32 pkru)
 }
 #endif
 
-static __always_inline void native_wbinvd(void)
+static __always_inline void wbinvd(void)
 {
 	asm volatile("wbinvd": : :"memory");
 }
@@ -167,12 +167,6 @@ static inline void __write_cr4(unsigned long x)
 {
 	native_write_cr4(x);
 }
-
-static __always_inline void wbinvd(void)
-{
-	native_wbinvd();
-}
-
 #endif /* CONFIG_PARAVIRT_XXL */
 
 static __always_inline void clflush(volatile void *__p)
diff --git a/arch/x86/kernel/cpu/resctrl/pseudo_lock.c b/arch/x86/kernel/cpu/resctrl/pseudo_lock.c
index 972e6b6..b72f7e9 100644
--- a/arch/x86/kernel/cpu/resctrl/pseudo_lock.c
+++ b/arch/x86/kernel/cpu/resctrl/pseudo_lock.c
@@ -459,7 +459,7 @@ static int pseudo_lock_fn(void *_rdtgrp)
 	 * increase likelihood that allocated cache portion will be filled
 	 * with associated memory.
 	 */
-	native_wbinvd();
+	wbinvd();
 
 	/*
 	 * Always called with interrupts enabled. By disabling interrupts
diff --git a/arch/x86/kernel/paravirt.c b/arch/x86/kernel/paravirt.c
index fec3815..927e33e 100644
--- a/arch/x86/kernel/paravirt.c
+++ b/arch/x86/kernel/paravirt.c
@@ -116,11 +116,6 @@ static noinstr void pv_native_set_debugreg(int regno, unsigned long val)
 	native_set_debugreg(regno, val);
 }
 
-noinstr void pv_native_wbinvd(void)
-{
-	native_wbinvd();
-}
-
 static noinstr void pv_native_safe_halt(void)
 {
 	native_safe_halt();
@@ -148,7 +143,6 @@ struct paravirt_patch_template pv_ops = {
 	.cpu.read_cr0		= native_read_cr0,
 	.cpu.write_cr0		= native_write_cr0,
 	.cpu.write_cr4		= native_write_cr4,
-	.cpu.wbinvd		= pv_native_wbinvd,
 	.cpu.read_msr		= native_read_msr,
 	.cpu.write_msr		= native_write_msr,
 	.cpu.read_msr_safe	= native_read_msr_safe,
diff --git a/arch/x86/kernel/process.c b/arch/x86/kernel/process.c
index f63f8fd..58ead05 100644
--- a/arch/x86/kernel/process.c
+++ b/arch/x86/kernel/process.c
@@ -825,7 +825,7 @@ void __noreturn stop_this_cpu(void *dummy)
 	 * X86_FEATURE_SME due to cmdline options.
 	 */
 	if (c->extended_cpuid_level >= 0x8000001f && (cpuid_eax(0x8000001f) & BIT(0)))
-		native_wbinvd();
+		wbinvd();
 
 	/*
 	 * This brings a cache line back and dirties it, but
@@ -846,7 +846,7 @@ void __noreturn stop_this_cpu(void *dummy)
 		/*
 		 * Use native_halt() so that memory contents don't change
 		 * (stack usage and variables) after possibly issuing the
-		 * native_wbinvd() above.
+		 * wbinvd() above.
 		 */
 		native_halt();
 	}
diff --git a/arch/x86/xen/enlighten_pv.c b/arch/x86/xen/enlighten_pv.c
index d6818c6..fd21690 100644
--- a/arch/x86/xen/enlighten_pv.c
+++ b/arch/x86/xen/enlighten_pv.c
@@ -1161,8 +1161,6 @@ static const typeof(pv_ops) xen_cpu_ops __initconst = {
 
 		.write_cr4 = xen_write_cr4,
 
-		.wbinvd = pv_native_wbinvd,
-
 		.read_msr = xen_read_msr,
 		.write_msr = xen_write_msr,
 

