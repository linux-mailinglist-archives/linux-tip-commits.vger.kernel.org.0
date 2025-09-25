Return-Path: <linux-tip-commits+bounces-6772-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6000FBA1A17
	for <lists+linux-tip-commits@lfdr.de>; Thu, 25 Sep 2025 23:43:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4203D7B9F19
	for <lists+linux-tip-commits@lfdr.de>; Thu, 25 Sep 2025 21:40:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F40D330D52;
	Thu, 25 Sep 2025 21:34:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="O2/6Rj63";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="W+b4FPZE"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 613EF32F778;
	Thu, 25 Sep 2025 21:34:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758836042; cv=none; b=GEtAuav70qsZ0nWZVPBrxfJu/KaCP7O+acOEZ0iQehjxYF57D+jcXhJ+v7akeOySUn5v56sn2paQsX8OZg+PgDLA3GkLyj6sISzeVduu0794TNxth+oxlr4zJGn4ubj6oNtzF5ag+B3DZltjCC0lamTWDskn38FMoHIhl6boG2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758836042; c=relaxed/simple;
	bh=v5wffslKcFAm8iUtPOvVKTUCcz8EcR5E6OkN1aExEZY=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=QIiKKH2CcHpLTlnnB8w7JgcHYOhNBGahf7hVYpbnzwqf+2TzklCisMegiw8p5KNuN9c/LNioJHH4NCb7fsBPYAooTbLKkD6wdZ6pY5IUJKRTigbPaV1YeAlzA68DwL1kAq99LaY2L4I+ALjyu1RTX9Egiv6ump1x3C4DbWxN+FA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=O2/6Rj63; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=W+b4FPZE; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 25 Sep 2025 21:33:57 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1758836038;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=vqGfwSn9gMqj9dBPA0/41T1mZSXDJJSrluvzJdhqEeY=;
	b=O2/6Rj63a2n34xRKo+XL2/gtnHETQr4tg/diVPEjDi53gqCIxUCAGh3zUObnroa34P9w55
	N4mZRWrNmbda0U9lupL6rp0l6Xn+KVavWJwAredavpVBWR+M5TnykjDu6NL8N7UUaK1eBY
	pXZ5g1QFiK4N9G5gvkUSXZNjdAAk5slOk+Uzwm44lSiV1drWe7weh1DUstoh27ght9//2Z
	8BeQDSu63BHt5TL+qjGGrC8qzWLf4jSyMdnLJNadtneuKTbL5LPyON54MN2QuaRdCJtMbV
	t7H6EO/HOnm3i2seLKsRozXUe47fv1Hwf7dtBcSFdyrlckPzCahligUaBSuUNQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1758836038;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=vqGfwSn9gMqj9dBPA0/41T1mZSXDJJSrluvzJdhqEeY=;
	b=W+b4FPZEsphWSAIRiqUMHri+K/PyCSI858qy8V94ldDwHKGt763zCEkditZFRs9s829OyM
	0t6ZuY00UeRBtOBg==
From: "tip-bot2 for Daniel Lezcano" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/clocksource] clocksource/drivers/sun5i: Add module owner
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>,
 Will McVicker <willmcvicker@google.com>, "Chen-Yu Tsai" <wens@csie.org>,
 x86@kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175883603728.709179.10437835433249522189.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the timers/clocksource branch of ti=
p:

Commit-ID:     376d11d32718c4d965714278ac6e6605d944fca2
Gitweb:        https://git.kernel.org/tip/376d11d32718c4d965714278ac6e6605d94=
4fca2
Author:        Daniel Lezcano <daniel.lezcano@linaro.org>
AuthorDate:    Mon, 02 Jun 2025 17:18:47 +02:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Tue, 23 Sep 2025 10:51:44 +02:00

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

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Reviewed-by: Will McVicker <willmcvicker@google.com>
Acked-by: Chen-Yu Tsai <wens@csie.org>
Link: https://lore.kernel.org/r/20250602151853.1942521-4-daniel.lezcano@linar=
o.org
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

