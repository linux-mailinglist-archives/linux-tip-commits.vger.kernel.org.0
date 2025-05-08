Return-Path: <linux-tip-commits+bounces-5467-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 46FFEAAF7E6
	for <lists+linux-tip-commits@lfdr.de>; Thu,  8 May 2025 12:34:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5B0BD1C06B2F
	for <lists+linux-tip-commits@lfdr.de>; Thu,  8 May 2025 10:34:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30E60221D88;
	Thu,  8 May 2025 10:33:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="e9wninQD";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="M/6jZMbc"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8D0A2144C4;
	Thu,  8 May 2025 10:33:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746700432; cv=none; b=lpRnWwCGsxVcpWZAi5umam3Z1T/q64aSpQaks1p9Iy67gyQTdIL89BzUdaqWnMzwmGCRE4PYDS2BtviaOp5ZxrUXKtREAdx9+EzmWB28gIYAuG7uK1NKTP64FSEZA9lZdqixDqexJyVLUxn5DqT5zalSocvksqzMSwpqhvHKTfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746700432; c=relaxed/simple;
	bh=OIGa146cQbqlutmSl+M+Sbqa1bgHAv010BQWYAoMBUo=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=a6yOj0/2asf55D++irF8zqGt+4MyDn+rzy6TV8hrwW76dJYR6uM4WWcbVw7RITx7DocaUkaM4Cd6yDRlaM4StRH5r/GuNezA+zjzwtNtpmsGUF+zw9KUDa9Q0BfjJDPb/WP+lKVi0h/k1mMuOsVpENGXlJr1r6+hTr7s+HT8bBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=e9wninQD; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=M/6jZMbc; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 08 May 2025 10:33:47 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1746700428;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oGieV+ae18h5GYXRoYrEC5O/1ArQmOze1knQwtxCCaA=;
	b=e9wninQDt8h+ozNW8J5rinhdgLZImKIeBw+gJCESGSvL8cDVx2xle9doMvHIcsY/6Fuz95
	jxL0GSwYemOXV1Dpi5ew1o9Crpr/eHekImLFpubDHooOznncoSQLQvL2LF/ntq7TxnlOaK
	8iIgQmxrmf1qJnPG3PIrwVDS9ckWLoZ5Tfzy9tJlPTZGQg+jBTI2vG7BbRekEaUDxbO1Zw
	QgIGsPXtZZ4z+43bpKkbf3RFeF8VlWnuV4WDWMluNF/1Py1h1yZGSqNVYqnILgFfAWWIem
	26mdxPagh6Vk9yijwoUpp5/OxzSDH0Uq74blS4LgrNB/tUn7t00Tsoc5LsrQqw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1746700428;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oGieV+ae18h5GYXRoYrEC5O/1ArQmOze1knQwtxCCaA=;
	b=M/6jZMbchlYexXw/ybfQgL2wT+e/GBXUgQDerZf2dEoIDtinU42IV3z8z/SeSnsniKqJqv
	uON138CtcKi3WFCQ==
From: "tip-bot2 for Sebastian Andrzej Siewior" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: locking/futex] tools/perf: Allow to select the number of hash buckets
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250416162921.513656-20-bigeasy@linutronix.de>
References: <20250416162921.513656-20-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174670042723.406.13985740022634140204.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the locking/futex branch of tip:

Commit-ID:     60035a3981a7f9d965df81a48a07b94e52ccd54f
Gitweb:        https://git.kernel.org/tip/60035a3981a7f9d965df81a48a07b94e52ccd54f
Author:        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
AuthorDate:    Wed, 16 Apr 2025 18:29:19 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Sat, 03 May 2025 12:02:10 +02:00

tools/perf: Allow to select the number of hash buckets

Add the -b/ --buckets argument to specify the number of hash buckets for
the private futex hash. This is directly passed to
    prctl(PR_FUTEX_HASH, PR_FUTEX_HASH_SET_SLOTS, buckets, immutable)

