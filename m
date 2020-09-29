Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2AA8F27BE87
	for <lists+linux-tip-commits@lfdr.de>; Tue, 29 Sep 2020 09:57:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727653AbgI2H4w (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Tue, 29 Sep 2020 03:56:52 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:44352 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727484AbgI2H4v (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Tue, 29 Sep 2020 03:56:51 -0400
Date:   Tue, 29 Sep 2020 07:56:46 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1601366207;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=h07DlkCi9A3A/nWY/LwUmSrlCEq+f166PIWhtfsUbb0=;
        b=4vdOoSI8AK2EHLJLUQEMNGpmXQZcMYsWzznOkPIHpUR/cRDVJo5QosuKwNiVORw1lX0FQI
        LCk+vhTg31YaRxwhc4G+NiWueNn5IDnpbYqUswg6oJRdB0B/Mv/+qIHnAXPjChstgeejNf
        dtQTBAZ/nlo58cux80AI3CYz8OUEmQqeE/+oHwfsQz2Z6jyhIL2S2FFgaFs/DPnmqrS5qG
        xzemKEXwQGxe882GhtdmLU3CmsTTlXWSj/V2S5RbFxR3Up7lib0VWTF7hL41QHIMR7728G
        q4YvNVcil0UJfLL/agW6uEQhHhm894ZvOYwjNVZSBs/YbmZ9mYjz4HKnS4C58Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1601366207;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=h07DlkCi9A3A/nWY/LwUmSrlCEq+f166PIWhtfsUbb0=;
        b=kAji2NG2IIDlRnfjrkwt+qkeS9kxCr0b0yybWNEDHQnRqWgIrGtslEOG+mVjb2oawoeTVQ
        K8G/SOBv1SrFObBg==
From:   "tip-bot2 for Peter Oskolkov" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] rseq/selftests: Test MEMBARRIER_CMD_PRIVATE_EXPEDITED_RSEQ
Cc:     Peter Oskolkov <posk@google.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200923233618.2572849-3-posk@google.com>
References: <20200923233618.2572849-3-posk@google.com>
MIME-Version: 1.0
Message-ID: <160136620672.7002.7894847614657872856.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     f166b111e0491486fca0d105f09655ab718bd1c8
Gitweb:        https://git.kernel.org/tip/f166b111e0491486fca0d105f09655ab718bd1c8
Author:        Peter Oskolkov <posk@google.com>
AuthorDate:    Wed, 23 Sep 2020 16:36:18 -07:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 25 Sep 2020 14:23:27 +02:00

rseq/selftests: Test MEMBARRIER_CMD_PRIVATE_EXPEDITED_RSEQ

Based on Google-internal RSEQ work done by Paul Turner and Andrew
Hunter.

This patch adds a selftest for MEMBARRIER_CMD_PRIVATE_EXPEDITED_RSEQ.
The test quite often fails without the previous patch in this
patchset, but consistently passes with it.

Signed-off-by: Peter Oskolkov <posk@google.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Link: https://lkml.kernel.org/r/20200923233618.2572849-3-posk@google.com
---
 tools/testing/selftests/rseq/param_test.c      | 223 +++++++++++++++-
 tools/testing/selftests/rseq/run_param_test.sh |   2 +-
 2 files changed, 224 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/rseq/param_test.c b/tools/testing/selftests/rseq/param_test.c
index e8a657a..3845890 100644
--- a/tools/testing/selftests/rseq/param_test.c
+++ b/tools/testing/selftests/rseq/param_test.c
@@ -1,8 +1,10 @@
 // SPDX-License-Identifier: LGPL-2.1
 #define _GNU_SOURCE
 #include <assert.h>
+#include <linux/membarrier.h>
 #include <pthread.h>
 #include <sched.h>
+#include <stdatomic.h>
 #include <stdint.h>
 #include <stdio.h>
 #include <stdlib.h>
@@ -1131,6 +1133,220 @@ static int set_signal_handler(void)
 	return ret;
 }
 
