Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B99C3EF369
	for <lists+linux-tip-commits@lfdr.de>; Tue, 17 Aug 2021 22:15:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234986AbhHQUPa (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Tue, 17 Aug 2021 16:15:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235017AbhHQUPC (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Tue, 17 Aug 2021 16:15:02 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5298DC0612A4;
        Tue, 17 Aug 2021 13:14:21 -0700 (PDT)
Date:   Tue, 17 Aug 2021 20:14:19 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1629231259;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PK/7i8WOkMjrUysvGAOgkwo+9ZFmACNeJ4mfBQJ/SV4=;
        b=sVG6E8+crtXjlpzum+vPuMnWIXIJ3bCHSLqXrwPnTv89X79eHI93CkjwKIIo+eI6IEfDcj
        fDTXO3ZObm+RfTTh2t2Dt6w5zNxoK7hWaR1gcNdf2/9BhzUHsCjrD4BzFgKZtKCXslt7W2
        jEv/yxHUcNlAdfzrCAlT/AIEABvBR4OH68w7/PWClCCCUb+uNjSA1vtHFwsmfaqEb/P5+0
        4wukVvxMm0p+LzkFYLpFBF9g5OJNFJxkqcyg3EwI5VkM7XjDNj878/lDDnu0uDeocrsouq
        pHS1GewGDcCXbD//J5xey5rUT1p2QAb0vzOKO1ZjYD4Cjp4o0hnBzZNWnw5hcg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1629231259;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PK/7i8WOkMjrUysvGAOgkwo+9ZFmACNeJ4mfBQJ/SV4=;
        b=d4pcZ5NP2U8wdxTinYluCXJPJXl1MnURw7+dI1LMYhW4TuvXZ6A/icFKuZ0N+dYZfFDKZv
        /HV3xIaMhxfD4TAg==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] locking/rwlock: Provide RT variant
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210815211303.882793524@linutronix.de>
References: <20210815211303.882793524@linutronix.de>
MIME-Version: 1.0
Message-ID: <162923125913.25758.11798276285831892376.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     8282947f67345246b4a6344dbceb07484d3d4dad
Gitweb:        https://git.kernel.org/tip/8282947f67345246b4a6344dbceb07484d3d4dad
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Sun, 15 Aug 2021 23:28:28 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 17 Aug 2021 17:50:51 +02:00

locking/rwlock: Provide RT variant

Similar to rw_semaphores, on RT the rwlock substitution is not writer fair,
because it's not feasible to have a writer inherit its priority to
multiple readers. Readers blocked on a writer follow the normal rules of
priority inheritance. Like RT spinlocks, RT rwlocks are state preserving
across the slow lock operations (contended case).

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/20210815211303.882793524@linutronix.de
---
 include/linux/rwlock_rt.h       | 140 +++++++++++++++++++++++++++++++-
 include/linux/rwlock_types.h    |  49 ++++++++---
 include/linux/spinlock_rt.h     |   2 +-
 kernel/Kconfig.locks            |   2 +-
 kernel/locking/spinlock.c       |   7 ++-
 kernel/locking/spinlock_debug.c |   5 +-
 kernel/locking/spinlock_rt.c    | 131 +++++++++++++++++++++++++++++-
 7 files changed, 323 insertions(+), 13 deletions(-)
 create mode 100644 include/linux/rwlock_rt.h

diff --git a/include/linux/rwlock_rt.h b/include/linux/rwlock_rt.h
new file mode 100644
index 0000000..49c1f38
--- /dev/null
+++ b/include/linux/rwlock_rt.h
@@ -0,0 +1,140 @@
+// SPDX-License-Identifier: GPL-2.0-only
+#ifndef __LINUX_RWLOCK_RT_H
+#define __LINUX_RWLOCK_RT_H
+
+#ifndef __LINUX_SPINLOCK_RT_H
+#error Do not #include directly. Use <linux/spinlock.h>.
+#endif
+
+#ifdef CONFIG_DEBUG_LOCK_ALLOC
+extern void __rt_rwlock_init(rwlock_t *rwlock, const char *name,
+			     struct lock_class_key *key);
+#else
+static inline void __rt_rwlock_init(rwlock_t *rwlock, char *name,
+				    struct lock_class_key *key)
+{
+}
+#endif
+
+#define rwlock_init(rwl)				\
+do {							\
+	static struct lock_class_key __key;		\
+							\
+	init_rwbase_rt(&(rwl)->rwbase);			\
+	__rt_rwlock_init(rwl, #rwl, &__key);		\
+} while (0)
+
+extern void rt_read_lock(rwlock_t *rwlock);
+extern int rt_read_trylock(rwlock_t *rwlock);
+extern void rt_read_unlock(rwlock_t *rwlock);
+extern void rt_write_lock(rwlock_t *rwlock);
+extern int rt_write_trylock(rwlock_t *rwlock);
+extern void rt_write_unlock(rwlock_t *rwlock);
+
+static __always_inline void read_lock(rwlock_t *rwlock)
+{
+	rt_read_lock(rwlock);
+}
+
+static __always_inline void read_lock_bh(rwlock_t *rwlock)
+{
+	local_bh_disable();
+	rt_read_lock(rwlock);
+}
+
+static __always_inline void read_lock_irq(rwlock_t *rwlock)
+{
+	rt_read_lock(rwlock);
+}
+
+#define read_lock_irqsave(lock, flags)			\
+	do {						\
+		typecheck(unsigned long, flags);	\
+		rt_read_lock(lock);			\
+		flags = 0;				\
+	} while (0)
+
+#define read_trylock(lock)	__cond_lock(lock, rt_read_trylock(lock))
+
+static __always_inline void read_unlock(rwlock_t *rwlock)
+{
+	rt_read_unlock(rwlock);
+}
+
+static __always_inline void read_unlock_bh(rwlock_t *rwlock)
+{
+	rt_read_unlock(rwlock);
+	local_bh_enable();
+}
+
+static __always_inline void read_unlock_irq(rwlock_t *rwlock)
+{
+	rt_read_unlock(rwlock);
+}
+
+static __always_inline void read_unlock_irqrestore(rwlock_t *rwlock,
+						   unsigned long flags)
+{
+	rt_read_unlock(rwlock);
+}
+
+static __always_inline void write_lock(rwlock_t *rwlock)
+{
+	rt_write_lock(rwlock);
+}
+
+static __always_inline void write_lock_bh(rwlock_t *rwlock)
+{
+	local_bh_disable();
+	rt_write_lock(rwlock);
+}
+
+static __always_inline void write_lock_irq(rwlock_t *rwlock)
+{
+	rt_write_lock(rwlock);
+}
+
+#define write_lock_irqsave(lock, flags)			\
+	do {						\
+		typecheck(unsigned long, flags);	\
+		rt_write_lock(lock);			\
+		flags = 0;				\
+	} while (0)
+
+#define write_trylock(lock)	__cond_lock(lock, rt_write_trylock(lock))
+
+#define write_trylock_irqsave(lock, flags)		\
+({							\
+	int __locked;					\
+							\
+	typecheck(unsigned long, flags);		\
+	flags = 0;					\
+	__locked = write_trylock(lock);			\
+	__locked;					\
+})
+
+static __always_inline void write_unlock(rwlock_t *rwlock)
+{
+	rt_write_unlock(rwlock);
+}
+
+static __always_inline void write_unlock_bh(rwlock_t *rwlock)
+{
+	rt_write_unlock(rwlock);
+	local_bh_enable();
+}
+
+static __always_inline void write_unlock_irq(rwlock_t *rwlock)
+{
+	rt_write_unlock(rwlock);
+}
+
+static __always_inline void write_unlock_irqrestore(rwlock_t *rwlock,
+						    unsigned long flags)
+{
+	rt_write_unlock(rwlock);
+}
+
+#define rwlock_is_contended(lock)		(((void)(lock), 0))
+
+#endif /* __LINUX_RWLOCK_RT_H */
diff --git a/include/linux/rwlock_types.h b/include/linux/rwlock_types.h
index 0ad226b..1948442 100644
--- a/include/linux/rwlock_types.h
+++ b/include/linux/rwlock_types.h
@@ -5,9 +5,19 @@
 # error "Do not include directly, include spinlock_types.h"
 #endif
 
+#ifdef CONFIG_DEBUG_LOCK_ALLOC
+# define RW_DEP_MAP_INIT(lockname)					\
+	.dep_map = {							\
+		.name = #lockname,					\
+		.wait_type_inner = LD_WAIT_CONFIG,			\
+	}
+#else
+# define RW_DEP_MAP_INIT(lockname)
+#endif
+
+#ifndef CONFIG_PREEMPT_RT
 /*
- * include/linux/rwlock_types.h - generic rwlock type definitions
- *				  and initializers
+ * generic rwlock type definitions and initializers
  *
  * portions Copyright 2005, Red Hat, Inc., Ingo Molnar
  * Released under the General Public License (GPL).
@@ -25,16 +35,6 @@ typedef struct {
 
 #define RWLOCK_MAGIC		0xdeaf1eed
 
-#ifdef CONFIG_DEBUG_LOCK_ALLOC
-# define RW_DEP_MAP_INIT(lockname)					\
-	.dep_map = {							\
-		.name = #lockname,					\
-		.wait_type_inner = LD_WAIT_CONFIG,			\
-	}
-#else
-# define RW_DEP_MAP_INIT(lockname)
-#endif
-
 #ifdef CONFIG_DEBUG_SPINLOCK
 #define __RW_LOCK_UNLOCKED(lockname)					\
 	(rwlock_t)	{	.raw_lock = __ARCH_RW_LOCK_UNLOCKED,	\
@@ -50,4 +50,29 @@ typedef struct {
 
 #define DEFINE_RWLOCK(x)	rwlock_t x = __RW_LOCK_UNLOCKED(x)
 
+#else /* !CONFIG_PREEMPT_RT */
+
+#include <linux/rwbase_rt.h>
+
+typedef struct {
+	struct rwbase_rt	rwbase;
+	atomic_t		readers;
+#ifdef CONFIG_DEBUG_LOCK_ALLOC
+	struct lockdep_map	dep_map;
+#endif
+} rwlock_t;
+
+#define __RWLOCK_RT_INITIALIZER(name)					\
+{									\
+	.rwbase = __RWBASE_INITIALIZER(name),				\
+	RW_DEP_MAP_INIT(name)						\
+}
+
+#define __RW_LOCK_UNLOCKED(name) __RWLOCK_RT_INITIALIZER(name)
+
+#define DEFINE_RWLOCK(name)						\
+	rwlock_t name = __RW_LOCK_UNLOCKED(name)
+
+#endif /* CONFIG_PREEMPT_RT */
+
 #endif /* __LINUX_RWLOCK_TYPES_H */
diff --git a/include/linux/spinlock_rt.h b/include/linux/spinlock_rt.h
index 21228d3..4fc7219 100644
--- a/include/linux/spinlock_rt.h
+++ b/include/linux/spinlock_rt.h
@@ -146,4 +146,6 @@ static inline int spin_is_locked(spinlock_t *lock)
 
 #define assert_spin_locked(lock) BUG_ON(!spin_is_locked(lock))
 
+#include <linux/rwlock_rt.h>
+
 #endif
diff --git a/kernel/Kconfig.locks b/kernel/Kconfig.locks
index 3de8fd1..4198f02 100644
--- a/kernel/Kconfig.locks
+++ b/kernel/Kconfig.locks
@@ -251,7 +251,7 @@ config ARCH_USE_QUEUED_RWLOCKS
 
 config QUEUED_RWLOCKS
 	def_bool y if ARCH_USE_QUEUED_RWLOCKS
-	depends on SMP
+	depends on SMP && !PREEMPT_RT
 
 config ARCH_HAS_MMIOWB
 	bool
diff --git a/kernel/locking/spinlock.c b/kernel/locking/spinlock.c
index c8d7ad9..c5830cf 100644
--- a/kernel/locking/spinlock.c
+++ b/kernel/locking/spinlock.c
@@ -124,8 +124,11 @@ void __lockfunc __raw_##op##_lock_bh(locktype##_t *lock)		\
  *         __[spin|read|write]_lock_bh()
  */
 BUILD_LOCK_OPS(spin, raw_spinlock);
+
+#ifndef CONFIG_PREEMPT_RT
 BUILD_LOCK_OPS(read, rwlock);
 BUILD_LOCK_OPS(write, rwlock);
+#endif
 
 #endif
 
@@ -209,6 +212,8 @@ void __lockfunc _raw_spin_unlock_bh(raw_spinlock_t *lock)
 EXPORT_SYMBOL(_raw_spin_unlock_bh);
 #endif
 
+#ifndef CONFIG_PREEMPT_RT
+
 #ifndef CONFIG_INLINE_READ_TRYLOCK
 int __lockfunc _raw_read_trylock(rwlock_t *lock)
 {
@@ -353,6 +358,8 @@ void __lockfunc _raw_write_unlock_bh(rwlock_t *lock)
 EXPORT_SYMBOL(_raw_write_unlock_bh);
 #endif
 
+#endif /* !CONFIG_PREEMPT_RT */
+
 #ifdef CONFIG_DEBUG_LOCK_ALLOC
 
 void __lockfunc _raw_spin_lock_nested(raw_spinlock_t *lock, int subclass)
diff --git a/kernel/locking/spinlock_debug.c b/kernel/locking/spinlock_debug.c
index b9d9308..1423567 100644
--- a/kernel/locking/spinlock_debug.c
+++ b/kernel/locking/spinlock_debug.c
@@ -31,6 +31,7 @@ void __raw_spin_lock_init(raw_spinlock_t *lock, const char *name,
 
 EXPORT_SYMBOL(__raw_spin_lock_init);
 
+#ifndef CONFIG_PREEMPT_RT
 void __rwlock_init(rwlock_t *lock, const char *name,
 		   struct lock_class_key *key)
 {
@@ -48,6 +49,7 @@ void __rwlock_init(rwlock_t *lock, const char *name,
 }
 
 EXPORT_SYMBOL(__rwlock_init);
+#endif
 
 static void spin_dump(raw_spinlock_t *lock, const char *msg)
 {
@@ -139,6 +141,7 @@ void do_raw_spin_unlock(raw_spinlock_t *lock)
 	arch_spin_unlock(&lock->raw_lock);
 }
 
+#ifndef CONFIG_PREEMPT_RT
 static void rwlock_bug(rwlock_t *lock, const char *msg)
 {
 	if (!debug_locks_off())
@@ -228,3 +231,5 @@ void do_raw_write_unlock(rwlock_t *lock)
 	debug_write_unlock(lock);
 	arch_write_unlock(&lock->raw_lock);
 }
+
+#endif /* !CONFIG_PREEMPT_RT */
diff --git a/kernel/locking/spinlock_rt.c b/kernel/locking/spinlock_rt.c
index edfa7b5..c36648b 100644
--- a/kernel/locking/spinlock_rt.c
+++ b/kernel/locking/spinlock_rt.c
@@ -127,3 +127,134 @@ void __rt_spin_lock_init(spinlock_t *lock, const char *name,
 }
 EXPORT_SYMBOL(__rt_spin_lock_init);
 #endif
+
+/*
+ * RT-specific reader/writer locks
+ */
+#define rwbase_set_and_save_current_state(state)	\
+	current_save_and_set_rtlock_wait_state()
+
+#define rwbase_restore_current_state()			\
+	current_restore_rtlock_saved_state()
+
+static __always_inline int
+rwbase_rtmutex_lock_state(struct rt_mutex_base *rtm, unsigned int state)
+{
+	if (unlikely(!rt_mutex_cmpxchg_acquire(rtm, NULL, current)))
+		rtlock_slowlock(rtm);
+	return 0;
+}
+
+static __always_inline int
+rwbase_rtmutex_slowlock_locked(struct rt_mutex_base *rtm, unsigned int state)
+{
+	rtlock_slowlock_locked(rtm);
+	return 0;
+}
+
+static __always_inline void rwbase_rtmutex_unlock(struct rt_mutex_base *rtm)
+{
+	if (likely(rt_mutex_cmpxchg_acquire(rtm, current, NULL)))
+		return;
+
+	rt_mutex_slowunlock(rtm);
+}
+
+static __always_inline int  rwbase_rtmutex_trylock(struct rt_mutex_base *rtm)
+{
+	if (likely(rt_mutex_cmpxchg_acquire(rtm, NULL, current)))
+		return 1;
+
+	return rt_mutex_slowtrylock(rtm);
+}
+
+#define rwbase_signal_pending_state(state, current)	(0)
+
+#define rwbase_schedule()				\
+	schedule_rtlock()
+
+#include "rwbase_rt.c"
+/*
+ * The common functions which get wrapped into the rwlock API.
+ */
+int __sched rt_read_trylock(rwlock_t *rwlock)
+{
+	int ret;
+
+	ret = rwbase_read_trylock(&rwlock->rwbase);
+	if (ret) {
+		rwlock_acquire_read(&rwlock->dep_map, 0, 1, _RET_IP_);
+		rcu_read_lock();
+		migrate_disable();
+	}
+	return ret;
+}
+EXPORT_SYMBOL(rt_read_trylock);
+
+int __sched rt_write_trylock(rwlock_t *rwlock)
+{
+	int ret;
+
+	ret = rwbase_write_trylock(&rwlock->rwbase);
+	if (ret) {
+		rwlock_acquire(&rwlock->dep_map, 0, 1, _RET_IP_);
+		rcu_read_lock();
+		migrate_disable();
+	}
+	return ret;
+}
+EXPORT_SYMBOL(rt_write_trylock);
+
+void __sched rt_read_lock(rwlock_t *rwlock)
+{
+	___might_sleep(__FILE__, __LINE__, 0);
+	rwlock_acquire_read(&rwlock->dep_map, 0, 0, _RET_IP_);
+	rwbase_read_lock(&rwlock->rwbase, TASK_RTLOCK_WAIT);
+	rcu_read_lock();
+	migrate_disable();
+}
+EXPORT_SYMBOL(rt_read_lock);
+
+void __sched rt_write_lock(rwlock_t *rwlock)
+{
+	___might_sleep(__FILE__, __LINE__, 0);
+	rwlock_acquire(&rwlock->dep_map, 0, 0, _RET_IP_);
+	rwbase_write_lock(&rwlock->rwbase, TASK_RTLOCK_WAIT);
+	rcu_read_lock();
+	migrate_disable();
+}
+EXPORT_SYMBOL(rt_write_lock);
+
+void __sched rt_read_unlock(rwlock_t *rwlock)
+{
+	rwlock_release(&rwlock->dep_map, _RET_IP_);
+	migrate_enable();
+	rcu_read_unlock();
+	rwbase_read_unlock(&rwlock->rwbase, TASK_RTLOCK_WAIT);
+}
+EXPORT_SYMBOL(rt_read_unlock);
+
+void __sched rt_write_unlock(rwlock_t *rwlock)
+{
+	rwlock_release(&rwlock->dep_map, _RET_IP_);
+	rcu_read_unlock();
+	migrate_enable();
+	rwbase_write_unlock(&rwlock->rwbase);
+}
+EXPORT_SYMBOL(rt_write_unlock);
+
+int __sched rt_rwlock_is_contended(rwlock_t *rwlock)
+{
+	return rw_base_is_contended(&rwlock->rwbase);
+}
+EXPORT_SYMBOL(rt_rwlock_is_contended);
+
+#ifdef CONFIG_DEBUG_LOCK_ALLOC
+void __rt_rwlock_init(rwlock_t *rwlock, const char *name,
+		      struct lock_class_key *key)
+{
+	debug_check_no_locks_freed((void *)rwlock, sizeof(*rwlock));
+	lockdep_init_map_wait(&rwlock->dep_map, name, key, 0, LD_WAIT_CONFIG);
+}
+EXPORT_SYMBOL(__rt_rwlock_init);
+#endif
