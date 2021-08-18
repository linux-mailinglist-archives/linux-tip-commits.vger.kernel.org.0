Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B8FE33EFE6B
	for <lists+linux-tip-commits@lfdr.de>; Wed, 18 Aug 2021 09:58:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239293AbhHRH7X (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 18 Aug 2021 03:59:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239108AbhHRH7U (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 18 Aug 2021 03:59:20 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CE50C061764;
        Wed, 18 Aug 2021 00:58:46 -0700 (PDT)
Date:   Wed, 18 Aug 2021 07:58:42 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1629273523;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=JZ5EuskIZOXsg6OIzF0PO2IoJZHnD0Wj96t91a6aVyw=;
        b=iVFEPLDCztS3ebmuhYhwPr3CbN+VmVqjH/rFMOrznOtpdDLvbuKnRl53sFqN+dDgoIPpSZ
        cMWbjIUxGneiaRlXxO3GRVvLCfmlxQ07nz/YMZiXo1PwAWN0fjeLxTz89jCxciVHee67r1
        3IiT6Z3qygkZZd4KEmgQxVrdndvMnkW2abkIQiQZcsz0yk4tlvtYOFXikkEQUgFKQySF9L
        uAwRbHvxta+pMszW4WNOsqJwz2/+itJW0tscoVpL4EVK5sSMNJ3sUQ5LDywfgXffzyhU4E
        AwAzWK6XV+mw6Bjw6b8T1CXKJ+MVQY1IjXCj22qWA5MtTS51gigFFtO+Rj0+Og==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1629273523;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=JZ5EuskIZOXsg6OIzF0PO2IoJZHnD0Wj96t91a6aVyw=;
        b=r6MIfn6T8ZdtlZVbKifUFoCXWo/Qt72vg6I37sWaJyplaFiVjd/RcjuN9w4O2Zc6gJx5Tc
        S2XvLk6LvNXhXPBQ==
From:   "tip-bot2 for Marco Elver" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/debug] kcsan: permissive: Ignore data-racy 1-bit value changes
Cc:     Marco Elver <elver@google.com>,
        Mark Rutland <mark.rutland@arm.com>,
        "Paul E. McKenney" <paulmck@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <162927352288.25758.7432492764387291801.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the locking/debug branch of tip:

Commit-ID:     d8fd74d35a8d3c602232e3238e916bda9d03d520
Gitweb:        https://git.kernel.org/tip/d8fd74d35a8d3c602232e3238e916bda9d03d520
Author:        Marco Elver <elver@google.com>
AuthorDate:    Mon, 07 Jun 2021 14:56:53 +02:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Tue, 20 Jul 2021 13:49:44 -07:00

kcsan: permissive: Ignore data-racy 1-bit value changes

Add rules to ignore data-racy reads with only 1-bit value changes.
Details about the rules are captured in comments in
kernel/kcsan/permissive.h. More background follows.

While investigating a number of data races, we've encountered data-racy
accesses on flags variables to be very common. The typical pattern is a
reader masking all but one bit, and/or the writer setting/clearing only
1 bit (current->flags being a frequently encountered case; more examples
in mm/sl[au]b.c, which disable KCSAN for this reason).

Since these types of data-racy accesses are common (with the assumption
they are intentional and hard to miscompile) having the option (with
CONFIG_KCSAN_PERMISSIVE=y) to filter them will avoid forcing everyone to
mark them, and deliberately left to preference at this time.

One important motivation for having this option built-in is to move
closer to being able to enable KCSAN on CI systems or for testers
wishing to test the whole kernel, while more easily filtering
less interesting data races with higher probability.

For the implementation, we considered several alternatives, but had one
major requirement: that the rules be kept together with the Linux-kernel
tree. Adding them to the compiler would preclude us from making changes
quickly; if the rules require tweaks, having them part of the compiler
requires waiting another ~1 year for the next release -- that's not
realistic. We are left with the following options:

	1. Maintain compiler plugins as part of the kernel-tree that
	   removes instrumentation for some accesses (e.g. plain-& with
	   1-bit mask). The analysis would be reader-side focused, as
	   no assumption can be made about racing writers.

Because it seems unrealistic to maintain 2 plugins, one for LLVM and
GCC, we would likely pick LLVM. Furthermore, no kernel infrastructure
exists to maintain LLVM plugins, and the build-system implications and
maintenance overheads do not look great (historically, plugins written
against old LLVM APIs are not guaranteed to work with newer LLVM APIs).

	2. Find a set of rules that can be expressed in terms of
	   observed value changes, and make it part of the KCSAN runtime.
	   The analysis is writer-side focused, given we rely on observed
	   value changes.

The approach taken here is (2). While a complete approach requires both
(1) and (2), experiments show that the majority of data races involving
trivial bit operations on flags variables can be removed with (2) alone.

It goes without saying that the filtering of data races using (1) or (2)
does _not_ guarantee they are safe! Therefore, limiting ourselves to (2)
for now is the conservative choice for setups that wish to enable
CONFIG_KCSAN_PERMISSIVE=y.

Signed-off-by: Marco Elver <elver@google.com>
Acked-by: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/kcsan/kcsan_test.c | 32 +++++++++++++++++++++++++-
 kernel/kcsan/permissive.h | 49 +++++++++++++++++++++++++++++++++++++-
 2 files changed, 80 insertions(+), 1 deletion(-)

diff --git a/kernel/kcsan/kcsan_test.c b/kernel/kcsan/kcsan_test.c
index 8bcffbd..dc55fd5 100644
--- a/kernel/kcsan/kcsan_test.c
+++ b/kernel/kcsan/kcsan_test.c
@@ -414,6 +414,14 @@ static noinline void test_kernel_atomic_builtins(void)
 	__atomic_load_n(&test_var, __ATOMIC_RELAXED);
 }
 
