Return-Path: <linux-tip-commits+bounces-4188-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 06722A5F272
	for <lists+linux-tip-commits@lfdr.de>; Thu, 13 Mar 2025 12:33:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B12BD19C12C8
	for <lists+linux-tip-commits@lfdr.de>; Thu, 13 Mar 2025 11:33:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80F7226771F;
	Thu, 13 Mar 2025 11:31:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ATNGgfRf";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="HhtVjN/j"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39D522641F4;
	Thu, 13 Mar 2025 11:31:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741865494; cv=none; b=fUr8+4klsxSKQ1utZaJ7SOJuQ8sw74Vg0KKUJ7+x2KoZkcYnIWDs6woatg2a41Jr2V71dfmyoF1DxfNbhZ876fzy3rfdqrrQ7k5nR1BUNJuBg3/rq8oIVX3mY5NtusmaXEgY9CT8ZgTevWac/Ag/k9yDmJ9AzarwuSiOzgNGudI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741865494; c=relaxed/simple;
	bh=32xqIk0sfTqa467Z1eG9Z/ro++VWhJrwh1jU5KDNnNo=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=KcbIGs2lDC4NxdXXS/zXiUKj/C/etZc1OZMn73rrJtcqBG1Zlj5zh5rsITfaUalPH9mDc/XsovpiP2ygqgCZ8R+jDVskjJrukymmGFlk+mACLcHZC3wttwqPB2NZYEvbECaTu1QjIuNOE//fYYepPvhkC2P98+C27wzg4NfvoHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ATNGgfRf; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=HhtVjN/j; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 13 Mar 2025 11:31:28 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1741865489;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SBOKYrnjHrfBJcj4I9jv6wnnl0O20SQ++ehbpg4+yV8=;
	b=ATNGgfRf+mDUIPw/K2Sa1ut2T6zZ4E65fvB0i2PylYGBJDWqtxzPtLAssuh8orxb6KlFzH
	q1N9SzjMgrtrDQSBG68GdBKcLQTDqGp9gc62VK3j46U8Uot/1Rwa2PKEvwGBrBB0/Bz7W5
	GA+TEXJ5yh+1lQDXKNkM82HxI40QDoQaoChANU4dg5ZR3I5Y6txdhv2ts/PPlyue9i5cfq
	dfUCa6UGSI7i8HdgmFc/w50wMLCfphPdt4thqZjR/bPZ2y8uHUUBNoDTPPW/JgBDGlJwHW
	7qeVHnMYoBHGXRI6XLZC+8yzOCULZhUAerNoW3pfgQJ13Vwqv0CLQbck2AajQw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1741865489;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SBOKYrnjHrfBJcj4I9jv6wnnl0O20SQ++ehbpg4+yV8=;
	b=HhtVjN/jaZhoVItpQ7uZiShN6No6v5Iu5SbikTgk89vvgS7DAh86q0dIlv2BlIJ70Y4BTR
	s55RtS+iwtq23+Ag==
From: "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] posix-timers: Rework timer removal
Cc: Thomas Gleixner <tglx@linutronix.de>,
 Frederic Weisbecker <frederic@kernel.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <87zfht1exf.ffs@tglx>
References: <87zfht1exf.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174186548859.14745.2675618902011180997.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     1d25bdd3f3831bb1b9512d4b5afcd2dea8a0c515
Gitweb:        https://git.kernel.org/tip/1d25bdd3f3831bb1b9512d4b5afcd2dea8a0c515
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Mon, 10 Mar 2025 09:13:32 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 13 Mar 2025 12:07:17 +01:00

posix-timers: Rework timer removal

sys_timer_delete() and the do_exit() cleanup function itimer_delete() are
doing the same thing, but have needlessly different implementations instead
of sharing the code.

The other oddity of timer deletion is the fact that the timer is not
invalidated before the actual deletion happens, which allows concurrent
lookups to succeed.

That's wrong because a timer which is in the process of being deleted
should not be visible and any actions like signal queueing, delivery and
rearming should not happen once the task, which invoked timer_delete(), has
the timer locked.

Rework the code so that:

   1) The signal queueing and delivery code ignore timers which are marked
      invalid

   2) The deletion implementation between sys_timer_delete() and
      itimer_delete() is shared

   3) The timer is invalidated and removed from the linked lists before
      the deletion callback of the relevant clock is invoked.

      That requires to rework timer_wait_running() as it does a lookup of
      the timer when relocking it at the end. In case of deletion this
      lookup would fail due to the preceding invalidation and the wait loop
      would terminate prematurely.

      But due to the preceding invalidation the timer cannot be accessed by
      other tasks anymore, so there is no way that the timer has been freed
      after the timer lock has been dropped.

      Move the re-validation out of timer_wait_running() and handle it at
      the only other usage site, timer_settime().

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
Link: https://lore.kernel.org/all/87zfht1exf.ffs@tglx

