Return-Path: <linux-tip-commits+bounces-3675-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CEF2A45EC8
	for <lists+linux-tip-commits@lfdr.de>; Wed, 26 Feb 2025 13:24:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2E53D18848ED
	for <lists+linux-tip-commits@lfdr.de>; Wed, 26 Feb 2025 12:20:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3193622A7E5;
	Wed, 26 Feb 2025 12:15:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="BwnxugIw";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="672bSY3z"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBFB2223311;
	Wed, 26 Feb 2025 12:15:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740572112; cv=none; b=N6K5gmr+VCKOetFi6HwoW0b9C10WRUdYrSeMz4X8kiL5wm/fWgh0rY5rM+RifrpDAkNAQGl473CwQ6HA/K6E/ftxqIVG7yKA3TcbrOWLZ14PeSG454IhxD6lycoP+ajvv/yOmwDIuOVPg17x7ZEl33LwtgBJwsw5DLaEtunTXlc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740572112; c=relaxed/simple;
	bh=kqj0iuVozlL2gR0XZUcXjCuXQcs7Wl11m2FUnyoc1MA=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=PMkw5+4ekUMI5L0OeyTMqnbrTS/CqVOCc5Hak+ZDocs6w2GaWfQ+QszOD27LYAmbq9GZb3xG5hRlF/UEQnNexqe9U4sRmWASOcFdbpH8qPpT20qGPNpKOp32hlom/Z5/7iZYCRIOJ1j9teZAU8Cmvi5zHNSyBB98oKkE61YG79w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=BwnxugIw; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=672bSY3z; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 26 Feb 2025 12:15:06 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1740572108;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Npf5gcDPFUu2TgZcA1Eb1QL7Ec63YVLG8BCSYkVYueQ=;
	b=BwnxugIwGCI7Eah5JQqooHi+4OY5mPOIgRnaTMjt4NB8Zz6RvOHTFfjKBhx2tnHXzj0Tln
	4tkzSl49KvcvZuRck4b/jOzpRfK8mHVR/xkwshe6WwyN05vgivjPeahkZ2VQUrKKnrQngk
	2Se/bpf1bt8zGuyfVBHW8NkBt/WLulVSGjnrbAapQSyrcoTRDo8XGexkO+E97apzd6AH/q
	+sYhPCUx6tqZqJSg750Vu5uBgvOTqVk/2MWNV/eylyYCpvIdSZoXQI/Kau+LBeg6o2Bri/
	t5vHFrhLKwquj1YiMTqQkogCAqIJmaEg5PmcgruZL1Bqtrmxc6BAf0iaQVFVIw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1740572108;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Npf5gcDPFUu2TgZcA1Eb1QL7Ec63YVLG8BCSYkVYueQ=;
	b=672bSY3zzQihEOKjMRbIaGB0dVKo7QpR0X95NY56zwFeZApaKu9zEdTeOMDFqWSb3LS26s
	gPjVPSQKr1v2JJBQ==
From: "tip-bot2 for Chang S. Bae" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/fpu] selftests/x86/xstate: Refactor context switching test
Cc: "Chang S. Bae" <chang.seok.bae@intel.com>, Ingo Molnar <mingo@kernel.org>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250226010731.2456-5-chang.seok.bae@intel.com>
References: <20250226010731.2456-5-chang.seok.bae@intel.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174057210678.10177.12394499663747386118.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/fpu branch of tip:

Commit-ID:     40f6852ef2bffcd6fb3634cf71e6fbc2d1d6b768
Gitweb:        https://git.kernel.org/tip/40f6852ef2bffcd6fb3634cf71e6fbc2d1d6b768
Author:        Chang S. Bae <chang.seok.bae@intel.com>
AuthorDate:    Tue, 25 Feb 2025 17:07:24 -08:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Wed, 26 Feb 2025 13:05:29 +01:00

selftests/x86/xstate: Refactor context switching test

The existing context switching and ptrace tests in amx.c are not specific
to dynamic states, making them reusable for general xstate testing.

As a first step, move the context switching test to xstate.c. Refactor
the test code to allow specifying which xstate component being tested.

To decouple the test from dynamic states, remove the permission request
code. In fact, The permission request inside the test wrapper was
redundant.

Additionally, replace fatal_error() with ksft_exit_fail_msg() for
consistency in error handling.

  Expected output:
  $ amx_64
  ...
  [RUN]   AMX Tile data: check context switches, 10 iterations, 5 threads.
  [OK]    No incorrect case was found.

Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/20250226010731.2456-5-chang.seok.bae@intel.com
---
 tools/testing/selftests/x86/Makefile |   2 +-
 tools/testing/selftests/x86/amx.c    | 166 +----------------------
 tools/testing/selftests/x86/xstate.c | 198 ++++++++++++++++++++++++++-
 tools/testing/selftests/x86/xstate.h |   2 +-
 4 files changed, 204 insertions(+), 164 deletions(-)
 create mode 100644 tools/testing/selftests/x86/xstate.c

