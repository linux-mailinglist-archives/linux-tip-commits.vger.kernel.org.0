Return-Path: <linux-tip-commits+bounces-6184-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 620BAB0EBCA
	for <lists+linux-tip-commits@lfdr.de>; Wed, 23 Jul 2025 09:22:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 059FBAA34B6
	for <lists+linux-tip-commits@lfdr.de>; Wed, 23 Jul 2025 07:20:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FC6A278170;
	Wed, 23 Jul 2025 07:17:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="VzdYom2y";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="WnykC2Yl"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 907B5278146;
	Wed, 23 Jul 2025 07:17:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753255066; cv=none; b=tLcKeXsa+fJOIqqR36KDxh8p8D8g7JmhHsb80xDr2VqHG0eS64Ihvt+sTMLcW9q1bX2fJMIqOg1emezPvlylel1p9GYcVgNIfuOwIxPCv88cwjIvMhayo7z7AVeHyN5Kc9DupVSpD5nXgdmY4+Zo0jvvfvKec8NlB47wDHQFOr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753255066; c=relaxed/simple;
	bh=LyBAcxuOzRGjYqYMsEdg/46cLvFOb6IzmjETFQicaUc=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=AvXAPLAdj5H+beaM/papOy9ddlyiMiSDMUnkSrdeaGYSQ7/7dTWJi+9jk052IMAu293jHmMD2T1kEe/idGzUKuoh+F+EaQw/Rra+6uaBOac/suSf2jUY1X51tvGQURvhTebCV6p9L4y7/JGhePFNH0Ga4qenfk0R18fEEb3Y1UA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=VzdYom2y; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=WnykC2Yl; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 23 Jul 2025 07:17:40 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1753255061;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TZm2/WJF4iP1m8B0vjMGnfdaCvfUmhUapJVd1bbEwow=;
	b=VzdYom2yhMRQmASqSWxX5IpsGdni3BvhCFWOmRgHyLDRudfRDk4dqQaELn1BM4xwng4BaZ
	PrGBYX2cR1MiuIyPr5PgZHafsBYX/x100VNcQzSnKHkNHnGLHemNug9/nG5Tum8zZzaYqh
	I1r7YguMmKGsge1rMPkE6EL44JVidR+jGod4vuFEd3zoYQ+/fIrJy8BgYKg46jCs3T9+qS
	MtITwvxwCQ9lJJvLd88N81QhBKHqHnv9ICU15gVlaTsq4vPyLqk8WOJFQWCyKEWljEi1mP
	4cMA70ddLzBfH5Ngv4Rrj9KH6VgRHgQNUC3bT02GQLfPS7Qy74GyzFHFQJlsZQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1753255061;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TZm2/WJF4iP1m8B0vjMGnfdaCvfUmhUapJVd1bbEwow=;
	b=WnykC2YlGKQ8qCtQ8gI7s63NJGlW0FdgTkGmyrUKKcYe3hkqMU5cZt4OSgAb/1EjTXjbeY
	g4Ez1WEVKqctetAA==
From: "tip-bot2 for Daniel Lezcano" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/clocksource] clocksource/drivers/sun5i: Add module owner
Cc: Will McVicker <willmcvicker@google.com>, "Chen-Yu Tsai" <wens@csie.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250602151853.1942521-4-daniel.lezcano@linaro.org>
References: <20250602151853.1942521-4-daniel.lezcano@linaro.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175325506076.1420.17648251485252685187.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the timers/clocksource branch of ti=
p:

Commit-ID:     562eb6fe7f32dd3e032c057c6593124b7afbff19
Gitweb:        https://git.kernel.org/tip/562eb6fe7f32dd3e032c057c6593124b7af=
bff19
Author:        Daniel Lezcano <daniel.lezcano@linaro.org>
AuthorDate:    Mon, 02 Jun 2025 17:18:47 +02:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Thu, 10 Jul 2025 11:28:29 +02:00

clocksource/drivers/sun5i: Add module owner

The conversion to modules requires a correct handling of the module
refcount in order to prevent to unload it if it is in use. That is
especially true with the clockevents where there is no function to
unregister them.

The core time framework correctly handles the module refcount with the
different clocksource and clockevents if the module owner is set.

Add the module owner to make sure the core framework will prevent
stupid things happening when the driver will be converted into a
module.

Reviewed-by: Will McVicker <willmcvicker@google.com>
Acked-by: Chen-Yu Tsai <wens@csie.org>
Link: https://lore.kernel.org/r/20250602151853.1942521-4-daniel.lezcano@linar=
o.org
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/clocksource/timer-sun5i.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/clocksource/timer-sun5i.c b/drivers/clocksource/timer-su=
n5i.c
index 6b48a90..f827d3f 100644
--- a/drivers/clocksource/timer-sun5i.c
+++ b/drivers/clocksource/timer-sun5i.c
@@ -185,6 +185,7 @@ static int sun5i_setup_clocksource(struct platform_device=
 *pdev,
 	cs->clksrc.read =3D sun5i_clksrc_read;
 	cs->clksrc.mask =3D CLOCKSOURCE_MASK(32);
 	cs->clksrc.flags =3D CLOCK_SOURCE_IS_CONTINUOUS;
+	cs->clksrc.owner =3D THIS_MODULE;
=20
 	ret =3D clocksource_register_hz(&cs->clksrc, rate);
 	if (ret) {
@@ -214,6 +215,7 @@ static int sun5i_setup_clockevent(struct platform_device =
*pdev,
 	ce->clkevt.rating =3D 340;
 	ce->clkevt.irq =3D irq;
 	ce->clkevt.cpumask =3D cpu_possible_mask;
+	ce->clkevt.owner =3D THIS_MODULE;
=20
 	/* Enable timer0 interrupt */
 	val =3D readl(base + TIMER_IRQ_EN_REG);

