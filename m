Return-Path: <linux-tip-commits+bounces-3109-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F2E2F9FBB74
	for <lists+linux-tip-commits@lfdr.de>; Tue, 24 Dec 2024 10:47:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7984E1885B2A
	for <lists+linux-tip-commits@lfdr.de>; Tue, 24 Dec 2024 09:47:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBF051B413B;
	Tue, 24 Dec 2024 09:46:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="3NuAD8bC";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="WHgNEPy7"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF4701B3949;
	Tue, 24 Dec 2024 09:46:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735033613; cv=none; b=FJ2amd4jsvwkmEhPvUR2pAXBnrnP18zdTAlet+dOqZaloQitKNTi0LxBhEY2jE5JNt1JlZdckO4GdDtcMXJRCQMjXp+qyptpk7Qizap9m0GTIT76FYTKoKXQhz8Lzrf2AvrvbvbJRH9JL9IIBRpiK3XHtGLDzAT8z5kAfLIu12c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735033613; c=relaxed/simple;
	bh=NJuwBoVPo3ke/KgYUdVzF6EQXCJSxJTtDn2wQ5/CksY=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=lIGKnYrJZWXxAXujUIVwtiq6oWa306gGC1XCOEeG9Djo0ggDPwEw5s0YDqnq9jfEM3AWwLsEwYyfUmIWTiWlHOBBpBOb1w+l54uqGDJPzYVdo7wNZLArWOryljTBso5I5iGMknavUIOdC5sse2lrQB77diN864kBOWVfBTWlJw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=3NuAD8bC; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=WHgNEPy7; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 24 Dec 2024 09:46:41 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1735033604;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FjPK2onDgEmP92lvX/BxfzQycBxTWx2f+oqnAFagG9U=;
	b=3NuAD8bCBV5Io6R81a9Xf0JGJ7k5q2nQM3jx8J7wbkoTK1bTxsO+oxDa36z13JLeVk+MP+
	mtjCOKogfGultHOPO1DTfcPGKuuKbt9KuXQOJDoCFjsSiBPIw9juGCIAX9l/oBogfH1703
	3tzHhjoSqjqpSBlCxw3G0rk3pG+T4t8oOz5VZNjbHXF1UpbM5ToYPLMe0kAUwIW8HkIzmY
	xrjcx/IqCcMqzcuRRaPrYtn/zq6PluYc8esPTx1DbxRK/OE/jLNE/1ztKGJ/5xv65o8Pmy
	rK+Bpaa/Up9pN3QwN3qQG/uFMMho+zG1ND96V2S2N9CmgQauJ37jxBFwvJCvmQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1735033604;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FjPK2onDgEmP92lvX/BxfzQycBxTWx2f+oqnAFagG9U=;
	b=WHgNEPy7fxeC+CPO2e/1USnlRmiJ01hABVIDYHG1+eFBF5uOrQDFavduzVvSq49BBC9enO
	pIYvYUtDoxc5gWAA==
From: "tip-bot2 for John Stultz" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: locking/urgent] locking/rtmutex: Make sure we wake anything on
 the wake_q when we release the lock->wait_lock
Cc: Bert Karwatzki <spasswolf@web.de>, John Stultz <jstultz@google.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20241212222138.2400498-1-jstultz@google.com>
References: <20241212222138.2400498-1-jstultz@google.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173503360180.399.450981967535555533.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the locking/urgent branch of tip:

Commit-ID:     4a077914578183ec397ad09f7156a357e00e5d72
Gitweb:        https://git.kernel.org/tip/4a077914578183ec397ad09f7156a357e00e5d72
Author:        John Stultz <jstultz@google.com>
AuthorDate:    Thu, 12 Dec 2024 14:21:33 -08:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 17 Dec 2024 17:47:24 +01:00

locking/rtmutex: Make sure we wake anything on the wake_q when we release the lock->wait_lock

Bert reported seeing occasional boot hangs when running with
PREEPT_RT and bisected it down to commit 894d1b3db41c
("locking/mutex: Remove wakeups from under mutex::wait_lock").

It looks like I missed a few spots where we drop the wait_lock and
potentially call into schedule without waking up the tasks on the
wake_q structure. Since the tasks being woken are ww_mutex tasks
they need to be able to run to release the mutex and unblock the
task that currently is planning to wake them. Thus we can deadlock.

So make sure we wake the wake_q tasks when we unlock the wait_lock.

