Return-Path: <linux-tip-commits+bounces-4067-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E964BA57697
	for <lists+linux-tip-commits@lfdr.de>; Sat,  8 Mar 2025 01:09:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E7EFE3B6A6B
	for <lists+linux-tip-commits@lfdr.de>; Sat,  8 Mar 2025 00:09:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C3D310F4;
	Sat,  8 Mar 2025 00:08:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="TcCXxPXK";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="9iCQkvyO"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53C1D82D98;
	Sat,  8 Mar 2025 00:08:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741392497; cv=none; b=KC+Zl1ya9jyMDmFOOTpadRqjIVSUoWoD/TO/vrw5Vpn8c5FLCRAKC3aEe3jvddvxZ8yHBfVPNkknO0FGou57COJ6mWXwUFxUElP6a0pdzMhfzz80+UwqC+XMlYwVjuYeOM50+Vrzos33PhJtF+vu/cIBCD23tGMOR3HGUjfUVBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741392497; c=relaxed/simple;
	bh=PlW28mI10vPuIAfVg6KF77ZaO0yao6nzu3NXETomr3s=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=uiEuiIuZpPU7ok6WS+fPnS8AJsdyfctKZYytYWilK78IJ5WdaN6RQM+OpJLqKNwNIjhnsyRXMQSAkxO7LHyN6Vl+GtqDHx26OqaHFFCtb4K0ZUGb6ZF/Xp3F0SP62WzrvhUNeRuP69BZ0fkj0C9T5v+oer0DWWG0J5lq0qctwI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=TcCXxPXK; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=9iCQkvyO; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sat, 08 Mar 2025 00:08:07 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1741392493;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=niRO7dlC9J1/iMo3kUhkJuAbkTO4PuOFj14SweFrT0I=;
	b=TcCXxPXKdEv5PLMm6OhkHYGfgQTikXdN5ZtnBXsxlkZUterYYt8ZWgKf0ciZzc+NBYb8gV
	r6skOTFeyDo3BhWlWni0PgKKng9ibNudifY7I7+uC0nM0VAh02g7XyrPBXq5uNeq86bInW
	FdasTSeuaxKW+JLBzGH7OKYK5dYHuOLyJdcUwL6hSsAuA0Het5KL1eW8zngndQS7lwX3rC
	tp+qnnZtAiIA0IpZQj2FFnR+zg+Fh14cANC6LaFvGv7J34UG571Emt+4HYcgegkwE6Mix+
	qcVgSsrwcfgxJyos5yvjno/IRATmqcYkbySrMw2YKQFlEe4AcAVlohly6yGYiw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1741392493;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=niRO7dlC9J1/iMo3kUhkJuAbkTO4PuOFj14SweFrT0I=;
	b=9iCQkvyOgVdni1GwP3uJIeluwd6guEgQsBIfheenCbXhizpXqq6sNdd42ZnLCO5O3lm4c6
	yzqMCq4s/u/T3/Ag==
From: "tip-bot2 for Waiman Long" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] locking/lock_events: Add locking events for
 rtmutex slow paths
Cc: Waiman Long <longman@redhat.com>, Boqun Feng <boqun.feng@gmail.com>,
 Ingo Molnar <mingo@kernel.org>, x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250307232717.1759087-4-boqun.feng@gmail.com>
References: <20250307232717.1759087-4-boqun.feng@gmail.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174139249256.14745.17990965280661455686.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     b76b44fb656100fcd8482d9102d35d1b6a5129e9
Gitweb:        https://git.kernel.org/tip/b76b44fb656100fcd8482d9102d35d1b6a5129e9
Author:        Waiman Long <longman@redhat.com>
AuthorDate:    Fri, 07 Mar 2025 15:26:53 -08:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Sat, 08 Mar 2025 00:55:03 +01:00

locking/lock_events: Add locking events for rtmutex slow paths

Add locking events for rtlock_slowlock() and rt_mutex_slowlock() for
profiling the slow path behavior of rt_spin_lock() and rt_mutex_lock().

Signed-off-by: Waiman Long <longman@redhat.com>
Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/20250307232717.1759087-4-boqun.feng@gmail.com
---
 kernel/locking/lock_events_list.h | 21 +++++++++++++++++++++
 kernel/locking/rtmutex.c          | 29 ++++++++++++++++++++++++-----
 2 files changed, 45 insertions(+), 5 deletions(-)

diff --git a/kernel/locking/lock_events_list.h b/kernel/locking/lock_events_list.h
index 97fb6f3..80b11f1 100644
--- a/kernel/locking/lock_events_list.h
+++ b/kernel/locking/lock_events_list.h
@@ -67,3 +67,24 @@ LOCK_EVENT(rwsem_rlock_handoff)	/* # of read lock handoffs		*/
 LOCK_EVENT(rwsem_wlock)		/* # of write locks acquired		*/
 LOCK_EVENT(rwsem_wlock_fail)	/* # of failed write lock acquisitions	*/
 LOCK_EVENT(rwsem_wlock_handoff)	/* # of write lock handoffs		*/
+
+/*
+ * Locking events for rtlock_slowlock()
+ */
+LOCK_EVENT(rtlock_slowlock)	/* # of rtlock_slowlock() calls		*/
+LOCK_EVENT(rtlock_slow_acq1)	/* # of locks acquired after wait_lock	*/
+LOCK_EVENT(rtlock_slow_acq2)	/* # of locks acquired in for loop	*/
+LOCK_EVENT(rtlock_slow_sleep)	/* # of sleeps				*/
+LOCK_EVENT(rtlock_slow_wake)	/* # of wakeup's			*/
+
+/*
+ * Locking events for rt_mutex_slowlock()
+ */
+LOCK_EVENT(rtmutex_slowlock)	/* # of rt_mutex_slowlock() calls	*/
+LOCK_EVENT(rtmutex_slow_block)	/* # of rt_mutex_slowlock_block() calls	*/
+LOCK_EVENT(rtmutex_slow_acq1)	/* # of locks acquired after wait_lock	*/
+LOCK_EVENT(rtmutex_slow_acq2)	/* # of locks acquired at the end	*/
+LOCK_EVENT(rtmutex_slow_acq3)	/* # of locks acquired in *block()	*/
+LOCK_EVENT(rtmutex_slow_sleep)	/* # of sleeps				*/
+LOCK_EVENT(rtmutex_slow_wake)	/* # of wakeup's			*/
+LOCK_EVENT(rtmutex_deadlock)	/* # of rt_mutex_handle_deadlock()'s	*/
diff --git a/kernel/locking/rtmutex.c b/kernel/locking/rtmutex.c
index 4a8df18..c80902e 100644
--- a/kernel/locking/rtmutex.c
+++ b/kernel/locking/rtmutex.c
@@ -27,6 +27,7 @@
 #include <trace/events/lock.h>
 
 #include "rtmutex_common.h"
+#include "lock_events.h"
 
 #ifndef WW_RT
 # define build_ww_mutex()	(false)
