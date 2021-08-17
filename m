Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E6C23EF34F
	for <lists+linux-tip-commits@lfdr.de>; Tue, 17 Aug 2021 22:15:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234592AbhHQUO4 (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Tue, 17 Aug 2021 16:14:56 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:34608 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234733AbhHQUOs (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Tue, 17 Aug 2021 16:14:48 -0400
Date:   Tue, 17 Aug 2021 20:14:13 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1629231254;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1FCKCF2ObQBv11Lw5cJfoGd7hJE+7e5OfzvRxcSiph4=;
        b=TKJ7+ffOmc50H9olDApPdIo8MzvUiNanTXFsaoI5HpOaKZolcQFi4yRy59eJIT2kuJiXon
        j3X/Df8Nd6qRPjr31PoAyHWkbOCZOJ/hzDRC3KXOMfChhU7webKa9v8E9B4QcWdal51rE9
        nXLmOJk1s/ik/XDPNu0oR9cfU6cWExSK2jaODf+lZ2rkl4seqpkiU2AkVlIbIE3IxcgSDH
        V974Qy+o28romoGR2uEKDZG4FZgKidLH4qzDxNEMl5ygqQneoQkoeU4UJQPdlT9bQ2aNUG
        1ORsCsUXesiqfdf2UE9pdMcX6M0+3/Un4sicIy06ePFbqTvUXafpj3xGLrsDYg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1629231254;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1FCKCF2ObQBv11Lw5cJfoGd7hJE+7e5OfzvRxcSiph4=;
        b=W72r3bCyTG8MB4KCHfadovDFHJFY8FSaAX2VGBOebOd75xed4zOMX34Vvppaf8SFgYsUJ1
        R+u567dTfseK9CCA==
From:   "tip-bot2 for Peter Zijlstra (Intel)" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] locking/ww_mutex: Split out the W/W
 implementation logic into kernel/locking/ww_mutex.h
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210815211304.396893399@linutronix.de>
References: <20210815211304.396893399@linutronix.de>
MIME-Version: 1.0
Message-ID: <162923125344.25758.15883986207611817960.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     2674bd181f3338dc2c58a59caa766dc9d5779784
Gitweb:        https://git.kernel.org/tip/2674bd181f3338dc2c58a59caa766dc9d5779784
Author:        Peter Zijlstra (Intel) <peterz@infradead.org>
AuthorDate:    Tue, 17 Aug 2021 16:31:54 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 17 Aug 2021 19:04:46 +02:00

locking/ww_mutex: Split out the W/W implementation logic into kernel/locking/ww_mutex.h

Split the W/W mutex helper functions out into a separate header file, so
they can be shared with a rtmutex based variant later.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/20210815211304.396893399@linutronix.de
---
 kernel/locking/mutex.c    | 372 +-------------------------------------
 kernel/locking/ww_mutex.h | 369 +++++++++++++++++++++++++++++++++++++-
 2 files changed, 370 insertions(+), 371 deletions(-)
 create mode 100644 kernel/locking/ww_mutex.h

diff --git a/kernel/locking/mutex.c b/kernel/locking/mutex.c
index 070f6f1..9906ca6 100644
--- a/kernel/locking/mutex.c
+++ b/kernel/locking/mutex.c
@@ -281,215 +281,7 @@ void __sched mutex_lock(struct mutex *lock)
 EXPORT_SYMBOL(mutex_lock);
 #endif
 
-/*
- * Wait-Die:
- *   The newer transactions are killed when:
- *     It (the new transaction) makes a request for a lock being held
- *     by an older transaction.
- *
- * Wound-Wait:
- *   The newer transactions are wounded when:
- *     An older transaction makes a request for a lock being held by
- *     the newer transaction.
- */
-
-/*
- * Associate the ww_mutex @ww with the context @ww_ctx under which we acquired
- * it.
- */
-static __always_inline void
-ww_mutex_lock_acquired(struct ww_mutex *ww, struct ww_acquire_ctx *ww_ctx)
-{
-#ifdef CONFIG_DEBUG_MUTEXES
-	/*
-	 * If this WARN_ON triggers, you used ww_mutex_lock to acquire,
-	 * but released with a normal mutex_unlock in this call.
-	 *
-	 * This should never happen, always use ww_mutex_unlock.
-	 */
-	DEBUG_LOCKS_WARN_ON(ww->ctx);
-
-	/*
-	 * Not quite done after calling ww_acquire_done() ?
-	 */
-	DEBUG_LOCKS_WARN_ON(ww_ctx->done_acquire);
-
-	if (ww_ctx->contending_lock) {
-		/*
-		 * After -EDEADLK you tried to
-		 * acquire a different ww_mutex? Bad!
-		 */
-		DEBUG_LOCKS_WARN_ON(ww_ctx->contending_lock != ww);
-
-		/*
-		 * You called ww_mutex_lock after receiving -EDEADLK,
-		 * but 'forgot' to unlock everything else first?
-		 */
-		DEBUG_LOCKS_WARN_ON(ww_ctx->acquired > 0);
-		ww_ctx->contending_lock = NULL;
-	}
-
-	/*
-	 * Naughty, using a different class will lead to undefined behavior!
-	 */
-	DEBUG_LOCKS_WARN_ON(ww_ctx->ww_class != ww->ww_class);
-#endif
-	ww_ctx->acquired++;
-	ww->ctx = ww_ctx;
-}
-
-/*
- * Determine if context @a is 'after' context @b. IOW, @a is a younger
- * transaction than @b and depending on algorithm either needs to wait for
- * @b or die.
- */
-static inline bool __sched
-__ww_ctx_stamp_after(struct ww_acquire_ctx *a, struct ww_acquire_ctx *b)
-{
-
-	return (signed long)(a->stamp - b->stamp) > 0;
-}
-
-/*
- * Wait-Die; wake a younger waiter context (when locks held) such that it can
- * die.
- *
- * Among waiters with context, only the first one can have other locks acquired
- * already (ctx->acquired > 0), because __ww_mutex_add_waiter() and
- * __ww_mutex_check_kill() wake any but the earliest context.
- */
-static bool __sched
-__ww_mutex_die(struct mutex *lock, struct mutex_waiter *waiter,
-	       struct ww_acquire_ctx *ww_ctx)
-{
-	if (!ww_ctx->is_wait_die)
-		return false;
-
-	if (waiter->ww_ctx->acquired > 0 &&
-			__ww_ctx_stamp_after(waiter->ww_ctx, ww_ctx)) {
-		debug_mutex_wake_waiter(lock, waiter);
-		wake_up_process(waiter->task);
-	}
-
-	return true;
-}
-
-/*
- * Wound-Wait; wound a younger @hold_ctx if it holds the lock.
- *
- * Wound the lock holder if there are waiters with older transactions than
- * the lock holders. Even if multiple waiters may wound the lock holder,
- * it's sufficient that only one does.
- */
-static bool __ww_mutex_wound(struct mutex *lock,
-			     struct ww_acquire_ctx *ww_ctx,
-			     struct ww_acquire_ctx *hold_ctx)
-{
-	struct task_struct *owner = __mutex_owner(lock);
-
-	lockdep_assert_held(&lock->wait_lock);
-
-	/*
-	 * Possible through __ww_mutex_add_waiter() when we race with
-	 * ww_mutex_set_context_fastpath(). In that case we'll get here again
-	 * through __ww_mutex_check_waiters().
-	 */
-	if (!hold_ctx)
-		return false;
-
-	/*
-	 * Can have !owner because of __mutex_unlock_slowpath(), but if owner,
-	 * it cannot go away because we'll have FLAG_WAITERS set and hold
-	 * wait_lock.
-	 */
-	if (!owner)
-		return false;
-
-	if (ww_ctx->acquired > 0 && __ww_ctx_stamp_after(hold_ctx, ww_ctx)) {
-		hold_ctx->wounded = 1;
-
-		/*
-		 * wake_up_process() paired with set_current_state()
-		 * inserts sufficient barriers to make sure @owner either sees
-		 * it's wounded in __ww_mutex_check_kill() or has a
-		 * wakeup pending to re-read the wounded state.
-		 */
-		if (owner != current)
-			wake_up_process(owner);
-
-		return true;
-	}
-
-	return false;
-}
-
-/*
- * We just acquired @lock under @ww_ctx, if there are later contexts waiting
- * behind us on the wait-list, check if they need to die, or wound us.
- *
- * See __ww_mutex_add_waiter() for the list-order construction; basically the
- * list is ordered by stamp, smallest (oldest) first.
- *
- * This relies on never mixing wait-die/wound-wait on the same wait-list;
- * which is currently ensured by that being a ww_class property.
- *
- * The current task must not be on the wait list.
- */
-static void __sched
-__ww_mutex_check_waiters(struct mutex *lock, struct ww_acquire_ctx *ww_ctx)
-{
-	struct mutex_waiter *cur;
-
-	lockdep_assert_held(&lock->wait_lock);
-
-	list_for_each_entry(cur, &lock->wait_list, list) {
-		if (!cur->ww_ctx)
-			continue;
-
-		if (__ww_mutex_die(lock, cur, ww_ctx) ||
-		    __ww_mutex_wound(lock, cur->ww_ctx, ww_ctx))
-			break;
-	}
-}
-
-/*
- * After acquiring lock with fastpath, where we do not hold wait_lock, set ctx
- * and wake up any waiters so they can recheck.
- */
-static __always_inline void
-ww_mutex_set_context_fastpath(struct ww_mutex *lock, struct ww_acquire_ctx *ctx)
-{
-	ww_mutex_lock_acquired(lock, ctx);
-
-	/*
-	 * The lock->ctx update should be visible on all cores before
-	 * the WAITERS check is done, otherwise contended waiters might be
-	 * missed. The contended waiters will either see ww_ctx == NULL
-	 * and keep spinning, or it will acquire wait_lock, add itself
-	 * to waiter list and sleep.
-	 */
-	smp_mb(); /* See comments above and below. */
-
-	/*
-	 * [W] ww->ctx = ctx	    [W] MUTEX_FLAG_WAITERS
-	 *     MB		        MB
-	 * [R] MUTEX_FLAG_WAITERS   [R] ww->ctx
-	 *
-	 * The memory barrier above pairs with the memory barrier in
-	 * __ww_mutex_add_waiter() and makes sure we either observe ww->ctx
-	 * and/or !empty list.
-	 */
-	if (likely(!(atomic_long_read(&lock->base.owner) & MUTEX_FLAG_WAITERS)))
-		return;
-
-	/*
-	 * Uh oh, we raced in fastpath, check if any of the waiters need to
-	 * die or wound us.
-	 */
-	raw_spin_lock(&lock->base.wait_lock);
-	__ww_mutex_check_waiters(&lock->base, ctx);
-	raw_spin_unlock(&lock->base.wait_lock);
-}
+#include "ww_mutex.h"
 
 #ifdef CONFIG_MUTEX_SPIN_ON_OWNER
 
@@ -744,20 +536,6 @@ void __sched mutex_unlock(struct mutex *lock)
 }
 EXPORT_SYMBOL(mutex_unlock);
 
