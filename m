Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1993235B539
	for <lists+linux-tip-commits@lfdr.de>; Sun, 11 Apr 2021 15:49:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236228AbhDKNqF (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Sun, 11 Apr 2021 09:46:05 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:33032 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235683AbhDKNpK (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Sun, 11 Apr 2021 09:45:10 -0400
Date:   Sun, 11 Apr 2021 13:43:54 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1618148635;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=JUur16PbD67IJv2F1XX/Dx45KjmjW5WIEhWrdpx8dbw=;
        b=Ck7EUFo9aIcto4QNvnbGMRLUdI9/eI4snHKO4wzgLiIDQJkSbLlWu1Yeoy6SJoCZ5exoqp
        rXzyQpTA0OqzW5D2HLSbs6aI9DbmVa+dO53V7gfey2QCsqppi6OyhnsQcDfhAop+w0sC0b
        X7H8U8WDSXB8oT2RfLqfB7sxwR8oJZCX+npAPVq/h2vuKUYGEUpNUzcpvWmnL9pgA3KNPX
        R6TOAFGwtMpDwwecY0Zo/1paP5WOA9/MKTVcoXZtN/mUwUbNifIjV7b/WoMGJd7SPvwimO
        JMAdL0lYqyJ5LskH6QotZ5f6u7W0uypsCsL4QAcstZz7AvuriZ3fK3OP4fn3hQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1618148635;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=JUur16PbD67IJv2F1XX/Dx45KjmjW5WIEhWrdpx8dbw=;
        b=2gRZaHewD/NG7lz4Czb1H7L+ESLA8sA40MxM7WYc4dcOrsaTsVJQsCAVJX7hwBHZfd5uhO
        fzIsAVMHnd7b2TCw==
From:   "tip-bot2 for Marco Elver" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] kcsan: Switch to KUNIT_CASE_PARAM for parameterized tests
Cc:     David Gow <davidgow@google.com>, Marco Elver <elver@google.com>,
        "Paul E. McKenney" <paulmck@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <161814863471.29796.17786545880873772401.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     f6a149140321274cbd955dee50798fe191841f94
Gitweb:        https://git.kernel.org/tip/f6a149140321274cbd955dee50798fe191841f94
Author:        Marco Elver <elver@google.com>
AuthorDate:    Wed, 13 Jan 2021 17:05:57 +01:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Mon, 08 Mar 2021 14:27:43 -08:00

kcsan: Switch to KUNIT_CASE_PARAM for parameterized tests

Since KUnit now support parameterized tests via KUNIT_CASE_PARAM, update
KCSAN's test to switch to it for parameterized tests. This simplifies
parameterized tests and gets rid of the "parameters in case name"
workaround (hack).

At the same time, we can increase the maximum number of threads used,
because on systems with too few CPUs, KUnit allows us to now stop at the
maximum useful threads and not unnecessarily execute redundant test
cases with (the same) limited threads as had been the case before.

Reviewed-by: David Gow <davidgow@google.com>
Signed-off-by: Marco Elver <elver@google.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/kcsan/kcsan_test.c | 116 +++++++++++++++++--------------------
 1 file changed, 54 insertions(+), 62 deletions(-)

diff --git a/kernel/kcsan/kcsan_test.c b/kernel/kcsan/kcsan_test.c
index f16f632..b71751f 100644
--- a/kernel/kcsan/kcsan_test.c
+++ b/kernel/kcsan/kcsan_test.c
@@ -13,6 +13,8 @@
  * Author: Marco Elver <elver@google.com>
  */
 
+#define pr_fmt(fmt) "kcsan_test: " fmt
+
 #include <kunit/test.h>
 #include <linux/jiffies.h>
 #include <linux/kcsan-checks.h>
@@ -951,22 +953,53 @@ static void test_atomic_builtins(struct kunit *test)
 }
 
 /*
- * Each test case is run with different numbers of threads. Until KUnit supports
- * passing arguments for each test case, we encode #threads in the test case
- * name (read by get_num_threads()). [The '-' was chosen as a stylistic
- * preference to separate test name and #threads.]
+ * Generate thread counts for all test cases. Values generated are in interval
+ * [2, 5] followed by exponentially increasing thread counts from 8 to 32.
  *
  * The thread counts are chosen to cover potentially interesting boundaries and
- * corner cases (range 2-5), and then stress the system with larger counts.
+ * corner cases (2 to 5), and then stress the system with larger counts.
  */
