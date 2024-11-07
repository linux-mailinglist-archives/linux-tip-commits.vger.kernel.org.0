Return-Path: <linux-tip-commits+bounces-2799-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D46459BFBA4
	for <lists+linux-tip-commits@lfdr.de>; Thu,  7 Nov 2024 02:35:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9445C2815AF
	for <lists+linux-tip-commits@lfdr.de>; Thu,  7 Nov 2024 01:35:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 770BB19995A;
	Thu,  7 Nov 2024 01:31:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="OSIMBMff";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="EDTE1zEN"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FB89195F22;
	Thu,  7 Nov 2024 01:31:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730943108; cv=none; b=ibStUOOyWcBN+H1G8EcMndvNo57inHzXWkZUIpTSygbuhU8h9+nwQQ5b0Oxn/jUyXriH2Y08uvlo90+lJws9pTZ5ciTNfu9w3DDqgDpUl4cOWwR8dQbJxNjyZgcRT2TJ0aAcok8IVt+v4gjWMIrMo/xw0SKNInBFgas0sVMl5NE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730943108; c=relaxed/simple;
	bh=JOmMNBWm94ex8FqGSLz8M3qX6Z7sM7ni6y4Zlh/UXdk=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=a4q3Zmso047+hTgDQWjPfd1eLhlcmXxAcMbvNPE4jVdtxLLBWYZFudkVfig1GZ5Xi6+u9JbD6b4xc1y05nc6G4izLbBtP+66Hq7W1s0Mg18VIko3yTxZ52kWQF7JjVKWcBQoQZBrwdgotVbvoNBeU/klz7nFKwva66esk5yngbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=OSIMBMff; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=EDTE1zEN; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 07 Nov 2024 01:31:43 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1730943103;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/mO0iRzww3zeEeiDJoxj+Y7cDuZ4QtPWfrHxpX9+ljs=;
	b=OSIMBMffor3quPYLY5X5fwvf4owrGW4C+06d+QPPuBGrtA+yfyxVbhy9irEl0YSnlxOu02
	xF2Pr1/KIdIMG6M5sdpvnRFMGid47AhkbO3YQ11dxzwG2Jk5OwSCGhcxn9PlDYr+9YfAHI
	+c5wOdZGK0wfm4ZEONzgHQ0YeA1JW9YnkKtqf5lzbmBZlO6giQf/a5Ee4osAhzzpKwKA1c
	Mh8yubdawoHrLXVTq3TQWchO+t/nzPWW1rhgOrUdGxtRPKHDEcn6iuE06ZgvXZS96IrrIG
	o2iCaTj/FYk53zvqtHHkJkdZi+gau+8nDN6rYuOrk74b/4leY/oS8qzIke/rGQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1730943103;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/mO0iRzww3zeEeiDJoxj+Y7cDuZ4QtPWfrHxpX9+ljs=;
	b=EDTE1zENq9QZGafwezIRoliNhWcHZMDAlwkTJLrxwxVvVE2tLklLlzONKJgyYUULdEIBao
	BDpf+lw8EAT3O5CQ==
From: "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] posix-timers: Make signal delivery consistent
Cc: Thomas Gleixner <tglx@linutronix.de>,
 Frederic Weisbecker <frederic@kernel.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20241105064213.040348644@linutronix.de>
References: <20241105064213.040348644@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173094310303.32228.17691292510523561481.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     513793bc6ab331b947111e8efaf8fcef33fb83e5
Gitweb:        https://git.kernel.org/tip/513793bc6ab331b947111e8efaf8fcef33fb83e5
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Tue, 05 Nov 2024 09:14:31 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 07 Nov 2024 02:14:43 +01:00

posix-timers: Make signal delivery consistent

Signals of timers which are reprogammed, disarmed or deleted can deliver
signals related to the past. The POSIX spec is blury about this:

 - "The effect of disarming or resetting a timer with pending expiration
    notifications is unspecified."

 - "The disposition of pending signals for the deleted timer is
    unspecified."

