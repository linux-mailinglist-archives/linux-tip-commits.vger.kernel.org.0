Return-Path: <linux-tip-commits+bounces-2638-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F2E19B47F7
	for <lists+linux-tip-commits@lfdr.de>; Tue, 29 Oct 2024 12:10:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 907291C2573E
	for <lists+linux-tip-commits@lfdr.de>; Tue, 29 Oct 2024 11:10:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C37F206053;
	Tue, 29 Oct 2024 11:09:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="cA4GLMd1";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="u1J4F7OB"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD023205E30;
	Tue, 29 Oct 2024 11:09:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730200161; cv=none; b=E2JV9VH2uQ+ccACwjSJFOOp8OzwmLYVuumb53DU+rifXgDiG6J8gv5YxbaGAshAkQrTu9crv8PREhyZ2wc1Watb2HaDR9aoz0wYCSt33LHj+3eWFd1+te8rLDEEZqDiy5NBhraKh5tlJ3z29GabTLL9aIKyrqnkv0C8es9+i8b8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730200161; c=relaxed/simple;
	bh=ZzYDjk7u042Tf5EuHxtU3dQhRcAKZ7Uh76DBPUDu8Ac=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=XVA577O9cz7ocR4qq6xdD8A/UyulOihQ1DZmASnpylMNvqAWA0NOf+xz3M8lJp0rlKi6DmcSL59Ryhd6JzoPz5w+iTPg3iHDFcTkJG/kx0jyyO/N1SUTNyHMLq4vwFxhMOUwBxpTlkKZnOaHi6ejWfVzSOcllr79bJQToX/tX7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=cA4GLMd1; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=u1J4F7OB; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 29 Oct 2024 11:09:15 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1730200156;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6wOfBnKB7eLXiLICiRYd+ixDfbR/6/6d87RmjlJW848=;
	b=cA4GLMd14LDJBrsObk9AoJ8XeDxe2VWgzXBsAc6LH71zj6pzefac3k+sEFDs5IoGksQInr
	0kAWKEq1axwhK2oUw+g/WTg1zJyX8Y8tUcEAdhS2M3Td20v4HZYJwsQJXhqt877oy67WXG
	wWwEihojuEmUFILQKirjLFwaNBDpDGcmsZQ3t4D/49wazsOiABmq1/Q9rv0GMRLTYs62/D
	C8+6HIRE02uSKfV48OM4ICWRorgeBQ6uRqjEHdfsBmGiHFdH/TIwvVTtAu8iBW8vfWmIBM
	sBV5OhPaRGE8mwuGo/uTsw/V9HNHfqMP9HKBheUnuUrKtvJx0/Iu6Bu8fPb8Xw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1730200156;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6wOfBnKB7eLXiLICiRYd+ixDfbR/6/6d87RmjlJW848=;
	b=u1J4F7OBjmNyWhgzSpMWzrU7jRi5qS8S5QbbLGDofGCAQa3XpxO4oM/NRrZe7Z26M0jVX7
	rYp3NjjEQnFHnADQ==
From: "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] posix-timers: Rename k_itimer:: It_requeue_pending
Cc: Thomas Gleixner <tglx@linutronix.de>,
 Frederic Weisbecker <frederic@kernel.org>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20241001083835.611997737@linutronix.de>
References: <20241001083835.611997737@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173020015521.1442.16903737264120343124.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     cd1e93aedab7f749760a33e9e094381973b1120e
Gitweb:        https://git.kernel.org/tip/cd1e93aedab7f749760a33e9e094381973b1120e
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Tue, 01 Oct 2024 10:42:07 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 29 Oct 2024 11:43:19 +01:00

posix-timers: Rename k_itimer:: It_requeue_pending

Prepare for using this struct member to do a proper reprogramming and
deletion accounting so that stale signals can be dropped.

No functional change.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/all/20241001083835.611997737@linutronix.de

---
 include/linux/posix-timers.h   |  5 ++---
 kernel/time/alarmtimer.c       |  2 +-
 kernel/time/posix-cpu-timers.c |  4 ++--
 kernel/time/posix-timers.c     | 12 ++++++------
 4 files changed, 11 insertions(+), 12 deletions(-)

diff --git a/include/linux/posix-timers.h b/include/linux/posix-timers.h
index 4ab49e5..253d106 100644
--- a/include/linux/posix-timers.h
+++ b/include/linux/posix-timers.h
@@ -150,8 +150,7 @@ static inline void posix_cputimers_init_work(void) { }
  * @it_active:		Marker that timer is active
  * @it_overrun:		The overrun counter for pending signals
  * @it_overrun_last:	The overrun at the time of the last delivered signal
- * @it_requeue_pending:	Indicator that timer waits for being requeued on
- *			signal delivery
+ * @it_signal_seq:	Sequence count to control signal delivery
  * @it_sigev_notify:	The notify word of sigevent struct for signal delivery
  * @it_interval:	The interval for periodic timers
  * @it_signal:		Pointer to the creators signal struct
