Return-Path: <linux-tip-commits+bounces-3678-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 08605A45E90
	for <lists+linux-tip-commits@lfdr.de>; Wed, 26 Feb 2025 13:21:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0AB337A7068
	for <lists+linux-tip-commits@lfdr.de>; Wed, 26 Feb 2025 12:20:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F5DC22AE65;
	Wed, 26 Feb 2025 12:15:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="TZp63hqp";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="I/4rbTGc"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 799B8222580;
	Wed, 26 Feb 2025 12:15:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740572115; cv=none; b=crEbUotHS/8n7mF6SGUWqNENb9ItlfJdnODb1tjh+SU6d1GOUH3+LugXjxg4ioCWio1XrTlAUOw0Wi4j3DnUNx313EctxZAf1e5GqAfptusVdKBaAlAiqJ6WoWx+vQvR4yccdDbtWxggP/P1xiVOVhoACzOsbMhLH3NyE02kGaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740572115; c=relaxed/simple;
	bh=+A4fc/9sd3bzEXsFiQVJVj4zEadL13jGMgekg5I7538=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=XB7ziK3RvRigwbBj09R8BPnIyUvWREjKzL4B8HpX6LjwPtmKmhx6X7jmBZX7i92o+WNBO+bXpW/5STm12ZwaUYzSr63TfVK5SlzFXYRmWHwVuKWbiqbNxbcB+xeFU3jIIdMatQrCIkA4J+sQIcfjjTc8gMFz4QR6RfVRDBepLBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=TZp63hqp; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=I/4rbTGc; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 26 Feb 2025 12:15:10 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1740572111;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yoyxU80YkXzHQbIKpLnwaQV6q10nEsaSHeBbb0B6ecU=;
	b=TZp63hqp6GwrhdhxNeoRX73Ylp/aucdIyJAUWpKUN0+vm1SwrDNbp/IA/1s+zYOgXUilcR
	LNBp50VUE6muUNs+A8lOmDgd3XWeHePZmdfPv+tSFpgxWozmlk+I7yONvty/fT3c9KcadX
	srQU6uLvV1zwyrnFqLVHMQlcIgOBVKWd6Lva7UMTE2QvM1QK6gRrl0k0nDUumAPph48iFH
	HgjTNClgHK2tunQAcsHI/z2A+LYsKvXs4om+5MGCYbqDR+ipPSiGmU6bZOfI1IJ2ipT/Ul
	jcOQrUFXk4Uamwjqlym8jaHJ80vY1lfSgOsMHC+aaaImLBTajOlHY2Ivxpcpdg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1740572111;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yoyxU80YkXzHQbIKpLnwaQV6q10nEsaSHeBbb0B6ecU=;
	b=I/4rbTGcjF/bh4crfIVg40bY/LPBOchRoJNJctKW8LiXm+QKNlyfPHmpwS3q089ORoKLAl
	WDOAR9vqPVy79FCw==
From: "tip-bot2 for Chang S. Bae" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: x86/fpu] selftests/x86: Consolidate redundant signal helper functions
Cc: "Chang S. Bae" <chang.seok.bae@intel.com>, Ingo Molnar <mingo@kernel.org>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250226010731.2456-2-chang.seok.bae@intel.com>
References: <20250226010731.2456-2-chang.seok.bae@intel.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174057211051.10177.16541749631448182589.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/fpu branch of tip:

Commit-ID:     dbd6b649e7d5b66c7fa95a65d67b59cf5b45f0ac
Gitweb:        https://git.kernel.org/tip/dbd6b649e7d5b66c7fa95a65d67b59cf5b45f0ac
Author:        Chang S. Bae <chang.seok.bae@intel.com>
AuthorDate:    Tue, 25 Feb 2025 17:07:21 -08:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Wed, 26 Feb 2025 13:05:28 +01:00

selftests/x86: Consolidate redundant signal helper functions

