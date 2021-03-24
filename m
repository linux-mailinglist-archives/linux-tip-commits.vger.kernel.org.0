Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F877347259
	for <lists+linux-tip-commits@lfdr.de>; Wed, 24 Mar 2021 08:23:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231178AbhCXHWr (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 24 Mar 2021 03:22:47 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:38668 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233186AbhCXHWb (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 24 Mar 2021 03:22:31 -0400
Date:   Wed, 24 Mar 2021 07:22:29 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1616570550;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ujXTNQ4XvJ93fDgwz3DDpWutDxjK2WINE5GUf6AXOQs=;
        b=LM7NdWF9jSgX5iw1gYYQLXnaAdb9n3oU6I/c38L2kDKFWxeO+/ljX1dT13o2yDZplaq39j
        wWzFsCq7yn08BF6rluAtsM5NWRXx5ZncQR/86YIWfIoD9rlSwIJihbXtOibYBGbqrTM7I9
        eP/JXbZ/WjFVUqWuKOyEQSZojxvlV6qDboAhHLmShED995Xi3q2ZvxPlc8tu4GJX5qsHRb
        3/t5wQOrWHIczfBxox8aVR2XyZffUlmHThcoLCJ2E2LHm610Om1VUodHQgGoO6zyj4NvSc
        NdSTsb2seLVMi0vICcc8ZlukU0pPFJPcLAtydROyAvwF/8sZyrNv/jnP4wa+Qg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1616570550;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ujXTNQ4XvJ93fDgwz3DDpWutDxjK2WINE5GUf6AXOQs=;
        b=VNtzOw4JfGW1Kptlq7C87kOYPEXROSud4Odhz/EjyMFdFivP1tig8khNEplJUaC9JLhEsk
        54TO5PqIqe6TLfAw==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] locking/rtmutex: Remove empty and unused debug stubs
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210323213708.001857655@linutronix.de>
References: <20210323213708.001857655@linutronix.de>
MIME-Version: 1.0
Message-ID: <161657054987.398.3509848218878647146.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     fec6b6a56b6135163f45332570e4c2cc51484a64
Gitweb:        https://git.kernel.org/tip/fec6b6a56b6135163f45332570e4c2cc51484a64
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Tue, 23 Mar 2021 22:30:24 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Wed, 24 Mar 2021 08:06:07 +01:00

locking/rtmutex: Remove empty and unused debug stubs

No users, just ballast.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/20210323213708.001857655@linutronix.de
---
 include/linux/rtmutex.h        | 14 ++------------
 kernel/locking/rtmutex-debug.c |  9 ---------
 kernel/locking/rtmutex.c       | 17 -----------------
 kernel/locking/rtmutex.h       |  2 --
 4 files changed, 2 insertions(+), 40 deletions(-)

diff --git a/include/linux/rtmutex.h b/include/linux/rtmutex.h
index 243fabc..d1672de 100644
--- a/include/linux/rtmutex.h
+++ b/include/linux/rtmutex.h
@@ -40,18 +40,9 @@ struct rt_mutex_waiter;
 struct hrtimer_sleeper;
 
 #ifdef CONFIG_DEBUG_RT_MUTEXES
- extern int rt_mutex_debug_check_no_locks_freed(const void *from,
-						unsigned long len);
- extern void rt_mutex_debug_check_no_locks_held(struct task_struct *task);
- extern void rt_mutex_debug_task_free(struct task_struct *tsk);
+extern void rt_mutex_debug_task_free(struct task_struct *tsk);
 #else
- static inline int rt_mutex_debug_check_no_locks_freed(const void *from,
-						       unsigned long len)
- {
-	return 0;
- }
-# define rt_mutex_debug_check_no_locks_held(task)	do { } while (0)
-# define rt_mutex_debug_task_free(t)			do { } while (0)
+static inline void rt_mutex_debug_task_free(struct task_struct *tsk) { }
 #endif
 
 #define rt_mutex_init(mutex) \
@@ -88,7 +79,6 @@ static inline int rt_mutex_is_locked(struct rt_mutex *lock)
 }
 
 extern void __rt_mutex_init(struct rt_mutex *lock, const char *name, struct lock_class_key *key);
-extern void rt_mutex_destroy(struct rt_mutex *lock);
 
 #ifdef CONFIG_DEBUG_LOCK_ALLOC
 extern void rt_mutex_lock_nested(struct rt_mutex *lock, unsigned int subclass);
diff --git a/kernel/locking/rtmutex-debug.c b/kernel/locking/rtmutex-debug.c
index fb15010..df584c9 100644
--- a/kernel/locking/rtmutex-debug.c
+++ b/kernel/locking/rtmutex-debug.c
@@ -38,20 +38,11 @@ void rt_mutex_debug_task_free(struct task_struct *task)
 	DEBUG_LOCKS_WARN_ON(task->pi_blocked_on);
 }
 
-void debug_rt_mutex_lock(struct rt_mutex *lock)
-{
-}
-
 void debug_rt_mutex_unlock(struct rt_mutex *lock)
 {
 	DEBUG_LOCKS_WARN_ON(rt_mutex_owner(lock) != current);
 }
 
-void
-debug_rt_mutex_proxy_lock(struct rt_mutex *lock, struct task_struct *powner)
-{
-}
-
 void debug_rt_mutex_proxy_unlock(struct rt_mutex *lock)
 {
 	DEBUG_LOCKS_WARN_ON(!rt_mutex_owner(lock));
diff --git a/kernel/locking/rtmutex.c b/kernel/locking/rtmutex.c
index 4beca54..82cb963 100644
--- a/kernel/locking/rtmutex.c
+++ b/kernel/locking/rtmutex.c
@@ -885,9 +885,6 @@ static int try_to_take_rt_mutex(struct rt_mutex *lock, struct task_struct *task,
 	raw_spin_unlock(&task->pi_lock);
 
 takeit:
-	/* We got the lock. */
-	debug_rt_mutex_lock(lock);
-
 	/*
 	 * This either preserves the RT_MUTEX_HAS_WAITERS bit if there
 	 * are still waiters or clears it.
@@ -1581,20 +1578,6 @@ void __sched rt_mutex_futex_unlock(struct rt_mutex *lock)
 }
 
 /**
- * rt_mutex_destroy - mark a mutex unusable
- * @lock: the mutex to be destroyed
- *
- * This function marks the mutex uninitialized, and any subsequent
- * use of the mutex is forbidden. The mutex must not be locked when
- * this function is called.
- */
-void rt_mutex_destroy(struct rt_mutex *lock)
-{
-	WARN_ON(rt_mutex_is_locked(lock));
-}
-EXPORT_SYMBOL_GPL(rt_mutex_destroy);
-
-/**
  * __rt_mutex_init - initialize the rt_mutex
  *
  * @lock:	The rt_mutex to be initialized
diff --git a/kernel/locking/rtmutex.h b/kernel/locking/rtmutex.h
index d77cb82..1e484ab 100644
--- a/kernel/locking/rtmutex.h
+++ b/kernel/locking/rtmutex.h
@@ -13,8 +13,6 @@
 
 #define debug_rt_mutex_init_waiter(w)			do { } while (0)
 #define debug_rt_mutex_free_waiter(w)			do { } while (0)
-#define debug_rt_mutex_lock(l)				do { } while (0)
-#define debug_rt_mutex_proxy_lock(l,p)			do { } while (0)
 #define debug_rt_mutex_proxy_unlock(l)			do { } while (0)
 #define debug_rt_mutex_unlock(l)			do { } while (0)
 #define debug_rt_mutex_init(m, n, k)			do { } while (0)
