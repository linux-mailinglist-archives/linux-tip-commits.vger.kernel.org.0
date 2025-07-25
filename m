Return-Path: <linux-tip-commits+bounces-6214-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 01939B11C8D
	for <lists+linux-tip-commits@lfdr.de>; Fri, 25 Jul 2025 12:36:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1F5BD4E09E6
	for <lists+linux-tip-commits@lfdr.de>; Fri, 25 Jul 2025 10:35:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BC722ED868;
	Fri, 25 Jul 2025 10:32:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="jUv0e6Sn";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="51sU5GZF"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50C5F2ED163;
	Fri, 25 Jul 2025 10:31:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753439521; cv=none; b=Aj26O2RRHpWRg2OOhPfqtgpw5YTAAELxKu4/A4Z9VZUvxTS/ScZxY3mqdAvf10Zgxh5G/AuisCRFREucfGSrpRkGVrRFTxaSZET8rlZy6v9466remwSXvkxed6mPe+7dGR7TeHPK2Gf/R/pVBEpihqmavxQ+bQdrO2qor20jBOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753439521; c=relaxed/simple;
	bh=mZkJ09HpKKkyfz50Lrq3zqQTl/Uj2cibPFsJkt4h738=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=XJCNpoDFqYCBbMBv2qXx26f7moetvAPHpIsRERzAVYEoMIkMl/oo7LwMnYT0ENt0piovk6Wvyf/YL+c0IoB/fCN/hY9IR4KzYTAvA7ABd+1BXWPg/2gedv+xxoUbwGPew8GeErZzDBTNOzJZJosCi4VRi6EEYkhkoBak25c1UVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=jUv0e6Sn; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=51sU5GZF; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 25 Jul 2025 10:31:55 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1753439516;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IwEbucBgrh9fqalGWAoBWN/dkt7X+G6/3C8iDFPjYRY=;
	b=jUv0e6SnNf2ktHagSxGfaSlNII2dltSzyHiDZidhCix0/2BYrN0jIxRQnv0o+ptsBtUOcZ
	SbcmAsLlrC7CAeFOU8GVIfNNkK8lAVOG3JkL2YULfmgZQkZQFNCBwALu06bcXfEg5jph2x
	/kNDCEety9/z84HonEGiMDQ9oVgLiCrVO73wJn5sHh7/+6O9S7CYkqwX87jHpnUUy1T7Bx
	howRTxm4NO1DBes+vuptwxKDKJd9HIckA5q7bg/whxqAriN6dMWIAoGg0P3I9XLFvTMcIX
	OK1BVDNnteryFlUvNL+wA37M3l3hXnyYxUNiia9bfzSt7fRbi6X+fyp5tsr9qg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1753439516;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IwEbucBgrh9fqalGWAoBWN/dkt7X+G6/3C8iDFPjYRY=;
	b=51sU5GZFKxArTf1SLOgixfwnFEsg0VtVev4PbzNA1BL6GBD3aiNpbZT48dVYpMiEgNIejF
	syt1oMx5QCBRtpAw==
From: "tip-bot2 for Daniel Lezcano" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/clocksource] clocksource/drivers/sun5i: Add module owner
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>, Ingo Molnar <mingo@kernel.org>,
 Will McVicker <willmcvicker@google.com>, "Chen-Yu Tsai" <wens@csie.org>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250602151853.1942521-4-daniel.lezcano@linaro.org>
References: <20250602151853.1942521-4-daniel.lezcano@linaro.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175343951511.1420.10772161053647291523.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the timers/clocksource branch of ti=
p:

Commit-ID:     d89048fedbe7a13056497a2bd93e28981e17c6fe
Gitweb:        https://git.kernel.org/tip/d89048fedbe7a13056497a2bd93e28981e1=
7c6fe
Author:        Daniel Lezcano <daniel.lezcano@linaro.org>
AuthorDate:    Mon, 02 Jun 2025 17:18:47 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Fri, 25 Jul 2025 11:43:18 +02:00

clocksource/drivers/sun5i: Add module owner

The conversion to modules requires a correct handling of the module
refcount in order to prevent to unload it if it is in use. That is
especially true with clockevents where there is no function to
unregister them.

The core time framework correctly handles the module refcount with the
different clocksource and clockevents if the module owner is set.

Add the module owner to make sure the core framework will prevent
stupid things happening when the driver will be converted into a
module.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
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

