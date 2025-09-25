Return-Path: <linux-tip-commits+bounces-6740-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BBBD5BA1936
	for <lists+linux-tip-commits@lfdr.de>; Thu, 25 Sep 2025 23:36:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 22DA83AE35D
	for <lists+linux-tip-commits@lfdr.de>; Thu, 25 Sep 2025 21:35:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B596327A3C;
	Thu, 25 Sep 2025 21:33:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="BYXVPtHo";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="aw4HMbGQ"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E918A322767;
	Thu, 25 Sep 2025 21:33:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758836003; cv=none; b=lNOErkThe2GQwN9nD+9tpRou8G6/seMpLCt0icfhcnzQl1rBQXI/459+yUSVMCeUIXK7ALxf5SIkPJDlVwd5d7FG4nxBdm4iD+lB05X8Nu5ZyDZU+y+s9USmrGmRrbEnJEL3Avb/DfpQr+TuuSVfRqjLBwzghreCj2Fof3Fdplw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758836003; c=relaxed/simple;
	bh=Isb+vKqG2AYv5ERsuY0s0Ao0fDFkCDmKd0ZGFFwMaJ4=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=LEmevMOclaV7qMvmqGidfl1fZTdvgv7C04uauc1kW0/Zxx3Njhj5rAl2RiYBYkxW24K2fJ2yk9fzgIYxZMvqaK+sMWHYjQ9uCf7Y2XD75lwEareYLzeEfoZSiq1e+CeWcvu/+9bxhTQ9oLtVZIu2CxxU88x3U17lMOr+aBjbTKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=BYXVPtHo; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=aw4HMbGQ; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 25 Sep 2025 21:33:18 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1758835999;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=KJ7Ye+KeEmWrs9B3r2FOHH0YXzS1wVmkZWtaVAQc9cA=;
	b=BYXVPtHo2lOaD0hnMjBqXKiKd4NOJlVZ+dUFx+4gsbGVCc1DcAni0dPpNhsb2BVn5H28XN
	ShfJaV4IF8dwg+nFJP4ryoLCO4JKGljk+MFC1vjQe+X2hQSRlR0TkOVer2voj+9ImA1lZN
	1m/nocbo+uOAUPbLYpIH39XuqrNhWRESQ7qvMV/lJ5fIG8Dmx0CPtqxWwDb1IYtZ11yfTv
	IykT0jEs+RaZoq241PPJIvytAhtFvcKMuyI8e2fDCFX9BTQDZ0zMkdqgDnqAwWATO92jW4
	DZXi7hN9K0tIhYiG/05kd5yO1l8ZbGC4SbgYUyD0a/rqcGE3tjCxMbaKQi/lIg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1758835999;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=KJ7Ye+KeEmWrs9B3r2FOHH0YXzS1wVmkZWtaVAQc9cA=;
	b=aw4HMbGQd570KirkDwMPlW+0y6ZCC+mgpF5VOviTZ8XvVjR7yeg/BCoXuneh806uBldzhp
	9RtJ2yzsbwap28Dg==
From: "tip-bot2 for Daniel Lezcano" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/clocksource] clocksource/drivers/vf-pit: Rename the VF
 PIT to NXP PIT
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175883599825.709179.9670443480489506285.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the timers/clocksource branch of ti=
p:

Commit-ID:     fc346a155fe910a1cf4639b00b131f9a10284bdd
Gitweb:        https://git.kernel.org/tip/fc346a155fe910a1cf4639b00b131f9a102=
84bdd
Author:        Daniel Lezcano <daniel.lezcano@linaro.org>
AuthorDate:    Mon, 04 Aug 2025 17:23:36 +02:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Tue, 23 Sep 2025 12:30:05 +02:00

clocksource/drivers/vf-pit: Rename the VF PIT to NXP PIT

