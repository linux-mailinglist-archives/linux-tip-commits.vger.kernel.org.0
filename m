Return-Path: <linux-tip-commits+bounces-3672-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 42792A45EBE
	for <lists+linux-tip-commits@lfdr.de>; Wed, 26 Feb 2025 13:24:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6E1B61899331
	for <lists+linux-tip-commits@lfdr.de>; Wed, 26 Feb 2025 12:19:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA386220685;
	Wed, 26 Feb 2025 12:15:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="VfG0TpwD";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="cxs+beE4"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB36C21C160;
	Wed, 26 Feb 2025 12:15:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740572108; cv=none; b=lvKxMfGjQGITtPKPZ80mB4mDDnzdg9ZK3nyT85udOLg9lSe0vat2P0Ku6qHMOAxtnYUKpvTvRUEK9HIMCiGJm/ul/pTXJzdnzc7aljejr4IJclGKLx+Uxi/lLhkoVzSATASoDsT0gOqiL5kcCE9DqvevAJSiSqpk8M+s62Re4A8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740572108; c=relaxed/simple;
	bh=343PP+rMJscGrmVQXb4OfKerqxGnLO1aL9O7r0w2Zew=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=W8DDO1rgiQ0PLXRWYTwqpBQRBS0PgrkhzJa93BoECOYjd4tnEk37706kpLRLfNQ4X3dJgyAUnN184iSohN8aDew1Bp5javawi6APemm649H/4htzgceJDdzh1ZGu4Jz3NUDx0mcqjE0HBW+fyLnRk/D/D54/+cqpvIcOQtvijfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=VfG0TpwD; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=cxs+beE4; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 26 Feb 2025 12:15:04 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1740572105;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=n1b1SDCZF5N0dTJ9caIvP/lPlTSy/bPJIdiY2lXoI4Y=;
	b=VfG0TpwDAZiQiBdMPgDIET4eI/67+dFq+Qp+e/KjFTBoN1VOqtbUg1TQKD2kZkTUXj54L3
	5iPo0jq1hjgrt6DRX/kWFUBSk28ZgFTl4VzW3OHJLdGEHD2OFL4jx/AxJgsYWruiL8BD/m
	YXC5o8x9+FIHRJY8nyWMrcUJqIAUi51+WeZQP7tGo3rlTHIwBmZljZwEu9dfc3WiRvHUYo
	79GKuk2slhHnAFoM09c4+Ni7rgexoq9EKd4uCLNtTcU7R0yWJsH8wAlpX1Hbdz3dTJqLlS
	v619FP/H/Z4wKvKxYq5wWVJK5iruyxKs39PAjiBQAJJaizdcgsu0OtmqD/1TMQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1740572105;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=n1b1SDCZF5N0dTJ9caIvP/lPlTSy/bPJIdiY2lXoI4Y=;
	b=cxs+beE4EFoRysi+ZYrOk0Kb1iH1cw/TAd18dD8HvN4NYHsoOGGfhm6rlqtdJ1QvgOmP2T
	7tYcoN47CpY2voAA==
From: "tip-bot2 for Chang S. Bae" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/fpu] selftests/x86/xstate: Consolidate test invocations
 into a single entry
Cc: "Chang S. Bae" <chang.seok.bae@intel.com>, Ingo Molnar <mingo@kernel.org>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250226010731.2456-8-chang.seok.bae@intel.com>
References: <20250226010731.2456-8-chang.seok.bae@intel.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174057210461.10177.8050759209259343036.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/fpu branch of tip:

Commit-ID:     10d8a204c5009fb8a6cb2790d17b5611b795c349
Gitweb:        https://git.kernel.org/tip/10d8a204c5009fb8a6cb2790d17b5611b795c349
Author:        Chang S. Bae <chang.seok.bae@intel.com>
AuthorDate:    Tue, 25 Feb 2025 17:07:27 -08:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Wed, 26 Feb 2025 13:05:29 +01:00

selftests/x86/xstate: Consolidate test invocations into a single entry

Currently, each of the three xstate tests runs as a separate invocation,
requiring the xstate number to be passed and state information to be
reconstructed repeatedly. This approach arose from their individual and
isolated development, but now it makes sense to unify them.

Introduce a wrapper function that first verifies feature availability
from the kernel and constructs the necessary state information once. The
wrapper then sequentially invokes all tests to ensure consistent
execution.

Update the AMX test to use this unified invocation.

Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/20250226010731.2456-8-chang.seok.bae@intel.com
---
 tools/testing/selftests/x86/amx.c    | 11 +++-----
 tools/testing/selftests/x86/xstate.c | 38 +++++++++++++++++++--------
 tools/testing/selftests/x86/xstate.h |  5 +---
 3 files changed, 35 insertions(+), 19 deletions(-)

