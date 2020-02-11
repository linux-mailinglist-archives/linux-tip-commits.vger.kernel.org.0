Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 050C9158EF8
	for <lists+linux-tip-commits@lfdr.de>; Tue, 11 Feb 2020 13:49:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729039AbgBKMsb (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Tue, 11 Feb 2020 07:48:31 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:46094 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728351AbgBKMsa (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Tue, 11 Feb 2020 07:48:30 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1j1Uxj-0007lC-EF; Tue, 11 Feb 2020 13:48:23 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 158F31C2018;
        Tue, 11 Feb 2020 13:48:23 +0100 (CET)
Date:   Tue, 11 Feb 2020 12:48:22 -0000
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] locking/percpu-rwsem: Remove the embedded rwsem
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Davidlohr Bueso <dbueso@suse.de>,
        Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200204092403.GB14879@hirez.programming.kicks-ass.net>
References: <20200204092403.GB14879@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Message-ID: <158142530284.411.17401749318245181313.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-tip-commits-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     7f26482a872c36b2ee87ea95b9dcd96e3d5805df
Gitweb:        https://git.kernel.org/tip/7f26482a872c36b2ee87ea95b9dcd96e3d5805df
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Wed, 30 Oct 2019 20:30:41 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 11 Feb 2020 13:10:56 +01:00

locking/percpu-rwsem: Remove the embedded rwsem

The filesystem freezer uses percpu-rwsem in a way that is effectively
write_non_owner() and achieves this with a few horrible hacks that
rely on the rwsem (!percpu) implementation.

When PREEMPT_RT replaces the rwsem implementation with a PI aware
variant this comes apart.

Remove the embedded rwsem and implement it using a waitqueue and an
atomic_t.

 - make readers_block an atomic, and use it, with the waitqueue
   for a blocking test-and-set write-side.

 - have the read-side wait for the 'lock' state to clear.

Have the waiters use FIFO queueing and mark them (reader/writer) with
a new WQ_FLAG. Use a custom wake_function to wake either a single
writer or all readers until a writer.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Reviewed-by: Davidlohr Bueso <dbueso@suse.de>
Acked-by: Will Deacon <will@kernel.org>
Acked-by: Waiman Long <longman@redhat.com>
Tested-by: Juri Lelli <juri.lelli@redhat.com>
Link: https://lkml.kernel.org/r/20200204092403.GB14879@hirez.programming.kicks-ass.net
---
 include/linux/percpu-rwsem.h  |  19 +---
 include/linux/wait.h          |   1 +-
 kernel/locking/percpu-rwsem.c | 153 ++++++++++++++++++++++++---------
 kernel/locking/rwsem.c        |   9 +--
 kernel/locking/rwsem.h        |  12 +---
 5 files changed, 123 insertions(+), 71 deletions(-)

diff --git a/include/linux/percpu-rwsem.h b/include/linux/percpu-rwsem.h
index bb5b71c..f5ecf6a 100644
--- a/include/linux/percpu-rwsem.h
+++ b/include/linux/percpu-rwsem.h
@@ -3,18 +3,18 @@
 #define _LINUX_PERCPU_RWSEM_H
 
 #include <linux/atomic.h>
-#include <linux/rwsem.h>
 #include <linux/percpu.h>
 #include <linux/rcuwait.h>
+#include <linux/wait.h>
 #include <linux/rcu_sync.h>
 #include <linux/lockdep.h>
 
 struct percpu_rw_semaphore {
 	struct rcu_sync		rss;
 	unsigned int __percpu	*read_count;
-	struct rw_semaphore	rw_sem; /* slowpath */
-	struct rcuwait          writer; /* blocked writer */
-	int			readers_block;
+	struct rcuwait		writer;
+	wait_queue_head_t	waiters;
+	atomic_t		block;
 #ifdef CONFIG_DEBUG_LOCK_ALLOC
 	struct lockdep_map	dep_map;
 #endif
@@ -31,8 +31,9 @@ static DEFINE_PER_CPU(unsigned int, __percpu_rwsem_rc_##name);		\
 is_static struct percpu_rw_semaphore name = {				\
 	.rss = __RCU_SYNC_INITIALIZER(name.rss),			\
 	.read_count = &__percpu_rwsem_rc_##name,			\
-	.rw_sem = __RWSEM_INITIALIZER(name.rw_sem),			\
 	.writer = __RCUWAIT_INITIALIZER(name.writer),			\
+	.waiters = __WAIT_QUEUE_HEAD_INITIALIZER(name.waiters),		\
+	.block = ATOMIC_INIT(0),					\
 	__PERCPU_RWSEM_DEP_MAP_INIT(name)				\
 }
 
@@ -130,20 +131,12 @@ static inline void percpu_rwsem_release(struct percpu_rw_semaphore *sem,
 					bool read, unsigned long ip)
 {
 	lock_release(&sem->dep_map, ip);
-#ifdef CONFIG_RWSEM_SPIN_ON_OWNER
-	if (!read)
-		atomic_long_set(&sem->rw_sem.owner, RWSEM_OWNER_UNKNOWN);
-#endif
 }
 
 static inline void percpu_rwsem_acquire(struct percpu_rw_semaphore *sem,
 					bool read, unsigned long ip)
 {
 	lock_acquire(&sem->dep_map, 0, 1, read, 1, NULL, ip);
-#ifdef CONFIG_RWSEM_SPIN_ON_OWNER
-	if (!read)
-		atomic_long_set(&sem->rw_sem.owner, (long)current);
-#endif
 }
 
 #endif
diff --git a/include/linux/wait.h b/include/linux/wait.h
index 3283c8d..feeb6be 100644
--- a/include/linux/wait.h
+++ b/include/linux/wait.h
@@ -20,6 +20,7 @@ int default_wake_function(struct wait_queue_entry *wq_entry, unsigned mode, int 
 #define WQ_FLAG_EXCLUSIVE	0x01
 #define WQ_FLAG_WOKEN		0x02
 #define WQ_FLAG_BOOKMARK	0x04
+#define WQ_FLAG_CUSTOM		0x08
 
 /*
  * A single wait-queue entry structure:
diff --git a/kernel/locking/percpu-rwsem.c b/kernel/locking/percpu-rwsem.c
index b155e8e..a136677 100644
--- a/kernel/locking/percpu-rwsem.c
+++ b/kernel/locking/percpu-rwsem.c
@@ -1,15 +1,14 @@
 // SPDX-License-Identifier: GPL-2.0-only
 #include <linux/atomic.h>
-#include <linux/rwsem.h>
 #include <linux/percpu.h>
+#include <linux/wait.h>
 #include <linux/lockdep.h>
 #include <linux/percpu-rwsem.h>
 #include <linux/rcupdate.h>
 #include <linux/sched.h>
+#include <linux/sched/task.h>
 #include <linux/errno.h>
 
-#include "rwsem.h"
-
 int __percpu_init_rwsem(struct percpu_rw_semaphore *sem,
 			const char *name, struct lock_class_key *key)
 {
@@ -17,11 +16,10 @@ int __percpu_init_rwsem(struct percpu_rw_semaphore *sem,
 	if (unlikely(!sem->read_count))
 		return -ENOMEM;
 
-	/* ->rw_sem represents the whole percpu_rw_semaphore for lockdep */
 	rcu_sync_init(&sem->rss);
-	init_rwsem(&sem->rw_sem);
 	rcuwait_init(&sem->writer);
-	sem->readers_block = 0;
+	init_waitqueue_head(&sem->waiters);
+	atomic_set(&sem->block, 0);
 #ifdef CONFIG_DEBUG_LOCK_ALLOC
 	debug_check_no_locks_freed((void *)sem, sizeof(*sem));
 	lockdep_init_map(&sem->dep_map, name, key, 0);
@@ -54,23 +52,23 @@ static bool __percpu_down_read_trylock(struct percpu_rw_semaphore *sem)
 	 * the same CPU as the increment, avoiding the
 	 * increment-on-one-CPU-and-decrement-on-another problem.
 	 *
-	 * If the reader misses the writer's assignment of readers_block, then
-	 * the writer is guaranteed to see the reader's increment.
+	 * If the reader misses the writer's assignment of sem->block, then the
+	 * writer is guaranteed to see the reader's increment.
 	 *
 	 * Conversely, any readers that increment their sem->read_count after
-	 * the writer looks are guaranteed to see the readers_block value,
-	 * which in turn means that they are guaranteed to immediately
-	 * decrement their sem->read_count, so that it doesn't matter that the
-	 * writer missed them.
+	 * the writer looks are guaranteed to see the sem->block value, which
+	 * in turn means that they are guaranteed to immediately decrement
+	 * their sem->read_count, so that it doesn't matter that the writer
+	 * missed them.
 	 */
 
 	smp_mb(); /* A matches D */
 
 	/*
-	 * If !readers_block the critical section starts here, matched by the
+	 * If !sem->block the critical section starts here, matched by the
 	 * release in percpu_up_write().
 	 */
-	if (likely(!smp_load_acquire(&sem->readers_block)))
+	if (likely(!atomic_read_acquire(&sem->block)))
 		return true;
 
 	__this_cpu_dec(*sem->read_count);
@@ -81,6 +79,88 @@ static bool __percpu_down_read_trylock(struct percpu_rw_semaphore *sem)
 	return false;
 }
 
+static inline bool __percpu_down_write_trylock(struct percpu_rw_semaphore *sem)
+{
+	if (atomic_read(&sem->block))
+		return false;
+
+	return atomic_xchg(&sem->block, 1) == 0;
+}
+
+static bool __percpu_rwsem_trylock(struct percpu_rw_semaphore *sem, bool reader)
+{
+	if (reader) {
+		bool ret;
+
+		preempt_disable();
+		ret = __percpu_down_read_trylock(sem);
+		preempt_enable();
+
+		return ret;
+	}
+	return __percpu_down_write_trylock(sem);
+}
+
+/*
+ * The return value of wait_queue_entry::func means:
+ *
+ *  <0 - error, wakeup is terminated and the error is returned
+ *   0 - no wakeup, a next waiter is tried
+ *  >0 - woken, if EXCLUSIVE, counted towards @nr_exclusive.
+ *
+ * We use EXCLUSIVE for both readers and writers to preserve FIFO order,
+ * and play games with the return value to allow waking multiple readers.
+ *
+ * Specifically, we wake readers until we've woken a single writer, or until a
+ * trylock fails.
+ */
+static int percpu_rwsem_wake_function(struct wait_queue_entry *wq_entry,
+				      unsigned int mode, int wake_flags,
+				      void *key)
+{
+	struct task_struct *p = get_task_struct(wq_entry->private);
+	bool reader = wq_entry->flags & WQ_FLAG_CUSTOM;
+	struct percpu_rw_semaphore *sem = key;
+
+	/* concurrent against percpu_down_write(), can get stolen */
+	if (!__percpu_rwsem_trylock(sem, reader))
+		return 1;
+
+	list_del_init(&wq_entry->entry);
+	smp_store_release(&wq_entry->private, NULL);
+
+	wake_up_process(p);
+	put_task_struct(p);
+
+	return !reader; /* wake (readers until) 1 writer */
+}
+
+static void percpu_rwsem_wait(struct percpu_rw_semaphore *sem, bool reader)
+{
+	DEFINE_WAIT_FUNC(wq_entry, percpu_rwsem_wake_function);
+	bool wait;
+
+	spin_lock_irq(&sem->waiters.lock);
+	/*
+	 * Serialize against the wakeup in percpu_up_write(), if we fail
+	 * the trylock, the wakeup must see us on the list.
+	 */
+	wait = !__percpu_rwsem_trylock(sem, reader);
+	if (wait) {
+		wq_entry.flags |= WQ_FLAG_EXCLUSIVE | reader * WQ_FLAG_CUSTOM;
+		__add_wait_queue_entry_tail(&sem->waiters, &wq_entry);
+	}
+	spin_unlock_irq(&sem->waiters.lock);
+
+	while (wait) {
+		set_current_state(TASK_UNINTERRUPTIBLE);
+		if (!smp_load_acquire(&wq_entry.private))
+			break;
+		schedule();
+	}
+	__set_current_state(TASK_RUNNING);
+}
+
 bool __percpu_down_read(struct percpu_rw_semaphore *sem, bool try)
 {
 	if (__percpu_down_read_trylock(sem))
@@ -89,20 +169,10 @@ bool __percpu_down_read(struct percpu_rw_semaphore *sem, bool try)
 	if (try)
 		return false;
 
-	/*
-	 * We either call schedule() in the wait, or we'll fall through
-	 * and reschedule on the preempt_enable() in percpu_down_read().
-	 */
-	preempt_enable_no_resched();
-
-	/*
-	 * Avoid lockdep for the down/up_read() we already have them.
-	 */
-	__down_read(&sem->rw_sem);
-	this_cpu_inc(*sem->read_count);
-	__up_read(&sem->rw_sem);
-
+	preempt_enable();
+	percpu_rwsem_wait(sem, /* .reader = */ true);
 	preempt_disable();
+
 	return true;
 }
 EXPORT_SYMBOL_GPL(__percpu_down_read);
@@ -117,7 +187,7 @@ void __percpu_up_read(struct percpu_rw_semaphore *sem)
 	 */
 	__this_cpu_dec(*sem->read_count);
 
-	/* Prod writer to recheck readers_active */
+	/* Prod writer to re-evaluate readers_active_check() */
 	rcuwait_wake_up(&sem->writer);
 }
 EXPORT_SYMBOL_GPL(__percpu_up_read);
@@ -137,6 +207,8 @@ EXPORT_SYMBOL_GPL(__percpu_up_read);
  * zero.  If this sum is zero, then it is stable due to the fact that if any
  * newly arriving readers increment a given counter, they will immediately
  * decrement that same counter.
+ *
+ * Assumes sem->block is set.
  */
 static bool readers_active_check(struct percpu_rw_semaphore *sem)
 {
@@ -160,23 +232,22 @@ void percpu_down_write(struct percpu_rw_semaphore *sem)
 	/* Notify readers to take the slow path. */
 	rcu_sync_enter(&sem->rss);
 
-	__down_write(&sem->rw_sem);
-
 	/*
-	 * Notify new readers to block; up until now, and thus throughout the
-	 * longish rcu_sync_enter() above, new readers could still come in.
+	 * Try set sem->block; this provides writer-writer exclusion.
+	 * Having sem->block set makes new readers block.
 	 */
-	WRITE_ONCE(sem->readers_block, 1);
+	if (!__percpu_down_write_trylock(sem))
+		percpu_rwsem_wait(sem, /* .reader = */ false);
 
-	smp_mb(); /* D matches A */
+	/* smp_mb() implied by __percpu_down_write_trylock() on success -- D matches A */
 
 	/*
-	 * If they don't see our writer of readers_block, then we are
-	 * guaranteed to see their sem->read_count increment, and therefore
-	 * will wait for them.
+	 * If they don't see our store of sem->block, then we are guaranteed to
+	 * see their sem->read_count increment, and therefore will wait for
+	 * them.
 	 */
 
-	/* Wait for all now active readers to complete. */
+	/* Wait for all active readers to complete. */
 	rcuwait_wait_event(&sem->writer, readers_active_check(sem));
 }
 EXPORT_SYMBOL_GPL(percpu_down_write);
@@ -195,12 +266,12 @@ void percpu_up_write(struct percpu_rw_semaphore *sem)
 	 * Therefore we force it through the slow path which guarantees an
 	 * acquire and thereby guarantees the critical section's consistency.
 	 */
-	smp_store_release(&sem->readers_block, 0);
+	atomic_set_release(&sem->block, 0);
 
 	/*
-	 * Release the write lock, this will allow readers back in the game.
+	 * Prod any pending reader/writer to make progress.
 	 */
-	__up_write(&sem->rw_sem);
+	__wake_up(&sem->waiters, TASK_NORMAL, 1, sem);
 
 	/*
 	 * Once this completes (at least one RCU-sched grace period hence) the
diff --git a/kernel/locking/rwsem.c b/kernel/locking/rwsem.c
index 30df8df..81c0d75 100644
--- a/kernel/locking/rwsem.c
+++ b/kernel/locking/rwsem.c
@@ -28,7 +28,6 @@
 #include <linux/rwsem.h>
 #include <linux/atomic.h>
 
-#include "rwsem.h"
 #include "lock_events.h"
 
 /*
@@ -1338,7 +1337,7 @@ static struct rw_semaphore *rwsem_downgrade_wake(struct rw_semaphore *sem)
 /*
  * lock for reading
  */
-inline void __down_read(struct rw_semaphore *sem)
+static inline void __down_read(struct rw_semaphore *sem)
 {
 	if (!rwsem_read_trylock(sem)) {
 		rwsem_down_read_slowpath(sem, TASK_UNINTERRUPTIBLE);
@@ -1383,7 +1382,7 @@ static inline int __down_read_trylock(struct rw_semaphore *sem)
 /*
  * lock for writing
  */
-inline void __down_write(struct rw_semaphore *sem)
+static inline void __down_write(struct rw_semaphore *sem)
 {
 	long tmp = RWSEM_UNLOCKED_VALUE;
 
@@ -1426,7 +1425,7 @@ static inline int __down_write_trylock(struct rw_semaphore *sem)
 /*
  * unlock after reading
  */
-inline void __up_read(struct rw_semaphore *sem)
+static inline void __up_read(struct rw_semaphore *sem)
 {
 	long tmp;
 
@@ -1446,7 +1445,7 @@ inline void __up_read(struct rw_semaphore *sem)
 /*
  * unlock after writing
  */
-inline void __up_write(struct rw_semaphore *sem)
+static inline void __up_write(struct rw_semaphore *sem)
 {
 	long tmp;
 
diff --git a/kernel/locking/rwsem.h b/kernel/locking/rwsem.h
index d0d33a5..e69de29 100644
--- a/kernel/locking/rwsem.h
+++ b/kernel/locking/rwsem.h
@@ -1,12 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-
-#ifndef __INTERNAL_RWSEM_H
-#define __INTERNAL_RWSEM_H
-#include <linux/rwsem.h>
-
-extern void __down_read(struct rw_semaphore *sem);
-extern void __up_read(struct rw_semaphore *sem);
-extern void __down_write(struct rw_semaphore *sem);
-extern void __up_write(struct rw_semaphore *sem);
-
-#endif /* __INTERNAL_RWSEM_H */
