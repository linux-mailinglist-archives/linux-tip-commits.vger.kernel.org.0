Return-Path: <linux-tip-commits+bounces-5727-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 407BCABFA84
	for <lists+linux-tip-commits@lfdr.de>; Wed, 21 May 2025 18:01:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B80CC189636C
	for <lists+linux-tip-commits@lfdr.de>; Wed, 21 May 2025 15:57:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2AC6267F66;
	Wed, 21 May 2025 15:49:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="C2gYCuj2";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="w1YoEPQL"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94565254869;
	Wed, 21 May 2025 15:49:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747842586; cv=none; b=ZTEw1i5Quztt/jmC3C2Q/UlFMF2Nv0Qvqq7zgGTjpQgG6o7A4dDwZ1gvmN36GMfJJ8tWg7dwsJ5WRmY2oaH/nYNjQKhZEOJUTqZzS8JZwUbQar/NgdAsr3S3qiqdPrHsFJQ7H+UkDMx2Sk1+S5eMNLy9hRltwIyYECrnXu7sZeo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747842586; c=relaxed/simple;
	bh=h63ja79BmqeDHV4bpuFDIEnJNa7+vBFVJcZ8p/kZh5Y=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=T2i8Vi0uAv9HibkA2crOgB8zEAzZJxTSnHLLgO7jrlp4c+wChEbTqUc242UUhOSKbnJw2hdaLQ4tWTQEAU5kjsCodFdQq8oMnVDw124GbBOMchXIV6HjLDXGPXicqhP0Q7GawRj80iD6cSE690yilRr50ZJq6AUMJ1R4tIxYa0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=C2gYCuj2; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=w1YoEPQL; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 21 May 2025 15:49:41 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1747842582;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MfzagXzSB8OfzZKwU4YtCX9adAdsYVMc7Ejh17A8iH8=;
	b=C2gYCuj2QvVXxtsJ7FHoNhO2uZ7TPE5Ka0po2z4m/nUFhPZUD+PcanZXhs5pbzbr2FBetb
	on8wFKDxpou2I3muxCEGyt0ABnHn+DtRtmAnggQabk8OsHutImOSvY6Bhba9c85AAQQkHK
	U66rIehnZTSa86pXK6JCQiKgWDioDx1BeLUVJ3B9xTaa4Z2IWUcqKtuy0b3bmXnzBRntng
	z3XhuhEIgmy45TREZkzzwO015e/fBiPTY9DKmVosjkbbiBNwJqrnmFZ8WwrTo3Oxp98PNm
	NtnuVh/ss5thVoGeFYohxsDlLRLBW7Fwso7LzMyUDBKbHo3uBBklDrMHJJH9OQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1747842582;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MfzagXzSB8OfzZKwU4YtCX9adAdsYVMc7Ejh17A8iH8=;
	b=w1YoEPQLJWKW1GsyCDSrrlSI/pBI2eK2IztCQyEz51jsy5mM+UMWRxQTAKvWCoyN6zrquY
	TbnRrxZxw+Ed4iDg==
From: "tip-bot2 for Pohsun Su" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/clocksource] clocksource/drivers/timer-tegra186: Fix
 watchdog self-pinging
Cc: Pohsun Su <pohsuns@nvidia.com>, Robert Lin <robelin@nvidia.com>,
 Daniel Lezcano <daniel.lezcano@linaro.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250507044311.3751033-3-robelin@nvidia.com>
References: <20250507044311.3751033-3-robelin@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174784258183.406.15458664313624762621.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/clocksource branch of tip:

Commit-ID:     b42d781e0350c969ef8155b800e33400f5f8b8a6
Gitweb:        https://git.kernel.org/tip/b42d781e0350c969ef8155b800e33400f5f8b8a6
Author:        Pohsun Su <pohsuns@nvidia.com>
AuthorDate:    Wed, 07 May 2025 12:43:10 +08:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Fri, 16 May 2025 11:10:32 +02:00

clocksource/drivers/timer-tegra186: Fix watchdog self-pinging

This change removes watchdog self-pinging behavior.

The timer irq handler is triggered due to the 1st expiration,
the handler disables and enables watchdog but also implicitly
clears the expiration count so the count can only be 0 or 1.

Since this watchdog supports opened, configured, or pinged by
systemd, We remove this behavior or the watchdog may not bark
when systemd crashes since the 5th expiration never comes.

Signed-off-by: Pohsun Su <pohsuns@nvidia.com>
Signed-off-by: Robert Lin <robelin@nvidia.com>
Link: https://lore.kernel.org/r/20250507044311.3751033-3-robelin@nvidia.com
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/clocksource/timer-tegra186.c | 27 +---------------------------
 1 file changed, 27 deletions(-)

diff --git a/drivers/clocksource/timer-tegra186.c b/drivers/clocksource/timer-tegra186.c
index 5eb6b7e..fb8a51a 100644
--- a/drivers/clocksource/timer-tegra186.c
+++ b/drivers/clocksource/timer-tegra186.c
@@ -174,9 +174,6 @@ static void tegra186_wdt_enable(struct tegra186_wdt *wdt)
 		value &= ~WDTCR_PERIOD_MASK;
 		value |= WDTCR_PERIOD(1);
 
-		/* enable local interrupt for WDT petting */
-		value |= WDTCR_LOCAL_INT_ENABLE;
-
 		/* enable local FIQ and remote interrupt for debug dump */
 		if (0)
 			value |= WDTCR_REMOTE_INT_ENABLE |
@@ -427,23 +424,10 @@ static int tegra186_timer_usec_init(struct tegra186_timer *tegra)
 	return clocksource_register_hz(&tegra->usec, USEC_PER_SEC);
 }
 
-static irqreturn_t tegra186_timer_irq(int irq, void *data)
-{
-	struct tegra186_timer *tegra = data;
-
-	if (watchdog_active(&tegra->wdt->base)) {
-		tegra186_wdt_disable(tegra->wdt);
-		tegra186_wdt_enable(tegra->wdt);
-	}
-
-	return IRQ_HANDLED;
-}
-
 static int tegra186_timer_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
 	struct tegra186_timer *tegra;
-	unsigned int irq;
 	int err;
 
 	tegra = devm_kzalloc(dev, sizeof(*tegra), GFP_KERNEL);
@@ -462,8 +446,6 @@ static int tegra186_timer_probe(struct platform_device *pdev)
 	if (err < 0)
 		return err;
 
-	irq = err;
-
 	/* create a watchdog using a preconfigured timer */
 	tegra->wdt = tegra186_wdt_create(tegra, 0);
 	if (IS_ERR(tegra->wdt)) {
@@ -490,17 +472,8 @@ static int tegra186_timer_probe(struct platform_device *pdev)
 		goto unregister_osc;
 	}
 
-	err = devm_request_irq(dev, irq, tegra186_timer_irq, 0,
-			       "tegra186-timer", tegra);
-	if (err < 0) {
-		dev_err(dev, "failed to request IRQ#%u: %d\n", irq, err);
-		goto unregister_usec;
-	}
-
 	return 0;
 
-unregister_usec:
-	clocksource_unregister(&tegra->usec);
 unregister_osc:
 	clocksource_unregister(&tegra->osc);
 unregister_tsc:

