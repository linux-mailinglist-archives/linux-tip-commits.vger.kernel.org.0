Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D76E0288426
	for <lists+linux-tip-commits@lfdr.de>; Fri,  9 Oct 2020 09:59:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732457AbgJIH67 (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 9 Oct 2020 03:58:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732513AbgJIH66 (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 9 Oct 2020 03:58:58 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57B48C0613E1;
        Fri,  9 Oct 2020 00:58:55 -0700 (PDT)
Date:   Fri, 09 Oct 2020 07:58:53 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1602230334;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=Y/x7Do+o79/9OoFsU0PLdIAp8paGUj31q1Iy6E+SWaM=;
        b=t3T9xMDson0XhMftogrQPdyaN4gSiOGDE+ZKmbUKpspa8bFn4M3AYQpzafm6cbWRj7Fgx4
        oJh8fU/+QFRpjgM6k94baumLS624maykDu9limqChzX7N+ekdaBu7aHzttvUb/dwqvW/Qn
        EfqOfrWxeSYII3Htuokt++hhGO+DMctElwxp9me//W1kEu4bIHGfbfDux5pkfFq0f9CsxT
        OFmhyOrSewGh6eQ7KetVMi4rex9iTFn2h+Fxlf4Uw6Yc6sl++rzCiPPPsVsJQ/w4C9BvQo
        xA+FjsYjOOl/RjbFXgiX9pVHBPnF1ybjkngwZW4q/x4nJGgR97Lg9q6hIajCiw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1602230334;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=Y/x7Do+o79/9OoFsU0PLdIAp8paGUj31q1Iy6E+SWaM=;
        b=26bZJHKtSZYkRdVMnORddF1xtxaKFq/PBRBqQJ/P8lhHc4JU6A/zf4ez+44u+sqzUJbb1r
        1LNLS81/lTd6N5DA==
From:   "tip-bot2 for Marco Elver" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] kcsan: Add atomic builtin test case
Cc:     Marco Elver <elver@google.com>,
        "Paul E. McKenney" <paulmck@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <160223033319.7002.1306650457431570762.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     f9ea63193135473ed6b6ff06f016eb6248100041
Gitweb:        https://git.kernel.org/tip/f9ea63193135473ed6b6ff06f016eb6248100041
Author:        Marco Elver <elver@google.com>
AuthorDate:    Fri, 03 Jul 2020 15:40:31 +02:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Mon, 24 Aug 2020 15:09:31 -07:00

kcsan: Add atomic builtin test case

Adds test case to kcsan-test module, to test atomic builtin
instrumentation works.

Signed-off-by: Marco Elver <elver@google.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/kcsan/kcsan-test.c | 63 ++++++++++++++++++++++++++++++++++++++-
 1 file changed, 63 insertions(+)

diff --git a/kernel/kcsan/kcsan-test.c b/kernel/kcsan/kcsan-test.c
index fed6fcb..721180c 100644
--- a/kernel/kcsan/kcsan-test.c
+++ b/kernel/kcsan/kcsan-test.c
@@ -390,6 +390,15 @@ static noinline void test_kernel_seqlock_writer(void)
 	write_sequnlock_irqrestore(&test_seqlock, flags);
 }
 
+static noinline void test_kernel_atomic_builtins(void)
+{
+	/*
+	 * Generate concurrent accesses, expecting no reports, ensuring KCSAN
+	 * treats builtin atomics as actually atomic.
+	 */
+	__atomic_load_n(&test_var, __ATOMIC_RELAXED);
+}
+
 /* ===== Test cases ===== */
 
 /* Simple test with normal data race. */
@@ -853,6 +862,59 @@ static void test_seqlock_noreport(struct kunit *test)
 }
 
 /*
+ * Test atomic builtins work and required instrumentation functions exist. We
+ * also test that KCSAN understands they're atomic by racing with them via
+ * test_kernel_atomic_builtins(), and expect no reports.
+ *
+ * The atomic builtins _SHOULD NOT_ be used in normal kernel code!
+ */
+static void test_atomic_builtins(struct kunit *test)
+{
+	bool match_never = false;
+
+	begin_test_checks(test_kernel_atomic_builtins, test_kernel_atomic_builtins);
+	do {
+		long tmp;
+
+		kcsan_enable_current();
+
+		__atomic_store_n(&test_var, 42L, __ATOMIC_RELAXED);
+		KUNIT_EXPECT_EQ(test, 42L, __atomic_load_n(&test_var, __ATOMIC_RELAXED));
+
+		KUNIT_EXPECT_EQ(test, 42L, __atomic_exchange_n(&test_var, 20, __ATOMIC_RELAXED));
+		KUNIT_EXPECT_EQ(test, 20L, test_var);
+
+		tmp = 20L;
+		KUNIT_EXPECT_TRUE(test, __atomic_compare_exchange_n(&test_var, &tmp, 30L,
+								    0, __ATOMIC_RELAXED,
+								    __ATOMIC_RELAXED));
+		KUNIT_EXPECT_EQ(test, tmp, 20L);
+		KUNIT_EXPECT_EQ(test, test_var, 30L);
+		KUNIT_EXPECT_FALSE(test, __atomic_compare_exchange_n(&test_var, &tmp, 40L,
+								     1, __ATOMIC_RELAXED,
+								     __ATOMIC_RELAXED));
+		KUNIT_EXPECT_EQ(test, tmp, 30L);
+		KUNIT_EXPECT_EQ(test, test_var, 30L);
+
+		KUNIT_EXPECT_EQ(test, 30L, __atomic_fetch_add(&test_var, 1, __ATOMIC_RELAXED));
+		KUNIT_EXPECT_EQ(test, 31L, __atomic_fetch_sub(&test_var, 1, __ATOMIC_RELAXED));
+		KUNIT_EXPECT_EQ(test, 30L, __atomic_fetch_and(&test_var, 0xf, __ATOMIC_RELAXED));
+		KUNIT_EXPECT_EQ(test, 14L, __atomic_fetch_xor(&test_var, 0xf, __ATOMIC_RELAXED));
+		KUNIT_EXPECT_EQ(test, 1L, __atomic_fetch_or(&test_var, 0xf0, __ATOMIC_RELAXED));
+		KUNIT_EXPECT_EQ(test, 241L, __atomic_fetch_nand(&test_var, 0xf, __ATOMIC_RELAXED));
+		KUNIT_EXPECT_EQ(test, -2L, test_var);
+
+		__atomic_thread_fence(__ATOMIC_SEQ_CST);
+		__atomic_signal_fence(__ATOMIC_SEQ_CST);
+
+		kcsan_disable_current();
+
+		match_never = report_available();
+	} while (!end_test_checks(match_never));
+	KUNIT_EXPECT_FALSE(test, match_never);
+}
+
+/*
  * Each test case is run with different numbers of threads. Until KUnit supports
  * passing arguments for each test case, we encode #threads in the test case
  * name (read by get_num_threads()). [The '-' was chosen as a stylistic
@@ -891,6 +953,7 @@ static struct kunit_case kcsan_test_cases[] = {
 	KCSAN_KUNIT_CASE(test_assert_exclusive_access_scoped),
 	KCSAN_KUNIT_CASE(test_jiffies_noreport),
 	KCSAN_KUNIT_CASE(test_seqlock_noreport),
+	KCSAN_KUNIT_CASE(test_atomic_builtins),
 	{},
 };
 
