Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 76A9341F060
	for <lists+linux-tip-commits@lfdr.de>; Fri,  1 Oct 2021 17:05:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354854AbhJAPH1 (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 1 Oct 2021 11:07:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354823AbhJAPHV (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 1 Oct 2021 11:07:21 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A93CBC0613E3;
        Fri,  1 Oct 2021 08:05:35 -0700 (PDT)
Date:   Fri, 01 Oct 2021 15:05:33 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1633100734;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9IxePFpz2ZKeOBPBxHylyzKq4Z2uegB5A42NvbaMi38=;
        b=BhmC6uOc687I7/vMDYyLkiy/1UJ9t2FITlzn3sc40E3MipTbe0FTe17X4hAL8C23UPGPDK
        m+MRCoOqwRJFlIgvOHNbOl+/I1VATaG1Ce6yb5PrQO68k2U6pCRZ6+BRnV8RJyZKsMIAIh
        iQCEoK2Fu8zNfYg6qBp2jN4fhW15C782+XvXwnHjbIk6UuIkkZutL2C8A+2OyBgrs+qd8h
        Pk2e4yPbG8qZif2iGfntf46VtjDUc4l79SjQihoOfwT+zUbxmuWgR44twulft/2Gs6hwn6
        F5MlIU6X+1RMEi8TA4xC7XF9SQg0hxKBy4z5v4wKnjmhlFCiSQfOhWZr+nX0Bw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1633100734;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9IxePFpz2ZKeOBPBxHylyzKq4Z2uegB5A42NvbaMi38=;
        b=nqBDx9FPwQ/owOo499Nk/tV33AFutxntXAyucXGU/1RlVitKYY6XqgAnv8VxBkGuvcNwP6
        2N66yH5VEiBG+XCA==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] sched: Clean up the might_sleep() underscore zoo
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210923165357.928693482@linutronix.de>
References: <20210923165357.928693482@linutronix.de>
MIME-Version: 1.0
Message-ID: <163310073320.25758.15346473778130672854.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     874f670e6088d3bff3972ecd44c1cb00610f9183
Gitweb:        https://git.kernel.org/tip/874f670e6088d3bff3972ecd44c1cb00610f9183
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Thu, 23 Sep 2021 18:54:35 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 01 Oct 2021 13:57:49 +02:00

sched: Clean up the might_sleep() underscore zoo

__might_sleep() vs. ___might_sleep() is hard to distinguish. Aside of that
the three underscore variant is exposed to provide a checkpoint for
rescheduling points which are distinct from blocking points.

They are semantically a preemption point which means that scheduling is
state preserving. A real blocking operation, e.g. mutex_lock(), wait*(),
which cannot preserve a task state which is not equal to RUNNING.

While technically blocking on a "sleeping" spinlock in RT enabled kernels
falls into the voluntary scheduling category because it has to wait until
the contended spin/rw lock becomes available, the RT lock substitution code
can semantically be mapped to a voluntary preemption because the RT lock
substitution code and the scheduler are providing mechanisms to preserve
the task state and to take regular non-lock related wakeups into account.

Rename ___might_sleep() to __might_resched() to make the distinction of
these functions clear.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20210923165357.928693482@linutronix.de
---
 include/linux/kernel.h       | 6 +++---
 include/linux/sched.h        | 8 ++++----
 kernel/locking/spinlock_rt.c | 6 +++---
 kernel/sched/core.c          | 6 +++---
 4 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/include/linux/kernel.h b/include/linux/kernel.h
index 2776423..5e4ae54 100644
--- a/include/linux/kernel.h
+++ b/include/linux/kernel.h
@@ -111,7 +111,7 @@ static __always_inline void might_resched(void)
 #endif /* CONFIG_PREEMPT_* */
 
 #ifdef CONFIG_DEBUG_ATOMIC_SLEEP
-extern void ___might_sleep(const char *file, int line, int preempt_offset);
+extern void __might_resched(const char *file, int line, int preempt_offset);
 extern void __might_sleep(const char *file, int line, int preempt_offset);
 extern void __cant_sleep(const char *file, int line, int preempt_offset);
 extern void __cant_migrate(const char *file, int line);
@@ -168,8 +168,8 @@ extern void __cant_migrate(const char *file, int line);
  */
 # define non_block_end() WARN_ON(current->non_block_count-- == 0)
 #else
-  static inline void ___might_sleep(const char *file, int line,
-				   int preempt_offset) { }
+  static inline void __might_resched(const char *file, int line,
+				     int preempt_offset) { }
   static inline void __might_sleep(const char *file, int line,
 				   int preempt_offset) { }
 # define might_sleep() do { might_resched(); } while (0)
diff --git a/include/linux/sched.h b/include/linux/sched.h
index e12b524..b38f002 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -2038,7 +2038,7 @@ static inline int _cond_resched(void) { return 0; }
 #endif /* !defined(CONFIG_PREEMPTION) || defined(CONFIG_PREEMPT_DYNAMIC) */
 
 #define cond_resched() ({			\
-	___might_sleep(__FILE__, __LINE__, 0);	\
+	__might_resched(__FILE__, __LINE__, 0);	\
 	_cond_resched();			\
 })
 
