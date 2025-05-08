Return-Path: <linux-tip-commits+bounces-5464-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A0ED1AAF7E1
	for <lists+linux-tip-commits@lfdr.de>; Thu,  8 May 2025 12:33:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9CB781C06434
	for <lists+linux-tip-commits@lfdr.de>; Thu,  8 May 2025 10:34:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CAAE21504E;
	Thu,  8 May 2025 10:33:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="jXfhcFdP";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="NEH31Zc7"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58CC64B1E7C;
	Thu,  8 May 2025 10:33:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746700430; cv=none; b=s2IEsPm1No5z0C5tACsfi8zTGtefqqvZKTJzahlYw+5Zv9naSifMnDt5vSyU+smzoYGbBbIJXTqKo+OoEyYJSe7omGiLTdNEzsvuHhy5Wq4E+2rzX+xCDTMwIPwcs+NBLR7rsr45cGyErFvwMSg1R2HgqsSf21pYNb79We6tY08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746700430; c=relaxed/simple;
	bh=TJH4jpbNSg2c7C0T+/ASUnPVqKy7iTplJYETUcxL1Bk=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=p3drU4ccVtEfnKk7494bc9WRJv5Bj+gmfEfhLZhWTHRluR0P39O03UOZPCil4cobgyez8YKHWZ+9RoCfWvKdNNvPD6kof7X2y6g5aDApoLHM2k7sDkkR8mXsThuWtzwZJHuHF2+M3Yvccf2pKMqMn7pCAnI7yOp+ngVns11OGeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=jXfhcFdP; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=NEH31Zc7; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 08 May 2025 10:33:45 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1746700426;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PTERVacphTRjOfCkD/3pVwtmaa2yLseQtsrKwDvpz28=;
	b=jXfhcFdPOVwxf78y8L4bdPoDav6CAoPAjYab1U1Gz5g4SUNhieNGY3zKIFxJfdHr9j+3yB
	fnDxy4ew6yt2k8UqWfS2mce0qXwScXqFQVE3qVmkMi3mzMV9W02k3j9gdLu5ETIcMZnObD
	ZY04wl0TTA8dHlg0/dsxqBOHo+iD6mHX8Fk+1eWJbMdH3jT66jBb1W5tdlWOUAaW+NRf9K
	MhdN6E9I60U+o43QiQUJpetKfg3atmzMIn/HHbLHtYMUfoNqp5iT+kg9D8+m+4mA9Gm2Dm
	KOxmO0n8IXlhZ8KcUtxFB6ZjLXFXIh9Dd4Bfd6Y9f+eRuDAjSgCExPIfYDYWEg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1746700426;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PTERVacphTRjOfCkD/3pVwtmaa2yLseQtsrKwDvpz28=;
	b=NEH31Zc7vM1IUHjFxkz180wFvrPHUR9wM58T5P7XDcpIYAn01PuFW3IcSafizJTtUMIVrB
	dvecUn2BNLjAzAAw==
From: "tip-bot2 for Sebastian Andrzej Siewior" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: locking/futex] selftests/futex: Add futex_numa_mpol
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250416162921.513656-22-bigeasy@linutronix.de>
References: <20250416162921.513656-22-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174670042503.406.13929766563847807863.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the locking/futex branch of tip:

Commit-ID:     3163369407baf8331a234fe4817e9ea27ba7ea9c
Gitweb:        https://git.kernel.org/tip/3163369407baf8331a234fe4817e9ea27ba7ea9c
Author:        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
AuthorDate:    Wed, 16 Apr 2025 18:29:21 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Sat, 03 May 2025 12:02:10 +02:00

selftests/futex: Add futex_numa_mpol

Test the basic functionality for the NUMA and MPOL flags:
- FUTEX2_NUMA should take the NUMA node which is after the uaddr
  and use it.
- Only update the node if FUTEX_NO_NODE was set by the user
- FUTEX2_MPOL should use the memory based on the policy. I attempted to
  set the node with mbind() and then use this with MPOL but this fails
  and futex falls back to the default node for the current CPU.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/r/20250416162921.513656-22-bigeasy@linutronix.de
