Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B106E3EF35B
	for <lists+linux-tip-commits@lfdr.de>; Tue, 17 Aug 2021 22:15:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235322AbhHQUPU (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Tue, 17 Aug 2021 16:15:20 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:34720 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234787AbhHQUOw (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Tue, 17 Aug 2021 16:14:52 -0400
Date:   Tue, 17 Aug 2021 20:14:17 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1629231258;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=D/lakbxGb/V25iYB0O7VFwcnlQvAP+15XrNut9hLpl0=;
        b=xHi3Gt/cmKdslVoRTLbicHlxjSyWsOtkvy9o//ShtyLXJzOMyaq7VxhzziG2XfPqGvTT1i
        eoW5a+r64hzQssoZRmPIFYHPKKkC3HasSm9yhXYn67DBYNKLiVxjjlyQbsGKrIabz5SC3z
        LQbNylsrXTDrA7vcq/ZbQigiBqZIPMV+blU8r/S/kRHcHgQMRQGXrxZV8njC9bnsZwrzOP
        A8RaYYOXCsJSapsLbkjNwh7hfz0gg+L/hJh9MuFiY0y2r+GqDkbOxrvI4yjrERPj0JA8hO
        vEqSeB76XKymF4rMq38ubZP2FG7LeFZwv7i9eQzwHuUBFR+RvjJcxw8zyMVuOQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1629231258;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=D/lakbxGb/V25iYB0O7VFwcnlQvAP+15XrNut9hLpl0=;
        b=nVUMp2x7DO+JO6xGEbfxw1ZOdEkxArS+H1QehHWe1Vzt3oAXruwTydso7n23hAkCcYGtXo
        g+OtSzhKw5mjo2AA==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] locking/mutex: Consolidate core headers, remove
 kernel/locking/mutex-debug.h
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210815211303.995350521@linutronix.de>
References: <20210815211303.995350521@linutronix.de>
MIME-Version: 1.0
Message-ID: <162923125785.25758.2150823316735633711.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     a321fb9038b335f3c447d1810b97d5f7eec152ac
Gitweb:        https://git.kernel.org/tip/a321fb9038b335f3c447d1810b97d5f7eec152ac
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Tue, 17 Aug 2021 16:17:38 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 17 Aug 2021 18:24:22 +02:00

locking/mutex: Consolidate core headers, remove kernel/locking/mutex-debug.h

Having two header files which contain just the non-debug and debug variants
is mostly waste of disc space and has no real value. Stick the debug
variants into the common mutex.h file as counterpart to the stubs for the
non-debug case.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/20210815211303.995350521@linutronix.de
---
 kernel/locking/mutex-debug.c |  4 +---
 kernel/locking/mutex-debug.h | 29 +---------------------------
 kernel/locking/mutex.c       |  4 ++--
 kernel/locking/mutex.h       | 37 +++++++++++++++++++++--------------
 4 files changed, 26 insertions(+), 48 deletions(-)
 delete mode 100644 kernel/locking/mutex-debug.h

diff --git a/kernel/locking/mutex-debug.c b/kernel/locking/mutex-debug.c
index db93015..7ef5a36 100644
--- a/kernel/locking/mutex-debug.c
+++ b/kernel/locking/mutex-debug.c
@@ -1,6 +1,4 @@
 /*
- * kernel/mutex-debug.c
- *
  * Debugging code for mutexes
  *
  * Started by Ingo Molnar:
@@ -22,7 +20,7 @@
 #include <linux/interrupt.h>
 #include <linux/debug_locks.h>
 
-#include "mutex-debug.h"
+#include "mutex.h"
 
 /*
  * Must be called with lock->wait_lock held.
diff --git a/kernel/locking/mutex-debug.h b/kernel/locking/mutex-debug.h
deleted file mode 100644
index 53e631e..0000000
--- a/kernel/locking/mutex-debug.h
+++ /dev/null
@@ -1,29 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-/*
- * Mutexes: blocking mutual exclusion locks
- *
- * started by Ingo Molnar:
- *
- *  Copyright (C) 2004, 2005, 2006 Red Hat, Inc., Ingo Molnar <mingo@redhat.com>
- *
- * This file contains mutex debugging related internal declarations,
- * prototypes and inline functions, for the CONFIG_DEBUG_MUTEXES case.
- * More details are in kernel/mutex-debug.c.
- */
-
-/*
- * This must be called with lock->wait_lock held.
- */
-extern void debug_mutex_lock_common(struct mutex *lock,
-				    struct mutex_waiter *waiter);
-extern void debug_mutex_wake_waiter(struct mutex *lock,
-				    struct mutex_waiter *waiter);
-extern void debug_mutex_free_waiter(struct mutex_waiter *waiter);
-extern void debug_mutex_add_waiter(struct mutex *lock,
-				   struct mutex_waiter *waiter,
-				   struct task_struct *task);
-extern void debug_mutex_remove_waiter(struct mutex *lock, struct mutex_waiter *waiter,
-				struct task_struct *task);
-extern void debug_mutex_unlock(struct mutex *lock);
-extern void debug_mutex_init(struct mutex *lock, const char *name,
-			     struct lock_class_key *key);
diff --git a/kernel/locking/mutex.c b/kernel/locking/mutex.c
index 21c9e5d..acbe43d 100644
--- a/kernel/locking/mutex.c
+++ b/kernel/locking/mutex.c
@@ -30,11 +30,11 @@
 #include <linux/debug_locks.h>
 #include <linux/osq_lock.h>
 
+#include "mutex.h"
+
 #ifdef CONFIG_DEBUG_MUTEXES
-# include "mutex-debug.h"
 # define MUTEX_WARN_ON(cond) DEBUG_LOCKS_WARN_ON(cond)
 #else
-# include "mutex.h"
 # define MUTEX_WARN_ON(cond)
 #endif
 
diff --git a/kernel/locking/mutex.h b/kernel/locking/mutex.h
index f0c710b..586e4f1 100644
--- a/kernel/locking/mutex.h
+++ b/kernel/locking/mutex.h
@@ -5,19 +5,28 @@
  * started by Ingo Molnar:
  *
  *  Copyright (C) 2004, 2005, 2006 Red Hat, Inc., Ingo Molnar <mingo@redhat.com>
- *
- * This file contains mutex debugging related internal prototypes, for the
- * !CONFIG_DEBUG_MUTEXES case. Most of them are NOPs:
  */
 
-#define debug_mutex_wake_waiter(lock, waiter)		do { } while (0)
-#define debug_mutex_free_waiter(waiter)			do { } while (0)
-#define debug_mutex_add_waiter(lock, waiter, ti)	do { } while (0)
-#define debug_mutex_remove_waiter(lock, waiter, ti)     do { } while (0)
-#define debug_mutex_unlock(lock)			do { } while (0)
-#define debug_mutex_init(lock, name, key)		do { } while (0)
-
-static inline void
-debug_mutex_lock_common(struct mutex *lock, struct mutex_waiter *waiter)
-{
-}
+#ifdef CONFIG_DEBUG_MUTEXES
+extern void debug_mutex_lock_common(struct mutex *lock,
+				    struct mutex_waiter *waiter);
+extern void debug_mutex_wake_waiter(struct mutex *lock,
+				    struct mutex_waiter *waiter);
+extern void debug_mutex_free_waiter(struct mutex_waiter *waiter);
+extern void debug_mutex_add_waiter(struct mutex *lock,
+				   struct mutex_waiter *waiter,
+				   struct task_struct *task);
+extern void debug_mutex_remove_waiter(struct mutex *lock, struct mutex_waiter *waiter,
+				      struct task_struct *task);
+extern void debug_mutex_unlock(struct mutex *lock);
+extern void debug_mutex_init(struct mutex *lock, const char *name,
+			     struct lock_class_key *key);
+#else /* CONFIG_DEBUG_MUTEXES */
+# define debug_mutex_lock_common(lock, waiter)		do { } while (0)
+# define debug_mutex_wake_waiter(lock, waiter)		do { } while (0)
+# define debug_mutex_free_waiter(waiter)		do { } while (0)
+# define debug_mutex_add_waiter(lock, waiter, ti)	do { } while (0)
+# define debug_mutex_remove_waiter(lock, waiter, ti)	do { } while (0)
+# define debug_mutex_unlock(lock)			do { } while (0)
+# define debug_mutex_init(lock, name, key)		do { } while (0)
+#endif /* !CONFIG_DEBUG_MUTEXES */