and must return without an error if specified. The `immutable' is 0 by
default and can be set to 1 via the -I/ --immutable argument.
The size of the private hash is verified with PR_FUTEX_HASH_GET_SLOTS.
If PR_FUTEX_HASH_GET_SLOTS failed then it is assumed that an older
kernel was used without the support and that the global hash is used.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/r/20250416162921.513656-20-bigeasy@linutronix.de
---
 tools/perf/bench/Build                 |  1 +-
 tools/perf/bench/futex-hash.c          |  7 +++-
 tools/perf/bench/futex-lock-pi.c       |  5 ++-
 tools/perf/bench/futex-requeue.c       |  6 ++-
 tools/perf/bench/futex-wake-parallel.c |  9 ++-
 tools/perf/bench/futex-wake.c          |  4 ++-
 tools/perf/bench/futex.c               | 65 +++++++++++++++++++++++++-
 tools/perf/bench/futex.h               |  5 ++-
 8 files changed, 101 insertions(+), 1 deletion(-)
 create mode 100644 tools/perf/bench/futex.c

diff --git a/tools/perf/bench/Build b/tools/perf/bench/Build
index 279ab2a..b558ab9 100644
--- a/tools/perf/bench/Build
+++ b/tools/perf/bench/Build
@@ -3,6 +3,7 @@ perf-bench-y += sched-pipe.o
 perf-bench-y += sched-seccomp-notify.o
 perf-bench-y += syscall.o
 perf-bench-y += mem-functions.o
+perf-bench-y += futex.o
 perf-bench-y += futex-hash.o
 perf-bench-y += futex-wake.o
 perf-bench-y += futex-wake-parallel.o
diff --git a/tools/perf/bench/futex-hash.c b/tools/perf/bench/futex-hash.c
index b472ede..fdf133c 100644
--- a/tools/perf/bench/futex-hash.c
+++ b/tools/perf/bench/futex-hash.c
@@ -18,9 +18,11 @@
 #include <stdlib.h>
 #include <linux/compiler.h>
 #include <linux/kernel.h>
+#include <linux/prctl.h>
 #include <linux/zalloc.h>
 #include <sys/time.h>
 #include <sys/mman.h>
+#include <sys/prctl.h>
 #include <perf/cpumap.h>
 
 #include "../util/mutex.h"
@@ -50,9 +52,12 @@ struct worker {
 static struct bench_futex_parameters params = {
 	.nfutexes = 1024,
 	.runtime  = 10,
+	.nbuckets = -1,
 };
 
 static const struct option options[] = {
+	OPT_INTEGER( 'b', "buckets", &params.nbuckets, "Specify amount of hash buckets"),
+	OPT_BOOLEAN( 'I', "immutable", &params.buckets_immutable, "Make the hash buckets immutable"),
 	OPT_UINTEGER('t', "threads", &params.nthreads, "Specify amount of threads"),
 	OPT_UINTEGER('r', "runtime", &params.runtime, "Specify runtime (in seconds)"),
 	OPT_UINTEGER('f', "futexes", &params.nfutexes, "Specify amount of futexes per threads"),
@@ -118,6 +123,7 @@ static void print_summary(void)
 	printf("%sAveraged %ld operations/sec (+- %.2f%%), total secs = %d\n",
 	       !params.silent ? "\n" : "", avg, rel_stddev_stats(stddev, avg),
 	       (int)bench__runtime.tv_sec);
+	futex_print_nbuckets(&params);
 }
 
 int bench_futex_hash(int argc, const char **argv)
@@ -161,6 +167,7 @@ int bench_futex_hash(int argc, const char **argv)
 
 	if (!params.fshared)
 		futex_flag = FUTEX_PRIVATE_FLAG;
+	futex_set_nbuckets_param(&params);
 
 	printf("Run summary [PID %d]: %d threads, each operating on %d [%s] futexes for %d secs.\n\n",
 	       getpid(), params.nthreads, params.nfutexes, params.fshared ? "shared":"private", params.runtime);
diff --git a/tools/perf/bench/futex-lock-pi.c b/tools/perf/bench/futex-lock-pi.c
index 0416120..5144a15 100644
--- a/tools/perf/bench/futex-lock-pi.c
+++ b/tools/perf/bench/futex-lock-pi.c
@@ -41,10 +41,13 @@ static struct stats throughput_stats;
 static struct cond thread_parent, thread_worker;
 
 static struct bench_futex_parameters params = {
+	.nbuckets = -1,
 	.runtime  = 10,
 };
 
 static const struct option options[] = {
+	OPT_INTEGER( 'b', "buckets", &params.nbuckets, "Specify amount of hash buckets"),
+	OPT_BOOLEAN( 'I', "immutable", &params.buckets_immutable, "Make the hash buckets immutable"),
 	OPT_UINTEGER('t', "threads", &params.nthreads, "Specify amount of threads"),
 	OPT_UINTEGER('r', "runtime", &params.runtime, "Specify runtime (in seconds)"),
 	OPT_BOOLEAN( 'M', "multi",   &params.multi, "Use multiple futexes"),
@@ -67,6 +70,7 @@ static void print_summary(void)
 	printf("%sAveraged %ld operations/sec (+- %.2f%%), total secs = %d\n",
 	       !params.silent ? "\n" : "", avg, rel_stddev_stats(stddev, avg),
 	       (int)bench__runtime.tv_sec);
+	futex_print_nbuckets(&params);
 }
 
 static void toggle_done(int sig __maybe_unused,
@@ -203,6 +207,7 @@ int bench_futex_lock_pi(int argc, const char **argv)
 	mutex_init(&thread_lock);
 	cond_init(&thread_parent);
 	cond_init(&thread_worker);
+	futex_set_nbuckets_param(&params);
 
 	threads_starting = params.nthreads;
 	gettimeofday(&bench__start, NULL);
diff --git a/tools/perf/bench/futex-requeue.c b/tools/perf/bench/futex-requeue.c
index aad5bfc..a2f91ee 100644
--- a/tools/perf/bench/futex-requeue.c
+++ b/tools/perf/bench/futex-requeue.c
@@ -42,6 +42,7 @@ static unsigned int threads_starting;
 static int futex_flag = 0;
 
 static struct bench_futex_parameters params = {
+	.nbuckets = -1,
 	/*
 	 * How many tasks to requeue at a time.
 	 * Default to 1 in order to make the kernel work more.
@@ -50,6 +51,8 @@ static struct bench_futex_parameters params = {
 };
 
 static const struct option options[] = {
+	OPT_INTEGER( 'b', "buckets", &params.nbuckets, "Specify amount of hash buckets"),
+	OPT_BOOLEAN( 'I', "immutable", &params.buckets_immutable, "Make the hash buckets immutable"),
 	OPT_UINTEGER('t', "threads",  &params.nthreads, "Specify amount of threads"),
 	OPT_UINTEGER('q', "nrequeue", &params.nrequeue, "Specify amount of threads to requeue at once"),
 	OPT_BOOLEAN( 's', "silent",   &params.silent, "Silent mode: do not display data/details"),
@@ -77,6 +80,7 @@ static void print_summary(void)
 	       params.nthreads,
 	       requeuetime_avg / USEC_PER_MSEC,
 	       rel_stddev_stats(requeuetime_stddev, requeuetime_avg));
+	futex_print_nbuckets(&params);
 }
 
 static void *workerfn(void *arg __maybe_unused)
@@ -204,6 +208,8 @@ int bench_futex_requeue(int argc, const char **argv)
 	if (params.broadcast)
 		params.nrequeue = params.nthreads;
 
+	futex_set_nbuckets_param(&params);
+
 	printf("Run summary [PID %d]: Requeuing %d threads (from [%s] %p to %s%p), "
 	       "%d at a time.\n\n",  getpid(), params.nthreads,
 	       params.fshared ? "shared":"private", &futex1,
diff --git a/tools/perf/bench/futex-wake-parallel.c b/tools/perf/bench/futex-wake-parallel.c
index 4352e31..ee66482 100644
--- a/tools/perf/bench/futex-wake-parallel.c
+++ b/tools/perf/bench/futex-wake-parallel.c
@@ -57,9 +57,13 @@ static struct stats waketime_stats, wakeup_stats;
 static unsigned int threads_starting;
 static int futex_flag = 0;
 
-static struct bench_futex_parameters params;
+static struct bench_futex_parameters params = {
+	.nbuckets = -1,
+};
 
 static const struct option options[] = {
+	OPT_INTEGER( 'b', "buckets", &params.nbuckets, "Specify amount of hash buckets"),
+	OPT_BOOLEAN( 'I', "immutable", &params.buckets_immutable, "Make the hash buckets immutable"),
 	OPT_UINTEGER('t', "threads", &params.nthreads, "Specify amount of threads"),
 	OPT_UINTEGER('w', "nwakers", &params.nwakes, "Specify amount of waking threads"),
 	OPT_BOOLEAN( 's', "silent",  &params.silent, "Silent mode: do not display data/details"),
@@ -218,6 +222,7 @@ static void print_summary(void)
 	       params.nthreads,
 	       waketime_avg / USEC_PER_MSEC,
 	       rel_stddev_stats(waketime_stddev, waketime_avg));
+	futex_print_nbuckets(&params);
 }
 
 
@@ -291,6 +296,8 @@ int bench_futex_wake_parallel(int argc, const char **argv)
 	if (!params.fshared)
 		futex_flag = FUTEX_PRIVATE_FLAG;
 
+	futex_set_nbuckets_param(&params);
+
 	printf("Run summary [PID %d]: blocking on %d threads (at [%s] "
 	       "futex %p), %d threads waking up %d at a time.\n\n",
 	       getpid(), params.nthreads, params.fshared ? "shared":"private",
diff --git a/tools/perf/bench/futex-wake.c b/tools/perf/bench/futex-wake.c
index 49b3c89..8d6107f 100644
--- a/tools/perf/bench/futex-wake.c
+++ b/tools/perf/bench/futex-wake.c
@@ -42,6 +42,7 @@ static unsigned int threads_starting;
 static int futex_flag = 0;
 
 static struct bench_futex_parameters params = {
+	.nbuckets = -1,
 	/*
 	 * How many wakeups to do at a time.
 	 * Default to 1 in order to make the kernel work more.
@@ -50,6 +51,8 @@ static struct bench_futex_parameters params = {
 };
 
 static const struct option options[] = {
+	OPT_INTEGER( 'b', "buckets", &params.nbuckets, "Specify amount of hash buckets"),
+	OPT_BOOLEAN( 'I', "immutable", &params.buckets_immutable, "Make the hash buckets immutable"),
 	OPT_UINTEGER('t', "threads", &params.nthreads, "Specify amount of threads"),
 	OPT_UINTEGER('w', "nwakes",  &params.nwakes, "Specify amount of threads to wake at once"),
 	OPT_BOOLEAN( 's', "silent",  &params.silent, "Silent mode: do not display data/details"),
@@ -93,6 +96,7 @@ static void print_summary(void)
 	       params.nthreads,
 	       waketime_avg / USEC_PER_MSEC,
 	       rel_stddev_stats(waketime_stddev, waketime_avg));
+	futex_print_nbuckets(&params);
 }
 
 static void block_threads(pthread_t *w, struct perf_cpu_map *cpu)
diff --git a/tools/perf/bench/futex.c b/tools/perf/bench/futex.c
new file mode 100644
index 0000000..02ae6c5
--- /dev/null
+++ b/tools/perf/bench/futex.c
@@ -0,0 +1,65 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <err.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <linux/prctl.h>
+#include <sys/prctl.h>
+
+#include "futex.h"
+
+void futex_set_nbuckets_param(struct bench_futex_parameters *params)
+{
+	int ret;
+
+	if (params->nbuckets < 0)
+		return;
+
+	ret = prctl(PR_FUTEX_HASH, PR_FUTEX_HASH_SET_SLOTS, params->nbuckets, params->buckets_immutable);
+	if (ret) {
+		printf("Requesting %d hash buckets failed: %d/%m\n",
+		       params->nbuckets, ret);
+		err(EXIT_FAILURE, "prctl(PR_FUTEX_HASH)");
+	}
+}
+
+void futex_print_nbuckets(struct bench_futex_parameters *params)
+{
+	char *futex_hash_mode;
+	int ret;
+
+	ret = prctl(PR_FUTEX_HASH, PR_FUTEX_HASH_GET_SLOTS);
+	if (params->nbuckets >= 0) {
+		if (ret != params->nbuckets) {
+			if (ret < 0) {
+				printf("Can't query number of buckets: %m\n");
+				err(EXIT_FAILURE, "prctl(PR_FUTEX_HASH)");
+			}
+			printf("Requested number of hash buckets does not currently used.\n");
+			printf("Requested: %d in usage: %d\n", params->nbuckets, ret);
+			err(EXIT_FAILURE, "prctl(PR_FUTEX_HASH)");
+		}
+		if (params->nbuckets == 0) {
+			ret = asprintf(&futex_hash_mode, "Futex hashing: global hash");
+		} else {
+			ret = prctl(PR_FUTEX_HASH, PR_FUTEX_HASH_GET_IMMUTABLE);
+			if (ret < 0) {
+				printf("Can't check if the hash is immutable: %m\n");
+				err(EXIT_FAILURE, "prctl(PR_FUTEX_HASH)");
+			}
+			ret = asprintf(&futex_hash_mode, "Futex hashing: %d hash buckets %s",
+				       params->nbuckets,
+				       ret == 1 ? "(immutable)" : "");
+		}
+	} else {
+		if (ret <= 0) {
+			ret = asprintf(&futex_hash_mode, "Futex hashing: global hash");
+		} else {
+			ret = asprintf(&futex_hash_mode, "Futex hashing: auto resized to %d buckets",
+				       ret);
+		}
+	}
+	if (ret < 0)
+		err(EXIT_FAILURE, "ENOMEM, futex_hash_mode");
+	printf("%s\n", futex_hash_mode);
+	free(futex_hash_mode);
+}
diff --git a/tools/perf/bench/futex.h b/tools/perf/bench/futex.h
index ebdc2b0..9c9a73f 100644
--- a/tools/perf/bench/futex.h
+++ b/tools/perf/bench/futex.h
@@ -25,6 +25,8 @@ struct bench_futex_parameters {
 	unsigned int nfutexes;
 	unsigned int nwakes;
 	unsigned int nrequeue;
+	int nbuckets;
+	bool buckets_immutable;
 };
 
 /**
@@ -143,4 +145,7 @@ futex_cmp_requeue_pi(u_int32_t *uaddr, u_int32_t val, u_int32_t *uaddr2,
 					val, opflags);
 }
 
+void futex_set_nbuckets_param(struct bench_futex_parameters *params);
+void futex_print_nbuckets(struct bench_futex_parameters *params);
+
 #endif /* _FUTEX_H */

