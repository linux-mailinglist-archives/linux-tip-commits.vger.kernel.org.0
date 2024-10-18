Return-Path: <linux-tip-commits+bounces-2514-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A4AD9A36A3
	for <lists+linux-tip-commits@lfdr.de>; Fri, 18 Oct 2024 09:10:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4BA47B22B9C
	for <lists+linux-tip-commits@lfdr.de>; Fri, 18 Oct 2024 07:10:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 690E9188926;
	Fri, 18 Oct 2024 07:07:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="e/STXYmD";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="8w9QBLLS"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48D2C18CC05;
	Fri, 18 Oct 2024 07:07:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729235279; cv=none; b=YKW0gSi9LR2gErKBMh3Hn/5pqcMRXSea8uqKvPrs4m+lLrsLU9vv2bv7tXDvlscrGimz57HcCOnL8f3hH6HGZ0KEUJuHDorRCytC52m+QI7iuBQ0SJ+uVjOtQQUqbFLrzI67lBBaL06Id2XHKvN8YK5dI/SThY5xeebxTAKI3Hw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729235279; c=relaxed/simple;
	bh=+5WQtZkz6yZS96rh0hrb2ub+RyC1kRlbHvI2rqlJmuE=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=Nq8c5herv0v7SQ42hHBQLJr2njeTACLTcRU7pdNONNxWsmuMuFtQT93b6jxss8ylwhGS3uhmX+6iW8R7lSi4Ba4ytAoIDbMjnV83smyvFZKZSTycknRD3tfUQI38u8uSW3Cs2d53zxPBgSKVlZakyfqosQ6zdcozcWr+l5iI+ZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=e/STXYmD; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=8w9QBLLS; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 18 Oct 2024 07:07:43 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1729235264;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PJgfwbgHarwNyInXY+/ttNUNNxpfyyBjlygxriujnyI=;
	b=e/STXYmD48Euwb1jaOzgGTUom72ZpfMoIRjTQnp/rAWqPHJTYPSXQ/rpXQd+iGtUrrZlsH
	8l4y80ScOVNX+1ZR2NssEMTJ9H4YIAoKNRNB8k58+V5R6yOWt6TvdehxjPLK19zVcHs5YO
	PTRe2Ctk0KNBUySkuFzpqopfmiTaz9S8EdWdi5GlhQi3BM5DHuhCngj7ZfiuJBzUg/dzgl
	ExK+4hRj3l45LSaib3kgj72EasFAvJtPsbDySNLIyEK1H7mFuQ/PMutcv+Qj4tYSQguoVs
	xt8ERfBBV48KxWGAUKzfqezGrNa8I3Xz/Ihee/tDR4ku6v4L6wM5dgp4Fdja0g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1729235264;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PJgfwbgHarwNyInXY+/ttNUNNxpfyyBjlygxriujnyI=;
	b=8w9QBLLSxiMx7pkh4vlV3+cQQoR4mpJjSC47MvuYc7Qv54AWkFdHKKAC+63HF9+TqLdKjk
	CPzJb7l+aJZfmsCQ==
From: "tip-bot2 for Juri Lelli" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] locking/mutex: Make mutex::wait_lock irq safe
Cc: Juri Lelli <juri.lelli@redhat.com>, "Connor O'Brien" <connoro@google.com>,
 John Stultz <jstultz@google.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Metin Kaya <metin.kaya@arm.com>, Valentin Schneider <vschneid@redhat.com>,
 K Prateek Nayak <kprateek.nayak@amd.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20241009235352.1614323-3-jstultz@google.com>
References: <20241009235352.1614323-3-jstultz@google.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172923526377.1442.10549503257985449589.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     5ec58525a1f1bd6ca8ea778e9df55cd82bc02e11
Gitweb:        https://git.kernel.org/tip/5ec58525a1f1bd6ca8ea778e9df55cd82bc02e11
Author:        Juri Lelli <juri.lelli@redhat.com>
AuthorDate:    Wed, 09 Oct 2024 16:53:35 -07:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 14 Oct 2024 12:52:40 +02:00

locking/mutex: Make mutex::wait_lock irq safe