+static noinline void test_kernel_xor_1bit(void)
+{
+	/* Do not report data races between the read-writes. */
+	kcsan_nestable_atomic_begin();
+	test_var ^= 0x10000;
+	kcsan_nestable_atomic_end();
+}
+
 /* ===== Test cases ===== */
 
 /* Simple test with normal data race. */
@@ -952,6 +960,29 @@ static void test_atomic_builtins(struct kunit *test)
 	KUNIT_EXPECT_FALSE(test, match_never);
 }
 
+__no_kcsan
+static void test_1bit_value_change(struct kunit *test)
+{
+	const struct expect_report expect = {
+		.access = {
+			{ test_kernel_read, &test_var, sizeof(test_var), 0 },
+			{ test_kernel_xor_1bit, &test_var, sizeof(test_var), __KCSAN_ACCESS_RW(KCSAN_ACCESS_WRITE) },
+		},
+	};
+	bool match = false;
+
+	begin_test_checks(test_kernel_read, test_kernel_xor_1bit);
+	do {
+		match = IS_ENABLED(CONFIG_KCSAN_PERMISSIVE)
+				? report_available()
+				: report_matches(&expect);
+	} while (!end_test_checks(match));
+	if (IS_ENABLED(CONFIG_KCSAN_PERMISSIVE))
+		KUNIT_EXPECT_FALSE(test, match);
+	else
+		KUNIT_EXPECT_TRUE(test, match);
+}
+
 /*
  * Generate thread counts for all test cases. Values generated are in interval
  * [2, 5] followed by exponentially increasing thread counts from 8 to 32.
@@ -1024,6 +1055,7 @@ static struct kunit_case kcsan_test_cases[] = {
 	KCSAN_KUNIT_CASE(test_jiffies_noreport),
 	KCSAN_KUNIT_CASE(test_seqlock_noreport),
 	KCSAN_KUNIT_CASE(test_atomic_builtins),
+	KCSAN_KUNIT_CASE(test_1bit_value_change),
 	{},
 };
 
diff --git a/kernel/kcsan/permissive.h b/kernel/kcsan/permissive.h
index f90e308..2c01fe4 100644
--- a/kernel/kcsan/permissive.h
+++ b/kernel/kcsan/permissive.h
@@ -12,6 +12,8 @@
 #ifndef _KERNEL_KCSAN_PERMISSIVE_H
 #define _KERNEL_KCSAN_PERMISSIVE_H
 
+#include <linux/bitops.h>
+#include <linux/sched.h>
 #include <linux/types.h>
 
 /*
@@ -22,7 +24,11 @@ static __always_inline bool kcsan_ignore_address(const volatile void *ptr)
 	if (!IS_ENABLED(CONFIG_KCSAN_PERMISSIVE))
 		return false;
 
-	return false;
+	/*
+	 * Data-racy bitops on current->flags are too common, ignore completely
+	 * for now.
+	 */
+	return ptr == &current->flags;
 }
 
 /*
@@ -41,6 +47,47 @@ kcsan_ignore_data_race(size_t size, int type, u64 old, u64 new, u64 diff)
 	if (type || size > sizeof(long))
 		return false;
 
+	/*
+	 * A common pattern is checking/setting just 1 bit in a variable; for
+	 * example:
+	 *
+	 *	if (flags & SOME_FLAG) { ... }
+	 *
+	 * and elsewhere flags is updated concurrently:
+	 *
+	 *	flags |= SOME_OTHER_FLAG; // just 1 bit
+	 *
+	 * While it is still recommended that such accesses be marked
+	 * appropriately, in many cases these types of data races are so common
+	 * that marking them all is often unrealistic and left to maintainer
+	 * preference.
+	 *
+	 * The assumption in all cases is that with all known compiler
+	 * optimizations (including those that tear accesses), because no more
+	 * than 1 bit changed, the plain accesses are safe despite the presence
+	 * of data races.
+	 *
+	 * The rules here will ignore the data races if we observe no more than
+	 * 1 bit changed.
+	 *
+	 * Of course many operations can effecively change just 1 bit, but the
+	 * general assuption that data races involving 1-bit changes can be
+	 * tolerated still applies.
+	 *
+	 * And in case a true bug is missed, the bug likely manifests as a
+	 * reportable data race elsewhere.
+	 */
+	if (hweight64(diff) == 1) {
+		/*
+		 * Exception: Report data races where the values look like
+		 * ordinary booleans (one of them was 0 and the 0th bit was
+		 * changed) More often than not, they come with interesting
+		 * memory ordering requirements, so let's report them.
+		 */
+		if (!((!old || !new) && diff == 1))
+			return true;
+	}
+
 	return false;
 }
 
