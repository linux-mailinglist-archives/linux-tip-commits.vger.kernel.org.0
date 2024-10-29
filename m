Return-Path: <linux-tip-commits+bounces-2627-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AFFA99B4496
	for <lists+linux-tip-commits@lfdr.de>; Tue, 29 Oct 2024 09:45:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3F3541F24DBB
	for <lists+linux-tip-commits@lfdr.de>; Tue, 29 Oct 2024 08:45:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBA82204003;
	Tue, 29 Oct 2024 08:45:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="nZli311M";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="LTbhVtSW"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BDE3203711;
	Tue, 29 Oct 2024 08:45:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730191524; cv=none; b=IvRqwCuFvfhZjknNccD7Pmx5xhT8l9Wy/UZqtbpcoRB+PVzFHbaDp7MTyjf59Zhf5MYqsBNh68Qz2eajQw3XLwg8pzz29OfPGD0+t3c0odb+FGi58BdTuYakvIqzIbS0/gq6E59Y+qGH6PvoaZYM8hzQ19Rlpxj5VLHUXTlHgUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730191524; c=relaxed/simple;
	bh=CNqczCtIqn27c387YmuMGw4OnfC0XUrVe51zsdLcVYY=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=oC26tnpew2gD5FizxqkUyGZpA39YjnB/GRVDnioaBhlY4GhLyvJgYl4e9cxkDnbC/3zcmMMFh2PJTejRMKyjG27uyK9Dqy1ffHEAHBFMRApQIWPlwEheh4FXy+nvqMbRox5Mi+RkngYTAjCY/bZIccVBK18XmsPPaRvcrntr4qE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=nZli311M; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=LTbhVtSW; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 29 Oct 2024 08:45:19 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1730191520;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=6Fyb/o+J6/NXPD/JI2fMq4peocDwjqArtC1ysLoesS4=;
	b=nZli311MX2eUCxavXlPcAubaH5diy4/EHkBw+BRtwd928E0KrN2acqVPqWz/8x9q5341Gj
	1LkI4sBKrypMX7Q92ccv7GODxId5vUtcqYjUpGaxIjOHV2aOCFHPFMo8vhdbrdSvi5CbtC
	UvMDtbcSkOM1Z4Sqca/reGSAx2d/IRLgv2soh7ggugP53s2/ggh62V1jSJFHxhuoqkTM62
	Q5rkvnlJ9CcT9FSxDiFiTj+JCNP1TE4Q1KaLv1e0OJ6YkSugXQYaG/7nzPKaKMrENLKINh
	029fssDbPg5IKH2z11w0MY6QkZX77i16T42mkkyjCW6BJJ+mF1UI6FY6Qas7cg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1730191520;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=6Fyb/o+J6/NXPD/JI2fMq4peocDwjqArtC1ysLoesS4=;
	b=LTbhVtSWNjputCxmblwkqWuRSUjLjB7ARpZIkFFFzLGkHxb/TttRacAde8Yk3HPlKz6OYd
	ERL1fWk85JOxOkBg==
From: "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] posix-timers: Add proper state tracking
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
Message-ID: <173019151990.1442.2662914389359343317.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     7fbc9b6c4f34249afa788eac24abdff5ca93f0aa
Gitweb:        https://git.kernel.org/tip/7fbc9b6c4f34249afa788eac24abdff5ca93f0aa
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Tue, 01 Oct 2024 10:42:09 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 29 Oct 2024 09:39:06 +01:00

posix-timers: Add proper state tracking

Right now the state tracking is done by two struct members:

 - it_active:
     A boolean which tracks armed/disarmed state

 - it_signal_seq:
     A sequence counter which is used to invalidate settings
     and prevent rearming

Replace it_active with it_status and keep properly track about the states
in one place.

This allows to reuse it_signal_seq to track reprogramming, disarm and
delete operations in order to drop signals which are related to the state
previous of those operations.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 include/linux/posix-timers.h   |  4 ++--
 kernel/time/alarmtimer.c       |  2 +-
 kernel/time/posix-cpu-timers.c | 15 ++++++++-------
 kernel/time/posix-timers.c     | 22 +++++++++++++---------
 kernel/time/posix-timers.h     |  6 ++++++
 5 files changed, 30 insertions(+), 19 deletions(-)

