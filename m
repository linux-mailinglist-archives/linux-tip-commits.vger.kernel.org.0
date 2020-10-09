Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A692288445
	for <lists+linux-tip-commits@lfdr.de>; Fri,  9 Oct 2020 10:00:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732633AbgJIH7s (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 9 Oct 2020 03:59:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732489AbgJIH6s (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 9 Oct 2020 03:58:48 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10A51C0613D7;
        Fri,  9 Oct 2020 00:58:48 -0700 (PDT)
Date:   Fri, 09 Oct 2020 07:58:45 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1602230326;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=3pSb+/j1QO4ssbeXN6c1d2tqq3nnePDN15Nj6sft5rM=;
        b=ADKEclV+/aKWtcLnpnOaHBA4+mx/9oFookYpqIucpUVxGAmwdB2CHyeqXOH+OA7w+6EdCJ
        CPdVwgnMPOG1An/CcLyovr4G+BBkGTqSYdxt7wiJqdD9TOGTObZdoqePCLSDK+UqL9LK4F
        HYrNJ7aWY8Ky/WYzngkxSgeNkerWWfdJ+yjDBkVbloJPTs88hxgxFJGGvyvnug4vTsxM2s
        SHcfPHT4zaOLB78BqYQKImulgG9Rts+vgJWWrp2J1R2hOd7TYORkvQKwekbbwcEcQ2bMwX
        BUraW0XasvkBFi/+t+Gk9jozO+51v1FBzkTPv7Z+6rI/p3p5s/6J13E5nCJVfw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1602230326;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=3pSb+/j1QO4ssbeXN6c1d2tqq3nnePDN15Nj6sft5rM=;
        b=898BQangzDj4+sVkupZahNp1ooDuxiYhjVBf3JBhmjfYQ+nLbpcHWzMuX8SdzgIRf3VjTz
        hENv79FHucUx7qCw==
From:   "tip-bot2 for Marco Elver" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] kcsan: Optimize debugfs stats counters
Cc:     Marco Elver <elver@google.com>,
        "Paul E. McKenney" <paulmck@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <160223032587.7002.16410277386030073602.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     2e986b81f698e73c95e6456183f27b861f47bb87
Gitweb:        https://git.kernel.org/tip/2e986b81f698e73c95e6456183f27b861f47bb87
Author:        Marco Elver <elver@google.com>
AuthorDate:    Mon, 10 Aug 2020 10:06:25 +02:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Mon, 24 Aug 2020 15:10:23 -07:00

kcsan: Optimize debugfs stats counters

Remove kcsan_counter_inc/dec() functions, as they perform no other
logic, and are no longer needed.

This avoids several calls in kcsan_setup_watchpoint() and
kcsan_found_watchpoint(), as well as lets the compiler warn us about
potential out-of-bounds accesses as the array's size is known at all
usage sites at compile-time.

Signed-off-by: Marco Elver <elver@google.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/kcsan/core.c    | 22 +++++++++++-----------
 kernel/kcsan/debugfs.c | 21 +++++----------------
 kernel/kcsan/kcsan.h   | 12 ++++++------
 kernel/kcsan/report.c  |  2 +-
 4 files changed, 23 insertions(+), 34 deletions(-)

diff --git a/kernel/kcsan/core.c b/kernel/kcsan/core.c
index b176400..8a1ff60 100644
--- a/kernel/kcsan/core.c
+++ b/kernel/kcsan/core.c
@@ -367,13 +367,13 @@ static noinline void kcsan_found_watchpoint(const volatile void *ptr,
 		 * already removed the watchpoint, or another thread consumed
 		 * the watchpoint before this thread.
 		 */
-		kcsan_counter_inc(KCSAN_COUNTER_REPORT_RACES);
+		atomic_long_inc(&kcsan_counters[KCSAN_COUNTER_REPORT_RACES]);
 	}
 
 	if ((type & KCSAN_ACCESS_ASSERT) != 0)
-		kcsan_counter_inc(KCSAN_COUNTER_ASSERT_FAILURES);
+		atomic_long_inc(&kcsan_counters[KCSAN_COUNTER_ASSERT_FAILURES]);
 	else
-		kcsan_counter_inc(KCSAN_COUNTER_DATA_RACES);
+		atomic_long_inc(&kcsan_counters[KCSAN_COUNTER_DATA_RACES]);
 
 	user_access_restore(flags);
 }
