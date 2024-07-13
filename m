Return-Path: <linux-tip-commits+bounces-1685-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AEA39304F2
	for <lists+linux-tip-commits@lfdr.de>; Sat, 13 Jul 2024 12:17:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 827AC1F225CD
	for <lists+linux-tip-commits@lfdr.de>; Sat, 13 Jul 2024 10:17:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2265B61FE5;
	Sat, 13 Jul 2024 10:17:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="F+LXnFlQ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="TXa8At66"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25B8E47F64;
	Sat, 13 Jul 2024 10:17:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720865823; cv=none; b=hbiYRvtDF/6kfgAVzTGtHDxVMLkmRRxF5AlBOuALPhNvP+KG3dJbRRcpUZ+lj0XADfPRTo1jgV/g/GqVoI5vjIUTz/1NCU0u3heK+7gdFmF5LKnXeNpkAngBcBygPV0hDA9oICc0nv5j97t8KPNmZKBd5ijR/eZR7AOArYPsCHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720865823; c=relaxed/simple;
	bh=ySQQONbI++Wtg6JWNWnKickyFPwfwpk5yCR1UCbQwro=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=pedd38FJwhrUQlaOvoMqTuP59f8O73rzZsXBwfjP26Rcbm3qX5JsmwzWkJnDcIJEaXDjc5ZNFOtqs2StJkH64XKulEr87xulDQz8Q1fQ7Nwe6mZk9yQkBA451CZXxlbWl8S8mSAwHPszJsGLFYstyIIaHXtpwU7ifbNVe3Iu6s8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=F+LXnFlQ; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=TXa8At66; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sat, 13 Jul 2024 10:16:53 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1720865813;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RlwaWUGSTCqSxoEAPcB9SbnSxdanRz9zsELHZNX6dYc=;
	b=F+LXnFlQ6u3Ro5U022eFB4a+xqaSVfGbRndsi5uo3iIDQrLzTe25jF6lWRm/U8t6FR2Q9h
	Asp014Z0GvGS8ZDzApEyqo3fXkR4IpyAllhY0SS5aI1SA7YHaLNaofkQXLg1zMMfEfi3pm
	KKH4u5jJsVGFpfE+vwrnvUhUeK8SRH7v/YwXrcNVZr6KExCXA+oHQXy3cmIJUyniRCeDCo
	LvvHjLdGgX1K73iopzqsCVvHNO09KlOCdTJcIMB/bI0ntJr8cWP1eg2Df1rWwL/P3E6OYl
	fEeFvbEV9t/YYZH3Iki2xPQagFmEx6XyXfLSCw+bBagT87CK3wYoKFSyrsblWQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1720865813;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RlwaWUGSTCqSxoEAPcB9SbnSxdanRz9zsELHZNX6dYc=;
	b=TXa8At66AvTLrIeYc+BChGg4xTurUpj9P77gWf4oz+wWwA/HxtAnlOsUIID3sTVKksvdnN
	+kgY70V54v5irHCA==
From: "tip-bot2 for Chris Packham" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] clocksource/drivers/realtek: Add timer driver for
 rtl-otto platforms
Cc: Markus Stockhausen <markus.stockhausen@gmx.de>,
 Sander Vanheule <sander@svanheule.net>,
 Chris Packham <chris.packham@alliedtelesis.co.nz>,
 Daniel Lezcano <daniel.lezcano@linaro.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240710043524.1535151-8-chris.packham@alliedtelesis.co.nz>
References: <20240710043524.1535151-8-chris.packham@alliedtelesis.co.nz>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172086581329.2215.17530000960111732772.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     4bdc3eaa102b6bedb0800f76f53eca516d5cf20c
Gitweb:        https://git.kernel.org/tip/4bdc3eaa102b6bedb0800f76f53eca516d5cf20c
Author:        Chris Packham <chris.packham@alliedtelesis.co.nz>
AuthorDate:    Wed, 10 Jul 2024 16:35:21 +12:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Fri, 12 Jul 2024 16:07:06 +02:00

