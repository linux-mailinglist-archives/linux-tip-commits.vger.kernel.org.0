Return-Path: <linux-tip-commits+bounces-3408-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C7A3A39761
	for <lists+linux-tip-commits@lfdr.de>; Tue, 18 Feb 2025 10:46:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 414CA18925FF
	for <lists+linux-tip-commits@lfdr.de>; Tue, 18 Feb 2025 09:46:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB415233132;
	Tue, 18 Feb 2025 09:46:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="JMiA23ue";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="DvJOAX6T"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CF7122B584;
	Tue, 18 Feb 2025 09:46:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739871991; cv=none; b=hYhCgrM/MlBX44D+VeZwVto76JNVr/TM3z5zkKpLvnkyrjrJoOkXB4MWp1IqXI9WLkdKsaX/HrKe4zl2VtgMm9siqYSIQPZVKKYCv4PY/3DMHjjpld3XgPCX90Ac9cBB2Ff4fObW9Gh0tUqykKJiWEi0yqCxa9ssSRKRjvoJMpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739871991; c=relaxed/simple;
	bh=/iE6xgyuDPiiVJZeVi8E86qGIv/EDudfFlcQHluQD+c=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=ZDVAGqpobP6r2g7Psclo0kLTLm1ak5Tm695eAHktENziteRFQwm8Vd/4BovS5Ea+jwlCSS1/F3nwXz4qbMAccH0ffasFP0dlX/BY6r83cgdtM1e8B+Uf4bjSOt+RC2HSqt9bHMTNJD92nOYgNq44/6yGLRSE4MZjyUTXaD+6qGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=JMiA23ue; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=DvJOAX6T; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 18 Feb 2025 09:46:27 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1739871987;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=f5BCh7QWJAU1cypNro6hgheza+PQacFS24Yhd6jtMi4=;
	b=JMiA23ue6+8IH4ySurGbgVuiG8GzPZy6AaFKK08K9/h3vhGx4aJUUdlxiOvWD8IH2gEZrH
	NQ3sTY69C/YexoXmRQ55e/vORQ5dWNDnK6X1z+26klzOTsNT6fbeMHPVjBi0wugO0xAcY6
	T08ZuNJjf5m7r9xIkrnnXbyhqYWjZ0ziTaIdeE9QGWlc8M9FP32GmXiGBv19L/IN5xFiWa
	16ziaux/iE9gu0knlYu/ivPuPOiCoTRtMS/b/ewO4P1nBjunJ8J4DAcdZUMMjkPNhKx1Ny
	G6fVNQxqY7Y5w/1TUaWDKHpdV1cBTEGZsaE3SBJEMA95vJW5VoeiidPdpMukwA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1739871987;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=f5BCh7QWJAU1cypNro6hgheza+PQacFS24Yhd6jtMi4=;
	b=DvJOAX6T7Hc7I5m7caUatk6O7tQLMlVZRnSJRTQFK0ccL/wOVWNJ5w2rWJqbIhT2xE2G23
	oXWvzqQy/D2OSoDg==
From: "tip-bot2 for Nam Cao" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/cleanups] PM / devfreq: rockchip-dfi: Switch to use
 hrtimer_setup()
Cc: Nam Cao <namcao@linutronix.de>, Thomas Gleixner <tglx@linutronix.de>,
 Chanwoo Choi <cw00.choi@samsung.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: =?utf-8?q?=3Cdfb35fb45eacdba7b8767052aa8c29ca157ac1b0=2E17387?=
 =?utf-8?q?46821=2Egit=2Enamcao=40linutronix=2Ede=3E?=
References: =?utf-8?q?=3Cdfb35fb45eacdba7b8767052aa8c29ca157ac1b0=2E173874?=
 =?utf-8?q?6821=2Egit=2Enamcao=40linutronix=2Ede=3E?=
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173987198723.10177.12595662327288867445.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/cleanups branch of tip:

Commit-ID:     4279d7054c871ed5e3d5de2b5948b24abba76c55
Gitweb:        https://git.kernel.org/tip/4279d7054c871ed5e3d5de2b5948b24abba76c55
Author:        Nam Cao <namcao@linutronix.de>
AuthorDate:    Wed, 05 Feb 2025 11:39:13 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 18 Feb 2025 10:32:34 +01:00

PM / devfreq: rockchip-dfi: Switch to use hrtimer_setup()

hrtimer_setup() takes the callback function pointer as argument and
initializes the timer completely.

Replace hrtimer_init() and the open coded initialization of
hrtimer::function with the new setup mechanism.

Patch was created by using Coccinelle.

Signed-off-by: Nam Cao <namcao@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Chanwoo Choi <cw00.choi@samsung.com>
Link: https://lore.kernel.org/all/dfb35fb45eacdba7b8767052aa8c29ca157ac1b0.1738746821.git.namcao@linutronix.de

---
 drivers/devfreq/event/rockchip-dfi.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/devfreq/event/rockchip-dfi.c b/drivers/devfreq/event/rockchip-dfi.c
index e2a1e44..0470d7c 100644
--- a/drivers/devfreq/event/rockchip-dfi.c
+++ b/drivers/devfreq/event/rockchip-dfi.c
@@ -642,8 +642,7 @@ static int rockchip_ddr_perf_init(struct rockchip_dfi *dfi)
 	if (ret)
 		return ret;
 
-	hrtimer_init(&dfi->timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
-	dfi->timer.function = rockchip_dfi_timer;
+	hrtimer_setup(&dfi->timer, rockchip_dfi_timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
 
 	switch (dfi->ddr_type) {
 	case ROCKCHIP_DDRTYPE_LPDDR2:

