Return-Path: <linux-tip-commits+bounces-3123-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E6EE9FC15C
	for <lists+linux-tip-commits@lfdr.de>; Tue, 24 Dec 2024 19:53:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B184C1883B5B
	for <lists+linux-tip-commits@lfdr.de>; Tue, 24 Dec 2024 18:53:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F3FE212D64;
	Tue, 24 Dec 2024 18:53:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="KUpui7T+";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="+dZ0j6ow"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49E131465B4;
	Tue, 24 Dec 2024 18:53:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735066424; cv=none; b=hiZSyaaamZwE2LCGBYB1yO2EAYNV9Py4SEpsScFflWNAG9wOL7xVHUDMQTZ3j8869j7B4n51xfY99kOiHt1Vv4ZNrpzOeZssQsA4GwlzmSA9bknI1N/+hY4TjUQ5TZ/24+gOjzTrtBv1l9tWxSHKYEwlMcAoerDC9AMciPw0tcg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735066424; c=relaxed/simple;
	bh=ou1l91o0U4Brr2CamL61MdJ+lbSINfBdCEzPbkOsGa0=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=ZOaJW0+QcyircYrPsqoTlLfAcfTWJA59Eo1ZYQxt92DHayjkeo4l6Clzs8BoPZ3nwqyfuvriimaRAcCRqJ0CwkoCp1fMjXn5+l5jxtUIs2+AB0imDflRBbL/k4ve5XAQUIfEX4t8bASUzcHKAXvEfDxQjMFA2txVT4ucPYefbUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=KUpui7T+; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=+dZ0j6ow; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 24 Dec 2024 18:53:36 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1735066419;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pzqhIW9ogf48ZjaQNToeFRAF37Ygnn/PCkEWl1NcUmw=;
	b=KUpui7T+Gtn56qWxxWKqiipcIQ6u+o6BC1Cg4b/bicC6bLro4nlV7uDPbJXAJu3Pv9O5XR
	dHYdNPZx43nnMagAD1tbFzrXRD23zuYXgeLTiRmNFLNe/LAZ/k+RTaB+TuLfv8hOv8iAQS
	l4z7JmSdTpF0FLMXodgL3AcmZDNNqay3vnLVSPJ7XTCOT5ea3o5Kuir4JPStU0Z08DVYXM
	v5Vv42GCeO3Rwbs0szt+Uwzu4I9F70gVh6wEC4y61GdJHoxHg9RXp9lWgxolqXqOcq0D2P
	XvuIsbwRDG/CS2O80g+TN/Yuxylb9eisDXeoL6tHpKLN+KIUMUb3sc+XlFc2Qg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1735066419;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pzqhIW9ogf48ZjaQNToeFRAF37Ygnn/PCkEWl1NcUmw=;
	b=+dZ0j6owKRhABXvQuHNENyErSHKem5RyWl2Et1ael9rtLo0iVAwYsi3GwAYuayCTEdN5n5
	GsKRPT2e2xfffhAg==
From: "tip-bot2 for John Stultz" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] sched/wake_q: Add helper to call wake_up_q after
 unlock with preemption disabled
Cc: Peter Zijlstra <peterz@infradead.org>, John Stultz <jstultz@google.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20241217040803.243420-1-jstultz@google.com>
References: <20241217040803.243420-1-jstultz@google.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173506641702.399.12574915584410501304.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     abfdccd6af2b071951633e57d6322c46a1ea791f
Gitweb:        https://git.kernel.org/tip/abfdccd6af2b071951633e57d6322c46a1ea791f
Author:        John Stultz <jstultz@google.com>
AuthorDate:    Mon, 16 Dec 2024 20:07:35 -08:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 20 Dec 2024 15:31:21 +01:00

sched/wake_q: Add helper to call wake_up_q after unlock with preemption disabled

A common pattern seen when wake_qs are used to defer a wakeup
until after a lock is released is something like:
  preempt_disable();
  raw_spin_unlock(lock);
  wake_up_q(wake_q);
  preempt_enable();

So create some raw_spin_unlock*_wake() helper functions to clean
this up.

Applies on top of the fix I submitted here:
 https://lore.kernel.org/lkml/20241212222138.2400498-1-jstultz@google.com/

NOTE: I recognise the unlock()/unlock_irq()/unlock_irqrestore()
variants creates its own duplication, which we could use a macro
to generate the similar functions, but I often dislike how those
generation macros making finding the actual implementation
harder, so I left the three functions as is. If folks would
prefer otherwise, let me know and I'll switch it.

