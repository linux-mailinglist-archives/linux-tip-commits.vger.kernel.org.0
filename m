Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9BE38316356
	for <lists+linux-tip-commits@lfdr.de>; Wed, 10 Feb 2021 11:10:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230522AbhBJKKF (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 10 Feb 2021 05:10:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230483AbhBJKID (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 10 Feb 2021 05:08:03 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 170ABC06178B;
        Wed, 10 Feb 2021 02:06:29 -0800 (PST)
Date:   Wed, 10 Feb 2021 10:06:24 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1612951587;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LVIUN0mDiPUJM7MQIns1ih3IA6LbLYq2HzLbxD1MGXg=;
        b=fm0oIp7YCp3+JQTvivPGMHH2PzY/PA+VWZxjwk3YCKl19rOfZIXJ/SeI5f8pSYJh4Q05fT
        q2N4MmcNPv7gWMIyyAjd/adrn8U57hlzMwILwqL0V8RWSWGlDBfXblhnCefadPb98VpSdJ
        F8SDSLHil8e0aLy2kE8MrUctZcOZXPQPglUzNyOpsJ7sEyk6tSYKMGyK3X8UO1p4Z5cEw4
        fovAA18N3KARx5wx3ot6dy3FBtjgTlhoH8KrlV9rjE1ygH6iTdodh95Gs68SpZ+fGz1Jc9
        BD8qQkyauksAGsFRq8MOHc2j1rglaolzOBJCUVxsH2IuvB2ZhOI9vdCKUXi7vg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1612951587;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LVIUN0mDiPUJM7MQIns1ih3IA6LbLYq2HzLbxD1MGXg=;
        b=dgQrOprWi6f3gdeT8yag2SAtjQUe6gRQZ9ZjK2AYCkx7bggyb++GxUqQsYBAsw+48TLMZt
        TeCh0WLIdc1th4BA==
From:   "tip-bot2 for Arnd Bergmann" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] clocksource/drivers/tango: Remove tango driver
Cc:     Marc Gonzalez <marc.w.gonzalez@free.fr>,
        Mans Rullgard <mans@mansr.com>, Arnd Bergmann <arnd@arndb.de>,
        Daniel Lezcano <daniel.lezcano@linaro.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210120131559.1971359-3-arnd@kernel.org>
References: <20210120131559.1971359-3-arnd@kernel.org>
MIME-Version: 1.0
Message-ID: <161295158456.23325.1332606250636032685.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     8fdb44176928fb3ef3e10d97eaf1aed82c90bd58
Gitweb:        https://git.kernel.org/tip/8fdb44176928fb3ef3e10d97eaf1aed82c90bd58
Author:        Arnd Bergmann <arnd@arndb.de>
AuthorDate:    Wed, 20 Jan 2021 14:15:57 +01:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Wed, 03 Feb 2021 09:11:35 +01:00

clocksource/drivers/tango: Remove tango driver

The tango platform is getting removed, so the driver is no
longer needed.

Cc: Marc Gonzalez <marc.w.gonzalez@free.fr>
Cc: Mans Rullgard <mans@mansr.com>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Acked-by: Mans Rullgard <mans@mansr.com>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Link: https://lore.kernel.org/r/20210120131559.1971359-3-arnd@kernel.org
---
 drivers/clocksource/Kconfig            |  8 +----
 drivers/clocksource/Makefile           |  1 +-
 drivers/clocksource/timer-tango-xtal.c | 57 +-------------------------
 3 files changed, 66 deletions(-)
 delete mode 100644 drivers/clocksource/timer-tango-xtal.c

diff --git a/drivers/clocksource/Kconfig b/drivers/clocksource/Kconfig
index b26bb9e..b5250e4 100644
--- a/drivers/clocksource/Kconfig
+++ b/drivers/clocksource/Kconfig
@@ -551,14 +551,6 @@ config CLKSRC_MIPS_GIC
 	select CLOCKSOURCE_WATCHDOG
 	select TIMER_OF
 
-config CLKSRC_TANGO_XTAL
-	bool "Clocksource for Tango SoC" if COMPILE_TEST
-	depends on ARM
-	select TIMER_OF
-	select CLKSRC_MMIO
-	help
-	  This enables the clocksource for Tango SoC.
-
 config CLKSRC_PXA
 	bool "Clocksource for PXA or SA-11x0 platform" if COMPILE_TEST
 	depends on HAS_IOMEM
diff --git a/drivers/clocksource/Makefile b/drivers/clocksource/Makefile
index ce8a3c0..1b05f03 100644
--- a/drivers/clocksource/Makefile
+++ b/drivers/clocksource/Makefile
@@ -71,7 +71,6 @@ obj-$(CONFIG_KEYSTONE_TIMER)		+= timer-keystone.o
 obj-$(CONFIG_INTEGRATOR_AP_TIMER)	+= timer-integrator-ap.o
 obj-$(CONFIG_CLKSRC_VERSATILE)		+= timer-versatile.o
 obj-$(CONFIG_CLKSRC_MIPS_GIC)		+= mips-gic-timer.o
-obj-$(CONFIG_CLKSRC_TANGO_XTAL)		+= timer-tango-xtal.o
 obj-$(CONFIG_CLKSRC_IMX_GPT)		+= timer-imx-gpt.o
 obj-$(CONFIG_CLKSRC_IMX_TPM)		+= timer-imx-tpm.o
 obj-$(CONFIG_TIMER_IMX_SYS_CTR)		+= timer-imx-sysctr.o
diff --git a/drivers/clocksource/timer-tango-xtal.c b/drivers/clocksource/timer-tango-xtal.c
deleted file mode 100644
index 3f94e45..0000000
--- a/drivers/clocksource/timer-tango-xtal.c
+++ /dev/null
@@ -1,57 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-#include <linux/clocksource.h>
-#include <linux/sched_clock.h>
-#include <linux/of_address.h>
-#include <linux/printk.h>
-#include <linux/delay.h>
-#include <linux/init.h>
-#include <linux/clk.h>
-
-static void __iomem *xtal_in_cnt;
-static struct delay_timer delay_timer;
-
-static unsigned long notrace read_xtal_counter(void)
-{
-	return readl_relaxed(xtal_in_cnt);
-}
-
-static u64 notrace read_sched_clock(void)
-{
-	return read_xtal_counter();
-}
-
-static int __init tango_clocksource_init(struct device_node *np)
-{
-	struct clk *clk;
-	int xtal_freq, ret;
-
-	xtal_in_cnt = of_iomap(np, 0);
-	if (xtal_in_cnt == NULL) {
-		pr_err("%pOF: invalid address\n", np);
-		return -ENXIO;
-	}
-
-	clk = of_clk_get(np, 0);
-	if (IS_ERR(clk)) {
-		pr_err("%pOF: invalid clock\n", np);
-		return PTR_ERR(clk);
-	}
-
-	xtal_freq = clk_get_rate(clk);
-	delay_timer.freq = xtal_freq;
-	delay_timer.read_current_timer = read_xtal_counter;
-
-	ret = clocksource_mmio_init(xtal_in_cnt, "tango-xtal", xtal_freq, 350,
-				    32, clocksource_mmio_readl_up);
-	if (ret) {
-		pr_err("%pOF: registration failed\n", np);
-		return ret;
-	}
-
-	sched_clock_register(read_sched_clock, 32, xtal_freq);
-	register_current_timer_delay(&delay_timer);
-
-	return 0;
-}
-
-TIMER_OF_DECLARE(tango, "sigma,tick-counter", tango_clocksource_init);
