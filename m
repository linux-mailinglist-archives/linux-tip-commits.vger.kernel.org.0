Return-Path: <linux-tip-commits+bounces-3815-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D980A4CB57
	for <lists+linux-tip-commits@lfdr.de>; Mon,  3 Mar 2025 19:53:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0D2361896FAC
	for <lists+linux-tip-commits@lfdr.de>; Mon,  3 Mar 2025 18:53:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E9D72356CE;
	Mon,  3 Mar 2025 18:52:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="kaIEXpJV";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="2yNk00x4"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94356231C9F;
	Mon,  3 Mar 2025 18:52:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741027928; cv=none; b=l/LEseqjTh7Yt4xmdgr/SQ6B0arUA3kmZneAu9P23dEfKQXRjKEVnaGUkP+X5EAknt6IB8/w66PFD30FU6P+OqJ/XBa3QkO/iXhPQvVqTMOzxgweCrLYRkJo8h8BjBDbNyOV0NM/bS/ajY/T02keFAyfzPAn1IBX97jr40bxuSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741027928; c=relaxed/simple;
	bh=t8ZGMtvi3ck6jbEi322k/AIyxYkAHucyrKBHXDPKGno=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=nbdg4fmYiu4Cbz+FLHlZY1OiXTG2P0l8uSndUmQY8zuqFkNNxPaie5ie1j507705SWHak7xbWSYMyiSwRb5R/FxUfVEMkNj1dQTc5zdFxRzgCA3PttTHlAEhD3tasj0DFdOG2FSRiW3Irfn2qS1+4x2KqbStf1kg5Tn+I/xvS6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=kaIEXpJV; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=2yNk00x4; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 03 Mar 2025 18:51:58 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1741027918;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9smXbEbj131BQFpTQ0auarKL3GP/DKlVuaEo5n3NptU=;
	b=kaIEXpJVNhoXGoQ5bNPXLMokh9O+2Bb3TKyR/cTfYoZcx0fJp+GBGPh66fKscd4jyBfGH8
	4u0Gk5ojfKj0m3AG8t4enIXeqzAsKOiMOAW5abecLMkqKfwBNMfcmUnho4YE/lvEcJm88E
	gSC5weVQsqvQsfNEyjJ18ndAPBgWxrQTBH//RTUIshph05/uCS7A+alBzNvRZ0smoCk4/r
	w6UH61qg72EKYhZDQIrTnojuCMcYavmOwFvjO1x/oX0oqJgNW27HpwC9CQybLsTTBBdABt
	+JZbuy4SkyNAQ0vgUilorqv7YManKJk4AeW/IKvQrK/kmhQKhdAoSmqIWMaTRw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1741027918;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9smXbEbj131BQFpTQ0auarKL3GP/DKlVuaEo5n3NptU=;
	b=2yNk00x4OMWsGvknXlicDRZuaAZzo3sc/RU6GIsBCIeaIleQhxcjrRjMnPvOSICfq5e6yM
	6roB4V+fD7uWQYAQ==
From: "tip-bot2 for Waiman Long" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] locking/lock_events: Add locking events for
 rtmutex slow paths
Cc: Waiman Long <longman@redhat.com>, Boqun Feng <boqun.feng@gmail.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250213200228.1993588-2-longman@redhat.com>
References: <20250213200228.1993588-2-longman@redhat.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174102791812.14745.1659427096378569982.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     9b4070d36399ffcadc92c918bd80da036a16faed
Gitweb:        https://git.kernel.org/tip/9b4070d36399ffcadc92c918bd80da036a16faed
Author:        Waiman Long <longman@redhat.com>
AuthorDate:    Thu, 13 Feb 2025 15:02:25 -05:00
Committer:     Boqun Feng <boqun.feng@gmail.com>
CommitterDate: Sun, 23 Feb 2025 18:24:46 -08:00

locking/lock_events: Add locking events for rtmutex slow paths

Add locking events for rtlock_slowlock() and rt_mutex_slowlock() for
profiling the slow path behavior of rt_spin_lock() and rt_mutex_lock().

Signed-off-by: Waiman Long <longman@redhat.com>
Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
Link: https://lore.kernel.org/r/20250213200228.1993588-2-longman@redhat.com
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

