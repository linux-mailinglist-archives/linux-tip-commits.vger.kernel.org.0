Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A08F9319E8E
	for <lists+linux-tip-commits@lfdr.de>; Fri, 12 Feb 2021 13:38:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231551AbhBLMim (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 12 Feb 2021 07:38:42 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:45340 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231292AbhBLMhv (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 12 Feb 2021 07:37:51 -0500
Date:   Fri, 12 Feb 2021 12:37:08 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1613133429;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=edQ+MM5iWg6k0qNyA1pANTolq4FwY2MmMJsIZFqO1pA=;
        b=cE5LEOkNHoEg/60dE7yR9YEtQlKnlB3qVNY13psL6IrRm4qllBE5VDqAP5Ov4+tgdYHk66
        WyI2nINSJzWQeMpbqowyyMKn1iYx1iJQfXiNqR52AAtGuqWqhPPxnCT0M4SMBMg24Lea27
        EyJsx19hsLq1eLwu4zJWFldyY8R8eOvYQ70MZArw8dmVvyajXdHGAETN4+vb/BBuxtzxqu
        IOpvYOq8EMm6em6ltrihJdjrcQ01kttyxkASVm6j1aPmlUkQjIs+uGyepmJ4Ud//S7LkAH
        SMBoaQzxF6gVYMb1cB7rL7hCLbWPbU4+sD57eiKLybX1kHl4i1WCxgx3jGK4TQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1613133429;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=edQ+MM5iWg6k0qNyA1pANTolq4FwY2MmMJsIZFqO1pA=;
        b=343YWQvHmy3WvBcU3yoEC4IymaqF33CPJX30WCY0Zpmxe6JtBX0y41GMBcVe9u9GrPUsp0
        u4sp3cF5ZQteSxDA==
From:   "tip-bot2 for Paul E. McKenney" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] torture: Throttle VERBOSE_TOROUT_*() output
Cc:     "Paul E. McKenney" <paulmck@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <161313342848.23325.15188575390698123425.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the core/rcu branch of tip:

Commit-ID:     8a67a20bf257ca378d6e5588fbe4382966395ac8
Gitweb:        https://git.kernel.org/tip/8a67a20bf257ca378d6e5588fbe4382966395ac8
Author:        Paul E. McKenney <paulmck@kernel.org>
AuthorDate:    Wed, 25 Nov 2020 13:00:04 -08:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Wed, 06 Jan 2021 17:17:21 -08:00

torture: Throttle VERBOSE_TOROUT_*() output

This commit adds kernel boot parameters torture.verbose_sleep_frequency
and torture.verbose_sleep_duration, which allow VERBOSE_TOROUT_*() output
to be throttled with periodic sleeps on large systems.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 Documentation/admin-guide/kernel-parameters.txt |  8 ++++++-
 include/linux/torture.h                         | 15 ++++++++++--
 kernel/torture.c                                | 20 ++++++++++++++++-
 3 files changed, 41 insertions(+), 2 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 3244f9e..18f3aa7 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -5337,6 +5337,14 @@
 			are running concurrently, especially on systems
 			with rotating-rust storage.
 
+	torture.verbose_sleep_frequency= [KNL]
+			Specifies how many verbose printk()s should be
+			emitted between each sleep.  The default of zero
+			disables verbose-printk() sleeping.
+
+	torture.verbose_sleep_duration= [KNL]
+			Duration of each verbose-printk() sleep in jiffies.
+
 	tp720=		[HW,PS2]
 
 	tpm_suspend_pcr=[HW,TPM]
diff --git a/include/linux/torture.h b/include/linux/torture.h
index 32941f8..d62d13c 100644
--- a/include/linux/torture.h
+++ b/include/linux/torture.h
@@ -32,9 +32,20 @@
 #define TOROUT_STRING(s) \
 	pr_alert("%s" TORTURE_FLAG " %s\n", torture_type, s)
 #define VERBOSE_TOROUT_STRING(s) \
-	do { if (verbose) pr_alert("%s" TORTURE_FLAG " %s\n", torture_type, s); } while (0)
+do {										\
+	if (verbose) {								\
+		verbose_torout_sleep();						\
+		pr_alert("%s" TORTURE_FLAG " %s\n", torture_type, s);		\
+	}									\
+} while (0)
 #define VERBOSE_TOROUT_ERRSTRING(s) \
-	do { if (verbose) pr_alert("%s" TORTURE_FLAG "!!! %s\n", torture_type, s); } while (0)
+do {										\
+	if (verbose) {								\
+		verbose_torout_sleep();						\
+		pr_alert("%s" TORTURE_FLAG "!!! %s\n", torture_type, s);	\
+	}									\
+} while (0)
+void verbose_torout_sleep(void);
 
 /* Definitions for online/offline exerciser. */
 typedef void torture_ofl_func(void);
diff --git a/kernel/torture.c b/kernel/torture.c
index 7ad5c96..93eeeb2 100644
--- a/kernel/torture.c
+++ b/kernel/torture.c
@@ -48,6 +48,12 @@ module_param(disable_onoff_at_boot, bool, 0444);
 static bool ftrace_dump_at_shutdown;
 module_param(ftrace_dump_at_shutdown, bool, 0444);
 
+static int verbose_sleep_frequency;
+module_param(verbose_sleep_frequency, int, 0444);
+
+static int verbose_sleep_duration = 1;
+module_param(verbose_sleep_duration, int, 0444);
+
 static char *torture_type;
 static int verbose;
 
@@ -58,6 +64,20 @@ static int verbose;
 static int fullstop = FULLSTOP_RMMOD;
 static DEFINE_MUTEX(fullstop_mutex);
 
+static atomic_t verbose_sleep_counter;
+
+/*
+ * Sleep if needed from VERBOSE_TOROUT*().
+ */
+void verbose_torout_sleep(void)
+{
+	if (verbose_sleep_frequency > 0 &&
+	    verbose_sleep_duration > 0 &&
+	    !(atomic_inc_return(&verbose_sleep_counter) % verbose_sleep_frequency))
+		schedule_timeout_uninterruptible(verbose_sleep_duration);
+}
+EXPORT_SYMBOL_GPL(verbose_torout_sleep);
+
 /*
  * Schedule a high-resolution-timer sleep in nanoseconds, with a 32-bit
  * nanosecond random fuzz.  This function and its friends desynchronize