@@ -414,7 +414,7 @@ kcsan_setup_watchpoint(const volatile void *ptr, size_t size, int type)
 		goto out;
 
 	if (!check_encodable((unsigned long)ptr, size)) {
-		kcsan_counter_inc(KCSAN_COUNTER_UNENCODABLE_ACCESSES);
+		atomic_long_inc(&kcsan_counters[KCSAN_COUNTER_UNENCODABLE_ACCESSES]);
 		goto out;
 	}
 
@@ -434,12 +434,12 @@ kcsan_setup_watchpoint(const volatile void *ptr, size_t size, int type)
 		 * with which should_watch() returns true should be tweaked so
 		 * that this case happens very rarely.
 		 */
-		kcsan_counter_inc(KCSAN_COUNTER_NO_CAPACITY);
+		atomic_long_inc(&kcsan_counters[KCSAN_COUNTER_NO_CAPACITY]);
 		goto out_unlock;
 	}
 
-	kcsan_counter_inc(KCSAN_COUNTER_SETUP_WATCHPOINTS);
-	kcsan_counter_inc(KCSAN_COUNTER_USED_WATCHPOINTS);
+	atomic_long_inc(&kcsan_counters[KCSAN_COUNTER_SETUP_WATCHPOINTS]);
+	atomic_long_inc(&kcsan_counters[KCSAN_COUNTER_USED_WATCHPOINTS]);
 
 	/*
 	 * Read the current value, to later check and infer a race if the data
@@ -541,16 +541,16 @@ kcsan_setup_watchpoint(const volatile void *ptr, size_t size, int type)
 		 * increment this counter.
 		 */
 		if (is_assert && value_change == KCSAN_VALUE_CHANGE_TRUE)
