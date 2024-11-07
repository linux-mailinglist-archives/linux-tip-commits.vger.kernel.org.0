Return-Path: <linux-tip-commits+bounces-2782-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B5429BFB7D
	for <lists+linux-tip-commits@lfdr.de>; Thu,  7 Nov 2024 02:31:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7EB321C212B6
	for <lists+linux-tip-commits@lfdr.de>; Thu,  7 Nov 2024 01:31:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12CD917BCA;
	Thu,  7 Nov 2024 01:31:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="T0TXXSQ6";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Hn15346o"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F05BBD268;
	Thu,  7 Nov 2024 01:31:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730943095; cv=none; b=dZQF47E5qDyh6v7VXZUz/790kBC/bU88kPls+iQzFIph6T7stlvWSusFP3gH+bCKP4Ud8vGiOZ9EvVMUqNgrlYCg4Qe5lfn9ZKlVJkO3Vb9lCze9dgzwIHP1IS1SLGx7ODoIREWUd72WbuPTYVi2TRMclgtuEsMVTD26cJiIoEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730943095; c=relaxed/simple;
	bh=wgQ6uc1CYhK5Kd3qY6rzivB8B5wRC9TPcliTVjyGA70=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=DmgGlbYpubnhOuFXnDNby5X5i/Q9uiQW1VN4RBzzbJUcs4cshah4nSesnYp5MgoqOykhletDUGigPyDIMMQAFRteRtVPDwq9m8KY4KntNb9yAPfX/I/1mTmgiuh8t9h71PUhWTHqhP/kVIajWi+Q/wsee0FhO+D4FncHXCtvsdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=T0TXXSQ6; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Hn15346o; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 07 Nov 2024 01:31:31 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1730943092;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YZ5eQucOIq2QteTvGgY9xizGjV4RMSPAl5MzEZ0YbI4=;
	b=T0TXXSQ670Zc+bEgkQSf2xw84818PgWRBegLQkzrmRlAxMdKy/LVNH37YznxIHplBhQrxo
	BCviuzBaEw5YyEzpv7SOkwT5qlR21h3iWPh+XzJPwmhSvsMHydBDTNqiomvTtTgeJ/XHTR
	EcwtHuQWFL/AZzqGn4PdqfXz166/0lZqkCf6M3ndigS4BOoMy5Q+bpLve1z58ga529t2xT
	DQnnHyXfbLQUCWdl5kSLkqSqahdOsO4ns5VzVYPrO7gPqh7Jt9gK9YYUWPS+sfla/s8Nsu
	TiZs065+Luap6frf8tTObgTz+TSz52Fh9qDp+aXYdykem99lW4oCr5tc9Z7sdg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1730943092;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YZ5eQucOIq2QteTvGgY9xizGjV4RMSPAl5MzEZ0YbI4=;
	b=Hn15346o7/rZrD6GaTTTUh0MHeE7bWLbaO+LM4i4bt/Q5CdnYh8Yyszcd1I6qb/qXSdUth
	Y9Pm2AT7S4NZFvDw==
From: "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] signal: Queue ignored posixtimers on ignore list
Cc: Thomas Gleixner <tglx@linutronix.de>,
 Frederic Weisbecker <frederic@kernel.org>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20241105064214.120756416@linutronix.de>
References: <20241105064214.120756416@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173094309149.32228.2635679814048547578.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     df7a996b4dab03c889fa86d849447b716f07b069
Gitweb:        https://git.kernel.org/tip/df7a996b4dab03c889fa86d849447b716f07b069
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Tue, 05 Nov 2024 09:14:54 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 07 Nov 2024 02:14:45 +01:00

signal: Queue ignored posixtimers on ignore list

Queue posixtimers which have their signal ignored on the ignored list:

   1) When the timer fires and the signal has SIG_IGN set

   2) When SIG_IGN is installed via sigaction() and a timer signal
      is already queued

This only happens when the signal is for a valid timer, which delivered the
signal in periodic mode. One-shot timer signals are correctly dropped.

Due to the lock order constraints (sighand::siglock nests inside
timer::lock) the signal code cannot access any of the timer fields which
are relevant to make this decision, e.g. timer::it_status.

