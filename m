Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 420762D4936
	for <lists+linux-tip-commits@lfdr.de>; Wed,  9 Dec 2020 19:41:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733096AbgLISjs (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 9 Dec 2020 13:39:48 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:48320 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728289AbgLISjc (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 9 Dec 2020 13:39:32 -0500
Date:   Wed, 09 Dec 2020 18:38:47 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1607539127;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/bgEwYN200xGfwgQ+BEapEpdha5D2NgmWWUlFWtHYiQ=;
        b=XpzN8MF713NPiRG6q6n4yf2+F9LgyNhzKE/E2I0Ws4g7LJWduuZLuZigWAgK+Ly1ZbHjA/
        4f+4GgNz882XH+Cjviq2zO/YLnh3bVOtQ/rGcbynqlEVmAdLWeLvDYB8Yqw/8Xwl6izaH9
        DBUjyYSieJfRV9y5jc11D+IfBbCWEBcr5yh0lZNdl5Ec+85tK4uaTEDkB6VC/REDXUcs4o
        H0mBwcCmlhl58JQqea8oSPhXw6KWx0PD2GGVak0NiuHlUxhDGtM1c4c94mwC7E7ferDNwx
        y8V+IklTpc020L9s5GDt9+CydycPI+T/4A1KodqhA4Gy6r6CYQQRIieBk6nayA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1607539127;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/bgEwYN200xGfwgQ+BEapEpdha5D2NgmWWUlFWtHYiQ=;
        b=V+Lgq8DeNfncUIsjl5bY/25z1H3oVPt4fFR0qyUTWQ2WSayzhOIjTtAeV/ZBB0H7wthWe5
        1Th1nKB90Qmd9vAw==
From:   "tip-bot2 for Waiman Long" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] locking/rwsem: Remove reader optimistic spinning
Cc:     Waiman Long <longman@redhat.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Davidlohr Bueso <dbueso@suse.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20201121041416.12285-6-longman@redhat.com>
References: <20201121041416.12285-6-longman@redhat.com>
MIME-Version: 1.0
Message-ID: <160753912720.3364.5292953528074969005.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     617f3ef95177840c77f59c2aec1029d27d5547d6
Gitweb:        https://git.kernel.org/tip/617f3ef95177840c77f59c2aec1029d27d5547d6
Author:        Waiman Long <longman@redhat.com>
AuthorDate:    Fri, 20 Nov 2020 23:14:16 -05:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 09 Dec 2020 17:08:48 +01:00

locking/rwsem: Remove reader optimistic spinning

Reader optimistic spinning is helpful when the reader critical section
is short and there aren't that many readers around. It also improves
the chance that a reader can get the lock as writer optimistic spinning
disproportionally favors writers much more than readers.

Since commit d3681e269fff ("locking/rwsem: Wake up almost all readers
in wait queue"), all the waiting readers are woken up so that they can
all get the read lock and run in parallel. When the number of contending
readers is large, allowing reader optimistic spinning will likely cause
reader fragmentation where multiple smaller groups of readers can get
the read lock in a sequential manner separated by writers. That reduces
reader parallelism.

One possible way to address that drawback is to limit the number of
readers (preferably one) that can do optimistic spinning. These readers
act as representatives of all the waiting readers in the wait queue as
they will wake up all those waiting readers once they get the lock.

Alternatively, as reader optimistic lock stealing has already enhanced
fairness to readers, it may be easier to just remove reader optimistic
spinning and simplifying the optimistic spinning code as a result.

Performance measurements (locking throughput kops/s) using a locking
microbenchmark with 50/50 reader/writer distribution and turbo-boost
disabled was done on a 2-socket Cascade Lake system (48-core 96-thread)
to see the impacts of these changes:

  1) Vanilla     - 5.10-rc3 kernel
  2) Before      - 5.10-rc3 kernel with previous patches in this series
  2) limit-rspin - 5.10-rc3 kernel with limited reader spinning patch
  3) no-rspin    - 5.10-rc3 kernel with reader spinning disabled

  # of threads  CS Load   Vanilla  Before   limit-rspin   no-rspin
  ------------  -------   -------  ------   -----------   --------
       2            1      5,185    5,662      5,214       5,077
       4            1      5,107    4,983      5,188       4,760
       8            1      4,782    4,564      4,720       4,628
      16            1      4,680    4,053      4,567       3,402
      32            1      4,299    1,115      1,118       1,098
      64            1      3,218      983      1,001         957
      96            1      1,938      944        957         930

       2           20      2,008    2,128      2,264       1,665
       4           20      1,390    1,033      1,046       1,101
       8           20      1,472    1,155      1,098       1,213
      16           20      1,332    1,077      1,089       1,122
      32           20        967      914        917         980
      64           20        787      874        891         858
      96           20        730      836        847         844

       2          100        372      356        360         355
       4          100        492      425        434         392
       8          100        533      537        529         538
      16          100        548      572        568         598
      32          100        499      520        527         537
      64          100        466      517        526         512
      96          100        406      497        506         509

