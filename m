Return-Path: <linux-tip-commits+bounces-6738-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 31006BA1915
	for <lists+linux-tip-commits@lfdr.de>; Thu, 25 Sep 2025 23:35:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D2F5317E9F4
	for <lists+linux-tip-commits@lfdr.de>; Thu, 25 Sep 2025 21:35:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC636327790;
	Thu, 25 Sep 2025 21:33:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="gNvZCM9M";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="zc+HRmMB"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4895326D58;
	Thu, 25 Sep 2025 21:33:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758836000; cv=none; b=sMFusopMC+pxa0oLK3yP5wYX7AXp9743HF6QPnIXpglGGYFO6TjwQ1Prt/CxsjHxDwT2bhHePY1+jamW4YHaNxGPk4wGbbTmUg0Min1DNUcxBntWnT3O8jR4+kwujTZWCOOz4dYfmwraD1kGzNGhAA5ATXebFGyF247KMRnTmo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758836000; c=relaxed/simple;
	bh=fzN2bTNPPnEaaTsHmQS89ubEo91pzZDLOYlmJusfWZs=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=APlzobqcbtRchO9/U6IZ96mmVsQqV0fS+gJdu2tbR2A1QCzo550cdcaV74qjM0mu4rVxhjwvqTr81+P9B2H+3mDo6aOfEOHuggy87jFkEcKPV7aWQ0yED46Ng3OB2uXWH8xgZWDffp4/JQA4fURo6rex3ynf5p3Jfeqp3gw2JKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=gNvZCM9M; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=zc+HRmMB; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 25 Sep 2025 21:33:16 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1758835997;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=4EukiwxrW9shURYQUPoMu2YiWxGokF2vNq/2qot4xRg=;
	b=gNvZCM9Mn5KYVah3gxLG3Gl8/jwug+iVLKce5x1nLf7PIUOHdTUzHTVA1CjQqIlnVH9RD/
	YE8luu120kkqilSekqefVgfNQl/YBIyf1FWqtABoyIxFULwqI9w3tpda7/W1YM41vEIZq/
	8PVZRrDqZ2AyjxuUgRvZIDOTC2KWiRGmqHM2mjfthgMh/IKkv78qwWc4vyCrtwxLzIKRNm
	3t5wRnYKmCqKHKNAHXzAu7pmI37+nEtlZW6kCTCjgb/F+5+ANNp8Gyhme7EOudbaXVRgma
	UaufjZwJ+3fVv8MC5OV1hC/RPHj/M20UvSkAsvCjA2dZj5OlbHkTVZaSrXObdg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1758835997;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=4EukiwxrW9shURYQUPoMu2YiWxGokF2vNq/2qot4xRg=;
	b=zc+HRmMBmeUun42qdyP9a5miBdszmbMzuB2APJCwA6C98+3Fkh1qiGDXQzVn3nyCV+hpbV
	yhiYnAkZeyPh7vAw==
From: "tip-bot2 for Daniel Lezcano" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/clocksource] clocksource/drivers/nxp-pit: Add NXP
 Automotive s32g2 / s32g3 support
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175883599601.709179.10993218696937661982.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the timers/clocksource branch of ti=
p:

Commit-ID:     bee33f22d7c30626e711b4900e3f460b6e0e104f
Gitweb:        https://git.kernel.org/tip/bee33f22d7c30626e711b4900e3f460b6e0=
e104f
Author:        Daniel Lezcano <daniel.lezcano@linaro.org>
AuthorDate:    Mon, 04 Aug 2025 17:23:38 +02:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Tue, 23 Sep 2025 12:30:19 +02:00

clocksource/drivers/nxp-pit: Add NXP Automotive s32g2 / s32g3 support

The previous changes put in place the encapsulation of the code in
order to allow multiple instances of the driver.

The S32G platform has two Periodic Interrupt Timer (PIT). The IP is
exactly the same as the VF platform.

Each PIT has four channels which are 32 bits wide and counting
down. The two first channels can be chained to implement a 64 bits
counter. The channel usage is kept unchanged with the original driver,
channel 2 is used as a clocksource, channel 3 is used as a
clockevent. Other channels are unused.

In order to support the S32G platform which has two PIT, we initialize
the timer and bind it to a CPU. The S32G platforms can have 2, 4 or 8
CPUs and this kind of configuration can appear unusual as we may endup
with two PIT used as a clockevent for the two first CPUs while the
other CPUs use the architected timers. However, in the context of the
automotive, the platform can be partioned to assign 2 CPUs for Linux
and the others CPUs to third party OS. The PIT is then used with their
specifities like the ability to freeze the time which is needed for
instance for debugging purpose.

The setup found for this platform is each timer instance is bound to
CPU0 and CPU1.

A counter is incremented when a timer is successfully initialized and
assigned to a CPU. This counter is used as an index for the CPU number
and to detect when we reach the maximum possible instances for the
platform. That in turn triggers the CPU hotplug callbacks to achieve
the per CPU setup. It is the exact same mechanism found in the NXP STM
driver.