Suggested-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: John Stultz <jstultz@google.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20241217040803.243420-1-jstultz@google.com
---
 include/linux/sched/wake_q.h | 34 ++++++++++++++++++++++++++++++++++
 kernel/futex/pi.c            |  5 +----
 kernel/locking/mutex.c       | 16 ++++------------
 kernel/locking/rtmutex.c     | 32 +++++---------------------------
 4 files changed, 44 insertions(+), 43 deletions(-)

diff --git a/include/linux/sched/wake_q.h b/include/linux/sched/wake_q.h
index 06cd8fb..0f28b46 100644
--- a/include/linux/sched/wake_q.h
+++ b/include/linux/sched/wake_q.h
@@ -63,4 +63,38 @@ extern void wake_q_add(struct wake_q_head *head, struct task_struct *task);
 extern void wake_q_add_safe(struct wake_q_head *head, struct task_struct *task);
 extern void wake_up_q(struct wake_q_head *head);
 
+/* Spin unlock helpers to unlock and call wake_up_q with preempt disabled */
+static inline
+void raw_spin_unlock_wake(raw_spinlock_t *lock, struct wake_q_head *wake_q)
+{
+	guard(preempt)();
+	raw_spin_unlock(lock);
+	if (wake_q) {
+		wake_up_q(wake_q);
+		wake_q_init(wake_q);
+	}
+}
+
+static inline
+void raw_spin_unlock_irq_wake(raw_spinlock_t *lock, struct wake_q_head *wake_q)
+{
+	guard(preempt)();
+	raw_spin_unlock_irq(lock);
+	if (wake_q) {
+		wake_up_q(wake_q);
+		wake_q_init(wake_q);
+	}
+}
+
+static inline
+void raw_spin_unlock_irqrestore_wake(raw_spinlock_t *lock, unsigned long flags,
+				     struct wake_q_head *wake_q)
+{
+	guard(preempt)();
+	raw_spin_unlock_irqrestore(lock, flags);
+	if (wake_q) {
+		wake_up_q(wake_q);
+		wake_q_init(wake_q);
+	}
+}
 #endif /* _LINUX_SCHED_WAKE_Q_H */
diff --git a/kernel/futex/pi.c b/kernel/futex/pi.c
index d62cca5..daea650 100644
--- a/kernel/futex/pi.c
+++ b/kernel/futex/pi.c
@@ -1020,10 +1020,7 @@ retry_private:
 	 * it sees the futex_q::pi_state.
 	 */
 	ret = __rt_mutex_start_proxy_lock(&q.pi_state->pi_mutex, &rt_waiter, current, &wake_q);
-	preempt_disable();
-	raw_spin_unlock_irq(&q.pi_state->pi_mutex.wait_lock);
-	wake_up_q(&wake_q);
-	preempt_enable();
+	raw_spin_unlock_irq_wake(&q.pi_state->pi_mutex.wait_lock, &wake_q);
 
 	if (ret) {
 		if (ret == 1)
diff --git a/kernel/locking/mutex.c b/kernel/locking/mutex.c
index 3302e52..b36f23d 100644
--- a/kernel/locking/mutex.c
+++ b/kernel/locking/mutex.c
@@ -657,10 +657,7 @@ __mutex_lock_common(struct mutex *lock, unsigned int state, unsigned int subclas
 				goto err;
 		}
 
-		raw_spin_unlock_irqrestore(&lock->wait_lock, flags);
-		/* Make sure we do wakeups before calling schedule */
-		wake_up_q(&wake_q);
-		wake_q_init(&wake_q);
+		raw_spin_unlock_irqrestore_wake(&lock->wait_lock, flags, &wake_q);
 
 		schedule_preempt_disabled();
 
@@ -710,8 +707,7 @@ skip_wait:
 	if (ww_ctx)
 		ww_mutex_lock_acquired(ww, ww_ctx);
 
-	raw_spin_unlock_irqrestore(&lock->wait_lock, flags);
-	wake_up_q(&wake_q);
+	raw_spin_unlock_irqrestore_wake(&lock->wait_lock, flags, &wake_q);
 	preempt_enable();
 	return 0;
 
@@ -720,10 +716,9 @@ err:
 	__mutex_remove_waiter(lock, &waiter);
 err_early_kill:
 	trace_contention_end(lock, ret);
-	raw_spin_unlock_irqrestore(&lock->wait_lock, flags);
+	raw_spin_unlock_irqrestore_wake(&lock->wait_lock, flags, &wake_q);
 	debug_mutex_free_waiter(&waiter);
 	mutex_release(&lock->dep_map, ip);
-	wake_up_q(&wake_q);
 	preempt_enable();
 	return ret;
 }
