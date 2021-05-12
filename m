Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 92F0437BA55
	for <lists+linux-tip-commits@lfdr.de>; Wed, 12 May 2021 12:28:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230213AbhELK3c (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 12 May 2021 06:29:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230115AbhELK3b (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 12 May 2021 06:29:31 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38DC5C061574;
        Wed, 12 May 2021 03:28:22 -0700 (PDT)
Date:   Wed, 12 May 2021 10:28:20 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1620815301;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rQYh2niRCNEgdSv5uQFvvdRgkeUGImI1b3ptliuA/Mw=;
        b=VOTU0+tvQjZUQutM54leCf21KZaqUs1NrDInytJveAXLzP6qHTDfUCkYMAMICyD2DkWBNC
        HedE5Jr8fkWiw4yL8W2ocaMXYMC/1hTJDdM46sS4bwRv9FnLZ/PAO0F5XnbVc/RndUUrox
        set4cFcB/JmxX3ePBQsKlADm0yDvUaj0o/eRnSaRaX/cvgs21rCLaFkbbli7cSb+Ibzgbu
        bnWFEcjkI/KIo1YCOU6eK3B5pBtv9tv1bhXB9tVJA8vMr3EHZiUqoRiJq7NqhAU7xRPRWj
        sXkmz8LRmjVGE6UNH9z/jbJbLShylfBWF0YuboI4/DggfWKBmf5bfToSprMWQA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1620815301;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rQYh2niRCNEgdSv5uQFvvdRgkeUGImI1b3ptliuA/Mw=;
        b=ZS1GKlA0yRq/wEoy2dC2DiLfQ6hV9uWKC39bQM6Z3yiagkIaqwn06Ry2oz791hFruKh07P
        jk8OtBsXZgnPqwBg==
From:   "tip-bot2 for Chris Hyser" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] kselftest: Add test for core sched prctl interface
Cc:     Chris Hyser <chris.hyser@oracle.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Don Hiatt <dhiatt@digitalocean.com>,
        Hongyu Ning <hongyu.ning@linux.intel.com>,
        Vincent Guittot <vincent.guittot@linaro.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210422123309.100860030@infradead.org>
References: <20210422123309.100860030@infradead.org>
MIME-Version: 1.0
Message-ID: <162081530038.29796.8660324173928745497.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     9f26990074931bbf797373e53104216059b300b1
Gitweb:        https://git.kernel.org/tip/9f26990074931bbf797373e53104216059b300b1
Author:        Chris Hyser <chris.hyser@oracle.com>
AuthorDate:    Wed, 24 Mar 2021 17:40:16 -04:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 12 May 2021 11:43:32 +02:00

kselftest: Add test for core sched prctl interface

Provides a selftest and examples of using the interface.

[peterz: updated to not use sched_debug]
Signed-off-by: Chris Hyser <chris.hyser@oracle.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Tested-by: Don Hiatt <dhiatt@digitalocean.com>
Tested-by: Hongyu Ning <hongyu.ning@linux.intel.com>
Tested-by: Vincent Guittot <vincent.guittot@linaro.org>
Link: https://lkml.kernel.org/r/20210422123309.100860030@infradead.org
---
 tools/testing/selftests/sched/.gitignore      |   1 +-
 tools/testing/selftests/sched/Makefile        |  14 +-
 tools/testing/selftests/sched/config          |   1 +-
 tools/testing/selftests/sched/cs_prctl_test.c | 338 +++++++++++++++++-
 4 files changed, 354 insertions(+)
 create mode 100644 tools/testing/selftests/sched/.gitignore
 create mode 100644 tools/testing/selftests/sched/Makefile
 create mode 100644 tools/testing/selftests/sched/config
 create mode 100644 tools/testing/selftests/sched/cs_prctl_test.c

diff --git a/tools/testing/selftests/sched/.gitignore b/tools/testing/selftests/sched/.gitignore
new file mode 100644
index 0000000..6996d46
--- /dev/null
+++ b/tools/testing/selftests/sched/.gitignore
@@ -0,0 +1 @@
+cs_prctl_test
diff --git a/tools/testing/selftests/sched/Makefile b/tools/testing/selftests/sched/Makefile
new file mode 100644
index 0000000..10c72f1
--- /dev/null
+++ b/tools/testing/selftests/sched/Makefile
@@ -0,0 +1,14 @@
+# SPDX-License-Identifier: GPL-2.0+
+
+ifneq ($(shell $(CC) --version 2>&1 | head -n 1 | grep clang),)
+CLANG_FLAGS += -no-integrated-as
+endif
+
+CFLAGS += -O2 -Wall -g -I./ -I../../../../usr/include/  -Wl,-rpath=./ \
+	  $(CLANG_FLAGS)
+LDLIBS += -lpthread
+
+TEST_GEN_FILES := cs_prctl_test
+TEST_PROGS := cs_prctl_test
+
+include ../lib.mk
diff --git a/tools/testing/selftests/sched/config b/tools/testing/selftests/sched/config
new file mode 100644
index 0000000..e8b09aa
--- /dev/null
+++ b/tools/testing/selftests/sched/config
@@ -0,0 +1 @@
+CONFIG_SCHED_DEBUG=y
diff --git a/tools/testing/selftests/sched/cs_prctl_test.c b/tools/testing/selftests/sched/cs_prctl_test.c
new file mode 100644
index 0000000..63fe652
--- /dev/null
+++ b/tools/testing/selftests/sched/cs_prctl_test.c
@@ -0,0 +1,338 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Use the core scheduling prctl() to test core scheduling cookies control.
+ *
+ * Copyright (c) 2021 Oracle and/or its affiliates.
+ * Author: Chris Hyser <chris.hyser@oracle.com>
+ *
+ *
+ * This library is free software; you can redistribute it and/or modify it
+ * under the terms of version 2.1 of the GNU Lesser General Public License as
+ * published by the Free Software Foundation.
+ *
+ * This library is distributed in the hope that it will be useful, but WITHOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU Lesser General Public License
+ * for more details.
+ *
+ * You should have received a copy of the GNU Lesser General Public License
+ * along with this library; if not, see <http://www.gnu.org/licenses>.
+ */
+
+#define _GNU_SOURCE
+#include <sys/eventfd.h>
+#include <sys/wait.h>
+#include <sys/types.h>
+#include <sched.h>
+#include <sys/prctl.h>
+#include <sys/types.h>
+#include <sys/wait.h>
+#include <unistd.h>
+#include <time.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+
+#if __GLIBC_PREREQ(2, 30) == 0
+#include <sys/syscall.h>
+static pid_t gettid(void)
+{
+	return syscall(SYS_gettid);
+}
+#endif
+
+#ifndef PR_SCHED_CORE
+#define PR_SCHED_CORE			62
+# define PR_SCHED_CORE_GET		0
+# define PR_SCHED_CORE_CREATE		1 /* create unique core_sched cookie */
+# define PR_SCHED_CORE_SHARE_TO		2 /* push core_sched cookie to pid */
+# define PR_SCHED_CORE_SHARE_FROM	3 /* pull core_sched cookie to pid */
+# define PR_SCHED_CORE_MAX		4
+#endif
+
+#define MAX_PROCESSES 128
+#define MAX_THREADS   128
+
+static const char USAGE[] = "cs_prctl_test [options]\n"
+"    options:\n"
+"	-P  : number of processes to create.\n"
+"	-T  : number of threads per process to create.\n"
+"	-d  : delay time to keep tasks alive.\n"
+"	-k  : keep tasks alive until keypress.\n";
+
+enum pid_type {PIDTYPE_PID = 0, PIDTYPE_TGID, PIDTYPE_PGID};
+
+const int THREAD_CLONE_FLAGS = CLONE_THREAD | CLONE_SIGHAND | CLONE_FS | CLONE_VM | CLONE_FILES;
+
+static int _prctl(int option, unsigned long arg2, unsigned long arg3, unsigned long arg4,
+		  unsigned long arg5)
+{
+	int res;
+
+	res = prctl(option, arg2, arg3, arg4, arg5);
+	printf("%d = prctl(%d, %ld, %ld, %ld, %lx)\n", res, option, (long)arg2, (long)arg3,
+	       (long)arg4, arg5);
+	return res;
+}
+
+#define STACK_SIZE (1024 * 1024)
+
+#define handle_error(msg) __handle_error(__FILE__, __LINE__, msg)
+static void __handle_error(char *fn, int ln, char *msg)
+{
+	printf("(%s:%d) - ", fn, ln);
+	perror(msg);
+	exit(EXIT_FAILURE);
+}
+
+static void handle_usage(int rc, char *msg)
+{
+	puts(USAGE);
+	puts(msg);
+	putchar('\n');
+	exit(rc);
+}
+
+static unsigned long get_cs_cookie(int pid)
+{
+	unsigned long long cookie;
+	int ret;
+
+	ret = prctl(PR_SCHED_CORE, PR_SCHED_CORE_GET, pid, PIDTYPE_PID,
+		    (unsigned long)&cookie);
+	if (ret) {
+		printf("Not a core sched system\n");
+		return -1UL;
+	}
+
+	return cookie;
+}
+
+struct child_args {
+	int num_threads;
+	int pfd[2];
+	int cpid;
+	int thr_tids[MAX_THREADS];
+};
+
+static int child_func_thread(void __attribute__((unused))*arg)
+{
+	while (1)
+		usleep(20000);
+	return 0;
+}
+
+static void create_threads(int num_threads, int thr_tids[])
+{
+	void *child_stack;
+	pid_t tid;
+	int i;
+
+	for (i = 0; i < num_threads; ++i) {
+		child_stack = malloc(STACK_SIZE);
+		if (!child_stack)
+			handle_error("child stack allocate");
+
+		tid = clone(child_func_thread, child_stack + STACK_SIZE, THREAD_CLONE_FLAGS, NULL);
+		if (tid == -1)
+			handle_error("clone thread");
+		thr_tids[i] = tid;
+	}
+}
+
+static int child_func_process(void *arg)
+{
+	struct child_args *ca = (struct child_args *)arg;
+
+	close(ca->pfd[0]);
+
+	create_threads(ca->num_threads, ca->thr_tids);
+
+	write(ca->pfd[1], &ca->thr_tids, sizeof(int) * ca->num_threads);
+	close(ca->pfd[1]);
+
+	while (1)
+		usleep(20000);
+	return 0;
+}
+
+static unsigned char child_func_process_stack[STACK_SIZE];
+
+void create_processes(int num_processes, int num_threads, struct child_args proc[])
+{
+	pid_t cpid;
+	int i;
+
+	for (i = 0; i < num_processes; ++i) {
+		proc[i].num_threads = num_threads;
+
+		if (pipe(proc[i].pfd) == -1)
+			handle_error("pipe() failed");
+
+		cpid = clone(child_func_process, child_func_process_stack + STACK_SIZE,
+			     SIGCHLD, &proc[i]);
+		proc[i].cpid = cpid;
+		close(proc[i].pfd[1]);
+	}
+
+	for (i = 0; i < num_processes; ++i) {
+		read(proc[i].pfd[0], &proc[i].thr_tids, sizeof(int) * proc[i].num_threads);
+		close(proc[i].pfd[0]);
+	}
+}
+
+void disp_processes(int num_processes, struct child_args proc[])
+{
+	int i, j;
+
+	printf("tid=%d, / tgid=%d / pgid=%d: %lx\n", gettid(), getpid(), getpgid(0),
+	       get_cs_cookie(getpid()));
+
+	for (i = 0; i < num_processes; ++i) {
+		printf("    tid=%d, / tgid=%d / pgid=%d: %lx\n", proc[i].cpid, proc[i].cpid,
+		       getpgid(proc[i].cpid), get_cs_cookie(proc[i].cpid));
+		for (j = 0; j < proc[i].num_threads; ++j) {
+			printf("        tid=%d, / tgid=%d / pgid=%d: %lx\n", proc[i].thr_tids[j],
+			       proc[i].cpid, getpgid(0), get_cs_cookie(proc[i].thr_tids[j]));
+		}
+	}
+	puts("\n");
+}
+
+static int errors;
+
+#define validate(v) _validate(__LINE__, v, #v)
+void _validate(int line, int val, char *msg)
+{
+	if (!val) {
+		++errors;
+		printf("(%d) FAILED: %s\n", line, msg);
+	} else {
+		printf("(%d) PASSED: %s\n", line, msg);
+	}
+}
+
+int main(int argc, char *argv[])
+{
+	struct child_args procs[MAX_PROCESSES];
+
+	int keypress = 0;
+	int num_processes = 2;
+	int num_threads = 3;
+	int delay = 0;
+	int res = 0;
+	int pidx;
+	int pid;
+	int opt;
+
+	while ((opt = getopt(argc, argv, ":hkT:P:d:")) != -1) {
+		switch (opt) {
+		case 'P':
+			num_processes = (int)strtol(optarg, NULL, 10);
+			break;
+		case 'T':
+			num_threads = (int)strtoul(optarg, NULL, 10);
+			break;
+		case 'd':
+			delay = (int)strtol(optarg, NULL, 10);
+			break;
+		case 'k':
+			keypress = 1;
+			break;
+		case 'h':
+			printf(USAGE);
+			exit(EXIT_SUCCESS);
+		default:
+			handle_usage(20, "unknown option");
+		}
+	}
+
+	if (num_processes < 1 || num_processes > MAX_PROCESSES)
+		handle_usage(1, "Bad processes value");
+
+	if (num_threads < 1 || num_threads > MAX_THREADS)
+		handle_usage(2, "Bad thread value");
+
+	if (keypress)
+		delay = -1;
+
+	srand(time(NULL));
+
+	/* put into separate process group */
+	if (setpgid(0, 0) != 0)
+		handle_error("process group");
+
+	printf("\n## Create a thread/process/process group hiearchy\n");
+	create_processes(num_processes, num_threads, procs);
+	disp_processes(num_processes, procs);
+	validate(get_cs_cookie(0) == 0);
+
+	printf("\n## Set a cookie on entire process group\n");
+	if (_prctl(PR_SCHED_CORE, PR_SCHED_CORE_CREATE, 0, PIDTYPE_PGID, 0) < 0)
+		handle_error("core_sched create failed -- PGID");
+	disp_processes(num_processes, procs);
+
+	validate(get_cs_cookie(0) != 0);
+
+	/* get a random process pid */
+	pidx = rand() % num_processes;
+	pid = procs[pidx].cpid;
+
+	validate(get_cs_cookie(0) == get_cs_cookie(pid));
+	validate(get_cs_cookie(0) == get_cs_cookie(procs[pidx].thr_tids[0]));
+
+	printf("\n## Set a new cookie on entire process/TGID [%d]\n", pid);
+	if (_prctl(PR_SCHED_CORE, PR_SCHED_CORE_CREATE, pid, PIDTYPE_TGID, 0) < 0)
+		handle_error("core_sched create failed -- TGID");
+	disp_processes(num_processes, procs);
+
+	validate(get_cs_cookie(0) != get_cs_cookie(pid));
+	validate(get_cs_cookie(pid) != 0);
+	validate(get_cs_cookie(pid) == get_cs_cookie(procs[pidx].thr_tids[0]));
+
+	printf("\n## Copy the cookie of current/PGID[%d], to pid [%d] as PIDTYPE_PID\n",
+	       getpid(), pid);
+	if (_prctl(PR_SCHED_CORE, PR_SCHED_CORE_SHARE_TO, pid, PIDTYPE_PID, 0) < 0)
+		handle_error("core_sched share to itself failed -- PID");
+	disp_processes(num_processes, procs);
+
+	validate(get_cs_cookie(0) == get_cs_cookie(pid));
+	validate(get_cs_cookie(pid) != 0);
+	validate(get_cs_cookie(pid) != get_cs_cookie(procs[pidx].thr_tids[0]));
+
+	printf("\n## Copy cookie from a thread [%d] to current/PGID [%d] as PIDTYPE_PID\n",
+	       procs[pidx].thr_tids[0], getpid());
+	if (_prctl(PR_SCHED_CORE, PR_SCHED_CORE_SHARE_FROM, procs[pidx].thr_tids[0],
+		   PIDTYPE_PID, 0) < 0)
+		handle_error("core_sched share from thread failed -- PID");
+	disp_processes(num_processes, procs);
+
+	validate(get_cs_cookie(0) == get_cs_cookie(procs[pidx].thr_tids[0]));
+	validate(get_cs_cookie(pid) != get_cs_cookie(procs[pidx].thr_tids[0]));
+
+	printf("\n## Copy cookie from current [%d] to current as pidtype PGID\n", getpid());
+	if (_prctl(PR_SCHED_CORE, PR_SCHED_CORE_SHARE_TO, 0, PIDTYPE_PGID, 0) < 0)
+		handle_error("core_sched share to self failed -- PGID");
+	disp_processes(num_processes, procs);
+
+	validate(get_cs_cookie(0) == get_cs_cookie(pid));
+	validate(get_cs_cookie(pid) != 0);
+	validate(get_cs_cookie(pid) == get_cs_cookie(procs[pidx].thr_tids[0]));
+
+	if (errors) {
+		printf("TESTS FAILED. errors: %d\n", errors);
+		res = 10;
+	} else {
+		printf("SUCCESS !!!\n");
+	}
+
+	if (keypress)
+		getchar();
+	else
+		sleep(delay);
+
+	for (pidx = 0; pidx < num_processes; ++pidx)
+		kill(procs[pidx].cpid, 15);
+
+	return res;
+}
