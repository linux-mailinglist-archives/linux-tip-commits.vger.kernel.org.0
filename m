Return-Path: <linux-tip-commits+bounces-5463-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E6AA7AAF7DF
	for <lists+linux-tip-commits@lfdr.de>; Thu,  8 May 2025 12:33:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C461F3A5E33
	for <lists+linux-tip-commits@lfdr.de>; Thu,  8 May 2025 10:33:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E187220E328;
	Thu,  8 May 2025 10:33:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="gIj2pKVL";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="JzN7Q1M4"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1B5720C46F;
	Thu,  8 May 2025 10:33:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746700428; cv=none; b=QiwgjQn1wC/1uU3SOtNLzLvFmZO4N+xfSDr6ChnKONVydMO5ghXYmw55DTXcTzId/ZD74BP2vDR0TSuH0fQj4ttPf67ZeR4+f4BDhaeEwYh54DkzFvUhn+OvdcPP1jC1yDok6ykRqft06UFbcY3bRajcRdq/0uIcqRq+8SUgIhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746700428; c=relaxed/simple;
	bh=+J0enqHHpgBHl9JpwsJuc6UllKrHph0deck3C7BBMSc=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=PtQe09S9sEXfMzluDD3u/HeNcisbHJQC5dv4m0zSFLNF1m8VeNyNt2floU4romNKhbmipQ01x15UmzxHthzG/IkqzANrvwGag9qdTwCK+mImSNF8udCgP3CEK5YRMiqgcUKojN+tz9W553TfDi7OG264uP3YdyhZVAh2tQTFjgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=gIj2pKVL; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=JzN7Q1M4; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 08 May 2025 10:33:44 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1746700425;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=t1A2RXlLH+TFnPaT/ra8mreTAG0XVq3Avb4+bAg0ZT8=;
	b=gIj2pKVL1m5woVrNCanI1imBE1wf7xbMXFq58iIyrxXMjzL12rI1BK701JghnIFt/V5vKY
	e4kg1N5EIdCLDDqNFOolcEl6IkkmmVv/XanOAHluOd3F0K2Lh2/tU65FxJMhAZIdrjcCdD
	Mut9QxVM+o32jzXRLPVa9Q0ATiC+7aznkM5hBXzSlm4C7WLK7LS7BamM4tSJQmTbRUvJ6S
	jR8niwfrSp0pmUjIUG1vkfDRHn7Do5nqXf5f/Uftm+bcvs9AqURfiyDY59OxY4a2CBpFby
	U2PFUmEm+8REs0LNsZXMPQv9YI0Lble84D1uK28UZQf+1Nrs8h/fnYsc8iz9NQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1746700425;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=t1A2RXlLH+TFnPaT/ra8mreTAG0XVq3Avb4+bAg0ZT8=;
	b=JzN7Q1M4EoGR21F6CwjE3Sq+WiulgNKK3rjqm3Qns9QEpt63spZDVcd40oCKQFLFEaLWsS
	aGh+c+b5O8gofbBA==
From: "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: locking/futex] futex,selftests: Add another FUTEX2_NUMA selftest
Cc: "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174670042408.406.13029931335930886132.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the locking/futex branch of tip:

Commit-ID:     9140f57c1c1391a0343a08daea9cd53f56e51154
Gitweb:        https://git.kernel.org/tip/9140f57c1c1391a0343a08daea9cd53f56e51154
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Thu, 21 Sep 2023 17:17:14 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Sat, 03 May 2025 12:02:11 +02:00

futex,selftests: Add another FUTEX2_NUMA selftest

Implement a simple NUMA aware spinlock for testing and howto purposes.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 tools/testing/selftests/futex/functional/Makefile     |   3 +-
 tools/testing/selftests/futex/functional/futex_numa.c | 262 +++++++++-
 2 files changed, 264 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/futex/functional/futex_numa.c