@@ -935,10 +930,7 @@ static noinline void __sched __mutex_unlock_slowpath(struct mutex *lock, unsigne
 	if (owner & MUTEX_FLAG_HANDOFF)
 		__mutex_handoff(lock, next);
 
-	preempt_disable();
-	raw_spin_unlock_irqrestore(&lock->wait_lock, flags);
-	wake_up_q(&wake_q);
-	preempt_enable();
+	raw_spin_unlock_irqrestore_wake(&lock->wait_lock, flags, &wake_q);
 }
 
 #ifndef CONFIG_DEBUG_LOCK_ALLOC
diff --git a/kernel/locking/rtmutex.c b/kernel/locking/rtmutex.c
index 697a56d..4a8df18 100644
--- a/kernel/locking/rtmutex.c
+++ b/kernel/locking/rtmutex.c
@@ -1292,13 +1292,7 @@ static int __sched task_blocks_on_rt_mutex(struct rt_mutex_base *lock,
 	 */
 	get_task_struct(owner);
 
-	preempt_disable();
-	raw_spin_unlock_irq(&lock->wait_lock);
-	/* wake up any tasks on the wake_q before calling rt_mutex_adjust_prio_chain */
-	wake_up_q(wake_q);
-	wake_q_init(wake_q);
-	preempt_enable();
-
+	raw_spin_unlock_irq_wake(&lock->wait_lock, wake_q);
 
 	res = rt_mutex_adjust_prio_chain(owner, chwalk, lock,
 					 next_lock, waiter, task);
@@ -1642,13 +1636,7 @@ static int __sched rt_mutex_slowlock_block(struct rt_mutex_base *lock,
 			owner = rt_mutex_owner(lock);
 		else
 			owner = NULL;
-		preempt_disable();
-		raw_spin_unlock_irq(&lock->wait_lock);
-		if (wake_q) {
-			wake_up_q(wake_q);
-			wake_q_init(wake_q);
-		}
-		preempt_enable();
+		raw_spin_unlock_irq_wake(&lock->wait_lock, wake_q);
 
 		if (!owner || !rtmutex_spin_on_owner(lock, waiter, owner))
 			rt_mutex_schedule();
@@ -1799,10 +1787,7 @@ static int __sched rt_mutex_slowlock(struct rt_mutex_base *lock,
 	 */
 	raw_spin_lock_irqsave(&lock->wait_lock, flags);
 	ret = __rt_mutex_slowlock_locked(lock, ww_ctx, state, &wake_q);
-	preempt_disable();
-	raw_spin_unlock_irqrestore(&lock->wait_lock, flags);
-	wake_up_q(&wake_q);
-	preempt_enable();
+	raw_spin_unlock_irqrestore_wake(&lock->wait_lock, flags, &wake_q);
 	rt_mutex_post_schedule();
 
 	return ret;
@@ -1860,11 +1845,7 @@ static void __sched rtlock_slowlock_locked(struct rt_mutex_base *lock,
 			owner = rt_mutex_owner(lock);
 		else
 			owner = NULL;
-		preempt_disable();
-		raw_spin_unlock_irq(&lock->wait_lock);
-		wake_up_q(wake_q);
-		wake_q_init(wake_q);
-		preempt_enable();
+		raw_spin_unlock_irq_wake(&lock->wait_lock, wake_q);
 
 		if (!owner || !rtmutex_spin_on_owner(lock, &waiter, owner))
 			schedule_rtlock();
@@ -1893,10 +1874,7 @@ static __always_inline void __sched rtlock_slowlock(struct rt_mutex_base *lock)
 
 	raw_spin_lock_irqsave(&lock->wait_lock, flags);
 	rtlock_slowlock_locked(lock, &wake_q);
-	preempt_disable();
-	raw_spin_unlock_irqrestore(&lock->wait_lock, flags);
-	wake_up_q(&wake_q);
-	preempt_enable();
+	raw_spin_unlock_irqrestore_wake(&lock->wait_lock, flags, &wake_q);
 }
 
 #endif /* RT_MUTEX_BUILD_SPINLOCKS */

