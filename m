Return-Path: <linux-tip-commits+bounces-4206-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A1F62A60DB0
	for <lists+linux-tip-commits@lfdr.de>; Fri, 14 Mar 2025 10:47:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D800F16BB24
	for <lists+linux-tip-commits@lfdr.de>; Fri, 14 Mar 2025 09:47:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD0D01EE7A8;
	Fri, 14 Mar 2025 09:47:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="d74bZwG9";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="UA5n4xmU"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AE0315666B;
	Fri, 14 Mar 2025 09:46:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741945621; cv=none; b=M9AzSNQ60Ftgn5h/8P3Wl7r+kAYLoAE/EyzmG/Rtm6LWDneJpBUww3z+NqGqLgvJGLhSFKbup4dAez292e6DHQsw1zsGtWpFexRxhwL1VrZRTfirY6+fthscjfqmda9OBbP90CGXPwRxyvDE+HvRwJ2NkhohZRNQ7Bm+RYIkaCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741945621; c=relaxed/simple;
	bh=BXpFKVBkRPdq0VCnr0u1/m9B7tcqX0yVcjyWTSrXFcY=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=CCjUSRhbjBlEVzXvQC3vbl2kFGR1hLNVU8udOdJRa3xwDSSeb8yLPIPJx2AyPyerUrW5X9GL27lvhFNS8fX8SNHEl/4dap7U4vQI9BWBSN13KxWzlBemUsJXYDRm64vaqYRHY0TbLpJ291rIw+TCOHiHltkXugLaFC+lCcwCOwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=d74bZwG9; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=UA5n4xmU; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 14 Mar 2025 09:46:57 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1741945618;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xmWIRRC2Ly6GIKpXff71/JnlCu8UUB9h4xEjBTbAPXY=;
	b=d74bZwG9eEN7Ku8n+JN7VKkTye/cQWkNoJh0zGbV9tJUP1ioDeuVHlZJJvx/J9Pkm08v1D
	b/OJa1zGm7LD1rlnwZa1xZ3dsJEqXPy3AmqSBkqG16kg6hc28BPlJzR9yodmQn61L81+at
	7TVhTMtO+mgVKWfTlFUNzSJAs9EelYUelLJ6tMdA1RMttZfbGRKgqGbRx9Z6m9MIl8J8G9
	4rVe/aBFIWrDIjZx4GJ2+UKol2/P22x1R31y2um/6Mf08+eSi9g/HcA/oC8MRLIBdrAANJ
	SzOjVNNO4tMWZmAdUbsc9ldhvkgTdtbYDf5OyPt9giK79pqBP7F3Z326TPzjgA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1741945618;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xmWIRRC2Ly6GIKpXff71/JnlCu8UUB9h4xEjBTbAPXY=;
	b=UA5n4xmU2Avvv2CvyJ9/LKkohtlemCpwKy0qqJDBtO3DRcS26S+QwunY01czQcTM7DjFxz
	4LWkN3au4z6R8tDQ==
From: "tip-bot2 for Brian Gerst" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cpu] x86/syscall/x32: Move the x32 syscall table to
 arch/x86/entry/syscall_64.c
Cc: Brian Gerst <brgerst@gmail.com>, Ingo Molnar <mingo@kernel.org>,
 Sohil Mehta <sohil.mehta@intel.com>, Andy Lutomirski <luto@kernel.org>,
 Juergen Gross <jgross@suse.com>, "H. Peter Anvin" <hpa@zytor.com>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Josh Poimboeuf <jpoimboe@redhat.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250313182236.655724-5-brgerst@gmail.com>
References: <20250313182236.655724-5-brgerst@gmail.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174194561771.14745.16285783829573376460.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/cpu branch of tip:

Commit-ID:     8b24877200a8d3c01d67b968dfbe58228909cc1b
Gitweb:        https://git.kernel.org/tip/8b24877200a8d3c01d67b968dfbe58228909cc1b
Author:        Brian Gerst <brgerst@gmail.com>
AuthorDate:    Thu, 13 Mar 2025 14:22:35 -04:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Fri, 14 Mar 2025 10:32:51 +01:00

x86/syscall/x32: Move the x32 syscall table to arch/x86/entry/syscall_64.c

Since commit:

  2e958a8a510d ("x86/entry/x32: Rename __x32_compat_sys_* to __x64_compat_sys_*")

the ABI prefix for x32 syscalls is the same as native 64-bit
syscalls.  Move the x32 syscall table to syscall_64.c

No functional changes.

Signed-off-by: Brian Gerst <brgerst@gmail.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Reviewed-by: Sohil Mehta <sohil.mehta@intel.com>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Juergen Gross <jgross@suse.com>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Link: https://lore.kernel.org/r/20250313182236.655724-5-brgerst@gmail.com
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
index 9e0ba33..b96f562 100644
--- a/arch/x86/entry/syscall_64.c
+++ b/arch/x86/entry/syscall_64.c
@@ -19,6 +19,9 @@
 #define __SYSCALL(nr, sym) extern long __x64_##sym(const struct pt_regs *);
 #define __SYSCALL_NORETURN(nr, sym) extern long __noreturn __x64_##sym(const struct pt_regs *);
 #include <asm/syscalls_64.h>
+#ifdef CONFIG_X86_X32_ABI
+#include <asm/syscalls_x32.h>
+#endif
 #undef  __SYSCALL
 
 #undef  __SYSCALL_NORETURN
@@ -44,6 +47,16 @@ long x64_sys_call(const struct pt_regs *regs, unsigned int nr)
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

