Return-Path: <linux-tip-commits+bounces-6198-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DD23AB11C68
	for <lists+linux-tip-commits@lfdr.de>; Fri, 25 Jul 2025 12:32:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 68FC94E0B7C
	for <lists+linux-tip-commits@lfdr.de>; Fri, 25 Jul 2025 10:31:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBD8A2E6103;
	Fri, 25 Jul 2025 10:31:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="0vz+CawW";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="HblEvTxf"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD7E62E4271;
	Fri, 25 Jul 2025 10:31:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753439506; cv=none; b=imzWw4kRxpD1hxIZ09OeQLO5olAdN/uvJwfTzDglCzjC+BOO0lCuoYBsgVsvFOlAXbkgn6GwxAi+zZz6hX/o4JFWlkXXEUweqUzeH2ytVnOwKSP6iPV/5KvEu+9fUKN0mYQBN6Gt0yUVHeEcJf3mDukphRm9qRXid38VYBEJGWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753439506; c=relaxed/simple;
	bh=UusoP5t/+loKFkJESTIvB993yxzIlaeCKrBZwH9xOyU=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=f8B6Yi0Mo+q+dD411Jq7PbWcFijrU5dMaX+dv/TbMtJohkbWpoGHomBMKrCey2nbxgn492YnsxJo8ankToAYrbTRrcznWPiEKbBUJyZlcY8AXyrWmSotT0t90mAKbi8Mgje/aROI8L2ICBO2uRjHYJPIAcTMIjnWjwnAkceKe5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=0vz+CawW; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=HblEvTxf; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 25 Jul 2025 10:31:36 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1753439498;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KKVkQPyKvYuNsC3qrOsGgDUByyJ/cRxk0pkPbkQnedA=;
	b=0vz+CawWql+6xmG6q5MXkjUZivGo+cHgdRzki0csqouce79xOG4bNPUPLOFtEcUn933nkB
	nTmZm9Ad/HaJ17dCj43Q/ty/hjlUAtZyPHA51nXrkfB848GiBDSmGAOBX1dbA8UbnbJtTG
	f/DRhIzIYATWwPvEq9qvJbl4aXBuJI52MgcA9hg7Jop647Z3aqPWvsgiZXoafP1D6WXn66
	IilCk1wfyES5MXt27xaKTkQv1ibdo6i0J+vTPcuDPzX0JD7hhvXnIATT4VKdJ0Rg22kgiS
	Bmw+UeGUzPq4pty7WyFmLCd1tZ7B6QPjAnt0f1qos3TPzlNkFEOTpr7OWiV7Fw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1753439498;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KKVkQPyKvYuNsC3qrOsGgDUByyJ/cRxk0pkPbkQnedA=;
	b=HblEvTxfMvR0yCn1LGJ/VPMXWTAM6/xISMt4H9m/JAh7cXiVjXZAVEIh+we5K9L+t+zU4+
	tHQUaILkUFI1Y3Ag==
From: "tip-bot2 for Guenter Roeck" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/clocksource] clocksource/drivers/timer-tegra186:
 Simplify calculating timeleft
Cc: Guenter Roeck <linux@roeck-us.net>,
 Daniel Lezcano <daniel.lezcano@linaro.org>, Ingo Molnar <mingo@kernel.org>,
 Jon Hunter <jonathanh@nvidia.com>, Pohsun Su <pohsuns@nvidia.com>,
 Robert Lin <robelin@nvidia.com>, x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250614175556.922159-2-linux@roeck-us.net>
References: <20250614175556.922159-2-linux@roeck-us.net>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175343949684.1420.2170175127179290236.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the timers/clocksource branch of ti=
p:

Commit-ID:     12c1fe0711d3de30440911f2d3e0147f9831f3c7
Gitweb:        https://git.kernel.org/tip/12c1fe0711d3de30440911f2d3e0147f983=
1f3c7
Author:        Guenter Roeck <linux@roeck-us.net>
AuthorDate:    Sat, 14 Jun 2025 10:55:56 -07:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Fri, 25 Jul 2025 12:06:33 +02:00

clocksource/drivers/timer-tegra186: Simplify calculating timeleft

It is not necessary to use 64-bit operations to calculate the
remaining watchdog timeout. Simplify to use 32-bit operations,
and add comments explaining why there will be no overflow.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Reviewed-by: Jon Hunter <jonathanh@nvidia.com>
Cc: Pohsun Su <pohsuns@nvidia.com>
Cc: Robert Lin <robelin@nvidia.com>
Link: https://lore.kernel.org/r/20250614175556.922159-2-linux@roeck-us.net
---
 drivers/clocksource/timer-tegra186.c | 25 +++++++++++++++----------
 1 file changed, 15 insertions(+), 10 deletions(-)

diff --git a/drivers/clocksource/timer-tegra186.c b/drivers/clocksource/timer=
-tegra186.c
index 76a5481..d403a3f 100644
--- a/drivers/clocksource/timer-tegra186.c
+++ b/drivers/clocksource/timer-tegra186.c
@@ -231,7 +231,7 @@ static unsigned int tegra186_wdt_get_timeleft(struct watc=
hdog_device *wdd)
 {
 	struct tegra186_wdt *wdt =3D to_tegra186_wdt(wdd);
 	u32 expiration, val;
-	u64 timeleft;
+	u32 timeleft;
=20
 	if (!watchdog_active(&wdt->base)) {
 		/* return zero if the watchdog timer is not activated. */
@@ -266,21 +266,26 @@ static unsigned int tegra186_wdt_get_timeleft(struct wa=
tchdog_device *wdd)
 	 * Calculate the time remaining by adding the time for the
 	 * counter value to the time of the counter expirations that
 	 * remain.
+	 * Note: Since wdt->base.timeout is bound to 255, the maximum
+	 * value added to timeleft is
+	 *   255 * (1,000,000 / 5) * 4
+	 * =3D 255 * 200,000 * 4
+	 * =3D 204,000,000
+	 * TMRSR_PCV is a 29-bit field.
+	 * Its maximum value is 0x1fffffff =3D 536,870,911.
+	 * 204,000,000 + 536,870,911 =3D 740,870,911 =3D 0x2C28CAFF.
+	 * timeleft can therefore not overflow, and 64-bit calculations
+	 * are not necessary.
 	 */
-	timeleft +=3D ((u64)wdt->base.timeout * (USEC_PER_SEC / 5)) * (4 - expirati=
on);
+	timeleft +=3D (wdt->base.timeout * (USEC_PER_SEC / 5)) * (4 - expiration);
=20
 	/*
 	 * Convert the current counter value to seconds,
-	 * rounding up to the nearest second. Cast u64 to
-	 * u32 under the assumption that no overflow happens
-	 * when coverting to seconds.
+	 * rounding to the nearest second.
 	 */
-	timeleft =3D DIV_ROUND_CLOSEST_ULL(timeleft, USEC_PER_SEC);
+	timeleft =3D DIV_ROUND_CLOSEST(timeleft, USEC_PER_SEC);
=20
-	if (WARN_ON_ONCE(timeleft > U32_MAX))
-		return U32_MAX;
-
-	return lower_32_bits(timeleft);
+	return timeleft;
 }
=20
 static const struct watchdog_ops tegra186_wdt_ops =3D {

