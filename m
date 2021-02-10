Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 775C831633F
	for <lists+linux-tip-commits@lfdr.de>; Wed, 10 Feb 2021 11:09:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230018AbhBJKJd (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 10 Feb 2021 05:09:33 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:58090 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230379AbhBJKHL (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 10 Feb 2021 05:07:11 -0500
Date:   Wed, 10 Feb 2021 10:06:25 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1612951588;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HFElhJXcH/rTP70CatrXXqHYO6/EMpy4OYIZD9OGn2g=;
        b=jrFU2gJWlzizNgJDMZi6Qgod3lyq+XhXYjjCou/bvbhr2J7Ka50oC4R83M2UGZVIfjuiSW
        xMxXviS3p6DICnTlMhSFSfw3aFa5wvtRvdUVw8gxVCq+gpJ5qLhtD231TwnwACc+iX3HrP
        K/lTmamUUGkzSKG1KpQtvVl5exorxZhAMC+YlD3nXvxPRJ56SMgwdP0LJF52XxAm0KWaZs
        6McjisGkGDWJ6qEpWa7CcTy1qW7TW1Tk9MbxuhaKllhpl6lcRgcvGeK91wcZVyARKp7w36
        5SlSn38hkuMFF5R+9QLl3BCXFg/s8VI/4XFgsoydY7jsdIVmRh5wckec/E5wgQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1612951588;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HFElhJXcH/rTP70CatrXXqHYO6/EMpy4OYIZD9OGn2g=;
        b=upvRInNcFI3Yr3copa3ylI3nSqN/GLwigGQyitE2qCLqVt3yHTKRDsg/dJOwH5cHjIn9+K
        5zcMzPfCntfrFHDQ==
From:   tip-bot2 for Uwe =?utf-8?q?Kleine-K=C3=B6nig?= 
        <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] clocksource/drivers/efm32: Drop unused timer code
Cc:     u.kleine-koenig@pengutronix.de,
        Daniel Lezcano <daniel.lezcano@linaro.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210115155130.185010-4-u.kleine-koenig@pengutronix.de>
References: <20210115155130.185010-4-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Message-ID: <161295158547.23325.15638365010660281338.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     523d83ef0979a9d0c8340913b40b696cb4f2f050
Gitweb:        https://git.kernel.org/tip/523d83ef0979a9d0c8340913b40b696cb4f=
2f050
Author:        Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
AuthorDate:    Fri, 15 Jan 2021 16:51:26 +01:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Mon, 18 Jan 2021 16:29:54 +01:00

clocksource/drivers/efm32: Drop unused timer code

Support for this machine was just removed, so drop the now unused timer
code, too.

Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Link: https://lore.kernel.org/r/20210115155130.185010-4-u.kleine-koenig@pengu=
tronix.de
---
 drivers/clocksource/Kconfig       |   9 +-
 drivers/clocksource/Makefile      |   1 +-
 drivers/clocksource/timer-efm32.c | 278 +-----------------------------
 3 files changed, 288 deletions(-)
 delete mode 100644 drivers/clocksource/timer-efm32.c

diff --git a/drivers/clocksource/Kconfig b/drivers/clocksource/Kconfig
index 9f00b83..6bf89e2 100644
--- a/drivers/clocksource/Kconfig
+++ b/drivers/clocksource/Kconfig
@@ -242,15 +242,6 @@ config INTEGRATOR_AP_TIMER
 	help
 	  Enables support for the Integrator-AP timer.
=20
-config CLKSRC_EFM32
-	bool "Clocksource for Energy Micro's EFM32 SoCs" if !ARCH_EFM32
-	depends on OF && ARM && (ARCH_EFM32 || COMPILE_TEST)
-	select CLKSRC_MMIO
-	default ARCH_EFM32
-	help
-	  Support to use the timers of EFM32 SoCs as clock source and clock
-	  event device.
-
 config CLKSRC_LPC32XX
 	bool "Clocksource for LPC32XX" if COMPILE_TEST
 	depends on HAS_IOMEM
diff --git a/drivers/clocksource/Makefile b/drivers/clocksource/Makefile
index 3c75cbb..0817338 100644
--- a/drivers/clocksource/Makefile
+++ b/drivers/clocksource/Makefile
@@ -43,7 +43,6 @@ obj-$(CONFIG_VT8500_TIMER)	+=3D timer-vt8500.o
 obj-$(CONFIG_NSPIRE_TIMER)	+=3D timer-zevio.o
 obj-$(CONFIG_BCM_KONA_TIMER)	+=3D bcm_kona_timer.o
 obj-$(CONFIG_CADENCE_TTC_TIMER)	+=3D timer-cadence-ttc.o
-obj-$(CONFIG_CLKSRC_EFM32)	+=3D timer-efm32.o
 obj-$(CONFIG_CLKSRC_STM32)	+=3D timer-stm32.o
 obj-$(CONFIG_CLKSRC_STM32_LP)	+=3D timer-stm32-lp.o
 obj-$(CONFIG_CLKSRC_EXYNOS_MCT)	+=3D exynos_mct.o
diff --git a/drivers/clocksource/timer-efm32.c b/drivers/clocksource/timer-ef=
m32.c
deleted file mode 100644
index 441a4b9..0000000
--- a/drivers/clocksource/timer-efm32.c
+++ /dev/null
@@ -1,278 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-only
-/*
- * Copyright (C) 2013 Pengutronix
- * Uwe Kleine-Koenig <u.kleine-koenig@pengutronix.de>
- */
-
-#define pr_fmt(fmt)	KBUILD_MODNAME ": " fmt
-
-#include <linux/kernel.h>
-#include <linux/clocksource.h>
-#include <linux/clockchips.h>
-#include <linux/irq.h>
-#include <linux/interrupt.h>
-#include <linux/of.h>
-#include <linux/of_address.h>
-#include <linux/of_irq.h>
-#include <linux/clk.h>
-
-#define TIMERn_CTRL			0x00
-#define TIMERn_CTRL_PRESC(val)			(((val) & 0xf) << 24)
-#define TIMERn_CTRL_PRESC_1024			TIMERn_CTRL_PRESC(10)
-#define TIMERn_CTRL_CLKSEL(val)			(((val) & 0x3) << 16)
-#define TIMERn_CTRL_CLKSEL_PRESCHFPERCLK	TIMERn_CTRL_CLKSEL(0)
-#define TIMERn_CTRL_OSMEN			0x00000010
-#define TIMERn_CTRL_MODE(val)			(((val) & 0x3) <<  0)
-#define TIMERn_CTRL_MODE_UP			TIMERn_CTRL_MODE(0)
-#define TIMERn_CTRL_MODE_DOWN			TIMERn_CTRL_MODE(1)
-
-#define TIMERn_CMD			0x04
-#define TIMERn_CMD_START			0x00000001
-#define TIMERn_CMD_STOP				0x00000002
-
-#define TIMERn_IEN			0x0c
-#define TIMERn_IF			0x10
-#define TIMERn_IFS			0x14
-#define TIMERn_IFC			0x18
-#define TIMERn_IRQ_UF				0x00000002
-
-#define TIMERn_TOP			0x1c
-#define TIMERn_CNT			0x24
-
-struct efm32_clock_event_ddata {
-	struct clock_event_device evtdev;
-	void __iomem *base;
-	unsigned periodic_top;
-};
-
-static int efm32_clock_event_shutdown(struct clock_event_device *evtdev)
-{
-	struct efm32_clock_event_ddata *ddata =3D
-		container_of(evtdev, struct efm32_clock_event_ddata, evtdev);
-
-	writel_relaxed(TIMERn_CMD_STOP, ddata->base + TIMERn_CMD);
-	return 0;
-}
-
-static int efm32_clock_event_set_oneshot(struct clock_event_device *evtdev)
-{
-	struct efm32_clock_event_ddata *ddata =3D
-		container_of(evtdev, struct efm32_clock_event_ddata, evtdev);
-
-	writel_relaxed(TIMERn_CMD_STOP, ddata->base + TIMERn_CMD);
-	writel_relaxed(TIMERn_CTRL_PRESC_1024 |
-		       TIMERn_CTRL_CLKSEL_PRESCHFPERCLK |
-		       TIMERn_CTRL_OSMEN |
-		       TIMERn_CTRL_MODE_DOWN,
-		       ddata->base + TIMERn_CTRL);
-	return 0;
-}
-
-static int efm32_clock_event_set_periodic(struct clock_event_device *evtdev)
-{
-	struct efm32_clock_event_ddata *ddata =3D
-		container_of(evtdev, struct efm32_clock_event_ddata, evtdev);
-
-	writel_relaxed(TIMERn_CMD_STOP, ddata->base + TIMERn_CMD);
-	writel_relaxed(ddata->periodic_top, ddata->base + TIMERn_TOP);
-	writel_relaxed(TIMERn_CTRL_PRESC_1024 |
-		       TIMERn_CTRL_CLKSEL_PRESCHFPERCLK |
-		       TIMERn_CTRL_MODE_DOWN,
-		       ddata->base + TIMERn_CTRL);
-	writel_relaxed(TIMERn_CMD_START, ddata->base + TIMERn_CMD);
-	return 0;
-}
-
-static int efm32_clock_event_set_next_event(unsigned long evt,
-					    struct clock_event_device *evtdev)
-{
-	struct efm32_clock_event_ddata *ddata =3D
-		container_of(evtdev, struct efm32_clock_event_ddata, evtdev);
-
-	writel_relaxed(TIMERn_CMD_STOP, ddata->base + TIMERn_CMD);
-	writel_relaxed(evt, ddata->base + TIMERn_CNT);
-	writel_relaxed(TIMERn_CMD_START, ddata->base + TIMERn_CMD);
-
-	return 0;
-}
-
-static irqreturn_t efm32_clock_event_handler(int irq, void *dev_id)
-{
-	struct efm32_clock_event_ddata *ddata =3D dev_id;
-
-	writel_relaxed(TIMERn_IRQ_UF, ddata->base + TIMERn_IFC);
-
-	ddata->evtdev.event_handler(&ddata->evtdev);
-
-	return IRQ_HANDLED;
-}
-
-static struct efm32_clock_event_ddata clock_event_ddata =3D {
-	.evtdev =3D {
-		.name =3D "efm32 clockevent",
-		.features =3D CLOCK_EVT_FEAT_ONESHOT | CLOCK_EVT_FEAT_PERIODIC,
-		.set_state_shutdown =3D efm32_clock_event_shutdown,
-		.set_state_periodic =3D efm32_clock_event_set_periodic,
-		.set_state_oneshot =3D efm32_clock_event_set_oneshot,
-		.set_next_event =3D efm32_clock_event_set_next_event,
-		.rating =3D 200,
-	},
-};
-
-static int __init efm32_clocksource_init(struct device_node *np)
-{
-	struct clk *clk;
-	void __iomem *base;
-	unsigned long rate;
-	int ret;
-
-	clk =3D of_clk_get(np, 0);
-	if (IS_ERR(clk)) {
-		ret =3D PTR_ERR(clk);
-		pr_err("failed to get clock for clocksource (%d)\n", ret);
-		goto err_clk_get;
-	}
-
-	ret =3D clk_prepare_enable(clk);
-	if (ret) {
-		pr_err("failed to enable timer clock for clocksource (%d)\n",
-		       ret);
-		goto err_clk_enable;
-	}
-	rate =3D clk_get_rate(clk);
-
-	base =3D of_iomap(np, 0);
-	if (!base) {
-		ret =3D -EADDRNOTAVAIL;
-		pr_err("failed to map registers for clocksource\n");
-		goto err_iomap;
-	}
-
-	writel_relaxed(TIMERn_CTRL_PRESC_1024 |
-		       TIMERn_CTRL_CLKSEL_PRESCHFPERCLK |
-		       TIMERn_CTRL_MODE_UP, base + TIMERn_CTRL);
-	writel_relaxed(TIMERn_CMD_START, base + TIMERn_CMD);
-
-	ret =3D clocksource_mmio_init(base + TIMERn_CNT, "efm32 timer",
-				    DIV_ROUND_CLOSEST(rate, 1024), 200, 16,
-				    clocksource_mmio_readl_up);
-	if (ret) {
-		pr_err("failed to init clocksource (%d)\n", ret);
-		goto err_clocksource_init;
-	}
-
-	return 0;
-
-err_clocksource_init:
-
-	iounmap(base);
-err_iomap:
-
-	clk_disable_unprepare(clk);
-err_clk_enable:
-
-	clk_put(clk);
-err_clk_get:
-
-	return ret;
-}
-
-static int __init efm32_clockevent_init(struct device_node *np)
-{
-	struct clk *clk;
-	void __iomem *base;
-	unsigned long rate;
-	int irq;
-	int ret;
-
-	clk =3D of_clk_get(np, 0);
-	if (IS_ERR(clk)) {
-		ret =3D PTR_ERR(clk);
-		pr_err("failed to get clock for clockevent (%d)\n", ret);
-		goto err_clk_get;
-	}
-
-	ret =3D clk_prepare_enable(clk);
-	if (ret) {
-		pr_err("failed to enable timer clock for clockevent (%d)\n",
-		       ret);
-		goto err_clk_enable;
-	}
-	rate =3D clk_get_rate(clk);
-
-	base =3D of_iomap(np, 0);
-	if (!base) {
-		ret =3D -EADDRNOTAVAIL;
-		pr_err("failed to map registers for clockevent\n");
-		goto err_iomap;
-	}
-
-	irq =3D irq_of_parse_and_map(np, 0);
-	if (!irq) {
-		ret =3D -ENOENT;
-		pr_err("failed to get irq for clockevent\n");
-		goto err_get_irq;
-	}
-
-	writel_relaxed(TIMERn_IRQ_UF, base + TIMERn_IEN);
-
-	clock_event_ddata.base =3D base;
-	clock_event_ddata.periodic_top =3D DIV_ROUND_CLOSEST(rate, 1024 * HZ);
-
-	clockevents_config_and_register(&clock_event_ddata.evtdev,
-					DIV_ROUND_CLOSEST(rate, 1024),
-					0xf, 0xffff);
-
-	ret =3D request_irq(irq, efm32_clock_event_handler, IRQF_TIMER,
-			  "efm32 clockevent", &clock_event_ddata);
-	if (ret) {
-		pr_err("Failed setup irq\n");
-		goto err_setup_irq;
-	}
-
-	return 0;
-
-err_setup_irq:
-err_get_irq:
-
-	iounmap(base);
-err_iomap:
-
-	clk_disable_unprepare(clk);
-err_clk_enable:
-
-	clk_put(clk);
-err_clk_get:
-
-	return ret;
-}
-
-/*
- * This function asserts that we have exactly one clocksource and one
- * clock_event_device in the end.
- */
-static int __init efm32_timer_init(struct device_node *np)
-{
-	static int has_clocksource, has_clockevent;
-	int ret =3D 0;
-
-	if (!has_clocksource) {
-		ret =3D efm32_clocksource_init(np);
-		if (!ret) {
-			has_clocksource =3D 1;
-			return 0;
-		}
-	}
-
-	if (!has_clockevent) {
-		ret =3D efm32_clockevent_init(np);
-		if (!ret) {
-			has_clockevent =3D 1;
-			return 0;
-		}
-	}
-
-	return ret;
-}
-TIMER_OF_DECLARE(efm32compat, "efm32,timer", efm32_timer_init);
-TIMER_OF_DECLARE(efm32, "energymicro,efm32-timer", efm32_timer_init);