In both cases it is reasonable to expect that pending signals are
discarded. Especially in the reprogramming case it does not make sense to
account for previous overruns or to deliver a signal for a timer which has
been disarmed. This makes the behaviour consistent and understandable.

Remove the si_sys_private check from the signal delivery code and invoke
posix_timer_deliver_signal() unconditionally for posix timer related
signals.

Change posix_timer_deliver_signal() so it controls the actual signal
delivery via the return value. It now instructs the signal code to drop the
signal when:

  1) The timer does not longer exist in the hash table

  2) The timer signal_seq value is not the same as the si_sys_private value
     which was set when the signal was queued.

This is also a preparatory change to embed the sigqueue into the k_itimer
structure, which in turn allows to remove the si_sys_private magic.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
Link: https://lore.kernel.org/all/20241105064213.040348644@linutronix.de

---
 include/linux/posix-timers.h   |  2 --
 kernel/signal.c                |  6 ++----
 kernel/time/posix-cpu-timers.c |  2 +-
 kernel/time/posix-timers.c     | 28 ++++++++++++++++------------
 4 files changed, 19 insertions(+), 19 deletions(-)

diff --git a/include/linux/posix-timers.h b/include/linux/posix-timers.h
index 02afbb4..8c6d974 100644
--- a/include/linux/posix-timers.h
+++ b/include/linux/posix-timers.h
@@ -137,8 +137,6 @@ static inline void clear_posix_cputimers_work(struct task_struct *p) { }
 static inline void posix_cputimers_init_work(void) { }
 #endif
 
-#define REQUEUE_PENDING 1
-
 /**
  * struct k_itimer - POSIX.1b interval timer structure.
  * @list:		List head for binding the timer to signals->posix_timers
diff --git a/kernel/signal.c b/kernel/signal.c
index df34aa4..68e6bc7 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -550,10 +550,8 @@ still_pending:
 		list_del_init(&first->list);
 		copy_siginfo(info, &first->info);
 
-		*resched_timer =
-			(first->flags & SIGQUEUE_PREALLOC) &&
-			(info->si_code == SI_TIMER) &&
-			(info->si_sys_private);
+		*resched_timer = (first->flags & SIGQUEUE_PREALLOC) &&
+				 (info->si_code == SI_TIMER);
 
 		__sigqueue_free(first);
 	} else {
diff --git a/kernel/time/posix-cpu-timers.c b/kernel/time/posix-cpu-timers.c
index 5f444e3..4305c00 100644
--- a/kernel/time/posix-cpu-timers.c
+++ b/kernel/time/posix-cpu-timers.c
@@ -746,7 +746,7 @@ static void __posix_cpu_timer_get(struct k_itimer *timer, struct itimerspec64 *i
 	 *  - Timers which expired, but the signal has not yet been
 	 *    delivered
 	 */
-	if (iv && ((timer->it_signal_seq & REQUEUE_PENDING) || sigev_none))
+	if (iv && timer->it_status != POSIX_TIMER_ARMED)
 		expires = bump_cpu_timer(timer, now);
 	else
 		expires = cpu_timer_getexpires(&timer->it.cpu);
diff --git a/kernel/time/posix-timers.c b/kernel/time/posix-timers.c
index dd72b8e..b380e25 100644
--- a/kernel/time/posix-timers.c
+++ b/kernel/time/posix-timers.c
@@ -269,7 +269,10 @@ bool posixtimer_deliver_signal(struct kernel_siginfo *info)
 	if (!timr)
 		goto out;
 
