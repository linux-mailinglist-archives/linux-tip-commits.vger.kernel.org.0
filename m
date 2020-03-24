Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3DD711908A0
	for <lists+linux-tip-commits@lfdr.de>; Tue, 24 Mar 2020 10:12:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727323AbgCXJLH (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Tue, 24 Mar 2020 05:11:07 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:43750 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727161AbgCXJLG (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Tue, 24 Mar 2020 05:11:06 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jGfaO-0007Vm-0i; Tue, 24 Mar 2020 10:11:00 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 528471C048C;
        Tue, 24 Mar 2020 10:10:57 +0100 (CET)
Date:   Tue, 24 Mar 2020 09:10:56 -0000
From:   "tip-bot2 for Marco Elver" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/kcsan] kcsan: Introduce KCSAN_ACCESS_ASSERT access type
Cc:     Marco Elver <elver@google.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Ingo Molnar <mingo@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <158504105699.28353.8605253105589685361.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-tip-commits-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the locking/kcsan branch of tip:

Commit-ID:     d591ec3db75f9eadfa7976ff8796c674c0027715
Gitweb:        https://git.kernel.org/tip/d591ec3db75f9eadfa7976ff8796c674c0027715
Author:        Marco Elver <elver@google.com>
AuthorDate:    Thu, 06 Feb 2020 16:46:24 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Sat, 21 Mar 2020 09:42:50 +01:00

kcsan: Introduce KCSAN_ACCESS_ASSERT access type

The KCSAN_ACCESS_ASSERT access type may be used to introduce dummy reads
and writes to assert certain properties of concurrent code, where bugs
could not be detected as normal data races.

For example, a variable that is only meant to be written by a single
CPU, but may be read (without locking) by other CPUs must still be
marked properly to avoid data races. However, concurrent writes,
regardless if WRITE_ONCE() or not, would be a bug. Using
kcsan_check_access(&x, sizeof(x), KCSAN_ACCESS_ASSERT) would allow
catching such bugs.

To support KCSAN_ACCESS_ASSERT the following notable changes were made:

  * If an access is of type KCSAN_ASSERT_ACCESS, disable various filters
    that only apply to data races, so that all races that KCSAN observes are
    reported.
  * Bug reports that involve an ASSERT access type will be reported as
    "KCSAN: assert: race in ..." instead of "data-race"; this will help
    more easily distinguish them.
  * Update a few comments to just mention 'races' where we do not always
    mean pure data races.

Signed-off-by: Marco Elver <elver@google.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 include/linux/kcsan-checks.h | 18 +++++++++-----
 kernel/kcsan/core.c          | 44 ++++++++++++++++++++++++++++++-----
 kernel/kcsan/debugfs.c       |  1 +-
 kernel/kcsan/kcsan.h         |  7 ++++++-
 kernel/kcsan/report.c        | 43 ++++++++++++++++++++++++----------
 lib/Kconfig.kcsan            | 24 +++++++++++--------
 6 files changed, 103 insertions(+), 34 deletions(-)

diff --git a/include/linux/kcsan-checks.h b/include/linux/kcsan-checks.h
index ef3ee23..5dcadc2 100644
--- a/include/linux/kcsan-checks.h
+++ b/include/linux/kcsan-checks.h
@@ -6,10 +6,16 @@
 #include <linux/types.h>
 
 /*
- * Access type modifiers.
+ * ACCESS TYPE MODIFIERS
+ *
+ *   <none>: normal read access;
+ *   WRITE : write access;
+ *   ATOMIC: access is atomic;
+ *   ASSERT: access is not a regular access, but an assertion;
  */
 #define KCSAN_ACCESS_WRITE  0x1
 #define KCSAN_ACCESS_ATOMIC 0x2
+#define KCSAN_ACCESS_ASSERT 0x4
 
 /*
  * __kcsan_*: Always calls into the runtime when KCSAN is enabled. This may be used
@@ -18,7 +24,7 @@
  */
 #ifdef CONFIG_KCSAN
 /**
- * __kcsan_check_access - check generic access for data races
+ * __kcsan_check_access - check generic access for races
  *
  * @ptr address of access
  * @size size of access
@@ -43,7 +49,7 @@ static inline void kcsan_check_access(const volatile void *ptr, size_t size,
 #endif
 
 /**
- * __kcsan_check_read - check regular read access for data races
+ * __kcsan_check_read - check regular read access for races
  *
  * @ptr address of access
  * @size size of access
@@ -51,7 +57,7 @@ static inline void kcsan_check_access(const volatile void *ptr, size_t size,
 #define __kcsan_check_read(ptr, size) __kcsan_check_access(ptr, size, 0)
 
 /**
- * __kcsan_check_write - check regular write access for data races
+ * __kcsan_check_write - check regular write access for races
  *
  * @ptr address of access
  * @size size of access
@@ -60,7 +66,7 @@ static inline void kcsan_check_access(const volatile void *ptr, size_t size,
 	__kcsan_check_access(ptr, size, KCSAN_ACCESS_WRITE)
 
 /**
- * kcsan_check_read - check regular read access for data races
+ * kcsan_check_read - check regular read access for races
  *
  * @ptr address of access
  * @size size of access
@@ -68,7 +74,7 @@ static inline void kcsan_check_access(const volatile void *ptr, size_t size,
 #define kcsan_check_read(ptr, size) kcsan_check_access(ptr, size, 0)
 
 /**
- * kcsan_check_write - check regular write access for data races
+ * kcsan_check_write - check regular write access for races
  *
  * @ptr address of access
  * @size size of access
diff --git a/kernel/kcsan/core.c b/kernel/kcsan/core.c
index 82c2bef..87ef01e 100644
--- a/kernel/kcsan/core.c
+++ b/kernel/kcsan/core.c
@@ -56,7 +56,7 @@ static DEFINE_PER_CPU(struct kcsan_ctx, kcsan_cpu_ctx) = {
 
 /*
  * SLOT_IDX_FAST is used in the fast-path. Not first checking the address's primary
- * slot (middle) is fine if we assume that data races occur rarely. The set of
+ * slot (middle) is fine if we assume that races occur rarely. The set of
  * indices {SLOT_IDX(slot, i) | i in [0, NUM_SLOTS)} is equivalent to
  * {SLOT_IDX_FAST(slot, i) | i in [0, NUM_SLOTS)}.
  */
@@ -178,6 +178,14 @@ is_atomic(const volatile void *ptr, size_t size, int type)
 	if ((type & KCSAN_ACCESS_ATOMIC) != 0)
 		return true;
 
+	/*
+	 * Unless explicitly declared atomic, never consider an assertion access
+	 * as atomic. This allows using them also in atomic regions, such as
+	 * seqlocks, without implicitly changing their semantics.
+	 */
+	if ((type & KCSAN_ACCESS_ASSERT) != 0)
+		return false;
+
 	if (IS_ENABLED(CONFIG_KCSAN_ASSUME_PLAIN_WRITES_ATOMIC) &&
 	    (type & KCSAN_ACCESS_WRITE) != 0 && size <= sizeof(long) &&
 	    IS_ALIGNED((unsigned long)ptr, size))
@@ -298,7 +306,11 @@ static noinline void kcsan_found_watchpoint(const volatile void *ptr,
 		 */
 		kcsan_counter_inc(KCSAN_COUNTER_REPORT_RACES);
 	}
-	kcsan_counter_inc(KCSAN_COUNTER_DATA_RACES);
+
+	if ((type & KCSAN_ACCESS_ASSERT) != 0)
+		kcsan_counter_inc(KCSAN_COUNTER_ASSERT_FAILURES);
+	else
+		kcsan_counter_inc(KCSAN_COUNTER_DATA_RACES);
 
 	user_access_restore(flags);
 }