The x86 selftests frequently register and clean up signal handlers, but
the sethandler() and clearhandler() functions have been redundantly
copied across multiple .c files.

Move these functions to helpers.h to enable reuse across tests,
eliminating around 250 lines of duplicate code.

Converge the error handling by using ksft_exit_fail_msg(), which is
functionally equivalent with err() within the selftest framework.

This change is a prerequisite for the upcoming xstate selftest, which
requires signal handling for registering and cleaning up handlers.

Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/20250226010731.2456-2-chang.seok.bae@intel.com
---
 tools/testing/selftests/x86/amx.c                   | 25 +-----------
 tools/testing/selftests/x86/corrupt_xstate_header.c | 14 +------
 tools/testing/selftests/x86/entry_from_vm86.c       | 24 +----------
 tools/testing/selftests/x86/fsgsbase.c              | 24 +----------
 tools/testing/selftests/x86/helpers.h               | 28 ++++++++++++-
 tools/testing/selftests/x86/ioperm.c                | 25 +-----------
 tools/testing/selftests/x86/iopl.c                  | 25 +-----------
 tools/testing/selftests/x86/ldt_gdt.c               | 18 +-------
 tools/testing/selftests/x86/mov_ss_trap.c           | 14 +------
 tools/testing/selftests/x86/ptrace_syscall.c        | 24 +----------
 tools/testing/selftests/x86/sigaltstack.c           | 26 +-----------
 tools/testing/selftests/x86/sigreturn.c             | 24 +----------
 tools/testing/selftests/x86/single_step_syscall.c   | 22 +---------
 tools/testing/selftests/x86/syscall_arg_fault.c     | 12 +-----
 tools/testing/selftests/x86/syscall_nt.c            | 12 +-----
 tools/testing/selftests/x86/sysret_rip.c            | 24 +----------
 tools/testing/selftests/x86/test_vsyscall.c         | 13 +------
 tools/testing/selftests/x86/unwind_vdso.c           | 12 +-----
 18 files changed, 51 insertions(+), 315 deletions(-)

diff --git a/tools/testing/selftests/x86/amx.c b/tools/testing/selftests/x86/amx.c
index 1fdf35a..0f355f3 100644
--- a/tools/testing/selftests/x86/amx.c
+++ b/tools/testing/selftests/x86/amx.c
@@ -20,6 +20,7 @@
 #include <sys/uio.h>
 
 #include "../kselftest.h" /* For __cpuid_count() */
+#include "helpers.h"
 
 #ifndef __x86_64__
 # error This test is 64-bit only
@@ -61,30 +62,6 @@ static inline void xrstor(struct xsave_buffer *xbuf, uint64_t rfbm)
 /* err() exits and will not return */
 #define fatal_error(msg, ...)	err(1, "[FAIL]\t" msg, ##__VA_ARGS__)
 
-static void sethandler(int sig, void (*handler)(int, siginfo_t *, void *),
-		       int flags)
-{
-	struct sigaction sa;
-
-	memset(&sa, 0, sizeof(sa));
-	sa.sa_sigaction = handler;
-	sa.sa_flags = SA_SIGINFO | flags;
-	sigemptyset(&sa.sa_mask);
-	if (sigaction(sig, &sa, 0))
-		fatal_error("sigaction");
-}
-
-static void clearhandler(int sig)
-{
-	struct sigaction sa;
-
-	memset(&sa, 0, sizeof(sa));
-	sa.sa_handler = SIG_DFL;
-	sigemptyset(&sa.sa_mask);
-	if (sigaction(sig, &sa, 0))
-		fatal_error("sigaction");
-}
-
 #define XFEATURE_XTILECFG	17
 #define XFEATURE_XTILEDATA	18
 #define XFEATURE_MASK_XTILECFG	(1 << XFEATURE_XTILECFG)
