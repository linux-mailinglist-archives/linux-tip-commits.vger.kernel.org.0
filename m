Return-Path: <linux-tip-commits+bounces-6129-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B76E4B07338
	for <lists+linux-tip-commits@lfdr.de>; Wed, 16 Jul 2025 12:21:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 47AC77B1D7E
	for <lists+linux-tip-commits@lfdr.de>; Wed, 16 Jul 2025 10:18:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 839502F508C;
	Wed, 16 Jul 2025 10:19:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Uwe462pC";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="U3SIVWqc"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35E732F4338;
	Wed, 16 Jul 2025 10:19:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752661158; cv=none; b=SDEH6lttoO2hVMFcTEO+Ujn55SpjrpkgtkX5oSYwWq+M4LclQCbxhrv13+g9v4WyK5giDyFq6Kahb10KDK7kw4Nhraac7PK5LQSiV5cEX40RhOExTusDcPdZWCOYFS+X3kx6TLCJOjOxlzayWOzQRSVYgr7Bti7n/gfjU73o6mI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752661158; c=relaxed/simple;
	bh=ST9ya2/jDiC4Hmwe5bCkQ1jpCEFOQr5oA3c4MYBaTUs=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=sj2TDrH7n6yM1V0XVTJLylX3G+Y9fqDSA2VoQnatp0v/MMZGu/l+n4LKnmtlOxeb9bgoUHkTVDR+oO3gQRzXKCXQBxAIilQ9ZTJiBAClRH+C2LUWSuvYgJYpRW6ZaAfWp37NPXkrLcgdcoVLhjCRKZmtCHwWa2nTwCU+vi6LOnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Uwe462pC; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=U3SIVWqc; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 16 Jul 2025 10:19:13 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1752661154;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8xCVeX3e/yVgRACkSNDxQZIA9E222FHkideCjsLa6gQ=;
	b=Uwe462pCN3ehYe8MUBXocNvNaI45TgUYdNa/DdvTFyr8wG7I6SrT18VPtXJsx49rXuBZcH
	j3HcJqHcy1dzzpvYAGuyN/d8b9SvpWHQomamo+qLPZuW1v0Nbm3c8dbuE+lu9bFPq4xg7r
	TVSkgLTWSzDHlxNOfl/9CmNvSvZgiiQ2fc7+Hky90KCShAwTevjp+bLsZnGQ9chdb0iwwe
	NVPvLfvsjKrGBmEEZjgYBKpaIsk4CrKa9gruQIrWS+csuhz96oFVQWA8+Sn5d5oty0OWwg
	TnMFx7y8sGBuSf3jsmDxCJMuDoVJrGM29QSocAvJK9Y7/3WJaqAXAYH8VN3vnQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1752661154;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8xCVeX3e/yVgRACkSNDxQZIA9E222FHkideCjsLa6gQ=;
	b=U3SIVWqcuTKBH4lsqrDM4YH0U9Le6KWrQcTUq/jVAlMKXAB6A9Nks/g7B1AfYgkoYRvUAX
	oPFxjFyUtM4QszAQ==
From: "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] locking/mutex: Rework task_struct::blocked_on
Cc: "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Juri Lelli <juri.lelli@redhat.com>, "Connor O'Brien" <connoro@google.com>,
 John Stultz <jstultz@google.com>, K Prateek Nayak <kprateek.nayak@amd.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250712033407.2383110-3-jstultz@google.com>
References: <20250712033407.2383110-3-jstultz@google.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175266115340.406.7737633482808574220.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     44e4e0297c3c01987399bb9973f4d22a096a62c2
Gitweb:        https://git.kernel.org/tip/44e4e0297c3c01987399bb9973f4d22a096a62c2
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Sat, 12 Jul 2025 03:33:43 
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 14 Jul 2025 17:16:31 +02:00

locking/mutex: Rework task_struct::blocked_on

Track the blocked-on relation for mutexes, to allow following this
relation at schedule time.

   task
     | blocked-on
     v
   mutex
     | owner
     v
   task

This all will be used for tracking blocked-task/mutex chains
with the prox-execution patch in a similar fashion to how
priority inheritance is done with rt_mutexes.

