Return-Path: <linux-tip-commits+bounces-2781-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DD1B9BFB7C
	for <lists+linux-tip-commits@lfdr.de>; Thu,  7 Nov 2024 02:31:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 616DF1C2125F
	for <lists+linux-tip-commits@lfdr.de>; Thu,  7 Nov 2024 01:31:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7C7717543;
	Thu,  7 Nov 2024 01:31:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="AqKRuKRm";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="DvZvRSiX"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93DFD79E1;
	Thu,  7 Nov 2024 01:31:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730943095; cv=none; b=ktOS3xm89NuWDxCxOc+KjQU2OEOmiyttYyh570e1m4KULbs1JWZtiDpxi3GUuv7HVwGOKRAFtbynRXQAPmSWQotAo6uAnqqsusiGyirGhGuOtEIJjWkle8PXnpOJAqo5zzNBggDWyD2V1y6/jOI7Xjj/CE27MCMUbU14shd3ZYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730943095; c=relaxed/simple;
	bh=a8HRuiBZd4yVlkq9CQ7gigJ8pHidg/uOP+jMFOM2u2Q=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=f9e8qTybIGPW9BDZJLcV8igELIofHRnCqjwZC7CFEUmo9yO5pUhG12wHUaakGmh/clg2rEn0qCBKf5m5IPrcAZ4KbX0DTsEHTiXexT7qc06mrr4b3L9byriARHsA9+FLTC0bCenZ0L9HPmyrGIV5J5ns+eXEDx2WCNdjESIFWGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=AqKRuKRm; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=DvZvRSiX; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 07 Nov 2024 01:31:30 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1730943091;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vb/uIt8/MTX5k4HpUCs9Dxm+/aVpK1w3FICLmzIqxPo=;
	b=AqKRuKRm+uNChvRoVGC5IYe9hcFdFqMPJl+Fr6p1XsYbh0ptWRiWxhnC4sqPhE6YHE2BAL
	mfFpH0PM0mOkxEkaHxNxr+irV3xCcXCBqCMyEkkSJQHtZrk4BsxyBoHK5WXz6Cqzwfcx0C
	fQPqb+ZpCqi054sPX9sRSI4U0FcFpSjtA5KIt6VgsSswMGSBo1nf2F74cCHZqSBE/HDacx
	lyo3DBICKRVbRW3cUIEH8DNLIkhVm3//yjmnVJEHZbOy5PbwNjQLAbWduekYf6Gw/KbaWp
	ug/5CYV5NmDoJ+q1LXBTmM81qEwcQqcQWbmCBL1W3r7tDwiPx0VW/lvwHmJqRA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1730943091;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vb/uIt8/MTX5k4HpUCs9Dxm+/aVpK1w3FICLmzIqxPo=;
	b=DvZvRSiXanUfak1qJ7grbbqm7uqPuKkcUHc69tePoWlh3KzkIGxIGXFrXDwwWPa4/XpKTJ
	Umwh0J+oFTpBfiDA==
From: "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] posix-timers: Cleanup SIG_IGN workaround leftovers
Cc: Thomas Gleixner <tglx@linutronix.de>,
 Frederic Weisbecker <frederic@kernel.org>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20241105064214.187239060@linutronix.de>
References: <20241105064214.187239060@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173094309081.32228.7408305563690711909.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     7a66f72b09bb0762360274b1fb677b3433dbaa06
Gitweb:        https://git.kernel.org/tip/7a66f72b09bb0762360274b1fb677b3433dbaa06
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Tue, 05 Nov 2024 09:14:55 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 07 Nov 2024 02:14:45 +01:00

posix-timers: Cleanup SIG_IGN workaround leftovers

Now that ignored posix timer signals are requeued and the timers are
rearmed on signal delivery the workaround to keep such timers alive and
self rearm them is not longer required.

