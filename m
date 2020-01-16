Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 10F2913FB8B
	for <lists+linux-tip-commits@lfdr.de>; Thu, 16 Jan 2020 22:32:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389150AbgAPVbc (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Thu, 16 Jan 2020 16:31:32 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:53585 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389044AbgAPVbO (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Thu, 16 Jan 2020 16:31:14 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1isCjL-0001YA-Ka; Thu, 16 Jan 2020 22:31:07 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 141B71C1970;
        Thu, 16 Jan 2020 22:31:02 +0100 (CET)
Date:   Thu, 16 Jan 2020 21:31:01 -0000
From:   "tip-bot2 for Rajan Vaja" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] clocksource/drivers/cadence-ttc: Use ttc driver as
 platform driver
Cc:     Rajan Vaja <rajan.vaja@xilinx.com>,
        Michal Simek <michal.simek@xilinx.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <1573122988-18399-1-git-send-email-rajan.vaja@xilinx.com>
References: <1573122988-18399-1-git-send-email-rajan.vaja@xilinx.com>
MIME-Version: 1.0
Message-ID: <157921026187.396.13367165250949261182.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-tip-commits-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     f5ac896b6a23eb46681cdbef440c1d991b04e519
Gitweb:        https://git.kernel.org/tip/f5ac896b6a23eb46681cdbef440c1d991b04e519
Author:        Rajan Vaja <rajan.vaja@xilinx.com>
AuthorDate:    Thu, 07 Nov 2019 02:36:28 -08:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Thu, 16 Jan 2020 19:06:57 +01:00

clocksource/drivers/cadence-ttc: Use ttc driver as platform driver

Currently TTC driver is TIMER_OF_DECLARE type driver. Because of
that, TTC driver may be initialized before other clock drivers. If
TTC driver is dependent on that clock driver then initialization of
TTC driver will failed.

So use TTC driver as platform driver instead of using
TIMER_OF_DECLARE.

Signed-off-by: Rajan Vaja <rajan.vaja@xilinx.com>
Tested-by: Michal Simek <michal.simek@xilinx.com>
Acked-by: Michal Simek <michal.simek@xilinx.com>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Link: https://lore.kernel.org/r/1573122988-18399-1-git-send-email-rajan.vaja@xilinx.com
---
 drivers/clocksource/timer-cadence-ttc.c | 26 ++++++++++++++++--------
 1 file changed, 18 insertions(+), 8 deletions(-)

diff --git a/drivers/clocksource/timer-cadence-ttc.c b/drivers/clocksource/timer-cadence-ttc.c
index 88fe2e9..38858e1 100644
--- a/drivers/clocksource/timer-cadence-ttc.c
+++ b/drivers/clocksource/timer-cadence-ttc.c
@@ -15,6 +15,8 @@
 #include <linux/of_irq.h>
 #include <linux/slab.h>
 #include <linux/sched_clock.h>
+#include <linux/module.h>
+#include <linux/of_platform.h>
 
 /*
  * This driver configures the 2 16/32-bit count-up timers as follows:
@@ -464,13 +466,7 @@ static int __init ttc_setup_clockevent(struct clk *clk,
 	return 0;
 }
 
-/**
- * ttc_timer_init - Initialize the timer
- *
- * Initializes the timer hardware and register the clock source and clock event
- * timers with Linux kernal timer framework
- */
-static int __init ttc_timer_init(struct device_node *timer)
+static int __init ttc_timer_probe(struct platform_device *pdev)
 {
 	unsigned int irq;
 	void __iomem *timer_baseaddr;
@@ -478,6 +474,7 @@ static int __init ttc_timer_init(struct device_node *timer)
 	static int initialized;
 	int clksel, ret;
 	u32 timer_width = 16;
+	struct device_node *timer = pdev->dev.of_node;
 
 	if (initialized)
 		return 0;
@@ -532,4 +529,17 @@ static int __init ttc_timer_init(struct device_node *timer)
 	return 0;
 }
 
-TIMER_OF_DECLARE(ttc, "cdns,ttc", ttc_timer_init);
+static const struct of_device_id ttc_timer_of_match[] = {
+	{.compatible = "cdns,ttc"},
+	{},
+};
+
+MODULE_DEVICE_TABLE(of, ttc_timer_of_match);
+
+static struct platform_driver ttc_timer_driver = {
+	.driver = {
+		.name	= "cdns_ttc_timer",
+		.of_match_table = ttc_timer_of_match,
+	},
+};
+builtin_platform_driver_probe(ttc_timer_driver, ttc_timer_probe);