-			kcsan_counter_inc(KCSAN_COUNTER_ASSERT_FAILURES);
+			atomic_long_inc(&kcsan_counters[KCSAN_COUNTER_ASSERT_FAILURES]);
 
 		kcsan_report(ptr, size, type, value_change, KCSAN_REPORT_RACE_SIGNAL,
 			     watchpoint - watchpoints);
 	} else if (value_change == KCSAN_VALUE_CHANGE_TRUE) {
 		/* Inferring a race, since the value should not have changed. */
 
-		kcsan_counter_inc(KCSAN_COUNTER_RACES_UNKNOWN_ORIGIN);
+		atomic_long_inc(&kcsan_counters[KCSAN_COUNTER_RACES_UNKNOWN_ORIGIN]);
 		if (is_assert)
-			kcsan_counter_inc(KCSAN_COUNTER_ASSERT_FAILURES);
+			atomic_long_inc(&kcsan_counters[KCSAN_COUNTER_ASSERT_FAILURES]);
 
 		if (IS_ENABLED(CONFIG_KCSAN_REPORT_RACE_UNKNOWN_ORIGIN) || is_assert)
 			kcsan_report(ptr, size, type, KCSAN_VALUE_CHANGE_TRUE,
@@ -563,7 +563,7 @@ kcsan_setup_watchpoint(const volatile void *ptr, size_t size, int type)
 	 * reused after this point.
 	 */
 	remove_watchpoint(watchpoint);
-	kcsan_counter_dec(KCSAN_COUNTER_USED_WATCHPOINTS);
+	atomic_long_dec(&kcsan_counters[KCSAN_COUNTER_USED_WATCHPOINTS]);
 out_unlock:
 	if (!kcsan_interrupt_watcher)
 		local_irq_restore(irq_flags);
diff --git a/kernel/kcsan/debugfs.c b/kernel/kcsan/debugfs.c
index 6c4914f..3c8093a 100644
--- a/kernel/kcsan/debugfs.c
+++ b/kernel/kcsan/debugfs.c
@@ -17,10 +17,7 @@
 
 #include "kcsan.h"
 
-/*
- * Statistics counters.
- */
-static atomic_long_t counters[KCSAN_COUNTER_COUNT];
+atomic_long_t kcsan_counters[KCSAN_COUNTER_COUNT];
 static const char *const counter_names[] = {
 	[KCSAN_COUNTER_USED_WATCHPOINTS]		= "used_watchpoints",
 	[KCSAN_COUNTER_SETUP_WATCHPOINTS]		= "setup_watchpoints",
@@ -53,16 +50,6 @@ static struct {
 };
 static DEFINE_SPINLOCK(report_filterlist_lock);
 
-void kcsan_counter_inc(enum kcsan_counter_id id)
-{
-	atomic_long_inc(&counters[id]);
-}
-
-void kcsan_counter_dec(enum kcsan_counter_id id)
-{
-	atomic_long_dec(&counters[id]);
-}
-
 /*
  * The microbenchmark allows benchmarking KCSAN core runtime only. To run
  * multiple threads, pipe 'microbench=<iters>' from multiple tasks into the
@@ -206,8 +193,10 @@ static int show_info(struct seq_file *file, void *v)
 
 	/* show stats */
 	seq_printf(file, "enabled: %i\n", READ_ONCE(kcsan_enabled));
-	for (i = 0; i < KCSAN_COUNTER_COUNT; ++i)
-		seq_printf(file, "%s: %ld\n", counter_names[i], atomic_long_read(&counters[i]));
+	for (i = 0; i < KCSAN_COUNTER_COUNT; ++i) {
+		seq_printf(file, "%s: %ld\n", counter_names[i],
+			   atomic_long_read(&kcsan_counters[i]));
+	}
 
 	/* show filter functions, and filter type */
 	spin_lock_irqsave(&report_filterlist_lock, flags);
diff --git a/kernel/kcsan/kcsan.h b/kernel/kcsan/kcsan.h
index 2948001..8d4bf34 100644
--- a/kernel/kcsan/kcsan.h
+++ b/kernel/kcsan/kcsan.h
@@ -8,6 +8,7 @@
 #ifndef _KERNEL_KCSAN_KCSAN_H
 #define _KERNEL_KCSAN_KCSAN_H
 
+#include <linux/atomic.h>
 #include <linux/kcsan.h>
 #include <linux/sched.h>
 
@@ -34,6 +35,10 @@ void kcsan_restore_irqtrace(struct task_struct *task);
  */
 void kcsan_debugfs_init(void);
 
+/*
+ * Statistics counters displayed via debugfs; should only be modified in
+ * slow-paths.
+ */
 enum kcsan_counter_id {
 	/*
 	 * Number of watchpoints currently in use.
@@ -86,12 +91,7 @@ enum kcsan_counter_id {
 
 	KCSAN_COUNTER_COUNT, /* number of counters */
 };
-
-/*
- * Increment/decrement counter with given id; avoid calling these in fast-path.
- */
-extern void kcsan_counter_inc(enum kcsan_counter_id id);
-extern void kcsan_counter_dec(enum kcsan_counter_id id);
+extern atomic_long_t kcsan_counters[KCSAN_COUNTER_COUNT];
 
 /*
  * Returns true if data races in the function symbol that maps to func_addr
diff --git a/kernel/kcsan/report.c b/kernel/kcsan/report.c
index bf1d594..d3bf87e 100644
--- a/kernel/kcsan/report.c
+++ b/kernel/kcsan/report.c
@@ -559,7 +559,7 @@ static bool prepare_report_consumer(unsigned long *flags,
 		 * If the actual accesses to not match, this was a false
 		 * positive due to watchpoint encoding.
 		 */
-		kcsan_counter_inc(KCSAN_COUNTER_ENCODING_FALSE_POSITIVES);
+		atomic_long_inc(&kcsan_counters[KCSAN_COUNTER_ENCODING_FALSE_POSITIVES]);
 		goto discard;
 	}
 
