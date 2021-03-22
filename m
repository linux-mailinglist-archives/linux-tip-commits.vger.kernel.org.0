Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8FED23436DD
	for <lists+linux-tip-commits@lfdr.de>; Mon, 22 Mar 2021 03:55:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229874AbhCVCye (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Sun, 21 Mar 2021 22:54:34 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:51012 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229854AbhCVCyV (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Sun, 21 Mar 2021 22:54:21 -0400
Date:   Mon, 22 Mar 2021 02:54:19 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1616381660;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=XYXuErdTeUZxk7JsZKivqXhBF1L9bEo912ouU5c9JGk=;
        b=jqgOf/a+5/hciIz9DAtWeS6jVOi3aDQYzSLxpP9UmaG2xJIiSQ0iUxKV5Uv06cB1DN1/r9
        qrcXn34PnKZ5XBBZEa9PeMfPePuq3iGywIhuKWr0SPj4FLHWiLP/mtra/nLh+sUMwjZIaa
        4s8ncQhYskgnAGTinHSI6GojVAx86FrrYPcKyUSb3x+126YW+LV8ta49IZC1cgDLZdxkwX
        K/j7AS0li/KyCrCtmR/dL9axbShJfqtUt0M0jDBKQJhF1540+nJGiKzcBb6RDviJzSfxUF
        XpM6a5qcD/7ymYyw7KkbTl1GT1G2O3ORgsER987eD2bZwdq8zBwKa3oxVChe+w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1616381660;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=XYXuErdTeUZxk7JsZKivqXhBF1L9bEo912ouU5c9JGk=;
        b=EBFPNOg2V7VkMFjO4ktemtG24ufRZ65IneSOJSjGEqeHloDY2ZCwZ8L4LjS6gPTCHfJeTw
        NLydDmqMnWbeQYCw==
From:   "tip-bot2 for Ingo Molnar" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] locking: Fix typos in comments
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Will Deacon <will.deacon@arm.com>,
        linux-kernel@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        x86@kernel.org
MIME-Version: 1.0
Message-ID: <161638165955.398.2858226798021587801.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     e2db7592be8e83df47519116621411e1056b21c7
Gitweb:        https://git.kernel.org/tip/e2db7592be8e83df47519116621411e1056b21c7
Author:        Ingo Molnar <mingo@kernel.org>
AuthorDate:    Mon, 22 Mar 2021 02:35:05 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Mon, 22 Mar 2021 02:45:52 +01:00

locking: Fix typos in comments

Fix ~16 single-word typos in locking code comments.

Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Paul E. McKenney <paulmck@kernel.org>
Cc: Will Deacon <will.deacon@arm.com>
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/arm/include/asm/spinlock.h | 2 +-
 include/linux/lockdep.h         | 2 +-
 include/linux/rwsem.h           | 2 +-
 kernel/locking/lockdep.c        | 4 ++--
 kernel/locking/lockdep_proc.c   | 2 +-
 kernel/locking/mcs_spinlock.h   | 2 +-
 kernel/locking/mutex.c          | 4 ++--
 kernel/locking/osq_lock.c       | 4 ++--
 kernel/locking/rtmutex.c        | 4 ++--
 kernel/locking/rwsem.c          | 2 +-
 kernel/locking/spinlock.c       | 4 ++--
 11 files changed, 16 insertions(+), 16 deletions(-)

diff --git a/arch/arm/include/asm/spinlock.h b/arch/arm/include/asm/spinlock.h
index 8f009e7..f610a77 100644
--- a/arch/arm/include/asm/spinlock.h
+++ b/arch/arm/include/asm/spinlock.h
@@ -22,7 +22,7 @@
  * assembler to insert a extra (16-bit) IT instruction, depending on the
  * presence or absence of neighbouring conditional instructions.
  *
- * To avoid this unpredictableness, an approprite IT is inserted explicitly:
+ * To avoid this unpredictability, an appropriate IT is inserted explicitly:
  * the assembler won't change IT instructions which are explicitly present
  * in the input.
  */
diff --git a/include/linux/lockdep.h b/include/linux/lockdep.h
index 17805aa..09ac2e8 100644
--- a/include/linux/lockdep.h
+++ b/include/linux/lockdep.h
@@ -155,7 +155,7 @@ extern void lockdep_set_selftest_task(struct task_struct *task);
 extern void lockdep_init_task(struct task_struct *task);
 
 /*
- * Split the recrursion counter in two to readily detect 'off' vs recursion.
+ * Split the recursion counter in two to readily detect 'off' vs recursion.
  */
 #define LOCKDEP_RECURSION_BITS	16
 #define LOCKDEP_OFF		(1U << LOCKDEP_RECURSION_BITS)
diff --git a/include/linux/rwsem.h b/include/linux/rwsem.h
index 4c715be..a66038d 100644
--- a/include/linux/rwsem.h
+++ b/include/linux/rwsem.h
@@ -110,7 +110,7 @@ do {								\
 
 /*
  * This is the same regardless of which rwsem implementation that is being used.
- * It is just a heuristic meant to be called by somebody alreadying holding the
+ * It is just a heuristic meant to be called by somebody already holding the
  * rwsem to see if somebody from an incompatible type is wanting access to the
  * lock.
  */
diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index c0b8926..0e97287 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -1747,7 +1747,7 @@ static enum bfs_result __bfs(struct lock_list *source_entry,
 
 		/*
 		 * Step 4: if not match, expand the path by adding the
-		 *         forward or backwards dependencis in the search
+		 *         forward or backwards dependencies in the search
 		 *
 		 */
 		first = true;
@@ -1916,7 +1916,7 @@ print_circular_bug_header(struct lock_list *entry, unsigned int depth,
  * -> B is -(ER)-> or -(EN)->, then we don't need to add A -> B into the
  * dependency graph, as any strong path ..-> A -> B ->.. we can get with
  * having dependency A -> B, we could already get a equivalent path ..-> A ->
- * .. -> B -> .. with A -> .. -> B. Therefore A -> B is reduntant.
+ * .. -> B -> .. with A -> .. -> B. Therefore A -> B is redundant.
  *
  * We need to make sure both the start and the end of A -> .. -> B is not
  * weaker than A -> B. For the start part, please see the comment in
diff --git a/kernel/locking/lockdep_proc.c b/kernel/locking/lockdep_proc.c
index 02ef87f..8069783 100644
--- a/kernel/locking/lockdep_proc.c
+++ b/kernel/locking/lockdep_proc.c
@@ -348,7 +348,7 @@ static int lockdep_stats_show(struct seq_file *m, void *v)
 			debug_locks);
 
 	/*
-	 * Zappped classes and lockdep data buffers reuse statistics.
+	 * Zapped classes and lockdep data buffers reuse statistics.
 	 */
 	seq_puts(m, "\n");
 	seq_printf(m, " zapped classes:                %11lu\n",
diff --git a/kernel/locking/mcs_spinlock.h b/kernel/locking/mcs_spinlock.h
index 5e10153..85251d8 100644
--- a/kernel/locking/mcs_spinlock.h
+++ b/kernel/locking/mcs_spinlock.h
@@ -7,7 +7,7 @@
  * The MCS lock (proposed by Mellor-Crummey and Scott) is a simple spin-lock
  * with the desirable properties of being fair, and with each cpu trying
  * to acquire the lock spinning on a local variable.
- * It avoids expensive cache bouncings that common test-and-set spin-lock
+ * It avoids expensive cache bounces that common test-and-set spin-lock
  * implementations incur.
  */
 #ifndef __LINUX_MCS_SPINLOCK_H
diff --git a/kernel/locking/mutex.c b/kernel/locking/mutex.c
index 622ebdf..cb6b112 100644
--- a/kernel/locking/mutex.c
+++ b/kernel/locking/mutex.c
@@ -92,7 +92,7 @@ static inline unsigned long __owner_flags(unsigned long owner)
 }
 
 /*
- * Trylock variant that retuns the owning task on failure.
+ * Trylock variant that returns the owning task on failure.
  */
 static inline struct task_struct *__mutex_trylock_or_owner(struct mutex *lock)
 {
@@ -207,7 +207,7 @@ __mutex_add_waiter(struct mutex *lock, struct mutex_waiter *waiter,
 
 /*
  * Give up ownership to a specific task, when @task = NULL, this is equivalent
- * to a regular unlock. Sets PICKUP on a handoff, clears HANDOF, preserves
+ * to a regular unlock. Sets PICKUP on a handoff, clears HANDOFF, preserves
  * WAITERS. Provides RELEASE semantics like a regular unlock, the
  * __mutex_trylock() provides a matching ACQUIRE semantics for the handoff.
  */
diff --git a/kernel/locking/osq_lock.c b/kernel/locking/osq_lock.c
index 1de006e..d5610ad 100644
--- a/kernel/locking/osq_lock.c
+++ b/kernel/locking/osq_lock.c
@@ -135,7 +135,7 @@ bool osq_lock(struct optimistic_spin_queue *lock)
 	 */
 
 	/*
-	 * Wait to acquire the lock or cancelation. Note that need_resched()
+	 * Wait to acquire the lock or cancellation. Note that need_resched()
 	 * will come with an IPI, which will wake smp_cond_load_relaxed() if it
 	 * is implemented with a monitor-wait. vcpu_is_preempted() relies on
 	 * polling, be careful.
@@ -164,7 +164,7 @@ bool osq_lock(struct optimistic_spin_queue *lock)
 
 		/*
 		 * We can only fail the cmpxchg() racing against an unlock(),
-		 * in which case we should observe @node->locked becomming
+		 * in which case we should observe @node->locked becoming
 		 * true.
 		 */
 		if (smp_load_acquire(&node->locked))
diff --git a/kernel/locking/rtmutex.c b/kernel/locking/rtmutex.c
index 29f09d0..db31bce 100644
--- a/kernel/locking/rtmutex.c
+++ b/kernel/locking/rtmutex.c
@@ -706,7 +706,7 @@ static int rt_mutex_adjust_prio_chain(struct task_struct *task,
 	} else if (prerequeue_top_waiter == waiter) {
 		/*
 		 * The waiter was the top waiter on the lock, but is
-		 * no longer the top prority waiter. Replace waiter in
+		 * no longer the top priority waiter. Replace waiter in
 		 * the owner tasks pi waiters tree with the new top
 		 * (highest priority) waiter and adjust the priority
 		 * of the owner.
@@ -1194,7 +1194,7 @@ static void rt_mutex_handle_deadlock(int res, int detect_deadlock,
 		return;
 
 	/*
-	 * Yell lowdly and stop the task right here.
+	 * Yell loudly and stop the task right here.
 	 */
 	rt_mutex_print_deadlock(w);
 	while (1) {
diff --git a/kernel/locking/rwsem.c b/kernel/locking/rwsem.c
index fe9cc65..809b001 100644
--- a/kernel/locking/rwsem.c
+++ b/kernel/locking/rwsem.c
@@ -819,7 +819,7 @@ static bool rwsem_optimistic_spin(struct rw_semaphore *sem)
 		 *    we try to get it. The new owner may be a spinnable
 		 *    writer.
 		 *
-		 * To take advantage of two scenarios listed agove, the RT
+		 * To take advantage of two scenarios listed above, the RT
 		 * task is made to retry one more time to see if it can
 		 * acquire the lock or continue spinning on the new owning
 		 * writer. Of course, if the time lag is long enough or the
diff --git a/kernel/locking/spinlock.c b/kernel/locking/spinlock.c
index 0ff0838..c8d7ad9 100644
--- a/kernel/locking/spinlock.c
+++ b/kernel/locking/spinlock.c
@@ -58,10 +58,10 @@ EXPORT_PER_CPU_SYMBOL(__mmiowb_state);
 /*
  * We build the __lock_function inlines here. They are too large for
  * inlining all over the place, but here is only one user per function
- * which embedds them into the calling _lock_function below.
+ * which embeds them into the calling _lock_function below.
  *
  * This could be a long-held lock. We both prepare to spin for a long
- * time (making _this_ CPU preemptable if possible), and we also signal
+ * time (making _this_ CPU preemptible if possible), and we also signal
  * towards that other CPU that it should break the lock ASAP.
  */
 #define BUILD_LOCK_OPS(op, locktype)					\