diff --git a/tools/testing/selftests/x86/amx.c b/tools/testing/selftests/x86/amx.c
index 9cb691d..40769c1 100644
--- a/tools/testing/selftests/x86/amx.c
+++ b/tools/testing/selftests/x86/amx.c
@@ -480,7 +480,6 @@ static void test_fork(void)
 
 int main(void)
 {
-	const unsigned int ctxtsw_num_threads = 5, ctxtsw_iterations = 10;
 	unsigned long features;
 	long rc;
 
@@ -506,11 +505,11 @@ int main(void)
 
 	test_fork();
 
-	test_context_switch(XFEATURE_XTILEDATA, ctxtsw_num_threads, ctxtsw_iterations);
-
-	test_ptrace(XFEATURE_XTILEDATA);
-
-	test_signal(XFEATURE_XTILEDATA);
+	/*
+	 * Perform generic xstate tests for context switching, ptrace,
+	 * and signal.
+	 */
+	test_xstate(XFEATURE_XTILEDATA);
 
 	clearhandler(SIGILL);
 	free_stashed_xsave();
diff --git a/tools/testing/selftests/x86/xstate.c b/tools/testing/selftests/x86/xstate.c
index b5600f4..fd8451e 100644
--- a/tools/testing/selftests/x86/xstate.c
+++ b/tools/testing/selftests/x86/xstate.c
@@ -6,7 +6,9 @@
 #include <pthread.h>
 #include <stdbool.h>
 
+#include <asm/prctl.h>
 #include <sys/ptrace.h>
+#include <sys/syscall.h>
 #include <sys/uio.h>
 #include <sys/wait.h>
 
@@ -189,15 +191,13 @@ static void affinitize_cpu0(void)
 		ksft_exit_fail_msg("sched_setaffinity to CPU 0 failed\n");
 }
 
-void test_context_switch(uint32_t feature_num, uint32_t num_threads, uint32_t iterations)
+static void test_context_switch(uint32_t num_threads, uint32_t iterations)
 {
 	struct futex_info *finfo;
 
 	/* Affinitize to one CPU to force context switches */
 	affinitize_cpu0();
 
-	xstate = get_xstate_info(feature_num);
-
 	printf("[RUN]\t%s: check context switches, %d iterations, %d threads.\n",
 	       xstate.name, iterations, num_threads);
 
@@ -299,13 +299,11 @@ static void ptracer_inject_xstate(pid_t target)
 	free(xbuf2);
 }
 
-void test_ptrace(uint32_t feature_num)
+static void test_ptrace(void)
 {
 	pid_t child;
 	int status;
 
-	xstate = get_xstate_info(feature_num);
-
 	child = fork();
 	if (child < 0) {
 		ksft_exit_fail_msg("fork() failed\n");
@@ -392,17 +390,14 @@ static void validate_sigfpstate(int sig, siginfo_t *si, void *ctx_void)
 	copy_xstate(stashed_xbuf, xbuf);
 }
 
-void test_signal(uint32_t feature_num)
+static void test_signal(void)
 {
 	bool valid_xstate;
 
-	xstate = get_xstate_info(feature_num);
-
 	/*
 	 * The signal handler will access this to verify xstate context
 	 * preservation.
 	 */
-
 	stashed_xbuf = alloc_xbuf();
 	if (!stashed_xbuf)
 		ksft_exit_fail_msg("unable to allocate XSAVE buffer\n");
@@ -433,3 +428,26 @@ void test_signal(uint32_t feature_num)
 	clearhandler(SIGUSR1);
 	free(stashed_xbuf);
 }
+
+void test_xstate(uint32_t feature_num)
+{
+	const unsigned int ctxtsw_num_threads = 5, ctxtsw_iterations = 10;
+	unsigned long features;
+	long rc;
+
+	rc = syscall(SYS_arch_prctl, ARCH_GET_XCOMP_SUPP, &features);
+	if (rc || !(features & (1 << feature_num))) {
+		ksft_print_msg("The kernel does not support feature number: %u\n", feature_num);
+		return;
+	}
+
+	xstate = get_xstate_info(feature_num);
+	if (!xstate.size || !xstate.xbuf_offset) {
+		ksft_exit_fail_msg("invalid state size/offset (%d/%d)\n",
+				   xstate.size, xstate.xbuf_offset);
+	}
+
+	test_context_switch(ctxtsw_num_threads, ctxtsw_iterations);
+	test_ptrace();
+	test_signal();
+}
diff --git a/tools/testing/selftests/x86/xstate.h b/tools/testing/selftests/x86/xstate.h
index 4d0ffe9..42af36e 100644
--- a/tools/testing/selftests/x86/xstate.h
+++ b/tools/testing/selftests/x86/xstate.h
@@ -189,8 +189,7 @@ static inline void set_rand_data(struct xstate_info *xstate, struct xsave_buffer
 		*ptr = data;
 }
 
-void test_context_switch(uint32_t feature_num, uint32_t num_threads, uint32_t iterations);
-void test_ptrace(uint32_t feature_num);
-void test_signal(uint32_t feature_num);
+/* Testing kernel's context switching and ABI support for the xstate. */
+void test_xstate(uint32_t feature_num);
 
 #endif /* __SELFTESTS_X86_XSTATE_H */

