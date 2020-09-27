Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C46027A03C
	for <lists+linux-tip-commits@lfdr.de>; Sun, 27 Sep 2020 11:28:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726252AbgI0J2B (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Sun, 27 Sep 2020 05:28:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726405AbgI0J1W (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Sun, 27 Sep 2020 05:27:22 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3970FC0613D3;
        Sun, 27 Sep 2020 02:27:22 -0700 (PDT)
Date:   Sun, 27 Sep 2020 09:27:20 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1601198840;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=56f0/Xuq8Y+tOXwqerwdulYEldLN5VCEPm3wQuDnbkE=;
        b=C+cF1SpdxWsW48d4obgRP0M4NVPgSaaWwG1DCWrAYqU7hTKT6alP6ZvRGN4gseSKIpJhNd
        TEIEBJUFdifJOQKQizk+qJhqk8G7J1ncIQ89zwC7Cadhp0P7bm0xgFCgcbP/U0vcAXXdPi
        YBcErwjwW1Ach2sDTprbwYLs2ERdiuyfqgaRYt+JSO15svmW+dIDFVevd73qyd7HDTqIbP
        ufW9yTIGYj14FKieGgJtP5Oc8ueyqp1NCHcaTptZvOuL25h2nWSusxdHKLgOvcWzaW5ad+
        tnwU8M4MgdAcKk8nyO7bBB/0YfDErbcfnlFzUGn743Np6+v9ElQgY7fh2EFocA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1601198840;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=56f0/Xuq8Y+tOXwqerwdulYEldLN5VCEPm3wQuDnbkE=;
        b=1OyA1AWBEs3Vr3m3NI0TlmFXeL/G/PQ30MxXSVAlkrT7d+kybdv8M62lWQzKiUMflVRw2r
        aMdSw8ZI1miHR9Ag==
From:   "tip-bot2 for Zhen Lei" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] clocksource/drivers/sp804: Support non-standard
 register offset
Cc:     Zhen Lei <thunder.leizhen@huawei.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200918132237.3552-7-thunder.leizhen@huawei.com>
References: <20200918132237.3552-7-thunder.leizhen@huawei.com>
MIME-Version: 1.0
Message-ID: <160119884001.7002.10466590684988402879.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     23c788cd48db9e2646fb5455f004e4a5626e4230
Gitweb:        https://git.kernel.org/tip/23c788cd48db9e2646fb5455f004e4a5626e4230
Author:        Zhen Lei <thunder.leizhen@huawei.com>
AuthorDate:    Fri, 18 Sep 2020 21:22:34 +08:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Thu, 24 Sep 2020 10:51:04 +02:00

clocksource/drivers/sp804: Support non-standard register offset

The ARM SP804 supports a maximum of 32-bit counter, but Hisilicon extends
it to 64-bit. That means, the registers: TimerXload, TimerXValue and
TimerXBGLoad are 64bits, all other registers are the same as those in the
SP804. The driver code can be completely reused except that the register
offset is different.

Currently, we get a timer register address by: add the constant register
offset to the timer base address. e.g. "base + TIMER_CTRL". It can not be
dynamically adjusted at run time.

So create a new structure "sp804_timer" to record the original registers
offset, and create a new structure "sp804_clkevt" to record the
calculated registers address. So the "base + TIMER_CTRL" is changed to
"clkevt->ctrl", this will faster than "base + timer->ctrl".

For example:
	struct sp804_timer arm_sp804_timer = {
		.ctrl	= TIMER_CTRL,
	};

	struct sp804_clkevt clkevt;

	clkevt.ctrl = base + arm_sp804_timer.ctrl.

-	writel(0, base + TIMER_CTRL);
+	writel(0, clkevt->ctrl);

Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Link: https://lore.kernel.org/r/20200918132237.3552-7-thunder.leizhen@huawei.com
---
 drivers/clocksource/timer-sp.h    |  26 +++++++-
 drivers/clocksource/timer-sp804.c | 108 ++++++++++++++++++++++-------
 2 files changed, 108 insertions(+), 26 deletions(-)

diff --git a/drivers/clocksource/timer-sp.h b/drivers/clocksource/timer-sp.h
index b2037eb..1ab75cb 100644
--- a/drivers/clocksource/timer-sp.h
+++ b/drivers/clocksource/timer-sp.h
@@ -10,6 +10,7 @@
  *
  * Every SP804 contains two identical timers.
  */
+#define NR_TIMERS	2
 #define TIMER_1_BASE	0x00
 #define TIMER_2_BASE	0x20
 
@@ -29,3 +30,28 @@
 #define TIMER_RIS	0x10			/*  CVR ro */
 #define TIMER_MIS	0x14			/*  CVR ro */
 #define TIMER_BGLOAD	0x18			/*  CVR rw */
+
+struct sp804_timer {
+	int load;
+	int value;
+	int ctrl;
+	int intclr;
+	int ris;
+	int mis;
+	int bgload;
+	int timer_base[NR_TIMERS];
+	int width;
+};
+
+struct sp804_clkevt {
+	void __iomem *base;
+	void __iomem *load;
+	void __iomem *value;
+	void __iomem *ctrl;
+	void __iomem *intclr;
+	void __iomem *ris;
+	void __iomem *mis;
+	void __iomem *bgload;
+	unsigned long reload;
+	int width;
+};
diff --git a/drivers/clocksource/timer-sp804.c b/drivers/clocksource/timer-sp804.c
index 471c5c6..5f4f979 100644
--- a/drivers/clocksource/timer-sp804.c
+++ b/drivers/clocksource/timer-sp804.c
@@ -20,6 +20,17 @@
 
 #include "timer-sp.h"
 
+struct sp804_timer __initdata arm_sp804_timer = {
+	.load		= TIMER_LOAD,
+	.value		= TIMER_VALUE,
+	.ctrl		= TIMER_CTRL,
+	.intclr		= TIMER_INTCLR,
+	.timer_base	= {TIMER_1_BASE, TIMER_2_BASE},
+	.width		= 32,
+};
+
+static struct sp804_clkevt sp804_clkevt[NR_TIMERS];
+
 static long __init sp804_get_clock_rate(struct clk *clk, const char *name)
 {
 	long rate;
@@ -58,11 +69,26 @@ static long __init sp804_get_clock_rate(struct clk *clk, const char *name)
 	return rate;
 }
 
-static void __iomem *sched_clock_base;
+static struct sp804_clkevt * __init sp804_clkevt_get(void __iomem *base)
+{
+	int i;
+
+	for (i = 0; i < NR_TIMERS; i++) {
+		if (sp804_clkevt[i].base == base)
+			return &sp804_clkevt[i];
+	}
+
+	/* It's impossible to reach here */
+	WARN_ON(1);
+
+	return NULL;
+}
+
+static struct sp804_clkevt *sched_clkevt;
 
 static u64 notrace sp804_read(void)
 {
-	return ~readl_relaxed(sched_clock_base + TIMER_VALUE);
+	return ~readl_relaxed(sched_clkevt->value);
 }
 
 int __init sp804_clocksource_and_sched_clock_init(void __iomem *base,
@@ -71,22 +97,25 @@ int __init sp804_clocksource_and_sched_clock_init(void __iomem *base,
 						  int use_sched_clock)
 {
 	long rate;
+	struct sp804_clkevt *clkevt;
 
 	rate = sp804_get_clock_rate(clk, name);
 	if (rate < 0)
 		return -EINVAL;
 
-	writel(0, base + TIMER_CTRL);
-	writel(0xffffffff, base + TIMER_LOAD);
-	writel(0xffffffff, base + TIMER_VALUE);
+	clkevt = sp804_clkevt_get(base);
+
+	writel(0, clkevt->ctrl);
+	writel(0xffffffff, clkevt->load);
+	writel(0xffffffff, clkevt->value);
 	writel(TIMER_CTRL_32BIT | TIMER_CTRL_ENABLE | TIMER_CTRL_PERIODIC,
-		base + TIMER_CTRL);
+		clkevt->ctrl);
 
-	clocksource_mmio_init(base + TIMER_VALUE, name,
+	clocksource_mmio_init(clkevt->value, name,
 		rate, 200, 32, clocksource_mmio_readl_down);
 
 	if (use_sched_clock) {
-		sched_clock_base = base;
+		sched_clkevt = clkevt;
 		sched_clock_register(sp804_read, 32, rate);
 	}
 
@@ -94,8 +123,7 @@ int __init sp804_clocksource_and_sched_clock_init(void __iomem *base,
 }
 
 
-static void __iomem *clkevt_base;
-static unsigned long clkevt_reload;
+static struct sp804_clkevt *common_clkevt;
 
 /*
  * IRQ handler for the timer
@@ -105,7 +133,7 @@ static irqreturn_t sp804_timer_interrupt(int irq, void *dev_id)
 	struct clock_event_device *evt = dev_id;
 
 	/* clear the interrupt */
-	writel(1, clkevt_base + TIMER_INTCLR);
+	writel(1, common_clkevt->intclr);
 
 	evt->event_handler(evt);
 
@@ -114,7 +142,7 @@ static irqreturn_t sp804_timer_interrupt(int irq, void *dev_id)
 
 static inline void timer_shutdown(struct clock_event_device *evt)
 {
-	writel(0, clkevt_base + TIMER_CTRL);
+	writel(0, common_clkevt->ctrl);
 }
 
 static int sp804_shutdown(struct clock_event_device *evt)
@@ -129,8 +157,8 @@ static int sp804_set_periodic(struct clock_event_device *evt)
 			     TIMER_CTRL_PERIODIC | TIMER_CTRL_ENABLE;
 
 	timer_shutdown(evt);
-	writel(clkevt_reload, clkevt_base + TIMER_LOAD);
-	writel(ctrl, clkevt_base + TIMER_CTRL);
+	writel(common_clkevt->reload, common_clkevt->load);
+	writel(ctrl, common_clkevt->ctrl);
 	return 0;
 }
 
@@ -140,8 +168,8 @@ static int sp804_set_next_event(unsigned long next,
 	unsigned long ctrl = TIMER_CTRL_32BIT | TIMER_CTRL_IE |
 			     TIMER_CTRL_ONESHOT | TIMER_CTRL_ENABLE;
 
-	writel(next, clkevt_base + TIMER_LOAD);
-	writel(ctrl, clkevt_base + TIMER_CTRL);
+	writel(next, common_clkevt->load);
+	writel(ctrl, common_clkevt->ctrl);
 
 	return 0;
 }
@@ -168,13 +196,13 @@ int __init sp804_clockevents_init(void __iomem *base, unsigned int irq,
 	if (rate < 0)
 		return -EINVAL;
 
-	clkevt_base = base;
-	clkevt_reload = DIV_ROUND_CLOSEST(rate, HZ);
+	common_clkevt = sp804_clkevt_get(base);
+	common_clkevt->reload = DIV_ROUND_CLOSEST(rate, HZ);
 	evt->name = name;
 	evt->irq = irq;
 	evt->cpumask = cpu_possible_mask;
 
-	writel(0, base + TIMER_CTRL);
+	writel(0, common_clkevt->ctrl);
 
 	if (request_irq(irq, sp804_timer_interrupt, IRQF_TIMER | IRQF_IRQPOLL,
 			"timer", &sp804_clockevent))
@@ -184,7 +212,26 @@ int __init sp804_clockevents_init(void __iomem *base, unsigned int irq,
 	return 0;
 }
 
-static int __init sp804_of_init(struct device_node *np)
+static void __init sp804_clkevt_init(struct sp804_timer *timer, void __iomem *base)
+{
+	int i;
+
+	for (i = 0; i < NR_TIMERS; i++) {
+		void __iomem *timer_base;
+		struct sp804_clkevt *clkevt;
+
+		timer_base = base + timer->timer_base[i];
+		clkevt = &sp804_clkevt[i];
+		clkevt->base	= timer_base;
+		clkevt->load	= timer_base + timer->load;
+		clkevt->value	= timer_base + timer->value;
+		clkevt->ctrl	= timer_base + timer->ctrl;
+		clkevt->intclr	= timer_base + timer->intclr;
+		clkevt->width	= timer->width;
+	}
+}
+
+static int __init sp804_of_init(struct device_node *np, struct sp804_timer *timer)
 {
 	static bool initialized = false;
 	void __iomem *base;
@@ -199,12 +246,12 @@ static int __init sp804_of_init(struct device_node *np)
 	if (!base)
 		return -ENXIO;
 
-	timer1_base = base;
-	timer2_base = base + TIMER_2_BASE;
+	timer1_base = base + timer->timer_base[0];
+	timer2_base = base + timer->timer_base[1];
 
 	/* Ensure timers are disabled */
-	writel(0, timer1_base + TIMER_CTRL);
-	writel(0, timer2_base + TIMER_CTRL);
+	writel(0, timer1_base + timer->ctrl);
+	writel(0, timer2_base + timer->ctrl);
 
 	if (initialized || !of_device_is_available(np)) {
 		ret = -EINVAL;
@@ -230,6 +277,8 @@ static int __init sp804_of_init(struct device_node *np)
 	if (irq <= 0)
 		goto err;
 
+	sp804_clkevt_init(timer, base);
+
 	of_property_read_u32(np, "arm,sp804-has-irq", &irq_num);
 	if (irq_num == 2) {
 
@@ -259,7 +308,12 @@ err:
 	iounmap(base);
 	return ret;
 }
-TIMER_OF_DECLARE(sp804, "arm,sp804", sp804_of_init);
+
+static int __init arm_sp804_of_init(struct device_node *np)
+{
+	return sp804_of_init(np, &arm_sp804_timer);
+}
+TIMER_OF_DECLARE(sp804, "arm,sp804", arm_sp804_of_init);
 
 static int __init integrator_cp_of_init(struct device_node *np)
 {
@@ -282,11 +336,13 @@ static int __init integrator_cp_of_init(struct device_node *np)
 	}
 
 	/* Ensure timer is disabled */
-	writel(0, base + TIMER_CTRL);
+	writel(0, base + arm_sp804_timer.ctrl);
 
 	if (init_count == 2 || !of_device_is_available(np))
 		goto err;
 
+	sp804_clkevt_init(&arm_sp804_timer, base);
+
 	if (!init_count) {
 		ret = sp804_clocksource_and_sched_clock_init(base,
 							     name, clk, 0);
