Return-Path: <linux-tip-commits+bounces-6729-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CC4E5BA18D9
	for <lists+linux-tip-commits@lfdr.de>; Thu, 25 Sep 2025 23:33:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E58551C248C2
	for <lists+linux-tip-commits@lfdr.de>; Thu, 25 Sep 2025 21:34:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85598322DB2;
	Thu, 25 Sep 2025 21:32:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="3gJ8o8kp";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="h0sW8nuO"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1FE0322A37;
	Thu, 25 Sep 2025 21:32:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758835979; cv=none; b=hvazoFwpppwcWy3ANojoNoeujmWxOs6WJqXucxpBenLVMwbB93/KqeayekqJwEwtYvLhnkM40RKHfxIC1qL5BgS0TkDnq9xZFHVb0FWvZq8FgNcY2yBgbyMt4LxWFoTvth6wAXxQoKAJTdCyC/DcogDSQlpVJDiFHRkAeA80h1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758835979; c=relaxed/simple;
	bh=4hkjYtIBvtVIvQ0/uV4kT4jEz94EoTZsE7I1Y/DJ4Sk=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=C2YVGj79usQXEMhTArCg53CrBWa9V6SmUfztzZ4EshN+0pthq0RxO14lt30aAQVWAVEqS5vGIAR44dUFf5IUC1kguu28CmVgzEFz3wrElPjDGArS9gPCj/8OuD7lL/nbHFA531HOMiTJ7aMLROu+xhNHPN8iy1uvUgYGDyA86Ic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=3gJ8o8kp; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=h0sW8nuO; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 25 Sep 2025 21:32:55 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1758835976;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=2yj/z0o9bVVZAFGUpsuihDm3mm7ANtastSMv8P6Os7I=;
	b=3gJ8o8kppuH95whmSe5an46m9P2eDBpVafrl32RXyXEoavz+FwCzKuEGpSFu0dQ7A0RbiS
	bBuOaYy1aYe2cEQivk391LJSjaQl/GxergbOcQjjcWe4XLIrIlW9j7pIgUpKt2GeUdZka2
	hfAIjA/HuPf1LzZlVt1tDVSruRMmS8hEvtBdCu4hnsroj9lx+IzMKnEss3xoxMpk3AKGKp
	uX6opRA7nWcon5iYA6GdPIN7XpynoXLAufRlanIe4CpQVOr7rT3C+kmYczQRecEX1LebEN
	zglNj/TbFUEEV8bacgv7LxlB4cy0pdVT/Fel8AeNo9yR2GYwMqVJo7fhw5Xs4w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1758835976;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=2yj/z0o9bVVZAFGUpsuihDm3mm7ANtastSMv8P6Os7I=;
	b=h0sW8nuOGGxN4ImsmYlPItP9U1Is4ISDEYl7/6W763xi1mTBfqr1mTwtwA6c+zEIsjJBI+
	aD43WLQZ8okvi6CA==
From: "tip-bot2 for Markus Stockhausen" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/clocksource] clocksource/drivers/timer-rtl-otto: Do not
 interfere with interrupts
Cc: Markus Stockhausen <markus.stockhausen@gmx.de>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 Stephen Howell <howels@allthatwemight.be>, bjorn@mork.no, x86@kernel.org,
 linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175883597505.709179.7983843522537898239.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the timers/clocksource branch of ti=
p:

Commit-ID:     c445bffbf28f721e05d0ce06895045fc62aaff7c
Gitweb:        https://git.kernel.org/tip/c445bffbf28f721e05d0ce06895045fc62a=
aff7c
Author:        Markus Stockhausen <markus.stockhausen@gmx.de>
AuthorDate:    Mon, 04 Aug 2025 04:03:27 -04:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Tue, 23 Sep 2025 12:41:11 +02:00

clocksource/drivers/timer-rtl-otto: Do not interfere with interrupts

During normal operation the timers are reprogrammed including an
interrupt acknowledgement. This has no effect as the whole timer
is setup from scratch afterwards. Especially in an interrupt this
has already been done by rttm_timer_interrupt().

Change the behaviour as follows:

- Use rttm_disable_timer() during reprogramming
- Keep rttm_stop_timer() for all other use cases.

Downstream has already tested and confirmed a patch. See
https://github.com/openwrt/openwrt/pull/19468
https://forum.openwrt.org/t/support-for-rtl838x-based-managed-switches/57875/=
3788

Signed-off-by: Markus Stockhausen <markus.stockhausen@gmx.de>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Tested-by: Stephen Howell <howels@allthatwemight.be>
Tested-by: Bj=C3=B8rn Mork <bjorn@mork.no>
Link: https://lore.kernel.org/r/20250804080328.2609287-4-markus.stockhausen@g=
mx.de
---
 drivers/clocksource/timer-rtl-otto.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/clocksource/timer-rtl-otto.c b/drivers/clocksource/timer=
-rtl-otto.c
index 48ba116..42f702a 100644
--- a/drivers/clocksource/timer-rtl-otto.c
+++ b/drivers/clocksource/timer-rtl-otto.c
@@ -141,7 +141,7 @@ static int rttm_next_event(unsigned long delta, struct cl=
ock_event_device *clkev
=20
 	RTTM_DEBUG(to->of_base.base);
 	rttm_bounce_timer(to->of_base.base, RTTM_CTRL_COUNTER);
-	rttm_stop_timer(to->of_base.base);
+	rttm_disable_timer(to->of_base.base);
 	rttm_set_period(to->of_base.base, delta);
 	rttm_start_timer(to, RTTM_CTRL_COUNTER);
=20
@@ -154,7 +154,7 @@ static int rttm_state_oneshot(struct clock_event_device *=
clkevt)
=20
 	RTTM_DEBUG(to->of_base.base);
 	rttm_bounce_timer(to->of_base.base, RTTM_CTRL_COUNTER);
-	rttm_stop_timer(to->of_base.base);
+	rttm_disable_timer(to->of_base.base);
 	rttm_set_period(to->of_base.base, RTTM_TICKS_PER_SEC / HZ);
 	rttm_start_timer(to, RTTM_CTRL_COUNTER);
=20
@@ -167,7 +167,7 @@ static int rttm_state_periodic(struct clock_event_device =
*clkevt)
=20
 	RTTM_DEBUG(to->of_base.base);
 	rttm_bounce_timer(to->of_base.base, RTTM_CTRL_TIMER);
-	rttm_stop_timer(to->of_base.base);
+	rttm_disable_timer(to->of_base.base);
 	rttm_set_period(to->of_base.base, RTTM_TICKS_PER_SEC / HZ);
 	rttm_start_timer(to, RTTM_CTRL_TIMER);
=20

