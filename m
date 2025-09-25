Return-Path: <linux-tip-commits+bounces-6752-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6018BBA1978
	for <lists+linux-tip-commits@lfdr.de>; Thu, 25 Sep 2025 23:38:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F00601C81C9F
	for <lists+linux-tip-commits@lfdr.de>; Thu, 25 Sep 2025 21:38:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31C4B32C31C;
	Thu, 25 Sep 2025 21:33:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="3NKkC9Dr";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="v8lXTuG/"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5828632BC1D;
	Thu, 25 Sep 2025 21:33:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758836018; cv=none; b=barNx33kgrLI97ZF/TDz84/v2cqQNcISWKWHB697OthEx5hRaNbbkmD1JlYGtl1DqeU/q5pHGGEoSAtSw0m5xaMDbGC98o9kuLwrlbEEXy6coTSNNi31EFmFjsrjrQRWSTFvzZOUDdqTHmkbevmiosfu2nCTHmcpkBRiehLc2+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758836018; c=relaxed/simple;
	bh=sKDyCE5qHc2qszO1StcmPMZLojkJMqXLk9gZHAqCXqg=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=ukfEXnIWzqtksDnNmIOzHshPg10bPo/Cg0BNpUD6KUAGtYl8xV392vVnNq/LNEb2fg34XyKr15qnGeV/2uFtdvckiX/T1zZkFK4858MwEQgrTlwKqwi90ZsjZAa6TCYt/GaG7pbIrR4wjecJ0Z01MbIOm/5yaNkuSpYTz2CbGh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=3NKkC9Dr; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=v8lXTuG/; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 25 Sep 2025 21:33:33 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1758836014;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=Dk4BRclWyNaujPQBQe7s1RoporEJHO5R7ukekWsjCHE=;
	b=3NKkC9Dr5rpp/Q9yQCOX9ha6lF2dnBdsBoOGbUnoMuzBvWoVo9WLAmWJZ3b7A3QGgvieE7
	tbtQ/JwRkKSCxeR5qztmSwWJe68kTMmEn1Dt6MDlFIKQg/bGxIfUWocFrDfIQQDvmsZblC
	bZc7dfZQA7UxZLBVAIEKIvhFiAq4FpmEAfo9CU710bL53oo7PnlAqOOnngjrQ+xPF/cdxx
	mm0Q0TTgl4qjQzEmR6qtqM/sn59dGilPhk8QZcxsoLQ6cxKW0S/J006bHjr39+xY+Ui2h6
	HtLE+0ibim7O4w6Cd54kqy1hhqOlfddA4QNy2vCcdfW51ORB4F+rTaJA95RR+A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1758836014;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=Dk4BRclWyNaujPQBQe7s1RoporEJHO5R7ukekWsjCHE=;
	b=v8lXTuG/VpYscqDv0fFiOMQ2irN9qRojbP138ElAXkiJTi7znWyM3azkghY4Zr+/gwGHye
	Wptbpbp7zshV4FAA==
From: "tip-bot2 for Daniel Lezcano" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/clocksource] clocksource/drivers/vf-pit: Encapsulate the
 initialization of the cycles_per_jiffy
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175883601314.709179.18149156507351302618.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the timers/clocksource branch of ti=
p:

Commit-ID:     8b0795e0fc0cf181ecab59d3a9a1618886ea995b
Gitweb:        https://git.kernel.org/tip/8b0795e0fc0cf181ecab59d3a9a1618886e=
a995b
Author:        Daniel Lezcano <daniel.lezcano@linaro.org>
AuthorDate:    Mon, 04 Aug 2025 17:23:24 +02:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Tue, 23 Sep 2025 12:28:56 +02:00

clocksource/drivers/vf-pit: Encapsulate the initialization of the cycles_per_=
jiffy

Move the cycles_per_jiffy initialization to the same place where the
other pit timer fields are initialized.

No functional changes intended.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Link: https://lore.kernel.org/r/20250804152344.1109310-7-daniel.lezcano@linar=
o.org
---
 drivers/clocksource/timer-vf-pit.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clocksource/timer-vf-pit.c b/drivers/clocksource/timer-v=
f-pit.c
index 9f3b72b..a11e6a6 100644
--- a/drivers/clocksource/timer-vf-pit.c
+++ b/drivers/clocksource/timer-vf-pit.c
@@ -155,6 +155,7 @@ static int __init pit_clockevent_init(struct pit_timer *p=
it, void __iomem *base,
 	 * the channels 0 and 1 unused for anyone else who needs them
 	 */
 	pit->clkevt_base =3D base + PIT_CH(3);
+	pit->cycle_per_jiffy =3D rate / (HZ);
=20
 	writel(0, pit->clkevt_base + PITTCTRL);
=20
@@ -212,7 +213,6 @@ static int __init pit_timer_init(struct device_node *np)
 		return ret;
=20
 	clk_rate =3D clk_get_rate(pit_clk);
-	pit_timer.cycle_per_jiffy =3D clk_rate / (HZ);
=20
 	/* enable the pit module */
 	writel(~PITMCR_MDIS, timer_base + PITMCR);