diff --git a/tools/testing/selftests/x86/corrupt_xstate_header.c b/tools/testing/selftests/x86/corrupt_xstate_header.c
index cf9ce8f..93a89a5 100644
--- a/tools/testing/selftests/x86/corrupt_xstate_header.c
+++ b/tools/testing/selftests/x86/corrupt_xstate_header.c
@@ -18,6 +18,7 @@
 #include <sys/wait.h>
 
 #include "../kselftest.h" /* For __cpuid_count() */
+#include "helpers.h"
 
 static inline int xsave_enabled(void)
 {
@@ -29,19 +30,6 @@ static inline int xsave_enabled(void)
 	return ecx & (1U << 27);
 }
 
-static void sethandler(int sig, void (*handler)(int, siginfo_t *, void *),
-		       int flags)
-{
-	struct sigaction sa;
-
-	memset(&sa, 0, sizeof(sa));
-	sa.sa_sigaction = handler;
-	sa.sa_flags = SA_SIGINFO | flags;
-	sigemptyset(&sa.sa_mask);
-	if (sigaction(sig, &sa, 0))
-		err(1, "sigaction");
-}
-
 static void sigusr1(int sig, siginfo_t *info, void *uc_void)
 {
 	ucontext_t *uc = uc_void;
diff --git a/tools/testing/selftests/x86/entry_from_vm86.c b/tools/testing/selftests/x86/entry_from_vm86.c
index d1e919b..5cb8393 100644
--- a/tools/testing/selftests/x86/entry_from_vm86.c
+++ b/tools/testing/selftests/x86/entry_from_vm86.c
@@ -24,31 +24,11 @@
 #include <errno.h>
 #include <sys/vm86.h>
 
+#include "helpers.h"
+
 static unsigned long load_addr = 0x10000;
 static int nerrs = 0;
 
-static void sethandler(int sig, void (*handler)(int, siginfo_t *, void *),
-		       int flags)
-{
-	struct sigaction sa;
-	memset(&sa, 0, sizeof(sa));
-	sa.sa_sigaction = handler;
-	sa.sa_flags = SA_SIGINFO | flags;
-	sigemptyset(&sa.sa_mask);
-	if (sigaction(sig, &sa, 0))
-		err(1, "sigaction");
-}
-
-static void clearhandler(int sig)
-{
-	struct sigaction sa;
-	memset(&sa, 0, sizeof(sa));
-	sa.sa_handler = SIG_DFL;
-	sigemptyset(&sa.sa_mask);
-	if (sigaction(sig, &sa, 0))
-		err(1, "sigaction");
-}
-
 static sig_atomic_t got_signal;
 
 static void sighandler(int sig, siginfo_t *info, void *ctx_void)
diff --git a/tools/testing/selftests/x86/fsgsbase.c b/tools/testing/selftests/x86/fsgsbase.c
index 50cf32d..0a75252 100644
--- a/tools/testing/selftests/x86/fsgsbase.c
+++ b/tools/testing/selftests/x86/fsgsbase.c
@@ -28,6 +28,8 @@
 #include <sys/wait.h>
 #include <setjmp.h>
 
+#include "helpers.h"
+
 #ifndef __x86_64__
 # error This test is 64-bit only
 #endif
@@ -39,28 +41,6 @@ static unsigned short *shared_scratch;
 
 static int nerrs;
 
-static void sethandler(int sig, void (*handler)(int, siginfo_t *, void *),
-		       int flags)
-{
-	struct sigaction sa;
-	memset(&sa, 0, sizeof(sa));
-	sa.sa_sigaction = handler;
-	sa.sa_flags = SA_SIGINFO | flags;
-	sigemptyset(&sa.sa_mask);
-	if (sigaction(sig, &sa, 0))
-		err(1, "sigaction");
-}
-
-static void clearhandler(int sig)
-{
-	struct sigaction sa;
-	memset(&sa, 0, sizeof(sa));
-	sa.sa_handler = SIG_DFL;
-	sigemptyset(&sa.sa_mask);
-	if (sigaction(sig, &sa, 0))
-		err(1, "sigaction");
-}
-
 static void sigsegv(int sig, siginfo_t *si, void *ctx_void)
 {
 	ucontext_t *ctx = (ucontext_t*)ctx_void;
diff --git a/tools/testing/selftests/x86/helpers.h b/tools/testing/selftests/x86/helpers.h
index 4ef42c4..6deaad0 100644
--- a/tools/testing/selftests/x86/helpers.h
+++ b/tools/testing/selftests/x86/helpers.h
@@ -2,8 +2,13 @@
 #ifndef __SELFTESTS_X86_HELPERS_H
 #define __SELFTESTS_X86_HELPERS_H
 
+#include <signal.h>
+#include <string.h>
+
 #include <asm/processor-flags.h>
 
+#include "../kselftest.h"
+
 static inline unsigned long get_eflags(void)
 {
 #ifdef __x86_64__
@@ -22,4 +27,27 @@ static inline void set_eflags(unsigned long eflags)
 #endif
 }
 
+static inline void sethandler(int sig, void (*handler)(int, siginfo_t *, void *), int flags)
+{
+	struct sigaction sa;
+
+	memset(&sa, 0, sizeof(sa));
+	sa.sa_sigaction = handler;
+	sa.sa_flags = SA_SIGINFO | flags;
+	sigemptyset(&sa.sa_mask);
+	if (sigaction(sig, &sa, 0))
+		ksft_exit_fail_msg("sigaction failed");
+}
+
+static inline void clearhandler(int sig)
+{
+	struct sigaction sa;
+
+	memset(&sa, 0, sizeof(sa));
+	sa.sa_handler = SIG_DFL;
+	sigemptyset(&sa.sa_mask);
+	if (sigaction(sig, &sa, 0))
+		ksft_exit_fail_msg("sigaction failed");
+}
+
 #endif /* __SELFTESTS_X86_HELPERS_H */
diff --git a/tools/testing/selftests/x86/ioperm.c b/tools/testing/selftests/x86/ioperm.c
index 57ec5e9..69d5fb7 100644
--- a/tools/testing/selftests/x86/ioperm.c
+++ b/tools/testing/selftests/x86/ioperm.c
@@ -20,30 +20,9 @@
 #include <sched.h>
 #include <sys/io.h>
 
-static int nerrs = 0;
-
-static void sethandler(int sig, void (*handler)(int, siginfo_t *, void *),
-		       int flags)
-{
-	struct sigaction sa;
-	memset(&sa, 0, sizeof(sa));
-	sa.sa_sigaction = handler;
-	sa.sa_flags = SA_SIGINFO | flags;
-	sigemptyset(&sa.sa_mask);
-	if (sigaction(sig, &sa, 0))
-		err(1, "sigaction");
-
-}
+#include "helpers.h"
 
-static void clearhandler(int sig)
-{
-	struct sigaction sa;
-	memset(&sa, 0, sizeof(sa));
-	sa.sa_handler = SIG_DFL;
-	sigemptyset(&sa.sa_mask);
-	if (sigaction(sig, &sa, 0))
-		err(1, "sigaction");
-}
+static int nerrs = 0;
 
 static jmp_buf jmpbuf;
 
diff --git a/tools/testing/selftests/x86/iopl.c b/tools/testing/selftests/x86/iopl.c
index 7e3e09c..457b671 100644
--- a/tools/testing/selftests/x86/iopl.c
+++ b/tools/testing/selftests/x86/iopl.c
@@ -20,30 +20,9 @@
 #include <sched.h>
 #include <sys/io.h>
 
-static int nerrs = 0;
-
-static void sethandler(int sig, void (*handler)(int, siginfo_t *, void *),
-		       int flags)
-{
-	struct sigaction sa;
-	memset(&sa, 0, sizeof(sa));
-	sa.sa_sigaction = handler;
-	sa.sa_flags = SA_SIGINFO | flags;
-	sigemptyset(&sa.sa_mask);
-	if (sigaction(sig, &sa, 0))
-		err(1, "sigaction");
-
-}
+#include "helpers.h"
 
-static void clearhandler(int sig)
-{
-	struct sigaction sa;
-	memset(&sa, 0, sizeof(sa));
-	sa.sa_handler = SIG_DFL;
-	sigemptyset(&sa.sa_mask);
-	if (sigaction(sig, &sa, 0))
-		err(1, "sigaction");
-}
+static int nerrs = 0;
 
 static jmp_buf jmpbuf;
 
diff --git a/tools/testing/selftests/x86/ldt_gdt.c b/tools/testing/selftests/x86/ldt_gdt.c
index 3a29346..bb99a71 100644
--- a/tools/testing/selftests/x86/ldt_gdt.c
+++ b/tools/testing/selftests/x86/ldt_gdt.c
@@ -26,6 +26,8 @@
 #include <asm/prctl.h>
 #include <sys/prctl.h>
 
+#include "helpers.h"
+
 #define AR_ACCESSED		(1<<8)
 
 #define AR_TYPE_RODATA		(0 * (1<<9))
@@ -506,20 +508,6 @@ static void fix_sa_restorer(int sig)
 }
 #endif
 
-static void sethandler(int sig, void (*handler)(int, siginfo_t *, void *),
-		       int flags)
-{
-	struct sigaction sa;
-	memset(&sa, 0, sizeof(sa));
-	sa.sa_sigaction = handler;
-	sa.sa_flags = SA_SIGINFO | flags;
-	sigemptyset(&sa.sa_mask);
-	if (sigaction(sig, &sa, 0))
-		err(1, "sigaction");
-
-	fix_sa_restorer(sig);
-}
-
 static jmp_buf jmpbuf;
 
 static void sigsegv(int sig, siginfo_t *info, void *ctx_void)
@@ -549,9 +537,11 @@ static void do_multicpu_tests(void)
 	}
 
 	sethandler(SIGSEGV, sigsegv, 0);
