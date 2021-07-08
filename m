Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E1043BF6FA
	for <lists+linux-tip-commits@lfdr.de>; Thu,  8 Jul 2021 10:42:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231258AbhGHIpU (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Thu, 8 Jul 2021 04:45:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231173AbhGHIpS (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Thu, 8 Jul 2021 04:45:18 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AA76C061574;
        Thu,  8 Jul 2021 01:42:37 -0700 (PDT)
Date:   Thu, 08 Jul 2021 08:42:34 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1625733755;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rU9QGQWZYfyAHMc3d+GKV9s6jrbfbu1BZTpeCF9esK4=;
        b=NcrTq3i5NnaCyXWkiQ0UEtCSY2RTnEYwToSFjGDmdDYuVE/l9Fx7ewwpcjw22iH29XrtBW
        9sbdqAPnxZSALqs2eKeTtPFjfoe+DCqlY/3XfY3uLrm8dqm2blaKu2Ifg9OkWa4l3+kEE2
        HuFmjoRjVV5KjpK5DrvCd7FiUsIRqFV6b3LVehbCBjj7pyeQJr+TYQZgMjrBTy8ZBxTx4V
        PjyywzLSPmSKihzcpDqYp4TRvPKKmSgCvEi4UVKdcMx0+x88s1ruyzccVIbVO+cVnpzqie
        jMK8NVykGItK9KKLx+l/GCumRhMj5kJgpsXCzsJf1kDQnsfud2i7+TBhwI3jig==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1625733755;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rU9QGQWZYfyAHMc3d+GKV9s6jrbfbu1BZTpeCF9esK4=;
        b=Rtu6yoMtAmGK3oous6+DFOQluTXH9JFSOJjRKzkkWURPipLksxHZrz71dbJV0O1zWu2qN8
        eKeeNOp0oyrXq9BQ==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] locking/mutex: Introduce __mutex_trylock_or_handoff()
Cc:     Yanfei Xu <yanfei.xu@windriver.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Waiman Long <longman@redhat.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210630154114.958507900@infradead.org>
References: <20210630154114.958507900@infradead.org>
MIME-Version: 1.0
Message-ID: <162573375491.395.6302178178874054170.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     ad90880dc9625682a58897cba2ecff657a2aa60b
Gitweb:        https://git.kernel.org/tip/ad90880dc9625682a58897cba2ecff657a2aa60b
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Wed, 30 Jun 2021 17:35:19 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 07 Jul 2021 13:53:25 +02:00

locking/mutex: Introduce __mutex_trylock_or_handoff()

Yanfei reported that it is possible to loose HANDOFF when we race with
mutex_unlock() and end up setting HANDOFF on an unlocked mutex. At
that point anybody can steal it, losing HANDOFF in the process.

If this happens often enough, we can in fact starve the top waiter.

Solve this by folding the 'set HANDOFF' operation into the trylock
operation, such that either we acquire the lock, or it gets HANDOFF
set. This avoids having HANDOFF set on an unlocked mutex.

Reported-by: Yanfei Xu <yanfei.xu@windriver.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Waiman Long <longman@redhat.com>
Reviewed-by: Yanfei Xu <yanfei.xu@windriver.com>
Link: https://lore.kernel.org/r/20210630154114.958507900@infradead.org
---
 kernel/locking/mutex.c | 60 ++++++++++++++++++++++++-----------------
 1 file changed, 36 insertions(+), 24 deletions(-)

diff --git a/kernel/locking/mutex.c b/kernel/locking/mutex.c
index 8c3d499..b81ec97 100644
--- a/kernel/locking/mutex.c
+++ b/kernel/locking/mutex.c
@@ -91,10 +91,7 @@ static inline unsigned long __owner_flags(unsigned long owner)
 	return owner & MUTEX_FLAGS;
 }
 