The column "CS Load" represents the number of pause instructions issued
in the locking critical section. A CS load of 1 is extremely short and
is not likey in real situations. A load of 20 (moderate) and 100 (long)
are more realistic.

It can be seen that the previous patches in this series have reduced
performance in general except in highly contended cases with moderate
or long critical sections that performance improves a bit. This change
is mostly caused by the "Prevent potential lock starvation" patch that
reduce reader optimistic spinning and hence reduce reader fragmentation.

The patch that further limit reader optimistic spinning doesn't seem to
have too much impact on overall performance as shown in the benchmark
data.

The patch that disables reader optimistic spinning shows reduced
performance at lightly loaded cases, but comparable or slightly better
performance on with heavier contention.

This patch just removes reader optimistic spinning for now. As readers
are not going to do optimistic spinning anymore, we don't need to
consider if the OSQ is empty or not when doing lock stealing.

Signed-off-by: Waiman Long <longman@redhat.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Davidlohr Bueso <dbueso@suse.de>
Link: https://lkml.kernel.org/r/20201121041416.12285-6-longman@redhat.com
---
 kernel/locking/lock_events_list.h |   5 +-
 kernel/locking/rwsem.c            | 284 ++++-------------------------
 2 files changed, 49 insertions(+), 240 deletions(-)

diff --git a/kernel/locking/lock_events_list.h b/kernel/locking/lock_events_list.h
index 270a0d3..97fb6f3 100644
--- a/kernel/locking/lock_events_list.h
+++ b/kernel/locking/lock_events_list.h
@@ -56,12 +56,9 @@ LOCK_EVENT(rwsem_sleep_reader)	/* # of reader sleeps			*/
 LOCK_EVENT(rwsem_sleep_writer)	/* # of writer sleeps			*/
 LOCK_EVENT(rwsem_wake_reader)	/* # of reader wakeups			*/
 LOCK_EVENT(rwsem_wake_writer)	/* # of writer wakeups			*/
-LOCK_EVENT(rwsem_opt_rlock)	/* # of opt-acquired read locks		*/
-LOCK_EVENT(rwsem_opt_wlock)	/* # of opt-acquired write locks	*/
+LOCK_EVENT(rwsem_opt_lock)	/* # of opt-acquired write locks	*/
 LOCK_EVENT(rwsem_opt_fail)	/* # of failed optspins			*/
 LOCK_EVENT(rwsem_opt_nospin)	/* # of disabled optspins		*/
-LOCK_EVENT(rwsem_opt_norspin)	/* # of disabled reader-only optspins	*/
-LOCK_EVENT(rwsem_opt_rlock2)	/* # of opt-acquired 2ndary read locks	*/
 LOCK_EVENT(rwsem_rlock)		/* # of read locks acquired		*/
 LOCK_EVENT(rwsem_rlock_steal)	/* # of read locks by lock stealing	*/
 LOCK_EVENT(rwsem_rlock_fast)	/* # of fast read locks acquired	*/