+	fix_sa_restorer(SIGSEGV);
 #ifdef __i386__
 	/* True 32-bit kernels send SIGILL instead of SIGSEGV on IRET faults. */
 	sethandler(SIGILL, sigsegv, 0);
+	fix_sa_restorer(SIGILL);
 #endif
 
 	printf("[RUN]\tCross-CPU LDT invalidation\n");
diff --git a/tools/testing/selftests/x86/mov_ss_trap.c b/tools/testing/selftests/x86/mov_ss_trap.c
index cc3de6f..f22cb6b 100644
--- a/tools/testing/selftests/x86/mov_ss_trap.c
+++ b/tools/testing/selftests/x86/mov_ss_trap.c
@@ -36,7 +36,7 @@
 #include <setjmp.h>
 #include <sys/prctl.h>
 
-#define X86_EFLAGS_RF (1UL << 16)
+#include "helpers.h"
 
 #if __x86_64__
 # define REG_IP REG_RIP
@@ -94,18 +94,6 @@ static void enable_watchpoint(void)
 	}
 }
 
-static void sethandler(int sig, void (*handler)(int, siginfo_t *, void *),
-		       int flags)
-{
-	struct sigaction sa;
-	memset(&sa, 0, sizeof(sa));
-	sa.sa_sigaction = handler;
-	sa.sa_flags = SA_SIGINFO | flags;
-	sigemptyset(&sa.sa_mask);
-	if (sigaction(sig, &sa, 0))
-		err(1, "sigaction");
-}
-
 static char const * const signames[] = {
 	[SIGSEGV] = "SIGSEGV",
 	[SIGBUS] = "SIBGUS",
diff --git a/tools/testing/selftests/x86/ptrace_syscall.c b/tools/testing/selftests/x86/ptrace_syscall.c
index 12aaa06..360ec88 100644
--- a/tools/testing/selftests/x86/ptrace_syscall.c
+++ b/tools/testing/selftests/x86/ptrace_syscall.c
@@ -15,6 +15,8 @@
 #include <asm/ptrace-abi.h>
 #include <sys/auxv.h>
 
+#include "helpers.h"
+
 /* Bitness-agnostic defines for user_regs_struct fields. */
 #ifdef __x86_64__
 # define user_syscall_nr	orig_rax
@@ -93,18 +95,6 @@ static siginfo_t wait_trap(pid_t chld)
 	return si;
 }
 
