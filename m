Return-Path: <linux-tip-commits+bounces-6753-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F3C0FBA1981
	for <lists+linux-tip-commits@lfdr.de>; Thu, 25 Sep 2025 23:38:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B5DC4189F8D4
	for <lists+linux-tip-commits@lfdr.de>; Thu, 25 Sep 2025 21:38:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D84F32CF7D;
	Thu, 25 Sep 2025 21:33:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="xCtYcKqo";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="UbK8h3om"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B70232C320;
	Thu, 25 Sep 2025 21:33:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758836020; cv=none; b=cS5ku1P0b999pgMpmjrYi7bGBBZ/W0UuOsAtqPyJ8vjJ/WwIG7p0fFXIHcQrznrmTJi2RMkRLqNDqRKkFftDYeg08bOKxnfbmUf+Xd+/KiskPkYTWMVvJyyKxvAzFVCbRbQcw01Z68NecYCsN+vQSPNNHH6Hefxekwoq1B3no9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758836020; c=relaxed/simple;
	bh=AXv82Bdn+waBJek2pnXmvdnEj7ZDzsHq08eAKh4VW3c=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=YdUZtWu4KJV9ocef6cbm23KvpEHVSwgIB6RN86Z4ZL5/nyBo9J/mpgPXHB3hcjMJalYlBsW72lRKxffFJxecSJs8PiIc9QNhrVWyHGhHE9pyYqEYc8LM+NbX+dsKOBOhrOocRCBEKURClatIQLqBn31cEPXHIFcPsHs3Ga1HDSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=xCtYcKqo; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=UbK8h3om; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 25 Sep 2025 21:33:35 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1758836016;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=u96dSCYYENagLBtCeMoR+JwRuEWAH0dMlReKU56CvH4=;
	b=xCtYcKqo4GOo+m2406vyl0HNPSNqul9JdHf6lsolR7E/IJRhQN+fB1mo3r/I5SBAqOcMKL
	ROYboHNOK4vqpuv6ChKVBBGnnzvSDnArIahKYNrMLifyzKO//Emxc5v6uQqgTL2q5hx333
	RDNRs4BqHpkbRWBB/g249l+nGxh5vfamPzlLkSFnAHUA0nuwWKj4mHQpCpe4xM2H3YgYRF
	GA/fyEm8uaQc5/kFru4rwCg7hag0lm+w+R6ryNt0fLTwLRf8WUJJe8cZRtBHOEGk5yc/YU
	J1HgUsc7YRzJMuJFmjUD1nTDzyLMZQAczmV9wKuboEf116zWQOwhJzukvL7nPw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1758836016;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=u96dSCYYENagLBtCeMoR+JwRuEWAH0dMlReKU56CvH4=;
	b=UbK8h3omKj6Kut3xT4TwMT0OOp+2PUIv84KCyePtMWMxDr/daA7/VcwaFKcIqboaYVuWOa
	OHsGQcrroY5tIIAw==
From: "tip-bot2 for Daniel Lezcano" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/clocksource] clocksource/drivers/vf-pit: Rework the base
 address usage
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175883601551.709179.8418809190993423615.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the timers/clocksource branch of ti=
p:

Commit-ID:     361580317976ff25ce4eddbf207d06b0aca9ab22
Gitweb:        https://git.kernel.org/tip/361580317976ff25ce4eddbf207d06b0aca=
9ab22
Author:        Daniel Lezcano <daniel.lezcano@linaro.org>
AuthorDate:    Mon, 04 Aug 2025 17:23:22 +02:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Tue, 23 Sep 2025 12:28:42 +02:00

clocksource/drivers/vf-pit: Rework the base address usage

This change passes the base address to the clockevent and clocksource
initialization functions in order to use different base address in the
next changes.

No functional changes intended.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Link: https://lore.kernel.org/r/20250804152344.1109310-5-daniel.lezcano@linar=
o.org
---
 drivers/clocksource/timer-vf-pit.c | 35 ++++++++++++++++++-----------
 1 file changed, 22 insertions(+), 13 deletions(-)