@@ -307,6 +319,7 @@ static noinline void
 kcsan_setup_watchpoint(const volatile void *ptr, size_t size, int type)
 {
 	const bool is_write = (type & KCSAN_ACCESS_WRITE) != 0;
+	const bool is_assert = (type & KCSAN_ACCESS_ASSERT) != 0;
 	atomic_long_t *watchpoint;
 	union {
 		u8 _1;
@@ -429,13 +442,32 @@ kcsan_setup_watchpoint(const volatile void *ptr, size_t size, int type)
 		/*
 		 * No need to increment 'data_races' counter, as the racing
 		 * thread already did.
+		 *
+		 * Count 'assert_failures' for each failed ASSERT access,
+		 * therefore both this thread and the racing thread may
+		 * increment this counter.
 		 */
-		kcsan_report(ptr, size, type, size > 8 || value_change,
-			     smp_processor_id(), KCSAN_REPORT_RACE_SIGNAL);
+		if (is_assert)
+			kcsan_counter_inc(KCSAN_COUNTER_ASSERT_FAILURES);
+
+		/*
+		 * - If we were not able to observe a value change due to size
+		 *   constraints, always assume a value change.
+		 * - If the access type is an assertion, we also always assume a
+		 *   value change to always report the race.
+		 */
+		value_change = value_change || size > 8 || is_assert;
+
+		kcsan_report(ptr, size, type, value_change, smp_processor_id(),
+			     KCSAN_REPORT_RACE_SIGNAL);
 	} else if (value_change) {
 		/* Inferring a race, since the value should not have changed. */
+
 		kcsan_counter_inc(KCSAN_COUNTER_RACES_UNKNOWN_ORIGIN);
-		if (IS_ENABLED(CONFIG_KCSAN_REPORT_RACE_UNKNOWN_ORIGIN))
+		if (is_assert)
+			kcsan_counter_inc(KCSAN_COUNTER_ASSERT_FAILURES);
+
+		if (IS_ENABLED(CONFIG_KCSAN_REPORT_RACE_UNKNOWN_ORIGIN) || is_assert)
 			kcsan_report(ptr, size, type, true,
 				     smp_processor_id(),
 				     KCSAN_REPORT_RACE_UNKNOWN_ORIGIN);
@@ -471,7 +503,7 @@ static __always_inline void check_access(const volatile void *ptr, size_t size,
 				     &encoded_watchpoint);
 	/*
 	 * It is safe to check kcsan_is_enabled() after find_watchpoint in the
-	 * slow-path, as long as no state changes that cause a data race to be
+	 * slow-path, as long as no state changes that cause a race to be
 	 * detected and reported have occurred until kcsan_is_enabled() is
 	 * checked.
 	 */
diff --git a/kernel/kcsan/debugfs.c b/kernel/kcsan/debugfs.c
index bec42da..a9dad44 100644
--- a/kernel/kcsan/debugfs.c
+++ b/kernel/kcsan/debugfs.c
@@ -44,6 +44,7 @@ static const char *counter_to_name(enum kcsan_counter_id id)
 	case KCSAN_COUNTER_USED_WATCHPOINTS:		return "used_watchpoints";
 	case KCSAN_COUNTER_SETUP_WATCHPOINTS:		return "setup_watchpoints";
 	case KCSAN_COUNTER_DATA_RACES:			return "data_races";
+	case KCSAN_COUNTER_ASSERT_FAILURES:		return "assert_failures";
 	case KCSAN_COUNTER_NO_CAPACITY:			return "no_capacity";
 	case KCSAN_COUNTER_REPORT_RACES:		return "report_races";
 	case KCSAN_COUNTER_RACES_UNKNOWN_ORIGIN:	return "races_unknown_origin";
diff --git a/kernel/kcsan/kcsan.h b/kernel/kcsan/kcsan.h
index 8492da4..50078e7 100644
--- a/kernel/kcsan/kcsan.h
+++ b/kernel/kcsan/kcsan.h
@@ -40,6 +40,13 @@ enum kcsan_counter_id {
 	KCSAN_COUNTER_DATA_RACES,
 
 	/*
+	 * Total number of ASSERT failures due to races. If the observed race is
+	 * due to two conflicting ASSERT type accesses, then both will be
+	 * counted.
+	 */
+	KCSAN_COUNTER_ASSERT_FAILURES,
+
+	/*
 	 * Number of times no watchpoints were available.
 	 */
 	KCSAN_COUNTER_NO_CAPACITY,
diff --git a/kernel/kcsan/report.c b/kernel/kcsan/report.c
index 7cd3428..3bc590e 100644
--- a/kernel/kcsan/report.c
+++ b/kernel/kcsan/report.c
@@ -34,11 +34,11 @@ static struct {
 } other_info = { .ptr = NULL };
 
 /*
- * Information about reported data races; used to rate limit reporting.
+ * Information about reported races; used to rate limit reporting.
  */
 struct report_time {
 	/*
-	 * The last time the data race was reported.
+	 * The last time the race was reported.
 	 */
 	unsigned long time;
 
@@ -57,7 +57,7 @@ struct report_time {
  *
  * Therefore, we use a fixed-size array, which at most will occupy a page. This
  * still adequately rate limits reports, assuming that a) number of unique data
- * races is not excessive, and b) occurrence of unique data races within the
+ * races is not excessive, and b) occurrence of unique races within the
  * same time window is limited.
  */
 #define REPORT_TIMES_MAX (PAGE_SIZE / sizeof(struct report_time))
@@ -74,7 +74,7 @@ static struct report_time report_times[REPORT_TIMES_SIZE];
 static DEFINE_SPINLOCK(report_lock);
 
 /*
- * Checks if the data race identified by thread frames frame1 and frame2 has
+ * Checks if the race identified by thread frames frame1 and frame2 has
  * been reported since (now - KCSAN_REPORT_ONCE_IN_MS).
  */
 static bool rate_limit_report(unsigned long frame1, unsigned long frame2)
@@ -90,7 +90,7 @@ static bool rate_limit_report(unsigned long frame1, unsigned long frame2)
 
 	invalid_before = jiffies - msecs_to_jiffies(CONFIG_KCSAN_REPORT_ONCE_IN_MS);
 
-	/* Check if a matching data race report exists. */
+	/* Check if a matching race report exists. */
 	for (i = 0; i < REPORT_TIMES_SIZE; ++i) {
 		struct report_time *rt = &report_times[i];
 
@@ -114,7 +114,7 @@ static bool rate_limit_report(unsigned long frame1, unsigned long frame2)
 		if (time_before(rt->time, invalid_before))
 			continue; /* before KCSAN_REPORT_ONCE_IN_MS ago */
 
-		/* Reported recently, check if data race matches. */
+		/* Reported recently, check if race matches. */
 		if ((rt->frame1 == frame1 && rt->frame2 == frame2) ||
 		    (rt->frame1 == frame2 && rt->frame2 == frame1))
 			return true;
@@ -142,11 +142,12 @@ skip_report(bool value_change, unsigned long top_frame)
 	 * 3. write watchpoint, conflicting write (value_change==true): report;
 	 * 4. write watchpoint, conflicting write (value_change==false): skip;
 	 * 5. write watchpoint, conflicting read (value_change==false): skip;
-	 * 6. write watchpoint, conflicting read (value_change==true): impossible;
+	 * 6. write watchpoint, conflicting read (value_change==true): report;
 	 *
 	 * Cases 1-4 are intuitive and expected; case 5 ensures we do not report
-	 * data races where the write may have rewritten the same value; and
-	 * case 6 is simply impossible.
+	 * data races where the write may have rewritten the same value; case 6
+	 * is possible either if the size is larger than what we check value
+	 * changes for or the access type is KCSAN_ACCESS_ASSERT.
 	 */
 	if (IS_ENABLED(CONFIG_KCSAN_REPORT_VALUE_CHANGE_ONLY) && !value_change) {
 		/*
@@ -178,11 +179,27 @@ static const char *get_access_type(int type)
 		return "write";
 	case KCSAN_ACCESS_WRITE | KCSAN_ACCESS_ATOMIC:
 		return "write (marked)";
+
+	/*
+	 * ASSERT variants:
+	 */
+	case KCSAN_ACCESS_ASSERT:
+	case KCSAN_ACCESS_ASSERT | KCSAN_ACCESS_ATOMIC:
+		return "assert no writes";
+	case KCSAN_ACCESS_ASSERT | KCSAN_ACCESS_WRITE:
+	case KCSAN_ACCESS_ASSERT | KCSAN_ACCESS_WRITE | KCSAN_ACCESS_ATOMIC:
+		return "assert no accesses";
+
 	default:
 		BUG();
 	}
 }
 
+static const char *get_bug_type(int type)
+{
+	return (type & KCSAN_ACCESS_ASSERT) != 0 ? "assert: race" : "data-race";
+}
+
 /* Return thread description: in task or interrupt. */
 static const char *get_thread_desc(int task_id)
 {
@@ -268,13 +285,15 @@ static bool print_report(const volatile void *ptr, size_t size, int access_type,
 		 * Do not print offset of functions to keep title short.
 		 */
 		cmp = sym_strcmp((void *)other_frame, (void *)this_frame);
-		pr_err("BUG: KCSAN: data-race in %ps / %ps\n",
+		pr_err("BUG: KCSAN: %s in %ps / %ps\n",
+		       get_bug_type(access_type | other_info.access_type),
 		       (void *)(cmp < 0 ? other_frame : this_frame),
 		       (void *)(cmp < 0 ? this_frame : other_frame));
 	} break;
 
 	case KCSAN_REPORT_RACE_UNKNOWN_ORIGIN:
-		pr_err("BUG: KCSAN: data-race in %pS\n", (void *)this_frame);
+		pr_err("BUG: KCSAN: %s in %pS\n", get_bug_type(access_type),
+		       (void *)this_frame);
 		break;
 
 	default:
@@ -427,7 +446,7 @@ void kcsan_report(const volatile void *ptr, size_t size, int access_type,
 	/*
 	 * With TRACE_IRQFLAGS, lockdep's IRQ trace state becomes corrupted if
 	 * we do not turn off lockdep here; this could happen due to recursion
-	 * into lockdep via KCSAN if we detect a data race in utilities used by
+	 * into lockdep via KCSAN if we detect a race in utilities used by
 	 * lockdep.
 	 */
 	lockdep_off();
diff --git a/lib/Kconfig.kcsan b/lib/Kconfig.kcsan
index 9785bbf..f0b7911 100644
--- a/lib/Kconfig.kcsan
+++ b/lib/Kconfig.kcsan
@@ -4,13 +4,17 @@ config HAVE_ARCH_KCSAN
 	bool
 
 menuconfig KCSAN
-	bool "KCSAN: dynamic data race detector"
+	bool "KCSAN: dynamic race detector"
 	depends on HAVE_ARCH_KCSAN && DEBUG_KERNEL && !KASAN
 	select STACKTRACE
 	help
-	  The Kernel Concurrency Sanitizer (KCSAN) is a dynamic data race
-	  detector, which relies on compile-time instrumentation, and uses a
-	  watchpoint-based sampling approach to detect data races.
+	  The Kernel Concurrency Sanitizer (KCSAN) is a dynamic race detector,
+	  which relies on compile-time instrumentation, and uses a
+	  watchpoint-based sampling approach to detect races.
+
+	  KCSAN's primary purpose is to detect data races. KCSAN can also be
+	  used to check properties, with the help of provided assertions, of
+	  concurrent code where bugs do not manifest as data races.
 
 	  See <file:Documentation/dev-tools/kcsan.rst> for more details.
 
@@ -85,14 +89,14 @@ config KCSAN_SKIP_WATCH_RANDOMIZE
 	  KCSAN_WATCH_SKIP.
 
 config KCSAN_REPORT_ONCE_IN_MS
-	int "Duration in milliseconds, in which any given data race is only reported once"
+	int "Duration in milliseconds, in which any given race is only reported once"
 	default 3000
 	help
-	  Any given data race is only reported once in the defined time window.
-	  Different data races may still generate reports within a duration
-	  that is smaller than the duration defined here. This allows rate
-	  limiting reporting to avoid flooding the console with reports.
-	  Setting this to 0 disables rate limiting.
+	  Any given race is only reported once in the defined time window.
+	  Different races may still generate reports within a duration that is
+	  smaller than the duration defined here. This allows rate limiting
+	  reporting to avoid flooding the console with reports.  Setting this
+	  to 0 disables rate limiting.
 
 # The main purpose of the below options is to control reported data races (e.g.
 # in fuzzer configs), and are not expected to be switched frequently by other
