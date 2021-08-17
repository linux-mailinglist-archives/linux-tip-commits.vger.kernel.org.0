Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 308C03EF366
	for <lists+linux-tip-commits@lfdr.de>; Tue, 17 Aug 2021 22:15:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235426AbhHQUP2 (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Tue, 17 Aug 2021 16:15:28 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:34880 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234952AbhHQUPB (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Tue, 17 Aug 2021 16:15:01 -0400
Date:   Tue, 17 Aug 2021 20:14:25 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1629231266;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Yid1/MucJ0awrQgqm5pSR7nHeuKu0/gigtyhpUNv8yo=;
        b=cZGpSVVXEW2nxaIIhc2NVi+Qtrcu2gm8noFqnC1w8jA0pKyOvxvEJvsab4r4ZuYJ/s9fHa
        kcXokQljmSlHmMBenyOXKkuykiRpf2zr/W1vcHnlfmXgJoMeJDLagW+dnHpCE7O3kDxgiN
        2523PCNXBnsWjNi9vGwUAogxBZ4NgvPw965OiUwzWaUvdLE/bPdWFEuUqdpPTdw2GfRYkP
        JvKtPM3AwQ6Z2Bzx/zeHFaxKuSJikj+WBRLhqe4ux51UUEPBs3WDBHGIzRDQImS1xIWikT
        xnphyLdk3Hdmkn9GHeA/cBWvAsvvPGm9JplvsGYErDA5vsUnmI9D0+zZakZ18A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1629231266;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Yid1/MucJ0awrQgqm5pSR7nHeuKu0/gigtyhpUNv8yo=;
        b=6Guh4u81d0CwLx8uj9SvaTpzjTExg/k8WYRgDRS4AgOzcKKBtmE+EcreIyAXRD9wWWgw9Z
        wLzvesCpOHsFfhBw==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] locking/rtmutex: Use rt_mutex_wake_q_head
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210815211303.197113263@linutronix.de>
References: <20210815211303.197113263@linutronix.de>
MIME-Version: 1.0
Message-ID: <162923126579.25758.4236219925296340637.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     7980aa397cc0968ea3ffee7a985c31c92ad84f81
Gitweb:        https://git.kernel.org/tip/7980aa397cc0968ea3ffee7a985c31c92ad84f81
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Sun, 15 Aug 2021 23:28:09 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 17 Aug 2021 17:20:14 +02:00

locking/rtmutex: Use rt_mutex_wake_q_head

Prepare for the required state aware handling of waiter wakeups via wake_q
and switch the rtmutex code over to the rtmutex specific wrapper.

No functional change.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/20210815211303.197113263@linutronix.de
---
 kernel/futex.c                  |  8 ++++----
 kernel/locking/rtmutex.c        | 12 ++++++------
 kernel/locking/rtmutex_api.c    | 19 ++++++++-----------
 kernel/locking/rtmutex_common.h |  4 ++--
 4 files changed, 20 insertions(+), 23 deletions(-)

diff --git a/kernel/futex.c b/kernel/futex.c
index 6eab247..21625cb 100644
--- a/kernel/futex.c
+++ b/kernel/futex.c
@@ -1493,11 +1493,11 @@ static void mark_wake_futex(struct wake_q_head *wake_q, struct futex_q *q)
  */
 static int wake_futex_pi(u32 __user *uaddr, u32 uval, struct futex_pi_state *pi_state)
 {
-	u32 curval, newval;
 	struct rt_mutex_waiter *top_waiter;
 	struct task_struct *new_owner;
 	bool postunlock = false;
-	DEFINE_WAKE_Q(wake_q);
+	DEFINE_RT_WAKE_Q(wqh);
+	u32 curval, newval;
 	int ret = 0;
 
 	top_waiter = rt_mutex_top_waiter(&pi_state->pi_mutex);
@@ -1549,14 +1549,14 @@ static int wake_futex_pi(u32 __user *uaddr, u32 uval, struct futex_pi_state *pi_
 		 * not fail.
 		 */
 		pi_state_update_owner(pi_state, new_owner);
-		postunlock = __rt_mutex_futex_unlock(&pi_state->pi_mutex, &wake_q);
+		postunlock = __rt_mutex_futex_unlock(&pi_state->pi_mutex, &wqh);
 	}
 
 out_unlock:
 	raw_spin_unlock_irq(&pi_state->pi_mutex.wait_lock);
 
 	if (postunlock)
-		rt_mutex_postunlock(&wake_q);
+		rt_mutex_postunlock(&wqh);
 
 	return ret;
 }
diff --git a/kernel/locking/rtmutex.c b/kernel/locking/rtmutex.c
index 35f7685..5f0d072 100644
--- a/kernel/locking/rtmutex.c
+++ b/kernel/locking/rtmutex.c
@@ -1017,7 +1017,7 @@ static int __sched task_blocks_on_rt_mutex(struct rt_mutex_base *lock,
  *
  * Called with lock->wait_lock held and interrupts disabled.
  */
-static void __sched mark_wakeup_next_waiter(struct wake_q_head *wake_q,
+static void __sched mark_wakeup_next_waiter(struct rt_wake_q_head *wqh,
 					    struct rt_mutex_base *lock)
 {
 	struct rt_mutex_waiter *waiter;
@@ -1054,10 +1054,10 @@ static void __sched mark_wakeup_next_waiter(struct wake_q_head *wake_q,
 	 * deboost but before waking our donor task, hence the preempt_disable()
 	 * before unlock.
 	 *
-	 * Pairs with preempt_enable() in rt_mutex_postunlock();
+	 * Pairs with preempt_enable() in rt_mutex_wake_up_q();
 	 */
 	preempt_disable();
-	wake_q_add(wake_q, waiter->task);
+	rt_mutex_wake_q_add(wqh, waiter);
 	raw_spin_unlock(&current->pi_lock);
 }
 
@@ -1328,7 +1328,7 @@ static __always_inline int __rt_mutex_trylock(struct rt_mutex_base *lock)
  */
 static void __sched rt_mutex_slowunlock(struct rt_mutex_base *lock)
 {
-	DEFINE_WAKE_Q(wake_q);
+	DEFINE_RT_WAKE_Q(wqh);
 	unsigned long flags;
 
 	/* irqsave required to support early boot calls */
@@ -1381,10 +1381,10 @@ static void __sched rt_mutex_slowunlock(struct rt_mutex_base *lock)
 	 *
 	 * Queue the next waiter for wakeup once we release the wait_lock.
 	 */
-	mark_wakeup_next_waiter(&wake_q, lock);
+	mark_wakeup_next_waiter(&wqh, lock);
 	raw_spin_unlock_irqrestore(&lock->wait_lock, flags);
 
-	rt_mutex_postunlock(&wake_q);
+	rt_mutex_wake_up_q(&wqh);
 }
 
 static __always_inline void __rt_mutex_unlock(struct rt_mutex_base *lock)
diff --git a/kernel/locking/rtmutex_api.c b/kernel/locking/rtmutex_api.c
index c5136f4..56403dc 100644
--- a/kernel/locking/rtmutex_api.c
+++ b/kernel/locking/rtmutex_api.c
@@ -137,10 +137,10 @@ int __sched __rt_mutex_futex_trylock(struct rt_mutex_base *lock)
  * do not use the fast-path, can be simple and will not need to retry.
  *
  * @lock:	The rt_mutex to be unlocked
- * @wake_q:	The wake queue head from which to get the next lock waiter
+ * @wqh:	The wake queue head from which to get the next lock waiter
  */
 bool __sched __rt_mutex_futex_unlock(struct rt_mutex_base *lock,
-				     struct wake_q_head *wake_q)
+				     struct rt_wake_q_head *wqh)
 {
 	lockdep_assert_held(&lock->wait_lock);
 
@@ -157,23 +157,23 @@ bool __sched __rt_mutex_futex_unlock(struct rt_mutex_base *lock,
 	 * avoid inversion prior to the wakeup.  preempt_disable()
 	 * therein pairs with rt_mutex_postunlock().
 	 */
-	mark_wakeup_next_waiter(wake_q, lock);
+	mark_wakeup_next_waiter(wqh, lock);
 
 	return true; /* call postunlock() */
 }
 
 void __sched rt_mutex_futex_unlock(struct rt_mutex_base *lock)
 {
-	DEFINE_WAKE_Q(wake_q);
+	DEFINE_RT_WAKE_Q(wqh);
 	unsigned long flags;
 	bool postunlock;
 
 	raw_spin_lock_irqsave(&lock->wait_lock, flags);
-	postunlock = __rt_mutex_futex_unlock(lock, &wake_q);
+	postunlock = __rt_mutex_futex_unlock(lock, &wqh);
 	raw_spin_unlock_irqrestore(&lock->wait_lock, flags);
 
 	if (postunlock)
-		rt_mutex_postunlock(&wake_q);
+		rt_mutex_postunlock(&wqh);
 }
 
 /**
@@ -441,12 +441,9 @@ void __sched rt_mutex_adjust_pi(struct task_struct *task)
 /*
  * Performs the wakeup of the top-waiter and re-enables preemption.
  */
-void __sched rt_mutex_postunlock(struct wake_q_head *wake_q)
+void __sched rt_mutex_postunlock(struct rt_wake_q_head *wqh)
 {
-	wake_up_q(wake_q);
-
-	/* Pairs with preempt_disable() in mark_wakeup_next_waiter() */
-	preempt_enable();
+	rt_mutex_wake_up_q(wqh);
 }
 
 #ifdef CONFIG_DEBUG_RT_MUTEXES
diff --git a/kernel/locking/rtmutex_common.h b/kernel/locking/rtmutex_common.h
index 9e2f1db..ff36316 100644
--- a/kernel/locking/rtmutex_common.h
+++ b/kernel/locking/rtmutex_common.h
@@ -76,9 +76,9 @@ extern int __rt_mutex_futex_trylock(struct rt_mutex_base *l);
 
 extern void rt_mutex_futex_unlock(struct rt_mutex_base *lock);
 extern bool __rt_mutex_futex_unlock(struct rt_mutex_base *lock,
-				struct wake_q_head *wake_q);
+				struct rt_wake_q_head *wqh);
 
-extern void rt_mutex_postunlock(struct wake_q_head *wake_q);
+extern void rt_mutex_postunlock(struct rt_wake_q_head *wqh);
 
 /*
  * Must be guarded because this header is included from rcu/tree_plugin.h
