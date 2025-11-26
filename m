Return-Path: <linux-tip-commits+bounces-7544-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 14E62C8A63A
	for <lists+linux-tip-commits@lfdr.de>; Wed, 26 Nov 2025 15:41:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 2CB33357F0A
	for <lists+linux-tip-commits@lfdr.de>; Wed, 26 Nov 2025 14:41:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE88D3054D9;
	Wed, 26 Nov 2025 14:40:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="tqj+9owe";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="TxHzPEN0"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1020D304BBD;
	Wed, 26 Nov 2025 14:40:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764168044; cv=none; b=gS313/UFs2Ee12QrfUgZc0QTpmi+zwoht34WnY/JW7zPO/a38iwQHcbKpzKaPtHDWhyGy1gdNrwNw4mdFqM0zRj59UrCNhUd/Ez+rSfmG2WARQ0Deisy6+oag/eA1S8gGBTkMIy3lWKGK8ramu+FfcFCZZFOah2xcdTdzN5JOmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764168044; c=relaxed/simple;
	bh=KEeiYz6/Yr519sBvoRL4kCvQqguypsUaNE1jgUXbWkc=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=C2zn5f4eqRlXO1aWf//jnKhGHGFdJkUYsuI30C1sDaDrixQqQauPSW/3GSXkvGmpaRwxp1BlCLUAGDguK/t+jV7UeIFKY4oZTo/UnFqkmfNX2V9TTOCmQ5tt5eAxTwdtp5MJWnn9LX8LWsDkMTnWFf+BwI3XWCL84MVnf9kpK1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=tqj+9owe; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=TxHzPEN0; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 26 Nov 2025 14:40:40 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1764168041;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GQo8i0/0pwk1cxw4C12fPxaWw0fG84LYb2C7y2DTjh8=;
	b=tqj+9oweBhSsyfZYa+8CPb3UGXEgw1tMbDxtpeJ9PKIxInZbvzEPmpVu/A4a75BzsGP4Gt
	5Hm/rS+ApWOnGv4H/kk/kBJHqSAKwMesFxjM/Q8oo8tP7gZ4e2mOcHY8jHw2rfKGsZfR7N
	jNlDhLPenp7/T/S678bi4Jg6ZlqCldoYyx2A9NIQ7Dqm8We/1zUGKFmm3ORHDyIDmm27Te
	S9HYlllpd1HYHeJqNEs+tBiNPWhcfuMnHKAy1wZPUuabA2SLzREwnOEEz6hKFw1FPVAI+Q
	gtV7BvZbBEUru1N/y28m/MHO2wuDM/LoLzjAf1AAyJxuEliKAnr9womVEsmCng==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1764168041;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GQo8i0/0pwk1cxw4C12fPxaWw0fG84LYb2C7y2DTjh8=;
	b=TxHzPEN0kbcc0BrFBCb+ItFoac9jk2XbAd4hq0jn0RtQ8yqnyF8PG5DRb0eMIzQQk+FtTV
	O03iS8MCaEs2mpAg==
From: "tip-bot2 for Johan Hovold" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: timers/clocksource] clocksource/drivers/nxp-pit: Prevent driver unbind
Cc: Johan Hovold <johan@kernel.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20251111153226.579-3-johan@kernel.org>
References: <20251111153226.579-3-johan@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176416804039.498.13926455840097713566.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the timers/clocksource branch of ti=
p:

Commit-ID:     e25f964cf414dafa6bee5c9c2c0b1d1fb041dc92
Gitweb:        https://git.kernel.org/tip/e25f964cf414dafa6bee5c9c2c0b1d1fb04=
1dc92
Author:        Johan Hovold <johan@kernel.org>
AuthorDate:    Tue, 11 Nov 2025 16:32:25 +01:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Wed, 26 Nov 2025 11:24:57 +01:00

clocksource/drivers/nxp-pit: Prevent driver unbind

The driver does not support unbinding (e.g. as clockevents cannot be
deregistered) so suppress the bind attributes to prevent the driver from
being unbound and rebound after registration (and disabling the timer
when reprobing fails).

Even if the driver can currently only be built-in, also switch to
builtin_platform_driver() to prevent it from being unloaded should
modular builds ever be enabled.

Fixes: bee33f22d7c3 ("clocksource/drivers/nxp-pit: Add NXP Automotive s32g2 /=
 s32g3 support")
Signed-off-by: Johan Hovold <johan@kernel.org>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Link: https://patch.msgid.link/20251111153226.579-3-johan@kernel.org
---
 drivers/clocksource/timer-nxp-pit.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/clocksource/timer-nxp-pit.c b/drivers/clocksource/timer-=
nxp-pit.c
index 2d0a355..d1740f1 100644
--- a/drivers/clocksource/timer-nxp-pit.c
+++ b/drivers/clocksource/timer-nxp-pit.c
@@ -374,9 +374,10 @@ static struct platform_driver nxp_pit_driver =3D {
 	.driver =3D {
 		.name =3D "nxp-pit",
 		.of_match_table =3D pit_timer_of_match,
+		.suppress_bind_attrs =3D true,
 	},
 	.probe =3D pit_timer_probe,
 };
-module_platform_driver(nxp_pit_driver);
+builtin_platform_driver(nxp_pit_driver);
=20
 TIMER_OF_DECLARE(vf610, "fsl,vf610-pit", pit_timer_init);

