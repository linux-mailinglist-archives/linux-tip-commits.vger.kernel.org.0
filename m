Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 793DC3EF367
	for <lists+linux-tip-commits@lfdr.de>; Tue, 17 Aug 2021 22:15:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235451AbhHQUP3 (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Tue, 17 Aug 2021 16:15:29 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:34902 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235005AbhHQUPC (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Tue, 17 Aug 2021 16:15:02 -0400
Date:   Tue, 17 Aug 2021 20:14:26 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1629231267;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cGqV7bciBgo1BGiDbb8gbTQ39JVPd5DkF6VaUAqnq0k=;
        b=Mf2/0v4XTdT0Aeq/bv3pNR5J9ZuJo2dmov5I4/6WlRyhUZWlCw6OPlad2DMv4rkY7BYZIP
        3dR3Dq/sQBM1F9MA1pd2mXiNhMjxmgA5GhZKh1m0OkJ1zqqaVB+CimxARkt19BO+tC4AZO
        4oFYqGUIxjIRt3CVivhaTdHzepZCksYWHLt+SPxecEawt1dcAXTb4pDyUuFGmPnbYH5eQG
        kem1RmKATebRQjAmJZzHrk3SGQ4UIWdCTJCd46VtAhyfjS8Z8ZAdjSFvcQuIkkzf8HYwP3
        VugWDzpdhD46NpjSAKvCRmck/iKbCmItGbOZz2HFIHdbImythuC40NSI7CNGiQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1629231267;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cGqV7bciBgo1BGiDbb8gbTQ39JVPd5DkF6VaUAqnq0k=;
        b=rRxIy/58w1bwbOTId5VR143YD3FH8FogAPrgttPsSmXPoqqo8zOy+fJ2cxt5VOctA9+0yk
        eRhbVnMXo/W2PTAg==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] locking/rtmutex: Add wake_state to rt_mutex_waiter
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210815211303.079800739@linutronix.de>
References: <20210815211303.079800739@linutronix.de>
MIME-Version: 1.0
Message-ID: <162923126695.25758.3283853670080274019.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     c014ef69b3acdb8c9e7fc412e96944f4d5c36fa0
Gitweb:        https://git.kernel.org/tip/c014ef69b3acdb8c9e7fc412e96944f4d5c36fa0
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Sun, 15 Aug 2021 23:28:06 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 17 Aug 2021 17:15:36 +02:00

locking/rtmutex: Add wake_state to rt_mutex_waiter

Regular sleeping locks like mutexes, rtmutexes and rw_semaphores are always
entering and leaving a blocking section with task state == TASK_RUNNING.

On a non-RT kernel spinlocks and rwlocks never affect the task state, but
on RT kernels these locks are converted to rtmutex based 'sleeping' locks.

So in case of contention the task goes to block, which requires to carefully
preserve the task state, and restore it after acquiring the lock taking
regular wakeups for the task into account, which happened while the task was
blocked. This state preserving is achieved by having a separate task state
for blocking on a RT spin/rwlock and a saved_state field in task_struct
along with careful handling of these wakeup scenarios in try_to_wake_up().

To avoid conditionals in the rtmutex code, store the wake state which has
to be used for waking a lock waiter in rt_mutex_waiter which allows to
handle the regular and RT spin/rwlocks by handing it to wake_up_state().

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/20210815211303.079800739@linutronix.de
---
 kernel/locking/rtmutex.c        |  2 +-
 kernel/locking/rtmutex_common.h |  9 +++++++++
 2 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/kernel/locking/rtmutex.c b/kernel/locking/rtmutex.c
index 3d0b29c..c13b9b8 100644
--- a/kernel/locking/rtmutex.c
+++ b/kernel/locking/rtmutex.c
@@ -692,7 +692,7 @@ static int __sched rt_mutex_adjust_prio_chain(struct task_struct *task,
 		 * to get the lock.
 		 */
 		if (prerequeue_top_waiter != rt_mutex_top_waiter(lock))
-			wake_up_process(rt_mutex_top_waiter(lock)->task);
+			wake_up_state(waiter->task, waiter->wake_state);
 		raw_spin_unlock_irq(&lock->wait_lock);
 		return 0;
 	}
diff --git a/kernel/locking/rtmutex_common.h b/kernel/locking/rtmutex_common.h
index 548285a..fcc55de 100644
--- a/kernel/locking/rtmutex_common.h
+++ b/kernel/locking/rtmutex_common.h
@@ -25,6 +25,7 @@
  * @pi_tree_entry:	pi node to enqueue into the mutex owner waiters tree
  * @task:		task reference to the blocked task
  * @lock:		Pointer to the rt_mutex on which the waiter blocks
+ * @wake_state:		Wakeup state to use (TASK_NORMAL or TASK_RTLOCK_WAIT)
  * @prio:		Priority of the waiter
  * @deadline:		Deadline of the waiter if applicable
  */
@@ -33,6 +34,7 @@ struct rt_mutex_waiter {
 	struct rb_node		pi_tree_entry;
 	struct task_struct	*task;
 	struct rt_mutex_base	*lock;
+	unsigned int		wake_state;
 	int			prio;
 	u64			deadline;
 };
@@ -158,9 +160,16 @@ static inline void rt_mutex_init_waiter(struct rt_mutex_waiter *waiter)
 	debug_rt_mutex_init_waiter(waiter);
 	RB_CLEAR_NODE(&waiter->pi_tree_entry);
 	RB_CLEAR_NODE(&waiter->tree_entry);
+	waiter->wake_state = TASK_NORMAL;
 	waiter->task = NULL;
 }
 
+static inline void rtlock_init_rtmutex_waiter(struct rt_mutex_waiter *waiter)
+{
+	rt_mutex_init_waiter(waiter);
+	waiter->wake_state = TASK_RTLOCK_WAIT;
+}
+
 #else /* CONFIG_RT_MUTEXES */
 /* Used in rcu/tree_plugin.h */
 static inline struct task_struct *rt_mutex_owner(struct rt_mutex_base *lock)
