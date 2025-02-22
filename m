Return-Path: <linux-tip-commits+bounces-3604-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A458A408A3
	for <lists+linux-tip-commits@lfdr.de>; Sat, 22 Feb 2025 14:23:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 304A8189D790
	for <lists+linux-tip-commits@lfdr.de>; Sat, 22 Feb 2025 13:24:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FA8B20967F;
	Sat, 22 Feb 2025 13:23:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="qyNYiYH3";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="NUZlZPsn"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75E35205E15;
	Sat, 22 Feb 2025 13:23:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740230632; cv=none; b=koWDI82t6rdUWCwdzVJwip9y8cSuXZuyiYWsuN5QTugyS4Ov/4f6BxwIVDwsIzy/vR3HLnO/WoWnHL7GHWR1Q7ACC62yQ/LtIrbp/8/+0ER9t1C72v6CeaLSbiYA3hVXztt9rpNG5T2TPg4cANPaJGLArcJMgeoJxmySeB6I3lE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740230632; c=relaxed/simple;
	bh=z8hmmW1WsvVsfVGUM0Z9RzvXk905aRV3TfrTQdH7vz4=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=DNM8a8oHmEWkh0j+Z8wK8Pz75W2IoSG6RAfBsu7EtGM1yFy420rL6+TBHjQ0uZmcW5D5rd1uiGMdo52rezPBNUfF/Kw6PJnnVofjooDj4dhyd6NAanJpVi8/kqAiL6bWuE4ytZSKxUSke56/W+yTALyctq3CBbxml62IrUFm1GE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=qyNYiYH3; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=NUZlZPsn; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sat, 22 Feb 2025 13:23:44 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1740230627;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qwldEa3DAuJ9BYJwDsklI979bt436W7gNo4+VvmURsU=;
	b=qyNYiYH3MDV1zmivFalz7YADvsdhCkdBxpQ/pH4z5L7+bG1rKbq/XahmzMveoNyi5ni9lD
	YSAF9KAmXPoFt+xJ438ncab259nUFs1rNzPPe6zF90ZEUOgwofNo8BP7bFen1/ydL8TE26
	dCbVhJF0HsWvJbbG69yCRG5vLSiiQz378O7fxt54e0aNGSyk+cDTdLiL/BHFEMgX9p6LH2
	l6r9ckGDMPw+KNDn823Ib2a6kiu0cmZW5RG/ZRqWGuWgIUXPyLc3t+rhWHBL/112t8ILCf
	D04mFUd7fCRYHQQ5C/yX6P8oYqMeS04mTlysU+5hiY+UXPT+r+1bzTGRJr0tjA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1740230627;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qwldEa3DAuJ9BYJwDsklI979bt436W7gNo4+VvmURsU=;
	b=NUZlZPsn7Fof0NKEFAkasTgBWx1lll1EANfnmxHKYGLGyao4/BQcHjuhmwVPNJR9hMbjFQ
	QNJk4B38KIThEyCw==
From: "tip-bot2 for Michael Jeanson" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] selftests/rseq: Add rseq syscall errors test
Cc: Michael Jeanson <mjeanson@efficios.com>, Ingo Molnar <mingo@kernel.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Shuah Khan <skhan@linuxfoundation.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250121213402.1754762-1-mjeanson@efficios.com>
References: <20250121213402.1754762-1-mjeanson@efficios.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174023062439.10177.14868853294846144350.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     3c27b40830cad0917c92fecf0c9cb1ec41de17cc
Gitweb:        https://git.kernel.org/tip/3c27b40830cad0917c92fecf0c9cb1ec41de17cc
Author:        Michael Jeanson <mjeanson@efficios.com>
AuthorDate:    Tue, 21 Jan 2025 16:33:52 -05:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Sat, 22 Feb 2025 14:13:45 +01:00

selftests/rseq: Add rseq syscall errors test

This test adds coverage of expected errors during rseq registration and
unregistration, it disables glibc integration and will thus always
exercise the rseq syscall explictly.

Signed-off-by: Michael Jeanson <mjeanson@efficios.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Reviewed-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Shuah Khan <skhan@linuxfoundation.org>
Link: https://lore.kernel.org/r/20250121213402.1754762-1-mjeanson@efficios.com
---
 tools/testing/selftests/rseq/.gitignore                 |   1 +-
 tools/testing/selftests/rseq/Makefile                   |   9 +-
 tools/testing/selftests/rseq/rseq.c                     |   6 +-
 tools/testing/selftests/rseq/rseq.h                     |   5 +-
 tools/testing/selftests/rseq/run_syscall_errors_test.sh |   5 +-
 tools/testing/selftests/rseq/syscall_errors_test.c      | 124 +++++++-
 6 files changed, 145 insertions(+), 5 deletions(-)
 create mode 100755 tools/testing/selftests/rseq/run_syscall_errors_test.sh
 create mode 100644 tools/testing/selftests/rseq/syscall_errors_test.c

