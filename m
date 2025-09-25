Return-Path: <linux-tip-commits+bounces-6755-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 82288BA1987
	for <lists+linux-tip-commits@lfdr.de>; Thu, 25 Sep 2025 23:38:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 05F4B321A5F
	for <lists+linux-tip-commits@lfdr.de>; Thu, 25 Sep 2025 21:38:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04B5E32CF99;
	Thu, 25 Sep 2025 21:33:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="bFpsELk1";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="9rI5m5Td"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6CC432CF6D;
	Thu, 25 Sep 2025 21:33:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758836021; cv=none; b=gPCKMRtoTCn/J8LCkZTYUy+OTTwfecHpoQVgkvuA85b6ryACL13/FtJjSrDacEZo0o5L4np9CovQ6VHS62xarawvEOR08T5hd05dP5TwsIvQmURqIpkP8kQmaP0mdRkbY15sff8kQpxIVBo/7NXoZYyXAqZ5cj9yofdBniQADAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758836021; c=relaxed/simple;
	bh=swXyQ9mqkKZSMESWR6GnJzE95zbAx9W380K5KFf6BUU=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=TWD9SK4D6JJWPopqnY9Trllt56khSt0hbZKJ97O4GVTDxiUahc9EPQiZueXtHTTPsXA8OHpd138sF/JFfANsNuYn2SU/VwRRNqxeLeCsjbo6HRCxidzSjuCjp7mH2f4fwKbt9r4oMVeeGX95G3Fe5+WKUyADZ3EOA5T2KU66jm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=bFpsELk1; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=9rI5m5Td; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 25 Sep 2025 21:33:36 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1758836018;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=5oddaP14BsJ1TsWTMvNqFG9/sYtVdOiFBM+Yi6WX1ws=;
	b=bFpsELk1Hv8cs5U6SssZmHZOJaGHn0VrG0D9F1C8VKoMK4PLaIXGkrXwTzOZOlDyTBDict
	12LD3ZbQa8M+kvQZw3/JT26fxTQX16sraVwK7sSgO2si4AKHba+0rDEAftsLVaic6us9S6
	eRqbiQ6ChfJQwWKBcuqPgDyPUnUQCo+2t+ufy21nU46EqXQYF2gkZ6i9nCf13Jv0P8R9Xj
	LTwcnLcR9nPGK92ZiAsJFelvaf9mo6nOSBHi2XI/q1SMM0ns7w9KvASKasisuZnUr+J1fT
	WwAdmXOwe5kQ2fq8rkcuR5gFcTuI7JDAZnYZBz9kK58pCZV3IiO/RbnjIiFLsQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1758836018;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=5oddaP14BsJ1TsWTMvNqFG9/sYtVdOiFBM+Yi6WX1ws=;
	b=9rI5m5TdvEGlR2cKTjiTe+fIytyZ8D54/1/gq5J/sMytAm1p7rXnL6fxPM+EYFAz5He09E
	OVxQGZHWQYvxbAAA==
From: "tip-bot2 for Daniel Lezcano" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/clocksource] clocksource/drivers/vf-pit: Set the scene
 for multiple timers
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175883601672.709179.18063053669930455254.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the timers/clocksource branch of ti=
p:

Commit-ID:     3996232e6e7e34a1f783c778f6c7075293912365
Gitweb:        https://git.kernel.org/tip/3996232e6e7e34a1f783c778f6c70752939=
12365
Author:        Daniel Lezcano <daniel.lezcano@linaro.org>
AuthorDate:    Mon, 04 Aug 2025 17:23:21 +02:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Tue, 23 Sep 2025 12:28:32 +02:00

clocksource/drivers/vf-pit: Set the scene for multiple timers

The driver is implemented as using a single timer and a single
clocksource. In order to take advantage of the multiple timers
supported in the PIT hardware and introduce different setup for a new
platform, let's encapsulate the data into a structure and pass this
structure around in the function parameter. The structure will be a
per timer instansiation in the next changes.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Link: https://lore.kernel.org/r/20250804152344.1109310-4-daniel.lezcano@linar=
o.org
---
 drivers/clocksource/timer-vf-pit.c | 121 ++++++++++++++++------------
 1 file changed, 72 insertions(+), 49 deletions(-)

diff --git a/drivers/clocksource/timer-vf-pit.c b/drivers/clocksource/timer-v=
f-pit.c
index 8041a8f..e4a8b32 100644
--- a/drivers/clocksource/timer-vf-pit.c
+++ b/drivers/clocksource/timer-vf-pit.c
@@ -15,7 +15,7 @@
  */
 #define PITMCR		0x00
 #define PIT0_OFFSET	0x100
-#define PITn_OFFSET(n)	(PIT0_OFFSET + 0x10 * (n))
+#define PIT_CH(n)       (PIT0_OFFSET + 0x10 * (n))
 #define PITLDVAL	0x00
 #define PITCVAL		0x04
 #define PITTCTRL	0x08
