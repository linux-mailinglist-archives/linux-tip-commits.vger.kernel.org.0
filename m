Return-Path: <linux-tip-commits+bounces-3416-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 63980A3978D
	for <lists+linux-tip-commits@lfdr.de>; Tue, 18 Feb 2025 10:52:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 625773AE60F
	for <lists+linux-tip-commits@lfdr.de>; Tue, 18 Feb 2025 09:48:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47B0923BF80;
	Tue, 18 Feb 2025 09:46:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="nD/2g9P5";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="DCOVdQDD"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C22F2376F7;
	Tue, 18 Feb 2025 09:46:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739871997; cv=none; b=i9XOhbkAmVHrl+JZcN4dSdnhWq7M/vPyrHyCgzg5UEjyKRFMWXWKe2JqU9VWHNVdpKEN+pUn4dtpXm1rFivtFyCdwNPFJmaxMnawcYK2+WltbklMWWi4+ftweImj6vZh1mcq4HxzktD0rltR5IytJW1lsWHd7C8YJplAuNf2HPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739871997; c=relaxed/simple;
	bh=NYhV5YMqcfuffYlMDl3EFtd5+BYIWxmMcKLl4kZpz/s=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=sONShfbRz2KBYkHFIc3tYEXfUHdh3NOs2/fiiL+FeVhLCr2cD44ZpNMOfHI7RMYxDjZhirvFr0oANVTL9eQjKzMvatUdn4ZsOIxh6DJ66jliI9iDlPK70ZVBWNJLScKWHEtFppvVSon1548gGaCgEFWC+VKOPxxORC3eChV31Fc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=nD/2g9P5; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=DCOVdQDD; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 18 Feb 2025 09:46:33 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1739871994;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1TD57jsXw7SjYGsioh1OT3mceG7xWJC3FxcBYajHPYs=;
	b=nD/2g9P5C9/IVYEl25ct43SE3jvO7zolOJG+MGN4SbuQ6S7WOtiX1yKqpEANq4YJJtFxqN
	01WZnToOO+jVJev0FH88Vm2sTggbtuwMRtPO2z+how3pxgxQrs7z+GPeZRPQ8m1dRkNnen
	l4tiy7zVxMRwZVGg9n/PbiEfbAkL2s2r45OOxRvfDViksJLpgwba7FKAsELOorXheFTZPZ
	HpZSRzFc7vouP8m6NPW1vntg79YzM5uGmpoVGdAoLDrJkMlaCiKbgTLWzM3feqjD8gTBVc
	JlaBq8VZg2TmuJ84nqOIbJPk2qj+6bHe3G+Yxt66zN+PnCRzNSFa5U/kmFsq7Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1739871994;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1TD57jsXw7SjYGsioh1OT3mceG7xWJC3FxcBYajHPYs=;
	b=DCOVdQDDPPRMFrKKXBq8KoNnGlrKZ7CoCGtH5I2H4iI/XbxjI/Vu1eHgqrh+HAdfkqwzP0
	PLKrGfFCNZZoNxDw==
From: "tip-bot2 for Nam Cao" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/cleanups] time: Switch to hrtimer_setup()
Cc: Nam Cao <namcao@linutronix.de>, Thomas Gleixner <tglx@linutronix.de>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: =?utf-8?q?=3C170bb691a0d59917c8268a98c80b607128fc9f7f=2E17387?=
 =?utf-8?q?46821=2Egit=2Enamcao=40linutronix=2Ede=3E?=
References: =?utf-8?q?=3C170bb691a0d59917c8268a98c80b607128fc9f7f=2E173874?=
 =?utf-8?q?6821=2Egit=2Enamcao=40linutronix=2Ede=3E?=
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173987199343.10177.396166451606753617.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/cleanups branch of tip:

Commit-ID:     f66b0acf394b8558f79c03336b579a47876a6940
Gitweb:        https://git.kernel.org/tip/f66b0acf394b8558f79c03336b579a47876a6940
Author:        Nam Cao <namcao@linutronix.de>
AuthorDate:    Wed, 05 Feb 2025 11:39:04 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 18 Feb 2025 10:32:33 +01:00

time: Switch to hrtimer_setup()

hrtimer_setup() takes the callback function pointer as argument and
initializes the timer completely.

Replace hrtimer_init() and the open coded initialization of
hrtimer::function with the new setup mechanism.

Signed-off-by: Nam Cao <namcao@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/all/170bb691a0d59917c8268a98c80b607128fc9f7f.1738746821.git.namcao@linutronix.de

---
 kernel/time/ntp.c                    | 3 +--
 kernel/time/posix-timers.c           | 7 +++----
 kernel/time/sched_clock.c            | 3 +--
 kernel/time/tick-broadcast-hrtimer.c | 3 +--
 kernel/time/tick-sched.c             | 6 ++----
 5 files changed, 8 insertions(+), 14 deletions(-)

