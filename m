Return-Path: <linux-tip-commits+bounces-6762-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EA94EBA19D5
	for <lists+linux-tip-commits@lfdr.de>; Thu, 25 Sep 2025 23:41:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0B5EE3A4AEF
	for <lists+linux-tip-commits@lfdr.de>; Thu, 25 Sep 2025 21:40:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA349321296;
	Thu, 25 Sep 2025 21:33:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="gvmyKz+b";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="1C3uorPt"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2239D32ED3C;
	Thu, 25 Sep 2025 21:33:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758836030; cv=none; b=hxxi6YPDZ89Klvit9jJlYKbkWIrmZmXps5PeynkfRcUXJm963LlXKdySLVfitaT0bMmXGEzyliaXwLmHuFwpKy4vYWpDMU04ZKq5/sSJ6GzUNSFexrv36b5phZlmo1ZHQ/0kuadsC1i0Tl96MTSA9Dqqglu3CKc49Qy2CcNWwUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758836030; c=relaxed/simple;
	bh=KStaUfcnuaadi42LGJp7BEcV+aLuJCVLGBnEdjmKG5c=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=bpVYd9sDF/ESKF+gWOJp82/4EjbUj3+OimEpyWCIIsVGKp5Nszi2y/9J9iUJ2NhjcSbE+czMZjv7r0wMSiB1nQKNHq+NfPSufJgLx+E/IgUqRFfMaidMZIu+JL9emzBpyVgZhBiZs5BbRLid2MjIwbN7Bk7bmMzRLU9jAqWt674=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=gvmyKz+b; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=1C3uorPt; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 25 Sep 2025 21:33:46 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1758836027;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=TbB/L3GNC+E/AVwHKWD6XnIEeamG8gXOIRNc/B17K7o=;
	b=gvmyKz+bV98R4Mz+XM4Wadsa/5rIQACFh2UjKAT0gM7/ZOJTfg/LB/2NaRryaZNfpzvb8U
	lmdH+88zunDl35z2ngJPMgYYfo23ZIIoVOF5MU7REFmwmbRmceZc6AlI9ZSX2WVewORQz+
	TivXV1a+rkVBQu6Eltyb7fwQYFuSUcNVRsEWkY+JYVy3MowinEgQSQa7KFrxs9Z8IwVri/
	l+I2BF8kP9uiSbgyDJmQIsoyFxUqNHtUJP/w2q2nyL+xoEs6e3UKjZXmqyS7c5LpzWYmwf
	TDTrEj/5R528UlGa1oyRaG2cEpERFGYSPNehTaTqhIFax7FodBENx93zuk1peg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1758836027;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=TbB/L3GNC+E/AVwHKWD6XnIEeamG8gXOIRNc/B17K7o=;
	b=1C3uorPtXJFT698FxveUKHfTCYYToHxAHgxW6Z1gwA0NuEt5MEVJnbNt9b3vv5TmXzN+Zw
	s+Be520OQy69o5CA==
From: "tip-bot2 for Guenter Roeck" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/clocksource] clocksource/drivers/timer-tegra186: Avoid
 64-bit divide operation
Cc: Guenter Roeck <linux@roeck-us.net>,
 Daniel Lezcano <daniel.lezcano@linaro.org>, Jon Hunter <jonathanh@nvidia.com>,
 Pohsun Su <pohsuns@nvidia.com>, Robert Lin <robelin@nvidia.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175883602648.709179.10589873692601492232.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the timers/clocksource branch of ti=
p:

Commit-ID:     916aa36042db8ee230543ffe0d192f900e8b8c9f
Gitweb:        https://git.kernel.org/tip/916aa36042db8ee230543ffe0d192f900e8=
b8c9f
Author:        Guenter Roeck <linux@roeck-us.net>
AuthorDate:    Sat, 14 Jun 2025 10:55:55 -07:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Tue, 23 Sep 2025 10:54:29 +02:00

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
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Reviewed-by: Jon Hunter <jonathanh@nvidia.com>
Cc: Pohsun Su <pohsuns@nvidia.com>
Cc: Robert Lin <robelin@nvidia.com>
Link: https://lore.kernel.org/r/20250614175556.922159-1-linux@roeck-us.net
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