-#define KCSAN_KUNIT_CASE(test_name)                                            \
-	{ .run_case = test_name, .name = #test_name "-02" },                   \
-	{ .run_case = test_name, .name = #test_name "-03" },                   \
-	{ .run_case = test_name, .name = #test_name "-04" },                   \
-	{ .run_case = test_name, .name = #test_name "-05" },                   \
-	{ .run_case = test_name, .name = #test_name "-08" },                   \
-	{ .run_case = test_name, .name = #test_name "-16" }
+static const void *nthreads_gen_params(const void *prev, char *desc)
+{
+	long nthreads = (long)prev;
+
+	if (nthreads < 0 || nthreads >= 32)
+		nthreads = 0; /* stop */
+	else if (!nthreads)
+		nthreads = 2; /* initial value */
+	else if (nthreads < 5)
+		nthreads++;
+	else if (nthreads == 5)
+		nthreads = 8;
+	else
+		nthreads *= 2;
 
+	if (!IS_ENABLED(CONFIG_PREEMPT) || !IS_ENABLED(CONFIG_KCSAN_INTERRUPT_WATCHER)) {
+		/*
+		 * Without any preemption, keep 2 CPUs free for other tasks, one
+		 * of which is the main test case function checking for
+		 * completion or failure.
+		 */
+		const long min_unused_cpus = IS_ENABLED(CONFIG_PREEMPT_NONE) ? 2 : 0;
+		const long min_required_cpus = 2 + min_unused_cpus;
+
+		if (num_online_cpus() < min_required_cpus) {
+			pr_err_once("Too few online CPUs (%u < %d) for test\n",
+				    num_online_cpus(), min_required_cpus);
+			nthreads = 0;
+		} else if (nthreads >= num_online_cpus() - min_unused_cpus) {
+			/* Use negative value to indicate last param. */
+			nthreads = -(num_online_cpus() - min_unused_cpus);
+			pr_warn_once("Limiting number of threads to %ld (only %d online CPUs)\n",
+				     -nthreads, num_online_cpus());
+		}
+	}
+
+	snprintf(desc, KUNIT_PARAM_DESC_SIZE, "threads=%ld", abs(nthreads));
+	return (void *)nthreads;
+}
+
+#define KCSAN_KUNIT_CASE(test_name) KUNIT_CASE_PARAM(test_name, nthreads_gen_params)
 static struct kunit_case kcsan_test_cases[] = {
 	KCSAN_KUNIT_CASE(test_basic),
 	KCSAN_KUNIT_CASE(test_concurrent_races),
@@ -996,24 +1029,6 @@ static struct kunit_case kcsan_test_cases[] = {
 
 /* ===== End test cases ===== */
 
-/* Get number of threads encoded in test name. */
-static bool __no_kcsan
-get_num_threads(const char *test, int *nthreads)
-{
-	int len = strlen(test);
-
-	if (WARN_ON(len < 3))
-		return false;
-
-	*nthreads = test[len - 1] - '0';
-	*nthreads += (test[len - 2] - '0') * 10;
-
-	if (WARN_ON(*nthreads < 0))
-		return false;
-
-	return true;
-}
-
 /* Concurrent accesses from interrupts. */
 __no_kcsan
 static void access_thread_timer(struct timer_list *timer)
@@ -1076,9 +1091,6 @@ static int test_init(struct kunit *test)
 	if (!torture_init_begin((char *)test->name, 1))
 		return -EBUSY;
 
-	if (!get_num_threads(test->name, &nthreads))
-		goto err;
-
 	if (WARN_ON(threads))
 		goto err;
 
@@ -1087,38 +1099,18 @@ static int test_init(struct kunit *test)
 			goto err;
 	}
 
-	if (!IS_ENABLED(CONFIG_PREEMPT) || !IS_ENABLED(CONFIG_KCSAN_INTERRUPT_WATCHER)) {
-		/*
-		 * Without any preemption, keep 2 CPUs free for other tasks, one
-		 * of which is the main test case function checking for
-		 * completion or failure.
-		 */
-		const int min_unused_cpus = IS_ENABLED(CONFIG_PREEMPT_NONE) ? 2 : 0;
-		const int min_required_cpus = 2 + min_unused_cpus;
+	nthreads = abs((long)test->param_value);
+	if (WARN_ON(!nthreads))
+		goto err;
 
-		if (num_online_cpus() < min_required_cpus) {
-			pr_err("%s: too few online CPUs (%u < %d) for test",
-			       test->name, num_online_cpus(), min_required_cpus);
-			goto err;
-		} else if (nthreads > num_online_cpus() - min_unused_cpus) {
-			nthreads = num_online_cpus() - min_unused_cpus;
-			pr_warn("%s: limiting number of threads to %d\n",
-				test->name, nthreads);
-		}
-	}
+	threads = kcalloc(nthreads + 1, sizeof(struct task_struct *), GFP_KERNEL);
+	if (WARN_ON(!threads))
+		goto err;
 
-	if (nthreads) {
-		threads = kcalloc(nthreads + 1, sizeof(struct task_struct *),
-				  GFP_KERNEL);
-		if (WARN_ON(!threads))
+	threads[nthreads] = NULL;
+	for (i = 0; i < nthreads; ++i) {
+		if (torture_create_kthread(access_thread, NULL, threads[i]))
 			goto err;
-
-		threads[nthreads] = NULL;
-		for (i = 0; i < nthreads; ++i) {
-			if (torture_create_kthread(access_thread, NULL,
-						   threads[i]))
-				goto err;
-		}
 	}
 
 	torture_init_end();
