Return-Path: <linux-tip-commits+bounces-5482-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CB5A0AAF809
	for <lists+linux-tip-commits@lfdr.de>; Thu,  8 May 2025 12:37:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9520F16E755
	for <lists+linux-tip-commits@lfdr.de>; Thu,  8 May 2025 10:37:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68EC822E3FD;
	Thu,  8 May 2025 10:34:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="mEwgNGzf";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="TN84fvWn"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0954822B8B0;
	Thu,  8 May 2025 10:34:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746700443; cv=none; b=macjrIcrdog+zRFQLgYyCyf8fPCDX+d1A5CWSzPQDdPk3BiEHAA5Q7YG5y+wWBdN7Z2T0CsJAa4tcfTl2FtBN/TToGzEk9Ww5tFp4NtK/Uz0lN13K5t1xuQIcZQ7rB1YGPvLDlzw3VqUOrSHIqjdMx7mscvp+GsFTuHt3C8bk2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746700443; c=relaxed/simple;
	bh=UTXD7XODGJ00TCPtslmszCWgtarLYVlFUaR9UVRy1x8=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=u4uR7gkhfXRhYfUgodyFzzpcaMnFcBgyds7pt7gC/dQ5FTooQmy5AP/vITcx75g6c2AHrneERDMruD7xqSYDdRV7aTO1dXCPwbV95JYKj9UkYK2LHM0/bOqOR+7u6/jAvBAA3O4fKhigDex+8lDZn52Lkm+R1CSZK3RMp5y1SBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=mEwgNGzf; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=TN84fvWn; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 08 May 2025 10:33:57 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1746700438;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Dk9ScZ39u4/mFGggF5rjMdjtCNxTqQ52UHz0FqDdDCc=;
	b=mEwgNGzfHkTB+kEOffJXQrDJJXGhzKYvzcevnS/evRwj50MzP+LQKr9YC6CCOtPHuh4ki1
	3hhzBVoLQ/2gooCQktMiFoNA85Sv8YpJLxTdGI8BHWM4/MxJ3VF3h6NJt52A0kR/2LXtTV
	/1DAYaUvmTOlNb9RcgUxxlXqYUIYf+SirxhhcPH+ttzCPNQQ2nTjTR3J06U6dVmvokq8hi
	z0XxftByoNzxU44RqYwxeL3AuZU565MA54LMAvQ5hQw4Yx5WMxtDvoSDFk9JpHljLPfCjk
	4x9TmKxEE0BnsguJ6+eqhK+LQ7wY7xuK8A9KZS1d4q5rQYSqqhV/hAyRtx+/Jw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1746700438;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Dk9ScZ39u4/mFGggF5rjMdjtCNxTqQ52UHz0FqDdDCc=;
	b=TN84fvWnVvQkF31D2V6qHcyHQ97slFZHFYxonXuGEgWuxP59jgAu0g1Fup+RvYWf2FKMiG
	VlLebnOeNXnBWHCg==
From: "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: locking/futex] futex: Create hb scopes
Cc: "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250416162921.513656-6-bigeasy@linutronix.de>
References: <20250416162921.513656-6-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174670043772.406.16223347270167826927.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the locking/futex branch of tip:

Commit-ID:     8486d12f558ff9e4e90331e8ef841d84bf3a8c24
Gitweb:        https://git.kernel.org/tip/8486d12f558ff9e4e90331e8ef841d84bf3a8c24
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Wed, 16 Apr 2025 18:29:05 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Sat, 03 May 2025 12:02:05 +02:00

futex: Create hb scopes

Create explicit scopes for hb variables; almost pure re-indent.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/r/20250416162921.513656-6-bigeasy@linutronix.de
---
 kernel/futex/core.c     |  83 ++++----
 kernel/futex/pi.c       | 282 +++++++++++++--------------
 kernel/futex/requeue.c  | 413 +++++++++++++++++++--------------------
 kernel/futex/waitwake.c | 189 +++++++++---------
 4 files changed, 493 insertions(+), 474 deletions(-)