-static void __ww_mutex_unlock(struct ww_mutex *lock)
-{
-	/*
-	 * The unlocking fastpath is the 0->1 transition from 'locked'
-	 * into 'unlocked' state:
-	 */
-	if (lock->ctx) {
-		MUTEX_WARN_ON(!lock->ctx->acquired);
-		if (lock->ctx->acquired > 0)
-			lock->ctx->acquired--;
-		lock->ctx = NULL;
-	}
-}
-
 /**
  * ww_mutex_unlock - release the w/w mutex
  * @lock: the mutex to be released
@@ -776,154 +554,6 @@ void __sched ww_mutex_unlock(struct ww_mutex *lock)
 }
 EXPORT_SYMBOL(ww_mutex_unlock);
 
-
-static __always_inline int __sched
-__ww_mutex_kill(struct mutex *lock, struct ww_acquire_ctx *ww_ctx)
-{
-	if (ww_ctx->acquired > 0) {
-#ifdef CONFIG_DEBUG_MUTEXES
-		struct ww_mutex *ww;
-
-		ww = container_of(lock, struct ww_mutex, base);
-		DEBUG_LOCKS_WARN_ON(ww_ctx->contending_lock);
-		ww_ctx->contending_lock = ww;
-#endif
-		return -EDEADLK;
-	}
-
-	return 0;
-}
-
-
-/*
- * Check the wound condition for the current lock acquire.
- *
- * Wound-Wait: If we're wounded, kill ourself.
- *
- * Wait-Die: If we're trying to acquire a lock already held by an older
- *           context, kill ourselves.
- *
- * Since __ww_mutex_add_waiter() orders the wait-list on stamp, we only have to
- * look at waiters before us in the wait-list.
- */
-static inline int __sched
-__ww_mutex_check_kill(struct mutex *lock, struct mutex_waiter *waiter,
-		      struct ww_acquire_ctx *ctx)
-{
-	struct ww_mutex *ww = container_of(lock, struct ww_mutex, base);
-	struct ww_acquire_ctx *hold_ctx = READ_ONCE(ww->ctx);
-	struct mutex_waiter *cur;
-
-	if (ctx->acquired == 0)
-		return 0;
-
-	if (!ctx->is_wait_die) {
-		if (ctx->wounded)
-			return __ww_mutex_kill(lock, ctx);
-
-		return 0;
-	}
-
-	if (hold_ctx && __ww_ctx_stamp_after(ctx, hold_ctx))
-		return __ww_mutex_kill(lock, ctx);
-
-	/*
-	 * If there is a waiter in front of us that has a context, then its
-	 * stamp is earlier than ours and we must kill ourself.
-	 */
-	cur = waiter;
-	list_for_each_entry_continue_reverse(cur, &lock->wait_list, list) {
-		if (!cur->ww_ctx)
-			continue;
-
-		return __ww_mutex_kill(lock, ctx);
-	}
-
-	return 0;
-}
-
-/*
- * Add @waiter to the wait-list, keep the wait-list ordered by stamp, smallest
- * first. Such that older contexts are preferred to acquire the lock over
- * younger contexts.
- *
- * Waiters without context are interspersed in FIFO order.
- *
- * Furthermore, for Wait-Die kill ourself immediately when possible (there are
- * older contexts already waiting) to avoid unnecessary waiting and for
- * Wound-Wait ensure we wound the owning context when it is younger.
- */
-static inline int __sched
-__ww_mutex_add_waiter(struct mutex_waiter *waiter,
-		      struct mutex *lock,
-		      struct ww_acquire_ctx *ww_ctx)
-{
-	struct mutex_waiter *cur;
-	struct list_head *pos;
-	bool is_wait_die;
-
-	if (!ww_ctx) {
-		__mutex_add_waiter(lock, waiter, &lock->wait_list);
-		return 0;
-	}
-
-	is_wait_die = ww_ctx->is_wait_die;
-
-	/*
-	 * Add the waiter before the first waiter with a higher stamp.
-	 * Waiters without a context are skipped to avoid starving
-	 * them. Wait-Die waiters may die here. Wound-Wait waiters
-	 * never die here, but they are sorted in stamp order and
-	 * may wound the lock holder.
-	 */
-	pos = &lock->wait_list;
-	list_for_each_entry_reverse(cur, &lock->wait_list, list) {
-		if (!cur->ww_ctx)
-			continue;
-
-		if (__ww_ctx_stamp_after(ww_ctx, cur->ww_ctx)) {
-			/*
-			 * Wait-Die: if we find an older context waiting, there
-			 * is no point in queueing behind it, as we'd have to
-			 * die the moment it would acquire the lock.
-			 */
-			if (is_wait_die) {
-				int ret = __ww_mutex_kill(lock, ww_ctx);
-
-				if (ret)
-					return ret;
-			}
-
-			break;
-		}
-
-		pos = &cur->list;
-
-		/* Wait-Die: ensure younger waiters die. */
-		__ww_mutex_die(lock, cur, ww_ctx);
-	}
-
-	__mutex_add_waiter(lock, waiter, pos);
-
-	/*
-	 * Wound-Wait: if we're blocking on a mutex owned by a younger context,
-	 * wound that such that we might proceed.
-	 */
-	if (!is_wait_die) {
-		struct ww_mutex *ww = container_of(lock, struct ww_mutex, base);
-
-		/*
-		 * See ww_mutex_set_context_fastpath(). Orders setting
-		 * MUTEX_FLAG_WAITERS vs the ww->ctx load,
-		 * such that either we or the fastpath will wound @ww->ctx.
-		 */
-		smp_mb();
-		__ww_mutex_wound(lock, ww_ctx, ww->ctx);
-	}
-
-	return 0;
-}
-
 /*
  * Lock a mutex (possibly interruptible), slowpath:
  */