The PIT acronym stands for Periodic Interrupt Timer which is found on
different NXP platforms not only on the Vybrid Family. Change the name
to be more generic for the NXP platforms in general. That will be
consistent with the NXP STM driver naming convention.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Link: https://lore.kernel.org/r/20250804152344.1109310-19-daniel.lezcano@lina=
ro.org
---
 drivers/clocksource/Kconfig         |   9 +-
 drivers/clocksource/Makefile        |   2 +-
 drivers/clocksource/timer-nxp-pit.c | 292 +++++++++++++++++++++++++++-
 drivers/clocksource/timer-vf-pit.c  | 292 +---------------------------
 4 files changed, 299 insertions(+), 296 deletions(-)
 create mode 100644 drivers/clocksource/timer-nxp-pit.c
 delete mode 100644 drivers/clocksource/timer-vf-pit.c

diff --git a/drivers/clocksource/Kconfig b/drivers/clocksource/Kconfig
index 6f7d371..0fd662f 100644
--- a/drivers/clocksource/Kconfig
+++ b/drivers/clocksource/Kconfig
@@ -474,11 +474,14 @@ config FSL_FTM_TIMER
 	help
 	  Support for Freescale FlexTimer Module (FTM) timer.
=20
-config VF_PIT_TIMER
-	bool "Vybrid Family Programmable timer" if COMPILE_TEST
+config NXP_PIT_TIMER
+	bool "NXP Periodic Interrupt Timer" if COMPILE_TEST
 	select CLKSRC_MMIO
 	help
-	  Support for Periodic Interrupt Timer on Freescale Vybrid Family SoCs.
+	  Support for Periodic Interrupt Timer on Freescale / NXP
+	  SoCs. This periodic timer is found on the Vybrid Family and
+	  the Automotive S32G2/3 platforms. It contains 4 channels
+	  where two can be coupled to form a 64 bits channel.
=20
 config SYS_SUPPORTS_SH_CMT
 	bool
diff --git a/drivers/clocksource/Makefile b/drivers/clocksource/Makefile
index 205bf3b..77a0f08 100644
--- a/drivers/clocksource/Makefile
+++ b/drivers/clocksource/Makefile
@@ -49,7 +49,7 @@ obj-$(CONFIG_CLKSRC_LPC32XX)	+=3D timer-lpc32xx.o
 obj-$(CONFIG_CLKSRC_MPS2)	+=3D mps2-timer.o
 obj-$(CONFIG_CLKSRC_SAMSUNG_PWM)	+=3D samsung_pwm_timer.o
 obj-$(CONFIG_FSL_FTM_TIMER)	+=3D timer-fsl-ftm.o
-obj-$(CONFIG_VF_PIT_TIMER)	+=3D timer-vf-pit.o
+obj-$(CONFIG_NXP_PIT_TIMER)	+=3D timer-nxp-pit.o
 obj-$(CONFIG_CLKSRC_QCOM)	+=3D timer-qcom.o
 obj-$(CONFIG_MTK_TIMER)		+=3D timer-mediatek.o
 obj-$(CONFIG_MTK_CPUX_TIMER)	+=3D timer-mediatek-cpux.o
