Return-Path: <linux-tip-commits+bounces-4361-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A5ECA68ACC
	for <lists+linux-tip-commits@lfdr.de>; Wed, 19 Mar 2025 12:11:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 64C59166311
	for <lists+linux-tip-commits@lfdr.de>; Wed, 19 Mar 2025 11:08:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F2D425C712;
	Wed, 19 Mar 2025 11:03:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="WuqB6WhB";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Tefps5Mp"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A35A25A2B0;
	Wed, 19 Mar 2025 11:03:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742382233; cv=none; b=ZowEq00fEekuvj+0EXW+eknu1MmbPoHvJl0ORdKHsQoQ64e2tcFqDzEMc7ZcZjC6YummNkYlRt9Q+YhjvaIkcpCiOxuxrptJmc9rhZjrgd0Vdf42zypHwAOslzBIiuXNXRBCTM1MnrAwOrddKWE0qaz5xcf29FCMVnMqC+2gguU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742382233; c=relaxed/simple;
	bh=YnMCyw2yV79aSdoTboytPzj2noUWm5EEGoZqtEGPybc=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=sio6yQt+50jyxcb1N+zLP5ZW2xyD8lyrbekBvbBhwU3f6Io9l+YddI0pNEvbGr0eWRISke1+kDjxhOG7ERdv9hpbTU+Q2xbAg8IazWBTAqCPVpi8X+u4IogulZAjl16C7jBs8Daxa2F3XJF+ZCoCMip5HUrvdmENSegaECPQMYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=WuqB6WhB; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Tefps5Mp; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 19 Mar 2025 11:03:49 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1742382230;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QhBDSJcm0IhSAPWRrNUua1od/VL3clFqVUQwKy1SOMU=;
	b=WuqB6WhBS/AmeaelJL4mfqksd5lt8sRsS24LgJHdjYytYwzaC33yOtC5XFaYvJNHyWGh16
	UaROCOGG2EP2AuzlFwYl598jzV2aIyieoCzqzYnhwWQwlE+LozmuvUXrgZbMtg+je8TXeb
	Fzwrq6zFi2rnKzMe1k/DKApxty62weMKD5cFJhc2UGqdmAcPZhtRV6vs9xxUMhFmNnMI99
	g+Lp79nksFQWIydZj53ad+iX/yPU4CnKJdZvveDuj8cUf2K1t8SXpq1rZFmV1HWCMXcgkn
	2cuF4cGAuW1aBi21r2qYAt+iY6tuTCv8Wv3EdztuyuT/RoCiJb6nfQ8MBAi5oA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1742382230;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QhBDSJcm0IhSAPWRrNUua1od/VL3clFqVUQwKy1SOMU=;
	b=Tefps5MpoRAMDql2nRkAGVSS/2UDbJDot8XjllRzJr82alWpZlFa5b1uaL/zBrlYNMXdCs
	cp+MuYEFBlFmFoCA==
From: "tip-bot2 for Brian Gerst" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/core] x86/syscall/x32: Move x32 syscall table
Cc: Brian Gerst <brgerst@gmail.com>, Ingo Molnar <mingo@kernel.org>,
 Sohil Mehta <sohil.mehta@intel.com>, Andy Lutomirski <luto@kernel.org>,
 "H. Peter Anvin" <hpa@zytor.com>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Josh Poimboeuf <jpoimboe@redhat.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250314151220.862768-5-brgerst@gmail.com>
References: <20250314151220.862768-5-brgerst@gmail.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174238222918.14745.2186248773968609720.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/core branch of tip:

Commit-ID:     21832247f2df4f636b0f2ae6939819e8dd2ed35f
Gitweb:        https://git.kernel.org/tip/21832247f2df4f636b0f2ae6939819e8dd2ed35f
Author:        Brian Gerst <brgerst@gmail.com>
AuthorDate:    Fri, 14 Mar 2025 11:12:17 -04:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Wed, 19 Mar 2025 11:19:15 +01:00

x86/syscall/x32: Move x32 syscall table

