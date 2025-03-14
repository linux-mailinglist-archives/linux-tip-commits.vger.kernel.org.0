Return-Path: <linux-tip-commits+bounces-4207-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CCFA1A60DB3
	for <lists+linux-tip-commits@lfdr.de>; Fri, 14 Mar 2025 10:47:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 21B283B8DC6
	for <lists+linux-tip-commits@lfdr.de>; Fri, 14 Mar 2025 09:47:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65A091F1934;
	Fri, 14 Mar 2025 09:47:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="pmho8f1q";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="TKU2DAcB"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 624B719CC31;
	Fri, 14 Mar 2025 09:47:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741945623; cv=none; b=BplTSIOJRuvyrKWsbMR9e8F+JNAYLnru3hZvO4ryHLA4ns6FYMWyIeheRz4BBm3Z0RgSBQoNeWop2Iq5JJoQbVlPEKlDovVvy8To7L+D5m7Uqn3HxVCUSAcyiylYEGZBDtR7mU5wSAxoWNP+C/QZTdYwBXlUMauLP7C731Tl8cU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741945623; c=relaxed/simple;
	bh=Ft917kPeKOsY7N44R6zLeajfNPb+oW3XtInzrdP8x1Y=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=NcitEQlnarUXRCtRYyp0SsM5Xy5g91UzkXdx7CQUSeCoJHGLusTYXcO4tDP4Bp3HASulTZMdOsiVSyWp5gQ8/OJNoohlMyumlFuW5inXMk9Xg6xZA7u1WlrTcK42lTWToricZ5SXNAlvHkYRi+6EfvyLj4daNeKFp+hyuafJcs0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=pmho8f1q; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=TKU2DAcB; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 14 Mar 2025 09:46:58 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1741945619;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CslTYsfvYzMeENbtLKoEG4nL7YajkgSJ1ALSbmV1uCE=;
	b=pmho8f1qAcR+rcGkq/OMXtcYDmIWFjDZdDN4NemsPTEn9vxwviX3T0w+BD448jr9tO+EjZ
	XTnbZRzdT3ue4uhIpXWwc31ZS38puX7XhuOFXVeVhhUUJ9MgDVdE4pzoN34x3KIXxoMPPv
	9MujFX5W5SWkmMrquLH1okntXgEC7HRNG77jcZGarGK1pDy/JeXWKc7gZikHqMLuuqHB3m
	SxX6h60yoTZhNYdXw1aGa4+YsEQ9zeVXyRFowTjRav3sjQC7bu6WM4Shg00dHHtln+FZ5P
	x0lQYcj3dKUFm7e56FVRacp4MAcVqFuiqH/k8Bvw39AgH2XZciCUg6wzs+EREw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1741945619;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CslTYsfvYzMeENbtLKoEG4nL7YajkgSJ1ALSbmV1uCE=;
	b=TKU2DAcBkYCLlObfcMKK6YtbOaLX8sU4JH2Ktfh7/td7lBPOv0faOuWy81uEZFSpWoDdgC
	r0rImydhcc8HdxBQ==
From: "tip-bot2 for Brian Gerst" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cpu] x86/syscall/64: Move the 64-bit syscall dispatch code
 to arch/x86/entry/syscall_64.c
Cc: Brian Gerst <brgerst@gmail.com>, Ingo Molnar <mingo@kernel.org>,
 Sohil Mehta <sohil.mehta@intel.com>, Andy Lutomirski <luto@kernel.org>,
 Juergen Gross <jgross@suse.com>, "H. Peter Anvin" <hpa@zytor.com>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Josh Poimboeuf <jpoimboe@redhat.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250313182236.655724-4-brgerst@gmail.com>
References: <20250313182236.655724-4-brgerst@gmail.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174194561857.14745.10977053738741788305.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/cpu branch of tip:

Commit-ID:     daffd8a21847b2a37da6b4d23753a4581543c575
Gitweb:        https://git.kernel.org/tip/daffd8a21847b2a37da6b4d23753a4581543c575
Author:        Brian Gerst <brgerst@gmail.com>
AuthorDate:    Thu, 13 Mar 2025 14:22:34 -04:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Fri, 14 Mar 2025 10:32:51 +01:00

x86/syscall/64: Move the 64-bit syscall dispatch code to arch/x86/entry/syscall_64.c

Move the 64-bit syscall dispatch code to syscall_64.c.

No functional changes.

Signed-off-by: Brian Gerst <brgerst@gmail.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Reviewed-by: Sohil Mehta <sohil.mehta@intel.com>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Juergen Gross <jgross@suse.com>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Link: https://lore.kernel.org/r/20250313182236.655724-4-brgerst@gmail.com
---
 arch/x86/entry/Makefile     |   2 +-
 arch/x86/entry/common.c     |  93 +--------------------------------
 arch/x86/entry/syscall_64.c | 103 ++++++++++++++++++++++++++++++++++-
 3 files changed, 103 insertions(+), 95 deletions(-)

