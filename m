Return-Path: <linux-tip-commits+bounces-623-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 95E16869D76
	for <lists+linux-tip-commits@lfdr.de>; Tue, 27 Feb 2024 18:24:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BE9C21C22BF3
	for <lists+linux-tip-commits@lfdr.de>; Tue, 27 Feb 2024 17:24:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CDED14D456;
	Tue, 27 Feb 2024 17:22:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="sjZPwv+j";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ETpDwKwr"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1B2814AD2E;
	Tue, 27 Feb 2024 17:21:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709054521; cv=none; b=ZfalHVOaXSNlOTPOVX7svQkdfUNEALMPgawjz1UAZY7I7j8LCUUVapUSYNJMJ0KhlRPoeKgvOVp6khFKdSIyXB7jkvMLVDijfPw7Iyo43PJDUVQWVBZ+DEljTbx2LhTiXisvb0PPxYN004MUkUmf2hHr5rTLZ8/rUBbMnYkyI8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709054521; c=relaxed/simple;
	bh=R8g2H2I6plpx5pN/lj3b8Pe/c6VrII1cU21kCQQ1spo=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=FZT/1CzuvsN0BdGYXnxb4SdJNaMpUDwDr2KCRH/hL/dRorll/KPw0AAtRkASnRXDFJdevnaka/XBK2RDsDChS6+EM1r9vVv3nCLMgLDyp8LhC3XA+8WugIqB887eoXs99QfuUtPtOlTdAVrnQkXwsEbVIyXE/yhXqRZqHNdhz9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=sjZPwv+j; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ETpDwKwr; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 27 Feb 2024 17:21:57 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1709054517;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7dnpyg4THHby13IlGSuMEKZU58Q5gGYrPricbeVgsSs=;
	b=sjZPwv+jxr3JngkAFnU5otlOO3Q1UPADmdIkq4F1Wa8F2n0/oytk3qvK7CJqapL7AzECkl
	hSSN+9nECKFTSnrSNnAJjGCppLMOXxwL0noSPk+/aw87T9hGgNPE0PCB+l/r42KtaTzyks
	/MgyWpMBIh81ekb+CJSd4yZ51JMWt/aOhSVUAKVobrTrqDMYZb8PCtymS7DzdH5gHfu1H9
	uQiJPD6hBPPoEbycv5mutbxQCrBjNnyUk8u2BXKBthFJlEx26ux/ph+Qycvv6E/6xos9EO
	AvQ/y9JCDUT4OnexWUsIces5zJALKVrUQB04hmlAAoo9t0CTiPbRoYBLJy6V9Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1709054517;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7dnpyg4THHby13IlGSuMEKZU58Q5gGYrPricbeVgsSs=;
	b=ETpDwKwroD8WcJO+r8FoEJLqXqyXMuI7IDXTZlbWSBSXPJqBCFT5K6yluCWBFDe9e6y8YZ
	RPosSgDOrpQWAQCA==
From:
 tip-bot2 for Uwe =?utf-8?q?Kleine-K=C3=B6nig?= <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] irqchip/imgpdc: Convert to
 platform_driver::remove_new() callback
Cc: u.kleine-koenig@pengutronix.de, Thomas Gleixner <tglx@linutronix.de>,
 x86@kernel.org, linux-kernel@vger.kernel.org, maz@kernel.org
In-Reply-To: =?utf-8?q?=3C472fc6f6bcd54b73f8af206d079a80cb8744d0ca=2E17032?=
 =?utf-8?q?84359=2Egit=2Eu=2Ekleine-koenig=40pengutronix=2Ede=3E?=
References: =?utf-8?q?=3C472fc6f6bcd54b73f8af206d079a80cb8744d0ca=2E170328?=
 =?utf-8?q?4359=2Egit=2Eu=2Ekleine-koenig=40pengutronix=2Ede=3E?=
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <170905451714.398.2278907850835414879.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     b7357ec21df979b9f72bac61df195dd30eab3381
Gitweb:        https://git.kernel.org/tip/b7357ec21df979b9f72bac61df195dd30ea=
b3381
Author:        Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
AuthorDate:    Fri, 22 Dec 2023 23:50:32 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 27 Feb 2024 18:12:09 +01:00

irqchip/imgpdc: Convert to platform_driver::remove_new() callback

The .remove() callback for a platform driver returns an int which makes
many driver authors wrongly assume it's possible to do error handling by
returning an error code. However the value returned is ignored (apart
from emitting a warning) and this typically results in resource leaks.

To improve here there is a quest to make the remove callback return
void. In the first step of this quest all drivers are converted to
remove_new(), which already returns void. Eventually after all drivers
are converted, .remove_new() will be renamed to .remove().

Trivially convert this driver from always returning zero in the remove
callback to the void returning variant.

Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/472fc6f6bcd54b73f8af206d079a80cb8744d0ca.1703=
284359.git.u.kleine-koenig@pengutronix.de

---
 drivers/irqchip/irq-imgpdc.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/irqchip/irq-imgpdc.c b/drivers/irqchip/irq-imgpdc.c
index 5831be4..b42ed68 100644
--- a/drivers/irqchip/irq-imgpdc.c
+++ b/drivers/irqchip/irq-imgpdc.c
@@ -461,12 +461,11 @@ err_generic:
 	return ret;
 }
=20
-static int pdc_intc_remove(struct platform_device *pdev)
+static void pdc_intc_remove(struct platform_device *pdev)
 {
 	struct pdc_intc_priv *priv =3D platform_get_drvdata(pdev);
=20
 	irq_domain_remove(priv->domain);
-	return 0;
 }
=20
 static const struct of_device_id pdc_intc_match[] =3D {
@@ -479,8 +478,8 @@ static struct platform_driver pdc_intc_driver =3D {
 		.name		=3D "pdc-intc",
 		.of_match_table	=3D pdc_intc_match,
 	},
-	.probe =3D pdc_intc_probe,
-	.remove =3D pdc_intc_remove,
+	.probe		=3D pdc_intc_probe,
+	.remove_new	=3D pdc_intc_remove,
 };
=20
 static int __init pdc_intc_init(void)

