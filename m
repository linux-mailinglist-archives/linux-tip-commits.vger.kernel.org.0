Return-Path: <linux-tip-commits+bounces-3744-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 40338A49F65
	for <lists+linux-tip-commits@lfdr.de>; Fri, 28 Feb 2025 17:54:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8E7AE7AA27F
	for <lists+linux-tip-commits@lfdr.de>; Fri, 28 Feb 2025 16:53:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06000276047;
	Fri, 28 Feb 2025 16:53:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="4nosDSjm";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="zAaZfCXp"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE4F526E97E;
	Fri, 28 Feb 2025 16:53:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740761619; cv=none; b=XjrrsW0lxfcibh2f9fkFdL0ucucL9v9TiKrBcEdYFSW9B5bs93b3KX8+KHLEL7RWcKN8n3Q9XUxPDY9qyPyTCiGaeF67pKGRzwPBGyWfJOO1qCpGTCZp7OaHHOjzWtMhjj3QLbRXruzT687SxlqaWq/Jj9aCiC++esIXTqst3+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740761619; c=relaxed/simple;
	bh=c2taeqS8lsOMq/9EBdG44FTRz+qklKVtW3WU/XtVm7I=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=BfqagvB3zZ0VgIvqbCtwTxLFWhR1YNfMAVpHVRovxHZEXGzn+ef5hrKqgUEoLWZy84OM0Tv/qF/hIlKW9svei1ghsuwVFu16MqGl9WPH9yjDAzKMMJEditU2/uY2vC9w8T6dY4/cN3A4rVEDS4EfXWbz1s37hxqboWy3dzypw1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=4nosDSjm; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=zAaZfCXp; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 28 Feb 2025 16:53:35 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1740761616;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CC8LRlFH9I7k6BASM2BE7cnck6ft4vLzr6ZqRcz+p70=;
	b=4nosDSjmn7nnpC8Xng+QYkriF8V1J4GL6KP1RWuGKS592J5iZ6T3aL3EQqzHeR9W+M37gN
	HPaBIKqdPbaP2E/nj6CegvXv8XvMrUOXmGu4n/amCuB3yvcPV6zp/yhPHOLpPNh23FThlC
	4sY30IE43zbcL75bSZ1MszhI9gUtXWgdbnJ96Rw9uObfxsLoIwyPyAbKZgehQUyVqvZwvZ
	kpB6e8yNJvuEXpxpJbHeDbNXbxuwnOsuHpnmjwjtXDEqPfB64eNJp83j/55OS1TCu/7+Fd
	YUYFuLbGm+zB4I8X6+biqXbYlzzMcj6q+rAiL9tnEzbE3RiQd+UWsAu/OJrJ/g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1740761616;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CC8LRlFH9I7k6BASM2BE7cnck6ft4vLzr6ZqRcz+p70=;
	b=zAaZfCXpknAdc3Gk6Z/X9e/ryDd5HcITXFwarK1FtM3tDD539BBWVWSJi3T7ZFZj1GZdm5
	JSvYnmalq4U3G5BA==
From: "tip-bot2 for H. Peter Anvin (Intel)" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cpu] x86/cpufeatures: Rename X86_CMPXCHG64 to X86_CX8
Cc: "H. Peter Anvin (Intel)" <hpa@zytor.com>, "Xin Li (Intel)" <xin@zytor.com>,
 "Borislav Petkov (AMD)" <bp@alien8.de>, Ingo Molnar <mingo@kernel.org>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250228082338.73859-2-xin@zytor.com>
References: <20250228082338.73859-2-xin@zytor.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174076161544.10177.382472902232608157.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/cpu branch of tip:

Commit-ID:     909639aa58fe4789644104c1fd89264c57da0979
Gitweb:        https://git.kernel.org/tip/909639aa58fe4789644104c1fd89264c57da0979
Author:        H. Peter Anvin (Intel) <hpa@zytor.com>
AuthorDate:    Fri, 28 Feb 2025 00:23:34 -08:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Fri, 28 Feb 2025 11:42:34 +01:00

