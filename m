Return-Path: <linux-tip-commits+bounces-5465-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 28053AAF7E2
	for <lists+linux-tip-commits@lfdr.de>; Thu,  8 May 2025 12:34:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0554D3A5E36
	for <lists+linux-tip-commits@lfdr.de>; Thu,  8 May 2025 10:33:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9139221519F;
	Thu,  8 May 2025 10:33:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="zEWCakrI";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="tK937q8e"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58D3021147F;
	Thu,  8 May 2025 10:33:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746700430; cv=none; b=b3TEwdq2LX4wfWqJOYiaU14n7kY8rMI8MKFnZ7lNnSfIn0CrM7Ng8cCybM7pohhNVMAgxscpzdnnPpR7BQ1WBkGS9RSxh5eFJpOsw6971Llt+jHwQt1iCEmjqCSw7bMi7+ciQwba4pv08b35kKGbFf1lWwmO83TeGZcdO0EX7vs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746700430; c=relaxed/simple;
	bh=NiLg6l1ERttqeRcO76J+r9hgARvInIUrwaJkooSjUwE=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=Id4xaeHCJ8K3CDpAf9kSozghwYCnWjU/Le8ArMNMPur2xIvAAuItpGa5+BsrO80zkJgQRZFCrs8iGda6JIA9bIXWHE2q3X1lLw4D6jtVsHYwZjsJpgiP0Su8AuwOmerY/00M+lT83bUcEnf8h2xfW9LhS/90FHeBpPJt5gHsTn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=zEWCakrI; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=tK937q8e; arc=none smtp.client-ip=193.142.43.55
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
	bh=dRYHBkwyvmPF18RLIZHw7p8MOtdtL6YSJr/G0xeFlzQ=;
	b=zEWCakrInMqn5oJdwFlWdVR1bTiPOQ9NIdk84vWVsSDO+0wpfjtdiubg0uTMq0kUHuGjZ9
	3FfeUzf+ihx1FENrKOsveknejOg3V5AkrZ2aXqMXEobocdsi5s0uR4wxUQ5qRElhIdH55n
	/XlYNHaUnwhc0BletQhJN8TuOTgaiEL0tvr+GRe5nhlfSl1o3D4dTnUav7rMiPwekRsmt8
	htmaY0ctogb52HwU4lUQkEsCUwwy8qByKF4tHyEbOsjbhL+bJpWW5OqBY21vpvF8o+XBGF
	NCbidDHHMkG4H4R2J0YU2HePbHVnJ6V8U3+ek12j4fMRxnTHnHJ8njrQb0pVfQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1746700426;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dRYHBkwyvmPF18RLIZHw7p8MOtdtL6YSJr/G0xeFlzQ=;
	b=tK937q8eUVpJlPgVKz1qpEZwlvk3zZga+JDV0zsDppn+zO3ztmji3yMTU/8td6Ri15bY//
	3OszVO73BA35SyAg==
From: "tip-bot2 for Sebastian Andrzej Siewior" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: locking/futex] selftests/futex: Add futex_priv_hash
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250416162921.513656-21-bigeasy@linutronix.de>
References: <20250416162921.513656-21-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174670042580.406.16015210835876114664.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the locking/futex branch of tip:

Commit-ID:     cda95faef7bcf26ba3f54c3cddce66d50116d146
Gitweb:        https://git.kernel.org/tip/cda95faef7bcf26ba3f54c3cddce66d50116d146
Author:        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
AuthorDate:    Wed, 16 Apr 2025 18:29:20 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Sat, 03 May 2025 12:02:10 +02:00

selftests/futex: Add futex_priv_hash

Test the basic functionality of the private hash:
- Upon start, with no threads there is no private hash.
- The first thread initializes the private hash.
- More than four threads will increase the size of the private hash if
  the system has more than 16 CPUs online.
- Once the user sets the size of private hash, auto scaling is disabled.
- The user is only allowed to use numbers to the power of two.
- The user may request the global or make the hash immutable.
- Once the global hash has been set or the hash has been made immutable,
  further changes are not allowed.
