Return-Path: <linux-tip-commits+bounces-4187-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E0178A5F273
	for <lists+linux-tip-commits@lfdr.de>; Thu, 13 Mar 2025 12:33:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C31F91664D0
	for <lists+linux-tip-commits@lfdr.de>; Thu, 13 Mar 2025 11:33:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36E0126771B;
	Thu, 13 Mar 2025 11:31:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="TTWfA8Dc";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="kexR8M+s"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39E2F2676EC;
	Thu, 13 Mar 2025 11:31:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741865494; cv=none; b=n/MIn2Q5D0Ns/cxh/FUsP2/k489Vc3/xd796RCVOLXV7t9FmwrqzZgbvz0jC+4a1bw0E6Q58ulpZY7WJB5ieoozlqXSjXk82s/DHGvl0tX+zHJ+N4yFTWvQDpnhbrs/O8GKPY6PKG/vGtn87/yKKWTvXc0PQbl1DVatPoihY08A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741865494; c=relaxed/simple;
	bh=f6SW9HYDkTxYkFAsM2se370qU/zdCXDppfUlS2CCcMs=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=FwEKO42zmknCggOKGv/+SvvEUpopwyVDNdi3QbJyazYUetHEy/MDeFuUzu8sa3W5fJGlvbZ3U3o4qPB1Crg8CGcv+9Hsrulfzk/cL/lre9XhRZU3IK2vbjYW3jInOl3xedl9C8Q7CfkV9GEf53XQnBpInQNX6rHuBuTaohifTyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=TTWfA8Dc; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=kexR8M+s; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 13 Mar 2025 11:31:29 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1741865490;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xKIHbs0JqGH1yMK9HSLDBeO8DMVx4T/A0VqKSmYbonU=;
	b=TTWfA8Dc6tc3k5UTevxfrt9CbAaRGANu1NosCJTh5/7EM77Ro/YHKspL/TqGArogKX5qPk
	/WgZh25VGIfEj2DPt/jaOBbsBnr93MB1irlxWob443SiknDE5pWXVDq+VD0w29IV/rXC89
	vUkYMkFXGA/PJ5aUUvSHHVpleoFJqTvyiazi/z0qnxFTijTYaKzPqnpcX90m9hZOgZnkG6
	iJ67Gpgbf+5edvJjVxb+DpJ3/TzetER6MkaZzeD1PzfuU/rnD1P5btIzaas3SSueApf2x2
	uLR5sIxSCaO4OPGeHmB3mp2EkjYmmBntoqIzWj26l+vIihoPi66RFUVQN4rz3g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1741865490;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xKIHbs0JqGH1yMK9HSLDBeO8DMVx4T/A0VqKSmYbonU=;
	b=kexR8M+smDUTRcWPzsng3SmPHRZkXG7431D8a9wUAPilxcFWnCwgaVkAYILHgwTtkPxEUp
	NXA5DVnJSMlHZVDw==
From: "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] posix-timers: Simplify lock/unlock_timer()
Cc: Thomas Gleixner <tglx@linutronix.de>,
 Frederic Weisbecker <frederic@kernel.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250308155623.959825668@linutronix.de>
References: <20250308155623.959825668@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174186548981.14745.1248150960378546378.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     50f53b23f1e3fae071381af9a15ac1028c4efc42
Gitweb:        https://git.kernel.org/tip/50f53b23f1e3fae071381af9a15ac1028c4efc42
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Sat, 08 Mar 2025 17:48:30 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 13 Mar 2025 12:07:17 +01:00

posix-timers: Simplify lock/unlock_timer()

Since the integration of sigqueue into the timer struct, lock_timer() is
only used in task context. So taking the lock with irqsave() is not longer
required.

Convert it to use spin_[un]lock_irq().

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
Link: https://lore.kernel.org/all/20250308155623.959825668@linutronix.de

---
 kernel/time/posix-timers.c | 70 +++++++++++++++----------------------
 1 file changed, 29 insertions(+), 41 deletions(-)

diff --git a/kernel/time/posix-timers.c b/kernel/time/posix-timers.c
index 988cbfb..4d25bea 100644
--- a/kernel/time/posix-timers.c
+++ b/kernel/time/posix-timers.c
@@ -53,14 +53,19 @@ static const struct k_clock clock_realtime, clock_monotonic;
 #error "SIGEV_THREAD_ID must not share bit with other SIGEV values!"
 #endif
 
