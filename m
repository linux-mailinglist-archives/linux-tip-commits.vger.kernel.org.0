Return-Path: <linux-tip-commits+bounces-2788-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6734C9BFB8A
	for <lists+linux-tip-commits@lfdr.de>; Thu,  7 Nov 2024 02:33:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B6408B221A4
	for <lists+linux-tip-commits@lfdr.de>; Thu,  7 Nov 2024 01:33:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 889851885BD;
	Thu,  7 Nov 2024 01:31:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ZKRZsuf3";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ZfaFHKk6"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A62676048;
	Thu,  7 Nov 2024 01:31:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730943100; cv=none; b=iZhOH19TTUlULu6dgkXmDTTf8yoHs1xwJo6605jYZDe73jE90ldMC4kK4ySlR4tSkIHkWg3WaHAYFDDXmFKtj9Gn9B+qIxbjeSoqmSEEAYOicA3P7xHUfcPfUTDO3wAs959rrtElF+t5RT6660juzkp9vNFVuU8q5q5tPJhmPMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730943100; c=relaxed/simple;
	bh=K+y5Oi6Zd5Z6JUCzKw/1yz9+IKmWE0K45U0K0/OdhJg=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=ogjzy7OofY44GkMcceoYtVx7NVR0rLQgeLN/uu3Ie+qku4HlFb0CprkeoxeSCl4ayZgUQlt2grIY+HLQ0dctX9OlW42sIPf+eRe5dAJHtxd2LEv8XFeQdk9llBvjaDUjkpx/0dXpgcOn+L/7y7eDsTV0WPBN2P83EkAbydODVv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ZKRZsuf3; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ZfaFHKk6; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 07 Nov 2024 01:31:35 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1730943096;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ArkTmIQChwwW1P6i/aNNG91eJIF50gouzi16oM0XSzQ=;
	b=ZKRZsuf304J/bKvrG0emiXxC2U44nh95vL4whS3wRp7IxH3CY9OKU+jTxjeBsaQP+ZKpDh
	5U/kxK16ShxydjsCevU4ur6Bvqh4j4DhuCs65arrp3DVpzXoqJaT9d1HJdlAHaKGIOoweZ
	xsU3R0kQjvztBF0vDhjntLLvngpIMqXCHtzgc111tALuEYVTwc8VnKMmtyo9/YePmDs7Ij
	UFjkPcs+oN8O4g916OkJgr41BPrbStfM/JuJtMOr8m6E/i7yqWthkCv2yIV+/oxvhG7wk1
	hq9QU8htrqqIH+ov9uLRB2uVZmINWqOFo4dpVFCivK2xNvMBt6CFHTCLPPQmVw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1730943096;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ArkTmIQChwwW1P6i/aNNG91eJIF50gouzi16oM0XSzQ=;
	b=ZfaFHKk6axv840xO939R/40dbo4IBAV4AKg3iuHCRxPQ9Dhxvd6wNbcfaIJI/IHsydQPEI
	s8rkudrQraWtpVBg==
From: "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] posix-timers: Embed sigqueue in struct k_itimer
Cc: Thomas Gleixner <tglx@linutronix.de>,
 Frederic Weisbecker <frederic@kernel.org>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20241105064213.719695194@linutronix.de>
References: <20241105064213.719695194@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173094309566.32228.17706754399205402373.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     6017a158beb13b412e55a451379798aae5876514
Gitweb:        https://git.kernel.org/tip/6017a158beb13b412e55a451379798aae5876514
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Tue, 05 Nov 2024 09:14:45 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 07 Nov 2024 02:14:44 +01:00

posix-timers: Embed sigqueue in struct k_itimer

To cure the SIG_IGN handling for posix interval timers, the preallocated
sigqueue needs to be embedded into struct k_itimer to prevent life time
races of all sorts.

Now that the prerequisites are in place, embed the sigqueue into struct
k_itimer and fixup the relevant usage sites.

Aside of preparing for proper SIG_IGN handling, this spares an extra
allocation.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/all/20241105064213.719695194@linutronix.de

---
 fs/proc/base.c               |  4 +-
 include/linux/posix-timers.h | 23 ++++++++-
 kernel/signal.c              | 19 +++++---
 kernel/time/posix-timers.c   | 88 ++++++++++++++++++++---------------
 4 files changed, 87 insertions(+), 47 deletions(-)

diff --git a/fs/proc/base.c b/fs/proc/base.c
index b31283d..6a37a43 100644
--- a/fs/proc/base.c
+++ b/fs/proc/base.c
@@ -2553,8 +2553,8 @@ static int show_timer(struct seq_file *m, void *v)
 
 	seq_printf(m, "ID: %d\n", timer->it_id);
 	seq_printf(m, "signal: %d/%px\n",
-		   timer->sigq->info.si_signo,
-		   timer->sigq->info.si_value.sival_ptr);
+		   timer->sigq.info.si_signo,
+		   timer->sigq.info.si_value.sival_ptr);
 	seq_printf(m, "notify: %s/%s.%d\n",
 		   nstr[notify & ~SIGEV_THREAD_ID],
 		   (notify & SIGEV_THREAD_ID) ? "tid" : "pid",
diff --git a/include/linux/posix-timers.h b/include/linux/posix-timers.h
index 39f1db7..28c0a30 100644
--- a/include/linux/posix-timers.h
+++ b/include/linux/posix-timers.h
@@ -39,6 +39,8 @@ static inline int clockid_to_fd(const clockid_t clk)
 
 #ifdef CONFIG_POSIX_TIMERS
 
+#include <linux/signal_types.h>
+
 /**
  * cpu_timer - Posix CPU timer representation for k_itimer
  * @node:	timerqueue node to queue in the task/sig
@@ -166,7 +168,7 @@ static inline void posix_cputimers_init_work(void) { }
  * @it_pid:		The pid of the process/task targeted by the signal
  * @it_process:		The task to wakeup on clock_nanosleep (CPU timers)
  * @rcuref:		Reference count for life time management
- * @sigq:		Pointer to preallocated sigqueue
+ * @sigq:		Embedded sigqueue
  * @it:			Union representing the various posix timer type
  *			internals.
  * @rcu:		RCU head for freeing the timer.
@@ -190,7 +192,7 @@ struct k_itimer {
 		struct pid		*it_pid;
 		struct task_struct	*it_process;
 	};
-	struct sigqueue		*sigq;
+	struct sigqueue		sigq;
 	rcuref_t		rcuref;
 	union {
 		struct {
@@ -218,6 +220,23 @@ static inline void posixtimer_putref(struct k_itimer *tmr)
 	if (rcuref_put(&tmr->rcuref))
 		posixtimer_free_timer(tmr);
 }
+
+static inline void posixtimer_sigqueue_getref(struct sigqueue *q)
+{
+	struct k_itimer *tmr = container_of(q, struct k_itimer, sigq);
+
+	WARN_ON_ONCE(!rcuref_get(&tmr->rcuref));
+}
+
+static inline void posixtimer_sigqueue_putref(struct sigqueue *q)
+{
+	struct k_itimer *tmr = container_of(q, struct k_itimer, sigq);
+
+	posixtimer_putref(tmr);
+}
+#else  /* CONFIG_POSIX_TIMERS */
+static inline void posixtimer_sigqueue_getref(struct sigqueue *q) { }
+static inline void posixtimer_sigqueue_putref(struct sigqueue *q) { }
 #endif /* !CONFIG_POSIX_TIMERS */
 
 #endif
diff --git a/kernel/signal.c b/kernel/signal.c
index 0ddb5dd..2d74cd5 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -460,8 +460,10 @@ static struct sigqueue *__sigqueue_alloc(int sig, struct task_struct *t, gfp_t g
 
 static void __sigqueue_free(struct sigqueue *q)
 {
-	if (q->flags & SIGQUEUE_PREALLOC)
+	if (q->flags & SIGQUEUE_PREALLOC) {
+		posixtimer_sigqueue_putref(q);
 		return;
+	}
 	if (q->ucounts) {
 		dec_rlimit_put_ucounts(q->ucounts, UCOUNT_RLIMIT_SIGPENDING);
 		q->ucounts = NULL;
@@ -569,11 +571,11 @@ still_pending:
 		copy_siginfo(info, &first->info);
 
 		/*
-		 * posix-timer signals are preallocated and freed when the
-		 * timer goes away. Either directly or by clearing
-		 * SIGQUEUE_PREALLOC so that the next delivery will free
-		 * them. Spare the extra round through __sigqueue_free()
-		 * which is ignoring preallocated signals.
+		 * posix-timer signals are preallocated and freed when the last
+		 * reference count is dropped in posixtimer_deliver_signal() or
+		 * immediately on timer deletion when the signal is not pending.
+		 * Spare the extra round through __sigqueue_free() which is
+		 * ignoring preallocated signals.
 		 */
 		if (unlikely((first->flags & SIGQUEUE_PREALLOC) && (info->si_code == SI_TIMER)))
 			*timer_sigq = first;
@@ -1989,7 +1991,7 @@ static inline struct task_struct *posixtimer_get_target(struct k_itimer *tmr)
 
 int posixtimer_send_sigqueue(struct k_itimer *tmr)
 {
-	struct sigqueue *q = tmr->sigq;
+	struct sigqueue *q = &tmr->sigq;
 	int sig = q->info.si_signo;
 	struct task_struct *t;
 	unsigned long flags;
@@ -2020,9 +2022,12 @@ int posixtimer_send_sigqueue(struct k_itimer *tmr)
 
 	ret = 0;
 	if (unlikely(!list_empty(&q->list))) {
+		/* This holds a reference count already */
 		result = TRACE_SIGNAL_ALREADY_PENDING;
 		goto out;
 	}
+
+	posixtimer_sigqueue_getref(q);
 	posixtimer_queue_sigqueue(q, t, tmr->it_pid_type);
 	result = TRACE_SIGNAL_DELIVERED;
 out:
diff --git a/kernel/time/posix-timers.c b/kernel/time/posix-timers.c
index d6fef06..2e2c0ed 100644
--- a/kernel/time/posix-timers.c
+++ b/kernel/time/posix-timers.c
@@ -250,15 +250,40 @@ static void common_hrtimer_rearm(struct k_itimer *timr)
 	hrtimer_restart(timer);
 }
 
+static bool __posixtimer_deliver_signal(struct kernel_siginfo *info, struct k_itimer *timr)
+{
+	guard(spinlock)(&timr->it_lock);
+
+	/*
+	 * Check if the timer is still alive or whether it got modified
+	 * since the signal was queued. In either case, don't rearm and
+	 * drop the signal.
+	 */
+	if (timr->it_signal_seq != info->si_sys_private || WARN_ON_ONCE(!timr->it_signal))
+		return false;
+
+	if (!timr->it_interval || WARN_ON_ONCE(timr->it_status != POSIX_TIMER_REQUEUE_PENDING))
+		return true;
+
+	timr->kclock->timer_rearm(timr);
+	timr->it_status = POSIX_TIMER_ARMED;
+	timr->it_overrun_last = timr->it_overrun;
+	timr->it_overrun = -1LL;
+	++timr->it_signal_seq;
+	info->si_overrun = timer_overrun_to_int(timr);
+	return true;
+}
+
 /*
  * This function is called from the signal delivery code. It decides
- * whether the signal should be dropped and rearms interval timers.
+ * whether the signal should be dropped and rearms interval timers.  The
+ * timer can be unconditionally accessed as there is a reference held on
+ * it.
  */
 bool posixtimer_deliver_signal(struct kernel_siginfo *info, struct sigqueue *timer_sigq)
 {
-	struct k_itimer *timr;
-	unsigned long flags;
-	bool ret = false;
+	struct k_itimer *timr = container_of(timer_sigq, struct k_itimer, sigq);
+	bool ret;
 
 	/*
 	 * Release siglock to ensure proper locking order versus
@@ -266,28 +291,11 @@ bool posixtimer_deliver_signal(struct kernel_siginfo *info, struct sigqueue *tim
 	 */
 	spin_unlock(&current->sighand->siglock);
 
-	timr = lock_timer(info->si_tid, &flags);
-	if (!timr)
-		goto out;
-
-	if (timr->it_signal_seq != info->si_sys_private)
-		goto out_unlock;
-
-	if (timr->it_interval && !WARN_ON_ONCE(timr->it_status != POSIX_TIMER_REQUEUE_PENDING)) {
-		timr->kclock->timer_rearm(timr);
+	ret = __posixtimer_deliver_signal(info, timr);
 
-		timr->it_status = POSIX_TIMER_ARMED;
-		timr->it_overrun_last = timr->it_overrun;
-		timr->it_overrun = -1LL;
-		++timr->it_signal_seq;
-
-		info->si_overrun = timer_overrun_to_int(timr);
-	}
-	ret = true;
+	/* Drop the reference which was acquired when the signal was queued */
+	posixtimer_putref(timr);
 
-out_unlock:
-	unlock_timer(timr, flags);
-out:
 	spin_lock(&current->sighand->siglock);
 
 	/* Don't expose the si_sys_private value to userspace */
@@ -404,17 +412,17 @@ static struct pid *good_sigevent(sigevent_t * event)
 	}
 }
 
-static struct k_itimer * alloc_posix_timer(void)
+static struct k_itimer *alloc_posix_timer(void)
 {
 	struct k_itimer *tmr = kmem_cache_zalloc(posix_timers_cache, GFP_KERNEL);
 
 	if (!tmr)
 		return tmr;
-	if (unlikely(!(tmr->sigq = sigqueue_alloc()))) {
+
+	if (unlikely(!posixtimer_init_sigqueue(&tmr->sigq))) {
 		kmem_cache_free(posix_timers_cache, tmr);
 		return NULL;
 	}
-	clear_siginfo(&tmr->sigq->info);
 	rcuref_init(&tmr->rcuref, 1);
 	return tmr;
 }
@@ -422,7 +430,8 @@ static struct k_itimer * alloc_posix_timer(void)
 void posixtimer_free_timer(struct k_itimer *tmr)
 {
 	put_pid(tmr->it_pid);
-	sigqueue_free(tmr->sigq);
+	if (tmr->sigq.ucounts)
+		dec_rlimit_put_ucounts(tmr->sigq.ucounts, UCOUNT_RLIMIT_SIGPENDING);
 	kfree_rcu(tmr, rcu);
 }
 
@@ -484,13 +493,13 @@ static int do_timer_create(clockid_t which_clock, struct sigevent *event,
 			goto out;
 		}
 		new_timer->it_sigev_notify     = event->sigev_notify;
-		new_timer->sigq->info.si_signo = event->sigev_signo;
-		new_timer->sigq->info.si_value = event->sigev_value;
+		new_timer->sigq.info.si_signo = event->sigev_signo;
+		new_timer->sigq.info.si_value = event->sigev_value;
 	} else {
 		new_timer->it_sigev_notify     = SIGEV_SIGNAL;
-		new_timer->sigq->info.si_signo = SIGALRM;
-		memset(&new_timer->sigq->info.si_value, 0, sizeof(sigval_t));
-		new_timer->sigq->info.si_value.sival_int = new_timer->it_id;
+		new_timer->sigq.info.si_signo = SIGALRM;
+		memset(&new_timer->sigq.info.si_value, 0, sizeof(sigval_t));
+		new_timer->sigq.info.si_value.sival_int = new_timer->it_id;
 		new_timer->it_pid = get_pid(task_tgid(current));
 	}
 
@@ -499,8 +508,8 @@ static int do_timer_create(clockid_t which_clock, struct sigevent *event,
 	else
 		new_timer->it_pid_type = PIDTYPE_TGID;
 
-	new_timer->sigq->info.si_tid   = new_timer->it_id;
-	new_timer->sigq->info.si_code  = SI_TIMER;
+	new_timer->sigq.info.si_tid = new_timer->it_id;
+	new_timer->sigq.info.si_code = SI_TIMER;
 
 	if (copy_to_user(created_timer_id, &new_timer_id, sizeof (new_timer_id))) {
 		error = -EFAULT;
@@ -584,7 +593,14 @@ static struct k_itimer *__lock_timer(timer_t timer_id, unsigned long *flags)
 	 *  1) Set timr::it_signal to NULL with timr::it_lock held
 	 *  2) Release timr::it_lock
 	 *  3) Remove from the hash under hash_lock
-	 *  4) Call RCU for removal after the grace period
+	 *  4) Put the reference count.
+	 *
+	 * The reference count might not drop to zero if timr::sigq is
+	 * queued. In that case the signal delivery or flush will put the
+	 * last reference count.
+	 *
+	 * When the reference count reaches zero, the timer is scheduled
+	 * for RCU removal after the grace period.
 	 *
 	 * Holding rcu_read_lock() accross the lookup ensures that
 	 * the timer cannot be freed.

