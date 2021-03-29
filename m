Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C8E1034D4E9
	for <lists+linux-tip-commits@lfdr.de>; Mon, 29 Mar 2021 18:25:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231366AbhC2QYf (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Mon, 29 Mar 2021 12:24:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231341AbhC2QYM (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Mon, 29 Mar 2021 12:24:12 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27309C061756;
        Mon, 29 Mar 2021 09:24:12 -0700 (PDT)
Date:   Mon, 29 Mar 2021 16:24:09 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1617035049;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+3sd0tg6nz4+7cSSkJ9jW6T2k5nwpz3paX8xCo0u++U=;
        b=AzmRp5zj1/i75mi6a3x1jfPBVHXvHXTZu5SquWAhNQLceZkKs/UPdJe3++hyepznF/pz85
        tzW9F+lXKyVV7eVtwkcid5iXz7M6HVx462YNc323/EgnAyaYXQQtF+HJFIMGiJZhL56oPQ
        YyQP34ZbTl8pCLB/F2IQyZRt1wvTaZncuV22T89y/M32WrJ6o/WK3Tdn0mzf0UZnen8tKE
        k/2miZ+2CXZliMJPivA5IPQFnCGJzuhH3EbtlzeFL2Ce0fW0xCaOBr7xtI/p6gFXhWhIBV
        ItnKDAYeshq1B4F/n+0rloU1nTCFWd7uPS1qZtqUSOZFfqgkSxt/5t7OJ2TGwQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1617035049;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+3sd0tg6nz4+7cSSkJ9jW6T2k5nwpz3paX8xCo0u++U=;
        b=rNc9Q9m0GQK1j9hzVuiDJn1PKhEhZNw8O7dAMFBfkWA0wvAqwGBQi44tli1/EHhHALeVKM
        IsPJO9xUhBWDyICw==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] locking/rtmutex: Move debug functions as inlines
 into common header
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210326153944.052454464@linutronix.de>
References: <20210326153944.052454464@linutronix.de>
MIME-Version: 1.0
Message-ID: <161703504930.29796.8475510831044647868.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     f41dcc18698e660668a33cde8ab965e0298ac341
Gitweb:        https://git.kernel.org/tip/f41dcc18698e660668a33cde8ab965e0298ac341
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Fri, 26 Mar 2021 16:29:39 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Mon, 29 Mar 2021 15:57:04 +02:00

locking/rtmutex: Move debug functions as inlines into common header

There is no value in having two header files providing just empty stubs and
a C file which implements trivial debug functions which can just be inlined.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/r/20210326153944.052454464@linutronix.de
---
 kernel/locking/Makefile         |  2 +-
 kernel/locking/rtmutex-debug.c  | 65 +--------------------------------
 kernel/locking/rtmutex-debug.h  | 23 +-----------
 kernel/locking/rtmutex.h        | 24 +------------
 kernel/locking/rtmutex_common.h | 30 ++++++++++++---
 5 files changed, 25 insertions(+), 119 deletions(-)
 delete mode 100644 kernel/locking/rtmutex-debug.c
 delete mode 100644 kernel/locking/rtmutex-debug.h
 delete mode 100644 kernel/locking/rtmutex.h

diff --git a/kernel/locking/Makefile b/kernel/locking/Makefile
index 8838f1d..3572808 100644
--- a/kernel/locking/Makefile
+++ b/kernel/locking/Makefile
@@ -12,7 +12,6 @@ ifdef CONFIG_FUNCTION_TRACER
 CFLAGS_REMOVE_lockdep.o = $(CC_FLAGS_FTRACE)
 CFLAGS_REMOVE_lockdep_proc.o = $(CC_FLAGS_FTRACE)
 CFLAGS_REMOVE_mutex-debug.o = $(CC_FLAGS_FTRACE)
-CFLAGS_REMOVE_rtmutex-debug.o = $(CC_FLAGS_FTRACE)
 endif
 
 obj-$(CONFIG_DEBUG_IRQFLAGS) += irqflag-debug.o
@@ -26,7 +25,6 @@ obj-$(CONFIG_LOCK_SPIN_ON_OWNER) += osq_lock.o
 obj-$(CONFIG_PROVE_LOCKING) += spinlock.o
 obj-$(CONFIG_QUEUED_SPINLOCKS) += qspinlock.o
 obj-$(CONFIG_RT_MUTEXES) += rtmutex.o
-obj-$(CONFIG_DEBUG_RT_MUTEXES) += rtmutex-debug.o
 obj-$(CONFIG_DEBUG_SPINLOCK) += spinlock.o
 obj-$(CONFIG_DEBUG_SPINLOCK) += spinlock_debug.o
 obj-$(CONFIG_QUEUED_RWLOCKS) += qrwlock.o
diff --git a/kernel/locking/rtmutex-debug.c b/kernel/locking/rtmutex-debug.c
deleted file mode 100644
index f1a83ec..0000000
--- a/kernel/locking/rtmutex-debug.c
+++ /dev/null
@@ -1,65 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-/*
- * RT-Mutexes: blocking mutual exclusion locks with PI support
- *
- * started by Ingo Molnar and Thomas Gleixner:
- *
- *  Copyright (C) 2004-2006 Red Hat, Inc., Ingo Molnar <mingo@redhat.com>
- *  Copyright (C) 2006 Timesys Corp., Thomas Gleixner <tglx@timesys.com>
- *
- * This code is based on the rt.c implementation in the preempt-rt tree.
- * Portions of said code are
- *
- *  Copyright (C) 2004  LynuxWorks, Inc., Igor Manyilov, Bill Huey
- *  Copyright (C) 2006  Esben Nielsen
- *  Copyright (C) 2006  Kihon Technologies Inc.,
- *			Steven Rostedt <rostedt@goodmis.org>
- *
- * See rt.c in preempt-rt for proper credits and further information
- */
-#include <linux/sched.h>
-#include <linux/sched/rt.h>
-#include <linux/sched/debug.h>
-#include <linux/delay.h>
-#include <linux/export.h>
-#include <linux/spinlock.h>
-#include <linux/kallsyms.h>
-#include <linux/syscalls.h>
-#include <linux/interrupt.h>
-#include <linux/rbtree.h>
-#include <linux/fs.h>
-#include <linux/debug_locks.h>
-
-#include "rtmutex_common.h"
-
-void debug_rt_mutex_unlock(struct rt_mutex *lock)
-{
-	DEBUG_LOCKS_WARN_ON(rt_mutex_owner(lock) != current);
-}
-
-void debug_rt_mutex_proxy_unlock(struct rt_mutex *lock)
-{
-	DEBUG_LOCKS_WARN_ON(!rt_mutex_owner(lock));
-}
-
-void debug_rt_mutex_init_waiter(struct rt_mutex_waiter *waiter)
-{
-	memset(waiter, 0x11, sizeof(*waiter));
-}
-
-void debug_rt_mutex_free_waiter(struct rt_mutex_waiter *waiter)
-{
-	memset(waiter, 0x22, sizeof(*waiter));
-}
-
-void debug_rt_mutex_init(struct rt_mutex *lock, const char *name, struct lock_class_key *key)
-{
-	/*
-	 * Make sure we are not reinitializing a held lock:
-	 */
-	debug_check_no_locks_freed((void *)lock, sizeof(*lock));
-
-#ifdef CONFIG_DEBUG_LOCK_ALLOC
-	lockdep_init_map(&lock->dep_map, name, key, 0);
-#endif
-}
diff --git a/kernel/locking/rtmutex-debug.h b/kernel/locking/rtmutex-debug.h
deleted file mode 100644
index 392468d..0000000
--- a/kernel/locking/rtmutex-debug.h
+++ /dev/null
@@ -1,23 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-/*
- * RT-Mutexes: blocking mutual exclusion locks with PI support
- *
- * started by Ingo Molnar and Thomas Gleixner:
- *
- *  Copyright (C) 2004-2006 Red Hat, Inc., Ingo Molnar <mingo@redhat.com>
- *  Copyright (C) 2006, Timesys Corp., Thomas Gleixner <tglx@timesys.com>
- *
- * This file contains macros used solely by rtmutex.c. Debug version.
- */
-
-extern void debug_rt_mutex_init_waiter(struct rt_mutex_waiter *waiter);
-extern void debug_rt_mutex_free_waiter(struct rt_mutex_waiter *waiter);
-extern void debug_rt_mutex_init(struct rt_mutex *lock, const char *name, struct lock_class_key *key);
-extern void debug_rt_mutex_unlock(struct rt_mutex *lock);
-extern void debug_rt_mutex_proxy_unlock(struct rt_mutex *lock);
-
-static inline bool debug_rt_mutex_detect_deadlock(struct rt_mutex_waiter *waiter,
-						  enum rtmutex_chainwalk walk)
-{
-	return (waiter != NULL);
-}
diff --git a/kernel/locking/rtmutex.h b/kernel/locking/rtmutex.h
deleted file mode 100644
index 1e484ab..0000000
--- a/kernel/locking/rtmutex.h
+++ /dev/null
@@ -1,24 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-/*
- * RT-Mutexes: blocking mutual exclusion locks with PI support
- *
- * started by Ingo Molnar and Thomas Gleixner:
- *
- *  Copyright (C) 2004-2006 Red Hat, Inc., Ingo Molnar <mingo@redhat.com>
- *  Copyright (C) 2006, Timesys Corp., Thomas Gleixner <tglx@timesys.com>
- *
- * This file contains macros used solely by rtmutex.c.
- * Non-debug version.
- */
-
-#define debug_rt_mutex_init_waiter(w)			do { } while (0)
-#define debug_rt_mutex_free_waiter(w)			do { } while (0)
-#define debug_rt_mutex_proxy_unlock(l)			do { } while (0)
-#define debug_rt_mutex_unlock(l)			do { } while (0)
-#define debug_rt_mutex_init(m, n, k)			do { } while (0)
-
-static inline bool debug_rt_mutex_detect_deadlock(struct rt_mutex_waiter *w,
-						  enum rtmutex_chainwalk walk)
-{
-	return walk == RT_MUTEX_FULL_CHAINWALK;
-}
diff --git a/kernel/locking/rtmutex_common.h b/kernel/locking/rtmutex_common.h
index 41adf8b..a90c22a 100644
--- a/kernel/locking/rtmutex_common.h
+++ b/kernel/locking/rtmutex_common.h
@@ -13,6 +13,7 @@
 #ifndef __KERNEL_RTMUTEX_COMMON_H
 #define __KERNEL_RTMUTEX_COMMON_H
 
+#include <linux/debug_locks.h>
 #include <linux/rtmutex.h>
 #include <linux/sched/wake_q.h>
 
@@ -135,10 +136,29 @@ extern bool __rt_mutex_futex_unlock(struct rt_mutex *lock,
 
 extern void rt_mutex_postunlock(struct wake_q_head *wake_q);
 
-#ifdef CONFIG_DEBUG_RT_MUTEXES
-# include "rtmutex-debug.h"
-#else
-# include "rtmutex.h"
-#endif
+/* Debug functions */
+static inline void debug_rt_mutex_unlock(struct rt_mutex *lock)
+{
+	if (IS_ENABLED(CONFIG_DEBUG_RT_MUTEXES))
+		DEBUG_LOCKS_WARN_ON(rt_mutex_owner(lock) != current);
+}
+
+static inline void debug_rt_mutex_proxy_unlock(struct rt_mutex *lock)
+{
+	if (IS_ENABLED(CONFIG_DEBUG_RT_MUTEXES))
+		DEBUG_LOCKS_WARN_ON(!rt_mutex_owner(lock));
+}
+
+static inline void debug_rt_mutex_init_waiter(struct rt_mutex_waiter *waiter)
+{
+	if (IS_ENABLED(CONFIG_DEBUG_RT_MUTEXES))
+		memset(waiter, 0x11, sizeof(*waiter));
+}
+
+static inline void debug_rt_mutex_free_waiter(struct rt_mutex_waiter *waiter)
+{
+	if (IS_ENABLED(CONFIG_DEBUG_RT_MUTEXES))
+		memset(waiter, 0x22, sizeof(*waiter));
+}
 
 #endif
