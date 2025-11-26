Return-Path: <linux-tip-commits+bounces-7543-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8ACC9C8A640
	for <lists+linux-tip-commits@lfdr.de>; Wed, 26 Nov 2025 15:41:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E27AA3A911C
	for <lists+linux-tip-commits@lfdr.de>; Wed, 26 Nov 2025 14:41:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBA5E305063;
	Wed, 26 Nov 2025 14:40:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="3BR729Jy";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="k9gqUxJz"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4776C303A05;
	Wed, 26 Nov 2025 14:40:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764168043; cv=none; b=As8nsKzIe4O3BStXHgLXPXv8fJEQbcrdtxQvGY/dRiTus/r3ETLwc0qufTHNFrKy0JuIUIVxb+cSL0g5g0b+Ur6SVueF3iPSeUokPQIsuU3Y+e6WETncKgF2M2ViZdqbJjO9WhH98aGNIhRi1EWfYSEBFRhISJSsb5nzMkfNtnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764168043; c=relaxed/simple;
	bh=iTnYc6aefY9yV6r5RXsefXeI0SlQUjM0AoCYzgnHa74=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=Wd6bDFsTtS4uFf5eRtcXUxjMjBvKIR9zur2PSaxle1luufSPylthqpWzFmP64q8xx9ctX7m/NgCsKlbmFoV7jWpMmNqusWuzRc/pBeZF6eN4sU0T1OTy8lbKPSghoRHQze3EU6lb0ni7qaGx4G8jUSMUjCN+As2D/zMQ3EucJHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=3BR729Jy; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=k9gqUxJz; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 26 Nov 2025 14:40:39 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1764168040;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qMCgo0GoaCEmZ1LG6tvlf3/ZQMs90yxkl4eVy0aUu60=;
	b=3BR729JyyYKDChl11XMNjgi1mTlFmT9ZkSlQtWSf6qlDg+1HfoB8XrsThHf8M8iDwwoHCK
	EWmWNBG2CsGRLJMSaVw06+Q4ytlACei7Np+xzDyFSYqSYAr6C5QAMLHZvq8FDZrl7bBJga
	uWe3SPerRIs20xaYYDAICcqmtAReXpDOYFskPpEP+5cpvNHt3LVBMsUVB1QU57P/pY903k
	Tkg9igv60ylMgIb7NbMu3FxIW91j0cfkBHQ1DS24XID/aEeT75OuZoTNDuCk+avZHitV/Z
	Bng6/1ywJIufNihJ7jp3LofnTA17V4puCIkCfBmF5/QOFpGU/VXbxLJUFEmJfA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1764168040;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qMCgo0GoaCEmZ1LG6tvlf3/ZQMs90yxkl4eVy0aUu60=;
	b=k9gqUxJzoRBOE4GsHugcjxtgC+tm0sTTKotao6ybuKcoxE0EL7SuOz3NbQ0clKn8AK4AWa
	NUtFS6CjQhZn9MDA==
From: "tip-bot2 for Johan Hovold" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: timers/clocksource] clocksource/drivers/nxp-stm: Prevent driver unbind
Cc: Johan Hovold <johan@kernel.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20251111153226.579-4-johan@kernel.org>
References: <20251111153226.579-4-johan@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176416803902.498.10056207388137203228.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the timers/clocksource branch of ti=
p:

Commit-ID:     6a2416892e8942f5e2bfe9b85c0164f410a53a2d
Gitweb:        https://git.kernel.org/tip/6a2416892e8942f5e2bfe9b85c0164f410a=
53a2d
Author:        Johan Hovold <johan@kernel.org>
AuthorDate:    Tue, 11 Nov 2025 16:32:26 +01:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Wed, 26 Nov 2025 11:25:03 +01:00

clocksource/drivers/nxp-stm: Prevent driver unbind

Clockevents cannot be deregistered so suppress the bind attributes to
prevent the driver from being unbound and releasing the underlying
resources after registration.

Even if the driver can currently only be built-in, also switch to
builtin_platform_driver() to prevent it from being unloaded should
modular builds ever be enabled.

Fixes: cec32ac75827 ("clocksource/drivers/nxp-timer: Add the System Timer Mod=
ule for the s32gx platforms")
Signed-off-by: Johan Hovold <johan@kernel.org>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Link: https://patch.msgid.link/20251111153226.579-4-johan@kernel.org
---
 drivers/clocksource/timer-nxp-stm.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/clocksource/timer-nxp-stm.c b/drivers/clocksource/timer-=
nxp-stm.c
index c320d76..1ab9072 100644
--- a/drivers/clocksource/timer-nxp-stm.c
+++ b/drivers/clocksource/timer-nxp-stm.c
@@ -487,9 +487,10 @@ static struct platform_driver nxp_stm_driver =3D {
 	.driver	=3D {
 		.name		=3D "nxp-stm",
 		.of_match_table	=3D nxp_stm_of_match,
+		.suppress_bind_attrs =3D true,
 	},
 };
-module_platform_driver(nxp_stm_driver);
+builtin_platform_driver(nxp_stm_driver);
=20
 MODULE_DESCRIPTION("NXP System Timer Module driver");
 MODULE_LICENSE("GPL");

