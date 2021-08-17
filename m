Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 475793EF3A0
	for <lists+linux-tip-commits@lfdr.de>; Tue, 17 Aug 2021 22:48:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235670AbhHQUQU (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Tue, 17 Aug 2021 16:16:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235099AbhHQUPi (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Tue, 17 Aug 2021 16:15:38 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65DE0C0611F9;
        Tue, 17 Aug 2021 13:14:29 -0700 (PDT)
Date:   Tue, 17 Aug 2021 20:14:27 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1629231268;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ONDP85jIyoQSasHiyDYOLwx4SxVDtI3xIYU475mCX4U=;
        b=xAtsnaU8OfQEy75tlDz58+v0knyo+pVqDzZiSXLTh4zR4LKdN5/8NI3+AtGYMbCVA0Vzet
        JN9jD8ut9E01YTS5xCjPH4pPvF7p8lo6/Ywt6se3RoDDufY0NBM8czxvCrQDrnQf3kHG4c
        a5hSOyl5hGlxo9hh/5cI4gw89WTIW50X5pce5i8SgZ0CGzUVtbwsK5cMvT12Sr6tnz1ruR
        PiZlKNYNp8eQTPUqUmFwQtp1PdmX9XoiFveTUYCVPiTG78o8RZI0/ishsNpuV2lKU1KXLw
        BPFCr3HGtuQRK6STIj42Oyc1cAFJ/KJIizrlqUkE17ZPklsRX7HWMnPE1KzItA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1629231268;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ONDP85jIyoQSasHiyDYOLwx4SxVDtI3xIYU475mCX4U=;
        b=6FC1PrE8jrAvoO7AaatU7ibfTIuq+dbRgbaJaNa0DaPfbGKIvDmTQwjWy4B6vu/vK/8/sd
        MIgrCYPOUfDLAsBg==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] locking/rwsem: Add rtmutex based R/W semaphore
 implementation
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210815211303.016885947@linutronix.de>
References: <20210815211303.016885947@linutronix.de>
MIME-Version: 1.0
Message-ID: <162923126752.25758.12902450118499172363.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     42254105dfe871a0dc4f9d376106aeb010e54341
Gitweb:        https://git.kernel.org/tip/42254105dfe871a0dc4f9d376106aeb010e54341
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Sun, 15 Aug 2021 23:28:05 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 17 Aug 2021 17:12:47 +02:00

locking/rwsem: Add rtmutex based R/W semaphore implementation

The RT specific R/W semaphore implementation used to restrict the number of
readers to one, because a writer cannot block on multiple readers and
inherit its priority or budget.

The single reader restricting was painful in various ways:

 - Performance bottleneck for multi-threaded applications in the page fault
   path (mmap sem)

 - Progress blocker for drivers which are carefully crafted to avoid the
   potential reader/writer deadlock in mainline.

The analysis of the writer code paths shows that properly written RT tasks
should not take them. Syscalls like mmap(), file access which take mmap sem
write locked have unbound latencies, which are completely unrelated to mmap
sem. Other R/W sem users like graphics drivers are not suitable for RT tasks
either.

So there is little risk to hurt RT tasks when the RT rwsem implementation is
done in the following way:

 - Allow concurrent readers

 - Make writers block until the last reader left the critical section. This
   blocking is not subject to priority/budget inheritance.

 - Readers blocked on a writer inherit their priority/budget in the normal
   way.

There is a drawback with this scheme: R/W semaphores become writer unfair
though the applications which have triggered writer starvation (mostly on
mmap_sem) in the past are not really the typical workloads running on a RT
system. So while it's unlikely to hit writer starvation, it's possible. If
there are unexpected workloads on RT systems triggering it, the problem
has to be revisited.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/20210815211303.016885947@linutronix.de
---
 include/linux/rwsem.h  |  78 +++++++++++++++++++++++++----
 kernel/locking/rwsem.c | 108 ++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 176 insertions(+), 10 deletions(-)

diff --git a/include/linux/rwsem.h b/include/linux/rwsem.h
index a66038d..426e98e 100644
--- a/include/linux/rwsem.h
+++ b/include/linux/rwsem.h
@@ -16,6 +16,19 @@
 #include <linux/spinlock.h>
 #include <linux/atomic.h>
 #include <linux/err.h>
+
+#ifdef CONFIG_DEBUG_LOCK_ALLOC
+# define __RWSEM_DEP_MAP_INIT(lockname)			\
+	.dep_map = {					\
+		.name = #lockname,			\
+		.wait_type_inner = LD_WAIT_SLEEP,	\
+	},
+#else
+# define __RWSEM_DEP_MAP_INIT(lockname)
+#endif
+
+#ifndef CONFIG_PREEMPT_RT
+
 #ifdef CONFIG_RWSEM_SPIN_ON_OWNER
 #include <linux/osq_lock.h>
 #endif
@@ -64,16 +77,6 @@ static inline int rwsem_is_locked(struct rw_semaphore *sem)
 
 /* Common initializer macros and functions */
 
-#ifdef CONFIG_DEBUG_LOCK_ALLOC
-# define __RWSEM_DEP_MAP_INIT(lockname)			\
-	.dep_map = {					\
-		.name = #lockname,			\
-		.wait_type_inner = LD_WAIT_SLEEP,	\
-	},
-#else
-# define __RWSEM_DEP_MAP_INIT(lockname)
-#endif
-
 #ifdef CONFIG_DEBUG_RWSEMS
 # define __RWSEM_DEBUG_INIT(lockname) .magic = &lockname,
 #else
@@ -119,6 +122,61 @@ static inline int rwsem_is_contended(struct rw_semaphore *sem)
 	return !list_empty(&sem->wait_list);
 }
 
