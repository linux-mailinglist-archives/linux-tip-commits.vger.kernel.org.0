Return-Path: <linux-tip-commits+bounces-4702-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 02F69A7C85B
	for <lists+linux-tip-commits@lfdr.de>; Sat,  5 Apr 2025 10:48:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B6D413A9DE5
	for <lists+linux-tip-commits@lfdr.de>; Sat,  5 Apr 2025 08:47:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62EC41EF0B9;
	Sat,  5 Apr 2025 08:46:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="i6hqi40n";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="hVru2eAc"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 705971DF254;
	Sat,  5 Apr 2025 08:46:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743842808; cv=none; b=IGoo4UGv95j8cDIlkqmgv7lHjnYv/w2L+8ErEQh30dlUyiHAEB2G30v8mrrhtaY/9kaV9RLgPRGVPNn64+q/abRRdl3l0zzVx5kln2DmFDv2nRpYCVg2Pqq74JpPTKslBjw8LZfBAqx863aS2uNfO/lgCfidWlxY+zWQ8Mg3FOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743842808; c=relaxed/simple;
	bh=ypeArV2yRX6zKtPdzlT2oFy9pgP047XdyQJR8mh5eqw=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=AXSZA4yExEsHKe1lbEf7hyPgfha/DFO6y+gJVMgDBARO2UYPru9IxuCCO8pp/Hy688H6pEMi2g5hw2iBx65wTPJaU7CwgKpieLI2kK6rad28ME82BIc9VPe3X4thgza0Jz0eG2tzDFeSdTfmmOUQxK4oIqFNANbg8kZ6ppXNrjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=i6hqi40n; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=hVru2eAc; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sat, 05 Apr 2025 08:46:41 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1743842802;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=OI1qdK0hiWBwn4MsSMs7tSvcEsFRlCioq5x8Ux9CqNM=;
	b=i6hqi40ngpAkfR++joZqKT0+4mbN3IShjvne/Nd/pIzANdFsDZaqytFC8Rm3ULwIEHD9ga
	QxJoJF01J9RTr98kuLTadwMHXqG+IM7xXWMACXtnXhredx7F4y0V8uasWdiC2CDvXcu9E3
	aiKnL02TYFfkbaFPyUl2NlxEYlnbDaLovnZ3ZSOiJyz+k4HFsDwlFfkv5/GURWyjwJQSFb
	Q+6L3/sb5sP6m/FwAjYvHcZ0I90t9uqEhQl2RgJJ+mwkEYki7dTWzOlvvcveG9ptEzP4HK
	ccKG4wsj2eH2hSQ9DsQmVxXMpkvkQDaf6sOQscxDgNkCmXmugsuHpdKbv2TtBA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1743842802;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=OI1qdK0hiWBwn4MsSMs7tSvcEsFRlCioq5x8Ux9CqNM=;
	b=hVru2eAcMrpUtsPk/KHBLc8HRKpxA0HrHkm8a0wT1rwa30daiU2NQ5sTqd+N8EI1W6BP20
	AyddOOm1PSyF1RCQ==
From: "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/cleanups] treewide: Convert new and leftover
 hrtimer_init() users
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@kernel.org>,
 x86@kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174384280127.31282.2714486346304643188.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/cleanups branch of tip:

Commit-ID:     48ad7bbfd53af0d3fe6490a4dd30c169db6f12aa
Gitweb:        https://git.kernel.org/tip/48ad7bbfd53af0d3fe6490a4dd30c169db6f12aa
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Fri, 04 Apr 2025 19:31:15 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Sat, 05 Apr 2025 10:30:17 +02:00

treewide: Convert new and leftover hrtimer_init() users

hrtimer_setup() takes the callback function pointer as argument and
initializes the timer completely.

Replace hrtimer_init() and the open coded initialization of
hrtimer::function with the new setup mechanism.

Coccinelle scripted cleanup.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 drivers/input/joystick/walkera0701.c |  3 +--
 drivers/input/keyboard/gpio_keys.c   | 10 ++++------
 drivers/net/netdevsim/netdev.c       |  4 ++--
 drivers/pps/generators/pps_gen_tio.c |  4 ++--
 4 files changed, 9 insertions(+), 12 deletions(-)