diff --git a/arch/x86/entry/Makefile b/arch/x86/entry/Makefile
index 96a6b86..5fd28ab 100644
--- a/arch/x86/entry/Makefile
+++ b/arch/x86/entry/Makefile
@@ -9,9 +9,11 @@ KCOV_INSTRUMENT := n
 
 CFLAGS_REMOVE_common.o		= $(CC_FLAGS_FTRACE)
 CFLAGS_REMOVE_syscall_32.o	= $(CC_FLAGS_FTRACE)
+CFLAGS_REMOVE_syscall_64.o	= $(CC_FLAGS_FTRACE)
 
 CFLAGS_common.o			+= -fno-stack-protector
 CFLAGS_syscall_32.o		+= -fno-stack-protector
+CFLAGS_syscall_64.o		+= -fno-stack-protector
 
 obj-y				:= entry.o entry_$(BITS).o syscall_$(BITS).o
 obj-y				+= common.o
diff --git a/arch/x86/entry/common.c b/arch/x86/entry/common.c
index 183efab..5bd448c 100644
--- a/arch/x86/entry/common.c
+++ b/arch/x86/entry/common.c
@@ -32,99 +32,6 @@
 #include <asm/syscall.h>
 #include <asm/irq_stack.h>
 
-#ifdef CONFIG_X86_64
-
-static __always_inline bool do_syscall_x64(struct pt_regs *regs, int nr)
-{
-	/*
-	 * Convert negative numbers to very high and thus out of range
-	 * numbers for comparisons.
-	 */
-	unsigned int unr = nr;
-
-	if (likely(unr < NR_syscalls)) {
-		unr = array_index_nospec(unr, NR_syscalls);
-		regs->ax = x64_sys_call(regs, unr);
-		return true;
-	}
-	return false;
-}
-
-static __always_inline bool do_syscall_x32(struct pt_regs *regs, int nr)
-{
-	/*
-	 * Adjust the starting offset of the table, and convert numbers
-	 * < __X32_SYSCALL_BIT to very high and thus out of range
-	 * numbers for comparisons.
-	 */
-	unsigned int xnr = nr - __X32_SYSCALL_BIT;
-
-	if (IS_ENABLED(CONFIG_X86_X32_ABI) && likely(xnr < X32_NR_syscalls)) {
-		xnr = array_index_nospec(xnr, X32_NR_syscalls);
-		regs->ax = x32_sys_call(regs, xnr);
-		return true;
-	}
-	return false;
-}
-
-/* Returns true to return using SYSRET, or false to use IRET */
-__visible noinstr bool do_syscall_64(struct pt_regs *regs, int nr)
-{
-	add_random_kstack_offset();
-	nr = syscall_enter_from_user_mode(regs, nr);
-
-	instrumentation_begin();
-
-	if (!do_syscall_x64(regs, nr) && !do_syscall_x32(regs, nr) && nr != -1) {
-		/* Invalid system call, but still a system call. */
-		regs->ax = __x64_sys_ni_syscall(regs);
-	}
-
-	instrumentation_end();
-	syscall_exit_to_user_mode(regs);
-
-	/*
-	 * Check that the register state is valid for using SYSRET to exit
-	 * to userspace.  Otherwise use the slower but fully capable IRET
-	 * exit path.
-	 */
-
-	/* XEN PV guests always use the IRET path */
-	if (cpu_feature_enabled(X86_FEATURE_XENPV))
-		return false;
-
-	/* SYSRET requires RCX == RIP and R11 == EFLAGS */
-	if (unlikely(regs->cx != regs->ip || regs->r11 != regs->flags))
-		return false;
-
-	/* CS and SS must match the values set in MSR_STAR */
-	if (unlikely(regs->cs != __USER_CS || regs->ss != __USER_DS))
-		return false;
-
-	/*
-	 * On Intel CPUs, SYSRET with non-canonical RCX/RIP will #GP
-	 * in kernel space.  This essentially lets the user take over
-	 * the kernel, since userspace controls RSP.
-	 *
-	 * TASK_SIZE_MAX covers all user-accessible addresses other than
-	 * the deprecated vsyscall page.
-	 */
-	if (unlikely(regs->ip >= TASK_SIZE_MAX))
-		return false;
-
-	/*
-	 * SYSRET cannot restore RF.  It can restore TF, but unlike IRET,
-	 * restoring TF results in a trap from userspace immediately after
-	 * SYSRET.
-	 */
-	if (unlikely(regs->flags & (X86_EFLAGS_RF | X86_EFLAGS_TF)))
-		return false;
-
-	/* Use SYSRET to exit to userspace */
-	return true;
-}
-#endif
-
 SYSCALL_DEFINE0(ni_syscall)
 {
 	return -ENOSYS;
diff --git a/arch/x86/entry/syscall_64.c b/arch/x86/entry/syscall_64.c
index ba83544..9e0ba33 100644
--- a/arch/x86/entry/syscall_64.c
+++ b/arch/x86/entry/syscall_64.c
@@ -1,10 +1,19 @@
-// SPDX-License-Identifier: GPL-2.0
-/* System call table for x86-64. */
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * 64-bit system call dispatch
+ *
+ * Copyright (c) 2015 Andrew Lutomirski
+ *
+ * Based on asm and ptrace code by many authors.  The code here originated
+ * in ptrace.c and signal.c.
+ */
 
 #include <linux/linkage.h>
 #include <linux/sys.h>
 #include <linux/cache.h>
 #include <linux/syscalls.h>
+#include <linux/entry-common.h>
+#include <linux/nospec.h>
 #include <asm/syscall.h>
 
 #define __SYSCALL(nr, sym) extern long __x64_##sym(const struct pt_regs *);
@@ -34,3 +43,93 @@ long x64_sys_call(const struct pt_regs *regs, unsigned int nr)
 	default: return __x64_sys_ni_syscall(regs);
 	}
 };
