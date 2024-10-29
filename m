Return-Path: <linux-tip-commits+bounces-2628-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 719AF9B449A
	for <lists+linux-tip-commits@lfdr.de>; Tue, 29 Oct 2024 09:45:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 32616282C88
	for <lists+linux-tip-commits@lfdr.de>; Tue, 29 Oct 2024 08:45:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 943E7204011;
	Tue, 29 Oct 2024 08:45:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="fLEyX44E";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="bMFID2dE"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 180871E00BD;
	Tue, 29 Oct 2024 08:45:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730191525; cv=none; b=Ue4bUfqfOEWvDuwq5QlQ6iLJOpQEsRR36fp3FW+p4a6YDK9TROj+5EiJ7Ot2FWTi1frUEYsUVR5Vk7qkm9oLGG2jQZU+OSkHlzY02AijYOihA4gyZrxmZ3JIM6XkbvYYZpHJMhEuzgTkY3tcqDLWw2ols+rnGRGr/882YlpkcbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730191525; c=relaxed/simple;
	bh=qk/z5F5TpzTq8D3SSK1Oj5upvCKYFYMGO7Ce5MG/L0w=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=j+Fc03ZK/TyWXkw1q+6bJREDNe49sopGnNElE+/xLFMbnEr0CxKuJAcq+qZsqNFcYBxYMJuaw7ikkYZ4jbigO3ES/tYHXx49nemuBWgfQS2Jb4UuZldoybuCQ9oZXGPK9XsMPSbSW1bM+8+rnNeeuo1jZq3aZPIORSJbmqJHTiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=fLEyX44E; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=bMFID2dE; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 29 Oct 2024 08:45:20 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1730191521;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=puzX2d/Y35lT+9hL6HguOpS04kxaUccO5g1CdnQJsxY=;
	b=fLEyX44EjbKskH5+nBTaM3bGd8TKfifwfv5aI5YQboiE3Ah1qsYhS97lMGZmbSp4x40fFC
	x5h1w467yJP3tzrU40ILrVn+KWPd2Q7ZVCGd5B1vV7lGRC8dCKYqc2piJwZXM85aiRzze2
	g7USLHSd5v/Dcm1oW97oYr3GnwsBTWdLfPRQWRDTrqpPZXf2hjPNUWgO51EbIf5E2eYO6F
	g6jaF0OQFDkdI1Vi8gENOnEVIWw1m9KU0/K3zUglQiHd19xC+1TLELQVdbMDFj7sXFaCO2
	4qADCmmKuDAdTxyd/zB8iUv7gelDFr/ettE8tTt7VayK5gktZcUruLQvzWIoEA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1730191521;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=puzX2d/Y35lT+9hL6HguOpS04kxaUccO5g1CdnQJsxY=;
	b=bMFID2dEWOEC4q6EsPmTKq1uMa5vKSWNetSMRP6blDtM9XFy+bUZbqfZT8nw8WKQ1TfxFo
	vgTCz2zLFnI4zRDQ==
From: "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] posix-timers: Rename k_itimer::it_requeue_pending
Cc: Thomas Gleixner <tglx@linutronix.de>,
 Frederic Weisbecker <frederic@kernel.org>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173019152069.1442.15727355645663587144.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     e40a4f012df93c61519d27ba1cea93851961b760
Gitweb:        https://git.kernel.org/tip/e40a4f012df93c61519d27ba1cea93851961b760
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Tue, 01 Oct 2024 10:42:07 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 29 Oct 2024 09:39:06 +01:00

posix-timers: Rename k_itimer::it_requeue_pending

Prepare for using this struct member to do a proper reprogramming and
deletion accounting so that stale signals can be dropped.

No functional change.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>

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

