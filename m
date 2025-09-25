Return-Path: <linux-tip-commits+bounces-6761-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F13B4BA19B4
	for <lists+linux-tip-commits@lfdr.de>; Thu, 25 Sep 2025 23:40:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1F82B189F9AB
	for <lists+linux-tip-commits@lfdr.de>; Thu, 25 Sep 2025 21:40:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD61A32ED31;
	Thu, 25 Sep 2025 21:33:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="uAZyxvKI";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="lIQseVcS"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAFE832E728;
	Thu, 25 Sep 2025 21:33:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758836028; cv=none; b=R+Zzj3ucA7ldasfEQiBwwuPb8g7MfSQhyhxLmpYAPSWe6uMN9Kw07z/YvSITE+4BzqHpJjiqnnNsjTrIcjuV9SETUin9sZKhcywy24PPc3aPC8w+N93PEcHSyx9g/ovqPEeVCghZGogSxHq5pE4MXmHZvKzrR0Rs59OJG6bJWN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758836028; c=relaxed/simple;
	bh=gCsbly83LpckG+NZJpaMrLImwCl7jFMO+KyAhfnTtB0=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=OOs/P2M3Qwa4hC16y1vkab9hpInzxzOeBhJ3vnwSr7SZPYMQT0IuwMlnduVy+nLroWmLon/QznbjLsKuhAg9iA4W6iXPlXECYdMmjzi61nzLYBRzXL/u4GyugbPC7ZDyGb7Mp+9EgupLYa+39iLZAB4+NkIYeHGpAkzkupGYofM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=uAZyxvKI; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=lIQseVcS; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 25 Sep 2025 21:33:43 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1758836025;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=xI7mAkW0GkFkDagBBTo4G3RzAq/JRoNpkrIE9sr03E4=;
	b=uAZyxvKIL1wmy+p4ujR3OSRa8g9GvOml4IK2UL3b1ea4W8TtSWHv/hDhSKvxiHuG0aoJbM
	PTNAyYFmyupqDZ5sI+VHZs+pgNVcji6CP/vbCZ9Yy7VXSsVKr9tZMpWF6QaapmZu5V6EFV
	1YqaJwuIgjtl+RALNeKXXqq7Q+9c+ZIuDrTArJOMLDIdmDbbZqWHqld9HtArdLPgmJWZIa
	xWTddAMHyYgi2I/AQfkpqwwkJSTpm2TEK6f/rFdZ4ftEnWwWeLwTCZlHkeVvQZqmSVPG9E
	t0f7OgN6AealFKijsci74BUXwdiTsJX+XUpYG2iyfHV23X8f1vP5xE1fkvdQtw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1758836025;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=xI7mAkW0GkFkDagBBTo4G3RzAq/JRoNpkrIE9sr03E4=;
	b=lIQseVcSC4SnGj8U8r13L+KQyxLoVwaT/SsJGFi5yflhLNobPt8qAN/EQEGq22QqjhQz4X
	h5FhHTgBK9tQ/MAA==
From: "tip-bot2 for Arnd Bergmann" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: timers/clocksource] clocksource/drivers/tegra186: Avoid 64-bit division
Cc: Arnd Bergmann <arnd@arndb.de>, Daniel Lezcano <daniel.lezcano@linaro.org>,
 x86@kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175883602398.709179.13814856568204259930.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the timers/clocksource branch of ti=
p:

Commit-ID:     409f8fe03e08f92bf5be96cedbcd7a3e8fb2eeaf
Gitweb:        https://git.kernel.org/tip/409f8fe03e08f92bf5be96cedbcd7a3e8fb=
2eeaf
Author:        Arnd Bergmann <arnd@arndb.de>
AuthorDate:    Fri, 20 Jun 2025 13:19:35 +02:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Tue, 23 Sep 2025 10:55:12 +02:00

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

[dlezcano : Fixed conflict with 20250614175556.922159-2-linux@roeck-us.net ]

Fixes: 28c842c8b0f5 ("clocksource/drivers/timer-tegra186: Add WDIOC_GETTIMELE=
FT support")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
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

