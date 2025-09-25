Return-Path: <linux-tip-commits+bounces-6742-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9384ABA192A
	for <lists+linux-tip-commits@lfdr.de>; Thu, 25 Sep 2025 23:36:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 498E956461B
	for <lists+linux-tip-commits@lfdr.de>; Thu, 25 Sep 2025 21:36:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99FF33294F0;
	Thu, 25 Sep 2025 21:33:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ZB8XizU5";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="sZAcEa23"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 758E2327A2E;
	Thu, 25 Sep 2025 21:33:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758836005; cv=none; b=SQ82FNK8qLa6/p022ZZzmVsm+TKMGYQYahRW//TqUiBuOU3X69CXGFA3Q10jat2QaMUMlJ5T7ulW/HSE9lhY/bq1Aw6SOVHC1ExE8cXxSg/lTQK+61/pzmTyGyhTBr3CalBjyZscQgIO7fAaMhVJgFQ7bWUvoEtCHZZiYHZbOiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758836005; c=relaxed/simple;
	bh=fIEJ5vZYr6A5LJOwMzIDDlqvo4uCkm8cdyT7315KwqM=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=HmiFU4c5ge9JOEIaywxLDOx6BAy8kASw5vwGD0IKk7A2egXkne58MdqoMgjbj8ufNkXxH0in2b2QzE4eku5okMRNXsbKOFF6xOTtk9IUnNFuQo0JWsm7nB4buKECMM2SNLhwU/XJK3uEgypKK5+BygLHAeO5eQIl32G58VPNFTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ZB8XizU5; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=sZAcEa23; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 25 Sep 2025 21:33:20 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1758836002;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=or6L+VlmHaZJDWNmHIhCe3QtvBGb65iBIhABKUR+p4k=;
	b=ZB8XizU5GbkYEY1RbfL+5BqK+3OcOoW9hEU10M3uSqeKKK2/TFy8PoP53QEh3WYHmBALdR
	RoFFFFey2/crDUxDEsIhFDoNGLBEaI0oOC9YNNLG4X3GUOooox6Xq6e5OBzyqmRZqcqL3T
	k2PLchX8GyUUdOMSOV93yZo1BiZ3dg1m4A3V/pQ07/uXttP1QQhNGmFF+7hcA5OiqMPU8C
	vkQ0Q/GmvFnWj52oc9exeMY+7Non++KiTNTS2zVJ6wRr52I6ZEluY16jbbKwRVRyQc4S2/
	Tany480N/wF6YM+ivpFb7QJ8x0qRIkwKZSYXau9YgdCV4SdSdEtze9qozq1RFQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1758836002;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=or6L+VlmHaZJDWNmHIhCe3QtvBGb65iBIhABKUR+p4k=;
	b=sZAcEa235uKyfCSOcWOO2ZHnY+wPaF0EDrqS3QZkT2MWwET5AglVx6wckDybroMfYEW50n
	LcGn2nx4Z3bHbuDA==
From: "tip-bot2 for Daniel Lezcano" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/clocksource] clocksource/drivers/vf-pit: Consolidate
 calls to pit_*_disable/enable
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175883600065.709179.10173957997148802345.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the timers/clocksource branch of ti=
p:

Commit-ID:     5ba405c719ce68a86308dd3bd90aeea59959030d
Gitweb:        https://git.kernel.org/tip/5ba405c719ce68a86308dd3bd90aeea5995=
9030d
Author:        Daniel Lezcano <daniel.lezcano@linaro.org>
AuthorDate:    Mon, 04 Aug 2025 17:23:34 +02:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Tue, 23 Sep 2025 12:29:55 +02:00

clocksource/drivers/vf-pit: Consolidate calls to pit_*_disable/enable

The difference between the pit_clocksource_enable() and
pit_clocksource_disable() is only setting the TIF flag for the
clockevent. Let's group them and pass the TIF flag parameter to the
function so we save some lines of code. But as the base address is
different regarding if it is a clocksource or a clockevent, we pass
the base address in parameter instead of the struct pit_timer.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Link: https://lore.kernel.org/r/20250804152344.1109310-17-daniel.lezcano@lina=
ro.org
---
 drivers/clocksource/timer-vf-pit.c | 34 +++++++++++------------------
 1 file changed, 13 insertions(+), 21 deletions(-)