---
 include/linux/posix-timers.h |   7 +-
 kernel/signal.c              |   2 +-
 kernel/time/posix-timers.c   | 194 ++++++++++++++--------------------
 3 files changed, 90 insertions(+), 113 deletions(-)

diff --git a/include/linux/posix-timers.h b/include/linux/posix-timers.h
index f11f10c..e714a55 100644
--- a/include/linux/posix-timers.h
+++ b/include/linux/posix-timers.h
@@ -240,6 +240,13 @@ static inline void posixtimer_sigqueue_putref(struct sigqueue *q)
 
 	posixtimer_putref(tmr);
 }
+
+static inline bool posixtimer_valid(const struct k_itimer *timer)
+{
+	unsigned long val = (unsigned long)timer->it_signal;
+
+	return !(val & 0x1UL);
+}
 #else  /* CONFIG_POSIX_TIMERS */
 static inline void posixtimer_sigqueue_getref(struct sigqueue *q) { }
 static inline void posixtimer_sigqueue_putref(struct sigqueue *q) { }
diff --git a/kernel/signal.c b/kernel/signal.c
index 875e97f..bb62104 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -2092,7 +2092,7 @@ static inline void posixtimer_sig_ignore(struct task_struct *tsk, struct sigqueu
 	 * from a non-periodic timer, then just drop the reference
 	 * count. Otherwise queue it on the ignored list.
 	 */
-	if (tmr->it_signal && tmr->it_sig_periodic)
+	if (posixtimer_valid(tmr) && tmr->it_sig_periodic)
 		hlist_add_head(&tmr->ignored_list, &tsk->signal->ignored_posix_timers);
 	else
 		posixtimer_putref(tmr);
diff --git a/kernel/time/posix-timers.c b/kernel/time/posix-timers.c
index 4d25bea..dff414b 100644
--- a/kernel/time/posix-timers.c
+++ b/kernel/time/posix-timers.c
@@ -279,7 +279,7 @@ static bool __posixtimer_deliver_signal(struct kernel_siginfo *info, struct k_it
 	 * since the signal was queued. In either case, don't rearm and
 	 * drop the signal.
 	 */
-	if (timr->it_signal_seq != timr->it_sigqueue_seq || WARN_ON_ONCE(!timr->it_signal))
+	if (timr->it_signal_seq != timr->it_sigqueue_seq || WARN_ON_ONCE(!posixtimer_valid(timr)))
 		return false;
 
 	if (!timr->it_interval || WARN_ON_ONCE(timr->it_status != POSIX_TIMER_REQUEUE_PENDING))
@@ -324,6 +324,9 @@ void posix_timer_queue_signal(struct k_itimer *timr)
 {
 	lockdep_assert_held(&timr->it_lock);
 
+	if (!posixtimer_valid(timr))
+		return;
+
 	timr->it_status = timr->it_interval ? POSIX_TIMER_REQUEUE_PENDING : POSIX_TIMER_DISARMED;
 	posixtimer_send_sigqueue(timr);
 }
@@ -553,11 +556,11 @@ static struct k_itimer *__lock_timer(timer_t timer_id)
 	 * The hash lookup and the timers are RCU protected.
 	 *
 	 * Timers are added to the hash in invalid state where
-	 * timr::it_signal == NULL. timer::it_signal is only set after the
-	 * rest of the initialization succeeded.
+	 * timr::it_signal is marked invalid. timer::it_signal is only set
+	 * after the rest of the initialization succeeded.
 	 *
 	 * Timer destruction happens in steps:
-	 *  1) Set timr::it_signal to NULL with timr::it_lock held
+	 *  1) Set timr::it_signal marked invalid with timr::it_lock held
 	 *  2) Release timr::it_lock
 	 *  3) Remove from the hash under hash_lock
 	 *  4) Put the reference count.
@@ -574,8 +577,8 @@ static struct k_itimer *__lock_timer(timer_t timer_id)
 	 *
 	 * The lookup validates locklessly that timr::it_signal ==
 	 * current::it_signal and timr::it_id == @timer_id. timr::it_id
-	 * can't change, but timr::it_signal becomes NULL during
-	 * destruction.
+	 * can't change, but timr::it_signal can become invalid during
+	 * destruction, which makes the locked check fail.
 	 */
 	guard(rcu)();
 	timr = posix_timer_by_id(timer_id);
