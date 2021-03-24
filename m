Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D3F77347262
	for <lists+linux-tip-commits@lfdr.de>; Wed, 24 Mar 2021 08:23:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232994AbhCXHWu (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 24 Mar 2021 03:22:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235828AbhCXHWc (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 24 Mar 2021 03:22:32 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDC5CC061763;
        Wed, 24 Mar 2021 00:22:31 -0700 (PDT)
Date:   Wed, 24 Mar 2021 07:22:29 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1616570550;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=B+XEENhMgQEr8MuTkQ4U15iXnkqHnDn1jZgb3aA/7jw=;
        b=gnAB9IpNf/g1WdXlti7RAJEEcPIiB3cXXv6aEOjWatARZTDdUdVsbqQ051uxDSDp5R8VSw
        XdaY8hATveM55lJ7+X38MQ3UB8mcyub+UodM7/hyxHHoBifb8Ys0nN+ZYWuR8SUY90LD4n
        dvQLuwKL4Sw2nMB6duKF701kD1kEFN+qPUe0I7VgVMydFG8Eget5JVd/uaTBXzGwlwb4xH
        LBBpMH9pSxRerneKX9pEiyeftDOBciFPxre92PeTBZOcFYj0FMzEHLHYrIwqzJY9JZXKMv
        98wVqWK3CzFk3lZ987Hfhg4I8HOjoyvpXLDbuk0szFaveWjor0Ev4hnCiNY0eA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1616570550;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=B+XEENhMgQEr8MuTkQ4U15iXnkqHnDn1jZgb3aA/7jw=;
        b=EMvYnuZT4LfmLSqO0vsMQWNCfNaT6vL2Gm/FKHHxkg+UoklVtemFB2Q5tASs/G0x4g4f2D
        tHPWgOz56fA5DpDg==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] locking/rtmutex: Move rt_mutex_debug_task_free()
 to rtmutex.c
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210323213708.096477462@linutronix.de>
References: <20210323213708.096477462@linutronix.de>
MIME-Version: 1.0
Message-ID: <161657054952.398.2028399395160226585.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     1238b7032101ba420a114f64b86a8e3de609d0e8
Gitweb:        https://git.kernel.org/tip/1238b7032101ba420a114f64b86a8e3de609d0e8
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Tue, 23 Mar 2021 22:30:25 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Wed, 24 Mar 2021 08:06:07 +01:00

locking/rtmutex: Move rt_mutex_debug_task_free() to rtmutex.c

Prepare for removing the header maze.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/20210323213708.096477462@linutronix.de
---
 kernel/locking/rtmutex-debug.c | 6 ------
 kernel/locking/rtmutex.c       | 8 ++++++++
 2 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/kernel/locking/rtmutex-debug.c b/kernel/locking/rtmutex-debug.c
index df584c9..f1a83ec 100644
--- a/kernel/locking/rtmutex-debug.c
+++ b/kernel/locking/rtmutex-debug.c
@@ -32,12 +32,6 @@
 
 #include "rtmutex_common.h"
 
-void rt_mutex_debug_task_free(struct task_struct *task)
-{
-	DEBUG_LOCKS_WARN_ON(!RB_EMPTY_ROOT(&task->pi_waiters.rb_root));
-	DEBUG_LOCKS_WARN_ON(task->pi_blocked_on);
-}
-
 void debug_rt_mutex_unlock(struct rt_mutex *lock)
 {
 	DEBUG_LOCKS_WARN_ON(rt_mutex_owner(lock) != current);
diff --git a/kernel/locking/rtmutex.c b/kernel/locking/rtmutex.c
index 82cb963..a18ee0c 100644
--- a/kernel/locking/rtmutex.c
+++ b/kernel/locking/rtmutex.c
@@ -1814,3 +1814,11 @@ bool rt_mutex_cleanup_proxy_lock(struct rt_mutex *lock,
 
 	return cleanup;
 }
+
+#ifdef CONFIG_DEBUG_RT_MUTEXES
+void rt_mutex_debug_task_free(struct task_struct *task)
+{
+	DEBUG_LOCKS_WARN_ON(!RB_EMPTY_ROOT(&task->pi_waiters.rb_root));
+	DEBUG_LOCKS_WARN_ON(task->pi_blocked_on);
+}
+#endif