diff --git a/tools/testing/selftests/futex/functional/Makefile b/tools/testing/selftests/futex/functional/Makefile
index a4881fd..8cfb87f 100644
--- a/tools/testing/selftests/futex/functional/Makefile
+++ b/tools/testing/selftests/futex/functional/Makefile
@@ -19,7 +19,8 @@ TEST_GEN_PROGS := \
 	futex_requeue \
 	futex_priv_hash \
 	futex_numa_mpol \
-	futex_waitv
+	futex_waitv \
+	futex_numa
 
 TEST_PROGS := run.sh
 
diff --git a/tools/testing/selftests/futex/functional/futex_numa.c b/tools/testing/selftests/futex/functional/futex_numa.c
new file mode 100644
index 0000000..f29e4d6
--- /dev/null
+++ b/tools/testing/selftests/futex/functional/futex_numa.c
@@ -0,0 +1,262 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <pthread.h>
+#include <sys/shm.h>
+#include <sys/mman.h>
+#include <fcntl.h>
+#include <stdbool.h>
+#include <time.h>
+#include <assert.h>
+#include "logging.h"
+#include "futextest.h"
+#include "futex2test.h"
+
+typedef u_int32_t u32;
+typedef int32_t   s32;
+typedef u_int64_t u64;
+
+static unsigned int fflags = (FUTEX2_SIZE_U32 | FUTEX2_PRIVATE);
+static int fnode = FUTEX_NO_NODE;
+
+/* fairly stupid test-and-set lock with a waiter flag */
+
+#define N_LOCK		0x0000001
+#define N_WAITERS	0x0001000
+
+struct futex_numa_32 {
+	union {
+		u64 full;
+		struct {
+			u32 val;
+			u32 node;
+		};
+	};
+};
+
+void futex_numa_32_lock(struct futex_numa_32 *lock)
+{
+	for (;;) {
+		struct futex_numa_32 new, old = {
+			.full = __atomic_load_n(&lock->full, __ATOMIC_RELAXED),
+		};
+
+		for (;;) {
+			new = old;
+			if (old.val == 0) {
+				/* no waiter, no lock -> first lock, set no-node */
+				new.node = fnode;
+			}
+			if (old.val & N_LOCK) {
+				/* contention, set waiter */
+				new.val |= N_WAITERS;
+			}
+			new.val |= N_LOCK;
+
+			/* nothing changed, ready to block */
+			if (old.full == new.full)
+				break;
+
+			/*
+			 * Use u64 cmpxchg to set the futex value and node in a
+			 * consistent manner.
+			 */
+			if (__atomic_compare_exchange_n(&lock->full,
+							&old.full, new.full,
+							/* .weak */ false,
+							__ATOMIC_ACQUIRE,
+							__ATOMIC_RELAXED)) {
+
+				/* if we just set N_LOCK, we own it */
+				if (!(old.val & N_LOCK))
+					return;
+
+				/* go block */
+				break;
+			}
+		}
+
+		futex2_wait(lock, new.val, fflags, NULL, 0);
+	}
+}
+
+void futex_numa_32_unlock(struct futex_numa_32 *lock)
+{
+	u32 val = __atomic_sub_fetch(&lock->val, N_LOCK, __ATOMIC_RELEASE);
+	assert((s32)val >= 0);
+	if (val & N_WAITERS) {
+		int woken = futex2_wake(lock, 1, fflags);
+		assert(val == N_WAITERS);
+		if (!woken) {
+			__atomic_compare_exchange_n(&lock->val, &val, 0U,
+						    false, __ATOMIC_RELAXED,
+						    __ATOMIC_RELAXED);
+		}
+	}
+}
+
+static long nanos = 50000;
+
+struct thread_args {
+	pthread_t tid;
+	volatile int * done;
+	struct futex_numa_32 *lock;
+	int val;
+	int *val1, *val2;
+	int node;
+};
+
+static void *threadfn(void *_arg)
+{
+	struct thread_args *args = _arg;
+	struct timespec ts = {
+		.tv_nsec = nanos,
+	};
+	int node;
+
+	while (!*args->done) {
+
+		futex_numa_32_lock(args->lock);
+		args->val++;
+
+		assert(*args->val1 == *args->val2);
+		(*args->val1)++;
+		nanosleep(&ts, NULL);
+		(*args->val2)++;
+
+		node = args->lock->node;
+		futex_numa_32_unlock(args->lock);
+
+		if (node != args->node) {
+			args->node = node;
+			printf("node: %d\n", node);
+		}
+
+		nanosleep(&ts, NULL);
+	}
+
+	return NULL;
+}
+
+static void *contendfn(void *_arg)
+{
+	struct thread_args *args = _arg;
+
+	while (!*args->done) {
+		/*
+		 * futex2_wait() will take hb-lock, verify *var == val and
+		 * queue/abort.  By knowingly setting val 'wrong' this will
+		 * abort and thereby generate hb-lock contention.
+		 */
+		futex2_wait(&args->lock->val, ~0U, fflags, NULL, 0);
+		args->val++;
+	}
+
+	return NULL;
+}
+
+static volatile int done = 0;
+static struct futex_numa_32 lock = { .val = 0, };
+static int val1, val2;
+
+int main(int argc, char *argv[])
+{
+	struct thread_args *tas[512], *cas[512];
+	int c, t, threads = 2, contenders = 0;
+	int sleeps = 10;
+	int total = 0;
+
+	while ((c = getopt(argc, argv, "c:t:s:n:N::")) != -1) {
+		switch (c) {
+		case 'c':
+			contenders = atoi(optarg);
+			break;
+		case 't':
+			threads = atoi(optarg);
+			break;
+		case 's':
+			sleeps = atoi(optarg);
+			break;
+		case 'n':
+			nanos = atoi(optarg);
+			break;
+		case 'N':
+			fflags |= FUTEX2_NUMA;
+			if (optarg)
+				fnode = atoi(optarg);
+			break;
+		default:
+			exit(1);
+			break;
+		}
+	}
+
+	for (t = 0; t < contenders; t++) {
+		struct thread_args *args = calloc(1, sizeof(*args));
+		if (!args) {
+			perror("thread_args");
+			exit(-1);
+		}
+
+		args->done = &done;
+		args->lock = &lock;
+		args->val1 = &val1;
+		args->val2 = &val2;
+		args->node = -1;
+
+		if (pthread_create(&args->tid, NULL, contendfn, args)) {
+			perror("pthread_create");
+			exit(-1);
+		}
+
+		cas[t] = args;
+	}
+
+	for (t = 0; t < threads; t++) {
+		struct thread_args *args = calloc(1, sizeof(*args));
+		if (!args) {
+			perror("thread_args");
+			exit(-1);
+		}
+
+		args->done = &done;
+		args->lock = &lock;
+		args->val1 = &val1;
+		args->val2 = &val2;
+		args->node = -1;
+
+		if (pthread_create(&args->tid, NULL, threadfn, args)) {
+			perror("pthread_create");
+			exit(-1);
+		}
+
+		tas[t] = args;
+	}
+
+	sleep(sleeps);
+
+	done = true;
+
+	for (t = 0; t < threads; t++) {
+		struct thread_args *args = tas[t];
+
+		pthread_join(args->tid, NULL);
+		total += args->val;
+//		printf("tval: %d\n", args->val);
+	}
+	printf("total: %d\n", total);
+
+	if (contenders) {
+		total = 0;
+		for (t = 0; t < contenders; t++) {
+			struct thread_args *args = cas[t];
+
+			pthread_join(args->tid, NULL);
+			total += args->val;
+			//		printf("tval: %d\n", args->val);
+		}
+		printf("contenders: %d\n", total);
+	}
+
+	return 0;
+}
+