This is addressed by establishing a protection scheme which requires to
lock both locks on the timer side for modifying decision fields in the
timer struct and therefore makes it possible for the signal delivery to
evaluate with only sighand:siglock being held:

  1) Move the NULLification of timer->it_signal into the sighand::siglock
     protected section of timer_delete() and check timer::it_signal in the
     code path which determines whether the signal is dropped or queued on
     the ignore list.

     This ensures that a deleted timer cannot be moved onto the ignore
     list, which would prevent it from being freed on exit() as it is not
     longer in the process' posix timer list.

     If the timer got moved to the ignored list before deletion then it is
     removed from the ignored list under sighand lock in timer_delete().

  2) Provide a new timer::it_sig_periodic flag, which gets set in the
     signal queue path with both timer and sighand locks held if the timer
     is actually in periodic mode at expiry time.

     The ignore list code checks this flag under sighand::siglock and drops
     the signal when it is not set.

     If it is set, then the signal is moved to the ignored list independent
     of the actual state of the timer.

     When the signal is un-ignored later then the signal is moved back to
     the signal queue. On signal delivery the posix timer side decides
     about dropping the signal if the timer was re-armed, dis-armed or
     deleted based on the signal sequence counter check.

     If the thread/process exits then not yet delivered signals are
     discarded which means the reference of the timer containing the
     sigqueue is dropped and frees the timer.

     This is way cheaper than requiring all code paths to lock
     sighand::siglock of the target thread/process on any modification of
     timer::it_status or going all the way and removing pending signals
     from the signal queues on every rearm, disarm or delete operation.

So the protection scheme here is that on the timer side both timer::lock
and sighand::siglock have to be held for modifying

   timer::it_signal
   timer::it_sig_periodic

which means that on the signal side holding sighand::siglock is enough to
evaluate these fields.
                                                                                                                                                                                                                                                                                                                             
In posixtimer_deliver_signal() holding timer::lock is sufficient to do the
sequence validation against timer::it_signal_seq because a concurrent
expiry is waiting on timer::lock to be released.

This completes the SIG_IGN handling and such timers are not longer self
rearmed which avoids pointless wakeups.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/all/20241105064214.120756416@linutronix.de

---
 include/linux/posix-timers.h |  2 +-
 kernel/signal.c              | 80 ++++++++++++++++++++++++++++++++---
 kernel/time/posix-timers.c   |  7 ++-
 3 files changed, 83 insertions(+), 6 deletions(-)

diff --git a/include/linux/posix-timers.h b/include/linux/posix-timers.h
index 1608b52..43ea6e7 100644
--- a/include/linux/posix-timers.h
+++ b/include/linux/posix-timers.h
@@ -160,6 +160,7 @@ static inline void posix_cputimers_init_work(void) { }
  * @it_clock:		The posix timer clock id
  * @it_id:		The posix timer id for identifying the timer
  * @it_status:		The status of the timer
+ * @it_sig_periodic:	The periodic status at signal delivery
  * @it_overrun:		The overrun counter for pending signals
  * @it_overrun_last:	The overrun at the time of the last delivered signal
  * @it_signal_seq:	Sequence count to control signal delivery
@@ -184,6 +185,7 @@ struct k_itimer {
 	clockid_t		it_clock;
 	timer_t			it_id;
 	int			it_status;
+	bool			it_sig_periodic;
 	s64			it_overrun;
 	s64			it_overrun_last;
 	unsigned int		it_signal_seq;
diff --git a/kernel/signal.c b/kernel/signal.c
index 908b49c..9b098a7 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -59,6 +59,8 @@
 #include <asm/cacheflush.h>
 #include <asm/syscall.h>	/* for syscall_get_* */
 
+#include "time/posix-timers.h"
+
 /*
  * SLAB caches for signal bits.
  */
@@ -731,6 +733,16 @@ void signal_wake_up_state(struct task_struct *t, unsigned int state)
 		kick_process(t);
 }
 