+struct test_membarrier_thread_args {
+	int stop;
+	intptr_t percpu_list_ptr;
+};
+
+/* Worker threads modify data in their "active" percpu lists. */
+void *test_membarrier_worker_thread(void *arg)
+{
+	struct test_membarrier_thread_args *args =
+		(struct test_membarrier_thread_args *)arg;
+	const int iters = opt_reps;
+	int i;
+
+	if (rseq_register_current_thread()) {
+		fprintf(stderr, "Error: rseq_register_current_thread(...) failed(%d): %s\n",
+			errno, strerror(errno));
+		abort();
+	}
+
+	/* Wait for initialization. */
+	while (!atomic_load(&args->percpu_list_ptr)) {}
+
+	for (i = 0; i < iters; ++i) {
+		int ret;
+
+		do {
+			int cpu = rseq_cpu_start();
+
+			ret = rseq_offset_deref_addv(&args->percpu_list_ptr,
+				sizeof(struct percpu_list_entry) * cpu, 1, cpu);
+		} while (rseq_unlikely(ret));
+	}
+
+	if (rseq_unregister_current_thread()) {
+		fprintf(stderr, "Error: rseq_unregister_current_thread(...) failed(%d): %s\n",
+			errno, strerror(errno));
+		abort();
+	}
+	return NULL;
+}
+
+void test_membarrier_init_percpu_list(struct percpu_list *list)
+{
+	int i;
+
+	memset(list, 0, sizeof(*list));
+	for (i = 0; i < CPU_SETSIZE; i++) {
+		struct percpu_list_node *node;
+
+		node = malloc(sizeof(*node));
+		assert(node);
+		node->data = 0;
+		node->next = NULL;
+		list->c[i].head = node;
+	}
+}
+
+void test_membarrier_free_percpu_list(struct percpu_list *list)
+{
+	int i;
+
+	for (i = 0; i < CPU_SETSIZE; i++)
+		free(list->c[i].head);
+}
+
+static int sys_membarrier(int cmd, int flags, int cpu_id)
+{
+	return syscall(__NR_membarrier, cmd, flags, cpu_id);
+}
+
+/*
+ * The manager thread swaps per-cpu lists that worker threads see,
+ * and validates that there are no unexpected modifications.
+ */
+void *test_membarrier_manager_thread(void *arg)
+{
+	struct test_membarrier_thread_args *args =
+		(struct test_membarrier_thread_args *)arg;
+	struct percpu_list list_a, list_b;
+	intptr_t expect_a = 0, expect_b = 0;
+	int cpu_a = 0, cpu_b = 0;
+
+	if (rseq_register_current_thread()) {
+		fprintf(stderr, "Error: rseq_register_current_thread(...) failed(%d): %s\n",
+			errno, strerror(errno));
+		abort();
+	}
+
+	/* Init lists. */
+	test_membarrier_init_percpu_list(&list_a);
+	test_membarrier_init_percpu_list(&list_b);
+
+	atomic_store(&args->percpu_list_ptr, (intptr_t)&list_a);
+
+	while (!atomic_load(&args->stop)) {
+		/* list_a is "active". */
+		cpu_a = rand() % CPU_SETSIZE;
+		/*
+		 * As list_b is "inactive", we should never see changes
+		 * to list_b.
+		 */
+		if (expect_b != atomic_load(&list_b.c[cpu_b].head->data)) {
+			fprintf(stderr, "Membarrier test failed\n");
+			abort();
+		}
+
+		/* Make list_b "active". */
+		atomic_store(&args->percpu_list_ptr, (intptr_t)&list_b);
+		if (sys_membarrier(MEMBARRIER_CMD_PRIVATE_EXPEDITED_RSEQ,
+					MEMBARRIER_CMD_FLAG_CPU, cpu_a) &&
+				errno != ENXIO /* missing CPU */) {
+			perror("sys_membarrier");
+			abort();
+		}
+		/*
+		 * Cpu A should now only modify list_b, so the values
+		 * in list_a should be stable.
+		 */
+		expect_a = atomic_load(&list_a.c[cpu_a].head->data);
+
+		cpu_b = rand() % CPU_SETSIZE;
+		/*
+		 * As list_a is "inactive", we should never see changes
+		 * to list_a.
+		 */
+		if (expect_a != atomic_load(&list_a.c[cpu_a].head->data)) {
+			fprintf(stderr, "Membarrier test failed\n");
+			abort();
+		}
+
+		/* Make list_a "active". */
+		atomic_store(&args->percpu_list_ptr, (intptr_t)&list_a);
+		if (sys_membarrier(MEMBARRIER_CMD_PRIVATE_EXPEDITED_RSEQ,
+					MEMBARRIER_CMD_FLAG_CPU, cpu_b) &&
+				errno != ENXIO /* missing CPU*/) {
+			perror("sys_membarrier");
+			abort();
+		}
+		/* Remember a value from list_b. */
+		expect_b = atomic_load(&list_b.c[cpu_b].head->data);
+	}
+
+	test_membarrier_free_percpu_list(&list_a);
+	test_membarrier_free_percpu_list(&list_b);
+
+	if (rseq_unregister_current_thread()) {
+		fprintf(stderr, "Error: rseq_unregister_current_thread(...) failed(%d): %s\n",
+			errno, strerror(errno));
+		abort();
+	}
+	return NULL;
+}
+
+/* Test MEMBARRIER_CMD_PRIVATE_RESTART_RSEQ_ON_CPU membarrier command. */
+#ifdef RSEQ_ARCH_HAS_OFFSET_DEREF_ADDV
+void test_membarrier(void)
+{
+	const int num_threads = opt_threads;
+	struct test_membarrier_thread_args thread_args;
+	pthread_t worker_threads[num_threads];
+	pthread_t manager_thread;
+	int i, ret;
+
+	if (sys_membarrier(MEMBARRIER_CMD_REGISTER_PRIVATE_EXPEDITED_RSEQ, 0, 0)) {
+		perror("sys_membarrier");
+		abort();
+	}
+
+	thread_args.stop = 0;
+	thread_args.percpu_list_ptr = 0;
+	ret = pthread_create(&manager_thread, NULL,
+			test_membarrier_manager_thread, &thread_args);
+	if (ret) {
+		errno = ret;
+		perror("pthread_create");
+		abort();
+	}
+
+	for (i = 0; i < num_threads; i++) {
+		ret = pthread_create(&worker_threads[i], NULL,
+				test_membarrier_worker_thread, &thread_args);
+		if (ret) {
+			errno = ret;
+			perror("pthread_create");
+			abort();
+		}
+	}
+
+
+	for (i = 0; i < num_threads; i++) {
+		ret = pthread_join(worker_threads[i], NULL);
+		if (ret) {
+			errno = ret;
+			perror("pthread_join");
+			abort();
+		}
+	}
+
+	atomic_store(&thread_args.stop, 1);
+	ret = pthread_join(manager_thread, NULL);
+	if (ret) {
+		errno = ret;
+		perror("pthread_join");
+		abort();
+	}
+}
+#else /* RSEQ_ARCH_HAS_OFFSET_DEREF_ADDV */
+void test_membarrier(void)
+{
+	fprintf(stderr, "rseq_offset_deref_addv is not implemented on this architecture. "
+			"Skipping membarrier test.\n");
+}
+#endif
+
 static void show_usage(int argc, char **argv)
 {
 	printf("Usage : %s <OPTIONS>\n",
@@ -1153,7 +1369,7 @@ static void show_usage(int argc, char **argv)
 	printf("	[-r N] Number of repetitions per thread (default 5000)\n");
 	printf("	[-d] Disable rseq system call (no initialization)\n");
 	printf("	[-D M] Disable rseq for each M threads\n");
-	printf("	[-T test] Choose test: (s)pinlock, (l)ist, (b)uffer, (m)emcpy, (i)ncrement\n");
+	printf("	[-T test] Choose test: (s)pinlock, (l)ist, (b)uffer, (m)emcpy, (i)ncrement, membarrie(r)\n");
 	printf("	[-M] Push into buffer and memcpy buffer with memory barriers.\n");
 	printf("	[-v] Verbose output.\n");
 	printf("	[-h] Show this help.\n");
@@ -1268,6 +1484,7 @@ int main(int argc, char **argv)
 			case 'i':
 			case 'b':
 			case 'm':
+			case 'r':
 				break;
 			default:
 				show_usage(argc, argv);
@@ -1320,6 +1537,10 @@ int main(int argc, char **argv)
 		printf_verbose("counter increment\n");
 		test_percpu_inc();
 		break;
+	case 'r':
+		printf_verbose("membarrier\n");
+		test_membarrier();
+		break;
 	}
 	if (!opt_disable_rseq && rseq_unregister_current_thread())
 		abort();
diff --git a/tools/testing/selftests/rseq/run_param_test.sh b/tools/testing/selftests/rseq/run_param_test.sh
index e426304..f51bc83 100755
--- a/tools/testing/selftests/rseq/run_param_test.sh
+++ b/tools/testing/selftests/rseq/run_param_test.sh
@@ -15,6 +15,7 @@ TEST_LIST=(
 	"-T m"
 	"-T m -M"
 	"-T i"
+	"-T r"
 )
 
 TEST_NAME=(
@@ -25,6 +26,7 @@ TEST_NAME=(
 	"memcpy"
 	"memcpy with barrier"
 	"increment"
+	"membarrier"
 )
 IFS="$OLDIFS"
 