diff --git a/drivers/input/joystick/walkera0701.c b/drivers/input/joystick/walkera0701.c
index 59eea81..15370fb 100644
--- a/drivers/input/joystick/walkera0701.c
+++ b/drivers/input/joystick/walkera0701.c
@@ -232,8 +232,7 @@ static void walkera0701_attach(struct parport *pp)
 		goto err_unregister_device;
 	}
 
-	hrtimer_init(&w->timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
-	w->timer.function = timer_handler;
+	hrtimer_setup(&w->timer, timer_handler, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
 
 	w->input_dev = input_allocate_device();
 	if (!w->input_dev) {
diff --git a/drivers/input/keyboard/gpio_keys.c b/drivers/input/keyboard/gpio_keys.c
index 5eef665..5c39a21 100644
--- a/drivers/input/keyboard/gpio_keys.c
+++ b/drivers/input/keyboard/gpio_keys.c
@@ -590,9 +590,8 @@ static int gpio_keys_setup_key(struct platform_device *pdev,
 
 		INIT_DELAYED_WORK(&bdata->work, gpio_keys_gpio_work_func);
 
-		hrtimer_init(&bdata->debounce_timer,
-			     CLOCK_REALTIME, HRTIMER_MODE_REL);
-		bdata->debounce_timer.function = gpio_keys_debounce_timer;
+		hrtimer_setup(&bdata->debounce_timer, gpio_keys_debounce_timer,
+			      CLOCK_REALTIME, HRTIMER_MODE_REL);
 
 		isr = gpio_keys_gpio_isr;
 		irqflags = IRQF_TRIGGER_RISING | IRQF_TRIGGER_FALLING;
@@ -628,9 +627,8 @@ static int gpio_keys_setup_key(struct platform_device *pdev,
 		}
 
 		bdata->release_delay = button->debounce_interval;
-		hrtimer_init(&bdata->release_timer,
-			     CLOCK_REALTIME, HRTIMER_MODE_REL_HARD);
-		bdata->release_timer.function = gpio_keys_irq_timer;
+		hrtimer_setup(&bdata->release_timer, gpio_keys_irq_timer,
+			      CLOCK_REALTIME, HRTIMER_MODE_REL_HARD);
 
 		isr = gpio_keys_irq_isr;
 		irqflags = 0;
diff --git a/drivers/net/netdevsim/netdev.c b/drivers/net/netdevsim/netdev.c
index ddda0c1..0e0321a 100644
--- a/drivers/net/netdevsim/netdev.c
+++ b/drivers/net/netdevsim/netdev.c
@@ -441,8 +441,8 @@ static enum hrtimer_restart nsim_napi_schedule(struct hrtimer *timer)
 
 static void nsim_rq_timer_init(struct nsim_rq *rq)
 {
-	hrtimer_init(&rq->napi_timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
-	rq->napi_timer.function = nsim_napi_schedule;
+	hrtimer_setup(&rq->napi_timer, nsim_napi_schedule, CLOCK_MONOTONIC,
+		      HRTIMER_MODE_REL);
 }
 
 static void nsim_enable_napi(struct netdevsim *ns)
diff --git a/drivers/pps/generators/pps_gen_tio.c b/drivers/pps/generators/pps_gen_tio.c
index 6c46b46..1d5ffe0 100644
--- a/drivers/pps/generators/pps_gen_tio.c
+++ b/drivers/pps/generators/pps_gen_tio.c
@@ -227,8 +227,8 @@ static int pps_gen_tio_probe(struct platform_device *pdev)
 		return PTR_ERR(tio->base);
 
 	pps_tio_disable(tio);
-	hrtimer_init(&tio->timer, CLOCK_REALTIME, HRTIMER_MODE_ABS);
-	tio->timer.function = hrtimer_callback;
+	hrtimer_setup(&tio->timer, hrtimer_callback, CLOCK_REALTIME,
+		      HRTIMER_MODE_ABS);
 	spin_lock_init(&tio->lock);
 	platform_set_drvdata(pdev, &tio);
 

