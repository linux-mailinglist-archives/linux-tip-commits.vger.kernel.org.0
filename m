Return-Path: <linux-tip-commits+bounces-6128-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 98E7DB07336
	for <lists+linux-tip-commits@lfdr.de>; Wed, 16 Jul 2025 12:21:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5EC247B19EA
	for <lists+linux-tip-commits@lfdr.de>; Wed, 16 Jul 2025 10:18:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E76302F4A14;
	Wed, 16 Jul 2025 10:19:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="E8h9Rah7";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="VsLJdlDV"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A15822F431A;
	Wed, 16 Jul 2025 10:19:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752661157; cv=none; b=UxTfghw5BKOCel3vw1h326lr/s9WNFV6xgBYDk3HRSX+3HP3F3+9OTvG8Wp5wy0VN0z3LQsFG+nudXBsX9lgTjktVSrG5MG+frI9HXUDOFIh3ZGVxJs1pRxiV9ASvevadXhTZSDEiU5ai4F4uvIelCNHIwfOz2fTWm7bo6chUl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752661157; c=relaxed/simple;
	bh=ZoplVouQrcqj6qB/CGDRUYoLsJSX5/f5VD4pVUtMoYw=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=VOvPyhcMm9R4FLCKFztiGNVePM7YqkN8dM4e6qc8c5S58HBJ03u+SBo7twoqBjfsCHUUVt5jU1bR/ZLYk75KreuMWJLDZY9/tG3FjGyHrx5YGWtvTDlDn+kF0CJVkhLHUQBjYDB5jAFBCJYDk00398najXYN/9zcTr7jEX3V6QE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=E8h9Rah7; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=VsLJdlDV; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 16 Jul 2025 10:19:12 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1752661153;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pM6+aWQCsvBUgySckVqZnlKJiiNqXkWki9FpKV0GwIo=;
	b=E8h9Rah7/mPl09RJeSS3/9e7qDrsHoDr6edpvwE4u120PrBZbZ0Cr/RnPc2rPZzlViW4AU
	fSt8W0SIqjaBPeTRjRjstFbdQ4w2NV8JMR1nz0rB5ADRoJWTPePU3aPIMXKe2q4Zuzf5Ak
	2m6fnYmFcPlJwszhucfVIVt7YR64/QAU/0L434XzglWSzealJigSkd676erDEjto+F3yfS
	q6GTLFAcwkSw7/Ua/VIeml5G6j9jhui3sD6LVF8DmpwvIyD2FGkK5ONmjw1wWenw58EC+C
	+o3dzN/sCYkwDAP/G5VerGD0rrR6CvWlQ6KE/AuVtOXjAcd17vndHU9cTgsfOQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1752661153;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pM6+aWQCsvBUgySckVqZnlKJiiNqXkWki9FpKV0GwIo=;
	b=VsLJdlDVT/xZcZYGEQHMQQRviCPRQ6ECPIUFPkfDj+te8XE4g9rm12EXR3rDG91DXd44yQ
	Lw7uOapspuXzUlCw==
From: "tip-bot2 for Valentin Schneider" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] locking/mutex: Add p->blocked_on wrappers for
 correctness checks
Cc: Valentin Schneider <valentin.schneider@arm.com>,
 "Connor O'Brien" <connoro@google.com>, John Stultz <jstultz@google.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 K Prateek Nayak <kprateek.nayak@amd.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250712033407.2383110-4-jstultz@google.com>
References: <20250712033407.2383110-4-jstultz@google.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175266115250.406.12016106761236893763.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     a4f0b6fef4b08e9928449206390133e48ac185a7
Gitweb:        https://git.kernel.org/tip/a4f0b6fef4b08e9928449206390133e48ac185a7
Author:        Valentin Schneider <valentin.schneider@arm.com>
AuthorDate:    Sat, 12 Jul 2025 03:33:44 
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 14 Jul 2025 17:16:32 +02:00

locking/mutex: Add p->blocked_on wrappers for correctness checks

This lets us assert mutex::wait_lock is held whenever we access
p->blocked_on, as well as warn us for unexpected state changes.

[fix conflicts, call in more places]
[jstultz: tweaked commit subject, reworked a good bit]
Signed-off-by: Valentin Schneider <valentin.schneider@arm.com>
Signed-off-by: Connor O'Brien <connoro@google.com>
Signed-off-by: John Stultz <jstultz@google.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Tested-by: K Prateek Nayak <kprateek.nayak@amd.com>
Link: https://lkml.kernel.org/r/20250712033407.2383110-4-jstultz@google.com
---
 include/linux/sched.h        | 64 +++++++++++++++++++++++++++++++++--
 kernel/locking/mutex-debug.c |  4 +-
 kernel/locking/mutex.c       | 32 +++++++-----------
 kernel/locking/ww_mutex.h    |  8 +---
 4 files changed, 81 insertions(+), 27 deletions(-)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index 33ad240..5b4e1cd 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -34,6 +34,7 @@
 #include <linux/sched/prio.h>
 #include <linux/sched/types.h>
 #include <linux/signal_types.h>
