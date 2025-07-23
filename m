Return-Path: <linux-tip-commits+bounces-6169-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 846DAB0EBA1
	for <lists+linux-tip-commits@lfdr.de>; Wed, 23 Jul 2025 09:18:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E00DF1C84309
	for <lists+linux-tip-commits@lfdr.de>; Wed, 23 Jul 2025 07:18:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01EE42749C4;
	Wed, 23 Jul 2025 07:17:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="X0E28SzY";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="UkI1f3pn"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2F712741CE;
	Wed, 23 Jul 2025 07:17:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753255048; cv=none; b=DqaF+DgSpHu9OTYiFZoo+oZzqBeRx+sMbo0RkO1G7g2dhWt58OxOq+6stj8+JSv3TmxftAAxXQhlfVVRr+bCNcmSNIRgKtAZnZ1i9uFY8Aup2i4U2hOFeP6JNEew37mkBR4j8eFp938bkzixaO4BnhvgkGshIO/cTCVmqS8HL/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753255048; c=relaxed/simple;
	bh=1mHtMH+roiwOsid4Ib53RoZsuUAg/xprC7uoI65dF6U=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=XFYVuF179Y045bsXf3d2ihdQc/+p7icrl03BXr+jVvVGBW9LDs3ni3vdhIASgSz+c0hSH16jbzOIl/A4+Elqz2344NY09/n5uNEsL8ilKm82zjpZY083IUNq6AXmM/Bo/sNf2U50dnvrVKCDrQCpNi3p9PCDKUmHXZyT7Rh+3Zo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=X0E28SzY; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=UkI1f3pn; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 23 Jul 2025 07:17:23 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1753255045;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=T5J3H08iTQesW1EM7igUr6KYUQeB4i36Gmd6nEliN5c=;
	b=X0E28SzYRAwmz6FzG94SpcMJQhmLu9LHWRloY3eTMh2aZg2Lc4Lt0YwsdutqLUoF45vmXK
	XirbNuAm8/XmRlakm7JHH0jKzE8DY9fS01gvpOSC5xh3PVAGIapVcWAdWzzsKO3n34kKq6
	fW+j8wLBhAzxkBq4N1VqGjtsVQpnZQexylIRCCovGJx0z1cQS2oH3h3cjBzLs09HbOvHW7
	whNdSNWbrpEYZBQNtVRHN6yBnjC+5vPcZLvnh4iJsuDu3HBHpwgWdKg27scIGGvKMy82d9
	2f1TcCZQFKOxLcL9ZQ9yLC2OhP2WfeQ9YwG/SCcPHidb4JlmBA30aDHHqwVBCQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1753255045;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=T5J3H08iTQesW1EM7igUr6KYUQeB4i36Gmd6nEliN5c=;
	b=UkI1f3pnYycATuuY9WIR/J8I60Em7BdMO37AAa/0G0BWcFcZ6M7I+qxd+7VzoVBiO4rOAw
	0kb8E1SNtxgaOBCw==
From: "tip-bot2 for Guenter Roeck" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/clocksource] clocksource/drivers/timer-tegra186: Avoid
 64-bit divide operation
Cc: Pohsun Su <pohsuns@nvidia.com>, Robert Lin <robelin@nvidia.com>,
 Guenter Roeck <linux@roeck-us.net>, Jon Hunter <jonathanh@nvidia.com>,
 Daniel Lezcano <daniel.lezcano@linaro.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250614175556.922159-1-linux@roeck-us.net>
References: <20250614175556.922159-1-linux@roeck-us.net>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175325504388.1420.5766368325078103873.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the timers/clocksource branch of ti=
p:

Commit-ID:     eda68f63d2bbc16a485f9f0f4df79253ae5353f2
Gitweb:        https://git.kernel.org/tip/eda68f63d2bbc16a485f9f0f4df79253ae5=
353f2
Author:        Guenter Roeck <linux@roeck-us.net>
AuthorDate:    Sat, 14 Jun 2025 10:55:55 -07:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Tue, 15 Jul 2025 13:08:07 +02:00

clocksource/drivers/timer-tegra186: Avoid 64-bit divide operation

Building the driver on xtensa fails with

tensa-linux-ld: drivers/clocksource/timer-tegra186.o:
	in function `tegra186_timer_remove':
timer-tegra186.c:(.text+0x350):
	undefined reference to `__udivdi3'

Avoid the problem by rearranging the offending code to avoid the 64-bit
divide operation.

Fixes: 28c842c8b0f5 ("clocksource/drivers/timer-tegra186: Add WDIOC_GETTIMELE=
FT support")
Cc: Pohsun Su <pohsuns@nvidia.com>
Cc: Robert Lin <robelin@nvidia.com>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Reviewed-by: Jon Hunter <jonathanh@nvidia.com>
Link: https://lore.kernel.org/r/20250614175556.922159-1-linux@roeck-us.net
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/clocksource/timer-tegra186.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clocksource/timer-tegra186.c b/drivers/clocksource/timer=
-tegra186.c
index 56a5342..76a5481 100644
--- a/drivers/clocksource/timer-tegra186.c
+++ b/drivers/clocksource/timer-tegra186.c
@@ -267,7 +267,7 @@ static unsigned int tegra186_wdt_get_timeleft(struct watc=
hdog_device *wdd)
 	 * counter value to the time of the counter expirations that
 	 * remain.
 	 */
-	timeleft +=3D (((u64)wdt->base.timeout * USEC_PER_SEC) / 5) * (4 - expirati=
on);
+	timeleft +=3D ((u64)wdt->base.timeout * (USEC_PER_SEC / 5)) * (4 - expirati=
on);
=20
 	/*
 	 * Convert the current counter value to seconds,