- Futex operations should work the whole time. It must be possible to
  hold a lock, such a PI initialised mutex, during the resize operation.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/r/20250416162921.513656-21-bigeasy@linutronix.de
---
 tools/testing/selftests/futex/functional/.gitignore        |   5 +-
 tools/testing/selftests/futex/functional/Makefile          |   1 +-
 tools/testing/selftests/futex/functional/futex_priv_hash.c | 315 +++++++-
 tools/testing/selftests/futex/functional/run.sh            |   4 +-
 4 files changed, 323 insertions(+), 2 deletions(-)
 create mode 100644 tools/testing/selftests/futex/functional/futex_priv_hash.c

diff --git a/tools/testing/selftests/futex/functional/.gitignore b/tools/testing/selftests/futex/functional/.gitignore
index fbcbdb6..d37ae7c 100644
--- a/tools/testing/selftests/futex/functional/.gitignore
+++ b/tools/testing/selftests/futex/functional/.gitignore
@@ -1,11 +1,12 @@
 # SPDX-License-Identifier: GPL-2.0-only
+futex_priv_hash
+futex_requeue
 futex_requeue_pi
 futex_requeue_pi_mismatched_ops
 futex_requeue_pi_signal_restart
+futex_wait
 futex_wait_private_mapped_file
 futex_wait_timeout
 futex_wait_uninitialized_heap
 futex_wait_wouldblock
-futex_wait
-futex_requeue
 futex_waitv
diff --git a/tools/testing/selftests/futex/functional/Makefile b/tools/testing/selftests/futex/functional/Makefile
index f79f9ba..67d9e16 100644
--- a/tools/testing/selftests/futex/functional/Makefile
+++ b/tools/testing/selftests/futex/functional/Makefile
@@ -17,6 +17,7 @@ TEST_GEN_PROGS := \
 	futex_wait_private_mapped_file \
 	futex_wait \
 	futex_requeue \
+	futex_priv_hash \
 	futex_waitv
 
 TEST_PROGS := run.sh