If the timers must be bound to different CPUs, it would require an
additionnal mechanism which is not part of these changes.

Tested on a s32g274a-rdb2.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Link: https://lore.kernel.org/r/20250804152344.1109310-21-daniel.lezcano@lina=
ro.org
---
 drivers/clocksource/timer-nxp-pit.c | 128 ++++++++++++++++++++++-----
 1 file changed, 109 insertions(+), 19 deletions(-)

diff --git a/drivers/clocksource/timer-nxp-pit.c b/drivers/clocksource/timer-=
nxp-pit.c
index 2a0ee41..2d0a355 100644
--- a/drivers/clocksource/timer-nxp-pit.c
+++ b/drivers/clocksource/timer-nxp-pit.c
@@ -1,14 +1,16 @@
 // SPDX-License-Identifier: GPL-2.0-or-later
 /*
  * Copyright 2012-2013 Freescale Semiconductor, Inc.
+ * Copyright 2018,2021-2025 NXP
  */
-
 #include <linux/interrupt.h>
 #include <linux/clockchips.h>
+#include <linux/cpuhotplug.h>
 #include <linux/clk.h>
 #include <linux/of_address.h>
 #include <linux/of_irq.h>
 #include <linux/sched_clock.h>
+#include <linux/platform_device.h>
=20
 /*
  * Each pit takes 0x10 Bytes register space
@@ -37,11 +39,23 @@
 struct pit_timer {
 	void __iomem *clksrc_base;
 	void __iomem *clkevt_base;
-	unsigned long cycle_per_jiffy;
 	struct clock_event_device ced;
 	struct clocksource cs;
+	int rate;
+};
+
+struct pit_timer_data {
+	int max_pit_instances;
 };
=20
+static DEFINE_PER_CPU(struct pit_timer *, pit_timers);
+
+/*
+ * Global structure for multiple PITs initialization
+ */
+static int pit_instances;
+static int max_pit_instances =3D 1;
+
 static void __iomem *sched_clock_base;
=20
 static inline struct pit_timer *ced_to_pit(struct clock_event_device *ced)
@@ -98,8 +112,8 @@ static u64 pit_timer_clocksource_read(struct clocksource *=
cs)
 	return (u64)~readl(PITCVAL(pit->clksrc_base));
 }
