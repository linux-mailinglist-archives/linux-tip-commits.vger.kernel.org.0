Return-Path: <linux-tip-commits+bounces-6757-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DBD5BA19B7
	for <lists+linux-tip-commits@lfdr.de>; Thu, 25 Sep 2025 23:40:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0CDBC7B5EC3
	for <lists+linux-tip-commits@lfdr.de>; Thu, 25 Sep 2025 21:37:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A455F32D5CD;
	Thu, 25 Sep 2025 21:33:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ywO3eKav";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ey7uyK7w"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA9FE32CF95;
	Thu, 25 Sep 2025 21:33:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758836023; cv=none; b=fKKA7Ig0tM3GgFeqLl3WZDYIZ7pKIVTWCFJyDVwnq2NgDrMTYSvN7trcxbIuhoIXrFZJD8yGNFEEPpxsi+WVF+etBZiRktM9NXs5JKurSjyvL0n1HsjDCQFGDTZJ+z5jZMqdINzWBCV80EDV8OWiQ5bq61Iu6KH4d2xHn1Hmq98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758836023; c=relaxed/simple;
	bh=cfo06/Ntd3r2TbBL3hLr2pdZVto7ZvVKhdVsiKjTOfI=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=gBKDwSljiOvHUX1HiNokAEswulvWegbgwU1nugAZLe4Io4OKDxGlw6bugSLxN1g3U6ZUsq0NkyG65ePrI1BQkBSpw23ZgbVgsPFWks8xW375EKDttjjQxnmAbVvXO26/hAL4q/NOAFh5xZrPDIOx/jQoP8Z80HeIJvGHvjXSi6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ywO3eKav; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ey7uyK7w; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 25 Sep 2025 21:33:39 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1758836020;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=iPdZtFpoMnHragFawqSIU+SA/Vc4r5N8pHsBHWXTMzg=;
	b=ywO3eKavuAcWIzq3cSOJrbBm794Wv29slJiNAJZNyHiaRNN88M7Yfl0PULxrzVLdriFOHS
	gsIRv2HvVr7+AgFbXC8CFVb3i/fyYNoxHQWX+HWOTi/64+k7WxKZ3C8qnLsOh9xWmJl1ko
	kg4FH3+giSPUa2Zi2M+BmO88opOEJDpeaQZ/M/aFdgehc68fVhYF3fzQrNlSroSJMeC6uw
	N1rRzWb2mpJCeRRJxQg9+1OpnV7rjcwpUb0h41eIvgBLY+CmxOj0qT5cxaqZjNXpuhm2Z/
	ojb31zcAz2r7aUN3quh+M64hLY+neCRqnkdj2j7vXmxAP0SRk8GO4HH+TB1Dqg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1758836020;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=iPdZtFpoMnHragFawqSIU+SA/Vc4r5N8pHsBHWXTMzg=;
	b=ey7uyK7wisPj1H6pnFEM2PQ/1HUA+c8cRqswoPb/c8Qbeud3NWpdF80k5qWTczQIwuLAlA
	oj9WOe3Q5OhvAmAA==
From: "tip-bot2 for Daniel Lezcano" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/clocksource] clocksource/drivers/vf-pit: Replace
 raw_readl/writel to readl/writel
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>, Arnd Bergmann <arnd@arndb.de>,
 x86@kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175883601917.709179.6290802957138965971.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the timers/clocksource branch of ti=
p:

Commit-ID:     0b781f527d6f99e68e5b3780ae03cd69a7cb5c0c
Gitweb:        https://git.kernel.org/tip/0b781f527d6f99e68e5b3780ae03cd69a7c=
b5c0c
Author:        Daniel Lezcano <daniel.lezcano@linaro.org>
AuthorDate:    Mon, 04 Aug 2025 17:23:19 +02:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Tue, 23 Sep 2025 12:27:53 +02:00

clocksource/drivers/vf-pit: Replace raw_readl/writel to readl/writel