Remove the relevant hacks and the not longer required return values from
the related functions. The alarm timer workarounds will be cleaned up in a
separate step.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/all/20241105064214.187239060@linutronix.de

---
 include/linux/posix-timers.h   |  2 +-
 kernel/signal.c                |  7 +--
 kernel/time/alarmtimer.c       | 47 ++++-----------------
 kernel/time/posix-cpu-timers.c | 18 +-------
 kernel/time/posix-timers.c     | 73 ++-------------------------------
 kernel/time/posix-timers.h     |  2 +-
 6 files changed, 24 insertions(+), 125 deletions(-)

diff --git a/include/linux/posix-timers.h b/include/linux/posix-timers.h
index 43ea6e7..f11f10c 100644
--- a/include/linux/posix-timers.h
+++ b/include/linux/posix-timers.h
@@ -111,7 +111,7 @@ static inline void posix_cputimers_rt_watchdog(struct posix_cputimers *pct,
 
 void posixtimer_rearm_itimer(struct task_struct *p);
 bool posixtimer_init_sigqueue(struct sigqueue *q);
-int posixtimer_send_sigqueue(struct k_itimer *tmr);
+void posixtimer_send_sigqueue(struct k_itimer *tmr);
 bool posixtimer_deliver_signal(struct kernel_siginfo *info, struct sigqueue *timer_sigq);
 void posixtimer_free_timer(struct k_itimer *timer);
 
diff --git a/kernel/signal.c b/kernel/signal.c
index 9b098a7..cbf70c8 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -1970,7 +1970,7 @@ static inline struct task_struct *posixtimer_get_target(struct k_itimer *tmr)
 	return t;
 }
 
