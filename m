Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B95C63EF32D
	for <lists+linux-tip-commits@lfdr.de>; Tue, 17 Aug 2021 22:15:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233714AbhHQUOf (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Tue, 17 Aug 2021 16:14:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234145AbhHQUOd (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Tue, 17 Aug 2021 16:14:33 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E871CC0613C1;
        Tue, 17 Aug 2021 13:13:59 -0700 (PDT)
Date:   Tue, 17 Aug 2021 20:13:57 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1629231238;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gPzEntAMTQLQV0hfENmcu0KKKAKqEz9WFLsv8fD71Vg=;
        b=bRF63/F9dvVLm/u5EHANoHdDsGC6MeaED7rdgFS3SggjFAe2RHMMmIb2fETBOfAZn6I9Ot
        /yQu59KzIcSqhMWrxnGBBG+JM6ERSgDmYlgYrgeP5n4IAzss2nLXynySzoEkau85GoRHck
        9U9s0EbHZ0L5EHTs4lCOuNy6QJho6n8MXiMU8+k+86CA20vhyy0Yumo8jXLTS9pnxzx0P4
        MyHLU2NGs0ADzKXgzU2PkIcpIugCyun4M2xyBW0MY5xfhjdPBCwfuFtzMdI+beeBK0Vki3
        R5ONozW7ZOf2XX0pCfgiedYRtuQ88c92rfu6862vfhww3DMeLkFmG0jHMHO19w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1629231238;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gPzEntAMTQLQV0hfENmcu0KKKAKqEz9WFLsv8fD71Vg=;
        b=fmiBV3xMvoy3vkvpcBHrzJLFOiCdyJ/YcB95q5w6ZlJP1ozrptBUEhxP7BNZd5PzLDgeSJ
        gMldDvj1d1C0cMDQ==
From:   "tip-bot2 for Steven Rostedt" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] locking/rtmutex: Add adaptive spinwait mechanism
Cc:     Gregory Haskins <ghaskins@novell.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210815211305.912050691@linutronix.de>
References: <20210815211305.912050691@linutronix.de>
MIME-Version: 1.0
Message-ID: <162923123763.25758.11891289655344170456.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     992caf7f17243d736fc996770bac6566103778f6
Gitweb:        https://git.kernel.org/tip/992caf7f17243d736fc996770bac6566103778f6
Author:        Steven Rostedt <rostedt@goodmis.org>
AuthorDate:    Sun, 15 Aug 2021 23:29:25 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 17 Aug 2021 19:06:11 +02:00

locking/rtmutex: Add adaptive spinwait mechanism

Going to sleep when locks are contended can be quite inefficient when the
contention time is short and the lock owner is running on a different CPU.

The MCS mechanism cannot be used because MCS is strictly FIFO ordered while
for rtmutex based locks the waiter ordering is priority based.

Provide a simple adaptive spinwait mechanism which currently restricts the
spinning to the top priority waiter.

[ tglx: Provide a contemporary changelog, extended it to all rtmutex based
  	locks and updated it to match the other spin on owner implementations ]

Originally-by: Gregory Haskins <ghaskins@novell.com>
Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/20210815211305.912050691@linutronix.de
---
 kernel/locking/rtmutex.c | 67 +++++++++++++++++++++++++++++++++++++--
 1 file changed, 65 insertions(+), 2 deletions(-)

diff --git a/kernel/locking/rtmutex.c b/kernel/locking/rtmutex.c
index 3eaf636..8aaa352 100644
--- a/kernel/locking/rtmutex.c
+++ b/kernel/locking/rtmutex.c
@@ -8,6 +8,11 @@
  *  Copyright (C) 2005-2006 Timesys Corp., Thomas Gleixner <tglx@timesys.com>
  *  Copyright (C) 2005 Kihon Technologies Inc., Steven Rostedt
  *  Copyright (C) 2006 Esben Nielsen
+ * Adaptive Spinlocks:
+ *  Copyright (C) 2008 Novell, Inc., Gregory Haskins, Sven Dietrich,
+ *				     and Peter Morreale,
+ * Adaptive Spinlocks simplification:
+ *  Copyright (C) 2008 Red Hat, Inc., Steven Rostedt <srostedt@redhat.com>
  *
  *  See Documentation/locking/rt-mutex-design.rst for details.
  */
@@ -1297,6 +1302,52 @@ static __always_inline void __rt_mutex_unlock(struct rt_mutex_base *lock)
 	rt_mutex_slowunlock(lock);
 }
 