@@ -29,23 +29,36 @@
=20
 #define PITTFLG_TIF	0x1
=20
+struct pit_timer {
+	void __iomem *clksrc_base;
+	void __iomem *clkevt_base;
+	unsigned long cycle_per_jiffy;
+	struct clock_event_device ced;
+	struct clocksource cs;
+};
+
+static struct pit_timer pit_timer;
+
 static void __iomem *clksrc_base;
-static void __iomem *clkevt_base;
-static unsigned long cycle_per_jiffy;
=20
-static inline void pit_timer_enable(void)
+static inline struct pit_timer *ced_to_pit(struct clock_event_device *ced)
 {
-	writel(PITTCTRL_TEN | PITTCTRL_TIE, clkevt_base + PITTCTRL);
+	return container_of(ced, struct pit_timer, ced);
 }
=20
-static inline void pit_timer_disable(void)
+static inline void pit_timer_enable(struct pit_timer *pit)
 {
-	writel(0, clkevt_base + PITTCTRL);
+	writel(PITTCTRL_TEN | PITTCTRL_TIE, pit->clkevt_base + PITTCTRL);
 }
=20
-static inline void pit_irq_acknowledge(void)
+static inline void pit_timer_disable(struct pit_timer *pit)
 {
-	writel(PITTFLG_TIF, clkevt_base + PITTFLG);
+	writel(0, pit->clkevt_base + PITTCTRL);
+}
+
+static inline void pit_irq_acknowledge(struct pit_timer *pit)
+{
+	writel(PITTFLG_TIF, pit->clkevt_base + PITTFLG);
 }
=20
 static u64 notrace pit_read_sched_clock(void)
@@ -53,21 +66,24 @@ static u64 notrace pit_read_sched_clock(void)
 	return ~readl(clksrc_base + PITCVAL);
 }
=20
-static int __init pit_clocksource_init(unsigned long rate)
+static int __init pit_clocksource_init(struct pit_timer *pit, unsigned long =
rate)
 {
 	/* set the max load value and start the clock source counter */
-	writel(0, clksrc_base + PITTCTRL);
-	writel(~0UL, clksrc_base + PITLDVAL);
-	writel(PITTCTRL_TEN, clksrc_base + PITTCTRL);
+	writel(0, pit->clksrc_base + PITTCTRL);
+	writel(~0, pit->clksrc_base + PITLDVAL);
+	writel(PITTCTRL_TEN, pit->clksrc_base + PITTCTRL);
+
+	clksrc_base =3D pit->clksrc_base;
=20
 	sched_clock_register(pit_read_sched_clock, 32, rate);
-	return clocksource_mmio_init(clksrc_base + PITCVAL, "vf-pit", rate,
+	return clocksource_mmio_init(pit->clksrc_base + PITCVAL, "vf-pit", rate,
 			300, 32, clocksource_mmio_readl_down);
 }
=20
-static int pit_set_next_event(unsigned long delta,
-				struct clock_event_device *unused)
+static int pit_set_next_event(unsigned long delta, struct clock_event_device=
 *ced)
 {
+	struct pit_timer *pit =3D ced_to_pit(ced);
+
 	/*
 	 * set a new value to PITLDVAL register will not restart the timer,
 	 * to abort the current cycle and start a timer period with the new
@@ -75,30 +91,37 @@ static int pit_set_next_event(unsigned long delta,
 	 * and the PITLAVAL should be set to delta minus one according to pit
 	 * hardware requirement.
 	 */
-	pit_timer_disable();
-	writel(delta - 1, clkevt_base + PITLDVAL);
-	pit_timer_enable();
+	pit_timer_disable(pit);
+	writel(delta - 1, pit->clkevt_base + PITLDVAL);
+	pit_timer_enable(pit);
=20
 	return 0;
 }
=20
-static int pit_shutdown(struct clock_event_device *evt)
+static int pit_shutdown(struct clock_event_device *ced)
 {
-	pit_timer_disable();
+	struct pit_timer *pit =3D ced_to_pit(ced);
+
+	pit_timer_disable(pit);
+
 	return 0;
 }
=20
-static int pit_set_periodic(struct clock_event_device *evt)
+static int pit_set_periodic(struct clock_event_device *ced)
 {
-	pit_set_next_event(cycle_per_jiffy, evt);
+	struct pit_timer *pit =3D ced_to_pit(ced);
+
+	pit_set_next_event(pit->cycle_per_jiffy, ced);
+
 	return 0;
 }
=20
 static irqreturn_t pit_timer_interrupt(int irq, void *dev_id)
 {
-	struct clock_event_device *evt =3D dev_id;
+	struct clock_event_device *ced =3D dev_id;
+	struct pit_timer *pit =3D ced_to_pit(ced);
=20
-	pit_irq_acknowledge();
+	pit_irq_acknowledge(pit);
=20
 	/*
 	 * pit hardware doesn't support oneshot, it will generate an interrupt
@@ -106,33 +129,33 @@ static irqreturn_t pit_timer_interrupt(int irq, void *d=
ev_id)
 	 * and start the counter again. So software need to disable the timer
 	 * to stop the counter loop in ONESHOT mode.
 	 */
-	if (likely(clockevent_state_oneshot(evt)))
-		pit_timer_disable();
+	if (likely(clockevent_state_oneshot(ced)))
+		pit_timer_disable(pit);
=20
-	evt->event_handler(evt);
+	ced->event_handler(ced);
=20
 	return IRQ_HANDLED;
 }
=20
-static struct clock_event_device clockevent_pit =3D {
-	.name		=3D "VF pit timer",
-	.features	=3D CLOCK_EVT_FEAT_PERIODIC | CLOCK_EVT_FEAT_ONESHOT,
-	.set_state_shutdown =3D pit_shutdown,
-	.set_state_periodic =3D pit_set_periodic,
-	.set_next_event	=3D pit_set_next_event,
-	.rating		=3D 300,
-};
-
-static int __init pit_clockevent_init(unsigned long rate, int irq)
+static int __init pit_clockevent_init(struct pit_timer *pit, unsigned long r=
ate, int irq)
 {
-	writel(0, clkevt_base + PITTCTRL);
-	writel(PITTFLG_TIF, clkevt_base + PITTFLG);
+	writel(0, pit->clkevt_base + PITTCTRL);
+
+	writel(PITTFLG_TIF, pit->clkevt_base + PITTFLG);
=20
 	BUG_ON(request_irq(irq, pit_timer_interrupt, IRQF_TIMER | IRQF_IRQPOLL,
-			   "VF pit timer", &clockevent_pit));
+			   "VF pit timer", &pit->ced));
+
+	pit->ced.cpumask =3D cpumask_of(0);
+	pit->ced.irq =3D irq;
+
+	pit->ced.name =3D "VF pit timer";
+	pit->ced.features =3D CLOCK_EVT_FEAT_PERIODIC | CLOCK_EVT_FEAT_ONESHOT;
+	pit->ced.set_state_shutdown =3D pit_shutdown;
+	pit->ced.set_state_periodic =3D pit_set_periodic;
+	pit->ced.set_next_event	=3D pit_set_next_event;
+	pit->ced.rating	=3D 300;
=20
-	clockevent_pit.cpumask =3D cpumask_of(0);
-	clockevent_pit.irq =3D irq;
 	/*
 	 * The value for the LDVAL register trigger is calculated as:
 	 * LDVAL trigger =3D (period / clock period) - 1
@@ -141,7 +164,7 @@ static int __init pit_clockevent_init(unsigned long rate,=
 int irq)
 	 * LDVAL trigger value is 1. And then the min_delta is
 	 * minimal LDVAL trigger value + 1, and the max_delta is full 32-bit.
 	 */
-	clockevents_config_and_register(&clockevent_pit, rate, 2, 0xffffffff);
+	clockevents_config_and_register(&pit->ced, rate, 2, 0xffffffff);
=20
 	return 0;
 }
@@ -164,8 +187,8 @@ static int __init pit_timer_init(struct device_node *np)
 	 * so choose PIT2 as clocksource, PIT3 as clockevent device,
 	 * and leave PIT0 and PIT1 unused for anyone else who needs them.
 	 */
-	clksrc_base =3D timer_base + PITn_OFFSET(2);
-	clkevt_base =3D timer_base + PITn_OFFSET(3);
+	pit_timer.clksrc_base =3D timer_base + PIT_CH(2);
+	pit_timer.clkevt_base =3D timer_base + PIT_CH(3);
=20
 	irq =3D irq_of_parse_and_map(np, 0);
 	if (irq <=3D 0)
@@ -180,15 +203,15 @@ static int __init pit_timer_init(struct device_node *np)
 		return ret;
=20
 	clk_rate =3D clk_get_rate(pit_clk);
-	cycle_per_jiffy =3D clk_rate / (HZ);
+	pit_timer.cycle_per_jiffy =3D clk_rate / (HZ);
=20
 	/* enable the pit module */
 	writel(~PITMCR_MDIS, timer_base + PITMCR);
=20
-	ret =3D pit_clocksource_init(clk_rate);
+	ret =3D pit_clocksource_init(&pit_timer, clk_rate);
 	if (ret)
 		return ret;
=20
-	return pit_clockevent_init(clk_rate, irq);
+	return pit_clockevent_init(&pit_timer, clk_rate, irq);
 }
 TIMER_OF_DECLARE(vf610, "fsl,vf610-pit", pit_timer_init);

