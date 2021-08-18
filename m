Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3181C3EFE6C
	for <lists+linux-tip-commits@lfdr.de>; Wed, 18 Aug 2021 09:58:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239328AbhHRH7Y (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 18 Aug 2021 03:59:24 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:38754 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239148AbhHRH7U (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 18 Aug 2021 03:59:20 -0400
Date:   Wed, 18 Aug 2021 07:58:44 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1629273524;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=JUKmlS1y6feA7sE1A4EWYn4h2WeWPHRaUyNWdEncuO8=;
        b=330xk8+VZ0TTp5rHsLa7fao1M+bzih/yYI23pAYevCPPy4Vl7JNfURYVVMq44a+AsiF/JJ
        snriVbbPi+fq+2exXNaKHubC2T4ebSEdPpMBNepMTCUEX/RwEqwL4PrY4rkJ0d9sZpSpof
        D4eWqDKaLUG0TPFAnKeuoqamy/B2ELgLi9atMV+lbbOcjoY4LNN1N/kg7N91wUuMzI72Yo
        pn4rWC1UBDT6MQql1HtneT6bNt7N8Ip8Um3AOeQYRZeuYqNNYjOcY3ijBbDBYvARa6QLYr
        bRpr8xdYEmLwdb1dYfDK/hPCOqhifmVEnTv3g5hyhsv2sjE+M7IUBNAK5MyoPQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1629273524;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=JUKmlS1y6feA7sE1A4EWYn4h2WeWPHRaUyNWdEncuO8=;
        b=Zk1wfqOBZuw2UFb//FEeQhD/MZ8elfXcQq68pltC3WyQVexaeAnmmu6Yt0sZZSkBItW+A5
        7kCEqOz9xg6jMpDA==
From:   "tip-bot2 for Marco Elver" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/debug] kcsan: Rework atomic.h into permissive.h
Cc:     Marco Elver <elver@google.com>,
        Mark Rutland <mark.rutland@arm.com>,
        "Paul E. McKenney" <paulmck@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <162927352407.25758.1233185703893160119.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the locking/debug branch of tip:

Commit-ID:     49f72d5358dd3c0d28bcd2232c513000b15480f0
Gitweb:        https://git.kernel.org/tip/49f72d5358dd3c0d28bcd2232c513000b15480f0
Author:        Marco Elver <elver@google.com>
AuthorDate:    Mon, 07 Jun 2021 14:56:51 +02:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Tue, 20 Jul 2021 13:49:43 -07:00

kcsan: Rework atomic.h into permissive.h

Rework atomic.h into permissive.h to better reflect its purpose, and
introduce kcsan_ignore_address() and kcsan_ignore_data_race().

Introduce CONFIG_KCSAN_PERMISSIVE and update the stub functions in
preparation for subsequent changes.

As before, developers who choose to use KCSAN in "strict" mode will see
all data races and are not affected. Furthermore, by relying on the
value-change filter logic for kcsan_ignore_data_race(), even if the
permissive rules are enabled, the opt-outs in report.c:skip_report()
override them (such as for RCU-related functions by default).

The option CONFIG_KCSAN_PERMISSIVE is disabled by default, so that the
documented default behaviour of KCSAN does not change. Instead, like
CONFIG_KCSAN_IGNORE_ATOMICS, the option needs to be explicitly opted in.

Signed-off-by: Marco Elver <elver@google.com>
Acked-by: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 Documentation/dev-tools/kcsan.rst |  8 +++++-
 kernel/kcsan/atomic.h             | 23 +---------------
 kernel/kcsan/core.c               | 33 +++++++++++++++------
 kernel/kcsan/permissive.h         | 47 ++++++++++++++++++++++++++++++-
 lib/Kconfig.kcsan                 | 10 ++++++-
 5 files changed, 89 insertions(+), 32 deletions(-)
 delete mode 100644 kernel/kcsan/atomic.h
 create mode 100644 kernel/kcsan/permissive.h

diff --git a/Documentation/dev-tools/kcsan.rst b/Documentation/dev-tools/kcsan.rst
index 69dc9c5..7db43c7 100644
--- a/Documentation/dev-tools/kcsan.rst
+++ b/Documentation/dev-tools/kcsan.rst
@@ -127,6 +127,14 @@ Kconfig options:
   causes KCSAN to not report data races due to conflicts where the only plain
   accesses are aligned writes up to word size.
 
+* ``CONFIG_KCSAN_PERMISSIVE``: Enable additional permissive rules to ignore
+  certain classes of common data races. Unlike the above, the rules are more
+  complex involving value-change patterns, access type, and address. This
+  option depends on ``CONFIG_KCSAN_REPORT_VALUE_CHANGE_ONLY=y``. For details
+  please see the ``kernel/kcsan/permissive.h``. Testers and maintainers that
+  only focus on reports from specific subsystems and not the whole kernel are
+  recommended to disable this option.
+
 To use the strictest possible rules, select ``CONFIG_KCSAN_STRICT=y``, which
 configures KCSAN to follow the Linux-kernel memory consistency model (LKMM) as
 closely as possible.
diff --git a/kernel/kcsan/atomic.h b/kernel/kcsan/atomic.h
deleted file mode 100644
index 530ae1b..0000000
--- a/kernel/kcsan/atomic.h
+++ /dev/null
@@ -1,23 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-/*
- * Rules for implicitly atomic memory accesses.
- *
- * Copyright (C) 2019, Google LLC.
- */
-
-#ifndef _KERNEL_KCSAN_ATOMIC_H
-#define _KERNEL_KCSAN_ATOMIC_H
-
-#include <linux/types.h>
-
-/*
- * Special rules for certain memory where concurrent conflicting accesses are
- * common, however, the current convention is to not mark them; returns true if
- * access to @ptr should be considered atomic. Called from slow-path.
- */
-static bool kcsan_is_atomic_special(const volatile void *ptr)
-{
-	return false;
-}
-
-#endif /* _KERNEL_KCSAN_ATOMIC_H */
diff --git a/kernel/kcsan/core.c b/kernel/kcsan/core.c
index 9061009..439edb9 100644
--- a/kernel/kcsan/core.c
+++ b/kernel/kcsan/core.c
@@ -20,9 +20,9 @@
 #include <linux/sched.h>
 #include <linux/uaccess.h>
 
-#include "atomic.h"
 #include "encoding.h"
 #include "kcsan.h"
+#include "permissive.h"
 
 static bool kcsan_early_enable = IS_ENABLED(CONFIG_KCSAN_EARLY_ENABLE);
 unsigned int kcsan_udelay_task = CONFIG_KCSAN_UDELAY_TASK;
@@ -353,6 +353,7 @@ static noinline void kcsan_found_watchpoint(const volatile void *ptr,
 					    atomic_long_t *watchpoint,
 					    long encoded_watchpoint)
 {
+	const bool is_assert = (type & KCSAN_ACCESS_ASSERT) != 0;
 	struct kcsan_ctx *ctx = get_ctx();
 	unsigned long flags;
 	bool consumed;
@@ -375,6 +376,16 @@ static noinline void kcsan_found_watchpoint(const volatile void *ptr,
 		return;
 
 	/*
+	 * If the other thread does not want to ignore the access, and there was
+	 * a value change as a result of this thread's operation, we will still
+	 * generate a report of unknown origin.
+	 *
+	 * Use CONFIG_KCSAN_REPORT_RACE_UNKNOWN_ORIGIN=n to filter.
+	 */
+	if (!is_assert && kcsan_ignore_address(ptr))
+		return;
+
+	/*
 	 * Consuming the watchpoint must be guarded by kcsan_is_enabled() to
 	 * avoid erroneously triggering reports if the context is disabled.
 	 */
@@ -396,7 +407,7 @@ static noinline void kcsan_found_watchpoint(const volatile void *ptr,
 		atomic_long_inc(&kcsan_counters[KCSAN_COUNTER_REPORT_RACES]);
 	}
 
-	if ((type & KCSAN_ACCESS_ASSERT) != 0)
+	if (is_assert)
 		atomic_long_inc(&kcsan_counters[KCSAN_COUNTER_ASSERT_FAILURES]);
 	else
 		atomic_long_inc(&kcsan_counters[KCSAN_COUNTER_DATA_RACES]);
@@ -427,12 +438,10 @@ kcsan_setup_watchpoint(const volatile void *ptr, size_t size, int type)
 		goto out;
 
 	/*
-	 * Special atomic rules: unlikely to be true, so we check them here in
-	 * the slow-path, and not in the fast-path in is_atomic(). Call after
-	 * kcsan_is_enabled(), as we may access memory that is not yet
-	 * initialized during early boot.
+	 * Check to-ignore addresses after kcsan_is_enabled(), as we may access
+	 * memory that is not yet initialized during early boot.
 	 */
-	if (!is_assert && kcsan_is_atomic_special(ptr))
+	if (!is_assert && kcsan_ignore_address(ptr))
 		goto out;
 
 	if (!check_encodable((unsigned long)ptr, size)) {
@@ -518,8 +527,14 @@ kcsan_setup_watchpoint(const volatile void *ptr, size_t size, int type)
 	if (access_mask)
 		diff &= access_mask;
 
-	/* Were we able to observe a value-change? */
-	if (diff != 0)
+	/*
+	 * Check if we observed a value change.
+	 *
+	 * Also check if the data race should be ignored (the rules depend on
+	 * non-zero diff); if it is to be ignored, the below rules for
+	 * KCSAN_VALUE_CHANGE_MAYBE apply.
+	 */
+	if (diff && !kcsan_ignore_data_race(size, type, old, new, diff))
 		value_change = KCSAN_VALUE_CHANGE_TRUE;
 
 	/* Check if this access raced with another. */
diff --git a/kernel/kcsan/permissive.h b/kernel/kcsan/permissive.h
new file mode 100644
index 0000000..f90e308
--- /dev/null
+++ b/kernel/kcsan/permissive.h
@@ -0,0 +1,47 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Special rules for ignoring entire classes of data-racy memory accesses. None
+ * of the rules here imply that such data races are generally safe!
+ *
+ * All rules in this file can be configured via CONFIG_KCSAN_PERMISSIVE. Keep
+ * them separate from core code to make it easier to audit.
+ *
+ * Copyright (C) 2019, Google LLC.
+ */
+
+#ifndef _KERNEL_KCSAN_PERMISSIVE_H
+#define _KERNEL_KCSAN_PERMISSIVE_H
+
+#include <linux/types.h>
+
+/*
+ * Access ignore rules based on address.
+ */
+static __always_inline bool kcsan_ignore_address(const volatile void *ptr)
+{
+	if (!IS_ENABLED(CONFIG_KCSAN_PERMISSIVE))
+		return false;
+
+	return false;
+}
+
+/*
+ * Data race ignore rules based on access type and value change patterns.
+ */
+static bool
+kcsan_ignore_data_race(size_t size, int type, u64 old, u64 new, u64 diff)
+{
+	if (!IS_ENABLED(CONFIG_KCSAN_PERMISSIVE))
+		return false;
+
+	/*
+	 * Rules here are only for plain read accesses, so that we still report
+	 * data races between plain read-write accesses.
+	 */
+	if (type || size > sizeof(long))
+		return false;
+
+	return false;
+}
+
+#endif /* _KERNEL_KCSAN_PERMISSIVE_H */
diff --git a/lib/Kconfig.kcsan b/lib/Kconfig.kcsan
index c76fbb3..26f03c7 100644
--- a/lib/Kconfig.kcsan
+++ b/lib/Kconfig.kcsan
@@ -231,4 +231,14 @@ config KCSAN_IGNORE_ATOMICS
 	  due to two conflicting plain writes will be reported (aligned and
 	  unaligned, if CONFIG_KCSAN_ASSUME_PLAIN_WRITES_ATOMIC=n).
 
+config KCSAN_PERMISSIVE
+	bool "Enable all additional permissive rules"
+	depends on KCSAN_REPORT_VALUE_CHANGE_ONLY
+	help
+	  Enable additional permissive rules to ignore certain classes of data
+	  races (also see kernel/kcsan/permissive.h). None of the permissive
+	  rules imply that such data races are generally safe, but can be used
+	  to further reduce reported data races due to data-racy patterns
+	  common across the kernel.
+
 endif # KCSAN