diff --git a/drivers/clocksource/timer-vf-pit.c b/drivers/clocksource/timer-v=
f-pit.c
index 5551b61..3825159 100644
--- a/drivers/clocksource/timer-vf-pit.c
+++ b/drivers/clocksource/timer-vf-pit.c
@@ -64,14 +64,16 @@ static inline void pit_module_disable(void __iomem *base)
 	writel(PITMCR_MDIS, PITMCR(base));
 }
=20
-static inline void pit_timer_enable(struct pit_timer *pit)
+static inline void pit_timer_enable(void __iomem *base, bool tie)
 {
-	writel(PITTCTRL_TEN | PITTCTRL_TIE, PITTCTRL(pit->clkevt_base));
+	u32 val =3D PITTCTRL_TEN | (tie ? PITTCTRL_TIE : 0);
+
+	writel(val, PITTCTRL(base));
 }
=20
-static inline void pit_timer_disable(struct pit_timer *pit)
+static inline void pit_timer_disable(void __iomem *base)
 {
-	writel(0, PITTCTRL(pit->clkevt_base));
+	writel(0, PITTCTRL(base));
 }
=20
 static inline void pit_timer_set_counter(void __iomem *base, unsigned int cn=
t)
@@ -79,16 +81,6 @@ static inline void pit_timer_set_counter(void __iomem *bas=
e, unsigned int cnt)
 	writel(cnt, PITLDVAL(base));
 }
=20
-static inline void pit_clocksource_enable(struct pit_timer *pit)
-{
-	writel(PITTCTRL_TEN, PITTCTRL(pit->clksrc_base));
-}
-
-static inline void pit_clocksource_disable(struct pit_timer *pit)
-{
-	pit_timer_disable(pit);
-}
-
 static inline void pit_irq_acknowledge(struct pit_timer *pit)
 {
 	writel(PITTFLG_TIF, PITTFLG(pit->clkevt_base));
@@ -122,9 +114,9 @@ static int __init pit_clocksource_init(struct pit_timer *=
pit, const char *name,
 	pit->cs.flags =3D CLOCK_SOURCE_IS_CONTINUOUS;
=20
 	/* set the max load value and start the clock source counter */
-	pit_clocksource_disable(pit);
+	pit_timer_disable(pit->clksrc_base);
 	pit_timer_set_counter(pit->clksrc_base, ~0);
-	pit_clocksource_enable(pit);
+	pit_timer_enable(pit->clksrc_base, 0);
=20
 	sched_clock_base =3D pit->clksrc_base + PITCVAL_OFFSET;
 	sched_clock_register(pit_read_sched_clock, 32, rate);
@@ -143,9 +135,9 @@ static int pit_set_next_event(unsigned long delta, struct=
 clock_event_device *ce
 	 * and the PITLAVAL should be set to delta minus one according to pit
 	 * hardware requirement.
 	 */
-	pit_timer_disable(pit);
+	pit_timer_disable(pit->clkevt_base);
 	pit_timer_set_counter(pit->clkevt_base, delta - 1);
-	pit_timer_enable(pit);
+	pit_timer_enable(pit->clkevt_base, true);
=20
 	return 0;
 }
@@ -154,7 +146,7 @@ static int pit_shutdown(struct clock_event_device *ced)
 {
 	struct pit_timer *pit =3D ced_to_pit(ced);
=20
-	pit_timer_disable(pit);
+	pit_timer_disable(pit->clkevt_base);
=20
 	return 0;
 }
@@ -182,7 +174,7 @@ static irqreturn_t pit_timer_interrupt(int irq, void *dev=
_id)
 	 * to stop the counter loop in ONESHOT mode.
 	 */
 	if (likely(clockevent_state_oneshot(ced)))
-		pit_timer_disable(pit);
+		pit_timer_disable(pit->clkevt_base);
=20
 	ced->event_handler(ced);
=20
@@ -201,7 +193,7 @@ static int __init pit_clockevent_init(struct pit_timer *p=
it, const char *name,
 	pit->clkevt_base =3D base + PIT_CH(3);
 	pit->cycle_per_jiffy =3D rate / (HZ);
=20
-	pit_timer_disable(pit);
+	pit_timer_disable(pit->clkevt_base);
=20
 	pit_irq_acknowledge(pit);
=20

