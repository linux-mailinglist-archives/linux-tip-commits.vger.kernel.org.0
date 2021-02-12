Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 42909319ECB
	for <lists+linux-tip-commits@lfdr.de>; Fri, 12 Feb 2021 13:42:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231652AbhBLMlQ (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 12 Feb 2021 07:41:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230260AbhBLMkB (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 12 Feb 2021 07:40:01 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1797C0617AB;
        Fri, 12 Feb 2021 04:37:13 -0800 (PST)
Date:   Fri, 12 Feb 2021 12:37:09 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1613133430;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=q8tZTeStUgUkOmKGGZEhWAUdTKqJmMSQXOkOUd8QaqE=;
        b=EB69wBL7Ql95IZcG86kWfO5MvqD2C5p27taWvn1WN7z7Vej+IoSc3hgkpMjqSDT4qEKsjB
        Opz+ESxA040zRupC8Dvk1eeo6+oPggPMwx1TnHGYwMcGY4apx/O4IvLLZ+rLe/pr+7tDOF
        TyOQJvTZ1PhJN0Utbjcjzx07WWrGtWSDx5P/KFOlH9XuKVpcypZjizobuuJVzLIKXaHqNO
        GkKczvdInqsJjzoLpZE9RLkNlhdZCBoi+nt4pyuUzarzTZfaMBlpKbtpv0TKq16njYL6Ya
        TCPX0hcaBOvtILD5eRbxmgw+UPRbpS1jYGFGQrIF0EM46VgZoGPyRyzXPqOpGQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1613133430;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=q8tZTeStUgUkOmKGGZEhWAUdTKqJmMSQXOkOUd8QaqE=;
        b=Wn/uT8PayGEQ+doFhgEAFGxiyHzZs/0eCHMf5zHJSvVXy/e/PkGS5khEQ4BPz26Lr3abPS
        /f16Jn/F1v7owsDg==
From:   "tip-bot2 for Paul E. McKenney" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] torture: Add fuzzed hrtimer-based sleep functions
Cc:     "Paul E. McKenney" <paulmck@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <161313342977.23325.11204289325171029680.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the core/rcu branch of tip:

Commit-ID:     ae19aaafae95a5487469433e9cae4c208f8d15cd
Gitweb:        https://git.kernel.org/tip/ae19aaafae95a5487469433e9cae4c208f8d15cd
Author:        Paul E. McKenney <paulmck@kernel.org>
AuthorDate:    Tue, 17 Nov 2020 11:30:18 -08:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Wed, 06 Jan 2021 17:17:19 -08:00

torture: Add fuzzed hrtimer-based sleep functions

This commit adds torture_hrtimeout_ns(), torture_hrtimeout_us(),
torture_hrtimeout_ms(), torture_hrtimeout_jiffies(), and
torture_hrtimeout_s(), each of which uses hrtimers to block for a fuzzed
time interval.  These functions are intended to be used by the various
torture tests to decouple wakeups from the timer wheel, thus providing
more opportunity for Murphy to insert destructive race conditions.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 include/linux/torture.h |  7 ++++-
 kernel/torture.c        | 75 ++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 82 insertions(+)

diff --git a/include/linux/torture.h b/include/linux/torture.h
index 7f65bd1..32941f8 100644
--- a/include/linux/torture.h
+++ b/include/linux/torture.h
@@ -61,6 +61,13 @@ static inline void torture_random_init(struct torture_random_state *trsp)
 	trsp->trs_count = 0;
 }
 
+/* Definitions for high-resolution-timer sleeps. */
+int torture_hrtimeout_ns(ktime_t baset_ns, u32 fuzzt_ns, struct torture_random_state *trsp);
+int torture_hrtimeout_us(u32 baset_us, u32 fuzzt_ns, struct torture_random_state *trsp);
+int torture_hrtimeout_ms(u32 baset_ms, u32 fuzzt_us, struct torture_random_state *trsp);
+int torture_hrtimeout_jiffies(u32 baset_j, struct torture_random_state *trsp);
+int torture_hrtimeout_s(u32 baset_s, u32 fuzzt_ms, struct torture_random_state *trsp);
+
 /* Task shuffler, which causes CPUs to occasionally go idle. */
 void torture_shuffle_task_register(struct task_struct *tp);
 int torture_shuffle_init(long shuffint);