---
 tools/testing/selftests/futex/functional/.gitignore        |   1 +-
 tools/testing/selftests/futex/functional/Makefile          |   3 +-
 tools/testing/selftests/futex/functional/futex_numa_mpol.c | 232 +++++++-
 tools/testing/selftests/futex/functional/run.sh            |   3 +-
 tools/testing/selftests/futex/include/futex2test.h         |  52 ++-
 5 files changed, 290 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/futex/functional/futex_numa_mpol.c

diff --git a/tools/testing/selftests/futex/functional/.gitignore b/tools/testing/selftests/futex/functional/.gitignore
index d37ae7c..7b24ae8 100644
--- a/tools/testing/selftests/futex/functional/.gitignore
+++ b/tools/testing/selftests/futex/functional/.gitignore
@@ -1,4 +1,5 @@
 # SPDX-License-Identifier: GPL-2.0-only
+futex_numa_mpol
 futex_priv_hash
 futex_requeue
 futex_requeue_pi
diff --git a/tools/testing/selftests/futex/functional/Makefile b/tools/testing/selftests/futex/functional/Makefile
index 67d9e16..a4881fd 100644
--- a/tools/testing/selftests/futex/functional/Makefile
+++ b/tools/testing/selftests/futex/functional/Makefile
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 INCLUDES := -I../include -I../../ $(KHDR_INCLUDES)
 CFLAGS := $(CFLAGS) -g -O2 -Wall -pthread $(INCLUDES) $(KHDR_INCLUDES)
-LDLIBS := -lpthread -lrt
+LDLIBS := -lpthread -lrt -lnuma
 
 LOCAL_HDRS := \
 	../include/futextest.h \
@@ -18,6 +18,7 @@ TEST_GEN_PROGS := \
 	futex_wait \
 	futex_requeue \
 	futex_priv_hash \
+	futex_numa_mpol \
 	futex_waitv
 
 TEST_PROGS := run.sh