-static void sethandler(int sig, void (*handler)(int, siginfo_t *, void *),
-		       int flags)
-{
-	struct sigaction sa;
-	memset(&sa, 0, sizeof(sa));
-	sa.sa_sigaction = handler;
-	sa.sa_flags = SA_SIGINFO | flags;
-	sigemptyset(&sa.sa_mask);
-	if (sigaction(sig, &sa, 0))
-		err(1, "sigaction");
-}
-
 static void setsigign(int sig, int flags)
 {
 	struct sigaction sa;
@@ -116,16 +106,6 @@ static void setsigign(int sig, int flags)
 		err(1, "sigaction");
 }
 
-static void clearhandler(int sig)
-{
-	struct sigaction sa;
-	memset(&sa, 0, sizeof(sa));
-	sa.sa_handler = SIG_DFL;
-	sigemptyset(&sa.sa_mask);
-	if (sigaction(sig, &sa, 0))
-		err(1, "sigaction");
-}
-
 #ifdef __x86_64__
 # define REG_BP REG_RBP
 #else
diff --git a/tools/testing/selftests/x86/sigaltstack.c b/tools/testing/selftests/x86/sigaltstack.c
index f689af7..0ae1b78 100644
--- a/tools/testing/selftests/x86/sigaltstack.c
+++ b/tools/testing/selftests/x86/sigaltstack.c
@@ -14,6 +14,8 @@
 #include <sys/resource.h>
 #include <setjmp.h>
 