diff --git a/kernel/locking/rwsem.c b/kernel/locking/rwsem.c
index ba5e239..ba67600 100644
--- a/kernel/locking/rwsem.c
+++ b/kernel/locking/rwsem.c
@@ -31,19 +31,13 @@
 #include "lock_events.h"
 
 /*
- * The least significant 3 bits of the owner value has the following
+ * The least significant 2 bits of the owner value has the following
  * meanings when set.
  *  - Bit 0: RWSEM_READER_OWNED - The rwsem is owned by readers
- *  - Bit 1: RWSEM_RD_NONSPINNABLE - Readers cannot spin on this lock.
- *  - Bit 2: RWSEM_WR_NONSPINNABLE - Writers cannot spin on this lock.
+ *  - Bit 1: RWSEM_NONSPINNABLE - Cannot spin on a reader-owned lock
  *
- * When the rwsem is either owned by an anonymous writer, or it is
- * reader-owned, but a spinning writer has timed out, both nonspinnable
- * bits will be set to disable optimistic spinning by readers and writers.
- * In the later case, the last unlocking reader should then check the
- * writer nonspinnable bit and clear it only to give writers preference
- * to acquire the lock via optimistic spinning, but not readers. Similar
- * action is also done in the reader slowpath.
+ * When the rwsem is reader-owned and a spinning writer has timed out,
+ * the nonspinnable bit will be set to disable optimistic spinning.
 
  * When a writer acquires a rwsem, it puts its task_struct pointer
  * into the owner field. It is cleared after an unlock.
@@ -59,46 +53,14 @@
  * is involved. Ideally we would like to track all the readers that own
  * a rwsem, but the overhead is simply too big.
  *
- * Reader optimistic spinning is helpful when the reader critical section
- * is short and there aren't that many readers around. It makes readers
- * relatively more preferred than writers. When a writer times out spinning
- * on a reader-owned lock and set the nospinnable bits, there are two main
- * reasons for that.
- *
- *  1) The reader critical section is long, perhaps the task sleeps after
- *     acquiring the read lock.
- *  2) There are just too many readers contending the lock causing it to
- *     take a while to service all of them.
- *
- * In the former case, long reader critical section will impede the progress
- * of writers which is usually more important for system performance. In
- * the later case, reader optimistic spinning tends to make the reader
- * groups that contain readers that acquire the lock together smaller
- * leading to more of them. That may hurt performance in some cases. In
- * other words, the setting of nonspinnable bits indicates that reader
- * optimistic spinning may not be helpful for those workloads that cause
- * it.
- *
- * Therefore, any writers that had observed the setting of the writer
- * nonspinnable bit for a given rwsem after they fail to acquire the lock
- * via optimistic spinning will set the reader nonspinnable bit once they
- * acquire the write lock. Similarly, readers that observe the setting
- * of reader nonspinnable bit at slowpath entry will set the reader
- * nonspinnable bits when they acquire the read lock via the wakeup path.
- *
- * Once the reader nonspinnable bit is on, it will only be reset when
- * a writer is able to acquire the rwsem in the fast path or somehow a
- * reader or writer in the slowpath doesn't observe the nonspinable bit.
- *
- * This is to discourage reader optmistic spinning on that particular
- * rwsem and make writers more preferred. This adaptive disabling of reader
- * optimistic spinning will alleviate the negative side effect of this
- * feature.
+ * A fast path reader optimistic lock stealing is supported when the rwsem
+ * is previously owned by a writer and the following conditions are met:
+ *  - OSQ is empty
+ *  - rwsem is not currently writer owned
+ *  - the handoff isn't set.
  */
 #define RWSEM_READER_OWNED	(1UL << 0)
-#define RWSEM_RD_NONSPINNABLE	(1UL << 1)
-#define RWSEM_WR_NONSPINNABLE	(1UL << 2)
-#define RWSEM_NONSPINNABLE	(RWSEM_RD_NONSPINNABLE | RWSEM_WR_NONSPINNABLE)
+#define RWSEM_NONSPINNABLE	(1UL << 1)
 #define RWSEM_OWNER_FLAGS_MASK	(RWSEM_READER_OWNED | RWSEM_NONSPINNABLE)
 
 #ifdef CONFIG_DEBUG_RWSEMS