diff --git a/tools/testing/selftests/futex/functional/futex_numa_mpol.c b/tools/testing/selftests/futex/functional/futex_numa_mpol.c
new file mode 100644
index 0000000..dd70532
--- /dev/null
+++ b/tools/testing/selftests/futex/functional/futex_numa_mpol.c
@@ -0,0 +1,232 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (C) 2025 Sebastian Andrzej Siewior <bigeasy@linutronix.de>
+ */
+
+#define _GNU_SOURCE
+
+#include <errno.h>
+#include <pthread.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <unistd.h>
+#include <numa.h>
+#include <numaif.h>
+
+#include <linux/futex.h>
+#include <sys/mman.h>
+
+#include "logging.h"
+#include "futextest.h"
+#include "futex2test.h"
+
+#define MAX_THREADS	64
+
+static pthread_barrier_t barrier_main;
+static pthread_t threads[MAX_THREADS];
+
+struct thread_args {
+	void *futex_ptr;
+	unsigned int flags;
+	int result;
+};
+
+static struct thread_args thread_args[MAX_THREADS];
+
+#ifndef FUTEX_NO_NODE
+#define FUTEX_NO_NODE (-1)
+#endif
+
+#ifndef FUTEX2_MPOL
+#define FUTEX2_MPOL	0x08
+#endif
+
+static void *thread_lock_fn(void *arg)
+{
+	struct thread_args *args = arg;
+	int ret;
+
+	pthread_barrier_wait(&barrier_main);
+	ret = futex2_wait(args->futex_ptr, 0, args->flags, NULL, 0);
+	args->result = ret;
+	return NULL;
+}
+
+static void create_max_threads(void *futex_ptr)
+{
+	int i, ret;
+
+	for (i = 0; i < MAX_THREADS; i++) {
+		thread_args[i].futex_ptr = futex_ptr;
+		thread_args[i].flags = FUTEX2_SIZE_U32 | FUTEX_PRIVATE_FLAG | FUTEX2_NUMA;
+		thread_args[i].result = 0;
+		ret = pthread_create(&threads[i], NULL, thread_lock_fn, &thread_args[i]);
+		if (ret) {
+			error("pthread_create failed\n", errno);
+			exit(1);
+		}
+	}
+}
+
+static void join_max_threads(void)
+{
+	int i, ret;
+
+	for (i = 0; i < MAX_THREADS; i++) {
+		ret = pthread_join(threads[i], NULL);
+		if (ret) {
+			error("pthread_join failed for thread %d\n", errno, i);
+			exit(1);
+		}
+	}
+}
+
+static void __test_futex(void *futex_ptr, int must_fail, unsigned int futex_flags)
+{
+	int to_wake, ret, i, need_exit = 0;
+
+	pthread_barrier_init(&barrier_main, NULL, MAX_THREADS + 1);
+	create_max_threads(futex_ptr);
+	pthread_barrier_wait(&barrier_main);
+	to_wake = MAX_THREADS;
+
+	do {
+		ret = futex2_wake(futex_ptr, to_wake, futex_flags);
+		if (must_fail) {
+			if (ret < 0)
+				break;
+			fail("Should fail, but didn't\n");
+			exit(1);
+		}
+		if (ret < 0) {
+			error("Failed futex2_wake(%d)\n", errno, to_wake);
+			exit(1);
+		}
+		if (!ret)
+			usleep(50);
+		to_wake -= ret;
+
+	} while (to_wake);
+	join_max_threads();
+
+	for (i = 0; i < MAX_THREADS; i++) {
+		if (must_fail && thread_args[i].result != -1) {
+			fail("Thread %d should fail but succeeded (%d)\n", i, thread_args[i].result);
+			need_exit = 1;
+		}
+		if (!must_fail && thread_args[i].result != 0) {
+			fail("Thread %d failed (%d)\n", i, thread_args[i].result);
+			need_exit = 1;
+		}
+	}
+	if (need_exit)
+		exit(1);
+}
+
+static void test_futex(void *futex_ptr, int must_fail)
+{
+	__test_futex(futex_ptr, must_fail, FUTEX2_SIZE_U32 | FUTEX_PRIVATE_FLAG | FUTEX2_NUMA);
+}
+
+static void test_futex_mpol(void *futex_ptr, int must_fail)
+{
+	__test_futex(futex_ptr, must_fail, FUTEX2_SIZE_U32 | FUTEX_PRIVATE_FLAG | FUTEX2_NUMA | FUTEX2_MPOL);
+}
+
+static void usage(char *prog)
+{
+	printf("Usage: %s\n", prog);
+	printf("  -c    Use color\n");
+	printf("  -h    Display this help message\n");
+	printf("  -v L  Verbosity level: %d=QUIET %d=CRITICAL %d=INFO\n",
+	       VQUIET, VCRITICAL, VINFO);
+}
+
+int main(int argc, char *argv[])
+{
+	struct futex32_numa *futex_numa;
+	int mem_size, i;
+	void *futex_ptr;
+	char c;
+
+	while ((c = getopt(argc, argv, "chv:")) != -1) {
+		switch (c) {
+		case 'c':
+			log_color(1);
+			break;
+		case 'h':
+			usage(basename(argv[0]));
+			exit(0);
+			break;
+		case 'v':
+			log_verbosity(atoi(optarg));
+			break;
+		default:
+			usage(basename(argv[0]));
+			exit(1);
+		}
+	}
+
+	mem_size = sysconf(_SC_PAGE_SIZE);
+	futex_ptr = mmap(NULL, mem_size, PROT_READ | PROT_WRITE, MAP_PRIVATE | MAP_ANONYMOUS, 0, 0);
+	if (futex_ptr == MAP_FAILED) {
+		error("mmap() for %d bytes failed\n", errno, mem_size);
+		return 1;
+	}
+	futex_numa = futex_ptr;
+
+	info("Regular test\n");
+	futex_numa->futex = 0;
+	futex_numa->numa = FUTEX_NO_NODE;
+	test_futex(futex_ptr, 0);
+
+	if (futex_numa->numa == FUTEX_NO_NODE) {
+		fail("NUMA node is left unitiliazed\n");
+		return 1;
+	}
+
+	info("Memory too small\n");
+	test_futex(futex_ptr + mem_size - 4, 1);
+
+	info("Memory out of range\n");
+	test_futex(futex_ptr + mem_size, 1);
+
+	futex_numa->numa = FUTEX_NO_NODE;
+	mprotect(futex_ptr, mem_size, PROT_READ);
+	info("Memory, RO\n");
+	test_futex(futex_ptr, 1);
+
+	mprotect(futex_ptr, mem_size, PROT_NONE);
+	info("Memory, no access\n");
+	test_futex(futex_ptr, 1);
+
+	mprotect(futex_ptr, mem_size, PROT_READ | PROT_WRITE);
+	info("Memory back to RW\n");
+	test_futex(futex_ptr, 0);
+
+	/* MPOL test. Does not work as expected */
+	for (i = 0; i < 4; i++) {
+		unsigned long nodemask;
+		int ret;
+
+		nodemask = 1 << i;
+		ret = mbind(futex_ptr, mem_size, MPOL_BIND, &nodemask,
+			    sizeof(nodemask) * 8, 0);
+		if (ret == 0) {
+			info("Node %d test\n", i);
+			futex_numa->futex = 0;
+			futex_numa->numa = FUTEX_NO_NODE;
+
+			ret = futex2_wake(futex_ptr, 0, FUTEX2_SIZE_U32 | FUTEX_PRIVATE_FLAG | FUTEX2_NUMA | FUTEX2_MPOL);
+			if (ret < 0)
+				error("Failed to wake 0 with MPOL.\n", errno);
+			if (0)
+				test_futex_mpol(futex_numa, 0);
+			if (futex_numa->numa != i) {
+				fail("Returned NUMA node is %d expected %d\n",
+				     futex_numa->numa, i);
+			}
+		}
+	}
+	return 0;
+}
diff --git a/tools/testing/selftests/futex/functional/run.sh b/tools/testing/selftests/futex/functional/run.sh
index f0f0d2b..8173984 100755
--- a/tools/testing/selftests/futex/functional/run.sh
+++ b/tools/testing/selftests/futex/functional/run.sh
@@ -86,3 +86,6 @@ echo
 echo
 ./futex_priv_hash $COLOR
 ./futex_priv_hash -g $COLOR
