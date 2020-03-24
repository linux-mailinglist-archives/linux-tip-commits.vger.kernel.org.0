Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B85521908C7
	for <lists+linux-tip-commits@lfdr.de>; Tue, 24 Mar 2020 10:13:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726845AbgCXJMg (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Tue, 24 Mar 2020 05:12:36 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:43717 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726129AbgCXJLB (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Tue, 24 Mar 2020 05:11:01 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jGfaJ-0007TS-JR; Tue, 24 Mar 2020 10:10:56 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 887641C0481;
        Tue, 24 Mar 2020 10:10:54 +0100 (CET)
Date:   Tue, 24 Mar 2020 09:10:54 -0000
From:   "tip-bot2 for Marco Elver" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/kcsan] kcsan: Introduce kcsan_value_change type
Cc:     John Hubbard <jhubbard@nvidia.com>, Marco Elver <elver@google.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Ingo Molnar <mingo@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <158504105423.28353.1408710911856962942.tip-bot2@tip-bot2>
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

Commit-ID:     b738f6169f1260b4ed5bd9f220b1c84d79f3ab8d
Gitweb:        https://git.kernel.org/tip/b738f6169f1260b4ed5bd9f220b1c84d79f3ab8d
Author:        Marco Elver <elver@google.com>
AuthorDate:    Tue, 11 Feb 2020 17:04:21 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Sat, 21 Mar 2020 09:44:03 +01:00

kcsan: Introduce kcsan_value_change type

Introduces kcsan_value_change type, which explicitly points out if we
either observed a value-change (TRUE), or we could not observe one but
cannot rule out a value-change happened (MAYBE). The MAYBE state can
either be reported or not, depending on configuration preferences.

A follow-up patch introduces the FALSE state, which should never be
reported.

No functional change intended.

Acked-by: John Hubbard <jhubbard@nvidia.com>
Signed-off-by: Marco Elver <elver@google.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 kernel/kcsan/core.c   | 38 ++++++++++++++++++++++----------------
 kernel/kcsan/kcsan.h  | 19 ++++++++++++++++++-
 kernel/kcsan/report.c | 26 ++++++++++++++------------
 3 files changed, 54 insertions(+), 29 deletions(-)

diff --git a/kernel/kcsan/core.c b/kernel/kcsan/core.c
index 498b1eb..3f89801 100644
--- a/kernel/kcsan/core.c
+++ b/kernel/kcsan/core.c
@@ -341,7 +341,7 @@ kcsan_setup_watchpoint(const volatile void *ptr, size_t size, int type)
 		u32 _4;
 		u64 _8;
 	} expect_value;
-	bool value_change = false;
+	enum kcsan_value_change value_change = KCSAN_VALUE_CHANGE_MAYBE;
 	unsigned long ua_flags = user_access_save();
 	unsigned long irq_flags;
 
@@ -398,6 +398,7 @@ kcsan_setup_watchpoint(const volatile void *ptr, size_t size, int type)
 	 * Read the current value, to later check and infer a race if the data
 	 * was modified via a non-instrumented access, e.g. from a device.
 	 */
