Return-Path: <linux-tip-commits+bounces-4232-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B5001A63526
	for <lists+linux-tip-commits@lfdr.de>; Sun, 16 Mar 2025 12:02:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A327E1890462
	for <lists+linux-tip-commits@lfdr.de>; Sun, 16 Mar 2025 11:02:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF45B1A5BBA;
	Sun, 16 Mar 2025 11:01:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ASdnf5td";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="JmtBLsT7"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 231331A3A8D;
	Sun, 16 Mar 2025 11:01:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742122905; cv=none; b=KBqh+H94stO2HODHC4+cZLMHq665ZuAVcE0p7jeLdTt8+bmjeEnvFi+zIrJ0WteYB4ACj52sXZaTDiYAxHmzkUq0Q/ltWv29W2v7DTNx4d8v/YyoOJCktJt3wP1iN94JDFntQngu+A4KSL2/oiZRLE2RDdVxPu1ttgXQQHyumis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742122905; c=relaxed/simple;
	bh=fxYYkOs+ihcJ/ZbQyje63961F84A1AoJYHRUEH04/Fc=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=QA1bCpNOthrafk+dKFgZlXQ38Jb6j/ozvrzskf716xs4KyeXXESBATvvC1mjQONvfibZ9r1m8qXMToM2SKUZ6nbjfJcQAvYfjuavPCSqiH2A/qG3C0CGyBsWjae1kyJYXdSTBtRPCJ10aYnZ8btsBXDnnUsXMgrco/UPATSeqVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ASdnf5td; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=JmtBLsT7; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sun, 16 Mar 2025 11:01:39 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1742122901;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=n2rpOYHkP5z5Wv71LbYAjSTAV64Pi9e0YkfO5mHHvC4=;
	b=ASdnf5tdp324mmWdhWRLoLMhFYI/motAQc16W683i+1lWxbI7H4pLt6vGmOEEoSkNcos5x
	8mozc1Xm2iZtSe7u+XjT5mD+dTFcqkFhxLdP/mkNsfJZe710KW6mJ9PZ4V8Pl15KPZrjQu
	nTxenn4TeETdnMDx1UygVy5HaujiCRt5fuFDw88Uf08Mlws8ECPnqio1abBUQyWicv5TRI
	7OPRn6gc/XDZSz5pv96uEJuAK4+i6tSwAvNXTMyPrMBHEGk5c7fi0BYbNm52o2SrX8Tuh9
	DmQ9LyPYgaa3t5Fw3VC5UeI6g/ZmdNsQ4j7SYA1tllJYtNp2ATlLZ3MXJ3cy1Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1742122901;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=n2rpOYHkP5z5Wv71LbYAjSTAV64Pi9e0YkfO5mHHvC4=;
	b=JmtBLsT77upiAqvLAUkQ4L08fWJQO+ya3RrgblLOF/juE53qQu7sRXKfdQvmvLuU6vlMOI
	G+S+VMa4DWSOxZBQ==
From: "tip-bot2 for Brian Gerst" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cpu] x86/syscall/x32: Move x32 syscall table
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
Message-ID: <174212290102.14745.16094285304261452563.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/cpu branch of tip:

Commit-ID:     0b9358963319e6d8f0ed49e3669e629a4efbd384
Gitweb:        https://git.kernel.org/tip/0b9358963319e6d8f0ed49e3669e629a4efbd384
Author:        Brian Gerst <brgerst@gmail.com>
AuthorDate:    Fri, 14 Mar 2025 11:12:17 -04:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Sun, 16 Mar 2025 11:49:41 +01:00

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