diff --git a/drivers/clocksource/timer-nxp-pit.c b/drivers/clocksource/timer-=
nxp-pit.c
new file mode 100644
index 0000000..2a0ee41
--- /dev/null
+++ b/drivers/clocksource/timer-nxp-pit.c
@@ -0,0 +1,292 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright 2012-2013 Freescale Semiconductor, Inc.
+ */
+
+#include <linux/interrupt.h>
+#include <linux/clockchips.h>
+#include <linux/clk.h>
+#include <linux/of_address.h>
+#include <linux/of_irq.h>
+#include <linux/sched_clock.h>
+
+/*
+ * Each pit takes 0x10 Bytes register space
+ */
+#define PIT0_OFFSET	0x100
+#define PIT_CH(n)       (PIT0_OFFSET + 0x10 * (n))
+
+#define PITMCR(__base)	(__base)
+
+#define PITMCR_FRZ	BIT(0)
+#define PITMCR_MDIS	BIT(1)
+
+#define PITLDVAL(__base)	(__base)
+#define PITTCTRL(__base)	((__base) + 0x08)
+
+#define PITCVAL_OFFSET	0x04
+#define PITCVAL(__base)	((__base) + 0x04)
+
+#define PITTCTRL_TEN			BIT(0)
+#define PITTCTRL_TIE			BIT(1)
+
+#define PITTFLG(__base)	((__base) + 0x0c)
+
+#define PITTFLG_TIF			BIT(0)
+
+struct pit_timer {
+	void __iomem *clksrc_base;
+	void __iomem *clkevt_base;
+	unsigned long cycle_per_jiffy;
+	struct clock_event_device ced;
+	struct clocksource cs;
+};
+
+static void __iomem *sched_clock_base;
+
+static inline struct pit_timer *ced_to_pit(struct clock_event_device *ced)
+{
+	return container_of(ced, struct pit_timer, ced);
+}
+
+static inline struct pit_timer *cs_to_pit(struct clocksource *cs)
+{
+	return container_of(cs, struct pit_timer, cs);
+}
+
+static inline void pit_module_enable(void __iomem *base)
+{
+	writel(0, PITMCR(base));
+}
+
+static inline void pit_module_disable(void __iomem *base)
+{
+	writel(PITMCR_MDIS, PITMCR(base));
+}
+
+static inline void pit_timer_enable(void __iomem *base, bool tie)
+{
+	u32 val =3D PITTCTRL_TEN | (tie ? PITTCTRL_TIE : 0);
+
+	writel(val, PITTCTRL(base));
+}
+
+static inline void pit_timer_disable(void __iomem *base)
+{
+	writel(0, PITTCTRL(base));
+}
+
+static inline void pit_timer_set_counter(void __iomem *base, unsigned int cn=
t)
+{
+	writel(cnt, PITLDVAL(base));
+}
+
+static inline void pit_timer_irqack(struct pit_timer *pit)
+{
+	writel(PITTFLG_TIF, PITTFLG(pit->clkevt_base));
+}
+
+static u64 notrace pit_read_sched_clock(void)
+{
+	return ~readl(sched_clock_base);
+}
+
+static u64 pit_timer_clocksource_read(struct clocksource *cs)
+{
+	struct pit_timer *pit =3D cs_to_pit(cs);
+
+	return (u64)~readl(PITCVAL(pit->clksrc_base));
+}
+
+static int __init pit_clocksource_init(struct pit_timer *pit, const char *na=
me,
+				       void __iomem *base, unsigned long rate)
+{
+	/*
+	 * The channels 0 and 1 can be chained to build a 64-bit
+	 * timer. Let's use the channel 2 as a clocksource and leave
+	 * the channels 0 and 1 unused for anyone else who needs them
+	 */
+	pit->clksrc_base =3D base + PIT_CH(2);
+	pit->cs.name =3D name;
+	pit->cs.rating =3D 300;
+	pit->cs.read =3D pit_timer_clocksource_read;
+	pit->cs.mask =3D CLOCKSOURCE_MASK(32);
+	pit->cs.flags =3D CLOCK_SOURCE_IS_CONTINUOUS;
+
+	/* set the max load value and start the clock source counter */
+	pit_timer_disable(pit->clksrc_base);
+	pit_timer_set_counter(pit->clksrc_base, ~0);
+	pit_timer_enable(pit->clksrc_base, 0);
+
+	sched_clock_base =3D pit->clksrc_base + PITCVAL_OFFSET;
+	sched_clock_register(pit_read_sched_clock, 32, rate);
+
+	return clocksource_register_hz(&pit->cs, rate);
+}
+
+static int pit_set_next_event(unsigned long delta, struct clock_event_device=
 *ced)
