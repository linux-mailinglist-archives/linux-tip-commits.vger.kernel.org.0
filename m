Return-Path: <linux-tip-commits+bounces-6215-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CB7DDB11C8B
	for <lists+linux-tip-commits@lfdr.de>; Fri, 25 Jul 2025 12:36:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4D8BC561955
	for <lists+linux-tip-commits@lfdr.de>; Fri, 25 Jul 2025 10:36:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBC172ED87D;
	Fri, 25 Jul 2025 10:32:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="e/9qyibs";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="+l9ymipk"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5362A2E4260;
	Fri, 25 Jul 2025 10:31:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753439521; cv=none; b=nU0Ezk2CSjSElQRxvXfFPBWgzfOmCnPt3mgW18167UcxJO24gIzbOKbgMeyFsCd4/5v8v+JEsK29S6yaVcEX7/ngoQki4N+y0Zvb0xcnoJ2ON6nHsdHAPnzbGDtFNTymvgfAQgrXELPD+BRhBQH1M26XEu8g3B+fUvqX6k+nqm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753439521; c=relaxed/simple;
	bh=riWt914DxaDdchtghd8dzyCobB/gD7VuMm1NrB5pJek=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=bdSufpz25SbZSDhnY9LcQ+CyxckxJH8anfJEjM7h+xsxt6ouFaC1nZcySR2ZJ23yNU5aITzQqKONuSxXFBKrxE990Im1gDfizYioJqnp1PGzKkPPKT2nBka49nbBzTmzSdswf7oGd3ontp6f/Pnj07AbSXL99LIUhBh/b3oSn5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=e/9qyibs; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=+l9ymipk; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 25 Jul 2025 10:31:57 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1753439518;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=We8XyQEzFKB0XKCVPMIAWxfeuL8OMT3eanHEO+btF+8=;
	b=e/9qyibsRJ80426JkZgyF4P4qEoOxSdnM05wL1ys3Iv6SgiADIcgOO9Ck6OA1vpBqqLJpE
	Tu+V4IuDxAX6xKceicZ4rWsDjMu0DpYpmc2GZGXVEDIoPJjCtb3GdFRvgzaKCg64AiF9w6
	rXVk38FgvGXvYTje/GlC8bxXJdPf2JLxo8g0mlKVbrusx4x/Q8/FUNnR5j9kJpH9Clc12O
	6tR/a/9z2h8JcPNVsv+EYkBXBCqb4uFLYpbra0Wy3v4FokiSedNPqY7+4KXtMvc7fVXYUr
	k/H2YLb1JsZclRN7y5uPjwj3eWipDg6KrOcv1T/Q2NvRZUlAifNeY/dPKK4nOA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1753439518;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=We8XyQEzFKB0XKCVPMIAWxfeuL8OMT3eanHEO+btF+8=;
	b=+l9ymipk0keSj6R3nVCjo/weWvZduiirImhMX93WB9AA+kbwMkuReEcqluei15uMEDzRhv
	3vQr218wJN+cNDBg==
From: "tip-bot2 for Daniel Lezcano" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: timers/clocksource] clocksource/drivers/scx200: Add module owner
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>, Ingo Molnar <mingo@kernel.org>,
 Will McVicker <willmcvicker@google.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250602151853.1942521-2-daniel.lezcano@linaro.org>
References: <20250602151853.1942521-2-daniel.lezcano@linaro.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175343951733.1420.16247336951842270693.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the timers/clocksource branch of ti=
p:

Commit-ID:     32095e3f3c0affe59a1a465ed19ae9a24f5fb44a
Gitweb:        https://git.kernel.org/tip/32095e3f3c0affe59a1a465ed19ae9a24f5=
fb44a
Author:        Daniel Lezcano <daniel.lezcano@linaro.org>
AuthorDate:    Mon, 02 Jun 2025 17:18:45 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Fri, 25 Jul 2025 11:42:32 +02:00

clocksource/drivers/scx200: Add module owner

The conversion to modules requires a correct handling of the module
refcount in order to prevent to unload it if it is in use. That is
especially true with clockevents where there is no function to
unregister them.

The core time framework correctly handles the module refcount with the
different clocksource and clockevents if the module owner is set.

Add the module owner to make sure the core framework will prevent
stupid things happening when the driver will be converted into a
module.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Reviewed-by: Will McVicker <willmcvicker@google.com>
Link: https://lore.kernel.org/r/20250602151853.1942521-2-daniel.lezcano@linar=
o.org
---
 drivers/clocksource/scx200_hrt.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/clocksource/scx200_hrt.c b/drivers/clocksource/scx200_hr=
t.c
index c3536ff..5a99801 100644
--- a/drivers/clocksource/scx200_hrt.c
+++ b/drivers/clocksource/scx200_hrt.c
@@ -52,6 +52,7 @@ static struct clocksource cs_hrt =3D {
 	.mask		=3D CLOCKSOURCE_MASK(32),
 	.flags		=3D CLOCK_SOURCE_IS_CONTINUOUS,
 	/* mult, shift are set based on mhz27 flag */
+	.owner		=3D THIS_MODULE,
 };
=20
 static int __init init_hrt_clocksource(void)

