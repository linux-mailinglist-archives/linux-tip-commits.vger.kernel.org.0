Return-Path: <linux-tip-commits+bounces-4192-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 97638A5F27C
	for <lists+linux-tip-commits@lfdr.de>; Thu, 13 Mar 2025 12:34:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 03F903AB023
	for <lists+linux-tip-commits@lfdr.de>; Thu, 13 Mar 2025 11:33:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 741C3267B64;
	Thu, 13 Mar 2025 11:31:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="QqgYKVLU";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="7kuVaFN0"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7618726773D;
	Thu, 13 Mar 2025 11:31:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741865497; cv=none; b=tZh9tk4qokRcjGM0s6fmUEEui5Iv2+SsfNpfmIn1bdx9vNjliEhKkXuDPgzVc2UoCyaFu6FwS3WRk47+gTJ7Q7BGKG4LcG1ZytFNoHifFXwKJfYw3GKbP7PCaQpF4EUn7A4/gHRGLITvGkUbdXJFwTdeg5noIwMOnilm3RjdW/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741865497; c=relaxed/simple;
	bh=9mbv7lNgzxYw6dYI7mZps7yxx/RPBGSQD/LA4gDaWlE=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=lzL1U2dhTcvh9MytOpZgiloHrkLeTzMXqtJZEKWSu1svc4+oWDxSAejANbMrNrXwoYGVxOl+VCFYZm3dO3KNSgriPtcbApJhrg4LnNr2iNXISmz6wiO7nWxnHV89xNvfKmcs8e0cMww/touYzsgSs8v7EaOkh09Q5tmh9qRimJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=QqgYKVLU; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=7kuVaFN0; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 13 Mar 2025 11:31:32 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1741865492;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=93XYs/XO/MTQ2P3m2wfI+c9dFxTeQjMvyYhKg0E9kkE=;
	b=QqgYKVLU1hINzxm02X+/HzVH1Uc2jfJBwtkz5lBIVfhoHKAMg+6mqPvHT0iLJ1UCThWp4t
	EsI1R+0y78zac9apvXR6CURJK/Y6/fq6cUVAO0sCVRWaFqADjYofHV4NCCaiXgtvU5XVX9
	TI7Ci61+TGDXmC3NqubDSM5R2SEjHZTuEF6QgvIGxR56w/tgErodOIFvqntvRhLQkriFP6
	2s8KekCDNwD0c+92CYnun9mns4E+PbcJOpZKu/RSWIigIIa83BcAvKIUU/jNuT1L63emyu
	erv4g8ieoR8Gl6tjvAY7yufyo/Ea9cL95yT0WeIOZcvtiZku3XNArs3Q9GCRKg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1741865492;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=93XYs/XO/MTQ2P3m2wfI+c9dFxTeQjMvyYhKg0E9kkE=;
	b=7kuVaFN0dBQJhMW4MtA4IVnx+4aBOe7jTijOe8jappV14LwQ0T4DmV28d4YzjpZYhkBU0K
	P1yE7GSYOmXK6UAg==
From: "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] posix-timers: Remove a few paranoid warnings
Cc: Thomas Gleixner <tglx@linutronix.de>,
 Frederic Weisbecker <frederic@kernel.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250308155623.765462334@linutronix.de>
References: <20250308155623.765462334@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174186549209.14745.2321427735841251654.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     4c5cd058beb565ea02ff3db9236f01b2b7d78071
Gitweb:        https://git.kernel.org/tip/4c5cd058beb565ea02ff3db9236f01b2b7d78071
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Sat, 08 Mar 2025 17:48:24 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 13 Mar 2025 12:07:16 +01:00

posix-timers: Remove a few paranoid warnings

Warnings about a non-initialized timer or non-existing callbacks are just
useful for implementing new posix clocks, but there a NULL pointer
dereference is expected anyway. :)

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
Link: https://lore.kernel.org/all/20250308155623.765462334@linutronix.de


---
 kernel/time/posix-timers.c | 37 ++++++++-----------------------------
 1 file changed, 8 insertions(+), 29 deletions(-)

