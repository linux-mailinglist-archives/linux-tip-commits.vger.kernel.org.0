Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C10BA375A18
	for <lists+linux-tip-commits@lfdr.de>; Thu,  6 May 2021 20:20:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234152AbhEFSVr (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Thu, 6 May 2021 14:21:47 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:41884 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230138AbhEFSVp (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Thu, 6 May 2021 14:21:45 -0400
Date:   Thu, 06 May 2021 18:20:44 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1620325245;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=V9Be9jAP4gTJZlsnC9/9+In65r3/XOTjN8L1tr9qPKw=;
        b=fw+WlzeLEitnLmSJlnqEHdWFzhKuH01zkOtXQMfVQmAkzdCN3JoeIerJ6sCEppBII6hjvF
        a0dbx4jifXFs8qwg8BLoRrU+GtHzdVs8rVo7HsXw1s2o1kXAy1Nr7nG7ejWIkG0Xbq30Ee
        A7q3NT0dVp2El53GtwKiDckZ0Gd9ATdCu6Rv4WOYXfFlWXW6+dfcd5o9Z+KffGQoAAnnJ+
        jwjQOZTBGy9UrhJi3seEmuz9gTMjZlN8X8eREGHfMSjOYpUiip71fSpItcAcAg1vX0ZL6D
        o+d1lt4stsSiApoToOlJaSmQzwNZ0MKLYwcLQ6tmkugqKEqKxFlGdF2Sz0oCZQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1620325245;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=V9Be9jAP4gTJZlsnC9/9+In65r3/XOTjN8L1tr9qPKw=;
        b=xYEy2LzZXhFvqFFOM/ohEAhJuBMlWEIvlbqXrqHq5mLgf2IMfE04uOlx2iqR6Z5LaUoVRg
        4BCa/K2X1P0HUwCg==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/urgent] futex: Make syscall entry points less convoluted
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210422194705.244476369@linutronix.de>
References: <20210422194705.244476369@linutronix.de>
MIME-Version: 1.0
Message-ID: <162032524497.29796.5753341794689744127.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the locking/urgent branch of tip:

Commit-ID:     51cf94d16860a324e97d1b670d88f1f2b643bc32
Gitweb:        https://git.kernel.org/tip/51cf94d16860a324e97d1b670d88f1f2b643bc32
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Thu, 22 Apr 2021 21:44:21 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 06 May 2021 20:19:04 +02:00

futex: Make syscall entry points less convoluted

The futex and the compat syscall entry points do pretty much the same
except for the timespec data types and the corresponding copy from
user function.

Split out the rest into inline functions and share the functionality.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/r/20210422194705.244476369@linutronix.de

---
 kernel/futex.c | 63 ++++++++++++++++++++++++++++---------------------
 1 file changed, 37 insertions(+), 26 deletions(-)

diff --git a/kernel/futex.c b/kernel/futex.c
index 4ddfdce..4938a00 100644
--- a/kernel/futex.c
+++ b/kernel/futex.c
@@ -3757,30 +3757,48 @@ long do_futex(u32 __user *uaddr, int op, u32 val, ktime_t *timeout,
 	return -ENOSYS;
 }
 
+static __always_inline bool futex_cmd_has_timeout(u32 cmd)
+{
+	switch (cmd) {
+	case FUTEX_WAIT:
+	case FUTEX_LOCK_PI:
+	case FUTEX_WAIT_BITSET:
+	case FUTEX_WAIT_REQUEUE_PI:
+		return true;
+	}
+	return false;
+}
+
+static __always_inline int
+futex_init_timeout(u32 cmd, u32 op, struct timespec64 *ts, ktime_t *t)
+{
+	if (!timespec64_valid(ts))
+		return -EINVAL;
+
+	*t = timespec64_to_ktime(*ts);
+	if (cmd == FUTEX_WAIT)
+		*t = ktime_add_safe(ktime_get(), *t);
+	else if (cmd != FUTEX_LOCK_PI && !(op & FUTEX_CLOCK_REALTIME))
+		*t = timens_ktime_to_host(CLOCK_MONOTONIC, *t);
+	return 0;
+}
 
 SYSCALL_DEFINE6(futex, u32 __user *, uaddr, int, op, u32, val,
 		const struct __kernel_timespec __user *, utime,
 		u32 __user *, uaddr2, u32, val3)
 {
-	struct timespec64 ts;
+	int ret, cmd = op & FUTEX_CMD_MASK;
 	ktime_t t, *tp = NULL;
-	int cmd = op & FUTEX_CMD_MASK;
+	struct timespec64 ts;
 
-	if (utime && (cmd == FUTEX_WAIT || cmd == FUTEX_LOCK_PI ||
-		      cmd == FUTEX_WAIT_BITSET ||
-		      cmd == FUTEX_WAIT_REQUEUE_PI)) {
+	if (utime && futex_cmd_has_timeout(cmd)) {
 		if (unlikely(should_fail_futex(!(op & FUTEX_PRIVATE_FLAG))))
 			return -EFAULT;
 		if (get_timespec64(&ts, utime))
 			return -EFAULT;
-		if (!timespec64_valid(&ts))
-			return -EINVAL;
-
-		t = timespec64_to_ktime(ts);
-		if (cmd == FUTEX_WAIT)
-			t = ktime_add_safe(ktime_get(), t);
-		else if (cmd != FUTEX_LOCK_PI && !(op & FUTEX_CLOCK_REALTIME))
-			t = timens_ktime_to_host(CLOCK_MONOTONIC, t);
+		ret = futex_init_timeout(cmd, op, &ts, &t);
+		if (ret)
+			return ret;
 		tp = &t;
 	}
 
@@ -3950,23 +3968,16 @@ SYSCALL_DEFINE6(futex_time32, u32 __user *, uaddr, int, op, u32, val,
 		const struct old_timespec32 __user *, utime, u32 __user *, uaddr2,
 		u32, val3)
 {
-	struct timespec64 ts;
+	int ret, cmd = op & FUTEX_CMD_MASK;
 	ktime_t t, *tp = NULL;
-	int cmd = op & FUTEX_CMD_MASK;
+	struct timespec64 ts;
 
-	if (utime && (cmd == FUTEX_WAIT || cmd == FUTEX_LOCK_PI ||
-		      cmd == FUTEX_WAIT_BITSET ||
-		      cmd == FUTEX_WAIT_REQUEUE_PI)) {
+	if (utime && futex_cmd_has_timeout(cmd)) {
 		if (get_old_timespec32(&ts, utime))
 			return -EFAULT;
-		if (!timespec64_valid(&ts))
-			return -EINVAL;
-
-		t = timespec64_to_ktime(ts);
-		if (cmd == FUTEX_WAIT)
-			t = ktime_add_safe(ktime_get(), t);
-		else if (cmd != FUTEX_LOCK_PI && !(op & FUTEX_CLOCK_REALTIME))
-			t = timens_ktime_to_host(CLOCK_MONOTONIC, t);
+		ret = futex_init_timeout(cmd, op, &ts, &t);
+		if (ret)
+			return ret;
 		tp = &t;
 	}
 