diff --git a/kernel/torture.c b/kernel/torture.c
index 8562ac1..7548634 100644
--- a/kernel/torture.c
+++ b/kernel/torture.c
@@ -58,6 +58,81 @@ static int verbose;
 static int fullstop = FULLSTOP_RMMOD;
 static DEFINE_MUTEX(fullstop_mutex);
 
+/*
+ * Schedule a high-resolution-timer sleep in nanoseconds, with a 32-bit
+ * nanosecond random fuzz.  This function and its friends desynchronize
+ * testing from the timer wheel.
+ */
+int torture_hrtimeout_ns(ktime_t baset_ns, u32 fuzzt_ns, struct torture_random_state *trsp)
+{
+	ktime_t hto = baset_ns;
+
+	if (trsp)
+		hto += (torture_random(trsp) >> 3) % fuzzt_ns;
+	set_current_state(TASK_UNINTERRUPTIBLE);
+	return schedule_hrtimeout(&hto, HRTIMER_MODE_REL);
+}
+EXPORT_SYMBOL_GPL(torture_hrtimeout_ns);
+
+/*
+ * Schedule a high-resolution-timer sleep in microseconds, with a 32-bit
+ * nanosecond (not microsecond!) random fuzz.
+ */
+int torture_hrtimeout_us(u32 baset_us, u32 fuzzt_ns, struct torture_random_state *trsp)
+{
+	ktime_t baset_ns = baset_us * NSEC_PER_USEC;
+
+	return torture_hrtimeout_ns(baset_ns, fuzzt_ns, trsp);
+}
+EXPORT_SYMBOL_GPL(torture_hrtimeout_us);
+
+/*
+ * Schedule a high-resolution-timer sleep in milliseconds, with a 32-bit
+ * microsecond (not millisecond!) random fuzz.
+ */
+int torture_hrtimeout_ms(u32 baset_ms, u32 fuzzt_us, struct torture_random_state *trsp)
+{
+	ktime_t baset_ns = baset_ms * NSEC_PER_MSEC;
+	u32 fuzzt_ns;
+
+	if ((u32)~0U / NSEC_PER_USEC < fuzzt_us)
+		fuzzt_ns = (u32)~0U;
+	else
+		fuzzt_ns = fuzzt_us * NSEC_PER_USEC;
+	return torture_hrtimeout_ns(baset_ns, fuzzt_ns, trsp);
+}
+EXPORT_SYMBOL_GPL(torture_hrtimeout_ms);
+
+/*
+ * Schedule a high-resolution-timer sleep in jiffies, with an
+ * implied one-jiffy random fuzz.  This is intended to replace calls to
+ * schedule_timeout_interruptible() and friends.
+ */
+int torture_hrtimeout_jiffies(u32 baset_j, struct torture_random_state *trsp)
+{
+	ktime_t baset_ns = jiffies_to_nsecs(baset_j);
+
+	return torture_hrtimeout_ns(baset_ns, jiffies_to_nsecs(1), trsp);
+}
+EXPORT_SYMBOL_GPL(torture_hrtimeout_jiffies);
+
+/*
+ * Schedule a high-resolution-timer sleep in milliseconds, with a 32-bit
+ * millisecond (not second!) random fuzz.
+ */
+int torture_hrtimeout_s(u32 baset_s, u32 fuzzt_ms, struct torture_random_state *trsp)
+{
+	ktime_t baset_ns = baset_s * NSEC_PER_SEC;
+	u32 fuzzt_ns;
+
+	if ((u32)~0U / NSEC_PER_MSEC < fuzzt_ms)
+		fuzzt_ns = (u32)~0U;
+	else
+		fuzzt_ns = fuzzt_ms * NSEC_PER_MSEC;
+	return torture_hrtimeout_ns(baset_ns, fuzzt_ns, trsp);
+}
+EXPORT_SYMBOL_GPL(torture_hrtimeout_s);
+
 #ifdef CONFIG_HOTPLUG_CPU
 
 /*
