Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4CE5431633D
	for <lists+linux-tip-commits@lfdr.de>; Wed, 10 Feb 2021 11:09:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229710AbhBJKJ0 (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 10 Feb 2021 05:09:26 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:58054 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230196AbhBJKHM (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 10 Feb 2021 05:07:12 -0500
Date:   Wed, 10 Feb 2021 10:06:24 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1612951587;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ARIT57xTExBwWYlVJaOkvlQs4Z42mV7zdxZi2rRxP/4=;
        b=CLduUEVvhkChhnjqZEGKV/Hhr2W+SNhdlWrpIkVFMXICEzQtSVD2SAHUOCRW/N5q0UWtdV
        GcSPXmPWi4okiw9xxV77cALVdO0SEvlcYcaXso230TROGudbIDcv3IMwlWCjRbyU8a+zin
        J2ALgFtjiL1RZ1CVVZv1uWr9OtBkv1BJMNlcYeN4UfKnkdj3MyscIiZFp0vQYsrKiPQFL1
        0KF6zfUEc5lcQr/Rs9LAB49wuV2I5UGo9UX6ODreuXcrNeADOQ+3ecQ3fYjN7oZ9o1lpEa
        nWBwimHuony7NOxQbWRcBXYjCuFs07JOsQJ+DV8/Z8JqqWRISR4CbqiK6rtAew==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1612951587;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ARIT57xTExBwWYlVJaOkvlQs4Z42mV7zdxZi2rRxP/4=;
        b=7NMtroZyhUX3uyCzqVj0cxA5S/xokkXgA2zjsynxxII3aOK9WvMXY6rVDxfzMo6jZMkbTB
        4eFkOewCJiS9+SCQ==
From:   "tip-bot2 for Arnd Bergmann" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] clocksource/drivers/u300: Remove the u300 driver
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Daniel Lezcano <daniel.lezcano@linaro.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210120131559.1971359-2-arnd@kernel.org>
References: <20210120131559.1971359-2-arnd@kernel.org>
MIME-Version: 1.0
Message-ID: <161295158480.23325.2283892599004004945.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     33105406764f7f13c5e7279826f77342c82c41b5
Gitweb:        https://git.kernel.org/tip/33105406764f7f13c5e7279826f77342c82c41b5
Author:        Arnd Bergmann <arnd@arndb.de>
AuthorDate:    Wed, 20 Jan 2021 14:15:56 +01:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Wed, 03 Feb 2021 09:10:24 +01:00

clocksource/drivers/u300: Remove the u300 driver

The ST-Ericsson U300 platform is getting removed, so this driver is no
longer needed.

Cc: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Link: https://lore.kernel.org/r/20210120131559.1971359-2-arnd@kernel.org
---
 Documentation/devicetree/bindings/timer/stericsson-u300-apptimer.txt |  18 +---
 drivers/clocksource/Kconfig                                          |   7 +-
 drivers/clocksource/Makefile                                         |   1 +-
 drivers/clocksource/timer-u300.c                                     | 457 +----------------------------------------------------------------------
 4 files changed, 483 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/timer/stericsson-u300-apptimer.txt
 delete mode 100644 drivers/clocksource/timer-u300.c

diff --git a/Documentation/devicetree/bindings/timer/stericsson-u300-apptimer.txt b/Documentation/devicetree/bindings/timer/stericsson-u300-apptimer.txt
deleted file mode 100644
index 9499bc8..0000000
--- a/Documentation/devicetree/bindings/timer/stericsson-u300-apptimer.txt
+++ /dev/null
@@ -1,18 +0,0 @@
-ST-Ericsson U300 apptimer
-
-Required properties:
-
-- compatible : should be "stericsson,u300-apptimer"
-- reg : Specifies base physical address and size of the registers.
-- interrupts : A list of 4 interrupts; one for each subtimer. These
-  are, in order: OS (operating system), DD (device driver) both
-  adopted for EPOC/Symbian with two specific IRQs for these tasks,
-  then GP1 and GP2, which are general-purpose timers.
-
-Example:
-
-timer {
-	compatible = "stericsson,u300-apptimer";
-	reg = <0xc0014000 0x1000>;
-	interrupts = <24 25 26 27>;
-};
diff --git a/drivers/clocksource/Kconfig b/drivers/clocksource/Kconfig
index 6bf89e2..b26bb9e 100644
--- a/drivers/clocksource/Kconfig
+++ b/drivers/clocksource/Kconfig
@@ -216,13 +216,6 @@ config PRIMA2_TIMER
 	help
 	  Enables support for the Prima2 timer.
 
-config U300_TIMER
-	bool "U300 timer driver" if COMPILE_TEST
-	depends on ARM
-	select CLKSRC_MMIO
-	help
-	  Enables support for the U300 timer.
-
 config NSPIRE_TIMER
 	bool "NSpire timer driver" if COMPILE_TEST
 	select CLKSRC_MMIO
diff --git a/drivers/clocksource/Makefile b/drivers/clocksource/Makefile
index 0817338..ce8a3c0 100644
--- a/drivers/clocksource/Makefile
+++ b/drivers/clocksource/Makefile
@@ -34,7 +34,6 @@ obj-$(CONFIG_ATLAS7_TIMER)	+= timer-atlas7.o
 obj-$(CONFIG_MXS_TIMER)		+= mxs_timer.o
 obj-$(CONFIG_CLKSRC_PXA)	+= timer-pxa.o
 obj-$(CONFIG_PRIMA2_TIMER)	+= timer-prima2.o
-obj-$(CONFIG_U300_TIMER)	+= timer-u300.o
 obj-$(CONFIG_SUN4I_TIMER)	+= timer-sun4i.o
 obj-$(CONFIG_SUN5I_HSTIMER)	+= timer-sun5i.o
 obj-$(CONFIG_MESON6_TIMER)	+= timer-meson6.o
diff --git a/drivers/clocksource/timer-u300.c b/drivers/clocksource/timer-u300.c
deleted file mode 100644
index 37cba8d..0000000
--- a/drivers/clocksource/timer-u300.c
+++ /dev/null
@@ -1,457 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-only
-/*
- * Copyright (C) 2007-2009 ST-Ericsson AB
- * Timer COH 901 328, runs the OS timer interrupt.
- * Author: Linus Walleij <linus.walleij@stericsson.com>
- */
-#include <linux/interrupt.h>
-#include <linux/time.h>
-#include <linux/timex.h>
-#include <linux/clockchips.h>
-#include <linux/clocksource.h>
-#include <linux/types.h>
-#include <linux/io.h>
-#include <linux/clk.h>
-#include <linux/err.h>
-#include <linux/irq.h>
-#include <linux/delay.h>
-#include <linux/of_address.h>
-#include <linux/of_irq.h>
-#include <linux/sched_clock.h>
-
-/* Generic stuff */
-#include <asm/mach/map.h>
-#include <asm/mach/time.h>
-
-/*
- * APP side special timer registers
- * This timer contains four timers which can fire an interrupt each.
- * OS (operating system) timer @ 32768 Hz
- * DD (device driver) timer @ 1 kHz
- * GP1 (general purpose 1) timer @ 1MHz
- * GP2 (general purpose 2) timer @ 1MHz
- */
-
-/* Reset OS Timer 32bit (-/W) */
-#define U300_TIMER_APP_ROST					(0x0000)
-#define U300_TIMER_APP_ROST_TIMER_RESET				(0x00000000)
-/* Enable OS Timer 32bit (-/W) */
-#define U300_TIMER_APP_EOST					(0x0004)
-#define U300_TIMER_APP_EOST_TIMER_ENABLE			(0x00000000)
-/* Disable OS Timer 32bit (-/W) */
-#define U300_TIMER_APP_DOST					(0x0008)
-#define U300_TIMER_APP_DOST_TIMER_DISABLE			(0x00000000)
-/* OS Timer Mode Register 32bit (-/W) */
-#define U300_TIMER_APP_SOSTM					(0x000c)
-#define U300_TIMER_APP_SOSTM_MODE_CONTINUOUS			(0x00000000)
-#define U300_TIMER_APP_SOSTM_MODE_ONE_SHOT			(0x00000001)
-/* OS Timer Status Register 32bit (R/-) */
-#define U300_TIMER_APP_OSTS					(0x0010)
-#define U300_TIMER_APP_OSTS_TIMER_STATE_MASK			(0x0000000F)
-#define U300_TIMER_APP_OSTS_TIMER_STATE_IDLE			(0x00000001)
-#define U300_TIMER_APP_OSTS_TIMER_STATE_ACTIVE			(0x00000002)
-#define U300_TIMER_APP_OSTS_ENABLE_IND				(0x00000010)
-#define U300_TIMER_APP_OSTS_MODE_MASK				(0x00000020)
-#define U300_TIMER_APP_OSTS_MODE_CONTINUOUS			(0x00000000)
-#define U300_TIMER_APP_OSTS_MODE_ONE_SHOT			(0x00000020)
-#define U300_TIMER_APP_OSTS_IRQ_ENABLED_IND			(0x00000040)
-#define U300_TIMER_APP_OSTS_IRQ_PENDING_IND			(0x00000080)
-/* OS Timer Current Count Register 32bit (R/-) */
-#define U300_TIMER_APP_OSTCC					(0x0014)
-/* OS Timer Terminal Count Register 32bit (R/W) */
-#define U300_TIMER_APP_OSTTC					(0x0018)
-/* OS Timer Interrupt Enable Register 32bit (-/W) */
-#define U300_TIMER_APP_OSTIE					(0x001c)
-#define U300_TIMER_APP_OSTIE_IRQ_DISABLE			(0x00000000)
-#define U300_TIMER_APP_OSTIE_IRQ_ENABLE				(0x00000001)
-/* OS Timer Interrupt Acknowledge Register 32bit (-/W) */
-#define U300_TIMER_APP_OSTIA					(0x0020)
-#define U300_TIMER_APP_OSTIA_IRQ_ACK				(0x00000080)
-
-/* Reset DD Timer 32bit (-/W) */
-#define U300_TIMER_APP_RDDT					(0x0040)
-#define U300_TIMER_APP_RDDT_TIMER_RESET				(0x00000000)
-/* Enable DD Timer 32bit (-/W) */
-#define U300_TIMER_APP_EDDT					(0x0044)
-#define U300_TIMER_APP_EDDT_TIMER_ENABLE			(0x00000000)
-/* Disable DD Timer 32bit (-/W) */
-#define U300_TIMER_APP_DDDT					(0x0048)
-#define U300_TIMER_APP_DDDT_TIMER_DISABLE			(0x00000000)
-/* DD Timer Mode Register 32bit (-/W) */
-#define U300_TIMER_APP_SDDTM					(0x004c)
-#define U300_TIMER_APP_SDDTM_MODE_CONTINUOUS			(0x00000000)
-#define U300_TIMER_APP_SDDTM_MODE_ONE_SHOT			(0x00000001)
-/* DD Timer Status Register 32bit (R/-) */
-#define U300_TIMER_APP_DDTS					(0x0050)
-#define U300_TIMER_APP_DDTS_TIMER_STATE_MASK			(0x0000000F)
-#define U300_TIMER_APP_DDTS_TIMER_STATE_IDLE			(0x00000001)
-#define U300_TIMER_APP_DDTS_TIMER_STATE_ACTIVE			(0x00000002)
-#define U300_TIMER_APP_DDTS_ENABLE_IND				(0x00000010)
-#define U300_TIMER_APP_DDTS_MODE_MASK				(0x00000020)
-#define U300_TIMER_APP_DDTS_MODE_CONTINUOUS			(0x00000000)
-#define U300_TIMER_APP_DDTS_MODE_ONE_SHOT			(0x00000020)
-#define U300_TIMER_APP_DDTS_IRQ_ENABLED_IND			(0x00000040)
-#define U300_TIMER_APP_DDTS_IRQ_PENDING_IND			(0x00000080)
-/* DD Timer Current Count Register 32bit (R/-) */
-#define U300_TIMER_APP_DDTCC					(0x0054)
-/* DD Timer Terminal Count Register 32bit (R/W) */
-#define U300_TIMER_APP_DDTTC					(0x0058)
-/* DD Timer Interrupt Enable Register 32bit (-/W) */
-#define U300_TIMER_APP_DDTIE					(0x005c)
-#define U300_TIMER_APP_DDTIE_IRQ_DISABLE			(0x00000000)
-#define U300_TIMER_APP_DDTIE_IRQ_ENABLE				(0x00000001)
-/* DD Timer Interrupt Acknowledge Register 32bit (-/W) */
-#define U300_TIMER_APP_DDTIA					(0x0060)
-#define U300_TIMER_APP_DDTIA_IRQ_ACK				(0x00000080)
-
-/* Reset GP1 Timer 32bit (-/W) */
-#define U300_TIMER_APP_RGPT1					(0x0080)
-#define U300_TIMER_APP_RGPT1_TIMER_RESET			(0x00000000)
-/* Enable GP1 Timer 32bit (-/W) */
-#define U300_TIMER_APP_EGPT1					(0x0084)
-#define U300_TIMER_APP_EGPT1_TIMER_ENABLE			(0x00000000)
-/* Disable GP1 Timer 32bit (-/W) */
-#define U300_TIMER_APP_DGPT1					(0x0088)
-#define U300_TIMER_APP_DGPT1_TIMER_DISABLE			(0x00000000)
-/* GP1 Timer Mode Register 32bit (-/W) */
-#define U300_TIMER_APP_SGPT1M					(0x008c)
-#define U300_TIMER_APP_SGPT1M_MODE_CONTINUOUS			(0x00000000)
-#define U300_TIMER_APP_SGPT1M_MODE_ONE_SHOT			(0x00000001)
-/* GP1 Timer Status Register 32bit (R/-) */
-#define U300_TIMER_APP_GPT1S					(0x0090)
-#define U300_TIMER_APP_GPT1S_TIMER_STATE_MASK			(0x0000000F)
-#define U300_TIMER_APP_GPT1S_TIMER_STATE_IDLE			(0x00000001)
-#define U300_TIMER_APP_GPT1S_TIMER_STATE_ACTIVE			(0x00000002)
-#define U300_TIMER_APP_GPT1S_ENABLE_IND				(0x00000010)
-#define U300_TIMER_APP_GPT1S_MODE_MASK				(0x00000020)
-#define U300_TIMER_APP_GPT1S_MODE_CONTINUOUS			(0x00000000)
-#define U300_TIMER_APP_GPT1S_MODE_ONE_SHOT			(0x00000020)
-#define U300_TIMER_APP_GPT1S_IRQ_ENABLED_IND			(0x00000040)
-#define U300_TIMER_APP_GPT1S_IRQ_PENDING_IND			(0x00000080)
-/* GP1 Timer Current Count Register 32bit (R/-) */
-#define U300_TIMER_APP_GPT1CC					(0x0094)
-/* GP1 Timer Terminal Count Register 32bit (R/W) */
-#define U300_TIMER_APP_GPT1TC					(0x0098)
-/* GP1 Timer Interrupt Enable Register 32bit (-/W) */
-#define U300_TIMER_APP_GPT1IE					(0x009c)
-#define U300_TIMER_APP_GPT1IE_IRQ_DISABLE			(0x00000000)
-#define U300_TIMER_APP_GPT1IE_IRQ_ENABLE			(0x00000001)
-/* GP1 Timer Interrupt Acknowledge Register 32bit (-/W) */
-#define U300_TIMER_APP_GPT1IA					(0x00a0)
-#define U300_TIMER_APP_GPT1IA_IRQ_ACK				(0x00000080)
-
-/* Reset GP2 Timer 32bit (-/W) */
-#define U300_TIMER_APP_RGPT2					(0x00c0)
-#define U300_TIMER_APP_RGPT2_TIMER_RESET			(0x00000000)
-/* Enable GP2 Timer 32bit (-/W) */
-#define U300_TIMER_APP_EGPT2					(0x00c4)
-#define U300_TIMER_APP_EGPT2_TIMER_ENABLE			(0x00000000)
-/* Disable GP2 Timer 32bit (-/W) */
-#define U300_TIMER_APP_DGPT2					(0x00c8)
-#define U300_TIMER_APP_DGPT2_TIMER_DISABLE			(0x00000000)
-/* GP2 Timer Mode Register 32bit (-/W) */
-#define U300_TIMER_APP_SGPT2M					(0x00cc)
-#define U300_TIMER_APP_SGPT2M_MODE_CONTINUOUS			(0x00000000)
-#define U300_TIMER_APP_SGPT2M_MODE_ONE_SHOT			(0x00000001)
-/* GP2 Timer Status Register 32bit (R/-) */
-#define U300_TIMER_APP_GPT2S					(0x00d0)
-#define U300_TIMER_APP_GPT2S_TIMER_STATE_MASK			(0x0000000F)
-#define U300_TIMER_APP_GPT2S_TIMER_STATE_IDLE			(0x00000001)
-#define U300_TIMER_APP_GPT2S_TIMER_STATE_ACTIVE			(0x00000002)
-#define U300_TIMER_APP_GPT2S_ENABLE_IND				(0x00000010)
-#define U300_TIMER_APP_GPT2S_MODE_MASK				(0x00000020)
-#define U300_TIMER_APP_GPT2S_MODE_CONTINUOUS			(0x00000000)
-#define U300_TIMER_APP_GPT2S_MODE_ONE_SHOT			(0x00000020)
-#define U300_TIMER_APP_GPT2S_IRQ_ENABLED_IND			(0x00000040)
-#define U300_TIMER_APP_GPT2S_IRQ_PENDING_IND			(0x00000080)
-/* GP2 Timer Current Count Register 32bit (R/-) */
-#define U300_TIMER_APP_GPT2CC					(0x00d4)
-/* GP2 Timer Terminal Count Register 32bit (R/W) */
-#define U300_TIMER_APP_GPT2TC					(0x00d8)
-/* GP2 Timer Interrupt Enable Register 32bit (-/W) */
-#define U300_TIMER_APP_GPT2IE					(0x00dc)
-#define U300_TIMER_APP_GPT2IE_IRQ_DISABLE			(0x00000000)
-#define U300_TIMER_APP_GPT2IE_IRQ_ENABLE			(0x00000001)
-/* GP2 Timer Interrupt Acknowledge Register 32bit (-/W) */
-#define U300_TIMER_APP_GPT2IA					(0x00e0)
-#define U300_TIMER_APP_GPT2IA_IRQ_ACK				(0x00000080)
-
-/* Clock request control register - all four timers */
-#define U300_TIMER_APP_CRC					(0x100)
-#define U300_TIMER_APP_CRC_CLOCK_REQUEST_ENABLE			(0x00000001)
-
-static void __iomem *u300_timer_base;
-
-struct u300_clockevent_data {
-	struct clock_event_device cevd;
-	unsigned ticks_per_jiffy;
-};
-
-static int u300_shutdown(struct clock_event_device *evt)
-{
-	/* Disable interrupts on GP1 */
-	writel(U300_TIMER_APP_GPT1IE_IRQ_DISABLE,
-	       u300_timer_base + U300_TIMER_APP_GPT1IE);
-	/* Disable GP1 */
-	writel(U300_TIMER_APP_DGPT1_TIMER_DISABLE,
-	       u300_timer_base + U300_TIMER_APP_DGPT1);
-	return 0;
-}
-
-/*
- * If we have oneshot timer active, the oneshot scheduling function
- * u300_set_next_event() is called immediately after.
- */
-static int u300_set_oneshot(struct clock_event_device *evt)
-{
-	/* Just return; here? */
-	/*
-	 * The actual event will be programmed by the next event hook,
-	 * so we just set a dummy value somewhere at the end of the
-	 * universe here.
-	 */
-	/* Disable interrupts on GPT1 */
-	writel(U300_TIMER_APP_GPT1IE_IRQ_DISABLE,
-	       u300_timer_base + U300_TIMER_APP_GPT1IE);
-	/* Disable GP1 while we're reprogramming it. */
-	writel(U300_TIMER_APP_DGPT1_TIMER_DISABLE,
-	       u300_timer_base + U300_TIMER_APP_DGPT1);
-	/*
-	 * Expire far in the future, u300_set_next_event() will be
-	 * called soon...
-	 */
-	writel(0xFFFFFFFF, u300_timer_base + U300_TIMER_APP_GPT1TC);
-	/* We run one shot per tick here! */
-	writel(U300_TIMER_APP_SGPT1M_MODE_ONE_SHOT,
-	       u300_timer_base + U300_TIMER_APP_SGPT1M);
-	/* Enable interrupts for this timer */
-	writel(U300_TIMER_APP_GPT1IE_IRQ_ENABLE,
-	       u300_timer_base + U300_TIMER_APP_GPT1IE);
-	/* Enable timer */
-	writel(U300_TIMER_APP_EGPT1_TIMER_ENABLE,
-	       u300_timer_base + U300_TIMER_APP_EGPT1);
-	return 0;
-}
-
-static int u300_set_periodic(struct clock_event_device *evt)
-{
-	struct u300_clockevent_data *cevdata =
-		container_of(evt, struct u300_clockevent_data, cevd);
-
-	/* Disable interrupts on GPT1 */
-	writel(U300_TIMER_APP_GPT1IE_IRQ_DISABLE,
-	       u300_timer_base + U300_TIMER_APP_GPT1IE);
-	/* Disable GP1 while we're reprogramming it. */
-	writel(U300_TIMER_APP_DGPT1_TIMER_DISABLE,
-	       u300_timer_base + U300_TIMER_APP_DGPT1);
-	/*
-	 * Set the periodic mode to a certain number of ticks per
-	 * jiffy.
-	 */
-	writel(cevdata->ticks_per_jiffy,
-	       u300_timer_base + U300_TIMER_APP_GPT1TC);
-	/*
-	 * Set continuous mode, so the timer keeps triggering
-	 * interrupts.
-	 */
-	writel(U300_TIMER_APP_SGPT1M_MODE_CONTINUOUS,
-	       u300_timer_base + U300_TIMER_APP_SGPT1M);
-	/* Enable timer interrupts */
-	writel(U300_TIMER_APP_GPT1IE_IRQ_ENABLE,
-	       u300_timer_base + U300_TIMER_APP_GPT1IE);
-	/* Then enable the OS timer again */
-	writel(U300_TIMER_APP_EGPT1_TIMER_ENABLE,
-	       u300_timer_base + U300_TIMER_APP_EGPT1);
-	return 0;
-}
-
-/*
- * The app timer in one shot mode obviously has to be reprogrammed
- * in EXACTLY this sequence to work properly. Do NOT try to e.g. replace
- * the interrupt disable + timer disable commands with a reset command,
- * it will fail miserably. Apparently (and I found this the hard way)
- * the timer is very sensitive to the instruction order, though you don't
- * get that impression from the data sheet.
- */
-static int u300_set_next_event(unsigned long cycles,
-			       struct clock_event_device *evt)
-
-{
-	/* Disable interrupts on GPT1 */
-	writel(U300_TIMER_APP_GPT1IE_IRQ_DISABLE,
-	       u300_timer_base + U300_TIMER_APP_GPT1IE);
-	/* Disable GP1 while we're reprogramming it. */
-	writel(U300_TIMER_APP_DGPT1_TIMER_DISABLE,
-	       u300_timer_base + U300_TIMER_APP_DGPT1);
-	/* Reset the General Purpose timer 1. */
-	writel(U300_TIMER_APP_RGPT1_TIMER_RESET,
-	       u300_timer_base + U300_TIMER_APP_RGPT1);
-	/* IRQ in n * cycles */
-	writel(cycles, u300_timer_base + U300_TIMER_APP_GPT1TC);
-	/*
-	 * We run one shot per tick here! (This is necessary to reconfigure,
-	 * the timer will tilt if you don't!)
-	 */
-	writel(U300_TIMER_APP_SGPT1M_MODE_ONE_SHOT,
-	       u300_timer_base + U300_TIMER_APP_SGPT1M);
-	/* Enable timer interrupts */
-	writel(U300_TIMER_APP_GPT1IE_IRQ_ENABLE,
-	       u300_timer_base + U300_TIMER_APP_GPT1IE);
-	/* Then enable the OS timer again */
-	writel(U300_TIMER_APP_EGPT1_TIMER_ENABLE,
-	       u300_timer_base + U300_TIMER_APP_EGPT1);
-	return 0;
-}
-
-static struct u300_clockevent_data u300_clockevent_data = {
-	/* Use general purpose timer 1 as clock event */
-	.cevd = {
-		.name			= "GPT1",
-		/* Reasonably fast and accurate clock event */
-		.rating			= 300,
-		.features		= CLOCK_EVT_FEAT_PERIODIC |
-					  CLOCK_EVT_FEAT_ONESHOT,
-		.set_next_event		= u300_set_next_event,
-		.set_state_shutdown	= u300_shutdown,
-		.set_state_periodic	= u300_set_periodic,
-		.set_state_oneshot	= u300_set_oneshot,
-	},
-};
-
-/* Clock event timer interrupt handler */
-static irqreturn_t u300_timer_interrupt(int irq, void *dev_id)
-{
-	struct clock_event_device *evt = &u300_clockevent_data.cevd;
-	/* ACK/Clear timer IRQ for the APP GPT1 Timer */
-
-	writel(U300_TIMER_APP_GPT1IA_IRQ_ACK,
-		u300_timer_base + U300_TIMER_APP_GPT1IA);
-	evt->event_handler(evt);
-	return IRQ_HANDLED;
-}
-
-/*
- * Override the global weak sched_clock symbol with this
- * local implementation which uses the clocksource to get some
- * better resolution when scheduling the kernel. We accept that
- * this wraps around for now, since it is just a relative time
- * stamp. (Inspired by OMAP implementation.)
- */
-
-static u64 notrace u300_read_sched_clock(void)
-{
-	return readl(u300_timer_base + U300_TIMER_APP_GPT2CC);
-}
-
-static unsigned long u300_read_current_timer(void)
-{
-	return readl(u300_timer_base + U300_TIMER_APP_GPT2CC);
-}
-
-static struct delay_timer u300_delay_timer;
-
-/*
- * This sets up the system timers, clock source and clock event.
- */
-static int __init u300_timer_init_of(struct device_node *np)
-{
-	unsigned int irq;
-	struct clk *clk;
-	unsigned long rate;
-	int ret;
-
-	u300_timer_base = of_iomap(np, 0);
-	if (!u300_timer_base) {
-		pr_err("could not ioremap system timer\n");
-		return -ENXIO;
-	}
-
-	/* Get the IRQ for the GP1 timer */
-	irq = irq_of_parse_and_map(np, 2);
-	if (!irq) {
-		pr_err("no IRQ for system timer\n");
-		return -EINVAL;
-	}
-
-	pr_info("U300 GP1 timer @ base: %p, IRQ: %u\n", u300_timer_base, irq);
-
-	/* Clock the interrupt controller */
-	clk = of_clk_get(np, 0);
-	if (IS_ERR(clk))
-		return PTR_ERR(clk);
-
-	ret = clk_prepare_enable(clk);
-	if (ret)
-		return ret;
-
-	rate = clk_get_rate(clk);
-
-	u300_clockevent_data.ticks_per_jiffy = DIV_ROUND_CLOSEST(rate, HZ);
-
-	sched_clock_register(u300_read_sched_clock, 32, rate);
-
-	u300_delay_timer.read_current_timer = &u300_read_current_timer;
-	u300_delay_timer.freq = rate;
-	register_current_timer_delay(&u300_delay_timer);
-
-	/*
-	 * Disable the "OS" and "DD" timers - these are designed for Symbian!
-	 * Example usage in cnh1601578 cpu subsystem pd_timer_app.c
-	 */
-	writel(U300_TIMER_APP_CRC_CLOCK_REQUEST_ENABLE,
-		u300_timer_base + U300_TIMER_APP_CRC);
-	writel(U300_TIMER_APP_ROST_TIMER_RESET,
-		u300_timer_base + U300_TIMER_APP_ROST);
-	writel(U300_TIMER_APP_DOST_TIMER_DISABLE,
-		u300_timer_base + U300_TIMER_APP_DOST);
-	writel(U300_TIMER_APP_RDDT_TIMER_RESET,
-		u300_timer_base + U300_TIMER_APP_RDDT);
-	writel(U300_TIMER_APP_DDDT_TIMER_DISABLE,
-		u300_timer_base + U300_TIMER_APP_DDDT);
-
-	/* Reset the General Purpose timer 1. */
-	writel(U300_TIMER_APP_RGPT1_TIMER_RESET,
-		u300_timer_base + U300_TIMER_APP_RGPT1);
-
-	/* Set up the IRQ handler */
-	ret = request_irq(irq, u300_timer_interrupt,
-			  IRQF_TIMER | IRQF_IRQPOLL, "U300 Timer Tick", NULL);
-	if (ret)
-		return ret;
-
-	/* Reset the General Purpose timer 2 */
-	writel(U300_TIMER_APP_RGPT2_TIMER_RESET,
-		u300_timer_base + U300_TIMER_APP_RGPT2);
-	/* Set this timer to run around forever */
-	writel(0xFFFFFFFFU, u300_timer_base + U300_TIMER_APP_GPT2TC);
-	/* Set continuous mode so it wraps around */
-	writel(U300_TIMER_APP_SGPT2M_MODE_CONTINUOUS,
-	       u300_timer_base + U300_TIMER_APP_SGPT2M);
-	/* Disable timer interrupts */
-	writel(U300_TIMER_APP_GPT2IE_IRQ_DISABLE,
-		u300_timer_base + U300_TIMER_APP_GPT2IE);
-	/* Then enable the GP2 timer to use as a free running us counter */
-	writel(U300_TIMER_APP_EGPT2_TIMER_ENABLE,
-		u300_timer_base + U300_TIMER_APP_EGPT2);
-
-	/* Use general purpose timer 2 as clock source */
-	ret = clocksource_mmio_init(u300_timer_base + U300_TIMER_APP_GPT2CC,
-				    "GPT2", rate, 300, 32, clocksource_mmio_readl_up);
-	if (ret) {
-		pr_err("timer: failed to initialize U300 clock source\n");
-		return ret;
-	}
-
-	/* Configure and register the clockevent */
-	clockevents_config_and_register(&u300_clockevent_data.cevd, rate,
-					1, 0xffffffff);
-
-	/*
-	 * TODO: init and register the rest of the timers too, they can be
-	 * used by hrtimers!
-	 */
-	return 0;
-}
-
-TIMER_OF_DECLARE(u300_timer, "stericsson,u300-apptimer",
-		       u300_timer_init_of);
