Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C14502F8341
	for <lists+linux-tip-commits@lfdr.de>; Fri, 15 Jan 2021 19:04:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728537AbhAOSEN (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 15 Jan 2021 13:04:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728176AbhAOSEM (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 15 Jan 2021 13:04:12 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81AE8C0613C1;
        Fri, 15 Jan 2021 10:03:32 -0800 (PST)
Date:   Fri, 15 Jan 2021 18:03:29 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1610733810;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+hqejZAOe1j6q20zTc4fZ1sxbglEhPIzQnMWYU8km7g=;
        b=U3Jvj4KVrSekzZPI4aw/t8XbigQOK7Kibwm679zCYbKuW0nfRSgnx0ivAcW7mrNYwQmZXQ
        wFM5sW2gXq5kQy2bH71PZ1u5SO3ZxjO+WynFy4fyf/Dd5olrkPTOQ6KDUIIeaI6go0AZKw
        wss3v554TA+kSXiHpnaRsc2PFCcljHmEA39bUN6xZH9G1m9Euy88WfElMFlYVpPqNu6knn
        2cLzpa93D4tBIMvu/9R7pNz7aHIBoUZIjmf10lu8B1czgNrIT0aij+2Qck3qxFO7ZO2NAc
        yHTsZmCVaQDnPE7039uw7j4HKp9Hw0h5H3Erb5QNSZgJnAGTdKgZ+yi6UMVztQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1610733810;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+hqejZAOe1j6q20zTc4fZ1sxbglEhPIzQnMWYU8km7g=;
        b=750yRhraTVEodPdez8batbIrMQbbgbxsfrlm9vltWm2bdzs6lbaXGV3k/pjl0LzLyPvESy
        d3AYjSf4N471DwCA==
From:   "tip-bot2 for Linus Walleij" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/platform] x86/platform/geode: Convert net5501 LED to GPIO
 machine descriptor
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Borislav Petkov <bp@suse.de>,
        Hans de Goede <hdegoede@redhat.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20201124085339.6181-1-linus.walleij@linaro.org>
References: <20201124085339.6181-1-linus.walleij@linaro.org>
MIME-Version: 1.0
Message-ID: <161073380972.414.17623871843847483339.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/platform branch of tip:

Commit-ID:     3ff13602d7cae283bca1c52caacd0ca6426f37d2
Gitweb:        https://git.kernel.org/tip/3ff13602d7cae283bca1c52caacd0ca6426f37d2
Author:        Linus Walleij <linus.walleij@linaro.org>
AuthorDate:    Tue, 24 Nov 2020 09:53:37 +01:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Fri, 15 Jan 2021 18:47:49 +01:00

x86/platform/geode: Convert net5501 LED to GPIO machine descriptor

Look up the LED from a GPIO machine descriptor table. The Geode LEDs
should be on the CS5535 companion chip.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Borislav Petkov <bp@suse.de>
Reviewed-by: Hans de Goede <hdegoede@redhat.com>
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Link: https://lkml.kernel.org/r/20201124085339.6181-1-linus.walleij@linaro.org
---
 arch/x86/platform/geode/net5501.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/arch/x86/platform/geode/net5501.c b/arch/x86/platform/geode/net5501.c
index 163e1b5..558384a 100644
--- a/arch/x86/platform/geode/net5501.c
+++ b/arch/x86/platform/geode/net5501.c
@@ -20,6 +20,7 @@
 #include <linux/platform_device.h>
 #include <linux/input.h>
 #include <linux/gpio_keys.h>
+#include <linux/gpio/machine.h>
 
 #include <asm/geode.h>
 
@@ -55,9 +56,7 @@ static struct platform_device net5501_buttons_dev = {
 static struct gpio_led net5501_leds[] = {
 	{
 		.name = "net5501:1",
-		.gpio = 6,
 		.default_trigger = "default-on",
-		.active_low = 0,
 	},
 };
 
@@ -66,6 +65,15 @@ static struct gpio_led_platform_data net5501_leds_data = {
 	.leds = net5501_leds,
 };
 
+static struct gpiod_lookup_table net5501_leds_gpio_table = {
+	.dev_id = "leds-gpio",
+	.table = {
+		/* The Geode GPIOs should be on the CS5535 companion chip */
+		GPIO_LOOKUP_IDX("cs5535-gpio", 6, NULL, 0, GPIO_ACTIVE_HIGH),
+		{ }
+	},
+};
+
 static struct platform_device net5501_leds_dev = {
 	.name = "leds-gpio",
 	.id = -1,
@@ -80,6 +88,7 @@ static struct platform_device *net5501_devs[] __initdata = {
 static void __init register_net5501(void)
 {
 	/* Setup LED control through leds-gpio driver */
+	gpiod_add_lookup_table(&net5501_leds_gpio_table);
 	platform_add_devices(net5501_devs, ARRAY_SIZE(net5501_devs));
 }
 