x86/cpufeatures: Rename X86_CMPXCHG64 to X86_CX8

Replace X86_CMPXCHG64 with X86_CX8, as CX8 is the name of the CPUID
flag, thus to make it consistent with X86_FEATURE_CX8 defined in
<asm/cpufeatures.h>.

No functional change intended.

Signed-off-by: H. Peter Anvin (Intel) <hpa@zytor.com>
Signed-off-by: Xin Li (Intel) <xin@zytor.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/20250228082338.73859-2-xin@zytor.com
---
 arch/x86/Kconfig                               | 2 +-
 arch/x86/Kconfig.cpu                           | 4 ++--
 arch/x86/include/asm/asm-prototypes.h          | 2 +-
 arch/x86/include/asm/atomic64_32.h             | 2 +-
 arch/x86/include/asm/cmpxchg_32.h              | 2 +-
 arch/x86/include/asm/required-features.h       | 2 +-
 arch/x86/lib/Makefile                          | 2 +-
 arch/x86/lib/cmpxchg8b_emu.S                   | 2 +-
 lib/atomic64_test.c                            | 2 +-
 tools/arch/x86/include/asm/required-features.h | 2 +-
 10 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index aa90f03..017035f 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -133,7 +133,7 @@ config X86
 	select ARCH_SUPPORTS_AUTOFDO_CLANG
 	select ARCH_SUPPORTS_PROPELLER_CLANG    if X86_64
 	select ARCH_USE_BUILTIN_BSWAP
-	select ARCH_USE_CMPXCHG_LOCKREF		if X86_CMPXCHG64
+	select ARCH_USE_CMPXCHG_LOCKREF		if X86_CX8
 	select ARCH_USE_MEMTEST
 	select ARCH_USE_QUEUED_RWLOCKS
 	select ARCH_USE_QUEUED_SPINLOCKS
diff --git a/arch/x86/Kconfig.cpu b/arch/x86/Kconfig.cpu
index 8fcb8cc..f8b3296 100644
--- a/arch/x86/Kconfig.cpu
+++ b/arch/x86/Kconfig.cpu
@@ -299,7 +299,7 @@ config X86_HAVE_PAE
 	def_bool y
 	depends on MCRUSOE || MEFFICEON || MCYRIXIII || MPENTIUM4 || MPENTIUMM || MPENTIUMIII || MPENTIUMII || M686 || MVIAC7 || MATOM || X86_64
 
-config X86_CMPXCHG64
+config X86_CX8
 	def_bool y
 	depends on X86_HAVE_PAE || M586TSC || M586MMX || MK6 || MK7 || MGEODEGX1 || MGEODE_LX
 
@@ -313,7 +313,7 @@ config X86_MINIMUM_CPU_FAMILY
 	int
 	default "64" if X86_64
 	default "6" if X86_32 && (MPENTIUM4 || MPENTIUMM || MPENTIUMIII || MPENTIUMII || M686 || MVIAC3_2 || MVIAC7 || MEFFICEON || MATOM || MK7)
-	default "5" if X86_32 && X86_CMPXCHG64
+	default "5" if X86_32 && X86_CX8
 	default "4"
 
 config X86_DEBUGCTLMSR
diff --git a/arch/x86/include/asm/asm-prototypes.h b/arch/x86/include/asm/asm-prototypes.h
index 3674006..8d9e627 100644
--- a/arch/x86/include/asm/asm-prototypes.h
+++ b/arch/x86/include/asm/asm-prototypes.h
@@ -16,7 +16,7 @@
 #include <asm/gsseg.h>
 #include <asm/nospec-branch.h>
 
-#ifndef CONFIG_X86_CMPXCHG64
+#ifndef CONFIG_X86_CX8
 extern void cmpxchg8b_emu(void);
 #endif
 
