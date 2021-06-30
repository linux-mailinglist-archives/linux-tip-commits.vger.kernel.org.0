Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4ABC73B8429
	for <lists+linux-tip-commits@lfdr.de>; Wed, 30 Jun 2021 15:50:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235725AbhF3NxB (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 30 Jun 2021 09:53:01 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:33022 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236130AbhF3NvY (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 30 Jun 2021 09:51:24 -0400
Date:   Wed, 30 Jun 2021 13:48:17 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1625060897;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=RiBTXM3AqT1R5ffR45UV7ZMF3xcMw/MCd802PvzPjXM=;
        b=DAN7AlNxalj/uz4di5IjMT4cJqCi4/NGMHCOTZrlVw5GDrycObv09zmkdH3KlG2486/GmG
        kHdHYctsYx/vfZGTQo3JSre9Tla3EAUysyMqxgm1zcnRdvDcye80zgd1zAkxcanldeZzNf
        lAvSExYL+pAXE4eX4QbU2T9bRCV7EnBSUu+840Uj0d+nNdEGXkplqL8LeBwOeQuvlaHVq7
        4+QRK+N8UtsReMnlkszvi68w0/tGtYqZs2xSUoEu212w9l3ikdUzKTtJsXZyoy48ZgNahE
        6L3VMjSxlBzXwCZVNzsclC/ksnxQnfwQHHTN3bOq+wqfSw4PTZfJn48wBDFsbg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1625060897;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=RiBTXM3AqT1R5ffR45UV7ZMF3xcMw/MCd802PvzPjXM=;
        b=7kyz7H7Fpi0nl5JNrx7Ggrr8jgVI7dKOBoJZkV8ZVL7+5qDv9nUI2luXGsb7FJHQmLVizy
        UYJcGGBXKUyYBLBw==
From:   "tip-bot2 for Mark Rutland" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/urgent] kcsan: Report observed value changes
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Marco Elver <elver@google.com>,
        "Paul E. McKenney" <paulmck@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <162506089714.395.6467456436207971619.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the locking/urgent branch of tip:

Commit-ID:     7bbe6dc0ade7e394ee1568dc9979fd0e3e155435
Gitweb:        https://git.kernel.org/tip/7bbe6dc0ade7e394ee1568dc9979fd0e3e155435
Author:        Mark Rutland <mark.rutland@arm.com>
AuthorDate:    Wed, 14 Apr 2021 13:28:24 +02:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Tue, 18 May 2021 10:58:15 -07:00

kcsan: Report observed value changes

When a thread detects that a memory location was modified without its
watchpoint being hit, the report notes that a change was detected, but
does not provide concrete values for the change. Knowing the concrete
values can be very helpful in tracking down any racy writers (e.g. as
specific values may only be written in some portions of code, or under
certain conditions).

When we detect a modification, let's report the concrete old/new values,
along with the access's mask of relevant bits (and which relevant bits
were modified). This can make it easier to identify potential racy
writers. As the snapshots are at most 8 bytes, we can only report values
for acceses up to this size, but this appears to cater for the common
case.

When we detect a race via a watchpoint, we may or may not have concrete
values for the modification. To be helpful, let's attempt to log them
when we do as they can be ignored where irrelevant.

The resulting reports appears as follows, with values zero-padded to the
access width:

| ==================================================================
| BUG: KCSAN: data-race in el0_svc_common+0x34/0x25c arch/arm64/kernel/syscall.c:96
|
| race at unknown origin, with read to 0xffff00007ae6aa00 of 8 bytes by task 223 on cpu 1:
|  el0_svc_common+0x34/0x25c arch/arm64/kernel/syscall.c:96
|  do_el0_svc+0x48/0xec arch/arm64/kernel/syscall.c:178
|  el0_svc arch/arm64/kernel/entry-common.c:226 [inline]
|  el0_sync_handler+0x1a4/0x390 arch/arm64/kernel/entry-common.c:236
|  el0_sync+0x140/0x180 arch/arm64/kernel/entry.S:674
|
| value changed: 0x0000000000000000 -> 0x0000000000000002
|
| Reported by Kernel Concurrency Sanitizer on:
| CPU: 1 PID: 223 Comm: syz-executor.1 Not tainted 5.8.0-rc3-00094-ga73f923ecc8e-dirty #3
| Hardware name: linux,dummy-virt (DT)
| ==================================================================

If an access mask is set, it is shown underneath the "value changed"
line as "bits changed: 0x<bits changed> with mask 0x<non-zero mask>".

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
[ elver@google.com: align "value changed" and "bits changed" lines,
  which required massaging the message; do not print bits+mask if no
  mask set. ]
Signed-off-by: Marco Elver <elver@google.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/kcsan/core.c   |  5 +++--
 kernel/kcsan/kcsan.h  |  6 ++++--
 kernel/kcsan/report.c | 31 ++++++++++++++++++++++++++-----
 3 files changed, 33 insertions(+), 9 deletions(-)

diff --git a/kernel/kcsan/core.c b/kernel/kcsan/core.c
index 6fe1513..26709ea 100644
--- a/kernel/kcsan/core.c
+++ b/kernel/kcsan/core.c
@@ -557,7 +557,8 @@ kcsan_setup_watchpoint(const volatile void *ptr, size_t size, int type)
 			atomic_long_inc(&kcsan_counters[KCSAN_COUNTER_ASSERT_FAILURES]);
 
 		kcsan_report_known_origin(ptr, size, type, value_change,
-					  watchpoint - watchpoints);
+					  watchpoint - watchpoints,
+					  old, new, access_mask);
 	} else if (value_change == KCSAN_VALUE_CHANGE_TRUE) {
 		/* Inferring a race, since the value should not have changed. */
 
@@ -566,7 +567,7 @@ kcsan_setup_watchpoint(const volatile void *ptr, size_t size, int type)
 			atomic_long_inc(&kcsan_counters[KCSAN_COUNTER_ASSERT_FAILURES]);
 
 		if (IS_ENABLED(CONFIG_KCSAN_REPORT_RACE_UNKNOWN_ORIGIN) || is_assert)
-			kcsan_report_unknown_origin(ptr, size, type);
+			kcsan_report_unknown_origin(ptr, size, type, old, new, access_mask);
 	}
 
 	/*
diff --git a/kernel/kcsan/kcsan.h b/kernel/kcsan/kcsan.h
index 572f119..f36e25c 100644
--- a/kernel/kcsan/kcsan.h
+++ b/kernel/kcsan/kcsan.h
@@ -129,12 +129,14 @@ void kcsan_report_set_info(const volatile void *ptr, size_t size, int access_typ
  * thread.
  */
 void kcsan_report_known_origin(const volatile void *ptr, size_t size, int access_type,
-			       enum kcsan_value_change value_change, int watchpoint_idx);
+			       enum kcsan_value_change value_change, int watchpoint_idx,
+			       u64 old, u64 new, u64 mask);
 
 /*
  * No other thread was observed to race with the access, but the data value
  * before and after the stall differs. Reports a race of "unknown origin".
  */
-void kcsan_report_unknown_origin(const volatile void *ptr, size_t size, int access_type);
+void kcsan_report_unknown_origin(const volatile void *ptr, size_t size, int access_type,
+				 u64 old, u64 new, u64 mask);
 
 #endif /* _KERNEL_KCSAN_KCSAN_H */
diff --git a/kernel/kcsan/report.c b/kernel/kcsan/report.c
index 50cee23..e37e438 100644
--- a/kernel/kcsan/report.c
+++ b/kernel/kcsan/report.c
@@ -327,7 +327,8 @@ static void print_verbose_info(struct task_struct *task)
 
 static void print_report(enum kcsan_value_change value_change,
 			 const struct access_info *ai,
-			 const struct other_info *other_info)
+			 const struct other_info *other_info,
+			 u64 old, u64 new, u64 mask)
 {
 	unsigned long stack_entries[NUM_STACK_ENTRIES] = { 0 };
 	int num_stack_entries = stack_trace_save(stack_entries, NUM_STACK_ENTRIES, 1);
@@ -407,6 +408,24 @@ static void print_report(enum kcsan_value_change value_change,
 	if (IS_ENABLED(CONFIG_KCSAN_VERBOSE))
 		print_verbose_info(current);
 
+	/* Print observed value change. */
+	if (ai->size <= 8) {
+		int hex_len = ai->size * 2;
+		u64 diff = old ^ new;
+
+		if (mask)
+			diff &= mask;
+		if (diff) {
+			pr_err("\n");
+			pr_err("value changed: 0x%0*llx -> 0x%0*llx\n",
+			       hex_len, old, hex_len, new);
+			if (mask) {
+				pr_err(" bits changed: 0x%0*llx with mask 0x%0*llx\n",
+				       hex_len, diff, hex_len, mask);
+			}
+		}
+	}
+
 	/* Print report footer. */
 	pr_err("\n");
 	pr_err("Reported by Kernel Concurrency Sanitizer on:\n");
@@ -584,7 +603,8 @@ void kcsan_report_set_info(const volatile void *ptr, size_t size, int access_typ
 }
 
 void kcsan_report_known_origin(const volatile void *ptr, size_t size, int access_type,
-			       enum kcsan_value_change value_change, int watchpoint_idx)
+			       enum kcsan_value_change value_change, int watchpoint_idx,
+			       u64 old, u64 new, u64 mask)
 {
 	const struct access_info ai = prepare_access_info(ptr, size, access_type);
 	struct other_info *other_info = &other_infos[watchpoint_idx];
@@ -608,7 +628,7 @@ void kcsan_report_known_origin(const volatile void *ptr, size_t size, int access
 	 * be done once we know the full stack trace in print_report().
 	 */
 	if (value_change != KCSAN_VALUE_CHANGE_FALSE)
-		print_report(value_change, &ai, other_info);
+		print_report(value_change, &ai, other_info, old, new, mask);
 
 	release_report(&flags, other_info);
 out:
@@ -616,7 +636,8 @@ out:
 	kcsan_enable_current();
 }
 
-void kcsan_report_unknown_origin(const volatile void *ptr, size_t size, int access_type)
+void kcsan_report_unknown_origin(const volatile void *ptr, size_t size, int access_type,
+				 u64 old, u64 new, u64 mask)
 {
 	const struct access_info ai = prepare_access_info(ptr, size, access_type);
 	unsigned long flags;
@@ -625,7 +646,7 @@ void kcsan_report_unknown_origin(const volatile void *ptr, size_t size, int acce
 	lockdep_off(); /* See kcsan_report_known_origin(). */
 
 	raw_spin_lock_irqsave(&report_lock, flags);
-	print_report(KCSAN_VALUE_CHANGE_TRUE, &ai, NULL);
+	print_report(KCSAN_VALUE_CHANGE_TRUE, &ai, NULL, old, new, mask);
 	raw_spin_unlock_irqrestore(&report_lock, flags);
 
 	lockdep_on();