@@ -811,22 +814,13 @@ static void common_timer_wait_running(struct k_itimer *timer)
  * when the task which tries to delete or disarm the timer has preempted
  * the task which runs the expiry in task work context.
  */
-static struct k_itimer *timer_wait_running(struct k_itimer *timer)
+static void timer_wait_running(struct k_itimer *timer)
 {
-	timer_t timer_id = READ_ONCE(timer->it_id);
-
-	/* Prevent kfree(timer) after dropping the lock */
-	scoped_guard (rcu) {
-		unlock_timer(timer);
-		/*
-		 * kc->timer_wait_running() might drop RCU lock. So @timer
-		 * cannot be touched anymore after the function returns!
-		 */
-		timer->kclock->timer_wait_running(timer);
-	}
-
-	/* Relock the timer. It might be not longer hashed. */
-	return lock_timer(timer_id);
+	/*
+	 * kc->timer_wait_running() might drop RCU lock. So @timer
+	 * cannot be touched anymore after the function returns!
+	 */
+	timer->kclock->timer_wait_running(timer);
 }
 
 /*
@@ -885,8 +879,7 @@ static int do_timer_settime(timer_t timer_id, int tmr_flags,
 			    struct itimerspec64 *new_spec64,
 			    struct itimerspec64 *old_spec64)
 {
-	struct k_itimer *timr;
-	int error;
+	int ret;
 
 	if (!timespec64_valid(&new_spec64->it_interval) ||
 	    !timespec64_valid(&new_spec64->it_value))
@@ -895,29 +888,36 @@ static int do_timer_settime(timer_t timer_id, int tmr_flags,
 	if (old_spec64)
 		memset(old_spec64, 0, sizeof(*old_spec64));
 
-	timr = lock_timer(timer_id);
-retry:
-	if (!timr)
-		return -EINVAL;
+	for (;;) {
+		struct k_itimer *timr = lock_timer(timer_id);
 
-	if (old_spec64)
-		old_spec64->it_interval = ktime_to_timespec64(timr->it_interval);
+		if (!timr)
+			return -EINVAL;
+
+		if (old_spec64)
+			old_spec64->it_interval = ktime_to_timespec64(timr->it_interval);
 
-	/* Prevent signal delivery and rearming. */
-	timr->it_signal_seq++;
+		/* Prevent signal delivery and rearming. */
+		timr->it_signal_seq++;
 
-	error = timr->kclock->timer_set(timr, tmr_flags, new_spec64, old_spec64);
+		ret = timr->kclock->timer_set(timr, tmr_flags, new_spec64, old_spec64);
+		if (ret != TIMER_RETRY) {
+			unlock_timer(timr);
+			break;
+		}
 
-	if (error == TIMER_RETRY) {
-		// We already got the old time...
+		/* Read the old time only once */
 		old_spec64 = NULL;
-		/* Unlocks and relocks the timer if it still exists */
-		timr = timer_wait_running(timr);
-		goto retry;
+		/* Protect the timer from being freed after the lock is dropped */
+		guard(rcu)();
+		unlock_timer(timr);
+		/*
+		 * timer_wait_running() might drop RCU read side protection
+		 * so the timer has to be looked up again!
+		 */
+		timer_wait_running(timr);
 	}
-	unlock_timer(timr);
-
-	return error;
+	return ret;
 }
 
 /* Set a POSIX.1b interval timer */
@@ -988,90 +988,56 @@ static inline void posix_timer_cleanup_ignored(struct k_itimer *tmr)
 	}
 }
 