+
+static __always_inline bool do_syscall_x64(struct pt_regs *regs, int nr)
+{
+	/*
+	 * Convert negative numbers to very high and thus out of range
+	 * numbers for comparisons.
+	 */
+	unsigned int unr = nr;
+
+	if (likely(unr < NR_syscalls)) {
+		unr = array_index_nospec(unr, NR_syscalls);
+		regs->ax = x64_sys_call(regs, unr);
+		return true;
+	}
+	return false;
+}
+
+static __always_inline bool do_syscall_x32(struct pt_regs *regs, int nr)
+{
+	/*
+	 * Adjust the starting offset of the table, and convert numbers
+	 * < __X32_SYSCALL_BIT to very high and thus out of range
+	 * numbers for comparisons.
+	 */
+	unsigned int xnr = nr - __X32_SYSCALL_BIT;
+
+	if (IS_ENABLED(CONFIG_X86_X32_ABI) && likely(xnr < X32_NR_syscalls)) {
+		xnr = array_index_nospec(xnr, X32_NR_syscalls);
+		regs->ax = x32_sys_call(regs, xnr);
+		return true;
+	}
+	return false;
+}
+
+/* Returns true to return using SYSRET, or false to use IRET */
+__visible noinstr bool do_syscall_64(struct pt_regs *regs, int nr)
+{
+	add_random_kstack_offset();
+	nr = syscall_enter_from_user_mode(regs, nr);
+
+	instrumentation_begin();
+
+	if (!do_syscall_x64(regs, nr) && !do_syscall_x32(regs, nr) && nr != -1) {
+		/* Invalid system call, but still a system call. */
+		regs->ax = __x64_sys_ni_syscall(regs);
+	}
+
+	instrumentation_end();
+	syscall_exit_to_user_mode(regs);
+
+	/*
+	 * Check that the register state is valid for using SYSRET to exit
+	 * to userspace.  Otherwise use the slower but fully capable IRET
+	 * exit path.
+	 */
+
+	/* XEN PV guests always use the IRET path */
+	if (cpu_feature_enabled(X86_FEATURE_XENPV))
+		return false;
+
+	/* SYSRET requires RCX == RIP and R11 == EFLAGS */
+	if (unlikely(regs->cx != regs->ip || regs->r11 != regs->flags))
+		return false;
+
+	/* CS and SS must match the values set in MSR_STAR */
+	if (unlikely(regs->cs != __USER_CS || regs->ss != __USER_DS))
+		return false;
+
+	/*
+	 * On Intel CPUs, SYSRET with non-canonical RCX/RIP will #GP
+	 * in kernel space.  This essentially lets the user take over
+	 * the kernel, since userspace controls RSP.
+	 *
+	 * TASK_SIZE_MAX covers all user-accessible addresses other than
+	 * the deprecated vsyscall page.
+	 */
+	if (unlikely(regs->ip >= TASK_SIZE_MAX))
+		return false;
+
+	/*
+	 * SYSRET cannot restore RF.  It can restore TF, but unlike IRET,
+	 * restoring TF results in a trap from userspace immediately after
+	 * SYSRET.
+	 */
+	if (unlikely(regs->flags & (X86_EFLAGS_RF | X86_EFLAGS_TF)))
+		return false;
+
+	/* Use SYSRET to exit to userspace */
+	return true;
+}