+#ifdef CONFIG_SMP
+static bool rtmutex_spin_on_owner(struct rt_mutex_base *lock,
+				  struct rt_mutex_waiter *waiter,
+				  struct task_struct *owner)
+{
+	bool res = true;
+
+	rcu_read_lock();
+	for (;;) {
+		/* If owner changed, trylock again. */
+		if (owner != rt_mutex_owner(lock))
+			break;
+		/*
+		 * Ensure that @owner is dereferenced after checking that
+		 * the lock owner still matches @owner. If that fails,
+		 * @owner might point to freed memory. If it still matches,
+		 * the rcu_read_lock() ensures the memory stays valid.
+		 */
+		barrier();
+		/*
+		 * Stop spinning when:
+		 *  - the lock owner has been scheduled out
+		 *  - current is not longer the top waiter
+		 *  - current is requested to reschedule (redundant
+		 *    for CONFIG_PREEMPT_RCU=y)
+		 *  - the VCPU on which owner runs is preempted
+		 */
+		if (!owner->on_cpu || waiter != rt_mutex_top_waiter(lock) ||
+		    need_resched() || vcpu_is_preempted(task_cpu(owner))) {
+			res = false;
+			break;
+		}
+		cpu_relax();
+	}
+	rcu_read_unlock();
+	return res;
+}
+#else
+static bool rtmutex_spin_on_owner(struct rt_mutex_base *lock,
+				  struct rt_mutex_waiter *waiter,
+				  struct task_struct *owner)
+{
+	return false;
+}
+#endif
+
 #ifdef RT_MUTEX_BUILD_MUTEX
 /*
  * Functions required for:
@@ -1381,6 +1432,7 @@ static int __sched rt_mutex_slowlock_block(struct rt_mutex_base *lock,
 					   struct rt_mutex_waiter *waiter)
 {
 	struct rt_mutex *rtm = container_of(lock, struct rt_mutex, rtmutex);
+	struct task_struct *owner;
 	int ret = 0;
 
 	for (;;) {
@@ -1403,9 +1455,14 @@ static int __sched rt_mutex_slowlock_block(struct rt_mutex_base *lock,
 				break;
 		}
 
+		if (waiter == rt_mutex_top_waiter(lock))
+			owner = rt_mutex_owner(lock);
+		else
+			owner = NULL;
 		raw_spin_unlock_irq(&lock->wait_lock);
 
-		schedule();
+		if (!owner || !rtmutex_spin_on_owner(lock, waiter, owner))
+			schedule();
 
 		raw_spin_lock_irq(&lock->wait_lock);
 		set_current_state(state);
@@ -1561,6 +1618,7 @@ static __always_inline int __rt_mutex_lock(struct rt_mutex_base *lock,
 static void __sched rtlock_slowlock_locked(struct rt_mutex_base *lock)
 {
 	struct rt_mutex_waiter waiter;
+	struct task_struct *owner;
 
 	lockdep_assert_held(&lock->wait_lock);
 
@@ -1579,9 +1637,14 @@ static void __sched rtlock_slowlock_locked(struct rt_mutex_base *lock)
 		if (try_to_take_rt_mutex(lock, current, &waiter))
 			break;
 
+		if (&waiter == rt_mutex_top_waiter(lock))
+			owner = rt_mutex_owner(lock);
+		else
+			owner = NULL;
 		raw_spin_unlock_irq(&lock->wait_lock);
 
-		schedule_rtlock();
+		if (!owner || !rtmutex_spin_on_owner(lock, &waiter, owner))
+			schedule_rtlock();
 
 		raw_spin_lock_irq(&lock->wait_lock);
 		set_current_state(TASK_RTLOCK_WAIT);
