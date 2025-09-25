Return-Path: <linux-tip-commits+bounces-6743-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C79C9BA1942
	for <lists+linux-tip-commits@lfdr.de>; Thu, 25 Sep 2025 23:36:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7C7041C81317
	for <lists+linux-tip-commits@lfdr.de>; Thu, 25 Sep 2025 21:36:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F39C2322A15;
	Thu, 25 Sep 2025 21:33:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="z88VFpt+";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="1gZlH7Eu"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16D3C286D70;
	Thu, 25 Sep 2025 21:33:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758836006; cv=none; b=aLMTuEXu6HSh6khItz8ncmtfa0gqBdVLPr0JpT0veKCSLSjaRIzyUMLf6nErRVtXlhMzkLBXbZK8abF2VTMmqQyMmMjDZZjA2TLI1BDqpR8D5StP258UOjWkOglY4KmL4l4/DG6O/tnp9CCXxSJpNROzkuHAh0XnZ9GFgIeqJrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758836006; c=relaxed/simple;
	bh=yozqPgxa1CW3JNaleeIp0W/3WjBycENOPov7GzWnmds=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=mdCe1pSyAlB3J+x9nkZS+ZFgtisY9F4mm0/7puKaXnr2ThHWKopAsX9icdZrb1k2+n0u69apE9rRaPL6f/lTVo+EwlenLJC+crL3R1RjMpo761GiEgW4rHgxfA2Q8RQr3uhrMIAitELmZWmVgsuq9wk7V3lT8zMqDezHXQdlKtU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=z88VFpt+; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=1gZlH7Eu; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 25 Sep 2025 21:33:22 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1758836003;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=fqLhe+mjz2mp30tg9EZvRoI0FbSYgNE8XwOKmU1JpQg=;
	b=z88VFpt+8yrkAYIjSEV99GuZEGNif5rWmJF5BWAinji3k61oWnp7mzK3XBjLF5pxf48tmj
	K+yE3zjMVHo6/oKNiOMrfRjvrbah3bQnhBSDKZELLMlR4PrzWoKth+Oy+d+W+l0SQRbZxy
	8VhP5o1HIHJLrYT3HZEx2oLNZkVtArD1DxdxKEmCHMN+ItjgKvB0HkZV3RkjDq97VoLRQT
	Jv5pJ6Oan7IZaXOjFwflngLwKslITvkdLX4IPSOspQsnqNiFLq84Mc0PVDD/wElrgiRAbc
	ByLPqdiquOD9vKjSmB9bsvcvow+ivHiYphnIa1XQAPWe5i7QOhzet0t5q1s+hw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1758836003;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=fqLhe+mjz2mp30tg9EZvRoI0FbSYgNE8XwOKmU1JpQg=;
	b=1gZlH7EuQlX6mW86v7Qwj6VJvccoNC/VTJb/JNOtPUr+JaLOgkAfUk6MHWlS9eDMAZ6CPc
	7zsdk8Eycgh5v/CA==
From: "tip-bot2 for Daniel Lezcano" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/clocksource] clocksource/drivers/vf-pit: Encapsulate set
 counter function
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175883600206.709179.12617389352911061668.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the timers/clocksource branch of ti=
p:

Commit-ID:     46e83e4afc05c87b5edc2b0b4765283f101af0c6
Gitweb:        https://git.kernel.org/tip/46e83e4afc05c87b5edc2b0b4765283f101=
af0c6
Author:        Daniel Lezcano <daniel.lezcano@linaro.org>
AuthorDate:    Mon, 04 Aug 2025 17:23:33 +02:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Tue, 23 Sep 2025 12:29:50 +02:00

clocksource/drivers/vf-pit: Encapsulate set counter function

Encapsulate the writel() calls to set the counter into a
self-explainatory function.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Link: https://lore.kernel.org/r/20250804152344.1109310-16-daniel.lezcano@lina=
ro.org
---
 drivers/clocksource/timer-vf-pit.c |  9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/clocksource/timer-vf-pit.c b/drivers/clocksource/timer-v=
f-pit.c
index 609a4d9..5551b61 100644
--- a/drivers/clocksource/timer-vf-pit.c
+++ b/drivers/clocksource/timer-vf-pit.c
@@ -74,6 +74,11 @@ static inline void pit_timer_disable(struct pit_timer *pit)
 	writel(0, PITTCTRL(pit->clkevt_base));
 }
=20
+static inline void pit_timer_set_counter(void __iomem *base, unsigned int cn=
t)
+{
+	writel(cnt, PITLDVAL(base));
+}
+
 static inline void pit_clocksource_enable(struct pit_timer *pit)
 {
 	writel(PITTCTRL_TEN, PITTCTRL(pit->clksrc_base));
@@ -118,7 +123,7 @@ static int __init pit_clocksource_init(struct pit_timer *=
pit, const char *name,
=20
 	/* set the max load value and start the clock source counter */
 	pit_clocksource_disable(pit);
-	writel(~0, PITLDVAL(pit->clksrc_base));
+	pit_timer_set_counter(pit->clksrc_base, ~0);
 	pit_clocksource_enable(pit);
=20
 	sched_clock_base =3D pit->clksrc_base + PITCVAL_OFFSET;
@@ -139,7 +144,7 @@ static int pit_set_next_event(unsigned long delta, struct=
 clock_event_device *ce
 	 * hardware requirement.
 	 */
 	pit_timer_disable(pit);
-	writel(delta - 1, PITLDVAL(pit->clkevt_base));
+	pit_timer_set_counter(pit->clkevt_base, delta - 1);
 	pit_timer_enable(pit);
=20
 	return 0;