For serialization, blocked-on is only set by the task itself
(current). And both when setting or clearing (potentially by
others), is done while holding the mutex::wait_lock.

[minor changes while rebasing]
[jstultz: Fix blocked_on tracking in __mutex_lock_common in error paths]
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Juri Lelli <juri.lelli@redhat.com>
Signed-off-by: Connor O'Brien <connoro@google.com>
Signed-off-by: John Stultz <jstultz@google.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Tested-by: K Prateek Nayak <kprateek.nayak@amd.com>
Link: https://lkml.kernel.org/r/20250712033407.2383110-3-jstultz@google.com
---
 include/linux/sched.h        |  5 +----
 kernel/fork.c                |  3 +--
 kernel/locking/mutex-debug.c |  9 +++++----
 kernel/locking/mutex.c       | 22 ++++++++++++++++++++++
 kernel/locking/ww_mutex.h    | 18 ++++++++++++++++--
 5 files changed, 45 insertions(+), 12 deletions(-)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index f225b6b..33ad240 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1230,10 +1230,7 @@ struct task_struct {
 	struct rt_mutex_waiter		*pi_blocked_on;
 #endif
 
-#ifdef CONFIG_DEBUG_MUTEXES
-	/* Mutex deadlock detection: */
-	struct mutex_waiter		*blocked_on;
-#endif
+	struct mutex			*blocked_on;	/* lock we're blocked on */
 
 #ifdef CONFIG_DETECT_HUNG_TASK_BLOCKER
 	/*
diff --git a/kernel/fork.c b/kernel/fork.c
index 1ee8eb1..5f87f05 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -2123,9 +2123,8 @@ __latent_entropy struct task_struct *copy_process(
 	lockdep_init_task(p);
 #endif
 
-#ifdef CONFIG_DEBUG_MUTEXES
 	p->blocked_on = NULL; /* not blocked yet */
-#endif
+
 #ifdef CONFIG_BCACHE
 	p->sequential_io	= 0;
 	p->sequential_io_avg	= 0;
diff --git a/kernel/locking/mutex-debug.c b/kernel/locking/mutex-debug.c
index 6e6f607..758b7a6 100644
--- a/kernel/locking/mutex-debug.c
+++ b/kernel/locking/mutex-debug.c
@@ -53,17 +53,18 @@ void debug_mutex_add_waiter(struct mutex *lock, struct mutex_waiter *waiter,
 {
 	lockdep_assert_held(&lock->wait_lock);
 
-	/* Mark the current thread as blocked on the lock: */
-	task->blocked_on = waiter;
+	/* Current thread can't be already blocked (since it's executing!) */
+	DEBUG_LOCKS_WARN_ON(task->blocked_on);
 }
 
 void debug_mutex_remove_waiter(struct mutex *lock, struct mutex_waiter *waiter,
 			 struct task_struct *task)
 {
+	struct mutex *blocked_on = READ_ONCE(task->blocked_on);
+
 	DEBUG_LOCKS_WARN_ON(list_empty(&waiter->list));
 	DEBUG_LOCKS_WARN_ON(waiter->task != task);
-	DEBUG_LOCKS_WARN_ON(task->blocked_on != waiter);
-	task->blocked_on = NULL;
+	DEBUG_LOCKS_WARN_ON(blocked_on && blocked_on != lock);
 
 	INIT_LIST_HEAD(&waiter->list);
 	waiter->task = NULL;
diff --git a/kernel/locking/mutex.c b/kernel/locking/mutex.c
index a39eccc..e2f5986 100644
--- a/kernel/locking/mutex.c
+++ b/kernel/locking/mutex.c
@@ -644,6 +644,8 @@ __mutex_lock_common(struct mutex *lock, unsigned int state, unsigned int subclas
 			goto err_early_kill;
 	}
 
+	WARN_ON(current->blocked_on);
+	current->blocked_on = lock;
 	set_current_state(state);
 	trace_contention_begin(lock, LCB_F_MUTEX);
 	for (;;) {
@@ -680,6 +682,12 @@ __mutex_lock_common(struct mutex *lock, unsigned int state, unsigned int subclas
 
 		first = __mutex_waiter_is_first(lock, &waiter);
 
+		/*
+		 * As we likely have been woken up by task
+		 * that has cleared our blocked_on state, re-set
+		 * it to the lock we are trying to aquire.
+		 */
+		current->blocked_on = lock;
 		set_current_state(state);
 		/*
 		 * Here we order against unlock; we must either see it change
@@ -691,8 +699,11 @@ __mutex_lock_common(struct mutex *lock, unsigned int state, unsigned int subclas
 
 		if (first) {
 			trace_contention_begin(lock, LCB_F_MUTEX | LCB_F_SPIN);
+			/* clear blocked_on as mutex_optimistic_spin may schedule() */
+			current->blocked_on = NULL;
 			if (mutex_optimistic_spin(lock, ww_ctx, &waiter))
 				break;
+			current->blocked_on = lock;
 			trace_contention_begin(lock, LCB_F_MUTEX);
 		}
 
@@ -700,6 +711,7 @@ __mutex_lock_common(struct mutex *lock, unsigned int state, unsigned int subclas
 	}
 	raw_spin_lock_irqsave(&lock->wait_lock, flags);
 acquired:
+	current->blocked_on = NULL;
 	__set_current_state(TASK_RUNNING);
 
 	if (ww_ctx) {
@@ -729,9 +741,11 @@ skip_wait:
 	return 0;
 
 err:
+	current->blocked_on = NULL;
 	__set_current_state(TASK_RUNNING);
 	__mutex_remove_waiter(lock, &waiter);
 err_early_kill:
+	WARN_ON(current->blocked_on);
 	trace_contention_end(lock, ret);
 	raw_spin_unlock_irqrestore_wake(&lock->wait_lock, flags, &wake_q);
 	debug_mutex_free_waiter(&waiter);
@@ -942,6 +956,14 @@ static noinline void __sched __mutex_unlock_slowpath(struct mutex *lock, unsigne
 		next = waiter->task;
 
 		debug_mutex_wake_waiter(lock, waiter);
+		/*
+		 * Unlock wakeups can be happening in parallel
+		 * (when optimistic spinners steal and release
+		 * the lock), so blocked_on may already be
+		 * cleared here.
+		 */
+		WARN_ON(next->blocked_on && next->blocked_on != lock);
+		next->blocked_on = NULL;
 		wake_q_add(&wake_q, next);
 	}
 
diff --git a/kernel/locking/ww_mutex.h b/kernel/locking/ww_mutex.h
index 37f025a..45fe05e 100644
--- a/kernel/locking/ww_mutex.h
+++ b/kernel/locking/ww_mutex.h
@@ -283,7 +283,15 @@ __ww_mutex_die(struct MUTEX *lock, struct MUTEX_WAITER *waiter,
 	if (waiter->ww_ctx->acquired > 0 && __ww_ctx_less(waiter->ww_ctx, ww_ctx)) {
 #ifndef WW_RT
 		debug_mutex_wake_waiter(lock, waiter);
+		/*
+		 * When waking up the task to die, be sure to clear the
+		 * blocked_on pointer. Otherwise we can see circular
+		 * blocked_on relationships that can't resolve.
+		 */
+		WARN_ON(waiter->task->blocked_on &&
+			waiter->task->blocked_on != lock);
 #endif
+		waiter->task->blocked_on = NULL;
 		wake_q_add(wake_q, waiter->task);
 	}
 
@@ -331,9 +339,15 @@ static bool __ww_mutex_wound(struct MUTEX *lock,
 		 * it's wounded in __ww_mutex_check_kill() or has a
 		 * wakeup pending to re-read the wounded state.
 		 */
-		if (owner != current)
+		if (owner != current) {
+			/*
+			 * When waking up the task to wound, be sure to clear the
+			 * blocked_on pointer. Otherwise we can see circular
+			 * blocked_on relationships that can't resolve.
+			 */
+			owner->blocked_on = NULL;
 			wake_q_add(wake_q, owner);
-
+		}
 		return true;
 	}
 