diff --git a/kernel/time/ntp.c b/kernel/time/ntp.c
index 163e7a2..b837d3d 100644
--- a/kernel/time/ntp.c
+++ b/kernel/time/ntp.c
@@ -678,8 +678,7 @@ void ntp_notify_cmos_timer(bool offset_set)
 
 static void __init ntp_init_cmos_sync(void)
 {
-	hrtimer_init(&sync_hrtimer, CLOCK_REALTIME, HRTIMER_MODE_ABS);
-	sync_hrtimer.function = sync_timer_callback;
+	hrtimer_setup(&sync_hrtimer, sync_timer_callback, CLOCK_REALTIME, HRTIMER_MODE_ABS);
 }
 #else /* CONFIG_GENERIC_CMOS_UPDATE) || defined(CONFIG_RTC_SYSTOHC) */
 static inline void __init ntp_init_cmos_sync(void) { }
diff --git a/kernel/time/posix-timers.c b/kernel/time/posix-timers.c
index 1b675ae..58351f5 100644
--- a/kernel/time/posix-timers.c
+++ b/kernel/time/posix-timers.c
@@ -381,7 +381,7 @@ static void posix_timer_unhash_and_free(struct k_itimer *tmr)
 
 static int common_timer_create(struct k_itimer *new_timer)
 {
-	hrtimer_init(&new_timer->it.real.timer, new_timer->it_clock, 0);
+	hrtimer_setup(&new_timer->it.real.timer, posix_timer_fn, new_timer->it_clock, 0);
 	return 0;
 }
 
@@ -747,7 +747,7 @@ static void common_hrtimer_arm(struct k_itimer *timr, ktime_t expires,
 	/*
 	 * Posix magic: Relative CLOCK_REALTIME timers are not affected by
 	 * clock modifications, so they become CLOCK_MONOTONIC based under the
-	 * hood. See hrtimer_init(). Update timr->kclock, so the generic
+	 * hood. See hrtimer_setup(). Update timr->kclock, so the generic
 	 * functions which use timr->kclock->clock_get_*() work.
 	 *
 	 * Note: it_clock stays unmodified, because the next timer_set() might
@@ -756,8 +756,7 @@ static void common_hrtimer_arm(struct k_itimer *timr, ktime_t expires,
 	if (timr->it_clock == CLOCK_REALTIME)
 		timr->kclock = absolute ? &clock_realtime : &clock_monotonic;
 
-	hrtimer_init(&timr->it.real.timer, timr->it_clock, mode);
-	timr->it.real.timer.function = posix_timer_fn;
+	hrtimer_setup(&timr->it.real.timer, posix_timer_fn, timr->it_clock, mode);
 
 	if (!absolute)
 		expires = ktime_add_safe(expires, timer->base->get_time());
diff --git a/kernel/time/sched_clock.c b/kernel/time/sched_clock.c
index fcca4e7..cc15fe2 100644
--- a/kernel/time/sched_clock.c
+++ b/kernel/time/sched_clock.c
@@ -263,8 +263,7 @@ void __init generic_sched_clock_init(void)
 	 * Start the timer to keep sched_clock() properly updated and
 	 * sets the initial epoch.
 	 */
-	hrtimer_init(&sched_clock_timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL_HARD);
-	sched_clock_timer.function = sched_clock_poll;
+	hrtimer_setup(&sched_clock_timer, sched_clock_poll, CLOCK_MONOTONIC, HRTIMER_MODE_REL_HARD);
 	hrtimer_start(&sched_clock_timer, cd.wrap_kt, HRTIMER_MODE_REL_HARD);
 }
 
diff --git a/kernel/time/tick-broadcast-hrtimer.c b/kernel/time/tick-broadcast-hrtimer.c
index e28f921..a88b72b 100644
--- a/kernel/time/tick-broadcast-hrtimer.c
+++ b/kernel/time/tick-broadcast-hrtimer.c
@@ -100,7 +100,6 @@ static enum hrtimer_restart bc_handler(struct hrtimer *t)
 
 void tick_setup_hrtimer_broadcast(void)
 {
-	hrtimer_init(&bctimer, CLOCK_MONOTONIC, HRTIMER_MODE_ABS_HARD);
-	bctimer.function = bc_handler;
+	hrtimer_setup(&bctimer, bc_handler, CLOCK_MONOTONIC, HRTIMER_MODE_ABS_HARD);
 	clockevents_register_device(&ce_broadcast_hrtimer);
 }
diff --git a/kernel/time/tick-sched.c b/kernel/time/tick-sched.c
index fa05851..c527b42 100644
--- a/kernel/time/tick-sched.c
+++ b/kernel/time/tick-sched.c
@@ -1573,12 +1573,10 @@ void tick_setup_sched_timer(bool hrtimer)
 	struct tick_sched *ts = this_cpu_ptr(&tick_cpu_sched);
 
 	/* Emulate tick processing via per-CPU hrtimers: */
-	hrtimer_init(&ts->sched_timer, CLOCK_MONOTONIC, HRTIMER_MODE_ABS_HARD);
+	hrtimer_setup(&ts->sched_timer, tick_nohz_handler, CLOCK_MONOTONIC, HRTIMER_MODE_ABS_HARD);
 
-	if (IS_ENABLED(CONFIG_HIGH_RES_TIMERS) && hrtimer) {
+	if (IS_ENABLED(CONFIG_HIGH_RES_TIMERS) && hrtimer)
 		tick_sched_flag_set(ts, TS_FLAG_HIGHRES);
-		ts->sched_timer.function = tick_nohz_handler;
-	}
 
 	/* Get the next period (per-CPU) */
 	hrtimer_set_expires(&ts->sched_timer, tick_init_jiffy_update());