diff --git a/tools/testing/selftests/rseq/.gitignore b/tools/testing/selftests/rseq/.gitignore
index 16496de..0fda241 100644
--- a/tools/testing/selftests/rseq/.gitignore
+++ b/tools/testing/selftests/rseq/.gitignore
@@ -9,3 +9,4 @@ param_test_compare_twice
 param_test_mm_cid
 param_test_mm_cid_benchmark
 param_test_mm_cid_compare_twice
+syscall_errors_test
diff --git a/tools/testing/selftests/rseq/Makefile b/tools/testing/selftests/rseq/Makefile
index 5a3432f..0d0a5fa 100644
--- a/tools/testing/selftests/rseq/Makefile
+++ b/tools/testing/selftests/rseq/Makefile
@@ -16,11 +16,12 @@ OVERRIDE_TARGETS = 1
 
 TEST_GEN_PROGS = basic_test basic_percpu_ops_test basic_percpu_ops_mm_cid_test param_test \
 		param_test_benchmark param_test_compare_twice param_test_mm_cid \
-		param_test_mm_cid_benchmark param_test_mm_cid_compare_twice
+		param_test_mm_cid_benchmark param_test_mm_cid_compare_twice \
+		syscall_errors_test
 
 TEST_GEN_PROGS_EXTENDED = librseq.so
 
-TEST_PROGS = run_param_test.sh
+TEST_PROGS = run_param_test.sh run_syscall_errors_test.sh
 
 TEST_FILES := settings
 
@@ -54,3 +55,7 @@ $(OUTPUT)/param_test_mm_cid_benchmark: param_test.c $(TEST_GEN_PROGS_EXTENDED) \
 $(OUTPUT)/param_test_mm_cid_compare_twice: param_test.c $(TEST_GEN_PROGS_EXTENDED) \
 					rseq.h rseq-*.h
 	$(CC) $(CFLAGS) -DBUILDOPT_RSEQ_PERCPU_MM_CID -DRSEQ_COMPARE_TWICE $< $(LDLIBS) -lrseq -o $@
+
+$(OUTPUT)/syscall_errors_test: syscall_errors_test.c $(TEST_GEN_PROGS_EXTENDED) \
+					rseq.h rseq-*.h
+	$(CC) $(CFLAGS) $< $(LDLIBS) -lrseq -o $@
diff --git a/tools/testing/selftests/rseq/rseq.c b/tools/testing/selftests/rseq/rseq.c
index f615679..1e29db9 100644
--- a/tools/testing/selftests/rseq/rseq.c
+++ b/tools/testing/selftests/rseq/rseq.c
@@ -87,7 +87,7 @@ static int sys_getcpu(unsigned *cpu, unsigned *node)
 	return syscall(__NR_getcpu, cpu, node, NULL);
 }
 
