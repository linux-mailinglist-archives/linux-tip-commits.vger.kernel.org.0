Return-Path: <linux-tip-commits+bounces-6745-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DE91BA1945
	for <lists+linux-tip-commits@lfdr.de>; Thu, 25 Sep 2025 23:36:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0408117A96A
	for <lists+linux-tip-commits@lfdr.de>; Thu, 25 Sep 2025 21:36:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E88132A80B;
	Thu, 25 Sep 2025 21:33:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="bDeGYLP7";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="41K4rdHL"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F01532A3D4;
	Thu, 25 Sep 2025 21:33:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758836010; cv=none; b=XFNvCfLW78l+p2I5vU5mJVJ7cfXjKaaNcOJO8djRS2/JlFTwc6rS/F+HNhjlgdsl7YcUcOqprD1rFRrkR1Uw0Z6z2lpVhHr8+Cv03J+Z1iiNaoZsxQvvWkrN6+T2Q6Kk6qC2VIZjE+JcC+BJJv/X0re3CaUmZP8LXgYBdFrqGVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758836010; c=relaxed/simple;
	bh=x5yDctqJ4mATiZuft9mitmx8y6UN/IZoAk98t0JCbZ4=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=IUvqL/Ca3H0u3BHX1yostGnfkqIGdYo6k8g/kRGOvZFkdU5I7huIvi++Gm/15T0Acuc1oVhRReGK0GILOI+p7SocsbAGUyBrVZWT+X7zwNiCa0NbRgnhT7J7dMCy1GLPm8nMnRnb4EUbfiGFFG1oshsrIPG0DQq/ZLOAmfgChGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=bDeGYLP7; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=41K4rdHL; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 25 Sep 2025 21:33:24 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1758836005;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=vPMHyPvmQtb4AAalFlPM9c+eTF4gqJBa5m1Y7sDyVQY=;
	b=bDeGYLP78UwkF0VVy4QbgvSt00e9oBfEhl9q8feePH0E5tDs/DsI0wDeArrDGwA1caFBUM
	4Hj5ZKc9BwY3aFoOl6zXgNsGLugMQVEVXDWH4fRTMX9sH73ksz7MjYR1ZvsTMAHmlYI05e
	SHsTqq9D3Q1oXUIT5vUjDuevsLuB4A96Y8JIT9MATwOZ9t0pzP0TeuZFRiXD/U6NoSOlpJ
	A3AeGSdr1bjQtylPRcLHnK9+UPwQ1YOpD6BDT0j3i56QL0byq2GAHvGTKWDpPH3GFMA/Fn
	hdmScRgKRRcsVikDqGjInhzK5tze6/OBbNHRjfLkKIdv7XzET57piVoR6UNPjg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1758836005;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=vPMHyPvmQtb4AAalFlPM9c+eTF4gqJBa5m1Y7sDyVQY=;
	b=41K4rdHLmW8Zjk95HgvkVhKQk8FCnhd7cbDTXQDgU6Cf9JeFKygEHXh+OfioTql3PvVWX7
	9ZQrJDnzSJ3fwgBQ==
From: "tip-bot2 for Daniel Lezcano" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/clocksource] clocksource/drivers/vf-pit: Encapsulate
 clocksource enable / disable
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175883600455.709179.1108311024852049680.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the timers/clocksource branch of ti=
p:

Commit-ID:     fcf25b4427c7d1edb91dd02753d6153fb25da094
Gitweb:        https://git.kernel.org/tip/fcf25b4427c7d1edb91dd02753d6153fb25=
da094
Author:        Daniel Lezcano <daniel.lezcano@linaro.org>
AuthorDate:    Mon, 04 Aug 2025 17:23:31 +02:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Tue, 23 Sep 2025 12:29:39 +02:00

clocksource/drivers/vf-pit: Encapsulate clocksource enable / disable

For the sake of lisibility, let's encapsulate the writel calls to
enable and disable the timer into a function with a self-explainatory
name.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Link: https://lore.kernel.org/r/20250804152344.1109310-14-daniel.lezcano@lina=
ro.org
---
 drivers/clocksource/timer-vf-pit.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/drivers/clocksource/timer-vf-pit.c b/drivers/clocksource/timer-v=
f-pit.c
index 2a255b4..9637708 100644
--- a/drivers/clocksource/timer-vf-pit.c
+++ b/drivers/clocksource/timer-vf-pit.c
@@ -62,6 +62,16 @@ static inline void pit_timer_disable(struct pit_timer *pit)
 	writel(0, PITTCTRL(pit->clkevt_base));
 }
=20
+static inline void pit_clocksource_enable(struct pit_timer *pit)
+{
+	writel(PITTCTRL_TEN, PITTCTRL(pit->clksrc_base));
+}
+
+static inline void pit_clocksource_disable(struct pit_timer *pit)
+{
+	pit_timer_disable(pit);
+}
+
 static inline void pit_irq_acknowledge(struct pit_timer *pit)
 {
 	writel(PITTFLG_TIF, PITTFLG(pit->clkevt_base));
@@ -95,9 +105,9 @@ static int __init pit_clocksource_init(struct pit_timer *p=
it, const char *name,
 	pit->cs.flags =3D CLOCK_SOURCE_IS_CONTINUOUS;
=20
 	/* set the max load value and start the clock source counter */
-	pit_timer_disable(pit);
+	pit_clocksource_disable(pit);
 	writel(~0, PITLDVAL(pit->clksrc_base));
-	writel(PITTCTRL_TEN, PITTCTRL(pit->clksrc_base));
+	pit_clocksource_enable(pit);
=20
 	sched_clock_base =3D pit->clksrc_base + PITCVAL_OFFSET;
 	sched_clock_register(pit_read_sched_clock, 32, rate);