diff --git a/kernel/futex/core.c b/kernel/futex/core.c
index 7adc914..e4cb5ce 100644
--- a/kernel/futex/core.c
+++ b/kernel/futex/core.c
@@ -944,7 +944,6 @@ static void exit_pi_state_list(struct task_struct *curr)
 {
 	struct list_head *next, *head = &curr->pi_state_list;
 	struct futex_pi_state *pi_state;
-	struct futex_hash_bucket *hb;
 	union futex_key key = FUTEX_KEY_INIT;
 
 	/*
@@ -957,50 +956,54 @@ static void exit_pi_state_list(struct task_struct *curr)
 		next = head->next;
 		pi_state = list_entry(next, struct futex_pi_state, list);
 		key = pi_state->key;
-		hb = futex_hash(&key);
-
-		/*
-		 * We can race against put_pi_state() removing itself from the
-		 * list (a waiter going away). put_pi_state() will first
-		 * decrement the reference count and then modify the list, so
-		 * its possible to see the list entry but fail this reference
-		 * acquire.
-		 *
-		 * In that case; drop the locks to let put_pi_state() make
-		 * progress and retry the loop.
-		 */
-		if (!refcount_inc_not_zero(&pi_state->refcount)) {
+		if (1) {
+			struct futex_hash_bucket *hb;
+
+			hb = futex_hash(&key);
+
+			/*
+			 * We can race against put_pi_state() removing itself from the
+			 * list (a waiter going away). put_pi_state() will first
+			 * decrement the reference count and then modify the list, so
+			 * its possible to see the list entry but fail this reference
+			 * acquire.
+			 *
+			 * In that case; drop the locks to let put_pi_state() make
+			 * progress and retry the loop.
+			 */
+			if (!refcount_inc_not_zero(&pi_state->refcount)) {
+				raw_spin_unlock_irq(&curr->pi_lock);
+				cpu_relax();
+				raw_spin_lock_irq(&curr->pi_lock);
+				continue;
+			}
 			raw_spin_unlock_irq(&curr->pi_lock);
-			cpu_relax();
-			raw_spin_lock_irq(&curr->pi_lock);
-			continue;
-		}
-		raw_spin_unlock_irq(&curr->pi_lock);
 
-		spin_lock(&hb->lock);
-		raw_spin_lock_irq(&pi_state->pi_mutex.wait_lock);
-		raw_spin_lock(&curr->pi_lock);
-		/*
-		 * We dropped the pi-lock, so re-check whether this
-		 * task still owns the PI-state:
-		 */
-		if (head->next != next) {
-			/* retain curr->pi_lock for the loop invariant */
-			raw_spin_unlock(&pi_state->pi_mutex.wait_lock);
+			spin_lock(&hb->lock);
+			raw_spin_lock_irq(&pi_state->pi_mutex.wait_lock);
+			raw_spin_lock(&curr->pi_lock);
+			/*
+			 * We dropped the pi-lock, so re-check whether this
+			 * task still owns the PI-state:
+			 */
+			if (head->next != next) {
+				/* retain curr->pi_lock for the loop invariant */
+				raw_spin_unlock(&pi_state->pi_mutex.wait_lock);
+				spin_unlock(&hb->lock);
+				put_pi_state(pi_state);
+				continue;
+			}
+
+			WARN_ON(pi_state->owner != curr);
+			WARN_ON(list_empty(&pi_state->list));
+			list_del_init(&pi_state->list);
+			pi_state->owner = NULL;
+
+			raw_spin_unlock(&curr->pi_lock);
+			raw_spin_unlock_irq(&pi_state->pi_mutex.wait_lock);
 			spin_unlock(&hb->lock);
-			put_pi_state(pi_state);
-			continue;
 		}
 
-		WARN_ON(pi_state->owner != curr);
-		WARN_ON(list_empty(&pi_state->list));
-		list_del_init(&pi_state->list);
-		pi_state->owner = NULL;
-
-		raw_spin_unlock(&curr->pi_lock);
-		raw_spin_unlock_irq(&pi_state->pi_mutex.wait_lock);
-		spin_unlock(&hb->lock);
-
 		rt_mutex_futex_unlock(&pi_state->pi_mutex);
 		put_pi_state(pi_state);
 
diff --git a/kernel/futex/pi.c b/kernel/futex/pi.c
index 3bf942e..a56f28f 100644
--- a/kernel/futex/pi.c
+++ b/kernel/futex/pi.c
@@ -920,7 +920,6 @@ int futex_lock_pi(u32 __user *uaddr, unsigned int flags, ktime_t *time, int tryl
 	struct hrtimer_sleeper timeout, *to;
 	struct task_struct *exiting = NULL;
 	struct rt_mutex_waiter rt_waiter;
-	struct futex_hash_bucket *hb;
 	struct futex_q q = futex_q_init;
 	DEFINE_WAKE_Q(wake_q);
 	int res, ret;
@@ -939,152 +938,169 @@ retry:
 		goto out;
 
 retry_private:
-	hb = futex_hash(&q.key);
-	futex_q_lock(&q, hb);
+	if (1) {
+		struct futex_hash_bucket *hb;
 
-	ret = futex_lock_pi_atomic(uaddr, hb, &q.key, &q.pi_state, current,
-				   &exiting, 0);
-	if (unlikely(ret)) {
-		/*
-		 * Atomic work succeeded and we got the lock,
-		 * or failed. Either way, we do _not_ block.
-		 */
-		switch (ret) {
-		case 1:
-			/* We got the lock. */
-			ret = 0;
-			goto out_unlock_put_key;
-		case -EFAULT:
-			goto uaddr_faulted;
-		case -EBUSY:
-		case -EAGAIN:
-			/*
-			 * Two reasons for this:
-			 * - EBUSY: Task is exiting and we just wait for the
-			 *   exit to complete.
-			 * - EAGAIN: The user space value changed.
-			 */
-			futex_q_unlock(hb);
+		hb = futex_hash(&q.key);
+		futex_q_lock(&q, hb);
+
+		ret = futex_lock_pi_atomic(uaddr, hb, &q.key, &q.pi_state, current,
+					   &exiting, 0);
+		if (unlikely(ret)) {
 			/*
-			 * Handle the case where the owner is in the middle of
-			 * exiting. Wait for the exit to complete otherwise
-			 * this task might loop forever, aka. live lock.
+			 * Atomic work succeeded and we got the lock,
+			 * or failed. Either way, we do _not_ block.
 			 */
-			wait_for_owner_exiting(ret, exiting);
-			cond_resched();
-			goto retry;
-		default:
-			goto out_unlock_put_key;
+			switch (ret) {
+			case 1:
+				/* We got the lock. */
+				ret = 0;
+				goto out_unlock_put_key;
+			case -EFAULT:
+				goto uaddr_faulted;
+			case -EBUSY:
+			case -EAGAIN:
+				/*
+				 * Two reasons for this:
+				 * - EBUSY: Task is exiting and we just wait for the
+				 *   exit to complete.
+				 * - EAGAIN: The user space value changed.
+				 */
+				futex_q_unlock(hb);
+				/*
+				 * Handle the case where the owner is in the middle of
+				 * exiting. Wait for the exit to complete otherwise
+				 * this task might loop forever, aka. live lock.
+				 */
+				wait_for_owner_exiting(ret, exiting);
+				cond_resched();
+				goto retry;
+			default:
+				goto out_unlock_put_key;
+			}
 		}
-	}
 
-	WARN_ON(!q.pi_state);
+		WARN_ON(!q.pi_state);
 
-	/*
-	 * Only actually queue now that the atomic ops are done:
-	 */
-	__futex_queue(&q, hb, current);
+		/*
+		 * Only actually queue now that the atomic ops are done:
+		 */
+		__futex_queue(&q, hb, current);
 
-	if (trylock) {
-		ret = rt_mutex_futex_trylock(&q.pi_state->pi_mutex);
-		/* Fixup the trylock return value: */
-		ret = ret ? 0 : -EWOULDBLOCK;
-		goto no_block;
-	}
+		if (trylock) {
+			ret = rt_mutex_futex_trylock(&q.pi_state->pi_mutex);
+			/* Fixup the trylock return value: */
+			ret = ret ? 0 : -EWOULDBLOCK;
+			goto no_block;
+		}
 
-	/*
-	 * Must be done before we enqueue the waiter, here is unfortunately
-	 * under the hb lock, but that *should* work because it does nothing.
-	 */
-	rt_mutex_pre_schedule();
+		/*
+		 * Must be done before we enqueue the waiter, here is unfortunately
+		 * under the hb lock, but that *should* work because it does nothing.
+		 */
+		rt_mutex_pre_schedule();
 
-	rt_mutex_init_waiter(&rt_waiter);
+		rt_mutex_init_waiter(&rt_waiter);
 
-	/*
-	 * On PREEMPT_RT, when hb->lock becomes an rt_mutex, we must not
-	 * hold it while doing rt_mutex_start_proxy(), because then it will
-	 * include hb->lock in the blocking chain, even through we'll not in
-	 * fact hold it while blocking. This will lead it to report -EDEADLK
-	 * and BUG when futex_unlock_pi() interleaves with this.
-	 *
-	 * Therefore acquire wait_lock while holding hb->lock, but drop the
-	 * latter before calling __rt_mutex_start_proxy_lock(). This
-	 * interleaves with futex_unlock_pi() -- which does a similar lock
-	 * handoff -- such that the latter can observe the futex_q::pi_state
-	 * before __rt_mutex_start_proxy_lock() is done.
-	 */
-	raw_spin_lock_irq(&q.pi_state->pi_mutex.wait_lock);
-	spin_unlock(q.lock_ptr);
-	/*
-	 * __rt_mutex_start_proxy_lock() unconditionally enqueues the @rt_waiter
-	 * such that futex_unlock_pi() is guaranteed to observe the waiter when
-	 * it sees the futex_q::pi_state.
-	 */
-	ret = __rt_mutex_start_proxy_lock(&q.pi_state->pi_mutex, &rt_waiter, current, &wake_q);
-	raw_spin_unlock_irq_wake(&q.pi_state->pi_mutex.wait_lock, &wake_q);
+		/*
+		 * On PREEMPT_RT, when hb->lock becomes an rt_mutex, we must not
+		 * hold it while doing rt_mutex_start_proxy(), because then it will
+		 * include hb->lock in the blocking chain, even through we'll not in
+		 * fact hold it while blocking. This will lead it to report -EDEADLK
+		 * and BUG when futex_unlock_pi() interleaves with this.
+		 *
+		 * Therefore acquire wait_lock while holding hb->lock, but drop the
+		 * latter before calling __rt_mutex_start_proxy_lock(). This
+		 * interleaves with futex_unlock_pi() -- which does a similar lock
+		 * handoff -- such that the latter can observe the futex_q::pi_state
+		 * before __rt_mutex_start_proxy_lock() is done.
+		 */
+		raw_spin_lock_irq(&q.pi_state->pi_mutex.wait_lock);
+		spin_unlock(q.lock_ptr);
+		/*
+		 * __rt_mutex_start_proxy_lock() unconditionally enqueues the @rt_waiter
+		 * such that futex_unlock_pi() is guaranteed to observe the waiter when
+		 * it sees the futex_q::pi_state.
+		 */
+		ret = __rt_mutex_start_proxy_lock(&q.pi_state->pi_mutex, &rt_waiter, current, &wake_q);
+		raw_spin_unlock_irq_wake(&q.pi_state->pi_mutex.wait_lock, &wake_q);
 
-	if (ret) {
-		if (ret == 1)
-			ret = 0;
-		goto cleanup;
-	}
+		if (ret) {
+			if (ret == 1)
+				ret = 0;
+			goto cleanup;
+		}
 
-	if (unlikely(to))
-		hrtimer_sleeper_start_expires(to, HRTIMER_MODE_ABS);
+		if (unlikely(to))
+			hrtimer_sleeper_start_expires(to, HRTIMER_MODE_ABS);
 
-	ret = rt_mutex_wait_proxy_lock(&q.pi_state->pi_mutex, to, &rt_waiter);
+		ret = rt_mutex_wait_proxy_lock(&q.pi_state->pi_mutex, to, &rt_waiter);
 
 cleanup:
-	/*
-	 * If we failed to acquire the lock (deadlock/signal/timeout), we must
-	 * must unwind the above, however we canont lock hb->lock because
-	 * rt_mutex already has a waiter enqueued and hb->lock can itself try
-	 * and enqueue an rt_waiter through rtlock.
-	 *
-	 * Doing the cleanup without holding hb->lock can cause inconsistent
-	 * state between hb and pi_state, but only in the direction of not
-	 * seeing a waiter that is leaving.
-	 *
-	 * See futex_unlock_pi(), it deals with this inconsistency.
-	 *
-	 * There be dragons here, since we must deal with the inconsistency on
-	 * the way out (here), it is impossible to detect/warn about the race
-	 * the other way around (missing an incoming waiter).
-	 *
-	 * What could possibly go wrong...
-	 */
-	if (ret && !rt_mutex_cleanup_proxy_lock(&q.pi_state->pi_mutex, &rt_waiter))
-		ret = 0;
+		/*
+		 * If we failed to acquire the lock (deadlock/signal/timeout), we must
+		 * unwind the above, however we canont lock hb->lock because
+		 * rt_mutex already has a waiter enqueued and hb->lock can itself try
+		 * and enqueue an rt_waiter through rtlock.
+		 *
+		 * Doing the cleanup without holding hb->lock can cause inconsistent
+		 * state between hb and pi_state, but only in the direction of not
+		 * seeing a waiter that is leaving.
+		 *
+		 * See futex_unlock_pi(), it deals with this inconsistency.
+		 *
+		 * There be dragons here, since we must deal with the inconsistency on
+		 * the way out (here), it is impossible to detect/warn about the race
+		 * the other way around (missing an incoming waiter).
+		 *
+		 * What could possibly go wrong...
+		 */
+		if (ret && !rt_mutex_cleanup_proxy_lock(&q.pi_state->pi_mutex, &rt_waiter))
+			ret = 0;
 
-	/*
-	 * Now that the rt_waiter has been dequeued, it is safe to use
-	 * spinlock/rtlock (which might enqueue its own rt_waiter) and fix up
-	 * the
-	 */
-	spin_lock(q.lock_ptr);
-	/*
-	 * Waiter is unqueued.
-	 */
-	rt_mutex_post_schedule();
+		/*
+		 * Now that the rt_waiter has been dequeued, it is safe to use
+		 * spinlock/rtlock (which might enqueue its own rt_waiter) and fix up
+		 * the
+		 */
+		spin_lock(q.lock_ptr);
+		/*
+		 * Waiter is unqueued.
+		 */
+		rt_mutex_post_schedule();
 no_block:
-	/*
-	 * Fixup the pi_state owner and possibly acquire the lock if we
-	 * haven't already.
-	 */
-	res = fixup_pi_owner(uaddr, &q, !ret);
-	/*
-	 * If fixup_pi_owner() returned an error, propagate that.  If it acquired
-	 * the lock, clear our -ETIMEDOUT or -EINTR.
-	 */
-	if (res)
-		ret = (res < 0) ? res : 0;
+		/*
+		 * Fixup the pi_state owner and possibly acquire the lock if we
+		 * haven't already.
+		 */
+		res = fixup_pi_owner(uaddr, &q, !ret);
+		/*
+		 * If fixup_pi_owner() returned an error, propagate that.  If it acquired
+		 * the lock, clear our -ETIMEDOUT or -EINTR.
+		 */
+		if (res)
+			ret = (res < 0) ? res : 0;
 
-	futex_unqueue_pi(&q);
-	spin_unlock(q.lock_ptr);
-	goto out;
+		futex_unqueue_pi(&q);
+		spin_unlock(q.lock_ptr);
+		goto out;
 
 out_unlock_put_key:
-	futex_q_unlock(hb);
+		futex_q_unlock(hb);
+		goto out;
+
+uaddr_faulted:
+		futex_q_unlock(hb);
+
+		ret = fault_in_user_writeable(uaddr);
+		if (ret)
+			goto out;
+
+		if (!(flags & FLAGS_SHARED))
+			goto retry_private;
+
+		goto retry;
+	}
 
 out:
 	if (to) {
@@ -1092,18 +1108,6 @@ out:
 		destroy_hrtimer_on_stack(&to->timer);
 	}
 	return ret != -EINTR ? ret : -ERESTARTNOINTR;
-
-uaddr_faulted:
-	futex_q_unlock(hb);
-
-	ret = fault_in_user_writeable(uaddr);
-	if (ret)
-		goto out;
-
-	if (!(flags & FLAGS_SHARED))
-		goto retry_private;
-
-	goto retry;
 }
 
 /*
diff --git a/kernel/futex/requeue.c b/kernel/futex/requeue.c
index 0e55975..209794c 100644
--- a/kernel/futex/requeue.c
+++ b/kernel/futex/requeue.c
@@ -371,7 +371,6 @@ int futex_requeue(u32 __user *uaddr1, unsigned int flags1,
 	union futex_key key1 = FUTEX_KEY_INIT, key2 = FUTEX_KEY_INIT;
 	int task_count = 0, ret;
 	struct futex_pi_state *pi_state = NULL;
-	struct futex_hash_bucket *hb1, *hb2;
 	struct futex_q *this, *next;
 	DEFINE_WAKE_Q(wake_q);
 
@@ -443,240 +442,244 @@ retry:
 	if (requeue_pi && futex_match(&key1, &key2))
 		return -EINVAL;
 
-	hb1 = futex_hash(&key1);
-	hb2 = futex_hash(&key2);
-
 retry_private:
-	futex_hb_waiters_inc(hb2);
-	double_lock_hb(hb1, hb2);
+	if (1) {
+		struct futex_hash_bucket *hb1, *hb2;
 
-	if (likely(cmpval != NULL)) {
-		u32 curval;
+		hb1 = futex_hash(&key1);
+		hb2 = futex_hash(&key2);
 
-		ret = futex_get_value_locked(&curval, uaddr1);
+		futex_hb_waiters_inc(hb2);
+		double_lock_hb(hb1, hb2);
 
-		if (unlikely(ret)) {
-			double_unlock_hb(hb1, hb2);
-			futex_hb_waiters_dec(hb2);
+		if (likely(cmpval != NULL)) {
+			u32 curval;
 
-			ret = get_user(curval, uaddr1);
-			if (ret)
-				return ret;
+			ret = futex_get_value_locked(&curval, uaddr1);
 
-			if (!(flags1 & FLAGS_SHARED))
-				goto retry_private;
+			if (unlikely(ret)) {
+				double_unlock_hb(hb1, hb2);
+				futex_hb_waiters_dec(hb2);
 
-			goto retry;
-		}
-		if (curval != *cmpval) {
-			ret = -EAGAIN;
-			goto out_unlock;
-		}
-	}
+				ret = get_user(curval, uaddr1);
+				if (ret)
+					return ret;
 
-	if (requeue_pi) {
-		struct task_struct *exiting = NULL;
+				if (!(flags1 & FLAGS_SHARED))
+					goto retry_private;
 
-		/*
-		 * Attempt to acquire uaddr2 and wake the top waiter. If we
-		 * intend to requeue waiters, force setting the FUTEX_WAITERS
-		 * bit.  We force this here where we are able to easily handle
-		 * faults rather in the requeue loop below.
-		 *
-		 * Updates topwaiter::requeue_state if a top waiter exists.
-		 */
-		ret = futex_proxy_trylock_atomic(uaddr2, hb1, hb2, &key1,
-						 &key2, &pi_state,
-						 &exiting, nr_requeue);
+				goto retry;
+			}
+			if (curval != *cmpval) {
+				ret = -EAGAIN;
+				goto out_unlock;
+			}
+		}
 
-		/*
-		 * At this point the top_waiter has either taken uaddr2 or
-		 * is waiting on it. In both cases pi_state has been
-		 * established and an initial refcount on it. In case of an
-		 * error there's nothing.
-		 *
-		 * The top waiter's requeue_state is up to date:
-		 *
-		 *  - If the lock was acquired atomically (ret == 1), then
-		 *    the state is Q_REQUEUE_PI_LOCKED.
-		 *
-		 *    The top waiter has been dequeued and woken up and can
-		 *    return to user space immediately. The kernel/user
-		 *    space state is consistent. In case that there must be
-		 *    more waiters requeued the WAITERS bit in the user
-		 *    space futex is set so the top waiter task has to go
-		 *    into the syscall slowpath to unlock the futex. This
-		 *    will block until this requeue operation has been
-		 *    completed and the hash bucket locks have been
-		 *    dropped.
-		 *
-		 *  - If the trylock failed with an error (ret < 0) then
-		 *    the state is either Q_REQUEUE_PI_NONE, i.e. "nothing
-		 *    happened", or Q_REQUEUE_PI_IGNORE when there was an
-		 *    interleaved early wakeup.
-		 *
-		 *  - If the trylock did not succeed (ret == 0) then the
-		 *    state is either Q_REQUEUE_PI_IN_PROGRESS or
-		 *    Q_REQUEUE_PI_WAIT if an early wakeup interleaved.
-		 *    This will be cleaned up in the loop below, which
-		 *    cannot fail because futex_proxy_trylock_atomic() did
-		 *    the same sanity checks for requeue_pi as the loop
-		 *    below does.
-		 */
-		switch (ret) {
-		case 0:
-			/* We hold a reference on the pi state. */
-			break;
+		if (requeue_pi) {
+			struct task_struct *exiting = NULL;
 
-		case 1:
 			/*
-			 * futex_proxy_trylock_atomic() acquired the user space
-			 * futex. Adjust task_count.
+			 * Attempt to acquire uaddr2 and wake the top waiter. If we
+			 * intend to requeue waiters, force setting the FUTEX_WAITERS
+			 * bit.  We force this here where we are able to easily handle
+			 * faults rather in the requeue loop below.
+			 *
+			 * Updates topwaiter::requeue_state if a top waiter exists.
 			 */
-			task_count++;
-			ret = 0;
-			break;
+			ret = futex_proxy_trylock_atomic(uaddr2, hb1, hb2, &key1,
+							 &key2, &pi_state,
+							 &exiting, nr_requeue);
 
-		/*
-		 * If the above failed, then pi_state is NULL and
-		 * waiter::requeue_state is correct.
-		 */
-		case -EFAULT:
-			double_unlock_hb(hb1, hb2);
-			futex_hb_waiters_dec(hb2);
-			ret = fault_in_user_writeable(uaddr2);
-			if (!ret)
-				goto retry;
-			return ret;
-		case -EBUSY:
-		case -EAGAIN:
-			/*
-			 * Two reasons for this:
-			 * - EBUSY: Owner is exiting and we just wait for the
-			 *   exit to complete.
-			 * - EAGAIN: The user space value changed.
-			 */
-			double_unlock_hb(hb1, hb2);
-			futex_hb_waiters_dec(hb2);
 			/*
-			 * Handle the case where the owner is in the middle of
-			 * exiting. Wait for the exit to complete otherwise
-			 * this task might loop forever, aka. live lock.
+			 * At this point the top_waiter has either taken uaddr2 or
+			 * is waiting on it. In both cases pi_state has been
+			 * established and an initial refcount on it. In case of an
+			 * error there's nothing.
+			 *
+			 * The top waiter's requeue_state is up to date:
+			 *
+			 *  - If the lock was acquired atomically (ret == 1), then
+			 *    the state is Q_REQUEUE_PI_LOCKED.
+			 *
+			 *    The top waiter has been dequeued and woken up and can
+			 *    return to user space immediately. The kernel/user
+			 *    space state is consistent. In case that there must be
+			 *    more waiters requeued the WAITERS bit in the user
+			 *    space futex is set so the top waiter task has to go
+			 *    into the syscall slowpath to unlock the futex. This
+			 *    will block until this requeue operation has been
+			 *    completed and the hash bucket locks have been
+			 *    dropped.
+			 *
+			 *  - If the trylock failed with an error (ret < 0) then
+			 *    the state is either Q_REQUEUE_PI_NONE, i.e. "nothing
+			 *    happened", or Q_REQUEUE_PI_IGNORE when there was an
+			 *    interleaved early wakeup.
+			 *
+			 *  - If the trylock did not succeed (ret == 0) then the
+			 *    state is either Q_REQUEUE_PI_IN_PROGRESS or
+			 *    Q_REQUEUE_PI_WAIT if an early wakeup interleaved.
+			 *    This will be cleaned up in the loop below, which
+			 *    cannot fail because futex_proxy_trylock_atomic() did
+			 *    the same sanity checks for requeue_pi as the loop
+			 *    below does.
 			 */
-			wait_for_owner_exiting(ret, exiting);
-			cond_resched();
-			goto retry;
-		default:
-			goto out_unlock;
-		}
-	}
-
-	plist_for_each_entry_safe(this, next, &hb1->chain, list) {
-		if (task_count - nr_wake >= nr_requeue)
-			break;
-
-		if (!futex_match(&this->key, &key1))
-			continue;
-
-		/*
-		 * FUTEX_WAIT_REQUEUE_PI and FUTEX_CMP_REQUEUE_PI should always
-		 * be paired with each other and no other futex ops.
-		 *
-		 * We should never be requeueing a futex_q with a pi_state,
-		 * which is awaiting a futex_unlock_pi().
-		 */
-		if ((requeue_pi && !this->rt_waiter) ||
-		    (!requeue_pi && this->rt_waiter) ||
-		    this->pi_state) {
-			ret = -EINVAL;
-			break;
-		}
-
-		/* Plain futexes just wake or requeue and are done */
-		if (!requeue_pi) {
-			if (++task_count <= nr_wake)
-				this->wake(&wake_q, this);
-			else
-				requeue_futex(this, hb1, hb2, &key2);
-			continue;
+			switch (ret) {
+			case 0:
+				/* We hold a reference on the pi state. */
+				break;
+
+			case 1:
+				/*
+				 * futex_proxy_trylock_atomic() acquired the user space
+				 * futex. Adjust task_count.
+				 */
+				task_count++;
+				ret = 0;
+				break;
+
+				/*
+				 * If the above failed, then pi_state is NULL and
+				 * waiter::requeue_state is correct.
+				 */
+			case -EFAULT:
+				double_unlock_hb(hb1, hb2);
+				futex_hb_waiters_dec(hb2);
+				ret = fault_in_user_writeable(uaddr2);
+				if (!ret)
+					goto retry;
+				return ret;
+			case -EBUSY:
+			case -EAGAIN:
+				/*
+				 * Two reasons for this:
+				 * - EBUSY: Owner is exiting and we just wait for the
+				 *   exit to complete.
+				 * - EAGAIN: The user space value changed.
+				 */
+				double_unlock_hb(hb1, hb2);
+				futex_hb_waiters_dec(hb2);
+				/*
+				 * Handle the case where the owner is in the middle of
+				 * exiting. Wait for the exit to complete otherwise
+				 * this task might loop forever, aka. live lock.
+				 */
+				wait_for_owner_exiting(ret, exiting);
+				cond_resched();
+				goto retry;
+			default:
+				goto out_unlock;
+			}
 		}
 
-		/* Ensure we requeue to the expected futex for requeue_pi. */
-		if (!futex_match(this->requeue_pi_key, &key2)) {
-			ret = -EINVAL;
-			break;
-		}
+		plist_for_each_entry_safe(this, next, &hb1->chain, list) {
+			if (task_count - nr_wake >= nr_requeue)
+				break;
 
-		/*
-		 * Requeue nr_requeue waiters and possibly one more in the case
-		 * of requeue_pi if we couldn't acquire the lock atomically.
-		 *
-		 * Prepare the waiter to take the rt_mutex. Take a refcount
-		 * on the pi_state and store the pointer in the futex_q
-		 * object of the waiter.
-		 */
-		get_pi_state(pi_state);
+			if (!futex_match(&this->key, &key1))
+				continue;
 
-		/* Don't requeue when the waiter is already on the way out. */
-		if (!futex_requeue_pi_prepare(this, pi_state)) {
 			/*
-			 * Early woken waiter signaled that it is on the
-			 * way out. Drop the pi_state reference and try the
-			 * next waiter. @this->pi_state is still NULL.
+			 * FUTEX_WAIT_REQUEUE_PI and FUTEX_CMP_REQUEUE_PI should always
+			 * be paired with each other and no other futex ops.
+			 *
+			 * We should never be requeueing a futex_q with a pi_state,
+			 * which is awaiting a futex_unlock_pi().
 			 */
-			put_pi_state(pi_state);
-			continue;
-		}
-
-		ret = rt_mutex_start_proxy_lock(&pi_state->pi_mutex,
-						this->rt_waiter,
-						this->task);
+			if ((requeue_pi && !this->rt_waiter) ||
+			    (!requeue_pi && this->rt_waiter) ||
+			    this->pi_state) {
+				ret = -EINVAL;
+				break;
+			}
+
+			/* Plain futexes just wake or requeue and are done */
+			if (!requeue_pi) {
+				if (++task_count <= nr_wake)
+					this->wake(&wake_q, this);
+				else
+					requeue_futex(this, hb1, hb2, &key2);
+				continue;
+			}
+
+			/* Ensure we requeue to the expected futex for requeue_pi. */
+			if (!futex_match(this->requeue_pi_key, &key2)) {
+				ret = -EINVAL;
+				break;
+			}
 
-		if (ret == 1) {
-			/*
-			 * We got the lock. We do neither drop the refcount
-			 * on pi_state nor clear this->pi_state because the
-			 * waiter needs the pi_state for cleaning up the
-			 * user space value. It will drop the refcount
-			 * after doing so. this::requeue_state is updated
-			 * in the wakeup as well.
-			 */
-			requeue_pi_wake_futex(this, &key2, hb2);
-			task_count++;
-		} else if (!ret) {
-			/* Waiter is queued, move it to hb2 */
-			requeue_futex(this, hb1, hb2, &key2);
-			futex_requeue_pi_complete(this, 0);
-			task_count++;
-		} else {
-			/*
-			 * rt_mutex_start_proxy_lock() detected a potential
-			 * deadlock when we tried to queue that waiter.
-			 * Drop the pi_state reference which we took above
-			 * and remove the pointer to the state from the
-			 * waiters futex_q object.
-			 */
-			this->pi_state = NULL;
-			put_pi_state(pi_state);
-			futex_requeue_pi_complete(this, ret);
 			/*
-			 * We stop queueing more waiters and let user space
-			 * deal with the mess.
+			 * Requeue nr_requeue waiters and possibly one more in the case
+			 * of requeue_pi if we couldn't acquire the lock atomically.
+			 *
+			 * Prepare the waiter to take the rt_mutex. Take a refcount
+			 * on the pi_state and store the pointer in the futex_q
+			 * object of the waiter.
 			 */
-			break;
+			get_pi_state(pi_state);
+
+			/* Don't requeue when the waiter is already on the way out. */
+			if (!futex_requeue_pi_prepare(this, pi_state)) {
+				/*
+				 * Early woken waiter signaled that it is on the
+				 * way out. Drop the pi_state reference and try the
+				 * next waiter. @this->pi_state is still NULL.
+				 */
+				put_pi_state(pi_state);
+				continue;
+			}
+
+			ret = rt_mutex_start_proxy_lock(&pi_state->pi_mutex,
+							this->rt_waiter,
+							this->task);
+
+			if (ret == 1) {
+				/*
+				 * We got the lock. We do neither drop the refcount
+				 * on pi_state nor clear this->pi_state because the
+				 * waiter needs the pi_state for cleaning up the
+				 * user space value. It will drop the refcount
+				 * after doing so. this::requeue_state is updated
+				 * in the wakeup as well.
+				 */
+				requeue_pi_wake_futex(this, &key2, hb2);
+				task_count++;
+			} else if (!ret) {
+				/* Waiter is queued, move it to hb2 */
+				requeue_futex(this, hb1, hb2, &key2);
+				futex_requeue_pi_complete(this, 0);
+				task_count++;
+			} else {
+				/*
+				 * rt_mutex_start_proxy_lock() detected a potential
+				 * deadlock when we tried to queue that waiter.
+				 * Drop the pi_state reference which we took above
+				 * and remove the pointer to the state from the
+				 * waiters futex_q object.
+				 */
+				this->pi_state = NULL;
+				put_pi_state(pi_state);
+				futex_requeue_pi_complete(this, ret);
+				/*
+				 * We stop queueing more waiters and let user space
+				 * deal with the mess.
+				 */
+				break;
+			}
 		}
-	}
 
-	/*
-	 * We took an extra initial reference to the pi_state in
-	 * futex_proxy_trylock_atomic(). We need to drop it here again.
-	 */
-	put_pi_state(pi_state);
+		/*
+		 * We took an extra initial reference to the pi_state in
+		 * futex_proxy_trylock_atomic(). We need to drop it here again.
+		 */
+		put_pi_state(pi_state);
 
 out_unlock:
-	double_unlock_hb(hb1, hb2);
+		double_unlock_hb(hb1, hb2);
+		futex_hb_waiters_dec(hb2);
+	}
 	wake_up_q(&wake_q);
-	futex_hb_waiters_dec(hb2);
 	return ret ? ret : task_count;
 }
 