With the proxy-execution series, we traverse the task->mutex->task
blocked_on/owner chain in the scheduler core. We do this while holding
the rq::lock to keep the structures in place while taking and
releasing the alternating lock types.

Since the mutex::wait_lock is one of the locks we will take in this
way under the rq::lock in the scheduler core, we need to make sure
that its usage elsewhere is irq safe.

[rebase & fix {un,}lock_wait_lock helpers in ww_mutex.h]
Signed-off-by: Juri Lelli <juri.lelli@redhat.com>
Signed-off-by: Connor O'Brien <connoro@google.com>
Signed-off-by: John Stultz <jstultz@google.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Metin Kaya <metin.kaya@arm.com>
Reviewed-by: Valentin Schneider <vschneid@redhat.com>
Tested-by: K Prateek Nayak <kprateek.nayak@amd.com>
Tested-by: Metin Kaya <metin.kaya@arm.com>
Link: https://lore.kernel.org/r/20241009235352.1614323-3-jstultz@google.com
---
 kernel/locking/mutex.c    | 18 ++++++++++--------
 kernel/locking/ww_mutex.h | 21 +++++++++++----------
 2 files changed, 21 insertions(+), 18 deletions(-)

diff --git a/kernel/locking/mutex.c b/kernel/locking/mutex.c
index 6c94da0..cd248d1 100644
--- a/kernel/locking/mutex.c
+++ b/kernel/locking/mutex.c
@@ -578,6 +578,7 @@ __mutex_lock_common(struct mutex *lock, unsigned int state, unsigned int subclas
 	DEFINE_WAKE_Q(wake_q);
 	struct mutex_waiter waiter;
 	struct ww_mutex *ww;
+	unsigned long flags;
 	int ret;
 
 	if (!use_ww_ctx)
@@ -620,7 +621,7 @@ __mutex_lock_common(struct mutex *lock, unsigned int state, unsigned int subclas
 		return 0;
 	}
 
-	raw_spin_lock(&lock->wait_lock);
+	raw_spin_lock_irqsave(&lock->wait_lock, flags);
 	/*
 	 * After waiting to acquire the wait_lock, try again.
 	 */
@@ -681,7 +682,7 @@ __mutex_lock_common(struct mutex *lock, unsigned int state, unsigned int subclas
 				goto err;
 		}
 
-		raw_spin_unlock(&lock->wait_lock);
+		raw_spin_unlock_irqrestore(&lock->wait_lock, flags);
 		/* Make sure we do wakeups before calling schedule */
 		wake_up_q(&wake_q);
 		wake_q_init(&wake_q);
@@ -706,9 +707,9 @@ __mutex_lock_common(struct mutex *lock, unsigned int state, unsigned int subclas
 			trace_contention_begin(lock, LCB_F_MUTEX);
 		}
 
-		raw_spin_lock(&lock->wait_lock);
+		raw_spin_lock_irqsave(&lock->wait_lock, flags);
 	}
-	raw_spin_lock(&lock->wait_lock);
+	raw_spin_lock_irqsave(&lock->wait_lock, flags);
 acquired:
 	__set_current_state(TASK_RUNNING);
 
@@ -734,7 +735,7 @@ skip_wait:
 	if (ww_ctx)
 		ww_mutex_lock_acquired(ww, ww_ctx);
 
-	raw_spin_unlock(&lock->wait_lock);
+	raw_spin_unlock_irqrestore(&lock->wait_lock, flags);
 	wake_up_q(&wake_q);
 	preempt_enable();
 	return 0;
@@ -744,7 +745,7 @@ err:
 	__mutex_remove_waiter(lock, &waiter);
 err_early_kill:
 	trace_contention_end(lock, ret);
-	raw_spin_unlock(&lock->wait_lock);
+	raw_spin_unlock_irqrestore(&lock->wait_lock, flags);
 	debug_mutex_free_waiter(&waiter);
 	mutex_release(&lock->dep_map, ip);
 	wake_up_q(&wake_q);