diff --git a/include/linux/posix-timers.h b/include/linux/posix-timers.h
index 253d106..02afbb4 100644
--- a/include/linux/posix-timers.h
+++ b/include/linux/posix-timers.h
@@ -147,7 +147,7 @@ static inline void posix_cputimers_init_work(void) { }
  * @kclock:		Pointer to the k_clock struct handling this timer
  * @it_clock:		The posix timer clock id
  * @it_id:		The posix timer id for identifying the timer
- * @it_active:		Marker that timer is active
+ * @it_status:		The status of the timer
  * @it_overrun:		The overrun counter for pending signals
  * @it_overrun_last:	The overrun at the time of the last delivered signal
  * @it_signal_seq:	Sequence count to control signal delivery
@@ -168,7 +168,7 @@ struct k_itimer {
 	const struct k_clock	*kclock;
 	clockid_t		it_clock;
 	timer_t			it_id;
-	int			it_active;
+	int			it_status;
 	s64			it_overrun;
 	s64			it_overrun_last;
 	unsigned int		it_signal_seq;
diff --git a/kernel/time/alarmtimer.c b/kernel/time/alarmtimer.c
index 75f8443..452d8aa 100644
--- a/kernel/time/alarmtimer.c
+++ b/kernel/time/alarmtimer.c
@@ -585,7 +585,7 @@ static enum alarmtimer_restart alarm_handle_timer(struct alarm *alarm,
 		 */
 		ptr->it_overrun += __alarm_forward_now(alarm, ptr->it_interval, true);
 		++ptr->it_signal_seq;
-		ptr->it_active = 1;
+		ptr->it_status = POSIX_TIMER_ARMED;
 		result = ALARMTIMER_RESTART;
 	}
 	spin_unlock_irqrestore(&ptr->it_lock, flags);
diff --git a/kernel/time/posix-cpu-timers.c b/kernel/time/posix-cpu-timers.c
index 993243b..12f828d 100644
--- a/kernel/time/posix-cpu-timers.c
+++ b/kernel/time/posix-cpu-timers.c
@@ -453,7 +453,6 @@ static void disarm_timer(struct k_itimer *timer, struct task_struct *p)
 	struct cpu_timer *ctmr = &timer->it.cpu;
 	struct posix_cputimer_base *base;
 
-	timer->it_active = 0;
 	if (!cpu_timer_dequeue(ctmr))
 		return;
 
@@ -494,11 +493,12 @@ static int posix_cpu_timer_del(struct k_itimer *timer)
 		 */
 		WARN_ON_ONCE(ctmr->head || timerqueue_node_queued(&ctmr->node));
 	} else {
-		if (timer->it.cpu.firing)
+		if (timer->it.cpu.firing) {
 			ret = TIMER_RETRY;
-		else
+		} else {
 			disarm_timer(timer, p);
-
+			timer->it_status = POSIX_TIMER_DISARMED;
+		}
 		unlock_task_sighand(p, &flags);
 	}
 
@@ -560,7 +560,7 @@ static void arm_timer(struct k_itimer *timer, struct task_struct *p)
 	struct cpu_timer *ctmr = &timer->it.cpu;
 	u64 newexp = cpu_timer_getexpires(ctmr);
 
-	timer->it_active = 1;
+	timer->it_status = POSIX_TIMER_ARMED;
 	if (!cpu_timer_enqueue(&base->tqhead, ctmr))
 		return;
 