@@ -172,7 +171,7 @@ struct k_itimer {
 	int			it_active;
 	s64			it_overrun;
 	s64			it_overrun_last;
-	int			it_requeue_pending;
+	unsigned int		it_signal_seq;
 	int			it_sigev_notify;
 	ktime_t			it_interval;
 	struct signal_struct	*it_signal;
diff --git a/kernel/time/alarmtimer.c b/kernel/time/alarmtimer.c
index 8bf8886..75f8443 100644
--- a/kernel/time/alarmtimer.c
+++ b/kernel/time/alarmtimer.c
@@ -584,7 +584,7 @@ static enum alarmtimer_restart alarm_handle_timer(struct alarm *alarm,
 		 * small intervals cannot starve the system.
 		 */
 		ptr->it_overrun += __alarm_forward_now(alarm, ptr->it_interval, true);
-		++ptr->it_requeue_pending;
+		++ptr->it_signal_seq;
 		ptr->it_active = 1;
 		result = ALARMTIMER_RESTART;
 	}
diff --git a/kernel/time/posix-cpu-timers.c b/kernel/time/posix-cpu-timers.c
index 6bcee47..993243b 100644
--- a/kernel/time/posix-cpu-timers.c
+++ b/kernel/time/posix-cpu-timers.c
@@ -608,7 +608,7 @@ static void cpu_timer_fire(struct k_itimer *timer)
 		 * ticking in case the signal is deliverable next time.
 		 */
 		posix_cpu_timer_rearm(timer);
-		++timer->it_requeue_pending;
+		++timer->it_signal_seq;
 	}
 }
 
@@ -745,7 +745,7 @@ static void __posix_cpu_timer_get(struct k_itimer *timer, struct itimerspec64 *i
 	 *  - Timers which expired, but the signal has not yet been
 	 *    delivered
 	 */
-	if (iv && ((timer->it_requeue_pending & REQUEUE_PENDING) || sigev_none))
+	if (iv && ((timer->it_signal_seq & REQUEUE_PENDING) || sigev_none))
 		expires = bump_cpu_timer(timer, now);
 	else
 		expires = cpu_timer_getexpires(&timer->it.cpu);
diff --git a/kernel/time/posix-timers.c b/kernel/time/posix-timers.c
index 22e1d6b..fd321fc 100644
--- a/kernel/time/posix-timers.c
+++ b/kernel/time/posix-timers.c
@@ -269,13 +269,13 @@ bool posixtimer_deliver_signal(struct kernel_siginfo *info)
 	if (!timr)
 		goto out;
 
-	if (timr->it_interval && timr->it_requeue_pending == info->si_sys_private) {
+	if (timr->it_interval && timr->it_signal_seq == info->si_sys_private) {
 		timr->kclock->timer_rearm(timr);
 
 		timr->it_active = 1;
 		timr->it_overrun_last = timr->it_overrun;
 		timr->it_overrun = -1LL;
-		++timr->it_requeue_pending;
+		++timr->it_signal_seq;
 
 		info->si_overrun = timer_overrun_to_int(timr, info->si_overrun);
 	}
@@ -299,7 +299,7 @@ int posix_timer_queue_signal(struct k_itimer *timr)
 
 	timr->it_active = 0;
 	if (timr->it_interval)
-		si_private = ++timr->it_requeue_pending;
+		si_private = ++timr->it_signal_seq;
 
 	type = !(timr->it_sigev_notify & SIGEV_THREAD_ID) ? PIDTYPE_TGID : PIDTYPE_PID;
 	ret = send_sigqueue(timr->sigq, timr->it_pid, type, si_private);
@@ -366,7 +366,7 @@ static enum hrtimer_restart posix_timer_fn(struct hrtimer *timer)
 
 			timr->it_overrun += hrtimer_forward(timer, now, timr->it_interval);
 			ret = HRTIMER_RESTART;
-			++timr->it_requeue_pending;
+			++timr->it_signal_seq;
 			timr->it_active = 1;
 		}
 	}
@@ -660,7 +660,7 @@ void common_timer_get(struct k_itimer *timr, struct itimerspec64 *cur_setting)
 	 * is a SIGEV_NONE timer move the expiry time forward by intervals,
 	 * so expiry is > now.
 	 */
-	if (iv && (timr->it_requeue_pending & REQUEUE_PENDING || sig_none))
+	if (iv && (timr->it_signal_seq & REQUEUE_PENDING || sig_none))
 		timr->it_overrun += kc->timer_forward(timr, now);
 
 	remaining = kc->timer_remaining(timr, now);
@@ -861,7 +861,7 @@ void posix_timer_set_common(struct k_itimer *timer, struct itimerspec64 *new_set
 		timer->it_interval = 0;
 
 	/* Prevent reloading in case there is a signal pending */
-	timer->it_requeue_pending = (timer->it_requeue_pending + 2) & ~REQUEUE_PENDING;
+	timer->it_signal_seq = (timer->it_signal_seq + 2) & ~REQUEUE_PENDING;
 	/* Reset overrun accounting */
 	timer->it_overrun_last = 0;
 	timer->it_overrun = -1LL;

