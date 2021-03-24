Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD51B34725C
	for <lists+linux-tip-commits@lfdr.de>; Wed, 24 Mar 2021 08:23:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235869AbhCXHWs (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 24 Mar 2021 03:22:48 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:38694 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235826AbhCXHWc (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 24 Mar 2021 03:22:32 -0400
Date:   Wed, 24 Mar 2021 07:22:30 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1616570551;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CDT8Pr7/T/HZ5GuQDr5jgtgtRbX5R4GRjyeIznWQnVM=;
        b=krb2flEysdeNrB9KigBSjf7MDb0SsFJLjKAqraw6EYtvOfv9+O9Uk2Kt/NWgqEO7SCc4Fz
        PMypqUvgOqADDJp+zSUr184SMt9OUQ9sGh1LcAdhijmNTDJ0jAbJC6pZ42/EDazKbtHqrA
        8ac4O4DihVVOW+KICqUuFLuFP5gSAaH+3QhLcoy4CVxmhCHYVY3ivTP09qEdnntYIjz+kX
        S96NGK98RcAhtZGbIdElPDLTfq3NGabAy7VVuDHbjNLTHNtoXJWTiHrv+yAawSMaq7n81N
        bCAHlpkq3sv+ezv5hq6dsoIE3nGGezgtCoHrxCaa8LHqGD0YD+KoAjXPxR/BpA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1616570551;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CDT8Pr7/T/HZ5GuQDr5jgtgtRbX5R4GRjyeIznWQnVM=;
        b=BTXYZWkj6NEzwkTROgcfKvruMiEWDiqUmm/SUPaHpnKt3+fMmflZsMLkVxWGVWduO9J/2D
        nJsMNjVWSGjuShCQ==
From:   "tip-bot2 for Sebastian Andrzej Siewior" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] locking/rtmutex: Remove rtmutex deadlock tester leftovers
Cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210323213707.630525866@linutronix.de>
References: <20210323213707.630525866@linutronix.de>
MIME-Version: 1.0
Message-ID: <161657055090.398.16593859740560990844.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     ff033d34ec7244e6d86b4bbdd917ec0d54299f31
Gitweb:        https://git.kernel.org/tip/ff033d34ec7244e6d86b4bbdd917ec0d54299f31
Author:        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
AuthorDate:    Tue, 23 Mar 2021 22:30:21 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Wed, 24 Mar 2021 08:06:07 +01:00

locking/rtmutex: Remove rtmutex deadlock tester leftovers

The following debug members of struct rtmutex are unused:

 - save_state: No users

 - file,line:  Printed if ::name is NULL. This is only used for non-futex
	       locks so ::name is never NULL

 - magic:      Assigned to NULL by rt_mutex_destroy(), no further usage

Remove them along with unused inlines and macros leftovers related to
the long gone deadlock tester.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/20210323213707.630525866@linutronix.de
---
 include/linux/rtmutex.h         | 7 ++-----
 kernel/locking/rtmutex-debug.c  | 7 +------
 kernel/locking/rtmutex-debug.h  | 2 --
 kernel/locking/rtmutex.c        | 3 ---
 kernel/locking/rtmutex.h        | 2 --
 kernel/locking/rtmutex_common.h | 1 -
 6 files changed, 3 insertions(+), 19 deletions(-)

diff --git a/include/linux/rtmutex.h b/include/linux/rtmutex.h
index 32f4a35..48b334b 100644
--- a/include/linux/rtmutex.h
+++ b/include/linux/rtmutex.h
@@ -32,10 +32,7 @@ struct rt_mutex {
 	struct rb_root_cached   waiters;
 	struct task_struct	*owner;
 #ifdef CONFIG_DEBUG_RT_MUTEXES
-	int			save_state;
-	const char		*name, *file;
-	int			line;
-	void			*magic;
+	const char		*name;
 #endif
 #ifdef CONFIG_DEBUG_LOCK_ALLOC
 	struct lockdep_map	dep_map;
@@ -60,7 +57,7 @@ struct hrtimer_sleeper;
 
 #ifdef CONFIG_DEBUG_RT_MUTEXES
 # define __DEBUG_RT_MUTEX_INITIALIZER(mutexname) \
-	, .name = #mutexname, .file = __FILE__, .line = __LINE__
+	, .name = #mutexname
 
 # define rt_mutex_init(mutex) \
 do { \
diff --git a/kernel/locking/rtmutex-debug.c b/kernel/locking/rtmutex-debug.c
index 36e6910..7e411b9 100644
--- a/kernel/locking/rtmutex-debug.c
+++ b/kernel/locking/rtmutex-debug.c
@@ -42,12 +42,7 @@ static void printk_task(struct task_struct *p)
 
 static void printk_lock(struct rt_mutex *lock, int print_owner)
 {
-	if (lock->name)
-		printk(" [%p] {%s}\n",
-			lock, lock->name);
-	else
-		printk(" [%p] {%s:%d}\n",
-			lock, lock->file, lock->line);
+	printk(" [%p] {%s}\n", lock, lock->name);
 
 	if (print_owner && rt_mutex_owner(lock)) {
 		printk(".. ->owner: %p\n", lock->owner);
diff --git a/kernel/locking/rtmutex-debug.h b/kernel/locking/rtmutex-debug.h
index fc54971..772c9b0 100644
--- a/kernel/locking/rtmutex-debug.h
+++ b/kernel/locking/rtmutex-debug.h
@@ -22,8 +22,6 @@ extern void debug_rt_mutex_deadlock(enum rtmutex_chainwalk chwalk,
 				    struct rt_mutex_waiter *waiter,
 				    struct rt_mutex *lock);
 extern void debug_rt_mutex_print_deadlock(struct rt_mutex_waiter *waiter);
-# define debug_rt_mutex_reset_waiter(w)			\
-	do { (w)->deadlock_lock = NULL; } while (0)
 
 static inline bool debug_rt_mutex_detect_deadlock(struct rt_mutex_waiter *waiter,
 						  enum rtmutex_chainwalk walk)
diff --git a/kernel/locking/rtmutex.c b/kernel/locking/rtmutex.c
index ca93e5d..11abc60 100644
--- a/kernel/locking/rtmutex.c
+++ b/kernel/locking/rtmutex.c
@@ -1594,9 +1594,6 @@ void __sched rt_mutex_futex_unlock(struct rt_mutex *lock)
 void rt_mutex_destroy(struct rt_mutex *lock)
 {
 	WARN_ON(rt_mutex_is_locked(lock));
-#ifdef CONFIG_DEBUG_RT_MUTEXES
-	lock->magic = NULL;
-#endif
 }
 EXPORT_SYMBOL_GPL(rt_mutex_destroy);
 
diff --git a/kernel/locking/rtmutex.h b/kernel/locking/rtmutex.h
index 732f96a..4dbdec1 100644
--- a/kernel/locking/rtmutex.h
+++ b/kernel/locking/rtmutex.h
@@ -11,7 +11,6 @@
  * Non-debug version.
  */
 
-#define rt_mutex_deadlock_check(l)			(0)
 #define debug_rt_mutex_init_waiter(w)			do { } while (0)
 #define debug_rt_mutex_free_waiter(w)			do { } while (0)
 #define debug_rt_mutex_lock(l)				do { } while (0)
@@ -21,7 +20,6 @@
 #define debug_rt_mutex_init(m, n, k)			do { } while (0)
 #define debug_rt_mutex_deadlock(d, a ,l)		do { } while (0)
 #define debug_rt_mutex_print_deadlock(w)		do { } while (0)
-#define debug_rt_mutex_reset_waiter(w)			do { } while (0)
 
 static inline void rt_mutex_print_deadlock(struct rt_mutex_waiter *w)
 {
diff --git a/kernel/locking/rtmutex_common.h b/kernel/locking/rtmutex_common.h
index a5007f0..aa04743 100644
--- a/kernel/locking/rtmutex_common.h
+++ b/kernel/locking/rtmutex_common.h
@@ -30,7 +30,6 @@ struct rt_mutex_waiter {
 	struct task_struct	*task;
 	struct rt_mutex		*lock;
 #ifdef CONFIG_DEBUG_RT_MUTEXES
-	unsigned long		ip;
 	struct pid		*deadlock_task_pid;
 	struct rt_mutex		*deadlock_lock;
 #endif
