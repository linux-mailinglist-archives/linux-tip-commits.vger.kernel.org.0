Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B2B83EF340
	for <lists+linux-tip-commits@lfdr.de>; Tue, 17 Aug 2021 22:15:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234196AbhHQUOr (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Tue, 17 Aug 2021 16:14:47 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:34608 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234145AbhHQUOl (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Tue, 17 Aug 2021 16:14:41 -0400
Date:   Tue, 17 Aug 2021 20:14:06 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1629231247;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4xRiIag06cFiRpGNIp5NaO2G6wz0poMdWFffXe+Vs0A=;
        b=KvVNXqqtK6HBrGBrPD0YYWRowWIPw/AVBhOEE42JlktHlXYqdl+3Jpi8e0aHJXQ+6qL7lq
        A1cTojbcRrJ9fh+imsDzY3WMiKhxCaJGUlPrDcb/RQaj572wR9ZpwpnKB9ruJs4XCstB4+
        f8xrhmu0ym7RDzq8JNg50x5RFiOosUG5i4paX3unhKEkOFlO5NJLKqMBzoqZDgQ26SeykT
        MBtd7Ws+x6tWtmCFdvivwwdGnS0NZPCGKxfyme1mcktMCLng2FQ6SDr47t2Pnx8HxPqVbh
        smCB30gdD97MNVWw3ihr1X95pPxy3mJCNS3egvcED/v7Ni4dBrL1XL+GyRFu3g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1629231247;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4xRiIag06cFiRpGNIp5NaO2G6wz0poMdWFffXe+Vs0A=;
        b=dslM1cEEDNlgLoloM1B/6AgvotkgHL4kArqzG8YgMghz8PkUJ9yrdHbO1LEdayWRsy0Y1V
        NUzX//qxcRZ7c4Ag==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] locking/rtmutex: Add mutex variant for RT
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210815211305.081517417@linutronix.de>
References: <20210815211305.081517417@linutronix.de>
MIME-Version: 1.0
Message-ID: <162923124625.25758.9078622271451263411.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     bb630f9f7a7d43869e4e7f5e4c002207396aea59
Gitweb:        https://git.kernel.org/tip/bb630f9f7a7d43869e4e7f5e4c002207396aea59
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Sun, 15 Aug 2021 23:29:01 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 17 Aug 2021 19:05:29 +02:00

locking/rtmutex: Add mutex variant for RT

Add the necessary defines, helpers and API functions for replacing struct mutex on
a PREEMPT_RT enabled kernel with an rtmutex based variant.

No functional change when CONFIG_PREEMPT_RT=n

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/20210815211305.081517417@linutronix.de
---
 include/linux/mutex.h        |  66 +++++++++++++++---
 kernel/locking/mutex.c       |   4 +-
 kernel/locking/rtmutex_api.c | 122 ++++++++++++++++++++++++++++++++++-
 lib/Kconfig.debug            |  11 +--
 4 files changed, 187 insertions(+), 16 deletions(-)

diff --git a/include/linux/mutex.h b/include/linux/mutex.h
index 0bbc872..8f226d4 100644
--- a/include/linux/mutex.h
+++ b/include/linux/mutex.h
@@ -20,6 +20,18 @@
 #include <linux/osq_lock.h>
 #include <linux/debug_locks.h>
 
+#ifdef CONFIG_DEBUG_LOCK_ALLOC
+# define __DEP_MAP_MUTEX_INITIALIZER(lockname)			\
+		, .dep_map = {					\
+			.name = #lockname,			\
+			.wait_type_inner = LD_WAIT_SLEEP,	\
+		}
+#else
+# define __DEP_MAP_MUTEX_INITIALIZER(lockname)
+#endif
+
+#ifndef CONFIG_PREEMPT_RT
+
 /*
  * Simple, straightforward mutexes with strict semantics:
  *
@@ -93,16 +105,6 @@ do {									\
 	__mutex_init((mutex), #mutex, &__key);				\
 } while (0)
 
-#ifdef CONFIG_DEBUG_LOCK_ALLOC
-# define __DEP_MAP_MUTEX_INITIALIZER(lockname)			\
-		, .dep_map = {					\
-			.name = #lockname,			\
-			.wait_type_inner = LD_WAIT_SLEEP,	\
-		}
-#else
-# define __DEP_MAP_MUTEX_INITIALIZER(lockname)
-#endif
-
 #define __MUTEX_INITIALIZER(lockname) \
 		{ .owner = ATOMIC_LONG_INIT(0) \
 		, .wait_lock = __RAW_SPIN_LOCK_UNLOCKED(lockname.wait_lock) \
@@ -124,6 +126,50 @@ extern void __mutex_init(struct mutex *lock, const char *name,
  */
 extern bool mutex_is_locked(struct mutex *lock);
 
+#else /* !CONFIG_PREEMPT_RT */
+/*
+ * Preempt-RT variant based on rtmutexes.
+ */
+#include <linux/rtmutex.h>
+
+struct mutex {
+	struct rt_mutex_base	rtmutex;
+#ifdef CONFIG_DEBUG_LOCK_ALLOC
+	struct lockdep_map	dep_map;
+#endif
+};
+
+#define __MUTEX_INITIALIZER(mutexname)					\
+{									\
+	.rtmutex = __RT_MUTEX_BASE_INITIALIZER(mutexname.rtmutex)	\
+	__DEP_MAP_MUTEX_INITIALIZER(mutexname)				\
+}
+
+#define DEFINE_MUTEX(mutexname)						\
+	struct mutex mutexname = __MUTEX_INITIALIZER(mutexname)
+
+extern void __mutex_rt_init(struct mutex *lock, const char *name,
+			    struct lock_class_key *key);
+extern int mutex_trylock(struct mutex *lock);
+
+static inline void mutex_destroy(struct mutex *lock) { }
+
+#define mutex_is_locked(l)	rt_mutex_base_is_locked(&(l)->rtmutex)
+
+#define __mutex_init(mutex, name, key)			\
+do {							\
+	rt_mutex_base_init(&(mutex)->rtmutex);		\
+	__mutex_rt_init((mutex), name, key);		\
+} while (0)
+
+#define mutex_init(mutex)				\
+do {							\
+	static struct lock_class_key __key;		\
+							\
+	__mutex_init((mutex), #mutex, &__key);		\
+} while (0)
+#endif /* CONFIG_PREEMPT_RT */
+
 /*
  * See kernel/locking/mutex.c for detailed documentation of these APIs.
  * Also see Documentation/locking/mutex-design.rst.
diff --git a/kernel/locking/mutex.c b/kernel/locking/mutex.c
index 9906ca6..3a65bf4 100644
--- a/kernel/locking/mutex.c
+++ b/kernel/locking/mutex.c
@@ -30,6 +30,7 @@
 #include <linux/debug_locks.h>
 #include <linux/osq_lock.h>
 
+#ifndef CONFIG_PREEMPT_RT
 #include "mutex.h"
 
 #ifdef CONFIG_DEBUG_MUTEXES
@@ -1066,7 +1067,8 @@ ww_mutex_lock_interruptible(struct ww_mutex *lock, struct ww_acquire_ctx *ctx)
 }
 EXPORT_SYMBOL(ww_mutex_lock_interruptible);
 
-#endif
+#endif /* !CONFIG_DEBUG_LOCK_ALLOC */
+#endif /* !CONFIG_PREEMPT_RT */
 
 /**
  * atomic_dec_and_mutex_lock - return holding mutex if we dec to 0
diff --git a/kernel/locking/rtmutex_api.c b/kernel/locking/rtmutex_api.c
index 16126fc..92b7d28 100644
--- a/kernel/locking/rtmutex_api.c
+++ b/kernel/locking/rtmutex_api.c
@@ -454,3 +454,125 @@ void rt_mutex_debug_task_free(struct task_struct *task)
 	DEBUG_LOCKS_WARN_ON(task->pi_blocked_on);
 }
 #endif
+
+#ifdef CONFIG_PREEMPT_RT
+/* Mutexes */
+void __mutex_rt_init(struct mutex *mutex, const char *name,
+		     struct lock_class_key *key)
+{
+	debug_check_no_locks_freed((void *)mutex, sizeof(*mutex));
+	lockdep_init_map_wait(&mutex->dep_map, name, key, 0, LD_WAIT_SLEEP);
+}
+EXPORT_SYMBOL(__mutex_rt_init);
+
+static __always_inline int __mutex_lock_common(struct mutex *lock,
+					       unsigned int state,
+					       unsigned int subclass,
+					       struct lockdep_map *nest_lock,
+					       unsigned long ip)
+{
+	int ret;
+
+	might_sleep();
+	mutex_acquire_nest(&lock->dep_map, subclass, 0, nest_lock, ip);
+	ret = __rt_mutex_lock(&lock->rtmutex, state);
+	if (ret)
+		mutex_release(&lock->dep_map, ip);
+	else
+		lock_acquired(&lock->dep_map, ip);
+	return ret;
+}
+
+#ifdef CONFIG_DEBUG_LOCK_ALLOC
+void __sched mutex_lock_nested(struct mutex *lock, unsigned int subclass)
+{
+	__mutex_lock_common(lock, TASK_UNINTERRUPTIBLE, subclass, NULL, _RET_IP_);
+}
+EXPORT_SYMBOL_GPL(mutex_lock_nested);
+
+void __sched _mutex_lock_nest_lock(struct mutex *lock,
+				   struct lockdep_map *nest_lock)
+{
+	__mutex_lock_common(lock, TASK_UNINTERRUPTIBLE, 0, nest_lock, _RET_IP_);
+}
+EXPORT_SYMBOL_GPL(_mutex_lock_nest_lock);
+
+int __sched mutex_lock_interruptible_nested(struct mutex *lock,
+					    unsigned int subclass)
+{
+	return __mutex_lock_common(lock, TASK_INTERRUPTIBLE, subclass, NULL, _RET_IP_);
+}
+EXPORT_SYMBOL_GPL(mutex_lock_interruptible_nested);
+
+int __sched mutex_lock_killable_nested(struct mutex *lock,
+					    unsigned int subclass)
+{
+	return __mutex_lock_common(lock, TASK_KILLABLE, subclass, NULL, _RET_IP_);
+}
+EXPORT_SYMBOL_GPL(mutex_lock_killable_nested);
+
+void __sched mutex_lock_io_nested(struct mutex *lock, unsigned int subclass)
+{
+	int token;
+
+	might_sleep();
+
+	token = io_schedule_prepare();
+	__mutex_lock_common(lock, TASK_UNINTERRUPTIBLE, subclass, NULL, _RET_IP_);
+	io_schedule_finish(token);
+}
+EXPORT_SYMBOL_GPL(mutex_lock_io_nested);
+
+#else /* CONFIG_DEBUG_LOCK_ALLOC */
+
+void __sched mutex_lock(struct mutex *lock)
+{
+	__mutex_lock_common(lock, TASK_UNINTERRUPTIBLE, 0, NULL, _RET_IP_);
+}
+EXPORT_SYMBOL(mutex_lock);
+
+int __sched mutex_lock_interruptible(struct mutex *lock)
+{
+	return __mutex_lock_common(lock, TASK_INTERRUPTIBLE, 0, NULL, _RET_IP_);
+}
+EXPORT_SYMBOL(mutex_lock_interruptible);
+
+int __sched mutex_lock_killable(struct mutex *lock)
+{
+	return __mutex_lock_common(lock, TASK_KILLABLE, 0, NULL, _RET_IP_);
+}
+EXPORT_SYMBOL(mutex_lock_killable);
+
+void __sched mutex_lock_io(struct mutex *lock)
+{
+	int token = io_schedule_prepare();
+
+	__mutex_lock_common(lock, TASK_UNINTERRUPTIBLE, 0, NULL, _RET_IP_);
+	io_schedule_finish(token);
+}
+EXPORT_SYMBOL(mutex_lock_io);
+#endif /* !CONFIG_DEBUG_LOCK_ALLOC */
+
+int __sched mutex_trylock(struct mutex *lock)
+{
+	int ret;
+
+	if (IS_ENABLED(CONFIG_DEBUG_RT_MUTEXES) && WARN_ON_ONCE(!in_task()))
+		return 0;
+
+	ret = __rt_mutex_trylock(&lock->rtmutex);
+	if (ret)
+		mutex_acquire(&lock->dep_map, 0, 1, _RET_IP_);
+
+	return ret;
+}
+EXPORT_SYMBOL(mutex_trylock);
+
+void __sched mutex_unlock(struct mutex *lock)
+{
+	mutex_release(&lock->dep_map, _RET_IP_);
+	__rt_mutex_unlock(&lock->rtmutex);
+}
+EXPORT_SYMBOL(mutex_unlock);
+
+#endif /* CONFIG_PREEMPT_RT */
diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index 5ddd575..e5cdf98 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -1235,7 +1235,7 @@ config PROVE_LOCKING
 	depends on DEBUG_KERNEL && LOCK_DEBUGGING_SUPPORT
 	select LOCKDEP
 	select DEBUG_SPINLOCK
-	select DEBUG_MUTEXES
+	select DEBUG_MUTEXES if !PREEMPT_RT
 	select DEBUG_RT_MUTEXES if RT_MUTEXES
 	select DEBUG_RWSEMS
 	select DEBUG_WW_MUTEX_SLOWPATH
@@ -1299,7 +1299,7 @@ config LOCK_STAT
 	depends on DEBUG_KERNEL && LOCK_DEBUGGING_SUPPORT
 	select LOCKDEP
 	select DEBUG_SPINLOCK
-	select DEBUG_MUTEXES
+	select DEBUG_MUTEXES if !PREEMPT_RT
 	select DEBUG_RT_MUTEXES if RT_MUTEXES
 	select DEBUG_LOCK_ALLOC
 	default n
@@ -1335,7 +1335,7 @@ config DEBUG_SPINLOCK
 
 config DEBUG_MUTEXES
 	bool "Mutex debugging: basic checks"
-	depends on DEBUG_KERNEL
+	depends on DEBUG_KERNEL && !PREEMPT_RT
 	help
 	 This feature allows mutex semantics violations to be detected and
 	 reported.
@@ -1345,7 +1345,8 @@ config DEBUG_WW_MUTEX_SLOWPATH
 	depends on DEBUG_KERNEL && LOCK_DEBUGGING_SUPPORT
 	select DEBUG_LOCK_ALLOC
 	select DEBUG_SPINLOCK
-	select DEBUG_MUTEXES
+	select DEBUG_MUTEXES if !PREEMPT_RT
+	select DEBUG_RT_MUTEXES if PREEMPT_RT
 	help
 	 This feature enables slowpath testing for w/w mutex users by
 	 injecting additional -EDEADLK wound/backoff cases. Together with
@@ -1368,7 +1369,7 @@ config DEBUG_LOCK_ALLOC
 	bool "Lock debugging: detect incorrect freeing of live locks"
 	depends on DEBUG_KERNEL && LOCK_DEBUGGING_SUPPORT
 	select DEBUG_SPINLOCK
-	select DEBUG_MUTEXES
+	select DEBUG_MUTEXES if !PREEMPT_RT
 	select DEBUG_RT_MUTEXES if RT_MUTEXES
 	select LOCKDEP
 	help