-/*
- * Trylock variant that returns the owning task on failure.
- */
-static inline struct task_struct *__mutex_trylock_or_owner(struct mutex *lock)
+static inline struct task_struct *__mutex_trylock_common(struct mutex *lock, bool handoff)
 {
 	unsigned long owner, curr = (unsigned long)current;
 
@@ -104,39 +101,48 @@ static inline struct task_struct *__mutex_trylock_or_owner(struct mutex *lock)
 		unsigned long task = owner & ~MUTEX_FLAGS;
 
 		if (task) {
-			if (likely(task != curr))
+			if (flags & MUTEX_FLAG_PICKUP) {
+				if (task != curr)
+					break;
+				flags &= ~MUTEX_FLAG_PICKUP;
+			} else if (handoff) {
+				if (flags & MUTEX_FLAG_HANDOFF)
+					break;
+				flags |= MUTEX_FLAG_HANDOFF;
+			} else {
 				break;
-
-			if (likely(!(flags & MUTEX_FLAG_PICKUP)))
-				break;
-
-			flags &= ~MUTEX_FLAG_PICKUP;
+			}
 		} else {
 #ifdef CONFIG_DEBUG_MUTEXES
-			DEBUG_LOCKS_WARN_ON(flags & MUTEX_FLAG_PICKUP);
+			DEBUG_LOCKS_WARN_ON(flags & (MUTEX_FLAG_HANDOFF | MUTEX_FLAG_PICKUP));
 #endif
+			task = curr;
 		}
 
-		/*
-		 * We set the HANDOFF bit, we must make sure it doesn't live
-		 * past the point where we acquire it. This would be possible
-		 * if we (accidentally) set the bit on an unlocked mutex.
-		 */
-		flags &= ~MUTEX_FLAG_HANDOFF;
-
-		if (atomic_long_try_cmpxchg_acquire(&lock->owner, &owner, curr | flags))
-			return NULL;
+		if (atomic_long_try_cmpxchg_acquire(&lock->owner, &owner, task | flags)) {
+			if (task == curr)
+				return NULL;
+			break;
+		}
 	}
 
 	return __owner_task(owner);
 }
 
 /*
+ * Trylock or set HANDOFF
+ */
+static inline bool __mutex_trylock_or_handoff(struct mutex *lock, bool handoff)
+{
+	return !__mutex_trylock_common(lock, handoff);
+}
+
+/*
  * Actual trylock that will work on any unlocked state.
  */
 static inline bool __mutex_trylock(struct mutex *lock)
 {
-	return !__mutex_trylock_or_owner(lock);
+	return !__mutex_trylock_common(lock, false);
 }
 
 #ifndef CONFIG_DEBUG_LOCK_ALLOC
@@ -479,6 +485,14 @@ ww_mutex_set_context_fastpath(struct ww_mutex *lock, struct ww_acquire_ctx *ctx)
 
 #ifdef CONFIG_MUTEX_SPIN_ON_OWNER
 
+/*
+ * Trylock variant that returns the owning task on failure.
+ */
+static inline struct task_struct *__mutex_trylock_or_owner(struct mutex *lock)
+{
+	return __mutex_trylock_common(lock, false);
+}
+
 static inline
 bool ww_mutex_spin_on_owner(struct mutex *lock, struct ww_acquire_ctx *ww_ctx,
 			    struct mutex_waiter *waiter)
@@ -1018,8 +1032,6 @@ __mutex_lock_common(struct mutex *lock, long state, unsigned int subclass,
 		schedule_preempt_disabled();
 
 		first = __mutex_waiter_is_first(lock, &waiter);
-		if (first)
-			__mutex_set_flag(lock, MUTEX_FLAG_HANDOFF);
 
 		set_current_state(state);
 		/*
@@ -1027,7 +1039,7 @@ __mutex_lock_common(struct mutex *lock, long state, unsigned int subclass,
 		 * state back to RUNNING and fall through the next schedule(),
 		 * or we must see its unlock and acquire.
 		 */
-		if (__mutex_trylock(lock) ||
+		if (__mutex_trylock_or_handoff(lock, first) ||
 		    (first && mutex_optimistic_spin(lock, ww_ctx, &waiter)))
 			break;
 
