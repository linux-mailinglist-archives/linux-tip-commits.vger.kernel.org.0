Return-Path: <linux-tip-commits+bounces-6197-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 46159B11C64
	for <lists+linux-tip-commits@lfdr.de>; Fri, 25 Jul 2025 12:32:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 60E471CE2FEB
	for <lists+linux-tip-commits@lfdr.de>; Fri, 25 Jul 2025 10:32:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F5A32E5B20;
	Fri, 25 Jul 2025 10:31:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ZA5n418h";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="G1tbz+JB"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC1322E49A0;
	Fri, 25 Jul 2025 10:31:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753439506; cv=none; b=j4ygGry5MP26ilCTskSw0vA75JnSay/s8KgMldqnMrF8npglNCJ0dZzc+lS8OSeFXUlsQ/lv4mmWKTNegKWziV4d91gskfIWvx98H9/W8WtIHImF0T2ebZUHDvi6+WDYqfit1WIor0HlWDbvxGR62f5fCOz34/NHUBp3p6geC2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753439506; c=relaxed/simple;
	bh=IJ9cv9ks+ik19mpe4YrVbBXkngaejyn2pMASUlUtoCo=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=bYfFveXw5ElJocIVZTPnw5SixfFoyJ5yPn5feelP0hH07no1krq2WzIcv5VjD9l2bcu7FDwxXbZZNJScHhcAwC/ZW3kObuMvoQm72MijIQG9i/qpRqVYiOxk9mrSRtH2G7SOfKIRr3m+KdthVDmgaSjM708J0qIqQ9xk8IGy+Lw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ZA5n418h; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=G1tbz+JB; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 25 Jul 2025 10:31:37 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1753439499;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xg63j6fOwNmsCLLedohQjTXuTmy/gU3eo11tc0h5z3A=;
	b=ZA5n418hHw2eeywWFoAmR0Y7GYE43mTh52w4EHIvYTTEBDydwESmWJvCof/u2Z/G9hB1JC
	xW2suySHCsRRwU1t++XN3zP4RFh7kof9zx0+F0gT+zCxsB9KXnvNUNDHoPlCDAaEfOZvDF
	8WwnoGphK6QX4QxExzRjX3gnLfbwn+TXlLR9fraeKJryhCdl0KfFo+dNfjP523k8jZT/l7
	VtoPzdAOIq0g+jPBAUZJxPGCQjyFnWng5aOK+bNI8RvGDreTe0E+YjcekxRiXXrJUWA4L9
	YUv74MxZmGpAzRghwZLZ3kmzAmNWuQq0hUXsW4psV9r/y8O1A2hAOIQopF+ALg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1753439499;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xg63j6fOwNmsCLLedohQjTXuTmy/gU3eo11tc0h5z3A=;
	b=G1tbz+JBNggGUs7HuQBpLhr26OyCOy7SneP6Ur8BhEnJTOQrR8UVTV3X3DJYoJ8CaVqJSo
	kUKljXdYfWvRv9Cw==
From: "tip-bot2 for Guenter Roeck" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/clocksource] clocksource/drivers/timer-tegra186: Avoid
 64-bit divide operation
Cc: Guenter Roeck <linux@roeck-us.net>,
 Daniel Lezcano <daniel.lezcano@linaro.org>, Ingo Molnar <mingo@kernel.org>,
 Jon Hunter <jonathanh@nvidia.com>, Pohsun Su <pohsuns@nvidia.com>,
 Robert Lin <robelin@nvidia.com>, x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250614175556.922159-1-linux@roeck-us.net>
References: <20250614175556.922159-1-linux@roeck-us.net>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175343949796.1420.7393840004808659473.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the timers/clocksource branch of ti=
p:

Commit-ID:     ed1d4c331f9f161788903885ce9ddfd665bdbe18
Gitweb:        https://git.kernel.org/tip/ed1d4c331f9f161788903885ce9ddfd665b=
dbe18
Author:        Guenter Roeck <linux@roeck-us.net>
AuthorDate:    Sat, 14 Jun 2025 10:55:55 -07:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Fri, 25 Jul 2025 12:06:28 +02:00

clocksource/drivers/timer-tegra186: Avoid 64-bit divide operation

Building the driver on xtensa fails with:

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
Signed-off-by: Ingo Molnar <mingo@kernel.org>
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

