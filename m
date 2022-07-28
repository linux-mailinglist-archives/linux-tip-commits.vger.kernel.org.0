Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6713D583C5E
	for <lists+linux-tip-commits@lfdr.de>; Thu, 28 Jul 2022 12:45:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236071AbiG1Kpo (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Thu, 28 Jul 2022 06:45:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236482AbiG1Koy (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Thu, 28 Jul 2022 06:44:54 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31CDE664C8;
        Thu, 28 Jul 2022 03:44:21 -0700 (PDT)
Date:   Thu, 28 Jul 2022 10:44:18 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1659005059;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VW1bAP9YNROBtNUegZQSwRmwXrEPGN4SXQNQfvRlQBo=;
        b=eCWg4Zm7e+ffrAnAkBKtfzjc2keaAKb8PH3UKc34YZEzspbTzJJIuQjKbOd0Cvuni1Jj/d
        VS9GBNQJfhCj7S+HLnuP8lD6hEnsg1BRLKHoKA+nXrIA17XzeHLGnFmD0r03KT1gGIDFoJ
        ETrP8DId5f2FjYs5Vb4Z+0ptiOxfdVv4HYnzWB2Es2/tkNnDWnOrXnzVL1e19Pw/vleUk8
        KHgVGpRy6xdLZSXENQKkxz0hG1IIVtSz9g8RpzQMNomhxPNVlyVfpb9WSfcv8Mhhy96Yhx
        5Ez+dv7r3JOyytnEtEQoP1e6DgIXJpQbvbPdigS0qrAsgVa/n0EBie7zhrZgZg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1659005059;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VW1bAP9YNROBtNUegZQSwRmwXrEPGN4SXQNQfvRlQBo=;
        b=otpeLwIK1uwEiW3VuHW2ejtmexEc/dsrCVIr1StBxFK9nqmEheoAAB0zhzU9hxawEpEJrK
        c1Ag6VCRPJHB3sDA==
From:   "tip-bot2 for Thierry Reding" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] clocksource: Add Tegra186 timers support
Cc:     Thierry Reding <treding@nvidia.com>, Kartik <kkartik@nvidia.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <1656922422-25823-3-git-send-email-kkartik@nvidia.com>
References: <1656922422-25823-3-git-send-email-kkartik@nvidia.com>
MIME-Version: 1.0
Message-ID: <165900505830.15455.5186375781379678570.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     42cee19a9f839f2d60f1cd237d6905d8649127aa
Gitweb:        https://git.kernel.org/tip/42cee19a9f839f2d60f1cd237d6905d8649127aa
Author:        Thierry Reding <treding@nvidia.com>
AuthorDate:    Mon, 04 Jul 2022 13:43:38 +05:30
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Sat, 16 Jul 2022 00:38:50 +02:00

clocksource: Add Tegra186 timers support

Currently this only supports a single watchdog, which uses a timer in
the background for countdown. Eventually the timers could be used for
various time-keeping tasks, but by default the architected timer will
already provide that functionality.

Signed-off-by: Thierry Reding <treding@nvidia.com>
Signed-off-by: Kartik <kkartik@nvidia.com>
Acked-by: Thierry Reding <treding@nvidia.com>
Link: https://lore.kernel.org/r/1656922422-25823-3-git-send-email-kkartik@nvidia.com
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/clocksource/Kconfig          |   8 +-
 drivers/clocksource/Makefile         |   1 +-
 drivers/clocksource/timer-tegra186.c | 508 ++++++++++++++++++++++++++-
 3 files changed, 517 insertions(+)
 create mode 100644 drivers/clocksource/timer-tegra186.c

diff --git a/drivers/clocksource/Kconfig b/drivers/clocksource/Kconfig
index 0367a1c..2dcdf02 100644
--- a/drivers/clocksource/Kconfig
+++ b/drivers/clocksource/Kconfig
@@ -150,6 +150,14 @@ config TEGRA_TIMER
 	help
 	  Enables support for the Tegra driver.
 
+config TEGRA186_TIMER
+	tristate "NVIDIA Tegra186 timer driver"
+	depends on ARCH_TEGRA || COMPILE_TEST
+	depends on WATCHDOG && WATCHDOG_CORE
+	help
+	  Enables support for the timers and watchdogs found on NVIDIA
+	  Tegra186 and later SoCs.
+
 config VT8500_TIMER
 	bool "VT8500 timer driver" if COMPILE_TEST
 	depends on HAS_IOMEM
diff --git a/drivers/clocksource/Makefile b/drivers/clocksource/Makefile
index 9c85ee2..685430d 100644
--- a/drivers/clocksource/Makefile
+++ b/drivers/clocksource/Makefile
@@ -36,6 +36,7 @@ obj-$(CONFIG_SUN4I_TIMER)	+= timer-sun4i.o
 obj-$(CONFIG_SUN5I_HSTIMER)	+= timer-sun5i.o
 obj-$(CONFIG_MESON6_TIMER)	+= timer-meson6.o
 obj-$(CONFIG_TEGRA_TIMER)	+= timer-tegra.o
+obj-$(CONFIG_TEGRA186_TIMER)	+= timer-tegra186.o
 obj-$(CONFIG_VT8500_TIMER)	+= timer-vt8500.o
 obj-$(CONFIG_NSPIRE_TIMER)	+= timer-zevio.o
 obj-$(CONFIG_BCM_KONA_TIMER)	+= bcm_kona_timer.o
diff --git a/drivers/clocksource/timer-tegra186.c b/drivers/clocksource/timer-tegra186.c
new file mode 100644
index 0000000..4515517
--- /dev/null
+++ b/drivers/clocksource/timer-tegra186.c
@@ -0,0 +1,508 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) 2019-2020 NVIDIA Corporation. All rights reserved.
+ */
+
+#include <linux/clocksource.h>
+#include <linux/module.h>
+#include <linux/interrupt.h>
+#include <linux/io.h>
+#include <linux/of.h>
+#include <linux/of_device.h>
+#include <linux/platform_device.h>
+#include <linux/pm.h>
+#include <linux/watchdog.h>
+
+/* shared registers */
+#define TKETSC0 0x000
+#define TKETSC1 0x004
+#define TKEUSEC 0x008
+#define TKEOSC  0x00c
+
+#define TKEIE(x) (0x100 + ((x) * 4))
+#define  TKEIE_WDT_MASK(x, y) ((y) << (16 + 4 * (x)))
+
+/* timer registers */
+#define TMRCR 0x000
+#define  TMRCR_ENABLE BIT(31)
+#define  TMRCR_PERIODIC BIT(30)
+#define  TMRCR_PTV(x) ((x) & 0x0fffffff)
+
+#define TMRSR 0x004
+#define  TMRSR_INTR_CLR BIT(30)
+
+#define TMRCSSR 0x008
+#define  TMRCSSR_SRC_USEC (0 << 0)
+
+/* watchdog registers */
+#define WDTCR 0x000
+#define  WDTCR_SYSTEM_POR_RESET_ENABLE BIT(16)
+#define  WDTCR_SYSTEM_DEBUG_RESET_ENABLE BIT(15)
+#define  WDTCR_REMOTE_INT_ENABLE BIT(14)
+#define  WDTCR_LOCAL_FIQ_ENABLE BIT(13)
+#define  WDTCR_LOCAL_INT_ENABLE BIT(12)
+#define  WDTCR_PERIOD_MASK (0xff << 4)
+#define  WDTCR_PERIOD(x) (((x) & 0xff) << 4)
+#define  WDTCR_TIMER_SOURCE_MASK 0xf
+#define  WDTCR_TIMER_SOURCE(x) ((x) & 0xf)
+
+#define WDTCMDR 0x008
+#define  WDTCMDR_DISABLE_COUNTER BIT(1)
+#define  WDTCMDR_START_COUNTER BIT(0)
+
+#define WDTUR 0x00c
+#define  WDTUR_UNLOCK_PATTERN 0x0000c45a
+
+struct tegra186_timer_soc {
+	unsigned int num_timers;
+	unsigned int num_wdts;
+};
+
+struct tegra186_tmr {
+	struct tegra186_timer *parent;
+	void __iomem *regs;
+	unsigned int index;
+	unsigned int hwirq;
+};
+
+struct tegra186_wdt {
+	struct watchdog_device base;
+
+	void __iomem *regs;
+	unsigned int index;
+	bool locked;
+
+	struct tegra186_tmr *tmr;
+};
+
+static inline struct tegra186_wdt *to_tegra186_wdt(struct watchdog_device *wdd)
+{
+	return container_of(wdd, struct tegra186_wdt, base);
+}
+
+struct tegra186_timer {
+	const struct tegra186_timer_soc *soc;
+	struct device *dev;
+	void __iomem *regs;
+
+	struct tegra186_wdt *wdt;
+	struct clocksource usec;
+	struct clocksource tsc;
+	struct clocksource osc;
+};
+
+static void tmr_writel(struct tegra186_tmr *tmr, u32 value, unsigned int offset)
+{
+	writel_relaxed(value, tmr->regs + offset);
+}
+
+static void wdt_writel(struct tegra186_wdt *wdt, u32 value, unsigned int offset)
+{
+	writel_relaxed(value, wdt->regs + offset);
+}
+
+static u32 wdt_readl(struct tegra186_wdt *wdt, unsigned int offset)
+{
+	return readl_relaxed(wdt->regs + offset);
+}
+
+static struct tegra186_tmr *tegra186_tmr_create(struct tegra186_timer *tegra,
+						unsigned int index)
+{
+	unsigned int offset = 0x10000 + index * 0x10000;
+	struct tegra186_tmr *tmr;
+
+	tmr = devm_kzalloc(tegra->dev, sizeof(*tmr), GFP_KERNEL);
+	if (!tmr)
+		return ERR_PTR(-ENOMEM);
+
+	tmr->parent = tegra;
+	tmr->regs = tegra->regs + offset;
+	tmr->index = index;
+	tmr->hwirq = 0;
+
+	return tmr;
+}
+
+static const struct watchdog_info tegra186_wdt_info = {
+	.options = WDIOF_SETTIMEOUT | WDIOF_MAGICCLOSE | WDIOF_KEEPALIVEPING,
+	.identity = "NVIDIA Tegra186 WDT",
+};
+
+static void tegra186_wdt_disable(struct tegra186_wdt *wdt)
+{
+	/* unlock and disable the watchdog */
+	wdt_writel(wdt, WDTUR_UNLOCK_PATTERN, WDTUR);
+	wdt_writel(wdt, WDTCMDR_DISABLE_COUNTER, WDTCMDR);
+
+	/* disable timer */
+	tmr_writel(wdt->tmr, 0, TMRCR);
+}
+
+static void tegra186_wdt_enable(struct tegra186_wdt *wdt)
+{
+	struct tegra186_timer *tegra = wdt->tmr->parent;
+	u32 value;
+
+	/* unmask hardware IRQ, this may have been lost across powergate */
+	value = TKEIE_WDT_MASK(wdt->index, 1);
+	writel(value, tegra->regs + TKEIE(wdt->tmr->hwirq));
+
+	/* clear interrupt */
+	tmr_writel(wdt->tmr, TMRSR_INTR_CLR, TMRSR);
+
+	/* select microsecond source */
+	tmr_writel(wdt->tmr, TMRCSSR_SRC_USEC, TMRCSSR);
+
+	/* configure timer (system reset happens on the fifth expiration) */
+	value = TMRCR_PTV(wdt->base.timeout * USEC_PER_SEC / 5) |
+		TMRCR_PERIODIC | TMRCR_ENABLE;
+	tmr_writel(wdt->tmr, value, TMRCR);
+
+	if (!wdt->locked) {
+		value = wdt_readl(wdt, WDTCR);
+
+		/* select the proper timer source */
+		value &= ~WDTCR_TIMER_SOURCE_MASK;
+		value |= WDTCR_TIMER_SOURCE(wdt->tmr->index);
+
+		/* single timer period since that's already configured */
+		value &= ~WDTCR_PERIOD_MASK;
+		value |= WDTCR_PERIOD(1);
+
+		/* enable local interrupt for WDT petting */
+		value |= WDTCR_LOCAL_INT_ENABLE;
+
+		/* enable local FIQ and remote interrupt for debug dump */
+		if (0)
+			value |= WDTCR_REMOTE_INT_ENABLE |
+				 WDTCR_LOCAL_FIQ_ENABLE;
+
+		/* enable system debug reset (doesn't properly reboot) */
+		if (0)
+			value |= WDTCR_SYSTEM_DEBUG_RESET_ENABLE;
+
+		/* enable system POR reset */
+		value |= WDTCR_SYSTEM_POR_RESET_ENABLE;
+
+		wdt_writel(wdt, value, WDTCR);
+	}
+
+	wdt_writel(wdt, WDTCMDR_START_COUNTER, WDTCMDR);
+}
+
+static int tegra186_wdt_start(struct watchdog_device *wdd)
+{
+	struct tegra186_wdt *wdt = to_tegra186_wdt(wdd);
+
+	tegra186_wdt_enable(wdt);
+
+	return 0;
+}
+
+static int tegra186_wdt_stop(struct watchdog_device *wdd)
+{
+	struct tegra186_wdt *wdt = to_tegra186_wdt(wdd);
+
+	tegra186_wdt_disable(wdt);
+
+	return 0;
+}
+
+static int tegra186_wdt_ping(struct watchdog_device *wdd)
+{
+	struct tegra186_wdt *wdt = to_tegra186_wdt(wdd);
+
+	tegra186_wdt_disable(wdt);
+	tegra186_wdt_enable(wdt);
+
+	return 0;
+}
+
+static int tegra186_wdt_set_timeout(struct watchdog_device *wdd,
+				    unsigned int timeout)
+{
+	struct tegra186_wdt *wdt = to_tegra186_wdt(wdd);
+
+	if (watchdog_active(&wdt->base))
+		tegra186_wdt_disable(wdt);
+
+	wdt->base.timeout = timeout;
+
+	if (watchdog_active(&wdt->base))
+		tegra186_wdt_enable(wdt);
+
+	return 0;
+}
+
+static const struct watchdog_ops tegra186_wdt_ops = {
+	.owner = THIS_MODULE,
+	.start = tegra186_wdt_start,
+	.stop = tegra186_wdt_stop,
+	.ping = tegra186_wdt_ping,
+	.set_timeout = tegra186_wdt_set_timeout,
+};
+
+static struct tegra186_wdt *tegra186_wdt_create(struct tegra186_timer *tegra,
+						unsigned int index)
+{
+	unsigned int offset = 0x10000, source;
+	struct tegra186_wdt *wdt;
+	u32 value;
+	int err;
+
+	offset += tegra->soc->num_timers * 0x10000 + index * 0x10000;
+
+	wdt = devm_kzalloc(tegra->dev, sizeof(*wdt), GFP_KERNEL);
+	if (!wdt)
+		return ERR_PTR(-ENOMEM);
+
+	wdt->regs = tegra->regs + offset;
+	wdt->index = index;
+
+	/* read the watchdog configuration since it might be locked down */
+	value = wdt_readl(wdt, WDTCR);
+
+	if (value & WDTCR_LOCAL_INT_ENABLE)
+		wdt->locked = true;
+
+	source = value & WDTCR_TIMER_SOURCE_MASK;
+
+	wdt->tmr = tegra186_tmr_create(tegra, source);
+	if (IS_ERR(wdt->tmr))
+		return ERR_CAST(wdt->tmr);
+
+	wdt->base.info = &tegra186_wdt_info;
+	wdt->base.ops = &tegra186_wdt_ops;
+	wdt->base.min_timeout = 1;
+	wdt->base.max_timeout = 255;
+	wdt->base.parent = tegra->dev;
+
+	err = watchdog_init_timeout(&wdt->base, 5, tegra->dev);
+	if (err < 0) {
+		dev_err(tegra->dev, "failed to initialize timeout: %d\n", err);
+		return ERR_PTR(err);
+	}
+
+	err = devm_watchdog_register_device(tegra->dev, &wdt->base);
+	if (err < 0) {
+		dev_err(tegra->dev, "failed to register WDT: %d\n", err);
+		return ERR_PTR(err);
+	}
+
+	return wdt;
+}
+
+static u64 tegra186_timer_tsc_read(struct clocksource *cs)
+{
+	struct tegra186_timer *tegra = container_of(cs, struct tegra186_timer,
+						    tsc);
+	u32 hi, lo, ss;
+
+	hi = readl_relaxed(tegra->regs + TKETSC1);
+
+	/*
+	 * The 56-bit value of the TSC is spread across two registers that are
+	 * not synchronized. In order to read them atomically, ensure that the
+	 * high 24 bits match before and after reading the low 32 bits.
+	 */
+	do {
+		/* snapshot the high 24 bits */
+		ss = hi;
+
+		lo = readl_relaxed(tegra->regs + TKETSC0);
+		hi = readl_relaxed(tegra->regs + TKETSC1);
+	} while (hi != ss);
+
+	return (u64)hi << 32 | lo;
+}
+
+static int tegra186_timer_tsc_init(struct tegra186_timer *tegra)
+{
+	tegra->tsc.name = "tsc";
+	tegra->tsc.rating = 300;
+	tegra->tsc.read = tegra186_timer_tsc_read;
+	tegra->tsc.mask = CLOCKSOURCE_MASK(56);
+	tegra->tsc.flags = CLOCK_SOURCE_IS_CONTINUOUS;
+
+	return clocksource_register_hz(&tegra->tsc, 31250000);
+}
+
+static u64 tegra186_timer_osc_read(struct clocksource *cs)
+{
+	struct tegra186_timer *tegra = container_of(cs, struct tegra186_timer,
+						    osc);
+
+	return readl_relaxed(tegra->regs + TKEOSC);
+}
+
+static int tegra186_timer_osc_init(struct tegra186_timer *tegra)
+{
+	tegra->osc.name = "osc";
+	tegra->osc.rating = 300;
+	tegra->osc.read = tegra186_timer_osc_read;
+	tegra->osc.mask = CLOCKSOURCE_MASK(32);
+	tegra->osc.flags = CLOCK_SOURCE_IS_CONTINUOUS;
+
+	return clocksource_register_hz(&tegra->osc, 38400000);
+}
+
+static u64 tegra186_timer_usec_read(struct clocksource *cs)
+{
+	struct tegra186_timer *tegra = container_of(cs, struct tegra186_timer,
+						    usec);
+
+	return readl_relaxed(tegra->regs + TKEUSEC);
+}
+
+static int tegra186_timer_usec_init(struct tegra186_timer *tegra)
+{
+	tegra->usec.name = "usec";
+	tegra->usec.rating = 300;
+	tegra->usec.read = tegra186_timer_usec_read;
+	tegra->usec.mask = CLOCKSOURCE_MASK(32);
+	tegra->usec.flags = CLOCK_SOURCE_IS_CONTINUOUS;
+
+	return clocksource_register_hz(&tegra->usec, USEC_PER_SEC);
+}
+
+static irqreturn_t tegra186_timer_irq(int irq, void *data)
+{
+	struct tegra186_timer *tegra = data;
+
+	if (watchdog_active(&tegra->wdt->base)) {
+		tegra186_wdt_disable(tegra->wdt);
+		tegra186_wdt_enable(tegra->wdt);
+	}
+
+	return IRQ_HANDLED;
+}
+
+static int tegra186_timer_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct tegra186_timer *tegra;
+	unsigned int irq;
+	int err;
+
+	tegra = devm_kzalloc(dev, sizeof(*tegra), GFP_KERNEL);
+	if (!tegra)
+		return -ENOMEM;
+
+	tegra->soc = of_device_get_match_data(dev);
+	dev_set_drvdata(dev, tegra);
+	tegra->dev = dev;
+
+	tegra->regs = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(tegra->regs))
+		return PTR_ERR(tegra->regs);
+
+	err = platform_get_irq(pdev, 0);
+	if (err < 0)
+		return err;
+
+	irq = err;
+
+	/* create a watchdog using a preconfigured timer */
+	tegra->wdt = tegra186_wdt_create(tegra, 0);
+	if (IS_ERR(tegra->wdt)) {
+		err = PTR_ERR(tegra->wdt);
+		dev_err(dev, "failed to create WDT: %d\n", err);
+		return err;
+	}
+
+	err = tegra186_timer_tsc_init(tegra);
+	if (err < 0) {
+		dev_err(dev, "failed to register TSC counter: %d\n", err);
+		return err;
+	}
+
+	err = tegra186_timer_osc_init(tegra);
+	if (err < 0) {
+		dev_err(dev, "failed to register OSC counter: %d\n", err);
+		goto unregister_tsc;
+	}
+
+	err = tegra186_timer_usec_init(tegra);
+	if (err < 0) {
+		dev_err(dev, "failed to register USEC counter: %d\n", err);
+		goto unregister_osc;
+	}
+
+	err = devm_request_irq(dev, irq, tegra186_timer_irq, 0,
+			       "tegra186-timer", tegra);
+	if (err < 0) {
+		dev_err(dev, "failed to request IRQ#%u: %d\n", irq, err);
+		goto unregister_usec;
+	}
+
+	return 0;
+
+unregister_usec:
+	clocksource_unregister(&tegra->usec);
+unregister_osc:
+	clocksource_unregister(&tegra->osc);
+unregister_tsc:
+	clocksource_unregister(&tegra->tsc);
+	return err;
+}
+
+static int tegra186_timer_remove(struct platform_device *pdev)
+{
+	struct tegra186_timer *tegra = platform_get_drvdata(pdev);
+
+	clocksource_unregister(&tegra->usec);
+	clocksource_unregister(&tegra->osc);
+	clocksource_unregister(&tegra->tsc);
+
+	return 0;
+}
+
+static int __maybe_unused tegra186_timer_suspend(struct device *dev)
+{
+	struct tegra186_timer *tegra = dev_get_drvdata(dev);
+
+	if (watchdog_active(&tegra->wdt->base))
+		tegra186_wdt_disable(tegra->wdt);
+
+	return 0;
+}
+
+static int __maybe_unused tegra186_timer_resume(struct device *dev)
+{
+	struct tegra186_timer *tegra = dev_get_drvdata(dev);
+
+	if (watchdog_active(&tegra->wdt->base))
+		tegra186_wdt_enable(tegra->wdt);
+
+	return 0;
+}
+
+static SIMPLE_DEV_PM_OPS(tegra186_timer_pm_ops, tegra186_timer_suspend,
+			 tegra186_timer_resume);
+
+static const struct tegra186_timer_soc tegra186_timer = {
+	.num_timers = 10,
+	.num_wdts = 3,
+};
+
+static const struct of_device_id tegra186_timer_of_match[] = {
+	{ .compatible = "nvidia,tegra186-timer", .data = &tegra186_timer },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, tegra186_timer_of_match);
+
+static struct platform_driver tegra186_wdt_driver = {
+	.driver = {
+		.name = "tegra186-timer",
+		.pm = &tegra186_timer_pm_ops,
+		.of_match_table = tegra186_timer_of_match,
+	},
+	.probe = tegra186_timer_probe,
+	.remove = tegra186_timer_remove,
+};
+module_platform_driver(tegra186_wdt_driver);
+
+MODULE_AUTHOR("Thierry Reding <treding@nvidia.com>");
+MODULE_DESCRIPTION("NVIDIA Tegra186 timers driver");
+MODULE_LICENSE("GPL v2");