+	expect_value._8 = 0;
 	switch (size) {
 	case 1:
 		expect_value._1 = READ_ONCE(*(const u8 *)ptr);
@@ -436,24 +437,37 @@ kcsan_setup_watchpoint(const volatile void *ptr, size_t size, int type)
 	 */
 	switch (size) {
 	case 1:
-		value_change = expect_value._1 != READ_ONCE(*(const u8 *)ptr);
+		expect_value._1 ^= READ_ONCE(*(const u8 *)ptr);
 		break;
 	case 2:
-		value_change = expect_value._2 != READ_ONCE(*(const u16 *)ptr);
+		expect_value._2 ^= READ_ONCE(*(const u16 *)ptr);
 		break;
 	case 4:
-		value_change = expect_value._4 != READ_ONCE(*(const u32 *)ptr);
+		expect_value._4 ^= READ_ONCE(*(const u32 *)ptr);
 		break;
 	case 8:
-		value_change = expect_value._8 != READ_ONCE(*(const u64 *)ptr);
+		expect_value._8 ^= READ_ONCE(*(const u64 *)ptr);
 		break;
 	default:
 		break; /* ignore; we do not diff the values */
 	}
 
+	/* Were we able to observe a value-change? */
+	if (expect_value._8 != 0)
+		value_change = KCSAN_VALUE_CHANGE_TRUE;
+
 	/* Check if this access raced with another. */
 	if (!remove_watchpoint(watchpoint)) {
 		/*
+		 * Depending on the access type, map a value_change of MAYBE to
+		 * TRUE (require reporting).
+		 */
+		if (value_change == KCSAN_VALUE_CHANGE_MAYBE && (size > 8 || is_assert)) {
+			/* Always assume a value-change. */
+			value_change = KCSAN_VALUE_CHANGE_TRUE;
+		}
+
+		/*
 		 * No need to increment 'data_races' counter, as the racing
 		 * thread already did.
 		 *
@@ -461,20 +475,12 @@ kcsan_setup_watchpoint(const volatile void *ptr, size_t size, int type)
 		 * therefore both this thread and the racing thread may
 		 * increment this counter.
 		 */
-		if (is_assert)
+		if (is_assert && value_change == KCSAN_VALUE_CHANGE_TRUE)
 			kcsan_counter_inc(KCSAN_COUNTER_ASSERT_FAILURES);
 
-		/*
-		 * - If we were not able to observe a value change due to size
-		 *   constraints, always assume a value change.
-		 * - If the access type is an assertion, we also always assume a
-		 *   value change to always report the race.
-		 */
-		value_change = value_change || size > 8 || is_assert;
-
 		kcsan_report(ptr, size, type, value_change, smp_processor_id(),
 			     KCSAN_REPORT_RACE_SIGNAL);
-	} else if (value_change) {
+	} else if (value_change == KCSAN_VALUE_CHANGE_TRUE) {
 		/* Inferring a race, since the value should not have changed. */
 
 		kcsan_counter_inc(KCSAN_COUNTER_RACES_UNKNOWN_ORIGIN);
@@ -482,7 +488,7 @@ kcsan_setup_watchpoint(const volatile void *ptr, size_t size, int type)
 			kcsan_counter_inc(KCSAN_COUNTER_ASSERT_FAILURES);
 
 		if (IS_ENABLED(CONFIG_KCSAN_REPORT_RACE_UNKNOWN_ORIGIN) || is_assert)
-			kcsan_report(ptr, size, type, true,
+			kcsan_report(ptr, size, type, KCSAN_VALUE_CHANGE_TRUE,
 				     smp_processor_id(),
 				     KCSAN_REPORT_RACE_UNKNOWN_ORIGIN);
 	}
diff --git a/kernel/kcsan/kcsan.h b/kernel/kcsan/kcsan.h
index 50078e7..83a79b0 100644
--- a/kernel/kcsan/kcsan.h
+++ b/kernel/kcsan/kcsan.h
@@ -88,6 +88,22 @@ extern void kcsan_counter_dec(enum kcsan_counter_id id);
  */
 extern bool kcsan_skip_report_debugfs(unsigned long func_addr);
 
+/*
+ * Value-change states.
+ */
+enum kcsan_value_change {
+	/*
+	 * Did not observe a value-change, however, it is valid to report the
+	 * race, depending on preferences.
+	 */
+	KCSAN_VALUE_CHANGE_MAYBE,
+
+	/*
+	 * The value was observed to change, and the race should be reported.
+	 */
+	KCSAN_VALUE_CHANGE_TRUE,
+};
+
 enum kcsan_report_type {
 	/*
 	 * The thread that set up the watchpoint and briefly stalled was
@@ -111,6 +127,7 @@ enum kcsan_report_type {
  * Print a race report from thread that encountered the race.
  */
 extern void kcsan_report(const volatile void *ptr, size_t size, int access_type,
-			 bool value_change, int cpu_id, enum kcsan_report_type type);
+			 enum kcsan_value_change value_change, int cpu_id,
+			 enum kcsan_report_type type);
 
 #endif /* _KERNEL_KCSAN_KCSAN_H */
diff --git a/kernel/kcsan/report.c b/kernel/kcsan/report.c
index abf6852..d871476 100644
--- a/kernel/kcsan/report.c
+++ b/kernel/kcsan/report.c
@@ -130,26 +130,27 @@ static bool rate_limit_report(unsigned long frame1, unsigned long frame2)
  * Special rules to skip reporting.
  */
 static bool
-skip_report(bool value_change, unsigned long top_frame)
+skip_report(enum kcsan_value_change value_change, unsigned long top_frame)
 {
 	/*
-	 * The first call to skip_report always has value_change==true, since we
+	 * The first call to skip_report always has value_change==TRUE, since we
 	 * cannot know the value written of an instrumented access. For the 2nd
 	 * call there are 6 cases with CONFIG_KCSAN_REPORT_VALUE_CHANGE_ONLY:
 	 *
-	 * 1. read watchpoint, conflicting write (value_change==true): report;
-	 * 2. read watchpoint, conflicting write (value_change==false): skip;
-	 * 3. write watchpoint, conflicting write (value_change==true): report;
-	 * 4. write watchpoint, conflicting write (value_change==false): skip;
-	 * 5. write watchpoint, conflicting read (value_change==false): skip;
-	 * 6. write watchpoint, conflicting read (value_change==true): report;
+	 * 1. read watchpoint, conflicting write (value_change==TRUE): report;
+	 * 2. read watchpoint, conflicting write (value_change==MAYBE): skip;
+	 * 3. write watchpoint, conflicting write (value_change==TRUE): report;
+	 * 4. write watchpoint, conflicting write (value_change==MAYBE): skip;
+	 * 5. write watchpoint, conflicting read (value_change==MAYBE): skip;
+	 * 6. write watchpoint, conflicting read (value_change==TRUE): report;
 	 *
 	 * Cases 1-4 are intuitive and expected; case 5 ensures we do not report
 	 * data races where the write may have rewritten the same value; case 6
 	 * is possible either if the size is larger than what we check value
 	 * changes for or the access type is KCSAN_ACCESS_ASSERT.
 	 */
-	if (IS_ENABLED(CONFIG_KCSAN_REPORT_VALUE_CHANGE_ONLY) && !value_change) {
+	if (IS_ENABLED(CONFIG_KCSAN_REPORT_VALUE_CHANGE_ONLY) &&
+	    value_change == KCSAN_VALUE_CHANGE_MAYBE) {
 		/*
 		 * The access is a write, but the data value did not change.
 		 *
@@ -245,7 +246,7 @@ static int sym_strcmp(void *addr1, void *addr2)
  * Returns true if a report was generated, false otherwise.
  */
 static bool print_report(const volatile void *ptr, size_t size, int access_type,
-			 bool value_change, int cpu_id,
+			 enum kcsan_value_change value_change, int cpu_id,
 			 enum kcsan_report_type type)
 {
 	unsigned long stack_entries[NUM_STACK_ENTRIES] = { 0 };
@@ -258,7 +259,7 @@ static bool print_report(const volatile void *ptr, size_t size, int access_type,
 	/*
 	 * Must check report filter rules before starting to print.
 	 */
-	if (skip_report(true, stack_entries[skipnr]))
+	if (skip_report(KCSAN_VALUE_CHANGE_TRUE, stack_entries[skipnr]))
 		return false;
 
 	if (type == KCSAN_REPORT_RACE_SIGNAL) {
@@ -477,7 +478,8 @@ retry:
 }
 
 void kcsan_report(const volatile void *ptr, size_t size, int access_type,
-		  bool value_change, int cpu_id, enum kcsan_report_type type)
+		  enum kcsan_value_change value_change, int cpu_id,
+		  enum kcsan_report_type type)
 {
 	unsigned long flags = 0;
 
