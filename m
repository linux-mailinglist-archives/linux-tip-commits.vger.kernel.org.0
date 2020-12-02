Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BDA782CB91A
	for <lists+linux-tip-commits@lfdr.de>; Wed,  2 Dec 2020 10:41:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388290AbgLBJjZ (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 2 Dec 2020 04:39:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388260AbgLBJjL (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 2 Dec 2020 04:39:11 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3CECC0617A7;
        Wed,  2 Dec 2020 01:38:30 -0800 (PST)
Date:   Wed, 02 Dec 2020 09:38:27 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1606901908;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Tr38RRPtlF6EI4tnyHub84lXxP2Mpsr978lq2r6FJmI=;
        b=W7u9YgylNKBV7wh/h2Hy5k80hqqeBJq9Pnjlqf9vH19Z8eCpG8EImeo78Y6K9RFMGhT4La
        YGohwBBEGSTEW2V7P/abeubJosVCh2uVNgc///4OhbFzsZZQ2d4VUO99afVB9NHMgpzMaH
        9WjzUT17QiGG2R6uigCiBjEnwKFvmNYdYj4y1vcMg/YkbsIj/alfR2uZEjr12L/E7im3aO
        XBh7OSM320Qt8moWTBEaD4aporwNLfiNtTfByyKTj1kBMn3XlDvWXhPzcFLKDlT9xQ1LnJ
        NnE3O0k3uVrWKaTdnxzg3+uLlSLnjSWng9Jwi+M1kub7HSAhxu0zFwduud4vgA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1606901908;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Tr38RRPtlF6EI4tnyHub84lXxP2Mpsr978lq2r6FJmI=;
        b=vYFiMwMc4Il7YDiO3VD57E2nqBVPznGmBNaFqU+ySqZVmsDef8cuJ8xL1IsgDP2u2teByt
        BjtgNsqO8f9DkbBA==
From:   "tip-bot2 for Gabriel Krisman Bertazi" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/entry] selftests: Add kselftest for syscall user dispatch
Cc:     Gabriel Krisman Bertazi <krisman@collabora.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andy Lutomirski <luto@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20201127193238.821364-6-krisman@collabora.com>
References: <20201127193238.821364-6-krisman@collabora.com>
MIME-Version: 1.0
Message-ID: <160690190749.3364.8306519873252674881.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the core/entry branch of tip:

Commit-ID:     c33fb498e133d8d059ad779d621d6a64315ca746
Gitweb:        https://git.kernel.org/tip/c33fb498e133d8d059ad779d621d6a64315ca746
Author:        Gabriel Krisman Bertazi <krisman@collabora.com>
AuthorDate:    Fri, 27 Nov 2020 14:32:36 -05:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 02 Dec 2020 10:32:17 +01:00

selftests: Add kselftest for syscall user dispatch

Implement functionality tests for syscall user dispatch.  In order to
make the test portable, refrain from open coding syscall dispatchers and
calculating glibc memory ranges.

Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Andy Lutomirski <luto@kernel.org>
Acked-by: Kees Cook <keescook@chromium.org>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/r/20201127193238.821364-6-krisman@collabora.com


---
 tools/testing/selftests/Makefile                         |   1 +-
 tools/testing/selftests/syscall_user_dispatch/.gitignore |   3 +-
 tools/testing/selftests/syscall_user_dispatch/Makefile   |   9 +-
 tools/testing/selftests/syscall_user_dispatch/config     |   1 +-
 tools/testing/selftests/syscall_user_dispatch/sud_test.c | 310 +++++++-
 5 files changed, 324 insertions(+)
 create mode 100644 tools/testing/selftests/syscall_user_dispatch/.gitignore
 create mode 100644 tools/testing/selftests/syscall_user_dispatch/Makefile
 create mode 100644 tools/testing/selftests/syscall_user_dispatch/config
 create mode 100644 tools/testing/selftests/syscall_user_dispatch/sud_test.c

diff --git a/tools/testing/selftests/Makefile b/tools/testing/selftests/Makefile
index d9c2835..96d5682 100644
--- a/tools/testing/selftests/Makefile
+++ b/tools/testing/selftests/Makefile
@@ -56,6 +56,7 @@ TARGETS += sparc64
 TARGETS += splice
 TARGETS += static_keys
 TARGETS += sync
+TARGETS += syscall_user_dispatch
 TARGETS += sysctl
 TARGETS += tc-testing
 TARGETS += timens
diff --git a/tools/testing/selftests/syscall_user_dispatch/.gitignore b/tools/testing/selftests/syscall_user_dispatch/.gitignore
new file mode 100644
index 0000000..f539615
--- /dev/null
+++ b/tools/testing/selftests/syscall_user_dispatch/.gitignore
@@ -0,0 +1,3 @@
+# SPDX-License-Identifier: GPL-2.0-only
+sud_test
+sud_benchmark
diff --git a/tools/testing/selftests/syscall_user_dispatch/Makefile b/tools/testing/selftests/syscall_user_dispatch/Makefile
new file mode 100644
index 0000000..8e15fa4
--- /dev/null
+++ b/tools/testing/selftests/syscall_user_dispatch/Makefile
@@ -0,0 +1,9 @@
+# SPDX-License-Identifier: GPL-2.0
+top_srcdir = ../../../..
+INSTALL_HDR_PATH = $(top_srcdir)/usr
+LINUX_HDR_PATH = $(INSTALL_HDR_PATH)/include/
+
+CFLAGS += -Wall -I$(LINUX_HDR_PATH)
+
+TEST_GEN_PROGS := sud_test
+include ../lib.mk
diff --git a/tools/testing/selftests/syscall_user_dispatch/config b/tools/testing/selftests/syscall_user_dispatch/config
new file mode 100644
index 0000000..039e303
--- /dev/null
+++ b/tools/testing/selftests/syscall_user_dispatch/config
@@ -0,0 +1 @@
+CONFIG_GENERIC_ENTRY=y
diff --git a/tools/testing/selftests/syscall_user_dispatch/sud_test.c b/tools/testing/selftests/syscall_user_dispatch/sud_test.c
new file mode 100644
index 0000000..6498b05
--- /dev/null
+++ b/tools/testing/selftests/syscall_user_dispatch/sud_test.c
@@ -0,0 +1,310 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) 2020 Collabora Ltd.
+ *
+ * Test code for syscall user dispatch
+ */
+
+#define _GNU_SOURCE
+#include <sys/prctl.h>
+#include <sys/sysinfo.h>
+#include <sys/syscall.h>
+#include <signal.h>
+
+#include <asm/unistd.h>
+#include "../kselftest_harness.h"
+
+#ifndef PR_SET_SYSCALL_USER_DISPATCH
+# define PR_SET_SYSCALL_USER_DISPATCH	59
+# define PR_SYS_DISPATCH_OFF	0
+# define PR_SYS_DISPATCH_ON	1
+#endif
+
+#ifndef SYS_USER_DISPATCH
+# define SYS_USER_DISPATCH	2
+#endif
+
+#ifdef __NR_syscalls
+# define MAGIC_SYSCALL_1 (__NR_syscalls + 1) /* Bad Linux syscall number */
+#else
+# define MAGIC_SYSCALL_1 (0xff00)  /* Bad Linux syscall number */
+#endif
+
+#define SYSCALL_DISPATCH_ON(x) ((x) = 1)
+#define SYSCALL_DISPATCH_OFF(x) ((x) = 0)
+
+/* Test Summary:
+ *
+ * - dispatch_trigger_sigsys: Verify if PR_SET_SYSCALL_USER_DISPATCH is
+ *   able to trigger SIGSYS on a syscall.
+ *
+ * - bad_selector: Test that a bad selector value triggers SIGSYS with
+ *   si_errno EINVAL.
+ *
+ * - bad_prctl_param: Test that the API correctly rejects invalid
+ *   parameters on prctl
+ *
+ * - dispatch_and_return: Test that a syscall is selectively dispatched
+ *   to userspace depending on the value of selector.
+ *
+ * - disable_dispatch: Test that the PR_SYS_DISPATCH_OFF correctly
+ *   disables the dispatcher
+ *
+ * - direct_dispatch_range: Test that a syscall within the allowed range
+ *   can bypass the dispatcher.
+ */
+
+TEST_SIGNAL(dispatch_trigger_sigsys, SIGSYS)
+{
+	char sel = 0;
+	struct sysinfo info;
+	int ret;
+
+	ret = sysinfo(&info);
+	ASSERT_EQ(0, ret);
+
+	ret = prctl(PR_SET_SYSCALL_USER_DISPATCH, PR_SYS_DISPATCH_ON, 0, 0, &sel);
+	ASSERT_EQ(0, ret) {
+		TH_LOG("Kernel does not support CONFIG_SYSCALL_USER_DISPATCH");
+	}
+
+	SYSCALL_DISPATCH_ON(sel);
+
+	sysinfo(&info);
+
+	EXPECT_FALSE(true) {
+		TH_LOG("Unreachable!");
+	}
+}
+
+TEST(bad_prctl_param)
+{
+	char sel = 0;
+	int op;
+
+	/* Invalid op */
+	op = -1;
+	prctl(PR_SET_SYSCALL_USER_DISPATCH, op, 0, 0, &sel);
+	ASSERT_EQ(EINVAL, errno);
+
+	/* PR_SYS_DISPATCH_OFF */
+	op = PR_SYS_DISPATCH_OFF;
+
+	/* offset != 0 */
+	prctl(PR_SET_SYSCALL_USER_DISPATCH, op, 0x1, 0x0, 0);
+	EXPECT_EQ(EINVAL, errno);
+
+	/* len != 0 */
+	prctl(PR_SET_SYSCALL_USER_DISPATCH, op, 0x0, 0xff, 0);
+	EXPECT_EQ(EINVAL, errno);
+
+	/* sel != NULL */
+	prctl(PR_SET_SYSCALL_USER_DISPATCH, op, 0x0, 0x0, &sel);
+	EXPECT_EQ(EINVAL, errno);
+
+	/* Valid parameter */
+	errno = 0;
+	prctl(PR_SET_SYSCALL_USER_DISPATCH, op, 0x0, 0x0, 0x0);
+	EXPECT_EQ(0, errno);
+
+	/* PR_SYS_DISPATCH_ON */
+	op = PR_SYS_DISPATCH_ON;
+
+	/* Dispatcher region is bad (offset > 0 && len == 0) */
+	prctl(PR_SET_SYSCALL_USER_DISPATCH, op, 0x1, 0x0, &sel);
+	EXPECT_EQ(EINVAL, errno);
+	prctl(PR_SET_SYSCALL_USER_DISPATCH, op, -1L, 0x0, &sel);
+	EXPECT_EQ(EINVAL, errno);
+
+	/* Invalid selector */
+	prctl(PR_SET_SYSCALL_USER_DISPATCH, op, 0x0, 0x1, (void *) -1);
+	ASSERT_EQ(EFAULT, errno);
+
+	/*
+	 * Dispatcher range overflows unsigned long
+	 */
+	prctl(PR_SET_SYSCALL_USER_DISPATCH, PR_SYS_DISPATCH_ON, 1, -1L, &sel);
+	ASSERT_EQ(EINVAL, errno) {
+		TH_LOG("Should reject bad syscall range");
+	}
+
+	/*
+	 * Allowed range overflows usigned long
+	 */
+	prctl(PR_SET_SYSCALL_USER_DISPATCH, PR_SYS_DISPATCH_ON, -1L, 0x1, &sel);
+	ASSERT_EQ(EINVAL, errno) {
+		TH_LOG("Should reject bad syscall range");
+	}
+}
+
+/*
+ * Use global selector for handle_sigsys tests, to avoid passing
+ * selector to signal handler
+ */
+char glob_sel;
+int nr_syscalls_emulated;
+int si_code;
+int si_errno;
+
+static void handle_sigsys(int sig, siginfo_t *info, void *ucontext)
+{
+	si_code = info->si_code;
+	si_errno = info->si_errno;
+
+	if (info->si_syscall == MAGIC_SYSCALL_1)
+		nr_syscalls_emulated++;
+
+	/* In preparation for sigreturn. */
+	SYSCALL_DISPATCH_OFF(glob_sel);
+}
+
+TEST(dispatch_and_return)
+{
+	long ret;
+	struct sigaction act;
+	sigset_t mask;
+
+	glob_sel = 0;
+	nr_syscalls_emulated = 0;
+	si_code = 0;
+	si_errno = 0;
+
+	memset(&act, 0, sizeof(act));
+	sigemptyset(&mask);
+
+	act.sa_sigaction = handle_sigsys;
+	act.sa_flags = SA_SIGINFO;
+	act.sa_mask = mask;
+
+	ret = sigaction(SIGSYS, &act, NULL);
+	ASSERT_EQ(0, ret);
+
+	/* Make sure selector is good prior to prctl. */
+	SYSCALL_DISPATCH_OFF(glob_sel);
+
+	ret = prctl(PR_SET_SYSCALL_USER_DISPATCH, PR_SYS_DISPATCH_ON, 0, 0, &glob_sel);
+	ASSERT_EQ(0, ret) {
+		TH_LOG("Kernel does not support CONFIG_SYSCALL_USER_DISPATCH");
+	}
+
+	/* MAGIC_SYSCALL_1 doesn't exist. */
+	SYSCALL_DISPATCH_OFF(glob_sel);
+	ret = syscall(MAGIC_SYSCALL_1);
+	EXPECT_EQ(-1, ret) {
+		TH_LOG("Dispatch triggered unexpectedly");
+	}
+
+	/* MAGIC_SYSCALL_1 should be emulated. */
+	nr_syscalls_emulated = 0;
+	SYSCALL_DISPATCH_ON(glob_sel);
+
+	ret = syscall(MAGIC_SYSCALL_1);
+	EXPECT_EQ(MAGIC_SYSCALL_1, ret) {
+		TH_LOG("Failed to intercept syscall");
+	}
+	EXPECT_EQ(1, nr_syscalls_emulated) {
+		TH_LOG("Failed to emulate syscall");
+	}
+	ASSERT_EQ(SYS_USER_DISPATCH, si_code) {
+		TH_LOG("Bad si_code in SIGSYS");
+	}
+	ASSERT_EQ(0, si_errno) {
+		TH_LOG("Bad si_errno in SIGSYS");
+	}
+}
+
+TEST_SIGNAL(bad_selector, SIGSYS)
+{
+	long ret;
+	struct sigaction act;
+	sigset_t mask;
+	struct sysinfo info;
+
+	glob_sel = 0;
+	nr_syscalls_emulated = 0;
+	si_code = 0;
+	si_errno = 0;
+
+	memset(&act, 0, sizeof(act));
+	sigemptyset(&mask);
+
+	act.sa_sigaction = handle_sigsys;
+	act.sa_flags = SA_SIGINFO;
+	act.sa_mask = mask;
+
+	ret = sigaction(SIGSYS, &act, NULL);
+	ASSERT_EQ(0, ret);
+
+	/* Make sure selector is good prior to prctl. */
+	SYSCALL_DISPATCH_OFF(glob_sel);
+
+	ret = prctl(PR_SET_SYSCALL_USER_DISPATCH, PR_SYS_DISPATCH_ON, 0, 0, &glob_sel);
+	ASSERT_EQ(0, ret) {
+		TH_LOG("Kernel does not support CONFIG_SYSCALL_USER_DISPATCH");
+	}
+
+	glob_sel = -1;
+
+	sysinfo(&info);
+
+	/* Even though it is ready to catch SIGSYS, the signal is
+	 * supposed to be uncatchable.
+	 */
+
+	EXPECT_FALSE(true) {
+		TH_LOG("Unreachable!");
+	}
+}
+
+TEST(disable_dispatch)
+{
+	int ret;
+	struct sysinfo info;
+	char sel = 0;
+
+	ret = prctl(PR_SET_SYSCALL_USER_DISPATCH, PR_SYS_DISPATCH_ON, 0, 0, &sel);
+	ASSERT_EQ(0, ret) {
+		TH_LOG("Kernel does not support CONFIG_SYSCALL_USER_DISPATCH");
+	}
+
+	/* MAGIC_SYSCALL_1 doesn't exist. */
+	SYSCALL_DISPATCH_OFF(glob_sel);
+
+	ret = prctl(PR_SET_SYSCALL_USER_DISPATCH, PR_SYS_DISPATCH_OFF, 0, 0, 0);
+	EXPECT_EQ(0, ret) {
+		TH_LOG("Failed to unset syscall user dispatch");
+	}
+
+	/* Shouldn't have any effect... */
+	SYSCALL_DISPATCH_ON(glob_sel);
+
+	ret = syscall(__NR_sysinfo, &info);
+	EXPECT_EQ(0, ret) {
+		TH_LOG("Dispatch triggered unexpectedly");
+	}
+}
+
+TEST(direct_dispatch_range)
+{
+	int ret = 0;
+	struct sysinfo info;
+	char sel = 0;
+
+	/*
+	 * Instead of calculating libc addresses; allow the entire
+	 * memory map and lock the selector.
+	 */
+	ret = prctl(PR_SET_SYSCALL_USER_DISPATCH, PR_SYS_DISPATCH_ON, 0, -1L, &sel);
+	ASSERT_EQ(0, ret) {
+		TH_LOG("Kernel does not support CONFIG_SYSCALL_USER_DISPATCH");
+	}
+
+	SYSCALL_DISPATCH_ON(sel);
+
+	ret = sysinfo(&info);
+	ASSERT_EQ(0, ret) {
+		TH_LOG("Dispatch triggered unexpectedly");
+	}
+}
+
+TEST_HARNESS_MAIN