-int rseq_available(void)
+bool rseq_available(void)
 {
 	int rc;
 
@@ -96,9 +96,9 @@ int rseq_available(void)
 		abort();
 	switch (errno) {
 	case ENOSYS:
-		return 0;
+		return false;
 	case EINVAL:
-		return 1;
+		return true;
 	default:
 		abort();
 	}
diff --git a/tools/testing/selftests/rseq/rseq.h b/tools/testing/selftests/rseq/rseq.h
index ba424ce..f51a5fd 100644
--- a/tools/testing/selftests/rseq/rseq.h
+++ b/tools/testing/selftests/rseq/rseq.h
@@ -160,6 +160,11 @@ int32_t rseq_fallback_current_cpu(void);
 int32_t rseq_fallback_current_node(void);
 
 /*
+ * Returns true if rseq is supported.
+ */
+bool rseq_available(void);
+
+/*
  * Values returned can be either the current CPU number, -1 (rseq is
  * uninitialized), or -2 (rseq initialization has failed).
  */
diff --git a/tools/testing/selftests/rseq/run_syscall_errors_test.sh b/tools/testing/selftests/rseq/run_syscall_errors_test.sh
new file mode 100755
index 0000000..9272246
--- /dev/null
+++ b/tools/testing/selftests/rseq/run_syscall_errors_test.sh
@@ -0,0 +1,5 @@
+#!/bin/bash
+# SPDX-License-Identifier: MIT
+# SPDX-FileCopyrightText: 2024 Michael Jeanson <mjeanson@efficios.com>
+
+GLIBC_TUNABLES="${GLIBC_TUNABLES:-}:glibc.pthread.rseq=0" ./syscall_errors_test
diff --git a/tools/testing/selftests/rseq/syscall_errors_test.c b/tools/testing/selftests/rseq/syscall_errors_test.c
new file mode 100644
index 0000000..a5d9e1f
--- /dev/null
+++ b/tools/testing/selftests/rseq/syscall_errors_test.c
@@ -0,0 +1,124 @@
+// SPDX-License-Identifier: MIT
+// SPDX-FileCopyrightText: 2024 Michael Jeanson <mjeanson@efficios.com>
+
+#ifndef _GNU_SOURCE
+#define _GNU_SOURCE
+#endif
+
+#include <assert.h>
+#include <stdint.h>
+#include <syscall.h>
+#include <string.h>
+#include <unistd.h>
+
+#include "rseq.h"
+
+static int sys_rseq(void *rseq_abi, uint32_t rseq_len,
+		    int flags, uint32_t sig)
+{
+	return syscall(__NR_rseq, rseq_abi, rseq_len, flags, sig);
+}
+
+/*
+ * Check the value of errno on some expected failures of the rseq syscall.
+ */
+
+int main(void)
+{
+	struct rseq_abi *global_rseq = rseq_get_abi();
+	int ret;
+	int errno_copy;
+
+	if (!rseq_available()) {
+		fprintf(stderr, "rseq syscall unavailable");
+		goto error;
+	}
+
+	/* The current thread is NOT registered. */
+
+	/* EINVAL */
+	errno = 0;
+	ret = sys_rseq(global_rseq, 32, -1, RSEQ_SIG);
+	errno_copy = errno;
+	fprintf(stderr, "Registration with invalid flag fails with errno set to EINVAL (ret = %d, errno = %s)\n", ret, strerrorname_np(errno_copy));
+	if (ret == 0 || errno_copy != EINVAL)
+		goto error;
+
+	errno = 0;
+	ret = sys_rseq((char *) global_rseq + 1, 32, 0, RSEQ_SIG);
+	errno_copy = errno;
+	fprintf(stderr, "Registration with unaligned rseq_abi fails with errno set to EINVAL (ret = %d, errno = %s)\n", ret, strerrorname_np(errno_copy));
+	if (ret == 0 || errno_copy != EINVAL)
+		goto error;
+
+	errno = 0;
+	ret = sys_rseq(global_rseq, 31, 0, RSEQ_SIG);
+	errno_copy = errno;
+	fprintf(stderr, "Registration with invalid size fails with errno set to EINVAL (ret = %d, errno = %s)\n", ret, strerrorname_np(errno_copy));
+	if (ret == 0 || errno_copy != EINVAL)
+		goto error;
+
+
+#if defined(__LP64__) && (!defined(__s390__) && !defined(__s390x__))
+	/*
+	 * We haven't found a reliable way to find an invalid address when
+	 * running a 32bit userspace on a 64bit kernel, so only run this test
+	 * on 64bit builds for the moment.
+	 *
+	 * Also exclude architectures that select
+	 * CONFIG_ALTERNATE_USER_ADDRESS_SPACE where the kernel and userspace
+	 * have their own address space and this failure can't happen.
+	 */
+
+	/* EFAULT */
+	errno = 0;
+	ret = sys_rseq((void *) -4096UL, 32, 0, RSEQ_SIG);
+	errno_copy = errno;
+	fprintf(stderr, "Registration with invalid address fails with errno set to EFAULT (ret = %d, errno = %s)\n", ret, strerrorname_np(errno_copy));
+	if (ret == 0 || errno_copy != EFAULT)
+		goto error;
+#endif
+
+	errno = 0;
+	ret = sys_rseq(global_rseq, 32, 0, RSEQ_SIG);
+	errno_copy = errno;
+	fprintf(stderr, "Registration succeeds for the current thread (ret = %d, errno = %s)\n", ret, strerrorname_np(errno_copy));
+	if (ret != 0 && errno != 0)
+		goto error;
+
+	/* The current thread is registered. */
+
+	/* EBUSY */
+	errno = 0;
+	ret = sys_rseq(global_rseq, 32, 0, RSEQ_SIG);
+	errno_copy = errno;
+	fprintf(stderr, "Double registration fails with errno set to EBUSY (ret = %d, errno = %s)\n", ret, strerrorname_np(errno_copy));
+	if (ret == 0 || errno_copy != EBUSY)
+		goto error;
+
+	/* EPERM */
+	errno = 0;
+	ret = sys_rseq(global_rseq, 32, RSEQ_ABI_FLAG_UNREGISTER, RSEQ_SIG + 1);
+	errno_copy = errno;
+	fprintf(stderr, "Unregistration with wrong RSEQ_SIG fails with errno to EPERM (ret = %d, errno = %s)\n", ret, strerrorname_np(errno_copy));
+	if (ret == 0 || errno_copy != EPERM)
+		goto error;
+
+	errno = 0;
+	ret = sys_rseq(global_rseq, 32, RSEQ_ABI_FLAG_UNREGISTER, RSEQ_SIG);
+	errno_copy = errno;
+	fprintf(stderr, "Unregistration succeeds for the current thread (ret = %d, errno = %s)\n", ret, strerrorname_np(errno_copy));
+	if (ret != 0)
+		goto error;
+
+	errno = 0;
+	ret = sys_rseq(global_rseq, 32, RSEQ_ABI_FLAG_UNREGISTER, RSEQ_SIG);
+	errno_copy = errno;
+	fprintf(stderr, "Double unregistration fails with errno set to EINVAL (ret = %d, errno = %s)\n", ret, strerrorname_np(errno_copy));
+	if (ret == 0 || errno_copy != EINVAL)
+		goto error;
+
+	return 0;
+error:
+	return -1;
+}