diff --git a/kernel/time/posix-timers.c b/kernel/time/posix-timers.c
index e908846..5591b15 100644
--- a/kernel/time/posix-timers.c
+++ b/kernel/time/posix-timers.c
@@ -682,7 +682,6 @@ void common_timer_get(struct k_itimer *timr, struct itimerspec64 *cur_setting)
 
 static int do_timer_gettime(timer_t timer_id,  struct itimerspec64 *setting)
 {
-	const struct k_clock *kc;
 	struct k_itimer *timr;
 	unsigned long flags;
 	int ret = 0;
@@ -692,11 +691,7 @@ static int do_timer_gettime(timer_t timer_id,  struct itimerspec64 *setting)
 		return -EINVAL;
 
 	memset(setting, 0, sizeof(*setting));
-	kc = timr->kclock;
-	if (WARN_ON_ONCE(!kc || !kc->timer_get))
-		ret = -EINVAL;
-	else
-		kc->timer_get(timr, setting);
+	timr->kclock->timer_get(timr, setting);
 
 	unlock_timer(timr, flags);
 	return ret;
@@ -824,7 +819,6 @@ static void common_timer_wait_running(struct k_itimer *timer)
 static struct k_itimer *timer_wait_running(struct k_itimer *timer,
 					   unsigned long *flags)
 {
-	const struct k_clock *kc = READ_ONCE(timer->kclock);
 	timer_t timer_id = READ_ONCE(timer->it_id);
 
 	/* Prevent kfree(timer) after dropping the lock */
@@ -835,8 +829,7 @@ static struct k_itimer *timer_wait_running(struct k_itimer *timer,
 	 * kc->timer_wait_running() might drop RCU lock. So @timer
 	 * cannot be touched anymore after the function returns!
 	 */
-	if (!WARN_ON_ONCE(!kc->timer_wait_running))
-		kc->timer_wait_running(timer);
+	timer->kclock->timer_wait_running(timer);
 
 	rcu_read_unlock();
 	/* Relock the timer. It might be not longer hashed. */
@@ -899,7 +892,6 @@ static int do_timer_settime(timer_t timer_id, int tmr_flags,
 			    struct itimerspec64 *new_spec64,
 			    struct itimerspec64 *old_spec64)
 {
-	const struct k_clock *kc;
 	struct k_itimer *timr;
 	unsigned long flags;
 	int error;
@@ -922,11 +914,7 @@ retry:
 	/* Prevent signal delivery and rearming. */
 	timr->it_signal_seq++;
 
-	kc = timr->kclock;
-	if (WARN_ON_ONCE(!kc || !kc->timer_set))
-		error = -EINVAL;
-	else
-		error = kc->timer_set(timr, tmr_flags, new_spec64, old_spec64);
+	error = timr->kclock->timer_set(timr, tmr_flags, new_spec64, old_spec64);
 
 	if (error == TIMER_RETRY) {
 		// We already got the old time...
@@ -1008,18 +996,6 @@ static inline void posix_timer_cleanup_ignored(struct k_itimer *tmr)
 	}
 }
 
-static inline int timer_delete_hook(struct k_itimer *timer)
-{
-	const struct k_clock *kc = timer->kclock;
-
-	/* Prevent signal delivery and rearming. */
-	timer->it_signal_seq++;
-
-	if (WARN_ON_ONCE(!kc || !kc->timer_del))
-		return -EINVAL;
-	return kc->timer_del(timer);
-}
-
 /* Delete a POSIX.1b interval timer. */
 SYSCALL_DEFINE1(timer_delete, timer_t, timer_id)
 {
@@ -1032,7 +1008,10 @@ retry_delete:
 	if (!timer)
 		return -EINVAL;
 
-	if (unlikely(timer_delete_hook(timer) == TIMER_RETRY)) {
+	/* Prevent signal delivery and rearming. */
+	timer->it_signal_seq++;
+
+	if (unlikely(timer->kclock->timer_del(timer) == TIMER_RETRY)) {
 		/* Unlocks and relocks the timer if it still exists */
 		timer = timer_wait_running(timer, &flags);
 		goto retry_delete;
@@ -1078,7 +1057,7 @@ retry_delete:
 	 * mechanism. Worse, that timer mechanism might run the expiry
 	 * function concurrently.
 	 */
-	if (timer_delete_hook(timer) == TIMER_RETRY) {
+	if (timer->kclock->timer_del(timer) == TIMER_RETRY) {
 		/*
 		 * Timer is expired concurrently, prevent livelocks
 		 * and pointless spinning on RT.