diff --git a/tools/testing/selftests/x86/Makefile b/tools/testing/selftests/x86/Makefile
index d51249f..f15efdc 100644
--- a/tools/testing/selftests/x86/Makefile
+++ b/tools/testing/selftests/x86/Makefile
@@ -132,3 +132,5 @@ $(OUTPUT)/check_initial_reg_state_64: CFLAGS += -Wl,-ereal_start -static
 
 $(OUTPUT)/nx_stack_32: CFLAGS += -Wl,-z,noexecstack
 $(OUTPUT)/nx_stack_64: CFLAGS += -Wl,-z,noexecstack
+
+$(OUTPUT)/amx_64: EXTRA_FILES += xstate.c
diff --git a/tools/testing/selftests/x86/amx.c b/tools/testing/selftests/x86/amx.c
index cde22f3..b3c51dd 100644
--- a/tools/testing/selftests/x86/amx.c
+++ b/tools/testing/selftests/x86/amx.c
@@ -3,7 +3,6 @@
 #define _GNU_SOURCE
 #include <err.h>
 #include <errno.h>
-#include <pthread.h>
 #include <setjmp.h>
 #include <stdio.h>
 #include <string.h>
@@ -434,14 +433,6 @@ static inline bool __validate_tiledata_regs(struct xsave_buffer *xbuf1)
 	return true;
 }
 
-static inline void validate_tiledata_regs_same(struct xsave_buffer *xbuf)
-{
-	int ret = __validate_tiledata_regs(xbuf);
-
-	if (ret != 0)
-		fatal_error("TILEDATA registers changed");
-}
-
 static inline void validate_tiledata_regs_changed(struct xsave_buffer *xbuf)
 {
 	int ret = __validate_tiledata_regs(xbuf);
@@ -498,158 +489,6 @@ static void test_fork(void)
 	_exit(0);
 }
 