+{
+	struct pit_timer *pit =3D ced_to_pit(ced);
+
+	/*
+	 * set a new value to PITLDVAL register will not restart the timer,
+	 * to abort the current cycle and start a timer period with the new
+	 * value, the timer must be disabled and enabled again.
+	 * and the PITLAVAL should be set to delta minus one according to pit
+	 * hardware requirement.
+	 */
+	pit_timer_disable(pit->clkevt_base);
+	pit_timer_set_counter(pit->clkevt_base, delta - 1);
+	pit_timer_enable(pit->clkevt_base, true);
+
+	return 0;
+}
+
+static int pit_shutdown(struct clock_event_device *ced)
+{
+	struct pit_timer *pit =3D ced_to_pit(ced);
+
+	pit_timer_disable(pit->clkevt_base);
+
+	return 0;
+}
+
+static int pit_set_periodic(struct clock_event_device *ced)
+{
+	struct pit_timer *pit =3D ced_to_pit(ced);
+
+	pit_set_next_event(pit->cycle_per_jiffy, ced);
+
+	return 0;
+}
+
+static irqreturn_t pit_timer_interrupt(int irq, void *dev_id)
+{
+	struct clock_event_device *ced =3D dev_id;
+	struct pit_timer *pit =3D ced_to_pit(ced);
+
+	pit_timer_irqack(pit);
+
+	/*
+	 * pit hardware doesn't support oneshot, it will generate an interrupt
+	 * and reload the counter value from PITLDVAL when PITCVAL reach zero,
+	 * and start the counter again. So software need to disable the timer
+	 * to stop the counter loop in ONESHOT mode.
+	 */
+	if (likely(clockevent_state_oneshot(ced)))
+		pit_timer_disable(pit->clkevt_base);
+
+	ced->event_handler(ced);
+
+	return IRQ_HANDLED;
+}
+
+static int __init pit_clockevent_init(struct pit_timer *pit, const char *nam=
e,
+				      void __iomem *base, unsigned long rate,
+				      int irq, unsigned int cpu)
+{
+	/*
+	 * The channels 0 and 1 can be chained to build a 64-bit
+	 * timer. Let's use the channel 3 as a clockevent and leave
+	 * the channels 0 and 1 unused for anyone else who needs them
+	 */
+	pit->clkevt_base =3D base + PIT_CH(3);
+	pit->cycle_per_jiffy =3D rate / (HZ);
+
+	pit_timer_disable(pit->clkevt_base);
+
+	pit_timer_irqack(pit);
+
+	BUG_ON(request_irq(irq, pit_timer_interrupt, IRQF_TIMER | IRQF_IRQPOLL,
+			   name, &pit->ced));
+
+	pit->ced.cpumask =3D cpumask_of(cpu);
+	pit->ced.irq =3D irq;
+
+	pit->ced.name =3D name;
+	pit->ced.features =3D CLOCK_EVT_FEAT_PERIODIC | CLOCK_EVT_FEAT_ONESHOT;
+	pit->ced.set_state_shutdown =3D pit_shutdown;
+	pit->ced.set_state_periodic =3D pit_set_periodic;
+	pit->ced.set_next_event	=3D pit_set_next_event;
+	pit->ced.rating	=3D 300;
+
+	/*
+	 * The value for the LDVAL register trigger is calculated as:
+	 * LDVAL trigger =3D (period / clock period) - 1
+	 * The pit is a 32-bit down count timer, when the counter value
+	 * reaches 0, it will generate an interrupt, thus the minimal
+	 * LDVAL trigger value is 1. And then the min_delta is
+	 * minimal LDVAL trigger value + 1, and the max_delta is full 32-bit.
+	 */
+	clockevents_config_and_register(&pit->ced, rate, 2, 0xffffffff);
+
+	return 0;
+}
+
+static int __init pit_timer_init(struct device_node *np)
+{
+	struct pit_timer *pit;
+	struct clk *pit_clk;
+	void __iomem *timer_base;
+	const char *name =3D of_node_full_name(np);
+	unsigned long clk_rate;
+	int irq, ret;
+
+	pit =3D kzalloc(sizeof(*pit), GFP_KERNEL);
+	if (!pit)
+		return -ENOMEM;
+
+	ret =3D -ENXIO;
+	timer_base =3D of_iomap(np, 0);
+	if (!timer_base) {
+		pr_err("Failed to iomap\n");
+		goto out_kfree;
+	}
+
+	ret =3D -EINVAL;
+	irq =3D irq_of_parse_and_map(np, 0);
+	if (irq <=3D 0) {
+		pr_err("Failed to irq_of_parse_and_map\n");
+		goto out_iounmap;
+	}
+
+	pit_clk =3D of_clk_get(np, 0);
+	if (IS_ERR(pit_clk)) {
+		ret =3D PTR_ERR(pit_clk);
+		goto out_iounmap;
+	}
+
+	ret =3D clk_prepare_enable(pit_clk);
+	if (ret)
+		goto out_clk_put;
+
+	clk_rate =3D clk_get_rate(pit_clk);
+
+	/* enable the pit module */
+	pit_module_enable(timer_base);
+
+	ret =3D pit_clocksource_init(pit, name, timer_base, clk_rate);
+	if (ret)
+		goto out_pit_module_disable;
+
+	ret =3D pit_clockevent_init(pit, name, timer_base, clk_rate, irq, 0);
+	if (ret)
+		goto out_pit_clocksource_unregister;
+
+	return 0;
+
+out_pit_clocksource_unregister:
+	clocksource_unregister(&pit->cs);
+out_pit_module_disable:
+	pit_module_disable(timer_base);
+	clk_disable_unprepare(pit_clk);
+out_clk_put:
+	clk_put(pit_clk);
+out_iounmap:
+	iounmap(timer_base);
+out_kfree:
+	kfree(pit);
+
+	return ret;
+}
+TIMER_OF_DECLARE(vf610, "fsl,vf610-pit", pit_timer_init);
diff --git a/drivers/clocksource/timer-vf-pit.c b/drivers/clocksource/timer-v=
f-pit.c
deleted file mode 100644
index 2a0ee41..0000000
--- a/drivers/clocksource/timer-vf-pit.c
+++ /dev/null
@@ -1,292 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-or-later
-/*
- * Copyright 2012-2013 Freescale Semiconductor, Inc.
- */
-
-#include <linux/interrupt.h>
-#include <linux/clockchips.h>
-#include <linux/clk.h>
-#include <linux/of_address.h>
-#include <linux/of_irq.h>
-#include <linux/sched_clock.h>
-
-/*
- * Each pit takes 0x10 Bytes register space
- */
-#define PIT0_OFFSET	0x100
-#define PIT_CH(n)       (PIT0_OFFSET + 0x10 * (n))
-
-#define PITMCR(__base)	(__base)
-
-#define PITMCR_FRZ	BIT(0)
-#define PITMCR_MDIS	BIT(1)
-
-#define PITLDVAL(__base)	(__base)
-#define PITTCTRL(__base)	((__base) + 0x08)
-
-#define PITCVAL_OFFSET	0x04
-#define PITCVAL(__base)	((__base) + 0x04)
-
-#define PITTCTRL_TEN			BIT(0)
-#define PITTCTRL_TIE			BIT(1)
-
-#define PITTFLG(__base)	((__base) + 0x0c)
-
-#define PITTFLG_TIF			BIT(0)
-
-struct pit_timer {
-	void __iomem *clksrc_base;
-	void __iomem *clkevt_base;
-	unsigned long cycle_per_jiffy;
-	struct clock_event_device ced;
-	struct clocksource cs;
-};
-
-static void __iomem *sched_clock_base;
-
-static inline struct pit_timer *ced_to_pit(struct clock_event_device *ced)
-{
-	return container_of(ced, struct pit_timer, ced);
-}
-
-static inline struct pit_timer *cs_to_pit(struct clocksource *cs)
-{
-	return container_of(cs, struct pit_timer, cs);
-}
-
-static inline void pit_module_enable(void __iomem *base)
-{
-	writel(0, PITMCR(base));
-}
-
-static inline void pit_module_disable(void __iomem *base)
-{
-	writel(PITMCR_MDIS, PITMCR(base));
-}
-
-static inline void pit_timer_enable(void __iomem *base, bool tie)
-{
-	u32 val =3D PITTCTRL_TEN | (tie ? PITTCTRL_TIE : 0);
-
-	writel(val, PITTCTRL(base));
-}
-
-static inline void pit_timer_disable(void __iomem *base)
-{
-	writel(0, PITTCTRL(base));
-}
-
-static inline void pit_timer_set_counter(void __iomem *base, unsigned int cn=
t)
-{
-	writel(cnt, PITLDVAL(base));
-}
-
-static inline void pit_timer_irqack(struct pit_timer *pit)
-{
-	writel(PITTFLG_TIF, PITTFLG(pit->clkevt_base));
-}
-
-static u64 notrace pit_read_sched_clock(void)
-{
-	return ~readl(sched_clock_base);
-}
-
-static u64 pit_timer_clocksource_read(struct clocksource *cs)
-{
-	struct pit_timer *pit =3D cs_to_pit(cs);
-
-	return (u64)~readl(PITCVAL(pit->clksrc_base));
-}
-
-static int __init pit_clocksource_init(struct pit_timer *pit, const char *na=
me,
-				       void __iomem *base, unsigned long rate)
-{
-	/*
-	 * The channels 0 and 1 can be chained to build a 64-bit
-	 * timer. Let's use the channel 2 as a clocksource and leave
-	 * the channels 0 and 1 unused for anyone else who needs them
-	 */
-	pit->clksrc_base =3D base + PIT_CH(2);
-	pit->cs.name =3D name;
-	pit->cs.rating =3D 300;
-	pit->cs.read =3D pit_timer_clocksource_read;
-	pit->cs.mask =3D CLOCKSOURCE_MASK(32);
-	pit->cs.flags =3D CLOCK_SOURCE_IS_CONTINUOUS;
-
-	/* set the max load value and start the clock source counter */
-	pit_timer_disable(pit->clksrc_base);
-	pit_timer_set_counter(pit->clksrc_base, ~0);
-	pit_timer_enable(pit->clksrc_base, 0);
-
-	sched_clock_base =3D pit->clksrc_base + PITCVAL_OFFSET;
-	sched_clock_register(pit_read_sched_clock, 32, rate);
-
-	return clocksource_register_hz(&pit->cs, rate);
-}
-
-static int pit_set_next_event(unsigned long delta, struct clock_event_device=
 *ced)
