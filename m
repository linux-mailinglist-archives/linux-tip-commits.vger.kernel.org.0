Return-Path: <linux-tip-commits+bounces-6163-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 81ECAB0EB96
	for <lists+linux-tip-commits@lfdr.de>; Wed, 23 Jul 2025 09:17:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9BC7E3AF289
	for <lists+linux-tip-commits@lfdr.de>; Wed, 23 Jul 2025 07:16:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B222426CE2B;
	Wed, 23 Jul 2025 07:17:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="XqciCb++";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="j5LUVFiL"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2087A42065;
	Wed, 23 Jul 2025 07:17:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753255041; cv=none; b=pHn+1OAwEFiOoomRFBjrnFG8aCT0xmz2ZET76eMjbnE/Ocd0JJzf3RogZEett5VzXsdizDRL3Ixw1hgXNcibTRoVhTVrgdQ/7qBbjW0zTGRDIeLyG4FKNMwkFcEa8ILsFZTNNdheBXkTh2cDA07NOexXXVvIEM6WcT7sOLoDCRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753255041; c=relaxed/simple;
	bh=Tr3oKeWSBwZFJHskNx/fls6QjGTHZ1GTeAsPxO09/6M=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=nSiqdvwdckiXt8rdERCYnK5RMHy99SSYtgRpTCViN4C0jNAoYJtdlPVQ3MEy4Vef/4MWuGerdGTH1dgH7w3Ge7+6j+8eyt4eVWRI6+A9Ef3gBvb6BmhRRw0iG3xWH16LGfT0zH5+y3sNPVMY8crkazGYiFbMPVloda/2c6PyGpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=XqciCb++; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=j5LUVFiL; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 23 Jul 2025 07:17:16 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1753255038;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0kLzgBfFfXcoSqLu68PXLNAK8FJg/cPOSg53oHflmu8=;
	b=XqciCb+++eplu95PAMewUbctglYpvV2epi17GjX/KfasahIV/AMy7tTVtz+QETrzINf6DM
	XF/nWoW8pc6YIjRF3LoGV+wpZHBEXCmjb4huf6pBW2/klRNBCdjD/6VfbM2GfF9r2bVVut
	CANIXUGGDdxCrO6SYyyDKnY+AuVEdXG+i4kVbNpMWmXXWg21l7srhaXesJdR5zwjvrw4VM
	ADIMsYSZfgR1eunlVtZcYoe/Qb+p4v6ToW79SVn66ckL5IZkQobj+QaunPiPr/gB6WMB/m
	hjVSOxLGvtA5muxLc/ruksQiqdmXJ1TQXq+kTQrjwNLBkcuTXJny33bCZiWv+g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1753255038;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0kLzgBfFfXcoSqLu68PXLNAK8FJg/cPOSg53oHflmu8=;
	b=j5LUVFiLgvUNAoDSWLslB1loGBCoDgOOMrxyalPoIm4VgMtOvg7wSlghULU7tmlIvkm8HW
	9K5JddlfhdmxqgAA==
From: "tip-bot2 for Daniel Lezcano" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/clocksource] clocksource/drivers/exynos_mct: Fix section
 mismatch from the module conversion
Cc: Will McVicker <willmcvicker@google.com>,
 Daniel Lezcano <daniel.lezcano@linaro.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250715121834.2059191-1-daniel.lezcano@linaro.org>
References: <20250715121834.2059191-1-daniel.lezcano@linaro.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175325503679.1420.6193823593844622184.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the timers/clocksource branch of ti=
p:

Commit-ID:     7e477e9c4eb412cbcaeae3ed4fff22035dc943eb
Gitweb:        https://git.kernel.org/tip/7e477e9c4eb412cbcaeae3ed4fff22035dc=
943eb
Author:        Daniel Lezcano <daniel.lezcano@linaro.org>
AuthorDate:    Tue, 15 Jul 2025 14:18:33 +02:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Tue, 15 Jul 2025 19:46:23 +02:00

clocksource/drivers/exynos_mct: Fix section mismatch from the module conversi=
on

The function register_current_timer_delay() when compiling on ARM32
fails with a section mismatch. That is resulting from the module
conversion where the function exynos4_clocksource_init() is called
from mct_init_dt(). This one had its __init annotation removed to for
the module loading.

Fix this by adding the __init_or_module annotation for the functions:
 - mct_init_dt()
 - mct_init_spi()
 - mct_init_dt()

Compiled on ARM32 + MODULES=3Dno, ARM64 + MODULES=3Dyes, ARM64 +
MODULES=3Dno

Link: https://lore.kernel.org/r/20250715121834.2059191-1-daniel.lezcano@linar=
o.org
Reviewed-by: Will McVicker <willmcvicker@google.com>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/clocksource/exynos_mct.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/clocksource/exynos_mct.c b/drivers/clocksource/exynos_mc=
t.c
index 5075ebe..80d263e 100644
--- a/drivers/clocksource/exynos_mct.c
+++ b/drivers/clocksource/exynos_mct.c
@@ -657,7 +657,7 @@ out_irq:
 	return err;
 }
=20
-static int mct_init_dt(struct device_node *np, unsigned int int_type)
+static __init_or_module int mct_init_dt(struct device_node *np, unsigned int=
 int_type)
 {
 	bool frc_shared =3D of_property_read_bool(np, "samsung,frc-shared");
 	u32 local_idx[MCT_NR_LOCAL] =3D {0};
@@ -705,12 +705,12 @@ static int mct_init_dt(struct device_node *np, unsigned=
 int int_type)
 	return exynos4_clockevent_init();
 }
=20
-static int mct_init_spi(struct device_node *np)
+static __init_or_module int mct_init_spi(struct device_node *np)
 {
 	return mct_init_dt(np, MCT_INT_SPI);
 }
=20
-static int mct_init_ppi(struct device_node *np)
+static __init_or_module int mct_init_ppi(struct device_node *np)
 {
 	return mct_init_dt(np, MCT_INT_PPI);
 }

