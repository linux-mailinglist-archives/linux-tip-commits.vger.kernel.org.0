Return-Path: <linux-tip-commits+bounces-3674-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C8FC4A45E8D
	for <lists+linux-tip-commits@lfdr.de>; Wed, 26 Feb 2025 13:20:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 008E7167FF3
	for <lists+linux-tip-commits@lfdr.de>; Wed, 26 Feb 2025 12:20:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EB1422333A;
	Wed, 26 Feb 2025 12:15:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="COR4gKZm";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="36rJ1k5X"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A52421D3FF;
	Wed, 26 Feb 2025 12:15:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740572110; cv=none; b=sJEVA3wqHOK8DFc0PX9Kka0yqZFOSrEdrS6rKGAZ8/mMrdmhmb5midjpsugBnXK++MSa6XOe0ABHzXvq1ZNQTILxgaWnhXGwY1HDILkXmK3KbqeN6Lo5faeBCKlcBB8XwHxdibd331eNrDzt3Qg5pJYpoto/6QXIZNS7VxVsQ8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740572110; c=relaxed/simple;
	bh=b9QmZzmh2WflAXViBmu2pm9aty3awYaH2mF+B3GrfBk=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=K2cF9tWYY7ARtc8uBJEgfsQF/MrCQeDYVUtjtV3i1nLtbGXwaF+x7ofNS2dMGFOtDAPtt+CmC8ZC8WFiaaMG8maDh34JCnicVsUwhQaQjJsYgvYNayYxSqFZE4YGNqb/tFpe+NMSwVupFZWI/T2vlMdiOBVCzYCuqcCGcEx0y3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=COR4gKZm; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=36rJ1k5X; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 26 Feb 2025 12:15:06 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1740572106;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=y3KFWfEOxs06YvVwNNzFPcDsj+XewpKCJt5oNy/PkZk=;
	b=COR4gKZmGrZk4GDGgoWNDqjf72la+JRZf4NoIj/mpwU7tGmimp9ki9KUx6OMC5u28JVvmd
	xPXLivIcVfLXs/GKc83DvwTZaqu8tNNhA3IiY2yPyHqQ8OC9AcGu81UfG1jBseuowKJfWK
	sql3q/NszOG9orzIbUTkNgRKoITeZzX3QuYowc3mgXCT70tW7gNcvYG1SmDuDWw2zVmNe7
	DMLAtM+WND6cuv+scWA1blEBfuOvHUef77SH9kBUA0aXkxdwu9vg64vwR+Yx03I8jI7RYh
	VKHPOWPHwuHqvnQmbJ9BmL4QuiZw+ExjWIXYSGvrJR/TVKneVD14WyDdqk754Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1740572106;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=y3KFWfEOxs06YvVwNNzFPcDsj+XewpKCJt5oNy/PkZk=;
	b=36rJ1k5XppWTweYpJl6u5pjduKQgXilwFYiATzdrUcvbzrxPjWm+Fv3lRt32U/pi1MdIzH
	tJNBiXb4i8ZTP9DA==
From: "tip-bot2 for Chang S. Bae" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/fpu] selftests/x86/xstate: Refactor ptrace ABI test
Cc: "Chang S. Bae" <chang.seok.bae@intel.com>, Ingo Molnar <mingo@kernel.org>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250226010731.2456-6-chang.seok.bae@intel.com>
References: <20250226010731.2456-6-chang.seok.bae@intel.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174057210611.10177.8781465858635484679.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/fpu branch of tip:

Commit-ID:     7cb2fbe41949caa35ef1805323b8fc011fac2537
Gitweb:        https://git.kernel.org/tip/7cb2fbe41949caa35ef1805323b8fc011fac2537
Author:        Chang S. Bae <chang.seok.bae@intel.com>
AuthorDate:    Tue, 25 Feb 2025 17:07:25 -08:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Wed, 26 Feb 2025 13:05:29 +01:00

selftests/x86/xstate: Refactor ptrace ABI test

Following the refactoring of the context switching test, the ptrace test is
another component reusable for other xstate features. As part of this
restructuring, add a missing check to validate the
user_xstateregs->xstate_fx_sw field in the ABI.

Also, replace err() and fatal_error() with ksft_exit_fail_msg() for
consistency in error handling.

  Expected output:
  $ amx_64
  ...
  [RUN]   AMX Tile data: inject xstate via ptrace().
  [OK]    'xfeatures' in SW reserved area was correctly written
  [OK]    xstate was correctly updated.

Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/20250226010731.2456-6-chang.seok.bae@intel.com
---
 tools/testing/selftests/x86/amx.c    | 108 +----------------------
 tools/testing/selftests/x86/xstate.c | 129 ++++++++++++++++++++++++++-
 tools/testing/selftests/x86/xstate.h |   1 +-
 3 files changed, 131 insertions(+), 107 deletions(-)

diff --git a/tools/testing/selftests/x86/amx.c b/tools/testing/selftests/x86/amx.c
index b3c51dd..4bafbb7 100644
--- a/tools/testing/selftests/x86/amx.c
+++ b/tools/testing/selftests/x86/amx.c
@@ -13,10 +13,8 @@
 #include <sys/auxv.h>
 #include <sys/mman.h>
 #include <sys/shm.h>
-#include <sys/ptrace.h>
 #include <sys/syscall.h>
 #include <sys/wait.h>
-#include <sys/uio.h>
 
 #include "helpers.h"
 #include "xstate.h"
@@ -32,8 +30,6 @@
 #define XFEATURE_MASK_XTILEDATA	(1 << XFEATURE_XTILEDATA)
 #define XFEATURE_MASK_XTILE	(XFEATURE_MASK_XTILECFG | XFEATURE_MASK_XTILEDATA)
 
-static uint32_t xbuf_size;
-
 struct xstate_info xtiledata;
 
 /* The helpers for managing XSAVE buffer and tile states: */
@@ -154,13 +150,6 @@ static inline bool load_rand_tiledata(struct xsave_buffer *xbuf)
 	return xrstor_safe(xbuf, XFEATURE_MASK_XTILEDATA);
 }
 
-/* Return XTILEDATA to its initial configuration. */
-static inline void init_xtiledata(void)
-{
-	clear_xstate_header(stashed_xsave);
-	xrstor_safe(stashed_xsave, XFEATURE_MASK_XTILEDATA);
-}
-
 enum expected_result { FAIL_EXPECTED, SUCCESS_EXPECTED };
 
 /* arch_prctl() and sigaltstack() test */
@@ -489,99 +478,6 @@ static void test_fork(void)
 	_exit(0);
 }
 
-/* Ptrace test */
-
-/*
- * Make sure the ptracee has the expanded kernel buffer on the first
- * use. Then, initialize the state before performing the state
- * injection from the ptracer.
- */
-static inline void ptracee_firstuse_tiledata(void)
-{
-	load_rand_tiledata(stashed_xsave);
-	init_xtiledata();
-}
-
-/*
- * Ptracer injects the randomized tile data state. It also reads
- * before and after that, which will execute the kernel's state copy
- * functions. So, the tester is advised to double-check any emitted
- * kernel messages.
- */
-static void ptracer_inject_tiledata(pid_t target)
-{
-	struct xsave_buffer *xbuf;
-	struct iovec iov;
-
-	xbuf = alloc_xbuf();
-	if (!xbuf)
-		fatal_error("unable to allocate XSAVE buffer");
-
-	printf("\tRead the init'ed tiledata via ptrace().\n");
-
-	iov.iov_base = xbuf;
-	iov.iov_len = xbuf_size;
-
-	memset(stashed_xsave, 0, xbuf_size);
-
-	if (ptrace(PTRACE_GETREGSET, target, (uint32_t)NT_X86_XSTATE, &iov))
-		fatal_error("PTRACE_GETREGSET");
-
-	if (!__compare_tiledata_state(stashed_xsave, xbuf))
-		printf("[OK]\tThe init'ed tiledata was read from ptracee.\n");
-	else
-		printf("[FAIL]\tThe init'ed tiledata was not read from ptracee.\n");
-
-	printf("\tInject tiledata via ptrace().\n");
-
-	load_rand_tiledata(xbuf);
-
-	memcpy(&stashed_xsave->bytes[xtiledata.xbuf_offset],
-	       &xbuf->bytes[xtiledata.xbuf_offset],
-	       xtiledata.size);
-
-	if (ptrace(PTRACE_SETREGSET, target, (uint32_t)NT_X86_XSTATE, &iov))
-		fatal_error("PTRACE_SETREGSET");
-
-	if (ptrace(PTRACE_GETREGSET, target, (uint32_t)NT_X86_XSTATE, &iov))
-		fatal_error("PTRACE_GETREGSET");
-
-	if (!__compare_tiledata_state(stashed_xsave, xbuf))
-		printf("[OK]\tTiledata was correctly written to ptracee.\n");
-	else
-		printf("[FAIL]\tTiledata was not correctly written to ptracee.\n");
-}
-
-static void test_ptrace(void)
-{
-	pid_t child;
-	int status;
-
-	child = fork();
-	if (child < 0) {
-		err(1, "fork");
-	} else if (!child) {
-		if (ptrace(PTRACE_TRACEME, 0, NULL, NULL))
-			err(1, "PTRACE_TRACEME");
-
-		ptracee_firstuse_tiledata();
-
-		raise(SIGTRAP);
-		_exit(0);
-	}
-
-	do {
-		wait(&status);
-	} while (WSTOPSIG(status) != SIGTRAP);
-
-	ptracer_inject_tiledata(child);
-
-	ptrace(PTRACE_DETACH, child, NULL, NULL);
-	wait(&status);
-	if (!WIFEXITED(status) || WEXITSTATUS(status))
-		err(1, "ptrace test");
-}
-
 int main(void)
 {
 	const unsigned int ctxtsw_num_threads = 5, ctxtsw_iterations = 10;
@@ -594,8 +490,6 @@ int main(void)
 		return KSFT_SKIP;
 	}
 
