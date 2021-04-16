Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 46630362353
	for <lists+linux-tip-commits@lfdr.de>; Fri, 16 Apr 2021 17:04:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245408AbhDPPCS (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 16 Apr 2021 11:02:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245198AbhDPPCQ (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 16 Apr 2021 11:02:16 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54404C061574;
        Fri, 16 Apr 2021 08:01:51 -0700 (PDT)
Date:   Fri, 16 Apr 2021 15:01:49 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1618585309;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0qaOt9ua7swaxmJ2q1ypE0rpJziCGDBwNsqTbpnvXjs=;
        b=GoqxzU7Jr37x2oWz/ORRvDky1MI/I7R32ohMKoBdKLM2HXaFbWokeXzV+C8Rk8gp5F3ygR
        4A1pBKndhLh8zsAKUlypBxh7W7awKhvMv45Ms/66eoZWIgX2Ao8mgpWTubi6rrNBjs65bN
        JMLwJ9GaAbWFr2w9VcnE/P3SIkxG13tnHM2ubxZ9fibohBHKSL3JG4E/WjJJe5DjnC9+I3
        ep6/zyqwfPDIpNNUs6XhbdZ+DNocvL8d06WLYbcl5soF/XoxEsjiLimkSlO1C80SE0dZcY
        7jqXw7lUTuKjSblJVAhz+dQvcxjqm3eAX9gszAA4r4cQnJNJiMd07KcSjIUo1Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1618585309;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0qaOt9ua7swaxmJ2q1ypE0rpJziCGDBwNsqTbpnvXjs=;
        b=+q1TBh6fcJIeGZ8Q1akHQ+maNkdI6Vllb+1gcpPI6ezQ64hW4/aNN5e6P9aHKikw9bKlSV
        yHbq8rF/b7fIRsCA==
From:   "tip-bot2 for Marco Elver" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] selftests/perf_events: Add kselftest for remove_on_exec
Cc:     Marco Elver <elver@google.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210408103605.1676875-9-elver@google.com>
References: <20210408103605.1676875-9-elver@google.com>
MIME-Version: 1.0
Message-ID: <161858530919.29796.4977531252308363092.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     6216798bf98e82c382922f1b71ecc4a13d6e65cb
Gitweb:        https://git.kernel.org/tip/6216798bf98e82c382922f1b71ecc4a13d6e65cb
Author:        Marco Elver <elver@google.com>
AuthorDate:    Thu, 08 Apr 2021 12:36:03 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 16 Apr 2021 16:32:42 +02:00

selftests/perf_events: Add kselftest for remove_on_exec

Add kselftest to test that remove_on_exec removes inherited events from
child tasks.

Signed-off-by: Marco Elver <elver@google.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20210408103605.1676875-9-elver@google.com
---
 tools/testing/selftests/perf_events/.gitignore       |   1 +-
 tools/testing/selftests/perf_events/Makefile         |   2 +-
 tools/testing/selftests/perf_events/remove_on_exec.c | 260 ++++++++++-
 3 files changed, 262 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/perf_events/remove_on_exec.c

diff --git a/tools/testing/selftests/perf_events/.gitignore b/tools/testing/selftests/perf_events/.gitignore
index 4dc43e1..790c470 100644
--- a/tools/testing/selftests/perf_events/.gitignore
+++ b/tools/testing/selftests/perf_events/.gitignore
@@ -1,2 +1,3 @@
 # SPDX-License-Identifier: GPL-2.0-only
 sigtrap_threads
+remove_on_exec
diff --git a/tools/testing/selftests/perf_events/Makefile b/tools/testing/selftests/perf_events/Makefile
index 973a2c3..fcafa5f 100644
--- a/tools/testing/selftests/perf_events/Makefile
+++ b/tools/testing/selftests/perf_events/Makefile
@@ -2,5 +2,5 @@
 CFLAGS += -Wl,-no-as-needed -Wall -I../../../../usr/include
 LDFLAGS += -lpthread
 
-TEST_GEN_PROGS := sigtrap_threads
+TEST_GEN_PROGS := sigtrap_threads remove_on_exec
 include ../lib.mk
diff --git a/tools/testing/selftests/perf_events/remove_on_exec.c b/tools/testing/selftests/perf_events/remove_on_exec.c
new file mode 100644
index 0000000..5814611
--- /dev/null
+++ b/tools/testing/selftests/perf_events/remove_on_exec.c
@@ -0,0 +1,260 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Test for remove_on_exec.
+ *
+ * Copyright (C) 2021, Google LLC.
+ */
+
+#define _GNU_SOURCE
+
+/* We need the latest siginfo from the kernel repo. */
+#include <sys/types.h>
+#include <asm/siginfo.h>
+#define __have_siginfo_t 1
+#define __have_sigval_t 1
+#define __have_sigevent_t 1
+#define __siginfo_t_defined
+#define __sigval_t_defined
+#define __sigevent_t_defined
+#define _BITS_SIGINFO_CONSTS_H 1
+#define _BITS_SIGEVENT_CONSTS_H 1
+
+#include <stdbool.h>
+#include <stddef.h>
+#include <stdint.h>
+#include <stdio.h>
+#include <linux/perf_event.h>
+#include <pthread.h>
+#include <signal.h>
+#include <sys/ioctl.h>
+#include <sys/syscall.h>
+#include <unistd.h>
+
+#include "../kselftest_harness.h"
+
+static volatile int signal_count;
+
+static struct perf_event_attr make_event_attr(void)
+{
+	struct perf_event_attr attr = {
+		.type		= PERF_TYPE_HARDWARE,
+		.size		= sizeof(attr),
+		.config		= PERF_COUNT_HW_INSTRUCTIONS,
+		.sample_period	= 1000,
+		.exclude_kernel = 1,
+		.exclude_hv	= 1,
+		.disabled	= 1,
+		.inherit	= 1,
+		/*
+		 * Children normally retain their inherited event on exec; with
+		 * remove_on_exec, we'll remove their event, but the parent and
+		 * any other non-exec'd children will keep their events.
+		 */
+		.remove_on_exec = 1,
+		.sigtrap	= 1,
+	};
+	return attr;
+}
+
+static void sigtrap_handler(int signum, siginfo_t *info, void *ucontext)
+{
+	if (info->si_code != TRAP_PERF) {
+		fprintf(stderr, "%s: unexpected si_code %d\n", __func__, info->si_code);
+		return;
+	}
+
+	signal_count++;
+}
+
+FIXTURE(remove_on_exec)
+{
+	struct sigaction oldact;
+	int fd;
+};
+
+FIXTURE_SETUP(remove_on_exec)
+{
+	struct perf_event_attr attr = make_event_attr();
+	struct sigaction action = {};
+
+	signal_count = 0;
+
+	/* Initialize sigtrap handler. */
+	action.sa_flags = SA_SIGINFO | SA_NODEFER;
+	action.sa_sigaction = sigtrap_handler;
+	sigemptyset(&action.sa_mask);
+	ASSERT_EQ(sigaction(SIGTRAP, &action, &self->oldact), 0);
+
+	/* Initialize perf event. */
+	self->fd = syscall(__NR_perf_event_open, &attr, 0, -1, -1, PERF_FLAG_FD_CLOEXEC);
+	ASSERT_NE(self->fd, -1);
+}
+
+FIXTURE_TEARDOWN(remove_on_exec)
+{
+	close(self->fd);
+	sigaction(SIGTRAP, &self->oldact, NULL);
+}
+
+/* Verify event propagates to fork'd child. */
+TEST_F(remove_on_exec, fork_only)
+{
+	int status;
+	pid_t pid = fork();
+
+	if (pid == 0) {
+		ASSERT_EQ(signal_count, 0);
+		ASSERT_EQ(ioctl(self->fd, PERF_EVENT_IOC_ENABLE, 0), 0);
+		while (!signal_count);
+		_exit(42);
+	}
+
+	while (!signal_count); /* Child enables event. */
+	EXPECT_EQ(waitpid(pid, &status, 0), pid);
+	EXPECT_EQ(WEXITSTATUS(status), 42);
+}
+
+/*
+ * Verify that event does _not_ propagate to fork+exec'd child; event enabled
+ * after fork+exec.
+ */
+TEST_F(remove_on_exec, fork_exec_then_enable)
+{
+	pid_t pid_exec, pid_only_fork;
+	int pipefd[2];
+	int tmp;
+
+	/*
+	 * Non-exec child, to ensure exec does not affect inherited events of
+	 * other children.
+	 */
+	pid_only_fork = fork();
+	if (pid_only_fork == 0) {
+		/* Block until parent enables event. */
+		while (!signal_count);
+		_exit(42);
+	}
+
+	ASSERT_NE(pipe(pipefd), -1);
+	pid_exec = fork();
+	if (pid_exec == 0) {
+		ASSERT_NE(dup2(pipefd[1], STDOUT_FILENO), -1);
+		close(pipefd[0]);
+		execl("/proc/self/exe", "exec_child", NULL);
+		_exit((perror("exec failed"), 1));
+	}
+	close(pipefd[1]);
+
+	ASSERT_EQ(waitpid(pid_exec, &tmp, WNOHANG), 0); /* Child is running. */
+	/* Wait for exec'd child to start spinning. */
+	EXPECT_EQ(read(pipefd[0], &tmp, sizeof(int)), sizeof(int));
+	EXPECT_EQ(tmp, 42);
+	close(pipefd[0]);
+	/* Now we can enable the event, knowing the child is doing work. */
+	EXPECT_EQ(ioctl(self->fd, PERF_EVENT_IOC_ENABLE, 0), 0);
+	/* If the event propagated to the exec'd child, it will exit normally... */
+	usleep(100000); /* ... give time for event to trigger (in case of bug). */
+	EXPECT_EQ(waitpid(pid_exec, &tmp, WNOHANG), 0); /* Should still be running. */
+	EXPECT_EQ(kill(pid_exec, SIGKILL), 0);
+
+	/* Verify removal from child did not affect this task's event. */
+	tmp = signal_count;
+	while (signal_count == tmp); /* Should not hang! */
+	/* Nor should it have affected the first child. */
+	EXPECT_EQ(waitpid(pid_only_fork, &tmp, 0), pid_only_fork);
+	EXPECT_EQ(WEXITSTATUS(tmp), 42);
+}
+
+/*
+ * Verify that event does _not_ propagate to fork+exec'd child; event enabled
+ * before fork+exec.
+ */
+TEST_F(remove_on_exec, enable_then_fork_exec)
+{
+	pid_t pid_exec;
+	int tmp;
+
+	EXPECT_EQ(ioctl(self->fd, PERF_EVENT_IOC_ENABLE, 0), 0);
+
+	pid_exec = fork();
+	if (pid_exec == 0) {
+		execl("/proc/self/exe", "exec_child", NULL);
+		_exit((perror("exec failed"), 1));
+	}
+
+	/*
+	 * The child may exit abnormally at any time if the event propagated and
+	 * a SIGTRAP is sent before the handler was set up.
+	 */
+	usleep(100000); /* ... give time for event to trigger (in case of bug). */
+	EXPECT_EQ(waitpid(pid_exec, &tmp, WNOHANG), 0); /* Should still be running. */
+	EXPECT_EQ(kill(pid_exec, SIGKILL), 0);
+
+	/* Verify removal from child did not affect this task's event. */
+	tmp = signal_count;
+	while (signal_count == tmp); /* Should not hang! */
+}
+
+TEST_F(remove_on_exec, exec_stress)
+{
+	pid_t pids[30];
+	int i, tmp;
+
+	for (i = 0; i < sizeof(pids) / sizeof(pids[0]); i++) {
+		pids[i] = fork();
+		if (pids[i] == 0) {
+			execl("/proc/self/exe", "exec_child", NULL);
+			_exit((perror("exec failed"), 1));
+		}
+
+		/* Some forked with event disabled, rest with enabled. */
+		if (i > 10)
+			EXPECT_EQ(ioctl(self->fd, PERF_EVENT_IOC_ENABLE, 0), 0);
+	}
+
+	usleep(100000); /* ... give time for event to trigger (in case of bug). */
+
+	for (i = 0; i < sizeof(pids) / sizeof(pids[0]); i++) {
+		/* All children should still be running. */
+		EXPECT_EQ(waitpid(pids[i], &tmp, WNOHANG), 0);
+		EXPECT_EQ(kill(pids[i], SIGKILL), 0);
+	}
+
+	/* Verify event is still alive. */
+	tmp = signal_count;
+	while (signal_count == tmp);
+}
+
+/* For exec'd child. */
+static void exec_child(void)
+{
+	struct sigaction action = {};
+	const int val = 42;
+
+	/* Set up sigtrap handler in case we erroneously receive a trap. */
+	action.sa_flags = SA_SIGINFO | SA_NODEFER;
+	action.sa_sigaction = sigtrap_handler;
+	sigemptyset(&action.sa_mask);
+	if (sigaction(SIGTRAP, &action, NULL))
+		_exit((perror("sigaction failed"), 1));
+
+	/* Signal parent that we're starting to spin. */
+	if (write(STDOUT_FILENO, &val, sizeof(int)) == -1)
+		_exit((perror("write failed"), 1));
+
+	/* Should hang here until killed. */
+	while (!signal_count);
+}
+
+#define main test_main
+TEST_HARNESS_MAIN
+#undef main
+int main(int argc, char *argv[])
+{
+	if (!strcmp(argv[0], "exec_child")) {
+		exec_child();
+		return 1;
+	}
+
+	return test_main(argc, argv);
+}
