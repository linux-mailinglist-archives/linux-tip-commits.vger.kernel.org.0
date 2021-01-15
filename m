Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A55822F8343
	for <lists+linux-tip-commits@lfdr.de>; Fri, 15 Jan 2021 19:04:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728176AbhAOSET (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 15 Jan 2021 13:04:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728241AbhAOSEM (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 15 Jan 2021 13:04:12 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 994ECC0613D3;
        Fri, 15 Jan 2021 10:03:32 -0800 (PST)
Date:   Fri, 15 Jan 2021 18:03:29 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1610733810;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=52h/SweSIvapfgqewQKiO1rbFd3MVs3qUHrBu19VPsI=;
        b=H/5IxwxWcIWgUxKm4bp4W3LfdnpK7d+XXfHQkvrXdnEpTNXWWNUgM9fNbYWD0gDsXDfcrZ
        fMbgjiztnngzrYiabAwwZZCvucJCuEEPovQNUobQEik5pniVwzI2FVH2bg9WXyxhtncTe5
        wSMx2csorvl25/3gkFeP1hwPt9LO6AQuW41YbkDcQfqH0sY1ZZmklRyyjiYDO3RQfDey9h
        bNSu59IovAzsBSxwafeC+UA4kMwSdxdAoWDClZEv6SGf/ws9qTbmB3xc7/K7Z/2lRce5kK
        b+4PaS3YrTZvQCjD1ehq0uRxtd+ZVeEAWz5JIcA5ZeuTs2LOjVY5EnclsJLG7A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1610733810;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=52h/SweSIvapfgqewQKiO1rbFd3MVs3qUHrBu19VPsI=;
        b=mUYyFgUDV6WfSGm7OQQ/WAxUqV+HCIcpJIyutdrOHYRfd8sDd8VJedLLXPEM3ZZz0N5wDU
        JCUhGsvRvA70P3CA==
From:   "tip-bot2 for Linus Walleij" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/platform] x86/platform/geode: Convert geode LED to GPIO
 machine descriptor
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Borislav Petkov <bp@suse.de>,
        Hans de Goede <hdegoede@redhat.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20201124085339.6181-2-linus.walleij@linaro.org>
References: <20201124085339.6181-2-linus.walleij@linaro.org>
MIME-Version: 1.0
Message-ID: <161073380939.414.12010085189850912559.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/platform branch of tip:

Commit-ID:     ab20fda2a3da1b189a061ca045d9ca734e1db234
Gitweb:        https://git.kernel.org/tip/ab20fda2a3da1b189a061ca045d9ca734e1db234
Author:        Linus Walleij <linus.walleij@linaro.org>
AuthorDate:    Tue, 24 Nov 2020 09:53:38 +01:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Fri, 15 Jan 2021 18:54:38 +01:00

x86/platform/geode: Convert geode LED to GPIO machine descriptor

Look up the LED from a GPIO machine descriptor table. The Geode LEDs
should be on the CS5535 companion chip.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Borislav Petkov <bp@suse.de>
Reviewed-by: Hans de Goede <hdegoede@redhat.com>
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Link: https://lkml.kernel.org/r/20201124085339.6181-2-linus.walleij@linaro.org
---
 arch/x86/platform/geode/geos.c | 19 +++++++++++++------
 1 file changed, 13 insertions(+), 6 deletions(-)

diff --git a/arch/x86/platform/geode/geos.c b/arch/x86/platform/geode/geos.c
index 73a3f49..d263528 100644
--- a/arch/x86/platform/geode/geos.c
+++ b/arch/x86/platform/geode/geos.c
@@ -20,6 +20,7 @@
 #include <linux/platform_device.h>
 #include <linux/input.h>
 #include <linux/gpio_keys.h>
+#include <linux/gpio/machine.h>
 #include <linux/dmi.h>
 
 #include <asm/geode.h>
@@ -53,21 +54,15 @@ static struct platform_device geos_buttons_dev = {
 static struct gpio_led geos_leds[] = {
 	{
 		.name = "geos:1",
-		.gpio = 6,
 		.default_trigger = "default-on",
-		.active_low = 1,
 	},
 	{
 		.name = "geos:2",
-		.gpio = 25,
 		.default_trigger = "default-off",
-		.active_low = 1,
 	},
 	{
 		.name = "geos:3",
-		.gpio = 27,
 		.default_trigger = "default-off",
-		.active_low = 1,
 	},
 };
 
@@ -76,6 +71,17 @@ static struct gpio_led_platform_data geos_leds_data = {
 	.leds = geos_leds,
 };
 
+static struct gpiod_lookup_table geos_leds_gpio_table = {
+	.dev_id = "leds-gpio",
+	.table = {
+		/* The Geode GPIOs should be on the CS5535 companion chip */
+		GPIO_LOOKUP_IDX("cs5535-gpio", 6, NULL, 0, GPIO_ACTIVE_LOW),
+		GPIO_LOOKUP_IDX("cs5535-gpio", 25, NULL, 1, GPIO_ACTIVE_LOW),
+		GPIO_LOOKUP_IDX("cs5535-gpio", 27, NULL, 2, GPIO_ACTIVE_LOW),
+		{ }
+	},
+};
+
 static struct platform_device geos_leds_dev = {
 	.name = "leds-gpio",
 	.id = -1,
@@ -90,6 +96,7 @@ static struct platform_device *geos_devs[] __initdata = {
 static void __init register_geos(void)
 {
 	/* Setup LED control through leds-gpio driver */
+	gpiod_add_lookup_table(&geos_leds_gpio_table);
 	platform_add_devices(geos_devs, ARRAY_SIZE(geos_devs));
 }
 
