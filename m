Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5BF893B842C
	for <lists+linux-tip-commits@lfdr.de>; Wed, 30 Jun 2021 15:50:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235851AbhF3NxB (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 30 Jun 2021 09:53:01 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:33026 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236058AbhF3NvZ (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 30 Jun 2021 09:51:25 -0400
Date:   Wed, 30 Jun 2021 13:48:17 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1625060898;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=asIRImexd2CORy/ClBuX7rSZeaLYtiA101oYf6/P/Ag=;
        b=a7UYWpLJQsX9R2z3J9R6ARTp+BWvgBUAAdNO5ryNZu5Z7g4i4pjgl4M0GaW+DLbMlyFBAc
        rSbFkERaTE+msi6an2aFZAR8sMzKE6r9lWcomWbKvOviuzalOTLnazyk9KGBD22dzVMymd
        gb6uE4TD69PqrO88oH8XcWzD0tWvjmXBS7ETwds75ZiRPytjDULyqbMx/EVGShmCb5HVjp
        N92MxGpBDhDz8uHQzwTVDa3HoYTJpQT0qO4JdgLGd/M2WpAvNxLngtu1zNEQ7DOr3edeq6
        LRAn007NVyn/cI1K3OHtO3sA6Pnpojde9ELa/zZ4Wk0Er8iBUm4M3/9J4Y/RgQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1625060898;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=asIRImexd2CORy/ClBuX7rSZeaLYtiA101oYf6/P/Ag=;
        b=ckDAJ5OAFgXfYhygX2TTHsUFBsCruEEU9KbTPxej5HReztKPaC0reJ8Ny7XtGD/gA2bCz1
        AqweOFFxR44c3LDg==
From:   "tip-bot2 for Mark Rutland" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/urgent] kcsan: Remove kcsan_report_type
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Marco Elver <elver@google.com>,
        "Paul E. McKenney" <paulmck@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <162506089763.395.5645478182976908324.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the locking/urgent branch of tip:

Commit-ID:     609f809746458522a7a96132acf0ca7ee67c424c
Gitweb:        https://git.kernel.org/tip/609f809746458522a7a96132acf0ca7ee67c424c
Author:        Mark Rutland <mark.rutland@arm.com>
AuthorDate:    Wed, 14 Apr 2021 13:28:23 +02:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Tue, 18 May 2021 10:58:15 -07:00

kcsan: Remove kcsan_report_type

Now that the reporting code has been refactored, it's clear by
construction that print_report() can only be passed
KCSAN_REPORT_RACE_SIGNAL or KCSAN_REPORT_RACE_UNKNOWN_ORIGIN, and these
can also be distinguished by the presence of `other_info`.

Let's simplify things and remove the report type enum, and instead let's
check `other_info` to distinguish these cases. This allows us to remove
code for cases which are impossible and generally makes the code simpler.

There should be no functional change as a result of this patch.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
[ elver@google.com: add updated comments to kcsan_report_*() functions ]
Signed-off-by: Marco Elver <elver@google.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/kcsan/kcsan.h  | 33 +++++++++++++--------------------
 kernel/kcsan/report.c | 29 +++++++----------------------
 2 files changed, 20 insertions(+), 42 deletions(-)

diff --git a/kernel/kcsan/kcsan.h b/kernel/kcsan/kcsan.h
index 2ee43fd..572f119 100644
--- a/kernel/kcsan/kcsan.h
+++ b/kernel/kcsan/kcsan.h
@@ -116,32 +116,25 @@ enum kcsan_value_change {
 	KCSAN_VALUE_CHANGE_TRUE,
 };
 
-enum kcsan_report_type {
-	/*
-	 * The thread that set up the watchpoint and briefly stalled was
-	 * signalled that another thread triggered the watchpoint.
-	 */
-	KCSAN_REPORT_RACE_SIGNAL,
-
-	/*
-	 * A thread found and consumed a matching watchpoint.
-	 */
-	KCSAN_REPORT_CONSUMED_WATCHPOINT,
-
-	/*
-	 * No other thread was observed to race with the access, but the data
-	 * value before and after the stall differs.
-	 */
-	KCSAN_REPORT_RACE_UNKNOWN_ORIGIN,
-};
-
 /*
- * Notify the report code that a race occurred.
+ * The calling thread hit and consumed a watchpoint: set the access information
+ * to be consumed by the reporting thread. No report is printed yet.
  */
 void kcsan_report_set_info(const volatile void *ptr, size_t size, int access_type,
 			   int watchpoint_idx);
+
+/*
+ * The calling thread observed that the watchpoint it set up was hit and
+ * consumed: print the full report based on information set by the racing
+ * thread.
+ */
 void kcsan_report_known_origin(const volatile void *ptr, size_t size, int access_type,
 			       enum kcsan_value_change value_change, int watchpoint_idx);
+
+/*
+ * No other thread was observed to race with the access, but the data value
+ * before and after the stall differs. Reports a race of "unknown origin".
+ */
 void kcsan_report_unknown_origin(const volatile void *ptr, size_t size, int access_type);
 
 #endif /* _KERNEL_KCSAN_KCSAN_H */
diff --git a/kernel/kcsan/report.c b/kernel/kcsan/report.c
index ba924f1..50cee23 100644
--- a/kernel/kcsan/report.c
+++ b/kernel/kcsan/report.c
@@ -326,7 +326,6 @@ static void print_verbose_info(struct task_struct *task)
 }
 
 static void print_report(enum kcsan_value_change value_change,
-			 enum kcsan_report_type type,
 			 const struct access_info *ai,
 			 const struct other_info *other_info)
 {
@@ -343,7 +342,7 @@ static void print_report(enum kcsan_value_change value_change,
 	if (skip_report(KCSAN_VALUE_CHANGE_TRUE, stack_entries[skipnr]))
 		return;
 
-	if (type == KCSAN_REPORT_RACE_SIGNAL) {
+	if (other_info) {
 		other_skipnr = get_stack_skipnr(other_info->stack_entries,
 						other_info->num_stack_entries);
 		other_frame = other_info->stack_entries[other_skipnr];
@@ -358,8 +357,7 @@ static void print_report(enum kcsan_value_change value_change,
 
 	/* Print report header. */
 	pr_err("==================================================================\n");
-	switch (type) {
-	case KCSAN_REPORT_RACE_SIGNAL: {
+	if (other_info) {
 		int cmp;
 
 		/*
@@ -371,22 +369,15 @@ static void print_report(enum kcsan_value_change value_change,
 		       get_bug_type(ai->access_type | other_info->ai.access_type),
 		       (void *)(cmp < 0 ? other_frame : this_frame),
 		       (void *)(cmp < 0 ? this_frame : other_frame));
-	} break;
-
-	case KCSAN_REPORT_RACE_UNKNOWN_ORIGIN:
+	} else {
 		pr_err("BUG: KCSAN: %s in %pS\n", get_bug_type(ai->access_type),
 		       (void *)this_frame);
-		break;
-
-	default:
-		BUG();
 	}
 
 	pr_err("\n");
 
 	/* Print information about the racing accesses. */
-	switch (type) {
-	case KCSAN_REPORT_RACE_SIGNAL:
+	if (other_info) {
 		pr_err("%s to 0x%px of %zu bytes by %s on cpu %i:\n",
 		       get_access_type(other_info->ai.access_type), other_info->ai.ptr,
 		       other_info->ai.size, get_thread_desc(other_info->ai.task_pid),
@@ -404,16 +395,10 @@ static void print_report(enum kcsan_value_change value_change,
 		pr_err("%s to 0x%px of %zu bytes by %s on cpu %i:\n",
 		       get_access_type(ai->access_type), ai->ptr, ai->size,
 		       get_thread_desc(ai->task_pid), ai->cpu_id);
-		break;
-
-	case KCSAN_REPORT_RACE_UNKNOWN_ORIGIN:
+	} else {
 		pr_err("race at unknown origin, with %s to 0x%px of %zu bytes by %s on cpu %i:\n",
 		       get_access_type(ai->access_type), ai->ptr, ai->size,
 		       get_thread_desc(ai->task_pid), ai->cpu_id);
-		break;
-
-	default:
-		BUG();
 	}
 	/* Print stack trace of this thread. */
 	stack_trace_print(stack_entries + skipnr, num_stack_entries - skipnr,
@@ -623,7 +608,7 @@ void kcsan_report_known_origin(const volatile void *ptr, size_t size, int access
 	 * be done once we know the full stack trace in print_report().
 	 */
 	if (value_change != KCSAN_VALUE_CHANGE_FALSE)
-		print_report(value_change, KCSAN_REPORT_RACE_SIGNAL, &ai, other_info);
+		print_report(value_change, &ai, other_info);
 
 	release_report(&flags, other_info);
 out:
@@ -640,7 +625,7 @@ void kcsan_report_unknown_origin(const volatile void *ptr, size_t size, int acce
 	lockdep_off(); /* See kcsan_report_known_origin(). */
 
 	raw_spin_lock_irqsave(&report_lock, flags);
-	print_report(KCSAN_VALUE_CHANGE_TRUE, KCSAN_REPORT_RACE_UNKNOWN_ORIGIN, &ai, NULL);
+	print_report(KCSAN_VALUE_CHANGE_TRUE, &ai, NULL);
 	raw_spin_unlock_irqrestore(&report_lock, flags);
 
 	lockdep_on();