+#include "helpers.h"
+
 /* sigaltstack()-enforced minimum stack */
 #define ENFORCED_MINSIGSTKSZ	2048
 
@@ -27,30 +29,6 @@ static bool sigalrm_expected;
 
 static unsigned long at_minstack_size;
 
-static void sethandler(int sig, void (*handler)(int, siginfo_t *, void *),
-		       int flags)
-{
-	struct sigaction sa;
-
-	memset(&sa, 0, sizeof(sa));
-	sa.sa_sigaction = handler;
-	sa.sa_flags = SA_SIGINFO | flags;
-	sigemptyset(&sa.sa_mask);
-	if (sigaction(sig, &sa, 0))
-		err(1, "sigaction");
-}
-
-static void clearhandler(int sig)
-{
-	struct sigaction sa;
-
-	memset(&sa, 0, sizeof(sa));
-	sa.sa_handler = SIG_DFL;
-	sigemptyset(&sa.sa_mask);
-	if (sigaction(sig, &sa, 0))
-		err(1, "sigaction");
-}
-
 static int setup_altstack(void *start, unsigned long size)
 {
 	stack_t ss;
diff --git a/tools/testing/selftests/x86/sigreturn.c b/tools/testing/selftests/x86/sigreturn.c
index 0b75b29..26ef562 100644
--- a/tools/testing/selftests/x86/sigreturn.c
+++ b/tools/testing/selftests/x86/sigreturn.c
@@ -46,6 +46,8 @@
 #include <sys/ptrace.h>
 #include <sys/user.h>
 
+#include "helpers.h"
+
 /* Pull in AR_xyz defines. */
 typedef unsigned int u32;
 typedef unsigned short u16;
@@ -138,28 +140,6 @@ static unsigned short LDT3(int idx)
 	return (idx << 3) | 7;
 }
 
