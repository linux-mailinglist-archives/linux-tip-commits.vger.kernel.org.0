Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 493333ACFB3
	for <lists+linux-tip-commits@lfdr.de>; Fri, 18 Jun 2021 18:03:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235667AbhFRQF4 (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 18 Jun 2021 12:05:56 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:57448 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233341AbhFRQFx (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 18 Jun 2021 12:05:53 -0400
Date:   Fri, 18 Jun 2021 16:03:42 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1624032222;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nSVHpH4GmdHHGiWo2kLV3HL6NDUO7/jJAglf7LwQqsE=;
        b=wNhJLv4XOJ1TcSdUBjY6/K2UKdVLUmnb62x7T9wXv2/WLvmFbX9HOqNlK0TDeE5SlGvQEr
        mik9DyLYxRb/SVT44qzBe3OgRl+4JEdwNHfVR8CKCdz8BqUAZdWec8jxFj3Waj3J0Qtobc
        4HQB720W0imaiFQInPhDbm6zQhHQrG6AhxXJKGgLamFcnQWvph+/mUxYzNzqB0aFxqCDDn
        dNzMxcaNahwU/4CPmJ+mlwdcwSsIRJ6Dxv+KpY+R6VZJCZmkBD8x1t0knLJkHFBAYNK/SY
        8+RLDVfC6kCZ4uqczNHY2zQV2u5YKhJtDEK3LcgKGvksVdioHKqKWBJ3dJpuYw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1624032222;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nSVHpH4GmdHHGiWo2kLV3HL6NDUO7/jJAglf7LwQqsE=;
        b=oVopSOQTAirZ8w2Kcju43skIu+Ci19VC5uVZ7ZX1FxKsLm+A7x9uHBNVeW6+eSbLL5+A/N
        /0BjnpG/IT/It1Bg==
From:   "tip-bot2 for Krzysztof Kozlowski" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] clocksource/drivers/samsung_pwm: Cleanup on init error
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210506202729.157260-3-krzysztof.kozlowski@canonical.com>
References: <20210506202729.157260-3-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Message-ID: <162403222216.19906.916681281934309111.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     63e83bd8cd848a3d1b4777d90635a309fa9cb2c7
Gitweb:        https://git.kernel.org/tip/63e83bd8cd848a3d1b4777d90635a309fa9cb2c7
Author:        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
AuthorDate:    Thu, 06 May 2021 16:27:27 -04:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Fri, 04 Jun 2021 10:12:12 +02:00

clocksource/drivers/samsung_pwm: Cleanup on init error

Failure of timer initialization is likely to be fatal for the system, so
cleanup in such case is not strictly necessary.  However the code might
be refactored or reused, so better not to rely on such assumption that
system won't continue init failure.

Unmap the IO memory and put the clock on initialization failures from
devicetree.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Link: https://lore.kernel.org/r/20210506202729.157260-3-krzysztof.kozlowski@canonical.com
---
 drivers/clocksource/samsung_pwm_timer.c | 20 +++++++++++++++++---
 1 file changed, 17 insertions(+), 3 deletions(-)

diff --git a/drivers/clocksource/samsung_pwm_timer.c b/drivers/clocksource/samsung_pwm_timer.c
index bfad61b..55e2f9f 100644
--- a/drivers/clocksource/samsung_pwm_timer.c
+++ b/drivers/clocksource/samsung_pwm_timer.c
@@ -421,7 +421,7 @@ static int __init samsung_pwm_alloc(struct device_node *np,
 	struct property *prop;
 	const __be32 *cur;
 	u32 val;
-	int i;
+	int i, ret;
 
 	memcpy(&pwm.variant, variant, sizeof(pwm.variant));
 	for (i = 0; i < SAMSUNG_PWM_NUM; ++i)
@@ -444,10 +444,24 @@ static int __init samsung_pwm_alloc(struct device_node *np,
 	pwm.timerclk = of_clk_get_by_name(np, "timers");
 	if (IS_ERR(pwm.timerclk)) {
 		pr_crit("failed to get timers clock for timer\n");
-		return PTR_ERR(pwm.timerclk);
+		ret = PTR_ERR(pwm.timerclk);
+		goto err_clk;
 	}
 
-	return _samsung_pwm_clocksource_init();
+	ret = _samsung_pwm_clocksource_init();
+	if (ret)
+		goto err_clocksource;
+
+	return 0;
+
+err_clocksource:
+	clk_put(pwm.timerclk);
+	pwm.timerclk = NULL;
+err_clk:
+	iounmap(pwm.base);
+	pwm.base = NULL;
+
+	return ret;
 }
 
 static const struct samsung_pwm_variant s3c24xx_variant = {
