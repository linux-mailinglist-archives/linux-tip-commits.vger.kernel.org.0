Return-Path: <linux-tip-commits+bounces-5140-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E7201AA43CA
	for <lists+linux-tip-commits@lfdr.de>; Wed, 30 Apr 2025 09:22:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CA6033BDAC1
	for <lists+linux-tip-commits@lfdr.de>; Wed, 30 Apr 2025 07:22:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C76220C473;
	Wed, 30 Apr 2025 07:22:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Z+yHbOSx";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="t3teywSg"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F746205AD7;
	Wed, 30 Apr 2025 07:22:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745997745; cv=none; b=miIv9+wCkv5iaBW/iefAzgSZ6mZmiMuaVXN3BdU8t7T5sAU3uFa956U+Id7UakKexpRPxZKzWDjZARAPs0bLLUGvM0F4CMPzVp3bVRcwW2eq0rKjeOC2BaQq1eyKES7fZ32dprdNY9jBqnY61bCuxuN6gjeZT+oCIUshokDcnbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745997745; c=relaxed/simple;
	bh=5bGrN5HsQmazWaJ64ju5zln7WV7ytklEm827xVVHrWk=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=UuJSjGXzHaDtKiFVbwJotnAcuoF8xRtzLYzw42pIUbSTMJpjP2lKOzIDbxtA99RGoSO6rBYKE7S69DgIWGK767s6TjdY4i6zyU9TSCi+t0AEuK3qP4mNPDSTP6CMZ4hemdJBRnNMGI0/Wa//gVNzS6A8OUdyCKcRLgn2F6lhT8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Z+yHbOSx; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=t3teywSg; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 30 Apr 2025 07:22:14 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1745997741;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NoEyHd0ojtCg6ptfiLNPIr4qqZcBeG7fwTAYVLhorV0=;
	b=Z+yHbOSxvJD3BNsT89IDJKW3AuABDXNfzdmvahbz1EIyBUxtpfS0aVn37Au1jBTD0bEO2E
	/KNrduhOk0sI4pYkgK3ZUOsYwSfTZulPmxknEM1SlJ7AHhpGzhdoTZQYHHAbZwQ/7w9/62
	NrASsFaBndzqSGWEGqAqVTwqFR0tNQ83HtW16jR5WfvUCWtQQn00ruj78My/fVg9dvJ4QV
	wcw8gSTigRpnOyRggCFoRyX7u2/R72GJdf+hKDN03uAuIRFWc5A/R/nEiXzfS8frRtagEA
	djGilC+J4fKr9Kq+nt06K2GLS7rqC+IaDpKuf9w+ntIMwHi1BHtKYbI1hiqZ+g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1745997741;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NoEyHd0ojtCg6ptfiLNPIr4qqZcBeG7fwTAYVLhorV0=;
	b=t3teywSgO3SQTmp89ruO6cyzoOnj4HXeJa8DZqg6k2+n6QsaqIgmigWu6l4/jpavuPr0w1
	JZD2or67n+W/y1CA==
From: "tip-bot2 for Su Hui" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: timers/core] alarmtimer: Switch spin_{lock,unlock}_irqsave() to guards
Cc: Su Hui <suhui@nfschina.com>, Thomas Gleixner <tglx@linutronix.de>,
 John Stultz <jstultz@google.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250430032734.2079290-4-suhui@nfschina.com>
References: <20250430032734.2079290-4-suhui@nfschina.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174599773468.22196.17349676424536470133.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     2117c1d503b4e0fd0c6776ae9fe4df2260643eae
Gitweb:        https://git.kernel.org/tip/2117c1d503b4e0fd0c6776ae9fe4df2260643eae
Author:        Su Hui <suhui@nfschina.com>
AuthorDate:    Wed, 30 Apr 2025 11:27:34 +08:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 30 Apr 2025 09:06:23 +02:00

alarmtimer: Switch spin_{lock,unlock}_irqsave() to guards

Using guard/scoped_guard() to simplify code. Using guard() to remove
'goto unlock' label is neater especially.