clocksource/drivers/realtek: Add timer driver for rtl-otto platforms

The timer/counter block on the Realtek SoCs provides up to 5 timers. It
also includes a watchdog timer which is handled by the
realtek_otto_wdt.c driver.

One timer will be used per CPU as a local clock event generator. An
additional timer will be used as an overal stable clocksource.

Signed-off-by: Markus Stockhausen <markus.stockhausen@gmx.de>
Signed-off-by: Sander Vanheule <sander@svanheule.net>
Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
Link: https://lore.kernel.org/r/20240710043524.1535151-8-chris.packham@alliedtelesis.co.nz
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/clocksource/Kconfig          |  10 +-
 drivers/clocksource/Makefile         |   1 +-
 drivers/clocksource/timer-rtl-otto.c | 291 ++++++++++++++++++++++++++-
 include/linux/cpuhotplug.h           |   1 +-
 4 files changed, 303 insertions(+)
 create mode 100644 drivers/clocksource/timer-rtl-otto.c

diff --git a/drivers/clocksource/Kconfig b/drivers/clocksource/Kconfig
index 34faa03..95dd466 100644
--- a/drivers/clocksource/Kconfig
+++ b/drivers/clocksource/Kconfig
@@ -134,6 +134,16 @@ config RDA_TIMER
 	help
 	  Enables the support for the RDA Micro timer driver.
 
+config REALTEK_OTTO_TIMER
+	bool "Clocksource/timer for the Realtek Otto platform" if COMPILE_TEST
+	select TIMER_OF
+	help
+	  This driver adds support for the timers found in the Realtek RTL83xx
+	  and RTL93xx SoCs series. This includes chips such as RTL8380, RTL8381
+	  and RTL832, as well as chips from the RTL839x series, such as RTL8390
+	  RT8391, RTL8392, RTL8393 and RTL8396 and chips of the RTL930x series
+	  such as RTL9301, RTL9302 or RTL9303.
+
 config SUN4I_TIMER
 	bool "Sun4i timer driver" if COMPILE_TEST
 	depends on HAS_IOMEM
diff --git a/drivers/clocksource/Makefile b/drivers/clocksource/Makefile
index 4bb856e..2274378 100644
--- a/drivers/clocksource/Makefile
+++ b/drivers/clocksource/Makefile
@@ -59,6 +59,7 @@ obj-$(CONFIG_MILBEAUT_TIMER)	+= timer-milbeaut.o
 obj-$(CONFIG_SPRD_TIMER)	+= timer-sprd.o
 obj-$(CONFIG_NPCM7XX_TIMER)	+= timer-npcm7xx.o
 obj-$(CONFIG_RDA_TIMER)		+= timer-rda.o
+obj-$(CONFIG_REALTEK_OTTO_TIMER)	+= timer-rtl-otto.o
 
 obj-$(CONFIG_ARC_TIMERS)		+= arc_timer.o
 obj-$(CONFIG_ARM_ARCH_TIMER)		+= arm_arch_timer.o
