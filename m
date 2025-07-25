Return-Path: <linux-tip-commits+bounces-6196-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CC06B11C66
	for <lists+linux-tip-commits@lfdr.de>; Fri, 25 Jul 2025 12:32:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C87E53B925A
	for <lists+linux-tip-commits@lfdr.de>; Fri, 25 Jul 2025 10:31:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DFB42E54CE;
	Fri, 25 Jul 2025 10:31:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="QqfP7X6F";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Ysfi4wt/"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3A062E4266;
	Fri, 25 Jul 2025 10:31:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753439506; cv=none; b=jKJ/mUfQtiiDaRfVc57a9Q0D0Jm1bjhXsAYcBvtrn3uEaw+mMzc5vbl7nb3X9lB9E4teSG7r4zvqnL+FgD8iOkRBu3BbGNUzsoGDMf6NcCsJDT4du3mu6+FzPzsfHq+uEf/CBmma6w2K7ggdcPpyRHLgqydJLnfepCQs9Ccc1/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753439506; c=relaxed/simple;
	bh=V3y60QjxYPlxbwchBkApId1RNa3lQ+GZJIfHcsO4T4o=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=GYRlQwz13EBr5q9jCwyBG++jdUV9kR9p5OWZeMXnmu8UKkOwwgb3H8+jfPXDW+DTDbbMZxRi1zHFSdSLw7ha6aBiW3TGdmZ3kWhpMTTCIoBfET0Muotr2FWBwZdCmYl2jt/YhuJ87CRoJ8i9e/+lv2e9sLFBVM+4atSWtYMl0yE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=QqfP7X6F; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Ysfi4wt/; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 25 Jul 2025 10:31:35 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1753439497;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GGR6PxVwELZW74lKyGnS6sA9+37uFvTayyNS9zp1vLk=;
	b=QqfP7X6FQcPNidkXbyV8C7heeJcLgqcKbh/PP6HqP2Wr8orp1/Ws47DhXAPaBL/dK3ZQBO
	wuqmwqvfJzth+nXOnLOz0/sA6in5FX9iHALTej2hu/wioUam+DntXKGhjnnEZrTiDtowP+
	X8Nn3MFK+xFWUmL0YbviXLvnUgrrJMZcBOH/ah6c7hCCWK6MI0M7/0JX95XLTvSKo2z5A/
	DDr45YSeDkME65ZOUcIvaFuTtlJC422eTWNgOUd7UGMKOpB8cEIrvOI8GMB6GVAl3J0GSR
	JVLWpWFZ4OKCP6NnyZhRYPftIahi24Z+iNicxFvZvbe1qMzYOQ5Eo3eDCbkGuQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1753439497;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GGR6PxVwELZW74lKyGnS6sA9+37uFvTayyNS9zp1vLk=;
	b=Ysfi4wt/d68YNkkPKAroyBlXIMyu48/wYfDoMYBKtMI8VPRr4OZGyE5dcHRAUF13591JX2
	LX9PrJ/8oQ+6uzBw==
From: "tip-bot2 for Arnd Bergmann" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: timers/clocksource] clocksource/drivers/tegra186: Avoid 64-bit division
Cc: Arnd Bergmann <arnd@arndb.de>, Daniel Lezcano <daniel.lezcano@linaro.org>,
 Ingo Molnar <mingo@kernel.org>, x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250620111939.3395525-1-arnd@kernel.org>
References: <20250620111939.3395525-1-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175343949555.1420.966974973330577851.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the timers/clocksource branch of ti=
p:

Commit-ID:     836758dc1e43928aa1a357009f5c3164a00cbfb0
Gitweb:        https://git.kernel.org/tip/836758dc1e43928aa1a357009f5c3164a00=
cbfb0
Author:        Arnd Bergmann <arnd@arndb.de>
AuthorDate:    Fri, 20 Jun 2025 13:19:35 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Fri, 25 Jul 2025 12:06:46 +02:00

clocksource/drivers/tegra186: Avoid 64-bit division

The newly added function causes a build failure on 32-bit targets with
older compiler version such as gcc-10:

  arm-linux-gnueabi-ld: drivers/clocksource/timer-tegra186.o: in function `te=
gra186_wdt_get_timeleft':
  timer-tegra186.c:(.text+0x3c2): undefined reference to `__aeabi_uldivmod'

The calculation can trivially be changed to avoid the division entirely,
as USEC_PER_SEC is a multiple of 5. Change both such calculation for
consistency, even though gcc apparently managed to optimize the other one
properly already.

[ dlezcano : Fixed conflict with 20250614175556.922159-2-linux@roeck-us.net ]

Fixes: 28c842c8b0f5 ("clocksource/drivers/timer-tegra186: Add WDIOC_GETTIMELE=
FT support")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/20250620111939.3395525-1-arnd@kernel.org
---
 drivers/clocksource/timer-tegra186.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clocksource/timer-tegra186.c b/drivers/clocksource/timer=
-tegra186.c
index d403a3f..1ec7b38 100644
--- a/drivers/clocksource/timer-tegra186.c
+++ b/drivers/clocksource/timer-tegra186.c
@@ -159,7 +159,7 @@ static void tegra186_wdt_enable(struct tegra186_wdt *wdt)
 	tmr_writel(wdt->tmr, TMRCSSR_SRC_USEC, TMRCSSR);
=20
 	/* configure timer (system reset happens on the fifth expiration) */
-	value =3D TMRCR_PTV(wdt->base.timeout * USEC_PER_SEC / 5) |
+	value =3D TMRCR_PTV(wdt->base.timeout * (USEC_PER_SEC / 5)) |
 		TMRCR_PERIODIC | TMRCR_ENABLE;
 	tmr_writel(wdt->tmr, value, TMRCR);
=20