@@ -586,7 +586,8 @@ static void cpu_timer_fire(struct k_itimer *timer)
 {
 	struct cpu_timer *ctmr = &timer->it.cpu;
 
-	timer->it_active = 0;
+	timer->it_status = POSIX_TIMER_DISARMED;
+
 	if (unlikely(timer->sigq == NULL)) {
 		/*
 		 * This a special case for clock_nanosleep,
@@ -671,7 +672,7 @@ static int posix_cpu_timer_set(struct k_itimer *timer, int timer_flags,
 		ret = TIMER_RETRY;
 	} else {
 		cpu_timer_dequeue(ctmr);
-		timer->it_active = 0;
+		timer->it_status = POSIX_TIMER_DISARMED;
 	}
 
 	/*
diff --git a/kernel/time/posix-timers.c b/kernel/time/posix-timers.c
index fd321fc..dd72b8e 100644
--- a/kernel/time/posix-timers.c
+++ b/kernel/time/posix-timers.c
@@ -272,7 +272,7 @@ bool posixtimer_deliver_signal(struct kernel_siginfo *info)
 	if (timr->it_interval && timr->it_signal_seq == info->si_sys_private) {
 		timr->kclock->timer_rearm(timr);
 
-		timr->it_active = 1;
+		timr->it_status = POSIX_TIMER_ARMED;
 		timr->it_overrun_last = timr->it_overrun;
 		timr->it_overrun = -1LL;
 		++timr->it_signal_seq;
@@ -292,14 +292,17 @@ out:
 
 int posix_timer_queue_signal(struct k_itimer *timr)
 {
+	enum posix_timer_state state = POSIX_TIMER_DISARMED;
 	int ret, si_private = 0;
 	enum pid_type type;
 
 	lockdep_assert_held(&timr->it_lock);
 
-	timr->it_active = 0;
-	if (timr->it_interval)
+	if (timr->it_interval) {
+		state = POSIX_TIMER_REQUEUE_PENDING;
 		si_private = ++timr->it_signal_seq;
+	}
+	timr->it_status = state;
 
 	type = !(timr->it_sigev_notify & SIGEV_THREAD_ID) ? PIDTYPE_TGID : PIDTYPE_PID;
 	ret = send_sigqueue(timr->sigq, timr->it_pid, type, si_private);
@@ -367,7 +370,7 @@ static enum hrtimer_restart posix_timer_fn(struct hrtimer *timer)
 			timr->it_overrun += hrtimer_forward(timer, now, timr->it_interval);
 			ret = HRTIMER_RESTART;
 			++timr->it_signal_seq;
-			timr->it_active = 1;
+			timr->it_status = POSIX_TIMER_ARMED;
 		}
 	}
 
@@ -640,10 +643,10 @@ void common_timer_get(struct k_itimer *timr, struct itimerspec64 *cur_setting)
 	/* interval timer ? */
 	if (iv) {
 		cur_setting->it_interval = ktime_to_timespec64(iv);
-	} else if (!timr->it_active) {
+	} else if (timr->it_status == POSIX_TIMER_DISARMED) {
 		/*
 		 * SIGEV_NONE oneshot timers are never queued and therefore
-		 * timr->it_active is always false. The check below
+		 * timr->it_status is always DISARMED. The check below
 		 * vs. remaining time will handle this case.
 		 *
 		 * For all other timers there is nothing to update here, so
@@ -888,7 +891,7 @@ int common_timer_set(struct k_itimer *timr, int flags,
 	if (kc->timer_try_to_cancel(timr) < 0)
 		return TIMER_RETRY;
 
-	timr->it_active = 0;
+	timr->it_status = POSIX_TIMER_DISARMED;
 	posix_timer_set_common(timr, new_setting);
 
 	/* Keep timer disarmed when it_value is zero */
@@ -901,7 +904,8 @@ int common_timer_set(struct k_itimer *timr, int flags,
 	sigev_none = timr->it_sigev_notify == SIGEV_NONE;
 
 	kc->timer_arm(timr, expires, flags & TIMER_ABSTIME, sigev_none);
-	timr->it_active = !sigev_none;
+	if (!sigev_none)
+		timr->it_status = POSIX_TIMER_ARMED;
 	return 0;
 }
 
@@ -1000,7 +1004,7 @@ int common_timer_del(struct k_itimer *timer)
 	timer->it_interval = 0;
 	if (kc->timer_try_to_cancel(timer) < 0)
 		return TIMER_RETRY;
-	timer->it_active = 0;
+	timer->it_status = POSIX_TIMER_DISARMED;
 	return 0;
 }
 
diff --git a/kernel/time/posix-timers.h b/kernel/time/posix-timers.h
index 4784ea6..4d09677 100644
--- a/kernel/time/posix-timers.h
+++ b/kernel/time/posix-timers.h
@@ -1,6 +1,12 @@
 /* SPDX-License-Identifier: GPL-2.0 */
 #define TIMER_RETRY 1
 
+enum posix_timer_state {
+	POSIX_TIMER_DISARMED,
+	POSIX_TIMER_ARMED,
+	POSIX_TIMER_REQUEUE_PENDING,
+};
+
 struct k_clock {
 	int	(*clock_getres)(const clockid_t which_clock,
 				struct timespec64 *tp);

