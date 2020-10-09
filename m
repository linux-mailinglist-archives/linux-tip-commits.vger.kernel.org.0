Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C0BE3288439
	for <lists+linux-tip-commits@lfdr.de>; Fri,  9 Oct 2020 10:00:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732601AbgJIH7e (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 9 Oct 2020 03:59:34 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:56244 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732492AbgJIH6y (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 9 Oct 2020 03:58:54 -0400
Date:   Fri, 09 Oct 2020 07:58:50 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1602230331;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=rso/ltSAJ/sz77ox1RHGYYD11K4Ed+muEn7ip6Dxmhc=;
        b=S3pOGVTl+QT4bbx6DRz3DWIEyMnQr7H7LYRtveRzwlnsF/yT3R6k/QQaZ336QLUIXEJ0p9
        2ys1/UewvP9Yj7/S1Tb9LxxMllN+wr5ngQAfRQ6q2sRq5uZHS+IZKGUNy+4Mv850TvgkVU
        WVCyK78pDFN/skknGz6eqKVwXc8u5/Pj3OorVLiejNaGd+ki5KPaF8OTo5bhXibZKgVfac
        pwnwFpBmmsL2Qx2/BaJuMa3OZgjG2mFuuyWpoQA13WyRYtF65MrrWk3/K7WiP2cy5b3hJd
        jXaWRz33HlNDx3xEuPUdB0Z/Y9ppnrub/Rn4vKHs5dlbP4RSZjAin7Z9t1bgzQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1602230331;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=rso/ltSAJ/sz77ox1RHGYYD11K4Ed+muEn7ip6Dxmhc=;
        b=/eB+mM9979n9sYv86QDAYOO+g/8wamwIU/rEiaxMxifSP4Cojk1G4Ph6eV5ZVB6JRVzd7I
        2kRBoKh68VAj96Ag==
From:   "tip-bot2 for Marco Elver" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] kcsan: Test support for compound instrumentation
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Marco Elver <elver@google.com>,
        "Paul E. McKenney" <paulmck@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <160223033066.7002.6713001500945527012.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     bec4a2474890a6884eb890c778ea02bccaaae6eb
Gitweb:        https://git.kernel.org/tip/bec4a2474890a6884eb890c778ea02bccaaae6eb
Author:        Marco Elver <elver@google.com>
AuthorDate:    Fri, 24 Jul 2020 09:00:05 +02:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Mon, 24 Aug 2020 15:09:58 -07:00

kcsan: Test support for compound instrumentation

Changes kcsan-test module to support checking reports that include
compound instrumentation. Since we should not fail the test if this
support is unavailable, we have to add a config variable that the test
can use to decide what to check for.

Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Marco Elver <elver@google.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/kcsan/kcsan-test.c | 65 +++++++++++++++++++++++++++++---------
 lib/Kconfig.kcsan         |  5 +++-
 2 files changed, 56 insertions(+), 14 deletions(-)

diff --git a/kernel/kcsan/kcsan-test.c b/kernel/kcsan/kcsan-test.c
index 721180c..ebe7fd2 100644
--- a/kernel/kcsan/kcsan-test.c
+++ b/kernel/kcsan/kcsan-test.c
@@ -27,6 +27,12 @@
 #include <linux/types.h>
 #include <trace/events/printk.h>
 
+#ifdef CONFIG_CC_HAS_TSAN_COMPOUND_READ_BEFORE_WRITE
+#define __KCSAN_ACCESS_RW(alt) (KCSAN_ACCESS_COMPOUND | KCSAN_ACCESS_WRITE)
+#else
+#define __KCSAN_ACCESS_RW(alt) (alt)
+#endif
+
 /* Points to current test-case memory access "kernels". */
 static void (*access_kernels[2])(void);
 
@@ -186,20 +192,21 @@ static bool report_matches(const struct expect_report *r)
 
 	/* Access 1 & 2 */
 	for (i = 0; i < 2; ++i) {
+		const int ty = r->access[i].type;
 		const char *const access_type =
-			(r->access[i].type & KCSAN_ACCESS_ASSERT) ?
-				((r->access[i].type & KCSAN_ACCESS_WRITE) ?
-					 "assert no accesses" :
-					 "assert no writes") :
-				((r->access[i].type & KCSAN_ACCESS_WRITE) ?
-					 "write" :
-					 "read");
+			(ty & KCSAN_ACCESS_ASSERT) ?
+				      ((ty & KCSAN_ACCESS_WRITE) ?
+					       "assert no accesses" :
+					       "assert no writes") :
+				      ((ty & KCSAN_ACCESS_WRITE) ?
+					       ((ty & KCSAN_ACCESS_COMPOUND) ?
+							"read-write" :
+							"write") :
+					       "read");
 		const char *const access_type_aux =
-			(r->access[i].type & KCSAN_ACCESS_ATOMIC) ?
-				" (marked)" :
-				((r->access[i].type & KCSAN_ACCESS_SCOPED) ?
-					 " (scoped)" :
-					 "");
+			(ty & KCSAN_ACCESS_ATOMIC) ?
+				      " (marked)" :
+				      ((ty & KCSAN_ACCESS_SCOPED) ? " (scoped)" : "");
 
 		if (i == 1) {
 			/* Access 2 */
@@ -277,6 +284,12 @@ static noinline void test_kernel_write_atomic(void)
 	WRITE_ONCE(test_var, READ_ONCE_NOCHECK(test_sink) + 1);
 }
 
+static noinline void test_kernel_atomic_rmw(void)
+{
+	/* Use builtin, so we can set up the "bad" atomic/non-atomic scenario. */
+	__atomic_fetch_add(&test_var, 1, __ATOMIC_RELAXED);
+}
+
 __no_kcsan
 static noinline void test_kernel_write_uninstrumented(void) { test_var++; }
 
@@ -439,8 +452,8 @@ static void test_concurrent_races(struct kunit *test)
 	const struct expect_report expect = {
 		.access = {
 			/* NULL will match any address. */
-			{ test_kernel_rmw_array, NULL, 0, KCSAN_ACCESS_WRITE },
-			{ test_kernel_rmw_array, NULL, 0, 0 },
+			{ test_kernel_rmw_array, NULL, 0, __KCSAN_ACCESS_RW(KCSAN_ACCESS_WRITE) },
+			{ test_kernel_rmw_array, NULL, 0, __KCSAN_ACCESS_RW(0) },
 		},
 	};
 	static const struct expect_report never = {
@@ -629,6 +642,29 @@ static void test_read_plain_atomic_write(struct kunit *test)
 	KUNIT_EXPECT_TRUE(test, match_expect);
 }
 
+/* Test that atomic RMWs generate correct report. */
+__no_kcsan
+static void test_read_plain_atomic_rmw(struct kunit *test)
+{
+	const struct expect_report expect = {
+		.access = {
+			{ test_kernel_read, &test_var, sizeof(test_var), 0 },
+			{ test_kernel_atomic_rmw, &test_var, sizeof(test_var),
+				KCSAN_ACCESS_COMPOUND | KCSAN_ACCESS_WRITE | KCSAN_ACCESS_ATOMIC },
+		},
+	};
+	bool match_expect = false;
+
+	if (IS_ENABLED(CONFIG_KCSAN_IGNORE_ATOMICS))
+		return;
+
+	begin_test_checks(test_kernel_read, test_kernel_atomic_rmw);
+	do {
+		match_expect = report_matches(&expect);
+	} while (!end_test_checks(match_expect));
+	KUNIT_EXPECT_TRUE(test, match_expect);
+}
+
 /* Zero-sized accesses should never cause data race reports. */
 __no_kcsan
 static void test_zero_size_access(struct kunit *test)
@@ -942,6 +978,7 @@ static struct kunit_case kcsan_test_cases[] = {
 	KCSAN_KUNIT_CASE(test_write_write_struct_part),
 	KCSAN_KUNIT_CASE(test_read_atomic_write_atomic),
 	KCSAN_KUNIT_CASE(test_read_plain_atomic_write),
+	KCSAN_KUNIT_CASE(test_read_plain_atomic_rmw),
 	KCSAN_KUNIT_CASE(test_zero_size_access),
 	KCSAN_KUNIT_CASE(test_data_race),
 	KCSAN_KUNIT_CASE(test_assert_exclusive_writer),
diff --git a/lib/Kconfig.kcsan b/lib/Kconfig.kcsan
index 3d282d5..f271ff5 100644
--- a/lib/Kconfig.kcsan
+++ b/lib/Kconfig.kcsan
@@ -40,6 +40,11 @@ menuconfig KCSAN
 
 if KCSAN
 
+# Compiler capabilities that should not fail the test if they are unavailable.
+config CC_HAS_TSAN_COMPOUND_READ_BEFORE_WRITE
+	def_bool (CC_IS_CLANG && $(cc-option,-fsanitize=thread -mllvm -tsan-compound-read-before-write=1)) || \
+		 (CC_IS_GCC && $(cc-option,-fsanitize=thread --param tsan-compound-read-before-write=1))
+
 config KCSAN_VERBOSE
 	bool "Show verbose reports with more information about system state"
 	depends on PROVE_LOCKING