Since commit:

  2e958a8a510d ("x86/entry/x32: Rename __x32_compat_sys_* to __x64_compat_sys_*")

the ABI prefix for x32 syscalls is the same as native 64-bit
syscalls.  Move the x32 syscall table to syscall_64.c

No functional changes.

Signed-off-by: Brian Gerst <brgerst@gmail.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Reviewed-by: Sohil Mehta <sohil.mehta@intel.com>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Link: https://lore.kernel.org/r/20250314151220.862768-5-brgerst@gmail.com
---
 arch/x86/entry/Makefile      |  1 -
 arch/x86/entry/syscall_64.c  | 13 +++++++++++++
 arch/x86/entry/syscall_x32.c | 25 -------------------------
 3 files changed, 13 insertions(+), 26 deletions(-)
 delete mode 100644 arch/x86/entry/syscall_x32.c

diff --git a/arch/x86/entry/Makefile b/arch/x86/entry/Makefile
index 5fd28ab..e870f8a 100644
--- a/arch/x86/entry/Makefile
+++ b/arch/x86/entry/Makefile
@@ -27,4 +27,3 @@ CFLAGS_REMOVE_entry_fred.o	+= -pg $(CC_FLAGS_FTRACE)
 obj-$(CONFIG_X86_FRED)		+= entry_64_fred.o entry_fred.o
 
 obj-$(CONFIG_IA32_EMULATION)	+= entry_64_compat.o syscall_32.o
-obj-$(CONFIG_X86_X32_ABI)	+= syscall_x32.o
diff --git a/arch/x86/entry/syscall_64.c b/arch/x86/entry/syscall_64.c
index e0c62d5..a05f7be 100644
--- a/arch/x86/entry/syscall_64.c
+++ b/arch/x86/entry/syscall_64.c
@@ -12,6 +12,9 @@
 #define __SYSCALL(nr, sym) extern long __x64_##sym(const struct pt_regs *);
 #define __SYSCALL_NORETURN(nr, sym) extern long __noreturn __x64_##sym(const struct pt_regs *);
 #include <asm/syscalls_64.h>
+#ifdef CONFIG_X86_X32_ABI
+#include <asm/syscalls_x32.h>
+#endif
 #undef  __SYSCALL
 
 #undef  __SYSCALL_NORETURN
@@ -37,6 +40,16 @@ long x64_sys_call(const struct pt_regs *regs, unsigned int nr)
 	}
 };
 
+#ifdef CONFIG_X86_X32_ABI
+long x32_sys_call(const struct pt_regs *regs, unsigned int nr)
+{
+	switch (nr) {
+	#include <asm/syscalls_x32.h>
+	default: return __x64_sys_ni_syscall(regs);
+	}
+};
+#endif
+
 static __always_inline bool do_syscall_x64(struct pt_regs *regs, int nr)
 {
 	/*
diff --git a/arch/x86/entry/syscall_x32.c b/arch/x86/entry/syscall_x32.c
deleted file mode 100644
index fb77908..0000000
--- a/arch/x86/entry/syscall_x32.c
+++ /dev/null
@@ -1,25 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-/* System call table for x32 ABI. */
-
-#include <linux/linkage.h>
-#include <linux/sys.h>
-#include <linux/cache.h>
-#include <linux/syscalls.h>
-#include <asm/syscall.h>
-
-#define __SYSCALL(nr, sym) extern long __x64_##sym(const struct pt_regs *);
-#define __SYSCALL_NORETURN(nr, sym) extern long __noreturn __x64_##sym(const struct pt_regs *);
-#include <asm/syscalls_x32.h>
-#undef  __SYSCALL
-
-#undef  __SYSCALL_NORETURN
-#define __SYSCALL_NORETURN __SYSCALL
-
-#define __SYSCALL(nr, sym) case nr: return __x64_##sym(regs);
-long x32_sys_call(const struct pt_regs *regs, unsigned int nr)
-{
-	switch (nr) {
-	#include <asm/syscalls_x32.h>
-	default: return __x64_sys_ni_syscall(regs);
-	}
-};