-	xbuf_size = get_xbuf_size();
-
 	xtiledata = get_xstate_info(XFEATURE_XTILEDATA);
 	if (!xtiledata.size || !xtiledata.xbuf_offset) {
 		fatal_error("xstate cpuid: invalid tile data size/offset: %d/%d",
@@ -614,7 +508,7 @@ int main(void)
 
 	test_context_switch(XFEATURE_XTILEDATA, ctxtsw_num_threads, ctxtsw_iterations);
 
-	test_ptrace();
+	test_ptrace(XFEATURE_XTILEDATA);
 
 	clearhandler(SIGILL);
 	free_stashed_xsave();
diff --git a/tools/testing/selftests/x86/xstate.c b/tools/testing/selftests/x86/xstate.c
index e5b51e7..d318b35 100644
--- a/tools/testing/selftests/x86/xstate.c
+++ b/tools/testing/selftests/x86/xstate.c
@@ -2,12 +2,25 @@
 
 #define _GNU_SOURCE
 
+#include <elf.h>
 #include <pthread.h>
 #include <stdbool.h>
 
+#include <sys/ptrace.h>
+#include <sys/uio.h>
+#include <sys/wait.h>
+
 #include "helpers.h"
 #include "xstate.h"
 
+static inline uint64_t xgetbv(uint32_t index)
+{
+	uint32_t eax, edx;
+
+	asm volatile("xgetbv" : "=a" (eax), "=d" (edx) : "c" (index));
+	return eax + ((uint64_t)edx << 32);
+}
+
 static struct xstate_info xstate;
 
 struct futex_info {
@@ -27,6 +40,19 @@ static inline void load_rand_xstate(struct xstate_info *xstate, struct xsave_buf
 	xrstor(xbuf, xstate->mask);
 }
 
+static inline void load_init_xstate(struct xstate_info *xstate, struct xsave_buffer *xbuf)
+{
+	clear_xstate_header(xbuf);
+	xrstor(xbuf, xstate->mask);
+}
+
+static inline void copy_xstate(struct xsave_buffer *xbuf_dst, struct xsave_buffer *xbuf_src)
+{
+	memcpy(&xbuf_dst->bytes[xstate.xbuf_offset],
+	       &xbuf_src->bytes[xstate.xbuf_offset],
+	       xstate.size);
+}
+
 static inline bool validate_xstate_same(struct xsave_buffer *xbuf1, struct xsave_buffer *xbuf2)
 {
 	int ret;
@@ -196,3 +222,106 @@ void test_context_switch(uint32_t feature_num, uint32_t num_threads, uint32_t it
 
 	free(finfo);
 }
+
+/*
+ * Ptrace test for the ABI format as described in arch/x86/include/asm/user.h
+ */
+
+/*
+ * Make sure the ptracee has the expanded kernel buffer on the first use.
+ * Then, initialize the state before performing the state injection from
+ * the ptracer. For non-dynamic states, this is benign.
+ */
+static inline void ptracee_touch_xstate(void)
+{
+	struct xsave_buffer *xbuf;
+
+	xbuf = alloc_xbuf();
+
+	load_rand_xstate(&xstate, xbuf);
+	load_init_xstate(&xstate, xbuf);
+
+	free(xbuf);
+}
+
+/*
+ * Ptracer injects the randomized xstate data. It also reads before and
+ * after that, which will execute the kernel's state copy functions.
+ */
+static void ptracer_inject_xstate(pid_t target)
+{
+	uint32_t xbuf_size = get_xbuf_size();
+	struct xsave_buffer *xbuf1, *xbuf2;
+	struct iovec iov;
+
+	/*
+	 * Allocate buffers to keep data while ptracer can write the
+	 * other buffer
+	 */
+	xbuf1 = alloc_xbuf();
+	xbuf2 = alloc_xbuf();
+	if (!xbuf1 || !xbuf2)
+		ksft_exit_fail_msg("unable to allocate XSAVE buffer\n");
+
+	iov.iov_base = xbuf1;
+	iov.iov_len  = xbuf_size;
+
+	if (ptrace(PTRACE_GETREGSET, target, (uint32_t)NT_X86_XSTATE, &iov))
+		ksft_exit_fail_msg("PTRACE_GETREGSET failed\n");
+
+	printf("[RUN]\t%s: inject xstate via ptrace().\n", xstate.name);
+
+	load_rand_xstate(&xstate, xbuf1);
+	copy_xstate(xbuf2, xbuf1);
+
+	if (ptrace(PTRACE_SETREGSET, target, (uint32_t)NT_X86_XSTATE, &iov))
+		ksft_exit_fail_msg("PTRACE_SETREGSET failed\n");
+
+	if (ptrace(PTRACE_GETREGSET, target, (uint32_t)NT_X86_XSTATE, &iov))
+		ksft_exit_fail_msg("PTRACE_GETREGSET failed\n");
+
+	if (*(uint64_t *)get_fpx_sw_bytes(xbuf1) == xgetbv(0))
+		printf("[OK]\t'xfeatures' in SW reserved area was correctly written\n");
+	else
+		printf("[FAIL]\t'xfeatures' in SW reserved area was not correctly written\n");
+
+	if (validate_xstate_same(xbuf2, xbuf1))
+		printf("[OK]\txstate was correctly updated.\n");
+	else
+		printf("[FAIL]\txstate was not correctly updated.\n");
+
+	free(xbuf1);
+	free(xbuf2);
+}
+
+void test_ptrace(uint32_t feature_num)
+{
+	pid_t child;
+	int status;
+
+	xstate = get_xstate_info(feature_num);
+
+	child = fork();
+	if (child < 0) {
+		ksft_exit_fail_msg("fork() failed\n");
+	} else if (!child) {
+		if (ptrace(PTRACE_TRACEME, 0, NULL, NULL))
+			ksft_exit_fail_msg("PTRACE_TRACEME failed\n");
+
+		ptracee_touch_xstate();
+
+		raise(SIGTRAP);
+		_exit(0);
+	}
+
+	do {
+		wait(&status);
+	} while (WSTOPSIG(status) != SIGTRAP);
+
+	ptracer_inject_xstate(child);
+
+	ptrace(PTRACE_DETACH, child, NULL, NULL);
+	wait(&status);
+	if (!WIFEXITED(status) || WEXITSTATUS(status))
+		ksft_exit_fail_msg("ptracee exit error\n");
+}
diff --git a/tools/testing/selftests/x86/xstate.h b/tools/testing/selftests/x86/xstate.h
index 5ef66f2..2bf11d3 100644
--- a/tools/testing/selftests/x86/xstate.h
+++ b/tools/testing/selftests/x86/xstate.h
@@ -190,5 +190,6 @@ static inline void set_rand_data(struct xstate_info *xstate, struct xsave_buffer
 }
 
 void test_context_switch(uint32_t feature_num, uint32_t num_threads, uint32_t iterations);
+void test_ptrace(uint32_t feature_num);
 
 #endif /* __SELFTESTS_X86_XSTATE_H */