Closes: https://lore.kernel.org/lkml/20241211182502.2915-1-spasswolf@web.de
Fixes: 894d1b3db41c ("locking/mutex: Remove wakeups from under mutex::wait_lock")
Reported-by: Bert Karwatzki <spasswolf@web.de>
Signed-off-by: John Stultz <jstultz@google.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20241212222138.2400498-1-jstultz@google.com
---
 kernel/locking/rtmutex.c     | 18 ++++++++++++++++--
 kernel/locking/rtmutex_api.c |  2 +-
 2 files changed, 17 insertions(+), 3 deletions(-)

diff --git a/kernel/locking/rtmutex.c b/kernel/locking/rtmutex.c
index e858de2..697a56d 100644
--- a/kernel/locking/rtmutex.c
+++ b/kernel/locking/rtmutex.c
@@ -1292,7 +1292,13 @@ static int __sched task_blocks_on_rt_mutex(struct rt_mutex_base *lock,
 	 */
 	get_task_struct(owner);
 
+	preempt_disable();
 	raw_spin_unlock_irq(&lock->wait_lock);
+	/* wake up any tasks on the wake_q before calling rt_mutex_adjust_prio_chain */
+	wake_up_q(wake_q);
+	wake_q_init(wake_q);
+	preempt_enable();
+
 
 	res = rt_mutex_adjust_prio_chain(owner, chwalk, lock,
 					 next_lock, waiter, task);
@@ -1596,6 +1602,7 @@ static void __sched remove_waiter(struct rt_mutex_base *lock,
  *			 or TASK_UNINTERRUPTIBLE)
  * @timeout:		 the pre-initialized and started timer, or NULL for none
  * @waiter:		 the pre-initialized rt_mutex_waiter
+ * @wake_q:		 wake_q of tasks to wake when we drop the lock->wait_lock
  *
  * Must be called with lock->wait_lock held and interrupts disabled
  */
@@ -1603,7 +1610,8 @@ static int __sched rt_mutex_slowlock_block(struct rt_mutex_base *lock,
 					   struct ww_acquire_ctx *ww_ctx,
 					   unsigned int state,
 					   struct hrtimer_sleeper *timeout,
-					   struct rt_mutex_waiter *waiter)
+					   struct rt_mutex_waiter *waiter,
+					   struct wake_q_head *wake_q)
 	__releases(&lock->wait_lock) __acquires(&lock->wait_lock)
 {
 	struct rt_mutex *rtm = container_of(lock, struct rt_mutex, rtmutex);
@@ -1634,7 +1642,13 @@ static int __sched rt_mutex_slowlock_block(struct rt_mutex_base *lock,
 			owner = rt_mutex_owner(lock);
 		else
 			owner = NULL;
+		preempt_disable();
 		raw_spin_unlock_irq(&lock->wait_lock);
+		if (wake_q) {
+			wake_up_q(wake_q);
+			wake_q_init(wake_q);
+		}
+		preempt_enable();
 
 		if (!owner || !rtmutex_spin_on_owner(lock, waiter, owner))
 			rt_mutex_schedule();
@@ -1708,7 +1722,7 @@ static int __sched __rt_mutex_slowlock(struct rt_mutex_base *lock,
 
 	ret = task_blocks_on_rt_mutex(lock, waiter, current, ww_ctx, chwalk, wake_q);
 	if (likely(!ret))
-		ret = rt_mutex_slowlock_block(lock, ww_ctx, state, NULL, waiter);
+		ret = rt_mutex_slowlock_block(lock, ww_ctx, state, NULL, waiter, wake_q);
 
 	if (likely(!ret)) {
 		/* acquired the lock */
diff --git a/kernel/locking/rtmutex_api.c b/kernel/locking/rtmutex_api.c
index 33ea31d..191e472 100644
--- a/kernel/locking/rtmutex_api.c
+++ b/kernel/locking/rtmutex_api.c
@@ -383,7 +383,7 @@ int __sched rt_mutex_wait_proxy_lock(struct rt_mutex_base *lock,
 	raw_spin_lock_irq(&lock->wait_lock);
 	/* sleep on the mutex */
 	set_current_state(TASK_INTERRUPTIBLE);
-	ret = rt_mutex_slowlock_block(lock, NULL, TASK_INTERRUPTIBLE, to, waiter);
+	ret = rt_mutex_slowlock_block(lock, NULL, TASK_INTERRUPTIBLE, to, waiter, NULL);
 	/*
 	 * try_to_take_rt_mutex() sets the waiter bit unconditionally. We might
 	 * have to fix that up.