+#else /* !CONFIG_PREEMPT_RT */
+
+#include <linux/rwbase_rt.h>
+
+struct rw_semaphore {
+	struct rwbase_rt	rwbase;
+#ifdef CONFIG_DEBUG_LOCK_ALLOC
+	struct lockdep_map	dep_map;
+#endif
+};
+
+#define __RWSEM_INITIALIZER(name)				\
+	{							\
+		.rwbase = __RWBASE_INITIALIZER(name),		\
+		__RWSEM_DEP_MAP_INIT(name)			\
+	}
+
+#define DECLARE_RWSEM(lockname) \
+	struct rw_semaphore lockname = __RWSEM_INITIALIZER(lockname)
+
+#ifdef CONFIG_DEBUG_LOCK_ALLOC
+extern void  __rwsem_init(struct rw_semaphore *rwsem, const char *name,
+			  struct lock_class_key *key);
+#else
+static inline void  __rwsem_init(struct rw_semaphore *rwsem, const char *name,
+				 struct lock_class_key *key)
+{
+}
+#endif
+
+#define init_rwsem(sem)						\
+do {								\
+	static struct lock_class_key __key;			\
+								\
+	init_rwbase_rt(&(sem)->rwbase);			\
+	__rwsem_init((sem), #sem, &__key);			\
+} while (0)
+
+static __always_inline int rwsem_is_locked(struct rw_semaphore *sem)
+{
+	return rw_base_is_locked(&sem->rwbase);
+}
+
+static __always_inline int rwsem_is_contended(struct rw_semaphore *sem)
+{
+	return rw_base_is_contended(&sem->rwbase);
+}
+
+#endif /* CONFIG_PREEMPT_RT */
+
+/*
+ * The functions below are the same for all rwsem implementations including
+ * the RT specific variant.
+ */
+
 /*
  * lock for reading
  */
diff --git a/kernel/locking/rwsem.c b/kernel/locking/rwsem.c
index 8a595b6..c017f9f 100644
--- a/kernel/locking/rwsem.c
+++ b/kernel/locking/rwsem.c
@@ -28,6 +28,7 @@
 #include <linux/rwsem.h>
 #include <linux/atomic.h>
 
+#ifndef CONFIG_PREEMPT_RT
 #include "lock_events.h"
 
 /*
@@ -1344,6 +1345,113 @@ static inline void __downgrade_write(struct rw_semaphore *sem)
 		rwsem_downgrade_wake(sem);
 }
 
+#else /* !CONFIG_PREEMPT_RT */
+
+#include "rtmutex.c"
+
+#define rwbase_set_and_save_current_state(state)	\
+	set_current_state(state)
+
+#define rwbase_restore_current_state()			\
+	__set_current_state(TASK_RUNNING)
+
+#define rwbase_rtmutex_lock_state(rtm, state)		\
+	__rt_mutex_lock(rtm, state)
+
+#define rwbase_rtmutex_slowlock_locked(rtm, state)	\
+	__rt_mutex_slowlock_locked(rtm, state)
+
+#define rwbase_rtmutex_unlock(rtm)			\
+	__rt_mutex_unlock(rtm)
+
+#define rwbase_rtmutex_trylock(rtm)			\
+	__rt_mutex_trylock(rtm)
+
+#define rwbase_signal_pending_state(state, current)	\
+	signal_pending_state(state, current)
+
+#define rwbase_schedule()				\
+	schedule()
+
+#include "rwbase_rt.c"
+
+#ifdef CONFIG_DEBUG_LOCK_ALLOC
+void __rwsem_init(struct rw_semaphore *sem, const char *name,
+		  struct lock_class_key *key)
+{
+	debug_check_no_locks_freed((void *)sem, sizeof(*sem));
+	lockdep_init_map_wait(&sem->dep_map, name, key, 0, LD_WAIT_SLEEP);
+}
+EXPORT_SYMBOL(__rwsem_init);
+#endif
+
+static inline void __down_read(struct rw_semaphore *sem)
+{
+	rwbase_read_lock(&sem->rwbase, TASK_UNINTERRUPTIBLE);
+}
+
+static inline int __down_read_interruptible(struct rw_semaphore *sem)
+{
+	return rwbase_read_lock(&sem->rwbase, TASK_INTERRUPTIBLE);
+}
+
+static inline int __down_read_killable(struct rw_semaphore *sem)
+{
+	return rwbase_read_lock(&sem->rwbase, TASK_KILLABLE);
+}
+
+static inline int __down_read_trylock(struct rw_semaphore *sem)
+{
+	return rwbase_read_trylock(&sem->rwbase);
+}
+
+static inline void __up_read(struct rw_semaphore *sem)
+{
+	rwbase_read_unlock(&sem->rwbase, TASK_NORMAL);
+}
+
+static inline void __sched __down_write(struct rw_semaphore *sem)
+{
+	rwbase_write_lock(&sem->rwbase, TASK_UNINTERRUPTIBLE);
+}
+
+static inline int __sched __down_write_killable(struct rw_semaphore *sem)
+{
+	return rwbase_write_lock(&sem->rwbase, TASK_KILLABLE);
+}
+
+static inline int __down_write_trylock(struct rw_semaphore *sem)
+{
+	return rwbase_write_trylock(&sem->rwbase);
+}
+
+static inline void __up_write(struct rw_semaphore *sem)
+{
+	rwbase_write_unlock(&sem->rwbase);
+}
+
+static inline void __downgrade_write(struct rw_semaphore *sem)
+{
+	rwbase_write_downgrade(&sem->rwbase);
+}
+
+/* Debug stubs for the common API */
+#define DEBUG_RWSEMS_WARN_ON(c, sem)
+
+static inline void __rwsem_set_reader_owned(struct rw_semaphore *sem,
+					    struct task_struct *owner)
+{
+}
+
+static inline bool is_rwsem_reader_owned(struct rw_semaphore *sem)
+{
+	int count = atomic_read(&sem->rwbase.readers);
+
+	return count < 0 && count != READER_BIAS;
+}
+
+#endif /* CONFIG_PREEMPT_RT */
+
 /*
  * lock for reading
  */