diff --git a/kernel/locking/ww_mutex.h b/kernel/locking/ww_mutex.h
new file mode 100644
index 0000000..dadc798
--- /dev/null
+++ b/kernel/locking/ww_mutex.h
@@ -0,0 +1,369 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+
+/*
+ * Wait-Die:
+ *   The newer transactions are killed when:
+ *     It (the new transaction) makes a request for a lock being held
+ *     by an older transaction.
+ *
+ * Wound-Wait:
+ *   The newer transactions are wounded when:
+ *     An older transaction makes a request for a lock being held by
+ *     the newer transaction.
+ */
+
+/*
+ * Associate the ww_mutex @ww with the context @ww_ctx under which we acquired
+ * it.
+ */
+static __always_inline void
+ww_mutex_lock_acquired(struct ww_mutex *ww, struct ww_acquire_ctx *ww_ctx)
+{
+#ifdef CONFIG_DEBUG_MUTEXES
+	/*
+	 * If this WARN_ON triggers, you used ww_mutex_lock to acquire,
+	 * but released with a normal mutex_unlock in this call.
+	 *
+	 * This should never happen, always use ww_mutex_unlock.
+	 */
+	DEBUG_LOCKS_WARN_ON(ww->ctx);
+
+	/*
+	 * Not quite done after calling ww_acquire_done() ?
+	 */
+	DEBUG_LOCKS_WARN_ON(ww_ctx->done_acquire);
+
+	if (ww_ctx->contending_lock) {
+		/*
+		 * After -EDEADLK you tried to
+		 * acquire a different ww_mutex? Bad!
+		 */
+		DEBUG_LOCKS_WARN_ON(ww_ctx->contending_lock != ww);
+
+		/*
+		 * You called ww_mutex_lock after receiving -EDEADLK,
+		 * but 'forgot' to unlock everything else first?
+		 */
+		DEBUG_LOCKS_WARN_ON(ww_ctx->acquired > 0);
+		ww_ctx->contending_lock = NULL;
+	}
+
+	/*
+	 * Naughty, using a different class will lead to undefined behavior!
+	 */
+	DEBUG_LOCKS_WARN_ON(ww_ctx->ww_class != ww->ww_class);
+#endif
+	ww_ctx->acquired++;
+	ww->ctx = ww_ctx;
+}
+
+/*
+ * Determine if context @a is 'after' context @b. IOW, @a is a younger
+ * transaction than @b and depending on algorithm either needs to wait for
+ * @b or die.
+ */
+static inline bool __sched
+__ww_ctx_stamp_after(struct ww_acquire_ctx *a, struct ww_acquire_ctx *b)
+{
+
+	return (signed long)(a->stamp - b->stamp) > 0;
+}
+
+/*
+ * Wait-Die; wake a younger waiter context (when locks held) such that it can
+ * die.
+ *
+ * Among waiters with context, only the first one can have other locks acquired
+ * already (ctx->acquired > 0), because __ww_mutex_add_waiter() and
+ * __ww_mutex_check_kill() wake any but the earliest context.
+ */
+static bool __sched
+__ww_mutex_die(struct mutex *lock, struct mutex_waiter *waiter,
+	       struct ww_acquire_ctx *ww_ctx)
+{
+	if (!ww_ctx->is_wait_die)
+		return false;
+
+	if (waiter->ww_ctx->acquired > 0 &&
+			__ww_ctx_stamp_after(waiter->ww_ctx, ww_ctx)) {
+		debug_mutex_wake_waiter(lock, waiter);
+		wake_up_process(waiter->task);
+	}
+
+	return true;
+}
+
+/*
+ * Wound-Wait; wound a younger @hold_ctx if it holds the lock.
+ *
+ * Wound the lock holder if there are waiters with older transactions than
+ * the lock holders. Even if multiple waiters may wound the lock holder,
+ * it's sufficient that only one does.
+ */
+static bool __ww_mutex_wound(struct mutex *lock,
+			     struct ww_acquire_ctx *ww_ctx,
+			     struct ww_acquire_ctx *hold_ctx)
+{
+	struct task_struct *owner = __mutex_owner(lock);
+
+	lockdep_assert_held(&lock->wait_lock);
+
+	/*
+	 * Possible through __ww_mutex_add_waiter() when we race with
+	 * ww_mutex_set_context_fastpath(). In that case we'll get here again
+	 * through __ww_mutex_check_waiters().
+	 */
+	if (!hold_ctx)
+		return false;
+
+	/*
+	 * Can have !owner because of __mutex_unlock_slowpath(), but if owner,
+	 * it cannot go away because we'll have FLAG_WAITERS set and hold
+	 * wait_lock.
+	 */
+	if (!owner)
+		return false;
+
+	if (ww_ctx->acquired > 0 && __ww_ctx_stamp_after(hold_ctx, ww_ctx)) {
+		hold_ctx->wounded = 1;
+
+		/*
+		 * wake_up_process() paired with set_current_state()
+		 * inserts sufficient barriers to make sure @owner either sees
+		 * it's wounded in __ww_mutex_check_kill() or has a
+		 * wakeup pending to re-read the wounded state.
+		 */
+		if (owner != current)
+			wake_up_process(owner);
+
+		return true;
+	}
+
+	return false;
+}
+
+/*
+ * We just acquired @lock under @ww_ctx, if there are later contexts waiting
+ * behind us on the wait-list, check if they need to die, or wound us.
+ *
+ * See __ww_mutex_add_waiter() for the list-order construction; basically the
+ * list is ordered by stamp, smallest (oldest) first.
+ *
+ * This relies on never mixing wait-die/wound-wait on the same wait-list;
+ * which is currently ensured by that being a ww_class property.
+ *
+ * The current task must not be on the wait list.
+ */
+static void __sched
+__ww_mutex_check_waiters(struct mutex *lock, struct ww_acquire_ctx *ww_ctx)
+{
+	struct mutex_waiter *cur;
+
+	lockdep_assert_held(&lock->wait_lock);
+
+	list_for_each_entry(cur, &lock->wait_list, list) {
+		if (!cur->ww_ctx)
+			continue;
+
+		if (__ww_mutex_die(lock, cur, ww_ctx) ||
+		    __ww_mutex_wound(lock, cur->ww_ctx, ww_ctx))
+			break;
+	}
+}
+
+/*
+ * After acquiring lock with fastpath, where we do not hold wait_lock, set ctx
+ * and wake up any waiters so they can recheck.
+ */
+static __always_inline void
+ww_mutex_set_context_fastpath(struct ww_mutex *lock, struct ww_acquire_ctx *ctx)
+{
+	ww_mutex_lock_acquired(lock, ctx);
+
+	/*
+	 * The lock->ctx update should be visible on all cores before
+	 * the WAITERS check is done, otherwise contended waiters might be
+	 * missed. The contended waiters will either see ww_ctx == NULL
+	 * and keep spinning, or it will acquire wait_lock, add itself
+	 * to waiter list and sleep.
+	 */
+	smp_mb(); /* See comments above and below. */
+
+	/*
+	 * [W] ww->ctx = ctx	    [W] MUTEX_FLAG_WAITERS
+	 *     MB		        MB
+	 * [R] MUTEX_FLAG_WAITERS   [R] ww->ctx
+	 *
+	 * The memory barrier above pairs with the memory barrier in
+	 * __ww_mutex_add_waiter() and makes sure we either observe ww->ctx
+	 * and/or !empty list.
+	 */
+	if (likely(!(atomic_long_read(&lock->base.owner) & MUTEX_FLAG_WAITERS)))
+		return;
+
+	/*
+	 * Uh oh, we raced in fastpath, check if any of the waiters need to
+	 * die or wound us.
+	 */
+	raw_spin_lock(&lock->base.wait_lock);
+	__ww_mutex_check_waiters(&lock->base, ctx);
+	raw_spin_unlock(&lock->base.wait_lock);
+}
+
+static __always_inline int __sched
+__ww_mutex_kill(struct mutex *lock, struct ww_acquire_ctx *ww_ctx)
+{
+	if (ww_ctx->acquired > 0) {
+#ifdef CONFIG_DEBUG_MUTEXES
+		struct ww_mutex *ww;
+
+		ww = container_of(lock, struct ww_mutex, base);
+		DEBUG_LOCKS_WARN_ON(ww_ctx->contending_lock);
+		ww_ctx->contending_lock = ww;
+#endif
+		return -EDEADLK;
+	}
+
+	return 0;
+}
+
+/*
+ * Check the wound condition for the current lock acquire.
+ *
+ * Wound-Wait: If we're wounded, kill ourself.
+ *
+ * Wait-Die: If we're trying to acquire a lock already held by an older
+ *           context, kill ourselves.
+ *
+ * Since __ww_mutex_add_waiter() orders the wait-list on stamp, we only have to
+ * look at waiters before us in the wait-list.
+ */
+static inline int __sched
+__ww_mutex_check_kill(struct mutex *lock, struct mutex_waiter *waiter,
+		      struct ww_acquire_ctx *ctx)
+{
+	struct ww_mutex *ww = container_of(lock, struct ww_mutex, base);
+	struct ww_acquire_ctx *hold_ctx = READ_ONCE(ww->ctx);
+	struct mutex_waiter *cur;
+
+	if (ctx->acquired == 0)
+		return 0;
+
+	if (!ctx->is_wait_die) {
+		if (ctx->wounded)
+			return __ww_mutex_kill(lock, ctx);
+
+		return 0;
+	}
+
+	if (hold_ctx && __ww_ctx_stamp_after(ctx, hold_ctx))
+		return __ww_mutex_kill(lock, ctx);
+
+	/*
+	 * If there is a waiter in front of us that has a context, then its
+	 * stamp is earlier than ours and we must kill ourself.
+	 */
+	cur = waiter;
+	list_for_each_entry_continue_reverse(cur, &lock->wait_list, list) {
+		if (!cur->ww_ctx)
+			continue;
+
+		return __ww_mutex_kill(lock, ctx);
+	}
+
+	return 0;
+}
+
+/*
+ * Add @waiter to the wait-list, keep the wait-list ordered by stamp, smallest
+ * first. Such that older contexts are preferred to acquire the lock over
+ * younger contexts.
+ *
+ * Waiters without context are interspersed in FIFO order.
+ *
+ * Furthermore, for Wait-Die kill ourself immediately when possible (there are
+ * older contexts already waiting) to avoid unnecessary waiting and for
+ * Wound-Wait ensure we wound the owning context when it is younger.
+ */
+static inline int __sched
+__ww_mutex_add_waiter(struct mutex_waiter *waiter,
+		      struct mutex *lock,
+		      struct ww_acquire_ctx *ww_ctx)
+{
+	struct mutex_waiter *cur;
+	struct list_head *pos;
+	bool is_wait_die;
+
+	if (!ww_ctx) {
+		__mutex_add_waiter(lock, waiter, &lock->wait_list);
+		return 0;
+	}
+
+	is_wait_die = ww_ctx->is_wait_die;
+
+	/*
+	 * Add the waiter before the first waiter with a higher stamp.
+	 * Waiters without a context are skipped to avoid starving
+	 * them. Wait-Die waiters may die here. Wound-Wait waiters
+	 * never die here, but they are sorted in stamp order and
+	 * may wound the lock holder.
+	 */
+	pos = &lock->wait_list;
+	list_for_each_entry_reverse(cur, &lock->wait_list, list) {
+		if (!cur->ww_ctx)
+			continue;
+
+		if (__ww_ctx_stamp_after(ww_ctx, cur->ww_ctx)) {
+			/*
+			 * Wait-Die: if we find an older context waiting, there
+			 * is no point in queueing behind it, as we'd have to
+			 * die the moment it would acquire the lock.
+			 */
+			if (is_wait_die) {
+				int ret = __ww_mutex_kill(lock, ww_ctx);
+
+				if (ret)
+					return ret;
+			}
+
+			break;
+		}
+
+		pos = &cur->list;
+
+		/* Wait-Die: ensure younger waiters die. */
+		__ww_mutex_die(lock, cur, ww_ctx);
+	}
+
+	__mutex_add_waiter(lock, waiter, pos);
+
+	/*
+	 * Wound-Wait: if we're blocking on a mutex owned by a younger context,
+	 * wound that such that we might proceed.
+	 */
+	if (!is_wait_die) {
+		struct ww_mutex *ww = container_of(lock, struct ww_mutex, base);
+
+		/*
+		 * See ww_mutex_set_context_fastpath(). Orders setting
+		 * MUTEX_FLAG_WAITERS vs the ww->ctx load,
+		 * such that either we or the fastpath will wound @ww->ctx.
+		 */
+		smp_mb();
+		__ww_mutex_wound(lock, ww_ctx, ww->ctx);
+	}
+
+	return 0;
+}
+
+static inline void __ww_mutex_unlock(struct ww_mutex *lock)
+{
+	if (lock->ctx) {
+#ifdef CONFIG_DEBUG_MUTEXES
+		DEBUG_LOCKS_WARN_ON(!lock->ctx->acquired);
+#endif
+		if (lock->ctx->acquired > 0)
+			lock->ctx->acquired--;
+		lock->ctx = NULL;
+	}
+}