-/* Context switching test */
-
-static struct _ctxtswtest_cfg {
-	unsigned int iterations;
-	unsigned int num_threads;
-} ctxtswtest_config;
-
-struct futex_info {
-	pthread_t thread;
-	int nr;
-	pthread_mutex_t mutex;
-	struct futex_info *next;
-};
-
-static void *check_tiledata(void *info)
-{
-	struct futex_info *finfo = (struct futex_info *)info;
-	struct xsave_buffer *xbuf;
-	int i;
-
-	xbuf = alloc_xbuf();
-	if (!xbuf)
-		fatal_error("unable to allocate XSAVE buffer");
-
-	/*
-	 * Load random data into 'xbuf' and then restore
-	 * it to the tile registers themselves.
-	 */
-	load_rand_tiledata(xbuf);
-	for (i = 0; i < ctxtswtest_config.iterations; i++) {
-		pthread_mutex_lock(&finfo->mutex);
-
-		/*
-		 * Ensure the register values have not
-		 * diverged from those recorded in 'xbuf'.
-		 */
-		validate_tiledata_regs_same(xbuf);
-
-		/* Load new, random values into xbuf and registers */
-		load_rand_tiledata(xbuf);
-
-		/*
-		 * The last thread's last unlock will be for
-		 * thread 0's mutex.  However, thread 0 will
-		 * have already exited the loop and the mutex
-		 * will already be unlocked.
-		 *
-		 * Because this is not an ERRORCHECK mutex,
-		 * that inconsistency will be silently ignored.
-		 */
-		pthread_mutex_unlock(&finfo->next->mutex);
-	}
-
-	free(xbuf);
-	/*
-	 * Return this thread's finfo, which is
-	 * a unique value for this thread.
-	 */
-	return finfo;
-}
-
-static int create_threads(int num, struct futex_info *finfo)
-{
-	int i;
-
-	for (i = 0; i < num; i++) {
-		int next_nr;
-
-		finfo[i].nr = i;
-		/*
-		 * Thread 'i' will wait on this mutex to
-		 * be unlocked.  Lock it immediately after
-		 * initialization:
-		 */
-		pthread_mutex_init(&finfo[i].mutex, NULL);
-		pthread_mutex_lock(&finfo[i].mutex);
-
-		next_nr = (i + 1) % num;
-		finfo[i].next = &finfo[next_nr];
-
-		if (pthread_create(&finfo[i].thread, NULL, check_tiledata, &finfo[i]))
-			fatal_error("pthread_create()");
-	}
-	return 0;
-}
-
-static void affinitize_cpu0(void)
-{
-	cpu_set_t cpuset;
-
-	CPU_ZERO(&cpuset);
-	CPU_SET(0, &cpuset);
-
-	if (sched_setaffinity(0, sizeof(cpuset), &cpuset) != 0)
-		fatal_error("sched_setaffinity to CPU 0");
-}
-
-static void test_context_switch(void)
-{
-	struct futex_info *finfo;
-	int i;
-
-	/* Affinitize to one CPU to force context switches */
-	affinitize_cpu0();
-
-	req_xtiledata_perm();
-
-	printf("[RUN]\tCheck tiledata context switches, %d iterations, %d threads.\n",
-	       ctxtswtest_config.iterations,
-	       ctxtswtest_config.num_threads);
-
-
-	finfo = malloc(sizeof(*finfo) * ctxtswtest_config.num_threads);
-	if (!finfo)
-		fatal_error("malloc()");
-
-	create_threads(ctxtswtest_config.num_threads, finfo);
-
-	/*
-	 * This thread wakes up thread 0
-	 * Thread 0 will wake up 1
-	 * Thread 1 will wake up 2
-	 * ...
-	 * the last thread will wake up 0
-	 *
-	 * ... this will repeat for the configured
-	 * number of iterations.
-	 */
-	pthread_mutex_unlock(&finfo[0].mutex);
-
-	/* Wait for all the threads to finish: */
-	for (i = 0; i < ctxtswtest_config.num_threads; i++) {
-		void *thread_retval;
-		int rc;
-
-		rc = pthread_join(finfo[i].thread, &thread_retval);
-
-		if (rc)
-			fatal_error("pthread_join() failed for thread %d err: %d\n",
-					i, rc);
-
-		if (thread_retval != &finfo[i])
-			fatal_error("unexpected thread retval for thread %d: %p\n",
-					i, thread_retval);
-
-	}
-
-	printf("[OK]\tNo incorrect case was found.\n");
-
-	free(finfo);
-}
-
 /* Ptrace test */
 
 /*
@@ -745,6 +584,7 @@ static void test_ptrace(void)
 
 int main(void)
 {
+	const unsigned int ctxtsw_num_threads = 5, ctxtsw_iterations = 10;
 	unsigned long features;
 	long rc;
 
@@ -772,9 +612,7 @@ int main(void)
 
 	test_fork();
 
-	ctxtswtest_config.iterations = 10;
-	ctxtswtest_config.num_threads = 5;
-	test_context_switch();
+	test_context_switch(XFEATURE_XTILEDATA, ctxtsw_num_threads, ctxtsw_iterations);
 
 	test_ptrace();
 
diff --git a/tools/testing/selftests/x86/xstate.c b/tools/testing/selftests/x86/xstate.c
new file mode 100644
index 0000000..e5b51e7
--- /dev/null
+++ b/tools/testing/selftests/x86/xstate.c
@@ -0,0 +1,198 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#define _GNU_SOURCE
+
+#include <pthread.h>
+#include <stdbool.h>
+
+#include "helpers.h"
+#include "xstate.h"
+
+static struct xstate_info xstate;
+
+struct futex_info {
+	unsigned int iterations;
+	struct futex_info *next;
+	pthread_mutex_t mutex;
+	pthread_t thread;
+	bool valid;
+	int nr;
+};
+
+static inline void load_rand_xstate(struct xstate_info *xstate, struct xsave_buffer *xbuf)
+{
+	clear_xstate_header(xbuf);
+	set_xstatebv(xbuf, xstate->mask);
+	set_rand_data(xstate, xbuf);
+	xrstor(xbuf, xstate->mask);
+}
+
+static inline bool validate_xstate_same(struct xsave_buffer *xbuf1, struct xsave_buffer *xbuf2)
+{
+	int ret;
+
+	ret = memcmp(&xbuf1->bytes[xstate.xbuf_offset],
+		     &xbuf2->bytes[xstate.xbuf_offset],
+		     xstate.size);
+	return ret == 0;
+}
+
+static inline bool validate_xregs_same(struct xsave_buffer *xbuf1)
+{
+	struct xsave_buffer *xbuf2;
+	bool ret;
+
+	xbuf2 = alloc_xbuf();
+	if (!xbuf2)
+		ksft_exit_fail_msg("failed to allocate XSAVE buffer\n");
+
+	xsave(xbuf2, xstate.mask);
+	ret = validate_xstate_same(xbuf1, xbuf2);
+
+	free(xbuf2);
+	return ret;
+}
+
+/* Context switching test */
+
+static void *check_xstate(void *info)
+{
+	struct futex_info *finfo = (struct futex_info *)info;
+	struct xsave_buffer *xbuf;
+	int i;
+
+	xbuf = alloc_xbuf();
+	if (!xbuf)
+		ksft_exit_fail_msg("unable to allocate XSAVE buffer\n");
+
+	/*
+	 * Load random data into 'xbuf' and then restore it to the xstate
+	 * registers.
+	 */
+	load_rand_xstate(&xstate, xbuf);
+	finfo->valid = true;
+
+	for (i = 0; i < finfo->iterations; i++) {
+		pthread_mutex_lock(&finfo->mutex);
+
+		/*
+		 * Ensure the register values have not diverged from the
+		 * record. Then reload a new random value.  If it failed
+		 * ever before, skip it.
+		 */
+		if (finfo->valid) {
+			finfo->valid = validate_xregs_same(xbuf);
+			load_rand_xstate(&xstate, xbuf);
+		}
+
+		/*
+		 * The last thread's last unlock will be for thread 0's
+		 * mutex. However, thread 0 will have already exited the
+		 * loop and the mutex will already be unlocked.
+		 *
+		 * Because this is not an ERRORCHECK mutex, that
+		 * inconsistency will be silently ignored.
+		 */
+		pthread_mutex_unlock(&finfo->next->mutex);
+	}
+
+	free(xbuf);
+	return finfo;
+}
+
+static void create_threads(uint32_t num_threads, uint32_t iterations, struct futex_info *finfo)
+{
+	int i;
+
+	for (i = 0; i < num_threads; i++) {
+		int next_nr;
+
+		finfo[i].nr = i;
+		finfo[i].iterations = iterations;
+
+		/*
+		 * Thread 'i' will wait on this mutex to be unlocked.
+		 * Lock it immediately after initialization:
+		 */
+		pthread_mutex_init(&finfo[i].mutex, NULL);
+		pthread_mutex_lock(&finfo[i].mutex);
+
+		next_nr = (i + 1) % num_threads;
+		finfo[i].next = &finfo[next_nr];
+
+		if (pthread_create(&finfo[i].thread, NULL, check_xstate, &finfo[i]))
+			ksft_exit_fail_msg("pthread_create() failed\n");
+	}
+}
+
+static bool checkout_threads(uint32_t num_threads, struct futex_info *finfo)
+{
+	void *thread_retval;
+	bool valid = true;
+	int err, i;
+
+	for (i = 0; i < num_threads; i++) {
+		err = pthread_join(finfo[i].thread, &thread_retval);
+		if (err)
+			ksft_exit_fail_msg("pthread_join() failed for thread %d err: %d\n", i, err);
+
+		if (thread_retval != &finfo[i]) {
+			ksft_exit_fail_msg("unexpected thread retval for thread %d: %p\n",
+					   i, thread_retval);
+		}
+
+		valid &= finfo[i].valid;
+	}
+
+	return valid;
+}
+
+static void affinitize_cpu0(void)
+{
+	cpu_set_t cpuset;
+
+	CPU_ZERO(&cpuset);
+	CPU_SET(0, &cpuset);
+
+	if (sched_setaffinity(0, sizeof(cpuset), &cpuset) != 0)
+		ksft_exit_fail_msg("sched_setaffinity to CPU 0 failed\n");
+}
+
+void test_context_switch(uint32_t feature_num, uint32_t num_threads, uint32_t iterations)
+{
+	struct futex_info *finfo;
+
+	/* Affinitize to one CPU to force context switches */
+	affinitize_cpu0();
+
+	xstate = get_xstate_info(feature_num);
+
+	printf("[RUN]\t%s: check context switches, %d iterations, %d threads.\n",
+	       xstate.name, iterations, num_threads);
+
+	finfo = malloc(sizeof(*finfo) * num_threads);
+	if (!finfo)
+		ksft_exit_fail_msg("unable allocate memory\n");
+
+	create_threads(num_threads, iterations, finfo);
+
+	/*
+	 * This thread wakes up thread 0
+	 * Thread 0 will wake up 1
+	 * Thread 1 will wake up 2
+	 * ...
+	 * The last thread will wake up 0
+	 *
+	 * This will repeat for the configured
+	 * number of iterations.
+	 */
+	pthread_mutex_unlock(&finfo[0].mutex);
+
+	/* Wait for all the threads to finish: */
+	if (checkout_threads(num_threads, finfo))
+		printf("[OK]\tNo incorrect case was found.\n");
+	else
+		printf("[FAIL]\tFailed with context switching test.\n");
+
+	free(finfo);
+}
diff --git a/tools/testing/selftests/x86/xstate.h b/tools/testing/selftests/x86/xstate.h
index d3461c4..5ef66f2 100644
--- a/tools/testing/selftests/x86/xstate.h
+++ b/tools/testing/selftests/x86/xstate.h
@@ -189,4 +189,6 @@ static inline void set_rand_data(struct xstate_info *xstate, struct xsave_buffer
 		*ptr = data;
 }
 
+void test_context_switch(uint32_t feature_num, uint32_t num_threads, uint32_t iterations);
+
 #endif /* __SELFTESTS_X86_XSTATE_H */

