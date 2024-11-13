Return-Path: <linux-tip-commits+bounces-2854-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F1329C7CCC
	for <lists+linux-tip-commits@lfdr.de>; Wed, 13 Nov 2024 21:21:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 76855283A2F
	for <lists+linux-tip-commits@lfdr.de>; Wed, 13 Nov 2024 20:21:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A11D820A5F6;
	Wed, 13 Nov 2024 20:20:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="uO2la8Kz";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="RDuRqN4m"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AE552076C3;
	Wed, 13 Nov 2024 20:20:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731529255; cv=none; b=dk3I9PSorCxfA6zVt6KKQEX2kkljgkaKENtcsEyWJNEHFLVZc0RjieH17ASgkTRTNUJntDk6uOgzRaqcpW4wh57jWzra/8wKeVu0gb3k2v25No6R99GUId2dlbi4gaWkMzhGJN07mCbgjWo4D1tESQjOlLO9f7GemyGLcgW6S78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731529255; c=relaxed/simple;
	bh=LXtyTAzNU6uyH92vhGRzi79pgYhJVlVGhjkpr0YB7cI=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=jGE6T2JSSWfOPvrGxQr2ylWl988UyLIFUbQrBTWPee1w+ceKJIfTKuo1wLxbv3bmJlZTAVkOpYzdposonH1ZOGmorV3kIF6Wcn9WSYY6OmMs+ZQNy2H3vpSp4hVkHFiUC8uoWVaRZL6cOsa0DX4VKzmyLNpdz49A+b0P614vVZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=uO2la8Kz; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=RDuRqN4m; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 13 Nov 2024 20:20:51 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1731529252;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PDHW6kMJRGahHbSBtWtJba58qatL7en1hTA1G352pSA=;
	b=uO2la8KzFWhZWyO83FyJCBcwp2QUxxr0rcOFIYknR0AmOd4SHFXQCf6qy6B3SzAxdfGsWf
	FfUpToicO9P9n2GWi5nfAT6z7DSMEjXbLmu6z6qZ2oJ+jlB7nnlq3CXtQ2bKZN+nCbnJOj
	6kF5wC/blNO5MIvFp5BaOsIHpXgyjOIQC0FJ+LucwYyhN35pVCf+6vActoxsgse542aNi9
	zm5BzxWxFkwzUNoT9Z1rLGIX1VF3U2kz3jyeDDjtViwX2riUIxH37HVhiB7baQaR1kILIm
	9YtTwjRwzjaHf00nNU1Yq2ANcqYPtW/oo3AumwWqe8p8KH629HODAxR1Svm3tQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1731529252;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PDHW6kMJRGahHbSBtWtJba58qatL7en1hTA1G352pSA=;
	b=RDuRqN4mkuT9IEcXr2LnMXxUiX1GP3tnqHA+YV5qhOgzjLQKcfkytayEpmqPwj85tG4D7Y
	IYQBqrQlbMcJhMDg==
From: "tip-bot2 for Judith Mendez" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] clocksource/drivers/timer-ti-dm: Don't fail probe
 if int not found
Cc: Judith Mendez <jm@ti.com>, Daniel Lezcano <daniel.lezcano@linaro.org>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20241011175203.1040568-1-jm@ti.com>
References: <20241011175203.1040568-1-jm@ti.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173152925155.32228.6547337257924138852.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     314413317b6d78cc76cd48f0296fde9fcfdec400
Gitweb:        https://git.kernel.org/tip/314413317b6d78cc76cd48f0296fde9fcfdec400
Author:        Judith Mendez <jm@ti.com>
AuthorDate:    Fri, 11 Oct 2024 12:52:03 -05:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Wed, 13 Nov 2024 13:49:33 +01:00

clocksource/drivers/timer-ti-dm: Don't fail probe if int not found

Some timers may not have an interrupt routed to the A53 GIC, but the
timer PWM functionality can still be used by Linux Kernel. Therefore,
do not fail probe if interrupt is not found and ti,timer-pwm exists.

Signed-off-by: Judith Mendez <jm@ti.com>
Link: https://lore.kernel.org/r/20241011175203.1040568-1-jm@ti.com
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/clocksource/timer-ti-dm.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/clocksource/timer-ti-dm.c b/drivers/clocksource/timer-ti-dm.c
index b7a34b1..3666d94 100644
--- a/drivers/clocksource/timer-ti-dm.c
+++ b/drivers/clocksource/timer-ti-dm.c
@@ -1104,8 +1104,12 @@ static int omap_dm_timer_probe(struct platform_device *pdev)
 		return  -ENOMEM;
 
 	timer->irq = platform_get_irq(pdev, 0);
-	if (timer->irq < 0)
-		return timer->irq;
+	if (timer->irq < 0) {
+		if (of_property_read_bool(dev->of_node, "ti,timer-pwm"))
+			dev_info(dev, "Did not find timer interrupt, timer usable in PWM mode only\n");
+		else
+			return timer->irq;
+	}
 
 	timer->io_base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(timer->io_base))

