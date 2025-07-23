Return-Path: <linux-tip-commits+bounces-6183-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 36063B0EBC3
	for <lists+linux-tip-commits@lfdr.de>; Wed, 23 Jul 2025 09:22:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5039E16C375
	for <lists+linux-tip-commits@lfdr.de>; Wed, 23 Jul 2025 07:20:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16AE3277C82;
	Wed, 23 Jul 2025 07:17:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="SuUXBh+V";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="impR9k6M"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 481F4277C86;
	Wed, 23 Jul 2025 07:17:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753255063; cv=none; b=UFoz6ioh2qSknf5chAEorUjd195MJLqBIa7MkLjcvf2mjLrEEl9YUedOApqGz2g11f62YZQTB1hT6AsY0pIFnM0N2Lk4kDRlFEeTVPXKyiRwsb6w7O3nuclwVKM7yRAbWOxiHdkMuH3J30Kjsg9sQziOafEUVxu5GDoelF8nzP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753255063; c=relaxed/simple;
	bh=1/YNgm+x0Bu8tQU0sJwQ8zyUkXMzluprz0Mwb02f7K0=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=WxD2sM5qJ8S5zFabU4shwMoe17G2sUINtIO2iPqQh2BKidhoaPoqJv8WwipHaMjiV8Rr5J9yozyKy4ICwMQk0uZqjjCN2f//953pdv9wklvtwbSoGG0qSvONwTZRzy3iYFpA+pgp0SqJS7/ZdoePop/jVg3ReAKvAMupsEw1NoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=SuUXBh+V; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=impR9k6M; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 23 Jul 2025 07:17:39 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1753255060;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+34mZ97xLaB6+DodOwfhVMtzaBrCf0mCGiGKCP130MQ=;
	b=SuUXBh+Vok3wJ7kpHaodF/CvsqnhBeCEc4r4tWx0deX8O9YjUyWN4HlAYatjx/tFcP+t2g
	rJNwcLBtGtZh30lxWMIayVFG4yCBGnd/7tQiI/fTOtOIwCkPLtDdCWW+88lYRahusXAwCL
	C1lpk5zPDMaunjT3bqSEVNMRma6gzrLLXewaxE2sdoIjtfE+2RB76sIoQWZiYscsHESwLg
	Rszg+ADiSM9ehHrFQCY2xg5hET/rCX+ZLkGiDyL2TSlJZMuFNHI2yQYXMSyHyEWHphj49F
	5oTkYyELTlY9iCOxqA3pUP2XTAz+7qAyrrvq+WjDOTicR5HPLYcVyW0Z55zPcw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1753255060;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+34mZ97xLaB6+DodOwfhVMtzaBrCf0mCGiGKCP130MQ=;
	b=impR9k6M3cJ0ZNH1ocI/3qD3V4Gf7OJ77rzr221VaawDiad9v7gd8BCSBJ73cX61K3WKL3
	5flFHOV6gfxeSLBw==
From: "tip-bot2 for Daniel Lezcano" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: timers/clocksource] clocksource/drivers/tegra186: Add module owner
Cc: Will McVicker <willmcvicker@google.com>,
 Daniel Lezcano <daniel.lezcano@linaro.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250602151853.1942521-5-daniel.lezcano@linaro.org>
References: <20250602151853.1942521-5-daniel.lezcano@linaro.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175325505977.1420.1197843793928404743.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the timers/clocksource branch of ti=
p:

Commit-ID:     dc8b1ad53317512f840fb81e4054db560950bc80
Gitweb:        https://git.kernel.org/tip/dc8b1ad53317512f840fb81e4054db56095=
0bc80
Author:        Daniel Lezcano <daniel.lezcano@linaro.org>
AuthorDate:    Mon, 02 Jun 2025 17:18:48 +02:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Thu, 10 Jul 2025 11:28:29 +02:00

clocksource/drivers/tegra186: Add module owner

The conversion to modules requires a correct handling of the module
refcount in order to prevent to unload it if it is in use. That is
especially true with the clockevents where there is no function to
unregister them.

The core time framework correctly handles the module refcount with the
different clocksource and clockevents if the module owner is set.

Add the module owner to make sure the core framework will prevent
stupid things happening when the driver will be converted into a
module.

Reviewed-by: Will McVicker <willmcvicker@google.com>
Link: https://lore.kernel.org/r/20250602151853.1942521-5-daniel.lezcano@linar=
o.org
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/clocksource/timer-tegra186.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/clocksource/timer-tegra186.c b/drivers/clocksource/timer=
-tegra186.c
index e5394f9..56a5342 100644
--- a/drivers/clocksource/timer-tegra186.c
+++ b/drivers/clocksource/timer-tegra186.c
@@ -373,6 +373,7 @@ static int tegra186_timer_tsc_init(struct tegra186_timer =
*tegra)
 	tegra->tsc.read =3D tegra186_timer_tsc_read;
 	tegra->tsc.mask =3D CLOCKSOURCE_MASK(56);
 	tegra->tsc.flags =3D CLOCK_SOURCE_IS_CONTINUOUS;
+	tegra->tsc.owner =3D THIS_MODULE;
=20
 	return clocksource_register_hz(&tegra->tsc, 31250000);
 }
@@ -392,6 +393,7 @@ static int tegra186_timer_osc_init(struct tegra186_timer =
*tegra)
 	tegra->osc.read =3D tegra186_timer_osc_read;
 	tegra->osc.mask =3D CLOCKSOURCE_MASK(32);
 	tegra->osc.flags =3D CLOCK_SOURCE_IS_CONTINUOUS;
+	tegra->osc.owner =3D THIS_MODULE;
=20
 	return clocksource_register_hz(&tegra->osc, 38400000);
 }
@@ -411,6 +413,7 @@ static int tegra186_timer_usec_init(struct tegra186_timer=
 *tegra)
 	tegra->usec.read =3D tegra186_timer_usec_read;
 	tegra->usec.mask =3D CLOCKSOURCE_MASK(32);
 	tegra->usec.flags =3D CLOCK_SOURCE_IS_CONTINUOUS;
+	tegra->usec.owner =3D THIS_MODULE;
=20
 	return clocksource_register_hz(&tegra->usec, USEC_PER_SEC);
 }

