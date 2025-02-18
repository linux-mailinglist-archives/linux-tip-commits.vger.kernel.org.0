Return-Path: <linux-tip-commits+bounces-3494-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C481A39909
	for <lists+linux-tip-commits@lfdr.de>; Tue, 18 Feb 2025 11:34:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C383D1896300
	for <lists+linux-tip-commits@lfdr.de>; Tue, 18 Feb 2025 10:32:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83C372673B0;
	Tue, 18 Feb 2025 10:26:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="bjFzDlOm";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="oMhZcKcU"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3A47237163;
	Tue, 18 Feb 2025 10:26:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739874407; cv=none; b=X1PNXrAOLB7XODpFCk/IeId1vovGyTIdZT4Cw6XUuUF7su4Rolo/r+hCBaCFYKavYrq1Mp7wewdf7NG2rW0tmvQOe4NZO1lCHFQZ/BXwPF7ApjuBHimqOTMQnl6mZZDGwpdpA5A3ErzkM+V4+aOtRlg2LlWmQVoKgJkbJTh1KnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739874407; c=relaxed/simple;
	bh=YcdHH9wy7gUPsqCgJ46EbEWGZgcdjcQpF440RGp3KqI=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=dE572Uuotp4u2hRYNu3Bb6taPdQ+e64EK35+gvc6fiGZchHLIP6mKt4fJa9locEmHUhSb5R3uuhI3dfyq4hiLy8mAEONgR9Z0t7XXdLkfZRmJGkIS9CoRjZOWVO2s055Mwvd3VsKJvXFijDOIUY4iOPauCilo1HkQDpsoIkUb+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=bjFzDlOm; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=oMhZcKcU; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 18 Feb 2025 10:26:43 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1739874404;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OYOQEXzM3yWGdjmqp8aRfQl88HV2JaQ2Hi/FtYG6Qo0=;
	b=bjFzDlOmrLy0hvUtutVVckK382E+tDtLQ9yac9QhxWBbprJxPy7pgKNwkjABAfWGq1E4+z
	3lUmkSRvj8M2e/DJlYt0OkEgIp3DblQsnyr4APZmVDIYJi1+33KKMeEr4c0WQExJw6/Bsb
	PzwyScZO/9GIuql6ozQGUK0ZMlZl/tro0MO1UvfIGIGeV90YNpEZklPQ1jHG3eYjRmLYE2
	H2gH8BT1x9OWLPHq5RTEBOsUjU1ZwB7HSW2iF0WpaFkKt9zkismoiRCTvcCMk/Jf9nwbLk
	ujJ8xmZYm9izVADxhZrMbikEjRrNisZwp4QJnyFUTJ5PMnMWLX5OCDVGf58TnQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1739874404;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OYOQEXzM3yWGdjmqp8aRfQl88HV2JaQ2Hi/FtYG6Qo0=;
	b=oMhZcKcU9e/JU9G2HgpxG7q+caRR/gakISQaJJUBATbfU/gGm/7nuqiRcpcXn6BEIMKHpv
	ntNo8cfpz8JUfgDg==
From: "tip-bot2 for Nam Cao" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/cleanups] serial: 8250: Switch to use hrtimer_setup()
Cc: Nam Cao <namcao@linutronix.de>, Thomas Gleixner <tglx@linutronix.de>,
 Zack Rusin <zack.rusin@broadcom.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: =?utf-8?q?=3C991926d130cc272df30d226760d5d74187991669=2E17387?=
 =?utf-8?q?46904=2Egit=2Enamcao=40linutronix=2Ede=3E?=
References: =?utf-8?q?=3C991926d130cc272df30d226760d5d74187991669=2E173874?=
 =?utf-8?q?6904=2Egit=2Enamcao=40linutronix=2Ede=3E?=
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173987440343.10177.10544898710297369369.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/cleanups branch of tip:

Commit-ID:     6bf9bb76b3af17f1fbfe76e8d70528e939511801
Gitweb:        https://git.kernel.org/tip/6bf9bb76b3af17f1fbfe76e8d70528e939511801
Author:        Nam Cao <namcao@linutronix.de>
AuthorDate:    Wed, 05 Feb 2025 11:45:56 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 18 Feb 2025 11:19:02 +01:00

serial: 8250: Switch to use hrtimer_setup()

hrtimer_setup() takes the callback function pointer as argument and
initializes the timer completely.

Replace hrtimer_init() and the open coded initialization of
hrtimer::function with the new setup mechanism.

Patch was created by using Coccinelle.

Signed-off-by: Nam Cao <namcao@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Zack Rusin <zack.rusin@broadcom.com>
Link: https://lore.kernel.org/all/991926d130cc272df30d226760d5d74187991669.1738746904.git.namcao@linutronix.de

---
 drivers/tty/serial/8250/8250_bcm7271.c |  3 +--
 drivers/tty/serial/8250/8250_port.c    | 10 ++++------
 2 files changed, 5 insertions(+), 8 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_bcm7271.c b/drivers/tty/serial/8250/8250_bcm7271.c
index d0b1835..742004d 100644
--- a/drivers/tty/serial/8250/8250_bcm7271.c
+++ b/drivers/tty/serial/8250/8250_bcm7271.c
@@ -1056,8 +1056,7 @@ static int brcmuart_probe(struct platform_device *pdev)
 	}
 
 	/* setup HR timer */
-	hrtimer_init(&priv->hrt, CLOCK_MONOTONIC, HRTIMER_MODE_ABS);
-	priv->hrt.function = brcmuart_hrtimer_func;
+	hrtimer_setup(&priv->hrt, brcmuart_hrtimer_func, CLOCK_MONOTONIC, HRTIMER_MODE_ABS);
 
 	up.port.shutdown = brcmuart_shutdown;
 	up.port.startup = brcmuart_startup;
diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
index 442967a..c57f448 100644
--- a/drivers/tty/serial/8250/8250_port.c
+++ b/drivers/tty/serial/8250/8250_port.c
@@ -566,12 +566,10 @@ static int serial8250_em485_init(struct uart_8250_port *p)
 	if (!p->em485)
 		return -ENOMEM;
 
-	hrtimer_init(&p->em485->stop_tx_timer, CLOCK_MONOTONIC,
-		     HRTIMER_MODE_REL);
-	hrtimer_init(&p->em485->start_tx_timer, CLOCK_MONOTONIC,
-		     HRTIMER_MODE_REL);
-	p->em485->stop_tx_timer.function = &serial8250_em485_handle_stop_tx;
-	p->em485->start_tx_timer.function = &serial8250_em485_handle_start_tx;
+	hrtimer_setup(&p->em485->stop_tx_timer, &serial8250_em485_handle_stop_tx, CLOCK_MONOTONIC,
+		      HRTIMER_MODE_REL);
+	hrtimer_setup(&p->em485->start_tx_timer, &serial8250_em485_handle_start_tx, CLOCK_MONOTONIC,
+		      HRTIMER_MODE_REL);
 	p->em485->port = p;
 	p->em485->active_timer = NULL;
 	p->em485->tx_stopped = true;