+#include <linux/spinlock.h>
 #include <linux/syscall_user_dispatch_types.h>
 #include <linux/mm_types_task.h>
 #include <linux/netdevice_xmit.h>
@@ -2129,6 +2130,67 @@ extern int __cond_resched_rwlock_write(rwlock_t *lock);
 	__cond_resched_rwlock_write(lock);					\
 })
 
+#ifndef CONFIG_PREEMPT_RT
+static inline struct mutex *__get_task_blocked_on(struct task_struct *p)
+{
+	struct mutex *m = p->blocked_on;
+
+	if (m)
+		lockdep_assert_held_once(&m->wait_lock);
+	return m;
+}
+
+static inline void __set_task_blocked_on(struct task_struct *p, struct mutex *m)
+{
+	WARN_ON_ONCE(!m);
+	/* The task should only be setting itself as blocked */
+	WARN_ON_ONCE(p != current);
+	/* Currently we serialize blocked_on under the mutex::wait_lock */
+	lockdep_assert_held_once(&m->wait_lock);
+	/*
+	 * Check ensure we don't overwrite existing mutex value
+	 * with a different mutex. Note, setting it to the same
+	 * lock repeatedly is ok.
+	 */
+	WARN_ON_ONCE(p->blocked_on && p->blocked_on != m);
+	p->blocked_on = m;
+}
+
+static inline void set_task_blocked_on(struct task_struct *p, struct mutex *m)
+{
+	guard(raw_spinlock_irqsave)(&m->wait_lock);
+	__set_task_blocked_on(p, m);
+}
+
+static inline void __clear_task_blocked_on(struct task_struct *p, struct mutex *m)
+{
+	WARN_ON_ONCE(!m);
+	/* Currently we serialize blocked_on under the mutex::wait_lock */
+	lockdep_assert_held_once(&m->wait_lock);
+	/*
+	 * There may be cases where we re-clear already cleared
+	 * blocked_on relationships, but make sure we are not
+	 * clearing the relationship with a different lock.
+	 */
+	WARN_ON_ONCE(m && p->blocked_on && p->blocked_on != m);
+	p->blocked_on = NULL;
+}
+
+static inline void clear_task_blocked_on(struct task_struct *p, struct mutex *m)
+{
+	guard(raw_spinlock_irqsave)(&m->wait_lock);
+	__clear_task_blocked_on(p, m);
+}
+#else
+static inline void __clear_task_blocked_on(struct task_struct *p, struct rt_mutex *m)
+{
+}
+
+static inline void clear_task_blocked_on(struct task_struct *p, struct rt_mutex *m)
+{
+}
+#endif /* !CONFIG_PREEMPT_RT */
+
 static __always_inline bool need_resched(void)
 {
 	return unlikely(tif_need_resched());
@@ -2168,8 +2230,6 @@ extern bool sched_task_on_rq(struct task_struct *p);
 extern unsigned long get_wchan(struct task_struct *p);
 extern struct task_struct *cpu_curr_snapshot(int cpu);
 
-#include <linux/spinlock.h>
-
 /*
  * In order to reduce various lock holder preemption latencies provide an
  * interface to see if a vCPU is currently running or not.
diff --git a/kernel/locking/mutex-debug.c b/kernel/locking/mutex-debug.c
index 758b7a6..949103f 100644
--- a/kernel/locking/mutex-debug.c
+++ b/kernel/locking/mutex-debug.c
@@ -54,13 +54,13 @@ void debug_mutex_add_waiter(struct mutex *lock, struct mutex_waiter *waiter,
 	lockdep_assert_held(&lock->wait_lock);
 
 	/* Current thread can't be already blocked (since it's executing!) */
-	DEBUG_LOCKS_WARN_ON(task->blocked_on);
+	DEBUG_LOCKS_WARN_ON(__get_task_blocked_on(task));
 }
 
 void debug_mutex_remove_waiter(struct mutex *lock, struct mutex_waiter *waiter,
 			 struct task_struct *task)
 {
-	struct mutex *blocked_on = READ_ONCE(task->blocked_on);
+	struct mutex *blocked_on = __get_task_blocked_on(task);
 
 	DEBUG_LOCKS_WARN_ON(list_empty(&waiter->list));
 	DEBUG_LOCKS_WARN_ON(waiter->task != task);
diff --git a/kernel/locking/mutex.c b/kernel/locking/mutex.c
index e2f5986..80d778f 100644
--- a/kernel/locking/mutex.c
+++ b/kernel/locking/mutex.c
@@ -644,8 +644,7 @@ __mutex_lock_common(struct mutex *lock, unsigned int state, unsigned int subclas
 			goto err_early_kill;
 	}
 
-	WARN_ON(current->blocked_on);
-	current->blocked_on = lock;
+	__set_task_blocked_on(current, lock);
 	set_current_state(state);
 	trace_contention_begin(lock, LCB_F_MUTEX);
 	for (;;) {
@@ -685,9 +684,9 @@ __mutex_lock_common(struct mutex *lock, unsigned int state, unsigned int subclas
 		/*
 		 * As we likely have been woken up by task
 		 * that has cleared our blocked_on state, re-set
-		 * it to the lock we are trying to aquire.
+		 * it to the lock we are trying to acquire.
 		 */
-		current->blocked_on = lock;
+		set_task_blocked_on(current, lock);
 		set_current_state(state);
 		/*
 		 * Here we order against unlock; we must either see it change
@@ -699,11 +698,15 @@ __mutex_lock_common(struct mutex *lock, unsigned int state, unsigned int subclas
 
 		if (first) {
 			trace_contention_begin(lock, LCB_F_MUTEX | LCB_F_SPIN);
-			/* clear blocked_on as mutex_optimistic_spin may schedule() */
-			current->blocked_on = NULL;
+			/*
+			 * mutex_optimistic_spin() can call schedule(), so
+			 * clear blocked on so we don't become unselectable
+			 * to run.
+			 */
+			clear_task_blocked_on(current, lock);
 			if (mutex_optimistic_spin(lock, ww_ctx, &waiter))
 				break;
-			current->blocked_on = lock;
+			set_task_blocked_on(current, lock);
 			trace_contention_begin(lock, LCB_F_MUTEX);
 		}
 
@@ -711,7 +714,7 @@ __mutex_lock_common(struct mutex *lock, unsigned int state, unsigned int subclas
 	}
 	raw_spin_lock_irqsave(&lock->wait_lock, flags);
 acquired:
-	current->blocked_on = NULL;
+	__clear_task_blocked_on(current, lock);
 	__set_current_state(TASK_RUNNING);
 
 	if (ww_ctx) {
@@ -741,11 +744,11 @@ skip_wait:
 	return 0;
 
 err:
-	current->blocked_on = NULL;
+	__clear_task_blocked_on(current, lock);
 	__set_current_state(TASK_RUNNING);
 	__mutex_remove_waiter(lock, &waiter);
 err_early_kill:
-	WARN_ON(current->blocked_on);
+	WARN_ON(__get_task_blocked_on(current));
 	trace_contention_end(lock, ret);
 	raw_spin_unlock_irqrestore_wake(&lock->wait_lock, flags, &wake_q);
 	debug_mutex_free_waiter(&waiter);
@@ -956,14 +959,7 @@ static noinline void __sched __mutex_unlock_slowpath(struct mutex *lock, unsigne
 		next = waiter->task;
 
 		debug_mutex_wake_waiter(lock, waiter);
-		/*
-		 * Unlock wakeups can be happening in parallel
-		 * (when optimistic spinners steal and release
-		 * the lock), so blocked_on may already be
-		 * cleared here.
-		 */
-		WARN_ON(next->blocked_on && next->blocked_on != lock);
-		next->blocked_on = NULL;
+		__clear_task_blocked_on(next, lock);
 		wake_q_add(&wake_q, next);
 	}
 
diff --git a/kernel/locking/ww_mutex.h b/kernel/locking/ww_mutex.h
index 45fe05e..086fd54 100644
--- a/kernel/locking/ww_mutex.h
+++ b/kernel/locking/ww_mutex.h
@@ -283,15 +283,13 @@ __ww_mutex_die(struct MUTEX *lock, struct MUTEX_WAITER *waiter,
 	if (waiter->ww_ctx->acquired > 0 && __ww_ctx_less(waiter->ww_ctx, ww_ctx)) {
 #ifndef WW_RT
 		debug_mutex_wake_waiter(lock, waiter);
+#endif
 		/*
 		 * When waking up the task to die, be sure to clear the
 		 * blocked_on pointer. Otherwise we can see circular
 		 * blocked_on relationships that can't resolve.
 		 */
-		WARN_ON(waiter->task->blocked_on &&
-			waiter->task->blocked_on != lock);
-#endif
-		waiter->task->blocked_on = NULL;
+		__clear_task_blocked_on(waiter->task, lock);
 		wake_q_add(wake_q, waiter->task);
 	}
 
@@ -345,7 +343,7 @@ static bool __ww_mutex_wound(struct MUTEX *lock,
 			 * blocked_on pointer. Otherwise we can see circular
 			 * blocked_on relationships that can't resolve.
 			 */
-			owner->blocked_on = NULL;
+			__clear_task_blocked_on(owner, lock);
 			wake_q_add(wake_q, owner);
 		}
 		return true;