diff --git a/tools/testing/selftests/futex/functional/futex_priv_hash.c b/tools/testing/selftests/futex/functional/futex_priv_hash.c
new file mode 100644
index 0000000..4d37650
--- /dev/null
+++ b/tools/testing/selftests/futex/functional/futex_priv_hash.c
@@ -0,0 +1,315 @@
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
+
+#include <linux/prctl.h>
+#include <sys/prctl.h>
+
+#include "logging.h"
+
+#define MAX_THREADS	64
+
+static pthread_barrier_t barrier_main;
+static pthread_mutex_t global_lock;
+static pthread_t threads[MAX_THREADS];
+static int counter;
+
+#ifndef PR_FUTEX_HASH
+#define PR_FUTEX_HASH			78
+# define PR_FUTEX_HASH_SET_SLOTS	1
+# define PR_FUTEX_HASH_GET_SLOTS	2
+# define PR_FUTEX_HASH_GET_IMMUTABLE	3
+#endif
+
+static int futex_hash_slots_set(unsigned int slots, int immutable)
+{
+	return prctl(PR_FUTEX_HASH, PR_FUTEX_HASH_SET_SLOTS, slots, immutable);
+}
+
+static int futex_hash_slots_get(void)
+{
+	return prctl(PR_FUTEX_HASH, PR_FUTEX_HASH_GET_SLOTS);
+}
+
+static int futex_hash_immutable_get(void)
+{
+	return prctl(PR_FUTEX_HASH, PR_FUTEX_HASH_GET_IMMUTABLE);
+}
+
+static void futex_hash_slots_set_verify(int slots)
+{
+	int ret;
+
+	ret = futex_hash_slots_set(slots, 0);
+	if (ret != 0) {
+		error("Failed to set slots to %d\n", errno, slots);
+		exit(1);
+	}
+	ret = futex_hash_slots_get();
+	if (ret != slots) {
+		error("Set %d slots but PR_FUTEX_HASH_GET_SLOTS returns: %d\n",
+		       errno, slots, ret);
+		exit(1);
+	}
+}
+
+static void futex_hash_slots_set_must_fail(int slots, int immutable)
+{
+	int ret;
+
+	ret = futex_hash_slots_set(slots, immutable);
+	if (ret < 0)
+		return;
+
+	fail("futex_hash_slots_set(%d, %d) expected to fail but succeeded.\n",
+	       slots, immutable);
+	exit(1);
+}
+
+static void *thread_return_fn(void *arg)
+{
+	return NULL;
+}
+
+static void *thread_lock_fn(void *arg)
+{
+	pthread_barrier_wait(&barrier_main);
+
+	pthread_mutex_lock(&global_lock);
+	counter++;
+	usleep(20);
+	pthread_mutex_unlock(&global_lock);
+	return NULL;
+}
+
+static void create_max_threads(void *(*thread_fn)(void *))
+{
+	int i, ret;
+
+	for (i = 0; i < MAX_THREADS; i++) {
+		ret = pthread_create(&threads[i], NULL, thread_fn, NULL);
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
+static void usage(char *prog)
+{
+	printf("Usage: %s\n", prog);
+	printf("  -c    Use color\n");
+	printf("  -g    Test global hash instead intead local immutable \n");
+	printf("  -h    Display this help message\n");
+	printf("  -v L  Verbosity level: %d=QUIET %d=CRITICAL %d=INFO\n",
+	       VQUIET, VCRITICAL, VINFO);
+}
+
+int main(int argc, char *argv[])
+{
+	int futex_slots1, futex_slotsn, online_cpus;
+	pthread_mutexattr_t mutex_attr_pi;
+	int use_global_hash = 0;
+	int ret;
+	char c;
+
+	while ((c = getopt(argc, argv, "cghv:")) != -1) {
+		switch (c) {
+		case 'c':
+			log_color(1);
+			break;
+		case 'g':
+			use_global_hash = 1;
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
+
+	ret = pthread_mutexattr_init(&mutex_attr_pi);
+	ret |= pthread_mutexattr_setprotocol(&mutex_attr_pi, PTHREAD_PRIO_INHERIT);
+	ret |= pthread_mutex_init(&global_lock, &mutex_attr_pi);
+	if (ret != 0) {
+		fail("Failed to initialize pthread mutex.\n");
+		return 1;
+	}
+
+	/* First thread, expect to be 0, not yet initialized */
+	ret = futex_hash_slots_get();
+	if (ret != 0) {
+		error("futex_hash_slots_get() failed: %d\n", errno, ret);
+		return 1;
+	}
+	ret = futex_hash_immutable_get();
+	if (ret != 0) {
+		error("futex_hash_immutable_get() failed: %d\n", errno, ret);
+		return 1;
+	}
+
+	ret = pthread_create(&threads[0], NULL, thread_return_fn, NULL);
+	if (ret != 0) {
+		error("pthread_create() failed: %d\n", errno, ret);
+		return 1;
+	}
+	ret = pthread_join(threads[0], NULL);
+	if (ret != 0) {
+		error("pthread_join() failed: %d\n", errno, ret);
+		return 1;
+	}
+	/* First thread, has to initialiaze private hash */
+	futex_slots1 = futex_hash_slots_get();
+	if (futex_slots1 <= 0) {
+		fail("Expected > 0 hash buckets, got: %d\n", futex_slots1);
+		return 1;
+	}
+
+	online_cpus = sysconf(_SC_NPROCESSORS_ONLN);
+	ret = pthread_barrier_init(&barrier_main, NULL, MAX_THREADS + 1);
+	if (ret != 0) {
+		error("pthread_barrier_init failed.\n", errno);
+		return 1;
+	}
+
+	ret = pthread_mutex_lock(&global_lock);
+	if (ret != 0) {
+		error("pthread_mutex_lock failed.\n", errno);
+		return 1;
+	}
+
+	counter = 0;
+	create_max_threads(thread_lock_fn);
+	pthread_barrier_wait(&barrier_main);
+
+	/*
+	 * The current default size of hash buckets is 16. The auto increase
+	 * works only if more than 16 CPUs are available.
+	 */
+	if (online_cpus > 16) {
+		futex_slotsn = futex_hash_slots_get();
+		if (futex_slotsn < 0 || futex_slots1 == futex_slotsn) {
+			fail("Expected increase of hash buckets but got: %d -> %d\n",
+			      futex_slots1, futex_slotsn);
+			info("Online CPUs: %d\n", online_cpus);
+			return 1;
+		}
+	}
+	ret = pthread_mutex_unlock(&global_lock);
+
+	/* Once the user changes it, it has to be what is set */
+	futex_hash_slots_set_verify(2);
+	futex_hash_slots_set_verify(4);
+	futex_hash_slots_set_verify(8);
+	futex_hash_slots_set_verify(32);
+	futex_hash_slots_set_verify(16);
+
+	ret = futex_hash_slots_set(15, 0);
+	if (ret >= 0) {
+		fail("Expected to fail with 15 slots but succeeded: %d.\n", ret);
+		return 1;
+	}
+	futex_hash_slots_set_verify(2);
+	join_max_threads();
+	if (counter != MAX_THREADS) {
+		fail("Expected thread counter at %d but is %d\n",
+		       MAX_THREADS, counter);
+		return 1;
+	}
+	counter = 0;
+	/* Once the user set something, auto reisze must be disabled */
+	ret = pthread_barrier_init(&barrier_main, NULL, MAX_THREADS);
+
+	create_max_threads(thread_lock_fn);
+	join_max_threads();
+
+	ret = futex_hash_slots_get();
+	if (ret != 2) {
+		printf("Expected 2 slots, no auto-resize, got %d\n", ret);
+		return 1;
+	}
+
+	futex_hash_slots_set_must_fail(1 << 29, 0);
+
+	/*
+	 * Once the private hash has been made immutable or global hash has been requested,
+	 * then this requested can not be undone.
+	 */
+	if (use_global_hash) {
+		ret = futex_hash_slots_set(0, 0);
+		if (ret != 0) {
+			printf("Can't request global hash: %m\n");
+			return 1;
+		}
+	} else {
+		ret = futex_hash_slots_set(4, 1);
+		if (ret != 0) {
+			printf("Immutable resize to 4 failed: %m\n");
+			return 1;
+		}
+	}
+
+	futex_hash_slots_set_must_fail(4, 0);
+	futex_hash_slots_set_must_fail(4, 1);
+	futex_hash_slots_set_must_fail(8, 0);
+	futex_hash_slots_set_must_fail(8, 1);
+	futex_hash_slots_set_must_fail(0, 1);
+	futex_hash_slots_set_must_fail(6, 1);
+
+	ret = pthread_barrier_init(&barrier_main, NULL, MAX_THREADS);
+	if (ret != 0) {
+		error("pthread_barrier_init failed.\n", errno);
+		return 1;
+	}
+	create_max_threads(thread_lock_fn);
+	join_max_threads();
+
+	ret = futex_hash_slots_get();
+	if (use_global_hash) {
+		if (ret != 0) {
+			error("Expected global hash, got %d\n", errno, ret);
+			return 1;
+		}
+	} else {
+		if (ret != 4) {
+			error("Expected 4 slots, no auto-resize, got %d\n", errno, ret);
+			return 1;
+		}
+	}
+
+	ret = futex_hash_immutable_get();
+	if (ret != 1) {
+		fail("Expected immutable private hash, got %d\n", ret);
+		return 1;
+	}
+	return 0;
+}
diff --git a/tools/testing/selftests/futex/functional/run.sh b/tools/testing/selftests/futex/functional/run.sh
index 5ccd599..f0f0d2b 100755
--- a/tools/testing/selftests/futex/functional/run.sh
+++ b/tools/testing/selftests/futex/functional/run.sh
@@ -82,3 +82,7 @@ echo
 
 echo
 ./futex_waitv $COLOR
+
+echo
+./futex_priv_hash $COLOR
+./futex_priv_hash -g $COLOR

