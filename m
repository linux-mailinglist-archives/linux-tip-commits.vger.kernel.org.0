Return-Path: <linux-tip-commits+bounces-6167-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 04C6AB0EB9F
	for <lists+linux-tip-commits@lfdr.de>; Wed, 23 Jul 2025 09:18:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 53D09568588
	for <lists+linux-tip-commits@lfdr.de>; Wed, 23 Jul 2025 07:17:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 107C1273D94;
	Wed, 23 Jul 2025 07:17:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="F8lBXsxu";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Ax9jyqFP"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D808273806;
	Wed, 23 Jul 2025 07:17:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753255046; cv=none; b=nE50qqq/EwDMlWYn063+f+RrbzFCWnNUV40mQmywjgKPTPB9aJlXWVLxPO6bRuW8CkDz5AfhYY+2lJMExbs8NRt7BKI1bfSKc/Q9AU2epuc0R0Z6UJX0i6uTlQXlbju1mqNY29GCdxV4OUDiKPY3vi+YKld6VbxkkZ6JxHsDfZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753255046; c=relaxed/simple;
	bh=DPRl2j5cW6jByoV3M2dPgw6lIuZN5yp52+t8t4BnvAU=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=PAYuyvbW415LllJrl4kiAQi4jHchT5aq9beSFKiF6MRzGdyZuJD5FwKlGcvypGxxqgD8ZaBa9YgQtQ0KCuQXOnEss/SG0yGnP4Tfhq+eeMkwpbDualyWi6Md8XBwKWbusEk4SRC4LMyW1vAHDFsVpV3Tyz7sJPITWzJi3X8oeYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=F8lBXsxu; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Ax9jyqFP; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 23 Jul 2025 07:17:21 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1753255042;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=r74f9PD7BWg+eDp2lHAPFVyiBiRePw8/5722tDU4H+8=;
	b=F8lBXsxukxUSYEV+3ehBtbw5nCRVbBEswauEb4grKplQp1H9ZmRU9Md0XsVNuDK64rHfCC
	t+qLjhD5S/28tTTjiop16cgUWEP0lbclQtcxltAK6bnjJ7Pk5XErL/BOFNVPbf0mGzdbtY
	cqWiQAAPq8F2ffdjItChzWvx8DhEQ4mwVEWipUs1/cdfmMdG2MAmZsoP322vOB+6znkleX
	vVN/LPjhI2i2xbz3RXoJm0eRbs3KA+wBp6i3BXqufbGrAywOvYVh4lQ+SKTlNJEt5WioiD
	T6WUjIgMtlUc1KDVxU/mefrBWgI9zxHlbcxa6ilvzWHzB+fcS0gSoNAqJPIUWw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1753255042;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=r74f9PD7BWg+eDp2lHAPFVyiBiRePw8/5722tDU4H+8=;
	b=Ax9jyqFPk/L9mJapbs57pjcC1xEEFzJekpfTSXcSyUfYJoN985cekr0kv38rXuGDwN3jGy
	4dEWfW7QvfF0rmDA==
From: "tip-bot2 for Arnd Bergmann" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: timers/clocksource] clocksource/drivers/tegra186: Avoid 64-bit division
Cc: Arnd Bergmann <arnd@arndb.de>, Daniel Lezcano <daniel.lezcano@linaro.org>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250620111939.3395525-1-arnd@kernel.org>
References: <20250620111939.3395525-1-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175325504156.1420.15575615944752834016.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the timers/clocksource branch of ti=
p:

Commit-ID:     7e11b4f49b5147817cd87489d4e63ca9fc92753c
Gitweb:        https://git.kernel.org/tip/7e11b4f49b5147817cd87489d4e63ca9fc9=
2753c
Author:        Arnd Bergmann <arnd@arndb.de>
AuthorDate:    Fri, 20 Jun 2025 13:19:35 +02:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Tue, 15 Jul 2025 13:09:35 +02:00

clocksource/drivers/tegra186: Avoid 64-bit division

The newly added function causes a build failure on 32-bit targets with
older compiler version such as gcc-10:

arm-linux-gnueabi-ld: drivers/clocksource/timer-tegra186.o: in function `tegr=
a186_wdt_get_timeleft':
timer-tegra186.c:(.text+0x3c2): undefined reference to `__aeabi_uldivmod'

The calculation can trivially be changed to avoid the division entirely,
as USEC_PER_SEC is a multiple of 5. Change both such calculation for
consistency, even though gcc apparently managed to optimize the other one
properly already.

Fixes: 28c842c8b0f5 ("clocksource/drivers/timer-tegra186: Add WDIOC_GETTIMELE=
FT support")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Link: https://lore.kernel.org/r/20250620111939.3395525-1-arnd@kernel.org
[dlezcano] : Fixed conflict with 20250614175556.922159-2-linux@roeck-us.net
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
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

