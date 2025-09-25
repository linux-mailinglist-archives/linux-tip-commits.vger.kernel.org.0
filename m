Return-Path: <linux-tip-commits+bounces-6763-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E4A9BA19BA
	for <lists+linux-tip-commits@lfdr.de>; Thu, 25 Sep 2025 23:40:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 58DD332053A
	for <lists+linux-tip-commits@lfdr.de>; Thu, 25 Sep 2025 21:40:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37AE032F472;
	Thu, 25 Sep 2025 21:33:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="4V+KhPyk";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="DysMg/Ob"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5981C322C9C;
	Thu, 25 Sep 2025 21:33:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758836031; cv=none; b=m5vx1Exlj5fnjoPxioPleROaa3SeNgbGRjhslofyD9LKQYsJVPX1SNsgIRXzpXfwAGBDUAR1OqNWW3LYKjYgdRQMpq4q4mqmaOSQ+pF8OGsHW8u8WfyJUnLLVsIxhozw0g1Dak+Ht9StyQnPDzumpZK6f4fnuPm0As3WlFh8hO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758836031; c=relaxed/simple;
	bh=matcRG/+tK/iX24Mh7LJ+1kenJO+3ybhCKgDb8pw2Yg=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=oq47uNwegEalRyF0nmSTSdC/8RgXj010jblqivfCvbIKtk0IyIMjzLZto0JUF1bOHckUAUHrLcEuApeiYU6mM6EespfpCUzvmLBmgsoLNDUbWqGeEh5ZAtSl9jeZKRRQT5I6CKNpPDzC/JCO57lC9V1jp04tSvcVFtQrb/7aSuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=4V+KhPyk; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=DysMg/Ob; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 25 Sep 2025 21:33:45 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1758836026;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=vIq1AxfyLLvO7v9/qeAnBRoQBL/WHpbKTlFDLsp0GhU=;
	b=4V+KhPykQj87EcuNtTAA7iH9OXb6bDMzQNFwEqI+cdP3K/5fWHEv5nHh08pc+Ed5cq6al0
	7peWdqy/+WEPk04Ppq1nhb696Iz0R6Pf9RbSwOE5ZmgPvfIp4rAT4SZDsX723vw43/iPAG
	DxSpNxXIGqLlD8DloN6+x/SbpLx5CVAdzpTIwS5HA7pDKZ3NuIvaZF3ZKy91yGcasbEVB4
	mdp6YSAboF4Eebick1PfqVHIMGgU61DWSQoCiNF2lnafrkjr1DyTF86pCwFEqtNCAZInlS
	Hkkviu/Zt2npBAjZTLobA02VttesNkQnPTnZMxoBGGuB9k6hCOUSfUhOL0fcnA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1758836026;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=vIq1AxfyLLvO7v9/qeAnBRoQBL/WHpbKTlFDLsp0GhU=;
	b=DysMg/Ob1p90K0pSoGvQA4UVwO+tTt1DdtpcuSkCgzPQ/DrYTY/6TXvS7inUiZfG06nhdw
	/5NJU3rOC31fPtDw==
From: "tip-bot2 for Guenter Roeck" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/clocksource] clocksource/drivers/timer-tegra186:
 Simplify calculating timeleft
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
Message-ID: <175883602529.709179.10128651335321896499.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the timers/clocksource branch of ti=
p:

Commit-ID:     7f3abae5b447a7f8458a0f58a003c11c46aade99
Gitweb:        https://git.kernel.org/tip/7f3abae5b447a7f8458a0f58a003c11c46a=
ade99
Author:        Guenter Roeck <linux@roeck-us.net>
AuthorDate:    Sat, 14 Jun 2025 10:55:56 -07:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Tue, 23 Sep 2025 10:54:58 +02:00

clocksource/drivers/timer-tegra186: Simplify calculating timeleft

It is not necessary to use 64-bit operations to calculate the
remaining watchdog timeout. Simplify to use 32-bit operations,
and add comments explaining why there will be no overflow.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
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