diff --git a/kernel/futex/waitwake.c b/kernel/futex/waitwake.c
index 1108f37..7dc35be 100644
--- a/kernel/futex/waitwake.c
+++ b/kernel/futex/waitwake.c
@@ -253,7 +253,6 @@ int futex_wake_op(u32 __user *uaddr1, unsigned int flags, u32 __user *uaddr2,
 		  int nr_wake, int nr_wake2, int op)
 {
 	union futex_key key1 = FUTEX_KEY_INIT, key2 = FUTEX_KEY_INIT;
-	struct futex_hash_bucket *hb1, *hb2;
 	struct futex_q *this, *next;
 	int ret, op_ret;
 	DEFINE_WAKE_Q(wake_q);
@@ -266,67 +265,71 @@ retry:
 	if (unlikely(ret != 0))
 		return ret;
 
-	hb1 = futex_hash(&key1);
-	hb2 = futex_hash(&key2);
-
 retry_private:
-	double_lock_hb(hb1, hb2);
-	op_ret = futex_atomic_op_inuser(op, uaddr2);
-	if (unlikely(op_ret < 0)) {
-		double_unlock_hb(hb1, hb2);
-
-		if (!IS_ENABLED(CONFIG_MMU) ||
-		    unlikely(op_ret != -EFAULT && op_ret != -EAGAIN)) {
-			/*
-			 * we don't get EFAULT from MMU faults if we don't have
-			 * an MMU, but we might get them from range checking
-			 */
-			ret = op_ret;
-			return ret;
-		}
-
-		if (op_ret == -EFAULT) {
-			ret = fault_in_user_writeable(uaddr2);
-			if (ret)
+	if (1) {
+		struct futex_hash_bucket *hb1, *hb2;
+
+		hb1 = futex_hash(&key1);
+		hb2 = futex_hash(&key2);
+
+		double_lock_hb(hb1, hb2);
+		op_ret = futex_atomic_op_inuser(op, uaddr2);
+		if (unlikely(op_ret < 0)) {
+			double_unlock_hb(hb1, hb2);
+
+			if (!IS_ENABLED(CONFIG_MMU) ||
+			    unlikely(op_ret != -EFAULT && op_ret != -EAGAIN)) {
+				/*
+				 * we don't get EFAULT from MMU faults if we don't have
+				 * an MMU, but we might get them from range checking
+				 */
+				ret = op_ret;
 				return ret;
-		}
-
-		cond_resched();
-		if (!(flags & FLAGS_SHARED))
-			goto retry_private;
-		goto retry;
-	}
+			}
 
-	plist_for_each_entry_safe(this, next, &hb1->chain, list) {
-		if (futex_match (&this->key, &key1)) {
-			if (this->pi_state || this->rt_waiter) {
-				ret = -EINVAL;
-				goto out_unlock;
+			if (op_ret == -EFAULT) {
+				ret = fault_in_user_writeable(uaddr2);
+				if (ret)
+					return ret;
 			}
-			this->wake(&wake_q, this);
-			if (++ret >= nr_wake)
-				break;
+
+			cond_resched();
+			if (!(flags & FLAGS_SHARED))
+				goto retry_private;
+			goto retry;
 		}
-	}
 
-	if (op_ret > 0) {
-		op_ret = 0;
-		plist_for_each_entry_safe(this, next, &hb2->chain, list) {
-			if (futex_match (&this->key, &key2)) {
+		plist_for_each_entry_safe(this, next, &hb1->chain, list) {
+			if (futex_match(&this->key, &key1)) {
 				if (this->pi_state || this->rt_waiter) {
 					ret = -EINVAL;
 					goto out_unlock;
 				}
 				this->wake(&wake_q, this);
-				if (++op_ret >= nr_wake2)
+				if (++ret >= nr_wake)
 					break;
 			}
 		}
-		ret += op_ret;
-	}
+
+		if (op_ret > 0) {
+			op_ret = 0;
+			plist_for_each_entry_safe(this, next, &hb2->chain, list) {
+				if (futex_match(&this->key, &key2)) {
+					if (this->pi_state || this->rt_waiter) {
+						ret = -EINVAL;
+						goto out_unlock;
+					}
+					this->wake(&wake_q, this);
+					if (++op_ret >= nr_wake2)
+						break;
+				}
+			}
+			ret += op_ret;
+		}
 
 out_unlock:
-	double_unlock_hb(hb1, hb2);
+		double_unlock_hb(hb1, hb2);
+	}
 	wake_up_q(&wake_q);
 	return ret;
 }
@@ -402,7 +405,6 @@ int futex_unqueue_multiple(struct futex_vector *v, int count)
  */
 int futex_wait_multiple_setup(struct futex_vector *vs, int count, int *woken)
 {
-	struct futex_hash_bucket *hb;
 	bool retry = false;
 	int ret, i;
 	u32 uval;
@@ -441,21 +443,25 @@ retry:
 		struct futex_q *q = &vs[i].q;
 		u32 val = vs[i].w.val;
 
-		hb = futex_hash(&q->key);
-		futex_q_lock(q, hb);
-		ret = futex_get_value_locked(&uval, uaddr);
+		if (1) {
+			struct futex_hash_bucket *hb;
 
-		if (!ret && uval == val) {
-			/*
-			 * The bucket lock can't be held while dealing with the
-			 * next futex. Queue each futex at this moment so hb can
-			 * be unlocked.
-			 */
-			futex_queue(q, hb, current);
-			continue;
-		}
+			hb = futex_hash(&q->key);
+			futex_q_lock(q, hb);
+			ret = futex_get_value_locked(&uval, uaddr);
 
-		futex_q_unlock(hb);
+			if (!ret && uval == val) {
+				/*
+				 * The bucket lock can't be held while dealing with the
+				 * next futex. Queue each futex at this moment so hb can
+				 * be unlocked.
+				 */
+				futex_queue(q, hb, current);
+				continue;
+			}
+
+			futex_q_unlock(hb);
+		}
 		__set_current_state(TASK_RUNNING);
 
 		/*
@@ -584,7 +590,6 @@ int futex_wait_setup(u32 __user *uaddr, u32 val, unsigned int flags,
 		     struct futex_q *q, union futex_key *key2,
 		     struct task_struct *task)
 {
-	struct futex_hash_bucket *hb;
 	u32 uval;
 	int ret;
 
@@ -612,43 +617,47 @@ retry:
 		return ret;
 
 retry_private:
-	hb = futex_hash(&q->key);
-	futex_q_lock(q, hb);
+	if (1) {
+		struct futex_hash_bucket *hb;
+
+		hb = futex_hash(&q->key);
+		futex_q_lock(q, hb);
 
-	ret = futex_get_value_locked(&uval, uaddr);
+		ret = futex_get_value_locked(&uval, uaddr);
 
-	if (ret) {
-		futex_q_unlock(hb);
+		if (ret) {
+			futex_q_unlock(hb);
 
-		ret = get_user(uval, uaddr);
-		if (ret)
-			return ret;
+			ret = get_user(uval, uaddr);
+			if (ret)
+				return ret;
 
-		if (!(flags & FLAGS_SHARED))
-			goto retry_private;
+			if (!(flags & FLAGS_SHARED))
+				goto retry_private;
 
-		goto retry;
-	}
+			goto retry;
+		}
 
-	if (uval != val) {
-		futex_q_unlock(hb);
-		return -EWOULDBLOCK;
-	}
+		if (uval != val) {
+			futex_q_unlock(hb);
+			return -EWOULDBLOCK;
+		}
 
-	if (key2 && futex_match(&q->key, key2)) {
-		futex_q_unlock(hb);
-		return -EINVAL;
-	}
+		if (key2 && futex_match(&q->key, key2)) {
+			futex_q_unlock(hb);
+			return -EINVAL;
+		}
 
-	/*
-	 * The task state is guaranteed to be set before another task can
-	 * wake it. set_current_state() is implemented using smp_store_mb() and
-	 * futex_queue() calls spin_unlock() upon completion, both serializing
-	 * access to the hash list and forcing another memory barrier.
-	 */
-	if (task == current)
-		set_current_state(TASK_INTERRUPTIBLE|TASK_FREEZABLE);
-	futex_queue(q, hb, task);
+		/*
+		 * The task state is guaranteed to be set before another task can
+		 * wake it. set_current_state() is implemented using smp_store_mb() and
+		 * futex_queue() calls spin_unlock() upon completion, both serializing
+		 * access to the hash list and forcing another memory barrier.
+		 */
+		if (task == current)
+			set_current_state(TASK_INTERRUPTIBLE|TASK_FREEZABLE);
+		futex_queue(q, hb, task);
+	}
 
 	return ret;
 }