@@ -203,7 +165,7 @@ static inline void __rwsem_set_reader_owned(struct rw_semaphore *sem,
 					    struct task_struct *owner)
 {
 	unsigned long val = (unsigned long)owner | RWSEM_READER_OWNED |
-		(atomic_long_read(&sem->owner) & RWSEM_RD_NONSPINNABLE);
+		(atomic_long_read(&sem->owner) & RWSEM_NONSPINNABLE);
 
 	atomic_long_set(&sem->owner, val);
 }
@@ -372,7 +334,6 @@ struct rwsem_waiter {
 	struct task_struct *task;
 	enum rwsem_waiter_type type;
 	unsigned long timeout;
-	unsigned long last_rowner;
 };
 #define rwsem_first_waiter(sem) \
 	list_first_entry(&sem->wait_list, struct rwsem_waiter, list)
@@ -486,10 +447,6 @@ static void rwsem_mark_wake(struct rw_semaphore *sem,
 		 * the reader is copied over.
 		 */
 		owner = waiter->task;
-		if (waiter->last_rowner & RWSEM_RD_NONSPINNABLE) {
-			owner = (void *)((unsigned long)owner | RWSEM_RD_NONSPINNABLE);
-			lockevent_inc(rwsem_opt_norspin);
-		}
 		__rwsem_set_reader_owned(sem, owner);
 	}
 
@@ -621,30 +578,6 @@ static inline bool rwsem_try_write_lock(struct rw_semaphore *sem,
 
 #ifdef CONFIG_RWSEM_SPIN_ON_OWNER
 /*
- * Try to acquire read lock before the reader is put on wait queue.
- * Lock acquisition isn't allowed if the rwsem is locked or a writer handoff
- * is ongoing.
- */
-static inline bool rwsem_try_read_lock_unqueued(struct rw_semaphore *sem)
-{
-	long count = atomic_long_read(&sem->count);
-
-	if (count & (RWSEM_WRITER_MASK | RWSEM_FLAG_HANDOFF))
-		return false;
-
-	count = atomic_long_fetch_add_acquire(RWSEM_READER_BIAS, &sem->count);
-	if (!(count & (RWSEM_WRITER_MASK | RWSEM_FLAG_HANDOFF))) {
-		rwsem_set_reader_owned(sem);
-		lockevent_inc(rwsem_opt_rlock);
-		return true;
-	}
-
-	/* Back out the change */
-	atomic_long_add(-RWSEM_READER_BIAS, &sem->count);
-	return false;
-}
-
-/*
  * Try to acquire write lock before the writer has been put on wait queue.
  */
 static inline bool rwsem_try_write_lock_unqueued(struct rw_semaphore *sem)
@@ -655,7 +588,7 @@ static inline bool rwsem_try_write_lock_unqueued(struct rw_semaphore *sem)
 		if (atomic_long_try_cmpxchg_acquire(&sem->count, &count,
 					count | RWSEM_WRITER_LOCKED)) {
 			rwsem_set_owner(sem);
-			lockevent_inc(rwsem_opt_wlock);
+			lockevent_inc(rwsem_opt_lock);
 			return true;
 		}
 	}
@@ -671,8 +604,7 @@ static inline bool owner_on_cpu(struct task_struct *owner)
 	return owner->on_cpu && !vcpu_is_preempted(task_cpu(owner));
 }
 
