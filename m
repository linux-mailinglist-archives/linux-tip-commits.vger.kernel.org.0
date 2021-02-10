Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 72685316343
	for <lists+linux-tip-commits@lfdr.de>; Wed, 10 Feb 2021 11:09:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230244AbhBJKJh (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 10 Feb 2021 05:09:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230425AbhBJKHZ (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 10 Feb 2021 05:07:25 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BBE2C061788;
        Wed, 10 Feb 2021 02:06:28 -0800 (PST)
Date:   Wed, 10 Feb 2021 10:06:24 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1612951586;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gfiSm7VAUcAl2YWQRsfr28SEQiQTr2dhLr8I77pscb0=;
        b=a7FmIJi6FHcnap1Q7Q+UAeqNw4ReM0hCHrfQsptvw9fr7OTdS8GqOlpE0jb9c3eq4xTLcx
        ebNBI6tzqasXECi0eOrbuKqsYyE+HJjmcFlhQ75n3mfGJX1aL6AKWD9KNOD8qt1CSIPJ1p
        OOlOMb3yVXHX4R3HHFVC40h8Asc49Lir3WmZ9OIicw8BY+FxtnGAqgGouKqd6GuGC6WRmY
        lbFWBYe1XFPeIg2niY6h22IzRmBYNHNsOJYnyCI3u4mOFsbp8y6qyFRv0+qDIORLaW7Rqw
        EHu1uxiNnQM4GV9ijMIZzLkLts5tk7IDzkkeprPTdi74aVYcPLCdGhDwbNH1ng==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1612951586;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gfiSm7VAUcAl2YWQRsfr28SEQiQTr2dhLr8I77pscb0=;
        b=GNAjTjdzk/VV3w/VMuDWYuZWKOM0wniZR9bR9hIwnXBsLoVRMQOZNb3dfrNcb71l0NC4wQ
        5sPep9p5OhIdGpAw==
From:   "tip-bot2 for Arnd Bergmann" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] clocksource/drivers/atlas: Remove sirf atlas driver
Cc:     Barry Song <baohua@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Daniel Lezcano <daniel.lezcano@linaro.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210120131559.1971359-4-arnd@kernel.org>
References: <20210120131559.1971359-4-arnd@kernel.org>
MIME-Version: 1.0
Message-ID: <161295158435.23325.18086315929676634913.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     446262b27285e86bfc078d5602d7e047a351d536
Gitweb:        https://git.kernel.org/tip/446262b27285e86bfc078d5602d7e047a351d536
Author:        Arnd Bergmann <arnd@arndb.de>
AuthorDate:    Wed, 20 Jan 2021 14:15:58 +01:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Wed, 03 Feb 2021 09:12:28 +01:00

clocksource/drivers/atlas: Remove sirf atlas driver

The CSR SiRF prima2/atlas platforms are getting removed, so this driver
is no longer needed.

Cc: Barry Song <baohua@kernel.org>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Acked-by: Barry Song <baohua@kernel.org>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Link: https://lore.kernel.org/r/20210120131559.1971359-4-arnd@kernel.org
---
 drivers/clocksource/Kconfig        |   6 +-
 drivers/clocksource/Makefile       |   1 +-
 drivers/clocksource/timer-atlas7.c | 281 +----------------------------
 3 files changed, 288 deletions(-)
 delete mode 100644 drivers/clocksource/timer-atlas7.c

diff --git a/drivers/clocksource/Kconfig b/drivers/clocksource/Kconfig
index b5250e4..4a17957 100644
--- a/drivers/clocksource/Kconfig
+++ b/drivers/clocksource/Kconfig
@@ -197,12 +197,6 @@ config CLPS711X_TIMER
 	help
 	  Enables support for the Cirrus Logic PS711 timer.
 
-config ATLAS7_TIMER
-	bool "Atlas7 timer driver" if COMPILE_TEST
-	select CLKSRC_MMIO
-	help
-	  Enables support for the Atlas7 timer.
-
 config MXS_TIMER
 	bool "MXS timer driver" if COMPILE_TEST
 	select CLKSRC_MMIO
diff --git a/drivers/clocksource/Makefile b/drivers/clocksource/Makefile
index 1b05f03..8c4ab8c 100644
--- a/drivers/clocksource/Makefile
+++ b/drivers/clocksource/Makefile
@@ -30,7 +30,6 @@ obj-$(CONFIG_ARMADA_370_XP_TIMER)	+= timer-armada-370-xp.o
 obj-$(CONFIG_ORION_TIMER)	+= timer-orion.o
 obj-$(CONFIG_BCM2835_TIMER)	+= bcm2835_timer.o
 obj-$(CONFIG_CLPS711X_TIMER)	+= clps711x-timer.o
-obj-$(CONFIG_ATLAS7_TIMER)	+= timer-atlas7.o
 obj-$(CONFIG_MXS_TIMER)		+= mxs_timer.o
 obj-$(CONFIG_CLKSRC_PXA)	+= timer-pxa.o
 obj-$(CONFIG_PRIMA2_TIMER)	+= timer-prima2.o
diff --git a/drivers/clocksource/timer-atlas7.c b/drivers/clocksource/timer-atlas7.c
deleted file mode 100644
index c21c91c..0000000
--- a/drivers/clocksource/timer-atlas7.c
+++ /dev/null
@@ -1,281 +0,0 @@
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
-#include <linux/cpu.h>
-#include <linux/bitops.h>
-#include <linux/irq.h>
-#include <linux/clk.h>
-#include <linux/slab.h>
-#include <linux/of.h>
-#include <linux/of_irq.h>
-#include <linux/of_address.h>
-#include <linux/sched_clock.h>
-
-#define SIRFSOC_TIMER_32COUNTER_0_CTRL			0x0000
-#define SIRFSOC_TIMER_32COUNTER_1_CTRL			0x0004
-#define SIRFSOC_TIMER_MATCH_0				0x0018
-#define SIRFSOC_TIMER_MATCH_1				0x001c
-#define SIRFSOC_TIMER_COUNTER_0				0x0048
-#define SIRFSOC_TIMER_COUNTER_1				0x004c
-#define SIRFSOC_TIMER_INTR_STATUS			0x0060
-#define SIRFSOC_TIMER_WATCHDOG_EN			0x0064
-#define SIRFSOC_TIMER_64COUNTER_CTRL			0x0068
-#define SIRFSOC_TIMER_64COUNTER_LO			0x006c
-#define SIRFSOC_TIMER_64COUNTER_HI			0x0070
-#define SIRFSOC_TIMER_64COUNTER_LOAD_LO			0x0074
-#define SIRFSOC_TIMER_64COUNTER_LOAD_HI			0x0078
-#define SIRFSOC_TIMER_64COUNTER_RLATCHED_LO		0x007c
-#define SIRFSOC_TIMER_64COUNTER_RLATCHED_HI		0x0080
-
-#define SIRFSOC_TIMER_REG_CNT 6
-
-static unsigned long atlas7_timer_rate;
-
-static const u32 sirfsoc_timer_reg_list[SIRFSOC_TIMER_REG_CNT] = {
-	SIRFSOC_TIMER_WATCHDOG_EN,
-	SIRFSOC_TIMER_32COUNTER_0_CTRL,
-	SIRFSOC_TIMER_32COUNTER_1_CTRL,
-	SIRFSOC_TIMER_64COUNTER_CTRL,
-	SIRFSOC_TIMER_64COUNTER_RLATCHED_LO,
-	SIRFSOC_TIMER_64COUNTER_RLATCHED_HI,
-};
-
-static u32 sirfsoc_timer_reg_val[SIRFSOC_TIMER_REG_CNT];
-
-static void __iomem *sirfsoc_timer_base;
-
-/* disable count and interrupt */
-static inline void sirfsoc_timer_count_disable(int idx)
-{
-	writel_relaxed(readl_relaxed(sirfsoc_timer_base + SIRFSOC_TIMER_32COUNTER_0_CTRL + 4 * idx) & ~0x7,
-		sirfsoc_timer_base + SIRFSOC_TIMER_32COUNTER_0_CTRL + 4 * idx);
-}
-
-/* enable count and interrupt */
-static inline void sirfsoc_timer_count_enable(int idx)
-{
-	writel_relaxed(readl_relaxed(sirfsoc_timer_base + SIRFSOC_TIMER_32COUNTER_0_CTRL + 4 * idx) | 0x3,
-		sirfsoc_timer_base + SIRFSOC_TIMER_32COUNTER_0_CTRL + 4 * idx);
-}
-
-/* timer interrupt handler */
-static irqreturn_t sirfsoc_timer_interrupt(int irq, void *dev_id)
-{
-	struct clock_event_device *ce = dev_id;
-	int cpu = smp_processor_id();
-
-	/* clear timer interrupt */
-	writel_relaxed(BIT(cpu), sirfsoc_timer_base + SIRFSOC_TIMER_INTR_STATUS);
-
-	if (clockevent_state_oneshot(ce))
-		sirfsoc_timer_count_disable(cpu);
-
-	ce->event_handler(ce);
-
-	return IRQ_HANDLED;
-}
-
-/* read 64-bit timer counter */
-static u64 sirfsoc_timer_read(struct clocksource *cs)
-{
-	u64 cycles;
-
-	writel_relaxed((readl_relaxed(sirfsoc_timer_base + SIRFSOC_TIMER_64COUNTER_CTRL) |
-			BIT(0)) & ~BIT(1), sirfsoc_timer_base + SIRFSOC_TIMER_64COUNTER_CTRL);
-
-	cycles = readl_relaxed(sirfsoc_timer_base + SIRFSOC_TIMER_64COUNTER_RLATCHED_HI);
-	cycles = (cycles << 32) | readl_relaxed(sirfsoc_timer_base + SIRFSOC_TIMER_64COUNTER_RLATCHED_LO);
-
-	return cycles;
-}
-
-static int sirfsoc_timer_set_next_event(unsigned long delta,
-	struct clock_event_device *ce)
-{
-	int cpu = smp_processor_id();
-
-	/* disable timer first, then modify the related registers */
-	sirfsoc_timer_count_disable(cpu);
-
-	writel_relaxed(0, sirfsoc_timer_base + SIRFSOC_TIMER_COUNTER_0 +
-		4 * cpu);
-	writel_relaxed(delta, sirfsoc_timer_base + SIRFSOC_TIMER_MATCH_0 +
-		4 * cpu);
-
-	/* enable the tick */
-	sirfsoc_timer_count_enable(cpu);
-
-	return 0;
-}
-
-/* Oneshot is enabled in set_next_event */
-static int sirfsoc_timer_shutdown(struct clock_event_device *evt)
-{
-	sirfsoc_timer_count_disable(smp_processor_id());
-	return 0;
-}
-
-static void sirfsoc_clocksource_suspend(struct clocksource *cs)
-{
-	int i;
-
-	for (i = 0; i < SIRFSOC_TIMER_REG_CNT; i++)
-		sirfsoc_timer_reg_val[i] = readl_relaxed(sirfsoc_timer_base + sirfsoc_timer_reg_list[i]);
-}
-
-static void sirfsoc_clocksource_resume(struct clocksource *cs)
-{
-	int i;
-
-	for (i = 0; i < SIRFSOC_TIMER_REG_CNT - 2; i++)
-		writel_relaxed(sirfsoc_timer_reg_val[i], sirfsoc_timer_base + sirfsoc_timer_reg_list[i]);
-
-	writel_relaxed(sirfsoc_timer_reg_val[SIRFSOC_TIMER_REG_CNT - 2],
-		sirfsoc_timer_base + SIRFSOC_TIMER_64COUNTER_LOAD_LO);
-	writel_relaxed(sirfsoc_timer_reg_val[SIRFSOC_TIMER_REG_CNT - 1],
-		sirfsoc_timer_base + SIRFSOC_TIMER_64COUNTER_LOAD_HI);
-
-	writel_relaxed(readl_relaxed(sirfsoc_timer_base + SIRFSOC_TIMER_64COUNTER_CTRL) |
-		BIT(1) | BIT(0), sirfsoc_timer_base + SIRFSOC_TIMER_64COUNTER_CTRL);
-}
-
-static struct clock_event_device __percpu *sirfsoc_clockevent;
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
-static unsigned int sirfsoc_timer_irq, sirfsoc_timer1_irq;
-
-static int sirfsoc_local_timer_starting_cpu(unsigned int cpu)
-{
-	struct clock_event_device *ce = per_cpu_ptr(sirfsoc_clockevent, cpu);
-	unsigned int irq;
-	const char *name;
-
-	if (cpu == 0) {
-		irq = sirfsoc_timer_irq;
-		name = "sirfsoc_timer0";
-	} else {
-		irq = sirfsoc_timer1_irq;
-		name = "sirfsoc_timer1";
-	}
-
-	ce->irq = irq;
-	ce->name = "local_timer";
-	ce->features = CLOCK_EVT_FEAT_ONESHOT;
-	ce->rating = 200;
-	ce->set_state_shutdown = sirfsoc_timer_shutdown;
-	ce->set_state_oneshot = sirfsoc_timer_shutdown;
-	ce->tick_resume = sirfsoc_timer_shutdown;
-	ce->set_next_event = sirfsoc_timer_set_next_event;
-	clockevents_calc_mult_shift(ce, atlas7_timer_rate, 60);
-	ce->max_delta_ns = clockevent_delta2ns(-2, ce);
-	ce->max_delta_ticks = (unsigned long)-2;
-	ce->min_delta_ns = clockevent_delta2ns(2, ce);
-	ce->min_delta_ticks = 2;
-	ce->cpumask = cpumask_of(cpu);
-
-	BUG_ON(request_irq(ce->irq, sirfsoc_timer_interrupt,
-			   IRQF_TIMER | IRQF_NOBALANCING, name, ce));
-	irq_force_affinity(ce->irq, cpumask_of(cpu));
-
-	clockevents_register_device(ce);
-	return 0;
-}
-
-static int sirfsoc_local_timer_dying_cpu(unsigned int cpu)
-{
-	struct clock_event_device *ce = per_cpu_ptr(sirfsoc_clockevent, cpu);
-
-	sirfsoc_timer_count_disable(1);
-
-	if (cpu == 0)
-		free_irq(sirfsoc_timer_irq, ce);
-	else
-		free_irq(sirfsoc_timer1_irq, ce);
-	return 0;
-}
-
-static int __init sirfsoc_clockevent_init(void)
-{
-	sirfsoc_clockevent = alloc_percpu(struct clock_event_device);
-	BUG_ON(!sirfsoc_clockevent);
-
-	/* Install and invoke hotplug callbacks */
-	return cpuhp_setup_state(CPUHP_AP_MARCO_TIMER_STARTING,
-				 "clockevents/marco:starting",
-				 sirfsoc_local_timer_starting_cpu,
-				 sirfsoc_local_timer_dying_cpu);
-}
-
-/* initialize the kernel jiffy timer source */
-static int __init sirfsoc_atlas7_timer_init(struct device_node *np)
-{
-	struct clk *clk;
-
-	clk = of_clk_get(np, 0);
-	BUG_ON(IS_ERR(clk));
-
-	BUG_ON(clk_prepare_enable(clk));
-
-	atlas7_timer_rate = clk_get_rate(clk);
-
-	/* timer dividers: 0, not divided */
-	writel_relaxed(0, sirfsoc_timer_base + SIRFSOC_TIMER_64COUNTER_CTRL);
-	writel_relaxed(0, sirfsoc_timer_base + SIRFSOC_TIMER_32COUNTER_0_CTRL);
-	writel_relaxed(0, sirfsoc_timer_base + SIRFSOC_TIMER_32COUNTER_1_CTRL);
-
-	/* Initialize timer counters to 0 */
-	writel_relaxed(0, sirfsoc_timer_base + SIRFSOC_TIMER_64COUNTER_LOAD_LO);
-	writel_relaxed(0, sirfsoc_timer_base + SIRFSOC_TIMER_64COUNTER_LOAD_HI);
-	writel_relaxed(readl_relaxed(sirfsoc_timer_base + SIRFSOC_TIMER_64COUNTER_CTRL) |
-		BIT(1) | BIT(0), sirfsoc_timer_base + SIRFSOC_TIMER_64COUNTER_CTRL);
-	writel_relaxed(0, sirfsoc_timer_base + SIRFSOC_TIMER_COUNTER_0);
-	writel_relaxed(0, sirfsoc_timer_base + SIRFSOC_TIMER_COUNTER_1);
-
-	/* Clear all interrupts */
-	writel_relaxed(0xFFFF, sirfsoc_timer_base + SIRFSOC_TIMER_INTR_STATUS);
-
-	BUG_ON(clocksource_register_hz(&sirfsoc_clocksource, atlas7_timer_rate));
-
-	return sirfsoc_clockevent_init();
-}
-
-static int __init sirfsoc_of_timer_init(struct device_node *np)
-{
-	sirfsoc_timer_base = of_iomap(np, 0);
-	if (!sirfsoc_timer_base) {
-		pr_err("unable to map timer cpu registers\n");
-		return -ENXIO;
-	}
-
-	sirfsoc_timer_irq = irq_of_parse_and_map(np, 0);
-	if (!sirfsoc_timer_irq) {
-		pr_err("No irq passed for timer0 via DT\n");
-		return -EINVAL;
-	}
-
-	sirfsoc_timer1_irq = irq_of_parse_and_map(np, 1);
-	if (!sirfsoc_timer1_irq) {
-		pr_err("No irq passed for timer1 via DT\n");
-		return -EINVAL;
-	}
-
-	return sirfsoc_atlas7_timer_init(np);
-}
-TIMER_OF_DECLARE(sirfsoc_atlas7_timer, "sirf,atlas7-tick", sirfsoc_of_timer_init);
