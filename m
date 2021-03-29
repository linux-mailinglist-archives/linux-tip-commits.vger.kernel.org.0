Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9984834D4F0
	for <lists+linux-tip-commits@lfdr.de>; Mon, 29 Mar 2021 18:25:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231458AbhC2QYi (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Mon, 29 Mar 2021 12:24:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231352AbhC2QYN (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Mon, 29 Mar 2021 12:24:13 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA110C061574;
        Mon, 29 Mar 2021 09:24:12 -0700 (PDT)
Date:   Mon, 29 Mar 2021 16:24:10 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1617035051;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GTSn3teyQcfXlqslL4hrke2zYZAue9RUdHlNMGivc+s=;
        b=uLoOSHjn8ZHfj7hA6c2SrqPEnQYbzy4OWhIU8FA/R2NtHUp7gOT25sd6c6O5HMniPEjPg5
        G8a6RkaMYE4plh34B+Hgk9qmAAs8Z3xTdDwVJVSiK3rAZLNK3zVR3VbCJhvT6SHZt010Rw
        YThmgEBLsLyYT+RKp7GB+iMJEpxzK/yWRo9rtfjTFYek+SJ3yk6q/qJ6pBFX1Oj+jjfyvB
        aNEwGRWpUhxaqej7RZEcHU2+DTsTito53vKMxaWt6f+rz8EA7B8M1riuHXcVRos5iPd55o
        2Dd6kb0SlHPgf8DiHWZmWzyyWK5Qg9QKz0C8OOHVieeoSKWbT3AhYVTJw/mptA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1617035051;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GTSn3teyQcfXlqslL4hrke2zYZAue9RUdHlNMGivc+s=;
        b=Dg+YS1ZTUt6sLzSR15uxbWJI7N1YrNa68zX2iERhm2qKuYVDuOW8/LF/s/Ap/Gy4ZRls/R
        g9sCVIlDM5e0s/Aw==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] locking/rtmutex: Remove empty and unused debug stubs
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210326153943.549192485@linutronix.de>
References: <20210326153943.549192485@linutronix.de>
MIME-Version: 1.0
Message-ID: <161703505091.29796.1379709907654256660.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     8188d74e68174b11ff7c4a635ffc8fd31eacc6b9
Gitweb:        https://git.kernel.org/tip/8188d74e68174b11ff7c4a635ffc8fd31eacc6b9
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Fri, 26 Mar 2021 16:29:34 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Mon, 29 Mar 2021 15:57:03 +02:00

locking/rtmutex: Remove empty and unused debug stubs

No users or useless and therefore just ballast.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/r/20210326153943.549192485@linutronix.de
---
 include/linux/rtmutex.h        | 14 ++------------
 kernel/locking/rtmutex-debug.c |  9 ---------
 kernel/locking/rtmutex-debug.h |  3 ---
 kernel/locking/rtmutex.c       | 18 ------------------
 kernel/locking/rtmutex.h       |  2 --
 5 files changed, 2 insertions(+), 44 deletions(-)

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
diff --git a/kernel/locking/rtmutex-debug.h b/kernel/locking/rtmutex-debug.h
index 659e93e..392468d 100644
--- a/kernel/locking/rtmutex-debug.h
+++ b/kernel/locking/rtmutex-debug.h
@@ -13,10 +13,7 @@
 extern void debug_rt_mutex_init_waiter(struct rt_mutex_waiter *waiter);
 extern void debug_rt_mutex_free_waiter(struct rt_mutex_waiter *waiter);
 extern void debug_rt_mutex_init(struct rt_mutex *lock, const char *name, struct lock_class_key *key);
-extern void debug_rt_mutex_lock(struct rt_mutex *lock);
 extern void debug_rt_mutex_unlock(struct rt_mutex *lock);
-extern void debug_rt_mutex_proxy_lock(struct rt_mutex *lock,
-				      struct task_struct *powner);
 extern void debug_rt_mutex_proxy_unlock(struct rt_mutex *lock);
 
 static inline bool debug_rt_mutex_detect_deadlock(struct rt_mutex_waiter *waiter,
diff --git a/kernel/locking/rtmutex.c b/kernel/locking/rtmutex.c
index 4beca54..96c7c53 100644
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
@@ -1635,7 +1618,6 @@ void rt_mutex_init_proxy_locked(struct rt_mutex *lock,
 				struct task_struct *proxy_owner)
 {
 	__rt_mutex_init(lock, NULL, NULL);
-	debug_rt_mutex_proxy_lock(lock, proxy_owner);
 	rt_mutex_set_owner(lock, proxy_owner);
 }
 
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