@@ -2046,9 +2046,9 @@ extern int __cond_resched_lock(spinlock_t *lock);
 extern int __cond_resched_rwlock_read(rwlock_t *lock);
 extern int __cond_resched_rwlock_write(rwlock_t *lock);
 
-#define cond_resched_lock(lock) ({				\
-	___might_sleep(__FILE__, __LINE__, PREEMPT_LOCK_OFFSET);\
-	__cond_resched_lock(lock);				\
+#define cond_resched_lock(lock) ({					\
+	__might_resched(__FILE__, __LINE__, PREEMPT_LOCK_OFFSET);	\
+	__cond_resched_lock(lock);					\
 })
 
 #define cond_resched_rwlock_read(lock) ({			\
diff --git a/kernel/locking/spinlock_rt.c b/kernel/locking/spinlock_rt.c
index d2912e4..c528924 100644
--- a/kernel/locking/spinlock_rt.c
+++ b/kernel/locking/spinlock_rt.c
@@ -32,7 +32,7 @@ static __always_inline void rtlock_lock(struct rt_mutex_base *rtm)
 
 static __always_inline void __rt_spin_lock(spinlock_t *lock)
 {
-	___might_sleep(__FILE__, __LINE__, 0);
+	__might_resched(__FILE__, __LINE__, 0);
 	rtlock_lock(&lock->lock);
 	rcu_read_lock();
 	migrate_disable();
@@ -210,7 +210,7 @@ EXPORT_SYMBOL(rt_write_trylock);
 
 void __sched rt_read_lock(rwlock_t *rwlock)
 {
-	___might_sleep(__FILE__, __LINE__, 0);
+	__might_resched(__FILE__, __LINE__, 0);
 	rwlock_acquire_read(&rwlock->dep_map, 0, 0, _RET_IP_);
 	rwbase_read_lock(&rwlock->rwbase, TASK_RTLOCK_WAIT);
 	rcu_read_lock();
@@ -220,7 +220,7 @@ EXPORT_SYMBOL(rt_read_lock);
 
 void __sched rt_write_lock(rwlock_t *rwlock)
 {
-	___might_sleep(__FILE__, __LINE__, 0);
+	__might_resched(__FILE__, __LINE__, 0);
 	rwlock_acquire(&rwlock->dep_map, 0, 0, _RET_IP_);
 	rwbase_write_lock(&rwlock->rwbase, TASK_RTLOCK_WAIT);
 	rcu_read_lock();
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 1bba412..c3943aa 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -9489,11 +9489,11 @@ void __might_sleep(const char *file, int line, int preempt_offset)
 			(void *)current->task_state_change,
 			(void *)current->task_state_change);
 
-	___might_sleep(file, line, preempt_offset);
+	__might_resched(file, line, preempt_offset);
 }
 EXPORT_SYMBOL(__might_sleep);
 
-void ___might_sleep(const char *file, int line, int preempt_offset)
+void __might_resched(const char *file, int line, int preempt_offset)
 {
 	/* Ratelimiting timestamp: */
 	static unsigned long prev_jiffy;
@@ -9538,7 +9538,7 @@ void ___might_sleep(const char *file, int line, int preempt_offset)
 	dump_stack();
 	add_taint(TAINT_WARN, LOCKDEP_STILL_OK);
 }
-EXPORT_SYMBOL(___might_sleep);
+EXPORT_SYMBOL(__might_resched);
 
 void __cant_sleep(const char *file, int line, int preempt_offset)
 {