+
+echo
+./futex_numa_mpol $COLOR
diff --git a/tools/testing/selftests/futex/include/futex2test.h b/tools/testing/selftests/futex/include/futex2test.h
index 9ee3592..ea79662 100644
--- a/tools/testing/selftests/futex/include/futex2test.h
+++ b/tools/testing/selftests/futex/include/futex2test.h
@@ -18,14 +18,43 @@ struct futex_waitv {
 };
 #endif
 
+#ifndef __NR_futex_wake
+#define __NR_futex_wake 454
+#endif
+
+#ifndef __NR_futex_wait
+#define __NR_futex_wait 455
+#endif
+
 #ifndef FUTEX2_SIZE_U32
 #define FUTEX2_SIZE_U32 0x02
 #endif
 
+#ifndef FUTEX2_NUMA
+#define FUTEX2_NUMA 0x04
+#endif
+
+#ifndef FUTEX2_MPOL
+#define FUTEX2_MPOL 0x08
+#endif
+
+#ifndef FUTEX2_PRIVATE
+#define FUTEX2_PRIVATE FUTEX_PRIVATE_FLAG
+#endif
+
+#ifndef FUTEX2_NO_NODE
+#define FUTEX_NO_NODE (-1)
+#endif
+
 #ifndef FUTEX_32
 #define FUTEX_32 FUTEX2_SIZE_U32
 #endif
 
+struct futex32_numa {
+	futex_t futex;
+	futex_t numa;
+};
+
 /**
  * futex_waitv - Wait at multiple futexes, wake on any
  * @waiters:    Array of waiters
@@ -38,3 +67,26 @@ static inline int futex_waitv(volatile struct futex_waitv *waiters, unsigned lon
 {
 	return syscall(__NR_futex_waitv, waiters, nr_waiters, flags, timo, clockid);
 }
+
+/*
+ * futex_wait() - block on uaddr with optional timeout
+ * @val:	Expected value
+ * @flags:	FUTEX2 flags
+ * @timeout:	Relative timeout
+ * @clockid:	Clock id for the timeout
+ */
+static inline int futex2_wait(void *uaddr, long val, unsigned int flags,
+			      struct timespec *timeout, clockid_t clockid)
+{
+	return syscall(__NR_futex_wait, uaddr, val, ~0U, flags, timeout, clockid);
+}
+
+/*
+ * futex2_wake() - Wake a number of futexes
+ * @nr:		Number of threads to wake at most
+ * @flags:	FUTEX2 flags
+ */
+static inline int futex2_wake(void *uaddr, int nr, unsigned int flags)
+{
+	return syscall(__NR_futex_wake, uaddr, ~0U, nr, flags);
+}

