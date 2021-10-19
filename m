Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 379D2433AA3
	for <lists+linux-tip-commits@lfdr.de>; Tue, 19 Oct 2021 17:35:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231947AbhJSPhw (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Tue, 19 Oct 2021 11:37:52 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:46502 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231574AbhJSPhv (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Tue, 19 Oct 2021 11:37:51 -0400
Date:   Tue, 19 Oct 2021 15:35:36 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1634657737;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Kiuf8lNuMz3AF0XWv9PfZ84rabRQqrQddA3gryuhXg0=;
        b=WCPjl7+RMe/FbiMfHY7BzgANp1Q2bCQToEWQ+aoVhLeHl9u3nDYe1XeHnYdjuryYlQqUhI
        fJF5EbWAIsFJ915PnKQ1JUPiWj4MawwCBTLrixTOL/OQKPImjcCI5lPazrKJ7qHBspaMBs
        HcNWGWEwCT6VbIglq34eUhh0TWanSePMqg7g3me3522E4wsuM4ue3/FFQ9olX4gXvpUsal
        gEsRCmk+gvcE+fzmB3UD3tfyOPKzA2Vf2SeSMYbTLJn1mEzMh4ADuChA2WdlJomTQASI+u
        3shKtEEkXl7USfHk3WiafRY/1G1ejgejMi9jGrCdBPFrtxSS7cj+C/QNb8FO8g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1634657737;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Kiuf8lNuMz3AF0XWv9PfZ84rabRQqrQddA3gryuhXg0=;
        b=vyfVKJk+tKrQTWAURYQUggbGLNvo9Ly9bIJUMbj9xDiCiAASOif8nM7wS8V31A1j4ADaw+
        T2j8O/m8A0un1GBg==
From:   "tip-bot2 for Yanfei Xu" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] locking: Remove rcu_read_{,un}lock() for
 preempt_{dis,en}able()
Cc:     Yanfei Xu <yanfei.xu@windriver.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Waiman Long <longman@redhat.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20211013134154.1085649-2-yanfei.xu@windriver.com>
References: <20211013134154.1085649-2-yanfei.xu@windriver.com>
MIME-Version: 1.0
Message-ID: <163465773649.25758.15688942192146286296.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     6c2787f2a20ceb49c98bd06f7dad1589eed1c951
Gitweb:        https://git.kernel.org/tip/6c2787f2a20ceb49c98bd06f7dad1589eed1c951
Author:        Yanfei Xu <yanfei.xu@windriver.com>
AuthorDate:    Wed, 13 Oct 2021 21:41:52 +08:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 19 Oct 2021 17:27:06 +02:00

locking: Remove rcu_read_{,un}lock() for preempt_{dis,en}able()

preempt_disable/enable() is equal to RCU read-side crital section, and
the spinning codes in mutex and rwsem could ensure that the preemption
is disabled. So let's remove the unnecessary rcu_read_lock/unlock for
saving some cycles in hot codes.

Signed-off-by: Yanfei Xu <yanfei.xu@windriver.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Waiman Long <longman@redhat.com>
Link: https://lore.kernel.org/r/20211013134154.1085649-2-yanfei.xu@windriver.com
---
 kernel/locking/mutex.c | 22 +++++++++++++++-------
 kernel/locking/rwsem.c | 14 +++++++++-----
 2 files changed, 24 insertions(+), 12 deletions(-)

diff --git a/kernel/locking/mutex.c b/kernel/locking/mutex.c
index 2fede72..db19136 100644
--- a/kernel/locking/mutex.c
+++ b/kernel/locking/mutex.c
@@ -351,13 +351,16 @@ bool mutex_spin_on_owner(struct mutex *lock, struct task_struct *owner,
 {
 	bool ret = true;
 
-	rcu_read_lock();
+	lockdep_assert_preemption_disabled();
+
 	while (__mutex_owner(lock) == owner) {
 		/*
 		 * Ensure we emit the owner->on_cpu, dereference _after_
-		 * checking lock->owner still matches owner. If that fails,
-		 * owner might point to freed memory. If it still matches,
-		 * the rcu_read_lock() ensures the memory stays valid.
+		 * checking lock->owner still matches owner. And we already
+		 * disabled preemption which is equal to the RCU read-side
+		 * crital section in optimistic spinning code. Thus the
+		 * task_strcut structure won't go away during the spinning
+		 * period
 		 */
 		barrier();
 
@@ -377,7 +380,6 @@ bool mutex_spin_on_owner(struct mutex *lock, struct task_struct *owner,
 
 		cpu_relax();
 	}
-	rcu_read_unlock();
 
 	return ret;
 }
@@ -390,19 +392,25 @@ static inline int mutex_can_spin_on_owner(struct mutex *lock)
 	struct task_struct *owner;
 	int retval = 1;
 
+	lockdep_assert_preemption_disabled();
+
 	if (need_resched())
 		return 0;
 
-	rcu_read_lock();
+	/*
+	 * We already disabled preemption which is equal to the RCU read-side
+	 * crital section in optimistic spinning code. Thus the task_strcut
+	 * structure won't go away during the spinning period.
+	 */
 	owner = __mutex_owner(lock);
 
 	/*
 	 * As lock holder preemption issue, we both skip spinning if task is not
 	 * on cpu or its cpu is preempted
 	 */
+
 	if (owner)
 		retval = owner->on_cpu && !vcpu_is_preempted(task_cpu(owner));
-	rcu_read_unlock();
 
 	/*
 	 * If lock->owner is not set, the mutex has been released. Return true
diff --git a/kernel/locking/rwsem.c b/kernel/locking/rwsem.c
index 29eea50..884aa08 100644
--- a/kernel/locking/rwsem.c
+++ b/kernel/locking/rwsem.c
@@ -635,7 +635,10 @@ static inline bool rwsem_can_spin_on_owner(struct rw_semaphore *sem)
 	}
 
 	preempt_disable();
-	rcu_read_lock();
+	/*
+	 * Disable preemption is equal to the RCU read-side crital section,
+	 * thus the task_strcut structure won't go away.
+	 */
 	owner = rwsem_owner_flags(sem, &flags);
 	/*
 	 * Don't check the read-owner as the entry may be stale.
@@ -643,7 +646,6 @@ static inline bool rwsem_can_spin_on_owner(struct rw_semaphore *sem)
 	if ((flags & RWSEM_NONSPINNABLE) ||
 	    (owner && !(flags & RWSEM_READER_OWNED) && !owner_on_cpu(owner)))
 		ret = false;
-	rcu_read_unlock();
 	preempt_enable();
 
 	lockevent_cond_inc(rwsem_opt_fail, !ret);
@@ -671,12 +673,13 @@ rwsem_spin_on_owner(struct rw_semaphore *sem)
 	unsigned long flags, new_flags;
 	enum owner_state state;
 
+	lockdep_assert_preemption_disabled();
+
 	owner = rwsem_owner_flags(sem, &flags);
 	state = rwsem_owner_state(owner, flags);
 	if (state != OWNER_WRITER)
 		return state;
 
-	rcu_read_lock();
 	for (;;) {
 		/*
 		 * When a waiting writer set the handoff flag, it may spin
@@ -694,7 +697,9 @@ rwsem_spin_on_owner(struct rw_semaphore *sem)
 		 * Ensure we emit the owner->on_cpu, dereference _after_
 		 * checking sem->owner still matches owner, if that fails,
 		 * owner might point to free()d memory, if it still matches,
-		 * the rcu_read_lock() ensures the memory stays valid.
+		 * our spinning context already disabled preemption which is
+		 * equal to RCU read-side crital section ensures the memory
+		 * stays valid.
 		 */
 		barrier();
 
@@ -705,7 +710,6 @@ rwsem_spin_on_owner(struct rw_semaphore *sem)
 
 		cpu_relax();
 	}
-	rcu_read_unlock();
 
 	return state;
 }
