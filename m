Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 02DA9316342
	for <lists+linux-tip-commits@lfdr.de>; Wed, 10 Feb 2021 11:09:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230216AbhBJKJg (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 10 Feb 2021 05:09:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230429AbhBJKHZ (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 10 Feb 2021 05:07:25 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C635C06178A;
        Wed, 10 Feb 2021 02:06:28 -0800 (PST)
Date:   Wed, 10 Feb 2021 10:06:24 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1612951586;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fQNjTuqP7Gp1RaKaHYv5UT3rNc8TXy5fS+pNJ6pJf/g=;
        b=aIQ1TWr/eWDCTeeL3JdnfG20hXRRT5NSZW44nagNrWQ8E8sE3Zz3BRJy93tqJf1558DpxN
        MOFsI+NOQOYEaloSPmwGEDloeB0Vns8KMgN3jUpKThQkvRZbvi838SMz03MVC7cgeBwC6C
        XX8Odqu7IqopE57K4RQoDnET23d2j0TQa2ZlKjwuGoHhjSPhivsk48C5TFl3gmT8E1s/z2
        6hYSIKaPkiE+AiZQYNHKp4jn1l3+Q9VjnMKGFBG8ypejGQyShlt/10irtiVuMaCmgNrap2
        Y3xhm8EVMNB55b91CW590KfPl6Ymu9sb26bg2alDZJv0KFauDnTAOg+Ues5dwg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1612951586;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fQNjTuqP7Gp1RaKaHYv5UT3rNc8TXy5fS+pNJ6pJf/g=;
        b=gUwI3Spqqlg/u+Sb68vAx+gjNudrdUjUBH5XmSAhkTueIp/BeG4zhbnHqq6tqT6wToPqaT
        ZrwXLqz2s8HBFNBg==
From:   "tip-bot2 for Arnd Bergmann" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] clocksource/drivers/prima: Remove sirf prima driver
Cc:     Barry Song <baohua@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Daniel Lezcano <daniel.lezcano@linaro.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210120131559.1971359-5-arnd@kernel.org>
References: <20210120131559.1971359-5-arnd@kernel.org>
MIME-Version: 1.0
Message-ID: <161295158414.23325.6271843196994503829.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     a8d80235808c8359b614412da76dc10518ea9090
Gitweb:        https://git.kernel.org/tip/a8d80235808c8359b614412da76dc10518ea9090
Author:        Arnd Bergmann <arnd@arndb.de>
AuthorDate:    Wed, 20 Jan 2021 14:15:59 +01:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Wed, 03 Feb 2021 09:13:46 +01:00

clocksource/drivers/prima: Remove sirf prima driver

The CSR SiRF prima2/atlas platforms are getting removed, so this driver
is no longer needed.

Cc: Barry Song <baohua@kernel.org>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Acked-by: Barry Song <baohua@kernel.org>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Link: https://lore.kernel.org/r/20210120131559.1971359-5-arnd@kernel.org
---
 drivers/clocksource/Kconfig        |   6 +-
 drivers/clocksource/Makefile       |   1 +-
 drivers/clocksource/timer-prima2.c | 242 +----------------------------
 3 files changed, 249 deletions(-)
 delete mode 100644 drivers/clocksource/timer-prima2.c

diff --git a/drivers/clocksource/Kconfig b/drivers/clocksource/Kconfig
index 4a17957..05f6d60 100644
--- a/drivers/clocksource/Kconfig
+++ b/drivers/clocksource/Kconfig
@@ -204,12 +204,6 @@ config MXS_TIMER
 	help
 	  Enables support for the MXS timer.
 
-config PRIMA2_TIMER
-	bool "Prima2 timer driver" if COMPILE_TEST
-	select CLKSRC_MMIO
-	help
-	  Enables support for the Prima2 timer.
-
 config NSPIRE_TIMER
 	bool "NSpire timer driver" if COMPILE_TEST
 	select CLKSRC_MMIO
diff --git a/drivers/clocksource/Makefile b/drivers/clocksource/Makefile
index 8c4ab8c..c17ee32 100644
--- a/drivers/clocksource/Makefile
+++ b/drivers/clocksource/Makefile
@@ -32,7 +32,6 @@ obj-$(CONFIG_BCM2835_TIMER)	+= bcm2835_timer.o
 obj-$(CONFIG_CLPS711X_TIMER)	+= clps711x-timer.o
 obj-$(CONFIG_MXS_TIMER)		+= mxs_timer.o
 obj-$(CONFIG_CLKSRC_PXA)	+= timer-pxa.o
-obj-$(CONFIG_PRIMA2_TIMER)	+= timer-prima2.o
 obj-$(CONFIG_SUN4I_TIMER)	+= timer-sun4i.o
 obj-$(CONFIG_SUN5I_HSTIMER)	+= timer-sun5i.o
 obj-$(CONFIG_MESON6_TIMER)	+= timer-meson6.o
diff --git a/drivers/clocksource/timer-prima2.c b/drivers/clocksource/timer-prima2.c
deleted file mode 100644
index c5d4693..0000000
--- a/drivers/clocksource/timer-prima2.c
+++ /dev/null
@@ -1,242 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-or-later
-/*
- * System timer for CSR SiRFprimaII
- *
- * Copyright (c) 2011 Cambridge Silicon Radio Limited, a CSR plc group company.
- */
-
-#include <linux/kernel.h>
-#include <linux/interrupt.h>
-#include <linux/clockchips.h>
-#include <linux/clocksource.h>
-#include <linux/bitops.h>
-#include <linux/irq.h>
-#include <linux/clk.h>
-#include <linux/err.h>
-#include <linux/slab.h>
-#include <linux/of.h>
-#include <linux/of_irq.h>
-#include <linux/of_address.h>
-#include <linux/sched_clock.h>
-
-#define PRIMA2_CLOCK_FREQ 1000000
-
-#define SIRFSOC_TIMER_COUNTER_LO	0x0000
-#define SIRFSOC_TIMER_COUNTER_HI	0x0004
-#define SIRFSOC_TIMER_MATCH_0		0x0008
-#define SIRFSOC_TIMER_MATCH_1		0x000C
-#define SIRFSOC_TIMER_MATCH_2		0x0010
-#define SIRFSOC_TIMER_MATCH_3		0x0014
-#define SIRFSOC_TIMER_MATCH_4		0x0018
-#define SIRFSOC_TIMER_MATCH_5		0x001C
-#define SIRFSOC_TIMER_STATUS		0x0020
-#define SIRFSOC_TIMER_INT_EN		0x0024
-#define SIRFSOC_TIMER_WATCHDOG_EN	0x0028
-#define SIRFSOC_TIMER_DIV		0x002C
-#define SIRFSOC_TIMER_LATCH		0x0030
-#define SIRFSOC_TIMER_LATCHED_LO	0x0034
-#define SIRFSOC_TIMER_LATCHED_HI	0x0038
-
-#define SIRFSOC_TIMER_WDT_INDEX		5
-
-#define SIRFSOC_TIMER_LATCH_BIT	 BIT(0)
-
-#define SIRFSOC_TIMER_REG_CNT 11
-
-static const u32 sirfsoc_timer_reg_list[SIRFSOC_TIMER_REG_CNT] = {
-	SIRFSOC_TIMER_MATCH_0, SIRFSOC_TIMER_MATCH_1, SIRFSOC_TIMER_MATCH_2,
-	SIRFSOC_TIMER_MATCH_3, SIRFSOC_TIMER_MATCH_4, SIRFSOC_TIMER_MATCH_5,
-	SIRFSOC_TIMER_INT_EN, SIRFSOC_TIMER_WATCHDOG_EN, SIRFSOC_TIMER_DIV,
-	SIRFSOC_TIMER_LATCHED_LO, SIRFSOC_TIMER_LATCHED_HI,
-};
-
-static u32 sirfsoc_timer_reg_val[SIRFSOC_TIMER_REG_CNT];
-
-static void __iomem *sirfsoc_timer_base;
-
-/* timer0 interrupt handler */
-static irqreturn_t sirfsoc_timer_interrupt(int irq, void *dev_id)
-{
-	struct clock_event_device *ce = dev_id;
-
-	WARN_ON(!(readl_relaxed(sirfsoc_timer_base + SIRFSOC_TIMER_STATUS) &
-		BIT(0)));
-
-	/* clear timer0 interrupt */
-	writel_relaxed(BIT(0), sirfsoc_timer_base + SIRFSOC_TIMER_STATUS);
-
-	ce->event_handler(ce);
-
-	return IRQ_HANDLED;
-}
-
-/* read 64-bit timer counter */
-static u64 notrace sirfsoc_timer_read(struct clocksource *cs)
-{
-	u64 cycles;
-
-	/* latch the 64-bit timer counter */
-	writel_relaxed(SIRFSOC_TIMER_LATCH_BIT,
-		sirfsoc_timer_base + SIRFSOC_TIMER_LATCH);
-	cycles = readl_relaxed(sirfsoc_timer_base + SIRFSOC_TIMER_LATCHED_HI);
-	cycles = (cycles << 32) |
-		readl_relaxed(sirfsoc_timer_base + SIRFSOC_TIMER_LATCHED_LO);
-
-	return cycles;
-}
-
-static int sirfsoc_timer_set_next_event(unsigned long delta,
-	struct clock_event_device *ce)
-{
-	unsigned long now, next;
-
-	writel_relaxed(SIRFSOC_TIMER_LATCH_BIT,
-		sirfsoc_timer_base + SIRFSOC_TIMER_LATCH);
-	now = readl_relaxed(sirfsoc_timer_base + SIRFSOC_TIMER_LATCHED_LO);
-	next = now + delta;
-	writel_relaxed(next, sirfsoc_timer_base + SIRFSOC_TIMER_MATCH_0);
-	writel_relaxed(SIRFSOC_TIMER_LATCH_BIT,
-		sirfsoc_timer_base + SIRFSOC_TIMER_LATCH);
-	now = readl_relaxed(sirfsoc_timer_base + SIRFSOC_TIMER_LATCHED_LO);
-
-	return next - now > delta ? -ETIME : 0;
-}
-
-static int sirfsoc_timer_shutdown(struct clock_event_device *evt)
-{
-	u32 val = readl_relaxed(sirfsoc_timer_base + SIRFSOC_TIMER_INT_EN);
-
-	writel_relaxed(val & ~BIT(0),
-		       sirfsoc_timer_base + SIRFSOC_TIMER_INT_EN);
-	return 0;
-}
-
-static int sirfsoc_timer_set_oneshot(struct clock_event_device *evt)
-{
-	u32 val = readl_relaxed(sirfsoc_timer_base + SIRFSOC_TIMER_INT_EN);
-
-	writel_relaxed(val | BIT(0), sirfsoc_timer_base + SIRFSOC_TIMER_INT_EN);
-	return 0;
-}
-
-static void sirfsoc_clocksource_suspend(struct clocksource *cs)
-{
-	int i;
-
-	writel_relaxed(SIRFSOC_TIMER_LATCH_BIT,
-		sirfsoc_timer_base + SIRFSOC_TIMER_LATCH);
-
-	for (i = 0; i < SIRFSOC_TIMER_REG_CNT; i++)
-		sirfsoc_timer_reg_val[i] =
-			readl_relaxed(sirfsoc_timer_base +
-				sirfsoc_timer_reg_list[i]);
-}
-
-static void sirfsoc_clocksource_resume(struct clocksource *cs)
-{
-	int i;
-
-	for (i = 0; i < SIRFSOC_TIMER_REG_CNT - 2; i++)
-		writel_relaxed(sirfsoc_timer_reg_val[i],
-			sirfsoc_timer_base + sirfsoc_timer_reg_list[i]);
-
-	writel_relaxed(sirfsoc_timer_reg_val[SIRFSOC_TIMER_REG_CNT - 2],
-		sirfsoc_timer_base + SIRFSOC_TIMER_COUNTER_LO);
-	writel_relaxed(sirfsoc_timer_reg_val[SIRFSOC_TIMER_REG_CNT - 1],
-		sirfsoc_timer_base + SIRFSOC_TIMER_COUNTER_HI);
-}
-
-static struct clock_event_device sirfsoc_clockevent = {
-	.name = "sirfsoc_clockevent",
-	.rating = 200,
-	.features = CLOCK_EVT_FEAT_ONESHOT,
-	.set_state_shutdown = sirfsoc_timer_shutdown,
-	.set_state_oneshot = sirfsoc_timer_set_oneshot,
-	.set_next_event = sirfsoc_timer_set_next_event,
-};
-
-static struct clocksource sirfsoc_clocksource = {
-	.name = "sirfsoc_clocksource",
-	.rating = 200,
-	.mask = CLOCKSOURCE_MASK(64),
-	.flags = CLOCK_SOURCE_IS_CONTINUOUS,
-	.read = sirfsoc_timer_read,
-	.suspend = sirfsoc_clocksource_suspend,
-	.resume = sirfsoc_clocksource_resume,
-};
-
-/* Overwrite weak default sched_clock with more precise one */
-static u64 notrace sirfsoc_read_sched_clock(void)
-{
-	return sirfsoc_timer_read(NULL);
-}
-
-static void __init sirfsoc_clockevent_init(void)
-{
-	sirfsoc_clockevent.cpumask = cpumask_of(0);
-	clockevents_config_and_register(&sirfsoc_clockevent, PRIMA2_CLOCK_FREQ,
-					2, -2);
-}
-
-/* initialize the kernel jiffy timer source */
-static int __init sirfsoc_prima2_timer_init(struct device_node *np)
-{
-	unsigned long rate;
-	unsigned int irq;
-	struct clk *clk;
-	int ret;
-
-	clk = of_clk_get(np, 0);
-	if (IS_ERR(clk)) {
-		pr_err("Failed to get clock\n");
-		return PTR_ERR(clk);
-	}
-
-	ret = clk_prepare_enable(clk);
-	if (ret) {
-		pr_err("Failed to enable clock\n");
-		return ret;
-	}
-
-	rate = clk_get_rate(clk);
-
-	if (rate < PRIMA2_CLOCK_FREQ || rate % PRIMA2_CLOCK_FREQ) {
-		pr_err("Invalid clock rate\n");
-		return -EINVAL;
-	}
-
-	sirfsoc_timer_base = of_iomap(np, 0);
-	if (!sirfsoc_timer_base) {
-		pr_err("unable to map timer cpu registers\n");
-		return -ENXIO;
-	}
-
-	irq = irq_of_parse_and_map(np, 0);
-
-	writel_relaxed(rate / PRIMA2_CLOCK_FREQ / 2 - 1,
-		sirfsoc_timer_base + SIRFSOC_TIMER_DIV);
-	writel_relaxed(0, sirfsoc_timer_base + SIRFSOC_TIMER_COUNTER_LO);
-	writel_relaxed(0, sirfsoc_timer_base + SIRFSOC_TIMER_COUNTER_HI);
-	writel_relaxed(BIT(0), sirfsoc_timer_base + SIRFSOC_TIMER_STATUS);
-
-	ret = clocksource_register_hz(&sirfsoc_clocksource, PRIMA2_CLOCK_FREQ);
-	if (ret) {
-		pr_err("Failed to register clocksource\n");
-		return ret;
-	}
-
-	sched_clock_register(sirfsoc_read_sched_clock, 64, PRIMA2_CLOCK_FREQ);
-
-	ret = request_irq(irq, sirfsoc_timer_interrupt, IRQF_TIMER,
-			  "sirfsoc_timer0", &sirfsoc_clockevent);
-	if (ret) {
-		pr_err("Failed to setup irq\n");
-		return ret;
-	}
-
-	sirfsoc_clockevent_init();
-
-	return 0;
-}
-TIMER_OF_DECLARE(sirfsoc_prima2_timer,
-	"sirf,prima2-tick", sirfsoc_prima2_timer_init);