-{
-	struct pit_timer *pit =3D ced_to_pit(ced);
-
-	/*
-	 * set a new value to PITLDVAL register will not restart the timer,
-	 * to abort the current cycle and start a timer period with the new
-	 * value, the timer must be disabled and enabled again.
-	 * and the PITLAVAL should be set to delta minus one according to pit
-	 * hardware requirement.
-	 */
-	pit_timer_disable(pit->clkevt_base);
-	pit_timer_set_counter(pit->clkevt_base, delta - 1);
-	pit_timer_enable(pit->clkevt_base, true);
-
-	return 0;
-}
-
-static int pit_shutdown(struct clock_event_device *ced)
-{
-	struct pit_timer *pit =3D ced_to_pit(ced);
-
-	pit_timer_disable(pit->clkevt_base);
-
-	return 0;
-}
-
-static int pit_set_periodic(struct clock_event_device *ced)
-{
-	struct pit_timer *pit =3D ced_to_pit(ced);
-
-	pit_set_next_event(pit->cycle_per_jiffy, ced);
-
-	return 0;
-}
-
-static irqreturn_t pit_timer_interrupt(int irq, void *dev_id)
-{
-	struct clock_event_device *ced =3D dev_id;
-	struct pit_timer *pit =3D ced_to_pit(ced);
-
-	pit_timer_irqack(pit);
-
-	/*
-	 * pit hardware doesn't support oneshot, it will generate an interrupt
-	 * and reload the counter value from PITLDVAL when PITCVAL reach zero,
-	 * and start the counter again. So software need to disable the timer
-	 * to stop the counter loop in ONESHOT mode.
-	 */
-	if (likely(clockevent_state_oneshot(ced)))
-		pit_timer_disable(pit->clkevt_base);
-
-	ced->event_handler(ced);
-
-	return IRQ_HANDLED;
-}
-
-static int __init pit_clockevent_init(struct pit_timer *pit, const char *nam=
e,
-				      void __iomem *base, unsigned long rate,
-				      int irq, unsigned int cpu)
-{
-	/*
-	 * The channels 0 and 1 can be chained to build a 64-bit
-	 * timer. Let's use the channel 3 as a clockevent and leave
-	 * the channels 0 and 1 unused for anyone else who needs them
-	 */
-	pit->clkevt_base =3D base + PIT_CH(3);
-	pit->cycle_per_jiffy =3D rate / (HZ);
-
-	pit_timer_disable(pit->clkevt_base);
-
-	pit_timer_irqack(pit);
-
-	BUG_ON(request_irq(irq, pit_timer_interrupt, IRQF_TIMER | IRQF_IRQPOLL,
-			   name, &pit->ced));
-
-	pit->ced.cpumask =3D cpumask_of(cpu);
-	pit->ced.irq =3D irq;
-
-	pit->ced.name =3D name;
-	pit->ced.features =3D CLOCK_EVT_FEAT_PERIODIC | CLOCK_EVT_FEAT_ONESHOT;
-	pit->ced.set_state_shutdown =3D pit_shutdown;
-	pit->ced.set_state_periodic =3D pit_set_periodic;
-	pit->ced.set_next_event	=3D pit_set_next_event;
-	pit->ced.rating	=3D 300;
-
-	/*
-	 * The value for the LDVAL register trigger is calculated as:
-	 * LDVAL trigger =3D (period / clock period) - 1
-	 * The pit is a 32-bit down count timer, when the counter value
-	 * reaches 0, it will generate an interrupt, thus the minimal
-	 * LDVAL trigger value is 1. And then the min_delta is
-	 * minimal LDVAL trigger value + 1, and the max_delta is full 32-bit.
-	 */
-	clockevents_config_and_register(&pit->ced, rate, 2, 0xffffffff);
-
-	return 0;
-}
-
-static int __init pit_timer_init(struct device_node *np)
-{
-	struct pit_timer *pit;
-	struct clk *pit_clk;
-	void __iomem *timer_base;
-	const char *name =3D of_node_full_name(np);
-	unsigned long clk_rate;
-	int irq, ret;
-
-	pit =3D kzalloc(sizeof(*pit), GFP_KERNEL);
-	if (!pit)
-		return -ENOMEM;
-
-	ret =3D -ENXIO;
-	timer_base =3D of_iomap(np, 0);
-	if (!timer_base) {
-		pr_err("Failed to iomap\n");
-		goto out_kfree;
-	}
-
-	ret =3D -EINVAL;
-	irq =3D irq_of_parse_and_map(np, 0);
-	if (irq <=3D 0) {
-		pr_err("Failed to irq_of_parse_and_map\n");
-		goto out_iounmap;
-	}
-
-	pit_clk =3D of_clk_get(np, 0);
-	if (IS_ERR(pit_clk)) {
-		ret =3D PTR_ERR(pit_clk);
-		goto out_iounmap;
-	}
-
-	ret =3D clk_prepare_enable(pit_clk);
-	if (ret)
-		goto out_clk_put;
-
-	clk_rate =3D clk_get_rate(pit_clk);
-
-	/* enable the pit module */
-	pit_module_enable(timer_base);
-
-	ret =3D pit_clocksource_init(pit, name, timer_base, clk_rate);
-	if (ret)
-		goto out_pit_module_disable;
-
-	ret =3D pit_clockevent_init(pit, name, timer_base, clk_rate, irq, 0);
-	if (ret)
-		goto out_pit_clocksource_unregister;
-
-	return 0;
-
-out_pit_clocksource_unregister:
-	clocksource_unregister(&pit->cs);
-out_pit_module_disable:
-	pit_module_disable(timer_base);
-	clk_disable_unprepare(pit_clk);
-out_clk_put:
-	clk_put(pit_clk);
-out_iounmap:
-	iounmap(timer_base);
-out_kfree:
-	kfree(pit);
-
-	return ret;
-}
-TIMER_OF_DECLARE(vf610, "fsl,vf610-pit", pit_timer_init);

