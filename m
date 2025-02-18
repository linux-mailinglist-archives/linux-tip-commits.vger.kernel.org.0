Return-Path: <linux-tip-commits+bounces-3477-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BB27A39918
	for <lists+linux-tip-commits@lfdr.de>; Tue, 18 Feb 2025 11:36:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D08883BABBE
	for <lists+linux-tip-commits@lfdr.de>; Tue, 18 Feb 2025 10:29:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CC91243375;
	Tue, 18 Feb 2025 10:26:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="LDIFOJ6V";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="y6rRaUk0"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5A5D2417DE;
	Tue, 18 Feb 2025 10:26:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739874396; cv=none; b=EC1BAx7a/gCpmcHXLYc18yXRxJCE6ZtzBAtG1/uteNzOocM8LL9lJevlwV6q72xr8zV5DeauGyV3v4LRKe9p/rGBkM3jeIN21RI4bBC7ADYPFRTFdrj4kI5ZHLJxFMdzKU4ZtKUNUdSTfmM1JINhkkpiONhtyiJlUIq6Ymj7iBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739874396; c=relaxed/simple;
	bh=yG0Y2Trd4wIOrymyZNyPHIVPvglX30ozaSn1czT0tig=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=JyCgIsdzimiNI1QtSlPoj/07f75tei1Jmnv7+0nFg2IRRidYZqehDx+syl0gkzf2JLhhRS/YcteruAekNKIgF9tJ74v3NQ2Q1Q60mu/4UrOQ80pziVYfJ2Wf6pifDfPYc2rSISAAucOdclXyDM+2+z0lXSAMcHGbQv+D/SBNlyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=LDIFOJ6V; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=y6rRaUk0; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 18 Feb 2025 10:26:32 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1739874393;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=auSLKxwlgI1ozWke8Cqpq3rsAwzB3ubuku9/7/Kn38k=;
	b=LDIFOJ6VSRRInW0FIsZULZAnYch3f/VWEE6kFcBROJ44QoElk0V2baPHMeYQu8t2/tFimK
	RDKWcBgNrfHGdSakLD22ee4VyOrNr3qK8HlXad4Nw2vzT4ZK/2RbbcSFL+XxMwdxc8cfsG
	15m1bvqNN1Vq+qxSUJDr0HgsXFYPqOurxlspo68g3E5IIBwKih7RYdk0qUAqbbP5dld9g1
	d6NB/xZEN1OBDrBXgrsmz4Zfgyyr132t3T77BczqeKily2LzWQvFNzny8ZwAXuD+HmutLS
	h09oMKNOBCN+D+h0Y8S+HHOE8svWF8cyp5U+V6kO7qHoxK8cs2fZzMP66MzHbw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1739874393;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=auSLKxwlgI1ozWke8Cqpq3rsAwzB3ubuku9/7/Kn38k=;
	b=y6rRaUk0POliL9+LpSnR7U0kWnpN6f97agOQOlZLmtuavJ3Q7B4chbXoTPLindcxs4tNhI
	hIXYHD94wRDNjzBQ==
From: "tip-bot2 for Nam Cao" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: timers/cleanups] leds: trigger: pattern: Switch to use hrtimer_setup()
Cc: Nam Cao <namcao@linutronix.de>, Thomas Gleixner <tglx@linutronix.de>,
 Zack Rusin <zack.rusin@broadcom.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: =?utf-8?q?=3C76fa1cc9777a99a48f49f949abadc1c10af1bc64=2E17387?=
 =?utf-8?q?46904=2Egit=2Enamcao=40linutronix=2Ede=3E?=
References: =?utf-8?q?=3C76fa1cc9777a99a48f49f949abadc1c10af1bc64=2E173874?=
 =?utf-8?q?6904=2Egit=2Enamcao=40linutronix=2Ede=3E?=
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173987439261.10177.17400093532233436700.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/cleanups branch of tip:

Commit-ID:     a9d0ac739658f9a7c27d3430475aa3a00948ab1f
Gitweb:        https://git.kernel.org/tip/a9d0ac739658f9a7c27d3430475aa3a00948ab1f
Author:        Nam Cao <namcao@linutronix.de>
AuthorDate:    Wed, 05 Feb 2025 11:46:13 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 18 Feb 2025 11:19:05 +01:00

leds: trigger: pattern: Switch to use hrtimer_setup()

hrtimer_setup() takes the callback function pointer as argument and
initializes the timer completely.

Replace hrtimer_init() and the open coded initialization of
hrtimer::function with the new setup mechanism.

Patch was created by using Coccinelle.

Signed-off-by: Nam Cao <namcao@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Zack Rusin <zack.rusin@broadcom.com>
Link: https://lore.kernel.org/all/76fa1cc9777a99a48f49f949abadc1c10af1bc64.1738746904.git.namcao@linutronix.de

---
 drivers/leds/trigger/ledtrig-pattern.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/leds/trigger/ledtrig-pattern.c b/drivers/leds/trigger/ledtrig-pattern.c
index aad48c2..a594bd5 100644
--- a/drivers/leds/trigger/ledtrig-pattern.c
+++ b/drivers/leds/trigger/ledtrig-pattern.c
@@ -483,8 +483,8 @@ static int pattern_trig_activate(struct led_classdev *led_cdev)
 	data->led_cdev = led_cdev;
 	led_set_trigger_data(led_cdev, data);
 	timer_setup(&data->timer, pattern_trig_timer_function, 0);
-	hrtimer_init(&data->hrtimer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
-	data->hrtimer.function = pattern_trig_hrtimer_function;
+	hrtimer_setup(&data->hrtimer, pattern_trig_hrtimer_function, CLOCK_MONOTONIC,
+		      HRTIMER_MODE_REL);
 	led_cdev->activated = true;
 
 	if (led_cdev->flags & LED_INIT_DEFAULT_TRIGGER) {