-int posixtimer_send_sigqueue(struct k_itimer *tmr)
+void posixtimer_send_sigqueue(struct k_itimer *tmr)
 {
 	struct sigqueue *q = &tmr->sigq;
 	int sig = q->info.si_signo;
@@ -1982,10 +1982,10 @@ int posixtimer_send_sigqueue(struct k_itimer *tmr)
 
 	t = posixtimer_get_target(tmr);
 	if (!t)
-		return -1;
+		return;
 
 	if (!likely(lock_task_sighand(t, &flags)))
-		return -1;
+		return;
 
 	/*
 	 * Update @tmr::sigqueue_seq for posix timer signals with sighand
@@ -2054,7 +2054,6 @@ int posixtimer_send_sigqueue(struct k_itimer *tmr)
 out:
 	trace_signal_generate(sig, &q->info, t, tmr->it_pid_type != PIDTYPE_PID, result);
 	unlock_task_sighand(t, &flags);
-	return 0;
 }
 
 static inline void posixtimer_sig_ignore(struct task_struct *tsk, struct sigqueue *q)
diff --git a/kernel/time/alarmtimer.c b/kernel/time/alarmtimer.c
index 452d8aa..8543d7f 100644
--- a/kernel/time/alarmtimer.c
+++ b/kernel/time/alarmtimer.c
@@ -197,28 +197,15 @@ static enum hrtimer_restart alarmtimer_fired(struct hrtimer *timer)
 {
 	struct alarm *alarm = container_of(timer, struct alarm, timer);
 	struct alarm_base *base = &alarm_bases[alarm->type];
-	unsigned long flags;
-	int ret = HRTIMER_NORESTART;
-	int restart = ALARMTIMER_NORESTART;
 
-	spin_lock_irqsave(&base->lock, flags);
-	alarmtimer_dequeue(base, alarm);
-	spin_unlock_irqrestore(&base->lock, flags);
+	scoped_guard (spinlock_irqsave, &base->lock)
+		alarmtimer_dequeue(base, alarm);
 
 	if (alarm->function)
-		restart = alarm->function(alarm, base->get_ktime());
-
-	spin_lock_irqsave(&base->lock, flags);
-	if (restart != ALARMTIMER_NORESTART) {
-		hrtimer_set_expires(&alarm->timer, alarm->node.expires);
-		alarmtimer_enqueue(base, alarm);
-		ret = HRTIMER_RESTART;
-	}
-	spin_unlock_irqrestore(&base->lock, flags);
+		alarm->function(alarm, base->get_ktime());
 
 	trace_alarmtimer_fired(alarm, base->get_ktime());
-	return ret;
-
+	return HRTIMER_NORESTART;
 }
 
 ktime_t alarm_expires_remaining(const struct alarm *alarm)
@@ -567,30 +554,14 @@ static enum alarmtimer_type clock2alarm(clockid_t clockid)
  *
  * Return: whether the timer is to be restarted
  */
-static enum alarmtimer_restart alarm_handle_timer(struct alarm *alarm,
-							ktime_t now)
+static enum alarmtimer_restart alarm_handle_timer(struct alarm *alarm, ktime_t now)
 {
-	struct k_itimer *ptr = container_of(alarm, struct k_itimer,
-					    it.alarm.alarmtimer);
-	enum alarmtimer_restart result = ALARMTIMER_NORESTART;
-	unsigned long flags;
-
-	spin_lock_irqsave(&ptr->it_lock, flags);
+	struct k_itimer *ptr = container_of(alarm, struct k_itimer, it.alarm.alarmtimer);
 
-	if (posix_timer_queue_signal(ptr) && ptr->it_interval) {
-		/*
-		 * Handle ignored signals and rearm the timer. This will go
-		 * away once we handle ignored signals proper. Ensure that
-		 * small intervals cannot starve the system.
-		 */
-		ptr->it_overrun += __alarm_forward_now(alarm, ptr->it_interval, true);
-		++ptr->it_signal_seq;
-		ptr->it_status = POSIX_TIMER_ARMED;
-		result = ALARMTIMER_RESTART;
-	}
-	spin_unlock_irqrestore(&ptr->it_lock, flags);
+	guard(spinlock_irqsave)(&ptr->it_lock);
+	posix_timer_queue_signal(ptr);
 
-	return result;
+	return ALARMTIMER_NORESTART;
 }
 
 /**
diff --git a/kernel/time/posix-cpu-timers.c b/kernel/time/posix-cpu-timers.c
index 0c441d8..50e8d04 100644
--- a/kernel/time/posix-cpu-timers.c
+++ b/kernel/time/posix-cpu-timers.c
@@ -603,21 +603,11 @@ static void cpu_timer_fire(struct k_itimer *timer)
 		 */
 		wake_up_process(timer->it_process);
 		cpu_timer_setexpires(ctmr, 0);
-	} else if (!timer->it_interval) {
-		/*
-		 * One-shot timer.  Clear it as soon as it's fired.
-		 */
+	} else {
 		posix_timer_queue_signal(timer);
-		cpu_timer_setexpires(ctmr, 0);
-	} else if (posix_timer_queue_signal(timer)) {
-		/*
-		 * The signal did not get queued because the signal
-		 * was ignored, so we won't get any callback to
-		 * reload the timer.  But we need to keep it
-		 * ticking in case the signal is deliverable next time.
-		 */
-		posix_cpu_timer_rearm(timer);
-		++timer->it_signal_seq;
+		/* Disable oneshot timers */
+		if (!timer->it_interval)
+			cpu_timer_setexpires(ctmr, 0);
 	}
 }
 
diff --git a/kernel/time/posix-timers.c b/kernel/time/posix-timers.c
index ea72db3..881a9ce 100644
--- a/kernel/time/posix-timers.c
+++ b/kernel/time/posix-timers.c
@@ -300,21 +300,12 @@ bool posixtimer_deliver_signal(struct kernel_siginfo *info, struct sigqueue *tim
 	return ret;
 }
 