-	if (timr->it_interval && timr->it_signal_seq == info->si_sys_private) {
+	if (timr->it_signal_seq != info->si_sys_private)
+		goto out_unlock;
+
+	if (timr->it_interval && !WARN_ON_ONCE(timr->it_status != POSIX_TIMER_REQUEUE_PENDING)) {
 		timr->kclock->timer_rearm(timr);
 
 		timr->it_status = POSIX_TIMER_ARMED;
@@ -281,6 +284,7 @@ bool posixtimer_deliver_signal(struct kernel_siginfo *info)
 	}
 	ret = true;
 
+out_unlock:
 	unlock_timer(timr, flags);
 out:
 	spin_lock(&current->sighand->siglock);
@@ -293,19 +297,18 @@ out:
 int posix_timer_queue_signal(struct k_itimer *timr)
 {
 	enum posix_timer_state state = POSIX_TIMER_DISARMED;
-	int ret, si_private = 0;
 	enum pid_type type;
+	int ret;
 
 	lockdep_assert_held(&timr->it_lock);
 
-	if (timr->it_interval) {
+	if (timr->it_interval)
 		state = POSIX_TIMER_REQUEUE_PENDING;
-		si_private = ++timr->it_signal_seq;
-	}
+
 	timr->it_status = state;
 
 	type = !(timr->it_sigev_notify & SIGEV_THREAD_ID) ? PIDTYPE_TGID : PIDTYPE_PID;
-	ret = send_sigqueue(timr->sigq, timr->it_pid, type, si_private);
+	ret = send_sigqueue(timr->sigq, timr->it_pid, type, timr->it_signal_seq);
 	/* If we failed to send the signal the timer stops. */
 	return ret > 0;
 }
@@ -663,7 +666,7 @@ void common_timer_get(struct k_itimer *timr, struct itimerspec64 *cur_setting)
 	 * is a SIGEV_NONE timer move the expiry time forward by intervals,
 	 * so expiry is > now.
 	 */
-	if (iv && (timr->it_signal_seq & REQUEUE_PENDING || sig_none))
+	if (iv && timr->it_status != POSIX_TIMER_ARMED)
 		timr->it_overrun += kc->timer_forward(timr, now);
 
 	remaining = kc->timer_remaining(timr, now);
@@ -863,8 +866,6 @@ void posix_timer_set_common(struct k_itimer *timer, struct itimerspec64 *new_set
 	else
 		timer->it_interval = 0;
 
-	/* Prevent reloading in case there is a signal pending */
-	timer->it_signal_seq = (timer->it_signal_seq + 2) & ~REQUEUE_PENDING;
 	/* Reset overrun accounting */
 	timer->it_overrun_last = 0;
 	timer->it_overrun = -1LL;
@@ -882,8 +883,6 @@ int common_timer_set(struct k_itimer *timr, int flags,
 	if (old_setting)
 		common_timer_get(timr, old_setting);
 
-	/* Prevent rearming by clearing the interval */
-	timr->it_interval = 0;
 	/*
 	 * Careful here. On SMP systems the timer expiry function could be
 	 * active and spinning on timr->it_lock.
@@ -933,6 +932,9 @@ retry:
 	if (old_spec64)
 		old_spec64->it_interval = ktime_to_timespec64(timr->it_interval);
 
+	/* Prevent signal delivery and rearming. */
+	timr->it_signal_seq++;
+
 	kc = timr->kclock;
 	if (WARN_ON_ONCE(!kc || !kc->timer_set))
 		error = -EINVAL;
@@ -1001,7 +1003,6 @@ int common_timer_del(struct k_itimer *timer)
 {
 	const struct k_clock *kc = timer->kclock;
 
-	timer->it_interval = 0;
 	if (kc->timer_try_to_cancel(timer) < 0)
 		return TIMER_RETRY;
 	timer->it_status = POSIX_TIMER_DISARMED;
@@ -1012,6 +1013,9 @@ static inline int timer_delete_hook(struct k_itimer *timer)
 {
 	const struct k_clock *kc = timer->kclock;
 
+	/* Prevent signal delivery and rearming. */
+	timer->it_signal_seq++;
+
 	if (WARN_ON_ONCE(!kc || !kc->timer_del))
 		return -EINVAL;
 	return kc->timer_del(timer);