diff --git a/drivers/clocksource/timer-rtl-otto.c b/drivers/clocksource/timer-rtl-otto.c
new file mode 100644
index 0000000..8a3068b
--- /dev/null
+++ b/drivers/clocksource/timer-rtl-otto.c
@@ -0,0 +1,291 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
+#define pr_fmt(fmt)	KBUILD_MODNAME ": " fmt
+
+#include <linux/clk.h>
+#include <linux/clockchips.h>
+#include <linux/cpu.h>
+#include <linux/cpuhotplug.h>
+#include <linux/cpumask.h>
+#include <linux/interrupt.h>
+#include <linux/io.h>
+#include <linux/jiffies.h>
+#include <linux/printk.h>
+#include <linux/sched_clock.h>
+#include "timer-of.h"
+
+#define RTTM_DATA		0x0
+#define RTTM_CNT		0x4
+#define RTTM_CTRL		0x8
+#define RTTM_INT		0xc
+
+#define RTTM_CTRL_ENABLE	BIT(28)
+#define RTTM_INT_PENDING	BIT(16)
+#define RTTM_INT_ENABLE		BIT(20)
+
+/*
+ * The Otto platform provides multiple 28 bit timers/counters with the following
+ * operating logic. If enabled the timer counts up. Per timer one can set a
+ * maximum counter value as an end marker. If end marker is reached the timer
+ * fires an interrupt. If the timer "overflows" by reaching the end marker or
+ * by adding 1 to 0x0fffffff the counter is reset to 0. When this happens and
+ * the timer is in operating mode COUNTER it stops. In mode TIMER it will
+ * continue to count up.
+ */
+#define RTTM_CTRL_COUNTER	0
+#define RTTM_CTRL_TIMER		BIT(24)
+
+#define RTTM_BIT_COUNT		28
+#define RTTM_MIN_DELTA		8
+#define RTTM_MAX_DELTA		CLOCKSOURCE_MASK(28)
+
+/*
+ * Timers are derived from the LXB clock frequency. Usually this is a fixed
+ * multiple of the 25 MHz oscillator. The 930X SOC is an exception from that.
+ * Its LXB clock has only dividers and uses the switch PLL of 2.45 GHz as its
+ * base. The only meaningful frequencies we can achieve from that are 175.000
+ * MHz and 153.125 MHz. The greatest common divisor of all explained possible
+ * speeds is 3125000. Pin the timers to this 3.125 MHz reference frequency.
+ */
+#define RTTM_TICKS_PER_SEC	3125000
+
+struct rttm_cs {
+	struct timer_of		to;
+	struct clocksource	cs;
+};
+
+/* Simple internal register functions */
+static inline void rttm_set_counter(void __iomem *base, unsigned int counter)
+{
+	iowrite32(counter, base + RTTM_CNT);
+}
+
+static inline unsigned int rttm_get_counter(void __iomem *base)
+{
+	return ioread32(base + RTTM_CNT);
+}
+
+static inline void rttm_set_period(void __iomem *base, unsigned int period)
+{
+	iowrite32(period, base + RTTM_DATA);
+}
+
+static inline void rttm_disable_timer(void __iomem *base)
+{
+	iowrite32(0, base + RTTM_CTRL);
+}
+
+static inline void rttm_enable_timer(void __iomem *base, u32 mode, u32 divisor)
+{
+	iowrite32(RTTM_CTRL_ENABLE | mode | divisor, base + RTTM_CTRL);
+}
+
+static inline void rttm_ack_irq(void __iomem *base)
+{
+	iowrite32(ioread32(base + RTTM_INT) | RTTM_INT_PENDING, base + RTTM_INT);
+}
+
+static inline void rttm_enable_irq(void __iomem *base)
+{
+	iowrite32(RTTM_INT_ENABLE, base + RTTM_INT);
+}
+
+static inline void rttm_disable_irq(void __iomem *base)
+{
+	iowrite32(0, base + RTTM_INT);
+}
+
+/* Aggregated control functions for kernel clock framework */
+#define RTTM_DEBUG(base)			\
+	pr_debug("------------- %d %p\n",	\
+		 smp_processor_id(), base)
+
+static irqreturn_t rttm_timer_interrupt(int irq, void *dev_id)
+{
+	struct clock_event_device *clkevt = dev_id;
+	struct timer_of *to = to_timer_of(clkevt);
+
+	rttm_ack_irq(to->of_base.base);
+	RTTM_DEBUG(to->of_base.base);
+	clkevt->event_handler(clkevt);
+
+	return IRQ_HANDLED;
+}
+
+static void rttm_stop_timer(void __iomem *base)
+{
+	rttm_disable_timer(base);
+	rttm_ack_irq(base);
+}
+
+static void rttm_start_timer(struct timer_of *to, u32 mode)
+{
+	rttm_set_counter(to->of_base.base, 0);
+	rttm_enable_timer(to->of_base.base, mode, to->of_clk.rate / RTTM_TICKS_PER_SEC);
+}
+
+static int rttm_next_event(unsigned long delta, struct clock_event_device *clkevt)
+{
+	struct timer_of *to = to_timer_of(clkevt);
+
+	RTTM_DEBUG(to->of_base.base);
+	rttm_stop_timer(to->of_base.base);
+	rttm_set_period(to->of_base.base, delta);
+	rttm_start_timer(to, RTTM_CTRL_COUNTER);
+
+	return 0;
+}
+
+static int rttm_state_oneshot(struct clock_event_device *clkevt)
+{
+	struct timer_of *to = to_timer_of(clkevt);
+
+	RTTM_DEBUG(to->of_base.base);
+	rttm_stop_timer(to->of_base.base);
+	rttm_set_period(to->of_base.base, RTTM_TICKS_PER_SEC / HZ);
+	rttm_start_timer(to, RTTM_CTRL_COUNTER);
+
+	return 0;
+}
+
+static int rttm_state_periodic(struct clock_event_device *clkevt)
+{
+	struct timer_of *to = to_timer_of(clkevt);
+
+	RTTM_DEBUG(to->of_base.base);
+	rttm_stop_timer(to->of_base.base);
+	rttm_set_period(to->of_base.base, RTTM_TICKS_PER_SEC / HZ);
+	rttm_start_timer(to, RTTM_CTRL_TIMER);
+
+	return 0;
+}
+
+static int rttm_state_shutdown(struct clock_event_device *clkevt)
+{
+	struct timer_of *to = to_timer_of(clkevt);
+
+	RTTM_DEBUG(to->of_base.base);
+	rttm_stop_timer(to->of_base.base);
+
+	return 0;
+}
+
+static void rttm_setup_timer(void __iomem *base)
+{
+	RTTM_DEBUG(base);
+	rttm_stop_timer(base);
+	rttm_set_period(base, 0);
+}
+
+static u64 rttm_read_clocksource(struct clocksource *cs)
+{
+	struct rttm_cs *rcs = container_of(cs, struct rttm_cs, cs);
+
+	return rttm_get_counter(rcs->to.of_base.base);
+}
+
+/* Module initialization part. */
+static DEFINE_PER_CPU(struct timer_of, rttm_to) = {
+	.flags				= TIMER_OF_BASE | TIMER_OF_CLOCK | TIMER_OF_IRQ,
+	.of_irq = {
+		.flags			= IRQF_PERCPU | IRQF_TIMER,
+		.handler		= rttm_timer_interrupt,
+	},
+	.clkevt = {
+		.rating			= 400,
+		.features		= CLOCK_EVT_FEAT_PERIODIC | CLOCK_EVT_FEAT_ONESHOT,
+		.set_state_periodic	= rttm_state_periodic,
+		.set_state_shutdown	= rttm_state_shutdown,
+		.set_state_oneshot	= rttm_state_oneshot,
+		.set_next_event		= rttm_next_event
+	},
+};
+
+static int rttm_enable_clocksource(struct clocksource *cs)
+{
+	struct rttm_cs *rcs = container_of(cs, struct rttm_cs, cs);
+
+	rttm_disable_irq(rcs->to.of_base.base);
+	rttm_setup_timer(rcs->to.of_base.base);
+	rttm_enable_timer(rcs->to.of_base.base, RTTM_CTRL_TIMER,
+			  rcs->to.of_clk.rate / RTTM_TICKS_PER_SEC);
+
+	return 0;
+}
+
+struct rttm_cs rttm_cs = {
+	.to = {
+		.flags	= TIMER_OF_BASE | TIMER_OF_CLOCK,
+	},
+	.cs = {
+		.name	= "realtek_otto_timer",
+		.rating	= 400,
+		.mask	= CLOCKSOURCE_MASK(RTTM_BIT_COUNT),
+		.flags	= CLOCK_SOURCE_IS_CONTINUOUS,
+		.read	= rttm_read_clocksource,
+	}
+};
+
+static u64 notrace rttm_read_clock(void)
+{
+	return rttm_get_counter(rttm_cs.to.of_base.base);
+}
+
+static int rttm_cpu_starting(unsigned int cpu)
+{
+	struct timer_of *to = per_cpu_ptr(&rttm_to, cpu);
+
+	RTTM_DEBUG(to->of_base.base);
+	to->clkevt.cpumask = cpumask_of(cpu);
+	irq_force_affinity(to->of_irq.irq, to->clkevt.cpumask);
+	clockevents_config_and_register(&to->clkevt, RTTM_TICKS_PER_SEC,
+					RTTM_MIN_DELTA, RTTM_MAX_DELTA);
+	rttm_enable_irq(to->of_base.base);
+
+	return 0;
+}
+
+static int __init rttm_probe(struct device_node *np)
+{
+	unsigned int cpu, cpu_rollback;
+	struct timer_of *to;
+	unsigned int clkidx = num_possible_cpus();
+
+	/* Use the first n timers as per CPU clock event generators */
+	for_each_possible_cpu(cpu) {
+		to = per_cpu_ptr(&rttm_to, cpu);
+		to->of_irq.index = to->of_base.index = cpu;
+		if (timer_of_init(np, to)) {
+			pr_err("setup of timer %d failed\n", cpu);
+			goto rollback;
+		}
+		rttm_setup_timer(to->of_base.base);
+	}
+
+	/* Activate the n'th + 1 timer as a stable CPU clocksource. */
+	to = &rttm_cs.to;
+	to->of_base.index = clkidx;
+	timer_of_init(np, to);
+	if (rttm_cs.to.of_base.base && rttm_cs.to.of_clk.rate) {
+		rttm_enable_clocksource(&rttm_cs.cs);
+		clocksource_register_hz(&rttm_cs.cs, RTTM_TICKS_PER_SEC);
+		sched_clock_register(rttm_read_clock, RTTM_BIT_COUNT, RTTM_TICKS_PER_SEC);
+	} else
+		pr_err(" setup of timer %d as clocksource failed", clkidx);
+
+	return cpuhp_setup_state(CPUHP_AP_REALTEK_TIMER_STARTING,
+				"timer/realtek:online",
+				rttm_cpu_starting, NULL);
+rollback:
+	pr_err("timer registration failed\n");
+	for_each_possible_cpu(cpu_rollback) {
+		if (cpu_rollback == cpu)
+			break;
+		to = per_cpu_ptr(&rttm_to, cpu_rollback);
+		timer_of_cleanup(to);
+	}
+
+	return -EINVAL;
+}
+
+TIMER_OF_DECLARE(otto_timer, "realtek,otto-timer", rttm_probe);
diff --git a/include/linux/cpuhotplug.h b/include/linux/cpuhotplug.h
index 7a5785f..56b744d 100644
--- a/include/linux/cpuhotplug.h
+++ b/include/linux/cpuhotplug.h
@@ -171,6 +171,7 @@ enum cpuhp_state {
 	CPUHP_AP_ARMADA_TIMER_STARTING,
 	CPUHP_AP_MIPS_GIC_TIMER_STARTING,
 	CPUHP_AP_ARC_TIMER_STARTING,
+	CPUHP_AP_REALTEK_TIMER_STARTING,
 	CPUHP_AP_RISCV_TIMER_STARTING,
 	CPUHP_AP_CLINT_TIMER_STARTING,
 	CPUHP_AP_CSKY_TIMER_STARTING,

