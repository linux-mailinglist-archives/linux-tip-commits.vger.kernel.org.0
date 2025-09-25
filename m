Return-Path: <linux-tip-commits+bounces-6746-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED3D8BA194B
	for <lists+linux-tip-commits@lfdr.de>; Thu, 25 Sep 2025 23:37:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3C7BA1663F6
	for <lists+linux-tip-commits@lfdr.de>; Thu, 25 Sep 2025 21:37:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A14B232A82E;
	Thu, 25 Sep 2025 21:33:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Wnx8Q9G+";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="7QuAKXU0"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6B1532A80A;
	Thu, 25 Sep 2025 21:33:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758836011; cv=none; b=Nvmow/tQpHrgS0zUlqbj+2zqrbRdjEe2eDulZoXr7nvN3X01zwCc9NeQOSk6QdhQESbtH/JTC2/CDx4rFzWZeq5bTLqrvONyhKPHISKHMeIRPQmzRWWwx6tz56lsTkCZIz2hTKJo4FWTI716pk723KJsm7g7nyh9G7EHRuU1Y/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758836011; c=relaxed/simple;
	bh=ScRe3m63K2G6I7TuLl798XAQvTxrTFc+cfZi8Y7tx7Y=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=OUbzYZBGPa7Q/kQKw58p5QCEfg7ZuTj43+7bRi91gphqcXn5nlqk+2DcJbjcn18+CKj6D6T+acV3fwixCvIuD3mmtG7goRBHuDZP7mgqL/lRAHZrtKTCAtNKlENuR2SI2R/qgWyDk00V8ldsRPYJ//uHVoMsjze7saCZQl5DW3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Wnx8Q9G+; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=7QuAKXU0; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 25 Sep 2025 21:33:25 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1758836007;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=KXzyQpbDuDlC0XB+ai5thY2ElPDttI4tDnf27kZPNmw=;
	b=Wnx8Q9G+xyCgFowQVdz0PazvSgemBcoGujTBBfAWBvq1GJGRmdtUUAfaxDlA6dF08RlZjH
	Z9NKlMD3viVT2Yhf3XTPg8PxQ8qApXffKkue6flKCc9KRZXY9XMyygCsq3Nyg0Pf1bwQdf
	BP+0SBdqtC0yEKgE6HaejGOt9YaBmZGMj2LHkBDUQ+XmynPKKUDSX4DtXDd/CaaczXzjXS
	Rao4OWIwA9/j/MO7kUeOwPSCMVaDzhVVTJjydb10M4iOWQDmf+YDxpXPEO4qIw8owj1gzC
	iu3f+ljF5qNqf5NOndF2ag8ya3Ql3qMgBCblJOPMx5l3609zumZdDqjYhrSoMQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1758836007;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=KXzyQpbDuDlC0XB+ai5thY2ElPDttI4tDnf27kZPNmw=;
	b=7QuAKXU0ykT6/mdXBH9N/Nq1q+GIf4egypqHpHhgoRE6aJHHCzbbcDQCTiJILPBA75DXEe
	G8hdp6emF8C873Aw==
From: "tip-bot2 for Daniel Lezcano" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/clocksource] clocksource/drivers/vf-pit: Use the node
 name for the interrupt and timer names
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175883600574.709179.5949311061896110422.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the timers/clocksource branch of ti=
p:

Commit-ID:     7201c95c258936e32c950f447c59875780046848
Gitweb:        https://git.kernel.org/tip/7201c95c258936e32c950f447c598757800=
46848
Author:        Daniel Lezcano <daniel.lezcano@linaro.org>
AuthorDate:    Mon, 04 Aug 2025 17:23:30 +02:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Tue, 23 Sep 2025 12:29:34 +02:00

clocksource/drivers/vf-pit: Use the node name for the interrupt and timer nam=
es

In order to differentiate from userspace the pit timer given the
device tree, let's use the node name for the interrupt and the timer
names.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Link: https://lore.kernel.org/r/20250804152344.1109310-13-daniel.lezcano@lina=
ro.org
---
 drivers/clocksource/timer-vf-pit.c | 20 +++++++++++---------
 1 file changed, 11 insertions(+), 9 deletions(-)

