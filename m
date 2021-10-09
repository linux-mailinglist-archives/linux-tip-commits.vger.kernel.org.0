Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 31D6C4278A9
	for <lists+linux-tip-commits@lfdr.de>; Sat,  9 Oct 2021 12:07:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244317AbhJIKJA (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Sat, 9 Oct 2021 06:09:00 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:49350 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232373AbhJIKJA (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Sat, 9 Oct 2021 06:09:00 -0400
Date:   Sat, 09 Oct 2021 10:07:01 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1633774022;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=j85004oBHyb8xmkDi2MSY2ehP0o/3ncukFR4OtoRLgU=;
        b=bosX8Nf/0jNj5qkKR6Ao57ePhWJDXM72dOP4qIrmNL9BZTWTsWlYxPU8CzaswERtYp77zq
        9+aLs0NGf3eRlWZbjgRj2BrG4RQLw+W/xLVSlA5ZbdxbD+1UmGQpnz6zsOsDKkjMqEb2kw
        1lHItORYShVjzNDFUL9y5d+AyhiWXdZ1wg49cdY82wNajA0ALMzgHDRcgZLVpxiX16gqlm
        Rfx+bjh72ZWWZuLFdWFiR756KVuvoK7au4TrlosnhVd8WSIuwgRq8k4PIRQPSlnJnBJXBJ
        T5LE3frHcDofi3+VrRnLTbgYaIhwX9ovq6kG9CxUGVLeuH5SLt0VJISAlTSadQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1633774022;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=j85004oBHyb8xmkDi2MSY2ehP0o/3ncukFR4OtoRLgU=;
        b=GLPJC1ZYjydZvah3x1c8lZVqQkbLfS7v6k0GUhLCCh8dMDyYs8KbeAofbgsT5WAISnL8jU
        ArHnAnxe1HHj+xCA==
From:   tip-bot2 for =?utf-8?q?Andr=C3=A9?= Almeida 
        <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] selftests: futex: Add sys_futex_waitv() test
Cc:     andrealmeid@collabora.com,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210923171111.300673-20-andrealmeid@collabora.com>
References: <20210923171111.300673-20-andrealmeid@collabora.com>
MIME-Version: 1.0
Message-ID: <163377402193.25758.18311707460294936545.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     5e59c1d1c78c9cdd8834f3242db4a76f617fa4ad
Gitweb:        https://git.kernel.org/tip/5e59c1d1c78c9cdd8834f3242db4a76f617=
fa4ad
Author:        Andr=C3=A9 Almeida <andrealmeid@collabora.com>
AuthorDate:    Thu, 23 Sep 2021 14:11:08 -03:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Thu, 07 Oct 2021 13:51:12 +02:00

selftests: futex: Add sys_futex_waitv() test

Create a new file to test the waitv mechanism. Test both private and
shared futexes. Wake the last futex in the array, and check if the
return value from futex_waitv() is the right index.

Signed-off-by: Andr=C3=A9 Almeida <andrealmeid@collabora.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/r/20210923171111.300673-20-andrealmeid@collabor=
a.com
---
 tools/testing/selftests/futex/functional/.gitignore    |   1 +-
 tools/testing/selftests/futex/functional/Makefile      |   3 +-
 tools/testing/selftests/futex/functional/futex_waitv.c | 237 ++++++++-
 tools/testing/selftests/futex/functional/run.sh        |   3 +-
 tools/testing/selftests/futex/include/futex2test.h     |  22 +-
 5 files changed, 265 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/futex/functional/futex_waitv.c
 create mode 100644 tools/testing/selftests/futex/include/futex2test.h

diff --git a/tools/testing/selftests/futex/functional/.gitignore b/tools/test=
ing/selftests/futex/functional/.gitignore
index 0e78b49..fbcbdb6 100644
--- a/tools/testing/selftests/futex/functional/.gitignore
+++ b/tools/testing/selftests/futex/functional/.gitignore
@@ -8,3 +8,4 @@ futex_wait_uninitialized_heap
 futex_wait_wouldblock
 futex_wait
 futex_requeue
+futex_waitv
diff --git a/tools/testing/selftests/futex/functional/Makefile b/tools/testin=
g/selftests/futex/functional/Makefile
index bd1fec5..5cc38de 100644
--- a/tools/testing/selftests/futex/functional/Makefile
+++ b/tools/testing/selftests/futex/functional/Makefile
@@ -17,7 +17,8 @@ TEST_GEN_FILES :=3D \
 	futex_wait_uninitialized_heap \
 	futex_wait_private_mapped_file \
 	futex_wait \
-	futex_requeue
+	futex_requeue \
+	futex_waitv
=20
 TEST_PROGS :=3D run.sh
=20
diff --git a/tools/testing/selftests/futex/functional/futex_waitv.c b/tools/t=
esting/selftests/futex/functional/futex_waitv.c
new file mode 100644
index 0000000..a94337f
--- /dev/null
+++ b/tools/testing/selftests/futex/functional/futex_waitv.c
@@ -0,0 +1,237 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * futex_waitv() test by Andr=C3=A9 Almeida <andrealmeid@collabora.com>
+ *
+ * Copyright 2021 Collabora Ltd.
+ */
+
+#include <errno.h>
+#include <error.h>
+#include <getopt.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <time.h>
+#include <pthread.h>
+#include <stdint.h>
+#include <sys/shm.h>
+#include "futextest.h"
+#include "futex2test.h"
+#include "logging.h"
+
+#define TEST_NAME "futex-wait"
+#define WAKE_WAIT_US 10000
+#define NR_FUTEXES 30
+static struct futex_waitv waitv[NR_FUTEXES];
+u_int32_t futexes[NR_FUTEXES] =3D {0};
+
+void usage(char *prog)
+{
+	printf("Usage: %s\n", prog);
+	printf("  -c	Use color\n");
+	printf("  -h	Display this help message\n");
+	printf("  -v L	Verbosity level: %d=3DQUIET %d=3DCRITICAL %d=3DINFO\n",
+	       VQUIET, VCRITICAL, VINFO);
+}
+
+void *waiterfn(void *arg)
+{
+	struct timespec to;
+	int res;
+
+	/* setting absolute timeout for futex2 */
+	if (clock_gettime(CLOCK_MONOTONIC, &to))
+		error("gettime64 failed\n", errno);
+
+	to.tv_sec++;
+
+	res =3D futex_waitv(waitv, NR_FUTEXES, 0, &to, CLOCK_MONOTONIC);
+	if (res < 0) {
+		ksft_test_result_fail("futex_waitv returned: %d %s\n",
+				      errno, strerror(errno));
+	} else if (res !=3D NR_FUTEXES - 1) {
+		ksft_test_result_fail("futex_waitv returned: %d, expecting %d\n",
+				      res, NR_FUTEXES - 1);
+	}
+
+	return NULL;
+}
+
+int main(int argc, char *argv[])
+{
+	pthread_t waiter;
+	int res, ret =3D RET_PASS;
+	struct timespec to;
+	int c, i;
+
+	while ((c =3D getopt(argc, argv, "cht:v:")) !=3D -1) {
+		switch (c) {
+		case 'c':
+			log_color(1);
+			break;
+		case 'h':
+			usage(basename(argv[0]));
+			exit(0);
+		case 'v':
+			log_verbosity(atoi(optarg));
+			break;
+		default:
+			usage(basename(argv[0]));
+			exit(1);
+		}
+	}
+
+	ksft_print_header();
+	ksft_set_plan(7);
+	ksft_print_msg("%s: Test FUTEX_WAITV\n",
+		       basename(argv[0]));
+
+	for (i =3D 0; i < NR_FUTEXES; i++) {
+		waitv[i].uaddr =3D (uintptr_t)&futexes[i];
+		waitv[i].flags =3D FUTEX_32 | FUTEX_PRIVATE_FLAG;
+		waitv[i].val =3D 0;
+		waitv[i].__reserved =3D 0;
+	}
+
+	/* Private waitv */
+	if (pthread_create(&waiter, NULL, waiterfn, NULL))
+		error("pthread_create failed\n", errno);
+
+	usleep(WAKE_WAIT_US);
+
+	res =3D futex_wake(u64_to_ptr(waitv[NR_FUTEXES - 1].uaddr), 1, FUTEX_PRIVAT=
E_FLAG);
+	if (res !=3D 1) {
+		ksft_test_result_fail("futex_wake private returned: %d %s\n",
+				      res ? errno : res,
+				      res ? strerror(errno) : "");
+		ret =3D RET_FAIL;
+	} else {
+		ksft_test_result_pass("futex_waitv private\n");
+	}
+
+	/* Shared waitv */
+	for (i =3D 0; i < NR_FUTEXES; i++) {
+		int shm_id =3D shmget(IPC_PRIVATE, 4096, IPC_CREAT | 0666);
+
+		if (shm_id < 0) {
+			perror("shmget");
+			exit(1);
+		}
+
+		unsigned int *shared_data =3D shmat(shm_id, NULL, 0);
+
+		*shared_data =3D 0;
+		waitv[i].uaddr =3D (uintptr_t)shared_data;
+		waitv[i].flags =3D FUTEX_32;
+		waitv[i].val =3D 0;
+		waitv[i].__reserved =3D 0;
+	}
+
+	if (pthread_create(&waiter, NULL, waiterfn, NULL))
+		error("pthread_create failed\n", errno);
+
+	usleep(WAKE_WAIT_US);
+
+	res =3D futex_wake(u64_to_ptr(waitv[NR_FUTEXES - 1].uaddr), 1, 0);
+	if (res !=3D 1) {
+		ksft_test_result_fail("futex_wake shared returned: %d %s\n",
+				      res ? errno : res,
+				      res ? strerror(errno) : "");
+		ret =3D RET_FAIL;
+	} else {
+		ksft_test_result_pass("futex_waitv shared\n");
+	}
+
+	for (i =3D 0; i < NR_FUTEXES; i++)
+		shmdt(u64_to_ptr(waitv[i].uaddr));
+
+	/* Testing a waiter without FUTEX_32 flag */
+	waitv[0].flags =3D FUTEX_PRIVATE_FLAG;
+
+	if (clock_gettime(CLOCK_MONOTONIC, &to))
+		error("gettime64 failed\n", errno);
+
+	to.tv_sec++;
+
+	res =3D futex_waitv(waitv, NR_FUTEXES, 0, &to, CLOCK_MONOTONIC);
+	if (res =3D=3D EINVAL) {
+		ksft_test_result_fail("futex_waitv private returned: %d %s\n",
+				      res ? errno : res,
+				      res ? strerror(errno) : "");
+		ret =3D RET_FAIL;
+	} else {
+		ksft_test_result_pass("futex_waitv without FUTEX_32\n");
+	}
+
+	/* Testing a waiter with an unaligned address */
+	waitv[0].flags =3D FUTEX_PRIVATE_FLAG | FUTEX_32;
+	waitv[0].uaddr =3D 1;
+
+	if (clock_gettime(CLOCK_MONOTONIC, &to))
+		error("gettime64 failed\n", errno);
+
+	to.tv_sec++;
+
+	res =3D futex_waitv(waitv, NR_FUTEXES, 0, &to, CLOCK_MONOTONIC);
+	if (res =3D=3D EINVAL) {
+		ksft_test_result_fail("futex_wake private returned: %d %s\n",
+				      res ? errno : res,
+				      res ? strerror(errno) : "");
+		ret =3D RET_FAIL;
+	} else {
+		ksft_test_result_pass("futex_waitv with an unaligned address\n");
+	}
+
+	/* Testing a NULL address for waiters.uaddr */
+	waitv[0].uaddr =3D 0x00000000;
+
+	if (clock_gettime(CLOCK_MONOTONIC, &to))
+		error("gettime64 failed\n", errno);
+
+	to.tv_sec++;
+
+	res =3D futex_waitv(waitv, NR_FUTEXES, 0, &to, CLOCK_MONOTONIC);
+	if (res =3D=3D EINVAL) {
+		ksft_test_result_fail("futex_waitv private returned: %d %s\n",
+				      res ? errno : res,
+				      res ? strerror(errno) : "");
+		ret =3D RET_FAIL;
+	} else {
+		ksft_test_result_pass("futex_waitv NULL address in waitv.uaddr\n");
+	}
+
+	/* Testing a NULL address for *waiters */
+	if (clock_gettime(CLOCK_MONOTONIC, &to))
+		error("gettime64 failed\n", errno);
+
+	to.tv_sec++;
+
+	res =3D futex_waitv(NULL, NR_FUTEXES, 0, &to, CLOCK_MONOTONIC);
+	if (res =3D=3D EINVAL) {
+		ksft_test_result_fail("futex_waitv private returned: %d %s\n",
+				      res ? errno : res,
+				      res ? strerror(errno) : "");
+		ret =3D RET_FAIL;
+	} else {
+		ksft_test_result_pass("futex_waitv NULL address in *waiters\n");
+	}
+
+	/* Testing an invalid clockid */
+	if (clock_gettime(CLOCK_MONOTONIC, &to))
+		error("gettime64 failed\n", errno);
+
+	to.tv_sec++;
+
+	res =3D futex_waitv(NULL, NR_FUTEXES, 0, &to, CLOCK_TAI);
+	if (res =3D=3D EINVAL) {
+		ksft_test_result_fail("futex_waitv private returned: %d %s\n",
+				      res ? errno : res,
+				      res ? strerror(errno) : "");
+		ret =3D RET_FAIL;
+	} else {
+		ksft_test_result_pass("futex_waitv invalid clockid\n");
+	}
+
+	ksft_print_cnts();
+	return ret;
+}
diff --git a/tools/testing/selftests/futex/functional/run.sh b/tools/testing/=
selftests/futex/functional/run.sh
index 11a9d62..5ccd599 100755
--- a/tools/testing/selftests/futex/functional/run.sh
+++ b/tools/testing/selftests/futex/functional/run.sh
@@ -79,3 +79,6 @@ echo
=20
 echo
 ./futex_requeue $COLOR
+
+echo
+./futex_waitv $COLOR
diff --git a/tools/testing/selftests/futex/include/futex2test.h b/tools/testi=
ng/selftests/futex/include/futex2test.h
new file mode 100644
index 0000000..9d30552
--- /dev/null
+++ b/tools/testing/selftests/futex/include/futex2test.h
@@ -0,0 +1,22 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * Futex2 library addons for futex tests
+ *
+ * Copyright 2021 Collabora Ltd.
+ */
+#include <stdint.h>
+
+#define u64_to_ptr(x) ((void *)(uintptr_t)(x))
+
+/**
+ * futex_waitv - Wait at multiple futexes, wake on any
+ * @waiters:    Array of waiters
+ * @nr_waiters: Length of waiters array
+ * @flags: Operation flags
+ * @timo:  Optional timeout for operation
+ */
+static inline int futex_waitv(volatile struct futex_waitv *waiters, unsigned=
 long nr_waiters,
+			      unsigned long flags, struct timespec *timo, clockid_t clockid)
+{
+	return syscall(__NR_futex_waitv, waiters, nr_waiters, flags, timo, clockid);
+}
