Return-Path: <linux-tip-commits+bounces-3492-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F0F27A3990C
	for <lists+linux-tip-commits@lfdr.de>; Tue, 18 Feb 2025 11:35:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F0496166A28
	for <lists+linux-tip-commits@lfdr.de>; Tue, 18 Feb 2025 10:32:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 808A9263C6F;
	Tue, 18 Feb 2025 10:26:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="v3Eqe04z";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="40kwIzPZ"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C41802580D6;
	Tue, 18 Feb 2025 10:26:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739874405; cv=none; b=hHgM+iI3ZX37/PZX+S/vdffGm8PbszWBo4DcprrNNyhW7S3QPeKobzY8ijFv6nUIGR9o0HKpAkvZ2TLrsedqAS7qrogKBeVKPBiNDSfKnpsff+f4boJmGguuv0W0QDzXB9h2nA6siTIhb+m18Ge4mcmdvcBIYCCxlQndS1DxFzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739874405; c=relaxed/simple;
	bh=Yv171g8ktvdE99m0rFDY9lalX5LPYbBKhjYft+R9tQE=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=ItAnIdbV/MXmg69/iDmcxwR4mYeAZahHmdBpOn4xriYcfUXEGq9gYgqW6ahIhQ92qTYouCWnRBPSJkTr/jK5/K/Sw3nrTGbp/CeOFn5hF+B8DlZ8b2cazD9YuVQCj7CsdKnb9hLzzM0KKH4e9Yum2d+IyWCxiuatX+IDNijRwiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=v3Eqe04z; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=40kwIzPZ; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 18 Feb 2025 10:26:41 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1739874402;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pqHtTPUngK0lABvJMho4+8z4/SShq3cWEkQMAo6jG1Q=;
	b=v3Eqe04z74r2pNAPMFDOokdF/6Nsdqr1mgodUqLz1J8X6uMkEtvdMMB1J6m/5mlLcFbvVK
	oDJRmg8og95rMp8+2GEVhOQt6MuK9/PIEPMVVzX672pG4UeO1L9ky9X6SGCPPJWDjAKUNl
	0nbtXoQ0A93bRfOt26tcsbOMW4x11lgBRMH5gCOuH7kl1ahm4384rDf52r39vsiQNLoja2
	W/cnsviM0trS6zJQ2O6BFxzfS+MaZBivpCLO6LoxOzue1AmACoNcYddod5eY2iTgwsK/em
	CjRH89cLHOIZ+07ObrYJLNrsJ5FOnh5uV5gtcguHjz9q6L8yP+Fsli4gj+fykg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1739874402;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pqHtTPUngK0lABvJMho4+8z4/SShq3cWEkQMAo6jG1Q=;
	b=40kwIzPZhLzxK7yvboOlOssFYvdPOKRne4/TiNbnetlUaKEc8OzKumr6BssYmEyU7nnNyx
	Ke9vo8ChsP3IuODg==
From: "tip-bot2 for Nam Cao" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/cleanups] serial: imx: Switch to use hrtimer_setup()
Cc: Nam Cao <namcao@linutronix.de>, Thomas Gleixner <tglx@linutronix.de>,
 Zack Rusin <zack.rusin@broadcom.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: =?utf-8?q?=3Cad27070bc67c13f8a9acbd5cbf4cbae72797e3e1=2E17387?=
 =?utf-8?q?46904=2Egit=2Enamcao=40linutronix=2Ede=3E?=
References: =?utf-8?q?=3Cad27070bc67c13f8a9acbd5cbf4cbae72797e3e1=2E173874?=
 =?utf-8?q?6904=2Egit=2Enamcao=40linutronix=2Ede=3E?=
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173987440192.10177.5822486703163579137.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/cleanups branch of tip:

Commit-ID:     721c5bf65a1d19d2958a83c6eb7ddd8002b9026f
Gitweb:        https://git.kernel.org/tip/721c5bf65a1d19d2958a83c6eb7ddd8002b9026f
Author:        Nam Cao <namcao@linutronix.de>
AuthorDate:    Wed, 05 Feb 2025 11:45:58 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 18 Feb 2025 11:19:03 +01:00

serial: imx: Switch to use hrtimer_setup()

hrtimer_setup() takes the callback function pointer as argument and
initializes the timer completely.

Replace hrtimer_init() and the open coded initialization of
hrtimer::function with the new setup mechanism.

Patch was created by using Coccinelle.

Signed-off-by: Nam Cao <namcao@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Zack Rusin <zack.rusin@broadcom.com>
Link: https://lore.kernel.org/all/ad27070bc67c13f8a9acbd5cbf4cbae72797e3e1.1738746904.git.namcao@linutronix.de

---
 drivers/tty/serial/imx.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
index 9c59ec1..9a1afe4 100644
--- a/drivers/tty/serial/imx.c
+++ b/drivers/tty/serial/imx.c
@@ -2582,10 +2582,10 @@ static int imx_uart_probe(struct platform_device *pdev)
 		imx_uart_writel(sport, ucr3, UCR3);
 	}
 
-	hrtimer_init(&sport->trigger_start_tx, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
-	hrtimer_init(&sport->trigger_stop_tx, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
-	sport->trigger_start_tx.function = imx_trigger_start_tx;
-	sport->trigger_stop_tx.function = imx_trigger_stop_tx;
+	hrtimer_setup(&sport->trigger_start_tx, imx_trigger_start_tx, CLOCK_MONOTONIC,
+		      HRTIMER_MODE_REL);
+	hrtimer_setup(&sport->trigger_stop_tx, imx_trigger_stop_tx, CLOCK_MONOTONIC,
+		      HRTIMER_MODE_REL);
 
 	/*
 	 * Allocate the IRQ(s) i.MX1 has three interrupts whereas later