diff --git a/drivers/clocksource/timer-vf-pit.c b/drivers/clocksource/timer-v=
f-pit.c
index e4a8b32..6a5f940 100644
--- a/drivers/clocksource/timer-vf-pit.c
+++ b/drivers/clocksource/timer-vf-pit.c
@@ -66,8 +66,16 @@ static u64 notrace pit_read_sched_clock(void)
 	return ~readl(clksrc_base + PITCVAL);
 }
=20
-static int __init pit_clocksource_init(struct pit_timer *pit, unsigned long =
rate)
+static int __init pit_clocksource_init(struct pit_timer *pit, void __iomem *=
base,
+				       unsigned long rate)
 {
+	/*
+	 * The channels 0 and 1 can be chained to build a 64-bit
+	 * timer. Let's use the channel 2 as a clocksource and leave
+	 * the channels 0 and 1 unused for anyone else who needs them
+	 */
+	pit->clksrc_base =3D base + PIT_CH(2);
+
 	/* set the max load value and start the clock source counter */
 	writel(0, pit->clksrc_base + PITTCTRL);
 	writel(~0, pit->clksrc_base + PITLDVAL);
@@ -76,8 +84,9 @@ static int __init pit_clocksource_init(struct pit_timer *pi=
t, unsigned long rate
 	clksrc_base =3D pit->clksrc_base;
=20
 	sched_clock_register(pit_read_sched_clock, 32, rate);
+
 	return clocksource_mmio_init(pit->clksrc_base + PITCVAL, "vf-pit", rate,
-			300, 32, clocksource_mmio_readl_down);
+				     300, 32, clocksource_mmio_readl_down);
 }
=20
 static int pit_set_next_event(unsigned long delta, struct clock_event_device=
 *ced)
@@ -137,8 +146,16 @@ static irqreturn_t pit_timer_interrupt(int irq, void *de=
v_id)
 	return IRQ_HANDLED;
 }
=20
-static int __init pit_clockevent_init(struct pit_timer *pit, unsigned long r=
ate, int irq)
+static int __init pit_clockevent_init(struct pit_timer *pit, void __iomem *b=
ase,
+				      unsigned long rate, int irq)
 {
+	/*
+	 * The channels 0 and 1 can be chained to build a 64-bit
+	 * timer. Let's use the channel 3 as a clockevent and leave
+	 * the channels 0 and 1 unused for anyone else who needs them
+	 */
+	pit->clkevt_base =3D base + PIT_CH(3);
+
 	writel(0, pit->clkevt_base + PITTCTRL);
=20
 	writel(PITTFLG_TIF, pit->clkevt_base + PITTFLG);
@@ -182,14 +199,6 @@ static int __init pit_timer_init(struct device_node *np)
 		return -ENXIO;
 	}
=20
-	/*
-	 * PIT0 and PIT1 can be chained to build a 64-bit timer,
-	 * so choose PIT2 as clocksource, PIT3 as clockevent device,
-	 * and leave PIT0 and PIT1 unused for anyone else who needs them.
-	 */
-	pit_timer.clksrc_base =3D timer_base + PIT_CH(2);
-	pit_timer.clkevt_base =3D timer_base + PIT_CH(3);
-
 	irq =3D irq_of_parse_and_map(np, 0);
 	if (irq <=3D 0)
 		return -EINVAL;
@@ -208,10 +217,10 @@ static int __init pit_timer_init(struct device_node *np)
 	/* enable the pit module */
 	writel(~PITMCR_MDIS, timer_base + PITMCR);
=20
-	ret =3D pit_clocksource_init(&pit_timer, clk_rate);
+	ret =3D pit_clocksource_init(&pit_timer, timer_base, clk_rate);
 	if (ret)
 		return ret;
=20
-	return pit_clockevent_init(&pit_timer, clk_rate, irq);
+	return pit_clockevent_init(&pit_timer, timer_base, clk_rate, irq);
 }
 TIMER_OF_DECLARE(vf610, "fsl,vf610-pit", pit_timer_init);

