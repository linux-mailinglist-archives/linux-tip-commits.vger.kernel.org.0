Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 28C2618AEB0
	for <lists+linux-tip-commits@lfdr.de>; Thu, 19 Mar 2020 09:48:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727365AbgCSIsr (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Thu, 19 Mar 2020 04:48:47 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:59763 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727035AbgCSIsE (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Thu, 19 Mar 2020 04:48:04 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jEqqK-00030E-DD; Thu, 19 Mar 2020 09:47:56 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 08A391C2299;
        Thu, 19 Mar 2020 09:47:51 +0100 (CET)
Date:   Thu, 19 Mar 2020 08:47:50 -0000
From:   "tip-bot2 for afzal mohammed" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] clocksource: Replace setup_irq() by request_irq()
Cc:     afzal mohammed <afzal.mohd.ma@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: =?utf-8?q?=3C91961c77c1cf93d41523f5e1ac52043f32f97077=2E15827?=
 =?utf-8?q?99709=2Egit=2Eafzal=2Emohd=2Ema=40gmail=2Ecom=3E?=
References: =?utf-8?q?=3C91961c77c1cf93d41523f5e1ac52043f32f97077=2E158279?=
 =?utf-8?q?9709=2Egit=2Eafzal=2Emohd=2Ema=40gmail=2Ecom=3E?=
MIME-Version: 1.0
Message-ID: <158460767073.28353.11166491089533563548.tip-bot2@tip-bot2>
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

Commit-ID:     cc2550b421aa30e3da67e5a7f6d14f3ecd3527b3
Gitweb:        https://git.kernel.org/tip/cc2550b421aa30e3da67e5a7f6d14f3ecd3527b3
Author:        afzal mohammed <afzal.mohd.ma@gmail.com>
AuthorDate:    Thu, 27 Feb 2020 16:29:02 +05:30
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Thu, 27 Feb 2020 12:15:24 +01:00

clocksource: Replace setup_irq() by request_irq()

request_irq() is preferred over setup_irq(). The early boot setup_irq()
invocations happen either via 'init_IRQ()' or 'time_init()', while
memory allocators are ready by 'mm_init()'.

Per tglx[1], setup_irq() existed in olden days when allocators were not
ready by the time early interrupts were initialized.

Hence replace setup_irq() by request_irq().

Seldom remove_irq() usage has been observed coupled with setup_irq(),
wherever that has been found, it too has been replaced by free_irq().

A build error that was reported by kbuild test robot <lkp@intel.com>
in the previous version of the patch also has been fixed.

[1] https://lkml.kernel.org/r/alpine.DEB.2.20.1710191609480.1971@nanos

Signed-off-by: afzal mohammed <afzal.mohd.ma@gmail.com>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Link: https://lore.kernel.org/r/91961c77c1cf93d41523f5e1ac52043f32f97077.1582799709.git.afzal.mohd.ma@gmail.com
---
 drivers/clocksource/bcm2835_timer.c       |  8 +---
 drivers/clocksource/bcm_kona_timer.c      | 10 +---
 drivers/clocksource/dw_apb_timer.c        | 11 +----
 drivers/clocksource/exynos_mct.c          | 12 +----
 drivers/clocksource/mxs_timer.c           | 10 +----
 drivers/clocksource/nomadik-mtu.c         | 11 +----
 drivers/clocksource/samsung_pwm_timer.c   | 12 +----
 drivers/clocksource/timer-atlas7.c        | 50 ++++++++++------------
 drivers/clocksource/timer-cs5535.c        | 10 +---
 drivers/clocksource/timer-efm32.c         | 10 +----
 drivers/clocksource/timer-fsl-ftm.c       | 10 +----
 drivers/clocksource/timer-imx-gpt.c       | 10 +----
 drivers/clocksource/timer-integrator-ap.c | 11 +----
 drivers/clocksource/timer-meson6.c        | 11 +----
 drivers/clocksource/timer-orion.c         |  9 +----
 drivers/clocksource/timer-prima2.c        | 14 +-----
 drivers/clocksource/timer-pxa.c           | 10 +----
 drivers/clocksource/timer-sp804.c         | 11 +----
 drivers/clocksource/timer-u300.c          |  9 +----
 drivers/clocksource/timer-vf-pit.c        | 10 +----
 drivers/clocksource/timer-vt8500.c        | 11 +----
 drivers/clocksource/timer-zevio.c         | 13 ++----
 include/linux/dw_apb_timer.h              |  1 +-
 23 files changed, 83 insertions(+), 191 deletions(-)

diff --git a/drivers/clocksource/bcm2835_timer.c b/drivers/clocksource/bcm2835_timer.c
index b235f44..1592650 100644
--- a/drivers/clocksource/bcm2835_timer.c
+++ b/drivers/clocksource/bcm2835_timer.c
@@ -31,7 +31,6 @@ struct bcm2835_timer {
 	void __iomem *compare;
 	int match_mask;
 	struct clock_event_device evt;
-	struct irqaction act;
 };
 
 static void __iomem *system_clock __read_mostly;
@@ -113,12 +112,9 @@ static int __init bcm2835_timer_init(struct device_node *node)
 	timer->evt.features = CLOCK_EVT_FEAT_ONESHOT;
 	timer->evt.set_next_event = bcm2835_time_set_next_event;
 	timer->evt.cpumask = cpumask_of(0);
-	timer->act.name = node->name;
-	timer->act.flags = IRQF_TIMER | IRQF_SHARED;
-	timer->act.dev_id = timer;
-	timer->act.handler = bcm2835_time_interrupt;
 
-	ret = setup_irq(irq, &timer->act);
+	ret = request_irq(irq, bcm2835_time_interrupt, IRQF_TIMER | IRQF_SHARED,
+			  node->name, timer);
 	if (ret) {
 		pr_err("Can't set up timer IRQ\n");
 		goto err_timer_free;
diff --git a/drivers/clocksource/bcm_kona_timer.c b/drivers/clocksource/bcm_kona_timer.c
index 5c40be9..a50ab5c 100644
--- a/drivers/clocksource/bcm_kona_timer.c
+++ b/drivers/clocksource/bcm_kona_timer.c
@@ -160,12 +160,6 @@ static irqreturn_t kona_timer_interrupt(int irq, void *dev_id)
 	return IRQ_HANDLED;
 }
 
-static struct irqaction kona_timer_irq = {
-	.name = "Kona Timer Tick",
-	.flags = IRQF_TIMER,
-	.handler = kona_timer_interrupt,
-};
-
 static int __init kona_timer_init(struct device_node *node)
 {
 	u32 freq;
@@ -192,7 +186,9 @@ static int __init kona_timer_init(struct device_node *node)
 	kona_timer_disable_and_clear(timers.tmr_regs);
 
 	kona_timer_clockevents_init();
-	setup_irq(timers.tmr_irq, &kona_timer_irq);
+	if (request_irq(timers.tmr_irq, kona_timer_interrupt, IRQF_TIMER,
+			"Kona Timer Tick", NULL))
+		pr_err("%s: request_irq() failed\n", "Kona Timer Tick");
 	kona_timer_set_next_event((arch_timer_rate / HZ), NULL);
 
 	return 0;
diff --git a/drivers/clocksource/dw_apb_timer.c b/drivers/clocksource/dw_apb_timer.c
index 6547665..b207a77 100644
--- a/drivers/clocksource/dw_apb_timer.c
+++ b/drivers/clocksource/dw_apb_timer.c
@@ -270,15 +270,10 @@ dw_apb_clockevent_init(int cpu, const char *name, unsigned rating,
 	dw_ced->ced.rating = rating;
 	dw_ced->ced.name = name;
 
-	dw_ced->irqaction.name		= dw_ced->ced.name;
-	dw_ced->irqaction.handler	= dw_apb_clockevent_irq;
-	dw_ced->irqaction.dev_id	= &dw_ced->ced;
-	dw_ced->irqaction.irq		= irq;
-	dw_ced->irqaction.flags		= IRQF_TIMER | IRQF_IRQPOLL |
-					  IRQF_NOBALANCING;
-
 	dw_ced->eoi = apbt_eoi;
-	err = setup_irq(irq, &dw_ced->irqaction);
+	err = request_irq(irq, dw_apb_clockevent_irq,
+			  IRQF_TIMER | IRQF_IRQPOLL | IRQF_NOBALANCING,
+			  dw_ced->ced.name, &dw_ced->ced);
 	if (err) {
 		pr_err("failed to request timer irq\n");
 		kfree(dw_ced);
diff --git a/drivers/clocksource/exynos_mct.c b/drivers/clocksource/exynos_mct.c
index a267fe3..fabad79 100644
--- a/drivers/clocksource/exynos_mct.c
+++ b/drivers/clocksource/exynos_mct.c
@@ -329,19 +329,15 @@ static irqreturn_t exynos4_mct_comp_isr(int irq, void *dev_id)
 	return IRQ_HANDLED;
 }
 
-static struct irqaction mct_comp_event_irq = {
-	.name		= "mct_comp_irq",
-	.flags		= IRQF_TIMER | IRQF_IRQPOLL,
-	.handler	= exynos4_mct_comp_isr,
-	.dev_id		= &mct_comp_device,
-};
-
 static int exynos4_clockevent_init(void)
 {
 	mct_comp_device.cpumask = cpumask_of(0);
 	clockevents_config_and_register(&mct_comp_device, clk_rate,
 					0xf, 0xffffffff);
-	setup_irq(mct_irqs[MCT_G0_IRQ], &mct_comp_event_irq);
+	if (request_irq(mct_irqs[MCT_G0_IRQ], exynos4_mct_comp_isr,
+			IRQF_TIMER | IRQF_IRQPOLL, "mct_comp_irq",
+			&mct_comp_device))
+		pr_err("%s: request_irq() failed\n", "mct_comp_irq");
 
 	return 0;
 }
diff --git a/drivers/clocksource/mxs_timer.c b/drivers/clocksource/mxs_timer.c
index f6ddae3..bc96a4c 100644
--- a/drivers/clocksource/mxs_timer.c
+++ b/drivers/clocksource/mxs_timer.c
@@ -117,13 +117,6 @@ static irqreturn_t mxs_timer_interrupt(int irq, void *dev_id)
 	return IRQ_HANDLED;
 }
 
-static struct irqaction mxs_timer_irq = {
-	.name		= "MXS Timer Tick",
-	.dev_id		= &mxs_clockevent_device,
-	.flags		= IRQF_TIMER | IRQF_IRQPOLL,
-	.handler	= mxs_timer_interrupt,
-};
-
 static void mxs_irq_clear(char *state)
 {
 	/* Disable interrupt in timer module */
@@ -277,6 +270,7 @@ static int __init mxs_timer_init(struct device_node *np)
 	if (irq <= 0)
 		return -EINVAL;
 
-	return setup_irq(irq, &mxs_timer_irq);
+	return request_irq(irq, mxs_timer_interrupt, IRQF_TIMER | IRQF_IRQPOLL,
+			   "MXS Timer Tick", &mxs_clockevent_device);
 }
 TIMER_OF_DECLARE(mxs, "fsl,timrot", mxs_timer_init);
diff --git a/drivers/clocksource/nomadik-mtu.c b/drivers/clocksource/nomadik-mtu.c
index 3f7fa8c..f49a631 100644
--- a/drivers/clocksource/nomadik-mtu.c
+++ b/drivers/clocksource/nomadik-mtu.c
@@ -181,13 +181,6 @@ static irqreturn_t nmdk_timer_interrupt(int irq, void *dev_id)
 	return IRQ_HANDLED;
 }
 
-static struct irqaction nmdk_timer_irq = {
-	.name		= "Nomadik Timer Tick",
-	.flags		= IRQF_TIMER,
-	.handler	= nmdk_timer_interrupt,
-	.dev_id		= &nmdk_clkevt,
-};
-
 static int __init nmdk_timer_init(void __iomem *base, int irq,
 				   struct clk *pclk, struct clk *clk)
 {
@@ -232,7 +225,9 @@ static int __init nmdk_timer_init(void __iomem *base, int irq,
 	sched_clock_register(nomadik_read_sched_clock, 32, rate);
 
 	/* Timer 1 is used for events, register irq and clockevents */
-	setup_irq(irq, &nmdk_timer_irq);
+	if (request_irq(irq, nmdk_timer_interrupt, IRQF_TIMER,
+			"Nomadik Timer Tick", &nmdk_clkevt))
+		pr_err("%s: request_irq() failed\n", "Nomadik Timer Tick");
 	nmdk_clkevt.cpumask = cpumask_of(0);
 	nmdk_clkevt.irq = irq;
 	clockevents_config_and_register(&nmdk_clkevt, rate, 2, 0xffffffffU);
diff --git a/drivers/clocksource/samsung_pwm_timer.c b/drivers/clocksource/samsung_pwm_timer.c
index dae1b2b..f760229 100644
--- a/drivers/clocksource/samsung_pwm_timer.c
+++ b/drivers/clocksource/samsung_pwm_timer.c
@@ -256,13 +256,6 @@ static irqreturn_t samsung_clock_event_isr(int irq, void *dev_id)
 	return IRQ_HANDLED;
 }
 
-static struct irqaction samsung_clock_event_irq = {
-	.name		= "samsung_time_irq",
-	.flags		= IRQF_TIMER | IRQF_IRQPOLL,
-	.handler	= samsung_clock_event_isr,
-	.dev_id		= &time_event_device,
-};
-
 static void __init samsung_clockevent_init(void)
 {
 	unsigned long pclk;
@@ -282,7 +275,10 @@ static void __init samsung_clockevent_init(void)
 						clock_rate, 1, pwm.tcnt_max);
 
 	irq_number = pwm.irq[pwm.event_id];
-	setup_irq(irq_number, &samsung_clock_event_irq);
+	if (request_irq(irq_number, samsung_clock_event_isr,
+			IRQF_TIMER | IRQF_IRQPOLL, "samsung_time_irq",
+			&time_event_device))
+		pr_err("%s: request_irq() failed\n", "samsung_time_irq");
 
 	if (pwm.variant.has_tint_cstat) {
 		u32 mask = (1 << pwm.event_id);
diff --git a/drivers/clocksource/timer-atlas7.c b/drivers/clocksource/timer-atlas7.c
index 93c3ac6..c21c91c 100644
--- a/drivers/clocksource/timer-atlas7.c
+++ b/drivers/clocksource/timer-atlas7.c
@@ -159,29 +159,23 @@ static struct clocksource sirfsoc_clocksource = {
 	.resume = sirfsoc_clocksource_resume,
 };
 
-static struct irqaction sirfsoc_timer_irq = {
-	.name = "sirfsoc_timer0",
-	.flags = IRQF_TIMER | IRQF_NOBALANCING,
-	.handler = sirfsoc_timer_interrupt,
-};
-
-static struct irqaction sirfsoc_timer1_irq = {
-	.name = "sirfsoc_timer1",
-	.flags = IRQF_TIMER | IRQF_NOBALANCING,
-	.handler = sirfsoc_timer_interrupt,
-};
+static unsigned int sirfsoc_timer_irq, sirfsoc_timer1_irq;
 
 static int sirfsoc_local_timer_starting_cpu(unsigned int cpu)
 {
 	struct clock_event_device *ce = per_cpu_ptr(sirfsoc_clockevent, cpu);
-	struct irqaction *action;
-
-	if (cpu == 0)
-		action = &sirfsoc_timer_irq;
-	else
-		action = &sirfsoc_timer1_irq;
+	unsigned int irq;
+	const char *name;
+
+	if (cpu == 0) {
+		irq = sirfsoc_timer_irq;
+		name = "sirfsoc_timer0";
+	} else {
+		irq = sirfsoc_timer1_irq;
+		name = "sirfsoc_timer1";
+	}
 
-	ce->irq = action->irq;
+	ce->irq = irq;
 	ce->name = "local_timer";
 	ce->features = CLOCK_EVT_FEAT_ONESHOT;
 	ce->rating = 200;
@@ -196,9 +190,9 @@ static int sirfsoc_local_timer_starting_cpu(unsigned int cpu)
 	ce->min_delta_ticks = 2;
 	ce->cpumask = cpumask_of(cpu);
 
-	action->dev_id = ce;
-	BUG_ON(setup_irq(ce->irq, action));
-	irq_force_affinity(action->irq, cpumask_of(cpu));
+	BUG_ON(request_irq(ce->irq, sirfsoc_timer_interrupt,
+			   IRQF_TIMER | IRQF_NOBALANCING, name, ce));
+	irq_force_affinity(ce->irq, cpumask_of(cpu));
 
 	clockevents_register_device(ce);
 	return 0;
@@ -206,12 +200,14 @@ static int sirfsoc_local_timer_starting_cpu(unsigned int cpu)
 
 static int sirfsoc_local_timer_dying_cpu(unsigned int cpu)
 {
+	struct clock_event_device *ce = per_cpu_ptr(sirfsoc_clockevent, cpu);
+
 	sirfsoc_timer_count_disable(1);
 
 	if (cpu == 0)
-		remove_irq(sirfsoc_timer_irq.irq, &sirfsoc_timer_irq);
+		free_irq(sirfsoc_timer_irq, ce);
 	else
-		remove_irq(sirfsoc_timer1_irq.irq, &sirfsoc_timer1_irq);
+		free_irq(sirfsoc_timer1_irq, ce);
 	return 0;
 }
 
@@ -268,14 +264,14 @@ static int __init sirfsoc_of_timer_init(struct device_node *np)
 		return -ENXIO;
 	}
 
-	sirfsoc_timer_irq.irq = irq_of_parse_and_map(np, 0);
-	if (!sirfsoc_timer_irq.irq) {
+	sirfsoc_timer_irq = irq_of_parse_and_map(np, 0);
+	if (!sirfsoc_timer_irq) {
 		pr_err("No irq passed for timer0 via DT\n");
 		return -EINVAL;
 	}
 
-	sirfsoc_timer1_irq.irq = irq_of_parse_and_map(np, 1);
-	if (!sirfsoc_timer1_irq.irq) {
+	sirfsoc_timer1_irq = irq_of_parse_and_map(np, 1);
+	if (!sirfsoc_timer1_irq) {
 		pr_err("No irq passed for timer1 via DT\n");
 		return -EINVAL;
 	}
diff --git a/drivers/clocksource/timer-cs5535.c b/drivers/clocksource/timer-cs5535.c
index 8f6bc53..51ea050 100644
--- a/drivers/clocksource/timer-cs5535.c
+++ b/drivers/clocksource/timer-cs5535.c
@@ -131,12 +131,6 @@ static irqreturn_t mfgpt_tick(int irq, void *dev_id)
 	return IRQ_HANDLED;
 }
 
-static struct irqaction mfgptirq  = {
-	.handler = mfgpt_tick,
-	.flags = IRQF_NOBALANCING | IRQF_TIMER | IRQF_SHARED,
-	.name = DRV_NAME,
-};
-
 static int __init cs5535_mfgpt_init(void)
 {
 	struct cs5535_mfgpt_timer *timer;
@@ -158,7 +152,9 @@ static int __init cs5535_mfgpt_init(void)
 	}
 
 	/* And register it with the kernel */
-	ret = setup_irq(timer_irq, &mfgptirq);
+	ret = request_irq(timer_irq, mfgpt_tick,
+			  IRQF_NOBALANCING | IRQF_TIMER | IRQF_SHARED,
+			  DRV_NAME, NULL);
 	if (ret) {
 		printk(KERN_ERR DRV_NAME ": Unable to set up the interrupt.\n");
 		goto err_irq;
diff --git a/drivers/clocksource/timer-efm32.c b/drivers/clocksource/timer-efm32.c
index 5a22cb0..441a4b9 100644
--- a/drivers/clocksource/timer-efm32.c
+++ b/drivers/clocksource/timer-efm32.c
@@ -119,13 +119,6 @@ static struct efm32_clock_event_ddata clock_event_ddata = {
 	},
 };
 
-static struct irqaction efm32_clock_event_irq = {
-	.name = "efm32 clockevent",
-	.flags = IRQF_TIMER,
-	.handler = efm32_clock_event_handler,
-	.dev_id = &clock_event_ddata,
-};
-
 static int __init efm32_clocksource_init(struct device_node *np)
 {
 	struct clk *clk;
@@ -230,7 +223,8 @@ static int __init efm32_clockevent_init(struct device_node *np)
 					DIV_ROUND_CLOSEST(rate, 1024),
 					0xf, 0xffff);
 
-	ret = setup_irq(irq, &efm32_clock_event_irq);
+	ret = request_irq(irq, efm32_clock_event_handler, IRQF_TIMER,
+			  "efm32 clockevent", &clock_event_ddata);
 	if (ret) {
 		pr_err("Failed setup irq\n");
 		goto err_setup_irq;
diff --git a/drivers/clocksource/timer-fsl-ftm.c b/drivers/clocksource/timer-fsl-ftm.c
index a9d9a3c..12a2ed7 100644
--- a/drivers/clocksource/timer-fsl-ftm.c
+++ b/drivers/clocksource/timer-fsl-ftm.c
@@ -176,13 +176,6 @@ static struct clock_event_device ftm_clockevent = {
 	.rating			= 300,
 };
 
-static struct irqaction ftm_timer_irq = {
-	.name		= "Freescale ftm timer",
-	.flags		= IRQF_TIMER | IRQF_IRQPOLL,
-	.handler	= ftm_evt_interrupt,
-	.dev_id		= &ftm_clockevent,
-};
-
 static int __init ftm_clockevent_init(unsigned long freq, int irq)
 {
 	int err;
@@ -192,7 +185,8 @@ static int __init ftm_clockevent_init(unsigned long freq, int irq)
 
 	ftm_reset_counter(priv->clkevt_base);
 
-	err = setup_irq(irq, &ftm_timer_irq);
+	err = request_irq(irq, ftm_evt_interrupt, IRQF_TIMER | IRQF_IRQPOLL,
+			  "Freescale ftm timer", &ftm_clockevent);
 	if (err) {
 		pr_err("ftm: setup irq failed: %d\n", err);
 		return err;
diff --git a/drivers/clocksource/timer-imx-gpt.c b/drivers/clocksource/timer-imx-gpt.c
index 706c0d0..7b2c70f 100644
--- a/drivers/clocksource/timer-imx-gpt.c
+++ b/drivers/clocksource/timer-imx-gpt.c
@@ -67,7 +67,6 @@ struct imx_timer {
 	struct clk *clk_ipg;
 	const struct imx_gpt_data *gpt;
 	struct clock_event_device ced;
-	struct irqaction act;
 };
 
 struct imx_gpt_data {
@@ -273,7 +272,6 @@ static irqreturn_t mxc_timer_interrupt(int irq, void *dev_id)
 static int __init mxc_clockevent_init(struct imx_timer *imxtm)
 {
 	struct clock_event_device *ced = &imxtm->ced;
-	struct irqaction *act = &imxtm->act;
 
 	ced->name = "mxc_timer1";
 	ced->features = CLOCK_EVT_FEAT_ONESHOT | CLOCK_EVT_FEAT_DYNIRQ;
@@ -287,12 +285,8 @@ static int __init mxc_clockevent_init(struct imx_timer *imxtm)
 	clockevents_config_and_register(ced, clk_get_rate(imxtm->clk_per),
 					0xff, 0xfffffffe);
 
-	act->name = "i.MX Timer Tick";
-	act->flags = IRQF_TIMER | IRQF_IRQPOLL;
-	act->handler = mxc_timer_interrupt;
-	act->dev_id = ced;
-
-	return setup_irq(imxtm->irq, act);
+	return request_irq(imxtm->irq, mxc_timer_interrupt,
+			   IRQF_TIMER | IRQF_IRQPOLL, "i.MX Timer Tick", ced);
 }
 
 static void imx1_gpt_setup_tctl(struct imx_timer *imxtm)
diff --git a/drivers/clocksource/timer-integrator-ap.c b/drivers/clocksource/timer-integrator-ap.c
index c90a69c..b0fcbaa 100644
--- a/drivers/clocksource/timer-integrator-ap.c
+++ b/drivers/clocksource/timer-integrator-ap.c
@@ -123,13 +123,6 @@ static struct clock_event_device integrator_clockevent = {
 	.rating			= 300,
 };
 
-static struct irqaction integrator_timer_irq = {
-	.name		= "timer",
-	.flags		= IRQF_TIMER | IRQF_IRQPOLL,
-	.handler	= integrator_timer_interrupt,
-	.dev_id		= &integrator_clockevent,
-};
-
 static int integrator_clockevent_init(unsigned long inrate,
 				      void __iomem *base, int irq)
 {
@@ -149,7 +142,9 @@ static int integrator_clockevent_init(unsigned long inrate,
 	timer_reload = rate / HZ;
 	writel(ctrl, clkevt_base + TIMER_CTRL);
 
-	ret = setup_irq(irq, &integrator_timer_irq);
+	ret = request_irq(irq, integrator_timer_interrupt,
+			  IRQF_TIMER | IRQF_IRQPOLL, "timer",
+			  &integrator_clockevent);
 	if (ret)
 		return ret;
 
diff --git a/drivers/clocksource/timer-meson6.c b/drivers/clocksource/timer-meson6.c
index 9e8b467..99f5510 100644
--- a/drivers/clocksource/timer-meson6.c
+++ b/drivers/clocksource/timer-meson6.c
@@ -150,13 +150,6 @@ static irqreturn_t meson6_timer_interrupt(int irq, void *dev_id)
 	return IRQ_HANDLED;
 }
 
-static struct irqaction meson6_timer_irq = {
-	.name		= "meson6_timer",
-	.flags		= IRQF_TIMER | IRQF_IRQPOLL,
-	.handler	= meson6_timer_interrupt,
-	.dev_id		= &meson6_clockevent,
-};
-
 static int __init meson6_timer_init(struct device_node *node)
 {
 	u32 val;
@@ -194,7 +187,9 @@ static int __init meson6_timer_init(struct device_node *node)
 	/* Stop the timer A */
 	meson6_clkevt_time_stop();
 
-	ret = setup_irq(irq, &meson6_timer_irq);
+	ret = request_irq(irq, meson6_timer_interrupt,
+			  IRQF_TIMER | IRQF_IRQPOLL, "meson6_timer",
+			  &meson6_clockevent);
 	if (ret) {
 		pr_warn("failed to setup irq %d\n", irq);
 		return ret;
diff --git a/drivers/clocksource/timer-orion.c b/drivers/clocksource/timer-orion.c
index 7d48710..d01ff41 100644
--- a/drivers/clocksource/timer-orion.c
+++ b/drivers/clocksource/timer-orion.c
@@ -114,12 +114,6 @@ static irqreturn_t orion_clkevt_irq_handler(int irq, void *dev_id)
 	return IRQ_HANDLED;
 }
 
-static struct irqaction orion_clkevt_irq = {
-	.name		= "orion_event",
-	.flags		= IRQF_TIMER,
-	.handler	= orion_clkevt_irq_handler,
-};
-
 static int __init orion_timer_init(struct device_node *np)
 {
 	unsigned long rate;
@@ -172,7 +166,8 @@ static int __init orion_timer_init(struct device_node *np)
 	sched_clock_register(orion_read_sched_clock, 32, rate);
 
 	/* setup timer1 as clockevent timer */
-	ret = setup_irq(irq, &orion_clkevt_irq);
+	ret = request_irq(irq, orion_clkevt_irq_handler, IRQF_TIMER,
+			  "orion_event", NULL);
 	if (ret) {
 		pr_err("%pOFn: unable to setup irq\n", np);
 		return ret;
diff --git a/drivers/clocksource/timer-prima2.c b/drivers/clocksource/timer-prima2.c
index d4a9dcf..c5d4693 100644
--- a/drivers/clocksource/timer-prima2.c
+++ b/drivers/clocksource/timer-prima2.c
@@ -165,14 +165,6 @@ static struct clocksource sirfsoc_clocksource = {
 	.resume = sirfsoc_clocksource_resume,
 };
 
-static struct irqaction sirfsoc_timer_irq = {
-	.name = "sirfsoc_timer0",
-	.flags = IRQF_TIMER,
-	.irq = 0,
-	.handler = sirfsoc_timer_interrupt,
-	.dev_id = &sirfsoc_clockevent,
-};
-
 /* Overwrite weak default sched_clock with more precise one */
 static u64 notrace sirfsoc_read_sched_clock(void)
 {
@@ -190,6 +182,7 @@ static void __init sirfsoc_clockevent_init(void)
 static int __init sirfsoc_prima2_timer_init(struct device_node *np)
 {
 	unsigned long rate;
+	unsigned int irq;
 	struct clk *clk;
 	int ret;
 
@@ -218,7 +211,7 @@ static int __init sirfsoc_prima2_timer_init(struct device_node *np)
 		return -ENXIO;
 	}
 
-	sirfsoc_timer_irq.irq = irq_of_parse_and_map(np, 0);
+	irq = irq_of_parse_and_map(np, 0);
 
 	writel_relaxed(rate / PRIMA2_CLOCK_FREQ / 2 - 1,
 		sirfsoc_timer_base + SIRFSOC_TIMER_DIV);
@@ -234,7 +227,8 @@ static int __init sirfsoc_prima2_timer_init(struct device_node *np)
 
 	sched_clock_register(sirfsoc_read_sched_clock, 64, PRIMA2_CLOCK_FREQ);
 
-	ret = setup_irq(sirfsoc_timer_irq.irq, &sirfsoc_timer_irq);
+	ret = request_irq(irq, sirfsoc_timer_interrupt, IRQF_TIMER,
+			  "sirfsoc_timer0", &sirfsoc_clockevent);
 	if (ret) {
 		pr_err("Failed to setup irq\n");
 		return ret;
diff --git a/drivers/clocksource/timer-pxa.c b/drivers/clocksource/timer-pxa.c
index 913a5d3..7ad0e5a 100644
--- a/drivers/clocksource/timer-pxa.c
+++ b/drivers/clocksource/timer-pxa.c
@@ -143,13 +143,6 @@ static struct clock_event_device ckevt_pxa_osmr0 = {
 	.resume			= pxa_timer_resume,
 };
 
-static struct irqaction pxa_ost0_irq = {
-	.name		= "ost0",
-	.flags		= IRQF_TIMER | IRQF_IRQPOLL,
-	.handler	= pxa_ost0_interrupt,
-	.dev_id		= &ckevt_pxa_osmr0,
-};
-
 static int __init pxa_timer_common_init(int irq, unsigned long clock_tick_rate)
 {
 	int ret;
@@ -161,7 +154,8 @@ static int __init pxa_timer_common_init(int irq, unsigned long clock_tick_rate)
 
 	ckevt_pxa_osmr0.cpumask = cpumask_of(0);
 
-	ret = setup_irq(irq, &pxa_ost0_irq);
+	ret = request_irq(irq, pxa_ost0_interrupt, IRQF_TIMER | IRQF_IRQPOLL,
+			  "ost0", &ckevt_pxa_osmr0);
 	if (ret) {
 		pr_err("Failed to setup irq\n");
 		return ret;
diff --git a/drivers/clocksource/timer-sp804.c b/drivers/clocksource/timer-sp804.c
index 9c84198..5cd0abf 100644
--- a/drivers/clocksource/timer-sp804.c
+++ b/drivers/clocksource/timer-sp804.c
@@ -168,13 +168,6 @@ static struct clock_event_device sp804_clockevent = {
 	.rating			= 300,
 };
 
-static struct irqaction sp804_timer_irq = {
-	.name		= "timer",
-	.flags		= IRQF_TIMER | IRQF_IRQPOLL,
-	.handler	= sp804_timer_interrupt,
-	.dev_id		= &sp804_clockevent,
-};
-
 int __init __sp804_clockevents_init(void __iomem *base, unsigned int irq, struct clk *clk, const char *name)
 {
 	struct clock_event_device *evt = &sp804_clockevent;
@@ -200,7 +193,9 @@ int __init __sp804_clockevents_init(void __iomem *base, unsigned int irq, struct
 
 	writel(0, base + TIMER_CTRL);
 
-	setup_irq(irq, &sp804_timer_irq);
+	if (request_irq(irq, sp804_timer_interrupt, IRQF_TIMER | IRQF_IRQPOLL,
+			"timer", &sp804_clockevent))
+		pr_err("%s: request_irq() failed\n", "timer");
 	clockevents_config_and_register(evt, rate, 0xf, 0xffffffff);
 
 	return 0;
diff --git a/drivers/clocksource/timer-u300.c b/drivers/clocksource/timer-u300.c
index 32adc30..37cba8d 100644
--- a/drivers/clocksource/timer-u300.c
+++ b/drivers/clocksource/timer-u300.c
@@ -330,12 +330,6 @@ static irqreturn_t u300_timer_interrupt(int irq, void *dev_id)
 	return IRQ_HANDLED;
 }
 
-static struct irqaction u300_timer_irq = {
-	.name		= "U300 Timer Tick",
-	.flags		= IRQF_TIMER | IRQF_IRQPOLL,
-	.handler	= u300_timer_interrupt,
-};
-
 /*
  * Override the global weak sched_clock symbol with this
  * local implementation which uses the clocksource to get some
@@ -420,7 +414,8 @@ static int __init u300_timer_init_of(struct device_node *np)
 		u300_timer_base + U300_TIMER_APP_RGPT1);
 
 	/* Set up the IRQ handler */
-	ret = setup_irq(irq, &u300_timer_irq);
+	ret = request_irq(irq, u300_timer_interrupt,
+			  IRQF_TIMER | IRQF_IRQPOLL, "U300 Timer Tick", NULL);
 	if (ret)
 		return ret;
 
diff --git a/drivers/clocksource/timer-vf-pit.c b/drivers/clocksource/timer-vf-pit.c
index fef0bb4..7ad4a8b 100644
--- a/drivers/clocksource/timer-vf-pit.c
+++ b/drivers/clocksource/timer-vf-pit.c
@@ -123,19 +123,13 @@ static struct clock_event_device clockevent_pit = {
 	.rating		= 300,
 };
 
-static struct irqaction pit_timer_irq = {
-	.name		= "VF pit timer",
-	.flags		= IRQF_TIMER | IRQF_IRQPOLL,
-	.handler	= pit_timer_interrupt,
-	.dev_id		= &clockevent_pit,
-};
-
 static int __init pit_clockevent_init(unsigned long rate, int irq)
 {
 	__raw_writel(0, clkevt_base + PITTCTRL);
 	__raw_writel(PITTFLG_TIF, clkevt_base + PITTFLG);
 
-	BUG_ON(setup_irq(irq, &pit_timer_irq));
+	BUG_ON(request_irq(irq, pit_timer_interrupt, IRQF_TIMER | IRQF_IRQPOLL,
+			   "VF pit timer", &clockevent_pit);
 
 	clockevent_pit.cpumask = cpumask_of(0);
 	clockevent_pit.irq = irq;
diff --git a/drivers/clocksource/timer-vt8500.c b/drivers/clocksource/timer-vt8500.c
index bb424bc..a469b1b 100644
--- a/drivers/clocksource/timer-vt8500.c
+++ b/drivers/clocksource/timer-vt8500.c
@@ -101,13 +101,6 @@ static irqreturn_t vt8500_timer_interrupt(int irq, void *dev_id)
 	return IRQ_HANDLED;
 }
 
-static struct irqaction irq = {
-	.name    = "vt8500_timer",
-	.flags   = IRQF_TIMER | IRQF_IRQPOLL,
-	.handler = vt8500_timer_interrupt,
-	.dev_id  = &clockevent,
-};
-
 static int __init vt8500_timer_init(struct device_node *np)
 {
 	int timer_irq, ret;
@@ -139,7 +132,9 @@ static int __init vt8500_timer_init(struct device_node *np)
 
 	clockevent.cpumask = cpumask_of(0);
 
-	ret = setup_irq(timer_irq, &irq);
+	ret = request_irq(timer_irq, vt8500_timer_interrupt,
+			  IRQF_TIMER | IRQF_IRQPOLL, "vt8500_timer",
+			  &clockevent);
 	if (ret) {
 		pr_err("%s: setup_irq failed for %s\n", __func__,
 							clockevent.name);
diff --git a/drivers/clocksource/timer-zevio.c b/drivers/clocksource/timer-zevio.c
index c004156..ecaa356 100644
--- a/drivers/clocksource/timer-zevio.c
+++ b/drivers/clocksource/timer-zevio.c
@@ -53,7 +53,6 @@ struct zevio_timer {
 
 	struct clk *clk;
 	struct clock_event_device clkevt;
-	struct irqaction clkevt_irq;
 
 	char clocksource_name[64];
 	char clockevent_name[64];
@@ -172,12 +171,12 @@ static int __init zevio_timer_add(struct device_node *node)
 		/* Interrupt to occur when timer value matches 0 */
 		writel(0, timer->base + IO_MATCH(TIMER_MATCH));
 
-		timer->clkevt_irq.name		= timer->clockevent_name;
-		timer->clkevt_irq.handler	= zevio_timer_interrupt;
-		timer->clkevt_irq.dev_id	= timer;
-		timer->clkevt_irq.flags		= IRQF_TIMER | IRQF_IRQPOLL;
-
-		setup_irq(irqnr, &timer->clkevt_irq);
+		if (request_irq(irqnr, zevio_timer_interrupt,
+				IRQF_TIMER | IRQF_IRQPOLL,
+				timer->clockevent_name, timer)) {
+			pr_err("%s: request_irq() failed\n",
+			       timer->clockevent_name);
+		}
 
 		clockevents_config_and_register(&timer->clkevt,
 				clk_get_rate(timer->clk), 0x0001, 0xffff);
diff --git a/include/linux/dw_apb_timer.h b/include/linux/dw_apb_timer.h
index 14f072e..82ebf92 100644
--- a/include/linux/dw_apb_timer.h
+++ b/include/linux/dw_apb_timer.h
@@ -25,7 +25,6 @@ struct dw_apb_timer {
 struct dw_apb_clock_event_device {
 	struct clock_event_device		ced;
 	struct dw_apb_timer			timer;
-	struct irqaction			irqaction;
 	void					(*eoi)(struct dw_apb_timer *);
 };
 
