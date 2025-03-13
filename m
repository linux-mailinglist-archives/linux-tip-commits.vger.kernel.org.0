Return-Path: <linux-tip-commits+bounces-4189-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE085A5F274
	for <lists+linux-tip-commits@lfdr.de>; Thu, 13 Mar 2025 12:33:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A228F7ADE76
	for <lists+linux-tip-commits@lfdr.de>; Thu, 13 Mar 2025 11:32:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A28CF267723;
	Thu, 13 Mar 2025 11:31:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="cJzXgzVH";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Dd7fHycs"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8B892676F9;
	Thu, 13 Mar 2025 11:31:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741865494; cv=none; b=H+jfV5ANiglMQRmB8ZowOiDrgWBQL/AU+zk4ySwB0sK5cZhE/l/JoTs1g/sOaI7hKU51zWDFrpi/sQe9N/mE6p8HZGIWFS9ji6AVoXOG8EpdVF0nt1HeLbgfPHZz0D5Qm2C77vXAygnMkSlITvpKVcmPwDl2t0+ax9fiimtsU3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741865494; c=relaxed/simple;
	bh=Ang4FFsQtMiRe6a9V3lBjP6em3c35zIwzKRJq7rSrL0=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=mMU+UJZRtiCagVMSpoMRYSG2cAGxhlisekCm0LeHvG5J5+7kDapmf0DXjFxotX1q57B7Xc5Cs2WrTyzpivm28K0YdKFbV/3QZ7AxbR4fEejY79dWwlV4dVXL8HG092MGPhDZIr4JR4rDsHmyYcFBk0wvGkn9K9gE/tvMTdrtheE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=cJzXgzVH; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Dd7fHycs; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 13 Mar 2025 11:31:30 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1741865491;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xYq7Ur/xGIxYhls0TDFv2/W3hxBymwjCRCf7iFdcT6M=;
	b=cJzXgzVHAojhYpzyVAGe5pGrktiT/KGnV485JF+d8xlDfA/SP19Fq6s52Zqw1mYAlgl+/c
	cwKRij5+JlDg3g4wE1M0zzY6zTC19csLu8HRBltppovdLpwtKK0Ch/feGeKW+mbw547t+v
	hkU3Q34ORi73O37qBNCLWyowGtt+yruFCpjcOVJ6Rsgcd5cullhlr7N3tCK0flWfwDfbZI
	YictBPNRKKve3HS+lpI6919rA7AbR87dagf3ViJ6TYqW0KGdH68AB7veh4J9Zo8x29A0Gw
	SE8/3zXy2/Li0OLLkVSZQp70Q8s2D6ufOrzDOw5zeQXgsO4ugwNgLuftdLbiHQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1741865491;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xYq7Ur/xGIxYhls0TDFv2/W3hxBymwjCRCf7iFdcT6M=;
	b=Dd7fHycskW+3EzQl8TjyIgToelQaQaMOGzsYFrbagPVk/qR1T6KYHkpAUUjxx1EQHHpglg
	rwNSJ/Fk1Bfq89BA==
From: "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] posix-timers: Use guards in a few places
Cc: Thomas Gleixner <tglx@linutronix.de>,
 Frederic Weisbecker <frederic@kernel.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250308155623.892762130@linutronix.de>
References: <20250308155623.892762130@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174186549062.14745.11291549489053287559.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     a31a300c4daba82b14eb77179b0b6fc729b9bad5
Gitweb:        https://git.kernel.org/tip/a31a300c4daba82b14eb77179b0b6fc729b9bad5
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Sat, 08 Mar 2025 17:48:28 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 13 Mar 2025 12:07:17 +01:00

posix-timers: Use guards in a few places

Switch locking and RCU to guards where applicable.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
Link: https://lore.kernel.org/all/20250308155623.892762130@linutronix.de

---
 kernel/time/posix-timers.c | 68 ++++++++++++++++---------------------
 1 file changed, 30 insertions(+), 38 deletions(-)

diff --git a/kernel/time/posix-timers.c b/kernel/time/posix-timers.c
index b7bf863..988cbfb 100644
--- a/kernel/time/posix-timers.c
+++ b/kernel/time/posix-timers.c
@@ -397,9 +397,8 @@ void posixtimer_free_timer(struct k_itimer *tmr)
 
 static void posix_timer_unhash_and_free(struct k_itimer *tmr)
 {
-	spin_lock(&hash_lock);
-	hlist_del_rcu(&tmr->t_hash);
-	spin_unlock(&hash_lock);
+	scoped_guard (spinlock, &hash_lock)
+		hlist_del_rcu(&tmr->t_hash);
 	posixtimer_putref(tmr);
 }
 