-static void sethandler(int sig, void (*handler)(int, siginfo_t *, void *),
-		       int flags)
-{
-	struct sigaction sa;
-	memset(&sa, 0, sizeof(sa));
-	sa.sa_sigaction = handler;
-	sa.sa_flags = SA_SIGINFO | flags;
-	sigemptyset(&sa.sa_mask);
-	if (sigaction(sig, &sa, 0))
-		err(1, "sigaction");
-}
-
-static void clearhandler(int sig)
-{
-	struct sigaction sa;
-	memset(&sa, 0, sizeof(sa));
-	sa.sa_handler = SIG_DFL;
-	sigemptyset(&sa.sa_mask);
-	if (sigaction(sig, &sa, 0))
-		err(1, "sigaction");
-}
-
 static void add_ldt(const struct user_desc *desc, unsigned short *var,
 		    const char *name)
 {
diff --git a/tools/testing/selftests/x86/single_step_syscall.c b/tools/testing/selftests/x86/single_step_syscall.c
index 9a30f44..280d7a2 100644
--- a/tools/testing/selftests/x86/single_step_syscall.c
+++ b/tools/testing/selftests/x86/single_step_syscall.c
@@ -33,28 +33,6 @@
 
 #include "helpers.h"
 
-static void sethandler(int sig, void (*handler)(int, siginfo_t *, void *),
-		       int flags)
-{
-	struct sigaction sa;
-	memset(&sa, 0, sizeof(sa));
-	sa.sa_sigaction = handler;
-	sa.sa_flags = SA_SIGINFO | flags;
-	sigemptyset(&sa.sa_mask);
-	if (sigaction(sig, &sa, 0))
-		err(1, "sigaction");
-}
-
-static void clearhandler(int sig)
-{
-	struct sigaction sa;
-	memset(&sa, 0, sizeof(sa));
-	sa.sa_handler = SIG_DFL;
-	sigemptyset(&sa.sa_mask);
-	if (sigaction(sig, &sa, 0))
-		err(1, "sigaction");
-}
-
 static volatile sig_atomic_t sig_traps, sig_eflags;
 sigjmp_buf jmpbuf;
 
diff --git a/tools/testing/selftests/x86/syscall_arg_fault.c b/tools/testing/selftests/x86/syscall_arg_fault.c
index 48ab065..f67a2df 100644
--- a/tools/testing/selftests/x86/syscall_arg_fault.c
+++ b/tools/testing/selftests/x86/syscall_arg_fault.c
@@ -17,18 +17,6 @@
 
 #include "helpers.h"
 
-static void sethandler(int sig, void (*handler)(int, siginfo_t *, void *),
-		       int flags)
-{
-	struct sigaction sa;
-	memset(&sa, 0, sizeof(sa));
-	sa.sa_sigaction = handler;
-	sa.sa_flags = SA_SIGINFO | flags;
-	sigemptyset(&sa.sa_mask);
-	if (sigaction(sig, &sa, 0))
-		err(1, "sigaction");
-}
-
 static sigjmp_buf jmpbuf;
 
 static volatile sig_atomic_t n_errs;
diff --git a/tools/testing/selftests/x86/syscall_nt.c b/tools/testing/selftests/x86/syscall_nt.c
index a108b80..f9c9814 100644
--- a/tools/testing/selftests/x86/syscall_nt.c
+++ b/tools/testing/selftests/x86/syscall_nt.c
@@ -18,18 +18,6 @@
 
 static unsigned int nerrs;
 
-static void sethandler(int sig, void (*handler)(int, siginfo_t *, void *),
-		       int flags)
-{
-	struct sigaction sa;
-	memset(&sa, 0, sizeof(sa));
-	sa.sa_sigaction = handler;
-	sa.sa_flags = SA_SIGINFO | flags;
-	sigemptyset(&sa.sa_mask);
-	if (sigaction(sig, &sa, 0))
-		err(1, "sigaction");
-}
-
 static void sigtrap(int sig, siginfo_t *si, void *ctx_void)
 {
 }
diff --git a/tools/testing/selftests/x86/sysret_rip.c b/tools/testing/selftests/x86/sysret_rip.c
index b30de9a..5fb531e 100644
--- a/tools/testing/selftests/x86/sysret_rip.c
+++ b/tools/testing/selftests/x86/sysret_rip.c
@@ -22,6 +22,8 @@
 #include <sys/mman.h>
 #include <assert.h>
 
+#include "helpers.h"
+
 /*
  * These items are in clang_helpers_64.S, in order to avoid clang inline asm
  * limitations:
@@ -31,28 +33,6 @@ extern const char test_page[];
 
 static void const *current_test_page_addr = test_page;
 
-static void sethandler(int sig, void (*handler)(int, siginfo_t *, void *),
-		       int flags)
-{
-	struct sigaction sa;
-	memset(&sa, 0, sizeof(sa));
-	sa.sa_sigaction = handler;
-	sa.sa_flags = SA_SIGINFO | flags;
-	sigemptyset(&sa.sa_mask);
-	if (sigaction(sig, &sa, 0))
-		err(1, "sigaction");
-}
-
-static void clearhandler(int sig)
-{
-	struct sigaction sa;
-	memset(&sa, 0, sizeof(sa));
-	sa.sa_handler = SIG_DFL;
-	sigemptyset(&sa.sa_mask);
-	if (sigaction(sig, &sa, 0))
-		err(1, "sigaction");
-}
-
 /* State used by our signal handlers. */
 static gregset_t initial_regs;
 
diff --git a/tools/testing/selftests/x86/test_vsyscall.c b/tools/testing/selftests/x86/test_vsyscall.c
index 6de11b4..05e1e67 100644
--- a/tools/testing/selftests/x86/test_vsyscall.c
+++ b/tools/testing/selftests/x86/test_vsyscall.c
@@ -310,19 +310,6 @@ static void test_getcpu(int cpu)
 static jmp_buf jmpbuf;
 static volatile unsigned long segv_err;
 
-static void sethandler(int sig, void (*handler)(int, siginfo_t *, void *),
-		       int flags)
-{
-	struct sigaction sa;
-
-	memset(&sa, 0, sizeof(sa));
-	sa.sa_sigaction = handler;
-	sa.sa_flags = SA_SIGINFO | flags;
-	sigemptyset(&sa.sa_mask);
-	if (sigaction(sig, &sa, 0))
-		ksft_exit_fail_msg("sigaction failed\n");
-}
-
 static void sigsegv(int sig, siginfo_t *info, void *ctx_void)
 {
 	ucontext_t *ctx = (ucontext_t *)ctx_void;
diff --git a/tools/testing/selftests/x86/unwind_vdso.c b/tools/testing/selftests/x86/unwind_vdso.c
index 4c311e1..9cc1758 100644
--- a/tools/testing/selftests/x86/unwind_vdso.c
+++ b/tools/testing/selftests/x86/unwind_vdso.c
@@ -43,18 +43,6 @@ int main()
 #include <dlfcn.h>
 #include <unwind.h>
 
-static void sethandler(int sig, void (*handler)(int, siginfo_t *, void *),
-		       int flags)
-{
-	struct sigaction sa;
-	memset(&sa, 0, sizeof(sa));
-	sa.sa_sigaction = handler;
-	sa.sa_flags = SA_SIGINFO | flags;
-	sigemptyset(&sa.sa_mask);
-	if (sigaction(sig, &sa, 0))
-		err(1, "sigaction");
-}
-
 static volatile sig_atomic_t nerrs;
 static unsigned long sysinfo;
 static bool got_sysinfo = false;

