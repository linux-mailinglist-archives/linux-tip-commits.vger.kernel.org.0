Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EAE093A14F7
	for <lists+linux-tip-commits@lfdr.de>; Wed,  9 Jun 2021 14:56:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231462AbhFIM6S (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 9 Jun 2021 08:58:18 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:54408 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231424AbhFIM6Q (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 9 Jun 2021 08:58:16 -0400
Date:   Wed, 09 Jun 2021 12:56:19 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1623243380;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xjNPwZvHCCtWZrGSeqi7tBe9oVflAX42XE/hHvuTsm4=;
        b=zu60UP5rn9dm/wu6AY3cQk6mqQ2M0UTlHrGumb2K33xKwVu85RIHi0CP2U6CGeejFz5eJy
        +16sxMcUhP5vATXieO1dMLW3Vbqy6AH2epLFxkGMngkvuhN5X2QXT5W7tCwQ1iZ38GL27M
        zdgQZBu+9QP4d9Rl/GZrkbj/0D6sW43WoK3BxR/aJlMDUr+KTm6nJb/0eCbTQUVLGR7r07
        4sjvP9nznfB1L/JtYIrZGOAH86wPUcyh6fa16PXIXdOjsdc8wtNWHt2tW4//+UNVZO6UTW
        ZQSKm/Rq1QtbWOYhabqLK2z9kkEyra6z90jq0d0pAkbkNPMiNRLXTRBfa8q5Lw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1623243380;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xjNPwZvHCCtWZrGSeqi7tBe9oVflAX42XE/hHvuTsm4=;
        b=brfAa8f2CEFzY5iMcKYlYq0LOC2Ewrml74fgpSTV5JQJDV1jX2QUfs4tLdL59x8QyfWU5b
        CVYSJ0/uyHPebBDQ==
From:   "tip-bot2 for Andy Lutomirski" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/fpu] selftests/x86: Test signal frame XSTATE header
 corruption handling
Cc:     Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@suse.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Rik van Riel <riel@surriel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210608144346.234764986@linutronix.de>
References: <20210608144346.234764986@linutronix.de>
MIME-Version: 1.0
Message-ID: <162324337919.29796.4599968372466254532.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/fpu branch of tip:

Commit-ID:     b7c11876d24bdd7ae3feeaa771b8f903f6cf05eb
Gitweb:        https://git.kernel.org/tip/b7c11876d24bdd7ae3feeaa771b8f903f6cf05eb
Author:        Andy Lutomirski <luto@kernel.org>
AuthorDate:    Tue, 08 Jun 2021 16:36:23 +02:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Wed, 09 Jun 2021 14:46:30 +02:00

selftests/x86: Test signal frame XSTATE header corruption handling

This is very heavily based on some code from Thomas Gleixner.  On a system
without XSAVES, it triggers the WARN_ON():

  Bad FPU state detected at copy_kernel_to_fpregs+0x2f/0x40, reinitializing FPU registers.

  [ bp: Massage in nitpicks. ]

Signed-off-by: Andy Lutomirski <luto@kernel.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Borislav Petkov <bp@suse.de>
Acked-by: Dave Hansen <dave.hansen@linux.intel.com>
Acked-by: Rik van Riel <riel@surriel.com>
Link: https://lkml.kernel.org/r/20210608144346.234764986@linutronix.de
---
 tools/testing/selftests/x86/Makefile                |   3 +-
 tools/testing/selftests/x86/corrupt_xstate_header.c | 114 +++++++++++-
 2 files changed, 116 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/x86/corrupt_xstate_header.c

diff --git a/tools/testing/selftests/x86/Makefile b/tools/testing/selftests/x86/Makefile
index 65bba2a..b4142cd 100644
--- a/tools/testing/selftests/x86/Makefile
+++ b/tools/testing/selftests/x86/Makefile
@@ -17,7 +17,8 @@ TARGETS_C_BOTHBITS := single_step_syscall sysret_ss_attrs syscall_nt test_mremap
 TARGETS_C_32BIT_ONLY := entry_from_vm86 test_syscall_vdso unwind_vdso \
 			test_FCMOV test_FCOMI test_FISTTP \
 			vdso_restorer
-TARGETS_C_64BIT_ONLY := fsgsbase sysret_rip syscall_numbering
+TARGETS_C_64BIT_ONLY := fsgsbase sysret_rip syscall_numbering \
+			corrupt_xstate_header
 # Some selftests require 32bit support enabled also on 64bit systems
 TARGETS_C_32BIT_NEEDED := ldt_gdt ptrace_syscall
 
diff --git a/tools/testing/selftests/x86/corrupt_xstate_header.c b/tools/testing/selftests/x86/corrupt_xstate_header.c
new file mode 100644
index 0000000..ab8599c
--- /dev/null
+++ b/tools/testing/selftests/x86/corrupt_xstate_header.c
@@ -0,0 +1,114 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Corrupt the XSTATE header in a signal frame
+ *
+ * Based on analysis and a test case from Thomas Gleixner.
+ */
+
+#define _GNU_SOURCE
+
+#include <stdlib.h>
+#include <stdio.h>
+#include <string.h>
+#include <sched.h>
+#include <signal.h>
+#include <err.h>
+#include <unistd.h>
+#include <stdint.h>
+#include <sys/wait.h>
+
+static inline void __cpuid(unsigned int *eax, unsigned int *ebx,
+			   unsigned int *ecx, unsigned int *edx)
+{
+	asm volatile(
+		"cpuid;"
+		: "=a" (*eax),
+		  "=b" (*ebx),
+		  "=c" (*ecx),
+		  "=d" (*edx)
+		: "0" (*eax), "2" (*ecx));
+}
+
+static inline int xsave_enabled(void)
+{
+	unsigned int eax, ebx, ecx, edx;
+
+	eax = 0x1;
+	ecx = 0x0;
+	__cpuid(&eax, &ebx, &ecx, &edx);
+
+	/* Is CR4.OSXSAVE enabled ? */
+	return ecx & (1U << 27);
+}
+
+static void sethandler(int sig, void (*handler)(int, siginfo_t *, void *),
+		       int flags)
+{
+	struct sigaction sa;
+
+	memset(&sa, 0, sizeof(sa));
+	sa.sa_sigaction = handler;
+	sa.sa_flags = SA_SIGINFO | flags;
+	sigemptyset(&sa.sa_mask);
+	if (sigaction(sig, &sa, 0))
+		err(1, "sigaction");
+}
+
+static void sigusr1(int sig, siginfo_t *info, void *uc_void)
+{
+	ucontext_t *uc = uc_void;
+	uint8_t *fpstate = (uint8_t *)uc->uc_mcontext.fpregs;
+	uint64_t *xfeatures = (uint64_t *)(fpstate + 512);
+
+	printf("\tWreck XSTATE header\n");
+	/* Wreck the first reserved bytes in the header */
+	*(xfeatures + 2) = 0xfffffff;
+}
+
+static void sigsegv(int sig, siginfo_t *info, void *uc_void)
+{
+	printf("\tGot SIGSEGV\n");
+}
+
+int main(void)
+{
+	cpu_set_t set;
+
+	sethandler(SIGUSR1, sigusr1, 0);
+	sethandler(SIGSEGV, sigsegv, 0);
+
+	if (!xsave_enabled()) {
+		printf("[SKIP] CR4.OSXSAVE disabled.\n");
+		return 0;
+	}
+
+	CPU_ZERO(&set);
+	CPU_SET(0, &set);
+
+	/*
+	 * Enforce that the child runs on the same CPU
+	 * which in turn forces a schedule.
+	 */
+	sched_setaffinity(getpid(), sizeof(set), &set);
+
+	printf("[RUN]\tSend ourselves a signal\n");
+	raise(SIGUSR1);
+
+	printf("[OK]\tBack from the signal.  Now schedule.\n");
+	pid_t child = fork();
+	if (child < 0)
+		err(1, "fork");
+	if (child == 0)
+		return 0;
+	if (child)
+		waitpid(child, NULL, 0);
+	printf("[OK]\tBack in the main thread.\n");
+
+	/*
+	 * We could try to confirm that extended state is still preserved
+	 * when we schedule.  For now, the only indication of failure is
+	 * a warning in the kernel logs.
+	 */
+
+	return 0;
+}