-static inline bool rwsem_can_spin_on_owner(struct rw_semaphore *sem,
-					   unsigned long nonspinnable)
+static inline bool rwsem_can_spin_on_owner(struct rw_semaphore *sem)
 {
 	struct task_struct *owner;
 	unsigned long flags;
@@ -689,7 +621,7 @@ static inline bool rwsem_can_spin_on_owner(struct rw_semaphore *sem,
 	/*
 	 * Don't check the read-owner as the entry may be stale.
 	 */
-	if ((flags & nonspinnable) ||
+	if ((flags & RWSEM_NONSPINNABLE) ||
 	    (owner && !(flags & RWSEM_READER_OWNED) && !owner_on_cpu(owner)))
 		ret = false;
 	rcu_read_unlock();
@@ -719,9 +651,9 @@ enum owner_state {
 #define OWNER_SPINNABLE		(OWNER_NULL | OWNER_WRITER | OWNER_READER)
 
 static inline enum owner_state
-rwsem_owner_state(struct task_struct *owner, unsigned long flags, unsigned long nonspinnable)
+rwsem_owner_state(struct task_struct *owner, unsigned long flags)
 {
-	if (flags & nonspinnable)
+	if (flags & RWSEM_NONSPINNABLE)
 		return OWNER_NONSPINNABLE;
 
 	if (flags & RWSEM_READER_OWNED)
@@ -731,14 +663,14 @@ rwsem_owner_state(struct task_struct *owner, unsigned long flags, unsigned long 
 }
 
 static noinline enum owner_state
-rwsem_spin_on_owner(struct rw_semaphore *sem, unsigned long nonspinnable)
+rwsem_spin_on_owner(struct rw_semaphore *sem)
 {
 	struct task_struct *new, *owner;
 	unsigned long flags, new_flags;
 	enum owner_state state;
 
 	owner = rwsem_owner_flags(sem, &flags);
-	state = rwsem_owner_state(owner, flags, nonspinnable);
+	state = rwsem_owner_state(owner, flags);
 	if (state != OWNER_WRITER)
 		return state;
 
@@ -752,7 +684,7 @@ rwsem_spin_on_owner(struct rw_semaphore *sem, unsigned long nonspinnable)
 		 */
 		new = rwsem_owner_flags(sem, &new_flags);
 		if ((new != owner) || (new_flags != flags)) {
-			state = rwsem_owner_state(new, new_flags, nonspinnable);
+			state = rwsem_owner_state(new, new_flags);
 			break;
 		}
 
@@ -801,14 +733,12 @@ static inline u64 rwsem_rspin_threshold(struct rw_semaphore *sem)
 	return sched_clock() + delta;
 }
 
-static bool rwsem_optimistic_spin(struct rw_semaphore *sem, bool wlock)
+static bool rwsem_optimistic_spin(struct rw_semaphore *sem)
 {
 	bool taken = false;
 	int prev_owner_state = OWNER_NULL;
 	int loop = 0;
 	u64 rspin_threshold = 0;
-	unsigned long nonspinnable = wlock ? RWSEM_WR_NONSPINNABLE
-					   : RWSEM_RD_NONSPINNABLE;
 
 	preempt_disable();
 
@@ -825,15 +755,14 @@ static bool rwsem_optimistic_spin(struct rw_semaphore *sem, bool wlock)
 	for (;;) {
 		enum owner_state owner_state;
 
-		owner_state = rwsem_spin_on_owner(sem, nonspinnable);
+		owner_state = rwsem_spin_on_owner(sem);
 		if (!(owner_state & OWNER_SPINNABLE))
 			break;
 
 		/*
 		 * Try to acquire the lock
 		 */
-		taken = wlock ? rwsem_try_write_lock_unqueued(sem)
-			      : rwsem_try_read_lock_unqueued(sem);
+		taken = rwsem_try_write_lock_unqueued(sem);
 
 		if (taken)
 			break;
@@ -841,7 +770,7 @@ static bool rwsem_optimistic_spin(struct rw_semaphore *sem, bool wlock)
 		/*
 		 * Time-based reader-owned rwsem optimistic spinning
 		 */
-		if (wlock && (owner_state == OWNER_READER)) {
+		if (owner_state == OWNER_READER) {
 			/*
 			 * Re-initialize rspin_threshold every time when
 			 * the owner state changes from non-reader to reader.
@@ -850,7 +779,7 @@ static bool rwsem_optimistic_spin(struct rw_semaphore *sem, bool wlock)
 			 * the beginning of the 2nd reader phase.
 			 */
 			if (prev_owner_state != OWNER_READER) {
-				if (rwsem_test_oflags(sem, nonspinnable))
+				if (rwsem_test_oflags(sem, RWSEM_NONSPINNABLE))
 					break;
 				rspin_threshold = rwsem_rspin_threshold(sem);
 				loop = 0;
@@ -926,89 +855,30 @@ done:
 }
 
 /*
- * Clear the owner's RWSEM_WR_NONSPINNABLE bit if it is set. This should
+ * Clear the owner's RWSEM_NONSPINNABLE bit if it is set. This should
  * only be called when the reader count reaches 0.
- *
- * This give writers better chance to acquire the rwsem first before
- * readers when the rwsem was being held by readers for a relatively long
- * period of time. Race can happen that an optimistic spinner may have
- * just stolen the rwsem and set the owner, but just clearing the
- * RWSEM_WR_NONSPINNABLE bit will do no harm anyway.
- */
-static inline void clear_wr_nonspinnable(struct rw_semaphore *sem)
-{
-	if (rwsem_test_oflags(sem, RWSEM_WR_NONSPINNABLE))
-		atomic_long_andnot(RWSEM_WR_NONSPINNABLE, &sem->owner);
-}
-
-/*
- * This function is called when the reader fails to acquire the lock via
- * optimistic spinning. In this case we will still attempt to do a trylock
- * when comparing the rwsem state right now with the state when entering
- * the slowpath indicates that the reader is still in a valid reader phase.
- * This happens when the following conditions are true:
- *
- * 1) The lock is currently reader owned, and
- * 2) The lock is previously not reader-owned or the last read owner changes.
- *
- * In the former case, we have transitioned from a writer phase to a
- * reader-phase while spinning. In the latter case, it means the reader
- * phase hasn't ended when we entered the optimistic spinning loop. In
- * both cases, the reader is eligible to acquire the lock. This is the
- * secondary path where a read lock is acquired optimistically.
- *
- * The reader non-spinnable bit wasn't set at time of entry or it will
- * not be here at all.
  */
-static inline bool rwsem_reader_phase_trylock(struct rw_semaphore *sem,
-					      unsigned long last_rowner)
+static inline void clear_nonspinnable(struct rw_semaphore *sem)
 {
-	unsigned long owner = atomic_long_read(&sem->owner);
-
-	if (!(owner & RWSEM_READER_OWNED))
-		return false;
-
-	if (((owner ^ last_rowner) & ~RWSEM_OWNER_FLAGS_MASK) &&
-	    rwsem_try_read_lock_unqueued(sem)) {
-		lockevent_inc(rwsem_opt_rlock2);
-		lockevent_add(rwsem_opt_fail, -1);
-		return true;
-	}
-	return false;
-}
-
-static inline bool rwsem_no_spinners(struct rw_semaphore *sem)
-{
-	return !osq_is_locked(&sem->osq);
+	if (rwsem_test_oflags(sem, RWSEM_NONSPINNABLE))
+		atomic_long_andnot(RWSEM_NONSPINNABLE, &sem->owner);
 }
 
 #else
-static inline bool rwsem_can_spin_on_owner(struct rw_semaphore *sem,
-					   unsigned long nonspinnable)
+static inline bool rwsem_can_spin_on_owner(struct rw_semaphore *sem)
 {
 	return false;
 }
 
-static inline bool rwsem_optimistic_spin(struct rw_semaphore *sem, bool wlock)
+static inline bool rwsem_optimistic_spin(struct rw_semaphore *sem)
 {
 	return false;
 }
 
-static inline void clear_wr_nonspinnable(struct rw_semaphore *sem) { }
-
-static inline bool rwsem_reader_phase_trylock(struct rw_semaphore *sem,
-					      unsigned long last_rowner)
-{
-	return false;
-}
-
-static inline bool rwsem_no_spinners(sem)
-{
-	return false;
-}
+static inline void clear_nonspinnable(struct rw_semaphore *sem) { }
 
 static inline int
-rwsem_spin_on_owner(struct rw_semaphore *sem, unsigned long nonspinnable)
+rwsem_spin_on_owner(struct rw_semaphore *sem)
 {
 	return 0;
 }
@@ -1021,7 +891,7 @@ rwsem_spin_on_owner(struct rw_semaphore *sem, unsigned long nonspinnable)
 static struct rw_semaphore __sched *
 rwsem_down_read_slowpath(struct rw_semaphore *sem, long count, int state)
 {
-	long owner, adjustment = -RWSEM_READER_BIAS;
+	long adjustment = -RWSEM_READER_BIAS;
 	long rcnt = (count >> RWSEM_READER_SHIFT);
 	struct rwsem_waiter waiter;
 	DEFINE_WAKE_Q(wake_q);
@@ -1029,54 +899,25 @@ rwsem_down_read_slowpath(struct rw_semaphore *sem, long count, int state)
 
 	/*
 	 * To prevent a constant stream of readers from starving a sleeping
-	 * waiter, don't attempt optimistic spinning if the lock is currently
-	 * owned by readers.
+	 * waiter, don't attempt optimistic lock stealing if the lock is
+	 * currently owned by readers.
 	 */
-	owner = atomic_long_read(&sem->owner);
-	if ((owner & RWSEM_READER_OWNED) && (rcnt > 1) &&
-	   !(count & RWSEM_WRITER_LOCKED))
+	if ((atomic_long_read(&sem->owner) & RWSEM_READER_OWNED) &&
+	    (rcnt > 1) && !(count & RWSEM_WRITER_LOCKED))
 		goto queue;
 
 	/*
-	 * Reader optimistic lock stealing
-	 *
-	 * We can take the read lock directly without doing
-	 * rwsem_optimistic_spin() if the conditions are right.
-	 * Also wake up other readers if it is the first reader.
+	 * Reader optimistic lock stealing.
 	 */
-	if (!(count & (RWSEM_WRITER_LOCKED | RWSEM_FLAG_HANDOFF)) &&
-	    rwsem_no_spinners(sem)) {
+	if (!(count & (RWSEM_WRITER_LOCKED | RWSEM_FLAG_HANDOFF))) {
 		rwsem_set_reader_owned(sem);
 		lockevent_inc(rwsem_rlock_steal);
-		if (rcnt == 1)
-			goto wake_readers;
-		return sem;
-	}
 
-	/*
-	 * Save the current read-owner of rwsem, if available, and the
-	 * reader nonspinnable bit.
-	 */
-	waiter.last_rowner = owner;
-	if (!(waiter.last_rowner & RWSEM_READER_OWNED))
-		waiter.last_rowner &= RWSEM_RD_NONSPINNABLE;
-
-	if (!rwsem_can_spin_on_owner(sem, RWSEM_RD_NONSPINNABLE))
-		goto queue;
-
-	/*
-	 * Undo read bias from down_read() and do optimistic spinning.
-	 */
-	atomic_long_add(-RWSEM_READER_BIAS, &sem->count);
-	adjustment = 0;
-	if (rwsem_optimistic_spin(sem, false)) {
-		/* rwsem_optimistic_spin() implies ACQUIRE on success */
 		/*
-		 * Wake up other readers in the wait list if the front
-		 * waiter is a reader.
+		 * Wake up other readers in the wait queue if it is
+		 * the first reader.
 		 */
-wake_readers:
-		if ((atomic_long_read(&sem->count) & RWSEM_FLAG_WAITERS)) {
+		if ((rcnt == 1) && (count & RWSEM_FLAG_WAITERS)) {
 			raw_spin_lock_irq(&sem->wait_lock);
 			if (!list_empty(&sem->wait_list))
 				rwsem_mark_wake(sem, RWSEM_WAKE_READ_OWNED,
@@ -1085,9 +926,6 @@ wake_readers:
 			wake_up_q(&wake_q);
 		}
 		return sem;
-	} else if (rwsem_reader_phase_trylock(sem, waiter.last_rowner)) {
-		/* rwsem_reader_phase_trylock() implies ACQUIRE on success */
-		return sem;
 	}
 
 queue:
@@ -1103,7 +941,7 @@ queue:
 		 * exit the slowpath and return immediately as its
 		 * RWSEM_READER_BIAS has already been set in the count.
 		 */
-		if (adjustment && !(atomic_long_read(&sem->count) &
+		if (!(atomic_long_read(&sem->count) &
 		     (RWSEM_WRITER_MASK | RWSEM_FLAG_HANDOFF))) {
 			/* Provide lock ACQUIRE */
 			smp_acquire__after_ctrl_dep();
@@ -1117,10 +955,7 @@ queue:
 	list_add_tail(&waiter.list, &sem->wait_list);
 
 	/* we're now waiting on the lock, but no longer actively locking */
-	if (adjustment)
-		count = atomic_long_add_return(adjustment, &sem->count);
-	else
-		count = atomic_long_read(&sem->count);
+	count = atomic_long_add_return(adjustment, &sem->count);
 
 	/*
 	 * If there are no active locks, wake the front queued process(es).
@@ -1129,7 +964,7 @@ queue:
 	 * wake our own waiter to join the existing active readers !
 	 */
 	if (!(count & RWSEM_LOCK_MASK)) {
-		clear_wr_nonspinnable(sem);
+		clear_nonspinnable(sem);
 		wake = true;
 	}
 	if (wake || (!(count & RWSEM_WRITER_MASK) &&
@@ -1175,46 +1010,24 @@ out_nolock:
 }
 
 /*
- * This function is called by the a write lock owner. So the owner value
- * won't get changed by others.
- */
-static inline void rwsem_disable_reader_optspin(struct rw_semaphore *sem,
-						bool disable)
-{
-	if (unlikely(disable)) {
-		atomic_long_or(RWSEM_RD_NONSPINNABLE, &sem->owner);
-		lockevent_inc(rwsem_opt_norspin);
-	}
-}
-
-/*
  * Wait until we successfully acquire the write lock
  */
 static struct rw_semaphore *
 rwsem_down_write_slowpath(struct rw_semaphore *sem, int state)
 {
 	long count;
-	bool disable_rspin;
 	enum writer_wait_state wstate;
 	struct rwsem_waiter waiter;
 	struct rw_semaphore *ret = sem;
 	DEFINE_WAKE_Q(wake_q);
 
 	/* do optimistic spinning and steal lock if possible */
-	if (rwsem_can_spin_on_owner(sem, RWSEM_WR_NONSPINNABLE) &&
-	    rwsem_optimistic_spin(sem, true)) {
+	if (rwsem_can_spin_on_owner(sem) && rwsem_optimistic_spin(sem)) {
 		/* rwsem_optimistic_spin() implies ACQUIRE on success */
 		return sem;
 	}
 
 	/*
-	 * Disable reader optimistic spinning for this rwsem after
-	 * acquiring the write lock when the setting of the nonspinnable
-	 * bits are observed.
-	 */
-	disable_rspin = atomic_long_read(&sem->owner) & RWSEM_NONSPINNABLE;
-
-	/*
 	 * Optimistic spinning failed, proceed to the slowpath
 	 * and block until we can acquire the sem.
 	 */
@@ -1282,7 +1095,7 @@ wait:
 		 * without sleeping.
 		 */
 		if (wstate == WRITER_HANDOFF &&
-		    rwsem_spin_on_owner(sem, RWSEM_NONSPINNABLE) == OWNER_NULL)
+		    rwsem_spin_on_owner(sem) == OWNER_NULL)
 			goto trylock_again;
 
 		/* Block until there are no active lockers. */
@@ -1324,7 +1137,6 @@ trylock_again:
 	}
 	__set_current_state(TASK_RUNNING);
 	list_del(&waiter.list);
-	rwsem_disable_reader_optspin(sem, disable_rspin);
 	raw_spin_unlock_irq(&sem->wait_lock);
 	lockevent_inc(rwsem_wlock);
 
@@ -1484,7 +1296,7 @@ static inline void __up_read(struct rw_semaphore *sem)
 	DEBUG_RWSEMS_WARN_ON(tmp < 0, sem);
 	if (unlikely((tmp & (RWSEM_LOCK_MASK|RWSEM_FLAG_WAITERS)) ==
 		      RWSEM_FLAG_WAITERS)) {
-		clear_wr_nonspinnable(sem);
+		clear_nonspinnable(sem);
 		rwsem_wake(sem, tmp);
 	}
 }
