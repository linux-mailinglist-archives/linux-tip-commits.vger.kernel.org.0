Return-Path: <linux-tip-commits+bounces-6749-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BA27BA1963
	for <lists+linux-tip-commits@lfdr.de>; Thu, 25 Sep 2025 23:38:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 96BD77B3A55
	for <lists+linux-tip-commits@lfdr.de>; Thu, 25 Sep 2025 21:35:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C03732B4B4;
	Thu, 25 Sep 2025 21:33:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="LkIXOkfx";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="xeXqnF64"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90CC2322A1E;
	Thu, 25 Sep 2025 21:33:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758836014; cv=none; b=C8uDcotywoz5FzsVgDUdGXAru4w9VJEBXchRI23+gNre1/JBDc7Rt4b6WeejoW0uz3QlJ7x9io3Fn35yJ5W+pyyN1rez5pvPK7mSA7fRbVu4RyFERG4J7wzU080tX+Q9i4UqjkTBo+WkkoDZmCv58aeJnygCuYDmky32vmuJ9oo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758836014; c=relaxed/simple;
	bh=lnabJoS5FWDflgi61TPfRJX6f2CZQz4w2B+wk2zXTLk=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=MtEh/67mwl4/9YtUX2O2cWyyHxgG3aGQAQ7bjhFhUc/XYIMoFqhtUYCtmATjtHBDx4nxljX1C6WTD75wRast+viVusar2XZIc4r7e5VOy8llyonNpJaahUREP5aCisKcqggD1O6NsIuvhobbGubM/uXRv8xrYd4rU9QYaQ8KF7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=LkIXOkfx; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=xeXqnF64; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 25 Sep 2025 21:33:29 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1758836010;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=OGMQ0pgjHNnM/BukHMRTWYqHe69OUvi5FLx4PJ4Rkus=;
	b=LkIXOkfxq+RhosJ9A+SWdMkvSdqTDwuZz43e/L1o4U86mqD6rpwMvfPPdAkzVsU+76827T
	CpJfXEzCXXZSrJ18rJnw1x3jTVIUPDSDk0kETYuzoCg7uqgxy0odTGLhmWqM34UpKM13+o
	Uyg1CVEFtq9hfACdJh71dp41OXkyU8clfFppQFGmN/meq4bgy4H6AYzZq/MoCOJdmFEQgo
	f+rWNTEneE4bM1TvNGZyDufgwWPJm+VG0TiVKrIj9ZX4zuCdsYrJprkAHzUr0PWR61joXd
	EJJE55/dYPzmSN/VmaFEZplKqteWmpweh+FZAAUBCt9UcZoFdlsstY3INifnDQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1758836010;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=OGMQ0pgjHNnM/BukHMRTWYqHe69OUvi5FLx4PJ4Rkus=;
	b=xeXqnF64BhHPW6h3PvvtYBFB1HLZxwUCychEC4EpSteEWweLlUDn/RkH1oSCzRXQ6NmYp8
	G39xrzlVCrKlybCg==
From: "tip-bot2 for Daniel Lezcano" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/clocksource] clocksource/drivers/vf-pit: Register the
 clocksource from the driver
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175883600949.709179.13377933294882014711.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the timers/clocksource branch of ti=
p:

Commit-ID:     c106b698ab8d1899d62de880d73dd99edb319849
Gitweb:        https://git.kernel.org/tip/c106b698ab8d1899d62de880d73dd99edb3=
19849
Author:        Daniel Lezcano <daniel.lezcano@linaro.org>
AuthorDate:    Mon, 04 Aug 2025 17:23:27 +02:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Tue, 23 Sep 2025 12:29:15 +02:00

clocksource/drivers/vf-pit: Register the clocksource from the driver

The function clocksource_mmio_init() uses its own global static
clocksource variable making no possible to have several instances of a
clocksource using this function. In order to support that, let's add
the clocksource structure to the pit structure and use the
clocksource_register_hz() function instead.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Link: https://lore.kernel.org/r/20250804152344.1109310-10-daniel.lezcano@lina=
ro.org
---
 drivers/clocksource/timer-vf-pit.c | 20 ++++++++++++++++++--
 1 file changed, 18 insertions(+), 2 deletions(-)

diff --git a/drivers/clocksource/timer-vf-pit.c b/drivers/clocksource/timer-v=
f-pit.c
index d1aec6a..6a40438 100644
--- a/drivers/clocksource/timer-vf-pit.c
+++ b/drivers/clocksource/timer-vf-pit.c
@@ -44,6 +44,11 @@ static inline struct pit_timer *ced_to_pit(struct clock_ev=
ent_device *ced)
 	return container_of(ced, struct pit_timer, ced);
 }
=20
+static inline struct pit_timer *cs_to_pit(struct clocksource *cs)
+{
+	return container_of(cs, struct pit_timer, cs);
+}
+
 static inline void pit_timer_enable(struct pit_timer *pit)
 {
 	writel(PITTCTRL_TEN | PITTCTRL_TIE, pit->clkevt_base + PITTCTRL);
@@ -64,6 +69,13 @@ static u64 notrace pit_read_sched_clock(void)
 	return ~readl(clksrc_base + PITCVAL);
 }
=20
+static u64 pit_timer_clocksource_read(struct clocksource *cs)
+{
+	struct pit_timer *pit =3D cs_to_pit(cs);
+
+	return (u64)~readl(pit->clksrc_base + PITCVAL);
+}
+
 static int __init pit_clocksource_init(struct pit_timer *pit, void __iomem *=
base,
 				       unsigned long rate)
 {
@@ -73,6 +85,11 @@ static int __init pit_clocksource_init(struct pit_timer *p=
it, void __iomem *base
 	 * the channels 0 and 1 unused for anyone else who needs them
 	 */
 	pit->clksrc_base =3D base + PIT_CH(2);
+	pit->cs.name =3D "vf-pit";
+	pit->cs.rating =3D 300;
+	pit->cs.read =3D pit_timer_clocksource_read;
+	pit->cs.mask =3D CLOCKSOURCE_MASK(32);
+	pit->cs.flags =3D CLOCK_SOURCE_IS_CONTINUOUS;
=20
 	/* set the max load value and start the clock source counter */
 	writel(0, pit->clksrc_base + PITTCTRL);
@@ -83,8 +100,7 @@ static int __init pit_clocksource_init(struct pit_timer *p=
it, void __iomem *base
=20
 	sched_clock_register(pit_read_sched_clock, 32, rate);
=20
-	return clocksource_mmio_init(pit->clksrc_base + PITCVAL, "vf-pit", rate,
-				     300, 32, clocksource_mmio_readl_down);
+	return clocksource_register_hz(&pit->cs, rate);
 }
=20
 static int pit_set_next_event(unsigned long delta, struct clock_event_device=
 *ced)

