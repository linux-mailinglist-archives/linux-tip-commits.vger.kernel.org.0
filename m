Return-Path: <linux-tip-commits+bounces-4692-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B9185A7C2F2
	for <lists+linux-tip-commits@lfdr.de>; Fri,  4 Apr 2025 19:55:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E925A189C8E5
	for <lists+linux-tip-commits@lfdr.de>; Fri,  4 Apr 2025 17:56:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BECED22170B;
	Fri,  4 Apr 2025 17:54:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ncH4iqze";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="yWT5sVQW"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2C1E21E0BC;
	Fri,  4 Apr 2025 17:54:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743789281; cv=none; b=o0PIZVcUsdwaf3gysiG44ZjHrIX7hfs59WaTLvsImuimxXz9CUZR8BNsiF/tlL3w3iQAyTjBxzndi1sKLSo2xkBoXdcMrt4ik+O3PSZEup9nqJohbprIIaddzlvMKYUe8VPubP7rPSn7/sdKbj6Uptj/CvTSN4vt2VM9yKa9chg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743789281; c=relaxed/simple;
	bh=TszzyPOsqxY8zj40fSi3+LbB8x6rEnK/0WqMa5gh4lE=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=bUAF8RkBdOgXQdks4i8n1S7Ez+3ZNi46a0mcxG8QCGiBYj60s5F1Tfz4a75qUf7eHU5k1jxTZOHosqsqZsH9cDr0p/IopI+Rvsw1g7cUesFN0JcvZWZysR+CWpnfaTQkVRawzoO6ED5n13KpjpSWqCFjvuCbLj6/m+PQKVZ13G4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ncH4iqze; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=yWT5sVQW; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 04 Apr 2025 17:54:37 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1743789278;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=f3FAbeJmSx2UcBqXQVoT7vAYYU5ffkrloNoPTyt4UK4=;
	b=ncH4iqze8DODi7irnjyv59jQ1cdM+bdZk/Tx+OQAXKuGmsHj6OkvQnxqH8mwFPDDdEvdOT
	64iEzRRWumofj4tzgsJ2WZIyFg1MsBNE/M2GXEMyokKqmhAFqLFsGvcan+N9gREzEfbn9m
	r3NHBcdoJEzWm0oQ4pH8fejCtum23odc4Wz2OaJJGXZ2Uuse4JUPFVIk202sNU/R/Afvq9
	6G/5kz3ylin9/6rW2RnPQRTozznUZlZH8m0ZxfVrmd863AOtsn/dq9LarbDm7yFba3KonP
	kT5Q/lUC3bQc9/x0SLGBlmZOLoLhB1UFgswTw2x0koXcKP4V6dLgVT/zRXBE9Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1743789278;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=f3FAbeJmSx2UcBqXQVoT7vAYYU5ffkrloNoPTyt4UK4=;
	b=yWT5sVQWX7D2ZEd8xdD/vn4NsT2GAHq7q1ZUYizDsY1EvYeOCFxaNlZ5M3ae4QZXOq04bz
	EMW3hwukBpu+mfDQ==
From: "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/cleanups] treewide: Convert new and leftover
 hrtimer_init() users
Cc: Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174378927747.31282.603645839002860292.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/cleanups branch of tip:

Commit-ID:     f1a5271df2aa65b08f4dcdd1499e3cfc096be108
Gitweb:        https://git.kernel.org/tip/f1a5271df2aa65b08f4dcdd1499e3cfc096be108
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Fri, 04 Apr 2025 19:31:15 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Fri, 04 Apr 2025 19:46:06 +02:00

treewide: Convert new and leftover hrtimer_init() users

hrtimer_setup() takes the callback function pointer as argument and
initializes the timer completely.
    
Replace hrtimer_init() and the open coded initialization of
hrtimer::function with the new setup mechanism.
    
Coccinelle scripted cleanup.
    
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
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
index b67af46..fd94690 100644
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
 

