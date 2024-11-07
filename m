Return-Path: <linux-tip-commits+bounces-2804-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E8B099BFC0B
	for <lists+linux-tip-commits@lfdr.de>; Thu,  7 Nov 2024 02:59:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9F5EC1F2291E
	for <lists+linux-tip-commits@lfdr.de>; Thu,  7 Nov 2024 01:59:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E32F16419;
	Thu,  7 Nov 2024 01:59:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Plrb7v6j";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="tcii0L0e"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9F4B11713;
	Thu,  7 Nov 2024 01:59:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730944779; cv=none; b=Xc/T+oriw0EQTd8vOsZi0WfJVI6T3+s97k+JcfbjjI51Pch374Lc20oczTpq3K6/jNG/F0vKiwX2IeVY2CdtaCJHfTOKXXl7+zTi7z0vpEzWBDP7Sxq6XWEAgSqqeWXnqjqFnIhpd+21Pndy4J5ZGqh9NSwAYkupKSNKogBXk0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730944779; c=relaxed/simple;
	bh=4JKXSue7u9eU0df9CGEzYpKVbFecv7djE3SO8NeSX20=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=TB0OdKwB7RjlaUiUYwfnl8/Jbm7dyA5OYmdWh6jzdatPm4jI+b50aTGDuxfZ8GyDg/dRroFpnO+cMZkIVgyv/PVyh82CJQeT6iUmFiu094Pt6qrB26mgvo11jaF7Uww9/D9m5Oqn6Ys3WY8cNnjhog6ILl4iRUuctQ86/+tymgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Plrb7v6j; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=tcii0L0e; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 07 Nov 2024 01:59:35 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1730944776;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8WHw33HKcdaBoncHJa5gA7jS/rSomPiI+uKc8/F1//k=;
	b=Plrb7v6jaQcpnSpR13Lin2aGJX0sTPJyRJKsRbykTHx+SdlTzdIVqYlIoADYNE55D4mddV
	4p6+7+b8x6eSzOLxdEnxpyCDTS4sFBF9pV+qR4aA3ekvv5odDwCcFgIFggR3Jb+Cpc5HNr
	ok932RYP8YeRiJ3j585AAtXHMuEOcprZ2Py8jEcKGAyLPwkyhP5XJ1MBQ+jNbe2qkvo7v2
	86ALumSQkM4byv/Dky8cDplTo1dpmKzMDFxozDN7hQZ4NKd9D0/y0HtOoB/HkR9kc8IQGs
	h6fVGKMfRsgPq8E4ckZLOPshmZaNU6l6MVHYEVpd7YhnIIcNcOV6xOLi6WaRrg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1730944776;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8WHw33HKcdaBoncHJa5gA7jS/rSomPiI+uKc8/F1//k=;
	b=tcii0L0e7enfeLwgO3TVkGa8fCyzcxG/xDNXbeqzgwMyGELZIN3Sazbqe8R9AyoaQXcuN/
	/IGvFnRserofoMBg==
From: "tip-bot2 for Nam Cao" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] alarmtimer: Switch to use hrtimer_setup() and
 hrtimer_setup_on_stack()
Cc: Nam Cao <namcao@linutronix.de>, Thomas Gleixner <tglx@linutronix.de>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: =?utf-8?q?=3C2bae912336103405adcdab96b88d3ea0353b4228=2E17303?=
 =?utf-8?q?86209=2Egit=2Enamcao=40linutronix=2Ede=3E?=
References: =?utf-8?q?=3C2bae912336103405adcdab96b88d3ea0353b4228=2E173038?=
 =?utf-8?q?6209=2Egit=2Enamcao=40linutronix=2Ede=3E?=
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173094477542.32228.15157514414231580788.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     d82fadc727501e80cbc733f5990a682c9f46dc5e
Gitweb:        https://git.kernel.org/tip/d82fadc727501e80cbc733f5990a682c9f46dc5e
Author:        Nam Cao <namcao@linutronix.de>
AuthorDate:    Thu, 31 Oct 2024 16:14:32 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 07 Nov 2024 02:47:07 +01:00

alarmtimer: Switch to use hrtimer_setup() and hrtimer_setup_on_stack()

hrtimer_setup() and hrtimer_setup_on_stack() take the callback function
pointer as argument and initialize the timer completely.

Replace the hrtimer_init*() variants and the open coded initialization of
hrtimer::function with the new setup mechanism.

Switch to use the new functions.

Signed-off-by: Nam Cao <namcao@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/all/2bae912336103405adcdab96b88d3ea0353b4228.1730386209.git.namcao@linutronix.de

---
 kernel/time/alarmtimer.c |  9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/kernel/time/alarmtimer.c b/kernel/time/alarmtimer.c
index 37d2d79..0ddccdf 100644
--- a/kernel/time/alarmtimer.c
+++ b/kernel/time/alarmtimer.c
@@ -324,7 +324,6 @@ __alarm_init(struct alarm *alarm, enum alarmtimer_type type,
 	     void (*function)(struct alarm *, ktime_t))
 {
 	timerqueue_init(&alarm->node);
-	alarm->timer.function = alarmtimer_fired;
 	alarm->function = function;
 	alarm->type = type;
 	alarm->state = ALARMTIMER_STATE_INACTIVE;
@@ -339,8 +338,8 @@ __alarm_init(struct alarm *alarm, enum alarmtimer_type type,
 void alarm_init(struct alarm *alarm, enum alarmtimer_type type,
 		void (*function)(struct alarm *, ktime_t))
 {
-	hrtimer_init(&alarm->timer, alarm_bases[type].base_clockid,
-		     HRTIMER_MODE_ABS);
+	hrtimer_setup(&alarm->timer, alarmtimer_fired, alarm_bases[type].base_clockid,
+		      HRTIMER_MODE_ABS);
 	__alarm_init(alarm, type, function);
 }
 EXPORT_SYMBOL_GPL(alarm_init);
@@ -757,8 +756,8 @@ static void
 alarm_init_on_stack(struct alarm *alarm, enum alarmtimer_type type,
 		    void (*function)(struct alarm *, ktime_t))
 {
-	hrtimer_init_on_stack(&alarm->timer, alarm_bases[type].base_clockid,
-			      HRTIMER_MODE_ABS);
+	hrtimer_setup_on_stack(&alarm->timer, alarmtimer_fired, alarm_bases[type].base_clockid,
+			       HRTIMER_MODE_ABS);
 	__alarm_init(alarm, type, function);
 }
 

