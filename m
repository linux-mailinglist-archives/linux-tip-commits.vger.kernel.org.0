Return-Path: <linux-tip-commits+bounces-6771-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B607BA19FF
	for <lists+linux-tip-commits@lfdr.de>; Thu, 25 Sep 2025 23:42:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BB52D3AD3B7
	for <lists+linux-tip-commits@lfdr.de>; Thu, 25 Sep 2025 21:41:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF40F33089B;
	Thu, 25 Sep 2025 21:34:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="p71a5/wn";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="GGrcvVk6"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3FDE330865;
	Thu, 25 Sep 2025 21:33:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758836040; cv=none; b=OSgA+ge2yUXRUxBKSyZa9hNSqfTaHb0tTyIZ8E1kQTTetpLm39KRCp57wxl7GYbAJRW+XvNMg84/ZouUbZ5AJfEScRX3QC7bG2oDyi2TliOPrwKXpy6ZcWhmd06ayYyU8CcV7GUwpmKnxOznXHIYgaOVaJJmuwckuIRxGpMMojU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758836040; c=relaxed/simple;
	bh=VMWaKrxuRHcV9Dqe3soagjOZG+AeaXTiZWi751lL8as=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=VEBUjpYiHjeM5jo46yFZ7Olmf93gNBQb/YaHoiV9im2f9JMl5L9FKaU74Gm3uYC552qfbjpA3mmUlutiDhBvql5ZGgdeesADbJ20OPYzkSSBd3chaBbPlyXYQv1lZ9/5195A9PTXSj6lAmXcJxcwazZ5Z1cHVV9XBtNWN4+Cra0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=p71a5/wn; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=GGrcvVk6; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 25 Sep 2025 21:33:56 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1758836037;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=iNhuv32IbKW7uSbp51s7u1+P0k1RsedBgYu4h4T7qsk=;
	b=p71a5/wnOsDwNtZSR7NmKvmrC9EHjgv+krcPnw7ITjDa5ef5+t4fby5K/27JmMQGUy3Mbm
	40RHzQrDt3Za9WnbG2HtLk8/VA8yeA7rBsXA+69YfO7KSMyPuYqM5VV/5fNrd3ZzKUSH8w
	Tj+vyzZPZn5QrB6McxEjrhrbgptc/qavgL9nYYjJtpArsq7ZmyVp3yHN5yNfnUgoH77/4f
	+1uixnox1gWNOvKj5uLuzUiOzJeUIFmwtK6GFpoi3LnvT/X8Ky1ciQPdcj1048Qs5JxfDD
	lyK5zVfyyQL+8MXOid0VSwYhngJV/KYqGAqIkh+7XgqusrdyfuVNyYf187to4A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1758836037;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=iNhuv32IbKW7uSbp51s7u1+P0k1RsedBgYu4h4T7qsk=;
	b=GGrcvVk6yrSKk3BhFAr/FX1Q1rz316BHXCi155GMLLS/w891CVhdLL21fPvhn23FJJEl2s
	A8+gKPIbt1Y2KJAw==
From: "tip-bot2 for Daniel Lezcano" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: timers/clocksource] clocksource/drivers/tegra186: Add module owner
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>,
 Will McVicker <willmcvicker@google.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175883603615.709179.11078382577244763572.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the timers/clocksource branch of ti=
p:

Commit-ID:     afe904f5091e2ceaa95b451f61a115a0224e8e38
Gitweb:        https://git.kernel.org/tip/afe904f5091e2ceaa95b451f61a115a0224=
e8e38
Author:        Daniel Lezcano <daniel.lezcano@linaro.org>
AuthorDate:    Mon, 02 Jun 2025 17:18:48 +02:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Tue, 23 Sep 2025 10:52:04 +02:00

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

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Reviewed-by: Will McVicker <willmcvicker@google.com>
Link: https://lore.kernel.org/r/20250602151853.1942521-5-daniel.lezcano@linar=
o.org
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