-static struct k_itimer *__lock_timer(timer_t timer_id, unsigned long *flags);
+static struct k_itimer *__lock_timer(timer_t timer_id);
 
-#define lock_timer(tid, flags)						   \
-({	struct k_itimer *__timr;					   \
-	__cond_lock(&__timr->it_lock, __timr = __lock_timer(tid, flags));  \
-	__timr;								   \
+#define lock_timer(tid)							\
+({	struct k_itimer *__timr;					\
+	__cond_lock(&__timr->it_lock, __timr = __lock_timer(tid));	\
+	__timr;								\
 })
 
+static inline void unlock_timer(struct k_itimer *timr)
+{
+	spin_unlock_irq(&timr->it_lock);
+}
+
 static int hash(struct signal_struct *sig, unsigned int nr)
 {
 	return hash_32(hash32_ptr(sig) ^ nr, HASH_BITS(posix_timers_hashtable));
@@ -144,11 +149,6 @@ static int posix_timer_add(struct k_itimer *timer)
 	return -EAGAIN;
 }
 
-static inline void unlock_timer(struct k_itimer *timr, unsigned long flags)
-{
-	spin_unlock_irqrestore(&timr->it_lock, flags);
-}
-
 static int posix_get_realtime_timespec(clockid_t which_clock, struct timespec64 *tp)
 {
 	ktime_get_real_ts64(tp);
@@ -538,7 +538,7 @@ COMPAT_SYSCALL_DEFINE3(timer_create, clockid_t, which_clock,
 }
 #endif
 
-static struct k_itimer *__lock_timer(timer_t timer_id, unsigned long *flags)
+static struct k_itimer *__lock_timer(timer_t timer_id)
 {
 	struct k_itimer *timr;
 
@@ -580,14 +580,14 @@ static struct k_itimer *__lock_timer(timer_t timer_id, unsigned long *flags)
 	guard(rcu)();
 	timr = posix_timer_by_id(timer_id);
 	if (timr) {
-		spin_lock_irqsave(&timr->it_lock, *flags);
+		spin_lock_irq(&timr->it_lock);
 		/*
 		 * Validate under timr::it_lock that timr::it_signal is
 		 * still valid. Pairs with #1 above.
 		 */
 		if (timr->it_signal == current->signal)
 			return timr;
-		spin_unlock_irqrestore(&timr->it_lock, *flags);
+		spin_unlock_irq(&timr->it_lock);
 	}
 	return NULL;
 }
@@ -680,17 +680,16 @@ void common_timer_get(struct k_itimer *timr, struct itimerspec64 *cur_setting)
 static int do_timer_gettime(timer_t timer_id,  struct itimerspec64 *setting)
 {
 	struct k_itimer *timr;
-	unsigned long flags;
 	int ret = 0;
 
-	timr = lock_timer(timer_id, &flags);
+	timr = lock_timer(timer_id);
 	if (!timr)
 		return -EINVAL;
 
 	memset(setting, 0, sizeof(*setting));
 	timr->kclock->timer_get(timr, setting);
 
-	unlock_timer(timr, flags);
+	unlock_timer(timr);
 	return ret;
 }
 
@@ -746,15 +745,14 @@ SYSCALL_DEFINE2(timer_gettime32, timer_t, timer_id,
 SYSCALL_DEFINE1(timer_getoverrun, timer_t, timer_id)
 {
 	struct k_itimer *timr;
-	unsigned long flags;
 	int overrun;
 
-	timr = lock_timer(timer_id, &flags);
+	timr = lock_timer(timer_id);
 	if (!timr)
 		return -EINVAL;
 
 	overrun = timer_overrun_to_int(timr);
-	unlock_timer(timr, flags);
+	unlock_timer(timr);
 
 	return overrun;
 }
@@ -813,14 +811,13 @@ static void common_timer_wait_running(struct k_itimer *timer)
  * when the task which tries to delete or disarm the timer has preempted
  * the task which runs the expiry in task work context.
  */
-static struct k_itimer *timer_wait_running(struct k_itimer *timer,
-					   unsigned long *flags)
+static struct k_itimer *timer_wait_running(struct k_itimer *timer)
 {
 	timer_t timer_id = READ_ONCE(timer->it_id);
 
 	/* Prevent kfree(timer) after dropping the lock */
 	scoped_guard (rcu) {
-		unlock_timer(timer, *flags);
+		unlock_timer(timer);
 		/*
 		 * kc->timer_wait_running() might drop RCU lock. So @timer
 		 * cannot be touched anymore after the function returns!
@@ -829,7 +826,7 @@ static struct k_itimer *timer_wait_running(struct k_itimer *timer,
 	}
 
 	/* Relock the timer. It might be not longer hashed. */
-	return lock_timer(timer_id, flags);
+	return lock_timer(timer_id);
 }
 
 /*
@@ -889,7 +886,6 @@ static int do_timer_settime(timer_t timer_id, int tmr_flags,
 			    struct itimerspec64 *old_spec64)
 {
 	struct k_itimer *timr;
-	unsigned long flags;
 	int error;
 
 	if (!timespec64_valid(&new_spec64->it_interval) ||
@@ -899,7 +895,7 @@ static int do_timer_settime(timer_t timer_id, int tmr_flags,
 	if (old_spec64)
 		memset(old_spec64, 0, sizeof(*old_spec64));
 
-	timr = lock_timer(timer_id, &flags);
+	timr = lock_timer(timer_id);
 retry:
 	if (!timr)
 		return -EINVAL;
@@ -916,10 +912,10 @@ retry:
 		// We already got the old time...
 		old_spec64 = NULL;
 		/* Unlocks and relocks the timer if it still exists */
-		timr = timer_wait_running(timr, &flags);
+		timr = timer_wait_running(timr);
 		goto retry;
 	}
-	unlock_timer(timr, flags);
+	unlock_timer(timr);
 
 	return error;
 }
@@ -995,10 +991,7 @@ static inline void posix_timer_cleanup_ignored(struct k_itimer *tmr)
 /* Delete a POSIX.1b interval timer. */
 SYSCALL_DEFINE1(timer_delete, timer_t, timer_id)
 {
-	struct k_itimer *timer;
-	unsigned long flags;
-
-	timer = lock_timer(timer_id, &flags);
+	struct k_itimer *timer = lock_timer(timer_id);
 
 retry_delete:
 	if (!timer)
@@ -1009,7 +1002,7 @@ retry_delete:
 
 	if (unlikely(timer->kclock->timer_del(timer) == TIMER_RETRY)) {
 		/* Unlocks and relocks the timer if it still exists */
-		timer = timer_wait_running(timer, &flags);
+		timer = timer_wait_running(timer);
 		goto retry_delete;
 	}
 
@@ -1028,7 +1021,7 @@ retry_delete:
 		WRITE_ONCE(timer->it_signal, NULL);
 	}
 
-	unlock_timer(timer, flags);
+	unlock_timer(timer);
 	posix_timer_unhash_and_free(timer);
 	return 0;
 }
@@ -1039,12 +1032,7 @@ retry_delete:
  */
 static void itimer_delete(struct k_itimer *timer)
 {
-	unsigned long flags;
-
-	/*
-	 * irqsave is required to make timer_wait_running() work.
-	 */
-	spin_lock_irqsave(&timer->it_lock, flags);
+	spin_lock_irq(&timer->it_lock);
 
 retry_delete:
 	/*
@@ -1065,7 +1053,7 @@ retry_delete:
 		 * do_exit() only for the last thread of the thread group.
 		 * So no other task can access and delete that timer.
 		 */
-		if (WARN_ON_ONCE(timer_wait_running(timer, &flags) != timer))
+		if (WARN_ON_ONCE(timer_wait_running(timer) != timer))
 			return;
 
 		goto retry_delete;
@@ -1082,7 +1070,7 @@ retry_delete:
 	 */
 	WRITE_ONCE(timer->it_signal, NULL);
 
-	spin_unlock_irqrestore(&timer->it_lock, flags);
+	spin_unlock_irq(&timer->it_lock);
 	posix_timer_unhash_and_free(timer);
 }
 

