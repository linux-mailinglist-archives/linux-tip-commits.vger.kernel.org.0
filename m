Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6760041F059
	for <lists+linux-tip-commits@lfdr.de>; Fri,  1 Oct 2021 17:05:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354653AbhJAPHP (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 1 Oct 2021 11:07:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354804AbhJAPHO (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 1 Oct 2021 11:07:14 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6525EC061775;
        Fri,  1 Oct 2021 08:05:30 -0700 (PDT)
Date:   Fri, 01 Oct 2021 15:05:28 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1633100729;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ja8FtNNXbh6T3vR8rdWqjwDlsJLN83kRvxCEXyoq7Qw=;
        b=bxjU6aJAaROQ7NU3rtad4qQiwceaLiilrM48T+ONqbg4ibfziGWRZGE/J+62O2jr+QxSLz
        ZbxB3Fz/FZv43tWybftuLG/NY1ZgkVDJVv/Z1mxvmWjkFCdwTMQnxWSg+KCCYMG3Z6N+Sa
        uoVvBUm+j5LmknGHUGqxKlswHFaks3tTJPMHaeVq0sphfcpOCzPsmdXYaRutX0SXoJ70fX
        Y+6Na53KbyJ+T7usI99JHrn4+nHug47hExmJp5mvqg7SQUMYEbuwhJgOisR0Gm3CrrDS7w
        HR5qpRa6hXtu3ylBQmIJbOyK8nQ+qo3X90ki5lA/IG1IWCEHTR9LHOe9ZAc1CA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1633100729;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ja8FtNNXbh6T3vR8rdWqjwDlsJLN83kRvxCEXyoq7Qw=;
        b=LbL9bCXD4xPos0exn74mr35Q4M+HxYJlVQcJpBzTKSXny/dPDTYmJ+Ry/gopTX+x+3FetT
        Fy95rTzj6SgPQ7Aw==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] locking/rt: Take RCU nesting into account for
 __might_resched()
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210923165358.368305497@linutronix.de>
References: <20210923165358.368305497@linutronix.de>
MIME-Version: 1.0
Message-ID: <163310072816.25758.17410900485953082527.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     ef1f4804b27a54da34de6984d16f1fe8f2cc7011
Gitweb:        https://git.kernel.org/tip/ef1f4804b27a54da34de6984d16f1fe8f2cc7011
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Thu, 23 Sep 2021 18:54:46 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 01 Oct 2021 13:57:51 +02:00

locking/rt: Take RCU nesting into account for __might_resched()

The general rule that rcu_read_lock() held sections cannot voluntary sleep
does apply even on RT kernels. Though the substitution of spin/rw locks on
RT enabled kernels has to be exempt from that rule. On !RT a spin_lock()
can obviously nest inside a RCU read side critical section as the lock
acquisition is not going to block, but on RT this is not longer the case
due to the 'sleeping' spinlock substitution.

The RT patches contained a cheap hack to ignore the RCU nesting depth in
might_sleep() checks, which was a pragmatic but incorrect workaround.

Instead of generally ignoring the RCU nesting depth in __might_sleep() and
__might_resched() checks, pass the rcu_preempt_depth() via the offsets
argument to __might_resched() from spin/read/write_lock() which makes the
checks work correctly even in RCU read side critical sections.

The actual blocking on such a substituted lock within a RCU read side
critical section is already handled correctly in __schedule() by treating
it as a "preemption" of the RCU read side critical section.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20210923165358.368305497@linutronix.de
---
 kernel/locking/spinlock_rt.c | 17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

diff --git a/kernel/locking/spinlock_rt.c b/kernel/locking/spinlock_rt.c
index c528924..b2e553f 100644
--- a/kernel/locking/spinlock_rt.c
+++ b/kernel/locking/spinlock_rt.c
@@ -24,6 +24,17 @@
 #define RT_MUTEX_BUILD_SPINLOCKS
 #include "rtmutex.c"
 
+/*
+ * __might_resched() skips the state check as rtlocks are state
+ * preserving. Take RCU nesting into account as spin/read/write_lock() can
+ * legitimately nest into an RCU read side critical section.
+ */
+#define RTLOCK_RESCHED_OFFSETS						\
+	(rcu_preempt_depth() << MIGHT_RESCHED_RCU_SHIFT)
+
+#define rtlock_might_resched()						\
+	__might_resched(__FILE__, __LINE__, RTLOCK_RESCHED_OFFSETS)
+
 static __always_inline void rtlock_lock(struct rt_mutex_base *rtm)
 {
 	if (unlikely(!rt_mutex_cmpxchg_acquire(rtm, NULL, current)))
@@ -32,7 +43,7 @@ static __always_inline void rtlock_lock(struct rt_mutex_base *rtm)
 
 static __always_inline void __rt_spin_lock(spinlock_t *lock)
 {
-	__might_resched(__FILE__, __LINE__, 0);
+	rtlock_might_resched();
 	rtlock_lock(&lock->lock);
 	rcu_read_lock();
 	migrate_disable();
@@ -210,7 +221,7 @@ EXPORT_SYMBOL(rt_write_trylock);
 
 void __sched rt_read_lock(rwlock_t *rwlock)
 {
-	__might_resched(__FILE__, __LINE__, 0);
+	rtlock_might_resched();
 	rwlock_acquire_read(&rwlock->dep_map, 0, 0, _RET_IP_);
 	rwbase_read_lock(&rwlock->rwbase, TASK_RTLOCK_WAIT);
 	rcu_read_lock();
@@ -220,7 +231,7 @@ EXPORT_SYMBOL(rt_read_lock);
 
 void __sched rt_write_lock(rwlock_t *rwlock)
 {
-	__might_resched(__FILE__, __LINE__, 0);
+	rtlock_might_resched();
 	rwlock_acquire(&rwlock->dep_map, 0, 0, _RET_IP_);
 	rwbase_write_lock(&rwlock->rwbase, TASK_RTLOCK_WAIT);
 	rcu_read_lock();
