Return-Path: <linux-tip-commits+bounces-6212-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 63F2BB11C87
	for <lists+linux-tip-commits@lfdr.de>; Fri, 25 Jul 2025 12:35:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C54F47BD28A
	for <lists+linux-tip-commits@lfdr.de>; Fri, 25 Jul 2025 10:33:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23EE42ECE82;
	Fri, 25 Jul 2025 10:31:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="YQN5UANB";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="YyEkf72e"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80D9F2EBBB0;
	Fri, 25 Jul 2025 10:31:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753439518; cv=none; b=aQwd1e5ihEb9BAssX0BflPqwUiLTw3MJyHWZGdqRmUUh3RR5JXpZZLKkqzxbaTbWSf4YbR1exBNPa78qk5hFWchx97QMNXksMes+yAa6X7cBHk0c9ARQSQwDsnEIiTiW2K+uJrOwGLM0l2VZFOxFCp0pUagZsENtZfXNc9Mw7yI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753439518; c=relaxed/simple;
	bh=uReSb7JzftOAxfkD8t+OO4D0hecWIpwc422AH7uAtPo=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=VPQwT1mcmnk8c1zrwLnrofGaUmaFYjAnbcy83nU8I1Pr3eV/MOnTCumlh2c0dQsJuu9DyVdOR4LS2g9ikCJSytS8Lg9q3Rky5oTHxhPplcaWRJHciZSMCHq1bD2GkxO9gUq2YNrgNL560Q+jgbNwTVEpcrRtI1vS856Q0jblmwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=YQN5UANB; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=YyEkf72e; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 25 Jul 2025 10:31:53 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1753439515;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5b+kPDm97piiuep4VNS2ofHXHSThNlVT16aHVVtHndw=;
	b=YQN5UANBFlAhiuEzbaPYXh7JkZ0az0KUjsc703C5LOL/NZjWLI7RS9jqr7GMieYQjaw1vZ
	ZN1ZFLhuvlA300SbSIJEHBmN0awRH8R11fJ0P5kNSFrb+U6Tg9OUeCsCCZhVrc8eflaMMu
	TTKxqlBMJ04HTWohIP0JS2AeJO9f16xXa9aRtkCgjs9jNkxWuVWEeZQdBGfE8J92SUOluG
	tiKReDOe+q3sOH9WxfrmamJBBgv2qj6f5/9cAB6NdGEDGnIRkRPO5PXtM4xYeL/3zaGqz3
	XaEHF11XVoi0f0cBFyhjAMv0JlXzObNus0sid71OG1SIm+t92wDMr8T7agXDyA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1753439515;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5b+kPDm97piiuep4VNS2ofHXHSThNlVT16aHVVtHndw=;
	b=YyEkf72ebxsOmOn5y1glwjeYiR4H3sDKchRVI7dfuwJsfGKy2bTNGlIJKCO++qaMTwEvsS
	SMJmMPsVmuF3aEBQ==
From: "tip-bot2 for Daniel Lezcano" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: timers/clocksource] clocksource/drivers/tegra186: Add module owner
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>, Ingo Molnar <mingo@kernel.org>,
 Will McVicker <willmcvicker@google.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250602151853.1942521-5-daniel.lezcano@linaro.org>
References: <20250602151853.1942521-5-daniel.lezcano@linaro.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175343951381.1420.10751880185529449366.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the timers/clocksource branch of ti=
p:

Commit-ID:     6d92fe9b423c19e6ec6dcbf71528a4bbbb7bf814
Gitweb:        https://git.kernel.org/tip/6d92fe9b423c19e6ec6dcbf71528a4bbbb7=
bf814
Author:        Daniel Lezcano <daniel.lezcano@linaro.org>
AuthorDate:    Mon, 02 Jun 2025 17:18:48 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Fri, 25 Jul 2025 11:43:25 +02:00

clocksource/drivers/tegra186: Add module owner

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

