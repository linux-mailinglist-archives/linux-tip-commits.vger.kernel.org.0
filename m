Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 70FB82F833D
	for <lists+linux-tip-commits@lfdr.de>; Fri, 15 Jan 2021 19:04:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726434AbhAOSEM (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 15 Jan 2021 13:04:12 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:40674 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726404AbhAOSEM (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 15 Jan 2021 13:04:12 -0500
Date:   Fri, 15 Jan 2021 18:03:28 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1610733810;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=W4BPOc4S2sdSSWBpTWKb2Ju5xAfxfSnO2Ne2If1bszU=;
        b=mAUd+HR0k0RZrme1tjkSgTfgvUm428T1IHOQkCVBFftILzfVsJ1VZnVR8HVYX0zwJBSj8b
        /5QU1uEw3CDS+YHI+piO6oqG0lcwVUSqUy+dvgrnybIetaXDqn8ja2N7AaLnoscgBTT8pQ
        0+wIAm2QNmcRiT0Nydv1IIHnKGPTy1wi8K7ZQWH76DyHUawOmjgxt9b4jsnIzXn8LefhOJ
        Jwn2cxvilwCJvogaIPh45uskAF720Wy8AkBU68l9oLOKg3OrNyDOhtyNDX0bG1ExhrRW2D
        D4OzJwhfs+eKCDcCzYyWdt0eY1b8HWh12hSt70WlpoaI4KBJfyT/owgoWaAZSw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1610733810;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=W4BPOc4S2sdSSWBpTWKb2Ju5xAfxfSnO2Ne2If1bszU=;
        b=vJef5Vp/EjekYMZ4UGoSiv7dFKIjmfAa1jG1r5cuYNHcXym+6On5R0b+slQi+kuLMbDpbp
        E/wlvl01+zaqCoAg==
From:   "tip-bot2 for Linus Walleij" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/platform] x86/platform/geode: Convert alix LED to GPIO
 machine descriptor
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Borislav Petkov <bp@suse.de>,
        Hans de Goede <hdegoede@redhat.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20201124085339.6181-3-linus.walleij@linaro.org>
References: <20201124085339.6181-3-linus.walleij@linaro.org>
MIME-Version: 1.0
Message-ID: <161073380900.414.10975437601520958385.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/platform branch of tip:

Commit-ID:     604303018221d00b58422e1d117ba29ce84295cb
Gitweb:        https://git.kernel.org/tip/604303018221d00b58422e1d117ba29ce84295cb
Author:        Linus Walleij <linus.walleij@linaro.org>
AuthorDate:    Tue, 24 Nov 2020 09:53:39 +01:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Fri, 15 Jan 2021 18:55:53 +01:00

x86/platform/geode: Convert alix LED to GPIO machine descriptor

Look up the LED from a GPIO machine descriptor table. The Geode LEDs
should be on the CS5535 companion chip.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Borislav Petkov <bp@suse.de>
Reviewed-by: Hans de Goede <hdegoede@redhat.com>
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Link: https://lkml.kernel.org/r/20201124085339.6181-3-linus.walleij@linaro.org
---
 arch/x86/platform/geode/alix.c | 19 +++++++++++++------
 1 file changed, 13 insertions(+), 6 deletions(-)

diff --git a/arch/x86/platform/geode/alix.c b/arch/x86/platform/geode/alix.c
index c33f744..b39bf3b 100644
--- a/arch/x86/platform/geode/alix.c
+++ b/arch/x86/platform/geode/alix.c
@@ -22,6 +22,7 @@
 #include <linux/platform_device.h>
 #include <linux/input.h>
 #include <linux/gpio_keys.h>
+#include <linux/gpio/machine.h>
 #include <linux/dmi.h>
 
 #include <asm/geode.h>
@@ -69,21 +70,15 @@ static struct platform_device alix_buttons_dev = {
 static struct gpio_led alix_leds[] = {
 	{
 		.name = "alix:1",
-		.gpio = 6,
 		.default_trigger = "default-on",
-		.active_low = 1,
 	},
 	{
 		.name = "alix:2",
-		.gpio = 25,
 		.default_trigger = "default-off",
-		.active_low = 1,
 	},
 	{
 		.name = "alix:3",
-		.gpio = 27,
 		.default_trigger = "default-off",
-		.active_low = 1,
 	},
 };
 
@@ -92,6 +87,17 @@ static struct gpio_led_platform_data alix_leds_data = {
 	.leds = alix_leds,
 };
 
+static struct gpiod_lookup_table alix_leds_gpio_table = {
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
 static struct platform_device alix_leds_dev = {
 	.name = "leds-gpio",
 	.id = -1,
@@ -106,6 +112,7 @@ static struct platform_device *alix_devs[] __initdata = {
 static void __init register_alix(void)
 {
 	/* Setup LED control through leds-gpio driver */
+	gpiod_add_lookup_table(&alix_leds_gpio_table);
 	platform_add_devices(alix_devs, ARRAY_SIZE(alix_devs));
 }
 
