Return-Path: <linux-tip-commits+bounces-3485-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 39066A39901
	for <lists+linux-tip-commits@lfdr.de>; Tue, 18 Feb 2025 11:34:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AA9F8177904
	for <lists+linux-tip-commits@lfdr.de>; Tue, 18 Feb 2025 10:30:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 613B52475CA;
	Tue, 18 Feb 2025 10:26:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="kO13d4Vb";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Z4Z3pJQp"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EB702451E0;
	Tue, 18 Feb 2025 10:26:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739874401; cv=none; b=AlMcNfERTybNlg9e2EOPGV3RpEKWxA7VKTFowfwX1g8Z2ipBalvKvLbbds868sxt1icicHfNLhXkZnGyjSjQcaRZc5uD/cRNEyrWqkDO1c/pcFuzxsVjUBE3Avm5N6Q94yn9FvK2f2hF/ewH7tbnPDSY8IIv3lIJmg8B7VjXjkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739874401; c=relaxed/simple;
	bh=EHv9BpqOb0BabrwdLGHkWijDLnYxrWIJoaO6OEaJBWk=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=TIewArIQ8jub0QxJ+BQvFNF7BhEp7rXmxE/ulAAXCNRt+7sW6x5ACKSzIGfft9eDVvH35BvhVjeNzihB0Ror0U24tpN6QNFp6ZFrROo9BGb+j8PZeh6xrJ4SzI9r1LQZM8BMXg/HP3EQtTLqEVES6KLviQLE5R0MiNiq5LIDPsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=kO13d4Vb; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Z4Z3pJQp; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 18 Feb 2025 10:26:37 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1739874398;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mVC3qdTmiurhBXgx6LJG65FNWSChX3liGrLQJRDlSPg=;
	b=kO13d4VbPsPSrg/OmAmSt35jHbN+u5YEGDH3psKC4knEyNgNxF3gJhjzUneCqakXaQpzqr
	/ItBU+8sprV0dZ+iZQMduYbHCP3cDUxOQlv+db1otNcRqSBEBDgwhHzmlIUUttyVUXyCGW
	oxuU1AYsOduSDev9Qt3XnHho6VUzyCTB1zocmSkvtpm55CNENIIln2pKhaSW2QZ/yrNePL
	5iIVhrGTUstqNOBPDx2saqNs1MmoVFj4ltGwlGT8q4EojiVgNJy0172e584IBYjkiOLSIY
	X/OfCQtNScX6j220ql4KOJI9UzGMzaQMi/vCchYvnfnbUaaSB4j3WBFjKFVaFA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1739874398;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mVC3qdTmiurhBXgx6LJG65FNWSChX3liGrLQJRDlSPg=;
	b=Z4Z3pJQpmf4VcFFYTdrVmn6wYV6DZ/2TWlDrtIV1twVjZ/GLgjHNvcWiki6m5vxqb70UuH
	mR5fVRUk9d4jmgDA==
From: "tip-bot2 for Nam Cao" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/cleanups] power: supply: ab8500_chargalg: Switch to use
 hrtimer_setup()
Cc: Nam Cao <namcao@linutronix.de>, Thomas Gleixner <tglx@linutronix.de>,
 Linus Walleij <linus.walleij@linaro.org>,
 Zack Rusin <zack.rusin@broadcom.com>,
 Sebastian Reichel <sebastian.reichel@collabora.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: =?utf-8?q?=3Cfa0bf7376ce8f124c8285a52d9f55d0ab4c42988=2E17387?=
 =?utf-8?q?46904=2Egit=2Enamcao=40linutronix=2Ede=3E?=
References: =?utf-8?q?=3Cfa0bf7376ce8f124c8285a52d9f55d0ab4c42988=2E173874?=
 =?utf-8?q?6904=2Egit=2Enamcao=40linutronix=2Ede=3E?=
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173987439756.10177.15267627556974204958.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/cleanups branch of tip:

Commit-ID:     1b73fd14cfb47710e99f2119ec19c770e5881928
Gitweb:        https://git.kernel.org/tip/1b73fd14cfb47710e99f2119ec19c770e5881928
Author:        Nam Cao <namcao@linutronix.de>
AuthorDate:    Wed, 05 Feb 2025 11:46:05 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 18 Feb 2025 11:19:04 +01:00

power: supply: ab8500_chargalg: Switch to use hrtimer_setup()

hrtimer_setup() takes the callback function pointer as argument and
initializes the timer completely.

Replace hrtimer_init() and the open coded initialization of
hrtimer::function with the new setup mechanism.

Patch was created by using Coccinelle.

Signed-off-by: Nam Cao <namcao@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
Acked-by: Zack Rusin <zack.rusin@broadcom.com>
Acked-by: Sebastian Reichel <sebastian.reichel@collabora.com>
Link: https://lore.kernel.org/all/fa0bf7376ce8f124c8285a52d9f55d0ab4c42988.1738746904.git.namcao@linutronix.de

---
 drivers/power/supply/ab8500_chargalg.c |  9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/power/supply/ab8500_chargalg.c b/drivers/power/supply/ab8500_chargalg.c
index 7a8d1fe..dc6c8b0 100644
--- a/drivers/power/supply/ab8500_chargalg.c
+++ b/drivers/power/supply/ab8500_chargalg.c
@@ -1787,13 +1787,12 @@ static int ab8500_chargalg_probe(struct platform_device *pdev)
 	psy_cfg.drv_data = di;
 
 	/* Initilialize safety timer */
-	hrtimer_init(&di->safety_timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
-	di->safety_timer.function = ab8500_chargalg_safety_timer_expired;
+	hrtimer_setup(&di->safety_timer, ab8500_chargalg_safety_timer_expired, CLOCK_MONOTONIC,
+		      HRTIMER_MODE_REL);
 
 	/* Initilialize maintenance timer */
-	hrtimer_init(&di->maintenance_timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
-	di->maintenance_timer.function =
-		ab8500_chargalg_maintenance_timer_expired;
+	hrtimer_setup(&di->maintenance_timer, ab8500_chargalg_maintenance_timer_expired,
+		      CLOCK_MONOTONIC, HRTIMER_MODE_REL);
 
 	/* Init work for chargalg */
 	INIT_DEFERRABLE_WORK(&di->chargalg_periodic_work,