diff --git a/drivers/clocksource/timer-vf-pit.c b/drivers/clocksource/timer-v=
f-pit.c
index 4f1b85b..2a255b4 100644
--- a/drivers/clocksource/timer-vf-pit.c
+++ b/drivers/clocksource/timer-vf-pit.c
@@ -79,8 +79,8 @@ static u64 pit_timer_clocksource_read(struct clocksource *c=
s)
 	return (u64)~readl(PITCVAL(pit->clksrc_base));
 }
=20
-static int __init pit_clocksource_init(struct pit_timer *pit, void __iomem *=
base,
-				       unsigned long rate)
+static int __init pit_clocksource_init(struct pit_timer *pit, const char *na=
me,
+				       void __iomem *base, unsigned long rate)
 {
 	/*
 	 * The channels 0 and 1 can be chained to build a 64-bit
@@ -88,7 +88,7 @@ static int __init pit_clocksource_init(struct pit_timer *pi=
t, void __iomem *base
 	 * the channels 0 and 1 unused for anyone else who needs them
 	 */
 	pit->clksrc_base =3D base + PIT_CH(2);
-	pit->cs.name =3D "vf-pit";
+	pit->cs.name =3D name;
 	pit->cs.rating =3D 300;
 	pit->cs.read =3D pit_timer_clocksource_read;
 	pit->cs.mask =3D CLOCKSOURCE_MASK(32);
@@ -162,8 +162,9 @@ static irqreturn_t pit_timer_interrupt(int irq, void *dev=
_id)
 	return IRQ_HANDLED;
 }
=20
-static int __init pit_clockevent_init(struct pit_timer *pit, void __iomem *b=
ase,
-				      unsigned long rate, int irq, unsigned int cpu)
+static int __init pit_clockevent_init(struct pit_timer *pit, const char *nam=
e,
+				      void __iomem *base, unsigned long rate,
+				      int irq, unsigned int cpu)
 {
 	/*
 	 * The channels 0 and 1 can be chained to build a 64-bit
@@ -178,12 +179,12 @@ static int __init pit_clockevent_init(struct pit_timer =
*pit, void __iomem *base,
 	pit_irq_acknowledge(pit);
=20
 	BUG_ON(request_irq(irq, pit_timer_interrupt, IRQF_TIMER | IRQF_IRQPOLL,
-			   "VF pit timer", &pit->ced));
+			   name, &pit->ced));
=20
 	pit->ced.cpumask =3D cpumask_of(cpu);
 	pit->ced.irq =3D irq;
=20
-	pit->ced.name =3D "VF pit timer";
+	pit->ced.name =3D name;
 	pit->ced.features =3D CLOCK_EVT_FEAT_PERIODIC | CLOCK_EVT_FEAT_ONESHOT;
 	pit->ced.set_state_shutdown =3D pit_shutdown;
 	pit->ced.set_state_periodic =3D pit_set_periodic;
@@ -208,6 +209,7 @@ static int __init pit_timer_init(struct device_node *np)
 	struct pit_timer *pit;
 	struct clk *pit_clk;
 	void __iomem *timer_base;
+	const char *name =3D of_node_full_name(np);
 	unsigned long clk_rate;
 	int irq, ret;
=20
@@ -244,11 +246,11 @@ static int __init pit_timer_init(struct device_node *np)
 	/* enable the pit module */
 	writel(~PITMCR_MDIS, timer_base + PITMCR);
=20
-	ret =3D pit_clocksource_init(pit, timer_base, clk_rate);
+	ret =3D pit_clocksource_init(pit, name, timer_base, clk_rate);
 	if (ret)
 		goto out_disable_unprepare;
=20
-	ret =3D pit_clockevent_init(pit, timer_base, clk_rate, irq, 0);
+	ret =3D pit_clockevent_init(pit, name, timer_base, clk_rate, irq, 0);
 	if (ret)
 		goto out_pit_clocksource_unregister;
=20