-int posix_timer_queue_signal(struct k_itimer *timr)
+void posix_timer_queue_signal(struct k_itimer *timr)
 {
-	enum posix_timer_state state = POSIX_TIMER_DISARMED;
-	int ret;
-
 	lockdep_assert_held(&timr->it_lock);
 
-	if (timr->it_interval)
-		state = POSIX_TIMER_REQUEUE_PENDING;
-
-	timr->it_status = state;
-
-	ret = posixtimer_send_sigqueue(timr);
-	/* If we failed to send the signal the timer stops. */
-	return ret > 0;
+	timr->it_status = timr->it_interval ? POSIX_TIMER_REQUEUE_PENDING : POSIX_TIMER_DISARMED;
+	posixtimer_send_sigqueue(timr);
 }
 
 /*
@@ -327,62 +318,10 @@ int posix_timer_queue_signal(struct k_itimer *timr)
 static enum hrtimer_restart posix_timer_fn(struct hrtimer *timer)
 {
 	struct k_itimer *timr = container_of(timer, struct k_itimer, it.real.timer);
-	enum hrtimer_restart ret = HRTIMER_NORESTART;
-	unsigned long flags;
-
-	spin_lock_irqsave(&timr->it_lock, flags);
-
-	if (posix_timer_queue_signal(timr)) {
-		/*
-		 * The signal was not queued due to SIG_IGN. As a
-		 * consequence the timer is not going to be rearmed from
-		 * the signal delivery path. But as a real signal handler
-		 * can be installed later the timer must be rearmed here.
-		 */
-		if (timr->it_interval != 0) {
-			ktime_t now = hrtimer_cb_get_time(timer);
-
-			/*
-			 * FIXME: What we really want, is to stop this
-			 * timer completely and restart it in case the
-			 * SIG_IGN is removed. This is a non trivial
-			 * change to the signal handling code.
-			 *
-			 * For now let timers with an interval less than a
-			 * jiffy expire every jiffy and recheck for a
-			 * valid signal handler.
-			 *
-			 * This avoids interrupt starvation in case of a
-			 * very small interval, which would expire the
-			 * timer immediately again.
-			 *
-			 * Moving now ahead of time by one jiffy tricks
-			 * hrtimer_forward() to expire the timer later,
-			 * while it still maintains the overrun accuracy
-			 * for the price of a slight inconsistency in the
-			 * timer_gettime() case. This is at least better
-			 * than a timer storm.
-			 *
-			 * Only required when high resolution timers are
-			 * enabled as the periodic tick based timers are
-			 * automatically aligned to the next tick.
-			 */
-			if (IS_ENABLED(CONFIG_HIGH_RES_TIMERS)) {
-				ktime_t kj = TICK_NSEC;
-
-				if (timr->it_interval < kj)
-					now = ktime_add(now, kj);
-			}
-
-			timr->it_overrun += hrtimer_forward(timer, now, timr->it_interval);
-			ret = HRTIMER_RESTART;
-			++timr->it_signal_seq;
-			timr->it_status = POSIX_TIMER_ARMED;
-		}
-	}
 
-	unlock_timer(timr, flags);
-	return ret;
+	guard(spinlock_irqsave)(&timr->it_lock);
+	posix_timer_queue_signal(timr);
+	return HRTIMER_NORESTART;
 }
 
 static struct pid *good_sigevent(sigevent_t * event)
diff --git a/kernel/time/posix-timers.h b/kernel/time/posix-timers.h
index 4d09677..61906f0 100644
--- a/kernel/time/posix-timers.h
+++ b/kernel/time/posix-timers.h
@@ -42,7 +42,7 @@ extern const struct k_clock clock_process;
 extern const struct k_clock clock_thread;
 extern const struct k_clock alarm_clock;
 
-int posix_timer_queue_signal(struct k_itimer *timr);
+void posix_timer_queue_signal(struct k_itimer *timr);
 
 void common_timer_get(struct k_itimer *timr, struct itimerspec64 *cur_setting);
 int common_timer_set(struct k_itimer *timr, int flags,

