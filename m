Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D0F381CB0BE
	for <lists+linux-tip-commits@lfdr.de>; Fri,  8 May 2020 15:46:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728341AbgEHNqo (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 8 May 2020 09:46:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728336AbgEHNqn (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 8 May 2020 09:46:43 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 553FAC05BD0B;
        Fri,  8 May 2020 06:46:43 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jX3Kq-0001nW-Ma; Fri, 08 May 2020 15:46:41 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 4885B1C03AB;
        Fri,  8 May 2020 15:46:35 +0200 (CEST)
Date:   Fri, 08 May 2020 13:46:35 -0000
From:   "tip-bot2 for Marco Elver" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/kcsan] kcsan: Avoid blocking producers in prepare_report()
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
        Marco Elver <elver@google.com>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <158894559518.8414.2767267085879359171.tip-bot2@tip-bot2>
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

Commit-ID:     6119418f94ca5314392d258d27eb0cb58bb1774e
Gitweb:        https://git.kernel.org/tip/6119418f94ca5314392d258d27eb0cb58bb1774e
Author:        Marco Elver <elver@google.com>
AuthorDate:    Wed, 18 Mar 2020 18:38:45 +01:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Mon, 13 Apr 2020 17:18:11 -07:00

kcsan: Avoid blocking producers in prepare_report()

To avoid deadlock in case watchers can be interrupted, we need to ensure
that producers of the struct other_info can never be blocked by an
unrelated consumer. (Likely to occur with KCSAN_INTERRUPT_WATCHER.)

There are several cases that can lead to this scenario, for example:

	1. A watchpoint A was set up by task T1, but interrupted by
	   interrupt I1. Some other thread (task or interrupt) finds
	   watchpoint A consumes it, and sets other_info. Then I1 also
	   finds some unrelated watchpoint B, consumes it, but is blocked
	   because other_info is in use. T1 cannot consume other_info
	   because I1 never returns -> deadlock.

	2. A watchpoint A was set up by task T1, but interrupted by
	   interrupt I1, which also sets up a watchpoint B. Some other
	   thread finds watchpoint A, and consumes it and sets up
	   other_info with its information. Similarly some other thread
	   finds watchpoint B and consumes it, but is then blocked because
	   other_info is in use. When I1 continues it sees its watchpoint
	   was consumed, and that it must wait for other_info, which
	   currently contains information to be consumed by T1. However, T1
	   cannot unblock other_info because I1 never returns -> deadlock.

To avoid this, we need to ensure that producers of struct other_info
always have a usable other_info entry. This is obviously not the case
with only a single instance of struct other_info, as concurrent
producers must wait for the entry to be released by some consumer (which
may be locked up as illustrated above).

While it would be nice if producers could simply call kmalloc() and
append their instance of struct other_info to a list, we are very
limited in this code path: since KCSAN can instrument the allocators
themselves, calling kmalloc() could lead to deadlock or corrupted
allocator state.

Since producers of the struct other_info will always succeed at
try_consume_watchpoint(), preceding the call into kcsan_report(), we
know that the particular watchpoint slot cannot simply be reused or
consumed by another potential other_info producer. If we move removal of
a watchpoint after reporting (by the consumer of struct other_info), we
can see a consumed watchpoint as a held lock on elements of other_info,
if we create a one-to-one mapping of a watchpoint to an other_info
element.

Therefore, the simplest solution is to create an array of struct
other_info that is as large as the watchpoints array in core.c, and pass
the watchpoint index to kcsan_report() for producers and consumers, and
change watchpoints to be removed after reporting is done.

With a default config on a 64-bit system, the array other_infos consumes
~37KiB. For most systems today this is not a problem. On smaller memory
constrained systems, the config value CONFIG_KCSAN_NUM_WATCHPOINTS can
be reduced appropriately.

Overall, this change is a simplification of the prepare_report() code,
and makes some of the checks (such as checking if at least one access is
a write) redundant.

Tested:
$ tools/testing/selftests/rcutorture/bin/kvm.sh \
	--cpus 12 --duration 10 --kconfig "CONFIG_DEBUG_INFO=y \
	CONFIG_KCSAN=y CONFIG_KCSAN_ASSUME_PLAIN_WRITES_ATOMIC=n \
	CONFIG_KCSAN_REPORT_VALUE_CHANGE_ONLY=n \
	CONFIG_KCSAN_REPORT_ONCE_IN_MS=100000 CONFIG_KCSAN_VERBOSE=y \
	CONFIG_KCSAN_INTERRUPT_WATCHER=y CONFIG_PROVE_LOCKING=y" \
	--configs TREE03
=> No longer hangs and runs to completion as expected.

Reported-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Marco Elver <elver@google.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/kcsan/core.c   |  31 ++++--
 kernel/kcsan/kcsan.h  |   3 +-
 kernel/kcsan/report.c | 212 +++++++++++++++++++----------------------
 3 files changed, 124 insertions(+), 122 deletions(-)

diff --git a/kernel/kcsan/core.c b/kernel/kcsan/core.c
index f1c3862..4d8ea0f 100644
--- a/kernel/kcsan/core.c
+++ b/kernel/kcsan/core.c
@@ -69,7 +69,6 @@ static DEFINE_PER_CPU(struct kcsan_ctx, kcsan_cpu_ctx) = {
  *   slot=9:  [10, 11,  9]
  *   slot=63: [64, 65, 63]
  */
-#define NUM_SLOTS (1 + 2*KCSAN_CHECK_ADJACENT)
 #define SLOT_IDX(slot, i) (slot + ((i + KCSAN_CHECK_ADJACENT) % NUM_SLOTS))
 
 /*
@@ -171,12 +170,16 @@ try_consume_watchpoint(atomic_long_t *watchpoint, long encoded_watchpoint)
 	return atomic_long_try_cmpxchg_relaxed(watchpoint, &encoded_watchpoint, CONSUMED_WATCHPOINT);
 }
 
-/*
- * Return true if watchpoint was not touched, false if consumed.
- */
-static inline bool remove_watchpoint(atomic_long_t *watchpoint)
+/* Return true if watchpoint was not touched, false if already consumed. */
+static inline bool consume_watchpoint(atomic_long_t *watchpoint)
 {
-	return atomic_long_xchg_relaxed(watchpoint, INVALID_WATCHPOINT) != CONSUMED_WATCHPOINT;
+	return atomic_long_xchg_relaxed(watchpoint, CONSUMED_WATCHPOINT) != CONSUMED_WATCHPOINT;
+}
+
+/* Remove the watchpoint -- its slot may be reused after. */
+static inline void remove_watchpoint(atomic_long_t *watchpoint)
+{
+	atomic_long_set(watchpoint, INVALID_WATCHPOINT);
 }
 
 static __always_inline struct kcsan_ctx *get_ctx(void)
@@ -322,7 +325,8 @@ static noinline void kcsan_found_watchpoint(const volatile void *ptr,
 
 	if (consumed) {
 		kcsan_report(ptr, size, type, KCSAN_VALUE_CHANGE_MAYBE,
-			     KCSAN_REPORT_CONSUMED_WATCHPOINT);
+			     KCSAN_REPORT_CONSUMED_WATCHPOINT,
+			     watchpoint - watchpoints);
 	} else {
 		/*
 		 * The other thread may not print any diagnostics, as it has
@@ -470,7 +474,7 @@ kcsan_setup_watchpoint(const volatile void *ptr, size_t size, int type)
 		value_change = KCSAN_VALUE_CHANGE_TRUE;
 
 	/* Check if this access raced with another. */
-	if (!remove_watchpoint(watchpoint)) {
+	if (!consume_watchpoint(watchpoint)) {
 		/*
 		 * Depending on the access type, map a value_change of MAYBE to
 		 * TRUE (always report) or FALSE (never report).
@@ -500,7 +504,8 @@ kcsan_setup_watchpoint(const volatile void *ptr, size_t size, int type)
 		if (is_assert && value_change == KCSAN_VALUE_CHANGE_TRUE)
 			kcsan_counter_inc(KCSAN_COUNTER_ASSERT_FAILURES);
 
-		kcsan_report(ptr, size, type, value_change, KCSAN_REPORT_RACE_SIGNAL);
+		kcsan_report(ptr, size, type, value_change, KCSAN_REPORT_RACE_SIGNAL,
+			     watchpoint - watchpoints);
 	} else if (value_change == KCSAN_VALUE_CHANGE_TRUE) {
 		/* Inferring a race, since the value should not have changed. */
 
@@ -510,9 +515,15 @@ kcsan_setup_watchpoint(const volatile void *ptr, size_t size, int type)
 
 		if (IS_ENABLED(CONFIG_KCSAN_REPORT_RACE_UNKNOWN_ORIGIN) || is_assert)
 			kcsan_report(ptr, size, type, KCSAN_VALUE_CHANGE_TRUE,
-				     KCSAN_REPORT_RACE_UNKNOWN_ORIGIN);
+				     KCSAN_REPORT_RACE_UNKNOWN_ORIGIN,
+				     watchpoint - watchpoints);
 	}
 
+	/*
+	 * Remove watchpoint; must be after reporting, since the slot may be
+	 * reused after this point.
+	 */
+	remove_watchpoint(watchpoint);
 	kcsan_counter_dec(KCSAN_COUNTER_USED_WATCHPOINTS);
 out_unlock:
 	if (!kcsan_interrupt_watcher)
diff --git a/kernel/kcsan/kcsan.h b/kernel/kcsan/kcsan.h
index 6630dfe..763d6d0 100644
--- a/kernel/kcsan/kcsan.h
+++ b/kernel/kcsan/kcsan.h
@@ -12,6 +12,7 @@
 
 /* The number of adjacent watchpoints to check. */
 #define KCSAN_CHECK_ADJACENT 1
+#define NUM_SLOTS (1 + 2*KCSAN_CHECK_ADJACENT)
 
 extern unsigned int kcsan_udelay_task;
 extern unsigned int kcsan_udelay_interrupt;
@@ -136,6 +137,6 @@ enum kcsan_report_type {
  */
 extern void kcsan_report(const volatile void *ptr, size_t size, int access_type,
 			 enum kcsan_value_change value_change,
-			 enum kcsan_report_type type);
+			 enum kcsan_report_type type, int watchpoint_idx);
 
 #endif /* _KERNEL_KCSAN_KCSAN_H */
diff --git a/kernel/kcsan/report.c b/kernel/kcsan/report.c
index de234d1..ae0a383 100644
--- a/kernel/kcsan/report.c
+++ b/kernel/kcsan/report.c
@@ -30,9 +30,7 @@ struct access_info {
 
 /*
  * Other thread info: communicated from other racing thread to thread that set
- * up the watchpoint, which then prints the complete report atomically. Only
- * need one struct, as all threads should to be serialized regardless to print
- * the reports, with reporting being in the slow-path.
+ * up the watchpoint, which then prints the complete report atomically.
  */
 struct other_info {
 	struct access_info	ai;
@@ -59,7 +57,11 @@ struct other_info {
 	struct task_struct	*task;
 };
 
-static struct other_info other_infos[1];
+/*
+ * To never block any producers of struct other_info, we need as many elements
+ * as we have watchpoints (upper bound on concurrent races to report).
+ */
+static struct other_info other_infos[CONFIG_KCSAN_NUM_WATCHPOINTS + NUM_SLOTS-1];
 
 /*
  * Information about reported races; used to rate limit reporting.
@@ -96,10 +98,11 @@ struct report_time {
 static struct report_time report_times[REPORT_TIMES_SIZE];
 
 /*
- * This spinlock protects reporting and other_info, since other_info is usually
- * required when reporting.
+ * Spinlock serializing report generation, and access to @other_infos. Although
+ * it could make sense to have a finer-grained locking story for @other_infos,
+ * report generation needs to be serialized either way, so not much is gained.
  */
-static DEFINE_SPINLOCK(report_lock);
+static DEFINE_RAW_SPINLOCK(report_lock);
 
 /*
  * Checks if the race identified by thread frames frame1 and frame2 has
@@ -395,9 +398,13 @@ static bool print_report(enum kcsan_value_change value_change,
 static void release_report(unsigned long *flags, struct other_info *other_info)
 {
 	if (other_info)
-		other_info->ai.ptr = NULL; /* Mark for reuse. */
+		/*
+		 * Use size to denote valid/invalid, since KCSAN entirely
+		 * ignores 0-sized accesses.
+		 */
+		other_info->ai.size = 0;
 
-	spin_unlock_irqrestore(&report_lock, *flags);
+	raw_spin_unlock_irqrestore(&report_lock, *flags);
 }
 
 /*
@@ -435,14 +442,14 @@ static void set_other_info_task_blocking(unsigned long *flags,
 			 */
 			set_current_state(TASK_UNINTERRUPTIBLE);
 		}
-		spin_unlock_irqrestore(&report_lock, *flags);
+		raw_spin_unlock_irqrestore(&report_lock, *flags);
 		/*
 		 * We cannot call schedule() since we also cannot reliably
 		 * determine if sleeping here is permitted -- see in_atomic().
 		 */
 
 		udelay(1);
-		spin_lock_irqsave(&report_lock, *flags);
+		raw_spin_lock_irqsave(&report_lock, *flags);
 		if (timeout-- < 0) {
 			/*
 			 * Abort. Reset @other_info->task to NULL, since it
@@ -454,128 +461,107 @@ static void set_other_info_task_blocking(unsigned long *flags,
 			break;
 		}
 		/*
-		 * If @ptr nor @current matches, then our information has been
-		 * consumed and we may continue. If not, retry.
+		 * If invalid, or @ptr nor @current matches, then @other_info
+		 * has been consumed and we may continue. If not, retry.
 		 */
-	} while (other_info->ai.ptr == ai->ptr && other_info->task == current);
+	} while (other_info->ai.size && other_info->ai.ptr == ai->ptr &&
+		 other_info->task == current);
 	if (is_running)
 		set_current_state(TASK_RUNNING);
 }
 
-/*
- * Depending on the report type either sets other_info and returns false, or
- * acquires the matching other_info and returns true. If other_info is not
- * required for the report type, simply acquires report_lock and returns true.
- */
-static bool prepare_report(unsigned long *flags, enum kcsan_report_type type,
-			   const struct access_info *ai, struct other_info *other_info)
+/* Populate @other_info; requires that the provided @other_info not in use. */
+static void prepare_report_producer(unsigned long *flags,
+				    const struct access_info *ai,
+				    struct other_info *other_info)
 {
-	if (type != KCSAN_REPORT_CONSUMED_WATCHPOINT &&
-	    type != KCSAN_REPORT_RACE_SIGNAL) {
-		/* other_info not required; just acquire report_lock */
-		spin_lock_irqsave(&report_lock, *flags);
-		return true;
-	}
+	raw_spin_lock_irqsave(&report_lock, *flags);
 
-retry:
-	spin_lock_irqsave(&report_lock, *flags);
+	/*
+	 * The same @other_infos entry cannot be used concurrently, because
+	 * there is a one-to-one mapping to watchpoint slots (@watchpoints in
+	 * core.c), and a watchpoint is only released for reuse after reporting
+	 * is done by the consumer of @other_info. Therefore, it is impossible
+	 * for another concurrent prepare_report_producer() to set the same
+	 * @other_info, and are guaranteed exclusivity for the @other_infos
+	 * entry pointed to by @other_info.
+	 *
+	 * To check this property holds, size should never be non-zero here,
+	 * because every consumer of struct other_info resets size to 0 in
+	 * release_report().
+	 */
+	WARN_ON(other_info->ai.size);
 
-	switch (type) {
-	case KCSAN_REPORT_CONSUMED_WATCHPOINT:
-		if (other_info->ai.ptr)
-			break; /* still in use, retry */
+	other_info->ai = *ai;
+	other_info->num_stack_entries = stack_trace_save(other_info->stack_entries, NUM_STACK_ENTRIES, 2);
 
-		other_info->ai = *ai;
-		other_info->num_stack_entries = stack_trace_save(other_info->stack_entries, NUM_STACK_ENTRIES, 1);
+	if (IS_ENABLED(CONFIG_KCSAN_VERBOSE))
+		set_other_info_task_blocking(flags, ai, other_info);
 
-		if (IS_ENABLED(CONFIG_KCSAN_VERBOSE))
-			set_other_info_task_blocking(flags, ai, other_info);
+	raw_spin_unlock_irqrestore(&report_lock, *flags);
+}
 
-		spin_unlock_irqrestore(&report_lock, *flags);
+/* Awaits producer to fill @other_info and then returns. */
+static bool prepare_report_consumer(unsigned long *flags,
+				    const struct access_info *ai,
+				    struct other_info *other_info)
+{
 
-		/*
-		 * The other thread will print the summary; other_info may now
-		 * be consumed.
-		 */
-		return false;
+	raw_spin_lock_irqsave(&report_lock, *flags);
+	while (!other_info->ai.size) { /* Await valid @other_info. */
+		raw_spin_unlock_irqrestore(&report_lock, *flags);
+		cpu_relax();
+		raw_spin_lock_irqsave(&report_lock, *flags);
+	}
 
-	case KCSAN_REPORT_RACE_SIGNAL:
-		if (!other_info->ai.ptr)
-			break; /* no data available yet, retry */
+	/* Should always have a matching access based on watchpoint encoding. */
+	if (WARN_ON(!matching_access((unsigned long)other_info->ai.ptr & WATCHPOINT_ADDR_MASK, other_info->ai.size,
+				     (unsigned long)ai->ptr & WATCHPOINT_ADDR_MASK, ai->size)))
+		goto discard;
 
+	if (!matching_access((unsigned long)other_info->ai.ptr, other_info->ai.size,
+			     (unsigned long)ai->ptr, ai->size)) {
 		/*
-		 * First check if this is the other_info we are expecting, i.e.
-		 * matches based on how watchpoint was encoded.
+		 * If the actual accesses to not match, this was a false
+		 * positive due to watchpoint encoding.
 		 */
-		if (!matching_access((unsigned long)other_info->ai.ptr & WATCHPOINT_ADDR_MASK, other_info->ai.size,
-				     (unsigned long)ai->ptr & WATCHPOINT_ADDR_MASK, ai->size))
-			break; /* mismatching watchpoint, retry */
-
-		if (!matching_access((unsigned long)other_info->ai.ptr, other_info->ai.size,
-				     (unsigned long)ai->ptr, ai->size)) {
-			/*
-			 * If the actual accesses to not match, this was a false
-			 * positive due to watchpoint encoding.
-			 */
-			kcsan_counter_inc(KCSAN_COUNTER_ENCODING_FALSE_POSITIVES);
-
-			/* discard this other_info */
-			release_report(flags, other_info);
-			return false;
-		}
+		kcsan_counter_inc(KCSAN_COUNTER_ENCODING_FALSE_POSITIVES);
+		goto discard;
+	}
 
-		if (!((ai->access_type | other_info->ai.access_type) & KCSAN_ACCESS_WRITE)) {
-			/*
-			 * While the address matches, this is not the other_info
-			 * from the thread that consumed our watchpoint, since
-			 * neither this nor the access in other_info is a write.
-			 * It is invalid to continue with the report, since we
-			 * only have information about reads.
-			 *
-			 * This can happen due to concurrent races on the same
-			 * address, with at least 4 threads. To avoid locking up
-			 * other_info and all other threads, we have to consume
-			 * it regardless.
-			 *
-			 * A concrete case to illustrate why we might lock up if
-			 * we do not consume other_info:
-			 *
-			 *   We have 4 threads, all accessing the same address
-			 *   (or matching address ranges). Assume the following
-			 *   watcher and watchpoint consumer pairs:
-			 *   write1-read1, read2-write2. The first to populate
-			 *   other_info is write2, however, write1 consumes it,
-			 *   resulting in a report of write1-write2. This report
-			 *   is valid, however, now read1 populates other_info;
-			 *   read2-read1 is an invalid conflict, yet, no other
-			 *   conflicting access is left. Therefore, we must
-			 *   consume read1's other_info.
-			 *
-			 * Since this case is assumed to be rare, it is
-			 * reasonable to omit this report: one of the other
-			 * reports includes information about the same shared
-			 * data, and at this point the likelihood that we
-			 * re-report the same race again is high.
-			 */
-			release_report(flags, other_info);
-			return false;
-		}
+	return true;
 
-		/* Matching access in other_info. */
-		return true;
+discard:
+	release_report(flags, other_info);
+	return false;
+}
 
+/*
+ * Depending on the report type either sets @other_info and returns false, or
+ * awaits @other_info and returns true. If @other_info is not required for the
+ * report type, simply acquires @report_lock and returns true.
+ */
+static noinline bool prepare_report(unsigned long *flags,
+				    enum kcsan_report_type type,
+				    const struct access_info *ai,
+				    struct other_info *other_info)
+{
+	switch (type) {
+	case KCSAN_REPORT_CONSUMED_WATCHPOINT:
+		prepare_report_producer(flags, ai, other_info);
+		return false;
+	case KCSAN_REPORT_RACE_SIGNAL:
+		return prepare_report_consumer(flags, ai, other_info);
 	default:
-		BUG();
+		/* @other_info not required; just acquire @report_lock. */
+		raw_spin_lock_irqsave(&report_lock, *flags);
+		return true;
 	}
-
-	spin_unlock_irqrestore(&report_lock, *flags);
-
-	goto retry;
 }
 
 void kcsan_report(const volatile void *ptr, size_t size, int access_type,
 		  enum kcsan_value_change value_change,
-		  enum kcsan_report_type type)
+		  enum kcsan_report_type type, int watchpoint_idx)
 {
 	unsigned long flags = 0;
 	const struct access_info ai = {
@@ -586,7 +572,11 @@ void kcsan_report(const volatile void *ptr, size_t size, int access_type,
 		.cpu_id		= raw_smp_processor_id()
 	};
 	struct other_info *other_info = type == KCSAN_REPORT_RACE_UNKNOWN_ORIGIN
-					? NULL : &other_infos[0];
+					? NULL : &other_infos[watchpoint_idx];
+
+	kcsan_disable_current();
+	if (WARN_ON(watchpoint_idx < 0 || watchpoint_idx >= ARRAY_SIZE(other_infos)))
+		goto out;
 
 	/*
 	 * With TRACE_IRQFLAGS, lockdep's IRQ trace state becomes corrupted if
@@ -596,7 +586,6 @@ void kcsan_report(const volatile void *ptr, size_t size, int access_type,
 	 */
 	lockdep_off();
 
-	kcsan_disable_current();
 	if (prepare_report(&flags, type, &ai, other_info)) {
 		/*
 		 * Never report if value_change is FALSE, only if we it is
@@ -611,7 +600,8 @@ void kcsan_report(const volatile void *ptr, size_t size, int access_type,
 
 		release_report(&flags, other_info);
 	}
-	kcsan_enable_current();
 
 	lockdep_on();
+out:
+	kcsan_enable_current();
 }