-/* Delete a POSIX.1b interval timer. */
-SYSCALL_DEFINE1(timer_delete, timer_t, timer_id)
+static void posix_timer_delete(struct k_itimer *timer)
 {
-	struct k_itimer *timer = lock_timer(timer_id);
-
-retry_delete:
-	if (!timer)
-		return -EINVAL;
-
-	/* Prevent signal delivery and rearming. */
+	/*
+	 * Invalidate the timer, remove it from the linked list and remove
+	 * it from the ignored list if pending.
+	 *
+	 * The invalidation must be written with siglock held so that the
+	 * signal code observes the invalidated timer::it_signal in
+	 * do_sigaction(), which prevents it from moving a pending signal
+	 * of a deleted timer to the ignore list.
+	 *
+	 * The invalidation also prevents signal queueing, signal delivery
+	 * and therefore rearming from the signal delivery path.
+	 *
+	 * A concurrent lookup can still find the timer in the hash, but it
+	 * will check timer::it_signal with timer::it_lock held and observe
+	 * bit 0 set, which invalidates it. That also prevents the timer ID
+	 * from being handed out before this timer is completely gone.
+	 */
 	timer->it_signal_seq++;
 
-	if (unlikely(timer->kclock->timer_del(timer) == TIMER_RETRY)) {
-		/* Unlocks and relocks the timer if it still exists */
-		timer = timer_wait_running(timer);
-		goto retry_delete;
-	}
-
 	scoped_guard (spinlock, &current->sighand->siglock) {
+		unsigned long sig = (unsigned long)timer->it_signal | 1UL;
+
+		WRITE_ONCE(timer->it_signal, (struct signal_struct *)sig);
 		hlist_del(&timer->list);
 		posix_timer_cleanup_ignored(timer);
-		/*
-		 * A concurrent lookup could check timer::it_signal lockless. It
-		 * will reevaluate with timer::it_lock held and observe the NULL.
-		 *
-		 * It must be written with siglock held so that the signal code
-		 * observes timer->it_signal == NULL in do_sigaction(SIG_IGN),
-		 * which prevents it from moving a pending signal of a deleted
-		 * timer to the ignore list.
-		 */
-		WRITE_ONCE(timer->it_signal, NULL);
 	}
 
-	unlock_timer(timer);
-	posix_timer_unhash_and_free(timer);
-	return 0;
+	while (timer->kclock->timer_del(timer) == TIMER_RETRY) {
+		guard(rcu)();
+		spin_unlock_irq(&timer->it_lock);
+		timer_wait_running(timer);
+		spin_lock_irq(&timer->it_lock);
+	}
 }
 
-/*
- * Delete a timer if it is armed, remove it from the hash and schedule it
- * for RCU freeing.
- */
-static void itimer_delete(struct k_itimer *timer)
+/* Delete a POSIX.1b interval timer. */
+SYSCALL_DEFINE1(timer_delete, timer_t, timer_id)
 {
-	spin_lock_irq(&timer->it_lock);
-
-retry_delete:
-	/*
-	 * Even if the timer is not longer accessible from other tasks
-	 * it still might be armed and queued in the underlying timer
-	 * mechanism. Worse, that timer mechanism might run the expiry
-	 * function concurrently.
-	 */
-	if (timer->kclock->timer_del(timer) == TIMER_RETRY) {
-		/*
-		 * Timer is expired concurrently, prevent livelocks
-		 * and pointless spinning on RT.
-		 *
-		 * timer_wait_running() drops timer::it_lock, which opens
-		 * the possibility for another task to delete the timer.
-		 *
-		 * That's not possible here because this is invoked from
-		 * do_exit() only for the last thread of the thread group.
-		 * So no other task can access and delete that timer.
-		 */
-		if (WARN_ON_ONCE(timer_wait_running(timer) != timer))
-			return;
-
-		goto retry_delete;
-	}
-	hlist_del(&timer->list);
-
-	posix_timer_cleanup_ignored(timer);
+	struct k_itimer *timer = lock_timer(timer_id);
 
-	/*
-	 * Setting timer::it_signal to NULL is technically not required
-	 * here as nothing can access the timer anymore legitimately via
-	 * the hash table. Set it to NULL nevertheless so that all deletion
-	 * paths are consistent.
-	 */
-	WRITE_ONCE(timer->it_signal, NULL);
+	if (!timer)
+		return -EINVAL;
 
-	spin_unlock_irq(&timer->it_lock);
+	posix_timer_delete(timer);
+	unlock_timer(timer);
+	/* Remove it from the hash, which frees up the timer ID */
 	posix_timer_unhash_and_free(timer);
+	return 0;
 }
 
 /*
@@ -1082,6 +1048,8 @@ retry_delete:
 void exit_itimers(struct task_struct *tsk)
 {
 	struct hlist_head timers;
+	struct hlist_node *next;
+	struct k_itimer *timer;
 
 	if (hlist_empty(&tsk->signal->posix_timers))
 		return;
@@ -1091,8 +1059,10 @@ void exit_itimers(struct task_struct *tsk)
 		hlist_move_list(&tsk->signal->posix_timers, &timers);
 
 	/* The timers are not longer accessible via tsk::signal */
-	while (!hlist_empty(&timers)) {
-		itimer_delete(hlist_entry(timers.first, struct k_itimer, list));
+	hlist_for_each_entry_safe(timer, next, &timers, list) {
+		scoped_guard (spinlock_irq, &timer->it_lock)
+			posix_timer_delete(timer);
+		posix_timer_unhash_and_free(timer);
 		cond_resched();
 	}
 