diff --git a/arch/x86/include/asm/atomic64_32.h b/arch/x86/include/asm/atomic64_32.h
index 6c6e9b9..797085e 100644
--- a/arch/x86/include/asm/atomic64_32.h
+++ b/arch/x86/include/asm/atomic64_32.h
@@ -48,7 +48,7 @@ static __always_inline s64 arch_atomic64_read_nonatomic(const atomic64_t *v)
 	ATOMIC64_EXPORT(atomic64_##sym)
 #endif
 
-#ifdef CONFIG_X86_CMPXCHG64
+#ifdef CONFIG_X86_CX8
 #define __alternative_atomic64(f, g, out, in...) \
 	asm volatile("call %c[func]" \
 		     : ALT_OUTPUT_SP(out) \
diff --git a/arch/x86/include/asm/cmpxchg_32.h b/arch/x86/include/asm/cmpxchg_32.h
index fd1282a..c38d4ed 100644
--- a/arch/x86/include/asm/cmpxchg_32.h
+++ b/arch/x86/include/asm/cmpxchg_32.h
@@ -69,7 +69,7 @@ static __always_inline bool __try_cmpxchg64_local(volatile u64 *ptr, u64 *oldp, 
 	return __arch_try_cmpxchg64(ptr, oldp, new,);
 }
 
-#ifdef CONFIG_X86_CMPXCHG64
+#ifdef CONFIG_X86_CX8
 
 #define arch_cmpxchg64 __cmpxchg64
 
diff --git a/arch/x86/include/asm/required-features.h b/arch/x86/include/asm/required-features.h
index e9187dd..0068133 100644
--- a/arch/x86/include/asm/required-features.h
+++ b/arch/x86/include/asm/required-features.h
@@ -23,7 +23,7 @@
 # define NEED_PAE	0
 #endif
 
-#ifdef CONFIG_X86_CMPXCHG64
+#ifdef CONFIG_X86_CX8
 # define NEED_CX8	(1<<(X86_FEATURE_CX8 & 31))
 #else
 # define NEED_CX8	0
diff --git a/arch/x86/lib/Makefile b/arch/x86/lib/Makefile
index 8a59c61..9bbe281 100644
--- a/arch/x86/lib/Makefile
+++ b/arch/x86/lib/Makefile
@@ -56,7 +56,7 @@ ifeq ($(CONFIG_X86_32),y)
         lib-y += string_32.o
         lib-y += memmove_32.o
         lib-y += cmpxchg8b_emu.o
-ifneq ($(CONFIG_X86_CMPXCHG64),y)
+ifneq ($(CONFIG_X86_CX8),y)
         lib-y += atomic64_386_32.o
 endif
 else
diff --git a/arch/x86/lib/cmpxchg8b_emu.S b/arch/x86/lib/cmpxchg8b_emu.S
index 1c96be7..d4bb243 100644
--- a/arch/x86/lib/cmpxchg8b_emu.S
+++ b/arch/x86/lib/cmpxchg8b_emu.S
@@ -7,7 +7,7 @@
 
 .text
 
-#ifndef CONFIG_X86_CMPXCHG64
+#ifndef CONFIG_X86_CX8
 
 /*
  * Emulate 'cmpxchg8b (%esi)' on UP
diff --git a/lib/atomic64_test.c b/lib/atomic64_test.c
index 759ea17..d726068 100644
--- a/lib/atomic64_test.c
+++ b/lib/atomic64_test.c
@@ -254,7 +254,7 @@ static __init int test_atomics_init(void)
 	pr_info("passed for %s platform %s CX8 and %s SSE\n",
 #ifdef CONFIG_X86_64
 		"x86-64",
-#elif defined(CONFIG_X86_CMPXCHG64)
+#elif defined(CONFIG_X86_CX8)
 		"i586+",
 #else
 		"i386+",
diff --git a/tools/arch/x86/include/asm/required-features.h b/tools/arch/x86/include/asm/required-features.h
index e9187dd..0068133 100644
--- a/tools/arch/x86/include/asm/required-features.h
+++ b/tools/arch/x86/include/asm/required-features.h
@@ -23,7 +23,7 @@
 # define NEED_PAE	0
 #endif
 
-#ifdef CONFIG_X86_CMPXCHG64
+#ifdef CONFIG_X86_CX8
 # define NEED_CX8	(1<<(X86_FEATURE_CX8 & 31))
 #else
 # define NEED_CX8	0