[ tglx: Brought back the scoped_guard()'s which were dropped in v2 and
  	simplified alarmtimer_rtc_add_device() ]

Signed-off-by: Su Hui <suhui@nfschina.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: John Stultz <jstultz@google.com>
Link: https://lore.kernel.org/all/20250430032734.2079290-4-suhui@nfschina.com

---
 kernel/time/alarmtimer.c | 78 +++++++++++++++------------------------
 1 file changed, 30 insertions(+), 48 deletions(-)

diff --git a/kernel/time/alarmtimer.c b/kernel/time/alarmtimer.c
index 621d396..577f0e6 100644
--- a/kernel/time/alarmtimer.c
+++ b/kernel/time/alarmtimer.c
@@ -70,12 +70,10 @@ static DEFINE_SPINLOCK(rtcdev_lock);
  */
 struct rtc_device *alarmtimer_get_rtcdev(void)
 {
-	unsigned long flags;
 	struct rtc_device *ret;
 
-	spin_lock_irqsave(&rtcdev_lock, flags);
+	guard(spinlock_irqsave)(&rtcdev_lock);
 	ret = rtcdev;
-	spin_unlock_irqrestore(&rtcdev_lock, flags);
 
 	return ret;
 }
@@ -83,7 +81,6 @@ EXPORT_SYMBOL_GPL(alarmtimer_get_rtcdev);
 
 static int alarmtimer_rtc_add_device(struct device *dev)
 {
-	unsigned long flags;
 	struct rtc_device *rtc = to_rtc_device(dev);
 	struct platform_device *pdev;
 	int ret = 0;
@@ -101,25 +98,18 @@ static int alarmtimer_rtc_add_device(struct device *dev)
 	if (!IS_ERR(pdev))
 		device_init_wakeup(&pdev->dev, true);
 
-	spin_lock_irqsave(&rtcdev_lock, flags);
-	if (!IS_ERR(pdev) && !rtcdev) {
-		if (!try_module_get(rtc->owner)) {
+	scoped_guard(spinlock_irqsave, &rtcdev_lock) {
+		if (!IS_ERR(pdev) && !rtcdev && try_module_get(rtc->owner)) {
+			rtcdev = rtc;
+			/* hold a reference so it doesn't go away */
+			get_device(dev);
+			pdev = NULL;
+		} else {
 			ret = -1;
-			goto unlock;
 		}
-
-		rtcdev = rtc;
-		/* hold a reference so it doesn't go away */
-		get_device(dev);
-		pdev = NULL;
-	} else {
-		ret = -1;
 	}
-unlock:
-	spin_unlock_irqrestore(&rtcdev_lock, flags);
 
 	platform_device_unregister(pdev);
-
 	return ret;
 }
 
@@ -198,7 +188,7 @@ static enum hrtimer_restart alarmtimer_fired(struct hrtimer *timer)
 	struct alarm *alarm = container_of(timer, struct alarm, timer);
 	struct alarm_base *base = &alarm_bases[alarm->type];
 
-	scoped_guard (spinlock_irqsave, &base->lock)
+	scoped_guard(spinlock_irqsave, &base->lock)
 		alarmtimer_dequeue(base, alarm);
 
 	if (alarm->function)
@@ -228,17 +218,16 @@ EXPORT_SYMBOL_GPL(alarm_expires_remaining);
 static int alarmtimer_suspend(struct device *dev)
 {
 	ktime_t min, now, expires;
-	int i, ret, type;
 	struct rtc_device *rtc;
-	unsigned long flags;
 	struct rtc_time tm;
+	int i, ret, type;
 
-	spin_lock_irqsave(&freezer_delta_lock, flags);
-	min = freezer_delta;
-	expires = freezer_expires;
-	type = freezer_alarmtype;
-	freezer_delta = 0;
-	spin_unlock_irqrestore(&freezer_delta_lock, flags);
+	scoped_guard(spinlock_irqsave, &freezer_delta_lock) {
+		min = freezer_delta;
+		expires = freezer_expires;
+		type = freezer_alarmtype;
+		freezer_delta = 0;
+	}
 
 	rtc = alarmtimer_get_rtcdev();
 	/* If we have no rtcdev, just return */
@@ -251,9 +240,8 @@ static int alarmtimer_suspend(struct device *dev)
 		struct timerqueue_node *next;
 		ktime_t delta;
 
-		spin_lock_irqsave(&base->lock, flags);
-		next = timerqueue_getnext(&base->timerqueue);
-		spin_unlock_irqrestore(&base->lock, flags);
+		scoped_guard(spinlock_irqsave, &base->lock)
+			next = timerqueue_getnext(&base->timerqueue);
 		if (!next)
 			continue;
 		delta = ktime_sub(next->expires, base->get_ktime());
@@ -352,13 +340,12 @@ EXPORT_SYMBOL_GPL(alarm_init);
 void alarm_start(struct alarm *alarm, ktime_t start)
 {
 	struct alarm_base *base = &alarm_bases[alarm->type];
-	unsigned long flags;
 
-	spin_lock_irqsave(&base->lock, flags);
-	alarm->node.expires = start;
-	alarmtimer_enqueue(base, alarm);
-	hrtimer_start(&alarm->timer, alarm->node.expires, HRTIMER_MODE_ABS);
-	spin_unlock_irqrestore(&base->lock, flags);
+	scoped_guard(spinlock_irqsave, &base->lock) {
+		alarm->node.expires = start;
+		alarmtimer_enqueue(base, alarm);
+		hrtimer_start(&alarm->timer, alarm->node.expires, HRTIMER_MODE_ABS);
+	}
 
 	trace_alarmtimer_start(alarm, base->get_ktime());
 }
@@ -381,13 +368,11 @@ EXPORT_SYMBOL_GPL(alarm_start_relative);
 void alarm_restart(struct alarm *alarm)
 {
 	struct alarm_base *base = &alarm_bases[alarm->type];
-	unsigned long flags;
 
-	spin_lock_irqsave(&base->lock, flags);
+	guard(spinlock_irqsave)(&base->lock);
 	hrtimer_set_expires(&alarm->timer, alarm->node.expires);
 	hrtimer_restart(&alarm->timer);
 	alarmtimer_enqueue(base, alarm);
-	spin_unlock_irqrestore(&base->lock, flags);
 }
 EXPORT_SYMBOL_GPL(alarm_restart);
 
@@ -401,14 +386,13 @@ EXPORT_SYMBOL_GPL(alarm_restart);
 int alarm_try_to_cancel(struct alarm *alarm)
 {
 	struct alarm_base *base = &alarm_bases[alarm->type];
-	unsigned long flags;
 	int ret;
 
-	spin_lock_irqsave(&base->lock, flags);
-	ret = hrtimer_try_to_cancel(&alarm->timer);
-	if (ret >= 0)
-		alarmtimer_dequeue(base, alarm);
-	spin_unlock_irqrestore(&base->lock, flags);
+	scoped_guard(spinlock_irqsave, &base->lock) {
+		ret = hrtimer_try_to_cancel(&alarm->timer);
+		if (ret >= 0)
+			alarmtimer_dequeue(base, alarm);
+	}
 
 	trace_alarmtimer_cancel(alarm, base->get_ktime());
 	return ret;
@@ -479,7 +463,6 @@ EXPORT_SYMBOL_GPL(alarm_forward_now);
 static void alarmtimer_freezerset(ktime_t absexp, enum alarmtimer_type type)
 {
 	struct alarm_base *base;
-	unsigned long flags;
 	ktime_t delta;
 
 	switch(type) {
@@ -498,13 +481,12 @@ static void alarmtimer_freezerset(ktime_t absexp, enum alarmtimer_type type)
 
 	delta = ktime_sub(absexp, base->get_ktime());
 
-	spin_lock_irqsave(&freezer_delta_lock, flags);
+	guard(spinlock_irqsave)(&freezer_delta_lock);
 	if (!freezer_delta || (delta < freezer_delta)) {
 		freezer_delta = delta;
 		freezer_expires = absexp;
 		freezer_alarmtype = type;
 	}
-	spin_unlock_irqrestore(&freezer_delta_lock, flags);
 }
 
 /**