@@ -443,9 +442,8 @@ static int do_timer_create(clockid_t which_clock, struct sigevent *event,
 	new_timer->it_overrun = -1LL;
 
 	if (event) {
-		rcu_read_lock();
-		new_timer->it_pid = get_pid(good_sigevent(event));
-		rcu_read_unlock();
+		scoped_guard (rcu)
+			new_timer->it_pid = get_pid(good_sigevent(event));
 		if (!new_timer->it_pid) {
 			error = -EINVAL;
 			goto out;
@@ -579,7 +577,7 @@ static struct k_itimer *__lock_timer(timer_t timer_id, unsigned long *flags)
 	 * can't change, but timr::it_signal becomes NULL during
 	 * destruction.
 	 */
-	rcu_read_lock();
+	guard(rcu)();
 	timr = posix_timer_by_id(timer_id);
 	if (timr) {
 		spin_lock_irqsave(&timr->it_lock, *flags);
@@ -587,14 +585,10 @@ static struct k_itimer *__lock_timer(timer_t timer_id, unsigned long *flags)
 		 * Validate under timr::it_lock that timr::it_signal is
 		 * still valid. Pairs with #1 above.
 		 */
-		if (timr->it_signal == current->signal) {
-			rcu_read_unlock();
+		if (timr->it_signal == current->signal)
 			return timr;
-		}
 		spin_unlock_irqrestore(&timr->it_lock, *flags);
 	}
-	rcu_read_unlock();
-
 	return NULL;
 }
 
@@ -825,16 +819,15 @@ static struct k_itimer *timer_wait_running(struct k_itimer *timer,
 	timer_t timer_id = READ_ONCE(timer->it_id);
 
 	/* Prevent kfree(timer) after dropping the lock */
-	rcu_read_lock();
-	unlock_timer(timer, *flags);
-
-	/*
-	 * kc->timer_wait_running() might drop RCU lock. So @timer
-	 * cannot be touched anymore after the function returns!
-	 */
-	timer->kclock->timer_wait_running(timer);
+	scoped_guard (rcu) {
+		unlock_timer(timer, *flags);
+		/*
+		 * kc->timer_wait_running() might drop RCU lock. So @timer
+		 * cannot be touched anymore after the function returns!
+		 */
+		timer->kclock->timer_wait_running(timer);
+	}
 
-	rcu_read_unlock();
 	/* Relock the timer. It might be not longer hashed. */
 	return lock_timer(timer_id, flags);
 }
@@ -1020,20 +1013,20 @@ retry_delete:
 		goto retry_delete;
 	}
 
-	spin_lock(&current->sighand->siglock);
-	hlist_del(&timer->list);
-	posix_timer_cleanup_ignored(timer);
-	/*
-	 * A concurrent lookup could check timer::it_signal lockless. It
-	 * will reevaluate with timer::it_lock held and observe the NULL.
-	 *
-	 * It must be written with siglock held so that the signal code
-	 * observes timer->it_signal == NULL in do_sigaction(SIG_IGN),
-	 * which prevents it from moving a pending signal of a deleted
-	 * timer to the ignore list.
-	 */
-	WRITE_ONCE(timer->it_signal, NULL);
-	spin_unlock(&current->sighand->siglock);
+	scoped_guard (spinlock, &current->sighand->siglock) {
+		hlist_del(&timer->list);
+		posix_timer_cleanup_ignored(timer);
+		/*
+		 * A concurrent lookup could check timer::it_signal lockless. It
+		 * will reevaluate with timer::it_lock held and observe the NULL.
+		 *
+		 * It must be written with siglock held so that the signal code
+		 * observes timer->it_signal == NULL in do_sigaction(SIG_IGN),
+		 * which prevents it from moving a pending signal of a deleted
+		 * timer to the ignore list.
+		 */
+		WRITE_ONCE(timer->it_signal, NULL);
+	}
 
 	unlock_timer(timer, flags);
 	posix_timer_unhash_and_free(timer);
@@ -1106,9 +1099,8 @@ void exit_itimers(struct task_struct *tsk)
 		return;
 
 	/* Protect against concurrent read via /proc/$PID/timers */
-	spin_lock_irq(&tsk->sighand->siglock);
-	hlist_move_list(&tsk->signal->posix_timers, &timers);
-	spin_unlock_irq(&tsk->sighand->siglock);
+	scoped_guard (spinlock_irq, &tsk->sighand->siglock)
+		hlist_move_list(&tsk->signal->posix_timers, &timers);
 
 	/* The timers are not longer accessible via tsk::signal */
 	while (!hlist_empty(&timers)) {