@@ -1612,10 +1613,13 @@ static int __sched rt_mutex_slowlock_block(struct rt_mutex_base *lock,
 	struct task_struct *owner;
 	int ret = 0;
 
+	lockevent_inc(rtmutex_slow_block);
 	for (;;) {
 		/* Try to acquire the lock: */
-		if (try_to_take_rt_mutex(lock, current, waiter))
+		if (try_to_take_rt_mutex(lock, current, waiter)) {
+			lockevent_inc(rtmutex_slow_acq3);
 			break;
+		}
 
 		if (timeout && !timeout->task) {
 			ret = -ETIMEDOUT;
@@ -1638,8 +1642,10 @@ static int __sched rt_mutex_slowlock_block(struct rt_mutex_base *lock,
 			owner = NULL;
 		raw_spin_unlock_irq_wake(&lock->wait_lock, wake_q);
 
-		if (!owner || !rtmutex_spin_on_owner(lock, waiter, owner))
+		if (!owner || !rtmutex_spin_on_owner(lock, waiter, owner)) {
+			lockevent_inc(rtmutex_slow_sleep);
 			rt_mutex_schedule();
+		}
 
 		raw_spin_lock_irq(&lock->wait_lock);
 		set_current_state(state);
@@ -1694,6 +1700,7 @@ static int __sched __rt_mutex_slowlock(struct rt_mutex_base *lock,
 	int ret;
 
 	lockdep_assert_held(&lock->wait_lock);
+	lockevent_inc(rtmutex_slowlock);
 
 	/* Try to acquire the lock again: */
 	if (try_to_take_rt_mutex(lock, current, NULL)) {
@@ -1701,6 +1708,7 @@ static int __sched __rt_mutex_slowlock(struct rt_mutex_base *lock,
 			__ww_mutex_check_waiters(rtm, ww_ctx, wake_q);
 			ww_mutex_lock_acquired(ww, ww_ctx);
 		}
+		lockevent_inc(rtmutex_slow_acq1);
 		return 0;
 	}
 
@@ -1719,10 +1727,12 @@ static int __sched __rt_mutex_slowlock(struct rt_mutex_base *lock,
 				__ww_mutex_check_waiters(rtm, ww_ctx, wake_q);
 			ww_mutex_lock_acquired(ww, ww_ctx);
 		}
+		lockevent_inc(rtmutex_slow_acq2);
 	} else {
 		__set_current_state(TASK_RUNNING);
 		remove_waiter(lock, waiter);
 		rt_mutex_handle_deadlock(ret, chwalk, lock, waiter);
+		lockevent_inc(rtmutex_deadlock);
 	}
 
 	/*
@@ -1751,6 +1761,7 @@ static inline int __rt_mutex_slowlock_locked(struct rt_mutex_base *lock,
 				  &waiter, wake_q);
 
 	debug_rt_mutex_free_waiter(&waiter);
+	lockevent_cond_inc(rtmutex_slow_wake, !wake_q_empty(wake_q));
 	return ret;
 }
 
@@ -1823,9 +1834,12 @@ static void __sched rtlock_slowlock_locked(struct rt_mutex_base *lock,
 	struct task_struct *owner;
 
 	lockdep_assert_held(&lock->wait_lock);
+	lockevent_inc(rtlock_slowlock);
 
-	if (try_to_take_rt_mutex(lock, current, NULL))
+	if (try_to_take_rt_mutex(lock, current, NULL)) {
+		lockevent_inc(rtlock_slow_acq1);
 		return;
+	}
 
 	rt_mutex_init_rtlock_waiter(&waiter);
 
@@ -1838,8 +1852,10 @@ static void __sched rtlock_slowlock_locked(struct rt_mutex_base *lock,
 
 	for (;;) {
 		/* Try to acquire the lock again */
-		if (try_to_take_rt_mutex(lock, current, &waiter))
+		if (try_to_take_rt_mutex(lock, current, &waiter)) {
+			lockevent_inc(rtlock_slow_acq2);
 			break;
+		}
 
 		if (&waiter == rt_mutex_top_waiter(lock))
 			owner = rt_mutex_owner(lock);
@@ -1847,8 +1863,10 @@ static void __sched rtlock_slowlock_locked(struct rt_mutex_base *lock,
 			owner = NULL;
 		raw_spin_unlock_irq_wake(&lock->wait_lock, wake_q);
 
-		if (!owner || !rtmutex_spin_on_owner(lock, &waiter, owner))
+		if (!owner || !rtmutex_spin_on_owner(lock, &waiter, owner)) {
+			lockevent_inc(rtlock_slow_sleep);
 			schedule_rtlock();
+		}
 
 		raw_spin_lock_irq(&lock->wait_lock);
 		set_current_state(TASK_RTLOCK_WAIT);
@@ -1865,6 +1883,7 @@ static void __sched rtlock_slowlock_locked(struct rt_mutex_base *lock,
 	debug_rt_mutex_free_waiter(&waiter);
 
 	trace_contention_end(lock, 0);
+	lockevent_cond_inc(rtlock_slow_wake, !wake_q_empty(wake_q));
 }
 
 static __always_inline void __sched rtlock_slowlock(struct rt_mutex_base *lock)

