Return-Path: <linux-tip-commits+bounces-3443-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 28A9DA39837
	for <lists+linux-tip-commits@lfdr.de>; Tue, 18 Feb 2025 11:08:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 130461894322
	for <lists+linux-tip-commits@lfdr.de>; Tue, 18 Feb 2025 10:08:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 570CC23C380;
	Tue, 18 Feb 2025 10:06:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="PuExQgYG";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="eDFu91Y0"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 865C52397AA;
	Tue, 18 Feb 2025 10:06:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739873208; cv=none; b=h70jly9wRaI/H8jS+fyak89/QdqOtGERctAStVYrvDV4pcK8GtASL+da/zd7CGsovjKJav2zBd8pYL/0tkwKLI/aQDfW7jOHhjscSZ2e4/mcQe2avT2XK63WOMRP+Bo49+FCHZimcq3vrWf403v9uioDXkNZQOTnEeV6IMyVDC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739873208; c=relaxed/simple;
	bh=2d4/dCVWjmjWEA+/o3i/k8Lm4IWh2vMNNiOyTLuS5pA=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=u7PFV1zbIRAcHY8zcHU4ZxJ2Oy8T0xGRr24iZFgS+ks9g+BONcHal3b55KTFkCEq3NRw+he7DXLaNn0agBfIomvYWaNECCp11EQNBoc1/Mx6eR9XY/G2as/vhFDONyBHArcljl10udwCesCcFW7ukzmNDU89lPAAf6bDX1mRN5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=PuExQgYG; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=eDFu91Y0; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 18 Feb 2025 10:06:44 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1739873204;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=X7p1MDfs9oMHiwgF49mP9Pl1WThiibYB9uqzEtCOLVA=;
	b=PuExQgYGDe006+wnZxqCmlOBEka9GDip65966UhdHI656hytgVwlt8Hul86fETuq32E2Px
	cIfwWsJWiCRZrJ9IA8JWJxYymsRaryhy4pykWoY+5Qe/WuerPwB7VGESI0+p8rFgVNUzrm
	FEePTUdzZz0J+hh5EI84gw0kGkoqIvGo0Ss/aTLaSmX4wU6Dux8ALzKd7wzdyMiooi7KGX
	23dHVjZnxIs6+a2QFLEfLmTab6AFrOl/HyUvimd6ZqigcxqgkZCadrAEoO0L0D77yE/j1C
	8Xo4MUbjjDqCOEBpGUmzy0Gt7kbYq/d1pZHfNh3Nt9LMZ4W2jd3rl7DVrsUhGg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1739873204;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=X7p1MDfs9oMHiwgF49mP9Pl1WThiibYB9uqzEtCOLVA=;
	b=eDFu91Y0G57iyRVi19yQiBLgd4UpCUOrklL9lHFb8ezyxEsylNznuufuuTvTTm55t0QHoq
	EHHfLcWWg2YxwLBg==
From: "tip-bot2 for Nam Cao" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/cleanups] net: fec: Switch to use hrtimer_setup()
Cc: Nam Cao <namcao@linutronix.de>, Thomas Gleixner <tglx@linutronix.de>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: =?utf-8?q?=3Cc68759ce7879a41d33d1d435c721f156cb1683c2=2E17387?=
 =?utf-8?q?46872=2Egit=2Enamcao=40linutronix=2Ede=3E?=
References: =?utf-8?q?=3Cc68759ce7879a41d33d1d435c721f156cb1683c2=2E173874?=
 =?utf-8?q?6872=2Egit=2Enamcao=40linutronix=2Ede=3E?=
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173987320419.10177.2662640879197829332.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/cleanups branch of tip:

Commit-ID:     e193660f5e7feabc461142a96c3237d7618dfeb3
Gitweb:        https://git.kernel.org/tip/e193660f5e7feabc461142a96c3237d7618dfeb3
Author:        Nam Cao <namcao@linutronix.de>
AuthorDate:    Wed, 05 Feb 2025 11:43:37 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 18 Feb 2025 10:35:46 +01:00

net: fec: Switch to use hrtimer_setup()

hrtimer_setup() takes the callback function pointer as argument and
initializes the timer completely.

Replace hrtimer_init() and the open coded initialization of
hrtimer::function with the new setup mechanism.

Patch was created by using Coccinelle.

Signed-off-by: Nam Cao <namcao@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/all/c68759ce7879a41d33d1d435c721f156cb1683c2.1738746872.git.namcao@linutronix.de

---
 drivers/net/ethernet/freescale/fec_ptp.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/freescale/fec_ptp.c b/drivers/net/ethernet/freescale/fec_ptp.c
index 7f6b574..fe4e7f9 100644
--- a/drivers/net/ethernet/freescale/fec_ptp.c
+++ b/drivers/net/ethernet/freescale/fec_ptp.c
@@ -739,8 +739,8 @@ void fec_ptp_init(struct platform_device *pdev, int irq_idx)
 
 	INIT_DELAYED_WORK(&fep->time_keep, fec_time_keep);
 
-	hrtimer_init(&fep->perout_timer, CLOCK_REALTIME, HRTIMER_MODE_REL);
-	fep->perout_timer.function = fec_ptp_pps_perout_handler;
+	hrtimer_setup(&fep->perout_timer, fec_ptp_pps_perout_handler, CLOCK_REALTIME,
+		      HRTIMER_MODE_REL);
 
 	irq = platform_get_irq_byname_optional(pdev, "pps");
 	if (irq < 0)