+static inline void posixtimer_sig_ignore(struct task_struct *tsk, struct sigqueue *q);
+
+static void sigqueue_free_ignored(struct task_struct *tsk, struct sigqueue *q)
+{
+	if (likely(!(q->flags & SIGQUEUE_PREALLOC) || q->info.si_code != SI_TIMER))
+		__sigqueue_free(q);
+	else
+		posixtimer_sig_ignore(tsk, q);
+}
+
 /* Remove signals in mask from the pending set and queue. */
 static void flush_sigqueue_mask(struct task_struct *p, sigset_t *mask, struct sigpending *s)
 {
@@ -747,7 +759,7 @@ static void flush_sigqueue_mask(struct task_struct *p, sigset_t *mask, struct si
 	list_for_each_entry_safe(q, n, &s->list, list) {
 		if (sigismember(mask, q->info.si_signo)) {
 			list_del_init(&q->list);
-			__sigqueue_free(q);
+			sigqueue_free_ignored(p, q);
 		}
 	}
 }
@@ -1964,7 +1976,7 @@ int posixtimer_send_sigqueue(struct k_itimer *tmr)
 	int sig = q->info.si_signo;
 	struct task_struct *t;
 	unsigned long flags;
-	int ret, result;
+	int result;
 
 	guard(rcu)();
 
@@ -1981,13 +1993,55 @@ int posixtimer_send_sigqueue(struct k_itimer *tmr)
 	 */
 	tmr->it_sigqueue_seq = tmr->it_signal_seq;
 
-	ret = 1; /* the signal is ignored */
+	/*
+	 * Set the signal delivery status under sighand lock, so that the
+	 * ignored signal handling can distinguish between a periodic and a
+	 * non-periodic timer.
+	 */
+	tmr->it_sig_periodic = tmr->it_status == POSIX_TIMER_REQUEUE_PENDING;
+
 	if (!prepare_signal(sig, t, false)) {
 		result = TRACE_SIGNAL_IGNORED;
+
+		/* Paranoia check. Try to survive. */
+		if (WARN_ON_ONCE(!list_empty(&q->list)))
+			goto out;
+
+		/* Periodic timers with SIG_IGN are queued on the ignored list */
+		if (tmr->it_sig_periodic) {
+			/*
+			 * Already queued means the timer was rearmed after
+			 * the previous expiry got it on the ignore list.
+			 * Nothing to do for that case.
+			 */
+			if (hlist_unhashed(&tmr->ignored_list)) {
+				/*
+				 * Take a signal reference and queue it on
+				 * the ignored list.
+				 */
+				posixtimer_sigqueue_getref(q);
+				posixtimer_sig_ignore(t, q);
+			}
+		} else if (!hlist_unhashed(&tmr->ignored_list)) {
+			/*
+			 * Covers the case where a timer was periodic and
+			 * then the signal was ignored. Later it was rearmed
+			 * as oneshot timer. The previous signal is invalid
+			 * now, and this oneshot signal has to be dropped.
+			 * Remove it from the ignored list and drop the
+			 * reference count as the signal is not longer
+			 * queued.
+			 */
+			hlist_del_init(&tmr->ignored_list);
+			posixtimer_putref(tmr);
+		}
 		goto out;
 	}
 
-	ret = 0;
+	/* This should never happen and leaks a reference count */
+	if (WARN_ON_ONCE(!hlist_unhashed(&tmr->ignored_list)))
+		hlist_del_init(&tmr->ignored_list);
+
 	if (unlikely(!list_empty(&q->list))) {
 		/* This holds a reference count already */
 		result = TRACE_SIGNAL_ALREADY_PENDING;
@@ -2000,7 +2054,22 @@ int posixtimer_send_sigqueue(struct k_itimer *tmr)
 out:
 	trace_signal_generate(sig, &q->info, t, tmr->it_pid_type != PIDTYPE_PID, result);
 	unlock_task_sighand(t, &flags);
-	return ret;
+	return 0;
+}
+
+static inline void posixtimer_sig_ignore(struct task_struct *tsk, struct sigqueue *q)
+{
+	struct k_itimer *tmr = container_of(q, struct k_itimer, sigq);
+
+	/*
+	 * If the timer is marked deleted already or the signal originates
+	 * from a non-periodic timer, then just drop the reference
+	 * count. Otherwise queue it on the ignored list.
+	 */
+	if (tmr->it_signal && tmr->it_sig_periodic)
+		hlist_add_head(&tmr->ignored_list, &tsk->signal->ignored_posix_timers);
+	else
+		posixtimer_putref(tmr);
 }
 
 static void posixtimer_sig_unignore(struct task_struct *tsk, int sig)
@@ -2048,6 +2117,7 @@ static void posixtimer_sig_unignore(struct task_struct *tsk, int sig)
 	}
 }
 #else /* CONFIG_POSIX_TIMERS */
+static inline void posixtimer_sig_ignore(struct task_struct *tsk, struct sigqueue *q) { }
 static inline void posixtimer_sig_unignore(struct task_struct *tsk, int sig) { }
 #endif /* !CONFIG_POSIX_TIMERS */
 
diff --git a/kernel/time/posix-timers.c b/kernel/time/posix-timers.c
index 2b88fb4..ea72db3 100644
--- a/kernel/time/posix-timers.c
+++ b/kernel/time/posix-timers.c
@@ -1072,12 +1072,17 @@ retry_delete:
 	spin_lock(&current->sighand->siglock);
 	hlist_del(&timer->list);
 	posix_timer_cleanup_ignored(timer);
-	spin_unlock(&current->sighand->siglock);
 	/*
 	 * A concurrent lookup could check timer::it_signal lockless. It
 	 * will reevaluate with timer::it_lock held and observe the NULL.
+	 *
+	 * It must be written with siglock held so that the signal code
+	 * observes timer->it_signal == NULL in do_sigaction(SIG_IGN),
+	 * which prevents it from moving a pending signal of a deleted
+	 * timer to the ignore list.
 	 */
 	WRITE_ONCE(timer->it_signal, NULL);
+	spin_unlock(&current->sighand->siglock);
 
 	unlock_timer(timer, flags);
 	posix_timer_unhash_and_free(timer);