The driver uses the raw_readl() and raw_writel() functions. Those are
not for MMIO devices. Replace them with readl() and writel()

[ dlezcano: Fixed typo in the subject s/reald/readl/ ]

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Acked-by: Arnd Bergmann <arnd@arndb.de>
Cc: Arnd Bergmann <arnd@arndb.de>
Link: https://lore.kernel.org/r/20250804152344.1109310-2-daniel.lezcano@linar=
o.org
---
 drivers/clocksource/timer-vf-pit.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/clocksource/timer-vf-pit.c b/drivers/clocksource/timer-v=
f-pit.c
index 911c921..8041a8f 100644
--- a/drivers/clocksource/timer-vf-pit.c
+++ b/drivers/clocksource/timer-vf-pit.c
@@ -35,30 +35,30 @@ static unsigned long cycle_per_jiffy;
=20
 static inline void pit_timer_enable(void)
 {
-	__raw_writel(PITTCTRL_TEN | PITTCTRL_TIE, clkevt_base + PITTCTRL);
+	writel(PITTCTRL_TEN | PITTCTRL_TIE, clkevt_base + PITTCTRL);
 }
=20
 static inline void pit_timer_disable(void)
 {
-	__raw_writel(0, clkevt_base + PITTCTRL);
+	writel(0, clkevt_base + PITTCTRL);
 }
=20
 static inline void pit_irq_acknowledge(void)
 {
-	__raw_writel(PITTFLG_TIF, clkevt_base + PITTFLG);
+	writel(PITTFLG_TIF, clkevt_base + PITTFLG);
 }
=20
 static u64 notrace pit_read_sched_clock(void)
 {
-	return ~__raw_readl(clksrc_base + PITCVAL);
+	return ~readl(clksrc_base + PITCVAL);
 }
=20
 static int __init pit_clocksource_init(unsigned long rate)
 {
 	/* set the max load value and start the clock source counter */
-	__raw_writel(0, clksrc_base + PITTCTRL);
-	__raw_writel(~0UL, clksrc_base + PITLDVAL);
-	__raw_writel(PITTCTRL_TEN, clksrc_base + PITTCTRL);
+	writel(0, clksrc_base + PITTCTRL);
+	writel(~0UL, clksrc_base + PITLDVAL);
+	writel(PITTCTRL_TEN, clksrc_base + PITTCTRL);
=20
 	sched_clock_register(pit_read_sched_clock, 32, rate);
 	return clocksource_mmio_init(clksrc_base + PITCVAL, "vf-pit", rate,
@@ -76,7 +76,7 @@ static int pit_set_next_event(unsigned long delta,
 	 * hardware requirement.
 	 */
 	pit_timer_disable();
-	__raw_writel(delta - 1, clkevt_base + PITLDVAL);
+	writel(delta - 1, clkevt_base + PITLDVAL);
 	pit_timer_enable();
=20
 	return 0;
@@ -125,8 +125,8 @@ static struct clock_event_device clockevent_pit =3D {
=20
 static int __init pit_clockevent_init(unsigned long rate, int irq)
 {
-	__raw_writel(0, clkevt_base + PITTCTRL);
-	__raw_writel(PITTFLG_TIF, clkevt_base + PITTFLG);
+	writel(0, clkevt_base + PITTCTRL);
+	writel(PITTFLG_TIF, clkevt_base + PITTFLG);
=20
 	BUG_ON(request_irq(irq, pit_timer_interrupt, IRQF_TIMER | IRQF_IRQPOLL,
 			   "VF pit timer", &clockevent_pit));
@@ -183,7 +183,7 @@ static int __init pit_timer_init(struct device_node *np)
 	cycle_per_jiffy =3D clk_rate / (HZ);
=20
 	/* enable the pit module */
-	__raw_writel(~PITMCR_MDIS, timer_base + PITMCR);
+	writel(~PITMCR_MDIS, timer_base + PITMCR);
=20
 	ret =3D pit_clocksource_init(clk_rate);
 	if (ret)