@@ -915,6 +916,7 @@ static noinline void __sched __mutex_unlock_slowpath(struct mutex *lock, unsigne
 	struct task_struct *next = NULL;
 	DEFINE_WAKE_Q(wake_q);
 	unsigned long owner;
+	unsigned long flags;
 
 	mutex_release(&lock->dep_map, ip);
 
@@ -941,7 +943,7 @@ static noinline void __sched __mutex_unlock_slowpath(struct mutex *lock, unsigne
 		}
 	}
 
-	raw_spin_lock(&lock->wait_lock);
+	raw_spin_lock_irqsave(&lock->wait_lock, flags);
 	debug_mutex_unlock(lock);
 	if (!list_empty(&lock->wait_list)) {
 		/* get the first entry from the wait-list: */
@@ -959,7 +961,7 @@ static noinline void __sched __mutex_unlock_slowpath(struct mutex *lock, unsigne
 		__mutex_handoff(lock, next);
 
 	preempt_disable();
-	raw_spin_unlock(&lock->wait_lock);
+	raw_spin_unlock_irqrestore(&lock->wait_lock, flags);
 	wake_up_q(&wake_q);
 	preempt_enable();
 }
diff --git a/kernel/locking/ww_mutex.h b/kernel/locking/ww_mutex.h
index a54bd16..37f025a 100644
--- a/kernel/locking/ww_mutex.h
+++ b/kernel/locking/ww_mutex.h
@@ -70,14 +70,14 @@ __ww_mutex_has_waiters(struct mutex *lock)
 	return atomic_long_read(&lock->owner) & MUTEX_FLAG_WAITERS;
 }
 
-static inline void lock_wait_lock(struct mutex *lock)
+static inline void lock_wait_lock(struct mutex *lock, unsigned long *flags)
 {
-	raw_spin_lock(&lock->wait_lock);
+	raw_spin_lock_irqsave(&lock->wait_lock, *flags);
 }
 
-static inline void unlock_wait_lock(struct mutex *lock)
+static inline void unlock_wait_lock(struct mutex *lock, unsigned long *flags)
 {
-	raw_spin_unlock(&lock->wait_lock);
+	raw_spin_unlock_irqrestore(&lock->wait_lock, *flags);
 }
 
 static inline void lockdep_assert_wait_lock_held(struct mutex *lock)
@@ -144,14 +144,14 @@ __ww_mutex_has_waiters(struct rt_mutex *lock)
 	return rt_mutex_has_waiters(&lock->rtmutex);
 }
 
-static inline void lock_wait_lock(struct rt_mutex *lock)
+static inline void lock_wait_lock(struct rt_mutex *lock, unsigned long *flags)
 {
-	raw_spin_lock(&lock->rtmutex.wait_lock);
+	raw_spin_lock_irqsave(&lock->rtmutex.wait_lock, *flags);
 }
 
-static inline void unlock_wait_lock(struct rt_mutex *lock)
+static inline void unlock_wait_lock(struct rt_mutex *lock, unsigned long *flags)
 {
-	raw_spin_unlock(&lock->rtmutex.wait_lock);
+	raw_spin_unlock_irqrestore(&lock->rtmutex.wait_lock, *flags);
 }
 
 static inline void lockdep_assert_wait_lock_held(struct rt_mutex *lock)
@@ -380,6 +380,7 @@ static __always_inline void
 ww_mutex_set_context_fastpath(struct ww_mutex *lock, struct ww_acquire_ctx *ctx)
 {
 	DEFINE_WAKE_Q(wake_q);
+	unsigned long flags;
 
 	ww_mutex_lock_acquired(lock, ctx);
 
@@ -408,10 +409,10 @@ ww_mutex_set_context_fastpath(struct ww_mutex *lock, struct ww_acquire_ctx *ctx)
 	 * Uh oh, we raced in fastpath, check if any of the waiters need to
 	 * die or wound us.
 	 */
-	lock_wait_lock(&lock->base);
+	lock_wait_lock(&lock->base, &flags);
 	__ww_mutex_check_waiters(&lock->base, ctx, &wake_q);
 	preempt_disable();
-	unlock_wait_lock(&lock->base);
+	unlock_wait_lock(&lock->base, &flags);
 	wake_up_q(&wake_q);
 	preempt_enable();
 }

