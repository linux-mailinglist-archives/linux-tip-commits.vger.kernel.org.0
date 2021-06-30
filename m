Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 349CA3B843D
	for <lists+linux-tip-commits@lfdr.de>; Wed, 30 Jun 2021 15:51:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236281AbhF3Nxp (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 30 Jun 2021 09:53:45 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:33042 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236277AbhF3Nvw (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 30 Jun 2021 09:51:52 -0400
Date:   Wed, 30 Jun 2021 13:48:20 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1625060901;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=WbhG5K/DAlaA8sj/bkjbcGBZM76qKBXyps7VbMXIcF0=;
        b=ozKW3q6oPE98XZLo9to5Ovugsv1Hd9ivEe1kYprLj+iJqaDYz8f6tUm1QapKZxQuz/PjA8
        Ojo8iHWhTxITShsvLgZ5butliEsuHR5bnCXY50AzjG+Ca7hhHeiexYv3deuPZ/KtR0Q1Q3
        zJDHnKJ6AUOB0RgFbWR+PVQWIy8tEtf2FW4ZZQjf7mTf9nV3w0ZpRbw6lWng8tMcqHpcil
        uNrTlqvhypxjrL5/vshLCRZd++g8elD1OK4rKEht1RvfUvuoLD4tDpRpNI95JCfKLiHQMy
        Rih/QbjZ/SomGoiTjvdzvfWpFfCcphfWkDEGuApsq32k0ACPVLea6l4CxvI6DA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1625060901;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=WbhG5K/DAlaA8sj/bkjbcGBZM76qKBXyps7VbMXIcF0=;
        b=gna2LYwB8E16fAcuCH4/sBMGTzwe5YkP3DWJicWp5u30vQB3SUhu3HnMx9AAnZyDH6aFlq
        msmVRgySXn4UjsAQ==
From:   "tip-bot2 for Mark Rutland" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/urgent] kcsan: Distinguish kcsan_report() calls
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Marco Elver <elver@google.com>,
        "Paul E. McKenney" <paulmck@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <162506090031.395.5409627985213398818.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the locking/urgent branch of tip:

Commit-ID:     793c2579beefa95894fc0afbbdc1a80a4e3bf306
Gitweb:        https://git.kernel.org/tip/793c2579beefa95894fc0afbbdc1a80a4e3bf306
Author:        Mark Rutland <mark.rutland@arm.com>
AuthorDate:    Wed, 14 Apr 2021 13:28:18 +02:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Tue, 18 May 2021 10:58:14 -07:00

kcsan: Distinguish kcsan_report() calls

Currently kcsan_report() is used to handle three distinct cases:

* The caller hit a watchpoint when attempting an access. Some
  information regarding the caller and access are recorded, but no
  output is produced.

* A caller which previously setup a watchpoint detected that the
  watchpoint has been hit, and possibly detected a change to the
  location in memory being watched. This may result in output reporting
  the interaction between this caller and the caller which hit the
  watchpoint.

* A caller detected a change to a modification to a memory location
  which wasn't detected by a watchpoint, for which there is no
  information on the other thread. This may result in output reporting
  the unexpected change.

... depending on the specific case the caller has distinct pieces of
information available, but the prototype of kcsan_report() has to handle
all three cases. This means that in some cases we pass redundant
information, and in others we don't pass all the information we could
pass. This also means that the report code has to demux these three
cases.

So that we can pass some additional information while also simplifying
the callers and report code, add separate kcsan_report_*() functions for
the distinct cases, updating callers accordingly. As the watchpoint_idx
is unused in the case of kcsan_report_unknown_origin(), this passes a
dummy value into kcsan_report(). Subsequent patches will refactor the
report code to avoid this.

There should be no functional change as a result of this patch.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
[ elver@google.com: try to make kcsan_report_*() names more descriptive ]
Signed-off-by: Marco Elver <elver@google.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/kcsan/core.c   | 12 ++++--------
 kernel/kcsan/kcsan.h  | 10 ++++++----
 kernel/kcsan/report.c | 26 +++++++++++++++++++++++---
 3 files changed, 33 insertions(+), 15 deletions(-)

diff --git a/kernel/kcsan/core.c b/kernel/kcsan/core.c
index d360183..6fe1513 100644
--- a/kernel/kcsan/core.c
+++ b/kernel/kcsan/core.c
@@ -380,9 +380,7 @@ static noinline void kcsan_found_watchpoint(const volatile void *ptr,
 
 	if (consumed) {
 		kcsan_save_irqtrace(current);
-		kcsan_report(ptr, size, type, KCSAN_VALUE_CHANGE_MAYBE,
-			     KCSAN_REPORT_CONSUMED_WATCHPOINT,
-			     watchpoint - watchpoints);
+		kcsan_report_set_info(ptr, size, type, watchpoint - watchpoints);
 		kcsan_restore_irqtrace(current);
 	} else {
 		/*
@@ -558,8 +556,8 @@ kcsan_setup_watchpoint(const volatile void *ptr, size_t size, int type)
 		if (is_assert && value_change == KCSAN_VALUE_CHANGE_TRUE)
 			atomic_long_inc(&kcsan_counters[KCSAN_COUNTER_ASSERT_FAILURES]);
 
-		kcsan_report(ptr, size, type, value_change, KCSAN_REPORT_RACE_SIGNAL,
-			     watchpoint - watchpoints);
+		kcsan_report_known_origin(ptr, size, type, value_change,
+					  watchpoint - watchpoints);
 	} else if (value_change == KCSAN_VALUE_CHANGE_TRUE) {
 		/* Inferring a race, since the value should not have changed. */
 
@@ -568,9 +566,7 @@ kcsan_setup_watchpoint(const volatile void *ptr, size_t size, int type)
 			atomic_long_inc(&kcsan_counters[KCSAN_COUNTER_ASSERT_FAILURES]);
 
 		if (IS_ENABLED(CONFIG_KCSAN_REPORT_RACE_UNKNOWN_ORIGIN) || is_assert)
-			kcsan_report(ptr, size, type, KCSAN_VALUE_CHANGE_TRUE,
-				     KCSAN_REPORT_RACE_UNKNOWN_ORIGIN,
-				     watchpoint - watchpoints);
+			kcsan_report_unknown_origin(ptr, size, type);
 	}
 
 	/*
diff --git a/kernel/kcsan/kcsan.h b/kernel/kcsan/kcsan.h
index 9881099..2ee43fd 100644
--- a/kernel/kcsan/kcsan.h
+++ b/kernel/kcsan/kcsan.h
@@ -136,10 +136,12 @@ enum kcsan_report_type {
 };
 
 /*
- * Print a race report from thread that encountered the race.
+ * Notify the report code that a race occurred.
  */
-extern void kcsan_report(const volatile void *ptr, size_t size, int access_type,
-			 enum kcsan_value_change value_change,
-			 enum kcsan_report_type type, int watchpoint_idx);
+void kcsan_report_set_info(const volatile void *ptr, size_t size, int access_type,
+			   int watchpoint_idx);
+void kcsan_report_known_origin(const volatile void *ptr, size_t size, int access_type,
+			       enum kcsan_value_change value_change, int watchpoint_idx);
+void kcsan_report_unknown_origin(const volatile void *ptr, size_t size, int access_type);
 
 #endif /* _KERNEL_KCSAN_KCSAN_H */
diff --git a/kernel/kcsan/report.c b/kernel/kcsan/report.c
index 13dce3c..5232bf2 100644
--- a/kernel/kcsan/report.c
+++ b/kernel/kcsan/report.c
@@ -598,9 +598,9 @@ static noinline bool prepare_report(unsigned long *flags,
 	}
 }
 
-void kcsan_report(const volatile void *ptr, size_t size, int access_type,
-		  enum kcsan_value_change value_change,
-		  enum kcsan_report_type type, int watchpoint_idx)
+static void kcsan_report(const volatile void *ptr, size_t size, int access_type,
+			 enum kcsan_value_change value_change,
+			 enum kcsan_report_type type, int watchpoint_idx)
 {
 	unsigned long flags = 0;
 	const struct access_info ai = {
@@ -645,3 +645,23 @@ void kcsan_report(const volatile void *ptr, size_t size, int access_type,
 out:
 	kcsan_enable_current();
 }
+
+void kcsan_report_set_info(const volatile void *ptr, size_t size, int access_type,
+			   int watchpoint_idx)
+{
+	kcsan_report(ptr, size, access_type, KCSAN_VALUE_CHANGE_MAYBE,
+		     KCSAN_REPORT_CONSUMED_WATCHPOINT, watchpoint_idx);
+}
+
+void kcsan_report_known_origin(const volatile void *ptr, size_t size, int access_type,
+			       enum kcsan_value_change value_change, int watchpoint_idx)
+{
+	kcsan_report(ptr, size, access_type, value_change,
+		     KCSAN_REPORT_RACE_SIGNAL, watchpoint_idx);
+}
+
+void kcsan_report_unknown_origin(const volatile void *ptr, size_t size, int access_type)
+{
+	kcsan_report(ptr, size, access_type, KCSAN_VALUE_CHANGE_TRUE,
+		     KCSAN_REPORT_RACE_UNKNOWN_ORIGIN, 0);
+}