=20
-static int __init pit_clocksource_init(struct pit_timer *pit, const char *na=
me,
-				       void __iomem *base, unsigned long rate)
+static int pit_clocksource_init(struct pit_timer *pit, const char *name,
+				void __iomem *base, unsigned long rate)
 {
 	/*
 	 * The channels 0 and 1 can be chained to build a 64-bit
@@ -155,7 +169,7 @@ static int pit_set_periodic(struct clock_event_device *ce=
d)
 {
 	struct pit_timer *pit =3D ced_to_pit(ced);
=20
-	pit_set_next_event(pit->cycle_per_jiffy, ced);
+	pit_set_next_event(pit->rate / HZ, ced);
=20
 	return 0;
 }
@@ -181,24 +195,28 @@ static irqreturn_t pit_timer_interrupt(int irq, void *d=
ev_id)
 	return IRQ_HANDLED;
 }
=20
-static int __init pit_clockevent_init(struct pit_timer *pit, const char *nam=
e,
-				      void __iomem *base, unsigned long rate,
-				      int irq, unsigned int cpu)
+static int pit_clockevent_per_cpu_init(struct pit_timer *pit, const char *na=
me,
+				       void __iomem *base, unsigned long rate,
+				       int irq, unsigned int cpu)
 {
+	int ret;
+
 	/*
 	 * The channels 0 and 1 can be chained to build a 64-bit
 	 * timer. Let's use the channel 3 as a clockevent and leave
 	 * the channels 0 and 1 unused for anyone else who needs them
 	 */
 	pit->clkevt_base =3D base + PIT_CH(3);
-	pit->cycle_per_jiffy =3D rate / (HZ);
+	pit->rate =3D rate;
=20
 	pit_timer_disable(pit->clkevt_base);
=20
 	pit_timer_irqack(pit);
=20
-	BUG_ON(request_irq(irq, pit_timer_interrupt, IRQF_TIMER | IRQF_IRQPOLL,
-			   name, &pit->ced));
+	ret =3D request_irq(irq, pit_timer_interrupt, IRQF_TIMER | IRQF_NOBALANCING,
+			  name, &pit->ced);
+	if (ret)
+		return ret;
=20
 	pit->ced.cpumask =3D cpumask_of(cpu);
 	pit->ced.irq =3D irq;
@@ -210,6 +228,32 @@ static int __init pit_clockevent_init(struct pit_timer *=
pit, const char *name,
 	pit->ced.set_next_event	=3D pit_set_next_event;
 	pit->ced.rating	=3D 300;
=20
+	per_cpu(pit_timers, cpu) =3D pit;
+
+	return 0;
+}
+
+static void pit_clockevent_per_cpu_exit(struct pit_timer *pit, unsigned int =
cpu)
+{
+	pit_timer_disable(pit->clkevt_base);
+	free_irq(pit->ced.irq, &pit->ced);
+	per_cpu(pit_timers, cpu) =3D NULL;
+}
+
+static int pit_clockevent_starting_cpu(unsigned int cpu)
+{
+	struct pit_timer *pit =3D per_cpu(pit_timers, cpu);
+	int ret;
+
+	if (!pit)
+		return 0;
+
+	ret =3D irq_force_affinity(pit->ced.irq, cpumask_of(cpu));
+	if (ret) {
+		pit_clockevent_per_cpu_exit(pit, cpu);
+		return ret;
+	}
+
 	/*
 	 * The value for the LDVAL register trigger is calculated as:
 	 * LDVAL trigger =3D (period / clock period) - 1
@@ -218,12 +262,12 @@ static int __init pit_clockevent_init(struct pit_timer =
*pit, const char *name,
 	 * LDVAL trigger value is 1. And then the min_delta is
 	 * minimal LDVAL trigger value + 1, and the max_delta is full 32-bit.
 	 */
-	clockevents_config_and_register(&pit->ced, rate, 2, 0xffffffff);
+	clockevents_config_and_register(&pit->ced, pit->rate, 2, 0xffffffff);
=20
 	return 0;
 }
=20
-static int __init pit_timer_init(struct device_node *np)
+static int pit_timer_init(struct device_node *np)
 {
 	struct pit_timer *pit;
 	struct clk *pit_clk;
@@ -253,7 +297,7 @@ static int __init pit_timer_init(struct device_node *np)
 	pit_clk =3D of_clk_get(np, 0);
 	if (IS_ERR(pit_clk)) {
 		ret =3D PTR_ERR(pit_clk);
-		goto out_iounmap;
+		goto out_irq_dispose_mapping;
 	}
=20
 	ret =3D clk_prepare_enable(pit_clk);
@@ -262,16 +306,31 @@ static int __init pit_timer_init(struct device_node *np)
=20
 	clk_rate =3D clk_get_rate(pit_clk);
=20
-	/* enable the pit module */
-	pit_module_enable(timer_base);
+	pit_module_disable(timer_base);
=20
 	ret =3D pit_clocksource_init(pit, name, timer_base, clk_rate);
-	if (ret)
+	if (ret) {
+		pr_err("Failed to initialize clocksource '%pOF'\n", np);
 		goto out_pit_module_disable;
+	}
=20
-	ret =3D pit_clockevent_init(pit, name, timer_base, clk_rate, irq, 0);
-	if (ret)
+	ret =3D pit_clockevent_per_cpu_init(pit, name, timer_base, clk_rate, irq, p=
it_instances);
+	if (ret) {
+		pr_err("Failed to initialize clockevent '%pOF'\n", np);
 		goto out_pit_clocksource_unregister;
+	}
+
+	/* enable the pit module */
+	pit_module_enable(timer_base);
+
+	pit_instances++;
+
+	if (pit_instances =3D=3D max_pit_instances) {
+		ret =3D cpuhp_setup_state(CPUHP_AP_ONLINE_DYN, "PIT timer:starting",
+					pit_clockevent_starting_cpu, NULL);
+		if (ret < 0)
+			goto out_pit_clocksource_unregister;
+	}
=20
 	return 0;
=20
@@ -282,6 +341,8 @@ out_pit_module_disable:
 	clk_disable_unprepare(pit_clk);
 out_clk_put:
 	clk_put(pit_clk);
+out_irq_dispose_mapping:
+	irq_dispose_mapping(irq);
 out_iounmap:
 	iounmap(timer_base);
 out_kfree:
@@ -289,4 +350,33 @@ out_kfree:
=20
 	return ret;
 }
+
+static int pit_timer_probe(struct platform_device *pdev)
+{
+	const struct pit_timer_data *pit_timer_data;
+
+	pit_timer_data =3D of_device_get_match_data(&pdev->dev);
+	if (pit_timer_data)
+		max_pit_instances =3D pit_timer_data->max_pit_instances;
+
+	return pit_timer_init(pdev->dev.of_node);
+}
+
+static struct pit_timer_data s32g2_data =3D { .max_pit_instances =3D 2 };
+
+static const struct of_device_id pit_timer_of_match[] =3D {
+	{ .compatible =3D "nxp,s32g2-pit", .data =3D &s32g2_data },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, pit_timer_of_match);
+
+static struct platform_driver nxp_pit_driver =3D {
+	.driver =3D {
+		.name =3D "nxp-pit",
+		.of_match_table =3D pit_timer_of_match,
+	},
+	.probe =3D pit_timer_probe,
+};
+module_platform_driver(nxp_pit_driver);
+
 TIMER_OF_DECLARE(vf610, "fsl,vf610-pit", pit_timer_init);

